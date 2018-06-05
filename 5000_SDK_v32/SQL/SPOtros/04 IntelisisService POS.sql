 SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO
 

/**************** spIntelisisServiceProcesarPOS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesarPOS') and type = 'P') drop procedure dbo.spIntelisisServiceProcesarPOS
GO
CREATE PROCEDURE spIntelisisServiceProcesarPOS
					@Sistema       varchar(100),
					@ID				int,
					@iSolicitud		int,
					@Solicitud		varchar(max),
					@Version		float,
					@Referencia		varchar(100),
					@SubReferencia	varchar(100),
					@Resultado		varchar(max)    OUTPUT,
					@Ok				int				OUTPUT,
					@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN

     IF @Referencia = 'Intelisis.POS.AnticiposFactCte'			EXEC spPOSISAnticiposFacturados			@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	ELSE
     IF @Referencia = 'Intelisis.POS.CxcPendienteCte'			EXEC spPOSISCxcPendienteCliente			@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	ELSE
     IF @Referencia = 'Intelisis.POS.PedidosCte'				EXEC spPOSISPedidosCliente				@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	ELSE
     IF @Referencia = 'Intelisis.POS.ImportarVenta'				EXEC spPOSISImportarVenta				@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	ELSE
     IF @Referencia = 'Intelisis.POS.CteInfo'					EXEC spPOSISClienteInfo					@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	ELSE
     IF @Referencia = 'Intelisis.POS.ArtInfo'					EXEC spPOSISArtInfo						@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	ELSE
     IF @Referencia = 'Intelisis.POS.AfectarVenta'				EXEC spPOSISAfectarVenta				@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	ELSE
     IF @Referencia = 'Intelisis.POS.MonederoInfo'				EXEC spPOSISMonederoInfo				@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	ELSE
	 IF @Referencia = 'Intelisis.POS.AuxiliarPMon'				EXEC spPOSISAuxiliarPMon				@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	ELSE
	 IF @Referencia = 'Intelisis.POS.TarjetaMonedero'			EXEC spPOSISTarjetaMonedero				@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	ELSE
	 IF @Referencia = 'Intelisis.POS.TarjetaMonederoActivar'	EXEC spPOSISTarjetaMonederoActivar		@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	ELSE
	 IF @Referencia = 'Intelisis.POS.MonederoRedimir'			EXEC spPOSISMonederoRedimir				@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	

  RETURN
END
GO

/**************** spPOSISAnticiposFacturados ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISAnticiposFacturados')           AND type = 'P') drop procedure dbo.spPOSISAnticiposFacturados
GO             
CREATE PROCEDURE spPOSISAnticiposFacturados
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Cliente     	        varchar(10),
	@Datos		        varchar(max),
        @Empresa                varchar(5),
        @ReferenciaIS           varchar(50),
        @SubReferenciaIS        varchar(50),
        @LenDatos               int
 
  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia
    FROM IntelisisService
   WHERE ID = @ID

  SELECT @Cliente = Cliente, @Empresa = Empresa  
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Anticipo')
    WITH (Cliente varchar(255), Empresa varchar(5))



  SELECT @Datos =(SELECT ID, Mov, MovID, Cliente, FechaEmision, Referencia, Concepto, AnticipoSaldo, Moneda, TipoCambio, Importe, Impuestos, Retencion, AnticipoAplicar, PedidoReferencia, PedidoReferenciaID--, Retencion2
    FROM Cxc
   WHERE Empresa = @Empresa 
     AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND AnticipoSaldo>0
     AND Cliente = @Cliente
   FOR XML AUTO)  
     
  SELECT @LenDatos = LEN(ISNULL(@Datos,''))
  
  IF @LenDatos BETWEEN 0 AND 3999
    SELECT @Datos = ISNULL(@Datos,'')+ '<Relleno '+  +'A="'+REPLICATE('X',4000-@LenDatos)+'" />'
  
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+' >' +ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
				
END
GO

/**************** spPOSISPedidosCliente ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISPedidosCliente')           AND type = 'P') drop procedure dbo.spPOSISPedidosCliente
GO             
CREATE PROCEDURE spPOSISPedidosCliente
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Cliente     	        varchar(10),
	@Datos		        varchar(max),
        @Empresa                varchar(5),
        @ReferenciaIS           varchar(50),
        @SubReferenciaIS        varchar(50),
        @LenDatos               int
 
  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia
    FROM IntelisisService
   WHERE ID = @ID

  SELECT @Cliente = Cliente, @Empresa = Empresa  
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Pedido')
    WITH (Cliente varchar(255), Empresa varchar(5))


  SELECT @Datos =(SELECT  Venta.ID,Venta.Empresa,Venta.Mov,Venta.MovID,Venta.FechaEmision ,Venta.Concepto,Venta.Proyecto,Venta.UEN,Venta.Moneda,CONVERT(varchar,Venta.TipoCambio) TipoCambio,Venta.Usuario,Venta.Referencia,Venta.Observaciones,Venta.Estatus,Venta.Cliente,Venta.EnviarA,Venta.Almacen,Venta.Agente,Venta.AgenteServicio,CONVERT(varchar,Venta.AgenteComision) AgenteComision,Venta.FormaEnvio,Venta.Condicion,Venta.Vencimiento ,Venta.CtaDinero,Venta.Descuento,CONVERT(varchar,Venta.DescuentoGlobal) DescuentoGlobal,CONVERT(varchar,Venta.Importe) Importe,CONVERT(varchar,Venta.Impuestos) Impuestos,CONVERT(varchar,Venta.Saldo) Saldo,CONVERT(varchar,Venta.DescuentoLineal) DescuentoLineal,Venta.OrigenTipo,Venta.Origen,Venta.OrigenID,Venta.FechaRegistro FechaRegistro,Venta.Causa,Venta.Atencion,Venta.AtencionTelefono,Venta.ListaPreciosEsp,Venta.ZonaImpuesto,Venta.Sucursal,Venta.SucursalOrigen,(SELECT ISNULL(SUM(AnticipoSaldo*TipoCambio),0.0) FROM Cxc WHERE Empresa =Venta.Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND AnticipoSaldo>0 AND Cliente = Venta.Cliente AND PedidoReferenciaID = Venta.ID )Anticipos,
                          VentaD.ID,CONVERT(varchar,VentaD.Renglon) Renglon,VentaD.RenglonSub,VentaD.RenglonID,VentaD.RenglonTipo,ISNULL(VentaD.CantidadPendiente,ISNULL(VentaD.CantidadReservada,0.0)) Cantidad,VentaD.Almacen,VentaD.EnviarA,VentaD.Articulo,VentaD.SubCuenta,CONVERT(varchar,VentaD.Precio) Precio,CONVERT(varchar,VentaD.DescuentoLinea) DescuentoLinea,CONVERT(varchar,VentaD.Impuesto1) Impuesto1,CONVERT(varchar,VentaD.Impuesto2) Impuesto2,CONVERT(varchar,VentaD.Impuesto3) Impuesto3,VentaD.Aplica,VentaD.AplicaID,CONVERT(varchar,VentaD.CantidadPendiente) CantidadPendiente,CONVERT(varchar,VentaD.CantidadReservada) CantidadReservada,CONVERT(varchar,VentaD.CantidadCancelada) CantidadCancelada,CONVERT(varchar,VentaD.CantidadOrdenada) CantidadOrdenada,CONVERT(varchar,VentaD.CantidadA) CantidadA,VentaD.Unidad,CONVERT(varchar,VentaD.Factor) Factor,CONVERT(varchar,VentaD.Puntos) Puntos,CONVERT(varchar,VentaD.CantidadObsequio) CantidadObsequio,VentaD.OfertaID,VentaD.Sucursal, VentaD.Codigo
     FROM Venta Venta JOIN VentaD VentaD ON Venta.ID = VentaD.ID
    JOIN MovTipo mt ON Venta.Mov = mt.Mov AND mt.Modulo = 'VTAS'
   WHERE Venta.Estatus IN ('PENDIENTE')
     AND mt.Clave = 'VTAS.P'
     AND ISNULL(Venta.Condicion,'') NOT IN (SELECT Condicion FROM Condicion WHERE ControlAnticipos = 'Cobrar Pedido')
     AND Venta.Empresa = @Empresa
     AND Venta.Cliente = @Cliente
     AND ISNULL(VentaD.CantidadPendiente,ISNULL(VentaD.CantidadReservada,0.0)) >0.0
     
   FOR XML AUTO)  



  IF NULLIF(@Datos    ,'') IS NULL
    SELECT @OK = 1 ,@OkRef= 'El Cliente No Tiene Pedidos,  '+@Cliente
    
    SELECT @Datos = ISNULL(@Datos,'')
    
  SELECT @LenDatos = LEN(@Datos)
  
  IF @LenDatos BETWEEN 0 AND 3999
    SELECT @Datos = @Datos+ '<Relleno '+  +'A="'+REPLICATE('X',4000-@LenDatos)+'" />'

  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+' >' +ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
					
END
GO


/**************** spPOSISAfectarVenta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISAfectarVenta')           AND type = 'P') drop procedure dbo.spPOSISAfectarVenta
GO             
CREATE PROCEDURE spPOSISAfectarVenta
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Cliente     	        varchar(10),
	@Datos		        varchar(max),
        @Empresa                varchar(5),
        @ReferenciaIS           varchar(50),
        @SubReferenciaIS        varchar(50),
        @Solicitud              varchar(max),
        @IDVenta                int,
   	@CodigoRedondeo	        varchar(50),
   	@IDPOS                  varchar(50),
	@ArticuloRedondeo	varchar(20),
	@Usuario                varchar(10),
	@Monedero               varchar(10),
	@Sucursal               int,
	@Estatus                varchar(15),
	@Mov                    varchar(20),
	@MovClave               varchar(20),
	@Articulo               varchar(20), 
	@SubCuenta              varchar(50), 
	@Unidad                 varchar(50),
	@Moneda                 varchar(10), 
	@TipoCambio             float, 
	@Renglon                float,
	@Costo                  float,
	@SugerirCostoDev        varchar(20),
	@ContMoneda             varchar(10),
	@ContMonedaTC           float,
	@VentaPreciosImpuestoIncluido		bit

        
  DECLARE @Venta table(
  ID                    varchar(50),
  Empresa               varchar(5) , 
  Mov                   varchar(20), 
  MovID                 varchar(20), 
  FechaEmision          datetime, 
  Concepto              varchar(50), 
  Proyecto              varchar(50), 
  UEN                   int, 
  Moneda                varchar(10), 
  TipoCambio            float, 
  Usuario               varchar(10), 
  Referencia            varchar(50), 
  Observaciones         varchar(100), 
  Estatus               varchar(15), 
  Cliente               varchar(10), 
  EnviarA               int, 
  Almacen               varchar(10), 
  Agente                varchar(10), 
  AgenteServicio        varchar(10), 
  AgenteComision        float, 
  FormaEnvio            varchar(50), 
  Condicion             varchar(50), 
  Vencimiento           datetime   , 
  CtaDinero             varchar(10), 
  Descuento             varchar(30), 
  DescuentoGlobal       float, 
  Importe               money, 
  Impuestos             money, 
  Saldo                 money, 
  DescuentoLineal       money, 
  OrigenTipo            varchar(10), 
  Origen                varchar(20), 
  OrigenID              varchar(20),
  FechaRegistro         datetime   , 
  Causa                 varchar(50), 
  Atencion              varchar(50), 
  AtencionTelefono      varchar(50), 
  ListaPreciosEsp       varchar(20), 
  ZonaImpuesto          varchar(30), 
  Sucursal              int, 
  SucursalOrigen        int,
  POSDescuento          varchar(30), 
  ReferenciaOrdenCompra varchar(50),
  Directo               bit,
  PedidoReferencia      varchar(50), 
  PedidoReferenciaID    int
   
  )  
  
DECLARE @VentaD table(
  ID                    varchar(50),
  Renglon               float, 
  RenglonSub            int, 
  RenglonID             int, 
  RenglonTipo           char(1),
  Cantidad              float, 
  Almacen               varchar(10), 
  EnviarA               int, 
  Articulo              varchar(20), 
  SubCuenta             varchar(50), 
  Precio                float, 
  DescuentoLinea        money, 
  Impuesto1             float, 
  Impuesto2             float, 
  Impuesto3             float, 
  Aplica                varchar(20), 
  AplicaID              varchar(20), 
  CantidadPendiente     float, 
  CantidadReservada     float, 
  CantidadCancelada     float, 
  CantidadOrdenada      float, 
  CantidadA             float, 
  Unidad                varchar(50), 
  Factor                float, 
  Puntos                money, 
  CantidadObsequio      float, 
  OfertaID              int, 
  Sucursal              int,
  PrecioImpuestoInc     float,
  AnticipoRetencion     float, 
  AnticipoFacturado     bit,
  AplicaDescGlobal      bit,
  Codigo                varchar(30)  
)       

DECLARE @SerieLote table(
  	IDL			varchar(50),
	Orden			int,	
        ID			varchar(36),
        RenglonID		int,
        Articulo		varchar(20),
        SubCuenta		varchar(50),
        SerieLote		varchar(50))
        
DECLARE @VentaCobro table(
  ID                    varchar(36), 
  Importe1              money, 
  Importe2              money, 
  Importe3              money, 
  Importe4              money, 
  Importe5              money, 
  FormaCobro1           varchar(50), 
  FormaCobro2           varchar(50), 
  FormaCobro3           varchar(50), 
  FormaCobro4           varchar(50), 
  FormaCobro5           varchar(50), 
  Referencia1           varchar(50), 
  Referencia2           varchar(50), 
  Referencia3           varchar(50), 
  Referencia4           varchar(50), 
  Referencia5           varchar(50), 
  Observaciones1        varchar(100), 
  Observaciones2        varchar(100), 
  Observaciones3        varchar(100), 
  Observaciones4        varchar(100), 
  Observaciones5        varchar(100), 
  Cambio                money, 
  Redondeo              money, 
  DelEfectivo           money, 
  Sucursal              int, 
  CtaDinero             varchar(10), 
  Cajero                varchar(10), 
  Condicion             varchar(50), 
  Vencimiento           datetime, 
  Actualizado           bit, 
  TotalCobrado          money, 
  SucursalOrigen        int, 
  POSTipoCambio1        float, 
  POSTipoCambio2        float, 
  POSTipoCambio3        float, 
  POSTipoCambio4        float, 
  POSTipoCambio5        float )       
        
DECLARE @TarjetaSerieMov table(
    Empresa             varchar(5), 
    Modulo              varchar(5), 
    ID                  int, 
    Serie               varchar(20), 
    Importe             money, 
    Sucursal            int, 
    TipoCambioTarjeta   float, 
    ImporteTarjeta      float)   
      
DECLARE @Anticipos table(
   ID                   int, 
   AnticipoAplicar      float

)       

  
  BEGIN TRANSACTION 
  
  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia, @Solicitud = Solicitud
    FROM IntelisisService
   WHERE ID = @ID

  SELECT @Empresa = Empresa, @Usuario = Usuario, @Monedero = Monedero, @Sucursal = Sucursal, @IDPOS = ID, @Mov = Mov, @Moneda = Moneda, @TipoCambio = ISNULL(TipoCambio,1.0) 
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Venta')
    WITH (Empresa varchar(5), Usuario varchar(10), Monedero varchar(20), Sucursal int, ID varchar(36), Mov varchar(20), Moneda varchar(10), TipoCambio float)   
    
  SELECT  @MovClave = Clave
    FROM MovTipo WHERE Mov = @Mov AND Modulo = 'VTAS'
    
   SELECT @CodigoRedondeo = pc.RedondeoVentaCodigo
     FROM POSCfg pc
    WHERE pc.Empresa = @Empresa
   
   SELECT @VentaPreciosImpuestoIncluido = VentaPreciosImpuestoIncluido, @SugerirCostoDev = SugerirCostoDev, @ContMoneda = ContMoneda
     FROM EmpresaCfg 
    WHERE Empresa = @Empresa
   
   SELECT @ContMonedaTC = TipoCambio FROM POSLTipoCambioRef WHERE Sucursal = @Sucursal AND Moneda = @ContMoneda
   SELECT @ArticuloRedondeo = Cuenta
     FROM CB
    WHERE Codigo = @CodigoRedondeo
      AND TipoCuenta = 'Articulos'          

    EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud
    INSERT @Venta(ID, Empresa, Mov, MovID, FechaEmision, Concepto, Proyecto, UEN, Moneda, TipoCambio, Usuario, Referencia, Observaciones, Estatus,      Cliente, EnviarA, Almacen, Agente, AgenteServicio, AgenteComision, FormaEnvio, Condicion, Vencimiento, CtaDinero, Descuento, DescuentoGlobal, Importe, Impuestos, Saldo, DescuentoLineal, OrigenTipo, Origen, OrigenID, FechaRegistro, Causa, Atencion, AtencionTelefono, ListaPreciosEsp, ZonaImpuesto, Sucursal, SucursalOrigen, POSDescuento,  ReferenciaOrdenCompra,    PedidoReferencia, PedidoReferenciaID)  
    SELECT        ID, Empresa, Mov, MovID, FechaEmision, Concepto, Proyecto, UEN, Moneda, TipoCambio, Usuario, Referencia, Observaciones, 'SINAFECTAR', Cliente, EnviarA, Almacen, Agente, AgenteServicio, AgenteComision, FormaEnvio, Condicion, Vencimiento, CtaDinero, Descuento, DescuentoGlobal, Importe, Impuestos, Saldo, DescuentoLineal, OrigenTipo, Origen, OrigenID, FechaRegistro, Causa, Atencion, AtencionTelefono, ListaPreciosEsp, ZonaImpuesto, Sucursal, SucursalOrigen, Descuento,     ID,                       PedidoReferencia, PedidoReferenciaID
      FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Venta')
      WITH (ID  varchar(36), Empresa  varchar(5), Mov  varchar(20), MovID  varchar(20), FechaEmision  datetime, Concepto  varchar(50), Proyecto  varchar(50), UEN  int, Moneda  varchar(10), TipoCambio  float, Usuario  varchar(10), Referencia  varchar(50), Observaciones  varchar(100), Estatus  varchar(15), Cliente  varchar(10), EnviarA  int, Almacen  varchar(10), Agente  varchar(10), AgenteServicio  varchar(10), AgenteComision  float, FormaEnvio  varchar(50), Condicion  varchar(50), Vencimiento  datetime, CtaDinero  varchar(10), Descuento  varchar(30), DescuentoGlobal  float, Importe  money, Impuestos  money, Saldo  money, DescuentoLineal  money, OrigenTipo  varchar(10), Origen  varchar(20), OrigenID  varchar(20), FechaRegistro  datetime, Causa  varchar(50), Atencion  varchar(50), AtencionTelefono  varchar(50), ListaPreciosEsp  varchar(20), ZonaImpuesto  varchar(30), Sucursal  int, SucursalOrigen  int, AnticipoFacturadoTipoServicio bit, PedidoReferencia  varchar(50), PedidoReferenciaID   int) 
    EXEC sp_xml_removedocument @iSolicitud
    IF @@ERROR<>0 SET @Ok = 1
  
    IF @Ok IS NULL
    BEGIN
      EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
      INSERT @VentaD(ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Cantidad, Almacen, EnviarA, Articulo, SubCuenta, Precio, DescuentoLinea, Impuesto1, Impuesto2, Impuesto3, Aplica, AplicaID, CantidadPendiente, CantidadReservada, CantidadCancelada, CantidadOrdenada, CantidadA, Unidad, Factor, Puntos, CantidadObsequio, OfertaID, Sucursal, PrecioImpuestoInc, AnticipoRetencion, AnticipoFacturado, AplicaDescGlobal, Codigo) 
      SELECT         ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Cantidad, Almacen, EnviarA, Articulo, SubCuenta, Precio, DescuentoLinea, Impuesto1, Impuesto2, Impuesto3, Aplica, AplicaID, CantidadPendiente, CantidadReservada, CantidadCancelada, CantidadOrdenada, CantidadA, Unidad, Factor, Puntos, CantidadObsequio, OfertaID, Sucursal, PrecioImpuestoInc, AnticipoRetencion, AnticipoFacturado, AplicaDescGlobal, Codigo
        FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Venta/VentaD')
      WITH (ID varchar(36),Renglon  float, RenglonSub  int, RenglonID  int, RenglonTipo  char(1), Cantidad  float, Almacen  varchar(10), EnviarA  int, Articulo  varchar(20), SubCuenta  varchar(50), Precio  float, DescuentoLinea  float, Impuesto1  float, Impuesto2  float, Impuesto3  float, Aplica  varchar(20), AplicaID  varchar(20), CantidadPendiente  float, CantidadReservada  float, CantidadCancelada  float, CantidadOrdenada  float, CantidadA  float, Unidad  varchar(50), Factor  float, Puntos  money, CantidadObsequio  float, OfertaID  int, Sucursal  int, PrecioImpuestoInc float, AnticipoRetencion float,AnticipoFacturado bit, AplicaDescGlobal  bit, Codigo  varchar(30)) 
      EXEC sp_xml_removedocument @iSolicitud
      IF @@ERROR<>0 SET @Ok = 1
    END
    IF @Ok IS NULL
    BEGIN
      EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
      INSERT @SerieLote(IDL, Orden, ID, RenglonID, Articulo, SubCuenta, SerieLote) 
      SELECT            IDL, Orden, ID, RenglonID, Articulo, SubCuenta, SerieLote
        FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/SerieLote')
      WITH (IDL varchar(36), Orden  int, ID varchar(36), RenglonID  int,Articulo  varchar(20),SubCuenta  varchar(50),SerieLote varchar(50)) 
      EXEC sp_xml_removedocument @iSolicitud
      IF @@ERROR<>0 SET @Ok = 1
    END  
    
    IF @Ok IS NULL
    BEGIN
      EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
      INSERT @VentaCobro(ID, Importe1, Importe2, Importe3, Importe4, Importe5, FormaCobro1, FormaCobro2, FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Observaciones1, Observaciones2, Observaciones3, Observaciones4, Observaciones5, Cambio, Redondeo, DelEfectivo, Sucursal, CtaDinero, Cajero, Condicion, Vencimiento, Actualizado, TotalCobrado, SucursalOrigen, POSTipoCambio1, POSTipoCambio2, POSTipoCambio3, POSTipoCambio4, POSTipoCambio5) 
      SELECT             ID, Importe1, Importe2, Importe3, Importe4, Importe5, FormaCobro1, FormaCobro2, FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, Observaciones1, Observaciones2, Observaciones3, Observaciones4, Observaciones5, Cambio, Redondeo, DelEfectivo, Sucursal, CtaDinero, Cajero, Condicion, Vencimiento, Actualizado, TotalCobrado, SucursalOrigen, POSTipoCambio1, POSTipoCambio2, POSTipoCambio3, POSTipoCambio4, POSTipoCambio5
        FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/VentaCobro')
      WITH (ID  varchar(36), Importe1  money, Importe2  money, Importe3  money, Importe4  money, Importe5  money, FormaCobro1  varchar(50), FormaCobro2  varchar(50), FormaCobro3  varchar(50), FormaCobro4  varchar(50), FormaCobro5  varchar(50), Referencia1  varchar(50), Referencia2  varchar(50), Referencia3  varchar(50), Referencia4  varchar(50), Referencia5  varchar(50), Observaciones1  varchar(100), Observaciones2  varchar(100), Observaciones3  varchar(100), Observaciones4  varchar(100), Observaciones5  varchar(100), Cambio  money, Redondeo  money, DelEfectivo  money, Sucursal  int, CtaDinero  varchar(10), Cajero  varchar(10), Condicion  varchar(50), Vencimiento  datetime, Actualizado  bit, TotalCobrado  money, SucursalOrigen  int, POSTipoCambio1  float, POSTipoCambio2  float, POSTipoCambio3  float, POSTipoCambio4  float, POSTipoCambio5  float) 
      EXEC sp_xml_removedocument @iSolicitud
      IF @@ERROR<>0 SET @Ok = 1
    END      
    
    IF @Ok IS NULL
    BEGIN
      EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
      INSERT @TarjetaSerieMov(Empresa,Modulo,ID,Serie,Importe,Sucursal,TipoCambioTarjeta,ImporteTarjeta) 
      SELECT            Empresa,Modulo,ID,Serie,Importe,Sucursal,TipoCambioTarjeta,ImporteTarjeta
        FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/TarjetaSerieMov')
      WITH (Empresa varchar(5), Modulo varchar(5), ID int, Serie varchar(20),Importe money, Sucursal int, TipoCambioTarjeta   float, ImporteTarjeta      float) 
      EXEC sp_xml_removedocument @iSolicitud
      IF @@ERROR<>0 SET @Ok = 1
    END     
    
    IF @Ok IS NULL
    BEGIN
      EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
      INSERT @Anticipos(ID,AnticipoAplicar) 
      SELECT            ID,AnticipoAplicar
        FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/POSCxcAnticipoTemp')
      WITH ( ID int, AnticipoAplicar float) 
      EXEC sp_xml_removedocument @iSolicitud
      IF @@ERROR<>0 SET @Ok = 1
    END        
    
   IF NOT EXISTS(SELECT * FROM Venta WHERE ReferenciaOrdenCompra = @IDPOS AND Estatus = 'CONCLUIDO')
   BEGIN
     IF @Ok IS NULL
     BEGIN
       INSERT Venta (Empresa,  Mov,  MovID, FechaEmision, FechaRegistro, Concepto, Proyecto, UEN, Moneda, TipoCambio,                                                                           Usuario, Referencia, Estatus,      Observaciones, Cliente, EnviarA,    Almacen,  Agente,  FormaEnvio,  Condicion,  Vencimiento,  CtaDinero,    DescuentoGlobal, Causa,  Atencion,  AtencionTelefono,  ListaPreciosEsp,  ZonaImpuesto,  Sucursal,  OrigenTipo,  Origen,  OrigenID, ReferenciaOrdenCompra,GenerarDinero,SucursalOrigen, AnticipoFacturadoTipoServicio, POSDescuento,  Directo,                                                                                          PedidoReferencia, PedidoReferenciaID )
       SELECT        Empresa,  Mov,  MovID, FechaEmision, FechaRegistro, Concepto, Proyecto, UEN, Moneda, CASE WHEN Moneda <> @ContMoneda THEN  (TipoCambio/@ContMonedaTC) ELSE TipoCambio END, Usuario, Referencia, 'SINAFECTAR', Observaciones, Cliente, EnviarA,    Almacen,  Agente,  FormaEnvio,  Condicion,  Vencimiento,  CtaDinero,    0.0            , Causa,  Atencion,  AtencionTelefono,  ListaPreciosEsp,  ZonaImpuesto,  Sucursal,  'POS',       Origen,  OrigenID, ID,                   1            ,Sucursal,       1,                             Descuento,  CASE WHEN (NULLIF(Origen,'') IS NOT NULL AND NULLIF(OrigenID,'') IS NOT NULL)  THEN 0 ELSE 1 END, PedidoReferencia, PedidoReferenciaID
         FROM @Venta       
       SELECT @IDVenta = SCOPE_IDENTITY()       
             
     END

     IF @Ok IS NULL AND @IDVenta IS NOT NULL
     BEGIN
       INSERT VentaD (ID,        Renglon,     RenglonID,     Aplica,       AplicaID,       RenglonTipo,     Cantidad,     CantidadObsequio,     Almacen,                                   EnviarA,     Articulo,     SubCuenta,      Precio,                                                                                                                                                                                                 Impuesto1,     Impuesto2,     Impuesto3,     Unidad,     Factor,     Sucursal,   Puntos,     AnticipoFacturado,     AnticipoRetencion,     AnticipoMoneda, AnticipoTipoCambio, DescuentoLinea,                                                                                                                              DescuentoImporte,                                                                                                                                                               POSDesGlobal,                                                                                POSDesLinea,                    Codigo )
       SELECT        @IDVenta,   pmv.Renglon, pmv.RenglonID, pmv.Aplica,   pmv.AplicaID  , pmv.RenglonTipo, pmv.Cantidad, pmv.CantidadObsequio, ISNULL(NULLIF(pmv.Almacen,''),v.Almacen) , pmv.EnviarA, pmv.Articulo, pmv.SubCuenta,  CASE WHEN pmv.Articulo = @ArticuloRedondeo THEN pmv.Precio / (1-(ISNULL(v.DescuentoGlobal,0)/100)) ELSE CASE WHEN @VentaPreciosImpuestoIncluido = 1 THEN pmv.PrecioImpuestoInc ELSE pmv.Precio END END, pmv.Impuesto1, pmv.Impuesto2, pmv.Impuesto3, pmv.Unidad, 1,         v.Sucursal, pmv.Puntos, pmv.AnticipoFacturado, pmv.AnticipoRetencion, v.Moneda,       v.TipoCambio,        dbo.fnPOSCalcDescuentosVenta(CASE WHEN ISNULL(pmv.AplicaDescGlobal, 1) = 1 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END,pmv.DescuentoLinea), (pmv.Cantidad*pmv.Precio)*(dbo.fnPOSCalcDescuentosVenta(CASE WHEN ISNULL(pmv.AplicaDescGlobal, 1) = 1 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END,pmv.DescuentoLinea)/100.0), CASE WHEN ISNULL(pmv.AplicaDescGlobal, 1) = 1 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END, ISNULL(pmv.DescuentoLinea,0.0), pmv.Codigo

         FROM @VentaD   pmv
         JOIN @Venta v ON v.ID = pmv.ID
     
     END
     IF EXISTS(SELECT * FROM POSValeSerie WHERE Serie = @Monedero)AND @IDVenta IS NOT NULL
       INSERT TarjetaSerieMov(Empresa,  ID,       Modulo, Serie,     Sucursal)
       SELECT                 @Empresa, @IDVenta, 'VTAS', @Monedero, @Sucursal    
       
     IF EXISTS(SELECT * FROM @SerieLote pls )AND @IDVenta IS NOT NULL
       INSERT SerieLoteMov (Empresa,  Modulo, ID,       RenglonID,     Articulo,     SubCuenta,                 SerieLote,     Cantidad, Sucursal)
       SELECT               @Empresa, 'VTAS', @IDVenta, pls.RenglonID, pls.Articulo, ISNULL(pls.SubCuenta, ''), pls.SerieLote, COUNT(*), @Sucursal  
         FROM @SerieLote pls
        GROUP BY Articulo, ISNULL(SubCuenta,''), SerieLote, RenglonID 
        
    IF EXISTS(SELECT * FROM @VentaCobro)AND @IDVenta IS NOT NULL
      INSERT VentaCobro(ID,       Importe1,  Importe2,  Importe3,  Importe4,  Importe5, FormaCobro1, FormaCobro2, FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, CtaDinero, Cajero,POSTipoCambio1, POSTipoCambio2, POSTipoCambio3, POSTipoCambio4, POSTipoCambio5 )            
      SELECT            @IDVenta, Importe1,  Importe2,  Importe3,  Importe4,  Importe5, FormaCobro1, FormaCobro2, FormaCobro3, FormaCobro4, FormaCobro5, Referencia1, Referencia2, Referencia3, Referencia4, Referencia5, CtaDinero, Cajero,POSTipoCambio1, POSTipoCambio2, POSTipoCambio3, POSTipoCambio4, POSTipoCambio5
        FROM @VentaCobro
      
    IF EXISTS (SELECT * FROM @TarjetaSerieMov)AND @IDVenta IS NOT NULL
      INSERT TarjetaSerieMov( Empresa, ID,       Importe, ImporteTarjeta, Modulo, Serie, Sucursal, TipoCambioTarjeta)
      SELECT                  Empresa, @IDVenta, Importe, ImporteTarjeta, 'VTAS', Serie, Sucursal, TipoCambioTarjeta
        FROM @TarjetaSerieMov
        
  
    IF EXISTS(SELECT * FROM @Anticipos)AND @IDVenta IS NOT NULL
    BEGIN
      UPDATE Cxc SET AnticipoAplicaID = @IDVenta ,AnticipoAplicaModulo = 'VTAS',AnticipoAplicar =a.AnticipoAplicar
        FROM @Anticipos a JOIN Cxc c ON a.ID = c.ID  
    END

  IF @MovClave IN ('VTAS.D') AND @Ok IS NULL
  BEGIN
    DECLARE crDetalle CURSOR LOCAL FOR
      SELECT Renglon, Articulo, SubCuenta, Unidad
        FROM VentaD
       WHERE ID = @IDVenta

      
    OPEN crDetalle
    FETCH NEXT FROM crDetalle INTO  @Renglon, @Articulo, @SubCuenta, @Unidad
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      SET @Costo = NULL
      EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, @SubCuenta, @Unidad, @SugerirCostoDev , @Moneda, @TipoCambio, @Costo OUTPUT, 0
      UPDATE VentaD SET Costo = @Costo  WHERE ID = @IDVenta AND Renglon = @Renglon AND Articulo = @Articulo
      FETCH NEXT FROM crDetalle INTO @Renglon, @Articulo, @SubCuenta, @Unidad
    END
    CLOSE crDetalle
    DEALLOCATE crDetalle      
  END

   
     
    IF @Ok IS NULL AND @IDVenta IS NOT NULL AND @Usuario IS NOT NULL
      EXEC spAfectar 'VTAS', @IDVenta, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END
  ELSE
    SELECT @IDVenta = ID FROM Venta WHERE ReferenciaOrdenCompra = @IDPOS     
    
  SELECT @OkRef = REPLACE(ISNULL(@OkRef,''),'<BR>','@##@')    

  IF @Ok IS NULL 
  BEGIN
    SELECT @Estatus = Estatus FROM Venta WHERE ID = @IDVenta
    COMMIT TRANSACTION
  END  
  ELSE
  BEGIN
   ROLLBACK TRANSACTION   
   SELECT @IDVenta = NULL 
  END   
 
  SELECT @Datos = '<Relleno '+'A="'+REPLICATE('X',4000)+'" />'
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + (ISNULL(@OkRef,'')) + CHAR(34)+' IDModulo=' + CHAR(34) + ISNULL(CONVERT(varchar,@IDVenta),'') + CHAR(34) + ' EstatusModulo=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) + ' >'+ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
  
				
END
GO

/**************** spPOSISCxcPendienteCliente ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISCxcPendienteCliente')           AND type = 'P') drop procedure dbo.spPOSISCxcPendienteCliente
GO             
CREATE PROCEDURE spPOSISCxcPendienteCliente
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Cliente     	        varchar(10),
	@Datos		        varchar(max),
        @Empresa                varchar(5),
        @ReferenciaIS           varchar(50),
        @SubReferenciaIS        varchar(50),
        @LenDatos               int
        
  DECLARE @Tabla table(
          ID            int,
          Empresa       varchar(5), 
          Mov           varchar(20), 
          MovID         varchar(20), 
          Cliente       varchar(10), 
          FechaEmision  datetime, 
          Vencimiento   datetime, 
          DiasCredito   int,
          DiasMoratorios int, 
          Referencia    varchar(50), 
          Concepto      varchar(50), 
          Moneda        varchar(10), 
          TipoCambio    float, 
          Importe       float, 
          Impuestos     float, 
          ImporteTotal  float,  
          Saldo         float, 
          SaldoTotal    float)
  

 
  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia
    FROM IntelisisService
   WHERE ID = @ID

  SELECT @Cliente = Cliente, @Empresa = Empresa  
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/CxcPendiente')
    WITH (Cliente varchar(255), Empresa varchar(5))

  INSERT @Tabla(ID,   Empresa ,  Mov,   MovID ,  Cliente,   FechaEmision,   Vencimiento,   DiasCredito,   DiasMoratorios,    Referencia,   Concepto,   Moneda,   TipoCambio,   Importe,   Impuestos,   ImporteTotal,    Saldo,   SaldoTotal)
  SELECT        c.ID, c.Empresa, c.Mov, c.MovID, c.Cliente, c.FechaEmision, c.Vencimiento, c.DiasCredito, c.DiasMoratorios,  c.Referencia, c.Concepto, c.Moneda, c.TipoCambio, c.Importe, c.Impuestos, c.ImporteTotal,  c.Saldo, c.SaldoTotal
    FROM CxcPendiente c JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'CXC'
   WHERE  c.Estatus IN ('PENDIENTE')
     AND c.Cliente = @Cliente  
     AND c.Empresa = @Empresa    
     AND mt.Clave IN('CXC.D', 'CXC.F', 'CXC.NC')

  SELECT @Datos =(SELECT * FROM @Tabla CxcPendiente FOR XML AUTO)  
     
  SELECT @LenDatos = LEN(ISNULL(@Datos,''))
  
  IF @LenDatos BETWEEN 0 AND 3999
    SELECT @Datos = ISNULL(@Datos,'')+ '<Relleno '+  +'A="'+REPLICATE('X',4000-@LenDatos)+'" />'
  
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+' >' +ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
				
END
GO

 /**************** spPOSISClienteInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISClienteInfo')           AND type = 'P') drop procedure dbo.spPOSISClienteInfo
GO             
CREATE PROCEDURE spPOSISClienteInfo
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Cliente     	        varchar(10),
	@Datos		        varchar(max),
	@Datos2		        varchar(max),
	@Datos3		        varchar(max),
	@Datos4  	        varchar(max),
        @Empresa                varchar(5),
        @ReferenciaIS           varchar(50),
        @SubReferenciaIS        varchar(50),
        @LenDatos               int,
        @SaldoMN                float,
        @LimiteCredito          float


 
  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia
    FROM IntelisisService
   WHERE ID = @ID

  SELECT @Cliente = RTRIM(LTRIM(Cliente)), @Empresa = Empresa  
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/CteInfo')
    WITH (Cliente varchar(10), Empresa varchar(5))

  SET ANSI_WARNINGS OFF
  
  SELECT @SaldoMN = SUM(s.Saldo*m.TipoCambio) FROM CxcSaldo s, Mon m WHERE s.Moneda = m.Moneda AND Empresa=@Empresa AND Cliente=@Cliente
  EXEC spPOSVerLimiteCreditoMN @Cliente, @Empresa, @LimiteCredito OUTPUT
  
  SELECT @Datos4 = '<Saldo SaldoMN=' + CHAR(34) + ISNULL(CONVERT(varchar ,ISNULL(@SaldoMN,0.0)),'') + CHAR(34) + '  LimiteCreditoMN=' + CHAR(34) + ISNULL(CONVERT(varchar ,ISNULL(@LimiteCredito,0.0)),'') + CHAR(34) + '/>'
  SELECT @Datos3 =(SELECT CteCredito.* FROM Cte  c LEFT OUTER JOIN CteCredito ON @empresa=CteCredito.Empresa AND c.Credito=CteCredito.Credito  WHERE c.Cliente = @Cliente FOR XML AUTO)  
  SELECT @Datos2 =(SELECT * FROM dbo.fnCxcInfo(@Empresa, @Cliente, @Cliente)fnCxcInfo FOR XML AUTO)
  SELECT @Datos =(SELECT * FROM Venta WHERE Cliente = @Cliente AND Estatus IN('PENDIENTE','PROCESAR','CONFIRMAR', 'VIGENTE') FOR XML AUTO)
  SELECT @Datos =   ISNULL(@Datos2,'')+  ISNULL(@Datos3,'')+ISNULL(@Datos,'')+ISNULL(@Datos4,'')
  SELECT @LenDatos = LEN(ISNULL(@Datos,''))
  
  --IF @LenDatos BETWEEN 0 AND 3999
    SELECT @Datos = ISNULL(@Datos,'')+ '<Relleno '+  +'A="'+REPLICATE('X',8000-@LenDatos)+'" />'
  
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+' >' +ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
				
END
GO

 /**************** spPOSISArtInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISArtInfo')           AND type = 'P') drop procedure dbo.spPOSISArtInfo
GO             
CREATE PROCEDURE spPOSISArtInfo
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Articulo     	        varchar(20),
	@Datos		        varchar(max),
	@Datos2		        varchar(max),
	@Datos3		        varchar(max),
	@Datos4  	        varchar(max),
        @Empresa                varchar(5),
        @ReferenciaIS           varchar(50),
        @SubReferenciaIS        varchar(50),
        @LenDatos               int,
        @SaldoMN                float,
        @LimiteCredito          float
        
  DECLARE @Disponible  table(Empresa  varchar(5), Articulo  varchar(20), Almacen   varchar(10), Disponible   float, Grupo  varchar(50), Tipo varchar(15))
  DECLARE @Reservado   table(Empresa  varchar(5), Articulo  varchar(20), Almacen   varchar(10), Reservado    float, Grupo  varchar(50), Tipo varchar(15))


 
  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia
    FROM IntelisisService
   WHERE ID = @ID

  SELECT @Articulo = RTRIM(LTRIM(Articulo)), @Empresa = Empresa  
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/ArtInfo')
    WITH (Articulo varchar(20), Empresa varchar(5))
    

  INSERT @Disponible(Empresa, Articulo, Almacen, Disponible,   Grupo,      Tipo)
  SELECT  a.Empresa, a.Articulo,   a.Almacen,   a.Disponible,  Alm.Grupo,   Alm.Tipo
    FROM ArtDisponible a JOIN Alm alm ON a.Almacen=Alm.Almacen
   WHERE a.Articulo = @Articulo 

  INSERT @Reservado(Empresa, Articulo, Almacen, Reservado,   Grupo,      Tipo)
  SELECT a.Empresa,   a.Articulo,  a.Almacen,   a.Reservado, Alm.Grupo,  Alm.Tipo
    FROM ArtReservado a  LEFT OUTER JOIN Alm Alm ON a.Almacen=Alm.Almacen
   WHERE a.Articulo = @Articulo  

  SELECT @Datos =(SELECT * FROM @Disponible Disponible FOR XML AUTO)
  SELECT @Datos2 =(SELECT * FROM @Reservado Reservado FOR XML AUTO)
 

  SELECT @Datos = ISNULL(@Datos,'')+ISNULL(@Datos2,'')
  SELECT @LenDatos = LEN(ISNULL(@Datos,''))
  SELECT @Datos = ISNULL(@Datos,'')+ '<Relleno '+  +'A="'+REPLICATE('X',8000-@LenDatos)+'" />'
  
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+' >' 
  +ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
				
END
GO   

/**************** spPOSISImportarVenta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISImportarVenta')           AND type = 'P') drop procedure dbo.spPOSISImportarVenta
GO             
CREATE PROCEDURE spPOSISImportarVenta
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Cliente     	        varchar(10),
	@Datos		        varchar(max),
        @Empresa                varchar(5),
        @ReferenciaIS           varchar(50),
        @SubReferenciaIS        varchar(50),
        @LenDatos               int,
        @ReferenciaOrigen       varchar(50),
        @IDPOS                  varchar(50)
 
  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia
    FROM IntelisisService
   WHERE ID = @ID
   
 SELECT @IDPOS = NULL  

  SELECT @ReferenciaOrigen = ReferenciaOrigen, @Empresa = Empresa
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Venta')
    WITH (ReferenciaOrigen varchar(50), Empresa varchar(5))
    
  IF EXISTS(SELECT * FROM Venta pl INNER JOIN MovTipo mt ON pl.Mov = mt.Mov AND mt.Modulo = 'VTAS' AND mt.Clave IN ('VTAS.F', 'VTAS.N','VTA.FM') WHERE LTRIM(RTRIM(pl.Mov)) + ' ' + LTRIM(RTRIM(pl.MovId)) = @ReferenciaOrigen AND pl.Importe >= 0)
    SELECT @IDPOS = ReferenciaOrdenCompra FROM Venta pl INNER JOIN MovTipo mt ON pl.Mov = mt.Mov AND mt.Modulo = 'VTAS' AND mt.Clave IN ('VTAS.F', 'VTAS.N','VTA.FM') WHERE LTRIM(RTRIM(pl.Mov)) + ' ' + LTRIM(RTRIM(pl.MovId)) = @ReferenciaOrigen AND pl.Importe >= 0


  IF EXISTS(SELECT * FROM POSLCB cb JOIN POSL pl ON cb.ID = pl.ID WHERE cb.IDCB = @ReferenciaOrigen AND pl.Importe >= 0) AND @IDPOS IS NULL
    SELECT @IDPOS = cb.ID FROM  POSLCB cb JOIN POSL pl ON cb.ID = pl.ID WHERE cb.IDCB = @ReferenciaOrigen AND pl.Importe >= 0    
      
  --IF EXISTS(SELECT * FROM POSL WHERE ID = @ReferenciaOrigen AND Importe >= 0)AND @IDPOS IS NULL
  --  SELECT @IDPOS = @ReferenciaOrigen
    


  IF @IDPOS IS NOT NULL
  SELECT @Datos =(SELECT  Venta.*,VentaD.*,ISNULL(Oferta.Forma,'')Forma,ISNULL(OfertaTipo.AceptaDevolucion,1) AceptaDevolucion ,SerieLoteMov.*
     FROM Venta Venta JOIN VentaD VentaD ON Venta.ID = VentaD.ID
    JOIN MovTipo mt ON Venta.Mov = mt.Mov AND mt.Modulo = 'VTAS'
    LEFT JOIN SerieLoteMov SerieLoteMov ON SerieLoteMov.ID = Venta.ID AND SerieLoteMov.Empresa = Venta.Empresa AND SerieLoteMov.Modulo = 'VTAS' AND  ISNULL(SerieLoteMov.SubCuenta, '') = ISNULL(VentaD.Subcuenta, '') AND SerieLoteMov.Articulo = VentaD.Articulo
    LEFT JOIN Oferta Oferta ON VentaD.OfertaID = Oferta.ID
    LEFT JOIN OfertaTipo OfertaTipo ON OfertaTipo.Tipo = Oferta.Tipo
   WHERE Venta.Estatus IN ('PENDIENTE','CONCLUIDO','PROCESAR')
     AND mt.Clave IN( 'VTAS.N','VTAS.F','VTAS.FM')
     AND Venta.Empresa = @Empresa
     AND Venta.ReferenciaOrdenCompra = @IDPOS
   FOR XML AUTO)  
  
  IF NULLIF(@Datos,'') IS NULL
    SELECT @OK = 20915 ,@OkRef= 'No Hay Concidencias Con la Referencia ('+@ReferenciaOrigen+')'
    
    SELECT @Datos = ISNULL(@Datos,'')
    
    SELECT @LenDatos = LEN(@Datos)
  
  --IF @LenDatos BETWEEN 0 AND 3999
    SELECT @Datos = @Datos+ '<Relleno '+  +'A="'+REPLICATE('X',8000-@LenDatos)+'" />'

  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+' >' +ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
					
END
GO

/**************** spPOSISMonederoInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISMonederoInfo')           AND type = 'P') drop procedure dbo.spPOSISMonederoInfo
GO             
CREATE PROCEDURE spPOSISMonederoInfo
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Cuenta				varchar(20),
	@Datos				varchar(max),
	@Datos2				varchar(max),
	@Datos3				varchar(max),
	@Datos4				varchar(max),
	@Empresa			varchar(5),
	@ReferenciaIS		varchar(50),
	@SubReferenciaIS	varchar(50),
	@LenDatos			int,
	@SaldoMN			float,
	@LimiteCredito		float


  DECLARE @SaldoPMon table (Empresa varchar(5), Moneda varchar(5), Grupo varchar(10), Cuenta varchar(20), SubCuenta varchar(50), Saldo float) 

  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia
    FROM IntelisisService
   WHERE ID = @ID

  SELECT @Cuenta = RTRIM(LTRIM(Cuenta)), @Empresa = Empresa  
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/MonederoInfo')
    WITH (Cuenta varchar(20), Empresa varchar(5))
    

  INSERT @SaldoPMon (Empresa, Moneda, Grupo, Cuenta,   SubCuenta,      Saldo)
  SELECT			 Empresa, Moneda, Grupo, Cuenta,   SubCuenta,      Saldo
    FROM SaldoPMon
   WHERE Empresa = @Empresa
     AND Cuenta = @Cuenta



  SELECT @Datos =(SELECT * FROM @SaldoPMon SaldoPMon FOR XML AUTO)

  SELECT @Datos = ISNULL(@Datos,'')
  SELECT @LenDatos = LEN(ISNULL(@Datos,''))
  SELECT @Datos = ISNULL(@Datos,'')+ '<Relleno '+  +'A="'+REPLICATE('X',8000-@LenDatos)+'" />'
  
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+' >' 
  +ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
				
END
GO 


 /**************** spPOSISAuxiliarPMon ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISAuxiliarPMon')           AND type = 'P') drop procedure dbo.spPOSISAuxiliarPMon
GO             
CREATE PROCEDURE spPOSISAuxiliarPMon
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Cuenta				varchar(20),
	@Datos				varchar(max),
	@Datos2				varchar(max),
	@Datos3				varchar(max),
	@Datos4				varchar(max),
	@Empresa			varchar(5),
	@ReferenciaIS		varchar(50),
	@SubReferenciaIS	varchar(50),
	@LenDatos			int,
	@SaldoMN			float,
	@LimiteCredito		float

  DECLARE @AuxiliarPMon table (ID int, Empresa varchar( 5), Rama varchar( 5), Mov varchar(20), MovID varchar(20), Modulo varchar(5), ModuloID int, Moneda varchar(10), TipoCambio float, Grupo varchar(10), Cuenta varchar(20), SubCuenta varchar(50), Ejercicio int, Periodo int, Fecha datetime, Cargo money, Abono money, Aplica varchar(20), AplicaID varchar(20), Acumulado bit, Conciliado bit, EsCancelacion bit, FechaConciliacion datetime, Sucursal int, Renglon float, RenglonSub int ) 

  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia
    FROM IntelisisService
   WHERE ID = @ID

  SELECT @Cuenta = RTRIM(LTRIM(Cuenta)), @Empresa = Empresa  
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/AuxiliarPMon')
    WITH (Cuenta varchar(20), Empresa varchar(5))
    

  INSERT @AuxiliarPMon (ID, Empresa, Rama, Mov, MovID, Modulo, ModuloID, Moneda, TipoCambio, Grupo, Cuenta, SubCuenta, Ejercicio, Periodo, Fecha, Cargo, Abono, Aplica, AplicaID, Acumulado, Conciliado, EsCancelacion, FechaConciliacion, Sucursal, Renglon, RenglonSub)
  SELECT			 ID, Empresa, Rama, Mov, MovID, Modulo, ModuloID, Moneda, TipoCambio, Grupo, Cuenta, SubCuenta, Ejercicio, Periodo, Fecha, Cargo, Abono, Aplica, AplicaID, Acumulado, Conciliado, EsCancelacion, FechaConciliacion, Sucursal, Renglon, RenglonSub
    FROM AuxiliarPMon
   WHERE Empresa = @Empresa
     AND Cuenta = @Cuenta



  SELECT @Datos =(SELECT * FROM @AuxiliarPMon AuxiliarPMon FOR XML AUTO)

  SELECT @Datos = ISNULL(@Datos,'')
  SELECT @LenDatos = LEN(ISNULL(@Datos,''))
  SELECT @Datos = ISNULL(@Datos,'')+ '<Relleno '+  +'A="'+REPLICATE('X',8000-@LenDatos)+'" />'
  
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+' >' 
  +ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
				
END
GO 




 /**************** spPOSISTarjetaMonedero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISTarjetaMonedero')           AND type = 'P') drop procedure dbo.spPOSISTarjetaMonedero
GO             
CREATE PROCEDURE spPOSISTarjetaMonedero
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Serie				varchar(20),
	@Datos				varchar(max),
	@Datos2				varchar(max),
	@Datos3				varchar(max),
	@Datos4				varchar(max),
	@Empresa			varchar(5),
	@ReferenciaIS		varchar(50),
	@SubReferenciaIS	varchar(50),
	@LenDatos			int,
	@SaldoMN			float,
	@LimiteCredito		float

  DECLARE @TarjetaMonedero table (Empresa varchar( 5), Serie varchar(20), Estatus varchar(15), TieneMovimientos bit, Usuario varchar(10), FechaAlta datetime, UsuarioActivacion varchar(10), FechaActivacion datetime, FechaBaja datetime ) 

  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia
    FROM IntelisisService
   WHERE ID = @ID

  SELECT @Serie = RTRIM(LTRIM(Serie)), @Empresa = Empresa  
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TarjetaMonedero')
    WITH (Serie varchar(20), Empresa varchar(5))
    

  INSERT @TarjetaMonedero (Empresa, Serie, Estatus, TieneMovimientos, Usuario, FechaAlta, UsuarioActivacion, FechaActivacion, FechaBaja)
  SELECT			       Empresa, Serie, Estatus, TieneMovimientos, Usuario, FechaAlta, UsuarioActivacion, FechaActivacion, FechaBaja
    FROM TarjetaMonedero
   WHERE Empresa = @Empresa
     AND Serie = @Serie



  SELECT @Datos =(SELECT * FROM @TarjetaMonedero TarjetaMonedero FOR XML AUTO)

  SELECT @Datos = ISNULL(@Datos,'')
  SELECT @LenDatos = LEN(ISNULL(@Datos,''))
  SELECT @Datos = ISNULL(@Datos,'')+ '<Relleno '+  +'A="'+REPLICATE('X',8000-@LenDatos)+'" />'
  
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+' >' 
  +ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
				
END
GO


 /**************** spPOSISTarjetaMonederoActivar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISTarjetaMonederoActivar')           AND type = 'P') drop procedure dbo.spPOSISTarjetaMonederoActivar
GO             
CREATE PROCEDURE spPOSISTarjetaMonederoActivar
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Serie				varchar(20),
	@Datos				varchar(max),
	@Datos2				varchar(max),
	@Datos3				varchar(max),
	@Datos4				varchar(max),
	@Empresa			varchar(5),
	@ReferenciaIS		varchar(50),
	@SubReferenciaIS	varchar(50),
	@LenDatos			int,
	@SaldoMN			float,
	@LimiteCredito		float,
	@Usuario			varchar(10),
	@SucursalT			varchar(3),
	@Sucursal			int

  DECLARE @TarjetaMonederoActivar table (Empresa varchar( 5), Serie varchar(20), Estatus varchar(15), TieneMovimientos bit, Usuario varchar(10), FechaAlta datetime, UsuarioActivacion varchar(10), FechaActivacion datetime, FechaBaja datetime ) 

  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia
    FROM IntelisisService
   WHERE ID = @ID

  SELECT @Serie = RTRIM(LTRIM(Serie)), @Empresa = Empresa, @SucursalT = SucursalT, @Usuario = Usuario
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TarjetaMonederoActivar')
    WITH (Serie varchar(20), Empresa varchar(5), SucursalT varchar(3), Usuario varchar(10))
      
  IF NULLIF(@SucursalT,'') IS NOT NULL
	SELECT @Sucursal = CONVERT(int,@SucursalT)
  
  EXEC spMonederoActivar @Empresa, @Serie, @Usuario, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  INSERT @TarjetaMonederoActivar (Empresa, Serie, Estatus, TieneMovimientos, Usuario, FechaAlta, UsuarioActivacion, FechaActivacion, FechaBaja)
  SELECT						  Empresa, Serie, Estatus, TieneMovimientos, Usuario, FechaAlta, UsuarioActivacion, FechaActivacion, FechaBaja
    FROM TarjetaMonedero
   WHERE Empresa = @Empresa
     AND Serie = @Serie

  SELECT @Datos =(SELECT * FROM @TarjetaMonederoActivar TarjetaMonederoActivar FOR XML AUTO)
  SELECT @Datos = ISNULL(@Datos,'')
  SELECT @LenDatos = LEN(ISNULL(@Datos,''))
  SELECT @Datos = ISNULL(@Datos,'')+ '<Relleno '+  +'A="'+REPLICATE('X',8000-@LenDatos)+'" />'
  
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+' >' 
  +ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
				
END
GO


 /**************** spPOSISMonederoRedimir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSISMonederoRedimir')           AND type = 'P') drop procedure dbo.spPOSISMonederoRedimir
GO             
CREATE PROCEDURE spPOSISMonederoRedimir
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int          = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
	@Serie				varchar(20),
	@Datos				varchar(max),
	@Datos2				varchar(max),
	@Datos3				varchar(max),
	@Datos4				varchar(max),
	@Empresa			varchar(5),
	@ReferenciaIS		varchar(50),
	@SubReferenciaIS	varchar(50),
	@LenDatos			int,
	@SaldoMN			float,
	@LimiteCredito		float,
	@Usuario			varchar(10),
	@Sucursal			int,
	@Mov				varchar(20),
	@MovID				varchar(20),
	@Moneda				varchar(10),
	@TipoCambio			float,
	@Posicion			int,
	@IDPos				varchar(36),
	@Importe			money

  DECLARE @POSSerieTarjetaMovM table (Empresa varchar( 5), Modulo varchar(5), ID varchar(36), Serie varchar(20), Importe money, Sucursal int, Posicion int, Mov varchar(20), MovID varchar(20), Referencia varchar(50), Moneda varchar(10), TipoCambio float, FechaEmision datetime, Usuario varchar(10)) 

  SELECT @ReferenciaIS = Referencia , @SubReferenciaIS = SubReferencia
    FROM IntelisisService
   WHERE ID = @ID

  SELECT @Serie			= RTRIM(LTRIM(Serie)), 
         @Empresa		= Empresa, 
		 @Sucursal		= Sucursal, 
		 @Usuario		= Usuario,
		 @Mov			= Mov,
		 @MovID			= MovID,
		 @Moneda		= Moneda,
		 @TipoCambio	= TipoCambio,
		 @Posicion		= Posicion,
		 @IDPos			= ID,
		 @Importe		= Importe
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/MonederoRedimir')
    WITH (Serie varchar(20), Empresa varchar(5), Sucursal int, Usuario varchar(10), Mov varchar(20), MovID varchar(20),
		  Moneda varchar(10), TipoCambio float, Posicion int, ID varchar(36), Importe money)
      
  EXEC spPOSMonederoCBRefimir @Empresa, @Sucursal, @IDPos, @Serie, @Importe, @Posicion, @Moneda, @TipoCambio, @Usuario, @Mov, @MovID, @Ok OUTPUT, @OkRef OUTPUT

  IF NOT EXISTS (SELECT * FROM POSSerieTarjetaMovM WHERE Mov = @Mov AND MovID = @MovID AND Posicion = @Posicion AND Empresa = @Empresa AND Serie = @Serie AND Sucursal = @Sucursal AND Referencia = 'APROBADA')
	DELETE FROM POSSerieTarjetaMovM WHERE Mov = @Mov AND MovID = @MovID AND Posicion = @Posicion AND Empresa = @Empresa AND Serie = @Serie AND Sucursal = @Sucursal AND Referencia <> 'APROBADA'

  IF @Ok IS NULL
  INSERT @POSSerieTarjetaMovM (Empresa, Modulo, ID, Serie, Importe, Sucursal, Posicion, Mov, MovID, Referencia, Moneda, TipoCambio, FechaEmision, Usuario)
  SELECT						  Empresa, Modulo, ID, Serie, Importe, Sucursal, Posicion, Mov, MovID, Referencia, Moneda, TipoCambio, FechaEmision, Usuario
    FROM POSSerieTarjetaMovM
   WHERE Mov = @Mov 
     AND MovID = @MovID 
	 AND Posicion = @Posicion 
	 AND Empresa = @Empresa
	 AND Serie = @Serie
	 AND Sucursal = @Sucursal

  SELECT @Datos =(SELECT * FROM @POSSerieTarjetaMovM MonederoRedimir FOR XML AUTO)
  SELECT @Datos = ISNULL(@Datos,'')
  SELECT @LenDatos = LEN(ISNULL(@Datos,''))
  SELECT @Datos = ISNULL(@Datos,'')+ '<Relleno '+  +'A="'+REPLICATE('X',8000-@LenDatos)+'" />'
  
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) 
  +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+' >' 
  +ISNULL(@Datos,'')+'</Resultado></Intelisis>' 
				
END
GO

--declare @datos		  varchar(8000),
--		@iSolicitud	int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		    
--set @Ok = null
--set @OkRef = null
--set @datos=
----'<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.POS.PedidosCte" SubReferencia="PedidosCte" Version="1.0"><Solicitud><Pedido   Cliente ="C4656" Empresa="1" Sucursal="18"/></Solicitud> </Intelisis>'



--'<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.POS.ImportarVenta" SubReferencia="ImportarVenta" Version="1.0"><Solicitud><Venta   ReferenciaOrigen ="H1S1CC8KKKK1625" Empresa="FREY" Sucursal="0"/></Solicitud> </Intelisis>'

--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado OUTPUT,@Ok Output,@OkRef Output,1,0,@Id Output
--select CONVERT(xml,@Resultado),LEN(@Resultado)
----declare 
--@Resultado varchar(8000),
--@Solicitud varchar(8000),
--@Ok        varbinary(4),
--@OkRef     varchar(255)
--set @Solicitud='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.intelisis.com/">
--   <soapenv:Header/>
--   <soapenv:Body>
--      <ws:solicitar>
--         <mssqlServidor>David1</mssqlServidor>
--         <mssqlPuerto>1433</mssqlPuerto>
--         <mssqlBaseDatos>POSMatriz</mssqlBaseDatos>
--         <mssqlUsuario>sa</mssqlUsuario>
--         <mssqlContrasena></mssqlContrasena>
--         <Solicitud><![CDATA[<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.POS.AfectarVenta" SubReferencia="AfectarVenta" Version="1.0"><Solicitud><POSL ID="A673F16B-FC62-4311-8303-25815A8D8306" Host="H1S1" Empresa="FREY" Modulo="VTAS" Mov="Nota" MovID="CORPD14" FechaEmision="2012-08-27T00:00:00" FechaRegistro="2012-08-27T19:43:16.680" UEN="0" Moneda="Pesos" TipoCambio="1.000000000000000e+000" Usuario="161003" Estatus="TRASPASADO" Cliente="MOST" Nombre="Cliente Mostrador" Direccion="Direccion de Cliente Mostrador" Pais="Mexico" RFC="SBA951115BE6" CURP="" Almacen="ALFRY-L" Agente="" Cajero="161003" FormaEnvio="" Vencimiento="2012-08-20T00:00:00" CtaDinero="21" Descuento="" Importe="563.5700" Impuestos="92.4300" ListaPreciosEsp="(Precio 4)" ZonaImpuesto="1" Sucursal="0" OrigenTipo="VTAS" Origen="Pedido" OrigenID="COR2" Prefijo="CORPD" Consecutivo="14" Cluster="S1" AnticipoFacturadoTipoServicio="1"><POSLVenta ID="A673F16B-FC62-4311-8303-25815A8D8306" Renglon="2.048000000000000e+003" RenglonSub="0" RenglonID="1" RenglonTipo="N" Cantidad="1.000000000000000e+000" Articulo="0001-ALEXA-LOVE-PV" Precio="2.909090909090909e+001" PrecioSugerido="3.200000000000000e+001" Impuesto1="1.000000000000000e+001" Impuesto2="0.000000000000000e+000" Impuesto3="0.000000000000000e+000" Unidad="Pieza" Factor="1.000000000000000e+000" OfertaID="42" Aplicado="0" PrecioImpuestoInc="3.200000000000000e+001" AnticipoFacturado="0"><POSLSerieLote><POSVentaCobro ID="A673F16B-FC62-4311-8303-25815A8D8306" Importe1="656.0000" FormaCobro1="Efectivo" CtaDinero="21" Cajero="161003" POSTipoCambio1="1.000000000000000e+000"><POSTarjetaSerieMov/></POSVentaCobro></POSLSerieLote></POSLVenta><POSLVenta ID="A673F16B-FC62-4311-8303-25815A8D8306" Renglon="4.096000000000000e+003" RenglonSub="0" RenglonID="2" RenglonTipo="N" Cantidad="1.200000000000000e+001" Articulo="0001-ALEXA-LOVE-TL" Precio="2.758620689655173e+001" PrecioSugerido="3.200000000000000e+001" Impuesto1="1.600000000000000e+001" Impuesto2="0.000000000000000e+000" Impuesto3="0.000000000000000e+000" Unidad="Pieza" Factor="1.000000000000000e+000" OfertaID="42" Aplicado="0" PrecioImpuestoInc="3.200000000000000e+001" AnticipoFacturado="0"><POSLSerieLote><POSVentaCobro ID="A673F16B-FC62-4311-8303-25815A8D8306" Importe1="656.0000" FormaCobro1="Efectivo" CtaDinero="21" Cajero="161003" POSTipoCambio1="1.000000000000000e+000"><POSTarjetaSerieMov/></POSVentaCobro></POSLSerieLote></POSLVenta><POSLVenta ID="A673F16B-FC62-4311-8303-25815A8D8306" Renglon="6.144000000000000e+003" RenglonSub="0" RenglonID="3" RenglonTipo="N" Cantidad="2.000000000000000e+000" Articulo="0001-ALEXA-LOVE-PL" Precio="2.758620689655173e+001" PrecioSugerido="3.200000000000000e+001" Impuesto1="1.600000000000000e+001" Impuesto2="0.000000000000000e+000" Impuesto3="0.000000000000000e+000" Unidad="Pieza" Factor="1.000000000000000e+000" OfertaID="42" Aplicado="0" PrecioImpuestoInc="3.200000000000000e+001" AnticipoFacturado="0"><POSLSerieLote><POSVentaCobro ID="A673F16B-FC62-4311-8303-25815A8D8306" Importe1="656.0000" FormaCobro1="Efectivo" CtaDinero="21" Cajero="161003" POSTipoCambio1="1.000000000000000e+000"><POSTarjetaSerieMov/></POSVentaCobro></POSLSerieLote></POSLVenta><POSLVenta ID="A673F16B-FC62-4311-8303-25815A8D8306" Renglon="8.192000000000000e+003" RenglonSub="0" RenglonID="4" RenglonTipo="N" Cantidad="3.000000000000000e+000" Articulo="0001-ALEXA-SLLN-PV" Precio="2.758620689655173e+001" PrecioSugerido="3.200000000000000e+001" Impuesto1="1.600000000000000e+001" Impuesto2="0.000000000000000e+000" Impuesto3="0.000000000000000e+000" Unidad="Pieza" Factor="1.000000000000000e+000" Aplicado="0" PrecioImpuestoInc="3.200000000000000e+001" AnticipoFacturado="0"><POSLSerieLote><POSVentaCobro ID="A673F16B-FC62-4311-8303-25815A8D8306" Importe1="656.0000" FormaCobro1="Efectivo" CtaDinero="21" Cajero="161003" POSTipoCambio1="1.000000000000000e+000"><POSTarjetaSerieMov/></POSVentaCobro></POSLSerieLote></POSLVenta><POSLVenta ID="A673F16B-FC62-4311-8303-25815A8D8306" Renglon="1.024000000000000e+004" RenglonSub="0" RenglonID="5" RenglonTipo="N" Cantidad="6.000000000000000e+000" Articulo="0001-ALEXA-SLLN-TL" Precio="2.758620689655173e+001" PrecioSugerido="3.200000000000000e+001" Impuesto1="1.600000000000000e+001" Impuesto2="0.000000000000000e+000" Impuesto3="0.000000000000000e+000" Unidad="Pieza" Factor="1.000000000000000e+000" Aplicado="0" PrecioImpuestoInc="3.200000000000000e+001" AnticipoFacturado="0"><POSLSerieLote><POSVentaCobro ID="A673F16B-FC62-4311-8303-25815A8D8306" Importe1="656.0000" FormaCobro1="Efectivo" CtaDinero="21" Cajero="161003" POSTipoCambio1="1.000000000000000e+000"><POSTarjetaSerieMov/></POSVentaCobro></POSLSerieLote></POSLVenta><POSLVenta ID="A673F16B-FC62-4311-8303-25815A8D8306" Renglon="1.228800000000000e+004" RenglonSub="0" RenglonID="6" RenglonTipo="N" Cantidad="1.000000000000000e+000" Articulo="ANTICIPO" Impuesto1="1.500000000000000e+001" Unidad="Piezas" CantidadInventario="1.000000000000000e+000" Aplicado="0" PrecioImpuestoInc="0.000000000000000e+000" AnticipoFacturado="0"><POSLSerieLote><POSVentaCobro ID="A673F16B-FC62-4311-8303-25815A8D8306" Importe1="656.0000" FormaCobro1="Efectivo" CtaDinero="21" Cajero="161003" POSTipoCambio1="1.000000000000000e+000"><POSTarjetaSerieMov/></POSVentaCobro></POSLSerieLote></POSLVenta><POSLVenta ID="A673F16B-FC62-4311-8303-25815A8D8306" Renglon="1.433600000000000e+004" RenglonSub="0" RenglonID="7" RenglonTipo="N" Cantidad="-1.000000000000000e+000" Articulo="OFERTAPUNT" Precio="1.000000000000000e+002" Impuesto1="1.200000537600026e+001" Impuesto2="0.000000000000000e+000" Impuesto3="0.000000000000000e+000" Factor="1.000000000000000e+000" Aplicado="0" PrecioImpuestoInc="1.120000053760003e+002" AnticipoFacturado="1" AnticipoRetencion="0.000000000000000e+000"><POSLSerieLote><POSVentaCobro ID="A673F16B-FC62-4311-8303-25815A8D8306" Importe1="656.0000" FormaCobro1="Efectivo" CtaDinero="21" Cajero="161003" POSTipoCambio1="1.000000000000000e+000"><POSTarjetaSerieMov/></POSVentaCobro></POSLSerieLote></POSLVenta></POSL></Solicitud></Intelisis>]]></Solicitud>
--         <intelisisUsuario>1</intelisisUsuario>
--         <intelisisContrasena>13972c14ad4df4e53ec22bfdd8ddb8b7</intelisisContrasena>
--         <procesar>1</procesar>
--         <eliminarProcesado>0</eliminarProcesado>
--      </ws:solicitar>
--   </soapenv:Body>
--</soapenv:Envelope>'

--exec spWebServiceSolicitud 'http://localhost:8080/IntelisisWebService?wsdl', 'POST', @Solicitud, 'solicitar','', '', @Resultado out, @Ok OUTPUT, @OkRef OUTPUT

