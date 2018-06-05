/**************** xp_ValidarCodigoBarras ****************/
if exists (select * from sysobjects where id = object_id('dbo.xp_ValidarCodigoBarras') and sysstat & 0xf = 4) drop procedure dbo.xp_ValidarCodigoBarras
GO
CREATE PROCEDURE xp_ValidarCodigoBarras
			@Codigo		char(20),

			@Articulo	char(20)	OUTPUT,
			@SubCuenta	varchar(20)	OUTPUT,
			@Unidad		varchar(50)	OUTPUT,
			@Veces		Float		OUTPUT,
		    	@Ok		int		OUTPUT,
    			@OkRef		varchar(255)	OUTPUT

AS BEGIN
  SELECT @Articulo  = NULLIF(RTRIM(Cuenta), ''), 
         @SubCuenta = NULLIF(RTRIM(SubCuenta), ''), 
         @Unidad    = NULLIF(RTRIM(Unidad), ''),
         @Veces     = ISNULL(NULLIF(Cantidad, 0.0), 1.0)
    FROM CB
    WHERE Codigo = @Codigo
  IF @@ROWCOUNT = 0 SELECT @Ok = 72040, @OkRef = @Codigo
END
GO


/**************** xp_ValidarArticulo ****************/
if exists (select * from sysobjects where id = object_id('dbo.xp_ValidarArticulo') and sysstat & 0xf = 4) drop procedure dbo.xp_ValidarArticulo
GO
CREATE PROCEDURE xp_ValidarArticulo
			@Articulo	char(20),
			@SubCuenta	varchar(20),
			@ZonaImpuesto	varchar(30),

			@ArtTipo	char(20)	OUTPUT,
			@RenglonTipo	char(1)		OUTPUT,
			@Impuesto1	float		OUTPUT,
			@Impuesto2	float		OUTPUT,
			@Impuesto3	money		OUTPUT,
		    	@Ok		int		OUTPUT,
    			@OkRef		varchar(255)	OUTPUT
AS BEGIN
  SELECT @ArtTipo   = Tipo,
         @Impuesto1 = Impuesto1,
         @Impuesto2 = Impuesto2,
         @Impuesto3 = Impuesto3
    FROM Art 
   WHERE Articulo = @Articulo
  IF @@ROWCOUNT = 0 SELECT @Ok = 72050, @OkRef = @Articulo

  EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
  EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT 
  EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT 
END
GO

/**************** xp_ValidarVentaD ****************/
if exists (select * from sysobjects where id = object_id('dbo.xp_ValidarVentaD') and sysstat & 0xf = 4) drop procedure dbo.xp_ValidarVentaD
GO
CREATE PROCEDURE xp_ValidarVentaD
			@Articulo		char(20),
			@Moneda			char(10),
			@ListaPrecios		varchar(20),
			@Veces			float,
			@Precio			money	OUTPUT,
			@Renglon		float	OUTPUT,
			@RenglonID		int	OUTPUT,
			@Cantidad		float	OUTPUT,
			@CantidadInventario	float	OUTPUT,
			@Factor			float	OUTPUT
AS BEGIN
-- Falta Considerar Otras Monedas ???
  SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1, @Cantidad = @Cantidad * @Veces, @CantidadInventario = ISNULL(@CantidadInventario, @Cantidad), @Factor = ISNULL(NULLIF(@Factor, 0.0), 1.0)
  IF @Precio IS NULL
    SELECT @Precio = CASE @ListaPrecios 
                       WHEN '(Precio Lista)' THEN PrecioLista 
                       WHEN '(Precio 2)'     THEN Precio2
                       WHEN '(Precio 3)'     THEN Precio3
                       WHEN '(Precio 4)'     THEN Precio4
                       WHEN '(Precio 5)'     THEN Precio5
                       WHEN '(Precio 6)'     THEN Precio6
                       WHEN '(Precio 7)'     THEN Precio7
                       WHEN '(Precio 8)'     THEN Precio8
                       WHEN '(Precio 9)'     THEN Precio9
                       WHEN '(Precio 10)'    THEN Precio10
                     END
       FROM Art
      WHERE Articulo = @Articulo
  IF @Precio IS NULL 
    SELECT @Precio = Precio FROM ListaPreciosD WHERE Lista = @ListaPrecios AND Moneda = @Moneda AND Articulo = @Articulo
END
GO

/**************** xp_VentaCamposEncabezado ****************/
if exists (select * from sysobjects where id = object_id('dbo.xp_VentaCamposEncabezado') and sysstat & 0xf = 4) drop procedure dbo.xp_VentaCamposEncabezado
GO
CREATE PROCEDURE xp_VentaCamposEncabezado
    			@Campo			varchar(50),
    			@Dato			varchar(100),

    			@FechaEmision		datetime	OUTPUT,
    			@FechaRequerida		datetime	OUTPUT,
    			@FechaOriginal		datetime	OUTPUT,
    			@FechaOrdenCompra	datetime	OUTPUT,
    			@SituacionFecha		datetime	OUTPUT,
    			@Vencimiento		datetime	OUTPUT,
    			@Departamento		int		OUTPUT,
    			@EnviarA		int		OUTPUT,
    			@Cliente		char(10)	OUTPUT,
    			@Moneda			char(10)	OUTPUT,
    			@Almacen		char(10)	OUTPUT,
    			@Agente 		char(10)	OUTPUT,
    			@CtaDinero		char(10)	OUTPUT,
    			@Prioridad		char(10)	OUTPUT,
    			@Concepto		varchar(50)	OUTPUT,
    			@Proyecto		varchar(50)	OUTPUT,
    			@FormaEnvio 		varchar(50)	OUTPUT,
    			@ListaPreciosEsp	varchar(20)	OUTPUT,
    			@OrdenCompra		varchar(50)	OUTPUT,
    			@Condicion 		varchar(50)	OUTPUT,
    			@Descuento		varchar(30)	OUTPUT,
    			@ZonaImpuesto		varchar(30)	OUTPUT,
    			@Atencion		varchar(50)	OUTPUT,
    			@Situacion		varchar(50)	OUTPUT,
    			@Referencia		varchar(50)	OUTPUT,
    			@Observaciones		varchar(100)	OUTPUT,

    			@ServicioTipo		varchar(50)	OUTPUT,
    			@ServicioArticulo	varchar(20)	OUTPUT,
    			@ServicioSerie		varchar(20)	OUTPUT,
    			@ServicioDescripcion   	varchar(100)	OUTPUT,
    			@ServicioIdentificador 	varchar(20)	OUTPUT,
    			@ServicioContrato	varchar(20)	OUTPUT,
    			@ServicioContratoTipo  	varchar(50)	OUTPUT,
    			@ServicioContratoID	varchar(20)	OUTPUT,
    			@ServicioGarantia	bit		OUTPUT,
    			@ServicioFecha	   	datetime	OUTPUT,

		    	@Ok			int		OUTPUT,
    			@OkRef			varchar(255)	OUTPUT

