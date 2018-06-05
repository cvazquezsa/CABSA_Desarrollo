/************** fixAplicaDifEfectivo ***************/
if exists (select * from sysobjects where id = object_id('dbo.fixAplicaDifEfectivo') and type = 'P') drop procedure dbo.fixAplicaDifEfectivo
GO
CREATE PROCEDURE fixAplicaDifEfectivo
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
     @ID 	int,
     @Importe	money

  DECLARE crCxc CURSOR FOR 
   select a.id, d.Importe
     from cxcd d, cxc c, auxiliar a
    where a.Modulo = 'CXC' and a.ModuloID = d.ID AND UPPER(d.Aplica) IN ('EFECTIVO A FAVOR', 'SALDO A FAVOR', 'REDONDEO')
      AND a.Rama = 'CEFE' AND ABS(ROUND(ISNULL(d.Importe, 0), 0)) <> ABS(ROUND(ISNULL(-a.Abono, 0), 0))
      AND c.ID = d.ID /*and c.Estatus <> 'CANCELADO'*/
    ORDER BY c.Empresa, c.Mov, c.MovID

  OPEN crCxc
  FETCH NEXT FROM crCxc INTO @ID, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spCorregirAuxiliar @ID, NULL, @Importe
    END
    FETCH NEXT FROM crCxc INTO @ID, @Importe
  END
  CLOSE crCxc
  DEALLOCATE crCxc

  DECLARE crCxp CURSOR FOR 
   select a.id, d.Importe
     from cxpd d, cxp c, auxiliar a
    where a.Modulo = 'CXP' and a.ModuloID = d.ID AND UPPER(d.Aplica) IN ('EFECTIVO A FAVOR', 'SALDO A FAVOR', 'REDONDEO')
      AND a.Rama = 'PEFE' AND ABS(ROUND(ISNULL(d.Importe, 0), 0)) <> ABS(ROUND(ISNULL(-a.Abono, 0), 0))
      AND c.ID = d.ID /*and c.Estatus <> 'CANCELADO'*/
    ORDER BY c.Empresa, c.Mov, c.MovID

  OPEN crCxp
  FETCH NEXT FROM crCxp INTO @ID, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spCorregirAuxiliar @ID, NULL, @Importe
    END
    FETCH NEXT FROM crCxp INTO @ID, @Importe
  END
  CLOSE crCxp
  DEALLOCATE crCxp


  RETURN
END
GO


/************** fixInvProdNominaImporte ***************/
if exists (select * from sysobjects where id = object_id('dbo.fixInvProdNominaImporte') and type = 'P') drop procedure dbo.fixInvProdNominaImporte
GO
CREATE PROCEDURE fixInvProdNominaImporte
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Importe		money,
    @Percepciones	money,
    @Deducciones	money

  DECLARE crFixInv CURSOR FOR SELECT ID FROM Inv
  OPEN crFixInv
  FETCH NEXT FROM crFixInv INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Importe = NULL
      SELECT @Importe = SUM(Cantidad*Costo)
        FROM InvD 
       WHERE ID = @ID
      UPDATE Inv SET Importe = @Importe WHERE CURRENT OF crFixInv 
    END
    FETCH NEXT FROM crFixInv INTO @ID
  END
  CLOSE crFixInv
  DEALLOCATE crFixInv

  DECLARE crFixProd CURSOR FOR SELECT ID FROM Prod
  OPEN crFixProd
  FETCH NEXT FROM crFixProd INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Importe = NULL
      SELECT @Importe = SUM(Cantidad*Costo)
        FROM ProdD 
       WHERE ID = @ID

      UPDATE Prod SET Importe = @Importe WHERE CURRENT OF crFixProd
    END
    FETCH NEXT FROM crFixProd INTO @ID
  END
  CLOSE crFixProd
  DEALLOCATE crFixProd

  DECLARE crFixNomina CURSOR FOR SELECT ID FROM Nomina
  OPEN crFixNomina
  FETCH NEXT FROM crFixNomina INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Percepciones = NULL
      SELECT @Percepciones = SUM(Importe)
        FROM NominaD
       WHERE ID = @ID AND UPPER(Movimiento) = 'PERCEPCION'

      SELECT @Deducciones = NULL
      SELECT @Deducciones = SUM(Importe)
        FROM NominaD
       WHERE ID = @ID AND UPPER(Movimiento) = 'DEDUCCION'

      UPDATE Nomina 
         SET Percepciones = @Percepciones,
             Deducciones  = @Deducciones
       WHERE CURRENT OF crFixNomina
    END
    FETCH NEXT FROM crFixNomina INTO @ID
  END
  CLOSE crFixNomina
  DEALLOCATE crFixNomina

  UPDATE Venta 
     SET Saldo = NULL
   WHERE Estatus IN ('CONCLUIDO', 'CANCELADO')
     AND NULLIF(Saldo, 0.0) IS NOT NULL
END
GO


/************** fixAgentPagoDev ***************/
if exists (select * from sysobjects where id = object_id('dbo.fixAgentPagoDev') and type = 'P') drop procedure dbo.fixAgentPagoDev
GO
CREATE PROCEDURE fixAgentPagoDev
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int,
    @NuevoAbono	money

  DECLARE crFixAgent CURSOR FOR 
   SELECT x.ID, -x.Abono
     FROM Auxiliar x, MovTipo m, MovTipo a
    WHERE Rama = 'AGENT' AND x.Mov = m.Mov AND x.Aplica = a.Mov AND m.Clave = 'AGENT.P' AND a.Clave = 'AGENT.D'
      AND ((x.Abono > 0.0 AND x.EsCancelacion = 0) OR (x.Abono < 0.0 AND x.EsCancelacion = 1))

  OPEN crFixAgent
  FETCH NEXT FROM crFixAgent INTO @ID, @NuevoAbono
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spCorregirAuxiliar @ID, NULL, @NuevoAbono
    END
    FETCH NEXT FROM crFixAgent INTO @ID, @NuevoAbono
  END
  CLOSE crFixAgent
  DEALLOCATE crFixAgent
END
GO


