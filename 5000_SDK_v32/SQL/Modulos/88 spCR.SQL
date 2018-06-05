/* SP CR   */
-- use matriz
-- CR.C  Corte
-- CR.Z  Cierre

SET ANSI_NULLS OFF
SET ANSI_WARNINGS OFF
SET NOCOUNT ON

/*********************** spCRCFDAfectar ***********************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spCRCFDAfectar') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spCRCFDAfectar
GO
CREATE PROCEDURE spCRCFDAfectar
				(
				@EmpresaCR			varchar(5) = NULL,
				@SucursalCR			int = NULL,
				@CFDSerieCR			varchar(20) = NULL,
				@CFDFolioCR			varchar(20) = NULL
				)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @iXML						int,
  @ID						int,
  @CFDID					int,
  @CFDSerie					varchar(20),
  @CFDFolio					varchar(20),
  @CFD						varchar(max),
  @XMLMAX					varchar(max),   

  @Empresa					varchar(5),
  @Sucursal					int,
  @FechaTrabajo				datetime,
  @Registro					varchar(max),
  @CadenaOriginal			varchar(max),  
  @ModuloID					int,
  @MovID					varchar(20),
  
  @CFDFecha					datetime,			
  @Ejercicio				int,
  @Periodo					int,
  @CFDAprobacion			varchar(20),		
  @CFDnoCertificado			varchar(20),	
  @CFDSello					varchar(max),
  @CFDImporte				float,			
  @CFDRFC					varchar(15),
  @CFDImpuesto1				float,
  @CFDImpuesto2				float,  
  @RegistroModificado		xml,
  
  @iDatos					int
  
  

  DECLARE @DocumentoX TABLE
  (
  Empresa			varchar(5) NULL,
  Sucursal			int NULL,
  FechaTrabajo		datetime NULL,
  ID				int NULL,
  CFDID				int NULL,
  CFDSerie			varchar(20) NULL,
  CFDFolio			varchar(20) NULL,
  Registro			varchar(max) NULL,
  CadenaOriginal	varchar(max) NULL,  
  ModuloID			int NULL,
  MovID				varchar(20)
  )
  
  INSERT @DocumentoX (Empresa, Sucursal, FechaTrabajo, ID, CFDID, CFDSerie, CFDFolio, Registro, CadenaOriginal)  
  SELECT 
   Empresa, 
   Sucursal,
   FechaTrabajo,
   ID,
   CFDID,
   CFDSerie,
   CFDFolio,
   Registro,
   CadenaOriginal
    FROM CRCFD
   WHERE CFDFolio = ISNULL(@CFDFolioCR,CFDFolio)
     AND CFDSerie = ISNULL(@CFDSerieCR,CFDSerie)
     AND Sucursal = ISNULL(@SucursalCR,Sucursal)
     AND Empresa  = ISNULL(@EmpresaCR,Empresa)
     AND Estatus  = 'PENDIENTE'
               
  --UPDATE Venta 
  --   SET CRCFDDocumento = d.Registro
  --  FROM Venta v JOIN @DocumentoX d
  --    ON d.Empresa = v.Empresa AND d.Sucursal = v.Sucursal AND d.CFDSerie = v.CRCFDSerie AND d.CFDFolio = v.CRCFDFolio    

  UPDATE @DocumentoX 
     SET 
     ModuloID = v.ID,
     MovID    = v.MovID
    FROM @DocumentoX d JOIN Venta v
      ON d.Empresa = v.Empresa AND d.Sucursal = v.Sucursal AND d.CFDSerie = v.CRCFDSerie AND d.CFDFolio = v.CRCFDFolio    
  
  DECLARE crDocumentoX CURSOR FOR
   SELECT Empresa, Sucursal, MovID, CFDSerie, CFDFolio, Registro, ModuloID, CadenaOriginal
     FROM @DocumentoX

  OPEN crDocumentoX
  FETCH NEXT FROM crDocumentoX INTO @Empresa, @Sucursal, @MovID, @CFDSerie, @CFDFolio, @Registro, @ModuloID, @CadenaOriginal
  
  WHILE @@FETCH_STATUS = 0
  BEGIN

    SET @RegistroModificado = CONVERT(XML,REPLACE(@Registro,'xmlns=','xmlns:Temp='))  
    EXEC sp_xml_preparedocument @iDatos OUTPUT, @RegistroModificado
    SELECT  
	  @CFDFecha = fecha,			
	  @CFDAprobacion = noAprobacion,		
	  @CFDnoCertificado = noCertificado,	
	  @CFDSello = sello,
	  @CFDImporte = total			
      FROM OPENXML (@iDatos, '/Comprobante', 1) WITH (fecha datetime, serie varchar(10), folio int, noAprobacion varchar(15), noCertificado varchar(20), sello varchar(max), total float)

    SELECT  
		@CFDRFC = rfc			
      FROM OPENXML (@iDatos, '/Comprobante/Receptor', 1) WITH (rfc varchar(15))

    SELECT  
		@CFDImpuesto1 = ISNULL(SUM(ISNULL(importe,0.0)),0.0)			
      FROM OPENXML (@iDatos, '/Comprobante/Impuestos/Traslados/Traslado', 1) WITH (importe float, impuesto varchar(50))
     WHERE impuesto = 'IVA' 

    SELECT  
		@CFDImpuesto2 = ISNULL(SUM(ISNULL(importe,0.0)),0.0)			
      FROM OPENXML (@iDatos, '/Comprobante/Impuestos/Traslados/Traslado', 1) WITH (importe float, impuesto varchar(50))
     WHERE impuesto = 'IEPS' 

    EXEC sp_xml_removedocument @iDatos  

    IF NOT EXISTS(SELECT * FROM CFD WHERE ModuloID = @ModuloID AND Modulo = 'VTAS')
    BEGIN
      INSERT CFD (Modulo,  ModuloID,  Fecha,     Ejercicio,       Periodo,          Empresa,  MovID,  Serie,     Folio,     RFC,     Aprobacion,     Importe,     Impuesto1,     Impuesto2,     noCertificado,     Sello,     Documento, CadenaOriginal)
          VALUES ('VTAS',  @ModuloID, @CFDFecha, YEAR(@CFDFecha), MONTH(@CFDFecha), @Empresa, @MovID, @CFDSerie, @CFDFolio, @CFDRFC, @CFDAprobacion, @CFDImporte, @CFDImpuesto1, @CFDImpuesto2, @CFDnoCertificado, @CFDSello, @Registro, @CadenaOriginal)
    END ELSE
    BEGIN
      UPDATE CFD
         SET
         Fecha           = @CFDFecha,
         Ejercicio       = YEAR(@Ejercicio), 
         Periodo         = YEAR(@Ejercicio),
         Empresa         = YEAR(@Empresa),
         MovID           = @MovID,
         Serie           = @CFDSerie,
         Folio           = @CFDFolio,
         RFC             = @CFDRFC,
         Aprobacion      = @CFDAprobacion,          
         Importe         = @CFDImporte,
         Impuesto1       = @CFDImpuesto1,
         Impuesto2       = @CFDImpuesto2,
         noCertificado   = @CFDnoCertificado,
         Sello           = @CFDSello,
         Documento       = @Registro,
         CadenaOriginal  = @CadenaOriginal
       WHERE ModuloID = @ModuloID
         AND Modulo   = 'VTAS'                            
    END
      
    UPDATE CRCFD SET Estatus = 'CONCLUIDO' WHERE CFDFolio = @CFDFolio AND CFDSerie = @CFDSerie AND Sucursal = @Sucursal AND Empresa = @Empresa AND Estatus NOT IN ('CONCLUIDO')    
    
    FETCH NEXT FROM crDocumentoX INTO @Empresa, @Sucursal, @MovID, @CFDSerie, @CFDFolio, @Registro, @ModuloID, @CadenaOriginal
  END
  CLOSE crDocumentoX
  DEALLOCATE crDocumentoX

  SELECT "Mensaje" = ''
  RETURN  
END
GO

/**************** spCRVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCRVerificar') and type = 'P') drop procedure dbo.spCRVerificar
GO
CREATE PROCEDURE spCRVerificar
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
		    @CfgPrestamoCxc		bit,
	
		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @GenerarPoliza		bit,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @VentasContado	money,
    @Ventas		money,
    @VentasOp		int,
    @VentasCant		float,
    @Agentes		money,
    @AgentesOp		int,
    @AgentesCant	float,
    @Cobros		money,
    @CajaSaldo		money,
    @CtaDinero		char(10),
    @FormaPago		varchar(50),
    @Tolerancia		money,
    @Redondeo		money,
    @VentaAnticipo	money

  SELECT @Tolerancia = 0.01
  IF @Accion <> 'CANCELAR'
  BEGIN
    SELECT @VentasContado = ISNULL(SUM(Importe), 0) FROM CRVenta  WHERE ID = @ID AND ISNULL(Cxc, 0) = 0
    SELECT @Ventas        = ISNULL(SUM(Importe), 0), @VentasOp  = SUM(Operaciones), @VentasCant  = ROUND(SUM(Cantidad), 4) FROM CRVenta  WHERE ID = @ID 
    SELECT @Agentes       = ISNULL(SUM(Importe), 0), @AgentesOp = SUM(Operaciones), @AgentesCant = ROUND(SUM(Cantidad), 4) FROM CRAgente WHERE ID = @ID
    SELECT @Cobros        = ISNULL(SUM(Importe*TipoCambio), 0) FROM CRCobro WHERE ID = @ID AND ISNULL(Cxc, 0) = 0
    SELECT @Redondeo      = ISNULL(SUM(Importe*TipoCambio), 0) FROM CRCaja WHERE ID = @ID AND UPPER(Movimiento) = 'REDONDEO'
    SELECT @VentaAnticipo = ISNULL(SUM(Importe*TipoCambio), 0) FROM CRCaja WHERE ID = @ID AND UPPER(Movimiento) = 'VENTA ANTICIPO'
    SELECT @CajaSaldo     = ISNULL(SUM(ImporteNeto), 0) FROM CRD WHERE ID = @ID AND UPPER(Tipo) IN ('COBROS', 'CAJA') AND ISNULL(Cxc, 0) = 0
    IF @CfgPrestamoCxc = 1
      IF EXISTS(SELECT * FROM CRCaja WHERE ID = @ID AND UPPER(Movimiento) = 'DEVOLUCION PRESTAMO')
        SELECT @Ok = 35320

    IF ROUND(@VentasContado, 0) <> ROUND(@Cobros, 0) AND ABS(@VentasContado - @Cobros - @Redondeo - @VentaAnticipo) > @Tolerancia SELECT @Ok = 10310 ELSE
    IF @Agentes <> 0.0
    BEGIN
      IF @Ventas     <> @Agentes     AND ABS(@Ventas - @Agentes) > @Tolerancia SELECT @Ok = 10320 ELSE
      IF @VentasOp   <> @AgentesOp   SELECT @Ok = 10330 ELSE
      IF @VentasCant <> @AgentesCant SELECT @Ok = 10340
    END
    IF @Ok IS NULL
    BEGIN
      SELECT @CtaDinero = NULL
      IF @MovTipo = 'CR.C'
      BEGIN
        IF @CfgValidarCRCero = 1 AND ABS(@CajaSaldo) > @Tolerancia
          SELECT @Ok = 30450, @OkRef = @Caja
        IF @Ok IS NULL
        BEGIN
          SELECT @CtaDinero = MIN(crc.CtaDinero) FROM CRCaja crc, CtaDinero c WHERE crc.ID = @ID AND NULLIF(crc.Importe, 0.0) IS NOT NULL AND crc.CtaDinero = c.CtaDinero AND c.Tipo <> 'Caja'
          IF @CtaDinero IS NULL 
            IF EXISTS(SELECT * FROM CRCaja WHERE ID = @ID AND CtaDinero = @Caja)
              SELECT @CtaDinero = @Caja
        END
        IF @CfgValidarFolio = 1 
        BEGIN
          IF @CajaFolio IS NULL SELECT @Ok = 10230 ELSE
          IF EXISTS(SELECT * FROM CR WHERE Empresa = @Empresa AND Mov = @Mov AND Caja = @Caja AND Estatus = 'CONCLUIDO' AND CajaFolio = @CajaFolio)
            SELECT @Ok = 10240 
        END
      END ELSE
      IF @MovTipo = 'CR.Z'
      BEGIN
        IF @CfgValidarCRZCero = 1 AND ABS(@CajaSaldo) > @Tolerancia
          SELECT @Ok = 30450, @OkRef = @Caja
        IF @Ok IS NULL
        BEGIN
          IF (SELECT ISNULL(COUNT(*), 0) FROM CR WHERE Empresa = @Empresa AND Caja = @Caja AND Mov = @Mov AND FechaEmision = @FechaEmision AND Estatus = 'CONCLUIDO') >= @CfgMaxCRZ
            SELECT @Ok = 55390
          SELECT @CtaDinero = MIN(crc.CtaDinero) FROM CRCaja crc, CtaDinero c WHERE crc.ID = @ID AND NULLIF(crc.Importe, 0.0) IS NOT NULL AND crc.CtaDinero = c.CtaDinero AND c.Tipo <> 'Banco'
          IF @CtaDinero IS NULL 
            SELECT @CtaDinero = MIN(crc.CtaDinero) FROM CRCaja crc, CtaDinero c WHERE crc.ID = @ID AND NULLIF(crc.Importe, 0.0) IS NOT NULL AND crc.CtaDinero = c.CtaDinero AND Tipo = 'Banco' AND c.Moneda <> crc.Moneda         
        END
      END 
      IF @CtaDinero IS NOT NULL 
        SELECT @Ok = 10540, @OkRef = @CtaDinero      
    END

    /*SELECT @CtaDinero = MIN(crc.CtaDinero) FROM CRCaja crc, CtaDinero c WHERE crc.ID = @ID AND NULLIF(crc.Importe, 0.0) IS NOT NULL AND crc.CtaDinero = c.CtaDinero AND UPPER(crc.Movimiento) = 'CORTE' AND c.Tipo <> 'Banco'
    IF @CtaDinero IS NULL */
      SELECT @CtaDinero = MIN(crc.CtaDinero) FROM CRCaja crc, CtaDinero c WHERE crc.ID = @ID AND NULLIF(crc.Importe, 0.0) IS NOT NULL AND crc.CtaDinero = c.CtaDinero AND Tipo = 'Banco' AND c.Moneda <> crc.Moneda
    IF @CtaDinero IS NOT NULL 
      SELECT @Ok = 10540, @OkRef = @CtaDinero

    SELECT @FormaPago = NULL
    SELECT @FormaPago = MIN(crc.FormaPago) FROM CRCobro crc, FormaPago fp WHERE crc.ID = @ID AND NULLIF(crc.Importe, 0.0) IS NOT NULL AND crc.FormaPago = fp.FormaPago AND RequiereReferencia = 1 AND NULLIF(RTRIM(crc.Referencia), '') IS NULL
    IF @FormaPago IS NULL 
      SELECT @FormaPago = MIN(crc.FormaPago) FROM CRCaja crc, FormaPago fp WHERE crc.ID = @ID AND NULLIF(crc.Importe, 0.0) IS NOT NULL AND crc.FormaPago = fp.FormaPago AND RequiereReferencia = 1 AND NULLIF(RTRIM(crc.Referencia), '') IS NULL
    IF @FormaPago IS NOT NULL 
      SELECT @Ok = 20910, @OkRef = @FormaPago

    IF @Ok IS NULL
    BEGIN
      IF EXISTS(SELECT * FROM CRCobro WHERE ID = @ID AND (NULLIF(RTRIM(Moneda), '') IS NULL OR NULLIF(TipoCambio, 0) IS NULL)) SELECT @Ok = 30040, @OkRef = 'Cobro'
      IF EXISTS(SELECT * FROM CRCaja  WHERE ID = @ID AND (NULLIF(RTRIM(Moneda), '') IS NULL OR NULLIF(TipoCambio, 0) IS NULL)) SELECT @Ok = 30040, @OkRef = 'Caja'
    END
  END

  IF @Ok IS NULL
    EXEC xpCRVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                       @FechaEmision, @Estatus, 
        	       @Caja, @Cajero, @CajaFolio,
   		       @Conexion, @SincroFinal, @Sucursal, 
		       @CfgMaxCRZ, @CfgValidarCRCero, @CfgValidarCRZCero, @CfgValidarFolio,
		       @CfgContX, @CfgContXGenerar, @GenerarPoliza,
		       @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO


