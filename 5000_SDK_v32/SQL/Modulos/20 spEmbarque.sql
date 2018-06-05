/* SP EMBARQUES   */

-- EMB.E  = Embarque
-- EMB.OC = Orden Cobro

SET NOCOUNT ON

--REQ12615 WMS
/**************** xpEmbarqueAsignarWMS ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpEmbarqueAsignarWMS') and type = 'P') drop procedure dbo.xpEmbarqueAsignarWMS
GO             
CREATE PROCEDURE xpEmbarqueAsignarWMS
		    @ID			int

AS BEGIN
  -- SET nocount ON
  DECLARE
    @ModuloID		int,
    @Modulo			char(10),
    @WMS			bit,
    @Mov			varchar(20),
    @Origen			varchar(20),
    @Renglon		float,
    @RenglonSub		int,
    @Tarima			varchar(20)

  DECLARE crEmbarqueDArt CURSOR FOR
   SELECT Modulo, ModuloID
     FROM EmbarqueDArt
    WHERE ID = @ID AND Modulo IN ('VTAS', 'COMS')
    GROUP BY Modulo, ModuloID
  OPEN crEmbarqueDArt
  FETCH NEXT FROM crEmbarqueDArt INTO @Modulo, @ModuloID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
    
      IF @Modulo = 'VTAS'
        SELECT
           @WMS      =	ISNULL(a.WMS,0),
           @Mov      =	Mov,
           @Origen   =	ISNULL(Origen,'')
          FROM Venta v JOIN Alm a ON v.Almacen = a.Almacen WHERE v.ID = @ModuloID
      ELSE
      IF @Modulo = 'COMS'
        SELECT
           @WMS      =	ISNULL(a.WMS,0),
           @Mov      =	Mov,
           @Origen   =	ISNULL(Origen,'')
          FROM Inv v JOIN Alm a ON v.Almacen = a.Almacen WHERE v.ID = @ModuloID

      IF @WMS = 1 AND EXISTS(SELECT * FROM WMSModuloMovimiento WHERE Modulo = @Modulo AND Movimiento IN (@Mov, @Origen))
      BEGIN
        IF @Modulo = 'VTAS'
          DECLARE crTarima CURSOR FOR
           SELECT Renglon, RenglonSub, Tarima
             FROM VentaD
            WHERE ID = @ModuloID AND ISNULL(Tarima,'') <> ''
        ELSE
        IF @Modulo = 'COMS'
          DECLARE crTarima CURSOR FOR
           SELECT Renglon, RenglonSub, Tarima
             FROM CompraD
            WHERE ID = @ModuloID AND ISNULL(Tarima,'') <> ''

        OPEN crTarima
        FETCH NEXT FROM crTarima INTO @Renglon, @RenglonSub, @Tarima
        WHILE @@FETCH_STATUS <> -1
        BEGIN
          IF @@FETCH_STATUS <> -2
          BEGIN
            UPDATE EmbarqueDArt SET Tarima = @Tarima WHERE ID = @ID AND Modulo = @Modulo AND ModuloID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub              
          END
          FETCH NEXT FROM crTarima INTO @Renglon, @RenglonSub, @Tarima
        END -- While
        CLOSE crTarima
        DEALLOCATE crTarima
      END
    END
    FETCH NEXT FROM crEmbarqueDArt INTO @Modulo, @ModuloID
  END -- While
  CLOSE crEmbarqueDArt
  DEALLOCATE crEmbarqueDArt

  RETURN
END
GO

/**************** spEmbarqueAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarqueAsignar') and type = 'P') drop procedure dbo.spEmbarqueAsignar
GO             
CREATE PROCEDURE spEmbarqueAsignar
		    @Sucursal		int,
	            @Estacion		int,
		    @ID			int,
		    @BorrarAnterior	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ListaID		int,
    @Modulo			char(10),
    @Paquetes		int,
    @Observaciones	varchar(100),
    @Orden 			int,
    @MovPorcentaje	float,
--JGD20Julio2011 Ticket 5227 Variable nueva para asignar el Movimiento de EmbarqueMov
    @IDVtas         int

  IF NOT EXISTS(SELECT * FROM Embarque WHERE ID = @ID)
    RETURN

  BEGIN TRANSACTION
  IF @BorrarAnterior = 1 
  BEGIN
    DELETE EmbarqueD WHERE ID = @ID
    DELETE EmbarqueDArt WHERE ID = @ID
    DELETE GuiaEmbarqueD WHERE Modulo = 'EMB' AND ID = @ID 
  END

  SELECT @Orden = ISNULL(MAX(Orden), 0) FROM EmbarqueD WHERE ID = @ID AND EmbarqueMov NOT IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)

  UPDATE EmbarqueMov 
     SET AsignadoID = @ID 
   WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
     AND AsignadoID IS NULL

  DECLARE crLista CURSOR 
      FOR SELECT l.ID, e.Paquetes, e.Modulo, e.ObservacionesEmbarque
            FROM ListaID l, EmbarqueMov e
           WHERE l.Estacion = @Estacion AND l.ID = e.ID AND AsignadoID = @ID
  OPEN crLista
  FETCH NEXT FROM crLista INTO @ListaID, @Paquetes, @Modulo, @Observaciones
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Orden = @Orden + 1
      IF @Modulo = 'VTAS'
      BEGIN
/*
        INSERT EmbarqueDArt (Sucursal, ID, EmbarqueMov, Modulo, ModuloID, Renglon, RenglonSub, CantidadTotal, ImporteTotal, Cantidad)
                      SELECT @Sucursal, @ID, @ListaID, em.Modulo, em.ModuloID, d.Renglon, d.RenglonSub, d.CantidadNeta, d.ImporteTotal, d.CantidadNeta-ISNULL(d.CantidadEmbarcada, 0)
                        FROM EmbarqueMov em, VentaTCalc d
                       WHERE em.ID = @ListaID AND em.Modulo = @Modulo
                         AND em.ModuloID = d.ID
*/
--JGD20Julio2011 Ticket 5227 El join se separa en 3 partes 
        SELECT @IDVtas = (SELECT ModuloID FROM EmbarqueMov WHERE ID = @ListaID AND Modulo = @Modulo)

        SELECT d.ID, d.Renglon, d.RenglonSub, d.CantidadNeta, d.ImporteTotal, d.CantidadNeta-ISNULL(d.CantidadEmbarcada, 0) CantidadNeta1, Tarima --REQ12615 WMS
        INTO #VentaTCalc
                        FROM VentaTCalc d
                       WHERE d.ID = @IDVtas

        INSERT EmbarqueDArt (Sucursal, ID, EmbarqueMov, Modulo, ModuloID, Renglon, RenglonSub, CantidadTotal, ImporteTotal, Cantidad, Tarima) --REQ12615 WMS
                      SELECT @Sucursal, @ID, @ListaID, @Modulo, d.ID, d.Renglon, d.RenglonSub, d.CantidadNeta, d.ImporteTotal, d.CantidadNeta1/*-ISNULL(d.CantidadEmbarcada, 0)*/, d.Tarima --REQ12615 WMS
                        FROM #VentaTCalc d
--Fin JGD20Julio2011 Ticket 5227
            DROP TABLE #VentaTCalc
      END
      ELSE
      IF @Modulo = 'COMS'
      BEGIN
        INSERT EmbarqueDArt (Sucursal, ID, EmbarqueMov, Modulo, ModuloID, Renglon, RenglonSub, CantidadTotal, ImporteTotal, Cantidad, Tarima) --REQ12615 WMS
                      SELECT @Sucursal, @ID, @ListaID, em.Modulo, em.ModuloID, d.Renglon, d.RenglonSub, d.CantidadNeta, d.ImporteTotal, d.CantidadNeta-ISNULL(d.CantidadEmbarcada, 0), d.Tarima --REQ12615 WMS
                        FROM EmbarqueMov em, CompraTCalc d
                       WHERE em.ID = @ListaID AND em.Modulo = @Modulo
                         AND em.ModuloID = d.ID
      END
        
      SELECT @MovPorcentaje = (SUM(ISNULL(Cantidad, 0)*ImporteTotal)/NULLIF(SUM(ISNULL(CantidadTotal, 0)*ImporteTotal), 0)) * 100
        FROM EmbarqueDArt
       WHERE ID = @ID AND EmbarqueMov = @ListaID
           
      INSERT EmbarqueD (Sucursal, ID, EmbarqueMov, MovPorcentaje, Orden, Paquetes, Observaciones) 
              VALUES (@Sucursal, @ID, @ListaID, @MovPorcentaje, @Orden, @Paquetes, @Observaciones)
    END
    FETCH NEXT FROM crLista INTO @ListaID, @Paquetes, @Modulo, @Observaciones
  END -- While
  CLOSE crLista
  DEALLOCATE crLista

  --EXEC xpEmbarqueAsignarWMS @ID --REQ12615 WMS

  UPDATE EmbarqueMov 
     SET AsignadoID = NULL
   WHERE AsignadoID = @ID AND ID NOT IN (SELECT EmbarqueMov FROM EmbarqueD WHERE ID = @ID)

  INSERT INTO GuiaEmbarqueD (Sucursal, Modulo, ID, Guia) 
       SELECT DISTINCT @Sucursal, 'EMB', @ID, g.Guia 
         FROM GuiaEmbarqueD g, EmbarqueMov e, ListaID l
        WHERE l.Estacion = @Estacion AND l.ID = e.ID
          AND g.Modulo = e.Modulo AND g.ID = e.ModuloID

  DELETE ListaID WHERE Estacion = @Estacion
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spEmbarqueDesAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarqueDesAsignar') and type = 'P') drop procedure dbo.spEmbarqueDesAsignar
GO             
CREATE PROCEDURE spEmbarqueDesAsignar
                    @Estacion		int,
		    @ID			int,
		    @AntecendeteID	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
		@Estatus		char(15)
  SELECT @Estatus = Estatus FROM Embarque WHERE ID = @ID
  -- SET nocount ON
  SELECT @AntecendeteID = NULLIF(@AntecendeteID, 0) 
  IF @Estatus = 'SINAFECTAR'
  BEGIN
    BEGIN TRANSACTION
      DELETE GuiaEmbarqueD WHERE Modulo = 'EMB' AND ID = @ID AND Guia IN (SELECT g.Guia FROM GuiaEmbarqueD g, EmbarqueMov e, ListaID l WHERE l.Estacion = @Estacion AND l.ID = e.ID AND g.Modulo = e.Modulo AND g.ID = e.ModuloID)
      UPDATE EmbarqueMov SET AsignadoID = @AntecendeteID WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
      DELETE EmbarqueD WHERE ID = @ID AND EmbarqueMov IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
      DELETE EmbarqueDArt WHERE ID = @ID AND EmbarqueMov IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
      DELETE ListaID WHERE Estacion = @Estacion
    COMMIT TRANSACTION
  END
  RETURN
