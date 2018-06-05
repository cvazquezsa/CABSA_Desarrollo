SET DATEFIRST 7
SET ANSI_NULLS ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE spConSATMonitorearRuta
	(
	@Ruta               varchar(4000),
	@RutaComponentes    varchar(4000),
	@RutaReemplazar     varchar(4000),
	@Tipo               varchar(20),
	@Modulo             varchar(20),
	@Empresa            char(5),
 	@Ok				    int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT
	)
AS
BEGIN
SET NOCOUNT ON
	DECLARE
		@RutaValidar varchar(4000),
		@Archivo     varchar(4000),
		@SQL         varchar(4000),
		@RutaOrigen  varchar(4000),
		@RutaDestino varchar(4000),
		@RutaArchivo varchar(4000),
		@ArchivoXML  varchar(max),
		@iSolicitud  int,
		@CFDFecha					datetime,
		@CFDSerie					varchar(10),
		@CFDFolio					varchar(20),
		@CFDRFC						varchar(15),
		@CFDAprobacion				varchar(15),
		@CFDImporte					money,
		@CFDImpuesto1				money,
		@CFDImpuesto2				money,
		@CFDRetencion1				money,
		@CFDRetencion2				money,	
		@CFDnoCertificado			varchar(20),
		@CFDSello					varchar(max),
		@CFDCadenaOriginal			varchar(max),
		@OrigenUUID					varchar(500),
		@OrigenMovID				varchar(20),
		@PrefijoCFDI               varchar(255),
		@RutaCFDI                  varchar(255),
		@Shell                     varchar(255),
		@r					        varchar(max),
		@ID                        int,
		@Fecha                     datetime,
		@UUID                      varchar(50),
		@RFCEmisor                 varchar(50),
		@RFCReceptor               varchar(50),
		@FechaTimbrado             datetime,
		@FechaTimbrado2            varchar(20),
		@Monto                     float,
		@Moneda                    varchar(100),
		@MonXML                    varchar(100),
		@TipoCambioT               varchar(100),
		@TipoCambio                float,
		@ClaveModulo               char(5),
		@XML                       xml,
		@XMLRes                    varchar(max) ,
		@XMLParcial                varchar(max) ,
		@XMLResultado              xml,
		@OkVal                     int,
		@OkRefVal                  varchar(255),
		@RutaReemplazarFin         varchar(255),
		@Personal					varchar(10),
		@Codificacion              varchar(100),
		@Version                   varchar(100),
		@Cadenaoriginal            varchar(255),
		@ValidacionEstructura      varchar(100),
		@CertificadoReportado      varchar(100),
		@CertificadoUsado          varchar(100),
		@ValidoDesde               datetime,
		@ValidoHasta               datetime,
		@NombreEmisor              varchar(255),
		@AddInicio                 int,
		@AddFin                    int,
		@PathMultiempresa		   bit,
		@EmpresaValidar			   char(5),
		@ModuloAutoAsoc			   varchar(20),
		@IDAutoAsoc				   int,
		@ErrorAutoAsoc			   varchar(255),
		@Estacion				   int,
		
		@cID						int,
		@cModulo					varchar(5),
		@cMov						varchar(20),
		@cMovID						varchar(20),
		@versionCFDI				   varchar(10)
	DECLARE @Datos TABLE (ID int IDENTITY(1,1), Datos varchar(max))
	DECLARE @Polizas TABLE (ID int, Modulo varchar(5), Mov varchar(20), MovID varchar(20))
	SELECT @RutaComponentes = RutaComponentes,
		   @PathMultiempresa = PathMultiempresa
    FROM EmpresaCfgContaSAT
	SELECT @ClaveModulo = CASE WHEN @Modulo = 'Ventas' THEN 'VTAS'
							WHEN @Modulo = 'CXC' THEN 'CXC'
							WHEN @Modulo = 'Compras' THEN 'COMS'
							WHEN @Modulo = 'Nomina' THEN 'NOM'
							WHEN @Modulo = 'CXP' THEN 'CXP'
							WHEN @Modulo = 'Gastos' THEN 'GAS'
							WHEN @Modulo = 'Pedimentos' THEN 'IMP' ELSE '' END
	SET @Fecha = dbo.fnFechaSinHora(GETDATE())
	SET @RutaComponentes = @RutaComponentes+'\'+ 'ValidadorCFDI.exe'
	CREATE TABLE #Archivos(Archivo varchar(4000) COLLATE Database_Default NULL)
	DELETE #Archivos
	SET @RutaValidar = @Ruta+'\No Validados\'+@Tipo+'\'+@Modulo
	SET @SQL = ''+'INSERT INTO #Archivos(Archivo)EXEC xp_cmdshell '+''''+'dir /B '+'"'+@RutaValidar+'"'+''''+' '+''
	EXEC(@SQL)
	DELETE #Archivos WHERE ISNULL(Archivo,'') = '' OR Archivo NOT LIKE '%.%' OR Archivo LIKE '%<DIR>%' OR ARCHIVO LIKE '%batch%' OR ARCHIVO LIKE '%??%'
	DECLARE crNoXML CURSOR LOCAL FAST_FORWARD FOR	
	SELECT Archivo
		FROM #Archivos
		WHERE Archivo NOT LIKE '%.XML'
	OPEN crNoXML
	FETCH NEXT FROM crNoXML INTO  @Archivo
	WHILE @@FETCH_STATUS <> -1
	BEGIN
		SET @RutaOrigen = @Ruta+'\No Validados\'+@Tipo+'\'+@Modulo+'\'+@Archivo
		SET @RutaDestino = @Ruta+'\Invalidos\'+@Tipo+'\'+@Modulo+'\'+@Archivo
		SET @RutaDestino = REPLACE(@RutaDestino, '\\', '\')
		IF CHARINDEX('\' , @RutaDestino) = 1 AND CHARINDEX('\\', @RutaDestino) = 0
				SELECT @RutaDestino = '\' + @RutaDestino
		INSERT CFDInvalido(Ruta,Documento,Tipo,Ok,OkRef,Modulo,Empresa)
		VALUES (@RutaDestino,@Archivo,@Tipo,1000,'Archivo de tipo inválido',@ClaveModulo,@Empresa)
		EXEC spMoverArchivo @RutaOrigen,@RutaDestino,@Ok Output,@OkRef Output
		EXEC spEliminarArchivo @RutaOrigen,@Ok Output,@OkRef Output
		FETCH NEXT FROM crNoXML INTO @Archivo
	END
	CLOSE crNoXML
	DEALLOCATE crNoXML
	DELETE #Archivos
	SET @RutaValidar = @Ruta+'\No Validados\'+@Tipo+'\'+@Modulo
	SET @SQL = ''+'INSERT INTO #Archivos(Archivo)EXEC xp_cmdshell '+''''+'dir /B '+'"'+@RutaValidar+'"'+''''+' '+''
	EXEC(@SQL)
	DELETE #Archivos WHERE ISNULL(Archivo,'') = '' OR Archivo NOT LIKE '%.%' OR Archivo LIKE '%<DIR>%' OR ARCHIVO LIKE '%batch%' OR ARCHIVO LIKE '%??%'
	DECLARE crXML CURSOR LOCAL FAST_FORWARD FOR	
	SELECT Archivo
		FROM #Archivos
		WHERE Archivo LIKE '%.XML'
	OPEN crXML
	FETCH NEXT FROM crXML INTO  @Archivo
	WHILE @@FETCH_STATUS <> -1
	BEGIN
		SET @Moneda = NULL
		SET @RFCReceptor = NULL
		SET @RFCEmisor = NULL
		SET @ArchivoXML = NULL
		declare @minSQL nvarchar(4000)
		set @minSQL = 'rename "' + @RutaValidar + '\' + @Archivo + '" "' + replace(@Archivo,'''', '') + '"'
		exec xp_cmdshell @minSQL, 'no_output'
		set @Archivo = replace(@Archivo,'''', '')
		SET @RutaArchivo = @RutaValidar + '\' + @Archivo
		EXEC spCFDFlexLeerArchivo @RutaArchivo, @ArchivoXML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
		IF @ClaveModulo <> 'IMP'
		BEGIN
			SET @ArchivoXML = substring(@ArchivoXML, charindex('<', @ArchivoXML), len(@ArchivoXML))
			if charindex('<?xml version', @ArchivoXML) = 0
			SET @ArchivoXML = '<?xml version="1.0" encoding="UTF-8"?>' + @ArchivoXML
			SET @AddInicio = 0
			SET @AddInicio = CHARINDEX('<Addenda>',@ArchivoXML)
			IF ISNULL(@AddInicio,0) > 0 AND LEN(@ArchivoXML) >0
			BEGIN
				SET @AddFin = CHARINDEX('/Addenda>',@ArchivoXML)
				SET @AddInicio = @AddInicio - 1
				SET @AddFin = @AddFin + 7
				SET @ArchivoXML = LEFT(@ArchivoXML,@AddInicio)+RIGHT(@ArchivoXML,LEN(@ArchivoXML)-@AddFin)
			END
			SET @ArchivoXML = REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( @ArchivoXML, '="s', '=" s' ), '="c', '=" c' ), '"', '" ' ), '=" ', '="' ), '=="', '==" ' )
			BEGIN TRY
				SELECT @XML = CONVERT(XML, @ArchivoXML)
			  ;with xmlnamespaces('http://www.sat.gob.mx/cfd/3' as cfdi, 'http://www.sat.gob.mx/TimbreFiscalDigital' as tfd, 'http://www.sat.gob.mx/detallista' as detallista, 'http://kontender.mx/namespace/boveda' as bovadd, 'http://kontender.mx/namespace' as kon
, 'http://www.w3.org/2001/XMLSchema-instance http://www.sat.gob.mx/ http://kontender.mx/namespace/ http://kontender.mx/namespace/AddendaK.xsd' as xsi)
              SELECT  @VersionCFDI = cfdi.value('@version', 'varchar(10)')
			    FROM @XML.nodes('/cfdi:Comprobante') a(cfdi)
              IF @VersionCFDI IS NULL
              BEGIN
				;with xmlnamespaces('http://www.sat.gob.mx/cfd/3' as cfdi, 'http://www.sat.gob.mx/TimbreFiscalDigital' as tfd, 'http://www.sat.gob.mx/detallista' as detallista, 'http://kontender.mx/namespace/boveda' as bovadd, 'http://kontender.mx/namespace' as kon, 
'http://www.w3.org/2001/XMLSchema-instance http://www.sat.gob.mx/ http://kontender.mx/namespace/ http://kontender.mx/namespace/AddendaK.xsd' as xsi)
                SELECT  @VersionCFDI = cfdi.value('@Version', 'varchar(10)')
				 FROM @XML.nodes('/cfdi:Comprobante') a(cfdi)
              END
              IF @VersionCFDI IN (NULL, '1.0','2.0','2.1', '2.2','3.0','3.1','3.2')
              BEGIN				
				;with xmlnamespaces('http://www.sat.gob.mx/cfd/3' as cfdi, 'http://www.sat.gob.mx/TimbreFiscalDigital' as tfd, 'http://www.sat.gob.mx/detallista' as detallista, 'http://kontender.mx/namespace/boveda' as bovadd, 'http://kontender.mx/namespace' as kon, 
'http://www.w3.org/2001/XMLSchema-instance http://www.sat.gob.mx/ http://kontender.mx/namespace/ http://kontender.mx/namespace/AddendaK.xsd' as xsi)
				SELECT
					@CFDFecha = cfdi.value('@fecha', 'varchar(100)'),
					@CFDSerie = cfdi.value('@serie', 'varchar(10)'),
					@CFDFolio = cfdi.value('@folio', 'varchar(20)'),
					@CFDAprobacion = RTRIM(ISNULL(cfdi.value('@noAprobacion', 'varchar(15)'),'')) + RTRIM(ISNULL(cfdi.value('@noAprobacion', 'varchar(15)'),'')),
					@CFDnoCertificado = cfdi.value('@noCertificado', 'varchar(100)'),	
					@CFDSello = cfdi.value('@sello', 'varchar(max)'),
					@CFDImporte = ISNULL(cfdi.value('@total', 'money'),0.0),
					@OrigenMovID = cfdi.value('@SerieFolioFiscalOrig', 'varchar(20)'),
					@OrigenUUID = cfdi.value('@FolioFiscalOrig', 'varchar(500)'),
					@TipoCambioT =  cfdi.value('@TipoCambio', 'varchar(100)'),
					@Moneda = ISNULL(cfdi.value('@Moneda', 'varchar(100)'), 'PESOS'),
					@MonXML = cfdi.value('@Moneda', 'varchar(100)')
				FROM @XML.nodes('/cfdi:Comprobante') a(cfdi)
				IF ISNUMERIC(@TipoCambioT) = 1
                  IF CHARINDEX('.',@TipoCambioT,0)  > 0
                    SELECT  @TipoCambio = CONVERT(float,REPLACE(@TipoCambioT,',',''))
                  ELSE
                    SELECT  @TipoCambio =CONVERT(float,REPLACE(@TipoCambioT,',','.'))
				;with xmlnamespaces('http://www.sat.gob.mx/cfd/3' as cfdi, 'http://www.sat.gob.mx/TimbreFiscalDigital' as tfd, 'http://www.sat.gob.mx/detallista' as detallista, 'http://kontender.mx/namespace/boveda' as bovadd, 'http://kontender.mx/namespace' as kon, 
'http://www.w3.org/2001/XMLSchema-instance http://www.sat.gob.mx/ http://kontender.mx/namespace/ http://kontender.mx/namespace/AddendaK.xsd' as xsi)
				SELECT @RFCReceptor			= cfdi.value('@rfc', 'varchar(50)')
					FROM @XML.nodes('/cfdi:Comprobante/cfdi:Receptor') a(cfdi)
				SELECT @RFCReceptor = LTRIM(RTRIM(UPPER(@RFCReceptor)))
				;with xmlnamespaces('http://www.sat.gob.mx/cfd/3' as cfdi, 'http://www.sat.gob.mx/TimbreFiscalDigital' as tfd, 'http://www.sat.gob.mx/detallista' as detallista, 'http://kontender.mx/namespace/boveda' as bovadd, 'http://kontender.mx/namespace' as kon, 
'http://www.w3.org/2001/XMLSchema-instance http://www.sat.gob.mx/ http://kontender.mx/namespace/ http://kontender.mx/namespace/AddendaK.xsd' as xsi)
				SELECT @RFCEmisor			= cfdi.value('@rfc', 'varchar(50)')
					FROM @XML.nodes('/cfdi:Comprobante/cfdi:Emisor') a(cfdi)
				SELECT @RFCEmisor = LTRIM(RTRIM(UPPER(@RFCEmisor)))
				;with xmlnamespaces('http://www.sat.gob.mx/cfd/3' as cfdi, 'http://www.sat.gob.mx/TimbreFiscalDigital' as tfd, 'http://www.sat.gob.mx/detallista' as detallista, 'http://kontender.mx/namespace/boveda' as bovadd, 'http://kontender.mx/namespace' as kon, 
'http://www.w3.org/2001/XMLSchema-instance http://www.sat.gob.mx/ http://kontender.mx/namespace/ http://kontender.mx/namespace/AddendaK.xsd' as xsi)
				SELECT @UUID			= tfd.value('@UUID', 'varchar(50)'),
						@FechaTimbrado   = tfd.value('@FechaTimbrado', 'varchar(100)')
				  FROM @xml.nodes('/cfdi:Comprobante/cfdi:Complemento/tfd:TimbreFiscalDigital') a(tfd)
			  END ELSE
              BEGIN
				;with xmlnamespaces('http://www.sat.gob.mx/cfd/3' as cfdi, 'http://www.sat.gob.mx/TimbreFiscalDigital' as tfd, 'http://www.sat.gob.mx/detallista' as detallista, 'http://kontender.mx/namespace/boveda' as bovadd, 'http://kontender.mx/namespace' as kon, 
'http://www.w3.org/2001/XMLSchema-instance http://www.sat.gob.mx/ http://kontender.mx/namespace/ http://kontender.mx/namespace/AddendaK.xsd' as xsi)
				SELECT
					@CFDFecha = cfdi.value('@Fecha', 'varchar(100)'),
					@CFDSerie = cfdi.value('@Serie', 'varchar(10)'),
					@CFDFolio = cfdi.value('@Folio', 'varchar(20)'),
					@CFDnoCertificado = cfdi.value('@NoCertificado', 'varchar(100)'),	
					@CFDSello = cfdi.value('@Sello', 'varchar(max)'),
					@CFDImporte = ISNULL(cfdi.value('@Total', 'money'),0.0),
					@TipoCambioT =  cfdi.value('@TipoCambio', 'varchar(100)'),
					@Moneda = ISNULL(cfdi.value('@Moneda', 'varchar(100)'), 'PESOS'),
					@MonXML = cfdi.value('@Moneda', 'varchar(100)')
				FROM @XML.nodes('/cfdi:Comprobante') a(cfdi)
				IF ISNUMERIC(@TipoCambioT) = 1
                  IF CHARINDEX('.',@TipoCambioT,0)  > 0
                    SELECT  @TipoCambio = CONVERT(float,REPLACE(@TipoCambioT,',',''))
                  ELSE
                    SELECT  @TipoCambio =CONVERT(float,REPLACE(@TipoCambioT,',','.'))
				;with xmlnamespaces('http://www.sat.gob.mx/cfd/3' as cfdi, 'http://www.sat.gob.mx/TimbreFiscalDigital' as tfd, 'http://www.sat.gob.mx/detallista' as detallista, 'http://kontender.mx/namespace/boveda' as bovadd, 'http://kontender.mx/namespace' as kon, 
'http://www.w3.org/2001/XMLSchema-instance http://www.sat.gob.mx/ http://kontender.mx/namespace/ http://kontender.mx/namespace/AddendaK.xsd' as xsi)
				SELECT @RFCReceptor			= cfdi.value('@Rfc', 'varchar(50)')
					FROM @XML.nodes('/cfdi:Comprobante/cfdi:Receptor') a(cfdi)
				SELECT @RFCReceptor = LTRIM(RTRIM(UPPER(@RFCReceptor)))
				;with xmlnamespaces('http://www.sat.gob.mx/cfd/3' as cfdi, 'http://www.sat.gob.mx/TimbreFiscalDigital' as tfd, 'http://www.sat.gob.mx/detallista' as detallista, 'http://kontender.mx/namespace/boveda' as bovadd, 'http://kontender.mx/namespace' as kon, 
'http://www.w3.org/2001/XMLSchema-instance http://www.sat.gob.mx/ http://kontender.mx/namespace/ http://kontender.mx/namespace/AddendaK.xsd' as xsi)
				SELECT @RFCEmisor			= cfdi.value('@Rfc', 'varchar(50)')
					FROM @XML.nodes('/cfdi:Comprobante/cfdi:Emisor') a(cfdi)
				SELECT @RFCEmisor = LTRIM(RTRIM(UPPER(@RFCEmisor)))
				;with xmlnamespaces('http://www.sat.gob.mx/cfd/3' as cfdi, 'http://www.sat.gob.mx/TimbreFiscalDigital' as tfd, 'http://www.sat.gob.mx/detallista' as detallista, 'http://kontender.mx/namespace/boveda' as bovadd, 'http://kontender.mx/namespace' as kon, 
'http://www.w3.org/2001/XMLSchema-instance http://www.sat.gob.mx/ http://kontender.mx/namespace/ http://kontender.mx/namespace/AddendaK.xsd' as xsi)
				SELECT @UUID			= tfd.value('@UUID', 'varchar(50)'),
						@FechaTimbrado   = tfd.value('@FechaTimbrado', 'varchar(100)')
					FROM @xml.nodes('/cfdi:Comprobante/cfdi:Complemento/tfd:TimbreFiscalDigital') a(tfd)
              END
			  SELECT @UUID = LTRIM(RTRIM(@UUID))
			END TRY
			BEGIN CATCH
				SELECT	@Ok = 71600, @OkRef = ERROR_MESSAGE()
			END CATCH
			IF NOT EXISTS(SELECT * FROM Mon WHERE Moneda = @Moneda)
				SELECT @Moneda = dbo.fnBuscaMonedaClave(@Moneda)
			SET @Moneda = ISNULL(@Moneda,'PESOS')
			SELECT @Shell = @RutaComponentes+' '+CHAR(34)+@RutaArchivo+CHAR(34)
			IF(SELECT NoValidarXML FROM EmpresaCfgContaSAT) = 0 
			BEGIN
					IF @Ok IS NULL
					BEGIN
						DELETE @Datos
						INSERT @Datos
						EXEC @r =  xp_cmdshell @Shell--, no_output
						IF NOT EXISTS(SELECT * FROM @Datos WHERE Datos Like '<?xml%') AND EXISTS (SELECT * FROM @Datos)
							SELECT TOP 1 @OK = ID, @OkRef = Datos FROM @Datos
						IF @Ok IS NULL
						BEGIN
							DELETE @Datos
								WHERE ID = (SELECT MIN(ID) FROM @Datos) AND Datos NOT Like '<?xml%'
							DELETE @Datos
								WHERE Datos IS NULL
							SET @XMLRes = ''
							SET @XMLParcial = ''
							DECLARE crDatos CURSOR LOCAL FAST_FORWARD FOR	
							SELECT Datos
								FROM @Datos
								WHERE Datos IS NOT NULL
							OPEN crDatos
							FETCH NEXT FROM crDatos INTO  @XMLParcial
							WHILE @@FETCH_STATUS <> -1
							BEGIN
								SET @XMLRes = @XMLRes + @XMLParcial
								FETCH NEXT FROM crDatos INTO @XMLParcial
							END
							CLOSE crDatos
							DEALLOCATE crDatos
							SET @XMLRes = SUBSTRING(@XMLRes, CHARINDEX('<?xml', @XMLRes), LEN(@XMLRes))
							if (CHARINDEX('<?xml', @XMLRes)) > 0
								SET @XMLRes = SUBSTRING(@XMLRes, CHARINDEX('>', @XMLRes)+1, LEN(@XMLRes))
							SET @XMLRes = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@XMLRes,'cfdi:',''),'xmlns:',''),'<?xml version="1.0" encoding="UTF-8" ?>',''),'xmlns:',''),'tfd:',''),'xsi:',''),'- ','')
							SET @XMLRes = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@XMLRes, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'ñ', 'n'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'), 'Ñ', 'N'),'ñ','n')
							SET @XMLRes = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@XMLRes, 'à', 'a'), 'è', 'e'),'ì', 'i'), 'ò', 'o'), 'ù', 'u'), '''', ''), '#', ''), 'À', 'A'), 'È', 'E'), 'Ì', 'I'), 'Ò', 'O'), 'Ù', 'U'), 'Ü', 'U'), 'Ç', 'C'),'ç','c')
							SET @XMLRes = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@XMLRes,'nomina:',''),'implocal:',''),'if:',''),'ecfd:',''),'compac:',''),'mfn:',''),'ï»¿',''),'&','')
							SET @XMLRes = REPLACE(REPLACE(REPLACE(@XMLRes,'°',''),'º',''),'´','')
							SET @XMLRes = REPLACE(REPLACE(REPLACE(REPLACE(@XMLRes, '<BR>', '<BR/>'), '<br>', '<br/>'), '<p>', '<p/>'), '<P>', '<P/>')
							BEGIN TRY	
								SELECT @XMLResultado = CONVERT(XML,@XMLRes)
								SELECT @OkVal = NULL, @OkRefVal = NULL
								EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @XMLResultado
								SELECT
									@Codificacion         = Codificacion,
									@Version              = Version,
									@Cadenaoriginal       = Cadenaoriginal,
									@ValidacionEstructura = ValidacionEstructura,
									@OkVal                = Ok,
									@OkRefVal             = OkRef
									FROM OPENXML (@iSolicitud, '/ValidacionCFDI', 2) WITH (Codificacion varchar(100),Version varchar(100),CadenaOriginal varchar(255),ValidacionEstructura varchar(100),Ok varchar(50),OkRef varchar(255))
								SELECT
									@CertificadoReportado = CertificadoReportado,
									@CertificadoUsado     = CertificadoUsado,
									@ValidoDesde          = CONVERT(datetime,RTRIM(REPLACE(ValidoDesde,'Z',''))),
									@ValidoHasta          = CONVERT(datetime,RTRIM(REPLACE(ValidoHasta,'Z',''))),
									@NombreEmisor         = REPLACE(NombreEmisor, 'CN=', '')
									FROM OPENXML (@iSolicitud, '/ValidacionCFDI/CertificadoEmisor', 2) WITH (CertificadoReportado varchar(100),CertificadoUsado varchar(100),ValidoDesde varchar(20),ValidoHasta varchar(20),NombreEmisor varchar(255))
								EXEC sp_xml_removedocument @iSolicitud
							END TRY
							BEGIN CATCH
								SELECT	@Ok = 71600, @OkRef = ERROR_MESSAGE()
							END CATCH
						END		
					END --/
			END
		END
		IF @ClaveModulo = 'IMP'
		BEGIN
			BEGIN TRY
			EXEC spCFDFlexLeerArchivo @RutaArchivo, @ArchivoXML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
			--SELECT @ok, 3
			DECLARE @FTimbrado varchar(50)
			DECLARE @TABLE AS TABLE(id            INT,
									parentid      INT,
									nodetype      INT,
									localname     VARCHAR(255),
									prefix        VARCHAR(255),
									namespaceuri  VARCHAR(255),
									datatype      VARCHAR(255),
									prev          VARCHAR(255),
									[text]        VARCHAR(MAX))
			EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @ArchivoXML
			INSERT INTO @TABLE (id, parentid, nodetype, localname, prefix, namespaceuri, datatype, prev, [text])
						 SELECT id, parentid, nodetype, localname, prefix, namespaceuri, datatype, prev, [text]
				  FROM OPENXML (@iSolicitud, '/', 1)
			EXEC sp_xml_removedocument @iSolicitud
			SELECT @RFCReceptor = max(CASE WHEN B.localname = 'rfcConsulta' THEN C.text ELSE '' END),
				   @RFCEmisor = max(CASE WHEN B.localname = 'Username' THEN C.text ELSE '' END),
				   @MonXML = max(CASE WHEN B.localname = 'TipoMoneda' THEN C.text ELSE '' END),
				   @CFDImporte = cast(sum(CASE WHEN B.localname = 'ValorTotal' THEN cast(C.text as money) ELSE '0' END) as varchar(100)),
				   @FTimbrado = max(CASE WHEN B.localname = 'fechaExpedicion' THEN C.text ELSE '' END)
			  FROM @TABLE AS A
		 LEFT JOIN @TABLE AS B
				ON A.ID = B.PARENTID
		 LEFT JOIN @TABLE AS C
				ON B.ID = C.PARENTID
			 WHERE A.nodetype = 1
			   AND B.localname IN ('rfcConsulta','Username','TipoMoneda','ValorTotal','fechaExpedicion')
			SET @FechaTimbrado = CONVERT(DATETIME,@FTimbrado,120)
			SET @Moneda = @MonXML
			IF NOT EXISTS(SELECT * FROM Mon WHERE Moneda = @Moneda)
				SELECT @Moneda = dbo.fnBuscaMonedaClave(@Moneda)
			IF @Moneda IS NULL
				SET @Moneda = 'Pesos'
			DELETE FROM @TABLE
			END TRY
			BEGIN CATCH
				SELECT	@Ok = 71600, @OkRef = ERROR_MESSAGE()
				--SELECT @OkRef
			END CATCH
		END
		SELECT @Ok,4, @OkRef
		SET @ModuloAutoAsoc = null
		SET @IDAutoAsoc = null
		SET @ErrorAutoAsoc = null
		SET @FechaTimbrado2 = CONVERT(VARCHAR(20), @FechaTimbrado, 112)
		EXEC spConSATAutoasociarXML @Empresa, @Tipo, @RFCEmisor, @RFCReceptor, @CFDImporte, @FechaTimbrado2, @ClaveModulo, @CFDFolio, @ModuloAutoAsoc OUTPUT, @IDAutoAsoc OUTPUT, @ErrorAutoAsoc OUTPUT
		--SELECT @OK,2
			IF NULLIF(@OkVal,0) IS NOT NULL
				SELECT @Ok = @OkVal,@OkRef = @OkRefVal
			SET @EmpresaValidar= NULL
			IF @Tipo = 'Egresos' AND ISNULL(@ClaveModulo,'') <> 'NOM' AND @EmpresaValidar IS NULL
				SELECT @EmpresaValidar = Empresa
					FROM Empresa
					WHERE RFC = @RFCReceptor AND Empresa = @Empresa
			IF @Tipo = 'Ingresos' OR @ClaveModulo = 'NOM' AND @EmpresaValidar IS NULL
				SELECT @EmpresaValidar = Empresa
					FROM Empresa
					WHERE RFC = @RFCEmisor AND Empresa = @Empresa
			--SELECT @OK, @EmpresaValidar
			IF (@Ok IS NULL AND @EmpresaValidar IS NULL)-- OR (ISNULL(@EmpresaValidar,'') <> ISNULL(@Empresa,''))
				SELECT @Ok = Mensaje, @OkRef = Descripcion
				  FROM MensajeLista
				 WHERE Mensaje = 71518
		IF @Ok IS NULL
		BEGIN
			IF EXISTS(SELECT UUID FROM CFDValido WHERE UUID = @UUID )
				SELECT	@Ok = Mensaje, @OkRef = Descripcion
					FROM	MensajeLista
					WHERE Mensaje = 71517
		END
		IF @Ok IS NULL AND @ClaveModulo = 'NOM'
			BEGIN		
			SELECT @Personal = Personal
				FROM Personal
				WHERE REPLACE(Registro2,' ','') = REPLACE(@RFCReceptor,' ','')
			SET @Personal = ISNULL(@Personal,'')
			IF ISNULL(@Personal,'') = ''
				SELECT	@Ok = Mensaje, @OkRef = Descripcion
						FROM	MensajeLista
						WHERE Mensaje = 71519		
			END
		IF @Ok IS NULL
		BEGIN
			IF ISNULL(@RutaReemplazar,'') <> ''
			SELECT @RutaReemplazarFin = dbo.fnRutaConfig(@RutaReemplazar,isnull(@EmpresaValidar,@Empresa),@CFDFecha,@RFCEmisor)
			SET @RutaReemplazarFin = ISNULL(NULLIF(@RutaReemplazarFin,'') + CASE WHEN RIGHT(@RutaReemplazarFin, 1) <> '\' THEN '\' ELSE '' END,'\')
			SET @RutaOrigen = @Ruta+'\No Validados\'+@Tipo+'\'+@Modulo+'\'+@Archivo
			SET @RutaDestino = @Ruta+'\Validados\'+@Tipo+'\'+@Modulo + CASE ISNULL(@PathMultiempresa,0) WHEN 1 THEN '\' ELSE '' END + @RutaReemplazarFin+@Archivo
			SET @RutaDestino = REPLACE(@RutaDestino, '\\', '\')
			IF CHARINDEX('\' , @RutaDestino) = 1 AND CHARINDEX('\\', @RutaDestino) = 0
				SELECT @RutaDestino = '\' + @RutaDestino
			IF ISNULL(@RutaReemplazarFin,'') <> ''
			BEGIN
				SET @RutaReemplazarFin = @Ruta+'\Validados\'+@Tipo+'\'+@Modulo + CASE ISNULL(@PathMultiempresa,0) WHEN 1 THEN '\' ELSE '' END + @RutaReemplazarFin
				EXEC spCrearRuta @RutaReemplazarFin
				SET @RutaReemplazarFin = ''
			END
			SELECT @ID = MAX(ID) FROM CFDValido WHERE Empresa = ISNULL(@EmpresavALIDAR,@Empresa)
			SET @ID = ISNULL(@ID,0) + 1
			INSERT CFDValido(ID,Empresa,Modulo,Fecha,Ruta,Documento,Tipo,UUID,RFCEmisor,RFCReceptor,FechaTimbrado,Monto,Moneda,TipoCambio,Nombre,MonXML,Personal,Codificacion,Version,Cadenaoriginal,ValidacionEstructura,CertificadoReportado,CertificadoUsado,ValidoDesde,ValidoHasta,NombreEmisor,MotivoNoAutoasociado)
			VALUES(@ID,isnull(@EmpresaValidar,@Empresa),@ClaveModulo,@Fecha,@RutaDestino,@ArchivoXML,@Tipo,@UUID,@RFCEmisor,@RFCReceptor,@FechaTimbrado,@CFDImporte,@Moneda,@TipoCambio,@Archivo,@MonXML,@Personal,@Codificacion,@Version,@Cadenaoriginal,@ValidacionEstructura,@CertificadoReportado,@CertificadoUsado,@ValidoDesde,@ValidoHasta,@NombreEmisor, ISNULL(@ErrorAutoAsoc,''))
			
			SELECT @Estacion = @@SPID
			DELETE FROM ListaSt WHERE Estacion = @Estacion
			INSERT INTO ListaSt(Estacion,Clave) VALUES(@Estacion,@ID)
			IF @Ok = NULL
			EXEC spValidaAsociarCFD @Empresa, @IDAutoAsoc, @ModuloAutoAsoc, @Estacion, @Ok OUTPUT, @OkRef OUTPUT
			IF ISNULL(@Ok,'')='' AND @IDAutoAsoc IS NOT NULL
			BEGIN
				DELETE FROM ListaID WHERE Estacion = @Estacion
				INSERT INTO ListaID(Estacion,ID) VALUES(@Estacion,@IDAutoAsoc)
				EXEC spVerMovtos @Empresa, @ModuloAutoAsoc, NULL, NULL, 1, @Estacion, null, null
				EXEC spAsociarCFD @Empresa, @IDAutoAsoc, @ModuloAutoAsoc, @Estacion, 'AdminDoctos', @Ok OUTPUT, @OkRef OUTPUT
				IF @Ok = 80055
				BEGIN
					UPDATE CFDValido SET Autoasociado = 44 WHERE ID = @ID AND Empresa = @Empresa
					IF @ModuloAutoAsoc = 'NOM'
					UPDATE CFDValido SET Personal = @Personal WHERE ID = @ID AND Empresa = @Empresa
					INSERT INTO @Polizas(ID,Modulo,Mov,MovID)
					SELECT ID,Modulo,Mov,MovID FROM dbo.fnBuscaMovs(@ModuloAutoAsoc,@IDAutoAsoc,@Empresa)
					DECLARE cPolizas CURSOR FOR
					 SELECT A.ID,A.Modulo,A.Mov,A.MovID
					   FROM @Polizas A
					   JOIN Cont B ON A.ID = B.ID
					  WHERE A.Modulo = 'CONT'
					    AND B.OrigenTipo <> 'FIS'
					OPEN cPolizas
					FETCH NEXT FROM cPolizas INTO @cID, @cModulo, @cMov, @cMovID
					WHILE @@FETCH_STATUS = 0
					BEGIN
						IF @Tipo = 'Egresos'
						BEGIN
							UPDATE ContSATCOmprobante SET ContID = @cID
							 WHERE Modulo = @ModuloAutoAsoc
							   AND ModuloID = @IDAutoAsoc
							   AND UUID = @UUID
							   AND ContID IS NULL
						END
						EXEC xpContSAT @Empresa,@ModuloAutoAsoc,@IDAutoAsoc,@cID,@Personal
						FETCH NEXT FROM cPolizas INTO @cID, @cModulo, @cMov, @cMovID						
					END
					CLOSE cPolizas
					DEALLOCATE cPolizas
				END
			END
			
			EXEC spMoverArchivo @RutaOrigen,@RutaDestino,@Ok Output,@OkRef Output
			EXEC spEliminarArchivo @RutaOrigen,@Ok Output,@OkRef Output
			SET @RutaReemplazarFin = ''	
		END
        IF EXISTS(SELECT * FROM CFDVALIDO WHERE ID = @ID AND Empresa = isnull(@EmpresaValidar,@Empresa))
        SELECT @Ok = NULL, @OkRef = NULL
		IF @Ok IS NOT NULL
		BEGIN
			SET @RutaOrigen = @Ruta+'\No Validados\'+@Tipo+'\'+@Modulo+'\'+@Archivo
			SET @RutaDestino = @Ruta+'\Invalidos\'+@Tipo+'\'+@Modulo+'\'+@Archivo
			SET @RutaDestino = REPLACE(@RutaDestino, '\\', '\')
			IF CHARINDEX('\' , @RutaDestino) = 1 AND CHARINDEX('\\', @RutaDestino) = 0
			SELECT @RutaDestino = '\' + @RutaDestino
			INSERT CFDInvalido(Ruta, Documento, Tipo, Ok, OkRef, Modulo, Empresa,
							   UUID, RFCEmisor, RFCReceptor, FechaTimbrado, Monto, Moneda, TipoCambio)
					   VALUES (@RutaDestino,@Archivo,@Tipo,@Ok,@OkRef,@ClaveModulo,isnull(@EmpresaValidar,@Empresa),
							   @UUID, @RFCEmisor, @RFCReceptor, @FechaTimbrado, @CFDImporte, @Moneda, @TipoCambio)
			EXEC spMoverArchivo @RutaOrigen,@RutaDestino,@Ok Output,@OkRef Output
			EXEC spEliminarArchivo @RutaOrigen,@Ok Output,@OkRef Output
			SELECT @Ok = NULL, @OkRef = NULL
		END
		FETCH NEXT FROM crXML INTO @Archivo
	END
	CLOSE crXML
	DEALLOCATE crXML
SET NOCOUNT OFF
END
GO
--EXEC spConSATValidarXML 1