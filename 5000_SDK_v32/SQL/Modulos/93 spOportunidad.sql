SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO


--REQ16092
/**************** spOportunidadunidadDInsertar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadunidadDInsertar') and type = 'P') drop procedure dbo.spOportunidadunidadDInsertar
GO
CREATE PROC spOportunidadunidadDInsertar 
			@ID			int, 
			@Plantilla	varchar(50),
			@Usuario	varchar(10),
			@Ok			int			 = NULL OUTPUT,
			@OkRef		varchar(255) = NULL OUTPUT					
--//WITH ENCRYPTION
AS
BEGIN
  INSERT INTO OportunidadD(
			ID,   Renglon,   RenglonSub,   RenglonID,   Tipo,   RenglonTipo,   Clave, Recurso,                                                      Estado)
    SELECT @ID, d.Renglon, d.RenglonSub, d.RenglonID, d.Tipo, d.RenglonTipo, d.Clave, CASE Tipo WHEN 'Actividad' THEN d.RecursoOmision ELSE '' END, CASE Tipo WHEN 'Actividad' THEN 'No Comenzada' ELSE '' END
      FROM OportunidadPlantillaD d
      JOIN OportunidadPlantilla c ON c.ID = d.ID
     WHERE Plantilla = @Plantilla

  UPDATE OportunidadPlantilla SET TieneMovimientos = 1  WHERE Plantilla = @Plantilla

  EXEC xpOportunidadunidadDInsertar @ID, @Plantilla, @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT					
  
  RETURN
END
GO

--REQ16092
/**************** spOportunidadPropuestaAgregar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadPropuestaAgregar') and type = 'P') drop procedure dbo.spOportunidadPropuestaAgregar
GO
CREATE PROC spOportunidadPropuestaAgregar 
			@ID			int, 
			@Usuario	varchar(10),
			@Sucursal	int,
			@Plantilla	varchar(20),
			@Ok			int			 = NULL OUTPUT,
			@OkRef		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION					
AS
BEGIN
  DECLARE @Mov					varchar(20),
		  @FechaEmision			datetime,
		  @Almacen				varchar(10),
		  @IDVTAS				int,
		  @OkDesc				varchar(255),
		  @OkTipo				varchar(50),
		  @TipoImpuesto			bit
 
  SELECT @FechaEmision = GETDATE()
  
  EXEC spExtraerFecha @FechaEmision OUTPUT
 
  SELECT @Mov = MovOportunidad FROM OportunidadPlantilla WHERE Plantilla = @Plantilla
  
  SELECT @Almacen = DefAlmacen FROM Usuario WHERE Usuario = @Usuario
 
  SELECT @TipoImpuesto = ISNULL(TipoImpuesto, 0) FROM EmpresaGral JOIN Oportunidad ON EmpresaGral.Empresa = Oportunidad.Empresa WHERE ID = @ID
 
  IF NULLIF(RTRIM(@Almacen), '') IS NULL
    SELECT @Ok = 10576
 
  IF @Ok IS NULL
  BEGIN
    INSERT INTO Venta(
		     Empresa,  Mov,  FechaEmision, Proyecto, UEN, Moneda, TipoCambio, Usuario, Referencia, Observaciones, Estatus,      Cliente,   Almacen, Agente, OrigenTipo, Origen, OrigenID,  Sucursal,  SucursalOrigen,  SucursalDestino, IDOPORT)
      SELECT Empresa, @Mov, @FechaEmision, Proyecto, UEN, Moneda, TipoCambio, Usuario, Referencia, Observaciones, 'SINAFECTAR', Contacto, @Almacen, Agente, 'OPORT',    Mov,    MovID,    @Sucursal, @Sucursal,       @Sucursal,        ID
        FROM Oportunidad
       WHERE ID = @ID

    SELECT @IDVTAS = SCOPE_IDENTITY()
          
    IF @TipoImpuesto = 0
      INSERT INTO VentaD(
		       ID,      Renglon,   RenglonSub,   RenglonID,   RenglonTipo,   Almacen,   Articulo,   Precio,   PrecioSugerido,   Agente,  Sucursal,  SucursalOrigen,   Impuesto1,   Impuesto2,   Impuesto3,   Retencion1,   Retencion2,   Retencion3,   ContUso,   ContUso2,   ContUso3,   Unidad,   Cantidad,   SubCuenta,   UEN,   DescuentoLinea,   DescuentoImporte,   FechaRequerida,   HoraRequerida,   Espacio,   PrecioMoneda,   PrecioTipoCambio,   PoliticaPrecios,   DescuentoTipo,   Factor,   CantidadInventario)
      SELECT @IDVTAS, i.Renglon, i.RenglonSub, i.RenglonID, i.RenglonTipo, i.Almacen, i.Articulo, i.Precio, i.PrecioSugerido, c.Agente, @Sucursal, @Sucursal,       a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Retencion1, a.Retencion2, a.Retencion3, a.ContUso, a.ContUso2, a.ContUso3, a.Unidad, i.Cantidad, i.SubCuenta, i.UEN, i.DescuentoLinea, i.DescuentoImporte, i.FechaRequerida, i.HoraRequerida, i.Espacio, i.PrecioMoneda, i.PrecioTipoCambio, i.PoliticaPrecios, i.DescuentoTipo, i.Factor, i.CantidadInventario
        FROM OportunidadInteresadoEn i
        JOIN Oportunidad c ON i.ID = c.ID
        JOIN Art a ON i.Articulo = a.Articulo
       WHERE i.ID = @ID
    ELSE
      INSERT INTO VentaD(
		       ID,       Renglon,   RenglonSub,   RenglonID,   RenglonTipo,   Almacen,   Articulo,   Precio,   PrecioSugerido,   Agente,  Sucursal,  SucursalOrigen,   TipoImpuesto1,   TipoImpuesto2,   TipoImpuesto3,   TipoRetencion1,   TipoRetencion2,   TipoRetencion3,     Impuesto1,                               Impuesto2,                               Impuesto3,                               Retencion1,                               Retencion2,                               Retencion3,                              ContUso,   ContUso2,   ContUso3,   Unidad,   Cantidad,   SubCuenta,    UEN,   DescuentoLinea,   DescuentoImporte,   FechaRequerida,   HoraRequerida,   Espacio,   PrecioMoneda,   PrecioTipoCambio,   PoliticaPrecios,   DescuentoTipo,   Factor,   CantidadInventario)
       SELECT @IDVTAS, i.Renglon, i.RenglonSub, i.RenglonID, i.RenglonTipo, i.Almacen, i.Articulo, i.Precio, i.PrecioSugerido, c.Agente, @Sucursal, @Sucursal,       a.TipoImpuesto1, a.TipoImpuesto2, a.TipoImpuesto3, a.TipoRetencion1, a.TipoRetencion2, a.TipoRetencion3, dbo.fnTipoImpuestoTasa(a.TipoImpuesto1), dbo.fnTipoImpuestoTasa(a.TipoImpuesto2), dbo.fnTipoImpuestoTasa(a.TipoImpuesto3), dbo.fnTipoImpuestoTasa(a.TipoRetencion1), dbo.fnTipoImpuestoTasa(a.TipoRetencion2), dbo.fnTipoImpuestoTasa(a.TipoRetencion3),  a.ContUso, a.ContUso2, a.ContUso3, a.Unidad, i.Cantidad, i.SubCuenta, i.UEN, i.DescuentoLinea, i.DescuentoImporte, i.FechaRequerida, i.HoraRequerida, i.Espacio, i.PrecioMoneda, i.PrecioTipoCambio, i.PoliticaPrecios, i.DescuentoTipo, i.Factor, i.CantidadInventario
         FROM OportunidadInteresadoEn i
         JOIN Oportunidad c ON i.ID = c.ID
         JOIN Art a ON i.Articulo = a.Articulo
        WHERE i.ID = @ID
  END

  --IF @Ok IS NULL OR(@Ok = 80030)
  --  EXEC spAfectar 'OPORT', @IDVTAS, 'CONSECUTIVO', @Usuario = @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  EXEC xpOportunidadPropuestaAgregar  @ID, @Usuario, @Sucursal, @Plantilla, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT					
			
  IF @Ok IS NULL
  BEGIN
    SELECT @OkRef = NULL
  END
  ELSE
    -- Leer el Mensaje
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok  

  -- Mostrar el Estatus de la Afectacion
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, @IDVTAS

  RETURN
END
GO


/**************** spOportunidadPlanPreliminarAgregar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadPlanPreliminarAgregar') and type = 'P') drop procedure dbo.spOportunidadPlanPreliminarAgregar
GO
CREATE PROC spOportunidadPlanPreliminarAgregar 
			@ID			int, 
			@Usuario	varchar(10),
			@Sucursal	int,
			@Plantilla	varchar(20),
			@Empresa    varchar(20),
			@Ok			int			 = NULL OUTPUT,
			@OkRef		varchar(255) = NULL OUTPUT	
--//WITH ENCRYPTION				
AS
BEGIN
  DECLARE @Mov					varchar(20),
		  @FechaEmision			datetime,		 
		  @IDProy				int,
		  @OkDesc				varchar(255),
		  @OkTipo				varchar(50)
		
  SELECT @FechaEmision = GETDATE()
  
  EXEC spExtraerFecha @FechaEmision OUTPUT
  
  SELECT @Mov = PlanPreliminar FROM EmpresaCfgMov WHERE Empresa=@Empresa

  IF @Mov IS NULL OR @Mov = ''
  BEGIN
    SELECT @OK=10061	
  END

  IF @Mov IS NOT NULL
  BEGIN
	INSERT Proyecto (Empresa, Mov,  ContactoTipo, Moneda, TipoCambio, Estatus,      FechaEmision,   Usuario, Proyecto, Sucursal, OrigenTipo, Origen, OrigenID)
			  SELECT Empresa, @Mov, ContactoTipo, Moneda, TipoCambio, 'SINAFECTAR', @FechaEmision,  Usuario, Proyecto, Sucursal, 'OPORT',    Mov,    MovID 
				FROM Oportunidad
				WHERE ID=@ID

    SELECT @IDProy = SCOPE_IDENTITY()


	INSERT INTO ProyectoInteresadoEn (ID,      Renglon, RenglonSub, RenglonTipo, RenglonID, Articulo, Cantidad, CantidadInventario, SubCuenta, Precio, PrecioSugerido, Sucursal, SucursalOrigen, UEN, DescuentoLinea, DescuentoImporte, FechaRequerida, HoraRequerida, Espacio, Almacen, PoliticaPrecios, PrecioMoneda, PrecioTipoCambio, DescuentoTipo, Unidad, Factor, CompraRequerida)
	SELECT                            @IDProy, Renglon, RenglonSub, RenglonTipo, RenglonID, Articulo, Cantidad, CantidadInventario, SubCuenta, Precio, PrecioSugerido, Sucursal, SucursalOrigen, UEN, DescuentoLinea, DescuentoImporte, FechaRequerida, HoraRequerida, Espacio, Almacen, PoliticaPrecios, PrecioMoneda, PrecioTipoCambio, DescuentoTipo, Unidad, Factor, CompraRequerida
	  FROM OportunidadInteresadoEn 
	 WHERE ID=@ID
 
  EXEC xpOportunidadPlanPreliminarAgregar  @ID, @Usuario, @Sucursal, @Plantilla, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT					
  
  END
  			
  IF @Ok IS NULL
  BEGIN
    SELECT @OkRef = NULL
  END
  ELSE
    -- Leer el Mensaje
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok  
  
  
  -- Mostrar el Estatus de la Afectacion
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, @IDProy
  


  RETURN
END
GO


/**************** spProyectoPropuestaAgregar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoPropuestaAgregar') and type = 'P') drop procedure dbo.spProyectoPropuestaAgregar
GO
CREATE PROC spProyectoPropuestaAgregar 
			@ID			int, 
			@Usuario	varchar(10),
			@Empresa    varchar(10),
			@Sucursal	int,			
			@Ok			int			 = NULL OUTPUT,
			@OkRef		varchar(255) = NULL OUTPUT	
--//WITH ENCRYPTION				
AS
BEGIN
  DECLARE @Mov					varchar(20),
		  @FechaEmision			datetime,
		  @Almacen				varchar(10),
		  @IDVTAS				int,
		  @OkDesc				varchar(255),
		  @OkTipo				varchar(50),
		  @TipoImpuesto			bit
 
  SELECT @FechaEmision = GETDATE()
  
  EXEC spExtraerFecha @FechaEmision OUTPUT
  
  SELECT @Mov = PropuestaEconomica FROM EmpresaCfgMov WHERE Empresa=@Empresa

  IF @Mov IS NULL OR @Mov = ''
  BEGIN
    SELECT @OK=10061	
  END

  IF @Mov IS NOT NULL
  BEGIN
	  SELECT @Almacen = DefAlmacen FROM Usuario WHERE Usuario = @Usuario
 
	  SELECT @TipoImpuesto = ISNULL(TipoImpuesto, 0) FROM EmpresaGral JOIN Oportunidad ON EmpresaGral.Empresa = Oportunidad.Empresa WHERE ID = @ID
 
	  IF NULLIF(RTRIM(@Almacen), '') IS NULL
		SELECT @Ok = 10576
 
	  IF @Ok IS NULL
	  BEGIN
		INSERT INTO Venta(
				 Empresa,  Mov,  FechaEmision, Proyecto, UEN, Moneda, TipoCambio, Usuario, Referencia, Observaciones, Estatus,      Cliente,  Almacen, Agente, OrigenTipo, Origen, OrigenID,  Sucursal,  SucursalOrigen,  SucursalDestino, IDProyecto)
		  SELECT Empresa, @Mov, @FechaEmision, Proyecto, UEN, Moneda, TipoCambio, Usuario, Referencia, Observaciones, 'SINAFECTAR', Cliente,  @Almacen, Agente, 'PROY',    Mov,    MovID,     @Sucursal, @Sucursal,       @Sucursal,       ID
			FROM Proyecto
		   WHERE ID = @ID

		SELECT @IDVTAS = SCOPE_IDENTITY()
         
		IF @TipoImpuesto = 0
		  INSERT INTO VentaD(
				   ID,      Renglon,   RenglonSub,   RenglonID,   RenglonTipo,   Almacen,   Articulo,   Precio,   PrecioSugerido,   Agente,  Sucursal,  SucursalOrigen,   Impuesto1,   Impuesto2,   Impuesto3,   Retencion1,   Retencion2,   Retencion3,   ContUso,   ContUso2,   ContUso3,   Unidad,   Cantidad,   SubCuenta,   UEN,   DescuentoLinea,   DescuentoImporte,   FechaRequerida,   HoraRequerida,   Espacio,   PrecioMoneda,   PrecioTipoCambio,   PoliticaPrecios,   DescuentoTipo,   Factor,   CantidadInventario)
		  SELECT @IDVTAS, i.Renglon, i.RenglonSub, i.RenglonID, i.RenglonTipo, i.Almacen, i.Articulo, i.Precio, i.PrecioSugerido, c.Agente, @Sucursal, @Sucursal,       a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Retencion1, a.Retencion2, a.Retencion3, a.ContUso, a.ContUso2, a.ContUso3, a.Unidad, i.Cantidad, i.SubCuenta, i.UEN, i.DescuentoLinea, i.DescuentoImporte, i.FechaRequerida, i.HoraRequerida, i.Espacio, i.PrecioMoneda, i.PrecioTipoCambio, i.PoliticaPrecios, i.DescuentoTipo, i.Factor, i.CantidadInventario
			FROM ProyectoInteresadoEn i
			JOIN Proyecto c ON i.ID = c.ID
			JOIN Art a ON i.Articulo = a.Articulo
		   WHERE i.ID = @ID
		ELSE
		  INSERT INTO VentaD(
				   ID,       Renglon,   RenglonSub,   RenglonID,   RenglonTipo,   Almacen,   Articulo,   Precio,   PrecioSugerido,   Agente,  Sucursal,  SucursalOrigen,   TipoImpuesto1,   TipoImpuesto2,   TipoImpuesto3,   TipoRetencion1,   TipoRetencion2,   TipoRetencion3,     Impuesto1,                               Impuesto2,                               Impuesto3,                               Retencion1,                               Retencion2,                               Retencion3,                              ContUso,   ContUso2,   ContUso3,   Unidad,   Cantidad,   SubCuenta,    UEN,   DescuentoLinea,   DescuentoImporte,   FechaRequerida,   HoraRequerida,   Espacio,   PrecioMoneda,   PrecioTipoCambio,   PoliticaPrecios,   DescuentoTipo,   Factor,   CantidadInventario)
		   SELECT @IDVTAS, i.Renglon, i.RenglonSub, i.RenglonID, i.RenglonTipo, i.Almacen, i.Articulo, i.Precio, i.PrecioSugerido, c.Agente, @Sucursal, @Sucursal,       a.TipoImpuesto1, a.TipoImpuesto2, a.TipoImpuesto3, a.TipoRetencion1, a.TipoRetencion2, a.TipoRetencion3, dbo.fnTipoImpuestoTasa(a.TipoImpuesto1), dbo.fnTipoImpuestoTasa(a.TipoImpuesto2), dbo.fnTipoImpuestoTasa(a.TipoImpuesto3), dbo.fnTipoImpuestoTasa(a.TipoRetencion1), dbo.fnTipoImpuestoTasa(a.TipoRetencion2), dbo.fnTipoImpuestoTasa(a.TipoRetencion3),  a.ContUso, a.ContUso2, a.ContUso3, a.Unidad, i.Cantidad, i.SubCuenta, i.UEN, i.DescuentoLinea, i.DescuentoImporte, i.FechaRequerida, i.HoraRequerida, i.Espacio, i.PrecioMoneda, i.PrecioTipoCambio, i.PoliticaPrecios, i.DescuentoTipo, i.Factor, i.CantidadInventario
			 FROM ProyectoInteresadoEn i
			 JOIN Proyecto c ON i.ID = c.ID
			 JOIN Art a ON i.Articulo = a.Articulo
			WHERE i.ID = @ID
	  END

	  --IF @Ok IS NULL OR(@Ok = 80030)
	  --  EXEC spAfectar 'OPORT', @IDVTAS, 'CONSECUTIVO', @Usuario = @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

	  EXEC xpProyectoPropuestaAgregar  @ID, @Usuario, @Sucursal, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT					
  END
  		
  IF @Ok IS NULL
  BEGIN
    SELECT @OkRef = NULL
  END
  ELSE
    -- Leer el Mensaje
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok  

  -- Mostrar el Estatus de la Afectacion
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, @IDVTAS

  RETURN
END
GO


--REQ16092
/**************** spOportunidadunidadInteresadoEnEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadunidadInteresadoEnEliminar') and type = 'P') drop procedure dbo.spOportunidadunidadInteresadoEnEliminar
GO
CREATE PROC spOportunidadunidadInteresadoEnEliminar
			@Estacion	int,
			@ID         int,
			@RenglonID	int
--//WITH ENCRYPTION
AS BEGIN
  DELETE OportunidadInteresadoEn WHERE ID = @ID AND RenglonID = @RenglonID
  RETURN
END
GO

--REQ16092
/**************** spOportunidadVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadVerificar') and type = 'P') drop procedure dbo.spOportunidadVerificar
GO
CREATE PROCEDURE spOportunidadVerificar
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

--//WITH ENCRYPTION
AS BEGIN 
  IF @Accion IN('AFECTAR', 'AUTORIZAR')
  BEGIN
    IF ISNULL(@Plantilla, '') = ''
      SELECT @Ok = 14080
    
    IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM OportunidadInteresadoEn WHERE ID = @ID)
      SELECT @Ok = 14081
    
    IF @MovTipo = 'OPORT.O' AND ISNULL(@Contacto, '') = ''
      SELECT @Ok = 28020

    IF @MovTipo = 'OPORT.O' AND @Estatus = 'REVISION' AND @EstatusNuevo = 'PENDIENTE' AND ISNULL(@Propuesta, '') = ''
      SELECT @Ok = 14082
  END

  EXEC xpOportunidadVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
                              @NivelInteres, @Plantilla, @ContactoTipo, @Contacto, @ImporteOportunidad, @PorcentajeCierre, @ImportePonderado, @ProbCierre, @Competidor, @Motivo, @Propuesta, @Intermediario, 
          	                  @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO

--REQ16092
/**************** spOportunidadMatar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadMatar') and type = 'P') drop procedure dbo.spOportunidadMatar
GO
CREATE PROC spOportunidadMatar
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
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Renglon					float,
		  @IDOrigen					int,
		  @AplicaEstatusNuevo		char(15),
		  @AplicaFechaConclusion	datetime,
		  @AplicaEstatus			varchar(15),
		  @OrigenMovTipo			varchar(20)

  IF @Accion = 'AFECTAR'
  BEGIN
    SELECT @IDOrigen = ID, @AplicaEstatus = Estatus FROM Oportunidad JOIN MovTipo ON Oportunidad.Mov = MovTipo.Mov AND MovTipo.Modulo = 'OPORT' WHERE Empresa = @Empresa AND Oportunidad.Mov = @Origen AND MovID = @OrigenID AND Estatus = 'PENDIENTE'

    SELECT @Renglon = MIN(Renglon) FROM OportunidadD WHERE ID = @IDOrigen AND Contacto = @Contacto AND ISNULL(CantidadPendiente, 0) <> 0
    
    IF @IDOrigen IS NULL OR @Renglon IS NULL
      SELECT @Ok = 20180, @OkRef = @Contacto
      
    UPDATE OportunidadD SET CantidadPendiente = NULL WHERE ID = @IDOrigen AND Contacto = @Contacto AND Renglon = @Renglon
    
    IF NOT EXISTS(SELECT * FROM OportunidadD WHERE ID = @IDOrigen AND ISNULL(CantidadPendiente, 0) <> 0)
      SELECT @AplicaEstatusNuevo = 'CONCLUIDO', @AplicaFechaConclusion = @FechaEmision
    ELSE
      SELECT @AplicaEstatusNuevo = @AplicaEstatus, @AplicaFechaConclusion = NULL
  END
  ELSE IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @IDOrigen = ID, @AplicaEstatus = Estatus FROM Oportunidad JOIN MovTipo ON Oportunidad.Mov = MovTipo.Mov AND MovTipo.Modulo = 'OPORT' WHERE Empresa = @Empresa AND Oportunidad.Mov = @Origen AND MovID = @OrigenID AND Estatus IN('PENDIENTE', 'CONCLUIDO')
        
    SELECT @Renglon = MIN(Renglon) FROM OportunidadD WHERE ID = @IDOrigen AND Contacto = @Contacto AND ISNULL(CantidadPendiente, 0) = 0
    
    IF @IDOrigen IS NULL OR @Renglon IS NULL
      SELECT @Ok = 20180, @OkRef = @Contacto
      
    UPDATE OportunidadD SET CantidadPendiente = 1 WHERE ID = @IDOrigen AND Contacto = @Contacto AND Renglon = @Renglon

    IF NOT EXISTS(SELECT * FROM OportunidadD WHERE ID = @IDOrigen AND ISNULL(CantidadPendiente, 0) = 0)
      SELECT @AplicaEstatusNuevo = 'PENDIENTE', @AplicaFechaConclusion = NULL
    ELSE 
      SELECT @AplicaEstatusNuevo = 'PENDIENTE', @AplicaFechaConclusion = @FechaEmision    
  END

  IF @AplicaEstatus <> @AplicaEstatusNuevo
  BEGIN
    EXEC spValidarTareas @Empresa, 'OPORT', @IDOrigen, @AplicaEstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT  
    UPDATE Oportunidad SET Estatus = @AplicaEstatusNuevo, FechaConclusion = @AplicaFechaConclusion WHERE ID = @IDOrigen
    IF @@ERROR <> 0 SELECT @Ok = 1
  END
  
  EXEC xpOportunidadMatar @Empresa, @Usuario, @FechaEmision, @FechaRegistro, @Sucursal, @ID, @Accion, @OrigenTipo, @Origen, @OrigenID, @ContactoTipo, @Contacto, @Ok OUTPUT, @OkRef OUTPUT
  
  -- Agregar a Estatus Log
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spMovFinal @Empresa, @Sucursal, 'OPORT', @IDOrigen, @AplicaEstatus, @AplicaEstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Origen, @OrigenID, @OrigenMovTipo, NULL, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

--REQ16092
/**************** spOportunidadPropuestaConcluir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadPropuestaConcluir') and type = 'P') drop procedure dbo.spOportunidadPropuestaConcluir
GO             
CREATE PROC spOportunidadPropuestaConcluir
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
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @IDVTAS			int,
		  @IDVTASAnt		int

  SELECT @IDVTASAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @IDVTAS = MIN(ID)
      FROM Venta
     WHERE IDOPORT = @ID
       AND Empresa = @Empresa
       AND ID <> @IDPropuesta
	   AND Estatus = 'CONFIRMAR'
       AND ID > @IDVTASAnt
  
    IF @IDVTAS IS NULL BREAK
    
    SELECT @IDVTASAnt = @IDVTAS
        
    EXEC spAfectar 'VTAS', @IDVTAS, 'AFECTAR', 'Todo', NULL, @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
  END
  
  RETURN
END
GO

--REQ16092
/**************** spOportunidadImporteOportunidad  ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadImporteOportunidad') and type = 'P') drop procedure dbo.spOportunidadImporteOportunidad
GO             
CREATE PROC spOportunidadImporteOportunidad
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
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Importe		float
  
  SELECT @Importe = Importe FROM Venta WHERE ID = @IDPropuesta
  
  UPDATE Oportunidad SET ImporteOportunidad = @Importe WHERE ID = @ID
  
  RETURN
END
GO

--REQ16092
/**************** spOportunidadOportunidadGanar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadOportunidadGanar') and type = 'P') drop procedure dbo.spOportunidadOportunidadGanar
GO             
CREATE PROC spOportunidadOportunidadGanar
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
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @GenerarMov			bit,
		  @Movimiento			varchar(20),
		  @GenerarID			int,
		  @Autoriza				varchar(10)

  SELECT @GenerarMov = ISNULL(GenerarMov, 0),
		 @Movimiento = Mov
    FROM OportunidadPlantilla
   WHERE Plantilla = @Plantilla

  IF @Accion IN('AFECTAR', 'AUTORIZAR')
  BEGIN   
    EXEC @GenerarID = spAfectar 'VTAS', @IDPropuesta, 'GENERAR', 'Todo', @Movimiento, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF (@Ok IS NULL OR @Ok = 80030) AND NULLIF(@GenerarID, 0) IS NOT NULL
    BEGIN
      SELECT @Ok = NULL, @OkRef = NULL

      EXEC spAfectar 'VTAS', @GenerarID, 'AFECTAR', 'Todo', NULL, @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
      
      IF @Accion = 'AUTORIZAR' AND @Ok IS NOT NULL
      BEGIN
        UPDATE Venta SET Mensaje = @Ok WHERE ID = @GenerarID
        
        EXEC spAfectar 'VTAS', @GenerarID, 'AUTORIZAR', 'Todo', NULL, @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
      END
    END
    IF @Ok IS NULL
      UPDATE Oportunidad SET IDVTAS = @GenerarID WHERE ID = @ID
    ELSE
      SELECT @Mensaje = Mensaje FROM Venta WHERE ID = @GenerarID      
  END
  ELSE IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @GenerarID = IDVTAS FROM Oportunidad WHERE ID = @ID
    
    IF NULLIF(@GenerarID, 0) IS NOT NULL
      EXEC spAfectar 'VTAS', @GenerarID, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
  END

  EXEC xpOportunidadOportunidadGanar @Empresa, @Usuario, @FechaEmision, @FechaRegistro, @Sucursal, @ID, @Accion, @OrigenTipo, @Origen, @OrigenID, @ContactoTipo, @Contacto, @Propuesta, @Plantilla, @IDPropuesta, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    

  RETURN
END
GO

--REQ16092
/**************** spOportunidadOAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadOAfectar') and type = 'P') drop procedure dbo.spOportunidadOAfectar
GO             
CREATE PROC spOportunidadOAfectar
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

--//WITH ENCRYPTION
AS BEGIN
  DECLARE @IDPropuesta		int
  
  SELECT @IDPropuesta = ID
    FROM Venta
   WHERE IDOPORT = @ID
     AND RTRIM(Mov)+' '+RTRIM(MovID) = @Propuesta
     AND Empresa = @Empresa
     
  IF @Accion IN ('AFECTAR') AND NOT EXISTS(SELECT ID FROM OportunidadD WHERE ID = @ID)
  BEGIN
    EXEC spOportunidadunidadDInsertar @ID, @Plantilla, @Usuario, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF ISNULL(@OrigenTipo, '') = 'OPORT' AND @Ok IS NULL AND ((@Estatus = 'SINAFECTAR' AND @EstatusNuevo = 'REVISION') OR(@Accion = 'CANCELAR'))
    EXEC spOportunidadMatar @Empresa, @Usuario, @FechaEmision, @FechaRegistro, @Sucursal, @ID, @Accion, @OrigenTipo, @Origen, @OrigenID, @ContactoTipo, @Contacto, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL AND (@EstatusNuevo = 'PENDIENTE')
  BEGIN
    EXEC spOportunidadImporteOportunidad @Empresa, @Usuario, @FechaEmision, @FechaRegistro, @Sucursal, @ID, @Accion, @OrigenTipo, @Origen, @OrigenID, @ContactoTipo, @Contacto, @Propuesta, @Plantilla, @IDPropuesta, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  END

  IF @Ok IS NULL AND ((@EstatusNuevo = 'CONCLUIDO') OR(@Accion = 'CANCELAR'))
  BEGIN
    EXEC spOportunidadOportunidadGanar @Empresa, @Usuario, @FechaEmision, @FechaRegistro, @Sucursal, @ID, @Accion, @OrigenTipo, @Origen, @OrigenID, @ContactoTipo, @Contacto, @Propuesta, @Plantilla, @IDPropuesta, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    

    IF @Ok IS NULL AND @EstatusNuevo = 'CONCLUIDO'
      EXEC spOportunidadPropuestaConcluir @Empresa, @Usuario, @FechaEmision, @FechaRegistro, @Sucursal, @ID, @Accion, @OrigenTipo, @Origen, @OrigenID, @ContactoTipo, @Contacto, @Propuesta, @Plantilla, @IDPropuesta, @Ok OUTPUT, @OkRef OUTPUT    
  END
  
  EXEC xpOportunidadOAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion, @Proyecto, 
						   @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
						   @MovUsuario, @NivelInteres, @Plantilla, @ContactoTipo, @Contacto, @ImporteOportunidad, @PorcentajeCierre, @ImportePonderado, @ProbCierre, @Competidor, 
						   @Motivo, @Propuesta, @Intermediario, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza, 
						   @Generar, @GenerarMov, @GenerarAfectado, @OrigenTipo, @Origen, @OrigenID, @IDGenerar OUTPUT, @GenerarMovID OUTPUT, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO

--REQ16092
/**************** spOportunidadGAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadGAfectar') and type = 'P') drop procedure dbo.spOportunidadGAfectar
GO             
CREATE PROCEDURE spOportunidadGAfectar
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

--//WITH ENCRYPTION
AS BEGIN
  IF @Accion = 'AFECTAR'
  BEGIN
    UPDATE OportunidadD SET CantidadPendiente = 1 WHERE ID = @ID
  END

  EXEC xpOportunidadGAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion, @Proyecto, 
						   @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
						   @MovUsuario, @NivelInteres, @Plantilla, @ContactoTipo, @Contacto, @ImporteOportunidad, @PorcentajeCierre, @ImportePonderado, @ProbCierre, @Competidor, 
						   @Motivo, @Propuesta, @Intermediario, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza, 
						   @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

--REQ16092
/**************** spOportunidadGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadGenerar') and type = 'P') drop procedure dbo.spOportunidadGenerar
GO             
CREATE PROCEDURE spOportunidadGenerar
		    @ID				int,
            @Base			char(20),
			@Sucursal	int,
		    	@Empresa	char(5), 
			@Modulo		char(5), 
			@Ejercicio	int, 
			@Periodo	int,
			@Usuario	char(10), 
			@FechaEmision	datetime, 
			@Estatus	char(15),

			@Almacen	char(10),
		        @AlmacenDestino char(10),

			@Mov		char(20),
			@MovID 		varchar(20), 
			@GenerarDirecto	bit,

			@GenerarMov		char(20),
			@GenerarSerie	char(20),
			@ContactoTipo	varchar(20),
			@GenerarMovID 	varchar(20)	OUTPUT, 
			@GenerarID		int		OUTPUT,

			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Renglon			int,
		  @RenglonAnt		int,
		  @Contacto			varchar(10)

  SELECT @RenglonAnt = 0
  WHILE(1=1)
  BEGIN
    IF @Base = 'PENDIENTE'
      SELECT @Renglon = MIN(Renglon)
        FROM OportunidadD
       WHERE ID = @ID
         AND ISNULL(CantidadPendiente, 0) > 0
         AND Renglon > @RenglonAnt
    ELSE IF @Base = 'SELECCION'
      SELECT @Renglon = MIN(Renglon)
        FROM OportunidadD
       WHERE ID = @ID
         AND ISNULL(CantidadPendiente, 0) > 0
         AND ISNULL(CantidadA, 0) > 0
         AND Renglon > @RenglonAnt

    IF @Renglon IS NULL BREAK
    
    SELECT @RenglonAnt = @Renglon

    SELECT @Contacto = Contacto FROM OportunidadD WHERE ID = @ID AND Renglon = @Renglon

    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaEmision, 'SINAFECTAR', 
					  NULL, NULL, 
					  @Mov, @MovID, 0,
					  @GenerarMov, NULL, @GenerarMovID OUTPUT, @GenerarID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    
    SELECT * INTO #GenerarInteresadoEn FROM cOportunidadInteresadoEn WHERE ID = @ID
    UPDATE #GenerarInteresadoEn SET ID = @GenerarID
    INSERT INTO cOportunidadInteresadoEn SELECT * FROM #GenerarInteresadoEn
    
    SELECT * INTO #GenerarCompentencia FROM cOportunidadCompetencia WHERE ID = @ID
    UPDATE #GenerarCompentencia SET ID = @GenerarID    
    INSERT INTO cOportunidadCompetencia SELECT * FROM #GenerarCompentencia

    DROP TABLE #GenerarInteresadoEn
    DROP TABLE #GenerarCompentencia

    UPDATE Oportunidad SET Contacto = @Contacto WHERE ID = @GenerarID
  END
  
  UPDATE OportunidadD SET CantidadA = NULL WHERE ID = @ID
  
  RETURN
END
GO


   
--REQ16092
/**************** spOportunidadAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadAfectar') and type = 'P') drop procedure dbo.spOportunidadAfectar
GO             
CREATE PROCEDURE spOportunidadAfectar
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

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @FechaCancelacion	datetime,
    @GenerarMovTipo	char(20),
    @GenerarPeriodo	int,
    @GenerarEjercicio	int,
    @IDOrigen			int
      
  SELECT @IDOrigen = ID FROM Oportunidad WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus = 'PENDIENTE'

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
    EXEC spOportunidadGenerar @ID, @Base, @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, 'SINAFECTAR', 
					  NULL, NULL, 
					  @Mov, @MovID, 0,
					  @GenerarMov, NULL, @ContactoTipo, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

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

    IF @Accion IN ('AFECTAR', 'CANCELAR', 'AUTORIZAR')
    BEGIN
      IF @MovTipo IN ('OPORT.O') AND @Ok IS NULL
      BEGIN
        EXEC spOportunidadOAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion, @Proyecto, 
						   @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
						   @MovUsuario, @NivelInteres, @Plantilla, @ContactoTipo, @Contacto, @ImporteOportunidad, @PorcentajeCierre, @ImportePonderado, @ProbCierre, @Competidor, 
						   @Motivo, @Propuesta, @Intermediario, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza, 
						   @Generar, @GenerarMov, @GenerarAfectado, @OrigenTipo, @Origen, @OrigenID, @IDGenerar OUTPUT, @GenerarMovID OUTPUT, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      END

      IF @MovTipo IN ('OPORT.G') AND @Ok IS NULL
      BEGIN
        EXEC spOportunidadGAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion, @Proyecto, 
						   @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
						   @MovUsuario, @NivelInteres, @Plantilla, @ContactoTipo, @Contacto, @ImporteOportunidad, @PorcentajeCierre, @ImportePonderado, @ProbCierre, @Competidor, 
						   @Motivo, @Propuesta, @Intermediario, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza, 
						   @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      END
      
	   IF @MovTipo IN ('OPORT.SD') AND @Ok IS NULL
      BEGIN
       EXEC spOportunidadOAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion, @Proyecto, 
						   @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
						   @MovUsuario, @NivelInteres, @Plantilla, @ContactoTipo, @Contacto, @ImporteOportunidad, @PorcentajeCierre, @ImportePonderado, @ProbCierre, @Competidor, 
						   @Motivo, @Propuesta, @Intermediario, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza, 
						   @Generar, @GenerarMov, @GenerarAfectado, @OrigenTipo, @Origen, @OrigenID, @IDGenerar OUTPUT, @GenerarMovID OUTPUT, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
	 
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
        
        UPDATE Oportunidad
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	           Estatus          = @EstatusNuevo,
               Situacion 	    = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza
         WHERE ID = @ID 
         
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @OrigenTipo, @IDOrigen, @Origen, @OrigenID, 'OPORT', @ID, @Mov, @MovID, @Ok OUTPUT

    EXEC xpOportunidadAfectar @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion, @Proyecto, 
	  					      @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
						      @MovUsuario, @NivelInteres, @Plantilla, @ContactoTipo, @Contacto, @ImporteOportunidad, @PorcentajeCierre, @ImportePonderado, @ProbCierre, @Competidor, 
						      @Motivo, @Propuesta, @Intermediario, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza, 
						      @Generar, @GenerarMov, @GenerarAfectado, @OrigenTipo, @Origen, @OrigenID, 
						      @IDGenerar OUTPUT, @GenerarMovID OUTPUT, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT, 1

  IF @Conexion = 0
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
  RETURN
END
GO




--REQ16092
/**************** spOportunidad ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidad') and type = 'P') drop procedure dbo.spOportunidad
GO
CREATE PROCEDURE spOportunidad
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
    @Autorizacion	      char(10),    
    @MovUsuario	      	char(10),
    @DocFuente	      	int,
    @Concepto    	varchar(50),
    @Referencia 	varchar(50),
    @Observaciones    	varchar(255),
    @Estatus          	char(15),
    @EstatusNuevo	char(15),
    @Ejercicio	      	int,
    @Periodo	      	int,
    @GenerarMovID	varchar(20),
    @GenerarPoliza	bit,
    @CfgContX		bit,
    @CfgContXGenerar	char(20),

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
    @OrigenTipo			varchar(5),
    @Origen				varchar(20),
    @OrigenID			varchar(20),
    @Mensaje			int
    
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
         @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion,
         @Concepto = Concepto, @Referencia = Referencia,
         @NivelInteres = NivelInteres, @Plantilla = Plantilla, @ContactoTipo = ContactoTipo, @Contacto = Contacto, @ImporteOportunidad = ImporteOportunidad, @PorcentajeCierre = PorcentajeCierre,
         @ImportePonderado = ImportePonderado, @ProbCierre = ProbCierre, @Competidor = Competidor, @Motivo = Motivo, @Propuesta = Propuesta, @Intermediario = Intermediario,
         @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID
    FROM Oportunidad
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
  ELSE 
  BEGIN
    IF @MovTipo IN ('OPORT.O', 'OPORT.SD')  -- Se agrega la Clave OPORT.SD para que quede en Estatus <Revisión>  
    BEGIN
      IF @Accion <> 'AUTORIZAR'
        SELECT @EstatusNuevo = @GenerarMov
      ELSE
        SELECT @EstatusNuevo = 'CONCLUIDO'
    END
    ELSE IF @MovTipo = 'OPORT.G'
      SELECT @EstatusNuevo = 'PENDIENTE'      
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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'PENDIENTE', 'POSFECHADO', 'RECHAZADO', 'REVISION')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE', 'POSFECHADO', 'RECHAZADO', 'REVISION'))
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
      EXEC spOportunidadVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
                             @NivelInteres, @Plantilla, @ContactoTipo, @Contacto, @ImporteOportunidad, @PorcentajeCierre, @ImportePonderado, @ProbCierre, @Competidor, @Motivo, @Propuesta, @Intermediario, 
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
   
    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO', 'AUTORIZAR') AND @Ok IS NULL
      EXEC spOportunidadAfectar @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion, @Proyecto, 
						@Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
						@MovUsuario, @NivelInteres, @Plantilla, @ContactoTipo, @Contacto, @ImporteOportunidad, @PorcentajeCierre, @ImportePonderado, @ProbCierre, @Competidor, 
						@Motivo, @Propuesta, @Intermediario, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza, 
						@Generar, @GenerarMov, @GenerarAfectado, @OrigenTipo, @Origen, @OrigenID, 
						@IDGenerar OUTPUT, @GenerarMovID OUTPUT, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END ELSE
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
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

  IF @Mensaje IS NOT NULL
    UPDATE Oportunidad SET Mensaje = @Mensaje WHERE ID = @ID

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


--REQ16092
/**************** spOportunidadPosfechado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadPosfechado') and type = 'P') drop procedure dbo.spOportunidadPosfechado
GO
CREATE PROC spOportunidadPosfechado
            @ID             int,
            @Fecha			datetime       
--//WITH ENCRYPTION
AS
BEGIN
  UPDATE Oportunidad SET PosfechadoHasta = @Fecha WHERE ID = @ID

  RETURN
END
GO

--REQ16092
/**************** spOportunidadRechazado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadRechazado') and type = 'P') drop procedure dbo.spOportunidadRechazado
GO
CREATE PROC spOportunidadRechazado
            @ID             int,
			@Competidor		varchar(50),
			@Motivo			varchar(100)
--//WITH ENCRYPTION
AS
BEGIN
  UPDATE Oportunidad SET Competidor = @Competidor, Motivo = @Motivo WHERE ID = @ID
  
  RETURN
END
GO

--REQ16092
/**************** spOportunidadGestionGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadGestionGenerar') and type = 'P') drop procedure dbo.spOportunidadGestionGenerar
GO
CREATE PROC spOportunidadGestionGenerar
			@ID					int,
			@Mov				varchar(20),
			@MovID				varchar(20),
			@Empresa			varchar(5),  
			@Sucursal			int,
			@Usuario			varchar(15),
			@Proyecto			varchar(50),
			@UEN				int,
			@Observaciones		varchar(100),
			@RID				int,
			@Tipo				varchar(20),
			@Clave				varchar(50),
			@PorcentajeAvance	float,
			@Comentarios		varchar(max),
			@Fecha				datetime,
			@FechaA				datetime,
			@Recurso			varchar(10),
			@IDGestion			int,
			@Ok					int			 = NULL OUTPUT,
			@OkRef				varchar(255) = NULL OUTPUT  
--//WITH ENCRYPTION  
AS 
BEGIN  
  DECLARE 
		  @NombreRecurso	varchar(100),
		  @Asunto			varchar(255),
		  @MovGestion		varchar(20),
		  @FechaEmision		datetime,
		  @Concepto			varchar(50),
		  @OPORTTareaEstado	varchar(30),
		  @Estatus			varchar(15),
		  @Avance			float,
		  @OkDesc           varchar(255),
		  @OkTipo           varchar(50),
		  @MovGES			varchar(50),
		  @GeneraMov		varchar(20),
		  @GeneraMovID		varchar(20)

  SELECT @FechaEmision = GETDATE()
  
  EXEC spExtraerFecha @FechaEmision OUTPUT

  IF ISNULL(@Recurso,'') = '' 
    SELECT @Ok = 55105, @OkRef = 'Clave: ' + ISNULL(@Clave,'')
    
  IF @IDGestion IS NOT NULL
    SELECT @Ok = 14083, @OkRef = 'Clave: ' + ISNULL(@Clave,'')    
  
  IF YEAR(@Fecha)  = 1899 SELECT @Fecha = NULL
  --BUG18507
  IF YEAR(@FechaA) = 1899 SELECT @FechaA = NULL  
  
  IF @Ok IS NULL 
  BEGIN
    SELECT @NombreRecurso = Nombre FROM Recurso WHERE Recurso=@Recurso
    
    SELECT @Asunto = @Tipo + ' ' + @Clave
    
    SELECT @MovGestion = GESTarea FROM EmpresaCfgMov WHERE Empresa = @Empresa
    
    SELECT @OPORTTareaEstado = OPORTTareaEstado FROM EmpresaCfg2 WHERE Empresa = @Empresa

    SELECT @Comentarios = '{\rtf1\ansi\ansicpg1252\deff0{\fonttbl{\f0\fnil Tahoma;}{\f1\fnil\fcharset0 Tahoma;}}  {\colortbl ;\red0\green0\blue0;}  \viewkind4\uc1\pard\cf1\lang2058\f0\fs20  \f1 ' + ISNULL(@Comentarios, '') + '\f0   \par }  '

    INSERT INTO Gestion(
			   Empresa,  Mov,         FechaEmision,  Concepto,  Proyecto,  UEN,  Usuario, Referencia,                         Observaciones,  Estatus,     OrigenTipo,  Origen,  OrigenID,  Sucursal,  Asunto,  Comentarios, FechaD,  FechaA,   Estado,           Avance,           SucursalOrigen,  SucursalDestino,  OPORTID)
	   SELECT @Empresa, @MovGestion, @FechaEmision, @Concepto, @Proyecto, @UEN, @Usuario, RTRIM(@Mov) + ' ' + RTRIM(@MovID), @Observaciones, 'SINAFECTAR', 'OPORT',     @Mov,    @MovID,    @Sucursal, @Asunto, @Comentarios, @Fecha, @FechaA,  @OPORTTareaEstado, @PorcentajeAvance, @Sucursal,       @Sucursal,      @ID

    SELECT @IDGestion = @@IDENTITY
   
    INSERT INTO MovGrupo (Modulo, ModuloID, Recurso) 
                 VALUES ('GES', @IDGestion, @Recurso)  
   
    EXEC spAfectar 'GES', @IDGestion, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion=@@SPID, @EnSilencio=1, @Conexion = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @Avance = Avance, @Estatus = Estatus, @MovGES = RTRIM(Mov)+' '+RTRIM(MovID), @GeneraMov = Mov, @GeneraMovID = MovID FROM Gestion WHERE ID=@IDGestion     

    EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'OPORT', @ID, @Mov, @MovID, 'GES', @IDGestion, @GeneraMov, @GeneraMovID, @Ok OUTPUT
      
    UPDATE OportunidadD
       SET IDGestion=@IDGestion,  
           PorcentajeAvance = @Avance,
           Fecha = @FechaEmision,
           Usuario = @Usuario,
           MovGestion = @MovGES
     WHERE ID = @ID 
       AND RID = @RID
     
    IF @@ERROR <> 0 SELECT @Ok = 1
  END

  IF @Ok IS NULL 
    SELECT @OkRef = NULL
  ELSE
    -- Leer el Mensaje
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok  
  
   -- Mostrar el Estatus de la Afectacion
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, @IDGestion

  RETURN  
END  
GO

--REQ16092
/**************** fnOportunidadMovimientoGestion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnOportunidadMovimientoGestion') DROP FUNCTION fnOportunidadMovimientoGestion
GO
CREATE FUNCTION fnOportunidadMovimientoGestion(
				@ID			int)
RETURNS varchar(50)
AS
BEGIN
  DECLARE @Valor	varchar(50)
  SELECT @Valor = RTRIM(Mov) + ' ' + RTRIM(MovID) FROM Gestion WHERE ID = @ID
  
  RETURN @Valor
END
GO

--REQ16092
/**************** spOportunidadActividadEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadActividadEliminar') and type = 'P') drop procedure dbo.spOportunidadActividadEliminar
GO
CREATE PROC spOportunidadActividadEliminar 
			@ID					int, 
			@Renglon			int, 
			@RenglonSub			int, 
			@IDGestion			int,
			@Tipo				varchar(20),
			@Clave				varchar(50),
			@PorcentajeAvance	float,
			@Ok					int			 = NULL OUTPUT,
			@OkRef				varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @OkDesc           	varchar(255),
		  @OkTipo           	varchar(50)

  IF @IDGestion IS NOT NULL
    SELECT @Ok = 14083, @OkRef = @Clave

  IF @Ok IS NULL
    DELETE OportunidadD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

  IF @Ok IS NULL 
    SELECT @OkRef = NULL
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

--REQ16092
/**************** spOportunidadeMailObtener ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadeMailObtener') and type = 'P') drop procedure dbo.spOportunidadeMailObtener
GO
CREATE PROC spOportunidadeMailObtener
			@EstacionTrabajo	int,
			@ID					int
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Mov			varchar(20),
		  @MovTipo		varchar(20)
  
  DELETE OportunidadeMailEnviar WHERE EstacionTrabajo = @EstacionTrabajo
  
  SELECT @Mov = Oportunidad.Mov, @MovTipo = MovTipo.Clave FROM Oportunidad JOIN MovTipo ON Oportunidad.Mov = MovTipo.Mov AND MovTipo.Modulo = 'OPORT' WHERE ID = @ID
  
  IF @MovTipo = 'OPORT.G'
  BEGIN
    INSERT INTO OportunidadeMailEnviar(
		    EstacionTrabajo, ContactoTipo, Cliente,  ID,		  Enviar)
    SELECT @EstacionTrabajo, OportunidadD.Tipo,    Contacto, CteCto.ID, 0
      FROM CteCto
      JOIN OportunidadD ON CteCto.Cliente = OportunidadD.Contacto
     WHERE OportunidadD.ID = @ID
       AND ISNULL(OPORTEnviar, 0) = 1
  END
  ELSE IF @MovTipo = 'OPORT.O'
  BEGIN
    INSERT INTO OportunidadeMailEnviar(
		    EstacionTrabajo, ContactoTipo,     Cliente,  ID,		  Enviar)
    SELECT @EstacionTrabajo, Oportunidad.ContactoTipo, Contacto, CteCto.ID, 0
      FROM CteCto 
      JOIN Oportunidad ON CteCto.Cliente = Oportunidad.Contacto
     WHERE Oportunidad.ID = @ID
       AND ISNULL(OPORTEnviar, 0) = 1
  END
  
  RETURN
END
GO

--REQ16092
/**************** spOportunidadeMailSeleccionar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadeMailSeleccionar') and type = 'P') drop procedure dbo.spOportunidadeMailSeleccionar
GO
CREATE PROC spOportunidadeMailSeleccionar
			@EstacionTrabajo	int,
			@Base				varchar(20)
--//WITH ENCRYPTION
AS
BEGIN
  IF @Base = 'Todo'
    UPDATE OportunidadeMailEnviar SET Enviar = 1 WHERE EstacionTrabajo = @EstacionTrabajo
  IF @Base = 'Nada'
    UPDATE OportunidadeMailEnviar SET Enviar = 0 WHERE EstacionTrabajo = @EstacionTrabajo    
  RETURN
END
GO

--REQ16092
/******************************* spOportunidadInsertarIS *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadInsertarIS') and type = 'P') drop procedure dbo.spOportunidadInsertarIS
GO             
CREATE PROCEDURE spOportunidadInsertarIS
		@Empresa					varchar(5),
		@Usuario					varchar(10),
		@ContactoTipo				varchar(20), 
		@Contacto					varchar(10), 
		@ModuloID					int,
		@FechaRegistro				datetime,
		@Para						varchar(max),
		@Asunto						varchar(255),
		@Mensaje					varchar(max),
		@Anexos						varchar(max),
		@Ok							int			 OUTPUT,
		@OkRef						varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Solicitud				varchar(max),
  @FechaXML					varchar(50),
  @ModuloIDXML				varchar(20),
  @Contrasena				varchar(32),
  @Resultado				varchar(max),
  @IntelisisServiceID		int,
  @ParaXML					varchar(max),
  @AsuntoXML				varchar(255),
  @MensajeXML				varchar(max),  
  @AnexosXML				varchar(max)

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario

  SET @FechaRegistro = dbo.fnFechaSinHora(GETDATE())  
  SET @ModuloIDXML = LTRIM(RTRIM(CONVERT(varchar,ISNULL(@ModuloID,0))))
  SET @ParaXML = dbo.fneDocXMLAUTF8(ISNULL(@Para,''),0,1)
  SET @AsuntoXML = dbo.fneDocXMLAUTF8(ISNULL(@Asunto,''),0,1)      
  SET @FechaXML = RTRIM(CONVERT(varchar,@FechaRegistro,126))
  SET @MensajeXML = dbo.fneDocXMLAUTF8(ISNULL(@Mensaje,''),0,1)
  SET @AnexosXML = dbo.fneDocXMLAUTF8(ISNULL(@Anexos,''),0,1)
  
  SET @Solicitud = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Oportunidad" Version="1.0">' +
                   '  <Solicitud>' +                    
                   '    <Oportunidad ContactoTipo = "' + @ContactoTipo + '" Contacto = "' + @Contacto + '" Usuario = "' + @Usuario + '" Empresa = "' + @Empresa + '" Fecha="' + @FechaXML  + '" Para="' + @ParaXML + '" Asunto="' + @AsuntoXML + '" Mensaje="' + @MensajeXML + '" ModuloID="' + @ModuloIDXML + '" Anexos="' + @AnexosXML +'" />' +
                   '  </Solicitud>' +
                   '</Intelisis>'
    
  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IntelisisServiceID OUTPUT                           
  
  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT OportunidadeMailHist (Fecha,     IntelisisServiceID,  Empresa,  ModuloID,  Asunto,  Mensaje,  Para,  Anexos,   ContactoTipo,  Contacto)
                 VALUES (GETDATE(), @IntelisisServiceID, @Empresa, @ModuloID, @Asunto, @Mensaje, @Para, @Anexos, @ContactoTipo, @Contacto) 	
    IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = 'OportunidadeMailHist'
  END                            
END
GO

--REQ16092
/**************** spOportunidadAnexo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'spOportunidadAnexo') DROP PROC spOportunidadAnexo
GO
CREATE PROC spOportunidadAnexo
		@EstacionTrabajo			int,
		@PlantillaeMail				varchar(20),
		@ID							int,
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(50),
		@MovID						varchar(50),
		@Movimiento					varchar(50),		
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
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT,
		@Anexos						varchar(max) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @RID					int,
		  @RIDAnt				int,
		  @Tipo					varchar(50),
		  @Ruta					varchar(255),
		  @Nombre				varchar(255),
		  @Existe				bit,
		  @Archivo				varchar(500),
		  @eDoc					varchar(max),
          @ManejadorObjeto		int, 
		  @IDArchivo			int,
		  @IDR					int,
		  @IDRAnt				int

  SELECT @Anexos = ''
  
  SELECT @RIDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @RID = MIN(RID)
      FROM OportunidadAnexo
     WHERE Plantilla = @PlantillaeMail
       AND RID > @RIDAnt

    --BUG15887
    SELECT @Ok = NULL

    IF @RID IS NULL BREAK
    
    SELECT @RIDAnt = @RID 
    
    SELECT @Tipo = Tipo, @Ruta = dbo.fnDirectorioEliminarDiagonalFinal(Ruta), @Nombre = Nombre FROM OportunidadAnexo WHERE Plantilla = @PlantillaeMail AND RID = @RID

    EXEC spOportunidadParsearMensaje @EstacionTrabajo, @PlantillaeMail, @ID, @Empresa, @Sucursal, @UEN, @Usuario, @Movimiento, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Ruta OUTPUT, @Nombre OUTPUT

    IF @Tipo = 'Especifico'
    BEGIN
      SELECT @Archivo = ISNULL(@Ruta, '') + '\' + ISNULL(@Nombre, '')    
      
      EXEC spVerificarArchivo @Archivo, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  
      
      IF @Existe = 0 SELECT @Ok = 1
    END
    ELSE IF @Tipo = 'Anexo'
    BEGIN
      SELECT @Archivo = ''

      EXEC spAnexoMovAdjuntarLista 'OPORT', @ID, @Nombre, @Archivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    END

    IF @Ok IS NULL AND RTRIM(ISNULL(@Archivo, '')) <> '' -- BUG13650
      SELECT @Anexos = @Anexos + @Archivo + ';'    
  END

  IF RIGHT(@Anexos, 1) = ';'
    SELECT @Anexos = SUBSTRING(@Anexos, 1, LEN(@Anexos) - 1)        
END
GO

--REQ16092
/******************************* spOportunidadParsearMensaje *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadParsearMensaje') and type = 'P') drop procedure dbo.spOportunidadParsearMensaje
GO
CREATE PROCEDURE spOportunidadParsearMensaje
		@EstacionTrabajo			int,
		@PlantillaeMail				varchar(20),
		@ID							int,
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
		@OkRef						varchar(255) = NULL OUTPUT,
		-- 11326
		@RutaAnexo					varchar(255) = NULL OUTPUT,
		@NombreAnexo				varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE @Ahora				datetime,
		  @Hoy	 				datetime,
		  @ConsultaNombre		varchar(50),
		  @Valor				varchar(255)

  SET @Ahora = GETDATE()
  SET @Hoy = dbo.fnFechaSinHora(@Ahora)

  SET @Asunto = REPLACE(@Asunto,'<Empresa>',ISNULL(RTRIM(@Empresa),''))
  SET @Asunto = REPLACE(@Asunto,'<EmpresaNombre>',ISNULL(RTRIM(@EmpresaNombre),''))  
  SET @Asunto = REPLACE(@Asunto,'<Sucursal>',ISNULL(RTRIM(CONVERT(varchar,@Sucursal)),''))
  SET @Asunto = REPLACE(@Asunto,'<SucursalNombre>',ISNULL(RTRIM(@SucursalNombre),''))    
  SET @Asunto = REPLACE(@Asunto,'<UEN>',ISNULL(RTRIM(CONVERT(varchar,@UEN)),''))  
  SET @Asunto = REPLACE(@Asunto,'<UENNombre>',ISNULL(RTRIM(@UENNombre),''))    
  SET @Asunto = REPLACE(@Asunto,'<Usuario>',ISNULL(RTRIM(@Usuario),''))  
  SET @Asunto = REPLACE(@Asunto,'<UsuarioNombre>',ISNULL(RTRIM(@UsuarioNombre),''))    
  SET @Asunto = REPLACE(@Asunto,'<Movimiento>',ISNULL(RTRIM(@Mov),''))    
  SET @Asunto = REPLACE(@Asunto,'<Estatus>',ISNULL(RTRIM(@Estatus),''))      
  SET @Asunto = REPLACE(@Asunto,'<Situacion>',ISNULL(RTRIM(@Situacion),''))        
  SET @Asunto = REPLACE(@Asunto,'<Proyecto>',ISNULL(RTRIM(@Proyecto),''))          
  SET @Asunto = REPLACE(@Asunto,'<ContactoTipo>',ISNULL(RTRIM(@ContactoTipo),''))            
  SET @Asunto = REPLACE(@Asunto,'<Contacto>',ISNULL(RTRIM(@Contacto),''))              
  SET @Asunto = REPLACE(@Asunto,'<Importe>',ISNULL(RTRIM(CONVERT(varchar, CONVERT(money, @Importe), 1)),'')) 
  SET @Asunto = REPLACE(@Asunto,'<ContactoNombre>',ISNULL(RTRIM(@ContactoNombre),''))                
  SET @Asunto = REPLACE(@Asunto,'<Hoy>',ISNULL(RTRIM(CONVERT(varchar,@Hoy)),''))                
  SET @Asunto = REPLACE(@Asunto,'<Ahora>',ISNULL(RTRIM(CONVERT(varchar,@Ahora)),''))                  
  SET @Asunto = REPLACE(@Asunto,'<FechaEmision>',ISNULL(RTRIM(CONVERT(varchar,@FechaEmision)),''))                    
  SET @Asunto = REPLACE(@Asunto,'<Modulo>', 'Oportunidades')
  SET @Asunto = REPLACE(@Asunto,'<ID>',ISNULL(RTRIM(CONVERT(varchar,@ID)),''))                    
    
  SET @Mensaje = REPLACE(@Mensaje,'<Modulo>', 'Oportunidades')
  SET @Mensaje = REPLACE(@Mensaje,'<Empresa>',ISNULL(RTRIM(@Empresa),''))
  SET @Mensaje = REPLACE(@Mensaje,'<EmpresaNombre>',ISNULL(RTRIM(@EmpresaNombre),''))  
  SET @Mensaje = REPLACE(@Mensaje,'<Sucursal>',ISNULL(RTRIM(CONVERT(varchar,@Sucursal)),''))
  SET @Mensaje = REPLACE(@Mensaje,'<SucursalNombre>',ISNULL(RTRIM(@SucursalNombre),''))    
  SET @Mensaje = REPLACE(@Mensaje,'<UEN>',ISNULL(RTRIM(CONVERT(varchar,@UEN)),''))  
  SET @Mensaje = REPLACE(@Mensaje,'<UENNombre>',ISNULL(RTRIM(@UENNombre),''))    
  SET @Mensaje = REPLACE(@Mensaje,'<Usuario>',ISNULL(RTRIM(@Usuario),''))  
  SET @Mensaje = REPLACE(@Mensaje,'<UsuarioNombre>',ISNULL(RTRIM(@UsuarioNombre),''))    
  SET @Mensaje = REPLACE(@Mensaje,'<Movimiento>',ISNULL(RTRIM(@Mov),''))    
  SET @Mensaje = REPLACE(@Mensaje,'<Estatus>',ISNULL(RTRIM(@Estatus),''))      
  SET @Mensaje = REPLACE(@Mensaje,'<Situacion>',ISNULL(RTRIM(@Situacion),''))        
  SET @Mensaje = REPLACE(@Mensaje,'<Proyecto>',ISNULL(RTRIM(@Proyecto),''))          
  SET @Mensaje = REPLACE(@Mensaje,'<ContactoTipo>',ISNULL(RTRIM(@ContactoTipo),''))            
  SET @Mensaje = REPLACE(@Mensaje,'<Contacto>',ISNULL(RTRIM(@Contacto),''))              
  SET @Mensaje = REPLACE(@Mensaje,'<Importe>',ISNULL(RTRIM(CONVERT(varchar, CONVERT(money, @Importe), 1)),'')) 
  SET @Mensaje = REPLACE(@Mensaje,'<ContactoNombre>',ISNULL(RTRIM(@ContactoNombre),''))              
  SET @Mensaje = REPLACE(@Mensaje,'<Hoy>',ISNULL(RTRIM(CONVERT(varchar,@Hoy)),''))                  
  SET @Mensaje = REPLACE(@Mensaje,'<Ahora>',ISNULL(RTRIM(CONVERT(varchar,@Ahora)),''))                    
  SET @Mensaje = REPLACE(@Mensaje,'<FechaEmision>',ISNULL(RTRIM(CONVERT(varchar,@FechaEmision)),''))                    
  SET @Mensaje = REPLACE(@Mensaje,'<ID>',ISNULL(RTRIM(CONVERT(varchar,@ID)),''))                    
	
  -- 11326
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Empresa>',ISNULL(RTRIM(@Empresa),''))
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<EmpresaNombre>',ISNULL(RTRIM(@EmpresaNombre),''))  
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Sucursal>',ISNULL(RTRIM(CONVERT(varchar,@Sucursal)),''))
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<SucursalNombre>',ISNULL(RTRIM(@SucursalNombre),''))    
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<UEN>',ISNULL(RTRIM(CONVERT(varchar,@UEN)),''))  
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<UENNombre>',ISNULL(RTRIM(@UENNombre),''))    
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Usuario>',ISNULL(RTRIM(@Usuario),''))  
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<UsuarioNombre>',ISNULL(RTRIM(@UsuarioNombre),''))    
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Movimiento>',ISNULL(RTRIM(@Mov),''))    
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Estatus>',ISNULL(RTRIM(@Estatus),''))      
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Situacion>',ISNULL(RTRIM(@Situacion),''))        
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Proyecto>',ISNULL(RTRIM(@Proyecto),''))          
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<ContactoTipo>',ISNULL(RTRIM(@ContactoTipo),''))            
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Contacto>',ISNULL(RTRIM(@Contacto),''))              
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Importe>',ISNULL(RTRIM(CONVERT(varchar, CONVERT(money, @Importe), 1)),'')) 
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<ContactoNombre>',ISNULL(RTRIM(@ContactoNombre),''))              
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Hoy>',ISNULL(RTRIM(CONVERT(varchar,@Hoy)),''))                  
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Ahora>',ISNULL(RTRIM(CONVERT(varchar,@Ahora)),''))                    
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<FechaEmision>',ISNULL(RTRIM(CONVERT(varchar,@FechaEmision)),''))   
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Modulo>', 'Oportunidades')
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<ID>',ISNULL(RTRIM(CONVERT(varchar,@ID)),''))                    
    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Empresa>',ISNULL(RTRIM(@Empresa),''))
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<EmpresaNombre>',ISNULL(RTRIM(@EmpresaNombre),''))  
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Sucursal>',ISNULL(RTRIM(CONVERT(varchar,@Sucursal)),''))
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<SucursalNombre>',ISNULL(RTRIM(@SucursalNombre),''))    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<UEN>',ISNULL(RTRIM(CONVERT(varchar,@UEN)),''))  
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<UENNombre>',ISNULL(RTRIM(@UENNombre),''))    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Usuario>',ISNULL(RTRIM(@Usuario),''))  
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<UsuarioNombre>',ISNULL(RTRIM(@UsuarioNombre),''))    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Movimiento>',ISNULL(RTRIM(@Mov),''))    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Estatus>',ISNULL(RTRIM(@Estatus),''))      
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Situacion>',ISNULL(RTRIM(@Situacion),''))        
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Proyecto>',ISNULL(RTRIM(@Proyecto),''))          
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<ContactoTipo>',ISNULL(RTRIM(@ContactoTipo),''))            
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Contacto>',ISNULL(RTRIM(@Contacto),''))              
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Importe>',ISNULL(RTRIM(CONVERT(varchar, CONVERT(money, @Importe), 1)),'')) 
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<ContactoNombre>',ISNULL(RTRIM(@ContactoNombre),''))              
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Hoy>',ISNULL(RTRIM(CONVERT(varchar,@Hoy)),''))                  
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Ahora>',ISNULL(RTRIM(CONVERT(varchar,@Ahora)),''))                    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<FechaEmision>',ISNULL(RTRIM(CONVERT(varchar,@FechaEmision)),''))
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Modulo>', 'Oportunidades')
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<ID>',ISNULL(RTRIM(CONVERT(varchar,@ID)),''))
  
  SELECT @Mensaje = REPLACE(@Mensaje,'<','&#060;')  
  SELECT @Mensaje = REPLACE(@Mensaje,'>','&#062;')  
END
GO

--REQ16092
/**************** spOportunidadeMailEnviarRegistro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadeMailEnviarRegistro') and type = 'P') drop procedure dbo.spOportunidadeMailEnviarRegistro
GO
CREATE PROC spOportunidadeMailEnviarRegistro
			@ID					int,
			@Usuario			varchar(10),
			@EstacionTrabajo	int,
			@RID				int,
			@PlantillaeMail		varchar(20),
			@Ok					int			 = NULL OUTPUT,
			@OkRef				varchar(255) = NULL OUTPUT					
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Cliente					varchar(10),
		  @eMail					varchar(100),
		  @Empresa					varchar(5),
		  @Sucursal					int,
		  @UEN						int,
		  @Mov						varchar(20),
		  @MovID					varchar(20),  
		  @Estatus					varchar(15),
		  @Situacion				varchar(50),
		  @Proyecto					varchar(50),  
		  @ContactoTipo				varchar(20),    
		  @Contacto					varchar(10),      
		  @Importe					float,
		  @FechaEmision				datetime,
		  @Asunto					varchar(255),
		  @Mensaje					varchar(max),
		  @Ruta						varchar(max),
		  @Anexo					varchar(max),
		  @EmpresaNombre			varchar(100),
		  @SucursalNombre			varchar(100),
		  @UENNombre				varchar(100),  
		  @UsuarioNombre			varchar(100),
		  @ContactoNombre			varchar(100),
		  @Vencimiento				datetime,
		  @FechaRegistro			datetime,
		  @Movimiento				varchar(50),
		  -- 11326
		  @Anexos					varchar(8000)
  
  EXEC spMovInfo @ID, 'OPORT', @Empresa = @Empresa OUTPUT, @Sucursal = @Sucursal OUTPUT, @UEN = @UEN OUTPUT, @Mov = @Mov OUTPUT, @MovID = @MovID OUTPUT, @Estatus = @Estatus OUTPUT, @Situacion = @Situacion OUTPUT, @Proyecto = @Proyecto OUTPUT, @CtoTipo = @ContactoTipo OUTPUT, @Contacto = @Contacto OUTPUT, @Importe = @Importe OUTPUT, @FechaEmision = @FechaEmision OUTPUT, @Vencimiento = @Vencimiento OUTPUT, @FechaRegistro = @FechaRegistro OUTPUT

  SELECT @Asunto = Asunto,
	     @Mensaje = Mensaje
	FROM OportunidadPlantillaeMail
	JOIN OportunidadPlantillaeMailMensaje ON OportunidadPlantillaeMail.ID = OportunidadPlantillaeMailMensaje.ID
   WHERE OportunidadPlantillaeMail.Plantilla = @PlantillaeMail

  SELECT @Contacto =  OportunidadeMailEnviar.Cliente,
		 @ContactoTipo = OportunidadeMailEnviar.ContactoTipo,
		 @eMail = CteCto.eMail
    FROM OportunidadeMailEnviar 
    JOIN Cte ON OportunidadeMailEnviar.Cliente = Cte.Cliente
    JOIN CteCto ON Cte.Cliente = CteCto.Cliente AND CteCto.ID = OportunidadeMailEnviar.ID AND CteCto.Cliente = OportunidadeMailEnviar.Cliente
   WHERE RID = @RID

  SET @Empresa      = ISNULL(@Empresa,'')
  SET @Sucursal     = ISNULL(@Sucursal,-1)
  SET @UEN          = ISNULL(@UEN,-1)
  SET @Usuario      = ISNULL(@Usuario,'')
  SET @Mov          = LTRIM(RTRIM(ISNULL(@Mov,'')))
  SET @MovID        = LTRIM(RTRIM(ISNULL(@MovID,'')))  
  SET @Estatus      = ISNULL(@Estatus,'')
  SET @Situacion    = ISNULL(@Situacion,'')
  SET @Proyecto     = ISNULL(@Proyecto,'')  
  SET @ContactoTipo = ISNULL(@ContactoTipo,'')    
  SET @Contacto     = ISNULL(@Contacto,'')      
  SET @Importe      = ISNULL(@Importe,0.0)
  SET @Vencimiento  = ISNULL(@Vencimiento,@FechaEmision)

  --BUG15884
  IF @FechaRegistro IS NULL
    SELECT @FechaRegistro = GETDATE()
  
  SET @Movimiento = @Mov + ' ' + @MovID  
  
  SELECT @EmpresaNombre  = ISNULL(Nombre,'') FROM Empresa WHERE Empresa = @Empresa     
  SELECT @SucursalNombre = ISNULL(Nombre,'') FROM Sucursal WHERE Sucursal = @Sucursal  
  SELECT @UENNombre      = ISNULL(Nombre,'') FROM UEN WHERE UEN = @UEN  
  SELECT @UsuarioNombre  = ISNULL(Nombre,'') FROM Usuario WHERE Usuario = @Usuario    
  SELECT @ContactoNombre = ISNULL(Nombre,'') FROM Cte WHERE Cliente = @Contacto

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)      
    EXEC spOportunidadParsearMensaje @EstacionTrabajo, @PlantillaeMail, @ID, @Empresa, @Sucursal, @UEN, @Usuario, @Movimiento, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, @Asunto OUTPUT, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
    EXEC spOportunidadAnexo @EstacionTrabajo, @PlantillaeMail, @ID, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @MovID, @Movimiento, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, @Ok OUTPUT, @OkRef OUTPUT, @Anexos OUTPUT

  IF @Ok IS NULL 
    EXEC spOportunidadInsertarIS @Empresa, @Usuario, @ContactoTipo, @Contacto, @ID, @FechaRegistro, @eMail, @Asunto, @Mensaje, @Anexos, @Ok OUTPUT, @OkRef OUTPUT

  RETURN 
END
GO

--REQ16092
/**************** spOportunidadeMailEnviar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadeMailEnviar') and type = 'P') drop procedure dbo.spOportunidadeMailEnviar
GO
CREATE PROC spOportunidadeMailEnviar 
			@ID					int,
			@Usuario			varchar(10),
			@EstacionTrabajo	int,
			@PlantillaeMail		varchar(20),
			@Ok					int			 = NULL OUTPUT,
			@OkRef				varchar(255) = NULL OUTPUT					
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @RID			int,
		  @RIDAnt		int,
		  @OkDesc		varchar(255),
		  @OkTipo		varchar(50)

  IF ISNULL(@PlantillaeMail, '') = ''
    SELECT @Ok = 14084

  IF @Ok IS NULL AND (SELECT COUNT(*) FROM OportunidadPlantillaeMail WHERE Plantilla = @PlantillaeMail) = 0
    SELECT @Ok = 14085, @OkRef = @PlantillaeMail

  IF @Ok IS NULL AND (SELECT ISNULL(Estatus, '') FROM OportunidadPlantillaeMail WHERE Plantilla = @PlantillaeMail) <> 'Activa'
    SELECT @Ok = 14086, @OkRef = @PlantillaeMail    
    
  SELECT @RIDAnt = 0
  WHILE(1=1) AND @Ok IS NULL
  BEGIN
    SELECT @RID = MIN(RID)
      FROM OportunidadeMailEnviar
     WHERE EstacionTrabajo = @EstacionTrabajo
       AND RID > @RIDAnt
       AND ISNULL(Enviar, 0) = 1

    IF @RID IS NULL BREAK
    
    SELECT @RIDAnt = @RID
    
    EXEC spOportunidadeMailEnviarRegistro @ID, @Usuario, @EstacionTrabajo, @RID, @PlantillaeMail, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  END

  IF @Ok IS NULL
  BEGIN
    SELECT @OkRef = NULL
  END
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

--REQ16092
/**************** spOportunidadReporteOpEstatus ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadReporteOpEstatus') and type = 'P') drop procedure dbo.spOportunidadReporteOpEstatus
GO
CREATE PROC spOportunidadReporteOpEstatus
			@Empresa	varchar(5),
			@Sucursal	int,
			@AgenteD	varchar(10),
			@AgenteA	varchar(10),
			@FechaD		datetime,
			@FechaA		datetime        
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Direccion2		varchar(100),
		  @Direccion3		varchar(100),
		  @Direccion4		varchar(100),
		  @Titulo			varchar(100),
		  @Reporte			varchar(500)

  DECLARE @Oportunidades TABLE(
    ID				int,
    RID				int			IDENTITY(1,1),
    ContactoTipo	varchar(20)	COLLATE DATABASE_DEFAULT NULL, 
    Contacto		varchar(10)	COLLATE DATABASE_DEFAULT NULL, 
    ContactoNombre	varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Estatus			varchar(15)	COLLATE DATABASE_DEFAULT NULL,
    Agente			varchar(10)	COLLATE DATABASE_DEFAULT NULL, 
    AgenteNombre	varchar(100)COLLATE DATABASE_DEFAULT NULL,  
    FechaEmision	datetime	NULL,
    Empresa			varchar(5)  COLLATE DATABASE_DEFAULT NULL,
    EmpresaNombre	varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion2		varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion3		varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion4		varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Titulo			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Reporte			varchar(500)COLLATE DATABASE_DEFAULT NULL
    )
 
  EXEC spContactoDireccionHorizontal @@SPID, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @@SPID

  --IF @Empresa IN ('', 'NULL', '(Todas)', '(Todos)') SELECT @Empresa = NULL
  IF @Sucursal IN (-1) SELECT @Sucursal = NULL
  IF @AgenteD IN ('', 'NULL', '(Todos)', '(Todas)') SELECT @AgenteD = NULL
  IF @AgenteA IN ('', 'NULL', '(Todos)', '(Todas)') SELECT @AgenteA = NULL

  SELECT @Titulo = 'Reporte de Oportunidades por Estatus'
  SELECT @Reporte = 'Sucursal: ' + ISNULL(CONVERT(varchar,@Sucursal), '(Todas)') + ' Del Agente: ' + ISNULL(CONVERT(varchar,@AgenteD), '(Todos)') + ' Al Agente: ' + ISNULL(CONVERT(varchar,@AgenteD), '(Todos)') + ' De la Fecha: ' + dbo.fnFormatearFecha(@FechaD, 'dd/MM/aaaa') + ' A la Fecha: ' + dbo.fnFormatearFecha(@FechaA, 'dd/MM/aaaa')
  
  INSERT INTO @Oportunidades(
		  ID,             ContactoTipo,             Contacto,             ContactoNombre, Estatus,             Agente,             AgenteNombre,  FechaEmision,              Direccion2,  Direccion3,  Direccion4,  Empresa, EmpresaNombre,   Titulo,  Reporte)
   SELECT Oportunidad.ID, Oportunidad.ContactoTipo, Oportunidad.Contacto, Cte.Nombre,     Oportunidad.Estatus, Oportunidad.Agente, Agente.Nombre, Oportunidad.FechaEmision, @Direccion2, @Direccion3, @Direccion4, @Empresa, Empresa.Nombre, @Titulo, @Reporte
     FROM Oportunidad
     JOIN Empresa ON Oportunidad.Empresa = Empresa.Empresa
     JOIN Cte ON Oportunidad.Contacto = Cte.Cliente
     JOIN MovTipo ON Oportunidad.Mov = MovTipo.Mov AND MovTipo.Modulo = 'OPORT'
     LEFT OUTER JOIN Agente ON Oportunidad.Agente = Agente.Agente
    WHERE Oportunidad.FechaEmision BETWEEN ISNULL(@FechaD, Oportunidad.FechaEmision) AND ISNULL(@FechaA, Oportunidad.FechaEmision)
      AND Oportunidad.Empresa = ISNULL(@Empresa, Oportunidad.Empresa)
      AND Oportunidad.Sucursal = ISNULL(@Sucursal, Oportunidad.Sucursal)
      AND ISNULL(Oportunidad.Agente,'') BETWEEN ISNULL(@AgenteD, ISNULL(Oportunidad.Agente,'')) AND ISNULL(@AgenteA, ISNULL(Oportunidad.Agente,''))
      AND Oportunidad.Estatus NOT IN ('CANCELADO', 'SINAFECTAR')
	  AND MovTipo.Clave = 'OPORT.O'

  SELECT * FROM @Oportunidades
  
  RETURN
END
GO

--REQ16092
/**************** spOportunidadAgenteLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadAgenteLista') and type = 'P') drop procedure dbo.spOportunidadAgenteLista
GO
CREATE PROC spOportunidadAgenteLista
--//WITH ENCRYPTION
AS 
BEGIN 
  DECLARE @ListaAgente TABLE(Agente varchar(10), Nombre varchar(100))
 
  INSERT INTO @ListaAgente(Agente, Nombre) VALUES('(Todos)', '(Todos)')
  INSERT INTO @ListaAgente SELECT Agente, Nombre FROM Agente WHERE Estatus='ALTA'
 
  SELECT Agente, Nombre FROM @ListaAgente
  
  RETURN
END
GO

--REQ16092
/**************** spOportunidadSucursalLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadSucursalLista') and type = 'P') drop procedure dbo.spOportunidadSucursalLista
GO
CREATE PROC spOportunidadSucursalLista
--//WITH ENCRYPTION
AS 
BEGIN 
  DECLARE @ListaSucursal TABLE(Sucursal int, Nombre varchar(100))
 
  INSERT INTO @ListaSucursal(Sucursal, Nombre) VALUES(-1, '(Todas)')
  INSERT INTO @ListaSucursal SELECT Sucursal, Nombre FROM Sucursal WHERE Estatus='ALTA'
 
  SELECT Sucursal, Nombre FROM @ListaSucursal
  
  RETURN
END
GO

--REQ16092
/**************** spOportunidadReporteOpEstatusD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadReporteOpEstatusD') and type = 'P') drop procedure dbo.spOportunidadReporteOpEstatusD
GO
CREATE PROC spOportunidadReporteOpEstatusD
			@Empresa   varchar(7),
			@Sucursal  int,
			@AgenteD   varchar(10),
			@AgenteA   varchar(10),
			@FechaD    datetime,
			@FechaA    datetime,
			@Estatus   varchar(50)        
--//WITH ENCRYPTION
AS 
BEGIN 
  DECLARE @Direccion2		varchar(100),
		  @Direccion3		varchar(100),
		  @Direccion4		varchar(100),
		  @Titulo			varchar(100),
		  @Reporte			varchar(500)
		  
  DECLARE @ProspectoxEtapa TABLE(
    ID					int,
    RID					int			IDENTITY(1,1),
    Movimiento			varchar(50)	COLLATE DATABASE_DEFAULT NULL, 
    ContactoTipo		varchar(20)	COLLATE DATABASE_DEFAULT NULL, 
    Contacto			varchar(10)	COLLATE DATABASE_DEFAULT NULL, 
    ContactoNombre		varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Estatus				varchar(15)	COLLATE DATABASE_DEFAULT NULL,
    Agente				varchar(10)	COLLATE DATABASE_DEFAULT NULL, 
    AgenteNombre		varchar(100)COLLATE DATABASE_DEFAULT NULL,  
    FechaActividad		datetime	NULL,
    Clave				varchar(50)	COLLATE DATABASE_DEFAULT NULL, 
    FechaEmision		datetime	NULL,  
    PorcentajeAvance	float		NULL,
    Empresa				varchar(5)  COLLATE DATABASE_DEFAULT NULL,
    EmpresaNombre		varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion2			varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion3			varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion4			varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Titulo				varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Reporte				varchar(500)COLLATE DATABASE_DEFAULT NULL    
    )  
     
  IF @Empresa IN ('', 'NULL', '(Todas)', '(Todos)') SELECT @Empresa = NULL
  IF @Sucursal IN (-1) SELECT @Sucursal = NULL
  IF @AgenteD IN ('', 'NULL', '(Todos)', '(Todas)') SELECT @AgenteD = NULL
  IF @AgenteA IN ('', 'NULL', '(Todos)', '(Todas)') SELECT @AgenteA = NULL

  SELECT @Titulo = 'Detalle de Oportunidades por Estatus'
  SELECT @Reporte = 'Estatus: ' + ISNULL(@Estatus, '') + ' Sucursal: ' + ISNULL(CONVERT(varchar,@Sucursal), '(Todas)') + ' Del Agente: ' + ISNULL(CONVERT(varchar,@AgenteD), '(Todos)') + ' Al Agente: ' + ISNULL(CONVERT(varchar,@AgenteD), '(Todos)') + ' De la Fecha: ' + dbo.fnFormatearFecha(@FechaD, 'dd/MM/aaaa') + ' A la Fecha: ' + dbo.fnFormatearFecha(@FechaA, 'dd/MM/aaaa')

  EXEC spContactoDireccionHorizontal @@SPID, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @@SPID
   
  INSERT INTO @ProspectoxEtapa(
		  ID,             Movimiento,                                          ContactoTipo,             Contacto,             ContactoNombre, Estatus,             Agente,             AgenteNombre,  FechaActividad,     Clave,              FechaEmision,              Direccion2,  Direccion3,  Direccion4,  Empresa, EmpresaNombre,   Titulo,  Reporte, PorcentajeAvance)
   SELECT Oportunidad.ID, RTRIM(Oportunidad.Mov)+' '+RTRIM(Oportunidad.MovID), Oportunidad.ContactoTipo, Oportunidad.Contacto, Cte.Nombre,     Oportunidad.Estatus, Oportunidad.Agente, Agente.Nombre, OportunidadD.Fecha, OportunidadD.Clave, Oportunidad.FechaEmision, @Direccion2, @Direccion3, @Direccion4, @Empresa, Empresa.Nombre, @Titulo, @Reporte, OportunidadD.PorcentajeAvance
     FROM Oportunidad
     JOIN OportunidadD ON Oportunidad.ID = OportunidadD.ID
     JOIN Empresa ON Oportunidad.Empresa = Empresa.Empresa
     JOIN Cte ON Oportunidad.Contacto = Cte.Cliente
     JOIN MovTipo ON Oportunidad.Mov = MovTipo.Mov AND MovTipo.Modulo = 'OPORT'
     LEFT OUTER JOIN Agente ON Oportunidad.Agente = Agente.Agente
    WHERE Oportunidad.FechaEmision BETWEEN ISNULL(@FechaD, Oportunidad.FechaEmision) AND ISNULL(@FechaA, Oportunidad.FechaEmision)
      AND Oportunidad.Empresa = ISNULL(@Empresa, Oportunidad.Empresa)
      AND Oportunidad.Sucursal = ISNULL(@Sucursal, Oportunidad.Sucursal)
      AND ISNULL(Oportunidad.Agente,'') BETWEEN ISNULL(@AgenteD, ISNULL(Oportunidad.Agente,'')) AND ISNULL(@AgenteA, ISNULL(Oportunidad.Agente,''))
      AND Oportunidad.Estatus NOT IN ('CANCELADO', 'SINAFECTAR')
      AND Oportunidad.Estatus = @Estatus
	  AND MovTipo.Clave = 'OPORT.O'
	        
  SELECT * FROM @ProspectoxEtapa
  
  RETURN
END
GO

--REQ16092
/**************** spOportunidadReportePipeline ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadReportePipeline') and type = 'P') drop procedure dbo.spOportunidadReportePipeline
GO
CREATE PROC spOportunidadReportePipeline
			@Empresa   varchar(5),
			@Sucursal  int,
			@AgenteD   varchar(10),
			@AgenteA   varchar(10),
			@FechaD    datetime,
			@FechaA    datetime,
			@Plantilla varchar(20),
			@Moneda    varchar(10)
--//WITH ENCRYPTION
AS BEGIN        
  DECLARE @Clave					varchar(50), 
		  @PorcentajePonderado		float,
		  @PorcentajeAvanceClave	float,
		  @PorcentajeAvance			float, 
		  @ImporteEstimadoClave		float,
		  @ImporteEstimado			float,
		  @ImporteOportunidad		float,
		  @EmpresaNombre			varchar(100),
		  @Direccion2				varchar(100),
		  @Direccion3				varchar(100),
		  @Direccion4				varchar(100),
		  @Titulo					varchar(100),
		  @Reporte					varchar(500)


  IF @Sucursal IN (-1) SELECT @Sucursal = NULL
  IF @AgenteD IN ('', 'NULL', '(Todos)', '(Todas)') SELECT @AgenteD = NULL
  IF @AgenteA IN ('', 'NULL', '(Todos)', '(Todas)') SELECT @AgenteA = NULL

  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  DECLARE @PipeLineProspectos TABLE(
    RID						int			IDENTITY(1,1),
    Clave					varchar(50) COLLATE DATABASE_DEFAULT NULL, 
    PorcentajePonderado		float		NULL, 
    PorcentajeAvanceClave	float		NULL, 
    PorcentajeAvance		float		NULL, 
    ImporteOportunidad		float		NULL,
    ImporteEstimadoClave	money		NULL,
    ImporteEstimado			money		NULL,
    NumLeadsClave			int			NULL, 
    Etiqueta				varchar(200)COLLATE DATABASE_DEFAULT NULL,
    Empresa					varchar(5)  COLLATE DATABASE_DEFAULT NULL,
    EmpresaNombre			varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion2				varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion3				varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion4				varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Titulo					varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Reporte					varchar(500)COLLATE DATABASE_DEFAULT NULL
    )
 
  EXEC spContactoDireccionHorizontal @@SPID, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @@SPID

  SELECT @Titulo = 'Pipeline de Oportunidades por Actividad'
  SELECT @Reporte = 'Sucursal: ' + ISNULL(CONVERT(varchar,@Sucursal), '(Todas)') + ' Del Agente: ' + ISNULL(CONVERT(varchar,@AgenteD), '(Todos)') + ' Al Agente: ' + ISNULL(CONVERT(varchar,@AgenteD), '(Todos)') + ' De la Fecha: ' + dbo.fnFormatearFecha(@FechaD, 'dd/MM/aaaa') + ' A la Fecha: ' + dbo.fnFormatearFecha(@FechaA, 'dd/MM/aaaa') + ' Plantilla: ' + ISNULL(CONVERT(varchar,@Plantilla), '') + ' Moneda: ' + ISNULL(CONVERT(varchar,@Moneda), '')
  
  -- Para hacer el calculo de la Clave    
  DECLARE crClaves CURSOR LOCAL STATIC FOR        
   SELECT OportunidadD.Clave, pd.PorcentajePonderado, OportunidadD.PorcentajeAvance, dbo.fnOportunidadAvance(Oportunidad.ID), Oportunidad.ImporteOportunidad*(dbo.fnOportunidadAvance(Oportunidad.ID)/100.0),
          Oportunidad.ImporteOportunidad
     FROM Oportunidad
     JOIN OportunidadD ON Oportunidad.ID = OportunidadD.ID
     JOIN Empresa ON Oportunidad.Empresa = Empresa.Empresa
     JOIN Cte ON Oportunidad.Contacto = Cte.Cliente
     JOIN MovTipo ON Oportunidad.Mov = MovTipo.Mov AND MovTipo.Modulo = 'OPORT'
     LEFT OUTER JOIN Agente ON Oportunidad.Agente = Agente.Agente
     JOIN OportunidadPlantilla p ON p.Plantilla = Oportunidad.Plantilla
     JOIN OportunidadPlantillaD pd ON p.ID = pd.ID AND pd.Tipo = OportunidadD.Tipo AND pd.Clave = OportunidadD.Clave
    WHERE Oportunidad.FechaEmision BETWEEN ISNULL(@FechaD, Oportunidad.FechaEmision) AND ISNULL(@FechaA, Oportunidad.FechaEmision)
      AND Oportunidad.Empresa = ISNULL(@Empresa, Oportunidad.Empresa)
      AND Oportunidad.Sucursal = ISNULL(@Sucursal, Oportunidad.Sucursal)
      AND ISNULL(Oportunidad.Agente,'') BETWEEN ISNULL(@AgenteD, ISNULL(Oportunidad.Agente,'')) AND ISNULL(@AgenteA, ISNULL(Oportunidad.Agente,''))
      AND Oportunidad.Estatus NOT IN ('CANCELADO', 'SINAFECTAR')
      AND Oportunidad.Moneda = ISNULL(@Moneda, Oportunidad.Moneda)    
      AND Oportunidad.Plantilla = @Plantilla
      AND Oportunidad.Estatus NOT IN ('CANCELADO', 'SINAFECTAR')
	  AND MovTipo.Clave = 'OPORT.O'
	  AND NULLIF(PorcentajeAvance, 0) IS NOT NULL
    ORDER BY pd.Renglon	  
	  
  OPEN crClaves        
  FETCH NEXT FROM crClaves INTO @Clave, @PorcentajePonderado, @PorcentajeAvanceClave, @PorcentajeAvance, @ImporteEstimado, @ImporteOportunidad
  WHILE @@FETCH_STATUS <> -1         
  BEGIN        
    IF @@FETCH_STATUS <> -2
    BEGIN        
      IF ISNULL(LEN(@Clave), 0) < 0 SELECT @Clave = 'No definida'    

      SELECT @ImporteEstimadoClave = ((@ImporteOportunidad*(@PorcentajePonderado/100.0))*(@PorcentajeAvanceClave/100.0))

      UPDATE @PipeLineProspectos    
         SET ImporteEstimadoClave = ISNULL(ImporteEstimadoClave, 0) + ISNULL(@ImporteEstimadoClave, 0),
             NumLeadsClave = ISNULL(NumLeadsClave, 0) + 1    
       WHERE ISNULL(Clave, '') = ISNULL(@Clave, '')

      IF @@ROWCOUNT = 0
        INSERT INTO @PipeLineProspectos(
				 Clave,  PorcentajePonderado,  PorcentajeAvanceClave,  PorcentajeAvance,  ImporteOportunidad,  ImporteEstimadoClave,  ImporteEstimado, NumLeadsClave)
         VALUES(@Clave, @PorcentajePonderado, @PorcentajeAvanceClave, @PorcentajeAvance, @ImporteOportunidad, @ImporteEstimadoClave, @ImporteEstimado, 1)
    END        
    FETCH NEXT FROM crClaves INTO @Clave, @PorcentajePonderado, @PorcentajeAvanceClave, @PorcentajeAvance, @ImporteEstimado, @ImporteOportunidad
  END        
  CLOSE crClaves        
  DEALLOCATE crClaves      
    
  UPDATE @PipeLineProspectos SET Clave = 'No definida' WHERE ISNULL(Clave, '') = ''    
    
  UPDATE @PipeLineProspectos
     SET Etiqueta = ISNULL(Clave, '') + '  ' + ISNULL(CONVERT(varchar(10), PorcentajePonderado), '') + '%',
		 Empresa = @Empresa,
		 EmpresaNombre = @EmpresaNombre,
		 Direccion2 = @Direccion2,
		 Direccion3 = @Direccion3,
		 Direccion4 = @Direccion4,
		 Titulo = @Titulo,
	     Reporte = @Reporte
    
  SELECT * FROM @PipeLineProspectos ORDER BY RID,PorcentajeAvanceClave, Clave    
RETURN    
END    
GO

--REQ16092
/**************** spOportunidadReportePipelineD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOportunidadReportePipelineD') and type = 'P') drop procedure dbo.spOportunidadReportePipelineD
GO
CREATE PROC spOportunidadReportePipelineD
			@Empresa	varchar(5),
			@Sucursal	int,
			@AgenteD	varchar(10),
			@AgenteA	varchar(10),
			@FechaD		datetime,
			@FechaA		datetime,
			@Plantilla	varchar(20),
			@Moneda		varchar(10),
			@Clave		varchar(50)
--//WITH ENCRYPTION
AS BEGIN        
  DECLARE @PorcentajePonderado		float,
		  @PorcentajeAvanceClave	float,
		  @PorcentajeAvance			float, 
		  @ImporteEstimadoClave		float,
		  @ImporteEstimado			float,
		  @ImporteOportunidad		float,
		  @EmpresaNombre			varchar(100),
		  @Direccion2				varchar(100),
		  @Direccion3				varchar(100),
		  @Direccion4				varchar(100),
		  @Titulo					varchar(100),
		  @Reporte					varchar(500),
		  @Agente					varchar(10),
		  @AgenteNombre				varchar(100),
		  @ContactoTipo				varchar(20),
		  @Contacto					varchar(10),
		  @ContactoNombre			varchar(100),
		  @Fecha					datetime

  IF @Sucursal IN (-1) SELECT @Sucursal = NULL
  IF @AgenteD IN ('', 'NULL', '(Todos)', '(Todas)') SELECT @AgenteD = NULL
  IF @AgenteA IN ('', 'NULL', '(Todos)', '(Todas)') SELECT @AgenteA = NULL
  IF @Clave IN ('', 'NULL', '(Todos)', '(Todas)') SELECT @Clave = NULL

  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  DECLARE @PipeLineProspectos TABLE(
    ID						int,
    RID						int			IDENTITY(1,1),
    Movimiento				varchar(50)	COLLATE DATABASE_DEFAULT NULL, 
    Agente					varchar(10) COLLATE DATABASE_DEFAULT NULL, 
    AgenteNombre			varchar(100)COLLATE DATABASE_DEFAULT NULL, 
    ContactoTipo			varchar(20) COLLATE DATABASE_DEFAULT NULL,
	Contacto				varchar(10) COLLATE DATABASE_DEFAULT NULL, 
	ContactoNombre			varchar(100)COLLATE DATABASE_DEFAULT NULL, 
    Clave					varchar(50) COLLATE DATABASE_DEFAULT NULL, 
    PorcentajePonderado		float		NULL, 
    PorcentajeAvanceClave	float		NULL, 
    PorcentajeAvance		float		NULL, 
    ImporteOportunidad		float		NULL,
    ImporteEstimadoClave	money		NULL,
    ImporteEstimado			money		NULL,
    NumLeadsClave			int			NULL, 
    Etiqueta				varchar(200)COLLATE DATABASE_DEFAULT NULL,
    Empresa					varchar(5)  COLLATE DATABASE_DEFAULT NULL,
    EmpresaNombre			varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion2				varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion3				varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Direccion4				varchar(100)COLLATE DATABASE_DEFAULT NULL,
    Titulo					varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Reporte					varchar(500)COLLATE DATABASE_DEFAULT NULL,
	Fecha					datetime
    )
 
  EXEC spContactoDireccionHorizontal @@SPID, 'Empresa', @Empresa, @Empresa, 1, 1, 1, 1
  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM ContactoDireccionHorizontal
   WHERE Estacion = @@SPID

  SELECT @Titulo = 'Pipeline de Oportunidades por Actividad'
  SELECT @Reporte = 'Actividad: ' + ISNULL(@Clave, '') + ' Sucursal: ' + ISNULL(CONVERT(varchar,@Sucursal), '(Todas)') + ' Del Agente: ' + ISNULL(CONVERT(varchar,@AgenteD), '(Todos)') + ' Al Agente: ' + ISNULL(CONVERT(varchar,@AgenteD), '(Todos)') + ' De la Fecha: ' + dbo.fnFormatearFecha(@FechaD, 'dd/MM/aaaa') + ' A la Fecha: ' + dbo.fnFormatearFecha(@FechaA, 'dd/MM/aaaa') + ' Plantilla: ' + ISNULL(CONVERT(varchar,@Plantilla), '') + ' Moneda: ' + ISNULL(CONVERT(varchar,@Moneda), '')
  
  -- Para hacer el calculo de la Clave    
  DECLARE crClaves CURSOR LOCAL STATIC FOR        
   SELECT OportunidadD.Clave, pd.PorcentajePonderado, OportunidadD.PorcentajeAvance, dbo.fnOportunidadAvance(Oportunidad.ID), Oportunidad.ImporteOportunidad*(dbo.fnOportunidadAvance(Oportunidad.ID)/100.0),
          Oportunidad.ImporteOportunidad, Oportunidad.Agente, Agente.Nombre, Oportunidad.ContactoTipo, Oportunidad.Contacto, Cte.Nombre, OportunidadD.Fecha
     FROM Oportunidad
     JOIN OportunidadD ON Oportunidad.ID = OportunidadD.ID
     JOIN Empresa ON Oportunidad.Empresa = Empresa.Empresa
     JOIN Cte ON Oportunidad.Contacto = Cte.Cliente
     JOIN MovTipo ON Oportunidad.Mov = MovTipo.Mov AND MovTipo.Modulo = 'OPORT'
     LEFT OUTER JOIN Agente ON Oportunidad.Agente = Agente.Agente
     JOIN OportunidadPlantilla p ON p.Plantilla = Oportunidad.Plantilla
     JOIN OportunidadPlantillaD pd ON p.ID = pd.ID AND pd.Tipo = OportunidadD.Tipo AND pd.Clave = OportunidadD.Clave
    WHERE Oportunidad.FechaEmision BETWEEN ISNULL(@FechaD, Oportunidad.FechaEmision) AND ISNULL(@FechaA, Oportunidad.FechaEmision)
      AND Oportunidad.Empresa = ISNULL(@Empresa, Oportunidad.Empresa)
      AND Oportunidad.Sucursal = ISNULL(@Sucursal, Oportunidad.Sucursal)
      AND ISNULL(Oportunidad.Agente,'') BETWEEN ISNULL(@AgenteD, ISNULL(Oportunidad.Agente,'')) AND ISNULL(@AgenteA, ISNULL(Oportunidad.Agente,''))
      AND Oportunidad.Estatus NOT IN ('CANCELADO', 'SINAFECTAR')
      AND Oportunidad.Moneda = ISNULL(@Moneda, Oportunidad.Moneda)    
      AND Oportunidad.Plantilla = @Plantilla
	  AND MovTipo.Clave = 'OPORT.O'
	  AND NULLIF(PorcentajeAvance, 0) IS NOT NULL	  
	  AND OportunidadD.Clave = ISNULL(@Clave,OportunidadD.Clave)
	  
  OPEN crClaves        
  FETCH NEXT FROM crClaves INTO @Clave, @PorcentajePonderado, @PorcentajeAvanceClave, @PorcentajeAvance, @ImporteEstimado, @ImporteOportunidad, @Agente, @AgenteNombre,
								@ContactoTipo, @Contacto, @ContactoNombre, @Fecha
  WHILE @@FETCH_STATUS <> -1         
  BEGIN        
    IF @@FETCH_STATUS <> -2
    BEGIN        
      IF ISNULL(LEN(@Clave), 0) < 0 SELECT @Clave = 'No definida'    

      SELECT @ImporteEstimadoClave = ((@ImporteOportunidad*(@PorcentajePonderado/100.0))*(@PorcentajeAvanceClave/100.0))

      UPDATE @PipeLineProspectos    
         SET ImporteEstimadoClave = ISNULL(ImporteEstimadoClave, 0) + ISNULL(@ImporteEstimadoClave, 0),
             NumLeadsClave = ISNULL(NumLeadsClave, 0) + 1    
       WHERE ISNULL(Clave, '') = ISNULL(@Clave, '')

      IF @@ROWCOUNT = 0
        INSERT INTO @PipeLineProspectos(
				 Clave,  PorcentajePonderado,  PorcentajeAvanceClave,  PorcentajeAvance,  ImporteOportunidad,  ImporteEstimadoClave,  ImporteEstimado, NumLeadsClave,  Agente,  AgenteNombre,  ContactoTipo,  Contacto,  ContactoNombre,  Fecha)
         VALUES(@Clave, @PorcentajePonderado, @PorcentajeAvanceClave, @PorcentajeAvance, @ImporteOportunidad, @ImporteEstimadoClave, @ImporteEstimado, 1,             @Agente, @AgenteNombre, @ContactoTipo, @Contacto, @ContactoNombre, @Fecha)
    END
    FETCH NEXT FROM crClaves INTO @Clave, @PorcentajePonderado, @PorcentajeAvanceClave, @PorcentajeAvance, @ImporteEstimado, @ImporteOportunidad, @Agente, @AgenteNombre,
								  @ContactoTipo, @Contacto, @ContactoNombre, @Fecha
  END        
  CLOSE crClaves        
  DEALLOCATE crClaves      
    
  UPDATE @PipeLineProspectos SET Clave = 'No definida' WHERE ISNULL(Clave, '') = ''    
    
  UPDATE @PipeLineProspectos
     SET Etiqueta = ISNULL(Clave, '') + '  ' + ISNULL(CONVERT(varchar(10), PorcentajePonderado), '') + '%',
		 Empresa = @Empresa,
		 EmpresaNombre = @EmpresaNombre,
		 Direccion2 = @Direccion2,
		 Direccion3 = @Direccion3,
		 Direccion4 = @Direccion4,
		 Titulo = @Titulo,
	     Reporte = @Reporte
    
  SELECT * FROM @PipeLineProspectos ORDER BY Clave,PorcentajeAvanceClave
RETURN    
END    
GO


/**************** spProductosPropuestaEconomica ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProductosPropuestaEconomica') and type = 'P') drop procedure dbo.spProductosPropuestaEconomica
GO
CREATE PROC spProductosPropuestaEconomica
@ID			INT
--//WITH ENCRYPTION
AS 
BEGIN 
  DECLARE
   @OrigenTipo			VARCHAR(20),
   @Origen	     		VARCHAR(20),
   @OrigenID			VARCHAR(20)

  SELECT @OrigenTipo=OrigenTipo, @Origen=Origen, @OrigenID=OrigenID FROM Venta WHERE ID=@ID

  CREATE TABLE #VentaCalcularPropEco
       (
		ID				    int,
		Renglon			    float null,
		MaterialServicio    varchar(100) null,
		Costo               money null,
		Descripcion         varchar(100) null,
		RenglonID		    int identity
		)
  -- Presupuestos Gastos
  -- SELECT * FROM *

  -- Presupuestos Compras
  INSERT INTO #VentaCalcularPropEco (ID, Renglon, MaterialServicio, Costo, Descripcion)
  SELECT @ID, NULL, b.Articulo, b.Costo+ISNULL(b.Impuesto1,0) Costo, c.Descripcion1
    FROM Compra a
	     LEFT OUTER JOIN CompraD b ON b.ID=a.ID
		 JOIN Art c ON c.Articulo = b.Articulo
   WHERE a.Estatus='CONCLUIDO'
         AND OrigenTipo=@OrigenTipo
		 AND Origen=@Origen
		 AND OrigenID=@OrigenID
 
    IF  (SELECT COUNT(*) FROM VentaCalcularPropEconomica WHERE ID=@ID)=0
	BEGIN
		INSERT INTO VentaCalcularPropEconomica (ID, Renglon, MaterialServicio, Costo, Descripcion, RenglonID)
		SELECT ID, Renglon, MaterialServicio, Costo, Descripcion, RenglonID FROM #VentaCalcularPropEco
	END
	
	--SELECT * FROM  VentaCalcularPropEconomica WHERE ID=@ID

  RETURN
END
GO


/**************** spPropuestaEconomicaActualizarCosto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPropuestaEconomicaActualizarCosto') and type = 'P') drop procedure dbo.spPropuestaEconomicaActualizarCosto
GO
CREATE PROC spPropuestaEconomicaActualizarCosto
@ID			INT,
@Estacion   INT,
@Renglon    FLOAT
--//WITH ENCRYPTION
AS 
BEGIN 
DECLARE
@Costo        money

SELECT @Costo=SUM(Costo) FROM VentaCalcularPropEconomica WHERE ID=@ID AND RenglonID IN (SELECT Clave FROM ListaST WHERE Estacion=@Estacion)
UPDATE VentaD SET Precio = Precio + ISNULL(@Costo,0)  WHERE ID=@ID AND Renglon=@Renglon

UPDATE VentaCalcularPropEconomica SET Renglon=@Renglon WHERE ID=@ID AND RenglonID IN (SELECT Clave FROM ListaST WHERE Estacion=@Estacion)

SELECT 'Asignación Correcta'

RETURN
END
GO
--EXEC spPropuestaEconomicaActualizarCosto 65904, 1, 2018

--PRINT "******************* SP Oportunidad ******************"