/**************** spCRAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCRAfectar') and type = 'P') drop procedure dbo.spCRAfectar
GO             
CREATE PROCEDURE spCRAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20) OUTPUT,
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
		   @CfgPrestamoCxc		bit,

		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

    		   @GenerarMov			char(20)     OUTPUT,
		   @IDGenerar			int	     OUTPUT,	
    		   @GenerarMovID	  	varchar(20)  OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CR				char(20),
    @CREstatus			char(15),
    @Cantidad			float,
    @Importe			money, 
    @PrecioTotal		money, 
    @ImporteAplicar		money,
    @DescuentoMov		char(20),
    @DescuentoImporte		money,
    @DescuentoLinea		float,
    @FechaVenta			datetime,
    @DescripcionExtra		varchar(100),

    @CxModulo			char(5),
    @CxMov			char(20),
    @CxMovID			varchar(20),

    @Generar			bit,
    @GenerarAfectado		bit,
    @GenerarModulo		char(5),
    @GenerarMovTipo		char(20),
    @GenerarEstatus		char(15),
    @GenerarPeriodo 		int, 
    @GenerarEjercicio 		int,
    @FechaCancelacion		datetime,
    @GenerarAccion		char(20),
    @ZonaImpuesto		varchar(30),

    @CfgCosteoNivelSubCuenta 	bit,
    @CfgZonaImpuestoNivelCte	bit,
    @CfgImpInc			bit,
    @CfgPrecioMoneda		bit,
    @CfgVentaMultiAlmacen	bit,
    @TipoCosteo			varchar(20),
    @ClienteNota		char(10),
    @ClienteVMOS		char(10),
    @AlmacenPrincipal		char(10),
    @Almacen			char(10),
    @AlmacenD			char(10),
    @Posicion			char(10),
    @VentaID			int,
    @VentaMov			char(20),
    @VentaMovID			varchar(20),
    @VentaEstatus		char(15),
    @Movimiento			varchar(20), 
    @CtaOrigen			char(10), 
    @CtaDestino			char(10), 
    @CtaDinero			char(10), 
    @FormaPago			varchar(50), 
    @DineroID			int,
    @DineroMov			char(20),
    @DineroMovID		varchar(20), 
    @CxcID			int,
    @CxcMov			char(20),
    @CxcMovID			varchar(20), 
    @InvID			int,
    @InvMov			char(20),
    @InvMovID			varchar(20), 
    @InvMovTipo			varchar(20), 
    @InvEstatus			varchar(15), 
    @AjusteID			int,
    @AjusteMov			char(20),
    @AjusteMovID		varchar(20), 
    @SoporteID			int,
    @SoporteMov			char(20),
    @SoporteMovID		varchar(20), 
    @ConDesglose		bit,
    @Renglon			float,
    @RenglonID			int,
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @Unidad			varchar(50),
    @Precio			float,
    @Costo			money,
    @JuntarImpuestos		float,
    @Moneda			char(10),
    @TipoCambio			float,    
    @Cliente			char(10),
    @ClienteEnviarA		int,  
    @Condicion			varchar(50),
    @Agente			char(10),
    @Cxc			bit,
    @Aplica			varchar(20),
    @AplicaID			varchar(20),
    @AplicaImporte		money,
    @ImportePendiente		money,
    @Vencimiento		datetime,
    @Saldo			money,
    @AplicaManual		bit,
    @VentaIdentificada		bit,
    
    @MovNota			char(20),
    @MovFactura			char(20),
    @MovCobro			char(20),
    @MovApertura		char(20),
    @MovIngreso			char(20),
    @MovEgreso			char(20),
    @MovRecoleccion		char(20),
    @MovFondoInicial		char(20),
    @MovDeposito		char(20),
    @MovSolicitudDeposito	char(20),
    @MovCheque			char(20),
    @MovFaltante		char(20),
    @MovSobrante		char(20),
    @MovRedondeo		char(20),
    @MovTransferencia		char(20),
    @MovInvFisico		char(20),
    @MovInvTransferencia	char(20),
    @MovAjuste			char(20),
    @MovPrestamoCxc		char(20),

    @FechaBanco			datetime,
    @ConceptoBanco		varchar(50),
    @CRAgente			bit,
    @CRMovVenta			varchar(20),
    @AlmacenOrigen		char(10),
    @AlmacenDestino		char(10),
    @SucursalCliente		char(10),
    @CFDSerie			varchar(20), --MEJORA3051
    @CFDFolio			varchar(20), --MEJORA3051
    @CFDReferencia		varchar(50)  --MEJORA3051
    
  -- Inicializar Variables
  SELECT @Cantidad		= 0,
         @Importe 		= 0.0,
         @Agente		= NULL,

         @Generar 		= 0,
         @GenerarAfectado	= 0,
         @IDGenerar		= NULL,
         @GenerarModulo		= NULL,
         @GenerarMovID	        = NULL,
         @GenerarMovTipo        = NULL,
         @GenerarEstatus 	= 'SINAFECTAR'

  SELECT @CfgCosteoNivelSubCuenta = CosteoNivelSubCuenta,
         @ClienteVMOS             = NULLIF(RTRIM(ClienteFacturaVMOS), ''),
         @TipoCosteo		  = ISNULL(NULLIF(RTRIM(UPPER(TipoCosteo)), ''), 'PROMEDIO'),
         @CfgImpInc 		  = VentaPreciosImpuestoIncluido,
         @CfgPrecioMoneda	  = VentaPrecioMoneda,
         @ConDesglose 		  = DineroDesgloseObligatorio,
         @CRAgente		  = ISNULL(CRAgente, 0),
         @CfgZonaImpuestoNivelCte = ISNULL(CRZonaImpuestoNivelCte, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa
  IF @ClienteVMOS IS NULL SELECT @Ok = 10580
  IF @CRAgente = 0 SELECT @Agente = @Cajero

  SELECT @CfgVentaMultiAlmacen = ISNULL(VentaMultiAlmacen, 0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT @MovNota         	= CRNota,
         @MovFactura      	= CRFactura,
         @MovCobro 		= CxcCobro,
         @MovApertura      	= CajaApertura,
         @MovIngreso       	= CajaIngreso,
         @MovEgreso        	= CajaEgreso,
         @MovRecoleccion   	= CajaRecoleccion,
         @MovDeposito      	= BancoDeposito,
         @MovSolicitudDeposito  = BancoSolicitudDeposito,
         @MovCheque        	= BancoCheque,
         @MovFaltante      	= CajaFaltanteCaja,
         @MovSobrante      	= CajaSobranteCaja,
         @MovRedondeo      	= DineroRedondeo,
         @MovFondoInicial  	= CajaFondoInicial,
         @MovTransferencia      = CajaTransferencia,
         @MovInvFisico		= InvFisico,
         @MovInvTransferencia	= InvTransferencia,
         @MovAjuste		= InvAjuste,
         @MovPrestamoCxc	= CRPrestamoCxc
    FROM EmpresaCfgMov 
   WHERE Empresa = @Empresa

/*  IF @Accion = 'AFECTAR' AND @MovTipo = 'CR.Z'
    IF (SELECT Clave FROM MovTipo WHERE Modulo = 'DIN' AND Mov = @MovDeposito) NOT IN ('DIN.D', 'DIN.SD') 
      SELECT @Ok = 35005, @OkRef = @MovDeposito*/

