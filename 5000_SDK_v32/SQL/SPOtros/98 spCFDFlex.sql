EXEC sp_configure 'show advanced option', '1'  
GO
RECONFIGURE WITH OVERRIDE 
GO
EXEC sp_configure 'Ole Automation Procedures', '1'  
GO
RECONFIGURE WITH OVERRIDE   
GO
EXEC sp_configure 'xp_cmdshell', '1'  
GO
RECONFIGURE WITH OVERRIDE   
GO
EXEC sp_configure N'Database Mail XPs', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO
if not substring(@@version, 1, 25) in ('Microsoft SQL Server 2012', 'Microsoft SQL Server 2014', 'Microsoft SQL Server 2016')
EXEC sp_configure N'SQL Mail XPs', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO

/******************************* spCFDFLexContratoAspelObtener *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFLexContratoAspelObtener') and type = 'P') drop procedure dbo.spCFDFLexContratoAspelObtener
GO             
CREATE PROCEDURE spCFDFLexContratoAspelObtener
        @Estacion	int,
        @Empresa	varchar(5)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @RutaFirmarContratoAspel	varchar(max),
    @RutaTemporal				varchar(max),
    @ArchivoTemporal			varchar(max),
    @Shell						varchar(8000),
    @SQL						nvarchar(max),
    @Rfc						varchar(20),
    @ModoPruebas				bit,
    @Existe						bit,
    @Ok							int,
    @OkRef						varchar(255),
    @CadenaConexion			varchar(max),
	    @ServidorPAC        varchar(100),
    @UsuarioPAC         varchar(100),
    @PaswordPAC         varchar(100)


  IF (OBJECT_ID('Tempdb..#CFDFlexLeerArchivo')) IS NOT NULL
    DROP TABLE #CFDFlexLeerArchivo

  CREATE TABLE #CFDFlexLeerArchivo
  (
    ArchivoXML varchar(max) COLLATE Modern_Spanish_CS_AS NOT NULL
   )
  

  SELECT @RFC = RFC FROM Empresa WHERE Empresa = @Empresa
  SELECT 
      @ServidorPAC       = TimbrarCFDIServidor,
      @UsuarioPAC        = TimbrarCFDIUsuario,
      @PaswordPAC        = TimbrarCFDIPassword,
      @RutaFirmarContratoAspel = RutaIntelisisCFDI,
         @RutaTemporal = RutaTemporal,        
         @ModoPruebas = ModoPruebas
    FROM EmpresaCFD
   WHERE Empresa = @Empresa
  SELECT @ArchivoTemporal = @RutaTemporal + CASE WHEN SUBSTRING(REVERSE(@RutaTemporal),1,1) <> '\' THEN '\' ELSE '' END + 'Contrato_CFDI_Obtener_Aspel.XML'  
  
  SELECT @CadenaConexion = '<IntelisisCFDI>'+
                             '<IDSESION>'+convert(varchar,@@SPID)+'</IDSESION>'+
                             '<FECHA>'+ CONVERT (varchar, GETDATE())+'</FECHA>'+
		                     '<SERVIDOR>ASPEL</SERVIDOR>'+
						     '<USUARIO></USUARIO>'+
						     '<PASSWORD></PASSWORD>'+
						     '<CUENTA></CUENTA>'+
						     '<TOKEN></TOKEN>'+
						     '<ACCION>OBTENERCONTRATO</ACCION>'+
						     '<RUTACER></RUTACER>'+
						     '<RUTAKEY></RUTAKEY>'+
						     '<PWDKEY></PWDKEY>'+
						     '<PWDPFX></PWDPFX>'+
						     '<UUID></UUID>'+
						     '<RFC>'+@RFC+'</RFC>'+
						     --BUG21377
			                 '<TIMEOUT>15000</TIMEOUT>'+
						     '<RUTAARCHIVO>'+@ArchivoTemporal+'</RUTAARCHIVO>'+
				             '<MODOPRUEBAS>'+CONVERT(varchar(1),@ModoPruebas)+'</MODOPRUEBAS>'+	
				             '<USARFIRMASAT>1</USARFIRMASAT>'+
						     '</IntelisisCFDI>'
  SELECT @Shell = CHAR(34)+CHAR(34)+@RutaFirmarContratoAspel+CHAR(34)+' '+CHAR(34)+@CadenaConexion+CHAR(34)+CHAR(34)
  EXEC spEliminarArchivo @ArchivoTemporal, @Ok OUTPUT, @OkRef OUTPUT
  
  IF @OK IS NULL
  BEGIN
    EXEC xp_cmdshell @Shell, no_output
    EXEC spVerificarArchivo @ArchivoTemporal, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END
  
  IF @Existe = 0 AND @OK IS NULL
    SELECT @OK = 71525, @OkRef = @ArchivoTemporal

  SET @SQL = N'INSERT INTO #CFDFlexLeerArchivo
                SELECT CONVERT(varchar(max),CONVERT(xml,BulkColumn)) FROM OPENROWSET(
                BULK ''' +  @ArchivoTemporal + ''', SINGLE_BLOB)AS x'

  IF @Existe = 1 AND @Ok IS NULL
  BEGIN
    EXEC (@SQL)

    DELETE CFDFLexContratoAspel WHERE Estacion = @Estacion
    INSERT CFDFLexContratoAspel
           (Estacion,  Contrato)
    SELECT @Estacion, ArchivoXML
      FROM #CFDFlexLeerArchivo
    SELECT  '' 
  END
  ELSE
  BEGIN
    SELECT @OkRef = Descripcion + ' ' + @OkRef FROM MensajeLista WHERE Mensaje = @Ok    
    SELECT 'Error - ' + CONVERT(varchar,@Ok) + '<BR><BR>' + @OkRef
  END
END
GO


/******************************* spCFDFLexContratoAspelFirmar *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFLexContratoAspelFirmar') and type = 'P') drop procedure dbo.spCFDFLexContratoAspelFirmar
GO             
CREATE PROCEDURE spCFDFLexContratoAspelFirmar
        @Estacion	int,
        @Empresa	varchar(5)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @RutaFirmarContratoAspel	varchar(max),
    @RutaTemporal				varchar(max),
    @ArchivoTemporal			varchar(max),
    @ArchivoObtener				varchar(max),
    @Shell						varchar(8000),
    @SQL						nvarchar(max),
    @CertificadoEmisor			varchar(255),
    @LlaveEmisor				varchar(255),
    @ContrasenaFirma			varchar(50),
    @UsuarioEmisor				varchar(50),
    @RFCEmisor					varchar(50),
    @Existe						bit,
    @Ok							int,
    @OkRef						varchar(255),
    @CadenaConexion				varchar(max),
    @Rfc						varchar(20),
    @ModoPruebas				bit,
	@ServidorPAC				varchar(100),
    @UsuarioPAC					varchar(100),
    @PaswordPAC					varchar(100),
	@CFDFlex					bit

  IF (OBJECT_ID('Tempdb..#CFDFlexLeerArchivo')) IS NOT NULL
    DROP TABLE #CFDFlexLeerArchivo

  CREATE TABLE #CFDFlexLeerArchivo
  (
    ArchivoXML varchar(max) COLLATE Modern_Spanish_CS_AS NOT NULL
   )

  SELECT @CFDFlex = CFDFlex FROM EmpresaGral WHERE Empresa = @Empresa  
  SELECT 
         @ServidorPAC       = TimbrarCFDIServidor,
         @UsuarioPAC        = TimbrarCFDIUsuario,
         @PaswordPAC        = TimbrarCFDIPassword,
         @RutaFirmarContratoAspel = RutaIntelisisCFDI,
         @CertificadoEmisor = RutaCertificado,
         @LlaveEmisor = Llave,
         @ContrasenaFirma = CASE WHEN @CFDFlex = 1 THEN ContrasenaSello ELSE ContrasenakeyCSD END,  
         @RutaTemporal = RutaTemporal,
         @UsuarioEmisor = 'DEMO',
         @ModoPruebas = ModoPruebas         
    FROM EmpresaCFD
   WHERE Empresa = @Empresa
  SELECT @RFC = RFC FROM Empresa WHERE Empresa = @Empresa
  SELECT @RFCEmisor = RFC FROM Empresa WHERE Empresa = @Empresa
  SELECT @ArchivoObtener = @RutaTemporal + CASE WHEN SUBSTRING(REVERSE(@RutaTemporal),1,1) <> '\' THEN '\' ELSE '' END + 'Contrato_CFDI_Obtener_Aspel.XML'  
  SELECT @ArchivoTemporal = @RutaTemporal + CASE WHEN SUBSTRING(REVERSE(@RutaTemporal),1,1) <> '\' THEN '\' ELSE '' END + 'Contrato_CFDI_Firmado_Aspel.XML'  
  SET @CadenaConexion = '<IntelisisCFDI>'+
                             '<IDSESION>'+convert(varchar,@@SPID)+'</IDSESION>'+
                             '<FECHA>'+ CONVERT (varchar, GETDATE())+'</FECHA>'+
		                     '<SERVIDOR>ASPEL</SERVIDOR>'+
						     '<USUARIO>'+@UsuarioPAC+'</USUARIO>'+
						     '<PASSWORD>'+@PaswordPAC+'</PASSWORD>'+
						     '<CUENTA></CUENTA>'+
						     '<TOKEN></TOKEN>'+
						     '<ACCION>FIRMARCONTRATO</ACCION>'+
						     '<RUTACER>'+@CertificadoEmisor+'</RUTACER>'+
						     '<RUTAKEY>'+@LlaveEmisor+'</RUTAKEY>'+
						     '<PWDKEY>'+@ContrasenaFirma+'</PWDKEY>'+
						     '<PWDPFX></PWDPFX>'+
						     '<UUID></UUID>'+
						     '<RFC>'+@RFC+'</RFC>'+
						     --BUG21377
			                 '<TIMEOUT>15000</TIMEOUT>'+
						     '<RUTAARCHIVO>'+@ArchivoObtener+'</RUTAARCHIVO>'+
						     '<RUTAARCHIVOOUT>'+@ArchivoTemporal+'</RUTAARCHIVOOUT>'+
				             '<MODOPRUEBAS>'+CONVERT(varchar(1),@ModoPruebas)+'</MODOPRUEBAS>'+	
				             '<USARFIRMASAT>1</USARFIRMASAT>'+
						     '</IntelisisCFDI>'
						     

  SELECT @Shell = CHAR(34)+CHAR(34)+@RutaFirmarContratoAspel+CHAR(34)+' '+CHAR(34)+@CadenaConexion+CHAR(34)+CHAR(34)
  
  --SET @Shell = @RutaFirmarContratoAspel + ' Firmar "' + @ArchivoTemporal + '" "' + @CertificadoEmisor + '" "' + @LlaveEmisor + '" "' + @ContraseñaFirma + '" "' + @UsuarioEmisor + '" "' + @RFCEmisor + '"'

  EXEC spEliminarArchivo @ArchivoTemporal, @Ok OUTPUT, @OkRef OUTPUT
  
  IF @OK IS NULL
  BEGIN  
    EXEC xp_cmdshell @Shell, no_output  
    EXEC spVerificarArchivo @ArchivoTemporal, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF @Existe = 0 AND @OK IS NULL
    SELECT @OK = 71525, @OkRef = @ArchivoTemporal

  SET @SQL = N'INSERT INTO #CFDFlexLeerArchivo
                SELECT CONVERT(varchar(max),CONVERT(xml,BulkColumn)) FROM OPENROWSET(
                BULK ''' +  @ArchivoTemporal + ''', SINGLE_BLOB)AS x'


  IF @Existe = 1 AND @Ok IS NULL
  BEGIN
    EXEC (@SQL)
  
    UPDATE EmpresaCFD SET ContatoFirmadoAspel = (SELECT ArchivoXML FROM #CFDFlexLeerArchivo) WHERE Empresa = @Empresa

  END
  ELSE
  BEGIN

    SELECT @OkRef = Descripcion + ' ' + @OkRef FROM MensajeLista WHERE Mensaje = @Ok    
    SELECT 'Error - ' + CONVERT(varchar,@Ok) + '<BR><BR>' + @OkRef
  END
END
GO
--EXEC spCFDFLexContratoAspelFirmar 1, 'DEMO'


/**************** spAbrirAnexo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAbrirAnexo') and type = 'P') drop procedure dbo.spAbrirAnexo
GO             
CREATE PROCEDURE spAbrirAnexo
					@Modulo		varchar(5),
					@ID			int				

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Direccion		varchar(255)
  
  SET @Direccion = NULL
  
  IF @Modulo = 'VTAS'
  BEGIN
    SELECT TOP 1 @Direccion = a.Direccion
      FROM Venta v
      JOIN AnexoMov a
		ON a.Rama = @Modulo
	   AND a.ID = v.ID
	  JOIN EmpresaCFD e
	    ON e.Empresa = v.Empresa
     WHERE v.ID = @ID
       AND a.CFD = 1
       AND RIGHT(a.Direccion,4) = '.PDF'
       AND ISNULL(e.MostrarAnexoPDF,0) = 1
  END
  ELSE
  IF @Modulo = 'CXC'
  BEGIN
    SELECT TOP 1 @Direccion = a.Direccion
      FROM Cxc c
      JOIN AnexoMov a
		ON a.Rama = @Modulo
	   AND a.ID = c.ID
	  JOIN EmpresaCFD e
	    ON e.Empresa = c.Empresa	   
     WHERE c.ID = @ID
       AND a.CFD = 1
       AND RIGHT(a.Direccion,4) = '.PDF'
       AND ISNULL(e.MostrarAnexoPDF,0) = 1
  END
  
  SELECT @Direccion
  
  RETURN
END
GO

/******************************* spCFDFlexRegistrarCorreoElectronico *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexRegistrarCorreoElectronico') and type = 'P') drop procedure dbo.spCFDFlexRegistrarCorreoElectronico
GO             
CREATE PROCEDURE spCFDFlexRegistrarCorreoElectronico
		@NombrePerfil			varchar(50),
		@NombreCuenta			varchar(50),
		@Descripcion			varchar(100),
		@CorreoElectronico		varchar(100),
		@Usuario				varchar(100),
		@Contrasena				varchar(50),
		@Servidor				varchar(100),
		@Puerto					int,
		@SSL					bit				



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  IF EXISTS(SELECT * FROM msdb.dbo.sysmail_account WHERE name = @NombreCuenta)
    EXECUTE msdb.dbo.sysmail_delete_account_sp @account_name = @NombreCuenta

  IF EXISTS(SELECT * FROM msdb.dbo.sysmail_profile WHERE name = @NombrePerfil)
    EXECUTE msdb.dbo.sysmail_delete_profile_sp @profile_name = @NombrePerfil
    
  EXECUTE msdb.dbo.sysmail_add_account_sp 
    @account_name = @NombreCuenta, 
    @description = @Descripcion,
    @email_address = @CorreoElectronico,
    @display_name = @NombreCuenta,
    @username=@Usuario,
    @password=@Contrasena,
    @mailserver_name = @Servidor,
    @port = @Puerto,
    @enable_ssl = @SSL
    
    
  EXECUTE msdb.dbo.sysmail_add_profile_sp
    @profile_name = @NombrePerfil,
    @description = @Descripcion  

  EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = @NombrePerfil,
    @account_name = @NombreCuenta,
    @sequence_number = 1

  EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
    @profile_name = @NombrePerfil,
    @principal_name = 'public',
    @is_default = 0
    
END
GO

/**************** fnCFDFlexFormatearImporte ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexFormatearImporte') DROP FUNCTION fnCFDFlexFormatearImporte
GO
CREATE FUNCTION fnCFDFlexFormatearImporte 
	(
	@Importe				float,
	@Entero					int,
	@Decimal				int
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(255),
    @NumeroEntero		int,
    @NumeroDecimal		float,
    @TextoEntero		varchar(100),
    @TextoDecimal		varchar(100),
    @PosicionInicial	int,
    @LongitudDecimal	int

  SET @NumeroEntero = FLOOR(@Importe)
  SET @NumeroDecimal = @Importe - @NumeroEntero
  
  SET @TextoEntero  = RTRIM(LTRIM(CONVERT(varchar,@NumeroEntero)))
  SET @TextoDecimal = RTRIM(LTRIM(CONVERT(varchar,@NumeroDecimal)))
  IF @TextoDecimal NOT IN ('0')
  BEGIN
    SET @PosicionInicial = CHARINDEX('.',@TextoDecimal) + 1
    SET @LongitudDecimal = LEN(@TextoDecimal) - 2
    SET @TextoDecimal = SUBSTRING(@TextoDecimal,@PosicionInicial,@LongitudDecimal)
  END  
  SET @TextoEntero = REPLICATE('0',10-LEN(@TextoEntero)) + @TextoEntero 
  SET @TextoDecimal = SUBSTRING(@TextoDecimal,1,6)
  SET @TextoDecimal = @TextoDecimal + REPLICATE('0',6-LEN(@TextoDecimal))
  SET @Resultado = RTRIM(@TextoEntero) + '.' + RTRIM(@TextoDecimal)
  RETURN (@Resultado)
END
GO

/**************** spCFDFlexTextoQRCode ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'spCFDFlexTextoQRCode') DROP PROCEDURE spCFDFlexTextoQRCode
GO
CREATE PROCEDURE spCFDFlexTextoQRCode 
                (
                @Modulo                                                                             varchar(5),
                @ModuloID                                                          int
                )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado                                                     varchar(255),
                @EmisorRFC                                                       varchar(50), 
                @ReceptorRFC                                    varchar(50),
                @Importe                                                              float,
                @UUID                                                                  varchar(50),
                @XML                                                                   varchar(max),
                @DocumentoXML                                xml,
                @PrefijoCFDI                                       varchar(255),
                @RutaCFDI                                                          varchar(255),
                @iDatos                                                                int

    SELECT
      @XML = Documento
      FROM CFD
     WHERE Modulo = @Modulo 
       AND ModuloID = @ModuloID 
     
    SET @DocumentoXML = CONVERT(XML,REPLACE(REPLACE(@XML,'encoding="UTF-8"','encoding="Windows-1252"'),'?<?xml','<?xml'))

    SET @PrefijoCFDI = '<ns xmlns' + CHAR(58) + 'cfdi="http' + CHAR(58) + '//www.sat.gob.mx/cfd/3" xmlns' + CHAR(58) + 'tfd="http' + CHAR(58) + '//www.sat.gob.mx/TimbreFiscalDigital"/>'    
    EXEC sp_xml_preparedocument @iDatos OUTPUT, @DocumentoXML, @PrefijoCFDI

    SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante'    
    SELECT  
                  @Importe = total                                 
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (total float)

    SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Receptor'
    SELECT  
                  @ReceptorRFC = rfc                                         
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (rfc varchar(15))

    SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Emisor'
    SELECT  
                  @EmisorRFC = rfc                                             
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (rfc varchar(15))


    SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Complemento/tfd' + CHAR(58) + 'TimbreFiscalDigital'
    SELECT  
                  @UUID = UUID
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (UUID uniqueidentifier)

    EXEC sp_xml_removedocument @iDatos  
  

  SET @Resultado = '?re='+ISNULL(@EmisorRFC,'')+'&rr='+ISNULL(@ReceptorRFC,'')+'&tt='+dbo.fnCFDFlexFormatearImporte(@Importe,10,6)+'&id='+@UUID

  SELECT @Resultado
END
GO

/******************************* spCFDFlexQRCode *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexQRCode') and type = 'P') drop procedure dbo.spCFDFlexQRCode
GO             
CREATE PROCEDURE spCFDFlexQRCode
        @Empresa	varchar(5),
		@Modulo		varchar(5),
		@ID			int,
		@Imagen		varchar(255)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @TextoQRCode			varchar(max),
    @Shell					varchar(8000),
    @RutaGenerarQRCode		varchar(max)
    
  SELECT @RutaGenerarQRCode = RTRIM(LTRIM(ISNULL(RutaGenerarQRCode,'')))
    FROM EmpresaCFD
   WHERE Empresa = @Empresa

  
  DECLARE @Tabla TABLE (
			            TextoQRCode		varchar(max)
					   )
  
  DELETE @Tabla  
  INSERT INTO @Tabla  
  EXEC spCFDFlexTextoQRCode @Modulo, @ID
  
  SELECT TOP 1 @TextoQRCode = RTRIM(LTRIM(ISNULL(TextoQRCode,''))) FROM @Tabla  
  SELECT @Shell = CHAR(34) + CHAR(34) + @RutaGenerarQRCode + CHAR(34) + ' ' + CHAR(34) + @Imagen + CHAR(34) + ' ' + CHAR(34) + @TextoQRCode + CHAR(34) + CHAR(34)

  EXEC xp_cmdshell @Shell, no_output


END
GO

--EXEC spCFDFlexQRCode 'DEMO', 'VTAS', 3145


/******************************* spCFDFlexJasperPDF *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexJasperPDF') and type = 'P') drop procedure dbo.spCFDFlexJasperPDF
GO             
CREATE PROCEDURE spCFDFlexJasperPDF
		@Empresa		varchar(5),
		@Modulo			varchar(5),
		@ID				int,
		@Temporal		varchar(255),
		@Imagen			varchar(255),
		@Reporte		varchar(50),
		--REQ Q3069 CFDGT
		@RutaDatosXML	varchar(255) OUTPUT,
		
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @XML					varchar(max),
    @JaseperPDF				varchar(max),
    @ImporteConLetra		varchar(max),
	@Comentario1			varchar(255),
	@Comentario2			varchar(255),
	@Comentario3			varchar(255),
	@Comentario4			varchar(255),
	@Comentario5			varchar(255),
	@PlantillaJasper		varchar(255),
	@eDocEstatus			varchar(15),
	@Mov					varchar(20),
	@ContMoneda				varchar(20),
	@EmpresaNoInterior		varchar(20),
	@ReceptorNoInterior		varchar(20),
	@Receptor				varchar(50),
	@TFDCadenaOriginal		varchar(max),
	@EsCFDI					bit,
	@Estatus				varchar(15),
	@SAT_MN					bit

  SET @EsCFDI = 0
  IF @Modulo = 'VTAS'
  BEGIN
    SELECT @Mov = RTRIM(LTRIM(ISNULL(v.Mov,''))),
           @Receptor = RTRIM(LTRIM(ISNULL(v.Cliente,''))),
           @Estatus = RTRIM(LTRIM(ISNULL(v.Estatus,''))),
           @SAT_MN = ISNULL(mt.SAT_MN, ec.SAT_MN)
      FROM Venta v
      JOIN EmpresaCFD ec
        ON v.Empresa = ec.Empresa
      JOIN MovTipo mt
        ON v.Mov = mt.Mov AND mt.Modulo = @Modulo
     WHERE v.ID = @ID
    
    SELECT @ReceptorNoInterior = RTRIM(LTRIM(ISNULL(DireccionNumeroInt,''))) FROM Cte WHERE Cliente = @Receptor
  END
  ELSE
  IF @Modulo = 'COMS'
  BEGIN
    SELECT @Mov = RTRIM(LTRIM(ISNULL(c.Mov,''))),
           @Receptor = RTRIM(LTRIM(ISNULL(c.Proveedor,''))),
           @Estatus = RTRIM(LTRIM(ISNULL(c.Estatus,''))),
           @SAT_MN = ISNULL(mt.SAT_MN, ec.SAT_MN)
      FROM Compra c
      JOIN EmpresaCFD ec
        ON c.Empresa = ec.Empresa
      JOIN MovTipo mt
        ON c.Mov = mt.Mov AND mt.Modulo = @Modulo
     WHERE c.ID = @ID
     
    SELECT @ReceptorNoInterior = RTRIM(LTRIM(ISNULL(DireccionNumeroInt,''))) FROM Prov WHERE Proveedor = @Receptor
  END
  ELSE
  IF @Modulo = 'CXC'
  BEGIN
    SELECT @Mov = RTRIM(LTRIM(ISNULL(Cxc.Mov,''))),
           @Receptor = RTRIM(LTRIM(ISNULL(Cxc.Cliente,''))),
           @Estatus = RTRIM(LTRIM(ISNULL(Cxc.Estatus,''))),
           @SAT_MN = ISNULL(mt.SAT_MN, ec.SAT_MN)
      FROM Cxc
      JOIN EmpresaCFD ec
        ON Cxc.Empresa = ec.Empresa
      JOIN MovTipo mt
        ON Cxc.Mov = mt.Mov AND mt.Modulo = @Modulo
     WHERE Cxc.ID = @ID
     
    SELECT @ReceptorNoInterior = RTRIM(LTRIM(ISNULL(DireccionNumeroInt,''))) FROM Cte WHERE Cliente = @Receptor 
  END
  ELSE
  IF @Modulo = 'CXP'
  BEGIN
    SELECT @Mov = RTRIM(LTRIM(ISNULL(Cxp.Mov,''))),
           @Receptor = RTRIM(LTRIM(ISNULL(Cxp.Proveedor,''))),
           @Estatus = RTRIM(LTRIM(ISNULL(Cxp.Estatus,''))),
           @SAT_MN = ISNULL(mt.SAT_MN, ec.SAT_MN)
      FROM Cxp
      JOIN EmpresaCFD ec
        ON Cxp.Empresa = ec.Empresa
      JOIN MovTipo mt
        ON Cxp.Mov = mt.Mov AND mt.Modulo = @Modulo
     WHERE Cxp.ID = @ID
     
    SELECT @ReceptorNoInterior = RTRIM(LTRIM(ISNULL(DireccionNumeroInt,''))) FROM Prov WHERE Proveedor = @Receptor
  END
  
  SELECT @ContMoneda = RTRIM(LTRIM(ISNULL(ContMoneda,''))) FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @EmpresaNoInterior = RTRIM(LTRIM(ISNULL(DireccionNumeroInt,''))) FROM Empresa WHERE Empresa = @Empresa
  
  UPDATE CFD
     SET TFDCadenaOriginal = dbo.fnCFDFlexCadenaOriginalTFDI(@Modulo, @ID)
   WHERE Modulo = @Modulo 
     AND ModuloID = @ID
     
  SELECT @XML = ISNULL(Documento,''),
         @TFDCadenaOriginal = ISNULL(TFDCadenaOriginal,'')
    FROM CFD 
   WHERE Modulo = @Modulo 
     AND ModuloID = @ID


  IF @Modulo = 'VTAS'
    SELECT
       @ImporteConLetra = RTRIM(LTRIM(ISNULL(dbo.fnNumeroEnEspanol(VentaTotal,CASE WHEN @SAT_MN = 1 THEN @ContMoneda ELSE VentaMoneda END),''))),
       @ImporteConLetra = CASE WHEN @SAT_MN = 1 THEN '(' + @ImporteConLetra +  + ' M.N.)' ELSE
            CASE WHEN @ContMoneda = VentaMoneda THEN '(' + @ImporteConLetra +  + ' M.N.)' ELSE '(' + @ImporteConLetra +  + ')' END END
      FROM CFDVenta 
     WHERE ID = @ID
  ELSE
  IF @Modulo = 'CXC'
    SELECT
       @ImporteConLetra = RTRIM(LTRIM(ISNULL(dbo.fnNumeroEnEspanol(CxcTotal,CASE WHEN @SAT_MN = 1 THEN @ContMoneda ELSE CXCMoneda END),''))),
       @ImporteConLetra = CASE WHEN @SAT_MN = 1 THEN '(' + @ImporteConLetra +  + ' M.N.)' ELSE
              CASE WHEN @ContMoneda = CXCMoneda THEN '(' + @ImporteConLetra +  + ' M.N.)' ELSE '(' + @ImporteConLetra +  + ')' END END
      FROM CFDCxc
     WHERE ID = @ID


  SELECT @Comentario1		=	RTRIM(LTRIM(ISNULL(Comentario1,''))),
		 @Comentario2		=	RTRIM(LTRIM(ISNULL(Comentario2,''))),
		 @Comentario3		=	RTRIM(LTRIM(ISNULL(Comentario3,''))),
		 @Comentario4		=	RTRIM(LTRIM(ISNULL(Comentario4,''))),
		 @Comentario5		=	RTRIM(LTRIM(ISNULL(Comentario5,''))),
		 @PlantillaJasper	=	RTRIM(LTRIM(ISNULL(PlantillaJasper,'')))
    FROM EmpresaCFDJasperReports 
   WHERE Empresa = @Empresa AND Reporte = @Reporte

  IF NULLIF(@Receptor,'') IS NULL SET @Receptor = '(Todos)'
  
  --Primero se busca el cliente especifico  
  SELECT 
    @eDocEstatus = NULLIF(Estatus,'')
    FROM MovTipoCFDFlex
   WHERE Modulo = @Modulo
     AND Mov = @Mov
     AND Contacto = @Receptor

  --Si no se encuentra, se busca una configuración genérica
  IF NULLIF(@eDocEstatus,'') IS NULL
  BEGIN  
    SELECT 
      @eDocEstatus = NULLIF(Estatus,'')      
      FROM MovTipoCFDFlex
     WHERE Modulo = @Modulo
       AND Mov = @Mov
       AND ISNULL(NULLIF(ISNULL(NULLIF(Contacto,''),'(Todos)'),'(Todos)'),@Receptor) = @Receptor
  END

--select @XML = '<?xml version="1.0" encoding="UTF-8"?><Comprobante xmlns="http://www.sat.gob.mx/cfd/2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0" xsi:schemaLocation="http://www.sat.gob.mx/cfd/2 http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv2.xsd" serie="ABCD" folio="1090" fecha="2011-09-06T16:57:05" sello="PCpVEzeSgN7q/XgxGAk5essnyG2tpMgFf2gJyTSnGI5JWPtOgP1i7nbep1e6AUMJF5jaCb9ZMyVYMzvddPp8/jsV8pPYgF/h60X1K79TuDvPeFtDldHfeFrrfUK0tEPmRxb1vbWwFPPPiTiWjitHdHwlg53XKvhl+NmIkZVte9o=" noCertificado="00001000000102317394" certificado="MIIESzCCAzOgAwIBAgIUMDAwMDEwMDAwMDAxMDIzMTczOTQwDQYJKoZIhvcNAQEFBQAwggE2MTgwNgYDVQQDDC9BLkMuIGRlbCBTZXJ2aWNpbyBkZSBBZG1pbmlzdHJhY2nDs24gVHJpYnV0YXJpYTEvMC0GA1UECgwmU2VydmljaW8gZGUgQWRtaW5pc3RyYWNpw7NuIFRyaWJ1dGFyaWExHzAdBgkqhkiG9w0BCQEWEGFjb2RzQHNhdC5nb2IubXgxJjAkBgNVBAkMHUF2LiBIaWRhbGdvIDc3LCBDb2wuIEd1ZXJyZXJvMQ4wDAYDVQQRDAUwNjMwMDELMAkGA1UEBhMCTVgxGTAXBgNVBAgMEERpc3RyaXRvIEZlZGVyYWwxEzARBgNVBAcMCkN1YXVodGVtb2MxMzAxBgkqhkiG9w0BCQIMJFJlc3BvbnNhYmxlOiBGZXJuYW5kbyBNYXJ0w61uZXogQ29zczAeFw0xMDEyMDcxNzU1NTlaFw0xMjEyMDYxNzU1NTlaMIHrMTAwLgYDVQQDEydDT01FUkNJQUxJWkFET1JBIFhUUkVNRSBQTEFORVQgU0EgREUgQ1YxMDAuBgNVBCkTJ0NPTUVSQ0lBTElaQURPUkEgWFRSRU1FIFBMQU5FVCBTQSBERSBDVjEwMC4GA1UEChMnQ09NRVJDSUFMSVpBRE9SQSBYVFJFTUUgUExBTkVUIFNBIERFIENWMSUwIwYDVQQtExxDWFAwNDA2MTc2RDQgLyBLQU1NNzUwMTMwNUYxMR4wHAYDVQQFExUgLyBLQU1NNzUwMTMwSERGSFlSMDgxDDAKBgNVBAsTA0FKVTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAmCMuw5FoOgn0XD5iIEWMJ48J6yUn/1hzdMM4z2ZaPYudkwtXoF8P3+LWzCa38euClMuwITJsLBbaqa6luIE+louF8iCUcVTi7BJPKSn+Vl4yIosu7XrOx/A4mxVN6hVo86KO/2tgqz3yqu7opCFCbucRGw+bbBnsT1x5rv/whfsCAwEAAaMdMBswDAYDVR0TAQH/BAIwADALBgNVHQ8EBAMCBsAwDQYJKoZIhvcNAQEFBQADggEBAHmuF2Xn3jO1FoWh4ttN/K1meFLi2sQ7s+jRkG2a9MPXWDtSFKtQDG5zZFdyxQNZa57TqFlCpaDgTUorNP7mpyx9zZOJfOsH8qkQ2lOQVQdaqWDNSV4a0SW7Rwes6tiIpqHy0UlELvoGpBt1sI8c7K17WHAnUamTBctB5cnmdq8kctIv0tYze3q7GvnQzbBmSSIapq8ZIB8ihHA3EboxR++NsDHEfzTPaZQ0b+VUbQRpHYIQ5gI0gKN7wuQzLEdn2f6ob51ZXgsciyLeNjATVp+pkniNJMQ7SDoJCVj6OOjZainqs4EdFcaNeQwPgjOWJzJ/c1r7uPdHDpiD3RVIXAE=" subTotal="2500.00" descuento="0.00" total="2750.00" tipoDeComprobante="ingreso" anoAprobacion="2009" noAprobacion="250420110" formaDePago="DIVERSAS"><Emisor rfc="DEM990311EQ7" nombre="EMPRESA DE DEMOSTRACION"><DomicilioFiscal calle="Tehuantepec a&#241;o &#249;no" noExterior="118" colonia="Roma Sur" localidad="meixoc" municipio="Cuauhtemoc" estado="DISTRITO FEDERAL" pais="Mexico" codigoPostal="84989"/><ExpedidoEn pais="Mexico"/></Emisor><Receptor rfc="XEXX010101000" nombre="Cliente Generico"><Domicilio calle="sin direccion" noExterior="SN" pais="Mexico"/></Receptor><Conceptos><Concepto cantidad="25.00" unidad="kg" noIdentificacion="ART25" descripcion="Articulo numero 25" valorUnitario="50.00" importe="1250.00"><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/></Concepto><Concepto cantidad="25.00" unidad="kg" noIdentificacion="ART26" descripcion="Articulo numero 26" valorUnitario="50.00" importe="1250.00"><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/></Concepto></Conceptos><Impuestos totalImpuestosTrasladados="250.00"><Traslados><Traslado impuesto="IVA" tasa="10.00" importe="250.00"/></Traslados></Impuestos><Addenda/></Comprobante>'
--select @XML = '<?xml version="1.0" encoding="UTF-8"?><cfdi:Comprobante xmlns:cfdi="http://www.sat.gob.mx/cfd/3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sat.gob.mx/cfd http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv3.xsd" version="3.0" serie="ABCD" folio="1090" fecha="2011-09-06T16:57:05" sello="PCpVEzeSgN7q/XgxGAk5essnyG2tpMgFf2gJyTSnGI5JWPtOgP1i7nbep1e6AUMJF5jaCb9ZMyVYMzvddPp8/jsV8pPYgF/h60X1K79TuDvPeFtDldHfeFrrfUK0tEPmRxb1vbWwFPPPiTiWjitHdHwlg53XKvhl+NmIkZVte9o=" noCertificado="00001000000102317394" certificado="MIIESzCCAzOgAwIBAgIUMDAwMDEwMDAwMDAxMDIzMTczOTQwDQYJKoZIhvcNAQEFBQAwggE2MTgwNgYDVQQDDC9BLkMuIGRlbCBTZXJ2aWNpbyBkZSBBZG1pbmlzdHJhY2nDs24gVHJpYnV0YXJpYTEvMC0GA1UECgwmU2VydmljaW8gZGUgQWRtaW5pc3RyYWNpw7NuIFRyaWJ1dGFyaWExHzAdBgkqhkiG9w0BCQEWEGFjb2RzQHNhdC5nb2IubXgxJjAkBgNVBAkMHUF2LiBIaWRhbGdvIDc3LCBDb2wuIEd1ZXJyZXJvMQ4wDAYDVQQRDAUwNjMwMDELMAkGA1UEBhMCTVgxGTAXBgNVBAgMEERpc3RyaXRvIEZlZGVyYWwxEzARBgNVBAcMCkN1YXVodGVtb2MxMzAxBgkqhkiG9w0BCQIMJFJlc3BvbnNhYmxlOiBGZXJuYW5kbyBNYXJ0w61uZXogQ29zczAeFw0xMDEyMDcxNzU1NTlaFw0xMjEyMDYxNzU1NTlaMIHrMTAwLgYDVQQDEydDT01FUkNJQUxJWkFET1JBIFhUUkVNRSBQTEFORVQgU0EgREUgQ1YxMDAuBgNVBCkTJ0NPTUVSQ0lBTElaQURPUkEgWFRSRU1FIFBMQU5FVCBTQSBERSBDVjEwMC4GA1UEChMnQ09NRVJDSUFMSVpBRE9SQSBYVFJFTUUgUExBTkVUIFNBIERFIENWMSUwIwYDVQQtExxDWFAwNDA2MTc2RDQgLyBLQU1NNzUwMTMwNUYxMR4wHAYDVQQFExUgLyBLQU1NNzUwMTMwSERGSFlSMDgxDDAKBgNVBAsTA0FKVTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAmCMuw5FoOgn0XD5iIEWMJ48J6yUn/1hzdMM4z2ZaPYudkwtXoF8P3+LWzCa38euClMuwITJsLBbaqa6luIE+louF8iCUcVTi7BJPKSn+Vl4yIosu7XrOx/A4mxVN6hVo86KO/2tgqz3yqu7opCFCbucRGw+bbBnsT1x5rv/whfsCAwEAAaMdMBswDAYDVR0TAQH/BAIwADALBgNVHQ8EBAMCBsAwDQYJKoZIhvcNAQEFBQADggEBAHmuF2Xn3jO1FoWh4ttN/K1meFLi2sQ7s+jRkG2a9MPXWDtSFKtQDG5zZFdyxQNZa57TqFlCpaDgTUorNP7mpyx9zZOJfOsH8qkQ2lOQVQdaqWDNSV4a0SW7Rwes6tiIpqHy0UlELvoGpBt1sI8c7K17WHAnUamTBctB5cnmdq8kctIv0tYze3q7GvnQzbBmSSIapq8ZIB8ihHA3EboxR++NsDHEfzTPaZQ0b+VUbQRpHYIQ5gI0gKN7wuQzLEdn2f6ob51ZXgsciyLeNjATVp+pkniNJMQ7SDoJCVj6OOjZainqs4EdFcaNeQwPgjOWJzJ/c1r7uPdHDpiD3RVIXAE=" subTotal="2500.00" descuento="0.00" total="2750.00" tipoDeComprobante="ingreso" anoAprobacion="2009" noAprobacion="250420110" formaDePago="DIVERSAS"><cfdi:Emisor rfc="DEM990311EQ7" nombre="EMPRESA DE DEMOSTRACION"><cfdi:DomicilioFiscal calle="Tehuantepec a&#241;o &#249;no" noExterior="118" colonia="Roma Sur" localidad="meixoc" municipio="Cuauhtemoc" estado="DISTRITO FEDERAL" pais="Mexico" codigoPostal="84989"/><cfdi:ExpedidoEn pais="Mexico"/></cfdi:Emisor><cfdi:Receptor rfc="XEXX010101000" nombre="Cliente Generico"><cfdi:Domicilio calle="sin direccion" noExterior="SN" pais="Mexico"/></cfdi:Receptor><cfdi:Conceptos><cfdi:Concepto cantidad="25.00" unidad="kg" noIdentificacion="ART25" descripcion="Articulo numero 25" valorUnitario="50.00" importe="1250.00"><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-25" fecha="2011-04-25" aduana="manzanillo"/></cfdi:Concepto><cfdi:Concepto cantidad="25.00" unidad="kg" noIdentificacion="ART26" descripcion="Articulo numero 26" valorUnitario="50.00" importe="1250.00"><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/><cfdi:InformacionAduanera numero="2011-04-26" fecha="2011-04-26" aduana="manzanillo"/></cfdi:Concepto></cfdi:Conceptos><cfdi:Impuestos totalImpuestosTrasladados="250.00"><cfdi:Traslados><cfdi:Traslado impuesto="IVA" tasa="10.00" importe="250.00"/></cfdi:Traslados></cfdi:Impuestos><cfdi:Addenda/></cfdi:Comprobante>'

  IF @XML LIKE '%<cfdi:Comprobante%' SET @EsCFDI = 1
  
  IF @Ok IS NULL
    EXEC speDocXML @@SPID, @Empresa, @Modulo, '', @ID, @PlantillaJasper, @eDocEstatus, 0, 1, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 0, 1

--select convert(xml,@XML), @Ok
    
  SELECT @JaseperPDF = 'Movimiento="' + @Mov + '" ' +
					   'ImporteConLetra="' + @ImporteConLetra + '" ' +
					   'Estatus="' + @Estatus + '" ' +
					   'EmpresaNoInterior="' + dbo.fneDocXmlAUTF8Min(@EmpresaNoInterior,0,1) + '" ' +
					   'ReceptorNoInterior="'+ dbo.fneDocXmlAUTF8Min(@ReceptorNoInterior,0,1) + '" ' +
                       'Comentario1="' + dbo.fneDocXmlAUTF8Min(@Comentario1,0,1) + '" ' + --REQ 14790
                       'Comentario2="' + dbo.fneDocXmlAUTF8Min(@Comentario2,0,1) + '" ' + --REQ 14790
                       'Comentario3="' + dbo.fneDocXmlAUTF8Min(@Comentario3,0,1) + '" ' + --REQ 14790
                       'Comentario4="' + dbo.fneDocXmlAUTF8Min(@Comentario4,0,1) + '" ' + --REQ 14790
                       'Comentario5="' + dbo.fneDocXmlAUTF8Min(@Comentario5,0,1) + '" ' + --REQ 14790
                       'TFDCadenaOriginal="' + @TFDCadenaOriginal + '" ' +
                       'CFDModulo=" '
  SELECT @XML = REPLACE(@XML, 'CFDModulo="', @JaseperPDF)  

  EXEC spCFDFlexRegenerarArchivo @Empresa, @Temporal, @XML, @Ok OUTPUT, @OkRef OUTPUT
  
  IF @EsCFDI = 1
    EXEC spCFDFlexQRCode @Empresa, @Modulo, @ID, @Imagen

  --REQ Q3069 CFDGT
  IF CHARINDEX('<FactDocGT xmlns' + CHAR(58) + 'xsi="http' + CHAR(58) + '//www.w3.org/2001/XMLSchema-instance" xmlns="http' + CHAR(58) + '//www.fact.com.mx/schema/gt"', @XML) = 0
    SELECT @RutaDatosXML = '/Comprobante/Conceptos/Concepto'
  ELSE
    SELECT @RutaDatosXML = '/FactDocGT/Detalles/Detalle'
  --REQ Q3069 CFDGT

--select convert(xml,@XML), @Ok
END
GO
--EXEC spCFDFlexJasperPDF 'DEMO', 'VTAS', 3145, 'C:\CFD\000100\000100 AX3145.XML', 'C:\CFD\000100\000100 AX3145.BMP'
--GO

/**************** fnCFDFlexCadenaOriginalTFDI1 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexCadenaOriginalTFDI1') DROP FUNCTION fnCFDFlexCadenaOriginalTFDI1
GO
CREATE FUNCTION fnCFDFlexCadenaOriginalTFDI1 
	(
	@Modulo				varchar(5),
	@ModuloID			int
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado				varchar(max),
	@Version				varchar(10),
	@UUID					varchar(50),
	@FechaTimbrado			datetime,
	@SelloCFD				varchar(max),
	@NoCertificadoSAT		varchar(50)
    

  SELECT 
    @Version = '1.0',
    @UUID = CONVERT(varchar(100),UUID),
    @FechaTimbrado = FechaTimbrado,
    @SelloCFD = Sello,
    @NoCertificadoSAT = noCertificado
    FROM CFD
   WHERE Modulo = @Modulo
     AND ModuloID = @ModuloID 
     
  SET @Resultado = '||' + RTRIM(LTRIM(@Version)) + '|' + RTRIM(LTRIM(@UUID)) + '|' + RTRIM(LTRIM(dbo.fneDocFormatoFecha(@FechaTimbrado,'AAAA-MM-DDTHH:NN:SSZ'))) + '|' + RTRIM(LTRIM(@SelloCFD)) + '|' + RTRIM(LTRIM(@NoCertificadoSAT)) + '||'   

  RETURN (@Resultado)
END
GO

/**************** fnCFDFlexCadenaOriginalTFDI ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexCadenaOriginalTFDI') DROP FUNCTION fnCFDFlexCadenaOriginalTFDI
GO
CREATE FUNCTION fnCFDFlexCadenaOriginalTFDI 
	(
	@Modulo				varchar(5),
	@ModuloID			int
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado				varchar(max),
	@Version				varchar(10),
	@UUID					varchar(50),
	@FechaTimbrado			datetime,
	@SelloCFD				varchar(max),
	@NoCertificadoSAT		varchar(50)
    

  SELECT 
    @Version = TFDVersion,
    @UUID = CONVERT(varchar(100),UUID),
    @FechaTimbrado = FechaTimbrado,
    @SelloCFD = Sello,
    @NoCertificadoSAT = noCertificadoSAT
    FROM CFD
   WHERE Modulo = @Modulo
     AND ModuloID = @ModuloID 
     
  SET @Resultado = '||' + RTRIM(LTRIM(@Version)) + '|' + RTRIM(LTRIM(@UUID)) + '|' + RTRIM(LTRIM(dbo.fneDocFormatoFecha(@FechaTimbrado,'AAAA-MM-DDTHH:NN:SSZ'))) + '|' + RTRIM(LTRIM(@SelloCFD)) + '|' + RTRIM(LTRIM(@NoCertificadoSAT)) + '||'   

  RETURN (@Resultado)
END
GO

/******************************* spCFDFlexEliminarCorreoElectronico *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexEliminarCorreoElectronico') and type = 'P') drop procedure dbo.spCFDFlexEliminarCorreoElectronico
GO             
CREATE PROCEDURE spCFDFlexEliminarCorreoElectronico
		@NombrePerfil			varchar(50),
		@NombreCuenta			varchar(50)


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  IF EXISTS(SELECT * FROM msdb.dbo.sysmail_profile WHERE name = @NombrePerfil)
    EXECUTE msdb.dbo.sysmail_delete_profile_sp @profile_name = @NombrePerfil

  IF EXISTS(SELECT * FROM msdb.dbo.sysmail_account WHERE name = @NombreCuenta)
    EXECUTE msdb.dbo.sysmail_delete_account_sp @account_name = @NombreCuenta        
END
GO

/******************* xpEscucharSQLAntes *******************/
if OBJECT_ID('dbo.xpEscucharSQLAntes') is not null
  DROP PROCEDURE xpEscucharSQLAntes