/************** fixAgentAnticipo ***************/
if exists (select * from sysobjects where id = object_id('dbo.fixAgentAnticipo') and type = 'P') drop procedure dbo.fixAgentAnticipo
GO
CREATE PROCEDURE fixAgentAnticipo
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @Importe		money,
     @Saldo		money,
     @SaldoNuevo	money,
     @Estatus		char(15)

  DECLARE crFixAgent CURSOR FOR 
   SELECT Importe, Saldo
     FROM Agent a, MovTipo mt
    WHERE a.Mov = mt.Mov AND mt.Clave = 'AGENT.A' AND a.Estatus = 'PENDIENTE' AND a.Saldo > a.Importe

  OPEN crFixAgent
  FETCH NEXT FROM crFixAgent INTO @Importe, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @SaldoNuevo = @Importe - (@Saldo - @Importe)
      IF @SaldoNuevo <= 0 SELECT @SaldoNuevo = NULL, @Estatus = 'CONCLUIDO' ELSE SELECT @Estatus = 'PENDIENTE'
      UPDATE Agent SET Saldo = @SaldoNuevo, Estatus = @Estatus WHERE CURRENT OF crFixAgent
    END
    FETCH NEXT FROM crFixAgent INTO @Importe, @Saldo
  END
  CLOSE crFixAgent
  DEALLOCATE crFixAgent
END
GO

/************** fixArtAlm ***************/
if exists (select * from sysobjects where id = object_id('dbo.fixArtAlm') and type = 'P') drop procedure dbo.fixArtAlm
GO
CREATE PROCEDURE fixArtAlm
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @Articulo		char(20),
    @SubCuenta  	char(20),
    @Almacen		char(10),
    @Minimo		float,
    @LoteOrdenar	varchar(30),
    @CantidadOrdenar	float,
    @MultiplosOrdenar	float
    

  DECLARE crFixArtAlm CURSOR FOR 
   SELECT Empresa, "Articulo" = Cuenta, SubCuenta, Grupo
     FROM SaldoU
    WHERE Rama = 'INV' 
    GROUP BY Empresa, Cuenta, SubCuenta, Grupo

  OPEN crFixArtAlm
  FETCH NEXT FROM crFixArtAlm INTO @Empresa, @Articulo, @SubCuenta, @Almacen
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      EXEC spRegistrarArtAlm @Empresa, @Articulo, @SubCuenta, @Almacen, NULL
      SELECT @Minimo = NULL, @LoteOrdenar = NULL, @CantidadOrdenar = NULL, @MultiplosOrdenar = NULL
      SELECT @Minimo = NULLIF(InvSeguridad, 0) FROM Art WHERE Articulo = @Articulo AND AlmacenROP = @Almacen
      IF @Minimo IS NOT NULL OR @LoteOrdenar IS NOT NULL OR @CantidadOrdenar IS NOT NULL OR @MultiplosOrdenar IS NOT NULL
        UPDATE ArtAlm 
           SET Minimo = @Minimo, LoteOrdenar = @LoteOrdenar, CantidadOrdenar = @CantidadOrdenar, MultiplosOrdenar = @MultiplosOrdenar
         WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @Almacen
    END

    FETCH NEXT FROM crFixArtAlm INTO @Empresa, @Articulo, @SubCuenta, @Almacen
  END
  CLOSE crFixArtAlm
  DEALLOCATE crFixArtAlm
END
GO

/************** fixAuxiliarDescuentoLineal **************/
if exists (select * from sysobjects where id = object_id('dbo.fixAuxiliarDescuentoLineal') and type = 'P') drop procedure dbo.fixAuxiliarDescuentoLineal
GO
CREATE PROCEDURE fixAuxiliarDescuentoLineal
			@Modulo		char(5),
			@ID		int,
			@Importe	money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cargo	money,
    @Abono	money

  DECLARE crAuxiliar CURSOR FOR
    SELECT Cargo, Abono FROM Auxiliar WHERE Modulo = @Modulo AND ModuloID = @ID
  OPEN crAuxiliar
  FETCH NEXT FROM crAuxiliar INTO @Cargo, @Abono
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Cargo IS NOT NULL SELECT @Cargo = @Importe ELSE SELECT @Abono = @Importe
      UPDATE Auxiliar SET Cargo = @Cargo, Abono = @Abono WHERE CURRENT OF crAuxiliar 
    END
    FETCH NEXT FROM crAuxiliar INTO @Cargo, @Abono
  END
  CLOSE crAuxiliar 
  DEALLOCATE crAuxiliar 
END
GO

/************** fixCxpDescuentoLineal **************/
if exists (select * from sysobjects where id = object_id('dbo.fixCxpDescuentoLineal') and type = 'P') drop procedure dbo.fixCxpDescuentoLineal
GO
CREATE PROCEDURE fixCxpDescuentoLineal
			@OrigenTipo	char(10),
			@Origen		char(20),
			@OrigenID	char(20),
			@NuevoImporte	money,
			@NuevoImpuestos	money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Importe		money,
    @Impuestos		money,
    @Saldo		money,
    @Pagado		money,
    @Estatus		char(15),
    @NuevoSaldo		money,
    @NuevoImporteTotal	money,
    @NuevoEstatus	char(15)
  
  DECLARE crCxp CURSOR FOR
   SELECT ID, ISNULL(Importe, 0), ISNULL(Impuestos, 0), ISNULL(Saldo, 0), Estatus 
     FROM Cxp 
    WHERE OrigenTipo = @OrigenTipo and Origen = @Origen and OrigenID = @OrigenID
      AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
  OPEN crCxp 
  FETCH NEXT FROM crCxp INTO @ID, @Importe, @Impuestos, @Saldo, @Estatus
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF ROUND(@Importe, 0) <> ROUND(@NuevoImporte, 0) OR ROUND(@Impuestos, 0) <> ROUND(@NuevoImpuestos, 0)
      BEGIN
        SELECT @NuevoImporteTotal = @NuevoImporte + @NuevoImpuestos
        SELECT @Pagado = @Importe + @Impuestos - @Saldo, @NuevoEstatus = @Estatus
        SELECT @NuevoSaldo = @NuevoImporteTotal - @Pagado
        IF @NuevoSaldo < 0.0 SELECT @NuevoSaldo = 0.0
        IF @NuevoSaldo > 0.0 SELECT @NuevoEstatus = 'PENDIENTE' ELSE SELECT @NuevoEstatus = 'CONCLUIDO'
        UPDATE Cxp SET Importe = @NuevoImporte, Impuestos = @NuevoImpuestos, Saldo = @NuevoSaldo, Estatus = @NuevoEstatus WHERE CURRENT OF crCxp 
        EXEC fixAuxiliarDescuentoLineal 'CXP', @ID, @NuevoImporteTotal
      END       
    END
    FETCH NEXT FROM crCxp INTO @ID, @Importe, @Impuestos, @Saldo, @Estatus
  END
  CLOSE crCxp 
  DEALLOCATE crCxp 
