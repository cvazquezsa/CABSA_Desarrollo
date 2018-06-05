SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/**************** spAgregarProveedorAPP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAgregarProveedorAPP') and type = 'P') drop procedure dbo.spAgregarProveedorAPP
GO             
CREATE PROCEDURE spAgregarProveedorAPP
		   @Clave		varchar(20),
           @Nombre	     	varchar(100),
		   @Direccion 		varchar(100),
		   @Delegacion		varchar(50),
		   @Colonia 		varchar(30),
           @Ruta		varchar(50),
		   @Poblacion 		varchar(30),
		   @Estado 		varchar(30),
		   @Pais 		varchar(30),
		   @CodigoPostal 	varchar(15),
		   @RFC 		varchar(15),
		   @Telefonos		varchar(100),
		   @Contacto		varchar(50),
		   @eMail		varchar(50),
		   @Categoria		varchar(50),
		   @Familia		varchar(50),
		   @Agente		varchar(10),
           @Tipo		varchar(20),
		   @Moneda		varchar(10),
		   @Condicion		varchar(50),
		   @CPID		int	    = NULL,
		   @Empresa		varchar(5)     = NULL, 
		   @Proveedor   varchar(10) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok			 int,
    @OkRef		 varchar(255),
    @Mensaje		 varchar(255),
    @NombreCorto	 char(20),
    @Pos		 int,
    @Consecutivo	 int,
    @PrefijoSucursal	 char(5),
    @ConsecutivoGral	 bit,
    @UsarPrefijoSucursal bit,
    @OkRegistro bit, 
	@Prefijo		varchar(5),
    @PrefijoLike		char(10),
    @Digitos		int

    SELECT 
		@Clave 	= UPPER(RTRIM(NULLIF(@Clave,'0'))),
		@Nombre 	= RTRIM(NULLIF(@Nombre,'0')), 
		@Direccion 	= RTRIM(NULLIF(@Direccion,'0')), 
		@Delegacion 	= RTRIM(NULLIF(@Delegacion,'0')), 
		@Colonia 	= RTRIM(NULLIF(@Colonia,'0')), 
		@Ruta	        = RTRIM(NULLIF(@Ruta, '0')),
		@Poblacion 	= RTRIM(NULLIF(@Poblacion,'0')), 
		@Estado 	= RTRIM(NULLIF(@Estado,'0')), 
		@Pais 		= RTRIM(NULLIF(@Pais,'0')), 
		@CodigoPostal 	= RTRIM(NULLIF(@CodigoPostal,'0')), 
		@RFC 		= RTRIM(NULLIF(@RFC,'0')), 
		@Telefonos 	= RTRIM(NULLIF(@Telefonos,'0')), 
		@Contacto	= RTRIM(NULLIF(@Contacto,'0')), 
		@eMail		= RTRIM(NULLIF(@eMail,'0')), 
		@Categoria	= RTRIM(NULLIF(@Categoria,'0')), 
		@Familia	= RTRIM(NULLIF(@Familia,'0')), 
		@Agente	= RTRIM(NULLIF(@Agente,'0')), 
		@Tipo		= RTRIM(NULLIF(@Tipo,'0')), 
		@Prefijo 	= RTRIM(NULLIF(@Prefijo,'0')), 
		@PrefijoLike 	= RTRIM(NULLIF(@PrefijoLike,'0')),
		@Condicion 	= RTRIM(NULLIF(@Condicion,'0')),
		@CPID	        = NULLIF(@CPID, 0),
		@Empresa 	= RTRIM(NULLIF(@Empresa,'0'))

  SELECT @PrefijoSucursal = NULL, @Ok = NULL, @OkRef = NULL, @UsarPrefijoSucursal = 0

  SELECT @UsarPrefijoSucursal = ProvExpressUsarPrefijoSucursal,
         @Condicion = ProvExpressCondicion,
         @ConsecutivoGral = SugerirConsecCentralizado, 		 
		 @Prefijo = ProvExpressPrefijo, 
		 @Digitos = ProvExpressDigitos 
    FROM EmpresaGral 
   WHERE Empresa = @Empresa


   SELECT @PrefijoLike = RTRIM(LTRIM(ISNULL(@Prefijo,' ')))+'[0-9]%'

      

  IF @UsarPrefijoSucursal = 1
    SELECT @PrefijoSucursal = NULLIF(RTRIM(Prefijo), '') FROM Sucursal s, Version v WHERE s.Sucursal = v.Sucursal

  IF @CPID IS NOT NULL
    SELECT @CodigoPostal = CodigoPostal, @Colonia = Colonia, @Delegacion = Delegacion, @Ruta = Ruta,
           @Estado = Estado, @Pais = 'Mexico'
      FROM CodigoPostal
     WHERE ID = @CPID

  IF @PrefijoSucursal IS NOT NULL SELECT @Prefijo = @PrefijoSucursal, @PrefijoLike = RTRIM(@PrefijoSucursal)+'[0-9]%'

  IF @Tipo IS NULL SELECT @Tipo = 'Acreedor'
  IF @Clave = '(RFC)'
  BEGIN
    IF NOT EXISTS(SELECT * FROM Prov WHERE UPPER(RTRIM(LTRIM(RFC)))=UPPER(RTRIM(LTRIM(@RFC))))
      SELECT @Clave = RTRIM(LTRIM(@RFC))
    ELSE 
      SELECT @Clave = '(CONSECUTIVO)'
  END
  IF @Clave = '(TELEFONO)'
  BEGIN
    SELECT @Clave = SUBSTRING(@Telefonos, 1, 10)
    SELECT @Pos = PATINDEX('% %', @Clave)
    IF @Pos > 1 SELECT @Clave = SUBSTRING(RTRIM(LTRIM(@Clave)), 1, @Pos-1)
  END

  IF @Clave IN ('(CONSECUTIVO)', NULL)
  BEGIN
    IF @ConsecutivoGral = 1 
      EXEC spConsecutivo 'Proveedores', 0, @Clave OUTPUT
    ELSE BEGIN
      SELECT @Clave = MAX(RTRIM(LTRIM(Proveedor))) FROM Prov WHERE Proveedor LIKE RTRIM(@PrefijoLike)
      IF @Clave IS NULL 
        SELECT @Consecutivo = 1
      ELSE SELECT @Consecutivo = Convert(int, STUFF(@Clave, 1, LEN(RTRIM(@Prefijo)), NULL)) + 1
      EXEC spLlenarCeros @Consecutivo, @Digitos, @Clave OUTPUT
      SELECT @Clave = RTRIM(@Prefijo) + RTRIM(LTRIM(@Clave))
    END
  END

  SELECT @Clave = NULLIF(RTRIM(LTRIM(@Clave)), '')


  BEGIN TRANSACTION
    IF NOT EXISTS(SELECT * FROM Prov WHERE RTRIM(LTRIM(Proveedor)) = RTRIM(LTRIM(@Clave)))
    BEGIN
      IF EXISTS(SELECT * FROM Prov WHERE UPPER(Nombre) = UPPER(@Nombre) AND UPPER(RTRIM(LTRIM(RFC)))=UPPER(RTRIM(LTRIM(@RFC))))
      BEGIN
        SELECT @Clave = Proveedor FROM Prov WHERE UPPER(Nombre) = UPPER(@Nombre) AND UPPER(RTRIM(LTRIM(RFC)))=UPPER(RTRIM(LTRIM(@RFC)))
        SELECT @Ok = 1
      END
      ELSE BEGIN

        SELECT @NombreCorto = LEFT(@Nombre, 20)
        INSERT Prov (Proveedor,        Tipo,  Nombre,  NombreCorto,  Direccion,  Delegacion,  Colonia,  Estado,  Pais,  Ruta,  Poblacion,  CodigoPostal,  RFC,  Telefonos,  Contacto1, eMail1, Categoria,  Familia,  DefMoneda, Condicion,  Agente,  Estatus, Alta)
             VALUES (LEFT(RTRIM(LTRIM(@Clave)), 10), @Tipo, @Nombre, @NombreCorto, @Direccion, @Delegacion, @Colonia, @Estado, @Pais, @Ruta, @Poblacion, @CodigoPostal, RTRIM(LTRIM(@RFC)), @Telefonos, @Contacto, @eMail, @Categoria, @Familia, @Moneda,   @Condicion, @Agente, 'ALTA',  GETDATE())


      END
    END


  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  IF @Ok = 10060
  BEGIN
    SELECT @Mensaje = '"'+LTRIM(RTRIM(ISNULL(@OkRef, '')))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    RAISERROR (@Mensaje,16,-1) 
  END 
  ELSE IF @Ok IS NULL AND EXISTS (SELECT * FROM Prov WHERE RTRIM(LTRIM(Proveedor)) = RTRIM(LTRIM(@Clave)) AND RTRIM(LTRIM(RFC)) = RTRIM(LTRIM(@RFC)))
  BEGIN
	SELECT @Proveedor = RTRIM(LTRIM(@Clave))
	RETURN
  END
  ELSE IF @Ok IS NOT NULL
  BEGIN
	SELECT @Proveedor = RTRIM(LTRIM(@Clave))
    RETURN 
  END
  ELSE
    SELECT @Proveedor = RTRIM(LTRIM(@Clave))
  RETURN
END
GO

/**************** spGASAnticipoPendienteAPP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGASAnticipoPendienteAPP') and type = 'P') drop procedure dbo.spGASAnticipoPendienteAPP
GO
CREATE PROCEDURE spGASAnticipoPendienteAPP
			@Empresa   char(5), 
			@Acreedor  varchar(10),
			@Mov       varchar(20) OUTPUT,
			@MovID     varchar(20) OUTPUT, 
			@Clase     varchar(50) OUTPUT,
			@SubClase  varchar(50) OUTPUT, 
			@Observaciones varchar(100) OUTPUT 
 --//WITH ENCRYPTION  
 AS BEGIN  
   
   SELECT @Mov = NULL,  @MovID = NULL,  @Clase = NULL,  @SubClase  = NULL,  @Observaciones = NULL
 
   DECLARE crAnticipo CURSOR
       FOR SELECT  Gasto.Mov, Gasto.MovID, Gasto.Clase, Gasto.SubClase, Gasto.Observaciones
               FROM Gasto
 			  JOIN MovTipo ON Gasto.Mov = MovTipo.Mov AND  MovTipo.Modulo ='GAS' 
           WHERE
                  Gasto.Empresa = @Empresa
              AND Gasto.Acreedor = @Acreedor
              AND Gasto.Estatus   = 'PENDIENTE'
             AND  MovTipo.Clave IN ('GAS.A')
           ORDER BY Gasto.ID, GAsto.FechaEmision  DESC
   OPEN crAnticipo
   FETCH NEXT FROM crAnticipo INTO @Mov, @MovID, @Clase, @SubClase, @Observaciones
   CLOSE crAnticipo
   DEALLOCATE crAnticipo
 
   RETURN
 END
GO

/**************** spConceptoAPP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConceptoAPP') and type = 'P') drop procedure dbo.spConceptoAPP
GO
CREATE PROCEDURE spConceptoAPP 
                      @Modulo   char(5),
                      @Concepto varchar(50) OUTPUT 
--//WITH ENCRYPTION
 AS BEGIN 
  SELECT @Concepto = ISNULL(ConceptoAPP.Concepto, @Concepto) 
    FROM ConceptoAPP  
    WHERE ConceptoAPP.Modulo       = @Modulo 
      AND ConceptoAPP.ConceptoAPP  = @Concepto 
 END 
 RETURN
GO

/**************** spContSatAsociarRegistroAPP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContSatAsociarRegistroAPP') and type = 'P') drop procedure dbo.spContSatAsociarRegistroAPP
GO
CREATE PROCEDURE spContSatAsociarRegistroAPP
 	@MacAddress		varchar(50),
 	@ID      		int,
 	@Empresa  		varchar(5),
 	@Modulo  		varchar(5),
 	@Mov      		varchar(20),
 	@MovID  		varchar(20),
 	@Usuario        varchar(10),
 	@Estatus        varchar(15),
 	@Moneda         varchar(10),
 	@TipoCambio     float,
 	@Ok		        int = NULL OUTPUT,
 	@OkRef			varchar(255) = NULL OUTPUT
 --//WITH ENCRYPTION
 AS 
 BEGIN
	DECLARE
		@Ruta           varchar(500),
		@UUID           varchar(50),
		@RFCEmisor      varchar(50),
		@RFCReceptor    varchar(50),
		@Documento      varchar(max),
		@FechaTimbrado  datetime,
		@Monto          float

	BEGIN TRAN Manual
 
	IF (@Modulo IN('VTAS','CXC')) AND (SELECT COUNT(*) FROM ContSATCFDTempAPP WHERE MacAddress = @MacAddress GROUP BY UUID HAVING COUNT(*) > 1) > 1
	BEGIN
		SELECT @Ok = Mensaje, @OkRef = 'Solo puedes asociar un Folio Fiscal a este modulo.'
		FROM MensajeLista WHERE Mensaje = 30013
		ROLLBACK TRAN Manual
	
		SELECT @OkRef
		RETURN
	END
 
	IF ( SELECT COUNT(*) FROM ContSATCFDTempAPP WHERE MacAddress = @MacAddress GROUP BY UUID HAVING COUNT(*) > 1) > 1
	BEGIN
		SELECT @Ok = Mensaje, @OkRef = 'Estas tratando de asociado dos Folio Fiscal iguales al mismo movimiento.'
		FROM MensajeLista WHERE Mensaje = 30013
		ROLLBACK TRAN Manual

		SELECT @OkRef
		RETURN
	END

	SELECT @Moneda = ISNULL(NULLIF(@Moneda,''),'MXN'), @TipoCambio = ISNULL(@TipoCambio,1.0)
	
	DECLARE crXML CURSOR LOCAL FAST_FORWARD FOR
		SELECT UUID, RFCEmisor, RFCReceptor, Fecha, Importe, Ruta, Documento
		FROM ContSATCFDTempAPP
		WHERE MacAddress = @MacAddress
	OPEN crXML
	FETCH NEXT FROM crXML INTO @UUID, @RFCEmisor, @RFCReceptor, @FechaTimbrado, @Monto, @Ruta, @Documento
	WHILE @@FETCH_STATUS <> -1
	BEGIN
		IF @FechaTimbrado IS NULL
			SELECT @FechaTimbrado = GETDATE()
		
		IF @Modulo IN('VTAS','CXC')
		BEGIN
			IF NOT EXISTS(SELECT * FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID)
				INSERT CFD(Modulo,  ModuloID, Fecha,           Ejercicio,                     Periodo,                        Empresa,  RFC,          Documento, UUID , FechaTimbrado, Timbrado, Importe)
				SELECT     @Modulo, @ID,      @FechaTimbrado,  DATEPART(year,@FechaTimbrado), DATEPART(MONTH,@FechaTimbrado), @Empresa, @RFCReceptor, @Documento, @UUID, @FechaTimbrado, 1, @Monto
		END
		ELSE
		BEGIN
			IF EXISTS(SELECT * FROM CFDEgreso WHERE UUID = @UUID AND Modulo = @Modulo AND ModuloID = @ID)
			BEGIN
				SELECT @Ok = Mensaje, @OkRef = 'El Folio Fiscal ya esta asociado a un movimiento.'
				FROM MensajeLista WHERE Mensaje = 30013
			END

			INSERT CFDEgreso (Modulo,  ModuloID, Documento,  RFCEmisor,  RFCReceptor,  UUID,  FechaTimbrado,  Monto,  Moneda,  TipoCambio, Empresa)
			SELECT            @Modulo, @ID,      @Documento, @RFCEmisor, @RFCReceptor, @UUID, @FechaTimbrado, @Monto, @Moneda, @TipoCambio, @Empresa
			EXCEPT
			SELECT Modulo,  ModuloID, Documento,  RFCEmisor,  RFCReceptor,  UUID,  FechaTimbrado,  Monto,  Moneda,  TipoCambio,Empresa
			FROM CFDEgreso
		END
	
	FETCH NEXT FROM crXML INTO @UUID, @RFCEmisor, @RFCReceptor, @FechaTimbrado, @Monto, @Ruta, @Documento
	END
	CLOSE crXML
	DEALLOCATE crXML
 
	IF(@OkRef IS NULL)
	BEGIN
		COMMIT TRAN Manual
		IF @Estatus NOT IN('SINAFECTAR','BORRADOR','CONFIRMAR')
		EXEC xpContSAT @Empresa, @Modulo, @ID, NULL
	END
	ELSE
	BEGIN
		ROLLBACK TRAN Manual
		SELECT @OkRef
	END
 
	RETURN
END
GO

/**************** spContSatAsociarAPP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContSatAsociarAPP') and type = 'P') drop procedure dbo.spContSatAsociarAPP
GO
CREATE PROCEDURE spContSatAsociarAPP
	@MacAddress   varchar(50),                              
	@Modulo       char(20), 
	@ModuloID     int, 
	@Empresa      char(5), 
	@FechaEmision datetime, 
	@Mov          varchar(10), 
	@RFCReceptor  varchar(20),
	@RFCEmisor    varchar(20),
	@Importe      money, 
	@UUID         varchar(50), 
	@Moneda       varchar(10), 
	@TipoCambio   float, 
	@Usuario      varchar(10), 
	@Ruta		  varchar(500),
	@Documento	  varchar(MAX),
	@Ok           int          OUTPUT,  
	@OkRef        varchar(255) OUTPUT 							         
 --//WITH ENCRYPTION
AS
BEGIN 
    DELETE ContSATCFDTempAPP WHERE MacAddress = @MacAddress
 	INSERT INTO ContSATCFDTempAPP (MacAddress, Modulo, ModuloID, Empresa, Fecha, RFCReceptor, RFCEmisor, Importe, UUID, Ruta, Documento)  
 	VALUES (@MacAddress,  @Modulo, @ModuloID, @Empresa, @FechaEmision, @RFCReceptor, @RFCEmisor, @Importe, @UUID, @Ruta, @Documento)  

   	IF EXISTS (SELECT * FROM ContSATCFDTempAPP WHERE MacAddress = @MacAddress AND Modulo = @Modulo AND ModuloID = @ModuloID) 
 	BEGIN
 		EXEC spContSatAsociarRegistroAPP  @MacAddress, @ModuloID , @Empresa, @Modulo, @Mov, NULL, @Usuario, 'SINAFECTAR',@Moneda, @TipoCambio, @Ok OUTPUT,  @OkRef OUTPUT
 	END 
RETURN 
END
GO 


/**************** spGastoAppCE ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoAppCE') and type = 'P') drop procedure dbo.spGastoAppCE
GO
CREATE PROCEDURE spGastoAppCE
	@MacAddress varchar(50), 
	@OkRef		varchar(255) OUTPUT
 --//WITH ENCRYPTION
 AS 
BEGIN 
	DECLARE
	@Empresa			char(5),
	@Sucursal			int,
	@Usuario			varchar(10),
	@Proveedor			varchar(10), 
	@RenglonID			int,
	@Modulo				char(5), 
	@FechaEmision		datetime, 
	@Folio				varchar(20),
	@Serie				varchar(20),
	@Moneda				varchar(10), 
	@TipoCambio			float, 
	@RFC 				varchar(20), 
	@RFCReceptor		varchar(20),
	@Nombre				varchar(100), 
	@Direccion			varchar(100), 
	@DireccionNum		varchar(20), 
	@Colonia			varchar(100), 
	@Poblacion			varchar(100), 
	@Delegacion			varchar(100), 
	@Estado 			varchar(30), 
	@Pais				varchar(30), 
	@CodigoPostal		varchar(15), 
	@Concepto			varchar(50),
	@ConceptoAPP		varchar(50),  
	@Referencia			varchar(50), 
	@Importe			money, 
	@Impuestos			money, 
	@Retencion			money, 
	@Retencion2			money, 
	@Retencion3			money, 
	@CentroCostos		varchar(20), 
	@IEPS				money, 
	@UUID 				varchar(50),
	@Documento			varchar(max), 
	@Mov				varchar(20), 
	@FechaTrabajo		datetime,
	@ID					int, 
	@Renglon			int, 
	@Impuesto1			float, 
	@AcreedorRef		varchar(10), 
	@ContRelacionarComp bit,
	@Ok			 		int,
	@AnticipoMov		varchar(20), 
	@AnticipoMovID		varchar(20), 
	@Clase				varchar(50),
	@SubClase			varchar(50), 
	@Observaciones		varchar(100), 
	@AltaAcreedor		bit
 
	SELECT 
		@Empresa      = Empresa, 
		@Sucursal     = Sucursal, 
		@Usuario      = Usuario, 
		@Proveedor    = Proveedor, 
		@CentroCostos = CentroCostos,
		@AltaAcreedor = AltaAcreedor
	FROM MacAddressAPP 
	WHERE MacAddress= @MacAddress

	IF		EXISTS(SELECT * FROM MacAddressAPP WHERE MacAddressAPP.MacAddress= @MacAddress AND MacAddressAPP.Activa = 0)  SELECT @Ok = 10060, @OkRef = 'Cuenta Inactiva, Comuniquese con el administrador del sistema'         ELSE
	IF NOT	EXISTS(SELECT * FROM MacAddressAPP WHERE MacAddressAPP.MacAddress= @MacAddress)                               SELECT @Ok = 10060, @OkRef = 'No Existe su Cuenta, Comuniquese con el administrador del sistema'     ELSE 
	IF NOT	EXISTS(SELECT * FROM MovAPP        WHERE MovAPP.MacAddress= @MacAddress)                                      SELECT @Ok = 10060, @OkRef = 'No hay Nada que afectar' 

	SELECT @RFCReceptor = Empresa.RFC FROM Empresa WHERE Empresa = @Empresa 
	SELECT @Mov = GastoComprobante FROM EmpresaCfgMov  WHERE EmpresaCfgMov.Empresa = @Empresa
	SELECT @Moneda = ContMoneda, @TipoCambio = Mon.TipoCambio  FROM EmpresaCfg JOIN Mon ON EmpresaCfg.ContMoneda = Mon.Moneda WHERE EmpresaCfg.Empresa = @Empresa
	SELECT @FechaTrabajo = dbo.fnFechaSinHora(GETDATE()), @Renglon = 0.00---, @OKRef = 'Ok'
	SELECT @ContRelacionarComp = ContRelacionarComp FROM MovTipo WHERE Mov = @Mov AND Modulo = 'GAS' 

	EXEC spGASAnticipoPendienteAPP @Empresa, @Proveedor, @AnticipoMov OUTPUT, @AnticipoMovID  OUTPUT, @Clase OUTPUT, @SubClase OUTPUT, @Observaciones OUTPUT
 
	BEGIN TRANSACTION
		IF @Ok IS NULL 
		BEGIN 
			INSERT INTO Gasto (Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Acreedor, Sucursal, OrigenTipo, MovAplica, MovAplicaID, Clase, Subclase, Observaciones)
			VALUES (@Empresa, @Mov, @FechaTrabajo, @Moneda, @TipoCambio, @Usuario, 'CONFIRMAR', @Proveedor, @Sucursal, 'APP', @AnticipoMov, @AnticipoMovID, @Clase, @SubClase, @Observaciones)
 			SELECT @ID = SCOPE_IDENTITY()

			DECLARE crGastoD CURSOR FOR	   
 			SELECT 
 				MovAPP.ID, 
 				MovAPP.Modulo, 
 				MovAPP.FechaEmision, 
 				RTRIM(LTRIM(REPLACE(MovAPP.RFCReceptor,'|',''))), 
 				RTRIM(LTRIM(REPLACE(MovAPP.Folio,'|',''))), 
 				RTRIM(LTRIM(REPLACE(MovAPP.Serie,'|',''))), 
 				RTRIM(LTRIM(REPLACE(MovAPP.RFC,'|',''))), 
 				UPPER(RTRIM(LTRIM(REPLACE(MovAPP.Nombre,'|','')))), 
 				UPPER(RTRIM(LTRIM(REPLACE(MovAPP.Direccion,'|','')))), 
 				UPPER(RTRIM(LTRIM(REPLACE(MovAPP.DireccionNum,'|','')))), 
 				UPPER(RTRIM(LTRIM(REPLACE(MovAPP.Colonia,'|','')))),  
 				UPPER(RTRIM(LTRIM(REPLACE(MovAPP.Poblacion,'|','')))), 
 				UPPER(RTRIM(LTRIM(REPLACE(MovAPP.Delegacion,'|','')))), 
 				UPPER(RTRIM(LTRIM(REPLACE(MovAPP.Estado,'|','')))), 
 				RTRIM(LTRIM(REPLACE(MovAPP.Pais,'|',''))), 
 				UPPER(RTRIM(LTRIM(REPLACE(MovAPP.CodigoPostal,'|','')))), 
 				UPPER(RTRIM(LTRIM(REPLACE(MovAPP.Concepto,'|','')))),
 				RTRIM(LTRIM(MovAPP.Importe)), 
 				RTRIM(LTRIM(MovAPP.Impuesto)), 
 				RTRIM(LTRIM(MovAPP.Retencion)), 
 				RTRIM(LTRIM(MovAPP.Retencion2)), 
 				RTRIM(LTRIM(MovAPP.Retencion3)), 
 				RTRIM(LTRIM(MovAPP.UUID)),
				MovAPP.Documento
 			  FROM MovAPP 
 			 WHERE MovAPP.MacAddress = @MacAddress
 			 ORDER BY MovAPP.ID
    
			OPEN crGastoD    
			FETCH NEXT FROM crGastoD INTO  @RenglonID, @Modulo, @FechaEmision, @RFCReceptor, @Folio, @Serie, @RFC, @Nombre, @Direccion, @DireccionNum, @Colonia, @Poblacion, @Delegacion, @Estado, @Pais, 
 										   @CodigoPostal, @ConceptoAPP, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, @UUID, @Documento 
			WHILE @@FETCH_STATUS <> -1    
			BEGIN    
			IF @@FETCH_STATUS <> -2     
			BEGIN    
 				SELECT @Renglon = @Renglon + 2048, @AcreedorRef = NULL, @Referencia =  RTRIM(LTRIM(ISNULL(REPLACE(@Serie,'.', ''),' ')))+' '+RTRIM(LTRIM(ISNULL(@Folio,' ')))
 				SELECT @Impuesto1 = dbo.fnMenor(ROUND(dbo.fnPorcentajeImporte(@Importe, @Impuestos),0.00), 16)
 				IF @Impuesto1 = 0.00 SELECT @Impuesto1 = NULL 
				SELECT @RFCReceptor = REPLACE(@RFCReceptor, '-','')
 
				IF NOT EXISTS (SELECT * FROM Empresa WHERE Empresa = @Empresa AND RTRIM(LTRIM(RFC)) = @RFCReceptor) SELECT @Ok = 10060, @OkRef = 'Este Documento no es de esta empresa, RFC: '+@RFC+' Concepto:'+@ConceptoAPP ELSE
				IF EXISTS (SELECT * FROM MovAPP WHERE MovAPP.MacAddress = @MacAddress AND ID <> @RenglonID AND RTRIM(LTRIM(MovAPP.UUID)) = @UUID)  SELECT @Ok = 10060, @OkRef = 'xml Duplicados'
 
				SELECT @Concepto = @ConceptoAPP
				SELECT @AcreedorRef = Proveedor FROM Prov WHERE RTRIM(LTRIM(RFC)) = @RFC
				EXEC spConceptoAPP @Modulo, @Concepto OUTPUT 
 
 				IF @Ok IS NULL 
 				BEGIN
 					IF  @AcreedorRef IS NULL AND NULLIF(RTRIM( @RFC), '') IS NOT NULL AND NULLIF(RTRIM(@Nombre), '') IS NOT NULL AND @AltaAcreedor = 1 
 					BEGIN
 						EXEC spAgregarProveedorAPP '(CONSECUTIVO)', @Nombre, @Direccion, @Poblacion, @Colonia, NULL, @Delegacion, @Estado, @Pais, @CodigoPostal, @RFC, NULL, NULL, NULL, NULL, NULL, NULL, 'Acreedor',  'Pesos', NULL, NULL, @Empresa, @AcreedorRef OUTPUT
 					END 
 
 					INSERT INTO GastoD (ID, Renglon, Concepto, Fecha, Cantidad, Precio, Importe, Impuestos, Retencion, Retencion2, Retencion3, Impuesto1,  Referencia, ContUso, AcreedorRef, DescripcionExtra)  
 					VALUES (@ID, @Renglon, @Concepto, @FechaEmision, 1, @Importe, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, @Impuesto1, @Referencia, @CentroCostos, @AcreedorRef, @ConceptoAPP) 
 
 					IF  NULLIF(RTRIM( @RFC), '') IS NOT NULL AND @ContRelacionarComp = 1 AND NULLIF(RTRIM(@UUID), '') IS NOT NULL
 					BEGIN 
 						EXEC spContSatAsociarAPP  @MacAddress,  @Modulo, @ID, @Empresa, @FechaEmision, @Mov, @RFCReceptor, @RFC, @Importe, @UUID, 
 												  @Moneda, @TipoCambio, @Usuario, NULL, @Documento, @Ok OUTPUT, @OkRef OUTPUT 
 					END
 
 					IF @Ok IS NULL DELETE MovAPP WHERE MacAddress = @MacAddress AND ID = @RenglonID 
 				END      
			END    
		FETCH NEXT FROM crGastoD INTO  @RenglonID, @Modulo, @FechaEmision, @RFCReceptor, @Folio, @Serie, @RFC, @Nombre, @Direccion, @DireccionNum, @Colonia, @Poblacion, @Delegacion, @Estado, @Pais, 
 									   @CodigoPostal, @ConceptoAPP, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, @UUID, @Documento 
		END    
		CLOSE crGastoD    
		DEALLOCATE crGastoD 
	END 

	IF @Ok IS NULL  
		SELECT @OkRef = 'Ok' 
 
	IF @Ok IS NULL
		COMMIT TRANSACTION
	ELSE
		ROLLBACK TRANSACTION 
 
 	IF @OK IS NOT NULL 
	BEGIN 
 		DELETE MovAPP WHERE MacAddress = @MacAddress 
 	END 
 
	RETURN 
END
GO

/******************************************************************************************************************************************************/
													/*Intelisis Autorizaciones*/