GO
CREATE PROCEDURE xpEscucharSQLAntes
		@ID				int = NULL--EMG
AS BEGIN
  DECLARE
	@Expresion	varchar(max),
	@XML		varchar(max),
	@iDatos		int

  IF NULLIF(@ID,0) IS NULL--EMG
    SELECT TOP 1
      @XML = Solicitud, 
      @ID  = ID 
      FROM IntelisisService
      WITH(NOLOCK) 
     WHERE Estatus = 'SINPROCESAR'
       AND Sistema = 'SDK'
       AND Referencia = 'SDK.ReportePDF'
       AND Contenido = 'Solicitud'
  
  IF @ID IS NOT NULL
  BEGIN
    UPDATE IntelisisService SET Estatus = 'PROCESANDO' WHERE ID = @ID
  
    EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML
    SELECT  
      @Expresion = Expresion
      FROM OPENXML (@iDatos, '/Intelisis/Solicitud', 2) WITH (Expresion varchar(max))
    EXEC sp_xml_removedocument @iDatos
  END  
  
  SELECT @Expresion = REPLACE(@Expresion, '<T>', CHAR(39)) --REQ 14790
  SELECT "ID" = @ID, "Expresion" = @Expresion
  
END
GO

/******************* xpEscucharSQLDespues *******************/
if OBJECT_ID('dbo.xpEscucharSQLDespues') is not null
  DROP PROCEDURE xpEscucharSQLDespues
GO
CREATE PROCEDURE xpEscucharSQLDespues
	@ID	int
AS BEGIN
  DECLARE 
    @XML					varchar(max),
    @Empresa				varchar(5),
    @Modulo					varchar(5),
    @ModuloID				int,
    @Mov					varchar(20),
    @Archivo				varchar(255),
    @Para					varchar(255),
    @Asunto					varchar(255),
    @Mensaje				varchar(255),
    @iDatos					int,
    @Sistema				varchar(100),
    @Referencia				varchar(100),
    @Existe					int,
    @TiempoTranscurrido		bit,
    @TiempoLimite			datetime,
    @Enviar					bit,    
    @EnviarXML				bit,
    @EnviarPDF				bit,
    @AlmacenarXML			bit,
    @AlmacenarPDF			bit,    
    @Sucursal				int,
    @NomArch				varchar(255),
    @ArchivoPDF				varchar(255),
    @ArchivoXML				varchar(255),
    @XMLExiste				int,
    @Archivos				varchar(255),
    @Documento				varchar(max),
    @Ok						int,
    @OkRef					varchar(255),    		
	@HtaGenerarPDF			bit, 
	@Jasper					bit,
	@ReportBuilder          bit, --REQ 16770
    @Reporteador            varchar(30),--TASK 17532
    @ReporteIntelisis       bit,--TASK 17532					
    @EnviarAlAfectar		bit
  
  IF @ID IS NOT NULL
  BEGIN  
    SELECT @ArchivoPDF = '', @ArchivoXML = '', @Archivos = '', @Existe = 0, @Ok = NULL, @OkRef = NULL, @XMLExiste = 0
    
    SELECT @XML = Solicitud, @Sistema = Sistema,  @Referencia = Referencia FROM IntelisisService WHERE ID = @ID

    IF @Sistema = 'SDK' AND @Referencia = 'SDK.ReportePDF'
    BEGIN
      EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML
      SELECT  
        @Empresa      = Empresa,
        @Modulo       = Modulo,
        @Mov          = Mov,
        @ModuloID     = ID,
        @NomArch      = NomArch,
        @Archivo      = Archivo,
        @Para         = Para,
        @Asunto       = Asunto,
        @Mensaje      = Mensaje,
        @Sucursal     = Sucursal,
        @Enviar       = CASE WHEN Enviar = 'SI'    THEN 1 ELSE 0 END,
        @AlmacenarPDF = CASE WHEN AlmacenarPDF = 'SI' THEN 1 ELSE 0 END,
        @AlmacenarXML = CASE WHEN AlmacenarXML = 'SI' THEN 1 ELSE 0 END,        
        @EnviarPDF    = CASE WHEN EnviarPDF = 'SI' THEN 1 ELSE 0 END,
        @EnviarXML    = CASE WHEN EnviarXML = 'SI' THEN 1 ELSE 0 END,        
        @HtaGenerarPDF = CASE WHEN HtaGenerarPDF = 'SI' THEN 1 ELSE 0 END
        
        FROM OPENXML (@iDatos, '/Intelisis/Solicitud', 2) WITH (Empresa varchar(5), Modulo varchar(5), Mov varchar(20), Archivo varchar(255), Para varchar(255), Asunto varchar(255), Mensaje varchar(255), EnviarPDF varchar(2), EnviarXML varchar(2), Sucursal int, NomArch varchar(255), ID int, Enviar varchar(2), AlmacenarXML varchar(2), AlmacenarPDF varchar(2),GenerarPdfAfectar varchar(3),HtaGenerarPDF varchar(3))

      EXEC sp_xml_removedocument @iDatos
      
 	  --SELECT @Jasper = ISNULL(Jasper,0) FROM EmpresaCFD WHERE Empresa = @Empresa--TASK 17532
 	  SELECT @Reporteador = Reporteador FROM EmpresaCFD WHERE Empresa = @Empresa--TASK 17532
 	  
 	  IF @Reporteador = 'Jasper Reports' --BUG 17392
        SET @Jasper = 1
      IF @Reporteador = 'Report Builder' --BUG 17392
        SET @ReportBuilder = 1   
      IF @Reporteador = 'Reporteador Intelisis'--TASK 17532
        SET @ReporteIntelisis = 1
        
 ----   /*validar si el pdf se genera o no */
        
   SELECT  @EnviarAlAfectar = EnviarAlAfectar FROM EmpresaCFD WHERE Empresa = @Empresa   
     
     -- IF (@AlmacenarPDF = 1 and @GenerarPdfAfectar=1) or @HtaGenerarPDF =1
      IF (@AlmacenarPDF = 1  AND @EnviarAlAfectar=1) OR (@AlmacenarPDF=1 AND @HtaGenerarPDF =1)
      BEGIN
      
        SET @ArchivoPDF = @Archivo + '.PDF'  

	    IF @Jasper = 0 AND @ReportBuilder = 0 AND @ReporteIntelisis = 0 --TASK 17532
        BEGIN
          SELECT @TiempoTranscurrido = 0, @TiempoLimite = DATEADD(second,10,GETDATE())
          WHILE @Existe = 0 AND @TiempoTranscurrido = 0
          BEGIN        
            EXEC spVerificarArchivo @ArchivoPDF, @Existe OUTPUT
            IF @TiempoLimite < GETDATE() AND @Existe = 0 SET @TiempoTranscurrido = 1
          END  
        END ELSE 
          EXEC spVerificarArchivo @ArchivoPDF, @Existe OUTPUT
		   
        IF @Existe = 1 
        BEGIN
          IF @EnviarPDF = 1 SET @Archivos = @ArchivoPDF + ';' 
          IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = @Modulo AND ID = @ModuloID AND CFD = 1 AND Nombre LIKE '%.pdf')
            INSERT AnexoMov (Sucursal,  Rama,    ID,        Nombre,          Direccion,   Tipo,      Icono, CFD) 
                     VALUES (@Sucursal, @Modulo, @ModuloID, @NomArch+'.pdf', @ArchivoPDF, 'Archivo', 745,   1)          
        END  
      END

     --IF @AlmacenarXML = 1 
     
  
      IF (@AlmacenarXML = 1  AND @EnviarAlAfectar=1) OR (@AlmacenarXML=1 AND @HtaGenerarPDF =1)
      BEGIN
        SET @ArchivoXML = @Archivo + '.XML'
        SELECT @Documento = Documento FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ModuloID

        EXEC spVerificarArchivo @ArchivoXML, @XMLExiste OUTPUT, @Ok OUTPUT, @OkRef OUTPUT   
        IF @XMLExiste = 0 AND @Ok IS NULL
          EXEC spCFDFlexRegenerarArchivo @Empresa, @ArchivoXML, @Documento, @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL 
        BEGIN
          SELECT @Existe = 1
          IF @EnviarXML = 1 SELECT @Archivos = @Archivos + @ArchivoXML  
          IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = @Modulo AND ID = @ModuloID AND CFD = 1 AND Nombre LIKE '%.xml')--AND Nombre = @NomArch)
            INSERT AnexoMov (Sucursal,  Rama,    ID,        Nombre,          Direccion,    Tipo,      Icono, CFD) 
                     VALUES (@Sucursal, @Modulo, @ModuloID, @NomArch+'.xml', @ArchivoXML, 'Archivo',  17,    1)          
        END  
      END

      IF @Existe = 1
      BEGIN
        IF @Reporteador = 'Reporteador Intelisis' --Bug 21329
        BEGIN
          EXEC spVerificarArchivo @ArchivoPDF, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT   
          IF @Existe = 0
            SET @Enviar = 0
        END
        IF @Enviar = 1 AND NULLIF(@Archivos,'') IS NOT NULL
        BEGIN
          EXEC spCFDFlexEnviarCorreo @Empresa, @Para, @Asunto, @Mensaje, @Archivos
        END
        SET @XML = '<Intelisis Sistema="SDK" Contenido="Resultado" Referencia="SDK.ReportePDF" SubReferencia="" Version="">' + 
                   '  <Resultado IntelisisServiceID="' + CONVERT(varchar,@ID) + '" Ok="" OkRef=""/>' +
                   '</Intelisis>'
      
        UPDATE IntelisisService SET Estatus = 'PROCESADO', Resultado = @XML WHERE ID = @ID
      END ELSE
      BEGIN
        UPDATE IntelisisService SET Estatus = 'ERROR', Resultado = @XML WHERE ID = @ID
      END
    END
  END  
  RETURN
END
GO


/******************* spJasperProcesar *******************/
if OBJECT_ID('dbo.spJasperProcesar') is not null
  DROP PROCEDURE spJasperProcesar
GO
CREATE PROCEDURE spJasperProcesar
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@ID			int

  SELECT TOP 1
     @ID = ID
    FROM IntelisisService
    WITH(NOLOCK) 
   WHERE Estatus = 'SINPROCESAR'
     AND Sistema = 'SDK'
     AND Referencia = 'SDK.ReportePDF'
     AND Contenido = 'Solicitud'
  
  IF @ID IS NOT NULL
    EXEC spIntelisisServiceProcesar @ID    
END
GO

/******************* spCrearJobsJasperTrabajo *******************/
if OBJECT_ID('dbo.spCrearJobsJasperTrabajo') is not null
  DROP PROCEDURE spCrearJobsJasperTrabajo
GO
CREATE PROCEDURE spCrearJobsJasperTrabajo
  @Nombre   	varchar(30),
  @BaseDatos   	varchar(30),
  @UsuarioI   	varchar(30)
  
--//WITH ENCRYPTION
 AS
  DECLARE
  @TrabajoID		binary (16),
  @ReturnCode		int,
  @Usuario			varchar(30),
  @Contrasena		varchar(30),
  @Activo			bit,
  @Trabajo 			char(20),
  @Cadena 			varchar(100),
  @Servidor			varchar(30),    
  @HoraInicial		int,
  @HoraFinal		int,
  @Frecuencia		tinyint,
  @Valor			tinyint,
  @Recurrencia		tinyint,  
  @FrecuenciaD		tinyint,
  @ValorD			tinyint,

  @Domingo			bit,
  @Lunes			bit,
  @Martes			bit,
  @Miercoles		bit,
  @Jueves			bit,
  @Viernes			bit,
  @Sabado			bit,
  @Valor2			tinyint,
  @Tipo				tinyint,
  @Dia				tinyint,
  @Fecha2			int,
  
  @Estatus			bit,
  @NombreOriginal	varchar(30)

  BEGIN TRANSACTION
    DECLARE @SQLServerAgent TABLE
    (
    Estatus				varchar(50)
    )

    SELECT @NombreOriginal = ISNULL(@Nombre,'')
    SELECT @Nombre = ISNULL(@Nombre,'') + '.' + @@SERVERNAME + '.' + @BaseDatos
    SELECT @ReturnCode = 0     
    IF (SELECT COUNT(1) FROM msdb.dbo.syscategories WHERE name = '[Uncategorized (Local)]') < 1 --REQ 14790
      EXECUTE msdb.dbo.sp_add_category @name = '[Uncategorized (Local)]'
    
    SELECT @TrabajoID = job_id FROM   msdb.dbo.sysjobs WHERE (name = @Nombre)
    IF (@TrabajoID IS NOT NULL)    
    BEGIN  
       IF (EXISTS (SELECT  * FROM    msdb.dbo.sysjobservers WHERE   (job_id = @TrabajoID) AND (server_id <> 0))) 
         BEGIN 
            RAISERROR ('Unable to import job ''Jasper'' since there is already a multi-server job with this name.', 16, 1) 
            SELECT @ReturnCode = 1     
         END 
       ELSE 
         EXECUTE msdb.dbo.sp_delete_job @job_name = @Nombre 
      SELECT @TrabajoID = NULL
    END 


  IF (@@ERROR = 0 AND @ReturnCode = 0) AND EXISTS(SELECT * FROM JasperTrabajo WHERE Trabajo = @NombreOriginal)
  BEGIN
    IF @ReturnCode = 0 
      EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @TrabajoID OUTPUT , @job_name = @Nombre, @owner_login_name = @Usuario, @description =  @Nombre, @category_name = '[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0

	DECLARE crTrabajo SCROLL CURSOR FOR
	SELECT Trabajo, Usuario, Contrasena, CONVERT(int, SUBSTRING(HoraInicial,1,2) + SUBSTRING(HoraInicial,4,2) + '00'), CONVERT(int, SUBSTRING(HoraFinal,1,2) + SUBSTRING(HoraFinal,4,2) + '00'), CASE Frecuencia WHEN 'Diaria' THEN 4 WHEN 'Semanal' THEN 8 WHEN 'Mensual' THEN 16 WHEN 'Mensual 2' THEN 32 END, Valor, Recurrencia, CASE FrecuenciaD WHEN 'Minutos' THEN 4 WHEN 'Horas' THEN 8 END , ValorD, Activo, Domingo, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, CASE Tipo WHEN 'Primer' THEN 1 WHEN 'Segundo' THEN 2 WHEN 'Tercer' THEN 4 WHEN 'Cuarto' THEN 8 WHEN 'Ultimo' THEN 16 END, CASE Dia WHEN 'Domingo' THEN 1 WHEN 'Lunes' THEN 2 WHEN 'Martes' THEN 3 WHEN 'Miercoles' THEN 4 WHEN 'Jueves' THEN 5 WHEN 'Viernes' THEN 6 WHEN 'Sabado' THEN 7 WHEN 'Día' THEN 8 WHEN 'Día de la semana' THEN 9 WHEN 'Día del fin de semana' THEN 10 END, CONVERT(int, CONVERT(varchar,DATEPART(YEAR,FechaInicial)) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(MONTH,FechaInicial)),2) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(DAY,FechaInicial)),2))
	  FROM JasperTrabajo
	 WHERE Trabajo = @NombreOriginal
	 
	IF ISNULL(@Contrasena,'') = '' 
  		SELECT @Contrasena = 'NULL'

	OPEN crTrabajo

	FETCH NEXT FROM crTrabajo INTO @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2

	WHILE @@FETCH_STATUS = 0 AND @ReturnCode = 0
	BEGIN
--select @Frecuencia = 32
	  SELECT @Valor2 = 0
      IF @Frecuencia = 8
      BEGIN
        IF @Domingo = 1
          SELECT @Valor2 = @Valor2 + 1
        
        IF @Lunes = 1
          SELECT @Valor2 = @Valor2 + 2
        
        IF @Martes = 1
          SELECT @Valor2 = @Valor2 + 4
        
        IF @Miercoles = 1
          SELECT @Valor2 = @Valor2 + 8
         
        IF @Jueves = 1
          SELECT @Valor2 = @Valor2 + 16
        
        IF @Viernes = 1
          SELECT @Valor2 = @Valor2 + 32
        
        IF @Sabado = 1
          SELECT @Valor2 = @Valor2 + 64
      
        SELECT @Valor = @Valor2
      END

      ELSE
      IF @Frecuencia = 32
        SELECT @Valor = @Dia
    

	  SET @cadena 	= 'EXEC spJasperProcesar '