/* CREATE TABLE #DineroOrden (
	Orden		int		NOT NULL PRIMARY KEY,
	Mov		varchar(20)	NULL)*/

  CREATE TABLE #DineroD (
	Renglon		float		NULL,
	FormaPago	varchar(50)	COLLATE Database_Default NULL,
	Referencia	varchar(50)	COLLATE Database_Default NULL,
	Importe		money		NULL)

/*  INSERT #DineroOrden (Orden, Mov) VALUES (1, @MovApertura)
  INSERT #DineroOrden (Orden, Mov) VALUES (2, @MovIngreso)
  INSERT #DineroOrden (Orden, Mov) VALUES (3, @MovRecoleccion)
  INSERT #DineroOrden (Orden, Mov) VALUES (4, @MovFaltante)
  INSERT #DineroOrden (Orden, Mov) VALUES (5, @MovSobrante)
  INSERT #DineroOrden (Orden, Mov) VALUES (6, @MovCorte)
  INSERT #DineroOrden (Orden, Mov) VALUES (7, @MovTransferencia)
*/
  SELECT @AlmacenPrincipal = NULLIF(RTRIM(AlmacenPrincipal), ''),
         @SucursalCliente  = NULLIF(RTRIM(Cliente),'')
    FROM Sucursal 
   WHERE Sucursal = @Sucursal
  EXEC xpCRAlmacenPrincipal @ID, @AlmacenPrincipal OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @AlmacenPrincipal IS NULL AND @Ok IS NULL SELECT @Ok = 10570
  IF @CfgPrestamoCxc = 1 AND @SucursalCliente IS NULL AND @Ok IS NULL SELECT @Ok = 10581

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
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, @GenerarEstatus, 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT

    IF @@ERROR <> 0 SELECT @Ok = 1