END
GO


/**************** spEmbarqueActualizarTotales ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarqueActualizarTotales') and type = 'P') drop procedure dbo.spEmbarqueActualizarTotales
GO             
CREATE PROCEDURE spEmbarqueActualizarTotales
		    @ID			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MovImporte			money, 
    @MovImpuestos		money, 
    @MovTipoCambio		float, 
    @MovPorcentaje		float,
    @Peso			float, 
    @Volumen			float, 
    @Paquetes			int,
    @SumaPeso			float,
    @SumaVolumen		float,
    @SumaPaquetes		int,
    @SumaImportePesos		money,
    @SumaImpuestosPesos		money,
    @SumaImporteEmbarque	money

  SELECT @SumaPeso 	     = 0.0, 
         @SumaVolumen        = 0.0, 
         @SumaPaquetes       = 0.0,
         @SumaImportePesos   = 0.0,
         @SumaImpuestosPesos = 0.0,
         @SumaImporteEmbarque= 0.0

  DECLARE crEmbarque CURSOR FOR
   SELECT m.Importe, m.Impuestos, m.TipoCambio, ISNULL(m.Peso, 0.0), ISNULL(m.Volumen, 0.0), ISNULL(d.Paquetes, 0), ISNULL(d.MovPorcentaje, 0)
     FROM EmbarqueD d, EmbarqueMov m
    WHERE d.EmbarqueMov=m.ID AND d.ID = @ID

  OPEN crEmbarque
  FETCH NEXT FROM crEmbarque INTO @MovImporte, @MovImpuestos, @MovTipoCambio, @Peso, @Volumen, @Paquetes, @MovPorcentaje
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      SELECT @SumaPeso           = @SumaPeso           + @Peso, 
             @SumaVolumen        = @SumaVolumen        + @Volumen, 
	     @SumaPaquetes       = @SumaPaquetes       + @Paquetes,
             @SumaImportePesos   = @SumaImportePesos   + (@MovImporte * @MovTipoCambio),
             @SumaImpuestosPesos = @SumaImpuestosPesos + (@MovImpuestos * @MovTipoCambio),
             @SumaImporteEmbarque= @SumaImporteEmbarque+ (((ISNULL(@MovImporte, 0)+ISNULL(@MovImpuestos, 0))*@MovTipoCambio))*(@MovPorcentaje/100)
    FETCH NEXT FROM crEmbarque INTO @MovImporte, @MovImpuestos, @MovTipoCambio, @Peso, @Volumen, @Paquetes, @MovPorcentaje
  END -- While
  CLOSE crEmbarque
  DEALLOCATE crEmbarque

  UPDATE Embarque
     SET Peso	      	  = NULLIF(@SumaPeso, 0.0),
         Volumen	  = NULLIF(@SumaVolumen, 0.0),
	 Paquetes	  = NULLIF(@SumaPaquetes, 0.0),
         Importe	  = NULLIF(@SumaImportePesos, 0.0),
         Impuestos        = NULLIF(@SumaImpuestosPesos, 0.0),
         ImporteEmbarque  = NULLIF(@SumaImporteEmbarque, 0.0)
   WHERE ID = @ID 
  RETURN
END
GO


/**************** spEmbarqueEliminarDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarqueEliminarDetalle') and type = 'P') drop procedure dbo.spEmbarqueEliminarDetalle
GO             
CREATE PROCEDURE spEmbarqueEliminarDetalle
		    @ID			int,
		    @Orden		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EmbarqueMov	int

  SELECT @EmbarqueMov = EmbarqueMov FROM EmbarqueD WHERE ID = @ID AND Orden = @Orden
  IF EXISTS(SELECT * FROM EmbarqueD WHERE ID = @ID AND Orden <> @Orden)
  BEGIN
    BEGIN TRANSACTION   
      UPDATE EmbarqueMov SET AsignadoID = NULL WHERE ID = @EmbarqueMov
      DELETE EmbarqueD WHERE ID = @ID AND Orden = @Orden
      EXEC spEmbarqueActualizarTotales @ID
    COMMIT TRANSACTION
  END
  RETURN
END
GO

/************** spEmbarqueMov *************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarqueMov') and type = 'P') drop procedure dbo.spEmbarqueMov
GO
CREATE PROCEDURE spEmbarqueMov
		   @Accion		char(20),
    		   @Empresa		char(5),
                   @Modulo  		char(5),
                   @ID	    		int,
		   @Mov			char(20),
		   @MovID		varchar(20),
                   @Estatus		char(15),
		   @EstatusNuevo	char(15),
		   @CfgEmbarcar		bit,

		   @Ok			int OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal		int,
    @AsignadoID		int,
    @MovReferencia 	varchar(50),
    @MovObservaciones 	varchar(100),
    @FechaEmision	datetime,
    @Almacen		char(10),
    @Cliente		char(10),
    @ClienteEnviarA	int,
    @Proveedor		char(10),
    @AlmacenDestino	char(10),
    @Peso		float,
    @Volumen		float,
    @Paquetes		int,
    @Importe		money,
    @Impuestos		money,
    @ImporteNeto	money,
    @DescuentoGlobal	float,
    @SobrePrecio	float,
    @Moneda  		char(10),
    @TipoCambio		float,
    @UEN		int,
    @Condicion  	varchar(50),
    @Vencimiento	datetime,
    @BeneficiarioNombre	varchar(100),

    @Nombre		varchar(100),
    @NombreEnvio	varchar(100),
    @Direccion 		varchar(100),
    @EntreCalles	varchar(100),
    @Plano		varchar(15),
    @Observaciones	varchar(100),
    @Delegacion		varchar(30),
    @Colonia 		varchar(30),
    @Poblacion 		varchar(30),
    @Estado 		varchar(30),
    @Pais 		varchar(30),
    @CodigoPostal 	varchar(15),
    @Telefonos		varchar(100),
    @Contacto1 		varchar(50),
    @Contacto2 		varchar(50),
    @Extencion1		varchar(10),
    @Extencion2		varchar(10),
    @DireccionNumero	varchar(20),
    @DireccionNumeroInt	varchar(20),
    @MapaLatitud	float,
    @MapaLongitud	float,
    @MapaPrecision	int,

    @AccionEmbarque	varchar(50),
    @Zona		varchar(30),
    @Ruta		varchar(50),
    @ZonaTipo		varchar(50),
    @OrdenEmbarque	int,
    @CfgEstadoPendiente	varchar(50),
    @SubClave           varchar(20),
    @Ubicacion          varchar(1000)
    
  IF @Estatus = @EstatusNuevo RETURN

  SELECT @Cliente = NULL, @ClienteEnviarA = NULL, @Proveedor = NULL, @Almacen = NULL, @AlmacenDestino = NULL, @Ruta = NULL, @Zona = NULL,
  	 @Volumen = 0.0, @Peso = 0.0, @Paquetes = NULL, @Importe = 0.0, @DescuentoGlobal = 0.0, @SobrePrecio = 0.0, @Impuestos = 0.0, 
         @AccionEmbarque = NULL, @BeneficiarioNombre = NULL

  IF @CfgEmbarcar = 1 AND @Estatus = 'SINAFECTAR' AND @EstatusNuevo <> 'CANCELADO'
  BEGIN
    IF @Modulo = 'VTAS'
    BEGIN
      SELECT @Sucursal = Sucursal, @FechaEmision = FechaEmision, @MovReferencia = Referencia, @MovObservaciones = Observaciones, @Almacen = Almacen,
             @Cliente = Cliente, @ClienteEnviarA = NULLIF(EnviarA, 0), @Volumen = ISNULL(Volumen, 0.0), @Peso = ISNULL(Peso, 0.0),
             @Importe = ISNULL(Importe, 0.0), @DescuentoGlobal = ISNULL(DescuentoGlobal, 0.0), @SobrePrecio = ISNULL(SobrePrecio, 0.0), @Impuestos = ISNULL(Impuestos, 0.0), @Moneda = Moneda, @TipoCambio = TipoCambio,
             @Condicion = Condicion, @Vencimiento = Vencimiento, @Paquetes = Paquetes, @UEN = UEN
        FROM Venta
       WHERE ID = @ID

       SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov and @Modulo = 'VTAS' 

    end
    ELSE
    IF @Modulo = 'COMS'
      SELECT @Sucursal = Sucursal, @FechaEmision = FechaEmision, @MovReferencia = Referencia, @MovObservaciones = Observaciones, @Almacen = Almacen,
             @Proveedor = Proveedor, @Volumen = ISNULL(Volumen, 0.0), @Peso = ISNULL(Peso, 0.0),
             @Importe = ISNULL(Importe, 0.0), @DescuentoGlobal = ISNULL(DescuentoGlobal, 0.0), @Impuestos = ISNULL(Impuestos, 0.0), @Moneda = Moneda, @TipoCambio = TipoCambio,
             @Condicion = Condicion, @Vencimiento = Vencimiento, @UEN = UEN
        FROM Compra
       WHERE ID = @ID
    ELSE
    IF @Modulo = 'INV'
      SELECT @Sucursal = Sucursal, @FechaEmision = FechaEmision, @MovReferencia = Referencia, @MovObservaciones = Observaciones, @Almacen = Almacen, 
             @AlmacenDestino = AlmacenDestino, @Volumen = ISNULL(Volumen, 0.0), @Peso = ISNULL(Peso, 0.0),
             @Importe = ISNULL(Importe, 0.0), @Moneda = Moneda, @TipoCambio = TipoCambio,
             @Condicion = Condicion, @Vencimiento = Vencimiento, @Paquetes = Paquetes, @UEN = UEN
        FROM Inv
       WHERE ID = @ID
    ELSE
    IF @Modulo = 'CXC'
      SELECT @Sucursal = Sucursal, @FechaEmision = FechaEmision, @MovReferencia = Referencia, @MovObservaciones = Observaciones,
             @Cliente = Cliente, @ClienteEnviarA = NULLIF(ClienteEnviarA, 0), @Importe = ISNULL(Importe, 0.0), @Impuestos = ISNULL(Impuestos, 0.0), @Moneda = Moneda, @TipoCambio = TipoCambio,
             @Condicion = Condicion, @Vencimiento = Vencimiento, @UEN = UEN
        FROM Cxc
       WHERE ID = @ID
    ELSE
    IF @Modulo = 'CXP'
      SELECT @Sucursal = Sucursal, @FechaEmision = FechaEmision, @MovReferencia = Referencia, @MovObservaciones = Observaciones,
             @Proveedor = Proveedor, @Importe = ISNULL(Importe, 0.0), @Impuestos = ISNULL(Impuestos, 0.0), @Moneda = Moneda, @TipoCambio = TipoCambio,
             @Condicion = Condicion, @Vencimiento = Vencimiento, @UEN = UEN
        FROM Cxp
       WHERE ID = @ID
    ELSE
    IF @Modulo = 'DIN'
      SELECT @Sucursal = Sucursal, @FechaEmision = FechaEmision, @MovReferencia = Referencia, @MovObservaciones = Observaciones,
             @Importe = ISNULL(Importe, 0.0), @Impuestos = ISNULL(Impuestos, 0.0), @Moneda = Moneda, @TipoCambio = TipoCambio,
             @BeneficiarioNombre = NULLIF(RTRIM(BeneficiarioNombre), ''), @UEN = UEN
        FROM Dinero
       WHERE ID = @ID
    ELSE
    IF @Modulo = 'CAM'
      SELECT @Sucursal = Sucursal, @FechaEmision = FechaEmision, @MovReferencia = Referencia, @MovObservaciones = Observaciones,
             @Cliente = Cliente, @ClienteEnviarA = NULLIF(ClienteEnviarA, 0), 
             @Condicion = Condicion, @Vencimiento = Vencimiento, @UEN = UEN
        FROM Cambio
       WHERE ID = @ID
  
    SELECT @ImporteNeto = dbo.fnSubTotal(@Importe, @DescuentoGlobal, @SobrePrecio)

    IF @Cliente IS NOT NULL
      SELECT @Nombre = Nombre, @NombreEnvio = Nombre, @Direccion = Direccion, @Colonia = Colonia, @Delegacion = Delegacion, @Poblacion = Poblacion, @Estado = Estado,
             @EntreCalles = EntreCalles, @Plano = Plano, @Observaciones = Observaciones,
             @Pais = Pais, @CodigoPostal = CodigoPostal, @Telefonos = Telefonos, 
             @Contacto1 = Contacto1, @Contacto2 = Contacto2, @Extencion1 = Extencion1, @Extencion2 = Extencion2,
             @Ruta = Ruta, @OrdenEmbarque = RutaOrden,
             @DireccionNumero = DireccionNumero, @DireccionNumeroInt = DireccionNumeroInt, 
             @MapaLatitud = MapaLatitud, @MapaLongitud = MapaLongitud, @MapaPrecision = MapaPrecision
        FROM Cte
       WHERE Cliente = @Cliente

    IF @AlmacenDestino IS NOT NULL
      SELECT @Nombre = Almacen, @NombreEnvio = Nombre, @Direccion = Direccion, @Colonia = Colonia, @Delegacion = Delegacion, @Poblacion = Poblacion, @Estado = Estado,
             @EntreCalles = EntreCalles, @Plano = Plano, @Observaciones = Observaciones,
             @Pais = Pais, @CodigoPostal = CodigoPostal, @Telefonos = Telefonos, 
             @Contacto1 = Encargado, @Ruta = Ruta,
             @DireccionNumero = DireccionNumero, @DireccionNumeroInt = DireccionNumeroInt, 
             @MapaLatitud = MapaLatitud, @MapaLongitud = MapaLongitud, @MapaPrecision = MapaPrecision
        FROM Alm
       WHERE Almacen = @AlmacenDestino

    IF @Cliente IS NOT NULL AND @ClienteEnviarA IS NOT NULL
      SELECT @NombreEnvio = Nombre, @Direccion = Direccion, @Colonia = Colonia, @Delegacion = Delegacion, @Poblacion = Poblacion, @Estado = Estado,
             @EntreCalles = EntreCalles, @Plano = Plano, @Observaciones = Observaciones,
             @Pais = Pais, @CodigoPostal = CodigoPostal, @Telefonos = Telefonos, 
             @Contacto1 = Contacto1, @Contacto2 = Contacto2, @Extencion1 = Extencion1, @Extencion2 = Extencion2,
             @Ruta = Ruta,
             @DireccionNumero = DireccionNumero, @DireccionNumeroInt = DireccionNumeroInt, 
             @MapaLatitud = MapaLatitud, @MapaLongitud = MapaLongitud, @MapaPrecision = MapaPrecision
        FROM CteEnviarA
       WHERE Cliente = @Cliente AND ID = @ClienteEnviarA

    IF @BeneficiarioNombre IS NOT NULL
      SELECT @Proveedor = Proveedor FROM Prov WHERE BeneficiarioNombre = @BeneficiarioNombre OR Nombre = @BeneficiarioNombre
  
    IF @Proveedor IS NOT NULL
      SELECT @Nombre = Nombre, @NombreEnvio = Nombre, @Direccion = Direccion, @Colonia = Colonia, @Delegacion = Delegacion, @Poblacion = Poblacion, @Estado = Estado,
             @EntreCalles = EntreCalles, @Plano = Plano, @Observaciones = Observaciones,
             @Pais = Pais, @CodigoPostal = CodigoPostal, @Telefonos = Telefonos, 
             @Contacto1 = Contacto1, @Contacto2 = Contacto2, @Extencion1 = Extencion1, @Extencion2 = Extencion2,
             @Ruta = Ruta,
             @DireccionNumero = DireccionNumero, @DireccionNumeroInt = DireccionNumeroInt, 
             @MapaLatitud = MapaLatitud, @MapaLongitud = MapaLongitud, @MapaPrecision = MapaPrecision
        FROM Prov
       WHERE Proveedor = @Proveedor


    SELECT @Ruta = r.Ruta, @Zona = r.Zona, @ZonaTipo = NULLIF(RTRIM(z.Tipo), '')
      FROM Ruta r, Zona z
     WHERE r.Ruta = @Ruta AND r.Zona = z.Zona

--    IF @Ruta IS NULL SELECT @Ok = 30510 

    SELECT @CfgEstadoPendiente = EmbarqueEstadoPendiente
      FROM EmpresaCfg
     WHERE Empresa = @Empresa
     
    SELECT @AccionEmbarque = Accion 
      FROM EmpresaCfgMovEsp 
     WHERE Empresa = @Empresa
       AND Asunto = 'EMB'
       AND Modulo = @Modulo
       AND Mov = @Mov
    
    IF @SubClave = 'VTAS.EMBARQUE'
      SELECT @MapaLatitud = MapaLatitud, @MapaLongitud = MapaLongitud, @Ubicacion = Ubicacion
        FROM Venta
       WHERE ID = @ID
      

    INSERT EmbarqueMov (Sucursal, Accion, Zona, Ruta, ZonaTipo, OrdenEmbarque, 
  	  	        Empresa, Modulo, ModuloID, Mov, MovID, MovEstatus, FechaEmision, MovReferencia, MovObservaciones, Almacen, 
			Cliente, ClienteEnviarA, Proveedor, AlmacenDestino, 
			Volumen, Peso, Paquetes, Importe, Impuestos, Moneda, TipoCambio, UEN, Condicion, Vencimiento,
     		        Nombre, NombreEnvio, Direccion, EntreCalles, Plano, Observaciones, Colonia, Delegacion, Poblacion, Estado, Pais, CodigoPostal, 
			Telefonos, Contacto1, Contacto2, Extencion1, Extencion2, 
			DireccionNumero, DireccionNumeroInt, MapaLatitud, MapaLongitud, MapaPrecision, Ubicacion)
                VALUES (@Sucursal, @AccionEmbarque, @Zona, @Ruta, @ZonaTipo, @OrdenEmbarque, 
      		        @Empresa, @Modulo, @ID, @Mov, @MovID, @EstatusNuevo, @FechaEmision, @MovReferencia, @MovObservaciones, @Almacen, 
			@Cliente, @ClienteEnviarA, @Proveedor, @AlmacenDestino, 
			@Volumen, @Peso, NULLIF(@Paquetes, 0), @ImporteNeto, @Impuestos, @Moneda, @TipoCambio, @UEN, @Condicion, @Vencimiento,
			@Nombre, @NombreEnvio, @Direccion, @EntreCalles, @Plano, @Observaciones, @Colonia, @Delegacion, @Poblacion, @Estado, @Pais, @CodigoPostal, 
			@Telefonos, @Contacto1, @Contacto2, @Extencion1, @Extencion2,
			@DireccionNumero, @DireccionNumeroInt, @MapaLatitud, @MapaLongitud, @MapaPrecision, @Ubicacion)
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @Ok IS NULL
    BEGIN
      IF @Modulo = 'VTAS' UPDATE Venta  SET EmbarqueEstado = @CfgEstadoPendiente WHERE ID = @ID ELSE
      IF @Modulo = 'COMS' UPDATE Compra SET EmbarqueEstado = @CfgEstadoPendiente WHERE ID = @ID ELSE
      IF @Modulo = 'INV'  UPDATE Inv    SET EmbarqueEstado = @CfgEstadoPendiente WHERE ID = @ID ELSE
      IF @Modulo = 'CXC'  UPDATE Cxc    SET EmbarqueEstado = @CfgEstadoPendiente WHERE ID = @ID ELSE
      IF @Modulo = 'DIN'  UPDATE Dinero SET EmbarqueEstado = @CfgEstadoPendiente WHERE ID = @ID 
    END
  END
  ELSE BEGIN  
    UPDATE EmbarqueMov
       SET MovEstatus = @EstatusNuevo,
           @AsignadoID = AsignadoID
     WHERE Modulo = @Modulo
       AND ModuloID = @ID
       /* AND Empresa = @Empresa
       AND Mov = @Mov
       AND MovID = @MovID*/

    IF @Accion = 'CANCELAR' AND @AsignadoID IS NOT NULL 
      IF (SELECT Estatus FROM Embarque WHERE ID = @AsignadoID) <> 'CONCLUIDO'
        SELECT @Ok = 42020
  END 
  RETURN 