--	  select @Cadena

	  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @TrabajoID, @step_id = 1, @step_name = @Trabajo, @command = @cadena, @database_name = @BaseDatos, @server = '', @database_user_name = '', @subsystem = 'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = '', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2

	  UPDATE JasperTrabajo SET UltimaActualizacion = GETDATE() WHERE Trabajo = @Trabajo
	  
	  FETCH NEXT FROM crTrabajo INTO  @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2
	END

--select @Trabajo Trabajo, @Usuario Usuario, @Contrasena Contrasena, @HoraInicial HoraInicial, @HoraFinal HoraFinal, @Frecuencia Frecuencia, @Valor Valor, @Recurrencia Recurrencia, @FrecuenciaD FrecuenciaD, @ValorD ValorD, @Activo Activo

    IF @ReturnCode = 0
  	  EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @TrabajoID, @start_step_id = 1, @enabled  = @Activo

    IF @ReturnCode = 0
  	  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @TrabajoID, @name = @Nombre, @enabled = @Activo, @freq_type = @Frecuencia, @active_start_date = @Fecha2, @active_start_time = @HoraInicial, @freq_interval = @Valor, @freq_subday_type = @FrecuenciaD , @freq_subday_interval = @ValorD, @freq_relative_interval = @Tipo, @freq_recurrence_factor = @Recurrencia, @active_end_date = 99991231, @active_end_time = @HoraFinal

    IF @ReturnCode = 0
	  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @TrabajoID, @server_name = @@SERVERNAME


  CLOSE crTrabajo
  DEALLOCATE crTrabajo
--select @ReturnCode = 1
  END  
  INSERT @SQLServerAgent (Estatus)
  EXEC master.dbo.xp_ServiceControl 'QUERYSTATE', 'SQLServerAgent'

  IF (SELECT TOP 1 Estatus FROM @SQLServerAgent) = 'Running.' SELECT @Estatus = 1 ELSE SELECT @Estatus = 0

  IF @ReturnCode = 0
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    COMMIT TRANSACTION
  END
  ELSE
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    ROLLBACK TRANSACTION
  END
GO
--EXEC spCrearJobsJasperTrabajo 'Jasper', 'Sucursal', 'DEMO'

/*************** spCFDFlexEnviarCorreo *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexEnviarCorreo') and type = 'P') drop procedure dbo.spCFDFlexEnviarCorreo
GO             
CREATE PROCEDURE spCFDFlexEnviarCorreo
		    @Empresa	varchar(5),
            @Para	    varchar(8000),
		    @Asunto	    varchar(8000),
		    @Mensaje	varchar(8000) = NULL,
		    @Anexos	    varchar(8000) = NULL,
		    @SQL	    varchar(8000) = NULL,
		    @SQLAncho	int 	      = 250,
		    @CC		    varchar(8000) = NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Perfil		varchar(50),
    @ID			int,
    @Fecha		datetime,
    @NombreCorreoEnLote	varchar(100),
	@MedioEnvio varchar(50),
	@Smtp				varchar(50),
	@PuertoCorreo		varchar(50),
	@Usuario			varchar(50),
	@Pasword			varchar(50),
	@RFC				varchar(50),
	@CadenaConexion		varchar(max),
	@RutaIntelisisCFDI	varchar(255),
	@AlmacenarRuta		varchar(200),
	@Shell				varchar(8000),
	@Enviar				bit,  
	@r					varchar(max)

  DECLARE @Datos TABLE (ID int IDENTITY(1,1), Datos varchar(255))



  SELECT @Perfil = NULLIF(DBMailPerfil,'') FROM EmpresaGral WHERE Empresa = @Empresa

  SELECT @MedioEnvio = EnviarMedio FROM  EmpresaCFD  WHERE  Empresa = @Empresa

  SELECT @RutaIntelisisCFDI = RutaIntelisisCFDI, @Enviar =  Enviar FROM EmpresaCFD  WHERE Empresa = @Empresa 

  SELECT @Para    = NULLIF(RTRIM(@Para), ''), 
         @Mensaje = NULLIF(RTRIM(@Mensaje), '') ,---+'nueva prueba reenviar correo' + CONVERT(VARCHAR(24),GETDATE(),113),--rasc  
         @Asunto  = NULLIF(RTRIM(@Asunto), ''),
         @Anexos  = NULLIF(RTRIM(@Anexos), ''),
         @SQL     = NULLIF(RTRIM(@SQL), ''),
         @Fecha   = GETDATE()
  
  IF @Enviar = 1
     BEGIN
	  IF @MedioEnvio = 'SQL Mail'
		 BEGIN
			  IF @Para IS NOT NULL AND @Perfil IS NOT NULL
			  BEGIN
				IF @SQL IS NOT NULL
				  EXEC spEnviarDBMail @Perfil, @Para, @CC = @CC, @Asunto = @Asunto, @Adjuntos = @Anexos,@Mensaje = @Mensaje, @Formato = 'HTML', @SQL = @SQL, @SQLAncho = @SQLAncho
				ELSE
				  EXEC spEnviarDBMail @Perfil, @Para, @CC = @CC, @Asunto = @Asunto, @Adjuntos = @Anexos, @Mensaje = @Mensaje, @Formato = 'HTML'

				SELECT @NombreCorreoEnLote = NombreCorreoEnLote FROM Version
				EXEC spOutlook @NombreCorreoEnLote, @Fecha, @Asunto, @Mensaje, @Anexos, @EnSilencio = 1, @ID = @ID OUTPUT
				EXEC spOutlookPara @ID, @Para
			  END
		 END
	  IF @MedioEnvio = 'IntelisisCFDI'
		 BEGIN  
			  IF SUBSTRING(@Anexos,LEN(@Anexos),1) = ';' SELECT @Anexos = STUFF(@Anexos,LEN(@Anexos),1,'')
	
			  SELECT @RFC=RFC FROM EMPRESA WHERE EMPRESA = @Empresa
	
			  SELECT @Usuario      = EnviarUsuario,
			         @Pasword      = EnviarContrasena,
			         @Smtp         = EnviarSmtp,
			         @PuertoCorreo = EnviarPuerto 
		        FROM EmpresaCFD 
		       WHERE Empresa=@Empresa 
    
			  SELECT @CadenaConexion = '<IntelisisCFDI>'+
								       '<IDSESION>'+convert(varchar,@@SPID)+'</IDSESION>'+
								       '<FECHA>'+Convert (varchar,GETDATE())+'</FECHA>'+
							           '<SERVIDOR>INTELISIS</SERVIDOR>'+
								       '<USUARIO>'+@Usuario+'</USUARIO>'+
								       '<PASSWORD>'+@Pasword+'</PASSWORD>'+
								       '<CUENTA>'+ISNULL(@Para,'')+'</CUENTA>'+						     
								       '<ACCION>ENVIARCORREO</ACCION>'+						     
								       '<RFC>'+@RFC+'</RFC>'+	
								       '<ASUNTO>'+@Asunto+'</ASUNTO>'+
								       '<SMTP>'+@Smtp+'</SMTP>'+		                 
								       '<PUERTO>'+@PuertoCorreo+'</PUERTO>'+
								       '<MENSAJE>'+@Mensaje+'</MENSAJE>'+		                 
								       '<RUTAARCHIVO>'+@Anexos+'</RUTAARCHIVO>'+				            
								       '</IntelisisCFDI>'

			  SELECT @Shell = CHAR(34)+CHAR(34)+@RutaIntelisisCFDI+CHAR(34)+' '+CHAR(34)+@CadenaConexion+CHAR(34)+CHAR(34)
			  INSERT @Datos
			  EXEC @r =  xp_cmdshell @Shell--, no_output
		 END
     END
END

GO


/**************** xpCFDFlexAlmacenar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDFlexAlmacenar') and type = 'P') drop procedure dbo.xpCFDFlexAlmacenar
GO             
CREATE PROCEDURE xpCFDFlexAlmacenar
			@Modulo			char(5),
			@ID				int,
			@Usuario		varchar(10),
			@Adicional		bit,
			@XML			bit OUTPUT, 
			@PDF			bit OUTPUT,
			@Nomarch		varchar(255) OUTPUT,
			@Reporte		varchar(100) OUTPUT,
			@Ruta			varchar(255) OUTPUT,
		    @EnviarPara		varchar(255) OUTPUT,
			@EnviarAsunto	varchar(255) OUTPUT,
			@EnviarMensaje	varchar(255) OUTPUT,
			@Cliente		varchar(10)  OUTPUT,
			@Sucursal		int OUTPUT,
			@Enviar			bit          OUTPUT,
			@EnviarXML		bit			 OUTPUT,
			@EnviarPDF		bit			 OUTPUT			
AS BEGIN
  RETURN
END
GO





/******************************* spCFDFlexGenerarPDF *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexGenerarPDF') and type = 'P') drop procedure dbo.spCFDFlexGenerarPDF
GO             
CREATE PROCEDURE spCFDFlexGenerarPDF
		@Empresa			varchar(5),
		@Modulo				varchar(5),
		@Mov				varchar(20),		
		@ID					int,
		@Usuario			varchar(10),
		@Adicional			bit = 0,
		@IDIS				int = NULL OUTPUT, 

		@Ok					int = NULL OUTPUT,
		@OkRef				varchar(255) = NULL OUTPUT,
		@HtaGenerarPDF         bit=0


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Datos					varchar(max),
    @Procesado				bit,
    @Reporte				varchar(100),
    @Contacto				varchar(10),
    @eMail					varchar(255),
    @Para					varchar(255),
    @Asunto					varchar(max),
    @Mensaje				varchar(max),
    @Contrasena				varchar(32),
    @AlmacenarXML				bit,
    @AlmacenarPDF				bit,    
    @EnviarXML				bit,
    @EnviarPDF				bit,
    @Archivo				varchar(255),
    @NomArch				varchar(255),
    @Ruta					varchar(255),
    @Sucursal				int,
    @PDFExiste				int,
    @ArchivoPDF				varchar(255),
    @Enviar					bit,
    @JasperFueraLinea		bit, --EMG
    @Procesar				bit, --EMG   
    @EnviarAlAfectar		bit

  SELECT @Reporte = NULL, @Para = '', @Asunto = NULL, @Mensaje = NULL, @Contrasena = NULL, @EnviarXML = NULL, @EnviarPDF = NULL, @PDFExiste = 0, @Enviar = 0
  
  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
 
      
  EXEC spCFDFlexAlmacenar @Modulo, @ID, @Usuario, @Adicional, @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, @Archivo OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @Para OUTPUT, @Asunto OUTPUT, @Mensaje OUTPUT, @Contacto OUTPUT, @Sucursal OUTPUT , @Enviar OUTPUT, @EnviarXML OUTPUT, @EnviarPDF OUTPUT
  
  SET @NomArch = @Archivo
  SET @Archivo = @Ruta + '\' + @Archivo
  SET @ArchivoPDF = @Archivo + '.PDF'
    
  --IF @Reporte IS NULL RETURN
      
  IF NULLIF(@Para,'') IS NULL AND @Enviar = 1 SELECT @Enviar = 0, @EnviarPDF = 0, @EnviarXML = 0
  
  EXEC spVerificarArchivo @ArchivoPDF, @PDFExiste OUTPUT, @Ok OUTPUT, @OkRef OUTPUT   
       
   SELECT  @EnviarAlAfectar = EnviarAlAfectar FROM EmpresaCFD WHERE Empresa = @Empresa  
  --IF  @GenerarPdfAfectar = 1 OR @AlmacenarXML = 1 Or @HtaGenerarPDF =1 AND @Ok IS NULL
  IF    @AlmacenarXML = 1 Or @HtaGenerarPDF =1 AND @Ok IS NULL
  BEGIN
    EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT  
    
    SET @Datos = '<?xml version="1.0" encoding="Windows-1252"?><Intelisis Sistema="SDK" Contenido="Solicitud" Referencia="SDK.ReportePDF" SubReferencia="" Version="1.0">' + 
                 '  <Solicitud>' +
                 '    <Expresion>' + CASE WHEN (@AlmacenarPDF = 1) AND (@PDFExiste = 0) AND NULLIF(@Reporte,'') IS NOT NULL THEN '<![CDATA[ReportePDF(' + CHAR(39) + @Reporte + CHAR(39) + ',' + CONVERT(varchar,ISNULL(@ID,0)) + ',' + '<T>' + @Archivo + '<T>' + ')]]>' ELSE 'Asigna(Temp.Num,Temp.Num)' END + '</Expresion>' +  --REQ 14790
                 '    <Empresa>' + dbo.fneDocXmlAUTF8Min(RTRIM(ISNULL(@Empresa,'')),0,1) + '</Empresa>' +               
                 '    <Sucursal>' + RTRIM(ISNULL(CONVERT(varchar,@Sucursal),'')) + '</Sucursal>' +                                
                 '    <Modulo>' + RTRIM(ISNULL(@Modulo,'')) + '</Modulo>' +
                 '    <Mov>' + RTRIM(ISNULL(@Mov,'')) + '</Mov>' +               
                 '    <ID>' + RTRIM(CONVERT(varchar,@ID)) + '</ID>' +                        
                 '    <NomArch>' + dbo.fneDocXmlAUTF8Min(RTRIM(ISNULL(@NomArch,'')),0,1) + '</NomArch>' +                                      
                 '    <Archivo>' + dbo.fneDocXmlAUTF8Min(RTRIM(ISNULL(@Archivo,'')),0,1) + '</Archivo>' +               
                 '    <Para>' + dbo.fneDocXmlAUTF8Min(RTRIM(ISNULL(@Para,'')),0,1) + '</Para>' +                              
                 '    <Asunto>' + dbo.fneDocXmlAUTF8Min(RTRIM(ISNULL(@Asunto,'')),0,1) + '</Asunto>' +                                             
                 '    <Mensaje>' + dbo.fneDocXmlAUTF8Min(RTRIM(ISNULL(@Mensaje,'')),0,1) + '</Mensaje>' +                                                            
                 '    <AlmacenarPDF>' + CASE WHEN @AlmacenarPDF = 1 THEN 'SI' ELSE 'NO' END + '</AlmacenarPDF>' +                                                                                              
                 '    <AlmacenarXML>' + CASE WHEN @AlmacenarXML = 1 THEN 'SI' ELSE 'NO' END + '</AlmacenarXML>' +                                                                             
                 '    <Enviar>' + CASE WHEN @Enviar = 1 THEN 'SI' ELSE 'NO' END + '</Enviar>' +                                                                                                               
                 '    <EnviarPDF>' + CASE WHEN @EnviarPDF = 1 THEN 'SI' ELSE 'NO' END + '</EnviarPDF>' +                                                                                              
                 '    <EnviarXML>' + CASE WHEN @EnviarXML = 1 THEN 'SI' ELSE 'NO' END + '</EnviarXML>' +                   
                 '    <HtaGenerarPDF>' + CASE WHEN @HtaGenerarPDF  = 1 THEN 'SI' ELSE 'NO' END + '</HtaGenerarPDF>' +                                                          
                 '  </Solicitud>' +
                 '</Intelisis>'

 --EMG
    SELECT @JasperFueraLinea = ISNULL(JasperFueraLinea,0) FROM EmpresaCFD WHERE Empresa = @Empresa
    IF @JasperFueraLinea = 1 
      SELECT @Procesar = 0
    ELSE
      SELECT @Procesar = 1
 --EMG
    IF @Ok IS NULL
      EXEC spIntelisisService @Usuario, @Contrasena, @Datos, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Procesar, 0, @IDIS OUTPUT--EMG

  --IF @Ok = 71660 SET @Ok = NULL --EMG
  END
  
END
GO


--SELECT * FROM ANEXOMOV
/******************************* spCFDFlexGenerarPDFS *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexGenerarPDFS') and type = 'P') drop procedure dbo.spCFDFlexGenerarPDFS
GO             
CREATE PROCEDURE spCFDFlexGenerarPDFS
		@Estacion			int,
		@EmpresaEstacion	varchar(5),
		@Usuario			varchar(10)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @RutaTemporal	varchar(255),
    @Modulo			varchar(5),
    @ModuloID		int,
    @Empresa		varchar(5), 
    @Mov			varchar(20),
    @MovID			varchar(20),
    @Archivo		varchar(255),
    @IDIS			int,
    @Contacto		varchar(10),
    @AlmacenarTipo	varchar(20),
    @Ok				int,
    @OkRef			varchar(255)
   
   
  SELECT @RutaTemporal = RutaTemporal FROM EmpresaCFD WHERE Empresa = @EmpresaEstacion
   
  DECLARE crListaModuloID CURSOR FOR
   SELECT Modulo, ID
     FROM ListaModuloID
    WHERE Estacion = @Estacion

  OPEN crListaModuloID
  FETCH NEXT FROM crListaModuloID INTO @Modulo, @ModuloID
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    IF @Modulo = 'VTAS' SELECT @Empresa = Empresa, @Mov = Mov, @MovID = MovID, @Contacto = Cliente FROM Venta WHERE ID = @ModuloID ELSE
    IF @Modulo = 'CXC'  SELECT @Empresa = Empresa, @Mov = Mov, @MovID = MovID, @Contacto = Cliente FROM CXC   WHERE ID = @ModuloID
  
    IF @Ok IS NULL
    BEGIN      

      SELECT @AlmacenarTipo = NULL
      SELECT @AlmacenarTipo = NULLIF(AlmacenarTipo,'') FROM CteCFD WHERE Cliente = @Contacto 
   
      EXEC spCFDFlexGenerarPDF @Empresa, @Modulo, @Mov, @ModuloID, @Usuario, 0, @IDIS OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,1

      IF @AlmacenarTipo = 'Adicional'
        EXEC spCFDFlexGenerarPDF @Empresa, @Modulo, @Mov, @ModuloID, @Usuario, 1, @IDIS OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,1            

    END

    IF @Ok IS NULL
    BEGIN
      UPDATE CFD SET GenerarPDF = 1 WHERE Modulo = @Modulo AND ModuloID = @ModuloID
      IF @@ERROR <> 0 SET @Ok = 1
    END  
      
    FETCH NEXT FROM crListaModuloID INTO @Modulo, @ModuloID
  END
  CLOSE crListaModuloID
  DEALLOCATE crListaModuloID         
  
  DELETE FROM ListaModuloID WHERE Estacion = @Estacion
END
GO

--/* DEMO */ spCFDFlexGenerarPDFS 1, 'DEMO', 'DEMO'

