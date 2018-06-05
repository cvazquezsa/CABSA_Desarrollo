/*********** Implementacion MD5 ***********/
sp_configure 'clr enabled', 1
GO
reconfigure
GO
IF EXISTS(SELECT * FROM sysobjects where name ='fnPassword' and type ='FS')
DROP FUNCTION fnPassword
GO
IF EXISTS(SELECT * FROM sys.assemblies WHERE name ='asPassword')
DROP ASSEMBLY asPassword
GO
CREATE ASSEMBLY asPassword
AUTHORIZATION [dbo]
FROM 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C0103003769C4510000000000000000E00002210B010B00000C000000060000000000009E2B0000002000000040000000000010002000000002000004000000000000000400000000000000008000000002000000000000030040850000100000100000000010000010000000000000100000000000000000000000502B00004B000000004000004003000000000000000000000000000000000000006000000C000000182A00001C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E74657874000000A40B000000200000000C000000020000000000000000000000000000200000602E72737263000000400300000040000000040000000E0000000000000000000000000000400000402E72656C6F6300000C0000000060000000020000001200000000000000000000000000004000004200000000000000000000000000000000802B0000000000004800000002000500DC2100003C080000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013300300FD000000010000110012007201000070281000000A0012017221000070281000000A0012020F00FE16020000016F1100000A2802000006281000000A001202281200000A6F1300000A281400000A0C12031202281200000A6F1500000A281600000A00091F23281700000A281800000A281900000A2D03082B141202281200000A191F206F1A00000A281400000A000C0608281B00000A07281B00000A0C12041202FE16020000016F1100000A2802000006281000000A0012051204281200000A6F1500000A281600000A0011051F23281700000A281800000A281900000A2D0411042B141204281200000A191F206F1A00000A281400000A001304110413062B0011062A000000133003006B0000000200001100731C00000A0A281D00000A026F1E00000A0B06076F1F00000A0B732000000A0C000713051613062B2611051106910D000812037239000070282100000A6F1300000A6F2200000A2600110617581306110611058E69FE04130711072DCC086F1100000A13042B0011042A1E02282300000A2A0042534A4201000100000000000C00000076322E302E35303732370000000005006C0000009C020000237E0000080300009803000023537472696E677300000000A00600004000000023555300E0060000100000002347554944000000F00600004C01000023426C6F620000000000000002000001471502000900000000FA253300160000010000001A000000020000000300000002000000230000000D00000002000000010000000200000000000A000100000000000600390032000A0061004C0006009C008A000600B3008A000600D0008A000600EF008A00060008018A00060021018A0006003C018A00060057018A0006008F0170010600A30170010600B1018A000600CA018A000600FA01E7013F000E02000006003D021D0206005D021D020600960232000A00BC024C000A00C5024C00060021030403060046033A0306006103040306007B033A0306008903320000000000010000000000010001000100100016001F0005000100010050200000000096006B000A0001005C210000000096006F0011000200D3210000000086187A001600030000000100800000000100840019007A001A0021007A001A0029007A001A0031007A001A0039007A001A0041007A001A0049007A001A0051007A001A0059007A001F0061007A001A0069007A001A0071007A001A0079007A00240089007A002A0091007A00160011007A001A00090083022F0011008C022F0099009D022F001100A50233009900B1023900A1007A002A00A100A5023D00A100D0024300A900E6024C009900EE0252001100F8025800B1007A001600B9004F037200B90058037700C1006F037D00C9007A001600D10083028400C9008E03890009007A0016002E000B009E002E001300AB002E001B00AB002E002300B1002E002B009E002E003300C0002E003B00AB002E004B00AB002E005300E1002E0063000B012E006B0018012E00730021012E007B002A0161008F000480000001000000000000000000000000007B020000020000000000000000000000010029000000000002000000000000000000000001004000000000000000003C4D6F64756C653E006C6F77776361742E646C6C00496E744669726D6100496E74656C69736973006D73636F726C69620053797374656D004F626A6563740053797374656D2E446174610053797374656D2E446174612E53716C54797065730053716C537472696E6700636174004765744D443548617368002E63746F720063616400696E7075740053797374656D2E5265666C656374696F6E00417373656D626C795469746C6541747472696275746500417373656D626C794465736372697074696F6E41747472696275746500417373656D626C79436F6E66696775726174696F6E41747472696275746500417373656D626C79436F6D70616E7941747472696275746500417373656D626C7950726F6475637441747472696275746500417373656D626C79436F7079726967687441747472696275746500417373656D626C7954726164656D61726B41747472696275746500417373656D626C7943756C747572654174747269627574650053797374656D2E52756E74696D652E496E7465726F70536572766963657300436F6D56697369626C65417474726962757465004775696441747472696275746500417373656D626C7956657273696F6E41747472696275746500417373656D626C7946696C6556657273696F6E4174747269627574650053797374656D2E446961676E6F73746963730044656275676761626C6541747472696275746500446562756767696E674D6F6465730053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300436F6D70696C6174696F6E52656C61786174696F6E734174747269627574650052756E74696D65436F6D7061746962696C697479417474726962757465006C6F777763617400546F537472696E67006765745F56616C756500537472696E6700546F4C6F776572006F705F496D706C69636974006765745F4C656E6774680053716C496E7433320053716C426F6F6C65616E006F705F477265617465725468616E4F72457175616C006F705F5472756500537562737472696E67006F705F4164646974696F6E0053797374656D2E53656375726974792E43727970746F677261706879004D443543727970746F5365727669636550726F76696465720053797374656D2E5465787400456E636F64696E67006765745F555446380047657442797465730048617368416C676F726974686D00436F6D707574654861736800537472696E674275696C646572004279746500417070656E6400000000001F4B006E0054005A007900630030004D0042006100640052006B00410041000017300073006B006B0072006C00460075004F002F0069000005780032000000C9AC479D23BAE74C83EAE859CE01B0EF0008B77A5C561934E089060001110911090400010E0E03200001042001010E042001010205200101114104200101080320000E05000111090E032000080500011151080800021155115111510500010211550520020E08080800021109110911091007071109110911091151110911511109040000125D0520011D050E0620011D051D050420010E0E05200112650E0E070812591D051265050E1D0508020C0100076C6F777763617400000501000000000E0100094D6963726F736F667400002001001B436F7079726967687420C2A9204D6963726F736F6674203230313300002901002463663731313261632D616364632D343732652D383562302D33353030393762303334613700000C010007312E302E302E3000000801000701000000000801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F777301000000000000003769C45100000000020000001C010000342A0000340C00005253445362307CDCD1291248AAD941646668553001000000643A5C50726F796563746F735C5665727369C3B36E5C32303133303632315C6C6F77776361745C6C6F77776361745C6F626A5C44656275675C6C6F77776361742E706462000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000782B000000000000000000008E2B0000002000000000000000000000000000000000000000000000802B00000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF2500200010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100100000001800008000000000000000000000000000000100010000003000008000000000000000000000000000000100000000004800000058400000E80200000000000000000000E80234000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE00000100000001000000000000000100000000003F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B00448020000010053007400720069006E006700460069006C00650049006E0066006F00000024020000010030003000300030003000340062003000000034000A00010043006F006D00700061006E0079004E0061006D006500000000004D006900630072006F0073006F00660074000000380008000100460069006C0065004400650073006300720069007000740069006F006E00000000006C006F00770077006300610074000000300008000100460069006C006500560065007200730069006F006E000000000031002E0030002E0030002E003000000038000C00010049006E007400650072006E0061006C004E0061006D00650000006C006F00770077006300610074002E0064006C006C0000005C001B0001004C006500670061006C0043006F007000790072006900670068007400000043006F0070007900720069006700680074002000A90020004D006900630072006F0073006F0066007400200032003000310033000000000040000C0001004F0072006900670069006E0061006C00460069006C0065006E0061006D00650000006C006F00770077006300610074002E0064006C006C000000300008000100500072006F0064007500630074004E0061006D006500000000006C006F00770077006300610074000000340008000100500072006F006400750063007400560065007200730069006F006E00000031002E0030002E0030002E003000000038000800010041007300730065006D0062006C0079002000560065007200730069006F006E00000031002E0030002E0030002E0030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000C000000A03B00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
WITH PERMISSION_SET = SAFE
GO
CREATE FUNCTION dbo.fnPassword( @cad NVARCHAR(max) )
RETURNS NVARCHAR(max)
as 
EXTERNAL NAME [asPassword].[Intelisis.IntFirma].cat; 
GO
/* Configuracion MS SQL Server */
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
GO
/*********** Pruebas Anteriores ***********/
if exists (select * from sysobjects where id=object_id('dbo.spIntelisisService') and type='P') drop procedure dbo.spIntelisisService
GO
/*CREATE PROCEDURE spIntelisisService	@Encabezado	varchar(max),			@Datos		varchar(max) WITH ENCRYPTION AS BEGIN  SELECT '<IntelisisService>'/*  if @Accion = 'Art'     SELECT top 1 * from art for xml auto  if @accion = 'venta'    SELECT top 1 * from venta for xml auto*/  SELECT '</IntelisisService>' RETURN END*/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesarRef') and type = 'P') drop procedure dbo.spIntelisisServiceProcesarRef
GO
/*CREATE PROCEDURE spIntelisisServiceProcesarRef				@Empresa 	varchar(5),				    @Usuario	varchar(10),				@FechaTrabajo	datetime,				@Estacion	int,				@Accion		varchar(255),				@ArchivoRef	varchar(255) if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesarDatos') and type = 'P') drop procedure dbo.spIntelisisServiceProcesarDatos*/
/*CREATE PROCEDURE spIntelisisServiceProcesarDatos @Empresa 	varchar(5),@Usuario	varchar(10), @FechaTrabajo	datetime, @Estacion	int, @Accion		varchar(255), @Resultado	text
/*********** Pruebas Anteriores ***********/

*/


--<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Cuenta.Alm.Listado" SubReferencia="ALTA" Version="1.0">   
--  <Solicitud>               
--   <Parametro Campo="Almacen" Valor="33333"/>         
--  </Solicitud>        
--</Intelisis>



