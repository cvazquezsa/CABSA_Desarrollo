/* *********************************************     FUNCIONES     **********************************************/
/******************************* fnTraducirParseo *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTraducirParseo')
DROP FUNCTION fnTraducirParseo
GO
CREATE FUNCTION fnTraducirParseo
  (
  @Modulo		varchar(5),
  @Mov			varchar(20),
  @Exportacion		varchar(50),
  @IDSeccion		int,
  @ValorOriginal	varchar(100)			
  )
RETURNS varchar(100)
AS

BEGIN
  DECLARE	@Resultado		varchar(100)

  SELECT @Resultado = ValorDestino 
    FROM DiccionarioParseoD 
   WHERE RTRIM(Exportacion) = RTRIM(@Exportacion) 
     AND IDSeccion = @IDSeccion 
     AND ValorOriginal = @ValorOriginal

  SET @Resultado = ISNULL(@Resultado,@ValorOriginal)
    
  RETURN RTRIM(LTRIM(@Resultado))	
END
GO


/******************************* fnFechaObtenerNumeroPosiciones *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFechaObtenerNumeroPosiciones')
DROP FUNCTION fnFechaObtenerNumeroPosiciones
GO

CREATE FUNCTION fnFechaObtenerNumeroPosiciones
  (
  @FormatoFecha		varchar(50)
  )
RETURNS @Resultado TABLE 
	(
	Letra		varchar(50),
	Cantidad	int
	)
AS

BEGIN
  DECLARE	@Contador		int,
			@Ultimoa		int,
			@Ultimom		int,
			@Ultimod		int,
			@Ultimoh		int,
			@Ultimon		int,
			@Ultimos		int,
			@Longitud		int,
			@Caracter		char(1),
			@Cadena			varchar(50)

  SELECT
    @Contador = 1, 
    @Longitud = LEN(@FormatoFecha), 
    @Ultimoa = 0, 
    @Ultimom = 0, 
    @Ultimod = 0, 
    @Ultimoh = 0, 
    @Ultimon = 0, 
    @Ultimos = 0, 
    @Caracter = NULL, 
    @Cadena = ''

  WHILE @Contador <= @Longitud
  BEGIN

    SET @Caracter = SUBSTRING(UPPER(@FormatoFecha),@Contador,1)

    IF @Caracter = 'A' 
    BEGIN
      IF (@Contador - @Ultimoa = 1) OR (@Ultimoa = 0) 
      IF NOT EXISTS(SELECT * FROM @Resultado WHERE Letra = 'A')
        INSERT @Resultado (Letra, Cantidad) VALUES ('A',1)
      ELSE
        UPDATE @Resultado SET Cantidad = Cantidad + 1 WHERE Letra = 'A'
      SET @Ultimoa = @Contador
    END

    IF @Caracter = 'M' 
    BEGIN
      IF (@Contador - @Ultimom = 1) OR (@Ultimom = 0) 
      IF NOT EXISTS(SELECT * FROM @Resultado WHERE Letra = 'M')
        INSERT @Resultado (Letra, Cantidad) VALUES ('M',1)
      ELSE
        UPDATE @Resultado SET Cantidad = Cantidad + 1 WHERE Letra = 'M'
      SET @Ultimom = @Contador
    END

    IF @Caracter = 'D' 
    BEGIN
      IF (@Contador - @Ultimod = 1) OR (@Ultimod = 0) 
      IF NOT EXISTS(SELECT * FROM @Resultado WHERE Letra = 'D')
        INSERT @Resultado (Letra, Cantidad) VALUES ('D',1)
      ELSE
        UPDATE @Resultado SET Cantidad = Cantidad + 1 WHERE Letra = 'D'
      SET @Ultimod = @Contador
    END

    IF @Caracter = 'H' 
    BEGIN
      IF (@Contador - @Ultimoh = 1) OR (@Ultimoh = 0) 
      IF NOT EXISTS(SELECT * FROM @Resultado WHERE Letra = 'H')
        INSERT @Resultado (Letra, Cantidad) VALUES ('H',1)
      ELSE
        UPDATE @Resultado SET Cantidad = Cantidad + 1 WHERE Letra = 'H'
      SET @Ultimoh = @Contador
    END

    IF @Caracter = 'N' 
    BEGIN
      IF (@Contador - @Ultimon = 1) OR (@Ultimon = 0) 
      IF NOT EXISTS(SELECT * FROM @Resultado WHERE Letra = 'N')
        INSERT @Resultado (Letra, Cantidad) VALUES ('N',1)
      ELSE
        UPDATE @Resultado SET Cantidad = Cantidad + 1 WHERE Letra = 'N'
      SET @Ultimon = @Contador
    END

    IF @Caracter = 'S' 
    BEGIN
      IF (@Contador - @Ultimos = 1) OR (@Ultimos = 0) 
      IF NOT EXISTS(SELECT * FROM @Resultado WHERE Letra = 'S')
        INSERT @Resultado (Letra, Cantidad) VALUES ('S',1)
      ELSE
        UPDATE @Resultado SET Cantidad = Cantidad + 1 WHERE Letra = 'S'
      SET @Ultimos = @Contador
    END

    SET @Contador = @Contador + 1
  END

  RETURN
END
GO

/******************************* fnFormatoFecha *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormatoFecha')
DROP FUNCTION fnFormatoFecha
GO

CREATE FUNCTION fnFormatoFecha
  (
  @Fecha				datetime,
  @FormatoFecha				varchar(50)
  )

RETURNS varchar(50)
AS

BEGIN
  DECLARE	@FormatoFechaR		varchar(50),
			@Anyo				varchar(50),
			@Mes				varchar(50),
			@Dia				varchar(50),
			@Hora				varchar(50),
			@Minuto				varchar(50),
			@Segundo			varchar(50),
			@AnyoCantidad		int,
			@MesCantidad		int,
			@DiaCantidad		int,
			@HoraCantidad		int,
			@MinutoCantidad		int,
			@SegundoCantidad	int

  DECLARE @Resultado	TABLE
	(
	Letra		varchar(50),
	Cantidad	int
	)

  IF NULLIF(RTRIM(@FormatoFecha),'') IS NULL RETURN CONVERT(varchar,@Fecha,126)

  SELECT @Anyo = '', @Mes = '', @Dia = '', @Hora = '', @Minuto = '', @Segundo = ''

  SET @FormatoFecha = UPPER(@FormatoFecha)

  INSERT @Resultado (Letra, Cantidad) SELECT Letra, Cantidad FROM fnFechaObtenerNumeroPosiciones(@FormatoFecha)

  SELECT @AnyoCantidad    = Cantidad FROM @Resultado WHERE Letra = 'A'
  SELECT @MesCantidad     = Cantidad FROM @Resultado WHERE Letra = 'M'
  SELECT @DiaCantidad     = Cantidad FROM @Resultado WHERE Letra = 'D'
  SELECT @HoraCantidad    = Cantidad FROM @Resultado WHERE Letra = 'H'
  SELECT @MinutoCantidad  = Cantidad FROM @Resultado WHERE Letra = 'N'
  SELECT @SegundoCantidad = Cantidad FROM @Resultado WHERE Letra = 'S'

  SELECT @AnyoCantidad    = ISNULL(@AnyoCantidad,0)
  SELECT @MesCantidad     = ISNULL(@MesCantidad,0) 
  SELECT @DiaCantidad     = ISNULL(@DiaCantidad,0) 
  SELECT @HoraCantidad    = ISNULL(@HoraCantidad,0) 
  SELECT @MinutoCantidad  = ISNULL(@MInutoCantidad,0) 
  SELECT @SegundoCantidad = ISNULL(@SegundoCantidad,0)

  SET @Anyo    = ISNULL(RIGHT(RTRIM(CONVERT(varchar,DATEPART(year,@Fecha))),@AnyoCantidad),'')
  SET @Mes     = ISNULL(RIGHT('0000' + RTRIM(CONVERT(varchar,DATEPART(month,@Fecha))),@MesCantidad),'')
  SET @Dia     = ISNULL(RIGHT('0000' + RTRIM(CONVERT(varchar,DATEPART(day,@Fecha))),@DiaCantidad),'')
  SET @Hora    = ISNULL(RIGHT('0000' + RTRIM(CONVERT(varchar,DATEPART(hour,@Fecha))),@HoraCantidad),'')
  SET @Minuto  = ISNULL(RIGHT('0000' + RTRIM(CONVERT(varchar,DATEPART(minute,@Fecha))),@MinutoCantidad),'')
  SET @Segundo = ISNULL(RIGHT('0000' + RTRIM(CONVERT(varchar,DATEPART(second,@Fecha))),@SegundoCantidad),'')

  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('A',@AnyoCantidad),@Anyo) 
  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('M',@MesCantidad),@Mes) 
  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('D',@DiaCantidad),@Dia) 
  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('H',@HoraCantidad),@Hora) 
  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('N',@MinutoCantidad),@Minuto) 
  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('S',@SegundoCantidad),@Segundo) 

  SET @FormatoFechaR = @FormatoFecha

  Return @FormatoFechaR
END
GO

/******************************* fnObtenerTipoColumna *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnObtenerTipoColumna')
DROP FUNCTION fnObtenerTipoColumna
GO
CREATE FUNCTION fnObtenerTipoColumna
  (
  @Campo		varchar(100),
  @Objeto		varchar(100)
  )
RETURNS varchar(50)
AS

BEGIN
  DECLARE	@Resultado		varchar(50),
			@ID				int,
			@TipoCampo		int
  
  SELECT @ID = ID FROM SysObjects WHERE ID = OBJECT_ID('dbo.' + RTRIM(LTRIM(@Objeto))) AND type IN ('V')
  SELECT @TipoCampo = XType FROM SysColumns WHERE ID = @ID AND RTRIM(LTRIM([Name])) = RTRIM(LTRIM(@Campo)) 

  IF @TipoCampo = 34  SET @Resultado = 'image' ELSE
  IF @TipoCampo = 35  SET @Resultado = 'text' ELSE
  IF @TipoCampo = 36  SET @Resultado = 'uniqueidentifier' ELSE
  IF @TipoCampo = 48  SET @Resultado = 'tinyint' ELSE
  IF @TipoCampo = 52  SET @Resultado = 'smallint' ELSE
  IF @TipoCampo = 56  SET @Resultado = 'int' ELSE
  IF @TipoCampo = 58  SET @Resultado = 'smalldatetime' ELSE
  IF @TipoCampo = 59  SET @Resultado = 'real' ELSE
  IF @TipoCampo = 60  SET @Resultado = 'money' ELSE
  IF @TipoCampo = 61  SET @Resultado = 'datetime' ELSE
  IF @TipoCampo = 62  SET @Resultado = 'float' ELSE
  IF @TipoCampo = 98  SET @Resultado = 'sql_variant' ELSE
  IF @TipoCampo = 99  SET @Resultado = 'ntext' ELSE
  IF @TipoCampo = 104 SET @Resultado = 'bit' ELSE
  IF @TipoCampo = 106 SET @Resultado = 'decimal' ELSE
  IF @TipoCampo = 108 SET @Resultado = 'numeric' ELSE
  IF @TipoCampo = 122 SET @Resultado = 'smallmoney' ELSE
  IF @TipoCampo = 127 SET @Resultado = 'bigint' ELSE
  IF @TipoCampo = 165 SET @Resultado = 'varbinary' ELSE
  IF @TipoCampo = 167 SET @Resultado = 'varchar' ELSE
  IF @TipoCampo = 173 SET @Resultado = 'binary' ELSE
  IF @TipoCampo = 175 SET @Resultado = 'char' ELSE
  IF @TipoCampo = 189 SET @Resultado = 'timestamp' ELSE
  IF @TipoCampo = 231 SET @Resultado = 'nvarchar' ELSE
  IF @TipoCampo = 239 SET @Resultado = 'nchar' ELSE
  IF @TipoCampo = 241 SET @Resultado = 'xml'
  
  RETURN RTRIM(LTRIM(@Resultado))	
END
GO



/* ***********************************     PROCEDIMIENTOS ALMACENADOS     ************************************/
/******************************* spParsearTexto *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spParsearTexto') AND TYPE = 'P')
DROP PROCEDURE spParsearTexto
GO

CREATE PROCEDURE spParsearTexto
  (
  @Modulo			varchar(5),
  @Mov				varchar(20),
  @Exportacion			varchar(50),
  @IDSeccion			int,
  @Vista			varchar(50),
  @Texto			varchar(MAX) OUTPUT,
  @Ok				int		     OUTPUT,
  @OkRef			varchar(255) OUTPUT
  )
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
	@Largo				int,
	@Contador			int,
	@TextoRetorno			varchar(MAX),
	@Caracter			char(1),
	@Campo				varchar(100),
	@CampoTraducido			varchar(200),
	@Modo				int,
	@Traducir			bit,
	@Formato			varchar(50)
		
  SELECT @Largo = LEN(@Texto), @Contador = 1
  SELECT @TextoRetorno = Char(39)
  SELECT @Campo = '', @Modo = 0

  WHILE @Contador <= @Largo
  BEGIN
    SET @Caracter = SUBSTRING(@Texto,@Contador,1)
    IF @Caracter = '[' SET @Modo = 1 ELSE
    IF @Caracter = ']' SET @Modo = 2 ELSE
    IF ASCII(@Caracter) <= 31 AND @Modo NOT IN (1) SET @Modo = 3 ELSE
    IF ASCII(@Caracter) >= 32 AND @Caracter NOT IN ('[',']') AND @Modo NOT IN (1) SET @Modo = 4

    IF @Modo = 1 
    BEGIN
      SET @Campo = @Campo + @Caracter	
    END
	
    ELSE IF @Modo = 2 
    BEGIN

      SET @Campo = @Campo + @Caracter
      SET @CampoTraducido = NULL
	
      SELECT @CampoTraducido = RTRIM(CampoIntelisis), @Formato = ISNULL(Formato,''), @Traducir = ISNULL(Traducir,0) FROM TablaParseoD WHERE RTRIM(Exportacion) = RTRIM(@Exportacion) AND IDSeccion = @IDSeccion AND RTRIM(CampoXML) = RTRIM(@Campo)	

      SET @CampoTraducido = ISNULL(@CampoTraducido,@Campo)

      IF @CampoTraducido <> @Campo
      BEGIN
        IF dbo.fnObtenerTipoColumna(@CampoTraducido,@Vista) IN ('uniqueidentifier','tinyint','smallint','int','real','money','float','bit','decimal','numeric','smallmoney','bigint') AND @CampoTraducido <> @Campo SET @CampoTraducido = 'ISNULL(RTRIM(LTRIM(CONVERT(varchar,' + RTRIM(@CampoTraducido) + '))),' + CHAR(39) + CHAR(39) + ')' ELSE
        IF dbo.fnObtenerTipoColumna(@CampoTraducido,@Vista) IN ('smalldatetime','datetime') AND @CampoTraducido <> @Campo SET @CampoTraducido = 'ISNULL(RTRIM(LTRIM(dbo.fnFormatoFecha(' + RTRIM(@CampoTraducido) + ',' + CHAR(39) + RTRIM(@Formato) + CHAR(39) + '))),' + CHAR(39) + CHAR(39) + ')' ELSE
        IF dbo.fnObtenerTipoColumna(@CampoTraducido,@Vista) IN ('varbinary','binary') AND @CampoTraducido <> @Campo SET @CampoTraducido = 'ISNULL(RTRIM(LTRIM(CONVERT(varchar,' + RTRIM(@CampoTraducido) + '))),' + CHAR(39) + CHAR(39) + ')' ELSE
        IF dbo.fnObtenerTipoColumna(@CampoTraducido,@Vista) IN ('varchar','char','nvarchar','nchar') AND @CampoTraducido <> @Campo SET @CampoTraducido = 'ISNULL(RTRIM(' + RTRIM(@CampoTraducido) + '),' + CHAR(39) + CHAR(39) + ')'

        IF @Traducir = 1 SET @CampoTraducido = CHAR(39) + ' +  dbo.fnTraducirParseo(' + CHAR(39) + RTRIM(@Modulo) + CHAR(39) + ',' + CHAR(39) + RTRIM(@Mov) + CHAR(39) + ',' + CHAR(39) + RTRIM(@Exportacion) + CHAR(39) + ',' + RTRIM(CONVERT(varchar,@IDSeccion)) + ',' + @CampoTraducido +  ') + ' + CHAR(39) ELSE
	IF @Traducir = 0 SET @CampoTraducido = CHAR(39) + ' + ' + @CampoTraducido +  ' + ' + CHAR(39) 

      END
      SET @Campo = ''
      SET @TextoRetorno = @TextoRetorno + @CampoTraducido
    END
	
    ELSE IF @Modo = 3
    BEGIN

      SET @CampoTraducido = CHAR(39) + ' + CHAR(' + CONVERT(varchar,ASCII(@Caracter)) + ') + ' + CHAR(39)
      SET @TextoRetorno = @TextoRetorno + @CampoTraducido
    END

    ELSE IF @Modo = 4
    BEGIN

      SET @TextoRetorno = @TextoRetorno + @Caracter
    END

    SET @Contador = @Contador + 1	    
  END
	
  SET @TextoRetorno = @TextoRetorno + CHAR(39)
  SET @Texto = @TextoRetorno
END
GO


/******************************* spMovParsearSeccion *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spMovParsearSeccion') AND TYPE = 'P')
DROP PROCEDURE spMovParsearSeccion
GO
CREATE PROCEDURE spMovParsearSeccion
  (
  @Estacion			int,
  @Modulo			varchar(5),			
  @Mov				varchar(20),
  @Exportacion			varchar(50),
  @IDSeccion			int,
  @Tabla			varchar(50),
  @ID				int,
  @Texto			varchar(MAX),
  @SubSeccionDe			varchar(50),
  @Cierre			bit,
  @Select			varchar(MAX) OUTPUT,
  @OrdenSeccion			int OUTPUT,
  @Ok				int OUTPUT,
  @OkRef			varchar(255) OUTPUT
  )
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @OrdenSeccionTexto	varchar(3)

  IF @SubSeccionDe IS NULL SET @OrdenSeccion = @OrdenSeccion + 1

  SET @OrdenSeccionTexto = REPLICATE('0',3-LEN(RTRIM(LTRIM(CONVERT(varchar,@OrdenSeccion))))) + RTRIM(LTRIM(CONVERT(varchar,@OrdenSeccion)))
  
  EXEC spParsearTexto @Modulo, @Mov, @Exportacion, @IDSeccion, @Tabla, @Texto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
  SET @Select = 
      'INSERT MovExportacionDatos (Estacion, Modulo, ModuloID, OrdenExportacion, Documento) SELECT ' + 
      RTRIM(LTRIM(CONVERT(varchar,@Estacion))) + ', ' + CHAR(39) + RTRIM(@Modulo) + CHAR(39) + 
      ', ' + RTRIM(LTRIM(CONVERT(varchar,@ID))) + ', ' +  
        CASE ISNULL(@Cierre,0) 
          WHEN 0 THEN CHAR(39) + @OrdenSeccionTexto + CHAR(39) + ' + OrdenExportacion' 
          WHEN 1 THEN ' + RTRIM(' + CHAR(39) + @OrdenSeccionTexto + CHAR(39) + ' + OrdenExportacion) + REPLICATE(CHAR(255),255 - LEN(RTRIM(LTRIM(' + CHAR(39) + @OrdenSeccionTexto + CHAR(39) + ' + OrdenExportacion))))' 
       END + 
      ', ' + @Texto + ' FROM ' + RTRIM(@Tabla) + ' WHERE ID = ' + RTRIM(CONVERT(varchar,@ID)) 

END
GO


/******************************* spLimpiarXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spLimpiarXML') AND TYPE = 'P')
DROP PROCEDURE spLimpiarXML
GO
CREATE PROCEDURE spLimpiarXML
  (
  @Exportacion varchar(50),
  @Modulo varchar(15),
  @ID int
  )
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE 
    @TagLimpiar			varchar(MAX),
    @DocumentoTexto		varchar(MAX),
    @Cont			int,
    @RID			int

  SET @RID = 1

  SELECT @Cont = COUNT(RID) 
    FROM TablaParseoD 
   WHERE Exportacion = @Exportacion
	
  WHILE @RID <= @Cont
  BEGIN

    SELECT @DocumentoTexto = DocumentoTexto 
      FROM MovXML 
     WHERE Modulo = @Modulo AND ModuloID = @ID

    SELECT @TagLimpiar = TagLimpiar 
      FROM TablaParseoD 
     WHERE Exportacion = @Exportacion AND RID = @RID

    IF @TagLimpiar IS NULL or @TagLimpiar = ''
      SET @RID = @RID+1
    ELSE
    BEGIN

      UPDATE MovXML 
         SET DocumentoTexto = (SELECT REPLACE(@DocumentoTexto,@TagLimpiar,'')) 
       WHERE Modulo = @Modulo AND ModuloID = @ID

      SET @RID = @RID+1
    END
  END
END
GO


/******************************* spTagLimpiar *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spTagLimpiar') AND TYPE = 'P')
DROP PROCEDURE spTagLimpiar
GO
CREATE PROCEDURE spTagLimpiar
  (
  @CampoXML varchar(MAX)
  )
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @TagLimpiar varchar(MAX)

  SET @TagLimpiar = '<'+RTRIM(REPLACE(@CampoXML,'[',''))+'>'+'</'+RTRIM(REPLACE(@CampoXML,'[',''))+'>'
  SET @TagLimpiar = RTRIM(REPLACE(@TagLimpiar,']',''))

  SELECT @TagLimpiar
END
GO

/******************************* spGenerarXMLSchema *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spGenerarXMLSchema') AND TYPE = 'P')
DROP PROCEDURE spGenerarXMLSchema
GO

CREATE PROCEDURE spGenerarXMLSchema
  (
  @Modulo			varchar(5),
  @Mov				varchar(20),
  @Exportacion			varchar(50)
  ) 
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @IDSQL		varchar(100),
	  @XSD			nvarchar(MAX),
	  @XMLSchema		nvarchar(max)

  SET @IDSQL = RTRIM(@Modulo) + '_' + RTRIM(@Mov) + '_' + RTRIM(@Exportacion)

  SELECT @XSD = DocumentoXSD 
    FROM MovExportacion 
   WHERE Exportacion = @Exportacion

  IF EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = @IDSQL)
  BEGIN

    SET @XMLSchema = 'DROP XML SCHEMA COLLECTION ' + RTRIM(@IDSQL)
    EXECUTE sp_executesql @XMLSchema

    IF NULLIF(RTRIM(@XSD),'') IS NOT NULL
    BEGIN
      SET @XMLSchema = 'CREATE XML SCHEMA COLLECTION ' + RTRIM(@IDSQL) + ' AS ' + RTRIM(@XSD)
      EXECUTE sp_executesql @XMLSchema
    END
  END
  ELSE
  BEGIN 
    IF NULLIF(RTRIM(@XSD),'') IS NOT NULL
    BEGIN
      SET @XMLSchema = 'CREATE XML SCHEMA COLLECTION ' + RTRIM(@IDSQL) + ' AS ' + RTRIM(@XSD)
      EXECUTE sp_executesql @XMLSchema
    END
  END
END 
GO

/******************************* spValidarXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spValidarXML') AND TYPE = 'P')
DROP PROCEDURE spValidarXML
GO

CREATE PROCEDURE spValidarXML
  (
  @Modulo		varchar(5),
  @Mov			varchar(20),
  @Exportacion	varchar(50),
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
    @Error			int

  SET @IDSQL = RTRIM(@Modulo) + '_' + RTRIM(@Mov) + '_' + RTRIM(@Exportacion)
  SET @Validacion = 'DECLARE @x XML (' + RTRIM(@IDSQL) + ') ' + 'BEGIN TRY SET @x = N' + CHAR(39) + RTRIM(@XML) + CHAR(39) + 'END TRY BEGIN CATCH SELECT ' + CHAR(39) + 'ERROR: ' + CHAR(39) + ' + CONVERT(varchar,@@ERROR) + ' + CHAR(39) + '. ' + CHAR(39) + ' + ISNULL(ERROR_MESSAGE(),' + CHAR(39) + '' + CHAR(39) + ')' + 'END CATCH'
  SET @Parametros = '@Error int OUTPUT'

  EXECUTE sp_executesql @Validacion, @Parametros, @Error = @Error OUTPUT
  SET @Ok = @Error
END 
GO

/******************************* spExportacionXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spExportacionXML') AND TYPE = 'P')
DROP PROCEDURE spExportacionXML
GO

CREATE PROCEDURE spExportacionXML
  (
  @Estacion		int,			
  @Modulo		varchar(5),		
  @Mov			varchar(20),
  @ID			int,
  @Ok			int OUTPUT,
  @OkRef		varchar(255) OUTPUT
  )
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE	@Documento				varchar(MAX),
			@Exportacion			varchar(50),
			@Orden					int,
			@Seccion				varchar(50),
			@SubSeccionDe			varchar(50),
			@Vista					varchar(100),
			@ExpresionFinal			varchar(100),
			@DocumentoSeccion		varchar(MAX),
			@LargoExpresionFinal	int,
			@PosicionFinal			int,
			@Select					varchar(MAX),
			@NSelect				nvarchar(MAX),
			@OrdenSeccion			int,
			@Cierre					bit,
			@DocumentoTexto			varchar(MAX),
			@ApuntadorTexto			binary(16),
			@ApuntadorPrologo		binary(16),
			@IDSeccion				int,
			@Prologo				varchar(200),
			@Codificacion			varchar(20),
			@ApuntadorValido		int


  SET @OrdenSeccion = 0
  DELETE MovExportacionDatos WHERE Estacion = @Estacion		
  
  SELECT @Exportacion = Exportacion, @Documento = Documento FROM MovExportacion WHERE Modulo = @Modulo AND Mov = @Mov
  SELECT @Codificacion = Codificacion FROM MovExportacion WHERE Exportacion = @Exportacion
  SET @Prologo = '<?xml version = "1.0" encoding = "'+ RTRIM(@Codificacion) +'" ?>'

  DECLARE crMovExportacionD CURSOR FAST_FORWARD FOR 
   SELECT Orden, Seccion, SubSeccionDe, Vista, ISNULL(ExpresionFinal,''), Cierre, RID
     FROM MovExportacionD
    WHERE Exportacion = @Exportacion
    ORDER BY Orden

  OPEN crMovExportacionD
  FETCH NEXT FROM crMovExportacionD INTO @Orden, @Seccion, @SubSeccionDe, @Vista, @ExpresionFinal, @Cierre, @IDSeccion
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN

    IF NULLIF(RTRIM(@ExpresionFinal),'') IS NOT NULL
    BEGIN
      SET @LargoExpresionFinal = LEN(@ExpresionFinal)
      SET @PosicionFinal = CHARINDEX(@ExpresionFinal,@Documento,1)
      IF @PosicionFinal > 0 SET @PosicionFinal = (@PosicionFinal - 1) + @LargoExpresionFinal ELSE SET @PosicionFinal = LEN(@Documento)
      SET @DocumentoSeccion = SUBSTRING(@Documento,1,@PosicionFinal)
      SET @Documento = SUBSTRING(@Documento,@PosicionFinal + 1, LEN(@Documento))
    END

    ELSE
    BEGIN
      SET @DocumentoSeccion = @Documento
      SET @Documento = ''
    END

    EXEC spMovParsearSeccion @Estacion, @Modulo, @Mov, @Exportacion, @IDSeccion, @Vista, @ID, @DocumentoSeccion, @SubSeccionDe, @Cierre, @Select OUTPUT, @OrdenSeccion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
    BEGIN
      SET @NSelect = @Select
      EXECUTE sp_executesql @NSelect  
    END

    FETCH NEXT FROM crMovExportacionD INTO @Orden, @Seccion, @SubSeccionDe, @Vista, @ExpresionFinal, @Cierre, @IDSeccion
  END
	
  CLOSE crMovExportacionD
  DEALLOCATE crMovExportacionD
  
  DELETE FROM MovXML WHERE Modulo = @Modulo AND ModuloID = @ID

  DECLARE crMovExportacionDatos CURSOR FAST_FORWARD FOR

   SELECT Documento
     FROM MovExportacionDatos
    WHERE Estacion = @Estacion AND Modulo = @Modulo AND ModuloID = @ID
    ORDER BY OrdenExportacion
  OPEN crMovExportacionDatos
  FETCH NEXT FROM crMovExportacionDatos INTO @DocumentoTexto
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    IF NOT EXISTS(SELECT * FROM MovXML WHERE Modulo = @Modulo AND ModuloID = @ID)
      INSERT MovXML (Modulo, ModuloID, DocumentoTexto) VALUES (@Modulo, @ID, @DocumentoTexto)
    ELSE
    BEGIN
      SELECT @ApuntadorTexto = TEXTPTR(DocumentoTexto) FROM MovXML WHERE Modulo = @Modulo AND ModuloID = @ID
      SET @ApuntadorValido = TEXTVALID('MovXML.DocumentoTexto',@ApuntadorPrologo)

      IF @ApuntadorValido = 1
        UPDATETEXT MovXML.DocumentoTexto @ApuntadorTexto NULL 0 @DocumentoTexto
    END

    FETCH NEXT FROM crMovExportacionDatos INTO @DocumentoTexto
  END

  CLOSE crMovExportacionDatos
  DEALLOCATE crMovExportacionDatos

  SELECT @ApuntadorPrologo = TEXTPTR(DocumentoTexto) FROM MovXML WHERE Modulo = @Modulo AND ModuloID = @ID 
  SET @ApuntadorValido = TEXTVALID('MovXML.DocumentoTexto',@ApuntadorPrologo)
 
  IF @ApuntadorValido = 1
    UPDATETEXT MovXML.DocumentoTexto @ApuntadorPrologo 0 0 @Prologo

  EXEC spLimpiarXML @Exportacion, @Modulo, @ID

  UPDATE MovXML SET DocumentoXML = DocumentoTexto WHERE Modulo = @Modulo AND ModuloID = @ID

  --EXEC spGenerarXMLSchema @Modulo, @Mov, @Exportacion
  --EXEC spValidarXML @Modulo, @Mov, @Exportacion, @DocumentoTexto, @Ok OUTPUT, @OkRef OUTPUT
END
GO

/******************************* spExportacionXML *************************************************/
--IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spExportacionXML') AND TYPE = 'P')
--DROP PROCEDURE spExportacionXML
--GO
--CREATE PROCEDURE spExportacionXML
--  (
--  @Modulo		varchar(5),		
--  @Mov			varchar(20),
--  @ID			int,
--  @Ok			int OUTPUT,
--  @OkRef		varchar(255) OUTPUT
--  )
--
--AS
--BEGIN
--  DECLARE @Exportacion		varchar(50)
--
--  DECLARE crMovExportacion CURSOR FOR
--   SELECT Exportacion
--     FROM MovExportacion
--    WHERE Modulo = @Modulo AND Mov = @Mov
--
--  OPEN crMovExportacion
--  FETCH NEXT FROM crMovExportacion INTO @Exportacion
--  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
--  BEGIN
--    
--    EXEC spMovParsear @@SPID, @Modulo, @Mov, @ID, @Ok OUTPUT, @OkRef OUTPUT
--
--    FETCH NEXT FROM crMovExportacion INTO crMovExportacion INTO @Exportacion
--  END
--  CLOSE crMovExportacion
--  DEALLOCATE crMovExportacion
--
--END