AS BEGIN
  IF @Campo = 'FechaEmision'     	SELECT @FechaEmision    	= CONVERT(datetime, @Dato, 103) ELSE
  IF @Campo = 'FechaRequerida'   	SELECT @FechaRequerida  	= CONVERT(datetime, @Dato, 103) ELSE
  IF @Campo = 'FechaOriginal'    	SELECT @FechaOriginal   	= CONVERT(datetime, @Dato, 103) ELSE
  IF @Campo = 'FechaOrdenCompra' 	SELECT @FechaOrdenCompra	= CONVERT(datetime, @Dato, 103) ELSE
  IF @Campo = 'SituacionFecha'   	SELECT @SituacionFecha  	= CONVERT(datetime, @Dato, 103) ELSE
  IF @Campo = 'Vencimiento' 	   	SELECT @Vencimiento     	= CONVERT(datetime, @Dato, 103), @Condicion = '(Fecha)' ELSE
  IF @Campo = 'Departamento' 	   	SELECT @Departamento	   	= CONVERT(int, @Dato) ELSE
  IF @Campo = 'EnviarA' 	   	SELECT @EnviarA		   	= CONVERT(int, @Dato) ELSE
  IF @Campo = 'Cliente'        		SELECT @Cliente		       	= @Dato ELSE
  IF @Campo = 'Almacen'    	   	SELECT @Almacen 	   	= @Dato ELSE
  IF @Campo = 'Agente'    	   	SELECT @Agente 	   		= @Dato ELSE
  IF @Campo = 'CtaDinero'        	SELECT @CtaDinero       	= @Dato ELSE
  IF @Campo = 'Prioridad' 	   	SELECT @Prioridad	   	= @Dato ELSE
  IF @Campo = 'Concepto'    	   	SELECT @Concepto 	   	= @Dato ELSE
  IF @Campo = 'Proyecto'    	   	SELECT @Proyecto        	= @Dato ELSE
  IF @Campo = 'FormaEnvio'       	SELECT @FormaEnvio 	   	= @Dato ELSE
  IF @Campo = 'ListaPreciosEsp'  	SELECT @ListaPreciosEsp 	= @Dato ELSE
  IF @Campo = 'OrdenCompra'      	SELECT @OrdenCompra     	= @Dato ELSE
  IF @Campo = 'Condicion'    	   	SELECT @Condicion 	   	= @Dato ELSE
  IF @Campo = 'Descuento'    	   	SELECT @Descuento 	   	= @Dato ELSE
  IF @Campo = 'ZonaImpuesto' 	   	SELECT @ZonaImpuesto	   	= @Dato ELSE
  IF @Campo = 'Atencion' 	   	SELECT @Atencion	   	= @Dato ELSE
  IF @Campo = 'Situacion' 	   	SELECT @Situacion	   	= @Dato ELSE
  IF @Campo = 'Referencia'       	SELECT @Referencia 	   	= @Dato ELSE
  IF @Campo = 'Observaciones'    	SELECT @Observaciones   	= @Dato ELSE
  IF @Campo = 'ServicioTipo'     	SELECT @ServicioTipo    	= @Dato ELSE
  IF @Campo = 'ServicioArticulo' 	SELECT @ServicioArticulo	= @Dato ELSE
  IF @Campo = 'ServicioSerie'    	SELECT @ServicioSerie   	= @Dato ELSE
  IF @Campo = 'ServicioDescripcion' 	SELECT @ServicioDescripcion	= @Dato ELSE
  IF @Campo = 'ServicioIdentificador'	SELECT @ServicioIdentificador	= @Dato ELSE
  IF @Campo = 'ServicioContrato' 	SELECT @ServicioContrato	= @Dato ELSE
  IF @Campo = 'ServicioContratoTipo' 	SELECT @ServicioContratoTipo	= @Dato ELSE
  IF @Campo = 'ServicioContratoID' 	SELECT @ServicioContratoID 	= CONVERT(int, @Dato) ELSE
  IF @Campo = 'ServicioGarantia' 	SELECT @ServicioGarantia	= CONVERT(bit, @Dato) ELSE
  IF @Campo = 'ServicioFecha' 		SELECT @ServicioFecha		= CONVERT(datetime, @Dato, 103) 

  RETURN
END
GO