/*
SELECT dbo.fnAutorizacionPositiva('SI') 
SELECT dbo.fnAutorizacionPositiva('OK') 
SELECT dbo.fnAutorizacionPositiva('YES') 

SELECT dbo.fnAutorizacionPositiva('S0') 
SELECT dbo.fnAutorizacionPositiva('OY') 
SELECT dbo.fnAutorizacionPositiva('YEA') 

SELECT dbo.fnAutorizacionPositiva(CHAR(13) + CHAR(10) + '   S I') 
SELECT dbo.fnAutorizacionPositiva(CHAR(13) + CHAR(10) + '   O K') 
SELECT dbo.fnAutorizacionPositiva(CHAR(13) + CHAR(10) + '   YE S') 

SELECT dbo.fnAutorizacionPositiva(CHAR(13) + CHAR(10) + '   SI') 
SELECT dbo.fnAutorizacionPositiva(CHAR(13) + CHAR(10) + '   OK') 
SELECT dbo.fnAutorizacionPositiva(CHAR(13) + CHAR(10) + '   YES') 

SELECT dbo.fnAutorizacionPositiva('CLARO QUE SI') 
SELECT dbo.fnAutorizacionPositiva('POR SUPUESTO QUE OK') 
SELECT dbo.fnAutorizacionPositiva('OFCOURSE YES') 

SELECT dbo.fnAutorizacionPositiva(CHAR(13) + CHAR(10) + '   SIp') 
SELECT dbo.fnAutorizacionPositiva(CHAR(13) + CHAR(10) + '   OKey') 
SELECT dbo.fnAutorizacionPositiva(CHAR(13) + CHAR(10) + '   YESmyfrend') 
*/

--REQ 13389
/******************* spISIntelisisCRM *******************/
if OBJECT_ID('dbo.spISIntelisisCRM') is not null DROP PROCEDURE spISIntelisisCRM
GO
CREATE PROCEDURE spISIntelisisCRM
		@ID					int,
		@iSolicitud			int,
		@Version			float,
		@Resultado			varchar(max) = NULL OUTPUT,
		@Ok					int			 = NULL OUTPUT,    
		@OkRef				varchar(255) = NULL OUTPUT,
		@CambiarEstatus		bit					OUTPUT
--//WITH ENCRYPTION	
AS BEGIN
DECLARE
  @Campoint				varchar(100),
  @CampoExt				varchar(100),
  @Campos				varchar(5000),
  @Variables			varchar(5000),
  @xml					xml,
  @Valor				varchar(max),
  @Tabla				varchar(100),
  @Tablaintelisis		varchar(100),
  @TablaCrm				varchar(100),    
  @Accion				varchar(100),  
  @xmlInserted			xml,  
  @xmlDelete			xml,  
  @CRMID				varchar(100),  
  @Bandera				int,
  @idAutomatico			bit,  
  @TEMP					varchar(100),  
  @Where				varchar(100),   
  @Where1				varchar(100),    
  @BuscarDato			bit,  
  @DefaultInsert		varchar(100),  
  @AccionEspecifica		varchar(10),  
  @AccionAnterior		varchar(10),  
  @Fecha				varchar(23),  
  @CampoLlave			varchar(50),  
  @TablaAnterior		varchar(50),  
  @ModoDebug			bit,  
  
  @SQL					nvarchar(max),
  @RutaXML				varchar(255),
  @Servidor				varchar(100),
  @Base					varchar(100)