END
GO

/************** spEmbarqueManual *************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarqueManual') and type = 'P') drop procedure dbo.spEmbarqueManual
GO
CREATE PROCEDURE spEmbarqueManual
    		   @Empresa		char(5),
                   @Modulo  		char(5),
                   @ID	    		int,
		   @Mov			char(20),
		   @MovID		varchar(20),
                   @Estatus		char(15),
		   @DesEmbarcar		bit	= 0,
		   @EnSilencio		bit	= 0

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @AsignadoID int,
    @Ok      	int,
    @OkRef   	varchar(255),	
    @OkDesc  	varchar(255),	
    @OkTipo  	varchar(50)	

  SELECT @Ok = NULL, @OkRef = NULL, @OkDesc = NULL, @OkTipo = NULL
  EXEC xpEmbarqueManual @Empresa, @Modulo, @ID, @Mov, @MovID, @Estatus, @DesEmbarcar, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    IF @DesEmbarcar = 1
    BEGIN
      IF EXISTS(SELECT * FROM EmbarqueMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov AND MovID = @MovID)
      BEGIN
        DELETE EmbarqueMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov AND MovID = @MovID AND AsignadoID IS NULL
        IF @@ROWCOUNT = 0 SELECT @Ok = 42020

        IF @Ok IS NULL 
        BEGIN
          IF @Modulo = 'VTAS' UPDATE Venta  SET EmbarqueEstado = NULL WHERE ID = @ID ELSE
          IF @Modulo = 'COMS' UPDATE Compra SET EmbarqueEstado = NULL WHERE ID = @ID ELSE
          IF @Modulo = 'INV'  UPDATE Inv    SET EmbarqueEstado = NULL WHERE ID = @ID ELSE
          IF @Modulo = 'CXC'  UPDATE Cxc    SET EmbarqueEstado = NULL WHERE ID = @ID ELSE
          IF @Modulo = 'DIN'  UPDATE Dinero SET EmbarqueEstado = NULL WHERE ID = @ID 
        END
      END ELSE SELECT @Ok = 42030
    END ELSE
    BEGIN

      IF @Modulo = 'VTAS'
      BEGIN
        IF EXISTS (SELECT * FROM VentaD d JOIN EmbarqueMov e ON  Empresa = @Empresa AND Modulo = @Modulo AND Mov = Aplica AND MovID = AplicaID WHERE d.ID = @ID)
        SELECT @OKRef = Aplica+' '+AplicaID, @Ok = 42020 FROM VentaD d JOIN EmbarqueMov e ON  Empresa = @Empresa AND Modulo = @Modulo AND Mov = Aplica AND MovID = AplicaID WHERE d.ID = @ID
      END

      IF EXISTS(SELECT * FROM EmbarqueMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov AND MovID = @MovID)
        SELECT @Ok = 42020								--  El Movimiento Ya Fue Embarcado

      IF @OK IS NULL
        EXEC spEmbarqueMov 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'SINAFECTAR', @Estatus, 1, @Ok OUTPUT
    END
  END

  IF @EnSilencio = 0
  BEGIN   
    IF @Ok IS NULL 
      SELECT @OkRef = NULL
    ELSE
      SELECT @OkDesc = Descripcion, 
             @OkTipo = Tipo
        FROM MensajeLista
       WHERE Mensaje = @Ok  

    SELECT @Ok, @OkDesc, @OkTipo, @OkRef, NULL
  END
  RETURN 
END
GO

/**************** spEmbarqueVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarqueVerificar') and type = 'P') drop procedure dbo.spEmbarqueVerificar
GO
CREATE PROCEDURE spEmbarqueVerificar
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

                    @Vehiculo			char(10),
		    @PersonalCobrador		varchar(10),		

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @CfgDesembarquesParciales   bit,	

		    @AntecedenteID		int	     OUTPUT,
		    @AntecedenteMovTipo		char(20)     OUTPUT,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ModuloID	int,
    @EstadoTipo char(20),
    @Cliente	char(10),
    @Proveedor	char(10),
    @Importe	money
    

  IF @Accion = 'CANCELAR'
  BEGIN
    IF EXISTS(SELECT * FROM EmbarqueD WHERE ID = @ID AND DesembarqueParcial = 1)
      SELECT @Ok = 42050

    RETURN
    -- Checar que se haya capturado el movimiento en este modulo
    /*IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND OModulo = @Modulo AND OID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070*/
  END 
  ELSE BEGIN
    IF @Estatus = 'SINAFECTAR'
    BEGIN
      IF NOT EXISTS(SELECT * FROM EmbarqueD WHERE ID = @ID) SELECT @Ok = 60010
      IF (SELECT Estatus FROM Vehiculo WHERE Vehiculo = @Vehiculo) = 'ENTRANSITO' SELECT @Ok = 42010 
      ELSE BEGIN
        SELECT @ModuloID = NULL 
        --Bug25872
        SELECT @ModuloID = MIN(e.ModuloID)FROM EmbarqueDArt e INNER JOIN VentaD d ON e.ModuloID = d.ID INNER JOIN  VENTA ON VENTA.ID=D.ID INNER JOIN  EmpresaCfg2 ON EmpresaCfg2.Empresa =VENTA.Empresa WHERE e.ID = @ID AND e.Modulo = 'VTAS' AND e.Renglon = d.Renglon AND e.RenglonSub = d.RenglonSub AND (e.Cantidad<0 OR e.Cantidad>(d.Cantidad-ISNULL(d.CantidadCancelada, 0)-ISNULL(d.CantidadEmbarcada, 0)))AND d.Articulo<>EmpresaCfg2.CxcAnticipoArticuloServicio AND EmpresaCfg2.Empresa =@Empresa         
        IF @ModuloID IS NOT NULL
          SELECT @Ok = 20010, @OkRef = RTRIM(Mov)+' '+RTRIM(MovID) FROM Venta WHERE ID = @ModuloID
      END
    END
    /*IF @EstatusNuevo = 'CONCLUIDO'
    BEGIN
      IF @Cxp = 1
      BEGIN
        IF @CxpProveedor IS NULL SELECT @Ok = 40020 ELSE
        IF @CxpImporte + @CxpImpuestos = 0.0 SELECT @Ok = 40140
      END 
    END*/
    IF @Estatus = 'PENDIENTE' 
    BEGIN
      DECLARE crEstado CURSOR FOR
       SELECT RTRIM(UPPER(e.Tipo)), NULLIF(RTRIM(m.Cliente), ''), NULLIF(RTRIM(m.Proveedor), ''), ISNULL(d.Importe, 0.0)
         FROM EmbarqueD d
         JOIN EmbarqueMov m ON d.EmbarqueMov = m.ID 
         LEFT OUTER JOIN EmbarqueEstado e ON d.Estado = e.Estado
        WHERE d.ID = @ID

      OPEN crEstado
      FETCH NEXT FROM crEstado INTO @EstadoTipo, @Cliente, @Proveedor, @Importe
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          IF @EstadoTipo = 'PENDIENTE' AND @CfgDesembarquesParciales = 0 SELECT @Ok = 30340 ELSE
          IF @EstadoTipo IN (NULL, '') SELECT @Ok = 30340 ELSE
          IF @EstadoTipo = 'COBRADO' AND @Cliente IS NULL SELECT @Ok = 20180 ELSE
          IF @EstadoTipo = 'PAGADO' AND @Proveedor IS NULL SELECT @Ok = 20180 ELSE
          IF @EstadoTipo IN ('COBRADO', 'PAGADO') AND @Importe = 0.0 SELECT @Ok = 40140
        END
        FETCH NEXT FROM crEstado INTO @EstadoTipo, @Cliente, @Proveedor, @Importe
      END  -- While
      CLOSE crEstado
      DEALLOCATE crEstado
    END
  END
  RETURN