/**************** xp_VentaCamposDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.xp_VentaCamposDetalle') and sysstat & 0xf = 4) drop procedure dbo.xp_VentaCamposDetalle
GO
CREATE PROCEDURE xp_VentaCamposDetalle
			@CodigosNumericos	bit,
			@ZonaImpuesto		varchar(30),
    			@Campo			varchar(50),
    			@Dato			varchar(100),

    			@Articulo		char(20)	OUTPUT,
    			@SubCuenta		varchar(20)	OUTPUT,
    			@Unidad			varchar(50)	OUTPUT,
    			@Almacen		char(10)	OUTPUT,
    			@DescripcionExtra	varchar(100)	OUTPUT,
    			@SustitutoArticulo  	varchar(20)	OUTPUT,
    			@SustitutoSubCuenta	varchar(20)	OUTPUT,
    			@Instruccion		varchar(50)	OUTPUT,
    			@Agente 		char(10)	OUTPUT,
    			@Paquete		int		OUTPUT,
    			@Departamento		int		OUTPUT,
    			@FechaRequerida		datetime	OUTPUT,
			@Veces			float		OUTPUT,
    			@Cantidad		float		OUTPUT,
    			@CantidadInventario	float		OUTPUT,
    			@Factor			float		OUTPUT,
    			@Precio			money		OUTPUT,
    			@DescuentoLinea		money		OUTPUT,
    			@Costo			money		OUTPUT,
			@Impuesto1		float		OUTPUT,
			@Impuesto2		float		OUTPUT,
			@Impuesto3		money		OUTPUT,
    			@ArtTipo		varchar(20)	OUTPUT,
			@RenglonTipo		char(1)		OUTPUT,

		    	@Ok			int		OUTPUT,
    			@OkRef			varchar(255)	OUTPUT
AS BEGIN
  DECLARE
    @UltArticulo	char(20)

  SELECT @UltArticulo = @Articulo

  IF @Campo = 'Articulo' 		SELECT @Articulo           = @Dato ELSE
  IF @Campo = 'SubCuenta' 		SELECT @SubCuenta          = @Dato ELSE
  IF @Campo = 'Unidad'			SELECT @Unidad             = @Dato ELSE
  IF @Campo = 'Almacen' 		SELECT @Almacen            = @Dato ELSE
  IF @Campo = 'DescripcionExtra'	SELECT @DescripcionExtra   = @Dato ELSE
  IF @Campo = 'SustitutoArticulo' 	SELECT @SustitutoArticulo  = @Dato ELSE
  IF @Campo = 'SustitutoSubCuenta' 	SELECT @SustitutoSubCuenta = @Dato ELSE
  IF @Campo = 'Instruccion'      	SELECT @Instruccion        = @Dato ELSE
  IF @Campo = 'Agente'           	SELECT @Agente             = @Dato ELSE
  IF @Campo = 'Paquete'			SELECT @Paquete            = CONVERT(int, @Dato) ELSE
  IF @Campo = 'Departamento' 	        SELECT @Departamento 	   = CONVERT(int, @Dato) ELSE
  IF @Campo = 'FechaRequerida'        	SELECT @FechaRequerida     = CONVERT(datetime, @Dato, 103) ELSE
  IF @Campo = 'Cantidad' 		SELECT @Cantidad           = CONVERT(float, @Dato) ELSE
  IF @Campo = 'CantidadInventario' 	SELECT @CantidadInventario = CONVERT(float, @Dato) ELSE
  IF @Campo = 'Factor' 			SELECT @Factor             = CONVERT(float, @Dato) ELSE
  IF @Campo = 'Precio'   		SELECT @Precio             = CONVERT(money, @Dato) ELSE
  IF @Campo = 'DescuentoLinea'		SELECT @DescuentoLinea     = CONVERT(money, @Dato) ELSE
  IF @Campo = 'Costo'   		SELECT @Costo              = CONVERT(money, @Dato) ELSE
  IF @Campo = 'Codigo'
  BEGIN
    IF @CodigosNumericos = 0 OR dbo.fnEsNumerico(@Dato) = 1
      EXEC xp_ValidarCodigoBarras @Dato, @Articulo OUTPUT, @SubCuenta OUTPUT, @Unidad OUTPUT, @Veces OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END

  -- Si Cambio el Articulo
  IF @Articulo <> @UltArticulo
    EXEC xp_ValidarArticulo @Articulo, @SubCuenta, @ZonaImpuesto, @ArtTipo OUTPUT, @RenglonTipo OUTPUT, @Impuesto1 OUTPUT, @Impuesto2 OUTPUT, @Impuesto3 OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO


/**************** xp_OrdenCompra_bCentral ****************/
if exists (select * from sysobjects where id = object_id('dbo.xp_OrdenCompra_bCentral') and sysstat & 0xf = 4) drop procedure dbo.xp_OrdenCompra_bCentral
GO             
CREATE PROCEDURE xp_OrdenCompra_bCentral
                     @Plantilla		varchar(50),
	             @Direccion		varchar(255),
		     @Empresa		char(5),
		     @Usuario		char(10),
		     @Estacion		int