--SET @ModoDebug = 1 --@Debug
  
  IF (OBJECT_ID('Tempdb..#IntelisisDatosXML')) IS NOT NULL
    DROP TABLE #IntelisisDatosXML
  ELSE
    CREATE TABLE #IntelisisDatosXML
    (
      Campo varchar(max) COLLATE Modern_Spanish_CS_AS NOT NULL,
      Valor varchar(max) COLLATE Modern_Spanish_CS_AS NULL
     )
       
  SET ANSI_NULLS ON
  SET ANSI_WARNINGS ON
  SET QUOTED_IDENTIFIER ON	
  SET CONTEXT_INFO 0x01

  SELECT @Accion = localname
    FROM OPENXML(@iSolicitud,'/Intelisis/Solicitud',1)
   WHERE nodetype = 1 AND parentid = 7

  SELECT @Tabla = localname
    FROM OPENXML(@iSolicitud,'/Intelisis/Solicitud',1)
   WHERE nodetype = 1 AND parentid = 8

  SELECT @RutaXML = '/Intelisis/Solicitud/' + @Accion + '/' + @Tabla

  INSERT #IntelisisDatosXML
  SELECT Campo.localname Campo, Valor.text Valor
    FROM OPENXML (@iSolicitud, @Rutaxml, 3) Campo
    LEFT OUTER JOIN OPENXML (@iSolicitud, @Rutaxml, 1) Valor
      ON Campo.id = Valor.parentid
   WHERE Campo.nodetype = 2
     AND Valor.nodetype = 3

  SELECT @Campos =''
  SELECT @Variables=''
  SELECT @Bandera = 0
  SELECT @TablaAnterior = ''
  
  SELECT
    @Servidor	= ServidorIntelisis,
    @Base		= BaseIntelisis
    FROM CfgCRM
    
  DECLARE crTablaSyncroIntelisis CURSOR FOR  
   SELECT TablaCrm,CampoInt, CampoExt , idAutomatico, BuscarDato, DefaultInsert, AccionEspecifica  
     FROM TablaSyncro   
    WHERE TablaIntelisis = @Tabla   
    ORDER BY  OrdenTabla, TablaIntelisis, TablaCRM, OrdenCampo  
  OPEN crTablaSyncroIntelisis  
  FETCH NEXT FROM crTablaSyncroIntelisis  
  INTO @TablaIntelisis, @CampoInt, @CampoExt, @idAutomatico, @BuscarDato, @DefaultInsert, @AccionEspecifica  
  WHILE @@FETCH_STATUS = 0  
  BEGIN
    IF @CampoExt IS NOT NULL
    BEGIN
      IF @TablaAnterior <> @TablaIntelisis AND @Bandera=0
        SELECT @TablaAnterior = @TablaIntelisis
      IF @TablaAnterior <> @TablaIntelisis
      BEGIN
        IF @Campos<>''
        BEGIN
          IF @Accion = 'INSERT'
          BEGIN
            SET @Campos = SUBSTRING(@Campos,1,LEN(@Campos)-1)
            SET @Variables = SUBSTRING(@Variables,1,LEN(@Variables)-1)
            SET @Campos = 'EXEC spSetInformacionContexto CRM, 1 INSERT INTO [' + @Servidor + '].[' + @Base + '].dbo.'+@TablaAnterior+' (' + @Campos + ') VALUES'
            SET @Variables = '(' +@Variables+ ')'
            SELECT @Campos = @Campos + @Variables
            
            IF @ModoDebug = 1
              PRINT (@Campos)
            ELSE
            BEGIN
              EXEC (@Campos)
            END
          END
          
          IF @Accion = 'UPDATE'
          BEGIN
            IF @TablaAnterior = 'LeadAddressBase'
              SELECT @Where =  ' AddressNumber= ''1'' AND ParentId '
            ELSE
            BEGIN
              SELECT @SQL = 'EXEC [' + @Servidor + '].[' + @Base + '].dbo.spBuscaDatoCRM ''' + 'Llave' + ''', ''' + @TablaAnterior + ''', ''' + '' + ''', @Where OUTPUT'
              
              IF @ModoDebug = 1
                PRINT (@Campos)
              ELSE
              BEGIN
                EXEC sp_executesql @SQL, N'@Where varchar(max) OUTPUT', @Where = @Where OUTPUT
              END
            END
            
            SET @Campos = SUBSTRING(@Campos,1,LEN(@Campos)-1)
            SELECT @Campos = 'EXEC spSetInformacionContexto CRM, 1 UPDATE [' + @Servidor + '].[' + @Base + '].dbo.' + @TablaAnterior + ' SET '+ @Campos+' WHERE '+@Where+' = '''+@CRMID+''''
            IF @ModoDebug = 1
              PRINT (@Campos)
            ELSE
            BEGIN
              EXEC (@Campos)
            END
          END
        END
        
        SELECT
          @Campos		 = '',
          @Variables	 = '',
          @TablaAnterior = @TablaIntelisis
      END
      
      IF @AccionEspecifica IS NOT NULL  
      BEGIN  
        SELECT @Accion = @AccionEspecifica  
      END  
  
      IF @Accion = 'INSERT'  
      BEGIN  
        SET @Campos = @Campos + @CampoExt + ', '        
        SELECT @SQL = 'SELECT @Valor = Valor '+ ' FROM #IntelisisDatosXML WHERE Campo = ''' + @CampoInt + ''''
        EXECUTE sp_executesql @SQL, N'@Valor varchar(max) OUTPUT', @Valor OUTPUT

        IF @Valor IS NULL
          SELECT @Valor = ''  
  
        IF @CampoInt = 'Estatus' AND @CampoExt = 'StateCode' AND @Valor = 'ALTA'  
          SELECT @Valor = '0'  
        IF @CampoInt = 'Estatus' AND @CampoExt = 'StateCode' AND @Valor = 'BAJA'  
          SELECT @Valor = '1'  
        IF @CampoInt = 'Estatus' AND @CampoExt = 'StatusCode' AND @Valor = 'ALTA'  
          SELECT @Valor = '1'  
        IF @CampoInt = 'Estatus' AND @CampoExt = 'StatusCode' AND @Valor = 'BAJA'  
          SELECT @Valor = '2'  
  
        --****  Controla los consecutivos de intelisis  ***  
        IF @idAutomatico= 1   
        BEGIN
          SELECT @SQL = 'EXEC [' + @Servidor + '].[' + @Base + '].dbo.spBuscaDatoCRM ''' + 'Consecutivo' + ''', ''' + @TablaIntelisis + ''', ''' + ISNULL(@Campos,'') + ''', @TEMP OUTPUT'
          IF @ModoDebug = 1
            PRINT (@Campos)
          ELSE
          BEGIN
            EXEC sp_executesql @SQL, N'@TEMP varchar(max) OUTPUT', @TEMP = @TEMP OUTPUT
          END
          SELECT @Valor = RTRIM(@TEMP)  
        END  
           
        --****  Busca datos en las tablas de intelisis ejemplo el agente  ***  
        IF @BuscarDato= 1 AND @idAutomatico= 0   
        BEGIN
          SELECT @SQL = 'EXEC [' + @Servidor + '].[' + @Base + '].dbo.spBuscaDatoCRM ''' + 'Busca' + ''', ''' + @CampoExt + ''', ''' + @Valor + ''', @TEMP OUTPUT'
          IF @ModoDebug = 1
            PRINT (@Campos)
          ELSE
          BEGIN
            EXEC sp_executesql @SQL, N'@TEMP varchar(max) OUTPUT', @TEMP = @TEMP OUTPUT
          END
          SELECT @Valor = RTRIM(@TEMP)
        END
           
        --**** Coloca valores por default solo en en INSERT ****  
        IF @DefaultInsert IS NOT NULL   
        BEGIN  
          IF @DefaultInsert = 'GUID'  
            SELECT @DefaultInsert = NEWID()  
           
          IF @DefaultInsert = 'Fecha'  
            SELECT @DefaultInsert= GETDATE()  
  
          SELECT @Valor= @DefaultInsert  
        END             
        SET @Variables = @Variables + '''' + @Valor + ''', '
      END  
  
      IF @Accion = 'UPDATE'  
      BEGIN  
        SELECT @SQL = 'SELECT @Valor = Valor '+ ' FROM #IntelisisDatosXML WHERE Campo = ''' + @CampoInt + ''''
        EXECUTE sp_executesql @SQL, N'@Valor varchar(max) OUTPUT', @Valor OUTPUT

        IF @Valor IS NULL
          SELECT @Valor = ''  
        IF @CampoInt = 'Estatus' AND @CampoExt = 'StateCode' AND @Valor = 'ALTA'  
          SELECT @Valor = '0'  
        IF @CampoInt = 'Estatus' AND @CampoExt = 'StateCode' AND @Valor = 'BAJA'  
          SELECT @Valor = '1'  
  
        IF @CampoInt = 'Estatus' AND @CampoExt = 'StatusCode' AND @Valor = 'ALTA'  
          SELECT @Valor = '1'  
        IF @CampoInt = 'Estatus' AND @CampoExt = 'StatusCode' AND @Valor = 'BAJA'  
          SELECT @Valor = '2'  
                     
          --****  Busca datos en las tablas de intelisis ejemplo el agente  ***  
        IF @BuscarDato= 1    
        BEGIN  
          SELECT @SQL = 'EXEC [' + @Servidor + '].[' + @Base + '].dbo.spBuscaDatoCRM ''' + 'Busca' + ''', ''' + @CampoExt + ''', ''' + @Valor + ''', @TEMP OUTPUT'
          IF @ModoDebug = 1
            PRINT (@Campos)
          ELSE
          BEGIN
            EXEC sp_executesql @SQL, N'@TEMP varchar(max) OUTPUT', @TEMP = @TEMP OUTPUT
          END
          SELECT @Valor= RTRIM(@TEMP)  
        END  
           
        IF @DefaultInsert IS NOT NULL   
        BEGIN  
          IF @DefaultInsert = 'GUID'  
            SELECT @DefaultInsert = NEWID()  
           
          IF @DefaultInsert = 'Fecha'  
            SELECT @DefaultInsert= GETDATE()  
  
          SELECT @Valor= @DefaultInsert  
        END  
            
        IF @Valor<>''  
          SET @Campos = @Campos + @CampoExt + '= ''' + @Valor + ''', '  
  
      END  
--select @Bandera, @Valor, @TablaIntelisis, @CampoInt, @CampoExt,@idAutomatico, @BuscarDato, @DefaultInsert, @AccionEspecifica, @BuscarDato
      IF @Bandera = 0   
      BEGIN  
        SELECT @CRMID = @Valor  
        SELECT @Bandera = 1  
      END  
    END  
    FETCH NEXT FROM crTablaSyncroIntelisis  
    INTO @TablaIntelisis, @CampoInt, @CampoExt, @idAutomatico, @BuscarDato, @DefaultInsert, @AccionEspecifica  
  END  
  CLOSE crTablaSyncroIntelisis  
  DEALLOCATE crTablaSyncroIntelisis  
  
  IF @Campos <> ''  
  BEGIN   
    IF @Accion = 'INSERT'  
    BEGIN  
      SET @Campos = SUBSTRING(@Campos,1,LEN(@Campos)-1)  
      SET @Variables = SUBSTRING(@Variables,1,LEN(@Variables)-1)  
      SET @Campos = 'EXEC spSetInformacionContexto CRM, 1 INSERT INTO [' + @Servidor + '].[' + @Base + '].dbo.'+@TablaIntelisis+' (' +@Campos+ ') VALUES'  
      SET @Variables = '(' +@Variables+ ')'  
      SELECT @CAMPOS = @CAMPOS + @Variables  
      
      IF @ModoDebug = 1   
        PRINT (@Campos)  
      ELSE  
      BEGIN  
        EXEC (@Campos)
      END   
    END  
    
    IF @Accion = 'UPDATE'      
    BEGIN  
      
      --Este IF solo aplicac para la tabla LeadAddressBase  
      IF @TablaAnterior = 'LeadAddressBase' OR @TablaAnterior = 'CustomerAddressBase'  
        SELECT @Where =  ' AddressNumber= ''1'' AND ParentId '  
      ELSE
      BEGIN
        SELECT @SQL = 'EXEC [' + @Servidor + '].[' + @Base + '].dbo.spBuscaDatoCRM ''' + 'Llave' + ''', ''' + @TablaAnterior + ''', ''' + '' + ''', @Where OUTPUT'
        IF @ModoDebug = 1
          PRINT (@Campos)
        ELSE
        BEGIN
          EXEC sp_executesql @SQL, N'@Where varchar(max) OUTPUT', @Where = @Where OUTPUT
        END
      END
     
      SET @Campos = SUBSTRING(@Campos,1,LEN(@Campos)-1)    
      SELECT @Campos = 'EXEC spSetInformacionContexto CRM, 1 UPDATE [' + @Servidor + '].[' + @Base + '].dbo.' + @TablaIntelisis + ' SET '+ @Campos+' WHERE '+@Where+' = '''+@CRMID+''''  
      IF @ModoDebug = 1   
        PRINT (@Campos)  
      ELSE  
      BEGIN    
        EXEC (@Campos)
      END             
    END  
  END      
  EXEC spSetInformacionContexto CRM, 0
  RETURN
END
GO

/**************** spISIntelisisCXPInsertarMovCXP_F ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisCXPInsertarMovCXP_F') and type = 'P') drop procedure dbo.spISIntelisisCXPInsertarMovCXP_F
GO             
CREATE PROCEDURE spISIntelisisCXPInsertarMovCXP_F
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  		@Empresa				varchar(5),
		@Mov					varchar(20),
		@MovID					varchar(20),
		@FechaEmision			datetime,
		@Concepto				varchar(50),
		@Proyecto				varchar(50),
		@UEN					int,
		@Moneda					varchar(10),		
		@TipoCambio				float,
		@Usuario				varchar(10),
		@Referencia				varchar(50),
		@Observaciones			varchar(100),
		@Estatus				varchar(15),
		@EstatusNuevo			varchar(15),
		@Proveedor				varchar(10),
		@ProveedorMoneda		varchar(10),
		@ProveedorTipoCambio	float,
		@Condicion				varchar(50),
		@Vencimiento			datetime,
		@FormaPago				varchar(50),
		@Importe				money,
		@Impuestos				money,
		@Retencion				money,
		@Retencion2				money,
		@Retencion3				money,
		@Saldo					money,
		@OrigenTipo				varchar(10),
		@Origen					varchar(20),
		@OrigenID				varchar(20),
		@GenerarPoliza			bit,
		@FechaRegistro			datetime,
		@DescuentoProntoPago	float,
		@Sucursal				int,
		@IDGenerar				int,
		@MovTipo				varchar(20),
		@ReferenciaIS			varchar(100),
		@SubReferencia			varchar(100)
								

  BEGIN TRANSACTION 
  
  IF @Ok IS NULL
  BEGIN
    SELECT @Mov =  NULLIF(Mov,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Mov varchar(255))
    IF @@ERROR <> 0 SET @Ok = 1
  END
  
  IF @Ok IS NULL
    SELECT @MovTipo = Clave
	  FROM MovTipo
     WHERE Modulo = 'CXP' AND Mov = @Mov
   
  IF @MovTipo <> 'CXP.F' SELECT @Ok = 35005, @OkRef = @Mov
  
  IF @Ok IS NULL
  BEGIN  
    SELECT @Empresa = NULLIF(Empresa,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Empresa varchar(255))
    SELECT @MovID =  NULLIF(MovID,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (MovID varchar(255)) 
    SELECT @FechaEmision = CONVERT(datetime,FechaEmision) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (FechaEmision varchar(255))
    SELECT @Concepto =  NULLIF(Concepto,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Concepto varchar(255))
    SELECT @Proyecto =  NULLIF(Proyecto,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Proyecto varchar(255))
    SELECT @UEN = CONVERT(int,UEN) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (UEN varchar(255))
    SELECT @Moneda =  NULLIF(Moneda,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Moneda varchar(255))
    SELECT @TipoCambio = CONVERT(float,TipoCambio) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (TipoCambio varchar(255))
    SELECT @Usuario =  NULLIF(Usuario,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Usuario varchar(255))
    SELECT @Referencia =  NULLIF(Referencia,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Referencia varchar(255))
    SELECT @Observaciones =  NULLIF(Observaciones,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Observaciones varchar(255))
    SELECT @EstatusNuevo =  NULLIF(EstatusNuevo,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (EstatusNuevo varchar(255))
    SELECT @Proveedor =  NULLIF(Proveedor,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Proveedor varchar(255))
    SELECT @ProveedorMoneda =  NULLIF(ProveedorMoneda,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (ProveedorMoneda varchar(255)) 
    SELECT @Condicion =  NULLIF(Condicion,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Condicion varchar(255)) 
    SELECT @Vencimiento = CONVERT(datetime,Vencimiento) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Vencimiento varchar(255))
    SELECT @FormaPago =  NULLIF(FormaPago,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (FormaPago varchar(255))
    SELECT @Importe = CONVERT(money,Importe) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Importe varchar(255))   
    SELECT @Impuestos = CONVERT(money,Impuestos) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Impuestos varchar(255))
    SELECT @Retencion = CONVERT(money,Retencion) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Retencion varchar(255)) 
    SELECT @Retencion2 = CONVERT(money,Retencion2) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Retencion2 varchar(255))  
    SELECT @Retencion3 = CONVERT(money,Retencion3) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Retencion3 varchar(255))
    SELECT @Saldo = CONVERT(money,Saldo) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Saldo varchar(255))
    SELECT @OrigenTipo =  NULLIF(OrigenTipo,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (OrigenTipo varchar(255))   
    SELECT @Origen =  NULLIF(Origen,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Origen varchar(255))   
    SELECT @OrigenID =  NULLIF(OrigenID,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (OrigenID varchar(255))
    SELECT @GenerarPoliza = CONVERT(bit,GenerarPoliza) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (GenerarPoliza varchar(255))  
    SELECT @FechaRegistro = CONVERT(datetime,FechaRegistro) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (FechaRegistro varchar(255)) 
    SELECT @DescuentoProntoPago = CONVERT(float,DescuentoProntoPago) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (DescuentoProntoPago varchar(255))
    SELECT @Sucursal = CONVERT(int,Sucursal) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Sucursal varchar(255))
  END
  
  IF @Ok IS NULL
  BEGIN  
    SET @Estatus = 'SINAFECTAR'  
    IF @EstatusNuevo = 'BORRADOR' SET @Estatus = 'BORRADOR'  

    IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = @Proveedor ) SELECT @Ok = 26050
    IF NOT EXISTS(SELECT * FROM Proy WHERE Proyecto = @Proyecto ) AND NULLIF(@Proyecto,'') IS NOT NULL SELECT @Ok = 15010
    IF NOT EXISTS(SELECT * FROM UEN WHERE UEN = @UEN ) AND NULLIF(@UEN,'') IS NOT NULL SELECT @Ok = 10070
    IF NOT EXISTS(SELECT * FROM Concepto WHERE Concepto = @Concepto AND Modulo = 'CXP') AND NULLIF(@Concepto,'') IS NOT NULL SELECT @Ok = 20485

    SELECT 
      @ProveedorMoneda = ISNULL(@ProveedorMoneda,DefMoneda),
      @Condicion = ISNULL(@Condicion,Condicion)
      FROM Prov
     WHERE Proveedor = @Proveedor

    IF NOT EXISTS(SELECT * FROM Condicion WHERE Condicion = @Condicion ) AND NULLIF(@Condicion,'') IS NOT NULL SELECT @Ok = 30030     
    IF NOT EXISTS(SELECT * FROM Mon WHERE Moneda = @ProveedorMoneda ) AND NULLIF(@ProveedorMoneda,'') IS NOT NULL SELECT @Ok = 20196
    IF NOT EXISTS(SELECT * FROM Mon WHERE Moneda = @Moneda ) AND NULLIF(@Moneda,'') IS NOT NULL SELECT @Ok = 20196
      
    SELECT
      @ProveedorTipoCambio = TipoCambio 
      FROM Mon
     WHERE Moneda = @ProveedorMoneda
   
    SELECT 
      @Condicion = ISNULL(@Condicion,Condicion)
      FROM Prov
     WHERE Proveedor = @Proveedor
   
    SELECT 
      @FormaPago = ISNULL(@FormaPago,FormaPago)
      FROM Prov
     WHERE Proveedor = @Proveedor
  END
    
  IF @Ok IS NULL
  BEGIN  
    INSERT INTO Cxp (Empresa,  Mov,  MovID,  FechaEmision,  Concepto,  Proyecto,  UEN,  Moneda,  TipoCambio,  Usuario,  Referencia,  Observaciones,  Estatus,  Proveedor,  ProveedorMoneda,  ProveedorTipoCambio,  Condicion,  Vencimiento,  FormaPago,  Importe,  Impuestos,  Retencion,  Retencion2,  Retencion3,  Saldo,  OrigenTipo,  Origen,  OrigenID,  GenerarPoliza,  FechaRegistro,  DescuentoProntoPago,  Sucursal)
	     VALUES (@Empresa, @Mov, @MovID, @FechaEmision, @Concepto, @Proyecto, @UEN, @Moneda, @TipoCambio, @Usuario, @Referencia, @Observaciones, @Estatus, @Proveedor, @ProveedorMoneda, @ProveedorTipoCambio, @Condicion, @Vencimiento, @FormaPago, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, @Saldo, @OrigenTipo, @Origen, @OrigenID, @GenerarPoliza, @FechaRegistro, @DescuentoProntoPago, @Sucursal)
    IF @@ERROR <> 0 SET @Ok = 1
    SET @IDGenerar = SCOPE_IDENTITY()
  END
  
  IF @Ok IS NULL AND @Estatus = 'SINAFECTAR'
    EXEC spAfectar 'CXP', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1, @@SPID
    
  SELECT @ReferenciaIS = Referencia 
    FROM IntelisisService 
   WHERE ID = @ID
  
  SET @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo=”CXP” ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'
  
    IF @Ok IS NULL
    BEGIN
      COMMIT TRANSACTION 
    END ELSE
    BEGIN
      ROLLBACK TRANSACTION 
    --SELECT @OkRef = 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
    END

END
GO

/*
<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.CXP.InsertarMov.CXP_CA" SubReferencia="aaa" Version="1.0">
  <Solicitud>
       <Cxp Empresa="DEMO" Mov="Nota Credito" MovID="" FechaEmision="11/08/2009" Concepto="" Proyecto="" UEN="" Moneda="Pesos" TipoCambio="1" Usuario="DEMO"  Referencia="" Observaciones="" Estatus="PENDIENTE" Proveedor="Fonacot" ProveedorMoneda="Pesos" Condicion="(Fecha)" Vencimiento="08/11/2009" FormaPago="" Importe="3920.00" Impuestos="588.00" Retencion="0.00" Retencion2="0.00" Retencion3="0.00" Saldo="45080.00" OrigenTipo="" Origen="" OrigenID="" GenerarPoliza="0" FechaRegistro="08/11/2009" DescuentoProntoPago="" Sucursal="0">
         <DetalleCxp Importe="2000.0" Aplica="Entrada Compra" AplicaID="16"/>
         <DetalleCxp Importe="3000.0" Aplica="Entrada Compra" AplicaID="17"/>
       </Cxp>  
  </Solicitud>
</Intelisis>
*/
/**************** spISIntelisisCXPInsertarMovCXP_CA ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisCXPInsertarMovCXP_CA') and type = 'P') drop procedure dbo.spISIntelisisCXPInsertarMovCXP_CA
GO             
CREATE PROCEDURE spISIntelisisCXPInsertarMovCXP_CA
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  		@Empresa				varchar(5),
		@Mov					varchar(20),
		@MovID					varchar(20),
		@FechaEmision			datetime,
		@Concepto				varchar(50),
		@Proyecto				varchar(50),
		@UEN					int,
		@Moneda					varchar(10),		
		@TipoCambio				float,
		@Usuario				varchar(10),
		@Referencia				varchar(50),
		@Observaciones			varchar(100),
		@Estatus				varchar(15),
		@EstatusNuevo			varchar(15),
		@Proveedor				varchar(10),
		@ProveedorMoneda		varchar(10),
		@ProveedorTipoCambio	float,
		@Condicion				varchar(50),
		@Vencimiento			datetime,
		@FormaPago				varchar(50),
		@Importe				money,
		@Impuestos				money,
		@Retencion				money,
		@Retencion2				money,
		@Retencion3				money,
		@Saldo					money,
		@OrigenTipo				varchar(10),
		@Origen					varchar(20),
		@OrigenID				varchar(20),
		@GenerarPoliza			bit,
		@FechaRegistro			datetime,
		@DescuentoProntoPago	float,
		@Sucursal				int,
		@IDGenerar				int,
		@MovTipo				varchar(20),
		@ReferenciaIS			varchar(100),
		@SubReferencia			varchar(100),
		@Renglon				float,
		@RenglonSub				float,
	    @DImporte				money,
		@Aplica					varchar(20),
		@AplicaID				varchar(20),
		@Suma					money,
        @AplicaManual           bit
								
  DECLARE @Temp     	    table
         (
          Renglon			float,
		  RenglonSub		float,
		  Importe			money,
		  Aplica			varchar(20),
		  AplicaID			varchar(20),
		  Sucursal   		int
         )


  BEGIN TRANSACTION 
  
  IF @Ok IS NULL
  BEGIN
    SELECT @Mov =  NULLIF(Mov,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Mov varchar(255))
    IF @@ERROR <> 0 SET @Ok = 1
  END
  
  IF @Ok IS NULL
    SELECT @MovTipo = Clave
	  FROM MovTipo
     WHERE Modulo = 'CXP' AND Mov = @Mov
   
  IF @MovTipo <> 'CXP.CA' SELECT @Ok = 35005, @OkRef = @Mov
  
  IF @Ok IS NULL
  BEGIN  
    SELECT @Empresa = NULLIF(Empresa,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Empresa varchar(255))
    SELECT @MovID =  NULLIF(MovID,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (MovID varchar(255)) 
    SELECT @FechaEmision = CONVERT(datetime,FechaEmision) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (FechaEmision varchar(255))
    SELECT @Concepto =  NULLIF(Concepto,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Concepto varchar(255))
    SELECT @Proyecto =  NULLIF(Proyecto,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Proyecto varchar(255))
    SELECT @UEN = CONVERT(int,UEN) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (UEN varchar(255))
    SELECT @Moneda =  NULLIF(Moneda,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Moneda varchar(255))
    SELECT @TipoCambio = CONVERT(float,TipoCambio) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (TipoCambio varchar(255))
    SELECT @Usuario =  NULLIF(Usuario,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Usuario varchar(255))
    SELECT @Referencia =  NULLIF(Referencia,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Referencia varchar(255))
    SELECT @Observaciones =  NULLIF(Observaciones,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Observaciones varchar(255))
    SELECT @EstatusNuevo =  NULLIF(EstatusNuevo,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (EstatusNuevo varchar(255))
    SELECT @Proveedor =  NULLIF(Proveedor,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Proveedor varchar(255))
    SELECT @ProveedorMoneda =  NULLIF(ProveedorMoneda,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (ProveedorMoneda varchar(255)) 
    SELECT @Condicion =  NULLIF(Condicion,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Condicion varchar(255)) 
    SELECT @Vencimiento = CONVERT(datetime,Vencimiento) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Vencimiento varchar(255))
    SELECT @FormaPago =  NULLIF(FormaPago,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (FormaPago varchar(255))
    SELECT @Importe = CONVERT(money,Importe) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Importe varchar(255))   
    SELECT @Impuestos = CONVERT(money,Impuestos) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Impuestos varchar(255))
    SELECT @Retencion = CONVERT(money,Retencion) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Retencion varchar(255)) 
    SELECT @Retencion2 = CONVERT(money,Retencion2) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Retencion2 varchar(255))  
    SELECT @Retencion3 = CONVERT(money,Retencion3) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Retencion3 varchar(255))
    SELECT @Saldo = CONVERT(money,Saldo) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Saldo varchar(255))
    SELECT @OrigenTipo =  NULLIF(OrigenTipo,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (OrigenTipo varchar(255))   
    SELECT @Origen =  NULLIF(Origen,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Origen varchar(255))   
    SELECT @OrigenID =  NULLIF(OrigenID,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (OrigenID varchar(255))
    SELECT @GenerarPoliza = CONVERT(bit,GenerarPoliza) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (GenerarPoliza varchar(255))  
    SELECT @FechaRegistro = CONVERT(datetime,FechaRegistro) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (FechaRegistro varchar(255)) 
    SELECT @DescuentoProntoPago = CONVERT(float,DescuentoProntoPago) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (DescuentoProntoPago varchar(255))
    SELECT @Sucursal = CONVERT(int,Sucursal) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (Sucursal varchar(255))
    SELECT @AplicaManual = CONVERT(bit,AplicaManual) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Cxp')
      WITH (AplicaManual varchar(255))

  END
  
  IF @Ok IS NULL
  BEGIN  
    SET @Estatus = 'SINAFECTAR'  
    IF @EstatusNuevo = 'BORRADOR' SET @Estatus = 'BORRADOR'  
    IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = @Proveedor ) SELECT @Ok = 26050
    IF NOT EXISTS(SELECT * FROM Proy WHERE Proyecto = @Proyecto ) AND NULLIF(@Proyecto,'') IS NOT NULL SELECT @Ok = 15010
    IF NOT EXISTS(SELECT * FROM UEN WHERE UEN = @UEN ) AND NULLIF(@UEN,'') IS NOT NULL SELECT @Ok = 10070
    IF NOT EXISTS(SELECT * FROM Concepto WHERE Concepto = @Concepto AND Modulo = 'CXP') AND NULLIF(@Concepto,'') IS NOT NULL SELECT @Ok = 20485

    SELECT 
      @ProveedorMoneda = ISNULL(@ProveedorMoneda,DefMoneda),
      @Condicion = ISNULL(@Condicion,Condicion)
      FROM Prov
     WHERE Proveedor = @Proveedor

    IF NOT EXISTS(SELECT * FROM Condicion WHERE Condicion = @Condicion ) AND NULLIF(@Condicion,'') IS NOT NULL SELECT @Ok = 30030     
    IF NOT EXISTS(SELECT * FROM Mon WHERE Moneda = @ProveedorMoneda ) AND NULLIF(@ProveedorMoneda,'') IS NOT NULL SELECT @Ok = 20196
    IF NOT EXISTS(SELECT * FROM Mon WHERE Moneda = @Moneda ) AND NULLIF(@Moneda,'') IS NOT NULL SELECT @Ok = 20196

    SELECT
      @ProveedorTipoCambio = TipoCambio 
      FROM Mon
     WHERE Moneda = @ProveedorMoneda
    
   
    SELECT 
      @Condicion = ISNULL(@Condicion,Condicion)
      FROM Prov
     WHERE Proveedor = @Proveedor
   
    SELECT 
      @FormaPago = ISNULL(@FormaPago,FormaPago)
      FROM Prov
     WHERE Proveedor = @Proveedor

  END
   
  IF @Ok IS NULL
  BEGIN  
    INSERT INTO Cxp (Empresa,  Mov,  MovID,  FechaEmision,  Concepto,  Proyecto,  UEN,  Moneda,  TipoCambio,  Usuario,  Referencia,  Observaciones,  Estatus,  Proveedor,  ProveedorMoneda,  ProveedorTipoCambio,  Condicion,  Vencimiento,  FormaPago,  Importe,  Impuestos,  Retencion,  Retencion2,  Retencion3,  Saldo,  OrigenTipo,  Origen,  OrigenID,  GenerarPoliza,  FechaRegistro,  DescuentoProntoPago,  Sucursal)
	     VALUES (@Empresa, @Mov, @MovID, @FechaEmision, @Concepto, @Proyecto, @UEN, @Moneda, @TipoCambio, @Usuario, @Referencia, @Observaciones, @Estatus, @Proveedor, @ProveedorMoneda, @ProveedorTipoCambio, @Condicion, @Vencimiento, @FormaPago, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, @Saldo, @OrigenTipo, @Origen, @OrigenID, @GenerarPoliza, @FechaRegistro, @DescuentoProntoPago, @Sucursal)
    IF @@ERROR <> 0 SET @Ok = 1
    SET @IDGenerar = SCOPE_IDENTITY()
  END

  SELECT @RenglonSub = 0
  INSERT @Temp (Importe, Aplica, AplicaID)
  SELECT Importe, Aplica, AplicaID 
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Cxp/DetalleCxp',1)  
    WITH (Importe varchar(100), Aplica varchar(100), AplicaID varchar(100))

  SELECT @Suma = SUM(Importe) FROM @Temp
  IF @Suma <> (@Importe + @Impuestos) AND @AplicaManual = 1 SET @Ok = 30230

  IF @AplicaManual = 1
  BEGIN
    DECLARE crDetalle CURSOR FOR 
    SELECT Importe, Aplica, AplicaID 
    FROM @Temp
    SET @Renglon = 0.0

    OPEN crDetalle
    FETCH NEXT FROM crDetalle INTO @DImporte,@Aplica,@AplicaID
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL 
    BEGIN
      SET @Renglon = @Renglon + 2048.0
      INSERT CxpD ( ID,   Renglon,  RenglonSub,  Importe,  Aplica,  AplicaID,  Sucursal)
      VALUES (@IDGenerar, @Renglon, @RenglonSub, @DImporte,@Aplica, @AplicaID, @Sucursal)
      IF @@ERROR <> 0 SET @Ok = 1

      FETCH NEXT FROM crDetalle INTO @DImporte,@Aplica,@AplicaID
    END
    CLOSE crDetalle
    DEALLOCATE crDetalle
  END 

  IF @Ok IS NULL AND @Estatus = 'SINAFECTAR'
    EXEC spAfectar 'CXP', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1, @@SPID
    
  SELECT @ReferenciaIS = Referencia 
    FROM IntelisisService 
   WHERE ID = @ID
  
  SET @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo=”CXP” ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
  END
END
GO

/*************** spIntelisisServiceEnviarCorreo *******************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceEnviarCorreo') and type = 'P') drop procedure dbo.spIntelisisServiceEnviarCorreo --MEJORA5066
GO             
CREATE PROCEDURE spIntelisisServiceEnviarCorreo
		    @Empresa	varchar(5),
            @Para		varchar(8000),
            @CC			varchar(8000),                                    
            @CCO		varchar(8000),            
		    @Asunto		varchar(8000),
		    @Mensaje	varchar(8000) = NULL,
		    -- 11326
		    @Anexos		varchar(max) = NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Perfil		varchar(50),
    @ID			int,
    @NombreCorreoEnLote	varchar(100)

  SELECT @Perfil = DBMailPerfil FROM EmpresaGral WHERE Empresa = @Empresa

  SELECT @Para    = NULLIF(RTRIM(@Para), ''), 
         @CC      = NULLIF(RTRIM(@CC), ''), 
         @CCO     = NULLIF(RTRIM(@CCO), ''),          
         @Asunto  = NULLIF(RTRIM(@Asunto), ''),         
         @Mensaje = NULLIF(RTRIM(@Mensaje), ''), 
         @Anexos  = NULLIF(RTRIM(@Anexos), '')

  IF @Para IS NOT NULL 
  BEGIN
    EXEC spEnviarDBMail @Perfil, @Para, @CC = @CC, @CCO = @CCO, @Asunto = @Asunto, @Mensaje = @Mensaje, @Formato = 'HTML', @Adjuntos = @Anexos
 
  END
END
GO

/************************ xpPOSReporteReporteador *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.xpPOSReporteReporteador') AND type = 'P') DROP PROCEDURE dbo.xpPOSReporteReporteador
GO             
CREATE PROCEDURE xpPOSReporteReporteador
 
  @Empresa	        varchar(5),	 
  @Modulo	        varchar(20),
  @ModuloID	        varchar(20),
  @ArchivoXML		varchar(255),
  @NomArch              varchar(255)
          
AS BEGIN
  DECLARE 
    @MovCFD                     varchar(20),
    @ReferenciaOrdenCompra      varchar(50)
   

    SELECT @MovCFD = MovFactura
      FROM POSCfg
     WHERE Empresa = @Empresa  
  IF @Modulo = 'VTAS'
  BEGIN
    IF EXISTS(SELECT * FROM Venta WHERE OrigenTipo = 'POS' AND ID = @ModuloID AND Mov = @MovCFD)
    BEGIN
      SELECT @ReferenciaOrdenCompra = ReferenciaOrdenCompra FROM Venta WHERE ID = @ModuloID

      IF EXISTS(SELECT * FROM POSL WHERE ID = @ReferenciaOrdenCompra)
        UPDATE POSL SET NombreArchivo = @NomArch
        WHERE ID = @ReferenciaOrdenCompra    
    END
  END   
  RETURN
END
GO

/************************ xpPOSReporteJasper *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.xpPOSReporteJasper') AND type = 'P') DROP PROCEDURE dbo.xpPOSReporteJasper
GO             
CREATE PROCEDURE xpPOSReporteJasper
  @Empresa	        varchar(5),	 
  @Modulo	        varchar(20),
  @ModuloID	        varchar(20),
  @ArchivoXML		varchar(255),
  @NomArch              varchar(255)
          
AS BEGIN
  DECLARE 
    @MovCFD                     varchar(20),
    @ReferenciaOrdenCompra      varchar(50),
    @XmlJasper                  varchar(max)
   
    SELECT @MovCFD = MovFactura
      FROM POSCfg
     WHERE Empresa = @Empresa  
  
  IF @Modulo = 'VTAS'
  BEGIN
    IF EXISTS(SELECT * FROM Venta WHERE OrigenTipo = 'POS' AND ID = @ModuloID AND Mov = @MovCFD)
    BEGIN
      SELECT @ReferenciaOrdenCompra = ReferenciaOrdenCompra FROM Venta WHERE ID = @ModuloID
      SELECT @XmlJasper = dbo.fnPOSLeerArchivo(@ArchivoXML)
      
      IF EXISTS(SELECT * FROM POSL WHERE ID = @ReferenciaOrdenCompra)
        UPDATE POSL SET XmlJasper = @XmlJasper, NombreArchivo = @NomArch
        WHERE ID = @ReferenciaOrdenCompra    
    END
  END   
  RETURN
END
GO

/******************* spISSDKReportePDF *******************/
if OBJECT_ID('dbo.spISSDKReportePDF') is not null
  DROP PROCEDURE spISSDKReportePDF
GO
CREATE PROCEDURE spISSDKReportePDF
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT,
		@CambiarEstatus	bit OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Expresion				varchar(max),
	@XML					varchar(max),
    @Sistema				varchar(100),
    @Referencia				varchar(100),    
    @ArchivoXML				varchar(255),
	@Empresa				varchar(5),
    @Modulo					varchar(5),
    @ModuloID				int,
    @Archivo				varchar(255),
    @iDatos					int,
    @XMLExiste				int,
    @Documento				varchar(max),
    @Shell					varchar(8000),
    @RutaJasper				varchar(255),
    @Jasper					bit,
    @Ruta					varchar(255),
    @RutaTemporal			varchar(255),
    @NomArch				varchar(255),
    @ArchivoBMP				varchar(255),
    @Mov					varchar(20),
    @Reporte				varchar(50),
    @RutaLogo				varchar(255),
	@AlmacenarPDF			varchar(5),
	--REQ Q3069 CFDGT	
	@RutaDatosXML			varchar(255),
	@JasperFueraLinea		bit,
	 --REQ 14790
	@Nailgun				bit,
	@RutaNG					varchar(255),	
    @HtaGenerarPDF			varchar(5),
	@ReportBuilder          bit, --REQ 16770
    @RutaReportBuilder      varchar(255),--REQ 16770
    @BaseArchivo            varchar(255),--REQ 16770
    @Movimiento             varchar(20),--REQ 16770
    @Sucursal               int,--REQ 16770
    @Usuario                char(10),
    @Reporteador            varchar(30),
    @ReporteIntelisis       bit, --TASK 17532
	@RutaLog                varchar(255),--BUG 17613
	@Existe                 bit,
	@EnviarAlAfectar		bit
	
  DECLARE @Datos TABLE(Datos varchar(255) COLLATE DATABASE_DEFAULT NULL)  

  DECLARE @Tabla TABLE (IDIntelisisService		int,
			            Expresion				varchar(max) COLLATE DATABASE_DEFAULT NULL)
			            
  DELETE @Datos					   					   
  DELETE @Tabla
  INSERT @Tabla	
  EXEC xpEscucharSQLAntes @ID
  
  SELECT @ArchivoXML = ''
  SET @Jasper = 0
  SET @ReportBuilder = 0
  SET @ReporteIntelisis = 0 --Bug 17320
  

  SELECT @Empresa	= RTRIM(LTRIM(ISNULL(Empresa,''))),
         @Modulo	= RTRIM(LTRIM(ISNULL(Modulo,''))),
         @ModuloID	= ID,
         @Archivo	= RTRIM(LTRIM(ISNULL(Archivo,''))),
         @NomArch	= RTRIM(LTRIM(ISNULL(NomArch,''))),
         @Mov		= RTRIM(LTRIM(ISNULL(Mov,''))),
		 @AlmacenarPDF = AlmacenarPDF,		 
		 @HtaGenerarPDF=HtaGenerarPDF
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud', 2) WITH (Empresa varchar(5), Modulo varchar(5), ID int, Archivo varchar(255), NomArch varchar(255), Mov varchar(20), AlmacenarPDF varchar(5),GenerarPdfAfectar varchar(5),HtaGenerarPDF varchar(5))

  SELECT @Reporte = NULLIF(ReporteJasper,'') FROM EmpresaCFDReporte WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov

  IF @Reporte IS NULL SELECT @Reporte = RTRIM(LTRIM(NULLIF(CFDReporteJasper,''))) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov

  SELECT @RutaJasper		= RTRIM(LTRIM(ISNULL(RutaJasper,''))),
         @RutaReportBuilder = RTRIM(LTRIM(ISNULL(RutaReportBuilder,''))),--REQ 16770
         @Reporteador       = ISNULL(Reporteador,''),--BUG 17392


         @RutaTemporal		= RTRIM(LTRIM(ISNULL(RutaTemporal,''))),
		 @JasperFueraLinea	= ISNULL(JasperFueraLinea,0),
		 --REQ 14790
		 @Nailgun			= ISNULL(Nailgun,0),
		 @RutaNG			= REPLACE(@RutaJasper,'IntelisisJReport.exe', 'ng com.intelisis.JReport.IntelisisJReport') --REQ 14790
    FROM EmpresaCFD WHERE Empresa = @Empresa

   IF @Reporteador = 'Jasper Reports' --BUG 17392
     SET @Jasper = 1
   IF @Reporteador = 'Report Builder' --BUG 17392
     SET @ReportBuilder = 1   
   IF @Reporteador = 'Reporteador Intelisis'--TASK 17532
     SET @ReporteIntelisis = 1

  SELECT @Ruta = RTRIM(LTRIM(ISNULL(Ruta,''))),
		 @RutaLogo = RTRIM(LTRIM(ISNULL(RutaLogo,'')))
    FROM EmpresaCFDJasperReports 
   WHERE Empresa = @Empresa AND Reporte = @Reporte
SELECT  @EnviarAlAfectar = EnviarAlAfectar FROM EmpresaCFD WHERE Empresa = @Empresa
  IF ISNULL(@Jasper,0) = 1 OR ISNULL(@ReportBuilder,0) = 1 OR ISNULL(@ReporteIntelisis,0) = 1--REQ 16770
  BEGIN

      IF @Jasper = 1 AND @ReportBuilder = 0 AND @ReporteIntelisis = 0
      BEGIN
		IF @Reporte IS NULL SELECT @OK = 71660, @OkRef = 'Falta Configurar Reporte Jasper'

        EXEC xpCFDFlexAlmacenarPDF @Empresa, @Modulo, @ModuloID, @AlmacenarPDF OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      
		IF @Ok IS NULL
        IF (@AlmacenarPDF = 'SI' and @EnviarAlAfectar =1) or @htaGenerarPDF ='SI'
        BEGIN

          SET @ArchivoXML = @RutaTemporal + '\' + @NomArch + 'Jasper.XML'    
          SET @ArchivoBMP = @RutaTemporal + '\' + @NomArch + '.BMP'    
          SET @Archivo = @Archivo + '.PDF'
        
          --REQ Q3069 CFDGT
          EXEC spCFDFlexJasperPDF @Empresa, @Modulo, @ModuloID, @ArchivoXML, @ArchivoBMP, @Reporte, @RutaDatosXML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

          --REQ 14790
	      IF @Nailgun = 0
            SET @Shell = @RutaJasper + ' ' + CHAR(34) + @ArchivoXML + CHAR(34) + ' ' + CHAR(34) + @Ruta + CHAR(34) + ' ' + CHAR(34) + @RutaLogo + CHAR(34) + ' ' + CHAR(34) + @ArchivoBMP + CHAR(34) + ' " " ' + CHAR(34) + @RutaDatosXML + CHAR(34) + ' ' + CHAR(34) + @Archivo + CHAR(34)+ ' ' + CHAR(34) + @RutaJasper + CHAR(34)
	      ELSE
	        SET @Shell = @RutaNG + ' ' + CHAR(34) + @ArchivoXML + CHAR(34) + ' ' + CHAR(34) + @Ruta + CHAR(34) + ' ' + CHAR(34) + @RutaLogo + CHAR(34) + ' ' + CHAR(34) + @ArchivoBMP + CHAR(34) + ' " " ' + CHAR(34) + @RutaDatosXML + CHAR(34) + ' ' + CHAR(34) + @Archivo + CHAR(34) + ' ' + CHAR(34) + @RutaJasper + CHAR(34)
        
          INSERT @Datos
          EXEC xp_cmdshell @Shell
        

          IF EXISTS(SELECT Datos FROM @Datos WHERE Datos IS NOT NULL)
          BEGIN
            SELECT @Ok = 71660
            SELECT @OkRef = (SELECT Top 1 Datos FROM @Datos WHERE Datos IS NOT NULL)
          END
    	  
	      IF @Shell IS NULL
          BEGIN
            SELECT @Ok = 71660
            SELECT @OkRef = (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok)
          END
        END
      END
      
      IF @ReportBuilder = 1 AND @Jasper = 0 AND @ReporteIntelisis = 0--REQ 16770
      BEGIN
       IF (@AlmacenarPDF = 'SI' and  @EnviarAlAfectar =1) or @htaGenerarPDF ='SI'
        BEGIN
		  IF ISNULL(@RutaReportBuilder,'') <> ''
		  BEGIN
		    SET @RutaLog = LEFT(@RutaReportBuilder,LEN(@RutaReportBuilder)-4) + '_Log.txt'
			EXEC spVerificarArchivo @RutaLog, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
			IF ISNULL(@Existe,0) = 1
			  EXEC spEliminarArchivo @RutaLog, @Ok OUTPUT, @OkRef OUTPUT
		  END
		  UPDATE CFD SET Documento = '<?xml version="1.0" encoding="UTF-8"?>'+convert(varchar(max),Documento) WHERE Modulo = @Modulo AND ModuloID = @ModuloID 
          SELECT @RutaReportBuilder = '''"'+@RutaReportBuilder+'" ' + CONVERT(VarChar,@ModuloID) + ' /EnSilencio '+LTRIM(RTRIM(@Modulo))+' XMLPDF '+''''      
          SET @Shell = 'EXEC xp_cmdshell ' + @RutaReportBuilder+' , no_output'
          INSERT @Datos    
          EXEC(@Shell)
		  IF ISNULL(@RutaLog,'') <> ''
		  BEGIN
			EXEC spVerificarArchivo @RutaLog, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
			IF ISNULL(@Existe,0) = 1
			BEGIN
			  SELECT @Ok = 71661
              SELECT @OkRef = 'Error en origen de datos: Revisar archivo' + @RutaLog
			END
		  END
          IF EXISTS(SELECT * FROM CFDReportBuilderLog WHERE Modulo = LTRIM(RTRIM(@Modulo)) AND ModuloID = @ModuloID)--Task 16770
          BEGIN
            SELECT @Ok = 71661
            SELECT @OkRef = (SELECT TOP 1 Mensaje FROM CFDReportBuilderLog WHERE Modulo = LTRIM(RTRIM(@Modulo)) AND ModuloID = @ModuloID)
          END
        END
      END   
      IF @ReporteIntelisis = 1 AND @Jasper = 0 AND @ReportBuilder = 0 --REQ 16770
      BEGIN
        SET @ID=@ID
      END
	  --POS
      IF @OK IS NULL AND (@ReporteIntelisis = 1 OR @ReportBuilder = 1)
        EXEC xpPOSReporteReporteador @Empresa, @Modulo, @ModuloID, @ArchivoXML ,@NomArch 

      IF @OK IS NULL AND @Jasper = 1
        EXEC xpPOSReporteJasper @Empresa, @Modulo, @ModuloID, @ArchivoXML ,@NomArch 		   

      EXEC xpEscucharSQLDespues @ID
  END
  ELSE
  BEGIN
    EXEC xpEscucharSQLDespues @ID
    SET @CambiarEstatus = 0
	UPDATE IntelisisService SET Estatus = 'SINPROCESAR' WHERE ID = @ID
  END

END
GO

/**************** fnISIntelisisAutorizacionParsearMensaje ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnISIntelisisAutorizacionParsearMensaje') DROP FUNCTION fnISIntelisisAutorizacionParsearMensaje
GO
CREATE FUNCTION fnISIntelisisAutorizacionParsearMensaje 
	(
	@MensajeRespuesta			varchar(max), 
	@Empresa					varchar(5),
	@Modulo						varchar(5),
	@Movimiento					varchar(50),
	@Estatus					varchar(15),
	@Situacion					varchar(50),
	@SituacionSiguiente			varchar(50),
	@Usuario					varchar(10)
	)
	
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(max)

  SET @MensajeRespuesta = REPLACE(@MensajeRespuesta,'<Empresa>',ISNULL(@Empresa,''))
  SET @MensajeRespuesta = REPLACE(@MensajeRespuesta,'<Modulo>',ISNULL(@Modulo,''))  
  SET @MensajeRespuesta = REPLACE(@MensajeRespuesta,'<Movimiento>',ISNULL(@Movimiento,''))    
  SET @MensajeRespuesta = REPLACE(@MensajeRespuesta,'<Estatus>',ISNULL(@Estatus,''))      
  SET @MensajeRespuesta = REPLACE(@MensajeRespuesta,'<Situacion>',ISNULL(@Situacion,''))        
  SET @MensajeRespuesta = REPLACE(@MensajeRespuesta,'<SituacionSiguiente>',ISNULL(@SituacionSiguiente,''))          
  SET @MensajeRespuesta = REPLACE(@MensajeRespuesta,'<Usuario>',ISNULL(@Usuario,''))            

  SET @Resultado = ISNULL(@MensajeRespuesta,'')
          
  RETURN (ISNULL(@Resultado,''))
END
GO

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ANSI_PADDING OFF
GO
/**************** spIntelisisServiceProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesar') and type = 'P') drop procedure dbo.spIntelisisServiceProcesar
GO             
CREATE PROCEDURE spIntelisisServiceProcesar
				@ID	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sistema		varchar(100),
    @Contenido		varchar(100),
    @Referencia		varchar(100),
    @SubReferencia  varchar(100),
    @Version		float,
    @Estatus		varchar(15),
    @EstatusNuevo	varchar(15),
    @Solicitud		varchar(max),
    @iSolicitud		int,
    @Resultado		varchar(max),
    @Ok				int,
    @OkRef			varchar(255),
    @CambiarEstatus	bit,----MEJORA5066    --REQ25014
    @EsContParalela	bit

  SELECT @EsContParalela = 0
   
  SELECT @Ok = NULL, @OkRef = NULL, @CambiarEstatus = 1 ----MEJORA5066
  SELECT @Sistema = Sistema, @Contenido = Contenido, @Referencia = Referencia, @SubReferencia = SubReferencia, @Version = Version, @Estatus = Estatus, @Solicitud = Solicitud 
    FROM IntelisisService
   WHERE ID = @ID
--REQ12534 Factory   
  IF @Estatus IN('SINPROCESAR')
  BEGIN
    IF @Sistema IN('Intelisis', 'SDK','Infor')
    BEGIN
                      IF @Contenido = 'Solicitud' 
      BEGIN
     
        EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud
        BEGIN TRY --Bug 23374
            IF @Referencia = 'Intelisis.CXP.InsertarMov.CXP_F' EXEC spISIntelisisCXPInsertarMovCXP_F @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE        
            IF @Referencia = 'IntelisisCRM.CRM' EXEC spISIntelisisCRM @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT ELSE --REQ 13389
            IF @Referencia = 'SDK.ReportePDF' EXEC spISSDKReportePDF @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT ELSE
			IF @Referencia = 'CRM.CRM' EXEC spISCRM @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT            
            
			--REQ12534 Factory
            EXEC spIntelisisServiceProcesarInfor @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia,@SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT             
            EXEC spIntelisisServiceProcesarAutorizacion @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia,@SubReferencia, @CambiarEstatus, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT             
            EXEC spIntelisisServiceProcesarNotificacion @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia,@SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT            --REQ16092
            EXEC spIntelisisServiceProcesarOportunidad @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia,@SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT                    
            EXEC spIntelisisServiceProcesareDocIn @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia,@SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 
            EXEC spIntelisisServiceEmida @ID, @iSolicitud, @Referencia, @SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT -- REQ12336
	        EXEC spIntelisisServiceProcesarWMS @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia, @SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT --REQ12615 WMS    	
            EXEC spIntelisisServiceProcesareCommerce @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia,@SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT -- REQ13987            
            EXEC spIntelisisServiceProcesarPOS @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia,@SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT --REQ 13393 POS            
            EXEC spIntelisisServiceProcesarMovil @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia,@SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT --REQ 13393 POS    	
	        EXEC xpIntelisisServiceProcesar @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia,@SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT                  
      IF LEFT(LTRIM(RTRIM(ISNULL(@Referencia,''))),22) = 'Intelisis.Distribucion' EXEC spIntelisisServiceProcesarDistribucion @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia,@SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
            --EXEC spIntelisisServiceProcesarContParalela @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia, @SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @EsContParalela OUTPUT --REQ25014
			EXEC spIntelisisServicePedidosMovilCobranzaLigera @Sistema, @ID, @iSolicitud, @Solicitud, @Version, @Referencia,@SubReferencia, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT --REQ 13393 POS

        END TRY --Bug 23374--
        BEGIN CATCH
          IF @Ok IS NOT NULL
            SET @Ok = @Ok
        END CATCH

        EXEC sp_xml_removedocument @iSolicitud        
        

        IF @CambiarEstatus = 1
        BEGIN
          IF @Ok IS NULL OR @Ok IN (80030)
            SELECT @EstatusNuevo = 'PROCESADO' 
          ELSE 
            SELECT @EstatusNuevo = 'ERROR'  
            
          --REQ25014
          IF @EsContParalela = 0
            SELECT @OkRef = ISNULL(Descripcion,'')+ @OkRef  
              FROM MensajeLista   WHERE   Mensaje = @Ok       
        
          UPDATE IntelisisService
             SET Estatus = @EstatusNuevo,
                 Resultado = @Resultado,
                 Ok = @Ok,
                 OkRef = @OkRef
           WHERE ID = @ID
        END
      END
    END
  END
  RETURN
END
GO

--BUG22851
/**************** spIntelisisService ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisService') and type = 'P') drop procedure dbo.spIntelisisService
GO             
CREATE PROCEDURE spIntelisisService
			@Usuario			varchar(10),
			@Contrasena			varchar(32),
			@Solicitud			varchar(max),			
			@Resultado			varchar(max)	= NULL	OUTPUT,
		  	@Ok					int				= NULL  OUTPUT,
		  	@OkRef				varchar(255)	= NULL  OUTPUT,		  
			@Procesar			bit				= 1,
			@EliminarProcesado	bit				= 1,
			@ID					int				= NULL  OUTPUT,
			@WMS				bit				= 0 --BUG 14724
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @iSolicitud						int,
    @Contenido						varchar(100),
    @Sistema						varchar(100),
    @Referencia						varchar(100),
    @SubReferencia					varchar(100),
	@Descripcion	                varchar(255), --PGC23102014
    @Version						float,
    @ISDiasResguardoSolicitud		int,
    @FechaDepuracion				datetime
    
  SELECT @ISDiasResguardoSolicitud = ISDiasResguardoSolicitud FROM Version

  -- REQ 17083
  IF NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario)
  BEGIN
    SELECT @Ok = 71020, @OkRef = @Usuario	
  END
  
  IF EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND Contrasena  IN(@Contrasena,dbo.fnPassword(UPPER(RTRIM(@Contrasena))))) --TASK 17083
  BEGIN
    EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud
    SELECT @Sistema = ISNULL(Sistema,''), @Contenido = ISNULL(Contenido,''), @Referencia = ISNULL(Referencia,''), @SubReferencia = ISNULL(SubReferencia,0), @Version = Version --PGC23102014
      FROM OPENXML (@iSolicitud, '/Intelisis',1) 
      WITH (Sistema varchar(100), Contenido varchar(100), Referencia varchar(100), SubReferencia varchar(100), Version float) 
    EXEC sp_xml_removedocument @iSolicitud

    INSERT IntelisisService (
            Sistema,  Contenido,  Referencia,  SubReferencia,  Version,  Usuario,  Solicitud)
    VALUES (@Sistema, @Contenido, @Referencia, @SubReferencia, @Version, @Usuario, @Solicitud)
    SELECT @ID = SCOPE_IDENTITY()
  
    IF @Procesar = 1
    BEGIN
      EXEC spIntelisisServiceProcesar @ID
      SELECT @Resultado = Resultado, @Ok = Ok, @OkRef = OkRef
        FROM IntelisisService
       WHERE ID = @ID
      IF @EliminarProcesado = 1 
        DELETE IntelisisService
         WHERE ID = @ID     
    END
    
    --Elimina los registros PROCESADOS anteriores a una fecha determinada para mantener la tabla pequeña.
    SELECT @FechaDepuracion = dbo.fnFechaSinHora(DATEADD(DAY,0-(@ISDiasResguardoSolicitud + 1),GETDATE()))    
    DELETE FROM IntelisisService WHERE Estatus = 'PROCESADO' AND FechaEstatus <= @FechaDepuracion

  END ELSE IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND Contrasena  IN(@Contrasena,dbo.fnPassword(UPPER(RTRIM(@Contrasena))))) --TASK 17083
    SELECT @Ok = 60230, @OkRef = @Usuario
			
  IF @Ok IS NOT NULL AND @Ok IN (71020,60230)
  BEGIN    
	SELECT @Descripcion=Descripcion FROM MensajeLista WHERE Mensaje=@Ok    
	SELECT @Resultado='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@Referencia,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'"> </Resultado></Intelisis>' 	
  END
	  
  RETURN
END
GO

--REQ25014
-- ********************* spWebService *********************
if exists(select * from sysobjects where name = 'spWebService' and type = 'p') drop proc spWebService
GO
CREATE PROC spWebService
			@Solicitud		varchar(max),
			@EnSilencio		bit			 = 0,
			@Resultado		varchar(max) = NULL OUTPUT,
			@Ok				int			 = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  SET ANSI_NULL_DFLT_ON ON 
  SET ANSI_NULLS ON 
  SET ANSI_PADDING ON 
  SET ANSI_WARNINGS ON 
  SET QUOTED_IDENTIFIER ON 
  SET CONCAT_NULL_YIELDS_NULL ON

  DECLARE @Usuario			varchar(10),
		  @Contrasena		varchar(32),
		  @ID				int,
		  @iSolicitud		int  

  EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud

    SELECT @Usuario = Usuario, @Contrasena = Contrasena
      FROM OPENXML (@iSolicitud, '/Intelisis',1) 
      WITH (Usuario varchar(10), Contrasena varchar(32) )

  EXEC sp_xml_removedocument @iSolicitud
  
  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado = @Resultado OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Procesar = 1, @EliminarProcesado = 0, @ID = @ID OUTPUT

  --SELECT @Resultado = REPLACE(@Resultado, '<?xml version="1.0" encoding="iso-8859-1"?>', '')
  
  IF @Ok IS NOT NULL AND @Resultado IS NULL
    SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Ok="' + CONVERT(varchar(max), @Ok) + '" OkRef="' + ISNULL(@OkRef, '') + '"> <Resultado></Resultado></Intelisis>'
  
  IF @EnSilencio = 0
    SELECT @Resultado
  RETURN
END
GO

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ANSI_PADDING OFF
GO
/**************** spIntelisisServicePedidosMovilCobranzaLigera ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServicePedidosMovilCobranzaLigera') and type = 'P') drop procedure dbo.spIntelisisServicePedidosMovilCobranzaLigera
GO
CREATE PROCEDURE spIntelisisServicePedidosMovilCobranzaLigera
			@Sistema       varchar(100),
			@ID			   int,
			@iSolicitud	   int,
			@Solicitud     varchar(max),
			@Version	   float,
			@Referencia    varchar(100),
			@SubReferencia varchar(100),
			@Resultado     varchar(max)  OUTPUT,
			@Ok			   int			 OUTPUT,
			@OkRef		   varchar(255)	 OUTPUT
--//WITH ENCRYPTION	
AS 
BEGIN
	-- Consultamos servicios Intelisis Movil
	IF @Referencia = 'Intelisis.Movil.Login.Listado'            EXEC spISIntelisisMovilLoginListado            @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.MovilUsuarioCfg.Listado'	EXEC spISIntelisisMovilMovilUsuarioCfgListado  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Art.Listado'              EXEC spISIntelisisMovilArtListado              @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Cte.Listado'	            EXEC spISIntelisisMovilCteListado	           @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE	
	IF @Referencia = 'Intelisis.Movil.Metadato.Listado'	        EXEC spISIntelisisMovilMetadatoListado	       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Cte.Alta'					EXEC spISIntelisisMovilCteAlta		           @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.CampanaD.Actualizar'		EXEC spISIntelisisMovilCampanaDActualizar	   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Venta.Alta'				EXEC spISIntelisisMovilVentaAlta			   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Cte.Actualizar'			EXEC spISIntelisisMovilCteActualizar		   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Venta.Consulta'			EXEC spISIntelisisMovilVentaConsulta		   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Venta.Template'			EXEC spISIntelisisMovilVentaTemplate		   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.ArtCat.Listado'           EXEC spISIntelisisMovilArtCatListado           @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.ArtGrupo.Listado'	        EXEC spISIntelisisMovilArtGrupoListado	       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.ArtFam.Listado'	        EXEC spISIntelisisMovilArtFamListado	       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.ArtLinea.Listado'	        EXEC spISIntelisisMovilArtLineaListado	       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.ArtJuego.Listado'	        EXEC spISIntelisisMovilArtJuegoListado	       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.ArtOpcion.Listado'	    EXEC spISIntelisisMovilArtOpcionListado	       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Alm.Listado'	            EXEC spISIntelisisMovilAlmListado	           @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.ArtSubDisponible.Listado'	EXEC spISIntelisisMovilArtSubDisponibleListado @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.CteEnviarA.Listado'	    EXEC spISIntelisisMovilCteEnviarAListado	   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Visita.Listado'	        EXEC spISIntelisisMovilVisitaListado	       @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Clientes.Listado'			EXEC spISIntelisisMovilClientesListado		   @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Cobro.Alta'   			EXEC spISIntelisisMovilCobroAlta               @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 
	-- Para cargar plugin de Agenda
    IF @Referencia = 'Intelisis.Movil.Agenda.Actualizar'		EXEC spISIntelisisMovilAgendaActualizar		@ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
    IF @Referencia = 'Intelisis.Movil.Agenda.Listado'			EXEC spISIntelisisMovilAgendaListado		    @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 	
	-- Adecuacion en Producto 25/07/2016 SP's Pendientes y Pendientes Envio.
	IF @Referencia = 'Intelisis.Movil.Cte.Pendientes'           EXEC spISIntelisisMovilCtePendientes           @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
	IF @Referencia = 'Intelisis.Movil.Cte.PendientesEnvio'      EXEC spISIntelisisMovilCxCPendientesEnvio      @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
		
  RETURN
END
GO

SET DATEFIRST 7
SET ANSI_NULLS ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
GO
/**************** spIntelisisPHPWebService ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisPHPWebService') and type = 'P') drop procedure dbo.spIntelisisPHPWebService
GO 
CREATE PROCEDURE [dbo].[spIntelisisPHPWebService]
  @Solicitud			varchar(max),			
  @Procesar				bit		= 1,
  @EliminarProcesado	bit		= 1
--//WITH ENCRYPTION
AS BEGIN
SET NOCOUNT ON
  
  DECLARE
  @Usuario			varchar(10),
  @Contrasena		varchar(32),
  @Resultado		varchar(max),
  @Ok				int,
  @OkRef			varchar(255),
  @ID				int,
  @iSolicitud		int,
  
  @Sistema			varchar(100),
  @Contenido		varchar(100),
  @Referencia		varchar(100),
  @SubReferencia	varchar(100),
  @Version			VARCHAR(100),
  @Texto			varchar(max)

  BEGIN TRY
	EXEC  sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud
  END TRY
  
  BEGIN CATCH
	SET @Solicitud = '<?xml version="1.0" encoding="windows-1252"?>' +
					 CAST(dbo.JSON2XML(@Solicitud).query('Root/Intelisis') AS VARCHAR(MAX))
	EXEC  sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud
  END CATCH

  BEGIN TRY
	  SELECT @Sistema		= Sistema,
			 @Contenido		= 'Resultado',
			 @Referencia    = Referencia,
			 @SubReferencia = SubReferencia,
			 @Version		= Version
		FROM OPENXML (@iSolicitud,'/Intelisis')
		WITH (Sistema varchar(100), Referencia varchar(100), SubReferencia varchar(100), Version varchar(100))

	  SELECT
		@Usuario    = Usuario,
		@Contrasena = Contrasena
		FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud')
		WITH (Usuario varchar(10), Contrasena varchar(32))

	  IF NOT EXISTS(SELECT Usuario FROM Usuario WHERE Usuario = @Usuario AND (Contrasena = @Contrasena OR Contrasena = dbo.fnPassword(UPPER(RTRIM(@Contrasena)))))
		SELECT @Ok = 3, @OkRef = ISNULL(@Usuario, 'N/A')

	  IF @Ok IS NULL
		EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @Procesar, @EliminarProcesado, @ID OUTPUT

	  IF @Ok IS NOT NULL
	  BEGIN
		IF @OkRef IS NULL
			SET @OkRef = (SELECT dbo.fneDocXmlAUtf8(Descripcion,0,1) + ' - ' + @Usuario FROM MensajeLista WHERE Mensaje = @Ok)
	  END
	  
	  EXEC sp_xml_removedocument @iSolicitud
  END TRY
  
  BEGIN CATCH
	SELECT ERROR_MESSAGE()
  END CATCH
  
  BEGIN TRY
	  -- Generamos XML de Salida
	  SET ANSI_NULLS ON
	  SET QUOTED_IDENTIFIER ON
	  SET ANSI_WARNINGS ON
	  SET ANSI_PADDING ON
	  
	  DECLARE @XMLHead as XML, @XMLResult as XML	
	  SET @Resultado = REPLACE(@Resultado, '"', '')
	  SET @XMLResult = CAST(@Resultado as XML)
	  SET @XMLHead = '<Intelisis/>'

	  SET @XMLHead.modify('insert attribute Sistema {sql:variable("@Sistema")} into /Intelisis[1]')
	  SET @XMLHead.modify('insert attribute Contenido {sql:variable("@Contenido")} into /Intelisis[1]')
	  SET @XMLHead.modify('insert attribute Referencia {sql:variable("@Referencia")} into /Intelisis[1]')
	  SET @XMLHead.modify('insert attribute SubReferencia {sql:variable("@SubReferencia")} into /Intelisis[1]')
	  SET @XMLHead.modify('insert attribute Version {sql:variable("@Version")} into /Intelisis[1]')

	  SET @XMLHead.modify('insert <Resultado/> as first into (/Intelisis)[1]');
	  SET @XMLHead.modify('insert attribute IntelisisServiceID {sql:variable("@ID")} into (/Intelisis/Resultado)[1]')
	  SET @XMLHead.modify('insert attribute Ok {sql:variable("@Ok")} into (/Intelisis/Resultado)[1]')
	  SET @XMLHead.modify('insert attribute OkRef {sql:variable("@OkRef")} into (/Intelisis/Resultado)[1]')

	  SET @XMLHead.modify('insert sql:variable("@XMLResult") as first into (/Intelisis/Resultado)[1]')
	  SET @Resultado = CAST(@XMLHead AS VARCHAR(MAX))

	  UPDATE IntelisisService
		 SET Resultado = @Resultado
	   WHERE ID = @ID
	  
	  SELECT @Referencia = REPLACE(REPLACE(@Referencia, 'Intelisis.', ''), '.', '')
		 SET @Resultado = dbo.XML2JSON(CAST(@Resultado as XML))
	  
	  SELECT @Resultado Resultado

	-- IMPRIMIMOS EL RESULTADO PARA VERLO DESDE EL MANAGEMENT --
	  DECLARE @iPrint int
	  SET @iPrint = 0
	  
	  WHILE @iPrint <= LEN(@Resultado)
	   BEGIN
		PRINT SUBSTRING(@Resultado, @iPrint, 4000)
		SET @iPrint = @iPrint + 4000
	   END

	  SET ANSI_NULLS OFF
	  SET QUOTED_IDENTIFIER OFF
	  SET ANSI_WARNINGS OFF
	  SET ANSI_PADDING OFF
	  SET NOCOUNT OFF
	  
  END TRY
  
  BEGIN CATCH
	SELECT ERROR_MESSAGE()
  END CATCH
  
  RETURN
END
GO