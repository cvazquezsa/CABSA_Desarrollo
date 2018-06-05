SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO 
/************** spAgregarProveedorExpress *************/
if exists (select * from sysobjects where id = object_id('dbo.spAgregarProveedorExpress') and type = 'P') drop procedure dbo.spAgregarProveedorExpress
GO
CREATE PROCEDURE spAgregarProveedorExpress
		   @Clave		char(20),
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
		   @BeneficiarioNombre	varchar(100),
		   @eMail		varchar(50),
		   @Categoria		varchar(50),
		   @Familia		varchar(50),
		   @Agente		char(10),
                   @Tipo		char(20),
		   @Moneda		char(10),
                   @Digitos		int,
		   @Condicion		varchar(50),
		   @CPID		int	    = NULL,
		   @Empresa		char(5)     = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok			 	int,
    @OkRef		 	varchar(255),
    @Mensaje		 	varchar(255),
    @NombreCorto	 	char(20),
    @Pos		 	int,
    @Consecutivo	 	int,
    @Prefijo		 	char(10),
    @ConsecutivoGral	 	bit,
    @UsarPrefijoSucursal 	bit,
    @Cont			int

  SELECT @Clave 	= UPPER(RTRIM(NULLIF(@Clave,'0'))),
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
         @BeneficiarioNombre	= RTRIM(NULLIF(@BeneficiarioNombre,'0')), 
         @eMail		= RTRIM(NULLIF(@eMail,'0')), 
         @Categoria	= RTRIM(NULLIF(@Categoria,'0')), 
         @Familia	= RTRIM(NULLIF(@Familia,'')), 
         @Agente	= RTRIM(NULLIF(@Agente,'0')), 
         @Tipo		= RTRIM(NULLIF(@Tipo,'0')), 
	 @Condicion 	= RTRIM(NULLIF(@Condicion,'0')),
         @CPID	        = NULLIF(@CPID, 0),
	 @Empresa 	= RTRIM(NULLIF(@Empresa,'0'))

  SELECT @Prefijo = ''
  SELECT @Condicion = ProvExpressCondicion,
         @ConsecutivoGral = SugerirConsecCentralizado 
    FROM EmpresaGral 
   WHERE Empresa = @Empresa

  IF @CPID IS NOT NULL
    SELECT @CodigoPostal = CodigoPostal, @Colonia = Colonia, @Delegacion = Delegacion, @Ruta = Ruta,
           @Estado = Estado, @Pais = 'Mexico'
      FROM CodigoPostal
     WHERE ID = @CPID

  IF @Tipo IS NULL SELECT @Tipo = 'Acreedor'
  SELECT @Prefijo = MAX(Proveedor) FROM Prov

  IF @Clave IN ('(CONSECUTIVO)', NULL)
  BEGIN
    IF @ConsecutivoGral = 1 
      EXEC spConsecutivo 'Proveedores', 0, @Clave OUTPUT
    ELSE
    BEGIN
      SELECT @Clave = MAX(Proveedor) FROM Prov
      IF @Clave IS NULL
      BEGIN 
        SELECT @Consecutivo = 1
        EXEC spLlenarCeros @Consecutivo, @Digitos, @Prefijo OUTPUT
      END
      ELSE
      BEGIN
        SELECT @Cont = COUNT(*) FROM Prov WHERE Proveedor LIKE @Clave+'%'
        SELECT @Consecutivo = @Cont + 1, @Prefijo = @Clave
        EXEC spLlenarCeros @Consecutivo, 1, @Prefijo OUTPUT
      END
      SELECT @Clave = LTRIM(@Clave)+ LTRIM(@Prefijo)
    END
  END
	IF @Clave='(RFC)' --CABSA
		SELECT @Clave = LEFT(@RFC,10)
	--SELECT @Clave


  SELECT @Clave = NULLIF(RTRIM(@Clave), '')
  IF @Clave IS NULL RETURN

  BEGIN TRANSACTION
    IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = @Clave)
    BEGIN
      IF EXISTS(SELECT * FROM Prov WHERE UPPER(Nombre) = UPPER(@Nombre) AND UPPER(RFC)=UPPER(@RFC))
        SELECT @Clave = Proveedor FROM Prov WHERE UPPER(Nombre) = UPPER(@Nombre) AND UPPER(RFC)=UPPER(@RFC)
      ELSE BEGIN
        IF @Categoria IS NOT NULL AND NOT EXISTS(SELECT * FROM ProvCat WHERE UPPER(Categoria) = UPPER(@Categoria)) SELECT @Ok = 10060, @OkRef = @Categoria  	ELSE
        IF @Familia   IS NOT NULL AND NOT EXISTS(SELECT * FROM ProvFam WHERE UPPER(Familia)   = UPPER(@Familia))   SELECT @Ok = 10060, @OkRef = @Familia	

        IF NOT EXISTS(SELECT * FROM BeneficiarioNombre WHERE Beneficiario = @BeneficiarioNombre)
          INSERT BeneficiarioNombre(Beneficiario, ImporteOmision, ConceptoOmision)
                             VALUES(@BeneficiarioNombre, NULL, NULL)

        SELECT @NombreCorto = LEFT(@Nombre, 20)
        INSERT Prov (Proveedor,        Tipo,  Nombre,  NombreCorto,  Direccion,  Delegacion,  Colonia,  Estado,  Pais,  Ruta,  Poblacion,  CodigoPostal,  RFC,  Telefonos,  Contacto1, eMail1, Categoria,  Familia,  DefMoneda, Condicion,  Agente,  Estatus, Alta,      BeneficiarioNombre)
             VALUES (LEFT(@Clave, 10), @Tipo, @Nombre, @NombreCorto, @Direccion, @Delegacion, @Colonia, @Estado, @Pais, @Ruta, @Poblacion, @CodigoPostal, @RFC, @Telefonos, @Contacto, @eMail, @Categoria, @Familia, @Moneda,   @Condicion, @Agente, 'ALTA',  GETDATE(), @BeneficiarioNombre)

        IF NOT EXISTS(SELECT * FROM BeneficiarioNombre WHERE Beneficiario = @BeneficiarioNombre)
          INSERT BeneficiarioNombre(Beneficiario, ImporteOmision, ConceptoOmision)
                             VALUES(@BeneficiarioNombre, NULL, NULL)

      END
    END
  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  IF @Ok IS NOT NULL
  BEGIN
    SELECT @Mensaje = '"'+LTRIM(RTRIM(ISNULL(@OkRef, '')))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    RAISERROR (@Mensaje,16,-1) 
  END ELSE
    SELECT /*"Clave" = */ @Clave
  RETURN 
END
GO