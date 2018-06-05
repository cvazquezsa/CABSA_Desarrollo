SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/**************** spCxAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxAfectar') and type = 'P') drop procedure dbo.spCxAfectar
GO             
CREATE PROCEDURE spCxAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)  OUTPUT,
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	      	float,
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion    		datetime,
    		   @FechaConclusion	 	datetime,

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

		   @Beneficiario		int,
    		   @Condicion			varchar(50),
   		   @Vencimiento			datetime,
                   @FechaProntoPago		datetime,
                   @DescuentoProntoPago		float,
		   @FormaPago			varchar(50),
		   @Contacto			char(10),
		   @ContactoEnviarA		int,
		   @ContactoMoneda		char(10),
		   @ContactoFactor		float,
	    	   @ContactoTipoCambio		float,
    		   @Importe   			money,	 
		   @ValesCobrados		money,
    		   @Impuestos	        	money,
		   @Retencion			money,
		   @Retencion2			money,
		   @Retencion3			money,
		   @Comisiones			money,
		   @ComisionesIVA		money,
		   @Saldo			money,
		   @SaldoInteresesOrdinarios	money, 
		   @SaldoInteresesMoratorios	money, 
		   @CtaDinero			char(10),
		   @Cajero			char(10),
		   @Agente			char(10),
  		   @AplicaManual                bit,
		   @ConDesglose			bit,
	    	   @CobroDesglosado		money, 
		   @CobroDelEfectivo		money, 
		   @CobroCambio			money,
		   @ImpuestosPorcentaje		money,
                   @RetencionPorcentaje		money,
		   @Aforo			float,
		   @Tasa			varchar(50),

                   @CfgAplicaAutoOrden		char(20),

                   @AfectarCantidadPendiente  	bit,
                   @AfectarCantidadA   		bit,

		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,
                   
                   @CfgRetencionAlPago		bit,
                   @CfgRetencionMov		char(20),
    		   @CfgRetencionAcreedor	char(10),
    		   @CfgRetencionConcepto	varchar(50),
    		   @CfgRetencion2Acreedor	char(10),
    		   @CfgRetencion2Concepto	varchar(50),
    		   @CfgRetencion3Acreedor	char(10),
    		   @CfgRetencion3Concepto	varchar(50),
                   @CfgAgentAfectarGastos	bit,

                   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
                   @CfgEmbarcar			bit,
	           @AutoAjuste			money,
	           @AutoAjusteMov		money,
                   @CfgDescuentoRecargos	bit,
     	           @CfgFormaCobroDA		varchar(50),
		   --@CfgControlEfectivo	bit,
		   --@TopeEfectivoAuto		money,
		   --@CfgAplicaDif		bit,
                   @CfgMovCargoDiverso		char(20),
                   @CfgMovCreditoDiverso	char(20),
		   @CfgVentaComisionesCobradas	bit,
                   @CfgCobroImpuestos	 	bit,
                   @CfgComisionBase		char(20),
		   --@CfgComisionCreditoDiverso	bit,
		   @CfgComisionCreditos		bit,
		   @CfgVentaLimiteNivelSucursal bit,
		   @CfgSugerirProntoPago	bit, 
		   @CfgAC			bit,

		   @GenerarGasto		bit,
		   @GenerarPoliza		bit,

		   @IDOrigen			int,
	    	   @OrigenTipo			char(10),
		   @OrigenMovTipo		char(20),
		   @MovAplica			char(20),
		   @MovAplicaID			varchar(20),
		   @MovAplicaMovTipo		char(20),

		   @AgenteNomina		bit,
		   @AgentePersonal		char(10), 
    		   @AgenteNominaMov	 	char(20),
		   @AgenteNominaConcepto	varchar(50),

		   @IVAFiscal			float,
		   @IEPSFiscal			float,
		   @ProveedorAutoEndoso		varchar(10),

		   @RamaID			int,
		   @LineaCredito		varchar(20),
		   @TipoAmortizacion		varchar(20),
		   @TipoTasa			varchar(20),

                   @Generar                     bit,
                   @GenerarMov                  char(20) OUTPUT,
                   @GenerarSerie		char(20),
		   @GenerarAfectado		bit,
		   @GenerarCopia		bit,
		   @RedondeoMonetarios		int, 	

		   @IDGenerar			int	     OUTPUT,	
    		   @GenerarMovID	  	varchar(20)  OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT,

		   @INSTRUCCIONES_ESP		varchar(20) 	= NULL,
		   @Nota			varchar(100) 	= NULL,
                   @Base			varchar(20)	= NULL,
		   @Origen			varchar(20)	= NULL,
		   @OrigenID			varchar(20)	= NULL,
		   @SaldoInteresesOrdinariosIVA			float = NULL, --MEJORA10041
		   @SaldoInteresesMoratoriosIVA			float = NULL,  --MEJORA10041
		   @EstacionTrabajo				int = NULL -- REQ12336		   
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ImporteTotal	   	money,
    @NuevoPendiente        	float,
    @Porcentaje		   	float,
    @ImporteComision		money,
    @ImporteSinImpuestos   	money,
    @ContactoImporte       	money,
    @SaldoNuevo	           	money,
    @Dias		   	int,
    @MovAplicaSaldo	   	money,
    @MovAplicaEstatus	 	char(15),
    @MovAplicaContacto	 	char(10),
    @FechaCancelacion	 	datetime,
    @EsCargo		 	bit,
    @RamaAfectar	 	char(5),
    @MovAfectar			char(20),
    @GenerarEstatus	 	char(15),
    @GenerarMovTipo 	 	char(20),
    @GenerarSubMovTipo 	 	varchar(20), --MEJORASLC       
    @GenerarPolizaTemp	 	bit,
    @GenerarPeriodo 	 	int, 
    @GenerarEjercicio 	 	int,
    @DineroID			int,
    @DineroImporte	 	money,
    @DineroMov		 	char(20),
    @DineroMovID	 	varchar(20),
    @DineroTipo		 	char(20),
    @NominaID 		 	int,
    @NominaMov 		 	char(20),
    @NominaMovID	 	varchar(20),
    @TieneDescuentoRecargos	bit,
    @AplicaPosfechado	 	bit,
    @ImporteAplicado	 	money,
    @DA			 	bit, 
    @IDAplica		 	int,
    @GenerarAplicaManual 	bit,
    @CxModulo		 	char(5),
    @CxMov		 	char(20),
    @CxMovID		 	varchar(20),
    @AforoID			int,
    @AforoMov			char(20),
    @AforoMovID			varchar(20),
    @AforoImporte		money,
    @SaldoSinImpuestos		money,
    @Limite			money,
    @Excedente			money,
    @LimiteDesde		datetime,
    @LimiteHasta		datetime,
    @VentaNeta			money,
    @ImporteMN			money,
    @ImpuestosMN		money,
    @MonedaMN			char(10),
    @ImporteD			money,
    @DescuentoRecargos		money,
    @SumaAnticiposFacturados	money,
    @TasaDiaria			float,
    @ComisionesFinanciadas	bit,
    @DiaRevision		varchar(10),
    @FechaRevision		datetime,
    @Metodo			int,
    @ImpuestoAdicional		float,
    @LCCtaDinero		varchar(10),
    @LCCtaDineroImporte		money,
    @MovAplicaRetencionAlPago 	bit, 
    @MovAplicaRetencion		money,
    @MovAplicaRetencion2	money,
    @MovAplicaRetencion3	money,		-- ETO Tarjetas 9-Feb-2007
    @Importe1			money,
    @Importe2			money,
    @Importe3			money,
    @Importe4			money,
    @Importe5			money,
    @FormaCobro1		varchar(50),
    @FormaCobro2		varchar(50),
    @FormaCobro3		varchar(50),
    @FormaCobro4		varchar(50),
    @FormaCobro5		varchar(50),
    @TarjetasCobradas		money,	
    @FormaCobroTarjetas		varchar(50), 	-- ETO Tarjetas 9-Feb-2007
    @MovAplicaImporteTotal  	money,
    @MovAplicaTipoCambio 	float,
    @MovAplicaImporteNeto 	money,
    @MovAplicaFactor 		float, 
    @MovAplicaMoneda 		varchar(20),
    @SubFolio 			varchar(20),
    @SaldoTotal			money,
    @NomAuto			bit,
    @CompraID			int,
    @CompraImporte		money,
    @OrigenImporte		money,
    @ConsignacionFechaCorte		datetime, --MEJORASLC
    @SubMovTipo					varchar(20), --MEJORASLC
    @ContUso					varchar(20),
    @ContUso2					varchar(20),
    @ContUso3					varchar(20),
    @Rama						varchar(5), --MEJORA10015    
    @IDCancelaCXPCA				int, --BUG8660
    @LDI                        bit,--REQ 13386 
    @LDITarjeta                 bit,--REQ 13386 
    @LDIServicio                varchar(20),--REQ 13386 
    @CFDFlex                    bit,--REQ 13386 ,
    @LDIOkRef                   varchar(255),--REQ 13386 
    @LDIOk						int,--REQ 13386     
    --BUG15665
    @Referencia1				varchar(50),
    @Referencia2				varchar(50),
    @Referencia3				varchar(50),
    @Referencia4				varchar(50),
    @Referencia5				varchar(50),
    @ReferenciaTarjetas			varchar(50)
    
  SET @LDIOkRef = NULL  --REQ 13386  
  SET @LDIOk = NULL  --REQ 13386  
  SELECT @LDI  = ISNULL(InterfazLDI,0)--REQ 13386      
    FROM EmpresaGral 
   WHERE Empresa = @Empresa
   
  SELECT @CFDFlex = ISNULL(CFDFlex,0) FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo    
    
    
  SELECT @SubMovTipo = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov --MEJORASLC

--MEJORA10041
/*
  IF @Movtipo = 'CXC.INT' AND @SubMovTipo = 'CXC.INM' --MEJORA10015
    SET @Rama = 'CIM' --MEJORA10015
  ELSE IF @Movtipo = 'CXC.INT' AND @SubMovTipo <> 'CXC.INM' --MEJORA10015
    SET @Rama = 'CIO' --MEJORA10015
  ELSE IF @Movtipo = 'CXP.INT' AND @SubMovTipo = 'CXP.INM' --MEJORA10015
    SET @Rama = 'PIM' --MEJORA10015
  ELSE IF @Movtipo = 'CXP.INT' AND @SubMovTipo <> 'CXP.INM' --MEJORA10015
    SET @Rama = 'PIO' --MEJORA10015
  ELSE --MEJORA10015
    SET @Rama = @Modulo --MEJORA10015
*/
  -- Inicializar Variables
  SELECT @ContactoImporte   = 0.0,
         @SaldoNuevo        = 0.0,
         @EsCargo           = 0,
         @AplicaPosfechado  = 0,
         @ComisionesFinanciadas = 0,
         @NomAuto = 0

  --ARCC16012011
  EXEC spCxAfectar2 @ID OUTPUT, @Accion	OUTPUT, @Empresa OUTPUT, @Modulo	OUTPUT, @Mov OUTPUT, @MovID OUTPUT, @MovTipo OUTPUT,
					@MovMoneda OUTPUT, @MovTipoCambio OUTPUT, @FechaEmision OUTPUT, @FechaAfectacion OUTPUT, @Concepto OUTPUT, 
					@Usuario OUTPUT, @Estatus OUTPUT, @FechaRegistro OUTPUT, @Ejercicio OUTPUT, @Periodo OUTPUT, @Contacto OUTPUT,
					@ContactoEnviarA OUTPUT, @Importe OUTPUT, @Impuestos OUTPUT, @Retencion OUTPUT, @Retencion2 OUTPUT, @Retencion3	OUTPUT,
					@Comisiones	OUTPUT, @ComisionesIVA OUTPUT, @Saldo OUTPUT, @SaldoInteresesOrdinarios OUTPUT, @SaldoInteresesMoratorios OUTPUT, 
					@CtaDinero OUTPUT, @Cajero OUTPUT, @Conexion OUTPUT, @SincroFinal OUTPUT, @Sucursal OUTPUT, @SucursalDestino OUTPUT,
					@SucursalOrigen OUTPUT, @CfgCobroImpuestos OUTPUT, @CfgVentaLimiteNivelSucursal OUTPUT, @CfgSugerirProntoPago OUTPUT, 
					@CfgAC OUTPUT, @TipoAmortizacion OUTPUT, @Generar OUTPUT, @GenerarMov OUTPUT, @GenerarSerie OUTPUT, @RedondeoMonetarios OUTPUT, 	
					@IDGenerar OUTPUT, @GenerarMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @Base OUTPUT, @ComisionesFinanciadas OUTPUT, 
					@ImporteTotal OUTPUT, @Limite OUTPUT, @VentaNeta OUTPUT, @LimiteDesde OUTPUT, @LimiteHasta OUTPUT, @Excedente OUTPUT,
					@GenerarEstatus OUTPUT, @GenerarMovTipo OUTPUT, @GenerarSubMovTipo OUTPUT, @GenerarPolizaTemp OUTPUT, @GenerarPeriodo OUTPUT, 
					@GenerarEjercicio OUTPUT, @DescuentoRecargos OUTPUT, @ImpuestoAdicional OUTPUT, @Metodo OUTPUT, @ImporteD OUTPUT, @SaldoSinImpuestos OUTPUT,		   
					@TasaDiaria OUTPUT, @Dias OUTPUT, @SubMovTipo OUTPUT, @ConsignacionFechaCorte OUTPUT, @SaldoTotal OUTPUT,
					@Porcentaje OUTPUT, @ImporteSinImpuestos OUTPUT, @GenerarAplicaManual OUTPUT, @SaldoInteresesOrdinariosIVA OUTPUT, @SaldoInteresesMoratoriosIVA OUTPUT --MEJORA10041

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') RETURN

  IF @Generar = 1 AND @Ok IS NULL RETURN

  --ARCC16012011					

  IF @OK IS NOT NULL RETURN 

  IF @Conexion = 0 
    BEGIN TRANSACTION 

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    IF @Accion <> 'CANCELAR' AND @Ok IS NULL
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         @Concepto, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    -- Si el movimiento no debe de llevar impuestos borrar el campo
    IF @MovTipo NOT IN ('CXC.C', 'CXC.CD', 'CXC.D', 'CXC.DM', 'CXC.RA', 'CXC.A', 'CXC.AR', 'CXC.AA', 'CXC.DE', 'CXC.F', 'CXC.FA', 'CXC.DFA', 'CXC.AF','CXC.CA', 'CXC.CAD','CXC.CAP','CXC.VV','CXC.OV','CXC.IM','CXC.RM','CXC.NC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP', 
                        'CXP.A', 'CXP.AA', 'CXP.DE', 'CXP.F','CXP.AF','CXP.CA', 'CXP.CAD','CXP.CAP','CXP.NC','CXP.NCD','CXP.NCF','CXP.NCP', 
                        'AGENT.P','AGENT.CO', 'CXC.FAC', 'CXP.FAC') SELECT @Impuestos = 0.0

    -- Calcula el Importe Total
    SELECT @ImporteTotal = @Importe + @Impuestos - @Retencion - @Retencion2 - @Retencion3
    IF @ComisionesFinanciadas = 1 
      SELECT @ImporteTotal = @ImporteTotal + ISNULL(@Comisiones, 0.0) + ISNULL(@ComisionesIVA, 0.0)

    -- Hay movimientos que no tienen Aplicacion
    IF @Accion <> 'CANCELAR' AND @Ok IS NULL AND
       @MovTipo IN ('CXC.NCD', 'CXC.DV', 'CXC.A', 'CXC.AR', 'CXC.AA', /*'CXC.CA', 'CXC.CAD', 'CXC.CAP',*/ 'CXC.VV','CXC.OV', 'CXC.F', 'CXC.CD', 'CXC.DE', 'CXC.DI', 'CXC.AJE', 'CXC.AJR', 'CXC.FA', 'CXC.AF',
	                'CXP.NCD', 'CXP.A', 'CXP.AA', /*'CXP.CA', 'CXP.CAD', 'CXP.CAP', */'CXP.F', 'CXP.AF', 'CXP.CD', 'CXP.DE', 'CXP.AJE', 'CXP.AJR',
                    'CXC.SD', 'CXC.SCH', 'CXP.SD', 'CXP.SCH') OR
       (@MovTipo IN ('CXC.NC', 'CXC.NCD','CXC.NCF', 'CXP.NC', 'CXP.NCD','CXP.NCF') AND @AplicaManual = 0)
    BEGIN
      IF @Modulo = 'CXC' DELETE CxcD WHERE ID = @ID ELSE
      IF @Modulo = 'CXP' DELETE CxpD WHERE ID = @ID 
    END

    IF @MovTipo IN ('CXP.CD') AND @Accion IN ('CANCELAR') AND @OrigenTipo IN ('DIN') AND @Ok IS NULL --MEJORA6013
    BEGIN
      UPDATE Dinero SET ChequeDevuelto = 0 WHERE ID = @IDOrigen
      IF @@ERROR <> 0 SET @Ok = 1
    END
    
    IF @MovTipo IN ('CXC.F', 'CXC.CA', 'CXC.CAP', 'CXC.CAD', 'CXC.D', 'CXC.DM', 'CXP.F', 'CXP.CA', 'CXP.CAP', 'CXP.CAD', 'CXP.D', 'CXP.DM') AND @Condicion IS NOT NULL
    BEGIN
      IF @CfgAC = 1 OR EXISTS(SELECT * FROM Condicion WHERE Condicion = @Condicion AND DA = 1)
        EXEC spCxCancelarDocAuto @Empresa, @Usuario, @Modulo, @ID, @Mov, @MovID, 0, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT
    END

    -- Actualizar Sucursal Detalle
    IF @Accion = 'AFECTAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
    BEGIN
      IF (SELECT Sincro FROM Version) = 1
      BEGIN
        IF @Modulo = 'CXC'   EXEC sp_executesql N'UPDATE CxcD   SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID ELSE 
        IF @Modulo = 'CXP'   EXEC sp_executesql N'UPDATE CxpD   SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID ELSE
        IF @Modulo = 'AGENT' EXEC sp_executesql N'UPDATE AgentD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
      END
    END

    IF @MovTipo IN ('CXC.FAC', 'CXC.DAC', 'CXP.FAC', 'CXP.DAC') AND @Accion = 'AFECTAR'
    BEGIN
      IF @Modulo = 'CXC' SELECT @IVAFiscal = IVAFiscal, @IEPSFiscal = IEPSFiscal, @Condicion = '(Fecha)', @Vencimiento = Vencimiento FROM Cxc WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus = 'PENDIENTE' ELSE
      IF @Modulo = 'CXP' SELECT @IVAFiscal = IVAFiscal, @IEPSFiscal = IEPSFiscal, @Condicion = '(Fecha)', @Vencimiento = Vencimiento FROM Cxp WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus = 'PENDIENTE'
    END

    IF @MovTipo = 'CXP.PAG' AND @Accion = 'CANCELAR' AND @Ok IS NULL 
    BEGIN
      SELECT @AforoID = NULL
      SELECT @AforoID = DID, @AforoMov = DMov, @AforoMovID = DMovID
        FROM MovFlujo 
       WHERE Cancelado = 0 AND Empresa = @Empresa AND OModulo = @Modulo AND OID = @ID AND DModulo = @Modulo

      IF @AforoID IS NOT NULL
      BEGIN
        EXEC spCx @AforoID, @Modulo, @Accion, 'TODO', @FechaEmision, NULL, @Usuario, 1, 0, @AforoMov OUTPUT, @AforoMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @AforoID, @AforoMov, @AforoMovID, @Ok OUTPUT
      END
    END

    -- Disminuir Anticipos Facturados
    IF @MovTipo = 'CXC.DFA' AND (@Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') OR @EstatusNuevo = 'CANCELADO') 
    BEGIN
      IF @Accion = 'CANCELAR' SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0 
      IF @Accion = 'CANCELAR'
       UPDATE Cxc 
          SET AnticipoSaldo = ISNULL(AnticipoSaldo, 0) + vfa.Importe
         FROM Cxc c, CxcFacturaAnticipo vfa
        WHERE vfa.ID = @ID AND vfa.CxcID = c.ID
      ELSE BEGIN
        SELECT @SumaAnticiposFacturados = SUM(AnticipoAplicar) FROM Cxc WHERE AnticipoAplicaModulo = @Modulo AND AnticipoAplicaID = @ID
        IF @ImporteTotal <> @SumaAnticiposFacturados SELECT @Ok = 30405 ELSE
        IF EXISTS(SELECT * FROM Cxc WHERE AnticipoAplicaModulo = @Modulo AND AnticipoAplicaID = @ID AND (ISNULL(AnticipoAplicar, 0) < 0.0 OR ROUND(AnticipoAplicar, 0) > ROUND(AnticipoSaldo, 0))) SELECT @Ok = 30405 
        ELSE BEGIN
          INSERT CxcFacturaAnticipo (ID, CxcID, Importe)
          SELECT @ID, ID, AnticipoAplicar
            FROM Cxc
           WHERE AnticipoAplicaModulo = @Modulo AND AnticipoAplicaID = @ID

          UPDATE Cxc 
             SET AnticipoSaldo = ISNULL(AnticipoSaldo, 0) - ISNULL(AnticipoAplicar, 0),
                 AnticipoAplicar = NULL,
                 AnticipoAplicaModulo = NULL,
                 AnticipoAplicaID = NULL 
           WHERE AnticipoAplicaModulo = @Modulo AND AnticipoAplicaID = @ID  
        END
      END
      IF @Ok IS NULL
        EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'CANT', @ContactoMoneda, @ContactoTipoCambio, @Contacto, NULL, NULL, NULL,
                     @Modulo, @ID, @Mov, @MovID, @EsCargo, @ImporteTotal, NULL, NULL,
                     @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0,
	  	     @Ok OUTPUT, @OkRef OUTPUT
    END

    -- Con Aplicacion
    IF @Ok IS NULL
    BEGIN
      IF (@MovTipo IN ('CXC.AF', 'CXC.AA','CXC.C','CXC.AJM','CXC.AJA','CXC.NET','CXC.DC','CXC.D','CXC.DM', 'CXC.DA', 'CXC.DP','CXC.AE','CXC.ANC','CXC.ACA','CXP.ACA','CXC.IM','CXC.RM', 
                       'CXP.AF', 'CXP.AA','CXP.P','CXP.AJM','CXP.AJA','CXP.NET','CXP.D','CXP.DM', 'CXP.PAG','CXP.DA','CXP.DC','CXP.DP','CXP.AE','CXP.ANC', 
                       'AGENT.P','AGENT.CO')) OR 
         (@MovTipo IN ('CXC.NC','CXC.NCD','CXC.CA','CXC.CAD','CXC.CAP','CXC.NCF','CXC.DV','CXC.NCP', 
                       'CXP.NC','CXP.NCD','CXP.CA','CXP.CAD','CXP.CAP','CXP.NCF','CXP.NCP') AND @AplicaManual = 1) 
      BEGIN
        -- Aplicacion Automatica
        IF @AplicaManual = 0 AND @Modulo IN ('CXC', 'CXP') AND @Accion <> 'CANCELAR' AND @MovTipo NOT IN ('CXC.IM', 'CXC.RM')
        BEGIN
          -- Borrar Aplicaciones anteriores
          IF @Modulo = 'CXC' DELETE CxcD WHERE ID = @ID ELSE
          IF @Modulo = 'CXP' DELETE CxpD WHERE ID = @ID 
          IF @@ERROR <> 0 SELECT @Ok = 1

          IF @MovTipo NOT IN ('CXC.AF','CXC.AA','CXC.DC','CXP.AF','CXP.AA','CXP.DC') 
            -- Generar Aplicacion 
            EXEC spCxAutoAplicacion @Sucursal, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovMoneda, @MovTipoCambio, @Contacto, @ContactoMoneda, @ContactoFactor, @ContactoTipoCambio, @ImporteTotal,
                                    @Accion, @FechaEmision, @Referencia, @Condicion, @Vencimiento, @Proyecto, @Usuario, 
                                    @CfgAplicaAutoOrden, /*@TopeEfectivoAuto, */@CfgMovCargoDiverso, @CfgMovCreditoDiverso,
                                    @Ok OUTPUT, @OkRef OUTPUT
        END
        -- Aplicar el Detalle 
--arcc
--select 'entro', @MovAplica, @MovAplicaID        
        EXEC spCxAplicar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                         @Referencia, @Concepto, @Proyecto, @Condicion, @Vencimiento, @FechaEmision, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo,
                         @Contacto, @ContactoEnviarA, @ContactoMoneda, @ContactoFactor, @ContactoTipoCambio, @Agente, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, @ImporteTotal, 
		         @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @OrigenTipo, @OrigenMovTipo, @MovAplica, @MovAplicaID, @MovAplicaMovTipo,
                         @CfgContX, @CfgContXGenerar, @CfgEmbarcar, @AutoAjuste, @AutoAjusteMov, @CfgDescuentoRecargos, NULL, 
                         /*@CfgControlEfectivo, @TopeEfectivoAuto, @CfgAplicaDif, @CfgComisionCreditoDiverso,*/ @CfgComisionCreditos, @CfgMovCargoDiverso, @CfgMovCreditoDiverso, @CfgVentaComisionesCobradas, @CfgComisionBase,
                         @CfgRetencionAlPago, @CfgRetencionMov, @CfgRetencionAcreedor, @CfgRetencionConcepto, @CfgRetencion2Acreedor, @CfgRetencion2Concepto, @CfgRetencion3Acreedor, @CfgRetencion3Concepto, @CfgAC,
                         0, @TieneDescuentoRecargos OUTPUT, @AplicaPosfechado OUTPUT, @ImporteAplicado OUTPUT, 
			 @RedondeoMonetarios, @Ok OUTPUT, @OkRef OUTPUT

        IF @MovTipo IN ('AGENT.P','AGENT.CO')
        BEGIN
          SELECT @Impuestos = 0.0, @Retencion = 0.0, @Retencion2 = 0.0, @Retencion3 = 0.0
          SELECT @Importe = SUM(Importe) FROM AgentD WHERE ID = @ID
          SELECT @Impuestos = @Importe * (@ImpuestosPorcentaje / 100), 
                 @Retencion = @Importe * (@RetencionPorcentaje / 100)
          SELECT @ImporteTotal = @Importe + @Impuestos - @Retencion - @Retencion2 - @Retencion3 
        END
      END
      SELECT @ContactoImporte = @ImporteTotal / @ContactoFactor
    END

    IF @Modulo = 'CXP' AND @Accion = 'CANCELAR'
      IF EXISTS (SELECT * FROM Cxp c JOIN MovTipo mt ON mt.Modulo = 'CXP' AND c.Mov = mt.Mov AND mt.Clave = 'CXP.RE' JOIN CxpD d ON c.ID = d.ID 
      WHERE c.Estatus = 'CONCLUIDO' AND c.Empresa = @Empresa AND d.Aplica = @Mov AND d.AplicaID = @MovID)
         SELECT @Ok= 30411

    IF @Modulo = 'CXC' AND @Accion = 'CANCELAR' 
      IF EXISTS (SELECT * FROM Cxc c JOIN MovTipo mt ON mt.Modulo = 'CXC' AND c.Mov = mt.Mov AND mt.Clave = 'CXC.RE' JOIN CxcD d ON c.ID = d.ID 
      WHERE c.Estatus = 'CONCLUIDO' AND c.Empresa = @Empresa AND d.Aplica = @Mov AND d.AplicaID = @MovID)
        SELECT @Ok= 30411
        
    IF @OrigenTipo = 'AUTO/RE' AND @Accion IN ('AFECTAR', 'CANCELAR') AND @Ok IS NULL
      EXEC spCxAplicarReevaluacion @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @Contacto, @ContactoMoneda, @ContactoTipoCambio, @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo IN ('CXC.INT', 'CXP.INT') AND @Accion IN ('AFECTAR', 'CANCELAR') AND @Ok IS NULL
      EXEC spCxAplicarIntereses @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo IN ('CXC.DESCINFLACION', 'CXP.DESCINFLACION') AND @Accion IN ('AFECTAR', 'CANCELAR') AND @Ok IS NULL --MEJORA10041
      EXEC spCxAplicarIVADescuentoInflacion @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Ok OUTPUT, @OkRef OUTPUT --MEJORA10041

    IF (@MovTipo IN ('CXP.D') AND @SubMovTipo IN ('CXP.SLCCORTE')) AND ((@Accion IN ('AFECTAR') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR')) OR (@Accion IN ('CANCELAR')  AND @Estatus IN ('PENDIENTE'))) AND @Ok IS NULL --MEJORASLC
    BEGIN
      SELECT @ConsignacionFechaCorte = dbo.fnFechaSinHora(ConsignacionFechaCorte) FROM Cxp WHERE ID = @ID
      EXEC spCxpSLCCorte @@SPID, @Modulo, @IDOrigen, @ID, @Mov, @MovID, @ConsignacionFechaCorte, @Accion, @Estatus, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
    END

    IF @Ok IS NULL 
    BEGIN
      IF (@MovTipo IN ('CXC.A','CXC.AR','CXC.FAC','CXC.DAC','CXC.F','CXC.FA','CXC.AF','CXC.VV','CXC.IM','CXC.RM','CXC.CD','CXC.D','CXC.DM','CXC.DA','CXC.DP', --MEJORA10015 --MEJORA10041
                       'CXP.A','CXP.F','CXP.AF','CXP.CD','CXP.D','CXP.DM', 'CXP.PAG','CXP.DA','CXP.DP', --MEJORA10015 --MEJORA10041
                       'CXP.FAC', 'CXP.DAC',
                       'CXC.SD', 'CXC.SCH', 'CXP.SD', 'CXP.SCH',
                       'AGENT.C', 'AGENT.D', 'AGENT.A')) OR
         (@MovTipo IN ('CXC.NC','CXC.NCD','CXC.NCF','CXC.CA','CXC.CAD','CXC.CAP','CXC.NCP', 'CXC.DV',
                       'CXP.NC','CXP.NCD','CXP.NCF','CXP.CA','CXP.CAD','CXP.CAP','CXP.NCP') AND @AplicaManual = 0) 
      BEGIN
        SELECT @EsCargo = 1
        IF @MovTipo IN ('CXC.DAC', 'CXC.A','CXC.AR','CXC.DA', 'CXC.ACA', 'CXP.ACA', 'CXP.A','CXP.DA','CXC.NC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP', 
                        'CXP.DAC', 'CXP.NC','CXP.NCD','CXP.NCF','CXP.NCP', 'AGENT.D', 'AGENT.A', 'CXC.SCH', 'CXP.SD') 
          SELECT @EsCargo = 0

        IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo

        SELECT @SaldoNuevo = @ContactoImporte
        EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @ContactoMoneda, @ContactoTipoCambio, @Contacto, NULL, NULL, NULL, --MEJORA10015 --MEJORA10041
                     @Modulo, @ID, @Mov, @MovID, @EsCargo, @SaldoNuevo, NULL, NULL,
                     @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0,
  		     @Ok OUTPUT, @OkRef OUTPUT

        IF @MovTipo = 'CXC.FA' AND @Ok IS NULL
        BEGIN
          IF @Accion <> 'CANCELAR' 
            UPDATE Cxc SET AnticipoSaldo = @SaldoNuevo, AnticipoAplicar = NULL, AnticipoAplicaModulo = NULL, AnticipoAplicaID = NULL WHERE ID = @ID
          ELSE 
            Update Cxc
               SET AnticipoAplicaModulo = NULL,
                   AnticipoAplicaID = NULL,
                   AnticipoAplicar= NULL
             WHERE ID = @ID                

          EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'CANT', @ContactoMoneda, @ContactoTipoCambio, @Contacto, NULL, NULL, NULL,
                       @Modulo, @ID, @Mov, @MovID, @EsCargo, @SaldoNuevo, NULL, NULL,
                       @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0,
  	  	       @Ok OUTPUT, @OkRef OUTPUT
        END
        IF @Accion = 'CANCELAR' SELECT @SaldoNuevo = 0.0
      END ELSE
      IF @MovTipo IN ('CXC.AE', 'CXC.DE', 'CXC.AJE', 'CXC.AJR', 'CXP.AE', 'CXP.DE', 'CXP.AJE', 'CXP.AJR') 
      BEGIN
        IF @Accion = 'CANCELAR' SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1

	IF @Modulo = 'CXC'
        BEGIN 
          IF @MovTipo = 'CXC.AJR'
            SELECT @RamaAfectar = 'CRND', @MovAfectar = 'Redondeo'
          ELSE
            SELECT @RamaAfectar = 'CEFE', @MovAfectar = 'Saldo a Favor'
        END ELSE
	IF @Modulo = 'CXP' 
        BEGIN
          IF @MovTipo = 'CXP.AJR'
            SELECT @RamaAfectar = 'PRND', @MovAfectar = 'Redondeo'
          ELSE
            SELECT @RamaAfectar = 'PEFE', @MovAfectar = 'Saldo a Favor'
        END

        EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @RamaAfectar, @MovMoneda, @MovTipoCambio, @Contacto, NULL, NULL, NULL,
                     @Modulo, @ID, @Mov, @MovID, @EsCargo, @ImporteTotal, NULL, NULL,
                     @FechaAfectacion, @Ejercicio, @Periodo, @MovAfectar, NULL, 0, 0, 0,
 		     @Ok OUTPUT, @OkRef OUTPUT
      END 


      IF @MovTipo IN ('CXC.ANC', 'CXC.ACA', 'CXP.ACA', 'CXC.RA', 'CXC.FAC', 'CXC.DAC', 'CXP.ANC', 'CXP.RA', 'CXP.FAC', 'CXP.DAC')
      BEGIN
        IF @Modulo = 'CXC' 
          SELECT @IDAplica = ID, @MovAplicaContacto = Cliente,   @MovAplicaSaldo = ISNULL(Saldo, 0.0), @MovAplicaEstatus = Estatus, @MovAplicaRetencion = ISNULL(Retencion, 0), @MovAplicaRetencion2 = ISNULL(Retencion2,0.0), @MovAplicaRetencion3 = ISNULL(Retencion3,0.0), @MovAplicaImporteTotal  = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0), @MovAplicaTipoCambio = TipoCambio, @MovAplicaMoneda = Moneda --MEJORA4648
            FROM Cxc 
           WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') 
        ELSE
        IF @Modulo = 'CXP' 
           SELECT @IDAplica = ID, @MovAplicaContacto = Proveedor, @MovAplicaSaldo = ISNULL(Saldo, 0.0), @MovAplicaEstatus = Estatus, @MovAplicaRetencionAlPago = RetencionAlPago, @MovAplicaRetencion = ISNULL(Retencion, 0), @MovAplicaRetencion2 = ISNULL(Retencion2, 0), @MovAplicaRetencion3 = ISNULL(Retencion3, 0), @MovAplicaImporteTotal  = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0), @MovAplicaTipoCambio = TipoCambio, @MovAplicaMoneda = Moneda
             FROM Cxp 
            WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
        IF @@ERROR <> 0 SELECT @Ok = 1

        SELECT @MovAplicaImporteNeto = ISNULL(@MovAplicaImporteTotal,0.0) - ISNULL(@MovAplicaRetencion,0.0) - ISNULL(@MovAplicaRetencion2,0.0) - ISNULL(@MovAplicaRetencion3,0.0) 
        SELECT @MovAplicaFactor = (@ImporteTotal * @MovTipoCambio) / NULLIF(CONVERT(float, @MovAplicaImporteNeto * @MovAplicaTipoCambio), 0)

        IF @MovMoneda <> @MovAplicaMoneda 
          SELECT @MovAplicaFactor = @MovAplicaFactor / @MovTipoCambio * @MovAplicaTipoCambio

        IF @MovAplicaMovTipo IN ('CXC.NCP','CXP.NCP') SELECT @AplicaPosfechado = 1

        IF @MovTipo IN ('CXC.FAC', 'CXP.FAC', 'CXC.ACA', 'CXP.ACA') SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1
        IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo
        EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @ContactoMoneda, @ContactoTipoCambio, @MovAplicaContacto, NULL, NULL, NULL,
                     @Modulo, @ID, @Mov, @MovID, @EsCargo, @ContactoImporte, NULL, NULL,
                     @FechaAfectacion, @Ejercicio, @Periodo, @MovAplica, @MovAplicaID, 0, 0, 0,
  		     @Ok OUTPUT, @OkRef OUTPUT

        IF @Accion = 'CANCELAR'
          SELECT @MovAplicaSaldo = @MovAplicaSaldo + @ContactoImporte 
        ELSE 
          SELECT @MovAplicaSaldo = @MovAplicaSaldo - @ContactoImporte 

        SELECT @MovAplicaSaldo = NULLIF(@MovAplicaSaldo, 0.0)
        IF @MovAplicaSaldo IS NULL SELECT @MovAplicaEstatus = 'CONCLUIDO' ELSE SELECT @MovAplicaEstatus = 'PENDIENTE'
        IF @MovAplicaEstatus = 'CONCLUIDO' SELECT @FechaConclusion = @FechaEmision ELSE IF @MovAplicaEstatus <> 'CANCELADO' SELECT @FechaConclusion  = NULL

        EXEC spValidarTareas @Empresa, @Modulo, @IDAplica, @MovAplicaEstatus, @Ok OUTPUT, @OkRef OUTPUT
        IF @Modulo = 'CXC' UPDATE Cxc SET Saldo = @MovAplicaSaldo, UltimoCambio = @FechaEmision, FechaConclusion = @FechaConclusion, Estatus = @MovAplicaEstatus WHERE ID = @IDAplica ELSE
        IF @Modulo = 'CXP' UPDATE Cxp SET Saldo = @MovAplicaSaldo, UltimoCambio = @FechaEmision, FechaConclusion = @FechaConclusion, Estatus = @MovAplicaEstatus WHERE ID = @IDAplica
        IF @@ERROR <> 0 SELECT @Ok = 1

        IF @MovTipo IN ('CXC.FAC', 'CXP.FAC', 'CXC.RA', 'CXP.RA', 'CXC.DAC', 'CXP.DAC')  AND @Accion <> 'CANCELAR' --Bug 18956
          INSERT MovImpuesto (
                 Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,		OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,                  Importe2,                  Importe3,                  SubTotal,                  ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
          SELECT @Modulo, @ID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1*@MovAplicaFactor, Importe2*@MovAplicaFactor, Importe3*@MovAplicaFactor, SubTotal*@MovAplicaFactor, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
            FROM MovImpuesto
           WHERE Modulo = @Modulo AND ModuloID = @IDAplica

        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @IDAplica, @MovAplica, @MovAplicaID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
      END
    END

    IF @Ok IS NULL OR (@Ok BETWEEN 80030 AND 81000) --BUG8660
    BEGIN
      -- Calcular Fecha Vencimiento
      IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion <> 'CANCELAR' 
      BEGIN
        IF @MovTipo IN ('CXC.F','CXC.AF','CXC.FAC','CXC.DAC','CXC.FA','CXC.CA','CXC.CAD','CXC.CAP','CXC.VV','CXC.CD','CXC.D','CXC.DM','CXC.DA','CXC.DP','CXC.NCP',
                        'CXP.F','CXP.AF','CXP.FAC','CXP.DAC','CXP.CA','CXP.CAD','CXP.CAP','CXP.CD','CXP.D','CXP.DM', 'CXP.PAG','CXP.DA','CXP.DP','CXP.NCP', 'CXP.P')
          EXEC spCalcularVencimientoPP @Modulo, @Empresa, @Contacto, @Condicion, @FechaEmision, @Vencimiento OUTPUT, @Dias OUTPUT, @FechaProntoPago OUTPUT, @DescuentoProntoPago OUTPUT, @Tasa OUTPUT, @Ok OUTPUT
        ELSE BEGIN
          SELECT @Condicion = NULL, @Vencimiento = @FechaEmision
          EXEC spExtraerFecha @Vencimiento OUTPUT
        END
      END

      IF @MovTipo IN ('CXC.A', 'CXC.AR', 'CXC.AA', 'CXC.AF', 'CXP.A', 'CXP.AA', 'CXP.AF') 
          EXEC spGenerarAP @Sucursal, @Accion, @Empresa, @Modulo, @ID, @MovTipo, @FechaRegistro,
          		   @Mov, @MovID, @MovMoneda, @MovTipoCambio, @Proyecto, @Contacto, @Referencia, NULL, @FechaEmision, @ImporteTotal,
  	 	           @Ok OUTPUT, @OkRef OUTPUT

--      IF @MovTipo IN ('CXC.NC', 'CXC.NCD','CXC.NCF', 'CXC.DV','CXP.NC','CXP.NCD','CXP.NCF') SELECT @Vencimiento = NULL
  
      IF @EstatusNuevo <> 'PENDIENTE' AND @SaldoNuevo > 0.0 SELECT @EstatusNuevo = 'PENDIENTE'
      IF @EstatusNuevo = 'PENDIENTE'  AND @SaldoNuevo = 0.0 AND @RamaID IS NULL SELECT @EstatusNuevo = 'CONCLUIDO'	/** JH 06.03.2007 **/ -- Es es para que en las amortizaciones donde no se paga capital queden pendientes

      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
      BEGIN
	IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
      END  

      IF @SaldoNuevo = 0.0 SELECT @SaldoNuevo = NULL
      IF @Modulo IN ('CXC', 'CXP')
      BEGIN
        IF NULLIF(@IVAFiscal, 0) IS NULL
        BEGIN
          IF NULLIF(@Impuestos, 0) IS NULL
          BEGIN
            --IF @Modulo = 'CXC' SELECT @IVAFiscal = SUM(d.Importe*a.IVAFiscal)/SUM(d.Importe) FROM CxcD d, CxcAplica a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.id = @ID ELSE
            --IF @Modulo = 'CXP' SELECT @IVAFiscal = SUM(d.Importe*a.IVAFiscal)/SUM(d.Importe) FROM CxpD d, CxpAplica a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.id = @ID 
	    IF @Modulo = 'CXC' SELECT @IVAFiscal = SUM(d.Importe*a.IVAFiscal)/NULLIF(SUM(d.Importe), 0.0) FROM CxcD d, Cxc a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.id = @ID AND UPPER(Estatus) NOT IN ('SINAFECTAR', 'CANCELADO') ELSE
            IF @Modulo = 'CXP' SELECT @IVAFiscal = SUM(d.Importe*a.IVAFiscal)/NULLIF(SUM(d.Importe), 0.0) FROM CxpD d, Cxp a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.id = @ID AND UPPER(Estatus) NOT IN ('SINAFECTAR', 'CANCELADO')
          END

          --BUG25239
          IF NULLIF(@IVAFiscal, 0) IS NULL AND NULLIF(@IEPSFiscal, 0) IS NULL
            SELECT @IVAFiscal = CONVERT(float, NULLIF(@Impuestos, 0)) / NULLIF(@ImporteTotal, 0)
        END
        IF NULLIF(@IEPSFiscal, 0) IS NULL
        BEGIN
          IF @Modulo = 'CXC' SELECT @IEPSFiscal = SUM(d.Importe*a.IEPSFiscal)/SUM(d.Importe) FROM CxcD d, CxcAplica a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.id = @ID ELSE
          IF @Modulo = 'CXP' SELECT @IEPSFiscal = SUM(d.Importe*a.IEPSFiscal)/SUM(d.Importe) FROM CxpD d, CxpAplica a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.id = @ID 
          --23508
          --SELECT @IVAFiscal=ISNULL(@IVAFiscal,0)-ISNULL(@IEPSFiscal, 0)
        END
      END
      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT

      IF @Tasa IS NOT NULL 
        EXEC spVerTasaDiaria @Tasa, @FechaEmision, @TasaDiaria OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      
      IF @Modulo = 'CXC'   
      BEGIN
        SELECT @FechaRevision = @FechaEmision
        SELECT @DiaRevision = DiaRevision1 FROM Cte WHERE Cliente = @Contacto
        EXEC spRecorrerVencimiento @DiaRevision, @FechaRevision OUTPUT
        
/*
         IF @OrigenTipo ='CXC'  --21568
		IF (SELECT ISNULL( SUM(ISNULL(V.IVAFiscal,0)),0) FROM CxcD cd INNER JOIN  Venta v ON  v.MovID =cd.AplicaID AND v.Mov =cd.Aplica INNER JOIN Cxc c on c.ID =cd.ID
			 WHERE c.ID =@ID AND C.Empresa =V.Empresa AND C.Sucursal =V.Sucursal AND C.Empresa =@Empresa AND C.Sucursal =@Sucursal  )=0
		 SELECT @IVAFiscal =0
*/

        UPDATE Cxc   SET Concepto = @Concepto, Impuestos = @Impuestos, IVAFiscal = @IVAFiscal, IEPSFiscal = @IEPSFiscal, Saldo = @SaldoNuevo, UltimoCambio = @FechaEmision, FechaConclusion = @FechaConclusion, FechaCancelacion = @FechaCancelacion, Estatus = @EstatusNuevo, Situacion = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END, GenerarPoliza = @GenerarPoliza, FechaProntoPago = @FechaProntoPago, DescuentoProntoPago = @DescuentoProntoPago, Condicion = @Condicion, Vencimiento = @Vencimiento, Tasa = @Tasa, TasaDiaria = ISNULL(@TasaDiaria, TasaDiaria), Autorizacion = @Autorizacion, FechaRevision = @FechaRevision WHERE ID = @ID 
        --18974
        IF ISNULL(@Origen,'' )='' AND ISNULL(@OrigenID,'' )='' AND @Mov='Aplicacion'
        UPDATE Cxc   SET Origen =@MovAplica ,OrigenID =@MovAplicaID  WHERE ID = @ID 
         --21568
        IF EXISTS(SELECT ID from Venta WHERE MovID=@MovID   AND Mov=@Mov  AND Empresa=@Empresa AND Sucursal =@Sucursal) AND @OrigenTipo ='VTAS'
        BEGIN 
			SELECT @IVAFiscal =IVAFiscal FROM Venta WHERE MovID=@MovID   AND  Mov=@Mov	AND Empresa=@Empresa AND Sucursal =@Sucursal			
			IF ISNULL(@IVAFiscal ,0)=0		 
			UPDATE Cxc   SET  IVAFiscal = @IVAFiscal WHERE ID = @ID
		END
      END ELSE
      IF @Modulo = 'CXP'   
       BEGIN
			UPDATE Cxp   SET Concepto = @Concepto, Impuestos = @Impuestos, IVAFiscal = @IVAFiscal, IEPSFiscal = @IEPSFiscal, Saldo = @SaldoNuevo, UltimoCambio = @FechaEmision, FechaConclusion = @FechaConclusion, FechaCancelacion = @FechaCancelacion, Estatus = @EstatusNuevo, Situacion = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END, GenerarPoliza = @GenerarPoliza, FechaProntoPago = @FechaProntoPago, DescuentoProntoPago = @DescuentoProntoPago, Condicion = @Condicion, Vencimiento = @Vencimiento, Tasa = @Tasa, TasaDiaria = ISNULL(@TasaDiaria, TasaDiaria), Autorizacion = @Autorizacion, Mensaje = NULL WHERE ID = @ID 
			 --21568
			IF EXISTS(SELECT ID from Compra where MovID=@MovID   and Mov=@Mov AND Empresa=@Empresa AND Sucursal =@Sucursal  ) AND @OrigenTipo ='COMS'
			BEGIN
				SELECT @IVAFiscal =IVAFiscal FROM Compra  WHERE MovID=@MovID   AND Mov=@Mov	AND Empresa=@Empresa AND Sucursal =@Sucursal 
				IF ISNULL(@IVAFiscal ,0)=0	
				UPDATE Cxp  SET  IVAFiscal = @IVAFiscal WHERE ID = @ID
			END
        END
      ELSE
      IF @Modulo = 'AGENT' 
        UPDATE Agent SET Concepto = @Concepto, Impuestos = @Impuestos, Saldo = @SaldoNuevo, UltimoCambio = @FechaEmision, FechaConclusion = @FechaConclusion, FechaCancelacion = @FechaCancelacion, Estatus = @EstatusNuevo, Situacion = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END, GenerarPoliza = @GenerarPoliza, Importe = @Importe, Retencion = @Retencion, Autorizacion = @Autorizacion WHERE ID = @ID 
      IF @@ERROR <> 0 SELECT @Ok = 1
      
      -- Calcular Comisiones
      IF @Agente IS NOT NULL AND 
          ((@OrigenMovTipo IS NULL AND @MovTipo IN ('CXC.F', /*'CXC.CA', 'CXC.CAD', */'CXC.NC', 'CXC.NCD')) 
       OR (@MovTipo IN ('CXC.C', 'CXC.A', 'CXC.AR', 'CXC.AA', 'CXC.CD') AND @CfgVentaComisionesCobradas = 1 AND @CfgComisionBase = 'COBRO'))
      BEGIN
        SELECT @ImporteComision = 0.0
        IF @Accion <> 'CANCELAR'
        BEGIN
          EXEC xpComisionCalcular @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
        	                  @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Agente, @Conexion, @SincroFinal, @Sucursal,
		  		  NULL, NULL, NULL, NULL, @Importe, @Importe, @Impuestos, @Impuestos, NULL, NULL, NULL,
                                  @ImporteComision OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          IF ISNULL(@ImporteComision, 0.0) <> 0.0 AND @Ok IS NULL
            UPDATE Cxc SET ComisionTotal = @ImporteComision, ComisionPendiente = @ImporteComision WHERE ID = @ID 
        END ELSE
          SELECT @ImporteComision = ComisionTotal FROM Cxc WHERE ID = @ID

        -- Generar Comisiones
        IF ISNULL(@ImporteComision, 0.0) <> 0.0 AND @Ok IS NULL 
           AND (@CfgVentaComisionesCobradas = 0 OR (@CfgVentaComisionesCobradas = 1 AND @MovTipo IN ('CXC.C', 'CXC.A', 'CXC.AR', 'CXC.AA', 'CXC.CD') AND @CfgComisionBase = 'COBRO'))
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, 'AGENT', @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                           @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                           @FechaRegistro, @Ejercicio, @Periodo, 
                           NULL, NULL, @Contacto, NULL, @Agente, NULL, NULL, NULL, 
                           @Importe, NULL, NULL, @ImporteComision, 
                           NULL, NULL, NULL, NULL, NULL, NULL,
                           @CxModulo, @CxMov, @CxMovID, @Ok OUTPUT, @OkRef  OUTPUT
      END

      EXEC spEmbarqueMov @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Estatus, @EstatusNuevo, @CfgEmbarcar, @Ok OUTPUT

      IF @Generar = 1
      BEGIN
        IF @GenerarAfectado = 1 SELECT @GenerarEstatus = 'CONCLUIDO' ELSE SELECT @GenerarEstatus = 'SINAFECTAR'
        IF @GenerarEstatus = 'CONCLUIDO' SELECT @FechaConclusion = @FechaEmision ELSE IF @GenerarEstatus <> 'CANCELADO' SELECT @FechaConclusion = NULL
        IF @GenerarEstatus = 'CONCLUIDO' AND @CfgContX = 1 AND @CfgContXGenerar <> 'NO' SELECT @GenerarPolizaTemp = 1 ELSE SELECT @GenerarPolizaTemp = 0

        EXEC spValidarTareas @Empresa, @Modulo, @IDGenerar, @GenerarEstatus, @Ok OUTPUT, @OkRef OUTPUT
        IF @Modulo = 'CXC'   UPDATE Cxc   SET FechaConclusion = @FechaConclusion, Estatus = @GenerarEstatus, GenerarPoliza = @GenerarPolizaTemp WHERE ID = @IDGenerar ELSE
        IF @Modulo = 'CXP'   UPDATE Cxp   SET FechaConclusion = @FechaConclusion, Estatus = @GenerarEstatus, GenerarPoliza = @GenerarPolizaTemp WHERE ID = @IDGenerar ELSE
        IF @Modulo = 'AGENT' UPDATE Agent SET FechaConclusion = @FechaConclusion, Estatus = @GenerarEstatus, GenerarPoliza = @GenerarPolizaTemp WHERE ID = @IDGenerar 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END
  /* MovImpuesto */
  IF NOT EXISTS(SELECT * FROM MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID) AND @Ok IS NULL
  BEGIN
    IF @IDOrigen IS NULL 
    BEGIN
      SELECT @CompraID = NULL
      IF @MovTipo = 'CXP.A'
      BEGIN
        SELECT @CompraID = MIN(ID) FROM Compra WHERE Empresa = @Empresa AND @Referencia = Mov+' '+MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      	IF @CompraID IS NOT NULL
      	BEGIN
          SELECT @CompraImporte = ISNULL(Importe, 0.0)
            FROM Compra
           WHERE ID = @CompraID
          INSERT MovImpuesto (
                 Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,	        OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,                                     Importe2,                                     Importe3,                                     SubTotal,                                     ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
          SELECT @Modulo, @ID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, dbo.fnR3(@CompraImporte, Importe1, @Importe), dbo.fnR3(@CompraImporte, Importe2, @Importe), dbo.fnR3(@CompraImporte, Importe3, @Importe), dbo.fnR3(@CompraImporte, SubTotal, @Importe), ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
            FROM MovImpuesto
           WHERE Modulo = 'COMS' AND ModuloID = @CompraID
        END ELSE 
        BEGIN
--JGD 06Enero2011. CXPReferenciaEnAnticiposCP
          IF (SELECT CP FROM EmpresaGral WHERE Empresa = @Empresa) = 1 AND (SELECT CXPReferenciaEnAnticiposCP FROM empresacfg2 WHERE Empresa = @Empresa) = 1
            SELECT @Ok = 20916, @OkRef = @Referencia
        END                 	                  
      END
--AR y JGD 03Febrero2011 Solucion Ticket 2636
      IF @CompraID IS NULL OR (@OrigenTipo = 'INV' AND @OrigenMovTipo = 'INV.EI' AND EXISTS (SELECT ID FROM InvGastoDiverso WHERE ID = @IDOrigen)) --arcc
      BEGIN
         IF @Modulo = 'CXC' SELECT @ContUso = NULLIF(ContUso,''), @ContUso2 = NULLIF(ContUso2,''), @ContUso3 = NULLIF(ContUso3,'') FROM Cxc WHERE ID = @ID ELSE
         IF @Modulo = 'CXP' SELECT @ContUso = NULLIF(ContUso,''), @ContUso2 = NULLIF(ContUso2,''), @ContUso3 = NULLIF(ContUso3,'') FROM Cxp WHERE ID = @ID
      
         INSERT MovImpuesto 
                (Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenFecha,   Retencion1,                                Retencion2,                                Retencion3,                                Impuesto1,                                               Importe1,  SubTotal,  ContUso,  ContUso2,  ContUso3)
          SELECT @Modulo, @ID,      @Modulo,      @ID,            @Concepto,      @FechaEmision, (@Retencion/NULLIF(@Importe, 0.0))*100.0, (@Retencion2/NULLIF(@Importe, 0.0))*100.0, (@Retencion3/NULLIF(@Importe, 0.0))*100.0,  ROUND(dbo.fnR3(NULLIF(@Importe, 0.0),100,@Impuestos),2), @Impuestos, @Importe, @ContUso, @ContUso2, @ContUso3
      END        
    END ELSE
    BEGIN
--Fin AR y JGD
      IF (@OrigenTipo = 'COMS' AND @OrigenMovTipo = 'COMS.EG' AND EXISTS (SELECT ID FROM CompraGastoDiverso WHERE ID = @IDOrigen)) --AND @Mov <> @OrigenMov
      OR (@OrigenTipo = 'COMS' AND @OrigenMovTipo = 'COMS.EI')
      OR (@OrigenTipo = 'INV' AND @OrigenMovTipo = 'INV.EI' AND EXISTS (SELECT ID FROM InvGastoDiverso WHERE ID = @IDOrigen)) --AND @Mov <> @OrigenMov
      BEGIN
        INSERT MovImpuesto 
              (Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenFecha,   Retencion1,                                Retencion2,                                Retencion3,                                Impuesto1,                               Importe1,   SubTotal)
        SELECT @Modulo, @ID,      @OrigenTipo,  @IDOrigen,      @Concepto,      FechaEmision,  (@Retencion/NULLIF(@Importe, 0.0))*100.0, (@Retencion2/NULLIF(@Importe, 0.0))*100.0, (@Retencion3/NULLIF(@Importe, 0.0))*100.0, (@Impuestos/NULLIF(@Importe, 0.0))*100.0, @Impuestos, @Importe
          FROM Mov
         WHERE Empresa = @Empresa AND Modulo = @OrigenTipo AND ID = @IDOrigen

        IF @OrigenTipo = 'COMS'
          UPDATE MovImpuesto SET Excento1 = c.Impuesto1Excento, Excento2 = c.Excento2, Excento3 = c.Excento3 
            FROM MovImpuesto p
            JOIN CompraGastoDiverso g ON p.OrigenModulo = @OrigenTipo AND p.OrigenModuloID = g.ID AND p.OrigenConcepto = g.Concepto
            JOIN Concepto c ON c.Concepto = g.Concepto 
           WHERE p.Modulo = 'CXP' AND p.ModuloID = @ID
        
        IF @OrigenTipo = 'INV'
          UPDATE MovImpuesto SET Excento1 = c.Impuesto1Excento, Excento2 = c.Excento2, Excento3 = c.Excento3 
            FROM MovImpuesto p
            JOIN InvGastoDiverso g ON p.OrigenModulo = @OrigenTipo AND p.OrigenModuloID = g.ID AND p.OrigenConcepto = g.Concepto
            JOIN Concepto c ON c.Concepto = g.Concepto 
           WHERE p.Modulo = 'CXP' AND p.ModuloID = @ID
      END
      ELSE
      IF @OrigenTipo = 'CXP' AND @OrigenMovTipo = 'CXP.RA'
        INSERT MovImpuesto (
               Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,	      OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1, Importe2, Importe3, SubTotal, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
        SELECT @Modulo, @ID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1, Importe2, Importe3, SubTotal, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
          FROM MovImpuesto
         WHERE Modulo = @Modulo AND ModuloID = @ID
--JGD 21Junio2011. Ticket 4861. 
      ELSE
        IF @OrigenTipo = 'GAS' AND @OrigenMovTipo = 'GAS.GTC'
          INSERT MovImpuesto (
                 Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible, OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1, Importe2, Importe3, SubTotal, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
            SELECT Modulo,ModuloID,OrigenModulo,OrigenModuloID,OrigenConcepto,ISNULL(OrigenDeducible, 100),OrigenFecha,LoteFijo,Retencion1,Retencion2,Retencion3,Excento1,Excento2,Excento3,Impuesto1,Impuesto2,Impuesto3,TipoImpuesto1,TipoImpuesto2,TipoImpuesto3,TipoRetencion1,TipoRetencion2,TipoRetencion3, @Impuestos,Importe2,Importe3,@Importe,ContUso,ContUso2,ContUso3,ClavePresupuestal,ClavePresupuestalImpuesto1,DescuentoGlobal 
              FROM MovImpuesto
             WHERE Modulo = 'CXP' AND ModuloID = @ID AND OrigenConcepto = @Concepto
--Fin JGD 21Junio2011
      ELSE BEGIN
      	SELECT @OrigenImporte = SUM(SubTotal)
      	  FROM MovImpuesto
         WHERE Modulo = @OrigenTipo AND ModuloID = @IDOrigen

        INSERT MovImpuesto (
               Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,	      OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,                                     Importe2,                                     Importe3,                                     SubTotal,                                     ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
        SELECT @Modulo, @ID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, dbo.fnR3(@OrigenImporte, Importe1, @Importe), dbo.fnR3(@OrigenImporte, Importe2, @Importe), dbo.fnR3(@OrigenImporte, Importe3, @Importe), dbo.fnR3(@OrigenImporte, SubTotal, @Importe), ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
          FROM MovImpuesto
         WHERE Modulo = @OrigenTipo AND ModuloID = @IDOrigen
       END
    END
  END

  IF NOT EXISTS(SELECT * FROM MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID) AND @MovTipo = 'CXP.F' AND @OrigenMovTipo = 'GAS.GTC' AND @IDOrigen IS NOT NULL 
  BEGIN
    SELECT @SubFolio = SUBSTRING(@MovID, PATINDEX('%-%', @MovID )+1, 5)
    INSERT MovImpuesto (
           Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,		  OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1, Importe2, Importe3, SubTotal, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
    SELECT @Modulo, @ID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1, Importe2, Importe3, SubTotal, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
      FROM MovImpuesto
     WHERE Modulo = @OrigenTipo AND ModuloID = @IDOrigen AND SubFolio = @SubFolio
  END

    IF @MovTipo IN ('CXC.ANC', 'CXC.ACA', 'CXP.ANC', 'CXP.ACA') AND @Accion <> 'CANCELAR' 
    BEGIN
      INSERT MovImpuesto (
             Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,		OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,                  Importe2,                  Importe3,                  SubTotal,                  ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
      SELECT @Modulo, @ID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1*@MovAplicaFactor, Importe2*@MovAplicaFactor, Importe3*@MovAplicaFactor, SubTotal*@MovAplicaFactor, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
        FROM MovImpuesto
       WHERE Modulo = @Modulo AND ModuloID = @IDAplica
    END

    IF @Ok IN (NULL, 80030) AND @RamaID IS NULL AND @MovTipo IN ('CXC.F', 'CXC.CA', 'CXC.CAP', 'CXC.CAD', 'CXC.D', 'CXC.DM', 'CXP.F', 'CXP.CA', 'CXP.CAP', 'CXP.CAD', 'CXP.D', 'CXP.DM') AND @Condicion IS NOT NULL AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo = 'PENDIENTE' AND @Accion = 'AFECTAR' 
    BEGIN
      SELECT @Ok = NULL, @OkRef = NULL
      IF @CfgAC = 1
      BEGIN
        IF @OrigenTipo IN ('VTAS', 'COMS')
          EXEC spCopiarTablaAmortizacionGuia @OrigenTipo, @IDOrigen, @Modulo, @ID
        EXEC spTablaAmortizacion @Modulo, @ID, @Usuario, 1, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT
      END ELSE 
        IF @INSTRUCCIONES_ESP <> 'SIN_DOCAUTO' AND EXISTS(SELECT * FROM Condicion WHERE Condicion = @Condicion AND DA = 1)
          EXEC spCxDocAuto @Modulo, @ID, @Usuario, @Ok OUTPUT, @OkRef OUTPUT
    END
    IF @Ok IS NULL
    BEGIN
      IF @Modulo = 'CXC' 	-- ETO Tarjetas 9-Feb-2007
      BEGIN
        SELECT @FormaCobroTarjetas = CxcFormaCobroTarjetas FROM EmpresaCfg WHERE Empresa = @Empresa
        SELECT @LDITarjeta = ISNULL(LDI,0), @LDIServicio = NULLIF(LDIServicio,'') FROM FormaPago WHERE FormaPago = @FormaCobroTarjetas 
        SELECT @TarjetasCobradas = 0.0

        SELECT @ConDesglose = ConDesglose,
	       @Importe1 = ISNULL(Importe1, 0), @FormaCobro1 = FormaCobro1,
	       @Importe2 = ISNULL(Importe2, 0), @FormaCobro2 = FormaCobro2,
	       @Importe3 = ISNULL(Importe3, 0), @FormaCobro3 = FormaCobro3,
               @Importe4 = ISNULL(Importe4, 0), @FormaCobro4 = FormaCobro4,
               @Importe5 = ISNULL(Importe5, 0), @FormaCobro5 = FormaCobro5,
               --BUG15665
               @Referencia1 = Referencia1, @Referencia2 = Referencia2, @Referencia3 = Referencia3, @Referencia4 = Referencia4, @Referencia5 = Referencia5
          FROM Cxc
         WHERE ID = @ID

        IF @ConDesglose = 0 AND @ImporteTotal > 0.0 AND @FormaPago = @FormaCobroTarjetas
          BEGIN
            SELECT @TarjetasCobradas = @ImporteTotal, @FormaCobro1 = @FormaPago
          END
        ELSE
          BEGIN
            --BUG15665
            IF @FormaCobro1 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe1, @ReferenciaTarjetas = @Referencia1
            IF @FormaCobro2 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe2, @ReferenciaTarjetas = @Referencia2
            IF @FormaCobro3 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe3, @ReferenciaTarjetas = @Referencia3
            IF @FormaCobro4 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe4, @ReferenciaTarjetas = @Referencia4
            IF @FormaCobro5 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe5, @ReferenciaTarjetas = @Referencia5
          END

        IF @MovTipo IN ('CXC.A','CXC.AR','CXC.AA','CXC.C', 'CXC.DC', 'CXC.DE')
        BEGIN 
          IF @ValesCobrados > 0.0 OR @TarjetasCobradas > 0.0
          -- Aplicar Vale, Cambiar Estatus = COBRADO
            EXEC spValeAplicarCobro @Empresa, @Modulo, @ID, @TarjetasCobradas, @Accion, @FechaEmision, @Ok OUTPUT, @OkRef OUTPUT
          -- kike Tarjetas spValeGeneraAplicacionTarjeta
--REQ 13386           
          IF @TarjetasCobradas <> 0.0 AND @Ok IS NULL AND NOT EXISTS(SELECT * FROM TarjetaSerieMov t JOIN ValeSerie v ON t.Serie = v.Serie JOIN Art a ON v.Articulo = a.Articulo WHERE t.Empresa = @Empresa AND t.Modulo = @Modulo AND t.ID = @ID AND ISNULL(t.Importe,0) <> 0 AND ISNULL(a.LDI,0) = 1) AND @LDITarjeta = 0 
            EXEC spValeGeneraAplicacionTarjeta @Empresa, @Modulo, @ID, @Mov, @MovID, @Accion, @FechaEmision, @Usuario, @Sucursal, @TarjetasCobradas, @CtaDinero, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT, @Referencia = @ReferenciaTarjetas --BUG15665
        END
      END	-- ETO Tarjetas 9-Feb-2007 Hasta aqui fue el cambio

     /**** INICIA: CABSA Deposito anticipado ****/
			DECLARE @EsNoIdentificado	bit
			SELECT @EsNoIdentificado = ISNULL(EsNoIdentificado,0) FROM FormaPago WHERE FormaPago = @FormaPago
			IF ISNULL(@EsNoIdentificado,0) = 1
				SELECT @CfgFormaCobroDA = @FormaPago
		/**** TERMINA: CABSA Deposito anticipado ****/
			IF (@MovTipo IN ('CXC.A','CXC.AR','CXC.AA','CXC.C','CXP.CAP','CXP.DP','CXP.CD','CXP.DC','CXP.NCP','CXP.C','AGENT.A') AND @ConDesglose = 0 AND UPPER(@FormaPago) = UPPER(@CfgFormaCobroDA)) OR
         (@MovTipo IN ('CXC.A','CXC.AR','CXC.AA','CXC.C') AND (@ConDesglose = 1 AND (SELECT UPPER(FormaCobro1) FROM Cxc WHERE ID = @ID)=UPPER(@CfgFormaCobroDA)))         
        -- Aplicar Deposito Anticipado de Dinero
        EXEC spDepositoAnticipado @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @ImporteTotal, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago, @CfgFormaCobroDA, @Referencia, @Ok OUTPUT, @OkRef OUTPUT
      ELSE--DSG Revisar las claves de afectacion que van a afectar al Cargo No Identificado
      IF (@MovTipo IN ('CXP.P','CXP.DP','CXP.NCP','CXP.ANC','CXP.A','CXP.AA','CXC.CAP','CXC.DE','CXC.DFA','CXC.DI','CXC.DC','AGENT.P','AGENT.A') AND @ConDesglose = 0 AND UPPER(@FormaPago) = UPPER(@CfgFormaCobroDA)) OR
         (@MovTipo IN ('CXC.DE') AND (@ConDesglose = 1 AND (SELECT UPPER(FormaCobro1) FROM Cxc WHERE ID = @ID)=UPPER(@CfgFormaCobroDA)))         
        -- Aplicar Cargos No Identificados de Dinero
        EXEC spCargoNoIdentificado @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @ImporteTotal, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago, @CfgFormaCobroDA, @Referencia, @Ok OUTPUT, @OkRef OUTPUT
      ELSE 
      	 BEGIN

        SELECT @DineroImporte = @ImporteTotal 
        IF @MovTipo = 'CXC.C' AND @ConDesglose = 1 AND @CobroDelEfectivo > 0.0 
        BEGIN
          IF @Accion <> 'CANCELAR' SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0
          EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'CEFE', @MovMoneda, @MovTipoCambio, @Contacto, NULL, NULL, NULL,
                       @Modulo, @ID, @Mov, @MovID, @EsCargo, @CobroDelEfectivo, NULL, NULL,
                       @FechaAfectacion, @Ejercicio, @Periodo, 'Saldo a Favor', NULL, 0, 0, 0,
                       @Ok OUTPUT, @OkRef OUTPUT
          SELECT @DineroImporte = @DineroImporte - @CobroDelEfectivo
        END
        -- Afectar en Otros Modulos
        IF ROUND(@DineroImporte, 2) > 0.0 AND @Ok IS NULL AND ((@MovTipo IN ('CXC.C','CXC.AA','CXC.DE','CXC.DFA','CXC.DI','CXC.DC', 'CXP.P','CXP.AA','CXP.DE','CXP.DC', 'AGENT.P','AGENT.CO') AND @EstatusNuevo IN ('CONCLUIDO','CANCELADO')) 
        OR (@MovTipo IN ('CXC.CAP','CXP.CAP','CXC.DP','CXC.NCP','CXC.CD', 'CXP.DP','CXP.NCP','CXP.CD','CXP.C', 'AGENT.A'))
	OR (@MovTipo IN ('CXC.A'/*, 'CXC.AR'*/) AND @OrigenMovTipo <> 'CXC.RA')
	OR (@MovTipo = 'CXP.A' AND @OrigenMovTipo <> 'CXP.RA')
	OR (@MovTipo IN ('CXC.ANC','CXP.ANC') AND @AplicaPosfechado = 1)
        ) 
        BEGIN
          IF @MovTipo IN ('AGENT.P', 'AGENT.CO') AND @AgenteNomina = 1 
          BEGIN
			SELECT @NomAuto= NomAuto FROM EmpresaGral WHERE Empresa=@Empresa 
				--inserta en Incidencia 
				SELECT @NominaID = NULL, @NominaMov = @AgenteNominaMov, @NominaMovID = NULL
				EXEC spGenerarNominaAuto @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
				@FechaAfectacion, @FechaRegistro, @AgenteNominaConcepto, @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones,
				@AgentePersonal, @NominaID OUTPUT, @NominaMov OUTPUT, @NominaMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
				--inserta en Nomina 
				SELECT @NominaID = NULL, @NominaMov = @AgenteNominaMov, @NominaMovID = NULL
				IF @OK IS NULL
					EXEC spGenerarNomina @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
					@FechaAfectacion, @FechaRegistro, @AgenteNominaConcepto, @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones,
					@AgentePersonal, @NominaID OUTPUT, @NominaMov OUTPUT, @NominaMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          END ELSE
          IF @MovTipo IN ('AGENT.P', 'AGENT.CO') AND @CfgAgentAfectarGastos = 1 
            EXEC spGenerarGasto @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT, @MovTipoGenerarGasto = 1
          ELSE BEGIN
            SELECT @DineroTipo = NULL
            IF @AplicaPosfechado = 1 SELECT @DineroTipo = 'APLICA_POSFECHADO'

            IF @MovTipo IN ('CXC.CAP', 'CXP.CAP')
            BEGIN
              IF @MovTipo = 'CXC.CAP' SELECT @DineroImporte = @DineroImporte - ISNULL(InteresesAnticipados, 0.0) - ISNULL(Comisiones, 0.0) - ISNULL(ComisionesIVA, 0.0) FROM Cxc WHERE ID = @ID ELSE
              IF @MovTipo = 'CXP.CAP' SELECT @DineroImporte = @DineroImporte - ISNULL(InteresesAnticipados, 0.0) - ISNULL(Comisiones, 0.0) - ISNULL(ComisionesIVA, 0.0) FROM Cxp WHERE ID = @ID
            END

            IF @CfgAC = 1 AND @MovTipo IN ('CXC.CAP', 'CXP.CAP') AND EXISTS(SELECT * FROM LCCtaDinero WHERE LineaCredito = @LineaCredito)
            BEGIN
              SELECT @LCCtaDineroImporte = SUM(Importe) FROM LCCtaDinero WHERE LineaCredito = @LineaCredito
	      DECLARE crLCCtaDinero CURSOR LOCAL FOR
  	       SELECT CtaDinero, dbo.fnR3(@LCCtaDineroImporte, @DineroImporte, Importe)
                 FROM LCCtaDinero 
                WHERE LineaCredito = @LineaCredito
	      OPEN crLCCtaDinero
  	      FETCH NEXT FROM crLCCtaDinero INTO @LCCtaDinero, @LCCtaDineroImporte
	      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
	      BEGIN
	        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
                BEGIN
                  EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                       @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @ConDesglose, 0,
                                       @FechaRegistro, @Ejercicio, @Periodo, 
                                       @FormaPago, @DineroTipo, @Beneficiario,
                                       @Contacto, @LCCtaDinero, @Cajero, @LCCtaDineroImporte, NULL,
		  	               NULL, NULL, @Vencimiento,
		      	               @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                       @Ok OUTPUT, @OkRef OUTPUT, @ProveedorAutoEndoso = @ProveedorAutoEndoso, @Nota = @Nota, @EstacionTrabajo = @EstacionTrabajo -- REQ12336
                  IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
                END
	        FETCH NEXT FROM crLCCtaDinero INTO @LCCtaDinero, @LCCtaDineroImporte
  	      END
	      CLOSE crLCCtaDinero
	      DEALLOCATE crLCCtaDinero
            END ELSE
              EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @ConDesglose, 0,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @FormaPago, @DineroTipo, @Beneficiario,
                                   @Contacto, @CtaDinero, @Cajero, @DineroImporte, NULL,
		  	           NULL, NULL, @Vencimiento,
		      	           @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                   @Ok OUTPUT, @OkRef OUTPUT, @ProveedorAutoEndoso = @ProveedorAutoEndoso, @Nota = @Nota, @EstacionTrabajo = @EstacionTrabajo -- REQ12336
          END
        END
      END
      IF @MovTipo IN ('CXC.RA', 'CXP.RA')
      BEGIN
        EXEC @IDGenerar = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                         @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  NULL, NULL, NULL, NULL,
                         @FechaRegistro, @Ejercicio, @Periodo, 
                         NULL, NULL, @Contacto, @ContactoEnviarA, @Agente, NULL, @CtaDinero, @FormaPago, 
           	         @Importe, @Impuestos, NULL, NULL, 
                         NULL, NULL, NULL, NULL, NULL, NULL,
                         @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef  OUTPUT
        IF @Ok IS NULL AND @Accion <> 'CANCELAR'
          SELECT @Ok = 80030, @GenerarMov = @CxMov, @GenerarMovID = @CxMovID
      END
      IF @MovTipo IN ('CXC.NCF', 'CXP.NCF')
      BEGIN
        SELECT @ImporteMN = @Importe * @ContactoTipoCambio,
               @ImpuestosMN = @Impuestos * @ContactoTipoCambio,
               @MonedaMN = NULL
        SELECT @MonedaMN = cfg.ContMoneda FROM EmpresaCfg cfg, Mon m WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda AND m.TipoCambio = 1.0
        IF @MonedaMN IS NULL SELECT MIN(Moneda) FROM Mon WHERE TipoCambio = 1.0
        EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MonedaMN, 1.0,
                         @FechaAfectacion, NULL, @Proyecto, @Usuario,  NULL, NULL, NULL, NULL,
                         @FechaRegistro, @Ejercicio, @Periodo, 
                         NULL, NULL, @Contacto, @ContactoEnviarA, @Agente, NULL, @CtaDinero, @FormaPago, 
           	         @ImporteMN, @ImpuestosMN, NULL, NULL, 
                         NULL, NULL, NULL, NULL, NULL, NULL,
                         @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef  OUTPUT
        IF @Ok IS NULL AND @Accion <> 'CANCELAR'
          SELECT @Ok = 80030, @GenerarMov = @CxMov, @GenerarMovID = @CxMovID
      END
      IF @MovTipo IN ('CXC.VV','CXC.OV', 'CXC.DV', 'CXC.AV')
      BEGIN
        IF @MovTipo IN ('CXC.VV','CXC.OV') SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1 
        IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo

        EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'CVALE', @MovMoneda, @MovTipoCambio, @Contacto, NULL, NULL, NULL,
                     @Modulo, @ID, @Mov, @MovID, @EsCargo, @ImporteTotal, NULL, NULL,
                     @FechaAfectacion, @Ejercicio, @Periodo, 'Vales en Circulacion', NULL, 0, 0, 0,
                     @Ok OUTPUT, @OkRef OUTPUT
      END
      IF @MovTipo = 'CXP.PAG' AND @Aforo > 0.0 AND @Accion <> 'CANCELAR' AND @Ok IS NULL 
      BEGIN
        SELECT @AforoMovID = NULL, @AforoImporte = @ImporteTotal * (@Aforo / 100)
        SELECT @AforoMov = CxpAforo FROM EmpresaCfgMov WHERE Empresa = @Empresa
        INSERT Cxp (Sucursal, Empresa, Mov, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Estatus, 
                    Proveedor, ProveedorMoneda, ProveedorTipoCambio, Importe,       Condicion,  Vencimiento,  AplicaManual, OrigenTipo, Origen, OrigenID)
            VALUES (@Sucursal, @Empresa, @AforoMov, @FechaEmision, @Proyecto, @ContactoMoneda, @ContactoTipoCambio, @Usuario, @Referencia, 'SINAFECTAR', 
                    @Contacto, @ContactoMoneda, @ContactoTipoCambio, @AforoImporte, @Condicion, @Vencimiento, 1, 'PAGARE', @Mov, @MovID)
        SELECT @AforoID = SCOPE_IDENTITY()
        INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @AforoID, 2048.0, 0, @Mov, @MovID, @AforoImporte)
        EXEC spCx @AforoID, @Modulo, @Accion, 'TODO', @FechaEmision, NULL, @Usuario, 1, 0, @AforoMov OUTPUT, @AforoMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @AforoID, @AforoMov, @AforoMovID, @Ok OUTPUT
        IF @Ok IS NULL 
        BEGIN
          UPDATE Cxp SET Aforo = @AforoImporte WHERE ID = @ID
          SELECT @Ok = 80030, @GenerarMov = @AforoMov, @GenerarMovID = @AforoMovID
        END
      END
    END
    /* aqui estaba antes MovImpuesto */

  IF @Estatus = 'BORRADOR' AND @Accion = 'AFECTAR' AND @IDOrigen IS NOT NULL
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @OrigenTipo, @IDOrigen, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT

  IF @MovTipo = 'CXC.C' AND @Accion = 'CANCELAR'
    EXEC spCxcVoucherCancelar @ID, @Usuario, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    IF @GenerarGasto = 1 
       EXEC spGenerarGasto @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT, @MovTipoGenerarGasto = 1
  
  --REQ 13451
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spCxAfectarClavePresupuestal @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                      @FechaEmision, @Condicion, @Vencimiento, @FormaPago, @Contacto, @ContactoMoneda, @ContactoFactor, @ContactoTipoCambio, 
                                      @Importe, @Impuestos, @Saldo, @CtaDinero, @AplicaManual, @ConDesglose, 
                                      @Conexion, @SincroFinal, @Sucursal, @EstatusNuevo, 
                                      @MovAplica, @MovAplicaID, @Ok OUTPUT, @OkRef OUTPUT, @Estatus

  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC xpCxAfectar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                     @FechaEmision, @Condicion, @Vencimiento, @FormaPago, @Contacto, @ContactoMoneda, @ContactoFactor, @ContactoTipoCambio, 
                     @Importe, @Impuestos, @Saldo, @CtaDinero, @AplicaManual, @ConDesglose, 
                     @Conexion, @SincroFinal, @Sucursal, @EstatusNuevo, 
                     @MovAplica, @MovAplicaID, @Ok OUTPUT, @OkRef OUTPUT, @Estatus

  IF @Modulo = 'CXC'
  BEGIN
    IF (SELECT TieneMovimientos FROM Cte WHERE Cliente = @Contacto) = 0    
      UPDATE Cte SET TieneMovimientos = 1 WHERE TieneMovimientos = 0 AND Cliente = @Contacto
  END
  IF @Modulo = 'CXP'
  BEGIN
    IF (SELECT TieneMovimientos FROM Prov WHERE Proveedor = @Contacto) = 0    
      UPDATE Prov SET TieneMovimientos = 1 WHERE Proveedor = @Contacto
  END
  IF @Modulo = 'AGENT'
  BEGIN
    IF (SELECT TieneMovimientos FROM Agente WHERE Agente = @Contacto) = 0    
      UPDATE Agente SET TieneMovimientos = 1 WHERE Agente = @Contacto
  END
  IF @Agente IS NOT NULL
  BEGIN
    IF (SELECT TieneMovimientos FROM Agente WHERE Agente = @Agente) = 0    
      UPDATE Agente SET TieneMovimientos = 1 WHERE Agente = @Agente
  END

  -- Agregar a Estatus Log
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT, @EstacionTrabajo -- REQ12336

  --BUG8660
  IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL AND @MovTipo = 'CXP.P'
  BEGIN
    SELECT @IDCancelaCXPCA = mf.DID
      FROM MovFlujo mf
      JOIN MovTipo mt ON mf.DModulo = mt.Modulo AND mf.DMov = mt.Mov
     WHERE mf.OID = @ID 
       AND mf.OModulo = @Modulo 
       AND mf.DModulo = @Modulo 
       AND mt.Clave = 'CXP.NCF'
       AND Cancelado = 0

    IF @IDCancelaCXPCA IS NOT NULL
      SELECT @IDCancelaCXPCA = mf.DID
        FROM MovFlujo mf
        JOIN MovTipo mt ON mf.DModulo = mt.Modulo AND mf.DMov = mt.Mov
       WHERE mf.OID = @IDCancelaCXPCA
         AND mf.OModulo = @Modulo 
         AND mf.DModulo = @Modulo 
         AND mt.Clave = 'CXP.CA'
         AND Cancelado = 0
         
    IF @IDCancelaCXPCA IS NOT NULL
      EXEC spCx @IDCancelaCXPCA, @Modulo, @Accion, 'TODO', @FechaEmision, NULL, @Usuario, 1, 0, NULL, NULL, NULL, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END
  IF @MovTipo IN ('CXC.A','CXC.AR','CXC.AA','CXC.C', 'CXC.DC', 'CXC.DE') AND @Modulo = 'CXC' AND(@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN 
  
--REQ 13386 
    IF @TarjetasCobradas <> 0.0 AND @LDI = 1 AND @CFDFlex = 0
    AND  EXISTS(SELECT * FROM TarjetaSerieMov t JOIN ValeSerie v ON t.Serie = v.Serie JOIN Art a ON v.Articulo = a.Articulo WHERE t.Empresa = @Empresa AND t.Modulo = @Modulo AND t.ID = @ID AND ISNULL(t.Importe,0) <> 0 AND ISNULL(a.LDI,0) = 1) AND   @LDITarjeta = 1  AND @LDIServicio IS NOT NULL
      EXEC spValeGeneraAplicacionTarjeta @Empresa, @Modulo, @ID, @Mov, @MovID, @Accion, @FechaEmision, @Usuario, @Sucursal, 
						@TarjetasCobradas, @CtaDinero, @MovMoneda, @MovTipoCambio, @LDIOk OUTPUT, @LDIOkRef OUTPUT, @LDI = 1, @Referencia = @ReferenciaTarjetas --BUG15665
    IF @LDIOk IS NOT NULL 
      SELECT @Ok = @LDIOk, @OkRef = @LDIOkRef						
  END  
  
  -- Cancelar Movimientos Ligados y el Flujo
  IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
    EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT

--IF @Ok IN (NULL, 80030) SELECT @Ok = 1 -- breakpoint
  IF @Conexion = 0 
  BEGIN
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
  END   
  RETURN
END
GO