--REQ 14790
/******************************* spCFDFlexGenerarPDFSinTransaccion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexGenerarPDFSinTransaccion') and type = 'P') drop procedure dbo.spCFDFlexGenerarPDFSinTransaccion
GO             
CREATE PROCEDURE spCFDFlexGenerarPDFSinTransaccion
		@Modulo				varchar(5),
		@ID					int,
		@Accion				char(20),
		@Usuario			varchar(10),
		@Ok					int = NULL OUTPUT,
		@OkRef				varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa				varchar(5),
    @Mov					varchar(20),
    @Contacto				varchar(10),
    @Estatus				varchar(15),
    @CFDFlex				bit,
    @CFDFlexMovTipo			bit,
    @EnviarAlAfectar		bit,    
    @AlmacenarTipo			varchar(20),
    @MovTipoCFDFlexEstatus	varchar(15)

  IF @Modulo = 'VTAS'
    SELECT @Empresa = Empresa, @Mov = Mov, @Contacto = Cliente, @Estatus = Estatus FROM Venta WHERE ID = @ID
  ELSE
  IF @Modulo = 'CXC'
    SELECT @Empresa = Empresa, @Mov = Mov, @Contacto = Cliente, @Estatus = Estatus FROM Cxc WHERE ID = @ID
  
  SELECT @CFDFlex = ISNULL(CFDFlex,0) FROM EmpresaGral WHERE Empresa = @Empresa  
  SELECT @CFDFlexMovTipo = ISNULL(CFDFlex,0) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  SELECT @EnviarAlAfectar = ISNULL(EnviarAlAfectar,0) FROM EmpresaCFD WHERE Empresa = @Empresa  

  SELECT @MovTipoCFDFlexEstatus = NULLIF(Estatus,'') FROM MovTipoCFDFlex WHERE Modulo = @Modulo AND Mov = @Mov AND Contacto = @Contacto

  IF @MovTipoCFDFlexEstatus IS NULL
    SELECT @MovTipoCFDFlexEstatus = NULLIF(Estatus,'') FROM MovTipoCFDFlex WHERE Modulo = @Modulo AND Mov = @Mov AND ISNULL(NULLIF(ISNULL(NULLIF(Contacto,''),'(Todos)'),'(Todos)'),@Contacto) = @Contacto
  
  IF (@Ok IS NULL AND @EnviarAlAfectar = 1 AND @CFDFlex = 1 AND @CFDFlexMovTipo = 1 AND @MovTipoCFDFlexEstatus IS NOT NULL)
	IF @Estatus = @MovTipoCFDFlexEstatus OR (@MovTipoCFDFlexEstatus = '(VARIOS)' AND (@Estatus IN (SELECT NULLIF(Estatus,'') FROM MovTipoCFDFlexEstatus WHERE Modulo = @Modulo AND Mov = @Mov AND Contacto = @Contacto) OR @Estatus IN (SELECT NULLIF(Estatus,'') FROM MovTipoCFDFlexEstatus WHERE Modulo = @Modulo AND Mov = @Mov AND ISNULL(NULLIF(ISNULL(NULLIF(Contacto,''),'(Todos)'),'(Todos)'),@Contacto) = @Contacto)))
	BEGIN
	  SELECT @AlmacenarTipo = NULL
	  SELECT @AlmacenarTipo = NULLIF(AlmacenarTipo,'') FROM CteCFD WHERE Cliente = @Contacto 
   
    EXEC spCFDFlexGenerarPDF @Empresa, @Modulo, @Mov, @ID, @Usuario, 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    
    IF @AlmacenarTipo = 'Adicional'
      EXEC spCFDFlexGenerarPDF @Empresa, @Modulo, @Mov, @ID, @Usuario, 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      
  END  
  
END
GO

/******************************* spHabilitarProcedimientosOle *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocHabilitarProcedimientosOle') AND TYPE = 'P')
DROP PROCEDURE speDocHabilitarProcedimientosOle
GO
CREATE PROCEDURE speDocHabilitarProcedimientosOle  
--//WITH ENCRYPTION
AS  
BEGIN  
  EXEC sp_configure 'show advanced option', '1'  
  RECONFIGURE  
  EXEC sp_configure 'Ole Automation Procedures', '1'  
  RECONFIGURE  
END  
GO

/**************** fnFragmentarRuta ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFragmentarRuta') DROP FUNCTION fnFragmentarRuta
GO
CREATE FUNCTION fnFragmentarRuta 
	(
	@Ruta				varchar(255)
	)
RETURNS @Directorios TABLE
        (
		Directorio			varchar(255) COLLATE DATABASE_DEFAULT
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Longitud			bigint,
  @Contador			bigint,
  @Caracter			char(1),
  @Directorio		varchar(255),
  @Estado			int,
  @EstadoAnterior	int
  
  SELECT @Longitud = LEN(@Ruta), @Contador = 1, @Caracter = NULL, @Directorio = '', @Estado = 0
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @Caracter = SUBSTRING(@Ruta,@Contador,1)
    SET @EstadoAnterior = @Estado    
    SET @Estado = CASE 
      WHEN @Estado = 0 AND @Caracter = '\'         THEN 1
      ELSE @Estado
    END

    IF @Estado = 0
    BEGIN
      SET @Directorio = @Directorio + @Caracter
    END
    IF @Estado = 1
    BEGIN
      INSERT @Directorios (Directorio) VALUES (@Directorio)    
      SET @Directorio = @Directorio + @Caracter
      SET @Estado = 0
    END

    
    SET @Contador = @Contador + 1
  END
  
  IF @Caracter <> '\'   
    INSERT @Directorios (Directorio) VALUES (@Directorio)    

  DELETE FROM @Directorios WHERE NULLIF(Directorio,'') IS NULL
  DELETE FROM @Directorios WHERE NULLIF(Directorio,'') = '\'
  DELETE FROM @Directorios WHERE NULLIF(Directorio,'') LIKE '\\%' AND CHARINDEX('\',SUBSTRING(Directorio,3,LEN(Directorio)-2)) = 0

  RETURN
END
GO

/******************************* spCrearDirectorio *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCrearDirectorio') AND TYPE = 'P')
DROP PROCEDURE spCrearDirectorio
GO
CREATE PROCEDURE spCrearDirectorio    
	(    
	@Directorio			varchar(255),    
 	@Ok					int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS    
BEGIN    
  DECLARE  
  @ResultadoOLE					int,
  @ManejadorObjeto				int,
  @ManejadorDirectorio			int,  
  @Existe						int          
  
  SET @ManejadorDirectorio = NULL  
  SET @Existe = 0
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Directorio   

  --Verifica si existe un directorio
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'FolderExists', @Existe OUT, @Directorio
  IF @ResultadoOLE <> 0 SELECT @Ok = 71640, @OkRef = @Directorio       
    
  --Elimina un archivo de texto    
  IF ISNULL(@Existe,0) = 0
  BEGIN
  --Crea el directorio
    EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'CreateFolder', @ManejadorDirectorio OUT, @Directorio
    IF @ResultadoOLE <> 0 SELECT @Ok = 71640, @OkRef = @Directorio       
  END

  IF @ManejadorDirectorio IS NOT NULL
  BEGIN
    EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorDirectorio
    IF @ResultadoOLE <> 0 SELECT @Ok = 71640, @OkRef = @Directorio
  END
  
  EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
  IF @ResultadoOLE <> 0 SELECT @Ok = 71640, @OkRef = @Directorio
    
END
go

/******************************* spCrearRuta *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCrearRuta') AND TYPE = 'P')
DROP PROCEDURE spCrearRuta
GO
CREATE PROCEDURE spCrearRuta    
	(    
	@Ruta				varchar(255),    
 	@Ok					int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS    
BEGIN    
  DECLARE  
    @Directorio				varchar(255)
    
  DECLARE crDirectorios CURSOR FOR
   SELECT Directorio
     FROM dbo.fnFragmentarRuta(@Ruta)

  OPEN crDirectorios
  FETCH NEXT FROM crDirectorios INTO @Directorio
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    EXEC spCrearDirectorio @Directorio, @Ok OUTPUT, @OkRef OUTPUT
    FETCH NEXT FROM crDirectorios INTO @Directorio
  END
  CLOSE crDirectorios
  DEALLOCATE crDirectorios
        
END
go

-- 12336
/******************************* spCopiarArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCopiarArchivo') AND TYPE = 'P')
DROP PROCEDURE spCopiarArchivo
GO
CREATE PROCEDURE spCopiarArchivo(
			@Origen				varchar(255),    
			@Destino			varchar(255), 
			
			@Ok					int			 = NULL OUTPUT,
			@OkRef				varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS    
BEGIN    
  DECLARE @ResultadoOLE		int,
		  @ManejadorObjeto	int,    
		  @IDArchivo		int
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  --IF @ResultadoOLE <> 0 RAISERROR('No es posible abrir el objeto OLE %s.',10,1,'Scripting.FileSystemObject')    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Origen   
  
  --Copiamos el archivo
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'CopyFile', null, @Origen, @Destino
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Origen 
END
GO

/******************************* spCrearArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCrearArchivo') AND TYPE = 'P')
DROP PROCEDURE spCrearArchivo
GO
CREATE PROCEDURE spCrearArchivo    
	(    
	@Archivo			varchar(255),    
	@ManejadorObjeto   int OUTPUT,    
	@IDArchivo			int OUTPUT,
 	@Ok				int = NULL OUTPUT,
	@OkRef			varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS    
BEGIN    
  DECLARE  @ResultadoOLE   int    
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  --IF @ResultadoOLE <> 0 RAISERROR('No es posible abrir el objeto OLE %s.',10,1,'Scripting.FileSystemObject')    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Archivo   
  
  --Crea un archivo de texto    
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'CreateTextFile', @IDArchivo OUT, @Archivo, 8, 0    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Archivo       
      
END
go

-- 11326
/******************************* spInsertaTextoEnArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spInsertaTextoEnArchivo') AND TYPE = 'P') DROP PROCEDURE spInsertaTextoEnArchivo
GO
CREATE PROCEDURE spInsertaTextoEnArchivo
    (  
    @IDArchivo		int,  
    @Cadena			varchar(max),
 	@Ok				int = NULL OUTPUT,
	@OkRef			varchar(255) = NULL OUTPUT            
    )
--//WITH ENCRYPTION
AS  
BEGIN  
  DECLARE
    @ResultadoOLE	int
    
  --Inserta una Linea al archivo  
  EXECUTE @ResultadoOLE = sp_OAMethod @IDArchivo, 'Write', NULL, @Cadena
  IF @ResultadoOLE <> 0 SET @Ok = 710520  
END  
GO

/******************************* spInsertaEnArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spInsertaEnArchivo') AND TYPE = 'P')
DROP PROCEDURE spInsertaEnArchivo
GO  
CREATE PROCEDURE spInsertaEnArchivo  
    (  
    @IDArchivo		int,  
    @Cadena		varchar(max),
 	@Ok				int = NULL OUTPUT,
	@OkRef			varchar(255) = NULL OUTPUT            
    )  
--//WITH ENCRYPTION
AS  
BEGIN  
  DECLARE
    @ResultadoOLE	int,
    @CadenaXML		xml

  SELECT @CadenaXML = CONVERT(xml,REPLACE(@Cadena, 'Ã?','A'))
  SELECT @Cadena = '<?xml version="1.0" encoding="UTF-8"?>' + CONVERT(varchar(max),@CadenaXML)

  --Inserta una Linea al archivo  
  EXECUTE @ResultadoOLE = sp_OAMethod @IDArchivo, 'Write', NULL, @Cadena
  IF @ResultadoOLE <> 0 SET @Ok = 710520  
END  
GO

/******************************* spInsertaEnArchivo2 *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spInsertaEnArchivo2') AND TYPE = 'P')
DROP PROCEDURE spInsertaEnArchivo2
GO  
CREATE PROCEDURE spInsertaEnArchivo2  
    (  
    @IDArchivo		int,  
    @Cadena		varchar(MAX),
    @Ok				int = NULL OUTPUT,
    @OkRef			varchar(255) = NULL OUTPUT            
    )  
--//WITH ENCRYPTION
AS  
BEGIN  
  DECLARE
    @ResultadoOLE	int
  

  
  --Inserta una Linea al archivo  
  EXECUTE @ResultadoOLE = sp_OAMethod @IDArchivo, 'Write', NULL, @Cadena    
  IF @ResultadoOLE <> 0 SET @Ok = 710520  
END  
GO

/******************************* spCerrarArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCerrarArchivo') AND TYPE = 'P')
DROP PROCEDURE spCerrarArchivo
GO  
CREATE PROCEDURE spCerrarArchivo  
    (  
    @IDArchivo			int,
    @ManejadorObjeto	int,    
	@Ok					int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT     
    )  
--//WITH ENCRYPTION
AS  
BEGIN  
  DECLARE  @ResultadoOLE  int    
  
  --Inserta una Linea al archivo  
  EXECUTE @ResultadoOLE = sp_OAMethod @IDArchivo, 'Close'
  IF @ResultadoOLE <> 0 SELECT @Ok = 71540
  
  EXECUTE @ResultadoOLE = sp_OADestroy @IDArchivo
  IF @ResultadoOLE <> 0 SELECT @Ok = 71540, @OkRef = 'Close'
    
  EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
  IF @ResultadoOLE <> 0 SELECT @Ok = 71540, @OkRef = 'Close'
  
END  
GO

/******************************* spVerificarArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spVerificarArchivo') AND TYPE = 'P')
DROP PROCEDURE spVerificarArchivo
GO
CREATE PROCEDURE spVerificarArchivo    
	(    
	@Archivo			varchar(255),    
	@Existe				int = 0 OUTPUT,
 	@Ok					int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS    
BEGIN    
  DECLARE  
  @ResultadoOLE		int,
  @ManejadorObjeto	int
    
  SET @Existe = 0
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Archivo   

  --Verifica si existe un archivo   
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'FileExists', @Existe OUT, @Archivo
  IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @Archivo       

  EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
  IF @ResultadoOLE <> 0 SELECT @Ok = 71530, @OkRef = @Archivo
    
  --IF @Existe = 1
  --BEGIN  
  --  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'Close'
  --  IF @ResultadoOLE <> 0 SELECT @Ok = 71540, @OkRef = @Archivo       
  --END

END
go

--DECLARE @Existe			int
--EXEC spVerificarArchivo 'C' + CHAR(58) + '\PruebasCFD\Temp\DEMO_VTAS_Factura_G168.PDF', @Existe OUTPUT
--SELECT @Existe

/******************************* spEliminarArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spEliminarArchivo') AND TYPE = 'P')
DROP PROCEDURE spEliminarArchivo
GO
CREATE PROCEDURE spEliminarArchivo    
	(    
	@Archivo			varchar(255),    
 	@Ok					int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS    
BEGIN    
  DECLARE  
  @ResultadoOLE		int,
  @ManejadorObjeto	int,
  @Existe			int          
    
  SET @Existe = 0
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Archivo   

  --Verifica si existe un archivo   
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'FileExists', @Existe OUT, @Archivo
  IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @Archivo       
    
  --Elimina un archivo de texto    
  IF @Existe = 1
  BEGIN
    EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'DeleteFile', NULL, @Archivo
    IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @Archivo       
  END
  
  EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
  IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @Archivo  
    
END
go

/**************** spRegenerarArchivo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRegenerarArchivo') and type = 'P') drop procedure dbo.spRegenerarArchivo
GO             
CREATE PROCEDURE spRegenerarArchivo
		@Archivo		varchar(255),	
		@XML			varchar(max),
		@Ok			int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ManejadorObjeto			int,
    @IDArchivo					int,
    @Shell						varchar(max)

  DECLARE @Datos TABLE
  (
  Datos		varchar(255)
  )

  SELECT @ManejadorObjeto = NULL, @IDArchivo = NULL

  IF @Ok IS NULL      
    EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL      
    EXEC spCrearArchivo @Archivo, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL  
    EXEC spInsertaEnArchivo2 @IDArchivo, @XML, @Ok OUTPUT, @OkRef OUTPUT  
    
  IF @Ok IS NULL
    EXEC spCerrarArchivo @IDArchivo, @ManejadorObjeto, @Ok OUTPUT, @OkRef OUTPUT  
 
END
GO

/******************************* spCFDFlexCrearArchivo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexCrearArchivo') and type = 'P') drop procedure dbo.spCFDFlexCrearArchivo
GO             
CREATE PROCEDURE spCFDFlexCrearArchivo
		@Archivo		varchar(255),
		@XML			varchar(max),
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ManejadorObjeto			int,
    @IDArchivo					int

    
  SELECT @ManejadorObjeto = NULL, @IDArchivo = NULL
    
  IF @Ok IS NULL      
    EXEC spCrearArchivo @Archivo, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL  
    EXEC spInsertaEnArchivo @IDArchivo, @XML, @Ok OUTPUT, @OkRef OUTPUT  
    
  IF @Ok IS NULL
    EXEC spCerrarArchivo @IDArchivo, @ManejadorObjeto, @Ok OUTPUT, @OkRef OUTPUT  
  
END
GO


--arcc
--DECLARE 
--  @Ok		int,
--  @OkRef	varchar(255)
  
--EXEC spCFDFlexCrearArchivoBCP 54, 'C' + CHAR(58) + '\PruebaUTF8.TXT', 'HOLA', @Ok OUTPUT, @OkRef OUTPUT
--select @ok, @okref

/******************************* spCFDFlexCrearArchivoBCP *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexCrearArchivoBCP') and type = 'P') drop procedure dbo.spCFDFlexCrearArchivoBCP
GO             
CREATE PROCEDURE spCFDFlexCrearArchivoBCP
		@Estacion		int,
		@Archivo		varchar(255),
		@XML			varchar(max),
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ManejadorObjeto			int,
    @IDArchivo					int,
    @Shell						varchar(8000)

  --SELECT @Shell = 'bcp "SELECT TOP 1 Datos FROM '+'TT.dbo.'+'CFDTemp WHERE Estacion = '+ CONVERT(varchar,@Estacion) +'"  queryout '+@RutaTemp + @NombreArchivo+' -c -T'

  DELETE FROM ArchivoTemp WHERE Estacion = @Estacion
  
  INSERT ArchivoTemp (Estacion, Datos) VALUES (@Estacion, @XML)
  
  SELECT @Shell = 'BCP "SELECT Datos FROM Desarrollo3500.dbo.ArchivoTemp WHERE Estacion = ' + CONVERT(varchar,@Estacion) + '"  queryout '+ @Archivo + ' -c -Cutf-16 -T'    
  EXEC xp_cmdshell @Shell
    
  SET @shell = 'C' + CHAR(58) + '\charsc ' + @Archivo +  ' /scs=utf-16 /dcs=utf-8 /replace'    

  EXEC xp_cmdshell @Shell
    
END
GO
    
/******************************* spCFDFlexRegenerarArchivo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexRegenerarArchivo') and type = 'P') drop procedure dbo.spCFDFlexRegenerarArchivo
GO             
CREATE PROCEDURE spCFDFlexRegenerarArchivo
		@Empresa		varchar(5),
		@Archivo		varchar(255),	
		@XML			varchar(max),
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ManejadorObjeto			int,
    @IDArchivo					int,
    @RutaANSIToUTF				varchar(255),
    @Shell						varchar(8000)

  DECLARE @Datos TABLE
  (
  Datos		varchar(255)
  )

  SELECT @ManejadorObjeto = NULL, @IDArchivo = NULL
  
  SELECT @RutaANSIToUTF = RutaANSIToUTF FROM EmpresaCFD WHERE Empresa = @Empresa  

  IF @Ok IS NULL      
    EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL      
    EXEC spCrearArchivo @Archivo, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL  
    EXEC spInsertaEnArchivo @IDArchivo, @XML, @Ok OUTPUT, @OkRef OUTPUT  
    
  IF @Ok IS NULL
    EXEC spCerrarArchivo @IDArchivo, @ManejadorObjeto, @Ok OUTPUT, @OkRef OUTPUT  

  IF @Ok IS NULL
  BEGIN
    SET @Shell = CHAR(34)+CHAR(34)+RTRIM(LTRIM(@RutaANSIToUTF))+CHAR(34) + ' A2U ' + CHAR(34)+ LTRIM(RTRIM(@Archivo))+ CHAR(34) + CHAR(34) 
    
    --Cuando viene en nulo no se debe de insertar.
    --INSERT @Datos (Datos)
    EXEC xp_cmdshell @Shell, no_output
    
    IF EXISTS(SELECT Datos FROM @Datos WHERE RTRIM(LTRIM(Datos)) = '1' ) SELECT @Ok = 71610, @OkRef = ISNULL(@Archivo,'')
  END  
END
GO

--declare @ok		int, @okref			varchar(255)
--exec spCFDFlexCrearArchivoTemporal 50, 'DEMO', 'Esta es una prueba de un archivo temporal 2', @ok output, @okref output
--select @ok, @okref

/******************************* spCFDFlexLeerArchivo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexLeerArchivo') and type = 'P') drop procedure dbo.spCFDFlexLeerArchivo
GO             
CREATE PROCEDURE spCFDFlexLeerArchivo
  @RutaArchivoXML	varchar(255),  
  @ArchivoXML		varchar(max) OUTPUT,  
  @Ok				int = NULL OUTPUT,  
  @OkRef			varchar(255) = NULL OUTPUT    
  
--//WITH ENCRYPTION  
AS BEGIN  
  -- SET nocount ON  
  DECLARE  
    @Codigo		int,  
    @SQL		nvarchar(max),  
    @Campo		varchar(max),
    @Existe		bit  
  
  SET @Codigo = '1252'  
  SET @ArchivoXML = ''  
  
  IF (OBJECT_ID('Tempdb..#CFDFlexLeerArchivo')) IS NOT NULL  
    DROP TABLE #CFDFlexLeerArchivo  
  
  CREATE TABLE #CFDFlexLeerArchivo  
  (  
    ArchivoXML varchar(max) NULL  
   )  
  
  EXEC spVerificarArchivo @RutaArchivoXML, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  
  
  SET @SQL = N'BULK INSERT #CFDFlexLeerArchivo  
                FROM ''' +  @RutaArchivoXML + '''  
                WITH (CODEPAGE = ' + CONVERT(varchar, @Codigo) + ')'  
  
  IF @Existe = 1                
    EXEC (@SQL)  
    
  IF NOT EXISTS(SELECT * FROM #CFDFlexLeerArchivo)  AND @Ok IS NULL
  BEGIN  
    SELECT @OK = 71525  
    SELECT @OkRef = (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok)  
    SELECT @OkRef = @OkRef + ' ' + @RutaArchivoXML  
  END  
  
  DECLARE crArchivoXML CURSOR FOR
   SELECT ISNULL(ArchivoXML, '')
     FROM #CFDFlexLeerArchivo
  OPEN crArchivoXML
  FETCH NEXT FROM crArchivoXML INTO @Campo
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SELECT @ArchivoXML = @ArchivoXML + @Campo
    FETCH NEXT FROM crArchivoXML INTO @Campo
  END
  CLOSE crArchivoXML
  DEALLOCATE crArchivoXML
  
END  
GO

/******************************* spCFDFlexValidarCertificado *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexValidarCertificado') and type = 'P') drop procedure dbo.spCFDFlexValidarCertificado
GO             
CREATE PROCEDURE spCFDFlexValidarCertificado
		@Estacion				int,
		@Empresa				varchar(5),
		@Sucursal				int,
		@Tipo					varchar(20),
		@FechaRegistro			datetime,		
		@Temporal				varchar(255),
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @RutaFirmaSAT			varchar(255),
    @RutaCertificado		varchar(255),
    @Shell					varchar(8000),
    @FechaTexto				varchar(max),
    @FechaVencimiento		datetime,
    @Encripcion				varchar(20),
    @NoCertificado			varchar(20),
    @ContrasenaSello		varchar(100),
    @CertificadoBase64		varchar(max),
    @RutaLlave				varchar(255),
	@r						int,
	@VersionFirmaSAT		varchar(max),
	@textoDatos				varchar(max),
	@RutaFirmaSATHelp       varchar(255)

  DECLARE @Datos TABLE (ID int identity(1,1), Datos varchar(255))
  DECLARE @Datos1 TABLE (ID int identity(1,1), Datos varchar(255))
    
  IF (OBJECT_ID('Tempdb..#CFDFlexLeerArchivo')) IS NOT NULL  
    DROP TABLE #CFDFlexLeerArchivo  
  
  CREATE TABLE #CFDFlexLeerArchivo  
  (  
    ArchivoXML varchar(max) NULL  
   )  

  EXEC spCFDFlexInfo @Estacion, @Empresa, @Sucursal, @Tipo, @NoCertificado OUTPUT, @ContrasenaSello OUTPUT, @CertificadoBase64 OUTPUT, @RutaLlave OUTPUT, @RutaCertificado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
  IF YEAR(GETDATE()) >= 2011
    SET @Encripcion = ' -g sha1 '
  ELSE
    SET @Encripcion = ' -g md5 '
    
  SET @Temporal = REPLACE(@Temporal,'.XML','')
  SET @Temporal = @Temporal + 'FechaCertificado.TXT'
  --EXEC spEliminarArchivo @Temporal, @Ok OUTPUT, @OkRef OUTPUT
  SELECT @RutaFirmaSAT = RutaFirmaSAT FROM EmpresaCFD WHERE Empresa = @Empresa  
  SELECT @RutaFirmaSATHelp = CHAR(34) + CHAR(34) + @RutaFirmaSAT + CHAR(34) + ' HELP' + CHAR(34)

  INSERT @Datos1
    EXEC @r = xp_cmdshell  @RutaFirmaSATHelp
  --IF @r = 0
    SELECT TOP 1 @TextoDatos = Datos FROM @Datos1 WHERE ISNULL(Datos,'') LIKE '%QUERYCERT%' ORDER BY ID ASC
  
  SELECT @VersionFirmaSAT = SUBSTRING(@textoDatos, 1,26)

  IF ISNULL(@TextoDatos,'') <> '' --@VersionFirmaSAT = 'FirmaSAT.exe Version 5.4.1'
    SET @Shell = CHAR(34) + CHAR(34) + @RutaFirmaSAT + CHAR(34) + ' QUERYCERT -q notAfter ' + CHAR(34) + @RutaCertificado + CHAR(34) + CHAR(34) 

  ELSE 
    --SET @Shell = @RutaFirmaSAT + ' DATENOTAFTER -i ' + '"' + @RutaCertificado + '"' + ' -o ' + '"' + @Temporal + '"'
	SET @Shell = CHAR(34) + CHAR(34) + @RutaFirmaSAT + CHAR(34) + ' DATENOTAFTER ' + CHAR(34) + @RutaCertificado + CHAR(34) + CHAR(34) 
 
  INSERT @Datos
  EXEC @r = xp_cmdshell @Shell--, no_output

  IF @r = 0
    SELECT TOP 1 @FechaTexto = Datos FROM @Datos WHERE Datos IS NOT NULL

  SET @Shell = CHAR(34) + CHAR(34) + @RutaFirmaSAT + CHAR(34) + ' KEYCHECK' + @Encripcion + '-k ' + CHAR(34) + @RutaLlave + CHAR(34) + ' -p ' + CHAR(34) +  @ContrasenaSello + CHAR(34) + ' ' + CHAR(34) + @Temporal + CHAR(34) + CHAR(34)

  INSERT #CFDFlexLeerArchivo
  EXEC xp_cmdshell @Shell
  
  IF EXISTS(SELECT * FROM #CFDFlexLeerArchivo WHERE ArchivoXML LIKE '%Error code -15: Decryption error/De error de descifrado:%') AND @Ok IS NULL
    SELECT @Ok = 60230, @OkRef = @RutaLlave
  ELSE
  IF EXISTS(SELECT * FROM #CFDFlexLeerArchivo WHERE ArchivoXML LIKE '%Error code -1: Cannot open input file/%') AND @Ok IS NULL
    SELECT @Ok = 71525, @OkRef = @RutaLlave

  IF @Ok IS NULL
  BEGIN
--    EXEC spCFDFlexLeerArchivo @Temporal, @FechaTexto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    IF SUBSTRING(@FechaTexto,1,1) NOT IN ('0','1','2','3','4','5','6','7','8','9')
      SELECT @Ok = 71550, @OkRef = @RutaCertificado
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @FechaVencimiento = CONVERT(datetime,REPLACE(@FechaTexto,'Z',''))  
    IF @@ERROR <> 0 SET @Ok = 71550
  END  
  
  IF @Ok IS NULL
  BEGIN
    IF @FechaVencimiento < @FechaRegistro SELECT @Ok = 71560, @OkRef = @FechaVencimiento
  END
    
END
GO

/******************************* spCFDFlexInfo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexInfo') and type = 'P') drop procedure dbo.spCFDFlexInfo
GO             
CREATE PROCEDURE spCFDFlexInfo
  @Estacion				int,  
  @Empresa				varchar(5),  
  @Sucursal				int,  
  @Tipo					varchar(20),
  @NoCertificado		varchar(20)  = NULL OUTPUT,  
  @ContrasenaSello		varchar(100) = NULL OUTPUT,  
  @CertificadoBase64	varchar(max) = NULL OUTPUT,  
  @RutaLlave			varchar(255) = NULL OUTPUT,  
  @RutaCertificado		varchar(255) = NULL OUTPUT,                    
  @Ok					int			 = NULL OUTPUT,  
  @OkRef				varchar(255) = NULL OUTPUT
  
--//WITH ENCRYPTION  
AS BEGIN  
  -- SET nocount ON  
  DECLARE    
    @SucursalCFDFlex  bit  

  SELECT @SucursalCFDFlex = ISNULL(CFDFlex, 0) FROM Sucursal WHERE Sucursal = @Sucursal    
  IF ISNULL(@SucursalCFDFlex, 0) = 1 AND ISNULL(@Tipo,'') <> 'Empresa'
    SELECT @NoCertificado = NoCertificado,  
           @ContrasenaSello = ContrasenaSello,  
           @CertificadoBase64 = CertificadoBase64,  
           @RutaLlave = Llave,  
           @RutaCertificado = RutaCertificado  
      FROM Sucursal  
     WHERE Sucursal = @Sucursal  
  ELSE  
    SELECT @NoCertificado = NoCertificado,  
           @ContrasenaSello = ContrasenaSello,  
           @CertificadoBase64 = CertificadoBase64,  
           @RutaLlave = Llave,  
           @RutaCertificado = RutaCertificado  
      FROM EmpresaCFD  
     WHERE Empresa = @Empresa  
    
END  
go

/******************************* spCFDFlexSellarXML *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexSellarXML') and type = 'P') drop procedure dbo.spCFDFlexSellarXML
GO             
CREATE PROCEDURE spCFDFlexSellarXML
		@Estacion				int,
		@Empresa				varchar(5),
		@Sucursal				int,
		@Temporal				varchar(255),
		@XML					varchar(max) OUTPUT,
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT,
		@Encripcion				varchar(20) = NULL

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @RutaFirmaSAT			varchar(255),
    @RutaCertificado		varchar(255),
    @RutaLlave				varchar(255),
    @Shell					varchar(8000),
    @ContrasenaSello		varchar(100),
    @CampoDatos				varchar(max),
    @Sello					varchar(max),
    @NoCertificado			varchar(20),
	@CertificadoBase64		varchar(max),
	@TemporalSello			varchar(255),
	@r						int,
    @RenglonDatos			varchar(255),
	@RID					int,
	@textoDatos				varchar(max)

  DECLARE @Datos TABLE (ID int identity(1,1), Datos varchar(255))

  IF @Encripcion IS NULL
  BEGIN
    IF YEAR(GETDATE()) >= 2011
      SET @Encripcion = ' -g sha1 '
    ELSE
      SET @Encripcion = ' -g md5 '      
  END ELSE
  BEGIN
    IF RTRIM(@Encripcion) IN ('md5','sha1')
    BEGIN
      SET @Encripcion = ' -g ' + RTRIM(@Encripcion)
    END ELSE 
    BEGIN
      SELECT @Ok = 71630, @OkRef = @RutaCertificado
    END 
  END

  SET @TemporalSello = REPLACE(@Temporal,'.XML','')
  SET @TemporalSello = @TemporalSello + 'Sello.TXT'
    
  EXEC spCFDFlexInfo @Estacion, @Empresa, @Sucursal, 'Sucursal', @NoCertificado OUTPUT, @ContrasenaSello OUTPUT, @CertificadoBase64 OUTPUT, @RutaLlave OUTPUT, @RutaCertificado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
  SELECT @RutaFirmaSAT = RutaFirmaSAT FROM EmpresaCFD WHERE Empresa = @Empresa  
  EXEC spEliminarArchivo @TemporalSello, @Ok OUTPUT, @OkRef OUTPUT
  SET @Shell = CHAR(34) + CHAR(34) + @RutaFirmaSAT + CHAR(34) + ' MAKESIG ' + @Encripcion + ' -k ' + CHAR(34) + @RutaLlave + CHAR(34) + ' -p ' + CHAR(34) + @ContrasenaSello + CHAR(34) + ' ' + CHAR(34) + @Temporal + CHAR(34) + CHAR(34)

  INSERT @Datos
    EXEC @r = xp_cmdshell @Shell--, no_output

  SELECT @TextoDatos = ''
  IF @r = 0
  BEGIN
    DECLARE crResultadoXMl CURSOR FOR
      SELECT Id, Datos FROM @Datos WHERE Datos IS NOT NULL ORDER BY ID Asc
    OPEN crResultadoXMl
    FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN  
	    SELECT @TextoDatos = @TextoDatos + @RenglonDatos
      END
    FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
	END
    CLOSE crResultadoXMl
    DEALLOCATE crResultadoXMl
  END 

  SET @Sello = ''
  IF @Ok IS NULL
  BEGIN
    --EXEC spCFDFlexLeerArchivo @TemporalSello, @CampoDatos OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
	SELECT @CampoDatos= @TextoDatos
    IF @CampoDatos LIKE 'ERROR%' SELECT @Ok = 71570, @OkRef = @CampoDatos

    IF @Ok IS NULL 
      SET @Sello = ISNULL(@CampoDatos,'')
  END

  SET @XML = REPLACE(@XML,'_SELLO_',@Sello)
  
END
GO


/******************************* spCFDFlexActualizarNoCertificado *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexActualizarNoCertificado') and type = 'P') drop procedure dbo.spCFDFlexActualizarNoCertificado
GO             
CREATE PROCEDURE spCFDFlexActualizarNoCertificado
		@Estacion				int,
		@Empresa				varchar(5),
		@Sucursal				int,
		@Tipo					varchar(20),
		@Temporal				varchar(255),
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @RutaFirmaSAT			varchar(255),
    @Shell					varchar(8000),
    @CampoDatos				varchar(max),
    @NoCertificado			varchar(20),
	@ContrasenaSello		varchar(100),
	@CertificadoBase64		varchar(max),
	@RutaLlave				varchar(255),
    @RutaCertificado		varchar(255),
    @TemporalNoCertificado	varchar(255),
	@r						int

  DECLARE @Datos TABLE (ID int identity(1,1), Datos varchar(255))
    
  EXEC spCFDFlexInfo @Estacion, @Empresa, @Sucursal, @Tipo, @NoCertificado OUTPUT, @ContrasenaSello OUTPUT, @CertificadoBase64 OUTPUT, @RutaLlave OUTPUT, @RutaCertificado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
  IF NULLIF(@RutaCertificado,'') IS NOT NULL
  BEGIN
    SELECT 
      @RutaFirmaSAT = RutaFirmaSAT
      FROM EmpresaCFD 
     WHERE Empresa = @Empresa  
    
    SET @TemporalNoCertificado = REPLACE(@Temporal,'.XML','')
    --26276
    --SET @TemporalNoCertificado = @TemporalNoCertificado + 'NoCertificado.TXT'
--	EXEC spEliminarArchivo @TemporalNoCertificado, @Ok OUTPUT, @OkRef OUTPUT
--    SET @Shell = @RutaFirmaSAT + ' NUMBERCERT ' + '"' + @RutaCertificado + '"' + ' ' + '"' + @TemporalNoCertificado + '"'
    SET @Shell = CHAR(34) + CHAR(34) + @RutaFirmaSAT + CHAR(34) + ' NUMBERCERT ' + CHAR(34) + @RutaCertificado + CHAR(34) + CHAR(34)

    --EXEC xp_cmdshell @Shell, no_output
	INSERT @Datos
    EXEC @r = xp_cmdshell @Shell--, no_output

    IF @r = 0
      SELECT TOP 1 @CampoDatos = Datos FROM @Datos WHERE Datos IS NOT NULL
	      
    SET @NoCertificado = ''
    IF @Ok IS NULL
    BEGIN
      --EXEC spCFDFlexLeerArchivo @TemporalNoCertificado, @CampoDatos OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @CampoDatos LIKE 'ERROR%' SELECT @Ok = 71590, @OkRef = @CampoDatos

      IF @Ok IS NULL 
        SET @NoCertificado = @NoCertificado + ISNULL(@CampoDatos,'')
    END
    
    IF @Ok IS NULL
      IF @Tipo = 'Sucursal'
        UPDATE Sucursal SET NoCertificado = @NoCertificado WHERE Sucursal = @Sucursal
      ELSE
        UPDATE EmpresaCFD SET NoCertificado = @NoCertificado WHERE Empresa = @Empresa
  END

END
GO

/******************************* spCFDFlexInsertarCertificadoXML *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexInsertarCertificadoXML') and type = 'P') drop procedure dbo.spCFDFlexInsertarCertificadoXML
GO             
CREATE PROCEDURE spCFDFlexInsertarCertificadoXML
		@Estacion				int,
		@Empresa				varchar(5),
		@Sucursal				int,
		@Tipo					varchar(20),
		@Certificar				bit = 1,
		@Temporal				varchar(255) = NULL,
		@XML					varchar(max) = NULL OUTPUT,
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @RutaFirmaSAT			varchar(255),
    @RutaCertificado		varchar(255),
    @Shell					varchar(8000),
    @CampoDatos				varchar(max),
    @NoCertificado			varchar(20),
	@ContrasenaSello		varchar(100),
	@CertificadoBase64		varchar(max),
	@RutaLlave				varchar(255),
	@SucursalCFDFlex		bit,
	@TemporalCertificado	varchar(255),
	@RutaTemporal			varchar(255),
    @r						int,
    @RenglonDatos			varchar(255),
	@RID					int,
	@textoDatos				varchar(max)

  DECLARE @Datos TABLE (ID int identity(1,1), Datos varchar(255))
      
  SELECT @SucursalCFDFlex = ISNULL(CFDFlex, 0) FROM Sucursal WHERE Sucursal = @Sucursal  
  SELECT @Tipo = ISNULL(NULLIF(@Tipo, ''), 'Empresa')
  EXEC spCFDFlexInfo @Estacion, @Empresa, @Sucursal, @Tipo, @NoCertificado OUTPUT, @ContrasenaSello OUTPUT, @CertificadoBase64 OUTPUT, @RutaLlave OUTPUT, @RutaCertificado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
 
  SELECT @CertificadoBase64 = NULLIF(@CertificadoBase64,'')
  IF @CertificadoBase64 IS NULL OR @Certificar = 0
  BEGIN
    SELECT 
      @RutaFirmaSAT = RutaFirmaSAT,
      @RutaTemporal = RutaTemporal
      FROM EmpresaCFD
     WHERE Empresa = @Empresa

    IF @Temporal IS NULL
	  SELECT @Temporal = @RutaTemporal + CASE WHEN SUBSTRING(REVERSE(@RutaTemporal),1,1) <> '\' THEN '\' ELSE '' END + 'Temporal' + CONVERT(varchar,@Estacion) + '.XML'

    SET @TemporalCertificado = REPLACE(@Temporal,'.XML','')
    SET @TemporalCertificado = @TemporalCertificado + 'Certificado.TXT'
	--EXEC spEliminarArchivo @TemporalCertificado, @Ok OUTPUT, @OkRef OUTPUT
    SET @Shell = CHAR(34) + CHAR(34) + @RutaFirmaSAT + CHAR(34) + ' CERTSTRING ' + CHAR(34) + @RutaCertificado + CHAR(34) + CHAR(34)

   -- EXEC xp_cmdshell @Shell, no_output
    INSERT @Datos
    EXEC @r = xp_cmdshell @Shell--, no_output

    SELECT @TextoDatos = ''
    IF @r = 0
    BEGIN
      DECLARE crResultadoXMl CURSOR FOR
        SELECT Id, Datos FROM @Datos WHERE Datos IS NOT NULL ORDER BY ID Asc
      OPEN crResultadoXMl
      FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
      WHILE @@FETCH_STATUS <> -1
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN  
	      SELECT @TextoDatos = @TextoDatos + @RenglonDatos
        END
      FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
	  END
      CLOSE crResultadoXMl
      DEALLOCATE crResultadoXMl
    END 
    
    SET @CertificadoBase64 = ''
    IF @Ok IS NULL
    BEGIN
      --EXEC spCFDFlexLeerArchivo @TemporalCertificado, @CampoDatos OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
	  SELECT @CampoDatos = @TextoDatos
      IF @CampoDatos LIKE 'ERROR%' SELECT @Ok = 71580, @OkRef = @CampoDatos

      IF @Ok IS NULL   
        SET @CertificadoBase64 = @CertificadoBase64 + ISNULL(@CampoDatos,'')
    END
            
    IF @Ok IS NULL
      IF @Tipo = 'Sucursal' AND @SucursalCFDFlex = 1
        UPDATE Sucursal SET CertificadoBase64 = @CertificadoBase64 WHERE Sucursal = @Sucursal
      ELSE
        UPDATE EmpresaCFD SET CertificadoBase64 = @CertificadoBase64 WHERE Empresa = @Empresa
  END
  IF @Ok IS NULL AND @Certificar = 0
    EXEC spCFDFlexActualizarNoCertificado @Estacion, @Empresa, @Sucursal, @Tipo, @Temporal, @Ok OUTPUT, @OkRef OUTPUT
    
  IF @Ok IS NULL AND @Certificar = 1
    SET @XML = REPLACE(@XML,'_CERTIFICADO_',@CertificadoBase64)

END
GO

/******************************* spCFDFlexInsertarNoCertificadoXML *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexInsertarNoCertificadoXML') and type = 'P') drop procedure dbo.spCFDFlexInsertarNoCertificadoXML
GO             
CREATE PROCEDURE spCFDFlexInsertarNoCertificadoXML
		@Estacion				int,
		@Empresa				varchar(5),
		@Sucursal				int,
		@Tipo					varchar(20),
		@Temporal				varchar(255),
		@XML					varchar(max) OUTPUT,
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @RutaFirmaSAT			varchar(255),
    @Shell					varchar(8000),
    @CampoDatos				varchar(max),
    @NoCertificado			varchar(20),
	@ContrasenaSello		varchar(100),
	@CertificadoBase64		varchar(max),
	@RutaLlave				varchar(255),
    @RutaCertificado		varchar(255),
    @TemporalNoCertificado	varchar(255),
    @r						int

  DECLARE @Datos TABLE (ID int identity(1,1), Datos varchar(255))
     
  SET @TemporalNoCertificado = REPLACE(@Temporal,'.XML','')
  SET @TemporalNoCertificado = @TemporalNoCertificado + 'NoCertificado.TXT'
  
  EXEC spCFDFlexInfo @Estacion, @Empresa, @Sucursal, @Tipo, @NoCertificado OUTPUT, @ContrasenaSello OUTPUT, @CertificadoBase64 OUTPUT, @RutaLlave OUTPUT, @RutaCertificado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  SELECT @NoCertificado = NULLIF(@NoCertificado,'')
  
  IF @NoCertificado IS NULL
  BEGIN
    SELECT 
      @RutaFirmaSAT = RutaFirmaSAT
      FROM EmpresaCFD 
     WHERE Empresa = @Empresa  
    EXEC spEliminarArchivo @TemporalNoCertificado, @Ok OUTPUT, @OkRef OUTPUT
 --   SET @Shell = @RutaFirmaSAT + ' NUMBERCERT ' + '"' + @Temporal + '"' + ' ' + '"' + @TemporalNoCertificado + '"'
    SET @Shell = CHAR(34) + CHAR(34) + @RutaFirmaSAT + CHAR(34) + ' NUMBERCERT ' + CHAR(34) + @Temporal + CHAR(34) + CHAR(34)

    --EXEC xp_cmdshell @Shell, no_output
 
    INSERT @Datos
    EXEC @r = xp_cmdshell @Shell--, no_output


    IF @r = 0
      SELECT TOP 1 @CampoDatos = Datos FROM @Datos WHERE Datos IS NOT NULL

    SET @NoCertificado = ''
    IF @Ok IS NULL
    BEGIN
      --EXEC spCFDFlexLeerArchivo @TemporalNoCertificado, @CampoDatos OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @CampoDatos LIKE 'ERROR%' SELECT @Ok = 71590, @OkRef = @CampoDatos

      IF @Ok IS NULL   
        SET @NoCertificado = @NoCertificado + ISNULL(@CampoDatos,'')
    END

    IF @Ok IS NULL
      UPDATE EmpresaCFD SET NoCertificado = @NoCertificado WHERE Empresa = @Empresa
  END

  IF @Ok IS NULL
    SET @XML = REPLACE(@XML,'_NOCERTIFICADO_',@NoCertificado)

END
GO

/******************************* spCFDFlexRegistrarCertificadoXML *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexRegistrarCertificadoXML') and type = 'P') drop procedure dbo.spCFDFlexRegistrarCertificadoXML
GO             
CREATE PROCEDURE spCFDFlexRegistrarCertificadoXML
		@Estacion				int,
		@Empresa				varchar(5),
		@Sucursal				int,
		@Tipo					varchar(20),
		@Certificar				bit = 1,
		@Temporal				varchar(255) = NULL,
		@XML					varchar(max) = NULL OUTPUT,
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @FechaRegistro		datetime,
    @RutaTemporal		varchar(255)
  
  SELECT @FechaRegistro = GETDATE()
  SELECT @RutaTemporal = RutaTemporal FROM EmpresaCFD WHERE Empresa = @Empresa
  SELECT @Temporal = @RutaTemporal + CASE WHEN SUBSTRING(REVERSE(@RutaTemporal),1,1) <> '\' THEN '\' ELSE '' END + 'Temporal' + CONVERT(varchar,@Estacion) + '.XML'
  
  IF @Tipo = 'Sucursal'
    UPDATE Sucursal SET CertificadoBase64 = NULL, noCertificado = NULL WHERE Sucursal = @Sucursal
  ELSE
    UPDATE EmpresaCFD SET CertificadoBase64 = NULL, noCertificado = NULL WHERE Empresa = @Empresa
  
  IF @Ok IS NULL
    EXEC spCFDFlexInsertarCertificadoXML @Estacion, @Empresa, @Sucursal, @Tipo, @Certificar, @Temporal, @XML, @Ok OUTPUT, @OkRef OUTPUT
    
  IF @Ok IS NULL
    EXEC spCFDFlexValidarCertificado @Estacion, @Empresa, @Sucursal, @Tipo, @FechaRegistro, @Temporal, @Ok OUTPUT, @OkRef OUTPUT
    
  IF @Tipo = 'Sucursal'
  BEGIN
    IF (SELECT CertificadoBase64 FROM Sucursal WHERE Sucursal = @Sucursal) IS NULL
      SELECT @Ok = 71580, @OkRef = RutaCertificado FROM Sucursal WHERE Sucursal = @Sucursal
  END
  ELSE
  BEGIN
    IF (SELECT CertificadoBase64 FROM EmpresaCFD WHERE Empresa = @Empresa) IS NULL
      SELECT @Ok = 71580, @OkRef = RutaCertificado FROM EmpresaCFD WHERE Empresa = @Empresa
  END

  IF @Ok IS NOT NULL
  BEGIN  
    IF @Tipo = 'Sucursal'
      UPDATE Sucursal SET CertificadoBase64 = '', noCertificado = '' WHERE Sucursal = @Sucursal
    ELSE
      UPDATE EmpresaCFD SET CertificadoBase64 = '', noCertificado = '' WHERE Empresa = @Empresa
      
    SELECT @OkRef = ISNULL(Descripcion,'') + '<BR>' + @OkRef FROM MensajeLista WHERE Mensaje = @Ok
    SELECT 'Error: ' + CONVERT(varchar,@Ok) + '<BR>' + @OkRef
  END
  ELSE
    SELECT 'Certificado Válido'
END
GO

/******************************* spCFDFlexInsertarPipeStringXML *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexInsertarPipeStringXML') and type = 'P') drop procedure dbo.spCFDFlexInsertarPipeStringXML
GO             
CREATE PROCEDURE spCFDFlexInsertarPipeStringXML
		@Estacion				int,
		@Empresa				varchar(5),
		@Temporal				varchar(255),
		@XML					varchar(max) OUTPUT,
		@CadenaOriginal			varchar(max) OUTPUT,
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @RutaFirmaSAT				varchar(255),
    @Shell						varchar(8000),
    @PipeString					varchar(max),
    @TemporalCadenaOriginal		varchar(255),
    @TemporalCadenaOriginalANSI	varchar(255),
    @RutaUTFTOANSI				varchar(255),
    @ArchivoXML					varchar(max),
	@ResultadoEjecucion			int,
	@Existe                     int    

  SELECT 
    @RutaFirmaSAT = RutaFirmaSAT,
    @RutaUTFTOANSI = RutaANSIToUTF
    FROM EmpresaCFD 
   WHERE Empresa = @Empresa  

  SET @TemporalCadenaOriginal = REPLACE(@Temporal,'.XML','.TXT')
  SET @TemporalCadenaOriginalANSI = REPLACE(@Temporal,'.XML','ANSI.TXT')
  EXEC spEliminarArchivo @TemporalCadenaOriginal, @Ok OUTPUT, @OkRef OUTPUT
  EXEC spEliminarArchivo @TemporalCadenaOriginalANSI, @Ok OUTPUT, @OkRef OUTPUT
  SET @Shell = CHAR(34) + CHAR(34) +  @RutaFirmaSAT + CHAR(34) + ' PIPESTRING -i ' + CHAR(34) + @Temporal + CHAR(34) + ' -o ' + CHAR(34) + @TemporalCadenaOriginal + CHAR(34) + CHAR(34)

  EXEC xp_cmdshell @Shell, no_output
  
  SET @Shell = CHAR(34)+CHAR(34)+@RutaUTFToAnsi +CHAR(34)+ ' U2A ' +CHAR(34)+ @TemporalCadenaOriginal + CHAR(34)+' ' +CHAR(34)+ @TemporalCadenaOriginalANSI + CHAR(34) + CHAR(34) 
 
  EXEC @ResultadoEjecucion = xp_cmdshell @Shell, no_output
  IF @ResultadoEjecucion = 1 SELECT @Ok = 71610, @OkRef = 'Error al Ejecutar '+@RutaUTFToAnsi
  
  IF @Ok IS NULL
  BEGIN
    EXEC spCFDFlexLeerArchivo @TemporalCadenaOriginalANSI, @ArchivoXML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    IF @ArchivoXML LIKE 'ERROR%' SELECT @Ok = 71590, @OkRef = @ArchivoXML    
    IF @Ok IS NULL 
      SET @PipeString =  @ArchivoXML
  END
      
  SET @CadenaOriginal = @PipeString  
  SET @XML = REPLACE(@XML,'_CADENAORIGINAL_',@PipeString)
  
  IF @Ok IS NULL
   EXEC spVerificarArchivo @TemporalCadenaOriginal, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	
  IF ISNULL(@Existe,0) = 1 AND @Ok IS NULL
   EXEC spEliminarArchivo @TemporalCadenaOriginal, @Ok OUTPUT, @OkRef OUTPUT  

  IF @Ok IS NULL
   EXEC spVerificarArchivo @TemporalCadenaOriginalANSI, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	
  IF ISNULL(@Existe,0) = 1 AND @Ok IS NULL
   EXEC spEliminarArchivo @TemporalCadenaOriginalANSI, @Ok OUTPUT, @OkRef OUTPUT  

END
GO
/******************************* spCFDFlexSepararAddendaCFDI *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexSepararAddendaCFDI') and type = 'P') drop procedure dbo.spCFDFlexSepararAddendaCFDI
GO             
CREATE PROCEDURE spCFDFlexSepararAddendaCFDI
		@CFDI				varchar(max),
		@CFDISinAddenda		varchar(max) OUTPUT,
		@Addenda			varchar(max) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @InicioAddenda			bigint,
    @FinAddenda				bigint,    
    @CFDIInicio				varchar(max),
    @CFDIFinal				varchar(max)
    
  SET @InicioAddenda = CHARINDEX('<cfdi:Addenda>', @CFDI)
  SET @FinAddenda = CHARINDEX('</cfdi:Addenda>', @CFDI)
  
  IF NULLIF(@InicioAddenda,0) IS NOT NULL AND NULLIF(@FinAddenda,0) IS NOT NULL 
  BEGIN  
    SET @CFDIInicio = SUBSTRING(@CFDI, 1,  @InicioAddenda - 1)
    SET @CFDIFinal = SUBSTRING(@CFDI, @FinAddenda + 15, LEN(@CFDI))
  
    SELECT @CFDISinAddenda =  @CFDIInicio + @CFDIFinal
  
    SET @Addenda = SUBSTRING(@CFDI, @InicioAddenda,LEN(@CFDI))
    SET @Addenda = SUBSTRING(@Addenda,1,CHARINDEX('</cfdi:Addenda>', @Addenda) + 14)
  END ELSE
  BEGIN
    SET @CFDISinAddenda = @CFDI
    SET @Addenda = ''
  END
END
GO

/******************************* spCFDFlexInsertarAddendaCFDI *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexInsertarAddendaCFDI') and type = 'P') drop procedure dbo.spCFDFlexInsertarAddendaCFDI
GO             
CREATE PROCEDURE spCFDFlexInsertarAddendaCFDI
		@CFDISinAddenda				varchar(max),
		@Addenda					varchar(max),		
		@CFDI						varchar(max) OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  SET @Addenda = REPLACE(@Addenda,'xmlns:cfdi="http' + CHAR(58) + '//www.sat.gob.mx/cfd/3"','')
  SET @Addenda = @Addenda + '</cfdi' + CHAR(58) + 'Comprobante>'
  SET @CFDI = REPLACE(@CFDISinAddenda,'</cfdi' + CHAR(58) + 'Comprobante>',@Addenda) 
END
GO

/*************** spCFDFlexIntelisisCFDI *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexIntelisisCFDI') and type = 'P') drop procedure dbo.spCFDFlexIntelisisCFDI
GO             
CREATE PROC spCFDFlexIntelisisCFDI
		@Estacion				int,
		@Empresa				varchar(5),
		@Modulo					varchar(5),
		@Mov					varchar(20),
		@MovID					varchar(20),
		@RutaArchivo			varchar(200),
    	@CFDI					varchar(max),
	    @CFDITimbrado			varchar(max) OUTPUT,
		@CadenaOriginal			varchar(max) OUTPUT,
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @ServidorPAC			varchar(100),
  		  @UsuarioPAC			varchar(100),
		  @PaswordPAC			varchar(100),
		  @AccionCFDI			varchar(50),
		  @RutaCer				varchar(200),
		  @RutaKey				varchar(200),
		  @passKey				varchar(100),
		  @RFC					varchar(20),
		  @Documento			varchar(max),
		  @RutaIntelisisCFDI	varchar(255),
		  @CadenaConexion		varchar(max),
		  @PswPFX				varchar(30),
		  @DatosXMl				varchar(max),
		  @RenglonDatos			varchar(255),
		  @Error				bit,
		  @Sucursal				int,
		  @SucursalCFDFlex		bit,
		  --@XML					xml,
		  @xml					varchar(max),
		  @RID					int,
		  @iDatos				int,
		  @DocumentoXML			xml,
		  @PrefijoCFDI			varchar(255),
		  @Shell				varchar(8000),
		  @r					varchar(max),
		  @FirmaCancelacionSAT  varchar(max),
		  @FechaCancelacionSAT  varchar(30),
		  @FechaTimbrado		varchar(max),
		  @UUID				varchar(50),
		  @SelloCancelacionSAT	varchar(max), 
		  @EsCadenaOriginal		bit,
		  @ModoPruebas			bit,
		  @Existe				int,
		  @TokenCanPAC			varchar(max),
		  @CuentaCanPAC			varchar(max),
		  @UsuarioCanPAC		varchar(50),
		  @PaswordCanPAC		varchar(50),
		  @RutaProvPac			varchar(max),
		  @AlmacenarRuta		varchar(200),
		  @TimeOutTimbrado		int,
		  @Timbrar              Bit,
		  @RegistrarLog         bit,
		  @UsarTimbrarNomina	bit
		     
  DECLARE @Datos TABLE (ID int IDENTITY(1,1), Datos varchar(255))

  --SELECT @FechaTimbrado = CONVERT(varchar(20),FechaTimbrado,127), @UUID = UUID, @Documento = Documento, @SelloCancelacionSAT = SelloCancelacionSAT FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID 

  SELECT @RFC = RFC FROM Empresa WHERE Empresa = @Empresa


  SELECT @RutaIntelisisCFDI = RutaTimbrarCFDI, 
         @ServidorPAC = TimbrarCFDIServidor,
         @UsuarioPAC  = TimbrarCFDIUsuario,
         @PaswordPAC = TimbrarCFDIPassword, 
         @RutaCer = RutaCertificado, 
         @RutaKey = Llave, 
         @passKey = ContrasenaSello, 
         @TimeOutTimbrado = CONVERT(varchar(30),ISNULL(TimeOutTimbrado,15000)), 
         @ModoPruebas = ModoPruebas,         
         @TokenCanPAC	=ISNULL(CancelarCFDIToken,''),
		 @CuentaCanPAC=ISNULL(CancelarCFDICuenta,''),
		 @UsuarioCanPAC=ISNULL(CancelarCFDIUsuario ,''),
		 @PaswordCanPAC=ISNULL(CancelarCFDIPassword  ,''),
		 @RegistrarLog		= RegistrarLog
    FROM EmpresaCFD WHERE Empresa = @Empresa
    
  SELECT @Sucursal = CASE @Modulo 
                       WHEN 'VTAS' THEN (SELECT Sucursal FROM Venta WHERE Mov = @Mov AND MovID = @MovID AND Empresa = @Empresa)
                       WHEN 'CXC' THEN (SELECT Sucursal FROM Cxc WHERE Mov = @Mov AND MovID = @MovID  AND Empresa = @Empresa) 
                     END
    
  SELECT @SucursalCFDFlex = ISNULL(CFDFlex, 0) FROM Sucursal WHERE Sucursal = @Sucursal    
  IF ISNULL(@SucursalCFDFlex, 0) = 1 --AND ISNULL(@Tipo,'') <> 'Empresa'
    SELECT @passKey = ContrasenaSello,  
           @RutaKey = Llave,  
           @RutaCer = RutaCertificado  
      FROM Sucursal  
     WHERE Sucursal = @Sucursal

  --BUG21754 BUG22355
  --IF @ServidorPAC = 'ASPEL'
  --  SELECT @CFDI = REPLACE(@CFDI, 'ñ', 'N')
  SELECT @RutaIntelisisCFDI = REPLACE(@RutaIntelisisCFDI,'TimbrarCFDI.EXE', 'IntelisisCFDI.exe')
  IF @UUID IS NOT NULL
    SELECT @Ok = 71680, @OkRef = 'El Movimiento Ya Fue Timbrado'

  --IF @Estatus = 'CONCLUIDO'
    --SELECT @AccionCFDI = 'SOLOTIMBRAR', @PswPFX = 'Intelisis1234567', @Timbrar = 1
    SELECT @AccionCFDI = 'TIMBRAR', @PswPFX = 'Intelisis1234567', @Timbrar = 1
  --ELSE 
  --  SELECT @Ok = 30110, @OkREf = 'CFDI - El Movimiento no esta CONCLUIDO'
  SELECT @AlmacenarRuta =   REPLACE(@RutaArchivo,'.XML','.tmp')
 
  DECLARE @Hoy datetime
  SELECT @Hoy = GETDATE()
  SELECT @FechaTimbrado = CONVERT(varchar(20), @Hoy,127), @UUID = '0'
 
  IF @RutaIntelisisCFDI IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta Intelisis CFDI no Puede Estar Vacio' ELSE
  IF @FechaTimbrado IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Fecha de Timbrado no Puede Estar Vacio' ELSE
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
/*
   IF @UsarTimbrarNomina=0 
    BEGIN
	 SET @UsuarioPAC=@UsuarioCanPAC 
	 SET @PaswordPAC=@PaswordCanPAC
	END
*/
    IF @CuentaCanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Cuenta PAC No puede Estar Vacio' ELSE 
    IF @TokencanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Token PAC No puede Estar Vacio' 
  END
  
  IF @UsuarioPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Usuario PAC No puede Estar Vacio' ELSE 
  IF @PaswordPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Pasword PAC No puede Estar Vacio' 
  
  IF @Ok IS NULL
    EXEC spCFDFlexRegenerarArchivo @Empresa, @AlmacenarRuta, @CFDI, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
 
     /*SELECT                  '<IntelisisCFDI>',
                             '<IDSESION>'+CONVERT(varchar,@@SPID)+'</IDSESION>',
                             '<FECHA>'+@FechaTimbrado+'</FECHA>',
		                     '<SERVIDOR>'+@ServidorPAC+'</SERVIDOR>',
						     '<USUARIO>'+@UsuarioPAC+'</USUARIO>',
						     '<PASSWORD>'+@PaswordPAC+'</PASSWORD>',
						     '<CUENTA>'+ISNULL(@CuentaCanPAC,'')+'</CUENTA>',
						     '<TOKEN>'+ISNULL(@TokenCanPAC,'')+'</TOKEN>',
						     '<ACCION>'+@AccionCFDI+'</ACCION>',
						     '<RUTACER>'+@RutaCer+'</RUTACER>',
						     '<RUTAKEY>'+@RutaKey+'</RUTAKEY>',
						     '<PWDKEY>'+@passKey+'</PWDKEY>',
						     '<PWDPFX>'+@PswPFX+'</PWDPFX>',
						     '<UUID>'+@UUID+'</UUID>',
						     '<RFC>'+@RFC+'</RFC>',
			                  '<TIMEOUT>'+CONVERT(varchar(30),@TimeOutTimbrado)+'</TIMEOUT>',
						     '<RUTAARCHIVO>'+@AlmacenarRuta+'</RUTAARCHIVO>',
						     '<MODOPRUEBAS>'+CONVERT(varchar(1),@ModoPruebas)+'</MODOPRUEBAS>',
						     '</IntelisisCFDI>' */
						      
    SELECT @CadenaConexion = '<IntelisisCFDI>'+
                             '<IDSESION>'+CONVERT(varchar,@@SPID)+'</IDSESION>'+
                             '<FECHA>'+@FechaTimbrado+'</FECHA>'+
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
			                  '<TIMEOUT>'+CONVERT(varchar(30),@TimeOutTimbrado)+'</TIMEOUT>'+
						     '<RUTAARCHIVO>'+@AlmacenarRuta+'</RUTAARCHIVO>'+
						     '<GUARDARLOG>'+convert(varchar(1),@RegistrarLog)+'</GUARDARLOG>'+
						     '<MODOPRUEBAS>'+CONVERT(varchar(1),@ModoPruebas)+'</MODOPRUEBAS>'+
						     '<USARFIRMASAT>1</USARFIRMASAT>'+
						     '</IntelisisCFDI>'

    SELECT @Shell = CHAR(34)+CHAR(34)+@RutaIntelisisCFDI+CHAR(34)+' '+CHAR(34)+@CadenaConexion+CHAR(34)+CHAR(34)
    
    INSERT @Datos
      EXEC @r =  xp_cmdshell @Shell--, no_output   
    
    EXEC spVerificarArchivo @AlmacenarRuta, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  

    IF @Existe = 1
      EXEC spEliminarArchivo @AlmacenarRuta, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @DatosXMl = '', @CadenaOriginal = '', @EsCadenaOriginal = 0
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
            
            --IF CHARINDEX('<CADENAORIGINAL',@RenglonDatos) >= 1
            --  SELECT @EsCadenaOriginal = 1
            
            --IF @EsCadenaOriginal = 0
            --  SELECT @DatosXMl = @DatosXML + @RenglonDatos
            --ELSE 
            --  SELECT @CadenaOriginal = @CadenaOriginal + @RenglonDatos
      END
    FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
      END
    CLOSE crResultadoXMl
    DEALLOCATE crResultadoXMl

    IF @Error = 1 SELECT @Ok = 71650,  @OkRef = @DatosXml
    IF @r <> 0
      SELECT @OK = 71650, @OkREf = 'Error al Ejecutar IntelisisCFDI.exe '+ISNULL(@DatosXml,'')
    IF NULLIF(@DatosXMl,'') IS NULL SELECT @Ok = 71650, @OkRef = 'Se Esperaba Respuesta de IntelisisCFDI.exe' 

    --BUG21754
	--IF @ServidorPAC = 'SOLUCIONFACTIBLE' 
	--SELECT @DatosXMl = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@DatosXMl, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'ñ', 'n'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'), 'Ñ', 'N')


    IF @Ok is NULL
    BEGIN
      IF CHARINDEX('<CADENAORIGINAL>', @DatosXML, 0) <> 0
      BEGIN
        SELECT @CadenaOriginal = SUBSTRING(@DatosXML, CHARINDEX('<CADENAORIGINAL>', @DatosXML, 0), LEN(@DatosXML) - CHARINDEX('<CADENAORIGINAL>', @DatosXML, 0) + 1)
        SELECT @DatosXML = SUBSTRING(@DatosXML, 1, CHARINDEX('<CADENAORIGINAL>', @DatosXML, 0) - 1)
      END
      ELSE
        SELECT @CadenaOriginal = ''

	  SELECT @CadenaOriginal = REPLACE(REPLACE(@CadenaOriginal,'<CADENAORIGINAL>',''),'</CADENAORIGINAL>','')
