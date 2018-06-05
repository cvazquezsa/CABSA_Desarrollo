SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/* SP CXC y CXP  */

-- CXC.F   = Factura		
-- CXC.FA  = Factura Anticipo
-- CXC.AF  = Anticipo Factura
-- CXC.CA  = Nota Cargo
-- CXC.CAD = Cargo Diverso
-- CXC.CAP = Prestamo
-- CXC.SD  = Solicitud Deposito
-- CXC.SCH = Solicitud Cheque
-- CXC.CD  = Cheque Devuelto
-- CXC.D   = Documento		
-- CXC.DA  = Documento Anticipo
-- CXC.C   = Cobro
-- CXC.NCP = Cobro Posfechado	Tipo Nota Credito
-- CXC.DP  = Cobro Posfechado	Tipo Documento
-- CXC.A   = Anticipo Pendiente
-- CXC.AA  = Anticipo Saldo
-- CXC.RA  = Reasigncion Anticipo
-- CXC.NC  = Nota Credito
-- CXC.NCD = Credito Diversof
-- CXC.ANC = Aplicacion N/Credito
-- CXC.ACA = Aplicacion N/Cargo
-- CXC.AE  = Aplicacion Efectivo	
-- CXC.DE  = Devolucion Efectivo
-- CXC.DI  = Devolucion Impuesto
-- CXC.DC  = Devolucion Credito
-- CXC.IM  = Intereses Moratorios
-- CXC.RM  = Refinanciamiento
-- CXC.AJE = Ajuste Saldo
-- CXC.AJR = Ajuste Redondeo
-- CXC.FAC = Reasignar Cargo (Endoso)
-- CXC.DAC = Reasignar Devolucion (Endoso)
-- CXC.AJM = Ajuste
-- CXC.AJA = Ajuste Aplicacion
-- CXC.NET = Neteo
-- CXC.VV  = Venta Vales
-- CXC.OV  = Obsequio Vales
-- CXC.AV  = Aplicacion Vales
-- CXC.DV  = Devolucion Vales
-- CXC.RE  = Reevaluacion
-- CXC.PR  = Presupuesto

-- CXP.F   = Entrada Compra
-- CXP.CA  = Nota Cargo		
-- CXP.CAD = Cargo Diverso		
-- CXP.CAP = Prestamo
-- CXP.CD  = Cheque Devuelto
-- CXP.D   = Documento		
-- CXP.DA  = Documento Anticipo
-- CXP.PAG = Pagare
-- CXP.FAC = Reasignar Cargo/Factoraje (Endoso)
-- CXP.DAC = Reasignar Devolucion (Endoso)
-- CXP.P   = Pago		
-- CXP.DP  = Pago Posfechado
-- CXP.NCP = Pago Posfechado
-- CXP.A   = Anticipo Pendiente
-- CXP.AA  = Anticipo Acumulado
-- CXP.RA  = Reasigncion Anticipo
-- CXP.NC  = Nota Credito
-- CXP.NCD = Credito Diverso
-- CXP.ANC = Aplicacion N/Credito
-- CXP.AE  = Aplicacion Efectivo	
-- CXP.DE  = Devolucion Efectivo	
-- CXP.DC  = Devolucion Credito
-- CXP.AJE = Ajuste Efectivo
-- CXP.AJR = Ajuste Redondeo
-- CXP.AJM = Ajuste
-- CXP.AJA = Ajuste Aplicacion
-- CXP.NET = Neteo
-- CXP.RE  = Reevaluacion
-- CXP.PR  = Presupuesto
-- CXP.SD  = Solicitud Deposito
-- CXP.SCH = Solicitud Cheque

-- AGENT.C = Comision
-- AGENT.C = Destajo
-- AGENT.D = Devolucion
-- AGENT.A = Anticipo
-- AGENT.P = Pago
-- AGENT.CO= Cobro

/************** spCxpSLCCalcularCorte *************/
if exists (select * from sysobjects where id = object_id('dbo.spCxpSLCCalcularCorte') and type = 'P') drop procedure dbo.spCxpSLCCalcularCorte
GO
CREATE PROCEDURE spCxpSLCCalcularCorte
		@Estacion				int,
        @ID						int,
        @IDGenerar				int,
        @FechaCorte				datetime,
        @CostoTotalMovimientos	float = NULL OUTPUT,
        @Ok						int = NULL OUTPUT,
        @OkRef					varchar(255) = NULL OUTPUT        
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Mov						varchar(20),
    @MovID						varchar(20),
    @MovImporteTotal			float,
    @MovTipo					varchar(20),
    @SubMovTipo					varchar(20),    
    @OModulo					varchar(5),
    @OModuloID					int,
    @OMov						varchar(20),
    @OMovTipo					varchar(20),
    @OSubMovTipo				varchar(20),
    @Empresa					varchar(5),
    @CantidadMovimientos		float,
    @CantidadSaldoInicial		float,    
    @CostoMovimientos			float,    
    @Articulo					varchar(20),
    @SubCuenta					varchar(50),
    @SerieLote					varchar(50),

    @ParticipacionSerieLote		float,
	@CantidadSerieLote			float,
	@ParticipacionMovimientos	float,
	@Origen						varchar(20),
	@OrigenID					varchar(20)
    

  SELECT
    @Origen = Origen,
    @OrigenID = OrigenID, 
    @Mov = Mov, 
    @MovID = MovID, 
    @Empresa = Empresa,
    @MovImporteTotal =  ISNULL(Importe,0.0) + ISNULL(Impuestos,0.0) - (ISNULL(Retencion,0.0)+ISNULL(Retencion2,0.0)+ISNULL(Retencion3,0.0))
    FROM Cxp WHERE ID = @ID
  
  SELECT @MovTipo = Clave, @SubMovTipo = SubClave FROM MovTipo WHERE Modulo = 'CXP' AND Mov = @Mov
  IF @MovTipo NOT IN ('CXP.F') OR @SubMovTipo NOT IN ('CXP.SLC') SELECT @Ok = 75510, @OkRef = ISNULL(@Mov,'') + ' ' + ISNULL(@MovID,'')
  
  IF @Ok IS NULL OR @Ok IN (80030)
  BEGIN
    EXEC spMovOrigen 'CXP', @ID, 0, @OModulo OUTPUT, @OModuloID OUTPUT  
    IF @OModulo = 'COMS'
    BEGIN
      SELECT @OMov = Mov FROM Compra WHERE ID = @OModuloID
      SELECT @OMovTipo = Clave, @OSubMovTipo = SubClave FROM MovTipo WHERE Modulo = 'COMS' AND Mov = @OMov 
      IF @OMovTipo NOT IN ('COMS.F') OR @OSubMovTipo NOT IN ('COMS.SLC') SELECT @Ok = 75500, @OkRef = ISNULL(@Mov,'') + ' ' + ISNULL(@MovID,'')
    END ELSE
    BEGIN
      SELECT @Ok = 75500, @OkRef = ISNULL(@Mov,'') + ' ' + ISNULL(@MovID,'')
    END  
  END

  IF NULLIF(@Ok,0) IS NULL OR @Ok IN (80030)
  BEGIN
    DELETE FROM SerieLoteConsignacionAuxTemp WHERE ModuloID = @IDGenerar AND Modulo = 'CXP' AND Estacion = @Estacion
    IF @@ERROR <> 0 SET @Ok = 1        
  END

  SET @CostoTotalMovimientos = 0.0
  DECLARE crSerieLoteMov CURSOR FOR
   SELECT slm.Articulo, ISNULL(slm.SubCuenta,''), slm.SerieLote, ISNULL(SUM(ISNULL(slm.Cantidad,0.0)),0.0)
     FROM SerieLoteMov slm JOIN CompraD cd
       ON cd.RenglonID = slm.RenglonID AND cd.ID = slm.ID AND slm.Modulo = 'COMS' AND slm.Empresa = @Empresa  
    WHERE slm.Modulo = @OModulo
      AND slm.ID = @OModuloID
    GROUP BY slm.SerieLote, ISNULL(slm.SubCuenta,''), slm.Articulo

  OPEN crSerieLoteMov
  FETCH NEXT FROM crSerieLoteMov INTO @Articulo, @SubCuenta, @SerieLote, @CantidadSerieLote
  WHILE @@FETCH_STATUS = 0 AND (@Ok IS NULL OR @Ok IN (80030))
  BEGIN

    INSERT SerieLoteConsignacionAuxTemp (Estacion,  Modulo, ModuloID,   Empresa, OModulo, OModuloID, Articulo, SubCuenta,  SerieLote, RIDOriginal, MModulo, MModuloID, Fecha, CargoU, AbonoU, CorteID, CorteIDAnterior)
                                 SELECT  @Estacion, 'CXP',  @IDGenerar, Empresa, OModulo, OModuloID, Articulo, SubCuenta,  SerieLote, RID,         Modulo,  ModuloID,  Fecha, CargoU, AbonoU, CorteID, CorteIDAnterior
                                   FROM  SerieLoteConsignacionAux
                                  WHERE  Fecha <= @FechaCorte
                                    AND SerieLote = @SerieLote
                                    AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'')
                                    AND Articulo = @Articulo
                                    AND OModuloID = @OModuloID
                                    AND OModulo = @OModulo
                                    AND Empresa = @Empresa
                                  
                                    
    SET @CantidadSaldoInicial = dbo.fnSerieLoteConsignacionSaldoInicial(@Estacion, 'CXP', @IDGenerar, @Empresa, @OModulo, @OModuloID, @Articulo, @SubCuenta, @SerieLote, @FechaCorte)     
    SET @CantidadMovimientos = dbo.fnSerieLoteConsignacionMovimientos(@Estacion, 'CXP', @IDGenerar, @Empresa, @OModulo, @OModuloID, @Articulo, @SubCuenta, @SerieLote, @FechaCorte)             
    --SET @CantidadMovimientos = @CantidadSaldoInicial - @CantidadMovimientos
    SET @ParticipacionSerieLote = dbo.fnSerieLoteConsignacionParticipacion(@Empresa, @OModuloID, @Articulo, @SubCuenta, @SerieLote)
    SET @ParticipacionMovimientos = (ISNULL(@CantidadMovimientos,0.0) / ISNULL(@CantidadSerieLote,0.0)) * ISNULL(@ParticipacionSerieLote,0.0)
    SET @CostoMovimientos = @MovImporteTotal * @ParticipacionMovimientos
    
    SET @CostoTotalMovimientos = @CostoTotalMovimientos + @CostoMovimientos
            
    FETCH NEXT FROM crSerieLoteMov INTO @Articulo, @SubCuenta, @SerieLote, @CantidadSerieLote
  END
  CLOSE crSerieLoteMov
  DEALLOCATE crSerieLoteMov

  IF @Ok IS NULL
  BEGIN
    UPDATE Cxp SET ConsignacionFechaCorte = @FechaCorte WHERE ID = @IDGenerar
    UPDATE CxpD 
       SET Importe = @CostoTotalMovimientos 
     WHERE ID = @IDGenerar
       AND Aplica = @Origen
       AND AplicaID = @OrigenID
  END
END
GO

/************** spCxpSLCCorte *************/
if exists (select * from sysobjects where id = object_id('dbo.spCxpSLCCorte') and type = 'P') drop procedure dbo.spCxpSLCCorte
GO
CREATE PROCEDURE spCxpSLCCorte
		@Estacion				int,
		@Modulo					varchar(20),
        @ID						int,
        @IDGenerar				int,
        @MovGenerar				varchar(20),
        @MovIDGenerar			varchar(20),
        @FechaCorte				datetime,
        @Accion					varchar(20),
        @Estatus				varchar(15),
        @EstatusNuevo			varchar(15),        
        @Ok						int OUTPUT,
        @OkRef					varchar(255) OUTPUT        
		
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CorteIDAnterior			int,
    @ImporteCorte				float,
    @OModulo					varchar(5),
    @OModuloID					int
      
  EXEC spMovOrigen @Modulo, @ID, 0, @OModulo OUTPUT, @OModuloID OUTPUT  
  IF @Accion IN ('AFECTAR') AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo IN ('PENDIENTE')
  BEGIN
    IF EXISTS(SELECT 1 FROM SerieLoteConsignacionAux WITH(UPDLOCK,ROWLOCK) WHERE OModulo = @OModulo AND OModuloID = @OModuloID)   
    BEGIN
      SELECT @CorteIDAnterior = dbo.fnSerieLoteConsignacionUltimoCorteTemp(@Estacion, @Modulo, @IDGenerar)    
      IF ISNULL(@CorteIDAnterior,0) = ISNULL(dbo.fnSerieLoteConsignacionUltimoCorte(@OModulo, @OModuloID),0) AND @Ok IS NULL
      BEGIN
        IF dbo.fnSerieLoteConsignacionCorteVerificado(@Estacion, @Modulo, @IDGenerar) = 1
        BEGIN
          UPDATE SerieLoteConsignacionAux
             SET CorteID = @IDGenerar,
                 CorteIDAnterior = @CorteIDAnterior
            FROM SerieLoteConsignacionAux slca JOIN SerieLoteConsignacionAuxTemp slcat
              ON slcat.RIDOriginal = slca.RID
           WHERE slcat.Estacion = @Estacion
             AND slcat.Modulo = @Modulo
             AND slcat.ModuloID = @IDGenerar    
             AND NULLIF(slcat.CorteID,0) IS NULL
        END ELSE SELECT @Ok = 75520     
      END ELSE SELECT @Ok = 75520
    END ELSE SELECT @Ok = 75520            
  END ELSE
  IF @Accion = 'CANCELAR' AND @Estatus IN ('PENDIENTE') AND @EstatusNuevo IN ('CANCELADO')
  BEGIN
    IF dbo.fnSerieLoteConsignacionUltimoCorte(@OModulo, @OModuloID) <> @IDGenerar SELECT @Ok = 75530, @OkRef =  ISNULL(@MovGenerar,'') + ' ' + ISNULL(@MovIDGenerar,'')

    IF @Ok IS NULL
    BEGIN
      IF EXISTS(SELECT 1 FROM SerieLoteConsignacionAux WITH(UPDLOCK,ROWLOCK) WHERE CorteID = @IDGenerar)
      BEGIN
        UPDATE SerieLoteConsignacionAux SET CorteID = NULL, CorteIDAnterior = NULL WHERE CorteID = @IDGenerar  
      END
    END
  END
END
GO

/**************** spCxGenerarComision ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxGenerarComision') and type = 'P') drop procedure dbo.spCxGenerarComision
GO             
CREATE PROCEDURE spCxGenerarComision
			@Sucursal		int, 
			@SucursalOrigen		int, 
			@SucursalDestino	int,
			@Accion			char(20), 
			@Empresa		char(5), 
			@Modulo			char(5),
			@IDAplica		int, 
			@AplicaMov		char(20), 
			@AplicaMovID		char(20), 
			@AplicaMovTipo		char(20), 
			@AplicaMoneda		char(10), 
			@AplicaTipoCambio	float,
			@FechaAfectacion	datetime, 
			@Proyecto		varchar(50), 
			@Usuario		char(10),  
			@FechaRegistro		datetime, 
			@Ejercicio		int, 
			@Periodo		int, 
			@Contacto		char(10), 
			@AplicaAgente		char(10), 
			@AplicaImporte		money, 
			@ImporteComision	money, 
			@CxModulo		char(5), 
			@CxMov			char(20), 
			@CxMovID		char(20), 
			@RedondeoMonetarios	int,
			@Ok 			int		OUTPUT, 
			@OkRef  		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @PrimeraVez		bit,
    @VentaID		int,
    @OrigenTipo		char(10),
    @Origen		char(20),
    @OrigenID		char(20),
    @ComisionTotal	money,
    @VentaAgente	char(10),
    @VentaComision	money,
    @Proporcion		float,
    @CxAgente		char(10),
    @CxImporte		money,
    @CxComision		money

  SELECT @PrimeraVez = 1
  SELECT @OrigenTipo = NULL, @ComisionTotal = NULL, @VentaAgente = NULL
  SELECT @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID FROM Cxc WHERE ID = @IDAplica
  IF @OrigenTipo = 'VTAS'
  BEGIN
    SELECT @VentaID = ID FROM Venta WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
    SELECT @ComisionTotal =  SUM(Comision) FROM VentaD WHERE ID = @VentaID
  END 

  DECLARE crVentaComision CURSOR FOR
   SELECT Agente, SUM(Comision) 
     FROM VentaD 
    WHERE ID = @VentaID AND NULLIF(RTRIM(Agente), '') IS NOT NULL
    GROUP BY Agente 

  OPEN crVentaComision
  FETCH NEXT FROM crVentaComision INTO @VentaAgente, @VentaComision
  WHILE @@FETCH_STATUS <> -1 OR @PrimeraVez = 1
  BEGIN     
    IF (@@FETCH_STATUS <> -2 OR @PrimeraVez = 1) AND @Ok IS NULL 
    BEGIN
      IF @VentaAgente IS NULL
        SELECT @CxAgente = @AplicaAgente, @CxImporte = @AplicaImporte, @CxComision = @ImporteComision
      ELSE BEGIN
        SELECT @Proporcion = ((@VentaComision * 100) / @ComisionTotal) / 100
        SELECT @CxAgente = @VentaAgente, @CxImporte = ROUND(CONVERT(money, @AplicaImporte * @Proporcion), @RedondeoMonetarios), @CxComision = ROUND(CONVERT(money, @ImporteComision * @Proporcion), @RedondeoMonetarios)
      END
      EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, 'AGENT', @Empresa, @Modulo, @IDAplica, @AplicaMov, @AplicaMovID, @AplicaMovTipo, @AplicaMoneda, @AplicaTipoCambio,
                       @FechaAfectacion, NULL, @Proyecto, @Usuario,  NULL, NULL, NULL, NULL,
                       @FechaRegistro, @Ejercicio, @Periodo, 
                       NULL, NULL, @Contacto, NULL, @CxAgente, NULL, NULL, NULL, 
	               @CxImporte, NULL, NULL, @CxComision, 
                       NULL, NULL, NULL, NULL, NULL, NULL,
                       @CxModulo, @CxMov, @CxMovID, @Ok OUTPUT, @OkRef  OUTPUT
      SELECT @PrimeraVez = 0
    END
    FETCH NEXT FROM crVentaComision INTO @VentaAgente, @VentaComision
  END -- While
  CLOSE crVentaComision
  DEALLOCATE crVentaComision

  RETURN
END
GO

/**************** spCxAplicarReevaluacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxAplicarReevaluacion') and type = 'P') drop procedure dbo.spCxAplicarReevaluacion
GO             
CREATE PROCEDURE spCxAplicarReevaluacion
                    @ID		  		int,
		    @Accion			char(20),
                    @Empresa			char(5),
		    @Usuario			char(10),
        	    @Modulo			char(5),
		    @Mov			char(20),
		    @MovID			varchar(20),
    		    @MovTipo   			char(20),
		    @Contacto			char(10),
                    @ContactoMoneda		char(10),
		    @ContactoTipoCambio		float,

		    @Ok 			int		OUTPUT, 
		    @OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoCambioLog	float,
    @Renglon		float, 
    @RenglonSub		int, 
    @AplicaID		int,
    @AplicaMov		char(20), 
    @AplicaMovID	varchar(20),
    @AplicaTipoCambio	float

  IF @Modulo = 'CXC' DECLARE crCxDetalle CURSOR LOCAL FOR SELECT Renglon, RenglonSub, Aplica, AplicaID FROM CxcD WHERE ID = @ID ELSE
  IF @Modulo = 'CXP' DECLARE crCxDetalle CURSOR LOCAL FOR SELECT Renglon, RenglonSub, Aplica, AplicaID FROM CxpD WHERE ID = @ID 

  OPEN crCxDetalle
  FETCH NEXT FROM crCxDetalle INTO @Renglon, @RenglonSub, @AplicaMov, @AplicaMovID
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN     
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @AplicaID = NULL 
      IF @Modulo = 'CXC' SELECT @AplicaID = ID, @AplicaTipoCambio = TipoCambio FROM Cxc WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus = 'PENDIENTE' AND Moneda = @ContactoMoneda AND Cliente   = @Contacto ELSE
      IF @Modulo = 'CXP' SELECT @AplicaID = ID, @AplicaTipoCambio = TipoCambio FROM Cxp WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus = 'PENDIENTE' AND Moneda = @ContactoMoneda AND Proveedor = @Contacto 
      IF @AplicaID IS NOT NULL 
      BEGIN
        IF @Accion = 'CANCELAR'
        BEGIN
          SELECT @TipoCambioLog = NULL
          SELECT @TipoCambioLog = TipoCambio
            FROM CxReevaluacionLog 
           WHERE Modulo = @Modulo AND ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
          IF @@ROWCOUNT > 0
          BEGIN
            IF @Modulo = 'CXC' UPDATE Cxc SET TipoCambio = @TipoCambioLog, ClienteTipoCambio   = CASE WHEN Moneda=ClienteMoneda   THEN @TipoCambioLog ELSE ClienteTipoCambio   END WHERE ID = @AplicaID ELSE
            IF @Modulo = 'CXP' UPDATE Cxp SET TipoCambio = @TipoCambioLog, ProveedorTipoCambio = CASE WHEN Moneda=ProveedorMoneda THEN @TipoCambioLog ELSE ProveedorTipoCambio END WHERE ID = @AplicaID 
          END ELSE
            SELECT @Ok = 10590
        END ELSE
        BEGIN
          IF @Modulo = 'CXC' UPDATE Cxc SET TipoCambio = @ContactoTipoCambio, ClienteTipoCambio   = CASE WHEN Moneda=ClienteMoneda   THEN @ContactoTipoCambio ELSE ClienteTipoCambio   END WHERE ID = @AplicaID ELSE
          IF @Modulo = 'CXP' UPDATE Cxp SET TipoCambio = @ContactoTipoCambio, ProveedorTipoCambio = CASE WHEN Moneda=ProveedorMoneda THEN @ContactoTipoCambio ELSE ProveedorTipoCambio END WHERE ID = @AplicaID 
          UPDATE CxReevaluacionLog 
             SET TipoCambio = @AplicaTipoCambio
           WHERE Modulo = @Modulo AND ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
          IF @@ROWCOUNT = 0 
            INSERT CxReevaluacionLog (Modulo, ID, Renglon, RenglonSub, TipoCambio) VALUES (@Modulo, @ID, @Renglon, @RenglonSub, @AplicaTipoCambio)
        END 
      END ELSE 
       SELECT @Ok = 30190
      IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@AplicaMov)+' '+RTRIM(@AplicaMovID)
    END
    FETCH NEXT FROM crCxDetalle INTO @Renglon, @RenglonSub, @AplicaMov, @AplicaMovID
  END -- While
  CLOSE crCxDetalle
  DEALLOCATE crCxDetalle
  RETURN
END
GO

/**************** spCxAplicarIntereses ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxAplicarIntereses') and type = 'P') drop procedure dbo.spCxAplicarIntereses
GO             
CREATE PROCEDURE spCxAplicarIntereses
                    @ID		  		int,
		    @Accion			char(20),
                    @Empresa			char(5),
		    @Usuario			char(10),
        	    @Modulo			char(5),
		    @Mov			char(20),
		    @MovID			varchar(20),
    		    @MovTipo   			char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @FechaEmision		datetime,

		    @Ok 			int		OUTPUT, 
		    @OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoCambioLog		float,
    @Renglon			float, 
    @RenglonSub			int, 
    @AplicaID			int,
    @AplicaMov			char(20), 
    @AplicaMovID		varchar(20),
    @AplicaTipoCambio		float, 
    @AplicaOrdinarios		money,
    @AplicaMoratorios		money,
    @AplicaRetencion		money,
    @AplicaLineaCredito		varchar(20),
    @AplicaCobroIntereses	varchar(20),
    @Ordinarios 			money,
    @Moratorios				money,
    @Retencion				money,
    @AplicaOrdinariosIVA	float, --MEJORA10041
    @AplicaMoratoriosIVA	float, --MEJORA10041    
    @OrdinariosIVA 			float, --MEJORA10041
    @MoratoriosIVA			float,  --MEJORA10041
    @EsInteresFijo			bit, --MEJORA10041
    @Sucursal				int,  --MEJORA10041
    @Rama					varchar(5), --MEJORA10041
    @SubMovTipo				varchar(20), --MEJORA10041
    @AplicaMoneda			varchar(10), --MEJORA10041
    @AplicaContacto			varchar(10), --MEJORA10041
    @InteresImporte			float, --MEJORA10041
    @IVAInteresImporte		float, --MEJORA10041    
    @EsCargo				bit,   --MEJORA10041
    @Ejercicio				int,   --MEJORA10041
    @Periodo				int    --MEJORA10041
    
  SELECT @SubMovTipo = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov --MEJORA10041
  IF @Movtipo = 'CXC.INT' AND @SubMovTipo = 'CXC.INM' --MEJORA10041
    SET @Rama = 'CIM' --MEJORA10041
  ELSE IF @Movtipo = 'CXC.INT' AND @SubMovTipo <> 'CXC.INM' --MEJORA10041
    SET @Rama = 'CIO' --MEJORA10041
  ELSE IF @Movtipo = 'CXP.INT' AND @SubMovTipo = 'CXP.INM' --MEJORA10041
    SET @Rama = 'PIM' --MEJORA10041
  ELSE IF @Movtipo = 'CXP.INT' AND @SubMovTipo <> 'CXP.INM' --MEJORA10041
    SET @Rama = 'PIO' --MEJORA10041
  ELSE --MEJORA10015
    SET @Rama = @Modulo --MEJORA10041
    

  IF @Modulo = 'CXC' SELECT @Ejercicio = Ejercicio, @Periodo = Periodo, @Sucursal = Sucursal, @EsInteresFijo = ISNULL(EsInteresFijo,0) FROM Cxc WHERE ID = @ID ELSE --MEJORA10041
  IF @Modulo = 'CXP' SELECT @Ejercicio = Ejercicio, @Periodo = Periodo, @Sucursal = Sucursal, @EsInteresFijo = ISNULL(EsInteresFijo,0) FROM Cxp WHERE ID = @ID      --MEJORA10041
        
  IF @Modulo = 'CXC' DECLARE crCxDetalle CURSOR LOCAL FOR SELECT Renglon, RenglonSub, Aplica, AplicaID, InteresesOrdinarios*@MovTipoCambio, InteresesMoratorios*@MovTipoCambio, CONVERT(money, NULL),     InteresesOrdinariosIVA*@MovTipoCambio, InteresesMoratoriosIVA*@MovTipoCambio FROM CxcD WHERE ID = @ID ELSE --MEJORA10041
  IF @Modulo = 'CXP' DECLARE crCxDetalle CURSOR LOCAL FOR SELECT Renglon, RenglonSub, Aplica, AplicaID, InteresesOrdinarios*@MovTipoCambio, InteresesMoratorios*@MovTipoCambio, Retencion*@MovTipoCambio, InteresesOrdinariosIVA*@MovTipoCambio, InteresesMoratoriosIVA*@MovTipoCambio FROM CxpD WHERE ID = @ID --MEJORA10041 

  OPEN crCxDetalle
  FETCH NEXT FROM crCxDetalle INTO @Renglon, @RenglonSub, @AplicaMov, @AplicaMovID, @AplicaOrdinarios, @AplicaMoratorios, @AplicaRetencion, @AplicaOrdinariosIVA, @AplicaMoratoriosIVA --MEJORA10041
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN     
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @AplicaID = NULL 
      IF @Modulo = 'CXC' SELECT @AplicaContacto = Cliente,   @AplicaID = ID, @AplicaMoneda = Moneda, @AplicaTipoCambio = TipoCambio, @AplicaLineaCredito = LineaCredito FROM Cxc WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus IN ('CONCLUIDO', 'PENDIENTE') ELSE
      IF @Modulo = 'CXP' SELECT @AplicaContacto = Proveedor, @AplicaID = ID, @AplicaMoneda = Moneda, @AplicaTipoCambio = TipoCambio, @AplicaLineaCredito = LineaCredito FROM Cxp WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus IN ('CONCLUIDO', 'PENDIENTE') 
      IF @AplicaID IS NOT NULL 
      BEGIN
        SELECT @Ordinarios  = ISNULL(@AplicaOrdinarios / @AplicaTipoCambio, 0.0), 
               @Moratorios = ISNULL(@AplicaMoratorios / @AplicaTipoCambio, 0.0),
               @Retencion = ISNULL(@AplicaRetencion / @AplicaTipoCambio, 0.0),
               @OrdinariosIVA = ISNULL(@AplicaOrdinariosIVA / @AplicaTipoCambio, 0.0), --MEJORA10041
               @MoratoriosIVA = ISNULL(@AplicaMoratoriosIVA / @AplicaTipoCambio, 0.0) --MEJORA10041

        SELECT @AplicaCobroIntereses = NULL
        SELECT @AplicaCobroIntereses = UPPER(CobroIntereses)
          FROM LC
         WHERE LineaCredito = @AplicaLineaCredito

        --MEJORA10041
        SET @EsCargo = 1 
        IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo
        
        SET @InteresImporte = ISNULL(@Ordinarios,0.0) + ISNULL(@Moratorios,0.0)
        SET @IVAInteresImporte = ISNULL(@OrdinariosIVA,0.0) + ISNULL(@MoratoriosIVA,0.0)
                
        --MEJORA10041
        --Intereses
        EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @Rama, @AplicaMoneda, @AplicaTipoCambio, @AplicaContacto, NULL, NULL, NULL, --MEJORA10041
                     @Modulo, @ID, @Mov, @MovID, @EsCargo, @InteresImporte, NULL, NULL,
                     @FechaEmision, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
  		     @Ok OUTPUT, @OkRef OUTPUT

        --MEJORA10041
        --IVA Intereses
        EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @Rama, @AplicaMoneda, @AplicaTipoCambio, @AplicaContacto, NULL, NULL, NULL, --MEJORA10041
                     @Modulo, @ID, @Mov, @MovID, @EsCargo, @IVAInteresImporte, NULL, NULL,
                     @FechaEmision, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
  		     @Ok OUTPUT, @OkRef OUTPUT

        IF @Accion = 'CANCELAR' SELECT @Ordinarios = -@Ordinarios, @Moratorios = -@Moratorios, @Retencion = -@Retencion, @OrdinariosIVA = -@OrdinariosIVA, @MoratoriosIVA = -@MoratoriosIVA --MEJORA10041
        IF @Ordinarios <> 0.0 OR @Moratorios <> 0.0 OR @OrdinariosIVA <> 0.0 OR @MoratoriosIVA <> 0.0 --MEJORA10041
        BEGIN
          IF @Modulo = 'CXC'
            UPDATE Cxc
               SET InteresesOrdinarios = NULLIF(ISNULL(InteresesOrdinarios, 0.0) + @Ordinarios, 0.0),
                   InteresesMoratorios = NULLIF(ISNULL(InteresesMoratorios, 0.0) + @Moratorios, 0.0),
                   InteresesOrdinariosIVA = NULLIF(ISNULL(InteresesOrdinariosIVA, 0.0) + @OrdinariosIVA, 0.0), --MEJORA10041
                   InteresesMoratoriosIVA = NULLIF(ISNULL(InteresesMoratoriosIVA, 0.0) + @MoratoriosIVA, 0.0), --MEJORA10041
		           SaldoInteresesOrdinarios = CASE WHEN @AplicaCobroIntereses = 'DEVENGADOS' OR @EsInteresFijo = 1 THEN NULLIF(ISNULL(SaldoInteresesOrdinarios, 0.0) + @Ordinarios, 0.0) ELSE SaldoInteresesOrdinarios END, --MEJORA10041
                   SaldoInteresesMoratorios = NULLIF(ISNULL(SaldoInteresesMoratorios, 0.0) + @Moratorios, 0.0),
		           SaldoInteresesOrdinariosIVA = CASE WHEN @AplicaCobroIntereses = 'DEVENGADOS' OR @EsInteresFijo = 1 THEN NULLIF(ISNULL(SaldoInteresesOrdinariosIVA, 0.0) + @OrdinariosIVA, 0.0) ELSE SaldoInteresesOrdinariosIVA END, --MEJORA10041
                   SaldoInteresesMoratoriosIVA = NULLIF(ISNULL(SaldoInteresesMoratoriosIVA, 0.0) + @MoratoriosIVA, 0.0) --MEJORA10041                   
             WHERE ID = @AplicaID
          ELSE
          IF @Modulo = 'CXP' 
            UPDATE Cxp
               SET InteresesOrdinarios = NULLIF(ISNULL(InteresesOrdinarios, 0.0) + @Ordinarios, 0.0),
                   InteresesMoratorios = NULLIF(ISNULL(InteresesMoratorios, 0.0) + @Moratorios, 0.0),
                   InteresesOrdinariosIVA = NULLIF(ISNULL(InteresesOrdinariosIVA, 0.0) + @OrdinariosIVA, 0.0), --MEJORA10041
                   InteresesMoratoriosIVA = NULLIF(ISNULL(InteresesMoratoriosIVA, 0.0) + @MoratoriosIVA, 0.0), --MEJORA10041                   
                   InteresesRetencion  = NULLIF(ISNULL(InteresesRetencion, 0.0)  + @Retencion, 0.0),
		           SaldoInteresesOrdinarios = CASE WHEN @AplicaCobroIntereses = 'DEVENGADOS'  OR @EsInteresFijo = 1 THEN NULLIF(ISNULL(SaldoInteresesOrdinarios, 0.0) + @Ordinarios, 0.0) ELSE SaldoInteresesOrdinarios END, --MEJORA10041
                   SaldoInteresesMoratorios = NULLIF(ISNULL(SaldoInteresesMoratorios, 0.0) + @Moratorios, 0.0),
		           SaldoInteresesOrdinariosIVA = CASE WHEN @AplicaCobroIntereses = 'DEVENGADOS'  OR @EsInteresFijo = 1 THEN NULLIF(ISNULL(SaldoInteresesOrdinariosIVA, 0.0) + @OrdinariosIVA, 0.0) ELSE SaldoInteresesOrdinariosIVA END, --MEJORA10041
                   SaldoInteresesMoratoriosIVA = NULLIF(ISNULL(SaldoInteresesMoratoriosIVA, 0.0) + @MoratoriosIVA, 0.0) --MEJORA10041
             WHERE ID = @AplicaID
        END
      END
    END
    FETCH NEXT FROM crCxDetalle INTO @Renglon, @RenglonSub, @AplicaMov, @AplicaMovID, @AplicaOrdinarios, @AplicaMoratorios, @AplicaRetencion, @AplicaOrdinariosIVA, @AplicaMoratoriosIVA --MEJORA10041
  END -- While
  CLOSE crCxDetalle
  DEALLOCATE crCxDetalle
  RETURN
END
GO

/**************** spCxAplicarIVADescuentoInflacion ****************/ --MEJORA10041
if exists (select * from sysobjects where id = object_id('dbo.spCxAplicarIVADescuentoInflacion') and type = 'P') drop procedure dbo.spCxAplicarIVADescuentoInflacion
GO             
CREATE PROCEDURE spCxAplicarIVADescuentoInflacion
                    @ID		  			int,
					@Accion				char(20),
                    @Empresa			char(5),
					@Usuario			char(10),
        			@Modulo				char(5),
					@Mov				char(20),
					@MovID				varchar(20),
					@MovTipo   			char(20),
					@MovMoneda			char(10),
					@MovTipoCambio		float,
					@FechaEmision		datetime,

					@Ok					int		OUTPUT, 
					@OkRef 				varchar(255)	OUTPUT
					
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoCambioLog						float,
    @Renglon							float, 
    @RenglonSub							int, 
    @AplicaID							int,
    @AplicaMov							char(20), 
    @AplicaMovID						varchar(20),
    @AplicaTipoCambio					float, 
    @AplicaOrdinariosIVAInflacion		float,
    @OrdinariosIVAInflacion 			float,
    @Sucursal							int,
    @Rama								varchar(5),
    @SubMovTipo							varchar(20),
    @AplicaMoneda						varchar(10),
    @AplicaContacto						varchar(10),
    @EsCargo							bit,
    @Ejercicio							int,
    @Periodo							int
    
  SELECT @SubMovTipo = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  IF @Movtipo = 'CXC.INT' AND @SubMovTipo = 'CXC.INM'
    SET @Rama = 'CIM'
  ELSE IF @Movtipo = 'CXC.INT' AND @SubMovTipo <> 'CXC.INM'
    SET @Rama = 'CIO'
  ELSE IF @Movtipo = 'CXP.INT' AND @SubMovTipo = 'CXP.INM'
    SET @Rama = 'PIM'
  ELSE IF @Movtipo = 'CXP.INT' AND @SubMovTipo <> 'CXP.INM'
    SET @Rama = 'PIO'
  ELSE
    SET @Rama = @Modulo
    

  IF @Modulo = 'CXC' SELECT @Ejercicio = Ejercicio, @Periodo = Periodo, @Sucursal = Sucursal FROM Cxc WHERE ID = @ID ELSE
  IF @Modulo = 'CXP' SELECT @Ejercicio = Ejercicio, @Periodo = Periodo, @Sucursal = Sucursal FROM Cxp WHERE ID = @ID     
    
  IF @Modulo = 'CXC' DECLARE crCxDetalle CURSOR LOCAL FOR SELECT Renglon, RenglonSub, Aplica, AplicaID, InteresesOrdinariosIVADescInfl*@MovTipoCambio FROM CxcD WHERE ID = @ID ELSE
  IF @Modulo = 'CXP' DECLARE crCxDetalle CURSOR LOCAL FOR SELECT Renglon, RenglonSub, Aplica, AplicaID, InteresesOrdinariosIVADescInfl*@MovTipoCambio FROM CxpD WHERE ID = @ID 

  OPEN crCxDetalle
  FETCH NEXT FROM crCxDetalle INTO @Renglon, @RenglonSub, @AplicaMov, @AplicaMovID, @AplicaOrdinariosIVAInflacion
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN     
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @AplicaID = NULL 
      IF @Modulo = 'CXC' SELECT @AplicaContacto = Cliente,   @AplicaID = ID, @AplicaMoneda = Moneda, @AplicaTipoCambio = TipoCambio FROM Cxc WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus IN ('CONCLUIDO', 'PENDIENTE') ELSE
      IF @Modulo = 'CXP' SELECT @AplicaContacto = Proveedor, @AplicaID = ID, @AplicaMoneda = Moneda, @AplicaTipoCambio = TipoCambio FROM Cxp WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus IN ('CONCLUIDO', 'PENDIENTE') 
      IF @AplicaID IS NOT NULL 
      BEGIN
        SELECT @OrdinariosIVAInflacion  = ISNULL(@AplicaOrdinariosIVAInflacion / @AplicaTipoCambio, 0.0)

        SET @EsCargo = 0 
        IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo
                        
        --IVA Inflacion
        EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @Rama, @AplicaMoneda, @AplicaTipoCambio, @AplicaContacto, NULL, NULL, NULL, --MEJORA10041
                     @Modulo, @ID, @Mov, @MovID, @EsCargo, @OrdinariosIVAInflacion, NULL, NULL,
                     @FechaEmision, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
  		     @Ok OUTPUT, @OkRef OUTPUT

        IF @Accion = 'AFECTAR' SET @OrdinariosIVAInflacion = -@OrdinariosIVAInflacion
        IF @OrdinariosIVAInflacion <> 0.0 
        BEGIN
          IF @Modulo = 'CXC' 
            UPDATE Cxc
               SET SaldoInteresesOrdinariosIVA = NULLIF(ISNULL(SaldoInteresesOrdinariosIVA, 0.0) + @OrdinariosIVAInflacion, 0.0)
             WHERE ID = @AplicaID 
          ELSE
          IF @Modulo = 'CXP' 
            UPDATE Cxp
               SET SaldoInteresesOrdinariosIVA = NULLIF(ISNULL(SaldoInteresesOrdinariosIVA, 0.0) + @OrdinariosIVAInflacion, 0.0)
             WHERE ID = @AplicaID 
        END
      END
    END
  FETCH NEXT FROM crCxDetalle INTO @Renglon, @RenglonSub, @AplicaMov, @AplicaMovID, @AplicaOrdinariosIVAInflacion --MEJORA10041
  END -- While
  CLOSE crCxDetalle
  DEALLOCATE crCxDetalle
  RETURN
END
GO

/**************** spCxFacturarIntereses ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxFacturarIntereses') and type = 'P') drop procedure dbo.spCxFacturarIntereses
GO             
CREATE PROCEDURE spCxFacturarIntereses
                    @ID		  		int,
		    @Accion			char(20),
                    @Empresa			char(5),
		    @Usuario			char(10),
        	    @Modulo			char(5),
		    @Mov			char(20),
		    @MovID			varchar(20),
    		    @MovTipo   			char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @Sucursal			int,
		    @Ok 			int		OUTPUT, 
		    @OkRef 			varchar(255)	OUTPUT
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @InteresesOrdinarios	money,
    @InteresesOrdinariosIVA float, --MEJORA10041    
    @QuitasOrdinarios		money,
    @QuitasOrdinariosIVA    float, --MEJORA10041    
    @InteresesMoratorios	money,
    @InteresesMoratoriosIVA	float, --MEJORA10041        
    @QuitasMoratorios		money,
    @QuitasMoratoriosIVA    float, --MEJORA10041        
    @FacturarInteresesAlCobro	bit,
    @InteresesMov		varchar(20),
    @InteresesConcepto		varchar(20),
    @MoratoriosMov		varchar(20),
    @MoratoriosConcepto		varchar(20),
    @BonificarQuitasAlCobro	bit,
    @QuitasMov			varchar(20),
    @QuitasConcepto		varchar(20),
    @QuitasMoraMov		varchar(20),
    @QuitasMoraConcepto		varchar(20),
    @FacturaID			int,
    @FacturaMov			varchar(20),
    @FacturaMovID		varchar(20),
    @FacturaConcepto		varchar(50),
    @FacturaImporte		money,
    @FacturaImpuestos	float --MEJORA10041    

  IF @Accion = 'CANCELAR'
  BEGIN
    IF @Modulo = 'CXC' 
      DECLARE crCancelarFacturarIntereses CURSOR LOCAL FOR 
       SELECT ID 
         FROM Cxc 
        WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('CONCLUIDO', 'PENDIENTE') 
    OPEN crCancelarFacturarIntereses
    FETCH NEXT FROM crCancelarFacturarIntereses INTO @FacturaID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spAfectar @Modulo, @FacturaID, @Accion, @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @FacturaID, @FacturaMov, @FacturaMovID, @Ok OUTPUT
      END
      FETCH NEXT FROM crCancelarFacturarIntereses INTO @FacturaID
    END
    CLOSE crCancelarFacturarIntereses
    DEALLOCATE crCancelarFacturarIntereses
  END ELSE
  IF @Modulo = 'CXC'
  BEGIN
    SELECT @FacturarInteresesAlCobro = ACFacturarInteresesAlCobro,
	   @InteresesMov = ACFacturarInteresesMov,
	   @InteresesConcepto = ACFacturarInteresesConcepto,
	   @MoratoriosMov = ACFacturarMoratoriosMov,
	   @MoratoriosConcepto = ACFacturarMoratoriosConcepto,
	   @BonificarQuitasAlCobro = ACBonificarQuitasAlCobro,
	   @QuitasMov = ACBonificarQuitasMov,
	   @QuitasConcepto = ACBonificarQuitasConcepto,
	   @QuitasMoraMov = ACBonificarQuitasMoraMov,
	   @QuitasMoraConcepto = ACBonificarQuitasMoraConcepto
      FROM EmpresaCfg
     WHERE Empresa = @Empresa
     
    SELECT @InteresesOrdinarios = SUM(InteresesOrdinarios), @InteresesOrdinariosIVA = SUM(ISNULL(InteresesOrdinariosIVA,0.0)), @QuitasOrdinarios = SUM(InteresesOrdinarios*InteresesOrdinariosQuita/100), @QuitasOrdinariosIVA = SUM(ISNULL(InteresesOrdinariosIVA,0.0)*ISNULL(InteresesOrdinariosQuita,0.0)/100), --MEJORA10041
           @InteresesMoratorios = SUM(InteresesMoratorios), @InteresesMoratoriosIVA = SUM(ISNULL(InteresesMoratoriosIVA,0.0)), @QuitasMoratorios = SUM(InteresesMoratorios*InteresesMoratoriosQuita/100), @QuitasMoratoriosIVA = SUM(ISNULL(InteresesMoratoriosIVA,0.0)*ISNULL(InteresesMoratoriosQuita,0.0)/100)  --MEJORA10041
      FROM CxcD
     WHERE ID = @ID

    -- Intereses Ordinarios
    IF (NULLIF(@InteresesOrdinarios, 0.0) IS NOT NULL OR NULLIF(@InteresesOrdinariosIVA, 0.0) IS NOT NULL) AND NULLIF(RTRIM(@InteresesMov), '') IS NOT NULL AND @FacturarInteresesAlCobro = 1 --MEJORA10041
    BEGIN
      SELECT @FacturaMov = @InteresesMov, @FacturaConcepto = @InteresesConcepto, @FacturaImporte = @InteresesOrdinarios, @FacturaImpuestos = @InteresesOrdinariosIVA --MEJORA10041
      INSERT Cxc (
      	     Mov,         Concepto,         Importe,         Impuestos,         Estatus,      OrigenTipo, Origen, OrigenID, Sucursal, Empresa, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio) --MEJORA10041
      SELECT @FacturaMov, @FacturaConcepto, @FacturaImporte, @FacturaImpuestos, 'SINAFECTAR', @Modulo,    @Mov,   @MovID,   Sucursal, Empresa, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio  --MEJORA10041
        FROM Cxc
       WHERE ID = @ID
      SELECT @FacturaID = SCOPE_IDENTITY()
      EXEC spAfectar @Modulo, @FacturaID, @Accion, @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok IS NULL
      BEGIN
      	SELECT @FacturaMovID = MovID FROM Cxc WHERE ID = @FacturaID
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @FacturaID, @FacturaMov, @FacturaMovID, @Ok OUTPUT
      END
    END

    -- Intereses Moratorios
    IF (NULLIF(@InteresesMoratorios, 0.0) IS NOT NULL OR NULLIF(@InteresesMoratoriosIVA, 0.0) IS NOT NULL) AND NULLIF(RTRIM(@MoratoriosMov), '') IS NOT NULL AND @FacturarInteresesAlCobro = 1 --MEJORA10041
    BEGIN
      SELECT @FacturaMov = @MoratoriosMov, @FacturaConcepto = @MoratoriosConcepto, @FacturaImporte = @InteresesMoratorios, @FacturaImpuestos = @InteresesMoratoriosIVA --MEJORA10041
      INSERT Cxc (
      	     Mov,         Concepto,         Importe,         Impuestos,         Estatus,     OrigenTipo, Origen, OrigenID, Sucursal, Empresa, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio) --MEJORA10041
      SELECT @FacturaMov, @FacturaConcepto, @FacturaImporte, @FacturaImpuestos, 'SINAFECTAR', @Modulo,    @Mov,   @MovID,   Sucursal, Empresa, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio --MEJORA10041
        FROM Cxc
       WHERE ID = @ID
      SELECT @FacturaID = SCOPE_IDENTITY()
      EXEC spAfectar @Modulo, @FacturaID, @Accion, @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok IS NULL
      BEGIN
      	SELECT @FacturaMovID = MovID FROM Cxc WHERE ID = @FacturaID
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @FacturaID, @FacturaMov, @FacturaMovID, @Ok OUTPUT
      END
    END

    -- Quitas Ordinarios
    IF (NULLIF(@QuitasOrdinarios, 0.0) IS NOT NULL OR NULLIF(@QuitasOrdinariosIVA, 0.0) IS NOT NULL) AND NULLIF(RTRIM(@QuitasMov), '') IS NOT NULL AND @BonificarQuitasAlCobro = 1 --MEJORA10041
    BEGIN
      SELECT @FacturaMov = @QuitasMov, @FacturaConcepto = @QuitasConcepto, @FacturaImporte = -@QuitasOrdinarios, @FacturaImpuestos = -@QuitasOrdinariosIVA --MEJORA10041
      INSERT Cxc (
      	     Mov,         Concepto,         Importe,         Impuestos,         Estatus,     OrigenTipo, Origen, OrigenID, Sucursal, Empresa, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio) --MEJORA10041
      SELECT @FacturaMov, @FacturaConcepto, @FacturaImporte, @FacturaImpuestos, 'SINAFECTAR', @Modulo,    @Mov,   @MovID,   Sucursal, Empresa, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio --MEJORA10041
        FROM Cxc
       WHERE ID = @ID
      SELECT @FacturaID = SCOPE_IDENTITY()
      EXEC spAfectar @Modulo, @FacturaID, @Accion, @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok IS NULL
      BEGIN
      	SELECT @FacturaMovID = MovID FROM Cxc WHERE ID = @FacturaID
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @FacturaID, @FacturaMov, @FacturaMovID, @Ok OUTPUT
      END
    END

    -- Quitas Moratorios
    IF (NULLIF(@QuitasMoratorios, 0.0) IS NOT NULL OR NULLIF(@QuitasMoratoriosIVA,0.0) IS NOT NULL) AND NULLIF(RTRIM(@QuitasMoraMov), '') IS NOT NULL AND @BonificarQuitasAlCobro = 1 --MEJORA10041
    BEGIN
      SELECT @FacturaMov = @QuitasMoraMov, @FacturaConcepto = @QuitasMoraConcepto, @FacturaImporte = -@QuitasMoratorios, @FacturaImpuestos = -@QuitasMoratoriosIVA --MEJORA10041
      INSERT Cxc (
      	     Mov,         Concepto,         Importe,         Impuestos,         Estatus,     OrigenTipo, Origen, OrigenID, Sucursal, Empresa, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio) --MEJORA10041
      SELECT @FacturaMov, @FacturaConcepto, @FacturaImporte, @FacturaImpuestos, 'SINAFECTAR', @Modulo,    @Mov,   @MovID,   Sucursal, Empresa, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio --MEJORA10041
        FROM Cxc
       WHERE ID = @ID
      SELECT @FacturaID = SCOPE_IDENTITY()
      EXEC spAfectar @Modulo, @FacturaID, @Accion, @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok IS NULL
      BEGIN
      	SELECT @FacturaMovID = MovID FROM Cxc WHERE ID = @FacturaID
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @FacturaID, @FacturaMov, @FacturaMovID, @Ok OUTPUT
      END
    END

  END		
  RETURN
END
GO

/*************** spGenerarRetencionMovImpuesto *******************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarRetencionMovImpuesto') and type = 'P') drop procedure dbo.spGenerarRetencionMovImpuesto
GO             
CREATE PROCEDURE spGenerarRetencionMovImpuesto
                    @Sucursal 			int, 
                    @SucursalOrigen 		int, 
                    @SucursalDestino 		int, 
                    @Accion 			varchar(20), 
                    @Empresa 			varchar(5), 
                    @Modulo 			varchar(5), 
                    @ID 			int, 
                    @movTipo 			varchar(20), 
                    @Mov 			varchar(20), 
                    @MovID 			varchar(20), 
                    @MovMoneda 			varchar(10), 
                    @MovTipoCambio 		float, 
                    @FechaEmision  		datetime, 
                    @Proyecto 			varchar(50), 
                    @Usuario 			varchar(10), 
                    @FechaRegistro 		datetime, 
                    @Ejercicio 			int, 
                    @Periodo 			int, 
                    @CfgRetencionMov		char(20),
    		    @CfgRetencionAcreedor	char(10),
    		    @CfgRetencionConcepto	varchar(50),
    		    @CfgRetencion2Acreedor	char(10),
    		    @CfgRetencion2Concepto	varchar(50),
    		    @CfgRetencion3Acreedor	char(10),
    		    @CfgRetencion3Concepto	varchar(50),
                    @Idaplica 			int,
                    @AplicaSaldoFactor 		float,
                    @RedondeoMonetarios 	float,
                    @Ok 			int 	     OUTPUT, 
                    @okRef 			varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
DECLARE
    @OrigenConcepto 		varchar(50), 
    @Retencion 			float, 
    @Retencion2 		float, 
    @Retencion3 		float, 
    @Subtotal 			money,
    @RetencionConcepto 		varchar(50),
    @Retencion2Concepto 	varchar(50),
    @Retencion3Concepto 	varchar(50),
    @CxModulo			char(5),
    @CxMov			char(20),
    @CxMovID			varchar(20),
    @CfgDevRetencionMov                 varchar(20),
	@Retencion2BaseImpuesto1		bit

  SELECT @Retencion2BaseImpuesto1 = ISNULL(Retencion2BaseImpuesto1,0) FROM Version                
  SELECT @CfgDevRetencionMov = CxpDevRetencion FROM EmpresaCfgMov WHERE Empresa = @Empresa

  DECLARE crMovRetencion CURSOR FOR
    SELECT OrigenConcepto, ISNULL(SubTotal*(Retencion1/100.0), 0.0), CASE WHEN @Retencion2BaseImpuesto1 = 0 THEN ISNULL(SubTotal*(Retencion2/100.0), 0.0) ELSE ISNULL(Importe1*(Retencion2/100.0), 0.0) END, ISNULL(SubTotal*(Retencion3/100.0),0.0)
      FROM MovImpuesto 
     WHERE Modulo = @Modulo AND ModuloId = @IDAplica AND OrigenConcepto IS NOT NULL
  OPEN crMovRetencion
  FETCH NEXT FROM crMovretencion INTO @OrigenConcepto, @Retencion, @Retencion2, @Retencion3
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Retencion < 0
        SELECT @Retencion  = @Retencion*-1, @CfgRetencionMov = @CfgDevRetencionMov
      IF @Retencion2 < 0
        SELECT @Retencion2 = @Retencion2*-1, @CfgRetencionMov = @CfgDevRetencionMov
      IF @Retencion3 < 0
        SELECT @Retencion3 = @Retencion3*-1, @CfgRetencionMov = @CfgDevRetencionMov

      EXEC spGastoConcepto @CfgRetencionConcepto,  @OrigenConcepto, @RetencionConcepto OUTPUT
      EXEC spGastoConcepto @CfgRetencion2Concepto, @OrigenConcepto, @Retencion2Concepto OUTPUT
      EXEC spGastoConcepto @CfgRetencion3Concepto, @OrigenConcepto, @Retencion3Concepto OUTPUT
      SELECT @Retencion  = ROUND(@Retencion  * @AplicaSaldoFactor, @RedondeoMonetarios),
             @Retencion2 = ROUND(@Retencion2 * @AplicaSaldoFactor, @RedondeoMonetarios),
             @Retencion3 = ROUND(@Retencion3 * @AplicaSaldoFactor, @RedondeoMonetarios)
      IF @Retencion <> 0.0 
      BEGIN
        IF @CfgRetencionAcreedor IS NULL 
          SELECT @Ok = 70100
        ELSE
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                           @FechaEmision, @RetencionConcepto, @Proyecto, @Usuario, NULL, NULL, NULL, NULL,
        	  	   @FechaRegistro, @Ejercicio, @Periodo,
            		   NULL, NULL, @CfgRetencionAcreedor, NULL, NULL, NULL, NULL, NULL,
                           @Retencion, NULL, NULL, NULL, 
                           NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		           @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP = 'RETENCION'
      END
      IF @Retencion2 <> 0.0 
      BEGIN
        IF @CfgRetencion2Acreedor IS NULL 
          SELECT @Ok = 70100
        ELSE
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                           @FechaEmision, @Retencion2Concepto, @Proyecto, @Usuario, NULL, NULL, NULL, NULL,
  	  	           @FechaRegistro, @Ejercicio, @Periodo,
            		   NULL, NULL, @CfgRetencion2Acreedor, NULL, NULL, NULL, NULL, NULL,
                           @Retencion2, NULL, NULL, NULL, 
                           NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		           @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP = 'RETENCION'
      END
      IF @Retencion3 <> 0.0 
      BEGIN
        IF @CfgRetencion3Acreedor IS NULL 
          SELECT @Ok = 70100
        ELSE
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                           @FechaEmision, @Retencion3Concepto, @Proyecto, @Usuario, NULL, NULL, NULL, NULL,
  	  	           @FechaRegistro, @Ejercicio, @Periodo,        
            		   NULL, NULL, @CfgRetencion3Acreedor, NULL, NULL, NULL, NULL, NULL,
                           @Retencion3, NULL, NULL, NULL, 
                           NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		           @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP = 'RETENCION'
      END

    END
    FETCH NEXT FROM crMovRetencion INTO @OrigenConcepto, @Retencion, @Retencion2, @Retencion3
  END
  CLOSE crMovRetencion
  DEALLOCATE crMovRetencion

  RETURN
END
GO

/**************** spCxAplicar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxAplicar') and type = 'P') drop procedure dbo.spCxAplicar
GO             
CREATE PROCEDURE spCxAplicar
                    @ID		  		int,
		    @Accion			char(20),
                    @Empresa			char(5),
		    @Usuario			char(10),
        	    @Modulo			char(5),
		    @Mov			char(20),
		    @MovID			varchar(20),
    		    @MovTipo   			char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		
		    @Referencia			varchar(50),
		    @Concepto			varchar(50),
		    @Proyecto			varchar(50),
    		    @Condicion			varchar(50) OUTPUT,
    		    @Vencimiento		datetime    OUTPUT,
                    @FechaEmision		datetime,
		    @FechaAfectacion		datetime,

		    @FechaRegistro		datetime, 
		    @Ejercicio			int, 
		    @Periodo			int,
		    @Contacto			char(10),
    		    @ContactoEnviarA		int,
                    @ContactoMoneda		char(10),
		    @ContactoFactor		float,
		    @ContactoTipoCambio		float,
		    @Agente			char(10),

		    @Importe			money,
                    @Impuestos			money,
 	  	    @Retencion			money,
 	  	    @Retencion2			money,
 	  	    @Retencion3			money,
		    @ImporteTotal		money,

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
		    @SucursalDestino		int,
		    @SucursalOrigen		int,

		    @OrigenTipo			char(10),
		    @OrigenMovTipo		char(20),
		    @MovAplica			char(20),
 		    @MovAplicaID		varchar(20),
		    @MovAplicaMovTipo		char(20),

		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @CfgEmbarcar		bit,
		    @AutoAjuste			money,
		    @AutoAjusteMov		money,
		    @CfgDescuentoRecargos	bit,
		    @CfgRefinanciamientoTasa 	float,
		    --@CfgControlEfectivo	bit,
		    --@TopeEfectivoAuto		money,
		    --@CfgComisionCreditoDiverso bit,
                    @CfgComisionCreditos	bit,
                    @CfgMovCargoDiverso		char(20),
                    @CfgMovCreditoDiverso	char(20),
		    @CfgVentaComisionesCobradas	bit,
		    @CfgComisionBase		char(20),

                    @CfgRetencionAlPago		bit,
                    @CfgRetencionMov		char(20),
    		    @CfgRetencionAcreedor	char(10),
    		    @CfgRetencionConcepto	varchar(50),
    		    @CfgRetencion2Acreedor	char(10),
    		    @CfgRetencion2Concepto	varchar(50),
    		    @CfgRetencion3Acreedor	char(10),
    		    @CfgRetencion3Concepto	varchar(50),
                    @CfgAC			bit,

		    @VerificarAplica		bit,
		    @TieneDescuentoRecargos	bit		OUTPUT,
		    @AplicaPosfechado		bit		OUTPUT,
		    @ImporteAplicado		money		OUTPUT,

		    @RedondeoMonetarios		int, 	
		    @Ok 			int		OUTPUT, 
		    @OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  -- SET nocount ON
  DECLARE
    @DiversoID			int,
    @DiversoMov			char(20),
    @DiversoMovID		varchar(20),
    @DiversoImporte		money,
    @DiversoSaldo		money,
    @IDGenerar			int,
    @EsCargo			bit,
    @RamaAfectar		char(5),
    @RamaEfectivo		char(5),
    @RamaRedondeo		char(5),
    @Abono			bit,
    @IDAplica			int,
    @IDOrigen			int,
    @IDMovAplica		int,
    @AplicaMov			char(20),
    @AplicaMovID		varchar(20),
    @ImporteAplicarFactor	int,
    @ImporteAplicar		money,
    @OrdinariosAplicar		money,
    @OrdinariosNetos		money,
    @OrdinariosIVAAplicar	float, --MEJORA10041
    @OrdinariosIVANetos		float, --MEJORA10041      
    @OtrosCargos		money,
    @MoratoriosAplicar		money,
    @MoratoriosNetos		money,
    @MoratoriosIVAAplicar	float, --MEJORA10041
    @MoratoriosIVANetos		float, --MEJORA10041     
    @ImporteNeto		money,
    @SumaImporteNeto		money,
    @Saldo			money,
    @SaldoCto			money,
    @AutoAjusteD		money,
    @Ligado			bit,
    @LigadoDR			bit,
    @Estatus			char(20),
    @ContactoImporte	 	money,
    @ContactoOrdinarios	 	money,
    @ContactoMoratorios 	money,
    @ContactoOrdinariosIVA	float, --MEJORA10041
    @ContactoMoratoriosIVA 	float, --MEJORA10041    
    @ImporteDetalle		money,
    @Renglon			float,
    @RenglonSub			float,
    @AplicaEstatus		char(15),
    @AplicaEstatusNuevo		char(15),
    @AplicaMovTipo		char(20),
    @AplicaMoneda		char(10),
    @AplicaTipoCambio		float,
    @AplicaContacto		char(10),
    @AplicaSaldo		money,
    @AplicaSaldoN		money,
    @AplicaSaldoOrdinarios	money,
    @AplicaSaldoOrdinariosN	money,
    @AplicaSaldoOrdinariosIVA	float, --BUG 13489
    @AplicaSaldoOrdinariosIVAN	float, --BUG 13489
    @AplicaSaldoMoratorios	money,
    @AplicaSaldoMoratoriosN	money,
    @AplicaSaldoMoratoriosIVA	float, --BUG 13489
    @AplicaSaldoMoratoriosIVAN	float, --BUG 13489
    @AplicaImporte		money,
    @AplicaImporteTotal		money,
    @AplicaImporteNeto		money,
    @AplicaComisionTotal	money,
    @AplicaComisionPendiente	money,
    @AplicaComisionPendienteN	money,
    @AplicaVencimiento		datetime,
    @AplicaFechaEmision		datetime,
    @AplicaFecha		datetime,
    @AplicaFechaAnterior	datetime,
    @AplicaAgente		char(10),
    @AplicaLineaCredito		varchar(20),
    @ImpuestoAdicional		float,
    @NuevoVencimiento		datetime,
    @AfectarComision		bit,
    @DescuentoRecargos		money,
    @ImporteComision		money,
    @CxModulo			char(5),
    @CxMov			char(20),
    @CxMovID			varchar(20),
    @AplicaSucursal		int,
    @AplicaDifID		int,
    @AplicaDifMov		char(20),
    @AplicaDifMovID		varchar(20),
    @AplicaDifMovTipo		char(20),
    @AplicaDifEnviarA		int,
    @AplicaDifConcepto		varchar(50),
    @AplicaDifReferencia	varchar(50),
    @AplicaDifImporte		money,
    @AplicaDifImporteCto	money,
    @AplicaDifImpuestos		money,
    @AplicaDifImpuestosCto	money,
    @AplicaDifImporteDetalle	money,
    @AplicaDifImporteDetalleCto	money,
    @AplicaDifEnRojo		bit,
    @AplicaSaldoFactor		float,
    @AplicaRetencionAlPago	bit,
    @AplicaRetencion		money,
    @AplicaRetencion2		money,
    @AplicaRetencion3		money,
    @AplicaConcepto		varchar(50),
    @AplicaOrigenTipo 		varchar(10), 
    @AplicaOrigen 		varchar(20), 
    @AplicaOrigenID		varchar(20), 
    @AplicaFactor		float,
    @RetencionConcepto		varchar(50),
    @Retencion2Concepto		varchar(50),
    @Retencion3Concepto		varchar(50),
    @IVA			float,   
    @DRID			int,
    @DRRenglon			float,
    @DRMov			char(20),
    @DRMovID			varchar(20),
    @DRAplica			char(20),
    @DRAplicaID			varchar(20),
    @DRConcepto			varchar(50),
    @DRImporte			money,
    @DRImpuestos		money,   
    @DRImporteTotal		money,
    @DREsCredito		bit,
    @MovDescuento		char(20),
    @MovRecargos		char(20),
    @ConceptoDescuento		varchar(50),
    @ConceptoRecargos		varchar(50),
    @UltimoVencimiento		datetime,
    @FechaConclusion		datetime,
    @EsReferencia			bit,
    @Peru				bit,
    @PPTO				bit,
    @CfgPeruRetenciones			bit,
    @CfgPeruRetencionesTopeExcento	money,
    @ContactoAfectar			char(10), 
    @Fiscal				bit,
    @FiscalGenerarRetenciones		bit,
    @CfgDevRetencionMov                 varchar(20),
    @RetencionAlPagoMovImpuesto         bit,
--JGD 11Abril2011 Ticket 3945
    @IDAgent						int,
    @IDAgentD						int,
    @AgentDevolucion				varchar(20),
    @IDAgentDev						int,
    @MovIDAgentDev					varchar(20),
    
    -- 9319
    @AplicaEjercicio				int,
    @AplicaPeriodo					int,
    -- 6024
    @NoAutoAjustar					bit,
    @RamaInteresOrdinario			varchar(5), --MEJORA10015
    @RamaInteresMoratorio			varchar(5),  --MEJORA10015    
    @SaldoInteresesOrdinarios		float, --MEJORA10041
--Fin JGD 11Abril2011 Ticket 3945
--23579
    @AplicaProyecto     varchar(50),
    @CP                 bit


--arcc
--set @ok = 1
--spAfectar 'CXC', 175, 'AFECTAR', 'Todo', NULL, 'DEMO', @Estacion=1
--select saldo,* from cxc order by id desc
  SELECT @RetencionAlPagoMovImpuesto = RetencionAlPagoMovImpuesto,
         @FiscalGenerarRetenciones     = ISNULL(FiscalGenerarRetenciones, 0)
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa
  SELECT @CfgDevRetencionMov = CxpDevRetencion FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @PPTO = PPTO, @Fiscal = ISNULL(Fiscal, 0), @CP = ISNULL(CP,0)  FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT @Peru = Peru FROM Version
    /*IF @Peru = 1
      SELECT @CfgPeruRetenciones            = ISNULL(PeruRetenciones, 0),
             @CfgPeruRetencionesTopeExcento = ISNULL(PeruRetencionesTopeExcento, 0)
        FROM EmpresaCfg2
       WHERE Empresa = @Empresa*/

  IF @VerificarAplica = 0
  BEGIN
    CREATE TABLE #CxAplicaMovImpuesto (
  	Renglon			float		NOT NULL,
	RenglonSub		int		NOT NULL,

	Impuesto1		float		NULL,
	Impuesto2		float		NULL,
	Impuesto3		float		NULL,
	Importe1		money		NULL,
	Importe2		money		NULL,
	Importe3		money		NULL,
	SubTotal		money		NULL,
        TipoImpuesto1		varchar(10)	COLLATE Database_Default NULL,
        TipoImpuesto2		varchar(10)	COLLATE Database_Default NULL,
        TipoImpuesto3		varchar(10)	COLLATE Database_Default NULL,
        TipoRetencion1		varchar(10)	COLLATE Database_Default NULL,
        TipoRetencion2		varchar(10)	COLLATE Database_Default NULL,
        TipoRetencion3		varchar(10)	COLLATE Database_Default NULL,
        LoteFijo		varchar(20)	COLLATE Database_Default NULL,
        OrigenModulo		varchar(5)	COLLATE Database_Default NULL,
	OrigenModuloID		int		NULL,
	OrigenConcepto		varchar(50)	COLLATE Database_Default NULL,
	OrigenDeducible		float		NULL	DEFAULT 100,
	OrigenFecha		datetime	NULL,
	Retencion1		float		NULL,
	Retencion2		float		NULL,
	Retencion3		float		NULL,
	Excento1		bit		NULL	DEFAULT 0,
	Excento2		bit		NULL	DEFAULT 0,
	Excento3		bit		NULL	DEFAULT 0,
	ContUso			varchar(20)	COLLATE Database_Default NULL,	
	ContUso2		varchar(20)	COLLATE Database_Default NULL,	
	ContUso3		varchar(20)	COLLATE Database_Default NULL,
	ClavePresupuestal		varchar(50)	COLLATE Database_Default NULL,
	ClavePresupuestalImpuesto1	varchar(50)	COLLATE Database_Default NULL,
	DescuentoGlobal		float		NULL		
    )

    IF @PPTO = 1
      CREATE TABLE #CxAplicaMovPresupuesto (
      	  Renglon		float		NOT NULL,
	  RenglonSub		int		NOT NULL,

  	  Importe		money		NULL,
          CuentaPresupuesto	varchar(20)	COLLATE Database_Default NULL)
  END

  SELECT @ContactoAfectar = @Contacto  

  SELECT @SumaImporteNeto = 0.0, @ImporteAplicado = 0.0, @TieneDescuentoRecargos = 0, @AplicaPosfechado = 0, @AfectarComision = 0, @UltimoVencimiento = NULL, @IDMovAplica = NULL
  IF @Modulo = 'CXC' SELECT @RamaEfectivo = 'CEFE', @RamaRedondeo = 'CRND' ELSE
  IF @Modulo = 'CXP' SELECT @RamaEfectivo = 'PEFE', @RamaRedondeo = 'PRND' 

  IF @MovAplica IS NOT NULL AND @MovAplicaID IS NOT NULL AND @MovAplicaMovTipo IS NOT NULL
  BEGIN
    IF @Modulo = 'CXC' SELECT @IDMovAplica = ID, @AplicaProyecto = NULLIF(Proyecto,'')  FROM Cxc WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
    IF @Modulo = 'CXP' SELECT @IDMovAplica = ID, @AplicaProyecto = NULLIF(Proyecto,'')  FROM Cxp WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') 
	IF  @CP = 1
      IF @Proyecto <> @AplicaProyecto
        SET @Ok = 70216    
  END

  IF @MovTipo NOT IN ('CXC.A', 'CXC.AR', 'CXC.AA', 'CXC.AF', 'CXP.A', 'CXP.AA', 'CXP.AF') OR @Accion = 'CANCELAR'
  BEGIN
    IF @Modulo = 'CXC' 
      DECLARE crCxDetalle CURSOR LOCAL
          FOR SELECT Renglon, RenglonSub, NULLIF(RTRIM(Aplica), ''), AplicaID, ISNULL(Importe, 0.0), 
                     ISNULL(InteresesOrdinarios, 0.0), ISNULL(InteresesOrdinarios*(1-(ISNULL(InteresesOrdinariosQuita, 0.0)/100)), 0.0), 
                     ISNULL(InteresesMoratorios, 0.0), ISNULL(InteresesMoratorios*(1-(ISNULL(InteresesMoratoriosQuita, 0.0)/100)), 0.0), 
                     ISNULL(ImpuestoAdicional, 0.0), ISNULL(OtrosCargos, 0.0), 
                     Fecha, FechaAnterior, ISNULL(DescuentoRecargos, 0.0), Ligado, LigadoDR, ISNULL(EsReferencia, 0), 
                     ISNULL(InteresesOrdinariosIVA, 0.0), ISNULL(InteresesOrdinariosIVA*(1-(ISNULL(InteresesOrdinariosQuita, 0.0)/100)), 0.0), --MEJORA10041 
                     ISNULL(InteresesMoratoriosIVA, 0.0), ISNULL(InteresesMoratoriosIVA*(1-(ISNULL(InteresesMoratoriosQuita, 0.0)/100)), 0.0)  --MEJORA10041
                FROM CxcD WHERE ID = @ID 
    ELSE
    IF @Modulo = 'CXP' 
      DECLARE crCxDetalle CURSOR LOCAL
          FOR SELECT Renglon, RenglonSub, NULLIF(RTRIM(Aplica), ''), AplicaID, ISNULL(Importe, 0.0), 
                     ISNULL(InteresesOrdinarios, 0.0), ISNULL(InteresesOrdinarios*(1-(ISNULL(InteresesOrdinariosQuita, 0.0)/100)), 0.0), 
                     ISNULL(InteresesMoratorios, 0.0), ISNULL(InteresesMoratorios*(1-(ISNULL(InteresesMoratoriosQuita, 0.0)/100)), 0.0), 
                     0.0, 0.0,
                     Fecha, FechaAnterior, ISNULL(DescuentoRecargos, 0.0), Ligado, LigadoDR, 0, 
                     ISNULL(InteresesOrdinariosIVA, 0.0), ISNULL(InteresesOrdinariosIVA*(1-(ISNULL(InteresesOrdinariosQuita, 0.0)/100)), 0.0), --MEJORA10041 
                     ISNULL(InteresesMoratoriosIVA, 0.0), ISNULL(InteresesMoratoriosIVA*(1-(ISNULL(InteresesMoratoriosQuita, 0.0)/100)), 0.0)  --MEJORA10041
                FROM CxpD WHERE ID = @ID 

    ELSE
    IF @Modulo = 'AGENT' 
      DECLARE crCxDetalle CURSOR LOCAL
          FOR SELECT Renglon, RenglonSub, NULLIF(RTRIM(Aplica), ''), AplicaID, ISNULL(Importe, 0.0), 
                     0.0, 0.0, 
                     0.0, 0.0,
                     0.0, 0.0,
                     GETDATE(), GETDATE(), 0.0, 0, 0, 0,
                     0.0,
                     0.0, 0.0, --MEJORA10041
                     0.0  --MEJORA10041 BUG13993
                FROM AgentD WHERE ID = @ID 

    OPEN crCxDetalle
    FETCH NEXT FROM crCxDetalle INTO @Renglon, @RenglonSub, @AplicaMov, @AplicaMovID, @ImporteAplicar, @OrdinariosAplicar, @OrdinariosNetos, @MoratoriosAplicar, @MoratoriosNetos, @ImpuestoAdicional, @OtrosCargos, @AplicaFecha, @AplicaFechaAnterior, @DescuentoRecargos, @Ligado, @LigadoDR, @EsReferencia, @OrdinariosIVAAplicar, @OrdinariosIVANetos, @MoratoriosIVAAplicar, @MoratoriosIVANetos --MEJORA10041
    IF @@ERROR <> 0 SELECT @Ok = 1
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @AplicaMov = @MovAplica AND @AplicaMovID = @MovAplicaID SELECT @Ok = 20180
      SELECT @AplicaMovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @AplicaMov

      IF @@FETCH_STATUS <> -2 AND (@ImporteAplicar <> 0.0 OR @OrdinariosAplicar <> 0.0 OR @MoratoriosAplicar <> 0.0 OR @OtrosCargos <> 0.0 OR @Modulo = 'AGENT') AND @Ok IS NULL --AND @LigadoDR = 0
      BEGIN
--ARCC
--SELECT 'ENTRO APLICAR'      
        SELECT @ImporteNeto = @ImporteAplicar + @DescuentoRecargos
        IF @DescuentoRecargos < 0.0 SELECT @ImporteAplicar = @ImporteAplicar + @DescuentoRecargos
        IF @AplicaMovTipo IN ('CXC.DP','CXP.DP') SELECT @AplicaPosfechado = 1

        -- Aplicar Negativos
        IF @MovTipo = 'AGENT.P'
        BEGIN
          IF @AplicaMovTipo IN ('AGENT.D', 'AGENT.A')
          BEGIN
            IF @ImporteAplicar > 0.0 SELECT @Ok = 30350
          END ELSE 
            IF @ImporteAplicar < 0.0 SELECT @Ok = 30351
        END ELSE
        IF @MovTipo = 'AGENT.CO'
        BEGIN
          IF @AplicaMovTipo IN ('AGENT.D', 'AGENT.A')
          BEGIN
            IF @ImporteAplicar < 0.0 SELECT @Ok = 30351
          END ELSE 
            IF @ImporteAplicar > 0.0 SELECT @Ok = 30350
        END 

        IF @VerificarAplica = 1 --OR @MovTipo IN ('CXC.DM', 'CXP.DM')
        BEGIN
          IF @Modulo = 'CXC'   SELECT @AplicaMoneda = ClienteMoneda, 	@AplicaSaldo = ISNULL(Saldo, 0.0), @AplicaSaldoOrdinarios = ISNULL(SaldoInteresesOrdinarios, 0.0), @AplicaSaldoOrdinariosIVA = ISNULL(SaldoInteresesOrdinariosIVA, 0.0), @AplicaSaldoMoratorios = ISNULL(SaldoInteresesMoratorios, 0.0), @AplicaSaldoMoratoriosIVA = ISNULL(SaldoInteresesMoratoriosIVA, 0.0), @AplicaContacto = Cliente,   @AplicaVencimiento = Vencimiento FROM Cxc WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO') ELSE --BUG 13489
          IF @Modulo = 'CXP'   SELECT @AplicaMoneda = ProveedorMoneda, 	@AplicaSaldo = ISNULL(Saldo, 0.0), @AplicaSaldoOrdinarios = ISNULL(SaldoInteresesOrdinarios, 0.0), @AplicaSaldoOrdinariosIVA = ISNULL(SaldoInteresesOrdinariosIVA, 0.0), @AplicaSaldoMoratorios = ISNULL(SaldoInteresesMoratorios, 0.0), @AplicaSaldoMoratoriosIVA = ISNULL(SaldoInteresesMoratoriosIVA, 0.0), @AplicaContacto = Proveedor, @AplicaVencimiento = Vencimiento FROM Cxp WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO') ELSE --BUG 13489
          IF @Modulo = 'AGENT' SELECT @AplicaMoneda = Moneda, 		@AplicaSaldo = ISNULL(Saldo, 0.0), @AplicaContacto = Agente FROM Agent WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO') 

          IF (@AplicaContacto <> @Contacto) OR (@AplicaMoneda <> @ContactoMoneda) SELECT @Ok = 30210
          --IF @Ok = 30210 AND @MovTipo IN ('CXC.DM', 'CXP.DM') SELECT @Ok = NULL, @ContactoAfectar = @AplicaContacto

          IF @UltimoVencimiento IS NULL OR @AplicaVencimiento > @UltimoVencimiento SELECT @UltimoVencimiento = @AplicaVencimiento

          IF @MovTipo = 'CXC.RM'
          BEGIN
            IF ROUND(@ImporteAplicar, @RedondeoMonetarios) <> ROUND(Convert(Money, @AplicaSaldo*DATEDIFF(day, @AplicaVencimiento, @AplicaFecha)*(@CfgRefinanciamientoTasa/100.0)), @RedondeoMonetarios)
              SELECT @Ok = 30240
          END
          IF @Modulo = 'CXC' AND @MovTipo = 'CXC.DC' AND @AplicaMovTipo NOT IN ('CXC.NC', 'CXC.NCD', 'CXC.DAC', 'CXC.NCF', 'CXC.DV', 'CXC.A', 'CXC.AR', 'CXC.DA') SELECT @Ok = 20180 ELSE
          IF @Modulo = 'CXP' AND @MovTipo = 'CXP.DC' AND @AplicaMovTipo NOT IN ('CXP.NC', 'CXP.NCD', 'CXP.DAC', 'CXP.NCF', 'CXP.A', 'CXP.DA') SELECT @Ok = 20180 
        END
  
        IF @DescuentoRecargos <> 0.0 
        BEGIN 
          IF @MovTipo IN ('CXC.C', 'CXC.D', 'CXC.DM', 'CXC.ANC', 'CXP.P', 'CXP.D', 'CXP.DM', 'CXP.PAG', 'CXP.ANC') AND @CfgDescuentoRecargos = 1 
          BEGIN
            SELECT @TieneDescuentoRecargos = 1 
          END ELSE SELECT @Ok = 30325
        END
        SELECT @ContactoImporte    = @ImporteAplicar / @ContactoFactor,
               @ContactoOrdinarios = @OrdinariosAplicar / @ContactoFactor,
               @ContactoOrdinariosIVA = @OrdinariosIVAAplicar / @ContactoFactor, --MEJORA10041
               @ContactoMoratorios = @MoratoriosAplicar / @ContactoFactor, 
               @ContactoMoratoriosIVA = @MoratoriosIVAAplicar / @ContactoFactor --MEJORA10041               

        IF UPPER(@AplicaMov) IN ('EFECTIVO A FAVOR', 'SALDO A FAVOR', 'REDONDEO', 'ANTICIPOS ACUMULADOS')
        BEGIN
          IF @MovTipo IN ('CXC.IM', 'CXC.RM') SELECT @Ok = 20180
          IF @VerificarAplica = 0
          BEGIN
            IF @MovTipo IN ('CXC.DA', 'CXC.DC', 'CXC.ACA', 'CXP.ACA', 'CXP.DA', 'CXP.DC') SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0
            IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo
            IF UPPER(@AplicaMov) = 'REDONDEO' SELECT @RamaAfectar = @RamaRedondeo ELSE SELECT @RamaAfectar = @RamaEfectivo
            EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @RamaAfectar, @ContactoMoneda, @ContactoTipoCambio, @ContactoAfectar, NULL, NULL, NULL,
                         @Modulo, @ID, @Mov, @MovID, @EsCargo, @ContactoImporte, NULL, NULL,
                         @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, NULL, 0, 0, 0,
                         @Ok OUTPUT, @OkRef OUTPUT
          END
        END ELSE
        BEGIN

          SELECT @AplicaSaldo = 0.0, @AplicaSaldoOrdinarios = 0.0, @AplicaSaldoOrdinariosIVA = 0.0, @AplicaSaldoMoratorios = 0.0, @AplicaSaldoMoratoriosIVA = 0.0, @AutoAjusteD = 0.0, @IDAplica = NULL, @AplicaImporteTotal = 0.0, --BUG 13489
                 @AplicaComisionTotal = 0.0, @AplicaComisionPendiente = 0.0,
		 @AplicaRetencionAlPago = 0, @AplicaRetencion = 0.0, @AplicaRetencion2 = 0.0, @AplicaRetencion3 = 0.0, @AplicaOrigenTipo = NULL, @AplicaOrigen = NULL, @AplicaOrigenID = NULL

          -- 9319
          IF @Modulo = 'CXC'   SELECT @IDAplica = ID, @AplicaEstatus = Estatus, @AplicaConcepto = Concepto, @AplicaSaldo = ISNULL(Saldo, 0.0), @AplicaSaldoOrdinarios = ISNULL(SaldoInteresesOrdinarios, 0.0), @AplicaSaldoOrdinariosIVA = ISNULL(SaldoInteresesOrdinariosIVA, 0.0), @AplicaSaldoMoratorios = ISNULL(InteresesMoratorios, 0.0), @AplicaSaldoMoratoriosIVA = ISNULL(InteresesMoratoriosIVA, 0.0), @AplicaImporte = ISNULL(Importe, 0.0), @AplicaImporteTotal = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0), @AutoAjusteD = ISNULL(AutoAjuste, 0.0), @AplicaMoneda = Moneda, @AplicaTipoCambio = TipoCambio, @AplicaFechaEmision = FechaEmision, @AplicaVencimiento = Vencimiento, @Estatus = Estatus, @AplicaOrigenTipo = OrigenTipo, @AplicaOrigen = Origen, @AplicaOrigenID = OrigenID, @AplicaLineaCredito = LineaCredito, @AplicaComisionTotal = ISNULL(ComisionTotal, 0.0), @AplicaComisionPendiente = ISNULL(ComisionPendiente, 0.0), @AplicaAgente = NULLIF(RTRIM(Agente), ''), @AplicaRetencion = ISNULL(Retencion, 0.0), @AplicaRetencion2 = ISNULL(Retencion2, 0.0), @AplicaRetencion3 = ISNULL(Retencion3, 0.0), @AplicaEjercicio = Ejercicio, @AplicaPeriodo = Periodo, @NoAutoAjustar = ISNULL(NoAutoAjustar ,0), @AplicaProyecto = NULLIF(Proyecto,'')  FROM Cxc WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE --MEJORA4648 --BUG 13489
          IF @Modulo = 'CXP'   SELECT @IDAplica = ID, @AplicaEstatus = Estatus, @AplicaConcepto = Concepto, @AplicaSaldo = ISNULL(Saldo, 0.0), @AplicaSaldoOrdinarios = ISNULL(SaldoInteresesOrdinarios, 0.0), @AplicaSaldoOrdinariosIVA = ISNULL(SaldoInteresesOrdinariosIVA, 0.0), @AplicaSaldoMoratorios = ISNULL(InteresesMoratorios, 0.0), @AplicaSaldoMoratoriosIVA = ISNULL(InteresesMoratoriosIVA, 0.0), @AplicaImporte = ISNULL(Importe, 0.0), @AplicaImporteTotal = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0), @AutoAjusteD = ISNULL(AutoAjuste, 0.0), @AplicaMoneda = Moneda, @AplicaTipoCambio = TipoCambio, @AplicaFechaEmision = FechaEmision, @AplicaVencimiento = Vencimiento, @Estatus = Estatus, @AplicaOrigenTipo = OrigenTipo, @AplicaOrigen = Origen, @AplicaOrigenID = OrigenID, @AplicaLineaCredito = LineaCredito, @AplicaRetencionAlPago = ISNULL(RetencionAlPago, 0), @AplicaRetencion = ISNULL(Retencion, 0.0), @AplicaRetencion2 = ISNULL(Retencion2, 0.0), @AplicaRetencion3 = ISNULL(Retencion3, 0.0), @AplicaEjercicio = Ejercicio, @AplicaPeriodo = Periodo, @NoAutoAjustar = ISNULL(NoAutoAjustar ,0), @AplicaProyecto = NULLIF(Proyecto,'')  FROM Cxp WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') --BUG 13489
          IF @Modulo = 'AGENT' SELECT @IDAplica = ID, @AplicaEstatus = Estatus, @AplicaConcepto = Concepto, @AplicaSaldo = ISNULL(Saldo, 0.0), @AplicaImporte = ISNULL(Importe, 0.0), @AplicaImporteTotal = ISNULL(Importe, 0.0), @AutoAjusteD = ISNULL(AutoAjuste, 0.0), @AplicaMoneda = Moneda, @AplicaTipoCambio = TipoCambio, @AplicaFechaEmision = FechaEmision, @Estatus = Estatus, @AplicaEjercicio = Ejercicio, @AplicaPeriodo = Periodo FROM Agent WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CANCELADO') 
          IF @@ERROR <> 0 SELECT @Ok = 1
          SELECT @AplicaImporteNeto = @AplicaImporteTotal - @AplicaRetencion - @AplicaRetencion2 - @AplicaRetencion3
		  IF  @CP = 1
            IF @Proyecto <> @AplicaProyecto AND @Modulo IN('CXC','CXP') 
              SET @Ok = 70216


          IF @Ok IS NULL AND @Accion <> 'CANCELAR'
            EXEC spValidarFechaAplicacion @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @Ejercicio, @Periodo,  
								          @AplicaMov, @AplicaMovID, @Modulo, @IDAplica, @AplicaFechaEmision, @AplicaEjercicio, @AplicaPeriodo, @Ok = @Ok OUTPUT,
								          @OkRef = @OkRef OUTPUT
          IF @Ok IS NULL AND @Accion <> 'CANCELAR'
            EXEC spEmpresaValidarFechaAplicacion @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @Ejercicio, @Periodo,  
								                 @AplicaMov, @AplicaMovID, @Modulo, @IDAplica, @AplicaFechaEmision, @AplicaEjercicio, @AplicaPeriodo, @Ok = @Ok OUTPUT,
								                 @OkRef = @OkRef OUTPUT

--JGD 31Marzo2011 Solucion Ticket 4239
--          SELECT @AplicaFactor = (@ImporteAplicar * @MovTipoCambio) / NULLIF(CONVERT(float, @AplicaImporteNeto * @AplicaTipoCambio), 0)
          IF (@MovMoneda <> @AplicaMoneda)
            SELECT @AplicaFactor = (@ImporteAplicar * @MovTipoCambio) / NULLIF(CONVERT(float, @AplicaImporteNeto * @AplicaTipoCambio), 0)
          ELSE
            SELECT @AplicaFactor = @ImporteAplicar/ NULLIF(CONVERT(float, @AplicaImporteNeto), 0)
--Fin JGD 31Marzo2011 Solucion Ticket 4239

          IF @MovMoneda <> @AplicaMoneda 
            SELECT @AplicaFactor = @AplicaFactor / @MovTipoCambio * @AplicaTipoCambio

          IF @VerificarAplica = 1
          BEGIN
            EXEC spAplicaOk @Empresa, @Usuario, @Modulo, @IDAplica, @Ok OUTPUT, @OkRef OUTPUT, @AplicaSucursal OUTPUT
            IF @MovTipo = 'CXC.AR'
            BEGIN
              IF @AplicaSucursal = @SucursalDestino SELECT @Ok = NULL, @OkRef = NULL ELSE SELECT @Ok = 60300 
            END
            IF @IDMovAplica IS NOT NULL AND @Ok IS NULL
              EXEC spAplicaOk @Empresa, @Usuario, @Modulo, @IDMovAplica, @Ok OUTPUT, @OkRef OUTPUT, @AplicaSucursal OUTPUT
          END

          -- si no encontro el registro
          IF @IDAplica IS NULL AND @EsReferencia = 0 SELECT @Ok = 30120
          IF @Accion NOT IN ('CANCELAR', 'GENERAR')
          BEGIN
            IF @MovTipo IN ('CXC.AJA', 'CXP.AJA')
            BEGIN
              IF @Estatus NOT IN ('PENDIENTE', 'CONCLUIDO') SELECT @Ok = 30060
            END ELSE
            BEGIN
              IF @Estatus <> 'PENDIENTE' SELECT @Ok = 30060
              --IF (ABS(@AplicaSaldo*ISNULL(@AplicaFactor,1)) - ABS(@ContactoImporte) <= -@AutoAjuste) AND @Ligado = 0 AND @MovTipo NOT IN ('CXC.IM','CXC.RM') SELECT @Ok = 30070
                            IF (ABS(@AplicaSaldo) - ABS(@ContactoImporte) <= -@AutoAjuste) AND @Ligado = 0 AND @MovTipo NOT IN ('CXC.IM','CXC.RM') SELECT @Ok = 30070
              IF @CfgAC = 1
              BEGIN
                IF (@AplicaSaldoOrdinarios - @ContactoOrdinarios <= -@AutoAjuste) AND @Ligado = 0 AND (SELECT UPPER(CobroIntereses) FROM LC WHERE LineaCredito = @AplicaLineaCredito) = 'DEVENGADOS' SELECT @Ok = 30071
                IF (@AplicaSaldoOrdinariosIVA - @ContactoOrdinariosIVA <= -@AutoAjuste) AND @Ligado = 0 AND (SELECT UPPER(CobroIntereses) FROM LC WHERE LineaCredito = @AplicaLineaCredito) = 'DEVENGADOS' SELECT @Ok = 30071 --BUG 13489
                IF (@AplicaSaldoMoratorios - @ContactoMoratorios <= -@AutoAjuste) AND @Ligado = 0 SELECT @Ok = 30072
                IF (@AplicaSaldoMoratoriosIVA - @ContactoMoratoriosIVA <= -@AutoAjuste) AND @Ligado = 0 SELECT @Ok = 30072 --BUG 13489
              END
            END
          END
          IF @Ok IS NULL
          BEGIN
            
            IF @VerificarAplica = 0 AND @EsReferencia = 0
            BEGIN
            
              IF @MovTipo IN ('CXC.IM', 'CXC.RM') 
              BEGIN
                IF @MovTipo = 'CXC.IM' SELECT @NuevoVencimiento = @FechaAfectacion ELSE
                IF @MovTipo = 'CXC.RM' SELECT @NuevoVencimiento = @AplicaFecha
                IF @Accion = 'CANCELAR' 
                   SELECT @NuevoVencimiento = @AplicaFechaAnterior
                ELSE 
                  UPDATE CxcD SET FechaAnterior = @AplicaVencimiento WHERE CURRENT OF crCxDetalle

                UPDATE Cxc SET Condicion = '(Fecha)', Vencimiento = @NuevoVencimiento WHERE ID = @IDAplica 
              END ELSE
              BEGIN
              
                IF @Accion <> 'CANCELAR' SELECT @EsCargo = 0, @ImporteDetalle = - @ContactoImporte ELSE SELECT @EsCargo = 1, @ImporteDetalle = @ContactoImporte

		-- Si se esta aplicando una NC o NCD Voltear EsCargo               
                IF @MovTipo IN ('CXC.ACA', 'CXP.ACA') OR ((@AplicaMovTipo IN ('CXC.DA','CXC.NC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP','CXC.DC', 'CXP.A','CXP.NC','CXP.NCD','CXP.NCP','CXP.NCF','CXP.DC', 'CXC.DAC', 'CXP.DAC')) OR (@Modulo = 'AGENT' AND @ImporteAplicar < 0.0))
                  IF @EsCargo = 0 SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0

                IF @MovTipo IN ('CXC.ACA', 'CXP.ACA') OR ((@AplicaMovTipo IN ('CXC.A', 'CXC.AR', 'CXC.DA','CXC.NC', 'CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP', 'CXP.A','CXP.DA','CXP.NC','CXP.NCD','CXP.NCF','CXP.NCP', 'CXC.DAC', 'CXP.DAC') AND @MovTipo NOT IN ('CXC.DA', 'CXC.DC', 'CXP.DA', 'CXP.DC')) OR (@Modulo = 'AGENT' AND @ImporteAplicar < 0.0))
                  SELECT @ImporteDetalle = -@ImporteDetalle

		-- Cuando Aplica Notas de Cargo el efecto es inverso a las Notas de Credito
                IF @MovTipo IN ('CXC.CA', 'CXC.CAD', 'CXC.CAP', 'CXP.CA', 'CXP.CAD', 'CXP.CAP')
                  SELECT @ImporteDetalle = -@ImporteDetalle

                IF @Modulo IN ('CXC', 'CXP') AND (@AplicaOrigenTipo IN (NULL, 'VTAS', 'COMS', 'CXC', 'CXP', 'GAS', 'INV') OR (@PPTO = 1 AND @AplicaOrigenTipo = 'GAS'))
                BEGIN
                  SELECT @IDOrigen = NULL
                  IF @AplicaOrigenTipo = 'VTAS' SELECT @IDOrigen = ID FROM Venta  WHERE Mov = @AplicaOrigen AND MovID = @AplicaOrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO') ELSE
                  IF @AplicaOrigenTipo = 'COMS' SELECT @IDOrigen = ID FROM Compra WHERE Mov = @AplicaOrigen AND MovID = @AplicaOrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO') ELSE
                  IF @AplicaOrigenTipo = 'GAS'  SELECT @IDOrigen = ID FROM Gasto  WHERE Mov = @AplicaOrigen AND MovID = @AplicaOrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO') ELSE
                  IF @AplicaOrigenTipo = 'CXC' OR (@AplicaOrigenTipo IS NULL AND @Modulo = 'CXC') SELECT @IDOrigen = ID FROM Cxc    WHERE Mov = @AplicaMov    AND MovID = @AplicaMovID    AND Estatus IN ('PENDIENTE', 'CONCLUIDO') ELSE
                  IF @AplicaOrigenTipo = 'CXP' OR (@AplicaOrigenTipo IS NULL AND @Modulo = 'CXP') SELECT @IDOrigen = ID FROM Cxp    WHERE Mov = @AplicaMov    AND MovID = @AplicaMovID    AND Estatus IN ('PENDIENTE', 'CONCLUIDO') 

                  IF @IDAplica IS NOT NULL
                  BEGIN
                    INSERT #CxAplicaMovImpuesto 
                          (Renglon,  RenglonSub,  OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,	      OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,               Importe2,               Importe3,               SubTotal,                   ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
                    SELECT @Renglon, @RenglonSub, OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1*@AplicaFactor, Importe2*@AplicaFactor, Importe3*@AplicaFactor, SubTotal*@AplicaFactor,     ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
                      FROM MovImpuesto
                     WHERE Modulo = @Modulo
                       AND ModuloID = @IDAplica
/*                     WHERE Modulo = ISNULL(@AplicaOrigenTipo, @Modulo)
                       AND ModuloID = @IDOrigen*/

                    IF @PPTO = 1 
                      INSERT #CxAplicaMovPresupuesto
                            (Renglon,  RenglonSub,  CuentaPresupuesto, Importe)
                      SELECT @Renglon, @RenglonSub, CuentaPresupuesto, Importe*@AplicaFactor
                        FROM MovPresupuesto
                       WHERE Modulo = @Modulo
                         AND ModuloID = @IDAplica
/*                       WHERE Modulo = ISNULL(@AplicaOrigenTipo, @Modulo)
                         AND ModuloID = @IDOrigen*/
                  END
                END

                -- Actualizar Saldo del Movimiento
                IF @Ligado = 0 AND @EsReferencia = 0
                BEGIN
                  IF @Accion = 'CANCELAR'
                    SELECT @AplicaSaldoOrdinariosN = @AplicaSaldoOrdinarios + @OrdinariosAplicar, 
                           @AplicaSaldoMoratoriosN = @AplicaSaldoMoratorios + @MoratoriosAplicar,
                           @AplicaSaldoOrdinariosIVAN = @AplicaSaldoOrdinariosIVA + @OrdinariosIVAAplicar, --BUG 13489
                           @AplicaSaldoMoratoriosIVAN = @AplicaSaldoMoratoriosIVA + @MoratoriosIVAAplicar  --BUG 13489
                  ELSE 
                    SELECT @AplicaSaldoOrdinariosN = @AplicaSaldoOrdinarios - @OrdinariosAplicar, 
                           @AplicaSaldoMoratoriosN = @AplicaSaldoMoratorios - @MoratoriosAplicar,
                           @AplicaSaldoOrdinariosIVAN = @AplicaSaldoOrdinariosIVA - @OrdinariosIVAAplicar, --BUG 13489
                           @AplicaSaldoMoratoriosIVAN = @AplicaSaldoMoratoriosIVA - @MoratoriosIVAAplicar  --BUG 13489

                  IF @AplicaSaldoOrdinariosN < 0.0 SELECT @Ok = 30070, @OkRef = 'Intereses Ordinarios'     ELSE 
                  IF @AplicaSaldoMoratoriosN < 0.0 SELECT @Ok = 30070, @OkRef = 'Intereses Moratorios'     ELSE --BUG 13489
                  IF @AplicaSaldoOrdinariosN < 0.0 SELECT @Ok = 30070, @OkRef = 'IVA Intereses Ordinarios' ELSE --BUG 13489
                  IF @AplicaSaldoMoratoriosN < 0.0 SELECT @Ok = 30070, @OkRef = 'IVA Intereses Moratorios' --BUG 13489
                   
                  IF @ImporteAplicar < 0.0 SELECT @ImporteAplicarFactor = -1 ELSE SELECT @ImporteAplicarFactor = 1
	  	          IF @Accion <> 'CANCELAR' AND ABS(@AplicaSaldo + @ImporteDetalle + @AplicaSaldoOrdinariosN + @AplicaSaldoOrdinariosIVAN + @AplicaSaldoMoratoriosN + @AplicaSaldoMoratoriosIVAN) <= (@AutoAjuste/@ContactoFactor)  AND @NoAutoAjustar = 0 --BUG 13489
                  BEGIN
                  
                    SELECT @ImporteAplicar = @AplicaSaldo * @ContactoFactor
                    SELECT @ContactoImporte    = @ImporteAplicar / @ContactoFactor
                    SELECT @AutoAjusteD = NULLIF(@AplicaSaldo + @ImporteDetalle, 0.0)
                    SELECT @AplicaSaldoN = NULL, @AplicaEstatusNuevo = 'CONCLUIDO'
                    SELECT @ImporteAplicar = @ImporteAplicar * @ImporteAplicarFactor, 
                           @ContactoImporte = @ContactoImporte * @ImporteAplicarFactor
                    IF @MovTipo IN ('CXC.DP', 'CXP.DP') SELECT @FechaConclusion = @Vencimiento ELSE SELECT @FechaConclusion = @FechaEmision

                    EXEC spValidarTareas @Empresa, @Modulo, @IDAplica, @AplicaEstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
                    IF @Modulo = 'CXC'   UPDATE Cxc   SET Saldo = @AplicaSaldoN, SaldoInteresesOrdinarios = @AplicaSaldoOrdinariosN, SaldoInteresesOrdinariosIVA = @AplicaSaldoOrdinariosIVAN, SaldoInteresesMoratorios = @AplicaSaldoMoratoriosN, SaldoInteresesMoratoriosIVA = @AplicaSaldoMoratoriosIVAN, AutoAjuste = @AutoAjusteD, Estatus = @AplicaEstatusNuevo, FechaConclusion = @FechaConclusion, UltimoCambio = @FechaEmision WHERE ID = @IDAplica ELSE --BUG 13489
                    IF @Modulo = 'CXP'   UPDATE Cxp   SET Saldo = @AplicaSaldoN, SaldoInteresesOrdinarios = @AplicaSaldoOrdinariosN, SaldoInteresesOrdinariosIVA = @AplicaSaldoOrdinariosIVAN, SaldoInteresesMoratorios = @AplicaSaldoMoratoriosN, SaldoInteresesMoratoriosIVA = @AplicaSaldoMoratoriosIVAN, AutoAjuste = @AutoAjusteD, Estatus = @AplicaEstatusNuevo, FechaConclusion = @FechaConclusion, UltimoCambio = @FechaEmision WHERE ID = @IDAplica ELSE --BUG 13489
                    IF @Modulo = 'AGENT' UPDATE Agent SET Saldo = @AplicaSaldoN, AutoAjuste = @AutoAjusteD, Estatus = @AplicaEstatusNuevo, FechaConclusion = @FechaConclusion, UltimoCambio = @FechaEmision WHERE ID = @IDAplica 

                    IF @AplicaPosfechado = 1 AND ISNULL(@AplicaSaldoN, 0) <> 0 AND @Accion <> 'CANCELAR' SELECT @Ok = 30395
                  END ELSE
                  BEGIN
                    SELECT @AplicaSaldoN = NULLIF(@AplicaSaldo + @AutoAjusteD + @ImporteDetalle, 0.0)
		            IF @AplicaSaldoN IS NULL AND ROUND(@AplicaSaldoOrdinariosN, 0) = 0.0  AND ROUND(@AplicaSaldoOrdinariosIVAN, 0) = 0.0 AND ROUND(@AplicaSaldoMoratoriosN, 0) = 0.0 AND ROUND(@AplicaSaldoMoratoriosIVAN, 0) = 0.0 SELECT @AplicaEstatusNuevo = 'CONCLUIDO' ELSE SELECT @AplicaEstatusNuevo = 'PENDIENTE' --BUG 13489

                    EXEC spValidarTareas @Empresa, @Modulo, @IDAplica, @AplicaEstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
                    IF @Modulo = 'CXC'   UPDATE Cxc   SET Saldo = @AplicaSaldoN, SaldoInteresesOrdinarios = @AplicaSaldoOrdinariosN, SaldoInteresesOrdinariosIVA = @AplicaSaldoOrdinariosIVAN, SaldoInteresesMoratorios = @AplicaSaldoMoratoriosN, SaldoInteresesMoratoriosIVA = @AplicaSaldoMoratoriosIVAN, AutoAjuste = NULL, Estatus = @AplicaEstatusNuevo, FechaConclusion = NULL, UltimoCambio = @FechaEmision WHERE ID = @IDAplica ELSE --BUG 13489
                    IF @Modulo = 'CXP'   UPDATE Cxp   SET Saldo = @AplicaSaldoN, SaldoInteresesOrdinarios = @AplicaSaldoOrdinariosN, SaldoInteresesOrdinariosIVA = @AplicaSaldoOrdinariosIVAN, SaldoInteresesMoratorios = @AplicaSaldoMoratoriosN, SaldoInteresesMoratoriosIVA = @AplicaSaldoMoratoriosIVAN, AutoAjuste = NULL, Estatus = @AplicaEstatusNuevo, FechaConclusion = NULL, UltimoCambio = @FechaEmision WHERE ID = @IDAplica ELSE --BUG 13489
                    IF @Modulo = 'AGENT' UPDATE Agent SET Saldo = @AplicaSaldoN, AutoAjuste = NULL, Estatus = @AplicaEstatusNuevo, FechaConclusion = NULL, UltimoCambio = @FechaEmision WHERE ID = @IDAplica 
                   -- SELECT @ContactoImporte = @ContactoImporte + @AutoAjusteD 
                    IF @AplicaPosfechado = 1 AND ISNULL(@AplicaSaldoN, 0) <> 0 AND @Accion <> 'CANCELAR' SELECT @Ok = 30395
                  END
                  IF @Accion <> 'CANCELAR'
					SELECT @ContactoImporte = @ContactoImporte - (ISNULL(@AutoAjusteD,0) )

                  -- Calcular Factor de Disminucion del Saldo
                  SELECT @AplicaSaldoFactor = ISNULL(((ISNULL(@AplicaSaldo, 0)-ISNULL(@AplicaSaldoN, 0)) / NULLIF(@AplicaImporteNeto, 0)), 0)
                  
                  /*IF @Peru = 1
                  BEGIN
                    IF @CfgPeruRetenciones = 1 AND @AplicaRetencionAlPago = 1 
                      IF ISNULL(@Importe, 0.0) + ISNULL(@Impuestos, 0.0) <= @CfgPeruRetencionesTopeExcento
                        SELECT @AplicaRetencionAlPago = 0                      
                  END*/

                  IF (@Fiscal = 0 OR @FiscalGenerarRetenciones = 1) AND (@AplicaRetencionAlPago = 1 OR @CfgRetencionAlPago = 1) AND @Modulo = 'CXP' AND (@MovTipo NOT IN ('CXP.AJM', 'CXP.AJA', 'CXP.AJR', 'CXP.AJE') ) 
                     AND ( @RetencionAlPagoMovImpuesto = 0 OR (@MovTipo <> 'CXP.D' AND @RetencionAlPagoMovImpuesto = 1))
                  BEGIN
                    IF @AplicaRetencion < 0
                      SELECT @AplicaRetencion = @AplicaRetencion*-1, @CfgRetencionMov = @CfgDevRetencionMov
                    IF @AplicaRetencion2 < 0
                      SELECT @AplicaRetencion2 = @AplicaRetencion2*-1, @CfgRetencionMov = @CfgDevRetencionMov
                    IF @AplicaRetencion3 < 0
                      SELECT @AplicaRetencion3 = @AplicaRetencion3*-1, @CfgRetencionMov = @CfgDevRetencionMov

                    IF @AplicaMovTipo = 'CXP.NC'
                      SELECT @CfgRetencionMov = @CfgDevRetencionMov

                    IF @RetencionAlPagoMovImpuesto = 1
                      EXEC spGenerarRetencionMovImpuesto @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @movTipo, @Mov, @MovID, @AplicaMoneda, @AplicaTipoCambio, @FechaEmision, @Proyecto, @Usuario, @FechaRegistro, @Ejercicio, @Periodo, @CfgRetencionMov, @CfgRetencionAcreedor, @cfgRetencionConcepto, @CfgRetencion2Acreedor, @cfgRetencion2Concepto, @CfgRetencion3Acreedor, @cfgRetencion3Concepto,  @IDAplica, @AplicasaldoFactor, @RedondeoMonetarios, @Ok OUTPUT, @okRef OUTPUT
                    ELSE BEGIN
                      EXEC spGastoConcepto @CfgRetencionConcepto,  @AplicaConcepto, @RetencionConcepto OUTPUT
                      EXEC spGastoConcepto @CfgRetencion2Concepto, @AplicaConcepto, @Retencion2Concepto OUTPUT
                      EXEC spGastoConcepto @CfgRetencion3Concepto, @AplicaConcepto, @Retencion3Concepto OUTPUT
                      SELECT @AplicaRetencion  = ROUND(@AplicaRetencion  * @AplicaSaldoFactor, @RedondeoMonetarios),
                             @AplicaRetencion2 = ROUND(@AplicaRetencion2 * @AplicaSaldoFactor, @RedondeoMonetarios),
                             @AplicaRetencion3 = ROUND(@AplicaRetencion3 * @AplicaSaldoFactor, @RedondeoMonetarios)
                      IF @AplicaRetencion <> 0.0 
                      BEGIN
                        IF @CfgRetencionAcreedor IS NULL 
                          SELECT @Ok = 70100
                        ELSE
                          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @AplicaMoneda, @AplicaTipoCambio, 
                                           @FechaEmision, @RetencionConcepto, @Proyecto, @Usuario, NULL, NULL, NULL, NULL,
              	  	                   @FechaRegistro, @Ejercicio, @Periodo,
            		                   NULL, NULL, @CfgRetencionAcreedor, NULL, NULL, NULL, NULL, NULL,
                                           @AplicaRetencion, NULL, NULL, NULL, 
                                           NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		                           @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                                           @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP = 'RETENCION'
                      END
                      IF @AplicaRetencion2 <> 0.0 
                      BEGIN
                        IF @CfgRetencion2Acreedor IS NULL 
                          SELECT @Ok = 70100
                        ELSE
                          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @AplicaMoneda, @AplicaTipoCambio, 
                                           @FechaEmision, @Retencion2Concepto, @Proyecto, @Usuario, NULL, NULL, NULL, NULL,
  	  	                           @FechaRegistro, @Ejercicio, @Periodo,
            		                   NULL, NULL, @CfgRetencion2Acreedor, NULL, NULL, NULL, NULL, NULL,
                                           @AplicaRetencion2, NULL, NULL, NULL, 
                                           NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		                           @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                                           @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP = 'RETENCION'
                      END
                      IF @AplicaRetencion3 <> 0.0 
                      BEGIN
                        IF @CfgRetencion3Acreedor IS NULL 
                          SELECT @Ok = 70100
                        ELSE
                          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @AplicaMoneda, @AplicaTipoCambio, 
                                           @FechaEmision, @Retencion3Concepto, @Proyecto, @Usuario, NULL, NULL, NULL, NULL,
  	  	                           @FechaRegistro, @Ejercicio, @Periodo,
            		                   NULL, NULL, @CfgRetencion3Acreedor, NULL, NULL, NULL, NULL, NULL,
                                           @AplicaRetencion3, NULL, NULL, NULL, 
                                           NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		                           @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                                           @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP = 'RETENCION'
                      END
                    END
                  END

                  -- Agregar a Estatus Log
		          IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
                    EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @IDAplica, @AplicaEstatus, @AplicaEstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @AplicaMov, @AplicaMovID, @AplicaMovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

                  -- Afectar las Comisiones
                  IF @Modulo = 'CXC' AND @AplicaMovTipo IN ('CXC.F', 'CXC.CA', 'CXC.CAD', 'CXC.NC', 'CXC.NCD') AND @CfgVentaComisionesCobradas = 1 AND (ISNULL(@AplicaSaldo, 0.0) > 0.0 OR @Accion = 'CANCELAR') AND @Ok IS NULL
                  BEGIN
                    /*SELECT @AfectarComision = 0
                    IF @MovTipo <> 'CXC.NC' AND @MovAplicaMovTipo <> 'CXC.NC' 
                      SELECT @AfectarComision = 1

                    IF @AfectarComision = 1 --AND @CfgComisionCreditoDiverso = 0
                      IF @MovTipo = 'CXC.NCD' OR @MovAplicaMovTipo = 'CXC.NCD'
                        SELECT @AfectarComision = 0
                   
                    IF @AfectarComision = 1
                    BEGIN*/
                      SELECT @ImporteComision = 0.0
                      IF @Accion = 'CANCELAR'
                        SELECT @ImporteComision = ISNULL(Comision, 0.0) FROM CxcD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
                      ELSE 
                      BEGIN
                        SELECT @AplicaComisionPendienteN = (ISNULL(@AplicaSaldoN, 0.0) * @AplicaComisionPendiente) / @AplicaSaldo
	  	                SELECT @ImporteComision = @AplicaComisionPendiente - @AplicaComisionPendienteN
  	        	        EXEC xpComisionCobro @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
           	             	                 @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaRegistro, @FechaAfectacion, @AplicaAgente, @Conexion, @SincroFinal, @Sucursal,
	   			  	                         @IDAplica, @AplicaMov, @AplicaMovID, @AplicaMovTipo, @AplicaFechaEmision, @AplicaVencimiento, 
                                             @AplicaImporteTotal, @AplicaSaldo, @AplicaComisionTotal, @AplicaComisionPendiente, @ImporteAplicar, 
                                             @ImporteComision OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
                      END

 		              IF ISNULL(@ImporteComision, 0.0) <> 0.0 AND @Ok IS NULL
                      BEGIN
                        IF @Accion = 'CANCELAR' 
			              SELECT @AplicaComisionPendienteN = @AplicaComisionPendiente + @ImporteComision
                        ELSE 
                        BEGIN
	    	              UPDATE CxcD SET Comision = @ImporteComision WHERE CURRENT OF crCxDetalle
                          SELECT @AplicaComisionPendienteN = @AplicaComisionPendiente - @ImporteComision
                          IF @AplicaComisionPendienteN <= 0.0 SELECT @AplicaComisionPendiente = NULL 
                        END
                        UPDATE Cxc SET ComisionPendiente = NULLIF(@AplicaComisionPendienteN, 0.0) WHERE ID = @IDAplica 

                        --IF @CfgComisionBase = 'VENTA' AND (@MovTipo NOT IN ('CXC.ANC', 'CXC.NC', 'CXC.NCD') OR @MovAplicaMovTipo IN ('CXC.A', 'CXC.AR'))
			            IF @CfgComisionBase = 'VENTA' AND (@MovTipo NOT IN ('CXC.ANC', 'CXC.NC', 'CXC.NCD') OR @CfgComisionCreditos = 1 OR @MovAplicaMovTipo IN ('CXC.A', 'CXC.AR'))
                        BEGIN
                          IF @Accion = 'CANCELAR'
                            UPDATE Cxc SET ComisionGenerada = ISNULL(ComisionGenerada, 0.0) - @ImporteComision WHERE ID = @IDAplica 
                          ELSE
                            UPDATE Cxc SET ComisionGenerada = ISNULL(ComisionGenerada, 0.0) + @ImporteComision WHERE ID = @IDAplica 

                          EXEC spCxGenerarComision @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @IDAplica, @AplicaMov, @AplicaMovID, @AplicaMovTipo, @AplicaMoneda, @AplicaTipoCambio,
                                                   @FechaAfectacion, @Proyecto, @Usuario,  
                                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                                   @ContactoAfectar, @AplicaAgente, 
     	      	  	  	                           @AplicaImporte, @ImporteComision, 
                                                   @CxModulo, @CxMov, @CxMovID, @RedondeoMonetarios, @Ok OUTPUT, @OkRef  OUTPUT
                        END
                      END
                  /*END ELSE
  	  	            BEGIN
                      IF @MovTipo IN ('CXC.NC', 'CXC.NCD') OR @MovAplicaMovTipo IN ('CXC.NC', 'CXC.NCD')
                      BEGIN
                        SELECT @ImporteComision = 0.0
                        IF @Accion = 'CANCELAR'
                        BEGIN
                          SELECT @ImporteComision = ISNULL(Comision, 0.0) FROM CxcD WHERE ID = @ID
	  	  	            SELECT @AplicaComisionPendienteN = @AplicaComisionPendiente + @ImporteComision
                        END ELSE 
                        BEGIN
                          SELECT @AplicaComisionPendienteN = (ISNULL(@AplicaSaldoN, 0.0) * @AplicaComisionPendiente) / @AplicaSaldo
	    	              SELECT @ImporteComision = @AplicaComisionPendiente - @AplicaComisionPendienteN
                          UPDATE CxcD SET Comision = @ImporteComision WHERE CURRENT OF crCxDetalle
                          SELECT @AplicaComisionPendienteN = @AplicaComisionPendiente - @ImporteComision
                          IF @AplicaComisionPendienteN <= 0.0 SELECT @AplicaComisionPendiente = NULL 
	  	                END
                        UPDATE Cxc SET ComisionPendiente = NULLIF(@AplicaComisionPendienteN, 0.0) WHERE ID = @IDAplica 
                      END
                    END*/
                  END
                END ELSE
                BEGIN
                  IF @Accion = 'CANCELAR' AND @LigadoDR = 0
                  BEGIN
                    IF ROUND(@AplicaSaldo, 2) = ROUND(@AplicaImporteTotal, 2)
                    BEGIN
                      EXEC spValidarTareas @Empresa, @Modulo, @IDAplica, 'CANCELADO', @Ok OUTPUT, @OkRef OUTPUT
                      IF @Modulo = 'CXC'   UPDATE Cxc   SET Saldo = NULL, Estatus = 'CANCELADO', FechaCancelacion = @FechaAfectacion, UltimoCambio = @FechaEmision WHERE ID = @IDAplica ELSE
                      IF @Modulo = 'CXP'   UPDATE Cxp   SET Saldo = NULL, Estatus = 'CANCELADO', FechaCancelacion = @FechaAfectacion, UltimoCambio = @FechaEmision WHERE ID = @IDAplica ELSE
                      IF @Modulo = 'AGENT' UPDATE Agent SET Saldo = NULL, Estatus = 'CANCELADO', FechaCancelacion = @FechaAfectacion, UltimoCambio = @FechaEmision WHERE ID = @IDAplica 
                    END ELSE SELECT @Ok = 60060, @OkRef = RTRIM(@AplicaMov)+' '+LTRIM(Convert(char, @AplicaMovID))
                  END
                END

                -- Actualizar Saldo del Cliente
                IF (@Ligado = 0 OR @Accion = 'CANCELAR') AND (@LigadoDR = 0 OR @AplicaMovTipo IN ('CXC.CA', 'CXC.CAD', 'CXP.CA', 'CXP.CAD')) AND @EsReferencia = 0
                BEGIN
                  IF @Accion <> 'CANCELAR' SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1
                  IF @MovTipo IN ('CXC.CA','CXC.CAD','CXC.CAP','CXC.DC','CXC.DA','CXC.ACA', 
                                  'CXP.CA','CXP.CAD','CXP.CAP','CXP.DC','CXP.DA','CXP.ACA','AGENT.CO') SELECT @EsCargo = ~@EsCargo
                  EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @ContactoMoneda, @ContactoTipoCambio, @ContactoAfectar, NULL, NULL, NULL,
                               @Modulo, @ID, @Mov, @MovID, @EsCargo, @ContactoImporte, NULL, NULL,
                               @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
                               @Ok OUTPUT, @OkRef OUTPUT
                               
				  SET @RamaInteresOrdinario = CASE WHEN @Modulo = 'CXC' THEN 'CIO' ELSE 'PIO' END --MEJORA10015
				  SET @RamaInteresMoratorio = CASE WHEN @Modulo = 'CXC' THEN 'CIM' ELSE 'PIM' END --MEJORA10015
				  
                  --MEJORA10015
                  EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @RamaInteresOrdinario, @ContactoMoneda, @ContactoTipoCambio, @ContactoAfectar, NULL, NULL, NULL,
                               @Modulo, @ID, @Mov, @MovID, @EsCargo, @ContactoOrdinarios, NULL, NULL,
                               @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
                               @Ok OUTPUT, @OkRef OUTPUT

                  --MEJORA10015
                  EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @RamaInteresMoratorio, @ContactoMoneda, @ContactoTipoCambio, @ContactoAfectar, NULL, NULL, NULL,
                               @Modulo, @ID, @Mov, @MovID, @EsCargo, @ContactoMoratorios, NULL, NULL,
                               @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
                               @Ok OUTPUT, @OkRef OUTPUT
				  
                  --MEJORA10041
                  EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @RamaInteresOrdinario, @ContactoMoneda, @ContactoTipoCambio, @ContactoAfectar, NULL, NULL, NULL,
                               @Modulo, @ID, @Mov, @MovID, @EsCargo, @ContactoOrdinariosIVA, NULL, NULL,
                               @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
                               @Ok OUTPUT, @OkRef OUTPUT

                  --MEJORA10041
                  EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @RamaInteresMoratorio, @ContactoMoneda, @ContactoTipoCambio, @ContactoAfectar, NULL, NULL, NULL,
                               @Modulo, @ID, @Mov, @MovID, @EsCargo, @ContactoMoratoriosIVA, NULL, NULL,
                               @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
                               @Ok OUTPUT, @OkRef OUTPUT

                               
                END
              END
              -- Registrar el Flujo	
              EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @IDAplica, @AplicaMov, @AplicaMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
            END
          END

          -- Checar Que no pongan importes negativos (con exepcion de los movimientos ligados que si pueden ir en rojo)
          IF @Accion <> 'CANCELAR' AND @EsReferencia = 0
          BEGIN
            IF (@VerificarAplica = 1) AND @AplicaMovTipo IN ('CXC.A', 'CXC.AR', 'CXC.DA', 'CXC.NC', 'CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP', 'CXP.A','CXP.DA','CXP.NC','CXP.NCD','CXP.NCF','CXP.NCP','CXC.DAC', 'CXP.DAC') AND @MovTipo NOT IN ('CXC.DA', 'CXC.DC', 'CXP.DA', 'CXP.DC', 'CXC.RE', 'CXP.RE')
            BEGIN
              IF @ImporteAplicar > 0.0 SELECT @Ok = 30100
            END ELSE
            BEGIN
              IF @ImporteAplicar < 0.0 AND @Ligado = 0 AND @AplicaMovTipo NOT IN ('CXC.A','CXC.AR','CXC.DA','CXC.NC', 'CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP', 'CXP.A','CXP.DA','CXP.NC','CXP.NCD','CXP.NCF','CXP.NCP', 'CXC.RE', 'CXP.RE','CXC.DAC', 'CXP.DAC') AND @MovTipo NOT IN ('AGENT.P', 'AGENT.CO', 'CXC.AJA', 'CXP.AJA') SELECT @Ok = 30100
  	    END
          END

          IF @Ok IS NOT NULL AND @OkRef IS NULL
            SELECT @OkRef = RTRIM(@AplicaMov)+' '+LTRIM(Convert(char, @AplicaMovID))
        END

        -- Acumular Importe por Linea
        SELECT @ImporteAplicado = @ImporteAplicado + (((@ImporteAplicar + @OrdinariosNetos + @MoratoriosNetos + @OtrosCargos) * (1+(@ImpuestoAdicional/100.0))) + ISNULL(@OrdinariosIVANetos,0.0) + ISNULL(@MoratoriosIVANetos,0.0)) --MEJORA10041        
        IF @DescuentoRecargos > 0.0 SELECT @ImporteAplicado = @ImporteAplicado + @DescuentoRecargos

        SELECT @SumaImporteNeto = @SumaImporteNeto + @ImporteNeto
      END -- Fetch_Status <> 2

      IF @Accion = 'CANCELAR' AND @LigadoDR = 1 
      BEGIN
        IF @Modulo = 'CXC' SELECT @DRID = ID FROM Cxc WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
        IF @Modulo = 'CXP' SELECT @DRID = ID FROM Cxp WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
        EXEC spCx @DRID, @Modulo, @Accion, 'TODO', @FechaEmision, NULL, @Usuario, 1, 0, @DRMov OUTPUT, @DRMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      END

      FETCH NEXT FROM crCxDetalle INTO @Renglon, @RenglonSub, @AplicaMov, @AplicaMovID, @ImporteAplicar, @OrdinariosAplicar, @OrdinariosNetos, @MoratoriosAplicar, @MoratoriosNetos, @ImpuestoAdicional, @OtrosCargos, @AplicaFecha, @AplicaFechaAnterior, @DescuentoRecargos, @Ligado, @LigadoDR, @EsReferencia, @OrdinariosIVAAplicar, @OrdinariosIVANetos, @MoratoriosIVAAplicar, @MoratoriosIVANetos --MEJORA10041
      IF @@ERROR <> 0 SELECT @Ok = 1
    END -- While
    CLOSE crCxDetalle
    DEALLOCATE crCxDetalle
  END

  IF @VerificarAplica = 0 AND @Peru = 1 AND @MovTipo IN ('CXP.P', 'CXP.ANC', 'CXP.NET') AND (ISNULL(@Retencion, 0.0) + ISNULL(@Retencion2, 0.0) + ISNULL(@Retencion3, 0.0)) <> 0.0 AND @Ok IS NULL 
  BEGIN
    EXEC spGastoConcepto @CfgRetencionConcepto,  @Concepto, @RetencionConcepto OUTPUT
    EXEC spGastoConcepto @CfgRetencion2Concepto, @Concepto, @Retencion2Concepto OUTPUT
    EXEC spGastoConcepto @CfgRetencion3Concepto, @Concepto, @Retencion3Concepto OUTPUT

    IF @Retencion < 0
      SELECT @Retencion = @Retencion*-1, @CfgRetencionMov = @CfgDevRetencionMov
    IF @Retencion2 < 0
      SELECT @Retencion2 = @Retencion2*-1, @CfgRetencionMov = @CfgDevRetencionMov
    IF @Retencion3 < 0
      SELECT @Retencion3 = @Retencion3*-1, @CfgRetencionMov = @CfgDevRetencionMov

    IF ISNULL(@Retencion, 0.0) <> 0.0 
    BEGIN
     IF @CfgRetencionAcreedor IS NULL 
       SELECT @Ok = 70100
     ELSE
       EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                        @FechaEmision, @RetencionConcepto, @Proyecto, @Usuario, NULL, NULL, NULL, NULL,
                        @FechaRegistro, @Ejercicio, @Periodo,
       	  	        NULL, NULL, @CfgRetencionAcreedor, NULL, NULL, NULL, NULL, NULL,
                        @Retencion, NULL, NULL, NULL, 
                        NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		        @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                        @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP = 'RETENCION'
    END
    IF ISNULL(@Retencion2, 0.0) <> 0.0 
    BEGIN
      IF @CfgRetencion2Acreedor IS NULL 
        SELECT @Ok = 70100
      ELSE
        EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                         @FechaEmision, @Retencion2Concepto, @Proyecto, @Usuario, NULL, NULL, NULL, NULL,
                         @FechaRegistro, @Ejercicio, @Periodo,
                         NULL, NULL, @CfgRetencion2Acreedor, NULL, NULL, NULL, NULL, NULL,
                         @Retencion2, NULL, NULL, NULL, 
                         NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
                         @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                         @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP = 'RETENCION'
    END
    IF ISNULL(@Retencion3, 0.0) <> 0.0 
    BEGIN
      IF @CfgRetencion3Acreedor IS NULL 
        SELECT @Ok = 70100
      ELSE
        EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                         @FechaEmision, @Retencion3Concepto, @Proyecto, @Usuario, NULL, NULL, NULL, NULL,
                         @FechaRegistro, @Ejercicio, @Periodo,
                         NULL, NULL, @CfgRetencion3Acreedor, NULL, NULL, NULL, NULL, NULL,
                         @Retencion3, NULL, NULL, NULL, 
                         NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
                         @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                         @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP = 'RETENCION'
    END
  END

  IF @Modulo IN ('CXC', 'CXP') AND @Accion <> 'CANCELAR' AND @Ok IS NULL 
  BEGIN
    -- Obtener el Siguiente renglon
    IF @Modulo = 'CXC' SELECT @Renglon = ISNULL(MAX(Renglon), 0.0) + 2048 FROM CxcD WHERE ID = @ID ELSE
    IF @Modulo = 'CXP' SELECT @Renglon = ISNULL(MAX(Renglon), 0.0) + 2048 FROM CxpD WHERE ID = @ID

/*    IF @MovTipo IN ('CXC.C', 'CXC.D', 'CXC.DM', 'CXP.P', 'CXP.D', 'CXP.DM', 'CXP.PAG') AND ABS(@ImporteTotal - @SumaImporteNeto) > @AutoAjuste AND @CfgAplicaDif = 0
      SELECT @Ok = 30230, @OkRef = 'Diferencia: '+LTRIM(CONVERT(char, @ImporteTotal - @SumaImporteNeto))*/

    IF @MovTipo IN ('CXC.IM', 'CXC.RM', 'CXC.DA', 'CXC.DC', 'CXP.DA', 'CXP.DC')
    BEGIN
      IF dbo.fnImporteSimilar(@ImporteAplicado, @ImporteTotal) = 0 
        SELECT @Ok = 30230
    END ELSE 
    BEGIN
      SELECT @Saldo = ISNULL(@ImporteTotal - @ImporteAplicado, 0.0)

      IF @MovTipo IN ('CXC.AJA', 'CXP.AJA') AND @Saldo <> 0.0
        SELECT @Ok = 35340, @OkRef = CONVERT(varchar, @Saldo)

      IF @Peru = 1 AND @MovTipo IN ('CXP.P', 'CXP.ANC', 'CXP.NET')
        SELECT @Saldo = @Saldo + ISNULL(@Retencion, 0.0) + ISNULL(@Retencion2, 0.0) + ISNULL(@Retencion3, 0.0)

      IF @Saldo <> 0.0 OR @TieneDescuentoRecargos = 1 AND @Ok IS NULL
      BEGIN
        IF @VerificarAplica = 0 
        BEGIN

          -- Afectar a Saldos
          SELECT @ContactoImporte = @Saldo / @ContactoFactor

          -- Tiene Descuentos / Recargos
          IF @TieneDescuentoRecargos = 1 
          BEGIN
            SELECT @MovDescuento = 
                      CASE @Modulo 
                        WHEN 'CXC' THEN CxcNCreditoProntoPago 
	                WHEN 'CXP' THEN CxpProntoPago 
                      END,
	           @MovRecargos = 
                     CASE @Modulo 
	               WHEN 'CXC' THEN CxcNCargoRecargos
	               WHEN 'CXP' THEN CxpRecargos
                     END
              FROM EmpresaCfgMov
             WHERE Empresa = @Empresa

            SELECT @ConceptoDescuento = 
                     CASE @Modulo 
         	       WHEN 'CXC' THEN CxcProntoPagoConcepto
     	               WHEN 'CXP' THEN CxpProntoPagoConcepto
                     END,
	           @ConceptoRecargos = 
                     CASE @Modulo 
       	               WHEN 'CXC' THEN CxcRecargosConcepto
 	               WHEN 'CXP' THEN CxpRecargosConcepto
                     END
              FROM EmpresaCfg
             WHERE Empresa = @Empresa

            SELECT @IVA = DefImpuesto
              FROM EmpresaGral
             WHERE Empresa = @Empresa

            -- Descuentos
      	    SELECT @DREsCredito = 1, @DRMov = @MovDescuento, @DRConcepto = @ConceptoDescuento,
                   @DRID = NULL, @DRRenglon = 0.0, @DRImporte = 0.0, @DRImpuestos = 0.0, @DRImporteTotal = 0.0
            IF @Modulo = 'CXC' DECLARE crDescuentoRecargos CURSOR LOCAL FOR SELECT Aplica, AplicaID, ISNULL(-DescuentoRecargos, 0.0)/@ContactoFactor FROM CxcD WHERE ID = @ID AND ISNULL(DescuentoRecargos, 0.0) < 0.0 ELSE
            IF @Modulo = 'CXP' DECLARE crDescuentoRecargos CURSOR LOCAL FOR SELECT Aplica, AplicaID, ISNULL(-DescuentoRecargos, 0.0)/@ContactoFactor FROM CxpD WHERE ID = @ID AND ISNULL(DescuentoRecargos, 0.0) < 0.0 
            OPEN crDescuentoRecargos
            FETCH NEXT FROM crDescuentoRecargos INTO @DRAplica, @DRAplicaID, @DescuentoRecargos
            WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
            BEGIN                         
              IF @@FETCH_STATUS <> -2 
              BEGIN
                IF @DRID IS NULL
                BEGIN
                  IF @Modulo = 'CXC'
                    INSERT Cxc (Sucursal, Empresa, Mov, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Estatus, Concepto, 
                                Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio, AplicaManual, OrigenTipo, Origen, OrigenID)
                        VALUES (@Sucursal, @Empresa, @DRMov, @FechaEmision, @Proyecto, @ContactoMoneda, @ContactoTipoCambio, @Usuario, @Referencia, 'SINAFECTAR', @DRConcepto,
                                @Contacto, @ContactoEnviarA, @ContactoMoneda, @ContactoTipoCambio, @DREsCredito, 'PP/RECARGO', @Mov, @MovID)
                  IF @Modulo = 'CXP'
                    INSERT Cxp (Sucursal, Empresa, Mov, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Estatus, Concepto,
                                Proveedor, ProveedorMoneda, ProveedorTipoCambio, AplicaManual, OrigenTipo, Origen, OrigenID)
                        VALUES (@Sucursal, @Empresa, @DRMov, @FechaEmision, @Proyecto, @ContactoMoneda, @ContactoTipoCambio, @Usuario, @Referencia, 'SINAFECTAR', @DRConcepto,
                                @Contacto, @ContactoMoneda, @ContactoTipoCambio, @DREsCredito, 'PP/RECARGO', @Mov, @MovID)
                  SELECT @DRID = SCOPE_IDENTITY()
                END

                SELECT @DRRenglon = @DRRenglon + 2048.0
                IF @Modulo = 'CXC' INSERT INTO CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @DRID, @DRRenglon, 0, @DRAplica, @DRAplicaID, @DescuentoRecargos)
                IF @Modulo = 'CXP' INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @DRID, @DRRenglon, 0, @DRAplica, @DRAplicaID, @DescuentoRecargos)
                SELECT @DRImporteTotal = @DRImporteTotal + @DescuentoRecargos
              END
              FETCH NEXT FROM crDescuentoRecargos INTO @DRAplica, @DRAplicaID, @DescuentoRecargos
            END
            CLOSE crDescuentoRecargos
            DEALLOCATE crDescuentoRecargos
            IF @DRID IS NOT NULL
            BEGIN
              SELECT @DRImpuestos = @DRImpuestos + ((@DRImporteTotal/(1+(@IVA/100.0)))*(@IVA/100.0))
              SELECT @DRImporte = @DRImporteTotal - @DRImpuestos
              IF @Modulo = 'CXC' UPDATE Cxc SET Importe = @DRImporte, Impuestos = @DRImpuestos WHERE ID = @DRID ELSE
              IF @Modulo = 'CXP' UPDATE Cxp SET Importe = @DRImporte, Impuestos = @DRImpuestos WHERE ID = @DRID 
              EXEC spMovCopiarAnexos @Sucursal, @Modulo, @ID, @Modulo, @DRID
              EXEC spCx @DRID, @Modulo, 'AFECTAR', 'TODO', @FechaEmision, NULL, @Usuario, 1, 0, @DRMov OUTPUT, @DRMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

              SELECT @Renglon = @Renglon + 2048.0
              IF @Modulo = 'CXC' INSERT INTO CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Ligado, LigadoDR) VALUES (@Sucursal, @ID, @Renglon, 0, @DRMov, @DRMovID, -@DRImporteTotal*@ContactoFactor, @DREsCredito, 1)
              IF @Modulo = 'CXP' INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Ligado, LigadoDR) VALUES (@Sucursal, @ID, @Renglon, 0, @DRMov, @DRMovID, -@DRImporteTotal*@ContactoFactor, @DREsCredito, 1)
              EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @DRID, @DRMov, @DRMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
            END

            -- Recargos
      	    SELECT @DREsCredito = 0, @DRMov = @MovRecargos, @DRConcepto = @ConceptoRecargos,
                   @DRID = NULL, @DRRenglon = 0.0, @DRImporte = 0.0, @DRImpuestos = 0.0, @DRImporteTotal = 0.0
            IF @Modulo = 'CXC' DECLARE crDescuentoRecargos CURSOR LOCAL FOR SELECT Aplica, AplicaID, ISNULL(DescuentoRecargos, 0.0)/@ContactoFactor FROM CxcD WHERE ID = @ID AND ISNULL(DescuentoRecargos, 0.0) > 0.0 ELSE
            IF @Modulo = 'CXP' DECLARE crDescuentoRecargos CURSOR LOCAL FOR SELECT Aplica, AplicaID, ISNULL(DescuentoRecargos, 0.0)/@ContactoFactor FROM CxpD WHERE ID = @ID AND ISNULL(DescuentoRecargos, 0.0) > 0.0 
            OPEN crDescuentoRecargos
            FETCH NEXT FROM crDescuentoRecargos INTO @DRAplica, @DRAplicaID, @DescuentoRecargos
            WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
            BEGIN                         
              IF @@FETCH_STATUS <> -2 
              BEGIN
                IF @DRID IS NULL
                BEGIN
                  IF @Modulo = 'CXC'
                    INSERT Cxc (Sucursal, Empresa, Mov, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Estatus, Concepto, 
                                Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio, AplicaManual, OrigenTipo, Origen, OrigenID)
                        VALUES (@Sucursal, @Empresa, @DRMov, @FechaEmision, @Proyecto, @ContactoMoneda, @ContactoTipoCambio, @Usuario, @Referencia, 'SINAFECTAR', @DRConcepto,
                                @Contacto, @ContactoEnviarA, @ContactoMoneda, @ContactoTipoCambio, @DREsCredito, 'PP/RECARGO', @Mov, @MovID)
                  IF @Modulo = 'CXP'
                    INSERT Cxp (Sucursal, Empresa, Mov, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Estatus, Concepto,
                                Proveedor, ProveedorMoneda, ProveedorTipoCambio, AplicaManual, OrigenTipo, Origen, OrigenID)
                        VALUES (@Sucursal, @Empresa, @DRMov, @FechaEmision, @Proyecto, @ContactoMoneda, @ContactoTipoCambio, @Usuario, @Referencia, 'SINAFECTAR', @DRConcepto,
                                @Contacto, @ContactoMoneda, @ContactoTipoCambio, @DREsCredito, 'PP/RECARGO', @Mov, @MovID)
                  SELECT @DRID = SCOPE_IDENTITY()
                END

                SELECT @DRRenglon = @DRRenglon + 2048.0
                SELECT @DRImporteTotal = @DRImporteTotal + @DescuentoRecargos
              END
              FETCH NEXT FROM crDescuentoRecargos INTO @DRAplica, @DRAplicaID, @DescuentoRecargos
            END
            CLOSE crDescuentoRecargos
            DEALLOCATE crDescuentoRecargos
            IF @DRID IS NOT NULL
            BEGIN
              SELECT @DRImpuestos = @DRImpuestos + ((@DRImporteTotal/(1+(@IVA/100.0)))*(@IVA/100.0))
              SELECT @DRImporte = @DRImporteTotal - @DRImpuestos
              IF @Modulo = 'CXC' UPDATE Cxc SET Importe = @DRImporte, Impuestos = @DRImpuestos WHERE ID = @DRID ELSE
              IF @Modulo = 'CXP' UPDATE Cxp SET Importe = @DRImporte, Impuestos = @DRImpuestos WHERE ID = @DRID 
              EXEC spMovCopiarAnexos @Sucursal, @Modulo, @ID, @Modulo, @DRID
              EXEC spCx @DRID, @Modulo, 'AFECTAR', 'TODO', @FechaEmision, NULL, @Usuario, 1, 0, @DRMov OUTPUT, @DRMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

              EXEC spValidarTareas @Empresa, @Modulo, @DRID, 'CONCLUIDO', @Ok OUTPUT, @OkRef OUTPUT
              IF @Modulo = 'CXC' UPDATE Cxc SET Estatus = 'CONCLUIDO', FechaConclusion = @FechaEmision, Saldo = NULL, UltimoCambio = @FechaEmision WHERE ID = @DRID ELSE
              IF @Modulo = 'CXP' UPDATE Cxp SET Estatus = 'CONCLUIDO', FechaConclusion = @FechaEmision, Saldo = NULL, UltimoCambio = @FechaEmision WHERE ID = @DRID 
              EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @ContactoMoneda, @ContactoTipoCambio, @Contacto, NULL, NULL, NULL,
                           @Modulo, @ID, @Mov, @MovID, @EsCargo, @DRImporteTotal, NULL, NULL,
                           @FechaAfectacion, @Ejercicio, @Periodo, @DRMov, @DRMovID, 0, 0, 0,
                           @Ok OUTPUT, @OkRef OUTPUT

              SELECT @Renglon = @Renglon + 2048.0
              IF @Modulo = 'CXC' INSERT INTO CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Ligado, LigadoDR) VALUES (@Sucursal, @ID, @Renglon, 0, @DRMov, @DRMovID, @DRImporteTotal*@ContactoFactor, @DREsCredito, 1)
              IF @Modulo = 'CXP' INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Ligado, LigadoDR) VALUES (@Sucursal, @ID, @Renglon, 0, @DRMov, @DRMovID, @DRImporteTotal*@ContactoFactor, @DREsCredito, 1)
              EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @DRID, @DRMov, @DRMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
            END
          END 

          -- Aplicar Diferencias
          IF /*@CfgAplicaDif = 1 AND */ABS(@Saldo) > @AutoAjusteMov AND @Ok IS NULL
          BEGIN
            IF @Saldo < 0.0 SELECT @AplicaDifEnRojo = 1 ELSE SELECT @AplicaDifEnRojo = 0
            IF @Modulo = 'CXC' DECLARE crAplicaDif CURSOR LOCAL FOR SELECT NULLIF(RTRIM(Mov), ''), Concepto, ISNULL(Importe, 0.0), ISNULL(Impuestos, 0.0), Referencia, ClienteEnviarA     FROM CxcAplicaDif WHERE ID = @ID ELSE
            IF @Modulo = 'CXP' DECLARE crAplicaDif CURSOR LOCAL FOR SELECT NULLIF(RTRIM(Mov), ''), Concepto, ISNULL(Importe, 0.0), ISNULL(Impuestos, 0.0), Referencia, CONVERT(int, NULL) FROM CxpAplicaDif WHERE ID = @ID 
            OPEN crAplicaDif
            FETCH NEXT FROM crAplicaDif INTO @AplicaDifMov, @AplicaDifConcepto, @AplicaDifImporte, @AplicaDifImpuestos, @AplicaDifReferencia, @AplicaDifEnviarA
            WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
            BEGIN                         
              IF @@FETCH_STATUS <> -2 
              BEGIN
                SELECT @AplicaDifMovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @AplicaDifMov
                IF @AplicaDifMov IS NULL OR
                   (@AplicaDifEnRojo = 0 AND NOT (UPPER(@AplicaDifMov) = 'SALDO A FAVOR' OR @AplicaDifMovTipo IN ('CXC.NC','CXC.NCD','CXC.NCF','CXP.NC','CXP.NCD','CXP.NCF'))) OR
                   (@AplicaDifEnRojo = 1 AND NOT (@AplicaDifMovTipo IN ('CXC.CA', 'CXC.CAD','CXP.CA','CXP.CAD'))) 
                  SELECT @Ok = 20180

                SELECT @AplicaDifImporteDetalle = @AplicaDifImporte +  @AplicaDifImpuestos
                IF @AplicaDifImporteDetalle <= 0.0 SELECT @Ok = 30100

                IF @AplicaDifEnRojo = 1 
		  SELECT @AplicaDifImporteDetalle = -@AplicaDifImporteDetalle

                SELECT @AplicaDifImporteCto        = @AplicaDifImporte / @ContactoFactor, 
                       @AplicaDifImpuestosCto      = @AplicaDifImpuestos / @ContactoFactor, 
                       @AplicaDifImporteDetalleCto = @AplicaDifImporteDetalle / @ContactoFactor

                IF UPPER(@AplicaDifMov) = 'SALDO A FAVOR'
                   EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @RamaEfectivo, @ContactoMoneda, @ContactoTipoCambio, @Contacto, NULL, NULL, NULL,
                               @Modulo, @ID, @Mov, @MovID, 0, @AplicaDifImporteDetalleCto, NULL, NULL,
                               @FechaAfectacion, @Ejercicio, @Periodo, @AplicaDifMov, NULL, 0, 0, 0,
                               @Ok OUTPUT, @OkRef OUTPUT
                ELSE 
                BEGIN
                  IF @Modulo = 'CXC'
                    INSERT Cxc (Sucursal, Empresa, Mov, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Estatus, Concepto, 
                                Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio, Condicion, Vencimiento, Importe, Impuestos, AplicaManual, OrigenTipo, Origen, OrigenID, Indirecto)
                        VALUES (@Sucursal, @Empresa, @AplicaDifMov, @FechaEmision, @Proyecto, @ContactoMoneda, @ContactoTipoCambio, @Usuario, @AplicaDifReferencia, 'SINAFECTAR', @AplicaDifConcepto,
                                @Contacto, @AplicaDifEnviarA, @ContactoMoneda, @ContactoTipoCambio, @Condicion, @Vencimiento, @AplicaDifImporteCto, @AplicaDifImpuestosCto, 0, @Modulo, @Mov, @MovID, 1)
                  IF @Modulo = 'CXP'
                    INSERT Cxp (Sucursal, Empresa, Mov, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Estatus, Concepto,
                                Proveedor, ProveedorMoneda, ProveedorTipoCambio, Condicion, Vencimiento, Importe, Impuestos, AplicaManual, OrigenTipo, Origen, OrigenID, Indirecto)
                        VALUES (@Sucursal, @Empresa, @AplicaDifMov, @FechaEmision, @Proyecto, @ContactoMoneda, @ContactoTipoCambio, @Usuario, @AplicaDifReferencia, 'SINAFECTAR', @AplicaDifConcepto,
                                @Contacto, @ContactoMoneda, @ContactoTipoCambio, @Condicion, @Vencimiento, @AplicaDifImporteCto, @AplicaDifImpuestosCto, 0, @Modulo, @Mov, @MovID, 1)
                  SELECT @AplicaDifID = SCOPE_IDENTITY()
                  -- Copiar Anexos
                  EXEC spMovCopiarAnexos @Sucursal, @Modulo, @ID, @Modulo, @AplicaDifID
                  --BUG 13489
                  --EXEC xpCxAplicaDifMov @ID, @AplicaDifID, @Modulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, @Conexion,
                       --@SincroFinal, @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
                  EXEC spCx @AplicaDifID, @Modulo, 'AFECTAR', 'TODO', @FechaEmision, NULL, @Usuario, 1, 0, @AplicaDifMov OUTPUT, @AplicaDifMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
                END

                SELECT @Renglon = @Renglon + 2048.0
                IF @Modulo = 'CXC' INSERT INTO CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Ligado) VALUES (@Sucursal, @ID, @Renglon, 0, @AplicaDifMov, @AplicaDifMovID, @AplicaDifImporteDetalle, 1)
                IF @Modulo = 'CXP' INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Ligado) VALUES (@Sucursal, @ID, @Renglon, 0, @AplicaDifMov, @AplicaDifMovID, @AplicaDifImporteDetalle, 1)

                --EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @AplicaDifID, @AplicaDifMov, @AplicaDifMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT BUG8660
                
                EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @AplicaDifID, @AplicaDifMov, @AplicaDifMovID, @Ok OUTPUT -- BUG8660

                SELECT @Renglon = @Renglon + 2048.0, @Saldo = ROUND(@Saldo - @AplicaDifImporteDetalle, @RedondeoMonetarios)
              END
              FETCH NEXT FROM crAplicaDif INTO @AplicaDifMov, @AplicaDifConcepto, @AplicaDifImporte, @AplicaDifImpuestos, @AplicaDifReferencia, @AplicaDifEnviarA
            END
            CLOSE crAplicaDif
            DEALLOCATE crAplicaDif
          END 

          IF @Saldo <> 0.0 AND @Ok IS NULL
          BEGIN
            SELECT @SaldoCto = @Saldo/@ContactoFactor
            /*IF @CfgControlEfectivo = 1 AND ABS(@Saldo) >= @TopeEfectivoAuto 
            BEGIN             
              IF @Saldo < 0.0
                SELECT @DiversoMov = @CfgMovCargoDiverso
              ELSE
                SELECT @DiversoMov = @CfgMovCreditoDiverso
 
	      SELECT @DiversoImporte = ABS(@ContactoImporte), @DiversoSaldo = @Saldo

              IF @Modulo = 'CXC'
                INSERT Cxc (Sucursal, Empresa, Mov, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Estatus,
                            Cliente, ClienteMoneda, ClienteTipoCambio, Condicion, Vencimiento, Importe, AplicaManual, OrigenTipo, Origen, OrigenID, Indirecto)
                    VALUES (@Sucursal, @Empresa, @DiversoMov, @FechaEmision, @Proyecto, @ContactoMoneda, @ContactoTipoCambio, @Usuario, @Referencia, 'SINAFECTAR',
                            @Contacto, @ContactoMoneda, @ContactoTipoCambio, @Condicion, @Vencimiento, @DiversoImporte ,0, @Modulo, @Mov, @MovID, 1)
              IF @Modulo = 'CXP'
                INSERT Cxp (Sucursal, Empresa, Mov, FechaEmision, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Estatus,
                            Proveedor, ProveedorMoneda, ProveedorTipoCambio, Condicion, Vencimiento, Importe, AplicaManual, OrigenTipo, Origen, OrigenID, Indirecto)
                    VALUES (@Sucursal, @Empresa, @DiversoMov, @FechaEmision, @Proyecto, @ContactoMoneda, @ContactoTipoCambio, @Usuario, @Referencia, 'SINAFECTAR',
                            @Contacto, @ContactoMoneda, @ContactoTipoCambio, @Condicion, @Vencimiento, @DiversoImporte ,0, @Modulo, @Mov, @MovID, 1)
              SELECT @DiversoID = SCOPE_IDENTITY()
	      -- Copiar Anexos
              EXEC spMovCopiarAnexos @Sucursal, @Modulo, @ID, @Modulo, @DiversoID

              EXEC spCx @DiversoID, @Modulo, 'AFECTAR', 'TODO', @FechaEmision, NULL, @Usuario, 1, 0, @DiversoMov OUTPUT, @DiversoMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
   
              IF @Modulo = 'CXC' INSERT INTO CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Ligado) VALUES (@Sucursal, @ID, @Renglon, 0, @DiversoMov, @DiversoMovID, @DiversoSaldo, 1)
              IF @Modulo = 'CXP' INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe, Ligado) VALUES (@Sucursal, @ID, @Renglon, 0, @DiversoMov, @DiversoMovID, @DiversoSaldo, 1)
              EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @DiversoID, @DiversoMov, @DiversoMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
            END ELSE*/
            IF @MovTipo IN ('CXC.AA', 'CXC.AF', 'CXP.AA', 'CXP.AF')
            BEGIN
              SELECT @Renglon = @Renglon + 2048.0
              IF @Modulo = 'CXC' INSERT INTO CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @ID, @Renglon, 0, 'Saldo a Favor', NULL, @Saldo) ELSE
              IF @Modulo = 'CXP' INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @ID, @Renglon, 0, 'Saldo a Favor', NULL, @Saldo) 
              IF @@ERROR <> 0 SELECT @Ok = 1

              EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @RamaEfectivo, @ContactoMoneda, @ContactoTipoCambio, @Contacto, NULL, NULL, NULL,
                           @Modulo, @ID, @Mov, @MovID, 0, @SaldoCto, NULL, NULL,
                           @FechaAfectacion, @Ejercicio, @Periodo, 'Saldo a Favor', NULL, 0, 0, 0,
                           @Ok OUTPUT, @OkRef OUTPUT
            END ELSE
            IF ABS(@Saldo) <= @AutoAjusteMov 
            BEGIN
              SELECT @Renglon = @Renglon + 2048.0
              -- Insertar en el Detalle "Redondeo"
              --BUG16710
              IF @Modulo = 'CXC' INSERT INTO CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @ID, @Renglon, 0, 'Redondeo', NULL, @Saldo) ELSE
              IF @Modulo = 'CXP' INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @ID, @Renglon, 0, 'Redondeo', NULL, @Saldo) 
              IF @@ERROR <> 0 SELECT @Ok = 1
 			  --BUG16710
 			  --SELECT @SaldoCto=@SaldoCto*(-1)
              EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @RamaRedondeo, @ContactoMoneda, @ContactoTipoCambio, @Contacto, NULL, NULL, NULL,
                           @Modulo, @ID, @Mov, @MovID, 0, @SaldoCto, NULL, NULL,
                           @FechaAfectacion, @Ejercicio, @Periodo, 'Redondeo', NULL, 0, 0, 0,
                           @Ok OUTPUT, @OkRef OUTPUT
            END ELSE 
              SELECT @Ok = 30230, @OkRef = 'Diferencia: '+LTRIM(CONVERT(char, @Saldo))
          END 
        END/* ELSE 
          IF ABS(@Saldo) > @AutoAjuste AND @CfgAplicaDif = 0 AND @TieneDescuentoRecargos = 0 AND @Ok IS NULL
            SELECT @Ok = 30230, @OkRef = 'Diferencia: '+LTRIM(CONVERT(char, @Saldo))*/
      END
    END
  END
  IF @VerificarAplica = 1 AND @MovTipo = 'CXP.PAG' AND @Ok IS NULL AND @Vencimiento < @UltimoVencimiento
    SELECT @Condicion = '(Fecha)', @Vencimiento = @UltimoVencimiento 

  IF @VerificarAplica = 0 AND @CfgAC = 1 AND @Ok IS NULL AND @MovTipo = 'CXC.C'
    EXEC spCxFacturarIntereses @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @Sucursal, @Ok OUTPUT,  @OkRef OUTPUT

  IF @VerificarAplica = 0
  BEGIN
    DELETE MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID
    IF EXISTS(SELECT * FROM #CxAplicaMovImpuesto)
    BEGIN
      INSERT MovImpuesto 
            (Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,		    OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,      Importe2,      Importe3,      SubTotal,      ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
      SELECT @Modulo, @ID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, SUM(Importe1), SUM(Importe2), SUM(Importe3), SUM(SubTotal), ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
        FROM #CxAplicaMovImpuesto
       GROUP BY OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
       ORDER BY OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
    END
    IF @PPTO = 1 
    BEGIN
      IF EXISTS(SELECT * FROM #CxAplicaMovPresupuesto)
      BEGIN
        INSERT MovPresupuesto
              (Modulo,  ModuloID, CuentaPresupuesto, Importe)
        SELECT @Modulo, @ID,      CuentaPresupuesto, SUM(Importe)
          FROM #CxAplicaMovPresupuesto
         GROUP BY CuentaPresupuesto
         ORDER BY CuentaPresupuesto
      END
    END
  END

  RETURN
END
GO


/**************** spCxCancelarDocAuto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxCancelarDocAuto') and type = 'P') drop procedure dbo.spCxCancelarDocAuto
GO
CREATE PROCEDURE spCxCancelarDocAuto
			@Empresa	char(5),
			@Usuario	char(10),
    		    	@Modulo	      	char(5),
    		    	@ID        	int,
			@Mov        	char(20),
    			@MovID		varchar(20),

			@Verificar	bit,
    			@FechaRegistro	datetime,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo		int,
    @ImporteTotal	money,
    @SaldoTotal		money,
    @CxID		int,
    @CxMov 		char(20), 
    @CxMovID 		varchar(20), 
    @IDGenerar		int

  IF @Verificar = 1
  BEGIN
    SELECT @SaldoTotal = 0
    IF @Modulo = 'CXC' SELECT @Conteo = COUNT(*), @ImporteTotal = ISNULL(SUM(Importe), 0) + ISNULL(SUM(Impuestos), 0), @SaldoTotal = ISNULL(SUM(Saldo), 0) FROM Cxc WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
    IF @Modulo = 'CXP' SELECT @Conteo = COUNT(*), @ImporteTotal = ISNULL(SUM(Importe), 0) + ISNULL(SUM(Impuestos), 0), @SaldoTotal = ISNULL(SUM(Saldo), 0) FROM Cxp WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
    IF @Conteo>0 AND ROUND(@ImporteTotal, 2) <> ROUND(@SaldoTotal, 2)
      SELECT @Ok = 60060
      
    IF @Modulo = 'CXP' AND @Ok IS NULL BEGIN
      DECLARE @IDCxP		int,
              @EstatusCxP	varchar(20),
    	      @IDSuc		int

      SELECT @EstatusCxP = NULL
      SELECT @IDSuc = Sucursal FROM CxP WHERE ID = @ID AND Empresa = @Empresa
      SELECT @IDCxP = ID FROM CxPD WHERE Sucursal = @IDSuc AND Aplica = @Mov AND AplicaID = @MovID

      SELECT @EstatusCxP = Estatus
        FROM CxP 
       WHERE ID = @IDCxP

      IF @EstatusCxP NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
        SELECT @Ok = 60060
    END
  END ELSE
  BEGIN
    IF @Modulo = 'CXC' DECLARE crCancelarDocAuto CURSOR LOCAL FOR SELECT ID FROM Cxc WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
    IF @Modulo = 'CXP' DECLARE crCancelarDocAuto CURSOR LOCAL FOR SELECT ID FROM Cxp WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
    OPEN crCancelarDocAuto
    FETCH NEXT FROM crCancelarDocAuto INTO @CxID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 
        EXEC spCx @CxID, @Modulo, 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @CxMov OUTPUT, @CxMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      FETCH NEXT FROM crCancelarDocAuto INTO @CxID
    END
    CLOSE crCancelarDocAuto
    DEALLOCATE crCancelarDocAuto
  END
  RETURN
END
GO

/**************** spCxVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxVerificar') and type = 'P') drop procedure dbo.spCxVerificar
GO
CREATE PROCEDURE spCxVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
		    @Autorizacion		char(10),
		    @Mensaje			int,
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,

		    @FechaEmision		datetime,
    		    @Condicion			varchar(50) OUTPUT,
    		    @Vencimiento		datetime    OUTPUT,
		    @FormaPago			varchar(50),
		    @Referencia			varchar(50),
                    @Contacto			char(10),
		    @ContactoTipo		char(20),
 		    @ContactoEnviarA		int,
                    @ContactoMoneda		char(10),
		    @ContactoFactor		float,
		    @ContactoTipoCambio		float,
		    @Importe			money,
             	    @ValesCobrados		money,
		    @Impuestos			money,
		    @Retencion			money,	
		    @Retencion2			money,	
		    @Retencion3			money,	
		    @Saldo			money,
		    @CtaDinero			char(10),
		    @Agente			char(10),
  		    @AplicaManual               bit,
		    @ConDesglose		bit,
		    @CobroDesglosado		money, 
		    @CobroDelEfectivo		money, 
		    @CobroCambio		money,

		    @Indirecto			bit,
		    @Conexion			bit,
		    @SincroFinal		bit,
             	    @Sucursal			int,
		    @SucursalDestino		int,
		    @SucursalOrigen		int,

 	    	    @EstatusNuevo	      	char(15),
                    @AfectarCantidadPendiente  	bit,
                    @AfectarCantidadA   	bit,

		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @CfgEmbarcar		bit,
		    @AutoAjuste			money,
		    @AutoAjusteMov		money,
		    /*@CfgAplicaDif		bit,*/
		    @CfgDescuentoRecargos	bit,
		    @CfgFormaCobroDA		varchar(50),
		    @CfgRefinanciamientoTasa	float,
		    @CfgAnticiposFacturados	bit,
		    @CfgValidarPPMorosos	bit,
		    @CfgAC			bit,

		    @Pagares			bit,

		    @OrigenTipo			char(10),
		    @OrigenMovTipo		char(20),
		    @MovAplica			char(20),
 		    @MovAplicaID		varchar(20),
		    @MovAplicaMovTipo		char(20),

		    @AgenteNomina		bit,
		    @RedondeoMonetarios		int,	

		    @Autorizar			bit	     OUTPUT,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT,

		    @INSTRUCCIONES_ESP		varchar(20) 	= NULL,
			@EmidaCarrierID varchar(255) -- BUG 17069

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @DA				bit,
    @AplicaMov			char(20),
    @AplicaMovID		varchar(20),
    @AplicaSaldo		money,
    @AplicaImporteTotal		money,
    @AplicaContacto		char(10),
    @AplicaMoneda		char(10),
    @AplicaAforo		money,
    @MovAplicaEstatus		char(15),
    @ContactoImporte		money,
    @CANTSaldo			money,
    @ImporteTotal		money,
    @ImporteAplicado		money,
    @Efectivo			money,
    @Anticipos			money,
    @CtaDineroMoneda		char(10),
    @CtaDineroTipo		char(20),
    @TieneDescuentoRecargos	bit,
    @AplicaPosfechado		bit,
    @ContactoEstatus		char(15),
    @ValeEstatus		char(15),
    @AforoImporte		money,
    @TarjetasCobradas		money, 	-- ETO Tarjetas 9-Feb-2007
    @FormaCobroTarjetas		varchar(50), 
    @Importe1			money,
    @Importe2			money,
    @Importe3			money,
    @Importe4			money,
    @Importe5			money,
    @FormaCobro1		varchar(50),
    @FormaCobro2		varchar(50),
    @FormaCobro3		varchar(50),
    @FormaCobro4		varchar(50),
    @FormaCobro5		varchar(50),   -- ETO Tarjetas 9-Feb-2007
    @CFDFlex                    bit,   --REQ 13386 
    @LDI                        bit,   --REQ 13386
	@SubMovTipo			varchar(20),   --BUG 17069
	@InterfazEmida		bit			   --BUG 20509

	
	
 --REQ 13386 
  SELECT @CFDFlex = CFDFlex FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo    
  
  SELECT @LDI  = ISNULL(InterfazLDI,0),            --REQ 13386  
         @InterfazEmida = ISNULL(InterfazEmida, 0) --BUG 20509
    FROM EmpresaGral
   WHERE Empresa = @Empresa
  

  SELECT @AplicaPosfechado = 0,
         @Autorizar 	   = 0,
	 @AforoImporte 	   = 0.0,
         @DA		   = 0

  -- BUG 17069
  SELECT @SubMovTipo=ISNULL(SubClave,'')
    FROM MovTipo
   WHERE Modulo=@Modulo
     AND Clave=@MovTipo

  IF @MovTipo IN ('CXC.VV', 'CXC.OV', 'CXC.DV', 'CXC.AV', 'CXC.SD', 'CXC.SCH', 'CXP.SD', 'CXP.SCH') AND @Conexion = 0 SELECT @Ok = 60160
  -- Si el movimiento no debe de llevar impuestos borrar el campo
  IF @MovTipo NOT IN ('CXC.C','CXC.CD','CXC.D','CXC.DM','CXC.A','CXC.RA','CXC.AR','CXC.AA','CXC.DE','CXC.F','CXC.FA','CXC.DFA','CXC.AF','CXC.CA','CXC.VV','CXC.OV','CXC.IM','CXC.RM','CXC.NC','CXC.DV','CXC.NCP','CXC.CAP', 
                      'CXP.A','CXP.AA','CXP.DE','CXP.F','CXP.AF','CXP.CA','CXP.NC','CXP.NCP','CXP.CAP',
                      'AGENT.P','AGENT.CO','CXC.FAC','CXP.FAC') AND @Impuestos <> 0.0
    SELECT @Ok = 20870
     
  IF @Accion = 'CANCELAR'
  BEGIN
    IF @Indirecto = 1 AND @Conexion = 0 SELECT @Ok = 60180
    IF @OrigenMovTipo = 'CXC.NCF' AND @Conexion = 0 SELECT @Ok = 60180

    IF @MovTipo IN ('CXC.F', 'CXC.CA', 'CXC.CAP', 'CXC.CAD', 'CXC.D', 'CXC.DM', 'CXP.F', 'CXP.CA', 'CXP.CAP', 'CXP.CAD', 'CXP.D', 'CXP.DM') AND @Condicion IS NOT NULL
    BEGIN
      IF @CfgAC = 1 OR EXISTS(SELECT * FROM Condicion WHERE Condicion = @Condicion AND DA = 1)
      BEGIN
        EXEC spCxCancelarDocAuto @Empresa, @Usuario, @Modulo, @ID, @Mov, @MovID, 1, NULL, @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL SELECT @DA = 1
      END
    END

    IF @DA=0 AND @MovTipo IN ('CXC.F','CXC.FA','CXC.FAC','CXC.DAC','CXC.AF','CXC.CA', 'CXC.CAD','CXC.CAP','CXC.VV','CXC.OV','CXC.IM','CXC.RM','CXC.D','CXC.DM','CXC.DA','CXC.DP', 'CXC.CD',
                              'CXP.F','CXP.AF','CXP.FAC','CXP.DAC','CXP.CA','CXP.CAD','CXP.CAP','CXP.D','CXP.DM','CXP.PAG','CXP.DA','CXP.DP', 'CXP.CD', 'CXP.FAC',
                              'AGENT.C', 'AGENT.D', 'AGENT.A', 'CXC.A','CXC.AR','CXC.NC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP','CXP.A','CXP.NC','CXP.NCD','CXP.NCF','CXP.NCP',
			      'CXC.SD', 'CXC.SCH', 'CXP.SD', 'CXP.SCH') 
			      --OR (@MovTipo IN ('CXC.NC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP','CXP.NC','CXP.NCD','CXP.NCF','CXP.NCP') AND @Conexion = 1)
    BEGIN
      IF NOT (@MovTipo = 'CXC.OV' AND @Conexion = 1)
      BEGIN
        IF @MovMoneda = @ContactoMoneda 
        BEGIN
          IF ABS(ROUND(@Saldo + @AforoImporte, 2) - ROUND(@Importe + @Impuestos - @Retencion - @Retencion2 - @Retencion3, 2)) > .5 SELECT @Ok = 60060
        END ELSE
        BEGIN
          IF ROUND((@Saldo  + @AforoImporte) * @ContactoTipoCambio, 2) <> ROUND((@Importe + @Impuestos - @Retencion - @Retencion2 - @Retencion3) * @MovTipoCambio, 2) SELECT @Ok = 60060
        END
      END

      -- En el caso de las N/Credito si tuvo aplicacion Directa no es Error
      IF @Ok IS NOT NULL AND @MovTipo IN ('CXC.CA','CXC.CAD','CXC.CAP','CXC.A','CXC.AR','CXC.NC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP',
                                          'CXP.CA','CXP.CAD','CXP.CAP','CXP.A','CXP.NC','CXP.NCD','CXP.NCF','CXP.NCP')
      BEGIN
        IF @Modulo = 'CXC' AND EXISTS (SELECT * FROM Cxc c, CxcD d WHERE c.ID = @ID AND c.AplicaManual = 1 AND c.ID = d.ID) SELECT @Ok = NULL ELSE
        IF @Modulo = 'CXP' AND EXISTS (SELECT * FROM Cxp c, CxpD d WHERE c.ID = @ID AND c.AplicaManual = 1 AND c.ID = d.ID) SELECT @Ok = NULL 
      END

      IF @OrigenTipo IN ('PAGARE','PP/RECARGO' ,'RETENCION') AND @Conexion = 0 SELECT @Ok = 60072 -- Esto se hizo por los Descuentos/Recargos
      IF @OrigenTipo = 'ENDOSO' AND @Conexion = 0 SELECT @Ok = 60070
    END

    IF @MovTipo = 'CXC.FA'
    BEGIN
      SELECT @CANTSaldo = 0.0
      SELECT @CANTSaldo = SUM(ISNULL(ROUND(Saldo, @RedondeoMonetarios), 0.0)) FROM Saldo WHERE Rama = 'CANT' AND Empresa = @Empresa AND Moneda = @MovMoneda AND Cuenta = @Contacto
      IF ROUND(@Importe + @Impuestos - @Retencion - @Retencion2 - @Retencion3, @RedondeoMonetarios) > @CANTSaldo
        SELECT @Ok = 30410
    END

    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
    BEGIN
      IF @OrigenMovTipo IS NOT NULL
      BEGIN
        IF @MovTipo IN ('CXC.F','CXC.CA', 'CXC.FA','CXC.AF','CXC.A','CXC.AR','CXC.NC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP','CXC.AJE', 'CXP.F','CXP.AF','CXP.A','CXP.NC','CXP.NCD','CXP.NCF','CXP.NCP','CXP.AJE', 'AGENT.C', 'AGENT.D')
          IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
            SELECT @Ok = 60070
        IF @MovTipo IN ('CXC.A', 'CXC.AR', 'CXP.A') AND @OrigenMovTipo IS NOT NULL 
          SELECT @Ok = 60070
      END
    END
    
    IF @MovTipo IN ('CXC.DC', 'CXC.DE')
    BEGIN
      SELECT @FormaCobroTarjetas = CxcFormaCobroTarjetas FROM EmpresaCfg WHERE Empresa = @Empresa
      SELECT @TarjetasCobradas = 0.0

      SELECT @ConDesglose = ConDesglose,
             @ImporteTotal = ISNULL(Importe, 0)+ISNULL(Impuestos, 0),
             @Importe1 = ISNULL(Importe1, 0), @FormaCobro1 = FormaCobro1,
             @Importe2 = ISNULL(Importe2, 0), @FormaCobro2 = FormaCobro2,
             @Importe3 = ISNULL(Importe3, 0), @FormaCobro3 = FormaCobro3,
             @Importe4 = ISNULL(Importe4, 0), @FormaCobro4 = FormaCobro4,
             @Importe5 = ISNULL(Importe5, 0), @FormaCobro5 = FormaCobro5
        FROM Cxc
       WHERE ID = @ID

      -- 9150
      IF NULLIF(@FormaPago, '') IS NOT NULL AND @ConDesglose = 0 AND NULLIF(@Ok, 0) IS NULL
      BEGIN
        IF dbo.fnFormaPagoVerificar(@Empresa, @FormaPago, @Modulo, @Mov, @Usuario, '(Forma Pago)', 0) = 0
          SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago') + '. ' + @FormaPago
      END
      IF NULLIF(@FormaCobro1, '') IS NOT NULL AND @ConDesglose = 1 AND NULLIF(@Ok, 0) IS NULL
      BEGIN
        IF dbo.fnFormaPagoVerificar(@Empresa, @FormaCobro1, @Modulo, @Mov, @Usuario, '(Forma Pago 1)', 1) = 0
          SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago 1') + '. ' + @FormaCobro1
      END
      IF NULLIF(@FormaCobro2, '') IS NOT NULL AND @ConDesglose = 1 AND NULLIF(@Ok, 0) IS NULL
      BEGIN
        IF dbo.fnFormaPagoVerificar(@Empresa, @FormaCobro2, @Modulo, @Mov, @Usuario, '(Forma Pago 2)', 1) = 0
          SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago 2') + '. ' + @FormaCobro2
      END
      IF NULLIF(@FormaCobro3, '') IS NOT NULL AND @ConDesglose = 1 AND NULLIF(@Ok, 0) IS NULL
      BEGIN
        IF dbo.fnFormaPagoVerificar(@Empresa, @FormaCobro3, @Modulo, @Mov, @Usuario, '(Forma Pago 3)', 1) = 0
          SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago 3') + '. ' + @FormaCobro3
      END
      IF NULLIF(@FormaCobro4, '') IS NOT NULL AND @ConDesglose = 1 AND NULLIF(@Ok, 0) IS NULL
      BEGIN
        IF dbo.fnFormaPagoVerificar(@Empresa, @FormaCobro4, @Modulo, @Mov, @Usuario, '(Forma Pago 4)', 1) = 0
          SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago 4') + '. ' + @FormaCobro4
      END
      IF NULLIF(@FormaCobro5, '') IS NOT NULL AND @ConDesglose = 1 AND NULLIF(@Ok, 0) IS NULL
      BEGIN
        IF dbo.fnFormaPagoVerificar(@Empresa, @FormaCobro5, @Modulo, @Mov, @Usuario, '(Forma Pago 5)', 1) = 0
          SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago 5') + '. ' + @FormaCobro5
      END                                            
      
      IF @ConDesglose = 0 AND @ImporteTotal > 0.0 AND @FormaPago = @FormaCobroTarjetas
      BEGIN
        SELECT @TarjetasCobradas = @ImporteTotal, @FormaCobro1 = @FormaPago
      END
      ELSE
      BEGIN
        IF @FormaCobro1 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe1
        IF @FormaCobro2 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe2
        IF @FormaCobro3 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe3
        IF @FormaCobro4 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe4
        IF @FormaCobro5 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe5
      END

      IF @TarjetasCobradas > 0.0
        EXEC spValeValidarCobro @Empresa, @Modulo, @ID, @Accion, @FechaEmision, @ValesCobrados, @TarjetasCobradas, @MovMoneda, @Ok OUTPUT, @OkRef OUTPUT
    END    
  END ELSE
  BEGIN
    IF @MovTipo IN ('CXC.RE', 'CXP.RE') AND @OrigenTipo <> 'AUTO/RE' SELECT @Ok = 25410
    IF @Modulo = 'CXC'   SELECT @ContactoEstatus = Estatus FROM Cte    WHERE Cliente   = @Contacto ELSE
    IF @Modulo = 'CXP'   SELECT @ContactoEstatus = Estatus FROM Prov   WHERE Proveedor = @Contacto ELSE
    IF @Modulo = 'AGENT' SELECT @ContactoEstatus = Estatus FROM Agente WHERE Agente    = @Contacto 

    IF @Modulo = 'CXP' AND @ContactoEstatus = 'BLOQUEADO' AND @Autorizacion IS NULL 
    BEGIN
      SELECT @Ok = 65032, @OkRef = @Contacto, @Autorizar = 1 
      EXEC xpOk_65032 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
    END

    IF @MovMoneda = @ContactoMoneda AND @MovTipoCambio <> @ContactoTipoCambio AND @MovTipo NOT IN ('CXC.NCF', 'CXP.NCF') SELECT @Ok = 35110

    IF @Contacto IS NULL 
      IF @Modulo = 'CXC' SELECT @Ok = 40010 ELSE SELECT @Ok = 40020

    IF @MovTipo IN ('CXC.FA','CXC.AF','CXC.DE','CXC.DI','CXC.ANC','CXC.ACA','CXP.ACA','CXC.RA','CXC.FAC','CXC.DAC','CXC.AJE','CXC.AJR', 'CXC.DA', 'CXP.AF','CXP.DE','CXP.ANC','CXP.RA','CXP.FAC','CXP.DAC','CXP.AJE','CXP.AJR', 'CXP.DA') AND @MovMoneda <> @ContactoMoneda 
      SELECT @Ok = 30080

    IF @MovTipo IN ('CXC.F','CXC.FA','CXC.AF','CXC.CA', 'CXC.CAD','CXC.CAP','CXC.VV','CXC.CD','CXC.D','CXC.DM','CXC.DA','CXC.DP','CXC.NCP', 'CXP.F','CXP.AF','CXP.CA', 'CXP.CAD','CXP.CAP','CXP.CD','CXP.D','CXP.DM', 'CXP.PAG','CXP.DA','CXP.DP','CXP.NCP') 
      EXEC spVerificarVencimiento @Condicion, @Vencimiento, @FechaEmision, @Ok OUTPUT
--JGD 27Enero2011 Solución Ticket 3331
    IF @MovTipo = 'CXC.C' AND @ConDesglose = 1 
    BEGIN 
      IF @CobroCambio > @CobroDesglosado SELECT @Ok = 30250 ELSE
      IF (@CobroDelEfectivo < 0.0) OR (@CobroDesglosado <= 0.0) SELECT @Ok = 30100 
      --IF @CobroDelEfectivo < 0.0 SELECT @Ok = 30100
    END

    IF @MovTipo IN ('CXC.AE','CXC.DE', 'CXP.AE','CXP.DE') OR (@MovTipo = 'CXC.C' AND @ConDesglose = 1 AND @CobroDelEfectivo > 0.0)
    BEGIN
      SELECT @Efectivo = 0.0
      IF @Modulo = 'CXC'
      BEGIN
        SELECT @Efectivo = ISNULL(Saldo, 0.0) FROM CxcEfectivo WHERE Empresa = @Empresa AND Cliente = @Contacto AND Moneda = @MovMoneda
        IF @MovTipo = 'CXC.C'
        BEGIN
          IF ROUND(@CobroDelEfectivo, 0) > ROUND(-@Efectivo, 0) SELECT @Ok = 30090
        END ELSE
          IF ROUND(@Importe, 0) > ROUND(-@Efectivo, 0) AND @MovTipo NOT IN ('CXC.DE', 'CXP.DE') SELECT @Ok = 30090
      END ELSE
      IF @Modulo = 'CXP'
      BEGIN
        SELECT @Efectivo = ISNULL(Saldo, 0.0) FROM CxpEfectivo WHERE Empresa = @Empresa AND Proveedor = @Contacto AND Moneda = @MovMoneda
        IF ROUND(@Importe, 0) < ROUND(@Efectivo, 0) SELECT @Ok = 30090
      END
    END

    IF @MovTipo = 'CXC.FA' AND @CfgAnticiposFacturados = 0 SELECT @Ok = 70070
    IF @MovTipo = 'CXP.PAG' AND @Pagares = 0 SELECT @Ok = 30560

	-- BUG 17069
	IF @Modulo = 'CXP' AND @MovTipo='CXP.A' AND @SubMovTipo='CXP.AEMIDA' AND @EmidaCarrierID='' AND @InterfazEmida=1 --BUG 20509
    BEGIN    
      SELECT @Ok = 40019
    END

    IF @Ok IS NOT NULL RETURN

    -- Checar Que no pongan importes negativos
    IF (@Importe + @Impuestos - @Retencion - @Retencion2 - @Retencion3 < 0.0 OR ROUND(@Importe, 2) < 0.0 OR ROUND(@Impuestos, 2) < 0.0) AND @MovTipo NOT IN ('CXC.AJE', 'CXC.AJR', 'CXC.AJM', 'CXC.AJA', 'CXP.AJE', 'CXP.AJR', 'CXP.AJM', 'CXP.AJA', 'AGENT.P','AGENT.CO', 'AGENT.C','AGENT.D', 'CXC.RE', 'CXP.RE') SELECT @Ok = 30100

    -- Calcula el Importe Total
    SELECT @ImporteTotal = @Importe + @Impuestos - @Retencion - @Retencion2 - @Retencion3

    IF @MovTipo IN ('CXC.ANC', 'CXC.ACA', 'CXP.ACA', 'CXC.RA', 'CXC.FAC', 'CXC.DAC', 'CXP.ANC', 'CXP.RA', 'CXP.FAC', 'CXP.DAC') AND @Accion <> 'CANCELAR'
    BEGIN
      IF @MovAplica IS NULL OR @MovAplicaID IS NULL SELECT @Ok = 30170
      IF @Ok IS NULL
      BEGIN
        IF @Modulo = 'CXC' SELECT @AplicaSaldo = ISNULL(Saldo, 0.0), @AplicaImporteTotal = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0), 				     @AplicaMoneda = ClienteMoneda,   @AplicaContacto = Cliente,   @MovAplicaEstatus = Estatus FROM Cxc WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
        IF @Modulo = 'CXP' SELECT @AplicaSaldo = ISNULL(Saldo, 0.0), @AplicaImporteTotal = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0), @AplicaAforo = ISNULL(Aforo, 0.0), @AplicaMoneda = ProveedorMoneda, @AplicaContacto = Proveedor, @MovAplicaEstatus = Estatus FROM Cxp WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')

        -- se checa contra el SaldoTotal porque se captitalizan los intereses en los endosos por pagar
/*        IF @MovTipo = 'CXP.FAC' SELECT @AplicaSaldo = ISNULL(Saldo, 0.0) + ISNULL(SaldoInteresesOrdinarios, 0.0) + ISNULL(SaldoInteresesMoratorios, 0.0) FROM Cxp WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')*/

        IF @ImporteTotal > @AplicaSaldo BEGIN
          SELECT @Ok = 30180 
          EXEC xpOk_30180 @Empresa, @Usuario, @Accion, @Modulo, @ID, @MovAplica, @MovAplicaID, @Ok OUTPUT, @OkRef OUTPUT
		END ELSE
        IF @MovAplicaEstatus <> 'PENDIENTE' SELECT @Ok = 30190 ELSE
        IF @MovMoneda <> @AplicaMoneda SELECT @Ok = 20196 ELSE
        IF @MovTipo IN ('CXC.ANC', 'CXC.ACA', 'CXP.ACA', 'CXP.ANC') AND @Contacto <> @AplicaContacto SELECT @Ok = 30192 ELSE
        IF @MovTipo IN ('CXC.RA', 'CXP.RA') AND @Contacto = @AplicaContacto SELECT @Ok = 30500 ELSE
        IF @MovTipo IN ('CXC.FAC', 'CXC.DAC', 'CXP.FAC', 'CXP.DAC')
        BEGIN
          IF (/*UPPER(@ContactoTipo) <> 'INST FINANCIERA' OR */@Contacto = @AplicaContacto) SELECT @Ok = 30505 
--          IF @ImporteTotal <> @AplicaSaldo OR @AplicaSaldo <> @AplicaImporteTotal-@AplicaAforo SELECT @Ok = 30506
        END
        
      END
    END
    IF @MovTipo IN ('CXC.CD', 'CXP.CD') AND @CtaDinero IS NULL SELECT @Ok = 40030
    IF @MovTipo IN ('CXC.RA', 'CXP.RA') AND @MovAplicaMovTipo NOT IN ('CXC.A', 'CXC.AR', 'CXP.A') SELECT @Ok = 20198
    --IF @MovTipo = 'CXC.FAC' AND @MovAplicaMovTipo NOT IN ('CXC.D', 'CXC.DM', 'CXC.F', 'CXC.CA', 'CXC.CAD') SELECT @Ok = 20199
    --IF @MovTipo = 'CXP.FAC' AND @MovAplicaMovTipo NOT IN ('CXP.D', 'CXP.DM', 'CXP.F', 'CXP.CA', 'CXP.CAD', 'CXP.PAG') SELECT @Ok = 20199
  
    IF @MovTipo = 'AGENT.A' AND @AgenteNomina = 1 SELECT @OK = 30360
    IF @MovTipo IN ('CXC.C','CXC.A','CXC.AR','CXC.AA','CXC.DE','CXC.DI','CXC.DC',
                    'CXP.P','CXP.A','CXP.AA','CXP.DE','CXP.DC','CXC.DFA',
                    'AGENT.P','AGENT.CO','AGENT.A') AND @CtaDinero IS NOT NULL AND @Ok IS NULL 
    BEGIN
      SELECT @CtaDineroMoneda = Moneda, @CtaDineroTipo = Tipo FROM CtaDinero WHERE CtaDinero = @CtaDinero
      IF @CtaDineroTipo <> 'Caja' AND @MovMoneda <> @CtaDineroMoneda SELECT @Ok = 30200
    END

    -- Verificar la Aplicacion Manual
    IF ((@MovTipo IN ('CXC.C','CXC.AJM','CXC.AJA','CXC.NET','CXC.NC','CXC.NCD','CXC.CA','CXC.CAD','CXC.CAP','CXC.NCF','CXC.DV','CXC.NCP','CXC.D','CXC.DM','CXC.DA','CXC.DP','CXC.AE','CXC.ANC','CXC.ACA','CXP.ACA','CXC.DC', 
                      'CXP.P','CXP.AJM','CXP.AJA','CXP.NET','CXP.NC','CXP.NCD','CXP.CA','CXP.CAD','CXP.CAP','CXP.NCF','CXP.NCP','CXP.D','CXP.DM', 'CXP.PAG','CXP.DA','CXP.DP','CXP.AE','CXP.ANC','CXP.DC') AND @AplicaManual = 1) OR (@MovTipo IN ('CXC.IM', 'CXC.RM', 'AGENT.P','AGENT.CO')))
       AND @Accion IN ('AFECTAR', 'VERIFICAR') AND @Ok IS NULL
    BEGIN
      -- Bug 25959
      DECLARE @Proyecto varchar(50)
      SELECT @Proyecto = NULL
      if @Modulo = 'CxC' SELECT @Proyecto = Proyecto FROM CxC WHERE ID = @ID
      if @Modulo = 'CxP' SELECT @Proyecto = Proyecto FROM CxP WHERE ID = @ID

      EXEC spCxAplicar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, NULL, @MovTipo, @MovMoneda, @MovTipoCambio, 
                       NULL, NULL, @Proyecto, @Condicion OUTPUT, @Vencimiento OUTPUT, NULL, @FechaEmision, NULL, NULL, NULL,
                       @Contacto, @ContactoEnviarA, @ContactoMoneda, @ContactoFactor, @ContactoTipoCambio, @Agente, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, @ImporteTotal, 
		       @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @OrigenTipo, @OrigenMovTipo, @MovAplica, @MovAplicaID, @MovAplicaMovTipo,
                       @CfgContX, @CfgContXGenerar, @CfgEmbarcar, @AutoAjuste, @AutoAjusteMov, @CfgDescuentoRecargos, @CfgRefinanciamientoTasa, 
		       /*0, NULL, @CfgAplicaDif, 0, */0, NULL, NULL, 0, NULL,
                       0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @CfgAC, 
                       1, @TieneDescuentoRecargos OUTPUT, @AplicaPosfechado OUTPUT, @ImporteAplicado OUTPUT, 
                       @RedondeoMonetarios, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL AND @CfgValidarPPMorosos = 1
        IF EXISTS(SELECT * FROM CxcD WHERE ID = @ID AND ISNULL(DescuentoRecargos, 0) < 0.0)
          IF EXISTS(SELECT *
                      FROM CxcPendiente p, MovTipo  mt
                     WHERE p.Empresa = @Empresa
                       AND p.Cliente = @Contacto
                       AND mt.Modulo = 'CXC' AND mt.Mov = p.Mov AND mt.Clave NOT IN ('CXC.A', 'CXC.AR', 'CXC.NC', 'CXC.NCD','CXC.NCF')
                       AND ISNULL(p.DiasMoratorios, 0) > 0)
            SELECT @Ok = 65090
    END
    IF @AplicaPosfechado = 1
    BEGIN
      IF @MovTipo IN ('CXC.C','CXP.P')
      BEGIN
        IF ROUND(@ImporteAplicado, @RedondeoMonetarios)<>ROUND(@ImporteTotal, @RedondeoMonetarios) SELECT @Ok = 30230 ELSE
        IF @Modulo = 'CXC' IF (SELECT COUNT(*) FROM CxcD WHERE ID = @ID) > 1 SELECT @Ok = 30390 ELSE
        IF @Modulo = 'CXP' IF (SELECT COUNT(*) FROM CxpD WHERE ID = @ID) > 1 SELECT @Ok = 30390 
      END ELSE 
        SELECT @Ok = 30380       
    END

    -- ETO Tarjetas 9-Feb-2007 Inicio Cambio
    SELECT @FormaCobroTarjetas = CxcFormaCobroTarjetas FROM EmpresaCfg WHERE Empresa = @Empresa
    SELECT @TarjetasCobradas = 0.0

    SELECT @ConDesglose = ConDesglose,
           @Importe1 = ISNULL(Importe1, 0), @FormaCobro1 = FormaCobro1,
           @Importe2 = ISNULL(Importe2, 0), @FormaCobro2 = FormaCobro2,
	   @Importe3 = ISNULL(Importe3, 0), @FormaCobro3 = FormaCobro3,
	   @Importe4 = ISNULL(Importe4, 0), @FormaCobro4 = FormaCobro4,
	   @Importe5 = ISNULL(Importe5, 0), @FormaCobro5 = FormaCobro5
      FROM Cxc
     WHERE ID = @ID

    -- 9150
    IF NULLIF(@FormaPago, '') IS NOT NULL AND @ConDesglose = 0 AND NULLIF(@Ok, 0) IS NULL
    BEGIN
      IF dbo.fnFormaPagoVerificar(@Empresa, @FormaPago, @Modulo, @Mov, @Usuario, '(Forma Pago)', 0) = 0
        SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago') + '. ' + @FormaPago
    END
    IF NULLIF(@FormaCobro1, '') IS NOT NULL AND @ConDesglose = 1 AND NULLIF(@Ok, 0) IS NULL
    BEGIN
      IF dbo.fnFormaPagoVerificar(@Empresa, @FormaCobro1, @Modulo, @Mov, @Usuario, '(Forma Pago 1)', 1) = 0
        SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago 1') + '. ' + @FormaCobro1
    END
    IF NULLIF(@FormaCobro2, '') IS NOT NULL AND @ConDesglose = 1 AND NULLIF(@Ok, 0) IS NULL
    BEGIN
      IF dbo.fnFormaPagoVerificar(@Empresa, @FormaCobro2, @Modulo, @Mov, @Usuario, '(Forma Pago 2)', 1) = 0
        SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago 2') + '. ' + @FormaCobro2
    END
    IF NULLIF(@FormaCobro3, '') IS NOT NULL AND @ConDesglose = 1 AND NULLIF(@Ok, 0) IS NULL
    BEGIN
      IF dbo.fnFormaPagoVerificar(@Empresa, @FormaCobro3, @Modulo, @Mov, @Usuario, '(Forma Pago 3)', 1) = 0
        SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago 3') + '. ' + @FormaCobro3
    END
    IF NULLIF(@FormaCobro4, '') IS NOT NULL AND @ConDesglose = 1 AND NULLIF(@Ok, 0) IS NULL
    BEGIN
      IF dbo.fnFormaPagoVerificar(@Empresa, @FormaCobro4, @Modulo, @Mov, @Usuario, '(Forma Pago 4)', 1) = 0
        SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago 4') + '. ' + @FormaCobro4
    END
    IF NULLIF(@FormaCobro5, '') IS NOT NULL AND @ConDesglose = 1 AND NULLIF(@Ok, 0) IS NULL
    BEGIN
      IF dbo.fnFormaPagoVerificar(@Empresa, @FormaCobro5, @Modulo, @Mov, @Usuario, '(Forma Pago 5)', 1) = 0
        SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago 5') + '. ' + @FormaCobro5
    END                                            

    IF @ConDesglose = 0 AND @ImporteTotal > 0.0 AND @FormaPago = @FormaCobroTarjetas
      BEGIN
        SELECT @TarjetasCobradas = @ImporteTotal, @FormaCobro1 = @FormaPago
      END
    ELSE
      BEGIN
        IF @FormaCobro1 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe1
        IF @FormaCobro2 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe2
        IF @FormaCobro3 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe3
        IF @FormaCobro4 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe4
        IF @FormaCobro5 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe5
      END

--    IF @ValesCobrados > 0.0 	-- ETO Tarjetas 9-Feb-2007 Original
    IF @ValesCobrados > 0.0 OR @TarjetasCobradas > 0.0
    BEGIN
      IF @MovTipo IN ('CXC.A', 'CXC.AR', 'CXC.AA', 'CXC.C', 'CXC.DC', 'CXC.DE') 
      BEGIN
        EXEC spValeValidarCobro @Empresa, @Modulo, @ID, @Accion, @FechaEmision, @ValesCobrados, @TarjetasCobradas, @MovMoneda, @Ok OUTPUT, @OkRef OUTPUT
        IF Exists(SELECT * FROM TarjetaSerieMov t JOIN ValeSerie v ON t.Serie = v.Serie JOIN Art a ON v.Articulo = a.Articulo WHERE t.Empresa = @Empresa AND t.Modulo = @Modulo AND t.ID = @ID AND ISNULL(t.Importe,0) <> 0 AND ISNULL(a.LDI,0) = 1) AND @LDI = 1 AND ISNULL(@CFDFlex,0) = 1
            SELECT @Ok = 73562         
      
      END  
      ELSE 
        SELECT @Ok = 36100, @OkRef = @FormaPago 
    END
    -- ETO Tarjetas 9-Feb-2007 Fin Cambio

    IF @MovTipo IN ('CXC.A','CXC.AR','CXC.AA','CXC.C','CXP.CAP','CXP.DP','CXP.CD','CXP.NCP','CXP.C','AGENT.A') AND UPPER(@FormaPago) = UPPER(@CfgFormaCobroDA) AND @Accion <> 'CANCELAR' AND @ConDesglose = 0 AND @Ok IS NULL
      IF (SELECT CxcDARef FROM EmpresaCfg WHERE Empresa = @Empresa) = 0
        IF NOT EXISTS (SELECT * FROM Dinero WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE' AND CtaDinero = @CtaDinero AND ROUND(Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios) AND Moneda = @MovMoneda)
        BEGIN
          SELECT @OkRef = NULL
          SELECT @OkRef = MIN(CtaDinero) FROM Dinero WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE' AND ROUND(Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios) AND Moneda = @MovMoneda
          IF @OkRef IS NULL
            SELECT @Ok = 35160
          ELSE SELECT @Ok = 35165
        END
    IF @MovTipo IN ('AGENT.P','AGENT.CO') AND ROUND(@ImporteAplicado, @RedondeoMonetarios) < 0.0 SELECT @Ok = 30100

  END

  IF @Accion NOT IN ('GENERAR', 'CANCELAR') AND @Ok IS NULL 
    EXEC spValidarMovImporteMaximo @Usuario, @Modulo, @Mov, @ID, @Ok OUTPUT, @OkRef OUTPUT
  IF @Ok IS NULL
    EXEC xpCxVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                       @FechaEmision, @Condicion, @Vencimiento, @FormaPago, @Contacto, @ContactoMoneda, @ContactoFactor, @ContactoTipoCambio, @Importe, @Impuestos, @Saldo, @CtaDinero, @AplicaManual, @ConDesglose, 
                       @CobroDesglosado, @CobroDelEfectivo, @CobroCambio,
                       @Indirecto, @Conexion, @SincroFinal, @Sucursal, @EstatusNuevo, @AfectarCantidadPendiente, @AfectarCantidadA, @CfgContX, @CfgContXGenerar, @CfgEmbarcar, @AutoAjuste, @CfgFormaCobroDA, @CfgRefinanciamientoTasa, 
                       @MovAplica, @MovAplicaID, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

/**************** spCxAutoAplicacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxAutoAplicacion') and type = 'P') drop procedure dbo.spCxAutoAplicacion
GO             
CREATE PROCEDURE spCxAutoAplicacion
		    @Sucursal			int, 
                    @Empresa			char(5),
        	    @Modulo			char(5), 
		    @ID				int, 
                    @Mov			char(20),
		    @MovID			varchar(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @Contacto			char(10), 
                    @ContactoMoneda		char(10),
		    @ContactoFactor		float,
		    @ContactoTipoCambio		float,
		    @ImporteTotal		money,

		    @Accion			char(20),
		    @FechaEmision		datetime,
		    @Referencia			varchar(50),
		    @Condicion			varchar(50),
		    @Vencimiento		datetime,
		    @Proyecto			varchar(50),
		    @Usuario			char(15),

		    @CfgAplicaAutoOrden		char(20),
		    --@TopeEfectivoAuto		money,
                    @CfgMovCargoDiverso		char(20),
                    @CfgMovCreditoDiverso	char(20),
		    @Ok 			int		OUTPUT, 
		    @OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @AplicaMov     	char(20),
    @AplicaMovTipo	char(20),
    @AplicaMovID	varchar(20),
    @Saldo		money,
    @Suma		money,
    @Requiere		money,
    @Obtenido		money,
    @Efectivo		money,
    @DiversoID		int,
    @DiversoMov		char(20),
    @DiversoMovID	varchar(20),
    @DiversoEfectivo	money,
    @IDGenerar		int,
    @Renglon		float,
    @ContactoEfectivo	money

  IF @Modulo = 'CXC' 
  BEGIN
    IF @CfgAplicaAutoOrden = 'FECHA VENCIMIENTO' DECLARE crCxAutoAplicaRen CURSOR FOR SELECT NULLIF(RTRIM(Mov), ''), MovID, ISNULL(Saldo, 0.0) FROM CxcPendiente WHERE Empresa = @Empresa AND Moneda = @ContactoMoneda AND Cliente = @Contacto ORDER BY Vencimiento ASC
    IF @CfgAplicaAutoOrden = 'FECHA EMISION'     DECLARE crCxAutoAplicaRen CURSOR FOR SELECT NULLIF(RTRIM(Mov), ''), MovID, ISNULL(Saldo, 0.0) FROM CxcPendiente WHERE Empresa = @Empresa AND Moneda = @ContactoMoneda AND Cliente = @Contacto ORDER BY FechaEmision ASC
    IF @CfgAplicaAutoOrden = 'CONSECUTIVO'       DECLARE crCxAutoAplicaRen CURSOR FOR SELECT NULLIF(RTRIM(Mov), ''), MovID, ISNULL(Saldo, 0.0) FROM CxcPendiente WHERE Empresa = @Empresa AND Moneda = @ContactoMoneda AND Cliente = @Contacto ORDER BY Mov, MovID ASC
    IF @CfgAplicaAutoOrden = 'SALDO MENOR'       DECLARE crCxAutoAplicaRen CURSOR FOR SELECT NULLIF(RTRIM(Mov), ''), MovID, ISNULL(Saldo, 0.0) FROM CxcPendiente WHERE Empresa = @Empresa AND Moneda = @ContactoMoneda AND Cliente = @Contacto ORDER BY Saldo ASC
    IF @CfgAplicaAutoOrden = 'SALDO MAYOR'       DECLARE crCxAutoAplicaRen CURSOR FOR SELECT NULLIF(RTRIM(Mov), ''), MovID, ISNULL(Saldo, 0.0) FROM CxcPendiente WHERE Empresa = @Empresa AND Moneda = @ContactoMoneda AND Cliente = @Contacto ORDER BY Saldo DESC
  END ELSE
  IF @Modulo = 'CXP' 
  BEGIN
    IF @CfgAplicaAutoOrden = 'FECHA VENCIMIENTO' DECLARE crCxAutoAplicaRen CURSOR FOR SELECT NULLIF(RTRIM(Mov), ''), MovID, ISNULL(Saldo, 0.0) FROM CxpPendiente WHERE Empresa = @Empresa AND Moneda = @ContactoMoneda AND Proveedor = @Contacto ORDER BY Vencimiento ASC
    IF @CfgAplicaAutoOrden = 'FECHA EMISION'     DECLARE crCxAutoAplicaRen CURSOR FOR SELECT NULLIF(RTRIM(Mov), ''), MovID, ISNULL(Saldo, 0.0) FROM CxpPendiente WHERE Empresa = @Empresa AND Moneda = @ContactoMoneda AND Proveedor = @Contacto ORDER BY FechaEmision ASC
    IF @CfgAplicaAutoOrden = 'CONSECUTIVO'       DECLARE crCxAutoAplicaRen CURSOR FOR SELECT NULLIF(RTRIM(Mov), ''), MovID, ISNULL(Saldo, 0.0) FROM CxpPendiente WHERE Empresa = @Empresa AND Moneda = @ContactoMoneda AND Proveedor = @Contacto ORDER BY Mov, MovID ASC
    IF @CfgAplicaAutoOrden = 'SALDO MENOR'       DECLARE crCxAutoAplicaRen CURSOR FOR SELECT NULLIF(RTRIM(Mov), ''), MovID, ISNULL(Saldo, 0.0) FROM CxpPendiente WHERE Empresa = @Empresa AND Moneda = @ContactoMoneda AND Proveedor = @Contacto ORDER BY Saldo ASC
    IF @CfgAplicaAutoOrden = 'SALDO MAYOR'       DECLARE crCxAutoAplicaRen CURSOR FOR SELECT NULLIF(RTRIM(Mov), ''), MovID, ISNULL(Saldo, 0.0) FROM CxpPendiente WHERE Empresa = @Empresa AND Moneda = @ContactoMoneda AND Proveedor = @Contacto ORDER BY Saldo DESC
  END

  SELECT @Suma = 0.0, @Renglon = 0
  OPEN crCxAutoAplicaRen
  FETCH NEXT FROM crCxAutoAplicaRen INTO @AplicaMov, @AplicaMovID, @Saldo 
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL 
  BEGIN   
    SELECT @AplicaMovTipo = Clave FROM MovTipo WHERE Mov = @AplicaMov AND Modulo = @Modulo
    IF @@FETCH_STATUS <> -2 AND @Saldo > 0.0 AND @AplicaMovTipo NOT IN ('CXC.A','CXC.DP','CXC.NC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP','CXC.SD','CXC.SCH', 'CXP.A','CXP.DP','CXP.NC','CXP.NCD','CXP.NCF','CXP.NCP','CXP.SD','CXP.SCH')
    BEGIN
      SELECT @Saldo = @Saldo * @ContactoFactor
      IF @@ERROR <> 0 SELECT @Ok = 1

      SELECT @Requiere = @ImporteTotal - @Suma
      IF @Requiere < @Saldo      
        SELECT @Obtenido = @Requiere  	-- Si Alcanza
      ELSE        
        SELECT @Obtenido = @Saldo	-- No Alcanza

      IF @Obtenido > 0.0 
      BEGIN
        SELECT @Renglon = @Renglon + 2048
        IF @Modulo = 'CXC' INSERT INTO CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @ID, @Renglon, 0, @AplicaMov, @AplicaMovID, @Obtenido) ELSE
        IF @Modulo = 'CXP' INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @ID, @Renglon, 0, @AplicaMov, @AplicaMovID, @Obtenido) 
        IF @@ERROR <> 0 SELECT @Ok = 1

        SELECT @Suma = @Suma + @Obtenido
        IF @Suma = @ImporteTotal BREAK
      END
    END -- fetch_status
    FETCH NEXT FROM crCxAutoAplicaRen INTO @AplicaMov, @AplicaMovID, @Saldo
    IF @@ERROR <> 0 SELECT @Ok = 1
  END
  CLOSE crCxAutoAplicaRen
  DEALLOCATE crCxAutoAplicaRen
  RETURN
END
GO

/**************** spDepositoAnticipadoAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDepositoAnticipadoAfectar') and type = 'P') drop procedure dbo.spDepositoAnticipadoAfectar
GO             
CREATE PROCEDURE spDepositoAnticipadoAfectar
		   @Sucursal		int,
		   @Accion		char(20),
		   @ID			int,
		   @Mov			char(20),
                   @MovID		varchar(20),
                   @Empresa		char(5),
    		   @Modulo	      	char(5),
		   @CtaDinero		char(10),
    		   @ImporteTotal	money,	 
    		   @MovMoneda	      	char(10),
		   @RedondeoMonetarios	int,	
		   @ConDesglose		bit,
		   @FormaPago		varchar(50),
		   @FormaPagoDA		varchar(50),
		   @Referencia		varchar(50),
		   @CfgDARef		bit,

       		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @DineroID			int,
    @DineroMov			varchar(20),
    @DineroMovID		varchar(20),
    @DineroSaldo		money,
    @DineroEstatus		varchar(15),
    @DineroEstatusAnterior	varchar(15),
    @DineroUsuario		varchar(10),
    @DineroConciliado		bit,
    @CfgConciliarEstatus	bit,
    @FechaEmision		datetime,
    @FechaRegistro		datetime,
    @ContAuto			bit,
    @MovTipo			varchar(20),

    @AfectarFiscal		varchar(20),
    @Fiscal				bit,
    @Usuario			varchar(20),
    @OkTemp             int,
    @OkRefTemp          varchar(255),
    @Total				float,
    @OrigenTotal		Float,
    @OrigenFactor		float

  SELECT @CfgConciliarEstatus = ISNULL(DineroConciliarEstatus, 0) 
    FROM EmpresaCfg 
   WHERE Empresa = @Empresa 

    SELECT @AfectarFiscal = NULL
    SELECT @Fiscal = ISNULL(Fiscal, 0)
      FROM EmpresaGral 
     WHERE Empresa = @Empresa

  SELECT @DineroID = NULL, @DineroEstatus = NULL
  IF @Accion = 'CANCELAR'
  BEGIN
    IF @CfgDARef = 1
    BEGIN
      SELECT @DineroID = MIN(d.ID)
        FROM Dinero d
        JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov AND mt.Clave = 'DIN.DA'
       WHERE d.Empresa = @Empresa 
         AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
         --AND d.CtaDinero = @CtaDinero 
         --AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios)
         AND d.MovID = @Referencia
         AND d.Moneda = @MovMoneda
      IF @DineroID IS NOT NULL 
      BEGIN
        DELETE MovImpuesto WHERE Modulo = 'DIN' AND ModuloID = @DineroID
        IF (SELECT Estatus FROM Dinero WHERE ID = @DineroID) = 'CONCLUIDO'
          EXEC spValidarTareas @Empresa, 'DIN', @DineroID, 'PENDIENTE', @Ok OUTPUT, @OkRef OUTPUT
        SELECT @DineroEstatusAnterior = Estatus FROM Dinero WHERE ID = @DineroID
        UPDATE Dinero 
           SET Estatus = 'PENDIENTE',
               Saldo = ISNULL(Saldo, 0.0) + @ImporteTotal
         WHERE ID = @DineroID
      END ELSE SELECT @Ok = 30120, @OkRef = 'Deposito Anticipado'     
    END ELSE
    BEGIN
      SELECT @DineroID = MIN(d.ID)
        FROM MovFlujo mf
        JOIN Dinero d ON d.ID = mf.DID AND d.CtaDinero = @CtaDinero AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios) AND d.Moneda = @MovMoneda AND d.Estatus IN ('CONCLUIDO', 'CONCILIADO')
       WHERE mf.Cancelado = 0 
         AND mf.Empresa = @Empresa 
         AND mf.OModulo = @Modulo 
         AND mf.OID = @ID

      IF @DineroID IS NOT NULL 
      BEGIN
        DELETE MovImpuesto WHERE Modulo = 'DIN' AND ModuloID = @DineroID
        EXEC spValidarTareas @Empresa, 'DIN', @DineroID, 'PENDIENTE', @Ok OUTPUT, @OkRef OUTPUT
        SELECT @DineroEstatusAnterior = Estatus FROM Dinero WHERE ID = @DineroID
        UPDATE Dinero 
           SET Estatus = 'PENDIENTE' 
         WHERE ID = @DineroID
      END ELSE SELECT @Ok = 30120, @OkRef = 'Deposito Anticipado'
    END
    IF @DineroID IS NOT NULL AND @Fiscal = 1 
    BEGIN
      SELECT @DineroMov = Mov, @DineroEstatus = Estatus, @FechaRegistro = FechaRegistro, @FechaEmision= FEchaEmision,  @Usuario = Usuario, @DineroMovID = MovID FROM Dinero WHERE ID = @DineroID
          SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'DIN' AND Mov = @DineroMov

      SELECT @AfectarFiscal = UPPER(NULLIF(RTRIM(AfectarFiscal), ''))
        FROM MovTipo
       WHERE Modulo = 'DIN' AND Mov = @DineroMov

      IF @AfectarFiscal NOT IN (NULL, 'NO')       
      BEGIN
        SELECT @OkTemp = @Ok, @OkRefTemp = @OkRef
        SELECT @Ok = NULL, @OkRef = NULL

        EXEC spGenerarFiscal @Empresa, @Sucursal, 'DIN', @DineroID, @DineroEstatusAnterior, 'CANCELADO', @Usuario, @FechaEmision, @FechaRegistro, @DineroMov, @DineroMovID, @MovTipo, @AfectarFiscal, @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000 SELECT @Ok = @OkTemp, @OkRef = @OkRefTemp
      END
    END

  END ELSE
  BEGIN
    IF @ConDesglose = 1 AND UPPER(@FormaPago) <> UPPER(@FormaPagoDA) 
      SELECT @Ok = 35161
    ELSE BEGIN
      IF @CfgDARef = 1
      BEGIN
        SELECT @DineroID = d.ID, @DineroMov = d.Mov, @DineroMovID = d.MovID, @DineroSaldo = ISNULL(Saldo, Importe), @DineroConciliado = ISNULL(Conciliado, 0), @DineroUsuario = Usuario, @DineroEstatusAnterior = Estatus
          FROM Dinero d
          JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov AND mt.Clave = 'DIN.DA'
         WHERE d.Empresa = @Empresa 
           AND d.Estatus = 'PENDIENTE' 
           --AND d.CtaDinero = @CtaDinero 
           --AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios)
           AND d.MovID = @Referencia
           AND d.Moneda = @MovMoneda
        IF @DineroID IS NOT NULL
        BEGIN
          IF ROUND(@ImporteTotal, @RedondeoMonetarios) <= ROUND(@DineroSaldo, @RedondeoMonetarios)
          BEGIN
            SELECT @DineroSaldo = ROUND(@DineroSaldo - @ImporteTotal, @RedondeoMonetarios)
            IF @DineroSaldo = 0.0 
              SELECT @DineroEstatus = 'CONCLUIDO'
            ELSE
              UPDATE Dinero SET Saldo = @DineroSaldo WHERE ID = @DineroID
          END ELSE 
            SELECT @Ok = 35162
        END
      END ELSE
      BEGIN
        SELECT @DineroID = d.ID, @DineroMov = d.Mov, @DineroMovID = d.MovID, @DineroConciliado = ISNULL(Conciliado, 0), @DineroUsuario = Usuario, @DineroEstatusAnterior = Estatus
          FROM Dinero d
          JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov AND mt.Clave = 'DIN.DA'
         WHERE d.Empresa = @Empresa 
           AND d.Estatus = 'PENDIENTE' 
           AND d.CtaDinero = @CtaDinero 
           AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios)
           AND d.Moneda = @MovMoneda
        IF @DineroID IS NOT NULL SELECT @DineroEstatus = 'CONCLUIDO'
      END

      IF @DineroEstatus = 'CONCLUIDO'
      BEGIN

        SELECT @OrigenFactor = 1
 
        IF @Modulo = 'CXC' AND EXISTS(SELECT * FROM MovImpuesto WHERE Modulo = 'CXC' AND ModuloID = @ID)
        BEGIN
          EXEC spMovInfo @ID, 'CXC', @Mov, @MovID, @Empresa = @Empresa, @Total = @OrigenTotal OUTPUT
          SELECT @OrigenFactor = @ImporteTotal / NULLIF(@OrigenTotal, 0.0)
  
          INSERT MovImpuesto (
                 Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,              OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,               Importe2,               Importe3,               SubTotal,               ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
          SELECT 'DIN', @DineroID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1*@OrigenFactor, Importe2*@OrigenFactor, Importe3*@OrigenFactor, SubTotal*@OrigenFactor, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
            FROM MovImpuesto
           WHERE Modulo = 'CXC' AND ModuloID = @ID
        END

        EXEC spValidarTareas @Empresa, 'DIN', @DineroID, 'CONCLUIDO', @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Dinero  
           SET Estatus = CASE WHEN @CfgConciliarEstatus = 1 AND @DineroConciliado = 1 THEN 'CONCILIADO' ELSE 'CONCLUIDO' END,
               Saldo = NULL
         WHERE ID = @DineroID

        SELECT @ContAuto = ISNULL(ContAuto, 0)
          FROM EmpresaGral 
         WHERE Empresa = @Empresa

          SELECT @FechaRegistro = GETDATE()
          SElECT @FechaEmision = dbo.fnFechaSinHora(@FechaRegistro)

        IF @CfgConciliarEstatus = 1 AND @ContAuto = 1
        BEGIN
          SELECT @FechaRegistro = GETDATE()
          SElECT @FechaEmision = dbo.fnFechaSinHora(@FechaRegistro)
          SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'DIN' AND Mov = @DineroMov
          SELECT @DineroEstatus = Estatus FROM Dinero WHERE ID = @DineroID
          EXEC spMovContAuto @Empresa, @Sucursal, 'DIN', @DineroID, @DineroEstatusAnterior, @DineroEstatus, @DineroUsuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, NULL, NULL, NULL
        END
      END

      IF @DineroID IS NULL SELECT @Ok = 35160
    END
  END

  IF @Ok IS NULL
  BEGIN
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT

      SELECT @AfectarFiscal = NULL
      SELECT @AfectarFiscal = UPPER(NULLIF(RTRIM(AfectarFiscal), ''))
        FROM MovTipo
       WHERE Modulo = 'DIN' AND Mov = @DineroMov

    SELECT @Fiscal = ISNULL(Fiscal, 0)
      FROM EmpresaGral 
     WHERE Empresa = @Empresa

    IF @Fiscal = 1 AND @AfectarFiscal NOT IN (NULL, 'NO') 
    BEGIN
      SELECT @OkTemp = @Ok, @OkRefTemp = @OkRef
      SELECT @Ok = NULL, @OkRef = NULL

      EXEC spGenerarFiscal @Empresa, @Sucursal, 'DIN', @DineroID, @DineroEstatusAnterior, @DineroEstatus, @DineroUsuario, @FechaEmision, @FechaRegistro, @DineroMov, @DineroMovID, @MovTipo, @AfectarFiscal, @Ok OUTPUT, @OkRef OUTPUT
	  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000 SELECT @Ok = @OkTemp, @OkRef = @OkRefTemp
    END

  END

END
GO

/**************** spDepositoAnticipado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDepositoAnticipado') and type = 'P') drop procedure dbo.spDepositoAnticipado
GO             
CREATE PROCEDURE spDepositoAnticipado
		   @Sucursal		int,
		   @Accion		char(20),
		   @ID			int,
		   @Mov			char(20),
                   @MovID		varchar(20),
                   @Empresa		char(5),
    		   @Modulo	      	char(5),
		   @CtaDinero		char(10),
    		   @ImporteTotal	money,	 
    		   @MovMoneda	      	char(10),
		   @RedondeoMonetarios	int,	
		   @ConDesglose		bit,
		   @FormaPago		varchar(50),
		   @FormaPagoDA		varchar(50),
		   @Referencia		varchar(50),

       		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgDARef		bit,
    @Importe1		money,
    @Importe2		money,
    @Importe3		money,
    @Importe4		money,
    @Importe5		money,
    @FormaPago1		varchar(50),
    @FormaPago2		varchar(50),
    @FormaPago3		varchar(50),
    @FormaPago4		varchar(50),
    @FormaPago5		varchar(50),
    @Referencia1	varchar(50),
    @Referencia2	varchar(50),
    @Referencia3	varchar(50),
    @Referencia4	varchar(50),
    @Referencia5	varchar(50)

  IF @Modulo IN ('CXP', 'AGENT', 'GAS') SELECT @ConDesglose = 0
  SELECT @CfgDARef = ISNULL(CxcDARef, 0) FROM EmpresaCfg WHERE Empresa = @Empresa
  IF @ConDesglose = 0
    EXEC spDepositoAnticipadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @ImporteTotal, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago, @FormaPagoDA, @Referencia, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
  ELSE BEGIN
    SELECT @Importe1 = ISNULL(Importe1, 0.0), @Importe2 = ISNULL(Importe2, 0.0), @Importe3 = ISNULL(Importe3, 0.0), @Importe4 = ISNULL(Importe4, 0.0), @Importe5 = ISNULL(Importe5, 0.0), 
           @FormaPago1 = FormaCobro1, @FormaPago2 = FormaCobro2, @FormaPago3 = FormaCobro3, @FormaPago4 = FormaCobro4, @FormaPago5 = FormaCobro5,
           @Referencia1 = Referencia1, @Referencia2 = Referencia2, @Referencia3 = Referencia3, @Referencia4 = Referencia4, @Referencia5 = Referencia5
      FROM Cxc
     WHERE ID = @ID
    IF @Importe1 <> 0.0 EXEC spDepositoAnticipadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @Importe1, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago1, @FormaPagoDA, @Referencia1, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
    IF @Importe2 <> 0.0 EXEC spDepositoAnticipadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @Importe2, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago2, @FormaPagoDA, @Referencia2, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
    IF @Importe3 <> 0.0 EXEC spDepositoAnticipadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @Importe3, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago3, @FormaPagoDA, @Referencia3, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
    IF @Importe4 <> 0.0 EXEC spDepositoAnticipadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @Importe4, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago4, @FormaPagoDA, @Referencia4, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
    IF @Importe5 <> 0.0 EXEC spDepositoAnticipadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @Importe5, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago5, @FormaPagoDA, @Referencia5, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
  END    
  RETURN  
END
GO

/**************** spCargoNoIdentificadoAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCargoNoIdentificadoAfectar') and type = 'P') drop procedure dbo.spCargoNoIdentificadoAfectar
GO             
CREATE PROCEDURE spCargoNoIdentificadoAfectar
		   @Sucursal		int,
		   @Accion		char(20),
		   @ID			int,
		   @Mov			char(20),
                   @MovID		varchar(20),
                   @Empresa		char(5),
    		   @Modulo	      	char(5),
		   @CtaDinero		char(10),
    		   @ImporteTotal	money,	 
    		   @MovMoneda	      	char(10),
		   @RedondeoMonetarios	int,	
		   @ConDesglose		bit,
		   @FormaPago		varchar(50),
		   @FormaPagoDA		varchar(50),
		   @Referencia		varchar(50),
		   @CfgDARef		bit,

       		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @DineroID			int,
    @DineroMov			varchar(20),
    @DineroMovID		varchar(20),
    @DineroSaldo		money,
    @DineroEstatus		varchar(15),
    @DineroEstatusAnterior	varchar(15),
    @DineroUsuario		varchar(10),
    @DineroConciliado		bit,
    @CfgConciliarEstatus	bit,
    @FechaEmision		datetime,
    @FechaRegistro		datetime,
    @ContAuto			bit,
    @MovTipo			varchar(20)
  SELECT @CfgConciliarEstatus = ISNULL(DineroConciliarEstatus, 0) 
    FROM EmpresaCfg 
   WHERE Empresa = @Empresa 

  SELECT @DineroID = NULL, @DineroEstatus = NULL
  IF @Accion = 'CANCELAR'
  BEGIN
    IF @CfgDARef = 1
    BEGIN
      SELECT @DineroID = MIN(d.ID)
        FROM Dinero d
        JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov AND mt.Clave = 'DIN.CNI' 
       WHERE d.Empresa = @Empresa 
         AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
         --AND d.CtaDinero = @CtaDinero 
         --AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios)
         AND d.MovID = @Referencia
         AND d.Moneda = @MovMoneda
      IF @DineroID IS NOT NULL 
      BEGIN
        IF (SELECT Estatus FROM Dinero WHERE ID = @DineroID) = 'CONCLUIDO'
          EXEC spValidarTareas @Empresa, 'DIN', @DineroID, 'PENDIENTE', @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Dinero 
           SET Estatus = 'PENDIENTE',
               Saldo = ISNULL(Saldo, 0.0) + @ImporteTotal
         WHERE ID = @DineroID
      END ELSE SELECT @Ok = 30120, @OkRef = 'Deposito Anticipado'     
    END ELSE
    BEGIN
      SELECT @DineroID = MIN(d.ID)
        FROM MovFlujo mf
        JOIN Dinero d ON d.ID = mf.DID AND d.CtaDinero = @CtaDinero AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios) AND d.Moneda = @MovMoneda AND d.Estatus IN ('CONCLUIDO', 'CONCILIADO')
       WHERE mf.Cancelado = 0 
         AND mf.Empresa = @Empresa 
         AND mf.OModulo = @Modulo 
         AND mf.OID = @ID

      IF @DineroID IS NOT NULL 
      BEGIN
        EXEC spValidarTareas @Empresa, 'DIN', @DineroID, 'PENDIENTE', @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Dinero 
           SET Estatus = 'PENDIENTE' 
         WHERE ID = @DineroID
      END ELSE SELECT @Ok = 30120, @OkRef = 'Deposito Anticipado'
    END
  END ELSE
  BEGIN
    IF @ConDesglose = 1 AND UPPER(@FormaPago) <> UPPER(@FormaPagoDA) 
      SELECT @Ok = 35161
    ELSE BEGIN
      IF @CfgDARef = 1
      BEGIN
        SELECT @DineroID = d.ID, @DineroMov = d.Mov, @DineroMovID = d.MovID, @DineroSaldo = ISNULL(Saldo, Importe), @DineroConciliado = ISNULL(Conciliado, 0), @DineroUsuario = Usuario, @DineroEstatusAnterior = Estatus
          FROM Dinero d
          JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov AND mt.Clave = 'DIN.CNI'
         WHERE d.Empresa = @Empresa 
           AND d.Estatus = 'PENDIENTE' 
           --AND d.CtaDinero = @CtaDinero 
           --AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios)
           AND d.MovID = @Referencia
           AND d.Moneda = @MovMoneda
        IF @DineroID IS NOT NULL
        BEGIN
          IF ROUND(@ImporteTotal, @RedondeoMonetarios) <= ROUND(@DineroSaldo, @RedondeoMonetarios)
          BEGIN
            SELECT @DineroSaldo = ROUND(@DineroSaldo - @ImporteTotal, @RedondeoMonetarios)
            IF @DineroSaldo = 0.0 
              SELECT @DineroEstatus = 'CONCLUIDO'
            ELSE
              UPDATE Dinero SET Saldo = @DineroSaldo WHERE ID = @DineroID
          END ELSE 
            SELECT @Ok = 35162
        END
      END ELSE
      BEGIN      	
        SELECT @DineroID = d.ID, @DineroMov = d.Mov, @DineroMovID = d.MovID, @DineroConciliado = ISNULL(Conciliado, 0), @DineroUsuario = Usuario, @DineroEstatusAnterior = Estatus
          FROM Dinero d
          JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov AND mt.Clave = 'DIN.CNI'
         WHERE d.Empresa = @Empresa 
           AND d.Estatus = 'PENDIENTE' 
           AND d.CtaDinero = @CtaDinero 
           AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios)
           AND d.Moneda = @MovMoneda
        IF @DineroID IS NOT NULL SELECT @DineroEstatus = 'CONCLUIDO'
      END

      IF @DineroEstatus = 'CONCLUIDO'
      BEGIN
        EXEC spValidarTareas @Empresa, 'DIN', @DineroID, 'CONCLUIDO', @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Dinero  
           SET Estatus = CASE WHEN @CfgConciliarEstatus = 1 AND @DineroConciliado = 1 THEN 'CONCILIADO' ELSE 'CONCLUIDO' END,
               Saldo = NULL
         WHERE ID = @DineroID

        SELECT @ContAuto = ISNULL(ContAuto, 0)
          FROM EmpresaGral 
         WHERE Empresa = @Empresa

        IF @CfgConciliarEstatus = 1 AND @ContAuto = 1
        BEGIN
          SELECT @FechaRegistro = GETDATE()
          SElECT @FechaEmision = dbo.fnFechaSinHora(@FechaRegistro)
          SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'DIN' AND Mov = @DineroMov
          SELECT @DineroEstatus = Estatus FROM Dinero WHERE ID = @DineroID
          EXEC spMovContAuto @Empresa, @Sucursal, 'DIN', @DineroID, @DineroEstatusAnterior, @DineroEstatus, @DineroUsuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, NULL, NULL, NULL
        END
      END

      IF @DineroID IS NULL SELECT @Ok = 35160
    END
  END

  IF @Ok IS NULL
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT
END
GO

/**************** spCargoNoIdentificado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCargoNoIdentificado') and type = 'P') drop procedure dbo.spCargoNoIdentificado
GO             
CREATE PROCEDURE spCargoNoIdentificado
		   @Sucursal		int,
		   @Accion		char(20),
		   @ID			int,
		   @Mov			char(20),
                   @MovID		varchar(20),
                   @Empresa		char(5),
    		   @Modulo	      	char(5),
		   @CtaDinero		char(10),
    		   @ImporteTotal	money,	 
    		   @MovMoneda	      	char(10),
		   @RedondeoMonetarios	int,	
		   @ConDesglose		bit,
		   @FormaPago		varchar(50),
		   @FormaPagoDA		varchar(50),
		   @Referencia		varchar(50),

       		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgDARef		bit,
    @Importe1		money,
    @Importe2		money,
    @Importe3		money,
    @Importe4		money,
    @Importe5		money,
    @FormaPago1		varchar(50),
    @FormaPago2		varchar(50),
    @FormaPago3		varchar(50),
    @FormaPago4		varchar(50),
    @FormaPago5		varchar(50),
    @Referencia1	varchar(50),
    @Referencia2	varchar(50),
    @Referencia3	varchar(50),
    @Referencia4	varchar(50),
    @Referencia5	varchar(50)

  IF @Modulo IN ('CXP', 'AGENT', 'GAS') SELECT @ConDesglose = 0
  SELECT @CfgDARef = ISNULL(CxcDARef, 0) FROM EmpresaCfg WHERE Empresa = @Empresa
  IF @ConDesglose = 0
    EXEC spCargoNoIdentificadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @ImporteTotal, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago, @FormaPagoDA, @Referencia, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
  ELSE BEGIN
    SELECT @Importe1 = ISNULL(Importe1, 0.0), @Importe2 = ISNULL(Importe2, 0.0), @Importe3 = ISNULL(Importe3, 0.0), @Importe4 = ISNULL(Importe4, 0.0), @Importe5 = ISNULL(Importe5, 0.0), 
           @FormaPago1 = FormaCobro1, @FormaPago2 = FormaCobro2, @FormaPago3 = FormaCobro3, @FormaPago4 = FormaCobro4, @FormaPago5 = FormaCobro5,
           @Referencia1 = Referencia1, @Referencia2 = Referencia2, @Referencia3 = Referencia3, @Referencia4 = Referencia4, @Referencia5 = Referencia5
      FROM Cxc
     WHERE ID = @ID
    IF @Importe1 <> 0.0 EXEC spCargoNoIdentificadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @Importe1, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago1, @FormaPagoDA, @Referencia1, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
    IF @Importe2 <> 0.0 EXEC spCargoNoIdentificadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @Importe2, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago2, @FormaPagoDA, @Referencia2, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
    IF @Importe3 <> 0.0 EXEC spCargoNoIdentificadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @Importe3, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago3, @FormaPagoDA, @Referencia3, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
    IF @Importe4 <> 0.0 EXEC spCargoNoIdentificadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @Importe4, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago4, @FormaPagoDA, @Referencia4, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
    IF @Importe5 <> 0.0 EXEC spCargoNoIdentificadoAfectar @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @Importe5, @MovMoneda, @RedondeoMonetarios, @ConDesglose, @FormaPago5, @FormaPagoDA, @Referencia5, @CfgDARef, @Ok OUTPUT, @OkRef OUTPUT
  END    
  RETURN  
END
GO

/**************** spAplicaDescuentoRecargos ****************/
--if exists (select * from sysobjects where id = object_id('dbo.spAplicaDescuentoRecargos') and type = 'P') drop procedure dbo.spAplicaDescuentoRecargos
GO             
/*CREATE PROCEDURE spAplicaDescuentoRecargos
		   @Sucursal		int,
		   @Accion		char(20),
		   @ID			int,
                   @Empresa		char(5),
    		   @Modulo	      	char(5),
		   @Mov			char(20),
		   @MovID		varchar(20),
    		   @MovMoneda	      	char(10),
		   @MovTipoCambio	float,
		   @Contacto		char(10),
		   @FechaEmision	datetime,
		   @FechaAfectacion	datetime,
		   @FechaRegistro	datetime,
    	 	   @Proyecto	      	varchar(50),
    		   @Usuario	      	char(10),
    		   @Referencia	      	varchar(50),

       		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OrigenTipo			char(10),
    @AplicaMov			char(20),
    @AplicaMovID		varchar(20),
    @DescuentoRecargos		money,
    @Importe			money,
    @Impuestos			money,
    @Efectivo			money,
    @Saldo			money,
    @CxID			int,
    @CxImpuestos		float,
    @CxMov			char(20), 
    @CxMovDescuento		char(20), 
    @CxMovRecargos 		char(20), 
    @CxMovID 			varchar(20), 
    @CxConcepto			varchar(50),
    @CxConceptoDescuento	varchar(50),
    @CxConceptoRecargos		varchar(50),
    @IDGenerar 			int

  SELECT @OrigenTipo = 'PP/RECARGO'
  IF @Accion = 'CANCELAR'
  BEGIN 
    IF @Modulo = 'CXC' DECLARE crDescuentoRecargos CURSOR FOR SELECT ID FROM Cxc WHERE OrigenTipo = @OrigenTipo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
    IF @Modulo = 'CXP' DECLARE crDescuentoRecargos CURSOR FOR SELECT ID FROM Cxp WHERE OrigenTipo = @OrigenTipo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
    OPEN crDescuentoRecargos
    FETCH NEXT FROM crDescuentoRecargos INTO @CxID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL 
    BEGIN   
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spCx @CxID, @Modulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @CxMov OUTPUT, @CxMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        -- Afectar Flujo
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @AplicaMov, @AplicaMovID, @Modulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT
      END
      FETCH NEXT FROM crDescuentoRecargos INTO @CxID
    END -- while
    CLOSE crDescuentoRecargos
    DEALLOCATE crDescuentoRecargos
  END ELSE 
  BEGIN
    SELECT @CxMovDescuento = 
              CASE @Modulo 
	        WHEN 'CXC' THEN CxcNCreditoProntoPago 
	        WHEN 'CXP' THEN CxpProntoPago 
              END,
	   @CxMovRecargos = 
              CASE @Modulo 
	        WHEN 'CXC' THEN CxcNCargoRecargos
	        WHEN 'CXP' THEN CxpNRecargos
              END
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa

    SELECT @CxConceptoDescuento = 
              CASE @Modulo 
 	        WHEN 'CXC' THEN CxcProntoPagoConcepto
 	        WHEN 'CXP' THEN CxpProntoPagoConcepto
              END,
	   @CxConceptoRecargos = 
              CASE @Modulo 
 	        WHEN 'CXC' THEN CxcRecargosConcepto
 	        WHEN 'CXP' THEN CxpRecargosConcepto
              END
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

    SELECT @CxImpuestos = DefImpuesto
      FROM EmpresaGral
     WHERE Empresa = @Empresa
 
    IF @Modulo = 'CXC' DECLARE crDescuentoRecargos CURSOR FOR SELECT Aplica, AplicaID, ISNULL(DescuentoRecargos, 0) FROM CxcD WHERE ID = @ID AND ISNULL(DescuentoRecargos, 0) <> 0  ELSE
    IF @Modulo = 'CXP' DECLARE crDescuentoRecargos CURSOR FOR SELECT Aplica, AplicaID, ISNULL(DescuentoRecargos, 0) FROM CxpD WHERE ID = @ID AND ISNULL(DescuentoRecargos, 0) <> 0
    OPEN crDescuentoRecargos
    FETCH NEXT FROM crDescuentoRecargos INTO @AplicaMov, @AplicaMovID, @DescuentoRecargos
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL 
    BEGIN   
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @DescuentoRecargos < 0.0 
          SELECT @CxMov = @CxMovDescuento, @CxConcepto = @CxConceptoDescuento, @DescuentoRecargos = -@DescuentoRecargos
        ELSE
          SELECT @CxMov = @CxMovRecargos, @CxConcepto = @CxConceptoRecargos

        SELECT @Importe = ROUND(@DescuentoRecargos / (1+(@CxImpuestos/100.0)), @RedondeoMonetarios)
        SELECT @Impuestos = ROUND(@DescuentoRecargos - @Importe, @RedondeoMonetarios)

        SELECT @CxID = NULL  

        IF @Modulo = 'CXC'
        BEGIN
          SELECT @Saldo	= ISNULL(Saldo, 0)
            FROM Cxc 
           WHERE Empresa = @Empresa 
             AND Mov   = @AplicaMov
             AND MovID = @AplicaMovID 
             AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')

          INSERT INTO Cxc (OrigenTipo,  Origen, OrigenID, Sucursal, Empresa,  Mov,    FechaEmision,     Concepto,    Proyecto,  Moneda,     TipoCambio,     Usuario,   Referencia,  Estatus,     Cliente,   ClienteMoneda, ClienteTipoCambio, Importe,  Impuestos,  UltimoCambio,   AplicaManual, Indirecto)
                   VALUES (@OrigenTipo, @Mov,   @MovID,   @Sucursal, @Empresa, @CxMov, @FechaAfectacion, @CxConcepto, @Proyecto, @MovMoneda, @MovTipoCambio, @Usuario, @Referencia,'SINAFECTAR', @Contacto, @MovMoneda,    @MovTipoCambio,    @Importe, @Impuestos, @FechaRegistro, 1,            1)
          SELECT @CxID = SCOPE_IDENTITY()

         IF @Saldo > 0
          BEGIN
            INSERT INTO CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @CxID, 2048, 0, @AplicaMov, @AplicaMovID, @Saldo)
            SELECT @Efectivo = @DescuentoRecargos - @Saldo
          END
          IF @Efectivo > 0
            INSERT INTO CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @CxID, 4096, 0, 'Redondeo', NULL, @Efectivo) 
        END
        IF @Modulo = 'CXP' 
        BEGIN
          SELECT @Saldo	    = ISNULL(Saldo, 0)
            FROM Cxp
           WHERE Empresa = @Empresa 
             AND Mov   = @AplicaMov
             AND MovID = @AplicaMovID 
             AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')

          INSERT INTO Cxp (OrigenTipo,  Origen, OrigenID, Sucursal,  Empresa,  Mov,    FechaEmision,     Concepto,    Proyecto,  Moneda,     TipoCambio,     Usuario,  Referencia, Estatus,       Proveedor, ProveedorMoneda, ProveedorTipoCambio, Importe,  Impuestos,  UltimoCambio,  AplicaManual,  Indirecto)
                   VALUES (@OrigenTipo, @Mov,   @MovID,   @Sucursal, @Empresa, @CxMov, @FechaAfectacion, @CxConcepto, @Proyecto, @MovMoneda, @MovTipoCambio, @Usuario, @Referencia,'SINAFECTAR', @Contacto, @MovMoneda,      @MovTipoCambio,      @Importe, @Impuestos, @FechaRegistro, 1,            1)
          SELECT @CxID = SCOPE_IDENTITY()

          IF @Saldo > 0
          BEGIN
            INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @CxID, 2048, 0, @AplicaMov, @AplicaMovID, @Saldo)
            SELECT @Efectivo = @DescuentoRecargos - @Saldo
          END
          IF @Efectivo > 0
            INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @CxID, 4096, 0, 'Redondeo', NULL, @Efectivo)
        END

        IF @CxID IS NOT NULL
        BEGIN
          -- Copiar Anexos
          EXEC spMovCopiarAnexos @Sucursal, @Modulo, @ID, @Modulo, @CxID
          -- Afectar N/Credito
          EXEC spCx @CxID, @Modulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @CxMov OUTPUT, @CxMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          -- Afectar Flujo
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @AplicaMov, @AplicaMovID, @Modulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT        
        END
      END -- fetch estatus
      FETCH NEXT FROM crDescuentoRecargos INTO @AplicaMov, @AplicaMovID, @DescuentoRecargos
    END -- while
    CLOSE crDescuentoRecargos
    DEALLOCATE crDescuentoRecargos
  END 
END*/
GO

--- Bug 5737
/**************** spRevisarVencimiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRevisarVencimiento') and type = 'P') drop procedure dbo.spRevisarVencimiento
GO             
CREATE PROCEDURE spRevisarVencimiento
		    @Modulo		    char(5),
		    @ID				int,
		    @Vencimiento	datetime	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaEmision	datetime,
    @Condicion		varchar(50),
    @Periodo		varchar(15),
    @DiaVencimiento	int,
    @Dia			int,
    @Mes			int,
    @Anio			int,
    @DocAuto		bit
    
  IF @Modulo = 'CXC'
    SELECT @FechaEmision = FechaEmision, @Condicion = Condicion FROM CXC WHERE ID = @ID
  IF @Modulo = 'CXP'
    SELECT @FechaEmision = FechaEmision, @Condicion = Condicion FROM CXP WHERE ID = @ID
  
  SELECT @Dia = DAY(@FechaEmision) 
  SELECT @DocAuto = ISNULL(DA, 0), @Periodo = DAPeriodo, @DiaVencimiento = ISNULL(DADiaEspecifico, '') FROM Condicion WHERE Condicion = @Condicion
  IF @DiaVencimiento = ''
    SELECT @DiaVencimiento = @Dia
  
  IF @DocAuto = 1
    IF @Periodo IN ('Bimestral') BEGIN
      IF @Periodo = 'Bimestral' BEGIN
        SELECT @Vencimiento = DATEADD(month, 2, @FechaEmision)
	    SELECT @Mes = MONTH(@Vencimiento), @Anio = YEAR(@Vencimiento)
	    EXEC spIntToDateTime @DiaVencimiento, @Mes, @Anio, @Vencimiento OUTPUT  
      END
    END

  RETURN
END
GO

/**************** spCxDocAuto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxDocAuto') and type = 'P') drop procedure dbo.spCxDocAuto
GO             
CREATE PROCEDURE spCxDocAuto
    		   @Modulo	      	char(5),
  		   @ID			int,
		   @Usuario		char(10),

       		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @Sucursal		int,
  @Empresa	      	char(5),
  @Mov	  	      	char(20),
  @MovID             	varchar(20),
  @MovMoneda	      	char(10),
  @Contacto		char(10),
  @FechaEmision      	datetime,	
  @Condicion		varchar(50),
  @Vencimiento      	datetime,
  @Concepto	      	varchar(50),
  @Observaciones     	varchar(255),
  @MovNCargo		char(20),
  @MovDocumento		char(20),
  @DAID			int,
  @DANumeroDocumentos	int,
  @DADiaEspecifico	int,
  @DAInteres		float,
  @DATipoInteres	varchar(20),
  @DAInteresImpuesto	float,
  @DAInteresConcepto	varchar(50),
  @DAPeriodo		char(15),
  @DAImpPrimerDoc	bit,
  @ImporteDocumentar	money,
  @Intereses		money,
  @InteresesImpuestos	money,
  @ImporteDocumento	money,
  @Interes		float

  SELECT @Interes = NULL
  IF @Modulo = 'CXC' SELECT @Sucursal = Sucursal, @Empresa = Empresa, @Mov = Mov, @MovID = MovID, @MovMoneda = Moneda, @Contacto = Cliente,   @FechaEmision = FechaEmision, @Condicion = Condicion, @Vencimiento = Vencimiento, @Concepto = Concepto, @Observaciones = Observaciones, @ImporteDocumentar  = NULLIF(Saldo, 0) FROM Cxc WHERE ID = @ID ELSE
  IF @Modulo = 'CXP' SELECT @Sucursal = Sucursal, @Empresa = Empresa, @Mov = Mov, @MovID = MovID, @MovMoneda = Moneda, @Contacto = Proveedor, @FechaEmision = FechaEmision, @Condicion = Condicion, @Vencimiento = Vencimiento, @Concepto = Concepto, @Observaciones = Observaciones, @ImporteDocumentar  = NULLIF(Saldo, 0) FROM Cxp WHERE ID = @ID 

  IF @ImporteDocumentar IS NULL RETURN
  SELECT @MovNCargo    = CASE WHEN @Modulo = 'CXC' THEN NULLIF(RTRIM(CxcNCargo), '')    ELSE NULLIF(RTRIM(CxpCargoProveedor), '')    END,
         @MovDocumento = CASE WHEN @Modulo = 'CXC' THEN NULLIF(RTRIM(CxcDocumento), '') ELSE NULLIF(RTRIM(CxpDocumento), '') END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @DANumeroDocumentos = ISNULL(DANumeroDocumentos, 0), @DATipoInteres = DATipoInteres, @DAInteres = DAInteres, @DAInteresImpuesto = DAInteresImpuesto, @DAInteresConcepto = DAInteresConcepto, @DAPeriodo = NULLIF(RTRIM(DAPeriodo), ''), @DAImpPrimerDoc = ISNULL(DAImpPrimerDoc, 0), @DADiaEspecifico = NULLIF(DADiaEspecifico, 0)
    FROM Condicion
   WHERE Condicion = @Condicion

  IF @DATipoInteres = 'Saldos Insolutos'
  BEGIN
    SELECT @ImporteDocumento = (@ImporteDocumentar * (@DAInteres/100.0)) / (1-(POWER(1+(@DAInteres/100.0), -@DANumeroDocumentos)))
    SELECT @Intereses = ROUND((@ImporteDocumento * @DANumeroDocumentos) - @ImporteDocumentar, 2)
    SELECT @Interes = @DAInteres * (1+(ISNULL(@DAInteresImpuesto, 0)/100.0))
  END ELSE
    SELECT @Intereses = @ImporteDocumentar * (@DAInteres/100.0)

  SELECT @InteresesImpuestos = @Intereses * (@DAInteresImpuesto/100.0)

  IF @DANumeroDocumentos = 0 OR @DAPeriodo IS NULL SELECT @Ok = 20700

  IF @DADiaEspecifico IS NOT NULL
    EXEC spVencimientoDiaEspecifico @FechaEmision, @DADiaEspecifico, @Vencimiento OUTPUT

  --- Bug 5737
  IF @Ok IS NULL
	IF @Modulo IN ('CXC', 'CXP')
	  EXEC spRevisarVencimiento @Modulo, @ID, @Vencimiento OUTPUT

  IF @Ok IS NULL
  BEGIN
    INSERT DocAuto (Sucursal, Empresa,  Modulo,  Cuenta,    Moneda,     Mov,  MovID,  ImporteDocumentar,  Intereses,  InteresesImpuestos,  InteresesConcepto,  NumeroDocumentos,    PrimerVencimiento, Periodo,    Concepto,  Observaciones,  Estatus,      Usuario,  FechaEmision,  ImpPrimerDoc, Condicion, Interes)
            VALUES (@Sucursal, @Empresa, @Modulo, @Contacto, @MovMoneda, @Mov, @MovID, @ImporteDocumentar, @Intereses, @InteresesImpuestos, @DAInteresConcepto, @DANumeroDocumentos, @Vencimiento,      @DAPeriodo, @Concepto, @Observaciones, 'SINAFECTAR', @Usuario, @FechaEmision, @DAImpPrimerDoc, @Condicion, @Interes)

    SELECT @DAID = SCOPE_IDENTITY()
    EXEC spDocAuto @DAID, @MovNCargo, @MovDocumento, @Usuario, 1, 0, @Ok OUTPUT, @OkRef OUTPUT
  END
  RETURN
END
GO

/**************** spGenerarFacturaSeguroDeducible ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarFacturaSeguroDeducible') and type = 'P') drop procedure dbo.spGenerarFacturaSeguroDeducible
GO             
CREATE PROCEDURE spGenerarFacturaSeguroDeducible
		   @Empresa		char(5),
                   @Mov			char(20),
		   @MovID		varchar(20),		
		   @Contacto		char(10),
		   @TipoSeguro		varchar(50),
		   @ImporteDeduclible	money	OUTPUT	
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @VentaID		int,
    @Articulo		char(20),
    @Cantidad		float,
    @Precio		money,
    @CantidadMaxima	float,
    @PrecioMaximo	money,
    @ImporteMaximo	money

  SELECT @VentaID = NULL
  SELECT @VentaID = ID FROM Venta WHERE Empresa = @Empresa AND Cliente = @Contacto AND Mov = @Mov AND MovID = @MovID AND Estatus IN ('CONCLUIDO', 'PENDIENTE')
  IF @VentaID IS NOT NULL
  BEGIN
    SELECT @ImporteDeduclible = 0.0

    DECLARE crFacturaDeducible CURSOR FOR 
     SELECT v.Articulo, v.Cantidad, v.SubTotal/NULLIF(v.Cantidad, 0)
       FROM VentaTCalc v, Art a
      WHERE v.ID = @VentaID AND v.Articulo = a.Articulo AND a.EsDeducible = 1
    OPEN crFacturaDeducible
    FETCH NEXT FROM crFacturaDeducible INTO @Articulo, @Cantidad, @Precio
    WHILE @@FETCH_STATUS <> -1 
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @@ERROR = 0
      BEGIN
        SELECT @CantidadMaxima = NULLIF(CantidadMaxima, 0),
               @PrecioMaximo   = NULLIF(PrecioMaximo, 0),
               @ImporteMaximo  = NULLIF(ImporteMaximo, 0)
          FROM SeguroTipoPolizaEx
         WHERE Tipo = @TipoSeguro AND Articulo = @Articulo
        IF @CantidadMaxima IS NOT NULL AND @Cantidad > @CantidadMaxima SELECT @Cantidad = @CantidadMaxima
        IF @PrecioMaximo   IS NOT NULL AND @Precio   > @PrecioMaximo   SELECT @Precio   = @PrecioMaximo
        IF @ImporteMaximo  IS NOT NULL AND (@Cantidad * @Precio) > @ImporteMaximo SELECT @Precio = @ImporteMaximo / @Cantidad

        SELECT @ImporteDeduclible = @ImporteDeduclible + (@Precio * @Cantidad)
      END
      FETCH NEXT FROM crFacturaDeducible INTO @Articulo, @Cantidad, @Precio
    END
    CLOSE crFacturaDeducible
    DEALLOCATE crFacturaDeducible
    
  END
  RETURN
END
GO

/**************** spGenerarFacturaSeguro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarFacturaSeguro') and type = 'P') drop procedure dbo.spGenerarFacturaSeguro
GO             
CREATE PROCEDURE spGenerarFacturaSeguro
		   @Empresa		char(5),
		   @ID			int,
                   @Mov			char(20),
		   @MovID		varchar(20),
    		   @MovMoneda	      	char(10),
    		   @MovTipoCambio	float,
		   @Contacto		char(10),
	    	   @IDGenerar		int,
		   @ImporteTotal	money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Aseguradora	char(10),
    @Deducible		money,
    @DeducibleMoneda	char(10),
    @CoAseguro		float,
    @Importe		money,
    @ImporteMaximo	money,
    @ImporteDeduclible	money,
    @TipoSeguro		varchar(50)

  SELECT @Aseguradora = NULL

  SELECT @Aseguradora = c.Aseguradora,
         @Deducible = (c.Deducible*CASE WHEN m.Moneda = @MovMoneda THEN @MovTipoCambio ELSE m.TipoCambio END)/@MovTipoCambio,
         @CoAseguro = c.CoAseguro,
         @ImporteMaximo = ISNULL(c.PolizaImporte, 0.0),
         @TipoSeguro = NULLIF(RTRIM(c.PolizaTipo), '')
    FROM Cte c, Mon m
   WHERE c.Cliente = @Contacto AND m.Moneda = DeducibleMoneda

  SELECT @ImporteDeduclible = @ImporteTotal
  EXEC spGenerarFacturaSeguroDeducible @Empresa, @Mov, @MovID, @Contacto, @TipoSeguro, @ImporteDeduclible OUTPUT	
  SELECT @Importe = @ImporteDeduclible - ISNULL(@Deducible, 0) - (@ImporteDeduclible * (ISNULL(@CoAseguro, 0) / 100))
  IF @Importe < 0 SELECT @Importe = 0.0
  IF @Importe > @ImporteMaximo SELECT @Importe = @ImporteMaximo

  IF @Aseguradora IS NOT NULL 
  BEGIN
    UPDATE Cxc 
       SET Cliente = @Aseguradora,
           Importe = @Importe
     WHERE ID = @IDGenerar
  END
  RETURN
END
GO

/**************** spCxAfectar2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxAfectar2') and type = 'P') drop procedure dbo.spCxAfectar2
GO             
CREATE PROCEDURE spCxAfectar2
    		   @ID                		int OUTPUT,

			   @Accion					char(20) OUTPUT,
    		   @Empresa	      			char(5) OUTPUT,
    		   @Modulo	      			char(5) OUTPUT,
    		   @Mov	  	      			char(20)OUTPUT,
    		   @MovID             		varchar(20)  OUTPUT,
    		   @MovTipo     			char(20) OUTPUT,
    		   @MovMoneda	      		char(10) OUTPUT,
    		   @MovTipoCambio	      	float OUTPUT,
    		   @FechaEmision      		datetime OUTPUT,
    		   @FechaAfectacion    		datetime OUTPUT,

    		   @Concepto	      		varchar(50) OUTPUT,
    		   @Usuario			  		char(10) OUTPUT,
    		   @Estatus           		char(15) OUTPUT,
    		   @FechaRegistro     		datetime OUTPUT,
    		   @Ejercicio	      		int OUTPUT,
    		   @Periodo		    		int OUTPUT,
			   @Contacto			char(10) OUTPUT,
			   @ContactoEnviarA		int OUTPUT,
    		   @Importe   			money OUTPUT,	 
    		   @Impuestos	        	money OUTPUT,
			   @Retencion			money OUTPUT,
			   @Retencion2			money OUTPUT,
			   @Retencion3			money OUTPUT,
			   @Comisiones			money OUTPUT,
			   @ComisionesIVA		money OUTPUT,
			   @Saldo			money OUTPUT,
			   @SaldoInteresesOrdinarios	money OUTPUT, 
			   @SaldoInteresesMoratorios	money OUTPUT, 
			   @CtaDinero			char(10) OUTPUT,
			   @Cajero			char(10) OUTPUT,

			   @Conexion			bit OUTPUT,
			   @SincroFinal			bit OUTPUT,
			   @Sucursal			int OUTPUT,
			   @SucursalDestino		int OUTPUT,
			   @SucursalOrigen		int OUTPUT,
                   
               @CfgCobroImpuestos	 	bit OUTPUT,
		       @CfgVentaLimiteNivelSucursal bit OUTPUT,
		       @CfgSugerirProntoPago	bit OUTPUT, 
		       @CfgAC			bit OUTPUT,

			   @TipoAmortizacion		varchar(20) OUTPUT,
	
               @Generar                     bit OUTPUT,
               @GenerarMov                  char(20) OUTPUT,
               @GenerarSerie		char(20) OUTPUT,
			   @RedondeoMonetarios		int OUTPUT, 	

			   @IDGenerar			int	     OUTPUT,	
    		   @GenerarMovID	  	varchar(20)  OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT,


               @Base			varchar(20)	= NULL OUTPUT,
			   @ComisionesFinanciadas		bit = NULL OUTPUT,
			   @ImporteTotal				float = NULL OUTPUT,
			   @Limite						float = NULL OUTPUT,
			   @VentaNeta					float = NULL OUTPUT,
			   @LimiteDesde					datetime = NULL OUTPUT,
			   @LimiteHasta					datetime = NULL OUTPUT,
			   @Excedente					float = NULL OUTPUT,
			   @GenerarEstatus				varchar(15) = NULL OUTPUT,
			   @GenerarMovTipo 	 			char(20) = NULL OUTPUT,
			   @GenerarSubMovTipo 	 		varchar(20) = NULL OUTPUT,
			   @GenerarPolizaTemp	 		bit = NULL OUTPUT,
			   @GenerarPeriodo 	 			int = NULL OUTPUT, 
			   @GenerarEjercicio 	 		int = NULL OUTPUT,
			   @DescuentoRecargos			money = NULL OUTPUT,
			   @ImpuestoAdicional			float = NULL OUTPUT,
			   @Metodo						int = NULL OUTPUT,
			   @ImporteD					money = NULL OUTPUT,
			   @SaldoSinImpuestos			money = NULL OUTPUT,		   
			   @TasaDiaria					float = NULL OUTPUT,
			   @Dias						int = NULL OUTPUT,
			   @SubMovTipo					varchar(20) = NULL OUTPUT,
			   @ConsignacionFechaCorte		datetime = NULL OUTPUT,
			   @SaldoTotal					money = NULL OUTPUT,
			   @Porcentaje					float = NULL OUTPUT,
			   @ImporteSinImpuestos			money = NULL OUTPUT,
			   @GenerarAplicaManual			bit = NULL OUTPUT,
			   @SaldoInteresesOrdinariosIVA		float = NULL OUTPUT, --MEJORA10041
			   @SaldoInteresesMoratoriosIVA		float = NULL OUTPUT  --MEJORA10041
		   
                   			
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @FactorImpuestos			float,
  @ImpuestosProporcional	float,
  @RetencionProporcional	float,
  @Retencion2Proporcional	float,    
  @Retencion3Proporcional	float,
  @ArrastrarTipoCambioGenerarMov	bit
  
  IF @CfgAC = 1 
  BEGIN
    SELECT @ComisionesFinanciadas = ISNULL(ComisionesFinanciadas, 0) FROM TipoAmortizacion WHERE TipoAmortizacion = @TipoAmortizacion
  END

  -- Calcula el Importe Total
  SELECT @ImporteTotal = @Importe + @Impuestos - @Retencion - @Retencion2 - @Retencion3
  IF @ComisionesFinanciadas = 1 
    SELECT @ImporteTotal = @ImporteTotal + ISNULL(@Comisiones, 0.0) + ISNULL(@ComisionesIVA, 0.0)

  -- Asignar el Consecutivo al Movimiento
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, 'SINCRO'
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END

  IF @CfgVentaLimiteNivelSucursal = 1 AND @MovTipo = 'CXC.F' AND @Accion = 'AFECTAR' AND @Ok IS NULL
  BEGIN
    SELECT @Limite = NULL
    SELECT @Limite = NULLIF(SUM(s.Limite*m.TipoCambio), 0), @LimiteDesde = MIN(s.Desde), @LimiteHasta = MAX(s.Hasta)
      FROM CteEnviarALimite s, Mon m
     WHERE s.Cliente = @Contacto AND s.EnviarA = @ContactoEnviarA AND @FechaEmision BETWEEN s.Desde AND s.Hasta
       AND s.Moneda = m.Moneda

    IF @Limite IS NOT NULL
    BEGIN
      SELECT @VentaNeta = ISNULL(SUM(ISNULL(v.Importe, 0)+ISNULL(v.Impuestos, 0)*m.TipoCambio) , 0)
        FROM CxcVentaNeta v, Mon m
       WHERE Empresa = @Empresa AND FechaEmision BETWEEN @LimiteDesde AND @LimiteHasta
         AND Cliente = @Contacto AND EnviarA = @ContactoEnviarA
         AND v.Moneda = m.Moneda

      SELECT @Excedente = @VentaNeta+@Importe+@Impuestos - @Retencion - @Retencion2 - @Retencion3 - @Limite

      IF ISNULL(@Excedente, 0) > 0             
        SELECT @Ok = 65060, @OkRef = 'Excedente '+CONVERT(varchar, @Excedente)+ ' MN'
    END
  END

  IF @OK IS NOT NULL RETURN 

  -- Generar Mov Nuevo
  IF @Generar = 1 AND @Ok IS NULL
  BEGIN
    IF @Accion = 'GENERAR' SELECT @GenerarEstatus = 'SINAFECTAR' ELSE SELECT @GenerarEstatus = 'CANCELADO' 
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, @GenerarEstatus, 
		      NULL, NULL, 
                      @Mov, @MovID, 0, 
		      @GenerarMov, @GenerarSerie, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT, @SubClave = @GenerarSubMovTipo OUTPUT --MEJORASLC

    IF @GenerarMovTipo IN ('CXC.EST','CXC.C','CXC.NET','CXC.D', 'CXC.DM','CXC.DA','CXC.DP','CXC.NC','CXC.NCD','CXC.NCF','CXC.CA','CXC.CAD','CXC.CAP','CXC.DV','CXC.NCP','CXC.DC',
                           'CXP.EST','CXP.P','CXP.NET','CXP.DP','CXP.NC','CXP.NCD','CXP.NCP','CXP.NCF','CXP.DC','CXP.D','CXP.CA','CXP.CAD','CXP.CAP','CXP.DM','CXP.PAG','CXP.DA',
                           'AGENT.P','AGENT.CO','CXC.FAC','CXP.FAC')
    BEGIN
      IF @Modulo = 'CXC' 
      BEGIN
        SELECT @DescuentoRecargos = NULL, @ImpuestoAdicional = NULL
        IF @GenerarMovTipo = 'CXC.C' AND @CfgSugerirProntoPago = 1
          SELECT @DescuentoRecargos = -NULLIF(ProntoPago, 0) FROM CxcAplica WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID

	-- Borrar Intereses Ordinarios / Fijos cuando son por Anticipado
        SELECT @Metodo = ta.Metodo FROM Cxc c JOIN Cxc r ON r.ID = c.RamaID JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = r.TipoAmortizacion WHERE c.ID = @ID
        IF @Metodo IN (12, 22) SELECT @SaldoInteresesOrdinarios = 0.0, @SaldoInteresesOrdinariosIVA = 0.0 --MEJORA10041
        IF @Metodo = 50 SELECT @ImpuestoAdicional = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa

        SELECT @ImporteD = @Saldo + ISNULL(@DescuentoRecargos, 0.0) + ISNULL(@SaldoInteresesOrdinarios, 0.0) + ISNULL(@SaldoInteresesMoratorios, 0.0) + ISNULL(@SaldoInteresesOrdinariosIVA, 0.0) + ISNULL(@SaldoInteresesMoratoriosIVA, 0.0) --MEJORA10041
        
        SELECT @FactorImpuestos = ISNULL(@ImporteD,0.0) / ((ISNULL(@ImporteTotal,0.0)+ ISNULL(@SaldoInteresesOrdinarios, 0.0) + ISNULL(@SaldoInteresesMoratorios, 0.0) + ISNULL(@SaldoInteresesOrdinariosIVA,0.0)+ISNULL(@SaldoInteresesMoratoriosIVA,0.0)) )--ARCC19012012 --MEJORA10041 --BUG 14143
        SET @ImpuestosProporcional = (ISNULL(@Impuestos,0.0)+ISNULL(@SaldoInteresesOrdinariosIVA,0.0)+ISNULL(@SaldoInteresesMoratoriosIVA,0.0)) * @FactorImpuestos --ARCC19012012 --MEJORA10041
        SET @RetencionProporcional = ISNULL(@Retencion,0.0) * @FactorImpuestos --ARCC19012012
        SET @Retencion2Proporcional = ISNULL(@Retencion2,0.0) * @FactorImpuestos --ARCC19012012          
        SET @Retencion3Proporcional = ISNULL(@Retencion3,0.0) * @FactorImpuestos --ARCC19012012                    

        UPDATE Cxc SET Importe = @ImporteD, Impuestos = NULL, Saldo = NULL, Retencion = NULL, Retencion2 = NULL, Retencion3 = NULL, Cajero = @Cajero, CtaDinero = @CtaDinero, AplicaManual = 1, UltimoCambio = @FechaEmision WHERE ID = @IDGenerar --MEJORA4648
        IF @GenerarMovTipo IN ('CXC.C', 'CXC.CD', 'CXC.D', 'CXC.DM', 'CXC.FAC') AND @CfgCobroImpuestos = 1
        BEGIN        
          --SELECT @SaldoSinImpuestos = ROUND(@ImporteD/(CONVERT(float, @Importe+@Impuestos-@Retencion-@Retencion2-@Retencion3)/CONVERT(float, NULLIF(@Importe,0))), @RedondeoMonetarios)--ARCC19012012                    
          --UPDATE Cxc SET Importe = @SaldoSinImpuestos, Impuestos = @ImporteD - @SaldoSinImpuestos+@Retencion+@Retencion2+@Retencion3, Retencion = @Retencion, Retencion2 = @Retencion2, Retencion3 = @Retencion3 WHERE ID = @IDGenerar --MEJORA4648 --ARCC19012012                    
          UPDATE Cxc SET Importe = @ImporteD - @ImpuestosProporcional + @RetencionProporcional + @Retencion2Proporcional + @Retencion3Proporcional, Impuestos = @ImpuestosProporcional, Retencion = @RetencionProporcional, Retencion2 = @Retencion2Proporcional, Retencion3 = @Retencion3Proporcional WHERE ID = @IDGenerar --ARCC19012012                    
        END

        IF @@ERROR <> 0 SELECT @Ok = 1
        INSERT INTO CxcD (Sucursal,  ID,         Renglon, RenglonSub, Aplica, AplicaID, Importe, DescuentoRecargos,  InteresesOrdinarios,                    InteresesMoratorios,                    ImpuestoAdicional,  InteresesOrdinariosIVA,                   InteresesMoratoriosIVA) --MEJORA10041
                  VALUES (@Sucursal, @IDGenerar, 2048,    0,          @Mov,   @MovID,   @Saldo,  @DescuentoRecargos, NULLIF(@SaldoInteresesOrdinarios, 0.0), NULLIF(@SaldoInteresesMoratorios, 0.0), @ImpuestoAdicional, ISNULL(@SaldoInteresesOrdinariosIVA,0.0), ISNULL(@SaldoInteresesMoratoriosIVA,0.0)) --MEJORA10041
      END ELSE
      IF @Modulo = 'CXP' 
      BEGIN
        SELECT @DescuentoRecargos = NULL 
        IF @Base = 'SELECCION'
        BEGIN
          SELECT @TasaDiaria = NULL, @Dias = NULL
          SELECT @TasaDiaria = NULLIF(Flotante, 0.0)/100.0/360.0 FROM SPIDTemp WHERE SPID = @@SPID
          SELECT @Dias = DATEDIFF(day, (SELECT FechaEmision FROM Cxp WHERE ID = @IDGenerar), (SELECT Vencimiento FROM Cxp WHERE ID = @ID))
          IF ISNULL(@Dias, 0) > 0
            SELECT @DescuentoRecargos = -@TasaDiaria * @Dias * @Saldo
        END

        IF (@GenerarMovTipo IN ('CXP.D') AND @GenerarSubMovTipo IN ('CXP.SLCCORTE')) AND (@MovTipo IN ('CXP.F') AND @SubMovTipo IN ('CXP.SLC')) AND (@Ok IS NULL OR @Ok IN (80030))--MEJORASLC
        BEGIN
          SET @ConsignacionFechaCorte = dbo.fnFechaSinHora(GETDATE())
          EXEC spCxpSLCCalcularCorte @@SPID, @ID, @IDGenerar, @ConsignacionFechaCorte, @Saldo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT                     
        END
                
        SELECT @SaldoTotal = @Saldo + ISNULL(@SaldoInteresesOrdinarios, 0.0) + ISNULL(@SaldoInteresesMoratorios, 0.0) + ISNULL(@SaldoInteresesOrdinariosIVA, 0.0) + ISNULL(@SaldoInteresesMoratoriosIVA, 0.0) --MEJORA10041
        SELECT @ImporteD = @SaldoTotal
        UPDATE Cxp SET Importe = @ImporteD, Impuestos = NULL, Saldo = NULL, Cajero = @Cajero, CtaDinero = @CtaDinero, AplicaManual = 1, UltimoCambio = @FechaEmision WHERE ID = @IDGenerar

	-- se sugiere en base al SaldoTotal en el caso del Endoso
        IF @GenerarMovTipo = 'CXP.FAC'
        BEGIN        
          UPDATE Cxp 
             SET Importe = dbo.fnR3(@ImporteTotal, @Importe, @Saldo/*Total*/), 
                 Impuestos = dbo.fnR3(@ImporteTotal, ISNULL(@Impuestos,0.0)+ISNULL(@SaldoInteresesOrdinariosIVA,0.0)+ISNULL(@SaldoInteresesMoratoriosIVA,0.0), @Saldo/*Total*/), --MEJORA10041
                 Retencion = dbo.fnR3(@ImporteTotal, @Retencion, @Saldo/*Total*/), 
                 Retencion2 = dbo.fnR3(@ImporteTotal, @Retencion2, @Saldo/*Total*/), 
                 Retencion3 = dbo.fnR3(@ImporteTotal, @Retencion3, @Saldo/*Total*/) 
           WHERE ID = @IDGenerar 
        END
        IF @@ERROR <> 0 SELECT @Ok = 1
        INSERT INTO CxpD (Sucursal,  ID,         Renglon, RenglonSub, Aplica, AplicaID, Importe, DescuentoRecargos,  InteresesOrdinarios,                    InteresesMoratorios,                    InteresesOrdinariosIVA,                   InteresesMoratoriosIVA) --MEJORA10041
                  VALUES (@Sucursal, @IDGenerar, 2048,    0,          @Mov,   @MovID,   @Saldo,  @DescuentoRecargos, NULLIF(@SaldoInteresesOrdinarios, 0.0), NULLIF(@SaldoInteresesMoratorios, 0.0), NULLIF(@SaldoInteresesOrdinariosIVA,0.0), NULLIF(@SaldoInteresesMoratoriosIVA,0.0)) --MEJORA10041
        IF @GenerarMovTipo = 'CXP.PAG' 
          UPDATE Cxp SET Condicion = NULL WHERE ID = @IDGenerar
      END ELSE
      IF @Modulo = 'AGENT' 
      BEGIN
        UPDATE Agent SET Importe = @Saldo, Impuestos = NULL, Retencion = NULL, Saldo = NULL, UltimoCambio = @FechaEmision WHERE ID = @IDGenerar
        IF @@ERROR <> 0 SELECT @Ok = 1
        INSERT INTO AgentD (Sucursal, ID,  Renglon, RenglonSub, Aplica, AplicaID, Importe) VALUES (@Sucursal, @IDGenerar, 2048, 0, @Mov, @MovID, @Saldo)
      END
    END
    --BUG14489
    IF @GenerarMovTipo IN ('CXC.CA','CXC.CAD','CXC.CAP','CXC.NC','CXC.NCD','CXC.NCF','CXC.NCP','CXC.DV',/*'CXC.RA', */
                           'CXP.CA','CXP.CAD','CXP.CAP','CXP.NC','CXP.NCD','CXP.NCF','CXP.NCP')
    BEGIN
      IF @Impuestos > 0.0 SELECT @Porcentaje = ((@Importe+@Impuestos-@Retencion-@Retencion2-@Retencion3)/CONVERT(float, @Importe)) ELSE SELECT @Porcentaje = 1.0
      SELECT @ImporteSinImpuestos = (@Saldo / @Porcentaje)

      --IF @Modulo = 'CXC' UPDATE Cxc SET Importe = @ImporteSinImpuestos, Impuestos = (@Saldo - @ImporteSinImpuestos + @Retencion + @Retencion2 + @Retencion3), Retencion = @Retencion, Retencion2 = @Retencion2, Retencion3 = @Retencion3, Saldo = NULL, UltimoCambio = @FechaEmision WHERE ID = @IDGenerar ELSE --ARCC19012012                    
      IF @Modulo = 'CXC' UPDATE Cxc SET Importe = @ImporteD - @ImpuestosProporcional + @RetencionProporcional + @Retencion2Proporcional + @Retencion3Proporcional, Impuestos = @ImpuestosProporcional, Retencion = @RetencionProporcional, Retencion2 = @Retencion2Proporcional, Retencion3 = @Retencion3Proporcional, Saldo = NULL, UltimoCambio = @FechaEmision WHERE ID = @IDGenerar ELSE --ARCC19012012                    
      IF @Modulo = 'CXP' UPDATE Cxp SET Importe = @ImporteSinImpuestos, Impuestos = (@Saldo - @ImporteSinImpuestos), Saldo = NULL, UltimoCambio = @FechaEmision WHERE ID = @IDGenerar 

      --BUG14489
      --IF @GenerarMovTipo = 'CXC.RA'
      --  UPDATE Cxc SET Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID), MovAplica = @Mov, MovAplicaID = @MovID WHERE ID = @IDGenerar
    END ELSE
    --BUG14489
    IF @GenerarMovTipo IN ('CXC.ANC', 'CXC.ACA', 'CXP.ACA', 'CXC.DAC', 'CXC.EST', 'CXP.ANC', 'CXP.RA', 'CXC.RA', 'CXP.DAC', 'CXO.EST')
    BEGIN
      IF @GenerarMovTipo IN ('CXC.ANC', 'CXC.ACA', 'CXP.ACA', 'CXP.ANC', 'CXC.EST', 'CXP.EST') SELECT @GenerarAplicaManual = 1 ELSE SELECT @GenerarAplicaManual = 0
      IF @Modulo = 'CXC' UPDATE Cxc SET Importe = @Saldo, Impuestos = NULL, Retencion = NULL, Retencion2 = NULL, Retencion3 = NULL, Saldo = NULL, UltimoCambio = @FechaEmision, Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID), MovAplica = @Mov, MovAplicaID = @MovID, AplicaManual = @GenerarAplicaManual, Moneda = ClienteMoneda,   TipoCambio = ClienteTipoCambio   WHERE ID = @IDGenerar ELSE
      IF @Modulo = 'CXP' UPDATE Cxp SET Importe = @Saldo, Impuestos = NULL, Saldo = NULL, UltimoCambio = @FechaEmision, Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID), MovAplica = @Mov, MovAplicaID = @MovID, AplicaManual = @GenerarAplicaManual, Moneda = ProveedorMoneda, TipoCambio = ProveedorTipoCambio WHERE ID = @IDGenerar 
    END
    ----5843
	SELECT @ArrastrarTipoCambioGenerarMov = ISNULL(ArrastrarTipoCambioGenerarMov, 0) FROM EmpresaGral  WHERE Empresa = @Empresa 
		  IF @GenerarMovTipo IN ('CXP.ANC')
		  BEGIN 
			  IF @Accion = 'GENERAR' AND (@ArrastrarTipoCambioGenerarMov=1 OR (SELECT ISNULL(ArrastrarTipoCambioGenerarMov, 0) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @GenerarMov) = 1  ) 
			  BEGIN
			   IF @Modulo = 'CXP' UPDATE Cxp set ProveedorMoneda = @MovMoneda, ProveedorTipoCambio = @MovTipoCambio,  Moneda = @MovMoneda, TipoCambio = @MovTipoCambio WHERE ID = @IDGenerar
			  END
		  END 
    

    IF @GenerarMovTipo IN ('CXC.FAC', 'CXP.FAC')
    BEGIN
      IF @Modulo = 'CXC' UPDATE Cxc SET UltimoCambio = @FechaEmision, Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID), MovAplica = @Mov, MovAplicaID = @MovID, AplicaManual = 0, Moneda = ClienteMoneda,   TipoCambio = ClienteTipoCambio   WHERE ID = @IDGenerar ELSE
      IF @Modulo = 'CXP' UPDATE Cxp SET UltimoCambio = @FechaEmision, Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID), MovAplica = @Mov, MovAplicaID = @MovID, AplicaManual = 0, Moneda = ProveedorMoneda, TipoCambio = ProveedorTipoCambio WHERE ID = @IDGenerar
	   --26071    
      SELECT @ArrastrarTipoCambioGenerarMov = ISNULL(ArrastrarTipoCambioGenerarMov, 0) FROM EmpresaGral  WHERE Empresa = @Empresa 
	  IF @Accion = 'GENERAR' AND (@ArrastrarTipoCambioGenerarMov=1 OR (SELECT ISNULL(ArrastrarTipoCambioGenerarMov, 0) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @GenerarMov) = 1  ) 
	  BEGIN
	   IF @Modulo = 'CXP' UPDATE Cxp set ProveedorMoneda = @MovMoneda, ProveedorTipoCambio = @MovTipoCambio,  Moneda = @MovMoneda, TipoCambio = @MovTipoCambio WHERE ID = @IDGenerar
	  END
      IF @GenerarMovTipo = 'CXC.FAC'
      BEGIN
        IF EXISTS(SELECT * FROM EmpresaCfgMov WHERE Empresa = @Empresa AND CxcFacturaSeguro = @GenerarMov) 
          EXEC spGenerarFacturaSeguro @Empresa, @ID, @Mov, @MovID, @MovMoneda, @MovTipoCambio, @Contacto, @IDGenerar, @ImporteTotal 
        ELSE
          IF EXISTS(SELECT * FROM EmpresaGral WHERE Empresa = @Empresa AND Ford = 1 AND FordMovCxcFactura = @GenerarMov) 
            UPDATE Cxc SET Cliente = cfg.FordCliente FROM Cxc c, EmpresaGral cfg WHERE c.ID = @IDGenerar AND cfg.Empresa = @Empresa
      END 
    END

    EXEC xpGenerarCxFinal @Modulo, @ID, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
    RETURN
  END
END
GO

--REQ 13451
/**************** spCxAfectarClavePresupuestal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxAfectarClavePresupuestal') and sysstat & 0xf = 4) drop procedure dbo.spCxAfectarClavePresupuestal
GO
CREATE PROCEDURE spCxAfectarClavePresupuestal
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
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OrigenTipo		char(5),
    @Origen			varchar(20),
    @Clave			varchar(20),
    @OrigenID		varchar(20),
    @IDOrigen		int,
    @Proyecto		varchar(50),
    @Concepto		varchar(50),
    @Retencion 		money,
    @Retencion2		money,
    @Retencion3		money,
    @ContUso		varchar(20),
    @ContUso2		varchar(20),
    @ContUso3		varchar(20)
  
  IF @Modulo = 'CXC'
    SELECT
      @OrigenTipo	= OrigenTipo,
      @Origen		= Origen,
      @OrigenID		= OrigenID,
      @Concepto		= Concepto,
      @Retencion	= ISNULL(Retencion, 0.0),
      @Retencion2	= ISNULL(Retencion2, 0.0),
      @Retencion3	= ISNULL(Retencion3, 0.0), 
      @ContUso		= NULLIF(ContUso,''),
      @ContUso2		= NULLIF(ContUso2,''),
      @ContUso3		= NULLIF(ContUso3,'')
      FROM Cxc
     WHERE ID = @ID
  ELSE
  IF @Modulo = 'CXP'
    SELECT
      @OrigenTipo	= OrigenTipo,
      @Origen		= Origen,
      @OrigenID		= OrigenID,
      @Concepto		= Concepto,
      @Retencion	= ISNULL(Retencion, 0.0),
      @Retencion2	= ISNULL(Retencion2, 0.0),
      @Retencion3	= ISNULL(Retencion3, 0.0),  
      @ContUso		= NULLIF(ContUso,''),
      @ContUso2		= NULLIF(ContUso2,''),
      @ContUso3		= NULLIF(ContUso3,'')    
      FROM Cxp
     WHERE ID = @ID
  
  SELECT @Clave = Clave FROM MovTipo WHERE Modulo = @OrigenTipo AND Mov = @Origen
  
  IF @OrigenTipo = 'NOM' AND @Clave = 'NOM.N'
  BEGIN  
    SELECT @IDOrigen = ID FROM Nomina WHERE Mov = @Origen AND MovID = @OrigenID AND Empresa = @Empresa
    SELECT @Proyecto = Proyecto FROM Nomina WHERE ID = @IDOrigen
    
    IF @Modulo = 'CXC'
      UPDATE Cxc
         SET Proyecto = @Proyecto
       WHERE ID = @ID
    ELSE
    IF @Modulo = 'CXP'
      UPDATE Cxp
         SET Proyecto = @Proyecto
       WHERE ID = @ID
  END
  
  IF NOT EXISTS(SELECT * FROM MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID) AND @Ok IS NULL
    INSERT MovImpuesto
          (Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenFecha,   Retencion1,                                Retencion2,                                Retencion3,                                Impuesto1,                                               Importe1,  SubTotal,  ContUso,  ContUso2,  ContUso3)
    SELECT @Modulo, @ID,      @Modulo,      @ID,            @Concepto,      @FechaEmision, (@Retencion/NULLIF(@Importe, 0.0))*100.0, (@Retencion2/NULLIF(@Importe, 0.0))*100.0, (@Retencion3/NULLIF(@Importe, 0.0))*100.0,  ROUND(dbo.fnR3(NULLIF(@Importe, 0.0),100,@Impuestos),2), @Impuestos, @Importe, @ContUso, @ContUso2, @ContUso3
  
  RETURN
END
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

/**************** spCx ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCx') and type = 'P') drop procedure dbo.spCx
GO
CREATE PROCEDURE spCx
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

		   @INSTRUCCIONES_ESP		varchar(20) 	= NULL,
		   @EstacionTrabajo				int = NULL -- REQ12336
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
    @MovUsuario			char(10),
    @FechaEmision     		datetime,
    @FechaAfectacion		datetime,
    @FechaConclusion		datetime,
    @Concepto	      		varchar(50),
    @Proyecto	      		varchar(50),
    @MovMoneda	      		char(10),
    @MovTipoCambio	   	float,
    @Autorizacion     		char(10),
    @Mensaje			int,
    @Referencia	      		varchar(50),
    @DocFuente	      		int,
    @Observaciones    		varchar(255),
    @Estatus          		char(15),
    @Ejercicio	      		int,
    @Periodo	      		int,
    @FormaPago			varchar(50),
    @CobroDesglosado		money,
    @CobroDelEfectivo		money,
    @CobroCambio		money,
    @ImpuestosPorcentaje	money,
    @RetencionPorcentaje	money,
    @IDOrigen			int,
    @OrigenTipo			char(10),
    @Origen			varchar(20),     
    @OrigenID			varchar(20),     
    @OrigenMovTipo		varchar(20),
    @ProveedorAutoEndoso	varchar(10),
    @Nota			varchar(100),

    @Condicion			varchar(50),
    @Vencimiento		datetime,
    @FechaProntoPago		datetime,
    @DescuentoProntoPago	float,
    @Contacto			char(10),
    @ContactoEnviarA		int,
    @ContactoTipo		char(20),
    @ContactoFactor		float,
    @ContactoTipoCambio		float,
    @ContactoMoneda		char(10),
    @Importe   			money,	 
    @ValesCobrados		money,
    @Impuestos	        	money,
    @Retencion 			money,
    @Retencion2			money,
    @Retencion3			money,
    @Comisiones			money,
    @ComisionesIVA		money,
    @IVAFiscal			float,
    @IEPSFiscal			float,
    @CtaDinero			char(10),
    @Cajero			char(10),
    @Agente			char(10),
    @Saldo			money,
    @SaldoInteresesOrdinarios	money,
    @SaldoInteresesMoratorios	money,
    @AplicaManual               bit,
    @ConDesglose		bit,
    @MovAplica			char(20),
    @MovAplicaID		varchar(20),
    @MovAplicaMovTipo		char(20),
    @Beneficiario		int,
    @AgenteNomina		bit,
    @AgentePersonal		char(10), 
    @AgenteNominaMov	 	char(20),
    @AgenteNominaConcepto	varchar(50), 
    @DineroID			int,
    @DineroMov			char(20),
    @DineroMovID		char(20),
    @DineroImporte		money,

    @CfgAplicaAutoOrden		char(20),
    @CfgContX			bit,
    @CfgContXGenerar		char(20),
    @CfgEmbarcar		bit,
    @CfgFormaCobroDA		varchar(50),
    @AutoAjuste			money,
    @AutoAjusteMov		money,
    @CfgDescuentoRecargos	bit,
    @CfgRefinanciamientoTasa 	float,
    --@CfgControlEfectivo	bit,
    --@TopeEfectivoAuto		money,
    --@CfgAplicaDif		bit,
    @CfgMovCargoDiverso		char(20),
    @CfgMovCreditoDiverso	char(20),
    @CfgVentaComisionesCobradas bit,
    @CfgCobroImpuestos		bit,
    @CfgComisionBase		char(20),
    --@CfgComisionCreditoDiverso bit,
    @CfgComisionCreditos	bit,
    @CfgAnticiposFacturados	bit,
    @CfgVentaLimiteNivelSucursal bit,
    @CfgSugerirProntoPago	bit,
    @CfgRetencionAlPago		bit,
    @CfgValidarPPMorosos	bit,
    @CfgRetencionMov		char(20),
    @CfgRetencionAcreedor	char(10),
    @CfgRetencionConcepto	varchar(50),
    @CfgRetencion2Acreedor	char(10),
    @CfgRetencion2Concepto	varchar(50),
    @CfgRetencion3Acreedor	char(10),
    @CfgRetencion3Concepto	varchar(50),
    @CfgAgentAfectarGastos	bit,
    @CfgAC			bit,
    @GenerarGasto		bit,
    @GenerarPoliza		bit,

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
    @FormaCobroVales		varchar(50),

    @Pagares			bit,
    @Aforo			float,
    @Tasa			varchar(50),

    @EstatusNuevo	      	char(15),
    @AfectarCantidadA   	bit,
    @AfectarCantidadPendiente  	bit,
    @Generar                    bit,
    @GenerarSerie		char(20),
    @GenerarAfectado		bit,
    @GenerarCopia		bit,
    @GenerarMovID		varchar(20),    
    
    @Autorizar			bit,
    @Indirecto			bit,	
    @RedondeoMonetarios		int,
    @LineaCredito		varchar(20),
    @TipoAmortizacion		varchar(20),
    @TipoTasa			varchar(20),
    @RamaID			int,
    @SaldoInteresesOrdinariosIVA	float,  --MEJORA10041
    @SaldoInteresesMoratoriosIVA	float,   --MEJORA10041

	@EmidaCarrierID	varchar(255), -- -- BUG 17069
	
	@CtaDineroOmision	varchar(10)  -- Bug 24103

  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  -- Inicializar Variables
  SELECT @AfectarCantidadA 	   = 0,
 	 @AfectarCantidadPendiente = 0,
         @ConDesglose  		   = 0,
         @Generar		   = 0,
         @GenerarSerie		   = NULL,
	 @GenerarAfectado	   = 0,
	 @GenerarCopia		   = 1,
    	 @CobroDesglosado	   = 0.0,
    	 @CobroDelEfectivo	   = 0.0,
    	 @CobroCambio		   = 0.0,
         @ValesCobrados		   = 0.0,
	 @ImpuestosPorcentaje	   = 0.0,
         @RetencionPorcentaje	   = 0.0,
         @Retencion		   = 0.0,
         @Retencion2		   = 0.0,
         @Retencion3		   = 0.0,
	 @ContactoTipo		   = NULL,
         @Autorizacion		   = NULL,
         @Mensaje		   = NULL,
         @ContactoEnviarA	   = NULL,
         @IDOrigen		   = NULL, 
         @OrigenMovTipo		   = NULL,
	 @ProveedorAutoEndoso	   = NULL,
         @Nota 			   = NULL,

	 @DineroID		   = NULL,
         @DineroMov		   = NULL,
         @DineroMovID		   = NULL,
         @DineroImporte		   = NULL,
         @IVAFiscal		   = NULL,
         @IEPSFiscal		   = NULL,
         @OrigenMovTipo		   = NULL,

         @Indirecto		   = 0,
         @Autorizar		   = 0,
         @ContactoTipoCambio	   = 0.0,
         @GenerarGasto		   = 0,
         @CfgContX		   = 0,
         @CfgContXGenerar	   = 'NO',
         @CfgEmbarcar		   = 0,
         --@CfgControlEfectivo	   = 0,
         --@TopeEfectivoAuto	   = 50.0,
         --@CfgAplicaDif	   = 0,
         @Contacto		   = NULL,
         @Beneficiario		   = NULL,
	 @Agente	           = NULL,
         @Cajero		   = NULL,
         @Saldo 	           = 0.0,
         @SaldoInteresesOrdinarios = 0.0,
         @SaldoInteresesMoratorios = 0.0,
         @SaldoInteresesOrdinariosIVA = 0.0, --MEJORA10041
         @SaldoInteresesMoratoriosIVA = 0.0, --MEJORA10041                           
         @AplicaManual	           = 1,
         @AgenteNomina		   = 0/*,
	 @Verificar		   = 1*/

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  -- Leer Datos Generales del Movimiento
  IF @Modulo = 'CXC'
  BEGIN
    SELECT @OrigenTipo = NULLIF(RTRIM(OrigenTipo), ''), @Origen = NULLIF(RTRIM(Origen), ''), @OrigenID = NULLIF(RTRIM(OrigenID), ''), @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Concepto = Concepto, @Proyecto = Proyecto,
           @MovUsuario = Usuario, @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, @Autorizacion = Autorizacion, @Referencia = Referencia,
           @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), @Condicion = NULLIF(RTRIM(Condicion), ''), @Vencimiento = Vencimiento, @FormaPago = NULLIF(RTRIM(FormaCobro), ''),
           @FechaProntoPago = FechaProntoPago, @DescuentoProntoPago = DescuentoProntoPago, 
           @Contacto = NULLIF(RTRIM(Cliente), ''), @ContactoEnviarA = ClienteEnviarA, @ContactoMoneda = NULLIF(RTRIM(ClienteMoneda), ''), @ContactoTipoCambio = ISNULL(ClienteTipoCambio, 0.0), @Importe = ISNULL(Importe, 0.0), @Impuestos = ISNULL(Impuestos, 0.0), @Retencion = ISNULL(Retencion, 0.0), @Retencion2 = ISNULL(Retencion2, 0.0), @Retencion3 = ISNULL(Retencion3, 0.0), 
    	   @CtaDinero = NULLIF(RTRIM(CtaDinero), ''), @Cajero = NULLIF(RTRIM(Cajero), ''), @Agente = NULLIF(RTRIM(Agente), ''), @Saldo = ISNULL(Saldo, 0.0), @SaldoInteresesOrdinarios = ISNULL(SaldoInteresesOrdinarios, 0.0), @SaldoInteresesMoratorios = ISNULL(SaldoInteresesMoratorios, 0.0), @AplicaManual = AplicaManual, @ConDesglose = ConDesglose,         
           @Importe1 = ISNULL(Importe1, 0.0), @Importe2 = ISNULL(Importe2, 0.0), @Importe3 = ISNULL(Importe3, 0.0), @Importe4 = ISNULL(Importe4, 0.0), @Importe5 = ISNULL(Importe5, 0.0),
           @FormaCobro1 = RTRIM(FormaCobro1), @FormaCobro2 = RTRIM(FormaCobro2), @FormaCobro3 = RTRIM(FormaCobro3), @FormaCobro4 = RTRIM(FormaCobro4), @FormaCobro5 = RTRIM(FormaCobro5), 
           @CobroDelEfectivo = ISNULL(DelEfectivo, 0.0), @CobroCambio = ISNULL(Cambio, 0.0),
           @MovAplica = NULLIF(RTRIM(MovAplica), ''), @MovAplicaID = NULLIF(RTRIM(MovAplicaID), ''),
           @GenerarPoliza = GenerarPoliza, @Indirecto = Indirecto, @FechaConclusion = FechaConclusion,
           @IVAFiscal = IVAFiscal, @IEPSFiscal = IEPSFiscal, @Nota = Nota, @Tasa = NULLIF(RTRIM(Tasa), ''),
           @RamaID = NULLIF(RamaID, 0), @LineaCredito = NULLIF(RTRIM(LineaCredito), ''), @TipoAmortizacion = NULLIF(RTRIM(TipoAmortizacion), ''), @TipoTasa = NULLIF(RTRIM(TipoTasa), ''), 
           @Comisiones = ISNULL(Comisiones, 0.0), @ComisionesIVA = ISNULL(ComisionesIVA, 0.0), @SaldoInteresesOrdinariosIVA = ISNULL(SaldoInteresesOrdinariosIVA,0.0), @SaldoInteresesMoratoriosIVA = ISNULL(SaldoInteresesMoratoriosIVA,0.0) --MEJORA10041
      FROM Cxc
     WHERE ID = @ID

    SELECT @CobroDesglosado = @Importe1 + @Importe2 + @Importe3 + @Importe4 + @Importe5
    SELECT @FormaCobroVales = CxcFormaCobroVales FROM EmpresaCfg WHERE Empresa = @Empresa
    IF @FormaCobro1 = @FormaCobroVales SELECT @ValesCobrados = @ValesCobrados + @Importe1
    IF @FormaCobro2 = @FormaCobroVales SELECT @ValesCobrados = @ValesCobrados + @Importe2
    IF @FormaCobro3 = @FormaCobroVales SELECT @ValesCobrados = @ValesCobrados + @Importe3
    IF @FormaCobro4 = @FormaCobroVales SELECT @ValesCobrados = @ValesCobrados + @Importe4
    IF @FormaCobro5 = @FormaCobroVales SELECT @ValesCobrados = @ValesCobrados + @Importe5

    SELECT @ContactoTipo = UPPER(Tipo),
           @CfgDescuentoRecargos = DescuentoRecargos
      FROM Cte
     WHERE Cliente = @Contacto

  END ELSE
  IF @Modulo = 'CXP'
  BEGIN
    SELECT @OrigenTipo = NULLIF(RTRIM(OrigenTipo), ''), @Origen = NULLIF(RTRIM(Origen), ''), @OrigenID = NULLIF(RTRIM(OrigenID), ''), @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Concepto = Concepto, @Proyecto = Proyecto,
           @MovUsuario = Usuario, @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, @Autorizacion = NULLIF(RTRIM(Autorizacion), ''), @Mensaje = Mensaje, @Referencia = Referencia,
           @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), @Condicion = NULLIF(RTRIM(Condicion), ''), @Vencimiento = Vencimiento, @FormaPago = NULLIF(RTRIM(FormaPago), ''),
           @FechaProntoPago = FechaProntoPago, @DescuentoProntoPago = DescuentoProntoPago,
           @Contacto = NULLIF(RTRIM(Proveedor), ''), @ContactoMoneda = NULLIF(RTRIM(ProveedorMoneda), ''), @ContactoTipoCambio = ISNULL(ProveedorTipoCambio, 0.0), @Importe = ISNULL(Importe, 0.0), @Impuestos = ISNULL(Impuestos, 0.0), @Retencion = ISNULL(Retencion, 0.0), @Retencion2 = ISNULL(Retencion2, 0.0), @Retencion3 = ISNULL(Retencion3, 0.0), 
    	   @CtaDinero = NULLIF(RTRIM(CtaDinero), ''), @Cajero = NULLIF(RTRIM(Cajero), ''), @Saldo = ISNULL(Saldo, 0.0), @SaldoInteresesOrdinarios = ISNULL(SaldoInteresesOrdinarios, 0.0), @SaldoInteresesMoratorios = ISNULL(SaldoInteresesMoratorios, 0.0), @AplicaManual = AplicaManual,
           @MovAplica = NULLIF(RTRIM(MovAplica), ''), @MovAplicaID = NULLIF(RTRIM(MovAplicaID), ''),
           @GenerarPoliza = GenerarPoliza, @Indirecto = Indirecto, @Beneficiario = Beneficiario, @FechaConclusion = FechaConclusion,
           @IVAFiscal = IVAFiscal, @IEPSFiscal = IEPSFiscal, @ProveedorAutoEndoso = ProveedorAutoEndoso, @Nota = Nota, @Tasa = NULLIF(RTRIM(Tasa), ''),
           @RamaID = NULLIF(RamaID, 0), @LineaCredito = NULLIF(RTRIM(LineaCredito), ''), @TipoAmortizacion = NULLIF(RTRIM(TipoAmortizacion), ''), @TipoTasa = NULLIF(RTRIM(TipoTasa), ''),
           @Comisiones = ISNULL(Comisiones, 0.0), @ComisionesIVA = ISNULL(ComisionesIVA, 0.0), @SaldoInteresesOrdinariosIVA = ISNULL(SaldoInteresesOrdinariosIVA,0.0), @SaldoInteresesMoratoriosIVA = ISNULL(SaldoInteresesMoratoriosIVA,0.0), --MEJORA10041
		   @EmidaCarrierID =ISNULL(EmidaCarrierID,'') -- BUG 17069
      FROM Cxp
     WHERE ID = @ID

    SELECT @ContactoTipo = UPPER(Tipo),
           @CfgDescuentoRecargos = DescuentoRecargos,
           @Pagares = Pagares,
           @Aforo   = ISNULL(Aforo, 0),
           @CtaDineroOmision = NULLIF(CtaDinero, '')  -- Bug 24103
      FROM Prov
     WHERE Proveedor = @Contacto
  END ELSE
  IF @Modulo = 'AGENT'
  BEGIN
    SELECT @OrigenTipo = NULLIF(RTRIM(OrigenTipo), ''), @Origen = NULLIF(RTRIM(Origen), ''), @OrigenID = NULLIF(RTRIM(OrigenID), ''), @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Concepto = Concepto, @Proyecto = Proyecto,
           @MovUsuario = Usuario, @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, @Autorizacion = Autorizacion, @Referencia = Referencia,
           @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), @FormaPago = NULLIF(RTRIM(FormaPago), ''),
           @Contacto = NULLIF(RTRIM(Agente), ''), @ContactoMoneda = NULLIF(RTRIM(Moneda), ''), @ContactoTipoCambio = ISNULL(TipoCambio, 0.0), @Importe = ISNULL(Importe, 0.0), @Impuestos = ISNULL(Impuestos, 0.0),
           @Agente = NULLIF(RTRIM(Agente), ''), @ImpuestosPorcentaje = ISNULL(ImpuestosPorcentaje, 0.0), @RetencionPorcentaje = ISNULL(RetencionPorcentaje, 0.0),
           @CtaDinero = NULLIF(RTRIM(CtaDinero), ''), @Saldo = ISNULL(Saldo, 0.0), 
           @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion
      FROM Agent
     WHERE ID = @ID

    SELECT @AgenteNomina    	= Nomina,
	   @AgentePersonal  	= Personal, 
	   @AgenteNominaMov 	= NominaMov,
           @AgenteNominaConcepto= NominaConcepto
      FROM Agente 
     WHERE Agente = @Agente
  END
  IF @Accion = 'AUTORIZAR'
    SELECT @Autorizacion = @Usuario, @Accion = 'AFECTAR'

  IF @MovAplica IS NOT NULL
    SELECT @MovAplicaMovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @MovAplica

  IF @ContactoTipo = 'ESTRUCTURA' SELECT @Ok = 20680

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario 

  -- Si va a Generar un Movimiento 
  IF @GenerarMov IS NOT NULL AND @Accion <> 'CANCELAR'
    SELECT @Generar = 1

  IF @Generar = 1 AND @OrigenTipo <> 'CAM'
    SELECT @Cajero = DefCajero, @CtaDinero = ISNULL(@CtaDinero,DefCtaDinero) FROM Usuario WHERE Usuario = @Usuario
  
  -- Bug 24103
  IF @CtaDinero IS NULL AND @CtaDineroOmision IS NOT NULL
    SELECT @CtaDinero = @CtaDineroOmision 

  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('VERIFICAR', 'AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, @Estatus, @Concepto OUTPUT, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT, @GenerarGasto = @GenerarGasto OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  IF @OrigenTipo IS NOT NULL AND @Origen IS NOT NULL
  BEGIN
    EXEC spMovEnMaxID @OrigenTipo, @Empresa, @Origen, @OrigenID, @IDOrigen OUTPUT, @Ok OUTPUT
    SELECT @OrigenMovTipo = Clave FROM MovTipo WHERE Modulo = @OrigenTipo AND Mov = @Origen
  END

  --IF @MovTipo = 'CXC.FA' AND @Accion = 'AFECTAR'  AND (SELECT dbo.fnEspitex(@Contacto)) = 1 --ANTICIPOFACTURADO
    --UPDATE CXC SET @Retencion = Retencion = @Impuestos WHERE ID = @ID
 
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
        EXEC spAsignarSucursalEstatus @ID, @Modulo, @Sucursal, 'SINAFECTAR'
      END
    END
  END

  IF @MovTipo = 'CXC.AR'
  BEGIN
    IF @Accion <> 'VERIFICAR' BEGIN TRANSACTION
    IF EXISTS(SELECT * FROM CxcD d, Cxc e WHERE d.ID = @ID AND d.Aplica = e.Mov AND d.AplicaID = e.MovID AND e.Empresa = @Empresa AND e.Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') AND e.Sucursal <> @SucursalDestino) SELECT @Ok = 60390
  END

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'PENDIENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE'))
  BEGIN
    SELECT @CfgAplicaAutoOrden = 
             CASE @Modulo 
     	       WHEN 'CXC'   THEN ISNULL(UPPER(RTRIM(CxcAplicaAutoOrden)), 'FECHA VENCIMIENTO')
     	       WHEN 'CXP'   THEN ISNULL(UPPER(RTRIM(CxpAplicaAutoOrden)), 'FECHA VENCIMIENTO')
     	       WHEN 'AGENT' THEN ISNULL(UPPER(RTRIM(CxpAplicaAutoOrden)), 'FECHA VENCIMIENTO')
	     END,

	  @AutoAjuste = 
             CASE @Modulo 
     	       WHEN 'CXC'   THEN ISNULL(NULLIF(CxcAutoAjuste, 0.0), 0.01)
     	       WHEN 'CXP'   THEN ISNULL(NULLIF(CxpAutoAjuste, 0.0), 0.01)
     	       WHEN 'AGENT' THEN ISNULL(NULLIF(CxpAutoAjuste, 0.0), 0.01)
	     END,

	  @AutoAjusteMov = 
             CASE @Modulo 
     	       WHEN 'CXC'   THEN ISNULL(NULLIF(CxcAutoAjusteMov, 0.0), 0.01)
     	       WHEN 'CXP'   THEN ISNULL(NULLIF(CxpAutoAjusteMov, 0.0), 0.01)
     	       WHEN 'AGENT' THEN ISNULL(NULLIF(CxpAutoAjusteMov, 0.0), 0.01)
	     END,
      
          @CfgFormaCobroDA = 
             CASE @Modulo 
     	       WHEN 'CXC' THEN NULLIF(RTRIM(CxcFormaCobroDA), '')
     	       WHEN 'CXP' THEN NULLIF(RTRIM(CxcFormaCobroDA), '')
               ELSE NULL
             END,

          @CfgRefinanciamientoTasa =
             CASE @Modulo 
     	       WHEN 'CXC' THEN ISNULL(CxcRefinanciamientoTasa, 0.0)
               ELSE NULL
             END,

/*
          @CfgControlEfectivo = 
              CASE @Modulo 
		WHEN 'CXC' THEN CxcControlEfectivo
  		WHEN 'CXP' THEN CxpControlEfectivo
                ELSE NULL
              END,

	  @TopeEfectivoAuto = 
              CASE @Modulo 
		WHEN 'CXC' THEN ISNULL(CxcTopeEfectivoAuto, 50.0)
		WHEN 'CXP' THEN ISNULL(CxpTopeEfectivoAuto, 50.0)
                ELSE convert(money, 0.0)
              END,*/

          @CfgVentaComisionesCobradas = VentaComisionesCobradas,
          @CfgComisionBase	      = UPPER(ComisionBase),
          @CfgValidarPPMorosos	      = ISNULL(CxcValidarDescPPMorosos, 0)

      FROM EmpresaCfg
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    SELECT @CfgAnticiposFacturados    = CxcAnticiposFacturados,
           @CfgCobroImpuestos         = CxcCobroImpuestos,
           @CfgComisionCreditos       = CxcComisionCreditos,
           @CfgVentaLimiteNivelSucursal = VentaLimiteNivelSucursal,
           @CfgSugerirProntoPago      = CxcSugerirProntoPago,
           @CfgRetencionAlPago        = ISNULL(RetencionAlPago, 0),
           @CfgRetencionAcreedor      = NULLIF(RTRIM(GastoRetencionAcreedor), ''),
    	   @CfgRetencionConcepto      = NULLIF(RTRIM(GastoRetencionConcepto), ''),
           @CfgRetencion2Acreedor     = NULLIF(RTRIM(GastoRetencion2Acreedor), ''),
    	   @CfgRetencion2Concepto     = NULLIF(RTRIM(GastoRetencion2Concepto), ''),
           @CfgRetencion3Acreedor     = NULLIF(RTRIM(GastoRetencion3Acreedor), ''),
    	   @CfgRetencion3Concepto     = NULLIF(RTRIM(GastoRetencion3Concepto), ''),
           @CfgAgentAfectarGastos     = ISNULL(AgentAfectarGastos, 0)
           /*@CfgComisionAnticipos      = UPPER(ComisionAnticipos),
           @CfgComisionCreditoDiverso = CxcComisionCreditoDiverso,
 	   @CfgAplicaDif = 
              CASE @Modulo 
		WHEN 'CXC' THEN CxcAplicaDif
  		WHEN 'CXP' THEN CxpAplicaDif
                ELSE NULL
              END*/
      FROM EmpresaCfg2
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1
 
    SELECT @AutoAjuste = @AutoAjuste /* / @MovTipoCambio*/

    SELECT @CfgContX = ContX,
           @CfgAC = ISNULL(AC, 0)
      FROM EmpresaGral
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @CfgContX = 1 
      SELECT @CfgContXGenerar = ContXGenerar
        FROM EmpresaCfgModulo
       WHERE Empresa = @Empresa
         AND Modulo  = @Modulo
    IF @@ERROR <> 0 SELECT @Ok = 1

    SELECT @CfgRetencionMov = CASE WHEN @MovTipo = 'CXP.DC' THEN CxpDevRetencion ELSE CxpRetencion END
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

   SELECT @CfgMovCargoDiverso = NULL,
          @CfgMovCreditoDiverso = NULL
 
    IF EXISTS(SELECT * FROM EmpresaCfgMovEsp WHERE Empresa = @Empresa AND Asunto = 'EMB' AND Modulo = @Modulo AND Mov = @Mov)
      SELECT @CfgEmbarcar = 1

   IF @MovTipo IN ('CXC.NCP','CXP.NCP') SELECT @AplicaManual = 0

    -- Checar Tipo de Movimiento
    IF @Accion <> 'CANCELAR' 
      IF (@MovTipo IN ('CXC.A','CXC.AR','CXC.FAC','CXC.DAC','CXC.F','CXC.FA','CXC.AF','CXC.VV','CXC.IM','CXC.RM','CXC.CD','CXC.D','CXC.DM','CXC.DA','CXC.DP', 
                       'CXP.A','CXP.F', 'CXP.FAC','CXP.DAC','CXP.AF','CXP.CD','CXP.D','CXP.DM','CXP.PAG','CXP.DA','CXP.DP',
		               'CXC.SD', 'CXC.SCH', 'CXP.SD', 'CXP.SCH',		
		               'AGENT.C', 'AGENT.D', 'AGENT.A')) OR
         (@MovTipo IN ('CXC.NC','CXC.NCD','CXC.NCF','CXC.CA','CXC.CAD','CXC.CAP','CXC.NCP','CXC.DV',
                       'CXP.NC','CXP.NCD','CXP.NCF','CXP.CA','CXP.CAD','CXP.CAP','CXP.NCP') AND @AplicaManual = 0)
        SELECT @EstatusNuevo = 'PENDIENTE'

    -- Calcular CteFactor
    EXEC spMoneda @Accion, @MovMoneda, @MovTipoCambio, @ContactoMoneda, @ContactoFactor, @ContactoTipoCambio, @Ok OUTPUT

    SELECT @ContactoFactor = @ContactoTipoCambio / @MovTipoCambio

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spCxVerificar @ID, @Accion, @Empresa, @Usuario, @Autorizacion, @Mensaje, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                         @FechaEmision, @Condicion OUTPUT, @Vencimiento OUTPUT, @FormaPago, @Referencia, @Contacto, @ContactoTipo, @ContactoEnviarA, @ContactoMoneda, @ContactoFactor, @ContactoTipoCambio, @Importe, @ValesCobrados, @Impuestos, @Retencion, @Retencion2, @Retencion3, @Saldo, @CtaDinero, @Agente, @AplicaManual, @ConDesglose, 
                         @CobroDesglosado, @CobroDelEfectivo, @CobroCambio, 
                         @Indirecto, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @EstatusNuevo, @AfectarCantidadPendiente, @AfectarCantidadA, @CfgContX, @CfgContXGenerar, @CfgEmbarcar, @AutoAjuste, @AutoAjusteMov, /*@CfgAplicaDif, */@CfgDescuentoRecargos, @CfgFormaCobroDA, @CfgRefinanciamientoTasa, @CfgAnticiposFacturados, @CfgValidarPPMorosos, @CfgAC,
			 @Pagares,
			 @OrigenTipo, @OrigenMovTipo, @MovAplica, @MovAplicaID, @MovAplicaMovTipo, @AgenteNomina, 
                         @RedondeoMonetarios, @Autorizar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,
		         @INSTRUCCIONES_ESP,
				 @EmidaCarrierID -- BUG 17069

      IF @Autorizar = 1 AND @Modulo = 'CXP' 
      BEGIN
        UPDATE Cxp SET Mensaje = @Ok WHERE ID = @ID
      END

      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR','GENERAR','CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END 
    -- No se pueden reafectar los movimientos pendientes
    IF @Estatus = 'PENDIENTE' AND @Accion = 'AFECTAR' AND @Ok IS NULL 
      SELECT @Ok = 60040

    IF @Accion IN ('AFECTAR','GENERAR','CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
    BEGIN  
      EXEC spCxAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, 
                       @FechaEmision, @FechaAfectacion, @FechaConclusion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 
                       @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @Beneficiario,
                       @Condicion, @Vencimiento, @FechaProntoPago, @DescuentoProntoPago, @FormaPago, @Contacto, @ContactoEnviarA, @ContactoMoneda, @ContactoFactor, @ContactoTipoCambio, @Importe, @ValesCobrados, @Impuestos, @Retencion, @Retencion2, @Retencion3, @Comisiones, @ComisionesIVA, 
                       @Saldo, @SaldoInteresesOrdinarios, @SaldoInteresesMoratorios, 
                       @CtaDinero, @Cajero, @Agente, @AplicaManual, @ConDesglose,
                       @CobroDesglosado, @CobroDelEfectivo, @CobroCambio, @ImpuestosPorcentaje, @RetencionPorcentaje, @Aforo, @Tasa,
                       @CfgAplicaAutoOrden, 
                       @AfectarCantidadPendiente, @AfectarCantidadA,
		       @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
                       @CfgRetencionAlPago, @CfgRetencionMov, @CfgRetencionAcreedor, @CfgRetencionConcepto, @CfgRetencion2Acreedor, @CfgRetencion2Concepto, @CfgRetencion3Acreedor, @CfgRetencion3Concepto, @CfgAgentAfectarGastos,
                       @CfgContX, @CfgContXGenerar, @CfgEmbarcar, @AutoAjuste, @AutoAjusteMov, @CfgDescuentoRecargos, @CfgFormaCobroDA, 
		       /*@CfgControlEfectivo, @TopeEfectivoAuto, @CfgAplicaDif, */@CfgMovCargoDiverso, @CfgMovCreditoDiverso, @CfgVentaComisionesCobradas, @CfgCobroImpuestos, @CfgComisionBase, /*@CfgComisionCreditoDiverso,*/ @CfgComisionCreditos, @CfgVentaLimiteNivelSucursal, @CfgSugerirProntoPago, @CfgAC,
                       @GenerarGasto, @GenerarPoliza, 
                       @IDOrigen, @OrigenTipo, @OrigenMovTipo, @MovAplica, @MovAplicaID, @MovAplicaMovTipo, 
                       @AgenteNomina, @AgentePersonal, @AgenteNominaMov, @AgenteNominaConcepto, 
                       @IVAFiscal, @IEPSFiscal, @ProveedorAutoEndoso,
		       @RamaID, @LineaCredito, @TipoAmortizacion, @TipoTasa,
                       @Generar, @GenerarMov OUTPUT, @GenerarSerie, @GenerarAfectado, @GenerarCopia, @RedondeoMonetarios,
                       @IDGenerar OUTPUT, @GenerarMovID OUTPUT, 
                       @Ok OUTPUT, @OkRef OUTPUT,
		       @INSTRUCCIONES_ESP, @Nota, @Base = @Base, @Origen = @Origen, @OrigenID = @OrigenID, @SaldoInteresesOrdinariosIVA = @SaldoInteresesOrdinariosIVA, @SaldoInteresesMoratoriosIVA = @SaldoInteresesMoratoriosIVA, --MEJORA10041
		       @EstacionTrabajo = @EstacionTrabajo -- REQ12336
      IF @Generar = 1 
      BEGIN
        -- Registrar el Flujo	
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @IDGenerar, @GenerarMov, @GenerarMovID, @Ok OUTPUT

        -- Avisar Movimiento Generado
        IF @Ok IS NULL AND @Accion <> 'CANCELAR'
          SELECT @Ok = 80030, @Mov = @GenerarMov
      END
    END
  END ELSE 
    IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
    IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010
    ELSE SELECT @Ok = 60040

  IF @Accion = 'SINCRO' AND @Ok = 80060 
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
    IF @EnLinea = 1 EXEC spSincroFinalModulo @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF @MovTipo = 'CXC.AR' AND @Accion <> 'VERIFICAR'
  BEGIN
    IF @Accion IN ('SINCRO', 'CANCELAR')
    BEGIN
      IF @Ok IN (80030, 80060) SELECT @Ok = NULL
      IF @ConDesglose = 1 AND @CobroDelEfectivo > 0.0 
        SELECT @Ok = 60380
      ELSE BEGIN 
        SELECT @DineroImporte = @Importe + @Impuestos - @Retencion - @Retencion2 - @Retencion3
        EXEC @DineroID = spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                         @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @ConDesglose, 0,
                                         @FechaRegistro, @Ejercicio, @Periodo, 
                                         @FormaPago, NULL, @Beneficiario,
                                         @Contacto, @CtaDinero, @Cajero, @DineroImporte, NULL,
          	                         NULL, NULL, @Vencimiento,
                                         @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                         @Ok OUTPUT, @OkRef OUTPUT, @Nota = @Nota
        IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
        IF @Ok IS NULL
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT
      END
    END ELSE 
      IF @SucursalOrigen = @Sucursal SELECT @Ok = 60370
    IF @Ok IN (NULL, 80030, 80060) 
      COMMIT TRANSACTION 
    ELSE 
      ROLLBACK TRANSACTION
  END

  -- Si hay Mensaje pero no tiene referencia
  IF @Ok IS NOT NULL AND @OkRef IS NULL 

    -- Si se Genero un Movimiento, Desplegarlo
    IF @Ok = 80030
      SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov)+' '+LTRIM(Convert(Char, @GenerarMovID))

    -- Si hubo un error poner como referencia el Movimiento
    ELSE
      SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL

  RETURN ISNULL(@IDGenerar, 0)
END
GO

/**************** spGenerarAfectarCx ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarAfectarCx') and type = 'P') drop procedure dbo.spGenerarAfectarCx
GO
CREATE PROCEDURE spGenerarAfectarCx
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
		   @MovEspecifico		varchar(20),

    		   @CxModulo			char(5)		OUTPUT,
    		   @CxMov			char(20)	OUTPUT,
    		   @CxMovID			varchar(20)	OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,
		   @INSTRUCCIONES_ESP		varchar(20) 	= NULL,
		   @IVAFiscal			float		= NULL,
		   @IEPSFiscal			float		= NULL,
		   @PersonalCobrador		char(10)	= NULL,
		   @Retencion2			money		= NULL,
		   @Retencion3			money		= NULL,
		   @ModuloEspecifico		char(5)		= NULL,
		   @EndosarA			varchar(10)	= NULL,
		   @Conteo			int		= NULL,
		   @Nota			varchar(100)	= NULL,
		   @MovIDEspecifico		varchar(20)     = NULL,
		   @ContUso			varchar(20)	= NULL,
		   @LineaCredito		varchar(20)	= NULL,
		   @LineaCreditoExpress		bit		= NULL,
	           @TipoAmortizacion		varchar(20)	= NULL,
                   @TipoTasa			varchar(20)	= NULL,
		   @TieneTasaEsp		bit		= NULL,
		   @TasaEsp			float		= NULL,
    		   @Comisiones			money		= NULL,
    		   @ComisionesIVA		money		= NULL,
		   @CopiarMovImpuesto		bit		= 0,
		   @NoAutoAplicar			bit		= 0		-- BUG10848
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ReferenciaOriginal		varchar(50),
    @EndosoID			int,
    @CxID			int,
    @CxMovTipo			varchar(20),
    @CxEsCredito		bit,
    @IDGenerar			int,
    @Saldo	  		money,
    @CfgMovCxcAnticipo		char(20),
    @CfgMovCxpAnticipo		char(20),
    @CfgMovCxcAjusteSaldo	char(20),
    @CfgMovCxpAjusteSaldo	char(20),
    @CfgMovFaltanteCaja		char(20),
    @CfgMovCxcForwardPorCobrar	char(20),
    @CfgMovCxpForwardPorPagar	char(20),
    @CfgMovFactura		char(20),
    @CfgMovGastoDiverso		char(20),
    @CfgMovCobro		char(20),
    @CfgMovPago			char(20),
    @CfgMovCxpNomina		char(20),
    @CfgMovCxpCancelacionNomina	char(20),
    @CfgMovCxcNomina		char(20),
    @CfgMovCxcCancelacionNomina	char(20),
    @CfgMovAvanceCxp		char(20),
    @CfgMovRetrocesoCxp		char(20),
    @CfgMovEmbarqueCxp		char(20),
    @CfgMovCxcVentaVales	char(20),
    @CfgMovCxcObsequioVales	char(20),
    @CfgMovCxcObsequioTarjetas	char(20), 	-- ETO Tarjetas 9-Feb-2007
    @CfgMovCxcAplicacionVales	char(20),
    @CfgMovCxcAplicacionTarjetas char(20), 	-- ETO Tarjetas 9-Feb-2007
    @CfgMovCxcDevolucionVales	char(20),
    @CfgMovCxpGastoDev          char(20),
    @CfgMovCxpGastoDevProrrateada char(20),
    @CfgMovCxpImportacion	char(20),
    @CfgMovCxcEndoso		char(20),
    @CfgMovCxpEndoso		char(20),
    @CfgMovCxcEndosoAFavor	char(20),
    @CfgMovCxpEndosoAFavor	char(20),
    @CfgComisionEspecial	bit,
    @CfgCompraAutoEndoso	bit,
    @CfgCompraAutoEndosoEmpresas bit,
    @CfgCompraAutoEndosoWS	bit,
    @CfgCompraAutoEndosoWSDL	varchar(255),
    @CfgCompraAutoEndosoMovs	bit,
    @CfgCompraAutoEndosoAutoCargos bit,
    @CfgEmbarqueCobrarDemas	bit,

    @CfgConsecutivoIndep 	bit,
    @CfgComisionesCobradas	bit,
    @ComisionPendiente		money,
    @AplicaManual		bit,
    @CxcMonedaCont		bit,
    @CxpMonedaCont		bit,
    @AgentMonedaCont		bit,
    @IDOrigen			int,
    @OrigenTipo			char(20),
    @Origen			char(20),
    @OrigenID			char(20),
    @OrigenEstatus 		char(15),
    @OrigenSucursal		int, 
    @OrigenUEN  		int,
    @Endoso			varchar(10),
    @CxEndosoID			int, 
    @CxEndosoMov		char(20), 
    @CxEndosoMovID		varchar(20), 
    @ContactoOriginal		char(10),
    @ProveedorAutoEndoso	varchar(10),
    @AutoAplicar		bit,
    @SaldoMN			money,
    @AplicaSaldoMN		money,
    @GastoCxc			bit,
    @AC				bit,
    @RetencionAlPago		bit,
    @DefImpuesto 		float,
    @ZonaImpuesto		varchar(50),
    @ArrastrarMovID		bit,
    @AplicarDemas		bit,
    @CxEstatus			varchar(15),
    @CfgGenerarEnBorrador	bit,
    @ContratoID			int,
    @ContratoMov		varchar(20),
    @ContratoMovID		varchar(20),
    @SubClave			varchar(20),
    @GasConceptoMultiple        bit,--Mejora 5425
    @MonedaOrigen			char(10),
    @TipoCambioOrigen		float,       
    @CteMoneda				char(10),
    @CteTipoCambio		 	float,
    @OrigenMovTipo     		char(20)
    

  SELECT @CxModulo = NULL,
         @CxMov    = NULL,
         @CxMovID  = NULL,
         @Endoso   = NULL,
         @ComisionPendiente = NULL,
	 @CfgConsecutivoIndep = 0,
	 @CxcMonedaCont = 0,
	 @CxpMonedaCont = 0,
	 @AgentMonedaCont = 0,
         @OrigenTipo = @Modulo,
         @Origen     = @Mov,
         @OrigenID   = @MovID,
         @ContactoOriginal = @Contacto,
	 @ProveedorAutoEndoso = NULL, 
         @CxEsCredito = 0,
         @GastoCxc    = 0,
         @AC          = 0,
         @RetencionAlPago = 0,
         @ReferenciaOriginal = @Referencia,
         @AplicarDemas = 0,
         @ContratoID = NULL,
         @ContratoMov = NULL,
         @ContratoMovID = NULL,
         @OrigenMovTipo = NULL

  SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo 
  EXEC xpGenerarAfectarCxOrigenID @Modulo, @ID, @OrigenID OUTPUT

  IF @INSTRUCCIONES_ESP = 'SIN_ORIGEN' SELECT @OrigenTipo = NULL, @Origen = NULL, @OrigenID = NULL
  IF @INSTRUCCIONES_ESP = 'RETENCION'  SELECT @OrigenTipo = @INSTRUCCIONES_ESP

  SELECT @AC = ISNULL(AC, 0)
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @CfgComisionesCobradas       = VentaComisionesCobradas,
         @CfgComisionEspecial         = ISNULL(ComisionEspecial, 0),
         @CfgCompraAutoEndoso         = ISNULL(CompraAutoEndoso, 0),
         @CfgCompraAutoEndosoEmpresas = ISNULL(CompraAutoEndosoEmpresas, 0),
         @CfgCompraAutoEndosoWS	      = ISNULL(CompraAutoEndosoWS, 0),
         @CfgCompraAutoEndosoWSDL     = CompraAutoEndosoWSDL,
         @CfgCompraAutoEndosoMovs     = ISNULL(CompraAutoEndosoMovs, 0),
         @CfgCompraAutoEndosoAutoCargos= ISNULL(CompraAutoEndosoAutoCargos, 0),
         @CfgEmbarqueCobrarDemas      = ISNULL(EmbarqueCobrarDemas, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @CfgConsecutivoIndep = CASE @MovTipo
   	    	   	          WHEN 'VTAS.D'  THEN VentaDevConsecutivoIndep 
   	    	   	          WHEN 'VTAS.DF' THEN VentaDevConsecutivoIndep 
   	    	   	          WHEN 'VTAS.B'  THEN VentaBonifConsecutivoIndep 
				  WHEN 'COMS.D'  THEN CompraDevConsecutivoIndep 
				  WHEN 'COMS.B'  THEN CompraBonifConsecutivoIndep 
				  ELSE 0
			        END,
         @AutoAplicar        = CASE @MovTipo
   	    	   	          WHEN 'VTAS.D'  THEN VentaDevAutoAplicar 
   	    	   	          WHEN 'VTAS.DF' THEN VentaDevAutoAplicar 
   	    	   	          WHEN 'VTAS.B'  THEN VentaDevAutoAplicar
				  WHEN 'COMS.D'  THEN CompraDevAutoAplicar
				  WHEN 'COMS.B'  THEN CompraDevAutoAplicar
				  ELSE 0
			        END,
	 @CxcMonedaCont        	= CxcMonedaCont,
	 @CxpMonedaCont        	= CxpMonedaCont,
	 @AgentMonedaCont       = AgentMonedaCont,
         @GastoCxc		= ISNULL(GastoCxc, 0),
         @GasConceptoMultiple   = ISNULL(GasConceptoMultiple,0) --mejora 5425
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa



  IF @CfgCompraAutoEndoso = 1 AND @Modulo = 'COMS'
  BEGIN
    SELECT @Endoso = NULLIF(RTRIM(AutoEndoso), '') FROM Prov WHERE Proveedor = @Contacto
    EXEC xpCompraAutoEndoso @Empresa, @Accion, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Endoso OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    IF @Endoso IS NOT NULL 
    BEGIN
      IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = @Endoso) SELECT @Ok = 26050, @OkRef = @Endoso

      IF @CfgCompraAutoEndosoEmpresas = 1 AND @Ok IS NULL
      BEGIN
        IF NOT EXISTS(SELECT * FROM Cte     WHERE Cliente = @Empresa) SELECT @Ok = 26060, @OkRef = @Empresa
        IF NOT EXISTS(SELECT * FROM Empresa WHERE Empresa = @Endoso)  SELECT @Ok = 26070, @OkRef = @Endoso
        IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'CXC' AND Mov = @Mov) SELECT @Ok = 26080, @OkRef = RTRIM(@Mov)+' en Cuentas por Cobrar (Auto Endosar CXP)'
      END 

      IF @CfgCompraAutoEndosoAutoCargos = 0 AND @Ok IS NULL 
      BEGIN
        IF @CfgCompraAutoEndosoMovs = 1 
          SELECT @EndosarA = @Endoso
        ELSE
          SELECT @ProveedorAutoEndoso = @Contacto, @Contacto = @Endoso
      END
    END
  END

  IF @CfgComisionesCobradas = 1 SELECT @ComisionPendiente = @ComisionTotal
  IF @ModuloAfectar = 'AGENT'
  BEGIN
    IF @CfgComisionEspecial = 1 RETURN 0
    SELECT @CxMov = @MovEspecifico, @CxModulo = @ModuloAfectar

    IF @CxMov IS NULL
      SELECT @CxMov = CASE 
		      WHEN @MovTipo IN ('CXC.C','CXC.A','CXC.AA','CXC.AR', 'VTAS.F','VTAS.FAR','VTAS.FB','CXC.F','CXC.FA','CXC.AF','VTAS.N','VTAS.NO','VTAS.NR','VTAS.FM','CXC.CA', 'CXC.CAD','CXC.ANC') AND (ISNULL(@ComisionTotal, 0.0)>=0.0) THEN NULLIF(RTRIM(AgentComision), '')
		      WHEN (@MovTipo IN ('VTAS.D', 'VTAS.DF', 'CXC.NC', 'CXC.NCD', 'CXC.CD')) OR (@MovTipo IN ('VTAS.N','VTAS.NO','VTAS.NR','VTAS.FM','VTAS.F','VTAS.FAR') AND (ISNULL(@ComisionTotal, 0.0)<0.0)) THEN NULLIF(RTRIM(AgentDevolucion), '')
		      WHEN @MovTipo = 'VTAS.B'   THEN NULLIF(RTRIM(AgentBonificacion), '')
		      WHEN @MovTipo = 'DIN.F'    THEN NULLIF(RTRIM(AgentFaltanteCaja), '')
		      WHEN @MovTipo = 'INV.A'    THEN NULLIF(RTRIM(AgentAjusteInv), '')
                    END
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa

    SELECT @Referencia = RTRIM(@Mov) + ' ' + LTRIM(CONVERT(char, @MovID))
    SELECT @ComisionTotal = ABS(@ComisionTotal)
  END ELSE 
  BEGIN
    IF @Modulo = 'CAM'
      SELECT @CxMovID = NULL, @Referencia = LTRIM(CONVERT(char, @MovID))
    ELSE 
      SELECT @CxMovID = @MovID

    
    IF @Modulo = 'GAS' AND @GasConceptoMultiple = 1 SET @CxMovID = NULL --Mejora 5425
    
    IF @MovTipo IN ('VTAS.D', 'VTAS.DF', 'VTAS.B', 'COMS.D', 'COMS.B') AND @CfgConsecutivoIndep = 1 
      SELECT @CxMovID = NULL, @Referencia = RTRIM(@Mov) + ' ' + LTRIM(CONVERT(char, @MovID))
    IF @Modulo IN ('VTAS', 'VALE', 'CXC', 'DIN') SELECT @CxModulo = 'CXC' ELSE
    IF @Modulo IN ('COMS', 'PROD', 'INV', 'CXP') SELECT @CxModulo = 'CXP' ELSE
    IF @Modulo = 'GAS'
    BEGIN
      SELECT @CxModulo = 'CXP'
      SELECT @RetencionAlPago = ISNULL(RetencionAlPago, 0) FROM Gasto WHERE ID = @ID
      IF @GastoCxc = 1 
        IF EXISTS(SELECT * FROM Cte WHERE Cliente = @Contacto AND EsProveedor = 1) 
          SELECT @CxModulo = 'CXC'
    END ELSE
    IF @Modulo = 'CAM' 
      IF UPPER(@Tipo) IN ('COMPRA', 'COBRO') SELECT @CxModulo = 'CXC' ELSE SELECT @CxModulo = 'CXP'

    IF @MovTipo = 'VTAS.FX'
    BEGIN
      SELECT @CxModulo = 'CXP', @Vencimiento = NULL, @Contacto = NULL, @Retencion = NULL, @Retencion2 = NULL, @Retencion3 = NULL, @ComisionTotal = NULL --MEJORA4648
      SELECT @Contacto = p.Proveedor, @Condicion = p.Condicion, @ZonaImpuesto = p.ZonaImpuesto FROM Venta v, Prov p WHERE v.ID = @ID AND p.Proveedor = v.GastoAcreedor     
      IF @Contacto IS NULL SELECT @Ok = 55110

      SELECT @DefImpuesto = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa
      EXEC spZonaImp @ZonaImpuesto, @DefImpuesto OUTPUT
      SELECT @Importe = SUM(CostoTotal) FROM VentaTCalc WHERE ID = @ID
      SELECT @Impuestos = @Importe * (@DefImpuesto / 100)
    END

    IF @Modulo = 'EMB' 
    BEGIN
      IF UPPER(@Tipo) IN ('COBRADO', 'COBRO PARCIAL') SELECT @CxModulo = 'CXC', @CxMovID = NULL ELSE 
      IF UPPER(@Tipo) = 'PAGADO'  SELECT @CxModulo = 'CXP', @CxMovID = NULL ELSE 
      IF UPPER(@Tipo) = 'CXP'     SELECT @CxModulo = 'CXP' 
    END
    IF @MovTipo = 'GAS.ASC' SELECT @CxModulo = 'AGENT'
    IF @Modulo = 'FIS' SELECT @CxModulo = @ModuloAfectar

    --IF @MovTipo = 'VTAS.N' SELECT @Importe = -@Importe, @Impuestos = -@Impuestos, @ComisionTotal = -@ComisionTotal
    SELECT @Saldo  = ISNULL(@Importe, 0.0) + ISNULL(@Impuestos, 0.0) - ISNULL(@Retencion, 0.0) - ISNULL(@Retencion2, 0.0) - ISNULL(@Retencion3, 0.0), @IDGenerar = NULL --MEJORA4648

    SELECT @CfgMovCobro	   = NULLIF(RTRIM(CxcCobro), ''),
           @CfgMovPago	   = NULLIF(RTRIM(CxpPago), ''),
           @CfgMovCxpNomina   = NULLIF(RTRIM(CxpNomina), ''),
	   @CfgMovCxpCancelacionNomina = NULLIF(RTRIM(CxpCancelacionNomina), ''),
           @CfgMovCxcNomina   = NULLIF(RTRIM(CxcNomina), ''),
	   @CfgMovCxcCancelacionNomina = NULLIF(RTRIM(CxcCancelacionNomina), ''),
           @CfgMovGastoDiverso = NULLIF(RTRIM(CxpGastoDiverso), ''),
           @CfgMovEmbarqueCxp  = NULLIF(RTRIM(EmbarqueCxp), ''),
           @CfgMovAvanceCxp    = NULLIF(RTRIM(ProdAvanceCxp), ''),
           @CfgMovRetrocesoCxp = NULLIF(RTRIM(ProdRetrocesoCxp), ''),
           @CfgMovCxcAnticipo  = NULLIF(RTRIM(CxcAnticipo), ''),
           @CfgMovCxpAnticipo  = NULLIF(RTRIM(CxpAnticipo), ''),
           @CfgMovCxcAjusteSaldo  = NULLIF(RTRIM(CxcAjusteSaldo), ''),
           @CfgMovCxpAjusteSaldo  = NULLIF(RTRIM(CxpAjusteSaldo), ''),
           @CfgMovCxcForwardPorCobrar = NULLIF(RTRIM(CxcForwardPorCobrar), ''),
           @CfgMovCxpForwardPorPagar  = NULLIF(RTRIM(CxpForwardPorPagar), ''),
           @CfgMovCxcVentaVales      = NULLIF(RTRIM(CxcVentaVales), ''),
           @CfgMovCxcObsequioVales   = NULLIF(RTRIM(CxcObsequioVales), ''),
           @CfgMovCxcAplicacionVales = NULLIF(RTRIM(CxcAplicacionVales), ''),
           --@CfgMovCxcAplicacionTarjetas = NULLIF(RTRIM(CxcAplicacionTarjetas), ''), 	-- ETO Tarjetas 9-Feb-2007
           @CfgMovCxcDevolucionVales = NULLIF(RTRIM(CxcDevolucionVales), ''),
     	   @CfgMovCxpGastoDev             = CxpGastoDev,
	   @CfgMovCxpGastoDevProrrateada  = CxpGastoDevProrrateada,
	   @CfgMovCxpImportacion     = NULLIF(RTRIM(CxpImportacion), ''),
           @CfgMovFaltanteCaja       = CxcFaltanteCaja,
           @CfgMovCxcEndoso          = CxcEndoso, 
           @CfgMovCxpEndoso          = CxpEndoso,
           @CfgMovCxcEndosoAFavor    = CxcEndosoAFavor,
           @CfgMovCxpEndosoAFavor    = CxpEndosoAFavor
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @ModuloEspecifico IS NOT NULL SELECT @CxModulo = @ModuloEspecifico
    IF @MovEspecifico IS NOT NULL
    BEGIN
      SELECT @CxMov = @MovEspecifico, @CxMovID = @MovIDEspecifico
    END ELSE
    BEGIN
      IF @Modulo = 'CXC' 
      BEGIN
        SELECT @CxModulo = @ModuloAfectar, @CxMovID = NULL
        IF @MovTipo = 'CXC.RA'  SELECT @CxMov = @CfgMovCxcAnticipo ELSE
        IF @MovTipo = 'CXC.NCF' SELECT @CxMov = @CfgMovCxcForwardPorCobrar
      END ELSE
      IF @Modulo = 'CXP' 
      BEGIN
        SELECT @CxModulo = @ModuloAfectar, @CxMovID = NULL
        IF @MovTipo = 'CXP.RA'  SELECT @CxMov = @CfgMovCxpAnticipo ELSE
        IF @MovTipo = 'CXP.NCF' SELECT @CxMov = @CfgMovCxpForwardPorPagar
      END ELSE
      IF @Modulo = 'NOM'
      BEGIN
        SELECT @CxMovID = NULL
        IF @CxModulo = 'CXP' SELECT @CxMov = CASE WHEN @Importe<0 THEN @CfgMovCxpCancelacionNomina ELSE @CfgMovCxpNomina END ELSE
        IF @CxModulo = 'CXC' SELECT @CxMov = CASE WHEN @Importe<0 THEN @CfgMovCxcCancelacionNomina ELSE @CfgMovCxcNomina END 
        IF @Importe<0 SELECT @Importe = -@Importe, @Impuestos = -@Impuestos, @ComisionTotal = -@ComisionTotal
      END ELSE
      IF @Modulo = 'VALE'
      BEGIN
	SELECT @CxMovID = NULL         
        IF @MovTipo IN ('VALE.V', 'VALE.EV') SELECT @CxMov = @CfgMovCxcVentaVales ELSE
        IF @MovTipo = 'VALE.O' SELECT @CxMov = @CfgMovCxcObsequioVales ELSE
        IF @MovTipo = 'VALE.A' SELECT @CxMov = @CfgMovCxcAplicacionVales ELSE
        --IF @MovTipo = 'VALE.AT' SELECT @CxMov = @CfgMovCxcAplicacionTarjetas ELSE -- ETO Tarjetas 9-Feb-2007 Aplicacion Tarjetas
        IF @MovTipo = 'VALE.D' SELECT @CxMov = @CfgMovCxcDevolucionVales
      END ELSE
      IF @Modulo = 'CAM'
      BEGIN
        IF UPPER(@Tipo) IN ('COBRO','VENTA') SELECT @CxMov = 'Venta' ELSE
        IF UPPER(@Tipo) IN ('COMPRA','PAGO') SELECT @CxMov = 'Compra'  
      END ELSE 
      IF @Modulo = 'CAP'
      BEGIN
        SELECT @CxMov = @Mov, @CxMovID = NULL--@MovID
        IF @MovTipo IN ('CAP.AC', 'CAP.CAP') SELECT @CxModulo = 'CXC' ELSE
        IF @MovTipo IN ('CAP.DC', 'CAP.DIV') SELECT @CxModulo = 'CXP' 
      END ELSE 
      IF @Modulo = 'EMB'
      BEGIN 
        IF UPPER(@Tipo) IN ('COBRADO', 'COBRO PARCIAL')
        BEGIN 
          SELECT @CxMov = @CfgMovCobro 
          IF @CfgEmbarqueCobrarDemas = 1 SELECT @AplicarDemas = 1
        END ELSE
        IF UPPER(@Tipo) = 'PAGADO'  SELECT @CxMov = @CfgMovPago  ELSE
        IF UPPER(@Tipo) = 'CXP'
        BEGIN
          SELECT @CxMov = @CfgMovEmbarqueCxp
          IF @CxMov = @CfgMovGastoDiverso SELECT @CxMovID = NULL
        END
      END ELSE
      BEGIN
        IF @MovTipo IN ('COMS.EG', 'COMS.EI', 'INV.EI') AND @Tipo = 'DESGLOSE' SELECT @CxMov = @CfgMovGastoDiverso, @CxMovID = NULL ELSE
        IF @MovTipo IN ('COMS.EG', 'COMS.EI') AND @Tipo = 'CXC' SELECT @CxModulo = 'CXC', @CxMov = @CfgMovGastoDiverso ELSE
        IF @MovTipo IN ('VTAS.FM', 'VTAS.N', 'VTAS.NO', 'VTAS.NR','VTAS.F','VTAS.FX','VTAS.FAR', 'VTAS.FB', 'COMS.F', 'COMS.FL', 'COMS.CA', 'COMS.GX', 'COMS.EG', 'INV.EI', 'GAS.G', 'GAS.GP', 'GAS.ASC') SELECT @CxMov = @Mov ELSE
        IF @MovTipo = 'GAS.GTC' SELECT @CxMov = @Mov, @CxMovID = RTRIM(@MovID) + '-' + CONVERT(varchar, @Conteo) ELSE
        IF @MovTipo = 'COMS.EI' SELECT @CxMov = @CfgMovCxpImportacion, @CxMovID = NULL ELSE
        IF @MovTipo = 'GAS.DG' SELECT @CxMov = @CfgMovCxpGastoDev, @CxMovID = NULL ELSE
        IF @MovTipo = 'GAS.DGP' SELECT @CxMov = @CfgMovCxpGastoDevProrrateada, @CxMovID = NULL ELSE
        IF @MovTipo IN ('VTAS.D','VTAS.DF','VTAS.B','COMS.D','COMS.B') SELECT @CxMov = ConsecutivoMov FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov AND Clave = @MovTipo ELSE
        IF @MovTipo IN ('PROD.A', 'PROD.E') SELECT @CxMov = @CfgMovAvanceCxp, @CxMovID = NULL ELSE
        IF @MovTipo IN ('PROD.R') SELECT @CxMov = @CfgMovRetrocesoCxp, @CxMovID = NULL ELSE
        IF @MovTipo = 'DIN.F'   SELECT @CxMov = @CfgMovFaltanteCaja ELSE
        IF @MovTipo = 'DIN.ACXC' SELECT @CxModulo = @ModuloAfectar, @CxMov = @CfgMovCxcAnticipo ELSE
        IF @MovTipo = 'DIN.ACXP' SELECT @CxModulo = @ModuloAfectar, @CxMov = @CfgMovCxpAnticipo ELSE
        IF @MovTipo IN ('DIN.SD', 'DIN.SCH') SELECT @CxModulo = @ModuloAfectar, @CxMov = @Mov, @CxMovID = @MovID ELSE
        IF @SubClave = 'VTAS.FA' SELECT @CxMov = @Mov 
        ELSE SELECT @Ok = 70021
      END
      IF EXISTS(SELECT * FROM EmpresaCfgMovGenera WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov AND GeneraModulo = @CxModulo)
      BEGIN
        SELECT @CxMov = GeneraMov, @ArrastrarMovID = ArrastrarMovID FROM EmpresaCfgMovGenera WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov AND GeneraModulo = @CxModulo
        IF @ArrastrarMovID = 1 SELECT @CxMovID = @MovID
      END
    END
  END

  EXEC xpGenerarAfectarCxMov @Accion, @ModuloAfectar, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Referencia, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  IF @CxMov IS NULL SELECT @Ok = 70020
  IF @Ok IS NULL
    IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = @CxModulo AND Mov = @CxMov) 
      SELECT @Ok = 70025, @OkRef = RTRIM(@CxMov) + ' ('+RTRIM(@CxModulo)+')'

  IF @Ok IS NOT NULL RETURN 0

  IF (@MovTipoCambio <> 1.0) AND ((@CxModulo = 'CXC' AND @CxcMonedaCont = 1) OR (@CxModulo = 'CXP' AND @CxpMonedaCont = 1) OR (@CxModulo = 'AGENT' AND @AgentMonedaCont = 1))
  BEGIN
    SELECT @Importe = @Importe * @MovTipoCambio,
           @Impuestos = @Impuestos * @MovTipoCambio,
           @Retencion = @Retencion * @MovTipoCambio, 
           @Retencion2 = @Retencion2 * @MovTipoCambio, 
           @Retencion3 = @Retencion3 * @MovTipoCambio, 
	   @Saldo = @Saldo * @MovTipoCambio,
	   @ComisionTotal = @ComisionTotal * @MovTipoCambio,
	   @ImporteAplicar = @ImporteAplicar * @MovTipoCambio
    SELECT @MovTipoCambio = 1.0
    SELECT @MovMoneda = ContMoneda
      FROM EmpresaCfg
     WHERE Empresa = @Empresa
  END

  SELECT @CxMovTipo = Clave FROM MovTipo WHERE Modulo = @CxModulo AND Mov = @CxMov
  IF @CxMovTipo IN ('CXC.DA','CXC.NC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP','CXC.DC', 'CXP.A','CXP.NC','CXP.NCD','CXP.NCP','CXP.NCF','CXP.DC')
    SELECT @CxEsCredito = 1

  IF @EndosarA IS NOT NULL
  BEGIN
    IF @CxEsCredito = 1
    BEGIN
      SELECT @CxEndosoMov = CASE @CxModulo WHEN 'CXC' THEN @CfgMovCxcEndosoAFavor WHEN 'CXP' THEN @CfgMovCxpEndosoAFavor END
    END ELSE
    BEGIN
      SELECT @CxEndosoMov = CASE @CxModulo WHEN 'CXC' THEN @CfgMovCxcEndoso WHEN 'CXP' THEN @CfgMovCxpEndoso END
    END
  END

  IF @Condicion IS NOT NULL AND @CxModulo IN ('CXC', 'CXP')
  BEGIN
    IF EXISTS(SELECT * FROM Condicion WHERE Condicion = @Condicion AND Neteo = 1)
      IF NOT EXISTS(SELECT * FROM Cte WHERE Cliente = @Contacto AND EsProveedor = 1) 
        SELECT @Ok = 10280
      ELSE BEGIN
        SELECT @AutoAplicar = 0
        IF @CxModulo = 'CXC' SELECT @CxModulo = 'CXP' ELSE
        IF @CxModulo = 'CXP' SELECT @CxModulo = 'CXC'
        SELECT @CxMov = CASE @CxModulo WHEN 'CXC' THEN @CfgMovCxcAjusteSaldo ELSE @CfgMovCxpAjusteSaldo END
        SELECT @Importe = @Importe + @Impuestos - @Retencion
        SELECT @Impuestos = 0.0, @Retencion = 0.0
        IF @CxEsCredito = 0 SELECT @Importe = -@Importe 
      END
  END

  IF @Accion NOT IN ('CANCELAR', 'GENERAR') SELECT @Accion = 'AFECTAR'
  IF @Accion <> 'CANCELAR'
  BEGIN
    IF @AC = 1
    BEGIN
      IF @CxModulo = 'CXC' AND @Modulo = 'VTAS' SELECT @LineaCredito = LineaCredito, @TipoAmortizacion = TipoAmortizacion, @TipoTasa = TipoTasa, @TieneTasaEsp = TieneTasaEsp, @TasaEsp = TasaEsp, @Comisiones = Comisiones, @ComisionesIVA = ComisionesIVA FROM Venta  WHERE ID = @ID
      IF @CxModulo = 'CXP' AND @Modulo = 'COMS' SELECT @LineaCredito = LineaCredito, @TipoAmortizacion = TipoAmortizacion, @TipoTasa = TipoTasa, @TieneTasaEsp = TieneTasaEsp, @TasaEsp = TasaEsp, @Comisiones = Comisiones, @ComisionesIVA = ComisionesIVA FROM Compra WHERE ID = @ID
    END

    IF @Aplica IS NOT NULL AND @AplicaMovID IS NOT NULL SELECT @AplicaManual = 1 ELSE SELECT @AplicaManual = 0

    SELECT @IDOrigen = dbo.fnModuloID(@Empresa, @OrigenTipo, @Origen, @OrigenID, @Ejercicio, @Periodo)
    /*SELECT @OrigenEstatus = Estatus, @OrigenSucursal = Sucursal, @OrigenUEN = UEN
      FROM dbo.fnMovReg(@OrigenTipo, @IDOrigen)*/
    EXEC spMovInfo @IDOrigen, @OrigenTipo, @Origen, @OrigenID, @OrigenEstatus OUTPUT, @OrigenSucursal OUTPUT, @OrigenUEN OUTPUT

    IF @AutoAplicar = 1 AND @CxModulo IN ('CXC', 'CXP') AND ISNULL(@NoAutoAplicar, 0) = 0 -- BUG10848
    BEGIN
      EXEC xpAutoAplicarCx @Modulo, @ID, @AutoAplicar OUTPUT
      IF @AutoAplicar = 1
      BEGIN
        SELECT @Aplica = NULL, @AplicaMovID = NULL, @AplicaSaldoMN = NULL, @SaldoMN = @Saldo * @MovTipoCambio
        IF @CxModulo = 'CXC' SELECT @Aplica = Mov, @AplicaMovID = MovID, @AplicaSaldoMN = Saldo*TipoCambio FROM Cxc WHERE Empresa = @Empresa AND Cliente   = @Contacto AND Estatus = 'PENDIENTE' AND @ReferenciaOriginal = RTRIM(Mov)+' '+RTRIM(MovID) ELSE
        IF @CxModulo = 'CXP' SELECT @Aplica = Mov, @AplicaMovID = MovID, @AplicaSaldoMN = Saldo*TipoCambio FROM Cxp WHERE Empresa = @Empresa AND Proveedor = @Contacto AND Estatus = 'PENDIENTE' AND @ReferenciaOriginal = RTRIM(Mov)+' '+RTRIM(MovID) 
        IF ISNULL(@AplicaSaldoMN, 0.0) > 0.0
        BEGIN
          SELECT @AplicaManual = 1
          IF @AplicaSaldoMN > @SaldoMN SELECT @ImporteAplicar = @Saldo ELSE SELECT @ImporteAplicar = @AplicaSaldoMN / @MovTipoCambio
        END
      END
    END

    SELECT @CxEstatus = 'SINAFECTAR'
    IF @CxModulo IN ('CXC', 'CXP') AND @Modulo IN ('VTAS','COMS','GAS','PROD')
    BEGIN
      SELECT @CfgGenerarEnBorrador = CASE WHEN @CxModulo = 'CXC' THEN CxcGenerarEnBorrador ELSE CxpGenerarEnBorrador END 
        FROM EmpresaCfg2
       WHERE Empresa = @Empresa
      IF @CfgGenerarEnBorrador = 1 
        SELECT @CxEstatus = 'BORRADOR'
      EXEC xpCxGenerarEnBorrador @Modulo, @ID, @CxEstatus OUTPUT
    END

    IF @Modulo = 'VTAS' SELECT @ContratoID = ContratoID, @ContratoMov = ContratoMov, @ContratoMovID = ContratoMovID FROM Venta  WHERE ID = @ID ELSE
    IF @Modulo = 'COMS' SELECT @ContratoID = ContratoID, @ContratoMov = ContratoMov, @ContratoMovID = ContratoMovID FROM Compra WHERE ID = @ID ELSE     
    IF @Modulo = 'GAS'  SELECT @ContratoID = ContratoID, @ContratoMov = ContratoMov, @ContratoMovID = ContratoMovID FROM Gasto  WHERE ID = @ID        
        	    
    IF @CxModulo = 'CXC'
    BEGIN
      IF EXISTS(SELECT * FROM Cte WHERE Cliente = @Contacto)
      BEGIN     
        SELECT @CteMoneda = @MovMoneda, @CteTipoCambio = @MovTipoCambio
        SELECT @OrigenMovTipo = Clave FROM MovTipo WHERE Modulo = @OrigenTipo AND Mov = @Origen

        IF @OrigenTipo = 'VTAS' AND @OrigenMovTipo IN ('VTAS.B', 'VTAS.D') AND @AutoAplicar = 1 AND @CxMovTipo IN ('CXC.NC') BEGIN
          SELECT @MonedaOrigen = Moneda, @TipoCambioOrigen = TipoCambio FROM Venta WHERE Mov = @Aplica AND MovID = @AplicaMovID
          IF @MovMoneda <> @MonedaOrigen AND @MovTipoCambio <> @TipoCambioOrigen
            SELECT @CteMoneda = @MonedaOrigen, @CteTipoCambio = @TipoCambioOrigen
        END 

        IF @PersonalCobrador IS NULL
          SELECT @PersonalCobrador = PersonalCobrador FROM Cte WHERE Cliente = @Contacto

        INSERT INTO Cxc 
               (Sucursal, SucursalOrigen, SucursalDestino, Empresa, Mov, MovID, FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente, Observaciones, Estatus, UltimoCambio,
                Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio, Condicion, Vencimiento, CtaDinero, Importe, Impuestos, Retencion, Retencion2, Retencion3, Saldo, 
    	        FormaCobro, Agente, ComisionTotal, ComisionPendiente, AplicaManual,
                OrigenTipo, Origen, OrigenID, UEN, VIN, IVAFiscal, IEPSFiscal, PersonalCobrador, Nota, LineaCredito, TipoAmortizacion, TipoTasa, TieneTasaEsp, TasaEsp, Comisiones, ComisionesIVA, ContratoID, ContratoMov, ContratoMovID, NoAutoAplicar) -- BUG10848
        VALUES (@Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @CxMov, @CxMovID, @FechaEmision, @Concepto, @Proyecto, @MovMoneda, @MovTipoCambio, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @CxEstatus, @FechaRegistro,
                @Contacto, @EnviarA, ISNULL(@CteMoneda, @MovMoneda), ISNULL(@CteTipoCambio,@MovTipoCambio), @Condicion, @Vencimiento, @CtaDinero, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, @Saldo,
                @FormaPago, @Agente, @ComisionTotal, @ComisionPendiente, @AplicaManual,
                @OrigenTipo, @Origen, @OrigenID, @OrigenUEN, @VIN, @IVAFiscal, @IEPSFiscal, @PersonalCobrador, @Nota, @LineaCredito, @TipoAmortizacion, @TipoTasa, @TieneTasaEsp, @TasaEsp, @Comisiones, @ComisionesIVA, @ContratoID, @ContratoMov, @ContratoMovID, @NoAutoAplicar) -- BUG10848
        SELECT @CxID = SCOPE_IDENTITY()
        IF @AplicaManual = 1
          INSERT INTO CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica,  AplicaID,     Importe)
                    VALUES (@Sucursal, @CxID, 2048, 0,          @Aplica, @AplicaMovID, @ImporteAplicar)
        IF @AplicarDemas = 1 AND @ImporteAplicar <> @Importe+ISNULL(@Impuestos, 0.0)
           INSERT CxcAplicaDif (
                  ID,    Mov,             Importe,                                          Cliente,   ClienteEnviarA, Sucursal,  SucursalOrigen) 
           SELECT @CxID, 'Saldo a Favor', @Importe+ISNULL(@Impuestos, 0.0)-@ImporteAplicar, @Contacto, @EnviarA,       @Sucursal, @SucursalOrigen

      END ELSE SELECT @Ok = 26060, @OkRef = @Contacto
    END ELSE 
    IF @CxModulo = 'CXP' 
    BEGIN
      IF EXISTS(SELECT * FROM Prov WHERE Proveedor = @Contacto)
      BEGIN     
        INSERT INTO Cxp 
               (Sucursal, SucursalOrigen, SucursalDestino, Empresa, Mov, MovID, FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente, Observaciones, Estatus, UltimoCambio,
                Proveedor, ProveedorMoneda, ProveedorTipoCambio, Condicion, Vencimiento, CtaDinero, Importe, Impuestos, Retencion, Retencion2, Retencion3, Saldo, AplicaManual,
                FormaPago, Beneficiario, 
                OrigenTipo, Origen, OrigenID, UEN, VIN, IVAFiscal, IEPSFiscal, ProveedorAutoEndoso, Nota, LineaCredito, TipoAmortizacion, TipoTasa, TieneTasaEsp, TasaEsp, Comisiones, ComisionesIVA, RetencionAlPago, ContratoID, ContratoMov, ContratoMovID, NoAutoAplicar) -- BUG10848
        VALUES (@Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @CxMov, @CxMovID, @FechaEmision, @Concepto, @Proyecto, @MovMoneda, @MovTipoCambio, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @CxEstatus, @FechaRegistro,
                @Contacto, @MovMoneda, @MovTipoCambio, @Condicion, @Vencimiento, @CtaDinero, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, @Saldo, @AplicaManual,
                @FormaPago, @Beneficiario, 
                @OrigenTipo, @Origen, @OrigenID, @OrigenUEN, @VIN, @IVAFiscal, @IEPSFiscal, @ProveedorAutoEndoso, @Nota, @LineaCredito, @TipoAmortizacion, @TipoTasa, @TieneTasaEsp, @TasaEsp, @Comisiones, @ComisionesIVA, @RetencionAlPago, @ContratoID, @ContratoMov, @ContratoMovID, @NoAutoAplicar) -- BUG10848
        SELECT @CxID = SCOPE_IDENTITY()
        IF @AplicaManual = 1
          INSERT INTO CxpD (Sucursal, ID, Renglon, RenglonSub, Aplica,  AplicaID,     Importe)
                    VALUES (@Sucursal, @CxID, 2048, 0,          @Aplica, @AplicaMovID, @ImporteAplicar)
      END ELSE SELECT @Ok = 26050, @OkRef = @Contacto
    END ELSE 
    IF @CxModulo = 'AGENT' 
    BEGIN
      IF EXISTS(SELECT * FROM Agente WHERE Agente = @Agente)
      BEGIN     
       IF NULLIF(RTRIM(@Observaciones), '') IS NOT NULL 
         SELECT @Observaciones = RTRIM(@Observaciones) + ' '
       IF @Contacto IS NOT NULL AND NULLIF(@Importe, 0) IS NOT NULL
         SELECT @Observaciones = RTRIM(@Observaciones) + '('+RTRIM(@Contacto)+', '+LTRIM(CONVERT(char, ROUND(@ComisionTotal/@Importe*100, 2)))+'%)'

        INSERT INTO Agent
               (Sucursal, SucursalDestino, Empresa, Mov, MovID, FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente, Estatus, UltimoCambio,
                Agente, Importe, Observaciones, 
                OrigenTipo, Origen, OrigenID, UEN)
        VALUES (@Sucursal, @SucursalDestino, @Empresa, @CxMov, @CxMovID, @FechaEmision, @Concepto, @Proyecto, @MovMoneda, @MovTipoCambio, @Usuario, @Autorizacion, @Referencia, @DocFuente, 'SINAFECTAR', @FechaRegistro,
                @Agente, @ComisionTotal, @Observaciones, 
                @OrigenTipo, @Origen, @OrigenID, @OrigenUEN)
        SELECT @CxID = SCOPE_IDENTITY()
      END ELSE SELECT @Ok = 26090, @OkRef = @Agente
    END

    -- Copiar Anexos
    EXEC spMovCopiarAnexos @Sucursal, @Modulo, @ID, @CxModulo, @CxID

    IF @Modulo = 'EMB' AND @CxModulo = 'CXC' AND (SELECT EmbarqueSugerirCobros FROM EmpresaCfg WHERE Empresa = @Empresa) = 1
      EXEC spSugerirCobro 'Importe Especifico', @CxModulo, @CxID, @ImporteAplicar 

    -- Copiar MovImpuesto
    IF @CopiarMovImpuesto = 1
    BEGIN
      INSERT MovImpuesto (
             Modulo,    ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,	      OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1, Importe2, Importe3, SubTotal, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
      SELECT @CxModulo, @CxID,    OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1, Importe2, Importe3, SubTotal, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
        FROM MovImpuesto
       WHERE Modulo = @Modulo AND ModuloID = @ID

      INSERT MovPresupuesto (
             Modulo,    ModuloID, CuentaPresupuesto, Importe)
      SELECT @CxModulo, @CxID,    CuentaPresupuesto, Importe
        FROM MovPresupuesto
       WHERE Modulo = @Modulo AND ModuloID = @ID      
    END
  END ELSE
  BEGIN
    SELECT @CxID = NULL
    IF @INSTRUCCIONES_ESP = 'SIN_ORIGEN' 
    BEGIN
      /*	
      IF @CxModulo = 'CXC'   SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID FROM MovFlujo f, Cxc e   WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NULL ELSE
      IF @CxModulo = 'CXP'   SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID FROM MovFlujo f, Cxp e   WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NULL ELSE
      IF @CxModulo = 'AGENT' SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID FROM MovFlujo f, Agent e WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NULL 
      */
      IF @CxModulo = 'CXC'   SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID, @CxEstatus = e.Estatus FROM MovFlujo f, Cxc e   WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NULL ELSE
      IF @CxModulo = 'CXP'   SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID, @CxEstatus = e.Estatus  FROM MovFlujo f, Cxp e   WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NULL ELSE
      IF @CxModulo = 'AGENT' SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID FROM MovFlujo f, Agent e WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NULL 
      
    END ELSE BEGIN
      /*	
      IF @CxModulo = 'CXC'   SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID FROM MovFlujo f, Cxc e   WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NOT NULL ELSE
      IF @CxModulo = 'CXP'   SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID FROM MovFlujo f, Cxp e   WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NOT NULL ELSE
      IF @CxModulo = 'AGENT' SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID FROM MovFlujo f, Agent e WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NOT NULL 
      */
      IF @CxModulo = 'CXC'   SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID, @CxEstatus = e.Estatus  FROM MovFlujo f, Cxc e   WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NOT NULL ELSE
      IF @CxModulo = 'CXP'   SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID, @CxEstatus = e.Estatus  FROM MovFlujo f, Cxp e   WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NOT NULL ELSE
      IF @CxModulo = 'AGENT' SELECT @CxID = f.DID, @CxMov = f.DMov, @CxMovID = f.DMovID FROM MovFlujo f, Agent e WHERE f.Cancelado = 0 AND f.Empresa = @Empresa AND f.OModulo = @Modulo AND f.OID = @ID AND f.DModulo = @CxModulo AND f.DID = e.ID AND e.OrigenTipo IS NOT NULL 
      	

--      IF @CxID IS NULL 
--        SELECT @Ok = 60060, @OkRef = 'Origen: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID))+ ' - Destino: '+RTRIM(@CxMov)+' '+LTRIM(Convert(Char, @CxMovID))
      IF @@ROWCOUNT <> 0
        IF @CxID IS NULL 
          SELECT @Ok = 60060, @OkRef = 'Origen: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID))+ ' - Destino: '+RTRIM(@CxMov)+' '+LTRIM(Convert(Char, @CxMovID))

      IF @CxModulo = 'CXC' AND @Modulo ='EMB' AND @Accion = 'CANCELAR'
      BEGIN
        DECLARE @tempIDCobroEmbarque int
        SELECT @tempIDCobroEmbarque = NULL
        SELECT @tempIDCobroEmbarque = ID FROM CXC WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Origen = @Mov AND OrigenID = @MovID AND OrigenTipo = 'EMB' AND Estatus = 'SINAFECTAR'
        IF @tempIDCobroEmbarque IS NOT NULL
        BEGIN
          DELETE Cxc  WHERE ID = @tempIDCobroEmbarque
          DELETE CxcD WHERE ID = @tempIDCobroEmbarque
        END
      END
    END
  END

  IF @LineaCreditoExpress = 1
  BEGIN
    EXEC spLCExpress @CxModulo, @CxID, @LineaCredito OUTPUT
    IF @CxModulo = 'CXC' UPDATE Cxc SET LineaCredito = @LineaCredito WHERE ID = @CxID ELSE
    IF @CxModulo = 'CXP' UPDATE Cxp SET LineaCredito = @LineaCredito WHERE ID = @CxID
  END

  IF @CxModulo = 'AGENT' AND @Accion = 'CANCELAR'
  BEGIN
    EXEC spCx @CxID, @CxModulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
              @CxMov OUTPUT, @CxMovID OUTPUT, @IDGenerar,  @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END 
  
  IF @Ok IS NULL AND @CxID IS NOT NULL
    EXEC xpGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @ModuloAfectar, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Concepto, @Proyecto,
                     @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @FechaRegistro, @Ejercicio, @Periodo,
                     @Condicion, @Vencimiento, @Contacto, @EnviarA, @Agente, @Tipo, @CtaDinero, @FormaPago, 
                     @Importe, @Impuestos, @Retencion, @ComisionTotal,
                     @Beneficiario, @Aplica, @AplicaMovID, @ImporteAplicar, @VIN, @MovEspecifico, @CxModulo, @CxMov, @CxMovID,
                     @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP, @IVAFiscal, @IEPSFiscal, @CxID, @ContUso

  /*
  IF @Accion IN ('AFECTAR', 'CANCELAR') AND @Ok IS NULL AND @CxID IS NOT NULL AND @CxEstatus = 'SINAFECTAR'
  BEGIN
    IF @Accion = 'CANCELAR' AND @EndosarA IS NOT NULL AND @CxModulo IN ('CXC', 'CXP')
    BEGIN
      SELECT @CxEndosoID = NULL
      IF @CxModulo = 'CXC' SELECT @CxEndosoID = ID, @CxEndosoMov = Mov, @CxEndosoMovID = MovID FROM Cxc WHERE Empresa = @Empresa AND Mov = @CxEndosoMov AND Cliente   = @EndosarA AND OrigenTipo = @CxModulo AND Origen = @CxMov AND OrigenID = @CxMovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
      IF @CxModulo = 'CXP' SELECT @CxEndosoID = ID, @CxEndosoMov = Mov, @CxEndosoMovID = MovID FROM Cxp WHERE Empresa = @Empresa AND Mov = @CxEndosoMov AND Proveedor = @EndosarA AND OrigenTipo = @CxModulo AND Origen = @CxMov AND OrigenID = @CxMovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') 
      IF @CxEndosoID IS NOT NULL
        EXEC spCx @CxEndosoID, @CxModulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                  @CxEndosoMov OUTPUT, @CxEndosoMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    END
    IF @Ok IS NULL
      EXEC spCx @CxID, @CxModulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                @CxMov OUTPUT, @CxMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,
	        @INSTRUCCIONES_ESP	

    -- Registrar el Flujo
--    IF @INSTRUCCIONES_ESP <> 'SIN_ORIGEN'            -- CUIDADO no hay que poner esto, porque no se puede cancelar bien una factura con DocAuto y Bonificacion Auto !!
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT
  END
  */
  
  IF (@Accion IN ('AFECTAR','CANCELAR') AND @Ok IS NULL AND @CxID IS NOT NULL AND @CxEstatus = 'SINAFECTAR') 
    OR (@Accion IN ('CANCELAR') AND @Ok IS NULL AND @CxID IS NOT NULL AND @CxEstatus IN ('PENDIENTE', 'BORRADOR', 'CONCLUIDO'))
    OR (@Accion IN ('AFECTAR') AND @Ok IS NULL AND @CxID IS NOT NULL AND @CxEstatus IN ('BORRADOR'))
  BEGIN
    IF @Accion = 'CANCELAR' AND @EndosarA IS NOT NULL AND @CxModulo IN ('CXC', 'CXP')
    BEGIN
      SELECT @CxEndosoID = NULL
      IF @CxModulo = 'CXC' SELECT @CxEndosoID = ID, @CxEndosoMov = Mov, @CxEndosoMovID = MovID FROM Cxc WHERE Empresa = @Empresa AND Mov = @CxEndosoMov AND Cliente   = @EndosarA AND OrigenTipo = @CxModulo AND Origen = @CxMov AND OrigenID = @CxMovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
      IF @CxModulo = 'CXP' SELECT @CxEndosoID = ID, @CxEndosoMov = Mov, @CxEndosoMovID = MovID FROM Cxp WHERE Empresa = @Empresa AND Mov = @CxEndosoMov AND Proveedor = @EndosarA AND OrigenTipo = @CxModulo AND Origen = @CxMov AND OrigenID = @CxMovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') 
      IF @CxEndosoID IS NOT NULL
        EXEC spCx @CxEndosoID, @CxModulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                  @CxEndosoMov OUTPUT, @CxEndosoMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    END
    IF @Ok IS NULL 
    BEGIN   
      IF NOT (@CxEstatus IN ('BORRADOR') AND @Accion IN ('AFECTAR')) 
      BEGIN
        EXEC spCx @CxID, @CxModulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                  @CxMov OUTPUT, @CxMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,
	          @INSTRUCCIONES_ESP	               	
      END
    -- Registrar el Flujo
--    IF @INSTRUCCIONES_ESP <> 'SIN_ORIGEN'            -- CUIDADO no hay que poner esto, porque no se puede cancelar bien na factura con DocAuto y Bonificacion Auto !!
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT
    END  
  END
  
  IF @Endoso IS NOT NULL AND @CfgCompraAutoEndosoEmpresas = 1 AND @Accion IN ('AFECTAR', 'CANCELAR') AND @Ok IS NULL
  BEGIN
    IF @CfgCompraAutoEndosoAutoCargos = 1
      SELECT @ProveedorAutoEndoso = @Contacto, @Contacto = @Endoso

    IF @CfgCompraAutoEndosoWS = 1
    BEGIN
      INSERT WSEnviar (WSDL, Estatus, EstatusFecha) VALUES (@CfgCompraAutoEndosoWSDL, 'SINAFECTAR', GETDATE())
      SELECT @EndosoID = SCOPE_IDENTITY()

      INSERT WSEnviarD (ID, Datos) 
      SELECT @EndosoID, '<?xml version="1.0" encoding="UTF-8" ?>'

      INSERT WSEnviarD (ID, Datos) 
      SELECT @EndosoID, '<Intelisis>'

      INSERT WSEnviarD (ID, Datos) 
      SELECT @EndosoID, '<Movimiento'+
              dbo.fnXML('Version', '1.0')+
              dbo.fnXML('Accion', @Accion)+
              dbo.fnXML('Tipo', 'CompraAutoEndoso')+
              dbo.fnXML('Empresa', @Empresa)+
              dbo.fnXML('Endoso', @Endoso)+
              dbo.fnXMLInt('Sucursal', @Sucursal)+
              dbo.fnXML('Usuario', @Usuario)+
              dbo.fnXML('Modulo', @CxModulo)+
              dbo.fnXMLInt('ID', @CxID)+
              dbo.fnXML('Mov', @CxMov)+
              dbo.fnXML('MovID', @CxMovID)+
              dbo.fnXML('MovTipo', @CxMovTipo)+
  	      dbo.fnXMLDateTime('FechaEmision',  @FechaEmision)+
              dbo.fnXML('Condicion', @Condicion)+
  	      dbo.fnXMLDateTime('Vencimiento',  @Vencimiento)+
              dbo.fnXML('Concepto', @Concepto)+
              dbo.fnXML('Proyecto', @Proyecto)+
              dbo.fnXML('Referencia', @Referencia)+
              dbo.fnXML('Observaciones', @Observaciones)+
              dbo.fnXML('Proveedor', @ContactoOriginal)+
              dbo.fnXML('Moneda', @MovMoneda)+
              dbo.fnXMLFloat('TipoCambio', @MovTipoCambio)+
  	      dbo.fnXMLMoney('Importe',  @Importe)+
  	      dbo.fnXMLMoney('Impuestos',  @Impuestos)+
  	      dbo.fnXMLMoney('Retencion',  @Retencion)+
  	      dbo.fnXMLMoney('Retencion2', @Retencion2)+
  	      dbo.fnXMLMoney('Retencion3', @Retencion3)+
              dbo.fnXMLFloat('IVAFiscal', @IVAFiscal)+
              dbo.fnXMLFloat('IEPSFiscal', @IEPSFiscal)+
             '>'

      INSERT WSEnviarD (ID, Datos) 
      SELECT @EndosoID, '<Proveedor'+
             dbo.fnXML('Nombre', Nombre)+
             dbo.fnXML('NombreCorto', NombreCorto)+
             dbo.fnXML('Direccion', Direccion)+
             dbo.fnXML('EntreCalles', EntreCalles)+
             dbo.fnXML('Plano', Plano)+
             dbo.fnXML('Observaciones', Observaciones)+
             dbo.fnXML('Delegacion', Delegacion)+
             dbo.fnXML('Colonia', Colonia)+
             dbo.fnXML('Poblacion', Poblacion)+
             dbo.fnXML('Estado', Estado)+
             dbo.fnXML('Zona', Zona)+
             dbo.fnXML('Pais', Pais)+
             dbo.fnXML('CodigoPostal', CodigoPostal)+
             dbo.fnXML('Telefonos', Telefonos)+
             dbo.fnXML('Fax', Fax)+
             dbo.fnXML('Contacto1', Contacto1)+
             dbo.fnXML('Contacto2', Contacto2)+
             dbo.fnXML('Extencion1', Extencion1)+
             dbo.fnXML('Extencion2', Extencion2)+
             dbo.fnXML('eMail1', eMail1)+
             dbo.fnXML('eMail2', eMail2)+
             dbo.fnXML('RFC', RFC)+
             dbo.fnXML('CURP', CURP)+
             dbo.fnXML('BeneficiarioNombre', BeneficiarioNombre)+
             dbo.fnXML('LeyendaCheque', LeyendaCheque)+
             '/>'
       FROM Prov
      WHERE Proveedor = @ContactoOriginal

      INSERT WSEnviarD (ID, Datos) 
      SELECT @EndosoID, '</Movimiento>'
      INSERT WSEnviarD (ID, Datos) 
      SELECT @EndosoID, '</Intelisis>'

      UPDATE WSEnviar SET Estatus = 'PENDIENTE', EstatusFecha = GETDATE() WHERE ID = @EndosoID
    END ELSE
    BEGIN
      SELECT @EndosoID = NULL
      IF @Accion = 'CANCELAR'
        SELECT @EndosoID = ID FROM Cxp WHERE Empresa = @Endoso AND Mov = @CxMov AND MovID = @CxMovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
      ELSE BEGIN
        INSERT INTO Cxp 
               (Sucursal, SucursalOrigen, SucursalDestino, Empresa, Mov, MovID, FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente, Observaciones, Estatus, UltimoCambio,
                Proveedor, ProveedorMoneda, ProveedorTipoCambio, Condicion, Vencimiento, CtaDinero, Importe, Impuestos, Retencion, Retencion2, Retencion3, 
                FormaPago, Beneficiario, 
                OrigenTipo, Origen, OrigenID, UEN, VIN, IVAFiscal, IEPSFiscal, Nota, AplicaManual)
        VALUES (@Sucursal, @SucursalOrigen, @SucursalDestino, @Endoso, @CxMov, @CxMovID, @FechaEmision, @Concepto, @Proyecto, @MovMoneda, @MovTipoCambio, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 'SINAFECTAR', @FechaRegistro,
                @ContactoOriginal, @MovMoneda, @MovTipoCambio, @Condicion, @Vencimiento, @CtaDinero, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, 
                @FormaPago, @Beneficiario, 
                'ENDOSO', @Origen, @OrigenID, @OrigenUEN, @VIN, @IVAFiscal, @IEPSFiscal, @Nota, @AplicaManual)
        SELECT @EndosoID = SCOPE_IDENTITY()
        IF @AplicaManual = 1
          INSERT INTO CxpD 
                 (Sucursal , ID,        Renglon, RenglonSub, Aplica,  AplicaID,     Importe)
          VALUES (@Sucursal, @EndosoID, 2048.0,  0,	     @Aplica, @AplicaMovID, @ImporteAplicar)
      END
      IF @EndosoID IS NOT NULL
      BEGIN
        EXEC xpEndosoGenerado @Sucursal, @ID, @CxID, @EndosoID, 'CXP', @CxMovTipo, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spCx @EndosoID, 'CXP', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                  @CxMov OUTPUT, @CxMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      END

      IF @Ok IS NULL
      BEGIN
        SELECT @EndosoID = NULL
        IF @Accion = 'CANCELAR'
          SELECT @EndosoID = ID FROM Cxc WHERE Empresa = @Endoso AND Mov = @CxMov AND MovID = @CxMovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
        ELSE BEGIN
          INSERT INTO Cxc 
                 (Sucursal, SucursalOrigen, SucursalDestino, Empresa, Mov, MovID, FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente, Observaciones, Estatus, UltimoCambio,
                  Cliente, ClienteEnviarA, ClienteMoneda, ClienteTipoCambio, Condicion, Vencimiento, CtaDinero, Importe, Impuestos, Retencion, Retencion2, Retencion3, --MEJORA4648
    	          FormaCobro, Agente, ComisionTotal, ComisionPendiente, 
                  OrigenTipo, Origen, OrigenID, UEN, VIN, IVAFiscal, IEPSFiscal, PersonalCobrador, Nota, LineaCredito, TipoAmortizacion, TipoTasa, TieneTasaEsp, TasaEsp, Comisiones, ComisionesIVA, AplicaManual)
          VALUES (@Sucursal, @SucursalOrigen, @SucursalDestino, @Endoso, @CxMov, @CxMovID, @FechaEmision, @Concepto, @Proyecto, @MovMoneda, @MovTipoCambio, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 'SINAFECTAR', @FechaRegistro,
                  @Empresa, NULL, @MovMoneda, @MovTipoCambio, @Condicion, @Vencimiento, @CtaDinero, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3,  --MEJORA4648
                  @FormaPago, @Agente, @ComisionTotal, @ComisionPendiente, 
                  'ENDOSO', @Origen, @OrigenID, @OrigenUEN, @VIN, @IVAFiscal, @IEPSFiscal, @PersonalCobrador, @Nota, @LineaCredito, @TipoAmortizacion, @TipoTasa, @TieneTasaEsp, @TasaEsp, @Comisiones, @ComisionesIVA, @AplicaManual)
          SELECT @EndosoID = SCOPE_IDENTITY()

          IF @AplicaManual = 1
            INSERT INTO CxcD 
                   (Sucursal , ID,        Renglon, RenglonSub,  Aplica,  AplicaID,     Importe)
            VALUES (@Sucursal, @EndosoID, 2048.0,  0,		@Aplica, @AplicaMovID, @ImporteAplicar)

        END
        IF @EndosoID IS NOT NULL
        BEGIN
          EXEC xpEndosoGenerado @Sucursal, @ID, @CxID, @EndosoID, 'CXC', @CxMovTipo, @Ok OUTPUT, @OkRef OUTPUT
          EXEC spCx @EndosoID, 'CXC', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                    @CxMov OUTPUT, @CxMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        END
      END
    END
  END  

  IF @Accion <> 'CANCELAR' AND @EndosarA IS NOT NULL AND @CxModulo IN ('CXC', 'CXP')
  BEGIN
    EXEC spCx @CxID, @CxModulo, 'GENERAR', 'TODO', @FechaRegistro, @CxEndosoMov, @Usuario, 1, 0, @CxEndosoMov OUTPUT, @CxEndosoMovID OUTPUT, @CxEndosoID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
    IF @Ok IS NULL
    BEGIN
      IF @CxModulo = 'CXC' UPDATE Cxc SET FechaEmision = @FechaEmision, Cliente   = @EndosarA, ClienteEnviarA = NULL WHERE ID = @CxEndosoID ELSE
      IF @CxModulo = 'CXP' UPDATE Cxp SET FechaEmision = @FechaEmision, Proveedor = @EndosarA WHERE ID = @CxEndosoID 
      EXEC spCx @CxEndosoID, @CxModulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @CxEndosoMov OUTPUT, @CxEndosoMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
    END
  END

  RETURN @CxID
END
GO

/**************** spGenerarCx ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCx') and type = 'P') drop procedure dbo.spGenerarCx
GO
CREATE PROCEDURE spGenerarCx
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

    		   @CxModulo			char(5)		OUTPUT,
    		   @CxMov			char(20)	OUTPUT,
    		   @CxMovID			varchar(20)	OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,
		   @INSTRUCCIONES_ESP		varchar(20) 	= NULL,
		   @IVAFiscal			float		= NULL,
		   @IEPSFiscal			float		= NULL,
		   @PersonalCobrador		char(10)	= NULL,
		   @Retencion2			money		= NULL,
		   @Retencion3			money		= NULL,
		   @ModuloEspecifico		char(5)		= NULL,
		   @EndosarA			varchar(10)	= NULL,
                   @Conteo			int		= NULL,
		   @Nota			varchar(100)	= NULL,
		   @MovIDEspecifico		varchar(20)     = NULL,
		   @ContUso			varchar(20)	= NULL,
		   @LineaCredito		varchar(20)	= NULL,
		   @LineaCreditoExpress		bit		= NULL,
	           @TipoAmortizacion		varchar(20)	= NULL,
                   @TipoTasa			varchar(20)	= NULL,
		   @TieneTasaEsp		bit		= NULL,
		   @TasaEsp			float		= NULL,
    		   @Comisiones			money		= NULL,
    		   @ComisionesIVA		money		= NULL,
		   @CopiarMovImpuesto		bit		= 0,
		   @NoAutoAplicar			bit		= 0		-- BUG10848
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CxID		int,
    @Equipo		bit

  SELECT @Equipo = 0
  IF @ModuloAfectar = 'AGENT' AND @Agente IS NOT NULL 
     SELECT @Equipo = Equipo FROM Agente WHERE Agente = @Agente

  IF @Equipo = 1
  BEGIN
    DECLARE crEquipo CURSOR FOR
     SELECT Agente, @ComisionTotal*(Porcentaje/100.0) FROM EquipoAgente WHERE Equipo = @Agente
    OPEN crEquipo
    FETCH NEXT FROM crEquipo INTO @Agente, @ComisionTotal
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        EXEC @CxID = spGenerarAfectarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @ModuloAfectar, @Empresa,
                                        @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision,
                                        @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                                        @FechaRegistro, @Ejercicio, @Periodo, @Condicion, @Vencimiento, @Contacto, @EnviarA,
                                        @Agente, @Tipo, @CtaDinero, @FormaPago, @Importe, @Impuestos, @Retencion, @ComisionTotal,
                                        @Beneficiario, @Aplica, @AplicaMovID, @ImporteAplicar, @VIN, @MovEspecifico,
                                        @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,
                                        @INSTRUCCIONES_ESP, @IVAFiscal, @IEPSFiscal, @PersonalCobrador, @Retencion2, @Retencion3, @ModuloEspecifico, @EndosarA, @Conteo, @Nota, @MovIDEspecifico, @ContUso,
                                        @LineaCredito, @LineaCreditoExpress, @TipoAmortizacion, @TipoTasa, @TieneTasaEsp, @TasaEsp, @Comisiones, @ComisionesIVA, @CopiarMovImpuesto,
                                        @NoAutoAplicar -- BUG10848
      FETCH NEXT FROM crEquipo INTO @Agente, @ComisionTotal
    END
    CLOSE crEquipo
    DEALLOCATE crEquipo
  END ELSE BEGIN  
    --- Bug 24103
    IF ISNULL(@CtaDinero, '') = ''
      SELECT @CtaDinero = CtaDinero FROM Prov WHERE Proveedor = @Contacto

    EXEC @CxID = spGenerarAfectarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @ModuloAfectar, @Empresa,
                                    @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision,
                                    @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                                    @FechaRegistro, @Ejercicio, @Periodo, @Condicion, @Vencimiento, @Contacto, @EnviarA,
                                    @Agente, @Tipo, @CtaDinero, @FormaPago, @Importe, @Impuestos, @Retencion, @ComisionTotal,
                                    @Beneficiario, @Aplica, @AplicaMovID, @ImporteAplicar, @VIN, @MovEspecifico,
                                    @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,
                                    @INSTRUCCIONES_ESP, @IVAFiscal, @IEPSFiscal, @PersonalCobrador, @Retencion2, @Retencion3, @ModuloEspecifico, @EndosarA, @Conteo, @Nota, @MovIDEspecifico, @ContUso,
									@LineaCredito, @LineaCreditoExpress, @TipoAmortizacion, @TipoTasa, @TieneTasaEsp, @TasaEsp, @Comisiones, @ComisionesIVA, @CopiarMovImpuesto,
                                    @NoAutoAplicar -- BUG10848
  END
  RETURN @CxID
END
GO

/**************** spGenerarCxImportacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCxImportacion') and type = 'P') drop procedure dbo.spGenerarCxImportacion
GO
CREATE PROCEDURE spGenerarCxImportacion
            @Sucursal                   int,
            @SucursalOrigen             int,
            @SucursalDestino            int,
            @Accion                     char(20),
            @ModuloAfectar              char(5),
            @Empresa                    char(5),
            @Modulo                     char(5),
            @ID                         int,
            @Mov                        char(20),
            @MovID                      varchar(20),
            @MovTipo                    char(20),
            @MovMoneda                  char(10),
            @MovTipoCambio              float,       
            @FechaEmision               datetime,
            @Concepto                   varchar(50),
            @Proyecto                   varchar(50),
            @Usuario                    char(10),
            @Autorizacion               char(10),
            @Referencia                 varchar(50),
            @DocFuente                  int,
            @Observaciones              varchar(255),
            @FechaRegistro              datetime,
            @Ejercicio                  int,
            @Periodo                    int,

            @Condicion                  varchar(50), 
            @Vencimiento                datetime,
            @Contacto                   char(10),
            @EnviarA                    int,
            @Agente                     char(10),
            @Tipo                       char(20),
            @CtaDinero                  char(10),
            @FormaPago                  varchar(50),

            @Importe                    money,
            @Impuestos                  money,
            @Retencion                  money,
            @ComisionTotal              money,

            @Beneficiario               int,
            @Aplica                     char(20),
            @AplicaMovID                varchar(20),
            @ImporteAplicar             money,
            @VIN                        varchar(20),
            @MovEspecifico              char(20),

            @CxModulo                   char(5)         OUTPUT,
            @CxMov                      char(20)        OUTPUT,
            @CxMovID                    varchar(20)     OUTPUT,

            @Ok                         int             OUTPUT,
            @OkRef                      varchar(255)    OUTPUT,
            @INSTRUCCIONES_ESP          varchar(20)     = NULL,
            @IVAFiscal                  float           = NULL,
            @IEPSFiscal                 float           = NULL,
            @Retencion2                 money           = NULL,
            @Retencion3                 money           = NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
            @ImportacionProveedor       char(10),
            @ImportacionReferencia      varchar(50),
            @ProvCondicion              varchar(50),
            @ProvVencimiento            datetime,
            @SumaImporte                money,
            @SumaImpuestos              money,

            @MonedaD                 varchar(10),
            @TipoCambioD             float
  
  IF @Modulo <> 'COMS' RETURN
  
  DECLARE crImportacion CURSOR FOR
   SELECT ImportacionProveedor, ImportacionReferencia, MonedaD, TipoCambioD, SUM(SubTotal), SUM(Impuestos)
     FROM CompraTCalc
    WHERE ID = @ID
    GROUP BY ImportacionProveedor, ImportacionReferencia, MonedaD, TipoCambioD
    ORDER BY ImportacionProveedor, ImportacionReferencia, MonedaD, TipoCambioD

  OPEN crImportacion
  FETCH NEXT FROM crImportacion INTO @ImportacionProveedor, @ImportacionReferencia, @MonedaD, @TipoCambioD, @SumaImporte, @SumaImpuestos
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN                         
    SELECT @ImportacionProveedor = NULLIF(RTRIM(@ImportacionProveedor), ''),
           @ImportacionReferencia = NULLIF(RTRIM(@ImportacionReferencia), ''),
           @ProvVencimiento = NULL
    SELECT @ProvCondicion = Condicion 
      FROM Prov
     WHERE Proveedor = @ImportacionProveedor

    SELECT @MonedaD = ISNULL(@MonedaD, @MovMoneda), @TipoCambioD = ISNULL(@TipoCambioD, @MovTipoCambio)

    EXEC xpGenerarCxImportacionCondicionVencimiento @Modulo, @ID, @Accion, @ImportacionProveedor, @ImportacionReferencia, @SumaImporte, @SumaImpuestos, @ProvCondicion OUTPUT, @ProvVencimiento OUTPUT

    IF @ImportacionProveedor IS NULL SELECT @Ok = 40020
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @ModuloAfectar, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MonedaD, @TipoCambioD, 
               	       @FechaEmision, @Concepto, @Proyecto, @Usuario, @Autorizacion, @ImportacionReferencia, @DocFuente, @Observaciones,
   		       @FechaRegistro, @Ejercicio, @Periodo,
		       @ProvCondicion, @ProvVencimiento, @ImportacionProveedor, NULL, @Agente, @Tipo, @CtaDinero, @FormaPago,
                       @SumaImporte, @SumaImpuestos, NULL, NULL, 
                       @Beneficiario, @Aplica, @AplicaMovID, @ImporteAplicar, @VIN, @MovEspecifico,
        	       @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                       @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP, @IVAFiscal, @IEPSFiscal, @Retencion2 = @Retencion2, @Retencion3 = @Retencion3
    FETCH NEXT FROM crImportacion INTO @ImportacionProveedor, @ImportacionReferencia, @MonedaD, @TipoCambioD, @SumaImporte, @SumaImpuestos
  END
  CLOSE crImportacion
  DEALLOCATE crImportacion
  RETURN 
END
GO

/**************** spAjusteRedondeo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAjusteRedondeo') and type = 'P') drop procedure dbo.spAjusteRedondeo
GO
CREATE PROCEDURE spAjusteRedondeo
		   @Sucursal	int,
                   @Empresa	char(5),
		   @Usuario	char(10),
    		   @Modulo	char(5)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CfgMovAjusteRedondeo	char(20),
    @Conteo					int,
    @ID						int,
    @FechaRegistro			datetime,
    @FechaEmision			datetime,
    @Rama					char(5),
    @Cuenta					char(20),
    @Saldo					money,
    @Moneda					char(10),
    @TipoCambio				float,
    @Mov					char(20),
    @MovID					varchar(20),
    @IDGenerar				int,
    @Ok						int,
    @OkRef					varchar(255),
    @OkDesc           		varchar(255),	
    @OkTipo           		varchar(50),	
    @RedondeoMonetarios		int,
    @SucursalMov			int

  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  SELECT @FechaRegistro = GETDATE() 
  SELECT @FechaEmision = @FechaRegistro, @Conteo = 0, @Ok = NULL, @OkRef = NULL

  IF @Modulo = 'CXC' SELECT @Rama = 'CRND' ELSE SELECT @Rama = 'PRND' 

  SELECT @CfgMovAjusteRedondeo = CASE @Modulo WHEN 'CXC' THEN NULLIF(RTRIM(CxcAjusteRedondeo), '') ELSE NULLIF(RTRIM(CxpAjusteRedondeo), '') END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

/*
JGD 10Febrero2011 Ticket 2682. Se descomenta el Filtro 'AND m.Moneda = s.Moneda' y se cambia el Ajuste del Redondeo
                               para que lo tome del Campo CxpAjusteRedondeo de la Tabla Moneda. De esta manera el Ajuste lo hará por Moneda
                               y no por Configuración de la Empresa, este cambio se realizó ya que no todas las Monedas manejan la misma
                               Tolerancia de Redondeo. Se realiza el cambio para Cxp y Cxc
*/
  IF @Modulo = 'CXC'
    DECLARE crAjusteRedondeo CURSOR FOR
     SELECT Sucursal, NULLIF(RTRIM(s.Cuenta), ''), s.Saldo, m.Moneda, m.TipoCambio
       FROM Saldo s
       JOIN EmpresaCfg ec ON s.Empresa = ec.Empresa      
       JOIN Mon m ON s.Moneda = m.Moneda
      WHERE s.Rama = @Rama
        AND s.Empresa = @Empresa      
        AND ISNULL(s.Saldo, 0) <> 0.0
        AND s.Saldo BETWEEN -m.CxcAjusteRedondeo AND m.CxcAjusteRedondeo        
  ELSE
    DECLARE crAjusteRedondeo CURSOR FOR
     SELECT Sucursal, NULLIF(RTRIM(s.Cuenta), ''), s.Saldo, m.Moneda, m.TipoCambio
       FROM Saldo s
       JOIN EmpresaCfg ec ON s.Empresa = ec.Empresa      
       JOIN Mon m ON s.Moneda = m.Moneda
      WHERE s.Rama = @Rama
        AND s.Empresa = @Empresa      
        AND ISNULL(s.Saldo, 0) <> 0.0
        AND s.Saldo BETWEEN -m.CxpAjusteRedondeo AND m.CxpAjusteRedondeo

  OPEN crAjusteRedondeo
  FETCH NEXT FROM crAjusteRedondeo INTO @SucursalMov, @Cuenta, @Saldo, @Moneda, @TipoCambio
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN                         
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      IF @Modulo = 'CXC'
        INSERT Cxc (Sucursal,      Empresa,  Mov,                   FechaEmision,  Moneda,  TipoCambio,  Usuario,   Estatus,     UltimoCambio,   Cliente, ClienteMoneda, ClienteTipoCambio, Importe)
            VALUES (@SucursalMov, @Empresa, @CfgMovAjusteRedondeo, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @FechaRegistro, @Cuenta, @Moneda,       @TipoCambio,       -@Saldo)
      ELSE
        INSERT Cxp (Sucursal,      Empresa,  Mov,                   FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      UltimoCambio,  Proveedor, ProveedorMoneda, ProveedorTipoCambio, Importe)
            VALUES (@SucursalMov, @Empresa, @CfgMovAjusteRedondeo, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @FechaRegistro, @Cuenta,  @Moneda,         @TipoCambio,         -@Saldo)

      SELECT @ID = SCOPE_IDENTITY()
      EXEC spCx @ID, @Modulo, 'AFECTAR', 'TODO', @FechaEmision, NULL, @Usuario, 0, 0, @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crAjusteRedondeo INTO @SucursalMov, @Cuenta, @Saldo, @Moneda, @TipoCambio
  END
  CLOSE crAjusteRedondeo
  DEALLOCATE crAjusteRedondeo

  IF @Ok IS NULL 
    SELECT @Ok = 80000, @OkRef = LTRIM(Convert(char, @conteo))+' Ajuste(s) generados.', @OkTipo = 'INFO', @OkDesc = 'Proceso Concluido'
  ELSE
    -- Leer el Mensaje
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok  
  
  -- Mostrar el Estatus de la Afectacion
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, NULL

  RETURN
END
GO

-- spEliminarSaldosMenores 0, 'DEMO', 'DEMO', 'CXC'
/**************** spEliminarSaldosMenores ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEliminarSaldosMenores') and type = 'P') drop procedure dbo.spEliminarSaldosMenores
GO
CREATE PROCEDURE spEliminarSaldosMenores
		   @Sucursal	int,
                   @Empresa	char(5),
		   @Usuario	char(10),
    		   @Modulo	char(5)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CfgMov			char(20),
    @Conteo			int,
    @ID				int,
    @Renglon			float,
    @FechaRegistro		datetime,
    @FechaEmision		datetime,
    @Contacto			char(10),
    @UltContacto		char(10),
    @Saldo			money,
    @SumaImporte		money,
    @Moneda			char(10),
    @UltMoneda			char(10),
    @TipoCambio			float,
    @Mov			char(20),
    @MovID			varchar(20),
    @MovGenerar			char(20),
    @MovIDGenerar		varchar(20),
    @MovTipo			varchar(20),
    @IDGenerar			int,
    @Ok				int,
    @OkRef			varchar(255),
    @OkDesc           		varchar(255),	
    @OkTipo           		varchar(50)

  SELECT @FechaRegistro = GETDATE() 
  SELECT @FechaEmision = @FechaRegistro, @ID = NULL, @Conteo = 0, @Ok = NULL, @OkRef = NULL, @UltContacto = NULL, @UltMoneda = NULL

  SELECT @CfgMov = CASE @Modulo WHEN 'CXC' THEN NULLIF(RTRIM(CxcAjuste), '') ELSE NULLIF(RTRIM(CxpAjuste), '') END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Modulo = 'CXC'
    DECLARE crEliminarSaldos CURSOR FOR
     SELECT mt.Clave, m.Moneda, m.TipoCambio, c.Cliente, c.Mov, c.MovID, ISNULL(c.Saldo, 0)
       FROM Cxc c, Mon m, MovTipo mt
      WHERE c.Empresa = @Empresa
        AND m.Moneda = c.Moneda
        AND c.Saldo < ISNULL(m.CxcEliminarSaldosMenores, 0)
        AND c.Estatus = 'PENDIENTE'
        AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.F', 'CXC.FAC', 'CXC.CA', 'CXC.CAD', 'CXC.D', 'CXC.DM', 'CXC.DA','CXC.NC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP','CXC.DC')
        AND ISNULL(c.Saldo, 0) > 0.0
		AND ISNULL(c.Saldo,0) < ISNULL(c.Importe,0)
      ORDER BY c.Moneda, c.Cliente
  ELSE
    DECLARE crEliminarSaldos CURSOR FOR
     SELECT mt.Clave, m.Moneda, m.TipoCambio, c.Proveedor, c.Mov, c.MovID, ISNULL(c.Saldo, 0)
       FROM Cxp c, Mon m, MovTipo mt
      WHERE c.Empresa = @Empresa
        AND m.Moneda = c.Moneda
        AND c.Saldo < ISNULL(m.CxpEliminarSaldosMenores, 0)
        AND c.Estatus = 'PENDIENTE'
        AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXP.F', 'CXP.FAC', 'CXP.CA', 'CXP.CAD', 'CXP.D', 'CXP.DM', 'CXP.A','CXP.NC','CXP.NCD','CXP.NCP','CXP.NCF','CXP.DC')
        AND ISNULL(c.Saldo, 0) > 0.0
      ORDER BY c.Moneda, c.Proveedor

  OPEN crEliminarSaldos
  FETCH NEXT FROM crEliminarSaldos INTO @MovTipo, @Moneda, @TipoCambio, @Contacto, @Mov, @MovID, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN                         
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      IF @MovTipo IN ('CXC.DA','CXC.NC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP','CXC.DC', 'CXP.A','CXP.NC','CXP.NCD','CXP.NCP','CXP.NCF','CXP.DC') SELECT @Saldo = -@Saldo
      IF @ID IS NULL OR @UltMoneda <> @Moneda OR @UltContacto <> @Contacto
      BEGIN
        SELECT @UltMoneda = @Moneda, @UltContacto = @Contacto
        IF @ID IS NOT NULL AND @Ok IS NULL
        BEGIN
          IF @Modulo = 'CXC'
            UPDATE Cxc SET Importe = @SumaImporte WHERE ID = @ID
          ELSE
            UPDATE Cxp SET Importe = @SumaImporte WHERE ID = @ID
          EXEC spCx @ID, @Modulo, 'AFECTAR', 'TODO', @FechaEmision, NULL, @Usuario, 0, 0, @MovGenerar OUTPUT, @MovIDGenerar OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        END
        IF @Ok IS NULL
        BEGIN
          IF @Modulo = 'CXC'
            INSERT Cxc (Sucursal,  Empresa,  Mov,     FechaEmision,  Moneda,  TipoCambio,  Usuario,   Estatus,     UltimoCambio,   Cliente,   ClienteMoneda, ClienteTipoCambio, AplicaManual)
                VALUES (@Sucursal, @Empresa, @CfgMov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @FechaRegistro, @Contacto, @Moneda,       @TipoCambio, 	1)
          ELSE
            INSERT Cxp (Sucursal,  Empresa,  Mov,     FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      UltimoCambio,   Proveedor, ProveedorMoneda, ProveedorTipoCambio, AplicaManual)
                VALUES (@Sucursal, @Empresa, @CfgMov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @FechaRegistro, @Contacto, @Moneda,         @TipoCambio, 	    1)

          SELECT @ID = SCOPE_IDENTITY()
          SELECT @Conteo = @Conteo + 1, @Renglon = 0.0, @SumaImporte = 0
        END
      END

      SELECT @Renglon = @Renglon + 2048.0, @SumaImporte = @SumaImporte + @Saldo
      IF @Modulo = 'CXC'
        INSERT CxcD (ID, Renglon, Aplica, AplicaID, Importe) VALUES (@ID, @Renglon, @Mov, @MovID, @Saldo)
      ELSE
        INSERT CxpD (ID, Renglon, Aplica, AplicaID, Importe) VALUES (@ID, @Renglon, @Mov, @MovID, @Saldo)
    END
    FETCH NEXT FROM crEliminarSaldos INTO @MovTipo, @Moneda, @TipoCambio, @Contacto, @Mov, @MovID, @Saldo
  END
  CLOSE crEliminarSaldos
  DEALLOCATE crEliminarSaldos

  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    IF @Modulo = 'CXC'
      UPDATE Cxc SET Importe = @SumaImporte WHERE ID = @ID
    ELSE
      UPDATE Cxp SET Importe = @SumaImporte WHERE ID = @ID
    EXEC spCx @ID, @Modulo, 'AFECTAR', 'TODO', @FechaEmision, NULL, @Usuario, 0, 0, @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF @Ok IS NULL 
    SELECT @Ok = 80000, @OkRef = LTRIM(Convert(char, @conteo))+' Ajuste(s) generados.', @OkTipo = 'INFO', @OkDesc = 'Proceso Concluido'
  ELSE
    -- Leer el Mensaje
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok  
  
  -- Mostrar el Estatus de la Afectacion
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, NULL

  RETURN
END
GO

/**************** spGenerarAgent ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarAgent') and type = 'P') drop procedure dbo.spGenerarAgent
GO
CREATE PROCEDURE spGenerarAgent
                   @ID       	int,
		   @MovTipo	char(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Aplica		char(20),
    @AplicaID		varchar(20),
    @AplicaMovTipo	char(20),
    @Sucursal 		int,
    @Empresa		char(5),
    @Moneda		char(10),
    @Agente   		char(10),
    @Renglon		float,
    @Saldo		money

  SELECT @Agente = NULL, @Renglon = 0.0
  SELECT @Sucursal = Sucursal, @Agente = NULLIF(RTRIM(Agente), ''), @Empresa = Empresa, @Moneda = Moneda
    FROM Agent
   WHERE ID = @ID AND Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')

  IF @Agente IS NOT NULL
  BEGIN
    -- Borrar el Anterior
    DELETE AgentD WHERE ID = @ID

    DECLARE crAgentPendiente CURSOR 
      FOR SELECT p.Mov, p.MovID, p.Saldo, mt.Clave
            FROM AgentPendiente p, MovTipo mt
           WHERE p.Empresa = @Empresa
             AND p.Moneda  = @Moneda
             AND p.Agente  = @Agente
             AND ISNULL(p.Saldo, 0.0) >= 0.0
             AND mt.Modulo = 'AGENT' AND mt.Mov = p.Mov
    OPEN crAgentPendiente
    FETCH NEXT FROM crAgentPendiente INTO @Aplica, @AplicaID, @Saldo, @AplicaMovTipo
    WHILE @@FETCH_STATUS <> -1 
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @@ERROR = 0
      BEGIN
        SELECT @Renglon = @Renglon + 2048
        IF @AplicaMovTipo IN ('AGENT.D', 'AGENT.A') SELECT @Saldo = -@Saldo
        IF @MovTipo = 'AGENT.CO' SELECT @Saldo = -@Saldo
        INSERT AgentD (Sucursal,  ID,  Renglon,  RenglonSub, Aplica,  AplicaID,  Importe)
               VALUES (@Sucursal, @ID, @Renglon, 0,          @Aplica, @AplicaID, @Saldo)
      END
      FETCH NEXT FROM crAgentPendiente INTO @Aplica, @AplicaID, @Saldo, @AplicaMovTipo
    END
    CLOSE crAgentPendiente
    DEALLOCATE crAgentPendiente
  END
  
  RETURN
END
GO


/**************** spGenerarAP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarAP') and type = 'P') drop procedure dbo.spGenerarAP
GO
CREATE PROCEDURE spGenerarAP
		   @Sucursal		int,
		   @Accion		char(20),
		   @Empresa		char(5),
    		   @Modulo	      	char(5),
		   @ID			int,
		   @MovTipo		char(20),
		   @FechaRegistro	datetime,
    		   @Mov	      		char(20),
    		   @MovID            	varchar(20),
		   @Moneda		char(10),
		   @TipoCambio		float,
		   @Proyecto		varchar(50),
		   @Cuenta		char(10),
		   @Referencia		varchar(50),
 		   @Condicion		varchar(50),
		   @PrimerVencimiento	datetime,
		   @ImporteTotal	money,

		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Rama		char(5),
    @a			int,
    @EsQuince		bit,
    @ControlAnticipos	char(20),
    @Numero		int,
    @Periodo		char(15),
    @ReferenciaBase	varchar(50),
    @Vencimiento	datetime,
    @FechaRequerida	datetime,
    @EsCargo		bit,
    @Pendiente		money,
    @Saldo		money,
    @Importe		money,
    @Suma		money,
    @Enganche		money,
    @RedondeoMonetarios	int

  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  IF @Accion = 'CANCELAR'
  BEGIN
    UPDATE Anticipo SET Cancelado = 1 WHERE Modulo = @Modulo AND ModuloID = @ID
    RETURN
  END

  SELECT @Suma = 0.0, @Enganche = 0.0
  IF @Modulo = 'VTAS' SELECT @Rama = 'CXC' ELSE
  IF @Modulo = 'COMS' SELECT @Rama = 'CXP'
  ELSE SELECT @Rama = @Modulo

  IF @MovTipo IN ('VTAS.P', 'VTAS.S', 'COMS.O') 
    SELECT @EsCargo = 1
  ELSE
    SELECT @EsCargo = 0

  IF @EsCargo = 0
  BEGIN
    SELECT @Saldo = 0.0
    SELECT @Saldo = ISNULL(Saldo, 0.0)
      FROM AnticipoPendiente
     WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Cuenta = @Cuenta AND Referencia = @Referencia

    IF @ImporteTotal <= @Saldo
      INSERT Anticipo (Sucursal,  Rama,  Modulo,  ModuloID, Empresa,  Cuenta,  Moneda,  TipoCambio,  Mov,  MovID,  Proyecto,  Referencia,  Abono,         Fecha,             FechaRegistro)
               VALUES (@Sucursal, @Rama, @Modulo, @ID,      @Empresa, @Cuenta, @Moneda, @TipoCambio, @Mov, @MovID, @Proyecto, @Referencia, @ImporteTotal, @PrimerVencimiento, @FechaRegistro)
    ELSE BEGIN 
      SELECT @Pendiente = @ImporteTotal
      SELECT @a = CHARINDEX('-', @Referencia)
      IF @a > 0 
        SELECT @ReferenciaBase = SUBSTRING(@Referencia, 1, @a-1) 
      ELSE SELECT @ReferenciaBase = @Referencia

      IF NULLIF(RTRIM(@ReferenciaBase), '') IS NOT NULL
      BEGIN
        DECLARE crAnticipoPendiente CURSOR FOR 
         SELECT Referencia, Saldo
           FROM AnticipoPendiente
          WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Cuenta = @Cuenta AND Referencia LIKE RTRIM(@ReferenciaBase)+'%'
          ORDER BY Fecha 
        OPEN crAnticipoPendiente
        FETCH NEXT FROM crAnticipoPendiente INTO @Referencia, @Saldo
        WHILE @@FETCH_STATUS <> -1 AND @Pendiente > 0.0
        BEGIN                         
          IF @@FETCH_STATUS <> -2 
          BEGIN
            IF @Saldo <= @Pendiente SELECT @Importe = @Saldo ELSE SELECT @Importe = @Pendiente
            INSERT Anticipo (Sucursal,  Rama,  Modulo,  ModuloID, Empresa,  Cuenta,  Moneda,  TipoCambio,  Mov,  MovID,  Proyecto,  Referencia,  Abono,    Fecha,              FechaRegistro)
                     VALUES (@Sucursal, @Rama, @Modulo, @ID,      @Empresa, @Cuenta, @Moneda, @TipoCambio, @Mov, @MovID, @Proyecto, @Referencia, @Importe, @PrimerVencimiento, @FechaRegistro)
            SELECT @Pendiente = @Pendiente - @Importe          
          END
          FETCH NEXT FROM crAnticipoPendiente INTO @Referencia, @Saldo
        END
        CLOSE crAnticipoPendiente
        DEALLOCATE crAnticipoPendiente
      END

      IF @Pendiente > 0.0
        INSERT Anticipo (Sucursal,  Rama,  Modulo,  ModuloID, Empresa,  Cuenta,  Moneda,  TipoCambio,  Mov,  MovID,  Proyecto,  Referencia,  Abono,      Fecha,              FechaRegistro)
                 VALUES (@Sucursal, @Rama, @Modulo, @ID,      @Empresa, @Cuenta, @Moneda, @TipoCambio, @Mov, @MovID, @Proyecto, @Referencia, @Pendiente, @PrimerVencimiento, @FechaRegistro)
    END
  END ELSE 
  BEGIN
    SELECT @ControlAnticipos = UPPER(ControlAnticipos), @Numero = NULLIF(AnticipadoNumero, 0), @Periodo = AnticipadoPeriodo  
      FROM Condicion 
     WHERE Condicion = @Condicion
    IF @ControlAnticipos = 'FECHA REQUERIDA' AND @Modulo IN ('VTAS', 'COMS')
    BEGIN
      IF @Modulo = 'VTAS' DECLARE crFechaRequerida CURSOR FOR SELECT FechaRequerida, SUM(ImporteTotal) FROM VentaTCalc  WHERE ID = @ID GROUP BY FechaRequerida ELSE
      IF @Modulo = 'COMS' DECLARE crFechaRequerida CURSOR FOR SELECT FechaRequerida, SUM(ImporteTotal) FROM CompraTCalc WHERE ID = @ID GROUP BY FechaRequerida
      SELECT @a = 1 
      OPEN crFechaRequerida
      FETCH NEXT FROM crFechaRequerida INTO @FechaRequerida, @Importe
      WHILE @@FETCH_STATUS <> -1 
      BEGIN                         
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID)+ '-' +LTRIM(CONVERT(char, @a))
          SELECT @a = @a + 1 
          INSERT Anticipo (Sucursal,  Rama,  Modulo,  ModuloID, Empresa,  Cuenta,  Moneda,  TipoCambio,  Mov,  MovID,  Proyecto,  Referencia,  Cargo,    Fecha,           FechaRegistro)
                   VALUES (@Sucursal, @Rama, @Modulo, @ID,      @Empresa, @Cuenta, @Moneda, @TipoCambio, @Mov, @MovID, @Proyecto, @Referencia, @Importe, @FechaRequerida, @FechaRegistro)
        END
        FETCH NEXT FROM crFechaRequerida INTO @FechaRequerida, @Importe
      END
      CLOSE crFechaRequerida
      DEALLOCATE crFechaRequerida
    END ELSE
    BEGIN
      IF @ControlAnticipos = 'PLAZOS'
      BEGIN
        SELECT @Numero = ISNULL(@Numero, 1)
        IF @Modulo = 'VTAS' SELECT @Enganche = ISNULL(Enganche, 0.0) FROM Venta WHERE ID = @ID
      END ELSE 
        SELECT @Numero = 1

      SELECT @a = 1, 
             @Vencimiento = @PrimerVencimiento,
             @Importe = ROUND(@ImporteTotal / @Numero, @RedondeoMonetarios)

      IF @Periodo = 'QUINCENAL'
        IF DATEPART(dd, @Vencimiento) <= 15 SELECT @EsQuince = 1 ELSE SELECT @EsQuince = 0

      WHILE (@a <= @Numero) AND @Ok IS NULL
      BEGIN
        IF @Enganche > 0.0 
          IF @a = 1 
            SELECT @Importe = @Enganche
          ELSE
            SELECT @Importe = ROUND((@ImporteTotal - @Enganche) / (@Numero-1), @RedondeoMonetarios)

        IF @Importe < 0.0 SELECT @Ok = 30100
        SELECT @Suma = @Suma + @Importe
        SELECT @Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID)
        IF @Numero > 1 SELECT @Referencia = @Referencia + '-' +LTRIM(CONVERT(char, @a))

        IF @a > 1
        BEGIN     
          IF dbo.fnEsNumerico(@Periodo) = 1 SELECT @Vencimiento = DATEADD(day,   CONVERT(int, @Periodo)*@a, @PrimerVencimiento) ELSE
          IF @Periodo = 'SEMANAL'    SELECT @Vencimiento = DATEADD(wk, @a-1,      @PrimerVencimiento) ELSE
          IF @Periodo = 'MENSUAL'    SELECT @Vencimiento = DATEADD(mm, @a-1,      @PrimerVencimiento) ELSE
          IF @Periodo = 'BIMESTRAL'  SELECT @Vencimiento = DATEADD(mm, (@a-1)*2,  @PrimerVencimiento) ELSE
          IF @Periodo = 'TRIMESTRAL' SELECT @Vencimiento = DATEADD(mm, (@a-1)*3,  @PrimerVencimiento) ELSE
          IF @Periodo = 'SEMESTRAL'  SELECT @Vencimiento = DATEADD(mm, (@a-1)*6,  @PrimerVencimiento) ELSE
          IF @Periodo = 'ANUAL'      SELECT @Vencimiento = DATEADD(yy, (@a-1),    @PrimerVencimiento) ELSE
          IF @Periodo = 'QUINCENAL' 
          BEGIN
            IF @EsQuince = 1 
              SELECT @EsQuince = 0, @Vencimiento = DATEADD(dd, -15, DATEADD(mm, 1, @Vencimiento)) 
            ELSE 
              SELECT @EsQuince = 1, @Vencimiento = DATEADD(dd, 15, @Vencimiento)
          END 
        END
 
        IF @a = @Numero AND @Suma <> @ImporteTotal SELECT @Importe = @Importe - (@Suma - @ImporteTotal)
        INSERT Anticipo (Sucursal,  Rama,  Modulo,  ModuloID, Empresa,  Cuenta,  Moneda,  TipoCambio,  Mov,  MovID,  Proyecto,  Referencia,  Cargo,    Fecha,        FechaRegistro)
                 VALUES (@Sucursal, @Rama, @Modulo, @ID,      @Empresa, @Cuenta, @Moneda, @TipoCambio, @Mov, @MovID, @Proyecto, @Referencia, @Importe, @Vencimiento, @FechaRegistro)

        SELECT @a = @a + 1
      END
    END
  END
  RETURN
END
GO

/**************** spCxModificarVencimiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxModificarVencimiento') and type = 'P') drop procedure dbo.spCxModificarVencimiento
GO
CREATE PROCEDURE spCxModificarVencimiento
    		   @Modulo	      	char(5),
		   @Estacion		int,
		   @Fecha		datetime
--//WITH ENCRYPTION
AS BEGIN
  IF @Modulo = 'CXC' UPDATE Cxc SET Condicion='(Fecha)', Vencimiento = @Fecha FROM Cxc c JOIN ListaID l ON l.Estacion = @Estacion AND l.ID = c.ID ELSE
  IF @Modulo = 'CXP' UPDATE Cxp SET Condicion='(Fecha)', Vencimiento = @Fecha FROM Cxp c JOIN ListaID l ON l.Estacion = @Estacion AND l.ID = c.ID
END
GO

PRINT "******************* SP CXC y CXP ******************"
GO