END
GO

/**************** spEmbarqueModificarVencimiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarqueModificarVencimiento') and type = 'P') drop procedure dbo.spEmbarqueModificarVencimiento
GO             
CREATE PROCEDURE spEmbarqueModificarVencimiento	
                   @FechaHora		datetime,
		   @Empresa		char(5),
    		   @ID       		int,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @Condicion		varchar(50), 
		   @Vencimiento		datetime,

		   @Ok			int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cliente		char(10),
    @CxID		int,
    @CxVencimiento	datetime,
    @Dias		int,
    @NuevaEmision	datetime,
    @NuevoVencimiento	datetime

  -- No hay cancelacion de Embarques
  SELECT @NuevoVencimiento = @Vencimiento, @NuevaEmision = @FechaHora
  EXEC spExtraerFecha @NuevaEmision OUTPUT
  SELECT @Cliente = Cliente FROM Venta WHERE ID = @ID
  EXEC spCalcularVencimiento 'CXC', @Empresa, @Cliente, @Condicion, @NuevaEmision, @NuevoVencimiento OUTPUT, @Dias OUTPUT, @Ok OUTPUT 
  SELECT @Dias = DATEDIFF(day, @Vencimiento, @NuevoVencimiento)

  IF @Dias > 0
  BEGIN
    UPDATE Venta 
       SET Vencimiento = DATEADD(day, @Dias, Vencimiento)
     WHERE ID = @ID

    SELECT @CxID = NULL
    SELECT @CxID = ID, @CxVencimiento = Vencimiento
      FROM Cxc 
     WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID 

    IF @CxID IS NOT NULL 
    BEGIN
      UPDATE Cxc 
         SET Vencimiento     = DATEADD(day, @Dias, Vencimiento),
             FechaProntoPago = DATEADD(day, @Dias, FechaProntoPago) 
       WHERE ID = @CxID

      DECLARE crDoc CURSOR FOR
       SELECT ID, Vencimiento 
         FROM Cxc c, MovTipo mt 
        WHERE mt.Modulo = 'CXC' AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.D', 'CXC.DM') AND c.Empresa = @Empresa AND c.OrigenTipo = 'CXC' AND c.Origen = @Mov AND c.OrigenID = @MovID
      OPEN crDoc
      FETCH NEXT FROM crDoc INTO @CxID, @CxVencimiento
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
          UPDATE Cxc 
             SET Vencimiento     = DATEADD(day, @Dias, Vencimiento),
                 FechaProntoPago = DATEADD(day, @Dias, FechaProntoPago) 
           WHERE CURRENT OF crDoc
 
        FETCH NEXT FROM crDoc INTO @CxID, @CxVencimiento
      END  -- While
      CLOSE crDoc
      DEALLOCATE crDoc
    END
  END
  RETURN
END
GO

/**************** spEmbarqueAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarqueAfectar') and type = 'P') drop procedure dbo.spEmbarqueAfectar
GO             
CREATE PROCEDURE spEmbarqueAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)  OUTPUT,
    		   @MovTipo     		char(20),
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
    		   @FechaConclusion		datetime,

    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
		   @Referencia			varchar(50),
		   @Concepto			varchar(50),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,
		   @FechaSalida			datetime,
		   @FechaRetorno		datetime,

		   @Vehiculo			char(10),
		   @PersonalCobrador		varchar(10),

		   @Conexion			bit,
		   @SincroFinal			bit,
                   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @AntecedenteID 		int,
		   @AntecedenteMovTipo		char(20),

		   @CtaDinero			char(10),
		   @CfgAfectarCobros		bit,
		   @CfgModificarVencimiento	bit,
		   @CfgEstadoTransito		varchar(50),
		   @CfgEstadoPendiente		varchar(50),
		   @CfgGastoTarifa		bit,
                   @CfgAfectarGastoTarifa	bit,
                   @CfgBaseProrrateo		varchar(20),
                   @CfgDesembarquesParciales	bit,

		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),		   
		   @GenerarPoliza		bit,

    		   @GenerarMov			char(20),
		   @IDGenerar			int	     OUTPUT,	
    		   @GenerarMovID	  	varchar(20)  OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Generar			bit,
    @GenerarAfectado		bit,
    @GenerarModulo		char(5),
    @GenerarMovTipo		char(20),
    @GenerarEstatus		char(15),
    @GenerarPeriodo 		int, 
    @GenerarEjercicio 		int,
    @EmbarqueMov		int, 
    @EmbarqueMovID		int, 
    @Estado			char(30),
    @EstadoTipo			char(20),
    @FechaHora			datetime,
    @Importe			money, 
    @Forma			varchar(50),
    @DetalleReferencia		varchar(50), 
    @DetalleObservaciones	varchar(100), 
    @MovModulo			char(5), 
    @MovModuloID		int, 
    @MovMov			char(20),
    @MovMovID			varchar(20),
    @MovMovTipo			char(20),
    @MovEstatus			char(15),
    @MovMoneda			char(10),
    @MovCondicion		varchar(50),
    @MovVencimiento		datetime,
    @MovImporte			money,
    @MovImpuestos		money,
    @MovTipoCambio		float,
    @MovPorcentaje		float,
    @Peso			float, 
    @AplicaImporte		money,
    @Volumen			float, 
    @Paquetes			int,
    @Cliente			char(10),
    @Proveedor			char(10),
    @ClienteProveedor		char(10),
    @ClienteEnviarA		int,
    @Agente			char(10),
    @SumaPeso			float,
    @SumaVolumen		float,
    @SumaPaquetes		int,
    @SumaImportePesos		money,
    @SumaImpuestosPesos		money,
    @SumaImporteEmbarque	money,
    @FechaCancelacion		datetime,
    @AntecedenteEstatus		char(15),
    @GenerarAccion		char(20),
    /*@CxpConcepto		varchar(50),*/
    @Dias			int,
    @CxModulo			char(5),
    @CxMov 			char(20),
    @CxMovID 			varchar(20),
    @CteModificarVencimiento	varchar(20),
    @EnviarAModificarVencimiento varchar(20),
    @ModificarVencimiento	bit,
    @GastoAnexoTotalPesos	money,
    @DiaRetorno			datetime,
    @TienePendientes		bit
    
  -- Inicializar Variables
  SELECT @Generar 		= 0,
         @GenerarAfectado	= 0,        
         @IDGenerar		= NULL,
         @GenerarModulo		= NULL,
         @GenerarMovID	        = NULL,
         @GenerarMovTipo        = NULL,
         @GenerarEstatus 	= 'SINAFECTAR',
         @TienePendientes       = 0,
         @GastoAnexoTotalPesos  = NULL

  IF @CfgDesembarquesParciales = 1 AND @MovTipo IN ('EMB.E', 'EMB.OC') AND @EstatusNuevo = 'CONCLUIDO'
  BEGIN
    IF EXISTS(SELECT * FROM EmbarqueD d, EmbarqueMov m, EmbarqueEstado e WHERE d.EmbarqueMov=m.ID AND d.ID = @ID AND d.Estado=e.Estado AND UPPER(e.Tipo)='PENDIENTE' AND d.DesembarqueParcial = 0)
      SELECT @TienePendientes = 1, @EstatusNuevo = 'PENDIENTE'
  END

  -- Asignar el Consecutivo al Movimiento
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
  BEGIN
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END

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
--      EXEC spEmbarqueCopiarDetalle @ID, @IDGenerar, @GenerarMovTipo, @Ok OUTPUT
 
    IF @Ok IS NULL SELECT @Ok = 80030
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Actualizar Sucursal Detalle
    IF @Accion = 'AFECTAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
      IF (SELECT Sincro FROM Version) = 1
        EXEC sp_executesql N'UPDATE EmbarqueD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, NULL, NULL,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    SELECT @SumaPeso 	       = 0.0, 
	   @SumaVolumen        = 0.0, 
	   @SumaPaquetes       = 0.0,
    	   @SumaImportePesos   = 0.0,
    	   @SumaImpuestosPesos = 0.0,
           @SumaImporteEmbarque= 0.0

    DECLARE crEmbarque CURSOR FOR
     SELECT NULLIF(d.EmbarqueMov, 0), d.Estado, d.FechaHora, NULLIF(RTRIM(d.Forma), ''), ISNULL(d.Importe, 0.0), NULLIF(RTRIM(d.Referencia), ''), NULLIF(RTRIM(d.Observaciones), ''),
  	    m.ID, m.Modulo, m.ModuloID, m.Mov, m.MovID, m.Importe, m.Impuestos, m.Moneda, m.TipoCambio, ISNULL(m.Peso, 0.0), ISNULL(m.Volumen, 0.0), ISNULL(d.Paquetes, 0), 
            NULLIF(RTRIM(m.Cliente), ''), NULLIF(RTRIM(m.Proveedor), ''), m.ClienteEnviarA, UPPER(e.Tipo), ISNULL(d.MovPorcentaje, 0)
       FROM EmbarqueD d
       JOIN EmbarqueMov m ON d.EmbarqueMov = m.ID 
       LEFT OUTER JOIN EmbarqueEstado e ON d.Estado = e.Estado 
      WHERE d.ID = @ID AND d.DesembarqueParcial = 0

    OPEN crEmbarque
    FETCH NEXT FROM crEmbarque INTO @EmbarqueMov, @Estado, @FechaHora, @Forma, @Importe, @DetalleReferencia, @DetalleObservaciones, @EmbarqueMovID, @MovModulo, @MovModuloID, @MovMov, @MovMovID, @MovImporte, @MovImpuestos, @MovMoneda, @MovTipoCambio, @Peso, @Volumen, @Paquetes, @Cliente, @Proveedor, @ClienteEnviarA, @EstadoTipo, @MovPorcentaje
    IF @@ERROR <> 0 SELECT @Ok = 1
    IF @@FETCH_STATUS = -1 SELECT @Ok = 60010
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @Accion = 'AFECTAR' AND @MovTipo = 'EMB.OC' AND @MovModulo = 'CXC' AND @EstadoTipo = 'COBRADO'
        IF @Importe < ISNULL((SELECT ISNULL(Saldo, 0.0)+ISNULL(SaldoInteresesOrdinarios, 0.0)+ISNULL(SaldoInteresesMoratorios, 0.0) FROM Cxc WHERE ID = @MovModuloID), 0)
          SELECT @EstadoTipo = 'COBRO PARCIAL'

      IF @@FETCH_STATUS <> -2 AND @EmbarqueMov IS NOT NULL AND @Ok IS NULL 
      BEGIN
        IF @MovTipo IN ('EMB.E', 'EMB.OC')
        BEGIN
          IF @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR'  
          BEGIN
            IF @MovTipo = 'EMB.OC' AND @MovModulo = 'CXC'
              UPDATE Cxc SET PersonalCobrador = @PersonalCobrador WHERE ID = @MovModuloID AND ISNULL(PersonalCobrador, '') <> @PersonalCobrador

            UPDATE EmbarqueD SET Estado = @CfgEstadoTransito WHERE CURRENT OF crEmbarque
            UPDATE EmbarqueMov SET MovPorcentaje = ISNULL(MovPorcentaje, 0) + @MovPorcentaje WHERE ID = @EmbarqueMovID
          END
          IF @Accion = 'CANCELAR'
          BEGIN
            UPDATE EmbarqueD SET Estado = @CfgEstadoPendiente WHERE CURRENT OF crEmbarque
            UPDATE EmbarqueMov SET MovPorcentaje = ISNULL(MovPorcentaje, 0) - @MovPorcentaje WHERE ID = @EmbarqueMovID
          END

          -- Embarque Parcial
          IF @MovModulo IN ('VTAS', 'COMS') AND @MovTipo = 'EMB.E' AND ((@Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR') OR (@Accion = 'CANCELAR' AND (@Estatus = 'PENDIENTE' OR @EstadoTipo <> 'DESEMBARCAR')) OR (@EstadoTipo = 'DESEMBARCAR' AND @Accion = 'AFECTAR'))
          BEGIN
            IF @MovModulo = 'VTAS'
            BEGIN
              UPDATE VentaD 
                 SET CantidadEmbarcada = CASE WHEN @Accion = 'CANCELAR' OR @EstadoTipo = 'DESEMBARCAR' THEN ISNULL(d.CantidadEmbarcada, 0) - ISNULL(e.Cantidad, 0) ELSE ISNULL(d.CantidadEmbarcada, 0) + ISNULL(e.Cantidad , 0) END
                FROM EmbarqueDArt e, VentaD d
               WHERE e.ID = @ID AND e.EmbarqueMov = @EmbarqueMov AND e.Modulo = @MovModulo AND e.ModuloID = d.ID AND e.Renglon = d.Renglon AND e.RenglonSub = d.RenglonSub

              IF EXISTS(SELECT * FROM EmbarqueDArt e, VentaD d WHERE e.ID = @ID AND e.EmbarqueMov = @EmbarqueMov AND e.Modulo = @MovModulo AND e.ModuloID = d.ID AND d.CantidadEmbarcada <> d.Cantidad-ISNULL(d.CantidadCancelada, 0))
                UPDATE EmbarqueMov SET AsignadoID = NULL WHERE ID = @EmbarqueMov
            END
            ELSE
            IF @MovModulo = 'COMS'
            BEGIN
              UPDATE CompraD 
                 SET CantidadEmbarcada = CASE WHEN @Accion = 'CANCELAR' OR @EstadoTipo = 'DESEMBARCAR' THEN ISNULL(d.CantidadEmbarcada, 0) - ISNULL(e.Cantidad, 0) ELSE ISNULL(d.CantidadEmbarcada, 0) + ISNULL(e.Cantidad , 0) END
                FROM EmbarqueDArt e, CompraD d
               WHERE e.ID = @ID AND e.EmbarqueMov = @EmbarqueMov AND e.Modulo = @MovModulo AND e.ModuloID = d.ID AND e.Renglon = d.Renglon AND e.RenglonSub = d.RenglonSub

              IF EXISTS(SELECT * FROM EmbarqueDArt e, CompraD d WHERE e.ID = @ID AND e.EmbarqueMov = @EmbarqueMov AND e.Modulo = @MovModulo AND e.ModuloID = d.ID AND d.CantidadEmbarcada <> d.Cantidad-ISNULL(d.CantidadCancelada, 0))
                UPDATE EmbarqueMov SET AsignadoID = NULL WHERE ID = @EmbarqueMov
            END
          END

          IF (@Accion = 'AFECTAR' AND @Estatus = 'PENDIENTE') OR (@Accion = 'CANCELAR' AND @Estatus = 'CONCLUIDO')
          BEGIN
            SELECT @GenerarAccion = @Accion
            SELECT @MovMovTipo = NULL, @MovEstatus = NULL, @Agente = NULL
            SELECT @MovMovTipo = Clave FROM MovTipo WHERE Modulo = @MovModulo AND Mov = @MovMov
            IF @MovModulo = 'VTAS' 
            BEGIN
	          SELECT @MovEstatus = Estatus, @Agente = Agente, @MovCondicion = Condicion, @MovVencimiento = Vencimiento FROM Venta WHERE ID = @MovModuloID 
              IF @EstadoTipo IN ('ENTREGADO', 'COBRADO') AND @FechaHora IS NOT NULL AND @Accion <> 'CANCELAR' AND @Ok IS NULL
              BEGIN
                SELECT @ModificarVencimiento = @CfgModificarVencimiento 
                SELECT @CteModificarVencimiento = ISNULL(UPPER(ModificarVencimiento), '(EMPRESA)') 
                  FROM Cte 
                 WHERE Cliente = @Cliente
                
                IF @CteModificarVencimiento = 'SI' SELECT @ModificarVencimiento = 1 ELSE 
		        IF @CteModificarVencimiento = 'NO' SELECT @ModificarVencimiento = 0

                IF NULLIF(@ClienteEnviarA, 0) IS NOT NULL
                BEGIN
                  SELECT @EnviarAModificarVencimiento = RTRIM(UPPER(ModificarVencimiento))
                    FROM CteEnviarA
                   WHERE Cliente = @Cliente AND ID = @ClienteEnviarA
                  IF @EnviarAModificarVencimiento = 'SI' SELECT @ModificarVencimiento = 1 ELSE 
   	 	          IF @EnviarAModificarVencimiento = 'NO' SELECT @ModificarVencimiento = 0
                END

                IF @ModificarVencimiento = 1 
  	          EXEC spEmbarqueModificarVencimiento @FechaHora, @Empresa, @MovModuloID, @MovMov, @MovMovID, @MovCondicion, @MovVencimiento, @Ok OUTPUT
              END
            END ELSE
            IF @MovModulo = 'INV'  SELECT @MovEstatus = Estatus FROM Inv    WHERE ID = @MovModuloID ELSE
            IF @MovModulo = 'COMS' SELECT @MovEstatus = Estatus FROM Compra WHERE ID = @MovModuloID ELSE
            IF @MovModulo = 'CXC'  SELECT @MovEstatus = Estatus FROM Cxc    WHERE ID = @MovModuloID ELSE
            IF @MovModulo = 'DIN'  SELECT @MovEstatus = Estatus FROM Dinero WHERE ID = @MovModuloID

	        IF ((@Accion <> 'CANCELAR' AND (@EstadoTipo = 'DESEMBARCAR')) OR (@EstadoTipo = 'COBRO PARCIAL' AND @MovTipo = 'EMB.OC')) OR (@Accion = 'CANCELAR' AND @Estatus = 'CONCLUIDO' AND @EstadoTipo <> 'DESEMBARCAR')
	    /*IF (@EstadoTipo = 'DESEMBARCAR') OR (@EstadoTipo = 'COBRO PARCIAL' AND @MovTipo = 'EMB.OC') OR (@Accion = 'CANCELAR' AND @Estatus = 'CONCLUIDO')*/
            BEGIN
              UPDATE EmbarqueMov SET AsignadoID = NULL WHERE ID = @EmbarqueMov
            END 

            IF @EstadoTipo = 'ENTREGADO' 
            BEGIN
	        IF @MovMovTipo IN ('DIN.CH', 'DIN.CHE') AND @MovEstatus = 'PENDIENTE'
              EXEC spDinero @MovModuloID, @MovModulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                            @GenerarMov, @GenerarMovID, @IDGenerar, 
                            @Ok OUTPUT, @OkRef OUTPUT
            END

            IF @EstadoTipo IN ('COBRADO', 'COBRO PARCIAL', 'PAGADO')
            BEGIN
              SELECT @ClienteProveedor = NULL
              IF @EstadoTipo IN ('COBRADO', 'COBRO PARCIAL') 
              BEGIN
                SELECT @ClienteProveedor = @Cliente 
                IF @CfgAfectarCobros = 0 AND @Accion <> 'CANCELAR' SELECT @GenerarAccion = 'GENERAR'
              END ELSE
              IF @EstadoTipo = 'PAGADO' SELECT @ClienteProveedor = @Proveedor

	          IF @ClienteProveedor IS NOT NULL 
              BEGIN
                IF @Importe > (ISNULL(@MovImporte, 0.0) + ISNULL(@MovImpuestos, 0.0)) AND (SELECT EmbarqueSugerirCobros FROM EmpresaCfg WHERE Empresa = @Empresa) = 0 
                  SELECT @AplicaImporte = ISNULL(@MovImporte, 0.0) + ISNULL(@MovImpuestos, 0.0) 
                ELSE
                  SELECT @AplicaImporte = @Importe

                EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @GenerarAccion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, NULL, @MovMoneda, @MovTipoCambio,
                                 @FechaEmision, NULL, @Proyecto, @Usuario, NULL,
 	         	         @DetalleReferencia, NULL, NULL, @FechaRegistro, @Ejercicio, @Periodo,
		                 NULL, NULL, @ClienteProveedor, @ClienteEnviarA, @Agente, @Estado, @CtaDinero, @Forma,
		                 @Importe, NULL, NULL, NULL, 
                                 NULL, @MovMov, @MovMovID, @AplicaImporte, NULL, NULL,
      			         @GenerarModulo, @GenerarMov, @GenerarMovID,
	   	                 @Ok OUTPUT, @OkRef OUTPUT, @PersonalCobrador = @PersonalCobrador
              END
            END
            IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL

            IF @EstadoTipo IN ('ENTREGADO', 'COBRADO') AND @Accion <> 'CANCELAR'
            BEGIN
              IF @MovModulo = 'VTAS' UPDATE Venta  SET FechaEntrega = @FechaHora WHERE ID = @MovModuloID ELSE
              IF @MovModulo = 'COMS' UPDATE Compra SET FechaEntrega = @FechaHora WHERE ID = @MovModuloID ELSE
              IF @MovModulo = 'INV'  UPDATE Inv    SET FechaEntrega = @FechaHora WHERE ID = @MovModuloID ELSE
              IF @MovModulo = 'CXC'  UPDATE Cxc    SET FechaEntrega = @FechaHora WHERE ID = @MovModuloID ELSE
              IF @MovModulo = 'DIN'  UPDATE Dinero SET FechaEntrega = @FechaHora WHERE ID = @MovModuloID 
            END
          END ELSE 
          BEGIN
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @MovModulo, @MovModuloID, @MovMov, @MovMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
  
            IF @Accion = 'CANCELAR'
              UPDATE EmbarqueMov SET AsignadoID = @AntecedenteID WHERE ID = @EmbarqueMov           
          END
        END

        IF @TienePendientes = 1 AND @EstadoTipo NOT IN ('PENDIENTE', NULL, '')
          UPDATE EmbarqueD 
             SET DesembarqueParcial = 1 
           WHERE CURRENT OF crEmbarque

        SELECT @SumaPeso           = @SumaPeso           + @Peso, 
	       @SumaVolumen        = @SumaVolumen        + @Volumen, 
	       @SumaPaquetes       = @SumaPaquetes       + @Paquetes,
               @SumaImportePesos   = @SumaImportePesos   + (@MovImporte * @MovTipoCambio),
               @SumaImpuestosPesos = @SumaImpuestosPesos + (@MovImpuestos * @MovTipoCambio),
               @SumaImporteEmbarque= @SumaImporteEmbarque+ (((ISNULL(@MovImporte, 0)+ISNULL(@MovImpuestos, 0))*@MovTipoCambio))*(@MovPorcentaje/100)
      END
      FETCH NEXT FROM crEmbarque INTO @EmbarqueMov, @Estado, @FechaHora, @Forma, @Importe, @DetalleReferencia, @DetalleObservaciones, @EmbarqueMovID, @MovModulo, @MovModuloID, @MovMov, @MovMovID, @MovImporte, @MovImpuestos, @MovMoneda, @MovTipoCambio, @Peso, @Volumen, @Paquetes, @Cliente, @Proveedor, @ClienteEnviarA, @EstadoTipo, @MovPorcentaje
      IF @@ERROR <> 0 SELECT @Ok = 1
    END  -- While
    CLOSE crEmbarque
    DEALLOCATE crEmbarque

    -- Gastos Embarque (Tarifas)
    IF @CfgGastoTarifa = 1 AND @EstatusNuevo = 'CONCLUIDO' AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    BEGIN
      EXEC spGastoAnexoTarifa @Sucursal, @Empresa, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Usuario, @CfgAfectarGastoTarifa, @Ok OUTPUT, @OkRef OUTPUT
    END

    -- Afectar Gastos Anexos
    IF (@EstatusNuevo = 'CONCLUIDO' OR @Accion = 'CANCELAR') AND @Ok IS NULL
    BEGIN
      EXEC spGastoAnexo @Empresa, @Modulo, @ID, @Accion, @FechaRegistro, @Usuario, @GastoAnexoTotalPesos OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      EXEC spGastoAnexoEliminar @Empresa, @Modulo, @ID
    END

    -- Actualizar Movimiento
    IF @Ok IS NULL 
    BEGIN
      IF @TienePendientes = 1
        UPDATE Embarque 
           SET Estatus = @EstatusNuevo, 
               UltimoCambio = @FechaRegistro
         WHERE ID = @ID 
      ELSE BEGIN
        IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
        IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaRegistro ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
        IF @EstatusNuevo = 'CONCLUIDO' AND @FechaRetorno IS NULL SELECT @FechaRetorno = @FechaRegistro
        SELECT @DiaRetorno = @FechaRetorno
        EXEC spExtraerFecha @DiaRetorno OUTPUT

        IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
        BEGIN
	  IF @Estatus =  'SINAFECTAR' AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
          IF @Estatus <> 'SINAFECTAR' AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
        END  

        EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Embarque
           SET Peso	      = NULLIF(@SumaPeso, 0.0),
	       Volumen	      = NULLIF(@SumaVolumen, 0.0),
	       Paquetes	      = NULLIF(@SumaPaquetes, 0.0),
               Importe	      = NULLIF(@SumaImportePesos, 0.0),
               Impuestos        = NULLIF(@SumaImpuestosPesos, 0.0),
               ImporteEmbarque  = NULLIF(@SumaImporteEmbarque, 0.0),
               Gastos           = NULLIF(@GastoAnexoTotalPesos, 0.0),
               FechaSalida      = @FechaSalida,
               FechaRetorno     = @FechaRetorno,
               DiaRetorno	      = @DiaRetorno,
               FechaConclusion  = @FechaConclusion,               
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
               Estatus          = @EstatusNuevo,
	     --Vencimiento      = @CxpVencimiento,
               Situacion 	      = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza
         WHERE ID = @ID 
         IF @@ERROR <> 0 SELECT @Ok = 1
      END

        -- Afectar Gastos
      IF @EstatusNuevo = 'CONCLUIDO'
      BEGIN
        UPDATE EmbarqueD SET DesembarqueParcial = 0 WHERE ID = @ID AND DesembarqueParcial = 1

        UPDATE EmbarqueMov
           SET Gastos = ISNULL(Gastos, 0) + (((e.Importe+e.Impuestos)*e.TipoCambio) * @GastoAnexoTotalPesos) / (@SumaImportePesos + @SumaImpuestosPesos)
          FROM EmbarqueMov e, EmbarqueD d
         WHERE d.ID = @ID AND d.EmbarqueMov = e.ID

        UPDATE EmbarqueMov
           SET Concluido = 1
         WHERE AsignadoID = @ID

        IF @CfgBaseProrrateo = 'IMPORTE'
          UPDATE Venta
             SET EmbarqueGastos = ISNULL(EmbarqueGastos, 0) + (((e.Importe+e.Impuestos)*e.TipoCambio) * @GastoAnexoTotalPesos) / (@SumaImportePesos + @SumaImpuestosPesos)
            FROM EmbarqueMov e, EmbarqueD d, Venta v
           WHERE d.ID = @ID AND d.EmbarqueMov = e.ID AND e.Modulo = 'VTAS' AND e.ModuloID = v.ID
        ELSE 
        IF @CfgBaseProrrateo = 'PAQUETES'
          UPDATE Venta
             SET EmbarqueGastos = ISNULL(EmbarqueGastos, 0) + (e.Paquetes * @GastoAnexoTotalPesos) / @SumaPaquetes
            FROM EmbarqueMov e, EmbarqueD d, Venta v
           WHERE d.ID = @ID AND d.EmbarqueMov = e.ID AND e.Modulo = 'VTAS' AND e.ModuloID = v.ID
        ELSE 
        IF @CfgBaseProrrateo = 'PESO'
          UPDATE Venta
             SET EmbarqueGastos = ISNULL(EmbarqueGastos, 0) + (e.Peso * @GastoAnexoTotalPesos) / @SumaPeso
            FROM EmbarqueMov e, EmbarqueD d, Venta v
           WHERE d.ID = @ID AND d.EmbarqueMov = e.ID AND e.Modulo = 'VTAS' AND e.ModuloID = v.ID
        ELSE 
        IF @CfgBaseProrrateo = 'VOLUMEN'
          UPDATE Venta
             SET EmbarqueGastos = ISNULL(EmbarqueGastos, 0) + (e.Volumen * @GastoAnexoTotalPesos) / @SumaVolumen
            FROM EmbarqueMov e, EmbarqueD d, Venta v
           WHERE d.ID = @ID AND d.EmbarqueMov = e.ID AND e.Modulo = 'VTAS' AND e.ModuloID = v.ID
        ELSE 
        IF @CfgBaseProrrateo = 'PESO/VOLUMEN'
          UPDATE Venta
             SET EmbarqueGastos = ISNULL(EmbarqueGastos, 0) + (((ISNULL(e.Peso, 0)*ISNULL(e.Volumen, 0))*e.TipoCambio) * @GastoAnexoTotalPesos) / (@SumaPeso * @SumaVolumen)
            FROM EmbarqueMov e, EmbarqueD d, Venta v
           WHERE d.ID = @ID AND d.EmbarqueMov = e.ID AND e.Modulo = 'VTAS' AND e.ModuloID = v.ID
      END

      UPDATE Vehiculo 
         SET Estatus = CASE WHEN @EstatusNuevo = 'PENDIENTE' THEN 'ENTRANSITO' ELSE 'DISPONIBLE' END
       WHERE Vehiculo = @Vehiculo
      IF @@ERROR <> 0 SELECT @Ok = 1
    END
 
    -- Afectar Cxp
    /*IF @Cxp = 1 AND @EstatusNuevo = 'CONCLUIDO' AND @Ok IS NULL
    BEGIN
      SELECT @CxpConcepto = Concepto FROM Vehiculo WHERE Vehiculo = @Vehiculo
      EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @CxpMoneda, @CxpTipoCambio, 
                       @FechaEmision, @CxpConcepto, @Proyecto, @Usuario, @Autorizacion, @CxpReferencia, @DocFuente, @Observaciones,
  		       @FechaRegistro, @Ejercicio, @Periodo,
		       @CxpCondicion, @CxpVencimiento, @CxpProveedor, NULL, NULL, 'CXP', NULL, NULL,
                       @CxpImporte, @CxpImpuestos, NULL, NULL,
                       NULL, NULL, NULL, NULL, NULL, NULL,
		       @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                       @Ok OUTPUT, @OkRef OUTPUT
    END*/


    IF @Vehiculo IS NOT NULL
    BEGIN
      IF (SELECT TieneMovimientos FROM Vehiculo WHERE Vehiculo = @Vehiculo) = 0
        UPDATE Vehiculo SET TieneMovimientos = 1 WHERE Vehiculo = @Vehiculo
    END

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
        ROLLBACK TRANSACTION
    
  RETURN
END
GO

/**************** spEmbarque ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarque') and type = 'P') drop procedure dbo.spEmbarque
GO
CREATE PROCEDURE spEmbarque
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
    @FechaAfectacion		datetime,
    @FechaConclusion		datetime,
    @FechaSalida		datetime,
    @FechaRetorno		datetime,
    @Proyecto	      		varchar(50),
    @MovUsuario	      		char(10),
    @Autorizacion     		char(10),
    @DocFuente	      		int,
    @Observaciones    		varchar(255),
    @Concepto			varchar(50),
    @Referencia			varchar(50),
    @Estatus          		char(15),
    @EstatusNuevo		char(15),
    @Ejercicio	      		int,
    @Periodo	      		int,
    @GenerarMovID		varchar(20),
    @GenerarPoliza		bit,
    @CfgContX			bit,
    @CfgContXGenerar		char(20),
    @CfgAfectarCobros		bit,
    @CfgModificarVencimiento	bit,
    @CfgEstadoTransito		varchar(50),
    @CfgEstadoPendiente		varchar(50),
    @CfgGastoTarifa		bit,
    @CfgAfectarGastoTarifa	bit,
    @CfgBaseProrrateo		varchar(20),
    @CfgDesembarquesParciales	bit, 
    @CtaDinero			char(10),
    @AntecedenteID		int,
    @AntecedenteMovTipo		char(20),
    @Vehiculo		        char(10),
    @PersonalCobrador		varchar(10)/*,
    @Verificar			bit*/
    /*@Cxp 			bit, 
    @CxpProveedor 		char(10), 
    @CxpImporte 		money, 
    @CxpImpuestos 		money, 
    @CxpCondicion 		varchar(50), 
    @CxpVencimiento 		datetime,
    @CxpReferencia		varchar(50), 
    @CxpMoneda			char(10),
    @CxpTipoCambio		float*/

  -- Inicializar Variables
  SELECT @CfgContX                = 0,
         @CfgContXGenerar  	  = 'NO',
         @CfgAfectarCobros 	  = 0,
         @CfgModificarVencimiento = 0/*,
         @Verificar		  = 1*/

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = Proyecto,
         @MovUsuario = Usuario, @Concepto = NULLIF(RTRIM(Concepto), ''), @Autorizacion = Autorizacion, @FechaSalida = FechaSalida, @FechaRetorno = FechaRetorno,
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @Vehiculo = NULLIF(RTRIM(Vehiculo), ''), @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion,
         @CtaDinero = NULLIF(RTRIM(CtaDinero), ''), @Referencia = Referencia, @PersonalCobrador = NULLIF(RTRIM(PersonalCobrador), '')/*,
         @CxpProveedor = NULLIF(RTRIM(Proveedor), ''), @CxpImporte = ISNULL(Importe, 0.0), @CxpImpuestos = ISNULL(Impuestos, 0.0), @CxpReferencia = CxpReferencia,
         @CxpCondicion = Condicion, @CxpVencimiento = Vencimiento, @CxpMoneda = Moneda, @CxpTipoCambio = TipoCambio*/
    FROM Embarque
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  /*IF @Vehiculo IS NOT NULL
   SELECT @Cxp = Cxp FROM Vehiculo WHERE Vehiculo = @Vehiculo*/


  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, @Estatus, @Concepto, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
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
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE'))
  BEGIN

    IF @FechaSalida IS NULL SELECT @FechaSalida = @FechaEmision

    SELECT @CfgAfectarCobros        = EmbarqueAfectarCobros,
           @CfgModificarVencimiento = EmbarqueModificarVencimiento,
           @CfgEstadoTransito       = EmbarqueEstadoTransito,
           @CfgEstadoPendiente      = EmbarqueEstadoPendiente,
           @CfgGastoTarifa	    = EmbarqueGenerarGastoTarifas,
           @CfgAfectarGastoTarifa   = EmbarqueAfectarGastoTarifas,
           @CfgBaseProrrateo	    = UPPER(EmbarqueBaseProrrateo),
           @CfgDesembarquesParciales = EmbarqueDesembarquesParciales
      FROM EmpresaCfg
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

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
  
    IF @MovTipo IN ('EMB.E', 'EMB.OC')
    BEGIN
      IF @Estatus = 'SINAFECTAR' AND @Accion <> 'CANCELAR' SELECT @EstatusNuevo = 'PENDIENTE'
      IF @Estatus = 'PENDIENTE'  AND @Accion <> 'CANCELAR' SELECT @EstatusNuevo = 'CONCLUIDO'
    END

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
    BEGIN
      EXEC spEmbarqueVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @Estatus, @EstatusNuevo, 
			       @Vehiculo, @PersonalCobrador, @Conexion, @SincroFinal, @Sucursal, 
                               @CfgDesembarquesParciales,  
                               @AntecedenteID OUTPUT, @AntecedenteMovTipo OUTPUT, 
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
      EXEC spEmbarqueAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			     @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Referencia, @Concepto,
                             @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @FechaSalida, @FechaRetorno,
                             @Vehiculo, @PersonalCobrador, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
			     @AntecedenteID, @AntecedenteMovTipo,
                             @CtaDinero, @CfgAfectarCobros, @CfgModificarVencimiento, @CfgEstadoTransito, @CfgEstadoPendiente, @CfgGastoTarifa, @CfgAfectarGastoTarifa, @CfgBaseProrrateo, @CfgDesembarquesParciales,
			     @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                             @GenerarMov, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                             @Ok OUTPUT, @OkRef OUTPUT

  END ELSE 
  BEGIN
    IF @Estatus = 'SINAFECTAR' AND @Accion = 'CANCELAR'
    BEGIN
      EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT 
      EXEC spGastoAnexoEliminar @Empresa, @Modulo, @ID
      UPDATE EmbarqueMov SET AsignadoID = NULL WHERE AsignadoID = @ID
    END ELSE
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

-- spafectar 'EMB', 1, 'CANCELAR'


-- select * from EmbarqueAsistenteCobro
/**************** spEmbarqueAsistenteCobroAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarqueAsistenteCobroAceptar') and type = 'P') drop procedure dbo.spEmbarqueAsistenteCobroAceptar
GO             
CREATE PROCEDURE spEmbarqueAsistenteCobroAceptar
		    @ID			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok		int,
    @OkRef	varchar(255),
    @Orden	int,
    @Mov	char(20), 
    @MovID	varchar(20),
    @FechaHora	datetime,
    @Estado	varchar(50),
    @Causa	varchar(50),
    @Importe	money, 
    @Forma	varchar(50),
    @Persona	varchar(50),
    @PersonaID	varchar(50),
    @Referencia	varchar(50)

  SELECT @Ok = NULL, @OkRef = NULL
  DECLARE crLista CURSOR FOR
   SELECT Mov, MovID, Estado, Importe, Forma, Causa, FechaHora, Persona, PersonaID, Referencia
     FROM EmbarqueAsistenteCobro
    WHERE ID = @ID
  OPEN crLista
  FETCH NEXT FROM crLista INTO @Mov, @MovID, @Estado, @Importe, @Forma, @Causa, @FechaHora, @Persona, @PersonaID, @Referencia
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @Orden = NULL
      SELECT @Orden = Orden FROM EmbarqueD d, EmbarqueMov m WHERE d.EmbarqueMov = m.ID AND d.ID = @ID AND m.Mov = @Mov AND m.MovID = @MovID
      IF @Orden IS NOT NULL 
        UPDATE EmbarqueD 
           SET FechaHora = @FechaHora, Estado = @Estado, Importe = @Importe, Forma = @Forma, Causa = @Causa, Persona = @Persona, PersonaID = @PersonaID, Referencia = @Referencia
         WHERE ID = @ID AND Orden = @Orden
      ELSE 
        SELECT @Ok = 30210, @OkRef = RTRIM(@Mov)+' '+RTRIM(@MovID)
    END
    FETCH NEXT FROM crLista INTO @Mov, @MovID, @Estado, @Importe, @Forma, @Causa, @FechaHora, @Persona, @PersonaID, @Referencia
  END -- While
  CLOSE crLista
  DEALLOCATE crLista

  IF @Ok IS NOT NULL
    SELECT Descripcion + ' - '+RTRIM(@OkRef) 
      FROM MensajeLista
     WHERE Mensaje = @Ok  
  ELSE
    SELECT NULL
END
GO



-- select * from EmbarqueAsistenteGeneral
/**************** spEmbarqueAsistenteGeneralAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmbarqueAsistenteGeneralAceptar') and type = 'P') drop procedure dbo.spEmbarqueAsistenteGeneralAceptar
GO             
CREATE PROCEDURE spEmbarqueAsistenteGeneralAceptar
			@Empresa	char(5),
		    	@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int,
    @Ok		int,
    @OkRef	varchar(255),
    @Orden	int,
    @Mov	char(20), 
    @MovID	varchar(20),
    @FechaHora	datetime,
    @Estado	varchar(50),
    @Causa	varchar(50),
    @Importe	money, 
    @Forma	varchar(50),
    @Persona	varchar(50),
    @PersonaID	varchar(50),
    @Referencia	varchar(50)

  SELECT @Ok = NULL, @OkRef = NULL
  DECLARE crLista CURSOR FOR
   SELECT Mov, MovID, Estado, Importe, Forma, Causa, FechaHora, Persona, PersonaID, Referencia
     FROM EmbarqueAsistenteGeneral
    WHERE Empresa = @Empresa AND Estacion = @Estacion
  OPEN crLista
  FETCH NEXT FROM crLista INTO @Mov, @MovID, @Estado, @Importe, @Forma, @Causa, @FechaHora, @Persona, @PersonaID, @Referencia
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @ID = NULL, @Orden = NULL
      SELECT @ID = d.ID, @Orden = d.Orden FROM Embarque e, EmbarqueD d, EmbarqueMov m WHERE e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' AND d.EmbarqueMov = m.ID AND d.ID = e.ID AND m.Mov = @Mov AND m.MovID = @MovID
      IF @Orden IS NOT NULL 
      BEGIN
        UPDATE EmbarqueD 
           SET FechaHora = @FechaHora, Estado = @Estado, Importe = @Importe, Forma = @Forma, Causa = @Causa, Persona = @Persona, PersonaID = @PersonaID, Referencia = @Referencia
         WHERE ID = @ID AND Orden = @Orden
        DELETE EmbarqueAsistenteGeneral WHERE CURRENT OF crLista
      END ELSE 
        SELECT @Ok = 30210, @OkRef = RTRIM(@Mov)+' '+RTRIM(@MovID)
    END
    FETCH NEXT FROM crLista INTO @Mov, @MovID, @Estado, @Importe, @Forma, @Causa, @FechaHora, @Persona, @PersonaID, @Referencia
  END -- While
  CLOSE crLista
  DEALLOCATE crLista

  IF @Ok IS NOT NULL
    SELECT Descripcion + ' - '+RTRIM(@OkRef) 
      FROM MensajeLista
     WHERE Mensaje = @Ok  
  ELSE
    SELECT NULL
END
GO

PRINT "******************* SP EMBARQUES ******************"
