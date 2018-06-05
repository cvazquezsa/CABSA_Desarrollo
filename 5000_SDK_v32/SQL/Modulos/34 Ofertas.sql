SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

-- fnRedondeoDecimales 'Función de redondeo de decimales, dependiendo de la configuración de la empresa'
/**************** fnRedondeoDecimales ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRedondeoDecimales' AND type = 'FN') DROP FUNCTION fnRedondeoDecimales
GO
CREATE FUNCTION fnRedondeoDecimales(@Empresa Varchar(5))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  RETURN (SELECT DecimalesCantidades FROM EmpresaGral WHERE Empresa = @Empresa)
END
GO

-- spOfertaFiltroAyuda 'Categoria Agente'
/**************** spOfertaFiltroAyuda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaFiltroAyuda') and type = 'P') drop procedure dbo.spOfertaFiltroAyuda
GO
CREATE PROCEDURE spOfertaFiltroAyuda
			@Campo		varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
--  IF @Campo = 'Empresa'  		SELECT 'Clave' = CONVERT(varchar(50), Empresa), 	'Nombre' = CONVERT(varchar(100), Nombre) FROM Empresa  		ELSE
--  IF @Campo = 'Sucursal' 		SELECT 'Clave' = CONVERT(varchar(50), Sucursal),	'Nombre' = CONVERT(varchar(100), Nombre) FROM Sucursal        	ELSE
--  IF @Campo = 'Region'   		SELECT 'Clave' = CONVERT(varchar(50), Region),  	'Nombre' = CONVERT(varchar(100), NULL)   FROM SucursalRegion 	ELSE
  IF @Campo = 'Almacen'  		    SELECT 'Clave' = CONVERT(varchar(50), Almacen), 	'Nombre' = CONVERT(varchar(100), Nombre) FROM Alm		    ELSE
  IF @Campo = 'Grupo Almacen'  		SELECT 'Clave' = CONVERT(varchar(50), Grupo), 		'Nombre' = CONVERT(varchar(100), NULL)   FROM AlmGrupo		ELSE
  IF @Campo = 'Cliente'  		    SELECT 'Clave' = CONVERT(varchar(50), Cliente), 	'Nombre' = CONVERT(varchar(100), Nombre) FROM Cte		    ELSE
  IF @Campo = 'Categoria Cliente'  	SELECT 'Clave' = CONVERT(varchar(50), Categoria), 	'Nombre' = CONVERT(varchar(100), NULL)   FROM CteCat		ELSE
  IF @Campo = 'Grupo Cliente'  		SELECT 'Clave' = CONVERT(varchar(50), Grupo), 		'Nombre' = CONVERT(varchar(100), NULL)   FROM CteGrupo		ELSE
  IF @Campo = 'Familia Cliente'  	SELECT 'Clave' = CONVERT(varchar(50), Familia), 	'Nombre' = CONVERT(varchar(100), NULL)   FROM CteFam		ELSE
  IF @Campo = 'Zona Cliente'  		SELECT 'Clave' = CONVERT(varchar(50), Zona), 		'Nombre' = CONVERT(varchar(100), NULL)   FROM Zona		    ELSE
  IF @Campo = 'Agente'  		    SELECT 'Clave' = CONVERT(varchar(50), Agente), 		'Nombre' = CONVERT(varchar(100), Nombre) FROM Agente		ELSE
  IF @Campo = 'Categoria Agente'  	SELECT 'Clave' = CONVERT(varchar(50), Categoria), 	'Nombre' = CONVERT(varchar(100), NULL)   FROM AgenteCat		ELSE
  IF @Campo = 'Grupo Agente'  		SELECT 'Clave' = CONVERT(varchar(50), Grupo), 		'Nombre' = CONVERT(varchar(100), NULL)   FROM AgenteGrupo	ELSE
  IF @Campo = 'Familia Agente'  	SELECT 'Clave' = CONVERT(varchar(50), Familia), 	'Nombre' = CONVERT(varchar(100), NULL)   FROM AgenteFam		ELSE
  IF @Campo = 'Movimiento'  		SELECT 'Clave' = CONVERT(varchar(50), Mov), 		'Nombre' = CONVERT(varchar(100), NULL)   FROM MovTipo WHERE Modulo = 'VTAS' ELSE
  IF @Campo = 'Moneda'  		    SELECT 'Clave' = CONVERT(varchar(50), Moneda), 		'Nombre' = CONVERT(varchar(100), Nombre) FROM Mon		    ELSE
  IF @Campo = 'Condicion Pago'  	SELECT 'Clave' = CONVERT(varchar(50), Condicion), 	'Nombre' = CONVERT(varchar(100), NULL)   FROM Condicion		ELSE
  IF @Campo = 'Tipo Forma Pago'  	SELECT 'Clave' = CONVERT(varchar(50), Tipo), 		'Nombre' = CONVERT(varchar(100), NULL)   FROM FormaPagoTipo	ELSE
  IF @Campo = 'Forma Envio'  		SELECT 'Clave' = CONVERT(varchar(50), FormaEnvio), 	'Nombre' = CONVERT(varchar(100), NULL)   FROM FormaEnvio	ELSE
  IF @Campo = 'Lista Precios'  		SELECT 'Clave' = CONVERT(varchar(50), Lista), 		'Nombre' = CONVERT(varchar(100), NULL)   FROM ListaPrecios  ELSE
  IF @Campo = 'Tipo de Servicio'    SELECT 'Clave' = CONVERT(varchar(50), Tipo), 	    'Nombre' = CONVERT(varchar(100), NULL)   FROM ServicioTipo  ELSE
  IF @Campo = 'Region'              SELECT 'Clave' = CONVERT(varchar(50), Region), 		'Nombre' = CONVERT(varchar(100), NULL)   FROM SucursalRegion    ELSE
  IF @Campo = 'Tipo de Contrato'    SELECT 'Clave' = CONVERT(varchar(50), Tipo), 		'Nombre' = CONVERT(varchar(100), NULL)   FROM VentaContratoTipo ELSE
  IF @Campo = 'Proyecto'            SELECT 'Clave' = CONVERT(varchar(50), Proyecto),    'Nombre' = CONVERT(varchar(100), Descripcion)   FROM Proy ELSE
                                    SELECT 'Clave' = CONVERT(varchar(50), NULL),        'Nombre' = CONVERT(varchar(100), NULL)
  RETURN
END
GO
--EXEC spOfertaTipoOrden 'Cambio Precio / Porcentaje','Precio/Costo','Porcentaje'
/**************** spOfertaTipoOrden ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaTipoOrden') and type = 'P') drop procedure dbo.spOfertaTipoOrden
GO
CREATE PROCEDURE spOfertaTipoOrden
			@Tipo		varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
DECLARE 
	@Forma		varchar(50),
	@Usar		varchar(50),
	@Numero		int,
	@Limite		int

	DECLARE @Valores TABLE(Orden int NULL)

	SET @Limite = 20
	
	IF ISNULL(@Forma,'') = ''
		SELECT @Forma = Forma, @Usar = Usar
		  FROM OfertaTipo
		 WHERE Tipo = @Tipo

	
	SET @Numero = 1
	WHILE @Numero <= @Limite
	BEGIN
		INSERT INTO @Valores(Orden)
	         VALUES (@Numero)
	
		SET @Numero = @Numero + 1
	END

  IF UPPER(@Forma) IN('PRECIO','PRECIO/COSTO','PRECIO/LISTA','DESCUENTO')
  DELETE @Valores
    FROM @Valores v
    JOIN OfertaTipo t ON v.Orden = t.Orden
   WHERE UPPER(t.Forma) IN('PRECIO','PRECIO/COSTO','PRECIO/LISTA','DESCUENTO') 
     AND UPPER(t.Tipo) <> UPPER(@Tipo)

  IF UPPER(@Forma) IN('IMPORTE/PUNTOS','PUNTOS','PUNTOS/PRECIO')
  DELETE @Valores
    FROM @Valores v
    JOIN OfertaTipo t ON v.Orden = t.Orden
   WHERE UPPER(t.Forma) IN('IMPORTE/PUNTOS','PUNTOS','PUNTOS/PRECIO')
     AND UPPER(t.Tipo) <> UPPER(@Tipo)

  IF UPPER(@Forma) IN('COMISION','OBSEQUIO MISMO ARTICULO','OBSEQUIO OTRO ARTICULO','PRECIO SIMILAR','DESCUENTO CASCADA','MISMO ARTICULO POR MONTO','OTRO ARTICULO POR MONTO')
  DELETE @Valores
    FROM @Valores v
    JOIN OfertaTipo t ON v.Orden = t.Orden
   WHERE UPPER(t.Forma) IN('COMISION','OBSEQUIO MISMO ARTICULO','OBSEQUIO OTRO ARTICULO','PRECIO SIMILAR','DESCUENTO CASCADA','MISMO ARTICULO POR MONTO','OTRO ARTICULO POR MONTO')
     AND UPPER(t.Tipo) <> UPPER(@Tipo)

  SELECT Orden FROM @Valores

  RETURN
END
GO
/**************** spOfertaFiltroClaveAyuda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaFiltroClaveAyuda') and type = 'P') drop procedure dbo.spOfertaFiltroClaveAyuda
GO
CREATE PROCEDURE spOfertaFiltroClaveAyuda
			@Campo		varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
--  IF @Campo = 'Empresa'  		SELECT 'Clave' = CONVERT(varchar(50), Empresa) 		FROM Empresa  		ORDER BY Empresa  ELSE
--  IF @Campo = 'Sucursal' 		SELECT 'Clave' = CONVERT(varchar(50), Sucursal)		FROM Sucursal        	ORDER BY Sucursal ELSE
--  IF @Campo = 'Region'   		SELECT 'Clave' = CONVERT(varchar(50), Region)	  	FROM SucursalRegion 	ORDER BY Region   ELSE
  IF @Campo = 'Almacen'  		    SELECT 'Clave' = CONVERT(varchar(50), Almacen)	 	FROM Alm		    ORDER BY Almacen  ELSE
  IF @Campo = 'Grupo Almacen'  		SELECT 'Clave' = CONVERT(varchar(50), Grupo)		FROM AlmGrupo	    ORDER BY Grupo    ELSE
  IF @Campo = 'Cliente'  		    SELECT 'Clave' = CONVERT(varchar(50), 'Oprima F9 para ver la Lista de Clientes') ELSE
  IF @Campo = 'Categoria Cliente'  	SELECT 'Clave' = CONVERT(varchar(50), Categoria) 	FROM CteCat		    ORDER BY Categoria ELSE
  IF @Campo = 'Grupo Cliente'  		SELECT 'Clave' = CONVERT(varchar(50), Grupo) 		FROM CteGrupo	    ORDER BY Grupo    ELSE
  IF @Campo = 'Familia Cliente'  	SELECT 'Clave' = CONVERT(varchar(50), Familia) 		FROM CteFam		    ORDER BY Familia  ELSE
  IF @Campo = 'Zona Cliente'  		SELECT 'Clave' = CONVERT(varchar(50), Zona) 		FROM Zona		    ORDER BY Zona     ELSE
  IF @Campo = 'Agente'  		    SELECT 'Clave' = CONVERT(varchar(50), Agente) 		FROM Agente		    ORDER BY Agente   ELSE
  IF @Campo = 'Categoria Agente'  	SELECT 'Clave' = CONVERT(varchar(50), Categoria) 	FROM AgenteCat		ORDER BY Categoria ELSE
  IF @Campo = 'Grupo Agente'  		SELECT 'Clave' = CONVERT(varchar(50), Grupo) 		FROM AgenteGrupo	ORDER BY Grupo    ELSE
  IF @Campo = 'Familia Agente'  	SELECT 'Clave' = CONVERT(varchar(50), Familia) 		FROM AgenteFam		ORDER BY Familia  ELSE
  IF @Campo = 'Movimiento'  		SELECT 'Clave' = CONVERT(varchar(50), Mov) 		    FROM MovTipo WHERE Modulo = 'VTAS' ORDER BY Mov ELSE
  IF @Campo = 'Moneda'  		    SELECT 'Clave' = CONVERT(varchar(50), Moneda) 		FROM Mon		    ORDER BY Moneda ELSE
  IF @Campo = 'Condicion Pago'  	SELECT 'Clave' = CONVERT(varchar(50), Condicion) 	FROM Condicion		ORDER BY Condicion ELSE
  IF @Campo = 'Tipo Forma Pago'  	SELECT 'Clave' = CONVERT(varchar(50), Tipo) 		FROM FormaPagoTipo	ORDER BY Tipo       ELSE
  IF @Campo = 'Forma Envio'  		SELECT 'Clave' = CONVERT(varchar(50), FormaEnvio) 	FROM FormaEnvio	    ORDER BY FormaEnvio ELSE
  IF @Campo = 'Lista Precios'  		SELECT 'Clave' = CONVERT(varchar(50), Lista) 		FROM ListaPrecios   ORDER BY Lista ELSE
  IF @Campo = 'Tipo de Servicio'    SELECT 'Clave' = CONVERT(varchar(50), Tipo)  	    FROM ServicioTipo ORDER BY Tipo  ELSE
  IF @Campo = 'Region'              SELECT 'Clave' = CONVERT(varchar(50), Region)       FROM SucursalRegion ORDER BY Region  ELSE
  IF @Campo = 'Tipo de Contrato'    SELECT 'Clave' = CONVERT(varchar(50), Tipo)         FROM VentaContratoTipo ELSE
  IF @Campo = 'Proyecto'            SELECT 'Clave' = CONVERT(varchar(50), Proyecto)     FROM Proy ELSE
                                    SELECT 'Clave' = CONVERT(varchar(50), NULL)
  RETURN
END
GO

-- spOfertaArtAyuda 'Categoria Articulo'
/**************** spOfertaArtAyuda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaArtAyuda') and type = 'P') drop procedure dbo.spOfertaArtAyuda
GO
/*CREATE PROCEDURE spOfertaArtAyuda
			@Campo		varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
  IF @Campo = 'Articulo'  		SELECT 'Clave' = CONVERT(varchar(50), Articulo), 	'Nombre' = CONVERT(varchar(100), Descripcion1) 	FROM Art  				ELSE
  IF @Campo = 'Rama' 			SELECT 'Clave' = CONVERT(varchar(50), Articulo), 	'Nombre' = CONVERT(varchar(100), Descripcion1) 	FROM Art WHERE Tipo = 'Estructura'	ELSE
  IF @Campo = 'Categoria Articulo'  	SELECT 'Clave' = CONVERT(varchar(50), Categoria), 	'Nombre' = CONVERT(varchar(100), NULL)   	FROM ArtCat		ELSE
  IF @Campo = 'Grupo Articulo'  	SELECT 'Clave' = CONVERT(varchar(50), Grupo), 		'Nombre' = CONVERT(varchar(100), NULL)   	FROM ArtGrupo		ELSE
  IF @Campo = 'Familia Articulo'  	SELECT 'Clave' = CONVERT(varchar(50), Familia), 	'Nombre' = CONVERT(varchar(100), NULL)   	FROM ArtFam		ELSE
  IF @Campo = 'Linea Articulo'  	SELECT 'Clave' = CONVERT(varchar(50), Linea), 		'Nombre' = CONVERT(varchar(100), NULL)   	FROM ArtLinea		ELSE
  IF @Campo = 'Fabricante'  		SELECT 'Clave' = CONVERT(varchar(50), Fabricante), 	'Nombre' = CONVERT(varchar(100), NULL)   	FROM Fabricante
  ELSE SELECT 'Clave' = CONVERT(varchar(50), NULL), 'Nombre' = CONVERT(varchar(100), NULL)
  RETURN
END*/
GO


/**************** spOfertaArtClaveAyuda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaArtClaveAyuda') and type = 'P') drop procedure dbo.spOfertaArtClaveAyuda
GO
/*CREATE PROCEDURE spOfertaArtClaveAyuda
			@Campo		varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
  IF @Campo = 'Articulo'  		SELECT 'Clave' = CONVERT(varchar(50), 'Oprima F9 para ver la Lista de Articulos') ELSE
  IF @Campo = 'Rama' 			SELECT 'Clave' = CONVERT(varchar(50), Articulo) 	FROM Art WHERE Tipo = 'Estructura'	ORDER BY Articulo ELSE
  IF @Campo = 'Categoria Articulo'  	SELECT 'Clave' = CONVERT(varchar(50), Categoria) 	FROM ArtCat		ORDER BY Categoria ELSE
  IF @Campo = 'Grupo Articulo'  	SELECT 'Clave' = CONVERT(varchar(50), Grupo) 		FROM ArtGrupo		ORDER BY Grupo ELSE
  IF @Campo = 'Familia Articulo'  	SELECT 'Clave' = CONVERT(varchar(50), Familia) 		FROM ArtFam		ORDER BY Familia ELSE
  IF @Campo = 'Linea Articulo'  	SELECT 'Clave' = CONVERT(varchar(50), Linea) 		FROM ArtLinea		ORDER BY Linea ELSE
  IF @Campo = 'Fabricante'  		SELECT 'Clave' = CONVERT(varchar(50), Fabricante) 	FROM Fabricante         ORDER BY Fabricante
  ELSE SELECT 'Clave' = CONVERT(varchar(50), NULL)
  RETURN
END*/
GO



/**************** spOfertaVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaVerificar') and type = 'P') drop procedure dbo.spOfertaVerificar
GO
CREATE PROCEDURE spOfertaVerificar
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

		    @FechaD			datetime,
		    @FechaA			datetime,

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @CfgOfertaNivelOpcion		bit, 
  @Articulo					varchar(20),
  @SubCuenta				varchar(50)
  
  SELECT @CfgOfertaNivelOpcion = ISNULL(OfertaNivelOpcion, 0)
    FROM EmpresaCfg2 ec
   WHERE ec.Empresa = @Empresa

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END ELSE 
  BEGIN
    IF @Ok IS NULL AND dbo.fnEstaVencido(@FechaEmision, @FechaA) = 1 SELECT @Ok = 10095
    ELSE
    IF @Ok IS NULL
    BEGIN
      IF @CfgOfertaNivelOpcion = 1
      BEGIN
      	SELECT @Articulo = Min(od.Articulo), @SubCuenta = Min(ISNULL(od.SubCuenta, ''))
      	  FROM OfertaD od
      	 WHERE id = @ID
      	 GROUP BY od.Articulo, ISNULL(od.SubCuenta, '')
        HAVING COUNT(od.Articulo) > 1
      	
      	IF @Articulo IS NOT NULL
      	  SELECT @OK = 10060, @OkRef = 'Producto Duplicado ' + RTRIM(@Articulo) + ' Opción ' + RTRIM(@SubCuenta)
      END
      ELSE
      BEGIN
      	SELECT @Articulo = Min(od.Articulo)
      	  FROM OfertaD od
      	 WHERE id = @ID
      	 GROUP BY od.Articulo
        HAVING COUNT(od.Articulo) > 1
      	
      	IF @Articulo IS NOT NULL
      	  SELECT @OK = 10060, @OkRef = 'Producto Duplicado ' + RTRIM(@Articulo)
      END
    END
  END
  RETURN
END
GO

/**************** spOfertaAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaAfectar') and type = 'P') drop procedure dbo.spOfertaAfectar
GO             
CREATE PROCEDURE spOfertaAfectar
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

		   @FechaD			datetime,
		   @FechaA			datetime,

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
  -- SET nocount ON
  DECLARE
    @FechaCancelacion		datetime,
    @GenerarMovTipo		char(20),
    @GenerarPeriodo		int,
    @GenerarEjercicio		int

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
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, 'SINAFECTAR', 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT
    IF @Ok IS NULL SELECT @Ok = 80030
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

    IF @Accion IN ('AFECTAR', 'CANCELAR')
    BEGIN
      -- Afectar Movimiento
      IF @Accion = 'AFECTAR'
      BEGIN
        SELECT @Ok = @Ok
      END

      -- Actualizar Movimiento
      IF @Ok IN (NULL, 80030)
      BEGIN
        IF @Accion = 'AFECTAR'
        BEGIN
          IF dbo.fnEstaVigente(@FechaEmision, @FechaD, @FechaA) = 1 
            SELECT @EstatusNuevo = 'VIGENTE'
        END

        IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
        IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
        IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
        BEGIN
	  IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
          IF @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
        END  

        EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Oferta
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	       Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT, @CancelarHijos = 1

--if @Ok IS NULL SELECT @Ok = 1  -- breakpoint
  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
    
  RETURN
END
GO

/**************** spOferta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOferta') and type = 'P') drop procedure dbo.spOferta
GO
CREATE PROCEDURE spOferta
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
    @MovUsuario	      	char(10),
    @Autorizacion     	char(10),
    @DocFuente	      	int,
    @Concepto    	varchar(50),
    @Referencia 	varchar(50),
    @Observaciones    	varchar(255),
    @Estatus          	char(15),
    @EstatusNuevo	char(15),
    @Ejercicio	      	int,
    @Periodo	      	int,
    @FechaD		datetime,
    @FechaA		datetime,
    @GenerarMovID	varchar(20),
    @GenerarPoliza	bit,
    @CfgContX		bit,
    @CfgContXGenerar	char(20)/*,
    @Verificar		bit*/

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
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @FechaD = FechaD, @FechaA = FechaA,
         @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion,
         @Concepto = Concepto, @Referencia = Referencia
    FROM Oferta
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
    SELECT @EstatusNuevo = 'PENDIENTE' 

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
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE', 'VIGENTE'))
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
      EXEC spOfertaVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
                             @FechaD, @FechaA,
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
   
    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
      EXEC spOfertaAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			       @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                               @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
                               @FechaD, @FechaA,
		               @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                               @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
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

