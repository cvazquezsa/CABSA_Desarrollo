--REQ14335
/**************** fnEmidaNivelCfgSiteID ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEmidaNivelCfgSiteID') DROP FUNCTION fnEmidaNivelCfgSiteID
GO
CREATE FUNCTION dbo.fnEmidaNivelCfgSiteID(		
			@Empresa	varchar(5)
) 
RETURNS varchar(10) 
AS
BEGIN
  RETURN(SELECT NivelCfgSiteID FROM EmidaCfg WHERE Empresa = @Empresa)
END
GO

--REQ14335
-- SELECT dbo.fnEmidaSiteID('DEMO', 'https://ws.terecargamos.com:8448/soap/servlet/rpcrouter', 0, 'DEMO')
/**************** fnEmidaSiteID ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEmidaSiteID') DROP FUNCTION fnEmidaSiteID
GO
CREATE FUNCTION fnEmidaSiteID(
		@Empresa		varchar(5),
		@URL			varchar(255),
		@Sucursal		int,
		@Usuario		varchar(10)
		)
RETURNS varchar(20)
AS
BEGIN
  DECLARE @terminalId		varchar(20),
          @NivelCfgSiteID	varchar(10)

  SELECT @NivelCfgSiteID = dbo.fnEmidaNivelCfgSiteID(@Empresa)  

  IF @NivelCfgSiteID = 'Agente'
    SELECT @terminalId = SiteID FROM EmidaTerminalCfg JOIN Usuario ON EmidaTerminalCfg.Agente = Usuario.DefAgente WHERE Empresa = @Empresa AND Usuario = @Usuario AND URL = @URL
  ELSE IF @NivelCfgSiteID =  'Sucursal'
    SELECT @terminalId = SiteID FROM EmidaTerminalCfg WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND URL = @URL
  ELSE IF @NivelCfgSiteID = 'Caja'
    SELECT @terminalId = SiteID FROM EmidaTerminalCfg JOIN Usuario ON EmidaTerminalCfg.CtaDinero = Usuario.DefCtaDinero WHERE Empresa = @Empresa AND Usuario = @Usuario AND URL = @URL

  RETURN @terminalId
END
GO

-- REQ12336
/**************** spEmidaSubmitPaymentEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaSubmitPaymentEliminar') and type = 'P') drop procedure dbo.spEmidaSubmitPaymentEliminar
GO
CREATE PROCEDURE spEmidaSubmitPaymentEliminar
		@Estacion		int
--//WITH ENCRYPTION
AS
BEGIN
  DELETE EmidaSubmitPayment WHERE Estacion = @Estacion
END
GO

-- REQ12336
/**************** spEmidaDineroSubmitPayment ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaDineroSubmitPayment') and type = 'P') drop procedure dbo.spEmidaDineroSubmitPayment
GO
CREATE PROC spEmidaDineroSubmitPayment
			@Modulo			varchar(5),
			@ModuloID		int,
			@Empresa		varchar(5),
			@Estacion		int,
			@Usuario		varchar(10),
			@Sucursal		int,
			@Ok				int			 = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @OrigenModuloID		int,
		  @OrigenModuloIDAnt	int,
		  @CarrierID			int,
		  @CtaDinero			varchar(10),
		  @Version				varchar(2),
		  @terminalId			varchar(20),
		  @clerkId				varchar(20),
		  @URL					varchar(255),
		  @bankCode				varchar(20),
		  @iResultado			int,
		  @Resultado			varchar(max),
		  @Solicitud			varchar(max),
		  @Fecha				datetime,
		  @Contrasena			varchar(32),

		  @amount				float,
		  @documentNumber		varchar(25),
		  @documentDate			datetime,
		  @documentDateTexto	varchar(10),
		  @OkDesc				varchar(255),
		  @OkTipo				varchar(50),
		  @EmidaRequestId		varchar(20)

  SELECT @Version = Version FROM EmidaCfg WHERE Empresa = @Empresa

  SELECT @Fecha = GETDATE()

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario

  SELECT @documentNumber = Referencia,
		 @documentDate	 = FechaEmision,
		 @amount		 = ISNULL(Importe, 0)
    FROM Dinero
   WHERE ID = @ModuloID

  IF DATEPART(mm, @documentDate) < 10
    SELECT @documentDateTexto = '0' + CONVERT(varchar, DATEPART(mm, @documentDate)) + '/'
  ELSE
    SELECT @documentDateTexto = CONVERT(varchar, DATEPART(mm, @documentDate)) + '/'
    
  IF DATEPART(dd, @documentDate) < 10
    SELECT @documentDateTexto = @documentDateTexto + '0' + CONVERT(varchar, DATEPART(dd, @documentDate)) + '/'
  ELSE
    SELECT @documentDateTexto = @documentDateTexto + CONVERT(varchar, DATEPART(dd, @documentDate)) + '/'

  SELECT @documentDateTexto = @documentDateTexto + CONVERT(varchar, DATEPART(yy, @documentDate))
  
  SELECT @OrigenModuloIDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @OrigenModuloID = MIN(Cxp.ID)
      FROM MovImpuesto 
      JOIN Cxp ON MovImpuesto.OrigenModulo = 'CXP' AND MovImpuesto.OrigenModuloID = Cxp.ID
      JOIN MovTipo ON MovTipo.Modulo = 'CXP' AND MovTipo.Mov = Cxp.Mov
     WHERE MovImpuesto.Modulo = 'DIN' 
       AND MovImpuesto.ModuloID = @ModuloID
       AND ISNULL(MovTipo.SubClave, '') = 'CXP.AEMIDA'
       AND Cxp.ID > @OrigenModuloIDAnt
       
    IF @OrigenModuloID IS NULL BREAK
    
    SELECT @OrigenModuloIDAnt = @OrigenModuloID
    
    SELECT @CarrierID = EmidaCarrierID, @CtaDinero = CtaDinero
      FROM Cxp 
     WHERE ID = @OrigenModuloID

    SELECT @URL = URL
      FROM EmidaCarrierCfg
     WHERE EmidaCarrierCfg.CarrierId = @CarrierID

    --REQ14335
    SELECT @terminalId = dbo.fnEmidaSiteID(@Empresa, @URL, @Sucursal, @Usuario)
    --SELECT @terminalId = EmidaTerminalCfg.SiteID
    --  FROM EmidaTerminalCfg
    -- WHERE EmidaTerminalCfg.Empresa = @Empresa
    --   AND EmidaTerminalCfg.Estacion = @Estacion
    --   AND EmidaTerminalCfg.URL = @URL
    --   AND EmidaTerminalCfg.Sucursal = @Sucursal

    SELECT @ClerkID = Agente.ClerkID
      FROM Agente
      JOIN Usuario ON Agente.Agente = Usuario.DefAgente
     WHERE Usuario = @Usuario

    SELECT @bankCode = EmidaBankCode
      FROM InstitucionFin 
      JOIN CtaDinero ON CtaDinero.Institucion = InstitucionFin.Institucion
     WHERE CtaDinero.CtaDinero = @CtaDinero

    SELECT @Solicitud = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.SubmitPayment" SubReferencia="" Version="' + ISNULL(@Version, '') + '">' + 
                        '  <Solicitud>' + 
                        '    <Emida Estacion="' + CONVERT(varchar, ISNULL(@Estacion, 0)) + '" Empresa="' + ISNULL(dbo.fneDocXmlAUTF8(@Empresa, 0, 1), '') + '" URL="' + ISNULL(@URL, '') + '" terminalId="' + ISNULL(@terminalId, '') + '" Version="' + ISNULL(@Version, '') + '" clerkId="' + ISNULL(@clerkId, '') + '" bankCode="' + ISNULL(@bankCode, '') + '" amount="' + ISNULL(CONVERT(varchar, @amount), '') + '" documentNumber="' + ISNULL(@documentNumber, '') + '" documentDate="' + ISNULL(@documentDateTexto, '') + '" />' + 
                        '  </Solicitud>' + 
                        '</Intelisis>'

    EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado = @Resultado OUTPUT, @Procesar = 1, @EliminarProcesado = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT     
    
    IF @Ok IS NULL 
    BEGIN
      EXEC sp_xml_preparedocument @iResultado OUTPUT, @Resultado

       SELECT @EmidaRequestId = requestId
        FROM OPENXML(@iResultado, '/Intelisis/Resultado/SubmitPaymentNotificationResponse', 2) 
         WITH(requestId varchar(20))

      UPDATE Cxp SET EmidaRequestId = @EmidaRequestId WHERE ID = @OrigenModuloID
      UPDATE Dinero SET EmidaRequestId = @EmidaRequestId WHERE ID = @ModuloID

      EXEC sp_xml_removedocument @iResultado 
    END
  END

  IF @Ok IS NULL 
    SELECT @OkRef = NULL
    
  RETURN
END
GO

-- REQ12336
/**************** spEmidaSubmitPayment ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaSubmitPayment') and type = 'P') drop procedure dbo.spEmidaSubmitPayment
GO
CREATE PROC spEmidaSubmitPayment
			@Empresa		varchar(5),
			@Estacion		int,
			@Usuario		varchar(10),
			@Sucursal		int,
			@Ok				int			 = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Version				varchar(2),
		  @terminalId			varchar(20),
		  @clerkId				varchar(20),
		  @URL					varchar(255),
		  @bankCode				varchar(20),
		  @iResultado			int,
		  @Solicitud			varchar(max),
		  @Fecha				datetime,
		  @Contrasena			varchar(32),

		  @amount				float,
		  @documentNumber		varchar(25),
		  @documentDate			datetime,
		  @documentDateTexto	varchar(10),
		  @OkDesc				varchar(255),
		  @OkTipo				varchar(50)

  SELECT @Version = Version FROM EmidaCfg WHERE Empresa = @Empresa

  SELECT @Fecha = GETDATE()

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
    
  SELECT @URL = EmidaCarrierCfg.URL
    FROM EmidaSubmitPayment
    JOIN EmidaCarrierCfg ON EmidaSubmitPayment.CarrierId = EmidaCarrierCfg.CarrierId AND EmidaCarrierCfg.Empresa = @Empresa
   WHERE EmidaSubmitPayment.Estacion = @Estacion

  --REQ14335
  SELECT @terminalId = dbo.fnEmidaSiteID(@Empresa, @URL, @Sucursal, @Usuario)   
  --SELECT @terminalId = EmidaTerminalCfg.SiteID
  --  FROM EmidaTerminalCfg
  -- WHERE EmidaTerminalCfg.Empresa = @Empresa
  --   AND EmidaTerminalCfg.Estacion = @Estacion
  --   AND EmidaTerminalCfg.URL = @URL
  --   AND EmidaTerminalCfg.Sucursal = @Sucursal

  SELECT @ClerkID = Agente.ClerkID
    FROM Agente
    JOIN Usuario ON Agente.Agente = Usuario.DefAgente
   WHERE Usuario = @Usuario
     
  SELECT @bankCode = EmidaBankCode
    FROM InstitucionFin 
    JOIN EmidaSubmitPayment ON InstitucionFin.Institucion = EmidaSubmitPayment.Institucion
   WHERE EmidaSubmitPayment.Estacion = @Estacion

  SELECT @amount		 = amount,
		 @documentNumber = documentNumber,
		 @documentDate	 = documentDate
    FROM EmidaSubmitPayment
   WHERE Estacion = @Estacion

  IF DATEPART(mm, @documentDate) < 10
    SELECT @documentDateTexto = '0' + CONVERT(varchar, DATEPART(mm, @documentDate)) + '/'
  ELSE
    SELECT @documentDateTexto = CONVERT(varchar, DATEPART(mm, @documentDate)) + '/'
    
  IF DATEPART(dd, @documentDate) < 10
    SELECT @documentDateTexto = @documentDateTexto + '0' + CONVERT(varchar, DATEPART(dd, @documentDate)) + '/'
  ELSE
    SELECT @documentDateTexto = @documentDateTexto + CONVERT(varchar, DATEPART(dd, @documentDate)) + '/'

  SELECT @documentDateTexto = @documentDateTexto + CONVERT(varchar, DATEPART(yy, @documentDate))

  SELECT @Solicitud = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.SubmitPayment" SubReferencia="" Version="' + ISNULL(@Version, '') + '">' + 
                      '  <Solicitud>' + 
                      '    <Emida Estacion="' + CONVERT(varchar, ISNULL(@Estacion, 0)) + '" Empresa="' + ISNULL(dbo.fneDocXmlAUTF8(@Empresa, 0, 1), '') + '" URL="' + ISNULL(@URL, '') + '" terminalId="' + ISNULL(@terminalId, '') + '" Version="' + ISNULL(@Version, '') + '" clerkId="' + ISNULL(@clerkId, '') + '" bankCode="' + ISNULL(@bankCode, '') + '" amount="' + ISNULL(CONVERT(varchar, @amount), '') + '" documentNumber="' + ISNULL(@documentNumber, '') + '" documentDate="' + ISNULL(@documentDateTexto, '') + '" />' + 
                      '  </Solicitud>' + 
                      '</Intelisis>'
  
  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Procesar = 1, @EliminarProcesado = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

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

/*
  DECLARE @InvoiceNo	int
  EXEC spEmidaInvoiceNo 1, 'DEMO', 'https://ws.microrecargas.com:8449/soap/servlet/rpcrouter', 'CONSECUTIVO', 0, 'DEMO', @InvoiceNo OUTPUT
  SELECT @InvoiceNo
*/
-- REQ12336
/**************** spEmidaInvoiceNo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaInvoiceNo') and type = 'P') drop procedure dbo.spEmidaInvoiceNo
GO
CREATE PROCEDURE spEmidaInvoiceNo
			@Estacion	int,
			@Empresa	varchar(5),
			@URL		varchar(255),
			@Accion		varchar(20),
			@Sucursal	int,
			@Usuario	varchar(10),	--REQ14335
			@InvoiceNo	int			= NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  --REQ14335
  DECLARE @NivelCfgSiteID	varchar(10)
  
  SELECT @NivelCfgSiteID = dbo.fnEmidaNivelCfgSiteID(@Empresa)

  IF @NivelCfgSiteID = 'Agente'
    SELECT @InvoiceNo = InvoiceNo FROM EmidaTerminalCfg JOIN Usuario ON EmidaTerminalCfg.Agente = Usuario.DefAgente WHERE Empresa = @Empresa AND Usuario = @Usuario AND URL = @URL
  ELSE IF @NivelCfgSiteID =  'Sucursal'
    SELECT @InvoiceNo = InvoiceNo FROM EmidaTerminalCfg WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND URL = @URL
  ELSE IF @NivelCfgSiteID = 'Caja'
    SELECT @InvoiceNo = InvoiceNo FROM EmidaTerminalCfg JOIN Usuario ON EmidaTerminalCfg.CtaDinero = Usuario.DefCtaDinero WHERE Empresa = @Empresa AND Usuario = @Usuario AND URL = @URL  

  IF @Accion = 'AFECTAR'
  BEGIN
    IF @NivelCfgSiteID = 'Agente'
    BEGIN
      IF @InvoiceNo = 99999
        UPDATE EmidaTerminalCfg SET InvoiceNo = 1 FROM EmidaTerminalCfg JOIN Usuario ON EmidaTerminalCfg.Agente = Usuario.DefAgente WHERE Empresa = @Empresa AND Usuario = @Usuario AND URL = @URL
      ELSE
        UPDATE EmidaTerminalCfg SET InvoiceNo = @InvoiceNo + 1 FROM EmidaTerminalCfg JOIN Usuario ON EmidaTerminalCfg.Agente = Usuario.DefAgente WHERE Empresa = @Empresa AND Usuario = @Usuario AND URL = @URL
    END
    ELSE IF @NivelCfgSiteID = 'Sucursal'
    BEGIN    
      IF @InvoiceNo = 99999
        UPDATE EmidaTerminalCfg SET InvoiceNo = 1 FROM EmidaTerminalCfg WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND URL = @URL
      ELSE
        UPDATE EmidaTerminalCfg SET InvoiceNo = @InvoiceNo + 1 FROM EmidaTerminalCfg WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND URL = @URL
    END
    ELSE IF @NivelCfgSiteID = 'Caja'
    BEGIN   
      IF @InvoiceNo = 99999
        UPDATE EmidaTerminalCfg SET InvoiceNo = 1 FROM EmidaTerminalCfg JOIN Usuario ON EmidaTerminalCfg.CtaDinero = Usuario.DefCtaDinero WHERE Empresa = @Empresa AND Usuario = @Usuario AND URL = @URL  
	  ELSE
        UPDATE EmidaTerminalCfg SET InvoiceNo = @InvoiceNo + 1 FROM EmidaTerminalCfg JOIN Usuario ON EmidaTerminalCfg.CtaDinero = Usuario.DefCtaDinero WHERE Empresa = @Empresa AND Usuario = @Usuario AND URL = @URL  
    END
  END
  RETURN
END
GO

-- REQ12336
/**************** spEmidaGetCarrier ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaGetCarrier') and type = 'P') drop procedure dbo.spEmidaGetCarrier
GO
CREATE PROCEDURE spEmidaGetCarrier
			@Estacion		int,
			@Empresa		varchar(5),
			@Usuario		varchar(10),
			@URL			varchar(255),
			@Version		varchar(2),
			@SiteID			varchar(20),
			@Ok				int			 = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Respuesta	varchar(max),
		  @iResultado	int,
		  @Solicitud	varchar(max),
		  @Fecha		datetime,
		  @Contrasena	varchar(32)

  SELECT @Fecha = GETDATE()

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario

  SELECT @Solicitud = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.ActualizarCatalogo" SubReferencia="CarrierList" Version="' + ISNULL(@Version, '') + '">' + 
                      '  <Solicitud>' + 
                      '    <Emida Estacion="' + CONVERT(varchar, ISNULL(@Estacion, 0)) + '" Empresa="' + ISNULL(dbo.fneDocXmlAUTF8(@Empresa, 0, 1), '') + '" URL="' + ISNULL(@URL, '') + '" SiteID="' + ISNULL(@SiteID, '') + '" Version="' + ISNULL(@Version, '') + '" />' + 
                      '  </Solicitud>' + 
                      '</Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Procesar = 1, @EliminarProcesado = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  
  RETURN 
END
GO

-- REQ12336
/**************** spEmidaGetProduct ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaGetProduct') and type = 'P') drop procedure dbo.spEmidaGetProduct
GO
CREATE PROCEDURE spEmidaGetProduct
			@Estacion		int,
			@Empresa		varchar(5),
			@Usuario		varchar(10),
			@URL			varchar(255),
			@Version		varchar(2),
			@SiteID			varchar(20),
			@Ok				int			 = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Respuesta	varchar(max),
		  @iResultado	int,
		  @Solicitud	varchar(max),
		  @Fecha		datetime,
		  @Contrasena	varchar(32)

  SELECT @Fecha = GETDATE()

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario

  SELECT @Solicitud = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.ActualizarCatalogo" SubReferencia="ProductList" Version="' + ISNULL(@Version, '') + '">' + 
                      '  <Solicitud>' + 
                      '    <Emida Estacion="' + CONVERT(varchar, ISNULL(@Estacion, 0)) + '" Empresa="' + ISNULL(dbo.fneDocXmlAUTF8(@Empresa, 0, 1), '') + '" URL="' + ISNULL(@URL, '') + '" SiteID="' + ISNULL(@SiteID, '') + '" Version="' + ISNULL(@Version, '') + '" />' + 
                      '  </Solicitud>' + 
                      '</Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Procesar = 1, @EliminarProcesado = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  
  RETURN 
END
GO

-- REQ12336
-- EXEC spEmidaActualizarCatalogos 1, 'DEMO', 'DEMO', 0
/**************** spEmidaActualizarCatalogos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaActualizarCatalogos') and type = 'P') drop procedure dbo.spEmidaActualizarCatalogos
GO
CREATE PROCEDURE spEmidaActualizarCatalogos
			@Estacion		int,
			@Empresa		varchar(5),
			@Usuario		varchar(10),
			@Sucursal		int,
			@Ok				int			 = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Solicitud	varchar(max),
		  @URL			varchar(255),
		  @URLAnt		varchar(255),
		  @Version		varchar(2),
		  @SiteID		varchar(20),
		  @OkDesc		varchar(255),
		  @OkTipo		varchar(50)

  DELETE EmidaActualizarCatalogos WHERE Estacion = @Estacion
 
  SELECT @Version = Version FROM EmidaCfg WHERE Empresa = @Empresa

  SELECT @URLAnt = ''  
  WHILE(1=1)
  BEGIN
    SELECT @URL = MIN(URL)
      FROM EmidaURLCfg
     WHERE Empresa = @Empresa
       AND URL > @URLAnt

    IF @URL IS NULL BREAK
    
    SELECT @URLAnt = @URL
    
    --REQ14335
    SELECT @SiteID = dbo.fnEmidaSiteID(@Empresa, @URL, @Sucursal, @Usuario)
    --SELECT @SiteID = SiteID FROM EmidaTerminalCfg WHERE Empresa = @Empresa AND URL = @URL AND Estacion = @Estacion AND Sucursal = @Sucursal

    IF @Ok IS NULL
      EXEC spEmidaGetCarrier @Estacion, @Empresa, @Usuario, @URL, @Version, @SiteID, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spEmidaGetProduct @Estacion, @Empresa, @Usuario, @URL, @Version, @SiteID, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    
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
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, NULL
END
GO

-- REQ12336
-- EXEC spEmidaGetAccountBalance 1, 'DEMO'
/**************** spEmidaGetAccountBalance ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaGetAccountBalance') and type = 'P') drop procedure dbo.spEmidaGetAccountBalance
GO
CREATE PROCEDURE spEmidaGetAccountBalance
			@Estacion		int,
			@Empresa		varchar(5),
			@Sucursal		int,
			@Usuario		varchar(10),
			@Ok				int			 = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @URL			varchar(255),
		  @URLAnt		varchar(255),
		  @Version		varchar(2),
		  @SiteID		varchar(20),
		  @MerchantID	varchar(20),
		  @OkDesc		varchar(255),
		  @OkTipo		varchar(50),
		  @Solicitud	varchar(max),
		  @Contrasena	varchar(32),
		  @Fecha		datetime

  SELECT @Fecha = GETDATE()

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario

  SELECT @Version = Version FROM EmidaCfg WHERE Empresa = @Empresa

  SELECT @URLAnt = ''  
  WHILE(1=1)
  BEGIN
    SELECT @URL = MIN(URL)
      FROM EmidaURLCfg
     WHERE Empresa = @Empresa
       AND URL > @URLAnt

    IF @URL IS NULL BREAK
    
    SELECT @URLAnt = @URL
    
    SELECT @MerchantID = MerchantID FROM EmidaMerchantIDCfg WHERE Empresa = @Empresa AND URL = @URL AND Sucursal = @Sucursal
    
    --REQ14335
    SELECT @SiteID = dbo.fnEmidaSiteID(@Empresa, @URL, @Sucursal, @Usuario)
    --SELECT @SiteID = SiteID FROM EmidaTerminalCfg WHERE Empresa = @Empresa AND URL = @URL AND Estacion = @Estacion AND Sucursal = @Sucursal

    SELECT @Solicitud = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.AccountBalance" SubReferencia="" Version="' + ISNULL(@Version, '') + '">' + 
                        '  <Solicitud>' + 
                        '    <Emida Estacion="' + CONVERT(varchar, ISNULL(@Estacion, 0)) + '" Empresa="' + ISNULL(dbo.fneDocXmlAUTF8(@Empresa, 0, 1), '') + '" URL="' + ISNULL(@URL, '') + '" SiteID="' + ISNULL(@SiteID, '') + '" Version="' + ISNULL(@Version, '') + '" Sucursal="' + CONVERT(varchar, ISNULL(@Sucursal, 0)) +'" MerchantID="' + ISNULL(@MerchantId, '') + '" />' + 
                        '  </Solicitud>' + 
                        '</Intelisis>'

    EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Procesar = 1, @EliminarProcesado = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
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
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, NULL
  
  RETURN
END
GO

-- REQ12336
/**************** spEmidaLookUpTransactionByInvocieNo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaLookUpTransactionByInvocieNo') and type = 'P') drop procedure dbo.spEmidaLookUpTransactionByInvocieNo
GO
CREATE PROCEDURE spEmidaLookUpTransactionByInvocieNo 
			@Estacion		int,
			@Empresa		varchar(5),
			@Sucursal		int,
			@Usuario		varchar(10),
			@Contrasena		varchar(32),
			@URL			varchar(255),
			@version		varchar(2),
			@terminalId		varchar(20),
			@clerkId		varchar(20),
			@invoiceNo		varchar(20),
			@Reintentos		int, 
			@Resultado		varchar(max)	OUTPUT,
			@Ok				int				OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Solicitud		varchar(max),
		  @NoReintento		int,
		  @iResultado		int,
		  @ResponseCode		varchar(2),
		  @ResponseMessage	varchar(250),
		  @TimeOutLookup	int,		-- REQ13894
		  @Delay			varchar(10)	-- REQ13894

  SELECT @TimeOutLookup = ISNULL(TimeOutLookup, 10) FROM EmidaCfg WHERE Empresa = @Empresa
  
  SELECT @Delay = '00:00:' + CONVERT(varchar(2), @TimeOutLookup)
  
  --SELECT @Ok = NULL, @OkRef = NULL
  
  SELECT @NoReintento = 1
  WHILE(@NoReintento<=@Reintentos)
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    
    SELECT @Solicitud = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.LookupTransaction" SubReferencia="" Version="' + ISNULL(@Version, '') + '">' + 
                        '  <Solicitud>' + 
                        '    <Emida Estacion="' + CONVERT(varchar, ISNULL(@Estacion, 0)) + '" Empresa="' + ISNULL(dbo.fneDocXmlAUTF8(@Empresa, 0, 1), '') + '" URL="' + ISNULL(@URL, '') + '" terminalId="' + ISNULL(@terminalId, '') + '" Version="' + ISNULL(@Version, '') + '" Sucursal="' + CONVERT(varchar, ISNULL(@Sucursal, 0)) +'" clerkId="' + ISNULL(@clerkId, '') + '" invoiceNo="' + ISNULL(@invoiceNo, '') + '" IntentoNumero="' + CONVERT(varchar, @NoReintento) + '" />' + 
                        '  </Solicitud>' + 
                        '</Intelisis>'

    EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado = @Resultado OUTPUT, @Procesar = 1, @EliminarProcesado = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    
    IF @Ok IS NULL RETURN

    WAITFOR DELAY @Delay
    
    SELECT @NoReintento = @NoReintento + 1      
  END
  
  RETURN
END
GO

-- REQ12336
/**************** spEmidaRecargaTelefonica ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaRecargaTelefonica') and type = 'P') drop procedure dbo.spEmidaRecargaTelefonica
GO
CREATE PROCEDURE spEmidaRecargaTelefonica
			@Modulo			varchar(5),
			@ModuloID		int,
			@Estacion		int,
			@Empresa		varchar(5),
			@Sucursal		int,
			@Usuario		varchar(10),
			@Ok				int			 = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Renglon				int,
		  @RenglonAnt			int,
		  @Articulo				varchar(20), -- BUG13887
		  @URL					varchar(255),
		  @version				varchar(2),
		  @terminalId			varchar(20),
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
		  @Solicitud			varchar(max),
		  @Contrasena			varchar(32),
		  @Fecha				datetime,
		  @Reintentos			int,
		  @Resultado			varchar(max),
		  @iResultado			int,
		  @EmidaControlNo		varchar(20),
		  @EmidaCarrierControlNo varchar(20), --REQ13894
		  @EmidaTransactionId	varchar(20),
		  @EmidaResponseMessage	varchar(500),
		  @EmidaTransactionDateTime	datetime,
		  @EmidaResponseCode	varchar(2)

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
  
  SELECT @version = Version, @Reintentos = Reintentos FROM EmidaCfg WHERE Empresa = @Empresa

  IF @Modulo = 'VTAS'
    SELECT @ClerkID = Agente.ClerkID
      FROM Agente
      JOIN Venta ON Agente.Agente = Venta.Agente
     WHERE ID = @ModuloID
       
  SELECT @RenglonAnt = 0
  WHILE(1=1)
  BEGIN
    IF @Modulo = 'VTAS'
      SELECT @Renglon = MIN(Renglon)
        FROM VentaD
        JOIN Art ON VentaD.Articulo = Art.Articulo AND ISNULL(Art.EmidaRecargaTelefonica, 0) = 1
       WHERE ID = @ModuloID 
         AND Renglon > @RenglonAnt

    IF @Renglon IS NULL BREAK
    
    SELECT @RenglonAnt = @Renglon
    
    SELECT @Articulo = Articulo, @RecargaTelefono = ISNULL(RecargaTelefono, ''), @RecargaConfirmarTelefono = ISNULL(RecargaConfirmarTelefono, '') FROM VentaD WHERE ID = @ModuloID AND Renglon = @Renglon -- REQ13848
    
    SELECT @URL = URL, @CarrierId = CarrierId, @ProductId = ProductId, @Description = Description, @ShortDescription = ShortDescription, @amount = amount, 
		   @languageOption = '02'
      FROM EmidaProductCfg
     WHERE Articulo = @Articulo
    
    --REQ14335
    SELECT @terminalId = dbo.fnEmidaSiteID(@Empresa, @URL, @Sucursal, @Usuario)     
    --SELECT @terminalId = SiteID
    --  FROM EmidaTerminalCfg
    -- WHERE Empresa = @Empresa
    --   AND URL = @URL
    --   AND Estacion = @Estacion
    --   AND Sucursal =  @Sucursal
     
    EXEC spEmidaInvoiceNo @Estacion, @Empresa, @URL, 'CONSECUTIVO', @Sucursal, @Usuario, @invoiceNo OUTPUT --REQ14335

    IF @Ok IS NULL
    BEGIN
      SELECT @Solicitud = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Emida.RecargaTelefonica" SubReferencia="" Version="' + ISNULL(@Version, '') + '">' + 
                          '  <Solicitud>' + 
                          '    <Emida Estacion="' + CONVERT(varchar, ISNULL(@Estacion, 0)) + '" Empresa="' + ISNULL(dbo.fneDocXmlAUTF8(@Empresa, 0, 1), '') + '" URL="' + ISNULL(@URL, '') + '" terminalId="' + ISNULL(@terminalId, '') + '" Version="' + ISNULL(@Version, '') + '" Sucursal="' + CONVERT(varchar, ISNULL(@Sucursal, 0)) +'" productId="' + ISNULL(@productId, '') + '" clerkId="' + ISNULL(@clerkId, '') + '" accountId="' + ISNULL(@RecargaTelefono, '') + '" amount="' + ISNULL(@amount, '') + '" invoiceNo="' + ISNULL(@invoiceNo, '') + '" languageOption="' + ISNULL(@languageOption, '') + '" Usuario="' + @Usuario +'" Contrasena="' + @Contrasena + '" />' +  -- REQ13848
                          '  </Solicitud>' + 
                          '</Intelisis>'
                      
      EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado = @Resultado OUTPUT, @Procesar = 1, @EliminarProcesado = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END

    IF @Ok IS NULL 
    BEGIN
      SELECT @OkRef = NULL
      EXEC sp_xml_preparedocument @iResultado OUTPUT, @Resultado

       SELECT @EmidaControlNo = ControlNo, @EmidaTransactionId = TransactionId, @EmidaResponseMessage = ResponseMessage,
			  @EmidaTransactionDateTime = TransactionDateTime, @EmidaResponseCode = ResponseCode,
			  @EmidaCarrierControlNo = CarrierControlNo -- REQ13894
        FROM OPENXML(@iResultado, '/Intelisis/Resultado/PinDistSaleResponse', 2) 
         WITH(CarrierControlNo varchar(20), ControlNo varchar(20), TransactionId varchar(20), ResponseMessage varchar(500), TransactionDateTime datetime, ResponseCode varchar(2))

      UPDATE Venta
         SET RecargaTelefono = @RecargaTelefono, -- REQ13848
             EmidaResponseCode = @EmidaResponseCode,
			 EmidaControlNo = @EmidaControlNo, 
			 EmidaCarrierControlNo = @EmidaCarrierControlNo, -- REQ13894
			 EmidaTransactionId = @EmidaTransactionId, 
			 EmidaResponseMessage = @EmidaResponseMessage,
			 EmidaTransactionDateTime = @EmidaTransactionDateTime
        FROM Venta
       WHERE ID = @ModuloID

      EXEC sp_xml_removedocument @iResultado 

      EXEC spEmidaInvoiceNo @Estacion, @Empresa, @URL, 'AFECTAR', @Sucursal, @Usuario --REQ14335
    END    
  END

  RETURN
END
GO

/**************** spEmidaGenerarOC ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaGenerarOC') and type = 'P') drop procedure dbo.spEmidaGenerarOC
GO
CREATE PROCEDURE spEmidaGenerarOC
			@Usuario		varchar(10),
			@Empresa		varchar(5),
			@Sucursal		int,
			@FechaD			datetime,
			@FechaA			datetime,
			@Ok				int			 = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Proveedor		varchar(10),
		  @Articulo			varchar(20),
		  @Almacen			varchar(10),
		  @FechaEmision		datetime,
		  @FechaRegistro	datetime,
		  @Mov				varchar(20),
		  @Moneda			varchar(10),
		  @TipoCambio		float,
		  @IDCompra			int,
		  @Costo			float,
		  @OkDesc			varchar(255),
		  @OkTipo			varchar(50),
		  @URL				varchar(255),
		  @URLAnt			varchar(255)

  SELECT @FechaEmision = GETDATE(), @FechaRegistro = GETDATE()
  EXEC spExtraerFecha @FechaEmision OUTPUT
  
  SELECT @Proveedor = Proveedor, @Mov = MovOC FROM EmidaCfg WHERE Empresa = @Empresa
  SELECT @Articulo = Articulo FROM Art WHERE ISNULL(EmidaTiempoAire, 0) = 1
  SELECT @Almacen = AlmacenPrincipal FROM Sucursal WHERE Sucursal = @Sucursal
  SELECT @Moneda = DefMoneda FROM Prov WHERE Proveedor = @Proveedor
  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
  
  IF @Proveedor IS NULL
    SELECT @Ok = 40020
  IF @Articulo IS NULL AND @Ok IS NULL
    SELECT @Ok = 20400
  IF @Almacen IS NULL AND @Ok IS NULL
    SELECT @Ok = 20390
  IF @Mov IS NULL AND @Ok IS NULL
    SELECT @Ok = 55130
  IF @Moneda IS NULL AND @Ok IS NULL
    SELECT @Ok = 30040
    
  IF @Ok IS NULL
  BEGIN
    CREATE TABLE #VentaD(
      ID			int, 
      Renglon		float,
      RenglonID		int,
      RenglonSub	int,
      Estatus		varchar(15)	COLLATE DATABASE_DEFAULT ,
      Articulo		varchar(20)	COLLATE DATABASE_DEFAULT ,
      Cantidad		float,
      FechaEmision	datetime,
      CarrierId		varchar(255)COLLATE DATABASE_DEFAULT NULL,
	  URL			varchar(255)COLLATE DATABASE_DEFAULT NULL,      
      Comision		float		NULL,
      Precio		float		NULL,
      Importe		float		NULL,
      EnCorte		bit			NOT NULL DEFAULT 0
      )

    CREATE TABLE #CompraD(
      ID			int, 
      Renglon		int			IDENTITY(1024, 1024),
      Estatus		varchar(15)	COLLATE DATABASE_DEFAULT ,
      Articulo		varchar(20)	COLLATE DATABASE_DEFAULT ,
      Cantidad		float,
      FechaEmision	datetime,
      CarrierId		varchar(255)COLLATE DATABASE_DEFAULT NULL,
	  URL			varchar(255)COLLATE DATABASE_DEFAULT NULL,  
      Comision		float		NULL,
      Precio		float		NULL,
      Importe		float		NULL
      )      

    INSERT INTO #VentaD(
			    ID,   Renglon,   RenglonID,   RenglonSub,   Articulo,   Cantidad,   FechaEmision,   Estatus)
	   SELECT d.ID, d.Renglon, d.RenglonID, d.RenglonSub, d.Articulo, d.Cantidad, v.FechaEmision, v.Estatus
  	     FROM Venta v
	     JOIN VentaD d ON v.ID = d.ID
	     JOIN MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'VTAS' AND ISNULL(m.SubClave, '') = 'VTAS.NEMIDA' -- REQ13894
	     JOIN Art a ON d.Articulo = a.Articulo AND ISNULL(a.EmidaRecargaTelefonica, 0) = 1
	    WHERE v.Estatus IN('CONCLUIDO', 'PROCESAR') -- REQ13894
  	      AND v.FechaEmision BETWEEN @FechaD AND @FechaA
	      AND v.Sucursal = @Sucursal
	      AND ISNULL(EmidaResponseCode, '') = '00'
	      AND v.Empresa = @Empresa

    UPDATE #VentaD
       SET URL		= EmidaProductCfg.URL,
           CarrierId= EmidaProductCfg.CarrierId,
		   Precio   = EmidaProductCfg.Amount,
           Comision = EmidaProductCfg.Comision,
		   Importe = (Amount * Cantidad) - ISNULL((Amount * Cantidad) * (EmidaProductCfg.Comision / 100) ,0)
      FROM #VentaD
      JOIN EmidaProductCfg ON #VentaD.Articulo = EmidaProductCfg.Articulo
      
    DELETE #VentaD
      FROM #VentaD
      JOIN EmidaCompraD ON #VentaD.ID = EmidaCompraD.IDVTAS
      JOIN Compra ON EmidaCompraD.ID = Compra.ID 
     WHERE Compra.Estatus IN('PENDIENTE', 'CONCLUIDO')
    
    SELECT @URLAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @URL = MIN(URL)
        FROM #VentaD
       WHERE URL > @URLAnt
      
      IF @URL IS NULL BREAK
      
      SELECT @URLAnt = @URL

      INSERT INTO Compra(
			    Empresa,  Mov,  FechaEmision,  Moneda,  TipoCambio,  Usuario, Estatus,      Proveedor,  Almacen, OrigenTipo,  Origen,   Sucursal,  Observaciones) 
	    SELECT @Empresa, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'CONFIRMAR', @Proveedor, @Almacen, 'Usuario',  @Usuario, @Sucursal, @URL 

      SELECT @IDCompra = @@IDENTITY

      TRUNCATE TABLE #CompraD
      
      INSERT INTO #CompraD(
			    ID,        Articulo, Cantidad,      FechaEmision, CarrierId, URL, Comision, Precio,      Estatus)
	    SELECT @IDCompra, @Articulo, SUM(Cantidad), FechaEmision, CarrierId, URL, Comision, SUM(Precio), Estatus
	      FROM #VentaD
	     WHERE URL = @URL 
	    GROUP BY FechaEmision, CarrierId, URL, Comision, Estatus

      INSERT INTO EmidaCompraD(
			    ID,       IDVTAS, Articulo, Cantidad, FechaEmision, CarrierId, URL, Comision, Precio, Estatus)
	    SELECT @IDCompra, ID,     Articulo, Cantidad, FechaEmision, CarrierId, URL, Comision, Precio, Estatus
	      FROM #VentaD
	     WHERE URL = @URL 

      INSERT INTO CompraD(
			    ID,       Renglon, RenglonSub, RenglonID,    RenglonTipo, Cantidad,	 Almacen,  Articulo, Costo,  Impuesto1, Impuesto2, Impuesto3, Retencion1, Retencion2, Retencion3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto4, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3, DescuentoLinea,    EmidaFechaRecarga,     EmidaProveedorCelular,       EmidaURL)
	    SELECT @IDCompra, Renglon, 0,          Renglon/1024, 'N',         1,        @Almacen, @Articulo, Precio, Impuesto1, Impuesto2, Impuesto3, Retencion1, Retencion2, Retencion3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto4, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3, #CompraD.Comision, #CompraD.FechaEmision, EmidaCarrierCfg.Description, #CompraD.URL
    	  FROM Art
  	      JOIN #CompraD ON Art.Articulo = #CompraD.Articulo
  	      JOIN EmidaCarrierCfg ON #CompraD.URL = EmidaCarrierCfg.URL AND #CompraD.CarrierId = EmidaCarrierCfg.CarrierId
	     WHERE Art.Articulo = @Articulo
    END
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
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, NULL  
  
  RETURN
END
GO