/*
      BEGIN TRY
        SELECT @XML = CONVERT(xml,@DatosXml)
      END TRY
      BEGIN CATCH
        SELECT @Ok = 71600, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
      END CATCH
*/
      SELECT @CFDITimbrado = @DatosXml


    END
  END
END
GO

/******************************* spCFDFlexTimbrarCFDI *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexTimbrarCFDI') and type = 'P') drop procedure dbo.spCFDFlexTimbrarCFDI
GO             
CREATE PROCEDURE spCFDFlexTimbrarCFDI
		@Estacion				int,
		@Empresa				varchar(5),
		@Modulo					varchar(5),
		@Mov					varchar(20),
		@MovID					varchar(20),
		@Archivo				varchar(255),
		@XML					varchar(max) OUTPUT,
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @RutaTimbrarCFDI			varchar(255),
    @RutaUTFToAnsi				varchar(255),
    @Shell						varchar(8000),
    @ArchivoTimbreOUT			varchar(255),
    @ArchivoTimbreOUTAnsi		varchar(255),    
    @ArchivoTimbreIN			varchar(255),
    @Timbre						varchar(max),
    @Conexion					varchar(max),
    @TimbrarCFDIServidor		varchar(100),
    @TimbrarCFDIUsuario			varchar(100),
    @TimbrarCFDIPassword		varchar(100),
    @XMLComprobante				varchar(max),
    @XMLAddenda					varchar(max),
    @TimbreConAddenda			varchar(max),
    @ArchivoTimbreOUTUUID		varchar(max),
    @UUID						varchar(max),
    @Error						bit,
	@ArchivoXML					varchar(max),
	@Resultado					int,
	@CadenaOriginal             varchar(max),
	@UsarIntelisisCFDI          bit,
	@Existe                     int
        
    
  SELECT 
    @RutaTimbrarCFDI     = RutaTimbrarCFDI,
    @RutaUTFToAnsi		 = RutaAnsiToUTF,
    @TimbrarCFDIServidor = TimbrarCFDIServidor,
    @TimbrarCFDIUsuario  = TimbrarCFDIUsuario,
    @TimbrarCFDIPassword = TimbrarCFDIPassword,
    @UsarIntelisisCFDI = UsarIntelisisCFDI
    FROM EmpresaCFD 
   WHERE Empresa = @Empresa  

  SET @Conexion = '<Funciones50><IDSESION>' + CONVERT(varchar,@@SPID) + '</IDSESION><SERVIDOR>' + ISNULL(@TimbrarCFDIServidor,'') + '</SERVIDOR><USUARIO>' + ISNULL(@TimbrarCFDIUsuario,'') + '</USUARIO><PASSWORD>' + ISNULL(@TimbrarCFDIPassword,'') + '</PASSWORD><SISTEMA></SISTEMA><RFC></RFC><RAZONSOCIAL></RAZONSOCIAL><NUMSERIE></NUMSERIE></Funciones50>'

  SET @ArchivoTimbreOUT = REPLACE(@Archivo,'.XML','TimbreOut.XML')
  SET @ArchivoTimbreOUTAnsi = REPLACE(@Archivo,'.XML','TimbreOutAnsi.XML')  
  SET @ArchivoTimbreIN = REPLACE(@Archivo,'.XML','TimbreIN.XML')

  IF @Ok IS NULL
    EXEC spEliminarArchivo @ArchivoTimbreIN ,@Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    EXEC spEliminarArchivo @ArchivoTimbreOUT ,@Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    EXEC spEliminarArchivo @ArchivoTimbreOUTAnsi ,@Ok OUTPUT, @OkRef OUTPUT
  
  EXEC spCFDFlexSepararAddendaCFDI @XML, @XMLComprobante OUTPUT, @XMLAddenda OUTPUT
  
  EXEC spCFDFlexRegenerarArchivo @Empresa, @ArchivoTimbreIN, @XMLComprobante, @Ok OUTPUT, @OkRef OUTPUT  

  EXEC xpCFDIRegistrarlog 'ANTES DE TIMBRAR', @Empresa, @Modulo, NULL, @Mov, @MovID, @XMLComprobante, 0, @Ok, @OkRef, NULL
  
  IF @Ok IS NULL
  BEGIN
  
  --IF @UsarIntelisisCFDI = 1
     EXEC spCFDFlexIntelisisCFDI @Estacion,	@Empresa, @Modulo, @Mov, @MovID, @ArchivoTimbreOUT, @XMLComprobante, @ArchivoXML OUTPUT, @CadenaOriginal OUTPUT, @Ok OUTPUT, @OkRef	OUTPUT
 -- ELSE
 -- BEGIN
 --   SET @Shell = @RutaTimbrarCFDI + ' ' + CHAR(34) + @ArchivoTimbreOUT + CHAR(34) + ' ' + CHAR(34) + @ArchivoTimbreIN + CHAR(34) + ' ' + CHAR(34) + @Conexion + CHAR(34) 

	--EXEC @Resultado =  xp_cmdshell @Shell, no_output
	--IF @Resultado = 1 SELECT @Ok = 71650, @OkRef = 'Error al Ejecutar '+@RutaTimbrarCFDI 
  
 --   SET @Shell = @RutaUTFToAnsi + ' U2A ' + @ArchivoTimbreOUT + ' ' + @ArchivoTimbreOUTAnsi 
 --   EXEC @Resultado =  xp_cmdshell @Shell, no_output
 --   IF @Resultado = 1 SELECT @Ok = 71610, @OkRef = 'Error al Ejecutar '+@RutaUTFToAnsi
  
 --   EXEC spCFDFlexLeerArchivo @ArchivoTimbreOUTAnsi, @ArchivoXML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
 -- END

    
    SELECT @ArchivoXML = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@ArchivoXML,'&amp;amp;','&amp;'),'&amp;quot;','&quot;'),'&amp;apos;','&apos;'),'&amp;gt;','&gt;'),'&amp;lt;','&lt;')

    IF @Ok IS NULL AND @TimbrarCFDIServidor<>'G4S'
    BEGIN
      SET @Error = 1
      --REQ Q3069 CFDGT
      IF @ArchivoXML LIKE '%<cfdi' + CHAR(58) + 'Comprobante%' OR @ArchivoXML LIKE '%<gs1' + CHAR(58) + 'invoice%'
        SET @Error = 0
        
      SET @Timbre = ISNULL(@ArchivoXML,'')
      IF @Error = 1 SELECT @Ok = 71650, @OkRef = SUBSTRING(@Timbre,1,255)
    END
     ELSE  IF @Ok IS NULL AND @TimbrarCFDIServidor='G4S'
      SET @Timbre = ISNULL(@ArchivoXML,'')

	IF @TimbrarCFDIServidor<>'G4S'
     SET @UUID = dbo.fnCFDFlexExtraerGUUID(@Timbre)
    ELSE 
     SET @UUID =  SUBSTRING(@Timbre, CHARINDEX('<DocumentGUID>', @Timbre)+14, CHARINDEX('</DocumentGUID>', @Timbre)-15)
    
    IF NULLIF(@UUID,'') IS NULL
    BEGIN
      SET @UUID = CONVERT(varchar(max),NEWID())
      IF NULLIF(@Modulo,'') IS NULL
        SET @ArchivoTimbreOUTUUID = REPLACE(@Archivo,'Temporal' + CONVERT(varchar,@Estacion) + '.XML', RTRIM(ISNULL(@Mov,'')) + '_' + RTRIM(ISNULL(@MovID,'')) + '_' + RTRIM(ISNULL(@UUID,'')) + '.XML')      
      ELSE
        SET @ArchivoTimbreOUTUUID = REPLACE(@Archivo,'Temporal' + CONVERT(varchar,@Estacion) + '.XML', RTRIM(ISNULL(@Modulo,'')) + '_' + RTRIM(ISNULL(@Mov,'')) + '_' + RTRIM(ISNULL(@MovID,'')) + '_' + RTRIM(ISNULL(@UUID,'')) + '.XML')
    END
    ELSE
      IF NULLIF(@Modulo,'') IS NULL
        SET @ArchivoTimbreOUTUUID = REPLACE(@Archivo,'Temporal' + CONVERT(varchar,@Estacion) + '.XML', RTRIM(ISNULL(@Mov,'')) + '_' + RTRIM(ISNULL(@MovID,'')) + '_UUID_' + RTRIM(ISNULL(@UUID,'')) + '.XML')
      ELSE    
        SET @ArchivoTimbreOUTUUID = REPLACE(@Archivo,'Temporal' + CONVERT(varchar,@Estacion) + '.XML', RTRIM(ISNULL(@Modulo,'')) + '_' + RTRIM(ISNULL(@Mov,'')) + '_' + RTRIM(ISNULL(@MovID,'')) + '_UUID_' + RTRIM(ISNULL(@UUID,'')) + '.XML')

    SELECT @Timbre = REPLACE(@Timbre, '<?xml version="1.0" encoding="UTF-8"?>', '')
	IF @Ok IS NULL
     EXEC spVerificarArchivo @ArchivoTimbreOUTUUID, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	
	IF ISNULL(@Existe,0) = 1 AND @Ok IS NULL
     EXEC spCFDFlexRegenerarArchivo @Empresa, @ArchivoTimbreOUTUUID, @Timbre, @Ok OUTPUT, @OkRef OUTPUT

    EXEC spCFDFlexInsertarAddendaCFDI @Timbre, @XMLAddenda, @TimbreConAddenda OUTPUT
    
  END

  EXEC xpCFDIRegistrarlog 'DESPUES DE TIMBRAR', @Empresa, @Modulo, NULL, @Mov, @MovID, @ArchivoXML, 0, @Ok, @OkRef, @UUID 
  
  IF @Ok IS NULL
  BEGIN
    SET @XML = @TimbreConAddenda

	EXEC spVerificarArchivo @ArchivoTimbreOUT, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
	IF ISNULL(@Existe,0) = 1 AND @Ok IS NULL
	 EXEC spEliminarArchivo @ArchivoTimbreOUT, @Ok OUTPUT, @OkRef OUTPUT
    
	IF @Ok IS NULL
	 EXEC spVerificarArchivo @ArchivoTimbreOUTAnsi, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
	IF ISNULL(@Existe,0) = 1 AND @Ok IS NULL
	 EXEC spEliminarArchivo @ArchivoTimbreOUTAnsi, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
     EXEC spVerificarArchivo @ArchivoTimbreIN, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	
	IF ISNULL(@Existe,0) = 1 AND @Ok IS NULL
	 EXEC spEliminarArchivo @ArchivoTimbreIN, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
     EXEC spVerificarArchivo @ArchivoTimbreOUTUUID, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	
	IF ISNULL(@Existe,0) = 1 AND @Ok IS NULL
	 EXEC spEliminarArchivo @ArchivoTimbreOUTUUID, @Ok OUTPUT, @OkRef OUTPUT  

  END  
END
GO

--Bug 19068
/******************************* spCFDFlexTimbrarCFDILote *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexTimbrarCFDILote') and type = 'P') drop procedure dbo.spCFDFlexTimbrarCFDILote
GO             
CREATE PROCEDURE spCFDFlexTimbrarCFDILote
		@Estacion			int,
		@Empresa			varchar(5),
		@Usuario			varchar(10)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @RutaTemporal		varchar(255),
    @Modulo				varchar(5),
    @ModuloID			int,
    @Archivo			varchar(255),
    @XML				varchar(max),
    @Temporal			varchar(255),
    @Timbrado			bit,
    @Ok					int,
    @OkRef				varchar(255),
    @Mov				varchar(20),
    @MovID				varchar(20),
	@iDatos				int,
	@RutaCFDI			varchar(255),
	@CFDUUID			uniqueidentifier,
	@CFDFechaTimbrado	datetime,
    @TFDVersion			varchar(10),
    @SelloSAT			varchar(max),
    @noCertificadoSAT	varchar(20),
    @PrefijoCFDI		varchar(255),
    @Estatus            varchar(15)

     
  DECLARE crListaModuloID CURSOR FOR
   SELECT Modulo, ID
     FROM ListaModuloID
    WHERE Estacion = @Estacion
    
  OPEN crListaModuloID
  FETCH NEXT FROM crListaModuloID INTO @Modulo, @ModuloID
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    SELECT @Mov = '', @MovID = ''
    IF @Modulo = 'VTAS'
      SELECT @Mov = RTRIM(Mov), @MovID = RTRIM(MovID), @Estatus = Estatus FROM Venta WHERE ID = @ModuloID
    ELSE
    IF @Modulo = 'COMS'
      SELECT @Mov = RTRIM(Mov), @MovID = RTRIM(MovID), @Estatus = Estatus FROM Compra WHERE ID = @ModuloID
    ELSE
    IF @Modulo = 'CXC'
      SELECT @Mov = RTRIM(Mov), @MovID = RTRIM(MovID), @Estatus = Estatus FROM Cxc WHERE ID = @ModuloID
    ELSE
    IF @Modulo = 'CXP'
      SELECT @Mov = RTRIM(Mov), @MovID = RTRIM(MovID), @Estatus = Estatus FROM Cxp WHERE ID = @ModuloID

    EXEC spCFDFlex @Estacion, @Empresa, @Modulo, @ModuloID, @Estatus, @Ok OUTPUT, @OkRef OUTPUT

    IF @@ERROR <> 0 SET @Ok = 1
    FETCH NEXT FROM crListaModuloID INTO @Modulo, @ModuloID
  END
  CLOSE crListaModuloID
  DEALLOCATE crListaModuloID         

  DELETE FROM ListaModuloID WHERE Estacion = @Estacion

  IF @Ok IS NOT NULL
  BEGIN
    SELECT @OkRef =  ISNULL(Descripcion,'') +ISNULL(@OkRef,'') FROM MensajeLista WHERE Mensaje = @Ok
    SELECT @OkRef
  END  
  ELSE
    SELECT 'PROCESO CONCLUIDO EXISTOSAMENTE' 
END
GO

/******************************* spCFDFlexGenerarXMLSchema *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCFDFlexGenerarXMLSchema') AND TYPE = 'P')
DROP PROCEDURE spCFDFlexGenerarXMLSchema
GO

CREATE PROCEDURE spCFDFlexGenerarXMLSchema
  (
  @Modulo			varchar(5),
  @Clave			varchar(20)
  ) 
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @IDSQL		varchar(100),
	  @XSD				nvarchar(MAX),
	  @XMLSchema		nvarchar(max)

  SELECT @XSD = REPLACE(REPLACE(LTRIM(RTRIM(XSD)),CHAR(13),''),CHAR(10),'')
    FROM eDocXSD 
   WHERE Modulo = @Modulo
     AND Clave = @Clave

  SET @IDSQL = @Clave
  
  IF EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = @IDSQL)
  BEGIN

    SET @XMLSchema = 'DROP XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']'
    EXECUTE sp_executesql @XMLSchema

    IF NULLIF(RTRIM(@XSD),'') IS NOT NULL
    BEGIN
      SET @XMLSchema = 'CREATE XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']' + ' AS ' + CHAR(39) + RTRIM(@XSD) + CHAR(39)
      EXECUTE sp_executesql @XMLSchema
    END
  END
  ELSE
  BEGIN 
    IF NULLIF(RTRIM(@XSD),'') IS NOT NULL
    BEGIN    
      SET @XMLSchema = 'CREATE XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']' + ' AS ' + CHAR(39) + RTRIM(@XSD) + CHAR(39)
      
      EXECUTE sp_executesql @XMLSchema
    END
  END
END 
GO

/******************************* xpCFDFlexValidarXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.xpCFDFlexValidarXML') AND TYPE = 'P')
DROP PROCEDURE xpCFDFlexValidarXML
GO
CREATE PROCEDURE xpCFDFlexValidarXML
  ( 
  @XML			varchar(MAX),
  @Ok			int OUTPUT,
  @OkRef		varchar(255) OUTPUT
  ) 

AS
BEGIN
  
  IF CHARINDEX('<detallista:orderIdentification><detallista:referenceIdentification type="ON"/>',@XML,1) >0
  OR CHARINDEX('<detallista:orderIdentification><detallista:referenceIdentification type="ON"></detallista:referenceIdentification>',@XML,1) >0
    SELECT @Ok=71600 ,@OkRef = '<detallista:orderIdentification><detallista:referenceIdentification type="ON"/>'

  IF CHARINDEX('<detallista:referenceIdentification type="ATZ"></detallista:referenceIdentification>',@XML,1) >0
  OR CHARINDEX('<detallista:referenceIdentification type="ATZ"/>',@XML,1) >0 
    SELECT @Ok=71600 ,@OkRef = '<detallista:referenceIdentification type="ATZ"/>'


  IF CHARINDEX('<detallista:alternatePartyIdentification type="SELLER_ASSIGNED_IDENTIFIER_FOR_A_PARTY"></detallista:alternatePartyIdentification>',@XML,1) >0
  OR CHARINDEX('<detallista:alternatePartyIdentification type="SELLER_ASSIGNED_IDENTIFIER_FOR_A_PARTY"/>',@XML,1) >0
    SELECT @Ok=71600 ,@OkRef = '<detallista:alternatePartyIdentification type="SELLER_ASSIGNED_IDENTIFIER_FOR_A_PARTY"/>'


  IF CHARINDEX('<detallista:alternateTradeItemIdentification type="SUPPLIER_ASSIGNED"></detallista:alternateTradeItemIdentification>',@XML,1) >0
  OR CHARINDEX('<detallista:alternateTradeItemIdentification type="SUPPLIER_ASSIGNED"/>',@XML,1) >0 
    SELECT @Ok=71600 ,@OkRef = '<detallista:alternateTradeItemIdentification type="SUPPLIER_ASSIGNED"/>'
  
END 
GO

/******************************* spCFDFlexValidarXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCFDFlexValidarXML') AND TYPE = 'P')
DROP PROCEDURE spCFDFlexValidarXML
GO
CREATE PROCEDURE spCFDFlexValidarXML
  (
  @Modulo		varchar(5),
  @Mov			varchar(20),
  @Contacto		varchar(10),
  @XML			varchar(MAX),
  @Ok			int OUTPUT,
  @OkRef		varchar(255) OUTPUT
  ) 
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @IDSQL			varchar(100),
    @Validacion			nvarchar(MAX),
    @Parametros			nvarchar(MAX),
    @Error				int,
    @ErrorRef			varchar(255),
    @Clave				varchar(50)
    
  SELECT @Clave = XSD FROM MovTipoCFDFlex WHERE Modulo = @Modulo AND Mov = @Mov AND ISNULL(NULLIF(ISNULL(NULLIF(Contacto,''),'(Todos)'),'(Todos)'),@Contacto) = @Contacto

  SET @IDSQL = @Clave

  IF EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = @IDSQL)
  BEGIN  
    --SET @Validacion = 'DECLARE @x XML (' + '[' + RTRIM(@IDSQL) + ']' + ') ' + 'BEGIN TRY SET @x = ' + CHAR(39) + RTRIM(@XML) + CHAR(39) + ' END TRY BEGIN CATCH SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() END CATCH'
    SET @Validacion = 'DECLARE @x XML (' + '[' + RTRIM(@IDSQL) + ']' + ') ' + 'BEGIN TRY SET @x = @XML END TRY BEGIN CATCH SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() END CATCH'
    SET @Parametros = '@XML varchar(max), @Error int OUTPUT, @ErrorRef varchar(255) OUTPUT'
    EXEC xpCFDFlexValidarXML @XML, @Ok OUTPUT,@OkRef OUTPUT 
    EXECUTE sp_executesql @Validacion, @Parametros, @XML = @XML, @Error = @Error OUTPUT, @ErrorRef = @ErrorRef OUTPUT
    IF @Error IS NOT NULL SELECT @Ok = @Error, @OkRef = @ErrorRef
  END
END 
GO

/**************** spCFDFlexCancelar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexCancelar') and type = 'P') drop procedure dbo.spCFDFlexCancelar
GO             
CREATE PROCEDURE spCFDFlexCancelar
		@Estacion		int,
		@Empresa		varchar(5),
		@Modulo			varchar(5),
		@ID				int,		
		@Estatus		varchar(15),
		@Ok				int OUTPUT,
		@OkRef			varchar(255) OUTPUT
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @FechaCancelacion			datetime,
	@CFDFecha					datetime,
	@CFDEmpresa					varchar(5),
	@MovID						varchar(20),
	@CFDSerie					varchar(20),
	@CFDFolio					varchar(20),
	@CFDRFC						varchar(15),
	@CFDImporte					float,
	@CFDImpuesto1				float,
	@CFDImpuesto2				float,
	@TipoCambio					float    
    
    
  IF @Estatus = 'CANCELADO'
  BEGIN

	SET @CFDFecha     = NULL		
	SET @CFDEmpresa   = NULL				
	SET @MovID        = NULL					
	SET @CFDSerie     = NULL				
	SET @CFDFolio     = NULL				
	SET @CFDRFC       = NULL					
	SET @CFDImporte   = NULL				
	SET @CFDImpuesto1 = NULL			
	SET @CFDImpuesto2 = NULL			
	SET @TipoCambio   = NULL				

    IF @Modulo = 'VTAS' SELECT @FechaCancelacion = ISNULL(v.FechaCancelacion,GETDATE()), @Modulo = 'VTAS', @CFDFecha = v.FechaRegistro, @CFDEmpresa = v.Empresa, @MovID = ISNULL(v.MovID,0.0), @CFDSerie = dbo.fnSerieConsecutivo(ISNULL(v.MovID,0.0)), @CFDFolio = dbo.fnFolioConsecutivo(ISNULL(v.MovID,'')), @CFDRFC = ISNULL(c.RFC,''), @CFDImporte = ISNULL(vtce.TotalNeto,0.0), @CFDImpuesto1 = ISNULL(Impuesto1Total,0.0), @CFDImpuesto2 = ISNULL(Impuesto2Total,0.0), @TipoCambio = v.TipoCambio FROM Venta v JOIN Cte c ON c.Cliente = v.Cliente JOIN VentaTCalcExportacion  vtce ON vtce.ID = v.ID WHERE v.ID = @ID ELSE
    IF @Modulo = 'CXC'  SELECT @FechaCancelacion = ISNULL(v.FechaCancelacion,GETDATE()), @Modulo = 'CXC',  @CFDFecha = v.FechaRegistro, @CFDEmpresa = v.Empresa, @MovID = ISNULL(v.MovID,0.0), @CFDSerie = dbo.fnSerieConsecutivo(ISNULL(v.MovID,0.0)), @CFDFolio = dbo.fnFolioConsecutivo(ISNULL(v.MovID,'')), @CFDRFC = ISNULL(c.RFC,''), @CFDImporte = ISNULL(v.Importe,0.0),      @CFDImpuesto1 = ISNULL(v.Impuestos,0.0),    @CFDImpuesto2 = 0.0,                        @TipoCambio = v.TipoCambio FROM Cxc v  JOIN Cte c ON c.Cliente = v.Cliente WHERE ID = @ID ELSE
    IF @Modulo = 'COMS' SELECT @FechaCancelacion = FechaCancelacion FROM Compra   WHERE ID = @ID ELSE
    IF @Modulo = 'CXP'  SELECT @FechaCancelacion = FechaCancelacion FROM Cxp      WHERE ID = @ID ELSE
    IF @Modulo = 'GAS'  SELECT @FechaCancelacion = FechaCancelacion FROM Gasto    WHERE ID = @ID  

    IF @Modulo IN ('VTAS','CXC')
    BEGIN 
      IF NOT EXISTS(SELECT 1 FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID) --REQ 14790
        INSERT CFD (Modulo,  ModuloID, Fecha,     Ejercicio,       Periodo,          Empresa,  MovID,  Serie,     Folio,     RFC,     Importe,     Impuesto1,     Impuesto2,     TipoCambio)
            VALUES (@Modulo, @ID,      @CFDFecha, YEAR(@CFDFecha), MONTH(@CFDFecha), @Empresa, @MovID, @CFDSerie, @CFDFolio, @CFDRFC, @CFDImporte, @CFDImpuesto1, @CFDImpuesto2, @TipoCambio)
      IF @@ERROR <> 0 SET @Ok = 1                   
    END
    
    IF @Ok IS NULL
    BEGIN

      UPDATE CFD
         SET FechaCancelacion = @FechaCancelacion,
             Fecha            = ISNULL(Fecha,@CFDFecha), 
             Empresa          = ISNULL(Empresa,@CFDEmpresa), 
             MovID            = ISNULL(MovID,@MovID), 
             Serie            = ISNULL(Serie,@CFDSerie), 
             Folio            = ISNULL(Folio,@CFDFolio), 
             RFC              = ISNULL(RFC,@CFDRFC), 
             Importe          = ISNULL(Importe,@CFDImporte), 
             Impuesto1        = ISNULL(Impuesto1,@CFDImpuesto1), 
             Impuesto2        = ISNULL(Impuesto2,@CFDImpuesto2), 
             TipoCambio       = ISNULL(TipoCambio,@TipoCambio)         
       WHERE Modulo = @Modulo
         AND ModuloID = @ID
      IF @@ERROR <> 0 SET @Ok = 1       
    END
  END  
END
GO

/**************** fnCFDFlexParcialidadNumero ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexParcialidadNumero') DROP FUNCTION fnCFDFlexParcialidadNumero
GO
CREATE FUNCTION dbo.fnCFDFlexParcialidadNumero
(@OrigenSerie varchar(20), @OrigenFolio int, @OrigenUUID varchar(50))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @ParcialidadNumero int
  
  SELECT @OrigenSerie = NULLIF(@OrigenSerie,''), @OrigenFolio = NULLIF(@OrigenFolio,0), @ParcialidadNumero = 0
  IF @OrigenUUID IS NULL
  BEGIN
    IF @OrigenSerie IS NOT NULL AND @OrigenFolio IS NOT NULL
    BEGIN
      SELECT @ParcialidadNumero = ISNULL(MAX(ParcialidadNumero),0) FROM CFD WHERE OrigenSerie = @OrigenSerie AND OrigenFolio = @OrigenFolio AND Modulo = 'VTAS'
      IF @ParcialidadNumero = 0
        SELECT @ParcialidadNumero = ISNULL(MAX(ParcialidadNumero),0) FROM CFD WHERE OrigenSerie = @OrigenSerie AND OrigenFolio = @OrigenFolio AND Modulo = 'CXC'
    END
  END
  ELSE
  BEGIN
    SELECT @ParcialidadNumero = ISNULL(MAX(ParcialidadNumero),0) FROM CFD WHERE OrigenUUID = @OrigenUUID
  END

  SELECT @ParcialidadNumero = ISNULL(@ParcialidadNumero,0) + 1
  RETURN (@ParcialidadNumero)
 END
GO

/**************** xpCFDFlexAntes ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDFlexAntes') and type = 'P') drop procedure dbo.xpCFDFlexAntes
GO             
CREATE PROCEDURE xpCFDFlexAntes
		@Estacion		int,
		@Empresa		varchar(5),
		@Modulo			varchar(5),
		@ID				int,		
		@Estatus		varchar(15),
		@Ok				int OUTPUT,
		@OkRef			varchar(255) OUTPUT,
		
		@LlamadaExterna	bit = 0,
		@Mov			varchar(20) = NULL,
		@MovID			varchar(20) = NULL,
		@Contacto		varchar(10) = NULL,
		@CrearArchivo	bit = 0,
		@Debug			bit = 0,
		@XMLFinal		varchar(max) = NULL OUTPUT,
		@Encripcion     varchar(20) = NULL

AS BEGIN
  RETURN
END
GO

/**************** xpCFDFlexDespues ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDFlexDespues') and type = 'P') drop procedure dbo.xpCFDFlexDespues
GO             
CREATE PROCEDURE xpCFDFlexDespues
		@Estacion					int,
		@Empresa					varchar(5),
		@Modulo						varchar(5),
		@ID							int,		
		@Estatus					varchar(15),
		@Ok							int			OUTPUT,
		@OkRef						varchar(255) OUTPUT,
		
		@LlamadaExterna				bit,
		@Mov						varchar(20),
		@MovID						varchar(20),
		@Contacto					varchar(10),
		@CrearArchivo				bit,
		@Debug						bit,
		@XMLFinal					varchar(max) OUTPUT,
		@Encripcion					varchar(20)
					
AS BEGIN
  RETURN
END
GO

/**************** spCFDFlexTempVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexTempVerificar') and type = 'P') drop procedure dbo.spCFDFlexTempVerificar
GO             
CREATE PROCEDURE spCFDFlexTempVerificar
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Modulo		char(5), 
		   @ID			int, 			
		   @Estatus		char(15), 
                   @EstatusNuevo	char(15),
		   @Usuario		char(10),
		   @FechaEmision	datetime, 	
		   @FechaRegistro	datetime,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @LlamadaExterna      bit = 0,
		   @Contacto		varchar(10) = NULL,
		   @Estacion		int = NULL,
		   @ModificarModulo     bit = 0,
		   @Continuar           bit = 1 OUTPUT,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
		   	    	    
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  @CFDFlexEstatus               varchar(20),
  @Comprobante			varchar(50),
  @Adenda			varchar(50),
  @FechaServidor		datetime,
  @Timbrado                     bit,
  @CFDI                         bit,
  @BloquearMovOtraFecha         bit,
  @NoValidarOrigenDocumento     bit,
  @TipoCambio                   float,
  @OrigenModulo			varchar(5),
  @OrigenMovimiento		varchar(20),
  @MovTipoCFDFlexEstatus        varchar(20),
  @MovOrigen                    varchar(20),
  @CFDEsParcialidad             bit,
  
  
  @CorteCuentaDe                varchar(10),
  @CorteCuentaA               varchar(10)
 
  IF @Ok IS NULL
    SET @CFDFlexEstatus = 'PROCESANDO'  

  IF ISNULL(@Estatus,'') = @EstatusNuevo
    SET @Continuar = 0

  SELECT @Comprobante = NULL, @Adenda = NULL, @Timbrado = 0, @FechaServidor = dbo.fnFechaSinHora(GETDATE())
  
  IF NULLIF(@Ok,0) IS NOT NULL
    SET @Continuar = 0

  SELECT @CFDI = ISNULL(CFDI,0)--,         @BloquearMovOtraFecha = ISNULL(BloquearMovOtraFecha,0)
    FROM EmpresaGral 
   WHERE Empresa = @Empresa

  SELECT @NoValidarOrigenDocumento = ISNULL(NoValidarOrigenDocumento,0)
    FROM EmpresaCFD
   WHERE Empresa = @Empresa


    IF NULLIF(@Contacto,'') IS NULL SET @Contacto = '(Todos)'
    
  IF @LlamadaExterna = 0
  BEGIN
    IF @Modulo = 'VTAS' SELECT @Contacto = Cliente,   @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal FROM Venta    WHERE ID = @ID ELSE
    IF @Modulo = 'CXC'  SELECT @Contacto = Cliente,   @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal, @MovOrigen = Origen FROM Cxc      WHERE ID = @ID ELSE
    IF @Modulo = 'COMS' SELECT @Contacto = Proveedor, @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal FROM Compra   WHERE ID = @ID ELSE
    IF @Modulo = 'CXP'  SELECT @Contacto = Proveedor, @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal FROM Cxp      WHERE ID = @ID ELSE
    IF @Modulo = 'GAS'  SELECT @Contacto = Acreedor,  @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal FROM Gasto    WHERE ID = @ID ELSE
    IF @Modulo = 'CORTE'SELECT @Contacto = CorteCuentaDe,  @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal FROM Corte WHERE ID = @ID 
  END ELSE
  BEGIN
    IF NULLIF(@Contacto,'') IS NULL SET @Contacto = '(Todos)'
    
    IF @Mov IS NULL AND @Ok IS NULL SELECT @Ok = 10160 ELSE
    IF @Mov IS NOT NULL AND NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov) AND @Ok IS NULL SELECT @Ok = 14055 ELSE    
    IF @MovID IS NULL AND @Ok IS NULL SELECT @Ok = 20915 ELSE
    IF @Contacto IS NOT NULL AND NOT EXISTS(SELECT * FROM MovTipoCFDFlex WHERE Modulo = @Modulo AND Mov = @Mov AND Contacto = @Contacto) AND @Ok IS NULL SELECT @Ok = 28020, @OkRef = @Contacto
  END
  IF @BloquearMovOtraFecha = 1 AND @Estatus = 'CONCLUIDO'
    IF @FechaEmision <> @FechaServidor SET @Ok = 10555
  
 
  IF NULLIF(@MovTipo,'') IS NULL
    SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  --Primero se busca el cliente especifico  
  SELECT 
    @Comprobante = Comprobante,
    @Adenda = Adenda,
    @MovTipoCFDFlexEstatus = NULLIF(Estatus,''),
    @OrigenModulo = NULLIF(OrigenModulo,''),
    @OrigenMovimiento = NULLIF(OrigenMov,'')
    FROM MovTipoCFDFlex
   WHERE Modulo = @Modulo
     AND Mov = @Mov
     AND Contacto = @Contacto

  --Si no se encuentra, se busca una configuración genérica
  IF @Comprobante IS NULL AND @Adenda IS NULL
  BEGIN  
    SELECT 
      @Comprobante = Comprobante,
      @Adenda = Adenda,
      @MovTipoCFDFlexEstatus = NULLIF(Estatus,''),
      @OrigenModulo = NULLIF(OrigenModulo,''),
      @OrigenMovimiento = NULLIF(OrigenMov,'')
      FROM MovTipoCFDFlex
     WHERE Modulo = @Modulo
       AND Mov = @Mov
       AND ISNULL(NULLIF(ISNULL(NULLIF(Contacto,''),'(Todos)'),'(Todos)'),@Contacto) = @Contacto
  END

  IF @OK IS NULL
  BEGIN
    IF EXISTS(SELECT 1 FROM CFD WHERE ModuloID = @ID AND Modulo = @Modulo AND ISNULL(Timbrado,0) = 1 AND @CFDI = 1) --REQ 14790
      SET @Continuar = 0
    ELSE
    IF EXISTS(SELECT 1 FROM CFD WHERE ModuloID = @ID AND Modulo = @Modulo AND Documento IS NOT NULL AND @CFDI = 0) --REQ 14790
      SET @Continuar = 0
  END

  IF @OrigenModulo IS NOT NULL AND @OrigenMovimiento IS NOT NULL AND @Ok IS NULL
  BEGIN
    IF NOT EXISTS(SELECT 1 --REQ 14790
                    FROM  MovFlujo
                   WHERE Empresa = @Empresa
                     AND DModulo = @Modulo
                     AND DMov = @Mov
                     AND DMovID = @MovID
                     AND Cancelado = 0
                     AND OModulo = @OrigenModulo
                     AND OMov = @OrigenMovimiento
                 )
      SET @Continuar = 0
  END

  IF @MovOrigen IS NULL
    SELECT @MovOrigen = dbo.fnCFDFlexOrigenDetalle(@ID)

  IF @Modulo = 'CXC' AND ('CXC.D' IN(SELECT Clave FROM MovTipo WHERE Mov = @MovOrigen AND Modulo = @Modulo) AND @NoValidarOrigenDocumento = 1)
  BEGIN
    SELECT @CFDEsParcialidad = ISNULL(CFDEsParcialidad,0) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
    IF @CFDEsParcialidad = 0
    BEGIN
      SELECT @Ok = 71670
      SET @Continuar = 0
    END
  END
  
  IF @Modulo = 'CXC' AND @MovTipo = 'CXC.C' AND @CFDEsParcialidad = 1
    IF(SELECT COUNT(1) FROM CxcD WHERE ID = @ID AND NULLIF(AplicaID,'') IS NOT NULL) > 1 SELECT @Ok = 60210 --REQ 14790

  IF @Modulo = 'CORTE'
  BEGIN
    SELECT @CorteCuentaDe = ISNULL(CorteCuentaDe, ''), @CorteCuentaA = ISNULL(CorteCuentaA, '') FROM Corte WHERE ID = @ID

    IF(@CorteCuentaDe <> @CorteCuentaA) OR(@CorteCuentaDe = '') OR(@CorteCuentaA = '')
      SELECT @Ok = 28055
  END         
              
  IF @Comprobante IS NULL AND @Adenda IS NULL SET @Continuar = 0

  IF @MovTipoCFDFlexEstatus <> '(VARIOS)'
  BEGIN
	IF (@MovTipoCFDFlexEstatus <> @Estatus) OR (@MovTipoCFDFlexEstatus IS NULL) OR (NULLIF(@Estatus,'') IS NULL) SET @Continuar = 0  
  END ELSE
	IF @Estatus NOT IN (SELECT NULLIF(Estatus,'') FROM MovTipoCFDFlexEstatus WHERE Modulo = @Modulo AND Mov = @Mov AND Contacto = @Contacto)
	BEGIN
	  IF @Estatus NOT IN (SELECT NULLIF(Estatus,'') FROM MovTipoCFDFlexEstatus WHERE Modulo = @Modulo AND Mov = @Mov AND ISNULL(NULLIF(ISNULL(NULLIF(Contacto,''),'(Todos)'),'(Todos)'),@Contacto) = @Contacto) SET @Continuar = 0
	END

  IF @OK IS NULL
    EXEC spCFDFlexValidarPlantillaConfiguracion @Comprobante, @Modulo, @CFDI, @Ok OUTPUT, @OkRef OUTPUT
  IF @ModificarModulo = 1
  BEGIN  
    IF @Modulo = 'VTAS' UPDATE Venta SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID ELSE    
    IF @Modulo = 'CXC' UPDATE Cxc SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID ELSE        
    IF @Modulo = 'COMS' UPDATE Compra SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID ELSE           
    IF @Modulo = 'CXP' UPDATE Cxp SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID ELSE           
    IF @Modulo = 'GAS' UPDATE Gasto SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID     ELSE              
    IF @Modulo = 'CORTE' UPDATE Corte SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID  
  END
  
  RETURN
END
GO

--EXEC spCFDFlexTempVerificar  @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @Contacto, @Estacion, @Continuar  OUTPUT, @Ok  OUTPUT, @OkRef   OUTPUT
/******************************* xpeDocAddenda2 *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.xpeDocAddenda2') AND TYPE = 'P')
DROP PROCEDURE xpeDocAddenda2
GO
CREATE PROCEDURE xpeDocAddenda2
  (
  @Estacion			int,			
  @Empresa			varchar(5),  
  @Modulo			varchar(5),		
  @Mov				varchar(20),
  @ID				int,
  @Estatus			varchar(15),
  @eDoc				varchar(50) OUTPUT
  )
AS
BEGIN
  RETURN
END
GO

/**************** spCFDFlex ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlex') and type = 'P') drop procedure dbo.spCFDFlex
GO             
CREATE PROCEDURE spCFDFlex
		@Estacion		int,
		@Empresa		varchar(5),
		@Modulo			varchar(5),
		@ID				int,
		@Estatus		varchar(15),
		
		@Ok				int OUTPUT,
		@OkRef			varchar(255) OUTPUT,
		
		@LlamadaExterna	bit = 0,
		@Mov			varchar(20) = NULL,
		@MovID			varchar(20) = NULL,
		@Contacto		varchar(10) = NULL,
		@CrearArchivo	bit = 0,
		@Debug			bit = 0,
		@XMLFinal		varchar(max) = NULL OUTPUT,
		@Encripcion     varchar(20) = NULL,
		@EstatusAnterior		varchar(15) = NULL
			
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@XMLSAT					varchar(max),
	@XMLADENDA				varchar(max),
	@XML					varchar(max),
	@Temporal				varchar(255),
        @RutaTemporal				varchar(255),
	@Comprobante				varchar(50),
	@Adenda					varchar(50),
	@FechaRegistro				datetime,
	@OkError				int,
	@OkRefError				varchar(255),
	@RutaError				varchar(255),
	@DocumentoXML				varchar(max),
	@iDatos					int,
	@CFDFecha				datetime,
	@CFDSerie				varchar(10),
	@CFDFolio				int,
	@CFDRFC					varchar(15),
	@CFDAprobacion				varchar(15),
	@CFDImporte				money,
	@CFDImpuesto1				money,
	@CFDImpuesto2				money,
	@CFDRetencion1				money,
	@CFDRetencion2				money,	
	@CFDnoCertificado			varchar(20),
	@CFDSello				varchar(max),
	@CFDCadenaOriginal			varchar(max),
	@MovTipoCFDFlexEstatus		        varchar(15),
	@Archivo				varchar(255),
	@Usuario				varchar(10),
	@EnviarAlAfectar			bit,
	@AlmacenarTipo				varchar(20),
	@TipoCambio				float,
	@CFDI					bit,
	@TipoCFDI				bit,
	@TimbrarEnTransaccion		        bit,
	@RutaTimbrarCFDI			varchar(255),
	@Timbrado				bit,
	@PrefijoCFDI				varchar(255),
	@RutaCFDI				varchar(255),
	@CFDUUID				uniqueidentifier,
	@CFDFechaTimbrado			datetime,
        @TFDVersion				varchar(10),
        @SelloSAT				varchar(max),
        @noCertificadoSAT			varchar(20),
        @BloquearMovOtraFecha		        bit,
        @FechaEmision				datetime,
        @FechaServidor				datetime,
        @Sucursal				int,
	@MovTipo				varchar(20),
        @OrigenModulo				varchar(5),
        @OrigenMovimiento			varchar(20),
	@MovOrigen				varchar(20),
        @CFDEsParcialidad			bit,
        @OrigenUUID				uniqueidentifier,
        @OrigenMovID				varchar(20),
        @OrigenSerie				varchar(10),
        @OrigenFolio				varchar(4),
        @Caracter				char(1),
        @ParcialidadNumero			int,
        @SerieFolioFiscalOrig		        varchar(50),
        @NoValidarOrigenDocumento	        bit,
	@FolioFiscalOrig			varchar(50),
        --@CorteCuentaDe				varchar(10),
        --@CorteCuentaA				varchar(10),

	--REQ Q3069 CFDGT
        @Sellar					bit,
 --REQ 15739  
        @CFDFlexEstatus                         varchar(15),
        @Continuar                              bit,
		@Adenda2			varchar(50),
		@XMLADENDA2		    varchar(max),
		@RutaFirmaSAT			varchar(255),
		@ExisteFirmaSAT			int,
		@Existe                 int    

  SELECT @Comprobante = NULL, @Adenda = NULL, @Timbrado = 0, @FechaServidor = dbo.fnFechaSinHora(GETDATE())
  
  EXEC xpCFDFlexAntes @Estacion, @Empresa, @Modulo, @ID, @Estatus, @Ok OUTPUT, @OkRef OUTPUT, @LlamadaExterna, @Mov, @MovID, @Contacto, @CrearArchivo, @Debug, @XMLFinal OUTPUT, @Encripcion

  IF @LlamadaExterna = 0
  BEGIN
    IF @Modulo = 'VTAS' SELECT @Contacto = Cliente,   @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal FROM Venta    WHERE ID = @ID ELSE
    IF @Modulo = 'CXC'  SELECT @Contacto = Cliente,   @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal, @MovOrigen = Origen FROM Cxc      WHERE ID = @ID ELSE
    IF @Modulo = 'COMS' SELECT @Contacto = Proveedor, @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal FROM Compra   WHERE ID = @ID ELSE
    IF @Modulo = 'CXP'  SELECT @Contacto = Proveedor, @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal FROM Cxp      WHERE ID = @ID ELSE
    IF @Modulo = 'GAS'  SELECT @Contacto = Acreedor,  @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal FROM Gasto    WHERE ID = @ID 
    --ELSE
    --IF @Modulo = 'CORTE'SELECT @Contacto = CorteCuentaDe,  @Mov = Mov, @MovID = MovID, @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Usuario = Usuario, @TipoCambio = TipoCambio, @Sucursal = Sucursal FROM Corte WHERE ID = @ID 
  END 
  SET @continuar = 1
  EXEC spCFDFlexTempVerificar  @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusAnterior, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @LlamadaExterna, @Contacto, @Estacion, 0, @Continuar  OUTPUT, @Ok  OUTPUT, @OkRef   OUTPUT

  IF @Continuar = 0 AND @Ok IS NULL  RETURN
  
  IF @Continuar = 1 AND @Ok IS NULL
  BEGIN
    SELECT @CFDI = ISNULL(CFDI,0)--,         @BloquearMovOtraFecha = ISNULL(BloquearMovOtraFecha,0)
      FROM EmpresaGral 
     WHERE Empresa = @Empresa

    SELECT @NoValidarOrigenDocumento = ISNULL(NoValidarOrigenDocumento,0)
      FROM EmpresaCFD
     WHERE Empresa = @Empresa  
  
    SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
    --Primero se busca el cliente especifico  
    SELECT 
      @Comprobante = Comprobante,
      @Adenda = Adenda,
      @MovTipoCFDFlexEstatus = NULLIF(Estatus,''),
      @OrigenModulo = NULLIF(OrigenModulo,''),
      @OrigenMovimiento = NULLIF(OrigenMov,'')
      FROM MovTipoCFDFlex
     WHERE Modulo = @Modulo
       AND Mov = @Mov
       AND Contacto = @Contacto

    --Si no se encuentra, se busca una configuración genérica
    IF @Comprobante IS NULL AND @Adenda IS NULL
    BEGIN  
      SELECT 
        @Comprobante = Comprobante,
        @Adenda = Adenda,
        @MovTipoCFDFlexEstatus = NULLIF(Estatus,''),
        @OrigenModulo = NULLIF(OrigenModulo,''),
        @OrigenMovimiento = NULLIF(OrigenMov,'')
        FROM MovTipoCFDFlex
       WHERE Modulo = @Modulo
         AND Mov = @Mov
         AND ISNULL(NULLIF(ISNULL(NULLIF(Contacto,''),'(Todos)'),'(Todos)'),@Contacto) = @Contacto
    END




    IF @MovOrigen IS NULL
      SELECT @MovOrigen = dbo.fnCFDFlexOrigenDetalle(@ID)

    IF @Modulo = 'CXC' AND ('CXC.D' IN(SELECT Clave FROM MovTipo WHERE Mov = @MovOrigen AND Modulo = @Modulo) AND @NoValidarOrigenDocumento = 1)
    BEGIN
      SELECT @CFDEsParcialidad = CFDEsParcialidad FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
      IF @CFDEsParcialidad = 0
      BEGIN
        SELECT @Ok = 71670
        RETURN
      END
      ELSE
        EXEC spCFDFlexActualizaDocNoAuto @ID  
    END

    IF @OK IS NULL
      EXEC spCFDFlexValidarPlantillaConfiguracion @Comprobante, @Modulo, @CFDI, @Ok OUTPUT, @OkRef OUTPUT
      

    SELECT @RutaTemporal = RutaTemporal, @EnviarAlAfectar = EnviarAlAfectar, @RutaTimbrarCFDI = RutaTimbrarCFDI FROM EmpresaCFD WHERE Empresa = @Empresa  
    SELECT @Temporal = @RutaTemporal + CASE WHEN SUBSTRING(REVERSE(@RutaTemporal),1,1) <> '\' THEN '\' ELSE '' END + 'Temporal' + CONVERT(varchar,@Estacion) + '.XML'  
    SET @RutaError = REPLACE(@Temporal,'Temporal' + CONVERT(varchar,@Estacion) + '.XML','Error' + CONVERT(varchar,@Estacion) + '.XML')  

    --REQ Q3069 CFDGT
    SELECT @TipoCFDI = ISNULL(TipoCFDI,0),
           @TimbrarEnTransaccion = ISNULL(TimbrarEnTransaccion,0),
           @Sellar = ISNULL(Sellar,0)
      FROM eDoc
     WHERE Modulo = @Modulo AND eDoc = @Comprobante
    
    --Elimina cualquier archivo de error que pudiera existir derivado de una ejecucion anterior.  
    EXEC spEliminarArchivo @RutaError, @Ok OUTPUT, @OkRef OUTPUT    
	  
    --REQ Q3069 CFDGT
	IF @Ok IS NULL AND @Sellar = 1
		BEGIN
		    SELECT @RutaFirmaSAT = RutaFirmaSAT FROM EmpresaCFD WHERE Empresa = @Empresa
			--Verificamos que exista el archivo FirmaSAT.exe para continuar con la verificacion
			EXEC master.dbo.xp_fileexist @RutaFirmaSAT, @ExisteFirmaSAT OUTPUT
			IF ISNULL(@ExisteFirmaSAT,0) = 1
				EXEC spCFDFlexValidarCertificado @Estacion, @Empresa, @Sucursal, 'Sucursal', @FechaRegistro, @Temporal, @Ok OUTPUT, @OkRef OUTPUT
		END

    IF @Ok IS NULL
      EXEC speDocXML @Estacion, @Empresa, @Modulo, @Mov, @ID, @Comprobante, @Estatus, 0, 1, @XMLSAT OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @LlamadaExterna, @Contacto

    IF @Ok IS NULL
      EXEC speDocXML @Estacion, @Empresa, @Modulo, @Mov, @ID, @Adenda, @Estatus, 0, 1, @XMLAdenda OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @LlamadaExterna, @Contacto

    IF @Ok IS NULL
      EXEC xpeDocAddenda2 @Estacion, @Empresa, @Modulo, @Mov, @ID, @Estatus, @Adenda2 OUTPUT

    IF @Ok IS NULL AND @Adenda2 IS NOT NULL
      EXEC speDocXML @Estacion, @Empresa, @Modulo, @Mov, @ID, @Adenda2, @Estatus, 0, 1, @XMLAdenda2 OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @LlamadaExterna, @Contacto

    IF @Ok IS NULL
    BEGIN
      SET @XML = REPLACE(@XMLSAT,'_ADDENDA_DOCUMENTO_',ISNULL(@XMLADENDA,''))
	  SET @XML = REPLACE(@XML,'_ADDENDA_DOCUMENTO2_',ISNULL(@XMLADENDA2,''))
      SET @XML = REPLACE(@XML,'<cfdi:Addenda></cfdi:Addenda>','')
      SET @XML = REPLACE(@XML,'<Addenda></Addenda>','')
    END

    --REQ Q3069 CFDGT
    IF @Ok IS NULL AND CHARINDEX('<FactDocGT xmlns' + CHAR(58) + 'xsi="http' + CHAR(58) + '//www.w3.org/2001/XMLSchema-instance" xmlns="http' + CHAR(58) + '//www.fact.com.mx/schema/gt"', @XMLSAT) = 0
      EXEC spCFDFlexValidarXMLImporte @Empresa, @XMLSAT, @RutaError, @TipoCFDI, @Ok OUTPUT, @OkRef OUTPUT

    --REQ Q3069 CFDGT
    IF @Ok IS NULL AND CHARINDEX('<FactDocGT xmlns' + CHAR(58) + 'xsi="http' + CHAR(58) + '//www.w3.org/2001/XMLSchema-instance" xmlns="http' + CHAR(58) + '//www.fact.com.mx/schema/gt"', @XMLSAT) <> 0
      EXEC spCFDFlexValidarXMLImportefdgt @Empresa, @XMLSAT, @RutaError, @TipoCFDI, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spCFDFlexRegenerarArchivo @Empresa, @Temporal, @XML, @Ok OUTPUT, @OkRef OUTPUT
    
    --REQ Q3069 CFDGT
    IF @Ok IS NULL AND @Sellar = 1
      EXEC spCFDFlexSellarXML @Estacion, @Empresa, @Sucursal, @Temporal, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @Encripcion
          
    --REQ Q3069 CFDGT
    IF @Ok IS NULL AND @Sellar = 1
      EXEC spCFDFlexInsertarCertificadoXML @Estacion, @Empresa, @Sucursal, 'Sucursal', 1, @Temporal, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spCFDFlexRegenerarArchivo @Empresa, @Temporal, @XML, @Ok OUTPUT, @OkRef OUTPUT

    --REQ Q3069 CFDGT
    IF @Ok IS NULL AND @Sellar = 1
      EXEC spCFDFlexInsertarNoCertificadoXML @Estacion, @Empresa, @Sucursal, 'Sucursal', @Temporal, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    --REQ Q3069 CFDGT
    IF @Ok IS NULL AND @Sellar = 1
      EXEC spCFDFlexInsertarPipeStringXML @Estacion, @Empresa, @Temporal, @XML OUTPUT, @CFDCadenaOriginal OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL      
    BEGIN
      EXEC spCFDFlexValidarXML @Modulo, @Mov, @Contacto, @XML, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NOT NULL SELECT @OkRef = CONVERT(varchar,@Ok) + '. ' + ISNULL(@OkRef,''), @Ok = 71600
    END  
      
    IF @Ok IS NULL AND @CFDI = 1 AND @TipoCFDI = 1
    BEGIN
      EXEC spCFDFlexTimbrarCFDI @Estacion, @Empresa, @Modulo, @Mov, @MovID, @Temporal, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 
    END  

    IF @CFDI = 1 AND @TipoCFDI = 1 AND @Ok IS NULL
      SELECT @Timbrado = 1   		    

    IF @CFDI = 1 AND @TipoCFDI = 1 AND ISNULL(@TimbrarEnTransaccion,0) = 0 AND @Ok IS NOT NULL    
      SELECT @Ok = NULL, @OkRef = NULL, @Timbrado = 0
    
     IF @Ok IS NULL AND @Modulo ='VTAS'
   UPDATE Venta SET CFDTimbrado =@Timbrado WHERE ID =@ID 
   
   IF @Ok IS NULL AND @Modulo ='CXC'
   UPDATE Cxc SET CFDTimbrado =@Timbrado WHERE ID =@ID 
     
    IF @Ok IS NOT NULL
    BEGIN
      SELECT @OkError = NULL, @OkRefError = NULL
      EXEC spCFDFlexRegenerarArchivo @Empresa, @RutaError, @XML, @OkError OUTPUT, @OkRefError OUTPUT
    END  
    
    IF @Ok IS NULL AND @LlamadaExterna = 0
    BEGIN
      IF EXISTS(SELECT 1 FROM MoveDoc WHERE ID = @ID AND Modulo = @Modulo AND Empresa = @Empresa) --REQ 14790
      BEGIN
        UPDATE MoveDoc
           SET eDoc = @XML
         WHERE ID = @ID
           AND Modulo = @Modulo
           AND Empresa = @Empresa
        IF @@ERROR <> 0 SET @Ok = 1     
      END     
      ELSE
      BEGIN
        INSERT MoveDoc (Empresa, Modulo, ID, eDoc) VALUES (@Empresa, @Modulo, @ID, @XML)
        IF @@ERROR <> 0 SET @Ok = 1           
      END
    END           

    IF @Ok IS NULL
    BEGIN
      IF @TipoCFDI = 0 OR @CFDI = 0 AND @Ok IS NULL
      BEGIN 
	  SET @DocumentoXML = '<?xml version="1.0" encoding="Windows-1252"?>' + @XML
	  SET @DocumentoXML = REPLACE(@XML,'xmlns=','xmlns' + CHAR(58) + 'Temp=')	  
        EXEC sp_xml_preparedocument @iDatos OUTPUT, @DocumentoXML
        SELECT  
          @CFDFecha = CONVERT(datetime,RTRIM(REPLACE(fecha,'Z',''))),			
		  @CFDSerie = serie,			
		  @CFDFolio = folio,			
		  @CFDAprobacion = RTRIM(ISNULL(anoAprobacion,'')) + RTRIM(ISNULL(noAprobacion,'')),		
		  @CFDnoCertificado = noCertificado,	
		  @CFDSello = sello,
		  @CFDImporte = ISNULL(subTotal,0.0)-ISNULL(descuento,0.0), --BUG15201
		  @OrigenMovID = SerieFolioFiscalOrig,
		  @OrigenUUID = FolioFiscalOrig
          FROM OPENXML (@iDatos, '/Comprobante', 1) WITH (fecha varchar(50), serie varchar(10), folio int, noAprobacion varchar(15), noCertificado varchar(20), sello varchar(255), subTotal money, descuento money, anoAprobacion varchar(15), SerieFolioFiscalOrig varchar(20), FolioFiscalOrig uniqueidentifier) --BUG15201

        SELECT  
      	  @CFDRFC = rfc			
          FROM OPENXML (@iDatos, '/Comprobante/Receptor', 1) WITH (rfc varchar(15))

        SELECT  
		  @CFDImpuesto1 = ISNULL(SUM(ISNULL(importe,0.0)),0.0)			
          FROM OPENXML (@iDatos, '/Comprobante/Impuestos/Traslados/Traslado', 1) WITH (importe money, impuesto varchar(50))
         WHERE impuesto = 'IVA' 

        SELECT  
		  @CFDImpuesto2 = ISNULL(SUM(ISNULL(importe,0.0)),0.0)			
          FROM OPENXML (@iDatos, '/Comprobante/Impuestos/Traslados/Traslado', 1) WITH (importe money, impuesto varchar(50))
         WHERE impuesto = 'IEPS' 

        SELECT  
		  @CFDRetencion1 = ISNULL(SUM(ISNULL(importe,0.0)),0.0)			
          FROM OPENXML (@iDatos, '/Comprobante/Impuestos/Retenciones/Retencion', 1) WITH (importe money, impuesto varchar(50))
         WHERE impuesto = 'ISR' 

        SELECT  
		  @CFDRetencion2 = ISNULL(SUM(ISNULL(importe,0.0)),0.0)			
          FROM OPENXML (@iDatos, '/Comprobante/Impuestos/Retenciones/Retencion', 1) WITH (importe money, impuesto varchar(50))
         WHERE impuesto = 'IVA' 

        EXEC sp_xml_removedocument @iDatos  
        
      END    
      ELSE
      IF @Ok IS NULL
      BEGIN
	  SET @DocumentoXML = '<?xml version="1.0" encoding="Windows-1252"?>' + @XML
	  
	  --REQ Q3069 CFDGT
        IF @DocumentoXML NOT LIKE '%<gs1' + CHAR(58) + 'invoice%'
        BEGIN
        --REQ Q3069 CFDGT
          SET @PrefijoCFDI = '<ns xmlns' + CHAR(58) + 'cfdi="http' + CHAR(58) + '//www.sat.gob.mx/cfd/3" xmlns' + CHAR(58) + 'tfd="http' + CHAR(58) + '//www.sat.gob.mx/TimbreFiscalDigital"/>'
          EXEC sp_xml_preparedocument @iDatos OUTPUT, @DocumentoXML, @PrefijoCFDI
          SET @DocumentoXML = REPLACE(@DocumentoXML,'<?xml version="1.0" encoding="Windows-1252"?><?xml version="1.0" encoding="Windows-1252"?>', '<?xml version="1.0" encoding="Windows-1252"?>')
          SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante'
          SELECT  
            @CFDFecha = CONVERT(datetime,RTRIM(REPLACE(fecha,'Z',''))),			
		  @CFDSerie = serie,			
		  @CFDFolio = folio,			
		  @CFDAprobacion = RTRIM(ISNULL(anoAprobacion,'')) + RTRIM(ISNULL(noAprobacion,'')),		
		  @CFDnoCertificado = noCertificado,	
		  @CFDSello = sello,
		  @CFDImporte = ISNULL(subTotal,0.0)-ISNULL(descuento,0.0), --BUG15201
		  @OrigenMovID = SerieFolioFiscalOrig,
		  @OrigenUUID = FolioFiscalOrig
            FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (fecha varchar(50), serie varchar(10), folio int, noAprobacion varchar(15), noCertificado varchar(20), sello varchar(255), subTotal money, descuento money, anoAprobacion varchar(15), SerieFolioFiscalOrig varchar(20), FolioFiscalOrig uniqueidentifier) --BUG15201

          SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Receptor'
          SELECT  
      	  @CFDRFC = rfc			
            FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (rfc varchar(15))

          SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Impuestos/cfdi' + CHAR(58) + 'Traslados/cfdi' + CHAR(58) + 'Traslado'
          SELECT  
		  @CFDImpuesto1 = ISNULL(SUM(ISNULL(importe,0.0)),0.0)			
            FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (importe money, impuesto varchar(50))
           WHERE impuesto = 'IVA' 

          SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Impuestos/cfdi' + CHAR(58) + 'Traslados/cfdi' + CHAR(58) + 'Traslado'
          SELECT  
		  @CFDImpuesto2 = ISNULL(SUM(ISNULL(importe,0.0)),0.0)			
            FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (importe money, impuesto varchar(50))
           WHERE impuesto = 'IEPS' 

          SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Impuestos/cfdi' + CHAR(58) + 'Retenciones/cfdi' + CHAR(58) + 'Retencion'
          SELECT  
		  @CFDRetencion1 = ISNULL(SUM(ISNULL(importe,0.0)),0.0)			
            FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (importe money, impuesto varchar(50))
           WHERE impuesto = 'ISR' 

          SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Impuestos/cfdi' + CHAR(58) + 'Retenciones/cfdi' + CHAR(58) + 'Retencion'
          SELECT  
		  @CFDRetencion2 = ISNULL(SUM(ISNULL(importe,0.0)),0.0)			
            FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (importe money, impuesto varchar(50))
           WHERE impuesto = 'IVA' 

          SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Complemento/tfd' + CHAR(58) + 'TimbreFiscalDigital'
          SELECT      
		  @CFDUUID = UUID,
		  @CFDFechaTimbrado = CONVERT(datetime,RTRIM(REPLACE(FechaTimbrado,'Z',''))),
            @TFDVersion = version,
            @SelloSAT = selloSAT,
            @noCertificadoSAT = noCertificadoSAT
            FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (UUID uniqueidentifier, FechaTimbrado varchar(50), version varchar(10), selloSAT varchar(max), noCertificadoSAT varchar(20))

          EXEC sp_xml_removedocument @iDatos
        --REQ Q3069 CFDGT        
        END
        --REQ Q3069 CFDGT
        ELSE
        BEGIN
        	SET @DocumentoXML = REPLACE(@DocumentoXML,'xmlns=', 'Temp=')	  
          SELECT @PrefijoCFDI = '<ns xmlns' + CHAR(58) + 'gs1="urn' + CHAR(58) + 'ean.ucc' + CHAR(58) + 'pay' + CHAR(58) + '2" xmlns' + CHAR(58) + 'xsi="http' + CHAR(58) + '//www.w3.org/2001/XMLSchema-instance" xsi' + CHAR(58) + 'noNamespaceSchemaLocation="http' + CHAR(58) + '//www.mysuitemex.com/fact/schema/gt/DTEgt.xsd"/>'
          EXEC sp_xml_preparedocument @iDatos OUTPUT, @DocumentoXML, @PrefijoCFDI

          SET @RutaCFDI = '/DTE/Documento/gs1' + CHAR(58) + 'invoice'
          SELECT   
            @CFDFechaTimbrado = CONVERT(datetime,RTRIM(creationDateTime))
            FROM OPENXML (@iDatos, @RutaCFDI, 2) WITH (creationDateTime varchar(50))

          SET @RutaCFDI = '/DTE/Documento/CAE/DCAE'
          SELECT
            @CFDSerie = Serie,
            @CFDFolio = NumeroDocumento,
            @CFDAprobacion = NumeroAutorizacion,
            @CFDRFC = NITReceptor,
            @CFDFecha = FechaEmision,
            @CFDImpuesto1 = ISNULL(IVA,0.0),
            @CFDImporte   = ISNULL(ImporteTotal,0.0)          
            FROM OPENXML (@iDatos, @RutaCFDI, 2) WITH (Serie varchar(10), NumeroDocumento int, NumeroAutorizacion varchar(15), NITReceptor varchar(15), FechaEmision datetime, IVA money, ImporteTotal money)  

          SET @RutaCFDI = '/DTE/Documento/CAE/FCAE'
          SELECT
            @SelloSAT = SignatureValue
            FROM OPENXML (@iDatos, @RutaCFDI, 2) WITH (SignatureValue varchar(50))  
    
          EXEC sp_xml_removedocument @iDatos
          
          UPDATE CFD
             SET SelloSAT = @SelloSAT
           WHERE Modulo = @Modulo
             AND ModuloID = @ID
          
        END
      --REQ Q3069 CFDGT
      END
    END
    
    IF @Ok IS NULL
    BEGIN
      IF EXISTS(SELECT 1 FROM CFD WHERE ModuloID = @ID AND Modulo = @Modulo) DELETE FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID --REQ 14790
      IF @@ERROR <> 0 SET @Ok = 1      
    END  

    IF @Ok IS NULL
    BEGIN
      SELECT @FolioFiscalOrig = dbo.fnCFDFlexCampoOrigen('CXC', @ID, 'FolioFiscalOrig')
      SELECT @SerieFolioFiscalOrig = dbo.fnCFDFlexCampoOrigen('CXC', @ID, 'SerieFolioFiscalOrig')
      SELECT @OrigenSerie = dbo.fnSerieConsecutivo(@SerieFolioFiscalOrig)
      SELECT @OrigenFolio = dbo.fnFolioConsecutivo(@SerieFolioFiscalOrig)

      SELECT @ParcialidadNumero = dbo.fnCFDFlexParcialidadNumero(@OrigenSerie, @OrigenFolio, @OrigenUUID)
    END

    IF @Ok IS NULL
    BEGIN
      INSERT CFD (Modulo,  ModuloID, Fecha,     Ejercicio,       Periodo,          Empresa,  MovID,  Serie,     Folio,     RFC,     Aprobacion,     Importe,     Impuesto1,     Impuesto2,     Retencion1,     Retencion2,     noCertificado,     Sello,     CadenaOriginal,      Documento, TipoCambio,  Timbrado,  UUID,     FechaTimbrado,     TFDVersion,  SelloSAT,  noCertificadoSAT,  OrigenUUID,  OrigenSerie,  OrigenFolio,  ParcialidadNumero) 
          VALUES (@Modulo, @ID,      @CFDFecha, YEAR(@CFDFecha), MONTH(@CFDFecha), @Empresa, @MovID, @CFDSerie, @CFDFolio, @CFDRFC, @CFDAprobacion, @CFDImporte, @CFDImpuesto1, @CFDImpuesto2, @CFDRetencion1, @CFDRetencion2, @CFDnoCertificado, @CFDSello, @CFDCadenaOriginal,  @XML,      @TipoCambio, @Timbrado, @CFDUUID, @CFDFechaTimbrado, @TFDVersion, @SelloSAT, @noCertificadoSAT, @OrigenUUID, @OrigenSerie, @OrigenFolio, @ParcialidadNumero) 
      UPDATE CFD
			SET TFDCadenaOriginal = dbo.fnCFDFlexCadenaOriginalTFDI(@Modulo, @ID)
			WHERE Modulo = @Modulo 
			AND ModuloID = @ID 
      IF @@ERROR <> 0 SET @Ok = 1      
    END

    IF @Ok IS NULL
      EXEC xpCFDFlexDespues @Estacion, @Empresa, @Modulo, @ID, @Estatus, @Ok OUTPUT, @OkRef OUTPUT, @LlamadaExterna, @Mov, @MovID, @Contacto, @CrearArchivo, @Debug, @XMLFinal, @Encripcion
 --REQ 15739
    IF @Ok IS NULL
      SELECT @CFDFlexEstatus = 'CONCLUIDO'
    ELSE  
      SELECT @CFDFlexEstatus = 'ERROR'  
      
    IF @Modulo = 'VTAS' UPDATE Venta SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID ELSE    
    IF @Modulo = 'CXC' UPDATE Cxc SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID ELSE        
    IF @Modulo = 'COMS' UPDATE Compra SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID ELSE           
    IF @Modulo = 'CXP' UPDATE Cxp SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID ELSE           
    IF @Modulo = 'GAS' UPDATE Gasto SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID 
    --ELSE              
    --IF @Modulo = 'CORTE' UPDATE Corte SET CFDFlexEstatus = @CFDFlexEstatus WHERE ID = @ID 
    
    
    IF @Ok IS NULL AND @CrearArchivo = 1
    BEGIN
      SELECT @Archivo = @RutaTemporal + CASE WHEN SUBSTRING(REVERSE(@RutaTemporal),1,1) <> '\' THEN '\' ELSE '' END + @Modulo + '_' + CONVERT(varchar,@ID) + '.XML'    
      EXEC spCFDFlexRegenerarArchivo @Empresa, @Archivo, @XML, @Ok OUTPUT, @OkRef OUTPUT    
    END
      
    IF (@Ok IS NULL AND ISNULL(@TipoCFDI,0) = 0 AND @EnviarAlAfectar = 1) OR (@EnviarAlAfectar = 1 AND ISNULL(@CFDI,0) = 1 AND ISNULL(@TipoCFDI,0) = 1 AND @Ok IS NULL AND @Timbrado = 1)  
    BEGIN
      SELECT @AlmacenarTipo = NULL
      SELECT @AlmacenarTipo = NULLIF(AlmacenarTipo,'') FROM CteCFD WHERE Cliente = @Contacto 
     
      EXEC spCFDFlexGenerarPDF @Empresa, @Modulo, @Mov, @ID, @Usuario, 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      
      IF @AlmacenarTipo = 'Adicional'
        EXEC spCFDFlexGenerarPDF @Empresa, @Modulo, @Mov, @ID, @Usuario, 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  
      IF @Ok IS NULL
      BEGIN
        UPDATE CFD SET GenerarPDF = 1 WHERE Modulo = @Modulo AND ModuloID = @ID
        IF @@ERROR <> 0 SET @Ok = 1
      END  	    
    END
  END    
   
  IF EXISTS(SELECT * FROM CFDFlexTemp WHERE ID = @ID AND Modulo = @Modulo)    
    DELETE CFDFlexTemp WHERE ID = @ID AND Modulo = @Modulo    
  IF @Debug = 1 
    SELECT CONVERT(xml,@XML)
--SELECT @Ok = 1
  SELECT @XMLFinal = @XML

  IF @Ok IS NULL
   EXEC spVerificarArchivo @Temporal, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT	
  IF ISNULL(@Existe,0) = 1 AND @Ok IS NULL
   EXEC spEliminarArchivo @Temporal, @Ok OUTPUT, @OkRef OUTPUT  

END
GO


 /************************ xpValidarCamposCFDFlex  *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.xpValidarCamposCFDFlex') AND type = 'P') DROP PROCEDURE dbo.xpValidarCamposCFDFlex
GO             
CREATE PROCEDURE xpValidarCamposCFDFlex
    
   @Modulo      varchar(5),
   @ID          int,
   @Ok          int             OUTPUT,
   @OkRef       varchar(255)    OUTPUT	     
AS BEGIN
 

 RETURN
END
GO
--/* DEMO */ spAfectar 'VTAS', 926, 'AUTORIZAR', 'Todo', NULL, 'DEMO', @Estacion=4
--select * from cfd


 --REQ 15739

 /************************ spValidarCamposCFDFlex  *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spValidarCamposCFDFlex') AND type = 'P') DROP PROCEDURE dbo.spValidarCamposCFDFlex
GO             
CREATE PROCEDURE spValidarCamposCFDFlex
    
   @Modulo      varchar(5),
   @ID          int,
   @Ok          int             OUTPUT,
   @OkRef       varchar(255)    OUTPUT
--//WITH ENCRYPTION	 	     
AS BEGIN
  DECLARE 
  @MovTipo      varchar(20),
  @Concepto     varchar(50),
  @Referencia	varchar(50),
  @Ref1			varchar(20),
  @Ref2			varchar(20),
  @Ref3			varchar(20),
  @Ref4			varchar(20),
  @Ref5			varchar(20)
  
  
  IF @Modulo = 'VTAS'
  BEGIN
    SELECT @MovTipo = mt.Clave FROM MovTipo mt JOIN Venta v ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' WHERE v.ID = @ID
    SELECT @Referencia = NULLIF(dbo.fneDocVentaReferenciaMetodoCobro(@ID, 1),'')
    SELECT @Ref1=  dbo.fnSplit(@Referencia,',', 1)   
	SELECT @Ref2=  dbo.fnSplit(@Referencia,',', 2)
    SELECT @Ref3=  dbo.fnSplit(@Referencia,',', 3)
    SELECT @Ref4=  dbo.fnSplit(@Referencia,',', 4)
    SELECT @Ref5=  dbo.fnSplit(@Referencia,',', 5)
  
    IF (@Referencia IS NOT NULL) 
	BEGIN
      IF CHARINDEX (',', @Referencia)=0 AND LEN(@Referencia )<4 
        SELECT @Ok = 71605, @OkRef = ISNULL(@OkRef,'') +' El número de Cuenta es menor a cuatro dígitos '	
      ELSE 
	  --IF (@Ref1 is not null and len(@Ref1)<4) or (@Ref2 is not null and len(@Ref2)<4) or (@Ref3 is not null and len(@Ref3)<4) or (@Ref4 is not null and len(@Ref4)<4) or (@Ref5 is not null and len(@Ref5)<4)  
        IF (@Ref1 NOT IN (null, '') and len(@Ref1)<4) or (@Ref2 NOT IN (null, '') and len(@Ref2)<4) or (@Ref3 NOT IN (null, '') and len(@Ref3)<4) or (@Ref4 NOT IN (null, '') and len(@Ref4)<4) or (@Ref5 NOT IN (null, '') and len(@Ref5)<4)    
  	      SELECT @Ok = 71605, @OkRef = ISNULL(@OkRef,'') +' El número de Cuenta es menor a cuatro dígitos '	
	END	
    --IF (SELECT NULLIF(dbo.fneDocVentaReferenciaMetodoCobro(@ID, 0),'')) IS NULL
    --  SELECT @Ok = 71605, @OkRef = ISNULL(@OkRef,'') +' FormaDePago'      
  END


  IF @Modulo = 'CXC'
  BEGIN
    SELECT @MovTipo = mt.Clave, @Concepto = NULLIF(c.Concepto,'') FROM MovTipo mt JOIN Cxc c ON c.Mov = mt.Mov AND mt.Modulo = 'CXC' WHERE c.ID = @ID
    
    --IF (SELECT NULLIF(dbo.fneDocCxcReferenciaMetodoCobro(@ID, 1),'')) IS NULL
    --  SELECT @Ok = 71605, @OkRef = ISNULL(@OkRef,'') +' MetodoDePago'
      
    --IF (SELECT NULLIF(dbo.fneDocCxcReferenciaMetodoCobro(@ID, 0),'')) IS NULL
    --  SELECT @Ok = 71605, @OkRef = ISNULL(@OkRef,'') +' FormaDePago'  
      
    IF @Concepto IS NULL
      SELECT @Ok = 71605, @OkRef = ISNULL(@OkRef,'') +' Concepto'      
  END 
     
  EXEC xpValidarCamposCFDFlex @MODULO,@ID,@OK OUTPUT,@OKREF OUTPUT 

 RETURN
END
GO


/********* fnSplit ************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSplit')
DROP FUNCTION fnSplit
GO
CREATE FUNCTION [dbo].[fnSplit]
 (
	@Expression VARCHAR(max)
	, @Delimiter  VARCHAR(max)
	, @INDEX      INT
 )
 RETURNS VARCHAR(max)
 AS
 BEGIN
	DECLARE @RETURN  VARCHAR(max)
	DECLARE @Pos     INT
	DECLARE @PrevPos INT
	DECLARE @I       INT
IF @Expression IS NULL OR @Delimiter IS NULL OR DATALENGTH(@Delimiter) = 0 OR @INDEX < 1
	SET @RETURN = NULL
ELSE IF @INDEX = 1 
	BEGIN
		SET @Pos = CHARINDEX(@Delimiter, @Expression, 1)
		IF @Pos > 0 SET @RETURN = LEFT(@Expression, @Pos - 1)
	END 
ELSE 
	BEGIN
		SET @Pos = 0
		SET @I = 0
		WHILE (@Pos > 0 AND @I < @INDEX) OR @I = 0 
		BEGIN
			SET @PrevPos = @Pos
			SET @Pos = CHARINDEX(@Delimiter, @Expression, @Pos + DATALENGTH(@Delimiter))
			SET @I = @I + 1
		END
		IF @Pos = 0 AND @I = @INDEX
			SET @RETURN = SUBSTRING(@Expression, @PrevPos + DATALENGTH(@Delimiter), DATALENGTH(@Expression))
		ELSE IF @Pos = 0 AND @I <> @INDEX
			SET @RETURN = NULL
		ELSE
			SET @RETURN = SUBSTRING(@Expression, @PrevPos + DATALENGTH(@Delimiter), @Pos - @PrevPos - DATALENGTH(@Delimiter))
	END
RETURN @RETURN
END

GO


/**************** fnTipoCFD****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTipoCFD') DROP FUNCTION fnTipoCFD
GO
CREATE FUNCTION dbo.fnTipoCFD
(       @Modulo  varchar(5), @Mov      varchar(20), @Estatus    varchar(15))
 
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
    @Resultado bit,
    @Comprobante        varchar(50)

  SELECT @Resultado = 0

  SELECT  @Comprobante = Comprobante
    FROM MovTipoCFDFlex
   WHERE Modulo = @Modulo
     AND Mov = @Mov
     AND ISNULL(NULLIF(Contacto,''),'(Todos)') = '(Todos)'
     AND Estatus = @Estatus
       
  SELECT @Resultado = ISNULL(TipoCFD,0) FROM eDoc WHERE Modulo = @Modulo AND eDoc = @Comprobante    


  RETURN (@Resultado)
 END

GO

/**************** spInsertarCFDFlexTemp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInsertarCFDFlexTemp') and type = 'P') drop procedure dbo.spInsertarCFDFlexTemp
GO             
CREATE PROCEDURE spInsertarCFDFlexTemp
		    @Estacion           int,
		    @Empresa            varchar(5), 
		    @Modulo             varchar(5), 
		    @ID                 int, 
		    @EstatusNuevo       varchar(15),  
		    @Estatus            varchar(15), 
		    @Mov                varchar(20), 
		    @MovID              varchar(20),
                    @Ok                 int             OUTPUT,
                    @OkRef              varchar(255)    OUTPUT		    	    
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
   
     INSERT CFDFlexTemp(Estacion,  Empresa,  Modulo,  ID,  Estatus,       EstatusAnterior, Mov,  MovID)
     SELECT             @Estacion, @Empresa, @Modulo, @ID, @EstatusNuevo, @Estatus,        @Mov, @MovID  
     IF @@ERROR <> 0 SET @Ok = 1    
     
     IF @Ok IS NULL AND dbo.fnTipoCFD(@Modulo, @Mov, @EstatusNuevo)= 1
       EXEC spValidarCamposCFDFlex  @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT     

  RETURN
END
GO

 --REQ 15739
/**************** spGenerarCFDFlexLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCFDFlexLote') and type = 'P') drop procedure dbo.spGenerarCFDFlexLote
GO             
CREATE PROCEDURE spGenerarCFDFlexLote
		    @Estacion           int,
		    @Empresa            varchar(5)	    
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Modulo     varchar(5), 
    @ID         int, 
    @Estatus    varchar(15) ,
    @Ok         int,
    @OkRef      varchar(255)
  
  DECLARE crCFDTemp CURSOR LOCAL FOR
    SELECT Empresa, Modulo, ID, Estatus 
      FROM CFDFlexPendiente
     WHERE ID IN(SELECT ID FROM LISTAID WHERE Estacion = @Estacion) 
    
  OPEN crCFDTemp
  FETCH NEXT FROM crCFDTemp INTO @Empresa, @Modulo, @ID, @Estatus 
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    EXEC spCFDFlex @Estacion, @Empresa, @Modulo, @ID, @Estatus, @Ok OUTPUT, @OkRef OUTPUT

    FETCH NEXT FROM crCFDTemp INTO @Empresa, @Modulo, @ID, @Estatus 
  END
  CLOSE crCFDTemp
  DEALLOCATE crCFDTemp  
  
  IF @Ok IS NOT NULL
  BEGIN
    SELECT @OkRef =  ISNULL(Descripcion,'') +ISNULL(@OkRef,'') FROM MensajeLista WHERE Mensaje = @Ok
    SELECT @OkRef
  END  
  ELSE
    SELECT 'PROCESO CONCLUIDO EXISTOSAMENTE'  

  RETURN
END
GO

--BUG18913
/**************** spRegenerarCFDFlex ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRegenerarCFDFlex') and type = 'P') drop procedure dbo.spRegenerarCFDFlex
GO             
CREATE PROC spRegenerarCFDFlex
			@Estacion		int,
			@Empresa		varchar(5),
			@Modulo			varchar(5),
			@ID				int,
			@Estatus		varchar(15),
			
			@Ok				int				= NULL OUTPUT,
			@OkRef			varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @OkDesc           	varchar(255),
    @OkTipo           	varchar(50)

  EXEC spCFDFlex @Estacion, @Empresa, @Modulo, @ID, @Estatus, @Ok OUTPUT, @OkRef OUTPUT

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


/**************** spCFDFlexGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexGenerar') and type = 'P') drop procedure dbo.spCFDFlexGenerar
GO             
CREATE PROCEDURE spCFDFlexGenerar
		    @Estacion        int,
		    @ID              int,
		    @Modulo          varchar(5),
    		    @Ok              int 	 OUTPUT,
    		    @OkRef           varchar(255)OUTPUT		    
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa            varchar(5),
    @Estatus            varchar(15),
    @EstatusAnterior    varchar(15),
    @Mov                varchar(20),
    @MovID              varchar(20),
    @eDocOk             int,
    @eDocOkRef          varchar(255)
    
    
    SELECT @Empresa = Empresa, @Estatus = Estatus, @EstatusAnterior = EstatusAnterior, @Mov = Mov, @MovID = MovID
      FROM CFDFlexTemp
     WHERE ID = @ID AND Modulo = @Modulo AND Estacion = @@SPID 
     
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
  BEGIN
    SELECT @eDocOk = NULL, @eDocOkRef = NULL  
    EXEC spCFDFlex @Estacion, @Empresa, @Modulo, @ID, @Estatus, @eDocOk OUTPUT, @eDocOkRef OUTPUT, 0, @Mov, @MovID, NULL, 0, 0, NULL, NULL, @EstatusAnterior
    IF @eDocOk IS NOT NULL SELECT @Ok = @eDocOk, @OkRef = @eDocOkRef
  END

  RETURN
END
GO

/**************** spCFDFlexAfectarSinMovFinal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDFlexAfectarSinMovFinal') and type = 'P') drop procedure dbo.spCFDFlexAfectarSinMovFinal
GO             
CREATE PROCEDURE spCFDFlexAfectarSinMovFinal
        @Empresa        varchar(5),
        @Modulo         varchar(5),
        @Mov            varchar(20),
        @MovID          varchar(20),
        @ID             int,
        @EstatusNuevo   varchar(15),
        @Estatus        varchar(15)= NULL,        
        @Ok             int  = NULL    OUTPUT,
        @OkRef          varchar(255)= NULL     OUTPUT
--//WITH ENCRYPTION		
AS BEGIN
  DECLARE
    @eDoc			bit,
    @CFDFlex			bit,    
    @MovTipoCFDFlex		bit ,
    @CFD                        bit


  SELECT @eDoc = ISNULL(eDoc, 0),
         @CFDFlex = ISNULL(CFDFlex, 0)
    FROM EmpresaGral 
   WHERE Empresa = @Empresa    
     
     
  SELECT @CFD = CFD,
         @MovTipoCFDFlex = ISNULL(CFDFlex,0)
    FROM MovTipo
   WHERE Modulo = @Modulo AND Mov = @Mov     
 
 --REQ 15739  
  IF EXISTS(SELECT * FROM CFDFlexTemp WHERE Estacion = @@SPID)    
    DELETE CFDFlexTemp WHERE Estacion = @@SPID

  IF (@MovTipoCFDFlex = 1) AND (@CFDFlex = 1) AND (@eDoc = 1) AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) --MEJORA2104
  BEGIN
    EXEC spInsertarCFDFlexTemp @@SPID, @Empresa, @Modulo, @ID, @EstatusNuevo,  @Estatus, @Mov, @MovID, @Ok OUTPUT, @OkRef OUTPUT
  END
  IF (@MovTipoCFDFlex = 1) AND (@CFDFlex = 1) AND (@eDoc = 1) AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) --MEJORA2104 
  BEGIN
    EXEC spCFDFlexCancelar @@SPID, @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT  

  END

    IF EXISTS(SELECT * FROM CFDFlexTemp WHERE Estacion = @@SPID) AND @Ok IS NULL
    EXEC  spCFDFlexGenerar @@SPID, @ID, @Modulo, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO    
 
if OBJECT_ID('dbo.xpCFDFlexAlmacenarPDF') is not null DROP PROCEDURE dbo.xpCFDFlexAlmacenarPDF
GO
CREATE PROCEDURE dbo.xpCFDFlexAlmacenarPDF
    @Empresa                            varchar(5),
    @Modulo                             varchar(5),
    @ModuloID                           int,
    @AlmacenarPDF                       varchar(5)      OUTPUT,
    @Ok                                 int             OUTPUT,
    @OkRef                              varchar(255)    OUTPUT
AS BEGIN
    RETURN
END
GO
/************** spMovFormatoIntelisis *************/
if exists (select * from sysobjects where id = object_id('dbo.spMovFormatoIntelisis') and type = 'P') DROP PROCEDURE dbo.spMovFormatoIntelisis
GO
CREATE PROCEDURE spMovFormatoIntelisis
                   @Empresa     varchar(5),
		           @Modulo	varchar(5),
		           @Mov		varchar(20),
                   @ID		int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FormatoIntelisis       varchar(30)

  SET @FormatoIntelisis = ''
  
    IF @Modulo = 'VTAS'
    SELECT @Mov = Mov
      FROM Venta 
     WHERE ID = @ID

  IF @Modulo = 'CXC'
    SELECT @Mov = Mov
      FROM Cxc 
     WHERE ID = @ID
  
  SELECT @FormatoIntelisis = CFDReporteIntelisis 
    FROM MovTipo 
   WHERE Modulo = @Modulo AND Mov = @Mov 
     
  SET @FormatoIntelisis = ISNULL(@FormatoIntelisis,'')


  SELECT 'ReporteIntelisis' = @FormatoIntelisis

  RETURN 
