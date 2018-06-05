SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
SET ANSI_DEFAULTS OFF
SET NOCOUNT ON
GO

IF NOT EXISTS (SELECT Mensaje FROM MensajeLista WHERE Mensaje = 71651) 
insert MensajeLista (Mensaje,Descripcion)      VALUES (71651,'Error al Cancelar el CFDI') 
GO
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIToken', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDICuenta', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIUsuario', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIPassword', 'varchar(100) NULL'
GO
/****** MensajeCFDI ******/
if not exists (select * from sysobjects where id = object_id('dbo.MensajeCFDI') and type = 'U') 
CREATE TABLE dbo.MensajeCFDI (
	Mensaje			int		NOT NULL,
	Descripcion		varchar(255)	NULL,
	Tipo			varchar(50)	NULL DEFAULT 'ERROR',

	CONSTRAINT priMensajeCFDI PRIMARY KEY  CLUSTERED (Mensaje)
)
GO

DELETE MensajeCFDI
GO
--SAT
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('301', 'El comprobante no cumple con el estándar XML o con la estructura XML')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('302', 'El sello del emisor no es válido.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('303', 'El CSD del emisor no corresponde al RFC que viene como emisor en el comprobante.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('304', 'El CSD del emisor ha sido revocado, utilizando la lista de LCO.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('305', 'La fecha de emisión no está dentro de la vigencia del CSD del emisor.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('306', 'La llave utilizada para sellar corresponde a un FIEL (no a un CSD).')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('307', 'Contiene un timbre previo.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('308', 'El CSD del emisor no ha sido firmado por un certificado de autoridad del SAT.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('401', 'La fecha de generación es mayor a 72 horas de la emisión del timbre.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('402', 'El RFC no existe conforme al régimen autorizado (Lista de validación de régimen) LCO.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('403', 'La fecha de emisión es anterior al 01 de Enero de 2011.')
--EDICOM
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('200', 'No se ha podido cambiar el password del usuario.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('201', 'No se ha podido cancelar los comprobantes.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('202', 'No se ha podido comprobar el UUID del comprobante.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('203', 'No se ha podido obtener la respuesta de la petición de generación del comprobante.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('204', 'No se ha podido obtener el comprobante de los UUIDs enviados.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('300', 'Error genérico de la aplicación.')
INSERT MensajeCFDI (Mensaje, Descripcion) VALUES ('404', 'Error de autentificación en el servicio.')
GO

/********************** spLeerProveedoresPac *****************************/
if exists (select * from sysobjects where id = object_id('dbo.spLeerProveedoresPac') and type = 'P') drop procedure dbo.spLeerProveedoresPac
GO
CREATE PROCEDURE spLeerProveedoresPac
		  @RutaArchivo		varchar(max),
		  @UsuarioPAC		varchar(50)=NULL  OUTPUT,
		  @PaswordPAC		varchar(50)=NULL OUTPUT,
		  @TokenPac			varchar(50)=NULL OUTPUT,
		  @Ok				int = NULL OUTPUT,  
		  @OkRef			varchar(255) = NULL OUTPUT  
--//WITH ENCRYPTION
 AS BEGIN	
 DECLARE 
		  @posIni int,
		  @pos int,
		  @SQL varchar(max),
		  @campo varchar(50)
 	   	
  IF exists(SELECT name FROM tempdb.dbo.sysobjects WHERE name like '#ProvPac%')
  DROP TABLE #ProvPac
  CREATE TABLE #ProvPac(Valor varchar(max))  
  
  SET @SQL = N'BULK INSERT #ProvPac
                FROM ''' + @RutaArchivo +'''
                WITH (CODEPAGE = ' + CONVERT(varchar, 1252) + ')'
                
  EXEC (@SQL) 
   
  IF NOT EXISTS(SELECT * FROM #ProvPac)  
  BEGIN  
    SELECT @OK = 71525  
    SELECT @OkRef = (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok)  
    SELECT @OkRef = @OkRef + ' ' + @RutaArchivo  
  END 
  
  ALTER TABLE #ProvPac ADD ID INT IDENTITY
    
  SELECT @posIni= ID FROM #ProvPac WHERE Valor like  '%KONESH]%'
  
  SELECT @campo= valor FROM #ProvPac WHERE ID= (@posIni+1)  
  SELECT @pos=CHARINDEX('USUARIO=', @campo)-LEN(@campo)
  SELECT @pos=LEN(@campo)-8
  SELECT @UsuarioPAC = right(@campo,@pos)
  
  SELECT @campo= Valor FROM #ProvPac WHERE ID= (@posIni+2)    
  SELECT @pos=CHARINDEX('CONTRASENA=', @campo)-LEN(@campo)
  SELECT @pos=LEN(@campo)-11
  SELECT @PaswordPAC=right(@campo,@pos)
  
  SELECT @campo= Valor FROM #ProvPac WHERE ID= (@posIni+3)  
  SELECT @pos=CHARINDEX('TOKEN=', @campo)-LEN(@campo)
  SELECT @pos=LEN(@campo)-6  
  SELECT @TokenPAC=right(@campo,@pos)
 
 END  
 GO

/*************** spIntelisisCFDICancelar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisCFDICancelar') and type = 'P') drop procedure dbo.spIntelisisCFDICancelar
GO
CREATE PROC spIntelisisCFDICancelar
            @Modulo					varchar(10),
            @ID						int,
            @Estatus				varchar(20), 
            @Empresa				varchar(10),
            @Sucursal				int,
            @RutaTimbrarCFD			varchar(255),
            @Fechatimbrado			varchar(20),
            @ServidorPAC			varchar(100),
            @UsuarioPAC				varchar(100),
            @PaswordPAC				varchar(100),
            @AccionCFDI				varchar(50),
            @RutaCer				varchar(200),
            @RutaKey				varchar(200),
            @passKey				varchar(100),
            @UUID					varchar(50),
            @RFC					varchar(20),
            @Documento				varchar(max),
            @ModoPruebas			bit,
            @AlmacenarRuta			varchar(200),
            @EsRetencion			bit,
            @FirmaCancelacionSAT	varchar(max)	OUTPUT,
            @DatosXMl				varchar(max)	OUTPUT,
            @Ok						int				OUTPUT,
            @OkRef					varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE
    @CadenaConexion			varchar(max),
	@PswPFX					varchar(30),
	@RenglonDatos			varchar(255),
	@Error					bit,
	@xml					xml,
	@RID					int,
	@iDatos					int,
	@DocumentoXML			xml,
	@PrefijoCFDI			varchar(255),
	@Shell					varchar(8000),
	@r						varchar(max),		  
	@FechaCancelacionSAT	varchar(30),
	@Cancelacion			bit,
	@TimeOutTimbrado		int,
	@MensajeSF				varchar(max), 
	@Dato1					varchar(max),
	@SelloCancelacionSAT	varchar(max),
	@EstatusCancelacion		varchar(10),
	--BUG21377
	@LeeXML					varchar(max),
	@TokenCanPAC				varchar(max),
	@CuentaCanPAC				varchar(max),
	@RutaProvPac			varchar(max),
	@UsarTimbrarNomina      bit
 
  DECLARE @Datos TABLE (ID int identity(1,1), Datos varchar(255))

  --BUG21377
  SELECT @PswPFX = 'Intelisis1234567', @Cancelacion = 1

  IF @RutaTimbrarCFD IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta IntelisisCFDI.exe no Puede Estar Vacio' ELSE
  IF @Fechatimbrado IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Fecha de Timbrado no Puede Estar Vacio' ELSE
  IF @ServidorPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Servidor PAC No puede Estar Vacio' ELSE   
  IF @RutaCer IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta Certificado CSD No puede Estar Vacio' ELSE 
  IF @RutaKey IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta Archivo Key No puede Estar Vacio' ELSE 
  IF @passKey IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Password Key No puede Estar Vacio' ELSE 
  IF @UUID IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Folio Fiscal UUID No puede Estar Vacio' ELSE 
  IF @RFC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato RFC Empresa No puede Estar Vacio' ELSE 
  IF @AlmacenarRuta IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Almacenar Ruta No puede Estar Vacio'


  SELECT @UsarTimbrarNomina= UsarTimbrarNomina FROM EmpresaCFD WHERE Empresa = @Empresa
  IF @ServidorPAC='KONESH'
  BEGIN	
   IF @UsarTimbrarNomina=1 
    SELECT @UsuarioPAC=TimbrarCFDIUsuario,@PaswordPAC=TimbrarCFDIPassword,@CuentaCanPAC=CancelarCFDICuenta,@TokenCanPAC=CancelarCFDIToken  FROM EmpresaCFDNomina WHERE Empresa = @Empresa
   ELSE 
    SELECT @UsuarioPAC=CancelarCFDIUsuario,@PaswordPAC=CancelarCFDIPassword,@CuentaCanPAC=CancelarCFDICuenta,@TokenCanPAC=CancelarCFDIToken  FROM EmpresaCFD WHERE Empresa = @Empresa
    
    IF @CuentaCanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Cuenta PAC No puede Estar Vacio' ELSE 
    IF @TokenCanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Token PAC No puede Estar Vacio' 
  END
  
  IF @UsuarioPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Usuario PAC No puede Estar Vacio' ELSE 
  IF @PaswordPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Pasword PAC No puede Estar Vacio'  
  
  IF @Ok IS NULL
  BEGIN
    SELECT @CadenaConexion = '<IntelisisCFDI>'+
                             '<IDSESION>'+convert(varchar,@@SPID)+'</IDSESION>'+
                             '<FECHA>'+@Fechatimbrado+'</FECHA>'+
		                     '<SERVIDOR>'+@ServidorPAC+'</SERVIDOR>'+
						     '<USUARIO>'+@UsuarioPAC+'</USUARIO>'+
						     '<PASSWORD>'+@PaswordPAC+'</PASSWORD>'+
						     '<CUENTA>'+ISNULL(@CuentaCanPAC,'')+'</CUENTA>'+
						     '<TOKEN>'+ISNULL(@TokenCanPAC,'')+'</TOKEN>'+
						     '<ACCION>'+@AccionCFDI+'</ACCION>'+
						     '<RUTACER>'+@RutaCer+'</RUTACER>'+
						     '<RUTAKEY>'+@RutaKey+'</RUTAKEY>'+
						     '<PWDKEY>'+@passKey+'</PWDKEY>'+
						     '<PWDPFX>'+@PswPFX+'</PWDPFX>'+
						     '<UUID>'+@UUID+'</UUID>'+
						     '<RFC>'+@RFC+'</RFC>'+
						     --BUG21377
			                 '<TIMEOUT>'+convert(varchar(30),ISNULL(@TimeOutTimbrado, 15000))+'</TIMEOUT>'+
						     '<RUTAARCHIVO>'+@AlmacenarRuta+'</RUTAARCHIVO>'+
				             '<MODOPRUEBAS>'+CONVERT(varchar(1),@ModoPruebas)+'</MODOPRUEBAS>'	
				             IF @EsRetencion=1 
				              SELECT  @CadenaConexion=@CadenaConexion+'<USARFIRMASAT>0</USARFIRMASAT></IntelisisCFDI>'
						     ELSE
						      SELECT  @CadenaConexion=@CadenaConexion+'</IntelisisCFDI>'
						     
    SELECT @Shell = CHAR(34)+CHAR(34)+@RutaTimbrarCFD+CHAR(34)+' '+CHAR(34)+@CadenaConexion+CHAR(34)+CHAR(34)


    INSERT @Datos
      EXEC @r =  xp_cmdshell @Shell--, no_output
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @DatosXMl = ''
    DECLARE crResultadoXMl CURSOR FOR
      SELECT Id, Datos FROM @Datos WHERE Datos IS NOT NULL ORDER BY ID Asc
    OPEN crResultadoXMl
    FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
      WHILE @@FETCH_STATUS <> -1
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN  
		IF @RID = 1 AND CHARINDEX('<IntelisisCFDI><Error>',@RenglonDatos) >= 1
		SELECT @Error = 1

	    IF @RID = 1 AND CHARINDEX('<',@RenglonDatos) = 0
		  SELECT @Error = 1
		
        SELECT @DatosXMl = @DatosXML + @RenglonDatos
      END
    FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
	END
    CLOSE crResultadoXMl
    DEALLOCATE crResultadoXMl
 /*JARL*/
 SELECT @DatosXML = REPLACE(@DatosXML,'<?xml vErsIOn="1.0"?>', '')
    IF @Error = 1 SELECT @Ok = 71650,  @OkRef = @DatosXml
    IF @r <> 0
    BEGIN
      IF CHARINDEX('programa o archivo por lotes ejecutable.',@RenglonDatos) >= 1
	    SELECT @Ok = 71650, @OkRef = 'Falta configurar la ruta de IntelisisCFDI.exe'
	  ELSE
	    SELECT @OK = 71650, @OkREf = 'Error al Ejecutar IntelisisCFDI.exe '+ISNULL(@DatosXml,'')
    END
    IF NULLIF(@DatosXMl,'') IS NULL SELECT @Ok = 71650, @OkRef = 'Se Esperaba Respuesta de IntelisisCFDI.exe' 

    --BUG21377
	--IF @ServidorPAC = 'SOLUCIONFACTIBLE'  OR @ServidorPAC='FORMASDIGITALES' OR @ServidorPAC='INVOICEONE'
	  SELECT @DatosXMl = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@DatosXMl, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'ñ', 'n'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'), 'Ñ', 'N'),'''','''''')

    IF @Ok is NULL
    BEGIN
      BEGIN TRY
        SELECT @xml = CONVERT(XML,@DatosXml)
      END TRY
      BEGIN CATCH
        SELECT @Ok = 71600, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
      END CATCH

      IF @OK IS NULL 
      BEGIN
	    SET @PrefijoCFDI = '<ns xmlns'+CHAR(58)+'es="http'+ CHAR(58) +'//cancelacfd.sat.gob.mx"  xmlns'+CHAR(58)+'sg="http'+ CHAR(58) +'//www.w3.org/2000/09/xmldsig#"/>' 	

        --BUG21401
	    EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML, @PrefijoCFDI
 
        IF @ServidorPAC ='MASTEREDI'
        BEGIN
          SELECT @FirmaCancelacionSAT = Firma
            FROM OPENXML (@idatos, 'MasTimbrado') 
            WITH (Firma	varchar(max) 'Mensaje')

          IF @FirmaCancelacionSAT='El archivo se proceso con exito.'			
          SET @FirmaCancelacionSAT=@FirmaCancelacionSAT+'Para obtener el acuse consulte a su PAC'													
        END		
        ELSE  IF @ServidorPAC ='KONESH'
        BEGIN
          SELECT @FirmaCancelacionSAT = Firma
            FROM OPENXML (@idatos, 'Cancelacion') 
            WITH (Firma	varchar(max) '.')         		
          SET @FirmaCancelacionSAT=@FirmaCancelacionSAT+'Para obtener el acuse consulte a su PAC'													
        END	 
	    ELSE IF @ServidorPAC = 'SOLUCIONFACTIBLE'
	    BEGIN
          SELECT @MensajeSF = mensaje
            FROM OPENXML (@idatos, '//EnviarSolicitudCancelacionResponse/CFDIResultadoCancelacion',2) 
            WITH (mensaje	varchar(max) 'mensaje')

          EXEC spExtraerDato @MensajeSF OUTPUT, @Dato1 OUTPUT, ':'
          EXEC spExtraerDato @MensajeSF OUTPUT, @FirmaCancelacionSAT OUTPUT, ';'
          SELECT @FirmaCancelacionSAT = RTRIM(LTRIM(@FirmaCancelacionSAT))           

          SELECT @EstatusCancelacion = EstatusUUID
          FROM   OPENXML (@idatos,'//EnviarSolicitudCancelacionResponse/CFDIResultadoCancelacion' ) 
          WITH (EstatusUUID       varchar(max) 'statusUUID') 
	    END  
        
        ELSE IF @ServidorPAC = 'FORMASDIGITALES'    
            BEGIN  
                SET @PrefijoCFDI = '<ns xmlns' + CHAR(58) + 's="http' + CHAR(58) + '//schemas.xmlsoap.org/soap/envelope/" xmlns' + CHAR(58) + 'cr="http' + CHAR(58) + '//cancelacfd.sat.gob.mx" xmlns' + CHAR(58) + 'sg="http' + CHAR(58) + '//www.w3.org/2000/09/xmldsig'+CHAR(35)+'" />'                  
                    EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML, @PrefijoCFDI                     
           
                    SELECT @FechaCancelacionSAT = Fecha, @EstatusCancelacion = EstatusUUID    
                        FROM   OPENXML (@idatos, '//cr:CancelaCFDResponse/cr:CancelaCFDResult/cr:Folios',2)     
                                   WITH (Fecha    varchar(50)         '../@Fecha',    
                                    UUID    varchar(50) 'cr:UUID',     
                                    EstatusUUID  varchar(10) 'cr:EstatusUUID',    
                                            RFC    varchar(10) '../@RfcEmisor')    
          
                    SELECT @FirmaCancelacionSAT = Firma    
                        FROM   OPENXML (@idatos, '//cr:CancelaCFDResponse/cr:CancelaCFDResult/sg:Signature',2)     
                               WITH (Firma       varchar(max) 'sg:SignatureValue')    
          
                    EXEC sp_xml_removedocument @iDatos 
            END 

	    ELSE  IF @ServidorPAC ='G4S'
        BEGIN                         		
          SET @FirmaCancelacionSAT='Para obtener el acuse consulte a su PAC'													
        END
	    ----REQ21490 REQ21609
	    --ELSE IF @ServidorPAC IN('EKOMERCIO', 'FEL', 'ASPEL')
	    --BEGIN
	    --  SELECT @EstatusCancelacion = EstatusUUID
		   -- FROM OPENXML (@idatos,'//es:Folios' ) 
		   -- WITH (EstatusUUID       varchar(max) 'es:EstatusUUID')
			
		   --SELECT @FirmaCancelacionSAT = Firma
		   --  FROM OPENXML (@idatos, '//sg:Signature') 
		   --  WITH (Firma	 varchar(max) 'sg:SignatureValue')         	  
	    --END	    
	    ELSE	
        BEGIN
          SELECT @EstatusCancelacion = EstatusUUID
            FROM OPENXML (@idatos,'//es:Folios' ) 
            WITH (EstatusUUID       varchar(max) 'es:EstatusUUID')

          SELECT @FirmaCancelacionSAT = Firma
            FROM OPENXML (@idatos, '//sg:Signature') 
            WITH (Firma	 varchar(max) 'sg:SignatureValue')         
	    END
	  	  
	    EXEC sp_xml_removedocument @iDatos 

        --BUG21630
        IF @EstatusCancelacion IN('201', '202') SELECT @EstatusCancelacion = NULL
		
        IF @EstatusCancelacion IS NOT NULL
	    BEGIN
   	      SELECT @OK = 71651
		  SELECT @OkRef = Descripcion FROM MensajeCFDI WHERE Mensaje = @EstatusCancelacion
		  
		  --BUG21630
		  --IF @EstatusCancelacion IN ('201') AND @FirmaCancelacionSAT IS NULL
  		  --  SELECT @OK = NULL , @OkRef = NULL
        END
      END
    END
  END
END
GO

/**************** fnIntelisisCFDIListaPAC ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnIntelisisCFDIListaPAC') DROP FUNCTION dbo.fnIntelisisCFDIListaPAC
GO
CREATE FUNCTION dbo.fnIntelisisCFDIListaPAC 
	(
	@Empresa			varchar(5)
	)
RETURNS @Lista TABLE
        (
	Servidor		varchar(100)
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EsGuatemala			bit
  
  SELECT @EsGuatemala = 0
--  SELECT @EsGuatemala = ISNULL(EsGuatemala,0) FROM Empresa WHERE Empresa = @Empresa
  
  IF @EsGuatemala = 0  
    INSERT @Lista (Servidor)
    SELECT 'EDICOM'
      UNION
    SELECT 'SOLUCIONFACTIBLE'
      UNION
	SELECT 'FACTURAINTELIGENTE'
	 UNION
    SELECT 'INVOICEONE'
    UNION
	SELECT 'PROFACT'
	 UNION
	SELECT 'PRODIGIA'
	 UNION
    SELECT 'FORMASDIGITALES'
    --REQ21489
    UNION
    SELECT 'ASPEL'    
    --REQ21490
    UNION
    SELECT 'EKOMERCIO'
    --REQ21512
    UNION
    SELECT 'MASTEREDI'    
    --REQ21609
    UNION
    SELECT 'FEL'        
    --REQ22337
    UNION
    SELECT 'LEVICOM'
    --REQ22648
    UNION
    SELECT 'KONESH'
    UNION
    SELECT 'G4S'
	UNION        --BUG 5234 (PRODRIGUEZ)
    SELECT 'SERVICIOPAC'
/*
      
      UNION
    SELECT 'Levicom'     
      UNION
    SELECT 'FoliosDigitales'
      UNION
    SELECT 'ExpidetuFactura'
      UNION
    SELECT 'Servisim'
    ELSE
    INSERT @Lista (Servidor)
    SELECT 'MYSUITEGUATEMALA'
*/  
  RETURN
END
GO