AS BEGIN
  DECLARE
    @Ok				int,
    @OkRef			varchar(255),
    @Clave 			varchar(100),
    @Campo			varchar(50),
    @Dato			varchar(100),
    @PlantillaTipo		varchar(50),
    @Encabezado			bit,
    @p				int,

    @ID				int,
    @OrigenTipo			char(10),	
    @Modulo			char(5),
    @Icono			int,
    @Mov			varchar(20),
    @Estatus			char(15),
    @Prioridad			char(10),
    @FechaEmision		datetime,
    @FechaRequerida		datetime,
    @FechaOriginal		datetime,
    @FechaOrdenCompra		datetime,
    @Descuento			varchar(30),
    @DescuentoGlobal		float,
    @Almacen			char(10),
    @CtaDinero			char(10),
    @Concepto			varchar(50),
    @Proyecto			varchar(50),
    @Moneda			char(10),
    @TipoCambio			float,
    @Referencia			varchar(50),
    @Observaciones		varchar(100),
    @OrdenCompra		varchar(50),
    @Cliente			char(10),
    @EnviarA			int,
    @Agente 			char(10),
    @FormaEnvio 		varchar(50),
    @Condicion 			varchar(50),
    @Vencimiento		datetime,
    @ListaPreciosEsp		varchar(20),
    @ZonaImpuesto		varchar(30),
    @Atencion			varchar(50),
    @Situacion			varchar(50),
    @SituacionFecha		datetime,
    @Departamento		int,
    @ServicioTipo		varchar(50),
    @ServicioArticulo		varchar(20),
    @ServicioSerie		varchar(20),
    @ServicioContrato		varchar(20),
    @ServicioContratoID	   	int,
    @ServicioContratoTipo  	varchar(50),
    @ServicioGarantia	   	bit,
    @ServicioDescripcion   	varchar(100),
    @ServicioFecha	   	datetime,
    @ServicioIdentificador 	varchar(20),

    @Articulo			char(20),
    @SubCuenta			varchar(20),
    @Unidad			varchar(50),
    @Cantidad			float,
    @Factor			float,
    @CantidadInventario		float,
    @Precio			money,
    @Costo			money,
    @DescuentoLinea		money,
    @DescripcionExtra		varchar(100), 
    @SustitutoArticulo  	varchar(20),
    @SustitutoSubCuenta		varchar(20),
    @Instruccion		varchar(50),
    @Paquete			int,

    @Veces			float,
    @Renglon			float,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @ArtTipo			varchar(20),
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money

  -- Inicializar Variables
  SELECT @Encabezado 	= 1,
         @Renglon    	= 0.0,
         @Factor	= 1.0,
         @Modulo        = 'VTAS',
         @Icono		= 51,
         @OrigenTipo 	= 'Excel', 
         @Estatus 	= 'CONFIRMAR',
         @Prioridad     = 'Normal',
         @FechaEmision 	= GETDATE()

  EXEC spExtraerFecha @FechaEmision OUTPUT

  -- Leer la Plantilla Excel
  SELECT @Mov           = Mov,
         @Cliente       = Cliente,
         @EnviarA       = EnviarA,
         @Almacen       = Almacen,
         @PlantillaTipo = Tipo
    FROM Excel
   WHERE Plantilla = @Plantilla
  IF @@ROWCOUNT = 0 SELECT @Ok = 72020

  IF @Cliente IS NOT NULL 
    SELECT @Proyecto        = Proyecto, 
           @EnviarA         = EnviarA, 
           @Agente          = Agente, 
           @FormaEnvio      = FormaEnvio, 
           @Condicion       = Condicion, 
           @Descuento       = Descuento, 
           @ListaPreciosEsp = ListaPreciosEsp, 
           @ZonaImpuesto    = ZonaImpuesto, 
           @Moneda          = DefMoneda
      FROM Cte
     WHERE Cliente = @Cliente
  ELSE SELECT @Ok = 72030

  BEGIN TRANSACTION
    DECLARE crListaSt CURSOR FOR
      SELECT NULLIF(RTRIM(LTRIM(Clave)), '') FROM ListaSt WHERE Estacion = @Estacion

    OPEN crListaSt

    -- Validar el Encabezado del Archivo
    FETCH NEXT FROM crListaSt INTO @Clave
    IF @Clave <> +'['+@Plantilla+']' SELECT @Ok = 72010

    FETCH NEXT FROM crListaSt INTO @Clave
    WHILE @@FETCH_STATUS <> -1 AND @Clave IS NOT NULL AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @p = CHARINDEX('=', @Clave)
        IF @p > 0 
        BEGIN
          SELECT @Campo = RTRIM(SUBSTRING(@Clave, 1, @p-1)), 
                 @Dato  = RTRIM(SUBSTRING(@Clave, @p+1, LEN(@Clave)-@p))

          IF @Encabezado = 1 
            EXEC xp_VentaCamposEncabezado @Campo, @Dato, 
					  @FechaEmision OUTPUT, @FechaRequerida OUTPUT, @FechaOriginal OUTPUT, 	@FechaOrdenCompra OUTPUT, 	@SituacionFecha OUTPUT, @Vencimiento OUTPUT, 
                                          @Departamento OUTPUT, @EnviarA OUTPUT, 	@Cliente OUTPUT, 	@Moneda OUTPUT, 		@Almacen OUTPUT, 	@Agente OUTPUT, 
					  @CtaDinero OUTPUT, 	@Prioridad OUTPUT, 	@Concepto OUTPUT, 	@Proyecto, 			@FormaEnvio OUTPUT, 	@ListaPreciosEsp OUTPUT, 
					  @OrdenCompra OUTPUT, 	@Condicion OUTPUT, 	@Descuento OUTPUT, 	@ZonaImpuesto OUTPUT, 		@Atencion OUTPUT, 	
					  @Situacion OUTPUT, 	@Referencia OUTPUT, 	@Observaciones OUTPUT,	
					  @ServicioTipo OUTPUT,		@ServicioArticulo OUTPUT,	@ServicioSerie OUTPUT, 		@ServicioDescripcion OUTPUT, 	@ServicioIdentificador OUTPUT, 	
					  @ServicioContrato OUTPUT, 	@ServicioContratoTipo OUTPUT, 	@ServicioContratoID OUTPUT, 	@ServicioGarantia OUTPUT, 	@ServicioFecha OUTPUT,
                   		          @Ok OUTPUT, @OkRef OUTPUT
          ELSE 
	    EXEC xp_VentaCamposDetalle 1, @ZonaImpuesto, @Campo, @Dato, 
				       @Articulo OUTPUT, @SubCuenta OUTPUT, @Unidad OUTPUT, @Almacen OUTPUT, @DescripcionExtra OUTPUT, 
		                       @SustitutoArticulo OUTPUT, @SustitutoSubCuenta OUTPUT,@Instruccion OUTPUT, @Agente OUTPUT, @Paquete OUTPUT, @Departamento OUTPUT, 
		   		       @FechaRequerida OUTPUT,@Veces OUTPUT, @Cantidad OUTPUT, @CantidadInventario OUTPUT, @Factor OUTPUT, @Precio OUTPUT, @DescuentoLinea OUTPUT, @Costo OUTPUT,
				       @Impuesto1 OUTPUT, @Impuesto2 OUTPUT, @Impuesto3 OUTPUT, @ArtTipo OUTPUT, @RenglonTipo OUTPUT,
		   		       @Ok OUTPUT, @OkRef OUTPUT

        END ELSE
        IF SUBSTRING(@Clave, 1, 1) = '[' AND SUBSTRING(@Clave, Len(@Clave), 1) = ']'
        BEGIN
          IF @Encabezado = 1 
          BEGIN
            IF @EnviarA IS NOT NULL AND NOT EXISTS(SELECT * FROM CteEnviarA WHERE Cliente = @Cliente AND ID = @EnviarA) SELECT @Ok = 72060, @OkRef = LTRIM(CONVERT(char, @EnviarA))
            IF @Ok IS NULL
            BEGIN
              SELECT @TipoCambio = TipoCambio      FROM Mon       WHERE Moneda = @Moneda
              SELECT @DescuentoGlobal = Porcentaje FROM Descuento WHERE Descuento = @Descuento
              SELECT @ServicioGarantia = ISNULL(@ServicioGarantia, 0)
              INSERT Venta ( OrigenTipo, Empresa,  Usuario,  Estatus,  Mov,  FechaEmision,   Directo, Almacen,  Concepto,  Proyecto,  Moneda,  TipoCambio,  Referencia,  Observaciones,  Prioridad,  Cliente,  EnviarA,  Agente,  FormaEnvio,  FechaRequerida,  FechaOriginal,  FechaOrdenCompra,  OrdenCompra,  Condicion,  Vencimiento,  CtaDinero,  Descuento,  DescuentoGlobal, ServicioTipo,  ServicioArticulo,  ServicioSerie,  ServicioContrato,  ServicioContratoID,  ServicioContratoTipo,  ServicioGarantia,   ServicioDescripcion,  ServicioIdentificador,  ServicioFecha, Atencion,  Departamento,  ZonaImpuesto,  ListaPreciosEsp,  Situacion,  SituacionFecha)
                    VALUES (@OrigenTipo, @Empresa, @Usuario, @Estatus, @Mov, @FechaEmision,  1,       @Almacen, @Concepto, @Proyecto, @Moneda, @TipoCambio, @Referencia, @Observaciones, @Prioridad, @Cliente, @EnviarA, @Agente, @FormaEnvio, @FechaRequerida, @FechaOriginal, @FechaOrdenCompra, @OrdenCompra, @Condicion, @Vencimiento, @CtaDinero, @Descuento, @DescuentoGlobal, @ServicioTipo, @ServicioArticulo, @ServicioSerie, @ServicioContrato, @ServicioContratoID, @ServicioContratoTipo, @ServicioGarantia, @ServicioDescripcion, @ServicioIdentificador, @ServicioFecha, @Atencion, @Departamento, @ZonaImpuesto, @ListaPreciosEsp, @Situacion, @SituacionFecha)
              SELECT @ID = SCOPE_IDENTITY()
              INSERT AnexoMov (Rama, ID, Nombre, Direccion, Icono, Tipo) 
                       VALUES (@Modulo, @ID, @PlantillaTipo, @Direccion, @Icono, 'Archivo')
              SELECT @Encabezado = 0
            END
          END ELSE
          BEGIN
            IF @Articulo IS NOT NULL AND @Cantidad > 0
            BEGIN
	      EXEC xp_ValidarVentaD @Articulo, @Moneda, @ListaPreciosEsp, @Veces, @Precio OUTPUT, @Renglon OUTPUT, @RenglonID OUTPUT, @Cantidad OUTPUT, @CantidadInventario OUTPUT, @Factor OUTPUT
              INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Almacen,  Articulo,  SubCuenta,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,  Cantidad,   DescuentoLinea,  Precio, Costo,   FechaRequerida,  Agente,  Departamento,  DescripcionExtra,  SustitutoArticulo,  SustitutoSubCuenta,  Instruccion,  Factor,  CantidadInventario,  Paquete)
                     VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Almacen, @Articulo, @SubCuenta, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @DescuentoLinea, @Precio, @Costo, @FechaRequerida, @Agente, @Departamento, @DescripcionExtra, @SustitutoArticulo, @SustitutoSubCuenta, @Instruccion, @Factor, @CantidadInventario, @Paquete)
            END        
            SELECT @Articulo = NULL, @SubCuenta = NULL, @Cantidad = NULL, @CantidadInventario = NULL, @Factor = 1.0, @Precio = NULL, @Costo = NULL
          END
        END
      END
      FETCH NEXT FROM crListaSt INTO @Clave
    END  -- While	

    IF @Articulo IS NOT NULL AND @Cantidad > 0
    BEGIN
      EXEC xp_ValidarVentaD @Articulo, @Moneda, @ListaPreciosEsp, @Veces, @Precio OUTPUT, @Renglon OUTPUT, @RenglonID OUTPUT, @Cantidad OUTPUT, @CantidadInventario OUTPUT, @Factor OUTPUT
      INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Almacen,  Articulo,  SubCuenta,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,  Cantidad,   DescuentoLinea,  Precio, Costo,   FechaRequerida,  Agente,  Departamento,  DescripcionExtra,  SustitutoArticulo,  SustitutoSubCuenta,  Instruccion,  Factor,  CantidadInventario,  Paquete)
             VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Almacen, @Articulo, @SubCuenta, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @DescuentoLinea, @Precio, @Costo, @FechaRequerida, @Agente, @Departamento, @DescripcionExtra, @SustitutoArticulo, @SustitutoSubCuenta, @Instruccion, @Factor, @CantidadInventario, @Paquete)
    END        
    CLOSE crListaSt
    DEALLOCATE crListaSt

  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  IF @Ok IS NULL SELECT @Ok = 80050

  SELECT Mensaje, Tipo, Descripcion, "Referencia" = ISNULL(@OkRef, '')
    FROM MensajeLista 
   WHERE Mensaje = @Ok
  RETURN 