/**************** spOfertaCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaCerrarDia') and type = 'P') drop procedure dbo.spOfertaCerrarDia
GO
CREATE PROCEDURE spOfertaCerrarDia
			@Fecha	datetime,
			@Ok	int		OUTPUT,
			@OkRef	varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaD	datetime,
    @FechaA	datetime,
    @Estatus	varchar(15)

  DECLARE crOferta CURSOR FOR
    SELECT FechaD, FechaA, Estatus
      FROM Oferta
     WHERE Estatus IN ('PENDIENTE', 'VIGENTE')

  OPEN crOferta
  FETCH NEXT FROM crOferta INTO @FechaD, @FechaA, @Estatus
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF dbo.fnEstaVencido(@Fecha, @FechaA) = 1
        UPDATE Oferta SET Estatus = 'CONCLUIDO', FechaConclusion = GETDATE() WHERE CURRENT OF crOferta
      ELSE
      IF @Estatus = 'PENDIENTE'
      BEGIN
        IF dbo.fnEstaVigente(@Fecha, @FechaD, @FechaA) = 1
          UPDATE Oferta SET Estatus = 'VIGENTE' WHERE CURRENT OF crOferta
      END
    END
    FETCH NEXT FROM crOferta INTO @FechaD, @FechaA, @Estatus
  END  -- While	
  CLOSE crOferta
  DEALLOCATE crOferta
  RETURN
END
GO

/**************** spOfertaVenta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaVenta') and type = 'P') drop procedure dbo.spOfertaVenta
GO
CREATE PROCEDURE spOfertaVenta
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Region		varchar(50),
    @Alm		varchar(10),
    @AlmGrupo		varchar(50),
    @Cte		varchar(10),
    @CteCategoria	varchar(50),
    @CteGrupo		varchar(50),
    @CteFamilia		varchar(50),
    @CteZona		varchar(50),
    @Agente		varchar(10),
    @AgenteCategoria	varchar(50),
    @AgenteGrupo	varchar(50),
    @AgenteFamilia	varchar(50),
    @Mov		varchar(20),
    @Moneda		varchar(10),
    @CondicionPago	varchar(50),
    @FormaPagoTipo	varchar(50),
    @FormaEnvio		varchar(50),
    @ListaPrecios	varchar(50),
    @TipoDeServicio	varchar(50),
    @TipoDeContrato varchar(50),
    @Proyecto       varchar(50)

  SELECT @Region = s.Region, @Alm = e.Almacen, @AlmGrupo = a.Grupo, 
         @Cte = e.Cliente, @CteCategoria = c.Categoria, @CteGrupo = c.Grupo, @CteFamilia = c.Familia, @CteZona = ea.Zona,
         @Mov = e.Mov, @Moneda = e.Moneda, @CondicionPago = e.Condicion, @FormaPagoTipo = e.FormaPagoTipo, @FormaEnvio = e.FormaEnvio, @ListaPrecios = e.ListaPreciosEsp,
         @Agente = e.Agente, @AgenteCategoria = ag.Categoria, @AgenteGrupo = ag.Grupo, @AgenteFamilia = ag.Familia, @TipoDeServicio = e.ServicioTipo, @TipoDeContrato = e.ContratoTipo,
         @Proyecto = e.Proyecto
    FROM Venta e
    JOIN Sucursal s ON s.Sucursal = e.Sucursal
    JOIN Cte c ON c.Cliente = e.Cliente
    JOIN Alm a ON a.Almacen = e.Almacen
    LEFT OUTER JOIN Agente ag ON ag.Agente = e.Agente
    LEFT JOIN CteEnviarA ea ON e.Cliente = ea.Cliente AND e.EnviarA = ea.ID
   WHERE e.ID = @ID

  INSERT #Venta (Campo, Valor) VALUES ('Region', 		    @Region)
  INSERT #Venta (Campo, Valor) VALUES ('Almacen', 		    @Alm)
  INSERT #Venta (Campo, Valor) VALUES ('Grupo Almacen', 	@AlmGrupo)
  INSERT #Venta (Campo, Valor) VALUES ('Cliente', 		    @Cte)
  INSERT #Venta (Campo, Valor) VALUES ('Categoria Cliente', @CteCategoria)
  INSERT #Venta (Campo, Valor) VALUES ('Grupo Cliente', 	@CteGrupo)
  INSERT #Venta (Campo, Valor) VALUES ('Familia Cliente', 	@CteFamilia)
  INSERT #Venta (Campo, Valor) VALUES ('Zona Cliente', 		@CteZona)
  INSERT #Venta (Campo, Valor) VALUES ('Agente', 		    @Agente)
  INSERT #Venta (Campo, Valor) VALUES ('Categoria Agente', 	@AgenteCategoria)
  INSERT #Venta (Campo, Valor) VALUES ('Grupo Agente', 		@AgenteGrupo)
  INSERT #Venta (Campo, Valor) VALUES ('Familia Agente', 	@AgenteFamilia)
  INSERT #Venta (Campo, Valor) VALUES ('Movimiento', 		@Mov)
  INSERT #Venta (Campo, Valor) VALUES ('Moneda', 		    @Moneda)
  INSERT #Venta (Campo, Valor) VALUES ('Condicion Pago',	@CondicionPago)
  INSERT #Venta (Campo, Valor) VALUES ('Tipo Forma Pago', 	@FormaPagoTipo)
  INSERT #Venta (Campo, Valor) VALUES ('Forma Envio', 		@FormaEnvio)
  INSERT #Venta (Campo, Valor) VALUES ('Lista Precios', 	@ListaPrecios)
  INSERT #Venta (Campo, Valor) VALUES ('Tipo de Servicio', 	@TipoDeServicio)
  INSERT #Venta (Campo, Valor) VALUES ('Tipo de Contrato', 	@TipoDeContrato)
  INSERT #Venta (Campo, Valor) VALUES ('Proyecto', 	        @Proyecto)
  
  UPDATE #Venta SET Valor = '' WHERE Valor IS NULL

  INSERT #VentaDetalle (Renglon, Campo, Valor)
  SELECT ed.Renglon, 'Almacen', ISNULL(ed.Almacen, @Alm)
    FROM Venta e
    JOIN VentaD ed ON e.ID = ed.ID
    JOIN Sucursal s ON s.Sucursal = e.Sucursal
    JOIN Cte c ON c.Cliente = e.Cliente
    JOIN Alm a ON a.Almacen = e.Almacen
    LEFT OUTER JOIN Agente ag ON ag.Agente = e.Agente
   WHERE e.ID = @ID

  UPDATE #VentaDetalle SET Valor = '' WHERE Valor IS NULL
  RETURN
END
GO

/**************** spOfertaFiltroOk ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaFiltroOk') and type = 'P') drop procedure dbo.spOfertaFiltroOk
GO
CREATE PROCEDURE spOfertaFiltroOk
			@ID		int,
			@FiltroOk	bit	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @ConteoFiltro	int,
    @ConteoVenta	int

  SELECT @ConteoFiltro = COUNT(DISTINCT f.Campo) 
    FROM OfertaFiltro f
   WHERE f.ID = @ID

  SELECT @ConteoVenta = COUNT(DISTINCT f.Campo) 
    FROM OfertaFiltro f
    JOIN #Venta v ON v.Campo = f.Campo AND v.Valor = f.Valor
   WHERE f.ID = @ID

  --SELECT @ConteoVenta = @ConteoVenta + COUNT(DISTINCT f.Campo) 
  --  FROM OfertaFiltro f
  --  JOIN #VentaDetalle v ON v.Campo = f.Campo AND v.Valor = f.Valor
  -- WHERE f.ID = @ID

  IF @ConteoFiltro = @ConteoVenta 
    SELECT @FiltroOk = 1
  ELSE
    SELECT @FiltroOk = 0 

  RETURN
END
GO

/**************** spOfertaActiva ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaActiva') and type = 'P') drop procedure dbo.spOfertaActiva
GO
CREATE PROCEDURE spOfertaActiva
			@Empresa	varchar(5),
			@Sucursal	int,
			@FechaHora	datetime,
			@ImporteTotalMN	money
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @ID			int,
    @MontoMinimoMN	money,
    @TodasSucursales	bit,
    @FiltroOk		bit
    
 SET DATEFIRST 7
 
 DECLARE crOferta CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
   SELECT o.ID, NULLIF(o.MontoMinimo, 0.0)*m.TipoCambio, ISNULL(o.TodasSucursales, 0)
     FROM Oferta o
     JOIN Mon m ON m.Moneda = o.Moneda
    WHERE o.Empresa = @Empresa AND o.Estatus = 'VIGENTE' AND dbo.fnEstaVigenteAvanzado(@FechaHora, o.FechaD, o.FechaA, o.HoraD, o.HoraA, o.DiasEsp) = 1
  OPEN crOferta
  FETCH NEXT FROM crOferta INTO @ID, @MontoMinimoMN, @TodasSucursales
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @TodasSucursales = 1 OR EXISTS(SELECT * FROM OfertaSucursalEsp WHERE ID = @ID AND SucursalEsp=@Sucursal)
      IF @MontoMinimoMN IS NULL OR (ISNULL(@ImporteTotalMN, 0.0) >= ISNULL(@MontoMinimoMN, 0.0))
      BEGIN
        EXEC spOfertaFiltroOk @ID, @FiltroOk OUTPUT
        EXEC xpOfertaActiva @Empresa, @Sucursal, @FechaHora, @ImporteTotalMN, @ID, @FiltroOk OUTPUT
        IF @FiltroOk = 1
          INSERT #OfertaActiva (ID, Sucursal) VALUES (@ID, @Sucursal)
      END
    END
    FETCH NEXT FROM crOferta INTO @ID, @MontoMinimoMN, @TodasSucursales
  END  -- While
  CLOSE crOferta
  DEALLOCATE crOferta
  RETURN
END
GO

/**************** spOfertaPrecioSugerido ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaPrecioSugerido') and type = 'P') drop procedure dbo.spOfertaPrecioSugerido
GO
CREATE PROCEDURE spOfertaPrecioSugerido
			@Empresa		varchar(5),
			@Sucursal		int,
			@Moneda			varchar(10),
			@TipoCambio		float,
			@ListaPrecios		varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
 DECLARE
   @Articulo		varchar(20), 
   @SubCuenta		varchar(50), 
   @Unidad		varchar(50),
   @Proveedor		varchar(10),
   @PrecioSugerido	float,
   @PrecioIndependiente bit, --Ticket 4859
   @RenglonTipo     char     --Ticket 4859

  DECLARE @VentaD TABLE(
          Orden			int IDENTITY(1,1) PRIMARY KEY,
          Articulo      varchar(20)NULL, 
          Proveedor		varchar(10)NULL, 
          SubCuenta     varchar(50)NULL, 
          Unidad        varchar(50)NULL, 
          RenglonTipo   varchar(1)NULL)

   INSERT @VentaD(Articulo, Proveedor, SubCuenta, Unidad, RenglonTipo)
   SELECT Articulo, Proveedor, SubCuenta, Unidad, RenglonTipo
     FROM #VentaD
    WHERE NULLIF(PrecioSugerido, 0.0) IS NULL
    GROUP BY Articulo, Proveedor, SubCuenta, Unidad, RenglonTipo
    ORDER BY Articulo, Proveedor, SubCuenta, Unidad, RenglonTipo
    
  DECLARE crVentaD CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
   SELECT Articulo, Proveedor, SubCuenta, Unidad, RenglonTipo
     FROM @VentaD
  OPEN crVentaD
  FETCH NEXT FROM crVentaD INTO @Articulo, @Proveedor, @SubCuenta, @Unidad, @RenglonTipo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @PrecioSugerido = NULL
      SELECT @PrecioIndependiente = NULL

      IF @RenglonTipo = 'C'
        SELECT @PrecioIndependiente = PrecioIndependiente 
          FROM ArtJuego a 
          JOIN ArtJuegoD d ON a.Articulo = d.Articulo AND a.Juego = d.Juego 
         WHERE d.Opcion = @Articulo

      EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @Moneda, @TipoCambio, @ListaPrecios, @PrecioSugerido OUTPUT, @Proveedor = @Proveedor
--JGD 15Junio2011 Ticket 4859
      --UPDATE #VentaD SET PrecioSugerido = @PrecioSugerido WHERE Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(Unidad, '') = ISNULL(@Unidad, '') AND ISNULL(Proveedor, '') = ISNULL(@Proveedor, '')
      UPDATE #VentaD SET PrecioSugerido = (CASE WHEN @PrecioIndependiente = 0 THEN PrecioSugerido ELSE @PrecioSugerido END) WHERE Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(Unidad, '') = ISNULL(@Unidad, '') AND ISNULL(Proveedor, '') = ISNULL(@Proveedor, '')
    END
    FETCH NEXT FROM crVentaD INTO @Articulo, @Proveedor, @SubCuenta, @Unidad, @RenglonTipo
  END  -- While
  CLOSE crVentaD
  DEALLOCATE crVentaD
  RETURN
END
GO


/* 
Precio 
	Precio, 
	Porcentaje, 
	Margen

Descuento
	Porcentaje, 
	Importe

Puntos
	Cantidad, 
	Porcentaje

Comision
	Importe, 
	Porcentaje

Obsequio Mismo Articulo
	Porcentaje, 
	Precio, 
	Total

Obsequio Otro Articulo
	Porcentaje, 
	Precio, 
	Total
*/