/******************************************************************************************************************************************************/

/**************** spAutorizacionModuloAPP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAutorizacionModuloAPP') and type = 'P') drop procedure dbo.spAutorizacionModuloAPP
GO
CREATE PROCEDURE spAutorizacionModuloAPP
                         @Modulo   char(5),
                         @ID       int, 
                         @Usuario  varchar(10),
                         @OkRef    varchar(255) OUTPUT  
--//WITH ENCRYPTION          
 AS BEGIN 
 DECLARE 
    @FechaTrabajo        datetime, 
    @Situacion           varchar(50),  
    @Mov                 varchar(20), 
    @Estatus             varchar(20),
    @UsuarioSituacion    varchar(10), 
    @SituacionSiguiente  varchar(50), 
    @Ok                  int
    
    SELECT @FechaTrabajo = GETDATE(),  @OkRef = 'Proceso Concluido' 
 
 
 	IF @Modulo = 'VTAS'  SELECT @Mov = Venta.Mov,  @Estatus = Venta.Estatus,  @Situacion = Venta.Situacion,  @UsuarioSituacion = Venta.SituacionUsuario  FROM Venta  WHERE Venta.ID  = @ID ELSE 
 	IF @Modulo = 'COMS'  SELECT @Mov = Compra.Mov, @Estatus = Compra.Estatus, @Situacion = Compra.Situacion, @UsuarioSituacion = Compra.SituacionUsuario FROM Compra WHERE Compra.ID = @ID ELSE 
 	IF @Modulo = 'GAS'   SELECT @Mov = Gasto.Mov,  @Estatus = Gasto.Estatus,  @Situacion = Gasto.Situacion,  @UsuarioSituacion = Gasto.SituacionUsuario  FROM Gasto  WHERE Gasto.ID  = @ID 
    
 	SELECT  @SituacionSiguiente =  NULLIF(dbo.fnSituacionSiguiente(@Modulo, @Mov, @Estatus, @Situacion),'')
 
 	IF @SituacionSiguiente = @Situacion SELECT @Ok = 10060, @OkRef = 'Este Movimiento ya fue Autorizado por Otro Usuario'
 
   IF @Ok IS NULL AND NULLIF(RTRIM(@SituacionSiguiente), '') IS NOT NULL  
    BEGIN 	 
 	IF @Modulo = 'VTAS'  UPDATE Venta  SET Situacion = @SituacionSiguiente, SituacionFecha = @FechaTrabajo, SituacionUsuario = @Usuario WHERE  ID = @ID ELSE 
 	IF @Modulo = 'COMS'  UPDATE Compra SET Situacion = @SituacionSiguiente, SituacionFecha = @FechaTrabajo, SituacionUsuario = @Usuario WHERE  ID = @ID ELSE
 	IF @Modulo = 'GAS'   UPDATE Gasto  SET Situacion = @SituacionSiguiente, SituacionFecha = @FechaTrabajo, SituacionUsuario = @Usuario WHERE  ID = @ID 
    END 
 
  END 
  RETURN 
GO

/**************** fnSituacionUsuarioAPP ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSituacionUsuarioAPP') DROP FUNCTION fnSituacionUsuarioAPP
GO
CREATE FUNCTION fnSituacionUsuarioAPP
 	(
 	@Empresa				varchar(5),
 	@Modulo					varchar(5), 
 	@Mov					varchar(20),
 	@Estatus				varchar(15),
 	@Situacion				varchar(50),
 	@Usuario				varchar(10)
 	)
 RETURNS bit
 AS BEGIN                                                                        
 
 DECLARE 
  @SituacionSiguiente varchar(50), 
  @Permite   int   
 
 
  SELECT  @SituacionSiguiente =  NULLIF(dbo.fnSituacionSiguiente(@Modulo, @Mov, @Estatus, @Situacion),'') 
 
       IF @SituacionSiguiente IS NOT NULL
       BEGIN
         IF ISNULL(dbo.fnSituacionPermiteAvanzar(@Empresa, @Modulo, @Mov, @Estatus, @SituacionSiguiente, @Usuario),0) = 1 SELECT @Permite = 1 ELSE SELECT @Permite = 0
 		END 
 
 RETURN(@Permite)
 END
GO 

/**************** spAppValidarUsuario ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAppValidarUsuario') and type = 'P') drop procedure dbo.spAppValidarUsuario
GO
CREATE PROCEDURE spAppValidarUsuario 
 @Usuario varchar(10), 
 @Empresa char(5), 
 @Sucursal int, 
 @Contrasena varchar(100),
 @OkRef varchar(255) OUTPUT 
 --//WITH ENCRYPTION
 AS BEGIN 
 DECLARE 
 @Estatus varchar(20), 
 @AccesarOtrasSucursalesEnLinea bit, 
 @Ok int 
 
  
 SELECT @OkRef = 'Ok'
 SELECT @Estatus = Estatus, @AccesarOtrasSucursalesEnLinea = AccesarOtrasSucursalesEnLinea FROM Usuario WHERE Usuario.Usuario = @Usuario
 IF NOT EXISTS (SELECT Empresa FROM UsuarioD WHERE Usuario = @Usuario AND Empresa = @Empresa) SELECT @Ok = 10060, @OkRef = 'El Usuario No Tiene Acceso a Esta Empresa' 
 IF @AccesarOtrasSucursalesEnLinea = 0 AND @Ok IS NULL 
 BEGIN 
 IF NOT EXISTS (SELECT *FROM UsuarioSucursalAcceso WHERE Usuario = @Usuario AND Sucursal = @Sucursal) SELECT @Ok = 10060, @OkRef = 'El Usuario No Tiene Acceso a Esta Sucursal' 
 END 
 IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND Contrasena IN (@Contrasena,dbo.fnPassword(UPPER(RTRIM(@Contrasena))))) SELECT @Ok = 10060, @OkRef = 'Contraseña Incorrecta' 
 IF @Estatus <> 'ALTA' AND @Ok IS NULL
 BEGIN 
 IF @Estatus = 'BLOQUEADO' SELECT @Ok = 10060, @OkRef = 'Usuario Bloqueado' ELSE 
 IF @Estatus = 'BAJA' SELECT @Ok = 10060, @OkRef = 'Usuario Baja' 
 END   
  
 RETURN
 END 
GO 

/**************** spGastoAPP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoAPP') and type = 'P') drop procedure dbo.spGastoAPP
GO
CREATE PROCEDURE spGastoAPP
                      @Empresa char(5), 
  					@Usuario varchar(10)  
--//WITH ENCRYPTION 
  AS BEGIN 
  	SELECT               
  		  GastoT.ID, 
		  GastoT.Empresa, 
		  GastoT.Mov, 
		  GastoT.MovID, 
		  GastoT.FechaEmision, 
		  GastoT.Observaciones, 
  		  GastoT.Moneda, 
		  GastoT.TipoCambio, 
		  GastoT.Usuario, 
		  Usuario.Nombre AS NombreUs, 
  		  Usuario.eMail, 
		  GastoT.Estatus, 
		  GastoT.Situacion, 
		  GastoT.SituacionFecha, 
		  GastoT.SituacionUsuario, 
  		  GastoT.Acreedor,  
		  Prov.Nombre AS NombreProv, 
		  GastoT.Clase, 
  		  GastoT.SubClase, 
		  GastoT.Sucursal, 
		  Sucursal.Nombre AS NombreSuc,  
		  GastoT.Renglon, 
		  GastoT.Concepto, 
  		  GastoT.Referencia, 
		  GastoT.Cantidad, 
		  ROUND(GastoT.TotalLinea / GastoT.Cantidad,4) Precio, 
		  GastoT.TotalLinea AS ImporteLinea 
  	  FROM  
  		  GastoT 
  	   JOIN Prov     ON GastoT.Acreedor = Prov.Proveedor
  	   JOIN Sucursal ON GastoT.Sucursal = Sucursal.Sucursal
  	   JOIN Usuario  ON GastoT.Usuario  = Usuario.Usuario 
  	   JOIN MovTipo  ON GastoT.Mov = MovTipo.Mov AND MovTipo.Modulo = 'GAS'
  	 WHERE 
  		  MovTipo.Clave IN ('GAS.S') AND GastoT.Estatus = 'PENDIENTE'
  		  AND GastoT.Empresa = @Empresa
  		  AND NULLIF(RTRIM(GastoT.Situacion), '') IS NOT NULL
  		  AND dbo.fnSituacionUsuarioAPP(GastoT.Empresa, 'GAS', GastoT.Mov, GastoT.Estatus, GastoT.Situacion, @Usuario) = 1	  
  END 
  RETURN 
  GO 