END
GO


/**************** xp_OrdenDistribucion_Gigante_Sucursal ****************/
if exists (select * from sysobjects where id = object_id('dbo.xp_OrdenDistribucion_Gigante_Sucursal') and sysstat & 0xf = 4) drop procedure dbo.xp_OrdenDistribucion_Gigante_Sucursal
GO             
CREATE PROCEDURE xp_OrdenDistribucion_Gigante_Sucursal
                     @Plantilla		varchar(50),
	             @Direccion		varchar(255),
		     @Empresa		char(5),
		     @Usuario		char(10),
		     @Estacion		int,
		     @EnviarA		int,
    		     @Ok		int		OUTPUT,
    		     @OkRef		varchar(255)	OUTPUT
AS BEGIN
  DECLARE
    @Clave 			varchar(100),
    @Campo			varchar(50),
    @Dato			varchar(100),
    @PlantillaTipo		varchar(50),
    @Encabezado			bit,
    @p				int,

    @ID				int,
    @OrigenTipo			char(10),	
    @Modulo			char(5),
    @Icono			int,
    @Mov			varchar(20),
    @Estatus			char(15),
    @Prioridad			char(10),
    @FechaEmision		datetime,
    @FechaRequerida		datetime,
    @FechaOriginal		datetime,
    @FechaOrdenCompra		datetime,
    @Descuento			varchar(30),
    @DescuentoGlobal		float,
    @Almacen			char(10),
    @CtaDinero			char(10),
    @Concepto			varchar(50),
    @Proyecto			varchar(50),
    @Moneda			char(10),
    @TipoCambio			float,
    @Referencia			varchar(50),
    @Observaciones		varchar(100),
    @OrdenCompra		varchar(50),
    @Cliente			char(10),
    @Agente 			char(10),
    @FormaEnvio 		varchar(50),
    @Condicion 			varchar(50),
    @Vencimiento		datetime,
    @ListaPreciosEsp		varchar(20),
    @ZonaImpuesto		varchar(30),
    @Atencion			varchar(50),
    @Situacion			varchar(50),
    @SituacionFecha		datetime,
    @Departamento		int,
    @ServicioTipo		varchar(50),
    @ServicioArticulo		varchar(20),
    @ServicioSerie		varchar(20),
    @ServicioContrato		varchar(20),
    @ServicioContratoID	   	int,
    @ServicioContratoTipo  	varchar(50),
    @ServicioGarantia	   	bit,
    @ServicioDescripcion   	varchar(100),
    @ServicioFecha	   	datetime,
    @ServicioIdentificador 	varchar(20),

    @Articulo			char(20),
    @SubCuenta			varchar(20),
    @Unidad			varchar(50),
    @Cantidad			float,
    @Factor			float,
    @CantidadInventario		float,
    @Precio			money,
    @Costo			money,
    @DescuentoLinea		money,
    @DescripcionExtra		varchar(100), 
    @SustitutoArticulo  	varchar(20),
    @SustitutoSubCuenta		varchar(20),
    @Instruccion		varchar(50),
    @Paquete			int,

    @Veces			float,
    @Renglon			float,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @ArtTipo			varchar(20),
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money

  -- Inicializar Variables
  SELECT @Encabezado 	= 1,
         @Renglon    	= 0.0,
         @Factor	= 1.0,
         @Modulo        = 'VTAS',
         @Icono		= 51,
         @OrigenTipo 	= 'Excel', 
         @Estatus 	= 'CONFIRMAR',
         @Prioridad     = 'Normal',
         @FechaEmision 	= GETDATE()

  EXEC spExtraerFecha @FechaEmision OUTPUT

  -- Leer la Plantilla Excel
  SELECT @Mov           = Mov,
         @Cliente       = Cliente,
         @Almacen       = Almacen,
         @PlantillaTipo = Tipo
    FROM Excel
   WHERE Plantilla = @Plantilla
  IF @@ROWCOUNT = 0 SELECT @Ok = 72020

  IF @Cliente IS NOT NULL 
    SELECT @Proyecto        = Proyecto, 
           @Agente          = Agente, 
           @FormaEnvio      = FormaEnvio, 
           @Condicion       = Condicion, 
           @Descuento       = Descuento, 
           @ListaPreciosEsp = ListaPreciosEsp, 
           @ZonaImpuesto    = ZonaImpuesto, 
           @Moneda          = DefMoneda
      FROM Cte
     WHERE Cliente = @Cliente
  ELSE SELECT @Ok = 72030

    DECLARE crListaSt CURSOR FOR
      SELECT NULLIF(RTRIM(LTRIM(Clave)), '') FROM ListaSt WHERE Estacion = @Estacion

    OPEN crListaSt

    -- Validar el Encabezado del Archivo
    FETCH NEXT FROM crListaSt INTO @Clave
    IF @Clave <> +'['+@Plantilla+']' SELECT @Ok = 72010

    FETCH NEXT FROM crListaSt INTO @Clave
    WHILE @@FETCH_STATUS <> -1 AND @Clave IS NOT NULL AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @p = CHARINDEX('=', @Clave)
        IF @p > 0 
        BEGIN
          SELECT @Campo = RTRIM(SUBSTRING(@Clave, 1, @p-1)), 
                 @Dato  = RTRIM(SUBSTRING(@Clave, @p+1, LEN(@Clave)-@p))

          IF @Encabezado = 1 
            EXEC xp_VentaCamposEncabezado @Campo, @Dato, 
					  @FechaEmision OUTPUT, @FechaRequerida OUTPUT, @FechaOriginal OUTPUT, 	@FechaOrdenCompra OUTPUT, 	@SituacionFecha OUTPUT, @Vencimiento OUTPUT, 
                                          @Departamento OUTPUT, @EnviarA OUTPUT, 	@Cliente OUTPUT, 	@Moneda OUTPUT, 		@Almacen OUTPUT, 	@Agente OUTPUT, 
					  @CtaDinero OUTPUT, 	@Prioridad OUTPUT, 	@Concepto OUTPUT, 	@Proyecto, 			@FormaEnvio OUTPUT, 	@ListaPreciosEsp OUTPUT, 
					  @OrdenCompra OUTPUT, 	@Condicion OUTPUT, 	@Descuento OUTPUT, 	@ZonaImpuesto OUTPUT, 		@Atencion OUTPUT, 	
					  @Situacion OUTPUT, 	@Referencia OUTPUT, 	@Observaciones OUTPUT,	
					  @ServicioTipo OUTPUT,		@ServicioArticulo OUTPUT,	@ServicioSerie OUTPUT, 		@ServicioDescripcion OUTPUT, 	@ServicioIdentificador OUTPUT, 	
					  @ServicioContrato OUTPUT, 	@ServicioContratoTipo OUTPUT, 	@ServicioContratoID OUTPUT, 	@ServicioGarantia OUTPUT, 	@ServicioFecha OUTPUT,
                   		          @Ok OUTPUT, @OkRef OUTPUT
          ELSE 
          BEGIN
            IF @Campo = 'Clave Artículo'
            BEGIN
      	      EXEC xp_ValidarCodigoBarras @Dato, @Articulo OUTPUT, @SubCuenta OUTPUT, @Unidad OUTPUT, @Veces OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
              IF @Ok IS NULL
                EXEC xp_ValidarArticulo @Articulo, @SubCuenta, @ZonaImpuesto, @ArtTipo OUTPUT, @RenglonTipo OUTPUT, @Impuesto1 OUTPUT, @Impuesto2 OUTPUT, @Impuesto3 OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
            END ELSE
            IF dbo.fnEsNumerico(SUBSTRING(@Campo, 1, 3)) = 1 AND CONVERT(int, SUBSTRING(@Campo, 1, 3)) = @EnviarA
	      SELECT @Cantidad = CONVERT(float, @Dato) 
          END
        END ELSE
        IF SUBSTRING(@Clave, 1, 1) = '[' AND SUBSTRING(@Clave, Len(@Clave), 1) = ']'
        BEGIN
          IF @Encabezado = 1 
          BEGIN
            IF @EnviarA IS NOT NULL AND NOT EXISTS(SELECT * FROM CteEnviarA WHERE Cliente = @Cliente AND ID = @EnviarA) SELECT @Ok = 72060, @OkRef = LTRIM(CONVERT(char, @EnviarA))
            IF @Ok IS NULL
            BEGIN
              SELECT @TipoCambio = TipoCambio      FROM Mon       WHERE Moneda = @Moneda
              SELECT @DescuentoGlobal = Porcentaje FROM Descuento WHERE Descuento = @Descuento
              SELECT @ServicioGarantia = ISNULL(@ServicioGarantia, 0)
              INSERT Venta ( OrigenTipo, Empresa,  Usuario,  Estatus,  Mov,  FechaEmision,   Directo, Almacen,  Concepto,  Proyecto,  Moneda,  TipoCambio,  Referencia,  Observaciones,  Prioridad,  Cliente,  EnviarA,  Agente,  FormaEnvio,  FechaRequerida,  FechaOriginal,  FechaOrdenCompra,  OrdenCompra,  Condicion,  Vencimiento,  CtaDinero,  Descuento,  DescuentoGlobal, ServicioTipo,  ServicioArticulo,  ServicioSerie,  ServicioContrato,  ServicioContratoID,  ServicioContratoTipo,  ServicioGarantia,   ServicioDescripcion,  ServicioIdentificador,  ServicioFecha, Atencion,  Departamento,  ZonaImpuesto,  ListaPreciosEsp,  Situacion,  SituacionFecha)
                    VALUES (@OrigenTipo, @Empresa, @Usuario, @Estatus, @Mov, @FechaEmision,  1,       @Almacen, @Concepto, @Proyecto, @Moneda, @TipoCambio, @Referencia, @Observaciones, @Prioridad, @Cliente, @EnviarA, @Agente, @FormaEnvio, @FechaRequerida, @FechaOriginal, @FechaOrdenCompra, @OrdenCompra, @Condicion, @Vencimiento, @CtaDinero, @Descuento, @DescuentoGlobal, @ServicioTipo, @ServicioArticulo, @ServicioSerie, @ServicioContrato, @ServicioContratoID, @ServicioContratoTipo, @ServicioGarantia, @ServicioDescripcion, @ServicioIdentificador, @ServicioFecha, @Atencion, @Departamento, @ZonaImpuesto, @ListaPreciosEsp, @Situacion, @SituacionFecha)
              SELECT @ID = SCOPE_IDENTITY()
              INSERT AnexoMov (Rama, ID, Nombre, Direccion, Icono, Tipo) 
                       VALUES (@Modulo, @ID, @PlantillaTipo, @Direccion, @Icono, 'Archivo')
              SELECT @Encabezado = 0
            END
          END ELSE
          BEGIN
            IF @Articulo IS NOT NULL AND @Cantidad > 0
            BEGIN
	      EXEC xp_ValidarVentaD @Articulo, @Moneda, @ListaPreciosEsp, @Veces, @Precio OUTPUT, @Renglon OUTPUT, @RenglonID OUTPUT, @Cantidad OUTPUT, @CantidadInventario OUTPUT, @Factor OUTPUT
              INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Almacen,  Articulo,  SubCuenta,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,  Cantidad,   DescuentoLinea,  Precio, Costo,   FechaRequerida,  Agente,  Departamento,  DescripcionExtra,  SustitutoArticulo,  SustitutoSubCuenta,  Instruccion,  Factor,  CantidadInventario,  Paquete)
                     VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Almacen, @Articulo, @SubCuenta, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @DescuentoLinea, @Precio, @Costo, @FechaRequerida, @Agente, @Departamento, @DescripcionExtra, @SustitutoArticulo, @SustitutoSubCuenta, @Instruccion, @Factor, @CantidadInventario, @Paquete)
            END        
            SELECT @Articulo = NULL, @SubCuenta = NULL, @Cantidad = NULL, @CantidadInventario = NULL, @Factor = 1.0, @Precio = NULL, @Costo = NULL
          END
        END
      END
      FETCH NEXT FROM crListaSt INTO @Clave
    END  -- While	

    IF @Articulo IS NOT NULL AND @Cantidad > 0
    BEGIN
      EXEC xp_ValidarVentaD @Articulo, @Moneda, @ListaPreciosEsp, @Veces, @Precio OUTPUT, @Renglon OUTPUT, @RenglonID OUTPUT, @Cantidad OUTPUT, @CantidadInventario OUTPUT, @Factor OUTPUT
      INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Almacen,  Articulo,  SubCuenta,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,  Cantidad,   DescuentoLinea,  Precio, Costo,   FechaRequerida,  Agente,  Departamento,  DescripcionExtra,  SustitutoArticulo,  SustitutoSubCuenta,  Instruccion,  Factor,  CantidadInventario,  Paquete)
             VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Almacen, @Articulo, @SubCuenta, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @DescuentoLinea, @Precio, @Costo, @FechaRequerida, @Agente, @Departamento, @DescripcionExtra, @SustitutoArticulo, @SustitutoSubCuenta, @Instruccion, @Factor, @CantidadInventario, @Paquete)
    END        
    CLOSE crListaSt
    DEALLOCATE crListaSt
  RETURN 