END
GO


/************** fixCompraDescuentoLineal **************/
if exists (select * from sysobjects where id = object_id('dbo.fixCompraDescuentoLineal') and type = 'P') drop procedure dbo.fixCompraDescuentoLineal
GO
CREATE PROCEDURE fixCompraDescuentoLineal
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Mov		char(20),
    @MovID		char(20),
    @Empresa		char(5),
    @Estatus		char(15),
    @Importe		money,
    @Impuestos		money,
    @DescuentoGlobal	money,
    @CfgMultiUnidades	bit,
    @CfgImpInc		bit

  DECLARE crCompra CURSOR FOR
    SELECT DISTINCT ID FROM CompraD WHERE DescuentoTipo = '$'
  OPEN crCompra
  FETCH NEXT FROM crCompra INTO @ID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Empresa = Empresa, @Mov = Mov, @MovID = MovID, @Estatus = Estatus, @DescuentoGlobal = DescuentoGlobal FROM Compra WHERE ID = @ID
      IF @Estatus IN ('PENDIENTE', 'CONCLUIDO', 'VIGENTE')
      BEGIN
        --SELECT @CfgImpInc = CompraPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa
        SELECT @CfgMultiUnidades = MultiUnidades FROM EmpresaCfg2 WHERE Empresa = @Empresa

        EXEC spInvReCalcEncabezado @ID, 'COMS', 0, @CfgMultiUnidades, @DescuentoGlobal
        SELECT @Importe = Importe, @Impuestos = Impuestos FROM Compra WHERE ID = @ID
        EXEC fixCxpDescuentoLineal 'COMS', @Mov, @MovID, @Importe, @Impuestos
      END
    END
    FETCH NEXT FROM crCompra INTO @ID
  END
  CLOSE crCompra
  DEALLOCATE crCompra
END
GO


/************** fixCxcDescuentoLineal **************/
if exists (select * from sysobjects where id = object_id('dbo.fixCxcDescuentoLineal') and type = 'P') drop procedure dbo.fixCxcDescuentoLineal
GO
CREATE PROCEDURE fixCxcDescuentoLineal
			@OrigenTipo	char(10),
			@Origen		char(20),
			@OrigenID	char(20),
			@NuevoImporte	money,
			@NuevoImpuestos	money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Importe		money,
    @Impuestos		money,
    @Saldo		money,
    @Pagado		money,
    @Estatus		char(15),
    @NuevoSaldo		money,
    @NuevoImporteTotal	money,
    @NuevoEstatus	char(15)
  
  DECLARE crCxc CURSOR FOR
   SELECT ID, ISNULL(Importe, 0), ISNULL(Impuestos, 0), ISNULL(Saldo, 0), Estatus 
     FROM Cxc 
    WHERE OrigenTipo = @OrigenTipo and Origen = @Origen and OrigenID = @OrigenID
      AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
  OPEN crCxc 
  FETCH NEXT FROM crCxc INTO @ID, @Importe, @Impuestos, @Saldo, @Estatus
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF ROUND(@Importe, 0) <> ROUND(@NuevoImporte, 0) OR ROUND(@Impuestos, 0) <> ROUND(@NuevoImpuestos, 0)
      BEGIN
        SELECT @NuevoImporteTotal = @NuevoImporte + @NuevoImpuestos
        SELECT @Pagado = @Importe + @Impuestos - @Saldo, @NuevoEstatus = @Estatus
        SELECT @NuevoSaldo = @NuevoImporteTotal - @Pagado
        IF @NuevoSaldo < 0.0 SELECT @NuevoSaldo = 0.0
        IF @NuevoSaldo > 0.0 SELECT @NuevoEstatus = 'PENDIENTE' ELSE SELECT @NuevoEstatus = 'CONCLUIDO'
        UPDATE Cxc SET Importe = @NuevoImporte, Impuestos = @NuevoImpuestos, Saldo = @NuevoSaldo, Estatus = @NuevoEstatus WHERE CURRENT OF crCxc 
        EXEC fixAuxiliarDescuentoLineal 'Cxc', @ID, @NuevoImporteTotal
      END       
    END
    FETCH NEXT FROM crCxc INTO @ID, @Importe, @Impuestos, @Saldo, @Estatus
  END
  CLOSE crCxc 
  DEALLOCATE crCxc 
END
GO


/************** fixVentaDescuentoLineal **************/
if exists (select * from sysobjects where id = object_id('dbo.fixVentaDescuentoLineal') and type = 'P') drop procedure dbo.fixVentaDescuentoLineal
GO
CREATE PROCEDURE fixVentaDescuentoLineal
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Mov		char(20),
    @MovID		char(20),
    @Empresa		char(5),
    @Estatus		char(15),
    @Importe		money,
    @Impuestos		money,
    @DescuentoGlobal	money,
    @CfgMultiUnidades	bit,
    @CfgImpInc		bit

  DECLARE crVenta CURSOR FOR
    SELECT DISTINCT ID FROM VentaD WHERE DescuentoTipo = '$'
  OPEN crVenta
  FETCH NEXT FROM crVenta INTO @ID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Empresa = Empresa, @Mov = Mov, @MovID = MovID, @Estatus = Estatus, @DescuentoGlobal = DescuentoGlobal FROM Venta WHERE ID = @ID
      IF @Estatus IN ('PENDIENTE', 'CONCLUIDO', 'VIGENTE')
      BEGIN
        SELECT @CfgImpInc = VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa
        SELECT @CfgMultiUnidades = MultiUnidades FROM EmpresaCfg2 WHERE Empresa = @Empresa

        EXEC spInvReCalcEncabezado @ID, 'VTAS', @CfgImpInc, @CfgMultiUnidades, @DescuentoGlobal
        SELECT @Importe = Importe, @Impuestos = Impuestos FROM Venta WHERE ID = @ID
        EXEC fixCxcDescuentoLineal 'VTAS', @Mov, @MovID, @Importe, @Impuestos
      END
    END
    FETCH NEXT FROM crVenta INTO @ID
  END
  CLOSE crVenta
  DEALLOCATE crVenta
END
GO


