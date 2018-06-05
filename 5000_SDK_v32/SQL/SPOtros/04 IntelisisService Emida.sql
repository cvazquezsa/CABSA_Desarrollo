-- REQ13868
/**************** spISEmidaRegistraLog ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISEmidaRegistraLog') and type = 'P') drop procedure dbo.spISEmidaRegistraLog
GO     
CREATE PROC spISEmidaRegistraLog
			@ID				int,
			@Empresa		varchar(5),
			@iSolicitud		int, 
			@Resultado		xml
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @UbicacionLogTransacciones	varchar(255),
		  @LogTransacciones				bit,
		  @ExisteArchivo				int,
		  @ManejadorObjeto				int,
		  @IDArchivo					int,
		  @Ok							int,
		  @OkRef						varchar(255),

		  @Solicitud					xml,
		  @iResultado					int,
		  @Referencia					varchar(100),
		  @FechaRecarga					datetime,

          -- Datos de la Solicitud
          @EmpresaTran					varchar(5),
		  @productId					varchar(255),
		  @clerkId						varchar(20),
		  @accountId					varchar(10),
		  @amount						float,
		  @invoiceNo					int,
		  @terminalId					varchar(20),
		  
		  -- Datos del Resultado
		  @ResponseCode					varchar(2),
		  @Pin							varchar(255),
		  @ControlNo					varchar(20),
		  @CarrierControlNo				varchar(20),
          @TransactionId				varchar(20),
          
          @Log							varchar(max),
          @Encabezados					varchar(max)

  SELECT @LogTransacciones = ISNULL(LogTransacciones, 0), @UbicacionLogTransacciones = ISNULL(RTRIM(UbicacionLogTransacciones), '') FROM EmidaCfg WHERE Empresa = @Empresa

  IF @LogTransacciones = 0 OR(@LogTransacciones = 1 AND @UbicacionLogTransacciones = '') RETURN

  SELECT @Solicitud = Solicitud, @Referencia = Referencia, @FechaRecarga = FechaEstatus FROM IntelisisService WHERE ID = @ID

  SELECT @EmpresaTran = Empresa,
		 @productId   = productId,
		 @clerkId	  = clerkId,
		 @accountId   = accountId,
		 @amount	  = amount,
		 @invoiceNo   = invoiceNo,
		 @terminalId  = terminalId
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Emida',1)     
    WITH (Empresa varchar(5), terminalId varchar(20), clerkId varchar(20), productId varchar(255), accountId varchar(10), amount varchar(10), invoiceNo varchar(20))

  EXEC sp_xml_preparedocument @iResultado OUTPUT, @Resultado
    
  SELECT @ResponseCode	   = ResponseCode,
		 @Pin			   = Pin,
		 @ControlNo		   = ControlNo,
		 @CarrierControlNo = CarrierControlNo,
		 @TransactionId	   = TransactionId
    FROM OPENXML(@iResultado, '/Intelisis/Resultado/PinDistSaleResponse', 2) 
    WITH (ResponseCode varchar(2), Pin varchar(255), ControlNo varchar(20), CarrierControlNo varchar(20), TransactionId varchar(20))

  EXEC sp_xml_removedocument @iResultado
  
  SELECT @Log = dbo.fnFormatoFecha(@FechaRecarga, 'dd/MM/aaaa hh:nn:ss') + ',' +
			    CONVERT(varchar(max), @accountId) + ',' +
			    CONVERT(varchar(max), @productId) + ',' +
			    CONVERT(varchar(max), @amount) + ',' +
			    CONVERT(varchar(max), @invoiceNo) + ',' +
			    CONVERT(varchar(max), @terminalId) + ',' +
			    CONVERT(varchar(max), @ResponseCode) + ',' +
			    CONVERT(varchar(max), @Pin) + ',' +
			    CONVERT(varchar(max), @ControlNo) + ',' +
			    CONVERT(varchar(max), @CarrierControlNo) + ',' +
			    CONVERT(varchar(max), @TransactionId) + '
'

  SELECT @Encabezados = 'FechaRecarga,' + 'AccountID,' + 'ProductID,' + 'Amount,' + 'InvoiceNo,' + 'TerminalID,' + 'ResponseCode,' + 'Pin,' + 'ControlNo,' + 'CarrierControlNo,' + 'TransactionID
' 
  
  EXEC spVerificarArchivo @UbicacionLogTransacciones, @ExisteArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
  IF @ExisteArchivo = 0 AND @Ok IS NULL
  BEGIN
    EXEC spCrearArchivo @UbicacionLogTransacciones, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    
    IF @Ok IS NULL 
      EXEC spInsertaTextoEnArchivo @IDArchivo, @Encabezados, @Ok OUTPUT, @OkRef OUTPUT
  END
  ELSE IF @ExisteArchivo = 1 AND @Ok IS NULL
    EXEC spAbreArchivo @UbicacionLogTransacciones, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    
  IF @Ok IS NULL
    EXEC spInsertaTextoEnArchivo @IDArchivo, @Log, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    EXEC spCerrarArchivo @IDArchivo, @ManejadorObjeto, @Ok OUTPUT, @OkRef OUTPUT
END
GO

-- REQ12336
/**************** spISEmidaActualizarCatalogoCarrierList ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISEmidaActualizarCatalogoCarrierList') and type = 'P') drop procedure dbo.spISEmidaActualizarCatalogoCarrierList
GO             
CREATE PROC spISEmidaActualizarCatalogoCarrierList 
			@ID					int, 
			@iSolicitud			int,
			@Estacion			int, 
			@Empresa			varchar(5),
			@URL				varchar(255),
			@SiteID				varchar(20),
			@Version			varchar(2),
			@Resultado			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT			
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Respuesta		varchar(max),
		  @RespuestaXML		xml,
		  @iResultado		int,
		  @ResponseCode		varchar(2),
		  @ResponseMessage	varchar(250)		  

  CREATE TABLE #EmidaCarrierCfg(
    Empresa			varchar(5)		COLLATE DATABASE_DEFAULT NULL,
    URL				varchar(255)	COLLATE DATABASE_DEFAULT NULL,
    CarrierId		varchar(255)	COLLATE DATABASE_DEFAULT NULL,
    Description		varchar(255)	COLLATE DATABASE_DEFAULT NULL,
    ProductCount	varchar(10)		COLLATE DATABASE_DEFAULT NULL,
    Existe			bit				NOT NULL DEFAULT 0
    )
  
  EXEC spWSEmidaGetCarrierList @URL, @Version, @SiteID, '', '', '', '', @Respuesta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
  SELECT @RespuestaXML = CONVERT(xml, @Respuesta)

  IF @Ok IS NULL
  BEGIN
    EXEC sp_xml_preparedocument @iResultado OUTPUT, @RespuestaXML

    SELECT @ResponseCode = ISNULL(ResponseCode, ''), @ResponseMessage = ISNULL(ResponseMessage, '')
      FROM OPENXML(@iResultado, '/GetCarrierListResponse', 2) 
      WITH (ResponseCode varchar(2), ResponseMessage varchar(250))

    IF @ResponseCode NOT IN('00', '')
      SELECT @Ok = 5, @OkRef = RTRIM(@ResponseCode) + ' ' + RTRIM(@ResponseMessage)

    INSERT INTO #EmidaCarrierCfg(
			Empresa,  URL,  CarrierId, Description, ProductCount)
     SELECT @Empresa, @URL, CarrierId, Description, ProductCount 
      FROM OPENXML(@iResultado, '/GetCarrierListResponse/Carrier', 2) WITH EmidaCarrierCfg

    EXEC sp_xml_removedocument @iResultado 

    IF @Ok IS NULL
    BEGIN
      UPDATE a
         SET a.Existe = 1
        FROM #EmidaCarrierCfg a
        JOIN EmidaCarrierCfg b ON a.URL = b.URL AND a.CarrierId = b.CarrierId AND a.Empresa = b.Empresa

      INSERT INTO EmidaCarrierCfg(
			  Empresa, URL, CarrierId, Description, ProductCount)
       SELECT Empresa, URL, CarrierId, Description, ProductCount
         FROM #EmidaCarrierCfg
        WHERE ISNULL(Existe, 0) = 0
      
      INSERT INTO EmidaActualizarCatalogos(
			   Empresa,  Estacion, Catalogo,      Clave,	   Descripcion, URL)
       SELECT @Empresa, @Estacion, 'Proveedores', CarrierId, Description, URL
         FROM #EmidaCarrierCfg
        WHERE ISNULL(Existe, 0) = 0
    END
  END

  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.ActualizarCatalogo" SubReferencia="CarrierList" Version="' + ISNULL(@Version, '') + '" Ok="' + ISNULL(CONVERT(varchar, @Ok), '') + '" OkRef="' + ISNULL(CONVERT(varchar, @OkRef), '') + '" >' + 
                      '  <Resultado>' + ISNULL(CONVERT(varchar(max), @RespuestaXML), '') + 
                      '  </Resultado>' + 
                      '</Intelisis>'
                        
  RETURN 
END
GO

-- REQ12336
/**************** spISEmidaActualizarCatalogoProductList ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISEmidaActualizarCatalogoProductList') and type = 'P') drop procedure dbo.spISEmidaActualizarCatalogoProductList
GO             
CREATE PROC spISEmidaActualizarCatalogoProductList 
			@ID					int, 
			@iSolicitud			int,
			@Estacion			int, 
			@Empresa			varchar(5),
			@URL				varchar(255),
			@SiteID				varchar(20),
			@Version			varchar(2),
			@Resultado			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT			
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Respuesta		varchar(max),
		  @RespuestaXML		xml,
		  @iResultado		int,
		  @ResponseCode		varchar(2),
		  @ResponseMessage	varchar(250)		  
 
  CREATE TABLE #EmidaProductCfg(
    Empresa				varchar(5)	COLLATE DATABASE_DEFAULT NULL,
    URL					varchar(255)COLLATE DATABASE_DEFAULT NULL,
    ProductId			varchar(255)COLLATE DATABASE_DEFAULT NULL,
    Description			varchar(255)COLLATE DATABASE_DEFAULT NULL,
    ShortDescription	varchar(255)COLLATE DATABASE_DEFAULT NULL,
    Amount				varchar(10)	COLLATE DATABASE_DEFAULT NULL,
    CarrierId			varchar(255)COLLATE DATABASE_DEFAULT NULL,
    CategoryId			varchar(255)COLLATE DATABASE_DEFAULT NULL,
    TransTypeId			varchar(255)COLLATE DATABASE_DEFAULT NULL,
    DiscountRate		varchar(10)	COLLATE DATABASE_DEFAULT NULL,
    CurrencyCode		varchar(10)	COLLATE DATABASE_DEFAULT NULL,
    CurrencySymbol		varchar(10)	COLLATE DATABASE_DEFAULT NULL,
    Existe				bit			NOT NULL DEFAULT 0
	)

  EXEC spWSEmidaGetProductList @URL, @Version, @SiteID, '', '', '', '', @Respuesta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
  IF @Ok IS NULL
  BEGIN
    SELECT @RespuestaXML = CONVERT(xml, @Respuesta)  
    
    EXEC sp_xml_preparedocument @iResultado OUTPUT, @RespuestaXML

    SELECT @ResponseCode = ISNULL(ResponseCode, ''), @ResponseMessage = ISNULL(ResponseMessage, '')
      FROM OPENXML(@iResultado, '/GetProductListResponse', 2) 
      WITH (ResponseCode varchar(2), ResponseMessage varchar(250))

    IF @ResponseCode NOT IN('00', '')
      SELECT @Ok = 5, @OkRef = RTRIM(@ResponseCode) + ' ' + RTRIM(@ResponseMessage)
      
    INSERT INTO #EmidaProductCfg(
			 Empresa,  URL,  ProductId, Description, ShortDescription, Amount, CarrierId, CategoryId, TransTypeId, DiscountRate, CurrencyCode, CurrencySymbol)
      SELECT @Empresa, @URL, ProductId, Description, ShortDescription, Amount, CarrierId, CategoryId, TransTypeId, DiscountRate, CurrencyCode, CurrencySymbol
        FROM OPENXML(@iResultado, '/GetProductListResponse/Product', 2) WITH EmidaProductCfg

    EXEC sp_xml_removedocument @iResultado
    
    IF @Ok IS NULL
    BEGIN
      UPDATE a
         SET a.Existe = 1
        FROM #EmidaProductCfg a
        JOIN EmidaProductCfg b ON a.URL = b.URL AND a.CarrierId = b.CarrierId AND a.Empresa = b.Empresa AND a.ProductId = b.ProductId

      INSERT INTO EmidaProductCfg(
			   Empresa, URL, ProductId, Description, ShortDescription, Amount, CarrierId, CategoryId, TransTypeId, DiscountRate, CurrencyCode, CurrencySymbol)
        SELECT Empresa, URL, ProductId, Description, ShortDescription, Amount, CarrierId, CategoryId, TransTypeId, DiscountRate, CurrencyCode, CurrencySymbol
          FROM #EmidaProductCfg
         WHERE ISNULL(Existe, 0) = 0

      INSERT INTO EmidaActualizarCatalogos(
			   Empresa,  Estacion, Catalogo,    Clave,	 Descripcion, URL)
       SELECT @Empresa, @Estacion, 'Productos', ProductId, Description, URL
         FROM #EmidaProductCfg
        WHERE ISNULL(Existe, 0) = 0
    END    
  END

  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.ActualizarCatalogo" SubReferencia="ProductList" Version="' + ISNULL(@Version, '') + '" Ok="' + ISNULL(CONVERT(varchar, @Ok), '') + '" OkRef="' + ISNULL(CONVERT(varchar, @OkRef), '') + '" >' + 
                      '  <Resultado>' + ISNULL(@Respuesta, '') + 
                      '  </Resultado>' + 
                      '</Intelisis>'
  RETURN 
END
GO
		
-- REQ12336
/**************** spISEmidaActualizarCatalogo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISEmidaActualizarCatalogo') and type = 'P') drop procedure dbo.spISEmidaActualizarCatalogo
GO             
CREATE PROC spISEmidaActualizarCatalogo
			@ID					int, 
			@iSolicitud			int,
			@SubReferencia		varchar(100),
			@Resultado			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT,
			@CambiarEstatus		bit = 1			OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Estacion		int,
		  @Empresa		varchar(5),
		  @URL			varchar(255),
		  @SiteID		varchar(20),
		  @Version		varchar(2)
  
  SELECT @Estacion = Estacion, @Empresa = Empresa, @URL = URL, @SiteID = SiteID, @Version = Version 
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Emida',1)     
    WITH (Estacion int, Empresa varchar(5), URL varchar(255), SiteID varchar(20), Version varchar(2))

  IF @SubReferencia = 'CarrierList'
    EXEC spISEmidaActualizarCatalogoCarrierList @ID, @iSolicitud, @Estacion, @Empresa, @URL, @SiteID, @Version, @Resultado = @Resultado OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    
  ELSE IF @SubReferencia = 'ProductList'
    EXEC spISEmidaActualizarCatalogoProductList @ID, @iSolicitud, @Estacion, @Empresa, @URL, @SiteID, @Version, @Resultado = @Resultado OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  RETURN
END
GO

-- REQ12336
/**************** spISEmidaAccountBalance ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISEmidaAccountBalance') and type = 'P') drop procedure dbo.spISEmidaAccountBalance
GO             
CREATE PROC spISEmidaAccountBalance
			@ID					int, 
			@iSolicitud			int,
			@SubReferencia		varchar(100),
			@Resultado			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT,
			@CambiarEstatus		bit = 1			OUTPUT			
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Estacion				int,
		  @Empresa				varchar(5),
		  @URL					varchar(255),
		  @SiteID				varchar(20),
		  @Version				varchar(2),
		  @MerchantID			varchar(20),
		  @Respuesta			varchar(max),
		  @RespuestaXML			xml,
		  @iResultado			int,
		  @Sucursal				int,
		  @ResponseCode			varchar(2),
		  @ResponseMessage		varchar(250)
  
  SELECT @Estacion = Estacion, @Empresa = Empresa, @URL = URL, @SiteID = SiteID, @Version = Version, @MerchantID = MerchantID, @Sucursal = Sucursal
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Emida',1)     
    WITH (Estacion int, Empresa varchar(5), URL varchar(255), SiteID varchar(20), Version varchar(2), MerchantID varchar(20), Sucursal int)
  
  EXEC spWSEmidaGetAccountBalance @URL, @Version, @SiteID, @MerchantID, @Respuesta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    SELECT @RespuestaXML = CONVERT(xml, @Respuesta)  
    
    EXEC sp_xml_preparedocument @iResultado OUTPUT, @RespuestaXML

    SELECT @ResponseCode = ISNULL(ResponseCode, ''), @ResponseMessage = ISNULL(ResponseMessage, '')
      FROM OPENXML(@iResultado, '/GetAccountBalanceResponse', 2) 
      WITH (ResponseCode varchar(2), ResponseMessage varchar(250))

    IF @ResponseCode <> '00'
      SELECT @Ok = 5, @OkRef = RTRIM(@ResponseCode) + ' ' + RTRIM(@ResponseMessage)

    IF @Ok IS NULL
    BEGIN
      DELETE EmidaAccountBalance WHERE Empresa = @Empresa AND URL = @URL AND Sucursal = @Sucursal

      INSERT INTO EmidaAccountBalance(
			  Empresa,  URL,  availableBalance, legalBusinessname, dba, Sucursal)
       SELECT @Empresa, @URL, availableBalance, legalBusinessname, dba, @Sucursal
        FROM OPENXML(@iResultado, '/GetAccountBalanceResponse', 2) WITH EmidaAccountBalance
    END

    EXEC sp_xml_removedocument @iResultado 
  END

  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.AccountBalance" Version="' + ISNULL(@Version, '') + '" Ok="' + ISNULL(CONVERT(varchar, @Ok), '') + '" OkRef="' + ISNULL(CONVERT(varchar, @OkRef), '') + '" >' + 
                      '  <Resultado>' + ISNULL(@Respuesta, '') + 
                      '  </Resultado>' + 
                      '</Intelisis>'  
END
GO

-- REQ12336
/**************** spISEmidaSubmitPayment ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISEmidaSubmitPayment') and type = 'P') drop procedure dbo.spISEmidaSubmitPayment
GO             
CREATE PROC spISEmidaSubmitPayment
			@ID					int, 
			@iSolicitud			int,
			@SubReferencia		varchar(100),
			@Resultado			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT,
			@CambiarEstatus		bit = 1			OUTPUT			
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Estacion				int,
		  @Empresa				varchar(5),
		  @URL					varchar(255),
		  @terminalId			varchar(20),
		  @Version				varchar(2),
		  @clerkId				varchar(20),
		  @bankCode				varchar(20),
		  @amount				float,
		  @documentNumber		varchar(25),
		  @documentDate			varchar(10),
		  @Respuesta			varchar(max),
		  @RespuestaXML			xml,
		  @iResultado			int,
		  @Sucursal				int,
		  @ResponseCode			varchar(2),
		  @ResponseMessage		varchar(250),
		  @TimeOut				int

  SELECT @Estacion = Estacion, @Empresa = Empresa, @URL = URL, @terminalId = terminalId, @Version = Version, @clerkId = clerkId, @bankCode = bankCode,
		 @amount = amount, @documentDate = documentDate, @documentNumber = documentNumber
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Emida',1)     
    WITH (Estacion int, Empresa varchar(5), URL varchar(255), terminalId varchar(20), Version varchar(2), clerkId varchar(20), 
		  amount varchar(10), bankCode varchar(20), documentNumber varchar(25), documentDate varchar(10))

  EXEC spWSEmidaSubmitPaymentNotification @URL, @version, @terminalId, @amount, @clerkId, @documentNumber, @documentDate, @bankCode, @Respuesta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    SELECT @RespuestaXML = CONVERT(xml, @Respuesta)  
    
    EXEC sp_xml_preparedocument @iResultado OUTPUT, @RespuestaXML

    SELECT @ResponseCode = RTRIM(ISNULL(ResponseCode, '')), @ResponseMessage = RTRIM(ISNULL(ResponseMessage, ''))
      FROM OPENXML(@iResultado, '/SubmitPaymentNotificationResponse', 2) 
      WITH (ResponseCode varchar(2), ResponseMessage varchar(250))

    IF @ResponseCode = '00'
      SELECT @Ok = NULL, @OkRef = NULL
    ELSE  
      SELECT @Ok = 5, @OkRef = @ResponseCode + ' ' + @ResponseMessage

    EXEC sp_xml_removedocument @iResultado 
  END
  
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.SubmitPayment" Version="' + ISNULL(@Version, '') + '" Ok="' + ISNULL(CONVERT(varchar, @Ok), '') + '" OkRef="' + ISNULL(CONVERT(varchar, @OkRef), '') + '" >' + 
                      '  <Resultado>' + ISNULL(CONVERT(varchar(max), @Respuesta), '') + 
                      '  </Resultado>' + 
                      '</Intelisis>'
  RETURN
END
GO

-- REQ12336
/**************** spISEmidaLookupTransaction ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISEmidaLookupTransaction') and type = 'P') drop procedure dbo.spISEmidaLookupTransaction
GO             
CREATE PROC spISEmidaLookupTransaction
			@ID					int, 
			@iSolicitud			int,
			@SubReferencia		varchar(100),
			@Resultado			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT,
			@CambiarEstatus		bit = 1			OUTPUT,
			@Empresa			varchar(5)		OUTPUT -- REQ13868			
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Estacion				int,
		  @URL					varchar(255),
		  @terminalId			varchar(20),
		  @Version				varchar(2),
		  @clerkId				varchar(20),
		  @invoiceNo			varchar(20),
		  @Respuesta			varchar(max),
		  @RespuestaXML			xml,
		  @iResultado			int,
		  @Sucursal				int,
		  @ResponseCode			varchar(2),
		  @ResponseMessage		varchar(250),
		  @TimeOut				int
  
  SELECT @Estacion = Estacion, @Empresa = Empresa, @URL = URL, @terminalId = terminalId, @Version = Version, @clerkId = clerkId, @invoiceNo = invoiceNo
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Emida',1)     
    WITH (Estacion int, Empresa varchar(5), URL varchar(255), terminalId varchar(20), Version varchar(2), clerkId varchar(20), productId varchar(255), 
		  accountId varchar(10), amount varchar(10), invoiceNo varchar(20), languageOption varchar(2))

  SELECT @TimeOut = TimeOutLookup FROM EmidaCfg WHERE Empresa = @Empresa -- BUG13861

  EXEC spWSEmidaLookUpTransactionByInvocieNo @URL, @Version, @terminalId, @clerkId, @invoiceNo, @TimeOut, @Respuesta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    SELECT @RespuestaXML = CONVERT(xml, @Respuesta)  
    
    EXEC sp_xml_preparedocument @iResultado OUTPUT, @RespuestaXML

    SELECT @ResponseCode = RTRIM(ISNULL(ResponseCode, '')), @ResponseMessage = RTRIM(ISNULL(ResponseMessage, ''))
      FROM OPENXML(@iResultado, '/PinDistSaleResponse', 2) 
      WITH (ResponseCode varchar(2), ResponseMessage varchar(250))

    IF @ResponseCode = '00'
      SELECT @Ok = NULL, @OkRef = NULL
    ELSE  
      SELECT @Ok = 5, @OkRef = @ResponseCode + ' ' + @ResponseMessage

    EXEC sp_xml_removedocument @iResultado 
  END
  
  SELECT @Resultado = ISNULL(CONVERT(varchar(max), @Respuesta), '')
  
  RETURN
END
GO

-- REQ12336
/**************** spISEmidaRecargaTelefonica ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISEmidaRecargaTelefonica') and type = 'P') drop procedure dbo.spISEmidaRecargaTelefonica
GO             
CREATE PROC spISEmidaRecargaTelefonica
			@ID					int, 
			@iSolicitud			int,
			@SubReferencia		varchar(100),
			@Resultado			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT,
			@CambiarEstatus		bit = 1			OUTPUT,
			@Empresa			varchar(5)		OUTPUT -- REQ13868
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Estacion				int,
		  
		  @URL					varchar(255),
		  @terminalId			varchar(20),
		  @Version				varchar(2),
		  @TimeOut				int,
		  @Reintentos			int,
		  @clerkId				varchar(20),
		  @CarrierId			varchar(255),
		  @ProductId			varchar(255),
		  @Description			varchar(255),
		  @ShortDescription		varchar(255),

		  @RecargaTelefono			varchar(10), -- REQ13848
		  @RecargaConfirmarTelefono	varchar(10), -- REQ13848
		  
		  @amount				varchar(10),
		  @invoiceNo			varchar(20),
		  @languageOption		varchar(2),
		  @Respuesta			varchar(max),
		  @RespuestaXML			xml,
		  @iResultado			int,
		  @Sucursal				int,
		  @ResponseCode			varchar(2),
		  @ResponseMessage		varchar(250),
		  @Usuario				varchar(10),
		  @Contrasena			varchar(32)
  
  SELECT @Estacion = Estacion, @Empresa = Empresa, @URL = URL, @terminalId = terminalId, @Version = Version, @clerkId = clerkId, @ProductId = productId, 
		 @RecargaTelefono = accountId, @amount = amount, @invoiceNo = invoiceNo, @languageOption = languageOption, @Usuario = Usuario, @Contrasena = Contrasena -- REQ13848
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Emida',1)     
    WITH (Estacion int, Empresa varchar(5), URL varchar(255), terminalId varchar(20), Version varchar(2), clerkId varchar(20), productId varchar(255), 
		  accountId varchar(10), amount varchar(10), invoiceNo varchar(20), languageOption varchar(2), Usuario varchar(10), Contrasena varchar(32))

  SELECT @TimeOut = TimeOut, @Reintentos = Reintentos FROM EmidaCfg WHERE Empresa = @Empresa
  
  EXEC spWSEmidaPinDistSale @URL, @Version, @terminalId, @clerkId, @productId, @RecargaTelefono, @amount, @invoiceNo, @languageOption, @TimeOut, @Respuesta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT -- REQ13848

  IF @Ok IS NULL
  BEGIN
    SELECT @RespuestaXML = CONVERT(xml, @Respuesta)  
    
    EXEC sp_xml_preparedocument @iResultado OUTPUT, @RespuestaXML

    SELECT @ResponseCode = RTRIM(ISNULL(ResponseCode, '')), @ResponseMessage = RTRIM(ISNULL(ResponseMessage, ''))
      FROM OPENXML(@iResultado, '/PinDistSaleResponse', 2) 
      WITH (ResponseCode varchar(2), ResponseMessage varchar(250))

    IF @ResponseCode <> '00'
      SELECT @Ok = 5, @OkRef = @ResponseCode + ' ' + @ResponseMessage
    ELSE
      SELECT @Ok = NULL, @OkRef = NULL
      
    EXEC sp_xml_removedocument @iResultado 
  END
  ELSE IF @Ok IS NOT NULL
  BEGIN  
    EXEC spEmidaLookUpTransactionByInvocieNo @Estacion, @Empresa, @Sucursal, @Usuario, @Contrasena, @URL, @version, @terminalId, @clerkId, @invoiceNo, @Reintentos, @Respuesta OUTPUT, @Ok OUTPUT,@OkRef OUTPUT  
  END
      
  SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.RecargaTelefonica" Version="' + ISNULL(@Version, '') + '" Ok="' + ISNULL(CONVERT(varchar, @Ok), '') + '" OkRef="' + ISNULL(CONVERT(varchar, @OkRef), '') + '" >' + 
                      '  <Resultado>' + ISNULL(CONVERT(varchar(max), @Respuesta), '') + 
                      '  </Resultado>' + 
                      '</Intelisis>'
  RETURN
END
GO

-- REQ12336
/**************** spIntelisisServiceEmida ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceEmida') and type = 'P') drop procedure dbo.spIntelisisServiceEmida
GO             
CREATE PROC spIntelisisServiceEmida
			@ID					int, 
			@iSolicitud			int,
			@Referencia			varchar(100),
			@SubReferencia		varchar(100),
			@Resultado			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT,
			@CambiarEstatus		bit = 1			OUTPUT			
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Empresa varchar(5) -- REQ13868
  
  IF @Referencia = 'Emida.ActualizarCatalogo' EXEC spISEmidaActualizarCatalogo @ID, @iSolicitud, @SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT ELSE
  IF @Referencia = 'Emida.AccountBalance' EXEC spISEmidaAccountBalance @ID, @iSolicitud, @SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT ELSE
  IF @Referencia = 'Emida.RecargaTelefonica' EXEC spISEmidaRecargaTelefonica @ID, @iSolicitud, @SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT, @Empresa OUTPUT /* REQ13868 */ ELSE
  IF @Referencia = 'Emida.LookupTransaction' EXEC spISEmidaLookupTransaction @ID, @iSolicitud, @SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT, @Empresa OUTPUT /* REQ13868 */ ELSE
  IF @Referencia = 'Emida.SubmitPayment' EXEC spISEmidaSubmitPayment @ID, @iSolicitud, @SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT

  IF @Referencia IN('Emida.RecargaTelefonica') -- REQ13868
    EXEC spISEmidaRegistraLog @ID, @Empresa, @iSolicitud, @Resultado

  RETURN
END
GO