END
GO
if exists (select * from sysobjects where id = object_id('dbo.spMovReporteIntelisis') and type = 'P') drop procedure dbo.spMovReporteIntelisis
GO
CREATE PROCEDURE spMovReporteIntelisis
                   @Empresa     varchar(5),
		           @Modulo	varchar(5),
		           @Mov		varchar(20),
                   @ID		int = NULL,
                   @Afectar bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ReporteIntelisis       bit,
    @Reporteador            varchar(30),
    @AlmacenarPDF           bit,
    @GenerarPdfAfectar      bit,
    @CFDReporteIntelisis    varchar(30),
    @Estatus                varchar(15),
    @EstatusCfg             varchar(15),--Bug 17745
    @CFDFlex                bit

  SET @ReporteIntelisis = 0
  
  SELECT @CFDFlex = CFDFlex 
    FROM EmpresaGral
   WHERE Empresa = @Empresa --Bug 18845
  SET @CFDFlex = ISNULL(@CFDFlex,0)
  
  IF @CFDFlex = 1
  BEGIN
    SELECT @Reporteador = Reporteador, @AlmacenarPDF = AlmacenarPDF,@GenerarPdfAfectar = GenerarPdfAfectar
      FROM EmpresaCFD 
     WHERE Empresa = @Empresa
    
    IF @Modulo = 'VTAS'
      SELECT @Estatus = Estatus, @Mov = Mov
        FROM Venta 
       WHERE ID = @ID
  
    IF @Modulo = 'CXC'
      SELECT @Estatus = Estatus, @Mov = Mov
        FROM Cxc 
       WHERE ID = @ID

    IF @Reporteador = 'Reporteador Intelisis' AND @AlmacenarPDF = 1 AND (@GenerarPdfAfectar = 1 OR @Afectar = 0)
    BEGIN
      SELECT @CFDReporteIntelisis = CFDReporteIntelisis 
        FROM MovTipo 
       WHERE Modulo = @Modulo AND Mov = @Mov 

      SELECT @EstatusCfg = MAX(ISNULL(Estatus,''))
        FROM MovTipoCFDFlex 
       WHERE Modulo = @Modulo AND Mov = @Mov
       
      IF ISNULL(@EstatusCfg,'') = ''
        SELECT @EstatusCfg = ISNULL(eDocEstatus,'')
          FROM MovTipo
         WHERE Modulo = @Modulo AND Mov = @Mov
         
      IF ISNULL(@CFDReporteIntelisis,'') <> '' AND (@Estatus = @EstatusCfg OR (@EstatusCfg = '(VARIOS)' AND @Estatus IN (SELECT NULLIF(Estatus,'') FROM MovTipoCFDFlexEstatus WHERE Modulo = @Modulo AND Mov = @Mov)))
      BEGIN
          SET @ReporteIntelisis = 1
      END
    END
  END

  SELECT 'ReporteIntelisis' = @ReporteIntelisis

  RETURN 