/************** fixBonificacionVentas **************/
if exists (select * from sysobjects where id = object_id('dbo.fixBonificacionVentas') and type = 'P') drop procedure dbo.fixBonificacionVentas
GO
CREATE PROCEDURE fixBonificacionVentas
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int,
    @Cargo	money,
    @Abono	money

  DECLARE crAuxiliarRU CURSOR FOR
    SELECT a.ID, a.Cargo, a.Abono
      FROM AuxiliarRU a, MovTipo mt 
     WHERE a.Modulo = 'VTAS' AND mt.Modulo = 'VTAS' AND mt.Mov = a.Mov AND mt.Clave = 'VTAS.B' AND (ISNULL(a.CargoU,0) <> 0 OR ISNULL(a.AbonoU, 0)<>0)
  OPEN crAuxiliarRU
  FETCH NEXT FROM crAuxiliarRU INTO @ID, @Cargo, @Abono
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spCorregirAuxiliarRU @ID, @Cargo, @Abono, NULL, NULL
    END
    FETCH NEXT FROM crAuxiliarRU INTO @ID, @Cargo, @Abono
  END
  CLOSE crAuxiliarRU
  DEALLOCATE crAuxiliarRU
END
GO


/************** fixVentaEliminarImpuesto3 **************/
if exists (select * from sysobjects where id = object_id('dbo.fixVentaEliminarImpuesto3') and type = 'P') drop procedure dbo.fixVentaEliminarImpuesto3
GO
CREATE PROCEDURE fixVentaEliminarImpuesto3
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @CxcID		int,
    @Mov		char(20),
    @MovID		char(20),
    @Empresa		char(5),
    @Estatus		char(15),
    @Importe		money,
    @Impuestos		money,
    @DescuentoGlobal	money,
    @CfgMultiUnidades	bit,
    @CfgImpInc		bit,
    @CxcImporte		money,
    @CxcImpuestos	money,
    @CxcSaldo		money,
    @CxcCobrado		money,
    @CxcEstatus		char(15)

  DECLARE crVenta CURSOR FOR
    SELECT DISTINCT ID FROM VentaD WHERE NULLIF(Impuesto3, 0) IS NOT NULL
  OPEN crVenta
  FETCH NEXT FROM crVenta INTO @ID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      UPDATE VentaD SET Impuesto3 = NULL WHERE ID = @ID
      SELECT @Empresa = Empresa, @Mov = Mov, @MovID = MovID, @Estatus = Estatus, @DescuentoGlobal = DescuentoGlobal FROM Venta WHERE ID = @ID
      SELECT @CfgMultiUnidades = MultiUnidades FROM EmpresaCfg2 WHERE Empresa = @Empresa

      EXEC spInvReCalcEncabezado @ID, 'VTAS', 0, @CfgMultiUnidades, @DescuentoGlobal
      SELECT @Importe = Importe, @Impuestos = Impuestos FROM Venta WHERE ID = @ID
      SELECT @CxcID = NULL
      SELECT @CxcID = ID, @CxcImporte = ISNULL(Importe, 0), @CxcImpuestos = ISNULL(Impuestos, 0), @CxcSaldo = ISNULL(Saldo, 0), @CxcEstatus = Estatus 
        FROM Cxc 
       WHERE Empresa = @Empresa AND OrigenTipo = 'VTAS' AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      IF @CxcID IS NOT NULL
      BEGIN
        SELECT @CxcCobrado = @CxcImporte + @CxcImpuestos - @CxcSaldo
        UPDATE Cxc SET Importe = @Importe, Impuestos = @Impuestos, Saldo = ISNULL(@Importe, 0) + ISNULL(@Impuestos, 0) - ISNULL(@CxcCobrado, 0), Estatus = 'PENDIENTE' WHERE ID = @CxcID
      END
    END
    FETCH NEXT FROM crVenta INTO @ID
  END
  CLOSE crVenta
  DEALLOCATE crVenta
END
GO


/************** fixVentaEncabezado **************/
if exists (select * from sysobjects where id = object_id('dbo.fixVentaEncabezado') and type = 'P') drop procedure dbo.fixVentaEncabezado
GO
CREATE PROCEDURE fixVentaEncabezado
			@ID	int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CxcID		int,
    @Mov		char(20),
    @MovID		char(20),
    @Empresa		char(5),
    @Estatus		char(15),
    @Importe		money,
    @Impuestos		money,
    @DescuentoGlobal	money,
    @CfgMultiUnidades	bit,
    @CfgImpInc		bit,
    @CxcImporte		money,
    @CxcImpuestos	money,
    @CxcSaldo		money,
    @CxcCobrado		money,
    @CxcEstatus		char(15)

  DECLARE crVenta CURSOR FOR
    SELECT ID 
      FROM Venta 
     WHERE Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND ID = ISNULL(@ID, ID)

  OPEN crVenta
  FETCH NEXT FROM crVenta INTO @ID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      UPDATE VentaD SET Impuesto3 = NULL WHERE ID = @ID
      SELECT @Empresa = Empresa, @Mov = Mov, @MovID = MovID, @Estatus = Estatus, @DescuentoGlobal = DescuentoGlobal FROM Venta WHERE ID = @ID
      SELECT @CfgMultiUnidades = MultiUnidades FROM EmpresaCfg2 WHERE Empresa = @Empresa

      EXEC spInvReCalcEncabezado @ID, 'VTAS', 0, @CfgMultiUnidades, @DescuentoGlobal
      SELECT @Importe = SubTotal, @Impuestos = Impuestos FROM VentaCalc WHERE ID = @ID
      SELECT @CxcID = NULL
      SELECT @CxcID = ID, @CxcImporte = ISNULL(Importe, 0), @CxcImpuestos = ISNULL(Impuestos, 0), @CxcSaldo = ISNULL(Saldo, 0), @CxcEstatus = Estatus 
        FROM Cxc 
       WHERE Empresa = @Empresa AND OrigenTipo = 'VTAS' AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')

      IF @CxcID IS NOT NULL AND (@CxcImporte <> @Importe OR @CxcImpuestos <> @Impuestos)
      BEGIN
        SELECT @CxcCobrado = @CxcImporte + @CxcImpuestos - @CxcSaldo
        UPDATE Cxc SET Importe = @Importe, Impuestos = @Impuestos, Saldo = ISNULL(@Importe, 0) + ISNULL(@Impuestos, 0) - ISNULL(@CxcCobrado, 0), Estatus = 'PENDIENTE' WHERE ID = @CxcID
      END
    END
    FETCH NEXT FROM crVenta INTO @ID
  END
  CLOSE crVenta
  DEALLOCATE crVenta