END
GO


/**************** xp_OrdenDistribucion_Gigante ****************/
if exists (select * from sysobjects where id = object_id('dbo.xp_OrdenDistribucion_Gigante') and sysstat & 0xf = 4) drop procedure dbo.xp_OrdenDistribucion_Gigante
GO             
CREATE PROCEDURE xp_OrdenDistribucion_Gigante
                     @Plantilla		varchar(50),
	             @Direccion		varchar(255),
		     @Empresa		char(5),
		     @Usuario		char(10),
		     @Estacion		int
AS BEGIN
  DECLARE
    @EnviarA 	int,
    @Ok		int,
    @OkRef	varchar(255)

  BEGIN TRANSACTION
    DECLARE crSucursal CURSOR FOR
     SELECT DISTINCT CONVERT(int, SUBSTRING(Clave, 1, 3))
       FROM ListaSt 
      WHERE dbo.fnEsNumerico(SUBSTRING(Clave, 1, 3)) = 1 
      ORDER BY CONVERT(int, SUBSTRING(Clave, 1, 3))

    OPEN crSucursal

    FETCH NEXT FROM crSucursal INTO @EnviarA
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
	EXEC xp_OrdenDistribucion_Gigante_Sucursal @Plantilla, @Direccion, @Empresa, @Usuario, @Estacion, @EnviarA, @Ok OUTPUT, @OkRef OUTPUT

      FETCH NEXT FROM crSucursal INTO @EnviarA
    END  -- While	

  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  IF @Ok IS NULL SELECT @Ok = 80050

  SELECT Mensaje, Tipo, Descripcion, "Referencia" = ISNULL(@OkRef, '')
    FROM MensajeLista 
   WHERE Mensaje = @Ok
  RETURN 