--    IF @Ok IS NULL 
--      EXEC spCRCopiarDetalle @ID, @IDGenerar, @GenerarMovTipo, @Ok OUTPUT
 
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
    BEGIN
      IF (SELECT Sincro FROM Version) = 1
      BEGIN
        EXEC sp_executesql N'UPDATE CRVenta     SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
        EXEC sp_executesql N'UPDATE CRAgente    SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
        EXEC sp_executesql N'UPDATE CRCobro     SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
        EXEC sp_executesql N'UPDATE CRCaja      SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
        EXEC sp_executesql N'UPDATE CRInvFisico SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
        EXEC sp_executesql N'UPDATE CRTrans     SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
        EXEC sp_executesql N'UPDATE CRSoporte   SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
      END
    END

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @Accion = 'CANCELAR' AND @Ok IS NULL   
    BEGIN
      -- Cancelar Ventas 
      DECLARE crCancelarVentas CURSOR LOCAL STATIC FOR
       SELECT ID, Mov, MovID, Estatus
         FROM Venta
        WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
        ORDER BY ID DESC
      OPEN crCancelarVentas
      FETCH NEXT FROM crCancelarVentas INTO @VentaID, @VentaMov, @VentaMovID, @VentaEstatus
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
        BEGIN
          EXEC spInv @VentaID, 'VTAS', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                     @VentaMov, @VentaMovID OUTPUT, NULL, NULL,
                     @Ok OUTPUT, @OkRef OUTPUT, 0
          IF @Ok IS NULL
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'VTAS', @VentaID, @VentaMov, @VentaMovID, @Ok OUTPUT
          IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@OkRef) + ' - ' + RTRIM(@VentaMov) + ' ' + RTRIM(@VentaMovID)
        END
        FETCH NEXT FROM crCancelarVentas INTO @VentaID, @VentaMov, @VentaMovID, @VentaEstatus
      END  -- While
      CLOSE crCancelarVentas
      DEALLOCATE crCancelarVentas

      -- Cancelar Dinero
      DECLARE crCancelarDinero CURSOR LOCAL STATIC FOR
       SELECT ID, Mov, MovID
         FROM Dinero
        WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
        ORDER BY ID DESC
      OPEN crCancelarDinero
      FETCH NEXT FROM crCancelarDinero INTO @DineroID, @DineroMov, @DineroMovID
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
        BEGIN
          EXEC spDinero @DineroID, 'DIN', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                        @DineroMov OUTPUT, @DineroMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT
          IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@OkRef) + ' - ' + RTRIM(@DineroMov) + ' ' + RTRIM(@DineroMovID)
        END
        FETCH NEXT FROM crCancelarDinero INTO @DineroID, @DineroMov, @DineroMovID
      END  -- While
      CLOSE crCancelarDinero
      DEALLOCATE crCancelarDinero

      -- Cancelar Cxc
      DECLARE crCancelarCxc CURSOR LOCAL STATIC FOR
       SELECT ID, Mov, MovID
         FROM Cxc
        WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
        ORDER BY ID DESC
      OPEN crCancelarCxc
      FETCH NEXT FROM crCancelarCxc INTO @CxcID, @CxcMov, @CxcMovID
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
        BEGIN
          EXEC spCx @CxcID, 'CXC', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                    @CxcMov OUTPUT, @CxcMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'DIN', @CxcID, @CxcMov, @CxcMovID, @Ok OUTPUT
          IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@OkRef) + ' - ' + RTRIM(@CxcMov) + ' ' + RTRIM(@CxcMovID)
        END
        FETCH NEXT FROM crCancelarCxc INTO @CxcID, @CxcMov, @CxcMovID
      END  -- While
      CLOSE crCancelarCxc
      DEALLOCATE crCancelarCxc

      -- Cancelar Inv
      DECLARE crCancelarInv CURSOR LOCAL STATIC FOR
       SELECT i.ID, i.Mov, i.MovID, i.Estatus, mt.Clave
         FROM Inv i
         JOIN MovTipo mt ON mt.Modulo = 'INV' AND mt.Mov = i.Mov
        WHERE i.Empresa = @Empresa AND i.OrigenTipo = @Modulo AND i.Origen = @Mov AND i.OrigenID = @MovID AND i.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
        ORDER BY i.ID DESC
      OPEN crCancelarInv
      FETCH NEXT FROM crCancelarInv INTO @InvID, @InvMov, @InvMovID, @InvEstatus, @InvMovTipo
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
        BEGIN
          IF @InvMovTipo = 'INV.IF' AND @InvEstatus = 'CONCLUIDO'
          BEGIN 
            SELECT @InvID = NULL
            SELECT @InvID = ID, @InvMov = Mov, @InvMovID = MovID 
              FROM Inv 
             WHERE Empresa = @Empresa AND Origen = @InvMov AND OrigenID = @InvMovID AND Estatus IN ('CONCLUIDO', 'PENDIENTE')
          END

          IF @InvID IS NOT NULL
          BEGIN
            EXEC spInv @InvID, 'INV', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                       @InvMov, @InvMovID OUTPUT, NULL, NULL,
                       @Ok OUTPUT, @OkRef OUTPUT, 0
            IF @Ok IS NULL
              EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT
          END
          IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@OkRef) + ' - ' + RTRIM(@InvMov) + ' ' + RTRIM(@InvMovID)
        END
        FETCH NEXT FROM crCancelarInv INTO @InvID, @InvMov, @InvMovID, @InvEstatus, @InvMovTipo
      END  -- While
      CLOSE crCancelarInv
      DEALLOCATE crCancelarInv

      -- Cancelar Soporte
      DECLARE crCancelarSoporte CURSOR LOCAL STATIC FOR
       SELECT ID, Mov, MovID
         FROM Soporte
        WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
        ORDER BY ID DESC
      OPEN crCancelarSoporte
      FETCH NEXT FROM crCancelarSoporte INTO @SoporteID, @SoporteMov, @SoporteMovID
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
        BEGIN
          EXEC spSoporte @SoporteID, 'ST', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                         @SoporteMov, @SoporteMovID OUTPUT, NULL, NULL,
                         @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'ST', @SoporteID, @SoporteMov, @SoporteMovID, @Ok OUTPUT
          IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@OkRef) + ' - ' + RTRIM(@InvMov) + ' ' + RTRIM(@InvMovID)
        END
        FETCH NEXT FROM crCancelarSoporte INTO @SoporteID, @SoporteMov, @SoporteMovID
      END  -- While
      CLOSE crCancelarSoporte
      DEALLOCATE crCancelarSoporte
    END

    IF @Accion <> 'CANCELAR' AND @Ok IS NULL 
    BEGIN
      IF EXISTS(SELECT * FROM crVenta WHERE ID = @ID)
      BEGIN
        IF @CfgVentaMultiAlmacen = 1
          DECLARE crCRVenta CURSOR LOCAL STATIC FOR
           SELECT NULLIF(RTRIM(Cliente), ''), NULLIF(ClienteEnviarA, 0), CONVERT(varchar, NULL), NULLIF(RTRIM(Mov), ''), NULLIF(RTRIM(MovID), ''), Cxc, CFDSerie, CFDFolio --MEJORA3051
             FROM CRVenta
            WHERE ID = @ID AND NULLIF(Importe, 0) IS NOT NULL
            GROUP BY NULLIF(RTRIM(Cliente), ''), NULLIF(ClienteEnviarA, 0), NULLIF(RTRIM(Mov), ''), NULLIF(RTRIM(MovID), ''), Cxc, CFDSerie, CFDFolio --MEJORA3051
            ORDER BY NULLIF(RTRIM(Cliente), ''), NULLIF(ClienteEnviarA, 0), NULLIF(RTRIM(Mov), ''), NULLIF(RTRIM(MovID), ''), Cxc, CFDSerie, CFDFolio --MEJORA3051
        ELSE
          DECLARE crCRVenta CURSOR LOCAL STATIC FOR
           SELECT NULLIF(RTRIM(Cliente), ''), NULLIF(ClienteEnviarA, 0), Almacen, NULLIF(RTRIM(Mov), ''), NULLIF(RTRIM(MovID), ''), Cxc, CFDSerie, CFDFolio --MEJORA3051
             FROM CRVenta
            WHERE ID = @ID AND NULLIF(Importe, 0) IS NOT NULL
            GROUP BY NULLIF(RTRIM(Cliente), ''), NULLIF(ClienteEnviarA, 0), Almacen, NULLIF(RTRIM(Mov), ''), NULLIF(RTRIM(MovID), ''), Cxc, CFDSerie, CFDFolio --MEJORA3051
            ORDER BY NULLIF(RTRIM(Cliente), ''), NULLIF(ClienteEnviarA, 0), Almacen, NULLIF(RTRIM(Mov), ''), NULLIF(RTRIM(MovID), ''), Cxc, CFDSerie, CFDFolio --MEJORA3051

        OPEN crCRVenta
        FETCH NEXT FROM crCRVenta INTO @Cliente, @ClienteEnviarA, @Almacen, @VentaMov, @VentaMovID, @Cxc, @CFDSerie, @CFDFolio --MEJORA3051
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          SET @CFDReferencia = NULLIF(@CFDSerie,'') + NULLIF(@CFDFolio,'') --MEJORA3051        
          IF @@FETCH_STATUS <> -2 
          BEGIN           
            IF @VentaMov IS NULL
            BEGIN
              SELECT @VentaIdentificada = 0
              IF @Cxc = 1
                SELECT @VentaMov = @MovFactura
              ELSE
                SELECT @VentaMov = @MovNota
            END ELSE
              SELECT @VentaIdentificada = 1

            SELECT @Condicion = NULL
            SELECT @ZonaImpuesto = ZonaImpuesto FROM Sucursal WHERE Sucursal = @Sucursal
            IF @CfgZonaImpuestoNivelCte = 1
              SELECT @ZonaImpuesto = ISNULL(NULLIF(RTRIM(ZonaImpuesto), ''), @ZonaImpuesto) FROM Cte WHERE Cliente = @Cliente

            IF @Cliente IS NULL
              SELECT @ClienteNota = @ClienteVMOS
            ELSE BEGIN
              SELECT @ClienteNota = @Cliente
              SELECT @CRMovVenta = CRMovVenta, @Condicion = Condicion, @ZonaImpuesto = ISNULL(NULLIF(RTRIM(ZonaImpuesto), ''), @ZonaImpuesto)
                FROM Cte
               WHERE Cliente = @ClienteNota
              IF @Cxc = 1 AND @CRMovVenta <> '(Empresa)' 
              BEGIN
                 SELECT @VentaMov = @CRMovVenta
                 IF NULLIF(@VentaMov,'') IS NULL SELECT @OK = 55130, @OKref = 'Ventas Credito (CR) Cliente:'+@ClienteNota
              END
            END

            IF @Ok IS NULL
            BEGIN
              INSERT Venta (Sucursal,  Empresa,  Mov,       MovID,       FechaEmision,  Moneda,     TipoCambio,     Almacen,                                                Cliente,      EnviarA,         Concepto,  Condicion,  Agente,  Usuario,  Estatus,    OrigenTipo, Origen, OrigenID, UEN,  Proyecto,  CRCFDSerie, CRCFDFolio, Referencia) --MEJORA3051
                    VALUES (@Sucursal, @Empresa, @VentaMov, @VentaMovID, @FechaEmision, @MovMoneda, @MovTipoCambio, ISNULL(NULLIF(RTRIM(@Almacen), ''), @AlmacenPrincipal), @ClienteNota, @ClienteEnviarA, @Concepto, @Condicion, @Agente, @Usuario, 'BORRADOR', @Modulo,    @Mov,   @MovID,   @UEN, @Proyecto, @CFDSerie,  @CFDFolio,  @CFDReferencia) --MEJORA3051

              SELECT @VentaID = SCOPE_IDENTITY()
              SELECT @Renglon = 0.0, @RenglonID = 0

              IF @CfgVentaMultiAlmacen = 1 
              BEGIN
                IF @VentaIdentificada = 1
                  DECLARE crDetalleVenta CURSOR LOCAL STATIC FOR
                   SELECT crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, SUM(crv.Importe*(100.0/(100.0-ISNULL(crv.DescuentoLinea, 0.0)))), SUM(crv.Importe), ISNULL(NULLIF(SUM(crv.Cantidad), 0), 1.0)
                     FROM CRVenta crv, CR, Art a
                    WHERE cr.ID = @ID 
                      AND cr.ID = crv.ID
                      AND a.Articulo = crv.Articulo
                      /*AND ISNULL(crv.Almacen, '') = ISNULL(@Almacen, '') */
                      AND ISNULL(crv.Cliente, '') = ISNULL(@Cliente, '') 
                      AND ISNULL(crv.ClienteEnviarA, 0) = ISNULL(@ClienteEnviarA, 0) 
                      AND ISNULL(crv.Cxc, 0) = ISNULL(@Cxc, 0)
                      AND ISNULL(crv.Mov, '') = ISNULL(@VentaMov, '')
                      AND ISNULL(crv.MovID, '') = ISNULL(@VentaMovID, '')
                    GROUP BY crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescuentoLinea, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, crv.Precio
                    ORDER BY crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescuentoLinea, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, crv.Precio
                ELSE
                  DECLARE crDetalleVenta CURSOR LOCAL STATIC FOR
                   SELECT crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, SUM(crv.Importe*(100.0/(100.0-ISNULL(crv.DescuentoLinea, 0.0)))), SUM(crv.Importe), ISNULL(NULLIF(SUM(crv.Cantidad), 0), 1.0)
                     FROM CRVenta crv, CR, Art a
                    WHERE cr.ID = @ID 
                      AND cr.ID = crv.ID
                      AND a.Articulo = crv.Articulo
                      /*AND ISNULL(crv.Almacen, '') = ISNULL(@Almacen, '') */
                      AND ISNULL(crv.Cliente, '') = ISNULL(@Cliente, '') 
                      AND ISNULL(crv.ClienteEnviarA, 0) = ISNULL(@ClienteEnviarA, 0) 
                      AND ISNULL(crv.Cxc, 0) = ISNULL(@Cxc, 0)
                      AND crv.Mov IS NULL
                      AND crv.MovID IS NULL
                    GROUP BY crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescuentoLinea, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, crv.Precio
                    ORDER BY crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescuentoLinea, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, crv.Precio
              END ELSE
              BEGIN
                IF @VentaIdentificada = 1
                  DECLARE crDetalleVenta CURSOR LOCAL STATIC FOR
                   SELECT crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, SUM(crv.Importe*(100.0/(100.0-ISNULL(crv.DescuentoLinea, 0.0)))), SUM(crv.Importe), ISNULL(NULLIF(SUM(crv.Cantidad), 0), 1.0)
                     FROM CRVenta crv, CR, Art a
                    WHERE cr.ID = @ID 
                      AND cr.ID = crv.ID
                      AND a.Articulo = crv.Articulo
                      AND ISNULL(crv.Almacen, '') = ISNULL(@Almacen, '') 
                      AND ISNULL(crv.Cliente, '') = ISNULL(@Cliente, '') 
                      AND ISNULL(crv.ClienteEnviarA, 0) = ISNULL(@ClienteEnviarA, 0) 
                      AND ISNULL(crv.Cxc, 0) = ISNULL(@Cxc, 0)
                      AND ISNULL(crv.Mov, '') = ISNULL(@VentaMov, '')
                      AND ISNULL(crv.MovID, '') = ISNULL(@VentaMovID, '')
                    GROUP BY crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescuentoLinea, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, crv.Precio
                    ORDER BY crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescuentoLinea, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, crv.Precio
                ELSE
                  DECLARE crDetalleVenta CURSOR LOCAL STATIC FOR
                   SELECT crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, SUM(crv.Importe*(100.0/(100.0-ISNULL(crv.DescuentoLinea, 0.0)))), SUM(crv.Importe), ISNULL(NULLIF(SUM(crv.Cantidad), 0), 1.0)
                     FROM CRVenta crv, CR, Art a
                    WHERE cr.ID = @ID 
                      AND cr.ID = crv.ID
                      AND a.Articulo = crv.Articulo
                      AND ISNULL(crv.Almacen, '') = ISNULL(@Almacen, '') 
                      AND ISNULL(crv.Cliente, '') = ISNULL(@Cliente, '') 
                      AND ISNULL(crv.ClienteEnviarA, 0) = ISNULL(@ClienteEnviarA, 0) 
                      AND ISNULL(crv.Cxc, 0) = ISNULL(@Cxc, 0)
                      AND crv.Mov IS NULL
                      AND crv.MovID IS NULL
                    GROUP BY crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescuentoLinea, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, crv.Precio
                    ORDER BY crv.Almacen, crv.Articulo, crv.SubCuenta, crv.Posicion, crv.DescuentoLinea, crv.DescripcionExtra, ISNULL(a.Impuesto1, 0), ISNULL(a.Impuesto2, 0), ISNULL(a.Impuesto3, 0), a.Unidad, crv.Precio
              END
  
              OPEN crDetalleVenta
              FETCH NEXT FROM crDetalleVenta INTO @AlmacenD, @Articulo, @SubCuenta, @Posicion, @DescripcionExtra, @Impuesto1, @Impuesto2, @Impuesto3, @Unidad, @PrecioTotal, @Importe, @Cantidad
              WHILE @@FETCH_STATUS <> -1 
              BEGIN
                IF @@FETCH_STATUS <> -2 
                BEGIN
                  EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
                  EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
                  EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
		          EXEC spTipoImpuesto @Modulo, @VentaID, @VentaMov, @FechaEmision, @Empresa, @Sucursal, @Cliente, @ClienteEnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT

                  SELECT @Precio = CONVERT(float, @PrecioTotal) / NULLIF(@Cantidad, 0.0)
                  SELECT @DescuentoLinea = NULLIF((1.0-(CONVERT(float, @Importe)/NULLIF(CONVERT(float, @PrecioTotal), 0.0)))*100.0, 0)
                  --SELECT @JuntarImpuestos = ((100.0+@Impuesto2)*(1+((@Impuesto1+@Impuesto3)/100.0))-100.0)
                  SELECT @JuntarImpuestos = ((100.0+ISNULL(@Impuesto2,0.0))*(1+((ISNULL(@Impuesto1,0.0)+ISNULL(@Impuesto3,0.0))/100.0))-100.0)
                  IF @CfgImpInc = 0
                   SELECT @Precio = @Precio/(1+(@JuntarImpuestos/100.0))		
                  SELECT @Costo = NULL
                  
                  EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @MovMoneda, @MovTipoCambio, @Costo OUTPUT, 0, @Precio = @Precio
                  SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
                  INSERT VentaD (Sucursal,  ID,       Renglon,  RenglonSub, RenglonID,  Almacen,                                                 Posicion,  Articulo,  SubCuenta,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,  Cantidad,  CantidadInventario,  Precio,  Costo,  DescuentoLinea,  DescripcionExtra,  Agente,  UEN,  PrecioMoneda, PrecioTipoCambio)
                         VALUES (@Sucursal, @VentaID, @Renglon, 0,          @RenglonID, ISNULL(NULLIF(RTRIM(@AlmacenD), ''), @AlmacenPrincipal), @Posicion, @Articulo, @SubCuenta, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @Cantidad,           @Precio, @Costo, @DescuentoLinea, @DescripcionExtra, @Agente, @UEN, @MovMoneda,   @MovTipoCambio)

                END
                FETCH NEXT FROM crDetalleVenta INTO @AlmacenD, @Articulo, @SubCuenta, @Posicion, @DescripcionExtra, @Impuesto1, @Impuesto2, @Impuesto3, @Unidad, @PrecioTotal, @Importe, @Cantidad
              END -- While
              CLOSE crDetalleVenta
              DEALLOCATE crDetalleVenta
            END
    
            IF @Ok IS NULL
            BEGIN
              EXEC spInv @VentaID, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                         @VentaMov, @VentaMovID OUTPUT, NULL, NULL,
                         @Ok OUTPUT, @OkRef OUTPUT, 0
              IF @Ok IN (80030) SELECT @Ok = NULL, @OkRef = NULL
              EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'VTAS', @VentaID, @VentaMov, @VentaMovID, @Ok OUTPUT

              EXEC spCRCFDAfectar @Empresa, @Sucursal, @CFDSerie, @CFDFolio              
              
            END
          END
          FETCH NEXT FROM crCRVenta INTO @Cliente, @ClienteEnviarA, @Almacen, @VentaMov, @VentaMovID, @Cxc, @CFDSerie, @CFDFolio --MEJORA3051
        END -- While
        CLOSE crCRVenta
        DEALLOCATE crCRVenta
                
      END

      IF @Ok IS NULL
      BEGIN
        -- Cobros Tesoreria
        IF EXISTS(SELECT * FROM CRCobro WHERE ID = @ID AND NULLIF(Importe, 0) IS NOT NULL AND ISNULL(Cxc, 0) = 0)
        BEGIN
          DECLARE crCRCobro CURSOR LOCAL STATIC FOR
           SELECT Moneda, TipoCambio
             FROM CRCobro
            WHERE ID = @ID AND NULLIF(Importe, 0) IS NOT NULL AND ISNULL(Cxc, 0) = 0
            GROUP BY Moneda, TipoCambio
            ORDER BY Moneda, TipoCambio

          OPEN crCRCobro
          FETCH NEXT FROM crCRCobro INTO @Moneda, @TipoCambio
          WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
          BEGIN
            IF @@FETCH_STATUS <> -2 
            BEGIN
              IF @Ok IS NULL
              BEGIN
                INSERT Dinero (Sucursal,  SucursalOrigen, Empresa,   Mov,         FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,    CtaDinero,  Cajero,   ConDesglose,  UEN,  Proyecto,  OrigenTipo, Origen, OrigenID)
                       VALUES (@Sucursal, @Sucursal,      @Empresa,  @MovIngreso, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'BORRADOR', @Caja,      @Cajero,  1,            @UEN, @Proyecto, @Modulo,    @Mov,   @MovID)
                SELECT @DineroID = SCOPE_IDENTITY()

                TRUNCATE TABLE #DineroD
                INSERT #DineroD (FormaPago, Referencia, Importe)
                SELECT FormaPago, Referencia, SUM(Importe)
                  FROM CRCobro
                 WHERE ID = @ID AND Moneda = @Moneda AND TipoCambio = @TipoCambio AND ISNULL(Cxc, 0) = 0
                 GROUP BY FormaPago, Referencia
                HAVING NULLIF(SUM(Importe), 0.0) IS NOT NULL
                 ORDER BY FormaPago, Referencia
                
                EXEC xpCRAfectarCobro @ID, @Accion, @Moneda, @TipoCambio, @DineroID, @Ok OUTPUT, @OkRef OUTPUT

                IF EXISTS(SELECT * FROM #DineroD)
                BEGIN
                  SELECT @Renglon = 0.0
                  UPDATE #DineroD SET @Renglon = Renglon = ISNULL(Renglon, 0) + @Renglon + 2048.0
                  INSERT DineroD (Sucursal,  ID, Renglon, FormaPago, Referencia, Importe) 
                  SELECT @Sucursal,  @DineroID, Renglon, FormaPago, Referencia, Importe
                    FROM #DineroD
                END ELSE
                  DELETE Dinero WHERE ID = @DineroID
              END
            END
            FETCH NEXT FROM crCRCobro INTO @Moneda, @TipoCambio
          END -- While
          CLOSE crCRCobro
          DEALLOCATE crCRCobro
        END 

        -- Cobros Cxc
        IF EXISTS(SELECT * FROM CRCobro WHERE ID = @ID AND NULLIF(Importe, 0) IS NOT NULL AND ISNULL(Cxc, 0) = 1 AND NULLIF(RTRIM(Cliente), '') IS NOT NULL)
        BEGIN
          DECLARE crCRCobroCxc CURSOR LOCAL STATIC FOR
           SELECT Cliente, FormaPago, Referencia, Vencimiento, Moneda, TipoCambio, SUM(Importe)
             FROM CRCobro
            WHERE ID = @ID AND NULLIF(Importe, 0) IS NOT NULL AND ISNULL(Cxc, 0) = 1
            GROUP BY Cliente, FormaPago, Referencia, Vencimiento, Moneda, TipoCambio
            ORDER BY Cliente, FormaPago, Referencia, Vencimiento, Moneda, TipoCambio

          OPEN crCRCobroCxc
          FETCH NEXT FROM crCRCobroCxc INTO @Cliente, @FormaPago, @Referencia, @Vencimiento, @Moneda, @TipoCambio, @Importe
          WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
          BEGIN
            IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
            BEGIN
              SELECT @AplicaManual = 0, @Saldo = 0.0
              IF EXISTS(SELECT * FROM Cxc WHERE Empresa = @Empresa AND Cliente = @Cliente AND Moneda = @Moneda AND Estatus = 'PENDIENTE' AND ISNULL(Saldo, 0.0) > 0.0 AND (RTRIM(Mov)+' '+RTRIM(MovID) = @Referencia OR Vencimiento = @Vencimiento))
                SELECT @AplicaManual = 1
              INSERT Cxc (Sucursal,  SucursalOrigen, Cliente,  Empresa,   Mov,       FechaEmision,  FormaCobro, Importe,   Moneda,  TipoCambio,  ClienteMoneda,  ClienteTipoCambio,  Usuario,  Estatus,    CtaDinero,  Cajero,   UEN,  Proyecto,  OrigenTipo, Origen, OrigenID, AplicaManual)
                  VALUES (@Sucursal, @Sucursal,      @Cliente, @Empresa,  @MovCobro, @FechaEmision, @FormaPago, @Importe, @Moneda, @TipoCambio, @Moneda,        @TipoCambio,        @Usuario, 'BORRADOR', @Caja,      @Cajero,  @UEN, @Proyecto, @Modulo,    @Mov,   @MovID,   @AplicaManual)
              SELECT @CxcID = SCOPE_IDENTITY()

              IF @AplicaManual = 1
              BEGIN
                SELECT @ImportePendiente = @Importe, @Renglon = 0.0
                DECLARE crDetalleCobroCxc CURSOR LOCAL STATIC FOR 
                 SELECT Mov, MovID, ISNULL(Saldo, 0.0)
                   FROM Cxc
                  WHERE Empresa = @Empresa AND Cliente = @Cliente AND Moneda = @Moneda AND Estatus = 'PENDIENTE' AND ISNULL(Saldo, 0.0) > 0.0 AND RTRIM(Mov)+' '+RTRIM(MovID) = @Referencia
                OPEN crDetalleCobroCxc
                FETCH NEXT FROM crDetalleCobroCxc INTO @Aplica, @AplicaID, @Saldo
                WHILE @@FETCH_STATUS <> -1 AND ISNULL(@ImportePendiente, 0.0) > 0.0
                BEGIN
                  IF @@FETCH_STATUS <> -2 
                  BEGIN
                    IF @Saldo > @ImportePendiente SELECT @AplicaImporte = @ImportePendiente ELSE SELECT @AplicaImporte = @Saldo
                    SELECT @Renglon = @Renglon + 2048.0, @ImportePendiente = @ImportePendiente - @AplicaImporte
                    INSERT CxcD (Sucursal,  ID,     Renglon,  Aplica,  AplicaID,  Importe) 
                         VALUES (@Sucursal, @CxcID, @Renglon, @Aplica, @AplicaID, @AplicaImporte) 
                  END
                  FETCH NEXT FROM crDetalleCobroCxc INTO @Aplica, @AplicaID, @Saldo
                END -- While
                CLOSE crDetalleCobroCxc
                DEALLOCATE crDetalleCobroCxc

                IF @ImportePendiente > 0.0
                BEGIN
                  DECLARE crDetalleCobroCxcVence CURSOR LOCAL STATIC FOR 
                   SELECT Mov, MovID, ISNULL(Saldo, 0.0)
                     FROM Cxc
                    WHERE Empresa = @Empresa AND Cliente = @Cliente AND Moneda = @Moneda AND Estatus = 'PENDIENTE' AND ISNULL(Saldo, 0.0) > 0.0 AND Vencimiento = @Vencimiento
                  OPEN crDetalleCobroCxcVence
                  FETCH NEXT FROM crDetalleCobroCxcVence INTO @Aplica, @AplicaID, @Saldo
                  WHILE @@FETCH_STATUS <> -1 AND ISNULL(@ImportePendiente, 0.0) > 0.0
                  BEGIN
                    IF @@FETCH_STATUS <> -2 
                    BEGIN
                      IF NOT EXISTS(SELECT * FROM CxcD WHERE ID = @CxcID AND Aplica = @Aplica AND AplicaID = @AplicaID)
                      BEGIN
                        IF @Saldo > @ImportePendiente SELECT @AplicaImporte = @ImportePendiente ELSE SELECT @AplicaImporte = @Saldo
                        SELECT @Renglon = @Renglon + 2048.0, @ImportePendiente = @ImportePendiente - @AplicaImporte
                        INSERT CxcD (Sucursal,  ID,     Renglon,  Aplica,  AplicaID,  Importe) 
                             VALUES (@Sucursal, @CxcID, @Renglon, @Aplica, @AplicaID, @AplicaImporte) 
                      END
                    END
                    FETCH NEXT FROM crDetalleCobroCxcVence INTO @Aplica, @AplicaID, @Saldo
                  END -- While
                  CLOSE crDetalleCobroCxcVence
                  DEALLOCATE crDetalleCobroCxcVence
                END
              END 
            END
            FETCH NEXT FROM crCRCobroCxc INTO @Cliente, @FormaPago, @Referencia, @Vencimiento, @Moneda, @TipoCambio, @Importe
          END -- While
          CLOSE crCRCobroCxc
          DEALLOCATE crCRCobroCxc
        END 

        -- Movimientos Caja
        DECLARE crCRCaja CURSOR LOCAL STATIC FOR
         SELECT d.Movimiento, CASE WHEN @MovTipo = 'CR.C' THEN @FechaEmision ELSE d.FechaEmision END, d.Concepto, d.CtaDinero, d.Moneda, d.TipoCambio, d.FormaPago, d.Referencia, ISNULL(d.Importe, 0.0)
           FROM CRCaja d--, CRCajaMovimiento o
          WHERE d.ID = @ID --AND d.Movimiento = o.Movimiento
            --AND UPPER(d.Movimiento) <> 'APERTURA'
            AND NULLIF(d.Importe, 0.0) IS NOT NULL
            AND UPPER(d.Movimiento) NOT IN ('GASTO', 'DEVOLUCION GASTO', 'VENTA ANTICIPO') 
          --ORDER BY o.Orden

        OPEN crCRCaja
        FETCH NEXT FROM crCRCaja INTO @Movimiento, @FechaBanco, @ConceptoBanco, @CtaDinero, @Moneda, @TipoCambio, @FormaPago, @Referencia, @Importe
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 AND (UPPER(@Movimiento) <> 'PRESTAMO' OR @CfgPrestamoCxc = 0)
          BEGIN
            SELECT @DineroMov = NULL, @CtaOrigen = NULL, @CtaDestino = NULL
            IF UPPER(@Movimiento) = 'FONDO INICIAL' 	 SELECT @DineroMov = @MovFondoInicial, @CtaOrigen = @CtaDinero, @CtaDestino = @Caja      ELSE
            IF UPPER(@Movimiento) = 'RECOLECCION'   	 SELECT @DineroMov = @MovRecoleccion,  @CtaOrigen = @Caja,      @CtaDestino = @CtaDinero ELSE
            IF UPPER(@Movimiento) = 'FALTANTE'      	 SELECT @DineroMov = @MovFaltante,     @CtaOrigen = @Caja				 ELSE
            IF UPPER(@Movimiento) = 'SOBRANTE'      	 SELECT @DineroMov = @MovSobrante,     @CtaOrigen = @Caja				 ELSE
            IF UPPER(@Movimiento) = 'REDONDEO'      	 SELECT @DineroMov = @MovRedondeo,     @CtaOrigen = @Caja				 ELSE
            IF UPPER(@Movimiento) = 'DEPOSITO'      	 SELECT @DineroMov = @MovDeposito,     @CtaOrigen = @CtaDinero 			         ELSE
            IF UPPER(@Movimiento) = 'SOLICITUD DEPOSITO' SELECT @DineroMov = @MovSolicitudDeposito, @CtaOrigen = @CtaDinero 		  	 ELSE
            IF UPPER(@Movimiento) = 'INGRESO ANTICIPO'   SELECT @DineroMov = @MovIngreso,      @CtaOrigen = @CtaDinero 			         ELSE
            IF UPPER(@Movimiento) = 'EGRESO ANTICIPO'    SELECT @DineroMov = @MovEgreso,       @CtaOrigen = @CtaDinero 			         ELSE
            IF UPPER(@Movimiento) IN ('VENTA CREDITO', 'ANTICIPO GASTO', 'PRESTAMO') SELECT @DineroMov = @MovTransferencia, @CtaOrigen = @Caja, @CtaDestino = @CtaDinero ELSE
            IF UPPER(@Movimiento) IN ('COBRO CREDITO', 'DEV. ANTICIPO GASTO', 'DEVOLUCION PRESTAMO', 'APLICACION CREDITO') SELECT @DineroMov = @MovTransferencia, @CtaOrigen = @CtaDinero, @CtaDestino = @Caja 
/*          ELSE IF UPPER(@Movimiento) = 'APERTURA'      SELECT @DineroMov = @MovCheque,       @CtaDestino= @CtaDinero*/
            ELSE SELECT @Ok = 35005, @OkRef = @Movimiento

            IF @Ok IS NULL
            BEGIN
              INSERT Dinero (Sucursal,  SucursalOrigen, Empresa,   Mov,        FechaEmision,                       Concepto,       Moneda,  TipoCambio,  Usuario,  Estatus,    CtaDinero,   CtaDineroDestino,  Cajero,   ConDesglose,  UEN,  Proyecto,  OrigenTipo, Origen, OrigenID, Referencia,  FormaPago,  Importe)
                     VALUES (@Sucursal, @Sucursal,      @Empresa,  @DineroMov, ISNULL(@FechaBanco, @FechaEmision), @ConceptoBanco, @Moneda, @TipoCambio, @Usuario, 'BORRADOR', @CtaOrigen,  @CtaDestino,       @Cajero,  1,            @UEN, @Proyecto, @Modulo,    @Mov,   @MovID,   @Referencia, @FormaPago, @Importe)
              SELECT @DineroID = SCOPE_IDENTITY()
              INSERT DineroD (Sucursal,  ID,        Renglon, FormaPago,  Referencia,  Importe) 
                       VALUES(@Sucursal, @DineroID, 2048.0,  @FormaPago, @Referencia, @Importe)
            END           
          END
          FETCH NEXT FROM crCRCaja INTO @Movimiento, @FechaBanco, @ConceptoBanco, @CtaDinero, @Moneda, @TipoCambio, @FormaPago, @Referencia, @Importe
        END -- While
        CLOSE crCRCaja
        DEALLOCATE crCRCaja

        IF @CfgPrestamoCxc = 1
        BEGIN
          DECLARE crCRPrestamoCxc CURSOR LOCAL STATIC FOR
           SELECT Concepto, FormaPago, Referencia, Moneda, TipoCambio, Importe
             FROM CRCaja
            WHERE ID = @ID AND NULLIF(Importe, 0) IS NOT NULL AND UPPER(Movimiento) = 'PRESTAMO'

          OPEN crCRPrestamoCxc
          FETCH NEXT FROM crCRPrestamoCxc INTO @Concepto, @FormaPago, @Referencia, @Moneda, @TipoCambio, @Importe
          WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
          BEGIN
            IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
            BEGIN
              INSERT Cxc (Sucursal,  SucursalOrigen, Cliente,          Empresa,   Mov,             FechaEmision,  Referencia,  Concepto,  FormaCobro, Importe,   Moneda,  TipoCambio, ClienteMoneda,  ClienteTipoCambio,  Usuario,  Estatus,    CtaDinero,  Cajero,   UEN,  Proyecto,  OrigenTipo, Origen, OrigenID)
                  VALUES (@Sucursal, @Sucursal,      @SucursalCliente, @Empresa,  @MovPrestamoCxc, @FechaEmision, @Referencia, @Concepto, @FormaPago, @Importe, @Moneda, @TipoCambio, @Moneda,        @TipoCambio,        @Usuario, 'BORRADOR', @Caja,      @Cajero,  @UEN, @Proyecto, @Modulo,    @Mov,   @MovID)
            END
            FETCH NEXT FROM crCRPrestamoCxc INTO @Concepto, @FormaPago, @Referencia, @Moneda, @TipoCambio, @Importe
          END -- While
          CLOSE crCRPrestamoCxc
          DEALLOCATE crCRPrestamoCxc
        END

	-- Egreso
        DECLARE crCREgreso CURSOR LOCAL STATIC FOR
         SELECT d.Movimiento, d.CtaDinero, d.Moneda, d.TipoCambio
           FROM CRCaja d--, CRCajaMovimiento o
          WHERE d.ID = @ID --AND d.Movimiento = o.Movimiento
            AND UPPER(d.Movimiento) IN ('DEPOSITO', 'SOLICITUD DEPOSITO'/*, 'APERTURA'*/)
          GROUP BY /*o.Orden, */d.Movimiento, d.CtaDinero, d.Moneda, d.TipoCambio
          ORDER BY /*o.Orden, */d.Movimiento, d.CtaDinero, d.Moneda, d.TipoCambio

        OPEN crCREgreso
        FETCH NEXT FROM crCREgreso INTO @Movimiento, @CtaDinero, @Moneda, @TipoCambio
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            SELECT @DineroMov = NULL, @CtaOrigen = @Caja, @CtaDestino = NULL
            /*IF UPPER(@Movimiento) = 'APERTURA'
              SELECT @DineroMov = @MovIngreso
            ELSE*/
              SELECT @DineroMov = @MovEgreso

            IF @Ok IS NULL
            BEGIN
              INSERT Dinero (Sucursal,  SucursalOrigen, Empresa,   Mov,        FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,    CtaDinero,   CtaDineroDestino,  Cajero,   ConDesglose,  UEN,  Proyecto,  OrigenTipo, Origen, OrigenID)
                     VALUES (@Sucursal, @Sucursal,      @Empresa,  @DineroMov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'BORRADOR', @CtaOrigen,  @CtaDestino,       @Cajero,  1,            @UEN, @Proyecto, @Modulo,    @Mov,   @MovID)
              SELECT @DineroID = SCOPE_IDENTITY()

              TRUNCATE TABLE #DineroD
	      INSERT #DineroD (FormaPago, Referencia, Importe)
              SELECT FormaPago, Referencia, SUM(Importe)
                FROM CRCaja
               WHERE ID = @ID AND Movimiento = @Movimiento AND CtaDinero = @CtaDinero AND Moneda = @Moneda AND TipoCambio = @TipoCambio
               GROUP BY FormaPago, Referencia
              HAVING NULLIF(SUM(Importe), 0.0) IS NOT NULL
               ORDER BY FormaPago, Referencia

  	      SELECT @Renglon = 0.0
              UPDATE #DineroD SET @Renglon = Renglon = ISNULL(Renglon, 0) + @Renglon + 2048.0
              INSERT DineroD (Sucursal,  ID,        Renglon, FormaPago, Referencia, Importe) 
              SELECT @Sucursal,  @DineroID, Renglon, FormaPago, Referencia, Importe
                FROM #DineroD
            END
          END
          FETCH NEXT FROM crCREgreso INTO @Movimiento, @CtaDinero, @Moneda, @TipoCambio
        END -- While
        CLOSE crCREgreso
        DEALLOCATE crCREgreso

        -- Afectar Movimientos Tesoreria
        DECLARE crCRDinero CURSOR LOCAL /*STATIC*/ FOR
         SELECT d.ID, d.Mov, "Importe" = (SELECT SUM(Importe) FROM DineroD WHERE ID = d.ID)
           FROM Dinero d--, #DineroOrden do
          WHERE d.Empresa = @Empresa AND d.Estatus = 'BORRADOR' AND d.OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID 
           --AND do.Mov = d.Mov
          --ORDER BY do.Orden, d.ID
        OPEN crCRDinero
        FETCH NEXT FROM crCRDinero INTO @DineroID, @DineroMov, @Importe
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            UPDATE Dinero SET Importe = @Importe WHERE CURRENT OF crCRDinero
            EXEC spDinero @DineroID, 'DIN', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                          @DineroMov OUTPUT, @DineroMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
            IF @Ok IN (21010, 21020, 80030) SELECT @Ok = NULL, @OkRef = NULL
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT
          END
          FETCH NEXT FROM crCRDinero INTO @DineroID, @DineroMov, @Importe
        END -- While
        CLOSE crCRDinero
        DEALLOCATE crCRDinero

        -- Afectar Movimientos Cxc
        DECLARE crCRCxc CURSOR LOCAL STATIC FOR
         SELECT ID, Mov
           FROM Cxc
          WHERE Empresa = @Empresa AND Estatus = 'BORRADOR' AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID 
        OPEN crCRCxc
        FETCH NEXT FROM crCRCxc INTO @CxcID, @CxcMov
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            EXEC spCx @CxcID, 'CXC', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                      @CxcMov OUTPUT, @CxcMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
            IF @Ok IN (80030) SELECT @Ok = NULL, @OkRef = NULL
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'CXC', @CxcID, @CxcMov, @CxcMovID, @Ok OUTPUT
          END
          FETCH NEXT FROM crCRCxc INTO @CxcID, @CxcMov
        END -- While
        CLOSE crCRCxc
        DEALLOCATE crCRCxc
      END
    END

    -- Afectar o Cancelar Gastos
    IF EXISTS(SELECT * FROM CRCaja WHERE ID = @ID AND UPPER(Movimiento) = 'GASTO')
    BEGIN
      EXEC spGenerarGasto @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT, @CRMovimiento = 'Gasto'
      IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL, @OkRef = NULL
    END

    -- Afectar o Cancelar Devolucion Gastos
    IF EXISTS(SELECT * FROM CRCaja WHERE ID = @ID AND UPPER(Movimiento) = 'DEVOLUCION GASTO')
    BEGIN
      EXEC spGenerarGasto @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT, @CRMovimiento = 'Devolucion Gasto'
      IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL, @OkRef = NULL
    END

    IF @Accion <> 'CANCELAR' AND @Ok IS NULL   
    BEGIN
      -- Generar Inv Fisico
      IF EXISTS(SELECT * FROM CRInvFisico WHERE ID = @ID)
      BEGIN
        SELECT @InvMov = @MovInvFisico
        INSERT Inv (Sucursal,  SucursalOrigen, Empresa,   Mov,     FechaEmision,  Moneda,     TipoCambio,     Usuario,  Estatus,     Almacen,           UEN,  Proyecto,  OrigenTipo, Origen, OrigenID)
            VALUES (@Sucursal, @Sucursal,      @Empresa,  @InvMov, @FechaEmision, @MovMoneda, @MovTipoCambio, @Usuario, 'CONFIRMAR', @AlmacenPrincipal, @UEN, @Proyecto, @Modulo,    @Mov,   @MovID)
        SELECT @InvID = SCOPE_IDENTITY()
        INSERT InvD 
               (ID,    Renglon,   Articulo,   SubCuenta,   Cantidad,   Unidad,   Almacen,           Posicion)
        SELECT @InvID, m.Renglon, m.Articulo, m.SubCuenta, m.Cantidad, a.Unidad, @AlmacenPrincipal, m.Posicion
          FROM CRInvFisico m, Art a
         WHERE m.ID = @ID AND m.Articulo = a.Articulo

/*        EXEC spInv @InvID, 'INV', 'AFECTAR', 'TODO', @FechaRegistro, @MovAjuste, @Usuario, 1, 0, NULL,
                   @InvMov, @InvMovID OUTPUT, @AjusteID OUTPUT, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, 0
        IF @Ok IN (80030, 80070) SELECT @Ok = NULL, @OkRef = NULL
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT

        IF @AjusteID IS NOT NULL
          UPDATE Inv SET Estatus = 'CONFIRMAR' WHERE ID = @AjusteID*/
      END

      -- Generar Transferencia
      IF EXISTS(SELECT * FROM CRTrans WHERE ID = @ID)
      BEGIN
        DECLARE crCRTrans CURSOR LOCAL STATIC FOR
         SELECT NULLIF(RTRIM(AlmacenOrigen), ''), NULLIF(RTRIM(AlmacenDestino), '')
           FROM CRTrans
          WHERE ID = @ID
          GROUP BY AlmacenOrigen, AlmacenDestino
          ORDER BY AlmacenOrigen, AlmacenDestino
        OPEN crCRTrans
        FETCH NEXT FROM crCRTrans INTO @AlmacenOrigen, @AlmacenDestino
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
          BEGIN
            SELECT @InvMov = @MovInvTransferencia
            INSERT Inv (Sucursal,  SucursalOrigen, Empresa,   Mov,     FechaEmision,  Moneda,     TipoCambio,     Usuario,  Estatus,      Almacen,                                   AlmacenDestino,                             UEN,  Proyecto,  OrigenTipo, Origen, OrigenID)
                VALUES (@Sucursal, @Sucursal,      @Empresa,  @InvMov, @FechaEmision, @MovMoneda, @MovTipoCambio, @Usuario, 'SINAFECTAR', ISNULL(@AlmacenOrigen, @AlmacenPrincipal), ISNULL(@AlmacenDestino, @AlmacenPrincipal), @UEN, @Proyecto, @Modulo,    @Mov,   @MovID)
            SELECT @InvID = SCOPE_IDENTITY()
            INSERT InvD 
                   (ID,    Renglon,   Articulo,   SubCuenta,   Cantidad,   Unidad,   Almacen,                                   Posicion)
            SELECT @InvID, m.Renglon, m.Articulo, m.SubCuenta, m.Cantidad, a.Unidad, ISNULL(@AlmacenOrigen, @AlmacenPrincipal), m.Posicion
              FROM CRTrans m, Art a
             WHERE m.ID = @ID AND m.Articulo = a.Articulo

            EXEC spInv @InvID, 'INV', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                       @InvMov, @InvMovID OUTPUT, NULL, NULL,
                       @Ok OUTPUT, @OkRef OUTPUT, 0
            IF @Ok IN (80030) SELECT @Ok = NULL, @OkRef = NULL
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT
          END
          FETCH NEXT FROM crCRTrans INTO @AlmacenOrigen, @AlmacenDestino
        END  -- While
        CLOSE crCRTrans
        DEALLOCATE crCRTrans
      END

      -- Generar Movimientos Soporte
      IF EXISTS(SELECT * FROM CRSoporte WHERE ID = @ID)
      BEGIN
        DECLARE crCRSoporte CURSOR LOCAL STATIC FOR
         SELECT Renglon, Mov
           FROM CRSoporte
          WHERE ID = @ID
        OPEN crCRSoporte
        FETCH NEXT FROM crCRSoporte INTO @Renglon, @SoporteMov
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
          BEGIN
            SELECT @SoporteMovID = NULL
            INSERT Soporte 
                   (Sucursal, SucursalOrigen, Empresa,   Mov, Cliente, Titulo, Problema, Contacto, Telefono, FechaEmision,  Usuario,  Estatus,      UEN,  Proyecto,  OrigenTipo, Origen, OrigenID)
            SELECT @Sucursal, @Sucursal,      @Empresa,  Mov, Cliente, Titulo, Problema, Contacto, Telefono, @FechaEmision, @Usuario, 'SINAFECTAR', @UEN, @Proyecto, @Modulo,    @Mov,   @MovID
              FROM CRSoporte
             WHERE ID = @ID
            SELECT @SoporteID = SCOPE_IDENTITY()
            EXEC spSoporte @SoporteID, 'ST', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                           @SoporteMov, @SoporteMovID OUTPUT, NULL, NULL,
                           @Ok OUTPUT, @OkRef OUTPUT
            IF @Ok IN (80030) SELECT @Ok = NULL, @OkRef = NULL
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'ST', @SoporteID, @SoporteMov, @SoporteMovID, @Ok OUTPUT
          END
          FETCH NEXT FROM crCRSoporte INTO @Renglon, @SoporteMov
        END  -- While
        CLOSE crCRSoporte
        DEALLOCATE crCRSoporte
      END
    END

    -- Actualizar Movimiento
    IF @Ok IN (NULL, 80030)
    BEGIN
      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
      BEGIN
	IF @Estatus =  'SINAFECTAR' AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus <> 'SINAFECTAR' AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
      END  
      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE CR
         SET FechaConclusion  = @FechaConclusion, 
             FechaCancelacion = @FechaCancelacion,
             UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
             Estatus          = @EstatusNuevo,
             Situacion 	      = CASE WHEN @Estatus <> @EstatusNuevo THEN NULL ELSE Situacion END,
             GenerarPoliza    = @GenerarPoliza
       WHERE ID = @ID 
      IF @@ERROR <> 0 SELECT @Ok = 1
    END

    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC xpCRAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                       @FechaEmision, @FechaAfectacion, @FechaConclusion,
		       @UEN, @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones,
                       @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
                       @Caja, @Cajero, @Concepto, @Referencia, 
                       @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
		       @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                       @GenerarMov, @IDGenerar, @GenerarMovID,
                       @Ok OUTPUT, @OkRef OUTPUT

  -- Agregar a Estatus Log
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

  -- Cancelar el Flujo
  IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
    EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT 

--  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000  SELECT @Ok = 1 -- breakpoint

  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
    
  RETURN
END
GO

/**************** spCR ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCR') and type = 'P') drop procedure dbo.spCR
GO
CREATE PROCEDURE spCR
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
    @UEN		int,
    @Proyecto	      	varchar(50),
    @MovUsuario	      	char(10),
    @Autorizacion     	char(10),
    @DocFuente	      	int,
    @Observaciones    	varchar(255),
    @Estatus          	char(15),
    @EstatusNuevo	char(15),
    @Ejercicio	      	int,
    @Periodo	      	int,
    @Concepto		varchar(50),
    @Referencia  	varchar(50),

    @Caja		char(10),
    @Cajero		char(10),
    @CajaFolio		int,
    @CfgMaxCRZ		int,
    @CfgValidarCRCero	bit,
    @CfgValidarCRZCero	bit,
    @CfgValidarFolio	bit,
    @CfgPrestamoCxc	bit,

    @GenerarMovID	varchar(20),
    @GenerarPoliza	bit,
    @CfgContX		bit,
    @CfgContXGenerar	char(20)/*,
    @Verificar		bit*/

  -- Inicializar Variables
  SELECT @CfgContX        	= 0,
         @CfgContXGenerar 	= 'NO'/*,
	 @Verificar	  	= 1*/

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, 
         @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @UEN = UEN, @Proyecto = Proyecto,
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, 
         @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, 
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @Caja = NULLIF(RTRIM(Caja), ''), @Cajero = NULLIF(RTRIM(Cajero), ''), @CajaFolio = NULLIF(CajaFolio, 0),
         @Concepto = Concepto, @Referencia = Referencia, 
         @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion
    FROM CR
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT

  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
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
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO',  'PENDIENTE'))
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

    SELECT @CfgMaxCRZ         = CRCorteCajaCentralMax,
           @CfgValidarCRCero  = ISNULL(CRValidarCorteSaldoCero, 0),
           @CfgValidarCRZCero = ISNULL(CRValidarCorteZSaldoCero, 0),
           @CfgValidarFolio   = ISNULL(CRValidarFolio, 0),
           @CfgPrestamoCxc    = ISNULL(CRPrestamoCxc, 0)
      FROM EmpresaCfg
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @Accion = 'CANCELAR' 
      SELECT @EstatusNuevo = 'CANCELADO' 
    ELSE
      SELECT @EstatusNuevo = 'CONCLUIDO'

    -- Verificar antes de Afectar
    IF /*(@Conexion = 0 OR @Accion = 'CANCELAR') AND */@Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spCRVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                         @FechaEmision, @Estatus, 
			 @Caja, @Cajero, @CajaFolio,
   		         @Conexion, @SincroFinal, @Sucursal, 
			 @CfgMaxCRZ, @CfgValidarCRCero, @CfgValidarCRZCero, @CfgValidarFolio, @CfgPrestamoCxc,
		         @CfgContX, @CfgContXGenerar, @GenerarPoliza,
		         @Ok OUTPUT, @OkRef OUTPUT

      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END
    
    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR', 'CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
      EXEC spCRAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, 
                       @FechaEmision, @FechaAfectacion, @FechaConclusion,
		       @UEN, @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones,
                       @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
                       @Caja, @Cajero, @Concepto, @Referencia, @CfgPrestamoCxc, 
                       @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
		       @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                       @GenerarMov OUTPUT, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
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


PRINT "******************* SP CR ******************"