END
GO



/************** fixVentaComision **************/
if exists (select * from sysobjects where id = object_id('dbo.fixVentaComision') and type = 'P') drop procedure dbo.fixVentaComision
GO
CREATE PROCEDURE fixVentaComision
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Mov		char(20),
    @MovID		char(20),
    @ComisionTotal	money,
    @DescuentoGlobal	money,
    @CfgMultiUnidades	bit,
    @CfgImpInc		bit

  SELECT @CfgImpInc = VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @CfgMultiUnidades = MultiUnidades FROM EmpresaCfg2 WHERE Empresa = @Empresa

  DECLARE crVenta CURSOR FOR
    SELECT v.ID, v.Mov, v.MovID, v.DescuentoGlobal 
      FROM Venta v, MovTipo mt
     WHERE v.Empresa = @Empresa AND v.FechaEmision BETWEEN @FechaD AND @FechaA AND v.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.F', 'VTAS.FB', 'VTAS.D', 'VTAS.DF', 'VTAS.B', 'VTAS.FM', 'VTAS.N')

  OPEN crVenta
  FETCH NEXT FROM crVenta INTO @ID, @Mov, @MovID, @DescuentoGlobal 
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spInvReCalcEncabezado @ID, 'VTAS', @CfgImpInc, @CfgMultiUnidades, @DescuentoGlobal, @CalcComisiones = 1
      SELECT @ComisionTotal = ComisionTotal FROM Venta WHERE ID = @ID
      UPDATE Cxc 
         SET ComisionTotal = @ComisionTotal 
       WHERE OrigenTipo = 'VTAS' AND Origen = @Mov AND OrigenID = @MovID AND Empresa = @Empresa AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
    END
    FETCH NEXT FROM crVenta INTO @ID, @Mov, @MovID, @DescuentoGlobal 
  END
  CLOSE crVenta
  DEALLOCATE crVenta
END
GO


/************** fixRHPlaza **************/
if exists (select * from sysobjects where id = object_id('dbo.fixRHPlaza') and type = 'P') drop procedure dbo.fixRHPlaza
GO
CREATE PROCEDURE fixRHPlaza
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EnUso		int,
    @Empresa		char(5), 
    @Sucursal		int, 
    @Departamento	varchar(50), 
    @Puesto		varchar(50)

  DECLARE crRHPlaza CURSOR FOR
    SELECT Empresa, Sucursal, Departamento, Puesto
      FROM RHPlaza

  OPEN crRHPlaza
  FETCH NEXT FROM crRHPlaza INTO @Empresa, @Sucursal, @Departamento, @Puesto
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @EnUso = NULL
      SELECT @EnUso = COUNT(*) 
        FROM Personal 
       WHERE Estatus IN ('ALTA') AND SucursalTrabajo = @Sucursal AND Departamento = @Departamento AND Puesto = @Puesto

      UPDATE RHPlaza SET EnUso = @EnUso WHERE CURRENT OF crRHPlaza
    END
    FETCH NEXT FROM crRHPlaza INTO @Empresa, @Sucursal, @Departamento, @Puesto
  END
  CLOSE crRHPlaza
  DEALLOCATE crRHPlaza
END
GO


/************** fixCantidadPendiente **************/
if exists (select * from sysobjects where id = object_id('dbo.fixCantidadPendiente') and type = 'P') drop procedure dbo.fixCantidadPendiente
GO
CREATE PROCEDURE fixCantidadPendiente
--//WITH ENCRYPTION
AS BEGIN
  UPDATE InvD 
     SET CantidadPendiente = NULL
    FROM Inv e, InvD d
   WHERE e.ID = d.ID AND e.Estatus = 'PENDIENTE' AND ROUND(d.CantidadPendiente, 2) = 0

  UPDATE VentaD 
     SET CantidadPendiente = NULL
    FROM Venta e, VentaD d
   WHERE e.ID = d.ID AND e.Estatus = 'PENDIENTE' AND ROUND(d.CantidadPendiente, 2) = 0
 
  UPDATE CompraD 
     SET CantidadPendiente = NULL
    FROM Compra e, CompraD d
   WHERE e.ID = d.ID AND e.Estatus = 'PENDIENTE' AND ROUND(d.CantidadPendiente, 2) = 0

  UPDATE ProdD 
     SET CantidadPendiente = NULL
    FROM Prod e, ProdD d
   WHERE e.ID = d.ID AND e.Estatus = 'PENDIENTE' AND ROUND(d.CantidadPendiente, 2) = 0
END
GO



/************** fixAuxiliarConciliado **************/
if exists (select * from sysobjects where id = object_id('dbo.fixAuxiliarConciliado') and type = 'P') drop procedure dbo.fixAuxiliarConciliado
GO
CREATE PROCEDURE fixAuxiliarConciliado
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @Mov		char(20),
    @MovID		varchar(20),
    @ModuloID		int,
    @Cuenta		char(20),
    @FechaConciliacion	datetime

  DECLARE crAuxiliar CURSOR FOR
    SELECT Empresa, Mov, MovID, ModuloID, FechaConciliacion, Cuenta
      FROM Auxiliar
     WHERE Modulo = 'DIN' AND Conciliado = 1

  OPEN crAuxiliar
  FETCH NEXT FROM crAuxiliar INTO @Empresa, @Mov, @MovID, @ModuloID, @FechaConciliacion, @Cuenta
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      UPDATE Dinero SET Conciliado       = 1, FechaConciliacion       = @FechaConciliacion WHERE ID = @ModuloID
      UPDATE Cxc    SET DineroConciliado = 1, DineroFechaConciliacion = @FechaConciliacion WHERE Empresa = @Empresa AND Dinero = @Mov AND DineroID = @MovID AND DineroCtaDinero = @Cuenta
      UPDATE Cxp    SET DineroConciliado = 1, DineroFechaConciliacion = @FechaConciliacion WHERE Empresa = @Empresa AND Dinero = @Mov AND DineroID = @MovID AND DineroCtaDinero = @Cuenta
      UPDATE Gasto  SET DineroConciliado = 1, DineroFechaConciliacion = @FechaConciliacion WHERE Empresa = @Empresa AND Dinero = @Mov AND DineroID = @MovID AND DineroCtaDinero = @Cuenta
    END
    FETCH NEXT FROM crAuxiliar INTO @Empresa, @Mov, @MovID, @ModuloID, @FechaConciliacion, @Cuenta
  END
  CLOSE crAuxiliar
  DEALLOCATE crAuxiliar