END
GO

/**************** xp_CteEstadoFinanciero ****************/
if exists (select * from sysobjects where id = object_id('dbo.xp_CteEstadoFinanciero') and sysstat & 0xf = 4) drop procedure dbo.xp_CteEstadoFinanciero
GO             
CREATE PROCEDURE xp_CteEstadoFinanciero
                     @Plantilla		varchar(50),
	             @Direccion		varchar(255),
		     @Empresa		char(5),
		     @Usuario		char(10),
		     @Estacion		int
AS BEGIN
  DECLARE
    @Ok			int,
    @OkRef		varchar(255),
    @Clave 		varchar(100),
    @Campo		varchar(50),
    @Dato		varchar(100),
    @PlantillaTipo	varchar(50),
    @Nombre		varchar(20),
    @Encabezado		bit,
    @p			int, 
    @Cliente		char(10),
    @Ejercicio		int,
    @Mayor		int,
    @Reporte		varchar(100),
    @Cuenta		varchar(100),
    @SaldoDeudor	money,
    @SaldoAcreedor	money,
    @Importe		money,
    @Razones		float

  -- Inicializar Variables
  SELECT @Encabezado 	= 1

  SELECT @PlantillaTipo = Tipo
    FROM Excel
   WHERE Plantilla = @Plantilla
  IF @@ROWCOUNT = 0 SELECT @Ok = 72020

  DECLARE crListaSt CURSOR FOR
    SELECT NULLIF(RTRIM(LTRIM(Clave)), '') FROM ListaSt WHERE Estacion = @Estacion
  OPEN crListaSt

  -- Validar el Encabezado del Archivo
  FETCH NEXT FROM crListaSt INTO @Clave
  IF @Clave <> +'['+@Plantilla+']' SELECT @Ok = 72010

  FETCH NEXT FROM crListaSt INTO @Clave
  WHILE @@FETCH_STATUS <> -1 AND @Clave IS NOT NULL AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @p = CHARINDEX('=', @Clave)
      IF @p > 0 
      BEGIN
        SELECT @Campo = RTRIM(SUBSTRING(@Clave, 1, @p-1)), 
               @Dato  = RTRIM(SUBSTRING(@Clave, @p+1, LEN(@Clave)-@p))

        IF @Encabezado = 1 
        BEGIN
	  IF @Campo = 'Cliente'   BEGIN SELECT @Cliente   = UPPER(@Dato)        IF NOT EXISTS(SELECT * FROM Cte WHERE Cliente = @Cliente) SELECT @Ok = 10040, @OkRef = UPPER(@Dato) END ELSE
	  IF @Campo = 'Ejercicio' BEGIN SELECT @Ejercicio = CONVERT(int, @Dato) IF ISNULL(@Ejercicio, 0) = 0 SELECT @Ok = 10050, @OkRef = @Dato END
        END ELSE 
        BEGIN
	  IF @Campo = 'Mayor'         SELECT @Mayor         = ISNULL(CONVERT(int, @Dato), 0) ELSE
	  IF @Campo = 'Cuenta'        SELECT @Cuenta        = @Dato ELSE
	  IF @Campo = 'SaldoDeudor'   SELECT @SaldoDeudor   = NULLIF(CONVERT(money, @Dato), 0) ELSE
	  IF @Campo = 'SaldoAcreedor' SELECT @SaldoAcreedor = NULLIF(CONVERT(money, @Dato), 0) ELSE
	  IF @Campo = 'Importe'       SELECT @Importe       = NULLIF(CONVERT(money, @Dato), 0) ELSE
	  IF @Campo = 'Razones'       SELECT @Razones       = NULLIF(CONVERT(float, @Dato), 0) 
        END
      END ELSE
      IF SUBSTRING(@Clave, 1, 1) = '[' AND SUBSTRING(@Clave, Len(@Clave), 1) = ']'
      BEGIN
        IF @Encabezado = 1 
        BEGIN
          DELETE CteEstadoFinanciero WHERE Cliente = @Cliente AND Ejercicio = @Ejercicio
          SELECT @Encabezado = 0
        END ELSE
        BEGIN
          IF @Importe IS NOT NULL OR @Razones IS NOT NULL SELECT @Reporte = 'Razones' ELSE SELECT @Reporte = 'Balance'
          IF @Cliente IS NOT NULL AND @Ejercicio IS NOT NULL AND @Cuenta IS NOT NULL           
            INSERT CteEstadoFinanciero (Cliente,  Ejercicio,  Reporte,  Mayor,  Cuenta,  SaldoDeudor,  SaldoAcreedor,  Importe,  Razones)
                                VALUES (@Cliente, @Ejercicio, @Reporte, @Mayor, @Cuenta, @SaldoDeudor, @SaldoAcreedor, @Importe, @Razones)
          SELECT @Mayor = NULL, @Cuenta = NULL, @SaldoDeudor = NULL, @SaldoAcreedor = NULL, @Importe = NULL
        END
      END
    END
    FETCH NEXT FROM crListaSt INTO @Clave
  END  -- While	
  IF @Importe IS NOT NULL OR @Razones IS NOT NULL SELECT @Reporte = 'Razones' ELSE SELECT @Reporte = 'Balance'
  IF @Cliente IS NOT NULL AND @Ejercicio IS NOT NULL AND @Cuenta IS NOT NULL
     INSERT CteEstadoFinanciero (Cliente,  Ejercicio,  Reporte,  Mayor,  Cuenta,  SaldoDeudor,  SaldoAcreedor,  Importe,  Razones)
                         VALUES (@Cliente, @Ejercicio, @Reporte, @Mayor, @Cuenta, @SaldoDeudor, @SaldoAcreedor, @Importe, @Razones)
  CLOSE crListaSt
  DEALLOCATE crListaSt

  IF @Ok IS NULL 
  BEGIN
    SELECT @Nombre =  'Edo. Financiero ' + CONVERT(varchar, @Ejercicio)
    IF NOT EXISTS(SELECT * FROM AnexoCta WHERE Rama = 'CXC' AND Cuenta = @Cliente AND Nombre = @Nombre)
      INSERT AnexoCta (Rama,  Cuenta,   Nombre,  Direccion,  Icono,  Tipo) 
               VALUES ('CXC', @Cliente, @Nombre, @Direccion, 51,    'Archivo')
    SELECT @Ok = 80050
  END

  SELECT Mensaje, Tipo, Descripcion, "Referencia" = ISNULL(@OkRef, '')
    FROM MensajeLista 
   WHERE Mensaje = @Ok
  RETURN 
END
GO

