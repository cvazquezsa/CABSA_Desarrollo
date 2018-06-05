/* SP INVENTARIOS     */
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO 


-- ArtTipo = 'NORMAL','SERIE', 'LOTE','VIN','PARTIDA', 'JUEGO', 'SERVICIO',

-- INV.E   = Entrada
-- INV.OI  = Orden Traspaso
-- INV.EI  = Entrada Traspaso
-- INV.S   = Salida 
-- INV.TI  = Transito
-- INV.DTI = Devolucion Transito
-- INV.TIF = Transito Faltante
-- INV.TIS = Transito Sobrante
-- INV.SI  = Salida Intercambio
-- INV.SOL = Solicitud
-- INV.OT  = Orden Transferencia
-- INV.P   = Prestamo
-- INV.R   = Recibo Prestamo
-- INV.T   = Transferencia
-- INV.TC  = Transferencia Costo
-- INV.TG  = Transferencia Consig
-- INV.A   = Ajuste
-- INV.IF  = Inventario Fisico
-- INV.CP  = Cambio Presentacion
-- INV.SM  = Orden Consumo
-- INV.CM  = Consumo Material

-- VTAS.C  = Cotizacion
-- VTAS.P  = Pedido
-- VTAS.S  = Servicio
-- VTAS.R  = Remision (Anterior)
-- VTAS.F  = Factura
-- VTAS.FB = Factura Broker
-- VTAS.EG = Entrega Garantia
-- VTAS.SG = Salida Garantia
-- VTAS.D  = Devolucion Venta
-- VTAS.DR = Devolucion Remision
-- VTAS.B  = Bonificacion Venta
-- VTAS.VC = Venta Consignacion
-- VTAS.VCR= Remision
-- VTAS.DCR= Devolucion Remision
-- VTAS.DC = Dev. Consignacion
-- VTAS.N  = Nota
-- VTAS.FM = Factura Mostrador
-- VTAS.CO = Contrato
-- VTAS.VP = Venta Perdida

-- COMS.R  = Requisicion
-- COMS.C  = Cotizacion
-- COMS.O  = Orden Compra
-- COMS.F  = Entrada Compra
-- COMS.FL = Compra Local
-- COMS.EG = Entrada con Gastos
-- COMS.D  = Devolucion Compra
-- COMS.B  = Bonificacion Compra
-- COMS.CA = Gasto Diverso
-- COMS.CC = Compra Consignacion
-- COMS.DC = Dev. Consignacion
-- COMS.OG = Orden Garantia
-- COMS.OD = Orden Devolucion
-- COMS.IG = Intercambio Garantia
-- COMS.DG = Devolucion Garantia
-- COMS.CP = Compra Perdida

-- PROD.O = Orden Produccion
-- PROD.A = Avance
-- PROD.R = Retroceso
-- PROD.E = Entrada Produccion


/**************** spInvPedidoProrrateadoAfectar ****************/
if exists (SELECT * FROM sysobjects WHERE id = object_id('dbo.spInvPedidoProrrateadoAfectar') AND sysstat & 0xf = 4) DROP PROCEDURE dbo.spInvPedidoProrrateadoAfectar
GO
CREATE PROCEDURE spInvPedidoProrrateadoAfectar
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
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE @Articulo		varchar(20),
	  @EmpresaProrrateo	varchar(7),
	  @SucursalProrrateo	int,
	  @CCProrrateo		varchar(20),
	  @CC2Prorrateo		varchar(20),
	  @CC3Prorrateo		varchar(20),
          @EspacioProrrateo	varchar(10),
	  @VINProrrateo		varchar(20),
	  @ProyectoProrrateo	varchar(50),
	  @UENProrrateo		int,
	  @ActividadProrrateo	varchar(100),
	  @Porcentaje		float,
	  @Renglon		int,
	  @RenglonID		int,
	  @NuevoID		int,
	  @Importe		money,
	  @Impuestos		money,
	  @SubMovTipo		varchar(20),
          @Concepto		varchar(50),
          @Proyecto		varchar(50),
	  @Actividad		varchar(20),
	  @UEN			int,
	  @Moneda		varchar(10),
	  @TipoCambio		float,
	  @Cliente		varchar(10),
	  @EnviarA		int,
	  @Almacen		varchar(10),
	  @Agente		varchar(10),
	  @AgenteServicio	varchar(10),
	  @AgenteComision	float,
	  @Formaenvio		varchar(50),
	  @OrigenTipo		varchar(10),
	  @Origen		varchar(20),
	  @OrigenID		varchar(20),
          @MovNuevo		varchar(20),
          @MovIDNuevo           varchar(20),
	  @OMov			varchar(20),
	  @DMov			varchar(20),
	  @DModulo		varchar(5),
	  @OModulo		varchar(5),
	  @OMovID		varchar(20),
	  @DMovID		varchar(20), 
	  @OID			int,
	  @DID			int,
          @TipoArt		varchar(20),
	  @RenglonTipo		char(1)
  DECLARE
	  @TmpProrrateo		table 
          (EmpresaProrrateo	varchar(7), 
	   SucursalProrrateo	int, 
	   CCProrrateo		varchar(20), 
	   CC2Prorrateo		varchar(20), 
	   CC3Prorrateo		varchar(20), 
	   EspacioProrrateo	varchar(10), 
	   VINProrrateo		varchar(20), 
	   ProyectoProrrateo	varchar(50), 
	   UENProrrateo		int, 
	   ActividadProrrateo	varchar(100))

  SELECT @MovTipo = mt.Clave,
         @SubMovTipo = mt.SubClave,
         @FechaEmision = v.FechaEmision,
         @Concepto = v.Concepto,
         @Proyecto = v.Proyecto,
         @Actividad = v.Actividad,
         @UEN = v.UEN,
         @Moneda = v.Moneda,
         @TipoCambio = v.TipoCambio,
         @Cliente = v.Cliente,
         @EnviarA = v.EnviarA,
         @Almacen = v.Almacen,
         @Agente = v.Agente,
         @AgenteServicio = v.Agenteservicio,
         @AgenteComision = v.Agentecomision,
         @FormaEnvio = v.FormaEnvio,
         @OrigenTipo = v.OrigenTipo,
         @Origen = v.Origen,
         @OrigenID = v.OrigenID    
    FROM Venta v 
    JOIN MovTipo mt 
      ON mt.Mov = v.Mov 
     AND mt.Modulo =  @Modulo 
     AND v.ID = @ID	
      
  IF @Modulo = 'VTAS' AND @MovTipo = 'VTAS.P' AND @SubMovTipo = 'VTAS.PPR' AND  @OK IS NULL
  BEGIN
    IF @Accion = 'RESERVARPARCIAL' AND @Estatus = 'SINAFECTAR' 
    BEGIN
      SELECT @MovNuevo = VentaPedidoEstadistico FROM EmpresaCfgMovVenta WHERE Empresa = @Empresa

      INSERT INTO @TmpProrrateo
      SELECT a.EmpresaProrrateo, a.SucursalProrrateo, a.CCProrrateo, a.CC2Prorrateo, a.CC3Prorrateo, a.EspacioProrrateo, a.VINProrrateo, a.ProyectoProrrateo, a.UENProrrateo, a.ActividadProrrateo
        FROM ArtProrrateo a
        JOIN VentaD v ON v.Articulo = a.Art 
       WHERE v.ID = @ID
       GROUP BY a.EmpresaProrrateo, a.SucursalProrrateo, a.CCProrrateo, a.CC2Prorrateo, a.CC3Prorrateo, a.EspacioProrrateo, a.VINProrrateo, a.ProyectoProrrateo, a.UENProrrateo, a.ActividadProrrateo

      DECLARE crVenta CURSOR FOR
       SELECT EmpresaProrrateo, SucursalProrrateo, CCProrrateo, CC2Prorrateo, CC3Prorrateo,
              EspacioProrrateo, VINProrrateo, ProyectoProrrateo, UENProrrateo, ActividadProrrateo
         FROM @TmpProrrateo

      OPEN crVenta
      FETCH NEXT FROM crVenta INTO @EmpresaProrrateo,@SucursalProrrateo,@CCProrrateo,@CC2Prorrateo,@CC3Prorrateo,@EspacioProrrateo,
			   @VINProrrateo,@ProyectoProrrateo,@UENProrrateo,@ActividadProrrateo
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        INSERT INTO Venta(
               Empresa,                           Mov,       FechaEmision, UltimoCambio, Proyecto,                            Actividad,                             UEN,                       Moneda, TipoCambio, Usuario, Estatus,      Directo, Prioridad, RenglonID, Codigo, Cliente, EnviarA, Almacen, FechaRequerida, Vencimiento, Sucursal,                   ContUso,                      ContUso2,                       ContUso3,                       Espacio)
        SELECT isnull(@EmpresaProrrateo,Empresa), @MovNuevo, FechaEmision, UltimoCambio, isnull(@ProyectoProrrateo,Proyecto), isnull(@ActividadProrrateo,Actividad), isnull(@UENProrrateo,UEN), Moneda, TipoCambio, Usuario, 'SINAFECTAR', Directo, Prioridad, RenglonID, Codigo, Cliente, EnviarA, Almacen, FechaRequerida, Vencimiento, isnull(@Sucursal,Sucursal), isnull(@CCProrrateo,ContUso), isnull(@CC2Prorrateo,ContUso2), isnull(@CC3Prorrateo,ContUso3), isnull(@EspacioProrrateo,Espacio)
          FROM Venta 
         WHERE ID = @ID
        IF @@ERROR <> 0 SET @OK = 1

        SET @NuevoID = SCOPE_IDENTITY()

        IF @OK IS NULL
        BEGIN 
          SET @Renglon = 2048
          SET @RenglonID = 1

          DECLARE crVentaD CURSOR FOR
           SELECT a.Art, a.Porcentaje
            FROM Artprorrateo a
            JOIN Ventad v ON v.Articulo = a.Art
           WHERE v.ID = @ID
             AND ISNULL(a.EmpresaProrrateo,'') = ISNULL(@EmpresaProrrateo,'')
             AND ISNULL(a.SucursalProrrateo,'') = ISNULL(@SucursalProrrateo,'')
             AND ISNULL(a.CCProrrateo,'') = ISNULL(@CCProrrateo,'')
             AND ISNULL(a.CC2Prorrateo,'') = ISNULL(@CC2Prorrateo,'')
             AND ISNULL(a.CC3Prorrateo,'') = ISNULL(@CC3Prorrateo,'')
             AND ISNULL(a.EspacioProrrateo,'') = ISNULL(@EspacioProrrateo,'')
             AND ISNULL(a.VINProrrateo,'') = ISNULL(@VINProrrateo,'')
             AND ISNULL(a.ProyectoProrrateo,'') = ISNULL(@ProyectoProrrateo,'')
             AND ISNULL(a.UENProrrateo,'') = ISNULL(@UENProrrateo,'')
             AND ISNULL(a.ActividadProrrateo,'') = ISNULL(@ActividadProrrateo,'')
           GROUP BY a.Art, a.Porcentaje

          OPEN crVentaD
          FETCH NEXT FROM crVentaD INTO @Articulo, @Porcentaje
          WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
          BEGIN
            SELECT @TipoArt = Tipo FROM Art WHERE Articulo = @Articulo

            EXEC spRenglonTipo @TipoArt, NULL, @RenglonTipo OUTPUT

            INSERT INTO VentaD (ID,       Renglon,  RenglonID,  RenglonTipo, Cantidad,   Almacen,   EnviarA,   Articulo,  Precio,                    PrecioSugerido,   Impuesto1,   Impuesto2,   Impuesto3,   Costo,   Contuso,      ContUso2,      ContUso3,      Factor,   FechaRequerida,   Sucursal,           UEN,           Espacio,           PrecioMoneda,   PrecioTipoCambio)
                         SELECT @NuevoID, @Renglon, @RenglonID, @RenglonTipo, v.Cantidad, v.Almacen, v.EnviarA, @Articulo, v.Precio*@Porcentaje/100, v.PrecioSugerido, v.Impuesto1, v.Impuesto2, v.Impuesto3, v.Costo, @CCProrrateo, @CC2Prorrateo, @CC2Prorrateo, v.Factor, v.FechaRequerida, @SucursalProrrateo, @UENProrrateo, @EspacioProrrateo, v.PrecioMoneda, v.PrecioTipoCambio           
              FROM VentaD v
             WHERE v.ID = @ID
               AND v.Articulo = @Articulo

              IF @@ERROR <> 0 SET @Ok = 1	
              SET @Renglon = @Renglon + 2048
              SET @RenglonID = @RenglonID + 1
              FETCH NEXT FROM crVentaD INTO @Articulo, @Porcentaje
          END
          CLOSE crVentaD
          DEALLOCATE crVentaD
        END
        IF @OK IS NULL
        BEGIN
          SELECT @Importe = sum((Precio * Cantidad * Factor)* (1 - (ISNULL(DescuentoLinea,0.0)/100))),
                 @Impuestos = sum((Precio * Cantidad * Factor)* (1 - (ISNULL(DescuentoLinea,0.0)/100))*Impuesto1/100)
            FROM VentaD
           WHERE ID = @NuevoID
  
          UPDATE VENTA SET
                 Importe = @Importe,
                 Impuestos = @Impuestos
           WHERE ID = @NuevoID
	   IF @@ERROR <> 0 SET @Ok = 1
        END
        
        IF @@ERROR <> 0 SET @OK = 1
    
        IF @OK IS NULL
        BEGIN
          EXEC spAfectar @Modulo= @Modulo, @ID=@NuevoID, @Accion='AFECTAR', @Base='Todo',@GenerarMov=NULL,@Usuario=@Usuario , @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
          IF @@ERROR <> 0 SET @OK = 1
          IF @OK IS NULL
          BEGIN
            SELECT @MovIDNuevo = MovID FROM Venta WHERE ID = @NuevoID

            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @NuevoID, @MovNuevo, @MovIDNuevo, @Ok OUTPUT
            IF @@ERROR <> 0 SET @OK = 1
          END
        END  

        FETCH NEXT FROM crVenta INTO @EmpresaProrrateo, @SucursalProrrateo, @CCProrrateo, @CC2Prorrateo, @CC3Prorrateo, @EspacioProrrateo, @VINProrrateo, @ProyectoProrrateo, @UENProrrateo, @ActividadProrrateo 
      END
      CLOSE crVenta
      DEALLOCATE crVenta
    END  ELSE
    IF @Accion = 'CANCELAR'  AND @Estatus = 'PENDIENTE' AND @OK IS NULL
    BEGIN
      DECLARE crCancelarVenta CURSOR FOR
      SELECT OModulo, OMov, OMovID, DModulo, DID, DMov, DMovID
        FROM MovFlujo
       WHERE OID = @ID AND DModulo = @Modulo
      OPEN crCancelarVenta
      FETCH NEXT FROM crCancelarVenta INTO @OModulo, @OMov, @OMovID, @DModulo, @DID, @DMov, @DMovID
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        EXEC spAfectar @Modulo, @DID, @Accion,'TODO', NULL ,@Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, @Conexion = 1
          IF @@ERROR <> 0 SET @OK = 1
          IF @OK IS NULL
          BEGIN
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @DModulo, @DID, @DMov, @DMovID, @OModulo, @ID, @OMov, @OMovID, @Ok OUTPUT
            IF @@ERROR <> 0 SET @OK = 1
          END
	FETCH NEXT FROM crCancelarVenta INTO @OModulo, @OMov, @OMovID, @DModulo, @DID, @DMov, @DMovID
      END
      CLOSE crCancelarVenta
      DEALLOCATE crCancelarVenta
    END
  END
END
GO

/**************** spInvFacturaProrrateadaAfectar ****************/
if exists (SELECT * FROM sysobjects WHERE id = object_id('dbo.spInvFacturaProrrateadaAfectar') AND sysstat & 0xf = 4) DROP PROCEDURE dbo.spInvFacturaProrrateadaAfectar
GO
CREATE PROCEDURE spInvFacturaProrrateadaAfectar
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
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE @Articulo		varchar(20),
	  @EmpresaProrrateo	varchar(7),
	  @SucursalProrrateo	int,
	  @CCProrrateo		varchar(20),
	  @CC2Prorrateo		varchar(20),
	  @CC3Prorrateo		varchar(20),
          @EspacioProrrateo	varchar(10),
	  @VINProrrateo		varchar(20),
	  @ProyectoProrrateo	varchar(50),
	  @UENProrrateo		int,
	  @ActividadProrrateo	varchar(100),
	  @Porcentaje		float,
	  @Renglon		int,
	  @RenglonID		int,
	  @NuevoID		int,
	  @Importe		money,
	  @Impuestos		money,
	  @SubMovTipo		varchar(20),
          @Concepto		varchar(50),
          @Proyecto		varchar(50),
	  @Actividad		varchar(20),
	  @UEN			int,
	  @Moneda		varchar(10),
	  @TipoCambio		float,
	  @Cliente		varchar(10),
	  @EnviarA		int,
	  @Almacen		varchar(10),
	  @Agente		varchar(10),
	  @AgenteServicio	varchar(10),
	  @AgenteComision	float,
	  @Formaenvio		varchar(50),
	  @OrigenTipo		varchar(10),
	  @Origen		varchar(20),
	  @OrigenID		varchar(20),
          @MovNuevo		varchar(20),
          @MovIDNuevo           varchar(20),
	  @OMov			varchar(20),
	  @DMov			varchar(20),
	  @DModulo		varchar(5),
	  @OModulo		varchar(5),
	  @OMovID		varchar(20),
	  @DMovID		varchar(20), 
	  @OID			int,
	  @DID			int,
          @TipoArt		varchar(20),
	  @RenglonTipo		char(1)
  DECLARE
	  @TmpProrrateo		table 
          (EmpresaProrrateo	varchar(7), 
	   SucursalProrrateo	int, 
	   CCProrrateo		varchar(20), 
	   CC2Prorrateo		varchar(20), 
	   CC3Prorrateo		varchar(20), 
	   EspacioProrrateo	varchar(10), 
	   VINProrrateo		varchar(20), 
	   ProyectoProrrateo	varchar(50), 
	   UENProrrateo		int, 
	   ActividadProrrateo	varchar(100))

  SELECT @MovTipo = mt.Clave,
         @SubMovTipo = mt.SubClave,
         @FechaEmision = v.FechaEmision,
         @Concepto = v.Concepto,
         @Proyecto = v.Proyecto,
         @Actividad = v.Actividad,
         @UEN = v.UEN,
         @Moneda = v.Moneda,
         @TipoCambio = v.TipoCambio,
         @Cliente = v.Cliente,
         @EnviarA = v.EnviarA,
         @Almacen = v.Almacen,
         @Agente = v.Agente,
         @AgenteServicio = v.Agenteservicio,
         @AgenteComision = v.Agentecomision,
         @FormaEnvio = v.FormaEnvio,
         @OrigenTipo = v.OrigenTipo,
         @Origen = v.Origen,
         @OrigenID = v.OrigenID    
    FROM Venta v 
    JOIN MovTipo mt 
      ON mt.Mov = v.Mov 
     AND mt.Modulo =  @Modulo 
     AND v.ID = @ID

  IF @Modulo = 'VTAS' AND @MovTipo = 'VTAS.F' AND @SubMovTipo = 'VTAS.FPR' AND  @OK IS NULL
  BEGIN
    IF @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR' 
    BEGIN

      SELECT @MovNuevo = VentaEstadistica FROM EmpresaCfgMovVenta WHERE Empresa = @Empresa

      INSERT INTO @TmpProrrateo
      SELECT a.EmpresaProrrateo, a.SucursalProrrateo, a.CCProrrateo, a.CC2Prorrateo, a.CC3Prorrateo, a.EspacioProrrateo, a.VINProrrateo, a.ProyectoProrrateo, a.UENProrrateo, a.ActividadProrrateo
        FROM ArtProrrateo a
        JOIN VentaD v ON v.Articulo = a.Art 
       WHERE v.ID = @ID
       GROUP BY a.EmpresaProrrateo, a.SucursalProrrateo, a.CCProrrateo, a.CC2Prorrateo, a.CC3Prorrateo, a.EspacioProrrateo, a.VINProrrateo, a.ProyectoProrrateo, a.UENProrrateo, a.ActividadProrrateo

      DECLARE crVenta CURSOR FOR
       SELECT EmpresaProrrateo, SucursalProrrateo, CCProrrateo, CC2Prorrateo, CC3Prorrateo,
              EspacioProrrateo, VINProrrateo, ProyectoProrrateo, UENProrrateo, ActividadProrrateo
         FROM @TmpProrrateo

      OPEN crVenta
      FETCH NEXT FROM crVenta INTO @EmpresaProrrateo,@SucursalProrrateo,@CCProrrateo,@CC2Prorrateo,@CC3Prorrateo,@EspacioProrrateo,
			   @VINProrrateo,@ProyectoProrrateo,@UENProrrateo,@ActividadProrrateo
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        INSERT INTO Venta(
               Empresa,                           Mov,       FechaEmision, UltimoCambio, Proyecto,                            Actividad,                             UEN,                       Moneda, TipoCambio, Usuario, Estatus,      Directo, Prioridad, RenglonID, Codigo, Cliente, EnviarA, Almacen, FechaRequerida, Vencimiento, Sucursal,                   ContUso,                      ContUso2,                       ContUso3,                       Espacio)
        SELECT isnull(@EmpresaProrrateo,Empresa), @MovNuevo, FechaEmision, UltimoCambio, isnull(@ProyectoProrrateo,Proyecto), isnull(@ActividadProrrateo,Actividad), isnull(@UENProrrateo,UEN), Moneda, TipoCambio, Usuario, 'SINAFECTAR', Directo, Prioridad, RenglonID, Codigo, Cliente, EnviarA, Almacen, FechaRequerida, Vencimiento, isnull(@Sucursal,Sucursal), isnull(@CCProrrateo,ContUso), isnull(@CC2Prorrateo,ContUso2), isnull(@CC3Prorrateo,ContUso3), isnull(@EspacioProrrateo,Espacio)
          FROM Venta 
         WHERE ID = @ID
        IF @@ERROR <> 0 SET @OK = 1

        SET @NuevoID = SCOPE_IDENTITY()

        IF @OK IS NULL
        BEGIN 
          SET @Renglon = 2048
          SET @RenglonID = 1

          DECLARE crVentaD CURSOR FOR
           SELECT a.Art, a.Porcentaje
            FROM Artprorrateo a
            JOIN Ventad v ON v.Articulo = a.Art
           WHERE v.ID = @ID
             AND ISNULL(a.EmpresaProrrateo,'') = ISNULL(@EmpresaProrrateo,'')
             AND ISNULL(a.SucursalProrrateo,'') = ISNULL(@SucursalProrrateo,'')
             AND ISNULL(a.CCProrrateo,'') = ISNULL(@CCProrrateo,'')
             AND ISNULL(a.CC2Prorrateo,'') = ISNULL(@CC2Prorrateo,'')
             AND ISNULL(a.CC3Prorrateo,'') = ISNULL(@CC3Prorrateo,'')
             AND ISNULL(a.EspacioProrrateo,'') = ISNULL(@EspacioProrrateo,'')
             AND ISNULL(a.VINProrrateo,'') = ISNULL(@VINProrrateo,'')
             AND ISNULL(a.ProyectoProrrateo,'') = ISNULL(@ProyectoProrrateo,'')
             AND ISNULL(a.UENProrrateo,'') = ISNULL(@UENProrrateo,'')
             AND ISNULL(a.ActividadProrrateo,'') = ISNULL(@ActividadProrrateo,'')
           GROUP BY a.Art, a.Porcentaje

          OPEN crVentaD
          FETCH NEXT FROM crVentaD INTO @Articulo, @Porcentaje
          WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
          BEGIN
            SELECT @TipoArt = Tipo FROM Art WHERE Articulo = @Articulo

            EXEC spRenglonTipo @TipoArt, NULL, @RenglonTipo OUTPUT

            INSERT INTO VentaD (ID,       Renglon,  RenglonID,  RenglonTipo, Cantidad,   Almacen,   EnviarA,   Articulo,  Precio,                    PrecioSugerido,   Impuesto1,   Impuesto2,   Impuesto3,   Costo,   Contuso,      ContUso2,      ContUso3,      Factor,   FechaRequerida,   Sucursal,           UEN,           Espacio,           PrecioMoneda,   PrecioTipoCambio)
                         SELECT @NuevoID, @Renglon, @RenglonID, @RenglonTipo, v.Cantidad, v.Almacen, v.EnviarA, @Articulo, v.Precio*@Porcentaje/100, v.PrecioSugerido, v.Impuesto1, v.Impuesto2, v.Impuesto3, v.Costo, @CCProrrateo, @CC2Prorrateo, @CC2Prorrateo, v.Factor, v.FechaRequerida, @SucursalProrrateo, @UENProrrateo, @EspacioProrrateo, v.PrecioMoneda, v.PrecioTipoCambio           
              FROM VentaD v
             WHERE v.ID = @ID
               AND v.Articulo = @Articulo

              IF @@ERROR <> 0 SET @Ok = 1	
              SET @Renglon = @Renglon + 2048
              SET @RenglonID = @RenglonID + 1

              FETCH NEXT FROM crVentaD INTO @Articulo, @Porcentaje
          END
          CLOSE crVentaD
          DEALLOCATE crVentaD
        END
        IF @OK IS NULL
        BEGIN
          SELECT @Importe = sum((Precio * Cantidad * Factor)* (1 - (ISNULL(DescuentoLinea,0.0)/100))),
                 @Impuestos = sum((Precio * Cantidad * Factor)* (1 - (ISNULL(DescuentoLinea,0.0)/100))*Impuesto1/100)
            FROM VentaD
           WHERE ID = @NuevoID
  
          UPDATE VENTA SET
                 Importe = @Importe,
                 Impuestos = @Impuestos
           WHERE ID = @NuevoID
	   IF @@ERROR <> 0 SET @Ok = 1
        END--8
        
        IF @@ERROR <> 0 SET @OK = 1
    
        IF @OK IS NULL
        BEGIN
          EXEC spAfectar @Modulo= @Modulo, @ID=@NuevoID, @Accion=@Accion,@Base='Todo',@GenerarMov= NULL,@Usuario=@Usuario , @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
          IF @@ERROR <> 0 SET @OK = 1
          IF @OK IS NULL
          BEGIN
            SELECT @MovIDNuevo = MovID FROM Venta WHERE ID = @NuevoID

            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @NuevoID, @MovNuevo, @MovIDNuevo, @Ok OUTPUT
            IF @@ERROR <> 0 SET @OK = 1
          END
        END  

        FETCH NEXT FROM crVenta INTO @EmpresaProrrateo, @SucursalProrrateo, @CCProrrateo, @CC2Prorrateo, @CC3Prorrateo, @EspacioProrrateo, @VINProrrateo, @ProyectoProrrateo, @UENProrrateo, @ActividadProrrateo 
      END
      CLOSE crVenta
      DEALLOCATE crVenta
    END  ELSE
    IF @Accion = 'CANCELAR'  AND @Estatus = 'CONCLUIDO' AND @OK IS NULL
    BEGIN--11
      DECLARE crCancelarVenta CURSOR FOR
      SELECT OModulo, OMov, OMovID, DModulo, DID, DMov, DMovID
        FROM MovFlujo
       WHERE OID = @ID AND DModulo = @Modulo
      OPEN crCancelarVenta
      FETCH NEXT FROM crCancelarVenta INTO @OModulo, @OMov, @OMovID, @DModulo, @DID, @DMov, @DMovID
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN--12
        EXEC spAfectar @Modulo, @DID, @Accion,'TODO', NULL ,@Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, @Conexion = 1
          IF @@ERROR <> 0 SET @OK = 1
          IF @OK IS NULL
          BEGIN
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @DModulo, @DID, @DMov, @DMovID, @OModulo, @ID, @OMov, @OMovID, @Ok OUTPUT
            IF @@ERROR <> 0 SET @OK = 1
          END
	FETCH NEXT FROM crCancelarVenta INTO @OModulo, @OMov, @OMovID, @DModulo, @DID, @DMov, @DMovID
      END
      CLOSE crCancelarVenta
      DEALLOCATE crCancelarVenta
    END
  END
END
GO

/**************** spGTInvAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGTInvAfectar') and sysstat & 0xf = 4) drop procedure dbo.spGTInvAfectar
GO             
CREATE PROCEDURE spGTInvAfectar
		@ID                	int,
		@Accion			char(20),
		@Base			char(20),
		@Empresa	      	char(5),
		@Usuario		char(10),
		@Modulo	      		char(5),
		@Mov	  	      	char(20),
		@MovID             	varchar(20),
		@MovTipo     		char(20),
		@MovMoneda	      	char(10),
		@MovTipoCambio		float,
		@Estatus		char(15),
		@EstatusNuevo		char(15),
		@FechaEmision		datetime,
		@FechaRegistro		datetime,
		@FechaAfectacion	datetime,
		@Conexion		bit,
		@SincroFinal		bit,
		@Sucursal		int,
		@UtilizarID		int,
		@UtilizarMovTipo	char(20),
		@IDGenerar		int,
		@Ok			int		OUTPUT,
		@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN

  DECLARE
	@IDCursor		int,
	@Clave			varchar(20),
	@SubClave		varchar(20),
	@OID			int,
	@OMov			varchar(20),
	@OMovID			varchar(20),
	@ImporteAplicar		money,	
	@MovDestino		varchar(20),
	@MovDestinoID		varchar(20)

  SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo
  IF @Accion = 'GENERAR' AND @Modulo = 'VTAS' AND @SubClave = 'VTAS.FA'
  BEGIN 
    UPDATE VentaD SET Aplica = NULL, AplicaID = NULL WHERE ID = @IDGenerar
    IF @@ERROR <> 0 SET @Ok = 1 
  END

  IF @Accion = 'GENERAR' AND @Modulo = 'VTAS' AND @MovTipo = 'VTAS.F'
  BEGIN
    SELECT @OMov = Origen, @OMovID = OrigenID FROM Venta WHERE ID = @ID
    SELECT @OID = ID FROM Venta WHERE Empresa = @Empresa AND Mov = @OMov AND MovID = @OMovID
    SELECT @Clave = Clave FROM MovTipo WHERE Mov = @OMov AND Modulo = 'VTAS'

    IF @Clave = 'VTAS.VCR'
    BEGIN
        DECLARE crAnticiposFacturados  CURSOR FOR
          SELECT 
            mf.DID
          FROM 
          MovFlujo mf 
          JOIN MovTipo mt ON mt.Mov = mf.DMov 
            AND mt.Modulo = 'VTAS' 
            AND mt.Clave = 'VTAS.F' 
            AND mt.SubClave = 'VTAS.FA'
          WHERE mf.OID = (SELECT OID FROM MovFlujo WHERE DID = @OID AND DModulo = 'VTAS')
        OPEN crAnticiposFacturados
        FETCH NEXT FROM crAnticiposFacturados INTO @IDcursor
        WHILE @@FETCH_STATUS <> -1
        BEGIN
        IF @@FETCH_STATUS <> -2
          BEGIN
            SELECT @MovDestino = Mov, @MovDestinoID = MovID, @ImporteAplicar = ISNULL(Importe, 0) + ISNULL(Impuestos, 0) FROM Venta WHERE ID = @IDCursor
            UPDATE Cxc SET AnticipoAplicar = @ImporteAplicar, AnticipoAplicaModulo = 'VTAS', AnticipoAplicaID = @ID WHERE Mov = @MovDestino AND MovID = @MovDestinoID AND OrigenTipo = 'VTAS' AND Empresa = @Empresa
          END
        FETCH NEXT FROM crAnticiposFacturados INTO @IDcursor
        END
        CLOSE crAnticiposFacturados
        DEALLOCATE crAnticiposFacturados
        IF @@ERROR <> 0 SET @Ok = 1 
    END

    IF @Clave = 'VTAS.P'
    BEGIN
        DECLARE crAnticiposFacturados  CURSOR FOR
          SELECT 
            mf.DID
          FROM 
          MovFlujo mf 
          JOIN MovTipo mt ON mt.Mov = mf.DMov 
            AND mt.Modulo = 'VTAS' 
            AND mt.Clave = 'VTAS.F' 
            AND mt.SubClave = 'VTAS.FA'
          WHERE mf.OID = @OID
        OPEN crAnticiposFacturados
        FETCH NEXT FROM crAnticiposFacturados INTO @IDcursor
        WHILE @@FETCH_STATUS <> -1
        BEGIN
          IF @@FETCH_STATUS <> -2
          BEGIN
            SELECT @MovDestino = Mov, @MovDestinoID = MovID, @ImporteAplicar = ISNULL(Importe, 0) + ISNULL(Impuestos, 0) FROM Venta WHERE ID = @IDCursor
            UPDATE Cxc SET AnticipoAplicar = @ImporteAplicar, AnticipoAplicaModulo = 'VTAS', AnticipoAplicaID = @ID WHERE Mov = @MovDestino AND MovID = @MovDestinoID AND OrigenTipo = 'VTAS' AND Empresa = @Empresa
          END
        FETCH NEXT FROM crAnticiposFacturados INTO @IDcursor
        END
        CLOSE crAnticiposFacturados
        DEALLOCATE crAnticiposFacturados
        IF @@ERROR <> 0 SET @Ok = 1 
    END
  END
  
  IF @Accion IN('AFECTAR','CANCELAR') AND @Modulo = 'VTAS' AND @SubClave = 'VTAS.FA' AND @Estatus IN('SINAFECTAR','CONCLUIDO') AND @EstatusNuevo IN('CONCLUIDO','CANCELADO')
  BEGIN
    SELECT @OMov = Origen, @OMovID = OrigenID FROM Venta WHERE ID = @ID
    SELECT @OID = ID FROM Venta WHERE Empresa = @Empresa AND Mov = @OMov AND MovID = @OMovID
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @OID, @OMov, @OMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
  END
  RETURN
END
GO

/**************** spProdSerieLoteDesdeOrden ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvProdSerieLoteDesdeOrden') and type = 'P') drop procedure dbo.spInvProdSerieLoteDesdeOrden
GO             
CREATE PROCEDURE spInvProdSerieLoteDesdeOrden
		   @Sucursal				int,
		   @Modulo				char(5),
    		   @OID					int,
		   @DID					int,
		   @CopiarArtCostoInv			bit = 0,
		   @Accion				varchar(20),
		   @Ok					int OUTPUT,
		   @OkRef				varchar(255) OUTPUT

--//WITH ENCRYPTION
AS  
BEGIN
  DECLARE
    @ProdSerieLoteDesdeOrden			bit,
	@ProdSerieloteIndicarArrastre       bit,
    @Empresa						varchar(5),
    @OMovTipo						varchar(20),
    @DMovTipo						varchar(20),
    @ProdAutoLote					varchar(20),
    @ORenglon						float,
    @ORenglonID						int,
    @OArticulo						varchar(20),
    @OSubCuenta						varchar(50),
    @OAlmacen						varchar(20),
    @OCantidad						float, 
    @OCantidadA						float,
    @OProdSerieLote					varchar(50),
    @DRenglon						float,
    @DRenglonID						varchar(20),
    @DArticulo						varchar(20),
    @DSubCuenta						varchar(50),
    @DAlmacen						varchar(20),
    @DCantidad						float,
    @DCantidadA						float,
    @DProdSerieLote					varchar(20),
    @Cantidad						float,
    @SerieLote						varchar(50),
    @Limite							float,
    @CantidadLoteDestino			float,
    @TotalCantidadLoteDestino		float,
	@Centro							varchar(20),
	@CentroDestino					varchar(20),
	@Verificar						int 

  DECLARE @SerieLoteMovArrastre		TABLE
  (
		Empresa			varchar(5),
		Modulo			varchar(5),
		ID				int,
		RenglonID		int,
		Articulo		varchar(20),
		SubCuenta		varchar(50),
		SerieLote		varchar(50),
		CentroOrigen	varchar(10),
		CentroDestino	varchar(10),
		Cantidad		float
  )

  SELECT 
    @Empresa = p.Empresa,
    @OMovTipo = mt.Clave 
    FROM Prod p JOIN MovTipo mt
      ON mt.Mov = p.Mov AND mt.Modulo = 'PROD'  
   WHERE ID = @OID

  SELECT 
    @DMovTipo = mt.Clave 
    FROM Prod p JOIN MovTipo mt
      ON mt.Mov = p.Mov AND mt.Modulo = 'PROD'  
   WHERE ID = @DID

  SELECT @ProdSerieLoteDesdeOrden = ProdSerieLoteDesdeOrden ,
         @ProdAutoLote = ProdAutoLote,
		 @ProdSerieloteIndicarArrastre = ProdSerieloteIndicarArrastre
	FROM EmpresaCfg2 
   WHERE Empresa = @Empresa 
 
  IF @ProdSerieLoteDesdeOrden = 1 AND @OMovTipo IN ('PROD.O') AND @DMovTipo IN ('PROD.A','PROD.E','PROD.R','PROD.M')AND @ProdAutoLote ='Nivel Renglon' AND @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN  
    DECLARE crActualizar CURSOR FOR 
     SELECT  opd.Renglon, opd.RenglonID, opd.Articulo, opd.SubCuenta, opd.Almacen, opd.Cantidad, opd.CantidadA, opd.ProdSerieLote, dpd.Renglon, dpd.RenglonID, dpd.Articulo, ISNULL(dpd.SubCuenta,''), dpd.Almacen, dpd.Cantidad, dpd.CantidadA, dpd.ProdSerieLote,dpd.Centro,dpd.CentroDestino
       FROM ProdD dpd JOIN ProdD opd  ON  dpd.ProdSerieLote = opd.ProdSerieLote
      WHERE dpd.ID = @DID AND opd.ID = @OID
       OPEN crActualizar
    
    FETCH NEXT FROM crActualizar INTO @ORenglon, @ORenglonID, @OArticulo, @OSubCuenta, @OAlmacen, @OCantidad, @OCantidadA, @OProdSerieLote, @DRenglon, @DRenglonID, @DArticulo, @DSubCuenta, @DAlmacen, @DCantidad, @DCantidadA, @DProdSerieLote, @Centro, @CentroDestino
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      IF (SELECT Tipo FROM Art WHERE Articulo = @OArticulo) IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA')
      BEGIN 	    	    	
        DELETE FROM SerieLoteMov WHERE ID = @DID AND Modulo = @Modulo AND Articulo = @DArticulo AND ISNULL(SubCuenta,'') = ISNULL(@DSubCuenta,'') AND RenglonID = @DRenglonID AND Empresa = @Empresa
        IF @@ERROR <> 0 SET @Ok = 1
  
        SET @TotalCantidadLoteDestino = 0.0
        IF @ProdSerieloteIndicarArrastre = 0
        BEGIN
          DECLARE crActualizar2 CURSOR FOR
	       SELECT SerieLote, Cantidad
  	       FROM SerieLoteMov
	        WHERE ID = @OID
              AND Modulo = @Modulo 
              AND Articulo = @OArticulo 
              AND ISNULL(SubCuenta,'') = ISNULL(@OSubCuenta,'') 
              AND RenglonID = @ORenglonID
              AND Empresa = @Empresa
        END
        ELSE 
        IF @ProdSerieloteIndicarArrastre = 1
        BEGIN
          DECLARE crActualizar2  CURSOR FOR
  	       SELECT slm.SerieLote, slm.Cantidad
   	       FROM SerieLoteMovArrastre slma JOIN SerieLoteMov slm 
	           ON slm.ID = slma.ID 
	          AND slm.RenglonID = slma.RenglonID
	          AND slm.Articulo = slma.Articulo 
              AND slm.SubCuenta = slma.SubCuenta
	          AND slm.SerieLote = slma.SerieLote
	          AND slm.Modulo = slma.Modulo
	          AND slm.Empresa = slma.Empresa
	        WHERE slma.ID = @OID
              AND slma.Modulo = @Modulo 
              AND slma.Articulo = @OArticulo 
              AND ISNULL(slma.SubCuenta,'') = ISNULL(@OSubCuenta,'') 
              AND slma.RenglonID = @ORenglonID
              AND slma.Empresa = @Empresa	
              AND slma.CentroOrigen = @Centro
              AND ISNULL(slma.CentroDestino,'') = ISNULL(@CentroDestino,'')

        END
            
        SET @Limite = @DCantidad
        OPEN crActualizar2
        FETCH NEXT FROM crActualizar2 INTO @SerieLote, @Cantidad 
        WHILE @@FETCH_STATUS = 0 AND @Limite > 0.0 AND @Ok IS NULL
        BEGIN
          IF @Limite >= @Cantidad 
            SET @CantidadLoteDestino = @Cantidad 
          ELSE
            SET @CantidadLoteDestino = @Limite
            
          INSERT SerieLoteMov (Empresa,  Modulo,  ID,   RenglonID,   Articulo,   SubCuenta,   SerieLote,  Cantidad,             Sucursal)
                       VALUES (@Empresa, @Modulo, @DID, @DRenglonID, @DArticulo, @DSubCuenta, @SerieLote, @CantidadLoteDestino, @Sucursal)
          IF @@ERROR <> 0 SET @Ok = 1
  
  
          IF @ProdSerieloteIndicarArrastre = 1 AND @Ok IS NULL
          BEGIN
            INSERT @SerieLoteMovArrastre (Empresa, Modulo,  ID,   RenglonID,   Articulo,   SubCuenta,   SerieLote,  CentroOrigen, CentroDestino,  Cantidad)
                                  SELECT @Empresa, @Modulo, @OID, @DRenglonID, @DArticulo, @DSubCuenta, @SerieLote, @Centro,      @CentroDestino, @CantidadLoteDestino 
          END

 
          SET @Limite = @Limite - @CantidadLoteDestino
          SET @TotalCantidadLoteDestino = @TotalCantidadLoteDestino + @CantidadLoteDestino
          FETCH NEXT FROM crActualizar2 INTO @SerieLote, @Cantidad
        END
        CLOSE crActualizar2
        DEALLOCATE crActualizar2
  
        IF @DCantidad <> @TotalCantidadLoteDestino SELECT @Ok = 20330, @OkRef = @DArticulo + '. ' + ISNULL(@DSubCuenta,'')
      END
         
      FETCH NEXT FROM crActualizar INTO @ORenglon	, @ORenglonID, @OArticulo, @OSubCuenta, @OAlmacen, @OCantidad, @OCantidadA, @OProdSerieLote, @DRenglon, @DRenglonID, @DArticulo, @DSubCuenta, @DAlmacen, @DCantidad, @DCantidadA, @DProdSerieLote,@Centro, @CentroDestino
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar

    DELETE FROM SerieLoteMovArrastre 
      FROM SerieLoteMovArrastre slma JOIN @SerieLoteMovArrastre slma2
        ON slma.Empresa = slma2.Empresa
       AND slma.Modulo = slma2.Modulo
       AND slma.ID = slma2.ID
       AND slma.RenglonID = slma2.RenglonID
       AND slma.Articulo = slma2.Articulo
       AND ISNULL(slma.SubCuenta,'') = ISNULL(slma2.SubCuenta,'')
       AND slma.SerieLote = slma2.SerieLote
       AND slma.CentroOrigen = slma2.CentroOrigen
       AND ISNULL(slma.CentroDestino,'') = ISNULL(slma2.CentroDestino,'') 
  
  END
END
GO

/**************** spInvFacturaFlexibleAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvFacturaFlexibleAfectar') and type = 'P') drop procedure dbo.spInvFacturaFlexibleAfectar
GO             
CREATE PROCEDURE spInvFacturaFlexibleAfectar
		@Empresa		varchar(5),
		@Sucursal		int,
		@Usuario		varchar(10),
		@Accion			varchar(20),
		@Estatus		varchar(15),
		@Modulo			varchar(5),
		@ID			int,
		@Ok			int OUTPUT,
		@OkRef			varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	
	@MovTipo		varchar(20),
	@SubMovTipo		varchar(20),
	@Mov			varchar(20),
	@FechaEmision		datetime,
        @Concepto		varchar(50),
	@Proyecto		varchar(50),
	@Actividad		varchar(20),
	@UEN			int,
	@Moneda			varchar(10),
	@TipoCambio		float,
	@Cliente		varchar(10),
	@EnviarA		int,
	@Almacen		varchar(10),
	@Agente			varchar(10),
	@AgenteServicio		varchar(10),
	@AgenteComision		float,
	@Formaenvio		varchar(50),
	
	@Importe		money,
	@Impuestos		money,
	@ComisionTotal		money,
	
	@OrigenTipo		varchar(10),
	@Origen			varchar(20),
	@OrigenID		varchar(20),
	
	@Articulo		varchar(20),
	@Cantidad		float,
	@Precio			float,
	@Unidad			varchar(50),

	@IDBonificacion		int,
	@Renglon		float,
	@RenglonID		int,

	@OMov			varchar(20),
	@DModulo		varchar(5),
	@OModulo		varchar(5),
	@OMovID			varchar(20), 
	@MovID			varchar(20),
	@OID			int,
	@DID			int,
	
	@IDFactura		int,
	@MovFactura		varchar(20),
        @MovAplicacion		varchar(20),

	@ZonaImpuesto		varchar(30),
	@Impuesto1		float,
	@Impuesto2		float,
	@Impuesto3		float,
	@SubCuenta		varchar(50),
	@Tipo			varchar(20),
	@RenglonTipo		varchar(1),
	@IDAplicacion		int,
	@Clave			varchar(20)

  SELECT @MovTipo = mt.Clave,
         @SubMovTipo = mt.SubClave,
         @FechaEmision = v.FechaEmision,
         @Concepto = v.Concepto,
         @Proyecto = v.Proyecto,
         @Actividad = v.Actividad,
         @UEN = v.UEN,
         @Moneda = v.Moneda,
         @TipoCambio = v.TipoCambio,
         @Cliente = v.Cliente,
         @EnviarA = v.EnviarA,
         @Almacen = v.Almacen,
         @Agente = v.Agente,
         @AgenteServicio = v.Agenteservicio,
         @AgenteComision = v.Agentecomision,
         @FormaEnvio = v.FormaEnvio,
         @OrigenTipo = v.OrigenTipo,
         @Origen = v.Origen,
         @OrigenID = v.OrigenID    
    FROM Venta v 
    JOIN MovTipo mt 
      ON mt.Mov = v.Mov 
     AND mt.Modulo =  @Modulo 
     AND v.ID = @ID

   SELECT 
     @MovFactura = VentaFactura,
     @MovAplicacion = cxcAplicacion 
     FROM EmpresaCfgMov 
    WHERE Empresa = @Empresa

   SELECT 
     @Mov = VentaBonificacion
     FROM EmpresaCfgMovVenta
    WHERE Empresa = @Empresa

  IF @Modulo = 'VTAS' AND @MovTipo = 'VTAS.F' AND @SubMovTipo = 'FF.FF' AND  @OK IS NULL
  BEGIN
    IF @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR' 
    BEGIN
      INSERT Venta (Empresa,  Mov,  FechaEmision,  Concepto,  Proyecto,  Actividad,  UEN,  Moneda,  TipoCambio,  Usuario,  Estatus,      Cliente,  EnviarA,  Almacen,  Agente,  AgenteServicio,  AgenteComision,  FormaEnvio,    Importe,  Impuestos,  ComisionTotal, OrigenTipo,  Origen,  OrigenID,  Sucursal)
            VALUES (@Empresa, @Mov, @FechaEmision, @Concepto, @Proyecto, @Actividad, @UEN, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Cliente, @EnviarA, @Almacen, @Agente, @AgenteServicio, @AgenteComision, @FormaEnvio, @Importe, @Impuestos, @ComisionTotal,@OrigenTipo, @Origen, @OrigenID, @Sucursal)
      IF @@ERROR <> 0 SET @OK = 1
      SELECT @IDBonificacion = SCOPE_IDENTITY()

      IF @OK IS NULL
      BEGIN 
	SET @Renglon = 2048.0
	SET @RenglonID = 1
        DECLARE VentaFlexibleD CURSOR FOR
         SELECT Articulo, ISNULL(SUM(Cantidad), 0), Precio
	FROM VentaFlexibleD 
	WHERE ID = @ID
	GROUP BY Articulo, Precio   

        OPEN VentaFlexibleD
        FETCH NEXT FROM VentaFlexibleD INTO @Articulo, @Cantidad, @Precio
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
          SELECT @ZonaImpuesto = ZonaImpuesto FROM Cte WHERE Cliente = @Cliente
	  SELECT @Tipo = Tipo, @Impuesto1 = Impuesto1, @Impuesto2 = Impuesto2, @Impuesto3 = Impuesto3 FROM Art WHERE Articulo = @Articulo

	  EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
     	  EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
       	  EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
          EXEC spTipoImpuesto @Modulo, @IDBonificacion, @Mov, @FechaEmision, @Empresa, @Sucursal, @Cliente, @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
          EXEC spRenglonTipo @Tipo, NULL, @RenglonTipo OUTPUT

	  INSERT VentaD (ID,              Renglon,  RenglonID,  RenglonSub, Cantidad,  Unidad,  Almacen,  Articulo,  Precio,  Sucursal,  UEN,  Impuesto1,  Impuesto2,  Impuesto3,  RenglonTipo)
	         VALUES (@IDBonificacion, @Renglon, @RenglonID, 0,          @Cantidad, @Unidad, @Almacen, @Articulo, @Precio, @Sucursal, @UEN, @Impuesto1, @Impuesto2, @Impuesto3, @RenglonTipo)
          IF @@ERROR <> 0 SET @Ok = 1	
          SET @Renglon = @Renglon + 2048.0
          SET @RenglonID = @RenglonID + 1

          FETCH NEXT FROM VentaFlexibleD INTO @Articulo, @Cantidad, @Precio
        END
        CLOSE VentaFlexibleD
        DEALLOCATE VentaFlexibleD
      END

      IF @OK IS NULL
      BEGIN
        UPDATE Venta SET Importe = @Importe WHERE ID = @IDBonificacion
	IF @@ERROR <> 0 SET @Ok = 1
      END

      IF @Ok IS NULL 
        EXEC spAfectar @Modulo, @IDBonificacion, @Accion,'TODO', NULL ,@Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, @Conexion = 1

      SELECT @OMov = Mov, @OMovID = MovID FROM Venta WHERE ID= @ID
      SELECT @MovID = MovID FROM Venta WHERE ID = @IDBonificacion

      IF @OK IS NULL
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @OMov, @OMovID, @Modulo, @IDBonificacion, @Mov, @MovID, @OK OUTPUT

      IF @OK IS NULL
      BEGIN
	DECLARE VentaFlexibleFactura CURSOR FOR
         SELECT Cliente
        FROM VentaFlexibleD
        WHERE ID = @ID
        GROUP BY Cliente

        OPEN VentaFlexibleFactura
        FETCH NEXT FROM VentaFlexibleFactura INTO @Cliente
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
          INSERT Venta (Empresa,  Mov,         FechaEmision,  Concepto,  Proyecto,  Actividad,  UEN,  Moneda,  TipoCambio,  Usuario,  Estatus,      Cliente,  EnviarA,  Almacen,  Agente,  AgenteServicio,  AgenteComision,  FormaEnvio,    Importe,  Impuestos,  ComisionTotal, OrigenTipo,  Origen,  OrigenID,  Sucursal)
                VALUES (@Empresa, @MovFactura, @FechaEmision, @Concepto, @Proyecto, @Actividad, @UEN, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Cliente, @EnviarA, @Almacen, @Agente, @AgenteServicio, @AgenteComision, @FormaEnvio, @Importe, @Impuestos, @ComisionTotal,@OrigenTipo, @Origen, @OrigenID, @Sucursal)
          IF @@ERROR <> 0 SET @OK = 1
          SELECT @IDFactura = SCOPE_IDENTITY()

          IF @OK IS NULL
          BEGIN
	    SET @Renglon = 2048.0
	    SET @RenglonID = 1
            DECLARE VentaFlexibleFacturaD CURSOR FOR
             SELECT Articulo, ISNULL(SUM(ISNULL(Cantidad,0.0)),0.0) , ISNULL(Precio, 0.0)
            FROM VentaFlexibleD
            WHERE ID = @ID AND Cliente = @Cliente
	    GROUP BY Articulo, Precio

            OPEN VentaFlexibleFacturaD
            FETCH NEXT FROM VentaFlexibleFacturaD INTO @Articulo, @Cantidad, @Precio
            WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
            BEGIN
              SELECT @ZonaImpuesto = ZonaImpuesto FROM Cte WHERE Cliente = @Cliente
	      SELECT @Tipo = Tipo, @Impuesto1 = Impuesto1, @Impuesto2 = Impuesto2, @Impuesto3 = Impuesto3 FROM Art WHERE Articulo = @Articulo

	      EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
     	      EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
       	      EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
              EXEC spTipoImpuesto @Modulo, @IDFactura, @MovFactura, @FechaEmision, @Empresa, @Sucursal, @Cliente, NULL, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
	      EXEC spRenglonTipo @Tipo, NULL, @RenglonTipo OUTPUT

	      INSERT VentaD (ID,         Renglon,  RenglonID,  RenglonSub, Cantidad,  Unidad,  Almacen,  Articulo,  Precio,  Sucursal,  UEN,   Impuesto1,   Impuesto2,   Impuesto3,  RenglonTipo)  
		     VALUES (@IDFactura, @Renglon, @RenglonID, 0,          @Cantidad, @Unidad, @Almacen, @Articulo, @Precio, @Sucursal, @UEN,  @Impuesto1,  @Impuesto2,  @Impuesto3, @RenglonTipo)  
	      IF @@ERROR <> 0 SET @Ok = 1	
	      SET @Renglon = @Renglon + 2048.0
	      SET @RenglonID = @RenglonID + 1
	      FETCH NEXT FROM VentaFlexibleFacturaD INTO @Articulo, @Cantidad, @Precio
            END
            CLOSE VentaFlexibleFacturaD
            DEALLOCATE VentaFlexibleFacturaD
          END

          IF @Ok IS NULL 
            EXEC spAfectar @Modulo, @IDFactura, @Accion,'TODO', NULL ,@Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, @Conexion = 1

          IF @OK IS NULL
          BEGIN

            SELECT @MovID = MOVID FROM Venta WHERE ID = @IDFactura
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @OMov, @OMovID, @Modulo, @IDFactura, @MovFactura, @MovID, @OK OUTPUT
          END 
          FETCH NEXT FROM VentaFlexibleFactura INTO @Cliente
        END
        CLOSE VentaFlexibleFactura
        DEALLOCATE VentaFlexibleFactura
      END 
      
      IF @OK IS NULL
      BEGIN 
	SELECT @DID = mf.DID, @DModulo = mf.DModulo, @Clave = mt.Clave 
          FROM MovFlujo mf JOIN MovTipo mt 
            ON mf.DMov = mt.Mov AND mt.Modulo = mf.DModulo
         WHERE mf.OID = @IDBonificacion AND mf.OModulo = 'VTAS' AND mf.DModulo = 'CXC'

        IF @Clave = 'CXC.NC' AND @DModulo = 'CXC'
        BEGIN
          EXEC @IDAplicacion = spAfectar 'CXC', @DID, 'GENERAR', 'Todo', @MovAplicacion, @Usuario, NULL, 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
	  IF @Ok >= 80000 SELECT @Ok = NULL, @OkRef = NULL

	  SELECT @Mov = Mov, @MovID = MovID FROM Venta WHERE ID = @ID
          SELECT @Importe = Importe + Impuestos FROM Venta WHERE ID = @IDBonificacion

          IF @OK IS NULL
          BEGIN
            INSERT CxcD (ID,            Renglon, RenglonSub, Aplica, AplicaID, Importe)
                 VALUES (@IDAplicacion, 2048.0,  0,          @Mov,   @MovID,   @Importe)
            IF @@ERROR <> 0 SET @Ok = 1
          END

          IF @OK IS NULL
            EXEC spAfectar 'CXC', @IDAplicacion, 'AFECTAR', 'Todo', NULL, @Usuario, NULL, 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
        END

      END

    END ELSE

    IF @Accion = 'CANCELAR'  AND @Estatus = 'CONCLUIDO' AND @OK IS NULL
    BEGIN
      DECLARE VentaFlexibleCancelar CURSOR FOR
      SELECT DID
        FROM MovFlujo
       WHERE OID = @ID AND DModulo = @Modulo
      OPEN VentaFlexibleCancelar
      FETCH NEXT FROM VentaFlexibleCancelar INTO @OID
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        EXEC spAfectar @Modulo, @OID, @Accion,'TODO', NULL ,@Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, @Conexion = 1
        FETCH NEXT FROM VentaFlexibleCancelar INTO @OID
      END
      CLOSE VentaFlexibleCancelar
      DEALLOCATE VentaFlexibleCancelar
    END
  END

--arcc
--SET @Ok = 1
END
GO

/**************** spInvAfectarUnidades ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvAfectarUnidades') and type = 'P') drop procedure dbo.spInvAfectarUnidades
GO             
CREATE PROCEDURE spInvAfectarUnidades
			@Sucursal		int,
                        @Accion			char(20),
                        @Base			char(20),
	           	@Empresa		char(5),
			@Usuario		char(10),
	           	@Modulo			char(5),
                        @ID			int,
	           	@Mov			char(20),
	           	@MovID			varchar(20),
			@MovTipo		char(20),
    		   	@MovMoneda	      	char(10),
    		   	@MovTipoCambio	 	float,
			@Estatus		char(15),

	           	@Articulo		char(20),
			@ArtMoneda		char(10),
			@ArtTipoCambio		float,
			@ArtTipo		char(20),
	           	@SubCuenta		varchar(50),
	           	@Almacen		char(10),
                        @AlmacenTipo		char(15),
			@AlmacenDestino		char(10),
                        @AlmacenDestinoTipo	char(15),
                   	@EsCargo        	bit,
			@CantidadOriginal	float,
	           	@Cantidad		float,
			@Factor			float,
			@Renglon		float,
			@RenglonSub		int,
              		@RenglonID		int,
			@RenglonTipo		char(1),
			@FechaRegistro		datetime,
    		   	@FechaAfectacion   	datetime,
	           	@Ejercicio		int,
	           	@Periodo		int,
		   	@AplicaMov		varchar(20),
		   	@AplicaMovID		varchar(20),
    		   	@OrigenTipo		varchar(10),

			@AfectarCostos		bit,
			@AfectarPiezas		bit,
			@AfectarVtasMostrador	bit,
                        @FacturarVtasMostrador	bit,
			@AfectarConsignacion	bit,
			@EsTransferencia	bit,

			@CfgSeriesLotesMayoreo	bit,
			--@CfgAutoConsig		bit,
    		   	@CfgFormaCosteo    	char(20),
    		   	@CfgTipoCosteo     	char(20),

			@CantidadReservada	float,
			@ReservadoParcial	float	     OUTPUT,
    			@UltRenglonIDJuego	int	     OUTPUT,
			@CantidadJuego		float	     OUTPUT,
    			@CantidadMinimaJuego	int	     OUTPUT,
			@UltReservadoCantidad 	float	     OUTPUT,
			@UltReservadoFecha   	datetime     OUTPUT,
		        @AfectarCantidad	float	     OUTPUT,
			@AfectarAlmacen		char(10)     OUTPUT,
			@AfectarAlmacenDestino	char(10)     OUTPUT,
   		   	@Ok                	int          OUTPUT,
    		   	@OkRef             	varchar(255) OUTPUT,
			@Tarima			varchar(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @EsPrestamoGarantia			bit,
    @NoEsCargo				bit,
    @AlmFisico				char(10),
    @AlmGarantia			char(10),
    @AfectarRama	    		char(5),
    @ArtCostoPromedio			float,
    @AplicaCostoPromedio		float,
    @EsTipoSerie			bit,
    @CostoInvTotal			float,
    @Disponible				float,
    @FactorJuego			float,
    @CfgPedidosReservarLineaCompleta	bit,
    @AlmWMS                 bit,
    @AlmDWMS                bit
  
  SELECT @AlmWMS = WMS FROM Alm WHERE Almacen = @Almacen
  SELECT @AlmDWMS = WMS FROM Alm WHERE Almacen = @AlmacenDestino

  SELECT @AfectarAlmacen = @Almacen, @AfectarAlmacenDestino = @AlmacenDestino
  SELECT @ReservadoParcial = 0, @EsTipoSerie = 0, @EsPrestamoGarantia = 0

  IF @MovTipo IN ('INV.P', 'INV.R') AND @AlmacenTipo <> @AlmacenDestinoTipo AND (@AlmacenTipo IN ('NORMAL','PROCESO','GARANTIAS') OR @AlmacenDestinoTipo IN ('NORMAL','PROCESO','GARANTIAS'))
    SELECT @EsPrestamoGarantia = 1

  IF @Accion = 'RESERVARPARCIAL' 
  BEGIN
    SELECT @CfgPedidosReservarLineaCompleta = PedidosReservarLineaCompleta FROM EmpresaCFG WHERE Empresa = @Empresa
    IF @RenglonTipo = 'C' AND @Modulo IN ('VTAS', 'INV', 'PROD') AND (SELECT dbo.fxReservarJuego(@Empresa)) = 0
    BEGIN
      IF @UltRenglonIDJuego <> @RenglonID 
      BEGIN
        SELECT @UltRenglonIDJuego = @RenglonID
	EXEC spInvCantidadReservarJuego @Empresa, @Modulo, @ID, @Estatus, @Almacen, @AlmacenTipo, 
                                        @AfectarConsignacion, @RenglonID, @CantidadJuego OUTPUT, @CantidadMinimaJuego OUTPUT, @Ok OUTPUT
      END
      SELECT @FactorJuego = @CantidadOriginal/@CantidadJuego
      SELECT @Cantidad = FLOOR(@CantidadMinimaJuego*@FactorJuego), @ReservadoParcial = FLOOR(@CantidadMinimaJuego*@FactorJuego)
    END ELSE
    BEGIN
      --Nota Se cambio spArtDisponible por spArtSubDisponible
	  EXEC spArtSubDisponible @Empresa, @Almacen, @Articulo, @ArtTipo, @SubCuenta, @AfectarConsignacion, @AlmacenTipo, @Factor, @Disponible OUTPUT, @Ok OUTPUT--, @Tarima = @Tarima --Bug 8086	      
      IF @Disponible < 0 SELECT @Disponible = 0.0  -- por las notas en rojo
--      IF @Disponible < @Cantidad SELECT @Cantidad = @Disponible, @ReservadoParcial = @Disponible ELSE SELECT @ReservadoParcial = @Cantidad  ETO 23-Mar-2007
--    ETO 23-Mar-2007 Si esta activa la opción de Ventas Auto Reservar Partidas Completas, no reserva si la cantidad a reservar es mayor al disponible 
      IF @Disponible < @Cantidad 
      BEGIN
        IF @CfgPedidosReservarLineaCompleta = 0
          SELECT @Cantidad = @Disponible, @ReservadoParcial = @Disponible
        ELSE
          SELECT @Cantidad = 0, @ReservadoParcial = 0
      END
      ELSE
        SELECT @ReservadoParcial = @Cantidad
    END
  END
  SELECT @AfectarCantidad = @Cantidad

  -- Cuando ya se va a concluir una factura pendiente, hay que quitar el reservado.
  IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND @Accion = 'AFECTAR' AND @Estatus = 'PENDIENTE'
    EXEC spSaldo @Sucursal, 'DESRESERVAR', @Empresa, @Usuario, 'RESV', @ArtMoneda, NULL, @Articulo, @SubCuenta, @Almacen, @AlmacenDestino, 
                 @Modulo, @ID, @Mov, @MovID, @EsCargo, NULL, @AfectarCantidad, @Factor,
                 @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, @EsTipoSerie,                 
				 @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID--, @SubGrupo = @Tarima --Bug 8086

  IF @Accion IN ('RESERVARPARCIAL', 'RESERVAR', 'DESRESERVAR') OR (@Accion = 'CANCELAR' AND @MovTipo IN ('VTAS.F','VTAS.FAR','VTAS.FC', 'VTAS.FG', 'VTAS.FX','VTAS.P','VTAS.S','INV.SOL','INV.OT','INV.OI','INV.SM') AND @CantidadReservada > 0.0)
  BEGIN
    SELECT @AfectarRama = 'RESV'
    IF @Accion = 'CANCELAR' 
    BEGIN
      SELECT @EsCargo = 0 
      SELECT @AfectarCantidad = @CantidadReservada
      IF @AfectarCantidad > @Cantidad SELECT @AfectarCantidad = @Cantidad
    END ELSE
      IF @Accion = 'DESRESERVAR' SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1
  END ELSE
  BEGIN
    SELECT @AfectarRama = 'INV'
    IF @AlmacenTipo = 'GARANTIAS' AND @EsPrestamoGarantia = 0 SELECT @AfectarRama = 'GAR' ELSE 
    IF @AlmacenTipo = 'ACTIVOS FIJOS' AND @AfectarConsignacion = 0 SELECT @AfectarRama = 'AF' ELSE
    IF @AfectarConsignacion  = 1 SELECT @AfectarRama = 'CSG' ELSE
    IF @AfectarPiezas        = 1 SELECT @AfectarRama = 'PZA' ELSE
    IF @AfectarVtasMostrador = 1
    BEGIN
      SELECT @AfectarRama = 'VMOS'
      IF @EsCargo = 1 SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1
    END
  END
  IF @EsTransferencia = 1 SELECT @EsCargo = 0
  IF @ArtTipo IN ('SERIE', 'VIN') AND @CfgSeriesLotesMayoreo = 0 SELECT @EsTipoSerie = 1
  
  IF @EsPrestamoGarantia = 1 
  BEGIN
    IF @AlmacenTipo = 'GARANTIAS'
      SELECT @AlmGarantia = @Almacen, @AlmFisico = @AlmacenDestino, @EsCargo = 1 
    ELSE 
    BEGIN    
      IF @MovTipo = 'INV.R'  SELECT @AlmGarantia = @Almacen, @AlmFisico = @AlmacenDestino, @EsCargo = 1, @afectarCostos = 0 
      ELSE SELECT @AlmGarantia = @AlmacenDestino, @AlmFisico = @Almacen, @EsCargo = 0, @afectarCostos = 0    
    END 
    
    IF @AfectarCostos = 1 AND @AfectarRama IN ('INV', 'AF') 
      SELECT @AfectarAlmacen = @AlmFisico, @AfectarAlmacenDestino = NULL
    ELSE
      EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @AfectarRama, @ArtMoneda, NULL, @Articulo, @SubCuenta, @AlmFisico, NULL, 
                   @Modulo, @ID, @Mov, @MovID, @EsCargo, NULL, @AfectarCantidad, @Factor,
                   @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, @EsTipoSerie,                   
				   @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID--, @SubGrupo = @Tarima --Bug 8086

    IF @EsCargo = 1 SELECT @NoEsCargo = 0 ELSE SELECT @NoEsCargo = 1
    EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'GAR', @ArtMoneda, NULL, @Articulo, @SubCuenta, @AlmGarantia, NULL, 
                 @Modulo, @ID, @Mov, @MovID, @NoEsCargo, NULL, @AfectarCantidad, @Factor,
                 @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, @EsTipoSerie,                 
				 @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID--, @SubGrupo = @Tarima --Bug 8086
  END 
  ELSE BEGIN
    IF @FacturarVtasMostrador = 1 OR (@Accion ='CANCELAR' AND @MovTipo IN ('VTAS.F','VTAS.FAR','VTAS.FB') AND @OrigenTipo = 'VMOS')
    BEGIN
/*      IF @Accion = 'CANCELAR' 
        IF @EsCargo = 1 SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1*/
      EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'VMOS', @ArtMoneda, NULL, @Articulo, @SubCuenta, @Almacen, @AlmacenDestino, 
                   @Modulo, @ID, @Mov, @MovID, @EsCargo, NULL, @AfectarCantidad, @Factor,
                   @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, @EsTipoSerie,	                   
				   @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID--, @SubGrupo = @Tarima --Bug 8086
/*      IF @Accion = 'CANCELAR' RETURN*/
    END

    -- Afectar SaldosU (Unidades)
    IF @AfectarCostos = 1 AND @AfectarRama IN ('INV', 'AF') 
      SELECT @AfectarAlmacen = @Almacen, @AfectarAlmacenDestino = @AlmacenDestino
    ELSE
      EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @AfectarRama, @ArtMoneda, NULL, @Articulo, @SubCuenta, @Almacen, @AlmacenDestino, 
                   @Modulo, @ID, @Mov, @MovID, @EsCargo, NULL, @AfectarCantidad, @Factor,
                   @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, @EsTipoSerie,
                   @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID--, @SubGrupo = @Tarima --Bug 8086

    IF @MovTipo IN('INV.T','VTAS.VCR') AND @AlmWMS = 1 AND ISNULL(@Tarima,'') <> ''
      EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, NULL, @Articulo, @SubCuenta, @Almacen, @AlmacenDestino, 
                   @Modulo, @ID, @Mov, @MovID, @EsCargo, NULL, @AfectarCantidad, @Factor,
                   @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, @EsTipoSerie,
                   @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @SubGrupo = @Tarima --Bug 8086

    IF @MovTipo IN('VTAS.VCR') AND @Accion = 'CANCELAR' AND @AlmDWMS = 1 AND ISNULL(@Tarima,'') <> ''
      EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, NULL, @Articulo, @SubCuenta, @AlmacenDestino, NULL, 
                   @Modulo, @ID, @Mov, @MovID, 1, NULL, @AfectarCantidad, @Factor,
                   @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, @EsTipoSerie,
                   @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @SubGrupo = @Tarima --Bug 8086

    IF @AfectarRama = 'RESV' AND @AfectarCantidad <> 0.0
    BEGIN     
      IF @EsCargo = 1 SELECT @UltReservadoCantidad = @AfectarCantidad ELSE SELECT @UltReservadoCantidad = -@AfectarCantidad
      SELECT @UltReservadoFecha = @FechaRegistro
      EXEC spExtraerFecha @UltReservadoFecha OUTPUT
      EXEC xpInvReservado @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @Renglon, @RenglonSub,
			  @EsCargo, @AfectarCantidad, @Factor, @Articulo, @SubCuenta, @FechaAfectacion, 
                          @Ok OUTPUT, @OkRef OUTPUT
    END

    IF @EsTransferencia = 1 AND @AfectarConsignacion = 1 AND @OK IS NULL 
        EXEC spTransferirConsignacion @Empresa, @Articulo, @SubCuenta, @Almacen, @AlmacenDestino, @Cantidad,
                                      @Ok OUTPUT
  END
  RETURN 
END 
GO

/**************** spInvGenerarEstadistica ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvGenerarEstadistica') and type = 'P') drop procedure dbo.spInvGenerarEstadistica
GO
CREATE PROCEDURE spInvGenerarEstadistica
				@Empresa	char(5),
 				@Sucursal	int,
				@Modulo		char(5),
				@ID		int,
			        @Mov		varchar(20),
			        @MovID		varchar(20),
				@Accion		varchar(20),
				@Contacto	varchar(10),
                        	@Ok 		int	     	OUTPUT,
		   		@OkRef 		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @VentaID	int

  IF @Modulo <> 'COMS' RETURN
  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @VentaID = MIN(ID) FROM Venta WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('CONCLUIDO', 'PENDIENTE')
  END ELSE
  BEGIN
    IF NOT EXISTS(SELECT * FROM Cte WHERE Cliente = @Contacto AND Estatus = 'ALTA') SELECT @Ok = 26065, @OkRef = @Contacto ELSE
    IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'VTAS' AND Mov = @Mov AND Clave = 'VTAS.EST') SELECT @Ok = 10490, @OkRef = @Mov+' (Ventas)'

    IF @Ok IS NULL
    BEGIN
      INSERT Venta (
             Estatus,      Usuario, OrigenTipo, Origen, OrigenID, Mov, MovID, Concepto, Empresa, FechaEmision, Referencia, Sucursal, Cliente,   Almacen, Moneda, TipoCambio, ListaPreciosEsp, Proyecto, UEN, FormaEnvio)
      SELECT 'SINAFECTAR', Usuario, @Modulo,    Mov,    MovID,    Mov, MovID, Concepto, Empresa, FechaEmision, Referencia, Sucursal, Proveedor, Almacen, Moneda, TipoCambio, ListaPreciosEsp, Proyecto, UEN, FormaEnvio
        FROM Compra
       WHERE ID = @ID

      SELECT @VentaID = SCOPE_IDENTITY() 
      INSERT VentaD (
             ID,       Renglon,  RenglonID,  RenglonTipo,  Codigo, Articulo,  SubCuenta,  Cantidad,  CantidadInventario,  Factor, Unidad,  Paquete, Costo, Precio,  Impuesto1,  Impuesto2,  Impuesto3,  Almacen,  DescripcionExtra, ContUso, ContUso2, ContUso3)
      SELECT @VentaID, Renglon,  RenglonID,  RenglonTipo,  Codigo, Articulo,  SubCuenta,  Cantidad,  CantidadInventario,  Factor, Unidad,  Paquete, Costo, NULL,    Impuesto1,  Impuesto2,  Impuesto3,  Almacen,  DescripcionExtra, ContUso, ContUso2, ContUso3
        FROM CompraD
       WHERE ID = @ID AND EsEstadistica = 1
    END
  END

  IF @Ok IS NULL AND @VentaID IS NOT NULL
  BEGIN
    EXEC spAfectar 'VTAS', @VentaID, @Accion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    IF @Ok IS NULL
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'VTAS', @VentaID, @Mov, @MovID, @Ok OUTPUT 
  END
  RETURN
END
GO       

/**************** spInvBackOrder ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvBackOrder') and type = 'P') drop procedure dbo.spInvBackOrder
GO
CREATE PROCEDURE spInvBackOrder
     			@Sucursal		int,
		  	@Accion			char(20), 
			@Estatus		char(15),
			@EsEntrada		bit,
			@Empresa		char(5),
			@Usuario		char(10),
                        @OModulo		char(5),
                        @OID			int,
                        @OMov			char(20),
                        @OMovID			varchar(20),
    		   	@Modulo			varchar(10),
    		   	@Mov			varchar(20),
    		   	@MovID			varchar(20),
			@Articulo		char(20),
			@SubCuenta		varchar(50),
			@MovUnidad		varchar(50),
			@Cantidad		float		OUTPUT,
			@FactorCompra		float,
			@ArtMoneda		char(10),

			@Almacen		char(10),
			@FechaAfectacion	datetime, 
			@FechaRegistro		datetime,
			@Ejercicio		int, 
			@Periodo		int,

                        @Ok 			int	     	OUTPUT,
		   	@OkRef 			varchar(255)	OUTPUT,
			@MovTipo		varchar(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Estatus = 'PENDIENTE' AND @Accion IN ('RESERVARPARCIAL', 'RESERVAR', 'DESRESERVAR') RETURN
  -- SET nocount ON
  DECLARE
     @DID			int,
     @EsCargo			bit,
     @ReservarEsCargo		bit,
     @MovTipoOrigen		char(20),
     @AlmacenOrigen		char(10),
     @SucursalAlmacenOrigen	int,
     @PendienteReal		float,
     @Obtenido			float,
     @ObtenidoReal		float,
     @PendienteDif 		float,
     @OrdenadoDif		float,
     @CantidadOrdenada		float,
     @CantidadOrdenadaReal	float,
     @CantidadPendiente		float,
     @CantidadPendienteReal	float,
     @CantidadReservada 	float,
     @CantidadReservadaReal 	float,
     @CantidadAReservar 	float,
     @FactorVenta		float,
     @Renglon			float,
     @RenglonSub		int,
     @RenglonID			int,
     @UltCantidad		float,
     @UltFecha			datetime,
     @EsCancelacion		BIT,
     @ArtTipo			varchar(20)

  SELECT @ArtTipo = Tipo FROM Art WHERE Articulo = @Articulo
  IF @ArtTipo = 'Servicio'
  BEGIN
    SELECT @OK = 20975, @OkRef = RTRIM(@Articulo)
    RETURN	
  END

  IF @Accion = 'CANCELAR' SELECT @EsCancelacion = 1 ELSE SELECT @EsCancelacion = 0
  IF @MovTipo = 'COMS.CP' SELECT @EsCancelacion = ~@EsCancelacion 
  IF @MovTipo = 'VTAS.P' AND @Accion <> 'CANCELAR'  SELECT @EsCancelacion = ~@EsCancelacion 

  SELECT @PendienteReal = @Cantidad*@FactorCompra, @UltFecha = @FechaRegistro
  EXEC spExtraerFecha @UltFecha OUTPUT

  IF @Modulo = 'VTAS'
    IF @MovTipo = 'VTAS.P'
		DECLARE crBackOrder CURSOR
		  FOR SELECT Venta.ID, Renglon, RenglonSub, VentaD.RenglonID, ISNULL(CantidadOrdenada, 0.0), ISNULL(CantidadReservada, 0.0), ISNULL(CantidadPendiente, 0.0), VentaD.Factor, VentaD.Almacen, mt.Clave
				FROM VentaD, Venta, MovTipo mt
			   WHERE VentaD.ID = Venta.ID
				 AND Venta.Empresa = @Empresa
			 AND Venta.Mov = @Mov
				 AND Venta.MovID = @MovID
				 AND mt.Modulo = @Modulo
				 AND mt.Mov = @Mov
				 AND Estatus = 'AFECTANDO'
				 AND VentaD.Articulo = @Articulo
				 AND ISNULL(RTRIM(VentaD.SubCuenta), '') = ISNULL(RTRIM(@SubCuenta), '')
				 --AND VentaD.Unidad = @MovUnidad
     ELSE

		DECLARE crBackOrder CURSOR
		  FOR SELECT Venta.ID, Renglon, RenglonSub, VentaD.RenglonID, ISNULL(CantidadOrdenada, 0.0), ISNULL(CantidadReservada, 0.0), ISNULL(CantidadPendiente, 0.0), VentaD.Factor, VentaD.Almacen, mt.Clave
				FROM VentaD, Venta, MovTipo mt
			   WHERE VentaD.ID = Venta.ID
				 AND Venta.Empresa = @Empresa
			 AND Venta.Mov = @Mov
				 AND Venta.MovID = @MovID
				 AND mt.Modulo = @Modulo
				 AND mt.Mov = @Mov
				 AND Estatus = 'PENDIENTE'
				 AND VentaD.Articulo = @Articulo
				 AND ISNULL(RTRIM(VentaD.SubCuenta), '') = ISNULL(RTRIM(@SubCuenta), '')
				 --AND VentaD.Unidad = @MovUnidad
  ELSE
  IF @Modulo = 'INV'
    DECLARE crBackOrder CURSOR
      FOR SELECT Inv.ID, Renglon, RenglonSub, InvD.RenglonID, ISNULL(CantidadOrdenada, 0.0), ISNULL(CantidadReservada, 0.0), ISNULL(CantidadPendiente, 0.0), InvD.Factor, InvD.Almacen, mt.Clave
            FROM InvD, Inv, MovTipo mt
           WHERE InvD.ID = Inv.ID
             AND Inv.Empresa = @Empresa
	     AND Inv.Mov = @Mov
             AND Inv.MovID = @MovID
             AND mt.Modulo = @Modulo
             AND mt.Mov = @Mov
             AND Estatus = 'PENDIENTE'
             AND InvD.Articulo = @Articulo
             AND ISNULL(RTRIM(InvD.SubCuenta), '') = ISNULL(RTRIM(@SubCuenta), '')
--             AND InvD.Unidad = @MovUnidad
  ELSE
  IF @Modulo = 'PROD'
    DECLARE crBackOrder CURSOR
      FOR SELECT e.ID, Renglon, RenglonSub, d.RenglonID, ISNULL(d.CantidadOrdenada, 0.0), ISNULL(d.CantidadReservada, 0.0), ISNULL(d.CantidadPendiente, 0.0), d.Factor, d.Almacen, mt.Clave
            FROM ProdD d, Prod e, MovTipo mt
           WHERE d.ID = e.ID
             AND e.Empresa = @Empresa
	     AND e.Mov = @Mov
             AND e.MovID = @MovID
             AND mt.Modulo = @Modulo
             AND mt.Mov = @Mov
             AND Estatus = 'PENDIENTE'
             AND d.Articulo = @Articulo
             AND ISNULL(RTRIM(d.SubCuenta), '') = ISNULL(RTRIM(@SubCuenta), '')
--             AND d.Unidad = @MovUnidad


  OPEN crBackOrder
  FETCH NEXT FROM crBackOrder INTO @DID, @Renglon, @RenglonSub, @RenglonID, @CantidadOrdenada, @CantidadReservada, @CantidadPendiente, @FactorVenta, @AlmacenOrigen, @MovTipoOrigen
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @PendienteReal > 0.0 AND @Ok IS NULL 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @ObtenidoReal = 0.0, @CantidadPendienteReal = @CantidadPendiente*@FactorVenta,
             @CantidadReservadaReal = @CantidadReservada*@FactorVenta,
             @CantidadOrdenadaReal = @CantidadOrdenada*@FactorVenta

      IF @EsEntrada = 0 SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0

      IF @EsCancelacion = 0
      BEGIN
        IF @EsCargo = 0
        BEGIN
          IF @CantidadOrdenadaReal > 0.0 
            IF @CantidadOrdenadaReal > @PendienteReal SELECT @ObtenidoReal = -@PendienteReal ELSE SELECT @ObtenidoReal = -@CantidadOrdenadaReal
        END ELSE
        BEGIN
          IF @CantidadPendienteReal > 0.0 
            IF @CantidadPendienteReal > @PendienteReal SELECT @ObtenidoReal = @PendienteReal ELSE SELECT @ObtenidoReal = @CantidadPendienteReal
        END
      END ELSE
      BEGIN
        IF @EsCargo = 0
        BEGIN
          IF @CantidadReservadaReal > 0.0 
            IF @CantidadReservadaReal > @PendienteReal SELECT @ObtenidoReal = @PendienteReal ELSE SELECT @ObtenidoReal = @CantidadReservadaReal
        END ELSE
        BEGIN
          IF @CantidadOrdenadaReal > 0.0 
            IF @CantidadOrdenadaReal > @PendienteReal SELECT @ObtenidoReal = -@PendienteReal ELSE SELECT @ObtenidoReal = -@CantidadOrdenadaReal
        END
      END

      SELECT @Obtenido = ROUND(@ObtenidoReal/@FactorVenta, 4)
      IF @Obtenido <> 0.0
      BEGIN
        IF @EsEntrada = 1 AND @AlmacenOrigen = @Almacen
        BEGIN
          IF @EsCancelacion = 0 SELECT @ReservarEsCargo = 1 ELSE SELECT @ReservarEsCargo = 0
          SELECT @CantidadAReservar = -@Obtenido
	  SELECT @OrdenadoDif = -@CantidadAReservar
          IF @ReservarEsCargo = 1 SELECT @UltCantidad = @CantidadAReservar ELSE SELECT @UltCantidad = @CantidadAReservar
          IF @Modulo = 'VTAS' UPDATE VentaD SET CantidadOrdenada = NULLIF(ISNULL(CantidadOrdenada, 0.0) - @CantidadAReservar, 0.0), CantidadReservada = NULLIF(ISNULL(CantidadReservada, 0.0) + @CantidadAReservar, 0.0), UltimoReservadoCantidad = @UltCantidad, UltimoReservadoFecha = @UltFecha WHERE CURRENT OF crBackOrder ELSE
          IF @Modulo = 'INV'  UPDATE InvD   SET CantidadOrdenada = NULLIF(ISNULL(CantidadOrdenada, 0.0) - @CantidadAReservar, 0.0), CantidadReservada = NULLIF(ISNULL(CantidadReservada, 0.0) + @CantidadAReservar, 0.0), UltimoReservadoCantidad = @UltCantidad, UltimoReservadoFecha = @UltFecha WHERE CURRENT OF crBackOrder ELSE
          IF @Modulo = 'PROD' UPDATE ProdD  SET CantidadOrdenada = NULLIF(ISNULL(CantidadOrdenada, 0.0) - @CantidadAReservar, 0.0), CantidadReservada = NULLIF(ISNULL(CantidadReservada, 0.0) + @CantidadAReservar, 0.0), UltimoReservadoCantidad = @UltCantidad, UltimoReservadoFecha = @UltFecha WHERE CURRENT OF crBackOrder
          ELSE SELECT @Ok = 20650

          INSERT BackOrderLog (Empresa,  OModulo,  OID,  OMov,  OMovID,  DModulo,  DID, DMov, DMovID, Articulo,  SubCuenta,  Cantidad,  Unidad)
                       VALUES (@Empresa, @OModulo, @OID, @OMov, @OMovID, @Modulo, @DID, @Mov, @MovID, @Articulo, @SubCuenta, @Cantidad, @MovUnidad)

          SELECT @SucursalAlmacenOrigen = Sucursal FROM Alm WHERE Almacen = @AlmacenOrigen
          EXEC spSaldo @SucursalAlmacenOrigen, @Accion, @Empresa, @Usuario, 'RESV', @ArtMoneda, NULL, @Articulo, @SubCuenta, @AlmacenOrigen, NULL,
                       @Modulo, @DID, @Mov, @MovID, 1, NULL, @CantidadAReservar, @FactorVenta,
         	       @FechaAfectacion, @Ejercicio, @Periodo, NULL, NULL, 0, 0, 0,
	  	       @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID
          EXEC spArtR @Empresa, @Modulo, @Articulo, @SubCuenta, @AlmacenOrigen, @MovTipoOrigen, @FactorVenta, NULL, NULL, NULL, @OrdenadoDif, NULL, NULL
          EXEC xpInvReservado @DID, @Accion, NULL, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @Renglon, @RenglonSub,
	   	      	      @ReservarEsCargo, @CantidadAReservar, @FactorVenta, @Articulo, @SubCuenta, @FechaAfectacion, 
                              @Ok OUTPUT, @OkRef OUTPUT
        END ELSE 
        BEGIN
          IF @Modulo = 'VTAS' UPDATE VentaD SET CantidadOrdenada = NULLIF(ISNULL(CantidadOrdenada, 0.0) + @Obtenido, 0.0), CantidadPendiente = NULLIF(ROUND(ISNULL(CantidadPendiente, 0.0) - @Obtenido, 10), 0.0) WHERE CURRENT OF crBackOrder ELSE
          IF @Modulo = 'INV'  UPDATE InvD   SET CantidadOrdenada = NULLIF(ISNULL(CantidadOrdenada, 0.0) + @Obtenido, 0.0), CantidadPendiente = NULLIF(ROUND(ISNULL(CantidadPendiente, 0.0) - @Obtenido, 10), 0.0) WHERE CURRENT OF crBackOrder ELSE
          IF @Modulo = 'PROD' UPDATE ProdD  SET CantidadOrdenada = NULLIF(ISNULL(CantidadOrdenada, 0.0) + @Obtenido, 0.0), CantidadPendiente = NULLIF(ROUND(ISNULL(CantidadPendiente, 0.0) - @Obtenido, 10), 0.0) WHERE CURRENT OF crBackOrder
          ELSE SELECT @Ok = 20650

	  SELECT @PendienteDif = -@Obtenido, @OrdenadoDif = @Obtenido
          EXEC spArtR @Empresa, @Modulo, @Articulo, @SubCuenta, @AlmacenOrigen, @MovTipoOrigen, @FactorVenta, @PendienteDif, NULL, NULL, @OrdenadoDif, NULL, NULL
        END

        SELECT @PendienteReal = @PendienteReal - ABS(@ObtenidoReal)
      END
    END
    IF @PendienteReal > 0.0 AND @Ok IS NULL
    BEGIN
      FETCH NEXT FROM crBackOrder INTO @DID, @Renglon, @RenglonSub, @RenglonID, @CantidadOrdenada, @CantidadReservada, @CantidadPendiente, @FactorVenta, @AlmacenOrigen, @MovTipoOrigen
      IF @@ERROR <> 0 SELECT @Ok = 1
    END
  END
  CLOSE crBackOrder
  DEALLOCATE crBackOrder

  IF ROUND(@PendienteReal, 0) > 0.0 AND @EsEntrada = 0 AND @EsCancelacion = 0 SELECT @Ok = 20350, @OkRef = RTRIM(@Articulo)+'/'+RTRIM(@Mov)+' '+RTRIM(@MovID)
  RETURN
END
GO


/**************** spInvBackOrderCliente ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvBackOrderCliente') and type = 'P') drop procedure dbo.spInvBackOrderCliente
GO
CREATE PROCEDURE spInvBackOrderCliente
			@Sucursal		int,
			@Empresa		char(5),
			@Usuario		char(10),
			@Cliente		char(10),
			@Articulo		char(20),
			@SubCuenta		varchar(50),
			@Cantidad		float,
			@FactorCompra		float,
			@ArtMoneda		char(10),
			@Almacen		char(10),
			@FechaAfectacion	datetime, 
			@FechaRegistro		datetime,
			@Ejercicio		int, 
			@Periodo		int,

                        @Ok 			int	     	OUTPUT,
		   	@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
     @ID			int,
     @Mov			char(20),
     @MovID			varchar(20),
     @MovTipo			char(20),
     @Renglon			float,
     @RenglonSub		int,
     @RenglonID			int,
     @EsCargo			bit,
     @PendienteReal		float,
     @ObtenidoReal		float,
     @PendienteDif 		float,
     @NuevoPendiente		float,
     @CantidadPendiente		float,
     @CantidadPendienteReal 	float,
     @CantidadReservada 	float,
     @CantidadAReservar 	float,
     @FactorVenta		float,
     @UltCantidad		float,
     @UltFecha			datetime,
     @SucursalAlmacen		INT,
     @ArtTipo				varchar(20)

  SELECT @ArtTipo = Tipo FROM Art WHERE Articulo = @Articulo
  IF @ArtTipo = 'Servicio'
  BEGIN
    SELECT @OK = 20975, @OkRef = RTRIM(@Articulo)
    RETURN	
  END

  SELECT @PendienteReal = @Cantidad*@FactorCompra, @EsCargo = 1, @UltFecha = @FechaRegistro
  EXEC spExtraerFecha @UltFecha OUTPUT

  DECLARE crBackOrderCte CURSOR
    FOR SELECT Venta.ID, Venta.Mov, Venta.MovID, Renglon, RenglonSub, VentaD.RenglonID, ISNULL(CantidadReservada, 0.0), ISNULL(CantidadPendiente, 0.0), ISNULL(NULLIF(VentaD.Factor, 0.0), 1.0), mt.Clave
          FROM VentaD
          JOIN Venta ON VentaD.ID = Venta.ID
          JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
         WHERE Venta.Cliente = @Cliente
           AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX')
           AND Estatus = 'PENDIENTE'
           AND VentaD.Articulo = @Articulo
           AND VentaD.SubCuenta = @SubCuenta
           AND ISNULL(CantidadPendiente, 0.0) > 0.0
           AND VentaD.Almacen = @Almacen
         ORDER BY Venta.FechaRequerida, Venta.FechaEmision

  OPEN crBackOrderCte
  FETCH NEXT FROM crBackOrderCte INTO @ID, @Mov, @MovID, @Renglon, @RenglonSub, @RenglonID, @CantidadReservada, @CantidadPendiente, @FactorVenta, @MovTipo
  WHILE @@FETCH_STATUS <> -1 AND @PendienteReal > 0.0 AND @Ok IS NULL 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @ObtenidoReal = 0.0, @CantidadPendienteReal = @CantidadPendiente*@FactorVenta
      IF @CantidadPendienteReal > @PendienteReal SELECT @ObtenidoReal = @PendienteReal ELSE SELECT @ObtenidoReal = @CantidadPendienteReal

      SELECT @CantidadAReservar = FLOOR(@ObtenidoReal/@FactorVenta)
      IF @CantidadAReservar <> 0.0
      BEGIN
        IF @EsCargo = 1 SELECT @UltCantidad = @CantidadAReservar ELSE SELECT @UltCantidad = -@CantidadAReservar
        UPDATE VentaD
           SET CantidadPendiente = NULLIF(ISNULL(CantidadPendiente, 0.0) - @CantidadAReservar, 0.0), CantidadReservada = NULLIF(ISNULL(CantidadReservada, 0.0) + @CantidadAReservar, 0.0),
               UltimoReservadoCantidad = @UltCantidad, UltimoReservadoFecha = @UltFecha
         WHERE CURRENT OF crBackOrderCte

        SELECT @NuevoPendiente = CantidadPendiente FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

        SELECT @SucursalAlmacen = Sucursal FROM Alm WHERE Almacen = @Almacen
        EXEC spSaldo @SucursalAlmacen, 'AFECTAR', @Empresa, @Usuario, 'RESV', @ArtMoneda, NULL, @Articulo, @SubCuenta, @Almacen, NULL,
                     'VTAS', @ID, @Mov, @MovID, 1, NULL, @CantidadAReservar, @FactorVenta,
          	     @FechaAfectacion, @Ejercicio, @Periodo, NULL, NULL, 0, 0, 0,
	  	     @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID
        EXEC spArtR @Empresa, 'VTAS', @Articulo, @SubCuenta, @Almacen, @MovTipo, @FactorVenta, NULL, @CantidadPendiente, @NuevoPendiente, NULL, NULL, NULL
        EXEC xpInvReservado @ID, 'AFECTAR', NULL, @Empresa, @Usuario, 'VTAS', @Mov, @MovID, @Renglon, @RenglonSub,
          	      	    @EsCargo, @CantidadAReservar, @FactorVenta, @Articulo, @SubCuenta, @FechaAfectacion, 
                            @Ok OUTPUT, @OkRef OUTPUT

        SELECT @PendienteReal = @PendienteReal - ABS(@ObtenidoReal)
      END
    END
    IF @PendienteReal > 0.0 AND @Ok IS NULL
      FETCH NEXT FROM crBackOrderCte INTO @ID, @Mov, @MovID, @Renglon, @RenglonSub, @RenglonID, @CantidadReservada, @CantidadPendiente, @FactorVenta, @MovTipo
  END
  CLOSE crBackOrderCte
  DEALLOCATE crBackOrderCte
  RETURN
END
GO



/**************** spInvAsignarRenglon ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvAsignarRenglon') and type = 'P') drop procedure dbo.spInvAsignarRenglon
GO             
CREATE PROCEDURE spInvAsignarRenglon
		   @Sucursal		int,
                   @Accion		char(20),
		   @Modulo		char(5),
    		   @ID                	int,
		   @Renglon		float,
	           @RenglonSub		int,
		   @DestinoModulo	char(5),
                   @Destino		char(20),
                   @DestinoID		varchar(20),
	           @Cantidad		float,

		   @Ok			int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  IF @Modulo = 'COMS'
  BEGIN
    SELECT * INTO #CompraDetalle FROM cCompraD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
    IF @@ERROR <> 0 SELECT @Ok = 1
    SELECT @Renglon = MAX(Renglon) + 2048 FROM CompraD WHERE ID = @ID 

    IF @Accion = 'DESASIGNAR' SELECT @DestinoModulo = NULL, @Destino = NULL, @DestinoID = NULL
    UPDATE #CompraDetalle SET Sucursal = @Sucursal, Renglon = @Renglon, RenglonSub = 1, CantidadPendiente = @Cantidad, CantidadA = NULL, CantidadCancelada = NULL, DestinoTipo = @DestinoModulo, Destino = @Destino, DestinoID = @DestinoID, Cantidad = @Cantidad, AplicaRenglon = @Renglon
    IF @@ERROR <> 0 SELECT @Ok = 1

    INSERT INTO cCompraD SELECT * FROM #CompraDetalle
    IF @@ERROR <> 0 SELECT @Ok = 1
  END ELSE
  IF @Modulo = 'PROD'
  BEGIN
    SELECT * INTO #ProdDetalle FROM cProdD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
    IF @@ERROR <> 0 SELECT @Ok = 1
    SELECT @Renglon = MAX(Renglon) + 2048 FROM ProdD WHERE ID = @ID 

    IF @Accion = 'DESASIGNAR' SELECT @DestinoModulo = NULL, @Destino = NULL, @DestinoID = NULL
    UPDATE #ProdDetalle SET Sucursal = @Sucursal, Renglon = @Renglon, RenglonSub = 1, CantidadPendiente = @Cantidad, CantidadA = NULL, CantidadCancelada = NULL, DestinoTipo = @DestinoModulo, Destino = @Destino, DestinoID = @DestinoID, Cantidad = @Cantidad
    IF @@ERROR <> 0 SELECT @Ok = 1

    INSERT INTO cProdD SELECT * FROM #ProdDetalle
    IF @@ERROR <> 0 SELECT @Ok = 1
  END 
END
GO

/**************** spInvCostearTransferencias ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvCostearTransferencias') and type = 'P') drop procedure dbo.spInvCostearTransferencias
GO
CREATE PROCEDURE spInvCostearTransferencias
				@Modulo		varchar(5),
				@ID			int,
				@MovTipo	varchar(20)

--//WITH ENCRYPTION
AS BEGIN
  IF @MovTipo <> 'INV.T' RETURN
  
  DECLARE
    @AuxiliarID	  int,
    @Empresa	  char(5),
    @Rama		  char(5),
    @Moneda		  char(10),
    @Grupo		  char(10),
    @Cuenta		  char(20),
    @SubCuenta	  varchar(50),
    @Ejercicio	  int,
    @Periodo	  int,
    @CargoU		  float,
    @AbonoU		  float,
    @Sucursal	  int,
    @SubGrupo	  varchar(20),
    @Costo		  float,

	@WMSAuxiliar  bit -- TASK1964

  SELECT @WMSAuxiliar = WMSAuxiliar FROM Version -- TASK1964

  DECLARE crInvCostearTransferencias CURSOR FOR
  SELECT u.ID, u.Empresa, u.Rama, u.Moneda, u.Grupo, u.Cuenta, ISNULL(u.SubCuenta, ''), u.Ejercicio, u.Periodo, ISNULL(u.CargoU, 0), ISNULL(u.AbonoU, 0), u.Sucursal, ISNULL(u.SubGrupo, ''), ISNULL(d.Costo/d.Factor, 0)
    FROM InvD d
    JOIN AuxiliarU u ON u.Modulo = @Modulo AND u.ModuloID = d.ID AND u.Renglon = d.Renglon AND u.RenglonSub = d.RenglonSub
   WHERE d.ID = @ID AND ((u.CargoU IS NOT NULL AND u.Cargo IS NULL) OR (u.AbonoU IS NOT NULL AND u.Abono IS NULL))
  OPEN crInvCostearTransferencias
  FETCH NEXT FROM crInvCostearTransferencias INTO @AuxiliarID, @Empresa, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, @Ejercicio, @Periodo, @CargoU, @AbonoU, @Sucursal, @SubGrupo, @Costo
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @CargoU <> 0
    BEGIN
      IF @WMSAuxiliar = 1 -- TASK1964
      BEGIN
        IF @SubGrupo <> '' -- TASK1964
        BEGIN -- TASK1964
          UPDATE SaldoUWMS WITH (ROWLOCK) SET Saldo = ISNULL(Saldo,0.0) + (@CargoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo

          UPDATE AcumUWMS WITH (ROWLOCK) SET Cargos = ISNULL(Cargos,0.0) + (@CargoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Ejercicio = @Ejercicio AND Periodo = @Periodo AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo

          UPDATE AuxiliarUWMS SET Cargo = @CargoU*@Costo
           WHERE ID = @AuxiliarID
        END ELSE BEGIN -- TASK1964
          UPDATE SaldoU WITH (ROWLOCK) SET Saldo = ISNULL(Saldo,0.0) + (@CargoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo

          UPDATE AcumU WITH (ROWLOCK) SET Cargos = ISNULL(Cargos,0.0) + (@CargoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Ejercicio = @Ejercicio AND Periodo = @Periodo AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo

          UPDATE AuxiliarU SET Cargo = @CargoU*@Costo
           WHERE ID = @AuxiliarID
        END -- TASK1964
      END ELSE BEGIN -- TASK1964  
	    EXEC dbo.sp_executesql N'
		  UPDATE SaldoU WITH (ROWLOCK) SET Saldo = ISNULL(Saldo,0.0) + (@CargoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo

          UPDATE AcumU WITH (ROWLOCK) SET Cargos = ISNULL(Cargos,0.0) + (@CargoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Ejercicio = @Ejercicio AND Periodo = @Periodo AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo

          UPDATE AuxiliarU SET Cargo = @CargoU*@Costo
           WHERE ID = @AuxiliarID',
		  N'@CargoU float, @Costo float, @Sucursal int, @Empresa varchar(5), @Rama varchar(5), @Moneda varchar(20), @Grupo varchar(20), @Cuenta varchar(20), @SubCuenta varchar(50),
		    @SubGrupo varchar(20), @Ejercicio int, @Periodo int, @AuxiliarID int',
		  @CargoU, @Costo, @Sucursal, @Empresa, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, @SubGrupo, @Ejercicio, @Periodo, @AuxiliarID
      END -- TASK1964
    END

    IF @AbonoU <> 0
    BEGIN
      IF @WMSAuxiliar = 1 -- TASK1964
      BEGIN
        IF @SubGrupo <> '' -- TASK1964
        BEGIN -- TASK1964
          UPDATE SaldoUWMS WITH (ROWLOCK) SET Saldo = ISNULL(Saldo,0.0) - (@AbonoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo

          UPDATE AcumUWMS WITH (ROWLOCK)SET Abonos = ISNULL(Abonos,0.0) + (@AbonoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Ejercicio = @Ejercicio AND Periodo = @Periodo AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo
      
          UPDATE AuxiliarUWMS SET Abono = @AbonoU*@Costo
           WHERE ID = @AuxiliarID
        END ELSE BEGIN -- TASK1964
          UPDATE SaldoU WITH (ROWLOCK) SET Saldo = ISNULL(Saldo,0.0) - (@AbonoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo

          UPDATE AcumU WITH (ROWLOCK)SET Abonos = ISNULL(Abonos,0.0) + (@AbonoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Ejercicio = @Ejercicio AND Periodo = @Periodo AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo
      
          UPDATE AuxiliarU SET Abono = @AbonoU*@Costo
           WHERE ID = @AuxiliarID
        END -- TASK1964
      END ELSE BEGIN -- TASK1964
	    EXEC dbo.sp_executesql N'
          UPDATE SaldoU WITH (ROWLOCK) SET Saldo = ISNULL(Saldo,0.0) - (@AbonoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo

          UPDATE AcumU  WITH (ROWLOCK)SET Abonos = ISNULL(Abonos,0.0) + (@AbonoU*@Costo)
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Ejercicio = @Ejercicio AND Periodo = @Periodo AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(SubGrupo, '') = @SubGrupo
      
          UPDATE AuxiliarU SET Abono = @AbonoU*@Costo
           WHERE ID = @AuxiliarID',
		  N'@AbonoU float, @Costo float, @Sucursal int, @Empresa varchar(5), @Rama varchar(5), @Moneda varchar(20), @Grupo varchar(20), @Cuenta varchar(20), @SubCuenta varchar(50),
		    @SubGrupo varchar(20), @Ejercicio int, @Periodo int, @AuxiliarID int',
		  @AbonoU, @Costo, @Sucursal, @Empresa, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, @SubGrupo, @Ejercicio, @Periodo, @AuxiliarID
      END -- TASK1964
    END

    FETCH NEXT FROM crInvCostearTransferencias INTO @AuxiliarID, @Empresa, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, @Ejercicio, @Periodo, @CargoU, @AbonoU, @Sucursal, @SubGrupo, @Costo
  END

  CLOSE crInvCostearTransferencias
  DEALLOCATE crInvCostearTransferencias

  RETURN  
END
GO

/**************** spInvAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvAsignar') and type = 'P') drop procedure dbo.spInvAsignar
GO
CREATE PROCEDURE spInvAsignar
			@Sucursal		int,
		  	@Accion			char(20), 
			@Empresa		char(5),
    		   	@Modulo			varchar(10),
			@ID			int,
    		   	@Mov			varchar(20),
    		   	@MovID			varchar(20),
			@Almacen		char(10),
			@Articulo		char(20),
			@SubCuenta		varchar(50),
			@MovUnidad		varchar(50),
			@Cantidad		float		OUTPUT,
                        @Ok 			int	     	OUTPUT,
		   	@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
     @DID		int,
     @DRenglon		float,
     @DRenglonSub	int,
     @Pendiente		float,
     @Obtenido		float,
     @CantidadPendiente	float,
     @SeCompra		bit,
     @SeProduce		bit,
     @ProdID		int

  SELECT @Pendiente = @Cantidad, @DID = NULL, @ProdID = NULL
  SELECT @SeCompra = SeCompra, @SeProduce = SeProduce FROM Art WHERE Articulo = @Articulo
  EXEC xpGetVentaProdID @ID, @ProdID OUTPUT

  IF @SeCompra = 1 OR @SeProduce = 0
  BEGIN
    IF @Accion = 'ASIGNAR'
      DECLARE crCompraD CURSOR
        FOR SELECT CompraD.ID, Renglon, RenglonSub, CantidadPendiente
              FROM CompraD, Compra
             WHERE CompraD.ID = Compra.ID
               AND Compra.Empresa = @Empresa
               AND Estatus = 'PENDIENTE'
               AND CompraD.Articulo = @Articulo
               AND ISNULL(CompraD.SubCuenta, '') = ISNULL(@SubCuenta, '')
	       AND CompraD.Unidad = @MovUnidad
               AND CompraD.Almacen = @Almacen
               AND NULLIF(RTRIM(CompraD.Destino), '') IS NULL 
               AND NULLIF(CompraD.DestinoID, 0) IS NULL
               AND ISNULL(CantidadPendiente, 0.0) > 0.0
    ELSE
    IF @Accion = 'DESASIGNAR'
      DECLARE crCompraD CURSOR
        FOR SELECT CompraD.ID, Renglon, RenglonSub, CantidadPendiente
              FROM CompraD, Compra
             WHERE CompraD.ID = Compra.ID
               AND Compra.Empresa = @Empresa
               AND Estatus = 'PENDIENTE'
               AND CompraD.Articulo = @Articulo
               AND ISNULL(CompraD.SubCuenta, '') = ISNULL(@SubCuenta, '')
  	       AND CompraD.Unidad = @MovUnidad
               AND CompraD.Almacen = @Almacen
               AND CompraD.DestinoTipo = @Modulo
               AND CompraD.Destino = @Mov
               AND CompraD.DestinoID = @MovID
               AND ISNULL(CantidadPendiente, 0.0) > 0.0

    OPEN crCompraD
    FETCH NEXT FROM crCompraD INTO @DID, @DRenglon, @DRenglonSub, @CantidadPendiente
    IF @@ERROR <> 0 SELECT @Ok = 1
    WHILE @@FETCH_STATUS <> -1 AND @Pendiente > 0.0 AND @Ok IS NULL 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Obtenido = 0.0
        IF @CantidadPendiente > @Pendiente SELECT @Obtenido = @Pendiente ELSE SELECT @Obtenido = @CantidadPendiente

        IF @Obtenido > 0.0
        BEGIN
          EXEC spInvAsignarRenglon @Sucursal, @Accion, 'COMS', @DID, @DRenglon, @DRenglonSub, @Modulo, @Mov, @MovID, @Obtenido, @Ok OUTPUT
          UPDATE CompraD 
             SET Cantidad          = NULLIF(Cantidad - @Obtenido, 0.0), 
                 CantidadPendiente = NULLIF(CantidadPendiente-@Obtenido, 0.0), 
                 CantidadA         = NULL 
           WHERE CURRENT OF crCompraD
          SELECT @Pendiente = @Pendiente - @Obtenido
        END
      END
      IF @Pendiente > 0.0 AND @Ok IS NULL
      BEGIN
        FETCH NEXT FROM crCompraD INTO @DID, @DRenglon, @DRenglonSub, @CantidadPendiente
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END
    CLOSE crCompraD
    DEALLOCATE crCompraD

    SELECT @Cantidad = @Cantidad - @Pendiente
    IF @Accion = 'ASIGNAR' AND @DID IS NOT NULL
      UPDATE Compra SET VerDestino = 1 WHERE ID = @DID AND VerDestino = 0
  END

  IF @SeProduce = 1 AND @Cantidad > 0.0
  BEGIN
    IF @Accion = 'ASIGNAR'
      DECLARE crProdD CURSOR
        FOR SELECT ProdD.ID, Renglon, RenglonSub, CantidadPendiente
              FROM ProdD, Prod
             WHERE ProdD.ID = Prod.ID
               AND Prod.Empresa = @Empresa
               AND Estatus = 'PENDIENTE'
               AND ProdD.Articulo = @Articulo
               AND ISNULL(ProdD.SubCuenta, '') = ISNULL(@SubCuenta, '')
	       AND ProdD.Unidad = @MovUnidad
               AND ProdD.Almacen = @Almacen
               AND NULLIF(RTRIM(ProdD.Destino), '') IS NULL 
               AND NULLIF(RTRIM(ProdD.DestinoID), '') IS NULL
               AND ISNULL(CantidadPendiente, 0.0) > 0.0
               AND ISNULL(@ProdID, Prod.ID) = Prod.ID
    ELSE
    IF @Accion = 'DESASIGNAR'
      DECLARE crProdD CURSOR
        FOR SELECT ProdD.ID, Renglon, RenglonSub, CantidadPendiente
              FROM ProdD, Prod
             WHERE ProdD.ID = Prod.ID
               AND Prod.Empresa = @Empresa
               AND Estatus = 'PENDIENTE'
               AND ProdD.Articulo = @Articulo
               AND ISNULL(ProdD.SubCuenta, '') = ISNULL(@SubCuenta, '')
  	       AND ProdD.Unidad = @MovUnidad
               AND ProdD.Almacen = @Almacen
               AND ProdD.DestinoTipo = @Modulo
               AND ProdD.Destino = @Mov
               AND ProdD.DestinoID = @MovID
               AND ISNULL(CantidadPendiente, 0.0) > 0.0
               AND ISNULL(@ProdID, Prod.ID) = Prod.ID

    OPEN crProdD
    FETCH NEXT FROM crProdD INTO @DID, @DRenglon, @DRenglonSub, @CantidadPendiente
    IF @@ERROR <> 0 SELECT @Ok = 1
    WHILE @@FETCH_STATUS <> -1 AND @Pendiente > 0.0 AND @Ok IS NULL 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Obtenido = 0.0
        IF @CantidadPendiente > @Pendiente SELECT @Obtenido = @Pendiente ELSE SELECT @Obtenido = @CantidadPendiente

        IF @Obtenido > 0.0
        BEGIN
          EXEC spInvAsignarRenglon @Sucursal, @Accion, 'PROD', @DID, @DRenglon, @DRenglonSub, @Modulo, @Mov, @MovID, @Obtenido, @Ok OUTPUT
          UPDATE ProdD 
             SET Cantidad          = NULLIF(Cantidad - @Obtenido, 0.0), 
                 CantidadPendiente = NULLIF(CantidadPendiente-@Obtenido, 0.0), 
                 CantidadA         = NULL 
           WHERE CURRENT OF crProdD
          SELECT @Pendiente = @Pendiente - @Obtenido
        END
      END
      IF @Pendiente > 0.0 AND @Ok IS NULL
      BEGIN
        FETCH NEXT FROM crProdD INTO @DID, @DRenglon, @DRenglonSub, @CantidadPendiente
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END
    CLOSE crProdD
    DEALLOCATE crProdD

    SELECT @Cantidad = @Cantidad - @Pendiente
    IF @Accion = 'ASIGNAR' AND @DID IS NOT NULL
      UPDATE Prod SET VerDestino = 1 WHERE ID = @DID AND VerDestino = 0
  END

  RETURN
END
GO

/**************** spInvMatar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvMatar') and type = 'P') drop procedure dbo.spInvMatar
GO
CREATE PROCEDURE spInvMatar
			@Sucursal		int,
			@ID			int,
		  	@Accion			char(20), 
			@Base			char(20),
			@Empresa		char(5), 
			@Usuario		char(10),
			@Modulo			char(5), 
			@Mov			char(20),
			@MovID			varchar(20),
			@MovTipo		char(20),
			@Estatus		char(15),
			@EstatusNuevo		char(15),
			@FechaEmision		datetime,
			@FechaRegistro		datetime, 
			@FechaAfectacion	datetime,
			@Ejercicio		int, 
			@Periodo		int,
			@AfectarConsignacion	bit,
			@AlmacenTipo		char(15),
			@AlmacenDestinoTipo	char(15),

			@CfgVentaSurtirDemas	bit,
			@CfgCompraRecibirDemas	bit,
			@CfgTransferirDemas	bit,
			@CfgBackOrders		bit,
		   	@CfgContX		bit,
		   	@CfgContXGenerar	char(20),
		   	@CfgEmbarcar		bit,
			@CfgImpInc		bit,
			@CfgMultiUnidades	bit,
		        @CfgMultiUnidadesNivel	char(20),

                        @Ok 			int	     OUTPUT,
    		   	@OkRef          	varchar(255) OUTPUT,
			@CfgPrecioMoneda	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Requiere			float,
    @Obtenido			float,
    @ReservadoObtenido		float,
    @PendienteObtenido		float,
    @PendienteDif		float,
    @NuevoPendiente     	float,
    @Cantidad			float,
    @MermaDesp			float,
    @CantidadA			float, 
    @CantidadOriginal		float, 
    @CantidadInventario		float,
    @CantidadReservada		float, 
    @CantidadPendiente		float, 
    @CantidadOrdenada		float,
    @Renglon			float,
    @RenglonSub			int,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @AlmacenOrigen		char(10),
    @AlmacenBackOrders		char(10),
    @Articulo			char(20), 
    @ArticuloOriginal		char(20),
    @SubCuentaOriginal		varchar(50),
    @SustitutoArticulo		varchar(20),
    @SustitutoSubCuenta		varchar(50),
    @ArtTipo			char(20),
    @ArtUnidad			varchar(50),
    @ArtMoneda			char(10),
    @SubCuenta			varchar(50), 
    @ProdSerieLote		varchar(50),
    @Espacio			varchar(10),
    @Centro			varchar(10),
    @CentroDestino		varchar(10),
    @AplicaMov			char(20), 
    @AplicaMovTipo		char(20),
    @AplicaTipoCambio		float,
    @AplicaEstatus		char(15),
    @AplicaEstatusNuevo		char(15),
    @AplicaFechaConclusion	datetime,
    @Llave			int,
    @AplicaMovID		varchar(20),
    @IDAplica			int,
    @UltID			int,
    @DescuentoGlobal		float,
    @SobrePrecio		float,
    @CantidadCalcularImporte	float,
    @Precio	         	float,
    @PrecioTipoCambio		float,
    @DescuentoTipo	 	char(1),
    @DescuentoLinea	 	float,
    @Impuesto1		 	float,
    @Impuesto2		 	float,
    @Impuesto3		 	money,
    @Impuesto5		 	money,
    @Importe 			money, 
    @ImporteNeto		money, 
    @Impuestos 			money,
    @ImpuestosNetos		money,
    @Impuesto1Neto		money,
    @Impuesto2Neto		money,
    @Impuesto3Neto		money,
    @Impuesto5Neto		money,
    @DescuentoLineaImporte 	money, 
    @DescuentoGlobalImporte 	money, 
    @SobrePrecioImporte 	money, 
    @SumaImporteNeto		money,
    @SumaImpuestos		money,
    @SumaImpuestosNetos		money,
    @SumaImpuesto1Neto		money,
    @SumaImpuesto2Neto		money,
    @SumaImpuesto3Neto		money,
    @SumaPendiente		float,
    @ImporteMatar		money,
    @SucursalAlmacenOrigen	int,
    @Rama			char(5),
    @MovUnidad			varchar(50),
    @Factor			float,
    @QuedaPendiente		bit,
    @SinMatar			bit,
    @EsCargo			bit,
    @EsEntrada			bit,
    @EsSalida			bit, 
    @AfectarPiezas		bit,
    @AfectarCostos		bit,
    @AfectarUnidades		bit,
    @DestinoTipo	  	varchar(10),
    @Destino			varchar(20),
    @DestinoID			varchar(20),
    @ContratoEstatusNuevo	char(15),
    @Cliente			char(10),
    @DetalleTipo		varchar(20),
/*    @AplicaAplica		char(20),
    @AplicaAplicaID		int,*/
    @Cancelar			bit,
    @Redondeo			int,
    @Existe			bit,
    @SinAlmacen			bit,
    @Retencion1			float, 
    @Retencion2			float, 
    @Retencion3			float,
    
    -- 9319
    @FechaAplica		datetime,  
	@EjercicioAplica	int,
	@PeriodoAplica		int,
    @AplicaRenglon		float

  SELECT @SinAlmacen = 0
  SELECT @Redondeo = ISNULL(DecimalesCantidadPendiente, 2)
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  DECLARE @AMatar TABLE (
    Llave			int		NOT NULL IDENTITY (1,1),
    ID	        	int	        NULL,
    MovTipo			char(20)	COLLATE Database_Default NULL,
    Almacen			char(10)	COLLATE Database_Default NULL,
    Articulo		char(20)	COLLATE Database_Default NULL,
    SubCuenta		varchar(50)	COLLATE Database_Default NULL,
    Unidad			varchar(50)	COLLATE Database_Default NULL,
    Espacio			varchar(10)	COLLATE Database_Default NULL,  
    Centro			varchar(10)	COLLATE Database_Default NULL,
    CentroDestino	varchar(10)	COLLATE Database_Default NULL,
    Cliente			varchar(10)	COLLATE Database_Default NULL,
    ProdSerieLote	varchar(50)	COLLATE Database_Default NULL,
    Cantidad		float		NULL,
	AplicaRenglon	float		NULL)
		
  IF @@ERROR <> 0 SELECT @Ok = 1

  DECLARE @MatarIndice TABLE (
    ID 		 		int 		NULL, 
    Estatus			char(15)	COLLATE Database_Default NULL,
    Mov				char(20)	COLLATE Database_Default NULL,
    MovID			varchar(20)	COLLATE Database_Default NULL,
    MovTipo			char(20)	COLLATE Database_Default NULL,
    TipoCambio		float		NULL,
    Almacen			char(10)	COLLATE Database_Default NULL,
    DescuentoGlobal	float		NULL,
    SobrePrecio		float		NULL,
    Importe			money		NULL)
  IF @@ERROR <> 0 SELECT @Ok = 1

  DECLARE @MatarDetalle TABLE (
    ID	        	int	        NULL,
    Renglon			float		NULL,
    RenglonSub		int			NULL,
    Reservado		float		NULL,
    Pendiente		float		NULL,
    MovTipo			char(20)	COLLATE Database_Default NULL,
    Almacen			char(10)	COLLATE Database_Default NULL,
    Articulo		char(20)	COLLATE Database_Default NULL,
    SubCuenta		varchar(50)	COLLATE Database_Default NULL,
    Factor			float		NULL,
	AplicaRenglon	float		NULL)

  IF @@ERROR <> 0 SELECT @Ok = 1

  IF @Accion = 'CANCELAR' SELECT @Cancelar = 1 ELSE SELECT @Cancelar = 0

  IF @Modulo = 'VTAS'
    DECLARE crMatarMov CURSOR
      FOR SELECT Venta.ID, Venta.Estatus, Venta.Mov, Venta.MovID, Venta.TipoCambio, VentaD.Almacen, Venta.DescuentoGlobal, Venta.SobrePrecio, MovTipo.Clave, sum(ISNULL(Cantidad, 0.0)), 0.0, sum(ISNULL(CantidadInventario, 0.0)), sum(ISNULL(CantidadReservada, 0.0)), sum(ISNULL(CantidadOrdenada, 0.0)), sum(ISNULL(CantidadPendiente, 0.0)), sum(ISNULL(CantidadA, 0.0)), CONVERT(char, NULL), VentaD.Articulo, NULLIF(RTRIM(Subcuenta), ''), NULLIF(RTRIM(SustitutoArticulo), ''), NULLIF(RTRIM(SustitutoSubCuenta), ''), NULLIF(RTRIM(VentaD.Unidad), ''), VentaD.Factor, NULLIF(RTRIM(UPPER(Art.Tipo)), ''), Art.Unidad, RenglonTipo, CONVERT(char, NULL), VentaD.Espacio, CONVERT(varchar, NULL), CONVERT(varchar, NULL), CONVERT(varchar, NULL), VentaD.AplicaRenglon
            FROM VentaD, Venta, MovTipo, Art
           WHERE VentaD.ID = @ID
             AND Venta.Empresa = @Empresa
	     AND Venta.Mov = Aplica 
             AND Venta.MovID = AplicaID	
             AND Venta.Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CANCELADO')
             AND MovTipo.Modulo = 'VTAS'
	     AND MovTipo.Mov = Aplica
             AND Art.Articulo = VentaD.Articulo
             AND Aplica IS NOT NULL
             AND AplicaID IS NOT NULL
           GROUP BY Venta.ID, Venta.Estatus, Venta.Mov, Venta.MovID, Venta.TipoCambio, VentaD.Almacen, Venta.DescuentoGlobal, Venta.SobrePrecio, MovTipo.Clave, VentaD.Articulo, SubCuenta, SustitutoArticulo, SustitutoSubCuenta, VentaD.Unidad, VentaD.Factor, Art.Tipo, Art.Unidad, RenglonTipo, VentaD.Espacio, VentaD.AplicaRenglon
           ORDER BY Venta.ID, Venta.Estatus, Venta.Mov, Venta.MovID, Venta.TipoCambio, VentaD.Almacen, Venta.DescuentoGlobal, Venta.SobrePrecio, MovTipo.Clave, VentaD.Articulo, SubCuenta, SustitutoArticulo, SustitutoSubCuenta, VentaD.Unidad, VentaD.Factor, Art.Tipo, Art.Unidad, RenglonTipo, VentaD.Espacio, VentaD.AplicaRenglon
  ELSE
  IF @Modulo = 'COMS'
    DECLARE crMatarMov CURSOR
      FOR SELECT Compra.ID, Compra.Estatus, Compra.Mov, Compra.MovID, Compra.TipoCambio, CompraD.Almacen, Compra.DescuentoGlobal, 0.0, MovTipo.Clave, sum(ISNULL(Cantidad, 0.0)), 0.0, sum(ISNULL(CantidadInventario, 0.0)), sum(ISNULL(Cantidad, 0.0)), sum(ISNULL(Cantidad, 0.0)), sum(ISNULL(CantidadPendiente, 0.0)), sum(ISNULL(CantidadA, 0.0)), CONVERT(char, NULL), CompraD.Articulo, NULLIF(RTRIM(Subcuenta), ''), convert(char(20), NULL), convert(char(20), NULL), NULLIF(RTRIM(CompraD.Unidad), ''), CompraD.Factor, NULLIF(RTRIM(UPPER(Art.Tipo)), ''), Art.Unidad, RenglonTipo, CONVERT(char, NULL), CONVERT(varchar, NULL), CONVERT(varchar, NULL), CONVERT(varchar, NULL), CompraD.Cliente, CompraD.AplicaRenglon
            FROM CompraD, Compra, MovTipo, Art
           WHERE CompraD.ID = @ID
             AND Compra.Empresa = @Empresa
	     AND Compra.Mov = Aplica 
             AND Compra.MovID = AplicaID
             AND Compra.Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CANCELADO')
             AND MovTipo.Modulo = 'COMS'
	     AND MovTipo.Mov = Aplica
             AND Art.Articulo = CompraD.Articulo
             AND Aplica IS NOT NULL
             AND AplicaID IS NOT NULL
           GROUP BY Compra.ID, Compra.Estatus, Compra.Mov, Compra.MovID, Compra.TipoCambio, CompraD.Almacen, Compra.DescuentoGlobal, MovTipo.Clave, CompraD.Articulo, SubCuenta, CompraD.Unidad, CompraD.Factor, Art.Tipo, Art.Unidad, RenglonTipo, CompraD.Cliente, CompraD.AplicaRenglon
           ORDER BY Compra.ID, Compra.Estatus, Compra.Mov, Compra.MovID, Compra.TipoCambio, CompraD.Almacen, Compra.DescuentoGlobal, MovTipo.Clave, CompraD.Articulo, SubCuenta, CompraD.Unidad, CompraD.Factor, Art.Tipo, Art.Unidad, RenglonTipo, CompraD.Cliente, CompraD.AplicaRenglon
  ELSE
  IF @Modulo = 'INV'
    DECLARE crMatarMov CURSOR
      FOR SELECT Inv.ID, Inv.Estatus, Inv.Mov, Inv.MovID, Inv.TipoCambio, InvD.Almacen, 0.0, 0.0, MovTipo.Clave, sum(ISNULL(Cantidad, 0.0)), 0.0, sum(ISNULL(CantidadInventario, 0.0)), sum(ISNULL(CantidadReservada, 0.0)), sum(ISNULL(CantidadOrdenada, 0.0)), sum(ISNULL(CantidadPendiente, 0.0)), sum(ISNULL(CantidadA, 0.0)), NULLIF(RTRIM(ProdSerieLote), ''), InvD.Articulo, NULLIF(RTRIM(Subcuenta), ''), convert(char(20), NULL), convert(char(20), NULL), NULLIF(RTRIM(InvD.Unidad), ''), InvD.Factor, NULLIF(RTRIM(UPPER(Art.Tipo)), ''), Art.Unidad, RenglonTipo, InvD.Tipo, CONVERT(varchar, NULL), CONVERT(varchar, NULL), CONVERT(varchar, NULL), CONVERT(varchar, NULL), InvD.AplicaRenglon
            FROM InvD, Inv, MovTipo, Art
           WHERE InvD.ID = @ID
             AND Inv.Empresa = @Empresa
	     AND Inv.Mov = Aplica 
             AND Inv.MovID = AplicaID
             AND Inv.Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CANCELADO')
             AND MovTipo.Modulo = 'INV'
	     AND MovTipo.Mov = Aplica
             AND Art.Articulo = InvD.Articulo
             AND Aplica IS NOT NULL
             AND AplicaID IS NOT NULL
             AND InvD.Seccion IS NULL
           GROUP BY Inv.ID, Inv.Estatus, Inv.Mov, Inv.MovID, Inv.TipoCambio, InvD.Almacen, MovTipo.Clave, InvD.ProdSerieLote, InvD.Articulo, SubCuenta, InvD.Unidad, InvD.Factor, InvD.Tipo, Art.Tipo, Art.Unidad, RenglonTipo, InvD.AplicaRenglon
           ORDER BY Inv.ID, Inv.Estatus, Inv.Mov, Inv.MovID, Inv.TipoCambio, InvD.Almacen, MovTipo.Clave, InvD.ProdSerieLote, InvD.Articulo, SubCuenta, InvD.Unidad, InvD.Factor, InvD.Tipo, Art.Tipo, Art.Unidad, RenglonTipo, InvD.AplicaRenglon
  ELSE
  IF @Modulo = 'PROD'
    DECLARE crMatarMov CURSOR
      FOR SELECT e.ID, e.Estatus, e.Mov, e.MovID, e.TipoCambio, d.Almacen, 0.0, 0.0, MovTipo.Clave, sum(ISNULL(d.Cantidad, 0.0)), sum(ISNULL(d.Merma, 0.0)+ISNULL(d.Desperdicio, 0.0)), sum(ISNULL(d.CantidadInventario, 0.0)), sum(ISNULL(d.CantidadReservada, 0.0)), sum(ISNULL(d.CantidadOrdenada, 0.0)), sum(ISNULL(d.CantidadPendiente, 0.0)), sum(ISNULL(d.CantidadA, 0.0)), NULLIF(RTRIM(d.ProdSerieLote), ''), d.Articulo, NULLIF(RTRIM(d.Subcuenta), ''), convert(char(20), NULL), convert(char(20), NULL), NULLIF(RTRIM(d.Unidad), ''), d.Factor, NULLIF(RTRIM(UPPER(Art.Tipo)), ''), Art.Unidad, d.RenglonTipo, d.Tipo, CONVERT(varchar, NULL), d.Centro, d.CentroDestino, CONVERT(varchar, NULL), d.AplicaRenglon
            FROM ProdD d, Prod e, MovTipo, Art
           WHERE d.ID = @ID
             AND UPPER(d.Tipo) <> 'EXCEDENTE'
             AND e.Empresa = @Empresa
             AND e.Mov = d.Aplica 
             AND e.MovID = d.AplicaID
             AND e.Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CANCELADO')
             AND MovTipo.Modulo = 'PROD'
             AND MovTipo.Mov = e.Mov
             AND Art.Articulo = d.Articulo
             AND Aplica IS NOT NULL
             AND AplicaID IS NOT NULL
           GROUP BY e.ID, e.Estatus, e.Mov, e.MovID, e.TipoCambio, d.Almacen, MovTipo.Clave, d.ProdSerieLote, d.Articulo, d.SubCuenta, d.Unidad, d.Factor, d.Tipo, Art.Tipo, Art.Unidad, RenglonTipo, d.Centro, d.CentroDestino, d.AplicaRenglon
           ORDER BY e.ID, e.Estatus, e.Mov, e.MovID, e.TipoCambio, d.Almacen, MovTipo.Clave, d.ProdSerieLote, d.Articulo, d.SubCuenta, d.Unidad, d.Factor, d.Tipo, Art.Tipo, Art.Unidad, RenglonTipo, d.Centro, d.CentroDestino, d.AplicaRenglon


  OPEN crMatarMov
  FETCH NEXT FROM crMatarMov INTO @IDAplica, @AplicaEstatus, @AplicaMov, @AplicaMovID, @AplicaTipoCambio, @AlmacenOrigen, @DescuentoGlobal, @SobrePrecio, @AplicaMovTipo, @CantidadOriginal, @MermaDesp, @CantidadInventario, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @CantidadA, @ProdSerieLote, @ArticuloOriginal, @SubcuentaOriginal, @SustitutoArticulo, @SustitutoSubCuenta, @MovUnidad, @Factor, @ArtTipo, @ArtUnidad, @RenglonTipo, @DetalleTipo, @Espacio, @Centro, @CentroDestino, @Cliente, @AplicaRenglon
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    -- 9319
    EXEC spMovInfo @IDAplica, @Modulo, @FechaEmision = @FechaAplica OUTPUT, @Ejercicio = @EjercicioAplica OUTPUT, @Periodo = @PeriodoAplica OUTPUT

    IF @Ok IS NULL AND @Accion <> 'CANCELAR'
      EXEC spValidarFechaAplicacion @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @Ejercicio, @Periodo,  
								    @AplicaMov, @AplicaMovID, @Modulo, @IDAplica, @FechaAplica, @EjercicioAplica, @PeriodoAplica, @Ok = @Ok OUTPUT,
								    @OkRef = @OkRef OUTPUT
    
    IF @Ok IS NULL AND @Accion <> 'CANCELAR'
      EXEC spEmpresaValidarFechaAplicacion @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @Ejercicio, @Periodo,  
								           @AplicaMov, @AplicaMovID, @Modulo, @IDAplica, @FechaAplica, @EjercicioAplica, @PeriodoAplica, @Ok = @Ok OUTPUT,
								           @OkRef = @OkRef OUTPUT    
								  
    IF @Ok IS NULL
    BEGIN
      IF @MovTipo = 'PROD.E' SELECT @CantidadOriginal = @CantidadOriginal + ISNULL(@MermaDesp, 0.0)

      IF @SustitutoArticulo  IS NOT NULL AND @ArticuloOriginal  <> @SustitutoArticulo  SELECT @Articulo  = @SustitutoArticulo  ELSE SELECT @Articulo  = @ArticuloOriginal
      IF @SustitutoSubCuenta IS NOT NULL AND @SubCuentaOriginal <> @SustitutoSubCuenta SELECT @SubCuenta = @SustitutoSubCuenta ELSE SELECT @SubCuenta = @SubCuentaOriginal
    
      -- Esto es para que no cheque el almacen cuando esta matando a una Devolucion Garantia
      IF (@MovTipo = 'COMS.DG' AND @AplicaMovTipo = 'COMS.IG') --OR @AplicaMovTipo = 'COMS.R'
        SELECT @AlmacenOrigen = MIN(d.Almacen) FROM CompraD d WHERE d.ID = @IDAplica AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @MovUnidad AND Renglon = ISNULL(@AplicaRenglon,Renglon)

      IF (@MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND @AplicaMovTipo IN ('VTAS.VC', 'VTAS.VCR')) 
        SELECT @SinAlmacen = 1

      IF @Modulo = 'VTAS' AND @MovTipo=@AplicaMovTipo
        SELECT @AlmacenOrigen = MIN(d.Almacen) FROM VentaD d WHERE d.ID = @IDAplica AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @MovUnidad AND Renglon = ISNULL(@AplicaRenglon,Renglon)

      /** 28.07.2006 **/
      IF (@MovTipo = 'INV.R' AND @AplicaMovTipo = 'INV.P') OR (@MovTipo = 'INV.EI')
        SELECT @AlmacenOrigen = MIN(d.Almacen) FROM InvD d WHERE d.ID = @IDAplica AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @MovUnidad AND Renglon = ISNULL(@AplicaRenglon,Renglon)

      EXEC xpInvMatarAlmacenOrigen @Accion, @Modulo, @ID, @MovTipo, @IDAplica, @AplicaMovTipo, @Articulo, @SubCuenta, @MovUnidad, @AlmacenOrigen OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      EXEC spInvInitRenglon @Empresa, 0, @CfgMultiUnidades, @CfgMultiUnidadesNivel, 0, 0, 0, 0, 0,
                            0, 1, @Accion, @Base, @Modulo, NULL, NULL, NULL, @Estatus, @EstatusNuevo, @MovTipo, 0, 0, @AfectarConsignacion, 0, @AlmacenTipo, @AlmacenDestinoTipo, 
			    @Articulo, @MovUnidad, @ArtUnidad, @ArtTipo, @RenglonTipo,
			    @AplicaMovTipo, @CantidadOriginal, @CantidadInventario, @CantidadPendiente, @CantidadA, @DetalleTipo,
                            @Cantidad OUTPUT, @CantidadCalcularImporte OUTPUT, @CantidadReservada OUTPUT, @CantidadOrdenada OUTPUT, @EsEntrada OUTPUT, @EsSalida OUTPUT, @SubCuenta OUTPUT,
                            @AfectarPiezas OUTPUT, @AfectarCostos OUTPUT, @AfectarUnidades OUTPUT, @Factor,
			    @Ok OUTPUT, @OkRef OUTPUT
      SELECT @Cantidad = @CantidadCalcularImporte
      IF @@FETCH_STATUS <> -2 AND @Cantidad <> 0.0 
      BEGIN
        IF @AplicaMovTipo NOT IN ('VTAS.C', 'VTAS.CS', 'VTAS.CO', 'VTAS.FR', 'COMS.C')
        BEGIN
          SELECT @Existe = 0
          IF @SinAlmacen = 1
          BEGIN
            IF EXISTS(SELECT * FROM @AMatar WHERE ID = @IDAplica AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(Unidad, '') = ISNULL(@MovUnidad, '') AND ISNULL(ProdSerieLote, '') = ISNULL(@ProdSerieLote, '') AND ISNULL(Espacio, '') = ISNULL(@Espacio, '') AND ISNULL(Centro, '') = ISNULL(@Centro, '') AND ISNULL(CentroDestino, '') = ISNULL(@CentroDestino, '') AND ISNULL(Cliente, '') = ISNULL(@Cliente, '') AND ISNULL(AplicaRenglon,@Renglon) = @Renglon) 
              SELECT @Existe = 1
          END ELSE
          BEGIN
	    IF EXISTS(SELECT * FROM @AMatar WHERE ID = @IDAplica AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(Unidad, '') = ISNULL(@MovUnidad, '') AND ISNULL(ProdSerieLote, '') = ISNULL(@ProdSerieLote, '') AND ISNULL(Espacio, '') = ISNULL(@Espacio, '') AND ISNULL(Centro, '') = ISNULL(@Centro, '') AND ISNULL(CentroDestino, '') = ISNULL(@CentroDestino, '') AND ISNULL(Cliente, '') = ISNULL(@Cliente, '') AND Almacen = @AlmacenOrigen AND ISNULL(AplicaRenglon,@Renglon) = @Renglon)
              SELECT @Existe = 1
          END

	  IF @Existe = 1
          BEGIN
            IF @SinAlmacen = 1
    	      UPDATE @AMatar SET Cantidad = Cantidad + @Cantidad WHERE ID = @IDAplica AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(Unidad, '') = ISNULL(@MovUnidad, '') AND ISNULL(ProdSerieLote, '') = ISNULL(@ProdSerieLote, '') AND ISNULL(Espacio, '') = ISNULL(@Espacio, '') AND ISNULL(Centro, '') = ISNULL(@Centro, '') AND ISNULL(CentroDestino, '') = ISNULL(@CentroDestino, '') AND ISNULL(Cliente, '') = ISNULL(@Cliente, '') AND ISNULL(AplicaRenglon,@Renglon) = @Renglon
            ELSE
      	      UPDATE @AMatar SET Cantidad = Cantidad + @Cantidad WHERE ID = @IDAplica AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(Unidad, '') = ISNULL(@MovUnidad, '') AND ISNULL(ProdSerieLote, '') = ISNULL(@ProdSerieLote, '') AND ISNULL(Espacio, '') = ISNULL(@Espacio, '') AND ISNULL(Centro, '') = ISNULL(@Centro, '') AND ISNULL(CentroDestino, '') = ISNULL(@CentroDestino, '') AND ISNULL(Cliente, '') = ISNULL(@Cliente, '') AND Almacen = @AlmacenOrigen AND ISNULL(AplicaRenglon,@Renglon) = @Renglon
	  END ELSE
	  BEGIN
  	    INSERT @AMatar (ID, MovTipo, Almacen, Articulo, SubCuenta, Cantidad, Unidad, ProdSerieLote, Espacio, Centro, CentroDestino, Cliente, AplicaRenglon) 
                    VALUES (@IDAplica, @AplicaMovTipo, @AlmacenOrigen, @Articulo, @SubCuenta, @Cantidad, @MovUnidad, @ProdSerieLote, @Espacio, @Centro, @CentroDestino, @Cliente, @AplicaRenglon)
            IF @@ERROR <> 0 SELECT @Ok = 1

	    IF NOT EXISTS(SELECT * FROM @MatarIndice WHERE ID = @IDAplica)
        BEGIN
	      INSERT @MatarIndice (ID,        Estatus,        Mov,        MovID,        MovTipo,        TipoCambio,        Almacen,        DescuentoGlobal,  SobrePrecio,  Importe) 
                         VALUES (@IDAplica, @AplicaEstatus, @AplicaMov, @AplicaMovID, @AplicaMovTipo, @AplicaTipoCambio, @AlmacenOrigen, @DescuentoGlobal, @SobrePrecio, 0.0)
          IF @@ERROR <> 0 SELECT @Ok = 1
         
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @IDAplica, @AplicaMov, @AplicaMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT 
        END
	  END
        END ELSE
          IF @AplicaMovTipo = 'VTAS.CO'
          BEGIN
            SELECT @ContratoEstatusNuevo = CASE @Accion WHEN 'CANCELAR' THEN 'CONFIRMAR' ELSE 'VIGENTE' END 
            EXEC spValidarTareas @Empresa, @Modulo, IDAplica, @ContratoEstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
            UPDATE Venta  
               SET ServicioContrato = Mov,
                   ServicioContratoID = MovID,
                   Estatus = @ContratoEstatusNuevo
             WHERE ID = @IDAplica
             EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @IDAplica, @AplicaMov, @AplicaMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
             IF @@ERROR <> 0 SELECT @Ok = 1
         END
      END
    END 
    FETCH NEXT FROM crMatarMov INTO @IDAplica, @AplicaEstatus, @AplicaMov, @AplicaMovID, @AplicaTipoCambio, @AlmacenOrigen, @DescuentoGlobal, @SobrePrecio, @AplicaMovTipo, @CantidadOriginal, @MermaDesp, @CantidadInventario, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @CantidadA, @ProdSerieLote, @ArticuloOriginal, @SubcuentaOriginal, @SustitutoArticulo, @SustitutoSubCuenta, @MovUnidad, @Factor, @ArtTipo, @ArtUnidad, @RenglonTipo, @DetalleTipo, @Espacio, @Centro, @CentroDestino, @Cliente, @AplicaRenglon
    IF @@ERROR <> 0 SELECT @Ok = 1
  END 
  CLOSE crMatarMov
  DEALLOCATE crMatarMov
  IF @Ok IS NOT NULL RETURN

  IF @Modulo = 'VTAS'
    DECLARE crMatarOrigen CURSOR
       FOR SELECT i.ID, VentaD.Almacen, VentaD.Almacen, i.DescuentoGlobal, i.SobrePrecio, i.Mov, i.MovID, i.MovTipo, i.TipoCambio, Renglon, RenglonSub, VentaD.RenglonID, Articulo, NULLIF(RTRIM(Subcuenta), ''), ISNULL(Cantidad, 0.0) - ISNULL(CantidadCancelada, 0.0), ISNULL(CantidadReservada, 0.0), ISNULL(CantidadOrdenada, 0.0), ISNULL(CantidadPendiente, 0.0), NULLIF(RTRIM(Unidad), ''), Factor, Convert(char, NULL), ISNULL(Precio, 0.0), NULLIF(RTRIM(DescuentoTipo), ''), ISNULL(DescuentoLinea, 0.0), ISNULL(Impuesto1, 0.0), ISNULL(Impuesto2, 0.0), ISNULL(Impuesto3, 0.0), NULLIF(RTRIM(Espacio), ''), CONVERT(varchar, NULL), CONVERT(varchar, NULL), CONVERT(varchar, NULL), PrecioTipoCambio, ISNULL(Retencion1,0.0), ISNULL(Retencion2,0.0), ISNULL(Retencion3,0.0) --MEJORA4648
             FROM VentaD
             JOIN @MatarIndice i ON i.ID = VentaD.ID
 	    ORDER BY Articulo, SubCuenta DESC, CantidadReservada DESC
  ELSE
  IF @Modulo = 'COMS'
    DECLARE crMatarOrigen CURSOR
       FOR SELECT i.ID, CompraD.Almacen, CompraD.Almacen, i.DescuentoGlobal, i.SobrePrecio, i.Mov, i.MovID, i.MovTipo, i.TipoCambio, Renglon, RenglonSub, CompraD.RenglonID, Articulo, NULLIF(RTRIM(Subcuenta), ''), ISNULL(Cantidad, 0.0) - ISNULL(CantidadCancelada, 0.0), Cantidad, Cantidad, ISNULL(CantidadPendiente, 0.0), NULLIF(RTRIM(Unidad), ''), Factor, Convert(char, NULL), ISNULL(Costo, 0.0), NULLIF(RTRIM(DescuentoTipo), ''), ISNULL(DescuentoLinea, 0.0), ISNULL(Impuesto1, 0.0), ISNULL(Impuesto2, 0.0), ISNULL(Impuesto3, 0.0), CONVERT(varchar, NULL), CONVERT(varchar, NULL), CONVERT(varchar, NULL), NULLIF(RTRIM(Cliente), ''), CONVERT(float, NULL), ISNULL(Retencion1, 0.0), ISNULL(Retencion2, 0.0), ISNULL(Retencion3, 0.0)
             FROM CompraD
             JOIN @MatarIndice i ON i.ID = CompraD.ID
 	    ORDER BY Articulo, SubCuenta DESC
  ELSE
  IF @Modulo = 'INV'
    DECLARE crMatarOrigen CURSOR
       FOR SELECT i.ID, InvD.Almacen, Inv.AlmacenDestino, i.DescuentoGlobal, i.SobrePrecio, i.Mov, i.MovID, i.MovTipo, i.TipoCambio, Renglon, RenglonSub, InvD.RenglonID, Articulo, NULLIF(RTRIM(Subcuenta), ''), ISNULL(Cantidad, 0.0) - ISNULL(CantidadCancelada, 0.0), ISNULL(CantidadReservada, 0.0), ISNULL(CantidadOrdenada, 0.0), ISNULL(CantidadPendiente, 0.0), NULLIF(RTRIM(Unidad), ''), Factor, NULLIF(RTRIM(ProdSerieLote), ''), Convert(money, NULL), Convert(char(1), NULL), Convert(money, NULL), Convert(float, NULL), Convert(float, NULL), Convert(money, NULL), CONVERT(varchar, NULL), CONVERT(varchar, NULL), CONVERT(varchar, NULL), CONVERT(varchar, NULL), CONVERT(float, NULL), CONVERT(float, NULL), CONVERT(float, NULL), CONVERT(float, NULL)
             FROM InvD
             JOIN Inv ON Inv.ID = InvD.ID
             JOIN @MatarIndice i ON i.ID = InvD.ID
	    ORDER BY Articulo, SubCuenta DESC, CantidadReservada DESC
  ELSE
  IF @Modulo = 'PROD'
    DECLARE crMatarOrigen CURSOR
       FOR SELECT i.ID, ProdD.Almacen, ProdD.Almacen, i.DescuentoGlobal, i.SobrePrecio, i.Mov, i.MovID, i.MovTipo, i.TipoCambio, Renglon, RenglonSub, ProdD.RenglonID, Articulo, NULLIF(RTRIM(Subcuenta), ''), ISNULL(Cantidad, 0.0) - ISNULL(CantidadCancelada, 0.0), ISNULL(CantidadReservada, 0.0), ISNULL(CantidadOrdenada, 0.0), ISNULL(CantidadPendiente, 0.0), NULLIF(RTRIM(Unidad), ''), Factor, NULLIF(RTRIM(ProdSerieLote), ''), Convert(money, NULL), Convert(char(1), NULL), Convert(money, NULL), Convert(float, NULL), Convert(float, NULL), Convert(money, NULL), CONVERT(varchar, NULL), NULLIF(RTRIM(Centro), ''), NULLIF(RTRIM(CentroDestino), ''), CONVERT(varchar, NULL), CONVERT(float, NULL), CONVERT(float, NULL), CONVERT(float, NULL), CONVERT(float, NULL)
             FROM ProdD
             JOIN @MatarIndice i ON i.ID = ProdD.ID
	    ORDER BY Articulo, SubCuenta DESC, CantidadReservada DESC

  -- Inicializar Variables
  SELECT @UltID = NULL
  OPEN crMatarOrigen
  FETCH NEXT FROM crMatarOrigen INTO @IDAplica, @AlmacenOrigen, @AlmacenBackOrders, @DescuentoGlobal, @SobrePrecio, @AplicaMov, @AplicaMovID, @AplicaMovTipo, @AplicaTipoCambio, @Renglon, @RenglonSub, @RenglonID, @Articulo, @SubCuenta, @CantidadOriginal, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @MovUnidad, @Factor, @ProdSerieLote, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @Espacio, @Centro, @CentroDestino, @Cliente, @PrecioTipoCambio, @Retencion1, @Retencion2, @Retencion3
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Modulo = 'COMS' SELECT @CantidadReservada = 0.0, @CantidadOrdenada = 0.0
      SELECT @Requiere = NULL, @ReservadoObtenido = 0.0, @PendienteObtenido = 0.0, @ArtMoneda = NULL
      SELECT @ArtMoneda = MonedaCosto, @ArtTipo = UPPER(Tipo) FROM Art WHERE Articulo = @Articulo

      IF @SinAlmacen = 1
        SELECT @Cantidad = ISNULL(Cantidad, 0.0), @Requiere = ISNULL(Cantidad, 0.0), @Llave = Llave 
          FROM @AMatar 
         WHERE ID = @IDAplica AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(Unidad, '') = ISNULL(@MovUnidad, '') AND ISNULL(ProdSerieLote, '') = ISNULL(@ProdSerieLote, '') AND ISNULL(Espacio, '') = ISNULL(@Espacio, '') AND ISNULL(Centro, '') = ISNULL(@Centro, '') AND ISNULL(CentroDestino, '') = ISNULL(@CentroDestino, '') AND ISNULL(Cliente, '') = ISNULL(@Cliente, '') AND ISNULL(AplicaRenglon,@Renglon) = @Renglon
      ELSE
        SELECT @Cantidad = ISNULL(Cantidad, 0.0), @Requiere = ISNULL(Cantidad, 0.0), @Llave = Llave 
          FROM @AMatar 
         WHERE ID = @IDAplica AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(Unidad, '') = ISNULL(@MovUnidad, '') AND ISNULL(ProdSerieLote, '') = ISNULL(@ProdSerieLote, '') AND ISNULL(Espacio, '') = ISNULL(@Espacio, '') AND ISNULL(Centro, '') = ISNULL(@Centro, '') AND ISNULL(CentroDestino, '') = ISNULL(@CentroDestino, '') AND ISNULL(Cliente, '') = ISNULL(@Cliente, '') AND Almacen = @AlmacenOrigen AND ISNULL(AplicaRenglon,@Renglon) = @Renglon

      IF @@ERROR <> 0 SELECT @Ok = 1
      IF @Requiere = 0.0 AND @SubCuenta IS NULL
      BEGIN
        IF @SinAlmacen = 1
          SELECT @Requiere = SUM(ISNULL(Cantidad, 0.0)), @Llave = MIN(Llave) 
            FROM @AMatar 
           WHERE ID = @IDAplica AND Articulo = @Articulo AND ISNULL(Unidad, '') = ISNULL(@MovUnidad, '') AND ISNULL(ProdSerieLote, '') = ISNULL(@ProdSerieLote, '') AND ISNULL(Espacio, '') = ISNULL(@Espacio, '') AND ISNULL(Centro, '') = ISNULL(@Centro, '') AND ISNULL(CentroDestino, '') = ISNULL(@CentroDestino, '') AND ISNULL(Cliente, '') = ISNULL(@Cliente, '') AND ISNULL(AplicaRenglon,@Renglon) = @Renglon
        ELSE
          SELECT @Requiere = SUM(ISNULL(Cantidad, 0.0)), @Llave = MIN(Llave) 
            FROM @AMatar 
           WHERE ID = @IDAplica AND Articulo = @Articulo AND ISNULL(Unidad, '') = ISNULL(@MovUnidad, '') AND ISNULL(ProdSerieLote, '') = ISNULL(@ProdSerieLote, '') AND ISNULL(Espacio, '') = ISNULL(@Espacio, '') AND ISNULL(Centro, '') = ISNULL(@Centro, '') AND ISNULL(CentroDestino, '') = ISNULL(@CentroDestino, '') AND ISNULL(Cliente, '') = ISNULL(@Cliente, '') AND Almacen = @AlmacenOrigen  AND ISNULL(AplicaRenglon,@Renglon) = @Renglon
        IF @@ERROR <> 0 SELECT @Ok = 1
      END

      IF @Requiere IS NOT NULL
      BEGIN
	IF @Modulo IN ('VTAS', 'INV', 'PROD') AND @Cancelar = 0 AND @ArtTipo NOT IN ('JUEGO', 'SERVICIO') AND @AlmacenOrigen IS NOT NULL
        BEGIN
          IF @Requiere < @CantidadReservada SELECT @ReservadoObtenido = @Requiere ELSE SELECT @ReservadoObtenido = @CantidadReservada
	  SELECT @Requiere = @Requiere - @ReservadoObtenido        
          IF @ReservadoObtenido > 0.0  -- Desreservar
          BEGIN
            IF @@ERROR <> 0 SELECT @Ok = 1

            SELECT @SucursalAlmacenOrigen = Sucursal FROM Alm WHERE Almacen = @AlmacenOrigen
            EXEC spSaldo @SucursalAlmacenOrigen, @Accion, @Empresa, @Usuario, 'RESV', @ArtMoneda, NULL, @Articulo, @SubCuenta, @AlmacenOrigen, NULL,
                         @Modulo, @IDAplica, @AplicaMov, @AplicaMovID, 0, NULL, @ReservadoObtenido, @Factor,
         	         @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0,
			 @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID
          END
        END

	IF @MovTipo='VTAS.VP' AND @Accion <> 'CANCELAR'
	BEGIN 
	 SELECT @Requiere=@ReservadoObtenido+@PendienteObtenido 
	 SELECT @ReservadoObtenido = 0, @PendienteObtenido = 0
	END 

        IF @Requiere > 0.0
        BEGIN
          IF @Cancelar = 1
          BEGIN
            IF @Requiere <= @CantidadOriginal-@CantidadPendiente-@CantidadReservada-@CantidadOrdenada
              SELECT @PendienteObtenido = @Requiere
            ELSE
              SELECT @PendienteObtenido = @CantidadOriginal-@CantidadPendiente-@CantidadReservada-@CantidadOrdenada
          END ELSE
          BEGIN
            IF @Requiere <= @CantidadPendiente 
	      SELECT @PendienteObtenido = @Requiere 
            ELSE 
              SELECT @PendienteObtenido = @CantidadPendiente
          END
	  SELECT @Requiere = @Requiere - @PendienteObtenido
	END

	SELECT @Obtenido = @ReservadoObtenido + @PendienteObtenido

	IF @Obtenido <> 0.0
	BEGIN
          -- Disminuir las Compras a Consignacion
          IF @AplicaMovTipo = 'COMS.CC' AND @MovTipo IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI') AND @SinAlmacen = 0
	  BEGIN
            SELECT @EsCargo = @Cancelar 
            IF @@ERROR <> 0 SELECT @Ok = 1

            SELECT @SucursalAlmacenOrigen = Sucursal FROM Alm WHERE Almacen = @AlmacenOrigen
            EXEC spSaldo @SucursalAlmacenOrigen, @Accion, @Empresa, @Usuario, 'CSG', @ArtMoneda, NULL, @Articulo, @SubCuenta, @AlmacenOrigen, NULL,
                         @Modulo, @IDAplica, @AplicaMov, @AplicaMovID, @EsCargo, NULL, @Obtenido, @Factor,
         	         @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0,
			 @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID
             
	  END
          IF @AplicaMovTipo IN ('COMS.O', 'COMS.OP', 'COMS.OG', 'COMS.OD', 'COMS.OI', 'PROD.O', 'INV.OT', 'INV.TI') AND @CfgBackOrders = 1 AND @MovTipo NOT IN ('PROD.CO', 'COMS.CP', 'COMS.O')
          BEGIN
  	    SELECT @DestinoTipo = NULL, @Destino = NULL, @DestinoID = NULL, @Cliente = NULL/*, @AplicaAplica = NULL, @AplicaAplicaID = NULL*/
            IF @Modulo = 'COMS' SELECT @Cliente = NULLIF(RTRIM(Cliente), ''), @DestinoTipo = DestinoTipo, @Destino = NULLIF(RTRIM(Destino), ''), @DestinoID = DestinoID FROM CompraD WHERE ID = @IDAplica AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
            IF @Modulo = 'INV'  SELECT @Cliente = NULLIF(RTRIM(Cliente), ''), @DestinoTipo = DestinoTipo, @Destino = NULLIF(RTRIM(Destino), ''), @DestinoID = DestinoID FROM InvD    WHERE ID = @IDAplica AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
            IF @Modulo = 'PROD' SELECT @Cliente = NULLIF(RTRIM(Cliente), ''), @DestinoTipo = DestinoTipo, @Destino = NULLIF(RTRIM(Destino), ''), @DestinoID = DestinoID FROM ProdD   WHERE ID = @IDAplica AND Renglon = @Renglon AND RenglonSub = @RenglonSub 

/*            IF @AplicaAplica IS NOT NULL AND @AplicaAplicaID IS NOT NULL
              EXEC spInvBackOrderAplica @Accion, @Empresa, @Usuario, @Modulo, @AplicaAplica, @AplicaAplicaID, @Articulo, @SubCuenta, @MovUnidad, @Obtenido, @ArtMoneda, 
      	 			        @AlmacenBackOrders, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo,
				        @Ok OUTPUT, @OkRef OUTPUT
            ELSE*/
              IF @Destino IS NOT NULL AND @DestinoID IS NOT NULL AND @DestinoTipo IN (SELECT Modulo FROM Modulo) AND @Cancelar = 0 
                EXEC spInvBackOrder @Sucursal, @Accion, @Estatus, 1, @Empresa, @Usuario, @Modulo, @ID, @Mov, @MovID, 
                                    @DestinoTipo, @Destino, @DestinoID, @Articulo, @SubCuenta, @MovUnidad, @Obtenido, @Factor, @ArtMoneda, 
	    			    @AlmacenBackOrders, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo,
				    @Ok OUTPUT, @OkRef OUTPUT, @MovTipo = @MovTipo
          END
          EXEC spCalculaImporte @Accion, @Modulo, @CfgImpInc, @MovTipo, @EsEntrada, @Obtenido, @Precio, @DescuentoTipo, @DescuentoLinea, @DescuentoGlobal, @SobrePrecio, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5,
                                @Importe OUTPUT, @ImporteNeto OUTPUT, @DescuentoLineaImporte OUTPUT, @DescuentoGlobalImporte OUTPUT, @SobrePrecioImporte OUTPUT, 
                                @Impuestos OUTPUT, @ImpuestosNetos OUTPUT, @Impuesto1Neto OUTPUT, @Impuesto2Neto OUTPUT, @Impuesto3Neto OUTPUT, @Impuesto5Neto OUTPUT, 
				@Articulo = @Articulo, @CfgPrecioMoneda = @CfgPrecioMoneda, @MovTipoCambio = @AplicaTipoCambio, @PrecioTipoCambio = @PrecioTipoCambio,
				@Retencion1 = @Retencion1, @Retencion2 = @Retencion2, @Retencion3 = @Retencion3, @ID = @ID

          SELECT @ImporteMatar = @ImporteNeto + @ImpuestosNetos
          UPDATE @MatarIndice SET Importe = Importe + @ImporteMatar WHERE ID = @IDAplica
          IF @@ERROR <> 0 SELECT @Ok = 1
	END

	UPDATE @AMatar 
	   SET Cantidad = Cantidad - @Obtenido 
         WHERE Llave = @Llave
        IF @@ERROR <> 0 SELECT @Ok = 1
        IF @Cancelar = 1
	  SELECT @ReservadoObtenido = -@ReservadoObtenido, @PendienteObtenido = -@PendienteObtenido
	INSERT @MatarDetalle (ID,         Renglon,  RenglonSub, Reservado,          Pendiente,          MovTipo,        Articulo,  SubCuenta,  Almacen,        Factor) 
                      VALUES (@IDAplica, @Renglon, @RenglonSub, @ReservadoObtenido, @PendienteObtenido, @AplicaMovTipo, @Articulo, @SubCuenta, @AlmacenOrigen, @Factor)
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END
    FETCH NEXT FROM crMatarOrigen INTO @IDAplica, @AlmacenOrigen, @AlmacenBackOrders, @DescuentoGlobal, @SobrePrecio, @AplicaMov, @AplicaMovID, @AplicaMovTipo, @AplicaTipoCambio, @Renglon, @RenglonSub, @RenglonID, @Articulo, @SubCuenta, @CantidadOriginal, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @MovUnidad, @Factor, @ProdSerieLote, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @Espacio, @Centro, @CentroDestino, @Cliente, @PrecioTipoCambio, @Retencion1, @Retencion2, @Retencion3
    IF @@ERROR <> 0 SELECT @Ok = 1
  END
  CLOSE crMatarOrigen
  DEALLOCATE crMatarOrigen
  IF @Ok IS NOT NULL RETURN


  DECLARE crMatar CURSOR
    FOR SELECT ID, Renglon, RenglonSub, Reservado, Pendiente, MovTipo, Articulo, SubCuenta, Almacen, Factor
          FROM @MatarDetalle
  OPEN crMatar
  FETCH NEXT FROM crMatar INTO @IDAplica, @Renglon, @RenglonSub, @ReservadoObtenido, @PendienteObtenido, @AplicaMovTipo, @Articulo, @SubCuenta, @AlmacenOrigen, @Factor
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Modulo = 'COMS' 
      BEGIN
	UPDATE CompraD 
           SET @NuevoPendiente = CantidadPendiente = NULLIF(ISNULL(CantidadPendiente, 0.0) - @PendienteObtenido, 0.0)
	 WHERE ID = @IDAplica AND Renglon = @Renglon AND RenglonSub = @RenglonSub
         IF @NuevoPendiente IS NOT NULL AND ROUND(@NuevoPendiente, @Redondeo) = 0 UPDATE CompraD SET CantidadPendiente = NULL WHERE ID = @IDAplica AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END ELSE
      IF @Modulo = 'VTAS'
      BEGIN
	UPDATE VentaD 
           SET CantidadReservada = NULLIF(ISNULL(CantidadReservada, 0.0) - @ReservadoObtenido, 0.0), 
               @NuevoPendiente = CantidadPendiente = NULLIF(ISNULL(CantidadPendiente, 0.0) - @PendienteObtenido, 0.0)
	 WHERE ID = @IDAplica AND Renglon = @Renglon AND RenglonSub = @RenglonSub
         IF @NuevoPendiente IS NOT NULL AND ROUND(@NuevoPendiente, @Redondeo) = 0 UPDATE VentaD SET CantidadPendiente = NULL WHERE ID = @IDAplica AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END ELSE
      IF @Modulo = 'INV' 
      BEGIN
	UPDATE InvD 
           SET CantidadReservada = NULLIF(ISNULL(CantidadReservada, 0.0) - @ReservadoObtenido, 0.0), 
               @NuevoPendiente = CantidadPendiente = NULLIF(ISNULL(CantidadPendiente, 0.0) - @PendienteObtenido, 0.0)
	 WHERE ID = @IDAplica AND Renglon = @Renglon AND RenglonSub = @RenglonSub
         IF @NuevoPendiente IS NOT NULL AND ROUND(@NuevoPendiente, @Redondeo) = 0 UPDATE InvD SET CantidadPendiente = NULL WHERE ID = @IDAplica AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END ELSE
      IF @Modulo = 'PROD' 
      BEGIN
	UPDATE ProdD 
           SET CantidadReservada = NULLIF(ISNULL(CantidadReservada, 0.0) - @ReservadoObtenido, 0.0), 
               @NuevoPendiente = CantidadPendiente = NULLIF(ISNULL(CantidadPendiente, 0.0) - @PendienteObtenido, 0.0)
	 WHERE ID = @IDAplica AND Renglon = @Renglon AND RenglonSub = @RenglonSub
         IF @NuevoPendiente IS NOT NULL AND ROUND(@NuevoPendiente, @Redondeo) = 0 UPDATE ProdD SET CantidadPendiente = NULL WHERE ID = @IDAplica AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END

      SELECT @PendienteDif = -@PendienteObtenido
      EXEC spArtR @Empresa, @Modulo, @Articulo, @SubCuenta, @AlmacenOrigen, @AplicaMovTipo, @Factor, @PendienteDif, NULL, NULL, NULL, NULL, NULL
    END
    FETCH NEXT FROM crMatar INTO @IDAplica, @Renglon, @RenglonSub, @ReservadoObtenido, @PendienteObtenido, @AplicaMovTipo, @Articulo, @SubCuenta, @AlmacenOrigen, @Factor
    IF @@ERROR <> 0 SELECT @Ok = 1
  END
  CLOSE crMatar
  DEALLOCATE crMatar
  IF @Ok IS NOT NULL RETURN

  IF @Modulo IN ('VTAS', 'COMS')
  BEGIN
    DECLARE crMatarSaldos CURSOR
      FOR SELECT ID, Mov, MovID, MovTipo, Importe
            FROM @MatarIndice
           WHERE Importe <> 0.0
    OPEN crMatarSaldos
    FETCH NEXT FROM crMatarSaldos INTO @IDAplica,  @AplicaMov, @AplicaMovID, @AplicaMovTipo, @ImporteMatar
    IF @@ERROR <> 0 SELECT @Ok = 1
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Modulo = 'VTAS' UPDATE Venta  SET Saldo = CASE @Cancelar WHEN 1 THEN NULLIF(ISNULL(Saldo, 0.0) + @ImporteMatar, 0.0) ELSE NULLIF(ISNULL(Saldo, 0.0) - @ImporteMatar, 0.0) END WHERE ID = @IDAplica ELSE
        IF @Modulo = 'COMS' UPDATE Compra SET Saldo = CASE @Cancelar WHEN 1 THEN NULLIF(ISNULL(Saldo, 0.0) + @ImporteMatar, 0.0) ELSE NULLIF(ISNULL(Saldo, 0.0) - @ImporteMatar, 0.0) END WHERE ID = @IDAplica 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
      FETCH NEXT FROM crMatarSaldos INTO @IDAplica,  @AplicaMov, @AplicaMovID, @AplicaMovTipo, @ImporteMatar
      IF @@ERROR <> 0 SELECT @Ok = 1
    END
    CLOSE crMatarSaldos
    DEALLOCATE crMatarSaldos
    IF @Ok IS NOT NULL RETURN
  END

  IF @Modulo = 'VTAS'
    DECLARE crMatarPendiente CURSOR
      FOR SELECT m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus, Sum(ISNULL(d.CantidadOrdenada, 0.0)) + Sum(ISNULL(d.CantidadReservada, 0.0)) + Sum(ISNULL(d.CantidadPendiente, 0.0))
            FROM VentaD d, @MatarIndice m
           WHERE d.ID = m.ID
           GROUP BY m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus
           ORDER BY m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus
  ELSE
  IF @Modulo = 'COMS'
    DECLARE crMatarPendiente CURSOR
      FOR SELECT m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus, Sum(ISNULL(d.CantidadPendiente, 0.0))
            FROM CompraD d, @MatarIndice m
           WHERE d.ID = m.ID
           GROUP BY m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus
           ORDER BY m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus
  ELSE
  IF @Modulo = 'INV'
    DECLARE crMatarPendiente CURSOR
      FOR SELECT m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus, Sum(ISNULL(d.CantidadOrdenada, 0.0)) + Sum(ISNULL(d.CantidadReservada, 0.0)) + Sum(ISNULL(d.CantidadPendiente, 0.0))
            FROM InvD d, @MatarIndice m
           WHERE d.ID = m.ID
           GROUP BY m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus
           ORDER BY m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus
  ELSE
  IF @Modulo = 'PROD'
    DECLARE crMatarPendiente CURSOR
      FOR SELECT m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus, Sum(ISNULL(d.CantidadOrdenada, 0.0)) + Sum(ISNULL(d.CantidadReservada, 0.0)) + Sum(ISNULL(d.CantidadPendiente, 0.0))
            FROM ProdD d, @MatarIndice m
           WHERE d.ID = m.ID
           GROUP BY m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus
           ORDER BY m.ID, m.Mov, m.MovID, m.MovTipo, m.Estatus

  OPEN crMatarPendiente
  FETCH NEXT FROM crMatarPendiente INTO @IDAplica, @AplicaMov, @AplicaMovID, @AplicaMovTipo, @AplicaEstatus, @CantidadPendiente
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF (@Accion = 'CANCELAR' AND ROUND(@CantidadPendiente, 4) > 0) OR (@Accion <> 'CANCELAR' AND ROUND(@CantidadPendiente, 4) = 0)
      BEGIN
        IF ROUND(@CantidadPendiente, 4) = 0 
        BEGIN
          SELECT @AplicaEstatusNuevo = 'CONCLUIDO', @AplicaFechaConclusion = @FechaEmision

          -- Checar Consumos Pendientes
          IF @AplicaMovTipo = 'PROD.O'
          BEGIN
            IF EXISTS(SELECT * FROM Inv WHERE Empresa = @Empresa AND Estatus = 'CONFIRMAR' AND OrigenTipo = 'PROD' AND Origen = @AplicaMov AND OrigenID = @AplicaMovID)               
              SELECT @Ok = 25400

            IF @MovTipo = 'PROD.E'
              IF EXISTS(SELECT * FROM Inv WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE' AND OrigenTipo = 'PROD' AND Origen = @AplicaMov AND OrigenID = @AplicaMovID)
                SELECT @Ok = 25400
          END
        END ELSE
          SELECT @AplicaEstatusNuevo = 'PENDIENTE', @AplicaFechaConclusion = NULL

        EXEC spValidarTareas @Empresa, @Modulo, @IDAplica, @AplicaEstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT  
        IF @Modulo = 'VTAS' UPDATE Venta  SET Estatus = @AplicaEstatusNuevo, FechaConclusion = @AplicaFechaConclusion WHERE ID = @IDAplica ELSE
        IF @Modulo = 'COMS' UPDATE Compra SET Estatus = @AplicaEstatusNuevo, FechaConclusion = @AplicaFechaConclusion WHERE ID = @IDAplica ELSE
        IF @Modulo = 'INV'  UPDATE Inv    SET Estatus = @AplicaEstatusNuevo, FechaConclusion = @AplicaFechaConclusion WHERE ID = @IDAplica ELSE
        IF @Modulo = 'PROD' UPDATE Prod   SET Estatus = @AplicaEstatusNuevo, FechaConclusion = @AplicaFechaConclusion WHERE ID = @IDAplica 
        IF @@ERROR <> 0 SELECT @Ok = 1
     
        -- Agregar a Estatus Log
        IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
          EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @IDAplica, @AplicaEstatus, @AplicaEstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @AplicaMov, @AplicaMovID, @AplicaMovTipo, NULL, @Ok OUTPUT, @OkRef OUTPUT

        IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000 --ARCC GESTION
          EXEC spMAFConcluirServicioMAF @Modulo, @AplicaEstatusNuevo, @Accion, @Empresa, @Sucursal, @Usuario, @AplicaFechaConclusion, @IDAplica, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT          
      END

          -- Checar Consumos Pendientes cuando la Entrada es Parcial
      IF @Accion <> 'CANCELAR' AND ROUND(@CantidadPendiente, 4) > 0
      BEGIN
        IF @MovTipo = 'PROD.E'
          IF EXISTS (SELECT e.ID FROM Inv e JOIN InvD d ON e.ID = d.ID WHERE e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' AND e.OrigenTipo = 'PROD' AND e.Origen = @AplicaMov AND e.OrigenID = @AplicaMovID 
                     AND CantidadPendiente > 0 AND d.Producto IN (SELECT Articulo FROM ProdD WHERE ID = @ID) 
                     AND CantidadPendiente > @CantidadPendiente*(SELECT ISNULL(m.Cantidad/m.CantidadP,1) FROM ProdProgramaMaterial m WHERE m.ID = @IDAplica AND m.Producto = d.Producto AND m.Lote = d.ProdSerieLote AND m.Articulo = d.Articulo  AND ISNULL(m.Subcuenta,'') = ISNULL(d.subcuenta,'')))
             SELECT @Ok = 25400

        IF @AplicaMovTipo = 'PROD.O'
          IF EXISTS (SELECT e.ID FROM Inv e JOIN InvD d ON e.ID = d.ID WHERE e.Empresa = @Empresa AND e.Estatus = 'CONFIRMAR' AND e.OrigenTipo = 'PROD' AND e.Origen = @AplicaMov AND e.OrigenID = @AplicaMovID 
                     AND CantidadPendiente > 0 AND d.Producto IN (SELECT Articulo FROM ProdD WHERE ID = @ID)  
                     AND CantidadPendiente > @CantidadPendiente*(SELECT ISNULL(m.Cantidad/m.CantidadP,1) FROM ProdProgramaMaterial m WHERE m.ID = @IDAplica AND m.Producto = d.Producto AND m.Lote = d.ProdSerieLote AND m.Articulo = d.Articulo AND ISNULL(m.Subcuenta,'') = ISNULL(d.subcuenta,'')))
            SELECT @Ok = 25400
      END

    END
    FETCH NEXT FROM crMatarPendiente INTO @IDAplica, @AplicaMov, @AplicaMovID, @AplicaMovTipo, @AplicaEstatus, @CantidadPendiente
    IF @@ERROR <> 0 SELECT @Ok = 1
  END
  CLOSE crMatarPendiente
  DEALLOCATE crMatarPendiente

  IF @MovTipo = 'INV.CM'
    SELECT @Cantidad = Sum(ISNULL(Cantidad, 0.0)) FROM @AMatar WHERE MovTipo NOT IN ('INV.SM')
  ELSE
  IF @Modulo = 'VTAS' AND (@CfgVentaSurtirDemas = 1 OR @Accion = 'RESERVARPARCIAL')
    SELECT @Cantidad = Sum(ISNULL(Cantidad, 0.0)) FROM @AMatar WHERE MovTipo NOT IN ('VTAS.P', 'VTAS.S')
  ELSE
  IF @Modulo = 'COMS' AND (@CfgCompraRecibirDemas = 1 OR @Accion = 'RESERVARPARCIAL')
    SELECT @Cantidad = Sum(ISNULL(Cantidad, 0.0)) FROM @AMatar WHERE MovTipo NOT IN ('COMS.R','COMS.O', 'COMS.OP', 'COMS.OG', 'COMS.OI')
  ELSE
  IF @Modulo = 'INV' AND (@CfgTransferirDemas = 1 OR @Accion = 'RESERVARPARCIAL')
    SELECT @Cantidad = Sum(ISNULL(Cantidad, 0.0)) FROM @AMatar WHERE MovTipo NOT IN ('INV.OI', 'INV.OT')
  ELSE
    SELECT @Cantidad = Sum(ISNULL(Cantidad, 0.0)) FROM @AMatar

  EXEC xpInvMatar @Accion, @ID, @MovTipo, @Cantidad OUTPUT

  /*
  IF ROUND(@Cantidad, 4) > 0 
  BEGIN
    SELECT @Ok = 20290, @OkRef = 'Articulo: '+ (SELECT MIN(Articulo) FROM @AMatar WHERE Cantidad > 0 )
    EXEC xpOk_20290 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END
  */

  /* Se Comenta la validación anterior ya que cualquier catidada que se encuentre es mayor a cero ya que no permite negativos ni cero,
	 asi mismo se valida que la cantidad para realizar el recibo de transito sea menos a la del inventario si no marca error de exede cantidad */

  IF ROUND(@Cantidad, 4) > ROUND((SELECT Convert(float, Disponible) FROM ArtDisponible  WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @AlmacenOrigen), 4) --ROUND(@CantidadInventario, 4)
  BEGIN
	SELECT @Ok = 20290, @OkRef = 'Articulo: '+ (SELECT MIN(Articulo) FROM @AMatar WHERE Cantidad > 0 )
	EXEC xpOk_20290 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT	
  END

  RETURN
END
GO

/**************** spInvMatarNotas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvMatarNotas') and type = 'P') drop procedure dbo.spInvMatarNotas
GO
CREATE PROCEDURE spInvMatarNotas
			@Sucursal		int,
			@ID			int,
		  	@Accion			char(20), 
			@Empresa		char(5), 
                        @Usuario		char(10),
			@Modulo			char(5), 
			@Mov			char(20),
			@MovID			varchar(20),
			@FechaAfectacion	datetime,
			@Ejercicio		int,
			@Periodo		int,

                        @Ok 			int	     OUTPUT,
    		   	@OkRef          	varchar(255) OUTPUT,
			@AfectandoNotasSinCobro	bit	     OUTPUT,
--REQ 15448
			@MovTipo                varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @IDNota			int,
    @NotaMov			char(20),
    @NotaMovID			varchar(20),
    @NotaCliente		char(10),
    @NotaEstatus		char(15),
    @NotaEstatusNuevo		char(15),
    @NotaMovTipo		char(20),
    @NotaImporteTotal		money,
    @NotaMoneda			char(10),
    @NotaTipoCambio		float,
    @EsCargo			bit,
    @CfgMoverNotasAuto		bit,
--REQ 15448
    @GenerarNCAlProcesar       bit,
    @ProcesadoID                int,
    @CfgAnticipoArticuloServicio varchar(20),
    @ArtOfertaFP                varchar(20),
    @ArtOfertaImporte           varchar(20),
    @RenglonVal int,
    @OrigenIDVal int,
    @Renglones int
    
  
      DECLARE crValidarOrigen CURSOR LOCAL FOR 
       SELECT RenglonID,OrigenID
         FROM VentaOrigen
        WHERE ID = @ID
      OPEN crValidarOrigen
      FETCH NEXT FROM crValidarOrigen INTO @RenglonVal,@OrigenIDVal
      WHILE @@FETCH_STATUS <> -1 
      BEGIN   
        IF @@FETCH_STATUS <> -2 
        BEGIN
             SELECT @Renglones = COUNT(RenglonID) 
               FROM VentaOrigen 
              WHERE ID = @ID AND OrigenID = @OrigenIDVal
          
            IF @Renglones >= 2
		    BEGIN
			  	DELETE VentaOrigen WHERE ID = @ID AND RenglonID = @RenglonVal
		    END
		    SET @Renglones = 0
        END
        FETCH NEXT FROM crValidarOrigen INTO @RenglonVal,@OrigenIDVal
      END
      CLOSE crValidarOrigen
      DEALLOCATE crValidarOrigen


  SELECT @ArtOfertaFP = ArtOfertaFP, @ArtOfertaImporte = ArtOfertaImporte
    FROM POSCfg WHERE Empresa = @Empresa
    
  SELECT @CfgAnticipoArticuloServicio = NULLIF(CxcAnticipoArticuloServicio,'')    FROM EmpresaCfg2
   WHERE Empresa = @Empresa  
 --REQ 15448     


  SELECT @CfgMoverNotasAuto = ISNULL(MoverNotasAuto, 0), @GenerarNCAlProcesar = ISNULL(GenerarNCAlProcesar,0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @AfectandoNotasSinCobro = 0
  IF @Accion <> 'CANCELAR' 
  BEGIN
    -- Esto es el caso de Factura Aseguradora
    IF NOT EXISTS(SELECT * FROM Venta v, VentaOrigen o WHERE v.ID = o.OrigenID AND o.ID = @ID)
      SELECT @AfectandoNotasSinCobro = 1
    ELSE BEGIN
      DECLARE @ChecarNotas TABLE (
        Articulo		char(20)	COLLATE Database_Default NULL, 
        SubCuenta		varchar(50)	COLLATE Database_Default NULL, 
        Cantidad		float		NULL)
  
 --REQ 15448
      IF @GenerarNCAlProcesar = 1
      BEGIN
      
        IF @MovTipo = 'VTAS.F'
        BEGIN
          INSERT INTO @ChecarNotas (Articulo, SubCuenta, Cantidad)
          SELECT Articulo, SubCuenta, SUM(ISNULL(Cantidad, 0.0))
            FROM Venta v, VentaD d, VentaOrigen o 
            WHERE v.ID = o.OrigenID 
              AND v.ID = d.ID
              AND o.ID = @ID
              AND ((d.Cantidad > 0.0)OR d.Articulo IN (@CfgAnticipoArticuloServicio,@ArtOfertaFP,@ArtOfertaImporte ))
          
            GROUP BY Articulo, SubCuenta
           UNION
           SELECT Articulo, SubCuenta, -SUM(ISNULL(Cantidad, 0.0))
             FROM VentaD 
            WHERE ID = @ID
            GROUP BY Articulo, SubCuenta
            ORDER BY Articulo, SubCuenta

            
          IF (SELECT ROUND(SUM(Cantidad), 0) FROM @ChecarNotas) <> 0 SELECT @Ok = 20380
        
        END
        IF @MovTipo = 'VTAS.D'
        BEGIN
                     
          INSERT INTO @ChecarNotas (Articulo, SubCuenta, Cantidad)
          SELECT Articulo, SubCuenta, -SUM(ISNULL(Cantidad, 0.0))
            FROM Venta v, VentaD d, VentaOrigen o 
            WHERE v.ID = o.OrigenID 
              AND v.ID = d.ID
              AND o.ID = @ID

              AND ((d.Cantidad < 0.0) AND d.Articulo NOT IN (@CfgAnticipoArticuloServicio,@ArtOfertaFP,@ArtOfertaImporte ))           
            GROUP BY Articulo, SubCuenta
           UNION
           SELECT Articulo, SubCuenta, -SUM(ISNULL(Cantidad, 0.0))
             FROM VentaD 
            WHERE ID = @ID
            GROUP BY Articulo, SubCuenta
            ORDER BY Articulo, SubCuenta
            
         

        END        
      END 
      ELSE
      BEGIN         
        INSERT INTO @ChecarNotas (Articulo, SubCuenta, Cantidad)
        SELECT Articulo, SubCuenta, SUM(ISNULL(Cantidad, 0.0))
          FROM Venta v, VentaD d, VentaOrigen o 
          WHERE v.ID = o.OrigenID 
            AND v.ID = d.ID
            AND o.ID = @ID
          GROUP BY Articulo, SubCuenta
         UNION
         SELECT Articulo, SubCuenta, -SUM(ISNULL(Cantidad, 0.0))
           FROM VentaD 
          WHERE ID = @ID
          GROUP BY Articulo, SubCuenta
          ORDER BY Articulo, SubCuenta
        IF (SELECT ROUND(SUM(Cantidad), 0) FROM @ChecarNotas) <> 0 SELECT @Ok = 20380
      END

      IF @Ok = 20380 AND EXISTS(SELECT * FROM Venta v, VentaOrigen o, MovTipo mt WHERE v.ID = o.OrigenID AND o.ID = @ID AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.NO')
        SELECT @Ok = NULL
    END
  END
  IF @Ok IS NULL
  BEGIN
    IF @CfgMoverNotasAuto = 1 AND @Accion = 'CANCELAR' AND @Ok IS NULL
    BEGIN
      DECLARE crRegresarNota CURSOR LOCAL FOR 
       SELECT OrigenID
         FROM VentaOrigen
        WHERE ID = @ID
      OPEN crRegresarNota
      FETCH NEXT FROM crRegresarNota INTO @IDNota
      WHILE @@FETCH_STATUS <> -1 
      BEGIN   
        IF @@FETCH_STATUS <> -2 
        BEGIN
          EXEC spMoverNota @IDNota, 'REGRESAR'
        END
        FETCH NEXT FROM crRegresarNota INTO @IDNota
      END
      CLOSE crRegresarNota
      DEALLOCATE crRegresarNota
    END
    

    DECLARE crVentaOrigen CURSOR LOCAL FOR 
     SELECT v.ID, v.Mov, v.MovID, v.Moneda, v.TipoCambio, v.Cliente, ISNULL(v.Importe, 0)+ISNULL(v.Impuestos, 0), v.Estatus, mt.Clave
       FROM Venta v, VentaOrigen o, MovTipo mt
      WHERE v.ID = o.OrigenID AND o.ID = @ID AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov

     
    OPEN crVentaOrigen
    FETCH NEXT FROM crVentaOrigen INTO @IDNota, @NotaMov, @NotaMovID, @NotaMoneda, @NotaTipoCambio, @NotaCliente, @NotaImporteTotal, @NotaEstatus, @NotaMovTipo
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN   
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @NotaMovTipo IN ('VTAS.NO', 'VTAS.NR') SELECT @AfectandoNotasSinCobro = 1
        IF (@Accion  = 'CANCELAR' AND @NotaEstatus <> 'CONCLUIDO' AND @MovTipo NOT IN('VTAS.FM')) OR
           (@Accion <> 'CANCELAR' AND @NotaEstatus <> 'PROCESAR' AND @MovTipo NOT IN('VTAS.FM')) 
         SELECT @Ok = 20380, @OkRef = RTRIM(@NotaMov)+' '+RTRIM(Convert(char, @NotaMovID))

        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @IDNota, @NotaMov, @NotaMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT 
--REQ 15448        
        IF @GenerarNCAlProcesar = 1
        BEGIN
          IF @Accion <> 'CANCELAR'
          BEGIN
 
            UPDATE VentaD SET ProcesadoID = vpt.ID
              FROM  VentaProcesarNotas vpt JOIN VentaD d ON d.ID = vpt.IDOrigen AND d.Renglon = vpt.Renglon AND d.RenglonSub = vpt.RenglonSub
             WHERE  vpt.IDOrigen = @IDNota AND d.ID = @IDNota AND vpt.ID = @ID
             
            IF EXISTS (SELECT * FROM VentaD WHERE ID = @IDNota AND  ProcesadoID  IS NULL)   
              SELECT @NotaEstatusNuevo = 'PROCESAR'   
            ELSE       
              SELECT @NotaEstatusNuevo = 'CONCLUIDO'      
          END
          ELSE          
          IF @Accion = 'CANCELAR'
          BEGIN
            UPDATE VentaD SET ProcesadoID = NULL
             WHERE ID = @IDNota AND ProcesadoID = @ID
             
            DELETE   VentaProcesarNotas WHERE IDOrigen = @IDNota AND ID = @ID
             
            SELECT @NotaEstatusNuevo = 'PROCESAR' 
          END     
        END  
        ELSE       
        SELECT @NotaEstatusNuevo = CASE @Accion WHEN 'CANCELAR' THEN 'PROCESAR' ELSE 'CONCLUIDO' END

        EXEC spValidarTareas @Empresa, @Modulo, @IDNota, @NotaEstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Venta 
           SET Saldo = NULL,
               Estatus = @NotaEstatusNuevo
         WHERE ID = @IDNota
        IF @@ERROR <> 0 SELECT @Ok = 1

        IF @NotaMovTipo = 'VTAS.NO' 
        BEGIN
          SELECT @EsCargo = 0
          IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo
          EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'CNO', @NotaMoneda, @NotaTipoCambio, @NotaCliente, NULL, NULL, NULL,
                       @Modulo, @IDNota, @NotaMov, @NotaMovID, @EsCargo, @NotaImporteTotal, NULL, NULL,
                       @FechaAfectacion, @Ejercicio, @Periodo, 'Consumos', NULL, 0, 0, 0,
	    	       @Ok OUTPUT, @OkRef OUTPUT
        END        
        IF @CfgMoverNotasAuto = 1 AND @NotaMovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR') AND @Accion <> 'CANCELAR' 
          EXEC spMoverNota @IDNota, 'MOVER'
      END
      IF @Ok IS NULL
        FETCH NEXT FROM crVentaOrigen INTO @IDNota, @NotaMov, @NotaMovID, @NotaMoneda, @NotaTipoCambio, @NotaCliente, @NotaImporteTotal, @NotaEstatus, @NotaMovTipo
    END
    CLOSE crVentaOrigen
    DEALLOCATE crVentaOrigen
  END
  RETURN
END
GO

/**************** spAfectarCambioPresentacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarCambioPresentacion') and type = 'P') drop procedure dbo.spAfectarCambioPresentacion
GO              
CREATE PROCEDURE spAfectarCambioPresentacion
		   @Sucursal			int,
                   @ID  			int, 
                   @Empresa			char(5),
                   @MovMoneda			char(10),
		   @MovTipoCambio		float,
    		   @CfgMultiUnidades		bit,
    		   @CfgMultiUnidadesNivel	char(20),
    		   @CfgFormaCosteo    		char(20),
    		   @CfgTipoCosteo     		char(20),

                   @Ok 				int		OUTPUT, 
                   @OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @ArtMoneda		char(10),
    @ArtFactor		float,
    @ArtTipoCambio	float,
    @ArtTipoCosteo	char(20),
    @ArtCostoEstandar	float, 
    @ArtCostoReposicion	float,
    @TipoCosteo		char(20),
    @Cantidad		float,
    @NuevaCantidad	float,
    @MovUnidad		varchar(50),
    @ArticuloDestino	char(20),
    @SubCuentaDestino	varchar(50),
    @Almacen		char(10),
    @Renglon		float,    
    @RenglonID		int,    
    @UltRenglonID	int,    
    @Costo		float,
    @NuevoCosto		float,
    @Factor 		float,
    @CPSobrante		float,
    @CPCantidad		float,
    @CantidadInventario	float,
    @Unidad		varchar(50),
    @UnidadFactor	float,
    @Decimales		int,
    @SerieLote          varchar(50),
    @Propiedades        varchar(50)

  --arcc
  --BEGIN TRANSACTION 

  SELECT @UltRenglonID = ISNULL(MAX(RenglonID), 0) FROM InvD WHERE ID = @ID

  DECLARE crGenerarCambioPresentacion CURSOR FOR 
   SELECT Renglon, RenglonID, Articulo, SubCuenta, ISNULL(Cantidad, 0.0), ISNULL(CantidadInventario, Cantidad), NULLIF(UPPER(RTRIM(ArticuloDestino)), ''), NULLIF(RTRIM(SubCuentaDestino), ''), Unidad, Almacen
     FROM InvD
    WHERE ID = @ID

  OPEN crGenerarCambioPresentacion
  FETCH NEXT FROM crGenerarCambioPresentacion INTO @Renglon, @RenglonID, @Articulo, @SubCuenta, @Cantidad, @CantidadInventario, @ArticuloDestino, @SubCuentaDestino, @MovUnidad, @Almacen
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL 
  BEGIN   
    IF @@FETCH_STATUS <> -2 AND @Articulo IS NOT NULL AND @Cantidad > 0.0 AND @ArticuloDestino IS NOT NULL
    BEGIN
      SELECT @Factor = 1.0, @Costo = NULL

      SELECT @UnidadFactor = 1.0
      IF @Cantidad <> @CantidadInventario
        SELECT @UnidadFactor = @CantidadInventario / @Cantidad
      ELSE
        IF @CfgMultiUnidades = 1
        BEGIN
          IF @CfgMultiUnidadesNivel = 'ARTICULO'
            EXEC xpArtUnidadFactor @Articulo, @SubCuenta, @MovUnidad, @UnidadFactor OUTPUT, @Decimales OUTPUT, NULL
          ELSE
            EXEC xpUnidadFactor @Articulo, @SubCuenta, @MovUnidad, @UnidadFactor OUTPUT, @Decimales OUTPUT
        END
 
      SELECT @Factor             = ISNULL(p.Factor, 1.0),
             @ArtMoneda	         = NULLIF(RTRIM(a.MonedaCosto), ''),
             @ArtTipoCosteo      = ISNULL(NULLIF(RTRIM(a.TipoCosteo), ''), @CfgTipoCosteo),
             @ArtCostoEstandar   = a.CostoEstandar,
             @ArtCostoReposicion = a.CostoReposicion
        FROM ArtPresenta p, Art a
       WHERE p.Articulo      = @Articulo
         AND p.Presentacion  = @ArticuloDestino
         AND a.Articulo      = @Articulo
      IF @@ROWCOUNT = 0 SELECT @Ok = 20250, @OkRef = @ArticuloDestino
      
      IF @@ERROR <> 0 SELECT @Ok = 1
      IF @CfgFormaCosteo = 'EMPRESA' SELECT @TipoCosteo = @CfgTipoCosteo ELSE SELECT @TipoCosteo = @ArtTipoCosteo
      EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, @SubCuenta, @MovUnidad, @TipoCosteo, @MovMoneda, @MovTipoCambio, @NuevoCosto OUTPUT, 0      

      -- Calcular MonedaFactor
      IF @Ok IS NULL
        EXEC spMoneda NULL, @MovMoneda, @MovTipoCambio, @ArtMoneda, @ArtFactor OUTPUT, @ArtTipoCambio OUTPUT, @Ok OUTPUT

      IF @Ok IS NULL
      BEGIN
        SELECT @CPSobrante = ISNULL(Convert(int, @Cantidad) % NULLIF(Convert(int, 1/@Factor), 0), 0)
        IF @@ERROR <> 0 SELECT @Ok = 1

        SELECT @CPCantidad = ISNULL((@Cantidad - @CPSobrante) * @Factor, 0)
        IF @@ERROR <> 0 SELECT @Ok = 1

        UPDATE InvD SET Cantidad = -(@Cantidad - @CPSobrante), Costo = NULL, ArticuloDestino = NULL WHERE CURRENT OF crGenerarCambioPresentacion
        IF @@ERROR <> 0 SELECT @Ok = 1

        SELECT @Renglon = @Renglon + 1--, @NuevoCosto = (@Costo / @Factor) * @ArtFactor * @UnidadFactor
        SELECT @NuevoCosto = @NuevoCosto / @Factor, @CantidadInventario = @CantidadInventario * @Factor
        IF @@ERROR <> 0 SELECT @Ok = 1

        EXEC xpCambioPresentacionUnidad @ArticuloDestino, @MovUnidad OUTPUT
        SELECT @UltRenglonID = @UltRenglonID + 1

        INSERT INTO InvD (Sucursal,  ID,  Renglon,  RenglonID,     Articulo,         SubCuenta,         Cantidad,    CantidadInventario,  Costo,       Unidad,     Almacen)
                  VALUES (@Sucursal, @ID, @Renglon, @UltRenglonID, @ArticuloDestino, @SubCuentaDestino, @CPCantidad, @CantidadInventario, @NuevoCosto, @MovUnidad, @Almacen)

        DECLARE crSerieLote CURSOR LOCAL FOR 
         SELECT SerieLote
           FROM SerieLoteMov
          WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') 
        OPEN crSerieLote
        FETCH NEXT FROM crSerieLote INTO @SerieLote
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          SELECT  @Propiedades = NULLIF(RTRIM(Propiedades), '')
            FROM SerieLote
           WHERE Sucursal  = @Sucursal
             AND Empresa   = @Empresa 
             AND Articulo  = @Articulo 
             AND SubCuenta = ISNULL(@SubCuenta,'') 
             AND SerieLote = @SerieLote
          UPDATE SerieLoteMov SET Propiedades = @Propiedades 
           WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') 
          FETCH NEXT FROM crSerieLote INTO @SerieLote
        END
        CLOSE crSerieLote
        DEALLOCATE crSerieLote          
         
        INSERT SerieLoteMov (Empresa, Modulo, ID,  RenglonID,     Articulo,         SubCuenta,                     SerieLote, Propiedades, ArtCostoInv, Cantidad,         CantidadAlterna,         Sucursal)
                     SELECT Empresa,  'INV',  @ID, @UltRenglonID, @ArticuloDestino, ISNULL(@SubCuentaDestino, ''), SerieLote, Propiedades, ArtCostoInv, Cantidad*@Factor, CantidadAlterna*@Factor, Sucursal
                       FROM SerieLoteMov
                      WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')


        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END
    FETCH NEXT FROM crGenerarCambioPresentacion INTO @Renglon, @RenglonID, @Articulo, @SubCuenta, @Cantidad, @CantidadInventario, @ArticuloDestino, @SubCuentaDestino, @MovUnidad, @Almacen
    IF @@ERROR <> 0 SELECT @Ok = 1
  END 
  CLOSE crGenerarCambioPresentacion
  DEALLOCATE crGenerarCambioPresentacion
  

  IF @Ok IS NULL
    UPDATE Inv SET RenglonID = @UltRenglonID WHERE ID = @ID
  --arcc  
  --BEGIN    
  --  COMMIT TRANSACTION
  --END ELSE
  --  ROLLBACK TRANSACTION

  RETURN
END
GO

-- spInvReCalcEncabezado 9, 'COMS', 0, 0, 20, 0
-- select Importe, Impuestos,* from compra where id = 8
-- select Importe, Impuestos,* from Venta where id = 91
-- spInvReCalcEncabezado 91, 'VTAS', 0, 0, 0, 0

/**************** spInvReCalcEncabezado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvReCalcEncabezado') and type = 'P') drop procedure dbo.spInvReCalcEncabezado
GO             
CREATE PROCEDURE spInvReCalcEncabezado
    		   @ID          	int,
		   @Modulo		char(5),
		   @CfgImpInc		bit,
		   @CfgMultiUnidades	bit,
		   @DescuentoGlobal 	float,
		   @SobrePrecio 	float = NULL,
		   @CalcComisiones	bit = 0,
		   @CfgPrecioMoneda	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		    char(5), 
    @Usuario		    char(10), 
    @Sucursal		    int,
    @Mov		    char(20), 
    @MovID		    varchar(20), 
    @MovTipo		    char(20),
    @MovMoneda		    char(10), 
    @MovTipoCambio	    float,
    @FechaEmision           datetime,
    @FechaRegistro          datetime,
    @Agente		    char(10),
    @Renglon		    float,
    @RenglonSub		    int,
    @Articulo		    char(20),
    @MovUnidad		    varchar(50),
    @Cantidad		    float,
    @CantidadObsequio	    float,
    @CantidadPendiente	    float,
    @Factor		    float,
    @Precio		    float,
    @PrecioTipoCambio	    float,
    @Costo		    float,
    @DescuentoTipo	    char(1),
    @DescuentoLinea	    float,
    @ImporteComision	    money,
    @Peso		    float,
    @Volumen		    float,
    @Impuesto1		    float,
    @Impuesto2		    float,
    @Impuesto3		    float,
    @Impuesto5		    float,
    @Retencion1		    float,
    @Retencion2		    float,
    @Retencion3		    float,
    @Importe 		    money, 
    @ImporteNeto	    money, 
    @Impuestos 		    money,
    @ImpuestosNetos	    money,
    @Impuesto1Neto 	    money,
    @Impuesto2Neto 	    money,
    @Impuesto3Neto 	    money,
    @Impuesto5Neto 	    money,
    @DescuentoLineaImporte  money, 
    @DescuentoGlobalImporte money,
    @SobrePrecioImporte	    money,
    @SumaImporte	    money,
    @SumaImporteNeto	    money,
    @SumaImpuestos	    money,
    @SumaImpuestosNetos	    money,
    @SumaImpuesto1Neto	    money,
    @SumaImpuesto2Neto	    money,
    @SumaImpuesto3Neto	    money,
    @SumaImpuesto5Neto	    money,
    @SumaDescuentoLinea	    money,
    @SumaPrecioLinea	    money,
    @SumaCostoLinea	    money,
    @SumaPeso		    float,
    @SumaVolumen	    float,
    @SumaComision	    money, 
    @SumaTotal	    	    money,
    @SumaSaldo	    	    money,
    @Ok			    int,
    @OkRef		    varchar(255),	
    @RedondeoMonetarios	    int,
    @AnticipoFacturado bit--ANTICIPOFACTURADO

  SELECT @RedondeoMonetarios = RedondeoMonetarios FROM Version 
  SELECT @Ok			= NULL,
         @OkRef			= NULL,
         @CantidadObsequio	= NULL, 
         @FechaRegistro		= GETDATE(),
	 @SumaImporte    	= 0.0,
         @SumaImporteNeto    	= 0.0,
         @SumaImpuestos	    	= 0.0,
         @SumaImpuestosNetos   	= 0.0,
         @SumaImpuesto1Neto    	= 0.0,
         @SumaImpuesto2Neto    	= 0.0,
         @SumaImpuesto3Neto    	= 0.0,
	 @SumaDescuentoLinea	= 0.0,
         @SumaComision		= 0.0,
         @SumaPrecioLinea	= 0.0,
         @SumaCostoLinea	= 0.0,
    	 @SumaPeso		= 0.0,
    	 @SumaVolumen		= 0.0,
         @SumaTotal		= 0.0,
         @SumaSaldo		= 0.0,
         @AnticipoFacturado = 0 --ANTICIPOFACTURADO

  IF @Modulo = 'VTAS'
  BEGIN
    SELECT @Empresa = e.Empresa, @Usuario = e.Usuario, @Sucursal = e.Sucursal, @Mov = e.Mov, @MovID = e.MovID, @MovTipo = mt.Clave, @MovMoneda = e.Moneda, @MovTipoCambio = e.TipoCambio, @FechaEmision = e.FechaEmision, @Agente = e.Agente
      FROM Venta e, MovTipo mt
     WHERE e.ID = @ID AND mt.Modulo = @Modulo AND mt.Mov = e.Mov

    DECLARE crVentaDetalleRecalc CURSOR LOCAL FOR
     SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Factor, NULLIF(RTRIM(d.Unidad), ''), (ISNULL(d.Cantidad, 0.0)-ISNULL(d.CantidadCancelada, 0.0)), d.CantidadObsequio, (ISNULL(d.CantidadPendiente, 0.0)+ISNULL(d.CantidadReservada, 0.0)+ISNULL(d.CantidadOrdenada, 0.0)), ISNULL(d.Costo, 0.0), ISNULL(d.Precio, 0.0), NULLIF(RTRIM(d.DescuentoTipo), ''), ISNULL(d.DescuentoLinea, 0.0), ISNULL(d.Impuesto1, 0.0), ISNULL(d.Impuesto2, 0.0), ISNULL(d.Impuesto3, 0.0), ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0), d.Agente, ISNULL(d.Comision, 0.0), d.PrecioTipoCambio, d.AnticipoFacturado --ANTICIPOFACTURADO
       FROM VentaD d, Art a
      WHERE d.ID = @ID
        AND d.Articulo = a.Articulo
    OPEN crVentaDetalleRecalc
    FETCH NEXT FROM crVentaDetalleRecalc INTO @Renglon, @RenglonSub, @Articulo, @Factor, @MovUnidad, @Cantidad, @CantidadObsequio, @CantidadPendiente, @Costo, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @Peso, @Volumen, @Agente, @ImporteComision, @PrecioTipoCambio, @AnticipoFacturado --ANTICIPOFACTURADO
  END ELSE
  IF @Modulo = 'COMS'
  BEGIN
    SELECT @Empresa = e.Empresa, @Usuario = e.Usuario, @Sucursal = e.Sucursal, @Mov = e.Mov, @MovID = e.MovID, @MovTipo = mt.Clave, @MovMoneda = e.Moneda, @MovTipoCambio = e.TipoCambio, @FechaEmision = e.FechaEmision, @Agente = e.Agente
      FROM Compra e, MovTipo mt
     WHERE e.ID = @ID AND mt.Modulo = @Modulo AND mt.Mov = e.Mov

     DECLARE crCompraDetalleRecalc CURSOR LOCAL FOR
      SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Factor, NULLIF(RTRIM(d.Unidad), ''), (ISNULL(d.Cantidad, 0.0)-ISNULL(d.CantidadCancelada, 0.0)), (ISNULL(d.CantidadPendiente, 0.0)), ISNULL(d.Costo, 0.0), NULLIF(RTRIM(d.DescuentoTipo), ''), ISNULL(d.DescuentoLinea, 0.0), ISNULL(d.Impuesto1, 0.0), ISNULL(d.Impuesto2, 0.0), ISNULL(d.Impuesto3, 0.0), ISNULL(d.Impuesto5, 0.0), ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0), d.Retencion1, d.Retencion2, d.Retencion3
        FROM CompraD d, Art a
       WHERE d.ID = @ID
         AND d.Articulo = a.Articulo
    OPEN crCompraDetalleRecalc
    FETCH NEXT FROM crCompraDetalleRecalc INTO @Renglon, @RenglonSub, @Articulo, @Factor, @MovUnidad, @Cantidad, @CantidadPendiente, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @Peso, @Volumen, @Retencion1, @Retencion2, @Retencion3
  END ELSE
  IF @Modulo = 'INV'
  BEGIN
    SELECT @Empresa = e.Empresa, @Usuario = e.Usuario, @Sucursal = e.Sucursal, @Mov = e.Mov, @MovID = e.MovID, @MovTipo = mt.Clave, @MovMoneda = e.Moneda, @MovTipoCambio = e.TipoCambio, @FechaEmision = e.FechaEmision, @Agente = e.Agente
      FROM Inv e, MovTipo mt
     WHERE e.ID = @ID AND mt.Modulo = @Modulo AND mt.Mov = e.Mov

    DECLARE crInvDetalleRecalc CURSOR LOCAL FOR
     SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Factor, NULLIF(RTRIM(d.Unidad), ''), (ISNULL(d.Cantidad, 0.0)-ISNULL(d.CantidadCancelada, 0.0)), (ISNULL(d.CantidadPendiente, 0.0)+ISNULL(d.CantidadReservada, 0.0)+ISNULL(d.CantidadOrdenada, 0.0)), ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0)
       FROM InvD d, Art a
      WHERE d.ID = @ID
        AND d.Articulo = a.Articulo
    OPEN crInvDetalleRecalc
    FETCH NEXT FROM crInvDetalleRecalc INTO @Renglon, @RenglonSub, @Articulo, @Factor, @MovUnidad, @Cantidad, @CantidadPendiente, @Peso, @Volumen
  END ELSE
  IF @Modulo = 'PROD'
  BEGIN
    SELECT @Empresa = e.Empresa, @Usuario = e.Usuario, @Sucursal = e.Sucursal, @Mov = e.Mov, @MovID = e.MovID, @MovTipo = mt.Clave, @MovMoneda = e.Moneda, @MovTipoCambio = e.TipoCambio, @FechaEmision = e.FechaEmision--, @Agente = e.Agente
      FROM Prod e, MovTipo mt
     WHERE e.ID = @ID AND mt.Modulo = @Modulo AND mt.Mov = e.Mov

    DECLARE crProdDetalleRecalc CURSOR FOR
     SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Factor, NULLIF(RTRIM(d.Unidad), ''), (ISNULL(d.Cantidad, 0.0)-ISNULL(d.CantidadCancelada, 0.0)), (ISNULL(d.CantidadPendiente, 0.0)+ISNULL(d.CantidadReservada, 0.0)+ISNULL(d.CantidadOrdenada, 0.0)), ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0)
       FROM ProdD d, Art a
      WHERE d.ID = @ID
        AND d.Articulo = a.Articulo
    OPEN crProdDetalleRecalc
    FETCH NEXT FROM crProdDetalleRecalc INTO @Renglon, @RenglonSub, @Articulo, @Factor, @MovUnidad, @Cantidad, @CantidadPendiente, @Peso, @Volumen
  END

  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Cantidad <> 0.0 
    BEGIN
      EXEC spCalculaImporte NULL, @Modulo, @CfgImpInc, NULL, NULL, @Cantidad, @Precio, @DescuentoTipo, @DescuentoLinea, @DescuentoGlobal, @SobrePrecio, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5,
                            @Importe OUTPUT, @ImporteNeto OUTPUT, @DescuentoLineaImporte OUTPUT, @DescuentoGlobalImporte OUTPUT, @SobrePrecioImporte OUTPUT, 
                            @Impuestos OUTPUT, @ImpuestosNetos OUTPUT, @Impuesto1Neto OUTPUT, @Impuesto2Neto OUTPUT, @Impuesto3Neto OUTPUT, @Impuesto5Neto OUTPUT, 
			    @Articulo = @Articulo, @CantidadObsequio = @CantidadObsequio, @CfgPrecioMoneda = @CfgPrecioMoneda, @MovTipoCambio = @MovTipoCambio, @PrecioTipoCambio = @PrecioTipoCambio,
			    @Retencion1 = @Retencion1, @Retencion2 = @Retencion2, @Retencion3 = @Retencion3, @ID = @ID, @AnticipoFacturado = @AnticipoFacturado --ANTICIPOFACTURADO

      IF @CalcComisiones = 1 AND @Modulo = 'VTAS'
      BEGIN
        EXEC xpComisionCalcular @ID, 'AFECTAR', @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
      	             	        @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaRegistro, @FechaRegistro, @Agente, 0, 0, @Sucursal,
		  	        @Renglon, @RenglonSub, @Articulo, @Cantidad, @Importe, @ImporteNeto, @Impuestos, @ImpuestosNetos, @Costo, NULL, NULL,
                                @ImporteComision OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE VentaD SET Comision = @ImporteComision WHERE CURRENT OF crVentaDetalleRecalc
      END

      SELECT @SumaImporte         = @SumaImporte         + @Importe,
             @SumaImporteNeto     = @SumaImporteNeto     + @ImporteNeto,
             @SumaImpuestos       = @SumaImpuestos 	 + @Impuestos,
             @SumaImpuestosNetos  = @SumaImpuestosNetos  + @ImpuestosNetos,
             @SumaImpuesto1Neto   = @SumaImpuesto1Neto   + @Impuesto1Neto,
             @SumaImpuesto2Neto   = @SumaImpuesto2Neto   + @Impuesto2Neto,
             @SumaImpuesto3Neto   = @SumaImpuesto3Neto   + @Impuesto3Neto,
             @SumaImpuesto5Neto   = @SumaImpuesto5Neto   + @Impuesto5Neto,
             @SumaCostoLinea      = @SumaCostoLinea      + ROUND(@Costo * @Cantidad, @RedondeoMonetarios),
             @SumaPrecioLinea     = @SumaPrecioLinea     + ROUND(@Precio * @Cantidad, @RedondeoMonetarios),
             @SumaDescuentoLinea  = @SumaDescuentoLinea  + @DescuentoLineaImporte,
             @SumaPeso	          = @SumaPeso            + (@Cantidad * @Peso * @Factor),
             @SumaVolumen	  = @SumaVolumen         + (@Cantidad * @Volumen * @Factor),
             @SumaComision	  = @SumaComision        + ISNULL(@ImporteComision, 0.0),
             @SumaTotal           = @SumaTotal           + @Importe + ISNULL(@ImpuestosNetos,0.0),
             @SumaSaldo           = @SumaSaldo           + ISNULL((@CantidadPendiente * (@Importe + @ImpuestosNetos)) / NULLIF(@Cantidad, 0), 0)
    END
    IF @Modulo = 'VTAS' FETCH NEXT FROM crVentaDetalleRecalc  INTO @Renglon, @RenglonSub, @Articulo, @Factor, @MovUnidad, @Cantidad, @CantidadObsequio, @CantidadPendiente, @Costo, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @Peso, @Volumen, @Agente, @ImporteComision, @PrecioTipoCambio, @AnticipoFacturado ELSE--ANTICIPOFACTURADO
    IF @Modulo = 'COMS' FETCH NEXT FROM crCompraDetalleRecalc INTO @Renglon, @RenglonSub, @Articulo, @Factor, @MovUnidad, @Cantidad, @CantidadPendiente, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @Peso, @Volumen, @Retencion1, @Retencion2, @Retencion3 ELSE
    IF @Modulo = 'INV'  FETCH NEXT FROM crInvDetalleRecalc    INTO @Renglon, @RenglonSub, @Articulo, @Factor, @MovUnidad, @Cantidad, @CantidadPendiente, @Peso, @Volumen ELSE
    IF @Modulo = 'PROD' FETCH NEXT FROM crProdDetalleRecalc   INTO @Renglon, @RenglonSub, @Articulo, @Factor, @MovUnidad, @Cantidad, @CantidadPendiente, @Peso, @Volumen
  END
  IF @Modulo = 'VTAS' 
  BEGIN 
    SELECT @SumaTotal = ROUND(@SumaTotal, ISNULL(VentaCobroRedondeoDecimales, @RedondeoMonetarios))
      FROM EmpresaCfg
     WHERE Empresa = @Empresa
    IF @CfgImpInc = 1      
      SELECT @SumaImporte = @SumaImporte - (@SumaImporte + ISNULL(@SumaImpuestosNetos,0.0) - @SumaTotal)
    UPDATE Venta SET Peso = @SumaPeso, Volumen = @SumaVolumen, Importe = @SumaImporte, Impuestos = @SumaImpuestosNetos, DescuentoLineal = @SumaDescuentoLinea, ComisionTotal = @SumaComision, PrecioTotal = @SumaPrecioLinea, CostoTotal = @SumaCostoLinea, IVAFiscal = CONVERT(float, @SumaImpuesto1Neto)/NULLIF(@SumaTotal, 0), IEPSFiscal = CONVERT(float, @SumaImpuesto2Neto)/NULLIF(@SumaTotal, 0), Saldo = @SumaSaldo WHERE ID = @ID 
    IF @@ERROR <> 0 SELECT @Ok = 1
    CLOSE crVentaDetalleRecalc
    DEALLOCATE crVentaDetalleRecalc
  END ELSE 
  IF @Modulo = 'COMS' 
  BEGIN 
    UPDATE Compra SET Peso = @SumaPeso, Volumen = @SumaVolumen, Importe = @SumaImporte, Impuestos = @SumaImpuestosNetos, DescuentoLineal = @SumaDescuentoLinea, IVAFiscal = CONVERT(float, @SumaImpuesto1Neto)/NULLIF(@SumaTotal, 0), IEPSFiscal = CONVERT(float, @SumaImpuesto2Neto)/NULLIF(@SumaTotal, 0), Saldo = @SumaSaldo WHERE ID = @ID 
    CLOSE crCompraDetalleRecalc
    DEALLOCATE crCompraDetalleRecalc
  END ELSE 
  IF @Modulo = 'INV' 
  BEGIN 
    UPDATE Inv SET Peso = @SumaPeso, Volumen = @SumaVolumen, Importe = @SumaCostoLinea WHERE ID = @ID 
    CLOSE crInvDetalleRecalc
    DEALLOCATE crInvDetalleRecalc
  END ELSE 
  IF @Modulo = 'PROD' 
  BEGIN 
    UPDATE Prod SET Peso = @SumaPeso, Volumen = @SumaVolumen, Importe = @SumaCostoLinea WHERE ID = @ID 
    CLOSE crProdDetalleRecalc
    DEALLOCATE crProdDetalleRecalc
  END
END
GO

/**************** spInvReCalcEncabezadoSimple ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvReCalcEncabezadoSimple') and type = 'P') drop procedure dbo.spInvReCalcEncabezadoSimple
GO             
CREATE PROCEDURE spInvReCalcEncabezadoSimple
                   @Empresa             char(5),
    		   @ID          	int,
		   @Modulo		char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgImpInc        bit,
    @CfgPrecioMoneda  bit,
    @CfgMultiUnidades bit,
    @DescuentoGlobal  float,
    @SobrePrecio      float

  SELECT @DescuentoGlobal = NULL, @SobrePrecio = NULL
  SELECT @CfgImpInc = VentaPreciosImpuestoIncluido, @CfgPrecioMoneda = VentaPrecioMoneda FROM EmpresaCfg  WHERE Empresa = @Empresa 
  SELECT @CfgMultiUnidades = MultiUnidades         FROM EmpresaCfg2 WHERE Empresa = @Empresa 
  IF @Modulo = 'VTAS' SELECT @DescuentoGlobal = DescuentoGlobal, @SobrePrecio = SobrePrecio FROM Venta  WHERE ID = @ID ELSE
  IF @Modulo = 'COMS' SELECT @DescuentoGlobal = DescuentoGlobal FROM Compra WHERE ID = @ID 

  EXEC spInvReCalcEncabezado @ID, @Modulo, @CfgImpInc, @CfgMultiUnidades, @DescuentoGlobal, @SobrePrecio,
			     @CfgPrecioMoneda = @CfgPrecioMoneda

  RETURN
END
GO

/**************** spAfectarGastoDiverso ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarGastoDiverso') and type = 'P') drop procedure dbo.spAfectarGastoDiverso
GO             
CREATE PROCEDURE spAfectarGastoDiverso
		   @Sucursal			int,
		   @SucursalOrigen		int,
		   @SucursalDestino		int,
		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @ID                		int,
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @FechaRegistro    		datetime,
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @Referencia	      		varchar(50),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
		   @Ejercicio			int,
		   @Periodo			int,
		   @VIN				varchar(20),

    		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Concepto		 	  varchar(50), 
    @Acreedor		 	  char(10), 
    @Moneda		 	  char(10),
    @TipoCambio		 	  float,
    @Importe		 	  money, 
    @Retencion		 	  float, 
    @Retencion2		 	  float, 
    @Retencion3		 	  float, 
    @Impuestos		 	  money, 
    @PorcentajeImpuestos 	  float, 
    @FechaEmision	 	  datetime, 
    @Condicion		 	  varchar(50), 
    @Vencimiento	 	  datetime,
    @CxImporte			  money,
    @CxImpuestos		  money,
    @CxRetencion	  	  money,
    @CxRetencion2		  money,
    @CxRetencion3		  money,
    @CxModulo		 	  char(5),
    @CxpID			  int,
    @CxcID			  int,
    @CxMov		 	  char(20),
    @CxMovID		 	  varchar(20),
    @CxReferencia   		  varchar(50),
    @GastoID                      int,
    @GastoMov                     char(20),    
    @GastoMovID                   varchar(20),
    @GastoDiversoMov		  char(20),    
    @RenglonID			  int,
    @CfgRetencionAlPago		  bit,
    @CfgRetencionConcepto	  varchar(50), 
    @CfgRetencion2Concepto	  varchar(50), 
    @CfgRetencion3Concepto	  varchar(50), 
    @RetencionConcepto		  varchar(50), 
    @Retencion2Concepto		  varchar(50), 
    @Retencion3Concepto		  varchar(50), 
    @CfgRetencionAcreedor	  char(10),
    @CfgRetencion2Acreedor	  char(10),
    @CfgRetencion3Acreedor	  char(10),
    @CfgRetencionMov		  char(20),
    @CfgReferenciaGasto		  bit,
    @CfgCompraGastoDiversoCxc	  bit,
    @ReferenciaGasto   		  varchar(50),
    @CfgGastoDiversoSinProrratear varchar(20),
    @Prorrateo                    varchar(20),
    @Clase                        varchar(50),
    @SubClase                     varchar(50),
    @Cliente			  varchar(10),
    @PorcentajeDeducible          float,
    @CfgDefImpuesto		  float,
    @ImportacionImpuesto1	  money,
    @ImportacionImpuesto1IVA	  money,
    @ImportacionImpuesto2	  money,
    @ImportacionImpuesto2IVA	  money,
    @CfgMoneda			  char(10),
    @CfgImportacionImpuesto1Acreedor	  varchar(10),
    @CfgImportacionImpuesto1Concepto	  varchar(50),
    @CfgImportacionImpuesto2Acreedor	  varchar(10),
    @CfgImportacionImpuesto2Concepto	  varchar(50),
    @Fiscal				  bit,
    @FiscalGenerarRetenciones		  bit,
    @Impuesto1						float

  SELECT @Fiscal = ISNULL(Fiscal, 0)
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @CfgRetencionMov  = CxpRetencion,
         @GastoMov         = Gasto,
         @GastoDiversoMov  = CxpGastoDiverso
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @CfgRetencionAlPago	       = ISNULL(RetencionAlPago, 0),
         @CfgRetencionAcreedor         = NULLIF(RTRIM(GastoRetencionAcreedor), ''),
  	 @CfgRetencionConcepto         = NULLIF(RTRIM(GastoRetencionConcepto), ''),
         @CfgRetencion2Acreedor        = NULLIF(RTRIM(GastoRetencion2Acreedor), ''),
    	 @CfgRetencion2Concepto        = NULLIF(RTRIM(GastoRetencion2Concepto), ''),
         @CfgRetencion3Acreedor        = NULLIF(RTRIM(GastoRetencion3Acreedor), ''),
    	 @CfgRetencion3Concepto        = NULLIF(RTRIM(GastoRetencion3Concepto), ''),
         @CfgReferenciaGasto	       = GastoDiversoReferenciaCxp,
         @CfgGastoDiversoSinProrratear = UPPER(GastoDiversoSinProrratear),
         @CfgCompraGastoDiversoCxc     = ISNULL(CompraGastoDiversoCxc, 0),
         @FiscalGenerarRetenciones     = ISNULL(FiscalGenerarRetenciones, 0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF @Modulo = 'COMS'
    DECLARE crEGD CURSOR FOR
     SELECT Concepto, Acreedor, RenglonID, ISNULL(Importe, 0), ISNULL(Retencion, 0), ISNULL(Retencion2, 0), ISNULL(Retencion3, 0), ISNULL(Impuestos, 0), PorcentajeImpuestos, Moneda, TipoCambio, FechaEmision, Condicion, Vencimiento, Referencia, UPPER(Prorrateo)
       FROM CompraGastoDiverso
       WHERE ID = @ID
  IF @Modulo = 'INV'
    DECLARE crEGD CURSOR FOR
     SELECT Concepto, Acreedor, RenglonID, ISNULL(Importe, 0), ISNULL(Retencion, 0), ISNULL(Retencion2, 0), ISNULL(Retencion3, 0), ISNULL(Impuestos, 0), PorcentajeImpuestos, Moneda, TipoCambio, FechaEmision, Condicion, Vencimiento, Referencia, UPPER(Prorrateo)
       FROM InvGastoDiverso
       WHERE ID = @ID

  OPEN crEGD
  FETCH NEXT FROM crEGD INTO @Concepto, @Acreedor, @RenglonID, @Importe, @Retencion, @Retencion2, @Retencion3, @Impuestos, @PorcentajeImpuestos, @Moneda, @TipoCambio, @FechaEmision, @Condicion, @Vencimiento, @ReferenciaGasto, @Prorrateo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
       SELECT @CxpID = NULL, @GastoID = NULL
       IF @CfgReferenciaGasto = 1 SELECT @CxReferencia = @ReferenciaGasto ELSE SELECT @CxReferencia = @Referencia
      /*IF @Impuestos IS NULL
        SELECT @Impuestos = ROUND(@Importe * (@PorcentajeImpuestos/100), @RedondeoMonetarios)*/

      IF @CfgGastoDiversoSinProrratear = 'GASTOS' AND @Prorrateo = 'NO'
      BEGIN
        IF @Accion <> 'CANCELAR'
        BEGIN
          SELECT @PorcentajeDeducible = 100
          SELECT @Clase = Clase, @SubClase = SubClase, @PorcentajeDeducible = PorcentajeDeducible FROM Concepto WHERE Modulo = 'GAS' AND Concepto = @Concepto

          INSERT Gasto (Sucursal,  Empresa,  Mov,       FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      UltimoCambio, Acreedor,  Clase,  SubClase,  OrigenTipo, Origen, OrigenID, Prioridad)
                VALUES (@Sucursal, @Empresa, @GastoMov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', GETDATE(),    @Acreedor, @Clase, @SubClase, @Modulo,    @Mov,   @MovID,   'Normal')
          SELECT @GastoID = SCOPE_IDENTITY()
          IF @Importe >0  SELECT @Impuesto1 = (@Impuestos *100)/@Importe 
          INSERT GastoD (ID,       Renglon,  Concepto,  Fecha,         Referencia,    Cantidad,  Precio,   Importe,  Impuestos,  Retencion,  Retencion2,  Retencion3,  Sucursal,  PorcentajeDeducible,Impuesto1)
                 VALUES (@GastoID, 2048,     @Concepto, @FechaEmision, @CxReferencia, 1,         @Importe, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, @Sucursal, @PorcentajeDeducible,ROUND(@Impuesto1,2))
        END ELSE
          SELECT @GastoID = ID FROM Gasto WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')

        IF @GastoID IS NOT NULL
        BEGIN
          EXEC spGasto @GastoID, 'GAS', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @GastoMov, @GastoMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'GAS', @GastoID, @GastoMov, @GastoMovID, @Ok OUTPUT
        END ELSE
          SELECT @Ok = 30120, @OkRef = @GastoMov
      END ELSE
      BEGIN
        SELECT @CxImporte = @Importe, @CxImpuestos = @Impuestos, @CxRetencion = @Retencion, @CxRetencion2 = @Retencion2, @CxRetencion3 = @Retencion3

/** 04.08.2006 **/
        /*IF @CfgRetencionAlPago = 0
          SELECT @CxImporte = @CxImporte - @Retencion - @Retencion2 - @Retencion3, @CxRetencion = NULL, @CxRetencion2 = NULL, @CxRetencion3 = NULL*/

        IF @CfgRetencionAlPago = 0
          EXEC spExtraerFecha @FechaEmision OUTPUT

        EXEC @CxpID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Moneda, @TipoCambio, 
                                  @FechaEmision, @Concepto, @Proyecto, @Usuario, @Autorizacion, @CxReferencia, @DocFuente, @Observaciones,
         	   	          @FechaRegistro, @Ejercicio, @Periodo,
	        	          @Condicion, @Vencimiento, @Acreedor, NULL, NULL, 'DESGLOSE', NULL, NULL,
                                  @CxImporte, @CxImpuestos, @CxRetencion, NULL,
                                  NULL, NULL, NULL, NULL, @VIN, @GastoDiversoMov,
	         	          @CxModulo, @CxMov OUTPUT, @CxMovID OUTPUT,
                                  @Ok OUTPUT, @OkRef OUTPUT, @Retencion2 = @CxRetencion2, @Retencion3 = @CxRetencion3
        IF @CfgCompraGastoDiversoCxc = 1 AND @Modulo = 'COMS' AND @Ok IS NULL
        BEGIN
          SELECT @Cliente = NULLIF(RTRIM(Cliente), '') FROM Compra WHERE ID = @ID
          IF @Cliente IS NULL SELECT @Ok = 40010
          IF @Ok IS NULL 
            EXEC @CxcID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Moneda, @TipoCambio, 
                                      @FechaEmision, @Concepto, @Proyecto, @Usuario, @Autorizacion, @CxReferencia, @DocFuente, @Observaciones,
         	   	              @FechaRegistro, @Ejercicio, @Periodo,
	        	              @Condicion, @Vencimiento, @Cliente, NULL, NULL, 'CXC', NULL, NULL,
                                      @CxImporte, @CxImpuestos, @CxRetencion, NULL,
                                      NULL, NULL, NULL, NULL, @VIN, @GastoDiversoMov,
	         	              @CxModulo, @CxMov, @CxMovID,
                                      @Ok OUTPUT, @OkRef OUTPUT, @Retencion2 = @CxRetencion2, @Retencion3 = @CxRetencion3, @ModuloEspecifico = 'CXC', @MovIDEspecifico = @CxMovID
        END

        IF (@Fiscal = 0 OR @FiscalGenerarRetenciones = 1) AND @CfgRetencionAlPago = 0
        BEGIN
          EXEC spGastoConcepto @CfgRetencionConcepto,  @Concepto, @RetencionConcepto OUTPUT
          EXEC spGastoConcepto @CfgRetencion2Concepto, @Concepto, @Retencion2Concepto OUTPUT
          EXEC spGastoConcepto @CfgRetencion3Concepto, @Concepto, @Retencion3Concepto OUTPUT
          IF @Retencion <> 0.0
          BEGIN
            IF @CfgRetencionAcreedor IS NULL 
              SELECT @Ok = 70100
            ELSE
              EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Moneda, @TipoCambio, 
                               @FechaEmision, @RetencionConcepto, @Proyecto, @Usuario, @Autorizacion, @CxReferencia, @DocFuente, @Observaciones,
	  	               @FechaRegistro, @Ejercicio, @Periodo,
		               NULL, NULL, @CfgRetencionAcreedor, NULL, NULL, NULL, NULL, NULL,
                               @Retencion, NULL, NULL, NULL, 
                               NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		               @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                               @Ok OUTPUT, @OkRef OUTPUT
          END
          IF @Retencion2 <> 0.0
          BEGIN
            IF @CfgRetencion2Acreedor IS NULL 
              SELECT @Ok = 70100
            ELSE
              EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Moneda, @TipoCambio, 
                               @FechaEmision, @Retencion2Concepto, @Proyecto, @Usuario, @Autorizacion, @CxReferencia, @DocFuente, @Observaciones,
	    	               @FechaRegistro, @Ejercicio, @Periodo,
		               NULL, NULL, @CfgRetencion2Acreedor, NULL, NULL, NULL, NULL, NULL,
                               @Retencion2, NULL, NULL, NULL, 
                               NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		               @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                               @Ok OUTPUT, @OkRef OUTPUT
          END
          IF @Retencion3 <> 0.0
          BEGIN
            IF @CfgRetencion3Acreedor IS NULL 
              SELECT @Ok = 70100
            ELSE
              EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Moneda, @TipoCambio, 
                               @FechaEmision, @Retencion3Concepto, @Proyecto, @Usuario, @Autorizacion, @CxReferencia, @DocFuente, @Observaciones,
	    	               @FechaRegistro, @Ejercicio, @Periodo,
		               NULL, NULL, @CfgRetencion3Acreedor, NULL, NULL, NULL, NULL, NULL,
                               @Retencion3, NULL, NULL, NULL, 
                               NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		               @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                               @Ok OUTPUT, @OkRef OUTPUT
          END
        END
      END
      EXEC xpAfectarGastoDiversoCursor @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Concepto, @Acreedor, @RenglonID, @CxpID, @GastoID, @Ok OUTPUT, @OkRef OUTPUT
    END
    FETCH NEXT FROM crEGD INTO @Concepto, @Acreedor, @RenglonID, @Importe, @Retencion, @Retencion2, @Retencion3, @Impuestos, @PorcentajeImpuestos, @Moneda, @TipoCambio, @FechaEmision, @Condicion, @Vencimiento, @ReferenciaGasto, @Prorrateo
  END
  CLOSE crEGD
  DEALLOCATE crEGD

  IF @MovTipo = 'COMS.EI'
  BEGIN
    SELECT @TipoCambio = TipoCambio FROM Compra WHERE ID = @ID
    SELECT @CfgDefImpuesto = DefImpuesto
      FROM EmpresaGral
     WHERE Empresa = @Empresa

    SELECT @CfgMoneda = ContMoneda,
           @CfgImportacionImpuesto1Acreedor = ImportacionImpuesto1Acreedor,
           @CfgImportacionImpuesto1Concepto = ImportacionImpuesto1Concepto,
           @CfgImportacionImpuesto2Acreedor = ImportacionImpuesto2Acreedor,
           @CfgImportacionImpuesto2Concepto = ImportacionImpuesto2Concepto
     FROM EmpresaCfg
    WHERE Empresa = @Empresa

    SELECT @FechaEmision = FechaEmision 
      FROM Compra
     WHERE ID = @ID

    SELECT @ImportacionImpuesto1 = SUM(Cantidad*ValorAduana*(ImportacionImpuesto1/100.0)*@TipoCambio),
           @ImportacionImpuesto2 = SUM(Cantidad*ValorAduana*(ImportacionImpuesto2/100.0)*@TipoCambio)
      FROM CompraD
     WHERE ID = @ID

    SELECT @ImportacionImpuesto1IVA = 0.0, --@ImportacionImpuesto1 * (@CfgDefImpuesto/100.0),
           @ImportacionImpuesto2IVA = 0.0 --@ImportacionImpuesto2 * (@CfgDefImpuesto/100.0)

    IF ISNULL(@ImportacionImpuesto1, 0.0) <> 0.0
      EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @CfgMoneda, 1.0, 
                       @FechaEmision, @CfgImportacionImpuesto1Concepto, @Proyecto, @Usuario, @Autorizacion, @CxReferencia, @DocFuente, @Observaciones,
	               @FechaRegistro, @Ejercicio, @Periodo,
		       NULL, NULL, @CfgImportacionImpuesto1Acreedor, NULL, NULL, NULL, NULL, NULL,
                       @ImportacionImpuesto1, @ImportacionImpuesto1IVA, NULL, NULL, 
                       NULL, NULL, NULL, NULL, NULL, @GastoDiversoMov,
		       @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                       @Ok OUTPUT, @OkRef OUTPUT

    IF ISNULL(@ImportacionImpuesto2, 0.0) <> 0.0
      EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @CfgMoneda, 1.0, 
                       @FechaEmision, @CfgImportacionImpuesto2Concepto, @Proyecto, @Usuario, @Autorizacion, @CxReferencia, @DocFuente, @Observaciones,
	               @FechaRegistro, @Ejercicio, @Periodo,
		       NULL, NULL, @CfgImportacionImpuesto2Acreedor, NULL, NULL, NULL, NULL, NULL,
                       @ImportacionImpuesto2, @ImportacionImpuesto2IVA, NULL, NULL, 
                       NULL, NULL, NULL, NULL, NULL, @GastoDiversoMov,
		       @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                       @Ok OUTPUT, @OkRef OUTPUT
  END

  RETURN
END
GO

/**************** spProdSplitOT ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdSplitOT') and type = 'P') drop procedure dbo.spProdSplitOT
Go             
CREATE PROCEDURE spProdSplitOT
		   @Sucursal		int,
    		   @OPID           	int,
		   @Renglon		float,
	           @RenglonSub		int,
	           @CantidadOriginal	float,
	           @CantidadNueva	float,
		   @OrdenDestino	int,
		   @OrdenSiguiente	int,
                   @CentroDestino	char(10),
		   @CentroSiguiente	char(10),
                   @EstacionDestino	char(10),
		   @EstacionSiguiente	char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dif 		float,
    @RenglonSubN	int

  SELECT @Dif = @CantidadOriginal - @CantidadNueva 
  IF @Dif > 0.0
  BEGIN
    SELECT * INTO #ProdDetalle 
      FROM cProdD 
     WHERE ID = @OPID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 

    SELECT @RenglonSubN = ISNULL(MAX(RenglonSub), 0) + 1 
      FROM ProdD 
     WHERE ID = @OPID AND Renglon = @Renglon

    UPDATE #ProdDetalle 
       SET Sucursal = @Sucursal, RenglonSub = @RenglonSubN, Cantidad = @Dif, CantidadPendiente = @Dif

    UPDATE #ProdDetalle 
       SET CantidadInventario = Cantidad*Factor

    INSERT INTO cProdD SELECT * FROM #ProdDetalle

    UPDATE ProdD 
       SET Orden = @OrdenDestino,
           OrdenDestino = @OrdenSiguiente,
           Centro = @CentroDestino, 
           CentroDestino = @CentroSiguiente,
           Estacion = @EstacionDestino, 
           EstacionDestino = @EstacionSiguiente,
           Cantidad = ISNULL(Cantidad, 0.0) - @Dif, CantidadPendiente = ISNULL(CantidadPendiente, 0.0) - @Dif, 
           CantidadCancelada = NULL 
     WHERE ID = @OPID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 

    UPDATE ProdD 
       SET CantidadInventario = Cantidad*Factor
     WHERE ID = @OPID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 

  END
  RETURN
END
GO

/**************** spProdAutoAfectarConsumos ****************/
--if exists (select * from sysobjects where id = object_id('dbo.spProdAutoAfectarConsumos') and type = 'P') drop procedure dbo.spProdAutoAfectarConsumos
Go             
/*CREATE PROCEDURE spProdAutoAfectarConsumos
		   @Sucursal		int,
		   @Empresa		char(5),
		   @FechaRegistro	datetime,
 		   @Usuario		char(10),
		   @OPMov		char(20),
		   @OPMovID		varchar(20),
    		   @Centro      	char(10),
    		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Mov		char(20),
    @MovID		varchar(20),
    @IDGenerar		int,
    @ContID		int,
    @VolverAfectar	int,
    @Almacen		char(10)

  IF (SELECT ProdAfectarConsumo FROM EmpresaCfg2 WHERE Empresa = @Empresa) <> 1 RETURN
  SELECT @Almacen = Almacen FROM Centro WHERE Centro = @Centro

  DECLARE crConsumo CURSOR FOR
  SELECT ID, Mov, MovID FROM Inv WHERE Empresa = @Empresa AND Estatus = 'CONFIRMAR' AND OrigenTipo = 'PROD' AND Origen = @OPMov AND OrigenID = @OPMovID AND Almacen = @Almacen
  OPEN crConsumo
  FETCH NEXT FROM crConsumo INTO @ID, @Mov, @MovID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC spInv @ID, 'INV', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, NULL, 
                 @Mov, @MovID, @IDGenerar, @ContID, 
                 @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT
      IF @Ok IS NOT NULL 
        SELECT @OkRef = RTRIM(ISNULL(@OkRef, '')) + ' ('+RTRIM(@Mov)+' '+RTRIM(@MovID)+')'
    END
    FETCH NEXT FROM crConsumo INTO @ID, @Mov, @MovID
  END
  CLOSE crConsumo
  DEALLOCATE crConsumo
  RETURN
END*/
GO

/**************** spProdAutoAfectarConsumos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdAutoAfectarConsumos') and type = 'P') drop procedure dbo.spProdAutoAfectarConsumos
Go             
CREATE PROCEDURE spProdAutoAfectarConsumos
		   @Sucursal		int,
		   @Empresa		char(5),
		   @Accion		char(20),
		   @FechaEmision	datetime,
		   @FechaRegistro	datetime,
 		   @Usuario		char(10),
		   @AvanceID		int,
		   @AvanceMov		char(20),
		   @AvanceMovID		varchar(20),
		   @OPID		int,
		   @OPMov		char(20),
		   @OPMovID		varchar(20),
    		   @Centro      	char(10),
    	 	   @ProdSerieLote      	varchar(50),
		   @Producto		char(20),
		   @SubProducto		varchar(50),
		   @CantidadP		float,
		   @UnidadP		varchar(50),
    		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgAfectarConsumo		bit,
    @CfgAfectarConsumoParcial	bit,
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @ConsumoMov			char(20),
    @ConsumoMovID		varchar(20),
    @AplicaMov			char(20),
    @AplicaMovID		varchar(20),
    @IDConsumo			int,
    @IDAplica			int,    
    @IDGenerar			int,
    @ContID			int,
    @VolverAfectar		int,
    @Almacen			char(10),
    @Articulo			char(20),
    @ArtTipo	         	varchar(20),
    @SubCuenta			varchar(50),
    @Cantidad			float,
    @Factor			float,
    @Merma			float,
    @Desperdicio		float,
    @CantidadInventario		float,
    @Unidad			varchar(50),
    @Renglon			float,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @DetalleTipo		varchar(20)

  SELECT @CfgMultiUnidades         = MultiUnidades,
	 @CfgMultiUnidadesNivel    = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'),
         @CfgAfectarConsumo        = ProdAfectarConsumo,
         @CfgAfectarConsumoParcial = ProdAfectarConsumoParcial
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  IF @CfgAfectarConsumo = 0 RETURN

  SELECT @ConsumoMov = ProdConsumoMaterial 
    FROM EmpresaCfgMov 
   WHERE Empresa = @Empresa

  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @IDConsumo = NULL
    SELECT @IDConsumo = ID, @ConsumoMov = Mov, @ConsumoMovID = MovID
      FROM Inv 
     WHERE OrigenTipo = 'PROD' AND Origen = @AvanceMov AND OrigenID = @AvanceMovID AND Estatus = 'CONCLUIDO'
    IF @IDConsumo IS NOT NULL
    BEGIN
      EXEC spInv @IDConsumo, 'INV', 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL, 
                 @ConsumoMov, @ConsumoMovID OUTPUT, @IDGenerar, @ContID, 
                 @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT
    
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'PROD', @AvanceID, @AvanceMov, @AvanceMovID, 'INV', @IDConsumo, @ConsumoMov, @ConsumoMovID, @Ok OUTPUT
    END
    RETURN
  END

  SELECT @Almacen = Almacen FROM Centro WHERE Centro = @Centro
  SELECT @IDAplica = NULL

  SELECT @IDAplica = MIN(i.ID)
    FROM Inv i, MovTipo mt 
   WHERE i.OrigenTipo = 'PROD' AND i.Origen = @OPMov AND i.OrigenID = @OPMovID
     AND mt.Modulo = 'INV' AND mt.Mov = i.Mov AND mt.Clave = 'INV.SM'
     AND i.Almacen = @Almacen AND i.Estatus = 'PENDIENTE'

  IF @IDAplica IS NULL RETURN 

  SELECT @AplicaMov = Mov, @AplicaMovID = MovID
    FROM Inv 
   WHERE ID = @IDAplica

  SELECT @DetalleTipo = 'Salida', @Renglon = 0.0, @RenglonID = 0
  INSERT Inv (OrigenTipo, Origen,      OrigenID,     Empresa,  Usuario,  Estatus,      Mov,         FechaEmision,  Proyecto,   Moneda,   TipoCambio,   Referencia,   Observaciones,   Prioridad,   Almacen,   Directo, VerLote, Sucursal)
       SELECT 'PROD',     @AvanceMov,  @AvanceMovID, @Empresa, @Usuario, 'SINAFECTAR', @ConsumoMov, @FechaEmision, i.Proyecto, i.Moneda, m.TipoCambio, i.Referencia, i.Observaciones, i.Prioridad, i.Almacen, 0, 1, @Sucursal
        FROM Inv i, Mon m
       WHERE m.Moneda = i.Moneda AND i.ID = @IDAplica
  SELECT @IDConsumo = SCOPE_IDENTITY()

  DECLARE crConsumo CURSOR FOR
   SELECT p.Articulo, p.SubCuenta, CASE WHEN @CfgAfectarConsumoParcial = 1 THEN (p.Cantidad/p.CantidadP)*@CantidadP ELSE p.Cantidad END, p.Unidad, p.Factor, (p.Merma/p.CantidadP)*@CantidadP, (p.Desperdicio/p.CantidadP)*@CantidadP
     FROM ProdProgramaMaterial p
     LEFT OUTER JOIN ArtMaterial a ON p.Producto = a.Articulo AND p.Articulo = a.Material AND ISNULL(p.Subcuenta,'') = ISNULL(a.Subcuenta, '') AND p.AlmacenOrigen = a.almacen 
    WHERE p.ID = @OPID AND p.AlmacenDestino = @Almacen AND p.Lote = @ProdSerieLote AND p.Producto = @Producto AND p.SubProducto = @SubProducto AND p.UnidadP = @UnidadP
      AND ISNULL(a.Centro,@Centro) = @Centro
  OPEN crConsumo
  FETCH NEXT FROM crConsumo INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @Factor, @Merma, @Desperdicio
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL AND ISNULL(@Cantidad, 0) <> 0
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
      SELECT @ArtTipo = Tipo
        FROM Art 
       WHERE Articulo = @Articulo

      EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
      SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

      INSERT InvD (ID,         Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Aplica,     AplicaID,     Almacen,  Producto,  SubProducto,  ProdSerieLote,  Articulo,  SubCuenta,  Cantidad,  Merma,  Desperdicio,  Unidad,  CantidadInventario, Factor,  Tipo)
           VALUES (@IDConsumo, @Renglon, 0,          @RenglonID, @RenglonTipo, @AplicaMov, @AplicaMovID, @Almacen, @Producto, @SubProducto, @ProdSerieLote, @Articulo, @SubCuenta, @Cantidad, @Merma, @Desperdicio, @Unidad, @CantidadInventario, @Factor, @DetalleTipo)
    END
    FETCH NEXT FROM crConsumo INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @Factor, @Merma, @Desperdicio
  END
  CLOSE crConsumo
  DEALLOCATE crConsumo

  IF @Renglon = 0
    DELETE Inv WHERE ID = @IDConsumo
  ELSE
  BEGIN
    EXEC spInv @IDConsumo, 'INV', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL, 
               @ConsumoMov, @ConsumoMovID OUTPUT, @IDGenerar, @ContID, 
               @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'PROD', @AvanceID, @AvanceMov, @AvanceMovID, 'INV', @IDConsumo, @ConsumoMov, @ConsumoMovID, @Ok OUTPUT
  END
  RETURN
END
GO

/**************** spProdAvanceMatar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdAvanceMatar') and type = 'P') drop procedure dbo.spProdAvanceMatar
GO             
CREATE PROCEDURE spProdAvanceMatar
		   @Sucursal		int,
		   @Accion		char(20),
		   @Empresa		char(5),
         	   @FechaEmision	datetime,
		   @FechaRegistro	datetime,
                   @Usuario		char(10),
		   @AvanceID		int,
		   @AvanceMov		char(20),
		   @AvanceMovID		varchar(20),
		   @MovTipo		char(20),
		   @OrdenD		int,
		   @OrdenA		int,
    		   @CentroD      	char(10),
    		   @CentroA	      	char(10),
    	 	   @ProdSerieLote      	varchar(50),
		   @Articulo		char(20),
		   @SubCuenta		varchar(50),
		   @Cantidad		float,
		   @Unidad		varchar(50),
		   @RenglonTipo		char(1),
		   @Factor		float,
		   @Ruta		char(20),

		   @GeneroCosto		bit	     OUTPUT,
    		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OPID		int,
    @OPMov		char(20),
    @OPMovID		varchar(20),
    @Renglon		float,
    @RenglonSub		int,
    @OrdenOrigen	int,
    @OrdenDestino	int,
    @OrdenSiguiente	int,
    @CentroOrigen	char(10),
    @CentroDestino	char(10),
    @CentroSiguiente	char(10),
    @EstacionDestino	char(10),
    @EstacionSiguiente	char(10),
    @CentroCosto	char(10),
    @Saldo		float,
    @CantidadPendiente	float

  SELECT @OPID = MIN(ID), @OPMov = MIN(Mov), @OPMovID = MIN(MovID)
    FROM ProdSerieLotePendiente 
   WHERE Empresa = @Empresa AND ProdSerieLote = @ProdSerieLote AND Articulo = @Articulo AND SubCuenta = @SubCuenta

  EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'PROD', @OPID, @OPMov, @OPMovID, 'PROD', @AvanceID, @AvanceMov, @AvanceMovID, @Ok OUTPUT 

  IF @MovTipo = 'PROD.E' SELECT @CentroA = @CentroD, @OrdenA = @OrdenD

  IF @MovTipo IN ('PROD.A', 'PROD.E') 
    EXEC spProdAutoAfectarConsumos @Sucursal, @Empresa, @Accion, @FechaEmision, @FechaRegistro, @Usuario, @AvanceID, @AvanceMov, @AvanceMovID, @OPID, @OPMov, @OPMovID, @CentroD, @ProdSerieLote, @Articulo, @SubCuenta, @Cantidad, @Unidad, @Ok OUTPUT, @OkRef OUTPUT

  IF @MovTipo = 'PROD.E' AND @Accion = 'CANCELAR' RETURN

  IF @Accion <> 'CANCELAR'
    SELECT @CentroOrigen = @CentroD, @CentroDestino = @CentroA,
           @OrdenOrigen  = @OrdenD,  @OrdenDestino  = @OrdenA
  ELSE
    SELECT @CentroOrigen = @CentroA, @CentroDestino = @CentroD,
           @OrdenOrigen  = @OrdenA,  @OrdenDestino  = @OrdenD

  EXEC spProdAvanceAlCentro @Empresa, @MovTipo, @Articulo, @SubCuenta, @ProdSerieLote, @Ruta, @OrdenDestino, @OrdenSiguiente OUTPUT, @CentroDestino, @CentroSiguiente OUTPUT, @EstacionDestino OUTPUT, @EstacionSiguiente OUTPUT

  IF (SELECT Estatus FROM Prod WHERE ID = @OPID) <> 'PENDIENTE' SELECT @Ok = 20180

  SELECT @Saldo = @Cantidad
  DECLARE crProdOT CURSOR FOR
  SELECT d.ID, d.Renglon, d.RenglonSub, ROUND(ISNULL(d.CantidadPendiente, 0.0), 4)
    FROM Prod e, ProdD d
   WHERE e.ID = d.ID AND e.ID = @OPID
     AND e.Empresa = @Empresa AND d.ProdSerieLote = @ProdSerieLote AND d.Articulo = @Articulo AND d.SubCuenta = @SubCuenta AND d.Unidad = @Unidad
     AND ISNULL(d.Orden, 0) = ISNULL(@OrdenOrigen, 0)
     AND ISNULL(d.Centro, '') = ISNULL(@CentroOrigen, '')
     AND ISNULL(d.CantidadPendiente, 0.0) > 0.0
   ORDER BY d.CantidadPendiente

  OPEN crProdOT
  FETCH NEXT FROM crProdOT INTO @OPID, @Renglon, @RenglonSub, @CantidadPendiente
  WHILE @@FETCH_STATUS <> -1 AND @Saldo > 0.0 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Saldo > 0.0 AND @Ok IS NULL
    BEGIN
      IF @Saldo >= @CantidadPendiente 
      BEGIN
        UPDATE ProdD 
           SET Centro   = @CentroDestino,   CentroDestino   = @CentroSiguiente,
               Orden    = @OrdenDestino,    OrdenDestino    = @OrdenSiguiente,
               Estacion = @EstacionDestino, EstacionDestino = @EstacionSiguiente
         WHERE CURRENT OF crProdOT
        SELECT @Saldo = @Saldo - @CantidadPendiente
      END ELSE
      BEGIN
        EXEC spProdSplitOT @Sucursal, @OPID, @Renglon, @RenglonSub, @CantidadPendiente, @Saldo, @OrdenDestino, @OrdenSiguiente, @CentroDestino, @CentroSiguiente, @EstacionDestino, @EstacionSiguiente
        SELECT @Saldo = 0.0
      END 
    END
    FETCH NEXT FROM crProdOT INTO @OPID, @Renglon, @RenglonSub, @CantidadPendiente
  END
  CLOSE crProdOT
  DEALLOCATE crProdOT
  
  IF @Saldo > 0.0 AND @Ok IS NULL SELECT @Ok = 20180
/*  IF @Saldo > 0.0 AND @Ok IS NULL
  BEGIN
    SELECT @Renglon = MAX(Renglon) + 2048.0 FROM ProdD WHERE ID = @OPID 
    INSERT ProdD (ID,    Renglon,  RenglonSub, RenglonTipo,  Articulo,  SubCuenta,  ProdSerieLote,  Orden,         Centro,         Cantidad, CantidadPendiente, Unidad,  Factor)
          VALUES (@OPID, @Renglon, 0,          @RenglonTipo, @Articulo, @SubCuenta, @ProdSerieLote, @OrdenDestino, @CentroDestino, @Saldo,   @Saldo,            @Unidad, @Factor)
  END
*/
  IF @Accion <> 'CANCELAR'
  BEGIN
    IF @MovTipo = 'PROD.R' SELECT @CentroCosto = @CentroDestino ELSE SELECT @CentroCosto = @CentroOrigen
    IF @@ROWCOUNT > 0 SELECT @GeneroCosto = 1
  END
  RETURN
END
GO

/**************** spProdAvance ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdAvance') and type = 'P') drop procedure dbo.spProdAvance
GO             
CREATE PROCEDURE spProdAvance
		   @Sucursal		int,
		   @Accion		char(20),
		   @Empresa		char(5),
		   @FechaEmision	datetime,
		   @FechaRegistro	datetime,
                   @Usuario		char(10),
		   @AvanceID		int,
		   @AvanceMov		char(20),
		   @AvanceMovID		varchar(20),
		   @MovTipo		char(20),

    		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @Ruta		char(20),
    @Orden		int,
    @OrdenDestino	int,
    @Centro		char(10),
    @CentroDestino     	char(10),
    @ProdSerieLote      varchar(50),
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @RenglonTipo	char(1),
    @Cantidad		float,
    @Unidad		varchar(50),
    @Factor		float,
    @MermaDesp		float,
    @GeneroCosto 	bit

--  IF @MovTipo = 'PROD.E' AND @Accion = 'CANCELAR' RETURN

  SELECT @GeneroCosto = 0

  DECLARE crProdAP CURSOR FOR
  SELECT Ruta, Orden, OrdenDestino, Centro, CentroDestino, ProdSerieLote, Articulo, SubCuenta, Unidad, RenglonTipo, AVG(Factor), SUM(Cantidad), SUM(ISNULL(Merma, 0)+ISNULL(Desperdicio, 0))
    FROM ProdD d
   WHERE ID = @AvanceID AND ISNULL(UPPER(d.Tipo), '') <> 'EXCEDENTE'
   GROUP BY Ruta, Orden, OrdenDestino, Centro, CentroDestino, ProdSerieLote, Articulo, SubCuenta, Unidad, RenglonTipo
   ORDER BY Ruta, Orden, OrdenDestino, Centro, CentroDestino, ProdSerieLote, Articulo, SubCuenta, Unidad, RenglonTipo

  OPEN crProdAP
  FETCH NEXT FROM crProdAP INTO @Ruta, @Orden, @OrdenDestino, @Centro, @CentroDestino, @ProdSerieLote, @Articulo, @SubCuenta, @Unidad, @RenglonTipo, @Factor, @Cantidad, @MermaDesp
  WHILE @@FETCH_STATUS <> -1 AND @Cantidad+@MermaDesp>0.0 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @MovTipo = 'PROD.E' SELECT @Cantidad = @Cantidad + @MermaDesp
      EXEC spProdAvanceMatar @Sucursal, @Accion, @Empresa, @FechaEmision, @FechaRegistro, @Usuario, @AvanceID, @AvanceMov, @AvanceMovID, @MovTipo, @Orden, @OrdenDestino, @Centro, @CentroDestino, @ProdSerieLote, 
	  		     @Articulo, @SubCuenta, @Cantidad, @Unidad, @RenglonTipo, @Factor, 
		             @Ruta, @GeneroCosto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    END

    FETCH NEXT FROM crProdAP INTO @Ruta, @Orden, @OrdenDestino, @Centro, @CentroDestino, @ProdSerieLote, @Articulo, @SubCuenta, @Unidad, @RenglonTipo, @Factor, @Cantidad, @MermaDesp
  END
  CLOSE crProdAP 
  DEALLOCATE crProdAP 
  RETURN
END
GO

/**************** spProdCentroInicial ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdCentroInicial') and type = 'P') drop procedure dbo.spProdCentroInicial
GO             
CREATE PROCEDURE spProdCentroInicial
			@ID		int,
			@Articulo	char(20),
			@SubCuenta	varchar(50),
			@ProdSerieLote	varchar(50),
			@OrdenD		int		OUTPUT,
			@OrdenA		int		OUTPUT,
			@CentroD	char(10)	OUTPUT,
			@CentroA	char(10)	OUTPUT,
			@EstacionD	char(10)	OUTPUT,
			@EstacionA	char(10)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @OrdenD = NULL, @OrdenA = NULL,
         @CentroD = NULL, @CentroA = NULL,
         @EstacionD = NULL, @EstacionA = NULL

  SELECT @OrdenD = MIN(Orden) 
    FROM ProdProgramaRuta WHERE ID = @ID AND Producto = @Articulo AND ISNULL(SubProducto, '') = ISNULL(@SubCuenta, '') AND Lote = @ProdSerieLote
  SELECT @CentroD   = Centro,
         @EstacionD = Estacion
    FROM ProdProgramaRuta WHERE ID = @ID AND Producto = @Articulo AND ISNULL(SubProducto, '') = ISNULL(@SubCuenta, '') AND Lote = @ProdSerieLote AND Orden = @OrdenD
  SELECT @OrdenA = MIN(Orden) 
    FROM ProdProgramaRuta WHERE ID = @ID AND Producto = @Articulo AND ISNULL(SubProducto, '') = ISNULL(@SubCuenta, '') AND Lote = @ProdSerieLote AND Orden > @OrdenD
  SELECT @CentroA = Centro,
         @EstacionA = Estacion
    FROM ProdProgramaRuta WHERE ID = @ID AND Producto = @Articulo AND ISNULL(SubProducto, '') = ISNULL(@SubCuenta, '') AND Lote = @ProdSerieLote AND Orden = @OrdenA
END
GO
/*
declare
@OrdenA int, @CentroA char(10), @EstacionD char(10), @EstacionA char(10)

EXEC spProdAvanceAlCentro 'DEMO', 'PROD.A', 'TITULO', NULL, '103', '12', 1, @OrdenA OUTPUT, 'CENTRO1', @CentroA OUTPUT, @EstacionD OUTPUT, @EstacionA OUTPUT
select @OrdenA, @CentroA, @EstacionD, @EstacionA
*/
/**************** spProdAvanceAlCentro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdAvanceAlCentro') and type = 'P') drop procedure dbo.spProdAvanceAlCentro
GO             
CREATE PROCEDURE spProdAvanceAlCentro
			@Empresa	char(5),
			@MovTipo	char(20),
			@Articulo	char(20), 
			@SubCuenta	varchar(50), 
			@ProdSerieLote	varchar(50), 
			@Ruta		char(20),
			@OrdenD		int,
			@OrdenA		int		OUTPUT,
			@CentroD	char(10),
			@CentroA	char(10)	OUTPUT,
			@EstacionD	char(10) 	OUTPUT,
			@EstacionA	char(10) 	OUTPUT,
			@Verificar	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int

  SELECT @ID = MIN(ID) FROM ProdSerieLotePendiente WHERE Empresa = @Empresa AND ProdSerieLote = @ProdSerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')

  IF @OrdenD IS NULL
    SELECT @OrdenD = MIN(Orden) FROM ProdProgramaRuta WHERE ID = @ID AND Producto = @Articulo AND ISNULL(SubProducto, '') = ISNULL(@SubCuenta, '') AND Lote = @ProdSerieLote AND Centro = @CentroD

  SELECT @EstacionD = Estacion FROM ProdProgramaRuta WHERE ID = @ID AND Producto = @Articulo AND ISNULL(SubProducto, '') = ISNULL(@SubCuenta, '') AND Lote = @ProdSerieLote AND Orden = @OrdenD AND Centro = @CentroD

  IF @MovTipo = 'PROD.R' AND @Verificar = 1
    SELECT @OrdenA = MAX(Orden) FROM ProdProgramaRuta WHERE ID = @ID AND Producto = @Articulo AND ISNULL(SubProducto, '') = ISNULL(@SubCuenta, '') AND Lote = @ProdSerieLote AND Orden < @OrdenD 
  ELSE
    SELECT @OrdenA = MIN(Orden) FROM ProdProgramaRuta WHERE ID = @ID AND Producto = @Articulo AND ISNULL(SubProducto, '') = ISNULL(@SubCuenta, '') AND Lote = @ProdSerieLote AND Orden > @OrdenD 

  SELECT @CentroA = Centro, @EstacionA = Estacion FROM ProdProgramaRuta WHERE ID = @ID AND Producto = @Articulo AND ISNULL(SubProducto, '') = ISNULL(@SubCuenta, '') AND Lote = @ProdSerieLote AND Orden = @OrdenA
END
GO

/**************** spProdUltimoCentro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdUltimoCentro') and type = 'P') drop procedure dbo.spProdUltimoCentro
GO             
CREATE PROCEDURE spProdUltimoCentro
			@Empresa	char(5),
			@Articulo	char(20), 
			@SubCuenta	varchar(50), 
			@ProdSerieLote	varchar(50), 
			@Ruta		char(20),
			@OrdenA		int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int

  SELECT @ID = MIN(ID) FROM ProdSerieLotePendiente WHERE Empresa = @Empresa AND ProdSerieLote = @ProdSerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
  SELECT @OrdenA = MAX(Orden) FROM ProdProgramaRuta WHERE ID = @ID AND Producto = @Articulo AND ISNULL(SubProducto, '') = ISNULL(@SubCuenta, '') AND Lote = @ProdSerieLote
  RETURN 
END
GO

/**************** spProdAvanceCalcCosto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdAvanceCalcCosto') and type = 'P') drop procedure dbo.spProdAvanceCalcCosto
GO             
CREATE PROCEDURE spProdAvanceCalcCosto
			@Empresa	 char(5),
		        @ProdSerieLote	 varchar(50),
			@Articulo	 char(20),
		        @SubCuenta	 varchar(50),
			@Ruta		 char(20),
			@Orden		 int,
			@Centro		 char(10),
			@TipoCosto	 char(10),	-- MO, IND, MAQ, TODOS
			@Cantidad	 float,
			@Tiempo		 float,
			@TiempoUnidad	 char(10),
			@MovMoneda	 char(10),
			@MovTipoCambio	 float,
			@EnSilencio	 bit	= 0,
			@CostoMO	 float 	= 0.0	OUTPUT,
		        @CostoIndirectos float 	= 0.0	OUTPUT,
			@CostoMaquila	 float  = 0.0   OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Moneda			char(10),    
    @CostoManoObra		float,
    @Factor			float,
    @TipoCambio			float,
    @Cxp			bit,
    @Ok				int

  SELECT @Ok = NULL, @CostoMO = 0.0, @CostoIndirectos = 0.0, @TipoCosto = UPPER(@TipoCosto), @SubCuenta = ISNULL(RTRIM(@SubCuenta), '')

  IF @TipoCosto IN ('MO', 'AMBOS')
  BEGIN
    IF @Ruta IS NULL
      SELECT @Ruta = MIN(Ruta) FROM ProdSerieLotePendiente WHERE Empresa = @Empresa AND ProdSerieLote = @ProdSerieLote AND Articulo = @Articulo AND SubCuenta = @SubCuenta

    SELECT @CostoMO = ISNULL(Costo, 0.0), @Moneda = Moneda
      FROM ProdRutaD 
     WHERE Ruta = @Ruta AND Orden = @Orden AND Centro = @Centro

    EXEC spMoneda NULL, @MovMoneda, @MovTipoCambio, @Moneda, @Factor OUTPUT, @TipoCambio OUTPUT, @Ok OUTPUT
    SELECT @CostoMO = @CostoMO * @Factor * @Cantidad
  END

  SELECT @Cxp = Cxp, 
         @CostoManoObra       = ISNULL(CostoManoObra, 0.0), 
         @CostoIndirectos     = ISNULL(CostoIndirectos, 0.0), 
         @Moneda = CostoMoneda 
    FROM Centro 
   WHERE Centro = @Centro
  EXEC spMoneda NULL, @MovMoneda, @MovTipoCambio, @Moneda, @Factor OUTPUT, @TipoCambio OUTPUT, @Ok OUTPUT

  IF @Cxp = 1
  BEGIN
    SELECT @CostoMaquila = NULL
    SELECT @CostoMaquila = ISNULL(Costo, 0) * @Factor * @Cantidad
      FROM CentroTarifa
     WHERE Centro = @Centro AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(RTRIM(@SubCuenta), '')

    IF @CostoMaquila IS NULL
      SELECT @CostoMaquila = ISNULL(Costo, 0) * @Factor * @Cantidad
        FROM CentroTarifa
       WHERE Centro = @Centro AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ''
  END

  SELECT @CostoMO         = @CostoMO + (@CostoManoObra * @Factor * @Tiempo),
         @CostoIndirectos = (@CostoIndirectos * @Factor * @Tiempo)

  IF @EnSilencio = 0 
    IF @TipoCosto = 'MAQ'
      SELECT "Costo" = @CostoMaquila
    ELSE IF @TipoCosto = 'MO' 
      SELECT "Costo" = @CostoMO
    ELSE
      SELECT "Costo" = @CostoIndirectos
END
GO

/**************** spProdAvanceTiempoCentro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdAvanceTiempoCentro') and type = 'P') drop procedure dbo.spProdAvanceTiempoCentro
GO             
CREATE PROCEDURE spProdAvanceTiempoCentro
		   @ID			int,
		   @MovTipo		char(20),
                   @MovMoneda		char(10),
		   @MovTipoCambio	float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ruta		char(20),
    @Orden		int,
    @OrdenDestino	int,
    @Centro		char(10),
    @CentroDestino	char(10),
    @Estacion		char(10),
    @EstacionDestino	char(10),
    @Empresa		char(5), 
    @ProdSerieLote	varchar(50),
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Cantidad		float,
    @Tiempo		float,
    @TiempoFijo		float,
    @TiempoVariable	float,
    @TiempoUnidad	varchar(10),
    @CostoMO	 	float,
    @CostoIndirectos 	float,
    @CostoMaquila	float

  DECLARE crProdD CURSOR FOR
   SELECT p.Empresa, d.ProdSerieLote, d.Articulo, d.SubCuenta, d.Cantidad, d.Ruta, d.Orden, d.Centro
     FROM Prod p, ProdD d 
    WHERE p.ID = @ID AND d.ID = p.ID
  
  OPEN crProdD
  FETCH NEXT FROM crProdD INTO @Empresa, @ProdSerieLote, @Articulo, @SubCuenta, @Cantidad, @Ruta, @Orden, @Centro
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spProdAvanceAlCentro @Empresa, @MovTipo, @Articulo, @SubCuenta, @ProdSerieLote, @Ruta, @Orden, @OrdenDestino OUTPUT, @Centro, @CentroDestino OUTPUT, @Estacion, @EstacionDestino OUTPUT, @Verificar = 1

      IF @Movtipo = 'PROD.R'
        SELECT @Orden = @OrdenDestino, @Centro=@CentroDestino

      SELECT @TiempoFijo = ISNULL(TiempoFijo, 0), @TiempoVariable = ISNULL(TiempoVariable, 0), @TiempoUnidad = UnidadT
        FROM ProdRutaD 
       WHERE Ruta = @Ruta AND Orden = @Orden AND Centro = @Centro

      SELECT @Tiempo = NULLIF(ROUND(@TiempoFijo + (@TiempoVariable * @Cantidad), 6), 0)
		
      EXEC spProdAvanceCalcCosto @Empresa, @ProdSerieLote, @Articulo, @SubCuenta, @Ruta, @Orden, @Centro, 'AMBOS', @Cantidad, @Tiempo, @TiempoUnidad, @MovMoneda, @MovTipoCambio, 1, @CostoMO OUTPUT, @CostoIndirectos OUTPUT, @CostoMaquila OUTPUT

      UPDATE ProdD  
         SET OrdenDestino    = @OrdenDestino,
             CentroDestino   = @CentroDestino,
             EstacionDestino = @EstacionDestino,
             Tiempo          = @Tiempo,
             TiempoUnidad    = @TiempoUnidad,
             ManoObra	     = @CostoMO,
             Indirectos      = @CostoIndirectos,
             Maquila	     = @CostoMaquila
       WHERE CURRENT OF crProdD
    END
    FETCH NEXT FROM crProdD INTO @Empresa, @ProdSerieLote, @Articulo, @SubCuenta, @Cantidad, @Ruta, @Orden, @Centro
  END
  CLOSE crProdD
  DEALLOCATE crProdD
  RETURN
END
GO

/**************** spProdSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdSerieLote') and type = 'P') drop procedure dbo.spProdSerieLote
GO             
CREATE PROCEDURE spProdSerieLote
                   @Sucursal		int,
		   @Accion		char(20),
    		   @Empresa		char(5),
    		   @MovTipo     	char(20),
		   @FechaEmision	datetime,
		   @DetalleTipo		varchar(20),
		   @ProdSerieLote	varchar(50),
		   @Articulo		char(20),
		   @SubCuenta		varchar(50),
		   @MovCantidad		float,	
		   @MovMerma		float,
                   @MovDesperdicio	float,
		   @Factor		float,

    		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaOrden		 datetime,
    @FechaEntrada	 datetime,
    @Cantidad 		 float,
    @Merma		 float,
    @Desperdicio	 float,
    @CantidadOrdenada	 float,
    @CantidadCancelada	 float,
    @CantidadEntrada	 float,
    @CantidadMerma	 float,
    @CantidadDesperdicio float

  SELECT @SubCuenta = ISNULL(RTRIM(@SubCuenta), '')
  SELECT @Cantidad = @MovCantidad*@Factor, @Merma = @MovMerma*@Factor, @Desperdicio = @MovDesperdicio*@Factor
  IF @Accion = 'CANCELAR' SELECT @Cantidad = -@Cantidad, @Merma = -@Merma, @Desperdicio = -@Desperdicio

  SELECT @CantidadOrdenada = 0.0, @CantidadCancelada = 0.0, @CantidadEntrada = 0.0, @CantidadMerma = 0.0, @CantidadDesperdicio = 0.0,
         @FechaOrden = NULL, @FechaEntrada = NULL

  IF @MovTipo = 'PROD.O'  SELECT @FechaOrden   = @FechaEmision, @CantidadOrdenada = @Cantidad ELSE
  IF @MovTipo = 'PROD.CO' SELECT @CantidadCancelada = @Cantidad ELSE
  IF @MovTipo = 'PROD.E'  SELECT @FechaEntrada = @FechaEmision, @CantidadEntrada  = @Cantidad, @CantidadMerma = @Merma, @CantidadDesperdicio = @Desperdicio

  UPDATE ProdSerieLote 
     SET FechaOrden          = ISNULL(@FechaOrden, FechaOrden),
	 FechaEntrada        = ISNULL(@FechaEntrada, FechaEntrada),
         CantidadOrdenada    = NULLIF(ISNULL(CantidadOrdenada, 0.0)    + @CantidadOrdenada, 0.0),
         CantidadCancelada   = NULLIF(ISNULL(CantidadCancelada, 0.0)   + @CantidadCancelada, 0.0),
         CantidadEntrada     = NULLIF(ISNULL(CantidadEntrada,  0.0)    + @CantidadEntrada, 0.0),
         CantidadMerma       = NULLIF(ISNULL(CantidadMerma,  0.0)      + @CantidadMerma, 0.0),
         CantidadDesperdicio = NULLIF(ISNULL(CantidadDesperdicio, 0.0) + @CantidadDesperdicio, 0.0)
   WHERE Empresa = @Empresa AND ProdSerieLote = @ProdSerieLote AND Articulo = @Articulo AND SubCuenta = @SubCuenta
  IF @@ROWCOUNT = 0
    INSERT ProdSerieLote (Sucursal,  Empresa,  FechaOrden,  FechaEntrada,  ProdSerieLote,  Articulo,  SubCuenta,  CantidadOrdenada,  CantidadCancelada,  CantidadEntrada,  CantidadMerma,  CantidadDesperdicio) 
                  VALUES (@Sucursal, @Empresa, @FechaOrden, @FechaEntrada, @ProdSerieLote, @Articulo, @SubCuenta, @CantidadOrdenada, @CantidadCancelada, @CantidadEntrada, @CantidadMerma, @CantidadDesperdicio)

  IF @MovTipo = 'PROD.CO'
    IF EXISTS(SELECT * FROM ProdSerieLoteCostoAcum WHERE Empresa = @Empresa AND ProdSerieLote = @ProdSerieLote AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND ISNULL(ROUND(CantidadPendiente, 4), 0) <= 0 AND ISNULL(ROUND(Saldo, 2), 0) >= 1)
      SELECT @Ok = 25440, @OkRef = 'Lote: '+ @ProdSerieLote
END
GO

/**************** spProdCostearEntrada ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdCostearEntrada') and type = 'P') drop procedure dbo.spProdCostearEntrada
GO             
CREATE PROCEDURE spProdCostearEntrada
		   @Empresa		char(5),
		   @ID			int,
		   @MovMoneda		char(10),
		   @MovTipoCambio	float,

    		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ProdSerieLote      varchar(50),
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Cantidad		float,
    @CantidadTotal	float,
    @CantidadPendiente	float,
    @CostoLote		float,
    @CostoUnitario	float

  DECLARE crProdD CURSOR FOR
  SELECT ProdSerieLote, Articulo, ISNULL(RTRIM(SubCuenta), ''), SUM(ISNULL(Cantidad, 0.0)), SUM(ISNULL(Cantidad, 0.0)+ISNULL(Merma, 0.0)+ISNULL(Desperdicio, 0.0))
    FROM ProdD
   WHERE ID = @ID
   GROUP BY ProdSerieLote, Articulo, SubCuenta
   ORDER BY ProdSerieLote, Articulo, SubCuenta

  OPEN crProdD
  FETCH NEXT FROM crProdD INTO @ProdSerieLote, @Articulo, @SubCuenta, @Cantidad, @CantidadTotal
  WHILE @@FETCH_STATUS <> -1 AND @CantidadTotal > 0.0 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @CostoLote = 0.0
      SELECT @CostoLote = SUM((ISNULL(l.Cargo, 0.0)-ISNULL(l.Abono, 0.0))*m.TipoCambio) / @MovTipoCambio
        FROM ProdSerieLoteCosto l, Mon m
       WHERE Empresa = @Empresa AND ProdSerieLote = @ProdSerieLote AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND m.Moneda = l.Moneda
      
      SELECT @CantidadPendiente = ISNULL(CantidadOrdenada, 0.0) - ISNULL(CantidadCancelada, 0.0) - ISNULL(CantidadEntrada, 0.0) - ISNULL(CantidadMerma, 0.0) - ISNULL(CantidadDesperdicio, 0.0)
        FROM ProdSerieLote
       WHERE Empresa = @Empresa AND ProdSerieLote = @ProdSerieLote AND Articulo = @Articulo AND SubCuenta = @SubCuenta 

      SELECT @CostoUnitario = (@CostoLote /** (@CantidadTotal/@CantidadPendiente)*/) / @Cantidad
      UPDATE ProdD SET Costo = @CostoUnitario WHERE ID = @ID AND ProdSerieLote = @ProdSerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND UPPER(Tipo) NOT IN ('MERMA', 'DESPERDICIO')
    END
    FETCH NEXT FROM crProdD INTO @ProdSerieLote, @Articulo, @SubCuenta, @Cantidad, @CantidadTotal
  END
  CLOSE crProdD
  DEALLOCATE crProdD
  RETURN
END
GO

/**************** spProdSerieLoteCosto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdSerieLoteCosto') and type = 'P') drop procedure dbo.spProdSerieLoteCosto
GO             
CREATE PROCEDURE spProdSerieLoteCosto
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
		   @EnAvance		bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cargo	money,
    @Abono	money,
    @CostoExtra	bit

  IF ISNULL(@ImporteNeto, 0.0) = 0.0 RETURN
  SELECT @SubCuenta = ISNULL(RTRIM(@SubCuenta), ''), @CostoExtra = 0

  IF @Accion = 'CANCELAR' SELECT @ImporteNeto = -@ImporteNeto 
  IF @EnAvance = 1
  BEGIN
    IF @MovTipo = 'PROD.R' SELECT @Abono = @ImporteNeto ELSE SELECT @Cargo = @ImporteNeto
  END ELSE
  BEGIN
    IF @MovTipo = 'INV.CM' AND UPPER(@DetalleTipo) = 'SALIDA' SELECT @Cargo = @ImporteNeto ELSE SELECT @Abono = @ImporteNeto  
  END

  EXEC xpProdSerieLoteCosto @Sucursal, @Accion, @Empresa, @Modulo, @ID, @MovTipo, @DetalleTipo, @ProdSerieLote, @Articulo, @SubCuenta, @ImporteNeto, @Moneda, @Concepto, @EnAvance, @CostoExtra OUTPUT
  INSERT ProdSerieLoteCosto (Sucursal,  Empresa,  ProdSerieLote,  Articulo,  SubCuenta,  Modulo,  ModuloID, Cargo,  Abono,  Moneda,  Concepto,  CostoExtra) 
                     VALUES (@Sucursal, @Empresa, @ProdSerieLote, @Articulo, @SubCuenta, @Modulo, @ID,      @Cargo, @Abono, @Moneda, @Concepto, @CostoExtra) 
END
GO

/**************** spProdCostearAvance ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdCostearAvance') and type = 'P') drop procedure dbo.spProdCostearAvance
GO             
CREATE PROCEDURE spProdCostearAvance
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
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ProdSerieLote      varchar(50),
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Comision		money,
    @ManoObra		money,
    @Indirectos		money,
    @Maquila		money,
    @MaquilaIVA		money,
    @Orden		int,
    @Centro		char(10),
    @Cxp		bit, 
    @Proveedor		char(10), 
    @CxpMov 		varchar(20), 
    @Concepto 		varchar(50), 
    @Impuesto1 		float, 
    @Condicion		varchar(50),
    @CxModulo 		char(5), 
    @CxMov 		char(20), 
    @CxMovID 		varchar(20)

  DECLARE crProdD CURSOR FOR
  SELECT ProdSerieLote, Orden, Centro, Articulo, ISNULL(RTRIM(SubCuenta), ''), ISNULL(SUM(Comision), 0.0), ISNULL(SUM(ManoObra), 0.0), ISNULL(SUM(Indirectos), 0.0), ISNULL(SUM(Maquila), 0.0)
    FROM ProdD
   WHERE ID = @ID
   GROUP BY ProdSerieLote, Orden, Centro, Articulo, SubCuenta
   ORDER BY ProdSerieLote, Orden, Centro, Articulo, SubCuenta

  OPEN crProdD
  FETCH NEXT FROM crProdD INTO @ProdSerieLote, @Orden, @Centro, @Articulo, @SubCuenta, @Comision, @ManoObra, @Indirectos, @Maquila
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Comision   <> 0.0 EXEC spProdSerieLoteCosto @Sucursal, @Accion, @Empresa, @Modulo, @ID, @MovTipo, NULL, @ProdSerieLote, @Articulo, @SubCuenta, @Comision,   @MovMoneda, 'Comisiones', 1
      IF @ManoObra   <> 0.0 EXEC spProdSerieLoteCosto @Sucursal, @Accion, @Empresa, @Modulo, @ID, @MovTipo, NULL, @ProdSerieLote, @Articulo, @SubCuenta, @ManoObra,   @MovMoneda, 'Mano Obra', 1
      IF @Indirectos <> 0.0 EXEC spProdSerieLoteCosto @Sucursal, @Accion, @Empresa, @Modulo, @ID, @MovTipo, NULL, @ProdSerieLote, @Articulo, @SubCuenta, @Indirectos, @MovMoneda, 'Indirectos', 1
      IF @Maquila    <> 0.0 
      BEGIN
        SELECT @Cxp = Cxp, @Proveedor = NULLIF(RTRIM(Proveedor), ''), @CxpMov = CxpMov, @Concepto = Concepto, @Impuesto1 = Impuesto1, @Condicion = Condicion FROM Centro WHERE Centro = @Centro
        EXEC xpProdCostearAvanceCxp @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                    @FechaEmision, @FechaRegistro, @Usuario, @Proyecto, @Ejercicio, @Periodo, @Referencia, @Observaciones,
                                    @Ok OUTPUT, @OkRef OUTPUT, @Cxp OUTPUT, @Proveedor OUTPUT, @CxpMov OUTPUT, @Concepto OUTPUT, @Impuesto1 OUTPUT, @Condicion OUTPUT
        
        IF @Cxp = 0 SELECT @Ok = 25355, @OkRef = @Centro
        IF @Proveedor IS NULL AND @Ok IS NULL SELECT @Ok = 40020
        SELECT @MaquilaIVA = @Maquila * (@Impuesto1 / 100)
        IF @Ok IS NULL
          EXEC spGenerarCx @Sucursal, @Sucursal, @Sucursal, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                           @FechaEmision, @Concepto, @Proyecto, @Usuario, NULL, @Referencia, NULL, @Observaciones,
  	  	           @FechaRegistro, @Ejercicio, @Periodo,
		           @Condicion, NULL, @Proveedor, NULL, NULL, NULL, NULL, NULL,
                           @Maquila, @MaquilaIVA, NULL, NULL, 
                           NULL, NULL, NULL, NULL, NULL, @CxpMov,
		           @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL
          EXEC spProdSerieLoteCosto @Sucursal, @Accion, @Empresa, @Modulo, @ID, @MovTipo, NULL, @ProdSerieLote, @Articulo, @SubCuenta, @Maquila,    @MovMoneda, 'Maquila', 1
      END
    END
    FETCH NEXT FROM crProdD INTO @ProdSerieLote, @Orden, @Centro, @Articulo, @SubCuenta, @Comision, @ManoObra, @Indirectos, @Maquila
  END
  CLOSE crProdD
  DEALLOCATE crProdD
  RETURN
END
GO


/**************** spProdGenerarCxp ****************/
--if exists (select * from sysobjects where id = object_id('dbo.spProdGenerarCxp') and type = 'P') drop procedure dbo.spProdGenerarCxp
GO             
/*CREATE PROCEDURE spProdGenerarCxp
		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @AvanceID           		int,
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
		   @FechaEmision		datetime,
    		   @FechaRegistro    		datetime,
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @Referencia	      		varchar(50),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
		   @Ejercicio			int,
		   @Periodo			int,

    		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Concepto		 varchar(50), 
    @Proveedor		 char(10), 
    @Moneda		 char(10),
    @TipoCambio		 float,
    @Importe		 money, 
    @Impuestos		 money, 
    @PorcentajeImpuestos float, 
    @Condicion		 varchar(50), 
    @CxModulo		 char(5),
    @CxMov		 char(20),
    @CxMovID		 varchar(20)

  IF (SELECT CostoAdicional FROM Prod WHERE ID = @AvanceID) = 0 RETURN

  DECLARE crCostoAdicional CURSOR FOR
   SELECT ca.Moneda, m.TipoCambio, c.Proveedor, c.Concepto, c.Condicion, c.Impuesto1, "Importe" = SUM(ISNULL(ca.Cantidad, 0.0)*ISNULL(ca.Costo, 0.0)*(1-(ISNULL(ca.DescuentoLinea, 0.0)/100)))
     FROM ProdCostoAdicional ca, Centro c, Mon m
    WHERE ca.AvanceID = @AvanceID
      AND c.Centro = ca.Centro AND c.Cxp = 1 AND m.Moneda = ca.Moneda
    GROUP BY ca.Moneda, m.TipoCambio, c.Proveedor, c.Concepto, c.Condicion, c.Impuesto1  
  OPEN crCostoAdicional
  FETCH NEXT FROM crCostoAdicional INTO @Moneda, @TipoCambio, @Proveedor, @Concepto, @Condicion, @PorcentajeImpuestos, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @Importe > 0.0
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Impuestos = ROUND(@Importe * (@PorcentajeImpuestos/100), 4)
      EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @AvanceID, @Mov, @MovID, @MovTipo, @Moneda, @TipoCambio, 
                       @FechaEmision, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
  		       @FechaRegistro, @Ejercicio, @Periodo,
		       @Condicion, NULL, @Proveedor, NULL, NULL, NULL, NULL, NULL,
                       @Importe, @Impuestos, NULL, NULL,
                       NULL, NULL, NULL, NULL, NULL, NULL,
		       @CxModulo, @CxMov, @CxMovID,
                       @Ok OUTPUT, @OkRef OUTPUT
    END
    FETCH NEXT FROM crCostoAdicional INTO @Moneda, @TipoCambio, @Proveedor, @Concepto, @Condicion, @PorcentajeImpuestos, @Importe
  END
  CLOSE crCostoAdicional
  DEALLOCATE crCostoAdicional

  RETURN
END*/
GO

/**************** spAutoGenerarOP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAutoGenerarOP') and type = 'P') drop procedure dbo.spAutoGenerarOP
GO
CREATE PROCEDURE spAutoGenerarOP
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
		   @ProdSerieLote	varchar(50),

		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @IDProd		int,
    @IDGenerar		int,
    @ContID		int,
    @GenerarMov		char(20),
    @GenerarMovID	char(20),
    @AutoReservar	bit

  SELECT @IDProd = NULL
  SELECT @GenerarMov   = ProdOrdenProduccion 
    FROM EmpresaCfgMov 
   WHERE Empresa = @Empresa

  SELECT @AutoReservar = ProdAutoReservar
    FROM EmpresaCfg2   
   WHERE Empresa = @Empresa

  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @IDProd = MAX(ID)
      FROM Prod
     WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Mov = @GenerarMov
       AND Estatus <> 'CANCELADO'
  END ELSE
  BEGIN
    IF EXISTS(SELECT d.* FROM VentaD d, Art a WHERE d.Articulo = a.Articulo AND a.SeProduce = 1 AND d.ID = @ID)
    BEGIN
      INSERT Prod (UltimoCambio, Sucursal,  SucursalOrigen, SucursalDestino, OrigenTipo,  Origen,  OrigenID,  Empresa,  Usuario,  Estatus,      Mov,         FechaEmision,  VerDestino, AutoReservar,  Almacen, Concepto, Proyecto, Moneda, TipoCambio, Referencia, Observaciones, Prioridad, FechaEntrega)
           SELECT GETDATE(),     @Sucursal, @Sucursal,      @Sucursal,       @Modulo,     @Mov,    @MovID,    @Empresa, @Usuario, 'SINAFECTAR', @GenerarMov, FechaEmision,  1,          @AutoReservar, Almacen, Concepto, Proyecto, Moneda, TipoCambio, Referencia, Observaciones, Prioridad, FechaRequerida
             FROM Venta 
            WHERE ID = @ID 
      SELECT @IDProd = SCOPE_IDENTITY()
  
      INSERT ProdD (ID,      Renglon,   RenglonSub,   RenglonID,   RenglonTipo,   Almacen,   Articulo,   SubCuenta,   Cantidad,            Unidad,   Factor,   CantidadInventario,   ProdSerieLote,  DestinoTipo, Destino, DestinoID, Cliente,  FechaRequerida,   FechaEntrega,     DescripcionExtra,   Ruta)
            SELECT  @IDProd, d.Renglon, d.RenglonSub, d.RenglonID, d.RenglonTipo, d.Almacen, d.Articulo, d.SubCuenta, d.CantidadPendiente, d.Unidad, d.Factor, d.CantidadInventario, @ProdSerieLote, @Modulo,     @Mov,    @MovID,    @Cliente, d.FechaRequerida, d.FechaRequerida, d.DescripcionExtra, a.ProdRuta
        FROM VentaD d, Art a
       WHERE d.ID = @ID AND d.Articulo = a.Articulo AND a.SeProduce = 1
    END
  END
  IF @IDProd IS NOT NULL
  BEGIN
    IF @Accion <> 'CANCELAR'
      EXEC spProdExplotar @Sucursal, @Empresa, @Usuario, @Accion, 'PROD', @IDProd, @FechaRegistro, 1, @Ok OUTPUT, @OkRef OUTPUT, @EnSilencio = 1

    EXEC spInv @IDProd, 'PROD', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, NULL, 
               @GenerarMov OUTPUT, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @ContID, 
               @Ok OUTPUT, @OkRef OUTPUT
    IF @Ok IS NULL 
    BEGIN
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'PROD', @IDProd, @GenerarMov, @GenerarMovID, @Ok OUTPUT 
      IF @Accion <> 'CANCELAR'
        SELECT @Ok = 80030, @OkRef = 'Movimiento: '+RTRIM(@GenerarMov) + ' ' +LTRIM(Convert(Char, @GenerarMovID))
    END
  END
  RETURN
END
GO

/**************** spInvLimiteRenFacturas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvLimiteRenFacturas') and type = 'P') drop procedure dbo.spInvLimiteRenFacturas
GO             
CREATE PROCEDURE spInvLimiteRenFacturas
			@ID			  int,
			@Limite			  int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo	int,
    @Renglon	float,
    @RenglonSub	int

  EXEC xpInvLimiteRenFacturas 'VTAS', @ID, @Limite OUTPUT
  IF (SELECT COUNT(*) FROM VentaD WHERE ID = @ID) <= @Limite RETURN

  DECLARE @Eliminar TABLE (Renglon float NULL, RenglonSub int NULL)

  DECLARE crLimiteFactura CURSOR FOR
  SELECT Renglon, RenglonSub
    FROM VentaD
   WHERE ID = @ID
   ORDER BY Cantidad DESC

  SELECT @Conteo = 0
  OPEN crLimiteFactura
  FETCH NEXT FROM crLimiteFactura INTO @Renglon, @RenglonSub
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Conteo = @Conteo + 1 
      IF @Conteo>@Limite 
        INSERT @Eliminar (Renglon, RenglonSub) VALUES (@Renglon, @RenglonSub)
    END
    FETCH NEXT FROM crLimiteFactura INTO @Renglon, @RenglonSub
  END
  CLOSE crLimiteFactura
  DEALLOCATE crLimiteFactura

  DELETE VentaD 
    FROM VentaD d
    JOIN @Eliminar e ON e.Renglon = d.Renglon AND e.RenglonSub = d.RenglonSub
   WHERE d.ID = @ID 
  RETURN
END
GO

/**************** spInvLimiteRenFacturasAgrupada ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvLimiteRenFacturasAgrupada') and type = 'P') drop procedure dbo.spInvLimiteRenFacturasAgrupada
GO             
CREATE PROCEDURE spInvLimiteRenFacturasAgrupada
			@ID		int,
			@Limite		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo		int,
    @Articulo		char(20),
    @uArticulo		char(20),
    @SubCuenta		varchar(50),
    @uSubCuenta		varchar(50),
    @Renglon		float,
    @RenglonID		int

  EXEC xpInvLimiteRenFacturas 'VTAS', @ID, @Limite OUTPUT
  IF (SELECT COUNT(*) FROM VentaD WHERE ID = @ID) <= @Limite RETURN

  SELECT @uArticulo = NULL, @uSubCuenta = NULL

  DECLARE @Eliminar TABLE (Renglon float NULL, RenglonID int NULL)

  DECLARE crLimiteFactura CURSOR FOR
  SELECT Articulo, SubCuenta, Renglon, RenglonID
    FROM VentaD
   WHERE ID = @ID
   ORDER BY Articulo, SubCuenta

  SELECT @Conteo = 0
  OPEN crLimiteFactura
  FETCH NEXT FROM crLimiteFactura INTO @Articulo, @SubCuenta, @Renglon, @RenglonID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @uArticulo IS NOT NULL AND (@Articulo <> @uArticulo OR @SubCuenta <> @uSubCuenta)
        SELECT @Conteo = @Conteo + 1 
      SELECT @uArticulo = @Articulo, @uSubCuenta = @SubCuenta

      IF @Conteo>=@Limite 
        INSERT @Eliminar (Renglon, RenglonID) VALUES (@Renglon, @RenglonID)
    END
    FETCH NEXT FROM crLimiteFactura INTO @Articulo, @SubCuenta, @Renglon, @RenglonID
  END
  CLOSE crLimiteFactura
  DEALLOCATE crLimiteFactura

  DELETE VentaD WHERE ID = @ID AND RenglonID IN (SELECT DISTINCT RenglonID FROM @Eliminar)
  DELETE VentaD WHERE ID = @ID AND Renglon   IN (SELECT DISTINCT Renglon   FROM @Eliminar)
  RETURN
END
GO

/**************** spVINEntrada ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVINEntrada') and type = 'P') drop procedure dbo.spVINEntrada
GO              
CREATE PROCEDURE spVINEntrada
			@Empresa	char(5),
			@Modulo 	char(5),
			@ID 		int,
			@Mov		char(20),
			@RenglonID 	int,
			@Articulo	char(20),
			@FechaEmision	datetime,
			@FechaRequerida	datetime,
			@ImporteNeto    float,
			@Impuesto1Neto  float,
    			@VIN		varchar(20)	OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoUnidad		varchar(20),
    @NumeroEconomico	varchar(20),
    @FechaEntrada	datetime,
    @FechaMRS		datetime,
    @Interfase          bit,
    @IntercambioDirecto	bit

  DECLARE crVIN CURSOR FOR
  SELECT v.VIN, v.TipoUnidad, NULLIF(RTRIM(v.NumeroEconomico), ''), ISNULL(v.FechaFacturaCompra, @FechaEmision), v.FechaMRS, v.IntercambioDirecto, v.Interfase
    FROM VIN v, SerieLoteMov s
   WHERE s.Empresa = @Empresa AND s.Modulo = @Modulo AND s.ID = @ID AND s.RenglonID = @RenglonID AND s.Articulo  = @Articulo
     AND v.VIN = s.SerieLote
  OPEN crVIN
  FETCH NEXT FROM crVIN INTO @VIN, @TipoUnidad, @NumeroEconomico, @FechaEntrada, @FechaMRS, @IntercambioDirecto, @Interfase
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @NumeroEconomico IS NULL
        EXEC xpVINNumeroEconomico @VIN, @TipoUnidad, @Articulo, @FechaEntrada, @NumeroEconomico OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
      EXEC xpVINFechaMRS @VIN, @Mov, @FechaEntrada, @FechaRequerida, @FechaMRS OUTPUT, @IntercambioDirecto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE VIN 
         SET FechaEntrada          = @FechaEntrada,
             NumeroEconomico       = @NumeroEconomico,
             FechaMRS              = @FechaMRS,
             IntercambioDirecto    = @IntercambioDirecto,
             CompraID	           = @ID,
             SubTotalFacturaCompra = CASE WHEN @Interfase = 0 OR UPPER(@TipoUnidad) = 'SEMINUEVO' THEN @ImporteNeto   ELSE SubTotalFacturaCompra END,
             IVAFacturaCompra      = CASE WHEN @Interfase = 0 OR UPPER(@TipoUnidad) = 'SEMINUEVO' THEN @Impuesto1Neto ELSE IVAFacturaCompra      END,
             TotalFacturaCompra    = CASE WHEN @Interfase = 0 OR UPPER(@TipoUnidad) = 'SEMINUEVO' THEN @ImporteNeto+@Impuesto1Neto ELSE TotalFacturaCompra END
       WHERE CURRENT OF crVIN      
    END
    FETCH NEXT FROM crVIN INTO @VIN, @TipoUnidad, @NumeroEconomico, @FechaEntrada, @FechaMRS, @IntercambioDirecto, @Interfase
  END
  CLOSE crVIN
  DEALLOCATE crVIN

  RETURN
END
GO


/**************** spLotesFijos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLotesFijos') and type = 'P') drop procedure dbo.spLotesFijos
GO              
CREATE PROCEDURE spLotesFijos
			@Empresa		char(5),
			@Sucursal		int,
			@FechaEmision		datetime,
			@Contacto		varchar(10),
			@EnviarA		int,
			@Modulo 		char(5),
			@ID 			int,
			@Mov			char(20),
			@MovID			varchar(20),
			@MovTipo		char(20),
			@Renglon		float,
			@RenglonSub		int,
			@RenglonID 		int,
			@ArtTipo		char(20),
			@Articulo		char(20),
			@SubCuenta		varchar(50),
			@Almacen		char(10),
			@ZonaImpuesto		varchar(50),
			@Cantidad		float,
			@Factor			float,
			@CfgImpInc		bit,
			@EsEntrada		bit,
			@Precio			float, 
			@DescuentoTipo		char(1), 
			@DescuentoLinea		float, 
			@DescuentoGlobal	float,
			@SobrePrecio		float,
			@TipoImpuesto1		varchar(10),
			@TipoImpuesto2		varchar(10),
			@TipoImpuesto3		varchar(10),
			@TipoImpuesto5		varchar(10),
			@Impuesto1		float 		OUTPUT,
			@Impuesto2		float 		OUTPUT,
			@Impuesto3		float 		OUTPUT,
			@Impuesto5		float 		OUTPUT,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT,
			@CfgPrecioMoneda	bit = 0,
			@MovTipoCambio		float = NULL,
			@PrecioTipoCambio	float = NULL,
			@ContUso		varchar(20),
			@ContUso2		varchar(20),
			@ContUso3		varchar(20),
			@ClavePresupuestal	    varchar(50),
			@ClavePresupuestalImpuesto1 varchar(50),
			@Retencion1		float,
			@Retencion2		float,
			@Retencion3		float
			
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @LoteFijo			varchar(50),
    @LoteCantidad		float,
    @SumaCantidad		float,
    @LoteImpuesto1		float,
    @LoteImpuesto2		float,
    @LoteImpuesto3		float,
    @LoteImpuesto5		float,
    @TotalImpuesto1		float,
    @TotalImpuesto2		float,
    @TotalImpuesto3		float,
    @TotalImpuesto5		float,
    @SubTotal			money,
    @Importe 			money,
    @ImporteNeto 		money,
    @DescuentoLineaImporte	money,
    @DescuentoGlobalImporte	money,
    @SobrePrecioImporte		money,
    @Impuestos 			money,
    @ImpuestosNetos 		money,
    @Impuesto1Neto 		money,
    @Impuesto2Neto 		money,
    @Impuesto3Neto 		money,
    @Impuesto5Neto 		money,
    @ArtExcento1		bit,
    @ArtExcento2		bit,
    @ArtExcento3		bit,
    @AplicaMov							varchar(20),	--MEJORA1002
    @AplicaMovID						int,			--MEJORA1002
    @VentaMovImpuestoDesdeRemision		bit,			--MEJORA1002
    @ArrastrarMovImpuestoRemision		bit,			--MEJORA1002
    @AplicaConcepto						varchar(50),	--MEJORA1002
    @AplicaFechaEmision					datetime,		--MEJORA1002
    @MovImpuestoAplicaID				int				--MEJORA1002
    
  SELECT @VentaMovImpuestoDesdeRemision = VentaMovImpuestoDesdeRemision FROM EmpresaCfg WHERE Empresa = @Empresa --MEJORA1002  
      
  SELECT @SubCuenta = ISNULL(RTRIM(@SubCuenta), ''), @Cantidad = NULLIF(@Cantidad, 0)
  DELETE SerieLoteMov FROM SerieLoteMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta AND NULLIF(Cantidad, 0) IS NULL
  SELECT @ArtExcento1 = ISNULL(Impuesto1Excento, 0), @ArtExcento2 = ISNULL(Excento2, 0), @ArtExcento3 = ISNULL(Excento3, 0)
    FROM Art
   WHERE Articulo = @Articulo

  SELECT @TotalImpuesto1 = 0.0, @TotalImpuesto2 = 0.0, @TotalImpuesto3 = 0.0, @TotalImpuesto5 = 0.0, @SubTotal = 0.0, @SumaCantidad = 0.0

  DECLARE crLote CURSOR FOR
  SELECT f.Lote, s.Cantidad/@Factor, ISNULL(f.Impuesto1, 0), ISNULL(f.Impuesto2, 0), ISNULL(f.Impuesto3, 0), ISNULL(f.Impuesto5, 0)
    FROM SerieLoteMov s, LoteFijo f 
   WHERE s.Empresa = @Empresa AND s.Modulo = @Modulo AND s.ID = @ID AND s.RenglonID = @RenglonID AND s.Articulo = @Articulo AND ISNULL(s.SubCuenta, '') = @SubCuenta AND s.SerieLote = f.Lote
  OPEN crLote
  FETCH NEXT FROM crLote INTO @LoteFijo, @LoteCantidad, @LoteImpuesto1, @LoteImpuesto2, @LoteImpuesto3, @LoteImpuesto5
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spZonaImp @ZonaImpuesto, @LoteImpuesto1 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @LoteImpuesto2 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @LoteImpuesto3 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @LoteImpuesto5 OUTPUT
      IF @Cantidad<0.0 SELECT @LoteCantidad = -@LoteCantidad

      EXEC spCalculaImporte 'AFECTAR', @Modulo, @CfgImpInc, @MovTipo, @EsEntrada, @LoteCantidad, @Precio, @DescuentoTipo, @DescuentoLinea, @DescuentoGlobal, @SobrePrecio, @LoteImpuesto1, @LoteImpuesto2, @LoteImpuesto3, @LoteImpuesto5,
                            @Importe OUTPUT, @ImporteNeto OUTPUT, @DescuentoLineaImporte OUTPUT, @DescuentoGlobalImporte OUTPUT, @SobrePrecioImporte OUTPUT, 
                            @Impuestos OUTPUT, @ImpuestosNetos OUTPUT, @Impuesto1Neto OUTPUT, @Impuesto2Neto OUTPUT, @Impuesto3Neto OUTPUT, @Impuesto5Neto OUTPUT, 
			    @Articulo = @Articulo, @CfgPrecioMoneda = @CfgPrecioMoneda, @MovTipoCambio = @MovTipoCambio, @PrecioTipoCambio = @PrecioTipoCambio,
			    @Retencion1 = @Retencion1, @Retencion2 = @Retencion2, @Retencion3 = @Retencion3, @ID = @ID

      IF @Modulo = 'VTAS' AND @VentaMovImpuestoDesdeRemision = 1 --MEJORA1002
      BEGIN
        SELECT @AplicaMov = Aplica, @AplicaMovID = AplicaID FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub  
        IF EXISTS(SELECT * FROM Venta v JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = @Modulo WHERE v.Empresa = @Empresa AND v.Mov = @AplicaMov AND v.MovID = @AplicaMovID AND mt.Clave = 'VTAS.VCR') AND @VentaMovImpuestoDesdeRemision = 1 AND @MovTipo IN ('VTAS.F')
        BEGIN
          SELECT @ArrastrarMovImpuestoRemision = 1
          SELECT @MovImpuestoAplicaID = ID, @AplicaConcepto = Concepto, @AplicaFechaEmision = FechaEmision FROM Venta WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID
        END ELSE
        BEGIN
          SELECT @ArrastrarMovImpuestoRemision = 0, @MovImpuestoAplicaID = NULL, @AplicaConcepto = NULL, @AplicaFechaEmision = NULL
        END  
      END

      IF @ArrastrarMovImpuestoRemision = 0 --MEJORA1002
      BEGIN
        INSERT #MovImpuesto (Renglon,  RenglonSub,  Excento1,     Excento2,     Excento3,     TipoImpuesto1,  TipoImpuesto2,  TipoImpuesto3,  TipoImpuesto5,  Impuesto1,      Impuesto2,      Impuesto3,      Impuesto5,      Importe1,       Importe2,       Importe3,       Importe5,       SubTotal,     LoteFijo,  ContUso,  ContUso2,  ContUso3,  ClavePresupuestal,  ClavePresupuestalImpuesto1,  DescuentoGlobal,  ImporteBruto)
                     VALUES (@Renglon, @RenglonSub, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @LoteImpuesto1, @LoteImpuesto2, @LoteImpuesto3, @LoteImpuesto5, @Impuesto1Neto, @Impuesto2Neto, @Impuesto3Neto, @Impuesto5Neto, @ImporteNeto, @LoteFijo, @ContUso, @ContUso2, @ContUso3, @ClavePresupuestal, @ClavePresupuestalImpuesto1, @DescuentoGlobal, @Importe)
      END ELSE
      BEGIN
        IF @ArrastrarMovImpuestoRemision = 1 --MEJORA1002
        BEGIN
          INSERT #MovImpuesto (OrigenModulo, OrigenModuloID,       OrigenConcepto,  OrigenFecha,         Renglon,  RenglonSub,  Excento1,     Excento2,     Excento3,     TipoImpuesto1,  TipoImpuesto2,  TipoImpuesto3,  TipoImpuesto5,  Impuesto1,      Impuesto2,      Impuesto3,      Impuesto5,      Importe1,       Importe2,       Importe3,       Importe5,       SubTotal,     LoteFijo,  ContUso,  ContUso2,  ContUso3,  ClavePresupuestal,  ClavePresupuestalImpuesto1,  DescuentoGlobal,  ImporteBruto)
                       VALUES ('VTAS',       @MovImpuestoAplicaID, @AplicaConcepto, @AplicaFechaEmision, @Renglon, @RenglonSub, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @LoteImpuesto1, @LoteImpuesto2, @LoteImpuesto3, @LoteImpuesto5, @Impuesto1Neto, @Impuesto2Neto, @Impuesto3Neto, @Impuesto5Neto, @ImporteNeto, @LoteFijo, @ContUso, @ContUso2, @ContUso3, @ClavePresupuestal, @ClavePresupuestalImpuesto1, @DescuentoGlobal, @Importe)      
        END             
      END                   

      SELECT @TotalImpuesto1 = @TotalImpuesto1 + @Impuesto1Neto, 
             @TotalImpuesto2 = @TotalImpuesto2 + @Impuesto2Neto, 
             @TotalImpuesto3 = @TotalImpuesto3 + @Impuesto3Neto,
             @TotalImpuesto5 = @TotalImpuesto5 + @Impuesto5Neto,
             @SubTotal       = @SubTotal + @ImporteNeto,
             @SumaCantidad   = @SumaCantidad + @LoteCantidad
    END
    FETCH NEXT FROM crLote INTO @LoteFijo, @LoteCantidad, @LoteImpuesto1, @LoteImpuesto2, @LoteImpuesto3, @LoteImpuesto5
  END
  CLOSE crLote
  DEALLOCATE crLote

  SELECT @Impuesto1 = (@TotalImpuesto1 / NULLIF(@SubTotal + @TotalImpuesto2, 0)) * 100,
         @Impuesto2 = (@TotalImpuesto2 / NULLIF(@SubTotal, 0)) * 100,
         @Impuesto3 = (@TotalImpuesto3 / NULLIF(@SubTotal + @TotalImpuesto2, 0)) * 100,
         @Impuesto5 = (@TotalImpuesto5 / NULLIF(@SubTotal + @TotalImpuesto2, 0)) * 100

  IF ROUND(@Cantidad, 0) <> ROUND(@SumaCantidad, 0) SELECT @Ok = 20330

/*  SELECT @SubCuenta = ISNULL(RTRIM(@SubCuenta), ''), @Cantidad = NULLIF(@Cantidad, 0)
  DELETE SerieLoteMov FROM SerieLoteMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta AND NULLIF(Cantidad, 0) IS NULL
  SELECT @Impuesto1 = SUM(s.Cantidad*ISNULL(f.Impuesto1, @Impuesto1)) / @Cantidad FROM SerieLoteMov s, LoteFijo f WHERE s.Empresa = @Empresa AND s.Modulo = @Modulo AND s.ID = @ID AND s.RenglonID = @RenglonID AND s.Articulo = @Articulo AND ISNULL(s.SubCuenta, '') = @SubCuenta AND s.SerieLote = f.Lote
  SELECT @Impuesto2 = SUM(s.Cantidad*ISNULL(f.Impuesto2, @Impuesto2)) / @Cantidad FROM SerieLoteMov s, LoteFijo f WHERE s.Empresa = @Empresa AND s.Modulo = @Modulo AND s.ID = @ID AND s.RenglonID = @RenglonID AND s.Articulo = @Articulo AND ISNULL(s.SubCuenta, '') = @SubCuenta AND s.SerieLote = f.Lote
  SELECT @Impuesto3 = SUM(s.Cantidad*ISNULL(f.Impuesto3, @Impuesto3)) / @Cantidad FROM SerieLoteMov s, LoteFijo f WHERE s.Empresa = @Empresa AND s.Modulo = @Modulo AND s.ID = @ID AND s.RenglonID = @RenglonID AND s.Articulo = @Articulo AND ISNULL(s.SubCuenta, '') = @SubCuenta AND s.SerieLote = f.Lote

  EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
  EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
  EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT*/
  RETURN
END
GO

/**************** spArtAlmABC ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtAlmABC') and type = 'P') drop procedure dbo.spArtAlmABC
GO              
CREATE PROCEDURE spArtAlmABC
			@Articulo		char(20), 
			@Almacen		char(10), 
			@FechaEmision		datetime,
			@CfgDiasHabiles		varchar(20),
			@CfgABCDiasHabiles	bit        
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Frecuencia		int,
    @SiguienteConteo	datetime

  SELECT @Frecuencia = NULL
  SELECT @Frecuencia = l.Frecuencia
    FROM Art a, AlmABC l
   WHERE a.Articulo = @Articulo AND l.Almacen = @Almacen AND l.ABC = a.ABC

  IF @CfgABCDiasHabiles = 1
    EXEC spCalcularDiasHabiles @FechaEmision, @Frecuencia, @CfgDiasHabiles, 0, @SiguienteConteo OUTPUT
  ELSE
    SELECT @SiguienteConteo = DATEADD(day, @Frecuencia, @FechaEmision)
  
  UPDATE ArtAlmABC 
     SET UltimoConteo = @FechaEmision, SiguienteConteo = @SiguienteConteo
   WHERE Articulo = @Articulo AND Almacen = @Almacen
  IF @@ROWCOUNT = 0
    INSERT ArtAlmABC (Articulo,  Almacen,  UltimoConteo,  SiguienteConteo) 
              VALUES (@Articulo, @Almacen, @FechaEmision, @SiguienteConteo) 
  RETURN
END
GO

/**************** spBorrarVentaCobro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spBorrarVentaCobro') and sysstat & 0xf = 4) drop procedure dbo.spBorrarVentaCobro
GO             
CREATE PROCEDURE spBorrarVentaCobro
                        @ID        int
--//WITH ENCRYPTION
AS BEGIN
  UPDATE VentaCobro 
     SET Actualizado = 1, Importe1 = NULL, Importe2 = NULL, Importe3 = NULL, Importe4 = NULL, Importe5 = NULL, DelEfectivo = NULL, Cambio = NULL, Redondeo = NULL
   WHERE ID = @ID
  RETURN
END
GO

/**************** spCobroIntegradoCxcCancelar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCobroIntegradoCxcCancelar') and sysstat & 0xf = 4) drop procedure dbo.spCobroIntegradoCxcCancelar
GO             
CREATE PROCEDURE spCobroIntegradoCxcCancelar
		   @Sucursal			int,
		   @Accion			char(20),
		   @Modulo			char(5),
    		   @Empresa	      		char(5),
                   @Usuario                     char(10),
                   @ID				int,
 		   @Mov				char(20),
    		   @MovID             		varchar(20),
                   @FechaRegistro               datetime,
		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CobroID        int,
    @CobroMov       varchar(20),
    @CobroMovID     varchar(20)

  SELECT @CobroMov = CxcCobro
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL

  SELECT @CobroID = ID, @CobroMov = Mov, @CobroMovID = MovID 
    FROM Cxc 
   WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
  EXEC spCx @CobroID, 'CXC', 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
            @CobroMov OUTPUT, @CobroMovID OUTPUT, NULL, 
            @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

--REQ13163
/**************** spTCAplicacionSaldo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTCAplicacionSaldo') and type = 'P') drop procedure dbo.spTCAplicacionSaldo
GO             
CREATE PROC spTCAplicacionSaldo
			@Modulo			varchar(5), 
			@ID				int, 
			@Mov			varchar(20),
			@MovTipo		varchar(20),
			@Empresa		varchar(5), 
			@Sucursal		int,
			@Usuario		varchar(10),
			@Accion			varchar(20),
			@Cliente		varchar(10),
			@TCDelEfectivo	float,
			@FechaEmision	datetime,
			@CxID			int, 
			@CxMov			varchar(20), 
			@CxMovID		varchar(20), 
			@Ok				int				OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @GenerarMov	varchar(20),
		  @IDGenerar	int,
		  @TCAccion		varchar(20)

  CREATE TABLE #CxcD(
    ID				int, 
    Renglon			int IDENTITY(2048, 2048),
    RenglonSub		int, 
    Importe			float, 
    Aplica			varchar(20),
    AplicaID		varchar(20)
    )
    
  SELECT @TCAccion = TCAccion FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov AND Clave = @MovTipo

  IF @TCAccion = 'Auth'
    SELECT @GenerarMov = CxcAplicacionSaldo FROM EmpresaCfgMov WHERE Empresa = @Empresa
  ELSE IF @TCAccion = 'Credit'
    SELECT @GenerarMov = CxcAplicacion FROM EmpresaCfgMov WHERE Empresa = @Empresa
    
  IF @Accion = 'AFECTAR'
  BEGIN
    IF @TCAccion = 'Auth'
    BEGIN
      INSERT INTO Cxc(
			    Empresa, Cliente,   ClienteEnviarA, Agente,    Mov,         Importe,       Impuestos, Proyecto,   Moneda,    FechaEmision, TipoCambio,    Usuario, Estatus,      ClienteMoneda, ClienteTipoCambio,             Vencimiento,  Sucursal,    AplicaManual, OrigenTipo, Origen,  OrigenID, Observaciones)
        SELECT @Empresa, v.Cliente, v.EnviarA,      v.Agente, @GenerarMov, @TCDelEfectivo, 0,         v.Proyecto, v.Moneda, @FechaEmision, v.TipoCambio, @Usuario, 'SINAFECTAR', c.DefMoneda,   dbo.fnTipoCambio(c.DefMoneda), @FechaEmision, v.Sucursal, 1,            'CXC',      @CxMov, @CxMovID,  'Aplicacion Cobros Tarjetas Bancarias'
          FROM Venta v
          JOIN Cte c ON v.Cliente = c.Cliente
         WHERE v.ID = @ID  

      SELECT @IDGenerar = @@IDENTITY
    
      INSERT INTO CxcD(ID, Renglon, RenglonSub, Importe, Aplica, AplicaID) VALUES(@IDGenerar, 2048, 0, @TCDelEfectivo, @CxMov, @CxMovID)
    END
    ELSE IF @TCAccion = 'Credit'
    BEGIN
      EXEC @IDGenerar = spAfectar 'CXC', @CxID, 'GENERAR', 'Todo', @GenerarMov, @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      
      INSERT INTO #CxcD(
			 ID,         RenglonSub, Importe,                            Aplica, AplicaID) 
      SELECT @IDGenerar, 0,          Cxc.Importe + ISNULL(Impuestos, 0), Mov,    MovID 
        FROM TCTransaccion JOIN Cxc ON TCTransaccion.CxcID = Cxc.ID
       WHERE Modulo = @Modulo
         AND ModuloID = @ID
         AND Cxc.Estatus = 'PENDIENTE'

      INSERT INTO CxcD(ID, Renglon, RenglonSub, Importe, Aplica, AplicaID) SELECT ID, Renglon, RenglonSub, Importe, Aplica, AplicaID FROM #CxcD
    END
    
    IF @IDGenerar IS NOT NULL
    BEGIN
      EXEC spAfectar 'CXC', @IDGenerar, 'AFECTAR', @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

      IF @Ok IS NULL
        UPDATE VentaCobro SET TCCxcIDAplicacion = @IDGenerar WHERE ID = @ID
    END
  END
  ELSE IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @IDGenerar = TCCxcIDAplicacion FROM VentaCobro WHERE ID = @ID

    IF @IDGenerar IS NOT NULL AND(SELECT Estatus FROM Cxc WHERE ID = @IDGenerar) IN('CONCLUIDO', 'PENDIENTE')
    BEGIN
      EXEC spAfectar 'CXC', @IDGenerar, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END
  END
  
  RETURN
END
GO

/**************** spCobroIntegradoCxc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCobroIntegradoCxc') and sysstat & 0xf = 4) drop procedure dbo.spCobroIntegradoCxc
GO
CREATE PROCEDURE spCobroIntegradoCxc
		   @Sucursal			int,
		   @SucursalOrigen		int,
		   @SucursalDestino		int,
		   @Accion			char(20),
		   @Modulo			char(5),
    	   @Empresa	      		char(5),
           @Usuario                     char(10),
           @ID				int,
 		   @Mov				char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
                   @MovMoneda                   char(10),
                   @MovTipoCambio               float,
                   @FechaRegistro               datetime,

                   @DineroImporte               money, 
                   @CobroDelEfectivo            money, 
                   @CobroCambio                 money, 
                   @FormaCobro1                 varchar(50), 
                   @FormaCobro2                 varchar(50), 
                   @FormaCobro3                 varchar(50), 
                   @FormaCobro4                 varchar(50), 
                   @FormaCobro5                 varchar(50),
                   @Importe1                    money, 
                   @Importe2                    money, 
                   @Importe3                    money, 
                   @Importe4                    money, 
                   @Importe5                    money,
                   @Referencia1                 varchar(50), 
                   @Referencia2                 varchar(50), 
                   @Referencia3                 varchar(50), 
                   @Referencia4                 varchar(50), 
                   @Referencia5                 varchar(50),
                   @CtaDinero                   char(10), 
                   @Cajero                      char(10),
                   @CxID                        int,
                   @FormaCambio					varchar(50),
				   @Ok							int		OUTPUT,
				   @OkRef						varchar(255)	OUTPUT,
				   @InterfazTC					bit,	--REQ13163
				   @TCDelEfectivo				float,	--REQ13163
				   @TCProcesado1				bit,	--REQ13163
				   @TCProcesado2				bit,	--REQ13163
				   @TCProcesado3				bit,	--REQ13163
				   @TCProcesado4				bit,	--REQ13163
				   @TCProcesado5				bit		--REQ13163
--//WITH ENCRYPTION
AS BEGIN
  CREATE TABLE #Moneda(
    Moneda				varchar(10)	COLLATE Database_Default NULL
    )
    
  DECLARE
    @CobroID					int,
    @CobroMov					varchar(20),
    @CobroMovID					varchar(20),
    @ImporteTotal				money,
    @Impuestos					money,
    @CobroSumaEfectivo			money,
    @PorcentajeRetencion		float,    
    @PorcentajeRetencion1		float,
    @PorcentajeRetencion2		float,
    @PorcentajeRetencion3		float,
    @OrigenImporte				float,
    @FormaMoneda1 				varchar(10),
    @FormaTipoCambio1			float,
    @FormaMoneda2 				varchar(10),
    @FormaTipoCambio2			float,
    @FormaMoneda3 				varchar(10),
    @FormaTipoCambio3			float,
    @FormaMoneda4 				varchar(10),
    @FormaTipoCambio4			float,
    @FormaMoneda5 				varchar(10),
    @FormaTipoCambio5			float,
    @FormaMonedaCambio 			varchar(10),
    @FormaTipoCambioCambio		float,    
	@Retencion1					float,
	@Retencion2					float,
	@Retencion3					float,
	@CfgCobroImpuestos			bit,
	
	@Moneda						varchar(10),
	@MonedaAnt					varchar(10),
	@TipoCambio					float

  SELECT @CfgCobroImpuestos = ISNULL(CxcCobroImpuestos,0) FROM EmpresaCfg2 WHERE Empresa = @Empresa	 --MEJORA7686

  IF @InterfazTC = 1 --REQ13163
  BEGIN
    IF @TCProcesado1 = 1 SELECT @FormaCobro1 = NULL, @Importe1 = 0, @Referencia1 = NULL
    IF @TCProcesado2 = 1 SELECT @FormaCobro2 = NULL, @Importe2 = 0, @Referencia2 = NULL
    IF @TCProcesado3 = 1 SELECT @FormaCobro3 = NULL, @Importe3 = 0, @Referencia3 = NULL
    IF @TCProcesado4 = 1 SELECT @FormaCobro4 = NULL, @Importe4 = 0, @Referencia4 = NULL
    IF @TCProcesado5 = 1 SELECT @FormaCobro5 = NULL, @Importe5 = 0, @Referencia5 = NULL
  END
  
  SELECT @CobroSumaEfectivo = 0.0
  IF @Importe1 <> 0.0 EXEC spFormaPagoMonTC @FormaCobro1, @Referencia1, @MovMoneda, @MovTipoCambio, @Importe1, @CobroSumaEfectivo OUTPUT, @FormaMoneda1 OUTPUT, @FormaTipoCambio1 OUTPUT, @Ok OUTPUT
  IF @Importe2 <> 0.0 EXEC spFormaPagoMonTC @FormaCobro2, @Referencia2, @MovMoneda, @MovTipoCambio, @Importe2, @CobroSumaEfectivo OUTPUT, @FormaMoneda2 OUTPUT, @FormaTipoCambio2 OUTPUT, @Ok OUTPUT
  IF @Importe3 <> 0.0 EXEC spFormaPagoMonTC @FormaCobro3, @Referencia3, @MovMoneda, @MovTipoCambio, @Importe3, @CobroSumaEfectivo OUTPUT, @FormaMoneda3 OUTPUT, @FormaTipoCambio3 OUTPUT, @Ok OUTPUT
  IF @Importe4 <> 0.0 EXEC spFormaPagoMonTC @FormaCobro4, @Referencia4, @MovMoneda, @MovTipoCambio, @Importe4, @CobroSumaEfectivo OUTPUT, @FormaMoneda4 OUTPUT, @FormaTipoCambio4 OUTPUT, @Ok OUTPUT
  IF @Importe5 <> 0.0 EXEC spFormaPagoMonTC @FormaCobro5, @Referencia5, @MovMoneda, @MovTipoCambio, @Importe5, @CobroSumaEfectivo OUTPUT, @FormaMoneda5 OUTPUT, @FormaTipoCambio5 OUTPUT, @Ok OUTPUT
  IF ISNULL(@CobroCambio,0.0) > 0.0 EXEC spFormaPagoMonTC @FormaCambio, NULL, @MovMoneda, @MovTipoCambio, @CobroCambio, @CobroSumaEfectivo OUTPUT, @FormaMonedaCambio OUTPUT, @FormaTipoCambioCambio OUTPUT, @Ok OUTPUT  

  INSERT INTO #Moneda(
			Moneda) 
	SELECT @FormaMoneda1 
    UNION ALL
	SELECT @FormaMoneda2
    UNION ALL
	SELECT @FormaMoneda3
    UNION ALL
	SELECT @FormaMoneda4
    UNION ALL
	SELECT @FormaMoneda5
    UNION ALL
	SELECT @FormaMonedaCambio

  --IF NULLIF(@Ok,0) IS NULL AND @MovMoneda <> @FormaMoneda1 AND ISNULL(@Importe1,0.0) <> 0.0 SELECT @Ok = 30045, @OkRef = @FormaMoneda1 ELSE
  --IF NULLIF(@Ok,0) IS NULL AND @MovMoneda <> @FormaMoneda2 AND ISNULL(@Importe2,0.0) <> 0.0 SELECT @Ok = 30045, @OkRef = @FormaMoneda2 ELSE
  --IF NULLIF(@Ok,0) IS NULL AND @MovMoneda <> @FormaMoneda3 AND ISNULL(@Importe3,0.0) <> 0.0 SELECT @Ok = 30045, @OkRef = @FormaMoneda3 ELSE
  --IF NULLIF(@Ok,0) IS NULL AND @MovMoneda <> @FormaMoneda4 AND ISNULL(@Importe4,0.0) <> 0.0 SELECT @Ok = 30045, @OkRef = @FormaMoneda4 ELSE
  --IF NULLIF(@Ok,0) IS NULL AND @MovMoneda <> @FormaMoneda5 AND ISNULL(@Importe5,0.0) <> 0.0 SELECT @Ok = 30045, @OkRef = @FormaMoneda5 ELSE
  --IF NULLIF(@Ok,0) IS NULL AND @MovMoneda <> @FormaMonedaCambio  AND ISNULL(@CobroCambio,0.0) > 0.0 SELECT @Ok = 30045, @OkRef = @FormaMonedaCambio                 

  IF ROUND(@CobroCambio, 2) <> 0.0 
    IF ABS(ROUND(@CobroSumaEfectivo, 2)) < ABS(ROUND(@CobroCambio, 2)) SELECT @Ok = 30590

  IF @MovTipo = 'VTAS.D' 
    SELECT @CobroMov = CxcDevolucion
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa
  ELSE 
    SELECT @CobroMov = CxcCobro
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa
  
  SELECT @MonedaAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Moneda = MIN(Moneda)
      FROM #Moneda
     WHERE Moneda > @MonedaAnt
    
    IF @Moneda IS NULL BREAK
    
    SELECT @MonedaAnt = @Moneda

    IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL, @CobroID = NULL
    
    SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
    
    EXEC spCx @CxID, 'CXC', 'GENERAR', 'TODO', @FechaRegistro, @CobroMov, @Usuario, 1, 0,
              @CobroMov OUTPUT, @CobroMovID OUTPUT, @CobroID OUTPUT, 
              @Ok OUTPUT, @OkRef OUTPUT

    IF ROUND(@CobroCambio, 0) < 0 SELECT @CobroCambio = 0.0
    IF @CobroID IS NOT NULL
    BEGIN
      UPDATE Cxc 
         SET OrigenTipo = @Modulo, Origen = @Mov, OrigenID = @MovID,
             ConDesglose = 1, CtaDinero = @CtaDinero, Cajero = @Cajero, Moneda = @Moneda,
             TipoCambio = @TipoCambio
       WHERE ID = @CobroID

      IF @FormaMoneda1 = @Moneda
        UPDATE Cxc SET FormaCobro1 = @FormaCobro1, Importe1 = NULLIF(@Importe1, 0), Referencia1 = @Referencia1 WHERE ID = @CobroID
      IF @FormaMoneda2 = @Moneda
        UPDATE Cxc SET FormaCobro2 = @FormaCobro2, Importe2 = NULLIF(@Importe2, 0), Referencia2 = @Referencia2 WHERE ID = @CobroID      
      IF @FormaMoneda3 = @Moneda
        UPDATE Cxc SET FormaCobro3 = @FormaCobro3, Importe3 = NULLIF(@Importe3, 0), Referencia3 = @Referencia3 WHERE ID = @CobroID
      IF @FormaMoneda4 = @Moneda
        UPDATE Cxc SET FormaCobro4 = @FormaCobro4, Importe4 = NULLIF(@Importe4, 0), Referencia4 = @Referencia4 WHERE ID = @CobroID            
      IF @FormaMoneda5 = @Moneda
        UPDATE Cxc SET FormaCobro5 = @FormaCobro5, Importe5 = NULLIF(@Importe5, 0), Referencia5 = @Referencia5 WHERE ID = @CobroID            
      IF @FormaMonedaCambio = @Moneda
        UPDATE Cxc SET Cambio = NULLIF(@CobroCambio, 0.0)/@FormaTipoCambioCambio, DelEfectivo = NULLIF(@CobroDelEfectivo, 0.0)/@FormaTipoCambioCambio WHERE ID = @CobroID            
     
   	  INSERT TarjetaSerieMov (Empresa, Modulo, ID, Serie, Importe, Sucursal)
	  SELECT @Empresa, 'CXC' , @CobroID, Serie, Importe, Sucursal
        FROM TarjetaSerieMov
	   WHERE Empresa = @Empresa AND Modulo = 'VTAS' AND ID = @ID

	  INSERT ValeSerieMov (Empresa, Modulo, ID, Serie, Sucursal)
	  SELECT @Empresa, 'CXC' , @CobroID, Serie, Sucursal
  	    FROM ValeSerieMov
	   WHERE Empresa = @Empresa AND Modulo = 'VTAS' AND ID = @ID

      SELECT @ImporteTotal = ISNULL(Importe1, 0) + ISNULL(Importe2, 0) + ISNULL(Importe3, 0) + ISNULL(Importe4, 0) + ISNULL(Importe5, 0) + ISNULL(DelEfectivo, 0) - ISNULL(Cambio, 0)
        FROM Cxc
       WHERE ID = @CobroID

      --aprueba
      UPDATE CxcD SET Importe = @ImporteTotal WHERE ID = @CobroID

      SELECT @Impuestos =  SUM(d.Importe*a.IVAFiscal) FROM CxcD d, CxcAplica a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.ID = @CobroID

      SELECT @Retencion1 = SUM(CONVERT(float,d.Importe)*ISNULL(a.Retencion,0.0)/ISNULL(a.ImporteTotal,0.0)) FROM CxcD d, CxcAplica a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.ID = @CobroID    
      SELECT @Retencion2 = SUM(CONVERT(float,d.Importe)*ISNULL(a.Retencion2,0.0)/ISNULL(a.ImporteTotal,0.0)) FROM CxcD d, CxcAplica a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.ID = @CobroID        
      SELECT @Retencion3 = SUM(CONVERT(float,d.Importe)*ISNULL(a.Retencion3,0.0)/ISNULL(a.ImporteTotal,0.0)) FROM CxcD d, CxcAplica a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.ID = @CobroID                
    
      IF @MovTipo = 'VTAS.D'
        UPDATE Cxc SET Importe = @ImporteTotal, Impuestos = NULL WHERE ID = @CobroID
      ELSE
        IF @CfgCobroImpuestos = 1 --MEJORA7686
        BEGIN --MEJORA7686
          UPDATE Cxc SET Importe = @ImporteTotal - ISNULL(@Impuestos, 0) + ISNULL(@Retencion1,0.0) + ISNULL(@Retencion2,0.0) + ISNULL(@Retencion3,0.0) , Impuestos = @Impuestos, Retencion = @Retencion1, Retencion2 = @Retencion2, Retencion3 = @Retencion3 WHERE ID = @CobroID
        END --MEJORA7686        
        ELSE --MEJORA7686
        BEGIN --MEJORA7686        
          UPDATE Cxc SET Importe = @ImporteTotal, Impuestos = NULL WHERE ID = @CobroID --MEJORA7686
        END --MEJORA7686
        
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      EXEC spCx @CobroID, 'CXC', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                @CobroMov OUTPUT, @CobroMovID OUTPUT, NULL, 
                @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
    END
    
    -- 9484
    UPDATE VentaCobro SET Actualizado = 1 WHERE ID = @ID
    --EXEC spBorrarVentaCobro @ID
  END
  RETURN
END
GO
--select * from cxcd order by id desc
--select IMPUESTOS,retencion, retencion2, retencion3, * from cxc where id = 139
--select retencion, retencion2, retencion3, * from cxcd order by id desc

/**************** spInvTransferirA ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvTransferirA') and type = 'P') drop procedure dbo.spInvTransferirA
GO
CREATE PROCEDURE spInvTransferirA
		   @Empresa		char(5),
		   @Sucursal		int,
                   @Usuario		char(10),
		   @Accion		char(20),
    		   @Modulo		char(5),
                   @ID          	int,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @FechaEmision	datetime,
		   @FechaRegistro	datetime,

		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @InvID		int,
    @InvMov		varchar(20),
    @InvMovID		varchar(20),
    @Almacen		varchar(10),
    @AlmacenDestino	varchar(10)

  SELECT @InvMov = InvTransferencia
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Accion = 'CANCELAR'
  BEGIN
    DECLARE crCancelarTransferirA CURSOR LOCAL FOR
     SELECT ID, Mov, MovID
       FROM Inv
      WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
    OPEN crCancelarTransferirA
    FETCH NEXT FROM crCancelarTransferirA INTO @InvID, @InvMov, @InvMovID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spAfectar 'INV', @InvID, 'CANCELAR', 'TODO', @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @FechaRegistro = @FechaRegistro, @Conexion = 1
        EXEC spMovFlujo @Sucursal, 'CANCELAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT 
      END
      FETCH NEXT FROM crCancelarTransferirA INTO @InvID, @InvMov, @InvMovID
    END
    CLOSE crCancelarTransferirA
    DEALLOCATE crCancelarTransferirA
  END ELSE
  BEGIN
    IF @Modulo = 'VTAS'
    BEGIN
      DECLARE crTransferirA CURSOR LOCAL FOR
       SELECT DISTINCT Almacen, TransferirA
         FROM VentaD
        WHERE ID = @ID AND ISNULL(NULLIF(RTRIM(TransferirA), ''), Almacen) <> Almacen
      OPEN crTransferirA
      FETCH NEXT FROM crTransferirA INTO @Almacen, @AlmacenDestino
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          INSERT Inv (
                 Empresa,  Sucursal,  Mov,     Almacen,  AlmacenDestino,  FechaEmision,  Concepto, Referencia, Proyecto, UEN, Usuario, Estatus,       Moneda, TipoCambio, OrigenTipo, Origen, OrigenID)
          SELECT @Empresa, @Sucursal, @InvMov, @Almacen, @AlmacenDestino, @FechaEmision, Concepto, Referencia, Proyecto, UEN, @Usuario, 'SINAFECTAR', Moneda, TipoCambio, @Modulo,    @Mov,   @MovID
            FROM Venta
           WHERE ID = @ID

          SELECT @InvID = SCOPE_IDENTITY()
          INSERT InvD (
                 ID,     Renglon, RenglonSub, Sucursal, Almacen, Articulo, SubCuenta, Cantidad, Unidad, Factor)
          SELECT @InvID, Renglon, RenglonSub, Sucursal, Almacen, Articulo, SubCuenta, Cantidad, Unidad, Factor
            FROM VentaD
           WHERE ID = @ID AND Almacen = @Almacen AND TransferirA = @AlmacenDestino

          INSERT SerieLoteMov (
                 Sucursal,  Empresa,   Modulo, ID,     RenglonID,   Articulo,   SubCuenta,   SerieLote,   Cantidad)
          SELECT @Sucursal, m.Empresa, 'INV',  @InvID, m.RenglonID, m.Articulo, m.SubCuenta, m.SerieLote, m.Cantidad
            FROM SerieLoteMov m
            JOIN VentaD d ON d.ID = @ID AND Almacen = @Almacen AND TransferirA = @AlmacenDestino
           WHERE m.Modulo = @Modulo AND m.ID = @ID AND m.RenglonID = d.RenglonID AND m.Articulo = d.Articulo AND m.SubCuenta = ISNULL(d.SubCuenta, '')

          EXEC spAfectar 'INV', @InvID, 'AFECTAR', 'TODO', @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @FechaRegistro = @FechaRegistro, @Conexion = 1
          IF @Ok IS NULL
          BEGIN
            SELECT @InvMovID = MovID 
              FROM Inv
             WHERE ID = @InvID

            EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT 
          END
        END
        FETCH NEXT FROM crTransferirA INTO @Almacen, @AlmacenDestino
      END
      CLOSE crTransferirA
      DEALLOCATE crTransferirA
    END 
  END

  RETURN
END
GO

/**************** spInvAfectarTarima ****************/
--if exists (select * from sysobjects where id = object_id('dbo.spInvAfectarTarima') and type = 'P') drop procedure dbo.spInvAfectarTarima
GO
/*CREATE PROCEDURE spInvAfectarTarima
		    @Modulo			varchar(5),
    		    @ID               		int,			
 		    @Accion			varchar(20),
    		    @Empresa          		varchar(5),
		    @Sucursal			int,
		    @Usuario			varchar(10),
		    @Mov			varchar(20),
		    @MovID			varchar(20),
		    @FechaAfectacion		datetime,
		    @Ejercicio			int,
		    @Periodo			int,
		    @CfgSeriesLotesMayoreo	bit,
    		    @Ok               		int           	OUTPUT,
    		    @OkRef            		varchar(255)  	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Renglon		float, 
    @RenglonSub		int, 
    @RenglonID		int,
    @Almacen		varchar(10),
    @Tarima		varchar(20),
    @Articulo		varchar(20),
    @ArtMoneda		varchar(10),
    @ArtTipo		varchar(20),
    @ArtSerieLoteInfo	bit,
    @ArtLotesFijos	bit,
    @AlmSucursal	int,
    @SubCuenta		varchar(50),
    @Unidad		varchar(50),
    @Cantidad		float,
    @Factor		float,
    @EsCargo		bit,
    @Seccion		int

  -- Salida
  IF @Accion = 'CANCELAR' SELECT @EsCargo = 1, @Seccion = 1 ELSE SELECT @EsCargo = 0, @Seccion = NULL
  DECLARE crAfectarTarima CURSOR FOR
   SELECT d.Renglon, d.RenglonSub, d.RenglonID, d.Almacen, ISNULL(RTRIM(d.Tarima), ''), d.Articulo, ISNULL(RTRIM(d.SubCuenta), ''), ISNULL(RTRIM(d.Unidad), ''), ISNULL(d.Factor, 1.0), d.Cantidad, a.MonedaCosto, UPPER(a.Tipo), a.SerieLoteInfo, a.LotesFijos, alm.Sucursal
     FROM InvD d
     JOIN Art a ON a.Articulo = d.Articulo
     JOIN Alm ON alm.Almacen = d.Almacen
    WHERE ID = @ID AND Seccion = @Seccion
  OPEN crAfectarTarima
  FETCH NEXT FROM crAfectarTarima INTO @Renglon, @RenglonSub, @RenglonID, @Almacen, @Tarima, @Articulo, @SubCuenta, @Unidad, @Factor, @Cantidad, @ArtMoneda, @ArtTipo, @ArtSerieLoteInfo, @ArtLotesFijos, @AlmSucursal
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND NULLIF(@Cantidad, 0.0) IS NOT NULL
    BEGIN
      EXEC spSaldo @AlmSucursal, @Accion, @Empresa, @Usuario, 'INV', @ArtMoneda, NULL, @Articulo, @SubCuenta, @Almacen, NULL, 
                   'INV', @ID, @Mov, @MovID, @EsCargo, NULL, @Cantidad, @Factor,
                   @FechaAfectacion, @Ejercicio, @Periodo, NULL, NULL, 0, 0, 0,
                   @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @SubGrupo = @Tarima

      IF @ArtTipo IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA') AND @CfgSeriesLotesMayoreo = 1 
        EXEC spSeriesLotesMayoreo @Sucursal, @AlmSucursal, NULL, @Empresa, @Modulo, @Accion, 0, 0, 1, 0,
                                  @ID, @RenglonID, @Almacen, NULL, @Articulo, @SubCuenta, @ArtTipo, @ArtSerieLoteInfo, @ArtLotesFijos, @ArtCosto, @ArtCostoInv, @Cantidad, @Factor, 
       	        	          @MovTipo, NULL, @AlmTipo, @FechaEmision, @CfgCosteoSeries, @CfgCosteoLotes, @ArtCostoIdentificado, @CfgValidarLotesCostoDif, @CfgVINAccesorioArt, @CfgVINCostoSumaAccesorios,
                                  @Ok OUTPUT, @OkRef OUTPUT, @Tarima = @Tarima
    END
    FETCH NEXT FROM crAfectarTarima INTO @Renglon, @RenglonSub, @RenglonID, @Almacen, @Tarima, @Articulo, @SubCuenta, @Unidad, @Factor, @Cantidad, @ArtMoneda, @ArtTipo, @ArtSerieLoteInfo, @ArtLotesFijos, @AlmSucursal
  END 
  CLOSE crAfectarTarima
  DEALLOCATE crAfectarTarima

  -- Entrada
  IF @Accion = 'CANCELAR' SELECT @EsCargo = 0, @Seccion = NULL ELSE SELECT @EsCargo = 1, @Seccion = 1
  DECLARE crAfectarTarima CURSOR FOR
   SELECT d.Renglon, d.RenglonSub, d.RenglonID, d.Almacen, ISNULL(RTRIM(d.Tarima), ''), d.Articulo, ISNULL(RTRIM(d.SubCuenta), ''), ISNULL(RTRIM(d.Unidad), ''), ISNULL(d.Factor, 1.0), d.Cantidad, a.MonedaCosto, UPPER(a.Tipo), a.SerieLoteInfo, a.LotesFijos, alm.Sucursal
     FROM InvD d
     JOIN Art a ON a.Articulo = d.Articulo
     JOIN Alm ON alm.Almacen = d.Almacen
    WHERE ID = @ID AND Seccion = @Seccion
  OPEN crAfectarTarima
  FETCH NEXT FROM crAfectarTarima INTO @Renglon, @RenglonSub, @RenglonID, @Almacen, @Tarima, @Articulo, @SubCuenta, @Unidad, @Factor, @Cantidad, @ArtMoneda, @ArtTipo, @ArtSerieLoteInfo, @ArtLotesFijos, @AlmSucursal
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND NULLIF(@Cantidad, 0.0) IS NOT NULL
    BEGIN
      EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'INV', @ArtMoneda, NULL, @Articulo, @SubCuenta, @Almacen, NULL, 
                   'INV', @ID, @Mov, @MovID, @EsCargo, NULL, @Cantidad, @Factor,
                   @FechaAfectacion, @Ejercicio, @Periodo, NULL, NULL, 0, 0, 0,
                   @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @SubGrupo = @Tarima
    END
    FETCH NEXT FROM crAfectarTarima INTO @Renglon, @RenglonSub, @RenglonID, @Almacen, @Tarima, @Articulo, @SubCuenta, @Unidad, @Factor, @Cantidad, @ArtMoneda, @ArtTipo, @ArtSerieLoteInfo, @ArtLotesFijos, @AlmSucursal
  END 
  CLOSE crAfectarTarima
  DEALLOCATE crAfectarTarima
  RETURN
END*/
GO 
/**************** xpActualizarOrdenEntarimadoWMS ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpActualizarOrdenEntarimadoWMS') and type = 'P') drop procedure dbo.xpActualizarOrdenEntarimadoWMS
GO             
CREATE PROCEDURE xpActualizarOrdenEntarimadoWMS
					@OrdenID    int,
					@ID         int,
					@Accion 	varchar(20),
					@Modulo		varchar(5),					
					@Posicion	varchar(10),
					@PosicionD  varchar(10)	

AS BEGIN
  -- SET nocount ON

  RETURN
END
GO
--REQ12615 WMS
/**************** spActualizarOrdenEntarimadoWMS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spActualizarOrdenEntarimadoWMS') and type = 'P') drop procedure dbo.spActualizarOrdenEntarimadoWMS
GO             
CREATE PROCEDURE spActualizarOrdenEntarimadoWMS
					@OrdenID    int,
					@ID         int,
					@Accion	    varchar(20),
					@Modulo		varchar(5),					
					@Posicion	varchar(10),
					@PosicionD  varchar(10)	
    
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
         @Mov varchar(20),
         @Clave varchar(20)
         
  IF @Modulo = 'COMS'
    SELECT @Posicion = PosicionWMS FROM Compra WHERE ID = @ID
  ELSE
  IF @Modulo = 'INV'
    SELECT @Posicion = PosicionWMS, @PosicionD = PosicionDWMS FROM Inv WHERE ID = @ID
  ELSE
  IF @Modulo = 'VTAS'
    SELECT @Posicion = PosicionWMS FROM Venta WHERE ID = @ID

  SELECT @Mov = Mov 
    FROM Inv 
   WHERE ID = @OrdenID
   
  SELECT @Clave = Clave 
    FROM MovTipo 
  WHERE Modulo = 'INV' AND Mov = @Mov
  
  IF @Clave = 'INV.SOL'
  BEGIN
    UPDATE Inv SET PosicionWMS = ISNULL(@PosicionD,@Posicion) WHERE ID = @OrdenID
  END
  
  IF @Clave <> 'INV.SOL'
    UPDATE Inv SET PosicionWMS = @Posicion WHERE ID = @OrdenID

  EXEC xpActualizarOrdenEntarimadoWMS @OrdenID, @ID, @Accion, @Modulo, @Posicion, @PosicionD

  RETURN
END
GO
/**************** xpGenerarOrdenEntarimado ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarOrdenEntarimado') and type = 'P') drop procedure dbo.xpGenerarOrdenEntarimado
GO             
CREATE PROCEDURE xpGenerarOrdenEntarimado
					@ID         int,
					@Almacen	varchar(10),
					@Modulo		varchar(5),
					@Posicion	varchar(10) OUTPUT,
					@PosicionD	varchar(10) OUTPUT

AS BEGIN
  -- SET nocount ON

  RETURN
END
GO

/**************** spGenerarOrdenEntarimado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarOrdenEntarimado') and type = 'P') drop procedure dbo.spGenerarOrdenEntarimado
GO
CREATE PROCEDURE spGenerarOrdenEntarimado
	@Modulo			varchar(5),
	@ID               		int,			
	@Accion			varchar(20),
	@Empresa          		varchar(5),
	@Sucursal			int,
	@Usuario			varchar(10),
	@Mov			varchar(20),
	@MovID			varchar(20),
	@MovTipo			varchar(20),
	@Almacen			varchar(10),

	@Ok               		int           	OUTPUT,
	@OkRef            		varchar(255)  	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @OrdenID	int,
    @OrdenMov	varchar(20),
    @OrdenMovID	varchar(20), --REQ12615 WMS
    @Posicion	varchar(10), --REQ12615 WMS
    @PosicionD	varchar(10),
    @AlmacenOrigen  varchar(10)

  SELECT @OrdenMov = InvOrdenEntarimado FROM EmpresaCfgMov WHERE Empresa = @Empresa
  IF @Accion = 'CANCELAR'
    SELECT @OrdenID = ID FROM Inv WHERE Mov = @OrdenMov AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
  ELSE BEGIN
    IF @Modulo = 'COMS'
      SELECT @Posicion = Posicion FROM Compra WHERE ID = @ID
    ELSE
    IF @Modulo = 'INV'
      SELECT @Posicion = PosicionWMS, @PosicionD = PosicionDWMS FROM Inv WHERE ID = @ID
    ELSE
    IF @Modulo = 'VTAS'
      SELECT @Posicion = PosicionWMS FROM Venta WHERE ID = @ID
    --ELSE
    --IF @Modulo = 'PROD'
    --  SELECT @Posicion = Posicion FROM Prod WHERE ID = @ID
    
    IF @Accion = 'RESERVARPARCIAL' SELECT @Accion = 'AFECTAR'
    IF @Modulo = 'VTAS'
    BEGIN
      INSERT Inv (
             Empresa,  Sucursal,  Mov,       Almacen,  FechaEmision, Concepto, Referencia, Proyecto, UEN, Usuario, Estatus,       Moneda, TipoCambio, OrigenTipo, Origen, OrigenID, CrossDocking, SucursalOrigen, SucursalDestino, PosicionWMS) --8. Desarrollo de proceso Cross Docking
      SELECT Empresa, Sucursal, @OrdenMov, @Almacen, FechaEmision, Concepto, Referencia, Proyecto, UEN, @Usuario, 'SINAFECTAR', Moneda, TipoCambio, 'INV/EP',    @Mov,   @MovID, CrossDocking, SucursalOrigen, SucursalDestino, PosicionWMS   --8. Desarrollo de proceso Cross Docking
        FROM Venta
       WHERE ID = @ID

      SELECT @OrdenID = SCOPE_IDENTITY()

	  --BUG7750
      INSERT InvD (
             ID,       Renglon, RenglonSub, RenglonID, Sucursal,  Almacen,  Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario, Costo)
      SELECT @OrdenID, Renglon, RenglonSub, VentaD.RenglonID, VentaD.Sucursal, @Almacen, VentaD.Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario, (ArtCosto.CostoPromedio*Factor)/Venta.TipoCambio --BUG24430 
	    FROM VentaD
		JOIN Venta ON Venta.ID = VentaD.ID
        --BUG24430
        LEFT OUTER JOIN ArtCosto ON VentaD.Articulo = ArtCosto.Articulo AND ArtCosto.Empresa = @Empresa AND ArtCosto.Sucursal = @Sucursal        
       WHERE Venta.ID = @ID-- AND Almacen = @Almacen AND NULLIF(RTRIM(Tarima), '') IS NULL--Cambio WMS
    END ELSE
    IF @Modulo = 'COMS'
    BEGIN
      INSERT Inv (
             Empresa,  Sucursal,  Mov,       Almacen,  FechaEmision, Concepto, Referencia, Proyecto, UEN, Usuario, Estatus,       Moneda, TipoCambio, OrigenTipo, Origen, OrigenID, CrossDocking, SucursalOrigen, SucursalDestino, PosicionWMS) --8. Desarrollo de proceso Cross Docking
      SELECT Empresa, Sucursal, @OrdenMov, @Almacen, FechaEmision, Concepto, Referencia, Proyecto, UEN, @Usuario, 'SINAFECTAR', Moneda, TipoCambio, @Modulo,    @Mov,   @MovID, CrossDocking, SucursalOrigen, SucursalDestino, PosicionWMS --8. Desarrollo de proceso Cross Docking
        FROM Compra
       WHERE ID = @ID

      SELECT @OrdenID = SCOPE_IDENTITY()

	  --BUG7750
      INSERT InvD (
             ID,       Renglon, RenglonSub, RenglonID, Sucursal,  Almacen,  Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario, Costo, CostoInv, FechaCaducidad)
	  --SELECT @OrdenID, Renglon, RenglonSub, RenglonID, @Sucursal, @Almacen, CompraD.Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario, ArtCosto.CostoPromedio*Factor, CostoInv, FechaCaducidad --BUG24430 
	  --SELECT @OrdenID, Renglon, RenglonSub, RenglonID, @Sucursal, @Almacen, CompraD.Articulo, SubCuenta, CantidadInventario, Unidad, Factor, CantidadInventario, ArtCosto.CostoPromedio*Factor, CostoInv, FechaCaducidad --BUG24430 --BUG2968
	  --SELECT @OrdenID, Renglon, RenglonSub, RenglonID, @Sucursal, @Almacen, CompraD.Articulo, SubCuenta, Cantidad*Factor, Unidad, Factor, CantidadInventario, ArtCosto.CostoPromedio*Factor, CostoInv, FechaCaducidad --BUG24430 --BUG2968 --BUG3186
	  SELECT @OrdenID, Renglon, RenglonSub, CompraD.RenglonID, CompraD.Sucursal, @Almacen, CompraD.Articulo, SubCuenta, CASE WHEN ISNULL(CantidadInventario,0) = 0 THEN Cantidad*Factor ELSE Cantidad END, Unidad, Factor, CantidadInventario, (ArtCosto.CostoPromedio*Factor)/Compra.TipoCambio, CostoInv, FechaCaducidad --BUG 4189	
        FROM CompraD
		JOIN Compra ON CompraD.ID = Compra.ID
        LEFT OUTER JOIN ArtCosto ON CompraD.Articulo = ArtCosto.Articulo AND ArtCosto.Empresa = @Empresa AND ArtCosto.Sucursal = @Sucursal
        --WHERE ID = @ID AND Almacen = @Almacen /*AND NULLIF(RTRIM(Tarima), '') IS NULL*/ --REQ12615 WMS
	    --BUG24430        
       WHERE CompraD.ID = @ID-- AND Almacen = @Almacen AND NULLIF(RTRIM(Tarima), '') IS NULL--Cambio WMS
    END ELSE
    IF @Modulo = 'INV'
    BEGIN
      INSERT Inv (
             Empresa,  Sucursal,  Mov,       Almacen,  FechaEmision, Concepto, Referencia, Proyecto, UEN, Usuario, Estatus,       Moneda, TipoCambio, OrigenTipo, Origen, OrigenID, CrossDocking, SucursalOrigen, SucursalDestino, PosicionWMS) --8. Desarrollo de proceso Cross Docking
      SELECT Empresa, Sucursal, @OrdenMov, @Almacen, FechaEmision, Concepto, Referencia, Proyecto, UEN, @Usuario, 'SINAFECTAR', Moneda, TipoCambio, @Modulo,    @Mov,   @MovID, CrossDocking, SucursalOrigen, SucursalDestino, PosicionWMS --8. Desarrollo de proceso Cross Docking
        FROM Inv
       WHERE ID = @ID
      SELECT @AlmacenOrigen = Almacen FROM Inv WHERE ID = @ID

      SELECT @OrdenID = SCOPE_IDENTITY()
	  --BUG7750
      INSERT InvD (
             ID,       Renglon, RenglonSub, RenglonID, Sucursal,  Almacen,  Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario, Costo, CostoInv, FechaCaducidad)
      --SELECT @OrdenID, Renglon, RenglonSub, RenglonID, @Sucursal, @Almacen, Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario, Costo, CostoInv, FechaCaducidad
	  --SELECT @OrdenID, Renglon, RenglonSub, RenglonID, @Sucursal, @Almacen, ArtCosto.Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario, ArtCosto.CostoPromedio*Factor, CostoInv, FechaCaducidad --BUG24430	  
	  --SELECT @OrdenID, Renglon, RenglonSub, RenglonID, @Sucursal, @Almacen, ArtCosto.Articulo, SubCuenta, Cantidad*Factor, Unidad, Factor, CantidadInventario, ArtCosto.CostoPromedio*Factor, CostoInv, FechaCaducidad --BUG24430 --BUG3699
	  SELECT @OrdenID, Renglon, RenglonSub, InvD.RenglonID, InvD.Sucursal, @Almacen, ArtCosto.Articulo, SubCuenta, CASE WHEN ISNULL(CantidadInventario,0) = 0 THEN Cantidad*Factor ELSE Cantidad END, Unidad, Factor, CantidadInventario, (ArtCosto.CostoPromedio*Factor)/Inv.TipoCambio, CostoInv, FechaCaducidad --BUG 4189
        FROM InvD
		JOIN Inv ON InvD.ID = Inv.ID 
        --WHERE ID = @ID AND Almacen IN(@Almacen,@AlmacenOrigen) /*AND NULLIF(RTRIM(Tarima), '') IS NULL*/ --REQ12615 WMS --Bug 19357
	    --BUG24430        
        LEFT OUTER JOIN ArtCosto ON InvD.Articulo = ArtCosto.Articulo AND ArtCosto.Empresa = @Empresa AND ArtCosto.Sucursal = @Sucursal                
       WHERE InvD.ID = @ID-- AND Almacen = @Almacen AND NULLIF(RTRIM(Tarima), '') IS NULL--Cambio WMS
         AND Cantidad > 0
    END ELSE
    IF @Modulo = 'PROD'
    BEGIN
      INSERT Inv (
             Empresa,  Sucursal,  Mov,       Almacen,  FechaEmision, Concepto, Referencia, Proyecto, UEN, Usuario, Estatus,       Moneda, TipoCambio, OrigenTipo, Origen, OrigenID, PosicionDWMS, CrossDocking, SucursalOrigen, SucursalDestino) --8. Desarrollo de proceso Cross Docking
      SELECT Empresa, Sucursal, @OrdenMov, @Almacen, FechaEmision, Concepto, Referencia, Proyecto, UEN, @Usuario, 'SINAFECTAR', Moneda, TipoCambio, @Modulo,    @Mov,   @MovID, PosicionDWMS, CrossDocking, SucursalOrigen, SucursalDestino    --8. Desarrollo de proceso Cross Docking
        FROM Prod
       WHERE ID = @ID

      SELECT @OrdenID = SCOPE_IDENTITY()
	  --BUG7750
      INSERT InvD (
             ID,       Renglon, RenglonSub, RenglonID, Sucursal,  Almacen,  Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario, Costo)
      --SELECT @OrdenID, Renglon, RenglonSub, RenglonID, @Sucursal, @Almacen, Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario, Costo
	  SELECT @OrdenID, Renglon, RenglonSub, ProdD.RenglonID, ProdD.Sucursal, @Almacen, ProdD.Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario, (ArtCosto.CostoPromedio*Factor)/Prod.TipoCambio --BUG24430   
	  --SELECT @OrdenID, Renglon, RenglonSub, RenglonID, @Sucursal, @Almacen, ProdD.Articulo, SubCuenta, CASE WHEN CantidadInventario = 0 THEN Cantidad*Factor ELSE Cantidad END, Unidad, Factor, CantidadInventario, ArtCosto.CostoPromedio*Factor --BUG 4189
        FROM ProdD
		JOIN Prod ON ProdD.ID = Prod.ID
        --WHERE ID = @ID AND Almacen = @Almacen /*AND NULLIF(RTRIM(Tarima), '') IS NULL*/ --REQ12615 WMS
		--BUG24430        
        LEFT OUTER JOIN ArtCosto ON ProdD.Articulo = ArtCosto.Articulo AND ArtCosto.Empresa = @Empresa AND ArtCosto.Sucursal = @Sucursal                        
       WHERE Prod.ID = @ID-- AND Almacen = @Almacen AND NULLIF(RTRIM(Tarima), '') IS NULL--Cambio WMS
    END 
    INSERT SerieLoteMov (
           Sucursal,  Empresa,   Modulo, ID,       RenglonID,   Articulo,   SubCuenta,   SerieLote,   Cantidad,   CantidadAlterna,   Propiedades,   Ubicacion,   Cliente,   Localizacion,   ArtCostoInv)
    SELECT m.Sucursal, m.Empresa, 'INV',  @OrdenID, m.RenglonID, m.Articulo, m.SubCuenta, m.SerieLote, m.Cantidad, m.CantidadAlterna, m.Propiedades, m.Ubicacion, m.Cliente, m.Localizacion, m.ArtCostoInv
      FROM SerieLoteMov m
      JOIN InvD d ON d.ID = @OrdenID AND d.RenglonID = m.RenglonID AND d.Articulo = m.Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(m.SubCuenta, '')
     WHERE m.Modulo = @Modulo AND m.ID = @ID
  END

  --REQ12615 WMS
  IF @Modulo = 'COMS'
    SELECT @Posicion = PosicionWMS FROM Compra WHERE ID = @ID
  ELSE
  IF @Modulo = 'INV'
    SELECT @Posicion = PosicionWMS, @PosicionD = PosicionDWMS FROM Inv WHERE ID = @ID
  ELSE
  IF @Modulo = 'VTAS'
    SELECT @Posicion = PosicionWMS FROM Venta WHERE ID = @ID

  UPDATE Inv SET PosicionWMS = @Posicion WHERE ID = @OrdenID

  EXEC spActualizarOrdenEntarimadoWMS @OrdenID, @ID, @Accion, @Modulo, @Posicion, @PosicionD
  --REQ12615 WMS

  IF @OrdenID IS NOT NULL
  BEGIN
    EXEC spAfectar 'INV', @OrdenID, @Accion, 'TODO', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    
    SELECT @OrdenMov = Mov, @OrdenMovID = MovID FROM Inv WHERE ID = @OrdenID --REQ12615 WMS
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @OrdenID, @OrdenMov, @OrdenMovID, @Ok OUTPUT
  END

  RETURN
END
GO

/**************** spSugerirEntarimado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirEntarimado') and type = 'P') drop procedure dbo.spSugerirEntarimado
GO
CREATE PROCEDURE spSugerirEntarimado
			@Modulo			varchar(5),
    		@ModuloID       int,
    		@Empresa        varchar(5),
			@Sucursal		int,
			@Usuario		varchar(10),

    		@Ok             int           	OUTPUT,
    		@OkRef          varchar(255)  	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Estacion				int,
    @ID						int,
    @Mov					varchar(20),
    @MovID					varchar(20),
    @Articulo				varchar(20),
    @Salir					bit,
    @Antes					float,
    @Despues				float,
    @Cantidad				float,
    @CantidadA				float,
    @CantidadTarima			float,
    @Tarima					varchar(20),
    @Unidad					varchar(50),
    @UnidadTarima			varchar(50),
    @NivelFactorMultiUnidad varchar(20) --REQ12615 WMS
    
  BEGIN TRANSACTION
  
  SELECT @NivelFactorMultiUnidad = NivelFactorMultiUnidad FROM EmpresaCfg2 WHERE Empresa = @Empresa --REQ12615 WMS
  SELECT @Estacion = -@@SPID 
  SELECT @Mov = Mov, @MovID = MovID FROM Inv WHERE ID = @ModuloID
  EXEC spEntarimar @Estacion, @Empresa, @Modulo, @ModuloID, @Mov, @MovID, 'SUGERIR', @Conexion = 1
  
  SELECT @Salir = 0
  WHILE @Salir = 0 AND @Ok IS NULL
  BEGIN
    SELECT @ID = NULL, @Cantidad = 0.0, @CantidadTarima = 0.0, @CantidadA = 0.0, @Antes = 0.0, @Despues = 0.0
    SELECT @Antes = SUM(Cantidad) FROM EntarimarMov WHERE Estacion = @Estacion
    SELECT @ID = MIN(ID) FROM EntarimarMov WHERE Estacion = @Estacion AND NULLIF(Cantidad, 0.0) IS NOT NULL
    IF @ID IS NOT NULL
    BEGIN
      --REQ12615 WMS
      SELECT @Articulo = Articulo,
             @Unidad = Unidad 
        FROM EntarimarMov 
       WHERE Estacion = @Estacion AND ID = @ID

      IF EXISTS(SELECT * FROM ArtUnidad WHERE Articulo = @Articulo AND Unidad = @Unidad)
        SELECT @Articulo = em.Articulo,
               @Cantidad = ISNULL(em.Cantidad, 0.0), 
               @Unidad = NULLIF(RTRIM(em.Unidad), ''),
               @CantidadTarima = ISNULL(u.factor, 1), --BUG 14145
               @UnidadTarima = NULLIF(RTRIM(u.Unidad), '')
          FROM EntarimarMov em
          JOIN Art a ON a.Articulo = em.Articulo
          JOIN ArtUnidad u ON u.Articulo = a.Articulo AND em.Unidad = u.Unidad
         WHERE em.Estacion = @Estacion AND em.ID = @ID
	  ELSE
      --REQ12615 WMS
      SELECT @Articulo = em.Articulo,
             @Cantidad = ISNULL(em.Cantidad, 0.0), @Unidad = NULLIF(RTRIM(em.Unidad), ''),
             @CantidadTarima = ISNULL(a.CantidadTarima, 1), --BUG 14145
			 @UnidadTarima = NULLIF(RTRIM(a.UnidadTarima), '')
        FROM EntarimarMov em
        JOIN Art a ON a.Articulo = em.Articulo
       WHERE em.Estacion = @Estacion AND em.ID = @ID

       --REQ12615 WMS
      IF @NivelFactorMultiUnidad = 'Articulo'
       SELECT @Cantidad = ISNULL(NULLIF(Factor,0),1) * @Cantidad FROM ArtUnidad WHERE Articulo = @Articulo AND Unidad = @Unidad --BUG 14380
      IF @NivelFactorMultiUnidad = 'Unidad'
       SELECT @Cantidad = ISNULL(Factor,1) * @Cantidad FROM Unidad WHERE Unidad = @Unidad

      IF @NivelFactorMultiUnidad = 'Articulo'
       --SELECT @CantidadTarima = ISNULL(NULLIF(Factor,0),1) * CantidadUnidadTarima FROM ArtUnidad WHERE Articulo = @Articulo AND Unidad = @unidad --BUG 14380
	   SELECT @CantidadTarima = ISNULL(NULLIF(Factor,0),1) * CantidadCamaTarima FROM ArtUnidad WHERE Articulo = @Articulo AND Unidad = @unidad --BUG 14380 --BUG3113
      IF @NivelFactorMultiUnidad = 'Unidad'
       --SELECT @CantidadTarima = ISNULL(u.Factor,1) * a.CantidadUnidadTarima FROM Unidad u JOIN ArtUnidad a on  u.Unidad = a.Unidad WHERE  a.Articulo = @Articulo AND u.Unidad = @unidad
	   SELECT @CantidadTarima = ISNULL(u.Factor,1) * a.CantidadCamaTarima FROM Unidad u JOIN ArtUnidad a on  u.Unidad = a.Unidad WHERE  a.Articulo = @Articulo AND u.Unidad = @unidad --BUG3113

      IF @Cantidad > 0
        SELECT @Unidad = @UnidadTarima
       --REQ12615 WMS

      IF @Cantidad > @CantidadTarima SELECT @CantidadA = @CantidadTarima ELSE SELECT @CantidadA = @Cantidad
      IF ISNULL(@Unidad, '') <> ISNULL(ISNULL(@UnidadTarima, @Unidad), '') SELECT @Salir = 1, @Ok = 20130, @OkRef = @Articulo
      IF ISNULL(@CantidadA, 0.0) > 0.0 AND @Salir = 0 AND @Ok IS NULL
      BEGIN
      	EXEC spConsecutivo 'Tarima', @Sucursal, @Tarima OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        UPDATE EntarimarMov
           SET CantidadA = @CantidadA
         WHERE Estacion = @Estacion AND ID = @ID
        EXEC spEntarimar @Estacion, @Empresa, @Modulo, @ModuloID, @Mov, @MovID, 'ENTARIMAR', @Tarima, @Conexion = 1
      END
    END
    IF @Salir = 0 AND @Ok IS NULL
    BEGIN
      --SELECT @Despues = SUM(Cantidad) FROM EntarimarMov WHERE Estacion = @Estacion
	  SELECT @Despues = SUM(CantidadA) FROM EntarimarMov WHERE Estacion = @Estacion --BUG3573
      IF ISNULL(@Antes, 0.0) = ISNULL(@Despues, 0.0) SELECT @Salir = 1
    END
  END
  IF @Ok IS NULL
    EXEC spEntarimar @Estacion, @Empresa, @Modulo, @ModuloID, @Mov, @MovID, 'ACEPTAR', @Conexion = 1
    
  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION
  RETURN
END
GO

/**************** fnTarimaEstaVacia ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTarimaEstaVacia') DROP FUNCTION fnTarimaEstaVacia
GO
CREATE FUNCTION fnTarimaEstaVacia (@Empresa varchar(5), @Tarima varchar(20))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit

  SELECT @Resultado = 1
  IF EXISTS(SELECT * FROM ArtExistenciaTarima WHERE Empresa = @Empresa AND Tarima = @Tarima AND NULLIF(Existencia, 0.0) IS NOT NULL)
    SELECT @Resultado = 0

  RETURN(@Resultado)
END
GO

/**************** fnArticuloEnTarima ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnArticuloEnTarima') DROP FUNCTION fnArticuloEnTarima
GO
CREATE FUNCTION fnArticuloEnTarima (@Empresa varchar(5), @Tarima varchar(20))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(20)

  SELECT @Resultado = NULL
  SELECT @Resultado = NULLIF(RTRIM(MIN(Articulo)), '')
    FROM ArtExistenciaTarima
   WHERE Empresa = @Empresa AND Tarima = @Tarima AND ROUND(ISNULL(Existencia, 0.0), 2) <> 0.0

  RETURN(@Resultado)
END
GO

/**************** fnExistenciaDeTarima ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnExistenciaDeTarima') DROP FUNCTION fnExistenciaDeTarima
GO
CREATE FUNCTION fnExistenciaDeTarima (@Empresa varchar(5), @Almacen varchar(10), @Tarima varchar(20), @Articulo varchar(20))
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	float

  SELECT @Resultado = NULL
  SELECT @Resultado = SUM(Existencia)
    FROM ArtExistenciaTarima
   WHERE Empresa = @Empresa AND Almacen = @Almacen AND Tarima = @Tarima AND Articulo = @Articulo

  RETURN(@Resultado)
END
GO

/**************** fnTarimaEnPuntoReorden ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTarimaEnPuntoReorden') DROP FUNCTION fnTarimaEnPuntoReorden
GO
CREATE FUNCTION fnTarimaEnPuntoReorden (@Empresa varchar(5), @Almacen varchar(10), @Tarima varchar(20), @Articulo varchar(20))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado		bit,
    @MinimoTarima	float,
    @Existencia		float,
    @Posicion		varchar(10),
    @PosicionTipo	varchar(20)

  SELECT @Resultado = 0

  SELECT @Posicion = t.Posicion,
         @PosicionTipo = ap.Tipo
    FROM Tarima t
    JOIN AlmPos ap ON ap.Almacen = @Almacen AND ap.Posicion = t.Posicion
   WHERE t.Tarima = @Tarima

  IF UPPER(@PosicionTipo) = 'DOMICILIO'
  BEGIN
    SELECT @MinimoTarima = NULL
    SELECT @MinimoTarima = NULLIF(MinimoTarima, 0.0) FROM ArtAlm WHERE Articulo = @Articulo AND Almacen = @Almacen
    IF @MinimoTarima IS NULL
      SELECT @MinimoTarima = MinimoTarima FROM Art WHERE Articulo = @Articulo
    SELECT @Existencia = dbo.fnExistenciaDeTarima(@Empresa, @Almacen, @Tarima, @Articulo)

    IF ISNULL(@Existencia, 0.0) = 0.0 OR (ISNULL(@Existencia, 0.0) < ISNULL(@MinimoTarima, 0.0)) SELECT @Resultado = 1
  END

  RETURN(@Resultado)
END
GO

--BUG24695
-- select dbo.fnAlmPosTieneCapacidad('DEMO', 'ALM5', 'UBIC1')
/**************** fnAlmPosTieneCapacidad ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAlmPosTieneCapacidad') DROP FUNCTION fnAlmPosTieneCapacidad
GO
--BUG24067
CREATE FUNCTION fnAlmPosTieneCapacidad (@Empresa varchar(5), @Almacen varchar(10), @Posicion varchar(20), @Tarima varchar(20))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Capacidad	int,
    @Tarimas	int,
    @Pendientes	int,
    @Resultado	bit,
    @Tipo	varchar(20)

  SELECT @Resultado = 0, @Capacidad = 0, @Tarimas = 0, @Pendientes = 0
  SELECT @Capacidad = Capacidad,
         @Tipo = Tipo
    FROM AlmPos 
   WHERE Almacen = @Almacen AND Posicion = @Posicion

  IF @Tipo = 'DOMICILIO'
    SELECT @Tarimas = ISNULL(COUNT(*), 0) 
      FROM Tarima 
     WHERE Almacen = @Almacen AND Posicion = @Posicion AND Estatus = 'ALTA' AND dbo.fnTarimaEnPuntoReorden(@Empresa, @Almacen, Tarima, dbo.fnArticuloEnTarima(@Empresa, Tarima)) = 0
  ELSE
    SELECT @Tarimas = ISNULL(COUNT(*), 0) 
      FROM Tarima 
     WHERE Almacen = @Almacen AND Posicion = @Posicion AND Estatus = 'ALTA'
     --BUG24067 
       AND Tarima <> ISNULL(@Tarima, '')
     
  SELECT @Pendientes = ISNULL(COUNT(*), 0)
    FROM TMAD d
    JOIN TMA e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE'
    JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = e.Mov AND mt.Clave IN ('TMA.SADO', 'TMA.OADO')
   WHERE d.EstaPendiente = 1 AND d.PosicionDestino = @Posicion

  IF @Capacidad > @Tarimas + @Pendientes SELECT @Resultado = 1
  RETURN(@Resultado)
END
GO



--REQ12615 WMS
/**************** fnAlmPosTieneCapacidadWMS ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAlmPosTieneCapacidadWMS') DROP FUNCTION fnAlmPosTieneCapacidadWMS
GO
CREATE FUNCTION fnAlmPosTieneCapacidadWMS (@Empresa varchar(5), @Almacen varchar(10), @Posicion varchar(20), @Articulo varchar(20), @TMAID int, @Verificar bit)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tarimas	int,
    @Pendientes	int,
    @Resultado	bit,
    @Tipo	varchar(20),
	@PesoTarima				float,
	@VolumenTarima			float,
	@Hoy					datetime,
	
	@PesoMaximo				float,
	@Volumen				float,
	@Capacidad				int,
	@Alta					datetime,
	@WMSRotacionArticulo	bit,
	@RotacionArt			varchar(10),
	@RotacionAlmPos			varchar(10),
	@ZonaPos				varchar(50),
	@ArtPos					varchar(20),
	@CantidadTarima			int,
    --REQ 14412
	@PermiteEstibar			bit,
	@EstibaMaxima			int,
	@EstibaMismaFecha		bit
  
  SELECT @ZonaPos = ISNULL(Zona,''),
         @ArtPos = ISNULL(ArticuloEsp,'')
	FROM AlmPos
   WHERE Almacen = @Almacen
     AND Posicion = @Posicion

  SELECT @WMSRotacionArticulo = ISNULL(WMSRotacionArticulo, 0) FROM EmpresaCfg WHERE Empresa = @Empresa

  SELECT @Resultado		= 0,
		 @Capacidad		= 0,
		 @Tarimas		= 0,
		 @Pendientes	= 0,
		 @PesoTarima	= 0,
		 @VolumenTarima	= 0,
		 @Hoy			= NULL,
		 @PesoMaximo	= 0,
		 @Volumen		= 0,
		 @Alta			= NULL,
		 @RotacionArt	= '',
		 @RotacionAlmPos = '',
		 @Hoy			= dbo.fnFechaSinHora(GETDATE())

  SELECT @PesoTarima		= PesoTarima,
         @VolumenTarima		= VolumenTarima,
         --REQ 14412
         @PermiteEstibar	= ISNULL(PermiteEstibar,0),
         @EstibaMismaFecha	= ISNULL(EstibaMismaFecha,0),
         @EstibaMaxima		= ISNULL(EstibaMaxima,1)
    FROM Art 
   WHERE Articulo = @Articulo

  IF @WMSRotacionArticulo = 1 AND @ZonaPos <> '' OR @WMSRotacionArticulo = 1 AND @ArtPos <> ''
  BEGIN
    SELECT @RotacionArt = ISNULL(TipoRotacion, '') FROM Art WHERE Articulo = @Articulo
    SELECT @RotacionAlmPos = ISNULL(TipoRotacion, '') FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen
  END

  IF EXISTS (SELECT * FROM ArtUnidad WHERE Articulo = @Articulo)
    SELECT TOP 1 @PesoTarima = Peso, @VolumenTarima = Volumen
      FROM ArtUnidad 
     WHERE Articulo = @Articulo AND	Factor = 1
  
  SELECT @PesoMaximo = a.PesoMaximo, @Volumen = a.Volumen, @Capacidad = a.Capacidad, @Alta = ISNULL(dbo.fnFechaSinHora(t.Alta), @Hoy), @Tipo = a.Tipo
    FROM AlmPos a 
    LEFT OUTER JOIN Tarima t 
      ON a.Posicion = t.Posicion 
   WHERE a.Posicion = @Posicion
     --BUG7691
     AND a.Almacen = @Almacen

  --REQ 14412
  IF @PermiteEstibar = 1 AND @EstibaMaxima > 1 --AND @Capacidad > @EstibaMaxima --BUG 19241
  BEGIN
    SELECT @PesoMaximo = @PesoMaximo * @EstibaMaxima
    SELECT @Volumen = @Volumen * @EstibaMaxima    
  END
  
  IF @Tipo = 'DOMICILIO'
  BEGIN
    SELECT @Tarimas = ISNULL(COUNT(*), 0) 
      FROM Tarima t
      JOIN ArtDisponibleTarima a ON t.Tarima = a.Tarima
     WHERE t.Almacen = @Almacen AND t.Posicion = @Posicion AND t.Estatus = 'ALTA' AND t.Tarima NOT LIKE '%-%' AND a.Disponible > 0

     --BUG6398
     --BUG3633
     SELECT @Pendientes = ISNULL(COUNT(*), 0)
      FROM TMAD d
      JOIN TMA e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus IN('PENDIENTE')
      JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = e.Mov AND mt.Clave IN ('TMA.SADO', 'TMA.SRADO')
     WHERE d.EstaPendiente = 1
       AND d.PosicionDestino = @Posicion
       AND e.Mov <> (SELECT ISNULL(Origen,'') FROM TMA WHERE ID = @TMAID)
       AND e.MovID <> (SELECT ISNULL(OrigenID,'') FROM TMA WHERE ID = @TMAID)
     --SELECT @Pendientes=0
     SELECT @Pendientes = @Pendientes + ISNULL(COUNT(*), 0)
      FROM TMAD d
      JOIN TMA e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus IN('PENDIENTE')
      JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = e.Mov AND mt.Clave IN ('TMA.OADO', 'TMA.ORADO')
     WHERE d.EstaPendiente = 1
       AND d.PosicionDestino = @Posicion
       AND e.Mov <> (SELECT ISNULL(Origen,'') FROM TMA WHERE ID = @TMAID)
       AND e.MovID <> (SELECT ISNULL(OrigenID,'') FROM TMA WHERE ID = @TMAID)

     IF @Verificar = 0
      SELECT @Pendientes = @Pendientes + COUNT(*) FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion AND CapacidadPosicion = 1
	  --BUG3628
      --SELECT @Pendientes = @Pendientes + (SELECT CASE WHEN COUNT(*)=1 THEN 0 ELSE COUNT(*) END FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion AND CapacidadPosicion = 1)	  
    ELSE      
      SELECT @Pendientes = @Pendientes + COUNT(*) FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion
	  --BUG3628
      --SELECT @Pendientes = @Pendientes + (SELECT CASE WHEN COUNT(*)=1 THEN 0 ELSE COUNT(*) END FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion)

    IF @Verificar = 0
      IF 1 > @Tarimas + @Pendientes SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
    ELSE
      IF 1 = @Tarimas + @Pendientes SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
    
    IF (SELECT m.Clave FROM MovTipo m JOIN TMA t ON m.Mov = t.Mov AND m.Modulo = 'TMA' WHERE t.id = @TMAID) IN ('TMA.SRADO', 'TMA.ORADO', 'TMA.RADO')
      SELECT @Resultado = 1

    RETURN(@Resultado)
  END   
  ELSE
  BEGIN
    --SELECT 'Ubica'
    SELECT @CantidadTarima = ISNULL(Capacidad,0) FROM AlmPos WHERE Almacen = @Almacen AND Posicion = @Posicion
    SELECT @Tarimas = ISNULL(COUNT(*), 0) FROM Tarima WHERE Almacen = @Almacen AND Posicion = @Posicion AND Estatus = 'ALTA'
    
    --BUG6398
	--BUG3633
    SELECT @Pendientes = ISNULL(COUNT(*), 0)
      FROM TMAD d
      JOIN TMA e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus IN('PENDIENTE')
      JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = e.Mov AND mt.Clave IN ('TMA.SADO', 'TMA.SRADO')
     WHERE d.EstaPendiente = 1
       AND d.PosicionDestino = @Posicion
       AND e.Mov <> (SELECT ISNULL(Origen,'') FROM TMA WHERE ID = @TMAID)
       AND e.MovID <> (SELECT ISNULL(OrigenID,'') FROM TMA WHERE ID = @TMAID)
    --SELECT @Pendientes=0
    SELECT @Pendientes = @Pendientes + ISNULL(COUNT(*), 0)
      FROM TMAD d
      JOIN TMA e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus IN('PENDIENTE')
      JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = e.Mov AND mt.Clave IN ('TMA.OADO', 'TMA.ORADO')
     WHERE d.EstaPendiente = 1
       AND d.PosicionDestino = @Posicion
       AND e.Mov <> (SELECT ISNULL(Origen,'') FROM TMA WHERE ID = @TMAID)
       AND e.MovID <> (SELECT ISNULL(OrigenID,'') FROM TMA WHERE ID = @TMAID)

     IF @Verificar = 0
      SELECT @Pendientes = @Pendientes + COUNT(*) FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion AND CapacidadPosicion = 1
      --BUG3628
      --SELECT @Pendientes = @Pendientes + (SELECT CASE WHEN COUNT(*)=1 THEN 0 ELSE COUNT(*) END FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion AND CapacidadPosicion = 1)	  
     ELSE
      SELECT @Pendientes = @Pendientes + COUNT(*) FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion
      --BUG3628
      --SELECT @Pendientes = @Pendientes + (SELECT CASE WHEN COUNT(*)=1 THEN 0 ELSE COUNT(*) END FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion)


    SELECT @PesoTarima		= @PesoTarima *		CASE WHEN (@Tarimas + @Pendientes + 0) = 0 THEN .999 ELSE (@Tarimas + @Pendientes + CASE WHEN @Verificar = 0 THEN 1 ELSE 0 END) END,
	       @VolumenTarima	= @VolumenTarima *	CASE WHEN (@Tarimas + @Pendientes + 0) = 0 THEN .999 ELSE (@Tarimas + @Pendientes + CASE WHEN @Verificar = 0 THEN 1 ELSE 0 END) END
	
    --REQ 14412
    IF @PermiteEstibar = 1
    BEGIN
      --IF @EstibaMismaFecha = 1 --Bug 3805 y 3806
      --BEGIN            
      --  IF @Hoy = @Alta
      --    IF @RotacionArt = @RotacionAlmPos  AND @PesoTarima <= @PesoMaximo AND @VolumenTarima <= @Volumen SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
      --  ELSE SELECT @Resultado = 0
      --END

      IF @Verificar = 0
	    IF @RotacionArt = @RotacionAlmPos  AND @PesoTarima  < @PesoMaximo AND @VolumenTarima < @Volumen SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
      ELSE
	    IF @RotacionArt = @RotacionAlmPos  AND @PesoTarima  <= @PesoMaximo AND @VolumenTarima <= @Volumen AND @Pendientes <> 0 SELECT @Resultado = 1 ELSE SELECT @Resultado = 0	    	       
	END
	       
    IF @Verificar = 0
	  IF @RotacionArt = @RotacionAlmPos  AND @PesoTarima  <= @PesoMaximo AND @VolumenTarima <= @Volumen SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
    ELSE
	  IF @RotacionArt = @RotacionAlmPos  AND @PesoTarima  <= @PesoMaximo AND @VolumenTarima <= @Volumen AND @Pendientes <> 0 SELECT @Resultado = 1 ELSE SELECT @Resultado = 0

    --REQ 14412
    IF @EstibaMismaFecha = 1
    BEGIN
      IF @Verificar = 0
	    IF @RotacionArt = @RotacionAlmPos  AND @Hoy = @Alta AND @PesoTarima  <= @PesoMaximo AND @VolumenTarima <= @Volumen SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
      ELSE
	    IF @RotacionArt = @RotacionAlmPos  AND @Hoy = @Alta AND @PesoTarima  <= @PesoMaximo AND @VolumenTarima <= @Volumen AND @Pendientes <> 0 SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
    END
    --BUG 19241
    IF @Verificar = 0
      IF (@CantidadTarima * CASE WHEN @PermiteEstibar = 1 AND @EstibaMaxima > 0 THEN @EstibaMaxima ELSE 1 END) > @Pendientes + @Tarimas AND @Resultado = 1
        SELECT @Resultado = 1
      ELSE
        SELECT @Resultado = 0
    ELSE
      IF (@CantidadTarima * CASE WHEN @PermiteEstibar = 1 AND @EstibaMaxima > 0 THEN @EstibaMaxima ELSE 1 END) >= @Pendientes + @Tarimas AND @Resultado = 1
        SELECT @Resultado = 1
      ELSE
        SELECT @Resultado = 0
  END

  RETURN(@Resultado)
END
GO

--BUG3628
/**************** spAlmPosTieneCapacidadWMS ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'spAlmPosTieneCapacidadWMS') DROP PROC spAlmPosTieneCapacidadWMS
GO
CREATE PROC spAlmPosTieneCapacidadWMS 
@Empresa varchar(5), @Almacen varchar(10), @Posicion varchar(20), 
            @Articulo varchar(20),  @Tarima varchar(20), @Renglon int, @TMAID int, @Verificar bit,
            @Ok int OUTPUT,	@OkRef varchar(255) OUTPUT
--RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tarimas	int,
    @Pendientes	int,
    @Resultado	bit,
    @Tipo	varchar(20),
	@PesoTarima				float,
	@VolumenTarima			float,
	@Hoy					datetime,
	
	@PesoMaximo				float,
	@Volumen				float,
	@Capacidad				int,
	@Alta					datetime,
	@WMSRotacionArticulo	bit,
	@RotacionArt			varchar(10),
	@RotacionAlmPos			varchar(10),
	@ZonaPos				varchar(50),
	@ArtPos					varchar(20),
	@CantidadTarima			int,
    --REQ 14412
	@PermiteEstibar			bit,
	@EstibaMaxima			int,
	@EstibaMismaFecha		bit
  
  SELECT @ZonaPos = ISNULL(Zona,''),
         @ArtPos = ISNULL(ArticuloEsp,'')
	FROM AlmPos
   WHERE Almacen = @Almacen
     AND Posicion = @Posicion

  SELECT @WMSRotacionArticulo = ISNULL(WMSRotacionArticulo, 0) FROM EmpresaCfg WHERE Empresa = @Empresa

  SELECT @Resultado		= 0,
		 @Capacidad		= 0,
		 @Tarimas		= 0,
		 @Pendientes	= 0,
		 @PesoTarima	= 0,
		 @VolumenTarima	= 0,
		 @Hoy			= NULL,
		 @PesoMaximo	= 0,
		 @Volumen		= 0,
		 @Alta			= NULL,
		 @RotacionArt	= '',
		 @RotacionAlmPos = '',
		 @Hoy			= dbo.fnFechaSinHora(GETDATE())

  SELECT @PesoTarima		= PesoTarima,
         @VolumenTarima		= VolumenTarima,
         --REQ 14412
         @PermiteEstibar	= ISNULL(PermiteEstibar,0),
         @EstibaMismaFecha	= ISNULL(EstibaMismaFecha,0),
         @EstibaMaxima		= ISNULL(EstibaMaxima,1)
    FROM Art 
   WHERE Articulo = @Articulo

  IF @WMSRotacionArticulo = 1 AND @ZonaPos <> '' OR @WMSRotacionArticulo = 1 AND @ArtPos <> ''
  BEGIN
    SELECT @RotacionArt = ISNULL(TipoRotacion, '') FROM Art WHERE Articulo = @Articulo
    SELECT @RotacionAlmPos = ISNULL(TipoRotacion, '') FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen
  END

--SELECT * FROM ArtUnidad    WHERE Articulo = @Articulo AND	Factor = 1

  IF EXISTS (SELECT * FROM ArtUnidad WHERE Articulo = @Articulo)
    SELECT TOP 1 @PesoTarima = Peso, @VolumenTarima = Volumen
      FROM ArtUnidad 
     WHERE Articulo = @Articulo AND	Factor = 1
  
  SELECT @PesoMaximo = a.PesoMaximo, @Volumen = a.Volumen, @Capacidad = a.Capacidad, @Alta = ISNULL(dbo.fnFechaSinHora(t.Alta), @Hoy), @Tipo = a.Tipo
    FROM AlmPos a 
    LEFT OUTER JOIN Tarima t 
      ON a.Posicion = t.Posicion AND a.Almacen = @Almacen
   WHERE a.Posicion = @Posicion

  --REQ 14412
  IF @PermiteEstibar = 1 AND @EstibaMaxima > 1 --AND @Capacidad > @EstibaMaxima --BUG 19241
  BEGIN
    SELECT @PesoMaximo = @PesoMaximo * @EstibaMaxima
    SELECT @Volumen = @Volumen * @EstibaMaxima    
  END
  
  IF @Tipo = 'DOMICILIO'
  BEGIN
    
    SELECT @Tarimas = ISNULL(COUNT(*), 0) 
      FROM Tarima t
      JOIN ArtDisponibleTarima a ON t.Tarima = a.Tarima
     WHERE t.Almacen = @Almacen AND t.Posicion = @Posicion AND t.Estatus = 'ALTA' AND t.Tarima NOT LIKE '%-%' AND a.Disponible > 0
      
	 --BUG3633
     --SELECT @Pendientes = ISNULL(COUNT(*), 0)
     -- FROM TMAD d
     -- JOIN TMA e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus IN('PENDIENTE')
     -- JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = e.Mov AND mt.Clave IN ('TMA.SADO', 'TMA.SRADO')
     --WHERE d.EstaPendiente = 1
     --  AND d.PosicionDestino = @Posicion
     --  AND e.Mov <> (SELECT ISNULL(Origen,'') FROM TMA WHERE ID = @TMAID)
     --  AND e.MovID <> (SELECT ISNULL(OrigenID,'') FROM TMA WHERE ID = @TMAID)
     SELECT @Pendientes=0
     SELECT @Pendientes = @Pendientes + ISNULL(COUNT(*), 0)
      FROM TMAD d
      JOIN TMA e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus IN('PENDIENTE')
      JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = e.Mov AND mt.Clave IN ('TMA.OADO', 'TMA.ORADO')
     WHERE d.EstaPendiente = 1
       AND d.PosicionDestino = @Posicion
       AND e.Mov <> (SELECT ISNULL(Origen,'') FROM TMA WHERE ID = @TMAID)
       AND e.MovID <> (SELECT ISNULL(OrigenID,'') FROM TMA WHERE ID = @TMAID)

    IF @Verificar = 0
      SELECT @Pendientes = @Pendientes + COUNT(*) FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion AND CapacidadPosicion = 1
      --BUG3628
      --SELECT @Pendientes = @Pendientes + (SELECT CASE WHEN COUNT(*)=1 THEN 0 ELSE COUNT(*) END FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion AND CapacidadPosicion = 1)	  
    ELSE
      SELECT @Pendientes = @Pendientes + COUNT(*) FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion
      --BUG3628
      --SELECT @Pendientes = @Pendientes + (SELECT CASE WHEN COUNT(*)=1 THEN 0 ELSE COUNT(*) END FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion)


    IF @Verificar = 0
      IF 1 > @Tarimas + @Pendientes SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
    ELSE
      IF 1 = @Tarimas + @Pendientes SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
    
    IF (SELECT m.Clave FROM MovTipo m JOIN TMA t ON m.Mov = t.Mov AND m.Modulo = 'TMA' WHERE t.id = @TMAID) IN ('TMA.SRADO', 'TMA.ORADO', 'TMA.RADO')
      SELECT @Resultado = 1

    RETURN(@Resultado)
  END   
  ELSE
  BEGIN
    --8. Desarrollo de proceso Cross Docking
	IF RTRIM(LTRIM(@Tipo)) = 'Cross Docking'
		RETURN

    SELECT @CantidadTarima = ISNULL(Capacidad,0) FROM AlmPos WHERE Almacen = @Almacen AND Posicion = @Posicion
    SELECT @Tarimas = ISNULL(COUNT(*), 0) FROM Tarima WHERE Almacen = @Almacen AND Posicion = @Posicion AND Estatus = 'ALTA'

	--BUG3633
    --SELECT @Pendientes = ISNULL(COUNT(*), 0)
    --  FROM TMAD d
    --  JOIN TMA e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus IN('PENDIENTE')
    --  JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = e.Mov AND mt.Clave IN ('TMA.SADO', 'TMA.SRADO')
    -- WHERE d.EstaPendiente = 1
    --   AND d.PosicionDestino = @Posicion
    --   AND e.Mov <> (SELECT ISNULL(Origen,'') FROM TMA WHERE ID = @TMAID)
    --   AND e.MovID <> (SELECT ISNULL(OrigenID,'') FROM TMA WHERE ID = @TMAID)
    SELECT @Pendientes=0
    SELECT @Pendientes = @Pendientes + ISNULL(COUNT(*), 0)
      FROM TMAD d
      JOIN TMA e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus IN('PENDIENTE')
      JOIN MovTipo mt ON mt.Modulo = 'TMA' AND mt.Mov = e.Mov AND mt.Clave IN ('TMA.OADO', 'TMA.ORADO')
     WHERE d.EstaPendiente = 1
       AND d.PosicionDestino = @Posicion
       AND e.Mov <> (SELECT ISNULL(Origen,'') FROM TMA WHERE ID = @TMAID)
       AND e.MovID <> (SELECT ISNULL(OrigenID,'') FROM TMA WHERE ID = @TMAID)

    IF @Verificar = 0
      SELECT @Pendientes = @Pendientes + COUNT(*) FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion AND CapacidadPosicion = 1
	  --BUG3628
      --SELECT @Pendientes = @Pendientes + (SELECT CASE WHEN COUNT(*)=1 THEN 0 ELSE COUNT(*) END FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion AND CapacidadPosicion = 1)	  
    ELSE
      SELECT @Pendientes = @Pendientes + COUNT(*) FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion
	  --BUG3628
      --SELECT @Pendientes = @Pendientes + (SELECT CASE WHEN COUNT(*)=1 THEN 0 ELSE COUNT(*) END FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion)

--select @Pendientes 
--
--SELECT * FROM TMAD WHERE ID = @TMAID AND PosicionDestino = @Posicion
--SELECT 'Ubica', @Posicion, @CantidadTarima, @Tarimas, @Pendientes, 	@PesoTarima, @PesoMaximo, @VolumenTarima, @Volumen, @Tarimas + @Pendientes         
         
    SELECT @PesoTarima		= @PesoTarima *		CASE WHEN (@Tarimas + @Pendientes + 0) = 0 THEN .999 ELSE (@Tarimas + @Pendientes + CASE WHEN @Verificar = 0 THEN 1 ELSE 0 END) END,
	       @VolumenTarima	= @VolumenTarima *	CASE WHEN (@Tarimas + @Pendientes + 0) = 0 THEN .999 ELSE (@Tarimas + @Pendientes + CASE WHEN @Verificar = 0 THEN 1 ELSE 0 END) END

    --REQ 14412
    IF @PermiteEstibar = 1
    BEGIN
      IF @EstibaMismaFecha = 1
      BEGIN            
        IF @Hoy = @Alta
          IF @RotacionArt = @RotacionAlmPos  AND @PesoTarima <= @PesoMaximo AND @VolumenTarima <= @Volumen SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
        ELSE SELECT @Resultado = 0
      END

      IF @Verificar = 0
	    IF @RotacionArt = @RotacionAlmPos  AND @PesoTarima  < @PesoMaximo AND @VolumenTarima < @Volumen SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
      ELSE
	    IF @RotacionArt = @RotacionAlmPos  AND @PesoTarima  <= @PesoMaximo AND @VolumenTarima <= @Volumen AND @Pendientes <> 0 SELECT @Resultado = 1 ELSE SELECT @Resultado = 0	    	       
	END
    
    --BUG3628
    IF @Resultado = 0
    BEGIN
     --SELECT 'Ubica', @Posicion, @CantidadTarima, @Tarimas, @Pendientes, 	@PesoTarima, @PesoMaximo, @VolumenTarima, @Volumen, @Tarimas + @Pendientes
     IF @PesoTarima > @PesoMaximo
       SELECT @Ok = 20941, @OkRef= 'Posición: ' + @Posicion + '<BR><BR>' + 'Tarima: '+ @Tarima + '<BR><BR>' + 'Peso Tarima: '+ CONVERT(varchar(20), @PesoTarima) + '<BR><BR>' + 'Peso Maximo: '  + CONVERT(varchar(20), @PesoMaximo)			
	 IF @Ok IS NULL AND @VolumenTarima > @Volumen
       SELECT @Ok = 20942, @OkRef= 'Posición: ' + @Posicion + '<BR><BR>' + 'Tarima: '+ @Tarima + '<BR><BR>' + 'Volumen Tarima: '+ CONVERT(varchar(20), @VolumenTarima) + '<BR><BR>' + 'Volumen Maximo: '  + CONVERT(varchar(20), @Volumen)
    END

    IF @Verificar = 0
	  IF @RotacionArt = @RotacionAlmPos  AND @PesoTarima  <= @PesoMaximo AND @VolumenTarima <= @Volumen SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
    ELSE
	  IF @RotacionArt = @RotacionAlmPos  AND @PesoTarima  <= @PesoMaximo AND @VolumenTarima <= @Volumen AND @Pendientes <> 0 SELECT @Resultado = 1 ELSE SELECT @Resultado = 0

    --REQ 14412
    IF @EstibaMismaFecha = 1
    BEGIN
      IF @Verificar = 0
	    IF @RotacionArt = @RotacionAlmPos  AND @Hoy = @Alta AND @PesoTarima  <= @PesoMaximo AND @VolumenTarima <= @Volumen SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
      ELSE
	    IF @RotacionArt = @RotacionAlmPos  AND @Hoy = @Alta AND @PesoTarima  <= @PesoMaximo AND @VolumenTarima <= @Volumen AND @Pendientes <> 0 SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
    END
    --BUG 19241
    IF @Verificar = 0
      IF (@CantidadTarima * CASE WHEN @PermiteEstibar = 1 AND @EstibaMaxima > 0 THEN @EstibaMaxima ELSE 1 END) > @Pendientes + @Tarimas AND @Resultado = 1
        SELECT @Resultado = 1
      ELSE
        SELECT @Resultado = 0
    ELSE
      IF (@CantidadTarima * CASE WHEN @PermiteEstibar = 1 AND @EstibaMaxima > 0 THEN @EstibaMaxima ELSE 1 END) >= @Pendientes + @Tarimas AND @Resultado = 1
        SELECT @Resultado = 1
      ELSE
        SELECT @Resultado = 0
  END
  --BUG3628
  IF @Ok IS NULL AND @Resultado = 0 
  BEGIN
    SELECT @Ok = 13220
    SELECT @OkRef= 'Posición: ' + @Posicion + '<BR><BR>' +
	               'Tarimas Ubicadas: '+ CONVERT(varchar(20), @Tarimas) + '<BR><BR>' +
				   'Pendientes por Acomodar: '+ CONVERT(varchar(20), @Pendientes) + '<BR><BR>' +
				   'Capacidad Máxima: '  + CONVERT(varchar(20), @CantidadTarima)			
  END
  
   RETURN
END
GO

/**************** fnTMADomicilioDisponible ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTMADomicilioDisponible') DROP FUNCTION fnTMADomicilioDisponible
GO
CREATE FUNCTION fnTMADomicilioDisponible (@Empresa varchar(5), @Almacen varchar(10), @Articulo varchar(20), @TMAID int, @Tarima varchar(20))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado		varchar(20),
    @Posicion		varchar(20)
    --@TipoEspecial	VARCHAR(20)--REQ12615 WMS

  SELECT @Resultado = NULL
  --SELECT @TipoEspecial = NULLIF(RTRIM(TipoEspecial), '') FROM Tarima WHERE Tarima = @Tarima --REQ12615 WMS

  -- Domicilio con Capacidad
  SELECT @Resultado = MIN(ap.Posicion)
    FROM AlmPos ap
   WHERE ap.Almacen = @Almacen AND ap.ArticuloEsp = @Articulo AND UPPER(ap.Tipo) = 'DOMICILIO' AND ap.Estatus = 'ALTA'
     AND ap.Posicion NOT IN (SELECT PosicionDestino FROM TMAD WHERE ID = @TMAID)
     --REQ12615 WMS
     --AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(@TipoEspecial, ap.TipoTarimaEsp), '')
     --AND dbo.fnAlmPosTieneCapacidad(@Empresa, @Almacen, ap.Posicion) = 1
     AND dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, ap.Posicion, @Articulo, @TMAID, 0) = 1
 /*
  -- Domicilio en Punto de Reorden
  IF @Resultado IS NULL
  BEGIN
    SELECT @Resultado = MIN(ap.Posicion)
      FROM AlmPos ap
      JOIN Tarima t ON t.Almacen = ap.Almacen AND t.Posicion = ap.Posicion AND t.Estatus = 'ALTA'
     WHERE ap.Almacen = @Almacen AND ap.ArticuloEsp = @Articulo AND UPPER(ap.Tipo) = 'DOMICILIO' AND ap.Estatus = 'ALTA'
       AND ap.Posicion NOT IN (SELECT PosicionDestino FROM TMAD WHERE ID = @TMAID)
       AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(@TipoEspecial, ap.TipoTarimaEsp), '')
       AND dbo.fnTarimaEnPuntoReorden(@Empresa, @Almacen, t.Tarima, @Articulo) = 1
  END
 */--REQ12615 WMS
  RETURN(@Resultado)
END
GO
--REQ12615 WMS
--BUG2554


/**************** fnTMAUbicacionDisponible ****************/
--/* 06052014
--[04:39:13 p.m.] en este excluyo de las ubicaciones disponibles a todas las que tenga en una zona que crearemos como virtuales
--[04:39:20 p.m.] para que el sistema no me las sugiera
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTMAUbicacionDisponible') DROP FUNCTION dbo.fnTMAUbicacionDisponible
GO
CREATE FUNCTION fnTMAUbicacionDisponible (@Empresa varchar(5), @Almacen varchar(10), @Articulo varchar(20), @TMAID int, @Tarima varchar(20), @SubCuenta varchar(50))  --TASK2429PGC
RETURNS varchar(20)  
--//WITH ENCRYPTION  
AS BEGIN  
  DECLARE  
    @Resultado		  varchar(20),  
    @Domicilio		  varchar(20),  
    --BUG24192 BUG24522
    @Pasillo		  int,
    @Fila			  int,  
    @Zona			  varchar(50),  
    @TipoEspecial	  varchar(20),  
    @Nivel			  int,
	@ZonaArt          varchar(30), -- Bug 5539
	@PosicionArticulo bit,  -- Bug 3805 y 3806
	--Bug 5980
	@ContZonaArt      int,
	@ContPosicion     int,
	@AlmZona          varchar(50)
  
  DECLARE  @Posicion TABLE (Posicion varchar(20), SSPID INT)  
--DECLARE @Empresa varchar(5), @Almacen varchar(10), @Articulo varchar(20), @TMAID int, @Tarima varchar(20)  
  
--SELECT @Empresa = 'DEMO', @Almacen = 'WMS', @Articulo = '1', @TMAID = 1578, @Tarima = 'TM819'  
  
  SELECT @Resultado = NULL  
  SELECT @TipoEspecial = TipoEspecial FROM Tarima WHERE Tarima = @Tarima  
  
  -- Domicilio del Articulo  
  SELECT TOP 1 @Domicilio = Posicion  
    FROM AlmPos  
   WHERE Almacen = @Almacen AND ArticuloEsp = @Articulo AND UPPER(Tipo) = 'DOMICILIO' AND Estatus = 'ALTA'  
  
  --BUG24522
  SELECT @Pasillo = CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, @Fila = Fila, @Nivel = Nivel  
    FROM AlmPos  
   WHERE Almacen = @Almacen AND Posicion = @Domicilio
 
   -- Bug 5539
  SELECT @ZonaArt = NULLIF(Zona,NULL) 
    FROM ArtZona 
   WHERE Articulo = @Articulo

 
  -- Bug 5539
  SELECT @ZonaArt = NULLIF(Zona,NULL) 
    FROM ArtZona 
   WHERE Articulo = @Articulo

   SELECT @ContZonaArt =  COUNT(*) 
     FROM ArtZona 
	WHERE Articulo = @Articulo

	SELECT @ContPosicion = COUNT(*) 
	  FROM AlmPos 
	 WHERE Almacen = @Almacen
	   AND UPPER(Tipo) = 'UBICACION' 
	   AND Estatus = 'ALTA' 
	   AND ISNULL(Zona, '') <> 'Virtuales'
	   AND ArticuloEsp = @Articulo 

	SELECT @AlmZona = ISNULL(Zona,'')
	  FROM AlmPos 
	 WHERE Almacen = @Almacen
	   AND UPPER(Tipo) = 'UBICACION' 
	   AND Estatus = 'ALTA' 
	   AND ISNULL(Zona, '') <> 'Virtuales'
	   AND ArticuloEsp = @Articulo 

	  -- Bug 3805 y 3806
	  SELECT @PosicionArticulo = ISNULL(PosicionArticulo,1)
		FROM EmpresaCfg 
	   WHERE Empresa = @Empresa

      IF @ContZonaArt >= 1 AND @ContPosicion >= 1 AND @AlmZona <> '' /* El Art Tiene Zonas y posiciones configurados */
	  BEGIN	   
	  	  DELETE @Posicion 
          INSERT INTO @Posicion  
		  SELECT ap.Posicion, @@SPID  
		    FROM AlmPos ap  
		   WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
  		     AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(@TipoEspecial, ap.TipoTarimaEsp), '')  
		     AND ap.ArticuloEsp = @Articulo   
		     AND ap.Zona IN (SELECT Zona FROM ArtZona WHERE Articulo = @Articulo)      
		   GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion
		   ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)

			IF @PosicionArticulo = 1
			BEGIN       
				IF @Articulo IN (SELECT Articulo FROM PosicionArt)
					SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
				     WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
				       AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

				IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
					SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
					 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
					   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)

				IF @Resultado IS NULL
					SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
					 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
					   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)
					   					   							
				IF @Resultado IS NULL
				BEGIN
					DELETE @Posicion 
					INSERT INTO @Posicion  
					SELECT ap.Posicion, @@SPID  
					  FROM AlmPos ap  
					 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
					   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(@TipoEspecial, ap.TipoTarimaEsp), '')  
					   AND ap.ArticuloEsp = @Articulo		
					 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion  
					 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)
   
							IF @Articulo IN (SELECT Articulo FROM PosicionArt)
								SELECT TOP 1 @Resultado = Posicion 
								  FROM @Posicion 
								 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
								   AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

							IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
								SELECT TOP 1 @Resultado = Posicion 
								  FROM @Posicion 
								 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
								   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)
			   
			   				IF @Resultado IS NULL
								 SELECT TOP 1 @Resultado = Posicion 
									  FROM @Posicion 
									 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
									   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)	

				END
				IF @Resultado IS NULL
				BEGIN
					DELETE @Posicion 
					INSERT INTO @Posicion  
					SELECT ap.Posicion, @@SPID
					  FROM AlmPos ap  
					 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
					   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(NULL, ap.TipoTarimaEsp), '')  
					   AND NULLIF(ap.ArticuloEsp, '') IS NULL
					   AND ap.Zona IN (SELECT Zona FROM ArtZona WHERE Articulo = @Articulo) 
					 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion
					 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)
   
							IF @Articulo IN (SELECT Articulo FROM PosicionArt)
								SELECT TOP 1 @Resultado = Posicion 
								  FROM @Posicion 
								 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
								   AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

							IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
								SELECT TOP 1 @Resultado = Posicion 
								  FROM @Posicion 
								 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
								   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)
			   
			   				IF @Resultado IS NULL
								 SELECT TOP 1 @Resultado = Posicion 
									  FROM @Posicion 
									 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
									   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)	

				END
				IF @Resultado IS NULL
				BEGIN
					DELETE @Posicion 
					INSERT INTO @Posicion  
					SELECT ap.Posicion, @@SPID
				      FROM AlmPos ap  
				     WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
				       AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(NULL, ap.TipoTarimaEsp), '')  
				       AND NULLIF(ap.ArticuloEsp, '') IS NULL
				       AND ISNULL(ap.Zona, '') = '' 
					 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion
					 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)
   
							IF @Articulo IN (SELECT Articulo FROM PosicionArt)
								SELECT TOP 1 @Resultado = Posicion 
								  FROM @Posicion 
								 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
								   AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

							IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
								SELECT TOP 1 @Resultado = Posicion 
								  FROM @Posicion 
								 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
								   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)
			   
			   				IF @Resultado IS NULL
								 SELECT TOP 1 @Resultado = Posicion 
									  FROM @Posicion 
									 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
									   --BUG7691
									   --AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)	

				END

			END
			ELSE
			BEGIN
				SELECT TOP 1 @Resultado = Posicion 
				  FROM @Posicion 
				 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
			END  
	  END

	   IF @ContZonaArt >= 1 AND @ContPosicion >= 1 AND @AlmZona = ''/* El Art No Tiene Zonas configurados pero posiciones configurados sin zonas*/
	  BEGIN
	  	DELETE @Posicion 
        INSERT INTO @Posicion  
		SELECT ap.Posicion, @@SPID  
		  FROM AlmPos ap  
		 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
		   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(@TipoEspecial, ap.TipoTarimaEsp), '')  
		   AND ap.ArticuloEsp = @Articulo		
		 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion  
		 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)

		 IF @PosicionArticulo = 1
			BEGIN       
				IF @Articulo IN (SELECT Articulo FROM PosicionArt)
					SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
				     WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
				       AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

				IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
					SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
					 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
					   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)
			   
			   	IF @Resultado IS NULL
					 SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)	

				IF @Resultado IS NULL
				BEGIN
					DELETE @Posicion 
					INSERT INTO @Posicion  
					SELECT ap.Posicion, @@SPID
					  FROM AlmPos ap  
					 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
					   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(NULL, ap.TipoTarimaEsp), '')  
					   AND NULLIF(ap.ArticuloEsp, '') IS NULL
					   AND ap.Zona IN (SELECT Zona FROM ArtZona WHERE Articulo = @Articulo) 
					 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion
					 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)
     
					IF @Articulo IN (SELECT Articulo FROM PosicionArt)
						SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

					IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
						SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)

					IF @Resultado IS NULL
						 SELECT TOP 1 @Resultado = Posicion 
							  FROM @Posicion 
							 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
							   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)	

				END
				IF @Resultado IS NULL
				BEGIN
					DELETE @Posicion 
					INSERT INTO @Posicion  
					SELECT ap.Posicion, @@SPID
					  FROM AlmPos ap  
					 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
					   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(NULL, ap.TipoTarimaEsp), '')  
					   AND NULLIF(ap.ArticuloEsp, '') IS NULL
					   AND ISNULL(ap.Zona, '') = ''  
					 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion
					 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)
     
					IF @Articulo IN (SELECT Articulo FROM PosicionArt)
						SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

					IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
						SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)

					IF @Resultado IS NULL
						 SELECT TOP 1 @Resultado = Posicion 
							  FROM @Posicion 
							 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
							   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)	

				END

			END
			ELSE
			BEGIN
				SELECT TOP 1 @Resultado = Posicion 
				  FROM @Posicion 
				 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
			END  
	  END

	  IF @ContZonaArt = 0 AND @ContPosicion >= 1 /* El Art No Tiene Zonas configurados pero posiciones configurados sin zonas*/
	  BEGIN
	  	DELETE @Posicion 
        INSERT INTO @Posicion  
		SELECT ap.Posicion, @@SPID  
		  FROM AlmPos ap  
		 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
		   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(@TipoEspecial, ap.TipoTarimaEsp), '')  
		   AND ap.ArticuloEsp = @Articulo		
		 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion  
		 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)

		 IF @PosicionArticulo = 1
			BEGIN       
				IF @Articulo IN (SELECT Articulo FROM PosicionArt)
					SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
				     WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
				       AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

				IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
					SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
					 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
					   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)

				IF @Resultado IS NULL
				 SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
					 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
					   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)					   

				IF @Resultado IS NULL
				BEGIN
					DELETE @Posicion 
					INSERT INTO @Posicion  
					SELECT ap.Posicion, @@SPID
					  FROM AlmPos ap  
					 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
					   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(NULL, ap.TipoTarimaEsp), '')  
					   AND NULLIF(ap.ArticuloEsp, '') IS NULL
					   AND ap.Zona IN (SELECT Zona FROM ArtZona WHERE Articulo = @Articulo) 
					 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion
					 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)
     
					IF @Articulo IN (SELECT Articulo FROM PosicionArt)
						SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

					IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
						SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)

					IF @Resultado IS NULL
						 SELECT TOP 1 @Resultado = Posicion 
							  FROM @Posicion 
							 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
							   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)	

				END
				IF @Resultado IS NULL
				BEGIN
					DELETE @Posicion 
					INSERT INTO @Posicion  
					SELECT ap.Posicion, @@SPID
					  FROM AlmPos ap  
					 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
					   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(NULL, ap.TipoTarimaEsp), '')  
					   AND NULLIF(ap.ArticuloEsp, '') IS NULL
					   AND ISNULL(ap.Zona, '') = ''  
					 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion
					 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)
     
					IF @Articulo IN (SELECT Articulo FROM PosicionArt)
						SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

					IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
						SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)

					IF @Resultado IS NULL
						 SELECT TOP 1 @Resultado = Posicion 
							  FROM @Posicion 
							 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
							   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)	

				END
			END
			ELSE
			BEGIN
				SELECT TOP 1 @Resultado = Posicion 
				  FROM @Posicion 
				 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
			END  
	  END

	  IF @ContZonaArt >= 1 AND @ContPosicion = 0  /* El Art Tiene Zonas */
	  BEGIN
	  	DELETE @Posicion 
        INSERT INTO @Posicion  
		SELECT ap.Posicion, @@SPID
		  FROM AlmPos ap  
		 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
		   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(NULL, ap.TipoTarimaEsp), '')  
		   AND NULLIF(ap.ArticuloEsp, '') IS NULL
		   AND ap.Zona IN (SELECT Zona FROM ArtZona WHERE Articulo = @Articulo) 
		 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion
		 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)

		 IF @PosicionArticulo = 1
			BEGIN       
				IF @Articulo IN (SELECT Articulo FROM PosicionArt)
					SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
				     WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
				       AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

				IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
					SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
					 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
					   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)

			    IF @Resultado IS NULL
					 SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)	

			    IF @Resultado IS NULL
					 SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   

				IF @RESULTADO IS NULL
				BEGIN
					DELETE @Posicion 
					INSERT INTO @Posicion  
					SELECT ap.Posicion, @@SPID
					  FROM AlmPos ap  
					 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
					   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(NULL, ap.TipoTarimaEsp), '')  
					   AND NULLIF(ap.ArticuloEsp, '') IS NULL
					   AND ISNULL(ap.Zona, '') = ''  
					 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion
					 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)
     
					IF @Articulo IN (SELECT Articulo FROM PosicionArt)
						SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

					IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
						SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)

					IF @Resultado IS NULL
						 SELECT TOP 1 @Resultado = Posicion 
							  FROM @Posicion 
							 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
							   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)	

					IF @Resultado IS NULL
						 SELECT TOP 1 @Resultado = Posicion 
							  FROM @Posicion 
							 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 							   

				END
			END
			ELSE
			BEGIN
				SELECT TOP 1 @Resultado = Posicion 
				  FROM @Posicion 
				 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
			END  

	  END

	  IF @ContZonaArt = 0 AND @ContPosicion = 0  /* El Art No Tiene Zonas Ni posiciones configurados */
	  BEGIN
	  	 DELETE @Posicion 
         INSERT INTO @Posicion  
		 SELECT ap.Posicion, @@SPID
		  FROM AlmPos ap  
		 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
		   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(NULL, ap.TipoTarimaEsp), '')  
		   AND NULLIF(ap.ArticuloEsp, '') IS NULL
		   AND ISNULL(ap.Zona, '') = ''  
		 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion
		 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel)

		 IF @PosicionArticulo = 1
			BEGIN       
				IF @Articulo IN (SELECT Articulo FROM PosicionArt)
					SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
				     WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
				       AND Posicion IN (SELECT Posicion FROM PosicionArt WHERE Articulo = @Articulo)

				IF @Articulo NOT IN (SELECT Articulo FROM PosicionArt)
					SELECT TOP 1 @Resultado = Posicion 
					  FROM @Posicion 
					 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
					   AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)

			    IF @Resultado IS NULL
					 SELECT TOP 1 @Resultado = Posicion 
						  FROM @Posicion 
						 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
						   --BUG7691
						   --AND Posicion NOT IN (SELECT Posicion FROM PosicionArt)	

			END
			ELSE
			BEGIN
				SELECT TOP 1 @Resultado = Posicion 
				  FROM @Posicion 
				 WHERE dbo.fnAlmPosTieneCapacidadWMS(@Empresa, @Almacen, Posicion, @Articulo, @TMAID, 0) = 1 
			END 
	  END
	      
  RETURN(@Resultado)  
END  
GO

/**************** spTMAInicializarUbicacionOpcionDisponible ****************/
--TASK2429PGC
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'spTMAInicializarUbicacionOpcionDisponible') DROP PROC dbo.spTMAInicializarUbicacionOpcionDisponible
GO
CREATE PROCEDURE spTMAInicializarUbicacionOpcionDisponible
    	    @Empresa          		varchar(5),
		    @Sucursal			int,
		    @Almacen			varchar(10),
            @TMAID                 int,			
 		    @Articulo			varchar(20),
            @Tarima             varchar(20),
            @SubCuenta          varchar(50),
            @ID                 int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
        
    @Renglon		float,
    @Zona			varchar(50),--Cambio WMS

	@ArticuloTipo      varchar(20),
    @PosicionSubCuenta varchar(50),
    @Domicilio		varchar(20),      
    @Pasillo		int,
    @Fila			int,  
    @TipoEspecial	varchar(20),  
    @Nivel			int

  
 
             SELECT @TipoEspecial = TipoEspecial FROM Tarima WHERE Tarima = @Tarima  
  
		    -- Domicilio del Articulo  
		    SELECT TOP 1 @Domicilio = Posicion  
			  FROM AlmPos  
		     WHERE Almacen = @Almacen AND ArticuloEsp = @Articulo AND UPPER(Tipo) = 'DOMICILIO' AND Estatus = 'ALTA'  
		  
		    --BUG24522
		    SELECT @Pasillo = CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, @Fila = Fila, @Nivel = Nivel  
			 FROM AlmPos  
		    WHERE Almacen = @Almacen AND Posicion = @Domicilio

            SELECT @PosicionSubCuenta=null

			SELECT TOP 1 @PosicionSubCuenta=ap.Posicion 
			  FROM AlmPos ap  
			 --EWQ. Tuning
			 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' 
			   AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
			   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(@TipoEspecial, ap.TipoTarimaEsp), '')  
			   AND ap.ArticuloEsp = @Articulo
			   AND NULLIF(ap.SubCuenta,'') IS NULL
--			   AND ap.ArticuloEsp+ap.Posicion+ap.SubCuenta NOT IN 
--				   (SELECT Articulo+PosicionDestino+SubCuenta
--					  FROM TMA t JOIN TMAD d ON d.ID=t.ID
--                     WHERE --t.ID = @TMAID and
--                       t.Estatus = 'PENDIENTE'
--                       AND d.EstaPendiente = 1)
			 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion  
			 --EWQ.Tuning
			 --BUG24522
			 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), 
				   Abs(ISNULL(Nivel, 0)-@Nivel)    

            IF @PosicionSubCuenta IS NULL
            BEGIN
             SELECT TOP 1 @PosicionSubCuenta=ap.Posicion 
			  FROM AlmPos ap  
			 --EWQ. Tuning
			 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' 
			   AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
			   AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(@TipoEspecial, ap.TipoTarimaEsp), '')  
               AND ap.Zona IN(SELECT Zona FROM ArtZona WHERE Articulo = @Articulo) 
               AND NULLIF(ap.SubCuenta,'') IS NULL               			   
               AND NULLIF(ap.ArticuloEsp, '') IS NULL
--			   AND ap.Posicion+ap.SubCuenta NOT IN 
--				   (SELECT PosicionDestino+SubCuenta
--					FROM TMAD WHERE ID = @TMAID)
			 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion  
			 --EWQ.Tuning
			 --BUG24522
			 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), 
				   Abs(ISNULL(Nivel, 0)-@Nivel)
            END
      

            IF @PosicionSubCuenta IS NULL
            BEGIN
             SELECT TOP 1 @PosicionSubCuenta=ap.Posicion 
			  FROM AlmPos ap  
			 --EWQ. Tuning
			 WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' 
			   AND ap.Estatus = 'ALTA' AND ISNULL(ap.Zona, '') <> 'Virtuales'
			   --AND ISNULL(ap.TipoTarimaEsp, '') = ISNULL(ISNULL(@TipoEspecial, ap.TipoTarimaEsp), '') 
               AND NULLIF(ap.SubCuenta,'') IS NULL
               AND NULLIF(ap.ArticuloEsp, '') IS NULL
               --AND ap.ArticuloEsp=''
--			   AND ap.Posicion+ap.SubCuenta NOT IN 
--				   (SELECT PosicionDestino+SubCuenta
--					FROM TMAD WHERE ID = @TMAID)
			 GROUP BY ap.Pasillo, ap.Fila, ap.Nivel, ap.Posicion  
			 --EWQ.Tuning
			 --BUG24522
			 ORDER BY Abs(ISNULL(CASE ISNUMERIC(Pasillo) WHEN 1 THEN Pasillo ELSE 0 END, 0)-@Pasillo), Abs(ISNULL(Fila, 0)-@Fila), 
				   Abs(ISNULL(Nivel, 0)-@Nivel)
            END
      
		    IF @PosicionSubCuenta IS NOT NULL
             IF NOT EXISTS(SELECT * FROM AlmPos WHERE ArticuloEsp=@Articulo AND SubCuenta=@SubCuenta)
             BEGIN
			  UPDATE AlmPos
			     SET SubCuenta=@SubCuenta
			   WHERE Posicion=@PosicionSubCuenta AND SubCuenta IS NULL
             END		  

  RETURN
END
GO

/**************** fnReabastecerDomicilio ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnReabastecerDomicilio') DROP FUNCTION fnReabastecerDomicilio
GO
CREATE FUNCTION fnReabastecerDomicilio (@Empresa varchar(5), @Almacen varchar(10), @Articulo varchar(20), @Domicilio varchar(20))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado		varchar(20),
    @Tipo		varchar(20),
    @Pasillo		int,
    @Fila		int,
    @Zona		varchar(50)

  SELECT @Resultado = NULL

  SELECT @Tipo = UPPER(Tipo), @Pasillo = Pasillo, @Fila = Fila, @Zona = Zona
    FROM AlmPos
   WHERE Almacen = @Almacen AND Posicion = @Domicilio

  IF @Tipo = 'DOMICILIO'
  BEGIN
    -- Buscar Ubicacion en Zona y Pasillo
    IF @Resultado IS NULL
      SELECT TOP(1) @Resultado = t.Tarima
        FROM AlmPos ap
        JOIN Tarima t ON t.Posicion = ap.Posicion AND dbo.fnExistenciaDeTarima(@Empresa, @Almacen, t.Tarima, @Articulo) > 0.0
       WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA'         
         AND ap.Zona = @Zona AND ap.Pasillo = @Pasillo
       GROUP BY t.Tarima, ISNULL(t.FechaCaducidad, t.Alta)
       ORDER BY ISNULL(t.FechaCaducidad, t.Alta), t.Tarima

    -- Buscar Ubicacion en Todo el Pasillo
    IF @Resultado IS NULL
      SELECT TOP(1) @Resultado = t.Tarima
        FROM AlmPos ap
        JOIN Tarima t ON t.Posicion = ap.Posicion AND dbo.fnExistenciaDeTarima(@Empresa, @Almacen, t.Tarima, @Articulo) > 0.0
       WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA'
         AND ap.Pasillo = @Pasillo
       GROUP BY t.Tarima, ISNULL(t.FechaCaducidad, t.Alta)
       ORDER BY ISNULL(t.FechaCaducidad, t.Alta), t.Tarima

    -- Buscar Ubicacion en Todo el Almacen
    IF @Resultado IS NULL
      SELECT TOP(1) @Resultado = t.Tarima
        FROM AlmPos ap
        JOIN Tarima t ON t.Posicion = ap.Posicion AND dbo.fnExistenciaDeTarima(@Empresa, @Almacen, t.Tarima, @Articulo) > 0.0
       WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'UBICACION' AND ap.Estatus = 'ALTA'
       GROUP BY t.Tarima, ISNULL(t.FechaCaducidad, t.Alta)
       ORDER BY ISNULL(t.FechaCaducidad, t.Alta), t.Tarima
  END

  RETURN(@Resultado)
END
GO

-- SELECT dbo.fnTarimaEnPosicion('A3', 'P1')
-- update tarima set Almacen = 'A3', Posicion = 'P1' WHERE Tarima = 'T1'
-- select * from tarima
/**************** fnTarimaEnPosicion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTarimaEnPosicion') DROP FUNCTION fnTarimaEnPosicion
GO
CREATE FUNCTION fnTarimaEnPosicion (@Almacen varchar(10), @Posicion varchar(10))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(20)

  SELECT @Resultado = NULL  
  SELECT @Resultado = NULLIF(RTRIM(MIN(Tarima)), '')
    FROM Tarima
   WHERE Almacen = @Almacen AND Posicion = @Posicion AND Estatus = 'ALTA'

  RETURN(@Resultado)
END
GO

--BUG24589
/************** spGenerarOrdenTarimaAcomodo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarOrdenTarimaAcomodo') AND type = 'P') drop procedure dbo.spGenerarOrdenTarimaAcomodo
GO             
CREATE PROCEDURE spGenerarOrdenTarimaAcomodo
		    @Tipo			varchar(20),
		    @Modulo			varchar(5),
    		    @ID               		int,			
 		    @Accion			varchar(20),
    		    @Empresa          		varchar(5),
		    @Sucursal			int,
		    @Usuario			varchar(10),
		    @Mov			varchar(20),
                    @MovID			varchar(20),
		    @MovTipo			varchar(20),
		    @FechaEmision		datetime,
		    @Proyecto			varchar(50),
		    @Almacen			varchar(10),
    		    @Ok               		int           	OUTPUT,
    		    @OkRef            		varchar(255)  	OUTPUT,
		    @GenerarOrden		bit		= 1
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TMAID		int,
    @TMAMov		varchar(20),
    @TMAMovID		varchar(20),
    @Renglon		float,
    @Tarima		varchar(20),
    @Posicion		varchar(20),
    @PosicionDestino	varchar(20),
    @Articulo		varchar(20),--Cambio WMS
    @MovDestino		varchar(20),--Cambio WMS
    @Zona			varchar(50),--Cambio WMS    
    --EWQ.Tuning
    @Unidad			varchar(50),
    @CantidadUnidad	float,
	@Es50			bit,
    @FechaCaducidad	datetime,
	@SubCuenta   varchar(50),  -- TASK2429PGC
	@ArticuloTipo      varchar(20), --TASK2429PGC    
    --TASK2429PGC
    @PosicionSubCuenta varchar(50),
    @Domicilio		varchar(20),      
    @Pasillo		int,
    @Fila			int,  
    @TipoEspecial	varchar(20),  
    @Nivel			int,

	@ArtSerieLoteInfo bit, --TASK3288
	@WMSPorcentajeMinimoADom    float --BUG6556


  SELECT @WMSPorcentajeMinimoADom = ISNULL(WMSPorcentajeMinimoADom,0) FROM EmpresaCfg WHERE Empresa = @Empresa --BUG6556

  SELECT @MovDestino = MovDestino FROM AlmSugerirSurtidoTarima WHERE Almacen = @Almacen AND Modulo = @Modulo AND Mov = @Mov AND ModuloDestino IN('TMA', 'WMS')--Cambio WMS

  SELECT @TMAID = NULL, @Renglon = 0.0
  IF @Accion = 'CANCELAR'
    SELECT @TMAID = MIN(ID) 
      FROM TMA
     WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
  ELSE BEGIN
    IF @Accion = 'RESERVARPARCIAL' SELECT @Accion = 'AFECTAR'
    INSERT TMA (
           Empresa,  Sucursal,  Usuario,  Mov,             
           FechaEmision,  Proyecto,  Estatus,       OrigenTipo, Origen, OrigenID, Almacen, Prioridad)--Cambio WMS
--    SELECT @Empresa, @Sucursal, @Usuario, CASE WHEN @GenerarOrden = 1 THEN TMAOrdenAcomodo ELSE TMASolicitudAcomodo END, --Cambio WMS
    SELECT @Empresa, @Sucursal, @Usuario, @MovDestino,--Cambio WMS
           @FechaEmision, @Proyecto, 'SINAFECTAR', @Modulo,    @Mov,   @MovID,   @Almacen, 'Alta'--Cambio WMS
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa
    SELECT @TMAID = SCOPE_IDENTITY()

--SELECT DISTINCT Tarima, Articulo, SubCuenta, Cantidad FROM InvD    WHERE ID = @ID AND NULLIF(RTRIM(Tarima), '') IS NOT NULL AND Seccion = CASE WHEN @Tipo = 'RECIBO' AND @MovTipo = 'INV.TMA' THEN 1 ELSE NULL END

    SELECT @PosicionSubCuenta=NULL

	--TASK2429PGC
    IF @Modulo = 'INV'  DECLARE crTarima CURSOR LOCAL FOR SELECT DISTINCT Tarima, Articulo, SubCuenta FROM InvD    WHERE ID = @ID AND NULLIF(RTRIM(Tarima), '') IS NOT NULL AND Seccion = CASE WHEN @Tipo = 'RECIBO' AND @MovTipo = 'INV.TMA' THEN 1 ELSE NULL END ELSE    
    IF @Modulo = 'VTAS' DECLARE crTarima CURSOR LOCAL FOR SELECT DISTINCT Tarima, Articulo, SubCuenta FROM VentaD  WHERE ID = @ID AND NULLIF(RTRIM(Tarima), '') IS NOT NULL ELSE
    IF @Modulo = 'COMS' DECLARE crTarima CURSOR LOCAL FOR SELECT DISTINCT Tarima, Articulo, SubCuenta FROM CompraD WHERE ID = @ID AND NULLIF(RTRIM(Tarima), '') IS NOT NULL ELSE
    IF @Modulo = 'PROD' DECLARE crTarima CURSOR LOCAL FOR SELECT DISTINCT Tarima, Articulo, SubCuenta FROM ProdD   WHERE ID = @ID AND NULLIF(RTRIM(Tarima), '') IS NOT NULL 

    OPEN crTarima
    FETCH NEXT FROM crTarima INTO @Tarima, @Articulo, @SubCuenta --TASK2429PGC
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @PosicionDestino = NULL        
        SELECT @Es50 = 0

        
        --BUG24471
        --SELECT @Articulo = dbo.fnArticuloEnTarima(@Empresa, @Tarima)

		--TASK2429PGC
        /* SELECT @Articulo = NULL
		SELECT @Articulo = Articulo FROM ArtDisponibleTarima WHERE Empresa = @Empresa AND Almacen = @Almacen AND Tarima = @Tarima
		*/

		SELECT @ArticuloTipo=Tipo, @ArtSerieLoteInfo=SerieLoteInfo FROM Art WHERE Articulo  = @Articulo --TASK2429PGC --TASK3288

        IF @Tipo = 'RECIBO'
        BEGIN
          --BUG24105
          IF NULLIF(@SubCuenta,'') IS NULL --TASK3288
		    IF @ArticuloTipo<>'Serie' OR (@ArticuloTipo='Serie' AND @ArtSerieLoteInfo=1) --TASK2429PGC  --TASK3288
		      EXEC spTMAArtDomicilioInicializar @Empresa, @Almacen, @Articulo, ''
          
           --TASK2429PGC 07082015
		   --IF @SubCuenta IS NOT NULL
             --Exec spTMAInicializarUbicacionOpcionDisponible @Empresa, @Sucursal, @Almacen, @TMAID, @Articulo, @Tarima, @SubCuenta, @ID

          --EWQ. Tuning Solo SSFA
          IF EXISTS(SELECT c.*
                      FROM Inv d
                      JOIN Inv o ON o.Mov = d.Origen AND o.MovId = d.OrigenID AND d.OrigenTipo = 'INV' AND d.Empresa = o.Empresa
                      JOIN Compra c ON c.Mov = o.Origen AND c.MovId = o.OrigenID AND o.OrigenTipo = 'COMS' AND c.Empresa = o.Empresa
                      JOIN MovTipo m ON c.Mov = m.Mov AND m.Modulo = 'COMS'
                     WHERE d.ID = @ID
                       AND m.Clave IN('COMS.F', 'COMS.EG', 'COMS.EI')) AND @PosicionDestino IS NULL
          BEGIN
            IF EXISTS(SELECT ID
                        FROM InvD
                       WHERE ID = @ID 
                         AND Seccion = 1 
                         AND Tarima = @Tarima
                         AND Articulo = @Articulo
                         AND Almacen = @Almacen
                       GROUP BY ID, Unidad
                       --HAVING SUM(Cantidad) <= dbo.fnArtUnidadCantidadTarima(@Empresa, @Articulo, Unidad)*0.5
					   --HAVING CONVERT(NUMERIC(12,2), SUM(Cantidad)) <= dbo.fnArtUnidadCantidadTarima(@Empresa, @Articulo, Unidad)*0.5 --BUG3675
					   HAVING CONVERT(NUMERIC(12,2), SUM(Cantidad)) <= dbo.fnArtUnidadCantidadTarima(@Empresa, @Articulo, Unidad)*(@WMSPorcentajeMinimoADom/100.00) --BUG6556
            )
            BEGIN
              SELECT @PosicionDestino = NULL
              
              SELECT @PosicionDestino = dbo.fnTMADomicilioDisponible50(@Empresa, @Almacen, @Articulo, @TMAID, @Tarima),
					 @Es50			  = 1
            END
          END

          --BUG24471
          IF EXISTS(SELECT oo.*
                      FROM Inv d
                      JOIN Inv o ON o.Mov = d.Origen AND o.MovId = d.OrigenID AND d.OrigenTipo = 'INV' AND d.Empresa = o.Empresa
                      JOIN Inv oo ON o.Origen = oo.Mov AND o.OrigenID = oo.MovID AND o.Empresa = oo.Empresa
                      JOIN MovTipo m ON oo.Mov = m.Mov AND m.Modulo = 'INV'
                     WHERE d.ID = @ID
                       AND m.Clave IN('INV.EI', 'INV.E', 'INV.R')) AND @PosicionDestino IS NULL
          BEGIN     
            IF EXISTS(SELECT ID
                        FROM InvD
                       WHERE ID = @ID 
                         AND Seccion = 1 
                         AND Tarima = @Tarima
                         AND Articulo = @Articulo
                         AND Almacen = @Almacen
                       GROUP BY ID, Unidad
                       --HAVING SUM(Cantidad) <= dbo.fnArtUnidadCantidadTarima(@Empresa, @Articulo, Unidad)*0.5
					   --HAVING CONVERT(NUMERIC(12,2), SUM(Cantidad)) <= dbo.fnArtUnidadCantidadTarima(@Empresa, @Articulo, Unidad)*0.5 --BUG3675
					   HAVING CONVERT(NUMERIC(12,2), SUM(Cantidad)) <= dbo.fnArtUnidadCantidadTarima(@Empresa, @Articulo, Unidad)*(@WMSPorcentajeMinimoADom/100.00) --BUG6556
            )
            BEGIN
              SELECT @PosicionDestino = NULL
              
              SELECT @PosicionDestino = dbo.fnTMADomicilioDisponible50(@Empresa, @Almacen, @Articulo, @TMAID, @Tarima),
					 @Es50			  = 1
            END
          END          

          IF @PosicionDestino IS NULL AND NULLIF(@SubCuenta,'') IS NULL --TASK2429PGC
		    IF @ArticuloTipo<>'Serie' OR (@ArticuloTipo='Serie' AND @ArtSerieLoteInfo=1) --TASK2429PGC  --TASK3288
              SELECT @PosicionDestino = dbo.fnTMADomicilioDisponible(@Empresa, @Almacen, @Articulo, @TMAID, @Tarima)

          --BUG24471
          IF ISNULL(@Es50, 0) = 0 AND @PosicionDestino IS NULL
          BEGIN
            SELECT @FechaCaducidad = ISNULL(FechaCaducidad, Alta) FROM Tarima WHERE Tarima = @Tarima

            IF EXISTS(SELECT t.*
                       FROM ArtDisponibleTarima a 
                       JOIN Tarima t ON t.Tarima = a.Tarima 
                       JOIN AlmPos p ON p.Posicion = t.Posicion  AND p.Almacen = @Almacen
                      WHERE a.Articulo = @Articulo 
                        AND p.Tipo = 'Ubicacion' 
                        AND t.Tarima <> @Tarima
                        AND t.Estatus = 'ALTA' AND t.Tarima NOT LIKE '%-%'
                        AND ISNULL(FechaCaducidad, Alta) < @FechaCaducidad
                       )
              BEGIN
               SELECT @PosicionDestino = dbo.fnTMAUbicacionDisponible(@Empresa, @Almacen, @Articulo, @TMAID, @Tarima, @SubCuenta) --TASK2429PGC
			   	IF NOT EXISTS (SELECT * FROM PosicionArt WHERE Posicion = @PosicionDestino AND Articulo = @Articulo) AND @PosicionDestino IS NOT NULL --BUG 5980
				BEGIN
					INSERT PosicionArt (Posicion,         Articulo)
								SELECT @PosicionDestino,  @Articulo
				END
              END
          END

		  --BUG3354 15092015
          --IF (SELECT COUNT(*) FROM TMAD WHERE ID=@TMAID)>1
          --  IF @PosicionDestino+@SubCuenta NOT IN
          --    (SELECT PosicionDestino+SubCuenta FROM TMAD WHERE ID=@TMAID
          --     UNION     
          --      SELECT Tarima.Posicion+Tarima.SubCuenta
          --       FROM Tarima
          --       JOIN AlmPos ON Tarima.Almacen=AlmPos.Almacen AND Tarima.Posicion=AlmPos.Posicion
          --       JOIN ArtDisponibleTarima ON Tarima.Tarima=ArtDisponibleTarima.Tarima
          --      WHERE ArtDisponibleTarima.Disponible>0)
          --       SELECT @PosicionDestino=NULL
          
          IF @PosicionDestino IS NULL
          BEGIN      
           SELECT @PosicionDestino = dbo.fnTMAUbicacionDisponible(@Empresa, @Almacen, @Articulo, @TMAID, @Tarima, @SubCuenta) --TASK2429PGC
		   IF NOT EXISTS (SELECT * FROM PosicionArt WHERE Posicion = @PosicionDestino AND Articulo = @Articulo) AND @PosicionDestino IS NOT NULL --BUG 5980
		   BEGIN
		       INSERT PosicionArt (Posicion,         Articulo)
	   	                    SELECT @PosicionDestino, @Articulo
		   END
          END

        END

        IF @Tipo = 'REABASTECIMIENTO'
        BEGIN
          IF dbo.fnTarimaEnPuntoReorden(@Empresa, @Almacen, @Tarima, @Articulo) = 1
          BEGIN
            SELECT @PosicionDestino = Posicion FROM Tarima WHERE Tarima = @Tarima

			/* Bug 4604 Inicia */
			IF @PosicionDestino IS NULL
			BEGIN
				SELECT @PosicionDestino = PosicionWMS
				  FROM Inv 
				 WHERE ID = @ID
			END
			/* Bug 4604 Fin */

            SELECT @Articulo = ArticuloEsp FROM AlmPos WHERE Almacen = @Almacen AND Posicion = @PosicionDestino
            SELECT @Tarima = dbo.fnReabastecerDomicilio(@Empresa, @Almacen, @Articulo, @PosicionDestino)
          END ELSE SELECT @Tarima = NULL
        END

        IF @Tarima IS NOT NULL --AND @PosicionDestino IS NOT NULL-- Cambio WMS
        BEGIN
          --IF ISNULL(@Es50, 0) = 0
          --BEGIN
            SELECT @Posicion = NULL
            SELECT @Posicion = Posicion FROM Tarima WHERE Tarima = @Tarima 

			/* Bug 4604 Inicia */
			IF @Posicion IS NULL
			BEGIN
				SELECT @Posicion = PosicionWMS
				  FROM Inv 
				 WHERE ID = @ID

				UPDATE Tarima
				   SET Posicion = @Posicion
				 WHERE Tarima   = @Tarima
		    END
			/* Bug 4604 Fin */

          --END
          --ELSE
          --  SELECT @Posicion = Posicion FROM Inv WHERE ID = @ID

          SELECT @Unidad = Unidad, @CantidadUnidad = Cantidad FROM InvD WHERE ID = @ID AND Tarima = @Tarima
		  
		  --Bugs 5993, 3786
		  SELECT @FechaCaducidad = FechaCaducidad
		    FROM InvD
		   WHERE ID = @ID

--          IF ISNULL(@Posicion, '') <> @PosicionDestino-- Cambio WMS
--          BEGIN-- Cambio WMS
            SELECT @Renglon = @Renglon + 2048.0
            SELECT @Zona = Zona FROM AlmPos WHERE Posicion = @PosicionDestino AND Almacen = @Almacen-- Cambio WMS
            --EWQ.Tuning 
            --EWQ. Tuning Solo SSFA
            INSERT TMAD (        
  	            ID,     Sucursal,  Renglon,  Tarima,  Almacen,  Posicion,  PosicionDestino, Zona, CapacidadPosicion, Prioridad, EstaPendiente, Procesado, Unidad, CantidadUnidad, Es50, Articulo, SubCuenta, FechaCaducidad)-- Cambio WMS --TASK2429PGC --Bugs 5993, 3786
            VALUES (@TMAID, @Sucursal, @Renglon, @Tarima, @Almacen, @Posicion, @PosicionDestino, @Zona, 1, 'Alta', 1, 0, @Unidad, @CantidadUnidad, ISNULL(@Es50, 0), @Articulo, @SubCuenta, @FechaCaducidad)-- Cambio WMS --TASK2429PGC --Bugs 5993, 3786
--          END-- Cambio WMS
        END
      END
      FETCH NEXT FROM crTarima INTO @Tarima, @Articulo, @SubCuenta
    END
    CLOSE crTarima
    DEALLOCATE crTarima

-- Cambio WMS
--    IF NOT EXISTS(SELECT * FROM TMAD WHERE ID = @TMAID)
--    BEGIN
--      DELETE TMA WHERE ID = @TMAID
--      SELECT @TMAID = NULL
--    END
-- Cambio WMS
  END

  IF @TMAID IS NOT NULL 
  BEGIN
    EXEC spAfectar 'TMA', @TMAID, @Accion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
    SELECT @TMAMov = Mov, @TMAMovID = MovID FROM TMA WHERE ID = @TMAID
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'TMA', @TMAID, @TMAMov, @TMAMovID, @Ok OUTPUT
  END

  RETURN
END
GO

/**************** spTraspasarTarima ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTraspasarTarima') and type = 'P') drop procedure dbo.spTraspasarTarima
GO
CREATE PROCEDURE spTraspasarTarima
		    @Modulo		varchar(5),
    		    @ID               	int,			
 		    @Accion		varchar(20),
    		    @Empresa          	varchar(5),
		    @Usuario		varchar(10),
		    @Mov		varchar(20),
                    @MovID		varchar(20),
		    @MovTipo		varchar(20),
		    @FechaEmision	datetime,

		    @TarimaNueva	varchar(20),
		    @TarimaAnterior	varchar(20),

    		    @Ok			int           	OUTPUT,
    		    @OkRef		varchar(255)  	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @InvID	int,
    @InvMov	varchar(20),
    @InvMovID	varchar(20),
    @Almacen	varchar(10),
    @Sucursal	int,
    @Moneda	varchar(10),
    @TipoCambio	float,
    @TipoCosteo	varchar(20),
    @Cantidad	float,
    @Costo	float,
    @Renglon	float,
    @RenglonID	int,
    @Articulo	varchar(20),
    @SubCuenta	varchar(50),
    @Proveedor	varchar(10),
    @Unidad	varchar(50)

  SELECT @InvMov = InvEntarimado FROM EmpresaCfgMov WHERE Empresa = @Empresa
  IF @Accion = 'CANCELAR'
    SELECT @InvID = ID FROM Inv WHERE Mov = @InvMov AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
  ELSE BEGIN
    SELECT @Almacen = Almacen FROM Tarima WHERE Tarima = @TarimaAnterior
    SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
    SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
    SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
    SELECT @TipoCosteo = ISNULL(NULLIF(RTRIM(UPPER(TipoCosteo)), ''), 'PROMEDIO')
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

    INSERT Inv (
            Empresa,  Sucursal,  Mov,     Almacen,  FechaEmision,  Usuario,  Estatus,      Moneda,  TipoCambio,  OrigenTipo, Origen, OrigenID)
    VALUES (@Empresa, @Sucursal, @InvMov, @Almacen, @FechaEmision, @Usuario, 'SINAFECTAR', @Moneda, @TipoCambio, @Modulo,    @Mov,   @MovID)
    SELECT @InvID = SCOPE_IDENTITY()

    DECLARE crTarimaExistencia CURSOR LOCAL FOR 
     SELECT e.Articulo, e.SubCuenta, e.Inventario, a.Proveedor, a.Unidad
       FROM ArtSubExistenciaInvTarima e
       JOIN Art a ON a.Articulo = e.Articulo
      WHERE e.Empresa = @Empresa AND e.Almacen = @Almacen AND e.Tarima = @TarimaAnterior
        AND NULLIF(e.Inventario, 0.0) IS NOT NULL

    SELECT @Renglon = 0.0, @RenglonID = 0
    OPEN crTarimaExistencia
    FETCH NEXT FROM crTarimaExistencia INTO @Articulo, @SubCuenta, @Cantidad, @Proveedor, @Unidad
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
        SELECT @Costo = NULL
        EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0

        INSERT InvD (
               ID,     Renglon,  Seccion, RenglonSub, RenglonID,  Sucursal,  Almacen,  Articulo,  SubCuenta,              Cantidad,  Unidad,  Costo,  Tarima)
        SELECT @InvID, @Renglon, NULL,    0,          @RenglonID, @Sucursal, @Almacen, @Articulo, ISNULL(@SubCuenta, ''), @Cantidad, @Unidad, @Costo, @TarimaAnterior

        INSERT SerieLoteMov (
               Sucursal,  Empresa, Modulo, ID,     RenglonID,  Articulo, SubCuenta, SerieLote, Cantidad,   CantidadAlterna,   Propiedades, Cliente, Localizacion, ArtCostoInv)
        SELECT @Sucursal, Empresa, 'INV',  @InvID, @RenglonID, Articulo, SubCuenta, SerieLote, Existencia, ExistenciaAlterna, Propiedades, Cliente, Localizacion, CostoInv
          FROM SerieLote
         WHERE Empresa = @Empresa AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Tarima = @TarimaAnterior

        SELECT @RenglonID = @RenglonID + 1
        INSERT InvD (
               ID,     Renglon,  Seccion, RenglonSub, RenglonID,  Sucursal,  Almacen,  Articulo,  SubCuenta,              Cantidad,  Unidad,  Costo,  Tarima)
        SELECT @InvID, @Renglon, 1,       1,          @RenglonID, @Sucursal, @Almacen, @Articulo, ISNULL(@SubCuenta, ''), @Cantidad, @Unidad, @Costo, @TarimaNueva

        INSERT SerieLoteMov (
               Sucursal,  Empresa, Modulo, ID,     RenglonID,  Articulo, SubCuenta, SerieLote, Cantidad,   CantidadAlterna,   Propiedades, Cliente, Localizacion, ArtCostoInv)
        SELECT @Sucursal, Empresa, 'INV',  @InvID, @RenglonID, Articulo, SubCuenta, SerieLote, Existencia, ExistenciaAlterna, Propiedades, Cliente, Localizacion, CostoInv
          FROM SerieLote
         WHERE Empresa = @Empresa AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Tarima = @TarimaAnterior

      END
      FETCH NEXT FROM crTarimaExistencia INTO @Articulo, @SubCuenta, @Cantidad, @Proveedor, @Unidad
    END -- While
    CLOSE crTarimaExistencia
    DEALLOCATE crTarimaExistencia
  END

  IF @InvID IS NOT NULL
  BEGIN
    EXEC spAfectar 'INV', @InvID, @Accion, 'TODO', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    
    SELECT @InvMov = Mov, @InvMovID = MovID FROM Inv WHERE ID = @InvID
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT
  END

  RETURN
END
GO

/**************** spTarimaAlta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTarimaAlta') and type = 'P') drop procedure dbo.spTarimaAlta
GO
CREATE PROCEDURE spTarimaAlta
			@Empresa	varchar(5),
			@Sucursal	int,
			@Usuario	varchar(10),
			@Almacen	varchar(10),
			@FechaRegistro	datetime,
			@FechaCaducidad	datetime,
			@Tarima		varchar(20),
			
    		@Ok		    int           	OUTPUT,
    		@OkRef		varchar(255)  	OUTPUT,

			@PosicionCC varchar(50)     = null 
--//WITH ENCRYPTION
AS BEGIN
 --TASK25114 
 --BUG24540
  DECLARE
    @Articulo	 varchar(20), -- TASK2429
    @SubCuenta   varchar(50),  -- TASK2429
	--Bug 4582
	@Posicion    varchar(10),
	@TPosiciones varchar(10),
	@TTarima     varchar(20)

  SELECT @Articulo  = Articulo, 
         @SubCuenta = SubCuenta,		 
		 @Posicion  = Posicion --Bug 4582
    FROM Tarima 
   WHERE Tarima = @Tarima -- TASK2429

  --Bug 4582
  SELECT @TPosiciones = Posicion,  
         @TTarima     = Tarima 
	FROM Tarima 
   WHERE Articulo = @Articulo 
     AND Estatus = 'ALTA' 
	 AND FechaCaducidad IS NULL 
	 AND Posicion <> @Posicion

  --BUG24540
  IF @FechaCaducidad IS NULL
    SELECT @FechaCaducidad = FechaCaducidad FROM Tarima WHERE Tarima = @Tarima

  --BUG25657
  IF @FechaRegistro IS NULL
    SELECT @FechaRegistro = Alta FROM Tarima WHERE Tarima = @Tarima


  UPDATE Tarima
     SET Estatus = 'ALTA',
         Alta = @FechaRegistro,
         FechaCaducidad = @FechaCaducidad
   WHERE Tarima = @Tarima

  IF @@ROWCOUNT = 0

    INSERT Tarima (
     				Tarima,  Almacen,  Posicion,           Estatus, Alta, Articulo, SubCuenta
		          ) -- TASK2429
             SELECT @Tarima, @Almacen, @PosicionCC /*DefPosicionRecibo*/, 'ALTA',   @FechaRegistro, @Articulo, @SubCuenta --REQ12615 WMS -- TASK2429
               FROM Alm
              WHERE Almacen = @Almacen

     --Bug 4582
	  UPDATE Tarima
		 SET FechaCaducidad = @FechaCaducidad
	   WHERE Tarima = @TTarima
		 AND Posicion = @TPosiciones
		 AND Estatus = 'ALTA'

  RETURN
END
GO

/**************** spInvAfectarInit ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvAfectarInit') and type = 'P') drop procedure dbo.spInvAfectarInit
GO             
CREATE PROCEDURE spInvAfectarInit
				@Accion		varchar(20),
				@Empresa	varchar(5),
				@Sucursal	int,
    				@MovTipo     	varchar(20),
				@OrigenTipo	varchar(10),
				@Origen		varchar(20),
				@OrigenID	varchar(20),
				@IDOrigen	int		OUTPUT,
				@Ok		int		OUTPUT,
				@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 			
  IF @OrigenTipo = 'INV'
    SELECT @IDOrigen = ID FROM Inv    WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Mov = @Origen AND MovID = @OrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
  IF @OrigenTipo = 'VTAS'
    SELECT @IDOrigen = ID FROM Venta  WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Mov = @Origen AND MovID = @OrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONFIRMAR')
  IF @OrigenTipo = 'COMS'
    SELECT @IDOrigen = ID FROM Compra WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Mov = @Origen AND MovID = @OrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
  IF @OrigenTipo = 'PROD'
    SELECT @IDOrigen = ID FROM Prod   WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Mov = @Origen AND MovID = @OrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')

  IF @Accion IN ('RESERVAR', 'DESRESERVAR', 'RESERVARPARCIAL', 'ASIGNAR', 'DESASIGNAR') AND @MovTipo NOT IN ('VTAS.P', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.S', 'INV.SOL', 'INV.SM', 'INV.OT', 'INV.OI')
    SELECT @Ok = 60040
END
GO


/**************** spInvAfectarUtilizarSeleccion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvAfectarUtilizarSeleccion') and type = 'P') drop procedure dbo.spInvAfectarUtilizarSeleccion
GO             
CREATE PROCEDURE spInvAfectarUtilizarSeleccion
				@Modulo		varchar(5),
				@UtilizarID	int,
				@Ok		int		OUTPUT,
				@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 							
        IF @Modulo = 'VTAS' UPDATE VentaD  SET CantidadA = NULL WHERE ID = @UtilizarID AND CantidadA IS NOT NULL ELSE
        IF @Modulo = 'COMS' UPDATE CompraD SET CantidadA = NULL WHERE ID = @UtilizarID AND CantidadA IS NOT NULL ELSE
        IF @Modulo = 'INV'  UPDATE InvD    SET CantidadA = NULL WHERE ID = @UtilizarID AND CantidadA IS NOT NULL ELSE
        IF @Modulo = 'PROD' UPDATE ProdD   SET CantidadA = NULL WHERE ID = @UtilizarID AND CantidadA IS NOT NULL
        IF @@ERROR <> 0 SELECT @Ok = 1
END
GO

/**************** spInvAfectarUtilizarConcluido ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvAfectarUtilizarConcluido') and type = 'P') drop procedure dbo.spInvAfectarUtilizarConcluido
GO             
CREATE PROCEDURE spInvAfectarUtilizarConcluido
				@Empresa		varchar(5),
				@Modulo			varchar(5),
				@FechaEmision		datetime,
				@UtilizarID		int,
				@AfectarMatando		bit,
				@UtilizarEstatus	varchar(15)	OUTPUT,
				@SumaPendiente		float		OUTPUT,
				@FechaConclusion	datetime	OUTPUT,
				@Ok			int		OUTPUT,
				@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 			
        SELECT @UtilizarEstatus = 'CONCLUIDO', @SumaPendiente = 0.0
        IF @AfectarMatando = 1
        BEGIN
	  IF @Modulo = 'VTAS' SELECT @SumaPendiente = Sum(ROUND(ISNULL(CantidadPendiente,0.0), 4)) + Sum(ROUND(ISNULL(CantidadReservada,0.0), 4)) FROM VentaD WHERE ID = @UtilizarID ELSE
	  IF @Modulo = 'COMS' SELECT @SumaPendiente = Sum(ROUND(ISNULL(CantidadPendiente,0.0), 4)) FROM CompraD WHERE ID = @UtilizarID ELSE
	  IF @Modulo = 'INV'  SELECT @SumaPendiente = Sum(ROUND(ISNULL(CantidadPendiente,0.0), 4)) + Sum(ROUND(ISNULL(CantidadReservada,0.0), 4)) FROM InvD   WHERE ID = @UtilizarID ELSE
	  IF @Modulo = 'PROD' SELECT @SumaPendiente = Sum(ROUND(ISNULL(CantidadPendiente,0.0), 4)) + Sum(ROUND(ISNULL(CantidadReservada,0.0), 4)) FROM ProdD  WHERE ID = @UtilizarID
          IF @@ERROR <> 0 SELECT @Ok = 1

	  IF @SumaPendiente > 0.0 SELECT @UtilizarEstatus = 'PENDIENTE'
	END
        IF @UtilizarEstatus = 'CONCLUIDO' SELECT @FechaConclusion = @FechaEmision ELSE IF @UtilizarEstatus <> 'CANCELADO' SELECT @FechaConclusion = NULL
        EXEC spValidarTareas @Empresa, @Modulo, @UtilizarID, @UtilizarEstatus, @Ok OUTPUT, @OkRef OUTPUT
        IF @Modulo = 'VTAS' UPDATE Venta  SET FechaConclusion = @FechaConclusion, Estatus = @UtilizarEstatus WHERE ID = @UtilizarID ELSE
        IF @Modulo = 'COMS' UPDATE Compra SET FechaConclusion = @FechaConclusion, Estatus = @UtilizarEstatus WHERE ID = @UtilizarID ELSE
        IF @Modulo = 'INV'  UPDATE Inv    SET FechaConclusion = @FechaConclusion, Estatus = @UtilizarEstatus WHERE ID = @UtilizarID ELSE
        IF @Modulo = 'PROD' UPDATE Prod   SET FechaConclusion = @FechaConclusion, Estatus = @UtilizarEstatus WHERE ID = @UtilizarID
        IF @@ERROR <> 0 SELECT @Ok = 1
END
GO        

/**************** spInvAfectarDinero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvAfectarDinero') and type = 'P') drop procedure dbo.spInvAfectarDinero
GO             
CREATE PROCEDURE spInvAfectarDinero
    		   @ID                	int,
		   @Accion		char(20),
		   @Base		char(20),
		   
    		   @Empresa	      	char(5),
    		   @Modulo	      	char(5),
    		   @Mov	  	      	char(20),
    		   @MovID             	varchar(20)	OUTPUT,
    		   @MovTipo     	char(20),
    		   @MovMoneda	      	char(10),
    		   @MovTipoCambio	float,
		   @FechaEmision	datetime,
    		   @FechaAfectacion    	datetime,
    		   @FechaConclusion	datetime,

    		   @Concepto	      	varchar(50),
    	 	   @Proyecto	      	varchar(50),
    		   @Usuario	      	char(10),
    		   @Autorizacion      	char(10),
    		   @Referencia	      	varchar(50),
    		   @DocFuente	      	int,
    		   @Observaciones     	varchar(255),
    		   @Estatus           	char(15),
		   @EstatusNuevo	char(15),
    		   @FechaRegistro     	datetime,
    		   @Ejercicio	      	int,
    		   @Periodo	      	int,

		   @ClienteProv		char(10),
		   @EnviarA		int,

		   @SucursalOrigen	int,
    		   
    		   @Ok			int		OUTPUT,
    		   @OkRef		varchar(255)	OUTPUT,
	   
                   @EsCargo        	bit		OUTPUT,
		   @CtaDinero		char(10)	OUTPUT,
		   @Cajero		char(10)	OUTPUT,

		   @DineroMov		char(20)	OUTPUT,
		   @DineroMovID		varchar(20)	OUTPUT,

		   @FormaPagoCambio	varchar(50)	OUTPUT,
                   @CobroCambio         money		OUTPUT, 
		   @DineroImporte	money		OUTPUT,
                   @CobroDelEfectivo    money		OUTPUT, 
		   @CobroSumaEfectivo	money		OUTPUT,
		   @Importe1		money		OUTPUT,
		   @Importe2		money		OUTPUT,
		   @Importe3		money		OUTPUT,
		   @Importe4		money		OUTPUT,
		   @Importe5		money		OUTPUT,
		   @ImporteCambio	money		OUTPUT,
		   @FormaCobro1		varchar(50)	OUTPUT,
		   @FormaCobro2		varchar(50)	OUTPUT,
		   @FormaCobro3		varchar(50)	OUTPUT,
		   @FormaCobro4		varchar(50)	OUTPUT,
		   @FormaCobro5		varchar(50)	OUTPUT,
		   @Referencia1		varchar(50)	OUTPUT,
		   @Referencia2		varchar(50)	OUTPUT,
		   @Referencia3		varchar(50)	OUTPUT,
		   @Referencia4		varchar(50)	OUTPUT,
		   @Referencia5		varchar(50)	OUTPUT,
		   @FormaMoneda		char(10)	OUTPUT,
		   @FormaTipoCambio	float		OUTPUT,
		   @FormaCobroVales	varchar(50)	OUTPUT,
		   @FormaCobroCambio	varchar(50) OUTPUT, --MEJORA5512
		   @InterfazTC			bit,	--REQ13163
		   @TCDelEfectivo		float,	--REQ13163
		   @TCProcesado1		bit,	--REQ13163
		   @TCProcesado2		bit,	--REQ13163
		   @TCProcesado3		bit,	--REQ13163
		   @TCProcesado4		bit,	--REQ13163
		   @TCProcesado5		bit	--REQ13163

--//WITH ENCRYPTION
AS BEGIN
  DECLARE @TCActivarInterfaz1		bit, --REQ13163
		  @TCActivarInterfaz2		bit, --REQ13163
		  @TCActivarInterfaz3		bit, --REQ13163
		  @TCActivarInterfaz4		bit, --REQ13163
		  @TCActivarInterfaz5		bit, --REQ13163
		  @sDineroID				int,
		  @sDineroMov				varchar(20),
		  @sDineroMovID			varchar(20)
		  		  
          IF @InterfazTC = 1 --REQ13163
          BEGIN
            SELECT @TCActivarInterfaz1	= ISNULL(TCActivarInterfaz, 0) FROM FormaPago WHERE FormaPago = @FormaCobro1
            SELECT @TCActivarInterfaz2	= ISNULL(TCActivarInterfaz, 0) FROM FormaPago WHERE FormaPago = @FormaCobro2
            SELECT @TCActivarInterfaz3	= ISNULL(TCActivarInterfaz, 0) FROM FormaPago WHERE FormaPago = @FormaCobro3
            SELECT @TCActivarInterfaz4	= ISNULL(TCActivarInterfaz, 0) FROM FormaPago WHERE FormaPago = @FormaCobro4
            SELECT @TCActivarInterfaz5	= ISNULL(TCActivarInterfaz, 0) FROM FormaPago WHERE FormaPago = @FormaCobro5
            
            IF NULLIF(@FormaCobro1, '') IS NOT NULL AND @TCActivarInterfaz1 = 1 SELECT @FormaCobro1 = NULL, @Importe1 = 0, @Referencia1 = NULL
            IF NULLIF(@FormaCobro2, '') IS NOT NULL AND @TCActivarInterfaz2 = 1 SELECT @FormaCobro2 = NULL, @Importe2 = 0, @Referencia2 = NULL
            IF NULLIF(@FormaCobro3, '') IS NOT NULL AND @TCActivarInterfaz3 = 1 SELECT @FormaCobro3 = NULL, @Importe3 = 0, @Referencia3 = NULL
            IF NULLIF(@FormaCobro4, '') IS NOT NULL AND @TCActivarInterfaz4 = 1 SELECT @FormaCobro4 = NULL, @Importe4 = 0, @Referencia4 = NULL
            IF NULLIF(@FormaCobro5, '') IS NOT NULL AND @TCActivarInterfaz5 = 1 SELECT @FormaCobro5 = NULL, @Importe5 = 0, @Referencia5 = NULL

            SELECT @CobroDelEfectivo = ISNULL(@CobroDelEfectivo, 0) + ISNULL(@TCDelEfectivo, 0)
          END
          
          IF @CobroDelEfectivo <> 0.0 
          BEGIN
            IF @MovTipo IN ('VTAS.VP', 'VTAS.SD') SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1
            IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo 
            EXEC spSaldo @SucursalOrigen /*@Sucursal*/, @Accion, @Empresa, @Usuario, 'CEFE', @MovMoneda, @MovTipoCambio, @ClienteProv, NULL, NULL, NULL,
                         @Modulo, @ID, @Mov, @MovID, @EsCargo, @CobroDelEfectivo, NULL, NULL,
                         @FechaAfectacion, @Ejercicio, @Periodo, 'Saldo a Favor', NULL, 0, 0, 0,
                         @Ok OUTPUT, @OkRef OUTPUT
          END
          IF @DineroImporte <> 0.0
          BEGIN

		    IF @Accion = 'CANCELAR'
			BEGIN
              SELECT @sDineroID = mf.DID, @sDineroMov = mf.DMov, @sDineroMovID = mf.DMovID 
                FROM MovFlujo mf
	            JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mf.DMov = mt.Mov AND mt.Clave IN ('DIN.SCH','DIN.SD')
	            JOIN Dinero d ON mf.DID = d.ID AND Estatus = 'CONCLUIDO'
               WHERE mf.Cancelado = 0 
                 AND mf.Empresa = @Empresa 
                 AND mf.OModulo = @Modulo 
                 AND mf.OID     = @ID
                 AND mf.DModulo = 'DIN'

              IF @sDineroID IS NOT NULL
                SELECT @Ok = 60060, @OkRef = RTRIM(@sDineroMov)+' '+LTRIM(Convert(Char, @sDineroMovID))
			END

            SELECT @CobroSumaEfectivo = 0.0
            IF @Importe1 <> 0.0
            BEGIN
              EXEC spFormaPagoMonTC @FormaCobro1, @Referencia1, @MovMoneda, @MovTipoCambio, @Importe1, @CobroSumaEfectivo OUTPUT, @FormaMoneda OUTPUT, @FormaTipoCambio OUTPUT, @Ok OUTPUT, @FormaCobroVales
		                 /* @Sucursal, @SucursalOrigen, @SucursalDestino */
              EXEC spGenerarDinero @SucursalOrigen, @SucursalOrigen, @SucursalOrigen, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @FormaMoneda, @FormaTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia1, @DocFuente, @Observaciones, 0, 0,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @FormaCobro1, NULL, NULL,
                                   @ClienteProv, @CtaDinero, @Cajero, @Importe1, NULL,
			           NULL, NULL, NULL,
                                   @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                   @Ok OUTPUT, @OkRef OUTPUT
            END
            IF @Importe2 <> 0.0
            BEGIN
              EXEC spFormaPagoMonTC @FormaCobro2, @Referencia2, @MovMoneda, @MovTipoCambio, @Importe2, @CobroSumaEfectivo OUTPUT, @FormaMoneda OUTPUT, @FormaTipoCambio OUTPUT, @Ok OUTPUT, @FormaCobroVales
		                 /* @Sucursal, @SucursalOrigen, @SucursalDestino */
              EXEC spGenerarDinero @SucursalOrigen, @SucursalOrigen, @SucursalOrigen, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @FormaMoneda, @FormaTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia2, @DocFuente, @Observaciones, 0, 0,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @FormaCobro2, NULL, NULL,
                                   @ClienteProv, @CtaDinero, @Cajero, @Importe2, NULL,
			           NULL, NULL, NULL,
                                   @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                   @Ok OUTPUT, @OkRef OUTPUT
            END
            IF @Importe3 <> 0.0
            BEGIN
              EXEC spFormaPagoMonTC @FormaCobro3, @Referencia3, @MovMoneda, @MovTipoCambio, @Importe3, @CobroSumaEfectivo OUTPUT, @FormaMoneda OUTPUT, @FormaTipoCambio OUTPUT, @Ok OUTPUT, @FormaCobroVales
		                 /* @Sucursal, @SucursalOrigen, @SucursalDestino */
              EXEC spGenerarDinero @SucursalOrigen, @SucursalOrigen, @SucursalOrigen, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @FormaMoneda, @FormaTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia3, @DocFuente, @Observaciones, 0, 0,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @FormaCobro3, NULL, NULL,
                                   @ClienteProv, @CtaDinero, @Cajero, @Importe3, NULL,
			           NULL, NULL, NULL,
                                   @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                   @Ok OUTPUT, @OkRef OUTPUT
            END
            IF @Importe4 <> 0.0
            BEGIN
              EXEC spFormaPagoMonTC @FormaCobro4, @Referencia4, @MovMoneda, @MovTipoCambio, @Importe4, @CobroSumaEfectivo OUTPUT, @FormaMoneda OUTPUT, @FormaTipoCambio OUTPUT, @Ok OUTPUT, @FormaCobroVales
		                 /* @Sucursal, @SucursalOrigen, @SucursalDestino */
              EXEC spGenerarDinero @SucursalOrigen, @SucursalOrigen, @SucursalOrigen, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @FormaMoneda, @FormaTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia4, @DocFuente, @Observaciones, 0, 0,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @FormaCobro4, NULL, NULL,
                                   @ClienteProv, @CtaDinero, @Cajero, @Importe4, NULL,
			           NULL, NULL, NULL,
                                   @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                   @Ok OUTPUT, @OkRef OUTPUT
            END
            IF @Importe5 <> 0.0
            BEGIN
              EXEC spFormaPagoMonTC @FormaCobro5, @Referencia5, @MovMoneda, @MovTipoCambio, @Importe5, @CobroSumaEfectivo OUTPUT, @FormaMoneda OUTPUT, @FormaTipoCambio OUTPUT, @Ok OUTPUT, @FormaCobroVales
		                 /* @Sucursal, @SucursalOrigen, @SucursalDestino */
              EXEC spGenerarDinero @SucursalOrigen, @SucursalOrigen, @SucursalOrigen, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @FormaMoneda, @FormaTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia5, @DocFuente, @Observaciones, 0, 0,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @FormaCobro5, NULL, NULL,
                                   @ClienteProv, @CtaDinero, @Cajero, @Importe5, NULL,
			           NULL, NULL, NULL,
                                   @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                   @Ok OUTPUT, @OkRef OUTPUT
            END

            IF ROUND(@CobroCambio, 2) <> 0.0
            BEGIN
              IF ABS(ROUND(@CobroSumaEfectivo, 2)) < ABS(ROUND(@CobroCambio, 2)) SELECT @Ok = 30590
              IF @Ok IS NULL
              BEGIN
                SELECT @FormaPagoCambio = ISNULL(NULLIF(@FormaCobroCambio,''),FormaPagoCambio) FROM EmpresaCfg WHERE Empresa = @Empresa --MEJORA5512
                SELECT @ImporteCambio = -@CobroCambio
                
                EXEC spFormaPagoMonTC @FormaPagoCambio, NULL, @MovMoneda, @MovTipoCambio, @ImporteCambio, NULL, @FormaMoneda OUTPUT, @FormaTipoCambio OUTPUT, @Ok OUTPUT, @FormaCobroVales
                
                SET @ImporteCambio = (ISNULL(@ImporteCambio,0.0) * ISNULL(@MovTipoCambio,0.0)) / ISNULL(@FormaTipoCambio,0.0) --MEJORA5512
                
	  	                   /* @Sucursal, @SucursalOrigen, @SucursalDestino */
                EXEC spGenerarDinero @SucursalOrigen, @SucursalOrigen, @SucursalOrigen, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @FormaMoneda, @FormaTipoCambio,
                                     @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, 'Cambio', @DocFuente, @Observaciones, 0, 0,
                                     @FechaRegistro, @Ejercicio, @Periodo, 
                                     @FormaPagoCambio, NULL, NULL,
                                     NULL, @CtaDinero, @Cajero, @ImporteCambio, NULL,
			             NULL, NULL, NULL,
                                     @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                     @Ok OUTPUT, @OkRef OUTPUT
              END
            END
          END
END
GO

--REQ12615 WMS
/**************** spGenerarConsumoChep ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarConsumoChep') and type = 'P') drop procedure dbo.spGenerarConsumoChep
GO
CREATE PROCEDURE spGenerarConsumoChep
		    @Modulo			varchar(5),
    		@ID             int,			
 		    @Accion			varchar(20),
    		@Empresa        varchar(5),
		    @Sucursal		int,
		    @Usuario		varchar(10),
		    @Mov			varchar(20),
            @MovID			varchar(20),
		    @MovTipo		varchar(20),
		    @Almacen		varchar(10),
		    @MovDestino		varchar(20),

    		@Ok             int         OUTPUT,
    		@OkRef          varchar(255)OUTPUT
--//WITH ENCRYPTION

AS BEGIN 
  DECLARE
    @OrdenID			int,
    @MovDestinoID		varchar(20),
    @Posicion			varchar(10),
    @Cantidad			float,
    @TarimaChep			varchar(20),
    @CantidadTarima		int,
    @CantidadEstibas	int,
    @Renglon			int,
    @RenglonID			int,
    @ArticuloD			varchar(20),
    @SucursalD			int,
    @AlmacenD			varchar(10),
    @Unidad				varchar(50),
    @FechaCaducidad		datetime,
    @Precio				float,
    @CantidadD			float


  IF @Accion = 'CANCELAR'
    SELECT @OrdenID = ID FROM Inv WHERE Mov = @MovDestino AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
  ELSE BEGIN  
    IF @Accion = 'RESERVARPARCIAL' SELECT @Accion = 'AFECTAR'
    IF @Modulo = 'VTAS' AND EXISTS (SELECT * FROM CteTarimaChep WHERE Cliente IN (SELECT Cliente FROM Venta WHERE ID = @ID) AND Articulo IN (SELECT Articulo FROM VentaD WHERE ID = @ID))
    BEGIN

      INSERT Inv (
             Empresa,  Sucursal,  Mov,       Almacen,  FechaEmision, Concepto, Referencia, Proyecto, UEN, Usuario, Estatus,       Moneda, TipoCambio, OrigenTipo, Origen, OrigenID, PosicionWMS, Agente)
      SELECT @Empresa, @Sucursal, @MovDestino, @Almacen, FechaEmision, Concepto, Referencia, Proyecto, UEN, @Usuario, 'SINAFECTAR', Moneda, TipoCambio, @Modulo,    @Mov,   @MovID, PosicionWMS, Agente
        FROM Venta
       WHERE ID = @ID
      SELECT @OrdenID = @@IDENTITY      
	  
	  SET @RenglonID = 1
      SET @Renglon = 2048

	  DECLARE crCheap CURSOR FOR
       SELECT SUM(d.Cantidad) / (t.CantidadTarima * t.CantidadEstibas), t.TarimaChep, t.CantidadTarima, t.CantidadEstibas, d.Sucursal, d.Almacen, d.Unidad, NULL, AVG(Precio), SUM(d.Cantidad)
         FROM VentaD d
         JOIN Venta v ON d.ID = v.ID
         JOIN CteTarimaChep t
           ON d.Articulo = t.Articulo AND d.Unidad = t.UnidadVenta AND v.Cliente = t.Cliente
        WHERE d.ID = @ID AND d.Almacen = @Almacen AND NULLIF(RTRIM(Tarima), '') IS NULL
          AND d.Articulo IN (SELECT Articulo FROM VentaD WHERE ID = @ID)
        GROUP BY d.Sucursal,  d.Almacen,  d.Articulo, d.Unidad, t.TarimaChep, t.CantidadTarima, t.CantidadEstibas

	  OPEN crCheap
	  FETCH NEXT FROM crCheap INTO @Cantidad, @TarimaChep, @CantidadTarima, @CantidadEstibas, @SucursalD, @AlmacenD, @Unidad, @FechaCaducidad, @Precio, @CantidadD
	  WHILE @@FETCH_STATUS = 0
	  BEGIN
	    SELECT @Cantidad =  ROUND((@Cantidad + .49),0)	    

          INSERT InvD (
                 ID,       Renglon, RenglonSub, RenglonID, Sucursal,  Almacen,  Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario, Costo)
          SELECT @OrdenID, @Renglon, 0, @RenglonID, @SucursalD, @AlmacenD, @TarimaChep, NULL, @Cantidad, @Unidad, 1, @CantidadTarima, @Precio
          
	      SELECT @Renglon = @Renglon + 2048
	      SELECT @RenglonID = @RenglonID + 1
	      
		FETCH NEXT FROM crCheap INTO @Cantidad, @TarimaChep, @CantidadTarima, @CantidadEstibas, @SucursalD, @AlmacenD, @Unidad, @FechaCaducidad, @Precio, @CantidadD
	  END
	  CLOSE crCheap
      DEALLOCATE crCheap           
    END 
  END

  IF @OrdenID IS NOT NULL AND @OK IS NULL
  BEGIN
    EXEC spAfectar 'INV', @OrdenID, @Accion, 'TODO', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    
    SELECT @MovDestino = Mov, @MovDestinoID = MovID FROM Inv WHERE ID = @OrdenID
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @OrdenID, @MovDestino, @MovDestinoID, @Ok OUTPUT
  END
  RETURN
END
GO

--REQ12615 WMS
/**************** spWMS *****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMS') and type = 'P') drop procedure dbo.spWMS
GO
CREATE PROCEDURE spWMS
		    @Modulo				varchar(5),
    		@ID				    int,			
 		    @Accion				varchar(20),
    		@Empresa			varchar(5),
		    @Sucursal			int,
		    @Usuario			varchar(10),
		    @Mov				varchar(20),
            @MovID				varchar(20),
		    @MovTipo			varchar(20),
		    @Almacen			varchar(10),
		    @FechaEmision		datetime,
		    @Proyecto	     	varchar(50),

    		@Ok               	int			OUTPUT,
    		@OkRef            	varchar(255)OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @ModuloDestino			varchar(5),
    @MovDestino				varchar(20),
    @ModuloOrigen			varchar(20),
    @Estatus				varchar(20),
    @EstatusEntarimado		varchar(20),
    @SubClave				varchar(20),
	--CAMBIOS USB 
	@ArtTipo VARCHAR(20),
	@CostoPromedio MONEY,
	@SucursalAlmacen INT,
	@ArtMoneda CHAR(10),
	@ArtTipoCambio FLOAT,
	@Articulo VARCHAR(20), 
	@SubCuenta VARCHAR(50), 
	@AfectarAlmacen VARCHAR(10), 
	@AfectarAlmacenDestino VARCHAR(10), 
	@EsCargo BIT, 
	@CostoInvTotal MONEY, 
	@AfectarCantidad FLOAT, 
	@Factor FLOAT, 
	@Ejercicio INT, 
	@Periodo INT, 
	@AplicaMov VARCHAR(20), 
	@AplicaMovID VARCHAR(20), 
	@Renglon FLOAT, 
	@RenglonID INT, 
	@RenglonSub INT, 
	@Tarima VARCHAR(20),
	@SerieLote VARCHAR(50)

  SELECT @SubClave = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov AND Clave = @MovTipo
  IF @Modulo = 'VTAS'
    SELECT @Estatus = Estatus FROM Venta WHERE ID = @ID
  ELSE
  IF @Modulo = 'COMS'
    SELECT @Estatus = Estatus FROM Compra WHERE ID = @ID
  ELSE    
  IF @Modulo = 'INV'
    SELECT @Estatus = Estatus FROM Inv WHERE ID = @ID
  ELSE
  IF @Modulo = 'TMA'
    SELECT @Estatus = Estatus FROM TMA WHERE ID = @ID

  IF @Modulo = 'PROD'
    SELECT @Estatus = Estatus FROM Prod WHERE ID = @ID

  IF @Modulo = 'TMA' SELECT @Modulo = 'WMS'
  IF @ModuloDestino = 'TMA' SELECT @ModuloDestino = 'WMS'

  IF EXISTS (SELECT TOP 1 * FROM AlmSugerirSurtidoTarima WHERE Almacen = @Almacen AND Modulo = @Modulo AND Mov = @Mov)
    SELECT @ModuloDestino = ModuloDestino, @MovDestino = MovDestino, @EstatusEntarimado = Estatus FROM AlmSugerirSurtidoTarima WHERE Almacen = @Almacen AND Modulo = @Modulo AND Mov = @Mov

  IF @Modulo = 'WMS' SELECT @Modulo = 'TMA'
  IF @ModuloDestino = 'WMS' SELECT @ModuloDestino = 'TMA'

  --IF @MovTipo = 'INV.T' SELECT @SubClave='INV.TMA' --BUG3652 --Se quita esta instruccion que carga la variable con codigo duro

	IF @MovTipo = 'INV.T'
	SELECT @SubClave = SubClave FROM MovTipo WHERE Modulo=@Modulo AND Mov=@Mov  --Se agrega esta nueva donde saca el dato de la tabla MovTipo
	--SELECT @SubClave='INV.TMA' --BUG3652

  IF (SELECT Clave FROM MovTipo WHERE Modulo = @ModuloDestino AND Mov = @MovDestino) IN ('INV.SOL') AND @EstatusEntarimado = @Estatus OR
     (SELECT Clave FROM MovTipo WHERE Modulo = @ModuloDestino AND Mov = @MovDestino) IN ('INV.SOL') AND @Accion = 'CANCELAR' OR
      @MovTipo = 'INV.T' AND @SubClave = 'INV.TMA' AND @Modulo = 'INV' AND @Accion <> 'CANCELAR'
  BEGIN
--    IF @Modulo = 'COMS' -- TASK2429
--    BEGIN
--      IF EXISTS(SELECT * FROM Art WHERE Articulo IN(SELECT Articulo FROM CompraD WHERE ID = @ID) AND ISNULL(TipoOpcion, 'No')  = 'Si')
--      BEGIN
--        SELECT @Ok = 10037, @OkRef = 'Artículo - ' + (SELECT TOP 1 c.Articulo FROM CompraD c JOIN Art a ON c.Articulo = a.Articulo WHERE c.ID = @ID AND ISNULL(a.TipoOpcion, 'No') = 'Si')
--      END
--    END
--    ELSE
--    IF @Modulo = 'INV'
--    BEGIN
--      IF EXISTS(SELECT * FROM Art WHERE Articulo IN(SELECT Articulo FROM InvD WHERE ID = @ID) AND ISNULL(TipoOpcion, 'No')  = 'Si')
--      BEGIN
--        SELECT @Ok = 10037, @OkRef = 'Artículo - ' + (SELECT TOP 1 i.Articulo FROM InvD i JOIN Art a ON i.Articulo = a.Articulo WHERE i.ID = @ID AND ISNULL(a.TipoOpcion, 'No') = 'Si')
--      END
--    END
    --Se comenta esta seccion nuevamente por el cambio de Rama
	--IF @MovTipo = 'INV.T' AND @SubClave = 'INV.TMA' AND @Modulo = 'INV' AND @Accion = 'AFECTAR' 
	--BEGIN
	--	DECLARE crInvD CURSOR LOCAL STATIC FOR
	--	SELECT Alm.Sucursal, Art.MonedaPrecio, dbo.fnTipoCambio(Art.MonedaPrecio), Art.Tipo, InvD.Articulo, InvD.SubCuenta, InvD.Almacen,  Inv.AlmacenDestino, 0 ' EsCargo', ISNULL(SerieLoteMov.Cantidad, InvD.Cantidad), 1, YEAR(@FechaEmision), MONTH(@FechaEmision), InvD.Aplica, InvD.AplicaID, InvD.Renglon, InvD.RenglonID, InvD.RenglonSub, InvD.Tarima, SerieLoteMov.SerieLote
	--	FROM Inv
	--	JOIN InvD ON Inv.ID=InvD.ID
	--	JOIN Art ON InvD.Articulo=Art.Articulo
	--	JOIN Alm ON InvD.Almacen=Alm.Almacen 
	--	LEFT JOIN SerieLoteMov ON InvD.ID=SerieLoteMov.ID AND InvD.RenglonID=SerieLoteMov.RenglonID AND InvD.Articulo=SerieLoteMov.Articulo AND SerieLoteMov.Modulo=@Modulo
	--	WHERE Inv.ID=@ID
	--	OPEN crInvD
	--	FETCH NEXT FROM crInvD INTO @SucursalAlmacen, @ArtMoneda, @ArtTipoCambio, @ArtTipo, @Articulo, @SubCuenta, @AfectarAlmacen, @AfectarAlmacenDestino, @EsCargo, @AfectarCantidad, @Factor, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, @Renglon, @RenglonID, @RenglonSub, @Tarima, @SerieLote
	--	WHILE @@FETCH_STATUS=0
	--	BEGIN

	--			IF @ArtTipo NOT IN ('Serie', 'Lote')
	--			SELECT @CostoInvTotal = Saldo FROM SaldoU  WHERE Cuenta = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,ISNULL(SubCuenta,'')) AND SubGrupo = @Tarima
	--			ELSE
	--			SELECT  @CostoInvTotal = (CostoPromedio*@AfectarCantidad) FROM SerieLote WHERE Empresa=@Empresa AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,ISNULL(SubCuenta,'')) AND Almacen=@AfectarAlmacen AND SerieLote=@SerieLote AND Tarima = @Tarima

	--			--Se había comentado por instrucciones de Beto Rivera ya que se cargaba y abonaba dos veces por las transferencias que entraban dos veces por la carga de la variable @SubClave en código duro
	--			EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, @ArtTipoCambio, @Articulo, @SubCuenta, @AfectarAlmacen, NULL, 
	--			@Modulo, @ID, @Mov, @MovID, @EsCargo, 0, @AfectarCantidad, @Factor,
	--			@FechaEmision, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
	--			@Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @SubGrupo = @Tarima

	--			EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, @ArtTipoCambio, @Articulo, @SubCuenta, @AfectarAlmacen, NULL, 
	--			@Modulo, @ID, @Mov, @MovID, 1, 0, @AfectarCantidad, @Factor,
	--			@FechaEmision, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
	--			@Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @SubGrupo = NULL

	--	FETCH NEXT FROM crInvD INTO @SucursalAlmacen, @ArtMoneda, @ArtTipoCambio, @ArtTipo, @Articulo, @SubCuenta, @AfectarAlmacen, @AfectarAlmacenDestino, @EsCargo, @AfectarCantidad, @Factor, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, @Renglon, @RenglonID, @RenglonSub, @Tarima, @SerieLote
	--	END
	--	CLOSE crInvD
	--	DEALLOCATE crInvD
	--END 

    IF @Ok IS NULL
    BEGIN
      EXEC spGenerarOrdenEntarimado @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @Almacen, @Ok OUTPUT, @OkRef OUTPUT
    END
  END

  IF (SELECT LEFT(Clave,3) FROM MovTipo WHERE Modulo = @ModuloDestino AND Mov = @MovDestino) = 'TMA' OR (SELECT Clave FROM MovTipo WHERE Modulo = @ModuloDestino AND Mov = @MovDestino) = 'INV.EI' --IN ('TMA.OSUR','TMA.SRADO','TMA.SADO')
    EXEC spGenerarOrdenTarimaAcomodo 'RECIBO', @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @FechaEmision, @Proyecto, @Almacen, @Ok OUTPUT, @OkRef OUTPUT, @GenerarOrden = 1

  IF (SELECT Clave FROM MovTipo WHERE Modulo = @ModuloDestino AND Mov = @MovDestino) IN ('INV.S') AND (SELECT SubClave FROM MovTipo WHERE Modulo = @ModuloDestino AND Mov = @MovDestino) = 'INV.SCHEP'
    EXEC spGenerarConsumoChep @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @Almacen, @MovDestino, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO

--REQ12615 WMS
/**************** spFlujoWMS *****************/
if exists (select * from sysobjects where id = object_id('dbo.spFlujoWMS') and type = 'P') drop procedure dbo.spFlujoWMS
GO
CREATE PROCEDURE spFlujoWMS
		    @Modulo				varchar(5),
    		@ID               	int,			
 		    @Accion				varchar(20),
    		@Empresa          	varchar(5),
		    @Sucursal			int,
		    @Usuario			varchar(10),
		    @Mov				varchar(20),
            @MovID				varchar(20),
		    @MovTipo			varchar(20),
		    @Almacen			varchar(10),
		    @FechaEmision		datetime,
		    @Proyecto	      	varchar(50),
		    @Tarima				varchar(20),
		    @Articulo			varchar(20),

    		@Ok               	int           	OUTPUT,
    		@OkRef            	varchar(255)  	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
	DECLARE
		@PosicionActual                     varchar(10),--Bug 22831
		@PosicionReal                       varchar(10)  

	IF @MovTipo = 'INV.A' AND @Accion = 'AFECTAR' 
	BEGIN
	
		SELECT @PosicionActual = PosicionActual, @PosicionReal = PosicionReal
			FROM InvD
			WHERE ID = @ID AND Articulo = @Articulo AND Tarima = @Tarima

		IF @PosicionActual <> @PosicionReal AND ISNULL(@PosicionActual,'') <> '' AND ISNULL(@PosicionReal,'') <> ''
			UPDATE Tarima SET Posicion = @PosicionReal WHERE Tarima = @Tarima
	END

	IF @MovTipo = 'INV.A' AND @Accion = 'CANCELAR' 
	BEGIN
		SELECT @PosicionActual = PosicionActual, @PosicionReal = PosicionReal
			FROM InvD
			WHERE ID = @ID AND Articulo = @Articulo AND Tarima = @Tarima

		IF @PosicionActual <> @PosicionReal AND ISNULL(@PosicionActual,'') <> '' AND ISNULL(@PosicionReal,'') <> ''
			UPDATE Tarima SET Posicion = @PosicionActual WHERE Tarima = @Tarima
	END

      IF @Modulo = 'INV' AND @MovTipo = 'INV.T'
        SELECT @Almacen = AlmacenDestino FROM INV WHERE ID = @ID

      EXEC spWMS @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @Almacen, @FechaEmision, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

      IF @Ok IS NULL
      BEGIN
	    IF @Modulo = 'VTAS'
          UPDATE Tarima 
             SET Baja = @FechaEmision,
                 Estatus = 'BAJA'
           WHERE Tarima IN(SELECT d.Tarima 
                             FROM VentaD d JOIN Tarima t 
                               ON d.Tarima = t.Tarima JOIN ArtDisponibleTarima a 
                               ON a.Tarima = t.Tarima 
                            WHERE d.ID = @ID AND t.Estatus = 'ALTA' 
							--AND ISNULL(a.Disponible,0) = 0) --CAMBIO USB (DESENTARIMAR)
                              AND d.Tarima NOT IN(SELECT TarimaSurtido FROM TMA WHERE Estatus IN('PENDIENTE','PORPROCESAR'))
							GROUP BY d.Tarima --CAMBIO USB (DESENTARIMAR)
							HAVING SUM(ISNULL(a.Disponible,0)) = 0) --CAMBIO USB (DESENTARIMAR)
	    ELSE
	    IF @Modulo = 'COMS'
          UPDATE Tarima 
             SET Baja = @FechaEmision,
                 Estatus = 'BAJA'
           WHERE Tarima IN(SELECT d.Tarima 
                             FROM CompraD d JOIN Tarima t 
                               ON d.Tarima = t.Tarima JOIN ArtDisponibleTarima a 
                               ON a.Tarima = t.Tarima 
                            WHERE d.ID = @ID AND t.Estatus = 'ALTA' AND ISNULL(a.Disponible,0) = 0
                              AND d.Tarima NOT IN(SELECT TarimaSurtido FROM TMA WHERE Estatus IN('PENDIENTE','PORPROCESAR')))
	    ELSE
	    IF @Modulo = 'INV'
          UPDATE Tarima 
             SET Baja = @FechaEmision,
                 Estatus = 'BAJA'
           WHERE Tarima IN(SELECT d.Tarima 
                             FROM InvD d JOIN Tarima t 
                               ON d.Tarima = t.Tarima JOIN ArtDisponibleTarima a 
                               ON a.Tarima = t.Tarima 
                            WHERE d.ID = @ID AND t.Estatus = 'ALTA' 
							--AND ISNULL(a.Disponible,0) = 0) --CAMBIO USB (DESENTARIMAR)
                              AND d.Tarima NOT IN(SELECT TarimaSurtido FROM TMA WHERE Estatus IN('PENDIENTE','PORPROCESAR'))
							GROUP BY d.Tarima --CAMBIO USB (DESENTARIMAR)
							HAVING SUM(ISNULL(a.Disponible,0)) = 0) --CAMBIO USB (DESENTARIMAR)
	    ELSE
	    IF @Modulo = 'PROD'
          UPDATE Tarima 
             SET Baja = @FechaEmision,
                 Estatus = 'BAJA'
           WHERE Tarima IN(SELECT d.Tarima 
                             FROM ProdD d JOIN Tarima t 
                               ON d.Tarima = t.Tarima JOIN ArtDisponibleTarima a 
                               ON a.Tarima = t.Tarima 
                            WHERE d.ID = @ID AND t.Estatus = 'ALTA' AND ISNULL(a.Disponible,0) = 0
                              AND d.Tarima NOT IN(SELECT TarimaSurtido FROM TMA WHERE Estatus IN('PENDIENTE','PORPROCESAR')))
	  END
--select @Ok = 1
  RETURN
END
GO


/**************** spCompraEntradaMaquilaGenerarEntradaProd ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraEntradaMaquilaGenerarEntradaProd') and type = 'P') drop procedure dbo.spCompraEntradaMaquilaGenerarEntradaProd
GO
CREATE PROCEDURE spCompraEntradaMaquilaGenerarEntradaProd
                           @Accion  varchar(20),
                           @Empresa char(5),
                           @Sucursal      int,
                               @ID          int,
                           @Mov           varchar(20),
                           @MovID   varchar(20),
                           @Ok            int         OUTPUT,
                           @OkRef   varchar(255)      OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EPID         int,
    @SID          int,
    @EPMov        varchar(20),
    @SPMov        varchar(20),
    @SPMovID            varchar(20),
    @EPMovID            varchar(20),
    @EPEstatus          varchar(20),
    @Articulo           varchar(20),
    @SubCuenta          varchar(50),
    @Cantidad           float,
    @Costo        float,
    @Fecha              datetime,
    @Posicion           varchar(10),
    @PosicionSurtido    varchar(10),
    @Almacen            varchar(10),
    @ConsumoID          int,
    @AlmacenProv        varchar(10),
    @Proveedor          varchar(10),
    @Usuario            varchar(10)
   
  SELECT @Usuario = Usuario,@Almacen = Almacen, @Proveedor = Proveedor FROM Compra WHERE ID = @ID
  SELECT @AlmacenProv = Almacen  FROM Prov WHERE Proveedor = @Proveedor
  SELECT @Fecha = dbo.fnFechaSinHora(GETDATE())
  SELECT @EPMov = InvEntradaProducto, @SPMov = InvSalidaDiversa FROM EmpresaCfgMov WHERE Empresa = @Empresa
 
  IF NOT EXISTS(SELECT * FROM ArtMaterial  a JOIN CompraD c ON a.Articulo = c.ArticuloMaquila WHERE c.ID = @ID)
    SELECT @EPMov = InvEntradaDiversa FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @Posicion = DefPosicionRecibo, @PosicionSurtido = DefPosicionSurtido from Alm WHERE Almacen = @Almacen
 
  IF @Ok IS NULL AND @Accion = 'AFECTAR'
  BEGIN
    INSERT Inv(Empresa, Mov,     FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Estatus,      Almacen, OrigenTipo, Origen, OrigenID, Sucursal, SucursalDestino, MovMES)
    SELECT     Empresa, @EPMov,  @Fecha,       Concepto, Proyecto, Moneda, TipoCambio, Usuario, Referencia, 'SINAFECTAR', Almacen, 'COMS',     Mov,    MovID,    Sucursal, Sucursal,        0
      FROM Compra
     WHERE ID = @ID
    SELECT @EPID = SCOPE_IDENTITY()
    IF @@ERROR <> 0 SET @Ok = 1
    IF @Ok IS NULL
    BEGIN
      INSERT InvD(ID,    Renglon,   RenglonID,    RenglonTipo,                Cantidad,   Almacen,   Codigo,   Articulo,          Unidad,    Sucursal, Posicion, Costo,    CantidadInventario)
      SELECT      @EPID, d.Renglon, d.RenglonID,  dbo.fnRenglonTipo(a.Tipo),  d.Cantidad, @Almacen, d.Codigo, d.ArticuloMaquila, a.Unidad,  d.Sucursal, @Posicion, d.Costo, (dbo.fnArtUnidadFactor(@Empresa, d.ArticuloMaquila,a.UnidadCompra)*d.Cantidad)
        FROM CompraD d JOIN Art a ON d.ArticuloMaquila = a.Articulo
       WHERE ID = @ID
      IF @@ERROR <> 0 SET @Ok = 1
    END
    IF @Ok IS NULL
    BEGIN
      INSERT SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
      SELECT              @Empresa, 'INV', @EPID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad
        FROM SerieLoteMov WHERE Modulo = 'COMS' AND ID = @ID AND Empresa =@Empresa
    END   
    IF @Ok IS NULL AND EXISTS(SELECT * FROM InvD d JOIN ArtMaterial a ON a.Articulo = d.Articulo AND d.ID = @EPID)
      EXEC @ConsumoID = spAfectar 'INV', @EPID, 'AFECTAR', 'TODO',NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    ELSE
    BEGIN
      INSERT Inv(Empresa, Mov,     FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Estatus,      Almacen, OrigenTipo, Origen, OrigenID, Sucursal, SucursalDestino, MovMES)
      SELECT     Empresa, @SPMov,  @Fecha,       Concepto, Proyecto, Moneda, TipoCambio, Usuario, Referencia, 'SINAFECTAR', @AlmacenProv, 'COMS',     Mov,    MovID,    Sucursal, Sucursal,        0
        FROM Compra
       WHERE ID = @ID
      SELECT @SID = SCOPE_IDENTITY()
      IF @@ERROR <> 0 SET @Ok = 1   
      IF @Ok IS NULL
      BEGIN
        INSERT InvD(ID,    Renglon,   RenglonID,    RenglonTipo,                Cantidad,   Almacen,     Codigo,   Articulo,          Unidad,    Sucursal,   Posicion, Costo,            CantidadInventario)
        SELECT      @SID, d.Renglon, d.RenglonID,  dbo.fnRenglonTipo(a.Tipo),  d.Cantidad, @AlmacenProv, d.Codigo, d.ArticuloMaquila, a.Unidad,  d.Sucursal, @PosicionSurtido, d.Costo,  (dbo.fnArtUnidadFactor(@Empresa, d.ArticuloMaquila,a.UnidadCompra)*d.Cantidad)
          FROM CompraD d JOIN Art a ON d.ArticuloMaquila = a.Articulo
         WHERE ID = @ID
        IF @@ERROR <> 0 SET @Ok = 1
      END
      IF @Ok IS NULL
      BEGIN
        INSERT SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
        SELECT              @Empresa, 'INV', @SID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad
          FROM SerieLoteMov WHERE Modulo = 'COMS' AND ID = @ID AND Empresa =@Empresa 
        IF @@ERROR <> 0 SET @Ok = 1 
      END   
      IF @Ok IS NULL
      BEGIN
        EXEC  spAfectar 'INV', @SID, 'AFECTAR', 'TODO',NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
          SELECT @SPMovID = MovID FROM Inv WHERE ID = @SID
        IF @Ok IS NULL
          EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa,  'COMS', @ID, @Mov, @MovID, 'INV', @SID, @SPMov, @SPMovID, @Ok OUTPUT        
      END
      IF @Ok BETWEEN 80030 AND 81000
        SET @Ok = NULL 
      IF @Ok BETWEEN 80030 AND 81000
        SET @Ok = NULL         
      IF @Ok IS NULL     
        EXEC  spAfectar 'INV', @EPID, 'AFECTAR', 'TODO',NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      SELECT @EPMov = Mov , @EPMovID = MovID FROM Inv WHERE ID = @EPID
      IF @Ok IS NULL
        EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa,  'COMS', @ID, @Mov, @MovID, 'INV', @EPID, @EPMov, @EPMovID, @Ok OUTPUT          
    END 
    IF @Ok BETWEEN 80030 AND 81000
      SET @Ok = NULL 
    IF @Ok IS NULL
      UPDATE Inv SET Almacen = @AlmacenProv WHERE ID = @ConsumoID
    IF @Ok IS NULL      
      UPDATE InvD SET Almacen = @AlmacenProv, Posicion = @PosicionSurtido, cantidadInventario= dbo.fnArtUnidadFactor(@Empresa, Articulo,Unidad)*Cantidad   WHERE ID = @ConsumoID 
    IF @Ok IS NULL AND @ConsumoID IS NOT NULL
    BEGIN
      EXEC spAfectar 'INV', @ConsumoID, 'AFECTAR', 'TODO',NULL,@Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok BETWEEN 80030 AND 81000
        SET @Ok = NULL
    END 
    SELECT @EPMov = Mov , @EPMovID = MovID FROM Inv WHERE ID = @EPID
    IF @Ok IS NULL
      EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa,  'COMS', @ID, @Mov, @MovID, 'INV', @EPID, @EPMov, @EPMovID, @Ok OUTPUT    
  END
  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @EPID = ID FROM Inv WHERE Origen = @Mov AND OrigenID = @MovID AND Empresa = @Empresa AND OrigenTipo = 'COMS'
    IF @EPID IS NOT NULL
    BEGIN
      EXEC  spAfectar 'INV', @EPID, 'CANCELAR', 'TODO', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      EXEC spMovFlujo @Sucursal, 'CANCELAR', @Empresa,  'COMS', @ID, @Mov, @MovID, 'INV', @EPID, @EPMov, @EPMovID, @Ok OUTPUT
    END  
  END
  RETURN
END
GO


/**************** spInvAfectar2 ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spInvAfectar2') and type = 'P') drop procedure dbo.spInvAfectar2
GO             
CREATE PROCEDURE spInvAfectar2

    		   @ID                		int,
		   @Accion			varchar(20),
		   @Base			varchar(20),
    		   @Empresa	      		varchar(5),
		   @Usuario			varchar(10),
    		   @Modulo	      		varchar(5),
    		   @Mov	  	      		varchar(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		varchar(20),
    		   @MovMoneda	      		varchar(10),
    		   @MovTipoCambio	 	float,
     	    	   @Estatus	 	      	varchar(15),
     	    	   @EstatusNuevo	      	varchar(15),
		   @FechaEmision		datetime,
		   @FechaRegistro		datetime,
    		   @FechaAfectacion    		datetime,
		   @Conexion			bit,
		   @SincroFinal			bit,
	    	   @Sucursal			int,
		   @UtilizarID			int,
    		   @UtilizarMovTipo    		varchar(20),
    		   @EsEcuador                   bit,
    		   @IDGenerar                   int,
    		   @GenerarOP                   bit,
    		   @ClienteProv                 varchar(10), 
    		   @ServicioSerie               varchar(20),  
    		   @OrigenTipo                  varchar(10),  		   
		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,
		   --REQ16092
		   @OPORT			bit,
		   @SubClave		        varchar(20),
		   @Origen			varchar(20), 
		   @OrigenID		        varchar(20),
		   @CfgVentaPuntosEnVales       bit,
		   @AlmacenDestinoOriginal      varchar(20),
		   @Almacen                     varchar(20),
		   @Referencia                  varchar(50),
		   @IDTransito                  int,
		   @ContID                      int,
		   @Estacion                    int,
		   @TransitoSucursal            int,
		   @TransitoMov                 varchar(20),
		   @TransitoMovID               varchar(20),
		   @TransitoEstatus             varchar(15),
		   @TraspasoExpressMov          varchar(20), 
		   @TraspasoExpressMovID        varchar(20),
		   @CFGProdInterfazInfor        bit,
		   
		   --BUG3652
		   @OrigenMovTipo               varchar(20),
      	   @Proyecto	      		    varchar(50),
		   @Tarima                      varchar(20),
		   @Articulo                    varchar(20)
		           
--//WITH ENCRYPTION
AS BEGIN
    DECLARE	@OID				int,
            @PosicionD          char(10),--Task 19162
            @WMS                bit,
            @AlmacenDestino     varchar(10),
            @IDOrden            int,
		    @CfgEspacios        bit
		    
    SELECT @WMS = NULLIF(WMS,''),
           @CfgEspacios = Espacios
      FROM EmpresaGral
     WHERE Empresa = @Empresa

	--BUG2826 (Se cancela esa parte del código, ya que se procesa en el spWMS)
	/*
	IF @WMS = 1 AND @Modulo = 'INV' AND @MovTipo IN('INV.T','INV.EI') AND @Accion = 'AFECTAR' AND @Ok IN (NULL, 80030)  --Task 19162
    BEGIN
      SELECT @AlmacenDestino = NULLIF(AlmacenDestino,''),@PosicionD = NULLIF(PosicionDWMS,'')
        FROM Inv 
       WHERE ID= @ID
      
      IF EXISTS(SELECT * FROM Alm WHERE Almacen = @AlmacenDestino AND WMS = 1)
      BEGIN
        IF @PosicionD IS NOT NULL 
           EXEC spGenerarOrdenEntarimado @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @AlmacenDestino, @Ok OUTPUT, @OkRef OUTPUT
      END
      
      IF @MovTipo = 'INV.EI' 
        UPDATE InvD SET Tarima = NULL WHERE ID = @ID--Cambio WMS
      
      IF @Modulo = 'INV' AND @Accion = 'CANCELAR' AND @MovTipo = 'INV.E'
      BEGIN
        SELECT @IDOrden = ID FROM Inv WHERE Origen = @Mov AND OrigenID = @MovID
        IF @IDOrden IS NOT NULL
          UPDATE Inv SET OrigenTipo = @Modulo WHERE ID = @IDOrden
      END
    END
	*/
    IF @Ok IS NULL AND @Accion NOT IN('CANCELAR')
    BEGIN
    IF EXISTS(SELECT * FROM SerieLoteMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND Sucursal NOT IN (SELECT Sucursal  FROM Alm WHERE Almacen = @Almacen))
          UPDATE SerieLoteMov 
             SET Sucursal = (SELECT Sucursal  FROM Alm WHERE Almacen = @Almacen)
           WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID
    END
    /* TransferirA */
    IF @MovTipo IN ('VTAS.D', 'VTAS.DCR') AND @Ok IN (NULL, 80030) 
    BEGIN
      SELECT @Ok = NULL
      IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID AND ISNULL(NULLIF(RTRIM(TransferirA), ''), Almacen) <> Almacen)
        EXEC spInvTransferirA @Empresa, @Sucursal, @Usuario, @Accion, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT
    END	

    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spInvFacturaFlexibleAfectar @Empresa, @Sucursal, @Usuario, @Accion, @Estatus, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT

    IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) AND @EsEcuador = 1
      EXEC spEcuadorAutorizacion @Sucursal, @Empresa, @Modulo, @ID, @Accion, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spGTInvAfectar @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
      	     	          @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal,
			  @UtilizarID, @UtilizarMovTipo, @IDGenerar,
                          @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spInvFacturaProrrateadaAfectar @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
      	     	                          @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal,
			                  @UtilizarID, @UtilizarMovTipo,
                                          @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spInvPedidoProrrateadoAfectar  @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
      	     	                          @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal,
			                  @UtilizarID, @UtilizarMovTipo,
                                          @Ok OUTPUT, @OkRef OUTPUT
                                          
    IF @MovTipo = 'VTAS.S' AND @GenerarOP = 1 AND @EstatusNuevo IN ('PENDIENTE', 'CANCELADO') AND @Estatus <> @EstatusNuevo
      EXEC spAutoGenerarOP @Sucursal, @Accion, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Empresa, @Usuario, @FechaRegistro, @ClienteProv, @ServicioSerie, @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo = 'INV.EP' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL AND @Accion = 'CANCELAR'
      EXEC spInvEntradaProductoCancelarConsumoMaterial @Accion, @Empresa, @ID, @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo = 'INV.CM' AND @EstatusNuevo = 'CONCLUIDO' AND @Ok IS NULL AND @OrigenTipo = 'INV/EP'
      EXEC spInvConsumoMaterialAfectarEntradaProducto @Accion, @Empresa, @Sucursal, @ID, @Mov, @MovID, @Ok OUTPUT, @OkRef OUTPUT                               

    --REQ16092
    IF @MovTipo = 'VTAS.C' AND ISNULL(@SubClave, '') = 'VTAS.COPORT' AND @OrigenTipo = 'OPORT'
    BEGIN
      SELECT @OID = ID FROM Oportunidad WHERE Mov = @Origen and MovID = @OrigenID AND Empresa = @Empresa

      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @OrigenTipo, @OID, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
    END
  
    IF @Modulo = 'COMS' AND @MovTipo = 'COMS.F' AND @SubClave = 'COMS.EMAQUILA' AND @CFGProdInterfazInfor = 1 AND @Ok IS NULL
      EXEC spCompraEntradaMaquilaGenerarEntradaProd @Accion, @Empresa, @Sucursal, @ID, @Mov, @MovID, @Ok OUTPUT, @OkRef OUTPUT    
   
    IF @CfgVentaPuntosEnVales = 1 AND @Accion IN ('AFECTAR', 'RESERVARPARCIAL', 'CANCELAR') AND @Mov IN (SELECT Mov FROM EmpresaCfgPuntosEnValesMov WHERE Empresa = @Empresa) AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
      EXEC spVentaPuntosEnVales @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT
   
    IF @Ok IS NULL AND @MovTipo = 'COMS.GX'
      IF EXISTS(SELECT * FROM CompraD WHERE ID = @ID AND EsEstadistica = 1)
        EXEC spInvGenerarEstadistica @Empresa, @Sucursal, @Modulo, @ID, @Mov, @MovID, @Accion, @ClienteProv, @Ok OUTPUT, @OkRef OUTPUT
        
            /* Generar Transito */
    IF @MovTipo IN ('INV.SI', 'INV.DTI') AND @Ok IS NULL AND @Accion <> 'VERIFICAR'
    BEGIN
      IF @Accion <> 'CANCELAR'
      BEGIN
        EXEC @IDGenerar = spMovCopiar @Sucursal, @Modulo, @ID, @Usuario, @FechaRegistro, 1, @CopiarArtCostoInv = 1
        IF @IDGenerar IS NOT NULL
        BEGIN   
          IF @MovTipo = 'INV.DTI'
          BEGIN
            UPDATE Inv SET Almacen = @AlmacenDestinoOriginal, AlmacenDestino = @Almacen WHERE ID = @IDGenerar
            UPDATE InvD SET Almacen = @AlmacenDestinoOriginal WHERE ID = @IDGenerar
          END
          UPDATE Inv 
             SET Referencia      = RTRIM(@Mov)+ ' ' + RTRIM(@MovID),
                 SucursalDestino = (SELECT a.Sucursal  FROM Inv i, Alm a  WHERE i.ID = @IDGenerar AND a.Almacen = i.AlmacenDestino),
                 Mov             = (SELECT InvTransito FROM EmpresaCfgMov WHERE Empresa = @Empresa),
                 OrigenTipo = @Modulo,
                 Origen     = @Mov,
                 OrigenID   = @MovID
           WHERE ID = @IDGenerar

          UPDATE SerieLoteMov 
             SET Sucursal = (SELECT Sucursal  FROM Alm WHERE Almacen = @AlmacenDestinoOriginal)
           WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @IDGenerar
          EXEC xpGenerarTransito @Empresa, @Sucursal, @Usuario, @Modulo, @MovTipo, @Referencia, @ID, @IDGenerar
        END
      END ELSE
        SELECT @IDGenerar = @IDTransito

--    SELECT @VolverAfectar = 3 
      IF @Ok IN (NULL, 80030)
      BEGIN
        SELECT @Ok = NULL, @OkRef = NULL
        EXEC spInv @IDGenerar, @Modulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, @SincroFinal, 'TRANSITO',
                   @Mov, @MovID, @IDGenerar, @ContID,
                   @Ok OUTPUT, @OkRef OUTPUT/*, @VolverAfectar*/, @Estacion -- REQ12336

        SELECT @TransitoSucursal = Sucursal, @TransitoMov = Mov, @TransitoMovID = MovID, @TransitoEstatus = Estatus FROM Inv WHERE ID = @IDGenerar
        IF @Ok IN (NULL, 80030)
        BEGIN
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @IDGenerar, @TransitoMov, @TransitoMovID, @Ok OUTPUT
          IF @Accion = 'CANCELAR' AND @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
        END ELSE SELECT @OkRef = @TransitoMov
      END

      /* Traspaso Express */
      IF (SELECT TraspasoExpress FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov) = 1 AND @Ok IN (NULL, 80030) AND @Accion <> 'CANCELAR'  AND @TransitoEstatus = 'PENDIENTE'
      BEGIN
        SELECT @Ok = NULL, @OkRef = NULL
        SELECT @IDTransito = @IDGenerar
        EXEC @IDGenerar = spMovCopiar @Sucursal, @Modulo, @IDTransito, @Usuario, @FechaRegistro, 1, @CopiarArtCostoInv = 1
        IF @IDGenerar IS NOT NULL
        BEGIN
          UPDATE Inv 
             SET Mov             = (SELECT InvReciboTraspaso FROM EmpresaCfgMov WHERE Empresa = @Empresa),
--                 SucursalDestino = (SELECT a.Sucursal  FROM Inv i, Alm a  WHERE i.ID = @IDGenerar AND a.Almacen = i.AlmacenDestino),
                 OrigenTipo      = @Modulo,
                 Origen          = @TransitoMov,
                 OrigenID        = @TransitoMovID,
                 Directo         = 0
           WHERE ID = @IDGenerar
          UPDATE InvD 
             SET Aplica   = @TransitoMov,
                 AplicaID = @TransitoMovID
           WHERE ID = @IDGenerar

          EXEC spInv @IDGenerar, @Modulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, @SincroFinal, NULL,
                     @Mov, @MovID, @IDGenerar, @ContID,
                     @Ok OUTPUT, @OkRef OUTPUT/*, @VolverAfectar*/, @Estacion -- REQ12336
          SELECT @TraspasoExpressMov = Mov, @TraspasoExpressMovID = MovID FROM Inv WHERE ID = @IDGenerar
          IF @Ok IN (NULL, 80030)
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @IDTransito, @TransitoMov, @TransitoMovID, @Modulo, @IDGenerar, @TraspasoExpressMov, @TraspasoExpressMovID, @Ok OUTPUT
          ELSE
            SELECT @OkRef = @TraspasoExpressMov
        END
      END
    END

	--BUG3652
    IF @OrigenMovTipo <> 'INV.IF'
    BEGIN

	  SELECT @AlmacenDestino = NULLIF(AlmacenDestino,'')
        FROM Inv 
       WHERE ID= @ID

	  IF @MovTipo='INV.T' AND @WMS = 1 AND EXISTS(SELECT * FROM Alm WHERE Almacen = @AlmacenDestino AND WMS = 1) AND @Accion IN ('AFECTAR', 'CANCELAR', 'RESERVARPARCIAL') AND @OrigenTipo <> 'TMA' AND @Ok IS NULL
	  BEGIN
        EXEC spFlujoWMS @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @Almacen, @FechaEmision, @Proyecto, @Tarima, @Articulo, @Ok OUTPUT, @OkRef OUTPUT
	  END
	END

END
GO        

 /**************** spInvAfectarFEA ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spInvAfectarFEA') and type = 'P') drop procedure dbo.spInvAfectarFEA
GO             
CREATE PROCEDURE spInvAfectarFEA

                   @ID                          int,
                   @Accion			char(20),
                   @Empresa                     varchar(5),
                   @Sucursal                    int,
                   @Estatus                     varchar(15),
                   @Modulo	      		char(5),
                   @Mov                         varchar(20),
                   @MovTipoConsecutivoFEA	varchar(20), 
                   @FEAConsecutivo		varchar(20),
                   @FEAReferencia		varchar(50),
                   @FEASerie		        varchar(20),
                   @FEAFolio			int,  
        	   @Ok                          int	        OUTPUT,
        	   @OkRef		        varchar(255)	OUTPUT		
        	   
      	   
		           
--//WITH ENCRYPTION
AS BEGIN

      SELECT @MovTipoConsecutivoFEA = NULLIF(RTRIM(ConsecutivoFEA), '') FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
      IF @MovTipoConsecutivoFEA IS NOT NULL
      BEGIN
        IF @Accion = 'AFECTAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND NOT EXISTS(SELECT * FROM VentaFEA WHERE ID = @ID)
        BEGIN
          EXEC spConsecutivo @MovTipoConsecutivoFEA, @Sucursal, @FEAConsecutivo OUTPUT, @Referencia = @FEAReferencia OUTPUT
          EXEC spMovIDEnSerieConsecutivo @FEAConsecutivo, @FEASerie OUTPUT, @FEAFolio OUTPUT
          INSERT VentaFEA (
                 ID,  Serie,     Folio,     Aprobacion,                   Procesar, Cancelada) 
          SELECT @ID, @FEASerie, @FEAFolio, CONVERT(int, @FEAReferencia), 1,        0
          EXEC spPreValidarFEA @ID, 0, @Ok OUTPUT, @OkRef OUTPUT
        END ELSE
        IF @Accion = 'CANCELAR' AND @Estatus IN ('PENDIENTE', 'CONCLUIDO') 
        BEGIN
	  UPDATE VentaFEA SET Procesar = 1, Cancelada = 1 WHERE ID = @ID
        END
      END
END
GO       

--REQ13163
/**************** spInvGenerarRetencionesCompra ****************/
if exists (SELECT * FROM sysobjects WHERE id = object_id('dbo.spInvGenerarRetencionesCompra') AND sysstat & 0xf = 4) DROP PROCEDURE dbo.spInvGenerarRetencionesCompra
GO
CREATE PROC spInvGenerarRetencionesCompra
			@Fiscal						bit,
			@FiscalGenerarRetenciones	bit,
			@CfgRetencionAlPago			bit,
			@MovTipo     				char(20),
			@SumaRetencion				money,
			@SumaRetencion2				money,
			@SumaRetencion3				money,
			@CfgRetencionAcreedor		char(10),
			@Sucursal					int,
			@SucursalOrigen				int,
			@SucursalDestino			int,
			@Accion						char(20),
			@Empresa	      			char(5),
			@Modulo	      				char(5),
			@ID                			int,
			@Mov	  	      			char(20),
    		@MovID             			varchar(20),
    		@MovMoneda	      			char(10),
    		@MovTipoCambio	 			float,
    		@FechaEmision				datetime,
    		@CfgRetencionConcepto		varchar(50),
    		@Proyecto					varchar(50),
    		@Usuario					char(10),
    		@Autorizacion      			char(10),
    		@DocFuente	      			int,
    		@Observaciones     			varchar(255),
    		@FechaRegistro				datetime,
    		@Ejercicio					int,
	        @Periodo					int,
	        @CfgRetencionMov			char(20),
	        @CfgRetencion2Acreedor		char(10),
	        @CfgRetencion2Concepto		varchar(50), 
	        @CfgRetencion3Acreedor		char(10),
	        @CfgRetencion3Concepto		varchar(50), 
	        @CxModulo		 			char(5)		OUTPUT,
	        @CxMov		 				char(20)	OUTPUT,
			@CxMovID		 			varchar(20)	OUTPUT,
			@Ok							int			OUTPUT,
		    @OkRef						varchar(255)OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
    -- Retenciones de la Compra
    IF (@Fiscal = 0 OR @FiscalGenerarRetenciones = 1) AND @CfgRetencionAlPago = 0 AND @MovTipo IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI', 'COMS.D') AND (@SumaRetencion <> 0.0 OR @SumaRetencion2 <> 0.0 OR @SumaRetencion3 <> 0.0)
    BEGIN
      IF @SumaRetencion <> 0.0 
      BEGIN
        IF @CfgRetencionAcreedor IS NULL 
          SELECT @Ok = 70100
        ELSE
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                           @FechaEmision, @CfgRetencionConcepto, @Proyecto, @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
  	               @FechaRegistro, @Ejercicio, @Periodo,
	               NULL, NULL, @CfgRetencionAcreedor, NULL, NULL, NULL, NULL, NULL,
                           @SumaRetencion, NULL, NULL, NULL, 
                           NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
	               @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT
      END
      IF @SumaRetencion2 <> 0.0 
      BEGIN
        IF @CfgRetencion2Acreedor IS NULL 
          SELECT @Ok = 70100
        ELSE
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                           @FechaEmision, @CfgRetencion2Concepto, @Proyecto, @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
    	               @FechaRegistro, @Ejercicio, @Periodo,
	               NULL, NULL, @CfgRetencion2Acreedor, NULL, NULL, NULL, NULL, NULL,
                           @SumaRetencion2, NULL, NULL, NULL, 
                           NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
  	               @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT
      END
      IF @SumaRetencion3 <> 0.0 
      BEGIN
        IF @CfgRetencion3Acreedor IS NULL 
          SELECT @Ok = 70100
        ELSE
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                           @FechaEmision, @CfgRetencion3Concepto, @Proyecto, @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
    	               @FechaRegistro, @Ejercicio, @Periodo,
	               NULL, NULL, @CfgRetencion3Acreedor, NULL, NULL, NULL, NULL, NULL,
                           @SumaRetencion3, NULL, NULL, NULL, 
                           NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
  	               @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT
      END
    END
  RETURN
END
GO

--8. Desarrollo de proceso Cross Docking
/**************** spEntarimarCrossDoking ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spEntarimarCrossDoking') and TYPE = 'P') DROP PROCEDURE dbo.spEntarimarCrossDoking
GO
CREATE PROCEDURE spEntarimarCrossDoking
    @Modulo                 varchar(5),
    @IDGenerar              int, 
    @Empresa                varchar(5),
	@ID               		int,	
	@Almacen                varchar(10), 
	@PosicionWMS		    varchar(10)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE @Articulo         varchar(20),
	      @Cantidad         float,
		  @Tarima	        varchar(20),
		  @Costo            money,  
          @SerieLote        varchar(50),
          @Sucursal         int,
          @SubCuenta        varchar(50),
	      @Ok               int,
	      @OkRef            varchar(255)

  IF @Modulo = 'INV'
  BEGIN
      DECLARE entarimacd_cursor CURSOR FOR 
	    SELECT Articulo 
	      FROM INVD 
	     WHERE ID = @ID
      GROUP BY Articulo

	    OPEN entarimacd_cursor

	    FETCH NEXT FROM entarimacd_cursor 
	    INTO @Articulo

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
		    SELECT @Cantidad = SUM(CANTIDAD) ,
		           @Costo    = SUM(COSTO)
		      FROM INVD 
		     WHERE ID = @ID 
		       AND ARTICULO = @Articulo		 	
	
	         EXEC spConsecutivo 'Tarima', 0, @Tarima OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

		     INSERT Tarima (
						    Tarima,  Almacen,  Posicion,  Estatus, Alta, Articulo
					       )
		             SELECT @Tarima, @Almacen, @PosicionWMS, 'ALTA', GETDATE(), @Articulo

			    INSERT InvD (ID, Renglon, RenglonSub,     RenglonID,      RenglonTipo, Cantidad,  Almacen, Articulo,  Costo,  Aplica, AplicaID, Unidad, Factor, CantidadInventario, Sucursal, CostoUEPS, CostoPEPS, UltimoCosto, CostoEstandar, Tarima,  Seccion, SucursalOrigen, AsignacionUbicacion, FechaCaducidad)
			    SELECT TOP 1 ID, Renglon, RenglonSub + 1, RenglonID + 1,  RenglonTipo, @Cantidad, Almacen, Articulo,  @Costo, Aplica, AplicaID, Unidad, Factor, @Cantidad,          Sucursal, CostoUEPS, CostoPEPS, UltimoCosto, CostoEstandar, @Tarima, 1,       SucursalOrigen, AsignacionUbicacion, FechaCaducidad
				    FROM INVD 
			    WHERE ID = @ID
				    AND Articulo = @Articulo

		    FETCH NEXT FROM entarimacd_cursor 
		    INTO @Articulo
	    END 
	    CLOSE entarimacd_cursor;
	    DEALLOCATE entarimacd_cursor;

        INSERT SerieLoteMov  (Empresa, Sucursal,  Modulo,  ID,        RenglonID,     Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades)
                       SELECT Empresa, slm.Sucursal, @Modulo, @IDGenerar, slm.RenglonID + 1, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Cantidad, @Tarima, slm.Propiedades
                         FROM SerieLoteMov slm
                         JOIN InvD d ON d.ID = slm.ID AND d.RenglonID = slm.RenglonID AND d.Articulo = slm.Articulo AND ISNULL(d.SubCuenta, '') = slm.SubCuenta
                         JOIN Art a ON a.Articulo = d.Articulo
                        WHERE slm.Modulo = @Modulo AND slm.ID = @ID AND Seccion IS NULL
                          AND a.SerieLoteInfo = 0 
    END

    IF @Modulo = 'COMS'
    BEGIN
      DECLARE entarimacd_cursor CURSOR FOR 
	    SELECT Articulo 
	      FROM CompraD 
	     WHERE ID = @ID
      GROUP BY Articulo

	    OPEN entarimacd_cursor

	    FETCH NEXT FROM entarimacd_cursor 
	    INTO @Articulo

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
		    SELECT @Cantidad = SUM(CANTIDAD) ,
		           @Costo    = SUM(COSTO)
		      FROM CompraD 
		     WHERE ID = @ID 
		       AND ARTICULO = @Articulo		 	
	
	         EXEC spConsecutivo 'Tarima', 0, @Tarima OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

		     INSERT Tarima (
						    Tarima,  Almacen,  Posicion,  Estatus, Alta, Articulo
					       )
		             SELECT @Tarima, @Almacen, @PosicionWMS, 'ALTA', GETDATE(), @Articulo

			    INSERT CompraD (ID, Renglon, RenglonSub,     RenglonID,      RenglonTipo, Cantidad,  Almacen, Articulo,  Costo,  Aplica, AplicaID, Unidad, Factor, CantidadInventario, Sucursal, CostoUEPS, CostoPEPS, UltimoCosto, CostoEstandar, Tarima,  SucursalOrigen,  FechaCaducidad)
			    SELECT TOP 1 ID, Renglon, RenglonSub + 1, RenglonID + 1,  RenglonTipo, @Cantidad, Almacen, Articulo,  @Costo, Aplica, AplicaID, Unidad, Factor, @Cantidad,          Sucursal, CostoUEPS, CostoPEPS, UltimoCosto, CostoEstandar, @Tarima,     SucursalOrigen,  FechaCaducidad
				    FROM CompraD 
			    WHERE ID = @ID
				    AND Articulo = @Articulo	

		    FETCH NEXT FROM entarimacd_cursor 
		    INTO @Articulo
	    END 
	    CLOSE entarimacd_cursor;
	    DEALLOCATE entarimacd_cursor;

        INSERT SerieLoteMov  (
            Empresa, Sucursal,  Modulo,  ID,        RenglonID,     Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades)
            SELECT Empresa, slm.Sucursal, @Modulo, @IDGenerar, slm.RenglonID + 1   , slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Cantidad, @Tarima, slm.Propiedades
                FROM SerieLoteMov slm
                JOIN CompraD d ON d.ID = slm.ID AND d.RenglonID = slm.RenglonID AND d.Articulo = slm.Articulo AND ISNULL(d.SubCuenta, '') = slm.SubCuenta
                JOIN Art a ON a.Articulo = d.Articulo
                WHERE slm.Modulo = @Modulo AND slm.ID = @ID 
                AND a.SerieLoteInfo = 0 
     END

     IF @Modulo = 'VTAS'
     BEGIN
      DECLARE entarimacd_cursor CURSOR FOR 
	    SELECT Articulo 
	      FROM VentaD 
	     WHERE ID = @ID
      GROUP BY Articulo

	    OPEN entarimacd_cursor

	    FETCH NEXT FROM entarimacd_cursor 
	    INTO @Articulo

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
		    SELECT @Cantidad = SUM(CANTIDAD) ,
		           @Costo    = SUM(COSTO)
		      FROM VentaD 
		     WHERE ID = @ID 
		       AND ARTICULO = @Articulo		 	
	
	         EXEC spConsecutivo 'Tarima', 0, @Tarima OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

		     INSERT Tarima (
						    Tarima,  Almacen,  Posicion,  Estatus, Alta, Articulo
					       )
		             SELECT @Tarima, @Almacen, @PosicionWMS, 'ALTA', GETDATE(), @Articulo

			    INSERT VentaD (ID, Renglon, RenglonSub,     RenglonID,      RenglonTipo, Cantidad,  Almacen, Articulo,  Costo,  Aplica, AplicaID, Unidad, Factor, CantidadInventario, Sucursal, CostoUEPS, CostoPEPS, UltimoCosto, CostoEstandar, Tarima,  SucursalOrigen)
			    SELECT TOP 1 ID, Renglon, RenglonSub + 1, RenglonID + 1,  RenglonTipo, @Cantidad, Almacen, Articulo,  @Costo, Aplica, AplicaID, Unidad, Factor, @Cantidad,          Sucursal, CostoUEPS, CostoPEPS, UltimoCosto, CostoEstandar, @Tarima,   SucursalOrigen
                 FROM VentaD 
			    WHERE ID = @ID
				    AND Articulo = @Articulo	

		    FETCH NEXT FROM entarimacd_cursor 
		    INTO @Articulo
	    END 
	    CLOSE entarimacd_cursor;
	    DEALLOCATE entarimacd_cursor;

        INSERT SerieLoteMov  (
            Empresa, Sucursal,  Modulo,  ID,        RenglonID,     Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades)
            SELECT Empresa, slm.Sucursal, @Modulo, @IDGenerar, slm.RenglonID + 1, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Cantidad, @Tarima, slm.Propiedades
                FROM SerieLoteMov slm
                JOIN VentaD d ON d.ID = slm.ID AND d.RenglonID = slm.RenglonID AND d.Articulo = slm.Articulo AND ISNULL(d.SubCuenta, '') = slm.SubCuenta
                JOIN Art a ON a.Articulo = d.Articulo
                WHERE slm.Modulo = @Modulo AND slm.ID = @ID
                AND a.SerieLoteInfo = 0 
    END

    IF @Modulo = 'PROD'
    BEGIN
      DECLARE entarimacd_cursor CURSOR FOR 
	    SELECT Articulo 
	      FROM ProdD 
	     WHERE ID = @ID
      GROUP BY Articulo

	    OPEN entarimacd_cursor

	    FETCH NEXT FROM entarimacd_cursor 
	    INTO @Articulo

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
		    SELECT @Cantidad = SUM(CANTIDAD) ,
		           @Costo    = SUM(COSTO)
		      FROM ProdD 
		     WHERE ID = @ID 
		       AND ARTICULO = @Articulo		 	
	
	         EXEC spConsecutivo 'Tarima', 0, @Tarima OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

		     INSERT Tarima (
						    Tarima,  Almacen,  Posicion,  Estatus, Alta, Articulo
					       )
		             SELECT @Tarima, @Almacen, @PosicionWMS, 'ALTA', GETDATE(), @Articulo

			    INSERT ProdD (ID, Renglon, RenglonSub,     RenglonID,      RenglonTipo, Cantidad,  Almacen, Articulo,  Costo,  Aplica, AplicaID, Unidad, Factor, CantidadInventario, Sucursal, CostoUEPS, CostoPEPS, UltimoCosto, CostoEstandar, Tarima,  SucursalOrigen)
			    SELECT TOP 1 ID, Renglon, RenglonSub + 1, RenglonID + 1,  RenglonTipo, @Cantidad, Almacen, Articulo,  @Costo, Aplica, AplicaID, Unidad, Factor, @Cantidad,          Sucursal, CostoUEPS, CostoPEPS, UltimoCosto, CostoEstandar, @Tarima,  SucursalOrigen
				    FROM ProdD 
			    WHERE ID = @ID
				    AND Articulo = @Articulo	

		    FETCH NEXT FROM entarimacd_cursor 
		    INTO @Articulo
	    END 
	    CLOSE entarimacd_cursor;
	    DEALLOCATE entarimacd_cursor;

        INSERT SerieLoteMov  (
            Empresa, Sucursal, Modulo,  ID,        RenglonID,     Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades)
            SELECT Empresa, slm.Sucursal, @Modulo, @IDGenerar, slm.RenglonID + 1, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Cantidad, @Tarima, slm.Propiedades
                FROM SerieLoteMov slm
                JOIN InvD d ON d.ID = slm.ID AND d.RenglonID = slm.RenglonID AND d.Articulo = slm.Articulo AND ISNULL(d.SubCuenta, '') = slm.SubCuenta
                JOIN Art a ON a.Articulo = d.Articulo
                WHERE slm.Modulo = @Modulo AND slm.ID = @ID
                AND a.SerieLoteInfo = 0 
    END

  RETURN
END
GO

/**************** spInvAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvAfectar') and type = 'P') drop procedure dbo.spInvAfectar
GO             
CREATE PROCEDURE spInvAfectar
    		   @ID                		int,
		   @Accion			char(20),
		   @Base			char(20),

    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)	OUTPUT,
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
		   @FechaEmision		datetime,
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
		   @EstatusNuevo		char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

    		   @Almacen        		char(10),
                   @AlmacenTipo			char(15),
    		   @AlmacenDestino    		char(10),
                   @AlmacenDestinoTipo		char(15),
		   @VoltearAlmacen		bit, 
		   @AlmacenEspecifico		char(10), 
                   @Largo			bit,
		   @Condicion			varchar(50), 
		   @Vencimiento			datetime,
		   @Periodicidad		varchar(20), 
		   @EndosarA			varchar(10),

		   @ClienteProv			char(10),
		   @EnviarA			int,
		   @DescuentoGlobal		float,
		   @SobrePrecio			float,
		   @Agente			char(10),
		   @AnticiposFacturados		money,
    		   @ServicioArticulo		char(20),
    		   @ServicioSerie		char(20),
		   @FechaRequerida		datetime,
		   @ZonaImpuesto		varchar(50),

		   @OrigenTipo			varchar(10),
		   @Origen			varchar(20),
                   @OrigenID			varchar(20),
                   @OrigenMovTipo		varchar(20),

		   --@CfgAutoConsig		bit,
    		   @CfgFormaCosteo    		char(20),
    		   @CfgTipoCosteo     		char(20),
                   @CfgCosteoActividades	varchar(20),
		   @CfgCosteoNivelSubCuenta	bit,
                   @CfgCosteoMultipleSimultaneo bit,
                   @CfgPosiciones		bit,
		   @CfgExistenciaAlterna	bit,
		   @CfgExistenciaAlternaSerieLote bit,
                   @CfgSeriesLotesMayoreo	bit,
    		   @CfgSeriesLotesAutoCampo	char(20),
    		   @CfgSeriesLotesAutoOrden	char(20),
                   @CfgCosteoSeries		bit,
                   @CfgCosteoLotes		bit,
		   @CfgValidarLotesCostoDif	bit,
		   @CfgVentaSurtirDemas		bit,
		   @CfgCompraRecibirDemas	bit,
		   @CfgTransferirDemas		bit,
		   @CfgBackOrders		bit,
		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
                   @CfgContXFacturasPendientes  bit,
		   @CfgEmbarcar			bit,
	           @CfgImpInc			bit,
    		   @CfgVentaContratosArticulo	char(20),
    		   @CfgVentaContratosImpuesto	float,
		   @CfgVentaComisionesCobradas	bit,
		   @CfgAnticiposFacturados	bit,
		   @CfgMultiUnidades		bit,
		   @CfgMultiUnidadesNivel	char(20),
    	      	   @CfgCompraFactorDinamico 	bit,
		   @CfgInvFactorDinamico   	bit,
		   @CfgProdFactorDinamico  	bit,
		   @CfgVentaFactorDinamico 	bit,
                   @CfgCompraAutoCargos		bit,
                   @CfgVentaAutoBonif		bit,
		   @CfgVINAccesorioArt 		bit,
                   @CfgVINCostoSumaAccesorios	bit,
		   @SeguimientoMatriz		bit,
		   @CobroIntegrado		bit,
		   @CobroIntegradoCxc		bit,
                   @CobroIntegradoParcial       bit,
		   @CobrarPedido		bit,

  		   @AfectarDetalle              bit,
		   @AfectarMatando		bit,
		   @AfectarVtasMostrador	bit,
		   @FacturarVtasMostrador	bit,
		   @AfectarConsignacion		bit,
		   @AfectarAlmacenRenglon	bit,
                   @CfgVentaMultiAgente		bit,
                   @CfgVentaMultiAlmacen	bit,
                   @CfgVentaArtAlmacenEspecifico bit, 
		   @CfgTipoMerma		char(1),
                   @CfgComisionBase		char(20), 
		   @CfgLimiteRenFacturas	int,	
		   @CfgVentaRedondeoDecimales	int,
                   @CfgCompraCostosImpuestoIncluido bit,

		   @AfectarConsecutivo		bit,
		   @EsTransferencia		bit,

		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @Utilizar			bit,
		   @UtilizarID			int,
		   @UtilizarMov			char(20),
		   @UtilizarSerie		char(20),
		   @UtilizarMovTipo		char(20),
		   @UtilizarMovID		varchar(20),

                   @Generar                     bit,
                   @GenerarMov                  char(20),
		   @GenerarSerie		char(20),
		   @GenerarAfectado		bit,
		   @GenerarCopia		bit,
		   @GenerarPoliza		bit,
		   @GenerarOP			bit,
		   @GenerarGasto		bit,
		   @FacturacionRapidaAgrupada	bit, 

		   @IDTransito			int	     OUTPUT,
    		   @IDGenerar		 	int	     OUTPUT,
    		   @GenerarMovID	  	varchar(20)  OUTPUT,
		   @ContID			int	     OUTPUT,

    		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT,
		   @CfgPrecioMoneda		bit = 0,
		   @EstacionTrabajo		    int = NULL -- REQ12336
               		   
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dias			int,
    @Renglon             	float,
    @RenglonSub		 	int,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @Articulo	         	char(20),
    @Posicion			char(10),
    @AuxiliarAlternoSucursal	int,
    @AuxiliarAlternoAlmacen	char(10),
    @AuxiliarAlternoFactorEntrada float,
    @AuxiliarAlternoFactorSalida  float,
    @ArtTipo	         	varchar(20),
    @ArtSerieLoteInfo		bit,
    @ArtTipoOpcion		varchar(20),
    @ArtComision		varchar(50),
    @Peso			float,
    @Volumen			float,
    @Subcuenta	         	varchar(50),
    @AcumularSinDetalles	bit,
    @AcumCantidad		float,
    @Cantidad	         	float,
    @Factor			float,
    @MovUnidad			varchar(50),
    @CantidadOriginal		float,
    @CantidadObsequio		float,
    @CantidadInventario		float,
    @CantidadReservada	 	float,
    @CantidadOrdenada		float,
    @CantidadOrdenadaA		float,
    @CantidadPendiente   	float,
    @CantidadPendienteA		float,
    @CantidadA	       	 	float,
    @IDSalidaTraspaso		int,
    @IDAplica			int,
    @AplicaMov              	char(20),
    @AplicaMovID            	varchar(20),
    @AplicaMovTipo		char(20),
    @AlmacenRenglon		char(10),
    @AgenteRenglon		char(10),
    @AlmacenOrigen		char(10),
    @Costo	         	float,		-- a proposito float en lugar de money
    @CostoInv			float,		-- a proposito float en lugar de money
    @CostoInvTotal          	float,
    @Precio	         	float,
    @PrecioN	         	float,
    @PrecioTipoCambio		float,
    @DescuentoTipo	 	char(1),
    @DescuentoLinea	 	float,
    @Impuesto1		 	float,
    @Impuesto1N		 	float,
    @Impuesto2		 	float,
    @Impuesto2N		 	float,
    @Impuesto3		 	money,
    @Impuesto3N		 	money,
    @Impuesto5		 	money,
    @Impuesto5N		 	money,
    @Importe             	money,
    @ImporteNeto             	money,
    @Impuestos		 	money,
    @ImpuestosNetos		money,
    @Impuesto1Neto 		money,
    @Impuesto2Neto 		money,
    @Impuesto3Neto 		money,
    @Impuesto5Neto 		money,
    @ImporteComision		money,
    @DescuentoLineaImporte	money,
    @DescuentoGlobalImporte	money,
    @SobrePrecioImporte		money,
    @AnticipoImporte		money,
    @AnticipoImpuestos		money,
    @ImporteCx			money,
    @ImpuestosCx		money,
    @RetencionCx		money,
    @Retencion2Cx		money,
    @Retencion3Cx		money,
    @ImporteTotalCx		money,
    @CondicionCx		varchar(50),
    @VencimientoCx		datetime,
    @FacturandoRemision         bit,

    @TienePendientes		bit,
    @SumaPendiente       	float,
    @SumaReservada		float,
    @SumaOrdenada		float,
    @SumaImporte		money,
    @SumaImporteNeto	 	money,
    @SumaImpuestos	 	money,
    @SumaImpuestosNetos	 	money,
    @SumaImpuesto1Neto 	 	money,
    @SumaImpuesto2Neto 	 	money,
    @SumaImpuesto3Neto 	 	money,
    @SumaImpuesto5Neto 	 	money,
    @SumaDescuentoLinea		money,
    @SumaPrecioLinea		money,
    @SumaCostoLinea		money,
    @SumaPeso			float,
    @SumaVolumen		float,
    @SumaComision		money,
    @SumaRetencion		money,
    @SumaRetencion2		money,
    @SumaRetencion3		money,
    @SumaRetenciones		money,
    @SumaAnticiposFacturados	money, 
    @ImporteRetencion		money,
    @ImporteRetencion2		money,
    @ImporteRetencion3		money,
    @Paquetes			int,
    @ImporteTotal		float,
    @MovImpuesoSubTotal		money,
    @ImporteMatar		money,
    @FechaCancelacion		datetime,
    @ArtUnidad			varchar(50),
    @ArtCantidad		float,
    @ArtCosto	         	float,		-- a proposito float en lugar de money
    @ArtCostoInv		float,		-- a proposito float en lugar de money
    @ArtAjusteCosteo		float,
    @ArtCostoUEPS		float,    
    @ArtCostoPEPS		float,
    @ArtUltimoCosto		float,
    @ArtCostoEstandar		float,
    @ArtPrecioLista		float,
    @ArtDepartamentoDetallista	int,
    @ArtMoneda			char(10),
    @ArtFactor	 	 	float,
    @ArtTipoCambio		float,
    @ArtCostoIdentificado	bit,
    @AjustePrecioLista		money,
    @MovRetencion1		float,
    @MovRetencion2		float,
    @MovRetencion3		float,
    @ReservadoParcial		float,
    @ExplotandoRenglon		float,
    @ExplotandoSubCuenta	bit,
    @EsEntrada           	bit,
    @EsSalida		 	bit,
    @EsCargo			bit,
    @AfectarCantidad		float,
    @AfectarAlmacen		char(10),
    @AfectarAlmacenDestino	char(10),
    @AfectarSerieLote		bit,
    @AfectarCostos       	bit,
    @AfectarUnidades     	bit,
    @AfectarPiezas       	bit,
    @AfectarRama		char(5),
    @UtilizarBase		char(20),
    @UtilizarEstatus		char(15),
    @GenerarAlmacen		char(10),
    @GenerarAlmacenDestino	char(10),
    @GenerarEstatus		char(15),
    @GenerarDirecto		bit,
    @GenerarMovTipo 	 	char(20), 
    @GenerarPeriodo 	 	int, 
    @GenerarEjercicio 	 	int,
    @GenerarPolizaTemp		bit,
    @YaGeneroConsecutivo	bit,
    @CxModulo			char(5),
    @CxID			int, 
    @CxMov			char(20),
    @CxMovID			varchar(20),
    @CxMovEspecifico		varchar(20),
    @CxAgente			char(10),
    @CxMovTipo			varchar(20),
    @CxImporte			money,
    @CxAjusteID			int, 
    @CxAjusteMov		char(20),
    @CxAjusteMovID		varchar(20),
    @CxAjusteImporte		money,
    @CxConcepto			varchar(50),
    @CompraID			int,
    @Cliente			char(10),
    @DetalleTipo		varchar(20),
    @Merma			float,
    @Desperdicio		float,
    @CantidadCalcularImporte	float,

    @DestinoTipo	  	varchar(10),
    @Destino			varchar(20),
    @DestinoID			varchar(20),

    @CobroDesglosado		money,
    @CobroCambio		money,
    @CobroRedondeo		money,
    @CobroSumaEfectivo		money,
    @CobroDelEfectivo		money,
    @ValesCobrados		money,
    @TarjetasCobradas		money,		-- ETO Tarjetas 9-Feb-2007
    @DineroImporte		money,
    @DineroModulo		char(5),
    @DineroMov			char(20),
    @DineroMovID		varchar(20),
    @MovImpuesto		bit,

    @Importe1			money,
    @Importe2			money,
    @Importe3			money,
    @Importe4			money,
    @Importe5			money,
    @ImporteCambio		money,
    @FormaCobro1		varchar(50),
    @FormaCobro2		varchar(50),
    @FormaCobro3		varchar(50),
    @FormaCobro4		varchar(50),
    @FormaCobro5		varchar(50),
    @FormaCobroVales		varchar(50),
    @FormaCobroCambio	varchar(50), --MEJORA5512
    @FormaCobroTarjetas		varchar(50), 	-- ETO Tarjetas 9-Feb-2007
    @IncrementaSaldoTarjeta	bit,	     	-- ETO Tarjetas 9-Feb-2007
    @FormaPagoCambio		varchar(50),
    @Referencia1		varchar(50),
    @Referencia2		varchar(50),
    @Referencia3		varchar(50),
    @Referencia4		varchar(50),
    @Referencia5		varchar(50),
    @CtaDinero			char(10),
    @Cajero			char(10),

    @FormaMoneda		char(10),
    @FormaTipoCambio		float,
    @AlmacenEspecificoVenta	char(10),

    @MatarAntes			bit,
    @UltRenglonIDJuego		int,
    @CantidadJuego		float,
    @CantidadMinimaJuego	int,
    @AlmacenTemp		char(10),
    @AlmacenOriginal		char(10),
    @AlmacenDestinoOriginal	char(10),
    @ProdSerieLote		varchar(50),
    @VIN			varchar(20),
    @UltReservadoCantidad	float,
    @UltReservadoFecha		datetime,
    @UltAgente			char(10),
    @ComisionAcum		money,
    @ComisionImporteNeto	float,
    @ComisionFactor		float,
    @Producto			varchar(20),
    @SubProducto		varchar(50),
    @IVAFiscal			float,
    @IEPSFiscal			float,
    @AfectandoNotasSinCobro	bit,
    @Continuar			bit,
    @ArtProvCosto		float,
    @ProveedorRef 		varchar(10), 

    @CfgRetencionAlPago		bit,
    @CfgRetencionMov		char(20),
    @CfgRetencionAcreedor	char(10),
    @CfgRetencionConcepto	varchar(50),
    @CfgRetencion2Acreedor	char(10),
    @CfgRetencion2Concepto	varchar(50),
    @CfgRetencion3Acreedor	char(10),
    @CfgRetencion3Concepto	varchar(50),
    @CfgIngresoMov		char(20),
    @CfgEstadisticaAjusteMerma	char(20),
    @CfgInvAjusteCargoAgente	varchar(20),
    @CfgVentaDMultiAgenteSugerir bit,
    @CfgVentaMonedero		bit,
	@CfgVentaMonederoA		bit,
    @CfgVentaPuntosEnVales	bit,
    @EspacioD			varchar(10),
    @EspacioDAnterior		varchar(10),
    @Ruta			char(20), 
    @Orden			int,
    @OrdenDestino		int,
    @Centro			char(10),
    @CentroDestino		char(10),
    @Estacion			char(10),
    @EstacionDestino		char(10),
    @TiempoEstandarFijo		float,
    @TiempoEstandarVariable 	float,
    @DescuentoInverso		float,
    @SucursalAlmacen        	int,
    @SucursalAlmacenDestino 	int,
    @ProrrateoAplicaID		int, 
    @ProrrateoAplicaIDMov	varchar(20), 
    @ProrrateoAplicaIDMovID	varchar(20),
    @ArtLotesFijos		bit,
    @ArtActividades		bit,
    @SeriesLotesAutoOrden	varchar(50),
    @CostoActividad		float,
    @CotizacionID		int,
    @CotizacionEstatusNuevo	char(15),
    @Hoy			datetime,	
    @RedondeoMonetarios		int,
    @CfgDiasHabiles		varchar(20),
    @CfgABCDiasHabiles		bit,
    @CostosImpuestoIncluido 	bit,
    @BorrarRetencionCx		bit, 
    @MovImpuestoFactor		float,
    @PrecioSinImpuestos		float,
    @ModificarCosto 		float, 
    @ModificarPrecio 		float,
    @CfgAC			bit,
    @LCMetodo			int,
    @LCPorcentajeResidual	float,
    @CP				bit,
    @PPTO			bit,
    @PPTOVentas			bit,
    @WMS			bit,
    @WMSAlmacen			bit,
    @WMSMov			varchar(20),
    @TransitoSucursal		int,
    @TransitoMov 		varchar(20), 
    @TransitoMovID 		varchar(20), 
    @TransitoEstatus 		varchar(15), 
    @TraspasoExpressMov		varchar(20), 
    @TraspasoExpressMovID	varchar(20), 
    @FEA			bit,
    @FEAConsecutivo		varchar(20),
    @FEAReferencia		varchar(50),
    @FEASerie			varchar(20),
    @FEAFolio			int,
    @MovTipoConsecutivoFEA	varchar(20),
    @CantidadDif		float,
    @CfgArrastrarSerieLote	bit,
    @CfgNotasBorrador		bit,
    @NoValidarDisponible	bit,
    @IDOrigen 			int,
    @CfgVentaArtEstatus		bit,
    @CfgVentaArtSituacion	bit,
    @CfgCostearTransferencias	bit,
    @ArtEstatus			varchar(15),
    @ArtSituacion		varchar(50),
    @ArtExcento1		bit,
    @ArtExcento2		bit,
    @ArtExcento3		bit,
    @Fiscal			bit,
    @FiscalGenerarRetenciones	bit,
    @ReferenciaAplicacionAnticipo varchar(50),
    @CxEndosoMov 		varchar(20),
    @CxEndosoMovID 		varchar(20),
    @CxEndosoID 		int,
    @AutoEndosar 		varchar(20),
    @Proveedor 			varchar(20),
    @CfgMovCxpEndoso 		varchar(20),
    @CfgCompraAutoEndosoAutoCargos bit,
    @Tarima			varchar(20),
    @Seccion			int,
    @ContUso			varchar(20),
    @ContUso2			varchar(20),
    @ContUso3			varchar(20),
    @ClavePresupuestal		varchar(50),
    @ClavePresupuestalImpuesto1	varchar(50),
    @FactorMovImpto		float,
    @FechaCaducidad		datetime,	
    @GenerarOrden		bit,
    @TipoImpuesto1		varchar(10),
    @TipoImpuesto2		varchar(10),
    @TipoImpuesto3		varchar(10),
    @TipoImpuesto5		varchar(10),
    @TipoRetencion1		varchar(10),
    @TipoRetencion2		varchar(10),
    @TipoRetencion3		varchar(10),
    @CfgRetencion2BaseImpuesto1	bit,
    @Retencion1			float,
    @Retencion2			float,
    @Retencion3			float,
    @SubClave			varchar(20),
    @EsEcuador			bit,
    @EmbarqueSumaArtJuego				varchar(20),
    @ArtCostoPromedio					money,
    @ArtCostoReposicion					money,
    @VentaMovImpuestoDesdeRemision		bit,			--MEJORA1002
    @ArrastrarMovImpuestoRemision		bit,			--MEJORA1002
    @AplicaConcepto						varchar(50),	--MEJORA1002
    @AplicaFechaEmision					datetime,		--MEJORA1002
    @MovImpuestoAplicaID				int,			--MEJORA1002
	@SubCuentaExplotarInformacion		bit,
	@SAUX								bit,
    @ValuacionOtraMoneda				varchar(10), --MEJORA6230
    @ValuacionOtraMonedaTC				float,       --MEJORA6230
    @ValuacionOtraMonedaTCV				float,       --MEJORA6230
    @ValuacionOtraMonedaTCC				float,		 --MEJORA6230
    @AnticipoFacturado					bit, --ANTICIPOFACTURADO
    @AnticipoFacturadoTipoServicio		bit,
    @LDI                                        bit,--REQ 13386  
    @CFDFlex                                    bit,--REQ 13386  
    @LDITarjeta                                 bit,--REQ 13386  
    
    @InterfazTC							bit,	--REQ13163
    @TCDelEfectivo						float,	--REQ13163
    @TCProcesado1						bit,	--REQ13163
    @TCProcesado2						bit,	--REQ13163
    @TCProcesado3						bit,	--REQ13163
    @TCProcesado4						bit,	--REQ13163
    @TCProcesado5						bit,	--REQ13163
    
    @TipoCambio1                float, --REQ 13393 POS
    @TipoCambio2                float, --REQ 13393 POS
    @TipoCambio3                float, --REQ 13393 POS
    @TipoCambio4                float, --REQ 13393 POS
    @TipoCambio5                float,  --REQ 13393 POS
    @ReferenciaTarjetas			varchar(50),  --BUG15665
    @OPORT						bit,		--REQ16092
    @GenerarNCAlProcesar        bit,
    @PosicionDestino             varchar(10),
    @CFGProdInterfazInfor        bit,
    @CfgEspacios                bit,

    --TASK25106
	--BUG24764
    @SubMovTipo			varchar(20),

	--TASK25114
	@PosicionActual     varchar(10), --Bug 22831
    @PosicionReal       varchar(10),
    
    @IDGenerarTransito	int,
    @CfgCostearDC	bit,
	--8. Desarrollo de proceso Cross Docking
	@CrossDocking         bit,
    @Escrossdocking       varchar(2),
	@PosicionWMS          varchar(10),
	@posicioncrossdocking varchar(10),
	@IDN                  int,
	@OrigenP              varchar(20),
	@OrigenIdP            varchar(20),
	---------------------------------
	@CrMov				  varchar(20),
	@CrMovID			  varchar(20),
	@CrRenglon			  float,
	@CrRenglonID		  int,
	@CrRenglonAnt		  float,
	@CrRenglonIDAnt		  int,
	@CrArticulo			  varchar(20),
    @CrArticuloAnt		  varchar(20),
	@CrAlmacen			  varchar(10),
	@CrCantidad			  float,
	@CrSerieLote		  varchar(50),
	@CrCantidadSL		  float,
	@CrCantidadAplicada	  float,
	@CrCantidadDispSL	  float,
	@CrSLMArticulo		  varchar(20),
	@CrSLMSerieLote		  varchar(50),
	@CrSLMCantidad		  float,
    @Serielote            varchar(50),
	@Disponible	          float,
    @BanderaDesentarimado bit
	    
       DECLARE @LDILog table(  	
        IDModulo                varchar(36) ,
  	Modulo                  varchar(5)  ,
  	Servicio                varchar(50) ,
        Fecha                   varchar(20) ,
        TipoTransaccion         varchar(50) , 
        TipoSubservicio         varchar(50) ,
        CodigoRespuesta         varchar(50) , 
        DescripcionRespuesta    varchar(255), 
        OrigenRespuesta         varchar(50) , 
        InfoAdicional           varchar(50) , 
        IDTransaccion           varchar(50) ,
        CodigoAutorizacion      varchar(50) ,
        Importe                 float       ,
        Comprobante             varchar(Max),
        Cadena                  varchar(Max),
        CadenaRespuesta         varchar(Max),
        RIDCobro                int         )

	  DECLARE @Bandera TABLE
	  (
		Id                  int Identity(1,1),
		Articulo            varchar(20) NULL, 
		SerieLote           varchar(50) NULL, 
		CantidadDispSL      float NULL, 
		SLMCantidad         float NULL, 
		CantidadS           float NULL, 
		Cantidad            float NULL 
	  )

	  DECLARE @BanderaF TABLE
	  (
		Id                  int Identity(1,1),
		Articulo            varchar(20) NULL,     
		SerieLote           varchar(50) NULL, 
		Cantidad            float NULL ,
		CantidadDispSL      float NULL
	  )

	  DECLARE @BanderaFinal TABLE
	  (
		Id                  int Identity(1,1),
		Articulo            varchar(20) NULL,     
		SerieLote           varchar(50) NULL, 
		Cantidad            float NULL ,
		CantidadDispSL      float NULL
	  )
    
  SELECT @CFDFlex = CFDFlex FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo	
  
  --TASK25106
  --BUG24764
  SELECT @SubMovTipo = ISNULL(SubClave, '') FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov

  SELECT @EsEcuador = EsEcuador FROM Empresa WHERE Empresa = @Empresa
  SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo 
  SELECT @RedondeoMonetarios = RedondeoMonetarios, @CfgRetencion2BaseImpuesto1 = ISNULL(Retencion2BaseImpuesto1, 0) FROM Version 

  IF @MovTipo = 'INV.EI' UPDATE InvD SET Tarima = NULL WHERE ID = @ID--Cambio WMS --TASK25114

  -- Inicializar Variables
  SELECT @ArtMoneda		= NULL,
         @SumaPendiente     	= 0.0,
	 @SumaReservada		= 0.0,
         @SumaOrdenada		= 0.0,
         @SumaImporte    	= 0.0,
         @SumaImporteNeto    	= 0.0,
         @SumaImpuestos	    	= 0.0,
         @SumaImpuestosNetos   	= 0.0,
         @SumaImpuesto1Neto    	= 0.0,
         @SumaImpuesto2Neto    	= 0.0,
         @SumaImpuesto3Neto    	= 0.0,
         @SumaImpuesto5Neto    	= 0.0,
	 @SumaDescuentoLinea	= 0.0,
         @SumaComision		= 0.0,
         @SumaPrecioLinea	= 0.0,
         @SumaCostoLinea	= 0.0,
    	 @SumaPeso		= 0.0,
    	 @SumaVolumen		= 0.0,
	 @SumaRetencion	 	= 0.0,
	 @SumaRetencion2 	= 0.0,
	 @SumaRetencion3 	= 0.0,
         @ComisionAcum		= 0.0,
         @ComisionImporteNeto	= 0.0,
	 @ExplotandoRenglon	= NULL,
--       @UsaCacheCostos	= 0,
--	 @UltCostoInvTotal	= 0.0,
         @YaGeneroConsecutivo   = 0,
	 @MatarAntes 		= 0,
	 @UltRenglonIDJuego	= NULL,
	 @DetalleTipo		= NULL,
         @Merma			= NULL,
         @Desperdicio	        = NULL,
         @VIN			= NULL,
         @UltAgente		= NULL,
         @Producto		= NULL,
         @SubProducto		= NULL,
         @ComisionFactor	= 1.0,
         @IVAFiscal		 = NULL,
         @IEPSFiscal		 = NULL,
         @SucursalAlmacen        = NULL,
         @SucursalAlmacenDestino = NULL,
         @ArtLotesFijos		 = 0,
         @ArtActividades	 = 0,
    	 @MovImpuesto 		 = 0,
         @CostosImpuestoIncluido = 0,
         @BorrarRetencionCx	 = 0,
         @FacturandoRemision     = 0,
	 @NoValidarDisponible	 = 0,
         @Seccion		 = NULL,
         @ClavePresupuestal	 = NULL,
         @ClavePresupuestalImpuesto1 = NULL,
         @ArrastrarMovImpuestoRemision = 0, --MEJORA1002
         @MovImpuestoAplicaID = NULL,       --MEJORA1002
         @AplicaConcepto = NULL,            --MEJORA1002
         @AplicaFechaEmision = NULL,         --MEJORA1002
         @AnticipoFacturadoTipoServicio = NULL --ANTICIPOFACTURADO

		 
  SELECT @AlmacenOriginal = @Almacen, @AlmacenDestinoOriginal = @AlmacenDestino
  SELECT @GenerarAlmacen = @Almacen, @GenerarAlmacenDestino = @AlmacenDestino
  SELECT @Hoy = @FechaRegistro
  EXEC spExtraerFecha @Hoy OUTPUT

  SELECT @CfgDiasHabiles  = DiasHabiles, 
         @CP = ISNULL(CP, 0),
         @PPTO  = ISNULL(PPTO, 0),
         @PPTOVentas = ISNULL(PPTOVentas, 0),
         @WMS   = ISNULL(WMS, 0),
         @CfgAC = ISNULL(AC, 0),
         @FEA   = ISNULL(FEA, 0),
         @Fiscal = ISNULL(Fiscal, 0),
         @SubCuentaExplotarInformacion = ISNULL(SubCuentaExplotarInformacion, 0),
         @SAUX   = ISNULL(SAUX, 0),
         @LDI = ISNULL(InterfazLDI,0),--REQ 13386  
         @InterfazTC = ISNULL(InterfazTC,0), --REQ13163         
         @OPORT	= ISNULL(OPORT, 0), --REQ16092
         @CFGProdInterfazInfor = ISNULL(ProdInterfazInfor,0),
         @CfgEspacios = Espacios
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @CfgRetencionMov = CASE WHEN @MovTipo = 'COMS.D' THEN CxpDevRetencion ELSE CxpRetencion END,
         @CfgIngresoMov   = VentaIngreso,
         @CfgEstadisticaAjusteMerma = InvEstadisticaAjusteMerma
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @CfgArrastrarSerieLote = ISNULL(VentaArrastrarSerieLote, 0),
         @CfgNotasBorrador = NotasBorrador,
         @CfgCompraAutoEndosoAutoCargos = ISNULL(CompraAutoEndosoAutoCargos, 0),
         @VentaMovImpuestoDesdeRemision = ISNULL(VentaMovImpuestoDesdeRemision,0), --MEJORA1002
         @GenerarNCAlProcesar    = ISNULL(GenerarNCAlProcesar, 0),
         @CfgCostearDC = ISNULL(CompraCostearDCporMovimiento, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  --REQ12615 WMS
  IF @WMS = 1 AND @MovTipo = 'INV.EI' 
    UPDATE InvD SET Tarima = NULL WHERE ID = @ID

  --BUG3323
  IF @WMS = 1 AND @MovTipo = 'COMS.F' AND EXISTS(SELECT PosicionWMS FROM Compra WHERE ID = @ID AND NULLIF(PosicionWMS,'') IS NULL) AND EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND WMS = 1) --BUG3800
   SELECT @Ok=20922, @OkRef='Especifique una Posición (Anden)'

  IF @MovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR', 'VTAS.FM') AND @CfgNotasBorrador = 1 AND (@Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')  OR @Accion = 'CANCELAR')
    SELECT @NoValidarDisponible = 1

  IF @Modulo = 'VTAS' SELECT @AnticipoFacturadoTipoServicio = ISNULL(AnticipoFacturadoTipoServicio,0) FROM Venta WHERE ID = @ID --ANTICIPOFACTURADO

  SELECT @CfgRetencionAlPago      = ISNULL(RetencionAlPago, 0),
         @CfgRetencionAcreedor    = NULLIF(RTRIM(GastoRetencionAcreedor), ''),
         @CfgRetencionConcepto    = ISNULL(NULLIF(NULLIF(RTRIM(GastoRetencionConcepto), ''), '(Concepto Gasto)'), @Concepto),
         @CfgRetencion2Acreedor   = NULLIF(RTRIM(GastoRetencion2Acreedor), ''),
         @CfgRetencion2Concepto   = ISNULL(NULLIF(NULLIF(RTRIM(GastoRetencion2Concepto), ''), '(Concepto Gasto)'), @Concepto),
         @CfgRetencion3Acreedor   = NULLIF(RTRIM(GastoRetencion3Acreedor), ''),
         @CfgRetencion3Concepto   = ISNULL(NULLIF(NULLIF(RTRIM(GastoRetencion3Concepto), ''), '(Concepto Gasto)'), @Concepto),
         @CfgABCDiasHabiles       = ISNULL(InvFrecuenciaABCDiasHabiles, 0),
         @CfgInvAjusteCargoAgente = UPPER(InvAjusteCargoAgente),
         @CfgVentaDMultiAgenteSugerir = ISNULL(VentaDMultiAgenteSugerir, 0),
         @CfgVentaPuntosEnVales   = ISNULL(VentaPuntosEnVales, 0),
	 @CfgVentaMonedero        = ISNULL(VentaMonedero, 0), 	-- ETO Tarjetas 9-Feb-2007
         @CfgVentaMonederoA        = ISNULL(VentaMonederoA, 0), 	
         @CfgVentaArtEstatus	  = ISNULL(VentaArtEstatus, 0),
         @CfgVentaArtSituacion	  = ISNULL(VentaArtSituacion, 0),
         @CfgCostearTransferencias= ISNULL(InvCostearTransferencias, 0),
         @FiscalGenerarRetenciones= ISNULL(FiscalGenerarRetenciones, 0),
		 @EmbarqueSumaArtJuego	  = ISNULL(EmbarqueSumaArtJuego, 'Articulo Juego'),
         @ValuacionOtraMoneda		= NULLIF(InvValuacionOtraMoneda,''), --MEJORA6230
		 @ValuacionOtraMonedaTC     = CASE WHEN InvValuacionOtraMoneda = @MovMoneda THEN @MovTipoCambio ELSE dbo.fnTipoCambio(InvValuacionOtraMoneda) END, --MEJORA6230
		 @ValuacionOtraMonedaTCV    = dbo.fnTipoCambioVenta(InvValuacionOtraMoneda), --MEJORA6230
		 @ValuacionOtraMonedaTCC    = dbo.fnTipoCambioCompra(InvValuacionOtraMoneda) --MEJORA6230
		 
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa
   
  IF @SubClave = 'COMS.CE/GT' SELECT @CfgRetencionAlPago = 0

  EXEC spInvAfectarInit @Accion, @Empresa, @Sucursal, @MovTipo, @OrigenTipo, @Origen, @OrigenID, @IDOrigen OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @OrigenMovTipo = 'VTAS.OP' AND @IDOrigen IS NOT NULL AND @Accion <> 'CANCELAR'
    UPDATE Venta 
      SET Estatus = 'CONCLUIDO' 
    WHERE ID = @IDOrigen

  IF @Utilizar = 1
  BEGIN
    IF @Utilizar = 1 AND @MovTipo IN ('VTAS.DC', 'VTAS.DCR') SELECT @GenerarAlmacen = @AlmacenDestino, @GenerarAlmacenDestino = @Almacen
    IF @Accion = 'GENERAR' SELECT @GenerarEstatus = 'SINAFECTAR' ELSE SELECT @GenerarEstatus = 'CANCELADO' 
    IF @UtilizarMovTipo IN ('VTAS.C','VTAS.CS','VTAS.FR','VTAS.CTO','COMS.C') SELECT @GenerarDirecto = 1 ELSE SELECT @GenerarDirecto = 0
    IF @UtilizarMovTipo = 'VTAS.CO' AND @CfgVentaContratosArticulo IS NULL SELECT @Ok = 20470
    IF @VoltearAlmacen = 1 SELECT @AlmacenTemp = @GenerarAlmacen, @GenerarAlmacen = @GenerarAlmacenDestino, @GenerarAlmacenDestino = @AlmacenTemp  
    IF @Ok IS NULL
    BEGIN
      EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, @GenerarEstatus, 
	  	        @GenerarAlmacen, @GenerarAlmacenDestino,
                        @UtilizarMov, @UtilizarMovID, @GenerarDirecto, 
                        @Mov, @UtilizarSerie, @MovID OUTPUT, @ID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      IF @Ok IS NULL AND (@MovTipo IN ('INV.EI', 'INV.DTI', 'INV.SI', 'INV.TMA') OR (@UtilizarMovTipo IN ('VTAS.VCR', 'VTAS.P', 'VTAS.R', 'VTAS.C') AND @CfgArrastrarSerieLote = 1))
        EXEC spMovCopiarSerieLote @Sucursal, @Modulo, @UtilizarID, @ID, 1

				IF @MovTipo = 'INV.TMAZ' AND @Modulo = 'INV' 
				BEGIN
					DECLARE CrArticuloCantidad CURSOR FOR
					SELECT A.Mov, A.MovID, B.Renglon, B.RenglonID, B.Articulo, A.Almacen,
						   CASE @BASE WHEN 'Seleccion' THEN B.CantidadA 
									  WHEN 'Reservado' THEN B.CantidadReservada
									  WHEN 'Pendiente' THEN B.CantidadPendiente END,
						   C.SerieLote,
						   C.Cantidad
					  FROM Inv A 
					  JOIN InvD B ON A.ID = B.ID
					  JOIN SerieLoteMov C ON A.ID = C.ID AND A.Empresa = C.Empresa AND C.Modulo = 'INV' AND B.RenglonID = C.RenglonID
					 WHERE A.ID = @UtilizarID
                     ORDER BY B.Articulo
   
					 OPEN CrArticuloCantidad
					 FETCH NEXT FROM CrArticuloCantidad INTO @CrMov, @CrMovID, @CrRenglon, @CrRenglonID, @CrArticulo, @CrAlmacen, @CrCantidad, @CrSerieLote, @CrCantidadSL
					 
					 SET @CrCantidadAplicada = 0
					 
					 WHILE @@FETCH_STATUS = 0
					 BEGIN
                     --SELECT  @CrMov, @CrMovID, @CrRenglon, @CrRenglonID, @CrArticulo, @CrAlmacen, @CrCantidad, @CrSerieLote, @CrCantidadSL
                        IF @CrArticuloAnt <> @CrArticulo OR @CrRenglonID <> @CrRenglonIDAnt
                            SELECT @CrCantidadAplicada = 0, @CrCantidadDispSL = 0

						SELECT  @CrSLMArticulo = NULL, 
								@CrSLMSerieLote = NULL, 
								@CrSLMCantidad = NULL

						DECLARE CrSerieLoteMov CURSOR FOR
						 SELECT A.Articulo, A.SerieLote, SUM(A.Cantidad) Cantidad
						   FROM SerieLoteMov A
						   JOIN Inv B
						     ON A.ID = B.ID
						    AND A.Modulo = B.OrigenTipo
						  WHERE A.Empresa = @Empresa
						    AND B.Origen = @CrMov
						    AND B.OrigenID = @CrMovID
						    AND A.Articulo = @CrArticulo 
						    AND A.SerieLote = @CrSerieLote
						    AND A.Modulo = 'INV'
						    AND B.Estatus <> 'CANCELADO'
						    AND A.ID <> @UtilizarID
						    AND A.ID <> @ID
						    AND ISNULL(A.Tarima,'') <> ''
							AND ISNULL(a.Cantidad,0) > 0
					   GROUP BY A.Articulo, A.SerieLote
						
						OPEN CrSerieLoteMov
						FETCH NEXT FROM CrSerieLoteMov INTO @CrSLMArticulo, @CrSLMSerieLote, @CrSLMCantidad

						IF @CrSLMArticulo IS NULL
						BEGIN
							SELECT @CrCantidad = CASE WHEN @CrCantidadAplicada = 0 
													  THEN @CrCantidad 
													  ELSE @CrCantidad - @CrCantidadAplicada 
												 END

							IF @CrCantidad <= 0
								DELETE SerieLoteMov 
								 WHERE Empresa = @Empresa 
								   AND Modulo = 'INV'
								   AND ID = @ID
								   AND Articulo = @CrArticulo
								   AND SerieLote = @CrSerieLote

							IF (@CrRenglonAnt <> @CrRenglon OR @CrRenglonIDAnt <> @CrRenglonID OR @CrCantidad > 0)
							BEGIN
								SELECT @CrRenglonAnt = @CrRenglon, @CrRenglonIDAnt = @CrRenglonID, @CrArticuloAnt = @CrArticulo
								
								UPDATE SerieLoteMov SET Cantidad = CASE WHEN Cantidad <= @CrCantidad THEN Cantidad ELSE @CrCantidad END
								  FROM SerieLoteMov 
								 WHERE Empresa = @Empresa 
								   AND Modulo = 'INV'
								   AND ID = @ID
								   AND Articulo = @CrArticulo
								   AND SerieLote = @CrSerieLote

								SELECT @CrCantidadAplicada = @CrCantidadAplicada + CASE WHEN Cantidad <= @CrCantidad THEN Cantidad ELSE @CrCantidad END,
                                       @CrCantidadDispSL = @CrCantidadDispSL + CASE WHEN Cantidad <= @CrCantidad THEN Cantidad ELSE @CrCantidad END
								  FROM SerieLoteMov
								 WHERE Empresa = @Empresa 
								   AND Modulo = 'INV'
								   AND ID = @ID
								   AND Articulo = @CrArticulo
								   AND SerieLote = @CrSerieLote
							END

                            INSERT @Bandera (Articulo,    SerieLote,    CantidadDispSL,    SLMCantidad,    CantidadS,     Cantidad)
                                     VALUES (@CrArticulo, @CrSerieLote, @CrCantidadDispSL, @CrSLMCantidad, @CrCantidadSL, @CrCantidad)

                            INSERT @BanderaF (SerieLote, Articulo, Cantidad)
                                       SELECT SerieLote, Articulo, Cantidad
                                         FROM @Bandera
                                        WHERE Articulo = @CrArticulo
                                          AND SerieLote = @CrSerieLote
                                        GROUP BY SerieLote, Articulo, Cantidad
                                        
                            IF EXISTS (SELECT * FROM @BanderaF WHERE Articulo = @CrArticulo)
                                UPDATE @BanderaF SET CantidadDispSL = (SELECT SUM(ISNULL(CantidadDispSL,0)) CantidadDispSL
                                                                         FROM @Bandera
                                                                         WHERE Articulo = @CrArticulo
                                                                           AND SerieLote = @CrSerieLote
                                                                         GROUP BY Articulo)
                                WHERE Articulo = @CrArticulo
                                  AND SerieLote = @CrSerieLote
						END

						IF @CrSLMArticulo IS NOT NULL
						BEGIN
							SET @CrCantidadAplicada = ISNULL(@CrCantidadAplicada,0)
							SET @CrCantidadDispSL = ISNULL(@CrCantidadDispSL,0)
						END
					
						WHILE @@FETCH_STATUS = 0
						BEGIN
                            SET @CrCantidadDispSL = (@CrCantidadDispSL + (@CrCantidadSL - @CrSLMCantidad))
                            
                            INSERT @Bandera (Articulo,    SerieLote,    CantidadDispSL,    SLMCantidad,    CantidadS,     Cantidad)
                                     VALUES (@CrArticulo, @CrSerieLote, @CrCantidadDispSL, @CrSLMCantidad, @CrCantidadSL, @CrCantidad)

                            INSERT @BanderaF (SerieLote, Articulo, Cantidad)
                                       SELECT SerieLote, Articulo, Cantidad
                                         FROM @Bandera
                                        WHERE Articulo = @CrArticulo
                                          AND SerieLote = @CrSerieLote
                                        GROUP BY SerieLote, Articulo, Cantidad
                                        
                            IF EXISTS (SELECT * FROM @BanderaF WHERE Articulo = @CrArticulo)
                                UPDATE @BanderaF SET CantidadDispSL = (SELECT SUM(ISNULL(CantidadDispSL,0)) CantidadDispSL
                                                                         FROM @Bandera
                                                                         WHERE Articulo = @CrArticulo
                                                                           AND SerieLote = @CrSerieLote
                                                                         GROUP BY Articulo)
                                WHERE Articulo = @CrArticulo
                                  AND SerieLote = @CrSerieLote
                                

							IF @CrArticulo = @CrSLMArticulo AND @CrSerieLote = @CrSLMSerieLote AND @CrSLMCantidad <= @CrCantidadSL
							BEGIN
								UPDATE SerieLoteMov SET Cantidad = CASE WHEN @CrCantidadDispSL > @CrCantidad 
																		THEN @CrCantidad
																		ELSE @CrCantidadDispSL 
																   END
								 WHERE Empresa = @Empresa 
								   AND Modulo = 'INV'
								   AND ID = @ID
								   AND Articulo = @CrArticulo
								   AND SerieLote = @CrSLMSerieLote

								SELECT @CrCantidadAplicada = @CrCantidadAplicada + CASE WHEN @CrCantidadDispSL > @CrCantidad 
																						THEN @CrCantidad
																						ELSE @CrCantidadDispSL
																					END
							END
							FETCH NEXT FROM CrSerieLoteMov INTO @CrSLMArticulo, @CrSLMSerieLote, @CrSLMCantidad
						END
						
						CLOSE CrSerieLoteMov
						DEALLOCATE CrSerieLoteMov
						
						FETCH NEXT FROM CrArticuloCantidad INTO @CrMov, @CrMovID, @CrRenglon, @CrRenglonID, @CrArticulo, @CrAlmacen, @CrCantidad, @CrSerieLote, @CrCantidadSL
					 END
					 
					 CLOSE CrArticuloCantidad
					 DEALLOCATE CrArticuloCantidad

					 -- BUG7029
					 --IF @CrCantidad > @CrCantidadDispSL
						--		SELECT @Ok = 20020, @OkRef = 'Disponible:' + CAST(@CrCantidadDispSL AS VARCHAR(20))

					 DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID AND Cantidad = 0
                     
					 
					 IF @Ok IS NOT NULL 
						BEGIN
							DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID
							EXEC spEliminarMov @Modulo, @ID
						END
				END  --
    END

	INSERT @BanderaFinal  (Articulo, Cantidad, CantidadDispSL)
					SELECT Articulo, (SUM(Cantidad)/COUNT(Serielote)), SUM(CantidadDispSL)
					  FROM @BanderaF
					 GROUP BY Articulo

	IF EXISTS (SELECT * FROM @BanderaFinal WHERE Cantidad > CantidadDispSL)
	BEGIN
		SELECT @Ok = 20025, @OkRef = 'Articulo: ' + (SELECT TOP 1 Articulo FROM @BanderaFinal WHERE Cantidad > CantidadDispSL)
		EXEC spEliminarMov 'INV', @ID
		RETURN
	END

    IF @Ok IS NULL
      SELECT @YaGeneroConsecutivo = 1

    -- Copiar Detalles
    IF @Ok IS NULL
    BEGIN
      IF @MovTipo = 'VTAS.EG'
        UPDATE Venta SET AlmacenDestino = (SELECT AlmacenDestinoEntregaGarantia FROM EmpresaCfg WHERE Empresa = @Empresa) WHERE ID = @ID

      IF @UtilizarMovTipo = 'VTAS.CO'
      BEGIN
        UPDATE Venta SET Condicion = NULL, Vencimiento = NULL, Referencia = RTRIM(@UtilizarMov)+' '+LTRIM(CONVERT(CHAR, @UtilizarMovID)) WHERE ID = @ID
        SELECT @Precio = sum(Precio * (Cantidad-ISNULL(CantidadCancelada,0)) * (1-(case DescuentoTipo when '$' then (ISNULL(DescuentoLinea, 0.0)/precio)*100 else ISNULL(DescuentoLinea,0.0) end)/100))
          FROM VentaD
         WHERE ID = @UtilizarID
  
        INSERT INTO VentaD (Sucursal, ID, Renglon, Aplica, AplicaID, Articulo, Cantidad, Precio, Impuesto1, Almacen) 
                    VALUES (@Sucursal, @ID, 2048, @UtilizarMov, @UtilizarMovID, @CfgVentaContratosArticulo, 1, @Precio, @CfgVentaContratosImpuesto, @Almacen)
      END ELSE 
      BEGIN
        EXEC spInvUtilizarTodoDetalle @Sucursal, @Modulo, @Base, @UtilizarID, @UtilizarMov, @UtilizarMovID, @UtilizarMovTipo, @ID, @GenerarDirecto, @Ok OUTPUT, @Empresa = @Empresa, @MovTipo = @MovTipo

        /* Se agreaga el DELETE en esta linea ya que no debe existir el artículo en serielote mov si no esta en el detalle */
        DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID AND Articulo NOT IN (SELECT Articulo FROM INVD WHERE ID = @Id)

        --REQ7890
        IF @MovTipo IN ('COMS.EG', 'COMS.EI', 'COMS.OI', 'INV.EI') 
          EXEC spMovCopiarGastoDiverso @Modulo, @Sucursal, @UtilizarID, @ID

        IF @MovTipo IN ('VTAS.F','VTAS.FAR') AND @CfgLimiteRenFacturas > 0
          IF @FacturacionRapidaAgrupada = 1
            EXEC spInvLimiteRenFacturasAgrupada @ID, @CfgLimiteRenFacturas
          ELSE
            EXEC spInvLimiteRenFacturas @ID, @CfgLimiteRenFacturas

        IF @UtilizarMovTipo IN ('VTAS.VC', 'VTAS.VCR') AND @MovTipo NOT IN ('VTAS.DC', 'VTAS.DCR') UPDATE VentaD  SET Almacen = @GenerarAlmacen WHERE ID = @ID ELSE
        IF @UtilizarMovTipo = 'INV.P'   UPDATE InvD SET Almacen = @GenerarAlmacenDestino WHERE ID = @ID ELSE
        IF @UtilizarMovTipo = 'INV.SM' AND @MovTipo = 'INV.CM' UPDATE InvD SET Tipo = 'Salida' WHERE ID = @ID ELSE
        IF @UtilizarMovTipo = 'PROD.O' AND @MovTipo IN ('PROD.E', 'PROD.CO')
        BEGIN
          IF @CfgTipoMerma = '#'
            UPDATE ProdD 
               SET Tipo = 'Entrada', 
                   Cantidad = Cantidad - ISNULL(a.Merma, 0) - ISNULL(a.Desperdicio, 0),
                   Merma = a.Merma,
                   Desperdicio  = a.Desperdicio
              FROM ProdD d, Art a
             WHERE d.Articulo = a.Articulo AND d.ID = @ID
          ELSE
            UPDATE ProdD 
               SET Tipo = 'Entrada', 
                   Cantidad = Cantidad - ISNULL(ROUND(d.Cantidad*(a.Merma/100), 10), 0) - ISNULL(ROUND(d.Cantidad*(a.Desperdicio/100), 10), 0),
                   Merma = ROUND(d.Cantidad*(a.Merma/100), 10),
                   Desperdicio  = ROUND(d.Cantidad*(a.Desperdicio/100), 10)                 
              FROM ProdD d, Art a
             WHERE d.Articulo = a.Articulo AND d.ID = @ID

          UPDATE ProdD SET CantidadInventario = Cantidad * Factor WHERE ID = @ID
        END
      END
      SELECT @UtilizarBase = @Base, @Base = 'TODO', @IDGenerar = @ID
    END
  END ELSE
    IF @VoltearAlmacen = 1 SELECT @AlmacenTemp = @GenerarAlmacen, @GenerarAlmacen = @GenerarAlmacenDestino, @GenerarAlmacenDestino = @AlmacenTemp  


  /* Otras Afectaciones */
  IF @Modulo = 'VTAS' AND @Accion <> 'CANCELAR' AND @Estatus = 'SINAFECTAR'
    IF EXISTS(SELECT ConVigencia FROM Venta WHERE ID = @ID AND ConVigencia = 1)
      UPDATE Cte 
         SET VigenciaDesde = v.VigenciaDesde, VigenciaHasta = v.VigenciaHasta
        FROM Venta v
       WHERE v.ID = @ID AND v.Cliente = Cte.Cliente

  IF @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN
    IF @Utilizar = 1 
    BEGIN
      -- Leer MovTipo, Periodo y Ejercicio	
      EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT

      BEGIN TRANSACTION
      
      IF @UtilizarMovTipo IN ('VTAS.C', 'VTAS.CS', 'COMS.C')
      BEGIN
        EXEC spValidarTareas @Empresa, @Modulo, @UtilizarID, 'CONCLUIDO', @Ok OUTPUT, @OkRef OUTPUT
        IF @UtilizarMovTipo IN ('VTAS.C', 'VTAS.CS') UPDATE Venta SET Estatus = 'CONCLUIDO' WHERE ID = @UtilizarID ELSE
        IF @UtilizarMovTipo = 'COMS.C' UPDATE Compra SET Estatus = 'CONCLUIDO' WHERE ID = @UtilizarID 
        IF @@ERROR <> 0 SELECT @Ok = 1

        -- 6777
        --EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @UtilizarID, @UtilizarMov, @UtilizarMovID, @Modulo, @ID, @Mov, 0, @Ok OUTPUT 
      END

      IF @UtilizarBase = 'SELECCION'
        EXEC spInvAfectarUtilizarSeleccion @Modulo, @UtilizarID, @Ok OUTPUT, @OkRef OUTPUT      
    
      IF @CfgVentaArtAlmacenEspecifico = 1 AND @Modulo = 'VTAS'
      BEGIN
        IF @CfgVentaMultiAlmacen = 0
        BEGIN
          SELECT @AlmacenEspecificoVenta = NULL
          SELECT @AlmacenEspecificoVenta = MIN(NULLIF(RTRIM(AlmacenEspecificoVenta), ''))
            FROM Art a, VentaD d
           WHERE d.ID = @ID AND d.Articulo = a.Articulo AND a.AlmacenEspecificoVentaMov = @Mov AND NULLIF(RTRIM(a.AlmacenEspecificoVenta), '') IS NOT NULL
          IF @AlmacenEspecificoVenta IS NOT NULL
            UPDATE Venta SET Almacen = @AlmacenEspecificoVenta WHERE ID = @ID
        END ELSE
          UPDATE VentaD
             SET Almacen = NULLIF(RTRIM(AlmacenEspecificoVenta), '')
            FROM VentaD d, Art a
           WHERE d.ID = @ID AND d.Articulo = a.Articulo AND a.AlmacenEspecificoVentaMov = @Mov AND NULLIF(RTRIM(a.AlmacenEspecificoVenta), '') IS NOT NULL
      END

      IF @UtilizarMovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR', 'VTAS.FM') AND @MovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR', 'VTAS.FM')
      BEGIN
        UPDATE VentaD SET Cantidad = -ABS(Cantidad), CantidadInventario = -ABS(CantidadInventario), Aplica = NULL, AplicaID = NULL WHERE ID = @ID
        UPDATE Venta  SET Directo = 1, Referencia = RTRIM(@UtilizarMov)+' '+RTRIM(@UtilizarMovID) WHERE ID = @ID
      END
      IF @UtilizarMovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR', 'VTAS.FM') AND @MovTipo = 'VTAS.SD'
      BEGIN
        UPDATE VentaD SET Aplica = NULL, AplicaID = NULL WHERE ID = @ID
        UPDATE Venta  SET Directo = 1, Referencia = RTRIM(@UtilizarMov)+' '+RTRIM(@UtilizarMovID) WHERE ID = @ID
      END

      IF @Modulo = 'VTAS' 
      BEGIN
        IF @MovTipo IN ('VTAS.N', 'VTAS.FM')
          UPDATE Venta SET Condicion = NULL, Vencimiento = NULL WHERE ID = @ID
        ELSE
        IF @MovTipo <> 'VTAS.FR' 
        BEGIN
          EXEC spCalcularVencimiento @Modulo, @Empresa, @ClienteProv, @Condicion, @Hoy, @Vencimiento OUTPUT, NULL, @Ok OUTPUT             
          UPDATE Venta SET Vencimiento = @Vencimiento WHERE ID = @ID AND Vencimiento <> @Vencimiento
        END
      END

      IF @UtilizarMovTipo = 'INV.P'
        UPDATE Inv SET Almacen = AlmacenDestino, AlmacenDestino = Almacen WHERE ID = @ID 

		--COMENTARIO_0001

     IF @MovTipo IN ('PROD.A', 'PROD.R', 'PROD.E')
       EXEC spProdAvanceTiempoCentro @ID, @MovTipo, @MovMoneda, @MovTipoCambio

     IF @GenerarMovTipo = 'INV.TMA' AND (SELECT WMSSugerirEntarimado FROM EmpresaCfg WHERE Empresa = @Empresa) = 1
	 BEGIN	
		--8. Desarrollo de proceso Cross Docking
		 SELECT @OrigenP   = Origen,
				@OrigenIDP = OrigenID
		   FROM INV 
		  WHERE ID = @ID

		 SELECT @IDN = ID 
		   FROM INV 
		  WHERE MOV   = @OrigenP 
			AND MOVID = @OrigenIDP

		SELECT @CrossDocking = CrossDocking, 
			   @Almacen      = Almacen,
			   @PosicionWMS  = PosicionWMS
		  FROM INV 
		 WHERE ID = @IDN

		 SELECT @EsCrossDocking = RTRIM(LTRIM(ISNULL(EsCrossDocking,''))), --SI, NO
				@posicioncrossdocking = ISNULL(defposicioncrossdocking,'') 
		   FROM ALM 
		  WHERE Almacen = @Almacen 

		 IF @posicioncrossdocking = '' AND @CrossDocking = 1
		 BEGIN
			SELECT @Ok    = Mensaje, 
				   @OkRef = Descripcion
			  FROM MensajeLista 
			 WHERE Mensaje = 20028

			 SELECT @OkRef
			 ROLLBACK TRANSACTION
			 EXEC spEliminarMov @Modulo, @ID
			 RETURN
		 END

		 IF @EsCrossDocking = '' AND @CrossDocking = 1
		 BEGIN
			SELECT @Ok    = Mensaje, 
				   @OkRef = Descripcion
			  FROM MensajeLista 
			 WHERE Mensaje = 20027

			 SELECT @OkRef
			 ROLLBACK TRANSACTION
			 EXEC spEliminarMov @Modulo, @ID
			 RETURN
		 END

		 IF @CrossDocking = 1 AND @EsCrossDocking IN ('Si','No')
		 BEGIN
			EXEC spEntarimarCrossDoking @Modulo, @IDGenerar, @Empresa, @ID, @Almacen, @PosicionWMS
		 END
		 ELSE     
		   EXEC spSugerirEntarimado @Modulo, @IDGenerar, @Empresa, @Sucursal, @Usuario, @Ok OUTPUT, @OkRef OUTPUT
	 END

     --TASK25114. OJO: Este bloque si esta habilitado para el cliente SSFA
     --REQ12615 WMS
	 
	 --IF @WMS = 1 
  --     IF EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND WMS = 1 AND SugerirSurtidoTarima = 1)
  --       IF EXISTS(SELECT * FROM AlmSugerirSurtidoTarima WHERE Almacen = @Almacen AND Modulo = @Modulo AND Mov = @Mov)
  --     	   EXEC spAutoSurtirTarima @Estacion, @Empresa, @Modulo, @IDGenerar, @Mov, @MovID, @Almacen, 1, @Ok OUTPUT, @OkRef OUTPUT
	
	 --REQ12615 WMS
   
      IF @Ok IS NULL
        EXEC xpInvAfectar @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
      	     	          @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal,
			  @UtilizarID, @UtilizarMovTipo,
                          @Ok OUTPUT, @OkRef OUTPUT

      EXEC spInvProdSerieLoteDesdeOrden @Sucursal,@Modulo,@UtilizarID, @ID,1, @Accion, @Ok OUTPUT, @OkRef OUTPUT  
  
      IF @LDI = 1 AND @Ok IS NOT NULL AND EXISTS(SELECT * FROM LDIIDTemp WHERE Estacion = @@SPID AND Modulo = @Modulo)
      BEGIN
        INSERT @LDILog(IDModulo, Modulo, Servicio, Fecha, TipoTransaccion, TipoSubservicio, CodigoRespuesta, DescripcionRespuesta, OrigenRespuesta, InfoAdicional, IDTransaccion, CodigoAutorizacion, Comprobante, Cadena, CadenaRespuesta, Importe, RIDCobro) 
        SELECT IDModulo, Modulo, Servicio, Fecha, TipoTransaccion, TipoSubservicio, CodigoRespuesta, DescripcionRespuesta, OrigenRespuesta, InfoAdicional, IDTransaccion, CodigoAutorizacion, Comprobante, Cadena, CadenaRespuesta, Importe, RIDCobro
          FROM LDIMovLog 
         WHERE IDModulo = @ID AND ID IN(SELECT ID FROM LDIIDTemp WHERE Estacion = @@SPID AND Modulo = @Modulo)
      END

--SELECT @Ok = 1 -- breakpoint generar
      IF @Ok IS NULL
        COMMIT TRANSACTION
      ELSE BEGIN
        ROLLBACK TRANSACTION
        EXEC spEliminarMov @Modulo, @ID
        IF EXISTS(SELECT * FROM @LDILog)
        BEGIN
          INSERT LDIMovLog(IDModulo, Modulo, Servicio, Fecha, TipoTransaccion, TipoSubservicio, CodigoRespuesta, DescripcionRespuesta, OrigenRespuesta, InfoAdicional, IDTransaccion, CodigoAutorizacion, Comprobante, Cadena, CadenaRespuesta, Importe, RIDCobro) 
          SELECT IDModulo, Modulo, Servicio, Fecha, TipoTransaccion, TipoSubservicio, CodigoRespuesta, DescripcionRespuesta, OrigenRespuesta, InfoAdicional, IDTransaccion, CodigoAutorizacion, Comprobante, Cadena, CadenaRespuesta, Importe, RIDCobro    
            FROM @LDILog
        END
      END
    END
    RETURN
  END

  IF @MovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR') AND @Accion = 'CANCELAR' AND @Estatus = 'CONCLUIDO'
    SELECT @Ok = 60060



  IF (@EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO') AND @Modulo IN ('VTAS', 'COMS') AND
     @MovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR', 'VTAS.FM', 'VTAS.F', 'VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.FB', 'VTAS.D', 'VTAS.DF', 'VTAS.B', 'COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI', 'COMS.D', 'COMS.B', 'COMS.CC', 'COMS.DC', 'COMS.CA', 'COMS.O') )
     OR (@EstatusNuevo = 'PROCESAR' AND @MovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR'))
     OR (@EstatusNuevo = 'PENDIENTE' AND @MovTipo IN ('VTAS.VCR','VTAS.R') AND @VentaMovImpuestoDesdeRemision = 1)  --MEJORA1002
     OR (@MovTipo IN ('VTAS.DCR') AND @EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO') AND @Modulo = 'VTAS' AND @VentaMovImpuestoDesdeRemision = 1) --MEJORA1002
  BEGIN    
    SELECT @MovImpuesto = 1
    CREATE TABLE #MovImpuesto (
    Renglon			float		NOT NULL,
	RenglonSub		int		NOT NULL,

	Impuesto1		float		NULL,
	Impuesto2		float		NULL,
	Impuesto3		float		NULL,
	Impuesto5		float		NULL,
	Importe1		money		NULL,
	Importe2		money		NULL,
	Importe3		money		NULL,
	Importe5		money		NULL,
	Retencion1		float		NULL,
	Retencion2		float		NULL,
	Retencion3		float		NULL,
	Excento1		bit		NULL	DEFAULT 0,
	Excento2		bit		NULL	DEFAULT 0,
	Excento3		bit		NULL	DEFAULT 0,
    TipoImpuesto1		varchar(10)	COLLATE Database_Default NULL,
    TipoImpuesto2		varchar(10)	COLLATE Database_Default NULL,
    TipoImpuesto3		varchar(10)	COLLATE Database_Default NULL,
    TipoImpuesto5		varchar(10)	COLLATE Database_Default NULL,
    TipoRetencion1		varchar(10)	COLLATE Database_Default NULL,
    TipoRetencion2		varchar(10)	COLLATE Database_Default NULL,
    TipoRetencion3		varchar(10)	COLLATE Database_Default NULL,
	SubTotal			money		NULL,
	ContUso				varchar(20)	COLLATE Database_Default NULL,
	ContUso2			varchar(20)	COLLATE Database_Default NULL,
	ContUso3			varchar(20)	COLLATE Database_Default NULL, 
	ClavePresupuestal	varchar(50)	COLLATE Database_Default NULL, 
	ClavePresupuestalImpuesto1 varchar(50)	COLLATE Database_Default NULL,  
	DescuentoGlobal				float	NULL,
	LoteFijo					varchar(20)	COLLATE Database_Default NULL,
	ImporteBruto				money		NULL,
	OrigenModulo		varchar(5)	COLLATE Database_Default NULL,			--MEJORA1002
	OrigenModuloID		int			NULL,									--MEJORA1002
	OrigenConcepto		varchar(50)	COLLATE Database_Default NULL,			--MEJORA1002
	OrigenFecha     	datetime	NULL									--MEJORA1002
	)
  END

  -- Aqui estaba spMovGenerar
  IF @CobroIntegrado = 1 AND @CfgVentaComisionesCobradas = 1 AND @CfgComisionBase = 'COBRO'
  BEGIN
    SELECT @ComisionFactor = 1-ABS(ISNULL(DelEfectivo / NULLIF((ISNULL(Importe1, 0) + ISNULL(Importe2, 0) + ISNULL(Importe3, 0) + ISNULL(Importe4, 0) + ISNULL(Importe5, 0) - ISNULL(Cambio, 0) + ISNULL(DelEfectivo, 0)), 0), 0.0))
      FROM VentaCobro
     WHERE ID = @ID
  END

  IF @MovTipo = 'INV.CP' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion = 'AFECTAR'
    EXEC spAfectarCambioPresentacion @Sucursal, @ID, @Empresa, @MovMoneda, @MovTipoCambio, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CfgFormaCosteo, @CfgTipoCosteo, @Ok OUTPUT, @OkRef OUTPUT

  -- Asignar el Consecutivo al Movimiento
  IF @Ok IS NULL AND @YaGeneroConsecutivo = 0 
    EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

  IF @EstatusNuevo = 'CONFIRMAR' AND @MovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR', 'VTAS.FM') RETURN

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID, @Sucursal = @SucursalDestino
    RETURN
  END

  IF @Generar = 1 AND @Ok IS NULL  -- Este bloque se movio
  BEGIN
    IF @MovTipo = 'INV.IF' SELECT @GenerarEstatus = 'SINAFECTAR' ELSE SELECT @GenerarEstatus = 'CANCELADO'
    IF @MovTipo IN ('VTAS.C','VTAS.CS','VTAS.FR') SELECT @GenerarDirecto = 1 ELSE SELECT @GenerarDirecto = 0

    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, @GenerarEstatus, 
		      @Almacen, @AlmacenDestino,
                      @Mov, @MovID, @GenerarDirecto, 
                      @GenerarMov, @GenerarSerie, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END

  -- Si hay Error Regresar
  IF @Ok IS NOT NULL OR @AfectarConsecutivo = 1 RETURN

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Actualizar Sucursal Detalle
    IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
    BEGIN
      IF (SELECT Sincro FROM Version) = 1
      BEGIN
        IF @Modulo = 'INV'  EXEC sp_executesql N'UPDATE InvD    SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID ELSE
        IF @Modulo = 'VTAS' EXEC sp_executesql N'UPDATE VentaD  SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID ELSE
        IF @Modulo = 'COMS' EXEC sp_executesql N'UPDATE CompraD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID ELSE
        IF @Modulo = 'PROD' EXEC sp_executesql N'UPDATE ProdD   SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
      END
    END

	--TASK25114
	--BUG24540
    IF @Modulo ='INV' AND @WMS = 1 AND @Accion = 'AFECTAR' AND @MovTipo = 'INV.A' AND @OrigenMovTipo = 'INV.IF'
    BEGIN
      UPDATE Tarima
         SET Estatus = 'BAJA',
             Baja = GETDATE()
             /*,Alta = NULL*/ --BUG3040
        FROM Tarima
        JOIN InvD   ON Tarima.Posicion = InvD.PosicionReal
        JOIN Inv    ON InvD.ID = Inv.ID
        JOIN AlmPos ON Inv.Almacen = AlmPos.Almacen AND InvD.PosicionReal = AlmPos.Posicion
       WHERE InvD.ID = @ID
         AND AlmPos.Tipo <> 'DOMICILIO'
    END
	
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC xpInvAfectarAntes @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
    	     	             @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal,
      			     NULL, NULL,
                             @Ok OUTPUT, @OkRef OUTPUT

    IF @Accion <> 'CANCELAR' AND @Estatus <> 'PENDIENTE'
    BEGIN
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                         	 @Concepto, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT
    END

    IF @MovTipo IN ('PROD.A', 'PROD.R', 'PROD.E') AND @Ok IS NULL
    BEGIN
      EXEC spProdCostearAvance @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                               @FechaEmision, @FechaRegistro, @Usuario, @Proyecto, @Ejercicio, @Periodo, @Referencia, @Observaciones,
                               @Ok OUTPUT, @OkRef OUTPUT

      IF @Estatus = 'SINAFECTAR' OR @Accion = 'CANCELAR'
        EXEC spProdAvance @Sucursal, @Accion, @Empresa, @FechaEmision, @FechaRegistro, @Usuario, @ID, @Mov, @MovID, @MovTipo, @Ok OUTPUT, @OkRef OUTPUT 
    END

    IF @MovTipo = 'PROD.E' AND @EstatusNuevo = 'CONCLUIDO' AND @Accion <> 'CANCELAR' AND @Ok IS NULL
      EXEC spProdCostearEntrada @Empresa, @ID, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.FB') AND @CobroIntegrado = 0 AND @FacturarVtasMostrador = 0 AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
      EXEC xpOtrosCargos @Empresa, @ID, @ClienteProv, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT

    -- Afectar el Detalle
    IF @AfectarDetalle = 1 AND @Ok IS NULL
    BEGIN
      IF @Accion = 'CANCELAR' OR (@MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND @EstatusNuevo = 'PENDIENTE') SELECT @MatarAntes = 1 ELSE SELECT @MatarAntes = 0
      IF @AfectarMatando = 1 AND @Utilizar = 0 AND @MatarAntes = 1 AND @Ok IS NULL 
        EXEC spInvMatar @Sucursal, @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
			@Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Ejercicio, @Periodo, @AfectarConsignacion, @AlmacenTipo, @AlmacenDestinoTipo,
			@CfgVentaSurtirDemas, @CfgCompraRecibirDemas, @CfgTransferirDemas, @CfgBackOrders, @CfgContX, @CfgContXGenerar, @CfgEmbarcar, @CfgImpInc, @CfgMultiUnidades, @CfgMultiUnidadesNivel,
                       	@Ok OUTPUT, @OkRef OUTPUT, 
			@CfgPrecioMoneda = @CfgPrecioMoneda
      -- Definir el Cursor del Detalle
      IF @Modulo = 'VTAS'
      BEGIN
        DECLARE crVentaDetalle CURSOR
           FOR SELECT d.Renglon, d.RenglonSub, d.RenglonID, d.RenglonTipo, ISNULL(d.Cantidad, 0.0), ISNULL(d.CantidadObsequio, 0.0), ISNULL(d.CantidadInventario, 0.0), ISNULL(d.CantidadReservada, 0.0), ISNULL(d.CantidadOrdenada, 0.0), ISNULL(d.CantidadPendiente, 0.0), ISNULL(d.CantidadA, 0.0), ISNULL(d.Factor, 0.0), NULLIF(RTRIM(d.Unidad), ''), d.Articulo, NULLIF(RTRIM(d.Subcuenta), ''), ISNULL(d.Costo, 0.0), ISNULL(d.Precio, 0.0), NULLIF(RTRIM(d.DescuentoTipo), ''), ISNULL(d.DescuentoLinea, 0.0), ISNULL(d.Impuesto1, 0.0), ISNULL(d.Impuesto2, 0.0), ISNULL(d.Impuesto3, 0.0), NULLIF(RTRIM(d.Aplica), ''), NULLIF(RTRIM(d.AplicaID), ''), d.Almacen, d.Agente, NULLIF(RTRIM(UPPER(a.Tipo)), ''), a.SerieLoteInfo, NULLIF(RTRIM(UPPER(a.TipoOpcion)), ''), ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0), a.Unidad, ISNULL(d.Retencion1, 0.0), ISNULL(d.Retencion2, 0.0), ISNULL(d.Retencion3, 0.0), d.UltimoReservadoCantidad, d.UltimoReservadoFecha, NULLIF(RTRIM(a.Comision), ''), NULLIF(RTRIM(d.Espacio), ''), a.LotesFijos, a.Actividades, a.CostoIdentificado, d.CostoUEPS, d.CostoPEPS, d.UltimoCosto, d.CostoEstandar, d.PrecioLista, d.PrecioTipoCambio, NULLIF(RTRIM(d.Posicion), ''), NULLIF(RTRIM(d.Tarima), ''), 
                      a.DepartamentoDetallista, a.Estatus, a.Situacion, a.Impuesto1Excento, a.Excento2, a.Excento3, d.TipoImpuesto1, d.TipoImpuesto2, d.TipoImpuesto3, a.TipoRetencion1, a.TipoRetencion2, a.TipoRetencion3, d.ContUso, d.ContUso2, d.ContUso3,
                      d.Retencion1, d.Retencion2, d.Retencion3, ISNULL(d.AnticipoFacturado,0) --ANTICIPOFACTURADO
                 FROM VentaD d, Art a
                WHERE d.ID = @ID
                  AND d.Articulo = a.Articulo
        OPEN crVentaDetalle
        FETCH NEXT FROM crVentaDetalle  INTO @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @CantidadOriginal, @CantidadObsequio, @CantidadInventario, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @CantidadA, @Factor, @MovUnidad, @Articulo, @Subcuenta, @Costo, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @AplicaMov, @AplicaMovID, @AlmacenRenglon, @AgenteRenglon, @ArtTipo, @ArtSerieLoteInfo, @ArtTipoOpcion, @Peso, @Volumen, @ArtUnidad, @MovRetencion1, @MovRetencion2, @MovRetencion3, @UltReservadoCantidad, @UltReservadoFecha, @ArtComision, @EspacioD, @ArtLotesFijos, @ArtActividades, @ArtCostoIdentificado, @ArtCostoUEPS, @ArtCostoPEPS, @ArtUltimoCosto, @ArtCostoEstandar, @ArtPrecioLista, @PrecioTipoCambio, @Posicion, @Tarima, @ArtDepartamentoDetallista, @ArtEstatus, @ArtSituacion, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @ContUso, @ContUso2, @ContUso3, @Retencion1, @Retencion2, @Retencion3, @AnticipoFacturado--ANTICIPOFACTURADO
        IF @@ERROR <> 0 SELECT @Ok = 1
        
      END ELSE
      IF @Modulo = 'COMS'
      BEGIN
        DECLARE crCompraDetalle CURSOR
           FOR SELECT d.Renglon, d.RenglonSub, d.RenglonID, d.RenglonTipo, ISNULL(d.Cantidad, 0.0), ISNULL(d.CantidadInventario, 0.0), d.Cantidad, d.Cantidad, ISNULL(d.CantidadPendiente, 0.0), ISNULL(d.CantidadA, 0.0), d.Factor, NULLIF(RTRIM(d.Unidad), ''), d.Articulo, NULLIF(RTRIM(d.Subcuenta), ''), ISNULL(d.Costo, 0.0), ISNULL(d.Costo, 0.0), NULLIF(RTRIM(d.DescuentoTipo), ''), ISNULL(d.DescuentoLinea, 0.0), ISNULL(d.Impuesto1, 0.0), ISNULL(d.Impuesto2, 0.0), ISNULL(d.Impuesto3, 0.0), ISNULL(d.Impuesto5, 0.0), NULLIF(RTRIM(d.Aplica), ''), NULLIF(RTRIM(d.AplicaID), ''), d.Almacen, d.ServicioArticulo, d.ServicioSerie, NULLIF(RTRIM(UPPER(a.Tipo)), ''), a.SerieLoteInfo, NULLIF(RTRIM(UPPER(a.TipoOpcion)), ''), ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0), a.Unidad, ISNULL(d.Retencion1, 0.0), ISNULL(d.Retencion2, 0.0), ISNULL(d.Retencion3, 0.0), a.LotesFijos, a.Actividades, a.CostoIdentificado, d.CostoUEPS, d.CostoPEPS, d.UltimoCosto, d.CostoEstandar, d.PrecioLista, NULLIF(RTRIM(d.Posicion), ''), NULLIF(RTRIM(d.Tarima), ''), 
                      a.DepartamentoDetallista, a.Estatus, a.Situacion, a.Impuesto1Excento, a.Excento2, a.Excento3, d.TipoImpuesto1, d.TipoImpuesto2, d.TipoImpuesto3, d.TipoImpuesto5, d.TipoRetencion1, d.TipoRetencion2, d.TipoRetencion3, d.ContUso, d.ContUso2, d.ContUso3, d.ClavePresupuestal, d.FechaCaducidad,
                      d.Retencion1, d.Retencion2, d.Retencion3, ISNULL(d.PosicionActual,''), ISNULL(PosicionReal,'') --TASK25114
                 FROM CompraD d, Art a
                WHERE d.ID = @ID
                  AND d.Articulo = a.Articulo
        OPEN crCompraDetalle
        FETCH NEXT FROM crCompraDetalle INTO @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @CantidadOriginal, @CantidadInventario, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @CantidadA, @Factor, @MovUnidad, @Articulo, @Subcuenta, @Costo, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @AplicaMov, @AplicaMovID, @AlmacenRenglon, @ServicioArticulo, @ServicioSerie, @ArtTipo, @ArtSerieLoteInfo, @ArtTipoOpcion, @Peso, @Volumen, @ArtUnidad, @MovRetencion1, @MovRetencion2, @MovRetencion3, @ArtLotesFijos, @ArtActividades, @ArtCostoIdentificado, @ArtCostoUEPS, @ArtCostoPEPS, @ArtUltimoCosto, @ArtCostoEstandar, @ArtPrecioLista, @Posicion, @Tarima, @ArtDepartamentoDetallista, @ArtEstatus, @ArtSituacion, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @ContUso, @ContUso2, @ContUso3, @ClavePresupuestal, @FechaCaducidad, @Retencion1, @Retencion2, @Retencion3, @PosicionActual, @PosicionReal  --TASK25114
        IF @@ERROR <> 0 SELECT @Ok = 1
      END ELSE
      IF @Modulo = 'INV'
      BEGIN
        DECLARE crInvDetalle CURSOR
           FOR SELECT d.Renglon, d.RenglonSub, d.RenglonID, d.RenglonTipo, ISNULL(d.Cantidad, 0.0), ISNULL(d.CantidadInventario, 0.0), ISNULL(d.CantidadReservada, 0.0), ISNULL(d.CantidadOrdenada, 0.0), ISNULL(d.CantidadPendiente, 0.0), ISNULL(d.CantidadA, 0.0), d.Factor, NULLIF(RTRIM(d.Unidad), ''), d.Articulo, NULLIF(RTRIM(d.Subcuenta), ''), ISNULL(d.Costo, 0.0), CONVERT(money, NULL), '$', CONVERT(money, NULL), CONVERT(float, NULL), CONVERT(float, NULL), CONVERT(money, NULL), NULLIF(RTRIM(d.Aplica), ''), NULLIF(RTRIM(d.AplicaID), ''), d.Almacen, d.ProdSerieLote, NULLIF(RTRIM(UPPER(a.Tipo)), ''), a.SerieLoteInfo, NULLIF(RTRIM(UPPER(a.TipoOpcion)), ''), ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0), a.Unidad, d.UltimoReservadoCantidad, d.UltimoReservadoFecha, d.Tipo, d.Producto, d.SubProducto, a.LotesFijos, a.Actividades, a.CostoIdentificado, d.CostoUEPS, d.CostoPEPS, d.UltimoCosto, d.CostoEstandar, d.PrecioLista, NULLIF(RTRIM(d.Posicion), ''), NULLIF(RTRIM(d.Tarima), ''), 
                      a.DepartamentoDetallista, a.Estatus, a.Situacion, a.Impuesto1Excento, a.Excento2, a.Excento3, a.TipoImpuesto1, a.TipoImpuesto2, a.TipoImpuesto3, a.TipoRetencion1, a.TipoRetencion2, a.TipoRetencion3, d.Seccion, d.FechaCaducidad, d.PosicionDestino, ISNULL(d.PosicionActual,''), ISNULL(PosicionReal,'') --TASK25114
                 FROM InvD d, Art a
                WHERE d.ID = @ID
                  AND d.Articulo = a.Articulo
        OPEN crInvDetalle
        FETCH NEXT FROM crInvDetalle INTO @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @CantidadOriginal, @CantidadInventario, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @CantidadA, @Factor, @MovUnidad, @Articulo, @Subcuenta, @Costo, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @AplicaMov, @AplicaMovID, @AlmacenRenglon, @ProdSerieLote, @ArtTipo, @ArtSerieLoteInfo, @ArtTipoOpcion, @Peso, @Volumen, @ArtUnidad, @UltReservadoCantidad, @UltReservadoFecha, @DetalleTipo, @Producto, @SubProducto, @ArtLotesFijos, @ArtActividades, @ArtCostoIdentificado, @ArtCostoUEPS, @ArtCostoPEPS, @ArtUltimoCosto, @ArtCostoEstandar, @ArtPrecioLista, @Posicion, @Tarima, @ArtDepartamentoDetallista, @ArtEstatus, @ArtSituacion, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @Seccion, @FechaCaducidad, @PosicionDestino, @PosicionActual, @PosicionReal  --TASK25114
        IF @@ERROR <> 0 SELECT @Ok = 1
      END ELSE
      IF @Modulo = 'PROD'
      BEGIN
        DECLARE crProdDetalle CURSOR
           FOR SELECT d.Renglon, d.RenglonSub, d.RenglonID, d.RenglonTipo, ISNULL(d.Cantidad, 0.0), ISNULL(d.CantidadInventario, 0.0), ISNULL(d.CantidadReservada, 0.0), ISNULL(d.CantidadOrdenada, 0.0), ISNULL(d.CantidadPendiente, 0.0), ISNULL(d.CantidadA, 0.0), d.Factor, NULLIF(RTRIM(d.Unidad), ''), d.Articulo, NULLIF(RTRIM(d.Subcuenta), ''), ISNULL(d.Costo, 0.0), CONVERT(money, NULL), '$', CONVERT(money, NULL), CONVERT(float, NULL), CONVERT(float, NULL), CONVERT(money, NULL), NULLIF(RTRIM(d.Aplica), ''), NULLIF(RTRIM(d.AplicaID), ''), d.Almacen, NULLIF(RTRIM(d.ProdSerieLote), ''), NULLIF(RTRIM(UPPER(a.Tipo)), ''), a.SerieLoteInfo, NULLIF(RTRIM(UPPER(a.TipoOpcion)), ''), ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0), a.Unidad, d.UltimoReservadoCantidad, d.UltimoReservadoFecha, d.Tipo, d.Merma, d.Desperdicio, d.Ruta, d.Orden, d.Centro, a.LotesFijos, a.Actividades, a.CostoIdentificado, d.CostoUEPS, d.CostoPEPS, d.UltimoCosto, d.CostoEstandar, d.PrecioLista, NULLIF(RTRIM(d.Posicion), ''), NULLIF(RTRIM(d.Tarima), ''), 
                      a.DepartamentoDetallista, a.Estatus, a.Situacion, a.Impuesto1Excento, a.Excento2, a.Excento3, a.TipoImpuesto1, a.TipoImpuesto2, a.TipoImpuesto3, a.TipoRetencion1, a.TipoRetencion2, a.TipoRetencion3
                 FROM ProdD d, Art a
                WHERE d.ID = @ID
                  AND d.Articulo = a.Articulo
        OPEN crProdDetalle
        FETCH NEXT FROM crProdDetalle INTO @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @CantidadOriginal, @CantidadInventario, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @CantidadA, @Factor, @MovUnidad, @Articulo, @Subcuenta, @Costo, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @AplicaMov, @AplicaMovID, @AlmacenRenglon, @ProdSerieLote, @ArtTipo, @ArtSerieLoteInfo, @ArtTipoOpcion, @Peso, @Volumen, @ArtUnidad, @UltReservadoCantidad, @UltReservadoFecha, @DetalleTipo, @Merma, @Desperdicio, @Ruta, @Orden, @Centro, @ArtLotesFijos, @ArtActividades, @ArtCostoIdentificado, @ArtCostoUEPS, @ArtCostoPEPS, @ArtUltimoCosto, @ArtCostoEstandar, @ArtPrecioLista, @Posicion, @Tarima, @ArtDepartamentoDetallista, @ArtEstatus, @ArtSituacion, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3
        IF @@ERROR <> 0 SELECT @Ok = 1
      END

      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        EXEC xpInvAfectarDetalleAntes @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
                  	              @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal,
		  		      @Renglon, @RenglonSub, @Articulo, @Cantidad, @Importe, @ImporteNeto, @Impuestos, @ImpuestosNetos, 
                                      @Ok OUTPUT, @OkRef OUTPUT

	SELECT @CantidadPendienteA = @CantidadPendiente, @CantidadOrdenadaA  = @CantidadOrdenada
        IF @CfgVentaMultiAgente = 1 AND @Modulo = 'VTAS' SELECT @Agente = @AgenteRenglon
        IF @CP = 1 SELECT @ClavePresupuestalImpuesto1 = ClavePresupuestalImpuesto1 FROM Art WHERE Articulo = @Articulo        

        IF @CfgMultiUnidades = 0
        BEGIN
          IF @Modulo = 'COMS' 
            SELECT @ArtUnidad = UnidadCompra FROM Art WHERE Articulo = @Articulo
          SELECT @MovUnidad = @ArtUnidad 
        END

        -- Afectar las Comisiones
        IF @Agente <> @UltAgente AND @UltAgente IS NOT NULL AND @ComisionAcum <> 0.0 AND @Ok IS NULL AND
          (((@MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FB', 'VTAS.D', 'VTAS.DF', 'VTAS.B') AND (@Estatus = 'SINAFECTAR' OR @EstatusNuevo = 'CANCELADO')) AND (@CfgVentaComisionesCobradas = 0 OR @CobroIntegrado = 1 OR @CobrarPedido = 1)) OR @MovTipo IN ('VTAS.FM', 'VTAS.N', 'VTAS.NO', 'VTAS.NR'))
        BEGIN
           EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, 'AGENT', @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                            @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                            @FechaRegistro, @Ejercicio, @Periodo, 
                            NULL, NULL, @ClienteProv, NULL, @UltAgente, NULL, NULL, NULL, 
                            @ComisionImporteNeto, NULL, NULL, @ComisionAcum, 
                            NULL, NULL, NULL, NULL, NULL, NULL,
                            @CxModulo, @CxMov, @CxMovID, @Ok OUTPUT, @OkRef  OUTPUT
          SELECT @ComisionAcum = 0.0, @ComisionImporteNeto = 0.0
        END

        SELECT @UltAgente = @Agente


        IF @Renglon = @ExplotandoRenglon SELECT @ExplotandoSubCuenta = 1 ELSE SELECT @ExplotandoSubCuenta = 0

	-- Almacenes
        SELECT @Almacen = @AlmacenOriginal, @AlmacenDestino = @AlmacenDestinoOriginal
        IF @AfectarAlmacenRenglon = 1 SELECT @Almacen = NULLIF(RTRIM(@AlmacenRenglon), '')
        IF @AlmacenEspecifico IS NOT NULL SELECT @Almacen = @AlmacenEspecifico
        IF @VoltearAlmacen = 1 SELECT @AlmacenTemp = @Almacen, @Almacen = @AlmacenDestino, @AlmacenDestino = @AlmacenTemp
        IF @EsTransferencia = 0 /*AND @MovTipo NOT IN ('INV.SI', 'INV.DTI') */SELECT @AlmacenDestino = NULL
        IF @Almacen        IS NOT NULL SELECT @AlmacenTipo        = UPPER(Tipo) FROM Alm WHERE Almacen = @AlmacenRenglon
        IF @AlmacenDestino IS NOT NULL SELECT @AlmacenDestinoTipo = UPPER(Tipo) FROM Alm WHERE Almacen = @AlmacenDestino
        SELECT @SucursalAlmacen = Sucursal, @WMSAlmacen = ISNULL(WMS, 0) FROM Alm WHERE Almacen = @Almacen
        IF @AlmacenDestino IS NOT NULL
          SELECT @SucursalAlmacenDestino = Sucursal FROM Alm WHERE Almacen = @AlmacenDestino
  
	-- si no existe la Tarima que la de de alta
        IF @WMS = 1 AND @WMSAlmacen = 1 AND NULLIF(RTRIM(@Tarima), '') IS NOT NULL
         BEGIN
		  --BUG25657  --EXEC spTarimaAlta @Empresa, @Sucursal , @Usuario, @Almacen, @FechaRegistro, @FechaCaducidad, @Tarima, @Ok OUTPUT, @OkRef OUTPUT
          EXEC spTarimaAlta @Empresa, @Sucursal , @Usuario, @Almacen, NULL, @FechaCaducidad, @Tarima, @Ok OUTPUT, @OkRef OUTPUT, @PosicionReal
        END
        
		--TASK25114
		--BUG24540
        --EWQ. Tuning
        IF @WMS = 1 AND @WMSAlmacen = 1 AND @Tarima IS NOT NULL AND @Modulo = 'INV' AND @Accion ='CANCELAR' AND @MovTipo = 'INV.A' AND ISNULL(@CantidadInventario, 0) < 0
        BEGIN
          IF (SELECT Tipo 
                FROM AlmPos 
               WHERE AlmPos.Almacen = @Almacen
                 AND AlmPos.Posicion = @PosicionReal) NOT IN('Domicilio', 'Recibo')

            --BUG24067
            IF dbo.fnAlmPosTieneCapacidad(@Empresa, @Almacen, @PosicionReal, @Tarima) = 0
              SELECT @Ok = 13220, @OkRef = @PosicionReal 
        END

		--TASK25114
        --BUG24540
        ----EWQ. Tuning
        IF @WMS = 1 AND @WMSAlmacen = 1 AND @Tarima IS NOT NULL AND @Modulo = 'INV' AND @Accion ='AFECTAR' AND @MovTipo = 'INV.A' AND ISNULL(@CantidadInventario, 0) > 0
        BEGIN
          IF (SELECT Tipo 
                FROM AlmPos 
               WHERE AlmPos.Almacen = @Almacen
                 AND AlmPos.Posicion = @PosicionReal) NOT IN('Domicilio', 'Recibo')
            --BUG24067
            IF dbo.fnAlmPosTieneCapacidad(@Empresa, @Almacen, @PosicionReal, @Tarima) = 0
              SELECT @Ok = 13220, @OkRef = @PosicionReal
        END

        SELECT @AplicaMovTipo = NULL, @IDAplica = NULL
        IF @AplicaMov <> NULL 
        BEGIN
	  SELECT @AplicaMovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @AplicaMov

 	  IF @Modulo = 'VTAS' SELECT @IDAplica = ID FROM Venta  WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CANCELADO') ELSE
 	  IF @Modulo = 'COMS' SELECT @IDAplica = ID FROM Compra WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CANCELADO') ELSE
 	  IF @Modulo = 'PROD' SELECT @IDAplica = ID FROM Prod   WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CANCELADO') ELSE
 	  IF @Modulo = 'INV'  SELECT @IDAplica = ID FROM Inv    WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CANCELADO') 

          IF @MovTipo = 'INV.EI' AND @IDAplica IS NOT NULL
          BEGIN
            SELECT @IDSalidaTraspaso = o.ID 
              FROM Inv i
              JOIN Inv o ON o.Empresa = i.Empresa AND o.Mov = i.Origen AND o.MovID = i.OrigenID AND o.Estatus IN ('PENDIENTE', 'CONCLUIDO')
             WHERE i.ID = @IDAplica
          END
        END

	-- Checar el Renglon
        EXEC spInvInitRenglon @Empresa, 0, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CfgCompraFactorDinamico, @CfgInvFactorDinamico, @CfgProdFactorDinamico, @CfgVentaFactorDinamico, 0,
                              0, 0, @Accion, @Base, @Modulo, @ID, @Renglon, @RenglonSub, @Estatus, @EstatusNuevo, @MovTipo, @FacturarVtasMostrador, @EsTransferencia, @AfectarConsignacion, @ExplotandoSubCuenta, @AlmacenTipo, @AlmacenDestinoTipo, 
			      @Articulo, @MovUnidad, @ArtUnidad, @ArtTipo, @RenglonTipo,
			      @AplicaMovTipo, @CantidadOriginal, @CantidadInventario, @CantidadPendiente, @CantidadA, @DetalleTipo,
                              @Cantidad OUTPUT, @CantidadCalcularImporte OUTPUT, @CantidadReservada OUTPUT, @CantidadOrdenada OUTPUT, @EsEntrada OUTPUT, @EsSalida OUTPUT, @SubCuenta OUTPUT, 
                              @AfectarPiezas OUTPUT, @AfectarCostos OUTPUT, @AfectarUnidades OUTPUT, @Factor OUTPUT,
			      @Ok OUTPUT, @OkRef OUTPUT, @Seccion = @Seccion

        -- Inicializar Variables
        SELECT @Importe		 	= 0.0,
	       @ImporteNeto	 	= 0.0,
	       @Impuestos 		= 0.0,
               @ImpuestosNetos		= 0.0,
               @Impuesto1Neto 		= 0.0,
               @Impuesto2Neto 		= 0.0,
               @Impuesto3Neto 		= 0.0,
               @Impuesto5Neto 		= 0.0,
	       @DescuentoLineaImporte	= 0.0,
	       @DescuentoGlobalImporte 	= 0.0,
	       @SobrePrecioImporte 	= 0.0,
               @ImporteComision		= 0.0,
               @CostoInvTotal	        = 0.0

        IF @@FETCH_STATUS <> -2 AND @Cantidad <> 0.0 AND @Ok IS NULL
        BEGIN
          SELECT @CostosImpuestoIncluido = 0
          IF @CfgCompraCostosImpuestoIncluido = 1 AND @AlmacenTipo <> 'ACTIVOS FIJOS' 
            SELECT @CostosImpuestoIncluido = 1

          SELECT @ArtMoneda = MonedaCosto, @SeriesLotesAutoOrden = ISNULL(NULLIF(NULLIF(RTRIM(UPPER(SeriesLotesAutoOrden)), ''), '(EMPRESA)'), @CfgSeriesLotesAutoOrden)
            FROM Art 
           WHERE Articulo = @Articulo

          IF @Generar = 0 OR @GenerarAfectado = 1 
          BEGIN
              -- Eliminar los Costos en Garantias
	      IF @Modulo = 'COMS' AND @MovTipo IN ('COMS.OG', 'COMS.IG', 'COMS.DG')
              BEGIN
		SELECT @Costo = 0.0, @Precio = 0.0
                UPDATE CompraD SET Costo = NULL WHERE CURRENT OF crCompraDetalle
	      END

              SELECT @AfectarSerieLote = 0
              IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND @AplicaMovTipo = 'VTAS.R' SELECT @FacturandoRemision = 1 ELSE SELECT @FacturandoRemision = 0
              IF @ArtTipo IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA') AND @CfgSeriesLotesMayoreo = 1 AND (@EsEntrada = 1 OR @EsSalida = 1 OR @EsTransferencia = 1 OR @MovTipo IN ('COMS.B', 'COMS.CA', 'COMS.GX')) AND @FacturarVtasMostrador = 0 AND @FacturandoRemision = 0 
              BEGIN

			   --IF @CantidadOriginal > 0
               -- EXEC spSeriesLotesINVWMS @Sucursal, @Empresa, @Modulo, @EsSalida, @EsTransferencia, @ID,  @RenglonID, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Factor, @AlmacenTipo, @SeriesLotesAutoOrden, @Ok OUTPUT, @OkRef OUTPUT
               
			   /* En el Mov Ajuste se tiene que insertar en SerieLoteMov los articulos con las cantidades del Inventario Físico. */
               IF @MovTipo = 'INV.A'
               BEGIN
                   SELECT @Tarima = ISNULL(dbo.fnAlmacenTarima(@Almacen, @Tarima), '')

                   DECLARE crArtInv CURSOR FOR
                       SELECT TOP 1 SerieLote
                         FROM SerieLote 
                        WHERE Empresa = @Empresa 
                          AND Articulo = @Articulo 
                          AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'')
                          AND Almacen = @Almacen     
                          AND ISNULL(@Tarima,'') = ISNULL(@Tarima, '')
                          AND Sucursal = @Sucursal
                          AND (Existencia IS NULL OR ExistenciaAlterna IS NULL)
                          AND @CantidadOriginal > 0            
                        ORDER BY SerieLote
       
	                OPEN crArtInv
	                FETCH NEXT FROM crArtInv INTO @SerieLote
	                WHILE @@FETCH_STATUS = 0 
	                BEGIN	
					       IF NOT EXISTS(SELECT * FROM SerieLoteMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID)
						   BEGIN                             
							   INSERT SerieLoteMov (Sucursal, Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
										   VALUES (@Sucursal, @Empresa, @Modulo, @ID, @RenglonID, @Articulo, ISNULL(@SubCuenta,''), @SerieLote, @CantidadOriginal)
                           END
         
		                FETCH NEXT FROM crArtInv INTO @SerieLote
	                END
	                CLOSE crArtInv
	                DEALLOCATE crArtInv	
                END


                SELECT @AfectarSerieLote = 1 -- a proposito el procedimiento "spSeriesLotesMayoreo" se puso despues de "spArtCosto" No hay que moverlo.

                IF @ArtSerieLoteInfo = 0 
					EXEC spSeriesLotesSurtidoAuto @Sucursal, @Empresa, @Modulo, @EsSalida, @EsTransferencia,
												  @ID,  @RenglonID, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Factor,
												  @AlmacenTipo, @SeriesLotesAutoOrden,	
											      @Ok OUTPUT, @OkRef OUTPUT--, @Tarima = @Tarima --Task 8036
              END
              SELECT @PrecioN = @Precio, @Impuesto1N = @Impuesto1, @Impuesto2N = @Impuesto2, @Impuesto3N = @Impuesto3, @Impuesto5N = @Impuesto5

              IF @Modulo IN ('VTAS', 'COMS') AND @Accion <> 'CANCELAR'
              BEGIN
                EXEC xpMovDPrecioImpuestos @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Renglon, @RenglonSub, @RenglonID, @ArtTipo, @Articulo, @SubCuenta, @Almacen, @CantidadOriginal, @PrecioN OUTPUT, @Impuesto1N OUTPUT, @Impuesto2N OUTPUT, @Impuesto3N OUTPUT, @Impuesto5N OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

                IF @MovImpuesto = 1
                BEGIN
                  IF @ArtTipo = 'LOTE' AND @ArtLotesFijos = 1 /*AR*/ AND @NoValidarDisponible = 0 
                    EXEC spLotesFijos @Empresa, @Sucursal, @FechaEmision, @ClienteProv, @EnviarA, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Renglon, @RenglonSub, @RenglonID, @ArtTipo, @Articulo, @SubCuenta, @Almacen, @ZonaImpuesto, @CantidadOriginal, @Factor,
                                      @CfgImpInc, @EsEntrada, @Precio, @DescuentoTipo, @DescuentoLinea, @DescuentoGlobal, @SobrePrecio,
                                      @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5,
                                      @Impuesto1N OUTPUT, @Impuesto2N OUTPUT, @Impuesto3N OUTPUT, @Impuesto5N OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 
				      @CfgPrecioMoneda = @CfgPrecioMoneda, @MovTipoCambio = @MovTipoCambio, @PrecioTipoCambio = @PrecioTipoCambio,
				      @ContUso = @ContUso, @ContUso2 = @ContUso2, @ContUso3 = @ContUso3, @ClavePresupuestal = @ClavePresupuestal, @ClavePresupuestalImpuesto1 = @ClavePresupuestalImpuesto1,
				      @Retencion1 = @Retencion1, @Retencion2 = @Retencion2, @Retencion3 = @Retencion3
                END
              END
  
              IF @PrecioN <> @Precio OR @Impuesto1N <> @Impuesto1 OR @Impuesto2 <> @Impuesto2N OR @Impuesto3 <> @Impuesto3N OR @Impuesto5 <> @Impuesto5N
              BEGIN                  
                SELECT @Precio = @PrecioN, @Impuesto1 = @Impuesto1N, @Impuesto2 = @Impuesto2N, @Impuesto3 = @Impuesto3N, @Impuesto5 = @Impuesto5N
                IF @Modulo = 'VTAS' UPDATE VentaD  SET Precio = @Precio, Impuesto1 = @Impuesto1, Impuesto2 = @Impuesto2, Impuesto3 = @Impuesto3 WHERE CURRENT OF crVentaDetalle ELSE
                IF @Modulo = 'COMS'
                BEGIN 
                  IF @ArtTipo <> 'LOTE' AND @ArtLotesFijos <> 1 /*AR*/ AND @NoValidarDisponible <> 0 
                  BEGIN
                    SELECT @Costo = @Precio
                    UPDATE CompraD SET Costo = @Costo, Impuesto1 = @Impuesto1, Impuesto2 = @Impuesto2, Impuesto3 = @Impuesto3, Impuesto5 = @Impuesto5 WHERE CURRENT OF crCompraDetalle                  
			      END
                END
              END

              IF @ArtActividades = 1 
              BEGIN
                IF @MovTipo IN ('VTAS.P', 'VTAS.S')
                  EXEC spSugerirArtActividad @Empresa, @Sucursal, @ID, @Renglon, @RenglonSub, @Articulo, @CantidadOriginal, @Agente

               IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX','VTAS.FB') 
               BEGIN                 
                 UPDATE VentaDAgente
                    SET CostoActividad = a.Costo
                   FROM VentaDAgente d, Actividad a 
                  WHERE d.ID = @ID AND d.Renglon = @Renglon AND d.RenglonSub = @RenglonSub AND d.Actividad = a.Actividad

                 IF @CfgCosteoActividades = 'TIEMPO ESTANDAR'
                   SELECT @CostoActividad = SUM(CostoActividad*CantidadEstandar) FROM VentaDAgente WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub                  
                 ELSE
                   SELECT @CostoActividad = SUM(CostoActividad*(CONVERT(float, Minutos)/60)) FROM VentaDAgente WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

                 UPDATE VentaD SET CostoActividad = @CostoActividad/NULLIF(@MovTipoCambio, 0)/NULLIF(@CantidadOriginal, 0) WHERE CURRENT OF crVentaDetalle 
               END                 
              END
	      
              -- Calcular el Importe 
              IF @Modulo IN ('VTAS', 'COMS')
              BEGIN
    	        EXEC spCalculaImporte @Accion, @Modulo, @CfgImpInc, @MovTipo, @EsEntrada, @CantidadCalcularImporte, @Precio, @DescuentoTipo, @DescuentoLinea, @DescuentoGlobal, @SobrePrecio, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5,
                                      @Importe OUTPUT, @ImporteNeto OUTPUT, @DescuentoLineaImporte OUTPUT, @DescuentoGlobalImporte OUTPUT, @SobrePrecioImporte OUTPUT, 
                                      @Impuestos OUTPUT, @ImpuestosNetos OUTPUT, @Impuesto1Neto OUTPUT, @Impuesto2Neto OUTPUT, @Impuesto3Neto OUTPUT, @Impuesto5Neto OUTPUT,  
				      @Articulo = @Articulo, @CantidadObsequio = @CantidadObsequio, @CfgPrecioMoneda = @CfgPrecioMoneda, @MovTipoCambio = @MovTipoCambio, @PrecioTipoCambio = @PrecioTipoCambio,
				      @Retencion1 = @Retencion1, @Retencion2 = @Retencion2, @Retencion3 = @Retencion3, @ID = @ID, @AnticipoFacturado = @AnticipoFacturado --ANTICIPOFACTURADO

                IF @MovImpuesto = 1 AND NOT (@ArtTipo = 'LOTE' AND @ArtLotesFijos = 1)
                BEGIN
                   IF @Modulo = 'VTAS' --MEJORA1002
                   BEGIN
                     IF EXISTS(SELECT * FROM Venta v JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = @Modulo WHERE v.Empresa = @Empresa AND v.Mov = @AplicaMov AND v.MovID = @AplicaMovID AND mt.Clave IN ('VTAS.VCR','VTAS.R')) AND @VentaMovImpuestoDesdeRemision = 1 AND @MovTipo IN ('VTAS.F','VTAS.DCR')
                     BEGIN
                       SELECT @ArrastrarMovImpuestoRemision = 1
                       SELECT @MovImpuestoAplicaID = ID, @AplicaConcepto = Concepto, @AplicaFechaEmision = FechaEmision FROM Venta WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID
                     END ELSE
                     BEGIN
                       SELECT @ArrastrarMovImpuestoRemision = 0, @MovImpuestoAplicaID = NULL, @AplicaConcepto = NULL, @AplicaFechaEmision = NULL
                     END  
                   END
                     
                   IF @CantidadOriginal<0.0 AND @AnticipoFacturado = 0 SELECT @MovImpuestoFactor = -1.0 ELSE SELECT @MovImpuestoFactor = 1.0 --ANTICIPOFACTURADO
                   IF @ArrastrarMovImpuestoRemision = 0 --MEJORA1002
                   BEGIN
                     INSERT #MovImpuesto (Renglon,  RenglonSub,  Retencion1,     Retencion2,     Retencion3,     Excento1,     Excento2,     Excento3,     TipoImpuesto1,  TipoImpuesto2,  TipoImpuesto3,  TipoImpuesto5,  TipoRetencion1,  TipoRetencion2,  TipoRetencion3,  Impuesto1,  Impuesto2,  Impuesto3,  Impuesto5,  Importe1,                          Importe2,                          Importe3,                          Importe5,                          SubTotal,                        ContUso,  ContUso2,  ContUso3,  ClavePresupuestal,  ClavePresupuestalImpuesto1,  DescuentoGlobal, ImporteBruto)
                                   SELECT @Renglon, @RenglonSub, @MovRetencion1, @MovRetencion2, @MovRetencion3, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @Impuesto1Neto*@MovImpuestoFactor, @Impuesto2Neto*@MovImpuestoFactor, @Impuesto3Neto*@MovImpuestoFactor, @Impuesto5Neto*@MovImpuestoFactor, @ImporteNeto*@MovImpuestoFactor, @ContUso, @ContUso2, @ContUso3, @ClavePresupuestal, @ClavePresupuestalImpuesto1, @DescuentoGlobal, @Importe
                   END ELSE
                   BEGIN
                     IF @ArrastrarMovImpuestoRemision = 1 --MEJORA1002
                     BEGIN                       
                       INSERT #MovImpuesto (OrigenModulo,  OrigenModuloID,       Renglon,  RenglonSub,  Retencion1,     Retencion2,     Retencion3,     Excento1,     Excento2,     Excento3,     TipoImpuesto1,  TipoImpuesto2,  TipoImpuesto3,  TipoImpuesto5,  TipoRetencion1,  TipoRetencion2,  TipoRetencion3,  Impuesto1,  Impuesto2,  Impuesto3,  Impuesto5,  Importe1,                          Importe2,                          Importe3,                          Importe5,                          SubTotal,                        ContUso,  ContUso2,  ContUso3,  ClavePresupuestal,  ClavePresupuestalImpuesto1,  DescuentoGlobal,  ImporteBruto, OrigenConcepto,  OrigenFecha) 
                                     SELECT 'VTAS',        @MovImpuestoAplicaID, @Renglon, @RenglonSub, @MovRetencion1, @MovRetencion2, @MovRetencion3, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @Impuesto1Neto*@MovImpuestoFactor, @Impuesto2Neto*@MovImpuestoFactor, @Impuesto3Neto*@MovImpuestoFactor, @Impuesto5Neto*@MovImpuestoFactor, @ImporteNeto*@MovImpuestoFactor, @ContUso, @ContUso2, @ContUso3, @ClavePresupuestal, @ClavePresupuestalImpuesto1, @DescuentoGlobal, @Importe,     @AplicaConcepto, @AplicaFechaEmision                     
                     END
                   END              
                END
                
                IF @Modulo = 'COMS'
                BEGIN
                  SELECT @Costo = @ImporteNeto / @Cantidad
                  --IF @CostosImpuestoIncluido = 1 SELECT @Costo = ROUND(@Costo, @RedondeoMonetarios)
                END
                            
                IF @@ERROR <> 0 SELECT @Ok = 1
              END

              -- Afectar la Cantidad
              SELECT @AfectarCantidad = NULL

              IF @AfectarUnidades = 1 AND @Ok IS NULL	
              BEGIN					
					EXEC spInvAfectarUnidades @SucursalAlmacen, @Accion, @Base, @Empresa, @Usuario, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @Estatus,
											  @Articulo, @ArtMoneda, @ArtTipoCambio, @ArtTipo, @SubCuenta, @Almacen, @AlmacenTipo, @AlmacenDestino, @AlmacenDestinoTipo, @EsEntrada, @CantidadOriginal, @Cantidad, @Factor, 
											  @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, 
											  @FechaRegistro, @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, @OrigenTipo,
											  @AfectarCostos, @AfectarPiezas, @AfectarVtasMostrador, @FacturarVtasMostrador, @AfectarConsignacion, @EsTransferencia, @CfgSeriesLotesMayoreo, /*@CfgAutoConsig, */@CfgFormaCosteo, @CfgTipoCosteo, 
											  @CantidadReservada, @ReservadoParcial OUTPUT, @UltRenglonIDJuego OUTPUT, @CantidadJuego OUTPUT, @CantidadMinimaJuego OUTPUT,
											  @UltReservadoCantidad OUTPUT, @UltReservadoFecha OUTPUT, @AfectarCantidad OUTPUT, @AfectarAlmacen OUTPUT, @AfectarAlmacenDestino OUTPUT,
 		    								  @Ok OUTPUT, @OkRef OUTPUT, @Tarima = @Tarima                    
              END 
              ELSE 
                SELECT @ReservadoParcial = 0.0, @AfectarAlmacen = @Almacen, @AfectarAlmacenDestino = @AlmacenDestino

              IF @FacturandoRemision = 1 AND @Accion <> 'CANCELAR' AND @ArtTipo NOT IN ('JUEGO', 'SERVICIO')
              BEGIN
                SELECT @Costo = ISNULL(SUM(Cantidad*Costo)/NULLIF(SUM(Cantidad), 0.0), 0.0) 
                  FROM VentaD 
                 WHERE ID = @IDAplica AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'')

                IF @Costo = 0.0 
                  SELECT @AfectarCostos = 1 
                ELSE
                  UPDATE VentaD SET Costo = @Costo WHERE CURRENT OF crVentaDetalle 
              END

	      /** JH 25.10.2006 **/
              IF @Modulo = 'VTAS' AND @AlmacenTipo = 'GARANTIAS' AND @Accion <> 'CANCELAR'
              BEGIN
                UPDATE VentaD SET Costo = NULL WHERE CURRENT OF crVentaDetalle 
                SELECT @Costo = 0.0
              END
	      /** JH 25.10.2006 **/

              IF @EsSalida = 1 AND @Modulo IN ('VTAS', 'INV') AND @EsTransferencia = 0 AND @AlmacenTipo <> 'ACTIVOS FIJOS' AND @Accion = 'AFECTAR' AND @FacturarVtasMostrador = 0 /*AR 11/09/07 */
                EXEC spChecarConsignacion @Empresa, @SucursalAlmacen, @Usuario, @Modulo, @Mov, @MovID,
				          @FechaAfectacion, @Ejercicio, @Periodo, @ArtMoneda, @Almacen, @Tarima, @Articulo, @SubCuenta, @AfectarCantidad, 
					  @Ok OUTPUT, @OkRef OUTPUT

              IF @AfectarCostos = 1 OR @EsTransferencia = 1 OR @MovTipo IN ('COMS.CC', 'COMS.DC') AND @Ok IS NULL
              BEGIN         
	        -- Calcular el Costo del Articulo
                IF @MovTipo IN ('COMS.EG', 'COMS.EI')
                  SELECT @CostoInv = CostoInv FROM CompraD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
                ELSE IF @MovTipo IN ('INV.EI')
                  SELECT @CostoInv = CostoInv FROM InvD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
                ELSE --IF @MovTipo NOT IN ('COMS.D')
                  SELECT @CostoInv = @Costo

                IF @CostosImpuestoIncluido = 1
                  SELECT @CostoInv = @CostoInv + (@ImpuestosNetos / @Cantidad)

                EXEC spArtCosto @SucursalAlmacen, @Accion, @Empresa, @Modulo, @AfectarCostos,
                                @EsEntrada, @EsSalida, @EsTransferencia, @AfectarSerieLote, @CfgFormaCosteo, @CfgTipoCosteo,
                                @ArtTipo, @Articulo, @SubCuenta, @Cantidad, @MovUnidad, @Factor, @CostoInv, @Costo,
                                @Mov, @MovID, @MovTipo, @AplicaMovTipo, @FechaAfectacion, @MovMoneda, @MovTipoCambio,		
        		        @ID, @RenglonID, @Almacen, @AlmacenTipo, 0, @CfgCosteoSeries, @CfgCosteoLotes, @CfgCosteoMultipleSimultaneo, @ArtCostoIdentificado, 
                                @ArtCosto OUTPUT, @ArtAjusteCosteo OUTPUT, @ArtCostoUEPS OUTPUT, @ArtCostoPEPS OUTPUT, @ArtUltimoCosto OUTPUT, @ArtCostoEstandar OUTPUT, @ArtCostoPromedio OUTPUT, @ArtCostoReposicion, @ArtPrecioLista OUTPUT,
                                @ArtMoneda OUTPUT, @ArtFactor OUTPUT, @ArtTipoCambio OUTPUT, @Ok OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @OtraMoneda = @ValuacionOtraMoneda, @OtraMonedaTipoCambio = @ValuacionOtraMonedaTC, @OtraMonedaTipoCambioVenta = @ValuacionOtraMonedaTCV, @OtraMonedaTipoCambioCompra = @ValuacionOtraMonedaTCC --MEJORA6230


                IF @CfgCosteoNivelSubCuenta = 1 AND @ArtTipoOpcion <> 'NO' 
                  EXEC spArtCosto @SucursalAlmacen, @Accion, @Empresa, @Modulo, @AfectarCostos,
                                  @EsEntrada, @EsSalida, @EsTransferencia, @AfectarSerieLote, @CfgFormaCosteo, @CfgTipoCosteo,
                                  @ArtTipo, @Articulo, @SubCuenta, @Cantidad, @MovUnidad, @Factor, @CostoInv, @Costo,
                                  @Mov, @MovID, @MovTipo, @AplicaMovTipo, @FechaAfectacion, @MovMoneda, @MovTipoCambio,
        		          @ID, @RenglonID, @Almacen, @AlmacenTipo, 1, @CfgCosteoSeries, @CfgCosteoLotes, @CfgCosteoMultipleSimultaneo, @ArtCostoIdentificado, 
                                  @ArtCosto OUTPUT, @ArtAjusteCosteo OUTPUT, @ArtCostoUEPS OUTPUT, @ArtCostoPEPS OUTPUT, @ArtUltimoCosto OUTPUT, @ArtCostoEstandar OUTPUT, @ArtCostoPromedio OUTPUT, @ArtCostoReposicion, @ArtPrecioLista OUTPUT,
                                  @ArtMoneda OUTPUT, @ArtFactor OUTPUT, @ArtTipoCambio OUTPUT, @Ok OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @OtraMoneda = @ValuacionOtraMoneda, @OtraMonedaTipoCambio = @ValuacionOtraMonedaTC, @OtraMonedaTipoCambioVenta = @ValuacionOtraMonedaTCV, @OtraMonedaTipoCambioCompra = @ValuacionOtraMonedaTCC --MEJORA6230

                SELECT @ModificarCosto = @ArtCosto * @ArtFactor, @ModificarPrecio = @Precio
		EXEC xpMovModificarCostoPrecio @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @AfectarCostos, @EsEntrada, @EsSalida, @EsTransferencia, @Renglon, @RenglonSub, @Articulo, @SubCuenta, @MovUnidad, @ArtCosto, @ArtFactor, @ModificarCosto OUTPUT, @ModificarPrecio OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
                IF @ModificarCosto <> @ArtCosto * @ArtFactor OR @ModificarPrecio <> @Precio
                BEGIN
                  SELECT @ArtCosto = @ModificarCosto / @ArtFactor, @Precio = @ModificarPrecio
                  IF @Modulo = 'VTAS' UPDATE VentaD SET Precio = @Precio WHERE CURRENT OF crVentaDetalle ELSE
                  IF @Modulo = 'INV'  UPDATE InvD   SET Precio = @Precio WHERE CURRENT OF crInvDetalle
    	          EXEC spCalculaImporte @Accion, @Modulo, @CfgImpInc, @MovTipo, @EsEntrada, @CantidadCalcularImporte, @Precio, @DescuentoTipo, @DescuentoLinea, @DescuentoGlobal, @SobrePrecio, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5,
                                        @Importe OUTPUT, @ImporteNeto OUTPUT, @DescuentoLineaImporte OUTPUT, @DescuentoGlobalImporte OUTPUT, @SobrePrecioImporte OUTPUT, 
                                        @Impuestos OUTPUT, @ImpuestosNetos OUTPUT, @Impuesto1Neto OUTPUT, @Impuesto2Neto OUTPUT, @Impuesto3Neto OUTPUT, @Impuesto5Neto OUTPUT, 
					@Articulo = @Articulo, @CantidadObsequio = @CantidadObsequio, @CfgPrecioMoneda = @CfgPrecioMoneda, @MovTipoCambio = @MovTipoCambio, @PrecioTipoCambio = @PrecioTipoCambio,
					@Retencion1 = @Retencion1, @Retencion2 = @Retencion2, @Retencion3 = @Retencion3, @ID = @ID, @AnticipoFacturado = @AnticipoFacturado --ANTICIPOFACTURADO
                  IF @MovImpuesto = 1 AND NOT (@ArtTipo = 'LOTE' AND @ArtLotesFijos = 1)
                  BEGIN
                    IF @Modulo = 'VTAS' --MEJORA1002
                    BEGIN
                      IF EXISTS(SELECT * FROM Venta v JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = @Modulo WHERE v.Empresa = @Empresa AND v.Mov = @AplicaMov AND v.MovID = @AplicaMovID AND mt.Clave IN ('VTAS.VCR','VTAS.R')) AND @VentaMovImpuestoDesdeRemision = 1 AND @MovTipo IN ('VTAS.F','VTAS.DCR')
                      BEGIN
                        SELECT @ArrastrarMovImpuestoRemision = 1
                        SELECT @MovImpuestoAplicaID = ID, @AplicaConcepto = Concepto, @AplicaFechaEmision = FechaEmision FROM Venta WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID
                      END ELSE
                      BEGIN
                        SELECT @ArrastrarMovImpuestoRemision = 0, @MovImpuestoAplicaID = NULL, @AplicaConcepto = NULL, @AplicaFechaEmision = NULL
                      END  
                   END
                                    
                   DELETE #MovImpuesto WHERE Renglon = @Renglon AND RenglonSub = @RenglonSub
                   IF @CantidadOriginal<0.0 SELECT @MovImpuestoFactor = -1.0 ELSE SELECT @MovImpuestoFactor = 1.0
                                                       
                   IF @ArrastrarMovImpuestoRemision = 0 --MEJORA1002
                   BEGIN
                     INSERT #MovImpuesto (Renglon,  RenglonSub,  Retencion1,     Retencion2,     Retencion3,     Excento1,     Excento2,     Excento3,     TipoImpuesto1,  TipoImpuesto2,  TipoImpuesto3,  TipoImpuesto5,  TipoRetencion1,  TipoRetencion2,  TipoRetencion3,  Impuesto1,  Impuesto2,  Impuesto3,  Impuesto5,  Importe1,                          Importe2,                          Importe3,                          Importe5,                          SubTotal,                        ContUso,  ContUso2,  ContUso3,  ClavePresupuestal,  ClavePresupuestalImpuesto1,  DescuentoGlobal,  ImporteBruto)
                                   SELECT @Renglon, @RenglonSub, @MovRetencion1, @MovRetencion2, @MovRetencion3, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @Impuesto1Neto*@MovImpuestoFactor, @Impuesto2Neto*@MovImpuestoFactor, @Impuesto3Neto*@MovImpuestoFactor, @Impuesto5Neto*@MovImpuestoFactor, @ImporteNeto*@MovImpuestoFactor, @ContUso, @ContUso2, @ContUso3, @ClavePresupuestal, @ClavePresupuestalImpuesto1, @DescuentoGlobal, @Importe                     
                   END ELSE
                   BEGIN
                     IF @ArrastrarMovImpuestoRemision = 1 --MEJORA1002
                     BEGIN                       
                       INSERT #MovImpuesto (OrigenModulo,  OrigenModuloID,       Renglon,  RenglonSub,  Retencion1,     Retencion2,     Retencion3,     Excento1,     Excento2,     Excento3,     TipoImpuesto1,  TipoImpuesto2,  TipoImpuesto3,  TipoImpuesto5,  TipoRetencion1,  TipoRetencion2,  TipoRetencion3,  Impuesto1,  Impuesto2,  Impuesto3,  Impuesto5,  Importe1,                          Importe2,                          Importe3,                          Importe5,                          SubTotal,                        ContUso,  ContUso2,  ContUso3,  ClavePresupuestal,  ClavePresupuestalImpuesto1,  DescuentoGlobal,  ImporteBruto, OrigenConcepto,  OrigenFecha)
                                     SELECT 'VTAS',        @MovImpuestoAplicaID, @Renglon, @RenglonSub, @MovRetencion1, @MovRetencion2, @MovRetencion3, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @Impuesto1Neto*@MovImpuestoFactor, @Impuesto2Neto*@MovImpuestoFactor, @Impuesto3Neto*@MovImpuestoFactor, @Impuesto5Neto*@MovImpuestoFactor, @ImporteNeto*@MovImpuestoFactor, @ContUso, @ContUso2, @ContUso3, @ClavePresupuestal, @ClavePresupuestalImpuesto1, @DescuentoGlobal, @Importe,     @AplicaConcepto, @AplicaFechaEmision                                          
                     END
                   END              
                                    
                  END
                END

                SELECT @ArtCostoInv = @ArtCosto  -- NO hay que quitar esto, porque artcosto va a cambiar
	        
				IF @CfgCostearDC = 1 AND @MovTipo IN ('COMS.D')
				  SELECT @CostoInvTotal = @Costo * @Cantidad
				ELSE
				  SELECT @CostoInvTotal = @ArtCosto * @Cantidad
                
                SELECT @ArtCantidad = ISNULL(@Cantidad, 0.0)*ISNULL(@Factor, 1.0)
                IF @MovTipo IN ('COMS.EG', 'COMS.EI', 'INV.EI') SELECT @ArtCosto = @Costo / @ArtFactor
            
                /*IF @Accion <> 'CANCELAR'
                BEGIN*/
                  SELECT @PrecioSinImpuestos = dbo.fnPrecioSinImpuestos (@Empresa, @Articulo, @ArtPrecioLista)
                  -- Actualizar el Costo, en las Salidas
                  IF (@EsSalida = 1 OR @EsTransferencia = 1) AND @Accion <> 'CANCELAR' AND @Ok IS NULL
                  BEGIN
                    IF @Modulo = 'VTAS' UPDATE VentaD  SET Unidad = @MovUnidad, Costo = @ArtCosto * @ArtFactor, AjusteCosteo = @ArtAjusteCosteo * @ArtFactor, CostoUEPS = @ArtCostoUEPS * @ArtFactor, CostoPEPS = @ArtCostoPEPS * @ArtFactor, UltimoCosto = @ArtUltimoCosto * @ArtFactor, CostoEstandar = @ArtCostoEstandar * @ArtFactor, PrecioLista = @PrecioSinImpuestos, DepartamentoDetallista = @ArtDepartamentoDetallista WHERE CURRENT OF crVentaDetalle  ELSE
                    IF @Modulo = 'INV'  UPDATE InvD    SET Unidad = @MovUnidad, Costo = @ArtCosto * @ArtFactor, AjusteCosteo = @ArtAjusteCosteo * @ArtFactor, CostoUEPS = @ArtCostoUEPS * @ArtFactor, CostoPEPS = @ArtCostoPEPS * @ArtFactor, UltimoCosto = @ArtUltimoCosto * @ArtFactor, CostoEstandar = @ArtCostoEstandar * @ArtFactor, PrecioLista = @PrecioSinImpuestos, DepartamentoDetallista = @ArtDepartamentoDetallista WHERE CURRENT OF crInvDetalle    ELSE
                    IF @Modulo = 'PROD' UPDATE ProdD   SET Unidad = @MovUnidad, Costo = @ArtCosto * @ArtFactor, AjusteCosteo = @ArtAjusteCosteo * @ArtFactor, CostoUEPS = @ArtCostoUEPS * @ArtFactor, CostoPEPS = @ArtCostoPEPS * @ArtFactor, UltimoCosto = @ArtUltimoCosto * @ArtFactor, CostoEstandar = @ArtCostoEstandar * @ArtFactor, PrecioLista = @PrecioSinImpuestos, DepartamentoDetallista = @ArtDepartamentoDetallista WHERE CURRENT OF crProdDetalle   ELSE
                    IF @Modulo = 'COMS' UPDATE CompraD SET Unidad = @MovUnidad, /*Costo = @ArtCosto * @ArtFactor,*/ AjusteCosteo = @ArtAjusteCosteo * @ArtFactor, CostoUEPS = @ArtCostoUEPS * @ArtFactor, CostoPEPS = @ArtCostoPEPS * @ArtFactor, UltimoCosto = @ArtUltimoCosto * @ArtFactor, CostoEstandar = @ArtCostoEstandar * @ArtFactor, PrecioLista = @PrecioSinImpuestos, DepartamentoDetallista = @ArtDepartamentoDetallista WHERE CURRENT OF crCompraDetalle                 
                    IF @@ERROR <> 0 SELECT @Ok = 1
					IF @MovTipo = 'COMS.D' UPDATE CompraD SET CostoInv = @ArtCosto  WHERE CURRENT OF crCompraDetalle 
                  END ELSE 
                  BEGIN
                    SELECT @AjustePrecioLista = NULL
                    IF @MovTipo = 'INV.EI' AND @IDSalidaTraspaso IS NOT NULL
                      SELECT @AjustePrecioLista = @PrecioSinImpuestos - (SELECT MIN(PrecioLista) FROM InvD WHERE ID = @IDSalidaTraspaso AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(Unidad, '') = ISNULL(@MovUnidad, ''))

                    IF @Modulo = 'VTAS' UPDATE VentaD  SET Unidad = @MovUnidad, AjusteCosteo = @ArtAjusteCosteo * @ArtFactor, CostoUEPS = @ArtCostoUEPS * @ArtFactor, CostoPEPS = @ArtCostoPEPS * @ArtFactor, UltimoCosto = @ArtUltimoCosto * @ArtFactor, CostoEstandar = @ArtCostoEstandar * @ArtFactor, PrecioLista = @PrecioSinImpuestos, DepartamentoDetallista = @ArtDepartamentoDetallista WHERE CURRENT OF crVentaDetalle  ELSE
                    IF @Modulo = 'INV'  UPDATE InvD    SET Unidad = @MovUnidad, AjusteCosteo = @ArtAjusteCosteo * @ArtFactor, CostoUEPS = @ArtCostoUEPS * @ArtFactor, CostoPEPS = @ArtCostoPEPS * @ArtFactor, UltimoCosto = @ArtUltimoCosto * @ArtFactor, CostoEstandar = @ArtCostoEstandar * @ArtFactor, PrecioLista = @PrecioSinImpuestos, DepartamentoDetallista = @ArtDepartamentoDetallista, AjustePrecioLista = @AjustePrecioLista WHERE CURRENT OF crInvDetalle ELSE
                    IF @Modulo = 'PROD' UPDATE ProdD   SET Unidad = @MovUnidad, AjusteCosteo = @ArtAjusteCosteo * @ArtFactor, CostoUEPS = @ArtCostoUEPS * @ArtFactor, CostoPEPS = @ArtCostoPEPS * @ArtFactor, UltimoCosto = @ArtUltimoCosto * @ArtFactor, CostoEstandar = @ArtCostoEstandar * @ArtFactor, PrecioLista = @PrecioSinImpuestos, DepartamentoDetallista = @ArtDepartamentoDetallista WHERE CURRENT OF crProdDetalle   ELSE
                    IF @Modulo = 'COMS' UPDATE CompraD SET Unidad = @MovUnidad, AjusteCosteo = @ArtAjusteCosteo * @ArtFactor, CostoUEPS = @ArtCostoUEPS * @ArtFactor, CostoPEPS = @ArtCostoPEPS * @ArtFactor, UltimoCosto = @ArtUltimoCosto * @ArtFactor, CostoEstandar = @ArtCostoEstandar * @ArtFactor, PrecioLista = @PrecioSinImpuestos, DepartamentoDetallista = @ArtDepartamentoDetallista WHERE CURRENT OF crCompraDetalle 
                  END
                /*END*/

                IF @MovTipo = 'VTAS.FC' AND NULLIF(RTRIM(@ServicioSerie), '') IS NOT NULL AND @CfgVINAccesorioArt = 1 AND @CfgVINCostoSumaAccesorios = 1
                  INSERT VINAccesorio 
                         (VIN,           Tipo, Accesorio, Descripcion,    PrecioDistribuidor,  PrecioPublico,           PrecioContado,       FechaAlta,     Estatus)
                  SELECT @ServicioSerie, @Mov, @Articulo, a.Descripcion1, @ArtCosto*@Cantidad, a.PrecioLista*@Cantidad, a.Precio2*@Cantidad, @FechaEmision, 'ALTA'
                    FROM Art a
                   WHERE a.Articulo = @Articulo

 		
                IF @Modulo <> 'COMS' SELECT @Costo = @ArtCosto * @ArtFactor
--COMENTARIO_0002

                -- Afectar Saldos de la Rama 'INV'
                IF @AfectarCostos = 1 AND @ArtTipo NOT IN ('JUEGO', 'SERVICIO') /*AND NOT (@MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND @AplicaMovTipo='VTAS.R')*/ AND @Ok IS NULL
                BEGIN
  		  IF @EsEntrada = 1 OR (@EsSalida = 0 AND @EsTransferencia = 1 AND @Accion <> 'CANCELAR') SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0
                  IF @MovTipo = 'COMS.B'  IF @Accion <> 'CANCELAR' SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1
                  IF @MovTipo IN ('COMS.CA', 'COMS.GX') IF @Accion <> 'CANCELAR' SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0

			IF @AlmacenTipo = 'ACTIVOS FIJOS' 
              SELECT @AfectarRama = 'AF' 
            ELSE 
              SELECT @AfectarRama = 'INV'

            IF @MovTipo = 'INV.TMA' AND @WMS = 1 AND @WMSAlmacen = 1 --Task 8036
              SELECT @AfectarRama = 'WMS'

            IF  @MovTipo IN ('INV.TMA')  AND @WMS = 1 AND @WMSAlmacen = 1 AND @Tarima IS NOT NULL --Task 8036
                    EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, @AfectarRama, @ArtMoneda, @ArtTipoCambio, @Articulo, @SubCuenta, @AfectarAlmacen, @AfectarAlmacenDestino, 
                                 @Modulo, @ID, @Mov, @MovID, @EsCargo, 0, @AfectarCantidad, @Factor,
                                 @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
   	  	                         @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @SubGrupo = @Tarima

            /* Viene de una Remision al Facturar */
            IF EXISTS(SELECT * FROM Movtipo WHERE Modulo = 'VTAS' AND Clave = 'VTAS.VCR' AND Mov = @Origen) AND @MovTipo = 'VTAS.F'
                SET @CostoInvTotal = 0

            IF  @MovTipo NOT IN('INV.TMA') --Task 8036
                    EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, @AfectarRama, @ArtMoneda, @ArtTipoCambio, @Articulo, @SubCuenta, @AfectarAlmacen, @AfectarAlmacenDestino, 
                                 @Modulo, @ID, @Mov, @MovID, @EsCargo, @CostoInvTotal, @AfectarCantidad, @Factor,
                                 @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
   	  	                         @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID
            
			/* Viene de una Remision al Facturar */
            IF NOT EXISTS(SELECT * FROM Movtipo WHERE Modulo = 'VTAS' AND Clave = 'VTAS.VCR' AND Mov = @Origen)
				IF  @MovTipo IN('VTAS.F','VTAS.FM','VTAS.FR','INV.SI','INV.T','VTAS.VCR','VTAS.R','INV.A','INV.S') AND @WMS = 1 AND @WMSAlmacen = 1--Task 8036
                    EXEC spSaldo @SucursalAlmacen, @Accion, @Empresa, @Usuario, 'WMS', @ArtMoneda, @ArtTipoCambio, @Articulo, @SubCuenta, @AfectarAlmacen, @AfectarAlmacenDestino, 
                                 @Modulo, @ID, @Mov, @MovID, @EsCargo, 0, @AfectarCantidad, @Factor,
                                 @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
   	  	                         @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @SubGrupo = @Tarima
            
			--TASK25114   --BUG24540
            IF @WMS = 1 AND @Modulo = 'INV' AND @MovTipo = 'INV.A'
 		    BEGIN
 		      IF (SELECT Tipo FROM AlmPos WHERE Almacen = @AfectarAlmacen AND Posicion = @PosicionReal) <> 'Domicilio'
 		      BEGIN
 		        IF @Accion IN('AFECTAR', 'CANCELAR') AND (SELECT Disponible FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @AfectarAlmacen AND Empresa = @Empresa AND Articulo = @Articulo) = 0
 		        BEGIN		         		         		          
				  UPDATE Tarima SET Estatus = 'BAJA', Baja = GETDATE() /*, Alta = NULL*/ WHERE Tarima = @Tarima --BUG3040
 		           		          
 		          IF @OrigenMovTipo = 'INV.IF'
 		          BEGIN
 		            IF EXISTS(SELECT * FROM InvD WHERE ID = @ID AND Articulo <> @Articulo AND Tarima = @Tarima)
 		            BEGIN
 		              DELETE SaldoUWMS WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = 'INV' AND Grupo = @Almacen AND Cuenta = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND SaldoU = 0 AND SubGrupo = @Tarima
 		            END
 		          END
 		        END
 		        
 		        IF @OrigenMovTipo = 'INV.IF'
 		        BEGIN
 		          DELETE SaldoUWMS WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = 'INV' AND Grupo = @Almacen AND Cuenta <> @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND SaldoU = 0 AND SubGrupo = @Tarima
 		        END   		        
 		        
 		        IF @Accion IN('AFECTAR', 'CANCELAR') AND (SELECT Disponible FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Empresa = @Empresa AND Articulo = @Articulo) > 0
 		          --BUG25657
 		          UPDATE Tarima SET Estatus = 'ALTA', Baja = NULL /*, Alta = GETDATE()*/ WHERE Tarima = @Tarima
 		          
                --BUG24540
                --EWQ. Tuning
                IF @Accion = 'AFECTAR' AND @PosicionActual <> @PosicionReal /*AND ISNULL(@PosicionActual,'') <> '' */AND ISNULL(@PosicionReal,'') <> ''
                  UPDATE Tarima SET Posicion = @PosicionReal WHERE Tarima = @Tarima

                IF @Accion = 'CANCELAR' AND @PosicionActual <> @PosicionReal AND ISNULL(@PosicionActual,'') <> '' /*AND ISNULL(@PosicionReal,'') <> ''*/
                  UPDATE Tarima SET Posicion = @PosicionActual WHERE Tarima = @Tarima
 		      END
 		    END
	
                END 
              END  -- Afectar Costos
              -- Afectar SeriesLotes
              IF @AfectarSerieLote = 1 AND @Ok IS NULL AND @Tarima IS NOT NULL AND @AfectarRama = 'WMS' --Task 8036
              BEGIN
                EXEC spSeriesLotesWMS @Empresa, @Modulo, @Accion, @EsEntrada, @EsSalida,
                                      @ID, @RenglonID, @Articulo, @SubCuenta, @MovTipo,
                                      @AplicaMovTipo, @FechaEmision, 0, @Tarima, 
                                      @Cantidad, @Ok OUTPUT, @OkRef OUTPUT
              END
              IF @AfectarSerieLote = 1 AND @Ok IS NULL AND @AfectarRama <> 'WMS' --Task 8036
              BEGIN
                EXEC spSeriesLotesMayoreo @Sucursal, @SucursalAlmacen, @SucursalAlmacenDestino, @Empresa, @Modulo, @Accion, @AfectarCostos, @EsEntrada, @EsSalida, @EsTransferencia,
                                          @ID, @RenglonID, @Almacen, @AlmacenDestino, @Articulo, @SubCuenta, @ArtTipo, @ArtSerieLoteInfo, @ArtLotesFijos, @ArtCosto, @ArtCostoInv, @Cantidad, @Factor, 
       				          @MovTipo, @AplicaMovTipo, @AlmacenTipo, @FechaEmision, @CfgCosteoSeries, @CfgCosteoLotes, @ArtCostoIdentificado, @CfgValidarLotesCostoDif, @CfgVINAccesorioArt, @CfgVINCostoSumaAccesorios,
                                          @Ok OUTPUT, @OkRef OUTPUT--, @Tarima = @Tarima--Task 8036
                IF @ArtTipo = 'VIN' 
                BEGIN
                  IF @Modulo = 'VTAS'
	          BEGIN
  		    IF @VIN IS NOT NULL SELECT @Ok = 20630
		    SELECT @VIN = MIN(SerieLote) FROM SerieLoteMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID AND Articulo  = @Articulo
                    IF @MovTipo = 'VTAS.F'
                      UPDATE Venta SET ServicioArticulo = @Articulo, ServicioSerie = @VIN WHERE ID = @ID
                  END

                  IF @Accion = 'CANCELAR' AND @Ok IS NULL
                    UPDATE VIN 
                       SET FechaMRS = NULL
                      FROM VIN v, SerieLoteMov s
		     WHERE s.Empresa = @Empresa AND s.Modulo = @Modulo AND s.ID = @ID AND s.RenglonID = @RenglonID AND s.Articulo  = @Articulo
                       AND v.VIN = s.SerieLote AND v.TieneMovimientos = 0
                  ELSE BEGIN
                    IF EXISTS(
                    SELECT v.VIN
                      FROM VIN v, SerieLoteMov s
		     WHERE s.Empresa = @Empresa AND s.Modulo = @Modulo AND s.ID = @ID AND s.RenglonID = @RenglonID AND s.Articulo  = @Articulo
                       AND v.VIN = s.SerieLote AND v.TieneMovimientos = 0)
                      UPDATE VIN 
	  	         SET TieneMovimientos = 1 
                        FROM VIN v, SerieLoteMov s
  		       WHERE s.Empresa = @Empresa AND s.Modulo = @Modulo AND s.ID = @ID AND s.RenglonID = @RenglonID AND s.Articulo  = @Articulo
                         AND v.VIN = s.SerieLote AND v.TieneMovimientos = 0

                    IF @MovTipo IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI')
		      EXEC spVINEntrada @Empresa, @Modulo, @ID, @Mov, @RenglonID, @Articulo, @FechaEmision, @FechaRequerida, @ImporteNeto, @Impuesto1Neto, @VIN OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

		    IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.FB') 
                      UPDATE VIN 
		         SET Cliente = @ClienteProv,
                             FechaSalida = @FechaEmision,
                             VentaID = @ID
                        FROM VIN v, SerieLoteMov s
		       WHERE s.Empresa = @Empresa AND s.Modulo = @Modulo AND s.ID = @ID AND s.RenglonID = @RenglonID AND s.Articulo  = @Articulo
                         AND v.VIN = s.SerieLote 
		  END 
                END
              END

	      -- Afectar SeriesLotes en Facturas de Mostrador 	
              IF (@MovTipo = 'VTAS.FM' AND @FacturarVtasMostrador = 1 AND @ArtTipo IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA') AND @Accion <> 'CANCELAR')
              BEGIN
                SELECT @CantidadDif = @Cantidad
                SELECT @CantidadDif = @Cantidad - ISNULL(SUM(Cantidad) / @Factor, 0.0)
                  FROM SerieLoteMov
                 WHERE Empresa   = @Empresa
                   AND Modulo    = @Modulo
                   AND ID        = @ID
                   AND RenglonID = @RenglonID
                   AND Articulo  = @Articulo
                   AND ISNULL(RTRIM(SubCuenta), '') = ISNULL(@SubCuenta, '')
                IF @CantidadDif <> 0.0
                BEGIN
                  DECLARE @SerieLoteMov TABLE (Sucursal int NULL, Empresa char(5) COLLATE Database_Default NULL, Modulo char(5) COLLATE Database_Default NULL, ID int NULL, RenglonID int NULL, Articulo varchar(20) COLLATE Database_Default NULL, SubCuenta varchar(50) COLLATE Database_Default NULL, SerieLote varchar(20) COLLATE Database_Default NULL, Cantidad float NULL, CantidadAlterna float NULL, Propiedades varchar(20) COLLATE Database_Default NULL, ArtCostoInv money NULL, Cliente varchar(10) COLLATE Database_Default NULL, Localizacion varchar(10) COLLATE Database_Default NULL)
	  	  EXEC spSeriesLotesSurtidoAuto @Sucursal, @Empresa, @Modulo, @EsSalida, @EsTransferencia,
			  		        @ID,  @RenglonID, @Almacen, @Articulo, @SubCuenta, @CantidadDif, @Factor,
				                @AlmacenTipo, @SeriesLotesAutoOrden,	
                                                @Ok OUTPUT, @OkRef OUTPUT, @Temp = 1, @Tarima = @Tarima
                  EXEC spSeriesLotesMayoreo @Sucursal, @SucursalAlmacen, @SucursalAlmacenDestino, @Empresa, @Modulo, @Accion, @AfectarCostos, @EsEntrada, @EsSalida, @EsTransferencia,
                                            @ID, @RenglonID, @Almacen, @AlmacenDestino, @Articulo, @SubCuenta, @ArtTipo, @ArtSerieLoteInfo, @ArtLotesFijos, @ArtCosto, @ArtCostoInv, @CantidadDif, @Factor, 
        				    @MovTipo, @AplicaMovTipo, @AlmacenTipo, @FechaEmision, @CfgCosteoSeries, @CfgCosteoLotes, @ArtCostoIdentificado, @CfgValidarLotesCostoDif, @CfgVINAccesorioArt, @CfgVINCostoSumaAccesorios,                                            
											@Ok OUTPUT, @OkRef OUTPUT, @Temp = 1--, @Tarima = @Tarima --Task 8036
                  EXEC spSeriesLotesFusionarTemp @Ok OUTPUT, @OkRef OUTPUT

--                  DROP TABLE @SerieLoteMov 

                  SELECT @CantidadDif = @Cantidad
                  SELECT @CantidadDif = @Cantidad - ISNULL(SUM(Cantidad) / @Factor, 0.0)
                    FROM SerieLoteMov
                   WHERE Empresa   = @Empresa
                     AND Modulo    = @Modulo
                     AND ID        = @ID
                     AND RenglonID = @RenglonID
                     AND Articulo  = @Articulo
                     AND ISNULL(RTRIM(SubCuenta), '') = ISNULL(@SubCuenta, '')
                  IF @CantidadDif <> 0.0 SELECT @Ok = 20330
                END
              END
              

	      -- Recalcular Factores de Unidades
              IF @AfectarCostos = 1 AND @CfgMultiUnidades = 1 AND @CfgMultiUnidadesNivel = 'ARTICULO'
		EXEC xpArtUnidadFactorRecalc @Empresa, @Accion,	@Modulo, @ID, @Renglon, @RenglonSub, @MovTipo, @AlmacenTipo,
		    			     @Articulo, @SubCuenta, @MovUnidad, @ArtTipo, @Factor,
					     @Almacen, @Cantidad, @CantidadInventario, @EsEntrada, @EsSalida,
					     @Ok OUTPUT, @OkRef OUTPUT


              IF @Modulo IN ('COMS', 'PROD', 'INV')
              BEGIN
                IF (@CfgBackOrders = 1 AND @MovTipo IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI', 'COMS.IG', 'INV.T', 'INV.T', 'INV.EI') OR (@MovTipo='PROD.E')) AND @Accion <> 'CANCELAR'
                BEGIN
                  SELECT @Cliente = NULL
	          SELECT @DestinoTipo = NULL, @Destino = NULL, @DestinoID = NULL

                  IF @Modulo = 'COMS' SELECT @Cliente = Cliente FROM CompraD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
                  IF @Modulo = 'INV'  SELECT @Cliente = Cliente, @DestinoTipo = DestinoTipo, @Destino = Destino, @DestinoID = DestinoID FROM InvD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
                  IF @Modulo = 'PROD' SELECT @Cliente = Cliente FROM ProdD   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 

                  IF @Modulo = 'INV' AND @Largo = 1 AND (@Cliente IS NOT NULL OR @DestinoTipo IS NOT NULL) SELECT @Ok = 20970
                  IF @Cliente IS NOT NULL
                    EXEC spInvBackOrderCliente @Sucursal, @Empresa, @Usuario, @Cliente, @Articulo, @SubCuenta, @Cantidad, @Factor, 
            	 		               @ArtMoneda, @Almacen, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo,
				               @Ok OUTPUT, @OkRef OUTPUT                
                END

                IF @MovTipo IN ('COMS.D', 'COMS.B', 'COMS.CA', 'COMS.GX') AND @AfectarCostos = 1 
                BEGIN
--COMENTARIO_0005
                  SELECT @DescuentoInverso = 100-ISNULL(@DescuentoGlobal, 0)
                  EXEC spR3 @DescuentoInverso, @Costo, 100, @Precio OUTPUT
      	          EXEC spCalculaImporte @Accion, @Modulo, @CfgImpInc, @MovTipo, @EsEntrada, @CantidadCalcularImporte, @Precio, NULL, NULL, @DescuentoGlobal, @SobrePrecio, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5,
                                        @Importe OUTPUT, @ImporteNeto OUTPUT, @DescuentoLineaImporte OUTPUT, @DescuentoGlobalImporte OUTPUT, @SobrePrecioImporte OUTPUT,
                                        @Impuestos OUTPUT, @ImpuestosNetos OUTPUT, @Impuesto1Neto OUTPUT, @Impuesto2Neto OUTPUT, @Impuesto3Neto OUTPUT, @Impuesto5Neto OUTPUT,  
					@Articulo = @Articulo, @CantidadObsequio = @CantidadObsequio, @CfgPrecioMoneda = @CfgPrecioMoneda, @MovTipoCambio = @MovTipoCambio, @PrecioTipoCambio = @PrecioTipoCambio,
					@Retencion1 = @Retencion1, @Retencion2 = @Retencion2, @Retencion3 = @Retencion3, @ID = @ID, @AnticipoFacturado = @AnticipoFacturado --ANTICIPOFACTURADO
                END ELSE BEGIN
                  SELECT @ImporteNeto = @Costo * @Cantidad
                END

              END
              IF @Modulo = 'PROD' SELECT @Importe = @Cantidad * @Costo

              IF @MovTipo = 'PROD.O' AND @Accion = 'AFECTAR'
              BEGIN
                EXEC spProdCentroInicial @ID, @Articulo, @SubCuenta, @ProdSerieLote, @Orden OUTPUT, @OrdenDestino OUTPUT, @Centro OUTPUT, @CentroDestino OUTPUT, @Estacion OUTPUT, @EstacionDestino OUTPUT
                UPDATE ProdD SET Centro = @Centro, Orden = @Orden, CentroDestino = @CentroDestino, OrdenDestino = @OrdenDestino, Estacion = @Estacion, EstacionDestino = @EstacionDestino WHERE CURRENT OF crProdDetalle
              END

              IF @MovTipo IN ('PROD.O', 'PROD.CO', 'PROD.E')
		EXEC spProdSerieLote @Sucursal, @Accion, @Empresa, @MovTipo, @FechaEmision, @DetalleTipo, @ProdSerieLote, @Articulo, @SubCuenta, @Cantidad, @Merma, @Desperdicio, @Factor, @Ok OUTPUT, @OkRef OUTPUT

              IF @MovTipo = 'INV.CM' AND @SubClave <> 'INV.SAUX'
                EXEC spProdSerieLoteCosto @Sucursal, @Accion, @Empresa, @Modulo, @ID, @MovTipo, @DetalleTipo, @ProdSerieLote, @Producto, @SubProducto, @CostoInvTotal, @ArtMoneda, @Mov, 0

              IF @MovTipo = 'PROD.E'
                EXEC spProdSerieLoteCosto @Sucursal, @Accion, @Empresa, @Modulo, @ID, @MovTipo, @DetalleTipo, @ProdSerieLote, @Articulo, @SubCuenta, @CostoInvTotal, @ArtMoneda, @Mov, 0

	      -- Afectar Activos Fijos
              IF @AlmacenTipo = 'ACTIVOS FIJOS' AND @ArtTipo IN ('SERIE', 'VIN') AND @CfgSeriesLotesMayoreo = 1 AND @Ok IS NULL AND
                (@EsEntrada = 1 OR @EsSalida = 1 OR @EsTransferencia = 1) AND @OrigenMovTipo <> 'COMS.CC'
                EXEC spActivoF @Sucursal, @Empresa, @Modulo, @Accion, @EsEntrada, @EsSalida, @EsTransferencia, 
                               @ID, @RenglonID, @Almacen, @AlmacenDestino, @Articulo, @ArtTipo, @Cantidad, 
			       @ArtCostoInv, @ArtMoneda, @FechaEmision, 
			       @Ok OUTPUT, @OkRef OUTPUT
              -- Afectar Estadisticas (Ventas)
              IF @Modulo = 'VTAS' AND 
                (@EstatusNuevo = 'CONCLUIDO' OR (@EstatusNuevo = 'CANCELADO' AND @Estatus <> 'PENDIENTE')) AND 
                (@MovTipo IN ('VTAS.F','VTAS.FAR','VTAS.FB', 'VTAS.D', 'VTAS.DF', 'VTAS.B') OR 
                (@MovTipo = 'VTAS.FM' AND @FacturarVtasMostrador = 1 AND @Accion <> 'CANCELAR')) AND @Ok IS NULL
              BEGIN
                IF @ArtTipo IN ('SERIE','LOTE','VIN') AND @CfgSeriesLotesMayoreo = 0 
                  SELECT @AcumularSinDetalles = 1 
                ELSE SELECT @AcumularSinDetalles = 0
		IF @MovTipo IN ('VTAS.F','VTAS.FAR','VTAS.FB','VTAS.FM') SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0

		/** 02.08.2006 **/
		/** 16.11.2006 **/
                IF @CantidadOriginal<0.0 SELECT @EsCargo = ~@EsCargo

                IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo
                IF @MovTipo = 'VTAS.B' SELECT @AcumCantidad = NULL ELSE SELECT @AcumCantidad = @Cantidad
         	EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'VTAS', @MovMoneda, NULL, @Articulo, @SubCuenta, @ClienteProv,  NULL,
                             @Modulo, @ID, @Mov, @MovID, @EsCargo, @ImporteNeto, @AcumCantidad, @Factor,
                             @FechaAfectacion, @Ejercicio, @Periodo, NULL, NULL, 0, @AcumularSinDetalles, 0,
			     @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID
              END ELSE

              -- Afectar Estadisticas (Compra)
              IF @Modulo = 'COMS' AND (@EstatusNuevo = 'CONCLUIDO' OR (@EstatusNuevo = 'CANCELADO' AND @Estatus <> 'PENDIENTE')) AND @MovTipo IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.D','COMS.B','COMS.CA', 'COMS.GX') AND @Ok IS NULL
              BEGIN
                IF @ArtTipo IN ('SERIE','LOTE','VIN') AND @CfgSeriesLotesMayoreo = 0 
                  SELECT @AcumularSinDetalles = 1 
                ELSE SELECT @AcumularSinDetalles = 0
		IF @MovTipo IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.CA', 'COMS.GX') SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0
                IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo
                IF @MovTipo IN ('COMS.B', 'COMS.CA', 'COMS.GX') SELECT @AcumCantidad = NULL ELSE SELECT @AcumCantidad = @Cantidad
         	EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'COMS', @MovMoneda, NULL, @Articulo, @SubCuenta, @ClienteProv, NULL,
                             @Modulo, @ID, @Mov, @MovID, @EsCargo, @ImporteNeto, @AcumCantidad, @Factor,
                             @FechaAfectacion, @Ejercicio, @Periodo, NULL, NULL, 0, @AcumularSinDetalles, 0,
			     @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID

	        -- Afectar ArtProv
                IF @MovTipo IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI') AND @Accion <> 'CANCELAR'
                BEGIN
                  IF @MovTipo = 'COMS.EI' 
                    SELECT @ProveedorRef = ISNULL(NULLIF(RTRIM(ImportacionProveedor), ''), @ClienteProv) FROM CompraD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
                  ELSE
                    SELECT @ProveedorRef = @ClienteProv
                  IF @CostosImpuestoIncluido = 1 SELECT @ArtProvCosto = @Costo ELSE SELECT @ArtProvCosto = @ArtCosto

                  EXEC xpArtProv @Empresa, @Accion, @Modulo, @ID, @Renglon, @RenglonSub, @MovTipo, @AlmacenTipo,
    			         @Articulo, @SubCuenta, @MovUnidad, @ArtTipo, @Factor,
				 @Almacen, @Cantidad, @CantidadInventario, @EsEntrada, @EsSalida,
                       	         @ProveedorRef, @ArtProvCosto, @FechaEmision,
				 @Ok OUTPUT, @OkRef OUTPUT
		END
              END
--DMJ Factory
              IF (@CfgPosiciones = 1 OR @CfgExistenciaAlterna = 1) AND @OrigenTipo <> 'VMOS' AND @AlmacenTipo <> 'ACTIVOS FIJOS' AND @ArtTipo NOT IN ('JUEGO', 'SERVICIO') AND (@EsEntrada = 1 OR @EsSalida = 1 OR @EsTransferencia = 1 OR @MovTipo IN ('COMS.CC','INV.CPOS') OR @Mov = @CfgEstadisticaAjusteMerma) AND @Ok IS NULL AND (SELECT ISNULL(Ubicaciones,0) FROM Alm WHERE Almacen = @Almacen) = 1
              BEGIN
                IF @CfgPosiciones = 1 AND @Posicion IS NULL 
                BEGIN
                  IF @WMS = 0 SELECT @Ok = 13050 --REQ12615 WMS
                END  
                ELSE BEGIN
                  IF @MovTipo NOT IN ('COMS.CC','INV.CPOS')
                  BEGIN
                    SELECT @AuxiliarAlternoSucursal = @SucursalAlmacen, @AuxiliarAlternoAlmacen = @Almacen
                    IF @Accion = 'CANCELAR' 
                      SELECT @AuxiliarAlternoFactorEntrada = -1.0, @AuxiliarAlternoFactorSalida = NULL
                    ELSE
                      SELECT @AuxiliarAlternoFactorEntrada = NULL, @AuxiliarAlternoFactorSalida = 1.0

                    IF @EsSalida = 1 OR @EsTransferencia = 1
                    BEGIN
                      IF @CfgExistenciaAlternaSerieLote = 1 AND @ArtTipo IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA')
                        INSERT AuxiliarAlterno 
                              (Empresa,  Sucursal,                 Almacen,                 Posicion,  SerieLote, Modulo,  ID,  Renglon,  RenglonSub,  Articulo,  SubCuenta,  Unidad,     Factor,  Entrada,                                Salida)
                        SELECT @Empresa, @AuxiliarAlternoSucursal, @AuxiliarAlternoAlmacen, @Posicion, SerieLote, @Modulo, @ID, @Renglon, @RenglonSub, @Articulo, @SubCuenta, @MovUnidad, @Factor, Cantidad*@AuxiliarAlternoFactorEntrada, Cantidad*@AuxiliarAlternoFactorSalida
                          FROM SerieLoteMov
                         WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
		      ELSE
                        INSERT AuxiliarAlterno 
                              (Empresa,  Sucursal,                 Almacen,                 Posicion,  Modulo,  ID,  Renglon,  RenglonSub,  Articulo,  SubCuenta,  Unidad,     Factor,  Entrada,                                 Salida)
                        SELECT @Empresa, @AuxiliarAlternoSucursal, @AuxiliarAlternoAlmacen, @Posicion, @Modulo, @ID, @Renglon, @RenglonSub, @Articulo, @SubCuenta, @MovUnidad, @Factor, @Cantidad*@AuxiliarAlternoFactorEntrada, @Cantidad*@AuxiliarAlternoFactorSalida
                    END

                    IF @EsTransferencia = 1
                      SELECT @AuxiliarAlternoSucursal = @SucursalAlmacenDestino, @AuxiliarAlternoAlmacen = @AlmacenDestino
                    IF @Accion = 'CANCELAR' 
                      SELECT @AuxiliarAlternoFactorEntrada = NULL, @AuxiliarAlternoFactorSalida = -1.0
                    ELSE
                      SELECT @AuxiliarAlternoFactorEntrada = 1.0, @AuxiliarAlternoFactorSalida = NULL

                    IF @EsEntrada = 1 OR @EsTransferencia = 1 OR @Mov = @CfgEstadisticaAjusteMerma
                    BEGIN
                      IF @CfgExistenciaAlternaSerieLote = 1 AND @ArtTipo IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA')
                        INSERT AuxiliarAlterno 
                              (Empresa,  Sucursal,                 Almacen,                 Posicion,                           SerieLote, Modulo,  ID,  Renglon,  RenglonSub,  Articulo,  SubCuenta,  Unidad,     Factor,  Entrada,                                Salida)
                        SELECT @Empresa, @AuxiliarAlternoSucursal, @AuxiliarAlternoAlmacen, ISNULL(@PosicionDestino,@Posicion), SerieLote, @Modulo, @ID, @Renglon, @RenglonSub, @Articulo, @SubCuenta, @MovUnidad, @Factor, Cantidad*@AuxiliarAlternoFactorEntrada, Cantidad*@AuxiliarAlternoFactorSalida
                          FROM SerieLoteMov
                         WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
		      ELSE
                        INSERT AuxiliarAlterno 
                              (Empresa,  Sucursal,                 Almacen,                 Posicion,                           Modulo,  ID,  Renglon,  RenglonSub,  Articulo,  SubCuenta,  Unidad,     Factor,  Entrada,                                 Salida)
                        SELECT @Empresa, @AuxiliarAlternoSucursal, @AuxiliarAlternoAlmacen, ISNULL(@PosicionDestino,@Posicion), @Modulo, @ID, @Renglon, @RenglonSub, @Articulo, @SubCuenta, @MovUnidad, @Factor, @Cantidad*@AuxiliarAlternoFactorEntrada, @Cantidad*@AuxiliarAlternoFactorSalida
                    END
                  END
		  IF @MovTipo ='INV.CPOS'
                  BEGIN
                    SELECT @AuxiliarAlternoSucursal = @SucursalAlmacen, @AuxiliarAlternoAlmacen = @Almacen
                    IF @CfgExistenciaAlternaSerieLote = 1 AND @ArtTipo IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA')
                    BEGIN
                      INSERT AuxiliarAlterno(Empresa,  Sucursal,                 Almacen,                 Posicion,  SerieLote, Modulo,  ID,  Renglon,  RenglonSub,  Articulo,  SubCuenta,  Unidad,     Factor,  Entrada, Salida)
                      SELECT                 @Empresa, @AuxiliarAlternoSucursal, @AuxiliarAlternoAlmacen, @Posicion, SerieLote, @Modulo, @ID, @Renglon, @RenglonSub, @Articulo, @SubCuenta, @MovUnidad, @Factor, 0.0,     CASE WHEN @Accion = 'CANCELAR' THEN @Cantidad *-1 ELSE @Cantidad  END
                        FROM SerieLoteMov
                       WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
                    
                      INSERT AuxiliarAlterno (Empresa,  Sucursal,                 Almacen,                 Posicion,         SerieLote, Modulo,  ID,  Renglon,  RenglonSub,  Articulo,  SubCuenta,  Unidad,     Factor,  Entrada,                                                      Salida)
                      SELECT                 @Empresa, @AuxiliarAlternoSucursal, @AuxiliarAlternoAlmacen, @PosicionDestino, SerieLote, @Modulo, @ID, @Renglon, @RenglonSub, @Articulo, @SubCuenta, @MovUnidad, @Factor,  CASE WHEN @Accion = 'CANCELAR' THEN @Cantidad*-1 ELSE @Cantidad END,  0.0
                    	FROM SerieLoteMov
                       WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')                         
                    END
                    ELSE
                    BEGIN
                      INSERT AuxiliarAlterno (Empresa,  Sucursal,                 Almacen,                 Posicion,  Modulo,  ID,  Renglon,  RenglonSub,  Articulo,  SubCuenta,  Unidad,     Factor,  Entrada,  Salida)
                      SELECT                  @Empresa, @AuxiliarAlternoSucursal, @AuxiliarAlternoAlmacen, @Posicion, @Modulo, @ID, @Renglon, @RenglonSub, @Articulo, @SubCuenta, @MovUnidad, @Factor, 0.0,      CASE WHEN @Accion = 'CANCELAR' THEN @Cantidad *-1 ELSE @Cantidad  END
                      INSERT AuxiliarAlterno (Empresa,  Sucursal,                 Almacen,                 Posicion,         Modulo,  ID,  Renglon,  RenglonSub,  Articulo,  SubCuenta,  Unidad,     Factor,  Entrada,                                                              Salida)
                      SELECT                  @Empresa, @AuxiliarAlternoSucursal, @AuxiliarAlternoAlmacen, @PosicionDestino, @Modulo, @ID, @Renglon, @RenglonSub, @Articulo, @SubCuenta, @MovUnidad, @Factor, CASE WHEN @Accion = 'CANCELAR' THEN @Cantidad*-1 ELSE @Cantidad END,  0.0
                    END  
                  END                         
                END
              END

              -- Matar el Pendiente Directamente (con Utilizar)
              IF @AfectarMatando = 1 AND @Utilizar = 1 AND @AplicaMov IS NOT NULL AND @AplicaMovID IS NOT NULL AND @Ok IS NULL
                SELECT @Ok = 71050

              -- Si afecta como pendiente generarlo y si afecta a la cantidad pendiente disminuirla
              IF (@Estatus = 'PENDIENTE' OR @EstatusNuevo = 'PENDIENTE') AND @Ok IS NULL
              BEGIN
                -- Si afecta como pendiente poner la cantidad pendiente
                IF @EstatusNuevo = 'PENDIENTE' 
                BEGIN
                  IF @Accion IN ('ASIGNAR', 'DESASIGNAR')
                    EXEC spInvAsignar @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Almacen, @Articulo, @SubCuenta, @MovUnidad, @Cantidad OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

                  IF @Accion = 'RESERVARPARCIAL' SELECT @CantidadPendiente = @Cantidad - @ReservadoParcial,  @CantidadReservada = @CantidadReservada + @ReservadoParcial ELSE
		  IF @Accion = 'RESERVAR'        SELECT @CantidadPendiente = @CantidadPendiente - @Cantidad, @CantidadReservada = @CantidadReservada + @Cantidad ELSE
		  IF @Accion = 'DESRESERVAR'  	 SELECT @CantidadPendiente = @CantidadPendiente + @Cantidad, @CantidadReservada = @CantidadReservada - @Cantidad ELSE 
		  IF @Accion = 'ASIGNAR'         SELECT @CantidadPendiente = @CantidadPendiente - @Cantidad, @CantidadOrdenada  = @CantidadOrdenada  + @Cantidad ELSE
		  IF @Accion = 'DESASIGNAR'      SELECT @CantidadPendiente = @CantidadPendiente + @Cantidad, @CantidadOrdenada  = @CantidadOrdenada  - @Cantidad ELSE
		  IF @Accion = 'CANCELAR' 
                  BEGIN
	  	    SELECT @CantidadReservada = @CantidadReservada - @Cantidad
                    IF @CantidadReservada < 0 
                      --- SELECT @CantidadPendiente = @CantidadPendiente + @CantidadReservada, @CantidadReservada = 0.0 (Bug 23531)
                      SELECT @CantidadPendiente = ROUND ((@CantidadPendiente + @CantidadReservada), 8), @CantidadReservada = 0.0
--COMENTARIO_0006
                  END ELSE SELECT @CantidadPendiente = @Cantidad
	        END 

		ELSE
		IF @EstatusNuevo = 'CANCELADO'
		  SELECT @CantidadReservada = 0.0, @CantidadPendiente = 0.0
  
 	        -- Si afecta al pendiente disminuir el pendiente
  		ELSE
                IF @Base IN ('SELECCION','PENDIENTE','TODO')
                  SELECT @CantidadPendiente = @CantidadPendiente - @Cantidad 

                IF @MovTipo IN ('VTAS.F','VTAS.FAR','VTAS.FC', 'VTAS.FG', 'VTAS.FX','VTAS.FB') AND @EstatusNuevo = 'CONCLUIDO' AND @Accion = 'AFECTAR' SELECT @CantidadPendiente = 0.0, @CantidadReservada = 0.0

		IF @Modulo NOT IN ('VTAS', 'INV', 'PROD') SELECT @CantidadOrdenada = 0.0
  	        -- Actualizar la Cantidad Pendiente del Detalle
                IF @CantidadPendiente = 0.0 SELECT @CantidadPendiente = NULL
                IF @CantidadReservada = 0.0 SELECT @CantidadReservada = NULL
                IF @CantidadOrdenada  = 0.0 SELECT @CantidadOrdenada  = NULL

                IF @Modulo = 'VTAS' UPDATE VentaD  SET CantidadCancelada = CASE WHEN @Accion = 'CANCELAR' AND @Base <> 'TODO' THEN ISNULL(CantidadCancelada, 0.0) + @Cantidad ELSE CantidadCancelada END, CantidadA = NULL, CantidadReservada = @CantidadReservada, UltimoReservadoCantidad = @UltReservadoCantidad, UltimoReservadoFecha = @UltReservadoFecha, CantidadOrdenada = @CantidadOrdenada, CantidadPendiente = @CantidadPendiente WHERE CURRENT OF crVentaDetalle ELSE
                IF @Modulo = 'INV'  UPDATE InvD    SET CantidadCancelada = CASE WHEN @Accion = 'CANCELAR' AND @Base <> 'TODO' THEN ISNULL(CantidadCancelada, 0.0) + @Cantidad ELSE CantidadCancelada END, CantidadA = NULL, CantidadReservada = @CantidadReservada, UltimoReservadoCantidad = @UltReservadoCantidad, UltimoReservadoFecha = @UltReservadoFecha, CantidadOrdenada = @CantidadOrdenada, CantidadPendiente = @CantidadPendiente WHERE CURRENT OF crInvDetalle ELSE
                IF @Modulo = 'PROD' UPDATE ProdD   SET CantidadCancelada = CASE WHEN @Accion = 'CANCELAR' AND @Base <> 'TODO' THEN ISNULL(CantidadCancelada, 0.0) + @Cantidad ELSE CantidadCancelada END, CantidadA = NULL, CantidadReservada = @CantidadReservada, UltimoReservadoCantidad = @UltReservadoCantidad, UltimoReservadoFecha = @UltReservadoFecha, CantidadOrdenada = @CantidadOrdenada, CantidadPendiente = @CantidadPendiente WHERE CURRENT OF crProdDetalle ELSE
                IF @Modulo = 'COMS' UPDATE CompraD SET CantidadCancelada = CASE WHEN @Accion = 'CANCELAR' AND @Base <> 'TODO' THEN ISNULL(CantidadCancelada, 0.0) + @Cantidad ELSE CantidadCancelada END, CantidadA = NULL, CantidadPendiente = @CantidadPendiente WHERE CURRENT OF crCompraDetalle 
                IF @@ERROR <> 0 SELECT @Ok = 1

--COMENTARIO_0007

		EXEC spArtR @Empresa, @Modulo, @Articulo, @SubCuenta, @Almacen, @MovTipo, @Factor, NULL, @CantidadPendienteA, @CantidadPendiente, NULL, @CantidadOrdenadaA, @CantidadOrdenada
              
                IF @CfgBackOrders = 1 AND @MovTipo IN ('COMS.O', 'COMS.OG', 'COMS.OI', 'PROD.O', 'INV.OT', 'INV.OI') AND @AplicaMovTipo IS NULL
                BEGIN
		   SELECT @DestinoTipo = NULL, @Destino = NULL, @DestinoID = NULL
                   IF @Modulo = 'COMS' SELECT @DestinoTipo = DestinoTipo, @Destino = Destino, @DestinoID = DestinoID FROM CompraD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
                   IF @Modulo = 'INV'  SELECT @DestinoTipo = DestinoTipo, @Destino = Destino, @DestinoID = DestinoID FROM InvD    WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
                   IF @Modulo = 'PROD' SELECT @DestinoTipo = DestinoTipo, @Destino = Destino, @DestinoID = DestinoID FROM ProdD   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
                   IF @DestinoTipo IN (SELECT Modulo FROM Modulo) AND @Destino IS NOT NULL AND @DestinoID IS NOT NULL 
                     EXEC spInvBackOrder @Sucursal, @Accion, @Estatus, 0, @Empresa, @Usuario, @Modulo, @ID, @Mov, @MovID, 
                                         @DestinoTipo, @Destino, @DestinoID, @Articulo, @SubCuenta, @MovUnidad, @Cantidad, @Factor, @ArtMoneda, 
				  	 @Almacen, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo,
 				         @Ok OUTPUT, @OkRef OUTPUT, @MovTipo = @MovTipo
		END
              END
            --END -- Afectacion normal

              IF @CfgBackOrders = 1 AND @MovTipo = 'COMS.CP'
              BEGIN
                SELECT @DestinoTipo = NULL, @Destino = NULL, @DestinoID = NULL
                IF @Modulo = 'COMS' SELECT @DestinoTipo = DestinoTipo, @Destino = Destino, @DestinoID = DestinoID FROM CompraD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
                IF @DestinoTipo IN (SELECT Modulo FROM Modulo) AND @Destino IS NOT NULL AND @DestinoID IS NOT NULL 
                  EXEC spInvBackOrder @Sucursal, @Accion, @Estatus, 0, @Empresa, @Usuario, @Modulo, @ID, @Mov, @MovID, 
                                      @DestinoTipo, @Destino, @DestinoID, @Articulo, @SubCuenta, @MovUnidad, @Cantidad, @Factor, @ArtMoneda, 
		           	      @Almacen, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo,
 				      @Ok OUTPUT, @OkRef OUTPUT, @MovTipo = @MovTipo
              END
          END -- no Generar o Generar y Afectar

			IF @CfgBackOrders = 1 AND @MovTipo = 'VTAS.P' AND @Accion NOT IN ('RESERVARPARCIAL','ASIGNAR' )
              BEGIN
                SELECT @DestinoTipo = @Modulo, @Destino = @Mov, @DestinoID = @MovID
				SELECT @Cantidad = sum(Cantidad) from VentaD where id = @ID
                  EXEC spInvBackOrder @Sucursal, @Accion, @Estatus, 0, @Empresa, @Usuario, @Modulo, @ID, @Mov, @MovID, 
                                      @DestinoTipo, @Destino, @DestinoID, @Articulo, @SubCuenta, @MovUnidad, @Cantidad, @Factor, @ArtMoneda, 
		           	      @Almacen, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo,
 				      @Ok OUTPUT, @OkRef OUTPUT, @MovTipo = @MovTipo
              END

          IF @Generar = 1 AND @GenerarCopia = 1 AND @Ok IS NULL
          BEGIN
            -- Copiar Detalle Actual en GenerarID
            -- Ver spInvUtilizarTodoDetalle
            IF @MovTipo IN ('VTAS.C', 'VTAS.CS', 'VTAS.FR') SELECT @GenerarDirecto = 1 ELSE SELECT @GenerarDirecto = 0
            EXEC spInvGenerarDetalle @Sucursal, @Modulo, @ID, @Renglon, @RenglonSub, @IDGenerar, @GenerarDirecto, @Mov, @MovID, @Cantidad, @Ok OUTPUT

            IF @Base = 'SELECCION'
            BEGIN
              -- Limipiar la CantidadA
              IF @Modulo = 'VTAS' UPDATE VentaD  SET CantidadA = NULL WHERE CURRENT OF crVentaDetalle ELSE
              IF @Modulo = 'COMS' UPDATE CompraD SET CantidadA = NULL WHERE CURRENT OF crCompraDetalle ELSE
              IF @Modulo = 'INV'  UPDATE InvD    SET CantidadA = NULL WHERE CURRENT OF crInvDetalle ELSE
              IF @Modulo = 'PROD' UPDATE ProdD   SET CantidadA = NULL WHERE CURRENT OF crProdDetalle 
              IF @@ERROR <> 0 SELECT @Ok = 1
            END
          END

          -- Actualizar el Factor y la Unidad a NULL si Vacio y Estatus/Situacion
	  IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') 
          BEGIN
            SELECT @TiempoEstandarFijo	   = NULL,
                   @TiempoEstandarVariable = NULL
            IF @MovTipo IN ('PROD.A', 'PROD.E')
              SELECT @TiempoEstandarFijo = ISNULL(TiempoFijo, 0), @TiempoEstandarVariable = ISNULL(TiempoVariable, 0)*@Cantidad
                FROM ProdRutaD 
               WHERE Ruta = @Ruta AND Orden = @Orden AND Centro = @Centro

	    IF @Modulo = 'VTAS' UPDATE VentaD  SET Unidad = @MovUnidad, Factor = @Factor, ArtEstatus = CASE WHEN @CfgVentaArtEstatus = 1 THEN @ArtEstatus ELSE NULL END, ArtSituacion = CASE WHEN @CfgVentaArtSituacion = 1 THEN @ArtSituacion ELSE NULL END  WHERE CURRENT OF crVentaDetalle ELSE
            IF @Modulo = 'COMS' UPDATE CompraD SET Unidad = @MovUnidad, Factor = @Factor WHERE CURRENT OF crCompraDetalle ELSE
            IF @Modulo = 'INV'  UPDATE InvD    SET Unidad = @MovUnidad, Factor = @Factor WHERE CURRENT OF crInvDetalle ELSE
            IF @Modulo = 'PROD' UPDATE ProdD   SET Unidad = @MovUnidad, Factor = @Factor, TiempoEstandarFijo = @TiempoEstandarFijo, TiempoEstandarVariable = @TiempoEstandarVariable WHERE CURRENT OF crProdDetalle 
	  END

          IF @MovTipo = 'COMS.R' 
          BEGIN
            SELECT @CompraID = NULL
            SELECT @CompraID = MAX(c.ID)
              FROM Compra c, CompraD d, MovTipo mt 
             WHERE c.Empresa = @Empresa AND c.Estatus = 'CONCLUIDO' 
               AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI')
               AND d.ID = c.ID AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '')

            IF @CompraID IS NOT NULL
              SELECT @ProveedorRef = Proveedor FROM Compra WHERE ID = @CompraID
            ELSE 
            BEGIN
              SELECT @ProveedorRef = @ClienteProv
              SELECT @ProveedorRef = ISNULL(p.Proveedor, @ClienteProv)
                FROM Art a, Prov p
               WHERE a.Articulo = @Articulo AND p.Proveedor = a.Proveedor
            END
            UPDATE CompraD SET ProveedorRef = @ProveedorRef
             WHERE CURRENT OF crCompraDetalle
          END

          IF @Modulo = 'COMS' AND @Accion IN ('AFECTAR', 'CANCELAR') AND NULLIF(RTRIM(@ServicioSerie), '') IS NOT NULL
            EXEC spSerieLoteFlujo @Sucursal, @SucursalAlmacen, @SucursalAlmacenDestino, @Accion, @Empresa, @Modulo, @ID, @ServicioArticulo, NULL, @ServicioSerie, @Almacen, @RenglonID, @Tarima = @Tarima


          IF @MovTipo IN ('VTAS.P', 'VTAS.S', 'VTAS.SD', 'VTAS.F','VTAS.FAR', 'VTAS.FB', 'VTAS.D', 'VTAS.DF', 'VTAS.B', 'VTAS.FM', 'VTAS.N', 'VTAS.NO', 'VTAS.NR', 'PROD.A', 'PROD.R', 'PROD.E') AND @FacturarVtasMostrador = 0 AND (@Estatus IN ('SINAFECTAR', 'BORRADOR') OR @Accion = 'CANCELAR') AND @Ok IS NULL
          BEGIN
            IF @Accion = 'CANCELAR' 
            BEGIN
              IF @Modulo = 'VTAS' SELECT @ImporteComision = ISNULL(Comision, 0.0) FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
              IF @Modulo = 'PROD' SELECT @ImporteComision = ISNULL(Comision, 0.0) FROM ProdD  WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
            END ELSE BEGIN
  	      EXEC xpComisionCalcular @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
       	           	              @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Agente, @Conexion, @SincroFinal, @Sucursal,
		  		      @Renglon, @RenglonSub, @Articulo, @Cantidad, @Importe, @ImporteNeto, @Impuestos, @ImpuestosNetos, @Costo, @ArtCosto, @ArtComision,
                                      @ImporteComision OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
              IF ISNULL(@ImporteComision, 0.0) <> 0.0 AND @Ok IS NULL
              BEGIN
                IF @Modulo = 'VTAS' UPDATE VentaD SET Comision = @ImporteComision WHERE CURRENT OF crVentaDetalle ELSE
                IF @Modulo = 'PROD' UPDATE ProdD  SET Comision = @ImporteComision WHERE CURRENT OF crProdDetalle 
              END
            END
          END

          IF @MovTipo NOT IN ('COMS.R', 'COMS.C', 'COMS.O', 'COMS.OP') 
          BEGIN
            IF (SELECT TieneMovimientos FROM Art WHERE Articulo = @Articulo) = 0
              UPDATE Art SET TieneMovimientos = 1 WHERE Articulo = @Articulo
            IF NULLIF(RTRIM(@SubCuenta), '') IS NOT NULL
            BEGIN
              IF (SELECT TieneMovimientos FROM ArtSub WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta) = 0
                UPDATE ArtSub SET TieneMovimientos = 1 WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta
            END

            IF @MovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR', 'VTAS.FM', 'VTAS.F', 'COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI')
              EXEC spArtUlt @Articulo, @FechaEmision, @Modulo, @MovTipo, @ID
          END

          IF @EsEntrada = 1 OR @EsSalida = 1 OR @EsTransferencia = 1 
          BEGIN
            EXEC spRegistrarArtAlm @Empresa, @Articulo, @SubCuenta, @Almacen, @FechaEmision
            IF @AlmacenDestino IS NOT NULL
              EXEC spRegistrarArtAlm @Empresa, @Articulo, @SubCuenta, @AlmacenDestino, @FechaEmision
          END

          IF @MovTipo = 'PROD.O' AND @Centro IS NOT NULL
          BEGIN
            IF (SELECT TieneMovimientos FROM Centro WHERE Centro = @Centro) = 0
              UPDATE Centro SET TieneMovimientos = 1 WHERE Centro = @Centro
          END

          IF @Modulo = 'VTAS' AND @Mov = @CfgIngresoMov AND @CfgEspacios = 1
          BEGIN
            IF @Accion = 'CANCELAR'
            BEGIN
              SELECT @EspacioDAnterior = NULL
              IF @AplicaMov = @CfgIngresoMov 
                 SELECT @EspacioDAnterior = MIN(d.Espacio) 
                   FROM VentaD d, Venta v 
                  WHERE v.Empresa = @Empresa AND v.Mov = @AplicaMov AND v.MovID = @AplicaMovID AND v.Estatus IN ('CONCLUIDO', 'PENDIENTE')
                    AND d.ID = v.ID AND d.Articulo = @Articulo AND d.SubCuenta = @SubCuenta AND d.Espacio IS NOT NULL
              UPDATE Cte SET Espacio = NULLIF(RTRIM(@EspacioDAnterior), '') WHERE Cliente = @ClienteProv
            END ELSE
              IF @EspacioD IS NULL 
                SELECT @Ok = 10210
              ELSE
                UPDATE Cte SET Espacio = @EspacioD WHERE Cliente = @ClienteProv
          END

          IF @MovTipo = 'INV.IF' AND @Accion = 'AFECTAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
            EXEC spArtAlmABC @Articulo, @Almacen, @FechaEmision, @CfgDiasHabiles, @CfgABCDiasHabiles
            
          IF @Ok IS NULL
	    EXEC xpInvAfectarDetalle @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
      	         	             @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal,
		  		     @Renglon, @RenglonSub, @Articulo, @Cantidad, @Importe, @ImporteNeto, @Impuestos, @ImpuestosNetos, 
                                     @Ok OUTPUT, @OkRef OUTPUT

          SELECT @ImporteRetencion = 0.0, @ImporteRetencion2 = 0.0, @ImporteRetencion3 = 0.0
          IF @Modulo = 'VTAS' AND @Ok IS NULL
          BEGIN --MEJORA4648
--COMENTARIO_0008
            SELECT @ImporteRetencion  = (@ImporteNeto * (@MovRetencion1 / 100.0)),
                   @ImporteRetencion2 = (@ImporteNeto * (@MovRetencion2 / 100.0)),
                   @ImporteRetencion3 = (@ImporteNeto * (@MovRetencion3 / 100.0)) 
            IF @CfgRetencion2BaseImpuesto1 = 1 --VERIFICAR SI ESTO ES CORRECTO EN VENTAS
              SELECT @ImporteRetencion2 = (@Impuesto1Neto * (@MovRetencion2 / 100.0))                                          
            
          END
          IF @MovTipo IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI', 'COMS.D') 
          BEGIN
            SELECT @ImporteRetencion  = (@ImporteNeto * (@MovRetencion1 / 100.0)),
                   @ImporteRetencion2 = (@ImporteNeto * (@MovRetencion2 / 100.0)),
                   @ImporteRetencion3 = (@ImporteNeto * (@MovRetencion3 / 100.0)) 
            IF @CfgRetencion2BaseImpuesto1 = 1 
              SELECT @ImporteRetencion2 = (@Impuesto1Neto * (@MovRetencion2 / 100.0))
          END
--COMENTARIO_0009

          -- Totalizadores van antes de leer el siguiente detalle
          SELECT @SumaPendiente       = @SumaPendiente 	     + ISNULL(@CantidadPendiente, 0.0), 
                 @SumaReservada	      = @SumaReservada	     + ISNULL(@CantidadReservada, 0.0),
                 @SumaOrdenada	      = @SumaOrdenada	     + ISNULL(@CantidadOrdenada, 0.0),
                 @SumaImporte         = @SumaImporte         + @Importe,
                 @SumaImporteNeto     = @SumaImporteNeto     + @ImporteNeto,
                 @ComisionImporteNeto = @ComisionImporteNeto + @ImporteNeto,
                 @SumaImpuestos       = @SumaImpuestos 	     + @Impuestos,
                 @SumaImpuestosNetos  = @SumaImpuestosNetos  + @ImpuestosNetos,
                 @SumaImpuesto1Neto   = @SumaImpuesto1Neto   + @Impuesto1Neto,
                 @SumaImpuesto2Neto   = @SumaImpuesto2Neto   + @Impuesto2Neto,
                 @SumaImpuesto3Neto   = @SumaImpuesto3Neto   + @Impuesto3Neto,
                 @SumaImpuesto5Neto   = @SumaImpuesto5Neto   + @Impuesto5Neto,
                 @SumaCostoLinea      = @SumaCostoLinea      + ROUND(@Costo * @Cantidad, @RedondeoMonetarios),
                 @SumaPrecioLinea     = @SumaPrecioLinea     + ROUND(@Precio * @Cantidad, @RedondeoMonetarios),
                 @SumaDescuentoLinea  = @SumaDescuentoLinea  + @DescuentoLineaImporte,
                 @SumaPeso	      = @SumaPeso            + (@Cantidad * @Peso * @Factor),
                 @SumaVolumen	      = @SumaVolumen         + (@Cantidad * @Volumen * @Factor),
                 @SumaComision	      = @SumaComision        + ISNULL(@ImporteComision, 0.0),
                 @ComisionAcum	      = @ComisionAcum        + ISNULL(@ImporteComision, 0.0)*@ComisionFactor,
                 @SumaRetencion	      = @SumaRetencion	     + ISNULL(@ImporteRetencion, 0.0),
                 @SumaRetencion2      = @SumaRetencion2	     + ISNULL(@ImporteRetencion2, 0.0),
                 @SumaRetencion3      = @SumaRetencion3	     + ISNULL(@ImporteRetencion3, 0.0)
        END -- fetch_status

        IF @Ok IS NOT NULL AND @OkRef IS NULL
        BEGIN
          SELECT @OkRef = 'Articulo: '+@Articulo
          IF @SubCuenta IS NOT NULL SELECT @OkRef = @OkRef+ ' ('+@SubCuenta+')'
        END

		IF @Ok IS NULL AND @SubCuentaExplotarInformacion = 1
		  EXEC spMovOpcion @Modulo, @ID, @Renglon, @RenglonSub, @Subcuenta, @Ok OUTPUT, @OkRef OUTPUT
         
        -- Siguiente Detalle
        IF @Ok IS NULL
        BEGIN
          IF @Modulo = 'VTAS' FETCH NEXT FROM crVentaDetalle  INTO @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @CantidadOriginal, @CantidadObsequio, @CantidadInventario, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @CantidadA, @Factor, @MovUnidad, @Articulo, @Subcuenta, @Costo, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @AplicaMov, @AplicaMovID, @AlmacenRenglon, @AgenteRenglon, @ArtTipo, @ArtSerieLoteInfo, @ArtTipoOpcion, @Peso, @Volumen, @ArtUnidad, @MovRetencion1, @MovRetencion2, @MovRetencion3, @UltReservadoCantidad, @UltReservadoFecha, @ArtComision, @EspacioD, @ArtLotesFijos, @ArtActividades, @ArtCostoIdentificado, @ArtCostoUEPS, @ArtCostoPEPS, @ArtUltimoCosto, @ArtCostoEstandar, @ArtPrecioLista, @PrecioTipoCambio, @Posicion, @Tarima, @ArtDepartamentoDetallista, @ArtEstatus, @ArtSituacion, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @ContUso, @ContUso2, @ContUso3, @Retencion1, @Retencion2, @Retencion3, @AnticipoFacturado  ELSE --ANTICIPOFACTURADO
          IF @Modulo = 'COMS' FETCH NEXT FROM crCompraDetalle INTO @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @CantidadOriginal, @CantidadInventario, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @CantidadA, @Factor, @MovUnidad, @Articulo, @Subcuenta, @Costo, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @AplicaMov, @AplicaMovID, @AlmacenRenglon, @ServicioArticulo, @ServicioSerie, @ArtTipo, @ArtSerieLoteInfo, @ArtTipoOpcion, @Peso, @Volumen, @ArtUnidad, @MovRetencion1, @MovRetencion2, @MovRetencion3, @ArtLotesFijos, @ArtActividades, @ArtCostoIdentificado, @ArtCostoUEPS, @ArtCostoPEPS, @ArtUltimoCosto, @ArtCostoEstandar, @ArtPrecioLista, @Posicion, @Tarima, @ArtDepartamentoDetallista, @ArtEstatus, @ArtSituacion, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @ContUso, @ContUso2, @ContUso3, @ClavePresupuestal, @FechaCaducidad, @Retencion1, @Retencion2, @Retencion3, @PosicionActual, @PosicionReal ELSE
          IF @Modulo = 'INV'  FETCH NEXT FROM crInvDetalle    INTO @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @CantidadOriginal, @CantidadInventario, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @CantidadA, @Factor, @MovUnidad, @Articulo, @Subcuenta, @Costo, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @AplicaMov, @AplicaMovID, @AlmacenRenglon, @ProdSerieLote, @ArtTipo, @ArtSerieLoteInfo, @ArtTipoOpcion, @Peso, @Volumen, @ArtUnidad, @UltReservadoCantidad, @UltReservadoFecha, @DetalleTipo, @Producto, @SubProducto, @ArtLotesFijos, @ArtActividades, @ArtCostoIdentificado, @ArtCostoUEPS, @ArtCostoPEPS, @ArtUltimoCosto, @ArtCostoEstandar, @ArtPrecioLista, @Posicion, @Tarima, @ArtDepartamentoDetallista, @ArtEstatus, @ArtSituacion, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @Seccion, @FechaCaducidad, @PosicionDestino, @PosicionActual, @PosicionReal ELSE
          IF @Modulo = 'PROD' FETCH NEXT FROM crProdDetalle   INTO @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @CantidadOriginal, @CantidadInventario, @CantidadReservada, @CantidadOrdenada, @CantidadPendiente, @CantidadA, @Factor, @MovUnidad, @Articulo, @Subcuenta, @Costo, @Precio, @DescuentoTipo, @DescuentoLinea, @Impuesto1, @Impuesto2, @Impuesto3, @AplicaMov, @AplicaMovID, @AlmacenRenglon, @ProdSerieLote, @ArtTipo, @ArtSerieLoteInfo, @ArtTipoOpcion, @Peso, @Volumen, @ArtUnidad, @UltReservadoCantidad, @UltReservadoFecha, @DetalleTipo, @Merma, @Desperdicio, @Ruta, @Orden, @Centro, @ArtLotesFijos, @ArtActividades, @ArtCostoIdentificado, @ArtCostoUEPS, @ArtCostoPEPS, @ArtUltimoCosto, @ArtCostoEstandar, @ArtPrecioLista, @Posicion, @Tarima, @ArtDepartamentoDetallista, @ArtEstatus, @ArtSituacion, @ArtExcento1, @ArtExcento2, @ArtExcento3, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3
          IF @@ERROR <> 0 SELECT @Ok = 1
        END
      END  -- While

--COMENTARIO_0010
      IF @Modulo = 'VTAS' BEGIN CLOSE crVentaDetalle  DEALLOCATE crVentaDetalle  END ELSE
      IF @Modulo = 'COMS' BEGIN CLOSE crCompraDetalle DEALLOCATE crCompraDetalle END ELSE
      IF @Modulo = 'INV'  BEGIN CLOSE crInvDetalle    DEALLOCATE crInvDetalle    END ELSE
      IF @Modulo = 'PROD' BEGIN CLOSE crProdDetalle   DEALLOCATE crProdDetalle   END 
    END -- AfectarDetalle
    
    IF @MovTipo = 'INV.T' AND @Ok IS NULL AND @CfgCostearTransferencias = 1
      EXEC spInvCostearTransferencias @Modulo, @ID, @MovTipo

--COMENTARIO_0011

    IF @Modulo = 'VTAS' AND @Ok IS NULL
      EXEC xpVentaRetencionTotalCalcular @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @ClienteProv, 
					 @SumaImpuesto1Neto, @SumaImpuesto2Neto, @SumaImpuesto3Neto,
                                         @SumaRetencion OUTPUT, @SumaRetencion2 OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @SumaRetencion3 = @SumaRetencion3 OUTPUT
--COMENTARIO_0012
    
    IF @PPTO = 1 AND @Accion <> 'CANCELAR' AND (@Modulo = 'COMS' OR (@Modulo = 'VTAS' AND @PPTOVentas = 1))
      EXEC spModuloAgregarMovPresupuesto @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT

    IF (@AfectarMatando = 1 AND @Utilizar = 0 AND @MatarAntes = 0 AND @Ok IS NULL) OR (@MovTipo = 'INV.TMA' AND @Accion <> 'CANCELAR' AND @Ok IS NULL) --REQ12615 WMS
      EXEC spInvMatar @Sucursal, @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
	 	      @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Ejercicio, @Periodo, @AfectarConsignacion, @AlmacenTipo, @AlmacenDestinoTipo, 
		      @CfgVentaSurtirDemas, @CfgCompraRecibirDemas, @CfgTransferirDemas, @CfgBackOrders, @CfgContX, @CfgContXGenerar, @CfgEmbarcar, @CfgImpInc, @CfgMultiUnidades, @CfgMultiUnidadesNivel,
                      @Ok OUTPUT, @OkRef OUTPUT, 
		      @CfgPrecioMoneda = @CfgPrecioMoneda

    -- 6777
    IF @Accion IN('AFECTAR', 'CANCELAR', 'RESERVARPARCIAL', 'RESERVAR') AND @OrigenMovTipo IN('VTAS.C', 'VTAS.CS', 'COMS.C')     
    BEGIN
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @IDOrigen, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
    END
    
    IF @Ok IS NULL
    BEGIN
      -- Calculos con Totalizadores
      SELECT @ImporteTotal = @SumaImporteNeto + @SumaImpuestosNetos 

      IF @Modulo = 'VTAS' 
      BEGIN
        --SELECT @ImporteTotal = ROUND(@ImporteTotal, @CfgVentaRedondeoDecimales)
        SELECT @SumaImporteNeto = @SumaImporteNeto - (@SumaImporteNeto + @SumaImpuestosNetos - @ImporteTotal)
      END

      IF @AnticiposFacturados > 0.0 
      BEGIN      
        SELECT @AnticipoImporte    = @SumaImporteNeto * @AnticiposFacturados / @ImporteTotal
        SELECT @AnticipoImpuestos  = @AnticiposFacturados - @AnticipoImporte
      END ELSE
        SELECT @AnticipoImporte = 0.0, @AnticipoImpuestos = 0.0

      SELECT @ImporteCx      = @SumaImporteNeto    - @AnticipoImporte,
             @ImpuestosCx    = @SumaImpuestosNetos - @AnticipoImpuestos,
	         @RetencionCx    = @SumaRetencion,
	         @Retencion2Cx   = @SumaRetencion2,
	         @Retencion3Cx   = @SumaRetencion3,
             @ImporteTotalCx = @ImporteTotal       - @AnticiposFacturados
      SELECT @SumaRetenciones = ISNULL(@SumaRetencion, 0.0) + ISNULL(@SumaRetencion2, 0.0) + ISNULL(@SumaRetencion3, 0.0)
      
      --SELECT @FactorMovImpto = @ImporteTotalCx / @ImporteTotal

      IF @ImporteTotal > 0
        SELECT @FactorMovImpto = @ImporteTotalCx / @ImporteTotal 
      ELSE
        SELECT @FactorMovImpto = 0

      IF @SubClave = 'COMS.CE/GT'
      BEGIN 
        DECLARE
          @GTImpuesto1Mov	varchar(20),
          @GTImpuesto1Acreedor	varchar(10)
        SELECT @GTImpuesto1Mov      = NULLIF(RTRIM(Impuesto1Mov), ''),
               @GTImpuesto1Acreedor = NULLIF(RTRIM(Impuesto1Acreedor), '')
         FROM EmpresaCfgGT
        WHERE Empresa = @Empresa
          
        IF @GTImpuesto1Mov IS NULL OR @GTImpuesto1Acreedor IS NULL
          SELECT @Ok = 20500, @OkRef = 'EmpresaCfgGT'
        EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                         @FechaEmision, @CfgRetencionConcepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
  	  	         @FechaRegistro, @Ejercicio, @Periodo,
		         NULL, NULL, @GTImpuesto1Acreedor, NULL, NULL, NULL, NULL, NULL,
                         @ImpuestosCx, NULL, NULL, NULL, 
                         NULL, NULL, NULL, NULL, NULL, @GTImpuesto1Mov,
		         @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                         @Ok OUTPUT, @OkRef OUTPUT
        SELECT @ImporteCx = @ImporteCx - ISNULL(@RetencionCx, 0.0)
        SELECT @RetencionCx = NULL, @ImpuestosCx = NULL
      END

      IF @MovImpuesto = 1
      BEGIN
       --IF (SELECT dbo.fnEsPitex(Cliente) FROM Venta WHERE ID = @ID) = 1 --ANTICIPOFACTURADO
         --UPDATE #MovImpuesto SET Retencion1 = Impuesto1 --ANTICIPOFACTURADO    

        DELETE MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID
        INSERT MovImpuesto (
               Modulo,  ModuloID,  OrigenModulo,                 OrigenModuloID,             OrigenConcepto,                   OrigenFecha,                              Retencion1, Retencion2, Retencion3, Impuesto1, Impuesto2, Impuesto3, Excento1, Excento2, Excento3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, LoteFijo, Importe1,                      Importe2,			             Importe3,			            SubTotal,                      ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal, ImporteBruto)  --MEJORA1002
        SELECT @Modulo, @ID,       ISNULL(OrigenModulo,@Modulo), ISNULL(OrigenModuloID,@ID), ISNULL(OrigenConcepto,@Concepto), ISNULL(OrigenFecha,@FechaEmision),        Retencion1, Retencion2, Retencion3, Impuesto1, Impuesto2, Impuesto3, Excento1, Excento2, Excento3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, LoteFijo, SUM(Importe1*@FactorMovImpto), SUM(Importe2*@FactorMovImpto), SUM(Importe3*@FactorMovImpto), SUM(SubTotal*@FactorMovImpto), ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal, SUM(ImporteBruto*@FactorMovImpto)  --MEJORA1002
          FROM #MovImpuesto
         GROUP BY Retencion1, Retencion2, Retencion3, Impuesto1, Impuesto2, Impuesto3, Excento1, Excento2, Excento3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, LoteFijo, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal, ISNULL(OrigenModulo,@Modulo), ISNULL(OrigenModuloID,@ID), ISNULL(OrigenConcepto,@Concepto), ISNULL(OrigenFecha,@FechaEmision) --MEJORA1002
         ORDER BY Retencion1, Retencion2, Retencion3, Impuesto1, Impuesto2, Impuesto3, Excento1, Excento2, Excento3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, LoteFijo, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal, ISNULL(OrigenModulo,@Modulo), ISNULL(OrigenModuloID,@ID), ISNULL(OrigenConcepto,@Concepto), ISNULL(OrigenFecha,@FechaEmision) --MEJORA1002
      END

      IF @Utilizar = 1 AND @ImporteTotal > 0.0 AND @UtilizarMovTipo IN ('VTAS.P','VTAS.R','VTAS.S','VTAS.VC','VTAS.VCR', 'COMS.O', 'COMS.OP', 'COMS.CC')
      BEGIN
	-- Restar al Saldo del Movimiento
	IF @Modulo = 'VTAS' UPDATE Venta  SET Saldo = Saldo - @ImporteTotal /*@ImporteCx*/      WHERE ID = @UtilizarID ELSE
	IF @Modulo = 'COMS' UPDATE Compra SET Saldo = Saldo - @ImporteTotal /*@SumaImporteNeto*/ WHERE ID = @UtilizarID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END

      -- Actualizar Importes Totales
      IF (@Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND @AfectarDetalle = 1) OR (@MovTipo IN ('COMS.D', 'COMS.B', 'COMS.CA', 'COMS.GX'))
      BEGIN
        SELECT @Paquetes = NULL
        IF @Modulo = 'VTAS' AND @MovTipo NOT IN ('VTAS.PR', 'VTAS.EST', 'VTAS.C', 'VTAS.CS', 'VTAS.P', 'VTAS.S', 'VTAS.SD') 
        BEGIN
          SELECT @Paquetes = ISNULL(COUNT(DISTINCT Paquete), 0) FROM VentaD WHERE ID = @ID 
          SELECT @Paquetes = @Paquetes + ISNULL(ROUND(SUM(Cantidad), 0), 0) FROM VentaD WHERE ID = @ID AND NULLIF(Paquete, 0) IS NULL
		  AND RenglonTipo <> CASE @EmbarqueSumaArtJuego WHEN 'Articulo Juego' THEN 'C' WHEN 'Componentes' THEN 'J'	ELSE 'J' END
        END ELSE
        IF @Modulo = 'INV'  AND @MovTipo NOT IN ('INV.SOL', 'INV.OT', 'INV.OT', 'INV.IF') 
        BEGIN
          SELECT @Paquetes = ISNULL(COUNT(DISTINCT Paquete) ,0) FROM InvD WHERE ID = @ID 
          SELECT @Paquetes = @Paquetes + ISNULL(ROUND(SUM(Cantidad), 0), 0) FROM InvD WHERE ID = @ID AND NULLIF(Paquete, 0) IS NULL
		  AND RenglonTipo <> CASE @EmbarqueSumaArtJuego WHEN 'Articulo Juego' THEN 'C' WHEN 'Componentes' THEN 'J'	ELSE 'J' END
        END ELSE
        IF @Modulo = 'COMS'  AND @MovTipo NOT IN ('COMS.R', 'COMS.C', 'COMS.O', 'COMS.OP', 'COMS.OG', 'COMS.OD', 'COMS.OI') 
        BEGIN
          SELECT @Paquetes = ISNULL(COUNT(DISTINCT Paquete) ,0) FROM InvD WHERE ID = @ID 
          SELECT @Paquetes = @Paquetes + ISNULL(ROUND(SUM(Cantidad), 0), 0) FROM CompraD WHERE ID = @ID AND NULLIF(Paquete, 0) IS NULL
		  AND RenglonTipo <> CASE @EmbarqueSumaArtJuego WHEN 'Articulo Juego' THEN 'C' WHEN 'Componentes' THEN 'J'	ELSE 'J' END
        END
        SELECT @IVAFiscal = CONVERT(float, @SumaImpuesto1Neto) / NULLIF(@ImporteTotal-@SumaRetenciones, 0),
               @IEPSFiscal = CONVERT(float, @SumaImpuesto2Neto) / NULLIF(@ImporteTotal-@SumaRetenciones, 0)

        IF @Modulo = 'VTAS' UPDATE Venta  SET Peso = @SumaPeso, Volumen = @SumaVolumen, Paquetes = @Paquetes, Importe = @SumaImporte, Impuestos = @SumaImpuestosNetos, IVAFiscal = @IVAFiscal, IEPSFiscal = @IEPSFiscal, Saldo = CASE WHEN @EstatusNuevo IN ('PENDIENTE', 'PROCESAR') THEN @ImporteTotal /*@ImporteCx*/ ELSE NULL END, DescuentoLineal = @SumaDescuentoLinea, ComisionTotal = @SumaComision, PrecioTotal = @SumaPrecioLinea, CostoTotal = @SumaCostoLinea, Retencion = NULLIF(@SumaRetenciones, 0.0) WHERE ID = @ID ELSE
        --BUG9637
        IF @Modulo = 'COMS' UPDATE Compra SET Peso = @SumaPeso, Volumen = @SumaVolumen, Paquetes = @Paquetes, Importe = @SumaImporte, Impuestos = @SumaImpuestosNetos, IVAFiscal = @IVAFiscal, IEPSFiscal = @IEPSFiscal, Saldo = CASE WHEN @EstatusNuevo IN ('PENDIENTE', 'PROCESAR') THEN @ImporteTotal /*@SumaImporteNeto*/ ELSE NULL END, DescuentoLineal = @SumaDescuentoLinea, Retencion = NULLIF(@SumaRetenciones, 0.0) WHERE ID = @ID ELSE
        IF @Modulo = 'INV'  UPDATE Inv    SET Peso = @SumaPeso, Volumen = @SumaVolumen, Paquetes = @Paquetes, Importe = @SumaCostoLinea WHERE ID = @ID ELSE
        IF @Modulo = 'PROD' UPDATE Prod   SET Peso = @SumaPeso, Volumen = @SumaVolumen, Paquetes = @Paquetes, Importe = @SumaCostoLinea WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END ELSE
        EXEC spInvReCalcEncabezado @ID, @Modulo, @CfgImpInc, @CfgMultiUnidades, @DescuentoGlobal, @SobrePrecio,
				   @CfgPrecioMoneda = @CfgPrecioMoneda

      /*IF @MovTipo = 'COMS.R' AND @Accion = 'AFECTAR' UPDATE Compra SET Proveedor = NULL WHERE ID = @ID*/

      IF @MovTipo = 'INV.IF' AND @EstatusNuevo = 'CONCLUIDO' 
        -- Generar Ajuste del Inventario Fisico
        EXEC spInvInventarioFisico @Sucursal, @ID, @Empresa, @Almacen, @IDGenerar, @Base, @CfgSeriesLotesMayoreo, @Estatus, @Ok OUTPUT, @OkRef OUTPUT

      -- En servicios cotizados, pegarle a la cotizacion
      IF @MovTipo = 'VTAS.S' AND @Estatus = 'CONFIRMAR' AND @EstatusNuevo IN ('PENDIENTE', 'CANCELADO')
      BEGIN
        SELECT @CotizacionID = ID FROM Venta WHERE Empresa = @Empresa AND OrigenTipo = 'VTAS' AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
        SELECT @CotizacionEstatusNuevo = CASE WHEN @Accion = 'CANCELAR' THEN 'CANCELADO' ELSE 'CONCLUIDO' END
        EXEC spValidarTareas @Empresa, @Modulo, @CotizacionID, @CotizacionEstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Venta SET Estatus = @CotizacionEstatusNuevo WHERE ID = @CotizacionID
      END
      IF @@ERROR <> 0 SELECT @Ok = 1

      IF @Estatus IN ('SINAFECTAR','AUTORIZARE','CONFIRMAR','BORRADOR') OR @Accion = 'CANCELAR'
      BEGIN
        -- Calcular Fecha Vencimiento
        IF @Accion <> 'CANCELAR' 
        BEGIN
          IF @MovTipo = 'VTAS.FR' 
            SELECT @Vencimiento = ISNULL(CASE WHEN ConVigencia = 1 THEN VigenciaDesde END, @FechaEmision) FROM Venta WHERE ID = @ID
          ELSE
            EXEC spCalcularVencimiento @Modulo, @Empresa, @ClienteProv, @Condicion, @FechaEmision, @Vencimiento OUTPUT, @Dias OUTPUT, @Ok OUTPUT 

          EXEC spExtraerFecha @Vencimiento OUTPUT
        END

        IF @MovTipo IN ('VTAS.P', 'VTAS.S', 'COMS.O') AND NULLIF(RTRIM(@Condicion), '') IS NOT NULL AND @EstatusNuevo <> 'CONFIRMAR' 
          IF (SELECT UPPER(ControlAnticipos) FROM Condicion WHERE Condicion = @Condicion) IN ('ABIERTO', 'PLAZOS', 'FECHA REQUERIDA')
            EXEC spGenerarAP @Sucursal, @Accion, @Empresa, @Modulo, @ID, @MovTipo, @FechaRegistro,
            		     @Mov, @MovID, @MovMoneda, @MovTipoCambio, @Proyecto, @ClienteProv, @Referencia, @Condicion, @Vencimiento, @ImporteTotal,
  	 	             @Ok OUTPUT, @OkRef OUTPUT

        IF @MovTipo = 'VTAS.NO'
        BEGIN
          SELECT @EsCargo = 1
          IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo
          EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'CNO', @MovMoneda, @MovTipoCambio, @ClienteProv, NULL, NULL, NULL,
                       @Modulo, @ID, @Mov, @MovID, @EsCargo, @ImporteTotal, NULL, NULL,
                       @FechaAfectacion, @Ejercicio, @Periodo, 'Consumos', NULL, 0, 0, 0,
 	  	       @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID
        END
      END

      IF (@Generar = 1 AND @GenerarAfectado = 1) OR (@Accion = 'CANCELAR' AND @Base <> 'TODO')
      BEGIN  
        IF @Modulo = 'VTAS' SELECT @SumaPendiente = Sum(ROUND(ISNULL(CantidadPendiente, 0.0), 4)), @SumaReservada = Sum(ROUND(ISNULL(CantidadReservada, 0.0), 2)), @SumaOrdenada = Sum(ROUND(ISNULL(CantidadOrdenada, 0.0), 2)) FROM VentaD WHERE ID = @ID ELSE
        IF @Modulo = 'COMS' SELECT @SumaPendiente = Sum(ROUND(ISNULL(CantidadPendiente, 0.0), 4)) FROM CompraD WHERE ID = @ID ELSE
        IF @Modulo = 'INV'  SELECT @SumaPendiente = Sum(ROUND(ISNULL(CantidadPendiente, 0.0), 4)), @SumaReservada = Sum(ROUND(ISNULL(CantidadReservada, 0.0), 2)), @SumaOrdenada = Sum(ROUND(ISNULL(CantidadOrdenada, 0.0), 2)) FROM InvD   WHERE ID = @ID ELSE
        IF @Modulo = 'PROD' SELECT @SumaPendiente = Sum(ROUND(ISNULL(CantidadPendiente, 0.0), 4)), @SumaReservada = Sum(ROUND(ISNULL(CantidadReservada, 0.0), 2)), @SumaOrdenada = Sum(ROUND(ISNULL(CantidadOrdenada, 0.0), 2)) FROM ProdD  WHERE ID = @ID
      END

      -- Actualizar el Estatus
      IF @MovTipo NOT IN ('INV.IF', 'PROD.A', 'PROD.R', 'PROD.E')
      BEGIN
        SELECT @TienePendientes = 0
        IF @Modulo = 'VTAS' AND EXISTS(SELECT * FROM VentaD  WHERE ID = @ID AND ((ISNULL(CantidadPendiente, 0.0) <> 0.0) OR (ISNULL(CantidadReservada, 0.0) <> 0.0) OR (ISNULL(CantidadOrdenada, 0.0) <> 0.0))) SELECT @TienePendientes = 1 ELSE
        IF @Modulo = 'INV'  AND EXISTS(SELECT * FROM InvD    WHERE ID = @ID AND ((ISNULL(CantidadPendiente, 0.0) <> 0.0) OR (ISNULL(CantidadReservada, 0.0) <> 0.0) OR (ISNULL(CantidadOrdenada, 0.0) <> 0.0))) SELECT @TienePendientes = 1 ELSE
        IF @Modulo = 'PROD' AND EXISTS(SELECT * FROM ProdD   WHERE ID = @ID AND ((ISNULL(CantidadPendiente, 0.0) <> 0.0) OR (ISNULL(CantidadReservada, 0.0) <> 0.0) OR (ISNULL(CantidadOrdenada, 0.0) <> 0.0))) SELECT @TienePendientes = 1 ELSE
        IF @Modulo = 'COMS' AND EXISTS(SELECT * FROM CompraD WHERE ID = @ID AND ISNULL(CantidadPendiente, 0.0) <> 0.0) SELECT @TienePendientes = 1 

        IF @EstatusNuevo <> 'PENDIENTE' AND @TienePendientes = 1 SELECT @EstatusNuevo = 'PENDIENTE'
        IF @EstatusNuevo = 'PENDIENTE'  AND @TienePendientes = 0 SELECT @EstatusNuevo = 'CONCLUIDO'
        --- Bug 25409: Se agrega la línea siguiente.
        IF @EstatusNuevo = 'PENDIENTE'  AND @OrigenTipo = 'POS' AND @MovTipo = 'VTAS.C' SELECT @EstatusNuevo = 'CONFIRMAR'
      END
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion = @FechaEmision ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion = NULL
      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL

      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
      BEGIN
        IF @Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @EstatusNuevo = 'CANCELADO' 
        BEGIN
           IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
           IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND @Estatus = 'PENDIENTE' AND @CfgContXFacturasPendientes = 0
             SELECT @GenerarPoliza = 0
        END ELSE BEGIN           
          IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND @CfgContXFacturasPendientes = 0
          BEGIN 
            IF @EstatusNuevo = 'CONCLUIDO' SELECT @GenerarPoliza = 1 
          END ELSE
  	    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 
        END
      END  

      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
      IF @Modulo = 'VTAS' UPDATE Venta  SET Vencimiento = @Vencimiento,  Concepto = @Concepto, FechaConclusion = @FechaConclusion, FechaCancelacion = @FechaCancelacion, UltimoCambio = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/, Estatus = @EstatusNuevo, Saldo = CASE WHEN @EstatusNuevo IN ('CONCLUIDO', 'CANCELADO') THEN NULL ELSE Saldo END, Situacion = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END, GenerarPoliza = @GenerarPoliza, Autorizacion = @Autorizacion, Mensaje = NULL WHERE ID = @ID ELSE
      IF @Modulo = 'COMS' UPDATE Compra SET Vencimiento = @Vencimiento,  Concepto = @Concepto, FechaConclusion = @FechaConclusion, FechaCancelacion = @FechaCancelacion, UltimoCambio = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/, Estatus = @EstatusNuevo, Saldo = CASE WHEN @EstatusNuevo IN ('CONCLUIDO', 'CANCELADO') THEN NULL ELSE Saldo END, Situacion = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END, GenerarPoliza = @GenerarPoliza, Autorizacion = @Autorizacion, Mensaje = NULL  WHERE ID = @ID ELSE
      IF @Modulo = 'INV'  UPDATE Inv    SET Vencimiento = @Vencimiento,  Concepto = @Concepto, FechaConclusion = @FechaConclusion, FechaCancelacion = @FechaCancelacion, UltimoCambio = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/, Estatus = @EstatusNuevo, Situacion = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END, GenerarPoliza = @GenerarPoliza, Autorizacion = @Autorizacion WHERE ID = @ID ELSE	  
      IF @Modulo = 'PROD' UPDATE Prod   SET/*Vencimiento=@Vencimiento,*/ Concepto = @Concepto, FechaConclusion = @FechaConclusion, FechaCancelacion = @FechaCancelacion, UltimoCambio = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/, Estatus = @EstatusNuevo, Situacion = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END, GenerarPoliza = @GenerarPoliza, Autorizacion = @Autorizacion WHERE ID = @ID
      IF @@ERROR <> 0 SELECT @Ok = 1

	  --TASK25114
--Cambio WMS
      IF @MovTipo = 'INV.TMA' AND @WMS = 1 AND @EstatusNuevo = 'CANCELADO'
      BEGIN
        --BUG24067
        UPDATE Tarima 
           SET Tarima.Estatus = 'BAJA', Tarima.Baja = @FechaCancelacion
          FROM InvD
          JOIN Tarima ON Tarima.Tarima = InvD.Tarima AND Tarima.Almacen = InvD.Almacen
          JOIN AlmPos ON Tarima.Posicion = AlmPos.Posicion AND AlmPos.Almacen = InvD.Almacen
         WHERE InvD.ID = @ID 
           AND ISNULL(InvD.Seccion,0) = 1 
           AND AlmPos.Tipo <> 'Domicilio'
      END  
--Cambio WMS

      EXEC spEmbarqueMov @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Estatus, @EstatusNuevo, @CfgEmbarcar, @Ok OUTPUT

      IF @Accion = 'CANCELAR' 
      BEGIN
        IF @EstatusNuevo = 'PENDIENTE'
        BEGIN
          --BUG15329
          IF @Base <> 'SELECCION'
  	        IF @Modulo = 'VTAS' UPDATE Venta  SET Saldo = Saldo - @ImporteTotal /*@ImporteCx*/      WHERE ID = @ID ELSE
	        IF @Modulo = 'COMS' UPDATE Compra SET Saldo = Saldo - @ImporteTotal /*@SumaImporteNeto*/ WHERE ID = @ID 
        END ELSE
        BEGIN
    	  IF @Modulo = 'VTAS' UPDATE Venta  SET Saldo = NULL WHERE ID = @ID ELSE
  	      IF @Modulo = 'COMS' UPDATE Compra SET Saldo = NULL WHERE ID = @ID 
        END
        IF @@ERROR <> 0 SELECT @Ok = 1
      END

      -- Si fue una Venta/Dev a Consignacion Guardar en Almacen Consignacion del Cliente en el Movimiento
      IF @MovTipo IN ('VTAS.VC','VTAS.VCR','VTAS.DC','VTAS.DCR') AND @Accion <> 'CANCELAR'
      BEGIN
	UPDATE Venta SET AlmacenDestino = CASE WHEN @MovTipo IN ('VTAS.VC','VTAS.VCR') THEN @GenerarAlmacenDestino ELSE @GenerarAlmacen END WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END

      IF @Utilizar = 1 AND @Ok IS NULL
        EXEC spInvAfectarUtilizarConcluido @Empresa, @Modulo, @FechaEmision, @UtilizarID, @AfectarMatando, @UtilizarEstatus, @SumaPendiente, @FechaConclusion, @Ok OUTPUT, @OkRef OUTPUT 

      IF @Generar = 1 AND @Ok IS NULL
      BEGIN
        IF @GenerarAfectado = 1 SELECT @GenerarEstatus = 'CONCLUIDO' ELSE SELECT @GenerarEstatus = 'SINAFECTAR'
        IF @GenerarEstatus = 'CONCLUIDO' SELECT @FechaConclusion = @FechaEmision ELSE IF @GenerarEstatus <> 'CANCELADO' SELECT @FechaConclusion = NULL
        IF @UtilizarEstatus = 'CONCLUIDO' AND @CfgContX = 1 AND @CfgContXGenerar <> 'NO' SELECT @GenerarPolizaTemp = 1 ELSE SELECT @GenerarPolizaTemp = 0

        EXEC spValidarTareas @Empresa, @Modulo, @IDGenerar, @GenerarEstatus, @Ok OUTPUT, @OkRef OUTPUT
        IF @Modulo = 'VTAS' UPDATE Venta  SET FechaConclusion = @FechaConclusion, Estatus = @GenerarEstatus, GenerarPoliza = @GenerarPolizaTemp WHERE ID = @IDGenerar ELSE
        IF @Modulo = 'COMS' UPDATE Compra SET FechaConclusion = @FechaConclusion, Estatus = @GenerarEstatus, GenerarPoliza = @GenerarPolizaTemp WHERE ID = @IDGenerar ELSE
        IF @Modulo = 'INV'  UPDATE Inv    SET FechaConclusion = @FechaConclusion, Estatus = @GenerarEstatus, GenerarPoliza = @GenerarPolizaTemp WHERE ID = @IDGenerar ELSE
        IF @Modulo = 'PROD' UPDATE Prod   SET FechaConclusion = @FechaConclusion, Estatus = @GenerarEstatus, GenerarPoliza = @GenerarPolizaTemp WHERE ID = @IDGenerar
        IF @@ERROR <> 0 SELECT @Ok = 1

        EXEC xpInvGenerarFinal @Empresa, @Usuario, @Accion, @Modulo, @ID, @IDGenerar, @GenerarEstatus, @Ok OUTPUT, @OkRef OUTPUT
      END

      IF @MovTipo = 'VTAS.S' AND NULLIF(RTRIM(@ServicioSerie), '') IS NOT NULL
      BEGIN
        EXEC spSerieLoteFlujo @Sucursal, @SucursalAlmacen, @SucursalAlmacenDestino, @Accion, @Empresa, @Modulo, @ID, @ServicioArticulo, NULL, @ServicioSerie, @Almacen, 0
        --UPDATE VIN SET FechaUltimoServicio = @FechaEmision WHERE VIN = @ServicioSerie
      END

      -- Afectar en Otros Modulos
      SELECT @Continuar = 1, @CxID = NULL, @CxMovTipo = NULL
      IF (@FacturarVtasMostrador = 1 AND @Accion <> 'CANCELAR') OR (@Accion ='CANCELAR' AND @MovTipo IN ('VTAS.F','VTAS.FAR','VTAS.FB','VTAS.D') AND @OrigenTipo = 'VMOS')
      BEGIN
        SELECT @Continuar = 0
        EXEC spInvReCalcEncabezado @ID, @Modulo, @CfgImpInc, @CfgMultiUnidades, @DescuentoGlobal, @SobrePrecio, @CfgPrecioMoneda = @CfgPrecioMoneda
	IF @MovTipo IN ('VTAS.F','VTAS.FAR','VTAS.FB','VTAS.D') OR (@MovTipo IN('VTAS.FM') AND  @GenerarNCAlProcesar = 1)
        BEGIN
          EXEC spInvMatarNotas @Sucursal, @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @FechaAfectacion, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT, @AfectandoNotasSinCobro OUTPUT, @MovTipo
          SELECT @Continuar = @AfectandoNotasSinCobro
        END
      END

      -- ETO Tarjetas 9-Feb-2007 Recarga Tarjetas
      IF @MovTipo = 'VTAS.FB' AND @Accion in ('AFECTAR', 'CANCELAR')
      BEGIN
        EXEC spMovTipoInstruccionBit @Modulo, @Mov, 'IncrementaSaldoTarjeta', @IncrementaSaldoTarjeta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        IF @IncrementaSaldoTarjeta = 1
          EXEC spIncrementaSaldoTarjeta @Empresa, @ID, @Mov, @MovID, @Modulo, @Ejercicio, @Periodo, @Accion, @FechaEmision, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT
      END

      IF @Continuar = 1 AND (@Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') OR @EstatusNuevo = 'CANCELADO') AND @Ok IS NULL
      BEGIN
	-- Bonificacion Automatica
        IF @Accion = 'CANCELAR'
        BEGIN
          IF @CfgCompraAutoCargos = 1 AND @MovTipo IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI', 'COMS.D', 'COMS.B') AND @Ok IS NULL
	    EXEC xpCompraAutoCargos @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @ID, @Mov,
			            @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision , @Concepto, @Proyecto,
				    @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @FechaRegistro, @Ejercicio, @Periodo,
				    @Condicion, @Vencimiento, @ClienteProv, @SumaImporteNeto, @SumaImpuestosNetos, @VIN, @Ok OUTPUT, @OkRef OUTPUT
          IF @CfgVentaAutoBonif = 1 AND @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.D', 'VTAS.DF', 'VTAS.B') AND @Ok IS NULL
	    EXEC xpVentaAutoBonif @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @ID, @Mov,
			          @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision , @Concepto, @Proyecto,
				  @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @FechaRegistro, @Ejercicio, @Periodo,
				  @Condicion, @Vencimiento, @ClienteProv, @CobroIntegrado, @SumaImporteNeto, @SumaImpuestosNetos, @VIN, @Ok OUTPUT, @OkRef OUTPUT, @Agente -- BUG 16650

--REQ 15448
          IF @MovTipo IN ('VTAS.F','VTAS.FAR','VTAS.N') AND (SELECT CxcAutoAplicarAnticiposPedidos FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1
          BEGIN
            SELECT @ReferenciaAplicacionAnticipo = RTRIM(@Origen) + ' ' + RTRIM(@OrigenID)
	    EXEC xpVentaAutoAplicarAnticiposPedidos @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @ID, @Mov,
   			          		    @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision , @Concepto, @Proyecto,
				  		    @Usuario, @Autorizacion, @ReferenciaAplicacionAnticipo, @DocFuente, @Observaciones, @FechaRegistro, @Ejercicio, @Periodo,
				  		    @Condicion, @Vencimiento, @ClienteProv, @CobroIntegrado, @SumaImporteNeto, @SumaImpuestosNetos, @VIN, @Ok OUTPUT, @OkRef OUTPUT
          END
        END

        IF @Modulo = 'VTAS' AND @CobroIntegrado = 0 
          EXEC spBorrarVentaCobro @ID
      
        IF @CobroIntegrado = 1 
        BEGIN
--REQ 13393 POS
          IF @OrigenTipo = 'POS'
          BEGIN

            SELECT @DineroImporte = 0.0, @CobroDesglosado = 0.0, @CobroDelEfectivo = 0.0, @CobroCambio = 0.0, @ValesCobrados = 0.0, @CobroRedondeo = 0.0, @TarjetasCobradas = 0.0 	-- ETO Tarjetas 9-Feb-2007
            SELECT @Importe1 = ISNULL(Importe1, 0.0), @Importe2 = ISNULL(Importe2, 0.0), @Importe3 = ISNULL(Importe3, 0.0), @Importe4 = ISNULL(Importe4, 0.0), @Importe5 = ISNULL(Importe5, 0.0),
          	 @FormaCobro1 = RTRIM(FormaCobro1), @FormaCobro2 = RTRIM(FormaCobro2), @FormaCobro3 = RTRIM(FormaCobro3), @FormaCobro4 = RTRIM(FormaCobro4), @FormaCobro5 = RTRIM(FormaCobro5), 
                   @Referencia1 = RTRIM(Referencia1), @Referencia2 = RTRIM(Referencia2), @Referencia3 = RTRIM(Referencia3), @Referencia4 = RTRIM(Referencia4), @Referencia5 = RTRIM(Referencia5), 
                   @CobroDelEfectivo = ISNULL(DelEfectivo, 0.0), @CtaDinero = NULLIF(RTRIM(CtaDinero), ''), @Cajero = NULLIF(RTRIM(Cajero), ''),
                   @CobroRedondeo = ISNULL(Redondeo, 0.0), @TipoCambio1 = POSTipoCambio1, @TipoCambio2 = POSTipoCambio2, @TipoCambio3 = POSTipoCambio3, @TipoCambio4 = POSTipoCambio4, @TipoCambio5 = POSTipoCambio5
              FROM VentaCobro
             WHERE ID = @ID
        
            EXEC spVentaCobroTotalPOS @Empresa, @FormaCobro1, @FormaCobro2, @FormaCobro3, @FormaCobro4, @FormaCobro5,
    	    	                 @Importe1, @Importe2, @Importe3, @Importe4, @Importe5, @CobroDesglosado OUTPUT, @Moneda = @MovMoneda, @TipoCambio1 = @TipoCambio1, @TipoCambio2 = @TipoCambio2, @TipoCambio3 = @TipoCambio3, @TipoCambio4 = @TipoCambio4, @TipoCambio5 = @TipoCambio5
          END  
          ELSE
          BEGIN      
          SELECT @DineroImporte = 0.0, @CobroDesglosado = 0.0, @CobroDelEfectivo = 0.0, @CobroCambio = 0.0, @ValesCobrados = 0.0, @CobroRedondeo = 0.0, @TarjetasCobradas = 0.0 	-- ETO Tarjetas 9-Feb-2007
          SELECT @Importe1 = ISNULL(Importe1, 0.0), @Importe2 = ISNULL(Importe2, 0.0), @Importe3 = ISNULL(Importe3, 0.0), @Importe4 = ISNULL(Importe4, 0.0), @Importe5 = ISNULL(Importe5, 0.0),
         	 @FormaCobro1 = RTRIM(FormaCobro1), @FormaCobro2 = RTRIM(FormaCobro2), @FormaCobro3 = RTRIM(FormaCobro3), @FormaCobro4 = RTRIM(FormaCobro4), @FormaCobro5 = RTRIM(FormaCobro5), 
                 @Referencia1 = RTRIM(Referencia1), @Referencia2 = RTRIM(Referencia2), @Referencia3 = RTRIM(Referencia3), @Referencia4 = RTRIM(Referencia4), @Referencia5 = RTRIM(Referencia5), 
                 @CobroDelEfectivo = ISNULL(DelEfectivo, 0.0), @CtaDinero = NULLIF(RTRIM(CtaDinero), ''), @Cajero = NULLIF(RTRIM(Cajero), ''),
                 @CobroRedondeo = ISNULL(Redondeo, 0.0), @FormaCobroCambio = RTRIM(FormaCobroCambio), --MEJORA5512
                 @TCDelEfectivo = ISNULL(TCDelEfectivo, 0), @TCProcesado1 = ISNULL(TCProcesado1, 0), @TCProcesado2 = ISNULL(TCProcesado2, 0), @TCProcesado3 = ISNULL(TCProcesado3, 0), @TCProcesado4 = ISNULL(TCProcesado4, 0), @TCProcesado5 = ISNULL(TCProcesado5, 0) --REQ13163
            FROM VentaCobro
           WHERE ID = @ID

          EXEC spVentaCobroTotal @FormaCobro1, @FormaCobro2, @FormaCobro3, @FormaCobro4, @FormaCobro5,
    	  	                 @Importe1, @Importe2, @Importe3, @Importe4, @Importe5, @CobroDesglosado OUTPUT, @Moneda = @MovMoneda, @TipoCambio = @MovTipoCambio

    	  END
          SELECT @FormaCobroVales = CxcFormaCobroVales, @FormaCobroTarjetas = CxcFormaCobroTarjetas FROM EmpresaCfg WHERE Empresa = @Empresa
          SELECT @LDITarjeta = ISNULL(LDI,0) FROM FormaPago WHERE FormaPago = @FormaCobroTarjetas
          IF @FormaCobro1 = @FormaCobroVales SELECT @ValesCobrados = @ValesCobrados + @Importe1
          IF @FormaCobro2 = @FormaCobroVales SELECT @ValesCobrados = @ValesCobrados + @Importe2
          IF @FormaCobro3 = @FormaCobroVales SELECT @ValesCobrados = @ValesCobrados + @Importe3
          IF @FormaCobro4 = @FormaCobroVales SELECT @ValesCobrados = @ValesCobrados + @Importe4
          IF @FormaCobro5 = @FormaCobroVales SELECT @ValesCobrados = @ValesCobrados + @Importe5
          -- ETO Tarjetas 9-Feb-2007
          --BUG15665
          IF @FormaCobro1 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe1, @ReferenciaTarjetas = @Referencia1
          IF @FormaCobro2 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe2, @ReferenciaTarjetas = @Referencia2
          IF @FormaCobro3 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe3, @ReferenciaTarjetas = @Referencia3
          IF @FormaCobro4 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe4, @ReferenciaTarjetas = @Referencia4
          IF @FormaCobro5 = @FormaCobroTarjetas SELECT @TarjetasCobradas = @TarjetasCobradas + @Importe5, @ReferenciaTarjetas = @Referencia5
          
          IF EXISTS(SELECT * FROM FormaPago WHERE FormaPago IN (@FormaCobro1, @FormaCobro2,@FormaCobro3,@FormaCobro4,@FormaCobro5)AND FormaPago NOT IN(@FormaCobroTarjetas) AND LDI= 1)
          BEGIN
            EXEC spLDIPagoTarjetaCredito @ID, @Empresa, @Sucursal, @Modulo, @Usuario, @FormaCobro1, @FormaCobro2,@FormaCobro3,@FormaCobro4,@FormaCobro5, @FormaCobroTarjetas, @Importe1, @Importe2, @Importe3, @Importe4, @Importe5, @Referencia1, @Referencia2, @Referencia3, @Referencia4, @Referencia5, @Ok OUTPUT, @OkRef OUTPUT, @Accion, @Estatus, @EstacionTrabajo
          END

          IF @CobroDesglosado + @CobroDelEfectivo <> 0.0
          BEGIN     
            SELECT @CobroCambio = @CobroDesglosado + @CobroDelEfectivo - (@ImporteTotalCx - @SumaRetenciones) - @CobroRedondeo

            IF (@CobroDesglosado + @CobroDelEfectivo) <  ((@ImporteTotalCx-@SumaRetenciones) + @CobroRedondeo) SELECT @CobroCambio = 0.0            
                       
            IF ROUND(ABS(@CobroCambio), @RedondeoMonetarios) = 0.01 SELECT @CobroCambio = 0.0
            IF @Accion <> 'CANCELAR'
              UPDATE VentaCobro SET Actualizado = 1, Cambio = @CobroCambio WHERE ID = @ID

            SELECT @DineroImporte = @CobroDesglosado - @CobroCambio
          END 
        END

        IF @CobroIntegrado = 1 AND @CobroIntegradoCxc = 0 AND @CobroIntegradoParcial = 0 AND @OrigenTipo <> 'CR' AND @ImporteTotalCx <> 0.0 AND (@Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') OR @EstatusNuevo = 'CANCELADO') AND @Ok IS NULL 
        BEGIN
          IF @ValesCobrados > 0.0 OR @TarjetasCobradas <> 0 -- 	-- ETO Tarjetas 9-Feb-2007 se agregó @TarjetasCobradas
            EXEC spValeAplicarCobro @Empresa, @Modulo, @ID, @TarjetasCobradas, @Accion, @FechaEmision, @Ok OUTPUT, @OkRef OUTPUT

	-- ETO Tarjetas 9-Feb-2007 
          IF @OK is null AND @TarjetasCobradas <> 0 AND (@LDI = 0 OR (@LDI = 1  AND @LDITarjeta = 0))
            EXEC spValeGeneraAplicacionTarjeta @Empresa, @Modulo, @ID, @Mov, @MovID, @Accion, @FechaEmision, @Usuario, @Sucursal, 
						@TarjetasCobradas, @CtaDinero, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT, @Referencia = @ReferenciaTarjetas --BUG15665
	-- ETO Tarjetas 9-Feb-2007 Puntos por Categoría de Artículos
--REQ 13386  	

        IF @LDI = 1  AND @OrigenTipo NOT IN ('POS','VMOS') 
        BEGIN
--REQ 13386  	
     		 
          IF @OK is null AND @Modulo = 'VTAS' AND @CfgVentaMonedero = 1 AND @CfgVentaMonederoA = 0 AND Exists(SELECT * FROM TarjetaSeriemov t JOIN ValeSerie v ON  t.Serie = v.Serie JOIN Art a ON v.Articulo = a.Articulo WHERE t.Empresa = @Empresa AND t.Modulo = @Modulo AND t.ID = @ID AND ISNULL(a.LDI,0) = 0) 
          BEGIN
             EXEC spVentaMonedero @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, 
				 @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, 
				 @Ok OUTPUT, @OkRef OUTPUT  
		 
          END				    
        END
        ELSE
        BEGIN
          IF @OK is null AND @Modulo = 'VTAS' AND @CfgVentaMonedero = 1 AND @CfgVentaMonederoA = 0 AND Exists(SELECT * FROM TarjetaSeriemov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID) AND @LDI = 0
          EXEC spVentaMonedero @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, 
	                       @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, 
			       @Ok OUTPUT, @OkRef OUTPUT
			       
       END
--REQ 13393 POS
       IF @OrigenTipo = 'POS'
       BEGIN
         EXEC spInvAfectarDineroPOS @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
                                    @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo,
                                    @ClienteProv, @EnviarA, @SucursalOrigen, @Ok OUTPUT, @OkRef OUTPUT,	   
                                    @EsCargo OUTPUT, @CtaDinero OUTPUT, @Cajero OUTPUT, @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                    @FormaPagoCambio OUTPUT, @CobroCambio OUTPUT, @DineroImporte OUTPUT, @CobroDelEfectivo OUTPUT, @CobroSumaEfectivo OUTPUT,
                                    @Importe1 OUTPUT, @Importe2 OUTPUT, @Importe3 OUTPUT, @Importe4 OUTPUT, @Importe5 OUTPUT, @ImporteCambio OUTPUT,
                                    @FormaCobro1 OUTPUT, @FormaCobro2 OUTPUT, @FormaCobro3 OUTPUT, @FormaCobro4 OUTPUT, @FormaCobro5 OUTPUT,
                                    @Referencia1 OUTPUT, @Referencia2 OUTPUT, @Referencia3 OUTPUT, @Referencia4 OUTPUT, @Referencia5 OUTPUT, 
                                    @FormaMoneda OUTPUT, @FormaTipoCambio OUTPUT, @FormaCobroVales OUTPUT, @TipoCambio1  OUTPUT,@TipoCambio2 OUTPUT, @TipoCambio3 OUTPUT, @TipoCambio4 OUTPUT, @TipoCambio5 OUTPUT
                                 
       END
       ELSE			       


          EXEC spInvAfectarDinero @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
                                  @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo,
                                  @ClienteProv, @EnviarA, @SucursalOrigen, @Ok OUTPUT, @OkRef OUTPUT,	   
                                  @EsCargo OUTPUT, @CtaDinero OUTPUT, @Cajero OUTPUT, @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                  @FormaPagoCambio OUTPUT, @CobroCambio OUTPUT, @DineroImporte OUTPUT, @CobroDelEfectivo OUTPUT, @CobroSumaEfectivo OUTPUT,
                                  @Importe1 OUTPUT, @Importe2 OUTPUT, @Importe3 OUTPUT, @Importe4 OUTPUT, @Importe5 OUTPUT, @ImporteCambio OUTPUT,
                                  @FormaCobro1 OUTPUT, @FormaCobro2 OUTPUT, @FormaCobro3 OUTPUT, @FormaCobro4 OUTPUT, @FormaCobro5 OUTPUT,
                                  @Referencia1 OUTPUT, @Referencia2 OUTPUT, @Referencia3 OUTPUT, @Referencia4 OUTPUT, @Referencia5 OUTPUT, 
                                  @FormaMoneda OUTPUT, @FormaTipoCambio OUTPUT, @FormaCobroVales OUTPUT, @FormaCobroCambio OUTPUT, --MEJORA5512
								  @InterfazTC, @TCDelEfectivo, @TCProcesado1, @TCProcesado2, @TCProcesado3, @TCProcesado4, @TCProcesado5 --REQ13163
                                  
        END ELSE
        IF @ImporteTotalCx > 0.0 AND @Ok IS NULL AND @OrigenTipo <> 'CR' AND 
           ((@MovTipo IN ('VTAS.FM', 'VTAS.N', 'VTAS.NO', 'VTAS.NR') AND @CobroIntegradoCxc = 1) OR
           (((@MovTipo IN ('VTAS.F','VTAS.FX','VTAS.FAR', 'VTAS.FB','VTAS.D','VTAS.DF')) OR (@SubClave = 'VTAS.FA')) AND @CobrarPedido = 0 AND (@Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') OR @EstatusNuevo = 'CANCELADO')) OR 
           (@MovTipo IN ('VTAS.B', 'COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.D','COMS.B','COMS.CA', 'COMS.GX') AND @EstatusNuevo IN ('CONCLUIDO','PROCESAR','CANCELADO')) )
        BEGIN
          -- Retenciones de la Compra
          IF /*@CfgRetencionAlPago = 0 OR*/ @BorrarRetencionCx = 1 SELECT @RetencionCx = 0.0, @Retencion2Cx = 0.0, @Retencion3Cx = 0.0

          IF @MovTipo = 'COMS.EI'
            EXEC spGenerarCxImportacion @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
         	                        @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
   		   		        @FechaRegistro, @Ejercicio, @Periodo,
		                        @Condicion, @Vencimiento, @ClienteProv, @EnviarA, @Agente, NULL, NULL, NULL,
                                        @ImporteCx, @ImpuestosCx, @RetencionCx, @SumaComision, 
                                        NULL, NULL, NULL, NULL, @VIN, NULL,
			                @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                                        @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP = 'SIN_DOCAUTO', @IVAFiscal = @IVAFiscal, @IEPSFiscal = @IEPSFiscal, @Retencion2 = @Retencion2Cx, @Retencion3 = @Retencion3Cx
          ELSE BEGIN
            IF (@CobroIntegradoCxc = 1 OR @CobroIntegradoParcial = 1) AND @Accion = 'CANCELAR'
              EXEC spCobroIntegradoCxcCancelar @Sucursal, @Accion, @Modulo, @Empresa, @Usuario, @ID, @Mov, @MovID, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT

            SELECT @CondicionCx = @Condicion, @VencimientoCx = @Vencimiento
            IF @CobroIntegradoParcial = 1
              SELECT @CondicionCx = Condicion, @VencimientoCx = Vencimiento FROM VentaCobro WHERE ID = @ID

            IF @CfgAC = 1 AND @Modulo = 'VTAS' 
            BEGIN
              SELECT @LCMetodo = ta.Metodo, @LCPorcentajeResidual = ISNULL(lc.PorcentajeResidual, 0)
                FROM Venta v 
                JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = v.TipoAmortizacion
                JOIN LC ON lc.LineaCredito = v.LineaCredito 
               WHERE v.ID = @ID          
               EXEC xpPorcentajeResidual @Modulo, @ID, @LCPorcentajeResidual OUTPUT

--COMENTARIO_0013

            END

            EXEC @CxID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
    	                   	     @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
   		           	     @FechaRegistro, @Ejercicio, @Periodo,
		           	     @CondicionCx, @VencimientoCx, @ClienteProv, @EnviarA, @Agente, NULL, NULL, NULL,
                           	     @ImporteCx, @ImpuestosCx, @RetencionCx, @SumaComision, 
                           	     NULL, NULL, NULL, NULL, @VIN, NULL,
			   	     @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                           	     @Ok OUTPUT, @OkRef OUTPUT, @INSTRUCCIONES_ESP = 'SIN_DOCAUTO', @IVAFiscal = @IVAFiscal, @IEPSFiscal = @IEPSFiscal, @Retencion2 = @Retencion2Cx, @Retencion3 = @Retencion3Cx, @EndosarA = @EndosarA, @CopiarMovImpuesto = 1
            
            IF (@CobroIntegradoCxc = 1 OR @CobroIntegradoParcial = 1) AND @Accion <> 'CANCELAR'
              EXEC spCobroIntegradoCxc @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo,
                                           @Empresa, @Usuario, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaRegistro,
                                           @DineroImporte, @CobroDelEfectivo, @CobroCambio,
                                           @FormaCobro1, @FormaCobro2, @FormaCobro3, @FormaCobro4, @FormaCobro5,
                                           @Importe1, @Importe2, @Importe3, @Importe4, @Importe5,
                                           @Referencia1, @Referencia2, @Referencia3, @Referencia4, @Referencia5,
                                           @CtaDinero, @Cajero, @CxID, @FormaCobroCambio, @Ok OUTPUT, @OkRef OUTPUT,
                                           @InterfazTC, @TCDelEfectivo, @TCProcesado1, @TCProcesado2, @TCProcesado3, @TCProcesado4, @TCProcesado5--REQ13163
                                           
            IF @CfgAC = 1 AND @LCMetodo = 50 AND @Accion <> 'CANCELAR'
            BEGIN
              SELECT @CxAjusteImporte = @ImporteCx * (@LCPorcentajeResidual/100.0)
              IF @CxAjusteImporte > 0.0
              BEGIN
                SELECT @CxAjusteMov = ACAjusteValorResidual FROM EmpresaCfgMov WHERE Empresa = @Empresa
                SELECT @CxConcepto = ACAjusteConceptoValorResidual FROM EmpresaCfg WHERE Empresa = @Empresa
                EXEC @CxAjusteID = spAfectar 'CXC', @CxID, 'GENERAR', 'TODO', @CxAjusteMov, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
                IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
                IF @Ok IS NULL AND @CxAjusteID IS NOT NULL
                BEGIN
                  UPDATE Cxc  SET Concepto = @CxConcepto, Importe = @CxAjusteImporte, Impuestos = NULL, AplicaManual = 1 WHERE ID = @CxAjusteID
                  DELETE CxcD WHERE ID = @CxAjusteID
                  INSERT CxcD (ID, Renglon, Aplica, AplicaID, Importe) VALUES (@CxAjusteID, 2048.0, @Mov, @MovID, @CxAjusteImporte)
                  EXEC spAfectar 'CXC', @CxAjusteID, 'AFECTAR', 'TODO', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
                END
              END

              SELECT @CxAjusteImporte = @ImpuestosCx
              IF @CxAjusteImporte > 0.0
              BEGIN
                SELECT @CxAjusteMov = ACAjusteImpuestoAd FROM EmpresaCfgMov WHERE Empresa = @Empresa
                SELECT @CxConcepto = ACAjusteConceptoImpuestoAd FROM EmpresaCfg WHERE Empresa = @Empresa
                EXEC @CxAjusteID = spAfectar 'CXC', @CxID, 'GENERAR', 'TODO', @CxAjusteMov, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
                IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
                IF @Ok IS NULL AND @CxAjusteID IS NOT NULL
                BEGIN
                  UPDATE Cxc  SET Concepto = @CxConcepto, Importe = @CxAjusteImporte, Impuestos = NULL, AplicaManual = 1 WHERE ID = @CxAjusteID
                  DELETE CxcD WHERE ID = @CxAjusteID
                  INSERT CxcD (ID, Renglon, Aplica, AplicaID, Importe) VALUES (@CxAjusteID, 2048.0, @Mov, @MovID, @CxAjusteImporte)
                  EXEC spAfectar 'CXC', @CxAjusteID, 'AFECTAR', 'TODO', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
                END
              END
            END
          END
          IF @CxID IS NOT NULL
            SELECT @CxMovTipo = Clave FROM MovTipo WHERE Modulo = @CxModulo AND Mov = @CxMov
        END

        IF (@CobroIntegradoCxc = 1 OR @CobroIntegradoParcial = 1) AND @Ok IS NULL AND @TCDelEfectivo > 0 AND @InterfazTC = 1 AND @Accion IN('AFECTAR', 'CANCELAR') --REQ13163
        BEGIN
          EXEC spTCAplicacionSaldo @Modulo, @ID, @Mov, @MovTipo, @Empresa, @Sucursal, @Usuario, @Accion, @Cliente, @TCDelEfectivo, @FechaEmision, @CxID, @CxMov, @CxMovID, @Ok OUTPUT, @OkRef OUTPUT
        END
        
        --REQ13163
        EXEC spInvGenerarRetencionesCompra @Fiscal, @FiscalGenerarRetenciones, @CfgRetencionAlPago, @MovTipo, @SumaRetencion, @SumaRetencion2, @SumaRetencion3, @CfgRetencionAcreedor, 
										   @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovMoneda, @MovTipoCambio, @FechaEmision, 
										   @CfgRetencionConcepto, @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @FechaRegistro, @Ejercicio, 
										   @Periodo, @CfgRetencionMov, @CfgRetencion2Acreedor, @CfgRetencion2Concepto, @CfgRetencion3Acreedor, @CfgRetencion3Concepto, 
										   @CxModulo = @CxModulo OUTPUT, @CxMov = @CxMov OUTPUT, @CxMovID = @CxMovID OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        
        -- Disminuir Anticipos Facturados
        IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FB','VTAS.N') AND (@Estatus = 'SINAFECTAR' OR @EstatusNuevo = 'CANCELADO') AND @CfgAnticiposFacturados = 1 AND (@AnticiposFacturados > 0.0 OR @AnticipoFacturadoTipoServicio = 1) --ANTICIPOFACTURADO
        BEGIN
          IF @Accion = 'CANCELAR' SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0 
          IF @Accion = 'CANCELAR'
		  BEGIN
            UPDATE Cxc 
               SET AnticipoSaldo = ISNULL(AnticipoSaldo, 0) + vfa.Importe
              FROM Cxc c, VentaFacturaAnticipo vfa
             WHERE vfa.ID = @ID AND vfa.CxcID = c.ID
--DMJ  Para cancelarlos anticipos facturados tipo servicio          
             IF @AnticipoFacturadoTipoServicio = 1 SELECT @AnticiposFacturados = (SELECT SUM(ABS(ISNULL(Importetotal,0.0))-ABS(ISNULL(AnticipoRetencion,0.0))) FROM VentaTCalc WHERE ID = @ID AND AnticipoFacturado = 1) --ANTICIPOFACTURADO
          END  
          ELSE BEGIN
            IF EXISTS(SELECT 1 FROM VentaD WHERE ID = @ID AND AnticipoFacturado = 1 AND (AnticipoMoneda <> @MovMoneda OR AnticipoTipoCambio <> @MovTipoCambio)) SELECT @Ok = 10495 --ANTICIPOFACTURADO
             
            --SELECT @SumaAnticiposFacturados = SUM((AnticipoAplicar*TipoCambio)/@MovTipoCambio) FROM Cxc WHERE AnticipoAplicaModulo = @Modulo AND AnticipoAplicaID = @ID --ANTICIPOFACTURADO
			SELECT @SumaAnticiposFacturados = SUM(CASE WHEN RTRIM(LTRIM(Moneda)) = RTRIM(LTRIM(@MovMoneda)) THEN AnticipoAplicar ELSE (AnticipoAplicar*TipoCambio)/@MovTipoCambio END) FROM Cxc WHERE AnticipoAplicaModulo = @Modulo AND AnticipoAplicaID = @ID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')--ANTICIPOFACTURADO            
            EXEC xpSumaAnticiposFacturados @Empresa, @Usuario, @Accion, @Modulo, @ID, @MovMoneda, @MovTipoCambio, @SumaAnticiposFacturados OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

            IF @AnticipoFacturadoTipoServicio = 1 SELECT @AnticiposFacturados = (SELECT SUM(ABS(ISNULL(Importetotal,0.0))-ABS(ISNULL(AnticipoRetencion,0.0))) FROM VentaTCalc WHERE ID = @ID AND AnticipoFacturado = 1) --ANTICIPOFACTURADO
            IF /*ISNULL(@SumaAnticiposFacturados, 0.0)> 0.0 AND */ABS(ROUND(@AnticiposFacturados,2)-ROUND(@SumaAnticiposFacturados,2)) > 0.1 SELECT @Ok = 30405 ELSE
            IF @AnticipoFacturadoTipoServicio = 1 AND ABS(ROUND(@AnticiposFacturados,2)-ROUND(@SumaAnticiposFacturados,2)) > 0.1 SELECT @Ok = 30405 ELSE             
            IF @AnticipoFacturadoTipoServicio = 1 AND EXISTS(SELECT 1 FROM VentaTCalc WHERE ID = @ID AND AnticipoFacturado = 1 AND ImporteTotal > 0.0) SELECT @Ok = 30405 --ANTICIPOFACTURADO
            IF EXISTS(SELECT * FROM Cxc WHERE AnticipoAplicaModulo = @Modulo AND AnticipoAplicaID = @ID AND (ISNULL(AnticipoAplicar, 0) < 0.0 OR ROUND(AnticipoAplicar, 0) > ROUND(AnticipoSaldo, 0))) SELECT @Ok = 30405 
            ELSE BEGIN
              INSERT VentaFacturaAnticipo (ID, CxcID, Importe)
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
          EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'CANT', @MovMoneda, @MovTipoCambio, @ClienteProv, NULL, NULL, NULL,
                       @Modulo, @ID, @Mov, @MovID, @EsCargo, @AnticiposFacturados, NULL, NULL,
                       @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0,
     	               @Ok OUTPUT, @OkRef OUTPUT
        END

        --REQ7890
        IF @MovTipo IN ('COMS.EG', 'COMS.EI', 'INV.EI', 'COMS.GX') AND @EstatusNuevo IN ('CONCLUIDO','PROCESAR','CANCELADO') --AND @OrigenMovTipo <> 'COMS.EIMPO'
          EXEC spAfectarGastoDiverso @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @FechaRegistro, 
                                     @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @Ejercicio, @Periodo, @VIN,
                                     @Ok OUTPUT, @OkRef OUTPUT

        --IF @MovTipo IN ('COMS.O') AND @EstatusNuevo IN ('CONCLUIDO','PROCESAR','CANCELADO', 'PENDIENTE') AND @MovTipo = 'COMS.EIMPO'
        --  EXEC spAfectarGastoDiverso @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @FechaRegistro, 
        --                             @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @Ejercicio, @Periodo, @VIN,
        --                             @Ok OUTPUT, @OkRef OUTPUT

        -- Afectar las Comisiones
        IF @UltAgente IS NOT NULL AND @ComisionAcum <> 0.0 AND @Ok IS NULL AND 
           (((@MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FB', 'VTAS.D', 'VTAS.DF', 'VTAS.B') AND (@Estatus = 'SINAFECTAR' OR @EstatusNuevo = 'CANCELADO')) AND (@CfgVentaComisionesCobradas = 0 OR @CobroIntegrado = 1 OR @CobrarPedido = 1)) OR @MovTipo IN ('VTAS.FM', 'VTAS.N', 'VTAS.NO', 'VTAS.NR')) 
        BEGIN
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, 'AGENT', @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                           @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                           @FechaRegistro, @Ejercicio, @Periodo, 
                           NULL, NULL, @ClienteProv, NULL, @UltAgente, NULL, NULL, NULL, 
                           @ComisionImporteNeto, NULL, NULL, @ComisionAcum, 
                           NULL, NULL, NULL, NULL, NULL, NULL,
                           @CxModulo, @CxMov, @CxMovID, @Ok OUTPUT, @OkRef  OUTPUT
          SELECT @ComisionAcum = 0.0, @ComisionImporteNeto = 0.0
        END

        IF @MovTipo = 'VTAS.DF' OR (@MovTipo = 'INV.A' AND @CfgInvAjusteCargoAgente <> 'NO') AND @Ok IS NULL
        BEGIN
          SELECT @CxImporte = NULL, @CxMovEspecifico = NULL, @CxAgente = @Agente

          IF @MovTipo = 'VTAS.DF'
          BEGIN
            SELECT @CxImporte = -SUM(Cantidad*Costo) FROM VentaD WHERE ID = @ID
            SELECT @CxMovEspecifico = @Mov
            SELECT @CxAgente = AgenteServicio FROM Venta WHERE ID = @ID
          END ELSE BEGIN
            IF @CfgInvAjusteCargoAgente = 'PRECIO' 
              SELECT @CxImporte = SUM(d.Cantidad*ISNULL(d.Precio, a.PrecioLista)) FROM InvD d, Art a WHERE d.ID = @ID AND d.Articulo = a.Articulo 
            ELSE 
              SELECT @CxImporte = SUM(Cantidad*Costo) FROM InvD WHERE ID = @ID
          END

          IF ISNULL(@CxImporte, 0.0) < 0.0
          BEGIN
            SELECT @CxImporte = -@CxImporte
            EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, 'AGENT', @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                             @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                             @FechaRegistro, @Ejercicio, @Periodo, 
                             NULL, NULL, @Agente, NULL, @CxAgente, NULL, NULL, NULL, 
                             @CxImporte, NULL, NULL, @CxImporte, 
                             NULL, NULL, NULL, NULL, NULL, @CxMovEspecifico,
                             @CxModulo, @CxMov, @CxMovID, @Ok OUTPUT, @OkRef  OUTPUT    
            IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
          END
        END

	-- Bonificacion Automatica
        IF @Accion <> 'CANCELAR'
        BEGIN
          IF @CfgCompraAutoCargos = 1 AND @MovTipo IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI', 'COMS.D', 'COMS.B') AND @Ok IS NULL
	    EXEC xpCompraAutoCargos @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @ID, @Mov,
			            @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision , @Concepto, @Proyecto,
				    @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @FechaRegistro, @Ejercicio, @Periodo,
				    @Condicion, @Vencimiento, @ClienteProv, @SumaImporteNeto, @SumaImpuestosNetos, @VIN, @Ok OUTPUT, @OkRef OUTPUT
          IF @CfgVentaAutoBonif = 1 AND @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.D', 'VTAS.DF', 'VTAS.B') AND @Ok IS NULL
	    EXEC xpVentaAutoBonif @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @ID, @Mov,
			          @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision , @Concepto, @Proyecto,
				  @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @FechaRegistro, @Ejercicio, @Periodo,
				  @Condicion, @Vencimiento, @ClienteProv, @CobroIntegrado, @SumaImporteNeto, @SumaImpuestosNetos, @VIN, @Ok OUTPUT, @OkRef OUTPUT
        END

        IF @Accion <> 'CANCELAR' AND @MovTipo IN ('VTAS.F','VTAS.FAR') AND (SELECT CxcAutoAplicarAnticiposPedidos FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1
        BEGIN
          SELECT @ReferenciaAplicacionAnticipo = RTRIM(@Origen) + ' ' + RTRIM(@OrigenID)
          EXEC xpVentaAutoAplicarAnticiposPedidos @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @ID, @Mov,
   			          		  @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision , @Concepto, @Proyecto,
				  		  @Usuario, @Autorizacion, @ReferenciaAplicacionAnticipo, @DocFuente, @Observaciones, @FechaRegistro, @Ejercicio, @Periodo,
				  		  @Condicion, @Vencimiento, @ClienteProv, @CobroIntegrado, @SumaImporteNeto, @SumaImpuestosNetos, @VIN, @Ok OUTPUT, @OkRef OUTPUT
        END
	-- Documentacion Automatica
	IF @Ok IN (NULL, 80030) AND @CxID IS NOT NULL AND @CxMovTipo IN ('CXC.F', 'CXC.CA', 'CXC.CAP', 'CXC.CAD', 'CXC.D', 'CXP.F', 'CXP.CA', 'CXP.CAP', 'CXP.CAD', 'CXP.D') AND @Condicion IS NOT NULL AND @Accion <> 'CANCELAR' 
	BEGIN 
          SELECT @Ok = NULL, @OkRef = NULL
          IF (SELECT AC FROM EmpresaGral WHERE Empresa = @Empresa) = 0
  	    IF EXISTS(SELECT * FROM Condicion WHERE Condicion = @Condicion AND DA = 1)
              EXEC spCxDocAuto @CxModulo, @CxID, @Usuario, @Ok OUTPUT, @OkRef OUTPUT
        END

        IF @CfgCompraAutoEndosoAutoCargos = 1 AND @Modulo = 'COMS' AND @MovTipo = 'COMS.F' AND @Accion = 'AFECTAR' AND @EstatusNuevo = 'CONCLUIDO' AND @CxModulo = 'CXP' and @CxmovTipo = 'CXP.F' AND @CxID IS NOT NULL AND @Ok IN (NULL, 80030) 
        BEGIN
          SELECT @Proveedor = Proveedor FROM Compra WHERE ID = @ID
          SELECT @AutoEndosar = AutoEndoso FROM Prov WHERE Proveedor = @Proveedor
 
          IF @AutoEndosar IS NOT NULL
          BEGIN
            SELECT @Ok = NULL, @OkRef = NULL
            SELECT @CxEndosoMov = CxpEndoso FROM EmpresaCfgMov WHERE Empresa = @Empresa
            EXEC spCx @CxID, @CxModulo, 'GENERAR', 'TODO', @FechaRegistro, @CxEndosoMov, @Usuario, 1, 0, @CxEndosoMov OUTPUT, @CxEndosoMovID OUTPUT, @CxEndosoID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
            IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
            IF @Ok IS NULL
            BEGIN
              IF @CxModulo = 'CXP' UPDATE Cxp SET FechaEmision = @FechaEmision, Proveedor = @AutoEndosar WHERE ID = @CxEndosoID 
                EXEC spCx @CxEndosoID, @CxModulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @CxEndosoMov OUTPUT, @CxEndosoMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
            END
          END
        END

        IF @MovTipo = 'COMS.OP' AND @Ok IS NULL
          EXEC spCompraProrrateo @Sucursal, @Empresa, @Usuario, @Accion, @Modulo, @ID, @FechaRegistro, 
                                 @Mov, @MovID, @FechaEmision, @Ejercicio, @Periodo, @MovMoneda, @MovTipoCambio, 
                                 @Ok OUTPUT, @OkRef OUTPUT
        -- Explotar PROD.O 
        IF @MovTipo = 'PROD.O' AND @Ok IS NULL
          EXEC spProdExplotar @Sucursal, @Empresa, @Usuario, @Accion, @Modulo, @ID, @FechaRegistro, 0, @Ok OUTPUT, @OkRef OUTPUT

        IF @MovTipo IN ('VTAS.FG'/*, 'VTAS.FX'*/) AND @Ok IS NULL
          EXEC spGenerarGasto @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT, @MovTipo = @MovTipo
      END  -- if @Continuar = 1
    END

    IF @Modulo = 'VTAS'
    BEGIN
      IF (SELECT TieneMovimientos FROM Cte WHERE Cliente = @ClienteProv) = 0      
        UPDATE Cte SET TieneMovimientos = 1 WHERE Cliente = @ClienteProv 
    END
    IF @Modulo = 'VTAS' AND @EnviarA IS NOT NULL
    BEGIN
      IF (SELECT TieneMovimientos FROM CteEnviarA WHERE Cliente = @ClienteProv  AND ID = @EnviarA) = 0
        UPDATE CteEnviarA SET TieneMovimientos = 1 WHERE Cliente = @ClienteProv  AND ID = @EnviarA
    END
    IF @Almacen IS NOT NULL
    BEGIN
      IF (SELECT TieneMovimientos FROM Alm WHERE Almacen = @Almacen) = 0      
        UPDATE Alm SET TieneMovimientos = 1 WHERE Almacen = @Almacen 
    END
    IF @AlmacenDestino IS NOT NULL
    BEGIN
      IF (SELECT TieneMovimientos FROM Alm WHERE Almacen = @AlmacenDestino) = 0      
        UPDATE Alm SET TieneMovimientos = 1 WHERE Almacen = @AlmacenDestino 
    END
    IF @Agente IS NOT NULL
    BEGIN
      IF (SELECT TieneMovimientos FROM Agente WHERE Agente = @Agente) = 0      
        UPDATE Agente SET TieneMovimientos = 1 WHERE Agente = @Agente 
    END
    IF @Modulo = 'COMS'
    BEGIN
      IF (SELECT TieneMovimientos FROM Prov WHERE Proveedor = @ClienteProv) = 0      
        UPDATE Prov SET TieneMovimientos = 1 WHERE Proveedor = @ClienteProv
    END

    IF @OrigenMovTipo = 'VTAS.FR'
      EXEC spAfectarMovRecurrente @Accion, @Empresa, @Modulo, @Origen, @OrigenID, @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo = 'VTAS.CTO'
      EXEC spMovContratoGenerar @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo IN ('COMS.CA', 'COMS.GX')
    BEGIN
      SELECT @ProrrateoAplicaID = p.ID, @ProrrateoAplicaIDMov = p.Mov, @ProrrateoAplicaIDMovID = p.MovID
        FROM Compra c, Compra p 
       WHERE c.ID = @ID 
         AND c.ProrrateoAplicaID = p.ID 
      IF @ProrrateoAplicaID IS NOT NULL
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @ProrrateoAplicaID, @ProrrateoAplicaIDMov, @ProrrateoAplicaIDMovID, @Ok OUTPUT 
    END

    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    BEGIN
      IF @GenerarGasto = 1 AND @Modulo = 'INV'
        EXEC spGenerarGasto @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT, @MovTipoGenerarGasto = 1

      EXEC xpInvGenerarGasto @Sucursal, @Accion, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Empresa, @Usuario, @FechaRegistro, @ClienteProv, @Ok OUTPUT, @OkRef OUTPUT
    END

    IF @MovTipo IN ('COMS.F', 'COMS.CC', 'VTAS.F') AND @Accion = 'AFECTAR' AND @EstatusNuevo = 'CONCLUIDO'
      EXEC spEliminarOrdenesPendientes @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
          	     	               @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal,
	        		       NULL, NULL,
                                       @Ok OUTPUT, @OkRef OUTPUT
                                       
    IF @MovTipo = 'COMS.O' AND @Accion = 'AFECTAR' AND @EstatusNuevo = 'PENDIENTE'
      EXEC spCancelarRequisicionesPendientes @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
                                             @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal,
                                             NULL, NULL,
                                             @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo IN ('VTAS.P', 'VTAS.S') AND @CfgVentaDMultiAgenteSugerir = 1  AND @EstatusNuevo = 'PENDIENTE'
      EXEC spSugerirVentaDAgenteFecha @ID, @EnSilencio = 1

--COMENTARIO_0014

  ----REQ12615 WMS
  --  IF @WMS = 1 AND EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND WMS = 1) AND @Accion IN ('AFECTAR', 'CANCELAR', 'RESERVARPARCIAL') AND @OrigenTipo <> 'TMA' AND @Ok IS NULL
  --  BEGIN
  --    SELECT @GenerarOrden = 0  	
  --    IF EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND GenerarOrdenEntarimado = 1) AND 
  --       EXISTS(SELECT * FROM AlmOrdenEntarimadoMov WHERE Almacen = @Almacen AND Modulo = @Modulo AND Mov = @Mov)
  --      EXEC spGenerarOrdenEntarimado @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @Almacen, @Ok OUTPUT, @OkRef OUTPUT

  --    IF EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND (GenerarOrdenAcomodoRecibo = 1 OR GenerarSolAcomodoRecibo = 1)) AND 
  --       EXISTS(SELECT * FROM AlmOrdenAcomodoReciboMov WHERE Almacen = @Almacen AND Modulo = @Modulo AND Mov = @Mov)
  --    BEGIN
  --    	IF EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND GenerarOrdenAcomodoRecibo = 1) SELECT @GenerarOrden = 1
  --      EXEC spGenerarOrdenTarimaAcomodo 'RECIBO', @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @FechaEmision, @Proyecto, @Almacen, @Ok OUTPUT, @OkRef OUTPUT, @GenerarOrden = @GenerarOrden
  --    END

  --    IF EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND (GenerarOrdenAcomodoSurtido = 1 OR GenerarSolAcomodoSurtido = 1)) AND 
  --       EXISTS(SELECT * FROM AlmOrdenAcomodoSurtidoMov WHERE Almacen = @Almacen AND Modulo = @Modulo AND Mov = @Mov)
  --    BEGIN
  --    	IF EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND GenerarOrdenAcomodoSurtido = 1) SELECT @GenerarOrden = 1
  --      EXEC spGenerarOrdenTarimaAcomodo 'REABASTECIMIENTO', @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @FechaEmision, @Proyecto, @Almacen, @Ok OUTPUT, @OkRef OUTPUT, @GenerarOrden = @GenerarOrden
  --    END
  --  END

    --TASK25114 --OJO: Posiblemente haya que atender el BUG24067 dentro del spFlujoWMS
    --BUG24540
    IF @OrigenMovTipo <> 'INV.IF'
BEGIN
	  --BUG3652
      IF @MovTipo<>'INV.T' AND @WMS = 1 AND EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND WMS = 1) AND @Accion IN ('AFECTAR', 'CANCELAR', 'RESERVARPARCIAL') AND @OrigenTipo <> 'TMA' AND @Ok IS NULL
	  BEGIN
        EXEC spFlujoWMS @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @Almacen, @FechaEmision, @Proyecto, @Tarima, @Articulo, @Ok OUTPUT, @OkRef OUTPUT

		IF @MovTipo = 'INV.SOL'
        BEGIN
			  SELECT @CrossDocking = CrossDocking,
              	     @Almacen      = Almacen,
		             @PosicionWMS  = PosicionWMS
	            FROM INV 
	           WHERE ID = @ID

               SELECT @EsCrossDocking = RTRIM(LTRIM(ISNULL(EsCrossDocking,''))), --SI, NO
	                  @posicioncrossdocking = ISNULL(defposicioncrossdocking,'') 
	             FROM ALM 
	             WHERE Almacen = @Almacen 

	         IF @posicioncrossdocking = '' AND @CrossDocking = 1
	         BEGIN
		        SELECT @Ok    = Mensaje, 
		               @OkRef = Descripcion
		          FROM MensajeLista 
		         WHERE Mensaje = 20028

		         SELECT @OkRef
		         ROLLBACK TRANSACTION
		         EXEC spEliminarMov @Modulo, @ID
		         RETURN
             END

	         IF @EsCrossDocking = '' AND @CrossDocking = 1
	         BEGIN
		        SELECT @Ok    = Mensaje, 
		               @OkRef = Descripcion
		          FROM MensajeLista 
		         WHERE Mensaje = 20027

		         SELECT @OkRef
		         ROLLBACK TRANSACTION
		         EXEC spEliminarMov @Modulo, @ID
		         RETURN
             END

            IF @CrossDocking = 1 AND @EsCrossDocking IN ('Si','No')
            BEGIN
                EXEC spAfectar 'INV', @ID, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Estacion = @@SPID
                EXEC spAfectar 'INV', @ID, 'GENERAR', 'Pendiente', 'Entarimado', @Usuario, @EnSilencio = 1, @Estacion = @@SPID
            END
        END
	  END
	END
	      --REQ12615 WMS

--Se movio  al     spInvAfectarFEA para disminuir el tamño del spinvafectar y poder compilar 
    IF @FEA = 1 
    BEGIN
      EXEC spInvAfectarFEA  @ID, @Accion, @Empresa, @Sucursal, @Estatus, @Modulo, @Mov, @MovTipoConsecutivoFEA, @FEAConsecutivo, @FEAReferencia, @FEASerie, @FEAFolio, @Ok OUTPUT, @OkRef OUTPUT

    END 


    IF @MovTipo = 'INV.A' AND @OrigenMovTipo= 'INV.IF'
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'INV', @IDOrigen, @Origen, @OrigenID, 'INV', @ID, @Mov, @MovID, @Ok OUTPUT

	--TASK25114
	--BUG24540
 	IF @WMS = 1 AND @Modulo = 'INV' AND @MovTipo = 'INV.A' AND @Accion = 'CANCELAR' AND @OrigenMovTipo = 'INV.IF'
 	BEGIN
      UPDATE Tarima
         SET Estatus = 'ALTA',
             Baja = NULL
			 --BUG25657
             --,Alta = GETDATE()
        FROM Tarima
        JOIN InvD   ON Tarima.Posicion = InvD.PosicionReal
        JOIN Inv    ON InvD.ID = Inv.ID
        JOIN AlmPos ON Inv.Almacen = AlmPos.Almacen AND InvD.PosicionReal = AlmPos.Posicion
        JOIN ArtDisponibleTarima ON Tarima.Tarima = ArtDisponibleTarima.Tarima AND ArtDisponibleTarima.Empresa = Inv.Empresa AND ArtDisponibleTarima.Almacen = Inv.Almacen
       WHERE InvD.ID = @ID
         AND AlmPos.Tipo <> 'DOMICILIO'
         AND Disponible > 0
         AND Tarima.Estatus = 'BAJA'
 	END

    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT, @Estacion = @EstacionTrabajo -- REQ12336
    
--Se movieron estos sp al     spInvAfectar2 para disminuir el tamño del spinvafectar y poder compilar                                      
    --spInvFacturaFlexibleAfectar  
    --spEcuadorAutorizacion 
    --spGTInvAfectar        
    --spInvFacturaProrrateadaAfectar  
    --spInvPedidoProrrateadoAfectar 
    --spAutoGenerarOP              
    --spInvEntradaProductoCancelarConsumoMaterial   
    --spInvConsumoMaterialAfectarEntradaProducto
    
    IF @Ok IS NULL
       EXEC spInvAfectar2    @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal, @UtilizarID, @UtilizarMovTipo, @EsEcuador, @IDGenerar, @GenerarOP, @ClienteProv, @ServicioSerie, @OrigenTipo, @Ok OUTPUT, @OkRef OUTPUT,
							--REQ16092
							@OPORT, @SubClave, @Origen, @OrigenID, @CfgVentaPuntosEnVales,	@AlmacenDestinoOriginal, @Almacen,  @Referencia, @IDTransito, @ContID, @Estacion, @TransitoSucursal, @TransitoMov, @TransitoMovID, @TransitoEstatus, @TraspasoExpressMov, @TraspasoExpressMovID, @CFGProdInterfazInfor, @OrigenMovTipo, @Proyecto, @Tarima, @Articulo --BUG3652


    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC xpInvAfectar @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
    	     	        @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal,
			NULL, NULL,
                        @Ok OUTPUT, @OkRef OUTPUT

	--TASK25106
	--BUG24764
    IF @Modulo = 'COMS' AND @MovTipo = 'COMS.O' AND @SubMovTipo = 'COMS.OPREENTARIMADO'
    BEGIN
      EXEC spGenerarOrdenEntarimado @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @Almacen, @Ok OUTPUT, @OkRef OUTPUT
    END

    IF @Modulo = 'COMS' AND @MovTipo = 'COMS.O' AND @SubMovTipo = 'COMS.EIMPO'
    BEGIN
      --SELECT @MovTipo, @SubMovTipo
      EXEC spGenerarReciboImportacion @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @Estatus, @Ok OUTPUT, @OkRef OUTPUT
    END

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
    BEGIN
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT
      IF @Modulo = 'VTAS' UPDATE VentaOrigen SET OrigenID = 0 WHERE ID = @ID
    END

    IF @SAUX = 1 AND @Accion IN ('AFECTAR', 'CANCELAR', 'RESERVARPARCIAL') AND @OK IS NULL
      EXEC spFlujoSAUX @Modulo, @ID, @Accion, @Base, @FechaRegistro, NULL, @Empresa, @Sucursal, @Usuario, @Conexion, @SincroFinal, @Mov, @MovID, @MovTipo, @Almacen, @FechaEmision, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT
    
--REQ 13386  
    IF @Modulo = 'VTAS' AND EXISTS(SELECT * FROM ValeSerie v JOIN VentaD d ON v.Articulo = d.Articulo 
                                     JOIN SerieLoteMov s ON d.ID = s.ID AND s.Modulo = 'VTAS' AND s.Empresa = @Empresa AND s.RenglonID = d.RenglonID AND d.Articulo = s.Articulo  AND ISNULL(d.SubCuenta,'') = ISNULL(s.SubCuenta,'') AND v.Serie = s.SerieLote
                                     JOIN Art a ON d.Articulo = a.Articulo
                                    WHERE d.ID = @ID AND a.LDI = 1 ) 
                                    AND @LDI = 1 AND @OrigenTipo NOT IN('POS','VMOS') AND @Accion NOT IN('CANCELAR') AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
                                    --AND ISNULL(@CFDFlex,0)=0
 
      EXEC spLDIVentaGenerarActivacionVale @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT
--if @ok IN (NULL, 80030) select @Ok = 1 -- breakpoint

 --REQ 13386 			   
    IF @CobroIntegrado = 1 AND @CobroIntegradoCxc = 0 AND @CobroIntegradoParcial = 0 AND @OrigenTipo NOT IN ('CR','POS','VMOS') AND @ImporteTotalCx <> 0.0 AND (@Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') OR @EstatusNuevo = 'CANCELADO') AND @Ok IS NULL 
    BEGIN  
      
      IF @OK is null AND @TarjetasCobradas <> 0 AND @LDI = 1 AND @LDITarjeta = 1--AND ISNULL(@CFDFlex,0)=0 
        EXEC spValeGeneraAplicacionTarjeta @Empresa, @Modulo, @ID, @Mov, @MovID, @Accion, @FechaEmision, @Usuario, @Sucursal, @TarjetasCobradas, @CtaDinero, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT, @LDI = 1, @Referencia = @ReferenciaTarjetas --BUG15665
    END		
    
 --REQ 13386 
    IF @OK is null AND @Modulo = 'VTAS' AND @CfgVentaMonedero = 1 AND @CfgVentaMonederoA = 0 AND Exists(SELECT * FROM TarjetaSeriemov t JOIN ValeSerie v ON  t.Serie = v.Serie JOIN Art a ON v.Articulo = a.Articulo WHERE t.Empresa = @Empresa AND t.Modulo = @Modulo AND t.ID = @ID AND ISNULL(a.LDI,0) = 1)AND  @LDI = 1 AND @OrigenTipo NOT IN('VMOS') --AND ISNULL(@CFDFlex,0)=0
      EXEC spVentaMonedero @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, 
                           @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, 
			   @Ok OUTPUT, @OkRef OUTPUT, @LDI = 1    						   
 --REQ 13386 				   
   IF @Modulo = 'VTAS' AND @MovTipo = 'VTAS.N' AND @SubClave = 'VTAS.NLDI' AND @Ok IS NULL AND @OrigenTipo NOT IN('POS','VMOS') AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion NOT IN ('CANCELAR')--AND ISNULL(@CFDFlex,0)=0
     EXEC spLDIVentaGenerarRecargaTel @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT			   

 --REQ 13386 
   IF @Modulo = 'VTAS' AND @MovTipo = 'VTAS.N' AND @SubClave = 'VTAS.NLDISERVICIO' AND @Ok IS NULL AND @OrigenTipo NOT IN('POS','VMOS') AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion NOT IN ('CANCELAR')--AND ISNULL(@CFDFlex,0)=0
     EXEC spLDIVentaGenerarPagoServicio @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT			   
    
     IF @LDI = 1 AND @Ok IS NOT NULL AND EXISTS(SELECT * FROM LDIIDTemp WHERE Estacion = @@SPID AND Modulo = @Modulo)
     BEGIN
       INSERT @LDILog(IDModulo, Modulo, Servicio, Fecha, TipoTransaccion, TipoSubservicio, CodigoRespuesta, DescripcionRespuesta, OrigenRespuesta, InfoAdicional, IDTransaccion, CodigoAutorizacion, Comprobante, Cadena, CadenaRespuesta, Importe, RIDCobro) 
       SELECT IDModulo, Modulo, Servicio, Fecha, TipoTransaccion, TipoSubservicio, CodigoRespuesta, DescripcionRespuesta, OrigenRespuesta, InfoAdicional, IDTransaccion, CodigoAutorizacion, Comprobante, Cadena, CadenaRespuesta, Importe, RIDCobro
         FROM LDIMovLog 
        WHERE IDModulo = @ID AND ID IN(SELECT ID FROM LDIIDTemp WHERE Estacion = @@SPID AND Modulo = @Modulo)
     END
     
  IF @Conexion = 0
  BEGIN
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE BEGIN
      DECLARE @PolizaDescuadrada TABLE (Cuenta varchar(20) NULL, SubCuenta varchar(50) NULL, Concepto varchar(50) NULL, Debe money NULL, Haber money NULL, SucursalContable int NULL)
      IF EXISTS(SELECT * FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID)
      INSERT @PolizaDescuadrada (Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID 
      ROLLBACK TRANSACTION
      DELETE PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID
      INSERT PolizaDescuadrada (Modulo, ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT @Modulo, @ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM @PolizaDescuadrada
      
      IF EXISTS(SELECT * FROM @LDILog)
      BEGIN
        INSERT LDIMovLog(IDModulo, Modulo, Servicio, Fecha, TipoTransaccion, TipoSubservicio, CodigoRespuesta, DescripcionRespuesta, OrigenRespuesta, InfoAdicional, IDTransaccion, CodigoAutorizacion, Comprobante, Cadena, CadenaRespuesta, Importe, RIDCobro) 
        SELECT IDModulo, Modulo, Servicio, Fecha, TipoTransaccion, TipoSubservicio, CodigoRespuesta, DescripcionRespuesta, OrigenRespuesta, InfoAdicional, IDTransaccion, CodigoAutorizacion, Comprobante, Cadena, CadenaRespuesta, Importe, RIDCobro    
          FROM @LDILog
      END    
    END
  END
    
  SELECT @BanderaDesentarimado = DesentarimarPedido FROM EmpresaCfg WHERE Empresa = @Empresa
  IF @BanderaDesentarimado = 1 AND @Accion = 'CANCELAR' AND @MovTipo = 'VTAS.P'
  BEGIN
    EXEC SPDesentarimarSurtidoPedido @ID, @Empresa, @Estacion, @Usuario
  END

  IF @Ok = 80070 AND @MovTipo = 'INV.IF' UPDATE Inv SET Estatus = 'CONCLUIDO', FechaConclusion = GETDATE() WHERE ID = @ID
  RETURN
END
GO
 
--COMENTARIO_0001
/*      IF @MovTipo = 'INV.DTI'
      BEGIN
        UPDATE Inv SET Almacen = @AlmacenDestinoOriginal, AlmacenDestino = @Almacen WHERE ID = @IDGenerar
        UPDATE InvD SET Almacen = @AlmacenDestinoOriginal WHERE ID = @IDGenerar
      END*/

--COMENTARIO_0002
                --IF @CostosImpuestoIncluido = 1 SELECT @Costo = ROUND(@Costo, @RedondeoMonetarios)

                /*IF @CostosImpuestoIncluido = 1 AND @MovTipo NOT IN ('COMS.EG', 'COMS.EI', 'INV.EI')
                  SELECT @Costo = @Costo - ROUND(@ImpuestosNetos / @Cantidad, @RedondeoMonetarios)*/

--COMENTARIO_0003
                  /*IF @UsaCacheCostos = 1 AND (@Articulo <> @UltArticulo OR @EsCargo <> @UltEsCargo OR @AplicaMov <> @UltAplica OR @AplicaMovID <> @UltAplicaID)
                  BEGIN
                    SELECT @UsaCacheCostos = 0*/

--COMENTARIO_0004
                  /*END
                  IF @UsaCacheCostos = 0 
                    SELECT @UsaCacheCostos   = 1, 
                           @UltArticulo      = @Articulo,
     	                   @UltArtMoneda     = @ArtMoneda,
		           @UltArtTipoCambio = @ArtTipoCambio,
                           @UltEsCargo       = @EsCargo,
    		  	   @UltAplica	     = @AplicaMov,
  			   @UltAplicaID	     = @AplicaMovID,
  			   @UltCostoInvTotal = @CostoInvTotal
                  ELSE
                    SELECT @UltCostoInvTotal = @UltCostoInvTotal + @CostoInvTotal*/

--COMENTARIO_0005                
                  /*SELECT @Costo = @ArtCosto * @ArtFactor
                  IF @CostosImpuestoIncluido = 1
                    SELECT @Costo = @Costo - ROUND(@ImpuestosNetos / @Cantidad, @RedondeoMonetarios)*/
                    

--COMENTARIO_0006
                    /*  Cancelar Parcial, esto funciona bien en el movimiento, pero el problema es que en la rutina de 
                        spInvAfectarUnidades, esta desreservando primero.

                    SELECT @CantidadPendiente = @CantidadPendiente - @Cantidad
                    IF @CantidadPendiente < 0 
                    BEGIN
                      SELECT @Cantidad = -@CantidadPendiente, @CantidadPendiente = 0.0
  	  	      SELECT @CantidadReservada = @CantidadReservada - @Cantidad
                      IF @CantidadReservada < 0 
                        SELECT @CantidadPendiente = @CantidadPendiente + @CantidadReservada, @CantidadReservada = 0.0
                    END*/

--COMENTARIO_0007
                /*IF @Modulo = 'VTAS' AND @Accion = 'CANCELAR' AND @Base <> 'TODO' 
                BEGIN
                  IF (SELECT CantidadCancelada FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub) = @CantidadOriginal
                    UPDATE VentaDAgente SET Estado = 'Cancelada' WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
                END*/

/*                IF @Accion = 'CANCELAR' AND @Base <> 'TODO'
                BEGIN
                  IF @Modulo = 'VTAS' UPDATE VentaD  SET CantidadCancelada = ISNULL(CantidadCancelada, 0.0) + @Cantidad WHERE CURRENT OF crVentaDetalle ELSE
                  IF @Modulo = 'INV'  UPDATE InvD    SET CantidadCancelada = ISNULL(CantidadCancelada, 0.0) + @Cantidad WHERE CURRENT OF crInvDetalle ELSE
                  IF @Modulo = 'PROD' UPDATE ProdD   SET CantidadCancelada = ISNULL(CantidadCancelada, 0.0) + @Cantidad WHERE CURRENT OF crProdDetalle ELSE
                  IF @Modulo = 'COMS' UPDATE CompraD SET CantidadCancelada = ISNULL(CantidadCancelada, 0.0) + @Cantidad WHERE CURRENT OF crCompraDetalle 
                  IF @@ERROR <> 0 SELECT @Ok = 1
                END             */

--COMENTARIO_0008
  	        --EXEC xpVentaRetencionCalcular @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @ClienteProv, --MEJORA4648
   		  	--	          @Renglon, @RenglonSub, @Articulo, @Cantidad, @Importe, @ImporteNeto, @Impuestos, @ImpuestosNetos, 
            --                              @ImporteRetencion OUTPUT, @BorrarRetencionCx OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
            
            --MEJORA4648

--COMENTARIO_0009
/*          IF @MovImpuesto = 1
            UPDATE #MovImpuesto 
               SET Importe1 = @Impuesto1Neto * Factor, 
                   Importe2 = @Impuesto2Neto * Factor,
                   Importe3 = @Impuesto3Neto * Factor,
                   SubTotal = @ImporteNeto * Factor
             WHERE Renglon = @Renglon AND RenglonSub = @RenglonSub */

--COMENTARIO_0010
      /*IF @UsaCacheCostos = 1 AND @Ok IS NULL
      BEGIN
        SELECT @UsaCacheCostos = 0
        IF @AlmacenTipo = 'ACTIVOS FIJOS' SELECT @AfectarRama = 'AF' ELSE SELECT @AfectarRama = 'INV'
        EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @AfectarRama, @UltArtMoneda, @UltArtTipoCambio, @UltArticulo, NULL, NULL, NULL,
                     @Modulo, @ID, @Mov, @MovID, @UltEsCargo, @UltCostoInvTotal, NULL, NULL,
                     @FechaAfectacion, @Ejercicio, @Periodo, @UltAplica, @UltAplicaID, 0, 0, 0,
   	  	     @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID
      END*/

--COMENTARIO_0011
/*    IF @MovTipo = 'INV.TMA' AND @Ok IS NULL
      EXEC spInvAfectarTarima @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @FechaAfectacion, @Ejercicio, @Periodo, 
			      @CfgSeriesLotesMayoreo,
		              @Ok OUTPUT, @OkRef OUTPUT*/

--COMENTARIO_0012
    /*  
    IF @MovImpuesto = 1
    BEGIN
      DELETE MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID
      INSERT MovImpuesto (
             Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenFecha,   Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, TipoImpuesto1,     TipoImpuesto2,     TipoImpuesto3,     TipoImpuesto5,     TipoRetencion1,     TipoRetencion2,     TipoRetencion3,     Impuesto1, Impuesto2, Impuesto3, Impuesto5, LoteFijo, Importe1,      Importe2,      Importe3,      Importe5,      SubTotal, ContUso, ContUso2, ContUso3)
      SELECT @Modulo, @ID,      @Modulo,      @ID,            @Concepto,      @FechaEmision, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, TipoImpuesto1,     TipoImpuesto2,     TipoImpuesto3,     TipoImpuesto5,     TipoRetencion1,     TipoRetencion2,     TipoRetencion3,     Impuesto1, Impuesto2, Impuesto3, Impuesto5, LoteFijo, SUM(Importe1), SUM(Importe2), SUM(Importe3), SUM(Importe5), SUM(SubTotal), ContUso, ContUso2, ContUso3
        FROM #MovImpuesto
       GROUP BY Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, TipoImpuesto1,     TipoImpuesto2,     TipoImpuesto3,     TipoImpuesto5,     TipoRetencion1,     TipoRetencion2,     TipoRetencion3,     Impuesto1, Impuesto2, Impuesto3, Impuesto5, LoteFijo, ContUso, ContUso2, ContUso3
       ORDER BY Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, TipoImpuesto1,     TipoImpuesto2,     TipoImpuesto3,     TipoImpuesto5,     TipoRetencion1,     TipoRetencion2,     TipoRetencion3,     Impuesto1, Impuesto2, Impuesto3, Impuesto5, LoteFijo, ContUso, ContUso2, ContUso3
    END
    */

--COMENTARIO_0013
              /*IF @Accion = 'CANCELAR'
              BEGIN
		Falta Buscar los Ajustes y Cancelarlos

              END*/

--COMENTARIO_0014
/*    IF @Ok IN (NULL, 80030) AND @Modulo = 'VTAS' 
    BEGIN
      IF @CfgAC = 1
      BEGIN
        IF (SELECT lc.Uso FROM Venta v JOIN LC ON lc.LineaCredito = v.LineaCredito WHERE v.ID = @ID) = 'Arrendamiento'
          EXEC spTablaArrendamiento @Modulo, @ID, @Usuario, 1, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT, @Accion = @Accion
      END
    END
*/

/*  IF @WMS = 1 AND (SELECT WMS FROM Alm WHERE Almacen = @Almacen) = 1
    BEGIN
      SELECT @WMSMov = NULL
      SELECT @WMSMov = NULLIF(RTRIM(WMSMov), '') FROM CfgWMSMov WHERE Modulo = @Modulo AND Mov = @Mov
      IF @WMSMov IS NOT NULL 
        EXEC spWMSGenerar @Empresa, @Sucursal, @Usuario, @Accion, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Almacen, @WMSMov, @Ok OUTPUT, @OkRef OUTPUT
    END
*/
--COMENTARIO_0015
--  ----REQ12615 WMS
  --  IF @WMS = 1 AND EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND WMS = 1) AND @Accion IN ('AFECTAR', 'CANCELAR', 'RESERVARPARCIAL') AND @OrigenTipo <> 'TMA' AND @Ok IS NULL
  --  BEGIN
  --    SELECT @GenerarOrden = 0  	
  --    IF EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND GenerarOrdenEntarimado = 1) AND 
  --       EXISTS(SELECT * FROM AlmOrdenEntarimadoMov WHERE Almacen = @Almacen AND Modulo = @Modulo AND Mov = @Mov)
  --      EXEC spGenerarOrdenEntarimado @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @Almacen, @Ok OUTPUT, @OkRef OUTPUT

  --    IF EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND (GenerarOrdenAcomodoRecibo = 1 OR GenerarSolAcomodoRecibo = 1)) AND 
  --       EXISTS(SELECT * FROM AlmOrdenAcomodoReciboMov WHERE Almacen = @Almacen AND Modulo = @Modulo AND Mov = @Mov)
  --    BEGIN
  --    	IF EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND GenerarOrdenAcomodoRecibo = 1) SELECT @GenerarOrden = 1
  --      EXEC spGenerarOrdenTarimaAcomodo 'RECIBO', @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @FechaEmision, @Proyecto, @Almacen, @Ok OUTPUT, @OkRef OUTPUT, @GenerarOrden = @GenerarOrden
  --    END

  --    IF EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND (GenerarOrdenAcomodoSurtido = 1 OR GenerarSolAcomodoSurtido = 1)) AND 
  --       EXISTS(SELECT * FROM AlmOrdenAcomodoSurtidoMov WHERE Almacen = @Almacen AND Modulo = @Modulo AND Mov = @Mov)
  --    BEGIN
  --    	IF EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen AND GenerarOrdenAcomodoSurtido = 1) SELECT @GenerarOrden = 1
  --      EXEC spGenerarOrdenTarimaAcomodo 'REABASTECIMIENTO', @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @MovTipo, @FechaEmision, @Proyecto, @Almacen, @Ok OUTPUT, @OkRef OUTPUT, @GenerarOrden = @GenerarOrden
  --    END
  --  END

/**************** spCancelarFacturaOtroMes ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCancelarFacturaOtroMes') and type = 'P') drop procedure dbo.spCancelarFacturaOtroMes
GO
CREATE PROCEDURE spCancelarFacturaOtroMes
		   @Sucursal		int,
    		   @Modulo	      	char(5),
                   @ID                  int,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @MovMoneda		char(10),
		   @MovTipoCambio	float,
		   @Empresa		char(5),
		   @Usuario		char(10),
		   @FechaRegistro	datetime,

		   @CancelacionMov	char(20) 	OUTPUT, 
		   @CancelacionMovID	varchar(20)	OUTPUT,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CxID	   		int,
    @CxMov			char(20),
    @CxMovID			varchar(20),
    @Concepto			varchar(50),
    @CancelacionID 		int,
    @IDGenerar     		int,
    @ContID        		int,
    @VolverAfectar 		bit,
    @CxcAplicacion		char(20),
    @GenerarMov 		char(20), 
    @GenerarMovID		varchar(20),
    @Importe			money,
    @FormaEnvio			varchar(50),
    @Ejercicio	      		int,
    @Periodo	      		int,
    @CfgVentaSurtirDemas	bit,
    @CfgCompraRecibirDemas	bit,
    @CfgTransferirDemas		bit,
    @CfgBackOrders		bit,
    @CfgContX			bit,
    @CfgContXGenerar		char(20),
    @CfgEmbarcar		bit,
    @CfgImpInc			bit,
    @CfgPrecioMoneda		bit,
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgCancelarFacturaReservarPedido bit,
    @CfgCancelarFacturaFecha	varchar(20),
    @CfgCancelarFacturaFisicamente bit,
    @AplicaNC			bit,
    @FechaCancelacion		datetime,
    @EstatusNuevo               varchar(15)

  IF @MovTipo NOT IN ('VTAS.F','VTAS.FAR') SELECT @Ok = 30110
  IF EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND BloquearCancelarFactura = 1)
    SELECT @Ok = 20995

  EXEC spMovTipo @Modulo, @Mov, @FechaRegistro, @Empresa, 'CONCLUIDO', @Concepto OUTPUT, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  SELECT @FormaEnvio = FormaEnvio FROM Venta WHERE ID = @ID

  SELECT @CxID = NULL, @AplicaNC = 0
  SELECT @CxID = ID, @CxMov = Mov, @CxMovID = MovID 
    FROM Cxc 
   WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus = 'PENDIENTE'
  IF @CxID IS NOT NULL SELECT @AplicaNC = 1

  SELECT @CfgVentaSurtirDemas          = VentaSurtirDemas,
         @CfgTransferirDemas	       = TransferirDemas,
         @CfgBackOrders	       	       = BackOrders,
         @CfgImpInc		       = VentaPreciosImpuestoIncluido,
         @CfgPrecioMoneda	       = VentaPrecioMoneda,
         @CfgCancelarFacturaReservarPedido = CancelarFacturaReservarPedido,
         @CfgCancelarFacturaFecha      = CancelarFacturaFecha,
         @CfgCancelarFacturaFisicamente= ISNULL(CancelarFacturaFisicamente, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa 

  SELECT @CfgCompraRecibirDemas  	= CompraRecibirDemas,
         @CfgMultiUnidades       	= MultiUnidades,
 	 @CfgMultiUnidadesNivel  	= ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa 

  SELECT @CfgContX	     = ContX
    FROM EmpresaGral
   WHERE Empresa = @Empresa 

  IF @CfgContX = 1
    SELECT @CfgContXGenerar = ISNULL(UPPER(RTRIM(ContXGenerar)), 'NO')
      FROM EmpresaCfgModulo
     WHERE Empresa = @Empresa 
       AND Modulo  = @Modulo

  IF /*@CxID IS NULL OR */@CfgCancelarFacturaFisicamente = 0 AND EXISTS(SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND OModulo = 'CXC' AND OID = @CxID AND DModulo = 'CXC')
    SELECT @Ok = 60060, @OkRef = RTRIM(@CxMov)+' '+LTRIM(Convert(Char, @CxMovID))

  IF @Ok IS NOT NULL RETURN

  IF @FormaEnvio IS NOT NULL AND EXISTS(SELECT * FROM EmpresaCfgMovEsp WHERE Empresa = @Empresa AND Asunto = 'EMB' AND Modulo = @Modulo AND Mov = @Mov)
  BEGIN
    SELECT @CfgEmbarcar = Embarcar FROM FormaEnvio WHERE FormaEnvio = @FormaEnvio
  END

  SELECT @CancelacionMov        = CASE WHEN @Mov = AutoRecaudacion THEN AutoCancelacionRecaudacion ELSE VentaCancelacionFactura END,
         @CxcAplicacion         = CxcAplicacion
    FROM EmpresaCfgMov 
   WHERE Empresa = @Empresa

  BEGIN TRANSACTION
    IF UPPER(@CfgCancelarFacturaFecha) = 'FECHA EMISION' 
      SELECT @FechaCancelacion = FechaEmision FROM Venta WHERE ID = @ID
    ELSE
      SELECT @FechaCancelacion = @FechaRegistro

    EXEC @CancelacionID = spMovCopiar @Sucursal, @Modulo, @ID, @Usuario, @FechaCancelacion, 1, 0
    IF @CancelacionID IS NOT NULL
    BEGIN
      UPDATE Venta 
         SET Mov = @CancelacionMov,
	     Moneda = @MovMoneda,
	     TipoCambio = @MovTipoCambio,
             Referencia = '('+RTRIM(@Mov)+' '+LTRIM(CONVERT(char, @MovID))+')',
             OrigenTipo = 'VTAS',
             Origen     = @Mov,
             OrigenID   = @MovID            
       WHERE ID = @CancelacionID
      IF @@ERROR <> 0 SELECT @Ok = 1
      EXEC spInv @CancelacionID, @Modulo, 'AFECTAR', 'TODO', @FechaCancelacion, NULL, @Usuario, 1, 0, NULL,
                 @CancelacionMov OUTPUT, @CancelacionMovID OUTPUT, @IDGenerar OUTPUT, @ContID OUTPUT, 
                 @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT, @EsCancelacionFactura = 1
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL

      IF @Ok IS NULL AND @CfgCancelarFacturaReservarPedido = 1
      BEGIN
        EXEC spInvMatar @Sucursal, @ID, 'CANCELAR', 'TODO', @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo,
			'CONCLUIDO', 'CANCELADO', @FechaCancelacion, @FechaCancelacion, @FechaCancelacion, @Ejercicio, @Periodo, 0, 'NORMAL', 'NORMAL',
			@CfgVentaSurtirDemas, @CfgCompraRecibirDemas, @CfgTransferirDemas, @CfgBackOrders, @CfgContX, @CfgContXGenerar, @CfgEmbarcar, @CfgImpInc, @CfgMultiUnidades, @CfgMultiUnidadesNivel,
                       	@Ok OUTPUT, @OkRef OUTPUT, 
			@CfgPrecioMoneda = @CfgPrecioMoneda
        IF @Ok IS NULL
          EXEC spCancelarFacturaReservarPedido @ID, @Usuario, @FechaCancelacion, @Ok OUTPUT, @OkRef OUTPUT
      END
    END

  IF @Ok IS NULL 
  BEGIN
    IF @CfgCancelarFacturaFisicamente = 1
      UPDATE Venta SET CancelacionID = @CancelacionID, FechaCancelacion = @FechaRegistro, Estatus = 'CANCELADO' WHERE ID IN (@ID, @CancelacionID)
    ELSE
      UPDATE Venta SET CancelacionID = @CancelacionID WHERE ID IN (@ID, @CancelacionID)

    EXEC xpCancelarFacturaOtroMes @ID, @CancelacionID, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION
    
  IF @Ok IS NULL
  BEGIN
    SELECT @EstatusNuevo = Estatus FROM Venta WHERE ID = @CancelacionID
    EXEC spCFDAfectarSinMovFinal  @Empresa, @Modulo, @CancelacionMov, @CancelacionMovID, @CancelacionID, @EstatusNuevo, NULL, @Ok, @OkRef 
  END    

  IF @AplicaNC = 1 AND @Ok IS NULL
  BEGIN
    SELECT @CxID = NULL
    SELECT @CxID = DID
      FROM Movflujo 
     WHERE Cancelado = 0 AND Empresa = @Empresa AND OModulo = @Modulo AND OID = @CancelacionID AND DModulo = 'CXC'

    IF @CxID IS NOT NULL
    BEGIN
      EXEC spCx @CxID, 'CXC', 'GENERAR', 'TODO', @FechaCancelacion, @CxcAplicacion, @Usuario, 0, 0,
                @GenerarMov OUTPUT, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, 
                @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL

      IF @Ok IS NULL
      BEGIN
        SELECT @Importe = Importe FROM Cxc WHERE ID = @IDGenerar
        INSERT CxcD (Sucursal, ID, Renglon, RenglonSub, Aplica, AplicaID, Importe)
             VALUES (@Sucursal, @IDGenerar, 2048, 0, @Mov, @MovID, @Importe)
        EXEC spCx @IDGenerar, 'CXC', 'AFECTAR', 'TODO', @FechaCancelacion, NULL, @Usuario, 0, 0,
                  @GenerarMov OUTPUT, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, 
                  @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL

        -- Si manda algun error que no lo aplique y que cancele lo que hizo
        IF @Ok IS NOT NULL
        BEGIN
          SELECT @Ok = NULL, @OkRef = NULL
          IF @GenerarMovID IS NULL 
            DELETE Cxc WHERE ID = @IDGenerar
          ELSE
            EXEC spCx @IDGenerar, 'CXC', 'CANCELAR', 'TODO', @FechaCancelacion, NULL, @Usuario, 0, 0,
                      @GenerarMov OUTPUT, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, 
                      @Ok OUTPUT, @OkRef OUTPUT
        END
      END
    END
  END
END
GO


/**************** spInsertarJuegoOmision ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInsertarJuegoOmision') and type = 'P') drop procedure dbo.spInsertarJuegoOmision
GO
CREATE PROCEDURE spInsertarJuegoOmision
			@Empresa		char(5),
			@Sucursal		int,
                   	@ID			int,
        		@Articulo		char(20), 
			@Cantidad		float,
			@Almacen		char(10), 
			@FechaRequerida		datetime, 
			@MovMoneda		char(10), 
			@MovTipoCambio		float,
			@Renglon		float	OUTPUT, 
			@RenglonID		float	OUTPUT, 
			@AutoLocalidad		char(5) = NULL,
			@Modulo			char(5) = 'VTAS',
			@IDPOS			varchar(50) = NULL,
			@Estacion               int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Opcion			varchar(20),
    @CantidadD			float,
    @CantidadInventario         float,
    @PrecioIndependiente	bit, 
    @ListaPreciosEsp 		varchar(50),
    @Unidad			varchar(50),
    @Precio			float,
    @CfgMultiUnidades	        bit,
    @CfgMultiUnidadesNivel      char(20),
    @CfgInvRegistrarPrecios     bit,
    @ZonaImpuesto		varchar(50),
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @FechaEmision		datetime,
    @Contacto			varchar(10),
    @EnviarA			int,
    @Mov			varchar(20),
    @Juego                      varchar(10),
    @SubCuenta                  varchar(50),
    @Factor                     float  

  SELECT @ZonaImpuesto = NULL
  IF @Modulo = 'VTAS' SELECT @Mov = Mov, @ZonaImpuesto = ZonaImpuesto, @FechaEmision = FechaEmision, @Contacto = Cliente, @EnviarA = EnviarA FROM Venta  WHERE ID = @ID ELSE
  IF @Modulo = 'POS' SELECT @Mov = pl.Mov, @ZonaImpuesto = ISNULL(u.DefZonaImpuesto,c.ZonaImpuesto), @FechaEmision = pl.FechaEmision, @Contacto = pl.Cliente, @EnviarA = pl.EnviarA 
  FROM POSL pl JOIN Usuario u  ON pl.Usuario = u.Usuario JOIN Cte c ON pl.Cliente = c.Cliente
  WHERE pl.ID = @IDPOS ELSE
  IF @Modulo = 'COMS' SELECT @Mov = Mov, @ZonaImpuesto = ZonaImpuesto, @FechaEmision = FechaEmision, @Contacto = Proveedor FROM Compra WHERE ID = @ID 

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'),
         @CfgInvRegistrarPrecios = ISNULL(InvRegistrarPrecios, 0) 
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  DECLARE crJuegoOmision CURSOR FOR
   SELECT j.Opcion, j.Cantidad*@Cantidad, CONVERT(bit, j.PrecioIndependiente), NULLIF(RTRIM(j.ListaPreciosEsp), ''), a.Unidad, a.Impuesto1, a.Impuesto2, a.Impuesto3, j.Juego, j.SubCuenta
     FROM Art a, ArtJuegoOmision j
    WHERE j.Articulo = @Articulo AND j.Opcion = a.Articulo

   OPEN crJuegoOmision
   FETCH NEXT FROM crJuegoOmision INTO @Opcion, @CantidadD, @PrecioIndependiente, @ListaPreciosEsp, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Juego, @SubCuenta
   WHILE @@FETCH_STATUS <> -1 
   BEGIN
     IF @@FETCH_STATUS <> -2 
     BEGIN
       SELECT @Renglon   = @Renglon + 2048.0,
              --@RenglonID = @RenglonID + 1,
	      @Precio    = NULL

       IF @Modulo IN ('COMS', 'VTAS','POS')
       BEGIN
         IF @PrecioIndependiente = 1
         EXEC spPCGet @Sucursal, @Empresa, @Opcion, NULL, @Unidad, @MovMoneda, @MovTipoCambio, @ListaPreciosEsp, @Precio OUTPUT
         EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
         EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
         EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
         EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Contacto, @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
         SELECT @Factor =  dbo.fnArtUnidadFactor(@Empresa, @Articulo,@Unidad)
       END

       EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CantidadD, @CantidadInventario OUTPUT

       IF @Modulo = 'VTAS'
         INSERT VentaD (ID,  Renglon,  RenglonID,  RenglonTipo,  Articulo, Cantidad,   CantidadInventario,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,          Precio,  AutoLocalidad,  Almacen,  FechaRequerida) 
                VALUES (@ID, @Renglon, @RenglonID, 'C',          @Opcion,  @CantidadD, @CantidadInventario, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3*@Factor, @Precio, @AutoLocalidad, @Almacen, @FechaRequerida)
       ELSE
       IF @Modulo = 'INV'
       BEGIN
         IF @CfgInvRegistrarPrecios = 0 SELECT @Precio = NULL
         INSERT InvD (ID,  Renglon,  RenglonID,  RenglonTipo,  Articulo, Cantidad,   CantidadInventario,  Unidad,  Almacen,  FechaRequerida, Precio) 
              VALUES (@ID, @Renglon, @RenglonID, 'C',          @Opcion,  @CantidadD, @CantidadInventario, @Unidad, @Almacen, @FechaRequerida, @Precio)
       END ELSE
       IF @Modulo = 'COMS'
         INSERT CompraD (ID,  Renglon,  RenglonID,  RenglonTipo,  Articulo, Cantidad,   CantidadInventario,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,          Almacen,  FechaRequerida) 
                 VALUES (@ID, @Renglon, @RenglonID, 'C',          @Opcion,  @CantidadD, @CantidadInventario, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3*@Factor, @Almacen, @FechaRequerida)
       ELSE
       IF @Modulo = 'PROD'
         INSERT ProdD (ID,  Renglon,  RenglonID,  RenglonTipo,  Articulo, Cantidad,   CantidadInventario,  Unidad,  Almacen) 
               VALUES (@ID, @Renglon, @RenglonID, 'C',          @Opcion,  @CantidadD, @CantidadInventario, @Unidad, @Almacen)
       ELSE
--REQ 13393 POS       
       IF @Modulo = 'POS'
       BEGIN

        
         INSERT POSArtJuegoComponente(Estacion,  RID, RenglonID,  Articulo,  ArtSubCuenta,   Juego,   Componente,    Opcion,     SubCuenta, Opcional, Cantidad, Recalcular, CantidadComponente)
         SELECT                       @Estacion, @IDPOS, @RenglonID, @Articulo,  CASE WHEN NULLIF(@SubCuenta,'') IS NOT NULL THEN @Opcion+' ('+@SubCuenta+')' ELSE @Opcion END , @Juego, j.Descripcion, @Opcion, @SubCuenta, ISNULL(j.Opcional,0), @Cantidad, 0,@CantidadD
           FROM ArtJuego j  JOIN ArtJuegoD d ON j.Articulo = d.Articulo AND j.Juego = d.Juego 
           WHERE  j.Articulo = @Articulo AND j.Juego = @Juego AND  d.Opcion = @Opcion
         GROUP BY   j.Descripcion, j.Opcional
         
         IF EXISTS(SELECT * FROM POSLVenta WHERE ID = @IDPOS AND Articulo = @Articulo)
         BEGIN
           SELECT @RenglonID = RenglonID FROM POSLVenta WHERE ID = @IDPOS AND Articulo = @Articulo
           UPDATE POSArtJuegoComponente SET RenglonID = @RenglonID WHERE Estacion = @Estacion AND Articulo = @Articulo
         END  
    
       END                 
      
     END
     
     FETCH NEXT FROM crJuegoOmision INTO @Opcion, @CantidadD, @PrecioIndependiente, @ListaPreciosEsp, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Juego, @SubCuenta
   END
   CLOSE crJuegoOmision
   DEALLOCATE crJuegoOmision

  RETURN		
END
GO

/**************** spGenerarServicioTipo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarServicioTipo') and type = 'P') drop procedure dbo.spGenerarServicioTipo
GO
CREATE PROCEDURE spGenerarServicioTipo
                   	@ID			int,
			@Empresa		char(5),
			@Sucursal		int,
			@Almacen		char(10),
			@ListaPreciosEsp	varchar(50),
			@ServicioTipo		varchar(50),
			@MovMoneda		char(10),
			@MovTipoCambio		float,
			@FechaRequerida		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok			int,
    @OkRef		varchar(255),
    @Renglon		float,
    @RenglonID		int,
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Precio		float,
    @Cantidad		float,
    @Unidad		varchar(50),
    @ArtTipo		varchar(20),
    @RenglonTipo	char(1),
    @Impuesto1		float,
    @Impuesto2		float,
    @Impuesto3		money,
    @ZonaImpuesto	varchar(50),
    @ListaPrecios	varchar(50),
    @FechaEmision	datetime,
    @Contacto		varchar(10),
    @EnviarA		int,
    @Mov		varchar(20),
    @Factor             float 

  SELECT @Renglon = 0.0, @RenglonID = 0
  DELETE VentaD WHERE ID = @ID

  SELECT @Mov = Mov, @ZonaImpuesto = ZonaImpuesto, @FechaEmision = FechaEmision, @Contacto = Cliente, @EnviarA = EnviarA
    FROM Venta 
   WHERE ID = @ID

  DECLARE crPlantilla CURSOR FOR
  SELECT p.Articulo, p.SubCuenta, p.Cantidad, ISNULL(NULLIF(RTRIM(p.AlmacenEsp), ''), @Almacen), ISNULL(NULLIF(RTRIM(p.ListaPreciosEsp), ''), @ListaPreciosEsp), a.Unidad, a.Tipo, a.Impuesto1, a.Impuesto2, a.Impuesto3
    FROM ServicioTipoPlantilla p, Art a
   WHERE p.Tipo = @ServicioTipo AND p.Articulo = a.Articulo
   ORDER BY Orden

  OPEN crPlantilla
  FETCH NEXT FROM crPlantilla INTO @Articulo, @SubCuenta, @Cantidad, @Almacen, @ListaPrecios, @Unidad, @ArtTipo, @Impuesto1, @Impuesto2, @Impuesto3 
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @Renglon   = @Renglon + 2048.0,
             @RenglonID = @RenglonID + 1,
             @Precio    = NULL

      EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
      EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @MovMoneda, @MovTipoCambio, @ListaPrecios, @Precio OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
      EXEC spTipoImpuesto 'VTAS', @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Contacto, @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
      SELECT @Factor =  dbo.fnArtUnidadFactor(@Empresa, @Articulo,@Unidad)
      INSERT VentaD (ID,  Renglon,  RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Cantidad,  Unidad,  Precio,  Almacen,  FechaRequerida,  Impuesto1,  Impuesto2,  Impuesto3) 
             VALUES (@ID, @Renglon, @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Cantidad, @Unidad, @Precio, @Almacen, @FechaRequerida, @Impuesto1, @Impuesto2, @Impuesto3*@Factor)

      IF UPPER(@ArtTipo) = 'JUEGO'
        EXEC spInsertarJuegoOmision @Empresa, @Sucursal, @ID, @Articulo, @Cantidad, @Almacen, @FechaRequerida, @MovMoneda, @MovTipoCambio, @Renglon OUTPUT, @RenglonID OUTPUT
    END
    FETCH NEXT FROM crPlantilla INTO @Articulo, @SubCuenta, @Cantidad, @Almacen, @ListaPrecios, @Unidad, @ArtTipo, @Impuesto1, @Impuesto2, @Impuesto3 
  END
  CLOSE crPlantilla
  DEALLOCATE crPlantilla

  UPDATE Venta SET RenglonID = @RenglonID WHERE ID = @ID
  RETURN		
END
GO

/**************** spGenerarMatrizServicio ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarMatrizServicio') and type = 'P') drop procedure dbo.spGenerarMatrizServicio
GO
CREATE PROCEDURE spGenerarMatrizServicio
			@Estacion	int,
                   	@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok			int,
    @OkRef		varchar(255),
    @Renglon		float,
    @RenglonID		int,
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Precio		float,
    @Cantidad		float,
    @Unidad		varchar(50),
    @ArtTipo		varchar(20),
    @RenglonTipo	char(1),
    @Impuesto1		float,
    @Impuesto2		float,
    @Impuesto3		money,
    @ZonaImpuesto	varchar(50),
    @Empresa		char(5),
    @Sucursal		int,
    @Almacen		char(10),
    @ListaPrecios	varchar(50),
    @ListaPreciosEsp	varchar(50),
    @ServicioTipo	varchar(50),
    @MovMoneda		char(10),
    @MovTipoCambio	float,
    @FechaRequerida	datetime,
    @FechaEmision	datetime,
    @Contacto		varchar(10),
    @EnviarA		int,
    @Mov		varchar(20),
    @Factor             float 

  SELECT @Renglon = 0.0, @RenglonID = 0
  DELETE VentaD WHERE ID = @ID

  SELECT @Empresa = Empresa,
	 @Sucursal = Sucursal,
 	 @Almacen = Almacen,
	 @ListaPrecios = ListaPreciosEsp,
 	 @MovMoneda = Moneda,
	 @MovTipoCambio = TipoCambio,
	 @FechaRequerida = FechaRequerida,
         @ZonaImpuesto = ZonaImpuesto,
         @FechaEmision = FechaEmision, @Contacto = Cliente, @EnviarA = EnviarA,
         @Mov = Mov
    FROM Venta 
   WHERE ID = @ID

  DECLARE crServicioMatriz CURSOR FOR
  SELECT m.Articulo, m.SubCuenta, ISNULL(NULLIF(m.Cantidad, 0.0), 1.0), ISNULL(m.Unidad, a.Unidad), a.Tipo, a.Impuesto1, a.Impuesto2, a.Impuesto3, NULLIF(m.PrecioEsp, 0.0), NULLIF(RTRIM(m.ListaPreciosEsp), '')
    FROM ServicioMatriz m, Art a, ListaID l
   WHERE m.ID = l.ID AND l.Estacion = @Estacion AND a.Articulo = m.Articulo
   ORDER BY m.ID

  OPEN crServicioMatriz
  FETCH NEXT FROM crServicioMatriz INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @ArtTipo, @Impuesto1, @Impuesto2, @Impuesto3, @Precio, @ListaPreciosEsp
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @Renglon   = @Renglon + 2048.0,
             @RenglonID = @RenglonID + 1

      EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
      IF @Precio IS NULL
      BEGIN
        IF @ListaPreciosEsp IS NOT NULL
          EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @MovMoneda, @MovTipoCambio, @ListaPreciosEsp, @Precio OUTPUT
        ELSE
          EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @MovMoneda, @MovTipoCambio, @ListaPrecios, @Precio OUTPUT
      END
      EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
      EXEC spTipoImpuesto 'VTAS', @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Contacto, @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
      SELECT @Factor =  dbo.fnArtUnidadFactor(@Empresa, @Articulo,@Unidad)
      INSERT VentaD (ID,  Renglon,  RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Cantidad,  Unidad,  Precio,  Almacen,  FechaRequerida,  Impuesto1,  Impuesto2,  Impuesto3) 
             VALUES (@ID, @Renglon, @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Cantidad, @Unidad, @Precio, @Almacen, @FechaRequerida, @Impuesto1, @Impuesto2, @Impuesto3*@Factor)

      IF UPPER(@ArtTipo) = 'JUEGO'
        EXEC spInsertarJuegoOmision @Empresa, @Sucursal, @ID, @Articulo, @Cantidad, @Almacen, @FechaRequerida, @MovMoneda, @MovTipoCambio, @Renglon OUTPUT, @RenglonID OUTPUT
    END
    FETCH NEXT FROM crServicioMatriz INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @ArtTipo, @Impuesto1, @Impuesto2, @Impuesto3, @Precio, @ListaPreciosEsp
  END
  CLOSE crServicioMatriz
  DEALLOCATE crServicioMatriz

  UPDATE Venta SET RenglonID = @RenglonID WHERE ID = @ID
  DELETE ListaID WHERE Estacion = @Estacion
  RETURN		
END
GO

/**************** spAnexosAlFacturar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAnexosAlFacturar') and type = 'P') drop procedure dbo.spAnexosAlFacturar
GO
CREATE PROCEDURE spAnexosAlFacturar
                   @ID          		int,
    		   @CfgMultiUnidades		bit,
    		   @CfgMultiUnidadesNivel	char(20),
		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon		float, 
    @RenglonSub		int, 
    @RenglonID		int, 
    @Empresa		char(5),
    @Sucursal		int,
    @Moneda		char(10),
    @TipoCambio		float,
    @ZonaImpuesto	varchar(50),  
    @Articulo		char(20), 
    @Cantidad		float,
    @Unidad		varchar(50),
    @NuevaCantidad	float,
    @CantidadInventario	float,
    @Impuesto1		float,
    @Impuesto2		float,
    @Impuesto3		money,
    @Precio		float,
    @ListaPrecios	varchar(50),
    @Anexo		char(20), 
    @AnexoSubCuenta	varchar(50), 
    @AnexoTipoCantidad	varchar(20),
    @AnexoCantidad	float, 
    @AnexoUnidad	varchar(50),
    @AnexoTipoPrecio	varchar(20),
    @AnexoPrecio	float,
    @ArtTipo		varchar(20),
    @RenglonTipo	char(1),
    @Almacen		char(10),
    @FechaRequerida	datetime,
    @FechaEmision	datetime,
    @Contacto		varchar(10),
    @EnviarA		int,
    @Mov		varchar(20),
    @Factor             float 
  BEGIN TRANSACTION
    DELETE VentaD WHERE ID = @ID AND Anexo = 1
    SELECT @Mov = Mov, @ZonaImpuesto = ZonaImpuesto, @Empresa = Empresa, @Sucursal = Sucursal, @Moneda = Moneda, @TipoCambio = TipoCambio, @ListaPrecios = ListaPreciosEsp, 
           @FechaEmision = FechaEmision, @Contacto = Cliente, @EnviarA = EnviarA
      FROM Venta WHERE ID = @ID
    IF EXISTS(SELECT d.ID FROM VentaD d, Art a WHERE d.ID = @ID AND d.Articulo = a.Articulo AND a.AnexosAlFacturar = 1)
    BEGIN
      DECLARE crAnexosAlFacturar CURSOR FOR
      SELECT d.Renglon, d.RenglonID, d.Articulo, d.Cantidad, d.Unidad, d.Almacen, d.FechaRequerida, d.Importe/NULLIF(d.Cantidad, 0)
        FROM VentaDCalc d, Art a 
       WHERE d.ID = @ID AND d.Articulo = a.Articulo AND a.AnexosAlFacturar = 1
    
      OPEN crAnexosAlFacturar
      FETCH NEXT FROM crAnexosAlFacturar INTO @Renglon, @RenglonID, @Articulo, @Cantidad, @Unidad, @Almacen, @FechaRequerida, @Precio
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          DECLARE crArtAnexo CURSOR LOCAL FOR
          SELECT x.Anexo, x.SubCuenta, UPPER(x.TipoCantidad), x.Cantidad, x.Unidad, UPPER(x.TipoPrecio), x.Precio, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Tipo
            FROM ArtAnexo x, Art a
           WHERE x.Articulo = @Articulo AND a.Articulo = x.Articulo AND NULLIF(RTRIM(x.UnidadEspecifica), '') IN (NULL, @Unidad)
    
          OPEN crArtAnexo
          FETCH NEXT FROM crArtAnexo INTO @Anexo, @AnexoSubCuenta, @AnexoTipoCantidad, @AnexoCantidad, @AnexoUnidad, @AnexoTipoPrecio, @AnexoPrecio, @Impuesto1, @Impuesto2, @Impuesto3, @ArtTipo
          WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
          BEGIN
            IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
            BEGIN
              IF NOT EXISTS(SELECT * FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND Articulo = @Anexo)
              BEGIN
                EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
                EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
       	        EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
                EXEC spTipoImpuesto 'VTAS', @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Contacto, @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
       	        
                EXEC spRenglonTipo @ArtTipo, @AnexoSubCuenta, @RenglonTipo OUTPUT
                IF @AnexoTipoCantidad = 'MULTIPLOS'
                  SELECT @NuevaCantidad = @AnexoCantidad * @Cantidad
                IF @AnexoTipoCantidad = '%'
                  SELECT @NuevaCantidad = @Cantidad * (@AnexoCantidad / 100)
                IF @AnexoTipoCantidad = 'ESPECIFICA'
                  SELECT @NuevaCantidad = @AnexoCantidad

                EXEC xpCantidadInventario @Anexo, @AnexoSubCuenta, @AnexoUnidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @NuevaCantidad, @CantidadInventario OUTPUT
                SELECT @RenglonSub = ISNULL(MAX(RenglonSub), 0)+1 FROM VentaD WHERE ID = @ID AND Renglon = @Renglon

                IF @AnexoTipoPrecio = 'NO'
                  SELECT @AnexoPrecio = NULL
                IF @AnexoTipoPrecio = '%'
                  SELECT @AnexoPrecio = @Precio * (@AnexoPrecio / 100)
                IF @AnexoTipoPrecio = 'CORRESPONDA'
                  EXEC spPCGet @Sucursal, @Empresa, @Anexo, @AnexoSubCuenta, @AnexoUnidad, @Moneda, @TipoCambio, @ListaPrecios, @AnexoPrecio OUTPUT
                
                SELECT @Factor =  dbo.fnArtUnidadFactor(@Empresa, @Anexo,@AnexoUnidad)
                INSERT VentaD (ID,  Renglon,  RenglonSub,  RenglonID,  RenglonTipo,  Articulo, SubCuenta,       Precio,       Cantidad,       Unidad,       CantidadInventario,  Impuesto1,  Impuesto2,  Impuesto3,          Almacen,  FechaRequerida) 
                       VALUES (@ID, @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @Anexo,   @AnexoSubCuenta, @AnexoPrecio, @NuevaCantidad, @AnexoUnidad, @CantidadInventario, @Impuesto1, @Impuesto2, @Impuesto3*@Factor, @Almacen, @FechaRequerida)
              END
            END
            FETCH NEXT FROM crArtAnexo INTO @Anexo, @AnexoSubCuenta, @AnexoTipoCantidad, @AnexoCantidad, @AnexoUnidad, @AnexoTipoPrecio, @AnexoPrecio, @Impuesto1, @Impuesto2, @Impuesto3, @ArtTipo
          END
          CLOSE crArtAnexo
          DEALLOCATE crArtAnexo
        END
        FETCH NEXT FROM crAnexosAlFacturar INTO @Renglon, @RenglonID, @Articulo, @Cantidad, @Unidad, @Almacen, @FechaRequerida, @Precio
      END
      CLOSE crAnexosAlFacturar
      DEALLOCATE crAnexosAlFacturar
    END

  IF @OK IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  RETURN		
END
GO

/**************** spInvEntradaProductoGenerarConsumoMaterial ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvEntradaProductoGenerarConsumoMaterial') and type = 'P') drop procedure dbo.spInvEntradaProductoGenerarConsumoMaterial
GO
CREATE PROCEDURE spInvEntradaProductoGenerarConsumoMaterial
				   @Accion	varchar(20),
				   @Empresa	char(5),
		                   @ID          int,
				   @IDGenerar	int		OUTPUT,
				   @Ok		int		OUTPUT,
				   @OkRef	varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMermaIncluida		bit,
    @CfgDesperdicioIncluido	bit,
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgTipoMerma		char(1),
    @MovGenerar			varchar(20),
    @Articulo			varchar(20),
    @SubCuenta			varchar(50),
    @Cantidad			float,
    @Unidad			varchar(50),
    @Factor			float,
    @SerieLote			varchar(50),
    @Renglon			float,
    @RenglonID 			int

  SELECT @CfgMermaIncluida 	 = ProdMermaIncluida,
         @CfgDesperdicioIncluido = ProdDesperdicioIncluido,
         @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'),
         @CfgTipoMerma		 = ISNULL(ProdTipoMerma, '%')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT @MovGenerar = ProdConsumoMaterial
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @Renglon = 0.0, @RenglonID = 0
  INSERT Inv (
         Empresa, Sucursal, Usuario, Mov,         FechaEmision, Almacen, Concepto, Referencia, Proyecto, Estatus,     OrigenTipo, DocFuente, Moneda, TipoCambio, VerLote)
  SELECT Empresa, Sucursal, Usuario, @MovGenerar, FechaEmision, Almacen, Concepto, Referencia, Proyecto, 'CONFIRMAR', 'INV/EP',   ID,        Moneda, TipoCambio, 1
    FROM Inv
   WHERE ID = @ID
  SELECT @IDGenerar = SCOPE_IDENTITY()
--JGD 21Febrero2011 Solucion Ticket 3581. Se agrego el DISTINCT a la Consulta, esto con el fin de que solo tome un registro cuando un Articulo se repite en otra Partida
  DECLARE crSerieLoteMov CURSOR FOR
   SELECT DISTINCT d.Articulo, d.SubCuenta, d.Unidad, d.Factor, slm.SerieLote, slm.Cantidad
     FROM InvD d 
     JOIN SerieLoteMov slm ON slm.Empresa = @Empresa AND slm.Modulo = 'INV' AND slm.ID = d.ID AND slm.Articulo = d.Articulo AND ISNULL(slm.SubCuenta, '') = ISNULL(d.Subcuenta, '')
    WHERE d.ID = @ID

  OPEN crSerieLoteMov
  FETCH NEXT FROM crSerieLoteMov INTO @Articulo, @SubCuenta, @Unidad, @Factor, @SerieLote, @Cantidad
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC spProdExp @IDGenerar, NULL, @SerieLote, 
  	             @Articulo, @SubCuenta, @Articulo, @SubCuenta, @Cantidad, @Unidad, @Factor, NULL, NULL,
		     @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CfgMermaIncluida, @CfgDesperdicioIncluido, @CfgTipoMerma,
		     NULL, 
                     @Renglon OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @Modulo = 'INV', @RenglonID = @RenglonID OUTPUT

    END
    FETCH NEXT FROM crSerieLoteMov INTO @Articulo, @SubCuenta, @Unidad, @Factor, @SerieLote, @Cantidad
  END
  CLOSE crSerieLoteMov
  DEALLOCATE crSerieLoteMov

  IF @IDGenerar IS NOT NULL SELECT @Ok = 80030
  RETURN
END
GO


/**************** spInvEntradaProductoCancelarConsumoMaterial ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvEntradaProductoCancelarConsumoMaterial') and type = 'P') drop procedure dbo.spInvEntradaProductoCancelarConsumoMaterial
GO
CREATE PROCEDURE spInvEntradaProductoCancelarConsumoMaterial
				   @Accion	varchar(20),
				   @Empresa	char(5),
		                   @ID          int,
				   @Ok		int		OUTPUT,
				   @OkRef	varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CMID	int

  SELECT @CMID = NULL
  SELECT @CMID = MAX(ID) FROM Inv WHERE Empresa = @Empresa AND OrigenTipo = 'INV/EP' AND DocFuente = @ID AND Estatus = 'CONCLUIDO'
  IF @CMID IS NULL 
    SELECT @Ok = 30120, @OkRef = 'Consumo Material'
  ELSE
    EXEC spAfectar 'INV', @CMID, 'CANCELAR', @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  RETURN
END
GO

/**************** spInvConsumoMaterialAfectarEntradaProducto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvConsumoMaterialAfectarEntradaProducto') and type = 'P') drop procedure dbo.spInvConsumoMaterialAfectarEntradaProducto
GO
CREATE PROCEDURE spInvConsumoMaterialAfectarEntradaProducto
				   @Accion	varchar(20),
				   @Empresa	char(5),
				   @Sucursal	int,
		                   @ID          int,
				   @Mov		varchar(20),
				   @MovID	varchar(20),
				   @Ok		int		OUTPUT,
				   @OkRef	varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EPID		int,
    @EPMov		varchar(20),
    @EPMovID		varchar(20),
    @EPEstatus		varchar(20),
    @TotalIndirectos	float,
    @Articulo		varchar(20),
    @SubCuenta		varchar(50),
    @Cantidad		float,
    @Costo		float

  SELECT @EPID = DocFuente FROM Inv WHERE ID = @ID
  SELECT @EPEstatus = Estatus FROM Inv WHERE ID = @EPID
  IF @EPEstatus = 'BORRADOR'
  BEGIN
    SELECT @TotalIndirectos = 0.0
    SELECT @TotalIndirectos = ISNULL(SUM(Porcentaje), 0.0) FROM MovGastoIndirecto WHERE Modulo = 'INV' AND ModuloID = @EPID

    DECLARE crInvD CURSOR FOR
     SELECT Articulo, ISNULL(RTRIM(SubCuenta), ''), NULLIF(SUM(Cantidad), 0.0)
       FROM InvD
      WHERE ID = @EPID
      GROUP BY Articulo, ISNULL(RTRIM(SubCuenta), '')

    OPEN crInvD
    FETCH NEXT FROM crInvD INTO @Articulo, @SubCuenta, @Cantidad
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        SELECT @Costo = NULL
        SELECT @Costo = SUM(Costo*Cantidad)/@Cantidad  --SUM(Costo*Cantidad)/SUM(Cantidad)
          FROM InvD
         WHERE ID = @ID AND Producto = @Articulo AND ISNULL(SubProducto, '') = @SubCuenta
        SELECT @Costo = @Costo * (1+(@TotalIndirectos/100.0))

        EXEC xpInvConsumoMaterialAfectarEntradaProducto @Accion, @Empresa, @Sucursal, @ID, @Mov, @MovID, @Articulo, @SubCuenta, @Cantidad, @Costo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 

        UPDATE InvD 
           SET Costo = @Costo
         WHERE ID = @EPID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta
      END
      FETCH NEXT FROM crInvD INTO @Articulo, @SubCuenta, @Cantidad
    END
    CLOSE crInvD
    DEALLOCATE crInvD
    EXEC spAfectar 'INV', @EPID, 'AFECTAR', 'TODO', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    
    SELECT @EPMov = Mov, @EPMovID = MovID FROM Inv WHERE ID = @EPID
    EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'INV', @EPID, @EPMov, @EPMovID, 'INV', @ID, @Mov, @MovID, @Ok OUTPUT
  END
  RETURN
END
GO



/**************** spInv ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInv') and type = 'P') drop procedure dbo.spInv
GO
CREATE PROCEDURE spInv
                   @ID                  	int,
    		   @Modulo	      		char(5),
		   @Accion			char(20),
		   @Base			char(20),

		   @FechaRegistro		datetime,
		   @GenerarMov			char(20),
		   @Usuario			char(10),
		   @Conexion			bit,
                   @SincroFinal			bit,
		   @AccionEspecial		varchar(20),

    		   @Mov	      			char(20)	OUTPUT,
    		   @MovID            		varchar(20)	OUTPUT,
    		   @IDGenerar			int		OUTPUT,
		   @ContID			int		OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,
		   @VolverAfectar		int = 0		OUTPUT,
		   @EsCancelacionFactura	bit = 0,
                   @FacturacionRapidaAgrupada	bit = 0,
           
		   @Estacion			int = 0 -- REQ12336

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Sucursal			int,
    @SucursalDestino		int,
    @SucursalOrigen		int,
    @SucursalPrincipal		int,
    @SucursalEnLinea		int,
    @EnLinea			bit,
    @PuedeEditar		bit,
    @Empresa	      		char(5),
    @MovUsuario			char(10),
    @MovTipo   			char(20),
    @MovMoneda	      		char(10),    
    @MovTipoCambio	     	float,
    @MovSeguimiento		char(20),
    @SeguimientoMatriz		bit,
    @FechaAfectacion   		datetime,
    @FechaEmision      		datetime,
    @FechaConclusion		datetime,
    @Concepto	      		varchar(50),
    @Proyecto	      		varchar(50),
    @Autorizacion     		char(10),
    @Mensaje			int,
    @Referencia	      		varchar(50),
    @DocFuente	      		int,
    @Observaciones    		varchar(255),
    @Estatus          		char(15),
    @AccionOriginal		char(20),

    @Almacen          		char(10),
    @AlmacenTipo		char(15),
    @AlmacenDestino   		char(10),
    @AlmacenDestinoTipo		char(15),
    @AlmacenTransito		char(10),
    @AlmacenEspecifico		char(10),
    @AlmacenSucursal		int,
    @VoltearAlmacen		bit,
    @Largo			bit,
    @ServicioGarantia		bit,
    @ServicioArticulo		char(20),
    @ServicioSerie		char(20),
    @Condicion			varchar(50),
    @Vencimiento		datetime,
    @FormaEnvio			varchar(50),
    @UEN			int,
    @ZonaImpuesto		varchar(50),

    @ClienteProv		char(10),
    @ClienteProvTipo		char(20),
    @EnviarA			int,
    @Credito			varchar(50),
    @CreditoEspecial		bit,
    @ConCredito			bit,
    @ConLimiteCredito		bit,
    @LimiteCredito		money,
    @ConLimitePedidos		bit,
    @LimitePedidos		money,
    @MonedaCredito		char(10),
    @Dias			int,
    @DiasCredito		int,
    @CondicionesValidas		varchar(255),
    @TipoCambioCredito		float,
    @PedidosParciales		bit,
    @VtasConsignacion		bit,
    @AfectarConsignacion	bit,
    @AfectarVtasMostrador	bit,
    @FacturarVtasMostrador	bit,
    @AlmacenVtasConsignacion	char(10),
    @DescuentoGlobal		float,
    @SobrePrecio		float,
    @Agente			char(10),
    @Departamento		int,
    @ExcluirPlaneacion		bit,
    @AFArticulo			varchar(20),
    @AFSerie			varchar(50),	-- BUG12333
    @CobroIntegrado		bit,
    @CobroIntegradoCxc		bit,
    @CobroIntegradoParcial      bit,
    @CobrarPedido		bit,
    @AnticiposFacturados	money,
    @CancelacionID		int,
    @ServicioPlacas		varchar(20),
    @ServicioKms		int,
    @AutoCorrida		varchar(20),
    @Espacio			varchar(10),
    @AutoKmsActuales		int,
    @Periodicidad		varchar(20),
    @EndosarA			varchar(10),
    @Directo			bit,

    @FechaRequerida		datetime,
    @HoraRequerida		char(5),
    @OrigenTipo			varchar(10),
    @Origen			varchar(20),
    @OrigenID			varchar(20),
    @OrigenMovTipo		varchar(20),

    @Ejercicio	      		int,
    @Periodo	      		int,
    @AlmacenTmp			char(10),
    @GenerarOP			bit,
    --@FechaControl		datetime,

    @CfgAlmacenTransito		char(20),
    @CfgFormaCosteo   		char(20),
    @CfgTipoCosteo    		char(20),
    @CfgCosteoActividades	varchar(20), 
    @CfgCosteoNivelSubCuenta	bit,
    @CfgCosteoMultipleSimultaneo bit,
    @CfgPosiciones		bit,
    @CfgExistenciaAlterna	bit,
    @CfgExistenciaAlternaSerieLote bit,
    @CfgValidarPrecios		char(20),
    @CfgPrecioMinimoSucursal	bit,
    @CfgValidarMargenMinimo	char(20),
    @CfgSeriesLotesMayoreo	bit,
    @CfgSeriesLotesAutoCampo	char(20),
    @CfgSeriesLotesAutoOrden	char(20),
    @CfgCosteoSeries		bit,
    @CfgCosteoLotes		bit,
    @CfgValidarLotesCostoDif	bit,

    @CfgPedidosReservar		bit,
    @CfgPedidosReservarEsp	bit,
    @CfgVentaSurtirDemas	bit,
    @CfgCompraRecibirDemas	bit,
    @CfgCompraRecibirDemasTolerancia float,
    @CfgTransferirDemas		bit,
    @CfgBackOrders		bit,
    @CfgContX			bit,
    @CfgContXGenerar		char(20),
    @CfgContXFacturasPendientes bit, 
    @CfgEmbarcar		bit,
    @CfgImpInc			bit,
    @CfgPrecioMoneda		bit,
    @CfgVentaRedondeoDecimales	int,
    @CfgCompraCostosImpuestoIncluido bit,
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgInvPrestamosGarantias	bit,
    @CfgServiciosRequiereTareas bit,
    @CfgServiciosValidarID	bit, 
    @CfgInvEntradasSinCosto	bit,
    @CfgVentaConfirmarServicios	bit,
    @CfgVentaConfirmarContratos	bit,
    @CfgInvConfirmarSolicitudes	bit,
    @CfgVentaContratosArticulo	char(20),
    @CfgVentaContratosImpuesto	float,
    @CfgVentaChecarCredito	char(20),
    @CfgVentaPedidosDisminuyenCredito bit,
    @CfgVentaBloquearMorosos	char(20),
    @CfgVentaLiquidaIntegral	bit,
    @CfgVentaLiquidaIntegralCxc	bit,
    @CfgFacturaCobroIntegrado	bit,
    @CfgFacturaCobroIntegradoParcial bit,
    @CfgVentaComisionesCobradas bit,	
    @CfgCompraConsignacion	char(20),
    --@CfgAutoConsig		bit,
    @CfgAutorizarRequisiciones	bit,
    @CfgBackOrdersNivel		char(20),
    @CfgCancelarFacturaReservarPedido bit,
    @CfgFacturasPendientes	bit,
    @CfgFacturasPendientesSerieLote bit,
    @CfgLimiteRenFacturas	int,
    @CfgNotasBorrador		bit,
    @CfgInvFisicoConteo		int,
    @CfgAnticiposFacturados	bit,
    @CfgCompraFactorDinamico 	bit,
    @CfgInvFactorDinamico   	bit,
    @CfgProdFactorDinamico  	bit,
    @CfgVentaFactorDinamico 	bit,
    @CfgCompraAutoCargos	bit,
    @CfgVentaAutoBonif		bit,
    @CfgVINAccesorioArt 	bit,
    @CfgVINCostoSumaAccesorios	bit,
    @CfgDecimalesCantidades	int,
    @CfgToleranciaCosto		float,
    @CfgToleranciaCostoInferior	float,
    @CfgToleranciaTipoCosto	char(20),
    @CfgAutoAsignarBackOrders	bit,
    @CfgInvMultiAlmacen		bit,
    @CfgCompraMultiAlmacen	bit,
    @CfgVentaMultiAlmacen	bit,
    @CfgVentaUENDetalle		bit,
    @CfgVentaMultiAgente	bit,
    @CfgVentaMultiDepartamento	bit,
    @CfgVentaAFDetalle		bit,
    @CfgVentaEnviarADetalle	bit,
    @CfgVentaExcluirPlaneacionDetalle bit,
    @CfgVentaDFechaRequerida	bit,
    @CfgVentaDHoraRequerida	bit,
    @CfgFormaPagoRequerida	bit,
    @CfgBloquearNotasNegativas	bit,
    @CfgBloquearFacturacionDirecta	bit,
    @CfgBloquearInvSalidaDirecta	bit,
    @CfgVentaArtAlmacenEspecifico  bit,
    @CfgProdAutoLote		char(20),
    @CfgProdAutoCB		char(20),
    @CfgTipoMerma		char(1),
    @CfgComisionBase		char(20),
    @CfgCompraValidarArtProv	bit,
    @CfgPresupuestosPendientes  bit,
    @CfgAutoAsignarMovSucursalAlmacen bit, 
    @CfgPermitirMovSucursalDiferente  bit,
    @CfgValidarCC		bit,
    @CfgVentaRestringida	bit,
    @CfgLimiteCreditoNivelGrupo bit,
    @CfgLimiteCreditoNivelUEN   bit,
    @CfgRestringirArtBloqueados bit,
    @CfgAutotransportes		bit,
    @CfgCancelarFactura		varchar(20), 
    @CfgAnexosAlFacturar	bit,
    @CfgVentaEndoso		bit,
    @CfgValidarFechaRequerida	bit,
    @CfgRecibirDemasSinLimites	bit,
    @CfgVIN			bit,
        
    @AfectarDetalle             bit,
    @AfectarMatando		bit,
    @AfectarMatandoOpcional	bit,
    @AfectarAlmacenRenglon	bit,
    @AfectarConsecutivo		bit,
    @EstatusNuevo		char(15),
    @EsTransferencia		bit,

    @CteChecarCredito		varchar(20),
    @ChecarCredito		varchar(20),
    @CteBloquearMorosos		varchar(20),
    @BloquearMorosos		varchar(20),
    @IDTransito			int,
    @TransitoSucursal		int,
    @TransitoMov 		char(20), 
    @TransitoMovID 		varchar(20), 
    @TransitoEstatus 		char(15), 

    @Utilizar			bit,
    @UtilizarID			int,
    @UtilizarMov		char(20),
    @UtilizarSerie		char(20),
    @UtilizarMovTipo		char(20),
    @UtilizarMovID		varchar(20),

    @Generar                    bit,
    @GenerarMovID		varchar(20),
    @GenerarSerie		char(20),
    @GenerarAfectado		bit,
    @GenerarCopia		bit,
    @GenerarPoliza		bit,
    @Autorizar			bit,
    @GenerarGasto		bit,
    @InvConteo			int,
    @AnexoID			int,
    @AnexarTodoDetalle		bit,
    @Verificar			bit,
    @CfgCentroCostos2VentaD	bit,
    @CfgCentroCostos3VentaD	bit,	
    @CfgCentroCostos2CompraD	bit,
    @CfgCentroCostos3CompraD	bit,    
    @ContUso2			varchar(20),
    @ContUso3			varchar(20),
    
    @InvVerificarEnConexion bit,
	@cPosicionActual                  varchar(10),
    @cId							  int,
	@cArticulo						  varchar(20),
	@cAlmacen						  varchar(10),
	@cRenglon						  float,
	@cTarima						  varchar(20),
	@Renglon						  float, 
	@RenglonSub						  int,
	@RenglonID						  int,  
	@RenglonTipo					  varchar(1),
	@Almacenc						  varchar(10),  
	@Articulo						  varchar(20),  
	@Costo							  money,  
	@Unidad							  varchar(50),
	@Factor							  float, 
	@CantidadInventario				  float,
	@Sucursalc						  int,
	@SucursalOrigenc				  int,
	@Tarima							  varchar(20),
	@PosicionActual					  varchar(10),
	@PosicionReal					  varchar(10),
	@Articuloc						  varchar(20),
	@Cantidadc						  float,
	@Almacenct                        varchar(10),      
	@cTarimaAlta                      varchar(20),
	/* Bugs 4592,4602,4656,4818 */
	@Renglonc                         float,
	@PosicionActualc	              varchar(10),
    @PosicionRealc	                  varchar(10),
	@TipoA	                          varchar(20),
	@TipoR	                          varchar(20),
	@WMS                              bit, --BUG4012
	--8. Desarrollo de proceso Cross Docking
	@CrossDocking                     bit,
    @Escrossdocking                   varchar(2),
	@PosicionWMS                      varchar(10),
	@DID                              int,
	@posicioncrossdocking             varchar(10), 
	@FechaCaducidad                   datetime, --Bugs 5993, 3786
    @ArticuloFC                       varchar(20),
	@AlmacencFC                       varchar(10),
	-----  BUG 7029
	@CrArtículo						  varchar(20),
	@CrAlmacen						  varchar(20),
	@CrCantidadDisponible			  float,
	@CrCantidadAfectar				  float,
	@CrMov							  varchar(20),
	@IDGenerarSATMA					  INT,
	@IDGenerarOATMA					  INT,
	@IDGenerarATMA					  INT,
	@OrigenWMS						  VARCHAR(20),
	@OrigenIDWMS					  VARCHAR(20),
    @OrigenSubMovTipo                 varchar(20),
	@MovMES							  bit  
    

  -- Inicializar Variables
  SELECT @AfectarDetalle	  = 1,
	 @AfectarMatando          = 0,
	 @AfectarMatandoOpcional  = 1,
	 @AfectarAlmacenRenglon	  = 1,
         @AfectarConsecutivo	  = 0,
	 @EsTransferencia	  = 0,
         @CobroIntegrado	  = 0,
         @CobroIntegradoCxc	  = 0,
         @CobroIntegradoParcial   = 0,
         @CobrarPedido		  = 0,
         @VoltearAlmacen	  = 0,
         @AlmacenEspecifico	  = NULL,
         @CancelacionID	  	  = NULL,
	 @SeguimientoMatriz	  = 0,
	 @SucursalPrincipal	  = NULL,
         @Periodicidad		  = NULL, 
         @EndosarA		  = NULL,

	 @Utilizar		  = 0,
         @UtilizarSerie		  = NULL,

         @Generar		  = 0,
         @GenerarSerie		  = NULL,
	 @GenerarAfectado	  = 0,
	 @GenerarCopia		  = 1,
	 @AnticiposFacturados	  = 0.0, 
	 @AutoCorrida		  = NULL,
         @Espacio		  = NULL,         

         @Autorizar		  = 0,	
         @Mensaje		  = NULL,
  	 @ClienteProvTipo 	  = NULL,
	 @AlmacenDestino	  = NULL,
	 @AlmacenTransito	  = NULL,
	 @Largo			  = 0,
         @EnviarA		  = NULL,
	 @Condicion	 	  = NULL,
         @FormaEnvio		  = NULL,
	 @ClienteProv		  = NULL,
         @ConCredito		  = 0,
    	 @ConLimiteCredito	  = 0,
    	 @LimiteCredito		  = 0.0,
         @LimitePedidos		  = 0.0,
         @DiasCredito		  = NULL,
         @CondicionesValidas	  = NULL,
	 @TipoCambioCredito	  = 1.0,
         @PedidosParciales	  = 0,
	 @VtasConsignacion	  = 0,
         @AfectarConsignacion	  = 0,
         @AfectarVtasMostrador    = 0,
	 @FacturarVtasMostrador	  = 0,
         @ServicioGarantia	  = 0,
         @ServicioArticulo	  = NULL,
	 @ServicioSerie		  = NULL, 
         @ServicioPlacas	  = NULL,
         @ServicioKms		  = NULL,
	 @AlmacenVtasConsignacion = NULL,
	 @DescuentoGlobal	  = 0.0,
	 @SobrePrecio		  = 0.0,
         @Agente		  = NULL,
         @Departamento		  = NULL,
         @ExcluirPlaneacion	  = 0, 
         @AFArticulo		  = NULL,
         @AFSerie		  = NULL,
         @Autorizacion		  = NULL,
         @Mensaje		  = NULL,
	 @GenerarOP		  = 0,
         @IDTransito		  = NULL,
         @SobrePrecio		  = NULL,

	 @CfgContX		    = 0,         
         @CfgContXGenerar	    = 'NO',
         @CfgContXFacturasPendientes= 0,
         @CfgEmbarcar		    = 0,
         @CfgMultiUnidades	    = 0,
	 @CfgMultiUnidadesNivel     = 'UNIDAD',
	 @CfgAutorizarRequisiciones = 0,

	 @FechaRequerida	  = NULL,
         @HoraRequerida		  = NULL,
    	 @OrigenTipo		  = NULL,
    	 @Origen		  = NULL,
    	 @OrigenID		  = NULL,
         @OrigenMovTipo		  = NULL,
         @GenerarGasto		  = 0,
         @AnexoID		  = NULL,
         @AnexarTodoDetalle	  = 0,
         @Verificar		  = 1 

	EXEC spMovInfo @ID,@Modulo,@Empresa=@Empresa OUTPUT,@Mov=@Mov OUTPUT,@Movtipo=@Movtipo OUTPUT, @Estatus=@Estatus OUTPUT

	IF @Modulo = 'INV' AND @MovTipo = 'INV.SOL' AND @Ok IS NULL
		BEGIN
			DECLARE CrVerificaTarima CURSOR FOR
			 SELECT D.Articulo,
					D.Almacen,
			   CASE @BASE WHEN 'Pendiente'
						  THEN SUM(CASE WHEN ISNULL(D.CantidadPendiente,0) <> 0
									    THEN D.CantidadPendiente
									    ELSE
										CASE WHEN ISNULL(D.CantidadInventario,0) = 0 
											 THEN D.Cantidad 
											 ELSE D.CantidadInventario
										END
								   END)
						  WHEN 'Seleccion'
						  THEN SUM(D.CantidadA)
						  WHEN 'Reservado'
						  THEN SUM(D.CantidadReservada)
				END,
				E.MOV
		   FROM InvD D
		   JOIN Inv E ON D.Id = E.Id
		  WHERE E.ID = @ID
	   GROUP BY D.Articulo, D.Almacen, E.Mov
   
   OPEN CrVerificaTarima
   FETCH NEXT FROM CrVerificaTarima INTO @CrArtículo, @CrAlmacen, @CrCantidadAfectar, @CrMov
   
   WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
     SELECT @CrCantidadDisponible = SUM(Disponible)
       FROM ArtDisponibleTarima
      WHERE Articulo = @CrArtículo 
        AND Almacen = @CrAlmacen 
        AND Empresa = @Empresa
        AND ISNULL(Tarima,'') = ''
     
                    IF EXISTS (SELECT * FROM ALMSUGERIRSURTIDOTARIMA WHERE Modulo = 'INV' AND MOV = @CrMov AND Almacen = @CrAlmacen)
                    BEGIN
                      IF @CrCantidadDisponible < @CrCantidadAfectar
      SELECT @Ok = 10340, @OkRef = 'La Cantidad a Entarimar es Mayor a la Disponible'
                    END
     
     FETCH NEXT FROM CrVerificaTarima INTO @CrArtículo, @CrAlmacen, @CrCantidadAfectar, @CrMov
    END
   
   CLOSE CrVerificaTarima
   DEALLOCATE CrVerificaTarima
 END
 
   --BUG4012
   SELECT @WMS = NULLIF(WMS,'') FROM EmpresaGral WHERE Empresa = @Empresa 
   IF @Modulo ='INV' AND @WMS = 1 AND @Accion = 'AFECTAR' AND @MovTipo = 'INV.IF'
   BEGIN
	DECLARE crInvWMS CURSOR FOR
		SELECT Id.PosicionActual, Id.Id, Id.Articulo, I.Almacen, Id.Renglon
		  FROM INVD AS ID
		  JOIN INV AS I ON I.ID = ID.Id
		 WHERE I.ID = @ID

		OPEN crInvWMS
		FETCH NEXT FROM crInvWMS INTO @cPosicionActual, @cId, @cArticulo, @cAlmacen, @cRenglon
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			DECLARE crInvTarWMS CURSOR FOR
				SELECT
					   Tarima.Tarima				
				  FROM Tarima
				  LEFT OUTER JOIN AlmPos ON Tarima.Almacen = AlmPos.Almacen AND Tarima.Posicion = AlmPos.Posicion
				  LEFT JOIN ArtDisponibleTarima ON Tarima.Tarima = ArtDisponibleTarima.Tarima
				 WHERE Tarima.Estatus = 'ALTA' AND Tarima.Almacen = @cAlmacen AND ArtDisponibleTarima.Articulo = (SELECT ISNULL(NULLIF(CONVERT(varchar(20),@cArticulo),''),ArtDisponibleTarima.Articulo))
				   AND ArtDisponibleTarima.Disponible > 0 
				   AND Tarima.Posicion = @cPosicionActual

			OPEN crInvTarWMS
			FETCH NEXT FROM crInvTarWMS INTO @cTarima
			WHILE @@FETCH_STATUS = 0 
			BEGIN			   
				IF NOT EXISTS (SELECT * FROM INVD WHERE ID = @cId AND Tarima = @cTarima)
				BEGIN	
					SELECT @RenglonSub         = RenglonSub, 						   
						   @RenglonTipo        = RenglonTipo, 
						   @Almacenc           = Almacen, 
						   @Articulo           = Articulo, 
						   @Costo              = Costo, 
						   @Unidad             = Unidad, 
						   @Factor             = Factor, 
						   @CantidadInventario = CantidadInventario, 
						   @Sucursalc          = Sucursal, 
						   @SucursalOrigenc    = SucursalOrigen, 
						   @Tarima             = Tarima, 
						   @PosicionActual     = PosicionActual						   
					  FROM InvD 
					 WHERE Id = @cId 
					   AND Renglon = @cRenglon

					SELECT @Renglon   = MAX(Renglon),
						   @RenglonID = MAX(RenglonID)
					  FROM INVD 
					 WHERE ID = @cId

					   SET @Renglon = @Renglon + 2048
					   SET @RenglonID = @RenglonID + 1

					   SELECT @PosicionReal = Posicion 
					     FROM tarima 
						WHERE tarima = @cTarima

					INSERT INTO InvD
								(ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Almacen, Codigo, Articulo, SubCuenta, ArticuloDestino, SubCuentaDestino, Cantidad, Paquete, Costo, CantidadA, Aplica, AplicaID, ContUso, Unidad, Factor, CantidadInventario, FechaRequerida, ProdSerieLote, Merma, Desperdicio, Producto, SubProducto, Tipo, Sucursal, SucursalOrigen, Precio, CostoInv, Espacio, DestinoTipo, Destino, DestinoID, Cliente, SegundoConteo, DescripcionExtra, Posicion, Tarima, FechaCaducidad, PosicionDestino, PosicionActual, PosicionReal)
                 
						  VALUES
								(@cId, @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @Almacenc, NULL, @Articulo, NULL, NULL, NULL, 0.0,  NULL, @Costo, NULL, NULL, NULL, NULL, @Unidad, @Factor, @CantidadInventario, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @Sucursalc, @SucursalOrigenc, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @cTarima, NULL, NULL, @PosicionActual, @PosicionReal)
				END
			
			FETCH NEXT FROM crInvTarWMS INTO @cTarima
		END
		CLOSE crInvTarWMS
		DEALLOCATE crInvTarWMS	

		FETCH NEXT FROM crInvWMS INTO @cPosicionActual, @cId, @cArticulo, @cAlmacen, @cRenglon
	END
	CLOSE crInvWMS
	DEALLOCATE crInvWMS

	DECLARE crInvFisTar CURSOR FOR
		SELECT ID.Tarima, ID.Articulo, ID.Cantidad, I.Almacen, ID.Renglon, ID.PosicionActual, ID.PosicionReal
			FROM INVD ID
			JOIN INV I ON ID.Id = I.Id
			WHERE ID.ID = @ID

		OPEN crInvFisTar
		FETCH NEXT FROM crInvFisTar INTO @cTarimaAlta, @Articuloc, @Cantidadc, @Almacenct, @Renglonc, @PosicionActualc, @PosicionRealc

		WHILE @@FETCH_STATUS = 0 
		BEGIN
			/* Bugs 4592,4602,4656,4818 */
			SELECT @TipoA = Tipo
			  FROM AlmPos
			 WHERE Posicion = @PosicionActualc

			SELECT @TipoR = Tipo
			  FROM AlmPos
			 WHERE Posicion = @PosicionRealc

			 IF @TipoA = 'Ubicacion' AND @TipoR = 'Domicilio'
			 BEGIN
				SELECT @Ok = 13137, @OkRef = ' ' + @cTarimaAlta
			 END

			 IF @TipoR = 'Surtido'
			 BEGIN
		 		SELECT @Ok = 13136, @OkRef = ' Posición: ' + @PosicionRealc
			 END
			 ELSE
			 BEGIN
				IF EXISTS (SELECT Tarima 
 				             FROM Tarima 
               				WHERE Tarima  = @cTarimaAlta 
				           ) AND @TipoA <> 'Ubicacion' AND @TipoR <> 'Domicilio'
				BEGIN
					UPDATE Tarima
					SET Posicion = @PosicionRealc
					WHERE Tarima   = @cTarimaAlta 
				END
			 END
			 /* Bugs 4592,4602,4656,4818 */
                IF EXISTS (SELECT Tarima 
				             FROM Tarima 
						    WHERE Tarima  = @cTarimaAlta 
							  AND Estatus = 'BAJA')	AND @Accion <> 'CANCELAR'		    
				BEGIN
				/* Valida si puede Autoriza la alta de la tarima*/
					IF EXISTS (SELECT AutorizaAltaTarima FROM Usuario WHERE Usuario = @Usuario AND AutorizaAltaTarima = 1) 
					BEGIN
						INSERT TarimasBajaWMS (Tarima,      SaldoU,     Articulo,    Almacen) 
									   SELECT  @cTarimaAlta, @Cantidadc, @Articuloc, @Almacenct

							UPDATE Tarima
							   SET Estatus = 'ALTA', 
								   Alta = GETDATE() 
							 WHERE Tarima = @cTarimaAlta					  
					END
					ELSE
					BEGIN
						SELECT @Ok = 13135, @OkRef = ''
					END					  
                END

				IF EXISTS(SELECT * FROM TarimasBajaWMS WHERE Tarima = @cTarimaAlta AND Articulo = @Articuloc AND Almacen = @Almacenct) AND @Accion = 'CANCELAR'
				BEGIN
				IF EXISTS (SELECT Tarima 
							 FROM Tarima 
							WHERE Tarima  = @cTarimaAlta 
							  AND Estatus = 'ALTA') AND @Accion = 'CANCELAR'
					BEGIN
						UPDATE Tarima
						   SET Estatus = 'BAJA', 
							   Baja    = GETDATE() 
						 WHERE Tarima = @cTarimaAlta

						IF EXISTS ( SELECT * FROM SaldoUWMS WHERE SubGrupo = @cTarimaAlta )
							UPDATE SaldoUWMS
								SET SaldoU = 0
							WHERE SubGrupo = @cTarimaAlta
					   
						IF EXISTS ( SELECT * FROM SaldoU WHERE SubGrupo = @cTarimaAlta )
							UPDATE SaldoU
								SET SaldoU = 0
							WHERE SubGrupo = @cTarimaAlta
					END	
				END
		FETCH NEXT FROM crInvFisTar INTO @cTarimaAlta, @Articuloc, @Cantidadc, @Almacenct, @Renglonc, @PosicionActualc, @PosicionRealc
		END
	CLOSE crInvFisTar
	DEALLOCATE crInvFisTar
   END

  SELECT @SucursalPrincipal = Sucursal, @InvVerificarEnConexion = InvVerificarEnConexion FROM Version
  
  SELECT @AccionOriginal = @Accion
  IF @Accion = 'CANCELAR' AND @Base = 'TODO' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  IF @Modulo = 'VTAS'
  BEGIN
    -- Leer Datos Generales del Movimiento
    SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Concepto = Concepto, @Proyecto = Proyecto, @MovMoneda = Moneda, @MovTipoCambio = TipoCambio,
	   @MovUsuario = Usuario, @Autorizacion = NULLIF(RTRIM(Autorizacion), ''), @Mensaje = Mensaje, @Referencia = Referencia, @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus),
           @Almacen = NULLIF(RTRIM(Almacen), ''), @AlmacenDestino = NULLIF(RTRIM(AlmacenDestino), ''), @Condicion = Condicion, @Vencimiento = Vencimiento, @FormaEnvio = FormaEnvio, @ClienteProv = Cliente, @EnviarA = EnviarA,
           @DescuentoGlobal = DescuentoGlobal, @SobrePrecio = SobrePrecio, @Agente = Agente, @AnticiposFacturados = ISNULL(AnticiposFacturados, 0.0),
           @ServicioGarantia = ServicioGarantia, @ServicioArticulo = NULLIF(RTRIM(ServicioArticulo), ''), @ServicioSerie = NULLIF(RTRIM(ServicioSerie), ''),
           @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID, @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion, @FechaRequerida = FechaRequerida, @HoraRequerida = HoraRequerida,
           @CancelacionID = CancelacionID, @Departamento = Departamento, @GenerarOP = GenerarOP, @Periodicidad = NULLIF(RTRIM(Periodicidad), ''), @EndosarA = NULLIF(RTRIM(EndosarA), ''),
           @AutoCorrida = NULLIF(RTRIM(AutoCorrida), ''), @Espacio = NULLIF(RTRIM(Espacio), ''), @AutoKmsActuales = ISNULL(AutoKmsActuales, 0), @UEN = UEN, @ServicioPlacas = NULLIF(RTRIM(ServicioPlacas), ''), @ServicioKms = NULLIF(ServicioKms, 0),
           @AFArticulo = NULLIF(RTRIM(AFArticulo), ''), @AFSerie = NULLIF(RTRIM(AFSerie), ''),
           @ExcluirPlaneacion = ISNULL(ExcluirPlaneacion, 0), @ZonaImpuesto = NULLIF(RTRIM(ZonaImpuesto), ''),
           @AnexoID = NULLIF(AnexoID, 0), @Directo = ISNULL(Directo, 0), @ContUso2 = ContUso2, @ContUso3 = ContUso3
      FROM Venta
     WHERE ID = @ID
    IF @@ERROR <> 0 SELECT @Ok = 1

    -- Leer Datos del Cliente
    SELECT @ClienteProvTipo	    = UPPER(Tipo),
           @Credito 		    = Credito,
	   @CreditoEspecial	    = CreditoEspecial,
	   @PedidosParciales	    = PedidosParciales,
           @VtasConsignacion 	    = VtasConsignacion,
	   @AlmacenVtasConsignacion = NULLIF(RTRIM(AlmacenVtasConsignacion), ''),
           @CteChecarCredito   	    = UPPER(ISNULL(RTRIM(ChecarCredito), '(EMPRESA)')),
	   @CteBloquearMorosos      = UPPER(ISNULL(RTRIM(BloquearMorosos), '(EMPRESA)'))
      FROM Cte
     WHERE Cliente = @ClienteProv
    IF @@ERROR <> 0 SELECT @Ok = 1   
 
    IF @CreditoEspecial = 1
    BEGIN
      SELECT @ConCredito = 1
      SELECT @ConLimiteCredito   = ISNULL(CreditoConLimite, 0),
   	     @LimiteCredito      = ISNULL(CreditoLimite, 0.0),
	     @ConLimitePedidos   = ISNULL(CreditoConLimitePedidos, 0),
   	     @LimitePedidos      = ISNULL(CreditoLimitePedidos, 0.0),
	     @MonedaCredito      = CreditoMoneda,
  	     @DiasCredito	 = CASE WHEN CreditoConDias = 1 THEN CreditoDias END,
             @CondicionesValidas = CASE WHEN CreditoConCondiciones = 1 THEN NULLIF(UPPER(RTRIM(CreditoCondiciones)), '') END
        FROM Cte
       WHERE Cliente = @ClienteProv
    END ELSE
      SELECT @ConCredito         = ConCredito,
             @ConLimiteCredito   = ISNULL(ConLimiteCredito, 0),
   	     @LimiteCredito      = ISNULL(LimiteCredito, 0.0),
             @ConLimitePedidos   = ISNULL(ConLimitePedidos, 0),
   	     @LimitePedidos      = ISNULL(LimitePedidos, 0.0),
	     @MonedaCredito      = MonedaCredito,
  	     @DiasCredito	 = CASE WHEN ConDias = 1 THEN Dias END,
             @CondicionesValidas = CASE WHEN ConCondiciones = 1 THEN NULLIF(UPPER(RTRIM(Condiciones)), '') END
        FROM CteCredito
       WHERE Empresa = @Empresa AND Credito = @Credito

   IF @ConCredito = 1 AND @ConLimiteCredito = 1 AND @MonedaCredito IS NOT NULL
     SELECT @TipoCambioCredito = TipoCambio FROM Mon WHERE Moneda = @MonedaCredito
  END ELSE

  IF @Modulo = 'COMS'
  BEGIN
    -- Leer Datos Generales del Movimiento
    SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Concepto = Concepto, @Proyecto = Proyecto, @MovMoneda = Moneda, @MovTipoCambio = TipoCambio,
	   @MovUsuario = Usuario, @Autorizacion = NULLIF(RTRIM(Autorizacion), ''), @Mensaje = Mensaje, @Referencia = Referencia, @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus),
           @Almacen = NULLIF(RTRIM(Almacen), ''), @Condicion = Condicion, @Vencimiento = Vencimiento, @FormaEnvio = FormaEnvio, @ClienteProv = Proveedor, @DescuentoGlobal = DescuentoGlobal,
    	   @FechaRequerida = FechaRequerida, @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID,
           @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion, @UEN = UEN, @ZonaImpuesto = NULLIF(RTRIM(ZonaImpuesto), ''), @Directo = ISNULL(Directo, 0), @ContUso2 = ContUso2, @ContUso3 = ContUso3
      FROM Compra
     WHERE ID = @ID

    SELECT @ClienteProvTipo = UPPER(Tipo)
      FROM Prov 
     WHERE Proveedor = @ClienteProv
  END ELSE

  IF @Modulo = 'INV'
  BEGIN
    -- Leer Datos Generales del Movimiento
    SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Concepto = Concepto, @Proyecto = Proyecto, @MovMoneda = Moneda, @MovTipoCambio = TipoCambio,
	   @MovUsuario = Usuario, @Autorizacion = NULLIF(RTRIM(Autorizacion), ''), @Referencia = Referencia, @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus),
           @Almacen = NULLIF(RTRIM(Almacen), ''), @AlmacenDestino = NULLIF(RTRIM(AlmacenDestino), ''), @AlmacenTransito = NULLIF(RTRIM(AlmacenTransito), ''), @Condicion = Condicion, @Vencimiento = Vencimiento, @FormaEnvio = FormaEnvio, @Largo = Largo,
           @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion, @Agente = NULLIF(RTRIM(Agente), ''),	   
	   @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID, @UEN = UEN, @InvConteo = ISNULL(Conteo,1), @Directo = ISNULL(Directo, 0) --TASK3791
      FROM Inv
     WHERE ID = @ID

    IF EXISTS (SELECT * FROM MovTipo WHERE Modulo = 'INV' AND Clave = 'INV.E' AND SubClave = 'INV.EA' AND Mov = @Mov)
	BEGIN
		SELECT @OrigenTipo = 'I:MES', @MovMES = 1 
		UPDATE Inv 
		   SET OrigenTipo = @OrigenTipo,
			   MovMES	  = @MovMES
		 WHERE ID = @ID 
    END

  END ELSE

  IF @Modulo = 'PROD'
  BEGIN
    -- Leer Datos Generales del Movimiento
    SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Concepto = Concepto, @Proyecto = Proyecto, @MovMoneda = Moneda, @MovTipoCambio = TipoCambio,
	   @MovUsuario = Usuario, @Autorizacion = NULLIF(RTRIM(Autorizacion), ''), @Referencia = Referencia, @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus),
           @Almacen = NULLIF(RTRIM(Almacen), ''), @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID,    
           @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion, @UEN = UEN, @Directo = ISNULL(Directo, 0)
      FROM Prod
     WHERE ID = @ID
  END 

  IF @@ERROR <> 0 SELECT @Ok = 1

  IF @Accion = 'AUTORIZAR'
    SELECT @Autorizacion = @Usuario, @Accion = 'AFECTAR'

  IF @ClienteProvTipo = 'ESTRUCTURA' SELECT @Ok = 20680, @OkRef = @ClienteProv
  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario

  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('VERIFICAR', 'AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro 
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, @Estatus, @Concepto OUTPUT, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT, @GenerarGasto = @GenerarGasto OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  IF @Origen IS NOT NULL
    SELECT @OrigenMovTipo = Clave, @OrigenSubMovTipo = SubClave FROM MovTipo WHERE Modulo = @OrigenTipo AND Mov = @Origen

  IF @MovTipo = 'INV.TI' AND @Accion <> 'GENERAR' AND NOT (@AccionEspecial = 'TRANSITO' OR @SincroFinal = 1) 
    SELECT @Ok = 25410

  IF @OrigenTipo = 'INV/EP' AND @Accion = 'CANCELAR' AND @Conexion = 0 SELECT @Ok = 60072

  IF @Ok IS NOT NULL RETURN

  IF @MovTipo IN ('VTAS.VC', 'VTAS.DC') AND @EnviarA IS NOT NULL
    SELECT @AlmacenVtasConsignacion = ISNULL(NULLIF(RTRIM(AlmacenVtasConsignacion), ''), @AlmacenVtasConsignacion)
      FROM CteEnviarA
     WHERE Cliente = @ClienteProv AND ID = @EnviarA

  -- Leer Configuracion de la Empresa
  SELECT @CfgFormaCosteo             = ISNULL(UPPER(RTRIM(FormaCosteo)), 'EMPRESA'),
         @CfgTipoCosteo              = ISNULL(UPPER(RTRIM(TipoCosteo)), 'PROMEDIO'),
         @CfgCosteoActividades       = UPPER(CosteoActividades),
         @CfgCosteoNivelSubCuenta    = CosteoNivelSubCuenta,
         @CfgCosteoMultipleSimultaneo= ISNULL(CosteoMultipleSimultaneo, 0),
         @CfgToleranciaCosto	     = ISNULL(ToleranciaCosto, 0.0),
         @CfgToleranciaCostoInferior = ISNULL(ToleranciaCostoInferior, 0.0),
         @CfgToleranciaTipoCosto     = ISNULL(UPPER(RTRIM(ToleranciaTipoCosto)), 'PROMEDIO'), 
         @CfgValidarPrecios	     = ISNULL(UPPER(RTRIM(ValidarPrecios)), 'NO'),
         @CfgPrecioMinimoSucursal    = ISNULL(PrecioMinimoNivelSucursal, 0),
         @CfgValidarMargenMinimo     = ISNULL(UPPER(RTRIM(ValidarMargenMinimo)), 'ULTIMO COSTO'),
         @CfgSeriesLotesMayoreo      = SeriesLotesMayoreo,
         @CfgSeriesLotesAutoCampo    = ISNULL(UPPER(RTRIM(SeriesLotesAutoCampo)),'NUMERO'),
         @CfgSeriesLotesAutoOrden    = ISNULL(UPPER(RTRIM(SeriesLotesAutoOrden)), 'NO'),
         @CfgCosteoSeries	     = CosteoSeries,
         @CfgCosteoLotes             = CosteoLotes,
	 @CfgPedidosReservar         = ISNULL(PedidosReservar, 0),
         @CfgPedidosReservarEsp	     = ISNULL(PedidosReservarEsp, 0),
	 @CfgVentaSurtirDemas        = VentaSurtirDemas,
         @CfgTransferirDemas	     = TransferirDemas,
	 @CfgVentaConfirmarServicios = VentaConfirmarServicios,
	 @CfgVentaConfirmarContratos = VentaConfirmarContratos,
         @CfgInvConfirmarSolicitudes = InvConfirmarSolicitudes,
	 @CfgServiciosRequiereTareas = VentaServiciosRequiereTareas,
         @CfgServiciosValidarID	     = ISNULL(VentaServiciosValidarID, 0),
         @CfgVentaContratosArticulo  = NULLIF(RTRIM(VentaContratosArticulo), ''),
         @CfgVentaContratosImpuesto  = ISNULL(VentaContratosImpuesto, 0.0),
         @CfgInvPrestamosGarantias   = InvPrestamosGarantias,
         @CfgInvEntradasSinCosto     = InvEntradasSinCosto,
	 @CfgInvFisicoConteo	     = ISNULL(InvFisicoConteo, 1),
         @CfgVentaChecarCredito      = UPPER(ISNULL(RTRIM(VentaChecarCredito), 'PEDIDO')),
         @CfgVentaPedidosDisminuyenCredito = ISNULL(VentaPedidosDisminuyenCredito, 0),
	 @CfgVentaBloquearMorosos    = UPPER(ISNULL(RTRIM(VentaBloquearMorosos), 'NO')),
         @CfgVentaLiquidaIntegral    = VentaLiquidaIntegral,
         @CfgVentaLiquidaIntegralCxc = VentaLiquidaIntegralCxc,
	 @CfgVentaComisionesCobradas = VentaComisionesCobradas,
	 @CfgImpInc		     = VentaPreciosImpuestoIncluido,
         @CfgPrecioMoneda	     = VentaPrecioMoneda,
         @CfgVentaRedondeoDecimales  = ISNULL(VentaCobroRedondeoDecimales, 2),
         @CfgCompraConsignacion      = ISNULL(UPPER(RTRIM(CompraConsignacion)), 'NO'),
	 @CfgAutorizarRequisiciones  = AutorizarRequisiciones,
         @CfgBackOrders	             = BackOrders,
         @CfgBackOrdersNivel	     = UPPER(BackOrdersNivel),
         @CfgFacturasPendientes      = FacturasPendientes,
         @CfgLimiteRenFacturas       = ISNULL(VentaLimiteRenFacturas, 0),
         @CfgNotasBorrador	     = NotasBorrador,
         @CfgFormaPagoRequerida      = FormaPagoRequerida,
         @CfgCancelarFacturaReservarPedido = CancelarFacturaReservarPedido,
         @CfgComisionBase	     = UPPER(ComisionBase),
         @CfgCompraValidarArtProv    = ISNULL(CompraValidarArtProv, 0),
         @CfgValidarCC	 	     = ISNULL(CentroCostosValidar, 0),
         @CfgCancelarFactura         = ISNULL(UPPER(CancelarFactura), 'NO'),
         @CfgRestringirArtBloqueados = CASE @Modulo WHEN 'VTAS' THEN VentaRestringirArtBloqueados WHEN 'COMS' THEN CompraRestringirArtBloquedos ELSE 0 END,
         @CfgLimiteCreditoNivelGrupo = ISNULL(VentaLimiteCreditoNivelGrupo, 0),
         @CfgLimiteCreditoNivelUEN   = ISNULL(VentaLimiteCreditoNivelUEN, 0),
         @CfgAnexosAlFacturar        = ISNULL(VentaAnexosAlFacturar, 0),
         @CfgVentaEndoso	     = ISNULL(VentaEndoso, 0),
         @CfgPosiciones		     = ISNULL(Posiciones, 0),
         @CfgExistenciaAlterna	     = ISNULL(ExistenciaAlterna, 0),
         @CfgExistenciaAlternaSerieLote = ISNULL(ExistenciaAlternaSerieLote, 0),
         @CfgCentroCostos2VentaD = ISNULL(CentroCostos2VentaD,0),
         @CfgCentroCostos3VentaD = ISNULL(CentroCostos3VentaD,0),  
		 @CfgCentroCostos2VentaD = ISNULL(CentroCostos2CompraD,0),
         @CfgCentroCostos3VentaD = ISNULL(CentroCostos3CompraD,0)         
    FROM EmpresaCfg
   WHERE Empresa = @Empresa 
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF @Modulo = 'VTAS'
    SELECT @CfgLimiteRenFacturas = ISNULL(NULLIF(VentaLimiteRenFacturas, 0), @CfgLimiteRenFacturas) FROM UEN WHERE UEN = @UEN

  SELECT @CfgFacturaCobroIntegrado 	  = FacturaCobroIntegrado,
         @CfgFacturaCobroIntegradoParcial = FacturaCobroIntegradoParcial,
         @CfgAnticiposFacturados 	= CxcAnticiposFacturados,
         @CfgCompraRecibirDemas  	= CompraRecibirDemas,
         @CfgCompraRecibirDemasTolerancia = NULLIF(CompraRecibirDemasTolerancia, 0),
	 @CfgMultiUnidades       	= MultiUnidades,
	 @CfgMultiUnidadesNivel  	= ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'),
	 @CfgCompraFactorDinamico	= CompraFactorDinamico,
	 @CfgInvFactorDinamico   	= InvFactorDinamico,
	 @CfgProdFactorDinamico  	= ProdFactorDinamico,
	 @CfgVentaFactorDinamico 	= VentaFactorDinamico,
	 @CfgFacturasPendientesSerieLote= FacturasPendientesSerieLote,
         @CfgAutoAsignarBackOrders 	= AutoAsignarBackOrders,
    	 @CfgInvMultiAlmacen	   	= InvMultiAlmacen,
         @CfgCompraMultiAlmacen	        = CompraMultiAlmacen,
    	 @CfgVentaMultiAlmacen   	= VentaMultiAlmacen,
         @CfgVentaUENDetalle		= VentaUENDetalle,
         @CfgVentaMultiAgente	   	= VentaMultiAgente,
         @CfgVentaMultiDepartamento 	= VentaMultiDepartamento,
         @CfgVentaAFDetalle		= VentaAFDetalle,
         @CfgVentaEnviarADetalle	= VentaEnviarADetalle,
         @CfgVentaExcluirPlaneacionDetalle = VentaExcluirPlaneacionDetalle,
         @CfgVentaDFechaRequerida	= VentaDFechaRequerida,
         @CfgVentaDHoraRequerida	= VentaDHoraRequerida,
         @CfgValidarLotesCostoDif	= ValidarLotesCostoDif,
         @CfgCompraAutoCargos           = CompraAutoCargos,
         @CfgVentaAutoBonif		= VentaBonificacionAuto,
         @CfgVentaArtAlmacenEspecifico  = VentaArtAlmacenEspecifico,
         @CfgCompraCostosImpuestoIncluido= ISNULL(CompraCostosImpuestoIncluido, 0),
         @CfgProdAutoLote	 	= ISNULL(UPPER(ProdAutoLote), 'NO'),
         @CfgProdAutoCB		        = ISNULL(UPPER(ProdAutoCB), 'NO'),
         @CfgTipoMerma		        = ISNULL(NULLIF(RTRIM(ProdTipoMerma), ''), '%'),
         @CfgVentaRestringida           = ISNULL(VentaRestringida, 0),
         @CfgPresupuestosPendientes     = CASE @Modulo WHEN 'VTAS' THEN VentaPresupuestosPendientes WHEN 'COMS' THEN CompraPresupuestosPendientes ELSE 0 END,
         @CfgValidarFechaRequerida      = CASE @Modulo WHEN 'VTAS' THEN VentaValidarFechaRequerida  WHEN 'COMS' THEN CompraValidarFechaRequerida  ELSE 0 END,
         @CfgVIN                        = ISNULL(VIN, 0),
         @CfgVINAccesorioArt 		= VINAccesorioArt,
         @CfgVINCostoSumaAccesorios	= VINCostoSumaAccesorios
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa 
  IF @@ERROR <> 0 SELECT @Ok = 1

  SELECT @CfgAlmacenTransito         = NULLIF(RTRIM(AlmacenTransito), ''),
         @CfgDecimalesCantidades     = ISNULL(DecimalesCantidades, 0),
	 @CfgContX	             = ContX,
         @CfgContXFacturasPendientes = ISNULL(ContXFacturasPendientes, 0), 
         @CfgAutotransportes	     = ISNULL(Autotransportes, 0),
         @CfgAutoAsignarMovSucursalAlmacen = ISNULL(AutoAsignarMovSucursalAlmacen, 0),
         @CfgPermitirMovSucursalDiferente  = ISNULL(PermitirMovSucursalDiferente, 0)
    FROM EmpresaGral
   WHERE Empresa = @Empresa 
  IF @@ERROR <> 0 SELECT @Ok = 1
  IF @CfgAutoAsignarMovSucursalAlmacen = 1 SELECT @CfgPermitirMovSucursalDiferente = 0

  IF @CfgContX = 1
    SELECT @CfgContXGenerar = ISNULL(UPPER(RTRIM(ContXGenerar)), 'NO')
      FROM EmpresaCfgModulo
     WHERE Empresa = @Empresa 
       AND Modulo  = @Modulo
  IF @@ERROR <> 0 SELECT @Ok = 1

  SELECT @CfgBloquearNotasNegativas     = ISNULL(BloquearNotasNegativas, 0),
         @CfgBloquearFacturacionDirecta = ISNULL(BloquearFacturacionDirecta, 0),
         @CfgBloquearInvSalidaDirecta   = ISNULL(BloquearInvSalidaDirecta, 0)
    FROM Usuario
   WHERE Usuario = @Usuario

  SELECT @CfgRecibirDemasSinLimites = ISNULL(RecibirDemasSinLimites, 0)
    FROM UsuarioCfg2
   WHERE Usuario = @Usuario

  IF @CfgRecibirDemasSinLimites = 1 SELECT @CfgCompraRecibirDemasTolerancia = NULL

/***Inventarios Ubicacion*/
	EXEC spMovInfo @ID,@Modulo,@Empresa=@Empresa OUTPUT,@Mov=@Mov OUTPUT,@Movtipo=@Movtipo OUTPUT, @Estatus=@Estatus OUTPUT
    IF @MovTipo  IN ('INV.CPOS') AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR') AND @Accion = 'AFECTAR'  
    EXEC xpAntesAfectarCambioPosicion @Empresa,@ID,@Mov,@Movtipo,@Accion,@Estatus,@Ok OUTPUT, @OkRef OUTPUT
  
  /******************/


  IF @MovTipo = 'INV.IF' AND @OrigenTipo = 'CR'
    SELECT @CfgInvFisicoConteo = 1

  IF @Accion = 'AFECTAR' AND @CfgAnexosAlFacturar = 1 AND @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.FB', 'VTAS.N', 'VTAS.FM') AND @OrigenTipo <> 'VMOS' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
    EXEC spAnexosAlFacturar @ID, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Ok OUTPUT, @OkRef OUTPUT

/*  IF @Accion IN ('AFECTAR', 'VERIFICAR') AND @CfgVIN = 1 AND @Modulo = 'VTAS' AND @MovTipo NOT IN ('VTAS.D', 'VTAS.DF', 'VTAS.B')
    EXEC spVentaCalcISAN @ID
*/
  IF @EndosarA IS NOT NULL
  BEGIN
    IF @Modulo = 'VTAS' AND (@MovTipo NOT IN ('VTAS.F','VTAS.FAR', 'VTAS.FB', 'VTAS.D', 'VTAS.DF', 'VTAS.B') OR @CfgVentaEndoso = 0 OR @ClienteProv = @EndosarA) SELECT @EndosarA = NULL
  END

  IF @Accion = 'CANCELAR' AND @Estatus = 'CONCLUIDO' AND @MovTipo IN ('VTAS.F','VTAS.FAR') AND @CfgCancelarFactura <> 'NO' AND @AnticiposFacturados = 0.0
  BEGIN
    IF @CancelacionID IS NULL 
    BEGIN
      IF DATEPART(month, @FechaRegistro) > DATEPART(month, @FechaEmision) 
      OR DATEPART(year,  @FechaRegistro) > DATEPART(year,  @FechaEmision)
      OR (@CfgCancelarFactura = 'Cambio Dia' AND DATEPART(day,  @FechaRegistro) > DATEPART(day,  @FechaEmision))
      BEGIN
        EXEC spCancelarFacturaOtroMes @Sucursal, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @Empresa, @Usuario, @FechaRegistro,
                                      @GenerarMov OUTPUT, @GenerarMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL 
          SELECT @Generar = 1, @Ok = 80030 
        ELSE RETURN
      END
    END ELSE SELECT @Ok = 60280   
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

  IF @MovTipo = 'INV.IF' AND @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR' AND @InvConteo=1 AND @CfgInvFisicoConteo = 1
  BEGIN
   UPDATE InvD SET CantidadA=Cantidad WHERE ID = @ID 
   UPDATE Inv SET Conteo = 1 WHERE ID = @ID
  END

  IF @MovTipo = 'INV.IF' AND @Accion = 'AFECTAR' AND @Estatus = 'PENDIENTE' AND @CfgInvFisicoConteo = 3
  BEGIN
    IF ISNULL(@InvConteo, 0) = 2
    BEGIN
      UPDATE InvD SET SegundoConteo = CantidadA, CantidadA = NULL WHERE ID = @ID 
      UPDATE Inv SET Conteo = 3 WHERE ID = @ID
      RETURN
    END ELSE
    IF ISNULL(@InvConteo, 0) = 3 UPDATE InvD SET CantidadA = SegundoConteo WHERE ID = @ID AND SegundoConteo = Cantidad          
  END
  
  IF @Ok IS NULL AND
     ((@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'AUTORIZARE', 'CONFIRMAR', 'PENDIENTE', 'PROCESAR', 'RECURRENTE')) OR 
      (@Accion =  'CANCELAR' AND @Estatus IN ('CONCLUIDO',  'AUTORIZARE', 'PENDIENTE', 'PROCESAR', 'RECURRENTE'))) OR
      (@Accion = 'GENERAR')
  BEGIN
    -- Analizar que Movimientos se Generan y que Movimientos se Utilizan
    EXEC spSucursalMovSeguimiento @Sucursal, @Modulo, @Mov, @MovSeguimiento OUTPUT

    IF @Accion = 'CANCELAR'
    BEGIN
      --REQ16092
      IF @MovTipo IN (/*'VTAS.C', */'VTAS.CS', 'VTAS.P', 'VTAS.S', 'VTAS.VC','VTAS.VCR', 'INV.IF', 'INV.P', 'INV.SOL','INV.OT','INV.OI','INV.TI','INV.SM') AND @Estatus = 'CONCLUIDO' SELECT @Ok = 60050 
      IF @MovTipo IN ('VTAS.C') AND @Estatus = 'CONCLUIDO' AND ISNULL(@OrigenTipo, '') <> 'OPORT' SELECT @Ok = 60050       
    END ELSE
    BEGIN
      IF @Modulo = 'VTAS'
      BEGIN
        --REQ16092
        IF @MovTipo IN (/*'VTAS.C', */'VTAS.CS','VTAS.OP') AND @Estatus = 'CONFIRMAR' AND @Accion <> 'VERIFICAR' SELECT @Utilizar = 1 
        IF @MovTipo IN ('VTAS.C') AND @Estatus = 'CONFIRMAR' AND @Accion <> 'VERIFICAR' AND ISNULL(@OrigenTipo, '') <> 'OPORT' SELECT @Utilizar = 1                 
        IF @MovTipo IN ('VTAS.C') AND @Estatus = 'CONFIRMAR' AND @Accion = 'GENERAR' AND ISNULL(@OrigenTipo, '') = 'OPORT' SELECT @Utilizar = 1                         
        
        IF @MovTipo IN ('VTAS.PR', 'VTAS.CTO', 'VTAS.S', 'VTAS.FR', 'VTAS.N', 'VTAS.NO', 'VTAS.NR', 'VTAS.FM') AND @Accion = 'GENERAR' SELECT @Utilizar = 1
        IF ((@MovTipo IN ('VTAS.P','VTAS.R','VTAS.S','VTAS.VC','VTAS.VCR', 'VTAS.SD') AND @Estatus = 'PENDIENTE') OR (@MovTipo = 'VTAS.CO' AND @Estatus = 'CONFIRMAR')) AND @Accion IN ('AFECTAR','GENERAR') SELECT @Utilizar = 1
      END ELSE
      IF @Modulo = 'COMS'
      BEGIN
        IF @MovTipo = 'COMS.C' AND @Estatus = 'CONFIRMAR' SELECT @Utilizar = 1 
        IF @MovTipo IN ('COMS.PR','COMS.R','COMS.O','COMS.OP','COMS.OG','COMS.OD','COMS.OI','COMS.IG','COMS.CC') AND @Estatus = 'PENDIENTE' AND @Accion IN ('AFECTAR','GENERAR') SELECT @Utilizar = 1
      END ELSE
      IF @Modulo = 'INV' 
      BEGIN
        IF ((@MovTipo='INV.S' AND @Estatus = 'CONCLUIDO') OR (@MovTipo IN ('INV.P', 'INV.SOL', 'INV.OT','INV.OI','INV.TI','INV.SM') AND @Estatus = 'PENDIENTE')) AND @Accion IN ('AFECTAR','GENERAR') SELECT @Utilizar = 1
      END ELSE
      IF @Modulo = 'PROD'
      BEGIN
        IF @MovTipo = 'PROD.O' AND @Estatus = 'PENDIENTE' AND @Accion IN ('AFECTAR','GENERAR') SELECT @Utilizar = 1
      END

      IF (@Generar = 1 OR @Utilizar = 1) AND @GenerarMov IS NULL AND @Ok IS NULL 
        SELECT @Ok = 60040
        
      --REQ16092
      IF @Ok = 60040 AND @MovTipo IN ('VTAS.C') AND @Estatus = 'CONFIRMAR' AND @Accion <> 'VERIFICAR' AND ISNULL(@OrigenTipo, '') = 'OPORT'
        SELECT @Ok = NULL
    END

    IF @Ok IS NOT NULL RETURN

    -- Si va a Utilizar el Movimiento 
    IF @Utilizar = 1 
    BEGIN
      SELECT @Estatus =  'SINAFECTAR'
      SELECT @UtilizarID = @ID, @UtilizarMov = @Mov, @UtilizarMovID = @MovID, @UtilizarMovTipo = @MovTipo,
	     @Mov = @GenerarMov, @GenerarMov = NULL, @MovID = NULL 

      -- Leer MovTipo, Periodo y Ejercicio	
      EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
    END


    IF @FormaEnvio IS NOT NULL AND EXISTS(SELECT * FROM EmpresaCfgMovEsp WHERE Empresa = @Empresa AND Asunto = 'EMB' AND Modulo = @Modulo AND Mov = @Mov)
    BEGIN
      SELECT @CfgEmbarcar = Embarcar FROM FormaEnvio WHERE FormaEnvio = @FormaEnvio
    END

    IF @Modulo = 'COMS' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'SINCRO')
    BEGIN
      IF @CfgCompraMultiAlmacen = 0 UPDATE CompraD SET Almacen = @Almacen WHERE ID = @ID AND Almacen <> @Almacen
      IF @CfgCentroCostos2VentaD = 0 UPDATE VentaD SET ContUso2 = @ContUso2 WHERE ID = @ID AND ContUso2 <> @ContUso2        
      IF @CfgCentroCostos3VentaD = 0 UPDATE VentaD SET ContUso3 = @ContUso3 WHERE ID = @ID AND ContUso3 <> @ContUso3                      

    END

    IF @Modulo = 'VTAS' 
    BEGIN
      IF @CteChecarCredito   = '(EMPRESA)' SELECT @ChecarCredito   = @CfgVentaChecarCredito   ELSE SELECT @ChecarCredito   = @CteChecarCredito
      IF @CteBloquearMorosos = '(EMPRESA)' SELECT @BloquearMorosos = @CfgVentaBloquearMorosos ELSE SELECT @BloquearMorosos = @CteBloquearMorosos
      IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'SINCRO')
      BEGIN
        IF @CfgVentaUENDetalle        = 0 UPDATE VentaD SET UEN          = @UEN          WHERE ID = @ID AND UEN          <> @UEN
        IF @CfgVentaMultiAlmacen      = 0 UPDATE VentaD SET Almacen      = @Almacen      WHERE ID = @ID AND Almacen      <> @Almacen
        IF @CfgVentaMultiAgente       = 0 UPDATE VentaD SET Agente       = @Agente       WHERE ID = @ID AND Agente       <> @Agente
        IF @CfgVentaMultiDepartamento = 0 UPDATE VentaD SET Departamento = @Departamento WHERE ID = @ID AND Departamento <> @Departamento
        IF @CfgVentaEnviarADetalle    = 0 UPDATE VentaD SET EnviarA      = @EnviarA      WHERE ID = @ID AND EnviarA      <> @EnviarA
        IF @CfgVentaAFDetalle         = 0 UPDATE VentaD SET AFArticulo   = @AFArticulo, AFSerie = @AFSerie WHERE ID = @ID AND (AFArticulo <> @AFArticulo OR AFSerie <> @AFSerie)
        IF @CfgVentaExcluirPlaneacionDetalle = 0 UPDATE VentaD SET ExcluirPlaneacion = @ExcluirPlaneacion WHERE ID = @ID AND ExcluirPlaneacion <> @ExcluirPlaneacion
        IF @CfgCentroCostos2VentaD = 0 UPDATE VentaD SET ContUso2 = @ContUso2 WHERE ID = @ID AND ContUso2 <> @ContUso2        
        IF @CfgCentroCostos3VentaD = 0 UPDATE VentaD SET ContUso3 = @ContUso3 WHERE ID = @ID AND ContUso3 <> @ContUso3                        
      END
    END

    /** 28.07.2006 **/
    IF @Modulo = 'INV' AND @Accion IN (/*'GENERAR', */'VERIFICAR', 'AFECTAR') AND (@CfgInvMultiAlmacen = 0 OR @MovTipo IN ('INV.IF', 'INV.EI', 'INV.TIF', 'INV.TIS', 'INV.P', 'INV.R')) AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
    BEGIN
      /** 22.11.2006 **/
      IF @MovTipo IN ('INV.EI', /*'INV.TIF', */'INV.TIS')
        UPDATE InvD SET Almacen = @AlmacenDestino WHERE ID = @ID AND Almacen <> @AlmacenDestino 
      ELSE
        UPDATE InvD SET Almacen = @Almacen WHERE ID = @ID AND Almacen <> @Almacen
    END

    IF @Ok IS NULL
    BEGIN
      /** 22.11.2006 **/
      IF @MovTipo IN ('INV.EI', /*'INV.TIF', */'INV.TIS', 'INV.DTI') SELECT @AlmacenTmp = @AlmacenDestino ELSE SELECT @AlmacenTmp = @Almacen
      SELECT @AlmacenSucursal = Sucursal FROM Alm WHERE Almacen = @AlmacenTmp
      IF @MovSeguimiento = 'MATRIZ' 
      BEGIN          
        SELECT @SeguimientoMatriz = 1
        IF @AlmacenSucursal <> 0 SELECT @Ok = 60350
        IF @Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'AUTORIZARE', 'CONFIRMAR')
        BEGIN    
          IF @SucursalPrincipal = 0 
            SELECT @Sucursal = 0
          ELSE
            IF @Accion <> 'CANCELAR' SELECT @Ok = 60300      
        END
      END

      IF @SeguimientoMatriz = 0 AND ISNULL(@SucursalDestino, @Sucursal) <> @AlmacenSucursal AND @MovTipo <> 'INV.TI' AND @Accion <> 'CANCELAR'  
      BEGIN
        IF @CfgAutoAsignarMovSucursalAlmacen = 1
          SELECT @SucursalDestino = @AlmacenSucursal

        EXEC xpInvSucursalDestino @Accion, @Empresa, @ID, @MovTipo, @Almacen, @AlmacenDestino, @SucursalDestino OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        /*EXEC spSucursalEnLinea @AlmacenSucursal, @EnLinea OUTPUT
        IF @EnLinea = 0
        BEGIN*/
          IF @Modulo = 'VTAS' UPDATE Venta  SET SucursalDestino = @SucursalDestino WHERE ID = @ID AND SucursalDestino <> @SucursalDestino ELSE
          IF @Modulo = 'COMS' UPDATE Compra SET SucursalDestino = @SucursalDestino WHERE ID = @ID AND SucursalDestino <> @SucursalDestino ELSE
          IF @Modulo = 'PROD' UPDATE Prod   SET SucursalDestino = @SucursalDestino WHERE ID = @ID AND SucursalDestino <> @SucursalDestino ELSE
          IF @Modulo = 'INV'  UPDATE Inv    SET SucursalDestino = @SucursalDestino WHERE ID = @ID AND SucursalDestino <> @SucursalDestino 
          IF @@ERROR <> 0 SELECT @Ok = 1
        /*END*/
      END

      IF ((@SucursalDestino IS NOT NULL AND @SucursalDestino <> @Sucursal) OR ISNULL(@SucursalDestino, @Sucursal) <> @AlmacenSucursal) AND @Accion = 'AFECTAR'
      BEGIN
        IF @SucursalDestino IS NULL SELECT @SucursalDestino = @Sucursal
        EXEC spInvVerificarSincro @SucursalDestino, @Modulo, @ID, @MovTipo, @Almacen, @AlmacenDestino, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
        IF @EnLinea = 1 
        BEGIN
          IF @Ok = 20780 AND @CfgPermitirMovSucursalDiferente = 1 SELECT @Ok = NULL, @OkRef = NULL
          EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, NULL
          SELECT @Sucursal = @SucursalDestino
        END ELSE
          SELECT @Accion = 'SINCRO'
      END
    END

    --IF @CfgCompraConsignacion = 'AUTOMATICO' SELECT @CfgAutoConsig = 1 ELSE SELECT @CfgAutoConsig = 0
    IF @AlmacenTransito IS NULL SELECT @AlmacenTransito = @CfgAlmacenTransito

	-- EToral 19/Nov/2009
    IF @MovTipo IN ('VTAS.PR', 'COMS.PR') AND @CfgPresupuestosPendientes = 1
    BEGIN
      IF @Accion = 'CANCELAR'
        SELECT @EstatusNuevo = 'CANCELADO'
      ELSE
      	SELECT @EstatusNuevo = 'PENDIENTE' 
    END

    IF @Modulo = 'VTAS'
    BEGIN
      IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion = 'AFECTAR' 
      BEGIN
        IF @CfgVentaDFechaRequerida = 0 UPDATE VentaD SET FechaRequerida = @FechaRequerida WHERE ID = @ID AND FechaRequerida <> @FechaRequerida
        IF @CfgVentaDHoraRequerida  = 0 UPDATE VentaD SET HoraRequerida  = @HoraRequerida  WHERE ID = @ID AND HoraRequerida  <> @HoraRequerida
      END
      IF @MovTipo IN ('VTAS.VC','VTAS.VCR','VTAS.DC','VTAS.DCR','VTAS.EG') SELECT @EsTransferencia = 1
      IF @MovTipo IN ('VTAS.OP', 'VTAS.C', 'VTAS.CS', 'VTAS.FR') SELECT @AfectarDetalle = 0
  
      IF (@Accion <> 'CANCELAR' AND ((@MovTipo = 'VTAS.FM' AND @Estatus = 'PROCESAR')) OR (@MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FB','VTAS.D') AND @OrigenTipo = 'VMOS')) SELECT @FacturarVtasMostrador = 1
      IF @MovTipo IN ('VTAS.P','VTAS.VP','VTAS.S','VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX','VTAS.FB','VTAS.R','VTAS.DR','VTAS.SG','VTAS.D','VTAS.DF','VTAS.EG','VTAS.VC','VTAS.VCR','VTAS.DC','VTAS.DCR','VTAS.N','VTAS.NO', 'VTAS.NR','VTAS.FM') 
      BEGIN
	SELECT @AfectarMatando = 1
        --- AR & CJ 05/May/2014 Bug 16186. Se agrega la línea siguiente.
        IF @VolverAfectar = 5 AND @Accion IN ('RESERVAR', 'RESERVARPARCIAL') AND @MovTipo = 'VTAS.P' SELECT @AfectarMatando = 0
        IF @Utilizar = 1 AND @UtilizarMovTipo IN ('VTAS.C', 'VTAS.CS', 'VTAS.FR') SELECT @AfectarMatando = 0 -- Si viene de una cotizacion no matar
        IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND @Accion <> 'CANCELAR' AND @Estatus = 'PENDIENTE' SELECT @AfectarMatando = 0 -- para que no vuelva a matar al pedido
      END
      IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
      BEGIN
        IF @Estatus IN ('SINAFECTAR', 'BORRADOR') AND 
           (@MovTipo IN ('VTAS.C', 'VTAS.CS') OR 
           (@MovTipo = 'VTAS.S'  AND @CfgVentaConfirmarServicios = 1) OR
           (@MovTipo = 'VTAS.CO' AND @CfgVentaConfirmarContratos = 1)) OR
           (@MovTipo IN ('VTAS.N', 'VTAS.FM') AND @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR' AND @MovID IS NULL AND @CfgVentaLiquidaIntegral = 0)
          SELECT @EstatusNuevo = 'CONFIRMAR' 
        ELSE 
  	  IF @MovTipo IN ('VTAS.P', 'VTAS.S', 'VTAS.R', 'VTAS.SD')
          BEGIN 
            IF @AnexoID IS NOT NULL 
            BEGIN
              IF NOT EXISTS(SELECT * FROM Venta WHERE ID = @AnexoID AND Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CANCELADO'))
                SELECT @Ok = 10350
              ELSE
                SELECT @EstatusNuevo = 'CONCLUIDO', @AnexarTodoDetalle = 1
            END ELSE BEGIN
              SELECT @EstatusNuevo = 'PENDIENTE' 
              IF @Accion = 'AFECTAR' AND @MovTipo IN ('VTAS.P', 'VTAS.S') AND @CfgPedidosReservar = 1 AND @SeguimientoMatriz = 0
                IF @CfgPedidosReservarEsp = 0 OR EXISTS(SELECT * FROM EmpresaPedidosReservarEsp WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov)
                  IF ABS(DATEDIFF(day, GETDATE(), @FechaEmision)) < 2
                    IF @Directo = 1
      	              SELECT @Accion = 'RESERVARPARCIAL'
                    ELSE
		      SELECT @VolverAfectar = 5
            END
          END

        IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX','VTAS.FB')
        BEGIN
          IF @CfgFacturasPendientes = 1 AND @Accion = 'AFECTAR' AND @MovTipo = 'VTAS.F'
          BEGIN
            IF @OrigenTipo <> 'VMOS'
            BEGIN
              IF NOT EXISTS(SELECT * FROM VentaD d, MovTipo mt WHERE d.ID = @ID AND mt.Mov = d.Aplica AND mt.Modulo = 'VTAS' AND mt.Clave = 'VTAS.R') AND
                 NOT EXISTS(SELECT * FROM VentaD d WHERE d.ID = @ID AND @CfgFacturasPendientesSerieLote = 0 AND d.RenglonTipo IN ('S', 'L', 'V', 'A'))
              BEGIN
                IF (SELECT FacturasPendientes FROM Alm WHERE Almacen = @Almacen ) = 1
                BEGIN
                  IF @CfgPosiciones = 1 AND EXISTS (SELECT ID FROM VentaD WHERE ID = @ID AND NULLIF(Posicion,'') IS NULL)
                    SELECT @Ok= 13050, @OkRef = 'Articulo: '+(SELECT TOP 1 Articulo FROM VentaD WHERE ID = @ID AND NULLIF(Posicion,'') IS NULL)
                  ELSE
	              BEGIN    
                    SELECT @EstatusNuevo = 'PENDIENTE'
                    /*IF @CfgPedidosReservar = 1 */SELECT @Accion = 'RESERVARPARCIAL'
                  END
                END
              END
            END
          END ELSE 
            IF @Utilizar = 1 AND @UtilizarMovTipo IN ('VTAS.VC','VTAS.VCR') SELECT @VoltearAlmacen = 1 --@Almacen = @AlmacenDestino, @AlmacenDestino = NULL
        END
        IF @MovTipo IN ('VTAS.VC', 'VTAS.DC') SELECT @AlmacenDestino = @AlmacenVtasConsignacion 
        IF @MovTipo IN ('VTAS.VCR', 'VTAS.DCR')
        BEGIN
          SELECT @AlmacenDestino = NULLIF(RTRIM(Almacen), '') FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
          IF @AlmacenDestino IS NULL SELECT @Ok = 20770
        END

	IF @MovTipo IN ('VTAS.VC', 'VTAS.VCR') SELECT @EstatusNuevo = 'PENDIENTE'
        IF @MovTipo IN ('VTAS.DC', 'VTAS.DCR') SELECT @VoltearAlmacen = 1 -- @AlmacenTmp = @AlmacenVtasConsignacion, @AlmacenDestino = @Almacen, @Almacen = @AlmacenTmp
        IF @MovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR', 'VTAS.FM') AND @EstatusNuevo <> 'CONFIRMAR' SELECT @EstatusNuevo = 'PROCESAR', @AfectarVtasMostrador = 1
        IF @MovTipo = 'VTAS.FR' SELECT @EstatusNuevo = 'RECURRENTE' 
	IF @MovTipo = 'VTAS.OP' SELECT @EstatusNuevo = 'CONFIRMAR'
      END 
      ELSE
      IF @Estatus = 'PENDIENTE'
      BEGIN
 	IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX','VTAS.P','VTAS.S','VTAS.VC','VTAS.VCR') AND @EstatusNuevo <> 'CANCELADO' SELECT @EstatusNuevo = 'PENDIENTE'
        IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') 
          IF @Accion = 'AFECTAR'
          BEGIN
            IF EXISTS (SELECT * FROM VentaD d, Art a WHERE d.Articulo = a.Articulo AND d.ID = @ID AND a.Tipo NOT IN ('JUEGO', 'SERVICIO') AND (ISNULL(d.CantidadPendiente, 0.0) <> 0.0 OR ISNULL(d.CantidadOrdenada, 0.0) <> 0.0))
              SELECT @Ok = 20520
            ELSE SELECT @EstatusNuevo = 'CONCLUIDO', @AfectarMatando = 0
         END ELSE
         IF @Accion = 'CANCELAR'
           IF EXISTS (SELECT * FROM VentaD WHERE ID = @ID AND ISNULL(CantidadOrdenada, 0.0) <> 0.0)
             SELECT @Ok = 20530
      END ELSE
      IF @Estatus = 'PROCESAR'
      BEGIN
        IF @MovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR','VTAS.FM') AND @Accion = 'CANCELAR' 
          SELECT @AfectarVtasMostrador = 1
      END
    END ELSE

    IF @Modulo = 'COMS'
    BEGIN
      IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
      BEGIN
        IF @MovTipo = 'COMS.R' 
        BEGIN 
          IF @CfgAutorizarRequisiciones = 0 SELECT @EstatusNuevo = 'PENDIENTE' 
          ELSE SELECT @EstatusNuevo = 'AUTORIZARE' 
        END ELSE
        IF @MovTipo = 'COMS.C' SELECT @EstatusNuevo = 'CONFIRMAR'  ELSE
	IF @MovTipo IN ('COMS.O',/*'COMS.OP',*/'COMS.OG','COMS.OD','COMS.OI','COMS.IG','COMS.CC') SELECT @EstatusNuevo = 'PENDIENTE' 
-- SELECT @OrigenMovTipo
        IF @MovTipo IN ('COMS.EG', 'COMS.EI') AND @Accion <> 'GENERAR' AND @OrigenSubMovTipo <> 'COMS.EIMPO' EXEC spCompraCostoInv @ID  
      END ELSE
      IF @Estatus = 'AUTORIZARE' 
      BEGIN
        IF @MovTipo = 'COMS.R' AND @EstatusNuevo <> 'CANCELADO' SELECT @EstatusNuevo = 'PENDIENTE'
      END ELSE

      IF @Estatus = 'PENDIENTE'
      BEGIN
 	IF @MovTipo IN ('COMS.R','COMS.O','COMS.OP','COMS.OG','COMS.OD','COMS.OI','COMS.CC') AND @EstatusNuevo <> 'CANCELADO' SELECT @EstatusNuevo = 'PENDIENTE'
      END

/*      IF @MovTipo IN ('COMS.O','COMS.OP','COMS.OG','COMS.OI','COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.IG','COMS.D','COMS.DG','COMS.CC','COMS.DC') SELECT @AfectarAlmacenRenglon = 1*/
      IF @MovTipo = 'COMS.C' OR (@MovTipo = 'COMS.R' AND @Estatus = 'SINAFECTAR' AND @EstatusNuevo = 'AUTORIZARE') SELECT @AfectarDetalle = 0
      IF @MovTipo IN ('COMS.R', 'COMS.O','COMS.OP','COMS.CP','COMS.OG','COMS.OD','COMS.D','COMS.OI','COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.IG','COMS.CC','COMS.DC','COMS.DG') 
      BEGIN
	SELECT @AfectarMatando = 1
        IF @Utilizar = 1 AND @UtilizarMovTipo = 'COMS.C' SELECT @AfectarMatando = 0 -- Si viene de una cotizacion no matar
      END
      IF @MovTipo = 'COMS.DC' SELECT @DescuentoGlobal = 0.0
    END ELSE

    IF @Modulo = 'INV'
    BEGIN
      IF @MovTipo = 'INV.SOC' SELECT @AfectarMatando = 1
      IF @MovTipo = 'INV.EP' AND @Estatus = 'SINAFECTAR' AND @Accion = 'AFECTAR'
      BEGIN
        SELECT @EstatusNuevo = 'BORRADOR'
        UPDATE InvD SET Costo = NULL, CostoInv = NULL WHERE ID = @ID
      END
      IF @MovTipo = 'INV.IF' AND @Accion <> 'CANCELAR'
      BEGIN
        IF @CfgInvFisicoConteo=1 OR @Estatus = 'PENDIENTE' 
          SELECT @Generar = 1, @GenerarCopia = 0 
        ELSE SELECT @EstatusNuevo = 'PENDIENTE'
      END

      IF @MovTipo IN ('INV.T','INV.TC','INV.TG','INV.R','INV.P') SELECT @EsTransferencia = 1

      IF @MovTipo = 'INV.R' AND @Estatus <> 'PENDIENTE' SELECT @AfectarMatando = 1, @AfectarMatandoOpcional = 0
      IF @MovTipo IN ('INV.S', 'INV.CM', 'INV.SI', 'INV.E', 'INV.EI', 'INV.T', 'INV.TIF', 'INV.TC', 'INV.TG', 'INV.P', 'INV.SOL', 'INV.OT', 'INV.OI', 'INV.DTI', 'INV.TMA') SELECT @AfectarMatando = 1
      --IF @MovTipo = 'INV.EI' SELECT @VoltearAlmacen = 1 --@AlmacenTmp = @AlmacenDestino, @AlmacenDestino = @Almacen, @Almacen = @AlmacenTmp

      IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
      BEGIN
        IF @CfgInvConfirmarSolicitudes = 1 AND @MovTipo = 'INV.SOL' AND @Estatus = 'SINAFECTAR'
          SELECT @EstatusNuevo = 'CONFIRMAR'
        ELSE
          IF @MovTipo IN ('INV.P', 'INV.SOL', 'INV.OT', 'INV.OI', 'INV.TI','INV.SM') SELECT @EstatusNuevo = 'PENDIENTE' 

        IF @MovTipo IN ('INV.OT', 'INV.T','INV.TG') 
        BEGIN
          IF EXISTS(SELECT * FROM Alm o, Alm d WHERE o.Almacen = @Almacen AND d.Almacen = @AlmacenDestino AND o.Sucursal <> d.Sucursal) SELECT @Ok = 60360 ELSE
          IF EXISTS(SELECT * FROM InvD i, Alm o, Alm d WHERE i.ID = @ID AND i.Almacen = o.Almacen AND d.Almacen = @AlmacenDestino AND o.Sucursal <> d.Sucursal) SELECT @Ok = 60360
        END
        IF @MovTipo IN ('INV.T','INV.TG') 
        BEGIN
          IF @Largo = 1 
          BEGIN
  	    IF @AlmacenTransito IS NULL OR @AlmacenDestino IS NULL SELECT @Ok = 20120
	    SELECT @EstatusNuevo = 'PENDIENTE', @AlmacenDestino = @AlmacenTransito
          END
        END
        IF @Accion = 'AFECTAR' AND @EstatusNuevo <> 'CONFIRMAR' AND
           @MovTipo IN ('INV.SOL', 'INV.OT', 'INV.OI') AND @CfgPedidosReservar = 1 AND @SeguimientoMatriz = 0
          IF @CfgPedidosReservarEsp = 0 OR EXISTS(SELECT * FROM EmpresaPedidosReservarEsp WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov)
            IF ABS(DATEDIFF(day, GETDATE(), @FechaEmision)) < 2
              IF @Directo = 1
 	        SELECT @Accion = 'RESERVARPARCIAL'
              ELSE
                SELECT @VolverAfectar = 5
        IF @MovTipo = 'INV.EI' AND @Accion <> 'GENERAR' EXEC spInvCostoInv @ID  
      END 

      ELSE      
      IF @Estatus = 'PENDIENTE'
      BEGIN
	IF @MovTipo IN ('INV.T','INV.TG') BEGIN IF @Accion = 'CANCELAR' SELECT @AlmacenDestino = @AlmacenTransito ELSE SELECT @AlmacenEspecifico = @AlmacenTransito /*@Almacen = @AlmacenTransito*/ END ELSE
        IF @MovTipo = 'INV.P' AND @Accion <> 'CANCELAR' SELECT @VoltearAlmacen = 1 --@AlmacenTmp = @AlmacenDestino, @AlmacenDestino = @Almacen, @Almacen = @AlmacenTmp
 	IF @MovTipo IN ('INV.SOL', 'INV.OT', 'INV.OI', 'INV.TI','INV.SM') AND @EstatusNuevo <> 'CANCELADO' SELECT @EstatusNuevo = 'PENDIENTE'
      END
    END ELSE

    IF @Modulo = 'PROD'
    BEGIN
      SELECT @AfectarAlmacenRenglon = 1
      IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
      BEGIN
	IF @MovTipo = 'PROD.O'
        BEGIN
          SELECT @EstatusNuevo = 'PENDIENTE' 
          EXEC spProdAutoSerieLote @CfgProdAutoLote, @Sucursal, @ID
        END
      END ELSE
      IF @Estatus = 'PENDIENTE'
      BEGIN
 	IF @MovTipo = 'PROD.O' AND @EstatusNuevo <> 'CANCELADO' SELECT @EstatusNuevo = 'PENDIENTE'
        IF @MovTipo IN ('PROD.A', 'PROD.R', 'PROD.E') AND @Accion <> 'CANCELAR' SELECT @EstatusNuevo = 'CONCLUIDO'
      END      
      IF @MovTipo IN (/*'PROD.O', */'PROD.E', 'PROD.CO') SELECT @AfectarMatando = 1
    END 

    IF @Accion = 'GENERAR' OR (@Accion IN ('RESERVAR', 'DESRESERVAR', 'ASIGNAR', 'DESASIGNAR') AND @Base = 'TODO') SELECT @Verificar = 0
    /* Si no se verifica en algunar cancelaciones como la entrada de compra, no checa que exista disponible para cancelar */
    --IF @Accion = 'CANCELAR' AND @Base = 'TODO' AND @Estatus = 'CONCLUIDO' SELECT @Verificar = 0

    IF @Accion = 'RESERVAR' AND @Base = 'PENDIENTE' SELECT @Accion = 'RESERVARPARCIAL'
    IF @MovTipo IN ('COMS.CC', 'COMS.DC', 'INV.TG') SELECT @AfectarConsignacion = 1

    EXEC xpInvAccion @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @MovTipo, @Base, @Estatus, @EstatusNuevo, @Directo, @Accion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    IF @Accion = 'CANCELAR' AND @EsTransferencia = 1 AND @MovTipo NOT IN ('VTAS.DC', 'VTAS.DCR')
      SELECT @VoltearAlmacen = ~@VoltearAlmacen -- @AlmacenTmp = @AlmacenDestino, @AlmacenDestino = @Almacen, @Almacen = @AlmacenTmp  

    IF @Almacen        IS NOT NULL SELECT @AlmacenTipo        = UPPER(Tipo) FROM Alm WHERE Almacen = @Almacen
    IF @AlmacenDestino IS NOT NULL SELECT @AlmacenDestinoTipo = UPPER(Tipo) FROM Alm WHERE Almacen = @AlmacenDestino

    IF @Estatus IN ('SINAFECTAR','AUTORIZARE','CONFIRMAR','BORRADOR') AND @Accion <> 'CANCELAR'
    BEGIN
      IF @MovTipo = 'VTAS.FR' 
        EXEC spCalcularPeriodicidad @FechaEmision, @Periodicidad, @Vencimiento OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      ELSE
        EXEC spCalcularVencimiento @Modulo, @Empresa, @ClienteProv, @Condicion, @FechaEmision, @Vencimiento OUTPUT, @Dias OUTPUT, @Ok OUTPUT 
      EXEC spExtraerFecha @Vencimiento OUTPUT
    END

    IF @Accion = 'DESAFECTAR' 
      EXEC spInvDesafectar @Modulo, @ID, @Usuario, @MovTipo, @Estatus, @Ok OUTPUT, @OkRef OUTPUT

    IF ((@Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'PENDIENTE') AND @Accion <> 'GENERAR') OR @Accion = 'CANCELAR') 
    BEGIN
      IF @Modulo = 'VTAS' AND @Condicion IS NOT NULL AND EXISTS(SELECT * FROM Condicion WHERE Condicion = @Condicion AND ControlAnticipos = 'COBRAR PEDIDO')
        SELECT @CobrarPedido = 1
      IF @MovTipo IN ('VTAS.P', 'VTAS.S', 'VTAS.SD', 'VTAS.VP', 'VTAS.B') AND @CobrarPedido = 1
        SELECT @CobroIntegrado = 1
      IF @MovTipo IN ('VTAS.N','VTAS.FM') AND @CobrarPedido = 0
        SELECT @CobroIntegrado = 1
      IF @MovTipo IN ('VTAS.F','VTAS.FAR', 'VTAS.FB', 'VTAS.D', 'VTAS.DF') AND @CfgFacturaCobroIntegrado = 1 AND @Vencimiento<=@FechaEmision AND @CobrarPedido = 0
      BEGIN
        SELECT @CobroIntegrado = 1
        IF @CfgFacturaCobroIntegradoParcial = 1 AND (SELECT FacturaCobroIntegradoParcial FROM Condicion WHERE Condicion = @Condicion) = 1 
          SELECT @CobroIntegradoParcial = 1
      END
      IF @Modulo = 'VTAS' AND (@OrigenTipo='CR' OR @EsCancelacionFactura = 1 OR @OrigenTipo='VMOS')
        SELECT @CobroIntegrado = 0
      IF @CobroIntegrado = 1 AND @CfgVentaLiquidaIntegral = 1 AND @CfgVentaLiquidaIntegralCxc = 1 
        SELECT @CobroIntegradoCxc = 1
    END

    IF @CfgSeriesLotesMayoreo = 1 AND @Accion IN ('AFECTAR', 'VERIFICAR') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR')
      EXEC spInvQuitarBasura @Empresa, @Modulo, @ID, @Conexion, @SincroFinal, @Sucursal

    IF @MovTipo IN ('INV.SI', 'INV.DTI') AND @Accion = 'CANCELAR' AND @Ok IS NULL 
    BEGIN
      SELECT @IDTransito = MIN(DID) FROM MovFlujo WHERE Cancelado = 0 AND Sucursal = @Sucursal AND Empresa = @Empresa AND OModulo = @Modulo AND OID = @ID AND DModulo = @Modulo
      IF @IDTransito IS NULL 
      BEGIN
        IF (SELECT fixCancelarTraspasoSinTransito FROM EmpresaGral WHERE Empresa = @Empresa) = 0
          SELECT @Ok = 25420
      END
      IF @Ok IS NULL AND @IDTransito IS NOT NULL
      BEGIN
        SELECT @TransitoSucursal = Sucursal, @TransitoMov = Mov, @TransitoMovID = MovID, @TransitoEstatus = Estatus FROM Inv WHERE ID = @IDTransito
        EXEC spPuedeEditarMovMatrizSucursal @TransitoSucursal, /*@TransitoSucursal*/@Sucursal, @IDTransito, @Modulo, @Empresa, @Usuario, @TransitoMov, @TransitoEstatus, 1, @PuedeEditar OUTPUT
        IF @PuedeEditar = 0 SELECT @Ok = 25430 ELSE
        IF @TransitoEstatus = 'CONCLUIDO' SELECT @Ok = 60050 ELSE
        IF EXISTS(SELECT * FROM InvD WHERE CantidadPendiente<>Cantidad AND ID = @IDTransito) SELECT @Ok = 60080
        IF @Ok IS NULL
        BEGIN
          EXEC spEmbarqueMov @Accion, @Empresa, @Modulo, @IDTransito, @TransitoMov, @TransitoMovID, @TransitoEstatus, @EstatusNuevo, @CfgEmbarcar, @Ok OUTPUT
          IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@TransitoMov)+' '+RTRIM(@TransitoMovID)
        END
      END
    END
    IF @Accion = 'CANCELAR' AND @Base IN ('SELECCION', 'PENDIENTE') AND @MovTipo <> 'COMS.O' SELECT @AfectarMatando = 0
    IF @Accion = 'CANCELAR' AND @MovTipo = 'PROD.CO' SELECT @Ok = 10100

    -- Autotransportes
    IF @CfgAutotransportes = 1 AND @Espacio IS NOT NULL AND @Modulo = 'VTAS' AND @Accion <> 'CANCELAR' AND @Estatus = 'SINAFECTAR' AND @AccionEspecial <> 'AUTO_MANT' AND @MovTipo = 'VTAS.P' AND @AutoCorrida IS NOT NULL AND @Ok IS NULL
      EXEC xpGenerarAutoCorrida @ID, @Empresa, @Sucursal, @Mov, @AutoCorrida, @Almacen, @FechaRequerida, @Espacio, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo = 'COMS.OP' AND @Accion = 'AFECTAR'
      EXEC spCompraProrrateoPreparar @Empresa, @ID, @Ok OUTPUT, @OkRef OUTPUT

 
    /* Esto antes estaba en spInvVerificar */
    IF @Accion = 'CANCELAR' AND (@Base = 'TODO' OR (@MovTipo NOT IN ('INV.SM', 'INV.OT', /** JH 22.08.2006 **/ 'INV.OI')))	-- Unicamente la Orden Consumo, Orden Transferencia  y Orde Traspaso se puede cancelar parcialmente, por el momento
    BEGIN
      -- Checar que se haya capturado el movimiento en este modulo
      IF @Conexion = 0 
        IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo) AND @MovTipo <> 'INV.CM'
        BEGIN
          SELECT @Ok = 60071

          -- Para que permita Cancelar GenerarOT desde ventas
          IF @MovTipo IN ('INV.OT', 'INV.OI') AND @OrigenMovTipo IN ('VTAS.P', 'VTAS.S') SELECT @Ok = NULL
          IF @OrigenTipo = 'PACTO' SELECT @Ok = NULL
          IF @Ok = 60071
            EXEC xpOk_60071 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
        END
    END

    -- Verificar antes de Afectar
    IF ((@Conexion = 0 OR @InvVerificarEnConexion = 1 OR @Accion ='VERIFICAR' OR @OrigenTipo = 'I:MES') OR @AccionEspecial = 'TRANSITO') AND @Accion NOT IN ('CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL AND @Verificar = 1
    BEGIN
      EXEC spInvVerificar @ID, @Accion, @Base, @Empresa, @Usuario, @Autorizacion OUTPUT, @Mensaje, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Ejercicio, @Periodo, 
                          @Almacen, @AlmacenTipo, @AlmacenDestino, @AlmacenDestinoTipo, @VoltearAlmacen, @AlmacenEspecifico, @Condicion, @Vencimiento,
		    	  @ClienteProv, @EnviarA, @DescuentoGlobal, @SobrePrecio, @ConCredito, @ConLimiteCredito, @LimiteCredito, @ConLimitePedidos, @LimitePedidos, @MonedaCredito, @TipoCambioCredito, @DiasCredito, @CondicionesValidas,
                          @PedidosParciales, @VtasConsignacion, @AlmacenVtasConsignacion, @AnticiposFacturados,
			  @Estatus, @EstatusNuevo, @AfectarMatando, @AfectarMatandoOpcional, @AfectarConsignacion, @AfectarAlmacenRenglon, 
    	   		  @OrigenTipo, @Origen, @OrigenID, @OrigenMovTipo,
                          @FacturarVtasMostrador, @EsTransferencia, @ServicioGarantia, @ServicioArticulo, @ServicioSerie, @FechaRequerida, @AutoCorrida,
                          @CfgCosteoNivelSubCuenta, @CfgDecimalesCantidades, @CfgSeriesLotesMayoreo, @CfgSeriesLotesAutoOrden, @CfgValidarPrecios, @CfgPrecioMinimoSucursal, @CfgValidarMargenMinimo, @CfgVentaSurtirDemas, @CfgCompraRecibirDemas, @CfgCompraRecibirDemasTolerancia, @CfgTransferirDemas, @ChecarCredito, @CfgVentaPedidosDisminuyenCredito, @BloquearMorosos, @CfgVentaLiquidaIntegral, @CfgFacturaCobroIntegrado, @CfgInvPrestamosGarantias, 
                          @CfgInvEntradasSinCosto, @CfgServiciosRequiereTareas, @CfgServiciosValidarID, @CfgImpInc, @CfgLimiteRenFacturas, @CfgNotasBorrador, @CfgAnticiposFacturados, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CfgCompraFactorDinamico, @CfgInvFactorDinamico, @CfgProdFactorDinamico, @CfgVentaFactorDinamico, @CfgToleranciaCosto, @CfgToleranciaCostoInferior, @CfgToleranciaTipoCosto, @CfgFormaPagoRequerida, @CfgBloquearNotasNegativas, @CfgBloquearFacturacionDirecta, @CfgBloquearInvSalidaDirecta, @SeguimientoMatriz, @CobroIntegrado, @CobroIntegradoCxc, @CobroIntegradoParcial, @CobrarPedido, @CfgCompraValidarArtProv, 
                          @CfgValidarCC, @CfgVentaRestringida, @CfgLimiteCreditoNivelGrupo, @CfgLimiteCreditoNivelUEN, @CfgRestringirArtBloqueados, @CfgValidarFechaRequerida, @FacturacionRapidaAgrupada,
			  @Utilizar, @UtilizarID, @UtilizarMovTipo, 
			  @Generar, @GenerarMov, @GenerarAfectado, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @AccionEspecial, @AnexoID,
                          @Autorizar OUTPUT, @AfectarConsecutivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 
			  @CfgPrecioMoneda = @CfgPrecioMoneda

      IF @Autorizar = 1 AND @Modulo IN ('VTAS', 'COMS')
      BEGIN
        IF @Modulo = 'VTAS' UPDATE Venta  SET Mensaje = @Ok WHERE ID = @ID ELSE
        IF @Modulo = 'COMS' UPDATE Compra SET Mensaje = @Ok WHERE ID = @ID
        IF @@ERROR <> 0 SELECT @Ok = 1
      END

      -- Si la Nota es por Devolucion ponerla Pendiente
      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR','GENERAR','CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END

    -- Autotransportes
    IF @CfgAutotransportes = 1 AND @Espacio IS NOT NULL AND @Modulo = 'VTAS' AND @Accion NOT IN ('CANCELAR', 'GENERAR') AND @Estatus = 'SINAFECTAR' AND @AccionEspecial <> 'AUTO_MANT' AND @Ok IS NULL
      EXEC xpAutoMant @ID, @Mov, @Almacen, @Usuario, @Empresa, @FechaEmision, @FechaRegistro, @Espacio, @AutoKmsActuales, @Ok OUTPUT, @OkRef OUTPUT

    -- Actualizar Placas
    IF @MovTipo = 'VTAS.S' AND @Accion <> 'CANCELAR' AND @ServicioSerie IS NOT NULL AND @Ok IS NULL
      UPDATE VIN SET Empresa = @Empresa, Cliente = @ClienteProv, Placas = @ServicioPlacas, Km = @ServicioKms WHERE VIN = @ServicioSerie 

    -- Actualizar Fecha Ultimo Servicio
    IF @MovTipo = 'VTAS.F' AND @OrigenMovTipo = 'VTAS.S' AND @Accion <> 'CANCELAR' AND @ServicioSerie IS NOT NULL AND @Ok IS NULL
    BEGIN
      UPDATE VIN SET FechaUltimoServicio = @FechaEmision WHERE VIN = @ServicioSerie 
      UPDATE Venta SET FechaOriginal = @FechaEmision WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
    END

    IF @Accion <> 'VERIFICAR' AND @Ok IS NULL AND @EstatusNuevo <> 'BORRADOR'
    BEGIN  
      IF @AnexarTodoDetalle = 1 AND @Ok IS NULL
      BEGIN
        EXEC spInvAnexarTodoDetalle @Empresa, @Modulo, @ID, @AnexoID, @CfgImpInc, @CfgMultiUnidades, @Ok OUTPUT, 
				    @CfgPrecioMoneda = @CfgPrecioMoneda
        IF @OK IS NULL AND @Modulo = 'VTAS' AND @AnexoID IS NOT NULL AND @MovTipo IN ('VTAS.P', 'VTAS.S') 
          IF @CfgPedidosReservar = 1 AND @SeguimientoMatriz = 0        
            IF @CfgPedidosReservarEsp = 0 OR EXISTS(SELECT * FROM EmpresaPedidosReservarEsp WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov)
              EXEC spAfectar 'VTAS', @AnexoID, 'RESERVARPARCIAL', 'SELECCION', @Usuario = @Usuario, @ok = @ok Output, @OkRef = @OkRef Output
      END
          
      EXEC spInvAfectar @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
                        @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 
                        @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
                        @Almacen, @AlmacenTipo, @AlmacenDestino, @AlmacenDestinoTipo, @VoltearAlmacen, @AlmacenEspecifico, @Largo, @Condicion, @Vencimiento, @Periodicidad, @EndosarA,
			@ClienteProv, @EnviarA, @DescuentoGlobal, @SobrePrecio, @Agente, @AnticiposFacturados, @ServicioArticulo, @ServicioSerie, @FechaRequerida, @ZonaImpuesto,
    	   		@OrigenTipo, @Origen, @OrigenID, @OrigenMovTipo,
                        /*@CfgAutoConsig, */@CfgFormaCosteo, @CfgTipoCosteo, @CfgCosteoActividades, @CfgCosteoNivelSubCuenta, @CfgCosteoMultipleSimultaneo, @CfgPosiciones, @CfgExistenciaAlterna, @CfgExistenciaAlternaSerieLote, @CfgSeriesLotesMayoreo, @CfgSeriesLotesAutoCampo, @CfgSeriesLotesAutoOrden, @CfgCosteoSeries, @CfgCosteoLotes, @CfgValidarLotesCostoDif,
 			@CfgVentaSurtirDemas, @CfgCompraRecibirDemas, @CfgTransferirDemas, @CfgBackOrders, @CfgContX, @CfgContXGenerar, @CfgContXFacturasPendientes, @CfgEmbarcar, @CfgImpInc, @CfgVentaContratosArticulo, @CfgVentaContratosImpuesto, 
	                @CfgVentaComisionesCobradas, @CfgAnticiposFacturados, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CfgCompraFactorDinamico, @CfgInvFactorDinamico, @CfgProdFactorDinamico, @CfgVentaFactorDinamico, @CfgCompraAutoCargos, @CfgVentaAutoBonif, @CfgVINAccesorioArt, @CfgVINCostoSumaAccesorios, @SeguimientoMatriz, @CobroIntegrado, @CobroIntegradoCxc, @CobroIntegradoParcial,  @CobrarPedido,
                        @AfectarDetalle, @AfectarMatando, @AfectarVtasMostrador, @FacturarVtasMostrador, @AfectarConsignacion, @AfectarAlmacenRenglon, @CfgVentaMultiAgente, @CfgVentaMultiAlmacen, @CfgVentaArtAlmacenEspecifico, @CfgTipoMerma, @CfgComisionBase, @CfgLimiteRenFacturas, @CfgVentaRedondeoDecimales, @CfgCompraCostosImpuestoIncluido,
                        @AfectarConsecutivo, @EsTransferencia, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
                        @Utilizar, @UtilizarID, @UtilizarMov, @UtilizarSerie, @UtilizarMovTipo, @UtilizarMovID, 
			@Generar, @GenerarMov, @GenerarSerie, @GenerarAfectado, @GenerarCopia, @GenerarPoliza, @GenerarOP, @GenerarGasto, @FacturacionRapidaAgrupada,
                        @IDTransito OUTPUT, @IDGenerar OUTPUT, @GenerarMovID OUTPUT, @ContID OUTPUT, 
                        @Ok OUTPUT, @OkRef OUTPUT,
                        @CfgPrecioMoneda = @CfgPrecioMoneda, @EstacionTrabajo = @Estacion -- REQ12336

      IF @MovTipo = 'PROD.O' AND @Accion = 'AFECTAR' AND @CfgProdAutoCB <> 'NO' AND @Ok IS NULL
        EXEC spProdAutoCB @CfgProdAutoCB, @Sucursal, @ID

      -- Si Cancelan la Devolucion (Automatica x Cancelacion Otros Meses) que libere la Factura
      IF @MovTipo IN ('VTAS.D', 'VTAS.DF')  AND @Accion = 'CANCELAR' AND @Ok IS NULL AND @CancelacionID IS NOT NULL
         UPDATE Venta SET CancelacionID = NULL WHERE CancelacionID = @CancelacionID
		
		--Bugd 5993, 3786
		IF (@Utilizar = 0 OR @Generar = 0 AND @MovTipo IN( 'INV.OT', 'INV.OI', 'INV.SI', 'INV.TI', 'INV.EI'))
		BEGIN
			DECLARE C_FechaCaducidad CURSOR FOR 
				SELECT Articulo 
			  	  FROM INVD 
				 WHERE ID = @ID
                 GROUP BY Articulo

			OPEN C_FechaCaducidad

			FETCH NEXT FROM C_FechaCaducidad 
			INTO @ArticuloFC

			WHILE @@FETCH_STATUS = 0
			BEGIN
				SELECT @FechaCaducidad = FechaCaducidad
				  FROM Tarima
				 WHERE Articulo = @ArticuloFC
				   AND Estatus = 'ALTA'

				IF @FechaCaducidad IS NOT NULL
					UPDATE INVD 
					   SET FechaCaducidad = @FechaCaducidad
					 WHERE ID = @ID
					   AND Articulo = @ArticuloFC

				FETCH NEXT FROM C_FechaCaducidad 
				INTO @ArticuloFC
			END 
			CLOSE C_FechaCaducidad;
			DEALLOCATE C_FechaCaducidad;
		END

      IF (@Utilizar = 1 OR @Generar = 1) AND @Ok IS NULL
      BEGIN
SELECT @CrossDocking  = CrossDocking, 
			   @Almacen       = Almacen,
			   @PosicionWMS   = PosicionWMS 
		  FROM INV 
		 WHERE ID = @ID

		 SELECT @EsCrossDocking       = EsCrossDocking,
				@posicioncrossdocking = ISNULL(defposicioncrossdocking,'') 
		   FROM ALM 
		  WHERE Almacen = @Almacen

			-- Avisar Movimiento generado
			IF @Ok IS NULL AND @Accion <> 'CANCELAR' AND @CrossDocking <> 1 OR RTRIM(LTRIM(@EsCrossDocking)) = 'No'
			  SELECT @Ok = 80030, @OkRef = NULL    

		IF @CrossDocking = 1 AND RTRIM(LTRIM(@EsCrossDocking)) = 'No' AND @Modulo = 'INV' AND RTRIM(LTRIM(@MovTipo)) = 'INV.TMA'
		BEGIN
			DECLARE C_ActualizaTarimaPCD CURSOR FOR 
				SELECT Tarima 
				  FROM INVD 
				 WHERE ID = @IDGenerar
				 GROUP BY Articulo, Tarima

			OPEN C_ActualizaTarimaPCD

			FETCH NEXT FROM C_ActualizaTarimaPCD 
			INTO @Tarima

			WHILE @@FETCH_STATUS = 0
			BEGIN
			
				IF @Tarima IS NOT NULL
					UPDATE Tarima 
					   SET Posicion = @posicioncrossdocking
					 WHERE Tarima = @Tarima	
			 		
			FETCH NEXT FROM C_ActualizaTarimaPCD 
			INTO @Tarima
			END 
			CLOSE C_ActualizaTarimaPCD;
			DEALLOCATE C_ActualizaTarimaPCD;
		END
		
		IF @CrossDocking = 1 AND RTRIM(LTRIM(@EsCrossDocking)) = 'Si' AND @Modulo = 'INV' AND RTRIM(LTRIM(@MovTipo)) = 'INV.TMA'
		BEGIN
			/* Concluye el Entarimado y genera la Solicitud de Acomodo en TMA */                    
			EXEC spAfectar 'INV', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Estacion = @Estacion

            /* Se obtiene el Mov y MovID para encontrar el Mov la Solicitud de Acomodo en TMA */
            SELECT @OrigenWMS   = Mov,
                   @OrigenIDWMS = MovID
              FROM INV 
             WHERE ID = @IDGenerar   
            
            /* Se obtiene el ID de la Solicitud de Acomodo */  
            SELECT @IDGenerarSATMA = ID FROM TMA WHERE ORIGEN = @OrigenWMS AND ORIGENID = @OrigenIDWMS            

			EXEC spMovPos  @Estacion, 'INV', @IDGenerar	           

			SELECT @DID = MovPos.DID 
			  FROM MovPos
			  LEFT OUTER JOIN MovPos MovPosLista ON MovPos.Estacion=MovPosLista.Estacion AND MovPos.Modulo=MovPosLista.Modulo AND MovPos.Tipo=MovPosLista.Tipo AND MovPos.Rama=MovPosLista.Clave
			 WHERE MovPos.Estacion = @Estacion AND MovPos.Modulo = 'INV' AND MovPos.Tipo = 'DESTINO' and MovPos.dmov = 'Solicitud Acomodo' AND MovPos.OESTATUS = 'CONCLUIDO'

			 UPDATE TMAD 
				SET PosicionDestino = @posicioncrossdocking 
			 WHERE ID = @DID 
            
			/* Se comenta esta seccion de codigo ya que no se tiene definido montacargas y acomodador para cross docking
				/* Afecta Solicitud de Acomodo por todo el pendiente */                   
				EXEC @IDGenerarOATMA = spAfectar 'TMA', @IDGenerarSATMA, 'GENERAR', 'Pendiente', 'Orden Acomodo', @Usuario, @EnSilencio = 1, @Estacion = @Estacion            

				/* Se actualiza Montacargas y Acomodador */
				UPDATE TMA SET Agente = 'C.DOCKING', Montacarga = 'C.DOCKING' WHERE ID = @IDGenerarOATMA
            
				/* Afecta Orden de Acomodo */
				EXEC spAfectar 'TMA', @IDGenerarOATMA, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Estacion = @Estacion
            
				/* Afecta Orden de Acomodo por todo el pendiente y Genero Acomodo */
				EXEC @IDGenerarATMA = spAfectar 'TMA', @IDGenerarOATMA, 'GENERAR', 'Pendiente', 'Acomodo', @Usuario, @EnSilencio = 1, @Estacion = @Estacion

				/* Afecta y concluyo el Acomodo */
				EXEC spAfectar 'TMA', @IDGenerarATMA, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Estacion = @Estacion
			*/
		END
      END
    END ELSE
      IF @EstatusNuevo IN ('CONFIRMAR', 'BORRADOR') EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT, @EstatusNuevo = @EstatusNuevo 
  END ELSE 
  BEGIN
    IF @Ok <> 80030
    BEGIN
--SELECT @Estatus, @Accion
      IF @Estatus IN ('SINAFECTAR','SINCRO','BORRADOR','CONFIRMAR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
      IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
      IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010 
      ELSE SELECT @Ok = ISNULL(@Ok, 60040)
    END
  END

  IF @MovTipo = 'INV.EP' AND @EstatusNuevo = 'BORRADOR' AND @Ok IS NULL AND @Accion <> 'CANCELAR'
    EXEC spInvEntradaProductoGenerarConsumoMaterial @Accion, @Empresa, @ID, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @OrigenTipo = 'PLAN' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Ok IN (80030, NULL)
  BEGIN
    IF @AccionOriginal = 'CANCELAR' 
      UPDATE PlanArtOP 
         SET LiberacionModulo = NULL, LiberacionID = NULL, LiberacionMov = NULL, LiberacionMovID = NULL, Estado = 'Plan'
       WHERE LiberacionModulo = @Modulo AND LiberacionID = @ID /*AND LiberacionMov = @Mov AND LiberacionMovID = @MovID*/
    ELSE
    IF @AccionOriginal = 'AFECTAR'
    BEGIN
      DELETE PlanArtOP 
       WHERE LiberacionModulo = @Modulo AND LiberacionID = @ID /*AND LiberacionMov = @Mov AND LiberacionMovID = @MovID*/
    END
  END

  IF @MovTipo IN ('VTAS.C', 'VTAS.CS') AND @Accion = 'CANCELAR'
    EXEC spEmbarqueMov @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Estatus, @EstatusNuevo, @CfgEmbarcar, @Ok OUTPUT

  --BUG16186
  IF @Accion = 'CANCELAR' AND @MovTipo IN ('VTAS.F','VTAS.FAR','VTAS.P') AND @CfgCancelarFacturaReservarPedido = 1 AND @Ok IS NULL
    SELECT @VolverAfectar = 4

  IF @Accion <> 'CANCELAR' AND @MovTipo = 'VTAS.F' AND @CfgFacturasPendientes = 1 AND @EstatusNuevo = 'PENDIENTE' AND @Ok IS NULL 
    IF NOT EXISTS (SELECT * FROM VentaD d, Art a WHERE d.Articulo = a.Articulo AND d.ID = @ID AND a.Tipo NOT IN ('JUEGO', 'SERVICIO') AND (ISNULL(ROUND(d.CantidadPendiente, 4), 0.0) <> 0.0 OR ISNULL(ROUND(d.CantidadOrdenada, 4), 0.0) <> 0.0))
      SELECT @VolverAfectar = 1

  IF @Estatus = 'SINAFECTAR' AND @Accion <> 'CANCELAR' AND @MovTipo IN ('VTAS.P', 'VTAS.S', 'INV.SOL','INV.OT', 'INV.OI','INV.SM') AND @CfgBackOrders = 1 AND @CfgBackOrdersNivel = 'MOVIMIENTO' AND @CfgAutoAsignarBackOrders = 1 AND @EstatusNuevo = 'PENDIENTE' AND @Ok IS NULL AND @OrigenMovTipo IS NULL
    IF EXISTS (SELECT * FROM VentaD d, Art a WHERE d.Articulo = a.Articulo AND d.ID = @ID AND a.Tipo NOT IN ('JUEGO', 'SERVICIO') AND ISNULL(ROUND(d.CantidadPendiente, 4), 0.0) <> 0.0)
      SELECT @VolverAfectar = 2

  IF @Accion = 'SINCRO' AND @Ok = 80060 
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
    IF @EnLinea = 1 EXEC spSincroFinalModulo @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END

  /* Aqui estaba antes la generacion del transito */

  IF @MovTipo = 'INV.IF' AND @Accion = 'AFECTAR' AND @Ok IS NULL
    UPDATE Inv SET Conteo = 2 WHERE ID = @ID AND Conteo IS NULL

  IF @AccionEspecial = 'TRANSITO' AND @Ok IS NULL
    SELECT @Ok = 80030, @OkRef = 'Movimiento: '+RTRIM(@Mov)+ ' ' +LTRIM(Convert(varchar, @MovID))

  -- Si hay Mensaje pero no tiene referencia
  IF @Ok IS NOT NULL AND @OkRef IS NULL 
  BEGIN

    -- Si se Genero un Movimiento, Desplegarlo
    IF @Ok = 80030
    BEGIN
      IF @Utilizar = 1 SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)        + ' ' +LTRIM(Convert(varchar, @MovID))
      IF @Generar  = 1 SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov) + ' ' +LTRIM(Convert(varchar, @GenerarMovID))
    END

    -- Si hubo un error poner como referencia el Movimiento
    ELSE
      SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(varchar, @MovID)), @IDGenerar = NULL
  END
  RETURN
END
GO


/**************** spInvRefacturar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvRefacturar') and type = 'P') drop procedure dbo.spInvRefacturar
GO             
CREATE PROCEDURE spInvRefacturar
                   @ID        		int,
		   @Usuario   		char(10),
    		   @FechaRegistro	datetime,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,
    		   @IDGenerar		int		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal		int,
    @Empresa		char(5),
    @OMov		char(20),
    @OMovID		varchar(20),
    @DMov		char(20),
    @DMovID		varchar(20),
    @FechaEmision	datetime,
    @VolverAfectar	int,
    @Directo		bit

  SELECT @FechaEmision = @FechaRegistro, @Ok = NULL, @OkRef = NULL, @IDGenerar = NULL
  EXEC spExtraerFecha @FechaEmision OUTPUT
  SELECT @OMov = Mov, @OMovID = MovID, @Empresa = Empresa, @Sucursal = Sucursal, @Directo = Directo FROM Venta WHERE ID = @ID

  BEGIN TRANSACTION

    EXEC spInv @ID, 'VTAS', 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL, NULL, NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT
    IF @Ok IS NULL
    BEGIN
      EXEC @IDGenerar = spMovCopiar @Sucursal, 'VTAS', @ID, @Usuario, @FechaEmision, 1, 1, @Directo

      EXEC spInv @IDGenerar, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL, NULL, NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT   
      IF @VolverAfectar = 1 
        EXEC spInv @IDGenerar, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL, NULL, NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT

      SELECT @DMov = Mov, @DMovID = MovID FROM Venta WHERE ID = @IDGenerar
      EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'VTAS', @ID, @OMov, @OMovID, 'VTAS', @IDGenerar, @DMov, @DMovID, @Ok OUTPUT 
    END
  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION
END
GO

/**************** spCancelarFacturaReservarPedido ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCancelarFacturaReservarPedido') and type = 'P') drop procedure dbo.spCancelarFacturaReservarPedido
GO             
CREATE PROCEDURE spCancelarFacturaReservarPedido		   
                   @ID        		int,
		   @Usuario   		char(10),
    		   @FechaRegistro	datetime,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa    	char(5),
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Almacen		char(10),
    @Unidad			varchar(50),
    @Cantidad		float,
    @Aplica			char(20),
    @AplicaID		char(20),
    @IDPedido		int,
    @IDGenerar		int, 
    @ContID			int,
    @VolverAfectar	int, 
	@AplicaRenglon	float

  DECLARE @Pedidos TABLE (ID int NOT NULL)

  DECLARE crAplica CURSOR FOR 
   SELECT v.Empresa, RTRIM(d.Aplica), RTRIM(d.AplicaID), d.Almacen, d.Articulo, NULLIF(RTRIM(d.SubCuenta), ''), Unidad, ISNULL(Cantidad, 0), d.AplicaRenglon
     FROM Venta v, VentaD d
    WHERE v.ID = d.ID AND v.ID = @ID AND d.Aplica IS NOT NULL AND d.AplicaID IS NOT NULL AND ISNULL(Cantidad, 0) > 0

  OPEN crAplica
  FETCH NEXT FROM crAplica INTO @Empresa, @Aplica, @AplicaID, @Almacen, @Articulo, @SubCuenta, @Unidad, @Cantidad, @AplicaRenglon
  WHILE @@FETCH_STATUS <> -1 
  BEGIN   
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @IDPedido = NULL
      SELECT @IDPedido = ID 
        FROM Venta v, MovTipo mt
       WHERE v.Empresa = @Empresa AND v.Mov = @Aplica AND v.MovID = @AplicaID AND v.Estatus = 'PENDIENTE'
         AND mt.Modulo = 'VTAS' AND mt.mov = v.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S')
      IF @IDPedido IS NOT NULL
      BEGIN
        IF NOT EXISTS(SELECT * FROM @Pedidos WHERE ID = @IDPedido) 
        BEGIN
          INSERT @Pedidos (ID) VALUES (@IDPedido)
          UPDATE VentaD SET CantidadA = NULL WHERE ID = @IDPedido
        END
        UPDATE VentaD 
           SET CantidadA = ISNULL(CantidadA, 0)+@Cantidad 
          FROM VentaD d, Art a
         WHERE d.ID = @IDPedido AND d.Almacen = @Almacen AND d.Articulo = @Articulo AND NULLIF(RTRIM(d.SubCuenta), '') = @SubCuenta AND d.Unidad = @Unidad 
           AND a.Articulo = d.Articulo AND a.Tipo NOT IN ('SERVICIO', 'JUEGO') AND ISNULL(@AplicaRenglon,Renglon) = Renglon
      END
    END
    FETCH NEXT FROM crAplica INTO @Empresa, @Aplica, @AplicaID, @Almacen, @Articulo, @SubCuenta, @Unidad, @Cantidad, @AplicaRenglon
  END
  CLOSE crAplica
  DEALLOCATE crAplica

  DECLARE crPedidos CURSOR FOR
   SELECT ID FROM @Pedidos
  OPEN crPedidos
  FETCH NEXT FROM crPedidos INTO @IDPedido
  WHILE @@FETCH_STATUS <> -1 
  BEGIN   
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF EXISTS(SELECT * FROM VentaD WHERE ID = @IDPedido AND NULLIF(CantidadA, 0.0) IS NOT NULL)
        EXEC spInv @IDPedido, 'VTAS', 'RESERVAR', 'SELECCION', @FechaRegistro, @Aplica, @Usuario, 0, 0, NULL,
                   @Aplica, @AplicaID, @IDGenerar, @ContID,
                   @Ok, @OkRef, @VolverAfectar
    END
    FETCH NEXT FROM crPedidos INTO @IDPedido
  END
  CLOSE crPedidos
  DEALLOCATE crPedidos
END
GO


/*
declare
  @ok int,
  @okref varchar(255)
exec spInvDesafectar 'COMS', 693, 'DEMO', 'COMS.O', 'PENDIENTE', @Ok OUTPUT, @OkRef OUTPUT
SELECT @Ok, @OkRef
*/
/**************** spInvDesafectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvDesafectar') and type = 'P') drop procedure dbo.spInvDesafectar
GO             
CREATE PROCEDURE spInvDesafectar
		   @Modulo		char(5),
                   @ID        		int,
		   @Usuario   		char(10),
		   @MovTipo		char(20), 
                   @Estatus		char(15),
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @MovTipo = 'COMS.O' AND @Estatus = 'PENDIENTE'
  BEGIN    
    IF EXISTS(SELECT * FROM CompraD WHERE ID = @ID AND NULLIF(Cantidad, 0.0) IS NOT NULL AND (ISNULL(CantidadCancelada, 0) <> 0 OR ISNULL(CantidadPendiente, 0) <> ISNULL(Cantidad, 0) OR NULLIF(RTRIM(DestinoTipo), '') IS NOT NULL OR DestinoID IS NOT NULL OR NULLIF(RTRIM(Aplica), '') IS NOT NULL))
      SELECT @Ok = 60400
    ELSE BEGIN
      EXEC spMovDesafectar @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL
      BEGIN
        UPDATE Compra SET Estatus = 'DESAFECTANDO' WHERE ID = @ID
        UPDATE Compra SET Estatus = 'SINAFECTAR', Usuario = @Usuario WHERE ID = @ID
        SELECT @Ok = 80080
      END
    END
  END
  RETURN
END
GO

/************** spWMSValidaArticulo ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spWMSValidaArticulo') AND TYPE = 'P') DROP PROCEDURE dbo.spWMSValidaArticulo
GO
CREATE PROCEDURE spWMSValidaArticulo
                 @ID            int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo             varchar(20),
	@CantidadCamaTarima   float,
	@CamasTarima          float

  DECLARE @TablaArt TABLE (
							Articulo             varchar(20)
                          )

DECLARE crArticuloVal CURSOR FOR
	SELECT Articulo 
	  FROM INVD 
	 WHERE ID = @ID

	OPEN crArticuloVal
	FETCH NEXT FROM crArticuloVal INTO @Articulo 
	WHILE @@FETCH_STATUS = 0 
	BEGIN

		SELECT @CantidadCamaTarima = CantidadCamaTarima,
		       @CamasTarima        = CamasTarima
		  FROM Art 
		 WHERE Articulo = @Articulo

		 IF @CantidadCamaTarima IS NULL AND @CamasTarima IS NULL
			INSERT @TablaArt SELECT @Articulo
	
		FETCH NEXT FROM crArticuloVal INTO @Articulo
	END
	CLOSE crArticuloVal
	DEALLOCATE crArticuloVal	

	IF EXISTS (SELECT * FROM @TablaArt)
	BEGIN
		SELECT TOP 1 Articulo FROM @TablaArt
	END
	ELSE
	BEGIN
		SELECT '0'
	END	
END
GO
-- select * from compra
GO
PRINT "******************* SP INVENTARIOS ******************"
go

--spAfectar 'INV', 133, 'AFECTAR', 'Todo', NULL, 'DEMO', @Estacion=11