END
GO
/************** spMovDirectorioIntelisis *************/
if exists (select * from sysobjects where id = object_id('dbo.spMovDirectorioIntelisis') and type = 'P') drop procedure dbo.spMovDirectorioIntelisis
GO
CREATE PROCEDURE spMovDirectorioIntelisis
                   @Empresa     varchar(5),
		           @Modulo	varchar(5),
		           @Mov		varchar(20),
                   @ID		int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Agente			char(10),
    @MovID			varchar(20),
    @FechaEmision	datetime,
    @FechaRegistro	datetime,    
    @ArchivoXML		varchar(255),
    @ArchivoPDF		varchar(255),
    @Nombre			varchar(100),
    @eMail			varchar(100),
    @Serie			varchar(20),
    @Folio			varchar(20),
    @AlmacenarTipo  varchar(20),
    @EnviarTipo		varchar(20),
    @Sucursal       int,
    @Cliente        varchar(10),
    @Ruta			varchar(255),
    @NomArch        varchar(255)

  SET @Ruta = ''
  IF @Modulo = 'VTAS' SELECT @Sucursal = Sucursal, @Cliente = RTRIM(Cliente), @Agente = RTRIM(Agente), @Mov = RTRIM(Mov), @MovID = RTRIM(MovID), @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Folio = MovID FROM Venta WHERE ID = @ID
  IF @Modulo = 'CXC'  SELECT @Sucursal = Sucursal, @Cliente = RTRIM(Cliente), @Agente = RTRIM(Agente), @Mov = RTRIM(Mov), @MovID = RTRIM(MovID), @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Folio = MovID FROM CXC   WHERE ID = @ID

  SELECT @Ruta = AlmacenarRuta, @Nombre = Nombre
    FROM EmpresaCFD 
   WHERE Empresa = @Empresa 

  
  SELECT @Nombre = REPLACE(@Nombre,' ','')
  SELECT @NomArch = @Nombre 
  SELECT @NomArch = REPLACE(@NomArch, '<Movimiento>', LTRIM(RTRIM(ISNULL(@Mov,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Serie>', LTRIM(RTRIM(ISNULL(@Serie,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Folio>', LTRIM(RTRIM(CONVERT(varchar, LTRIM(RTRIM(ISNULL(@Folio,'')))))))
  SELECT @NomArch = REPLACE(@NomArch, '<Cliente>', LTRIM(RTRIM(ISNULL(@Cliente,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Empresa>', LTRIM(RTRIM(ISNULL(@Empresa,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Sucursal>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @Sucursal),''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Ejercicio>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, YEAR(GETDATE())),''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Periodo>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, MONTH(GETDATE())),''))))

  SELECT @Ruta = REPLACE(@Ruta, '<Cliente>', LTRIM(RTRIM(ISNULL(@Cliente,''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Ejercicio>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, YEAR(GETDATE())),''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Periodo>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, MONTH(GETDATE())),''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Empresa>', LTRIM(RTRIM(ISNULL(@Empresa,''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Sucursal>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @Sucursal),''))))

     
  IF ISNULL(@Ruta,'') <> '' 
    SET @Ruta = @Ruta +'\'
  

  SELECT 'DirectorioIntelisis' = @Ruta

  RETURN 
END
GO

/************** spMovRutaIntelisis *************/
if exists (select * from sysobjects where id = object_id('dbo.spMovRutaIntelisis') and type = 'P') drop procedure dbo.spMovRutaIntelisis
GO
CREATE PROCEDURE spMovRutaIntelisis
                   @Empresa     varchar(5),
		           @Modulo	varchar(5),
		           @Mov		varchar(20),
                   @ID		int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Agente			char(10),
    @MovID			varchar(20),
    @FechaEmision	datetime,
    @FechaRegistro	datetime,    
    @ArchivoXML		varchar(255),
    @ArchivoPDF		varchar(255),
    @Nombre			varchar(100),
    @eMail			varchar(100),
    @Serie			varchar(20),
    @Folio			varchar(20),
    @AlmacenarTipo  varchar(20),
    @EnviarTipo		varchar(20),
    @Sucursal       int,
    @Cliente        varchar(10),
    @Ruta			varchar(255),
    @NomArch        varchar(255)

  SET @Ruta = ''
  IF @Modulo = 'VTAS' SELECT @Sucursal = Sucursal, @Cliente = RTRIM(Cliente), @Agente = RTRIM(Agente), @Mov = RTRIM(Mov), @MovID = RTRIM(MovID), @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Folio = MovID FROM Venta WHERE ID = @ID
  IF @Modulo = 'CXC'  SELECT @Sucursal = Sucursal, @Cliente = RTRIM(Cliente), @Agente = RTRIM(Agente), @Mov = RTRIM(Mov), @MovID = RTRIM(MovID), @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro, @Folio = MovID FROM CXC   WHERE ID = @ID

  SELECT @Ruta = AlmacenarRuta, @Nombre = Nombre
    FROM EmpresaCFD 
   WHERE Empresa = @Empresa 

  SELECT @Nombre = REPLACE(@Nombre,' ','')
  SELECT @NomArch = @Nombre 
  SELECT @NomArch = REPLACE(@NomArch, '<Movimiento>', LTRIM(RTRIM(ISNULL(@Mov,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Serie>', LTRIM(RTRIM(ISNULL(@Serie,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Folio>', LTRIM(RTRIM(CONVERT(varchar, LTRIM(RTRIM(ISNULL(@Folio,'')))))))
  SELECT @NomArch = REPLACE(@NomArch, '<Cliente>', LTRIM(RTRIM(ISNULL(@Cliente,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Empresa>', LTRIM(RTRIM(ISNULL(@Empresa,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Sucursal>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @Sucursal),''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Ejercicio>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, YEAR(GETDATE())),''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Periodo>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, MONTH(GETDATE())),''))))

  SELECT @Ruta = REPLACE(@Ruta, '<Cliente>', LTRIM(RTRIM(ISNULL(@Cliente,''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Ejercicio>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, YEAR(GETDATE())),''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Periodo>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, MONTH(GETDATE())),''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Empresa>', LTRIM(RTRIM(ISNULL(@Empresa,''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Sucursal>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @Sucursal),''))))

     
  IF ISNULL(@Ruta,'') <> '' AND ISNULL(@NomArch,'') <> ''
    SET @Ruta = @Ruta + '\' + @NomArch
  
  IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = @Modulo AND ID = @ID AND CFD = 1 AND Nombre LIKE '%.pdf')
            INSERT AnexoMov (Sucursal,  Rama,    ID,        Nombre,          Direccion,   Tipo,      Icono, CFD) 
                     VALUES (@Sucursal, @Modulo, @ID, @NomArch+'.pdf', @Ruta+'.pdf', 'Archivo', 745,   1)  

  SELECT 'RutaIntelisis' = @Ruta

  RETURN 
END
GO
/************** spMovEnviarIntelisis *************/
if exists (select * from sysobjects where id = object_id('dbo.spMovEnviarIntelisis') and type = 'P') drop procedure dbo.spMovEnviarIntelisis
GO
CREATE PROCEDURE spMovEnviarIntelisis
                   @Empresa     varchar(5),
		           @Modulo	varchar(5),
		           @Mov		varchar(20),
                   @ID		int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Enviar					bit,
    @Archivos				varchar(255),
    @Para					varchar(255),
    @Reporteador            varchar(30),
    @Asunto					varchar(255),
    @Mensaje				varchar(255),
    @EnviarAlAfectar        bit,
    @AlmacenarPDF           bit,
    @ArchivoXML		varchar(255),
    @ArchivoPDF		varchar(255),
    @Cliente        varchar(10),
    @Nombre			varchar(100),
    @MovID          varchar(20),
    @Sucursal       int,
    @Agente         varchar(10),
    @FechaEmision   datetime,
    @FechaRegistro  datetime,
    @Serie			varchar(20),
    @Folio			bigint,
    @eMail          varchar(100)
    
    
    SELECT @Enviar = 0, @Archivos = '', @eMail = '', @Para = ''
    
    SELECT @Enviar = Enviar,
           @EnviarAlAfectar = EnviarAlAfectar,
           @AlmacenarPDF = AlmacenarPDF,
           @Asunto = EnviarAsunto,
           @Mensaje = EnviarMensaje,
           @Reporteador = Reporteador,
           @Nombre = Nombre
      FROM EmpresaCFD
     WHERE Empresa = @Empresa
     
     IF @Modulo = 'VTAS'
       SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Cliente = RTRIM(Cliente), @Agente = RTRIM(Agente), @Mov = RTRIM(Mov), @MovID = RTRIM(MovID), @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro FROM Venta WHERE ID= @ID

     IF @Modulo = 'CXC'
       SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Cliente = RTRIM(Cliente), @Agente = RTRIM(Agente), @Mov = RTRIM(Mov), @MovID = RTRIM(MovID), @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro FROM Cxc WHERE ID= @ID
     
     EXEC spMovIDEnSerieConsecutivo @MovID, @Serie OUTPUT, @Folio OUTPUT
     
	   SET @Nombre = ISNULL(@Nombre,'')
       SELECT @Nombre = REPLACE(@Nombre, '<Movimiento>', LTRIM(RTRIM(ISNULL(@Mov,''))))
       SELECT @Nombre = REPLACE(@Nombre, '<Serie>', LTRIM(RTRIM(ISNULL(@Serie,''))))
       SELECT @Nombre = REPLACE(@Nombre, '<Folio>', CONVERT(varchar, LTRIM(RTRIM(ISNULL(@Folio,'')))))
       SELECT @Nombre = REPLACE(@Nombre, '<Cliente>', LTRIM(RTRIM(ISNULL(@Cliente,''))))
       SELECT @Nombre = REPLACE(@Nombre, '<Empresa>', LTRIM(RTRIM(ISNULL(@Empresa,''))))
       SELECT @Nombre = REPLACE(@Nombre, '<Sucursal>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @Sucursal),''))))
       SELECT @Nombre = REPLACE(@Nombre, '<Ejercicio>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, YEAR(GETDATE())),''))))
       SELECT @Nombre = REPLACE(@Nombre, '<Periodo>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, MONTH(GETDATE())),''))))


     SELECT @Asunto  = REPLACE(@Asunto, '<Nombre>', @Nombre),
            @Mensaje = REPLACE(@Mensaje, '<Nombre>', @Nombre)
     
     SELECT @ArchivoPDF = Direccion
       FROM AnexoMov 
      WHERE Rama = @Modulo AND ID = @ID AND CFD = 1 AND Nombre LIKE '%.pdf'

     SELECT @ArchivoXML = Direccion
       FROM AnexoMov 
      WHERE Rama = @Modulo AND ID = @ID AND CFD = 1 AND Nombre LIKE '%.xml'
      
     IF ISNULL(@ArchivoPDF,'') <> ''
       SET @Archivos = @ArchivoPDF + ';'

     IF ISNULL(@ArchivoXML,'') <> ''
       SET @Archivos = @Archivos + @ArchivoXML    
	 
	 IF ISNULL(@ArchivoXML,'') = ''
       SET @Archivos = @ArchivoPDF      
     
     
       DECLARE crCteCto CURSOR LOCAL FOR 
         SELECT eMail
           FROM CteCto
          WHERE Cliente = @Cliente AND CFD_Enviar = 1 AND NULLIF(RTRIM(eMail), '') IS NOT NULL
        OPEN crCteCto
        FETCH NEXT FROM crCteCto INTO @eMail
        WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            IF @Para <> '' SELECT @Para = @Para+';'
            SELECT @Para = @Para + @eMail
          END
          FETCH NEXT FROM crCteCto INTO @eMail
        END
        CLOSE crCteCto
        DEALLOCATE crCteCto

        IF (@EnviarAlAfectar = 1) AND NULLIF(@Archivos,'') IS NOT NULL-- AND @Reporteador = 'Reporteador Intelisis' --Bug 21329
        BEGIN
          EXEC spCFDFlexEnviarCorreo @Empresa, @Para, @Asunto, @Mensaje, @Archivos
        END
		
  RETURN 
END
GO

/**************** spCFDAfectarSinMovFinal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDAfectarSinMovFinal') and type = 'P') drop procedure dbo.spCFDAfectarSinMovFinal
GO             
CREATE PROCEDURE spCFDAfectarSinMovFinal
        @Empresa        varchar(5),
        @Modulo         varchar(5),
        @Mov            varchar(20),
        @MovID          varchar(20),
        @ID             int,
        @EstatusNuevo   varchar(15),
        @Estatus        varchar(15)= NULL,        
        @Ok             int  = NULL    OUTPUT,
        @OkRef          varchar(255)= NULL     OUTPUT
--//WITH ENCRYPTION                     
AS BEGIN
  DECLARE
    @eDoc               bit,
    @CFDFlex                 bit,    
    @MovTipoCFDFlex          bit ,
    @CFD                        bit


  SELECT @eDoc = ISNULL(eDoc, 0),
         @CFDFlex = ISNULL(CFDFlex, 0)
    FROM EmpresaGral 
   WHERE Empresa = @Empresa    
     
     
  SELECT @CFD = CFD,
         @MovTipoCFDFlex = ISNULL(CFDFlex,0)
    FROM MovTipo
   WHERE Modulo = @Modulo AND Mov = @Mov     
 
 --REQ 15739  
  IF EXISTS(SELECT * FROM CFDFlexTemp WHERE Estacion = @@SPID)    
    DELETE CFDFlexTemp WHERE Estacion = @@SPID

  IF (@MovTipoCFDFlex = 1) AND (@CFDFlex = 1) AND (@eDoc = 1) AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) --MEJORA2104
  BEGIN
    EXEC spInsertarCFDFlexTemp @@SPID, @Empresa, @Modulo, @ID, @EstatusNuevo,  @Estatus, @Mov, @MovID, @Ok OUTPUT, @OkRef OUTPUT
  END
  IF (@MovTipoCFDFlex = 1) AND (@CFDFlex = 1) AND (@eDoc = 1) AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) --MEJORA2104 
  BEGIN
    EXEC spCFDFlexCancelar @@SPID, @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT  

  END

    IF EXISTS(SELECT * FROM CFDFlexTemp WHERE Estacion = @@SPID) AND @Ok IS NULL
    EXEC  spCFDFlexGenerar @@SPID, @ID, @Modulo, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO



-- CJ 02/Sep/2013 Bug 18439
/***************  spCFDRevisarTimbrado  ***************/
if OBJECT_ID('dbo.spCFDRevisarTimbrado') is not null
  drop procedure dbo.spCFDRevisarTimbrado
GO
CREATE PROCEDURE spCFDRevisarTimbrado
	@Empresa	varchar(5),
	@Mov		varchar(20),
	@ID		int,
	@Modulo		char(5) = 'VTAS'
WITH ENCRYPTION
AS BEGIN
  DECLARE @Timbrado bit

  SELECT @Timbrado = 1

  IF (((SELECT ISNULL(CFD, 0) FROM Empresa WHERE Empresa = @Empresa) = 1) AND 
      ((SELECT ISNULL(CFD, 0) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov) = 1)) OR
     (((SELECT ISNULL(CFDFlex, 0) FROM EmpresaGral WHERE Empresa = @Empresa) = 1) AND 
      ((SELECT ISNULL(CFDFlex, 0) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov) = 1)) BEGIN
      SELECT @Timbrado = 0
      IF EXISTS (SELECT * FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID)
        SELECT @Timbrado = Timbrado FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID
  END

  SELECT "Timbrado" = @Timbrado	
  RETURN
END
GO

/******************************* tgMovTipoCFDFlex *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgMovTipoCFDFlex') AND TYPE = 'tr') DROP TRIGGER tgMovTipoCFDFlex
GO
CREATE TRIGGER tgMovTipoCFDFlex ON MovTipoCFDFlex  
FOR DELETE  
AS  
BEGIN  
  DECLARE @Modulo	varchar(5),  
		  @Mov		varchar(20) ,  
		  @Contacto varchar(10)  
      
  SELECT @Modulo = Modulo, @Mov = Mov, @Contacto = Contacto FROM deleted  
    
  DELETE FROM MovTipoCFDFlexEstatus WHERE Modulo = @Modulo AND Mov = @Mov AND Contacto = @Contacto  
  
  RETURN  
END
GO