END
GO


/************** fixDevCompraDesc **************/
if exists (select * from sysobjects where id = object_id('dbo.fixDevCompraDesc') and type = 'P') drop procedure dbo.fixDevCompraDesc
GO
CREATE PROCEDURE fixDevCompraDesc
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  update comprad set costo = ROUND((d.costo/((100-ISNULL(d.DescuentoLinea, 0))/100))/((100-ISNULL(c.DescuentoGlobal, 0))/100), 2)
    from compra c, comprad d
   where c.id = d.id and c.id = @ID
END
GO

/************** fixComisionesNotasCargo **************/
if exists (select * from sysobjects where id = object_id('dbo.fixComisionesNotasCargo') and type = 'P') drop procedure dbo.fixComisionesNotasCargo
GO
CREATE PROCEDURE fixComisionesNotasCargo
--//WITH ENCRYPTION
AS BEGIN
  UPDATE Cxc 
     SET ComisionTotal = NULL, ComisionPendiente = NULL
    FROM Cxc c, MovTipo mt
   WHERE c.Mov = mt.Mov AND mt.Modulo = 'CXC' AND mt.Clave IN ('CXC.CA', 'CXC.CAD') AND (NULLIF(ComisionTotal, 0) IS NOT NULL OR NULLIF(ComisionPendiente, 0) IS NOT NULL)
END
GO

/************** fixNominaPersonal **************/
if exists (select * from sysobjects where id = object_id('dbo.fixNominaPersonal') and type = 'P') drop procedure dbo.fixNominaPersonal
GO
CREATE PROCEDURE fixNominaPersonal
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID 	int

  SELECT @ID = MIN(ID) FROM NominaPersonal
  INSERT NominaPersonal (ID, Personal, SucursalTrabajo, CentroCostos, UEN, Actividad)
  SELECT n.ID, d.Personal, n.Sucursal, p.CentroCostos, p.UEN, p.Actividad
    FROM Nomina n, NominaD d, Personal p, MovTipo mt
   WHERE n.ID = d.ID AND d.Personal = p.Personal 
     AND mt.Modulo = 'NOM' AND mt.Mov = n.Mov AND mt.Clave IN ('NOM.N', 'NOM.NE', 'NOM.NA', 'NOM.NC')
     AND n.ID < @ID
   GROUP BY n.ID, d.Personal, n.Sucursal, p.CentroCostos, p.UEN, p.Actividad
   ORDER BY n.ID, d.Personal, n.Sucursal, p.CentroCostos, p.UEN, p.Actividad
END
GO


/************** fixCorteCaja **************/
if exists (select * from sysobjects where id = object_id('dbo.fixCorteCaja') and type = 'P') drop procedure dbo.fixCorteCaja
GO
CREATE PROCEDURE fixCorteCaja
			@Empresa	char(5),
			@CtaDinero	char(10)
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @ID		int,
  @UltimoID	int,
  @MovMoneda	char(10)

  SELECT @ID = MAX(d.ID) 
    FROM Dinero d, MovTipo mt 
   WHERE mt.Modulo = 'DIN' AND mt.Mov = d.Mov AND mt.Clave = 'DIN.C' AND d.Empresa = @Empresa AND d.CtaDinero = @CtaDinero

  SELECT @MovMoneda = Moneda FROM Dinero WHERE ID = @ID

  SELECT @UltimoID = ISNULL(MAX(ID), 0) 
    FROM Dinero d, MovTipo mt 
   WHERE d.ID < @ID AND d.Mov = mt.Mov AND mt.Clave = 'DIN.C' AND d.Estatus = 'CONCLUIDO' AND d.Empresa = @Empresa AND d.CtaDinero = @CtaDinero 

  UPDATE Dinero
     SET Corte = @ID
   WHERE ID > @UltimoID AND (Estatus = 'CONCLUIDO' OR ID = @ID) AND Moneda = @MovMoneda AND Empresa = @Empresa AND CtaDinero = @CtaDinero AND Corte IS NULL

  UPDATE Dinero
     SET CorteDestino = @ID
   WHERE ID > @UltimoID AND (Estatus = 'CONCLUIDO' OR ID = @ID) AND Moneda = @MovMoneda AND Empresa = @Empresa AND CtaDineroDestino = @CtaDinero AND CorteDestino IS NULL
END
GO


/************** fixCompraDescuentoGlobal **************/
if exists (select * from sysobjects where id = object_id('dbo.fixCompraDescuentoGlobal') and type = 'P') drop procedure dbo.fixCompraDescuentoGlobal
GO
CREATE PROCEDURE fixCompraDescuentoGlobal
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @ID			int, 
  @CfgImpInc		bit, 
  @CfgMultiUnidades	bit, 
  @DescuentoGlobal	float

  DECLARE crCompra CURSOR FOR
    SELECT c.ID, cfg.VentaPreciosImpuestoIncluido, cfg2.MultiUnidades, c.DescuentoGlobal
      FROM Compra c, MovTipo mt, EmpresaCfg cfg, EmpresaCfg2 cfg2
     WHERE mt.Modulo = 'COMS' AND mt.Mov = c.Mov AND mt.Clave IN ('COMS.D', 'COMS.B', 'COMS.CA', 'COMS.GX')
       AND NULLIF(c.DescuentoGlobal, 0) IS NOT NULL
       AND cfg.Empresa = c.Empresa AND cfg2.Empresa = c.Empresa
  OPEN crCompra
  FETCH NEXT FROM crCompra INTO @ID, @CfgImpInc, @CfgMultiUnidades, @DescuentoGlobal
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spInvReCalcEncabezado @ID, 'COMS', @CfgImpInc, @CfgMultiUnidades, @DescuentoGlobal
    FETCH NEXT FROM crCompra INTO @ID, @CfgImpInc, @CfgMultiUnidades, @DescuentoGlobal
  END
  CLOSE crCompra
  DEALLOCATE crCompra
END
GO