/**************** spOfertaLog ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaLog') and type = 'P') drop procedure dbo.spOfertaLog
GO
CREATE PROCEDURE spOfertaLog 
    @OfertaID			      int,
    @Tipo				        varchar(50), 
    @Forma				      varchar(50), 
    @Usar				        varchar(50),
    @Articulo			      varchar(20), 
    @SubCuenta			    varchar(50), 
    @Unidad				      varchar(50), 
    @Descuento			    float = 0.00,
    @DescuentoImporte	  float = 0.00,
    @Costo				      float = 0.00,
    @PrecioBaseCosto	  float = 0.00,
    @PrecioBaseLista	  float = 0.00,
    @Precio				      float = 0.00,
    @Puntos				      float = 0.00,
    @PuntosPorcentaje	  float = 0.00, 
    @Comision			      float = 0.00, 
    @ComisionPorcentaje	float = 0.00,
    @ArtCantidadTotal   float = 0.00,
    @ArticuloObsequio   varchar(20)=NULL,
    @SubCuentaObsequio  varchar(50)=NULL,
    @UnidadObsequio		  varchar(50) = NULL,
    @DescuentoP1			  float = 0.00,
    @DescuentoP2			  float = 0.00,
    @DescuentoP3			  float = 0.00,
    @DescuentoG1			  float = 0.00,
    @DescuentoG2			  float = 0.00,
    @DescuentoG3			  float = 0.00,
    @OfertaIDP1         int = 0,
    @OfertaIDP2         int = 0,
    @OfertaIDP3         int = 0,
    @OfertaIDG1         int = 0,
    @OfertaIDG2         int = 0,
    @OfertaIDG3         int = 0,
    @Descripcion		    varchar(255) = NULL
    --//WITH ENCRYPTION
    AS BEGIN 
    DECLARE 
    @Cantidad		int,
    @Impuesto		float,		
    @Empresa		varchar(5),
    @Mov				varchar(20),
    @MovID			varchar(20),
    @Moneda			varchar(20),
    @TipoCambio float,
    @Prioridad	int,
    @PrioridadG	int

    SELECT @Mov = Mov, 
	       @MovID = MovID, 
	       @Prioridad = Prioridad,
		   @PrioridadG = PrioridadG
	  FROM Oferta
	 WHERE ID = @OfertaID		 

	IF @ArticuloObsequio IS NOT NULL AND EXISTS(SELECT * FROM #OfertaLog WHERE Articulo = @Articulo AND ArticuloObsequio = @ArticuloObsequio AND UnidadObsequio = @UnidadObsequio and SubCuentaObsequio =@SubCuentaObsequio)
	  BEGIN
		  UPDATE #OfertaLog SET CantidadObsequio = CantidadObsequio + 1 WHERE ArticuloObsequio = @ArticuloObsequio AND UnidadObsequio = @UnidadObsequio and SubCuentaObsequio =@SubCuentaObsequio
	  END

	IF @ArticuloObsequio IS NULL OR NOT EXISTS(SELECT * FROM #OfertaLog WHERE Articulo = @Articulo AND ArticuloObsequio = @ArticuloObsequio AND UnidadObsequio = @UnidadObsequio and SubCuentaObsequio = @SubCuentaObsequio)
	BEGIN
    INSERT #OfertaLog(OfertaID, Prioridad, PrioridadG, Mov, MovID,
                      Tipo, Forma, Usar, Articulo, SubCuenta,
                      Unidad, Descuento, DescuentoImporte, Costo, PrecioBaseCosto,
                      PrecioBaseLista, Precio, Puntos, PuntosPorcentaje, Comision,
                      ArticuloObsequio, SubCuentaObsequio,	CantidadObsequio, ComisionPorcentaje, UnidadObsequio,
                      DescuentoP1, DescuentoP2, DescuentoP3, DescuentoG1, DescuentoG2, 
                      DescuentoG3, OfertaIDP1, OfertaIDP2, OfertaIDP3, OfertaIDG1, 
                      OfertaIDG2, OfertaIDG3, Descripcion)
    VALUES  (@OfertaID, @Prioridad, @PrioridadG, @Mov, @MovID,
            @Tipo, @Forma, @Usar,	@Articulo, @SubCuenta,
            @Unidad, @Descuento, @DescuentoImporte, @Costo, @PrecioBaseCosto,	
            @PrecioBaseLista,	@Precio, @Puntos, @PuntosPorcentaje, @Comision, 
            @ArticuloObsequio, @SubCuentaObsequio, @ArtCantidadTotal,	@ComisionPorcentaje, @UnidadObsequio,
            @DescuentoP1, @DescuentoP2, @DescuentoP3, @DescuentoG1, @DescuentoG2, 
            @DescuentoG3, @OfertaIDP1, @OfertaIDP2, @OfertaIDP3, @OfertaIDG1, 
            @OfertaIDG2, @OfertaIDG3, @Descripcion)

	END
  RETURN
END
GO

/**************** spOfertaNormal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaNormal') and type = 'P') drop procedure dbo.spOfertaNormal
GO
CREATE PROCEDURE spOfertaNormal
    @Empresa				varchar(5),
    @Sucursal				int,
    @Moneda					varchar(10),
    @TipoCambio				float,
    @Articulo				varchar(20), 
    @SubCuenta				varchar(50), 
    @ArtCantidadTotal		float,
    @ArtCostoBase			float, 
    @ArtPrecioSugerido		float,
    @ArtPrecio				float	OUTPUT, 
    @ArtDescuento			float	OUTPUT, 
    @ArtDescuentoImporte    money	OUTPUT,
    @ArtPuntos				float	OUTPUT, 
    @ArtPuntosPorcentaje	float	OUTPUT,
    @ArtComision			float	OUTPUT,
    @ArtComisionPorcentaje	float	OUTPUT,
    @ArtOfertaID			int		OUTPUT,
    @CfgOfertaNivelopcion	bit ,
    @PuntosPrecio           bit= NULL,
    @Prioridad				int= NULL,
    @ArtUnidad				varchar(50)
						
    --//WITH ENCRYPTION
    AS BEGIN 
    DECLARE
    @a			              int,
    @b                        int,--REQ 9999
    @OfertaID		          int,
    @OfertaTipoCambio	      float,
    @Tipo		              varchar(50),
    @Forma		              varchar(50),	
    @Usar		              varchar(50),	
    @TieneVolumen	          bit,
    @Cantidad		          float,
    @Porcentaje		          float,
    @Precio		              float,
    @Importe	              money,
    @Obsequio		          varchar(20),
    @UnidadObsequio		      varchar(50),
    @Desde		              float,
    @ModImporte               int,
    @PrecioVenta              float,--REQ 9999
    @ImporteVenta             float,--REQ 9999
    @CantidadObsequio         float,--REQ 9999
    @CantidadOferta           float,--REQ 9999
    @ImporteOferta            float,--REQ 9999
    @CumpleTotal              int,--REQ 9999
    @ArtTipo                  varchar(20),
    @TipoCosteo               varchar(20),
    @Costo                    money,
    @PrecioBaseCosto          money,
    @Factor                   float,
    @PrecioBaseLista          money,
    @ListaPreciosEsp          varchar(20),
    @CfgImpInc                int,
    @CfgCosteoNivelSubCuenta  bit,
    @ObsequiosTotales	      int,
    @CantidadObsequiosVtaD    int,
    @CantidadArt		      int,
    @Contador			      int,
    ------------------------------------------------- Solucion BUG 2598 y 2599
    @ArticuloDesc		      varchar(20),
    @DescuentoEnP1		      float, 
    @DescuentoEnP2		      float, 
    @CantidadTemporal	      int,
    @ImporteTemporal	      float, 
    @PrecioTemporal		      float,
    @DescImporteTemporal      money,
    @PorcentajeImporte	      float,
    @ArticuloImporte	      varchar(20),
    @OfertaAplicaLog	      bit,
    @RestaComponente	      int,		-- Bug 2810
    @DescripcionOfertaLog     varchar(255),
    @SubCuentaObsequio        varchar(50), -- Desarrollo Obsequios 
    @CantidadArticulo	      int,
    @DescripcionArtObsequio   varchar(100),
    @DescripcionArtOrigen     varchar(100),
    @NombreListaEsp           varchar (100),
    @ArtCantidadTotalObsequio int,
    @TotalArticulosOferta     int,
    @ImporteVentaPorcentaje   float,
    @DesImporte               float,
    @cantidadTotal            int,
    ------------------------------------------------- Solución BUG 5360
    @TotalArtOferta           int,
    @ArtAplicados             int,
    @ArtAplicadosDCI          int    
    
    DECLARE @TabDescuentos    TABLE (Articulo varchar(20), DescuentoP1 float, DescuentoP2 float, Precio float, Cantidad int, Impuesto float, DescuentoImporte money)
    DECLARE @TabOferta        TABLE (Articulo varchar(20),SubCuenta varchar(20), Unidad varchar(20), Cantidad int)      --- Solución BUG 5360
    DECLARE @TabVenta         TABLE (Articulo varchar(20),SubCuenta varchar(20), Unidad varchar(20), Cantidad int)      --- Solución BUG 5360
    DECLARE @TabVentaImporte  TABLE (Articulo varchar(20),SubCuenta varchar(20), Unidad varchar(20), TotalImpote float) --- Solución BUG 4251
    --------------------------------------------------------------------------

   SELECT @TipoCosteo = TipoCosteo,
          @CfgImpInc  = VentaPreciosImpuestoIncluido,
          @CfgCosteoNivelSubCuenta    = CosteoNivelSubCuenta
     FROM EmpresaCfg ec 
    WHERE ec.Empresa = @Empresa


   SELECT @OfertaAplicaLog = CASE 
								WHEN (ISNULL(OfertaAplicaLog, 0) > 0) THEN OfertaAplicaLog
								WHEN (ISNULL(OfertaAplicaLogPOS, 0) > 0) THEN OfertaAplicaLogPOS
								ELSE 0
							 END
	 FROM EmpresaCfg2 ec
	WHERE ec.Empresa = @Empresa

  DECLARE @OfertaNormal TABLE(
          Orden					int IDENTITY(1,1)PRIMARY KEY,
          ID					int NOT NULL,
          Prioridad             int NULL,
          TipoCambio			float NULL,
          Tipo					varchar(50) NULL,
          Forma					varchar(50) NULL,
          Usar					varchar(50) NULL,
          TieneVolumen			bit NULL,
          Cantidad				float NULL,
          Porcentaje			float NULL,
          Precio				float NULL,
          Importe				money NULL,
          Obsequio				varchar(20) NULL,
          Factor				float NULL,
          ListaPreciosEsp		varchar(20) NULL,
          UnidadObsequio		varchar(50) NULL,
          SubCuentaObsequio		varchar(50) NULL)

  IF @CfgOfertaNivelopcion = 1
     INSERT @OfertaNormal(ID, Prioridad, TipoCambio, Tipo, Forma, Usar, TieneVolumen, Cantidad, Porcentaje, Precio, Importe, Obsequio, Factor, ListaPreciosEsp, UnidadObsequio, SubCuentaObsequio)
     SELECT o.ID, o.Prioridad, o.TipoCambio, o.Tipo, UPPER(o.Forma), UPPER(o.Usar), ISNULL(o.TieneVolumen, 0), NULLIF(d.Cantidad, 0.0), NULLIF(d.Porcentaje, 0.0), NULLIF(d.Precio, 0.0), NULLIF(d.Importe, 0.0), NULLIF(RTRIM(d.Obsequio), ''), ISNULL(d.Factor,0.00), o.ListaPreciosEsp,d.UnidadObsequio, d.SubCuentaObsequio
       FROM OfertaD d
       JOIN Oferta o ON o.ID = d.ID AND o.Prioridad = @Prioridad
       JOIN Mon m ON m.Moneda = o.Moneda
       JOIN MovTipo mt ON mt.Modulo = 'OFER' AND mt.Mov = o.Mov AND mt.Clave IN ('OFER.OF')
       JOIN #OfertaActiva oa ON oa.ID = o.ID
       JOIN OfertaTipo t ON o.Tipo = t.Tipo
      WHERE d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta,'') AND ISNULL(NULLIF(d.Unidad,''), @ArtUnidad) = ISNULL(@ArtUnidad,'')
      ORDER BY o.Prioridad,t.Orden,o.FechaEmision
  ELSE
     INSERT @OfertaNormal(ID, Prioridad, TipoCambio, Tipo, Forma, Usar, TieneVolumen, Cantidad, Porcentaje, Precio, Importe, Obsequio, Factor, ListaPreciosEsp, UnidadObsequio, SubCuentaObsequio)
     SELECT o.ID, o.Prioridad, o.TipoCambio, o.Tipo, UPPER(o.Forma), UPPER(o.Usar), ISNULL(o.TieneVolumen, 0), NULLIF(d.Cantidad, 0.0), NULLIF(d.Porcentaje, 0.0), NULLIF(d.Precio, 0.0), NULLIF(d.Importe, 0.0), NULLIF(RTRIM(d.Obsequio), ''), ISNULL(d.Factor,0.00), o.ListaPreciosEsp,d.UnidadObsequio, d.SubCuentaObsequio
       FROM OfertaD d
       JOIN Oferta o ON o.ID = d.ID AND o.Prioridad = @Prioridad
       JOIN Mon m ON m.Moneda = o.Moneda
       JOIN MovTipo mt ON mt.Modulo = 'OFER' AND mt.Mov = o.Mov AND mt.Clave IN ('OFER.OF')
       JOIN #OfertaActiva oa ON oa.ID = o.ID
       JOIN OfertaTipo t ON o.Tipo = t.Tipo
      WHERE d.Articulo = @Articulo AND ISNULL(NULLIF(d.Unidad,''), @ArtUnidad) = ISNULL(@ArtUnidad,'')
      ORDER BY o.Prioridad,t.Orden,o.FechaEmision

IF @Prioridad = 1
BEGIN

DECLARE crOfertaNormal CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
 SELECT ID, TipoCambio, Tipo, Forma, Usar, TieneVolumen, Cantidad, Porcentaje, Precio, Importe, Obsequio, Factor, ListaPreciosEsp, UnidadObsequio, SubCuentaObsequio
   FROM @OfertaNormal
  WHERE Prioridad = 1
  OPEN crOfertaNormal
  FETCH NEXT FROM crOfertaNormal INTO @OfertaID, @OfertaTipoCambio, @Tipo, @Forma, @Usar, @TieneVolumen, @Cantidad, @Porcentaje, @Precio, @Importe, @Obsequio, @Factor, @ListaPreciosEsp, @UnidadObsequio, @SubCuentaObsequio
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN

      SELECT @ArtPrecio = NULL, @ArtDescuento  = NULL, @ArtDescuentoImporte = NULL, 
             @ArtPuntos = NULL, @ArtPuntosPorcentaje = NULL, @ArtComision = NULL, @ArtOfertaID = NULL, 
             @PrecioBaseCosto = NULL, @PrecioBaseLista = NULL

      IF @TieneVolumen = 1
      BEGIN
        SELECT @Desde = NULL
        SELECT @Desde = MAX(Desde)
          FROM OfertaDVol
         WHERE ID = @OfertaID AND Articulo = @Articulo AND (@ArtCantidadTotal >= Desde AND @ArtCantidadTotal <= Hasta)

        IF @Desde IS NOT NULL
          SELECT @Cantidad = Desde, @Porcentaje = Porcentaje, @Precio = Precio, @Importe = Importe
            FROM OfertaDVol
           WHERE ID = @OfertaID AND Articulo = @Articulo AND Desde = @Desde         
      END
      SELECT @Precio = NULLIF(@Precio, 0.0)*@OfertaTipoCambio/@TipoCambio, 
	         @Importe = NULLIF(@Importe, 0.0)*@OfertaTipoCambio/@TipoCambio

      IF @Forma = 'Precio/Costo'
      BEGIN
           --EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, @Subcuenta, @ArtUnidad, @TipoCosteo, @Moneda, @TipoCambio, @MovCosto = @Costo OUTPUT, @ConReturn = 0
        IF NULLIF(@SubCuenta,'') IS NOT NULL AND @CfgCosteoNivelSubCuenta = 1
        BEGIN
			    SELECT @Costo = UltimoCosto 
			      FROM ArtSubCosto 
			      WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Empresa = @Empresa AND Sucursal = @Sucursal
        END
        ELSE
        BEGIN
			    SELECT @Costo = UltimoCosto 
			      FROM ArtCosto 
			     WHERE Articulo = @Articulo AND Empresa = @Empresa AND Sucursal = @Sucursal
        END
        
        --VERIFICANDO COSTO NULO
        IF @Costo IS NULL
			SET @Costo = 0.0 
        	        
        IF @Usar = 'PORCENTAJE' AND @Porcentaje IS NOT NULL AND @Costo IS NOT NULL
        BEGIN 
            SET @PrecioBaseCosto = @Costo + (@Costo * (@Porcentaje/100))

            IF @PrecioBaseCosto IS NOT NULL AND EXISTS(SELECT * FROM #VentaD WHERE Articulo = @Articulo AND RenglonTipo <> 'C')
			      BEGIN			    
				      SET @ArtOfertaID = @OfertaID		

				      UPDATE #VentaD SET PrecioSugerido = @PrecioBaseCosto, Precio = @PrecioBaseCosto,OfertaID = @OfertaID 
				       WHERE Articulo = @Articulo 
				         AND ISNULL(SubCuenta,'') = ISNULL(@Subcuenta,ISNULL(SubCuenta,''))
				         AND Unidad = @ArtUnidad AND RenglonTipo <> 'C'

	   		      IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
              BEGIN
            	      SET @DescripcionOfertaLog = 'PRECIO = COSTO + ' + CAST(@Porcentaje as varchar(20))+' %'
                    SET @PrecioBaseCosto = CAST(ROUND(@PrecioBaseCosto,dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT)

				            EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @PrecioBaseCosto, @Descripcion = @DescripcionOfertaLog --Implementando
              END
			      END

        END 
        IF @Usar = 'MONTO' AND @Importe IS NOT NULL AND @Costo IS NOT NULL
        BEGIN
            SET @PrecioBaseCosto = @Costo + @Importe

            IF @PrecioBaseCosto IS NOT NULL AND EXISTS(SELECT * FROM #VentaD WHERE Articulo = @Articulo AND RenglonTipo <> 'C')
			 BEGIN
			    SET @ArtOfertaID = @OfertaID      

				UPDATE #VentaD SET PrecioSugerido = @PrecioBaseCosto, Precio = @PrecioBaseCosto,OfertaID = @OfertaID 
				 WHERE Articulo = @Articulo
				   AND ISNULL(SubCuenta,'') = ISNULL(@Subcuenta,ISNULL(SubCuenta,''))
				   AND Unidad = @ArtUnidad AND RenglonTipo <> 'C'

               
		   		IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
          BEGIN
            SET @DescripcionOfertaLog = 'PRECIO = COSTO + $' + CONVERT(varchar(20), @Importe)
            SET @PrecioBaseCosto = CAST(ROUND(@PrecioBaseCosto,dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT)
                                  
			      EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @PrecioBaseCosto, @Descripcion = @DescripcionOfertaLog
          END
			 END
        END
        IF @Usar = 'FACTOR' AND @Costo IS NOT NULL AND @Factor IS NOT NULL
        BEGIN
            SET @PrecioBaseCosto = @Costo * @Factor

       IF @PrecioBaseCosto IS NOT NULL
			 BEGIN
			    
				SET @ArtOfertaID = @OfertaID
        SET @DescripcionOfertaLog = 'PRECIO = COSTO X ' + CAST(@Factor as varchar(20))

				UPDATE #VentaD SET PrecioSugerido = @PrecioBaseCosto, Precio = @PrecioBaseCosto,OfertaID = @OfertaID 
				 WHERE Articulo = @Articulo 
				   AND ISNULL(SubCuenta,'') = ISNULL(@Subcuenta,ISNULL(SubCuenta,''))
				   AND Unidad = @ArtUnidad
		   		
				IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
        BEGIN
            SET @PrecioBaseCosto = CAST(ROUND(@PrecioBaseCosto,dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT)
			      EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @PrecioBaseCosto, @Descripcion = @DescripcionOfertaLog
        END
			 END
        END

      END
      IF @Forma = 'Precio/Lista'
      BEGIN

        EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @ArtUnidad, @Moneda, @TipoCambio, @ListaPreciosEsp, @PrecioBaseLista OUTPUT
           
        IF @Usar = 'PORCENTAJE' AND @Porcentaje IS NOT NULL AND @PrecioBaseLista IS NOT NULL
        BEGIN          

            SET @PrecioBaseLista = @PrecioBaseLista + (@PrecioBaseLista * (@Porcentaje/100))
            IF @PrecioBaseLista IS NOT NULL
			        BEGIN			    
				        SET @ArtOfertaID = @OfertaID				      
				 
				        UPDATE #VentaD SET PrecioSugerido = @PrecioBaseLista, Precio = @PrecioBaseLista,OfertaID = @OfertaID 
				         WHERE Articulo = @Articulo 
				           AND ISNULL(SubCuenta,'') = ISNULL(@Subcuenta,ISNULL(SubCuenta,''))
				           AND Unidad = @ArtUnidad		

				        IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
                BEGIN                      
                      IF @Subcuenta IS NOT NULL OR @Subcuenta <> ''
                      BEGIN
                             SELECT @NombreListaEsp = b.Lista
                               FROM ofertaD a
                         INNER JOIN ListaPreciosDUnidad  b
                                 ON a.Articulo = b.Articulo
                                AND a.PrecioLista = b.Precio
                              WHERE a.Articulo = @Articulo
                                AND a.id = @OfertaID
                                AND a.Unidad = @ArtUnidad
                      END ELSE
                      BEGIN
                             SELECT @NombreListaEsp = a.Lista
                               FROM ListaPreciosSubUnidad a
                         INNER JOIN ofertaD b
                                 ON a.Articulo = b.Articulo
                              WHERE b.Articulo = @Articulo 
                                AND b.SubCuenta = @SubCuenta 
                                AND b.Unidad = @ArtUnidad
                      END                

                       IF @ListaPreciosEsp IS NOT NULL AND @ListaPreciosEsp = ''
                          SET @ListaPreciosEsp = LTRIM(RTRIM(@NombreListaEsp))

                         SET @DescripcionOfertaLog = 'PRECIO = '+ ISNULL(@ListaPreciosEsp,  LTRIM(RTRIM(@NombreListaEsp))) +' + ' + CAST(@Porcentaje as varchar(20))+' %'
                         SET @PrecioBaseLista = CAST(ROUND(@PrecioBaseLista,dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT)

			                   EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @PrecioBaseLista, @Descripcion = @DescripcionOfertaLog --Implementando                
                END	
            END
        END 
        IF @Usar = 'MONTO' AND @Importe IS NOT NULL AND @PrecioBaseLista IS NOT NULL
        BEGIN
            SET @PrecioBaseLista = @PrecioBaseLista + @Importe

            IF @PrecioBaseLista IS NOT NULL
              BEGIN			    
		              SET @ArtOfertaID = @OfertaID

		              UPDATE #VentaD SET PrecioSugerido = @PrecioBaseLista, Precio = @PrecioBaseLista,OfertaID = @OfertaID 
			              WHERE Articulo = @Articulo 
				              AND ISNULL(SubCuenta,'') = ISNULL(@Subcuenta,ISNULL(SubCuenta,''))
				              AND Unidad = @ArtUnidad

                      IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
                      BEGIN
                      IF @Subcuenta IS NOT NULL OR @Subcuenta <> ''
                          BEGIN
                                 SELECT @NombreListaEsp = b.Lista
                                   FROM ofertaD a
                             INNER JOIN ListaPreciosDUnidad  b
                                     ON a.Articulo = b.Articulo
                                    AND a.PrecioLista = b.Precio
                                  WHERE a.Articulo = @Articulo
                                    AND a.id = @OfertaID
                                    AND a.Unidad = @ArtUnidad
                          END ELSE
                          BEGIN
                                 SELECT @NombreListaEsp = a.Lista
                                   FROM ListaPreciosSubUnidad a
                             INNER JOIN ofertaD b
                                     ON a.Articulo = b.Articulo
                                  WHERE b.Articulo = @Articulo 
                                    AND b.SubCuenta = @SubCuenta 
                                    AND b.Unidad = @ArtUnidad
                          END                

                           IF @ListaPreciosEsp IS NOT NULL AND @ListaPreciosEsp = ''
                              SET @ListaPreciosEsp = LTRIM(RTRIM(@NombreListaEsp))		                 
        		                  SET @DescripcionOfertaLog = 'PRECIO = '+ ISNULL(@ListaPreciosEsp,  LTRIM(RTRIM(@NombreListaEsp)))  +' (+) $' + CAST(@Importe as varchar(20)) 
                              SET @PrecioBaseLista = CAST(ROUND(@PrecioBaseLista,dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT)

			                        EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @PrecioBaseLista, @Descripcion = @DescripcionOfertaLog--Implementando	   
                      END
              END
        END

      END
      IF @Forma = 'PRECIO'
      BEGIN
        IF @Usar = 'PORCENTAJE' AND @Porcentaje IS NOT NULL
        BEGIN
          SELECT @Precio = dbo.fnDisminuyePorcentaje(@ArtPrecioSugerido, @Porcentaje)

            IF @Precio IS NOT NULL
			BEGIN
			    
				SET @ArtOfertaID = @OfertaID

				UPDATE #VentaD SET PrecioSugerido = @Precio, OfertaID = @OfertaID WHERE Articulo = @Articulo AND Unidad = @ArtUnidad AND ISNULL(SubCuenta,'') = ISNULL(NULLIF(@SubCuenta,''),ISNULL(SubCuenta,''))

				IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL 
        BEGIN
        		SET @DescripcionOfertaLog = 'PRECIO = PRECIO (-) ' + CAST(@Porcentaje as varchar(20))+' %'
            SET @Precio = CAST(ROUND(@Precio,dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT)

			      EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @Precio, @Descripcion = @DescripcionOfertaLog --Implementando	   
        END

			END
        END
        IF @Usar = 'MARGEN' AND @Porcentaje IS NOT NULL AND (SELECT Tipo FROM Art WHERE Articulo = @Articulo) <> 'Juego'
        BEGIN
			IF NULLIF(@SubCuenta,'') IS NOT NULL AND @CfgCosteoNivelSubCuenta = 1
			BEGIN
				SELECT @ArtCostoBase = UltimoCosto 
				  FROM ArtSubCosto 
				 WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Empresa = @Empresa AND Sucursal = @Sucursal
			END
			 ELSE IF NULLIF(@SubCuenta,'') IS NULL--BUG 2773
			BEGIN
				SELECT @ArtCostoBase = UltimoCosto 
				  FROM ArtCosto 
				 WHERE Articulo = @Articulo AND Empresa = @Empresa AND Sucursal = @Sucursal
			END
			 
        SELECT @Precio = dbo.fnPrecioMargen (@ArtCostoBase, @Porcentaje)
		  
        IF @Precio IS NOT NULL
			  BEGIN
				  SET @ArtOfertaID = @OfertaID
				  UPDATE #VentaD SET PrecioSugerido = @Precio, OfertaID = @OfertaID WHERE Articulo = @Articulo AND Unidad = @ArtUnidad AND ISNULL(SubCuenta,'') = ISNULL(NULLIF(@SubCuenta,''),ISNULL(SubCuenta,''))
				  IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
              SET @DescripcionOfertaLog = 'PRECIO = (COSTO X 100 %)/(100% - ' + CAST(@Porcentaje as varchar(20))+'%)'              
              SET @Precio = CAST(ROUND(@Precio,dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT)
			        EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @Precio, @Descripcion = @DescripcionOfertaLog --Implementando	 
			  END
        	  
        END
        IF  @Usar = 'PRECIO' AND @Precio IS NOT NULL AND (@ArtPrecio IS NULL OR @Precio < @ArtPrecio)
        BEGIN
          SELECT @ArtPrecio = @Precio, @ArtOfertaID = @OfertaID

            IF @ArtPrecio IS NOT NULL
			BEGIN
			    
				SET @ArtOfertaID = @OfertaID
				
				UPDATE #VentaD SET PrecioSugerido = @Precio, OfertaID = @OfertaID WHERE Articulo = @Articulo AND Unidad = @ArtUnidad AND ISNULL(SubCuenta,'') = ISNULL(NULLIF(@SubCuenta,''),ISNULL(SubCuenta,''))
				
				IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
			      EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @ArtPrecio--Implementando	 
			END
        END 
      END

    END
    FETCH NEXT FROM crOfertaNormal INTO @OfertaID, @OfertaTipoCambio, @Tipo, @Forma, @Usar, @TieneVolumen, @Cantidad, @Porcentaje, @Precio, @Importe, @Obsequio, @Factor, @ListaPreciosEsp, @UnidadObsequio, @SubCuentaObsequio
  END  -- While
  CLOSE crOfertaNormal
  DEALLOCATE crOfertaNormal

  RETURN
END

IF @Prioridad = 2
BEGIN
    DECLARE crOfertaNormal CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
     SELECT ID, TipoCambio, Tipo, Forma, Usar, TieneVolumen, Cantidad, Porcentaje, Precio, Importe, Obsequio, UnidadObsequio, SubCuentaObsequio
       FROM @OfertaNormal
      WHERE Prioridad = 2     
  OPEN crOfertaNormal
  FETCH NEXT FROM crOfertaNormal INTO @OfertaID, @OfertaTipoCambio, @Tipo, @Forma, @Usar, @TieneVolumen, @Cantidad, @Porcentaje, @Precio, @Importe, @Obsequio, @UnidadObsequio, @SubCuentaObsequio
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN

      IF (SELECT COUNT(DISTINCT ID) EXISTEN FROM OfertaD WHERE ID IN (SELECT ID FROM Oferta WHERE Estatus = 'VIGENTE' AND Prioridad = 2)) <= 1
			SELECT @ArtPrecio = NULL, @ArtDescuento  = NULL, @ArtDescuentoImporte = NULL, @ArtPuntos = NULL, @ArtPuntosPorcentaje = NULL, @ArtComision = NULL, @ArtOfertaID = NULL      

      IF @TieneVolumen = 1
      BEGIN
        SELECT @Desde = NULL
        SELECT @Desde = MIN(Desde)
          FROM OfertaDVol
         WHERE ID = @OfertaID AND Articulo = @Articulo AND @ArtCantidadTotal >= Desde AND @ArtCantidadTotal < Hasta
        IF @Desde IS NOT NULL
          SELECT @Cantidad = Cantidad, @Porcentaje = Porcentaje, @Precio = Precio, @Importe = Importe
            FROM OfertaDVol
           WHERE ID = @OfertaID AND Articulo = @Articulo AND Desde = @Desde
      END
      SELECT @Precio = NULLIF(@Precio, 0.0)*@OfertaTipoCambio/@TipoCambio, 
	     @Importe = NULLIF(@Importe, 0.0)*@OfertaTipoCambio/@TipoCambio

      IF @Forma = 'PUNTOS' /***** Se movieron las ofertas de Puntos a la Prioridad 2 para que puedan aplicar con otra oferta Normal *****/
      BEGIN      
        IF @Usar = 'CANTIDAD' AND @Cantidad IS NOT NULL
        BEGIN
          IF (@ArtPuntos IS NULL OR @Cantidad > ISNULL(@ArtPuntos, 0)) AND EXISTS(SELECT * FROM #VentaD WHERE Articulo = @Articulo AND RenglonTipo <> 'C')
            BEGIN
                --OBTENEMOS CANTIDAD INGRESADA EN #VENTAD
                SET @CantidadArticulo = 0
                SELECT @CantidadArticulo = Cantidad FROM #VentaD WHERE Articulo = @Articulo
                
                IF (ISNULL(@TieneVolumen,0) > 0) AND EXISTS(SELECT Cantidad FROM OfertaDVol WHERE ID = @OfertaID AND @CantidadArticulo >= Desde AND @CantidadArticulo <= Hasta)
				    SELECT @Cantidad = Cantidad FROM OfertaDVol WHERE ID = @OfertaID AND @CantidadArticulo >= Desde AND @CantidadArticulo <= Hasta

				SELECT @ArtPuntos = @Cantidad, @ArtOfertaID = @OfertaID

				IF @ArtPuntos IS NOT NULL 
				BEGIN
					IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
						BEGIN
							SET @DescripcionOfertaLog = 'PUNTOS = ' + CAST(@ArtPuntos as varchar(20)) + ' puntos X ' + CAST(@ArtUnidad as varchar(20))
							SET @ArtPuntos =  @ArtPuntos * @CantidadArticulo
							EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Puntos = @ArtPuntos, @Descripcion = @DescripcionOfertaLog--Implementando
						END
				END
			END
        END ELSE
        IF @Usar = 'PORCENTAJE' AND @Porcentaje IS NOT NULL
        BEGIN  
          IF @ArtPuntosPorcentaje IS NULL OR @Porcentaje > @ArtPuntosPorcentaje
            SELECT @ArtPuntosPorcentaje = @Porcentaje, @ArtOfertaID = @OfertaID            

			    IF @ArtPuntosPorcentaje IS NOT NULL AND EXISTS(SELECT * FROM #VentaD WHERE Articulo = @Articulo AND RenglonTipo <> 'C')
			    BEGIN
				    IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
            BEGIN    
                SELECT @ImporteVenta = SUM((ISNULL(ISNULL(Precio,PrecioSugerido),0))*ISNULL(Cantidad,0)) FROM #VentaD WHERE Articulo = @Articulo AND Unidad = @ArtUnidad AND ISNULL(SubCuenta,'') = ISNULL(ISNULL(@SubCuenta,SubCuenta),'') 
                SELECT @CantidadArticulo = Cantidad FROM #VentaD WHERE Articulo = @Articulo AND Unidad = @ArtUnidad AND ISNULL(SubCuenta,'') = ISNULL(NULLIF(@SubCuenta,''),ISNULL(SubCuenta,''))
                 
                SET @ArtPuntos = (@ArtPuntosPorcentaje/100) * @ImporteVenta
                     
                SET @DescripcionOfertaLog = 'PUNTOS = ' + CAST(@ArtPuntosPorcentaje as varchar(20)) + '% X $'+  CAST(@ImporteVenta as varchar(20))

			          EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Puntos = @ArtPuntos, @PuntosPorcentaje = @ArtPuntosPorcentaje, @Descripcion = @DescripcionOfertaLog--Implementando
            END
			    END
        END
      END ELSE
      IF @Forma = 'PUNTOS/PRECIO' AND @PuntosPrecio = 1
      BEGIN
      
        IF ISNULL(@Precio,0.0) IS NOT NULL AND (@ArtPrecio IS NULL OR ISNULL(@Precio,0.0) < ISNULL(@ArtPrecio,0.0))
          SELECT @ArtPrecio = ISNULL(@Precio,0.0), @ArtOfertaID = @OfertaID

        IF @ArtPuntos IS NULL OR @Cantidad > @ArtPuntos
		BEGIN
            SELECT @ArtPuntos = @Cantidad *-1, @ArtOfertaID = @OfertaID        

		IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL 
			  EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @ArtPrecio, @Puntos = @ArtPuntos--Implementando
		END

      END ELSE
      IF @Forma = 'IMPORTE/PUNTOS' AND @PuntosPrecio = 1
      BEGIN
        
        IF @Precio IS NOT NULL AND (@ArtPrecio IS NULL OR @Precio < @ArtPrecio)
        SELECT @ArtPrecio = @Precio, @ArtOfertaID = @OfertaID

        IF @Usar = 'IMPORTE/CANTIDAD'    
        BEGIN        
          SELECT @ArtPuntos = 0.0,@ArtOfertaID = @OfertaID

		  IF @ArtPuntos IS NOT NULL --Revisar
		  BEGIN
     			IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
               --Puntos=Por cada 1000 te regala 10 puntos
                  SET @DescripcionOfertaLog = 'PUNTOS = POR CADA $' + CAST(@ArtPrecio as varchar(20)) + ' TE REGALA '+  CAST(@ArtPuntos as varchar(20)) + ' PUNTOS'
                  
                  IF EXISTS(SELECT * FROM #OfertaLog WHERE Articulo = @Articulo AND OfertaID = @OfertaID)
						DELETE FROM #OfertaLog WHERE Articulo = @Articulo AND OfertaID = @OfertaID
				  
				  EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @ArtPrecio, @Puntos = @ArtPuntos, @Descripcion = @DescripcionOfertaLog		
		  END
        END
        IF @Usar =  'IMPORTE/PORCENTAJE'   
        BEGIN
          SELECT @ArtPuntos = 0.0,@ArtOfertaID = @OfertaID

		  IF @ArtPuntos IS NOT NULL  --Revisar
		  BEGIN
			IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
              --Puntos=Por cada 1000 te regala el 10 % en puntos
              SET @DescripcionOfertaLog = 'PUNTOS = POR CADA ' + CAST(@ArtPuntos as varchar(20)) + ' TE REGALA EL'+  CAST(@ArtPuntos as varchar(20)) + '% EN PUNTOS'
				      EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @ArtPrecio, @Puntos = @ArtPuntos, @Descripcion = @DescripcionOfertaLog		
		  END
        END 
      END ELSE
      IF @Forma = 'DESCUENTO'
      BEGIN
        IF @Usar = 'PORCENTAJE' AND @Porcentaje IS NOT NULL AND ISNULL(@Cantidad,0) <= @ArtCantidadTotal
        BEGIN
          IF @ArtDescuento IS NULL OR @Porcentaje > @ArtDescuento
		        BEGIN
              SELECT @ArtDescuento = @Porcentaje, @ArtOfertaID = @OfertaID       
              
              --Agrega los valores al log de ofertas                     
              IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL AND @ArtDescuento > 0 AND EXISTS (SELECT * FROM #VentaD WHERE Articulo = @Articulo AND ISNULL(NULLIF(Unidad,''), @ArtUnidad) = ISNULL(@ArtUnidad,'') AND ISNULL(NULLIF(SubCuenta,''), @SubCuenta) = ISNULL(@SubCuenta,'') AND RenglonTipo <> 'C')
              BEGIN
                  --Obtiene el valor del Importe de Venta 
                  SELECT @ImporteVenta = (SUM(CASE WHEN @CfgImpInc = 1 THEN ISNULL(Precio,ISNULL(PrecioSugerido,0)) / (1+(ISNULL(Impuesto1,0)/100))  ELSE ISNULL(Precio,ISNULL(PrecioSugerido,0)) END * ISNULL(Cantidad,0)))
                	  FROM #VentaD 
                   WHERE Articulo = @Articulo AND Unidad = @ArtUnidad AND ISNULL(SubCuenta,'') = ISNULL(ISNULL(@SubCuenta,SubCuenta),'') AND RenglonTipo NOT IN ('C')                              
                   
                     --Realiza el redondeo del importe venta segun la configuración de la empresa
                     SET @ImporteVenta = CAST(ROUND((@ImporteVenta * (@ArtDescuento / 100)),dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT)

                     --Obtiene la descripción de la oferta DESCUENTO PORCENTAJE
                     SET @DescripcionOfertaLog = 'Descuento = Importe (-) ' + CAST(@ArtDescuento as varchar(20))+' %'
                    
                    --Inserta los valores al Log de Ofertas
                    EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Descuento = @ArtDescuento, @DescuentoImporte = @ImporteVenta, @Descripcion = @DescripcionOfertaLog
              END
		      END
        END ELSE
        IF @Usar = 'IMPORTE' AND @Importe IS NOT NULL AND ISNULL(@Cantidad,0) <= ISNULL(@ArtCantidadTotal,0)
        BEGIN        

          IF @ArtDescuentoImporte IS NULL OR @Importe > @ArtDescuentoImporte
            BEGIN    
                SELECT @ArtDescuentoImporte = @Importe FROM #VentaD WHERE Articulo = @Articulo AND ISNULL(NULLIF(Unidad,''), @ArtUnidad) = ISNULL(@ArtUnidad,'') AND ISNULL(NULLIF(SubCuenta,''), @SubCuenta) = ISNULL(@SubCuenta,'') AND RenglonTipo <> 'C'--BUG (2803, 26948) 
                
                SELECT @ImporteVenta = (SUM(CASE WHEN @CfgImpInc = 1 THEN ISNULL(Precio,ISNULL(PrecioSugerido,0)) / (1+(ISNULL(Impuesto1,0)/100))  ELSE ISNULL(Precio,ISNULL(PrecioSugerido,0)) END * ISNULL(Cantidad,0)))
             	FROM #VentaD 
                WHERE Articulo = @Articulo AND Unidad = @ArtUnidad AND ISNULL(SubCuenta,'') = ISNULL(ISNULL(@SubCuenta,SubCuenta),'') AND RenglonTipo NOT IN ('C')

                IF @ArtDescuentoImporte IS NOT NULL AND @ImporteVenta >= @ArtDescuentoImporte
                  BEGIN  
                    SET @ArtOfertaID = @OfertaID                 
                  
                    IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL AND EXISTS (SELECT * FROM #VentaD WHERE Articulo = @Articulo AND ISNULL(NULLIF(Unidad,''), @ArtUnidad) = ISNULL(@ArtUnidad,'') AND ISNULL(NULLIF(SubCuenta,''), @SubCuenta) = ISNULL(@SubCuenta,'') AND RenglonTipo <> 'C')
                    BEGIN
                        SET @ArtDescuentoImporte = CAST(ROUND(@ArtDescuentoImporte,dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT)    
                        SET @DescripcionOfertaLog = 'Descuento = Importe (-) $' + CAST(@Importe as varchar(20))
                      
						SELECT @CantidadTemporal = Cantidad, @PrecioTemporal =  ISNULL(Precio,ISNULL(PrecioSugerido,0))
                        FROM #VentaD WHERE Articulo = @Articulo AND Unidad = @ArtUnidad AND ISNULL(SubCuenta,'') = ISNULL(ISNULL(@SubCuenta,SubCuenta),'') AND RenglonTipo NOT IN ('C')                        
					    SET @DesImporte = dbo.fnPorcentajeImporte(@CantidadTemporal*@PrecioTemporal, @ArtDescuentoImporte)
                      
                        EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @DescuentoImporte = @ArtDescuentoImporte, @Descuento = @DesImporte, @Descripcion = @DescripcionOfertaLog 
                        SELECT @DesImporte = 0.0, @PrecioTemporal = 0.0, @CantidadTemporal = 0
                    END
                  END
                ELSE
					SET @ArtDescuentoImporte = NULL	 --Si no se cumple importe, se limpia variable
            END
        END        
      END 
    END
    FETCH NEXT FROM crOfertaNormal INTO @OfertaID, @OfertaTipoCambio, @Tipo, @Forma, @Usar, @TieneVolumen, @Cantidad, @Porcentaje, @Precio, @Importe, @Obsequio, @UnidadObsequio, @SubCuentaObsequio
  END  -- While
  CLOSE crOfertaNormal
  DEALLOCATE crOfertaNormal
  RETURN
END

IF @Prioridad = 3
BEGIN

 DECLARE crOfertaNormal CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
  SELECT ID, TipoCambio, Tipo, Forma, Usar, TieneVolumen, Cantidad, Porcentaje, Precio, Importe, Obsequio, UnidadObsequio, SubCuentaObsequio
    FROM @OfertaNormal
    WHERE Prioridad = 3    
  OPEN crOfertaNormal
  FETCH NEXT FROM crOfertaNormal INTO @OfertaID, @OfertaTipoCambio, @Tipo, @Forma, @Usar, @TieneVolumen, @Cantidad, @Porcentaje, @Precio, @Importe, @Obsequio, @UnidadObsequio, @SubCuentaObsequio
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN

	IF (SELECT COUNT(DISTINCT ID) EXISTEN FROM OfertaD WHERE ID IN (SELECT ID FROM Oferta WHERE Estatus = 'VIGENTE' AND Prioridad = 3)) <= 1
			SELECT @ArtPrecio = NULL, @ArtDescuento  = NULL, @ArtDescuentoImporte = NULL, @ArtPuntos = NULL, @ArtPuntosPorcentaje = NULL, @ArtComision = NULL, @ArtOfertaID = NULL

      IF @TieneVolumen = 1
      BEGIN
        SELECT @Desde = NULL
        SELECT @Desde = MIN(Desde)
          FROM OfertaDVol
         WHERE ID = @OfertaID AND Articulo = @Articulo AND @ArtCantidadTotal >= Desde AND @ArtCantidadTotal < Hasta
        IF @Desde IS NOT NULL
          SELECT @Cantidad = Cantidad, @Porcentaje = Porcentaje, @Precio = Precio, @Importe = Importe
            FROM OfertaDVol
           WHERE ID = @OfertaID AND Articulo = @Articulo AND Desde = @Desde
      END
      SELECT @Precio = NULLIF(@Precio, 0.0)*@OfertaTipoCambio/@TipoCambio, 
	     @Importe = NULLIF(@Importe, 0.0)*@OfertaTipoCambio/@TipoCambio
      IF @Forma = 'COMISION'
      BEGIN
        IF @Usar = 'IMPORTE' AND @Importe IS NOT NULL
        BEGIN
          IF @ArtComision IS NULL OR @Importe > @ArtComision
            SELECT @ArtComision = @Importe, @ArtOfertaID = @OfertaID

		  IF @ArtComision IS NOT NULL
		  BEGIN
			IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
				EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @ArtPrecio, @Comision = @ArtComision--Implementando		
		  END

        END ELSE
        IF @Usar = 'PORCENTAJE' AND @Porcentaje IS NOT NULL
        BEGIN
          IF @ArtComisionPorcentaje IS NULL OR @Porcentaje > @ArtComisionPorcentaje
            SELECT @ArtComisionPorcentaje = @Porcentaje, @ArtOfertaID = @OfertaID

		  IF @ArtComisionPorcentaje IS NOT NULL
		  BEGIN
			IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
				EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Precio = @ArtPrecio, @ComisionPorcentaje = @ArtComisionPorcentaje--Implementando		
		  END
        END
      END ELSE
      IF @Forma = 'OBSEQUIO MISMO ARTICULO' AND ABS(@ArtCantidadTotal) >= @Cantidad
      BEGIN
          SELECT @a = 0
          WHILE @a < CONVERT(int, ABS(@ArtCantidadTotal)) / CONVERT(int, @Cantidad)
          BEGIN
              DELETE #ArtObsequio WHERE Articulo = @Obsequio AND Unidad = @ArtUnidad AND ISNULL(SubCuenta,'') = ISNULL(NULLIF(@SubCuenta,''),ISNULL(SubCuenta,''))             
              DELETE #OfertaLog  WHERE OfertaId = @OfertaID AND ArticuloObsequio = @Obsequio AND UnidadObsequio = @ArtUnidad AND ISNULL(SubcuentaObsequio,ISNULL(@SubCuenta,'')) = ISNULL(@SubCuenta,'')
 
              INSERT #ArtObsequio (Articulo, OfertaID, Unidad, SubCuenta) VALUES (@Articulo, @OfertaID, @ArtUnidad, @SubCuenta)
              SELECT @a = @a + 1,@ArtOfertaID = @OfertaID
      
              IF @OfertaAplicaLog = 1 AND @OfertaID IS NOT NULL
              BEGIN
                  SELECT @DescripcionArtObsequio = a.Descripcion1
                  FROM art a 
                  JOIN #ArtObsequio o ON a.Articulo = o.Articulo 
                  WHERE a.articulo = @Articulo 

                  IF @SubCuenta IS NULL OR @SubCuenta = ''
                      SET @DescripcionOfertaLog = 'OBSEQUIO MISMO ARTÍCULO = ARTÍCULO OBSEQUIO - ' + @DescripcionArtObsequio
                  ELSE
                      SET @DescripcionOfertaLog = 'OBSEQUIO MISMO ARTÍCULO = ARTÍCULO OBSEQUIO - ' + @DescripcionArtObsequio + ', OPCIÓN OBSEQUIO - ' + @SubCuenta
			                 
                  EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @ArtCantidadTotal = 1, @ArticuloObsequio = @Articulo, @UnidadObsequio = @ArtUnidad, @SubCuentaObsequio = @SubCuenta, @Descripcion = @DescripcionOfertaLog --Implementando          
              END
          END
      END ELSE
      IF @Forma = 'OBSEQUIO OTRO ARTICULO' AND ABS(@ArtCantidadTotal) >= @Cantidad AND @Obsequio IS NOT NULL
      BEGIN      
        --VERIFICAMOS QUE COMPONENTES EXISTE PARA OMITIRLOS --BUG 2810
        SELECT @RestaComponente = Cantidad FROM #VentaD WHERE Articulo = @Articulo AND RenglonTipo = 'C'
		    IF @RestaComponente IS NOT NULL	SET @ArtCantidadTotal = @ArtCantidadTotal - @RestaComponente
      
        SELECT @a = 0
        WHILE @a < CONVERT(int, ABS(@ArtCantidadTotal)) / CONVERT(int, @Cantidad)
        BEGIN
          INSERT #ArtObsequio (Articulo, OfertaID, Unidad, SubCuenta) VALUES (@Obsequio, @OfertaID, @UnidadObsequio, @SubCuentaObsequio)
          SELECT @ArtOfertaID = @OfertaID
          SELECT @a = @a + 1
        END

          SELECT @ArtCantidadTotalObsequio = Cantidad 
            FROM #VentaD 
           WHERE articulo = @Obsequio AND Unidad = @UnidadObsequio AND ISNULL(Subcuenta,ISNULL(@SubCuentaObsequio,'')) = ISNULL(@SubCuentaObsequio,'')

		      IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL AND @ArtCantidadTotalObsequio >= 1 
          BEGIN             
              IF @a < @ArtCantidadTotalObsequio                
                 SET @ArtCantidadTotalObsequio = @a
              ELSE
                 SET @ArtCantidadTotalObsequio = @ArtCantidadTotalObsequio
              
              SELECT @DescripcionArtObsequio = Descripcion1 FROM ART WHERE articulo = @Obsequio

              IF @SubCuentaObsequio IS NOT NULL AND @SubCuentaObsequio <> ''
                SET @DescripcionOfertaLog = 'OBSEQUIO OTRO ARTÍCULO = ' + @DescripcionArtObsequio + ', OPCIÓN OBSEQUIO - ' + @SubCuentaObsequio  
              ELSE
                SET @DescripcionOfertaLog = 'OBSEQUIO OTRO ARTÍCULO = ' + @DescripcionArtObsequio

			        EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @ArtCantidadTotal = @ArtCantidadTotalObsequio, @ArticuloObsequio = @Obsequio, @UnidadObsequio = @UnidadObsequio, @SubCuentaObsequio = @SubCuentaObsequio, @Descripcion = @DescripcionOfertaLog --Implementando
          END
          
      END ELSE

     IF @Forma = 'PRECIO SIMILAR' --AND @ArtCantidadTotal >= @Cantidad AND ISNULL(@Obsequio,'')='' 
      BEGIN
            SELECT @a = 0           
            SET @ObsequiosTotales = CONVERT(int, ABS(@ArtCantidadTotal)) / CONVERT(int, @Cantidad)
		 
            WHILE @a < ISNULL(@ObsequiosTotales,0)
            BEGIN
                  SET @Obsequio = ''
          
                  SELECT @PrecioVenta = PrecioSugerido 
                    FROM #VentaD 
                   WHERE Articulo = @Articulo 
		                 AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta,'')
                     AND Unidad = @ArtUnidad                                            
                  
                  SELECT @CantidadObsequiosVtaD = COUNT(*) FROM #ArtObsequio
		          		          
                  IF @CantidadObsequiosVtaD >= @ObsequiosTotales
					BEGIN
		              SET @a = @ObsequiosTotales 
		            END

                  IF @CantidadObsequiosVtaD <= @ObsequiosTotales 
				          BEGIN				          
                             SELECT TOP 1 @Obsequio = d.Articulo, @SubCuentaObsequio = d.SubCuenta, @UnidadObsequio = d.Unidad, @CantidadArt = d.Cantidad
				                  FROM #VentaD d
							           WHERE (ISNULL(d.Articulo,'')+ISNULL(d.SubCuenta,'')) <> (ISNULL(@Articulo,'')+ISNULL(@SubCuenta,'')) --BUG 3010
						               AND d.PrecioSugerido <= ISNULL(@PrecioVenta,0) AND d.Cantidad > ISNULL(d.CantidadObsequio,0) --AND ISNULL(d.OfertaID,0) = 0
						               AND d.RenglonTipo <> 'C'
						               AND d.Cantidad >= ((SELECT COUNT(*) FROM #ArtObsequio WHERE Articulo = d.Articulo)+@ObsequiosTotales)
 				              ORDER BY d.PrecioSugerido DESC 				              				              
							
   				            IF @CantidadArt >= @ObsequiosTotales AND ISNULL(@Obsequio,'') <> ''
				              BEGIN
  				                  SELECT @ArtOfertaID = @OfertaID -- Aqui JLMR
					                  SET @Contador = 0
									  
					                  IF (@CantidadArt >= @ObsequiosTotales) AND (@CantidadArt >= @CantidadObsequiosVtaD)
					                      BEGIN
						                    SET @ObsequiosTotales = @ObsequiosTotales - @CantidadObsequiosVtaD
						                    
						                    IF (@ObsequiosTotales = 0) AND (@Obsequio IS NOT NULL) --TERMINO DE DAR OBSEQUIOS
												SET @ObsequiosTotales = @CantidadObsequiosVtaD
						                    
						                  END							                            
                            
									WHILE  @Contador < @ObsequiosTotales
						                BEGIN
											IF (SELECT SUM(Cantidad) FROM #VentaD WHERE Articulo = @Obsequio AND Unidad = @UnidadObsequio AND SubCuenta = @SubCuentaObsequio) >= @ObsequiosTotales
												BEGIN
													INSERT #ArtObsequio (Articulo, OfertaID, Unidad, SubCuenta) VALUES (@Obsequio, @OfertaID, @UnidadObsequio, @SubCuentaObsequio) -- BUG 3010
													SET @Contador = @Contador + 1
												END						                
                                        END                           
                           
                           SET @a = @ObsequiosTotales

                            IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL AND @Obsequio <> ''
								BEGIN
									 SELECT @DescripcionArtObsequio = Descripcion1 FROM ART WHERE articulo = @Obsequio

									 IF @SubCuentaObsequio IS NOT NULL OR @SubCuentaObsequio = ''
										SET @DescripcionOfertaLog = 'PRECIO SIMILAR = ARTÍCULO OBSEQUIO (' + @DescripcionArtObsequio + '), OPCIÓN OBSEQUIO - ' + @SubCuentaObsequio 
									 ELSE
										SET @DescripcionOfertaLog = 'PRECIO SIMILAR = ARTÍCULO OBSEQUIO (' + @DescripcionArtObsequio +')'
	                    
									 EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @ArtCantidadTotal = @ObsequiosTotales, @ArticuloObsequio = @Obsequio, @UnidadObsequio = @UnidadObsequio, @SubCuentaObsequio = @SubCuentaObsequio, @Descripcion = @DescripcionOfertaLog --Implementando																								
								END--IF APLICA LOG                                          
				        END
				        ELSE
							BEGIN
								SET @a = @ObsequiosTotales
							END
				     END
				  ELSE IF (@CantidadObsequiosVtaD > @ObsequiosTotales)
				           BEGIN     				                          				                 
				                 SELECT TOP 1 @Obsequio = d.Articulo, @SubCuentaObsequio = d.SubCuenta, @UnidadObsequio = d.Unidad, @CantidadArt = d.Cantidad
				                 FROM #VentaD d
							           WHERE (ISNULL(d.Articulo,'')+ISNULL(d.SubCuenta,'')) <> (ISNULL(@Articulo,'')+ISNULL(@SubCuenta,'')) --BUG 3010
						               AND d.PrecioSugerido <= ISNULL(@PrecioVenta,0) AND d.Cantidad > ISNULL(d.CantidadObsequio,0) --AND ISNULL(d.OfertaID,0) = 0
						               AND d.RenglonTipo <> 'C'
						               AND d.Cantidad >= ((SELECT COUNT(*) FROM #ArtObsequio WHERE Articulo = d.Articulo)+@ObsequiosTotales)
 								 ORDER BY d.PrecioSugerido DESC 								 
				                 
				                 SELECT @CantidadObsequiosVtaD = COUNT(*) FROM #ArtObsequio
				                 
						         SELECT @ArtOfertaID = @OfertaID -- Aqui JLMR
						         SET @Contador = 0
					             
					             IF (@CantidadArt >= @ObsequiosTotales) AND (@CantidadArt >= @CantidadObsequiosVtaD)
					                BEGIN
						                 SET @CantidadArt = @ObsequiosTotales - @CantidadObsequiosVtaD
						                    
						                 IF (@CantidadArt < 0) AND (@Obsequio IS NOT NULL) --TERMINO DE DAR OSEQUIOS
										  	 SET @CantidadArt = @ObsequiosTotales
										  	 										  	 
										 WHILE  @Contador < @CantidadArt
											BEGIN                      
								                INSERT #ArtObsequio (Articulo, OfertaID, Unidad, SubCuenta) VALUES (@Obsequio, @OfertaID, @UnidadObsequio, @SubCuentaObsequio)
								                SET @Contador = @Contador + 1
      										END      				                     
								                                               
										SET @a = @CantidadArt 
										
										IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL AND @Obsequio <> '' AND @CantidadArt > 0
										  BEGIN             
												SELECT @DescripcionArtObsequio = Descripcion1 FROM ART WHERE articulo = @Obsequio

												IF @SubCuentaObsequio IS NOT NULL OR @SubCuentaObsequio = ''
												  SET @DescripcionOfertaLog = 'PRECIO SIMILAR = ARTÍCULO OBSEQUIO (' + @DescripcionArtObsequio + '), OPCIÓN OBSEQUIO - ' + @SubCuentaObsequio 
												ELSE
												  SET @DescripcionOfertaLog = 'PRECIO SIMILAR = ARTÍCULO OBSEQUIO (' + @DescripcionArtObsequio +')'

												EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @ArtCantidadTotal = @CantidadArt, @ArticuloObsequio = @Obsequio, @UnidadObsequio = @UnidadObsequio, @SubCuentaObsequio = @SubCuentaObsequio, @Descripcion = @DescripcionOfertaLog --Implementando
										  END--IF APLICA LOG 										
						            END     
					END
         END--WHILE    
            
         UPDATE #VentaD SET CantidadObsequio = NULL         

      END ELSE--IF PRECIO SIMILAR
      IF @Forma = 'DESCUENTO CASCADA' AND @ArtCantidadTotal >= ISNULL(@Cantidad,0)
      BEGIN
             
        SELECT @ArtDescuento = 0.00, @ArtOfertaID = NULL
        IF @ArtCantidadTotal >= ISNULL(@Cantidad,0)
        BEGIN
          
          SELECT @ArtDescuento = MAX(Porcentaje),@ArtOfertaID = @OfertaID 
            FROM OfertaDVol 
           WHERE Articulo = @Articulo AND Desde <= @ArtCantidadTotal AND ID = @OfertaID		 
           
          IF ISNULL(@ArtDescuento,0.00) <> 0.00 --Bug20158
          SELECT @ArtOfertaID = @OfertaID 
		  		    	
          IF ISNULL(@ArtDescuento,0.00) = 0.00 --Bug18165
            SELECT @ArtOfertaID=NULL,@ArtDescuento = 0.00
            
          SELECT @ArtTipo = Tipo FROM Art WHERE Articulo = @Articulo--Bug 19083

          IF @ArtTipo = 'Juego' 
          BEGIN
            IF EXISTS(SELECT * FROM ArtJuego WHERE Articulo = @Articulo AND PrecioIndependiente = 1)
              SELECT @ArtDescuento = NULL,@ArtOfertaID = NULL			  
          END		  

		    IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL AND @ArtTipo <> 'Juego' AND @ArtDescuento IS NOT NULL
					EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Descuento = @ArtDescuento--Implementando

        END
      END ELSE
      IF @Forma = 'MISMO ARTICULO POR MONTO' AND @ArtCantidadTotal >= @Cantidad  
      BEGIN
      	SELECT @ImporteVenta = SUM(CASE WHEN @CfgImpInc = 1 THEN ISNULL(PrecioSugerido,0) / (1+(ISNULL(Impuesto1,0)/100))  ELSE ISNULL(PrecioSugerido,0) END * ISNULL(Cantidad,0)) FROM #VentaD WHERE Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(NULLIF(@SubCuenta,''),ISNULL(SubCuenta,'')) AND Unidad = @ArtUnidad
        SELECT @a = 0
        WHILE @a < Convert(int,@ArtCantidadTotal)/Convert(int,@Cantidad) AND @ImporteVenta >= @Importe
        BEGIN
			INSERT #ArtObsequio (Articulo, OfertaID, Unidad, SubCuenta) VALUES (@Articulo, @OfertaID, @ArtUnidad, @SubCuenta)
			--SELECT @a = @a + 1,@ArtOfertaID = @OfertaID
      SELECT @ArtOfertaID = @OfertaID
		    IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
        	BEGIN
              SELECT @DescripcionArtObsequio = Descripcion1 FROM ART WHERE articulo = @Articulo
              IF @SubCuenta IS NULL OR @SubCuenta = ''
              BEGIN
                SET @DescripcionOfertaLog = 'MISMO ARTICULO POR MONTO = ARTÍCULO OBSEQUIO - ' + @DescripcionArtObsequio    
              END
              ELSE
              BEGIN               
                SET @DescripcionOfertaLog = 'MISMO ARTICULO POR MONTO = ARTÍCULO OBSEQUIO - ' + @DescripcionArtObsequio + ', OPCIÓN OBSEQUIO - ' + @SubCuenta   
              END
					    EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @ArtCantidadTotal = 1, @ArticuloObsequio = @Articulo, @SubCuentaObsequio = @SubCuenta, @UnidadObsequio = @ArtUnidad, @Descripcion = @DescripcionOfertaLog--Implementando
          END
          SELECT @a = @a + 1
        END
      END ELSE
      IF @Forma = 'OTRO ARTICULO POR MONTO' AND @ArtCantidadTotal >= @Cantidad AND @Obsequio IS NOT NULL
      BEGIN  
      	      SELECT @ImporteVenta = SUM((ISNULL(CASE WHEN @CfgImpInc = 1 THEN ISNULL(PrecioSugerido,0) / (1+(ISNULL(Impuesto1,0)/100))  ELSE ISNULL(PrecioSugerido,0) END,0)- (ISNULL(CASE WHEN @CfgImpInc = 1 THEN ISNULL(PrecioSugerido,0) / (1+(ISNULL(Impuesto1,0)/100))  ELSE ISNULL(PrecioSugerido,0) END,0) * ISNULL(Descuento/100,0))) * ISNULL(Cantidad,0)) FROM #VentaD WHERE Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(NULLIF(@SubCuenta,''),ISNULL(SubCuenta,'')) AND Unidad = @ArtUnidad
              SET @a = 0

              WHILE @a < CONVERT(INT, (@ArtCantidadTotal/@Cantidad)) AND @ImporteVenta >= @Importe
              BEGIN
                INSERT #ArtObsequio (Articulo, OfertaID, Unidad, SubCuenta) VALUES (@Obsequio, @OfertaID, @UnidadObsequio, @SubCuentaObsequio)
                SELECT @a = @a + 1
              END--WHILE                	                               

              DECLARE 
                      @c_Articulo	          varchar(20),
                      @c_SubCuenta	        varchar(50),
                      @c_Unidad	            varchar(50),
                      @c_obsequio	          varchar(20),
                      @c_SubCuentaObsequio  varchar(50),
                      @c_UnidadObsequio     varchar(50)

               DECLARE ofertaV_cursor CURSOR FOR

                SELECT DISTINCT d.Articulo, d.SUBCUENTA, d.Unidad, o.obsequio, o.SubCuentaObsequio, o.UnidadObsequio
                  FROM OfertaD o 
                  JOIN #VentaD d ON d.Articulo = o.Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(o.SubCuenta, '') AND d.Unidad = o.Unidad       
                 WHERE o.ID = @OfertaID 

                OPEN ofertaV_cursor
                FETCH NEXT FROM ofertaV_cursor INTO @c_Articulo, @c_SubCuenta, @c_Unidad, @c_obsequio, @c_SubCuentaObsequio, @c_UnidadObsequio

                WHILE @@FETCH_STATUS = 0
                BEGIN
                    IF EXISTS(SELECT rid FROM #ventad WHERE articulo = @c_Articulo AND  ISNULL(SubCuenta, '') = ISNULL(@c_SubCuenta, '') AND unidad = @c_Unidad)
                      AND EXISTS(SELECT rid FROM #ventad WHERE articulo = @Obsequio AND  ISNULL(SubCuenta, '') = ISNULL(@c_SubCuentaObsequio, '') AND unidad = @c_UnidadObsequio)
                      AND @ImporteVenta >= @Importe
                      BEGIN
                            SELECT @ArtOfertaID = @OfertaID
                            IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
                            BEGIN
                                  --Obtiene la descripción del artículo Obsequio
                                  SELECT @DescripcionArtObsequio = Descripcion1 FROM ART WHERE articulo = @Obsequio

                                  --Obtiene la cantidad total de articulos ingresados en la venta
                                  SELECT @cantidadTotal = SUM(cantidad) FROM #ventad WHERE articulo = @Obsequio AND ISNULL(SubCuenta, '') = ISNULL(@SubCuentaObsequio, '') AND unidad = @UnidadObsequio

                                  --Asigna el valor de la cantidad de obsequio
                                  IF  @cantidadTotal <= @a 
                                    SET @cantidadTotal = @cantidadTotal
                                  ELSE
                                    SET @cantidadTotal = @a     

                                  IF @SubCuentaObsequio IS NULL OR @SubCuentaObsequio = ''
                                  BEGIN 
                                      SET @DescripcionOfertaLog = 'OTRO ARTÍCULO POR MONTO = MONTO MÍNIMO $'+  CAST(@Importe as varchar(20)) + ', ARTÍCULO OBSEQUIO - ' + @DescripcionArtObsequio
                                  END ELSE
                                  BEGIN
                                      SET @DescripcionOfertaLog = 'OTRO ARTÍCULO POR MONTO = MONTO MÍNIMO $'+  CAST(@Importe as varchar(20))  + ', ARTÍCULO OBSEQUIO - ' + @DescripcionArtObsequio + ', OPCIÓN OBSEQUIO - ' + @SubCuentaObsequio     
                                  END
			                        
                                  --Inserta datos al LOG de OFERTAS
                                  EXEC spOfertaLog @OfertaID, @Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @ArtCantidadTotal = @cantidadTotal, @ArticuloObsequio = @Obsequio, @SubCuentaObsequio =  @SubCuentaObsequio, @UnidadObsequio = @UnidadObsequio, @Descripcion = @DescripcionOfertaLog
                            END
                      END
                    FETCH NEXT FROM ofertaV_cursor INTO @c_Articulo, @c_SubCuenta, @c_Unidad, @c_obsequio, @c_SubCuentaObsequio, @c_UnidadObsequio
                END
                CLOSE ofertaV_cursor
                DEALLOCATE ofertaV_cursor   
      END ELSE
     IF @Forma = 'DESCUENTO COMBINADO' --AND @ArtCantidadTotal >= @Cantidad
     BEGIN
        --Tabla temporal que contiene el conjunto de artículos de Oferta
        INSERT @TabOferta
        SELECT d.articulo, ISNULL(d.SubCuenta,''), d.Unidad, d.Cantidad FROM Oferta o JOIN OfertaD d ON(o.ID=d.ID) WHERE o.ID = @OfertaID ORDER BY d.articulo asc

        --Total de Artículos de Oferta
        SELECT @TotalArtOferta = COUNT(articulo) FROM @TabOferta
        
        --Tabla temporal que contiene el conjunto de artículos de Venta
        INSERT @TabVenta
        SELECT articulo,ISNULL(SubCuenta,''), Unidad, SUM(Cantidad) FROM #VentaD GROUP BY articulo,SubCuenta,Unidad ORDER BY articulo ASC
   
        --Total de Artículos que cumplen la condición de la Oferta Descuento Combinado
        SELECT @ArtAplicados = COUNT(*) FROM @TabOferta T1
         INNER JOIN @TabVenta T2 ON T1.Articulo = T2.Articulo AND ISNULL(T1.SubCuenta,'') = ISNULL(T2.SubCuenta,'') AND T1.Unidad = T2.Unidad WHERE T1.Cantidad <= T2.Cantidad

        --Condición de la Oferta Descuento Combinado
        IF (@TotalArtOferta = @ArtAplicados)
        BEGIN
            SELECT @ArtDescuento = Porcentaje FROM Oferta WHERE ID = @OfertaID

            IF @ArtCantidadTotal >= @Cantidad AND @ArtDescuento > 0
            BEGIN
                SELECT @ArtDescuento = Porcentaje FROM Oferta WHERE ID = @OfertaID
                SET @ArtOfertaID = @OfertaID 
              
                --Aplica para insertar en el Log de Ofertas
                IF @OfertaAplicaLog = 1 AND @ArtOfertaID IS NOT NULL
                BEGIN
                	    SELECT @ImporteVenta = (SUM(CASE WHEN @CfgImpInc = 1 THEN ISNULL(Precio,ISNULL(PrecioSugerido,0)) / (1+(ISNULL(Impuesto1,0)/100)) ELSE ISNULL(Precio,ISNULL(PrecioSugerido,0)) END * ISNULL(Cantidad,0)))
                        FROM #VentaD WHERE Articulo = @Articulo AND Unidad = @ArtUnidad AND ISNULL(SubCuenta,'') = ISNULL(ISNULL(@SubCuenta,SubCuenta),'') AND RenglonTipo NOT IN ('C')                            
                    
                      --Aplica el redondeo al valor de Importe Venta
                      SET @ImporteVenta = CAST(ROUND((@ImporteVenta * (@ArtDescuento / 100)),dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT) 
                    
                      --Arma la descripción para la oferta DESCUENTO COMBINADO
                      SET @DescripcionOfertaLog = 'A partir de cantidad: ' + CAST(@Cantidad as varchar(20)) +', Descuento aplicado '+ CAST(@ArtDescuento as varchar(20)) + ' %.'

                      EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Descuento = @ArtDescuento, @DescuentoImporte = @ImporteVenta, @Descripcion = @DescripcionOfertaLog
                END
            END   
        END 
        ELSE
        BEGIN
          RETURN
        END 
     END ELSE
     IF @Forma = 'DESCUENTO COMBINADO IMPORTE' 
     BEGIN
          INSERT @TabVentaImporte
          SELECT v.articulo, v.subcuenta ,v.unidad, (SUM(CASE WHEN @CfgImpInc = 1 THEN ISNULL(v.Precio,ISNULL(v.PrecioSugerido,0)) / (1+(ISNULL(v.Impuesto1,0)/100)) ELSE ISNULL(v.Precio,ISNULL(v.PrecioSugerido,0)) END * ISNULL(v.Cantidad,0)))
            FROM Oferta o
			      JOIN OfertaD d ON(o.ID=d.ID)
			      JOIN #VentaD v ON d.Articulo = v.Articulo AND d.Unidad = v.Unidad AND ISNULL(v.SubCuenta,ISNULL(d.SubCuenta,'')) = ISNULL(d.SubCuenta,'')
		       WHERE o.ID = @OfertaID AND v.RenglonTipo NOT IN ('C')
           GROUP BY v.articulo, v.subcuenta ,v.unidad
           
          SELECT @ArtAplicadosDCI = COUNT(*)
            FROM Oferta o
			     INNER JOIN OfertaD T1 ON(o.ID=T1.ID)
           INNER JOIN @TabVentaImporte T2 ON T1.Articulo = T2.Articulo AND ISNULL(T1.SubCuenta,'') = ISNULL(T2.SubCuenta,'') AND T1.Unidad = T2.Unidad
           WHERE o.ID = @OfertaID AND T1.Importe <= T2.TotalImpote

             SET @TotalArticulosOferta = (SELECT count(*) FROM OfertaD d JOIN Oferta o ON d.ID = o.ID WHERE o.ID = @OfertaID)

              IF(@ArtAplicadosDCI = @TotalArticulosOferta)
              BEGIN     
                  INSERT @TabDescuentos
                  SELECT v.Articulo, v.DescuentoP1, v.DescuentoP2, ISNULL(ISNULL(v.Precio,v.PrecioSugerido),0), SUM(v.Cantidad), v.Impuesto1, v.DescuentoImporte 
                    FROM #VentaD v
                    JOIN OfertaD d ON v.Articulo = d.Articulo AND v.Unidad = d.Unidad AND ISNULL(v.SubCuenta,ISNULL(d.SubCuenta,'')) = ISNULL(d.SubCuenta,'')
                    JOIN Oferta o ON d.ID = o.ID
                   WHERE o.ID = @OfertaID AND v.RenglonTipo NOT IN ('C')
                   GROUP BY v.Articulo, v.DescuentoP1, v.DescuentoP2, ISNULL(ISNULL(v.Precio,v.PrecioSugerido),0), v.Impuesto1, v.DescuentoImporte

                  --VERIFICANDO SI EXISTE UN DESCUENTO EN PRIORIDAD 2       
                  IF EXISTS(SELECT DescuentoP2 FROM @TabDescuentos WHERE DescuentoP2 > 0.0) OR EXISTS(SELECT DescuentoImporte FROM @TabDescuentos WHERE DescuentoImporte > 0)
			            BEGIN
				              SELECT @DescImporteTemporal = DescuentoImporte, @CantidadTemporal = Cantidad, @PrecioTemporal =  CASE WHEN @CfgImpInc = 1 THEN ISNULL(Precio,0) / (1+(ISNULL(Impuesto,0)/100))  ELSE ISNULL(Precio,0) END FROM @TabDescuentos WHERE DescuentoImporte > 0        
 
				              IF (ISNULL(@DescImporteTemporal,0)) >0
					            BEGIN															
                             SET @PorcentajeImporte = CAST(dbo.fnPorcentajeImporte(@CantidadTemporal*@PrecioTemporal, @DescImporteTemporal) AS DECIMAL(4,2))						
						              SELECT @ArticuloImporte = Articulo, @CantidadTemporal = Cantidad FROM @TabDescuentos WHERE DescuentoImporte > 0
												
						              IF EXISTS(SELECT DescuentoP2 FROM @TabDescuentos WHERE ISNULL(DescuentoP2,0) = 0 AND Articulo = @Articulo)
							            BEGIN
								                UPDATE #VentaD SET DescuentoP2 = @PorcentajeImporte, DescuentoImporte = NULL 
                                 WHERE Articulo = CASE
										                                  WHEN @ArticuloImporte = @Articulo THEN @Articulo
										                                  WHEN @ArticuloImporte <> @Articulo THEN @ArticuloImporte END
                                   AND RenglonTipo NOT IN ('C')--= 'N'

                                IF @OfertaAplicaLog = 1
                                BEGIN
                                      SET @ImporteOferta = CAST(ROUND(@ImporteOferta,dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT) 		
                                      EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Descuento = @ArtDescuento, @DescuentoImporte = @ImporteOferta, @DescuentoP2 = @PorcentajeImporte--Implementando
                                END
					                END

					                SELECT @PrecioTemporal = CASE WHEN @CfgImpInc = 1 THEN ISNULL(Precio,ISNULL(PrecioSugerido,0)) / (1+(ISNULL(Impuesto1,0)/100))  ELSE ISNULL(Precio,ISNULL(PrecioSugerido,0)) END
						                FROM #VentaD WHERE Articulo = @Articulo	AND RenglonTipo NOT IN ('C')--= 'N'

						              SET @ImporteTemporal = dbo.fnDisminuyePorcentaje(@CantidadTemporal*@PrecioTemporal, @PorcentajeImporte)
						              SET @ImporteVenta = @ImporteTemporal	
					            END ELSE
					            BEGIN			
						                SELECT @ArticuloDesc = Articulo, @CantidadTemporal = Cantidad, @DescuentoEnP2 = DescuentoP2 FROM @TabDescuentos WHERE DescuentoP2 > 0

						                SELECT @PrecioTemporal = CASE WHEN @CfgImpInc = 1 THEN ISNULL(Precio,ISNULL(PrecioSugerido,0)) / (1+(ISNULL(Impuesto1,0)/100))  ELSE ISNULL(Precio,ISNULL(PrecioSugerido,0)) END
						                  FROM #VentaD WHERE Articulo = CASE
						                                                  WHEN @ArticuloDesc = @Articulo THEN @Articulo
								                                              WHEN @ArticuloDesc <> @Articulo THEN @ArticuloDesc END
                               AND RenglonTipo NOT IN ('C')--= 'N' 	
					    
						                   SET @ImporteTemporal = dbo.fnDisminuyePorcentaje(@CantidadTemporal*@PrecioTemporal, @DescuentoEnP2)						
						                SELECT @ImporteVenta = @ImporteTemporal
					            END	
			            END
        
                  IF (@ImporteTemporal IS NOT NULL AND @ArticuloDesc = @Articulo) OR (@ImporteTemporal IS NOT NULL AND @ArticuloDesc IS NULL)
			            BEGIN
				                SELECT @ImporteVenta = ISNULL(@ImporteTemporal,0) + (ISNULL(ISNULL(vd.Precio,vd.PrecioSugerido),0) / (1+(ISNULL(vd.Impuesto1,0)/100)))*ISNULL(vd.Cantidad,0) 
				                  FROM #VentaD vd
				                  JOIN OfertaD od ON vd.Articulo = od.Articulo
				                 WHERE od.ID = @OfertaID AND vd.Articulo = od.Articulo AND vd.Articulo <> @Articulo AND od.Articulo <> @Articulo AND ISNULL(vd.SubCuenta,'') = ISNULL(ISNULL(@SubCuenta,vd.SubCuenta),'') AND vd.RenglonTipo NOT IN ('C')--= 'N' 
				
		                    SELECT @ImporteOferta = SUM(ISNULL(d.Importe,0)), @Porcentaje = MAX(ISNULL(o.Porcentaje,0))
				                  FROM Oferta o
				                  JOIN OfertaD d ON o.ID = d.ID
		                      LEFT JOIN #VentaD vd ON d.Articulo = vd.Articulo
				                 WHERE o.ID = @OfertaID AND d.Unidad = vd.Unidad AND ISNULL(d.SubCuenta,'') = ISNULL(ISNULL(@SubCuenta,d.SubCuenta),'') AND vd.RenglonTipo NOT IN ('C')--= 'N'
  			          END
		              ELSE IF (@ImporteTemporal IS NOT NULL) AND (@ArticuloDesc <> @Articulo)
			            BEGIN
				                SELECT @ImporteVenta = ISNULL(@ImporteTemporal,0) + (ISNULL(ISNULL(vd.Precio,vd.PrecioSugerido),0) / (1+(ISNULL(vd.Impuesto1,0)/100)))*ISNULL(vd.Cantidad,0) 
				                  FROM #VentaD vd
				                  JOIN OfertaD od ON vd.Articulo = od.Articulo
				                 WHERE od.ID = @OfertaID AND vd.Articulo = od.Articulo AND vd.Articulo = @Articulo AND od.Articulo = @Articulo
                           AND od.Unidad = vd.Unidad AND ISNULL(vd.SubCuenta,'') = ISNULL(ISNULL(@SubCuenta,vd.SubCuenta),'') AND vd.RenglonTipo NOT IN ('C')--= 'N' 
				
				                SELECT @ImporteOferta = SUM(ISNULL(d.Importe,0)), @Porcentaje = MAX(ISNULL(o.Porcentaje,0))
				                  FROM Oferta o
				                  JOIN OfertaD d ON o.ID = d.ID
		                 LEFT JOIN #VentaD vd ON d.Articulo = vd.Articulo
				                 WHERE o.ID = @OfertaID AND d.Unidad = vd.Unidad AND ISNULL(d.SubCuenta,'') = ISNULL(ISNULL(@SubCuenta,d.SubCuenta),'') AND vd.RenglonTipo NOT IN ('C')--= 'N'
			            END
		              ELSE IF (@ImporteTemporal IS NULL)
			            BEGIN
				                SELECT @ImporteVenta = (SUM(CASE WHEN @CfgImpInc = 1 THEN ISNULL(Precio,ISNULL(PrecioSugerido,0)) / (1+(ISNULL(Impuesto1,0)/100))  ELSE ISNULL(Precio,ISNULL(PrecioSugerido,0)) END * ISNULL(Cantidad,0)))
                          FROM #VentaD WHERE Articulo = @Articulo AND Unidad = @ArtUnidad AND ISNULL(SubCuenta,'') = ISNULL(ISNULL(@SubCuenta,SubCuenta),'') AND RenglonTipo NOT IN ('C')--= 'N'
				
				                SELECT @ImporteOferta = SUM(ISNULL(d.Importe,0)), @Porcentaje = MAX(ISNULL(o.Porcentaje,0))
				                  FROM Oferta o JOIN OfertaD d ON o.ID = d.ID 
                         WHERE o.ID = @OfertaID AND d.Articulo = @Articulo
                           AND d.Unidad = @ArtUnidad 
                           AND ISNULL(d.SubCuenta,'') = ISNULL(ISNULL(@SubCuenta,d.SubCuenta),'')		      							
			            END                             
        
      	          IF @ImporteVenta>=@ImporteOferta AND ISNULL(@Porcentaje,0)>0
      	          BEGIN              
                       IF @OfertaAplicaLog = 1 
                       BEGIN
                            SELECT @ArtDescuento = @Porcentaje
                               SET @ImporteVenta = (@ImporteVenta * (@ArtDescuento / 100))
                
                            --Aplica el redondeo al valor de Importe Venta
                               SET @ImporteVenta = CAST(ROUND(@ImporteVenta,dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT) 
                
                            --Arma la descripción para la oferta DESCUENTO COMBINADO IMPORTE             
                               SET @DescripcionOfertaLog = 'A partir del Importe: $' + CAST(@Importe as varchar(20)) +', Descuento aplicado: '+ CAST(@ArtDescuento as varchar(20)) + ' %.'
                              EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @Descuento = @Porcentaje, @DescuentoImporte = @ImporteVenta, @DescuentoP2 = @Porcentaje, @Descripcion = @DescripcionOfertaLog--Implementando  
                       END
                  END
              END 
              ELSE
              BEGIN
                    RETURN
              END
      END ELSE
      IF @Forma = 'OBSEQUIO COMBINADO' AND @ArtCantidadTotal >= @Cantidad --AND @Porcentaje IS NOT NULL
      BEGIN
        SELECT  @Obsequio = o.Obsequio, 
				        @CantidadObsequio = o.CantidadObsequio,
				        @CantidadOferta = SUM(CASE WHEN d.Cantidad <=ISNULL(v.Cantidad,0) THEN 1 ELSE -99999 END),
				        @UnidadObsequio = a.Unidad,
                @SubCuentaObsequio = o.SubCuentaObsequio
          FROM Oferta o
          JOIN OfertaD d ON(o.ID=d.ID)
          JOIN Art a ON (o.Obsequio = a.Articulo)
     LEFT JOIN #VentaD v ON d.Articulo = v.Articulo
         WHERE o.ID = @OfertaID 
         GROUP BY o.Obsequio,o.CantidadObsequio, a.Unidad, o.SubCuentaObsequio
        
        SELECT @ArtCantidadTotal = SUM(Cantidad) 
          FROM #VentaD
         WHERE Articulo = @Obsequio 
           AND Unidad = @UnidadObsequio
           AND ISNULL(Subcuenta,ISNULL(@SubCuentaObsequio,'')) = ISNULL(@SubCuentaObsequio,'')

          IF @CantidadOferta >= 0
          BEGIN
            DELETE #ArtObsequio WHERE Articulo = @Obsequio AND Unidad = @UnidadObsequio--BUG 2772 --AND ISNULL(SubCuenta,'') = ISNULL(NULLIF(@Subcuenta,''),ISNULL(SubCuenta,''))             
            DELETE #OfertaLog  WHERE OfertaId = @OfertaID AND ArticuloObsequio = @Obsequio AND UnidadObsequio = @UnidadObsequio AND ISNULL(SubcuentaObsequio,ISNULL(@SubCuentaObsequio,'')) = ISNULL(@SubCuentaObsequio,'')
            SET @a = 0  
            WHILE @a < @CantidadObsequio 
            BEGIN
			        INSERT #ArtObsequio (Articulo, OfertaID, Unidad, SubCuenta) VALUES (@Obsequio, @OfertaID, @UnidadObsequio, @SubCuentaObsequio)--BUG 2772 -- @Subcuenta)

              SET @a = @a + 1
              SELECT @ArtOfertaID = @OfertaID -- Aqui JLMR    
 
               IF @OfertaAplicaLog = 1 AND @ArtCantidadTotal >= @a 
               BEGIN
                  EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @ArticuloObsequio = @Obsequio, @ArtCantidadTotal = 1, @UnidadObsequio = @UnidadObsequio, @SubCuentaObsequio = @SubCuentaObsequio --Implementando
               END
            END
          END
      END
    END
    FETCH NEXT FROM crOfertaNormal INTO @OfertaID, @OfertaTipoCambio, @Tipo, @Forma, @Usar, @TieneVolumen, @Cantidad, @Porcentaje, @Precio, @Importe, @Obsequio, @UnidadObsequio, @SubCuentaObsequio
  END  -- While
  CLOSE crOfertaNormal
  DEALLOCATE crOfertaNormal
END
  RETURN
END
GO

/**************** spOfertaObsequiosMultiples ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaObsequiosMultiples') and type = 'P') drop procedure dbo.spOfertaObsequiosMultiples
GO
CREATE PROCEDURE spOfertaObsequiosMultiples
			@Empresa		varchar(5),
			@Sucursal		int,
			@Moneda			varchar(10),
			@TipoCambio		float
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @OfertaID				int,
    @Articulo				varchar(20),
    @SubCuenta				varchar(50),
    @ArtUnidad              varchar(50),
    @Salir					bit,
    @CfgOfertaNivelopcion	bit,
	@OfertaAplicaLog        bit,
	@Tipo                   varchar(50),
	@Forma                  varchar(50),
	@Usar                   varchar(50)
    
  SELECT @CfgOfertaNivelopcion = ISNULL(OfertaNivelopcion, 0),
         @OfertaAplicaLog = ISNULL(OfertaAplicaLog, 0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa
        
 DECLARE @OfertaObsequiosMultiples TABLE(
          Orden     int identity(1,1)PRIMARY KEY,
          ID		int,
          Tipo		varchar(50)NULL,
          Forma		varchar(50)NULL,
          Usar		varchar(50)NULL)
  INSERT @OfertaObsequiosMultiples (ID, Tipo, Forma, Usar)
  SELECT o.ID,o.Tipo,o.Forma,o.Usar
    FROM Oferta o 
    JOIN MovTipo mt ON mt.Modulo = 'OFER' AND mt.Mov = o.Mov AND mt.Clave = 'OFER.OM'
    JOIN #OfertaActiva oa ON oa.ID = o.ID
ORDER BY o.Prioridad ASC,o.MontoMinimo*o.TipoCambio DESC, o.FechaEmision  ASC
              
  SELECT @Salir = 0
  DECLARE crOfertaObsequiosMultiples CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
   SELECT ID, Tipo, Forma, Usar
     FROM @OfertaObsequiosMultiples
  OPEN crOfertaObsequiosMultiples
  FETCH NEXT FROM crOfertaObsequiosMultiples INTO @OfertaID, @Tipo, @Forma, @Usar
  WHILE @@FETCH_STATUS <> -1 AND @Salir = 0
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Articulo = NULL
      IF @CfgOfertaNivelopcion = 1
        SELECT @Articulo = MIN(o.Articulo), @SubCuenta = MIN(ISNULL(o.SubCuenta, '')),@ArtUnidad = MIN(ISNULL(o.Unidad, ''))
          FROM OfertaD o 
          JOIN #VentaD d ON d.Articulo = o.Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(o.SubCuenta, '') AND d.Unidad = o.Unidad
         WHERE o.ID = @OfertaID 
      ELSE
        SELECT @Articulo = MIN(o.Articulo),@ArtUnidad = MIN(ISNULL(o.Unidad, ''))
          FROM OfertaD o 
          JOIN #VentaD d ON d.Articulo = o.Articulo AND d.Unidad = o.Unidad
         WHERE o.ID = @OfertaID 

      IF @Articulo IS NOT NULL
      BEGIN
        UPDATE #VentaD
           SET CantidadObsequio = 1.0,
               OfertaID = @OfertaID
         WHERE NULLIF(OfertaID, 0) IS NULL 
           AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta AND Unidad = @ArtUnidad
        SELECT @Salir = 1

		    IF @OfertaAplicaLog = 1 AND @OfertaID IS NOT NULL
		      EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @ArtUnidad, @ArticuloObsequio = @Articulo, @ArtCantidadTotal = 1--Implementando
      END
    END
    FETCH NEXT FROM crOfertaObsequiosMultiples INTO @OfertaID, @Tipo, @Forma, @Usar
  END  -- While
  CLOSE crOfertaObsequiosMultiples
  DEALLOCATE crOfertaObsequiosMultiples
  RETURN
END
GO

/**************** spOfertaArmadaAplicar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaArmadaAplicar') and type = 'P') drop procedure dbo.spOfertaArmadaAplicar
GO
CREATE PROCEDURE spOfertaArmadaAplicar
			@OfertaID	int,
			@Empresa	char(5) 
			
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
          @Articulo             varchar(20),
          @SubCuenta            varchar(50),
          @Unidad               varchar(50),
          @Cantidad             float,
          @Precio               float,
          @ArmadaOk             bit,
          @CfgOfertaNivelOpcion	bit,
          @TotalPreciosVenta		int, 
          @TotalPreciosOferta		int,
          @TotalImporteVenta		float,
          @CfgImpInc            int,
          @MontoMinimo          float,
          @Tipo                 varchar(50),
          @Forma                varchar(50),
          @Usar                 varchar(50),
          @OfertaAplicaLog      bit
  
  SELECT @CfgImpInc  = VentaPreciosImpuestoIncluido FROM EmpresaCfg ec WHERE ec.Empresa = @Empresa
    
  SELECT @CfgOfertaNivelOpcion = ISNULL(OfertaNivelOpcion, 0),
         @OfertaAplicaLog = ISNULL(OfertaAplicaLog, 0)
    FROM EmpresaCfg2 ec
   WHERE ec.Empresa = @Empresa

  SELECT @ArmadaOk = 1
  
  IF @CfgOfertaNivelOpcion = 1
    DECLARE crOfertaD CURSOR LOCAL FOR 
     SELECT Articulo, ISNULL(SubCuenta, ''),ISNULL(Unidad,''), Cantidad
       FROM OfertaD
      WHERE ID = @OfertaID
  ELSE
    DECLARE crOfertaD CURSOR LOCAL FOR 
     SELECT Articulo, ISNULL(SubCuenta, ''),ISNULL(Unidad,''), Cantidad
       FROM OfertaD
      WHERE ID = @OfertaID
      
  OPEN crOfertaD
  FETCH NEXT FROM crOfertaD INTO @Articulo, @SubCuenta, @Unidad, @Cantidad
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @ArmadaOk = 1
    BEGIN
      IF @CfgOfertaNivelOpcion = 1 
      BEGIN
        IF NOT EXISTS(SELECT * FROM #VentaD WHERE NULLIF(OfertaID, 0) IS NULL AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta AND Unidad = @Unidad AND CantidadInventario >= @Cantidad AND Cantidad>=@Cantidad)
          SELECT @ArmadaOk = 0
      END
      ELSE
      IF NOT EXISTS(SELECT * FROM #VentaD WHERE NULLIF(OfertaID, 0) IS NULL AND Articulo = @Articulo AND Unidad = @Unidad AND CantidadInventario >= @Cantidad AND Cantidad>=@Cantidad)
        SELECT @ArmadaOk = 0
    END
    FETCH NEXT FROM crOfertaD INTO @Articulo, @SubCuenta, @Unidad, @Cantidad
  END  -- While
  CLOSE crOfertaD
  DEALLOCATE crOfertaD

  IF @ArmadaOk = 1
  BEGIN
	SELECT @TotalPreciosVenta = COUNT(*) FROM #VentaD v JOIN OfertaD od ON v.PrecioSugerido >= od.Precio AND od.ID = @OfertaID AND v.Articulo = od.Articulo AND ISNULL(v.SubCuenta, '') = ISNULL(od.SubCuenta,'') AND ISNULL(v.Unidad,'') = ISNULL(od.Unidad,'')
	SELECT @TotalPreciosOferta = COUNT(*) FROM OfertaD WHERE ID = @OfertaID
	SELECT @TotalImporteVenta = SUM(CASE WHEN @CfgImpInc = 1 THEN ISNULL(v.PrecioSugerido,0) / (1+(ISNULL(v.Impuesto1,0)/100)) ELSE ISNULL(v.PrecioSugerido,0) END * ISNULL(v.Cantidad,0)) 	
	FROM #VentaD v JOIN OfertaD od ON v.PrecioSugerido >= od.Precio AND od.ID = @OfertaID AND v.Articulo = od.Articulo AND ISNULL(v.SubCuenta, '') = ISNULL(od.SubCuenta,'') AND ISNULL(v.Unidad,'') = ISNULL(od.Unidad,'')
	SELECT @MontoMinimo = MontoMinimo,@Tipo = Tipo, @Forma = Forma, @Usar = Usar FROM Oferta WHERE ID = @OfertaID	
  
  	IF @CfgOfertaNivelOpcion = 1
      DECLARE crOfertaD CURSOR LOCAL FOR 
       SELECT Articulo, ISNULL(SubCuenta, ''), ISNULL(Unidad,''), Cantidad, Precio
         FROM OfertaD
        WHERE ID = @OfertaID
    ELSE
      DECLARE crOfertaD CURSOR LOCAL FOR 
       SELECT Articulo, CONVERT(char(50), ''), ISNULL(Unidad,''), Cantidad, Precio
         FROM OfertaD
        WHERE ID = @OfertaID
    OPEN crOfertaD
    FETCH NEXT FROM crOfertaD INTO @Articulo, @SubCuenta, @Unidad, @Cantidad, @Precio
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @TotalPreciosVenta = @TotalPreciosOferta AND @TotalImporteVenta >= ISNULL(@MontoMinimo, 0.0)
      BEGIN
      	IF @CfgOfertaNivelOpcion = 1
          UPDATE #VentaD 
             SET Precio = @Precio,
                 PrecioSugerido = @Precio,
                 OfertaID = @OfertaID
           WHERE NULLIF(OfertaID, 0) IS NULL 
             AND Articulo = @Articulo
             AND ISNULL(SubCuenta, '') = @SubCuenta
             AND Unidad = @Unidad
             AND CantidadInventario >= @Cantidad
             AND PrecioSugerido >= @Precio				
        ELSE
          UPDATE #VentaD 
             SET Precio = @Precio,
                 PrecioSugerido = @Precio,
                 OfertaID = @OfertaID
           WHERE NULLIF(OfertaID, 0) IS NULL 
             AND Articulo = @Articulo 
             AND Unidad = @Unidad
             AND CantidadInventario >= @Cantidad
             AND PrecioSugerido >= @Precio

				IF @OfertaAplicaLog = 1 AND @Precio IS NOT NULL
        BEGIN
              SET @Precio = CAST(ROUND(@Precio,dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT)
		          EXEC spOfertaLog @OfertaID,@Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @Unidad, @Precio = @Precio--BUG 27184	
        END
      END
      FETCH NEXT FROM crOfertaD INTO @Articulo, @SubCuenta, @Unidad, @Cantidad, @Precio
    END  -- While
    CLOSE crOfertaD
    DEALLOCATE crOfertaD
  END
  RETURN
END
GO

/**************** spOfertaArmada ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaArmada') and type = 'P') drop procedure dbo.spOfertaArmada
GO
CREATE PROCEDURE spOfertaArmada
			@Empresa		varchar(5),
			@Sucursal		int,
			@Moneda			varchar(10),
			@TipoCambio		float
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @OfertaID	int,
    @ArmadaOk	bit
  
  DECLARE @OfertaArmada TABLE(
		  Orden int IDENTITY(1,1)PRIMARY KEY,
		  ID    int)
		  
   INSERT @OfertaArmada(ID)
   SELECT o.ID
     FROM Oferta o 
     JOIN MovTipo mt ON mt.Modulo = 'OFER' AND mt.Mov = o.Mov AND mt.Clave = 'OFER.OA'
     JOIN #OfertaActiva oa ON oa.ID = o.ID
    ORDER BY o.Prioridad,o.FechaEmision
    
  DECLARE crOfertaArmada CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
   SELECT ID
     FROM @OfertaArmada
  OPEN crOfertaArmada
  FETCH NEXT FROM crOfertaArmada INTO @OfertaID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spOfertaArmadaAplicar @OfertaID, @Empresa 

    FETCH NEXT FROM crOfertaArmada INTO @OfertaID
  END  -- While
  CLOSE crOfertaArmada
  DEALLOCATE crOfertaArmada
  RETURN
END
GO


/**************** spOfertaGrupal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaGrupal') and type = 'P') drop procedure dbo.spOfertaGrupal
GO
CREATE PROCEDURE spOfertaGrupal
			@Empresa		varchar(5),
			@Sucursal		int,
			@Moneda			varchar(10),
			@TipoCambio		float,
			@Prioridad		int= NULL
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @OfertaID		      int, 
    @Categoria	          varchar(50), 
    @Grupo			      varchar(50), 
    @Familia		      varchar(50), 
    @Linea			      varchar(50), 
    @Fabricante           varchar(50), 
    @Proveedor	          varchar(10), 
    @Porcentaje	          float,
    @Almacen	          varchar(20),
    @Tipo                 varchar(10),
    @Articulo		      char(20),
    @Cantidad		      int,
    @CantidadTotal        int,
    -------------------------
    @ImporteVenta	      int,
    @MontoMinimo	      float,
    @CategoriaD		      varchar(50),
    @GrupoD			      varchar(50),
    @FamiliaD		      varchar(50), 
    @LineaD			      varchar(50), 
    @FabricanteD	      varchar(50), 
    @ProveedorD		      varchar(10),
    @ABC                  varchar(50),
    @Unidad			      varchar(50),
    @CfgImpInc		      int,
    @bOfertaGrupalActiva  bit,
    @TipoN                varchar(10),
    @Forma                varchar(50),
    @Usar                 varchar(50),
    @OfertaAplicaLog      bit,
    @DescripcionOfertaLog varchar (255),
    @SubCuenta            varchar(50),
    @ContadorTotalCascada int,
    @Precio               float,
    @PorcentajeImporte	  float,
    @DescuentoCascada     float

	SELECT @CfgImpInc  = VentaPreciosImpuestoIncluido FROM EmpresaCfg ec WHERE ec.Empresa = @Empresa

   SELECT @OfertaAplicaLog = CASE 
								WHEN (ISNULL(OfertaAplicaLog, 0) > 0) THEN OfertaAplicaLog
								WHEN (ISNULL(OfertaAplicaLogPOS, 0) > 0) THEN OfertaAplicaLogPOS
								ELSE 0
							 END
	 FROM EmpresaCfg2 ec
	WHERE ec.Empresa = @Empresa

IF @Prioridad = 1
 BEGIN
  DECLARE crOfertaGrupal CURSOR LOCAL FOR 
   SELECT o.ID, 
          NULLIF(RTRIM(o.Categoria), ''), 
          NULLIF(RTRIM(o.Grupo), ''), 
          NULLIF(RTRIM(o.Familia), ''), 
          NULLIF(RTRIM(o.Linea), ''), 
          NULLIF(RTRIM(o.Fabricante), ''), 
          NULLIF(RTRIM(o.Proveedor), ''), 
          NULLIF(o.Porcentaje, 0.0),
          ISNULL(o.GrupoTipo,'NORMAL'),
          ISNULL(o.MontoMinimo, 0.0),
          NULLIF(RTRIM(o.CategoriaD), ''), 
          NULLIF(RTRIM(o.GrupoD), ''),
          NULLIF(RTRIM(o.FamiliaD), ''),
          NULLIF(RTRIM(o.LineaD), ''),
          NULLIF(RTRIM(o.FabricanteD), ''),
          NULLIF(RTRIM(o.ProveedorD), ''),
          ISNULL(CantidadObsequio, 0),
          NULLIF(RTRIM(o.ABC), ''),
          NULLIF(RTRIM(o.Unidad),''),
          NULLIF(RTRIM(o.Tipo),''),
          NULLIF(RTRIM(o.Forma),''),
          NULLIF(RTRIM(o.Usar),'')
     FROM Oferta o 
     JOIN MovTipo mt ON mt.Modulo = 'OFER' AND mt.Mov = o.Mov AND mt.Clave = 'OFER.OG'
     JOIN #OfertaActiva oa ON oa.ID = o.ID AND oa.Sucursal = @Sucursal
    WHERE o.PrioridadG = @Prioridad
    ORDER BY o.FechaEmision
  OPEN crOfertaGrupal
  FETCH NEXT FROM crOfertaGrupal INTO @OfertaID, @Categoria, @Grupo, @Familia, @Linea, @Fabricante, @Proveedor, @Porcentaje, @Tipo, @MontoMinimo, @CategoriaD, @GrupoD, @FamiliaD, @LineaD, @FabricanteD, @ProveedorD, @Cantidad, @ABC, @Unidad, @TipoN, @Forma, @Usar
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
    SET @bOfertaGrupalActiva = 1
	SELECT @CantidadTotal = SUM(ISNULL(Cantidad,0)), @ImporteVenta = SUM(CASE WHEN @CfgImpInc = 1 
      THEN ISNULL(v.PrecioSugerido,0) / (1+(ISNULL(v.Impuesto1,0)/100)) ELSE ISNULL(v.PrecioSugerido,0) END * ISNULL(v.Cantidad,0))
        FROM #VentaD v
      JOIN Art a ON v.Articulo = a.Articulo
       WHERE (NULLIF(v.OfertaIDG3, 0) IS NULL OR NULLIF(v.OfertaIDG3, 0) = @OfertaID)
         AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria), '')
         AND ISNULL(a.Grupo,'')      = ISNULL(ISNULL(@Grupo, a.Grupo),'')
         AND ISNULL(a.Familia,'')    = ISNULL(ISNULL(@Familia, a.Familia),'')
         AND ISNULL(a.Linea,'')      = ISNULL(ISNULL(@Linea, a.Linea),'')
         AND ISNULL(a.Fabricante,'') = ISNULL(ISNULL(@Fabricante, a.Fabricante),'')
         AND ISNULL(a.Proveedor,'')  = ISNULL(ISNULL(@Proveedor, a.Proveedor),'')
         AND ISNULL(a.ABC,'')  = ISNULL(ISNULL(@ABC, a.ABC),'')
         AND ISNULL(v.Unidad,'')  = ISNULL(ISNULL(@Unidad, v.Unidad),'')

    IF @Tipo = 'NORMAL' AND @Porcentaje IS NOT NULL AND @ImporteVenta >= @MontoMinimo
      BEGIN
        UPDATE #VentaD
           SET DescuentoG1 = @Porcentaje,
               OfertaIDG1 = @OfertaID
         WHERE (NULLIF(OfertaIDG1, 0) IS NULL OR NULLIF(OfertaIDG1, 0) = @OfertaID)
           AND ISNULL(Categoria, '')  = ISNULL(ISNULL(@Categoria, Categoria), '')
           AND ISNULL(Grupo,'')       = ISNULL(ISNULL(@Grupo, Grupo),'')
           AND ISNULL(Familia,'')     = ISNULL(ISNULL(@Familia, Familia),'')
           AND ISNULL(Linea,'')       = ISNULL(ISNULL(@Linea, Linea),'')
           AND ISNULL(Fabricante,'')  = ISNULL(ISNULL(@Fabricante, Fabricante),'')
           AND ISNULL(Proveedor,'')   = ISNULL(ISNULL(@Proveedor, Proveedor),'')
           AND ISNULL(ABC,'')         = ISNULL(ISNULL(@ABC, ABC),'')
           AND ISNULL(Unidad,'')      = ISNULL(ISNULL(@Unidad, Unidad),'')
   
    IF @OfertaAplicaLog = 1 AND @OfertaID IS NOT NULL
      DECLARE logOfertaP1Normal CURSOR LOCAL FOR 

              SELECT d.Articulo, d.unidad      
              FROM #VentaD d
              WHERE DescuentoG1 = @Porcentaje
              AND   OfertaIDG1 = @OfertaID
              AND (NULLIF(OfertaIDG1, 0) IS NULL OR NULLIF(OfertaIDG1, 0) = @OfertaID)
              AND ISNULL(Categoria, '')  = ISNULL(ISNULL(@Categoria, Categoria), '')
              AND ISNULL(Grupo,'')       = ISNULL(ISNULL(@Grupo, Grupo),'')
              AND ISNULL(Familia,'')     = ISNULL(ISNULL(@Familia, Familia),'')
              AND ISNULL(Linea,'')       = ISNULL(ISNULL(@Linea, Linea),'')
              AND ISNULL(Fabricante,'')  = ISNULL(ISNULL(@Fabricante, Fabricante),'')
              AND ISNULL(Proveedor,'')   = ISNULL(ISNULL(@Proveedor, Proveedor),'')
              AND ISNULL(ABC,'')         = ISNULL(ISNULL(@ABC, ABC),'')
              AND ISNULL(Unidad,'')      = ISNULL(ISNULL(@Unidad, Unidad),'')--BUG 26789

        OPEN logOfertaP1Normal 
        FETCH NEXT FROM logOfertaP1Normal INTO @Articulo, @Unidad
        WHILE @@FETCH_STATUS <> -1 
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
	            EXEC spOfertaLog @OfertaID, @Tipo, @Forma, @Usar, @Articulo, NULL, @Unidad, @Descuento = @Porcentaje, @DescuentoG3 = @Porcentaje, @OfertaIDG3 = @OfertaID--Implementando 
          END
          FETCH NEXT FROM logOfertaP1Normal INTO @Articulo, @Unidad
        END
        CLOSE logOfertaP1Normal 
        DEALLOCATE logOfertaP1Normal        	
      END
	ELSE
		BEGIN
			UPDATE #VentaD SET Descuento = 0, DescuentoG1 = 0 WHERE OfertaID IS NOT NULL
	
		END 
      
     --IF @CantidadTotal >= @Cantidad
     --  BEGIN
     --  UPDATE #VentaD
     --     SET DescuentoG3 = @Porcentaje,
     --         OfertaIDG3 = @OfertaID
     --   WHERE (NULLIF(OfertaIDG3, 0) IS NULL OR NULLIF(OfertaIDG3, 0) = @OfertaID)
     --     AND ISNULL(Categoria, '') = ISNULL(ISNULL(@CategoriaD, Categoria), '')
     --     AND ISNULL(Grupo,'')      = ISNULL(ISNULL(@GrupoD, Grupo),'')
     --     AND ISNULL(Familia,'')    = ISNULL(ISNULL(@FamiliaD, Familia),'')
     --     AND ISNULL(Linea,'')      = ISNULL(ISNULL(@LineaD, Linea),'')
     --     AND ISNULL(Fabricante,'') = ISNULL(ISNULL(@FabricanteD, Fabricante),'')
     --     AND ISNULL(Proveedor,'')  = ISNULL(ISNULL(@ProveedorD, Proveedor),'')  
     --     AND ISNULL(Almacen,'')  = ISNULL(ISNULL(@Almacen, Almacen),'')
     --     AND SucursalDetalle = ISNULL(@Sucursal,SucursalDetalle)
     --     AND ISNULL(ABC,'')  = ISNULL(ISNULL(@ABC, ABC),'')
     -- END   
    END
    FETCH NEXT FROM crOfertaGrupal INTO @OfertaID, @Categoria, @Grupo, @Familia, @Linea, @Fabricante, @Proveedor, @Porcentaje, @Tipo, @MontoMinimo, @CategoriaD, @GrupoD, @FamiliaD, @LineaD, @FabricanteD, @ProveedorD, @Cantidad, @ABC, @Unidad, @TipoN, @Forma, @Usar
  END  -- While
  CLOSE crOfertaGrupal
  DEALLOCATE crOfertaGrupal
  
  IF EXISTS (SELECT * FROM #VentaD WHERE Descuento > 0 OR DescuentoG1 > 0) AND @bOfertaGrupalActiva = 0
	UPDATE #VentaD SET Descuento = 0, DescuentoG1 = 0 WHERE OfertaID IS NOT NULL
  
  RETURN
 END

IF @Prioridad = 2
 BEGIN
  DECLARE crOfertaGrupal CURSOR LOCAL FOR 
   SELECT o.ID, 
		  NULLIF(RTRIM(o.Categoria), ''), 
		  NULLIF(RTRIM(o.Grupo), ''), 
		  NULLIF(RTRIM(o.Familia), ''), 
		  NULLIF(RTRIM(o.Linea), ''), 
		  NULLIF(RTRIM(o.Fabricante), ''), 
		  NULLIF(RTRIM(o.Proveedor), ''), 
		  NULLIF(o.Porcentaje, 0.0),
		  ISNULL(o.GrupoTipo,'NORMAL'),
		  ISNULL(o.MontoMinimo, 0.0),
          NULLIF(RTRIM(o.CategoriaD), ''), 
          NULLIF(RTRIM(o.GrupoD), ''),
          NULLIF(RTRIM(o.FamiliaD), ''),
          NULLIF(RTRIM(o.LineaD), ''),
          NULLIF(RTRIM(o.FabricanteD), ''),
          NULLIF(RTRIM(o.ProveedorD), ''),
          NULLIF(RTRIM(o.ABC), ''),
          NULLIF(RTRIM(o.Unidad), ''),
		  o.Tipo,
		  o.Forma,
		  o.Usar
     FROM Oferta o 
     JOIN MovTipo mt ON mt.Modulo = 'OFER' AND mt.Mov = o.Mov AND mt.Clave = 'OFER.OG'
     JOIN #OfertaActiva oa ON oa.ID = o.ID
    WHERE o.PrioridadG = @Prioridad
    ORDER BY o.FechaEmision
  OPEN crOfertaGrupal
  FETCH NEXT FROM crOfertaGrupal INTO @OfertaID, @Categoria, @Grupo, @Familia, @Linea, @Fabricante, @Proveedor, @Porcentaje, @Tipo, @MontoMinimo, @CategoriaD, @GrupoD, @FamiliaD, @LineaD, @FabricanteD, @ProveedorD, @ABC, @Unidad, @TipoN, @Forma, @Usar
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
    IF @Tipo = 'NORMAL' AND @Porcentaje IS NOT NULL
      BEGIN
        UPDATE #VentaD
           SET DescuentoG2 = @Porcentaje,
               OfertaIDG2 = @OfertaID
         WHERE (NULLIF(OfertaIDG2, 0) IS NULL OR NULLIF(OfertaIDG2, 0) = @OfertaID)
           AND ISNULL(Categoria, '') = ISNULL(ISNULL(@Categoria, Categoria), '')
           AND ISNULL(Grupo,'')      = ISNULL(ISNULL(@Grupo, Grupo),'')
           AND ISNULL(Familia,'')    = ISNULL(ISNULL(@Familia, Familia),'')
           AND ISNULL(Linea,'')      = ISNULL(ISNULL(@Linea, Linea),'')
           AND ISNULL(Fabricante,'') = ISNULL(ISNULL(@Fabricante, Fabricante),'')
           AND ISNULL(Proveedor,'')  = ISNULL(ISNULL(@Proveedor, Proveedor),'')
           AND ISNULL(ABC,'')  = ISNULL(ISNULL(@ABC, ABC),'')
           AND ISNULL(Unidad,'')  = ISNULL(ISNULL(@Unidad, Unidad),'')

			IF @OfertaAplicaLog = 1 AND @OfertaID IS NOT NULL
	          DECLARE logOfertaP2Normal CURSOR LOCAL FOR 
				 SELECT d.Articulo, d.unidad
				   FROM #VentaD d
				OPEN logOfertaP2Normal 
				FETCH NEXT FROM logOfertaP2Normal INTO @Articulo, @Unidad
				WHILE @@FETCH_STATUS <> -1 
				BEGIN
				  IF @@FETCH_STATUS <> -2 
				  BEGIN    
					  EXEC spOfertaLog @OfertaID, @Tipo, @Forma, @Usar, @Articulo, NULL, @Unidad, @Descuento = @Porcentaje, @DescuentoG2 = @Porcentaje, @OfertaIDG3 = @OfertaID--Implementando 
				  END
				  FETCH NEXT FROM logOfertaP2Normal INTO @Articulo, @Unidad
				END
			CLOSE logOfertaP2Normal 
			DEALLOCATE logOfertaP2Normal

      END
      
      IF @Tipo = 'CASCADA'
      BEGIN      
        DECLARE crOfertaCascada CURSOR LOCAL FOR 

         SELECT ISNULL(d.Cantidad,0), ISNULL(d.Articulo,''), ISNULL(d.SubCuenta,''), Descuento
           FROM #VentaD d
           JOIN Art a ON d.Articulo=a.Articulo
          WHERE (NULLIF(d.OfertaIDG3, 0) IS NULL OR NULLIF(d.OfertaIDG3, 0) = @OfertaID)
            AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria), '')
            AND ISNULL(a.Grupo,'')      = ISNULL(ISNULL(@Grupo, a.Grupo),'')
            AND ISNULL(a.Familia,'')    = ISNULL(ISNULL(@Familia, a.Familia),'')
            AND ISNULL(a.Linea,'')      = ISNULL(ISNULL(@Linea, a.Linea),'')
            AND ISNULL(a.Fabricante,'') = ISNULL(ISNULL(@Fabricante, a.Fabricante),'')
            AND ISNULL(a.Proveedor,'')  = ISNULL(ISNULL(@Proveedor, a.Proveedor),'')
            AND ISNULL(a.ABC,'')        = ISNULL(ISNULL(@ABC, a.ABC),'')
            AND ISNULL(d.Unidad,'')        = ISNULL(ISNULL(@Unidad, d.Unidad),'')

        OPEN crOfertaCascada
        FETCH NEXT FROM crOfertaCascada INTO @Cantidad, @Articulo, @SubCuenta, @DescuentoCascada
        WHILE @@FETCH_STATUS <> -1 
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            SET @Porcentaje = 0
            SELECT @Porcentaje = Porcentaje FROM OfertaCascadaGrupo WHERE ID=@OfertaID AND @Cantidad BETWEEN Desde AND Hasta
             
            IF ISNULL(@Porcentaje,0) = 0 AND @Cantidad > (SELECT MAX(Hasta) FROM OfertaCascadaGrupo WHERE ID=@OfertaID) OR @Cantidad < (SELECT MIN(Desde) FROM OfertaCascadaGrupo WHERE ID=@OfertaID)
              SELECT @Porcentaje = Porcentaje FROM Oferta WHERE ID=@OfertaID

            IF ISNULL(@Porcentaje,0) <> 0
                UPDATE #VentaD SET DescuentoG3 = @Porcentaje, OfertaIDG3 = @OfertaID
                  FROM #VentaD d
				          JOIN Art a ON d.Articulo=a.Articulo
				         WHERE (NULLIF(d.OfertaIDG3, 0) IS NULL OR NULLIF(d.OfertaIDG3, 0) = @OfertaID)
				           AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria), '')
				           AND ISNULL(a.Grupo,'')      = ISNULL(ISNULL(@Grupo, a.Grupo),'')
				           AND ISNULL(a.Familia,'')    = ISNULL(ISNULL(@Familia, a.Familia),'')
				           AND ISNULL(a.Linea,'')      = ISNULL(ISNULL(@Linea, a.Linea),'')
				           AND ISNULL(a.Fabricante,'') = ISNULL(ISNULL(@Fabricante, a.Fabricante),'')
				           AND ISNULL(a.Proveedor,'')  = ISNULL(ISNULL(@Proveedor, a.Proveedor),'')
				           AND ISNULL(a.ABC,'')        = ISNULL(ISNULL(@ABC, a.ABC),'')
				           AND ISNULL(d.Unidad,'')     = ISNULL(ISNULL(@Unidad, d.Unidad),'')
				           AND ISNULL(d.Articulo,'')   = @Articulo
				           AND ISNULL(d.SubCuenta,'')  = @SubCuenta

                IF @OfertaAplicaLog = 1 AND @OfertaID IS NOT NULL AND @Porcentaje <> 0 AND @DescuentoCascada > 0 --BUG 27190    
				BEGIN
				    EXEC spOfertaLog @OfertaID, @Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @Unidad, @Descuento = @Porcentaje, @DescuentoG3 = @Porcentaje, @OfertaIDG3 = @OfertaID--BUG 27190 
				END
	        END
        FETCH NEXT FROM crOfertaCascada INTO @Cantidad, @Articulo, @SubCuenta, @DescuentoCascada
        END  -- While
        CLOSE crOfertaCascada
        DEALLOCATE crOfertaCascada        
      END--IF CASCADA
    END
    FETCH NEXT FROM crOfertaGrupal INTO @OfertaID, @Categoria, @Grupo, @Familia, @Linea, @Fabricante, @Proveedor, @Porcentaje, @Tipo, @MontoMinimo, @CategoriaD, @GrupoD, @FamiliaD, @LineaD, @FabricanteD, @ProveedorD, @ABC, @Unidad, @TipoN, @Forma, @Usar
  END  -- While
  CLOSE crOfertaGrupal
  DEALLOCATE crOfertaGrupal
  RETURN
 END

IF @Prioridad >= 3
 BEGIN
  DECLARE crOfertaGrupal CURSOR LOCAL FOR 
   SELECT o.ID, 
		  NULLIF(RTRIM(o.Categoria), ''), 
		  NULLIF(RTRIM(o.Grupo), ''), 
		  NULLIF(RTRIM(o.Familia), ''), 
		  NULLIF(RTRIM(o.Linea), ''), 
		  NULLIF(RTRIM(o.Fabricante), ''), 
		  NULLIF(RTRIM(o.Proveedor), ''), 
		  NULLIF(o.Porcentaje, 0.0),
		  ISNULL(o.GrupoTipo,'NORMAL'),
		  ISNULL(o.MontoMinimo, 0.0),
          NULLIF(RTRIM(o.CategoriaD), ''), 
          NULLIF(RTRIM(o.GrupoD), ''),
          NULLIF(RTRIM(o.FamiliaD), ''),
          NULLIF(RTRIM(o.LineaD), ''),
          NULLIF(RTRIM(o.FabricanteD), ''),
          NULLIF(RTRIM(o.ProveedorD), ''),
          NULLIF(RTRIM(o.ABC), ''),
          NULLIF(RTRIM(o.Unidad), ''),
		  o.Tipo,
		  o.Forma,
		  o.Usar
     FROM Oferta o 
     JOIN MovTipo mt ON mt.Modulo = 'OFER' AND mt.Mov = o.Mov AND mt.Clave = 'OFER.OG'
     JOIN #OfertaActiva oa ON oa.ID = o.ID
    WHERE o.PrioridadG >= @Prioridad
    ORDER BY o.FechaEmision
  OPEN crOfertaGrupal
  FETCH NEXT FROM crOfertaGrupal INTO @OfertaID, @Categoria, @Grupo, @Familia, @Linea, @Fabricante, @Proveedor, @Porcentaje, @Tipo, @MontoMinimo, @CategoriaD, @GrupoD, @FamiliaD, @LineaD, @FabricanteD, @ProveedorD, @ABC, @Unidad, @TipoN, @Forma, @Usar
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
    IF @Tipo = 'NORMAL' AND @Porcentaje IS NOT NULL
      BEGIN
        UPDATE #VentaD
           SET DescuentoG3 = @Porcentaje,
               OfertaIDG3 = @OfertaID
         WHERE (NULLIF(OfertaIDG3, 0) IS NULL OR NULLIF(OfertaIDG3, 0) = @OfertaID)
           AND ISNULL(Categoria, '') = ISNULL(ISNULL(@Categoria, Categoria), '')
           AND ISNULL(Grupo,'')      = ISNULL(ISNULL(@Grupo, Grupo),'')
           AND ISNULL(Familia,'')    = ISNULL(ISNULL(@Familia, Familia),'')
           AND ISNULL(Linea,'')      = ISNULL(ISNULL(@Linea, Linea),'')
           AND ISNULL(Fabricante,'') = ISNULL(ISNULL(@Fabricante, Fabricante),'')
           AND ISNULL(Proveedor,'')  = ISNULL(ISNULL(@Proveedor, Proveedor),'')
           AND ISNULL(ABC,'')        = ISNULL(ISNULL(@ABC, ABC),'')
           AND ISNULL(Unidad,'')        = ISNULL(ISNULL(@Unidad, Unidad),'')

		 IF @OfertaAplicaLog = 1 AND @OfertaID IS NOT NULL
	        DECLARE logOfertaP3Normal CURSOR LOCAL FOR 
				 SELECT d.Articulo, d.unidad
				   FROM #VentaD d
				OPEN logOfertaP3Normal 
				FETCH NEXT FROM logOfertaP3Normal INTO @Articulo, @Unidad
				WHILE @@FETCH_STATUS <> -1 
				BEGIN
				  IF @@FETCH_STATUS <> -2 
				  BEGIN    
					  EXEC spOfertaLog @OfertaID, @Tipo, @Forma, @Usar, @Articulo, NULL, @Unidad, @Descuento = @Porcentaje, @DescuentoG3 = @Porcentaje, @OfertaIDG3 = @OfertaID--Implementando 
				  END
				  FETCH NEXT FROM logOfertaP3Normal INTO @Articulo, @Unidad
				END
			CLOSE logOfertaP3Normal 
			DEALLOCATE logOfertaP3Normal
      END

    IF @@FETCH_STATUS <> -2 AND @Porcentaje IS NOT NULL AND @Tipo = 'CRUZADA'
    BEGIN
	      SELECT @ImporteVenta = SUM(CASE WHEN @CfgImpInc = 1 THEN ISNULL(v.PrecioSugerido,0) / (1+(ISNULL(v.Impuesto1,0)/100))  ELSE ISNULL(v.PrecioSugerido,0) END * ISNULL(v.Cantidad,0))
          FROM #VentaD v
          JOIN Art a ON v.Articulo = a.Articulo
         WHERE (NULLIF(v.OfertaIDG3, 0) IS NULL OR NULLIF(v.OfertaIDG3, 0) = @OfertaID)
           AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria), '')
           AND ISNULL(a.Grupo,'')      = ISNULL(ISNULL(@Grupo, a.Grupo),'')
           AND ISNULL(a.Familia,'')    = ISNULL(ISNULL(@Familia, a.Familia),'')
           AND ISNULL(a.Linea,'')      = ISNULL(ISNULL(@Linea, a.Linea),'')
           AND ISNULL(a.Fabricante,'') = ISNULL(ISNULL(@Fabricante, a.Fabricante),'')
           AND ISNULL(a.Proveedor,'')  = ISNULL(ISNULL(@Proveedor, a.Proveedor),'')
           AND ISNULL(a.ABC,'')        = ISNULL(ISNULL(@ABC, a.ABC),'')
           AND ISNULL(v.Unidad,'')     = ISNULL(ISNULL(@Unidad, v.Unidad),'')
      
        IF @ImporteVenta >= @MontoMinimo
              UPDATE #VentaD
                 SET DescuentoG3 = @Porcentaje,
                     OfertaIDG3 = @OfertaID
               WHERE (NULLIF(OfertaIDG3, 0) IS NULL OR NULLIF(OfertaIDG3, 0) = @OfertaID)
                 AND ISNULL(Categoria, '') = ISNULL(ISNULL(@CategoriaD, Categoria), '')
                 AND ISNULL(Grupo,'')      = ISNULL(ISNULL(@GrupoD, Grupo),'')
                 AND ISNULL(Familia,'')    = ISNULL(ISNULL(@FamiliaD, Familia),'')
                 AND ISNULL(Linea,'')      = ISNULL(ISNULL(@LineaD, Linea),'')
                 AND ISNULL(Fabricante,'') = ISNULL(ISNULL(@FabricanteD, Fabricante),'')
                 AND ISNULL(Proveedor,'')  = ISNULL(ISNULL(@ProveedorD, Proveedor),'')
                 AND ISNULL(ABC,'')        = ISNULL(ISNULL(@ABC, ABC),'')
                 AND ISNULL(Unidad,'')     = ISNULL(ISNULL(@Unidad, Unidad),'')

			    IF @OfertaAplicaLog = 1 AND @OfertaID IS NOT NULL AND @ImporteVenta IS NOT NULL
          BEGIN
                DECLARE logOfertaP3Cruzada CURSOR LOCAL FOR 
                      SELECT d.Articulo, d.unidad, d.SubCuenta,CASE WHEN @CfgImpInc = 1 THEN ISNULL(d.PrecioSugerido,0) / (1+(ISNULL(d.Impuesto1,0)/100))  ELSE ISNULL(d.PrecioSugerido,0) END * ISNULL(d.Cantidad,0)
                        FROM #VentaD d
                       WHERE (NULLIF(OfertaIDG3, 0) IS NULL OR NULLIF(OfertaIDG3, 0) = @OfertaID)
                         AND ISNULL(Categoria, '') = ISNULL(ISNULL(@CategoriaD, Categoria), '')
                         AND ISNULL(Grupo,'')      = ISNULL(ISNULL(@GrupoD, Grupo),'')
                         AND ISNULL(Familia,'')    = ISNULL(ISNULL(@FamiliaD, Familia),'')
                         AND ISNULL(Linea,'')      = ISNULL(ISNULL(@LineaD, Linea),'')
                         AND ISNULL(Fabricante,'') = ISNULL(ISNULL(@FabricanteD, Fabricante),'')
                         AND ISNULL(Proveedor,'')  = ISNULL(ISNULL(@ProveedorD, Proveedor),'')
                         AND ISNULL(ABC,'')        = ISNULL(ISNULL(@ABC, ABC),'')
                         AND ISNULL(Unidad,'')     = ISNULL(ISNULL(@Unidad, Unidad),'')
                OPEN logOfertaP3Cruzada 
                FETCH NEXT FROM logOfertaP3Cruzada INTO @Articulo, @Unidad, @SubCuenta, @Precio
                WHILE @@FETCH_STATUS <> -1 
                BEGIN
                    IF @@FETCH_STATUS <> -2 
                    BEGIN    
					   --Obtiene el valor del Descuento Importe       					
                       SET @PorcentajeImporte = dbo.fnDisminuyePorcentaje(@Precio, @Porcentaje)

                       --Realiza el redondeo del Descuento Importe segun la configuración de la empresa
                       SET @PorcentajeImporte = CAST(ROUND((@PorcentajeImporte),dbo.fnRedondeoDecimales(@Empresa)) AS FLOAT)                    	
                        EXEC spOfertaLog @OfertaID, @Tipo, @Forma, @Usar, @Articulo, @SubCuenta, @Unidad, @Descuento = @Porcentaje, @DescuentoImporte = @PorcentajeImporte, @DescuentoG3 = @Porcentaje, @OfertaIDG3 = @OfertaID--Implementando 
                    END
                  FETCH NEXT FROM logOfertaP3Cruzada INTO @Articulo, @Unidad, @SubCuenta, @Precio
                END
                CLOSE logOfertaP3Cruzada 
                DEALLOCATE logOfertaP3Cruzada
          END
    END          
  END
    FETCH NEXT FROM crOfertaGrupal INTO @OfertaID, @Categoria, @Grupo, @Familia, @Linea, @Fabricante, @Proveedor, @Porcentaje, @Tipo, @MontoMinimo, @CategoriaD, @GrupoD, @FamiliaD, @LineaD, @FabricanteD, @ProveedorD, @ABC, @Unidad, @TipoN, @Forma, @Usar
  END  -- While
  CLOSE crOfertaGrupal
  DEALLOCATE crOfertaGrupal
  RETURN
 END
END
GO

IF EXISTS (SELECT * FROM SysObjects WHERE name='xpOfertaAplicar' AND type='P') DROP PROCEDURE xpOfertaAplicar
GO
CREATE PROCEDURE xpOfertaAplicar
				@ID			int,
				@Aplica		bit OUTPUT
AS
BEGIN
/*	IF (SELECT ISNULL(DescuentoGlobal,0) FROM Venta WHERE ID = @ID)>0
	SELECT @Aplica = 0*/
	RETURN
END
GO
-- xpOfertaAplicarDetalle Para ver si se aplica oferta o no, validacion a nivel detalle
IF EXISTS (SELECT * FROM SysObjects WHERE name='xpOfertaAplicarDetalle' AND type='P') DROP PROCEDURE xpOfertaAplicarDetalle
GO
CREATE PROCEDURE xpOfertaAplicarDetalle
				@ID				int,
				@Articulo		varchar(20),
				@Aplica			bit OUTPUT
AS
BEGIN
/*
	DELETE #VentaD
	FROM VentaD
	WHERE VentaD.Renglon = #VentaD.Renglon AND VentaD.RenglonSub = #VentaD.RenglonSub AND VentaD.Articulo = #VentaD.Articulo 
		  AND VentaD.ID = @ID AND VentaD.Precio <> VentaD.PrecioSugerido
	
	DELETE #VentaD
	FROM VentaD
	WHERE VentaD.Renglon = #VentaD.Renglon AND VentaD.RenglonSub = #VentaD.RenglonSub AND VentaD.Articulo = #VentaD.Articulo 
		  AND VentaD.ID = @ID AND ISNULL(VentaD.DescuentoLinea,0) <> 0
		  
    IF (SELECT ISNULL(DescuentoLinea, 0) FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND OfertaID IS NULL) > 0
      SELECT @Aplica = 0    
*/
	RETURN
END
GO

/**************** spOfertaProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaProcesar') and type = 'P') drop procedure dbo.spOfertaProcesar
GO
CREATE PROCEDURE spOfertaProcesar
			@Empresa		varchar(5),
			@Sucursal		int,
			@Moneda			varchar(10),
			@TipoCambio		float,
			@ListaPrecios	varchar(50),
			@ID				int	= NULL,
			@PuntosPrecio           bit = NULL
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @CfgCostoBase			varchar(50),
    @CfgOfertaNivelopcion	bit, 
    @Articulo				varchar(20), 
    @SubCuenta				varchar(50), 
    @ArtCantidadTotal		float,
    @ArtPrecioSugerido		float,
    @ArtCostoBase			float,
    @ArtPrecio				float, 
    @ArtDescuento			float, 
    @ArtDescuentoImporte	money,
    @ArtPuntos				float, 
    @ArtPuntosPorcentaje	float, 
    @ArtComision			float,
    @ArtComisionPorcentaje	float,
    @ArtOfertaID			int,
    @RID					int,
    @Renglon				float,
    @RenglonSub				int,
    @Aplica					bit,
--EAS 
	@OfertaID				int,
	@Descuento				float,
	@DescuentoP1			float, 
	@DescuentoP2			float, 
	@DescuentoP3			float,
	@DescuentoG1			float,
	@DescuentoG2			float,
	@DescuentoG3			float,
	@Bandera				bit,
	@ArtUnidad				varchar(50),
	@DescuentoAd			float

  SELECT @CfgCostoBase = CostoBase 
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @CfgOfertaNivelopcion = ISNULL(OfertaNivelopcion, 0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  -- Oferta Obsequios Multiples
  EXEC spOfertaObsequiosMultiples @Empresa, @Sucursal, @Moneda, @TipoCambio

  -- Oferta Armada
  EXEC spOfertaArmada @Empresa, @Sucursal, @Moneda, @TipoCambio

  -- Oferta Normal
  IF @CfgOfertaNivelopcion = 1
    DECLARE crVentaD CURSOR LOCAL FOR
     SELECT Articulo, ISNULL(RTRIM(SubCuenta), ''), MIN(PrecioSugerido), SUM(Cantidad)/*SUM(CantidadInventario)*/, Unidad
       FROM #VentaD
      --WHERE NULLIF(OfertaID, 0) IS NULL --Aplicar Ofertas Cascada
      GROUP BY Articulo, ISNULL(RTRIM(SubCuenta), ''), Unidad
  ELSE
    DECLARE crVentaD CURSOR LOCAL FOR
     SELECT Articulo, CONVERT(char(50), ''), MIN(PrecioSugerido), SUM(Cantidad)/*SUM(CantidadInventario)*/, Unidad
       FROM #VentaD
      --WHERE NULLIF(OfertaID, 0) IS NULL--Aplicar Ofertas Cascada
      GROUP BY Articulo, Unidad

    OPEN crVentaD
    
  FETCH NEXT FROM crVentaD INTO @Articulo, @SubCuenta, @ArtPrecioSugerido, @ArtCantidadTotal, @ArtUnidad
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
  
  	SELECT @Aplica = 1
  	EXEC xpOfertaAplicarDetalle @ID, @Articulo, @Aplica OUTPUT
  	
    IF @@FETCH_STATUS <> -2 AND @Aplica = 1
    BEGIN
      SELECT @ArtCostoBase = dbo.fnPCGet(@Empresa, 0, @Moneda, @TipoCambio, @Articulo, @SubCuenta, NULL, @CfgCostoBase)
      SELECT @ArtPrecio = NULL, @ArtDescuento = NULL, @ArtDescuentoImporte = NULL, @ArtPuntos = NULL, @ArtPuntosPorcentaje = NULL,
		     @ArtComision = NULL, @ArtComisionPorcentaje = NULL, @ArtOfertaID = NULL


/**************************************************************************  Prioridad 1 *************************************************/
      EXEC spOfertaNormal @Empresa, @Sucursal, @Moneda, @TipoCambio, @Articulo, @SubCuenta, @ArtCantidadTotal, @ArtCostoBase, @ArtPrecioSugerido, 
			  @ArtPrecio OUTPUT, @ArtDescuento OUTPUT, @ArtDescuentoImporte OUTPUT, @ArtPuntos OUTPUT, @ArtPuntosPorcentaje OUTPUT, 
			  @ArtComision OUTPUT, @ArtComisionPorcentaje OUTPUT, @ArtOfertaID OUTPUT, @CfgOfertaNivelopcion, @PuntosPrecio, 1, @ArtUnidad

      IF @CfgOfertaNivelopcion = 1
        UPDATE #VentaD
		   SET Precio = ISNULL(@ArtPrecio, PrecioSugerido),      
         --SET Precio = @ArtPrecio,
               DescuentoP1 = @ArtDescuento,
               OfertaIDP1 = @ArtOfertaID,
               OfertaID = ISNULL(@ArtOfertaID,OfertaID) --BUG 2808
         WHERE Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta AND Unidad = @ArtUnidad
      ELSE
      	UPDATE #VentaD
		   SET Precio = ISNULL(@ArtPrecio, PrecioSugerido),      
         --SET Precio = @ArtPrecio,
               DescuentoP1 = @ArtDescuento,
               OfertaIDP1 = @ArtOfertaID,
               OfertaID = ISNULL(@ArtOfertaID,OfertaID) --BUG 2808
         WHERE Articulo = @Articulo AND Unidad = @ArtUnidad
	
      SELECT @ArtPrecio = NULL, @ArtDescuento  = NULL, @ArtDescuentoImporte = NULL, 
             @ArtPuntos = NULL, @ArtPuntosPorcentaje = NULL, @ArtComision = NULL, @ArtOfertaID = NULL
/*****************************************************************************************************************************************/

/**************************************************************************  Prioridad 2 *************************************************/
      EXEC spOfertaNormal @Empresa, @Sucursal, @Moneda, @TipoCambio, @Articulo, @SubCuenta, @ArtCantidadTotal, @ArtCostoBase, @ArtPrecioSugerido, 
			  @ArtPrecio OUTPUT, @ArtDescuento OUTPUT, @ArtDescuentoImporte OUTPUT, @ArtPuntos OUTPUT, @ArtPuntosPorcentaje OUTPUT, 
			  @ArtComision OUTPUT, @ArtComisionPorcentaje OUTPUT, @ArtOfertaID OUTPUT, @CfgOfertaNivelopcion, @PuntosPrecio, 2, @ArtUnidad

      IF @CfgOfertaNivelopcion = 1
        UPDATE #VentaD
		   SET Precio = ISNULL(@ArtPrecio, PrecioSugerido),      
         --SET Precio = @ArtPrecio,
               DescuentoP2 = @ArtDescuento,
               Puntos = @ArtPuntos,
	           PuntosPorcentaje = @ArtPuntosPorcentaje,
               OfertaIDP2 = @ArtOfertaID,
               DescuentoImporte = @ArtDescuentoImporte,
               OfertaID = ISNULL(@ArtOfertaID,OfertaID) --BUG 2808
         WHERE Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta AND Unidad = @ArtUnidad
      ELSE
      	UPDATE #VentaD
		   SET Precio = ISNULL(@ArtPrecio, PrecioSugerido),      
         --SET Precio = @ArtPrecio,
               DescuentoP2 = @ArtDescuento,
	           --DescuentoImporte = @ArtDescuentoImporte,
               Puntos = @ArtPuntos,
	           PuntosPorcentaje = @ArtPuntosPorcentaje,
               OfertaIDP2 = @ArtOfertaID,
               DescuentoImporte = @ArtDescuentoImporte,
               OfertaID = ISNULL(@ArtOfertaID,OfertaID) --BUG 2808
         WHERE Articulo = @Articulo AND Unidad = @ArtUnidad

      SELECT @ArtPrecio = NULL, @ArtDescuento  = NULL, @ArtDescuentoImporte = NULL, 
             @ArtPuntos = NULL, @ArtPuntosPorcentaje = NULL, @ArtComision = NULL, @ArtOfertaID = NULL
             
/*****************************************************************************************************************************************/


      EXEC spOfertaNormal @Empresa, @Sucursal, @Moneda, @TipoCambio, @Articulo, @SubCuenta, @ArtCantidadTotal, @ArtCostoBase, @ArtPrecioSugerido, 
			  @ArtPrecio OUTPUT, @ArtDescuento OUTPUT, @ArtDescuentoImporte OUTPUT, @ArtPuntos OUTPUT, @ArtPuntosPorcentaje OUTPUT, 
			  @ArtComision OUTPUT, @ArtComisionPorcentaje OUTPUT, @ArtOfertaID OUTPUT, @CfgOfertaNivelopcion, @PuntosPrecio, 3, @ArtUnidad

      IF @CfgOfertaNivelopcion = 1
        UPDATE #VentaD
			     SET Precio = CASE WHEN Precio <> 0 THEN Precio ELSE PrecioSugerido END,  --BUG 2808
               DescuentoP3 = CASE WHEN PrecioSugerido > 0 THEN @ArtDescuento ELSE NULL END,
               Comision = CASE WHEN PrecioSugerido > 0 THEN @ArtComision ELSE NULL END,
               ComisionPorcentaje = CASE WHEN PrecioSugerido > 0 THEN @ArtComisionPorcentaje ELSE NULL END,
               OfertaIDP3 = CASE WHEN PrecioSugerido > 0 THEN @ArtOfertaID ELSE NULL END,
               OfertaID = CASE WHEN PrecioSugerido > 0 THEN ISNULL(@ArtOfertaID,OfertaID) ELSE NULL END
         WHERE Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta AND Unidad = @ArtUnidad
      ELSE
      	UPDATE #VentaD
      		SET Precio = CASE WHEN Precio <> 0 THEN Precio ELSE PrecioSugerido END,  --BUG 2808
              DescuentoP3 = CASE WHEN PrecioSugerido > 0 THEN @ArtDescuento ELSE NULL END,
              Comision = CASE WHEN PrecioSugerido > 0 THEN @ArtComision ELSE NULL END,
              ComisionPorcentaje = CASE WHEN PrecioSugerido > 0 THEN @ArtComisionPorcentaje ELSE NULL END,
              OfertaIDP3 = CASE WHEN PrecioSugerido > 0 THEN @ArtOfertaID ELSE NULL END,
              OfertaID = CASE WHEN PrecioSugerido > 0 THEN ISNULL(@ArtOfertaID,OfertaID) ELSE NULL END
        WHERE Articulo = @Articulo AND Unidad = @ArtUnidad

    END
    FETCH NEXT FROM crVentaD INTO @Articulo, @SubCuenta, @ArtPrecioSugerido, @ArtCantidadTotal, @ArtUnidad
  END  -- While
  CLOSE crVentaD
  DEALLOCATE crVentaD

  -- Oferta Grupal
  EXEC spOfertaGrupal @Empresa, @Sucursal, @Moneda, @TipoCambio, 1
  EXEC spOfertaGrupal @Empresa, @Sucursal, @Moneda, @TipoCambio, 2
  EXEC spOfertaGrupal @Empresa, @Sucursal, @Moneda, @TipoCambio, 3
  

-----------------------------------------------------------------------------------------
  SET @Bandera = 0
  DECLARE crDesc CURSOR LOCAL FOR 
   SELECT					  RID,	Articulo,	SubCuenta, Unidad, ISNULL(Descuento,0), ISNULL(DescuentoP1,0), ISNULL(DescuentoP2,0), ISNULL(DescuentoP3,0), ISNULL(DescuentoG1,0), ISNULL(DescuentoG2,0), ISNULL(DescuentoG3,0), ISNULL(DescuentoAd,0)
     FROM #VentaD     
  OPEN crDesc
  FETCH NEXT FROM crDesc INTO @RID, @Articulo, @SubCuenta, @ArtUnidad, @Descuento, @DescuentoP1, @DescuentoP2,	@DescuentoP3, @DescuentoG1, @DescuentoG2, @DescuentoG3, @DescuentoAd
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN 
	SELECT @ArtDescuento = NULL,  @ArtOfertaID = NULL
    
    SELECT @DescuentoP1 = @DescuentoP1/100, @DescuentoP2 = @DescuentoP2/100, @DescuentoP3 = @DescuentoP3/100,
           @DescuentoG1 = @DescuentoG1/100, @DescuentoG2 = @DescuentoG2/100, @DescuentoG3 = @DescuentoG3/100, @DescuentoAd = @DescuentoAd/100

	IF @Bandera = 0 AND @DescuentoG1 <> 0 SET @Bandera = 1
	IF @Bandera = 0 AND @DescuentoG2 <> 0 SET @Bandera = 1
	IF @Bandera = 0 AND @DescuentoG3 <> 0 SET @Bandera = 1
	IF @Bandera = 0 AND @DescuentoP1 <> 0 SET @Bandera = 1
	IF @Bandera = 0 AND @DescuentoP2 <> 0 SET @Bandera = 1
	IF @Bandera = 0 AND @DescuentoP3 <> 0 SET @Bandera = 1

    IF @Bandera = 0
		SELECT @Descuento = @Descuento/100
	ELSE
		SELECT @Descuento = 0
           
         
	SELECT @ArtDescuento = 1 - ((1-@DescuentoG1) *(1-@DescuentoG2) *(1-@DescuentoG3) *(1-@DescuentoP1) *(1-@DescuentoP2) *(1-@DescuentoP3) * (1-@Descuento) * (1-@DescuentoAd))
	
	SELECT @ArtDescuento = (ISNULL (@ArtDescuento,0)*100)

	IF (SELECT TOP 1 NULLIF(OfertaIDP3, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad) IS NOT NULL BEGIN  SELECT @ArtOfertaID = NULLIF(OfertaIDP3, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad END ELSE
	IF (SELECT TOP 1 NULLIF(OfertaIDP2, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad) IS NOT NULL BEGIN  SELECT @ArtOfertaID = NULLIF(OfertaIDP2, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad END ELSE
	IF (SELECT TOP 1 NULLIF(OfertaIDP1, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad) IS NOT NULL BEGIN  SELECT @ArtOfertaID = NULLIF(OfertaIDP1, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad END ELSE
	IF (SELECT TOP 1 NULLIF(OfertaIDG3, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad) IS NOT NULL BEGIN  SELECT @ArtOfertaID = NULLIF(OfertaIDG3, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad END ELSE
	IF (SELECT TOP 1 NULLIF(OfertaIDG2, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad) IS NOT NULL BEGIN  SELECT @ArtOfertaID = NULLIF(OfertaIDG2, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad END ELSE
	IF (SELECT TOP 1 NULLIF(OfertaIDG1, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad) IS NOT NULL BEGIN  SELECT @ArtOfertaID = NULLIF(OfertaIDG1, '') FROM #VentaD WHERE RID = @RID AND Articulo = @Articulo AND Subcuenta = ISNULL(@SubCuenta,SubCuenta) AND Unidad = @ArtUnidad END

	--UPDATE #VentaD SET Descuento = CASE WHEN ISNULL(OfertaID,0) = 0 AND ISNULL(Descuento,0) <> 0 THEN Descuento ELSE  @ArtDescuento END, OfertaID = CASE WHEN ISNULL(@ArtOfertaID,0) <> 0 THEN @ArtOfertaID ELSE OfertaID END WHERE RID = @RID AND Articulo = @Articulo AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,ISNULL(Subcuenta,'')) AND Unidad = @ArtUnidad --BUG 2808
    UPDATE #VentaD SET Descuento =  @ArtDescuento , OfertaID = @ArtOfertaID WHERE RID = @RID AND Articulo = @Articulo AND ISNULL(Subcuenta,'') = ISNULL(@SubCuenta,ISNULL(Subcuenta,'')) AND Unidad = @ArtUnidad 

    END
    FETCH NEXT FROM crDesc INTO @RID, @Articulo, @SubCuenta, @ArtUnidad, @Descuento, @DescuentoP1, @DescuentoP2, @DescuentoP3, @DescuentoG1, @DescuentoG2, @DescuentoG3, @DescuentoAd
  END  -- While
  CLOSE crDesc
  DEALLOCATE crDesc

---------------------------------------------------------------------------------------  
  

  --EAS Se Agrega OfertaID
  -- Otorgar Obsequios
  DECLARE crArtObsequio CURSOR LOCAL FOR 
   SELECT Articulo, ISNULL(SubCuenta,''),ISNULL(Unidad,''), OfertaID
     FROM #ArtObsequio
    ORDER BY Articulo
  OPEN crArtObsequio
  FETCH NEXT FROM crArtObsequio INTO @Articulo, @SubCuenta, @ArtUnidad, @OfertaID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN

      SELECT @RID = MIN(RID) 
        FROM #VentaD 
       WHERE Articulo = @Articulo AND ISNULL(Unidad,'') = ISNULL(@ArtUnidad, ISNULL(Unidad,'')) AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta, ISNULL(Subcuenta,'')) AND ISNULL(Cantidad, 0.0) - ISNULL(CantidadObsequio, 0.0) > 0.0 AND RenglonTipo <> 'C'
      
      --IF @RID IS NULL
      --SELECT @RID = MIN(RID) 
      --  FROM #VentaD 
      -- WHERE Articulo = @Articulo AND Unidad = @ArtUnidad /*AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta, ISNULL(Subcuenta,''))*/ AND ISNULL(Cantidad, 0.0) - ISNULL(CantidadObsequio, 0.0) > 0.0


      UPDATE #VentaD
         SET CantidadObsequio = ISNULL(CantidadObsequio, 0.0) + 1.0, OfertaID = @OfertaID
       WHERE RID = @RID AND RenglonTipo <> 'C'
    END
    FETCH NEXT FROM crArtObsequio INTO @Articulo, @SubCuenta, @ArtUnidad, @OfertaID
  END  -- While
  CLOSE crArtObsequio
  DEALLOCATE crArtObsequio

    UPDATE #VentaD SET Descuento = 0.00 WHERE ISNULL(Cantidad,0) < = ISNULL(CantidadObsequio,0) AND ISNULL(CantidadObsequio,0) > 0

  RETURN
END
GO

/**************** spOfertaAplicar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaAplicar') and type = 'P') drop procedure dbo.spOfertaAplicar
GO
CREATE PROCEDURE spOfertaAplicar
    		    @ID               	int,
		    @OfertaFechaHora	varchar(20)	= NULL
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Empresa		varchar(5),
    @Mov		varchar(20),
    @Sucursal		int,
    @Usuario		varchar(10),
    @ListaPrecios	varchar(50),
    @FechaHora		datetime,
    @Estatus		varchar(15),
    @FechaEmision	datetime,
    @FechaRequerida	datetime,
    @HoraRequerida	varchar(5),
    @Moneda		varchar(10),
    @TipoCambio		float,
    @DescuentoGlobal	float,
    @ImporteTotalMN	money,
    @Aplica				bit, -- MPFP 14012009 Se utiliza para xpOfertaAplicar
--    @MovTipo		char(20) -- JGD, No debe de Aplicar Ofertas para Notas en Estatus Borrador	-- MPFP 14012009 Se utiliza para xpOfertaAplicar
	@SucursalDetalle	int,
	@VentaMultiAlmacen	bit,
--REQ 13393 POS
    @Monedero           varchar(20),
    @PuntosPrecio       bit,
	@OfertaAplicaLog	bit


  SET @PuntosPrecio = 0  
  
  
  UPDATE VentaD 
     SET DescuentoLinea = CASE WHEN OfertaID IS NOT NULL THEN NULL ELSE DescuentoLinea END, --NULL, BUG8495
     --CASE WHEN OfertaID IS NOT NULL THEN NULL ELSE DescuentoLinea END,
         OfertaID	= NULL,
         OfertaIDG1 = NULL,
         OfertaIDG2 = NULL,
         OfertaIDG3 = NULL,
         OfertaIDP1 = NULL,
         OfertaIDP2 = NULL,
         OfertaIDP3 = NULL,
         DescuentoG1 = NULL,
         DescuentoG2 = NULL,
         DescuentoG3 = NULL
   WHERE ID = @ID
   
  SELECT @Mov = v.Mov, @Empresa = v.Empresa, @Sucursal = v.Sucursal, @Usuario = v.Usuario, @Moneda = v.Moneda, @TipoCambio = v.TipoCambio, @Estatus = v.Estatus, @ListaPrecios = v.ListaPreciosEsp,
         @FechaEmision = v.FechaEmision, @FechaRequerida = v.FechaRequerida, @HoraRequerida = v.HoraRequerida, @DescuentoGlobal = v.DescuentoGlobal, @Monedero = NULLIF(v.Monedero,'')
         --@MovTipo = mt.Clave
    FROM Venta v 
       JOIN MovTipo mt ON mt.Mov = v.Mov
   WHERE ID = @ID AND mt.Modulo = 'VTAS'

   SELECT @OfertaAplicaLog = CASE 
								WHEN (ISNULL(OfertaAplicaLog, 0) > 0) THEN OfertaAplicaLog
								WHEN (ISNULL(OfertaAplicaLogPOS, 0) > 0) THEN OfertaAplicaLogPOS
								ELSE 0
							 END
	 FROM EmpresaCfg2 ec
	WHERE ec.Empresa = @Empresa

--REQ 13393 POS 


  IF EXISTS(SELECT *  FROM TarjetaSerieMov v JOIN ValeSerie s ON  v.Serie = s.Serie  WHERE v.Empresa = @Empresa AND v.Modulo = 'VTAS' AND v.ID = @ID AND s.TipoTarjeta = 1) 
    SELECT TOP 1 @Monedero = Serie
      FROM TarjetaSerieMov
     WHERE Empresa = @Empresa AND Modulo = 'VTAS' AND ID = @ID   
     
 

  IF NULLIF(@Monedero,'') IS NOT NULL
  SET @PuntosPrecio = 1 

  SELECT @VentaMultiAlmacen = ISNULL(VentaMultiAlmacen,0) FROM EmpresaCfg2 WHERE Empresa = @Empresa   

  SET @Aplica = 1
  EXEC xpOfertaAplicar @ID, @Aplica OUTPUT -- MPFP 14012009 xpOfertaAplicar

  IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND (SELECT AplicarOfertas FROM MovTipo WHERE Modulo = 'VTAS' AND Mov = @Mov) = 1 AND @Aplica = 1 -- MPFP 14012009 xpOfertaAplicar
  BEGIN
--    IF @Estatus <> 'BORRADOR' AND @MovTipo <> 'VTAS.N' --JGD 19Abril2011. Ticket 4390
--    BEGIN
      IF @OfertaFechaHora IS NULL
        SELECT @OfertaFechaHora = OfertaFechaHora 
          FROM EmpresaCfg2
         WHERE Empresa = @Empresa

      IF UPPER(@OfertaFechaHora) = 'FECHA SERVIDOR'  SELECT @FechaHora = GETDATE() ELSE
      IF UPPER(@OfertaFechaHora) = 'FECHA EMISION'   SELECT @FechaHora = @FechaEmision ELSE
      IF UPPER(@OfertaFechaHora) = 'FECHA REQUERIDA' SELECT @FechaHora = dbo.FechaConHora(@FechaRequerida, @HoraRequerida)

      -- #Venta 
      CREATE TABLE #Venta (Campo varchar(50) COLLATE Database_Default NOT NULL, Valor varchar(100) COLLATE Database_Default NULL)
      CREATE TABLE #VentaDetalle (Renglon float, Campo varchar(50) COLLATE Database_Default NOT NULL, Valor varchar(100) COLLATE Database_Default NULL)
      EXEC spOfertaVenta @ID
      CREATE INDEX Campo ON #Venta (Campo, Valor)
      CREATE INDEX Campo ON #VentaDetalle (Renglon, Campo, Valor)

      -- #VentaD 
      CREATE TABLE #VentaD (
	  RID					int NOT NULL IDENTITY(1,1) PRIMARY KEY,
      Renglon				float NOT NULL, 
	  RenglonSub			int NOT NULL, 
      RenglonTipo			varchar(1)  COLLATE Database_Default NULL,  --Ticket 4859
	  Articulo				varchar(20) COLLATE Database_Default NOT NULL, 
	  SubCuenta				varchar(50) COLLATE Database_Default NULL, 
	  Rama					varchar(20) COLLATE Database_Default NULL, 
	  Categoria				varchar(50) COLLATE Database_Default NULL, 
	  Grupo					varchar(50) COLLATE Database_Default NULL, 
	  Familia				varchar(50) COLLATE Database_Default NULL, 
	  Linea					varchar(50) COLLATE Database_Default NULL, 
	  Fabricante			varchar(50) COLLATE Database_Default NULL, 
	  Proveedor				varchar(10) COLLATE Database_Default NULL, 
	  ABC                   varchar(50) COLLATE Database_Default NULL, 
	  Cantidad				float NULL, 
	  Unidad				varchar(50) COLLATE Database_Default NULL, 
	  CantidadInventario	float NULL, 
	  PrecioSugerido		float NULL, 
	  Precio				float NULL,
	  Impuesto1             float NULL, 
	  Descuento				float NULL,
	  DescuentoP1			float NULL,
	  DescuentoP2			float NULL,
	  DescuentoP3			float NULL,
	  DescuentoG1			float NULL,
	  DescuentoG2			float NULL,
	  DescuentoG3			float NULL,
	  DescuentoImporte		money NULL, 
	  Puntos				float NULL, 
	  PuntosPorcentaje		float NULL, 
	  Comision				float NULL, 
	  ComisionPorcentaje	float NULL, 
	  CantidadObsequio		float NULL, 
	  SucursalDetalle	    int	 NULL,
	  Almacen		        varchar(20) COLLATE Database_Default NOT NULL, 
	  OfertaID				int NULL,
	  OfertaIDP1			int NULL,
	  OfertaIDP2			int NULL,
	  OfertaIDP3			int NULL,
	  OfertaIDG1			int NULL,
	  OfertaIDG2			int NULL,
	  OfertaIDG3			int NULL,
	  DescuentoAd			float NULL)
	  
	--EAS Se agrega OfertaID
	--JLMR Se agrega la Unidad
    --CREATE TABLE #ArtObsequio (Articulo varchar(20) COLLATE Database_Default NOT NULL)
    CREATE TABLE #ArtObsequio (Articulo varchar(20) COLLATE Database_Default NOT NULL, OfertaID INT NULL, Unidad varchar(50) NULL, SubCuenta varchar(50) NULL)

      -- #OfertaLog 
    CREATE TABLE #OfertaLog (
    RID					        int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    OfertaID            int NOT NULL,
    Mov                 varchar(20)NULL,
    MovID               varchar(20)NULL,
    Prioridad				    int NULL,
    PrioridadG			    int NULL,
    Tipo                varchar(50)NULL,
    Forma               varchar(50)NULL,
    Usar                varchar(50)NULL,
    Articulo				    varchar(20) COLLATE Database_Default NOT NULL, 
    SubCuenta				    varchar(50) COLLATE Database_Default NULL, 
    Unidad				      varchar(50) COLLATE Database_Default NULL, 
    Descuento				    float NULL,
    DescuentoImporte		money NULL, 
    Puntos				      float NULL, 
    PuntosPorcentaje		float NULL, 
    Comision				    float NULL, 
    ComisionPorcentaje	float NULL, 
    CantidadObsequio		float NULL,
    Costo					      float NULL,
    PrecioBaseCosto		  float NULL,
    PrecioBaseLista		  float NULL,
    Precio				      float NULL,
    ArticuloObsequio		varchar(20)NULL,
    UnidadObsequio		  varchar(50) NULL,
    SubCuentaObsequio varchar(50) NULL,
    ArtTipo				      varchar(20)NULL,
    CantidadOferta		  float NULL,
    DescuentoP1			    float NULL,
    DescuentoP2			    float NULL,
    DescuentoP3			    float NULL,
    DescuentoG1			    float NULL,
    DescuentoG2			    float NULL,
    DescuentoG3			    float NULL,
    SucursalDetalle	    int	 NULL,
    OfertaIDP1			    int NULL,
    OfertaIDP2			    int NULL,
    OfertaIDP3			    int NULL,
    OfertaIDG1			    int NULL,
    OfertaIDG2			    int NULL,
    OfertaIDG3			    int NULL,
    Descripcion			    varchar(255) NULL)

      INSERT #VentaD (
             Renglon,   RenglonSub,   RenglonTipo,   Articulo,   SubCuenta,   Rama,   Categoria,   Grupo,   Familia,   Linea,   Fabricante,   Proveedor,   ABC, Cantidad,   Unidad,   PrecioSugerido, Impuesto1, CantidadInventario, Almacen, OfertaID, OfertaIDP1, OfertaIDP2, OfertaIDP3, OfertaIDG1, OfertaIDG2, OfertaIDG3, DescuentoP1, DescuentoP2, DescuentoP3, DescuentoG1, DescuentoG2, DescuentoG3, Descuento, SucursalDetalle)
      SELECT d.Renglon, d.RenglonSub, d.RenglonTipo, d.Articulo, d.SubCuenta, a.Rama, a.Categoria, a.Grupo, a.Familia, a.Linea, a.Fabricante, a.Proveedor, a.ABC, d.Cantidad, d.Unidad, PrecioSugerido, d.Impuesto1, ISNULL(ISNULL(d.CantidadInventario, d.Cantidad*dbo.fnArtUnidadFactor(@Empresa, d.Articulo, d.Unidad)), 0.0), ISNULL(d.Almacen,v.Almacen), d.OfertaID, d.OfertaIDP1, d.OfertaIDP2, d.OfertaIDP3, d.OfertaIDG1, d.OfertaIDG2, d.OfertaIDG3, d.DescuentoP1, d.DescuentoP2, d.DescuentoP3, d.DescuentoG1, d.DescuentoG2, d.DescuentoG3, d.DescuentoLinea, ISNULL(d.Sucursal,v.Sucursal)
        FROM VentaD d
        JOIN Venta v ON d.ID = v.ID
        JOIN Art a ON a.Articulo = d.Articulo
       WHERE d.ID = @ID AND ISNULL(d.AnticipoFacturado,0) = 0
      CREATE INDEX Renglon     ON #VentaD (Renglon, RenglonSub)
      CREATE INDEX Articulo    ON #VentaD (Articulo)
      CREATE INDEX Rama        ON #VentaD (Rama)
      CREATE INDEX Categoria   ON #VentaD (Categoria)
      CREATE INDEX Grupo       ON #VentaD (Grupo)
      CREATE INDEX Familia     ON #VentaD (Familia)
      CREATE INDEX Linea       ON #VentaD (Linea)
      CREATE INDEX Fabricante  ON #VentaD (Fabricante)
      CREATE INDEX RenglonTipo ON #VentaD (Renglon, RenglonSub, RenglonTipo)
      -- #OfertaActiva
      CREATE TABLE #OfertaActiva (ID int NOT NULL, Sucursal int NOT NULL, MovTipo varchar(20) COLLATE Database_Default NULL PRIMARY KEY (ID, Sucursal))

      IF @VentaMultiAlmacen = 0
      BEGIN   
          EXEC spOfertaPrecioSugerido @Empresa, @Sucursal, @Moneda, @TipoCambio, @ListaPrecios

          SELECT @ImporteTotalMN = SUM(Cantidad*PrecioSugerido)*@TipoCambio FROM #VentaD
          
          EXEC spOfertaActiva @Empresa, @Sucursal, @FechaHora, @ImporteTotalMN

          EXEC spOfertaProcesar @Empresa, @Sucursal, @Moneda, @TipoCambio, @ListaPrecios, @ID, @PuntosPrecio
	  END
	  ELSE
	  BEGIN
        DECLARE crSucursalDetalleOferta CURSOR FOR
         SELECT SucursalDetalle
           FROM #VentaD 
          GROUP BY SucursalDetalle

        OPEN crSucursalDetalleOferta
        FETCH NEXT FROM crSucursalDetalleOferta INTO @SucursalDetalle
        WHILE @@FETCH_STATUS <> -1 
        BEGIN
          EXEC spOfertaPrecioSugerido @Empresa, @SucursalDetalle, @Moneda, @TipoCambio, @ListaPrecios

          SELECT @ImporteTotalMN = SUM(Cantidad*PrecioSugerido)*@TipoCambio FROM #VentaD
          EXEC spOfertaActiva @Empresa, @SucursalDetalle, @FechaHora, @ImporteTotalMN
--REQ 13393 POS

          EXEC spOfertaProcesar @Empresa, @SucursalDetalle, @Moneda, @TipoCambio, @ListaPrecios, @ID, @PuntosPrecio

          FETCH NEXT FROM crSucursalDetalleOferta INTO @SucursalDetalle
        END  -- While	
        CLOSE crSucursalDetalleOferta
        DEALLOCATE crSucursalDetalleOferta
	  END

      UPDATE #VentaD
         SET Precio = 0.00, PrecioSugerido = 0.00
       WHERE Articulo IN(SELECT d.Opcion FROM ArtJuego j JOIN ArtJuegoD d ON j.Articulo = d.Articulo AND j.Juego = d.Juego WHERE ISNULL(j.PrecioIndependiente,0) = 0)
       AND RenglonTipo <> 'N' AND RenglonTipo <> 'S' AND RenglonTipo <> 'L'

      UPDATE #VentaD
         SET Descuento = dbo.fnPorcentajeImporte(Cantidad*Precio, DescuentoImporte)
       WHERE NULLIF(DescuentoImporte, 0.0) IS NOT NULL
	  
      UPDATE #VentaD
         SET Puntos = CASE
						WHEN EXISTS(SELECT ID FROM Oferta WHERE Estatus = 'VIGENTE' AND (TIPO LIKE '%PUNTOS%' OR FORMA LIKE '%CANTIDAD%'))
							THEN Puntos
						ELSE 
							dbo.fnPorcentaje(dbo.fnDisminuyePorcentaje(Cantidad*Precio, Descuento), PuntosPorcentaje)
						END
       WHERE NULLIF(PuntosPorcentaje, 0.0) IS NOT NULL
	    
      UPDATE #VentaD
         SET Puntos = CASE
						WHEN EXISTS(SELECT ID FROM Oferta WHERE Estatus = 'VIGENTE' AND (TIPO LIKE '%PUNTOS%' OR FORMA LIKE '%CANTIDAD%'))
							THEN Puntos
						ELSE 
							Puntos*Cantidad
					   END
       WHERE Puntos IS NOT NULL AND NULLIF(PuntosPorcentaje, 0.0) IS NULL

      UPDATE #VentaD
         SET Comision = dbo.fnPorcentaje(dbo.fnDisminuyePorcentaje(Cantidad*Precio, Descuento), ComisionPorcentaje)
       WHERE NULLIF(ComisionPorcentaje, 0.0) IS NOT NULL

      UPDATE VentaD
         SET /*Factor = t.CantidadInventario/NULLIF(t.Cantidad, 0.0),
             CantidadInventario = t.CantidadInventario,*/
             PrecioSugerido = ISNULL(d.PrecioSugerido, t.PrecioSugerido),
             Precio = ISNULL(t.Precio, t.PrecioSugerido),
             DescuentoLinea = t.Descuento,
             DescuentoP1 = t.DescuentoP1,
             DescuentoP2 = t.DescuentoP2,
             DescuentoP3 = t.DescuentoP3,
             DescuentoG1 = t.DescuentoG1,
             DescuentoG2 = t.DescuentoG2,
             DescuentoG3 = t.DescuentoG3,
             DescuentoImporte = NULL,
             Puntos = CASE WHEN @Monedero IS NOT NULL THEN  t.Puntos ELSE NULL END,
             Comision = t.Comision,
             CantidadObsequio = t.CantidadObsequio,
             OfertaID = t.OfertaID,
             OfertaIDP1 = t.OfertaIDP1,
             OfertaIDP2 = t.OfertaIDP2,
             OfertaIDP3 = t.OfertaIDP3,
             OfertaIDG1 = t.OfertaIDG1,
             OfertaIDG2 = t.OfertaIDG2,
             OfertaIDG3 = t.OfertaIDG3
        FROM VentaD d 
        JOIN #VentaD t ON t.Renglon = d.Renglon AND t.RenglonSub = d.RenglonSub
       WHERE d.ID = @ID

       IF @OfertaAplicaLog = 1
	   BEGIN
		   --Eliminar OfertaLog
		   DELETE OfertaLog WHERE ID = @ID

		   INSERT OfertaLog (ID, OfertaID, RID, Prioridad, PrioridadG, Mov,
				  MovID, Tipo, Forma, Usar, Articulo,
				  SubCuenta, Unidad, Descuento, DescuentoImporte, Costo, 
				  PrecioBaseCosto, PrecioBaseLista, Precio, Puntos, PuntosPorcentaje,
				  Comision, ArticuloObsequio, CantidadObsequio, ComisionPorcentaje, UnidadObsequio, 
				  DescuentoP1,DescuentoP2, DescuentoP3, DescuentoG1, DescuentoG2, 
				  DescuentoG3, OfertaIDP1, OfertaIDP2, OfertaIDP3, OfertaIDG1,
				  OfertaIDG2, OfertaIDG3, Descripcion, SubCuentaObsequio)
		   SELECT @ID, OfertaID, RID, Prioridad, PrioridadG, Mov,
				  MovID, Tipo, Forma, Usar, Articulo,
				  SubCuenta, Unidad, Descuento, DescuentoImporte, Costo, 
				  PrecioBaseCosto, PrecioBaseLista, Precio, Puntos, PuntosPorcentaje,
				  Comision, ArticuloObsequio, CantidadObsequio, ComisionPorcentaje, UnidadObsequio, 
				  DescuentoP1,DescuentoP2, DescuentoP3, DescuentoG1, DescuentoG2, 
				  DescuentoG3, OfertaIDP1, OfertaIDP2, OfertaIDP3, OfertaIDG1,
				  OfertaIDG2, OfertaIDG3, Descripcion, SubCuentaObsequio
			 FROM #OfertaLog
		   --Insertar en OfertaLog (fisica) a partir de temporal
	   END
       EXEC spInvReCalcEncabezadoSimple @Empresa, @ID, 'VTAS'
      END
    --END
  RETURN
END
GO
