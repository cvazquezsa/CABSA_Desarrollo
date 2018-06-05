/* SP SUGERIR    */
-- select importe,* from cxc where id = 65
-- select * from cxcd where id = 65
-- spSugerirAplicacion 'CXC', 65
/*

     SELECT p.Mov, p.MovID, mt.Clave, ISNULL(p.Saldo*p.MovTipoCambio/1.0, 0.0), ISNULL(p.InteresesOrdinarios*p.MovTipoCambio/1.0, 0.0), ISNULL(p.InteresesMoratorios*p.MovTipoCambio/1.0, 0.0), ta.Metodo
       FROM CxcPendiente p
       JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = p.Mov
       LEFT OUTER JOIN CfgAplicaOrden a ON a.Modulo = 'CXC' AND a.Mov = p.Mov
       LEFT OUTER JOIN Cxc r ON r.ID = p.RamaID
       LEFT OUTER JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = r.TipoAmortizacion
      WHERE p.Empresa = 'HPYME' AND p.Cliente = 'CTE01'
      ORDER BY a.Orden, p.Vencimiento, p.Mov, p.MovID

-- spSugerirAplicacion 'cxc', 17, 2000


*/

/**************** spDineroSugerirCorteMultimoneda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroSugerirCorteMultimoneda') and type = 'P') drop procedure dbo.spDineroSugerirCorteMultimoneda
GO             
CREATE PROCEDURE spDineroSugerirCorteMultimoneda
		    @Sucursal			int,
		    @DineroID			int,
		    @Empresa			char(5),
		    @Caja			char(10),
		    @CorteParcialDelCajero	bit	= 0

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DineroMovTipo	char(20),
    @DineroTipoCambio	float,
    @TipoCambio         float,
    @DineroCajero	char(10),
    @Cajero		char(10),
    @MovTipo		char(20),
    @UltimoID		int,
    @ID			int,
    @ConDesglose	bit,
    @Total		money,
    @Importe		money,
    @Renglon		float,
    @Moneda		char(10),
    @FormaPago		varchar(50),
    @FormaPagoD		varchar(50),
    @CtaDinero		char(10),
    @CtaDineroDestino	char(10),
    @FondoFijo		money,
    @FondoFijoFormaPago	varchar(50),
    @Continuar		bit,
    @DescontarFondoFijo	money,
    @Referencia	varchar(50)
    

  CREATE TABLE #CorteCaja (
    Referencia	varchar(50)	COLLATE Database_Default NULL,
    FormaPago		varchar(50)	COLLATE Database_Default NULL,
    Moneda		varchar(10)	COLLATE Database_Default NULL,
    Importe		money		NULL
  )

  SELECT @DineroMovTipo = mt.Clave,
         @DineroTipoCambio = d.TipoCambio,
         @DineroCajero = d.Cajero
    FROM Dinero d, MovTipo mt
   WHERE d.ID = @DineroID AND mt.Modulo = 'DIN' AND d.Mov = mt.Mov

  SELECT @FondoFijo = ISNULL(FondoFijo, 0),
         @FondoFijoFormaPago = NULLIF(RTRIM(FondoFijoFormaPago), '')
    FROM CtaDinero 
   WHERE CtaDinero = @Caja

  INSERT #CorteCaja (FormaPago) VALUES (NULL)
  INSERT #CorteCaja (FormaPago) SELECT FormaPago FROM FormaPago

  SELECT @UltimoID = ISNULL(MAX(ID), 0) FROM Dinero d, MovTipo mt WHERE d.Empresa = @Empresa AND d.Mov = mt.Mov AND mt.Clave = 'DIN.C' AND d.Estatus = 'CONCLUIDO' AND CtaDinero = @Caja

  DECLARE crCorteCaja CURSOR
      FOR SELECT f.ID, f.CtaDinero, f.CtaDineroDestino, f.ConDesglose, f.Importe, f.FormaPago, d.Importe, d.FormaPago, mt.Clave, f.Cajero, d.Referencia, f.Moneda
           FROM Dinero f
           LEFT OUTER JOIN DineroD d ON f.ID = d.ID  
           JOIN MovTipo mt ON f.Mov = mt.Mov
          WHERE f.Empresa = @Empresa
            AND f.ID > @UltimoID
            AND mt.Clave IN ('DIN.I', 'DIN.E', 'DIN.F', 'DIN.TC', 'DIN.A', 'DIN.AP'/*, 'DIN.CP'*/)
            AND f.Estatus = 'CONCLUIDO'
            AND mt.SubClave NOT IN ('DIN.AMULTIMONEDA')
            --AND f.Moneda = @Moneda
            AND ((f.CtaDinero = @Caja AND f.Corte IS NULL) OR (f.CtaDineroDestino = @Caja AND f.CorteDestino IS NULL))
           ORDER BY f.Moneda  


  OPEN crCorteCaja
  FETCH NEXT FROM crCorteCaja INTO @ID, @CtaDinero, @CtaDineroDestino, @ConDesglose, @Total, @FormaPago, @Importe, @FormaPagoD, @MovTipo, @Cajero, @Referencia, @Moneda
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
--select "ID" =@ID, "CtaDinero" =@CtaDinero, "Destino" = @CtaDineroDestino, "Desglose" = @ConDesglose, "Total" = @Total, "Forma" = @FormaPago, "Importe" = @Importe, "FormaD" = @FormaPagoD, "MovTipo" = @MovTipo
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Continuar = 1
      IF @MovTipo = 'DIN.CP' AND @CtaDineroDestino = @Caja SELECT @Continuar = 0
      IF @MovTipo = 'DIN.CP' AND @CorteParcialDelCajero = 1 AND @DineroCajero <> @Cajero SELECT @Continuar = 0

      IF @Continuar = 1
      BEGIN
        IF @MovTipo IN ('DIN.E', 'DIN.F', 'DIN.CP') OR (@MovTipo = 'DIN.TC' AND @CtaDinero = @Caja) 
          SELECT @Total = -@Total, @Importe = -@Importe

        IF @ConDesglose = 0
	      UPDATE #CorteCaja SET Importe = ISNULL(Importe, 0.0) + @Total, Referencia = @Referencia, Moneda = @Moneda WHERE FormaPago = @FormaPago
        ELSE 
          UPDATE #CorteCaja SET Importe = ISNULL(Importe, 0.0) + @Importe, Referencia = @Referencia, Moneda = @Moneda WHERE FormaPago = @FormaPagoD
      END
    END
    FETCH NEXT FROM crCorteCaja INTO @ID, @CtaDinero, @CtaDineroDestino, @ConDesglose, @Total, @FormaPago, @Importe, @FormaPagoD, @MovTipo, @Cajero, @Referencia, @Moneda
  END
  CLOSE crCorteCaja
  DEALLOCATE crCorteCaja

  BEGIN TRANSACTION
    DELETE DineroD WHERE ID = @DineroID
    SELECT @Renglon = 0.0, @Total = 0.0

    SELECT @DescontarFondoFijo = (SELECT ISNULL(SUM(Importe), 0) FROM #CorteCaja) - (SELECT ISNULL(SUM(s.Saldo*m.TipoCambio), 0) - @FondoFijo
      FROM DineroSaldo s, Mon m 
     WHERE s.Empresa = @Empresa AND s.CtaDinero = @Caja AND s.Moneda = m.Moneda)

    DECLARE crFormaPago CURSOR FOR SELECT NULLIF(RTRIM(FormaPago), ''), Importe, NULLIF(RTRIM(Referencia), ''), Moneda FROM #CorteCaja WHERE ISNULL(Importe, 0.0) <> 0.0
    OPEN crFormaPago
    FETCH NEXT FROM crFormaPago INTO @FormaPago, @Importe, @Referencia, @Moneda
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @DescontarFondoFijo <> 0.0 AND @FormaPago = @FondoFijoFormaPago AND @DineroTipoCambio = 1.0 AND @DineroMovTipo = 'DIN.CP' 
          SELECT @Importe = @Importe - @DescontarFondoFijo
          
        SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda  

        IF @Importe <> 0.0
        BEGIN
          SELECT @Renglon = @Renglon + 2048, @Total = @Total + (@Importe * @TipoCambio)
          INSERT DineroD (Sucursal, ID, Renglon, RenglonSub, Importe, FormaPago, Referencia, CtaDinero, Moneda, TipoCambio) 
                  VALUES (@Sucursal, @DineroID, @Renglon, 0, @Importe, @FormaPago, @Referencia, @Caja,  @Moneda, @TipoCambio)
        END
      END
      FETCH NEXT FROM crFormaPago INTO @FormaPago, @Importe, @Referencia, @Moneda
    END
    CLOSE crFormaPago
    DEALLOCATE crFormaPago
    UPDATE Dinero SET ConDesglose = 1, Importe = @Total WHERE ID = @DineroID
  COMMIT TRANSACTION
END
GO

-- select * from cxc
-- spCxAsistenteAplicacion 'DEMO', 'CXC', 5
/**************** spCxAsistenteAplicacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxAsistenteAplicacion') and type = 'P') drop procedure dbo.spCxAsistenteAplicacion
GO             
CREATE PROCEDURE spCxAsistenteAplicacion
		    @Empresa		char(5),
		    @Modulo		char(5),
		    @ID			int
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Aplica			varchar(20),
    @AplicaID			varchar(20),
    @Importe			money,
    @InteresesOrdinarios	money,
    @InteresesMoratorios	money,
    @Saldo			money,
    @SaldoInteresesOrdinarios	money,
    @SaldoInteresesMoratorios	money

  IF (SELECT AC FROM EmpresaGral WHERE Empresa = @Empresa) = 0 
    RETURN
    
  IF @Modulo = 'CXC'
    DECLARE crAsistenteAplicacion CURSOR LOCAL FOR
       SELECT d.Aplica, d.AplicaID, d.Importe
         FROM CxcD d
        WHERE d.ID = @ID
  ELSE
  IF @Modulo = 'CXP'
    DECLARE crAsistenteAplicacion CURSOR LOCAL FOR
       SELECT d.Aplica, d.AplicaID, d.Importe
         FROM CxpD d
        WHERE d.ID = @ID
    
  OPEN crAsistenteAplicacion
  FETCH NEXT FROM crAsistenteAplicacion INTO @Aplica, @AplicaID, @Importe
  WHILE @@FETCH_STATUS <> -1 AND NULLIF(@Importe, 0.0) IS NOT NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Saldo = 0.0, @SaldoInteresesOrdinarios = 0.0, @SaldoInteresesMoratorios = 0.0
      IF @Modulo = 'CXC'
        SELECT @Saldo = ISNULL(Saldo, 0.0), @SaldoInteresesOrdinarios = ISNULL(SaldoInteresesOrdinarios, 0.0), @SaldoInteresesMoratorios = ISNULL(SaldoInteresesMoratorios, 0.0)
          FROM CxcPendiente
         WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID
      ELSE
      IF @Modulo = 'CXP'
        SELECT @Saldo = ISNULL(Saldo, 0.0), @SaldoInteresesOrdinarios = ISNULL(SaldoInteresesOrdinarios, 0.0), @SaldoInteresesMoratorios = ISNULL(SaldoInteresesMoratorios, 0.0)
          FROM CxpPendiente
         WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID

      SELECT @InteresesMoratorios = NULL, @InteresesOrdinarios = NULL
      IF @SaldoInteresesMoratorios > 0.0 
      BEGIN
        IF @Importe >= @SaldoInteresesMoratorios 
          SELECT @InteresesMoratorios = @SaldoInteresesMoratorios, @Importe = @Importe - @SaldoInteresesMoratorios
        ELSE
          SELECT @InteresesMoratorios = @Importe, @Importe = 0.0
      END 
      IF @SaldoInteresesOrdinarios > 0.0 
      BEGIN
        IF @Importe >= @SaldoInteresesOrdinarios
          SELECT @InteresesOrdinarios = @SaldoInteresesOrdinarios, @Importe = @Importe - @SaldoInteresesOrdinarios
        ELSE
          SELECT @InteresesOrdinarios = @Importe, @Importe = 0.0
      END 
      
      IF @Modulo = 'CXC'
        UPDATE CxcD 
           SET Importe = @Importe, InteresesOrdinarios = @InteresesOrdinarios, InteresesMoratorios = @InteresesMoratorios 
         WHERE CURRENT OF crAsistenteAplicacion
      ELSE
      IF @Modulo = 'CXP'
        UPDATE CxpD 
           SET Importe = @Importe, InteresesOrdinarios = @InteresesOrdinarios, InteresesMoratorios = @InteresesMoratorios 
         WHERE CURRENT OF crAsistenteAplicacion
    END
    FETCH NEXT FROM crAsistenteAplicacion INTO @Aplica, @AplicaID, @Importe
  END 
  CLOSE crAsistenteAplicacion
  DEALLOCATE crAsistenteAplicacion

  RETURN
END
GO

-- spSugerirCobro 'SALDO VENCIDO', 'CXC', 15
/**************** spSugerirCobro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirCobro') and type = 'P') drop procedure dbo.spSugerirCobro
GO             
CREATE PROCEDURE spSugerirCobro
		    @SugerirPago	varchar(20),
		    @Modulo		char(5),
		    @ID			int,
    		    @ImporteTotal	money = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa			char(5),
    @Sucursal			int,
    @Hoy			datetime,
    @Vencimiento		datetime,
    @DiasCredito		int,
    @DiasVencido		int,
    @TasaDiaria			float,
    @Moneda			char(10),
    @TipoCambio			float,
    @Contacto			char(10),
    @Renglon			float,
    @Aplica			varchar(20),
    @AplicaID			varchar(20),
    @AplicaMovTipo		varchar(20),
    @Capital			money,
    @SaldoInteresesOrdinarios		money,
    @SaldoInteresesOrdinariosIVA	float, --MEJORA10041    
    @SaldoInteresesMoratorios		money,
    @SaldoInteresesMoratoriosIVA	float, --MEJORA10041        
    @ImpuestoAdicional		float,
    @Importe			money,
    @SumaImporte		money,
    @Impuestos			money,
    @DesglosarImpuestos 			bit,
    @LineaCredito					varchar(20),
    @Metodo							int,
    @InteresesOrdinariosConIVAFactor	float, --MEJORA10041
    @InteresesMoratoriosConIVAFactor	float  --MEJORA10041

  SELECT @DesglosarImpuestos = 0 , @Renglon = 0.0, @SumaImporte = 0.0, @ImporteTotal = NULLIF(@ImporteTotal, 0.0), @SugerirPago = UPPER(@SugerirPago)
  IF @SugerirPago <> 'IMPORTE ESPECIFICO' SELECT @ImporteTotal = NULL

  IF @Modulo = 'CXC'
  BEGIN
    SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Cliente   FROM Cxc WHERE ID = @ID 
    DELETE CxcD WHERE ID = @ID 
    DECLARE crAplica CURSOR FOR
     SELECT p.Mov, p.MovID, p.Vencimiento, mt.Clave, ISNULL(p.Saldo*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.SaldoInteresesOrdinarios*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.SaldoInteresesOrdinariosIVA*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.SaldoInteresesMoratorios*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.SaldoInteresesMoratoriosIVA*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ta.Metodo, p.LineaCredito --MEJORA10041
       FROM CxcPendiente p
       JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = p.Mov
       LEFT OUTER JOIN CfgAplicaOrden a ON a.Modulo = @Modulo AND a.Mov = p.Mov
       LEFT OUTER JOIN Cxc r ON r.ID = p.RamaID
       LEFT OUTER JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = r.TipoAmortizacion
      WHERE p.Empresa = @Empresa AND p.Cliente = @Contacto AND mt.Clave NOT IN ('CXC.SCH','CXC.SD')
      ORDER BY a.Orden, p.Vencimiento, p.Mov, p.MovID
    SELECT @DesglosarImpuestos = ISNULL(CxcCobroImpuestos, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa
  END ELSE
  IF @Modulo = 'CXP' 
  BEGIN
    SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Contacto = Proveedor FROM Cxp WHERE ID = @ID 
    DELETE CxpD WHERE ID = @ID
    DECLARE crAplica CURSOR FOR
     SELECT p.Mov, p.MovID, p.Vencimiento, mt.Clave, ISNULL(p.Saldo*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.SaldoInteresesOrdinarios*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.SaldoInteresesOrdinariosIVA*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.SaldoInteresesMoratorios*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ISNULL(p.SaldoInteresesMoratoriosIVA*mt.Factor*p.MovTipoCambio/@TipoCambio, 0.0), ta.Metodo, p.LineaCredito --MEJORA10041
       FROM CxpPendiente p
       JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = p.Mov
       LEFT OUTER JOIN CfgAplicaOrden a ON a.Modulo = @Modulo AND a.Mov = p.Mov
       LEFT OUTER JOIN Cxc r ON r.ID = p.RamaID
       LEFT OUTER JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = r.TipoAmortizacion
      WHERE p.Empresa = @Empresa AND p.Proveedor = @Contacto AND mt.Clave NOT IN ('CXP.SCH','CXP.SD')
      ORDER BY a.Orden, p.Vencimiento, p.Mov, p.MovID
  END ELSE
    RETURN

  OPEN crAplica
  FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @Vencimiento, @AplicaMovTipo, @Capital, @SaldoInteresesOrdinarios, @SaldoInteresesOrdinariosIVA, @SaldoInteresesMoratorios, @SaldoInteresesMoratoriosIVA, @Metodo, @LineaCredito --MEJORA10041
  WHILE @@FETCH_STATUS <> -1 AND ((@SugerirPago = 'SALDO VENCIDO' AND @Vencimiento<=@Hoy) OR (@SugerirPago = 'IMPORTE ESPECIFICO' AND @ImporteTotal > @SumaImporte) OR @SugerirPago = 'SALDO TOTAL')
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN      
/*
      IF @Modulo = 'CXC' AND (SELECT CobroIntereses FROM LC WHERE LineaCredito = @LineaCredito) = 'FIJOS' 
         SELECT @Intereses = @InteresesFijos 
      ELSE SELECT @Intereses = @InteresesOrdinarios
*/
      -- Borrar Intereses Ordinarios cuando son por Anticipado
      IF @Metodo IN (12, 22) SELECT @SaldoInteresesOrdinarios = 0.0, @SaldoInteresesOrdinariosIVA = 0.0 --MEJORA10041
      IF @Metodo = 50 SELECT @ImpuestoAdicional = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa ELSE SELECT @ImpuestoAdicional = NULL

      -- Intereses Moratorios
      IF @SumaImporte + @SaldoInteresesMoratorios + @SaldoInteresesMoratoriosIVA > @ImporteTotal --MEJORA10041
      BEGIN --MEJORA10041
        SELECT @InteresesMoratoriosConIVAFactor = @ImporteTotal - @SumaImporte --MEJORA10041
        SELECT @InteresesMoratoriosConIVAFactor = @InteresesMoratoriosConIVAFactor / (@SaldoInteresesMoratorios + @SaldoInteresesMoratoriosIVA) --MEJORA10041
        SELECT @SaldoInteresesMoratorios = @SaldoInteresesMoratorios * @InteresesMoratoriosConIVAFactor --MEJORA10041
        SELECT @SaldoInteresesMoratoriosIVA = @SaldoInteresesMoratoriosIVA * @InteresesMoratoriosConIVAFactor --MEJORA10041        
      END --MEJORA10041        
      SELECT @SumaImporte = @SumaImporte + @SaldoInteresesMoratorios + @SaldoInteresesMoratoriosIVA --MEJORA10041

      -- Intereses Ordinarios
      IF @SumaImporte + @SaldoInteresesOrdinarios + @SaldoInteresesOrdinariosIVA > @ImporteTotal --MEJORA10041
      BEGIN --MEJORA10041
        SELECT @InteresesOrdinariosConIVAFactor = @ImporteTotal - @SumaImporte --MEJORA10041
        SELECT @InteresesOrdinariosConIVAFactor = @InteresesOrdinariosConIVAFactor / (@SaldoInteresesOrdinarios + @SaldoInteresesOrdinariosIVA) --MEJORA10041
        SELECT @SaldoInteresesOrdinarios = @SaldoInteresesOrdinarios * @InteresesOrdinariosConIVAFactor --MEJORA10041
        SELECT @SaldoInteresesOrdinariosIVA = @SaldoInteresesOrdinariosIVA * @InteresesOrdinariosConIVAFactor --MEJORA10041        
      END        
      SELECT @SumaImporte = @SumaImporte + @SaldoInteresesOrdinarios + @SaldoInteresesOrdinariosIVA --MEJORA10041

      -- Capital
      IF @SumaImporte + @Capital > @ImporteTotal SELECT @Capital = @ImporteTotal - @SumaImporte
      SELECT @SumaImporte = @SumaImporte + @Capital

      IF @SaldoInteresesMoratorios <> 0.0 OR @SaldoInteresesOrdinarios <> 0.0 OR @Capital <> 0.0
      BEGIN
        SELECT @Renglon = @Renglon + 2048.0
        IF @Modulo = 'CXC'
          INSERT CxcD (ID,  Sucursal,  Renglon,  Aplica,  AplicaID,  Importe,               InteresesOrdinarios,		            InteresesOrdinariosIVA,                    InteresesMoratorios,                    InteresesMoratoriosIVA,                    ImpuestoAdicional) --MEJORA10041
               VALUES (@ID, @Sucursal, @Renglon, @Aplica, @AplicaID, NULLIF(@Capital, 0.0), NULLIF(@SaldoInteresesOrdinarios, 0.0), NULLIF(@SaldoInteresesOrdinariosIVA, 0.0), NULLIF(@SaldoInteresesMoratorios, 0.0), NULLIF(@SaldoInteresesMoratoriosIVA, 0.0), @ImpuestoAdicional) --MEJORA10041
        ELSE
          INSERT CxpD (ID,  Sucursal,  Renglon,  Aplica,  AplicaID,  Importe,               InteresesOrdinarios,                    InteresesOrdinariosIVA,                    InteresesMoratorios,                    InteresesMoratoriosIVA) --MEJORA10041
               VALUES (@ID, @Sucursal, @Renglon, @Aplica, @AplicaID, NULLIF(@Capital, 0.0), NULLIF(@SaldoInteresesOrdinarios, 0.0), NULLIF(@SaldoInteresesOrdinariosIVA, 0.0), NULLIF(@SaldoInteresesMoratorios, 0.0), NULLIF(@SaldoInteresesMoratoriosIVA, 0.0)) --MEJORA10041
      END
      FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @Vencimiento, @AplicaMovTipo, @Capital, @SaldoInteresesOrdinarios, @SaldoInteresesOrdinariosIVA, @SaldoInteresesMoratorios, @SaldoInteresesMoratoriosIVA, @Metodo, @LineaCredito --MEJORA10041
    END
  END
  CLOSE crAplica
  DEALLOCATE crAplica

  IF @Modulo = 'CXC'
  BEGIN
    SELECT @Impuestos = NULL, @Importe = @SumaImporte
    IF @DesglosarImpuestos = 1
      SELECT @Impuestos = NULLIF(SUM((ISNULL(d.Importe, 0.0)+ISNULL(d.DescuentoRecargos, 0.0))*c.IVAFiscal*ISNULL(c.IEPSFiscal, 1)), 0)
        FROM CxcD d, Cxc c
       WHERE d.ID = @ID AND c.Empresa = @Empresa AND c.Mov = d.Aplica AND c.MovID = d.AplicaID AND c.Estatus = 'PENDIENTE'     
    UPDATE Cxc SET AplicaManual = 1, Importe = @Importe - ISNULL(@Impuestos, 0.0), Impuestos = ISNULL(@Impuestos, 0.0) WHERE ID = @ID
  END ELSE
    UPDATE Cxp SET AplicaManual = 1, Importe = @SumaImporte WHERE ID = @ID

  RETURN
END
GO

/**************** spSugerirCobroCapital ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirCobroCapital') and type = 'P') drop procedure dbo.spSugerirCobroCapital
GO             
CREATE PROCEDURE spSugerirCobroCapital
		    @Aplicacion		varchar(20),
		    @Modulo		char(5),
		    @ID			int,
    		    @ImporteTotal	money = NULL,
                    @LineaCredito	varchar(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @Sucursal		int,
    @Hoy		datetime,
    @Moneda		char(10),
    @TipoCambio		float,
    @Cliente		char(10),
    @Aplica		varchar(20),
    @AplicaID		varchar(20),
    @Saldo		money,
    @Cantidad		int,
    @Renglon		float,
    @Importe		money



  SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Hoy = FechaEmision, @Moneda = Moneda, @TipoCambio = TipoCambio, @Cliente = Cliente
    FROM Cxc 
   WHERE ID = @ID 

  EXEC spSugerirCobro 'SALDO VENCIDO', @Modulo, @ID, @ImporteTotal 
  SELECT @Saldo = @ImporteTotal - (SELECT SUM(ISNULL(Importe, 0.0)+ ISNULL(InteresesOrdinarios, 0.0)+ISNULL(InteresesMoratorios, 0.0)) FROM CxcD WHERE ID = @ID)
  IF ISNULL(@Saldo, 0.0) > 0.0
  BEGIN
    SELECT @Renglon = 0.0
    SELECT @Renglon = ISNULL(MAX(Renglon),0.0) FROM CxcD WHERE ID = @ID
    IF UPPER(@Aplicacion) = 'DISTRIBUIDA'
    BEGIN
      SELECT @Cantidad = COUNT(*) 
        FROM CxcPendiente p
       WHERE Empresa = @Empresa AND Cliente = @Cliente AND LineaCredito = @LineaCredito AND RamaID IS NOT NULL AND Vencimiento>@Hoy

      SELECT @Importe = @Saldo/NULLIF(@Cantidad, 0)
      DECLARE crAplica CURSOR FOR
       SELECT p.Mov, p.MovID
         FROM CxcPendiente p
        WHERE Empresa = @Empresa AND Cliente = @Cliente AND LineaCredito = @LineaCredito AND RamaID IS NOT NULL AND Vencimiento>@Hoy
      OPEN crAplica
      FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID
      WHILE @@FETCH_STATUS <> -1 AND @Importe IS NOT NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0
          INSERT CxcD (ID,  Sucursal,  Renglon,  Aplica,  AplicaID,  Importe) 
               VALUES (@ID, @Sucursal, @Renglon, @Aplica, @AplicaID, @Importe)
        END
        FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID
      END 
      CLOSE crAplica
      DEALLOCATE crAplica
    END ELSE
    IF UPPER(@Aplicacion) = 'FINAL'
    BEGIN
      DECLARE crAplica CURSOR FOR
       SELECT p.Mov, p.MovID, Saldo
         FROM CxcPendiente p
        WHERE Empresa = @Empresa AND Cliente = @Cliente AND LineaCredito = @LineaCredito AND RamaID IS NOT NULL
        ORDER BY Vencimiento DESC
      OPEN crAplica
      FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @Importe
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Importe IS NOT NULL AND @Saldo > 0.0
        BEGIN
          IF @Importe > @Saldo SELECT @Importe = @Saldo
          SELECT @Renglon = @Renglon + 2048.0
          INSERT CxcD (ID,  Sucursal,  Renglon,  Aplica,  AplicaID,  Importe) 
               VALUES (@ID, @Sucursal, @Renglon, @Aplica, @AplicaID, @Importe)
          SELECT @Saldo = @Saldo - @Importe
        END
        FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @Importe 
      END 
      CLOSE crAplica
      DEALLOCATE crAplica
    END 
  END ELSE 
    EXEC spSugerirCobro 'IMPORTE ESPECIFICO', @Modulo, @ID, @ImporteTotal 
  RETURN
END
GO

-- EXEC spDineroSugerirCorte 0, 4, 'DEMO', 'C1', 'Pesos'	
/**************** spDineroSugerirCorte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroSugerirCorte') and type = 'P') drop procedure dbo.spDineroSugerirCorte
GO             
CREATE PROCEDURE spDineroSugerirCorte
		    @Sucursal			int,
		    @DineroID			int,
		    @Empresa			char(5),
		    @Caja			char(10),
		    @Moneda			char(10),
		    @CorteParcialDelCajero	bit	= 0

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DineroMovTipo	char(20),
    @DineroTipoCambio	float,
    @DineroCajero	char(10),
    @Cajero		char(10),
    @MovTipo		char(20),
    @UltimoID		int,
    @ID			int,
    @ConDesglose	bit,
    @Total		money,
    @Importe		money,
    @Renglon		float,

    @FormaPago		varchar(50),
    @FormaPagoD		varchar(50),
    @CtaDinero		char(10),
    @CtaDineroDestino	char(10),
    @FondoFijo		money,
    @FondoFijoFormaPago	varchar(50),
    @Continuar		bit,
    @DescontarFondoFijo	money,
    @Referencia	varchar(50) --JGD 29Abril2011. Ticket 4362

  CREATE TABLE #CorteCaja (
    Referencia	varchar(50)	COLLATE Database_Default NULL,
    FormaPago		varchar(50)	COLLATE Database_Default NULL,
    Importe		money		NULL
  )

  SELECT @DineroMovTipo = mt.Clave,
         @DineroTipoCambio = d.TipoCambio,
         @DineroCajero = d.Cajero
    FROM Dinero d, MovTipo mt
   WHERE d.ID = @DineroID AND mt.Modulo = 'DIN' AND d.Mov = mt.Mov

  SELECT @FondoFijo = ISNULL(FondoFijo, 0),
         @FondoFijoFormaPago = NULLIF(RTRIM(FondoFijoFormaPago), '')
    FROM CtaDinero 
   WHERE CtaDinero = @Caja

  INSERT #CorteCaja (FormaPago) VALUES (NULL)
  INSERT #CorteCaja (FormaPago) SELECT FormaPago FROM FormaPago

  SELECT @UltimoID = ISNULL(MAX(ID), 0) FROM Dinero d, MovTipo mt WHERE d.Empresa = @Empresa AND d.Mov = mt.Mov AND mt.Clave = 'DIN.C' AND d.Estatus = 'CONCLUIDO' AND CtaDinero = @Caja

  DECLARE crCorteCaja CURSOR
      FOR SELECT f.ID, f.CtaDinero, f.CtaDineroDestino, f.ConDesglose, f.Importe, f.FormaPago, d.Importe, d.FormaPago, mt.Clave, f.Cajero, d.Referencia
           FROM Dinero f
           LEFT OUTER JOIN DineroD d ON f.ID = d.ID  
           JOIN MovTipo mt ON f.Mov = mt.Mov
          WHERE f.Empresa = @Empresa
            AND f.ID > @UltimoID
            AND mt.Clave IN ('DIN.I', 'DIN.E', 'DIN.F', 'DIN.TC', 'DIN.A', 'DIN.AP'/*, 'DIN.CP'*/)
            AND f.Estatus = 'CONCLUIDO'
            AND f.Moneda = @Moneda
            AND ((f.CtaDinero = @Caja AND f.Corte IS NULL) OR (f.CtaDineroDestino = @Caja AND f.CorteDestino IS NULL))

  OPEN crCorteCaja
  FETCH NEXT FROM crCorteCaja INTO @ID, @CtaDinero, @CtaDineroDestino, @ConDesglose, @Total, @FormaPago, @Importe, @FormaPagoD, @MovTipo, @Cajero, @Referencia
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
--select "ID" =@ID, "CtaDinero" =@CtaDinero, "Destino" = @CtaDineroDestino, "Desglose" = @ConDesglose, "Total" = @Total, "Forma" = @FormaPago, "Importe" = @Importe, "FormaD" = @FormaPagoD, "MovTipo" = @MovTipo
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Continuar = 1
      IF @MovTipo = 'DIN.CP' AND @CtaDineroDestino = @Caja SELECT @Continuar = 0
      IF @MovTipo = 'DIN.CP' AND @CorteParcialDelCajero = 1 AND @DineroCajero <> @Cajero SELECT @Continuar = 0

      IF @Continuar = 1
      BEGIN
        IF @MovTipo IN ('DIN.E', 'DIN.F', 'DIN.CP') OR (@MovTipo = 'DIN.TC' AND @CtaDinero = @Caja) 
          SELECT @Total = -@Total, @Importe = -@Importe

        IF @ConDesglose = 0
	      UPDATE #CorteCaja SET Importe = ISNULL(Importe, 0.0) + @Total, Referencia = @Referencia WHERE FormaPago = @FormaPago
        ELSE 
          UPDATE #CorteCaja SET Importe = ISNULL(Importe, 0.0) + @Importe, Referencia = @Referencia WHERE FormaPago = @FormaPagoD
      END
    END
    FETCH NEXT FROM crCorteCaja INTO @ID, @CtaDinero, @CtaDineroDestino, @ConDesglose, @Total, @FormaPago, @Importe, @FormaPagoD, @MovTipo, @Cajero, @Referencia
  END
  CLOSE crCorteCaja
  DEALLOCATE crCorteCaja

  BEGIN TRANSACTION
    DELETE DineroD WHERE ID = @DineroID
    SELECT @Renglon = 0.0, @Total = 0.0

    SELECT @DescontarFondoFijo = (SELECT ISNULL(SUM(Importe), 0) FROM #CorteCaja) - (SELECT ISNULL(SUM(s.Saldo*m.TipoCambio), 0) - @FondoFijo
      FROM DineroSaldo s, Mon m 
     WHERE s.Empresa = @Empresa AND s.CtaDinero = @Caja AND s.Moneda = m.Moneda)

    DECLARE crFormaPago CURSOR FOR SELECT NULLIF(RTRIM(FormaPago), ''), Importe, NULLIF(RTRIM(Referencia), '') FROM #CorteCaja WHERE ISNULL(Importe, 0.0) <> 0.0
    OPEN crFormaPago
    FETCH NEXT FROM crFormaPago INTO @FormaPago, @Importe, @Referencia
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @DescontarFondoFijo <> 0.0 AND @FormaPago = @FondoFijoFormaPago AND @DineroTipoCambio = 1.0 AND @DineroMovTipo = 'DIN.CP' 
          SELECT @Importe = @Importe - @DescontarFondoFijo

        IF @Importe <> 0.0
        BEGIN
          SELECT @Renglon = @Renglon + 2048, @Total = @Total + @Importe
          INSERT DineroD (Sucursal, ID, Renglon, RenglonSub, Importe, FormaPago, Referencia) 
                  VALUES (@Sucursal, @DineroID, @Renglon, 0, @Importe, @FormaPago, @Referencia)
        END
      END
      FETCH NEXT FROM crFormaPago INTO @FormaPago, @Importe, @Referencia
    END
    CLOSE crFormaPago
    DEALLOCATE crFormaPago
    UPDATE Dinero SET ConDesglose = 1, Importe = @Total WHERE ID = @DineroID
  COMMIT TRANSACTION
END
GO

/**************** spCerrarSucursalCajas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCerrarSucursalCajas') and type = 'P') drop procedure dbo.spCerrarSucursalCajas
GO             
CREATE PROCEDURE spCerrarSucursalCajas
			@Estacion	int,
                    	@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@Fecha		datetime,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DineroID		int,
    @DineroMov		char(20),
    @DineroMovID	varchar(20),
    @Cajero		char(10),
    @Caja		char(10),
    @CtaDestino		char(10),
    @Moneda		char(10),
    @TipoCambio		float

  SELECT @DineroMov = CajaCorteCaja FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @CtaDestino = DefCtaDineroTrans FROM Usuario WHERE Usuario = @Usuario 
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  DECLARE crCtaDinero CURSOR FOR
   SELECT c.CtaDinero 
     FROM DineroSaldo s, CtaDinero c 
    WHERE s.CtaDinero = c.CtaDinero AND c.Tipo = 'Caja' AND ISNULL(s.Saldo, 0) <> ISNULL(c.FondoFijo, 0)
      AND c.CorteAutoCerrarDia = 1
  OPEN crCtaDinero
  FETCH NEXT FROM crCtaDinero INTO @Caja
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Cajero = NULLIF(RTRIM(Cajero), '') 
        FROM CtaDineroCajero 
       WHERE Moneda = '' AND CtaDinero = @Caja

      INSERT Dinero (Empresa,  Sucursal,  Usuario,  Mov,        FechaEmision, CtaDinero, CtaDineroDestino, Moneda,  TipoCambio,  Cajero,  Estatus)
             VALUES (@Empresa, @Sucursal, @Usuario, @DineroMov, @Fecha,       @Caja,     @CtaDestino,      @Moneda, @TipoCambio, @Cajero, 'SINAFECTAR')
      SELECT @DineroID = SCOPE_IDENTITY()
      EXEC spDineroSugerirCorte @Sucursal, @DineroID, @Empresa, @Caja, @Moneda
      IF EXISTS(SELECT * FROM DineroD WHERE ID = @DineroID)
        EXEC spAfectar 'DIN', @DineroID, @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      ELSE
        DELETE Dinero WHERE ID = @DineroID
    END
    FETCH NEXT FROM crCtaDinero INTO @Caja
  END -- While
  CLOSE crCtaDinero
  DEALLOCATE crCtaDinero

  RETURN
END
GO

-- spCompraSugerir 100, 18304, '0', '10', '1'
-- select estatus, * from compra where id = 18304
-- select count(*) from ventad
/**************** spCompraSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraSugerir') and type = 'P') drop procedure dbo.spCompraSugerir
GO             
CREATE PROCEDURE spCompraSugerir
		    @Estacion			int,
                    @CompraID			int,
		    @ClienteEspecifico		char(10),
		    @ProveedorEspecifico	char(10),
    		    @AlmacenEspecifico 		char(10)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa			char(5),
    @BackOrders			bit,
    @BackOrdersNivel		char(20),
    @Almacen			char(10),
    @Articulo			char(20), 
    @SubCuenta			varchar(50), 
    @Existencia			float, 
    @ExistenciaConsignacion	float, 
    @ExistenciaReservada	float, 
    @VentasMostrador		float, 
    @Garantias			float, 
    @ActivosFijos		float, 
    @Piezas			float, 
    @PuntoOrden			float, 
    @PuntoOrdenOrdenar		float, 
    @Minimo			float, 
    @Maximo			float, 
    @CompraPendiente		float, 
    @RequsicionesPendientes	float, 
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @VentaPendiente		float, 
    @ProdPendiente		float,
    @CantidadOrdenada		float, 
    @VentaRemisionada		float, 
    @InvPendiente		float,
    @Disponible			float,
    @porSurtir			float,
    @porRecibir			float,
    @porRecibirDisponible	float, 
    @Necesario			float, 
    @Flujo			float, 
    @SugerirNecesario		float, 
    @SugerirPuntoOrden		float, 
    @Sugerencia			float,
    @ClaveProveedor		char(20),
    @UnidadCompra		varchar(50),
    @CompraMinima		float, 
    @Multiplos			int,
    @MultiplosUnidad		varchar(50),
    @Cliente            	char(10),
    @Ok				int,
    @OkRef			varchar(255),
    @CompraSugerirArtR		bit,
    @CompraSugerirUnidadDemanda	bit

  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @CompraID = ISNULL(@CompraID, 0), 
	 @ProveedorEspecifico = NULLIF(RTRIM(@ProveedorEspecifico), ''), 
	 @ClienteEspecifico = NULLIF(RTRIM(@ClienteEspecifico), ''), 
	 @AlmacenEspecifico = NULLIF(RTRIM(@AlmacenEspecifico), '')
  SELECT @Empresa = Empresa FROM Compra WHERE ID = @CompraID
  SELECT @BackOrders = BackOrders, @BackOrdersNivel = ISNULL(NULLIF(RTRIM(UPPER(BackOrdersNivel)), ''), 'CLIENTE') 
    FROM EmpresaCfg 
   WHERE Empresa = @Empresa
  SELECT @CfgMultiUnidades = MultiUnidades, @CfgMultiUnidadesNivel = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'),
         @CompraSugerirArtR = ISNULL(CompraSugerirArtR, 0),
         @CompraSugerirUnidadDemanda = ISNULL(CompraSugerirUnidadDemanda, 0)
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa


  IF @ProveedorEspecifico = '0' SELECT @ProveedorEspecifico = NULL
  IF @ClienteEspecifico   = '0' SELECT @ClienteEspecifico   = NULL
  IF @AlmacenEspecifico   = '0' SELECT @AlmacenEspecifico   = NULL
  IF @CompraID IS NULL RETURN

    DELETE CompraSugerir WHERE Estacion = @Estacion

    IF @BackOrders = 1 AND @BackOrdersNivel = 'MOVIMIENTO'
    BEGIN
      IF @ProveedorEspecifico IS NOT NULL
      BEGIN
        -- Ventas Pendientes
        INSERT CompraSugerir 
               (Estacion, CompraID,  Modulo, ModuloID, Mov,   MovID,   FechaEmision,   FechaRequerida,   Referencia,   Cliente,   Almacen,   Articulo,   SubCuenta,   Precio,   UnidadCompra, ClaveProveedor, CantidadMinima,          Multiplos,    MultiplosUnidad, Cantidad, 		 FactorDemanda, Paquete)
        SELECT @Estacion, @CompraID, 'VTAS',  v.ID,     v.Mov, v.MovID, v.FechaEmision, v.FechaRequerida, v.Referencia, v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, d.Precio, d.Unidad,     ap.Clave,       ap.CompraMinimaCantidad, ap.Multiplos, ap.Unidad,       d.CantidadPendiente, d.Factor,      d.Paquete
          FROM Venta v, VentaD d, MovTipo mt, Art a, ArtProv ap
         WHERE v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus = 'PENDIENTE' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND d.CantidadPendiente > 0 
           AND v.Cliente = ISNULL(@ClienteEspecifico, v.Cliente)
           AND d.Articulo = ap.Articulo AND ISNULL(d.SubCuenta, '') = ap.SubCuenta AND ap.Proveedor = @ProveedorEspecifico
           AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')
           AND d.Articulo = a.Articulo AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')

        -- Inv Pendientes
        INSERT CompraSugerir 
               (Estacion, CompraID,  Modulo, ModuloID, Mov,   MovID,   FechaEmision,   Referencia,   Almacen,   Articulo,   SubCuenta,   UnidadCompra, ClaveProveedor, CantidadMinima,          Multiplos,    MultiplosUnidad, Cantidad, 		  FactorDemanda, Paquete)
        SELECT @Estacion, @CompraID, 'INV',   d.ID,     d.Mov, d.MovID, d.FechaEmision, d.Referencia, d.Almacen, d.Articulo, d.SubCuenta, d.Unidad,     ap.Clave,       ap.CompraMinimaCantidad, ap.Multiplos, ap.Unidad,       d.CantidadPendiente, d.Factor,      d.Paquete
          FROM InvSolicitudPendienteD d, Art a, ArtProv ap
         WHERE d.Empresa = @Empresa AND d.CantidadPendiente > 0 
           AND d.Articulo = ap.Articulo AND ISNULL(d.SubCuenta, '') = ap.SubCuenta AND ap.Proveedor = @ProveedorEspecifico
           AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')
           AND d.Articulo = a.Articulo AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')
      END ELSE
      BEGIN
        INSERT CompraSugerir 
               (Estacion, CompraID,  Modulo, ModuloID, Mov,   MovID,   FechaEmision,   FechaRequerida,   Referencia,   Cliente,   Almacen,   Articulo,   SubCuenta,   Precio,   Cantidad,            UnidadCompra,	FactorDemanda, Paquete)
        SELECT @Estacion, @CompraID, 'VTAS',  v.ID,     v.Mov, v.MovID, v.FechaEmision, v.FechaRequerida, v.Referencia, v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, d.Precio, d.CantidadPendiente, d.Unidad,		d.Factor,      d.Paquete
          FROM Venta v, VentaD d, MovTipo mt, Art a--, ArtProv ap
         WHERE v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus = 'PENDIENTE' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND d.CantidadPendiente > 0 
           AND v.Cliente = ISNULL(@ClienteEspecifico, v.Cliente)
         --AND d.Articulo = ap.Articulo AND ISNULL(d.SubCuenta, '') = ap.SubCuenta AND ap.Proveedor = @ProveedorEspecifico
           AND d.Articulo = a.Articulo AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')

        -- Inv Pendientes
        INSERT CompraSugerir 
               (Estacion, CompraID,  Modulo, ModuloID, Mov,   MovID,   FechaEmision,   Referencia,   Almacen,   Articulo,   SubCuenta,   Cantidad,            UnidadCompra, 	FactorDemanda, Paquete)
        SELECT @Estacion, @CompraID, 'INV',   d.ID,    d.Mov, d.MovID, d.FechaEmision, d.Referencia, d.Almacen, d.Articulo, d.SubCuenta, d.CantidadPendiente, d.Unidad,		d.Factor,      d.Paquete
          FROM InvSolicitudPendienteD d, Art a--, ArtProv ap
         WHERE d.Empresa = @Empresa AND d.CantidadPendiente > 0 
         --AND d.Articulo = ap.Articulo AND ISNULL(d.SubCuenta, '') = ap.SubCuenta AND ap.Proveedor = @ProveedorEspecifico
           AND d.Articulo = a.Articulo AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')
      END
      IF @CfgMultiUnidades = 1 AND @CompraSugerirUnidadDemanda = 0
      BEGIN
        IF @CfgMultiUnidadesNivel = 'ARTICULO'	
          UPDATE CompraSugerir
             SET UnidadCompra = a.UnidadCompra,
                 Cantidad = s.Cantidad*ISNULL(NULLIF(s.FactorDemanda, 0.0), 1.0)/ISNULL(NULLIF(u.Factor, 0.0), 1.0)
            FROM CompraSugerir s, Art a, ArtUnidad u
           WHERE Estacion = @Estacion AND CompraID = @CompraID AND s.Articulo = a.Articulo AND a.UnidadCompra = u.Unidad AND a.Articulo = u.Articulo
        ELSE
          UPDATE CompraSugerir
             SET UnidadCompra = a.UnidadCompra,
                 Cantidad = s.Cantidad*ISNULL(NULLIF(s.FactorDemanda, 0.0), 1.0)/ISNULL(NULLIF(u.Factor, 0.0), 1.0)
            FROM CompraSugerir s, Art a, Unidad u
           WHERE Estacion = @Estacion AND CompraID = @CompraID AND s.Articulo = a.Articulo AND a.UnidadCompra = u.Unidad
      END
    END

    IF @BackOrders = 1 AND @BackOrdersNivel = 'CLIENTE'
    BEGIN
      IF @CfgMultiUnidades = 1 AND @CfgMultiUnidadesNivel = 'ARTICULO'
      BEGIN
        IF @ProveedorEspecifico IS NOT NULL
          -- Ventas Pendientes
          INSERT CompraSugerir 
                 (Estacion, CompraID,  Modulo, Cliente,   Almacen,   Articulo,   SubCuenta,   ClaveProveedor, CantidadMinima,          Multiplos,    MultiplosUnidad, UnidadCompra, Cantidad, Paquete )
          SELECT @Estacion, @CompraID, 'VTAS',  v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, ap.Clave,       ap.CompraMinimaCantidad, ap.Multiplos, ap.Unidad,       u.Unidad,     SUM(d.CantidadPendiente*ISNULL(NULLIF(d.Factor, 0.0), 1.0)/ISNULL(NULLIF(u.Factor, 0.0), 1.0)), d.Paquete
            FROM Venta v, VentaD d, MovTipo mt, Art a, ArtUnidad u, ArtProv ap
           WHERE v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus = 'PENDIENTE' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND d.CantidadPendiente > 0 
             AND v.Cliente = ISNULL(@ClienteEspecifico, v.Cliente)
             AND d.Articulo = a.Articulo AND a.UnidadCompra = u.Unidad AND a.Articulo = u.Articulo
             AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')
             AND d.Articulo = ap.Articulo AND ISNULL(d.SubCuenta, '') = ap.SubCuenta AND ap.Proveedor = @ProveedorEspecifico
           GROUP BY v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, u.Unidad, ap.Clave, ap.CompraMinimaCantidad, ap.Multiplos, ap.Unidad, d.Paquete
           ORDER BY v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, u.Unidad, ap.Clave, ap.CompraMinimaCantidad, ap.Multiplos, ap.Unidad, d.Paquete
        ELSE
          INSERT CompraSugerir 
                 (Estacion, CompraID,  Modulo, Cliente,   Almacen,   Articulo,   SubCuenta,   UnidadCompra, Cantidad, Paquete )
          SELECT @Estacion, @CompraID, 'VTAS',  v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, u.Unidad,    SUM(d.CantidadPendiente*ISNULL(NULLIF(d.Factor, 0.0), 1.0)/ISNULL(NULLIF(u.Factor, 0.0), 1.0)), d.Paquete
            FROM Venta v, VentaD d, MovTipo mt, Art a, ArtUnidad u--, ArtProv ap
           WHERE v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus = 'PENDIENTE' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND d.CantidadPendiente > 0 
             AND v.Cliente = ISNULL(@ClienteEspecifico, v.Cliente)
             AND d.Articulo = a.Articulo AND a.UnidadCompra = u.Unidad AND a.Articulo = u.Articulo
             AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')
--           AND d.Articulo = ap.Articulo AND ISNULL(d.SubCuenta, '') = ap.SubCuenta AND ap.Proveedor = @ProveedorEspecifico
           GROUP BY v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, u.Unidad, d.Paquete
           ORDER BY v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, u.Unidad, d.Paquete
      END ELSE
      BEGIN
        IF @ProveedorEspecifico IS NOT NULL
          -- Ventas Pendientes
          INSERT CompraSugerir 
                 (Estacion, CompraID,  Modulo, Cliente,   Almacen,   Articulo,   SubCuenta,   ClaveProveedor, CantidadMinima,          Multiplos,    MultiplosUnidad, UnidadCompra, Cantidad, Paquete )
          SELECT @Estacion, @CompraID, 'VTAS',  v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, ap.Clave,       ap.CompraMinimaCantidad, ap.Multiplos, ap.Unidad,       u.Unidad,     SUM(d.CantidadPendiente*ISNULL(NULLIF(d.Factor, 0.0), 1.0)/ISNULL(NULLIF(u.Factor, 0.0), 1.0)), d.Paquete
            FROM Venta v, VentaD d, MovTipo mt, Art a, Unidad u, ArtProv ap
           WHERE v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus = 'PENDIENTE' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND d.CantidadPendiente > 0 
             AND v.Cliente = ISNULL(@ClienteEspecifico, v.Cliente)
             AND d.Articulo = a.Articulo AND a.UnidadCompra = u.Unidad
             AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')
             AND d.Articulo = ap.Articulo AND ISNULL(d.SubCuenta, '') = ap.SubCuenta AND ap.Proveedor = @ProveedorEspecifico
           GROUP BY v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, u.Unidad, ap.Clave, ap.CompraMinimaCantidad, ap.Multiplos, ap.Unidad, d.Paquete
           ORDER BY v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, u.Unidad, ap.Clave, ap.CompraMinimaCantidad, ap.Multiplos, ap.Unidad, d.Paquete
        ELSE
          INSERT CompraSugerir 
                 (Estacion, CompraID,  Modulo, Cliente,   Almacen,   Articulo,   SubCuenta,   UnidadCompra, Cantidad, Paquete )
          SELECT @Estacion, @CompraID, 'VTAS',  v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, u.Unidad,     SUM(d.CantidadPendiente*ISNULL(NULLIF(d.Factor, 0.0), 1.0)/ISNULL(NULLIF(u.Factor, 0.0), 1.0)), d.Paquete
            FROM Venta v, VentaD d, MovTipo mt, Art a, Unidad u--, ArtProv ap
           WHERE v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus = 'PENDIENTE' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND d.CantidadPendiente > 0 
             AND v.Cliente = ISNULL(@ClienteEspecifico, v.Cliente)
             AND d.Articulo = a.Articulo AND a.UnidadCompra = u.Unidad
             AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')
--           AND d.Articulo = ap.Articulo AND ISNULL(d.SubCuenta, '') = ap.SubCuenta AND ap.Proveedor = @ProveedorEspecifico
           GROUP BY v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, u.Unidad, d.Paquete
           ORDER BY v.Cliente, d.Almacen, d.Articulo, d.SubCuenta, u.Unidad, d.Paquete
      END

      DECLARE crCompraPendiente CURSOR FOR
       SELECT d.Articulo, d.SubCuenta, d.Unidad, d.Almacen, d.Cliente, SUM(d.CantidadPendiente)
         FROM Compra c, CompraD d, MovTipo mt
        WHERE c.ID = d.ID AND c.Empresa = @Empresa AND mt.Mov = c.Mov AND mt.Clave IN ('COMS.O', 'COMS.OG', 'COMS.OI') AND c.Estatus = 'PENDIENTE'
        GROUP BY d.Articulo, d.SubCuenta, d.Unidad, d.Almacen, d.Cliente
        ORDER BY d.Articulo, d.SubCuenta, d.Unidad, d.Almacen, d.Cliente
      OPEN crCompraPendiente
      FETCH NEXT FROM crCompraPendiente INTO @Articulo, @SubCuenta, @UnidadCompra, @Almacen, @Cliente, @CompraPendiente 
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          UPDATE CompraSugerir 
             SET Cantidad = Cantidad - @CompraPendiente
           WHERE Estacion = @Estacion AND CompraID = @CompraID AND Modulo = 'VTAS' AND Cliente = @Cliente
             AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND UnidadCompra = @UnidadCompra
        END
        FETCH NEXT FROM crCompraPendiente INTO @Articulo, @SubCuenta, @UnidadCompra, @Almacen, @Cliente, @CompraPendiente 
      END
      CLOSE crCompraPendiente
      DEALLOCATE crCompraPendiente
    END 

    IF @AlmacenEspecifico IS NOT NULL
      DELETE CompraSugerir WHERE Estacion = @Estacion AND CompraID = @CompraID AND Almacen <> @AlmacenEspecifico

    IF @CompraSugerirArtR = 1
    BEGIN
      IF @ClienteEspecifico IS NULL
      BEGIN
        IF @ProveedorEspecifico IS NOT NULL
          DECLARE crArtR CURSOR FOR
           SELECT r.Articulo, NULLIF(RTRIM(r.SubCuenta), ''), r.Almacen,  
	          ISNULL(r.INV, 0.0), ISNULL(r.CSG, 0.0), ISNULL(r.RESV, 0.0), ISNULL(r.VMOS, 0.0), ISNULL(r.GAR, 0.0), ISNULL(r.AF, 0.0), ISNULL(r.PZA, 0.0), 
	          ISNULL(r.PuntoOrden, 0.0), ISNULL(r.PuntoOrdenOrdenar, 0.0), ISNULL(r.Minimo, 0.0), ISNULL(r.Maximo, 0.0), 
	          ISNULL(r.CompraPendiente, 0.0), ISNULL(r.RequsicionesPendientes, 0.0), ISNULL(r.VentaPendiente, 0.0), ISNULL(r.ProdPendiente, 0.0), ISNULL(r.CantidadOrdenada, 0.0), ISNULL(r.VentaRemisionada, 0.0), ISNULL(r.InvPendiente, 0.0),
                  a.UnidadCompra, ap.Clave, ap.CompraMinimaCantidad, ap.Multiplos, ap.Unidad
             FROM ArtR r, Art a, ArtProv ap
            WHERE r.Empresa = @Empresa AND r.Articulo = a.Articulo AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')
              AND r.Articulo = ap.Articulo AND ISNULL(r.SubCuenta, '') = ap.SubCuenta AND ap.Proveedor = @ProveedorEspecifico
              AND a.Estatus = 'ALTA'
        ELSE
          DECLARE crArtR CURSOR FOR
           SELECT r.Articulo, NULLIF(RTRIM(r.SubCuenta), ''), r.Almacen,  
	          ISNULL(r.INV, 0.0), ISNULL(r.CSG, 0.0), ISNULL(r.RESV, 0.0), ISNULL(r.VMOS, 0.0), ISNULL(r.GAR, 0.0), ISNULL(r.AF, 0.0), ISNULL(r.PZA, 0.0), 
	          ISNULL(r.PuntoOrden, 0.0), ISNULL(r.PuntoOrdenOrdenar, 0.0), ISNULL(r.Minimo, 0.0), ISNULL(r.Maximo, 0.0), 
	          ISNULL(r.CompraPendiente, 0.0), ISNULL(r.RequsicionesPendientes, 0.0), ISNULL(r.VentaPendiente, 0.0), ISNULL(r.ProdPendiente, 0.0), ISNULL(r.CantidadOrdenada, 0.0), ISNULL(r.VentaRemisionada, 0.0), ISNULL(r.InvPendiente, 0.0),
                  a.UnidadCompra, CONVERT(char(20), NULL), 1, 1, a.UnidadCompra
             FROM ArtR r, Art a--, ArtProv ap
            WHERE r.Empresa = @Empresa AND r.Articulo = a.Articulo AND UPPER(a.Tipo) NOT IN ('SERVICIO', 'JUEGO')
              AND a.Estatus = 'ALTA'
            --AND r.Articulo = ap.Articulo AND ISNULL(r.SubCuenta, '') = ap.SubCuenta AND ap.Proveedor = @ProveedorEspecifico

        OPEN crArtR
        FETCH NEXT FROM crArtR INTO @Articulo, @SubCuenta, @Almacen, 
	   		            @Existencia, @ExistenciaConsignacion, @ExistenciaReservada, @VentasMostrador, @Garantias, @ActivosFijos, @Piezas,
	    		            @PuntoOrden, @PuntoOrdenOrdenar, @Minimo, @Maximo,
			            @CompraPendiente, @RequsicionesPendientes, @VentaPendiente, @ProdPendiente, @CantidadOrdenada, @VentaRemisionada, @InvPendiente,
			            @UnidadCompra, @ClaveProveedor, @CompraMinima, @Multiplos, @MultiplosUnidad
                                
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 AND (@AlmacenEspecifico IS NULL OR @Almacen = @AlmacenEspecifico)
          BEGIN
            SELECT @SugerirNecesario = 0.0, @SugerirPuntoOrden = 0.0, @Sugerencia = 0.0, @porSurtir = 0.0
  	    SELECT @Disponible = @Existencia + @ExistenciaConsignacion - @ExistenciaReservada - @VentasMostrador
            SELECT @porRecibir = @CompraPendiente + @RequsicionesPendientes
  	    SELECT @porRecibirDisponible = @porRecibir-@CantidadOrdenada
            IF @BackOrders = 0 
              SELECT @porSurtir = @VentaPendiente + @ProdPendiente + @InvPendiente + @CantidadOrdenada         

            SELECT @Necesario = @porSurtir - @Disponible - @porRecibir
            SELECT @Flujo = @Disponible + /*@porRecibir*/@porRecibirDisponible - @porSurtir
	    IF @Necesario > 0.0 SELECT @SugerirNecesario = @Necesario 
            IF @Flujo <= @PuntoOrden SELECT @SugerirPuntoOrden = @PuntoOrden - @Flujo + @PuntoOrdenOrdenar
            EXEC xpSugerirCompra @Empresa, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Articulo, @SubCuenta, @Almacen, 
                                 @Existencia, @ExistenciaConsignacion, @ExistenciaReservada, @VentasMostrador, @Garantias, @ActivosFijos, @Piezas,
	  	         	 @PuntoOrden, @PuntoOrdenOrdenar, @Minimo, @Maximo,
			         @CompraPendiente, @VentaPendiente, @ProdPendiente, @CantidadOrdenada, @VentaRemisionada, @InvPendiente,
			         @ClaveProveedor, @UnidadCompra, @CompraMinima, @Multiplos, @MultiplosUnidad,
			         @Disponible, @porRecibir, @porRecibirDisponible, @porSurtir, @Necesario, @Flujo, 
  		                 @SugerirNecesario, @SugerirPuntoOrden, @Sugerencia OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

            IF ISNULL(@Sugerencia, 0) <> 0.0
    	      INSERT CompraSugerir (Estacion, CompraID,  Articulo,  SubCuenta,  Almacen,  UnidadCompra,  ClaveProveedor,  CantidadMinima, Multiplos,  MultiplosUnidad,  Cantidad)
                            VALUES (@Estacion, @CompraID, @Articulo, @SubCuenta, @Almacen, @UnidadCompra, @ClaveProveedor, @CompraMinima,  @Multiplos, @MultiplosUnidad, @Sugerencia)
          END
          FETCH NEXT FROM crArtR INTO @Articulo, @SubCuenta, @Almacen, 
	     		              @Existencia, @ExistenciaConsignacion, @ExistenciaReservada, @VentasMostrador, @Garantias, @ActivosFijos, @Piezas,
			              @PuntoOrden, @PuntoOrdenOrdenar, @Minimo, @Maximo,
			              @CompraPendiente, @RequsicionesPendientes, @VentaPendiente, @ProdPendiente, @CantidadOrdenada, @VentaRemisionada, @InvPendiente,
	  	 	              @UnidadCompra, @ClaveProveedor, @CompraMinima, @Multiplos, @MultiplosUnidad
        END -- While
        CLOSE crArtR
        DEALLOCATE crArtR
      END
    END
    DELETE CompraSugerir WHERE Estacion = @Estacion AND CompraID = @CompraID AND ROUND(Cantidad, 4) <= 0.0
END
GO


/**************** spCompraSugerirAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraSugerirAceptar') and type = 'P') drop procedure dbo.spCompraSugerirAceptar
GO             
CREATE PROCEDURE spCompraSugerirAceptar
		    @Estacion		int,
		    @Sucursal		int,
		    @Empresa		char(5),
                    @CompraID		int,
		    @Todo		bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @BackOrders			bit,
    @BackOrdersNivel		char(20),
    @CfgClaveDesarrollo		char(20),
    @CfgCompraCostoSugerido	char(20),
    @Directo			bit,
    @VerDestino			bit,
    @TieneDestino		bit,
    @Proveedor			char(10),
    @ZonaImpuesto		varchar(30),
    @Renglon			float,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @Modulo			char(5),
    @Mov			char(20),
    @MovID			varchar(20),
    @Cliente			char(10),
    @Almacen			char(10),
    @Articulo			char(20),
    @ArtTipo			varchar(20),
    @Codigo			varchar(50),
    @UnidadCompra		varchar(50),
    @ArtGrupo			varchar(50),
    @ArtDescuentoCompra		float,
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @Retencion1			float, 
    @Retencion2			float, 
    @Retencion3			float, 
    @SubCuenta			varchar(50),
    @ServicioArticulo		varchar(20),
    @ServicioSerie		varchar(20),
    @ServicioFecha		datetime,
    @SucursalAlmacen		int,
    @Cantidad			float,
    @CantidadA			float,
    @Costo			float,
    @DescuentoLinea		float,
    @Paquete			int,
    @FechaEntrega		datetime,
    @DescripcionExtra		varchar(100),
    @MovMoneda			char(10),
    @MovTipoCambio		float,
    @CantidadInventario		float,
    @FechaEmision		datetime,
    @CompraMov			varchar(20),
    @Factor                     float

  SET nocount ON
  SELECT @RenglonID = 0, @TieneDestino = 0
  SELECT @Renglon = ISNULL(MAX(Renglon), 0) FROM CompraD WHERE ID = @CompraID
  SELECT @BackOrders = BackOrders,
	 @BackOrdersNivel = ISNULL(NULLIF(RTRIM(UPPER(BackOrdersNivel)), ''), 'CLIENTE'),
         @CfgCompraCostoSugerido = UPPER(CompraCostoSugerido)
    FROM EmpresaCfg 
   WHERE Empresa = @Empresa

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT @CfgClaveDesarrollo = UPPER(ClaveDesarrollo)
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @Directo = Directo, @VerDestino = VerDestino, @Proveedor = Proveedor, @RenglonID = ISNULL(RenglonID, 0), @FechaEntrega = FechaEntrega, @MovMoneda = Moneda, @MovTipoCambio = TipoCambio,
         @FechaEmision = FechaEmision, @CompraMov = Mov
    FROM Compra 
   WHERE ID = @CompraID

  SELECT @ZonaImpuesto = ZonaImpuesto 
    FROM Prov 
   WHERE Proveedor = @Proveedor

--  BEGIN TRANSACTION
    DECLARE crCompraSugerir CURSOR
        FOR SELECT s.Cliente, s.Modulo, s.Mov, s.MovID, s.Almacen, s.Articulo, s.SubCuenta, s.UnidadCompra, s.ServicioArticulo, s.ServicioSerie, s.ServicioFecha, ISNULL(s.Cantidad, 0.0), ISNULL(s.CantidadA, 0.0), a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Retencion1, a.Retencion2, a.Retencion3, a.Tipo, a.Grupo, a.DescuentoCompra, s.Paquete, a.Codigo
              FROM CompraSugerir s, Art a 
             WHERE s.Estacion = @Estacion AND s.CompraID = @CompraID AND s.Articulo = a.Articulo
             ORDER BY s.Articulo
    OPEN crCompraSugerir
    FETCH NEXT FROM crCompraSugerir INTO @Cliente, @Modulo, @Mov, @MovID, @Almacen, @Articulo, @SubCuenta, @UnidadCompra, @ServicioArticulo, @ServicioSerie, @ServicioFecha, @Cantidad, @CantidadA, @Impuesto1, @Impuesto2, @Impuesto3, @Retencion1, @Retencion2, @Retencion3, @ArtTipo, @ArtGrupo, @ArtDescuentoCompra, @Paquete, @Codigo
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @Todo = 1 SELECT @CantidadA = @Cantidad
      IF @@FETCH_STATUS <> -2 AND @CantidadA > 0
      BEGIN
        IF @BackOrders = 0 OR @BackOrdersNivel <> 'MOVIMIENTO' SELECT @Modulo = NULL, @Mov = NULL, @MovID = NULL
        IF @BackOrders = 0 OR @BackOrdersNivel <> 'CLIENTE'    SELECT @Cliente = NULL

        EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
	EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
	EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
        EXEC spTipoImpuesto 'COMS', @CompraID, @CompraMov, @FechaEmision, @Empresa, @Sucursal, @Proveedor, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
	SELECT @Factor =  dbo.fnArtUnidadFactor(@Empresa, @Articulo,@UnidadCompra)
 	EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
        SELECT @SucursalAlmacen = Sucursal FROM Alm WHERE Almacen = @Almacen
        EXEC spVerCosto @SucursalAlmacen, @Empresa, @Proveedor, @Articulo, @SubCuenta, @UnidadCompra, @CfgCompraCostoSugerido, @MovMoneda, @MovTipoCambio, @Costo OUTPUT, 0
        IF @ServicioArticulo IS NOT NULL
          SELECT @DescripcionExtra = @ServicioArticulo + ' - ' + @ServicioSerie + ' - ' + CONVERT(char, @ServicioFecha, 103)
        ELSE SELECT @DescripcionExtra = NULL
        SELECT @DescuentoLinea = @ArtDescuentoCompra
        IF @CfgClaveDesarrollo='INFO' SELECT @DescuentoLinea = ISNULL(Flotante1, 0.0) FROM ArtGrupo WHERE Grupo = @ArtGrupo


      	SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1--, @CantidadA = ROUND(@CantidadA, 4)
        EXEC xpCantidadInventario @Articulo, @SubCuenta, @UnidadCompra, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CantidadA, @CantidadInventario OUTPUT
        INSERT CompraD (Sucursal,  ID,        Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Codigo,  Articulo,  SubCuenta,  Unidad,        Cantidad,   CantidadInventario,  Almacen,  Cliente,  DestinoTipo, Destino, DestinoID, Costo,  DescuentoLinea,  DescripcionExtra,  Impuesto1,  Impuesto2,  Impuesto3,          Retencion1,  Retencion2,  Retencion3,  FechaEntrega,  Paquete)
                VALUES (@Sucursal, @CompraID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Codigo, @Articulo, @SubCuenta, @UnidadCompra, @CantidadA, @CantidadInventario, @Almacen, @Cliente, @Modulo,     @Mov,    @MovID,    @Costo, @DescuentoLinea, @DescripcionExtra, @Impuesto1, @Impuesto2, @Impuesto3*@Factor, @Retencion1, @Retencion2, @Retencion3, @FechaEntrega, @Paquete)
        IF @TieneDestino = 0 AND @BackOrders = 1 AND @BackOrdersNivel = 'MOVIMIENTO' AND @Mov IS NOT NULL SELECT @TieneDestino = 1
      END
      FETCH NEXT FROM crCompraSugerir INTO @Cliente, @Modulo, @Mov, @MovID, @Almacen, @Articulo, @SubCuenta, @UnidadCompra, @ServicioArticulo, @ServicioSerie, @ServicioFecha, @Cantidad, @CantidadA, @Impuesto1, @Impuesto2, @Impuesto3, @Retencion1, @Retencion2, @Retencion3, @ArtTipo, @ArtGrupo, @ArtDescuentoCompra, @Paquete, @Codigo
    END  -- While
    CLOSE crCompraSugerir
    DEALLOCATE crCompraSugerir
    IF @TieneDestino = 1 SELECT /*@Directo = 0, */@VerDestino = 1
    UPDATE Compra SET Directo = @Directo, VerDestino = @VerDestino, RenglonID = @RenglonID WHERE ID = @CompraID
--  COMMIT TRANSACTION
END
GO

/**************** spVentaCteD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaCteD') and type = 'P') drop procedure dbo.spVentaCteD
GO             
CREATE PROCEDURE spVentaCteD
		    @Estacion		int,
		    @Empresa		char(5),
		    @Cliente		char(10),
		    @FechaD		datetime,
		    @FechaA		datetime

--//WITH ENCRYPTION
AS BEGIN
--  BEGIN TRANSACTION
    DELETE VentaCteDLista WHERE Estacion = @Estacion

    INSERT VentaCteDLista (Estacion, ID, Renglon, RenglonSub, Cantidad, Estatus) 
    SELECT /*TOP 1000 */@Estacion, d.ID, d.Renglon, ISNULL(d.RenglonSub, 0), d.Cantidad, 0
      FROM Venta v, VentaD d
     WHERE v.ID = d.ID
       AND v.Empresa = @Empresa
       AND v.Cliente = @Cliente 
       AND v.FechaEmision BETWEEN @FechaD AND @FechaA
       AND d.RenglonTipo NOT IN ('C', 'E')  -- C = Componente del Juego (que no aparezcan ya que despues los va a copiar)
     ORDER BY v.ID DESC
--  COMMIT TRANSACTION
END
GO

/**************** spVentaCteDComponentes ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaCteDComponentes') and type = 'P') drop procedure dbo.spVentaCteDComponentes
GO             
CREATE PROCEDURE spVentaCteDComponentes
			@Sucursal			int,
			@VentaID			int, 
			@VentaDRenglon			float, 
		        @VentaDRenglonSub		int,
		        @VentaDCantidad			float,
		        @MovTipo			char(20),
		        @ID				int,
			@Almacen			char(10),
			@Renglon			float, 
			@RenglonID			int,
                        @CopiarAplicacion		bit = 0,
			@Empresa			varchar(5)	= NULL,
			@CfgSeriesLotesAutoOrden	varchar(20) 	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @Salir 		 bit,
     @CantidadOriginal	 float,
     @RenglonSub	 int,
     @Cantidad		 float,
     @CantidadInventario float,
     @Unidad		 varchar(50),
     @RenglonTipo	 char(1),
     @RenglonD		 float,
     @RenglonDSub	 int,
     @ArtTipo		 varchar(20),
     @Articulo		 varchar(20),
     @Subcuenta		 varchar(50)

  SELECT @Salir = 0, @RenglonSub = 0
  SELECT @CantidadOriginal = ISNULL(Cantidad, 0.0)
    FROM VentaD 
   WHERE ID = @VentaID AND Renglon = @VentaDRenglon AND RenglonSub = @VentaDRenglonSub
 
  IF @CantidadOriginal = 0 RETURN

  DECLARE crJuego CURSOR FOR
     SELECT Cantidad, (@VentaDCantidad*CantidadInventario/NULLIF(@CantidadOriginal, 0.0)), Unidad, RenglonTipo, Renglon, RenglonSub, Articulo, Subcuenta
       FROM VentaD 
      WHERE ID = @VentaID AND Renglon > @VentaDRenglon

  OPEN crJuego 
  FETCH NEXT FROM crJuego INTO @Cantidad, @CantidadInventario, @Unidad, @RenglonTipo, @RenglonD, @RenglonDSub, @Articulo, @Subcuenta
  WHILE @@FETCH_STATUS <> -1 AND @Salir = 0
  BEGIN
    IF @RenglonTipo NOT IN ('C', 'E') SELECT @Salir = 1
    IF @@FETCH_STATUS <> -2 AND @Salir = 0
    BEGIN
      SELECT @ArtTipo = Tipo FROM ART WHERE Articulo = @Articulo
      SELECT @Cantidad = @VentaDCantidad * @Cantidad / @CantidadOriginal
      SELECT @RenglonSub = @RenglonSub + 1
      INSERT VentaD (Sucursal, ID,  Renglon,  RenglonSub,  RenglonID,  RenglonTipo,  Almacen,  Articulo,  Subcuenta,  Cantidad, CantidadInventario, Unidad, Precio,  DescuentoTipo,  DescuentoLinea,  Impuesto1,  Impuesto2,  Impuesto3,  
                     Costo,  ContUso,  Aplica,  AplicaID)
              SELECT @Sucursal, @ID, @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @Almacen, Articulo, Subcuenta, @Cantidad, @CantidadInventario, @Unidad, Precio, DescuentoTipo, DescuentoLinea, Impuesto1, Impuesto2, Impuesto3, 
                CASE WHEN @MovTipo IN ('VTAS.D', 'VTAS.DF', 'VTAS.SD', 'VTAS.DFC') THEN Costo ELSE NULL END, ContUso, CASE WHEN @CopiarAplicacion = 0 THEN NULL ELSE Aplica END, CASE WHEN @CopiarAplicacion = 0 THEN NULL ELSE AplicaID END
                FROM VentaD WHERE ID = @VentaID AND Renglon = @RenglonD AND RenglonSub = @RenglonDSub
      IF @ArtTipo IN  ('Serie', 'Lote')
       EXEC spVentaCteDSerieLote @Empresa, @Sucursal, @CfgSeriesLotesAutoOrden, @ID, @RenglonD, @RenglonID, @VentaID, @Articulo, @SubCuenta, @Cantidad
    END
    FETCH NEXT FROM crJuego INTO @Cantidad, @CantidadInventario, @Unidad, @RenglonTipo, @RenglonD, @RenglonDSub, @Articulo, @Subcuenta
  END  -- While
  CLOSE crJuego 
  DEALLOCATE crJuego 
END
GO


/**************** spVentaCteDSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaCteDSerieLote') and type = 'P') drop procedure dbo.spVentaCteDSerieLote
GO             
CREATE PROCEDURE spVentaCteDSerieLote
			@Empresa			char(5),
			@Sucursal			int,
			@CfgSeriesLotesAutoOrden 	char(20),
            		@ID				int, 
			@VentaDRenglonID 		int,
			@RenglonID			int, 
			@VentaID			int, 
			@Articulo			char(20), 
			@SubCuenta			varchar(50),			
			@CantidadTotal			float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SeriesLotesAutoOrden	char(20),
    @SerieLote			varchar(50),
    @Cantidad			float,
    @CantidadAlterna		float,
    @SumaCantidad		float,
    @Propiedades		varchar(20),
    @Ubicacion			int,
    @ArtCostoInv		float

  SELECT @SeriesLotesAutoOrden = ISNULL(NULLIF(NULLIF(RTRIM(UPPER(SeriesLotesAutoOrden)), ''), '(EMPRESA)'), @CfgSeriesLotesAutoOrden)
    FROM Art 
   WHERE Articulo = @Articulo

  IF @SeriesLotesAutoOrden = 'DESCENDENTE' 
    DECLARE crSerieLoteMov CURSOR FOR
     SELECT SerieLote, Cantidad, CantidadAlterna, Propiedades, Ubicacion, ArtCostoInv
       FROM SerieLoteMov
      WHERE Modulo = 'VTAS' AND ID = @ID AND RenglonID = @VentaDRenglonID AND Articulo = @Articulo
      ORDER BY SerieLote
  ELSE
    DECLARE crSerieLoteMov CURSOR FOR
     SELECT SerieLote, Cantidad, CantidadAlterna, Propiedades, Ubicacion, ArtCostoInv
       FROM SerieLoteMov
      WHERE Modulo = 'VTAS' AND ID = @ID AND RenglonID = @VentaDRenglonID AND Articulo = @Articulo
      ORDER BY SerieLote DESC 	-- A proposito esta al revez

  SELECT @SumaCantidad = 0.0
  OPEN crSerieLoteMov
  FETCH NEXT FROM crSerieLoteMov INTO @SerieLote, @Cantidad, @CantidadAlterna, @Propiedades, @Ubicacion, @ArtCostoInv
  WHILE @@FETCH_STATUS <> -1 AND @SumaCantidad < @CantidadTotal
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @SumaCantidad + @Cantidad > @CantidadTotal 
        SELECT @CantidadAlterna = ((@CantidadTotal - @SumaCantidad)*@CantidadAlterna)/@Cantidad, 
               @Cantidad        = @CantidadTotal - @SumaCantidad       
      INSERT SerieLoteMov (Sucursal, Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, CantidadAlterna, Propiedades, Ubicacion, ArtCostoInv)
      VALUES (@Sucursal, @Empresa, 'VTAS', @VentaID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), @SerieLote, @Cantidad, @CantidadAlterna, @Propiedades, @Ubicacion, @ArtCostoInv)
      SELECT @SumaCantidad = @SumaCantidad + @Cantidad
    END
    FETCH NEXT FROM crSerieLoteMov INTO @SerieLote, @Cantidad, @CantidadAlterna, @Propiedades, @Ubicacion, @ArtCostoInv
  END  -- While
  CLOSE crSerieLoteMov 
  DEALLOCATE crSerieLoteMov 

  RETURN
END
GO

/**************** spVentaCteDAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaCteDAceptar') and type = 'P') drop procedure dbo.spVentaCteDAceptar
GO             
CREATE PROCEDURE spVentaCteDAceptar
	@Sucursal			int, 
	@Estacion			int,
	@VentaID			int,
	@MovTipo			char(20),
	@CopiarAplicacion	bit = 0
--//WITH ENCRYPTION
AS BEGIN
	DECLARE 
		@Empresa					char(5),
		@ID							int,
		@Mov						char(20),
		@MovID						varchar(20),
		@MovReferencia				varchar(50),
		@TieneAlgo					bit,
		@Directo					bit,
		@Cliente					char(10),
		@Renglon					float,
		@RenglonID					int,
		@VentaDRenglon				float,
		@VentaDRenglonID			int,
		@VentaDRenglonSub			int,
		@RenglonTipo				char(1),
		@ZonaImpuesto				varchar(30),
		@Cantidad					float,
		@CantidadInventario			float,
		@Almacen					char(10),
		@Codigo						varchar(50),
		@Articulo					char(20),
		@SubCuenta					varchar(50),
		@Unidad						varchar(50),
		@Precio          			float,
		@DescuentoTipo				char(1),
		@DescuentoLinea				float,
		@Impuesto1					float,
		@Impuesto2					float,
		@Impuesto3					money,
		@DescripcionExtra			varchar(100),
		@Costo						float,
		@ContUso					varchar(20),
		@Aplica						char(20),
		@AplicaID					char(20),
		@Agente						char(10),
		@AgenteD					char(10),
		@Descuento					varchar(30),
		@DescuentoGlobal 			float,
		@FormaPagoTipo				varchar(50),
		@SobrePrecio				float,
		@ArtTipo					varchar(20),
		@Departamento				int,
		@DepartamentoD				int,
		@DescuentoImporte 			float,
		@CfgSeriesLotesAutoOrden	char(20),
		@FechaEmision				datetime,
		@EnviarA					int,
		@VentaMov					varchar(20),
		@VentaMovO					varchar(20),
		@VentaMovID					varchar(20),
		@TipoImpuesto1				varchar(10),
		@TipoImpuesto2				varchar(10),
		@TipoImpuesto3				varchar(10),
		@TipoRetencion1				varchar(10),
		@TipoRetencion2				varchar(10),
		@TipoRetencion3				varchar(10),
		@Retencion1					float,
		@Retencion2					float,
		@Retencion3					float,
		@Factor						float,
		@ContMoneda					varchar(10),        
		@MonedaOrigen				varchar(10),        
		@MonedaDestino				varchar(10),
		@TipoCambioCont				float,
		@TipoCambioOrigen			float,
		@TipoCambioDestino			float,
----------------------------------------------------
		@CantidadVenta				float,
		@Clave   					varchar(20),
		@ClaveID   					varchar(20)

  SELECT @TieneAlgo = 0, @RenglonID = 0

  SELECT @Renglon = ISNULL(MAX(Renglon), 0) 
    FROM VentaD 
   WHERE ID = @VentaID

  /* DEVOLUCIÓN */
  SELECT @VentaMov = Mov, 
		 @FechaEmision = FechaEmision, 
		 @Empresa = Empresa, 
		 @Cliente = Cliente, 
		 @EnviarA = EnviarA, 
		 @Directo = Directo,
		 @RenglonID = ISNULL(RenglonID, 0),
		 @MonedaDestino = Moneda, 
		 @TipoCambioDestino = ISNULL(TipoCambio,1.0)  
    FROM Venta  
   WHERE ID = @VentaID

   SELECT @Clave = Clave 
     FROM MovTipo 
	WHERE MOV = @VentaMov 
	  AND Modulo = 'VTAS'

  SELECT @ZonaImpuesto = ZonaImpuesto 
    FROM Cte 
   WHERE Cliente = @Cliente

  SELECT @CfgSeriesLotesAutoOrden = ISNULL(UPPER(RTRIM(SeriesLotesAutoOrden)), 'NO'), 
		 @ContMoneda = ContMoneda 

    FROM EmpresaCfg
   WHERE Empresa = @Empresa 

  BEGIN TRANSACTION
    DECLARE crVentaCteD CURSOR FOR
     SELECT l.ID, l.CantidadA, (l.CantidadA*d.CantidadInventario/ISNULL(NULLIF(d.Cantidad, 0.0), 1.0)), d.Renglon, d.RenglonSub, d.RenglonID, RenglonTipo, d.Almacen, d.Codigo, d.Articulo, Subcuenta, Unidad, Precio, DescuentoTipo, DescuentoLinea, DescuentoImporte, Impuesto1, Impuesto2, Impuesto3, Costo, d.ContUso, Aplica, AplicaID, d.Agente, d.Departamento, d.TipoImpuesto1, d.TipoImpuesto2, d.TipoImpuesto3, d.TipoRetencion1, d.TipoRetencion2, d.TipoRetencion3, d.Retencion1, d.Retencion2, d.Retencion3, v.Mov ,v.MovID, l.cantidad, mt.Clave
       FROM VentaD d
	   JOIN Venta v ON d.ID = v.ID
	   JOIN MovTipo MT ON V.Mov = MT.Mov AND Modulo = 'VTAS'    
	   JOIN VentaCteDLista l ON d.ID = l.ID AND d.Renglon = l.Renglon AND d.RenglonSub = l.RenglonSub
  LEFT JOIN VentaDevolucion vd ON l.ID = vd.RID AND ISNULL(VD.CantidadA, 0.0) + ISNULL(VD.Cantidad, 0.00) <= ISNULL(VD.Cantidad, 0.00) AND d.Renglon = vd.Renglon
      WHERE l.Estacion = @Estacion AND ISNULL(l.CantidadA, 0.0) > 0 AND d.Cantidad - ISNULL(VD.CantidadA, 0.0) > 0
      ORDER BY l.ID, l.Renglon, l.RenglonSUB

     OPEN crVentaCteD
     FETCH NEXT FROM crVentaCteD INTO @ID, @Cantidad, @CantidadInventario, @VentaDRenglon, @VentaDRenglonSub, @VentaDRenglonID, @RenglonTipo, @Almacen, @Codigo, @Articulo, @Subcuenta, @Unidad, @Precio, @DescuentoTipo, @DescuentoLinea, @DescuentoImporte, @Impuesto1, @Impuesto2, @Impuesto3, @Costo, @ContUso, @Aplica, @AplicaID, @AgenteD, @DepartamentoD, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @Retencion1, @Retencion2, @Retencion3, @VentaMovO, @VentaMovID, @CantidadVenta, @ClaveID
     WHILE @@FETCH_STATUS = 0
     BEGIN
	 	IF @CantidadVenta >= @Cantidad AND @ClaveID <> 'VTAS.D'
		BEGIN
         IF @TieneAlgo = 0 
         BEGIN
           SELECT @TieneAlgo = 1

		   /* FACTURA */
           SELECT @Mov = Mov, 
		          @MovID = MovID, 
				  @MovReferencia = NULLIF(RTRIM(Referencia), ''), 
				  @Agente = Agente, 
				  @Descuento = Descuento, 
				  @DescuentoGlobal = DescuentoGlobal, 
				  @FormaPagoTipo = FormaPagoTipo, 
				  @SobrePrecio = SobrePrecio, 
				  @Departamento = Departamento, 
				  @MonedaOrigen = Moneda, 
				  @TipoCambioOrigen = ISNULL(TipoCambio,1.0)
             FROM Venta 
            WHERE ID = @ID
         END


		 IF @MonedaOrigen <> @MonedaDestino
         BEGIN  

           SELECT @Precio = (@Precio*@TipoCambioOrigen)/@TipoCambioDestino
         END         
		 
		 EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
		 EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
		 EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT

         EXEC spTipoImpuesto 'VTAS', @VentaID, @VentaMov, @FechaEmision, @Empresa, @Sucursal, @Cliente, @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT

      	 SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1

         IF @MovTipo NOT IN ('VTAS.D', 'VTAS.DF','VTAS.SD', 'VTAS.DFC', 'VTAS.DC', 'VTAS.DCR', 'VTAS.B', 'VTAS.SD') 
			SELECT @Costo = NULL

         IF @CopiarAplicacion = 0 
			SELECT @Aplica = NULL, @AplicaID = NULL

         IF @Aplica IS NOT NULL 

			SELECT @Directo = 0

         SELECT @Factor =  dbo.fnArtUnidadFactor(@Empresa, @Articulo, @Unidad) 

		 IF EXISTS (SELECT * FROM VentaDevolucion WHERE RID = @ID AND Renglon = @VentaDRenglon AND RenglonID = @VentaDRenglonID) AND EXISTS (SELECT * FROM VentaDevolucion WHERE ID = @VentaID) /* Ya existe una factura en esa devolución */
		 BEGIN
			IF @Clave = 'VTAS.D'
				UPDATE VentaD SET Cantidad = Cantidad + @Cantidad WHERE ID = @VentaID AND Renglon IN (SELECT RenglonRID FROM VentaDevolucion WHERE RID = @ID AND Renglon = @VentaDRenglon AND RenglonID = @VentaDRenglonID)
		 END
		 ELSE
			 INSERT VentaD (Sucursal,  ID,       Renglon,  RenglonSub,  RenglonID,  RenglonTipo,  Almacen,  Codigo,  Articulo,  Subcuenta,  Unidad, Cantidad,  CantidadInventario,  Precio,  DescuentoTipo,  DescuentoLinea,  DescuentoImporte, Impuesto1,  Impuesto2,  Impuesto3,           Costo,  ContUso,  Aplica,  AplicaID,  Agente,   Departamento,    TipoImpuesto1, TipoImpuesto2,  TipoImpuesto3,  TipoRetencion1,  TipoRetencion2,  TipoRetencion3,  Retencion1,  Retencion2,  Retencion3)
					VALUES (@Sucursal, @VentaID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Almacen, @Codigo, @Articulo, @Subcuenta, @Unidad, @Cantidad, @CantidadInventario, @Precio, @DescuentoTipo, @DescuentoLinea, @DescuentoImporte, @Impuesto1, @Impuesto2, @Impuesto3*@Factor, @Costo, @ContUso, @Aplica, @AplicaID, @AgenteD, @DepartamentoD, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @Retencion1, @Retencion2, @Retencion3)


		 IF EXISTS (SELECT * FROM VentaDevolucion WHERE RID = @ID AND Renglon = @VentaDRenglon AND Articulo = @Articulo) AND EXISTS (SELECT * FROM VentaDevolucion WHERE ID = @VentaID)
		 BEGIN
			IF @Clave = 'VTAS.D' 
				UPDATE VentaDevolucion SET CantidadA = CantidadA + @Cantidad WHERE RID = @ID AND Renglon = @VentaDRenglon AND Articulo = @Articulo
		 END
		 ELSE
		 BEGIN
			IF @Clave = 'VTAS.D'
				INSERT VentaDevolucion (RID, Renglon,	    RenglonRID,	RenglonID, Articulo,  Cantidad,		ID,			CantidadA, Estatus)
								SELECT @ID, @VentaDRenglon, @Renglon,	@VentaDRenglonID, @Articulo, @CantidadVenta,  @VentaID,	@Cantidad,	1	
		 END
							
         EXEC spArtTipo @RenglonTipo, @ArtTipo OUTPUT

         IF @ArtTipo IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA')
           EXEC spVentaCteDSerieLote @Empresa, @Sucursal, @CfgSeriesLotesAutoOrden, @ID, @VentaDRenglonID, @RenglonID, @VentaID, @Articulo, @SubCuenta, @Cantidad
         IF @ArtTipo = 'JUEGO'
           EXEC spVentaCteDComponentes @Sucursal, @ID, @VentaDRenglon, @VentaDRenglonSub, @Cantidad, @MovTipo, @VentaID, @Almacen, @Renglon, @RenglonID, @CopiarAplicacion, @Empresa, @CfgSeriesLotesAutoOrden

         /*	*/
			IF NOT EXISTS (SELECT * FROM VentaOrigenDevolucion WHERE Id = @VentaID AND IdOrigen = @ID AND Empresa = @Empresa)
				INSERT VentaOrigenDevolucion (Empresa,  Modulo, Id,		   ModuloOrigen,  IdOrigen, MovOrigen,  MovIDOrigen)
									  VALUES (@Empresa, 'VTAS', @VentaID,  'VTAS',		  @ID,		@VentaMovO, @VentaMovID)
		 /* */           
       END
	   ELSE
			SELECT 'Tu cantidad es incorrecta'
			
       FETCH NEXT FROM crVentaCteD INTO @ID, @Cantidad, @CantidadInventario, @VentaDRenglon, @VentaDRenglonSub, @VentaDRenglonID, @RenglonTipo, @Almacen, @Codigo, @Articulo, @Subcuenta, @Unidad, @Precio, @DescuentoTipo, @DescuentoLinea, @DescuentoImporte, @Impuesto1, @Impuesto2, @Impuesto3, @Costo, @ContUso, @Aplica, @AplicaID, @AgenteD, @DepartamentoD, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @Retencion1, @Retencion2, @Retencion3, @VentaMovO, @VentaMovID, @CantidadVenta, @ClaveID
     END  -- While

     CLOSE crVentaCteD
     DEALLOCATE crVentaCteD

     IF @TieneAlgo = 1
     BEGIN
       IF @MovReferencia IS NULL 
		SELECT @MovReferencia = RTRIM(@Mov) + ' ' + RTRIM(@MovID)


		UPDATE Venta 
          SET Referencia = @MovReferencia, 
			  Directo = @Directo, 
			  Agente = @Agente, 
			  Descuento = @Descuento, 
			  DescuentoGlobal = @DescuentoGlobal, 
			  FormaPagoTipo = @FormaPagoTipo, 
			  SobrePrecio = @SobrePrecio, 
			  RenglonID = @RenglonID, 
			  Departamento = @Departamento
        WHERE ID = @VentaID
     END
   DELETE VentaCteDLista WHERE Estacion = @Estacion
  COMMIT TRANSACTION
END
GO

/**************** spVentaPendienteAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaPendienteAceptar') and type = 'P') drop procedure dbo.spVentaPendienteAceptar
GO             
CREATE PROCEDURE spVentaPendienteAceptar
                    @Estacion	int,
					@ID		    int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa				char(5),
    @Sucursal				int,
    @Moneda					char(10),
    @TipoCambio				float,
    @Mov					char(20),
    @MovID					varchar(20),
    @MovTipo				char(20),
    @Renglon				float,
    @RenglonID				int,
    @RenglonIDJuego			int,
    @LModulo				char(5),
    @LID					int,
    @LRenglon				float,
    @LRenglonSub			int,
    @LRenglonID				int,
    @FechaEmision			datetime,
    @FechaRequerida			datetime,
    @FechaEntrega			datetime,
    @Codigo					varchar(50),
    @Articulo				char(20),
    @SubCuenta				varchar(50),
    @ProdRuta				varchar(20),
    @Precio					float,
    @DescuentoTipo			char(1),
    @DescuentoLinea			float,		
    @RenglonTipo			char(1),
    @Almacen				char(10),
    @AlmacenEncabezado		char(10),
    @Proveedor				char(10),
    @Cantidad				float,
    @CantidadA				float,
    @CantidadOrdenada		float,
    @CantidadPendiente		float,
    @CantidadReservada		float,
    @CantidadInventario		float,
    @Unidad					varchar(50),
    @DescripcionExtra		varchar(100),
    @PoliticaPrecios		varchar(255),
    @EnviarA				int,
    @Factor					float,
    @Impuesto1				float,
    @Impuesto2				float,
    @Impuesto3				money,
    @Agente					char(10),
    @PrecioMoneda			char(10),
    @PrecioTipoCambio		float,
    @Costo					float,
    @ContUso				varchar(20),
    @OrdenCompra			varchar(50),
	@Tarima					varchar(20)

  SELECT @Renglon = 0.0, 
		 @RenglonID = 0, 
		 @Proveedor = NULL

  SELECT @Empresa = v.Empresa, 
		 @Sucursal = Sucursal, 
		 @Moneda = v.Moneda, 
		 @TipoCambio = v.TipoCambio, 
		 @FechaEmision = v.FechaEmision, 
		 @AlmacenEncabezado = v.Almacen
    FROM Venta v
   WHERE v.ID = @ID

  SELECT @Renglon = ISNULL(MAX(Renglon), 0.0), 
		 @RenglonID = ISNULL(MAX(RenglonID), 0) 
    FROM VentaD 
   WHERE ID = @ID 

  BEGIN TRANSACTION
    DECLARE crLista CURSOR FOR
     SELECT Modulo, ID, Renglon, RenglonSub
       FROM ListaIDRenglon
      WHERE Estacion = @Estacion
      ORDER BY IDInterno

    OPEN crLista
    FETCH NEXT FROM crLista INTO @LModulo, @LID, @LRenglon, @LRenglonSub
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @DescripcionExtra = NULL
        SELECT @Mov = e.Mov, @MovID = e.MovID, @RenglonTipo = RenglonTipo, @LRenglonID = d.RenglonID, @Codigo = d.Codigo, @Articulo = d.Articulo, @SubCuenta = d.SubCuenta, @Almacen = d.Almacen, 
               @CantidadOrdenada = ISNULL(d.Cantidad, 0.0)-ISNULL(d.CantidadCancelada, 0.0), @CantidadPendiente = ISNULL(d.CantidadPendiente, 0.0), @CantidadReservada = ISNULL(d.CantidadReservada, 0.0), @CantidadA = ISNULL(d.CantidadA, 0.0),
               @Cantidad = ISNULL(d.CantidadPendiente, 0.0)+ISNULL(d.CantidadReservada, 0.0), @Unidad = d.Unidad, @Factor = d.Factor, @FechaRequerida = d.FechaRequerida, 
               @DescripcionExtra = d.DescripcionExtra,
               @Precio = d.Precio, @DescuentoTipo = d.DescuentoTipo, @DescuentoLinea = d.DescuentoLinea,
               @Impuesto1 = d.Impuesto1, @Impuesto2 = d.Impuesto2, @Impuesto3 = d.Impuesto3,
               @Agente = d.Agente, @PoliticaPrecios = PoliticaPrecios, @PrecioMoneda = PrecioMoneda, @PrecioTipoCambio = PrecioTipoCambio,
               @Costo = d.Costo, @ContUso = d.ContUso, @MovTipo = mt.Clave, @EnviarA = d.EnviarA, @OrdenCompra = d.OrdenCompra, @Tarima = d.Tarima
          FROM Venta e, VentaD d, MovTipo mt
         WHERE e.ID = d.ID AND d.ID = @LID AND d.Renglon = @LRenglon AND d.RenglonSub = @LRenglonSub
           AND mt.Modulo = 'VTAS' AND mt.Mov = e.Mov

        EXEC xpVentaPendienteAceptarCantidad @CantidadOrdenada, @CantidadPendiente, @CantidadReservada, @CantidadA, @Cantidad OUTPUT
        IF NULLIF(@Cantidad, 0) IS NOT NULL
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1, @CantidadInventario = @Cantidad * @Factor
          IF @RenglonTipo = 'J' SELECT @RenglonIDJuego = @RenglonID ELSE
          IF @RenglonTipo = 'C' SELECT @RenglonID = @RenglonIDJuego

          IF @MovTipo IN ('VTAS.VC', 'VTAS.VCR') SELECT @Almacen = @AlmacenEncabezado

          INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID, RenglonTipo,  Aplica,  AplicaID,  Codigo,  Articulo, SubCuenta,   Almacen,  Cantidad,  Unidad,  Factor,  FechaRequerida,  Impuesto1,  Impuesto2,  Impuesto3,  DescripcionExtra,  Precio,  DescuentoTipo,  DescuentoLinea,  CantidadInventario,  Agente,  PoliticaPrecios,  PrecioMoneda,  PrecioTipoCambio,  EnviarA,  Costo,  ContUso, OrdenCompra, Tarima) 
                 VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Mov,    @MovID,    @Codigo, @Articulo, @SubCuenta, @Almacen, @Cantidad, @Unidad, @Factor, @FechaRequerida, @Impuesto1, @Impuesto2, @Impuesto3, @DescripcionExtra, @Precio, @DescuentoTipo, @DescuentoLinea, @CantidadInventario, @Agente, @PoliticaPrecios, @PrecioMoneda, @PrecioTipoCambio, @EnviarA, @Costo, @ContUso, @OrdenCompra, @Tarima)

          INSERT SerieLoteMov (Empresa, Sucursal, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Propiedades)
          SELECT Empresa, @Sucursal, Modulo, @ID, @RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Propiedades
            FROM SerieLoteMov
           WHERE Modulo = 'VTAS' AND Empresa = @Empresa AND ID = @LID AND RenglonID = @LRenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')

          -- 7242
          INSERT AnexoMovD (Sucursal, Rama, ID, Cuenta, Nombre, Direccion, Icono, Tipo, Orden, Comentario)
          SELECT @Sucursal, 'VTAS', @ID, Cuenta, Nombre, Direccion, Icono, Tipo, Orden, Comentario
            FROM AnexoMovD
           WHERE Rama = 'VTAS' AND ID = @LID AND Cuenta = @Articulo
        END
      END
      FETCH NEXT FROM crLista INTO @LModulo, @LID, @LRenglon, @LRenglonSub
    END -- While
    CLOSE crLista
    DEALLOCATE crLista
       
    UPDATE Venta SET Directo = 0, RenglonID = @RenglonID WHERE ID = @ID 
    DELETE ListaIDRenglon WHERE Estacion = @Estacion
  COMMIT TRANSACTION
  RETURN
END
GO

-- select * from ListaIDRenglon
-- spVentaPendienteGenerar 100, 'DEMO', 0, 'DEMO', '1/1/1'
/**************** spVentaPendienteGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaPendienteGenerar') and type = 'P') drop procedure dbo.spVentaPendienteGenerar
GO             
CREATE PROCEDURE spVentaPendienteGenerar
                    	@Estacion	int,
		    	@Empresa	char(5),
			@Sucursal	int,
		    	@Usuario	char(10),
		   	@FechaEmision	datetime,
			@Mov		char(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Almacen	char(10),
    @Moneda	char(10),    
    @Cliente	char(10),
    @EnviarA	int,
    @Condicion	varchar(50), 
    @Concepto	varchar(50), 
    @Agente	char(10), 
    @Proyecto	varchar(50), 
    @UEN	int,
    @ID		int,
    @Conteo	int

  SELECT @Conteo = 0
  IF NULLIF(NULLIF(RTRIM(@Mov), '0'), '') IS NULL
  SELECT @Mov = VentaFactura 
    FROM EmpresaCfgMov 
   WHERE Empresa = @Empresa

  SELECT ID, Renglon, RenglonSub
    INTO #ListaIDRenglon
    FROM ListaIDRenglon
   WHERE Modulo = 'VTAS'

  DECLARE crListaClientes CURSOR FOR
  SELECT v.Moneda, v.Cliente, v.EnviarA, v.Almacen, v.Condicion, v.Concepto, v.Agente, v.Proyecto, v.UEN
    FROM #ListaIDRenglon l, Venta v
   WHERE l.ID = v.ID
   GROUP BY v.Moneda, v.Cliente, v.EnviarA, v.Almacen, v.Condicion, v.Concepto, v.Agente, v.Proyecto, v.UEN
   ORDER BY v.Moneda, v.Cliente, v.EnviarA, v.Almacen, v.Condicion, v.Concepto, v.Agente, v.Proyecto, v.UEN

  OPEN crListaClientes
  FETCH NEXT FROM crListaClientes INTO @Moneda, @Cliente, @EnviarA, @Almacen, @Condicion, @Concepto, @Agente, @Proyecto, @UEN
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      INSERT Venta (Sucursal,  Empresa,  Mov,  FechaEmision,  Moneda,  TipoCambio,   Almacen,  Cliente,  EnviarA,  Condicion,  Concepto,  Usuario,  Estatus,     Agente,  Proyecto,  UEN)
            SELECT @Sucursal, @Empresa, @Mov, @FechaEmision, @Moneda, m.TipoCambio, @Almacen, @Cliente, @EnviarA, @Condicion, @Concepto, @Usuario, 'CONFIRMAR', @Agente, @Proyecto, @UEN
              FROM Mon m 
             WHERE m.Moneda = @Moneda
      SELECT @ID = SCOPE_IDENTITY()

      DELETE ListaIDRenglon WHERE Estacion = @Estacion
      INSERT ListaIDRenglon (Estacion,  Modulo, ID,  Renglon,  RenglonSub)
      SELECT @Estacion, 'VTAS', l.ID, l.Renglon, l.RenglonSub
        FROM #ListaIDRenglon l, Venta v
       WHERE l.ID = v.ID AND v.Moneda = @Moneda AND v.Cliente = @Cliente AND ISNULL(v.EnviarA, 0) = ISNULL(@EnviarA, 0) AND v.Almacen = @Almacen AND ISNULL(v.Condicion, '') = ISNULL(@Condicion, '') AND ISNULL(v.Concepto, '') = ISNULL(@Concepto, '') AND ISNULL(v.Agente, '') = ISNULL(@Agente, '') AND ISNULL(v.Proyecto, '') = ISNULL(@Proyecto, '') AND ISNULL(v.UEN, 0) = ISNULL(@UEN, 0)
      EXEC spVentaPendienteAceptar @Estacion, @ID
      SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crListaClientes INTO @Moneda, @Cliente, @EnviarA, @Almacen, @Condicion, @Concepto, @Agente, @Proyecto, @UEN
  END -- While
  CLOSE crListaClientes
  DEALLOCATE crListaClientes

  SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+ ' '+RTRIM(@Mov)+'(s), por Confirmar.'
  RETURN
END
GO

/*
 insert listast(Estacion, clave) values (113, 'A1')
exec spPCArtListaAceptar 113, 3
*/

/**************** spPCArtListaAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCArtListaAceptar') and type = 'P') drop procedure dbo.spPCArtListaAceptar
GO             
CREATE PROCEDURE spPCArtListaAceptar
                    @Estacion	int,
		    @ID		int,
                    @ArticuloEsp varchar(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @p                  	int,
    @Sucursal			int,
    @Empresa			char(5),
    @Moneda			char(10),
    @TipoCambio			float,
    @ListaModificar		varchar(20),
    @ListaModificarD		varchar(20),
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @Unidad			varchar(50),
    @Precio			float,
    @Renglon			float,
    @CfgPrecioNivelUnidad	bit,
    @CfgListaModificarDetalle	bit,
    @Monto			float,
    @PC_H2			bit

  SELECT @Sucursal       = Sucursal,
         @Empresa        = Empresa,
         @Moneda         = Moneda,
         @TipoCambio	 = TipoCambio,
         @ListaModificar = ListaModificar,
         @Monto          = Monto
    FROM PC
   WHERE ID = @ID

  SELECT @CfgListaModificarDetalle = ISNULL(PCListaModificarDetalle, 0),
         @CfgPrecioNivelUnidad = ISNULL(PrecioNivelUnidad, 0),
         @PC_H2	= ISNULL(PC_H2, 0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF @CfgListaModificarDetalle = 1 SELECT @ListaModificarD = @ListaModificar ELSE SELECT @ListaModificarD = NULL

  SELECT @Renglon = 0.0
  SELECT @Renglon = ISNULL(MAX(Renglon), 0.0) FROM PCD WHERE ID = @ID 

    IF @Estacion > 0
    BEGIN
      BEGIN TRANSACTION
      DECLARE crLista CURSOR LOCAL FOR
       SELECT Clave
         FROM ListaSt l
        ORDER BY ID

      OPEN crLista
      FETCH NEXT FROM crLista INTO @Articulo
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN         
          SELECT @Renglon = @Renglon + 2048.0, @SubCuenta = NULL
          SELECT @p = CHARINDEX(CHAR(9), @Articulo)
          IF @p>0
            SELECT @SubCuenta = NULLIF(RTRIM(SUBSTRING(@Articulo, @p+1, LEN(@Articulo))), ''),
                   @Articulo  = NULLIF(RTRIM(SUBSTRING(@Articulo, 1, @p-1)), '')

          IF @PC_H2 = 1
            INSERT PCD (ID,  Renglon,                                              Articulo,  SubCuenta,                       Unidad,                     Monto,  ListaModificar) 
                 SELECT @ID, @Renglon+ROW_NUMBER() OVER (order by ListaModificar), @Articulo, ISNULL(s.SubCuenta, @SubCuenta), ISNULL(u.Unidad, a.Unidad), @Monto, ISNULL(lm.ListaModificar, @ListaModificarD)
                   FROM Art a
                   LEFT OUTER JOIN ArtUnidad u ON u.Articulo = a.Articulo
                   LEFT OUTER JOIN ArtSub s ON s.Articulo = a.Articulo
                   LEFT OUTER JOIN PCListaModificar lm ON lm.ID = @ID
                  WHERE a.Articulo = @Articulo
          ELSE
          IF @CfgPrecioNivelUnidad = 1
          BEGIN
            /*IF EXISTS(SELECT * FROM ArtUnidad WHERE Articulo = @Articulo)
              INSERT PCD (ID,  Renglon,  Articulo, Unidad) 
                   SELECT @ID, @Renglon, @Articulo, Unidad
                     FROM ArtUnidad
                    WHERE Articulo = @Articulo
            ELSE*/
              INSERT PCD (ID,  Renglon,                                              Articulo,  SubCuenta,  Unidad,   Monto,  ListaModificar) 
                   SELECT @ID, @Renglon+ROW_NUMBER() OVER (order by ListaModificar), @Articulo, @SubCuenta, a.Unidad, @Monto, ISNULL(lm.ListaModificar, @ListaModificarD)
                     FROM Art a
                     LEFT OUTER JOIN PCListaModificar lm ON lm.ID = @ID
                    WHERE a.Articulo = @Articulo
          END ELSE
          BEGIN
            IF EXISTS(SELECT * FROM PCListaModificar WHERE ID = @ID)
              INSERT PCD (
                      ID,  Renglon,                                             Articulo,  SubCuenta,  Monto,  ListaModificar) 
              SELECT @ID, @Renglon+ROW_NUMBER() OVER (order by ListaModificar), @Articulo, @SubCuenta, @Monto, ListaModificar
                FROM PCListaModificar
               WHERE ID = @ID
            ELSE
              INSERT PCD (
                      ID,  Renglon,  Articulo,  SubCuenta,  Monto,  ListaModificar) 
              VALUES (@ID, @Renglon, @Articulo, @SubCuenta, @Monto, @ListaModificarD) 
          END
        END
        FETCH NEXT FROM crLista INTO @Articulo
      END -- While
      CLOSE crLista
      DEALLOCATE crLista
      DELETE ListaSt WHERE Estacion = @Estacion
    END

    DECLARE crPCD CURSOR FOR
     SELECT Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), ''), ListaModificar
       FROM PCD
      WHERE ID = @ID
        AND Anterior IS NULL
        --BUG14720
        AND Nuevo IS NULL
      ORDER BY ID

    OPEN crPCD
    FETCH NEXT FROM crPCD INTO @Articulo, @SubCuenta, @Unidad, @ListaModificarD
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @CfgListaModificarDetalle = 0 SELECT @ListaModificarD = @ListaModificar
        EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @Moneda, @TipoCambio, @ListaModificarD, @Precio OUTPUT
        UPDATE PCD SET Nuevo = @Precio, Anterior = @Precio WHERE CURRENT OF crPCD
      END
      FETCH NEXT FROM crPCD INTO @Articulo, @SubCuenta, @Unidad, @ListaModificarD
    END -- While
    CLOSE crPCD
    DEALLOCATE crPCD

    IF @ArticuloEsp IS NOT NULL
      DELETE PCD WHERE ID = @ID AND Articulo = @ArticuloEsp AND NULLIF(RTRIM(SubCuenta), '') IS NULL
  
  IF @Estacion > 0
    COMMIT TRANSACTION
  RETURN
END
GO

/**************** spActivoFijoAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spActivoFijoAsignar') and type = 'P') drop procedure dbo.spActivoFijoAsignar
GO             
CREATE PROCEDURE spActivoFijoAsignar
                    @Estacion	int,
		    @ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon	float,
    @Articulo	char(20),
    @Serie	varchar(50)

  DECLARE crLista CURSOR FOR
   SELECT af.Articulo, af.Serie
     FROM ListaID l, ActivoF af
    WHERE l.ID = af.ID AND l.Estacion = @Estacion
    ORDER BY l.ID

  SELECT @Renglon = ISNULL(MAX(Renglon), 0) FROM ActivoFijoD WHERE ID = @ID
  OPEN crLista
  FETCH NEXT FROM crLista INTO @Articulo, @Serie
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048.0

      INSERT ActivoFijoD (ID,  Renglon,  Articulo,  Serie) 
                  VALUES (@ID, @Renglon, @Articulo, @Serie) 
    END
    FETCH NEXT FROM crLista INTO @Articulo, @Serie
  END -- While
  CLOSE crLista
  DEALLOCATE crLista
  DELETE ListaID WHERE Estacion = @Estacion
END
GO

-- spArtDisponibleAsignar 100, 5, 'DEMO', 'STOCK', 1
/**************** spArtDisponibleAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtDisponibleAsignar') and type = 'P') drop procedure dbo.spArtDisponibleAsignar
GO             
CREATE PROCEDURE spArtDisponibleAsignar
                    @Estacion		int,
		    @ID			int,
		    @Empresa		char(5),
		    @Almacen		char(10),
                    @ConDisponible	bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p			int,
    @Renglon		float,
    @RenglonID		int,
    @Clave		varchar(100),
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Cantidad		float,
    @RenglonTipo	char(1),
    @ArtTipo		varchar(20),
    @ArtUnidad		varchar(50)

  DECLARE crLista CURSOR FOR
   SELECT Clave
     FROM ListaSt
    WHERE Estacion = @Estacion
    ORDER BY ID

  SELECT @Renglon = ISNULL(MAX(Renglon), 0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM InvD WHERE ID = @ID
  OPEN crLista
  FETCH NEXT FROM crLista INTO @Clave
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @p = CHARINDEX(CHAR(9), @Clave)
      IF @p > 0
      BEGIN
        SELECT @Articulo = RTRIM(SUBSTRING(@Clave, 1, @p-1)),
               @SubCuenta = RTRIM(SUBSTRING(@Clave, @p+1, LEN(@Clave)))
        SELECT @Cantidad = NULL
        IF @ConDisponible = 1 
          SELECT @Cantidad = SUM(Disponible)  
            FROM ArtSubDisponible 
           WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Almacen = @Almacen

        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
        SELECT @ArtTipo = Tipo, @ArtUnidad = Unidad FROM Art WHERE Articulo = @Articulo
        EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
        INSERT InvD (ID,  Renglon,  RenglonTipo,  RenglonID,  Articulo,  SubCuenta,  Almacen,  Cantidad,  Unidad) 
             VALUES (@ID, @Renglon, @RenglonTipo, @RenglonID, @Articulo, @SubCuenta, @Almacen, @Cantidad, @ArtUnidad) 
      END
    END
    FETCH NEXT FROM crLista INTO @Clave
  END -- While
  CLOSE crLista
  DEALLOCATE crLista
  UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @ID
  DELETE ListaSt WHERE Estacion = @Estacion
END
GO

-- spArtExistenciaProrratear 100, 5, 'DEMO', 'STOCK', 1
/**************** spArtExistenciaProrratear ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtExistenciaProrratear') and type = 'P') drop procedure dbo.spArtExistenciaProrratear
GO             
CREATE PROCEDURE spArtExistenciaProrratear
                    @Estacion		int,
		    @ID			int,
		    @Empresa		char(5),
		    @Almacen		char(10),
		    @Importe		money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @p				int,
    @Renglon			float,
    @RenglonID			int,
    @Clave			varchar(100),
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @Cantidad			float,
    @CantidadInventario		float,
    @ZonaImpuesto		varchar(30),
    @RenglonTipo		char(1),
    @ArtTipo			varchar(20),
    @ArtUnidad			varchar(50),
    @Impuesto1			float, 
    @Impuesto2			float, 
    @Impuesto3			float,
    @FechaEmision		datetime,
    @Proveedor			varchar(10),
    @Sucursal			int,
    @Mov			varchar(20),
    @Factor                     float

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  DECLARE crLista CURSOR FOR
   SELECT Clave
     FROM ListaSt
    WHERE Estacion = @Estacion
    ORDER BY ID

  SELECT @Mov = Mov, @FechaEmision = FechaEmision, @Proveedor = Proveedor, @ZonaImpuesto = ZonaImpuesto, @Sucursal = Sucursal FROM Compra WHERE ID = @ID
  DELETE CompraD WHERE ID = @ID
  SELECT @Renglon = ISNULL(MAX(Renglon), 0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM CompraD WHERE ID = @ID
  OPEN crLista
  FETCH NEXT FROM crLista INTO @Clave
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @p = CHARINDEX(CHAR(9), @Clave)
      IF @p > 0
      BEGIN
        SELECT @Articulo = RTRIM(SUBSTRING(@Clave, 1, @p-1)),
               @SubCuenta = RTRIM(SUBSTRING(@Clave, @p+1, LEN(@Clave)))
        SELECT @Cantidad = NULL
        SELECT @Cantidad = SUM(Inventario)  
          FROM ArtSubExistenciaInv
         WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Almacen = @Almacen

        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
        SELECT @ArtTipo = Tipo, @ArtUnidad = Unidad, @Impuesto1 = Impuesto1, @Impuesto2 = Impuesto2, @Impuesto3 = Impuesto3 FROM Art WHERE Articulo = @Articulo

        EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
	EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
	EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
        EXEC spTipoImpuesto 'COMS', @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Proveedor, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
        SELECT @Factor =  dbo.fnArtUnidadFactor(@Empresa, @Articulo,@ArtUnidad)
        EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
        EXEC xpCantidadInventario @Articulo, @SubCuenta, @ArtUnidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
        INSERT CompraD (ID,  Renglon,  RenglonTipo,  RenglonID,  Articulo,  SubCuenta,  Almacen,  Cantidad,  Unidad,     CantidadInventario,  Impuesto1,  Impuesto2,  Impuesto3) 
                VALUES (@ID, @Renglon, @RenglonTipo, @RenglonID, @Articulo, @SubCuenta, @Almacen, @Cantidad, @ArtUnidad, @CantidadInventario, @Impuesto1, @Impuesto2, @Impuesto3*@Factor) 
      END
    END
    FETCH NEXT FROM crLista INTO @Clave
  END -- While
  CLOSE crLista
  DEALLOCATE crLista
  SELECT @Cantidad = SUM(Cantidad) FROM CompraD WHERE ID = @ID
  UPDATE CompraD SET Costo = @Importe / @Cantidad WHERE ID = @ID

  UPDATE Compra SET RenglonID = @RenglonID WHERE ID = @ID
  DELETE ListaSt WHERE Estacion = @Estacion
END
GO

/**************** spCompraDAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraDAsignar') and type = 'P') drop procedure dbo.spCompraDAsignar
GO             
CREATE PROCEDURE spCompraDAsignar
                    @Estacion	int,
		    @ID		int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Mov			char(20),
    @MovID			varchar(20),
    @Renglon			float,
    @RenglonID			int,
    @LModulo			char(5),
    @LID			int,
    @LRenglon			float,
    @LRenglonSub		int,
    @FechaEmision		datetime,
    @FechaRequerida		datetime,
    @FechaEntrega		datetime,
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @Costo			float,
    @ContUso			char(20),
    @DescuentoTipo		char(1),
    @DescuentoLinea		float,
    @DescuentoImporte		float,
    @Paquete			int,
    @RenglonTipo		char(1),
    @Almacen			char(10),
    @Proveedor			char(10),
    @Cantidad			float,
    @CantidadInventario		float,
    @Unidad			varchar(50),
    @DescripcionExtra		varchar(100),
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @Retencion1			float,
    @Retencion2			float,
    @Retencion3			float

  SELECT @Renglon = 0.0, @RenglonID = 0, @Proveedor = NULL, @Mov = NULL, @MovID = NULL
  SELECT @Renglon = ISNULL(MAX(Renglon), 0.0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM VentaD WHERE ID = @ID 

  BEGIN TRANSACTION
    DECLARE crLista CURSOR FOR
     SELECT Modulo, ID, Renglon, RenglonSub
       FROM ListaIDRenglon
      WHERE Estacion = @Estacion
      ORDER BY IDInterno

    OPEN crLista
    FETCH NEXT FROM crLista INTO @LModulo, @LID, @LRenglon, @LRenglonSub
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Mov IS NULL
          SELECT @Mov = Mov, @MovID = MovID FROM Compra WHERE ID = @LID
        SELECT @DescripcionExtra = NULL
        SELECT @RenglonTipo = RenglonTipo, @Articulo = d.Articulo, @SubCuenta = d.SubCuenta, @Almacen = d.Almacen, 
               @Cantidad = ISNULL(d.Cantidad, 0.0)-ISNULL(d.CantidadCancelada, 0.0), @Unidad = d.Unidad, @FechaRequerida = d.FechaRequerida, 
               @DescripcionExtra = d.DescripcionExtra,
               @Costo = d.Costo, @DescuentoTipo = d.DescuentoTipo, @DescuentoLinea = d.DescuentoLinea, @DescuentoImporte = d.DescuentoImporte,
               @Impuesto1 = d.Impuesto1, @Impuesto2 = d.Impuesto2, @Impuesto3 = d.Impuesto3,
               @Retencion1 = d.Retencion1, @Retencion2 = d.Retencion2, @Retencion3 = d.Retencion3,
               @CantidadInventario = d.CantidadInventario, @Paquete = d.Paquete, @ContUso = ContUso
          FROM CompraD d
         WHERE d.ID = @LID AND d.Renglon = @LRenglon AND d.RenglonSub = @LRenglonSub

        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

        INSERT CompraD (ID,  Renglon, RenglonSub, RenglonID, RenglonTipo,  Articulo, SubCuenta,   Almacen,  Cantidad,  Unidad,  FechaRequerida,  Impuesto1,  Impuesto2,  Impuesto3,  Retencion1,  Retencion2,  Retencion3,  DescripcionExtra,  Costo,  DescuentoTipo,  DescuentoLinea,  DescuentoImporte,  Paquete,  CantidadInventario, ContUso) 
                VALUES (@ID, @Renglon, 0,        @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Almacen, @Cantidad, @Unidad, @FechaRequerida, @Impuesto1, @Impuesto2, @Impuesto3, @Retencion1, @Retencion2, @Retencion3, @DescripcionExtra, @Costo, @DescuentoTipo, @DescuentoLinea, @DescuentoImporte, @Paquete, @CantidadInventario, @ContUso)
      END
      FETCH NEXT FROM crLista INTO @LModulo, @LID, @LRenglon, @LRenglonSub
    END -- While
    CLOSE crLista
    DEALLOCATE crLista

    UPDATE Compra SET Referencia = RTRIM(@Mov) + ' ' + RTRIM(@MovID) WHERE ID = @ID AND NULLIF(RTRIM(Referencia), '') IS NULL
    DELETE ListaIDRenglon WHERE Estacion = @Estacion
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spCompraGenerarInv ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraGenerarInv') and type = 'P') drop procedure dbo.spCompraGenerarInv
GO             
CREATE PROCEDURE spCompraGenerarInv
		    @ID		int,
		    @Sucursal	int,
	            @Usuario	char(10),
		    @Mov	char(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgCompraFactorDinamico	bit,
    @UnidadCompra		varchar(50),
    @UnidadVenta		varchar(50),
    @Decimales			int,
    @Ok				int,
    @FactorCompra		float,
    @FactorVenta		float,
    @InvID			int,
    @Articulo			char(20), 
    @SubCuenta			varchar(50), 
    @Moneda			char(10), 
    @TipoCambio			float,
    @Unidad			varchar(50),
    @Precio			float,
    @Costo			float,
    @Cantidad			float,
    @CantidadInventario		float

  SELECT @Ok = NULL
  SELECT @CfgMultiUnidades = cfg.MultiUnidades,  
         @CfgMultiUnidadesNivel = ISNULL(UPPER(cfg.NivelFactorMultiUnidad), 'UNIDAD'),
         @CfgCompraFactorDinamico = CompraFactorDinamico
    FROM Compra c, EmpresaCfg2 cfg 
   WHERE c.ID = @ID AND cfg.Empresa = c.Empresa

  BEGIN TRANSACTION
    INSERT Inv (UltimoCambio, Sucursal,  Empresa, Usuario,  Estatus,     Mov,  FechaEmision, Almacen, Proyecto, Moneda, TipoCambio, Referencia, Observaciones, RenglonID)
        SELECT GETDATE(),     @Sucursal, Empresa, Usuario, 'SINAFECTAR', @Mov, FechaEmision, Almacen, Proyecto, Moneda, TipoCambio, Referencia, Observaciones, RenglonID
          FROM Compra 
         WHERE ID = @ID 
    SELECT @InvID = SCOPE_IDENTITY()

    INSERT InvD (Sucursal,  ID,     Renglon, RenglonSub, RenglonID, RenglonTipo, Articulo, SubCuenta, Cantidad, CantidadInventario, Unidad, Factor, Almacen, Costo)
          SELECT @Sucursal, @InvID, Renglon, RenglonSub, RenglonID, RenglonTipo, Articulo, SubCuenta, Cantidad, CantidadInventario, Unidad, Factor, Almacen, SubTotal/NULLIF(Cantidad, 0)
            FROM CompraTCalc
           WHERE ID = @ID

    DECLARE crInvD CURSOR FOR
     SELECT d.Articulo, d.SubCuenta, e.Moneda, e.TipoCambio, d.Unidad, a.Unidad, d.Cantidad, ISNULL(d.CantidadInventario, d.Cantidad), d.Costo
       FROM InvD d, Inv e, Art a
      WHERE d.ID = e.ID AND e.ID = @InvID AND d.Articulo = a.Articulo

    OPEN crInvD
    FETCH NEXT FROM crInvD INTO @Articulo, @SubCuenta, @Moneda, @TipoCambio, @UnidadCompra, @UnidadVenta, @Cantidad, @CantidadInventario, @Costo
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @FactorCompra = 1.0, @FactorVenta = 1.0, @Unidad = @UnidadCompra
        IF @CfgMultiUnidades = 1 AND @CfgCompraFactorDinamico = 0
        BEGIN
          IF @CfgMultiUnidadesNivel = 'ARTICULO'
          BEGIN
            EXEC xpArtUnidadFactor @Articulo, @SubCuenta, @UnidadCompra, @FactorCompra OUTPUT, @Decimales OUTPUT, @OK OUTPUT
            EXEC xpArtUnidadFactor @Articulo, @SubCuenta, @UnidadVenta, @FactorVenta OUTPUT, @Decimales OUTPUT, @OK OUTPUT
          END ELSE
          BEGIN
            EXEC xpUnidadFactor @Articulo, @SubCuenta, @UnidadCompra, @FactorCompra OUTPUT, @Decimales OUTPUT
            EXEC xpUnidadFactor @Articulo, @SubCuenta, @UnidadVenta, @FactorVenta OUTPUT, @Decimales OUTPUT
          END
          IF @FactorCompra <> @FactorVenta
          BEGIN
            SELECT @Unidad = @UnidadVenta,
                   @Cantidad = @Cantidad*@FactorCompra/@FactorVenta,
                   @Costo    = @FactorVenta*@Costo/@FactorCompra
            SELECT @CantidadInventario = @Cantidad*@FactorVenta
          END
        END
        EXEC spVerArtPrecioDescuento @Articulo, @SubCuenta, '(Precio Lista)', @Moneda, @TipoCambio, 1, @Precio OUTPUT
        UPDATE InvD 
           SET Unidad = @Unidad, Cantidad = @Cantidad, CantidadInventario = @CantidadInventario, Costo = @Costo, Precio = @Precio 
         WHERE CURRENT OF crInvD
      END
      FETCH NEXT FROM crInvD INTO @Articulo, @SubCuenta, @Moneda, @TipoCambio, @UnidadCompra, @UnidadVenta, @Cantidad, @CantidadInventario, @Costo
    END -- While
    CLOSE crInvD
    DEALLOCATE crInvD

  COMMIT TRANSACTION
  RETURN
END
GO

/*
declare
  @precio money
   EXEC spVerArtPrecioDescuento 'A1', NULL, '(Precio Lista)', 'Pesos', 1.0, 1, @Precio OUTPUT
select @precio

*/

--spRHModificarEnLote 'DEMO', 14.0, 15.0, 0.0, 'Si'
/**************** spRHModificarEnLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRHModificarEnLote') and type = 'P') drop procedure dbo.spRHModificarEnLote
GO             
CREATE PROCEDURE spRHModificarEnLote
		    @Empresa		char(5),
		    @ID			int,
		    @Porcentaje		float,
		    @Importe		money,
	            @Redondear		char(2),
		    @UsarIncremento	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal			int,
    @Personal			char(10), 
    @Categoria			varchar(50), 
    @Puesto			varchar(50), 
    @AnosCumplidos		int,
    @TipoSueldo			varchar(10),
    @SueldoDiario		money,
    @SueldoDiarioComplemento	money,
    @SueldoBruto		money,
    @SDI			money,
    @Incremento			float,
    @NomComplemento		bit,
    @NomComplementoTope		money,
    @NomComplementoPremios	float,
    @NomDiasMes			float,
    @TopeNeto			money

  SELECT @NomComplemento = ISNULL(NomComplemento, 0),
         @NomComplementoTope = ISNULL(NomComplementoTope, 0.0),
         @NomComplementoPremios = ISNULL(NomComplementoPremios, 0.0),
         @NomDiasMes = ISNULL(NomDiasMes, 30)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @Porcentaje = ISNULL(@Porcentaje, 0),
         @Importe    = ISNULL(@Importe, 0),
         @Redondear  = ISNULL(NULLIF(RTRIM(@Redondear), '0'), 'NO')

  BEGIN TRANSACTION
    DECLARE crRHD CURSOR FOR
     SELECT d.Personal, d.Categoria, d.Puesto, d.SucursalTrabajo, d.TipoSueldo, DATEDIFF(day, d.FechaAntiguedad, GETDATE()) / 365, ISNULL(p.SueldoDiario, 0.0), ISNULL(p.SueldoDiarioComplemento, 0.0), d.Incremento
       FROM RHD d
       JOIN Personal p ON p.Personal = d.Personal
      WHERE d.ID = @ID
    OPEN crRHD
    FETCH NEXT FROM crRHD INTO @Personal, @Categoria, @Puesto, @Sucursal, @TipoSueldo, @AnosCumplidos, @SueldoDiario, @SueldoDiarioComplemento, @Incremento
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @UsarIncremento = 1 
          SELECT @Porcentaje = @Incremento

        IF @Importe <> 0.0
          SELECT @SueldoDiario = @Importe
        ELSE 
        BEGIN
          IF @NomComplemento = 1 AND @SueldoDiarioComplemento > 0.0
          BEGIN
            SELECT @SueldoBruto = ((@SueldoDiario * (1+(ISNULL(@NomComplementoPremios, 0)/100.0))) + @SueldoDiarioComplemento) * @NomDiasMes
            SELECT @SueldoBruto = @SueldoBruto * (1+(ISNULL(@Porcentaje, 0)/100.0))
            SELECT @TopeNeto = @NomComplementoTope / (1+(ISNULL(@NomComplementoPremios, 0)/100.0))
            IF @SueldoBruto > @TopeNeto
              SELECT @SueldoDiario = @TopeNeto / @NomDiasMes,
                     @SueldoDiarioComplemento = (@SueldoBruto - @NomComplementoTope) / @NomDiasMes
            ELSE
              SELECT @SueldoDiario = @SueldoBruto / @NomDiasMes, @SueldoDiarioComplemento = 0.0
          END ELSE
            SELECT @SueldoDiario = @SueldoDiario * (1+(ISNULL(@Porcentaje, 0)/100.0))
        END

        IF UPPER(@Redondear) <> 'NO'
          SELECT @SueldoDiario = ROUND(@SueldoDiario, 0),
                 @SueldoDiarioComplemento = ROUND(@SueldoDiarioComplemento, 0)

        EXEC spVerSDI @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, @AnosCumplidos, @SueldoDiario, @TipoSueldo, 1, @SDI OUTPUT
        UPDATE RHD 
           SET SueldoDiario = @SueldoDiario, 
               SueldoDiarioComplemento = @SueldoDiarioComplemento,
               SDI = @SDI 
         WHERE CURRENT OF crRHD
      END
      FETCH NEXT FROM crRHD INTO @Personal, @Categoria, @Puesto, @Sucursal, @TipoSueldo, @AnosCumplidos, @SueldoDiario, @SueldoDiarioComplemento, @Incremento
    END -- While
    CLOSE crRHD
    DEALLOCATE crRHD

  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spRHSugerirMinimosProfesionales ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRHSugerirMinimosProfesionales') and type = 'P') drop procedure dbo.spRHSugerirMinimosProfesionales
GO             
CREATE PROCEDURE spRHSugerirMinimosProfesionales
		    @ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Personal		char(10),
    @ZonaEconomica	varchar(30),
    @SueldoDiario	money,
    @NuevoSueldo	money,
    @ZonaA		money,
    @ZonaB		money,
    @ZonaC		money,
    @Renglon		float

  SELECT @Renglon = 0
  BEGIN TRANSACTION
    DELETE RHD WHERE ID = @ID
    DECLARE crPersonal CURSOR FOR
     SELECT p.Personal, p.SueldoDiario, RTRIM(p.ZonaEconomica), mp.ZonaA, mp.ZonaB, mp.ZonaC
       FROM Personal p, MinimosProfesionales mp
      WHERE p.MinimoProfesional = mp.Numero
    OPEN crPersonal
    FETCH NEXT FROM crPersonal INTO @Personal, @SueldoDiario, @ZonaEconomica, @ZonaA, @ZonaB, @ZonaC
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @NuevoSueldo = NULL
        IF @ZonaEconomica = 'B' SELECT @NuevoSueldo = @ZonaB ELSE
        IF @ZonaEconomica = 'C' SELECT @NuevoSueldo = @ZonaC 
        ELSE SELECT @NuevoSueldo = @ZonaA
        IF @NuevoSueldo <> @SueldoDiario
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0
          INSERT RHD (ID,  Renglon,  Personal, SueldoDiario, SDI, TipoContrato, PeriodoTipo, Jornada, TipoSueldo, Categoria, Departamento, Puesto, Grupo, FechaAlta, FechaAntiguedad, VencimientoContrato, SucursalTrabajo)
               SELECT @ID, @Renglon, Personal, @NuevoSueldo, SDI, TipoContrato, PeriodoTipo, Jornada, TipoSueldo, Categoria, Departamento, Puesto, Grupo, FechaAlta, FechaAntiguedad, VencimientoContrato, SucursalTrabajo
                 FROM Personal 
                WHERE Personal = @Personal
        END
      END
      FETCH NEXT FROM crPersonal INTO @Personal, @SueldoDiario, @ZonaEconomica, @ZonaA, @ZonaB, @ZonaC
    END
    CLOSE crPersonal
    DEALLOCATE crPersonal
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spSugerirPago ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirPago') and type = 'P') drop procedure dbo.spSugerirPago
GO             
CREATE PROCEDURE spSugerirPago
		    @ID			int,
		    @Empresa		char(5),
		    @Moneda		char(10),
		    @Proveedor		char(10),
		    @Vencimiento	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Maximo		float,
    @Renglon		float,
    @Aplica		char(20),
    @AplicaID		char(20),
    @Importe		money,
    @AbonoMaximo	money,
    @TotalCargos	money,
    @TotalAbonos	money

  SELECT @Maximo = ISNULL(MaximoAplicacionPagos, 0) FROM Prov WHERE Proveedor = @Proveedor
  SELECT @Renglon = 0, @TotalCargos = 0.0, @TotalAbonos = 0.0
  BEGIN TRANSACTION
    DELETE CxpD WHERE ID = @ID
    DECLARE crCxp CURSOR FOR
     --BUG18789
     SELECT fn.Mov, fn.MovID, fn.Saldo 
       FROM dbo.fnCxpInfo(@Empresa, @Proveedor, @Proveedor) fn
       JOIN CxpDMov c ON fn.Mov = c.Mov
      WHERE fn.Moneda = @Moneda AND fn.Vencimiento <= @Vencimiento
      ORDER BY Saldo DESC

    OPEN crCxp
    FETCH NEXT FROM crCxp INTO @Aplica, @AplicaID, @Importe
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Renglon = @Renglon + 2048
        IF @Importe > 0 
          SELECT @TotalCargos = @TotalCargos + @Importe
        ELSE
        BEGIN
          SELECT @AbonoMaximo = @TotalCargos * (@Maximo/100.0)
          IF @TotalAbonos - @Importe > @AbonoMaximo
            SELECT @Importe = -(@AbonoMaximo - @TotalAbonos)

          SELECT @TotalAbonos = @TotalAbonos - @Importe
        END
        
        IF @Importe <> 0.0
          INSERT CxpD (ID,  Renglon,  Aplica,  AplicaID,  Importe)
               VALUES (@ID, @Renglon, @Aplica, @AplicaID, @Importe)
      END
      FETCH NEXT FROM crCxp INTO @Aplica, @AplicaID, @Importe
    END -- While
    CLOSE crCxp
    DEALLOCATE crCxp
    SELECT @Importe = SUM(Importe) FROM CxpD WHERE ID = @ID
    UPDATE Cxp SET Importe = @Importe, Impuestos = NULL, AplicaManual = 1 WHERE ID = @ID
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spGenerarPagos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarPagos') and type = 'P') drop procedure dbo.spGenerarPagos
GO             
CREATE PROCEDURE spGenerarPagos
                    @Estacion		int,
		    @Empresa		char(5),
		    @Sucursal		int,
		    @Usuario		char(10),
                    @Mov		char(20),
		    @Vencimiento	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Afectar		bit,
    @Moneda			char(10),
    @MonedaAnt		char(10),
    @TipoCambio		float,
    @Conteo			int,
    @ID				int,
    @Proveedor		char(10),
    @FechaEmision	datetime

  SELECT @FechaEmision = GETDATE()
  EXEC spExtraerFecha @FechaEmision OUTPUT
  SELECT @Afectar = ISNULL(CxpAfectarPagosAutomaticos, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa

  SELECT @Conteo = 0
  DECLARE crLista CURSOR FOR
   SELECT NULLIF(RTRIM(Clave), '')
     FROM ListaSt 
    WHERE Estacion = @Estacion

  OPEN crLista
  FETCH NEXT FROM crLista INTO @Proveedor
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @MonedaAnt = ''
      WHILE(1=1)
      BEGIN
        SELECT @Moneda = MIN(Moneda)
          FROM Mon
         WHERE Moneda > @MonedaAnt
         
        IF @Moneda IS NULL BREAK
        
        SELECT @MonedaAnt = @Moneda
        
        SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda

        INSERT Cxp (Sucursal,  Empresa,  Mov,  FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      Proveedor,  ProveedorMoneda, ProveedorTipoCambio)
            VALUES (@Sucursal, @Empresa, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'CONFIRMAR',  @Proveedor, @Moneda,         @TipoCambio)
        SELECT @ID = SCOPE_IDENTITY()
        EXEC spSugerirPago @ID, @Empresa, @Moneda, @Proveedor, @Vencimiento
        IF EXISTS(SELECT * FROM CxpD WHERE ID = @ID)
        BEGIN
          IF @Afectar = 1 EXEC spAfectar 'CXP', @ID, @EnSilencio = 1
          SELECT @Conteo = @Conteo + 1
        END ELSE
          DELETE Cxp WHERE ID = @ID      
      END     
    END
    FETCH NEXT FROM crLista INTO @Proveedor
  END -- While
  CLOSE crLista
  DEALLOCATE crLista
  SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+ ' '+RTRIM(@Mov)+'(s)'
END
GO

/**************** spSugerirVentaCobroEfectivo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirVentaCobroEfectivo') and type = 'P') drop procedure dbo.spSugerirVentaCobroEfectivo
GO             
CREATE PROCEDURE spSugerirVentaCobroEfectivo
		    @ID			int,
		    @EnSilencio		bit		= 0,
		    @Saldo		money		= NULL OUTPUT,
		    @Mov		varchar(20)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @Cliente		char(10),
    @Moneda		char(10),
    @OrigenTipo		char(10),
    @Origen		char(20),
    @OrigenID		varchar(20),    
    @Aplicado		money

  SELECT @Saldo = NULL
  SELECT @Empresa = Empresa, @Cliente = Cliente, @Moneda = Moneda, @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID
    FROM Venta
   WHERE ID = @ID

  IF @OrigenTipo = 'VTAS'
  BEGIN
    IF EXISTS(SELECT * FROM Venta v, Condicion c, MovTipo mt WHERE v.Empresa = @Empresa AND v.Mov = @Origen AND v.MovID = @OrigenID AND Cliente = @Cliente AND v.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND v.Condicion = c.Condicion AND UPPER(c.ControlAnticipos) IN ('ABIERTO', 'PLAZOS', 'FECHA REQUERIDA') AND mt.Mov = v.Mov AND mt.Modulo = 'VTAS' and mt.Clave IN ('VTAS.P', 'VTAS.S'))
    BEGIN
      SELECT @Saldo = 0.0
      SELECT @Saldo = ISNULL(SUM(Abono), 0.0)
        FROM Anticipo 
       WHERE Cancelado = 0 AND Empresa = @Empresa AND Cuenta = @Cliente AND Moneda = @Moneda AND Referencia=RTRIM(@Origen)+' '+RTRIM(@OrigenID) And Referencia IS NOT NULL
       
      SELECT @Aplicado = 0.0
      SELECT @Aplicado = ISNULL(SUM(Importe+Impuestos),0.0) 
        FROM Cxc 
       WHERE Empresa=@Empresa AND Cliente=@Cliente AND Moneda=@Moneda AND Referencia=RTRIM(@Origen)+' '+RTRIM(@OrigenID) AND Mov=@Mov And Estatus='CONCLUIDO' AND Referencia IS NOT NULL          
      Select @Saldo = @Saldo - @Aplicado 
    END
  END

  IF @Saldo IS NULL /*OR*/ AND (SELECT VentaSugerirSaldoFavorID FROM EmpresaCfg WHERE Empresa = @Empresa) = 0
    SELECT @Saldo = -ISNULL(Saldo, 0.0) FROM CxcEfectivo WHERE Empresa = @Empresa AND Cliente = @Cliente AND Moneda = @Moneda

  IF @EnSilencio = 0  
    SELECT "Saldo" = @Saldo
  ELSE
    RETURN
END
GO


-- spSugerirVentaCobroEfectivo 45

/*
select * from venta
SELECT ISNULL(SUM(Abono), 0.0)
        FROM Anticipo
       WHERE Cancelado = 0 AND Empresa = 'DEMO' AND Cuenta = 'MEX' AND Moneda = 'Pesos' AND Referencia LIKE 'Pedido 1%'

*/


/**************** spPedidoGenerarINV_OT ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPedidoGenerarINV_OT') and type = 'P') drop procedure dbo.spPedidoGenerarINV_OT
GO             
CREATE PROCEDURE spPedidoGenerarINV_OT
		    @Empresa			char(5),
		    @ID				int,
		    @Sucursal			int,
	            @Usuario			char(10),
		    @InvMov			char(20),
    		    @Almacen			char(10),
    		    @AlmacenDestino		char(10),
		    @BackOrdersMovimiento	bit	
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mov		char(20),
    @MovID		varchar(20),
    @InvID		int,
    @InvMovID		varchar(20),
    @Articulo		char(20), 
    @SubCuenta		varchar(50),
    @DestinoTipo 	char(10),
    @Destino	 	char(20),
    @DestinoID	 	char(20),
    @FechaRegistro	datetime,
    @Ok			int,
    @OkRef		varchar(255)

  SELECT @DestinoTipo = NULL, @Destino = NULL, @DestinoID = NULL, @FechaRegistro = GETDATE(), @Ok = NULL, @OkRef = NULL
  IF @BackOrdersMovimiento = 1 
    SELECT @DestinoTipo = 'VTAS', @Destino = Mov, @DestinoID = MovID
      FROM Venta 
     WHERE ID = @ID

  BEGIN TRANSACTION
    SELECT @Mov = Mov, @MovID = MovID FROM Venta WHERE ID = @ID
    INSERT Inv (OrigenTipo, Origen, OrigenID, UltimoCambio,  Sucursal,  Empresa, Usuario,  Estatus,     Mov,     FechaEmision, Almacen,  AlmacenDestino,  Proyecto, Moneda, TipoCambio, Referencia, Observaciones, FechaRequerida, VerDestino)
        SELECT 'VTAS',      Mov,    MovID,    GETDATE(),     @Sucursal, Empresa, Usuario, 'SINAFECTAR', @InvMov, FechaEmision, @Almacen, @AlmacenDestino, Proyecto, Moneda, TipoCambio, Referencia, Observaciones, FechaRequerida, @BackOrdersMovimiento
          FROM Venta
         WHERE ID = @ID 
    SELECT @InvID = SCOPE_IDENTITY()

    INSERT InvD (Sucursal,  ID,     Renglon,   RenglonSub,   RenglonID,   RenglonTipo,    Articulo,   SubCuenta,   Cantidad,            Unidad,   Precio,   CantidadInventario,                                             Almacen,   FechaRequerida,   DestinoTipo,  Destino,  DestinoID,  DescripcionExtra)
          SELECT @Sucursal, @InvID, d.Renglon, d.RenglonSub, d.RenglonID, ot.RenglonTipo, d.Articulo, d.SubCuenta, d.CantidadPendiente, d.Unidad, d.Precio, d.CantidadPendiente*d.CantidadInventario/NULLIF(d.Cantidad, 0), ot.Origen, d.FechaRequerida, @DestinoTipo, @Destino, @DestinoID, d.DescripcionExtra
            FROM VentaD d, Venta v, #GenerarOT ot
           WHERE v.ID = @ID AND d.ID = v.ID AND d.Renglon = ot.Renglon AND d.RenglonSub = ot.RenglonSub
             AND ot.Origen = @Almacen AND ot.Destino = @AlmacenDestino
  COMMIT TRANSACTION

  EXEC spInv @InvID, 'INV', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, NULL, 
             @InvMov, @InvMovID OUTPUT, NULL, NULL, 
             @Ok OUTPUT, @OkRef OUTPUT, NULL
  EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'VTAS', @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT 
  RETURN
END
GO

/**************** spPedidoGenerarINV_OTm ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPedidoGenerarINV_OTm') and type = 'P') drop procedure dbo.spPedidoGenerarINV_OTm
GO             
CREATE PROCEDURE spPedidoGenerarINV_OTm
		    @Empresa			char(5),
		    @ID				int,
		    @Sucursal			int,
	            @Usuario			char(10),
		    @InvMov			char(20),
    		    @Almacen			char(10),
    		    @AlmacenDestino		char(10),
		    @BackOrdersMovimiento	bit	
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mov		char(20),
    @MovID		varchar(20),
    @InvID		int,
    @InvMovID		varchar(20),
    @Articulo		char(20), 
    @SubCuenta		varchar(50),
    @DestinoTipo 	char(10),
    @Destino	 	char(20),
    @DestinoID	 	char(20),
    @FechaRegistro	datetime,
    @Ok			int,
    @OkRef		varchar(255)

  SELECT @DestinoTipo = NULL, @Destino = NULL, @DestinoID = NULL, @FechaRegistro = GETDATE(), @Ok = NULL, @OkRef = NULL
  IF @BackOrdersMovimiento = 1 
    SELECT @DestinoTipo = 'VTAS', @Destino = Mov, @DestinoID = MovID
      FROM Venta 
     WHERE ID = @ID

  BEGIN TRANSACTION
    SELECT @Mov = Mov, @MovID = MovID FROM Venta WHERE ID = @ID
    INSERT Inv (OrigenTipo, Origen, OrigenID, UltimoCambio,  Sucursal,  Empresa, Usuario,  Estatus,     Mov,     FechaEmision, Almacen,  AlmacenDestino,  Proyecto, Moneda, TipoCambio, Referencia, Observaciones, FechaRequerida, VerDestino)
        SELECT 'VTAS',      Mov,    MovID,    GETDATE(),     @Sucursal, Empresa, Usuario, 'SINAFECTAR', @InvMov, FechaEmision, @Almacen, @AlmacenDestino, Proyecto, Moneda, TipoCambio, Referencia, Observaciones, FechaRequerida, @BackOrdersMovimiento
          FROM Venta
         WHERE ID = @ID 
    SELECT @InvID = SCOPE_IDENTITY()

    INSERT InvD (Sucursal,  ID,     Renglon,   RenglonSub,   RenglonID,   RenglonTipo,    Articulo,   SubCuenta,   Cantidad,            Unidad,   Precio,   CantidadInventario,                                             Almacen,   FechaRequerida,   DestinoTipo,  Destino,  DestinoID,  DescripcionExtra)
          SELECT @Sucursal, @InvID, d.Renglon, d.RenglonSub, d.RenglonID, ot.RenglonTipo, d.Articulo, d.SubCuenta, d.CantidadPendiente, d.Unidad, d.Precio, d.CantidadPendiente*d.CantidadInventario/NULLIF(d.Cantidad, 0), ot.Origen, d.FechaRequerida, @DestinoTipo, @Destino, @DestinoID, d.DescripcionExtra
            FROM VentaD d, Venta v, #GenerarOT ot
           WHERE v.ID = @ID AND d.ID = v.ID AND d.Renglon = ot.Renglon AND d.RenglonSub = ot.RenglonSub
             AND /*ot.Origen = @Almacen AND */ot.Destino = @AlmacenDestino
  COMMIT TRANSACTION

  EXEC spInv @InvID, 'INV', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, NULL, 
             @InvMov, @InvMovID OUTPUT, NULL, NULL, 
             @Ok OUTPUT, @OkRef OUTPUT, NULL
  EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'VTAS', @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT 
  RETURN
END
GO

/**************** spArtAlmacenOrigenOT ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtAlmacenOrigenOT') and type = 'P') drop procedure dbo.spArtAlmacenOrigenOT
GO             
CREATE PROCEDURE spArtAlmacenOrigenOT
		    @Empresa		char(5),
		    @Articulo		char(20),
                    @AlmacenDestino	char(10),
		    @AlmacenOrigen	char(10) 	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @RutaDistribucion	    		varchar(50),
    @RutaDistribucionNivelArticulo	bit,
    @CfgAlmacenOrigenOT                 varchar(30),
    @AlmacenROP                         varchar(10)

  SELECT @AlmacenOrigen = NULL
  SELECT @RutaDistribucion = RutaDistribucion, 
         @RutaDistribucionNivelArticulo = RutaDistribucionNivelArticulo,
         @CfgAlmacenOrigenOT = AlmacenOrigenOT
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT @RutaDistribucion = CASE WHEN @RutaDistribucionNivelArticulo = 1 THEN RutaDistribucion ELSE @RutaDistribucion END,
         @AlmacenROP = AlmacenROP 
    FROM Art
   WHERE Articulo = @Articulo

  IF @CfgAlmacenOrigenOT = 'Ruta Distribucion' OR @AlmacenROP IN (NULL, '(Demanda)')
    SELECT @AlmacenOrigen = AlmacenOrigen
      FROM RutaDistribucionD
     WHERE Ruta = @RutaDistribucion AND AlmacenDestino = @AlmacenDestino
  ELSE
    SELECT @AlmacenOrigen = @AlmacenROP

  RETURN
END
GO

-- spPedidoGenerarOT 'FOTAO', 201, 0, 'COSME', 'Orden Traspaso'
-- spPedidoGenerarOT 'DEMO', 3, 0, 'DEMO', 'Orden Transferencia', @VerID=1
/**************** spPedidoGenerarOT ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPedidoGenerarOT') and type = 'P') drop procedure dbo.spPedidoGenerarOT
GO             
CREATE PROCEDURE spPedidoGenerarOT
		    @Empresa	char(5),
		    @ID		int,
		    @Sucursal	int,
	            @Usuario	char(10),
		    @InvMov	char(20),
		    @EnSilencio	bit	= 0,
		    @VerID	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @GenerarID				int,
    @Mov				char(20),
    @MovID				varchar(20),
    @BackOrdersMovimiento		bit,
    @Conteo				int,
    @Origen				char(10),
    @Destino				char(10),
    @Renglon				float,
    @RenglonSub				int,
    @ArtTipo				varchar(20),
    @Articulo				char(20),
    @SubCuenta				varchar(50),
    @RenglonTipo			char(1),
    @CfgInvMultiAlmacen                 bit

  SELECT @Conteo = 0, @GenerarID = NULL
  CREATE TABLE #GenerarOT (
    Origen	char(10)	COLLATE Database_Default NULL,
    Destino	char(10)	COLLATE Database_Default NULL,
    Renglon	float		NULL,
    RenglonSub	int		NULL,
    RenglonTipo	char(1)		COLLATE Database_Default NULL)

  SELECT @CfgInvMultiAlmacen = InvMultiAlmacen
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF EXISTS(SELECT * FROM EmpresaCfg WHERE Empresa = @Empresa AND BackOrders = 1 AND UPPER(BackOrdersNivel) = 'MOVIMIENTO')
    SELECT @BackOrdersMovimiento = 1
  ELSE 
    SELECT @BackOrdersMovimiento = 0

  SELECT @Mov = Mov, @MovID = MovID FROM Venta WHERE ID = @ID
  IF @BackOrdersMovimiento = 1
  BEGIN
    DECLARE crVentaD CURSOR FOR
     SELECT a.Tipo, d.Articulo, d.SubCuenta, d.Renglon, d.RenglonSub, d.Almacen 
       FROM VentaD d, Art a
      WHERE d.ID = @ID AND a.Articulo = d.Articulo AND ISNULL(d.CantidadPendiente, 0) > 0 AND UPPER(a.Tipo) NOT IN ('JUEGO', 'SERVICIO')

    OPEN crVentaD
    FETCH NEXT FROM crVentaD INTO @ArtTipo, @Articulo, @SubCuenta, @Renglon, @RenglonSub, @Destino
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spArtAlmacenOrigenOT @Empresa, @Articulo, @Destino, @Origen OUTPUT

 	EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
        IF @Origen IS NOT NULL AND @Destino IS NOT NULL
          INSERT #GenerarOT (Renglon,  RenglonSub,  RenglonTipo,  Origen,  Destino) 
                     VALUES (@Renglon, @RenglonSub, @RenglonTipo, @Origen, @Destino)
      END
      FETCH NEXT FROM crVentaD INTO @ArtTipo, @Articulo, @SubCuenta, @Renglon, @RenglonSub, @Destino
    END -- While
    CLOSE crVentaD
    DEALLOCATE crVentaD

    IF @CfgInvMultiAlmacen = 1
    BEGIN  
      DECLARE crGenerarOTm CURSOR FOR
       SELECT Destino
         FROM #GenerarOT
        GROUP BY Destino
        ORDER BY Destino

      OPEN crGenerarOTm
      FETCH NEXT FROM crGenerarOTm INTO @Destino
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @Origen = MIN(Origen) FROM #GenerarOT WHERE Destino = @Destino
          EXEC spPedidoGenerarINV_OTm @Empresa, @ID, @Sucursal, @Usuario, @InvMov, @Origen, @Destino, @BackOrdersMovimiento
          SELECT @Conteo = @Conteo + 1
        END
        FETCH NEXT FROM crGenerarOTm INTO @Destino
      END -- While
      CLOSE crGenerarOTm
      DEALLOCATE crGenerarOTm
    END ELSE
    BEGIN
      DECLARE crGenerarOT CURSOR FOR
       SELECT Origen, Destino
         FROM #GenerarOT
        GROUP BY Origen, Destino
        ORDER BY Origen, Destino

      OPEN crGenerarOT
      FETCH NEXT FROM crGenerarOT INTO @Origen, @Destino
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          EXEC spPedidoGenerarINV_OT @Empresa, @ID, @Sucursal, @Usuario, @InvMov, @Origen, @Destino, @BackOrdersMovimiento
          SELECT @Conteo = @Conteo + 1
        END

        FETCH NEXT FROM crGenerarOT INTO @Origen, @Destino
      END -- While
      CLOSE crGenerarOT
      DEALLOCATE crGenerarOT
    END
  END

  SELECT @GenerarID = ID 
    FROM Inv 
   WHERE Empresa = @Empresa AND OrigenTipo = 'VTAS' AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CANCELADO')

  IF @EnSilencio = 1
    RETURN @GenerarID
  ELSE BEGIN
    IF @VerID = 1
      SELECT @GenerarID
    ELSE
      SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+ ' '+RTRIM(@InvMov)+'(s)'
    RETURN
  END
END
GO

-- spSugerirFechaEntrega '001', 403
/**************** spSugerirFechaEntrega ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirFechaEntrega') and type = 'P') drop procedure dbo.spSugerirFechaEntrega
GO             
CREATE PROCEDURE spSugerirFechaEntrega
		 	@Empresa	char(5),
		    	@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo				int,
    @RutaDistribucion	    		varchar(50),
    @RutaDistribucionNivelArticulo	bit,
    @Origen				char(10),
    @Destino				char(10),
    @Articulo				char(20),
    @SubCuenta				varchar(50),
    @Cantidad				float,
    @Almacen				char(10),
    @Hoy				datetime,
    @Fecha				datetime,
    @FechaEntrega			datetime,
    @TiempoDist				int,
    @TiempoDistU			varchar(50),
    @Tiempo				int,
    @TiempoU				varchar(50)

  SELECT @Hoy = GETDATE()
  SELECT @FechaEntrega = @Hoy
  EXEC spExtraerFecha @FechaEntrega OUTPUT
  SELECT @Conteo = 0
  SELECT @RutaDistribucion = RutaDistribucion, 
         @RutaDistribucionNivelArticulo = RutaDistribucionNivelArticulo 
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  DECLARE crVentaD CURSOR FOR
   SELECT d.Articulo, ISNULL(d.SubCuenta, ''), CASE WHEN v.Estatus = 'PENDIENTE' THEN d.CantidadPendiente ELSE d.Cantidad-ISNULL(d.CantidadCancelada, 0) END, d.Almacen, CASE WHEN @RutaDistribucionNivelArticulo = 1 THEN a.RutaDistribucion ELSE @RutaDistribucion END,
          a.TiempoEntrega, a.TiempoEntregaUnidad
     FROM Venta v, VentaD d, Art a
    WHERE v.ID = @ID AND v.ID = d.ID AND a.Articulo = d.Articulo AND ISNULL(d.CantidadPendiente, 0) > 0 AND UPPER(a.Tipo) NOT IN ('JUEGO', 'SERVICIO')

  OPEN crVentaD
  FETCH NEXT FROM crVentaD INTO @Articulo, @SubCuenta, @Cantidad, @Destino, @RutaDistribucion, @Tiempo, @TiempoU
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Fecha = @Hoy
      SELECT @Origen = NULL
      SELECT @Origen = AlmacenOrigen,
             @TiempoDist = TiempoEntrega,
             @TiempoDistU = TiempoEntregaUnidad
        FROM RutaDistribucionD
       WHERE Ruta = @RutaDistribucion AND AlmacenDestino = @Destino
      IF @Origen IS NOT NULL
      BEGIN
        EXEC spIncTiempo @Fecha, @TiempoDist, @TiempoDistU, @Fecha OUTPUT
        SELECT @Almacen = @Origen 
      END ELSE 
        SELECT @Almacen = @Destino

     IF NOT EXISTS(SELECT * FROM ArtSubDisponible WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Almacen = @Almacen AND ISNULL(Disponible, 0)>=@Cantidad)
       EXEC spIncTiempo @Fecha, @Tiempo, @TiempoU, @Fecha OUTPUT

      IF @Fecha > @FechaEntrega SELECT @FechaEntrega = @Fecha
    END
    FETCH NEXT FROM crVentaD INTO @Articulo, @SubCuenta, @Cantidad, @Destino, @RutaDistribucion, @Tiempo, @TiempoU
  END -- While
  CLOSE crVentaD
  DEALLOCATE crVentaD

  SELECT "FechaEntrega" = @FechaEntrega
  RETURN
END
GO

-- spProrrateoFecha  1, 1, '1/1/1', 'Mensual', 3

/**************** spProrrateoFecha ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProrrateoFecha') and type = 'P') drop procedure dbo.spProrrateoFecha
GO             
CREATE PROCEDURE spProrrateoFecha
		    @Estacion		int,
		    @Total		float,
		    @Fecha		datetime,
		    @Periodicidad	char(20),
		    @Veces		int
			
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cantidad	float

  IF NULLIF(@Veces, 0) IS NULL OR @Veces > 300 RETURN
  DELETE ProrrateoFecha WHERE Estacion = @Estacion
  SELECT @Cantidad = @Total/NULLIF(@Veces, 0)
  WHILE ROUND(@Total, 10) > 0 
  BEGIN
    INSERT ProrrateoFecha (Estacion, Cantidad, Fecha) VALUES (@Estacion, @Cantidad, @Fecha)
    SELECT @Total = @Total - @Cantidad
    IF @Periodicidad = 'QUINCENAL' SELECT @Fecha = @Fecha + 1
    EXEC spCalcularPeriodicidad @Fecha, @Periodicidad, @Fecha OUTPUT, NULL, NULL
  END
  RETURN
END
GO

/**************** spProrrateoFechaAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProrrateoFechaAceptar') and type = 'P') drop procedure dbo.spProrrateoFechaAceptar
GO             
CREATE PROCEDURE spProrrateoFechaAceptar
		    @Estacion	int,
		    @Modulo	char(5),
		    @ID		int,
		    @Renglon	float,
		    @RenglonSub	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo	int,
    @Fecha	datetime,
    @Cantidad	float,
    @Factor	float

  SELECT @Conteo = 0
  IF @Modulo = 'VTAS' SELECT @Factor = CantidadInventario/NULLIF(Cantidad, 0) FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

  DECLARE crProrrateo CURSOR FOR
   SELECT Fecha, Cantidad
     FROM ProrrateoFecha
    WHERE Estacion = @Estacion
    ORDER BY Fecha
  OPEN crProrrateo
  FETCH NEXT FROM crProrrateo INTO @Fecha, @Cantidad
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Modulo = 'VTAS'
      BEGIN
        SELECT @Conteo = @Conteo + 1
        SELECT * INTO #VentaDetalle FROM cVentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        UPDATE #VentaDetalle SET Cantidad = @Cantidad, CantidadInventario = @Cantidad * @Factor, FechaRequerida = @Fecha, Renglon = @Renglon / 2, RenglonSub = @Conteo 
        INSERT INTO cVentaD SELECT * FROM #VentaDetalle
        DROP TABLE #VentaDetalle
      END
    END
    FETCH NEXT FROM crProrrateo INTO @Fecha, @Cantidad
  END -- While
  CLOSE crProrrateo
  DEALLOCATE crProrrateo
  IF @Modulo = 'VTAS' DELETE VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
  RETURN
END
GO

-- spGenerarCOMS_OC 0, 'DEMO', '1/1/1', 'Orden Compra'
/**************** spGenerarCOMS_OC ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCOMS_OC') and type = 'P') drop procedure dbo.spGenerarCOMS_OC
GO             
CREATE PROCEDURE spGenerarCOMS_OC
			@Sucursal	int,
			@Empresa	char(5),
			@Usuario	char(10),
			@FechaTrabajo	datetime,
			@GenerarMov	char(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo		int,
    @Proveedor		char(10), 
    @UltProveedor	char(10), 
    @Agente		char(10),
    @UltAgente		char(10),
    @Almacen		char(10),
    @UltAlmacen		char(10),
    @ID			int,
    @Renglon		float,
    @RenglonSub		int,
    @GenerarID		int, 
    @GenerarRenglon	float,
    @GenerarRenglonID	int,
    @Moneda		char(10),
    @TipoCambio		float,
    @Mov		char(20),
    @MovID		varchar(20),
    @Ok			int,
    @OkRef		varchar(255),
    @Condicion		varchar(50),
    @UsuarioAgente	char(10),
    @ZonaImpuesto	varchar(50), 
    @Impuesto1		float, 
    @Impuesto2		float, 
    @Impuesto3		float,
    @Articulo		varchar(20)

  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0, @UltProveedor = NULL, @UltAgente = NULL, @UltAlmacen = NULL, @GenerarID = NULL, @GenerarRenglon = 0.0, @GenerarRenglonID = 0
  DECLARE crGenerarOC CURSOR FOR
   SELECT ProveedorRef, AgenteRef, c.ID, c.Mov, c.MovID, c.Moneda, c.TipoCambio, c.Almacen, d.Renglon, d.RenglonSub
     FROM Compra c, CompraD d, MovTipo mt
    WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND mt.Modulo = 'COMS' AND mt.Mov = c.Mov AND mt.Clave = 'COMS.R'
      AND d.CantidadPendiente > 0 AND d.CantidadA > 0 AND UPPER(d.EstadoRef) = 'AUTORIZADO'
      AND NULLIF(RTRIM(ProveedorRef), '') IS NOT NULL
      AND c.ID = d.ID
    ORDER BY ProveedorRef, AgenteRef, c.Almacen, c.ID, d.Renglon, d.RenglonSub

  OPEN crGenerarOC
  FETCH NEXT FROM crGenerarOC INTO @Proveedor, @Agente, @ID, @Mov, @MovID, @Moneda, @TipoCambio, @Almacen, @Renglon, @RenglonSub
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      IF @UltProveedor <> @Proveedor OR @UltAgente <> @Agente OR @Almacen <> @UltAlmacen
      BEGIN
        IF @Agente IS NULL SELECT @UsuarioAgente = @Usuario
        ELSE SELECT @UsuarioAgente = ISNULL(NULLIF(RTRIM(MIN(Usuario)), ''), @Usuario) FROM Usuario WHERE DefAgente = @Agente

        SELECT @UltProveedor = @Proveedor, @UltAgente = @Agente, @UltAlmacen = @Almacen
        IF @GenerarID IS NOT NULL
          UPDATE Compra SET RenglonID = @GenerarRenglonID WHERE ID = @GenerarID
          --EXEC spAfectar 'COMS', @GenerarID, @Usuario = @UsuarioAgente, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT*/

        SELECT @Conteo = @Conteo + 1

        SELECT @Condicion = Condicion, 
               @ZonaImpuesto = ZonaImpuesto,
               @Moneda = DefMoneda
          FROM Prov 
         WHERE Proveedor = @Proveedor
        SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda

        EXEC spMovCopiarEncabezado @Sucursal, 'COMS', @ID, @Empresa, @Mov, @MovID, @UsuarioAgente, @FechaTrabajo, 'CONFIRMAR',
	  		           @Moneda, @TipoCambio, @Almacen, NULL,
			           0, @GenerarMov, NULL, 
			           @GenerarID OUTPUT, @Ok OUTPUT, 1

        UPDATE Compra 
           SET Proveedor    = @Proveedor, 
               Agente       = @Agente,
               Condicion    = @Condicion,
               ZonaImpuesto = @ZonaImpuesto
         WHERE ID = @GenerarID
      END
      SELECT @GenerarRenglon = @GenerarRenglon + 2048.0,
             @GenerarRenglonID = @GenerarRenglonID + 1

      SELECT @Articulo = d.Articulo, @Impuesto1 = a.Impuesto1, @Impuesto2 = a.Impuesto2, @Impuesto3 = a.Impuesto3
        FROM CompraD d, Art a
       WHERE d.ID = @ID AND d.Renglon = @Renglon AND d.RenglonSub = @RenglonSub
         AND d.Articulo = a.Articulo

      EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
      EXEC spTipoImpuesto 'COMS', @ID, @Mov, @FechaTrabajo, @Empresa, @Sucursal, @Proveedor, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT

      INSERT CompraD
             (ID, Renglon, RenglonSub, RenglonID, Aplica, AplicaID, RenglonTipo, Cantidad, CantidadInventario, Unidad, Factor, Almacen, Articulo, SubCuenta, FechaRequerida, FechaOrdenar, FechaEntrega, Costo, Impuesto1, Impuesto2, Impuesto3, Retencion1, Retencion2, Retencion3, 
             DescuentoTipo, DescuentoLinea, DescuentoImporte, DescripcionExtra, ReferenciaExtra, ContUso, Cliente, ServicioArticulo, ServicioSerie, Paquete)
      SELECT @GenerarID, @GenerarRenglon, 0, @GenerarRenglonID, @Mov, @MovID, RenglonTipo, CantidadA, CantidadA*Factor, Unidad, Factor, Almacen, Articulo, SubCuenta, FechaRequerida, FechaOrdenar, FechaEntrega, Costo, @Impuesto1, @Impuesto2, @Impuesto3, Retencion1, Retencion2, Retencion3, 
             DescuentoTipo, DescuentoLinea, DescuentoImporte, DescripcionExtra, ReferenciaExtra, ContUso, Cliente, ServicioArticulo, ServicioSerie, Paquete
        FROM CompraD
       WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

      UPDATE CompraD SET CantidadA = NULL, EstadoRef = 'Liberado' WHERE CURRENT OF crGenerarOC
    END
    FETCH NEXT FROM crGenerarOC INTO @Proveedor, @Agente, @ID, @Mov, @MovID, @Moneda, @TipoCambio, @Almacen, @Renglon, @RenglonSub
  END -- While
  CLOSE crGenerarOC
  DEALLOCATE crGenerarOC

  IF @GenerarID IS NOT NULL
    UPDATE Compra SET RenglonID = @GenerarRenglonID WHERE ID = @GenerarID
    --EXEC spAfectar 'COMS', @GenerarID, @Usuario = @UsuarioAgente, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  IF @Ok IN (NULL, 80300)
    SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+ ' Ordenes (por Confirmar)'
  ELSE
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  RETURN
END
GO

/**************** spReabastecer ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReabastecer') and type = 'P') drop procedure dbo.spReabastecer
GO             
CREATE PROCEDURE spReabastecer
			@SucursalOrigen	int,
			@Empresa	char(5),
			@Usuario	char(10),
			@Desde		datetime,
			@Hasta		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal		int,
    @InvID		int,
    @FechaEmision	datetime,
    @Moneda		char(10),
    @TipoCambio		float,
    @AlmacenOrigen	char(10),
    @Almacen		char(10),
    @UltAlmacen		char(10),
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Unidad		varchar(50),
    @Cantidad		float,
    @CantidadInventario	float,
    @RutaDistribucion	varchar(50),
    @OrdenTransferencia	char(20),
    @OrdenTraspaso	char(20),
    @InvMov		char(20),
    @Renglon		float,
    @RenglonID		int,
    @Conteo		int,
    @Ok			int,
    @OkRef		varchar(255)

  SELECT @FechaEmision = GETDATE(), @UltAlmacen = NULL, @Ok = NULL, @OkRef = NULL, @Conteo = 0, @InvID = NULL
  EXEC spExtraerFecha @FechaEmision OUTPUT
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio 
    FROM EmpresaCfg cfg, Mon m 
   WHERE m.Moneda = cfg.ContMoneda AND cfg.Empresa = @Empresa
  SELECT @RutaDistribucion = RutaDistribucion 
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa
  SELECT @OrdenTransferencia = InvOrdenTransferencia,
         @OrdenTraspaso      = InvOrdenTraspaso
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  BEGIN TRANSACTION

    DECLARE crReabastecer CURSOR FOR
     SELECT Almacen, Articulo, SubCuenta, Unidad, SUM(Cantidad), SUM(CantidadInventario) 
       FROM Reabastecer
      WHERE Empresa = @Empresa AND FechaRegistro BETWEEN @Desde AND @Hasta
      GROUP BY Almacen, Articulo, SubCuenta, Unidad
      ORDER BY Almacen, Articulo, SubCuenta, Unidad

    OPEN crReabastecer
    FETCH NEXT FROM crReabastecer INTO @Almacen, @Articulo, @SubCuenta, @Unidad, @Cantidad, @CantidadInventario
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @Almacen <> @UltAlmacen
        BEGIN
          IF @InvID IS NOT NULL UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @InvID
          SELECT @AlmacenOrigen = NULL
          SELECT @AlmacenOrigen = NULLIF(RTRIM(AlmacenOrigen), '')
            FROM RutaDistribucionD
           WHERE Ruta = @RutaDistribucion AND AlmacenDestino = @Almacen
          IF @AlmacenOrigen IS NULL SELECT @Ok = 20395, @OkRef = @Almacen

          IF @Ok IS NULL
          BEGIN
            SELECT @Sucursal = @SucursalOrigen
            SELECT @Sucursal = ISNULL(Sucursal, @SucursalOrigen) FROM Alm WHERE Almacen = @AlmacenOrigen
            IF @Sucursal <> (SELECT Sucursal FROM Alm WHERE Almacen = @Almacen)
              SELECT @InvMov = @OrdenTraspaso
            ELSE
              SELECT @InvMov = @OrdenTransferencia

            INSERT Inv (Sucursal, SucursalOrigen,  Empresa,  Usuario,  Estatus,     Mov,     FechaEmision,  FechaRequerida, Almacen,        AlmacenDestino, Moneda,  TipoCambio)
                SELECT @Sucursal, @SucursalOrigen, @Empresa, @Usuario, 'CONFIRMAR', @InvMov, @FechaEmision, @FechaEmision,  @AlmacenOrigen, @Almacen,       @Moneda, @TipoCambio
            SELECT @InvID = SCOPE_IDENTITY()
            SELECT @Renglon = 0.0, @RenglonID = 0, @Conteo = @Conteo + 1
          END
        END
        IF @Ok IS NULL AND @InvID IS NOT NULL
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
          INSERT InvD (ID,     Renglon,  RenglonSub,  RenglonID,  Almacen,        Articulo,  SubCuenta,  Unidad,  Cantidad,  CantidadInventario,  FechaRequerida)
               VALUES (@InvID, @Renglon, 0,           @RenglonID, @AlmacenOrigen, @Articulo, @SubCuenta, @Unidad, @Cantidad, @CantidadInventario, @FechaEmision)
        END
      END
      FETCH NEXT FROM crReabastecer INTO @Almacen, @Articulo, @SubCuenta, @Unidad, @Cantidad, @CantidadInventario
    END -- While
    CLOSE crReabastecer
    DEALLOCATE crReabastecer
    IF @InvID IS NOT NULL UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @InvID

  IF @Ok IS NULL
  BEGIN
    UPDATE Venta SET Reabastecido = 1 WHERE Empresa = @Empresa AND FechaRegistro BETWEEN @Desde AND @Hasta AND Reabastecido = 0
    UPDATE Inv   SET Reabastecido = 1 WHERE Empresa = @Empresa AND FechaRegistro BETWEEN @Desde AND @Hasta AND Reabastecido = 0
    UPDATE EmpresaGral SET ReabastecidoHasta = @Hasta WHERE Empresa = @Empresa
    COMMIT TRANSACTION
    SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+ ' Ordenes (por Confirmar)'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  END

  RETURN
END
GO

/**************** spEvaluacionCtoEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEvaluacionCtoEliminar') and type = 'P') drop procedure dbo.spEvaluacionCtoEliminar
GO             
CREATE PROCEDURE spEvaluacionCtoEliminar
			@Evaluacion	varchar(50),
			@Fecha		datetime,
			@Contacto	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DELETE EvaluacionCto 
   WHERE Evaluacion = @Evaluacion AND Fecha = @Fecha AND Contacto = @Contacto
  RETURN
END
GO


/**************** spEvaluacionCto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEvaluacionCto') and type = 'P') drop procedure dbo.spEvaluacionCto
GO             
CREATE PROCEDURE spEvaluacionCto
			@Evaluacion	varchar(50),
			@Fecha		datetime,
			@Contacto	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  -- Borrar Puntos Anteriores
  DELETE EvaluacionCto 
   WHERE Evaluacion = @Evaluacion AND Fecha = @Fecha AND Punto NOT IN (SELECT Punto FROM EvaluacionFormato WHERE Evaluacion = @Evaluacion)

  -- Insertar Puntos Nuevos
  INSERT EvaluacionCto (Evaluacion, Punto, Fecha, Contacto)
  SELECT Evaluacion, Punto, @Fecha, @Contacto
    FROM EvaluacionFormato 
   WHERE Evaluacion = @Evaluacion AND Punto NOT IN (SELECT Punto FROM EvaluacionCto WHERE Evaluacion = @Evaluacion AND Fecha = @Fecha AND Contacto = @Contacto)
  RETURN
END
GO

/**************** spTareasCompletarSeleccion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTareasCompletarSeleccion') and type = 'P') drop procedure dbo.spTareasCompletarSeleccion
GO             
CREATE PROCEDURE spTareasCompletarSeleccion
			@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  UPDATE Tarea SET Estado = 'Completada' WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
END
GO

/**************** spTareasPorOmision ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTareasPorOmision') and type = 'P') drop procedure dbo.spTareasPorOmision
GO             
CREATE PROCEDURE spTareasPorOmision
			@Modulo		char(5),
			@ID 		int,
			@Empresa	char(5)  = NULL,
			@Mov		char(20) = NULL,
			@Usuario	char(10) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Hoy	datetime,
    @Clase	varchar(50),
    @SubClase	varchar(50)

  EXEC xpTareasPorOmision @Modulo, @ID, @Empresa, @Mov, @Usuario

  SELECT @Hoy = GETDATE()
  EXEC spExtraerFecha @Hoy OUTPUT

  IF NOT EXISTS(SELECT * FROM Tarea WHERE Modulo = @Modulo AND ModuloID = @ID)
  BEGIN
    IF @Modulo IN ('VTAS', 'ST', 'GAS')
    BEGIN
      IF @Modulo = 'VTAS' SELECT @Clase = NULLIF(RTRIM(Clase), ''), @SubClase = NULLIF(RTRIM(SubClase), '') FROM Venta   WHERE ID = @ID ELSE
      IF @Modulo = 'GAS'  SELECT @Clase = NULLIF(RTRIM(Clase), ''), @SubClase = NULLIF(RTRIM(SubClase), '') FROM Gasto   WHERE ID = @ID ELSE
      IF @Modulo = 'ST'   SELECT @Clase = NULLIF(RTRIM(Clase), ''), @SubClase = NULLIF(RTRIM(SubClase), '') FROM Soporte WHERE ID = @ID

      INSERT Tarea (Empresa, Usuario, Modulo, ModuloID, Orden, Asunto, Tipo, Estado, Vencimiento, Forzosa/*, Tiempo*/) 
      SELECT @Empresa, @Usuario, @Modulo, @ID, t.Orden, t.Tarea, t.Tipo, 'No Comenzada', DATEADD(day, ISNULL(t.Dias, 0), @Hoy), t.Forzosa/*, (SELECT Tiempo FROM Tarea WHERE Tarea = y.Tarea)*/
        FROM ClaseTarea t
       WHERE t.Modulo = @Modulo AND t.Clase = @Clase AND (t.SubClase IS NULL OR t.SubClase = @SubClase)
       GROUP BY t.Orden, t.Tarea, t.Tipo, t.Dias, t.Forzosa
       ORDER BY t.Orden, t.Tarea, t.Tipo, t.Dias, t.Forzosa
    END

    IF EXISTS(SELECT * FROM MovTipoTarea WHERE Modulo = @Modulo AND Mov=@Mov) 
      INSERT Tarea (Empresa, Usuario, Modulo, ModuloID, Orden, Asunto, Tipo, Estado, Vencimiento, Forzosa/*, Tiempo*/) 
      SELECT @Empresa, @Usuario, @Modulo, @ID, t.Orden, t.Tarea, t.Tipo, 'No Comenzada', DATEADD(day, ISNULL(t.Dias, 0), @Hoy), t.Forzosa/*, (SELECT Tiempo FROM Tarea WHERE Tarea = t.Tarea)*/
        FROM MovTipoTarea t
       WHERE t.Modulo = @Modulo AND t.Mov = @Mov
       GROUP BY t.Orden, t.Tarea, t.Tipo, t.Dias, t.Forzosa
       ORDER BY t.Orden, t.Tarea, t.Tipo, t.Dias, t.Forzosa
  END

/*  IF @Modulo = 'VTAS'
  BEGIN
    IF NOT EXISTS(SELECT * FROM ServicioTarea WHERE ID = @ID)
    BEGIN
      SELECT @Clase = NULLIF(RTRIM(Clase), ''), @SubClase = NULLIF(RTRIM(SubClase), '') FROM Venta WHERE ID = @ID
      INSERT ServicioTarea (ID, Tarea, Estado, Fecha, Tiempo) 
      SELECT @ID, c.Tarea, 'No Comenzada', GETDATE(), (SELECT Tiempo FROM Tarea WHERE Tarea = c.Tarea)
        FROM ClaseTarea c
       WHERE c.Modulo = @Modulo AND c.Clase = @Clase AND (c.SubClase IS NULL OR c.SubClase = @SubClase)
       GROUP BY c.Tarea
       ORDER BY c.Tarea
    END
  END ELSE
  IF @Modulo = 'ST'
  BEGIN
    IF NOT EXISTS(SELECT * FROM MovTarea WHERE ID = @ID)
    BEGIN
      SELECT @Clase = NULLIF(RTRIM(Clase), ''), @SubClase = NULLIF(RTRIM(SubClase), '') FROM Soporte WHERE ID = @ID
      INSERT MovTarea (Modulo, ID, Tarea, Estado, Fecha, Tiempo) 
      SELECT @Modulo, @ID, c.Tarea, 'No Comenzada', GETDATE(), (SELECT Tiempo FROM Tarea WHERE Tarea = c.Tarea)
        FROM ClaseTarea c
       WHERE c.Modulo = @Modulo AND c.Clase = @Clase AND (c.SubClase IS NULL OR c.SubClase = @SubClase)
       GROUP BY c.Tarea
       ORDER BY c.Tarea
    END
  END  */
END
GO

/**************** spCompraProrrateoArt ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraProrrateoArt') and type = 'P') drop procedure dbo.spCompraProrrateoArt
GO             
CREATE PROCEDURE spCompraProrrateoArt
			@Estacion	int,
			@Empresa	char(5),
			@ID		int,
			@RenglonID	int,
			@Articulo	char(20),
			@SubCuenta	varchar(20),
			@Cantidad	float,
			@Recalc		bit	= 0,
			@Manual		bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Redondeo	int

  SELECT @SubCuenta = NULLIF(RTRIM(@SubCuenta), '0'), @Cantidad = NULLIF(@Cantidad, 0)
  SELECT @Redondeo = ISNULL(CompraProrrateadaRedondeo, 0) FROM EmpresaCfg WHERE Empresa = @Empresa
  IF @Recalc = 1 OR @Manual = 1 
    DELETE CompraDProrrateo WHERE ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')

  IF @Manual = 1
  BEGIN
    INSERT CompraDProrrateo (ID, RenglonID, Articulo, SubCuenta, Almacen, Cantidad)
    SELECT @ID, @RenglonID, @Articulo, @SubCuenta, RTRIM(s.AlmacenPrincipal), p.Cantidad
      FROM CompraProrrateoManual p, SucursalesDelGrupoConAlm g, Sucursal s
     WHERE p.Estacion = @Estacion AND p.Grupo = g.Grupo AND p.Grupo = s.Grupo AND NULLIF(RTRIM(s.AlmacenPrincipal), '') IS NOT NULL AND s.Estatus = 'ALTA' 
  END ELSE 
  BEGIN
    IF @Cantidad IS NOT NULL AND NOT EXISTS(SELECT * FROM CompraDProrrateo WHERE ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, ''))
    BEGIN    
      IF EXISTS(SELECT * FROM ArtCompraProrrateo WHERE Articulo = @Articulo)
        INSERT CompraDProrrateo (ID, RenglonID, Articulo, SubCuenta, Almacen, Cantidad)
        SELECT @ID, @RenglonID, @Articulo, @SubCuenta, RTRIM(s.AlmacenPrincipal), ROUND(ISNULL(p.Cantidad, 0) + ISNULL(@Cantidad/NULLIF(g.Sucursales, 0)*(p.Porcentaje/100.0), 0), @Redondeo)
          FROM ArtCompraProrrateo p, SucursalesDelGrupoConAlm g, Sucursal s
         WHERE p.Articulo = @Articulo AND p.Grupo = g.Grupo AND p.Grupo = s.Grupo AND NULLIF(RTRIM(s.AlmacenPrincipal), '') IS NOT NULL AND s.Estatus = 'ALTA'
      ELSE
        INSERT CompraDProrrateo (ID, RenglonID, Articulo, SubCuenta, Almacen, Cantidad)
        SELECT @ID, @RenglonID, @Articulo, @SubCuenta, RTRIM(s.AlmacenPrincipal), ROUND(@Cantidad/NULLIF(g.Sucursales, 0)*(p.Porcentaje/100.0), @Redondeo)
          FROM EmpresaCompraProrrateo p, SucursalesDelGrupoConAlm g, Sucursal s
         WHERE p.Empresa = @Empresa AND p.Grupo = g.Grupo AND p.Grupo = s.Grupo AND NULLIF(RTRIM(s.AlmacenPrincipal), '') IS NOT NULL AND s.Estatus = 'ALTA'
    END
  END
  DELETE CompraDProrrateo WHERE ID = @ID AND NULLIF(Cantidad, 0) IS NULL
  RETURN
END
GO

/*
 exec spMovForma 'ST', 1, 'Problema', 0
 select * from movforma
*/

/**************** spMovForma ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovForma') and type = 'P') drop procedure dbo.spMovForma
GO             
CREATE PROCEDURE spMovForma
			@Modulo		char(5),
			@ID		int,
			@Mov		char(20),
			@Sucursal	int
--//WITH ENCRYPTION
AS BEGIN
  DELETE MovForma WHERE Modulo = @Modulo AND ID = @ID AND Mov <> @Mov
  INSERT MovForma (Modulo, ID, Mov, Orden, Sucursal, Campo)
  SELECT Modulo, @ID, Mov, Orden, @Sucursal, Campo 
    FROM MovTipoForma
   WHERE Modulo = @Modulo AND Mov = @Mov AND Campo NOT IN (SELECT Campo FROM MovForma WHERE Modulo = @Modulo AND ID = @ID)
  RETURN
END
GO


/**************** spCRPlantilla ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCRPlantilla') and type = 'P') drop procedure dbo.spCRPlantilla
GO             
CREATE PROCEDURE spCRPlantilla
			@Empresa	char(5),
			@Sucursal	int,
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo		varchar(20),
    @Agente		varchar(10),
    @FormaPago		varchar(50),
    @Renglon		float,
    @Moneda		char(10), 
    @TipoCambio		float,
    @FPMoneda		char(10), 
    @FPTipoCambio	float

  SELECT @Moneda = Moneda, @TipoCambio = TipoCambio 
    FROM CR
   WHERE ID = @ID

  IF NOT EXISTS(SELECT * FROM CRVenta WHERE ID = @ID)
  BEGIN
    SELECT @Renglon = 0.0
    DECLARE crCRVenta CURSOR FOR
     SELECT Articulo
       FROM EmpresaCfgCR
      WHERE Empresa = @Empresa AND NULLIF(RTRIM(Articulo), '') IS NOT NULL

    OPEN crCRVenta
    FETCH NEXT FROM crCRVenta INTO @Articulo
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Renglon = @Renglon + 2048.0
        INSERT CRVenta (ID, Renglon, Articulo) VALUES (@ID, @Renglon, @Articulo)
      END
      FETCH NEXT FROM crCRVenta INTO @Articulo
    END -- While
    CLOSE crCRVenta
    DEALLOCATE crCRVenta
  END

  IF NOT EXISTS(SELECT * FROM CRAgente WHERE ID = @ID)
  BEGIN
    SELECT @Renglon = 0.0
    DECLARE crCRAgente CURSOR FOR
     SELECT Agente
       FROM SucursalCfgCR
      WHERE Sucursal = @Sucursal AND NULLIF(RTRIM(Agente), '') IS NOT NULL

    OPEN crCRAgente
    FETCH NEXT FROM crCRAgente INTO @Agente
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Renglon = @Renglon + 2048.0
        INSERT CRAgente (ID, Renglon, Agente) VALUES (@ID, @Renglon, @Agente)
      END
      FETCH NEXT FROM crCRAgente INTO @Agente
    END -- While
    CLOSE crCRAgente
    DEALLOCATE crCRAgente
  END

  IF NOT EXISTS(SELECT * FROM CRCobro WHERE ID = @ID)
  BEGIN
    SELECT @Renglon = 0.0
    DECLARE crCRCobro CURSOR FOR
     SELECT FormaPago
       FROM EmpresaCfgCR 
      WHERE Empresa = @Empresa AND NULLIF(RTRIM(FormaPago), '') IS NOT NULL

    OPEN crCRCobro
    FETCH NEXT FROM crCRCobro INTO @FormaPago
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Renglon = @Renglon + 2048.0
        SELECT @FPMoneda = ISNULL(NULLIF(RTRIM(Moneda), ''), @Moneda) FROM FormaPago WHERE FormaPago = @FormaPago
        IF @FPMoneda <> @Moneda SELECT @FPTipoCambio = TipoCambio FROM Mon WHERE Moneda = @FPMoneda ELSE SELECT @FPTipoCambio = @TipoCambio

        INSERT CRCobro (ID, Renglon, FormaPago, Moneda, TipoCambio) VALUES (@ID, @Renglon, @FormaPago, @FPMoneda, @FPTipoCambio)
      END
      FETCH NEXT FROM crCRCobro INTO @FormaPago
    END -- While
    CLOSE crCRCobro
    DEALLOCATE crCRCobro
  END

  RETURN
END
GO


/**************** spReevaluar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReevaluar') and type = 'P') drop procedure dbo.spReevaluar
GO
CREATE PROCEDURE spReevaluar
		   @Estacion		int,
		   @Sucursal		int,
                   @Empresa		char(5),
		   @Usuario		char(10),
    		   @Modulo		char(5),
		   @FechaEmision	datetime
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CfgMov			char(20),
    @CfgMovCredito		char(20),
    @Conteo			int,
    @ID				int,
    @Renglon			float,
    @FechaRegistro		datetime,
    @CtaDinero			char(10),
    @Contacto			char(10),
    @UltContacto		char(10),
    @Saldo			money,
    @SaldoMN			money,
    @AjusteMN			money,
    @AjusteAnteriorMN		money,
    @Importe			money,
    @SumaImporte		money,
    @ContMoneda			char(10),
    @UltMoneda			char(10),
    @Moneda			char(10),
    @TipoCambio			float,
    @MovTipoCambio		float,
    @Mov			char(20),
    @MovID			varchar(20),
    @MovGenerar			char(20),
    @MovIDGenerar		varchar(20),
    @IDGenerar			int,
    @Ok				int,
    @OkRef			varchar(255),
    @OkDesc           		varchar(255),	
    @OkTipo           		varchar(50)

  EXEC spExtraerFecha @FechaEmision OUTPUT
  SELECT @FechaRegistro = GETDATE() 
  SELECT @ID = NULL, @Conteo = 0, @Ok = NULL, @OkRef = NULL, @UltContacto = NULL, @UltMoneda = NULL
  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  SELECT @CfgMov = CASE @Modulo 
                     WHEN 'CXC' THEN NULLIF(RTRIM(CxcReevaluacion), '') 
                     WHEN 'CXP' THEN NULLIF(RTRIM(CxpReevaluacion), '') 
                     WHEN 'DIN' THEN NULLIF(RTRIM(DineroReevaluacion), '') 
                   END,
         @CfgMovCredito = CASE @Modulo 
                     WHEN 'CXC' THEN NULLIF(RTRIM(CxcReevaluacionCredito), '') 
                     WHEN 'CXP' THEN NULLIF(RTRIM(CxpReevaluacionCredito), '') 
                   END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Modulo = 'DIN'
  BEGIN
    DECLARE crCtaDinero CURSOR FOR
     SELECT m.Moneda, m.TipoCambio, c.CtaDinero 
       FROM CtaDinero c, Reevaluacion m
      WHERE c.Tipo <> 'Caja' 
        AND m.Moneda = c.Moneda AND m.Estacion = @Estacion AND ISNULL(m.TipoCambio, 0) > 0 AND m.Moneda <> @ContMoneda
    OPEN crCtaDinero
    FETCH NEXT FROM crCtaDinero INTO @Moneda, @TipoCambio, @CtaDinero
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        SELECT @Saldo = ISNULL(SUM(Cargo), 0)-ISNULL(SUM(Abono), 0), 
               @SaldoMN = ISNULL(SUM(Cargo*TipoCambio), 0)-ISNULL(SUM(Abono*TipoCambio), 0) 
          FROM Auxiliar 
         WHERE Empresa = @Empresa AND Rama = @Modulo AND Cuenta = @CtaDinero AND Fecha <= @FechaEmision
        SELECT @AjusteMN = (@Saldo*@TipoCambio)-@SaldoMN

        SELECT @AjusteAnteriorMN = SUM(Importe)
          FROM Dinero d, MovTipo mt
         WHERE mt.Modulo = @Modulo AND mt.Mov = d.Mov AND mt.Clave = 'DIN.RE'
           AND d.Empresa = @Empresa AND d.CtaDinero = @CtaDinero AND d.Moneda = @ContMoneda AND d.FechaEmision <= @FechaEmision
           AND d.Estatus = 'CONCLUIDO'

        SELECT @Importe = ISNULL(@AjusteMN, 0) - ISNULL(@AjusteAnteriorMN, 0)
        IF @Importe <> 0.0
        BEGIN
          INSERT Dinero (OrigenTipo, Sucursal,  Empresa,  Mov,     FechaEmision,  Moneda,      TipoCambio,  Usuario,   Estatus,     UltimoCambio,   CtaDinero,  Importe)
                 VALUES ('AUTO/RE',  @Sucursal, @Empresa, @CfgMov, @FechaEmision, @ContMoneda, 1.0,         @Usuario, 'SINAFECTAR', @FechaRegistro, @CtaDinero, @Importe)
          SELECT @ID = SCOPE_IDENTITY()
          SELECT @Conteo = @Conteo + 1
          EXEC spDinero @ID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        END
      END
      FETCH NEXT FROM crCtaDinero INTO @Moneda, @TipoCambio, @CtaDinero
    END
    CLOSE crCtaDinero
    DEALLOCATE crCtaDinero
  END ELSE
  BEGIN
    -- Movimientos
    IF @Modulo = 'CXC'
      DECLARE crReevaluacion CURSOR FOR
       SELECT m.Moneda, m.TipoCambio, c.TipoCambio, c.Cliente, c.Mov, c.MovID, ISNULL(c.Saldo*ISNULL(mt.Factor, 1), 0)
         FROM Cxc c, Reevaluacion m, MovTipo mt
        WHERE c.Empresa = @Empresa
          AND m.Moneda = c.Moneda AND m.TipoCambio <> c.TipoCambio AND m.Estacion = @Estacion AND ISNULL(m.TipoCambio, 0) > 0 AND m.Moneda <> @ContMoneda
          AND c.Estatus = 'PENDIENTE'
          AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.F', 'CXC.FA', 'CXC.FAC', 'CXC.CA', 'CXC.CAD', 'CXC.D', 'CXC.DAC', 'CXC.CAP') 
          AND ISNULL(c.Saldo, 0) > 0.0
          AND c.FechaEmision <= @FechaEmision
        ORDER BY c.Moneda, c.Cliente
    ELSE
    IF @Modulo = 'CXP'
      DECLARE crReevaluacion CURSOR FOR
       SELECT m.Moneda, m.TipoCambio, c.TipoCambio, c.Proveedor, c.Mov, c.MovID, ISNULL(c.Saldo*ISNULL(mt.Factor, 1), 0)
         FROM Cxp c, Reevaluacion m, MovTipo mt
        WHERE c.Empresa = @Empresa
          AND m.Moneda = c.Moneda AND m.TipoCambio <> c.TipoCambio AND m.Estacion = @Estacion AND ISNULL(m.TipoCambio, 0) > 0 AND m.Moneda <> @ContMoneda
          AND c.Estatus = 'PENDIENTE'
          AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXP.F', 'CXP.FAC', 'CXP.CA', 'CXP.CAD', 'CXP.D', 'CXP.DAC', 'CXP.CAP') 
          AND ISNULL(c.Saldo, 0) > 0.0
          AND c.FechaEmision <= @FechaEmision
        ORDER BY c.Moneda, c.Proveedor

    OPEN crReevaluacion
    FETCH NEXT FROM crReevaluacion INTO @Moneda, @TipoCambio, @MovTipoCambio, @Contacto, @Mov, @MovID, @Saldo
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        SELECT @Importe = (@Saldo*@TipoCambio) - (@Saldo*@MovTipoCambio)
        IF @ID IS NULL OR @UltMoneda <> @Moneda OR @UltContacto <> @Contacto
        BEGIN
          SELECT @UltMoneda = @Moneda, @UltContacto = @Contacto
          IF @ID IS NOT NULL AND @Ok IS NULL
          BEGIN
            IF @Modulo = 'CXC'
              UPDATE Cxc SET Importe = @SumaImporte WHERE ID = @ID
            ELSE
            IF @Modulo = 'CXP'
              UPDATE Cxp SET Importe = @SumaImporte WHERE ID = @ID
            EXEC spCx @ID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @MovGenerar OUTPUT, @MovIDGenerar OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          END
          IF @Ok IS NULL
          BEGIN
            IF @Modulo = 'CXC'
              INSERT Cxc (OrigenTipo, Sucursal,  Empresa,  Mov,     FechaEmision,  Moneda,      TipoCambio,  Usuario,   Estatus,     UltimoCambio,   Cliente,   ClienteMoneda, ClienteTipoCambio, AplicaManual)
                  VALUES ('AUTO/RE',  @Sucursal, @Empresa, @CfgMov, @FechaEmision, @ContMoneda, 1.0,         @Usuario, 'SINAFECTAR', @FechaRegistro, @Contacto, @Moneda,       @TipoCambio, 	1)
            ELSE
            IF @Modulo = 'CXP'
              INSERT Cxp (OrigenTipo, Sucursal,  Empresa,  Mov,     FechaEmision,  Moneda,      TipoCambio,  Usuario,  Estatus,      UltimoCambio,   Proveedor, ProveedorMoneda, ProveedorTipoCambio, AplicaManual)
                  VALUES ('AUTO/RE',  @Sucursal, @Empresa, @CfgMov, @FechaEmision, @ContMoneda, 1.0,         @Usuario, 'SINAFECTAR', @FechaRegistro, @Contacto, @Moneda,         @TipoCambio, 	    1)

            SELECT @ID = SCOPE_IDENTITY()
            SELECT @Conteo = @Conteo + 1, @Renglon = 0.0, @SumaImporte = 0
          END
        END

        SELECT @Renglon = @Renglon + 2048.0, @SumaImporte = @SumaImporte + @Importe
        IF @Modulo = 'CXC'
          INSERT CxcD (ID, Renglon, Aplica, AplicaID, Importe) VALUES (@ID, @Renglon, @Mov, @MovID, @Importe)
        ELSE
        IF @Modulo = 'CXP'
          INSERT CxpD (ID, Renglon, Aplica, AplicaID, Importe) VALUES (@ID, @Renglon, @Mov, @MovID, @Importe)
      END
      FETCH NEXT FROM crReevaluacion INTO @Moneda, @TipoCambio, @MovTipoCambio, @Contacto, @Mov, @MovID, @Saldo
    END
    CLOSE crReevaluacion
    DEALLOCATE crReevaluacion

    IF @ID IS NOT NULL AND @Ok IS NULL
    BEGIN
      IF @Modulo = 'CXC'
        UPDATE Cxc SET Importe = @SumaImporte WHERE ID = @ID
      ELSE
      IF @Modulo = 'CXP'
        UPDATE Cxp SET Importe = @SumaImporte WHERE ID = @ID
      EXEC spCx @ID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    END

    -- Creditos
    SELECT @ID = NULL
    IF @Modulo = 'CXC'
      DECLARE crReevaluacion CURSOR FOR
       SELECT m.Moneda, m.TipoCambio, c.TipoCambio, c.Cliente, c.Mov, c.MovID, ISNULL(c.Saldo*ISNULL(mt.Factor, 1), 0)
         FROM Cxc c, Reevaluacion m, MovTipo mt
        WHERE c.Empresa = @Empresa
          AND m.Moneda = c.Moneda AND m.TipoCambio <> c.TipoCambio AND m.Estacion = @Estacion AND ISNULL(m.TipoCambio, 0) > 0 AND m.Moneda <> @ContMoneda
          AND c.Estatus = 'PENDIENTE'
          AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.DA', 'CXC.NC', 'CXC.NCD', 'CXC.NCF', 'CXC.DV') 
          AND ISNULL(c.Saldo, 0) > 0.0
          AND c.FechaEmision <= @FechaEmision
        ORDER BY c.Moneda, c.Cliente
    ELSE
    IF @Modulo = 'CXP'
      DECLARE crReevaluacion CURSOR FOR
       SELECT m.Moneda, m.TipoCambio, c.TipoCambio, c.Proveedor, c.Mov, c.MovID, ISNULL(c.Saldo*ISNULL(mt.Factor, 1), 0)
         FROM Cxp c, Reevaluacion m, MovTipo mt
        WHERE c.Empresa = @Empresa
          AND m.Moneda = c.Moneda AND m.TipoCambio <> c.TipoCambio AND m.Estacion = @Estacion AND ISNULL(m.TipoCambio, 0) > 0 AND m.Moneda <> @ContMoneda
          AND c.Estatus = 'PENDIENTE'
          AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXP.A', 'CXP.DA', 'CXP.NC', 'CXP.NCD', 'CXP.NCF') 
          AND ISNULL(c.Saldo, 0) > 0.0
          AND c.FechaEmision <= @FechaEmision
        ORDER BY c.Moneda, c.Proveedor

    OPEN crReevaluacion
    FETCH NEXT FROM crReevaluacion INTO @Moneda, @TipoCambio, @MovTipoCambio, @Contacto, @Mov, @MovID, @Saldo
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        SELECT @Importe = (@Saldo*@TipoCambio) - (@Saldo*@MovTipoCambio)
        IF @ID IS NULL OR @UltMoneda <> @Moneda OR @UltContacto <> @Contacto
        BEGIN
          SELECT @UltMoneda = @Moneda, @UltContacto = @Contacto
          IF @ID IS NOT NULL AND @Ok IS NULL
          BEGIN
            IF @Modulo = 'CXC'
              UPDATE Cxc SET Importe = @SumaImporte WHERE ID = @ID
            ELSE
            IF @Modulo = 'CXP'
              UPDATE Cxp SET Importe = @SumaImporte WHERE ID = @ID
            EXEC spCx @ID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @MovGenerar OUTPUT, @MovIDGenerar OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          END
          IF @Ok IS NULL
          BEGIN
            IF @Modulo = 'CXC'
              INSERT Cxc (OrigenTipo, Sucursal,  Empresa,  Mov,            FechaEmision,  Moneda,      TipoCambio,  Usuario,   Estatus,     UltimoCambio,   Cliente,   ClienteMoneda, ClienteTipoCambio, AplicaManual)
                  VALUES ('AUTO/RE',  @Sucursal, @Empresa, @CfgMovCredito, @FechaEmision, @ContMoneda, 1.0,         @Usuario, 'SINAFECTAR', @FechaRegistro, @Contacto, @Moneda,       @TipoCambio, 	1)
            ELSE
            IF @Modulo = 'CXP'
              INSERT Cxp (OrigenTipo, Sucursal,  Empresa,  Mov,            FechaEmision,  Moneda,      TipoCambio,  Usuario,  Estatus,      UltimoCambio,   Proveedor, ProveedorMoneda, ProveedorTipoCambio, AplicaManual)
                  VALUES ('AUTO/RE',  @Sucursal, @Empresa, @CfgMovCredito, @FechaEmision, @ContMoneda, 1.0,         @Usuario, 'SINAFECTAR', @FechaRegistro, @Contacto, @Moneda,         @TipoCambio, 	    1)

            SELECT @ID = SCOPE_IDENTITY()
            SELECT @Conteo = @Conteo + 1, @Renglon = 0.0, @SumaImporte = 0
          END
        END

        SELECT @Renglon = @Renglon + 2048.0, @SumaImporte = @SumaImporte + @Importe
        IF @Modulo = 'CXC'
          INSERT CxcD (ID, Renglon, Aplica, AplicaID, Importe) VALUES (@ID, @Renglon, @Mov, @MovID, @Importe)
        ELSE
        IF @Modulo = 'CXP'
          INSERT CxpD (ID, Renglon, Aplica, AplicaID, Importe) VALUES (@ID, @Renglon, @Mov, @MovID, @Importe)
      END
      FETCH NEXT FROM crReevaluacion INTO @Moneda, @TipoCambio, @MovTipoCambio, @Contacto, @Mov, @MovID, @Saldo
    END
    CLOSE crReevaluacion
    DEALLOCATE crReevaluacion

    IF @ID IS NOT NULL AND @Ok IS NULL
    BEGIN
      IF @Modulo = 'CXC'
        UPDATE Cxc SET Importe = @SumaImporte WHERE ID = @ID
      ELSE
      IF @Modulo = 'CXP'
        UPDATE Cxp SET Importe = @SumaImporte WHERE ID = @ID
      EXEC spCx @ID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    END
  END

  IF @Ok IS NULL 
    SELECT @Ok = 80000, @OkRef = LTRIM(Convert(char, @Conteo))+' Movimientos(s) generados.', @OkTipo = 'INFO', @OkDesc = 'Proceso Concluido'
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

/**************** spInteresesDevengados ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInteresesDevengados') and type = 'P') drop procedure dbo.spInteresesDevengados
GO
CREATE PROCEDURE spInteresesDevengados
		   @Sucursal		int,
                   @Empresa		char(5),
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
    @CfgMov			char(20),
    @RamaID			int,
    @ID				int,
    @CtaDinero			char(10),
    @Contacto			char(10),
    @Intereses			money,
    @Importe			money,
    @Moneda			char(10),
    @TipoCambio			float,
    @MovTipoCambio		float,
    @MovGenerar			char(20),
    @MovIDGenerar		varchar(20),
    @IDGenerar			int,
    @Concepto			varchar(50), 
    @Proyecto			varchar(50), 
    @UEN			int

  SELECT @ID = NULL

  SELECT @CfgMov = CASE @Modulo 
                     WHEN 'CXC' THEN NULLIF(RTRIM(CxcInteresesDevengados), '') 
                     WHEN 'CXP' THEN NULLIF(RTRIM(CxpInteresesDevengados), '') 
                   END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Ok IS NULL
  BEGIN
    -- Movimientos
    IF @Modulo = 'CXC'
      DECLARE crIntereses CURSOR FOR
       SELECT ISNULL(c.RamaID, c.ID), m.Moneda, m.TipoCambio, c.Concepto, c.Proyecto, c.UEN, c.Cliente, SUM(ISNULL(c.Saldo*ISNULL(mt.Factor, 1)*(c.TasaDiaria/100.0)/**DATEDIFF(day, ISNULL(UltimoDevengado, FechaEmision), @Hoy)*/, 0))
         FROM Cxc c, Mon m, MovTipo mt
        WHERE c.Empresa = @Empresa
          AND m.Moneda = c.Moneda 
          AND c.Estatus = 'PENDIENTE'
          AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.F', 'CXC.FAC', 'CXC.CA', 'CXC.CAD', 'CXC.D', 'CXC.DAC', 'CXC.A', 'CXC.AR', 'CXC.DA', 'CXC.NC', 'CXC.NCD', 'CXC.NCF', 'CXC.DV') 
          AND ISNULL(c.Saldo, 0) > 0.0 AND NULLIF(c.TasaDiaria, 0) IS NOT NULL AND c.Vencimiento > @Hoy
        GROUP BY ISNULL(c.RamaID, c.ID), m.Moneda, m.TipoCambio, c.Concepto, c.Proyecto, c.UEN, c.Cliente
    ELSE
    IF @Modulo = 'CXP'
      DECLARE crIntereses CURSOR FOR
       SELECT ISNULL(c.RamaID, c.ID), m.Moneda, m.TipoCambio, c.Concepto, c.Proyecto, c.UEN, c.Proveedor, SUM(ISNULL(c.Saldo*ISNULL(mt.Factor, 1)*(c.TasaDiaria/100.0)/**DATEDIFF(day, ISNULL(UltimoDevengado, FechaEmision), @Hoy)*/, 0))
         FROM Cxp c, Mon m, MovTipo mt
        WHERE c.Empresa = @Empresa
          AND m.Moneda = c.Moneda 
          AND c.Estatus = 'PENDIENTE'
          AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXP.F', 'CXP.FAC', 'CXP.CA', 'CXP.CAD', 'CXP.D', 'CXP.DAC', 'CXP.A', 'CXP.DA', 'CXP.NC', 'CXP.NCD', 'CXP.NCF')
          AND ISNULL(c.Saldo, 0) > 0.0 AND NULLIF(c.TasaDiaria, 0) IS NOT NULL AND c.Vencimiento > @Hoy
        GROUP BY ISNULL(c.RamaID, c.ID), m.Moneda, m.TipoCambio, c.Concepto, c.Proyecto, c.UEN, c.Proveedor

    OPEN crIntereses
    FETCH NEXT FROM crIntereses INTO @RamaID, @Moneda, @TipoCambio, @Concepto, @Proyecto, @UEN, @Contacto, @Importe
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL AND NULLIF(@Importe, 0) IS NOT NULL
      BEGIN
        IF @Modulo = 'CXC'
          INSERT Cxc (OrigenTipo, Sucursal,  Empresa,  Mov,     FechaEmision,  Moneda,  TipoCambio,  Importe,  Usuario,   Estatus,     UltimoCambio,   Cliente,   ClienteMoneda, ClienteTipoCambio, RamaID,  Concepto,  Proyecto,  UEN)
              VALUES ('AUTO/ID',  @Sucursal, @Empresa, @CfgMov, @Hoy,          @Moneda, @TipoCambio, @Importe, @Usuario, 'SINAFECTAR', @FechaRegistro, @Contacto, @Moneda,       @TipoCambio,       @RamaID, @Concepto, @Proyecto, @UEN)
        ELSE
        IF @Modulo = 'CXP'
          INSERT Cxp (OrigenTipo, Sucursal,  Empresa,  Mov,     FechaEmision,  Moneda,  TipoCambio,  Importe,  Usuario,  Estatus,      UltimoCambio,   Proveedor, ProveedorMoneda, ProveedorTipoCambio,   RamaID,  Concepto,  Proyecto,  UEN)
              VALUES ('AUTO/ID',  @Sucursal, @Empresa, @CfgMov, @Hoy,          @Moneda, @TipoCambio, @Importe, @Usuario, 'SINAFECTAR', @FechaRegistro, @Contacto, @Moneda,         @TipoCambio, 	  @RamaID, @Concepto, @Proyecto, @UEN)

        SELECT @ID = SCOPE_IDENTITY()
        EXEC spCx @ID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @MovGenerar OUTPUT, @MovIDGenerar OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        SELECT @Conteo = @Conteo + 1
      END
      FETCH NEXT FROM crIntereses INTO @RamaID, @Moneda, @TipoCambio, @Concepto, @Proyecto, @UEN, @Contacto, @Importe
    END
    CLOSE crIntereses
    DEALLOCATE crIntereses
  END
  RETURN
END
GO

/**************** spCargarIntereses ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCargarIntereses') and type = 'P') drop procedure dbo.spCargarIntereses
GO
CREATE PROCEDURE spCargarIntereses
		   @Sucursal		int,
                   @Empresa		char(5),
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
    @CfgMov			char(20),
    @RamaID			int,
    @ID				int,
    @Renglon			float,
    @CtaDinero			char(10),
    @Contacto			char(10),
    @Intereses			money,
    @Importe			money,
    @Moneda			char(10),
    @TipoCambio			float,
    @MovTipoCambio		float,
    @MovGenerar			char(20),
    @MovIDGenerar		varchar(20),
    @IDGenerar			int,
    @Concepto			varchar(50), 
    @Proyecto			varchar(50), 
    @UEN			int,
    @Tasa			varchar(50),
    @NuevaTasaDiaria		float

  EXEC spExtraerFecha @Hoy OUTPUT
  SELECT @FechaRegistro = GETDATE() 
  SELECT @ID = NULL

  SELECT @CfgMov = CASE @Modulo 
                     WHEN 'CXC' THEN NULLIF(RTRIM(CxcCargoIntereses), '') 
                     WHEN 'CXP' THEN NULLIF(RTRIM(CxpAbonoIntereses), '') 
                   END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  CREATE TABLE #Devengados (
    Renglon	float		NULL,
    Mov		varchar(20)	COLLATE Database_Default NULL,
    MovID	varchar(20)	COLLATE Database_Default NULL,
    Importe	money		NULL)

  IF @Ok IS NULL
  BEGIN
    -- Movimientos
    IF @Modulo = 'CXC'
      DECLARE crIntereses CURSOR FOR
       SELECT ISNULL(c.RamaID, c.ID), m.Moneda, m.TipoCambio, c.Concepto, c.Proyecto, c.UEN, c.Cliente, c.Tasa
         FROM Cxc c, Mon m, MovTipo mt
        WHERE c.Empresa = @Empresa
          AND m.Moneda = c.Moneda 
          AND c.Estatus = 'PENDIENTE'
          AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.F', 'CXC.FAC', 'CXC.CA', 'CXC.CAD', 'CXC.D', 'CXC.DAC', 'CXC.A', 'CXC.AR', 'CXC.DA', 'CXC.NC', 'CXC.NCD', 'CXC.NCF', 'CXC.DV') 
          AND ISNULL(c.Saldo, 0) > 0.0 AND NULLIF(c.TasaDiaria, 0) IS NOT NULL AND c.Vencimiento = @Hoy
        ORDER BY ISNULL(c.RamaID, c.ID), m.Moneda, m.TipoCambio, c.Concepto, c.Proyecto, c.UEN, c.Cliente
    ELSE
    IF @Modulo = 'CXP'
      DECLARE crIntereses CURSOR FOR
       SELECT ISNULL(c.RamaID, c.ID), m.Moneda, m.TipoCambio, c.Concepto, c.Proyecto, c.UEN, c.Proveedor, c.Tasa
         FROM Cxp c, Mon m, MovTipo mt
        WHERE c.Empresa = @Empresa
          AND m.Moneda = c.Moneda 
          AND c.Estatus = 'PENDIENTE'
          AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXP.F', 'CXP.FAC', 'CXP.CA', 'CXP.CAD', 'CXP.D', 'CXP.DAC', 'CXP.A', 'CXP.DA', 'CXP.NC', 'CXP.NCD', 'CXP.NCF')
          AND ISNULL(c.Saldo, 0) > 0.0 AND NULLIF(c.TasaDiaria, 0) IS NOT NULL AND c.Vencimiento = @Hoy
        ORDER BY ISNULL(c.RamaID, c.ID), m.Moneda, m.TipoCambio, c.Concepto, c.Proyecto, c.UEN, c.Proveedor

    OPEN crIntereses
    FETCH NEXT FROM crIntereses INTO @RamaID, @Moneda, @TipoCambio, @Concepto, @Proyecto, @UEN, @Contacto, @Tasa
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
      BEGIN
        TRUNCATE TABLE #Devengados
        IF @Modulo = 'CXC'
        BEGIN
          INSERT Cxc (OrigenTipo, Sucursal,  Empresa,  Mov,     FechaEmision,  Moneda,  TipoCambio,  Usuario,   Estatus,     UltimoCambio,   Cliente,   ClienteMoneda, ClienteTipoCambio, AplicaManual, RamaID,  Concepto,  Proyecto,  UEN)
              VALUES ('AUTO/CI',  @Sucursal, @Empresa, @CfgMov, @Hoy,          @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @FechaRegistro, @Contacto, @Moneda,       @TipoCambio,       1,            @RamaID, @Concepto, @Proyecto, @UEN)
          SELECT @ID = SCOPE_IDENTITY()
          INSERT #Devengados (Mov, MovID, Importe)
          SELECT Mov, MovID, Saldo 
            FROM Cxc
           WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE' AND NULLIF(Saldo, 0) IS NOT NULL
             AND Moneda = @Moneda AND ISNULL(RamaID, ID) = @RamaID AND OrigenTipo = 'AUTO/ID' 
             AND Cliente = @Contacto
        END ELSE     
        IF @Modulo = 'CXP'
        BEGIN
          INSERT Cxp (OrigenTipo, Sucursal,  Empresa,  Mov,     FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      UltimoCambio,   Proveedor, ProveedorMoneda, ProveedorTipoCambio,   AplicaManual, RamaID,  Concepto,  Proyecto,  UEN)
              VALUES ('AUTO/CI',  @Sucursal, @Empresa, @CfgMov, @Hoy,          @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @FechaRegistro, @Contacto, @Moneda,         @TipoCambio, 	  1,            @RamaID, @Concepto, @Proyecto, @UEN)
          SELECT @ID = SCOPE_IDENTITY()
          INSERT #Devengados (Mov, MovID, Importe)
          SELECT Mov, MovID, Saldo 
            FROM Cxp
           WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE' AND NULLIF(Saldo, 0) IS NOT NULL
             AND Moneda = @Moneda AND ISNULL(RamaID, ID) = @RamaID AND OrigenTipo = 'AUTO/ID' 
             AND Proveedor = @Contacto
        END          
        SELECT @Renglon = 0.0
        UPDATE #Devengados SET @Renglon = Renglon = ISNULL(Renglon, 0) + @Renglon + 2048
        IF @Modulo = 'CXC'
        BEGIN
          INSERT CxcD (Sucursal, ID, Renglon, Aplica, AplicaID, Importe) 
          SELECT @Sucursal, @ID, Renglon, Mov, MovID, Importe FROM #Devengados          
          IF EXISTS(SELECT * FROM CxcD)
            UPDATE Cxc SET Importe = (SELECT SUM(Importe) FROM CxcD WHERE ID = @ID) WHERE ID = @ID 
          ELSE BEGIN
            DELETE Cxc WHERE ID = @ID
            SELECT @ID = NULL
          END
        END ELSE
        IF @Modulo = 'CXP' 
        BEGIN
          INSERT CxpD (Sucursal, ID, Renglon, Aplica, AplicaID, Importe) 
          SELECT @Sucursal, @ID, Renglon, Mov, MovID, Importe FROM #Devengados 
          IF EXISTS(SELECT * FROM CxpD)
            UPDATE Cxp SET Importe = (SELECT SUM(Importe) FROM CxpD WHERE ID = @ID) WHERE ID = @ID 
          ELSE BEGIN
            DELETE Cxp WHERE ID = @ID
            SELECT @ID = NULL
          END
        END

        IF @ID IS NOT NULL
          EXEC spCx @ID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @MovGenerar OUTPUT, @MovIDGenerar OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        SELECT @Conteo = @Conteo + 1

        -- Actualizar la Tasa
        EXEC spVerTasaDiaria @Tasa, @Hoy, @NuevaTasaDiaria OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF @Modulo = 'CXC' UPDATE Cxc SET TasaDiaria = @NuevaTasaDiaria WHERE ISNULL(RamaID, ID) = @RamaID AND Vencimiento > @Hoy ELSE
        IF @Modulo = 'CXP' UPDATE Cxp SET TasaDiaria = @NuevaTasaDiaria WHERE ISNULL(RamaID, ID) = @RamaID AND Vencimiento > @Hoy 

      END
      FETCH NEXT FROM crIntereses INTO @RamaID, @Moneda, @TipoCambio, @Concepto, @Proyecto, @UEN, @Contacto, @Tasa
    END
    CLOSE crIntereses
    DEALLOCATE crIntereses
  END
  RETURN
END
GO


-- spGenerarIntereses 0, 'DEMO', 'DEMO', 'CXC', '9/12/3'
/**************** spGenerarIntereses ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarIntereses') and type = 'P') drop procedure dbo.spGenerarIntereses
GO
CREATE PROCEDURE spGenerarIntereses
		   @Sucursal		int,
                   @Empresa		char(5),
		   @Usuario		char(10),
		   @FechaD		datetime,
		   @FechaA		datetime,
                   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaRegistro   datetime,
    @Conteo	     int,
    @Hoy	     datetime

  SELECT @Conteo = 0
  EXEC spExtraerFecha @FechaD OUTPUT
  EXEC spExtraerFecha @FechaA OUTPUT
  SELECT @FechaRegistro = GETDATE() 

  SELECT @Hoy = @FechaD
  WHILE @Hoy < @FechaA
  BEGIN
    EXEC spCargarIntereses @Sucursal, @Empresa, @Usuario, 'CXC', @Hoy, @FechaRegistro, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    IF @Ok IS NULL
      EXEC spCargarIntereses @Sucursal, @Empresa, @Usuario, 'CXP', @Hoy, @FechaRegistro, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    IF @Ok IS NULL
      EXEC spInteresesDevengados @Sucursal, @Empresa, @Usuario, 'CXC', @Hoy, @FechaRegistro, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    IF @Ok IS NULL
      EXEC spInteresesDevengados @Sucursal, @Empresa, @Usuario, 'CXP', @Hoy, @FechaRegistro, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    SELECT @Hoy = DATEADD(day, 1, @Hoy)
  END
  RETURN
END
GO

/**************** spSugerirSerieLoteMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirSerieLoteMov') and type = 'P') drop procedure dbo.spSugerirSerieLoteMov
GO
CREATE PROCEDURE spSugerirSerieLoteMov
                   	@Empresa	char(5),
    		   	@Modulo		char(5),
			@ID		int,
			@MovTipo	varchar(20),
			@Almacen	char(10),
			@RenglonID	int,
			@Articulo	char(20),
			@SubCuenta	varchar(50),
			@Sucursal	int,
			@Cantidad	float,
			@Paquete	int,
			@EnSilencio	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @a			int,
    @LotesFijos		bit,
    @LotesAuto		bit,
    @ArtConsecutivo	int,
    @AFConsecutivo	int,
    @EsEntrada		bit,
    @EsAF		bit,
    @SugerirEntrada	bit

  SELECT @LotesFijos = 0, @LotesAuto = 0, @SubCuenta = ISNULL(NULLIF(NULLIF(RTRIM(@SubCuenta), ''), '0'), ''), @EsEntrada = 0, @EsAF = 0
  SELECT @LotesFijos = ISNULL(LotesFijos, 0), @LotesAuto = ISNULL(LotesAuto, 0), @ArtConsecutivo = ISNULL(Consecutivo, 0) FROM Art WHERE Articulo = @Articulo AND Tipo = 'LOTE'

  IF (SELECT UPPER(Tipo) FROM Alm WHERE Almacen = @Almacen) = 'ACTIVOS FIJOS' SELECT @EsAF = 1
  IF @MovTipo IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI', 'INV.E', 'INV.EP') SELECT @EsEntrada = 1

  IF NOT EXISTS(SELECT * FROM SerieLoteMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta)
  BEGIN
    IF @EsAF = 1 AND @EsEntrada = 1
    BEGIN
      SELECT @SugerirEntrada = ISNULL(AFSugerirSerieEntrada, 0), @AFConsecutivo = ISNULL(AFConsecutivo, 0) FROM EmpresaCfg WHERE Empresa = @Empresa
      IF @SugerirEntrada = 1
      BEGIN
        SELECT @a = 0
        WHILE @a<@Cantidad
        BEGIN
          SELECT @a = @a + 1
          INSERT SerieLoteMov (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  SubCuenta,  SerieLote, Cantidad)
                       VALUES (@Empresa, @Sucursal, @Modulo, @ID, @RenglonID, @Articulo, @SubCuenta, CONVERT(varchar, @AFConsecutivo+@a), 1)         
        END
        UPDATE EmpresaCfg SET AFConsecutivo = @AFConsecutivo+@Cantidad WHERE Empresa = @Empresa
    
        SELECT @LotesFijos = CONVERT(bit, 0)
        RETURN
      END
    END
    IF @LotesFijos = 1 OR (@LotesAuto = 1 AND ISNULL(@Paquete, 0) > 0 AND @EsEntrada = 1)
    BEGIN
      IF @LotesFijos = 1 
        INSERT SerieLoteMov (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  SubCuenta,  SerieLote, Cantidad)
                      SELECT @Empresa, @Sucursal, @Modulo, @ID, @RenglonID, @Articulo, @SubCuenta, Lote,      NULL
                        FROM ArtLoteFijo
                       WHERE Articulo = @Articulo
      ELSE 
      IF @LotesAuto = 1 
      BEGIN
        SELECT @a = 0
        WHILE @a<@Paquete
        BEGIN
          SELECT @a = @a + 1
          INSERT SerieLoteMov (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  SubCuenta,  SerieLote, Cantidad)
                       VALUES (@Empresa, @Sucursal, @Modulo, @ID, @RenglonID, @Articulo, @SubCuenta, CONVERT(varchar, @ArtConsecutivo+@a), @Cantidad/@Paquete)         
        END
        UPDATE Art SET Consecutivo = @ArtConsecutivo+@Paquete WHERE Articulo = @Articulo
      END
    END
  END
  IF @EnSilencio = 0
    SELECT "LotesFijos" = @LotesFijos
  RETURN
END
GO

/**************** spSugerirArtActividad ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirArtActividad') and type = 'P') drop procedure dbo.spSugerirArtActividad
GO
CREATE PROCEDURE spSugerirArtActividad
                   	@Empresa	char(5),
			@Sucursal	int,
			@ID		int,
			@Renglon	float,
			@RenglonSub	int,
			@Articulo	char(20),
			@Cantidad	float = 1.0,
			@Agente		char(10) = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF (SELECT ISNULL(Actividades, 0) FROM Art WHERE Articulo = @Articulo) = 1 
    IF NOT EXISTS(SELECT * FROM VentaDAgente WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub)
      INSERT VentaDAgente (ID, Renglon, RenglonSub, Sucursal, SucursalOrigen, Actividad, CantidadEstandar, Estado,      CostoActividad)
                    SELECT @ID, @Renglon, @RenglonSub, @Sucursal, @Sucursal, aa.Actividad, aa.Cantidad, 'No comenzada', a.Costo
                      FROM ArtActividad aa, Actividad a
                     WHERE aa.Articulo = @Articulo AND aa.Actividad=a.Actividad
                     ORDER BY aa.Orden

  EXEC xpSugerirArtActividad @Empresa, @Sucursal, @ID, @Renglon, @RenglonSub, @Articulo, @Cantidad, @Agente
  RETURN
END
GO


/**************** spSugerirVentaDAgenteDisponible ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirVentaDAgenteDisponible') and type = 'P') drop procedure dbo.spSugerirVentaDAgenteDisponible
GO
CREATE PROCEDURE spSugerirVentaDAgenteDisponible
			@ID			int,
			@Hoy			datetime,
			@ActividadHoras		float,
			@Agente			varchar(10),
			@FechaDisponible	datetime	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Nomina		bit,
    @Personal		char(10),
    @Jornada		varchar(20),
    @HorasPromedio	float,
    @HorasAsignadas	float,
    @Domingo		bit,
    @Lunes		bit,
    @Martes		bit,
    @Miercoles		bit,
    @Jueves		bit,
    @Viernes		bit,
    @Sabado		bit,
    @Fecha		datetime,
    @DiaSemana		int,
    @EsLaborable	bit

  SET DATEFIRST 7
  SELECT @Nomina = ISNULL(Nomina, 0), @Personal = Personal, @Jornada = Jornada FROM Agente WHERE Agente = @Agente
  IF @Nomina = 1 SELECT @Jornada = Jornada FROM Personal WHERE Personal = @Personal

  SELECT @HorasPromedio = NULLIF(HorasPromedio, 0.0),
         @Domingo    	= ISNULL(Domingo, 0),
         @Lunes		= ISNULL(Lunes, 0),
         @Martes	= ISNULL(Martes, 0),
         @Miercoles  	= ISNULL(Miercoles, 0),
         @Jueves	= ISNULL(Jueves, 0),
         @Viernes	= ISNULL(Viernes, 0),
         @Sabado	= ISNULL(Sabado, 0)
    FROM Jornada
   WHERE Jornada = @Jornada

  SELECT @FechaDisponible = NULL, @Fecha = @Hoy + 1

  WHILE @FechaDisponible IS NULL AND @HorasPromedio > 0.0
  BEGIN
    SELECT @EsLaborable = 1
    SELECT @DiaSemana = DATEPART(weekday, @Fecha)
    IF (@DiaSemana = 1 AND @Domingo   = 1) OR
       (@DiaSemana = 2 AND @Lunes     = 1) OR
       (@DiaSemana = 3 AND @Martes    = 1) OR
       (@DiaSemana = 4 AND @Miercoles = 1) OR
       (@DiaSemana = 5 AND @Jueves    = 1) OR
       (@DiaSemana = 6 AND @Viernes   = 1) OR
       (@DiaSemana = 7 AND @Sabado    = 1) 
      SELECT @EsLaborable = 0
    IF EXISTS(SELECT * FROM DiaFestivo WHERE Fecha = @Fecha AND EsLaborable = 0) SELECT @EsLaborable = 0
    IF EXISTS(SELECT * FROM JornadaDiaFestivo WHERE Jornada = @Jornada AND Fecha = @Fecha AND EsLaborable = 0) SELECT @EsLaborable = 0

    IF @EsLaborable = 1
    BEGIN
      SELECT @HorasAsignadas = 0.0
      SELECT @HorasAsignadas = ISNULL(SUM(da.CantidadEstandar), 0.0) 
        FROM VentaDAgente da
        JOIN VentaD d ON d.ID = da.ID AND d.Renglon = da.Renglon AND d.RenglonSub = da.RenglonSub
       WHERE da.ID = @ID AND da.Agente = @Agente AND da.Fecha = @Fecha

      SELECT @HorasAsignadas = @HorasAsignadas + ISNULL(SUM(da.CantidadEstandar), 0.0) 
        FROM VentaDAgente da
        JOIN Venta v ON v.ID = da.ID AND v.Estatus = 'PENDIENTE'
        JOIN VentaD d ON d.ID = da.ID AND d.Renglon = da.Renglon AND d.RenglonSub = da.RenglonSub
       WHERE da.ID <> @ID AND da.Agente = @Agente AND da.Fecha = @Fecha

      IF (@HorasAsignadas + @ActividadHoras <= @HorasPromedio) OR @HorasAsignadas = 0.0
        SELECT @FechaDisponible = @Fecha
    END
    SELECT @Fecha = DATEADD(day, 1, @Fecha)
  END

  RETURN
END
GO

/**************** spSugerirVentaDAgenteActividad ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirVentaDAgenteActividad') and type = 'P') drop procedure dbo.spSugerirVentaDAgenteActividad
GO
CREATE PROCEDURE spSugerirVentaDAgenteActividad
			@ID			int,
			@Hoy			datetime,
			@Actividad		varchar(100),
			@ActividadHoras		float,
			@AgenteDisponible	varchar(10)	OUTPUT,
			@FechaDisponible	datetime	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Agente	varchar(10),
    @Fecha	datetime

  CREATE TABLE #AgenteFecha (
    Agente		varchar(10)	COLLATE Database_Default NOT NULL PRIMARY KEY,
    Fecha		datetime	NULL)

  DECLARE crAgenteActividad CURSOR FOR
   SELECT NULLIF(RTRIM(Agente), '')
     FROM AgenteActividad
    WHERE Actividad = @Actividad
  OPEN crAgenteActividad
  FETCH NEXT FROM crAgenteActividad INTO @Agente
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Agente IS NOT NULL
    BEGIN
      EXEC spSugerirVentaDAgenteDisponible @ID, @Hoy, @ActividadHoras, @Agente, @Fecha OUTPUT
      IF @Fecha IS NOT NULL AND @Fecha > @Hoy
        INSERT #AgenteFecha (Agente, Fecha) VALUES (@Agente, @Fecha)
    END
    FETCH NEXT FROM crAgenteActividad INTO @Agente
  END -- While
  CLOSE crAgenteActividad
  DEALLOCATE crAgenteActividad

  SELECT @FechaDisponible = MIN(Fecha) FROM #AgenteFecha 
  SELECT @AgenteDisponible = MIN(Agente) FROM #AgenteFecha WHERE Fecha = @FechaDisponible
  DROP TABLE #AgenteFecha

  RETURN
END
GO

/**************** spSugerirVentaDAgenteFecha ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirVentaDAgenteFecha') and type = 'P') drop procedure dbo.spSugerirVentaDAgenteFecha
GO
CREATE PROCEDURE spSugerirVentaDAgenteFecha
			@ID		int,
			@EnSilencio	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @Hoy		datetime,
    @Actividad		varchar(100),
    @ActividadHoras	float,
    @Agente		varchar(10),
    @Fecha		datetime,
    @FechaEntrega	datetime

  SELECT @Empresa = Empresa FROM Venta WHERE ID = @ID
  SELECT @Hoy = GETDATE()
  EXEC spExtraerFecha @Hoy OUTPUT
  UPDATE VentaDAgente SET Agente = NULL, Fecha = NULL WHERE ID = @ID AND Estado = 'No comenzada'

  DECLARE crVentaDAgente CURSOR FOR
   SELECT NULLIF(RTRIM(da.Actividad), ''), ISNULL(da.CantidadEstandar, 0.0)
     FROM VentaDAgente da
     JOIN VentaD d ON d.ID = da.ID AND d.Renglon = da.Renglon AND d.RenglonSub = da.RenglonSub
    WHERE da.ID = @ID AND da.Estado = 'No comenzada'
  OPEN crVentaDAgente
  FETCH NEXT FROM crVentaDAgente INTO @Actividad, @ActividadHoras
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Actividad IS NOT NULL AND @ActividadHoras > 0.0
    BEGIN
      EXEC spSugerirVentaDAgenteActividad @ID, @Hoy, @Actividad, @ActividadHoras, @Agente OUTPUT, @Fecha OUTPUT
      UPDATE VentaDAgente SET Agente = @Agente, Fecha = @Fecha WHERE CURRENT OF crVentaDAgente
    END
    FETCH NEXT FROM crVentaDAgente INTO @Actividad, @ActividadHoras
  END -- While
  CLOSE crVentaDAgente
  DEALLOCATE crVentaDAgente
  SELECT @FechaEntrega = MAX(Fecha) FROM VentaDAgente WHERE ID = @ID

  SELECT @FechaEntrega = DATEADD(day, 1, @FechaEntrega)
  EXEC spRecorrerDiaHabilEmpresa @Empresa, @FechaEntrega OUTPUT
  UPDATE Venta SET FechaEntrega = @FechaEntrega WHERE ID = @ID

  IF @EnSilencio = 0
    SELECT 'Proceso Concluido con Exito'
  RETURN
END
GO


/**************** spSugerirTodasActividades ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirTodasActividades') and type = 'P') drop procedure dbo.spSugerirTodasActividades
GO
CREATE PROCEDURE spSugerirTodasActividades
			@Empresa	char(5),
			@Modulo		char(5),
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal	int,
    @Renglon	float,
    @RenglonSub	int,
    @Articulo	char(20),
    @Cantidad	float,
    @Agente	char(10)

  IF @Modulo = 'VTAS'
    DECLARE crMovD CURSOR FOR SELECT Sucursal, Renglon, RenglonSub, Articulo, Cantidad, Agente FROM VentaD WHERE ID = @ID

  OPEN crMovD
  FETCH NEXT FROM crMovD INTO @Sucursal, @Renglon, @RenglonSub, @Articulo, @Cantidad, @Agente
  WHILE @@FETCH_STATUS <> -1 
  BEGIN                         
    IF @@FETCH_STATUS <> -2 
      EXEC spSugerirArtActividad @Empresa, @Sucursal, @ID, @Renglon, @RenglonSub, @Articulo, @Cantidad, @Agente

    FETCH NEXT FROM crMovD INTO @Sucursal, @Renglon, @RenglonSub, @Articulo, @Cantidad, @Agente
  END
  CLOSE crMovD
  DEALLOCATE crMovD
  RETURN
END
GO


-- spPedidoAuto 'DEMO', 0, 'DEMO', 'STOCK', '1/1/3'
/**************** spPedidoAuto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPedidoAuto') and type = 'P') drop procedure dbo.spPedidoAuto
GO
CREATE PROCEDURE spPedidoAuto
                   	@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@Almacen	char(10),
			@Fecha		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @Conteo			int,
    @ID				int,
    @Moneda			char(10),
    @TipoCambio			float,
    @Mov			char(20),
    @Cliente			char(10),
    @ListaPrecios		varchar(50),
    @ZonaImpuesto		varchar(50),
    @Articulo			char(20), 
    @SubCuenta			varchar(50), 
    @Cantidad			float, 
    @CantidadInventario		float, 
    @Unidad			varchar(50),
    @ArtTipo			varchar(20),
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @Renglon			float,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @Precio			money,
    @EnviarA			int,
    @Factor                     float

  SELECT @Conteo = 0
  SELECT @Moneda = ContMoneda
    FROM EmpresaCfg
   WHERE Empresa = @Empresa
  SELECT @Mov = VentaPedidoAuto
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  DECLARE crCte CURSOR FOR 
   SELECT Cliente, ISNULL(c.SucursalEmpresa, @Sucursal), m.Moneda, m.TipoCambio, c.ListaPreciosEsp, c.ZonaImpuesto, ISNULL(NULLIF(RTRIM(c.AlmacenDef), ''), @Almacen)
     FROM Cte c
     JOIN Mon m ON m.Moneda = ISNULL(c.DefMoneda, @Moneda)
    WHERE c.PedidoDef = 1 
  OPEN crCte
  FETCH NEXT FROM crCte INTO @Cliente, @Sucursal, @Moneda, @TipoCambio, @ListaPrecios, @ZonaImpuesto, @Almacen
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@Almacen), '') IS NOT NULL
    BEGIN
      IF NOT EXISTS(SELECT v.ID FROM Venta v, MovTipo mt WHERE v.Empresa = @Empresa AND v.Cliente = @Cliente AND v.FechaRequerida = @Fecha AND v.Estatus = 'PENDIENTE' AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.P')
      BEGIN
        IF EXISTS(SELECT * FROM CtePedidoDef WHERE Cliente = @Cliente)
        BEGIN
          INSERT Venta (Estatus,     Usuario,  Mov,  Empresa,  FechaEmision, FechaRequerida, Sucursal,  Cliente,  EnviarA,   Agente,   Almacen,  Moneda,  TipoCambio,  ListaPreciosEsp, Condicion,   Descuento,   DescuentoGlobal, Proyecto,   FormaEnvio)
                 SELECT 'CONFIRMAR', @Usuario, @Mov, @Empresa, @Fecha,       @Fecha,         @Sucursal, @Cliente, c.EnviarA, c.Agente, @Almacen, @Moneda, @TipoCambio, @ListaPrecios,   c.Condicion, c.Descuento, d.Porcentaje,    c.Proyecto, c.FormaEnvio
                   FROM Cte c
		   LEFT OUTER JOIN Descuento d ON d.Descuento = c.Descuento
                  WHERE c.Cliente = @Cliente 
          SELECT @ID = SCOPE_IDENTITY() 
          IF @ID IS NOT NULL
          BEGIN
            SELECT @Renglon = 0.0, @RenglonID = 0, @Conteo = @Conteo + 1
            SELECT @EnviarA = EnviarA FROM Venta WHERE ID = @ID

            DECLARE crPedidoDef CURSOR LOCAL FOR 
             SELECT d.Articulo, NULLIF(RTRIM(d.SubCuenta), ''), d.Cantidad, d.Unidad, a.Tipo, a.Impuesto1, a.Impuesto2, a.Impuesto3 
               FROM CtePedidoDef d, Art a 
              WHERE d.Cliente = @Cliente AND d.Articulo = a.Articulo
            OPEN crPedidoDef
            FETCH NEXT FROM crPedidoDef INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @ArtTipo, @Impuesto1, @Impuesto2, @Impuesto3
            WHILE @@FETCH_STATUS <> -1 
            BEGIN
              IF @@FETCH_STATUS <> -2 
              BEGIN
                EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
     	        EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
       	        EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
                EXEC spTipoImpuesto 'VTAS', @ID, @Mov, @Fecha, @Empresa, @Sucursal, @Cliente, @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
   	        EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
                EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @Moneda, @TipoCambio, @ListaPrecios, @Precio OUTPUT
                SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
                EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
                SELECT @Factor =  dbo.fnArtUnidadFactor(@Empresa, @Articulo,@Unidad)
                INSERT VentaD (ID,  Renglon,  RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Cantidad,  CantidadInventario,  Unidad,  Precio,  Impuesto1,  Impuesto2,  Impuesto3,          Almacen,  FechaRequerida)
                       VALUES (@ID, @Renglon, @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Cantidad, @CantidadInventario, @Unidad, @Precio, @Impuesto1, @Impuesto2, @Impuesto3*@Factor, @Almacen, @Fecha)
              END
              FETCH NEXT FROM crPedidoDef INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @ArtTipo, @Impuesto1, @Impuesto2, @Impuesto3
            END
            CLOSE crPedidoDef
            DEALLOCATE crPedidoDef
          END
        END
      END
    END
    FETCH NEXT FROM crCte INTO @Cliente, @Sucursal, @Moneda, @TipoCambio, @ListaPrecios, @ZonaImpuesto, @Almacen
  END
  CLOSE crCte
  DEALLOCATE crCte
  SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+' '+RTRIM(@Mov)+' (por Confirmar)'
  RETURN
END
GO

--delete venta where estatus = 'confirmar'

-- spEmpresaParticipacionCalc 'DEMO'
/**************** spEmpresaParticipacionCalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmpresaParticipacionCalc') and type = 'P') drop procedure dbo.spEmpresaParticipacionCalc
GO             
CREATE PROCEDURE spEmpresaParticipacionCalc
			@Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Simbolo		varchar(20),
    @ContMoneda		char(10),
    @CtaResultados	char(20),
    @Resultado		money

  SELECT @ContMoneda = ContMoneda, @CtaResultados = CtaResultados FROM EmpresaCfg WHERE Empresa = @Empresa
  DECLARE crParticipacion CURSOR FOR
   SELECT Simbolo
     FROM EmpresaParticipacion
    WHERE Empresa = @Empresa AND UPPER(Tipo)='EMPRESA'
  OPEN crParticipacion
  FETCH NEXT FROM crParticipacion INTO @Simbolo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Resultado = -SUM(Saldo) FROM Saldo WHERE Rama = 'CONT' and Empresa = @Simbolo AND Moneda = @ContMoneda AND Cuenta = @CtaResultados
      UPDATE EmpresaParticipacion SET Resultado = @Resultado, UltimoCambio = GETDATE() WHERE CURRENT OF crParticipacion
    END
    FETCH NEXT FROM crParticipacion INTO @Simbolo
  END -- While
  CLOSE crParticipacion
  DEALLOCATE crParticipacion
  RETURN
END
GO

/**************** spEmpresaParticipacionGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmpresaParticipacionGenerar') and type = 'P') drop procedure dbo.spEmpresaParticipacionGenerar
GO             
CREATE PROCEDURE spEmpresaParticipacionGenerar
			@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@FechaTrabajo	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Renglon		float,
    @CuentaDebe		varchar(20),
    @CuentaHaber	varchar(20),
    @ContMoneda		char(10),
    @Importe		money,
    @TipoCambio		float,
    @MovCont		char(20)

  SELECT @MovCont = ContDiario FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @ContMoneda = mon.Moneda, @TipoCambio = mon.TipoCambio
    FROM EmpresaCfg cfg, Mon
   WHERE cfg.Empresa = @Empresa AND mon.Moneda = cfg.ContMoneda

  EXEC spExtraerFecha @FechaTrabajo OUTPUT
  INSERT Cont (Sucursal,  Empresa,  Mov,      FechaEmision,  FechaContable, Moneda,      TipoCambio,   Usuario,  Estatus)
       VALUES (@Sucursal, @Empresa, @MovCont, @FechaTrabajo, @FechaTrabajo, @ContMoneda, @TipoCambio, @Usuario, 'CONFIRMAR')
  SELECT @ID = SCOPE_IDENTITY()
  SELECT @Renglon = 0

  DECLARE crParticipacion CURSOR FOR
   SELECT p.CuentaDebe, p.CuentaHaber, p.Resultado*(p.Porcentaje/100.0)*m.TipoCambio/@TipoCambio
     FROM EmpresaParticipacion p, Mon m
    WHERE p.Empresa = @Empresa AND p.Moneda = m.Moneda
  OPEN crParticipacion
  FETCH NEXT FROM crParticipacion INTO @CuentaDebe, @CuentaHaber, @Importe
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048.0
      INSERT ContD (ID, Renglon, Cuenta, Debe) VALUES (@ID, @Renglon, @CuentaDebe, @Importe)
      SELECT @Renglon = @Renglon + 2048.0
      INSERT ContD (ID, Renglon, Cuenta, Haber) VALUES (@ID, @Renglon, @CuentaHaber, @Importe)
    END
    FETCH NEXT FROM crParticipacion INTO @CuentaDebe, @CuentaHaber, @Importe
  END -- While
  CLOSE crParticipacion
  DEALLOCATE crParticipacion

  SELECT 'Se Generó 1 Póliza (por Confirmar)'
  RETURN
END
GO


/**************** spMovCodigo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovCodigo') and type = 'P') drop procedure dbo.spMovCodigo
GO             
CREATE PROCEDURE spMovCodigo
			@Modulo		char(5),
			@ID		int,
			@Aceptar	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo	char(20),
    @SubCuenta	varchar(50),
    @Unidad	varchar(50),
    @Cantidad	float,
    @Pendiente	float,
    @Renglon	float,
    @RenglonSub	int,
    @Ok		int,
    @OkRef	varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  BEGIN TRANSACTION
    IF @Modulo = 'COMS' UPDATE CompraD SET CantidadA = NULL WHERE ID = @ID

    DECLARE crMovCodigo CURSOR FOR
     SELECT cb.Cuenta, ISNULL(RTRIM(cb.SubCuenta), ''), ISNULL(RTRIM(cb.Unidad), ''), SUM(ISNULL(cb.Cantidad, 1)*mc.Cantidad)
       FROM MovCodigo mc, CB
      WHERE mc.Modulo = @Modulo AND mc.ModuloID = @ID AND cb.Codigo = mc.Codigo
      GROUP BY cb.Cuenta, ISNULL(RTRIM(cb.SubCuenta), ''), ISNULL(RTRIM(cb.Unidad), '')
      ORDER BY cb.Cuenta, ISNULL(RTRIM(cb.SubCuenta), ''), ISNULL(RTRIM(cb.Unidad), '')
    OPEN crMovCodigo
    FETCH NEXT FROM crMovCodigo INTO @Articulo, @SubCuenta, @Unidad, @Cantidad
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @Modulo = 'COMS' SELECT @Pendiente = SUM(CantidadPendiente) FROM CompraD WHERE ID = @ID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(Unidad, '') = @Unidad
        IF @Cantidad > ISNULL(@Pendiente, 0)
          SELECT @Ok = 10250, @OkRef = RTRIM(@Articulo) + ' ' + @SubCuenta
        ELSE
          IF @Aceptar = 1 
          BEGIN
            IF @Modulo = 'COMS' 
            BEGIN
              SELECT @Renglon = MIN(Renglon), @RenglonSub = MIN(RenglonSub) FROM CompraD WHERE ID = @ID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(Unidad, '') = @Unidad AND ISNULL(CantidadPendiente, 0) > 0
              UPDATE CompraD SET CantidadA = @Cantidad WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
            END
          END
      END
      FETCH NEXT FROM crMovCodigo INTO @Articulo, @SubCuenta, @Unidad, @Cantidad
    END -- While
    CLOSE crMovCodigo
    DEALLOCATE crMovCodigo

  IF @Ok IS NULL
  BEGIN
    IF @Aceptar = 1 DELETE MovCodigo WHERE Modulo = @Modulo AND ModuloID = @ID 
    COMMIT TRANSACTION
    SELECT @Ok
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT Descripcion + ' ' + @OkRef FROM MensajeLista WHERE Mensaje = @Ok  
  END
  RETURN
END
GO

-- select * from movcodigo
-- spMovCodigo 'COMS', 5


/**************** spCteEventoDAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCteEventoDAsignar') and type = 'P') drop procedure dbo.spCteEventoDAsignar
GO             
CREATE PROCEDURE spCteEventoDAsignar
                    @Estacion	int,
		    @Cliente	char(10)
--//WITH ENCRYPTION
AS BEGIN
  INSERT CteEvento (Cliente, EventoD)
     SELECT @Cliente, l.ID
       FROM ListaID l
      WHERE l.Estacion = @Estacion --AND l.ID NOT IN (SELECT EventoD FROM CteEvento WHERE Cliente = @Cliente)
END
GO

/**************** spCteCtoEventoDAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCteCtoEventoDAsignar') and type = 'P') drop procedure dbo.spCteCtoEventoDAsignar
GO             
CREATE PROCEDURE spCteCtoEventoDAsignar
                    @Estacion	int,
		    @Cliente	char(10),
		    @ID		int
--//WITH ENCRYPTION
AS BEGIN
  INSERT CteCtoEvento (Cliente, ID, EventoD)
     SELECT @Cliente, @ID, l.ID
       FROM ListaID l
      WHERE l.Estacion = @Estacion --AND l.ID NOT IN (SELECT EventoD FROM CteEvento WHERE Cliente = @Cliente)
END
GO

/**************** spCxcAnticiposPendientesAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxcAnticiposPendientesAceptar') and type = 'P') drop procedure dbo.spCxcAnticiposPendientesAceptar
GO             
CREATE PROCEDURE spCxcAnticiposPendientesAceptar
		    @Modulo	char(5),
                    @ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE    
    @ImporteTotal	money,
    @Impuestos		money
    
  SELECT @ImporteTotal = SUM(AnticipoAplicar), 
         @Impuestos = SUM(AnticipoAplicar*Impuestos/(Importe+Impuestos)) 
    FROM Cxc 
   WHERE AnticipoAplicaModulo=@Modulo AND AnticipoAplicaID=@ID
  IF @Modulo = 'CXC' UPDATE Cxc SET Importe = @ImporteTotal - ISNULL(@Impuestos, 0), Impuestos = @Impuestos WHERE ID = @ID
  RETURN
END
GO

/**************** spVtasAplicarAnticiposTipoServicio ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVtasAplicarAnticiposTipoServicio') and type = 'P') drop procedure dbo.spVtasAplicarAnticiposTipoServicio
GO             
CREATE PROCEDURE spVtasAplicarAnticiposTipoServicio
        @Estacion       int,
        @ID             int
        
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Transaccion                        varchar(50),
    @Ok                                 int,
    @OkRef                              varchar(255),
    @Empresa                            varchar(5),
    @Cliente                            varchar(10),
    @CfgAnticipoTipoServicio            bit,
    @CfgAnticipoArticuloServicio        varchar(20),
    @CfgMultiUnidades                   bit,
    @CfgVentaFactorDinamico             bit,
    @MovMoneda                          varchar(10),    
    @MovTipoCambio                      float,    
    @Moneda                             varchar(10), 
    @TipoCambio                         float,
    @Importe                            float,
    @Impuestos                          float,
    @Retencion                          float,
    @Retencion2                          float,    
    @AnticipoRetencion					float,
    @PorcentajeImpuesto                 float,
    @PorcentajeRetencion                float,
    @PorcentajeRetencion2                float,    
    @AnticipoAplicar                    float,
    @AnticipoSaldo                      float,    
    @MovAnticipoAplicar                 float,
    @Renglon                            float,
    @RenglonID                          int,    
    @Almacen                            varchar(10),
    @Unidad                             varchar(50),
    @Sucursal                           int,
    @AsignoAnticipo                     bit,
    @PreciosIVAIncluido                 bit,
    @CantidadInventario                 float,
    @UnidadFactor                       float,
    @FactorAplicar						float,
    @TipoImpuesto1						varchar(10) ,
    @FechaEmision						datetime,
    @Mov								varchar(10),    
    @Contacto							varchar(10)                                   

  SET @Transaccion = 'spVtasAplicarAnticiposTipoServicio' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))
  
  BEGIN TRANSACTION @Transaccion

  UPDATE Venta SET AnticipoFacturadoTipoServicio = 0 WHERE ID = @ID
  
  DELETE FROM VentaD WHERE ID = @ID AND AnticipoFacturado = 1

  SELECT @Ok = NULL, @OkRef = NULL
  
  SELECT 
    @Empresa = Empresa,
    @Cliente = Cliente,
    @MovMoneda  = Moneda,
    @MovTipoCambio = TipoCambio,
    @Almacen = Almacen,
    @Sucursal = Sucursal  
    FROM Venta 
   WHERE ID = @ID

  SELECT
    @PreciosIVAIncluido = VentaPreciosImpuestoIncluido
    FROM EmpresaCfg
   WHERE Empresa = @Empresa 

  SELECT
    @CfgAnticipoTipoServicio     = ISNULL(CxcAnticipoTipoServicio,0),
    @CfgAnticipoArticuloServicio = NULLIF(CxcAnticipoArticuloServicio,''),
    @CfgMultiUnidades            = ISNULL(MultiUnidades,0),
    @CfgVentaFactorDinamico      = ISNULL(VentaFactorDinamico,0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa 

  IF @CfgAnticipoArticuloServicio IS NULL SELECT @Ok = 10490, @OkRef = @Empresa

  SELECT @Unidad = Unidad FROM Art WHERE Articulo = @CfgAnticipoArticuloServicio  
  
  IF @CfgAnticipoTipoServicio = 1 AND @Ok IS NULL 
  BEGIN
  
    SELECT @Renglon = ISNULL(MAX(ISNULL(Renglon,0.0)),0.0) + 2048.0 FROM VentaD WHERE ID = @ID
    SELECT @RenglonID = ISNULL(MAX(ISNULL(RenglonID,0)),0.0) + 1 FROM VentaD WHERE ID = @ID    
    
    SET @AsignoAnticipo = 0
--SELECT Importe, Impuestos, Retencion, AnticipoAplicar,* FROM Cxc WHERE ID = 4    
    DECLARE crAnticiposFacturados CURSOR FOR
     SELECT Moneda, ISNULL(TipoCambio,0.0), SUM(ISNULL(Importe,0.0)), SUM(ISNULL(Impuestos,0.0)), SUM(ISNULL(Retencion,0.0)), ROUND((ISNULL(Impuestos,0.0)/ISNULL(Importe,0.0))*100.0,0), ROUND((ISNULL(Retencion,0.0)/ISNULL(Importe,0.0))*100.0,0), SUM(ISNULL(AnticipoAplicar,0.0)), SUM(ISNULL(AnticipoSaldo,0.0)), SUM(ISNULL(Retencion2,0.0)), ROUND((ISNULL(Retencion2,0.0)/ISNULL(Importe,0.0))*100.0,0)
       FROM Cxc
      WHERE Empresa = @Empresa
        AND AnticipoSaldo > 0.0
        AND Estatus IN ('PENDIENTE','CONCLUIDO')
        AND Cliente = @Cliente
        AND ISNULL(AnticipoAplicar,0.0) > 0.0
        AND AnticipoAplicaID = @ID
      GROUP BY Moneda, ISNULL(TipoCambio,0.0), ROUND((ISNULL(Impuestos,0.0)/ISNULL(Importe,0.0))*100.0,0), ROUND((ISNULL(Retencion,0.0)/ISNULL(Importe,0.0))*100.0,0), ROUND((ISNULL(Retencion2,0.0)/ISNULL(Importe,0.0))*100.0,0)
    
    OPEN crAnticiposFacturados
    FETCH NEXT FROM crAnticiposFacturados INTO @Moneda, @TipoCambio, @Importe, @Impuestos, @Retencion, @PorcentajeImpuesto, @PorcentajeRetencion, @AnticipoAplicar, @AnticipoSaldo, @Retencion2, @PorcentajeRetencion2
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      SET @FactorAplicar = @AnticipoAplicar / (@Importe  + @Impuestos - @Retencion - @Retencion2)
      IF @PreciosIVAIncluido = 0
      BEGIN
        IF @MovMoneda = @Moneda
        BEGIN
          --SET @MovAnticipoAplicar = (((@AnticipoAplicar*@TipoCambio)/@MovTipoCambio)/(1+(@PorcentajeImpuesto/100.0)))*(1+(@PorcentajeRetencion/100.0))      
          SET @MovAnticipoAplicar = @AnticipoAplicar
          SET @MovAnticipoAplicar = @MovAnticipoAplicar - (@Impuestos * @FactorAplicar)
          SET @MovAnticipoAplicar = @MovAnticipoAplicar + (@Retencion * @FactorAplicar)
          SET @MovAnticipoAplicar = @MovAnticipoAplicar + (@Retencion2 * @FactorAplicar)        
          SET @Retencion = @MovAnticipoAplicar*(@PorcentajeRetencion/100.0)                   
          SET @Retencion2 = @MovAnticipoAplicar*(@PorcentajeRetencion2/100.0)                           
        END
        ELSE        
        BEGIN
          --SET @MovAnticipoAplicar = (((@AnticipoAplicar*@TipoCambio)/@MovTipoCambio)/(1+(@PorcentajeImpuesto/100.0)))*(1+(@PorcentajeRetencion/100.0))      
          SET @MovAnticipoAplicar = (@AnticipoAplicar*@TipoCambio)/@MovTipoCambio
          SET @MovAnticipoAplicar = @MovAnticipoAplicar - (((@Impuestos*@TipoCambio)/@MovTipoCambio) * @FactorAplicar)
          SET @MovAnticipoAplicar = @MovAnticipoAplicar + (((@Retencion*@TipoCambio)/@MovTipoCambio) * @FactorAplicar)
          SET @MovAnticipoAplicar = @MovAnticipoAplicar + (((@Retencion2*@TipoCambio)/@MovTipoCambio) * @FactorAplicar)        
          SET @Retencion = @MovAnticipoAplicar*(@PorcentajeRetencion/100.0)                   
          SET @Retencion2 = @MovAnticipoAplicar*(@PorcentajeRetencion2/100.0)                                   
        END
      END        
      ELSE  
      BEGIN
        IF @MovMoneda = @Moneda
        BEGIN
          SET @MovAnticipoAplicar = @AnticipoAplicar
          SET @MovAnticipoAplicar = @MovAnticipoAplicar + (@Retencion * @FactorAplicar) + (@Retencion2 * @FactorAplicar)
          SET @Retencion = @MovAnticipoAplicar*(@PorcentajeRetencion/100.0)                       
          SET @Retencion2 = @MovAnticipoAplicar*(@PorcentajeRetencion2/100.0)                       
          --SET @MovAnticipoAplicar = (((@AnticipoAplicar*@TipoCambio)/@MovTipoCambio)*(1+(@PorcentajeRetencion/100.0)))            
          --SET @Retencion = (((@AnticipoAplicar*@TipoCambio)/@MovTipoCambio)/(1+(@PorcentajeImpuesto/100.0)))*(1+(@PorcentajeRetencion/100.0))*(@PorcentajeRetencion/100.0)          
        END
        ELSE
        BEGIN
          SET @MovAnticipoAplicar = (@AnticipoAplicar*@TipoCambio)/@MovTipoCambio   
          SET @MovAnticipoAplicar = @MovAnticipoAplicar + (((@Retencion*@TipoCambio)/@MovTipoCambio) * @FactorAplicar) + (((@Retencion2*@TipoCambio)/@MovTipoCambio) * @FactorAplicar)
          SET @Retencion = @MovAnticipoAplicar*(@PorcentajeRetencion/100.0)                       
          SET @Retencion2 = @MovAnticipoAplicar*(@PorcentajeRetencion2/100.0)                       
          --SET @MovAnticipoAplicar = (((@AnticipoAplicar*@TipoCambio)/@MovTipoCambio)*(1+(@PorcentajeRetencion/100.0)))            
          --SET @Retencion = (((@AnticipoAplicar*@TipoCambio)/@MovTipoCambio)/(1+(@PorcentajeImpuesto/100.0)))*(1+(@PorcentajeRetencion/100.0))*(@PorcentajeRetencion/100.0)                  
        END
      END
      SET @AnticipoRetencion = ISNULL(@Retencion,0.0) + ISNULL(@Retencion2,0.0)
      SET @CantidadInventario = NULL
      SET @UnidadFactor = NULL
      
      IF @CfgMultiUnidades = 1 AND @CfgVentaFactorDinamico = 1
      BEGIN      
        EXEC spUnidadFactor @Empresa, @CfgAnticipoArticuloServicio, NULL, @Unidad, @UnidadFactor OUTPUT      
      END  
      
      EXEC spMovInfo       @ID,'VTAS',@Mov =@Mov output , @FechaEmision=@FechaEmision output,@Contacto =@Contacto output   
      EXEC spTipoImpuesto 'VTAS',@ID , @Mov,@FechaEmision, @Empresa =@Empresa ,@Sucursal=@Sucursal ,@Contacto=@Contacto  , @Articulo = @CfgAnticipoArticuloServicio,@TipoImpuesto1=@TipoImpuesto1 output

      INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo, Almacen,  Articulo,                     Precio,              Impuesto1,           Impuesto2, Impuesto3, Cantidad, CantidadInventario, Unidad,  Factor, Sucursal,  AnticipoFacturado, AnticipoMoneda, AnticipoTipoCambio, PrecioMoneda, PrecioTipoCambio, DescuentoTipo, AnticipoRetencion,  Retencion1,           Retencion2           ,TipoImpuesto1)
             VALUES (@ID, @Renglon, 0,          @RenglonID, 'N',         @Almacen, @CfgAnticipoArticuloServicio, @MovAnticipoAplicar, @PorcentajeImpuesto, 0.0,       0.0,       -1,       -1*@UnidadFactor,   @Unidad, 1,      @Sucursal, 1,                 @MovMoneda,     @MovTipoCambio,     @MovMoneda,   @MovTipoCambio,   NULL,          @AnticipoRetencion, @PorcentajeRetencion, @PorcentajeRetencion2,@TipoImpuesto1)
    
      SET @Renglon = @Renglon + 2048.0
      SET @RenglonID = @RenglonID + 1      
      SET @AsignoAnticipo = 1
      FETCH NEXT FROM crAnticiposFacturados INTO @Moneda, @TipoCambio, @Importe, @Impuestos, @Retencion, @PorcentajeImpuesto, @PorcentajeRetencion, @AnticipoAplicar, @AnticipoSaldo, @Retencion2, @PorcentajeRetencion2    
    END
    CLOSE crAnticiposFacturados
    DEALLOCATE crAnticiposFacturados

    IF @AsignoAnticipo = 1 UPDATE Venta SET AnticipoFacturadoTipoServicio = 1 WHERE ID = @ID
  END

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION @Transaccion
    SELECT 'Proceso Exitoso...'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO

/**************** spArtAlmABCAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtAlmABCAceptar') and type = 'P') drop procedure dbo.spArtAlmABCAceptar
GO             
CREATE PROCEDURE spArtAlmABCAceptar
		    @Estacion		int,
		    @Modulo		char(5),
                    @ID			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo		char(20),
    @ArtTipo		varchar(20),
    @Almacen		char(10),
    @Sucursal		int,
    @Renglon		float,
    @RenglonID		int,  
    @RenglonTipo	char(1),
    @Unidad		varchar(50)

  IF @Modulo = 'INV'
  BEGIN
    SELECT @Sucursal = Sucursal, @Almacen = Almacen, @RenglonID = ISNULL(RenglonID, 0) FROM Inv WHERE ID = @ID
    SELECT @Renglon = ISNULL(MAX(Renglon), 0.0) FROM InvD WHERE ID = @ID
  END
  DECLARE crLista CURSOR FOR
   SELECT Clave
     FROM ListaSt
    ORDER BY ID

  OPEN crLista
  FETCH NEXT FROM crLista INTO @Articulo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF NOT EXISTS(SELECT * FROM InvD WHERE ID = @ID AND Articulo = @Articulo)
      BEGIN
        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1 

        SELECT @ArtTipo = Tipo, @Unidad = Unidad FROM Art WHERE Articulo = @Articulo
        EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
        IF @Modulo = 'INV'
          INSERT InvD (ID,  Renglon,  RenglonTipo,  RenglonID,  Articulo,  Almacen,  Sucursal,  Unidad) 
               VALUES (@ID, @Renglon, @RenglonTipo, @RenglonID, @Articulo, @Almacen, @Sucursal, @Unidad) 
      END
    END
    FETCH NEXT FROM crLista INTO @Articulo
  END -- While
  CLOSE crLista
  DEALLOCATE crLista
  IF @Modulo = 'INV' UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @ID
  RETURN
END
GO


-- spMovReciboEliminar 'COMS', 2, 'A1', '0', '0', 0, '0', '30/12/1899'
/**************** spMovReciboEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovReciboEliminar') and type = 'P') drop procedure dbo.spMovReciboEliminar
GO             
CREATE PROCEDURE spMovReciboEliminar
			@Modulo		char(5),
			@ID		int,
			@Articulo	char(20),
			@SubCuenta	varchar(20),
			@Unidad		varchar(50),
			@Costo		float,
			@Lote		varchar(50),
			@Caducidad	datetime
--//WITH ENCRYPTION
AS BEGIN
  IF @Caducidad = CONVERT(datetime, '30/12/1899', 103) SELECT @Caducidad = NULL
  DELETE MovRecibo WHERE Modulo = @Modulo AND ModuloID = @ID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(NULLIF(RTRIM(@SubCuenta), '0'), '') AND ISNULL(Unidad, '') = ISNULL(NULLIF(RTRIM(@Unidad), '0'), '') AND ISNULL(Costo, 0) = ISNULL(@Costo, 0) AND ISNULL(Lote, '') = ISNULL(NULLIF(RTRIM(@Lote), '0'), '') AND Caducidad = @Caducidad
  RETURN
END
GO

/**************** spMovReciboValidar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovReciboValidar') and type = 'P') drop procedure dbo.spMovReciboValidar
GO             
CREATE PROCEDURE spMovReciboValidar
		    @Empresa		char(5),
		    @Fecha		datetime,
		    @Modulo		char(5),
		    @ID			int,
		    @Cuenta		char(10),
		    @AplicaMov		char(20),
		    @AplicaMovID	varchar(20),
                    @Articulo		char(20),
		    @SubCuenta		varchar(50),
		    @Cantidad		float,
		    @Unidad		varchar(50),
		    @Costo		float,
		    @Caducidad		datetime,
		    @Lote		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok			int,
    @OkRef		varchar(255),
    @LotesFijos		bit,
    @TieneCaducidad	bit,
    @CaducidadMinima	int,
    @CfgCompraCaducidad	bit,
    @AplicaID		int,
    @CantidadPendiente	float,
    @CantidadRecibida	float,
    @CostoAnterior	float,
    @Factor		float

  SELECT @Ok = NULL, @OkRef = NULL, @AplicaID = NULL, @AplicaMov = NULLIF(NULLIF(RTRIM(@AplicaMov), '0'), ''), @AplicaMovID = NULLIF(NULLIF(RTRIM(@AplicaMovID), '0'), '')
  SELECT @SubCuenta = NULLIF(NULLIF(RTRIM(@SubCuenta), '0'), ''), @Unidad = NULLIF(NULLIF(RTRIM(@Unidad), '0'), ''), @Lote = NULLIF(NULLIF(RTRIM(@Lote), '0'), '')
  SELECT @LotesFijos = ISNULL(LotesFijos, 0), @TieneCaducidad = ISNULL(TieneCaducidad, 0), @CaducidadMinima = NULLIF(CaducidadMinima, 0) FROM Art WHERE Articulo = @Articulo
  SELECT @CfgCompraCaducidad = ISNULL(CompraCaducidad, 0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF @AplicaMov IS NOT NULL
  BEGIN
    IF @Modulo = 'COMS' SELECT @AplicaID = ID FROM Compra WHERE Empresa = @Empresa AND Proveedor = @Cuenta AND Estatus = 'PENDIENTE' AND Mov = @AplicaMov AND MovID = @AplicaMovID ELSE
    IF @Modulo = 'INV'  SELECT @AplicaID = ID FROM Inv    WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE' AND Mov = @AplicaMov AND MovID = @AplicaMovID 
  END

  SELECT @Factor = Factor FROM Unidad WHERE Unidad = @Unidad
  IF @Modulo = 'COMS' AND @LotesFijos = 1 AND @Lote IS NULL SELECT @Ok = 20060 ELSE
  IF NULLIF(@Cantidad, 0) IS NULL SELECT @Ok = 20010 ELSE
  IF @Unidad IS NULL SELECT @Ok = 20130 ELSE
  IF NULLIF(@Costo, 0) IS NULL SELECT @Ok = 20100 ELSE
  IF @Modulo = 'COMS' AND @CfgCompraCaducidad = 1 AND @TieneCaducidad = 1 AND @CaducidadMinima IS NOT NULL
  BEGIN
    IF @Caducidad IS NULL SELECT @Ok = 25125 ELSE
    IF @Caducidad < DATEADD(day, @CaducidadMinima, @Fecha) SELECT @Ok = 25126 
  END

  IF @Ok IS NULL AND @AplicaID IS NOT NULL 
  BEGIN
    IF @Modulo = 'COMS' 
      SELECT @CantidadPendiente = ISNULL(SUM(CantidadPendiente*Factor), 0)
        FROM CompraD 
       WHERE ID = @AplicaID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(CantidadPendiente, 0) > 0
    ELSE
    IF @Modulo = 'INV' 
      SELECT @CantidadPendiente = ISNULL(SUM(CantidadPendiente*Factor), 0)
        FROM InvD 
       WHERE ID = @AplicaID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(CantidadPendiente, 0) > 0
  
    SELECT @CantidadRecibida = ISNULL(SUM(r.Cantidad*u.Factor), 0)
      FROM MovRecibo r, Unidad u
     WHERE r.Modulo = @Modulo AND r.ModuloID = @ID AND r.Articulo = @Articulo AND ISNULL(r.SubCuenta, '') = ISNULL(@SubCuenta, '') 
       AND r.Unidad = u.Unidad

    IF @CantidadPendiente < @CantidadRecibida + (@Cantidad * @Factor)
    BEGIN
      IF @CantidadPendiente = 0 SELECT @Ok = 30191 ELSE SELECT @Ok = 30193
    END ELSE BEGIN
      SELECT @CostoAnterior = NULL 
      SELECT @CostoAnterior = NULLIF(MIN(Costo), 0)
        FROM MovRecibo 
       WHERE Modulo = @Modulo AND ModuloID = @ID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Unidad = @Unidad AND ISNULL(Lote, '') = ISNULL(@Lote, '')
      IF @CostoAnterior IS NOT NULL AND @Costo <> @CostoAnterior SELECT @Ok = 20101
    END     
  END

  IF @Ok IS NULL
    SELECT @Ok
  ELSE
    SELECT Descripcion + ' ' + ISNULL(@OkRef, '') FROM MensajeLista WHERE Mensaje = @Ok  
  RETURN
END
GO

-- spMovReciboAceptar 'COMS', 6, 'Orden Compra', 1
/**************** spMovReciboAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovReciboAceptar') and type = 'P') drop procedure dbo.spMovReciboAceptar
GO             
CREATE PROCEDURE spMovReciboAceptar
			@Modulo		char(5),
			@ID		int,
		    	@AplicaMov	varchar(20),
		    	@AplicaMovID	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa			char(5),
    @Sucursal			int,
    @Estatus			char(15),
    @ZonaImpuesto		varchar(30),
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @Renglon			float,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @Articulo			char(20), 
    @SubCuenta			varchar(20), 
    @Cantidad			float, 
    @CantidadInventario 	float,
    @ReciboCantidad		float, 
    @ReciboCosto		float, 
    @Unidad			varchar(50), 
    @Costo			float, 
    @Lote			varchar(50), 
    @Caducidad			datetime, 
    @Impuesto1			float, 
    @Impuesto2			float, 
    @Impuesto3			float, 
    @ArtTipo 			varchar(20),
    @Almacen			char(10),
    @AlmacenDestino		char(10),
    @AplicaID			int,
    @LotesFijos			bit,
    @TieneCaducidad		bit,
    @AplicaUnidad		varchar(50), 
    @Factor			float,
    @AplicaFactor		float,
    @DescuentoGlobal		float,
    @Descuento			varchar(50),
    @Condicion			varchar(50),
    @Referencia			varchar(50),
    @AplicaContUso		varchar(20),
    @AplicaDescuentoLinea	float,
    @DescuentoImporte		float,
    @Origen			varchar(20),
    @OrigenID			varchar(20),
    @FechaEmision		datetime,
    @Contacto			varchar(10),
    @EnviarA			int,
    @Mov			varchar(20)

  BEGIN TRANSACTION

  SELECT @ZonaImpuesto = NULL, @AplicaID = NULL, @AplicaMov = NULLIF(RTRIM(NULLIF(@AplicaMov, '0')), ''), @AplicaMovID = NULLIF(RTRIM(NULLIF(@AplicaMovID, '0')), '')

  IF @Modulo = 'COMS'
  BEGIN
    SELECT @FechaEmision = FechaEmision, @Contacto = Proveedor, @Empresa = Empresa, @Sucursal = Sucursal, @ZonaImpuesto = NULLIF(RTRIM(ZonaImpuesto), ''), @Almacen = Almacen, @Mov = Mov FROM Compra WHERE ID = @ID
    SELECT @Renglon = ISNULL(MAX(Renglon), 0.0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM CompraD WHERE ID = @ID
    SELECT @AplicaID = ID, @DescuentoGlobal = DescuentoGlobal, @Descuento = Descuento, @Condicion = Condicion, @Referencia = Referencia, @Origen = Origen, @OrigenID = OrigenID FROM Compra WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE' AND Mov = @AplicaMov AND MovID = @AplicaMovID
  END ELSE
  IF @Modulo = 'INV'
  BEGIN
    SELECT @FechaEmision = FechaEmision, @Empresa = Empresa, @Sucursal = Sucursal, @Almacen = Almacen, @Mov = Mov FROM Inv WHERE ID = @ID
    SELECT @Renglon = ISNULL(MAX(Renglon), 0.0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM InvD WHERE ID = @ID
    SELECT @AplicaID = ID, @Referencia = Referencia, @Origen = Origen, @OrigenID = OrigenID FROM Inv WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE' AND Mov = @AplicaMov AND MovID = @AplicaMovID
  END 

  SELECT @CfgMultiUnidades = MultiUnidades, 
         @CfgMultiUnidadesNivel = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  IF @Modulo = 'COMS' DELETE CompraD WHERE ID = @ID
  IF @Modulo = 'INV'  DELETE InvD    WHERE ID = @ID
  DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID

  DECLARE crMovReciboAceptar CURSOR
      FOR SELECT r.Articulo, r.SubCuenta, r.Cantidad, r.Unidad, r.Costo, NULLIF(RTRIM(r.Lote), ''), r.Caducidad, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Tipo, a.LotesFijos, a.TieneCaducidad
            FROM MovRecibo r, Art a 
           WHERE r.Modulo = @Modulo AND r.ModuloID = @ID AND r.Articulo = a.Articulo
  OPEN crMovReciboAceptar
  FETCH NEXT FROM crMovReciboAceptar INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @Costo, @Lote, @Caducidad, @Impuesto1, @Impuesto2, @Impuesto3, @ArtTipo, @LotesFijos, @TieneCaducidad
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Cantidad > 0
    BEGIN
      IF @LotesFijos = 0 SELECT @Lote = NULL
      IF @TieneCaducidad = 0 SELECT @Caducidad = NULL
      EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
      EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Contacto, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
      EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT

      SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1
      EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

      SELECT @Factor = @CantidadInventario / @Cantidad
      SELECT @ReciboCantidad = @Cantidad,
             @ReciboCosto = @Costo,
             @AplicaUnidad = @Unidad

      IF @Modulo = 'COMS'
      BEGIN
        IF @AplicaID IS NOT NULL
        BEGIN
          SELECT @AplicaUnidad = MIN(Unidad), @AplicaFactor = MIN(Factor), @AplicaContUso = MIN(ContUso), @AplicaDescuentoLinea = MIN(DescuentoLinea)
            FROM CompraD 
           WHERE ID = @AplicaID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(CantidadPendiente, 0) > 0
          SELECT @ReciboCantidad = @Cantidad * @Factor / @AplicaFactor,
                 @ReciboCosto = @Costo / @Factor * @AplicaFactor
        END
        EXEC xpCantidadInventario @Articulo, @SubCuenta, @AplicaUnidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @ReciboCantidad, @CantidadInventario OUTPUT
        SELECT @DescuentoImporte = @ReciboCantidad * @ReciboCosto * (@AplicaDescuentoLinea/100.0)
        INSERT CompraD (Sucursal,  ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  DescuentoLinea,        DescuentoImporte,  Unidad,        Cantidad,        CantidadInventario,  Almacen,  Aplica,     AplicaID,     Costo,        Impuesto1,  Impuesto2,  Impuesto3,          FechaCaducidad, ContUso)
                VALUES (@Sucursal, @ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @AplicaDescuentoLinea, @DescuentoImporte, @AplicaUnidad, @ReciboCantidad, @CantidadInventario, @Almacen, @AplicaMov, @AplicaMovID, @ReciboCosto, @Impuesto1, @Impuesto2, @Impuesto3*@Factor, @Caducidad,     @AplicaContUso)
      END ELSE
      IF @Modulo = 'INV'
      BEGIN
        IF @AplicaID IS NOT NULL
        BEGIN
          SELECT @AlmacenDestino = AlmacenDestino FROM Inv WHERE ID = @AplicaID
          UPDATE InvD SET Almacen = @AlmacenDestino WHERE ID = @AplicaID AND Almacen <> @AlmacenDestino

          SELECT @AplicaUnidad = MIN(Unidad), @AplicaFactor = MIN(Factor), @AplicaContUso = MIN(ContUso) 
            FROM InvD 
           WHERE ID = @AplicaID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(CantidadPendiente, 0) > 0
          SELECT @ReciboCantidad = @Cantidad * @Factor / @AplicaFactor,
                 @ReciboCosto = @Costo / @Factor * @AplicaFactor
        END
        EXEC xpCantidadInventario @Articulo, @SubCuenta, @AplicaUnidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @ReciboCantidad, @CantidadInventario OUTPUT
        INSERT InvD (Sucursal,  ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Unidad,        Cantidad,        CantidadInventario,  Almacen,  Aplica,     AplicaID,     Costo,        ContUso)
             VALUES (@Sucursal, @ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @AplicaUnidad, @ReciboCantidad, @CantidadInventario, @Almacen, @AplicaMov, @AplicaMovID, @ReciboCosto, @AplicaContUso)
      END 

      IF @Modulo = 'INV'
        INSERT SerieLoteMov (Empresa, Sucursal,  Modulo, ID,    RenglonID,  Articulo,  SubCuenta,              SerieLote, Cantidad, ArtCostoInv) 
                     SELECT  @Empresa, @Sucursal, @Modulo, @ID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), SerieLote, Cantidad, ArtCostoInv
                       FROM fnSerieLoteMovParcial (@Empresa, @Modulo, @AplicaID, @Articulo, @SubCuenta, @CantidadInventario)
      ELSE
      IF @Lote IS NOT NULL
        INSERT SerieLoteMov (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  SubCuenta,              SerieLote, Cantidad) 
                     VALUES (@Empresa, @Sucursal, @Modulo, @ID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), @Lote,     @CantidadInventario) 

    END
    FETCH NEXT FROM crMovReciboAceptar INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @Costo, @Lote, @Caducidad, @Impuesto1, @Impuesto2, @Impuesto3, @ArtTipo, @LotesFijos, @TieneCaducidad
  END  -- While
  CLOSE crMovReciboAceptar
  DEALLOCATE crMovReciboAceptar

  IF @Modulo = 'COMS'
  BEGIN
    IF EXISTS(SELECT * FROM CompraD WHERE ID = @ID) SELECT @Estatus = 'BORRADOR' ELSE SELECT @Estatus = 'SINAFECTAR' 
    UPDATE Compra SET OrigenTipo = @Modulo, Origen = @AplicaMov, OrigenID = @AplicaMovID, Estatus = @Estatus, Directo = CASE WHEN @AplicaMov IS NULL THEN 1 ELSE 0 END, RenglonID = @RenglonID, DescuentoGlobal = @DescuentoGlobal, Descuento = @Descuento, Condicion = @Condicion, Referencia = ISNULL(NULLIF(RTRIM(Referencia), ''), @Referencia) WHERE ID = @ID
  END ELSE
  IF @Modulo = 'INV'
  BEGIN
    IF EXISTS(SELECT * FROM InvD WHERE ID = @ID) SELECT @Estatus = 'BORRADOR' ELSE SELECT @Estatus = 'SINAFECTAR' 
    UPDATE Inv SET OrigenTipo = @Modulo, Origen = @AplicaMov, OrigenID = @AplicaMovID, Estatus = @Estatus, Directo = CASE WHEN @AplicaMov IS NULL THEN 1 ELSE 0 END, RenglonID = @RenglonID, Referencia = ISNULL(NULLIF(RTRIM(Referencia), ''), @Referencia) WHERE ID = @ID
  END 

  COMMIT TRANSACTION
  RETURN
END
GO


/**************** spTransferirLoteSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTransferirLoteSugerir') and type = 'P') drop procedure dbo.spTransferirLoteSugerir
GO             
CREATE PROCEDURE spTransferirLoteSugerir
			@Estacion	int,
			@Empresa	char(5),
			@Articulo	char(20),
			@SubCuenta	varchar(20),
			@Almacen	char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal	int

  SELECT @SubCuenta = ISNULL(NULLIF(RTRIM(@SubCuenta), '0'), '')
  DELETE TransferirLote WHERE Estacion = @Estacion
  SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
  INSERT TransferirLote (Estacion, Almacen) SELECT @Estacion, Almacen FROM Alm WHERE Sucursal = @Sucursal AND Tipo = 'Normal'
  SELECT "Existencia" = COUNT(*) FROM SerieLote WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Almacen = @Almacen AND Existencia > 0
  RETURN
END
GO

-- spTransferirLoteGenerar 101, 'DEMO', 'L1', 'STOCK', 'DEMO', '1/1/4'
/**************** spTransferirLoteGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTransferirLoteGenerar') and type = 'P') drop procedure dbo.spTransferirLoteGenerar
GO             
CREATE PROCEDURE spTransferirLoteGenerar
			@Estacion	int,
			@Empresa	char(5),
			@Articulo	char(20),
			@SubCuenta	varchar(20),
			@Almacen	char(10),
			@Usuario	char(10),
			@FechaEmision	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal			int,
    @ID				int,
    @Mov			char(20),
    @Destino			char(10),
    @Lotes			int,
    @Consecutivo		int,
    @Referencia			varchar(50), 
    @Moneda			char(10),
    @TipoCambio			float,
    @Cantidad			float,
    @Unidad			varchar(50),
    @Conteo			int,
    @Ok				int,
    @OkRef			varchar(255),
    @CfgSeriesLotesAutoOrden	varchar(20),
    @SeriesLotesAutoOrden	varchar(20)

  SELECT @Conteo = 0, @Ok = NULL, @OkRef = NULL
  SELECT @CfgSeriesLotesAutoOrden    = ISNULL(UPPER(RTRIM(SeriesLotesAutoOrden)), 'NO')
    FROM EmpresaCfg
   WHERE Empresa = @Empresa 
  SELECT @SeriesLotesAutoOrden = ISNULL(NULLIF(NULLIF(RTRIM(UPPER(SeriesLotesAutoOrden)), ''), '(EMPRESA)'), @CfgSeriesLotesAutoOrden)
    FROM Art 
   WHERE Articulo = @Articulo
  SELECT @SubCuenta = ISNULL(NULLIF(RTRIM(@SubCuenta), '0'), '')
  SELECT @Unidad = Unidad FROM Art WHERE Articulo = @Articulo
  SELECT @Mov = InvTransferencia FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  EXEC spConsecutivo 'Transferir Lotes', @Sucursal, @Consecutivo OUTPUT
  SELECT @Referencia = CONVERT(varchar, @Consecutivo)

  DECLARE crTransferirLote CURSOR
      FOR SELECT Almacen, Cantidad
            FROM TransferirLote
           WHERE Estacion = @Estacion AND ISNULL(Cantidad, 0) > 0 
  OPEN crTransferirLote
  FETCH NEXT FROM crTransferirLote INTO @Destino, @Lotes
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      INSERT Inv (UltimoCambio, Sucursal,  Empresa, Usuario,    Estatus,     Mov,  FechaEmision,  Almacen,  AlmacenDestino, Moneda,  TipoCambio,  Referencia, RenglonID)
          SELECT GETDATE(),     @Sucursal, @Empresa, @Usuario, 'SINAFECTAR', @Mov, @FechaEmision, @Almacen, @Destino,       @Moneda, @TipoCambio, @Referencia, 1
      SELECT @ID = SCOPE_IDENTITY()

      INSERT SerieLoteMov (Empresa, Sucursal, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
      SELECT @Empresa, @Sucursal, 'INV', @ID, 1, @Articulo, @SubCuenta, SerieLote, Existencia
        FROM SerieLote
       WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote IN (SELECT SerieLote FROM dbo.fnCantidadLote(@Empresa, @Almacen, @Articulo, @SubCuenta, @Lotes, @SeriesLotesAutoOrden))
      SELECT @Cantidad = SUM(Cantidad) FROM SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID AND RenglonID = 1 AND Articulo = @Articulo
      INSERT InvD (Sucursal,  ID,  Renglon, RenglonSub, RenglonID, Articulo,  SubCuenta,  Cantidad,  CantidadInventario,  Unidad, Almacen)
            SELECT @Sucursal, @ID,  2048.0, 0,          1,         @Articulo, @SubCuenta, @Cantidad, @Cantidad,           @Unidad, @Almacen
     
     EXEC spAfectar 'INV', @ID, @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
     IF @Ok IS NULL
       UPDATE CB 
          SET Referencia = @Referencia 
        WHERE TipoCuenta = 'Articulos' AND Cuenta = @Articulo AND SerieLote IN (SELECT SerieLote FROM SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID)

     SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crTransferirLote INTO @Destino, @Lotes
  END  -- While
  CLOSE crTransferirLote
  DEALLOCATE crTransferirLote

  IF @Ok IS NULL
    SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+' '+RTRIM(@Mov)
  ELSE
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  RETURN
END
GO


-- spSerieLoteCalidad 'DEMO', 'L1', '', 'MX100'
-- select * from SerieLoteCalidad 
/**************** spSerieLoteCalidad ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSerieLoteCalidad') and type = 'P') drop procedure dbo.spSerieLoteCalidad
GO             
CREATE PROCEDURE spSerieLoteCalidad
			@Empresa	char(5),
			@Articulo	char(20),
			@SubCuenta	varchar(20),
			@SerieLote	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @SubCuenta = ISNULL(NULLIF(RTRIM(@SubCuenta), '0'), '')
  IF NOT EXISTS(SELECT * FROM SerieLoteCalidad WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @SerieLote)
    INSERT SerieLoteCalidad 
          (Empresa,  Articulo,  SubCuenta,  SerieLote,  Evaluacion)
    SELECT @Empresa, @Articulo, @SubCuenta, @SerieLote, Evaluacion
      FROM ArtCalidad
     WHERE Articulo = @Articulo
  RETURN
END
GO

-- spCambioPresentacionSugerir 'DEMO', 'STOCK', 'A2', 10
/**************** spCambioPresentacionSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCambioPresentacionSugerir') and type = 'P') drop procedure dbo.spCambioPresentacionSugerir
GO             
CREATE PROCEDURE spCambioPresentacionSugerir
			@Empresa	        char(5),
			@Almacen                char(10),
			@NuevaPresentacion	char(20),
			@Cantidad	        float
--//WITH ENCRYPTION
AS BEGIN
  SELECT p.Articulo, "Descripcion" = a.Descripcion1, d.Disponible 
    FROM ArtPresenta p, ArtDisponible d, Art a 
   WHERE p.Presentacion = @NuevaPresentacion
     AND d.Empresa = @Empresa AND d.Almacen = @Almacen AND d.Articulo = p.Articulo
     AND d.Disponible/p.Factor >= @Cantidad
     AND p.Articulo = a.Articulo
  RETURN
END
GO


/**************** spCambioPresentacionGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCambioPresentacionGenerar') and type = 'P') drop procedure dbo.spCambioPresentacionGenerar
GO             
CREATE PROCEDURE spCambioPresentacionGenerar
                        @Empresa               char(5),
                        @Almacen               char(10),
                        @Articulo              char(20),
                        @NuevaPresentacion     char(20),
                        @Cantidad              float,
                        @Unidad                varchar(50),
                        @Modulo                char(5),
                        @ID                    int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Fecha		       datetime,
    @IDGenerar                 int,
    @CfgMultiUnidades	       bit,
    @CfgMultiUnidadesNivel     char(20),
    @Origen         	       varchar(20),
    @OrigenID         	       varchar(20),
    @IDDestino		       int,
    @DestinoTipo	       char(10),
    @Destino		       varchar(20),
    @DestinoID		       varchar(20),
    @DestinoMoneda	       char(10),
    @ArtTipo                   varchar(20),
    @SubCuenta                 varchar(50),
    @Mov 		       char(20),
    @MovID 		       varchar(20),
    @Moneda     	       char(10),
    @TipoCambio 	       float,
    @Ok         	       int,
    @OkRef      	       varchar(255),
    @Usuario    	       char(10),
    @Sucursal   	       int,
    @SucursalOrigen	       int,
    @RenglonTipo               char(1),
    @CantidadInventario        float 

  SELECT @Ok = 0,@OkRef = NULL, @SubCuenta = NULL, @DestinoTipo = NULL, @Destino = NULL, @DestinoID = NULL
  SELECT @Fecha = GETDATE()
  EXEC spExtraerFecha @Fecha OUTPUT

  SELECT @Mov = cfg.InvCambioPresentacion  
    FROM EmpresaCfgMov cfg 
   WHERE cfg.Empresa = @Empresa

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT @Sucursal = Sucursal, 
         @SucursalOrigen = SucursalOrigen, 
         @Usuario = Usuario, 
         @Origen = Mov, 
         @OrigenID = MovID, 
         @Moneda = Moneda, 
         @TipoCambio = TipoCambio 
    FROM Inv
   WHERE ID = @ID 

  INSERT INTO Inv  (Empresa,     Mov,  FechaEmision, Moneda,  TipoCambio,  Estatus    ,  Directo,  Almacen,  Usuario,  Sucursal,  SucursalOrigen,   OrigenTipo,  Origen,  OrigenID)
  VALUES           (@Empresa,    @Mov, @Fecha,       @Moneda, @TipoCambio, 'SINAFECTAR', 1,        @Almacen, @Usuario, @Sucursal, @SucursalOrigen,  'INV',       @Origen, @OrigenID)

  SELECT @IDGenerar = SCOPE_IDENTITY()

  SELECT @ArtTipo = Tipo FROM Art WHERE Articulo = @Articulo
  EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
  EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

  INSERT INTO InvD
          (ID,         Renglon, RenglonID,  RenglonTipo,  Almacen,  Articulo,   SubCuenta,  ArticuloDestino,    Cantidad,  Unidad,  CantidadInventario,  Sucursal,  SucursalOrigen)
  VALUES  (@IDGenerar, 2048.0,  1,          @RenglonTipo, @Almacen, @Articulo,  @SubCuenta, @NuevaPresentacion, @Cantidad, @Unidad, @CantidadInventario, @Sucursal, @SucursalOrigen)

  EXEC spAfectar 'INV', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  SELECT @Mov = ISNULL(Mov, ''), @MovID = ISNULL(MovID, '')
    FROM Inv
   WHERE ID = @IDGenerar

  IF @Ok IS NULL
    EXEC xpCambioPresentacionGenerar @Empresa, @Almacen, @Articulo, @NuevaPresentacion, @Cantidad, @Unidad, @Modulo, @ID

  IF @Ok IS NULL
  BEGIN
    SELECT @DestinoTipo = DestinoTipo, @Destino = Destino, @DestinoID = DestinoID FROM InvD WHERE ID = @ID AND Articulo = @NuevaPresentacion
    IF @DestinoTipo = 'VTAS'
    BEGIN
      EXEC spMovEnID @DestinoTipo, @Empresa, @Destino, @DestinoID, @IDDestino OUTPUT, @DestinoMoneda OUTPUT, @Ok OUTPUT
      UPDATE VentaD SET DescripcionExtra = @Articulo WHERE ID = @IDDestino AND Articulo = @NuevaPresentacion AND NULLIF(CantidadOrdenada, 0) IS NOT NULL
    END
  END

  IF @Ok IS NULL
    SELECT 'Se Genero con Exito ' + @Mov + ' ' + @MovID 
  ELSE
    SELECT Descripcion + ' ' + ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  RETURN
END
GO

/**************** spAutoBoletoMovAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAutoBoletoMovAceptar') and type = 'P') drop procedure dbo.spAutoBoletoMovAceptar
GO             
CREATE PROCEDURE spAutoBoletoMovAceptar
                        @Empresa        char(5),
                        @Modulo         char(5),
                        @ID             int,
                        @RenglonID      int,
                        @Articulo       char(20),
                        @SubCuenta      varchar(50),
                        @AsignarBoletos bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cantidad        float,
    @BoletoD         varchar(20),
    @BoletoA         varchar(20)

  IF @AsignarBoletos = 1
  BEGIN
    SELECT @BoletoD = NULL, 
           @BoletoA = NULL, 
           @SubCuenta = NULLIF(NULLIF(RTRIM(@SubCuenta), ''), '0')

    DECLARE crAutoBoletoMov CURSOR FOR
     SELECT Cantidad
       FROM AutoBoletoMov
      WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')

    OPEN crAutoBoletoMov
    FETCH NEXT FROM crAutoBoletoMov INTO @Cantidad
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @BoletoD = SerieLoteD,
               @BoletoA = SerieLoteA
          FROM dbo.fnSerieLoteMovDelAl(@Empresa, @Modulo, @ID, @RenglonID, @Articulo, @SubCuenta, @BoletoA, @Cantidad)

        UPDATE AutoBoletoMov
           SET BoletoD = @BoletoD,
               BoletoA = @BoletoA
         WHERE CURRENT OF crAutoBoletoMov
      END
      FETCH NEXT FROM crAutoBoletoMov INTO @Cantidad
    END -- While
    CLOSE crAutoBoletoMov
    DEALLOCATE crAutoBoletoMov
  END

  RETURN
END
GO

/**************** spCteRenombrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCteRenombrar') and type = 'P') drop procedure dbo.spCteRenombrar
GO             
CREATE PROCEDURE spCteRenombrar
			@ClaveA		varchar(20),
			@ClaveN		varchar(20),
			@EnSilencio	bit		= 0,
			@Conexion	bit		= 0,
			@Conteo		int		= 0	OUTPUT,
			@Ok		int		= NULL	OUTPUT,
			@OkRef		varchar(255)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF EXISTS(SELECT * FROM Cte WHERE Cliente = @ClaveA) AND NOT EXISTS(SELECT * FROM Cte WHERE Cliente = @ClaveN)
  BEGIN
    BEGIN TRY
      IF @Conexion = 0
        BEGIN TRANSACTION

      UPDATE Cte		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Cxc		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Venta		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Excel		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE OutlookNombre	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE MovDReg		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE EmpresaCfgPV 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Sucursal       	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE MensajeSalida     	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE SerieLote		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE SerieLoteMov 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE EspacioAsignacion 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AutoBoleto 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Cambio		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Compra		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CompraD		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CxcAplicaDif 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Neteo 		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Dinero		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE EmbarqueMov 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE InvD		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProdD		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Soporte		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Vale		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ValeSerie		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE VentaResumen 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Nota		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Precio		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Recurso		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Proyecto		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Tarea		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AgenteCte		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEnviarAOtrosDatos SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEnviarAHist	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEnviarA 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEnviarALimite 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteRelacion 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteArtBloqueo  	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteBonificacion  	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteHist 		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteCtoComites 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteCtoActividad 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteCtoDireccion 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteCtoHist 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteCto		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteAcceso 		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CtePedidoDef 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteOtrosDatos 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEvento		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteCtoEvento 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteTel		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteUEN 		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CtePension 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteCapacidadPago 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CtePresupuesto 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteRep		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteDepto		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteMapeoMov 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteDeptoEnviarA 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEntregaMercancia SET Cliente = @ClaveN  WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEstadoFinanciero SET Cliente = @ClaveN  WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEmpresaCFD	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteCFD		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteUsoServicio 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ArtCte		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ArtCteCompetencia 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE VINHist		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE VIN		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ActivoF 		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Personal		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Beneficiario 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Rep		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Socio		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE WebUsuario 	SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CRVenta		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CRCobro		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CRSoporte		SET Cliente = @ClaveN	WHERE Cliente = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE Usuario		SET Cliente = @ClaveN		WHERE Cliente = @ClaveA					SELECT @Conteo = @Conteo + @@ROWCOUNT      
      UPDATE Usuario		SET DefCliente = @ClaveN	WHERE DefCliente = @ClaveA				SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Gasto		SET ClienteRef = @ClaveN	WHERE ClienteRef = @ClaveA				SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE LCAval		SET Aval = @ClaveN		WHERE Aval = @ClaveA					SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CRMov		SET ClienteIntelisis = @ClaveN	WHERE ClienteIntelisis = @ClaveA			SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CRMovSoporte 	SET ClienteIntelisis = @ClaveN	WHERE ClienteIntelisis = @ClaveA			SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CB			SET Cuenta = @ClaveN		WHERE Cuenta = @ClaveA AND TipoCuenta = 'Cliente'	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CtaSituacionProg  	SET Cuenta = @ClaveN		WHERE Cuenta = @ClaveA AND TipoCuenta = 'Cliente'	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE Cont		SET Contacto = @ClaveN	WHERE Contacto = @ClaveA AND ContactoTipo = 'Cliente'	SELECT @Conteo = @Conteo + @@ROWCOUNT      
      UPDATE Dinero		SET Contacto = @ClaveN	WHERE Contacto = @ClaveA AND ContactoTipo = 'Cliente'	SELECT @Conteo = @Conteo + @@ROWCOUNT      
      UPDATE FiscalD 		SET Contacto = @ClaveN	WHERE Contacto = @ClaveA AND ContactoTipo = 'Cliente'	SELECT @Conteo = @Conteo + @@ROWCOUNT      
      UPDATE CampanaD		SET Contacto = @ClaveN	WHERE Contacto = @ClaveA AND ContactoTipo = 'Cliente'	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE Prop		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='CXC'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ListaD		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='CXC'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AnexoCta		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='CXC'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CuentaTarea	SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='CXC'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      
      UPDATE Auxiliar		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama IN ('CXC','CEFE','CNO','CRND','CVALE')	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Acum		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama IN ('CXC','CEFE','CNO','CRND','CVALE')	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Saldo		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama IN ('CXC','CEFE','CNO','CRND','CVALE')	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE AuxiliarRU		SET Grupo = @ClaveN	WHERE Grupo = @ClaveA AND Rama IN ('VTAS')	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AcumRU		SET Grupo = @ClaveN	WHERE Grupo = @ClaveA AND Rama IN ('VTAS')	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE SaldoRU		SET Grupo = @ClaveN	WHERE Grupo = @ClaveA AND Rama IN ('VTAS')	SELECT @Conteo = @Conteo + @@ROWCOUNT

      IF @Conexion = 0
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
      SELECT @Ok = 1, @OkRef = ERROR_MESSAGE()
      IF @Conexion = 0
        ROLLBACK TRANSACTION 
    END CATCH
  END ELSE
    SELECT @Ok =10066, @OkRef = 'De '+ISNULL(@ClaveA, '')+' al '+ISNULL(@ClaveN, '')

  RETURN
END
GO

/**************** spProvRenombrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProvRenombrar') and type = 'P') drop procedure dbo.spProvRenombrar
GO             
CREATE PROCEDURE spProvRenombrar
			@ClaveA		varchar(20),
			@ClaveN		varchar(20),
			@EnSilencio	bit		= 0,
			@Conexion	bit		= 0,
			@Conteo		int		= 0	OUTPUT,
			@Ok		int		= NULL	OUTPUT,
			@OkRef		varchar(255)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF EXISTS(SELECT * FROM Prov WHERE Proveedor = @ClaveA) AND NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = @ClaveN)
  BEGIN
    BEGIN TRY
      IF @Conexion = 0
        BEGIN TRANSACTION

      UPDATE Prov		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT          
      UPDATE Compra		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE OutlookNombre 	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Anuncio		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PC			SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Oferta 		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ActivoFijo 	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Neteo		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE EmbarqueMov  	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Embarque		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Soporte		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Recurso		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Proyecto		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProyD		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Proy		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Tarea		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteRep		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ArtProvUnidad 	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ArtProvSucursal 	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ArtProvHist 	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ArtProv		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ArtPlanEx		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Art		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProvAutoCargos 	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProvCuotaDesc 	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProvCuota		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProvCuota		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProvSucursal  	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProvCredito 	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProvRelacion  	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProvCB		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Vehiculo		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE SugerirCostoArtCat SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Centro		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Rep		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE WebUsuario 	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PlanArtOP		SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PlanArtOPHist 	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PlanBitacora 	SET Proveedor = @ClaveN	WHERE Proveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE InvGastoDiversoD		SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE InvGastoDiverso		SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CompraGastoDiversoD	SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CompraGastoDiverso		SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Gasto			SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Tramite			SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE MovReg			SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ConciliacionD		SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Credito			SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE LCHist			SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE LC				SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Incidencia 		SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      --UPDATE NominaReciboD		SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE VentaParticipacion 	SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ObligacionFiscal		SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Fiscal			SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ConceptoAcreedor 		SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Tramite			SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CtaDinero			SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Agente			SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CtePension			SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE InstitucionFinConcepto  	SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Socio			SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE FordParticipaciones 	SET Acreedor = @ClaveN	WHERE Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE GastoD			SET AcreedorRef = @ClaveN	WHERE AcreedorRef = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT   
      UPDATE NominaConcepto 		SET AcreedorDef = @ClaveN	WHERE AcreedorDef = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT         
      UPDATE Concepto			SET AcreedorDef = @ClaveN	WHERE AcreedorDef = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT         

      UPDATE Venta			SET GastoAcreedor = @ClaveN	WHERE GastoAcreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Nota			SET GastoAcreedor = @ClaveN	WHERE GastoAcreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE MovTipo			SET GastoAcreedor = @ClaveN	WHERE GastoAcreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE Cxp		SET Proveedor = @ClaveN			WHERE Proveedor = @ClaveA		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Cxp		SET ProveedorAutoEndoso = @ClaveN	WHERE ProveedorAutoEndoso = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CompraD		SET ProveedorRef = @ClaveN		WHERE ProveedorRef = @ClaveA		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CompraD		SET ProveedorArt = @ClaveN		WHERE ProveedorArt = @ClaveA		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CompraD		SET ImportacionProveedor = @ClaveN	WHERE ImportacionProveedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      
      UPDATE PersonalCfg  	SET PA1Acreedor = @ClaveN		WHERE PA1Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalCfg  	SET PA2Acreedor = @ClaveN		WHERE PA2Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalCfg  	SET PA3Acreedor = @ClaveN		WHERE PA3Acreedor = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
     

      UPDATE Dinero		SET Proveedor = @ClaveN			WHERE Proveedor = @ClaveA		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Dinero		SET ProveedorAutoEndoso = @ClaveN	WHERE ProveedorAutoEndoso = @ClaveA	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Dinero		SET Contacto = @ClaveN			WHERE Contacto = @ClaveA AND ContactoTipo = 'Proveedor'	SELECT @Conteo = @Conteo + @@ROWCOUNT      
      
      UPDATE NotaD		SET ProveedorRef = @ClaveN		WHERE ProveedorRef = @ClaveA		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE VentaD       	SET ProveedorRef = @ClaveN		WHERE ProveedorRef = @ClaveA		SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE CB			SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND TipoCuenta = 'Proveedor'	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE Cont		SET Contacto = @ClaveN	WHERE Contacto = @ClaveA AND ContactoTipo = 'Proveedor'	SELECT @Conteo = @Conteo + @@ROWCOUNT      
      UPDATE FiscalD 		SET Contacto = @ClaveN	WHERE Contacto = @ClaveA AND ContactoTipo = 'Proveedor'	SELECT @Conteo = @Conteo + @@ROWCOUNT      
      UPDATE CampanaD		SET Contacto = @ClaveN	WHERE Contacto = @ClaveA AND ContactoTipo = 'Proveedor'	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE Prop		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='CXP'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ListaD		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='CXP'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AnexoCta		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='CXP'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CuentaTarea	SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='CXP'		SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE Auxiliar		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama IN ('CXP','PEFE','PRND')	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Acum		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama IN ('CXP','PEFE','PRND')	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Saldo		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama IN ('CXP','PEFE','PRND')	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE AuxiliarRU		SET Grupo = @ClaveN	WHERE Grupo = @ClaveA AND Rama IN ('COMS')	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AcumRU		SET Grupo = @ClaveN	WHERE Grupo = @ClaveA AND Rama IN ('COMS')	SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE SaldoRU		SET Grupo = @ClaveN	WHERE Grupo = @ClaveA AND Rama IN ('COMS')	SELECT @Conteo = @Conteo + @@ROWCOUNT


      IF @Conexion = 0
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
      SELECT @Ok = 1, @OkRef = ERROR_MESSAGE()
      IF @Conexion = 0
        ROLLBACK TRANSACTION 
    END CATCH
  END ELSE
    SELECT @Ok =10066, @OkRef = 'De '+ISNULL(@ClaveA, '')+' al '+ISNULL(@ClaveN, '')

  RETURN
END
GO

/**************** spPersonalRenombrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPersonalRenombrar') and type = 'P') drop procedure dbo.spPersonalRenombrar
GO             
CREATE PROCEDURE spPersonalRenombrar
			@ClaveA         varchar(20),
			@ClaveN        	varchar(20),
			@EnSilencio	bit		= 0,
			@Conexion	bit		= 0,
			@Conteo		int		= 0	OUTPUT,
			@Ok		int		= NULL	OUTPUT,
			@OkRef		varchar(255)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF EXISTS(SELECT * FROM Personal WHERE Personal = @ClaveA) AND NOT EXISTS(SELECT * FROM Personal WHERE Personal = @ClaveN)
  BEGIN
    BEGIN TRY
      IF @Conexion = 0
        BEGIN TRANSACTION

      UPDATE Personal	        SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Personal	        SET ReportaA = @ClaveN WHERE ReportaA  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT    
      UPDATE Personal	        SET RecomendadoPor = @ClaveN WHERE RecomendadoPor = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT          
      
      UPDATE OutlookNombre	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE MovPersonal 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE MovReg		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE MovDReg		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE BPlan		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE GastoD		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ActivoFijo 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AsisteD		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Incidencia 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE IncidenciaH 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Inv		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE NominaD		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE NominaPersonal 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE NominaPersonalFecha SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE NominaPersonalProy SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE NominaLog		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE NominaH		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      --UPDATE NominaIncidencia 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      --UPDATE NominaPrestamo 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      --UPDATE NominaRecibo 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE TipoLiquidacionNominaPanama SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE NominaImportar	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProdD 		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE RHD		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Soporte		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Recurso 		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Proyecto		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProyD		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Tarea 		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AgentePersonal 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Agente		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteRep		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Plaza		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalTarjeta 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalUltimoPago SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalSuc	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalAcceso 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalCfg 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalEntrada 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalEntradaH 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Rep		SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE WebUsuario 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalDatosAcademicos SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalDatosLaborales  SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalHerman	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalSpranger	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE PersonalCleaver 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE NomXPersonalGrupo 	SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      /*UPDATE CompetenciaFormatoCalificacion SET Personal = @ClaveN WHERE Personal  = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CompetenciaFormatoCalificacion SET EvaluaPersonal = @ClaveN WHERE EvaluaPersonal = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT*/

      UPDATE CxcPersonalCobradorLog SET PersonalCobrador = @ClaveN WHERE PersonalCobrador = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Cxc		    SET PersonalCobrador = @ClaveN WHERE PersonalCobrador = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Embarque		    SET PersonalCobrador = @ClaveN WHERE PersonalCobrador = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEnviarAHist	    SET PersonalCobrador = @ClaveN WHERE PersonalCobrador = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEnviarA 	    SET PersonalCobrador = @ClaveN WHERE PersonalCobrador = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Cte		    SET PersonalCobrador = @ClaveN WHERE PersonalCobrador = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE CB			SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND TipoCuenta = 'Personal'	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE Cont		SET Contacto = @ClaveN	WHERE Contacto = @ClaveA AND ContactoTipo = 'Personal'	SELECT @Conteo = @Conteo + @@ROWCOUNT      
      UPDATE Dinero		SET Contacto = @ClaveN	WHERE Contacto = @ClaveA AND ContactoTipo = 'Personal'	SELECT @Conteo = @Conteo + @@ROWCOUNT      
      UPDATE FiscalD 		SET Contacto = @ClaveN	WHERE Contacto = @ClaveA AND ContactoTipo = 'Personal'	SELECT @Conteo = @Conteo + @@ROWCOUNT      
      UPDATE CampanaD		SET Contacto = @ClaveN	WHERE Contacto = @ClaveA AND ContactoTipo = 'Personal'	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE Prop		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='NOM'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ListaD		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='NOM'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AnexoCta		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='NOM'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CuentaTarea	SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='NOM'		SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE PersonalPropValor	SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='EMP'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      
      IF @Conexion = 0
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
      SELECT @Ok = 1, @OkRef = ERROR_MESSAGE()
      IF @Conexion = 0
        ROLLBACK TRANSACTION 
    END CATCH
  END ELSE
    SELECT @Ok =10066, @OkRef = 'De '+ISNULL(@ClaveA, '')+' al '+ISNULL(@ClaveN, '')

  RETURN
END
GO

/**************** spAgenteRenombrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAgenteRenombrar') and type = 'P') drop procedure dbo.spAgenteRenombrar
GO             
CREATE PROCEDURE spAgenteRenombrar
			@ClaveA         varchar(20),
			@ClaveN        	varchar(20),
			@EnSilencio	bit		= 0,
			@Conexion	bit		= 0,
			@Conteo		int		= 0	OUTPUT,
			@Ok		int		= NULL	OUTPUT,
			@OkRef		varchar(255)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF EXISTS(SELECT * FROM Agente WHERE Agente = @ClaveA) AND NOT EXISTS(SELECT * FROM Agente WHERE Agente = @ClaveN)
  BEGIN
    BEGIN TRY
      IF @Conexion = 0
        BEGIN TRANSACTION

      UPDATE Agente		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE OutlookNombre	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Calendario		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Registro		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE MovReg		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE MovDReg		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE LCHist 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE LC			SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Cambio		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Capital		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Agent		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Compra		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Cxc		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Embarque		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Inv		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Soporte 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Vale 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE VentaResumen 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Nota		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Nota		SET AgenteServicio= @ClaveN WHERE AgenteServicio= @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Venta		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Venta		SET AgenteServicio= @ClaveN WHERE AgenteServicio= @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE NotaDAgente 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE VentaDAgente 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE NotaD		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE VentaD 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Precio		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Recurso 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Proyecto 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProyD 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Tarea 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AgenteCte 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AgenteAgenda 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AgentePersonal 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AgenteComisionTipoFactura SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE EquipoAgente 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AgenteActividad 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEnviarAHist 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteEnviarA 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteHist 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CteRep		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Cte 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE VIN  		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ProvSucursal 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Prov		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Vehiculo 		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Vehiculo 		SET Agente2       = @ClaveN WHERE Agente2       = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Vehiculo 		SET Agente3       = @ClaveN WHERE Agente3       = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Rep		SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE WebUsuario 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Prospecto  	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE Campana	 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CRAgente 	 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE TMA 	 	SET Agente        = @ClaveN WHERE Agente        = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE CompraD 	 	SET AgenteRef	          = @ClaveN WHERE AgenteRef             = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE SIC	 	SET AgentePorOmision      = @ClaveN WHERE AgentePorOmision      = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE SoporteCambio	SET AgenteAnalisisImpacto = @ClaveN WHERE AgenteAnalisisImpacto = @ClaveA SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE CB			SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND TipoCuenta = 'Agente'	SELECT @Conteo = @Conteo + @@ROWCOUNT

      UPDATE Prop		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='AGENT'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE ListaD		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='AGENT'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE AnexoCta		SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='AGENT'		SELECT @Conteo = @Conteo + @@ROWCOUNT
      UPDATE CuentaTarea	SET Cuenta = @ClaveN	WHERE Cuenta = @ClaveA AND Rama='AGENT'		SELECT @Conteo = @Conteo + @@ROWCOUNT

      IF @Conexion = 0
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
      SELECT @Ok = 1, @OkRef = ERROR_MESSAGE()
      IF @Conexion = 0
        ROLLBACK TRANSACTION 
    END CATCH
  END ELSE
    SELECT @Ok =10066, @OkRef = 'De '+ISNULL(@ClaveA, '')+' al '+ISNULL(@ClaveN, '')

  RETURN
END
GO


/**************** spVINRenombrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVINRenombrar') and type = 'P') drop procedure dbo.spVINRenombrar
GO             
CREATE PROCEDURE spVINRenombrar
			@VIND           varchar(20),
			@VINA        	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo        int

  IF EXISTS(SELECT * FROM VIN WHERE VIN = @VIND) AND NOT EXISTS(SELECT * FROM VIN WHERE VIN = @VINA)
  BEGIN
    SELECT @Conteo = 0

    UPDATE VIN                      SET VIN           = @VINA WHERE VIN           = @VIND  SELECT @Conteo = @Conteo + @@ROWCOUNT
    UPDATE VINHist                  SET VIN           = @VINA WHERE VIN           = @VIND  SELECT @Conteo = @Conteo + @@ROWCOUNT
    UPDATE VINCostoExtra            SET VIN           = @VINA WHERE VIN           = @VIND  SELECT @Conteo = @Conteo + @@ROWCOUNT
    UPDATE VINAccesorio             SET VIN           = @VINA WHERE VIN           = @VIND  SELECT @Conteo = @Conteo + @@ROWCOUNT
    UPDATE SerieLote                SET SerieLote     = @VINA WHERE SerieLote     = @VIND  SELECT @Conteo = @Conteo + @@ROWCOUNT
    UPDATE SerieLoteD               SET SerieLote     = @VINA WHERE SerieLote     = @VIND  SELECT @Conteo = @Conteo + @@ROWCOUNT
    UPDATE SerieLoteMov             SET SerieLote     = @VINA WHERE SerieLote     = @VIND  SELECT @Conteo = @Conteo + @@ROWCOUNT
    UPDATE SerieLoteAutorizacion    SET SerieLote     = @VINa WHERE SerieLote     = @VIND  SELECT @Conteo = @Conteo + @@ROWCOUNT
    UPDATE SerieLoteCalidad         SET SerieLote     = @VINA WHERE SerieLote     = @VIND  SELECT @Conteo = @Conteo + @@ROWCOUNT
    UPDATE Venta                    SET ServicioSerie = @VINA WHERE ServicioSerie = @VIND  SELECT @Conteo = @Conteo + @@ROWCOUNT
    UPDATE CompraD                  SET ServicioSerie = @VINA WHERE ServicioSerie = @VIND  SELECT @Conteo = @Conteo + @@ROWCOUNT

    SELECT 'Se Renombro con Exito.<BR><BR>'+CONVERT(varchar, @Conteo)+' Registros Afectados.'
  END ELSE
    SELECT 'No se puede Renombrar del '+ISNULL(@VIND, '')+' al '+ISNULL(@VINA, '')

  RETURN
END
GO

-- spCopiarArtVINAccesorio 'CIVIC', 'CIVIC2'
/**************** spCopiarArtVINAccesorio ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCopiarArtVINAccesorio') and type = 'P') drop procedure dbo.spCopiarArtVINAccesorio
GO             
CREATE PROCEDURE spCopiarArtVINAccesorio
                        @ArticuloD        char(20),
                        @ArticuloA        char(20)
--//WITH ENCRYPTION
AS BEGIN 
  IF @ArticuloA = @ArticuloD RETURN
  
  DELETE ArtVINAccesorio WHERE Articulo = @ArticuloA
  INSERT ArtVINAccesorio 
        (Articulo,  Modelo,  Tipo, Accesorio, Descripcion, PrecioDistribuidor, PrecioPublico, PrecioContado)
  SELECT @ArticuloA, Modelo, Tipo, Accesorio, Descripcion, PrecioDistribuidor, PrecioPublico, PrecioContado
    FROM ArtVINAccesorio 
   WHERE Articulo = @ArticuloD
END
GO

/* 
exec spArtDescuentoCompra 'A1'
select descuentocompra from art where articulo = 'A1'
*/

/**************** spArtDescuentoCompra ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtDescuentoCompra') and type = 'P') drop procedure dbo.spArtDescuentoCompra
GO             
CREATE PROCEDURE spArtDescuentoCompra
                        @Articulo	char(20)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Porcentaje		float,
    @Neto		float

  SELECT @Neto = 100.0
  DECLARE crArtDescuentoCompra CURSOR FOR
   SELECT ISNULL(Porcentaje, 0.0)
     FROM ArtDescuentoCompra
    WHERE Articulo = @Articulo
  OPEN crArtDescuentoCompra
  FETCH NEXT FROM crArtDescuentoCompra INTO @Porcentaje
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      SELECT @Neto = @Neto - (@Neto * (@Porcentaje / 100))

    FETCH NEXT FROM crArtDescuentoCompra INTO @Porcentaje
  END -- While
  CLOSE crArtDescuentoCompra
  DEALLOCATE crArtDescuentoCompra
  UPDATE Art SET DescuentoCompra = 100 - @Neto WHERE Articulo = @Articulo
END
GO



/**************** spVentaActualizarPrecios ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaActualizarPrecios') and type = 'P') drop procedure dbo.spVentaActualizarPrecios
GO             
CREATE PROCEDURE spVentaActualizarPrecios
                        @ID             int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Precio	        float,
    @ListaPrecios	varchar(50),
    @Moneda		char(10),
    @TipoCambio		float

  SELECT @ListaPrecios = ListaPreciosEsp,
         @Moneda       = Moneda,
         @TipoCambio   = TipoCambio
    FROM Venta
   WHERE ID = @ID
  DECLARE crVentaD CURSOR FOR
   SELECT Articulo, SubCuenta
     FROM VentaD
    WHERE ID = @ID

  OPEN crVentaD
  FETCH NEXT FROM crVentaD INTO @Articulo, @SubCuenta
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spVerArtPrecioDescuento @Articulo, @SubCuenta, @ListaPrecios, @Moneda, @TipoCambio, 1, @Precio OUTPUT
      UPDATE VentaD SET Precio = @Precio, PrecioSugerido = @Precio WHERE CURRENT OF crVentaD
    END
    FETCH NEXT FROM crVentaD INTO @Articulo, @SubCuenta
  END -- While
  CLOSE crVentaD
  DEALLOCATE crVentaD

  RETURN
END
GO


/**************** spCompraActualizarPrecios ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraActualizarPrecios') and type = 'P') drop procedure dbo.spCompraActualizarPrecios
GO             
CREATE PROCEDURE spCompraActualizarPrecios
                        @ID             	int,
			@UnicamenteNulos 	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Costo		float,
    @Precio	        float,
    @ListaPrecios	varchar(50),
    @Moneda		char(10),
    @TipoCambio		float

  SELECT @ListaPrecios = ListaPreciosEsp,
         @Moneda       = Moneda,
         @TipoCambio   = TipoCambio
    FROM Compra
   WHERE ID = @ID
  DECLARE crCompraD CURSOR FOR
   SELECT Articulo, SubCuenta, Costo
     FROM CompraD
    WHERE ID = @ID

  OPEN crCompraD
  FETCH NEXT FROM crCompraD INTO @Articulo, @SubCuenta, @Costo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @UnicamenteNulos = 0 OR @Costo IS NULL
      BEGIN
        EXEC spVerArtPrecioDescuento @Articulo, @SubCuenta, @ListaPrecios, @Moneda, @TipoCambio, 1, @Precio OUTPUT
        UPDATE CompraD SET Costo = @Precio WHERE CURRENT OF crCompraD
      END
    END
    FETCH NEXT FROM crCompraD INTO @Articulo, @SubCuenta, @Costo
  END -- While
  CLOSE crCompraD
  DEALLOCATE crCompraD

  RETURN
END
GO

/**************** spSugerirProvision ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirProvision') and type = 'P') drop procedure dbo.spSugerirProvision
GO             
CREATE PROCEDURE spSugerirProvision
			@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@FechaEmision	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Concepto			varchar(50),
    @Acreedor			char(10),
    @ProvisionTolerancia	float,
    @ProvisionImporte		money,
    @Acumulado			money,
    @Saldo			money,
    @GastoMov			char(20), 
    @GastoID			int,
    @Renglon			float,
    @Moneda			char(10),
    @TipoCambio			float,
    @PorcentajeDeducible	float,
    @PorcentajeImpuestos	float,
    @Impuestos			money,
    @Conteo			int,
    @Ok				int,
    @OkRef			varchar(255),
    @Mensaje			varchar(255)

  BEGIN TRANSACTION 

  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0
  SELECT @GastoMov = GastoProvision 
    FROM EmpresaCfgMov 
   WHERE Empresa = @Empresa

  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @ProvisionTolerancia = ISNULL(GastoProvisionTolerancia, 0.0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  DECLARE crConceptoGAS CURSOR FOR
   SELECT Concepto, ProvisionImporte, Impuestos, PorcentajeDeducible
     FROM Concepto
    WHERE Modulo = 'GAS' AND Provisionable = 1 AND NULLIF(ProvisionImporte, 0.0) IS NOT NULL
  OPEN crConceptoGAS
  FETCH NEXT FROM crConceptoGAS INTO @Concepto, @ProvisionImporte, @PorcentajeImpuestos, @PorcentajeDeducible
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @Acumulado = ISNULL(SUM(d.Importe*e.TipoCambio), 0.0)-ISNULL(SUM(d.Provision*e.TipoCambio), 0.0)
        FROM Gasto e, GastoD d, MovTipo mt 
       WHERE e.Empresa = @Empresa AND e.ID = d.ID AND e.Ejercicio = YEAR(@FechaEmision) AND e.Periodo = MONTH(@FechaEmision)
         AND d.Concepto = @Concepto 
         AND mt.Modulo = 'GAS' AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.G', 'GAS.P', 'GAS.GTC', 'GAS.C', 'GAS.CCH')

      IF @Acumulado < (@ProvisionImporte*(1-(@ProvisionTolerancia/100)))
      BEGIN
        SELECT @Acreedor = NULL
        SELECT @Acreedor = MIN(Acreedor) FROM ConceptoAcreedor WHERE Modulo = 'GAS' AND Concepto = @Concepto AND porOmision = 1
        IF @Acreedor IS NULL
          SELECT @Acreedor = MIN(Acreedor) FROM ConceptoAcreedor WHERE Modulo = 'GAS' AND Concepto = @Concepto
        IF @Acreedor IS NULL SELECT @Ok = 30670, @OkRef = @Concepto
        IF @Ok IS NULL
        BEGIN
          SELECT @Conteo = @Conteo + 1
          INSERT Gasto (Sucursal, Empresa,  Mov,       FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,    UltimoCambio, Acreedor,  Clase,   SubClase,   Condicion,   Prioridad)
                SELECT @Sucursal, @Empresa, @GastoMov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'BORRADOR', GETDATE(),    @Acreedor, c.Clase, c.SubClase, p.Condicion, 'Normal'
                  FROM Concepto c, Prov p
                 WHERE c.Modulo = 'GAS' AND c.Concepto = @Concepto AND p.Proveedor = @Acreedor
          SELECT @GastoID = SCOPE_IDENTITY()
          SELECT @Saldo = @ProvisionImporte - @Acumulado
          SELECT @Impuestos = @Saldo * (@PorcentajeImpuestos / 100)
          INSERT GastoD (ID,       Renglon, Concepto,  Fecha,         Cantidad,  Precio, Importe, Impuestos,  Sucursal,  PorcentajeDeducible)
                 VALUES (@GastoID, 2048.0,  @Concepto, @FechaEmision, 1,         @Saldo, @Saldo,  @Impuestos, @Sucursal, @PorcentajeDeducible)
        END
      END
    END
    FETCH NEXT FROM crConceptoGAS INTO @Concepto, @ProvisionImporte, @PorcentajeImpuestos, @PorcentajeDeducible
  END
  CLOSE crConceptoGAS
  DEALLOCATE crConceptoGAS

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = CONVERT(varchar, @Conteo)+' Provision(es) Generadas con Exito. (Borrador)'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/**************** spSugerirAFMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirAFMov') and type = 'P') drop procedure dbo.spSugerirAFMov
GO             
CREATE PROCEDURE spSugerirAFMov
			@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@FechaEmision	datetime,
			@Mov		char(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Moneda		char(10),
    @TipoCambio		float,
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  BEGIN TRANSACTION 

  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  INSERT ActivoFijo (Empresa,  Mov,  FechaEmision,  Usuario,  Moneda,  TipoCambio,  Estatus,      Todo, Revaluar)
             VALUES (@Empresa, @Mov, @FechaEmision, @Usuario, @Moneda, @TipoCambio, 'SINAFECTAR', 1,    0)
  SELECT @ID = SCOPE_IDENTITY()
  EXEC spAfectar 'AF', @ID, @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = RTRIM(@Mov)+' Generado con Exito.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/************** spAfectarContBorradorCierreMes ***************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarContBorradorCierreMes') and type = 'P') drop procedure dbo.spAfectarContBorradorCierreMes
GO
CREATE PROCEDURE spAfectarContBorradorCierreMes
		      @Empresa char(5),
		      @Usuario char(10),
		      @Fecha   datetime
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Cuantos 		int,
    @ID 		int,
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  BEGIN TRANSACTION 

  DECLARE crContBorrador CURSOR FOR 
   SELECT ID 
     FROM Cont 
    WHERE Empresa = @Empresa AND Estatus = 'BORRADOR' AND MONTH(FechaContable) = MONTH(@Fecha) AND YEAR(FechaContable) = YEAR(@Fecha)
  SELECT @Cuantos = 0
  OPEN crContBorrador
  FETCH NEXT FROM crContBorrador INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spCont @ID, 'CONT', 'AFECTAR', 'TODO', @Fecha, NULL, @Usuario, 1, 0, NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT
      SELECT @Cuantos = @Cuantos + 1
    END
    FETCH NEXT FROM crContBorrador INTO @ID
  END
  CLOSE crContBorrador
  DEALLOCATE crContBorrador

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT CONVERT(varchar, @Cuantos)+' Movimiento(s) Afectado(s).'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO


-- spInvAjusteSaldosMenores 'DEMO', 0, 'DEMO', '21/4/5'
/**************** spInvAjusteSaldosMenores ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvAjusteSaldosMenores') and type = 'P') drop procedure dbo.spInvAjusteSaldosMenores
GO             
CREATE PROCEDURE spInvAjusteSaldosMenores
			@Empresa	char(5),
			@SucursalOrigen	int,
			@Usuario	char(10),
			@FechaEmision	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @Sucursal			int,
    @InvID			int,
    @Moneda			char(10),
    @TipoCambio			float,
    @Ajuste			float,
    @Almacen			char(10),
    @UltAlmacen			char(10),
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @ArtTipo			varchar(20),
    @Unidad			varchar(50),
    @Cantidad			float,
    @CantidadInventario		float,
    @InvMov			varchar(20),
    @Renglon			float,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @Conteo			int,
    @Ok				int,
    @OkRef			varchar(255)

  SELECT @UltAlmacen = NULL, @Ok = NULL, @OkRef = NULL, @Conteo = 0, @InvID = NULL
  EXEC spExtraerFecha @FechaEmision OUTPUT

  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio 
    FROM EmpresaCfg cfg, Mon m 
   WHERE m.Moneda = cfg.ContMoneda AND cfg.Empresa = @Empresa

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'),
         @Ajuste = ABS(ISNULL(InvAjusteSaldosMenores, 0.0))
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT @InvMov = InvAjusteSaldosMenores
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  BEGIN TRANSACTION

    DECLARE crSaldoU CURSOR FOR
     SELECT s.Grupo, s.Cuenta, s.SubCuenta, -s.SaldoU, a.Tipo, a.Unidad
       FROM SaldoU s
       JOIN Art a ON a.Articulo = s.Cuenta
      WHERE s.Empresa = @Empresa AND s.Rama = 'INV' AND ABS(s.SaldoU) > 0 AND ABS(s.SaldoU) <= @Ajuste
      ORDER BY s.Grupo, s.Cuenta, s.SubCuenta

    OPEN crSaldoU
    FETCH NEXT FROM crSaldoU INTO @Almacen, @Articulo, @SubCuenta, @Cantidad, @ArtTipo, @Unidad
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @Almacen <> @UltAlmacen
        BEGIN
          IF @InvID IS NOT NULL UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @InvID
          IF @Ok IS NULL
          BEGIN
            SELECT @Sucursal = @SucursalOrigen
            SELECT @Sucursal = ISNULL(Sucursal, @SucursalOrigen) FROM Alm WHERE Almacen = @Almacen
            INSERT Inv (Sucursal, SucursalOrigen,  Empresa,  Usuario,  Estatus,     Mov,     FechaEmision,  FechaRequerida, Almacen,  Moneda,  TipoCambio)
                SELECT @Sucursal, @SucursalOrigen, @Empresa, @Usuario, 'CONFIRMAR', @InvMov, @FechaEmision, @FechaEmision,  @Almacen, @Moneda, @TipoCambio
            SELECT @InvID = SCOPE_IDENTITY()
            SELECT @Renglon = 0.0, @RenglonID = 0, @Conteo = @Conteo + 1
          END
        END
        IF @Ok IS NULL AND @InvID IS NOT NULL
        BEGIN
          EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
          INSERT InvD (ID,     Renglon,  RenglonSub,  RenglonID,  RenglonTipo,  Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario)
               VALUES (@InvID, @Renglon, 0,           @RenglonID, @RenglonTipo, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario)
        END
      END
      FETCH NEXT FROM crSaldoU INTO @Almacen, @Articulo, @SubCuenta, @Cantidad, @ArtTipo, @Unidad
    END -- While
    CLOSE crSaldoU
    DEALLOCATE crSaldoU
    IF @InvID IS NOT NULL UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @InvID

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+ ' '+@InvMov+' (por Confirmar)'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  END

  RETURN
END
GO

/**************** spArtMaterialHist ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtMaterialHist') and type = 'P') drop procedure dbo.spArtMaterialHist
GO             
CREATE PROCEDURE spArtMaterialHist
			@Articulo	varchar(20),
			@FechaD		datetime,
			@FechaA		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID	int

  INSERT ArtMaterialHist (Articulo, FechaD, FechaA) VALUES (@Articulo, @FechaD, @FechaA)
  SELECT @ID = SCOPE_IDENTITY()
  INSERT ArtMaterialHistD (
         ID,  Articulo, OrdenID, SiOpcion, Material, SubCuenta, Cantidad, Unidad, Merma, Desperdicio, Almacen, CentroTipo, CostoAcumulado, Orden, Porcentaje, Volumen)
  SELECT @ID, Articulo, OrdenID, SiOpcion, Material, SubCuenta, Cantidad, Unidad, Merma, Desperdicio, Almacen, CentroTipo, CostoAcumulado, Orden, Porcentaje, Volumen
    FROM ArtMaterial
   WHERE Articulo = @Articulo
  RETURN
END
GO

-- spImpuestosImportacion 'A', 'Mexico'
/**************** spImpuestosImportacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spImpuestosImportacion') and type = 'P') drop procedure dbo.spImpuestosImportacion
GO             
CREATE PROCEDURE spImpuestosImportacion
			@Articulo	varchar(20),
			@Arancel	varchar(50),
			@Pais		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ArtProgramaSectorial	varchar(50),
    @ArtOrigenPais		varchar(50),
    @TratadoComercial		varchar(50),
    @TratadoComercialPct	varchar(50),
    @ProgramaSectorial		varchar(50),
    @ProgramaSectorialPct	float,
    @Porcentaje			float,
    @IGI			float,
    @Cuota			float
  
  SELECT @ArtProgramaSectorial = NULLIF(RTRIM(ProgramaSectorial), ''), @ArtOrigenPais = NULLIF(RTRIM(OrigenPais), '') FROM Art WHERE Articulo = @Articulo
  SELECT @Porcentaje = Porcentaje, @Cuota = Cuota FROM ArtArancel WHERE Arancel = @Arancel

  SELECT @TratadoComercialPct = MIN(atc.Porcentaje)
    FROM ArtArancelTratadoComercial atc
    JOIN TratadoComercialPais tcp ON tcp.Pais = @Pais AND tcp.TratadoComercial = atc.TratadoComercial
   WHERE atc.Arancel = @Arancel

  SELECT @TratadoComercial = MIN(atc.TratadoComercial)
    FROM ArtArancelTratadoComercial atc
    JOIN TratadoComercialPais tcp ON tcp.Pais = @Pais AND tcp.TratadoComercial = atc.TratadoComercial
   WHERE atc.Arancel = @Arancel AND atc.Porcentaje = @TratadoComercialPct

  SELECT @ProgramaSectorialPct = MIN(aps.Porcentaje)
    FROM ArtArancelProgramaSectorial aps
   WHERE aps.Arancel = @Arancel

  SELECT @ProgramaSectorial = MIN(aps.ProgramaSectorial)
    FROM ArtArancelProgramaSectorial aps
   WHERE aps.Arancel = @Arancel AND aps.Porcentaje = @ProgramaSectorialPct

   IF @ArtProgramaSectorial IS NULL SELECT @ProgramaSectorialPct = 0.0
   IF @ArtOrigenPais IS NULL SELECT @TratadoComercialPct = 0.0

   IF NULLIF(@ProgramaSectorialPct, 0.0) IS NULL OR @ProgramaSectorialPct > @TratadoComercialPct
     SELECT @IGI = @TratadoComercialPct, @ProgramaSectorial = NULL
   ELSE
     SELECT @IGI = @ProgramaSectorialPct, @TratadoComercial = NULL

  IF NULLIF(@IGI, 0.0) IS NULL AND @ArtProgramaSectorial IS NULL AND @TratadoComercial IS NULL SELECT @IGI = @Porcentaje

  SELECT 'ImportacionImpuesto1' = @IGI, 'ImportacionImpuesto2' = @Cuota, 'TratadoComercial' = @TratadoComercial, 'ProgramaSectorial' = @ProgramaSectorial
  RETURN
END
GO


/**************** spMovGastoIndirectoSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovGastoIndirectoSugerir') and type = 'P') drop procedure dbo.spMovGastoIndirectoSugerir
GO             
CREATE PROCEDURE spMovGastoIndirectoSugerir
			@Empresa	char(5),
			@Modulo		char(5),
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  IF NOT EXISTS(SELECT * FROM MovGastoIndirecto WHERE Modulo = @Modulo AND ModuloID = @ID)
    INSERT MovGastoIndirecto (
           Modulo,  ModuloID, Concepto, Porcentaje)
    SELECT @Modulo, @ID,      Concepto, Porcentaje
      FROM EmpresaCfgGastoIndirecto
     WHERE Empresa = @Empresa
END
GO


/**************** spContDistribuirSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContDistribuirSugerir') and type = 'P') drop procedure dbo.spContDistribuirSugerir
GO             
CREATE PROCEDURE spContDistribuirSugerir
			@Estacion	int,
			@Cuenta		varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @s	char(1)

  IF EXISTS(SELECT * FROM ContDistribuir WHERE Estacion = @Estacion) RETURN
  SELECT @s = SUBSTRING(@Cuenta, 1, 1)
  IF @s = '1' INSERT ContDistribuir (Estacion, Cuenta) SELECT @Estacion, Cuenta FROM Cta WHERE LEN(Cuenta) = 4 AND SUBSTRING(Cuenta, 1, 1) = '1' ELSE
  IF @s IN ('2', '3') INSERT ContDistribuir (Estacion, Cuenta) SELECT @Estacion, Cuenta FROM Cta WHERE LEN(Cuenta) = 4 AND SUBSTRING(Cuenta, 1, 1) IN ('2', '3') ELSE
  IF @s = '4' INSERT ContDistribuir (Estacion, Cuenta) SELECT @Estacion, Cuenta FROM Cta WHERE CuentaDistribucion = @Cuenta ELSE
  IF @s IN ('5', '6') INSERT ContDistribuir (Estacion, Cuenta) SELECT @Estacion, Cuenta FROM Cta WHERE LEN(Cuenta) = 4 AND SUBSTRING(Cuenta, 1, 1) IN ('5', '6')
END
GO


/**************** spContDistribuirSugerirPresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContDistribuirSugerirPresupuesto') and type = 'P') drop procedure dbo.spContDistribuirSugerirPresupuesto
GO             
CREATE PROCEDURE spContDistribuirSugerirPresupuesto
			@ID		int,
			@Cuenta		varchar(20),
			@Periodo	int
--//WITH ENCRYPTION
AS BEGIN
  IF EXISTS(SELECT * FROM GRP_PresupuestoCta WHERE ID = @ID AND Periodo = @Periodo) RETURN
  INSERT GRP_PresupuestoCta (ID, Periodo, Cuenta) SELECT @ID, @Periodo, Cuenta FROM Cta WHERE CuentaDistribucion = @Cuenta
END
GO


/**************** spContDistribuir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContDistribuir') and type = 'P') drop procedure dbo.spContDistribuir
GO             
CREATE PROCEDURE spContDistribuir
			@Estacion	int,
			@Cuenta		varchar(20),
			@ID		int,
			@Renglon	float,
			@RenglonSub	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EsAcreedora	bit,
    @DRenglon		float,
    @DCuenta		varchar(20), 
    @DSubCuenta		varchar(50), 
    @Importe		money,
    @Debe		money,
    @SumaDebe		money,
    @Haber		money,
    @SumaHaber		money,
    @Periodo		int,
    @Presupuesto	bit,
    @SucursalContable	int

  BEGIN TRANSACTION

  SELECT @SumaDebe = 0.0, @SumaHaber = 0.0
  SELECT @DRenglon = ISNULL(MAX(Renglon), 0.0) + 2048.0 FROM ContD WHERE ID = @ID
  SELECT @Periodo = Periodo, @Presupuesto = Presupuesto, @SucursalContable = SucursalContable FROM ContD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

  SELECT @EsAcreedora = ISNULL(EsAcreedora, 0) FROM Cta WHERE Cuenta = @Cuenta
  DECLARE crContDistribuir CURSOR FOR
   SELECT NULLIF(RTRIM(Cuenta), ''), NULLIF(RTRIM(SubCuenta), ''), NULLIF(Importe, 0.0)
     FROM ContDistribuir
    WHERE Estacion = @Estacion
    ORDER BY ID

  OPEN crContDistribuir
  FETCH NEXT FROM crContDistribuir INTO @DCuenta, @DSubCuenta, @Importe
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @DCuenta IS NOT NULL AND @Importe IS NOT NULL
    BEGIN   
      IF @EsAcreedora = 1 SELECT @Debe = NULL, @Haber = @Importe ELSE SELECT @Debe = @Importe, @Haber = NULL
      INSERT ContD (
              ID,  Renglon,   RenglonSub, Cuenta,   SubCuenta,   Debe,  Haber,  Periodo,  Presupuesto,  SucursalContable)
      VALUES (@ID, @DRenglon, 0,          @DCuenta, @DSubCuenta, @Debe, @Haber, @Periodo, @Presupuesto, @SucursalContable)
      SELECT @DRenglon = @DRenglon + 2048.0, @SumaDebe = @SumaDebe + ISNULL(@Debe, 0.0), @SumaHaber = @SumaHaber + ISNULL(@Haber, 0.0)
    END
    FETCH NEXT FROM crContDistribuir INTO @DCuenta, @DSubCuenta, @Importe
  END -- While
  CLOSE crContDistribuir
  DEALLOCATE crContDistribuir

  UPDATE ContD 
     SET Debe = NULLIF(@SumaHaber, 0.0), Haber = NULLIF(@SumaDebe, 0.0) 
   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

  DELETE ContDistribuir
   WHERE Estacion = @Estacion

  COMMIT TRANSACTION
END
GO

/**************** spCompraCotizacionGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraCotizacionGenerar') and type = 'P') drop procedure dbo.spCompraCotizacionGenerar
GO             
CREATE PROCEDURE spCompraCotizacionGenerar
			@Estacion	int,
			@Empresa	varchar(5),
			@Sucursal	int,
			@Usuario	varchar(10),
			@FechaEmision	datetime,
			@Proveedor	varchar(10),
			@Mov		varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo	int,
    @Ok		int,
    @OkRef	varchar(255),
    @ID		int,
    @MovID	varchar(20),
    @Moneda	char(10),
    @TipoCambio	float,
    @Almacen	varchar(10),
    @Renglon	float
  	
  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda
  
  IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = @Proveedor AND Estatus = 'ALTA')
    SELECT @Ok = 26050, @OkRef = @Proveedor
      
  BEGIN TRANSACTION

  IF @Ok IS NULL
  BEGIN
    INSERT Compra (Sucursal,  Empresa,  Mov,   Estatus,     FechaEmision,  Moneda,  TipoCambio,  Usuario,  Proveedor,  Directo) 
           VALUES (@Sucursal, @Empresa, @Mov, 'SINAFECTAR', @FechaEmision, @Moneda, @TipoCambio, @Usuario, @Proveedor, 0)
    SELECT @ID = SCOPE_IDENTITY()
   
    SELECT d.* INTO #CompraDetalle 
      FROM cCompraD d
      JOIN ListaIDRenglon l ON l.Estacion = @Estacion AND l.Modulo = 'COMS' AND l.ID = d.ID AND l.Renglon = d.Renglon AND l.RenglonSub = d.RenglonSub
  
    UPDATE #CompraDetalle 
       SET Aplica = r.Mov, AplicaID = r.MovID, EmpresaRef = r.Empresa
      FROM #CompraDetalle d
      JOIN Compra r ON r.ID = d.ID 
      
    UPDATE #CompraDetalle 
       SET ID = @ID, Cantidad = CantidadPendiente, CantidadPendiente = NULL, CantidadCancelada = NULL, CantidadA = NULL

    SELECT @Renglon = 0.0
    UPDATE #CompraDetalle
       SET @Renglon = Renglon = @Renglon + 2048.0, RenglonSub = 0         
/*
    UPDATE #CompraDetalle
       SET EmpresaRef = c.Empresa
      FROM #CompraDetalle d
      JOIN Compra c ON c.ID = d.ID
*/
    INSERT INTO cCompraD SELECT * FROM #CompraDetalle
    DROP TABLE #CompraDetalle

    SELECT @Almacen = MIN(Almacen) FROM CompraD WHERE ID = @ID
    UPDATE Compra SET Almacen = @Almacen WHERE ID = @ID
    SELECT @Conteo = @Conteo + 1
  END
  
  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+ ' '+@Mov+' (sin Afectar)'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  END
  RETURN
END
GO

/**************** spCompraCotizacionAutorizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraCotizacionAutorizar') and type = 'P') drop procedure dbo.spCompraCotizacionAutorizar
GO             
CREATE PROCEDURE spCompraCotizacionAutorizar
			@Estacion	int,
			@Empresa	varchar(5),
			@Sucursal	int,
			@Usuario	varchar(10),
			@FechaEmision	datetime,
            @Mov			varchar(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo	int,
    @Ok		int,
    @OkRef	varchar(255),
    @ID		int,
    --@Mov	varchar(20),
    @MovID	varchar(20),
    @IDOrigen	int,
    @Origen	varchar(20),
    @OrigenID	varchar(20),
    @Proveedor	varchar(10),
    @Moneda	char(10),
    @TipoCambio	float,
	@UltimoCambio date, 
	@Prioridad varchar(10), 
	@RenglonID int, 
	@FechaRequerida date, 
	@Condicion varchar(50), 
	@Vencimiento date, 
	@Importe money, 
	@Impuestos money, 
	@FechaEntrega date, 
	@SucursalDestino int,
    @Almacen	varchar(10),
    @Renglon	float,
    @EmpresaRef	varchar(5)
  	
  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0
  IF @Mov IS NULL
    SELECT @Mov = CompraOrden FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda
     
  BEGIN TRANSACTION

  DECLARE crCotizacion CURSOR FOR
   SELECT ISNULL(d.EmpresaRef, @Empresa), c.ID, c.Mov, c.MovID, c.Proveedor, c.Moneda, c.TipoCambio, c.UltimoCambio, c.Prioridad, c.RenglonID, c.FechaRequerida, c.Condicion, c.Vencimiento, c.Importe, c.Impuestos, c.FechaEntrega, c.SucursalDestino
     FROM Compra c
     JOIN ListaIDRenglon l ON l.Estacion = @Estacion AND l.Modulo = 'COMS' AND l.ID = c.ID   
     JOIN CompraD d ON d.ID = l.ID AND d.Renglon = l.Renglon AND d.RenglonSub = l.RenglonSub
    GROUP BY ISNULL(d.EmpresaRef, @Empresa), c.ID, c.Mov, c.MovID, c.Proveedor, c.Moneda, c.TipoCambio, c.UltimoCambio, c.Prioridad, c.RenglonID, c.FechaRequerida, c.Condicion, c.Vencimiento, c.Importe, c.Impuestos, c.FechaEntrega, c.SucursalDestino
    ORDER BY ISNULL(d.EmpresaRef, @Empresa), c.ID, c.Mov, c.MovID, c.Proveedor, c.Moneda, c.TipoCambio, c.UltimoCambio, c.Prioridad, c.RenglonID, c.FechaRequerida, c.Condicion, c.Vencimiento, c.Importe, c.Impuestos, c.FechaEntrega, c.SucursalDestino
  OPEN crCotizacion
  FETCH NEXT FROM crCotizacion INTO @EmpresaRef, @IDOrigen, @Origen, @OrigenID, @Proveedor, @Moneda, @TipoCambio, @UltimoCambio, @Prioridad, @RenglonID, @FechaRequerida, @Condicion, @Vencimiento, @Importe, @Impuestos, @FechaEntrega, @SucursalDestino
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Ok IS NULL
      BEGIN
        INSERT Compra (Sucursal,  Empresa,     Mov,   Estatus,     FechaEmision,  Moneda,  TipoCambio,  Usuario,  Proveedor,  Directo, OrigenTipo, Origen,  OrigenID, UltimoCambio,  Prioridad,  RenglonID,   FechaRequerida,   Condicion, Vencimiento,  Importe, Impuestos, FechaEntrega, SucursalDestino) 
               VALUES (@Sucursal, @EmpresaRef, @Mov, 'SINAFECTAR', @FechaEmision, @Moneda, @TipoCambio, @Usuario, @Proveedor, 0,       'COMS',     @Origen, @OrigenID, @UltimoCambio, @Prioridad, @RenglonID, @FechaRequerida, @Condicion, @Vencimiento, @Importe, @Impuestos, @FechaEntrega, @SucursalDestino)
        SELECT @ID = SCOPE_IDENTITY()
   
        SELECT d.* INTO #CompraDetalle 
          FROM cCompraD d
          JOIN ListaIDRenglon l ON l.Estacion = @Estacion AND l.Modulo = 'COMS' AND l.ID = d.ID AND l.Renglon = d.Renglon AND l.RenglonSub = d.RenglonSub
         WHERE d.ID = @IDOrigen --AND d.EmpresaRef = ISNULL(@EmpresaRef, d.EmpresaRef)
  
        UPDATE #CompraDetalle 
           SET ID = @ID
        SELECT @Renglon = 0.0
        UPDATE #CompraDetalle
           SET @Renglon = Renglon = @Renglon + 2048.0,
               RenglonSub = 0         
        INSERT INTO cCompraD SELECT * FROM #CompraDetalle
        DROP TABLE #CompraDetalle

        SELECT @Almacen = MIN(Almacen) FROM CompraD WHERE ID = @ID
        UPDATE Compra SET Almacen = @Almacen WHERE ID = @ID
        SELECT @Conteo = @Conteo + 1
        UPDATE Compra SET Estatus = 'CONCLUIDO', FechaConclusion = GETDATE() WHERE ID = @IDOrigen
      END  	
    END
    FETCH NEXT FROM crCotizacion INTO @EmpresaRef, @IDOrigen, @Origen, @OrigenID, @Proveedor, @Moneda, @TipoCambio, @UltimoCambio, @Prioridad, @RenglonID, @FechaRequerida, @Condicion, @Vencimiento, @Importe, @Impuestos, @FechaEntrega, @SucursalDestino
  END -- While
  CLOSE crCotizacion
  DEALLOCATE crCotizacion

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+ ' '+@Mov+' (sin Afectar)'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  END
  RETURN
END
GO

/**************** fnCompraCotizacionAutorizarValida ****************/
if exists (SELECT name, type,* FROM sysobjects WHERE name = 'fnCompraCotizacionAutorizarValida') DROP FUNCTION fnCompraCotizacionAutorizarValida
GO       
CREATE FUNCTION fnCompraCotizacionAutorizarValida (@Estacion	int)
RETURNS INT
--//WITH ENCRYPTION
AS BEGIN
 DECLARE
 @Conteo	  int,
 @Registros   int,
 @RegistrosL  int,
 @RegistrosLC int,
 @Estatus     int
 Declare @Valores Table (row_id int , clave int) 

 SELECT @Conteo = 1
 SELECT @Registros  =  count(*) FROM (select ID from ListaIDRenglon WHERE Estacion = @Estacion  GROUP BY ID) as total
 Insert Into @Valores
  select ROW_NUMBER() OVER(ORDER BY ID DESC) AS Row , ID from ListaIDRenglon WHERE Estacion = 1 GROUP BY ID
 
 WHILE @Conteo <= @Registros
  BEGIN
  select @RegistrosL  = count(*) From ListaIDRenglon Where Estacion = @Estacion And ID = (select clave from @Valores where row_id = @Conteo)
  select @RegistrosLC = count(*) From CompraConfirmarD Where ID = (select clave from @Valores where row_id = @Conteo)
   
  IF @RegistrosL = @RegistrosLC
   
    SELECT @Estatus = 1, @Conteo =  @Conteo +1
  ELSE
   begin
    SELECT @Estatus = 0
    BREAK
   end
  END
  
  RETURN(@Estatus)

END
GO

/**************** spCompraExtraccion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraExtraccion') and type = 'P') drop procedure dbo.spCompraExtraccion
GO              
CREATE PROCEDURE spCompraExtraccion
				@Estacion		int,
				@ID				int
--//WITH ENCRYPTION
AS
BEGIN
  DELETE CompraExtraccionLista WHERE Estacion = @Estacion
  
  INSERT INTO CompraExtraccionLista
         (Estacion,   ID,   Renglon,   RenglonSub,   RenglonID,   SerieLote)
  SELECT @Estacion, v.ID, v.Renglon, v.RenglonSub, v.RenglonID, v.SerieLote
    FROM VerCompraImportacionSerieLote v
   WHERE v.ID = @ID
  
  RETURN
END
GO
  
/**************** spGenerarInvExtraccion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarInvExtraccion') and type = 'P') drop procedure dbo.spGenerarInvExtraccion
GO              
CREATE PROCEDURE spGenerarInvExtraccion
				@Estacion			int,
				@ID					int,
				@Empresa			char(5),
				@GenerarMov			char(20),
				@AlmacenDestino		char(10),
				@Usuario			char(10),
				@Sucursal			int
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
  @IDInv				int,
  @Mov					char(20),
  @MovID				char(20),
  @Almacen				char(10),
  @FechaEmision			datetime,
  @Moneda				char(10),
  @TipoCambio			float,
  @Renglon				float,
  @RenglonSub			int,
  @RenglonID			int,
  @CantidadA			float,
  @CantidadA2			float,
  @CantidadInventario	float,
  @PaqueteCantidad		float,
  @RenglonTipo			char(1),
  @Articulo				char(20),
  @SubCuenta			char(50),
  @Observaciones		varchar(100),
  @Unidad				char(50),
  @CfgMultiUnidades     bit,
  @CfgMultiUnidadesNivel char(20)
  
  SELECT @Mov = c.Mov, @MovID = c.MovID, @Almacen = c.Almacen
    FROM Compra c
  WHERE c.ID = @ID

  IF NOT EXISTS(SELECT * FROM Alm a WHERE a.Almacen = @AlmacenDestino)
  BEGIN
  	SELECT 'El Almacén indicado no existe'
  	RETURN
  END
  
  IF NOT EXISTS(SELECT * FROM MovTipo mt WHERE mt.Modulo = 'INV' AND mt.Mov = @GenerarMov)
  BEGIN
  	SELECT 'El Movimiento indicado no existe'
  	RETURN
  END

  IF NOT EXISTS(SELECT * FROM MovTipo mt WHERE mt.Modulo = 'INV' AND mt.Mov = @GenerarMov AND mt.Clave IN ('INV.OI', 'INV.SI'))
  BEGIN
  	SELECT 'El Movimiento debe ser Tipo Orden Traspaso o Salida Traspaso'
  	RETURN
  END
  
  IF NOT EXISTS(SELECT * FROM CompraExtraccionLista cel WHERE cel.Estacion = @Estacion AND cel.ID = @ID AND ISNULL(cel.CantidadA, 0) > 0)
  BEGIN
  	SELECT 'No hay registros que generar'
  	RETURN
  END

  SELECT @Articulo = Min(Articulo)
  FROM CompraExtraccion ce
  WHERE ce.Estacion = @Estacion
    AND ce.ID = @ID
    AND ISNULL(ce.CantidadA, 0) > ce.Existencia
    
  IF @Articulo IS NOT NULL
  BEGIN
  	SELECT 'El Artículo ' + RTRIM(@Articulo) + ' excede la cantidad indicada a la Existencia'
  	RETURN
  END
  
  IF @Almacen = @AlmacenDestino
  BEGIN
  	SELECT 'El Almacén Destino debe ser diferente al de la Compra'
  	RETURN
  END

  SELECT @FechaEmision = GETDATE()
  EXEC spExtraerFecha @FechaEmision OUTPUT
  
  SELECT @Moneda = ec.ContMoneda
    FROM EmpresaCfg ec
   WHERE Empresa = @Empresa
   
  SELECT @CfgMultiUnidades         = ISNULL(MultiUnidades, 0),
         @CfgMultiUnidadesNivel    = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2 WHERE Empresa = @Empresa
   
  SELECT @TipoCambio = TipoCambio FROM Mon m WHERE m.Moneda = @Moneda

  INSERT INTO 
      Inv(Empresa,  Mov,         FechaEmision,  Moneda,  TipoCambio,  Usuario, Referencia,                         Estatus, Directo, Almacen, AlmacenDestino, Sucursal)
  VALUES(@Empresa, @GenerarMov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, RTRIM(@Mov) + ' ' + RTRIM(@MovID), 'CONFIRMAR', 1, @Almacen, @AlmacenDestino, @Sucursal)
  
  SELECT @IDInv = SCOPE_IDENTITY()
  
  DECLARE crGenerarInvExtraccion CURSOR FOR
  SELECT ce.Renglon, ce.RenglonSub, ce.RenglonID, ce.Observaciones, ISNULL(ce.PaqueteCantidad, 1), SUM(ISNULL(ce.CantidadA, 0)), ce.RenglonTipo, ce.Articulo, ISNULL(ce.SubCuenta, ''), ce.Unidad
  FROM CompraExtraccion ce
  WHERE ce.Estacion = @Estacion
    AND ce.ID = @ID
    AND ISNULL(ce.CantidadA, 0) > 0
  GROUP BY ce.Renglon, ce.RenglonSub, ce.RenglonID, ce.Observaciones, ISNULL(ce.PaqueteCantidad, 1), ce.RenglonTipo, ce.Articulo, ISNULL(ce.SubCuenta, ''), ce.Unidad
  
  OPEN crGenerarInvExtraccion
  FETCH NEXT FROM crGenerarInvExtraccion INTO @Renglon, @RenglonSub, @RenglonID, @Observaciones, @PaqueteCantidad, @CantidadA, @RenglonTipo, @Articulo, @SubCuenta, @Unidad
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SELECT @CantidadInventario = NULL, @CantidadA2 = 0
    SELECT @CantidadA2 = @PaqueteCantidad*@CantidadA
    EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CantidadA2, @CantidadInventario OUTPUT

    INSERT INTO
       InvD(ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Cantidad, Almacen, Articulo, SubCuenta, Unidad, Factor, CantidadInventario, DescripcionExtra)
    VALUES(@IDInv, @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @CantidadA2, @Almacen, @Articulo, @SubCuenta, @Unidad, 1, @CantidadInventario, @Observaciones)
    
    INSERT INTO SerieLoteMov
           (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
    SELECT @Empresa, 'INV', @IDInv, @RenglonID, @Articulo, @SubCuenta, SerieLote, CantidadA*@PaqueteCantidad
      FROM CompraExtraccion ce
     WHERE ce.Estacion = @Estacion
       AND ce.ID = @ID
       AND ce.Renglon = @Renglon AND ce.RenglonSub = @RenglonSub AND ce.RenglonID = @RenglonID
       AND ISNULL(ce.CantidadA, 0) > 0
    
    FETCH NEXT FROM crGenerarInvExtraccion INTO @Renglon, @RenglonSub, @RenglonID, @Observaciones, @PaqueteCantidad, @CantidadA, @RenglonTipo, @Articulo, @SubCuenta, @Unidad
  END
  
  CLOSE crGenerarInvExtraccion
  DEALLOCATE crGenerarInvExtraccion
  
  SELECT 'Movimiento Generado'
   
  RETURN
END
GO

if not exists (select * from sysobjects where id = object_id('dbo.VentaLotes') and type = 'U')  -- drop table VentaLotes
  CREATE TABLE dbo.VentaLotes(
	Estacion		varchar(20),
	Articulo		varchar(20)		NOT NULL,
	Mov				varchar(20)		NOT NULL,
	Almacen			varchar(10)		NOT NULL,
	Categoria		varchar(20)		NULL,
	Familia			varchar (50)	NULL,
	Grupo			varchar (50)	NULL,
	Concepto		varchar (50)	NULL,
	CicloEsc		varchar(10)		NULL,--se guardará en el campo FechaOrdenCompra de la Tabla Venta
	Condicion		varchar(50)		NULL,--se hará referencia a Condicion de la Tabla Venta
	FechaEmision	datetime		NOT NULL,
	ContUso			varchar(20)		NULL,
	CopiarEnTiempo	bit Default 1	NULL,
	AplicaDesc		bit Default 1	NULL,
	FechaD			datetime		NULL,
	FechaA			datetime		NULL,
	Unidad			varchar(20)		NULL
	CONSTRAINT priVentaLotes PRIMARY KEY CLUSTERED (Estacion)
  )
GO 
if not exists (select * from sysobjects where id = object_id('dbo.VentaLotesAux') and type = 'U')  -- drop table VentaLotesAux
  CREATE TABLE dbo.VentaLotesAux(
	Estacion		varchar(20),
	Cliente			varchar(10) NULL,
	Sucursal		int,
	NombreSucCte	varchar(100),
	Articulo		varchar(20),
	Mov				varchar(20),
	Almacen			varchar(10),
	Categoria		varchar(20),
	Familia			varchar (50),
	Grupo			varchar (50),
	Concepto		varchar (50) NULL,
	CicloEsc		varchar(10),--se guardará en el campo FechaOrdenCompra de la Tabla Venta
	Condicion		varchar(50),--se hará referencia a Condicion de la Tabla Venta
	FechaEmision	datetime,
	ContUso			varchar(20),
	CopiarEnTiempo	bit Default 1 NULL,
	AplicaDesc		bit Default 1 NULL,
	FechaD			datetime NULL,
	FechaA			datetime NULL,
	Unidad			varchar(20) NULL	
	--CONSTRAINT priVentaLotesAux PRIMARY KEY CLUSTERED (Estacion,Articulo,Mov,Almacen)
  )
GO
--select * from VentaLotesAux  select * from VentaLotes
--spVentaLotes 'DEMO','DEMO',112,'CAT1','FAM1','GPO1',NULL,NULL,1
--spVentaLotes 'DEMO','DEMO',111,'CAT2','FAM3','GPO2',NULL,NULL,1
--spVentaLotes 'DEMO','DEMO',106,NULL,NULL,NULL,NULL,NULL,0
--spVentaLotes 'DEMO','DEMO',111,'TODOS','TODOS','TODOS',NULL,NULL,1
--spVentaLotes '10100', 'DEMO', '100', 'CAT2', 'FAM3', 'GPO2', NULL, NULL, '0'
--spVentaLotes 'DEMO', 'DEMO', '100', 'CAT2', 'FAM3', 'GPO2', NULL, NULL, '0'

if exists (select * from sysobjects where id = object_id('dbo.spGenerarVentaLote') and type = 'P') drop procedure dbo.spGenerarVentaLote
GO
CREATE PROCEDURE spGenerarVentaLote
	@Empresa		varchar(5),
	@Usuario		varchar(10),
	@Estacion		varchar(20),
	@CteCat			varchar(20),
	@CteFam			varchar (50),
	@CteGpo			varchar (50),
    @Ok             int			= NULL  OUTPUT,
    @OkRef          varchar(255)= NULL  OUTPUT,
	@Verificar			bit
--//WITH ENCRYPTION
AS 
BEGIN  
	DECLARE @Mensaje		varchar(100),
			@ID				int,
			@Renglon    	float,
			@RenglonSub    	int,
			@RenglonID		int,
			@Cliente		varchar(10),
			@SucCte			int,
			@NombreSucCte	varchar(100),
			@Articulo		varchar(20),
			@Precio			float,
			@Impuesto		float,
			@ImpuestoD		float,
			@Mov			varchar(20),
			@Almacen		varchar(10),
			@Categoria		varchar(20),
			@Familia		varchar (50),
			@Grupo			varchar (50),
			@Concepto		varchar (50),
			@CicloEsc		varchar(10),
			@Condicion		varchar(50),
			@FechaEmision	datetime,
			@FechaEmisionA	datetime,
			@ContUso		varchar(20),
			@CopiarEnTiempo	bit,
			@AplicaDesc		bit,
			@FechaD			datetime,
			@FechaA			datetime,
			@Unidad			varchar(20),
			@Dcto			varchar(30),
			@DctoGlobal		float,
			@TiempoUnidad	varchar(50),
			@Cont			int,
			@Contcr			int

  IF RTRIM(@CteCat) IN ('', '(TODOS)', 'NULL', 'TODOS') SELECT @CteCat = NULL
  IF RTRIM(@CteFam) IN ('', '(TODOS)', 'NULL', 'TODOS') SELECT @CteFam = NULL
  IF RTRIM(@CteGpo) IN ('', '(TODOS)', 'NULL', 'TODOS') SELECT @CteGpo = NULL

  IF @Verificar = 1 
  BEGIN
    IF NOT EXISTS
    (SELECT DISTINCT c.Cliente 
	   FROM cte c 
	   JOIN CteEnviarA cea ON c.Cliente = cea.Cliente
	   JOIN VentaLotes	v ON cea.Categoria = CASE @CteCat WHEN NULL THEN ISNULL(cea.Categoria,'') ELSE ISNULL(v.Categoria,'') END 
	    AND cea.Familia = CASE @CteFam WHEN NULL THEN ISNULL(cea.Familia,'') ELSE ISNULL(v.Familia,'') END
	    AND cea.Grupo = CASE @CteGpo WHEN NULL THEN ISNULL(cea.Grupo,'') ELSE ISNULL(v.Grupo,'') END
	  WHERE ISNULL(cea.Categoria, '') = CASE @CteCat WHEN NULL THEN ISNULL(cea.Categoria, '') ELSE @CteCat END AND
	        ISNULL(cea.Grupo, '') = CASE @CteGpo WHEN NULL THEN ISNULL(cea.Grupo, '') ELSE @CteGpo END AND
		    ISNULL(cea.Familia, '') = CASE @CteFam WHEN NULL THEN ISNULL(cea.Familia, '') ELSE @CteFam END
		    AND v.Estacion = @Estacion)
    BEGIN
	  DELETE FROM VentaLotesAux WHERE Estacion = @Estacion
	  SELECT @Mensaje = 'No Existen Sucursales de Clientes con esas Agrupaciones'
		RAISERROR (@Mensaje, 16, -1)
		RETURN
	END

	DELETE FROM VentaLotesAux WHERE Estacion = @Estacion
	INSERT INTO VentaLotesAux
             (Estacion,  Cliente,  Sucursal, NombreSucCte, Articulo,   Mov,    Almacen,     Categoria,     Familia,
              Grupo,     Concepto,    CicloEsc,    Condicion,    FechaEmision,    ContUso,    CopiarEnTiempo,    AplicaDesc,
              FechaD, FechaA, Unidad)
	SELECT vl.Estacion, c.Cliente, cea.ID, cea.Nombre, vl.Articulo, vl.Mov, vl.Almacen, cea.Categoria, cea.Familia,
	       cea.Grupo, vl.Concepto, vl.CicloEsc, vl.Condicion, vl.FechaEmision, vl.ContUso, vl.CopiarEnTiempo, vl.AplicaDesc,
	       vl.FechaD, vl.FechaA, vl.Unidad
      FROM CteEnviarA cea 
      JOIN cte c ON cea.Cliente = c.Cliente
      LEFT OUTER JOIN VentaLotes vl ON cea.Categoria = CASE @CteCat WHEN NULL THEN ISNULL(cea.Categoria,'') ELSE ISNULL(vl.Categoria,'') END 
       AND cea.Familia = CASE @CteFam WHEN NULL THEN ISNULL(cea.Familia,'') ELSE ISNULL(vl.Familia,'') END
       AND cea.Grupo = CASE @CteGpo WHEN NULL THEN ISNULL(cea.Grupo,'') ELSE ISNULL(vl.Grupo,'') END
     WHERE cea.Categoria = CASE @CteCat WHEN NULL THEN ISNULL(cea.Categoria, '') ELSE @CteCat END
       AND cea.Grupo = CASE @CteGpo WHEN NULL THEN ISNULL(cea.Grupo, '') ELSE @CteGpo END
       AND cea.Familia = CASE @CteFam WHEN NULL THEN ISNULL(cea.Familia, '') ELSE @CteFam END			
       AND vl.Estacion = @Estacion

    SELECT @Mensaje = 'Agrupaciones Correctas'
	SELECT @Mensaje 
	RETURN
  END
  ELSE
  BEGIN
    IF NOT EXISTS
	(SELECT DISTINCT c.Cliente 
	   FROM cte c 
	   JOIN CteEnviarA cea ON c.Cliente = cea.Cliente
	   JOIN VentaLotes	v ON cea.Categoria = CASE @CteCat WHEN NULL THEN ISNULL(cea.Categoria,'') ELSE ISNULL(v.Categoria,'') END 
        AND cea.Familia = CASE @CteFam WHEN NULL THEN ISNULL(cea.Familia,'') ELSE ISNULL(v.Familia,'') END
        AND cea.Grupo = CASE @CteGpo WHEN NULL THEN ISNULL(cea.Grupo,'') ELSE ISNULL(v.Grupo,'') END
      WHERE ISNULL(cea.Categoria, '') = CASE @CteCat WHEN NULL THEN ISNULL(cea.Categoria, '') ELSE @CteCat END AND
            ISNULL(cea.Grupo, '') = CASE @CteGpo WHEN NULL THEN ISNULL(cea.Grupo, '') ELSE @CteGpo END AND
            ISNULL(cea.Familia, '') = CASE @CteFam WHEN NULL THEN ISNULL(cea.Familia, '') ELSE @CteFam END
		    AND v.Estacion = @Estacion)
	BEGIN
	  SELECT @Mensaje = 'No se ha Generado la Venta por Lotes o es Incorrecta, Imposible Afectar'
	  RAISERROR (@Mensaje, 16, -1)
	  RETURN
	END

    SELECT @Cont = 0, @Contcr = 0
	IF (SELECT DISTINCT CopiarEnTiempo FROM VentaLotesAux WHERE Estacion = @Estacion) = 1
	BEGIN
  	  SELECT DISTINCT @TiempoUnidad = Unidad FROM VentaLotesAux WHERE Estacion = @Estacion
      SELECT DISTINCT @FechaD = FechaD FROM VentaLotesAux WHERE Estacion = @Estacion
	  SELECT DISTINCT @FechaA = FechaA FROM VentaLotesAux WHERE Estacion = @Estacion
      SELECT @FechaEmisionA = @FechaD

	  WHILE @FechaEmisionA <= @FechaA
	  BEGIN
        SELECT @Cont = @Cont + 1
        IF @TiempoUnidad = 'dias' SELECT @FechaEmisionA = DATEADD(day, 1, @FechaEmisionA) ELSE
        IF @TiempoUnidad = 'semanas' SELECT @FechaEmisionA = DATEADD(week, 1, @FechaEmisionA) ELSE
        IF @TiempoUnidad = 'años'    SELECT @FechaEmisionA = DATEADD(year, 1, @FechaEmisionA)
        ELSE SELECT @FechaEmisionA = DATEADD(month, 1, @FechaEmisionA)
      END
    END

    DECLARE crVentaLotes CURSOR FOR
     SELECT Cliente,Sucursal,NombreSucCte,Articulo,Mov,Almacen,Categoria,Familia,Grupo,Concepto,CicloEsc,Condicion,FechaEmision,ContUso,CopiarEnTiempo,AplicaDesc,FechaD,FechaA,Unidad
       FROM VentaLotesAux
	  WHERE Estacion = @Estacion

	OPEN crVentaLotes
    FETCH NEXT FROM crVentaLotes INTO @Cliente,@SucCte,@NombreSucCte,@Articulo,@Mov,@Almacen,@Categoria,@Familia,@Grupo,@Concepto,@CicloEsc,@Condicion,@FechaEmision,@ContUso,@CopiarEnTiempo,@AplicaDesc,@FechaD,@FechaA,@Unidad
    WHILE @@FETCH_STATUS = 0
	  BEGIN
        SELECT @Dcto = NULL,@DctoGlobal = 0
		SELECT @Precio = PrecioLista FROM Art WHERE Articulo = @Articulo
		SELECT @Impuesto = Impuesto1 FROM Art WHERE Articulo = @Articulo
		SELECT @Impuesto = (@Precio*@Impuesto)/100
		SELECT @ImpuestoD = Impuesto1 FROM Art WHERE Articulo = @Articulo

		IF ISNULL(@AplicaDesc,0) = 1
		  SELECT @Dcto = ISNULL(d.Descuento, ''),@DctoGlobal = ISNULL(d.Porcentaje, 0)
		    FROM cte c 
            JOIN CteEnviarA cea on c.Cliente = cea.Cliente
            LEFT OUTER JOIN Descuento d on d.Descuento = cea.Descuento
           WHERE cea.ID = @SucCte and c.Cliente = @Cliente

		  INSERT INTO Venta(Empresa,  Mov,MovID,FechaEmision, Concepto,Moneda,TipoCambio,Usuario,  Estatus,  Directo,Prioridad,RenglonID,Cliente,EnviarA,Almacen, FechaRequerida,OrdenCompra,Condicion, Vencimiento,  Importe,Impuestos,Descuento,DescuentoGlobal,ServicioGarantia,ServicioExpress,ServicioDemerito,ServicioDeducible,ServicioFlotilla,ServicioRampa,Extra,ListaPreciosEsp,Sucursal,SucursalOrigen,GenerarOP,ConVigencia,DesglosarImpuestos,DesglosarImpuesto2,ExcluirPlaneacion,SubModulo,Comentarios,Extra1,SucursalVenta,AF,FordVisitoOASIS,ServicioPuntual,TieneTasaEsp)
		    VALUES(@Empresa,@Mov,NULL,@FechaEmision,          @Concepto,'Pesos',1.0,     @Usuario,'SINAFECTAR',1,     'Normal',   1,    @Cliente,@SucCte,@Almacen,@FechaEmision,  @CicloEsc, @Condicion,@FechaEmision,@Precio,@Impuesto, @Dcto,     @DctoGlobal,        0,             0,               0,              0,                0,                 0,         0,'(Precio Lista)', @SucCte,  @SucCte,        0,          0,        0,                   0,                 0,             'VTAS',     '',       0,     @SucCte,    0,  0,                 0,              0)											

          SELECT @ID = MAX(ID) FROM Venta
		  SELECT @Renglon = MAX(Renglon) FROM VentaD WHERE ID = @ID
		  SELECT @Renglon = ISNULL(@Renglon,0) + 1024

		  INSERT INTO VentaD(ID,Renglon,RenglonSub,RenglonID,RenglonTipo,EnviarA,Almacen,Articulo,Cantidad,Precio,PrecioSugerido,DescuentoTipo,DescuentoImporte,Impuesto1,Impuesto2,Impuesto3,CantidadReservada,Unidad,Factor,FechaRequerida,UltimoReservadoCantidad,Sucursal,SucursalOrigen,PrecioMoneda,PrecioTipoCambio,ExcluirPlaneacion,ExcluirISAN,PresupuestoEsp)
            VALUES(@ID,@Renglon,0,1,'N',1,@Almacen,@Articulo,1.0,@Precio,@Precio,NULL,NULL,@ImpuestoD,0.0,0.0,1,'pza',1.0,@FechaEmision,1,@SucCte,0,'Pesos',1.0,0,0,0)

          EXEC spAfectar 'VTAS',@ID, 'VERIFICAR', 'Todo', @Usuario = @Usuario, @Estacion = @Estacion, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef= @Okref OUTPUT
		  IF @Ok BETWEEN 80000 AND 80050
		    SELECT @Ok = NULL

		  IF @Ok IS NULL
		    EXEC spAfectar 'VTAS',@ID, 'AFECTAR', 'Todo', NULL, @Usuario = @Usuario, @Estacion = @Estacion, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef= @Okref OUTPUT
			
		  IF @Ok IS NOT NULL
		  BEGIN
		    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
			RAISERROR(@Mensaje, 16, -1)
		  END
		  ELSE
		  BEGIN	
		    IF ISNULL(@CopiarEnTiempo, 0) = 1
			  EXEC spMovCopiarMeses @SucCte,'VTAS',@ID,@Usuario,@FechaD,@FechaA,1,@Unidad,1--Afecta los Movimientos
		  END
		  SELECT @Contcr = @Contcr + 1 
	    FETCH NEXT FROM crVentaLotes INTO @Cliente,@SucCte,@NombreSucCte,@Articulo,@Mov,@Almacen,@Categoria,@Familia,@Grupo,@Concepto,@CicloEsc,@Condicion,@FechaEmision,@ContUso,@CopiarEnTiempo,@AplicaDesc,@FechaD,@FechaA,@Unidad
	  END
	CLOSE crVentaLotes
	DEALLOCATE crVentaLotes
	DELETE FROM VentaLotes WHERE Estacion = @Estacion
	DELETE FROM VentaLotesAux WHERE Estacion = @Estacion
	SELECT @Cont = @Cont * @Contcr

	IF @Cont = 0
  	  SELECT @Mensaje = 'Proceso Concluido'
	ELSE
	  SELECT @Mensaje = 'Proceso Concluido, Movimientos Generados: ' + RTRIM(Convert(char, @Cont))

	SELECT @Mensaje 
	RETURN

  END
RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.spVentaLotesBorrar') and type = 'P') drop procedure dbo.spVentaLotesBorrar
GO
CREATE PROCEDURE spVentaLotesBorrar
	@Estacion	varchar(20)
--//WITH ENCRYPTION
AS 
BEGIN  
  DELETE FROM VentaLotes WHERE Estacion = @Estacion
  DELETE FROM VentaLotesAux WHERE Estacion = @Estacion
  RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.spCalculaEmpaques') and type = 'P') drop procedure dbo.spCalculaEmpaques
GO
CREATE PROCEDURE spCalculaEmpaques
	@ID			int,
	@Modulo		char(5),  
	@Sucursal	int
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE @RenglonID		int,
			@RenglonAux		float,
			@Articulo		varchar(20),
			@Almacen		varchar(10),
			@Empaque		varchar(20),
			@Corrugado		varchar(20),
			@Pzascorrugado	float,
			@PzasEmpaque	int,
			@Cantidad		float,
			@CantidadAux	float,
			@CantidadE		float,
			@CantidadEAux	float,
			@CantidadC		float,			
			@Unidad			varchar(50),
			@FechaRequerida	datetime,
			@Agente			varchar(10),
			@Moneda			varchar(10),
			@TipoCambio		float,
			@Cliente		varchar(10),
			@Mensaje		varchar(100),
			@Estatus		char(15)

  SELECT @Estatus = Estatus FROM Venta v WHERE ID = @ID
  IF @Estatus <> 'SINAFECTAR'
    RETURN

  IF @Modulo = 'VTAS' AND @Estatus = 'SINAFECTAR' --AND @MovTipo = 'VTAS.P'
  BEGIN/*
    IF NOT EXISTS (SELECT ID FROM VentaD WHERE ID = @ID)
	BEGIN
	  SELECT @Mensaje = 'No existen Articulos, no se pueden calcular Empaques'
	  RAISERROR (@Mensaje, 16, -1)
	  RETURN
	END			
*/
	DELETE FROM Ventad WHERE DescripcionExtra = 'Empaques' AND Precio = 0 AND ID = @ID
	
	SELECT @RenglonAux = 0
	
	DECLARE crVentaD CURSOR FOR
 	SELECT v.RenglonID,d.Articulo,d.Cantidad,v.Almacen,v.FechaRequerida,v.Agente,v.Moneda,v.TipoCambio,v.Cliente
	  FROM Venta v 
	  JOIN VentaD d ON v.ID = d.ID
	 WHERE v.ID = @ID
	 ORDER BY d.Renglon
	 
	OPEN crVentaD
	FETCH NEXT FROM crVentaD INTO @RenglonID,@Articulo,@Cantidad,@Almacen,@FechaRequerida,@Agente,@Moneda,@TipoCambio,@Cliente
	WHILE @@FETCH_STATUS = 0
	BEGIN
	  SELECT @RenglonAux = MAX(Renglon) FROM VentaD WHERE ID = @ID
	  SELECT @Unidad = Unidad FROM Art WHERE Articulo = @Articulo
	  IF EXISTS(SELECT Cliente, Articulo FROM CteArtEmpaque WHERE Cliente = @Cliente AND Articulo = @Articulo)
	  BEGIN
	    SELECT @Empaque = ISNULL(Empaque,''), @Corrugado = Corrugado, @PzasCorrugado = PzasCorrugado, @PzasEmpaque = CASE WHEN ISNULL(Empaque,'') = '' THEN 0 ELSE 1 END
		  FROM CteArtEmpaque
         WHERE Articulo = @Articulo AND Cliente = @Cliente
								
        IF @PzasEmpaque <> 0
		BEGIN
		  IF EXISTS(SELECT Articulo FROM VentaD WHERE Articulo = @Empaque AND ID = @ID)
		  BEGIN
		    SELECT @CantidadE = Cantidad FROM VentaD WHERE Articulo = @Empaque AND ID = @ID
			SELECT @CantidadEAux = @CantidadE + @Cantidad
			UPDATE VentaD SET Cantidad = @CantidadEAux,CantidadPendiente = @CantidadEAux,CantidadInventario = @CantidadEAux
			 WHERE Articulo = @Empaque AND ID = @ID
		  END
		  ELSE
		  BEGIN
		    SELECT @RenglonAux = @RenglonAux + 1024
			INSERT INTO VentaD 
			        (ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Cantidad,  Almacen, Articulo, Precio, PrecioSugerido, Unidad, Factor, CantidadInventario, FechaRequerida, Agente, Sucursal, PrecioMoneda, PrecioTipoCambio, DescripcionExtra)
		    VALUES (@ID, @RenglonAux, 0, @RenglonID, 'N',            @Cantidad, @Almacen, @Empaque, 0,       0,            @Unidad, 1 ,    @Cantidad,          @FechaRequerida, @Agente, @Sucursal, @Moneda, @TipoCambio, 'Empaques')		
		  END
		END
		
		IF EXISTS(SELECT Articulo FROM VentaD WHERE Articulo = @Corrugado AND ID = @ID)
		BEGIN
		  SELECT @CantidadAux = CEILING(ISNULL(@Cantidad,0)/ISNULL(@Pzascorrugado,0))
		  SELECT @CantidadC = Cantidad FROM VentaD WHERE Articulo = @Corrugado AND ID = @ID
		  SELECT @CantidadAux = @CantidadC + @CantidadAux
		  UPDATE VentaD SET Cantidad = @CantidadAux,CantidadPendiente = @CantidadAux,CantidadInventario = @CantidadAux
		   WHERE Articulo = @Corrugado AND ID = @ID
		END
		ELSE
		BEGIN
		  SELECT @RenglonAux = @RenglonAux + 1024
		  SELECT @CantidadAux = CEILING(ISNULL(@Cantidad,0)/ISNULL(@Pzascorrugado,0))
		  INSERT INTO VentaD
		         (ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Cantidad,  Almacen, Articulo, Precio, PrecioSugerido, Unidad, Factor, CantidadInventario, FechaRequerida, Agente, Sucursal, PrecioMoneda, PrecioTipoCambio, DescripcionExtra)
		  VALUES (@ID, @RenglonAux, 0, @RenglonID, 'N',        @CantidadAux, @Almacen, @Corrugado,0,       0,            @Unidad, 1,     @CantidadAux,      @FechaRequerida,  @Agente, @Sucursal, @Moneda, @TipoCambio, 'Empaques')		
		END
	  END
      FETCH NEXT FROM crVentaD INTO @RenglonID,@Articulo,@Cantidad,@Almacen,@FechaRequerida,@Agente,@Moneda,@TipoCambio,@Cliente
	END
	CLOSE crVentaD
	DEALLOCATE crVentaD
  END
  RETURN
END
GO

/**************** spVentaActualizaDevolucion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaActualizaDevolucion') and type = 'P') drop procedure dbo.spVentaActualizaDevolucion
GO             
CREATE PROCEDURE spVentaActualizaDevolucion
											@RId		int,
											@Eliminar	int
--//WITH ENCRYPTION
AS BEGIN
	 DECLARE @ID					int, 
			 @VentaDRenglon			float, 
			 @VentaDRenglonID		int,
			 @Cantidad				float, 
			 @Articulo				varchar(20), 
			 @Almacen				varchar(10), 
			 @Empresa				varchar(5),
			 @Clave					varchar(20)
	 
	 SELECT @Clave = mt.Clave 
	   FROM Venta v
	   JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS'
	  WHERE v.ID = @RId
	 
	 IF @Clave = 'VTAS.D'
	 BEGIN
		 UPDATE VentaDevolucion SET Estatus = 1 WHERE id = @RId
 
		 DECLARE crVentaCteD CURSOR FOR
				SELECT d.ID, d.Renglon, d.RenglonID, d.Cantidad, d.Articulo, d.Almacen, v.Empresa
				  FROM Venta v
			INNER JOIN VentaD d ON v.ID = d.ID
				 WHERE v.ID = @RId

		OPEN crVentaCteD
		FETCH NEXT FROM crVentaCteD INTO @ID, @VentaDRenglon, @VentaDRenglonID, @Cantidad, @Articulo, @Almacen, @Empresa
		WHILE @@FETCH_STATUS = 0
		BEGIN	
	
			IF EXISTS (SELECT * FROM VentaDevolucion WHERE ID = @ID AND RenglonRID = @VentaDRenglon AND Articulo = @Articulo)
				UPDATE VentaDevolucion SET Estatus = 0 WHERE ID = @ID AND RenglonRID = @VentaDRenglon AND Articulo = @Articulo	

		  FETCH NEXT FROM crVentaCteD INTO @ID, @VentaDRenglon, @VentaDRenglonID, @Cantidad, @Articulo, @Almacen, @Empresa
		END
		CLOSE crVentaCteD
		DEALLOCATE crVentaCteD

		DELETE VentaDevolucion WHERE Estatus = 1 AND id = @RId 	

	 END

	 IF @Eliminar = 1
		DELETE VentaDevolucion WHERE ID = @RId
END
GO