/************** fixContContacto **************/
if exists (select * from sysobjects where id = object_id('dbo.fixContContacto') and type = 'P') drop procedure dbo.fixContContacto
GO
CREATE PROCEDURE fixContContacto
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @Empresa	char(5),
  @Modulo	char(10),
  @Mov		varchar(20),
  @MovID	varchar(20),
  @ID		int,
  @Moneda	char(10),
  @Contacto	char(10),
  @ContactoTipo	varchar(20),
  @Ok		int

  SELECT @Ok = NULL
  DECLARE crCont CURSOR FOR
    SELECT Empresa, OrigenTipo, Origen, OrigenID
      FROM Cont
     WHERE Estatus = 'CONCLUIDO' AND Contacto IS NULL AND Origen IS NOT NULL AND OrigenID IS NOT NULL
  OPEN crCont
  FETCH NEXT FROM crCont INTO @Empresa, @Modulo, @Mov, @MovID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spMovEnID @Modulo, @Empresa, @Mov, @MovID, @ID OUTPUT, @Moneda OUTPUT, @Ok OUTPUT
      IF @ID IS NOT NULL
      BEGIN
        EXEC spContAutoGetDatos @Modulo, @ID, @Contacto = @Contacto OUTPUT, @ContactoTipo = @ContactoTipo OUTPUT
        UPDATE Cont SET Contacto = @Contacto, ContactoTipo = @ContactoTipo WHERE CURRENT OF crCont
      END
    END
    FETCH NEXT FROM crCont INTO @Empresa, @Modulo, @Mov, @MovID
  END
  CLOSE crCont
  DEALLOCATE crCont
END
GO



/************** fixInvCapaUP **************/
if exists (select * from sysobjects where id = object_id('dbo.fixInvCapaUP') and type = 'P') drop procedure dbo.fixInvCapaUP
GO
CREATE PROCEDURE fixInvCapaUP
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Hoy	datetime

  SELECT @Hoy = GETDATE()
  EXEC spExtraerFecha @Hoy OUTPUT
  DELETE InvCapa WHERE Sistema IN ('U', 'P')

 INSERT InvCapa (
        Sucursal, Sistema,  Empresa, Articulo, SubCuenta, Fecha, Existencia, Costo)
 SELECT Sucursal, 'U',      Empresa, Articulo, SubCuenta, @Hoy,  Existencia, dbo.fnCostoSugeridoCapas(Empresa, Sucursal, Articulo, SubCuenta) 
   FROM ArtSubExistenciaInvCsg
  WHERE ISNULL(Existencia, 0.0) > 0.0

 INSERT InvCapa (
        Sucursal, Sistema,  Empresa, Articulo, SubCuenta, Fecha, Existencia, Costo)
 SELECT Sucursal, 'P',      Empresa, Articulo, SubCuenta, @Hoy,  Existencia, dbo.fnCostoSugeridoCapas(Empresa, Sucursal, Articulo, SubCuenta) 
   FROM ArtSubExistenciaInvCsg
  WHERE ISNULL(Existencia, 0.0) > 0.0
END
GO

/*************** spEliminarSerieLoteSinExistencia *******************/
if exists (select * from sysobjects where id = object_id('dbo.spEliminarSerieLoteSinExistencia') and type = 'P') drop procedure dbo.spEliminarSerieLoteSinExistencia
GO             
CREATE PROCEDURE spEliminarSerieLoteSinExistencia
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @Codigo	varchar(30), 
  @Articulo	varchar(20), 
  @SubCuenta	varchar(50), 
  @SerieLote	varchar(50),
  @Existencia	float

  DECLARE crCB CURSOR FOR
   SELECT Codigo, Cuenta, SubCuenta, SerieLote
     FROM cb
  OPEN crCB
  FETCH NEXT FROM crCB INTO @Codigo, @Articulo, @SubCuenta, @SerieLote
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Existencia = 0.0
      SELECT @Existencia = SUM(ISNULL(Existencia, 0.0)  + ISNULL(ExistenciaAlterna, 0.0) + ISNULL(ExistenciaActivoFijo, 0.0))
        FROM SerieLote
       WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @SerieLote

      IF ROUND(@Existencia, 10) = 0.0
        DELETE CB WHERE CURRENT OF crCB
    END
    FETCH NEXT FROM crCB INTO @Codigo, @Articulo, @SubCuenta, @SerieLote
  END
  CLOSE crCB
  DEALLOCATE crCB

  DELETE SerieLote 
   WHERE ISNULL(ROUND(Existencia, 10), 0.0) = 0.0 AND ISNULL(ROUND(ExistenciaAlterna, 10), 0.0) = 0.0 AND ISNULL(ROUND(ExistenciaActivoFijo, 10), 0.0) = 0.0
END
GO

/************** fixPresupuesto ***************/
if exists (select * from sysobjects where id = object_id('dbo.fixPresupuesto') and type = 'P') drop procedure dbo.fixPresupuesto
GO
CREATE PROCEDURE fixPresupuesto
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5), 
    @Sucursal		int, 
    @UEN		int, 
    @Rama		char(5), 
    @Moneda		char(10), 
    @Tipo		varchar(50), 
    @Cuenta		char(20), 
    @SubCuenta		varchar(50), 
    @Ejercicio		int, 
    @Periodo		int, 
    @Presupuesto	money, 
    @Reservado		money, 
    @Comprometido	money, 
    @Devengado		money, 
    @Ejercido		money

  DECLARE crPresupuesto CURSOR FOR
  SELECT Empresa, Sucursal, UEN, Rama, Moneda, NULLIF(Tipo, ''), Cuenta, NULLIF(SubCuenta, ''), Ejercicio, Periodo, SUM(Presupuesto), SUM(Reservado), SUM(Comprometido), SUM(Devengado), SUM(Ejercido)
    FROM Presupuesto
   GROUP BY Empresa, Sucursal, UEN, Rama, Moneda, NULLIF(Tipo, ''), Cuenta, NULLIF(SubCuenta, ''), Ejercicio, Periodo
   ORDER BY Empresa, Sucursal, UEN, Rama, Moneda, NULLIF(Tipo, ''), Cuenta, NULLIF(SubCuenta, ''), Ejercicio, Periodo

  OPEN crPresupuesto
  FETCH NEXT FROM crPresupuesto INTO @Empresa, @Sucursal, @UEN, @Rama, @Moneda, @Tipo, @Cuenta, @SubCuenta, @Ejercicio, @Periodo, @Presupuesto, @Reservado, @Comprometido, @Devengado, @Ejercido
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      DELETE Presupuesto WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND UEN = @UEN AND Rama = @Rama AND Moneda = @Moneda AND ISNULL(Tipo, '') = ISNULL(@Tipo, '') AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Ejercicio = @Ejercicio AND Periodo = @Periodo
      INSERT Presupuesto (Empresa,  Sucursal,  UEN,  Rama,  Moneda,  Tipo,  Cuenta,  SubCuenta,  Ejercicio,  Periodo,  Presupuesto,  Reservado,  Comprometido,  Devengado,  Ejercido) 
                  VALUES (@Empresa, @Sucursal, @UEN, @Rama, @Moneda, @Tipo, @Cuenta, @SubCuenta, @Ejercicio, @Periodo, @Presupuesto, @Reservado, @Comprometido, @Devengado, @Ejercido)
    END
    FETCH NEXT FROM crPresupuesto INTO @Empresa, @Sucursal, @UEN, @Rama, @Moneda, @Tipo, @Cuenta, @SubCuenta, @Ejercicio, @Periodo, @Presupuesto, @Reservado, @Comprometido, @Devengado, @Ejercido
  END  -- While
  CLOSE crPresupuesto
  DEALLOCATE crPresupuesto

  RETURN
END
GO


/************** fixPersonalEmpresa ***************/
if exists (select * from sysobjects where id = object_id('dbo.fixPersonalEmpresa') and type = 'P') drop procedure dbo.fixPersonalEmpresa
GO
/*CREATE PROCEDURE fixPersonalEmpresa
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
     @Personal	varchar(10),
     @Empresa	varchar(5)

  DECLARE crPersonal CURSOR FOR
  SELECT Personal
    FROM Personal

  OPEN crPersonal
  FETCH NEXT FROM crPersonal INTO @Personal
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Empresa = NULL
      SELECT @Empresa = MIN(n.Empresa) 
        FROM NominaPersonal d 
        JOIN Nomina n ON n.ID = d.ID AND n.Estatus = 'CONCLUIDO'
       WHERE d.Personal = @Personal AND n.ID = (SELECT MAX(n2.ID) FROM Nomina n2 JOIN NominaPersonal d2 ON d2.ID = n2.ID WHERE d2.Personal = @Personal AND Estatus = 'CONCLUIDO')

      UPDATE Personal SET Empresa = @Empresa WHERE CURRENT OF crPersonal
    END
    FETCH NEXT FROM crPersonal INTO @Personal
  END  -- While
  CLOSE crPersonal
  DEALLOCATE crPersonal
  RETURN
END*/
GO
CREATE PROCEDURE fixPersonalEmpresa
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
     @Personal	varchar(10)

  BEGIN TRANSACTION

  ALTER TABLE Personal DISABLE TRIGGER ALL
  UPDATE Personal
     SET Empresa = n.Empresa
    FROM Personal p
    JOIN NominaPersonal d ON d.Personal = p.Personal
    JOIN Nomina n ON n.ID = d.ID AND n.Estatus = 'CONCLUIDO'
   WHERE n.ID = (SELECT MAX(n2.ID) FROM Nomina n2 JOIN NominaPersonal d2 ON d2.ID = n2.ID WHERE d2.Personal = p.Personal AND Estatus = 'CONCLUIDO')

  ALTER TABLE Personal ENABLE TRIGGER ALL
  COMMIT TRANSACTION
  RETURN
END
GO



if (select version from version) <= 2924
  EXEC fixPersonalEmpresa
GO



/************** fixVarchar ***************/
--if exists (select * from sysobjects where id = object_id('dbo.fixVarchar') and type = 'P') drop procedure dbo.fixVarchar
GO
/*CREATE PROCEDURE fixVarchar
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla	sysname,
    @Campo	sysname,
    @Tamano	int,
    @Extras	varchar(255)

  DECLARE crTabla CURSOR LOCAL FOR
   SELECT Name
     FROM sysobjects where type = 'U'
    ORDER BY Name
  OPEN crTabla
  FETCH NEXT FROM crTabla INTO @Tabla
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      DECLARE crCampo CURSOR LOCAL FOR
       SELECT Campo, Tamano
         FROM SysTipoDatos
        WHERE Tabla = @Tabla AND TipoDatos = 'char' AND Tamano >= 5
        ORDER BY Campo
      OPEN crCampo
      FETCH NEXT FROM crCampo INTO @Campo, @Tamano
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @Extras = 'varchar('+CONVERT(varchar, @Tamano)+') NULL'
          EXEC spALTER_COLUMN @Tabla, @Campo, @Extras
        END
        FETCH NEXT FROM crCampo INTO @Campo, @Tamano
      END
      CLOSE crCampo
      DEALLOCATE crCampo
    END
    FETCH NEXT FROM crTabla INTO @Tabla
  END
  CLOSE crTabla
  DEALLOCATE crTabla

  RETURN
END*/
GO



IF (SELECT Version FROM Version)<=3096
BEGIN
  UPDATE MovTipoContAuto SET Debe  = 'Base G Total' WHERE Debe  = 'Base' AND Modulo = 'FIS'
  UPDATE MovTipoContAuto SET Haber = 'Base G Total' WHERE Haber = 'Base' AND Modulo = 'FIS'

  UPDATE MovTipoContAuto SET Debe  = 'Base G Ded/Acum' WHERE Debe  = 'Base Deducible' AND Modulo = 'FIS'
  UPDATE MovTipoContAuto SET Haber = 'Base G Ded/Acum' WHERE Haber = 'Base Deducible' AND Modulo = 'FIS'

  UPDATE MovTipoContAuto SET Debe  = 'Base G No Ded/Acum' WHERE Debe  = 'Base No Deducible' AND Modulo = 'FIS'
  UPDATE MovTipoContAuto SET Haber = 'Base G No Ded/Acum' WHERE Haber = 'Base No Deducible' AND Modulo = 'FIS'

  UPDATE MovTipoContAuto SET Debe  = 'Impuesto Ded/Acum' WHERE Debe  = 'Neto Deducible' AND Modulo = 'FIS'
  UPDATE MovTipoContAuto SET Haber = 'Impuesto Ded/Acum' WHERE Haber = 'Neto Deducible' AND Modulo = 'FIS'

  UPDATE MovTipoContAuto SET Debe  = 'Impuesto No Ded/Acum' WHERE Debe  = 'Neto No Deducible' AND Modulo = 'FIS'
  UPDATE MovTipoContAuto SET Haber = 'Impuesto No Ded/Acum' WHERE Haber = 'Neto No Deducible' AND Modulo = 'FIS'
  UPDATE MovTipo SET AfectarFiscal = 'Ingreso/Egreso' WHERE AfectarFiscal = 'Conciliacion'
END
GO
