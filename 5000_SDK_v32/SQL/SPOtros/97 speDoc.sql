/* Configuracion MS SQL Server */

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_DEFAULTS OFF
GO

/***********************************************     VISTAS        **********************************************/

/**************** fnEsCaracterUTF8 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEsCaracterUTF8') DROP FUNCTION fnEsCaracterUTF8
GO
CREATE FUNCTION fnEsCaracterUTF8 
	(
	@Caracter				varchar(20)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EsCaracterUTF8	bit

  IF @Caracter IN ('&lt;','&gt;','&amp;','&copy;','&reg;','&trade;','&curren;','&euro;','&yen;','&pound;','&cent;','&deg;','&acute;','&circ;','&uml;','&tilde;','&agrave;','&egrave;','&igrave;','&ograve;','&ugrave;','&Agrave;','&Egrave;','&Igrave;','&Ograve;','&Ugrave;','&aacute;','&eacute;','&iacute;','&oacute;','&uacute;','&yacute;','&Aacute;','&Eacute;','&Iacute;','&Oacute;','&Uacute;','&acirc;','&ecirc;','&icirc;','&ocirc;','&ucirc;','&Acirc;','&Ecirc;','&Icirc;','&Ocirc;','&Ucirc;','&auml;','&euml;','&iuml;','&ouml;','&uuml;','&yuml;','&Auml;','&Euml;','&Iuml;','&Ouml;','&Uuml;','&Yuml;','&atilde;','&otilde;','&ntilde;','&aring;','&oslash;','&scaron;','&Atilde;','&Otilde;','&Ntilde;','&Aring;','&Oslash;','&Scaron;','&ccedil;','&Ccedil;','&quot;')
     OR (SUBSTRING(@Caracter,1,1) = '&' AND SUBSTRING(@Caracter,2,1) = '#' AND SUBSTRING(@Caracter,3,1) IN ('0','1','2','3','4','5','6','7','8','9') AND SUBSTRING(@Caracter,4,1) IN ('0','1','2','3','4','5','6','7','8','9') AND SUBSTRING(@Caracter,5,1) IN ('0','1','2','3','4','5','6','7','8','9') AND SUBSTRING(@Caracter,6,1) = ';')
    SET @EsCaracterUTF8 = 1
  ELSE
    SET @EsCaracterUTF8 = 0
            
  RETURN (@EsCaracterUTF8)
END
GO

--select dbo.fnescaracterutf8('&#038;')

/**************** fnASCII_CP437 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnASCII_CP437') DROP FUNCTION fnASCII_CP437
GO
CREATE FUNCTION fnASCII_CP437 
	(
	@Caracter				char(1), 
	@ConvertirCP437			bit = 0
	)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ASCII	int

  IF @ConvertirCP437 = 1
    SET @ASCII = ASCII(@Caracter COLLATE SQL_Latin1_General_CP437_CI_AS)  
  ELSE
    SET @ASCII = ASCII(@Caracter)
      
  RETURN (@ASCII)
END
GO

--BUG17262 EWILLARD
-- Se mueve la definición de la funcion fnCaracterAUTF8 a 01 spGenerales.sql para evitar el error al dar mantenimiento a versiones anteriores.

--select dbo.fnCaracterAUTF8(char(038))
--SELECT dbo.fnCaracterAUTF8('&')

--BUG17262 EWILLARD
-- Se mueve la definición de la funcion fneDocXmlAUTF8 a 01 spGenerales.sql para evitar el error al dar mantenimiento a versiones anteriores.

--SELECT dbo.fneDocXmlAUTF8('<a>Abráham &&#038; Romano</a>',0,1) 

/**************** fneDocXmlAUTF8Min ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocXmlAUTF8Min') DROP FUNCTION dbo.fneDocXmlAUTF8Min
GO
CREATE FUNCTION dbo.fneDocXmlAUTF8Min   
 (  
 @XML    varchar(max),  
 @ConvertirCP437  bit = 0,  
 @ConvertirComillas  bit = 1  
 )  
RETURNS varchar(max)  
  
--//WITH ENCRYPTION  
AS BEGIN  

    SET @XML = ISNULL(@XML,'') COLLATE Modern_Spanish_CS_AS
    SET @XML = REPLACE(@XML,'''','&apos;') COLLATE Modern_Spanish_CS_AS
    SET @XML = REPLACE(@XML,'&','&amp;') COLLATE Modern_Spanish_CS_AS
    SET @XML = REPLACE(@XML,'<','&gt;') COLLATE Modern_Spanish_CS_AS
    SET @XML = REPLACE(@XML,'>','&lt;') COLLATE Modern_Spanish_CS_AS
    SET @XML = REPLACE(@XML,'"','&quot;') COLLATE Modern_Spanish_CS_AS
      
  RETURN @XML  
  
END
GO


/**************** fnSerieConsecutivo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSerieConsecutivo') DROP FUNCTION fnSerieConsecutivo
GO
CREATE FUNCTION fnSerieConsecutivo 
	(
	@MovID				varchar(20)
	)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Serie	varchar(20),
    @p		int
    
  SELECT @p = LEN(@MovID)
  
  WHILE @p >= 1 AND dbo.fnEsNumerico(SUBSTRING(@MovID, @p, 1)) = 1
    SELECT @p = @p - 1

  SELECT @Serie = NULLIF(RTRIM(SUBSTRING(@MovID, 1, @p)), '')

  RETURN (@Serie)
END
GO


/**************** fnFolioConsecutivo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFolioConsecutivo') DROP FUNCTION fnFolioConsecutivo
GO
CREATE FUNCTION fnFolioConsecutivo 
	(
	@MovID				varchar(20)
	)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Folio	varchar(20),
    @p		int
    
  SELECT @p = LEN(@MovID)
  
  WHILE @p >= 1 AND dbo.fnEsNumerico(SUBSTRING(@MovID, @p, 1)) = 1
    SELECT @p = @p - 1

  SELECT @Folio = RTRIM(SUBSTRING(@MovID, @p+1, LEN(@MovID)))


  RETURN (@Folio)
END
GO


-- select dbo.fnCFDTipoCambioMN(10.14, 1)
/**************** fnCFDTipoCambioMN ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDTipoCambioMN') DROP FUNCTION fnCFDTipoCambioMN
GO
CREATE FUNCTION fnCFDTipoCambioMN (@TipoCambio Float, @EnMN bit)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			float

SELECT @EnMN = ISNULL(@EnMN,0)

IF @EnMN = 1
 SELECT @Resultado = @TipoCambio
ELSE 
 SELECT @Resultado = 1

  RETURN(@Resultado)
END
GO

/******************************* fnxpeDocVentaReferenciaMetodoCobro *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnxpeDocVentaReferenciaMetodoCobro')
DROP FUNCTION fnxpeDocVentaReferenciaMetodoCobro
GO
CREATE FUNCTION fnxpeDocVentaReferenciaMetodoCobro
  (
  @ID               int,
  @Ref              bit,
  @Resultado        varchar(max)
  )
RETURNS varchar(max)
AS

BEGIN
    
  RETURN RTRIM(LTRIM(@Resultado))	
END
GO

/******************************* fneDocEsNumero *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocEsNumero')
DROP FUNCTION fneDocEsNumero
GO
CREATE FUNCTION fneDocEsNumero
  (
  @Resultado        varchar(4)
  )
RETURNS varchar(100)
AS

BEGIN

  IF ISNUMERIC(@Resultado) = 0
    SET @Resultado = NULL
  
  RETURN (@Resultado)
END
GO

/******************************* fneDocVentaReferenciaMetodoCobro *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocVentaReferenciaMetodoCobro')
DROP FUNCTION fneDocVentaReferenciaMetodoCobro
GO
CREATE FUNCTION fneDocVentaReferenciaMetodoCobro
  (
  @ID               int,
  @Ref              bit
  )
RETURNS varchar(100)
AS
BEGIN
  DECLARE	
    @FormaCobro     varchar(50),
    @Referencia     varchar(50),
    @FormaCobro1    varchar(50),
    @Referencia1    varchar(50),
    @FormaCobro2    varchar(50),
    @Referencia2    varchar(50),
    @FormaCobro3    varchar(50),
    @Referencia3    varchar(50),
	@FormaCobro4    varchar(50),
    @Referencia4    varchar(50),
    @FormaCobro5    varchar(50),
    @Referencia5    varchar(50),
	@Importe1       float, 
	@Importe2       float, 
	@Importe3       float, 
	@Importe4       float, 
	@Importe5       float,
    @Cliente		varchar(10),
    @Resultado      varchar(MAX),
    @InfoPago		varchar(100),
    @InfoFormaPago	varchar(50),
    @EnviarA		int,
    @Empresa		char(5),
	@IDR            int,
	@FormaCobroRef  varchar(50),
	@ReferenciaRef  varchar(50),
	@ValidarMetodoPago bit

  SELECT @ValidarMetodoPago = 0
  IF EXISTS (SELECT * FROM VentaCobro WHERE ID = @ID)
    SELECT @ValidarMetodoPago = 1


  SELECT
     @Resultado   = '',
     @FormaCobro1 = NULLIF(FormaCobro1,''),
     @Referencia1 = ISNULL(Referencia1,'No Aplica'),
     @FormaCobro2 = NULLIF(FormaCobro2,''),
     @Referencia2 = ISNULL(Referencia2,'No Aplica'),
     @FormaCobro3 = NULLIF(FormaCobro3,''),
     @Referencia3 = ISNULL(Referencia3,'No Aplica'),
     @FormaCobro4 = NULLIF(FormaCobro4,''),
     @Referencia4 = ISNULL(Referencia4,'No Aplica'),
     @FormaCobro5 = NULLIF(FormaCobro5,''),
     @Referencia5 = ISNULL(Referencia5,'No Aplica'),
	 @Importe1    = ISNULL(Importe1,0),
	 @Importe2    = ISNULL(Importe2,0),
	 @Importe3    = ISNULL(Importe3,0),
	 @Importe4    = ISNULL(Importe4,0),
	 @Importe5    = ISNULL(Importe5,0)
    FROM VentaCobro
   WHERE ID = @ID   

  SELECT
     @FormaCobro  = ISNULL(FormaPagoTipo,''),
     @Referencia  = NULL,
     @Cliente     = ISNULL(Cliente,''),
     @EnviarA     = EnviarA,
     @Empresa     = Empresa
    FROM Venta
   WHERE ID = @ID 
  
  SELECT @FormaCobro1 = ClaveSAT FROM FormaPago WHERE FormaPago = @FormaCobro1
  SELECT @FormaCobro2 = ClaveSAT FROM FormaPago WHERE FormaPago = @FormaCobro2
  SELECT @FormaCobro3 = ClaveSAT FROM FormaPago WHERE FormaPago = @FormaCobro3
  SELECT @FormaCobro4 = ClaveSAT FROM FormaPago WHERE FormaPago = @FormaCobro4
  SELECT @FormaCobro5 = ClaveSAT FROM FormaPago WHERE FormaPago = @FormaCobro5
  SELECT @FormaCobro = MAX(ClaveSAT) FROM FormaPagoTipoD tf JOIN FormaPago f ON tf.FormaPago = f.FormaPago WHERE Tipo = @FormaCobro

  IF @Ref <> 1  
   SELECT @Resultado =  NULLIF(@FormaCobro,'')

  IF @Resultado IS NULL
   SELECT @Resultado  = ''   

  DECLARE @DatosTemp TABLE (Importe float,   FormaCobro varchar(50), Referencia varchar(50)) 
   INSERT INTO @DatosTemp SELECT @Importe1, @FormaCobro1, @Referencia1
   INSERT INTO @DatosTemp SELECT @Importe2, @FormaCobro2, @Referencia2
   INSERT INTO @DatosTemp SELECT @Importe3, @FormaCobro3, @Referencia3
   INSERT INTO @DatosTemp SELECT @Importe4, @FormaCobro4, @Referencia4
   INSERT INTO @DatosTemp SELECT @Importe5, @FormaCobro5, @Referencia5

  DECLARE @Datos TABLE (ID int identity(1,1), FormaCobro varchar(50), Referencia varchar(50))
   INSERT INTO @Datos(FormaCobro, Referencia) SELECT FormaCobro, Referencia FROM @DatosTemp ORDER BY Importe DESC

  SELECT @IDR = MIN(ID) FROM @Datos
  WHILE @IDR IS NOT NULL
  BEGIN
   SELECT @FormaCobroRef = FormaCobro, @ReferenciaRef = Referencia FROM @Datos WHERE ID = @IDR

   IF @Ref = 1
   BEGIN
    IF @FormaCobroRef IS NOT NULL AND @ReferenciaRef IS NOT NULL
     SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@ReferenciaRef,4)),'No Aplica') + ','
   END
   ELSE
   BEGIN
    IF @FormaCobroRef IS NOT NULL AND @ReferenciaRef IS NOT NULL
     SELECT @Resultado = @Resultado + @FormaCobroRef + ','
   END
   
   SELECT @IDR = MIN(ID) FROM @Datos WHERE ID > @IDR
  END
  
  --IF @Ref = 1
  --BEGIN
  --  IF @FormaCobro1 IS NOT NULL AND @Referencia1 IS NOT NULL
  --    SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@Referencia1,4)),'No Aplica') + ','
  --  IF @FormaCobro2 IS NOT NULL AND @Referencia2 IS NOT NULL
  --    SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@Referencia2,4)),'No Aplica') + ','
  --  IF @FormaCobro3 IS NOT NULL AND @Referencia3 IS NOT NULL
  --    SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@Referencia3,4)),'No Aplica') + ','
  --  IF @FormaCobro4 IS NOT NULL AND @Referencia4 IS NOT NULL
  --    SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@Referencia4,4)),'No Aplica') + ','
  --  IF @FormaCobro5 IS NOT NULL AND @Referencia5 IS NOT NULL
  --    SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@Referencia5,4)),'No Aplica') + ','
  --END
  --ELSE
  --BEGIN
  --  IF @FormaCobro1 IS NOT NULL AND @Referencia1 IS NOT NULL
  --    SELECT @Resultado = @Resultado + @FormaCobro1 + ','
  --  IF @FormaCobro2 IS NOT NULL AND @Referencia2 IS NOT NULL
  --    SELECT @Resultado = @Resultado + @FormaCobro2 + ','
  --  IF @FormaCobro3 IS NOT NULL AND @Referencia3 IS NOT NULL
  --    SELECT @Resultado = @Resultado + @FormaCobro3 + ','
  --  IF @FormaCobro4 IS NOT NULL AND @Referencia4 IS NOT NULL
  --    SELECT @Resultado = @Resultado + @FormaCobro4 + ','
  --  IF @FormaCobro5 IS NOT NULL AND @Referencia5 IS NOT NULL
  --    SELECT @Resultado = @Resultado + @FormaCobro5 + ','
  --END

  IF SUBSTRING(@Resultado, LEN(@Resultado), 1)  = ','
    SET @Resultado = SUBSTRING(@Resultado, 1, LEN(@Resultado)-1)
  
  IF NULLIF(@Resultado,'') IS NULL
  BEGIN
    SELECT @InfoFormaPago = InfoFormaPago FROM CteEmpresaCFD WHERE Cliente = @Cliente AND Empresa = @Empresa

    IF @Ref = 1
      SELECT @Resultado = dbo.fneDocEsNumero(RIGHT(NULLIF(CuentaPago,''),4)) FROM CteCFDFormaPago WHERE Cliente = @Cliente AND Empresa = @Empresa AND FormaPago = @InfoFormaPago
    ELSE
      SELECT @Resultado = FormaPago.ClaveSAT FROM CteCFDFormaPago LEFT JOIN FormaPago ON CteCFDFormaPago.FormaPago = FormaPago.FormaPago  WHERE CteCFDFormaPago.Cliente = @Cliente AND CteCFDFormaPago.Empresa = @Empresa  AND CteCFDFormaPago.FormaPago = @InfoFormaPago
  END

  IF NULLIF(@Resultado,'') IS NULL
  BEGIN
    --IF @EnviarA IS NOT NULL
    --  SELECT @InfoPago = InfoPago,
    --         @InfoFormaPago = InfoFormaPago
    --    FROM CteEnviarACFD
    --   WHERE Cliente = @Cliente
    --     AND EnviarA = @EnviarA
       
     IF @InfoPago IS NULL OR @InfoFormaPago IS NULL
       SELECT @InfoPago = InfoPago,
             @InfoFormaPago = InfoFormaPago
        FROM CteCFD
       WHERE Cliente = @Cliente

    SELECT @FormaCobro = NULLIF(FormaPago.ClaveSAT,''),
           @Referencia = ISNULL(dbo.fneDocEsNumero(RIGHT(NULLIF(CuentaPago,''),4)),'No Aplica')
      FROM CteCFDInfoPagoD
	  LEFT JOIN FormaPago ON CteCFDInfoPagoD.FormaPago = FormaPago.FormaPago
     WHERE CteCFDInfoPagoD.Cliente = @Cliente
       AND CteCFDInfoPagoD.InfoPago = @InfoPago
       AND CteCFDInfoPagoD.FormaPago = @InfoFormaPago
  END  

  IF NULLIF(@Resultado,'') IS NULL
  BEGIN
    IF @Ref = 1
    BEGIN
      SET @Resultado = dbo.fneDocEsNumero(RIGHT(@Referencia,4))
      IF @Resultado IS NULL
        SELECT @Resultado = dbo.fneDocEsNumero(RIGHT(Cta,4)) FROM CteCFD WHERE Cliente = @Cliente
    END
    ELSE
      SET @Resultado = ISNULL(@FormaCobro, '')
  END

  IF ISNULL(@Resultado,'') = '' AND @Ref != 1
     SELECT @Resultado = ISNULL(NULLIF(SATFormaPago.Clave,''), '') FROM Venta JOIN Condicion ON Venta.Condicion = Condicion.Condicion 
	   LEFT JOIN SATFormaPago ON Condicion.CFD_formaDePago = SATFormaPago.Descripcion WHERE Venta.ID = @ID

  IF NULLIF(@Resultado,'') IS NULL
  BEGIN
    IF @Ref = 1
      SET @Resultado = ISNULL(NULLIF(@Referencia,''),'No Aplica')
    ELSE
      SET @Resultado = ISNULL(NULLIF(@FormaCobro,''), 'NA')
  END
  
  SET @Resultado = dbo.fnxpeDocVentaReferenciaMetodoCobro(@ID, @Ref, @Resultado)
    
  RETURN RTRIM(LTRIM(@Resultado))
END
GO
/******************************* fnxpeDocCXCReferenciaMetodoCobro *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnxpeDocCXCReferenciaMetodoCobro')
DROP FUNCTION fnxpeDocCXCReferenciaMetodoCobro
GO
CREATE FUNCTION fnxpeDocCXCReferenciaMetodoCobro
  (
  @ID               int,
  @Ref              bit,
  @Resultado        varchar(max)
  )
RETURNS varchar(max)
AS

BEGIN
    
  RETURN RTRIM(LTRIM(@Resultado))	
END
GO

/******************************* fneDocCXCReferenciaMetodoCobro *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocCXCReferenciaMetodoCobro')
DROP FUNCTION fneDocCXCReferenciaMetodoCobro
GO
CREATE FUNCTION fneDocCXCReferenciaMetodoCobro
  (
  @ID               int,
  @Ref              bit
  )
RETURNS varchar(100)
AS

BEGIN
  DECLARE	
    @FormaCobro     varchar(50),
    @Referencia     varchar(50),
    @FormaCobro1    varchar(50),
    @Referencia1    varchar(50),
    @FormaCobro2    varchar(50),
    @Referencia2    varchar(50),
    @FormaCobro3    varchar(50),
    @Referencia3    varchar(50),
    @FormaCobro4    varchar(50),
    @Referencia4    varchar(50),
    @FormaCobro5    varchar(50),
    @Referencia5    varchar(50),
	@Importe1       float, 
	@Importe2       float, 
	@Importe3       float, 
	@Importe4       float, 
	@Importe5       float,
    @Cliente		varchar(10),
    @Resultado      varchar(max),
    @InfoPago		varchar(100),
    @InfoFormaPago	varchar(50),
    @EnviarA		int,
    @Empresa		char(5),
	@IDR            int,
	@FormaCobroRef  varchar(50),
	@ReferenciaRef  varchar(50),
	@ValidarMetodoPago bit,
	@MovTipo		 varchar(20)

  SELECT @MovTipo = Clave  FROM CXC c JOIN MovTipo mt ON Mt.Modulo = 'CXC' AND mt.Mov = c.Mov WHERE c.ID = @ID
  SELECT @ValidarMetodoPago = 0
  IF @MovTipo = 'CXC.C' SELECT @ValidarMetodoPago = 1

  SELECT
     @Resultado   = '',
     @FormaCobro  = ISNULL(FormaCobro,''),
     @Referencia  = NULL,
     @FormaCobro1 = NULLIF(FormaCobro1,''),
     @Referencia1 = NULLIF(Referencia1,''),
     @FormaCobro2 = NULLIF(FormaCobro2,''),
     @Referencia2 = NULLIF(Referencia2,''),
     @FormaCobro3 = NULLIF(FormaCobro3,''),
     @Referencia3 = NULLIF(Referencia3,''),
     @FormaCobro4 = NULLIF(FormaCobro4,''),
     @Referencia4 = NULLIF(Referencia4,''),
     @FormaCobro5 = NULLIF(FormaCobro5,''),
     @Referencia5 = NULLIF(Referencia5,''),
     @Cliente     = ISNULL(Cliente,''),
     @EnviarA     = ClienteEnviarA,
     @Empresa     = Empresa,
	 @Importe1    = ISNULL(Importe1,0),
	 @Importe2    = ISNULL(Importe2,0),
	 @Importe3    = ISNULL(Importe3,0),
	 @Importe4    = ISNULL(Importe4,0),
	 @Importe5    = ISNULL(Importe5,0)
    FROM Cxc
   WHERE ID = @ID
   
  SELECT @FormaCobro1 = ClaveSAT FROM FormaPago WHERE FormaPago = @FormaCobro1
  SELECT @FormaCobro2 = ClaveSAT FROM FormaPago WHERE FormaPago = @FormaCobro2
  SELECT @FormaCobro3 = ClaveSAT FROM FormaPago WHERE FormaPago = @FormaCobro3
  SELECT @FormaCobro4 = ClaveSAT FROM FormaPago WHERE FormaPago = @FormaCobro4
  SELECT @FormaCobro5 = ClaveSAT FROM FormaPago WHERE FormaPago = @FormaCobro5
  SELECT @FormaCobro = ClaveSAT FROM FormaPago WHERE FormaPago = @FormaCobro
  
  DECLARE @DatosTemp TABLE (Importe float,   FormaCobro varchar(50), Referencia varchar(50)) 
   INSERT INTO @DatosTemp SELECT @Importe1, @FormaCobro1, @Referencia1
   INSERT INTO @DatosTemp SELECT @Importe2, @FormaCobro2, @Referencia2
   INSERT INTO @DatosTemp SELECT @Importe3, @FormaCobro3, @Referencia3
   INSERT INTO @DatosTemp SELECT @Importe4, @FormaCobro4, @Referencia4
   INSERT INTO @DatosTemp SELECT @Importe5, @FormaCobro5, @Referencia5

  IF @Resultado IS NULL
   SELECT @Resultado  = ''

  DECLARE @Datos TABLE (ID int identity(1,1), FormaCobro varchar(50), Referencia varchar(50))
   INSERT INTO @Datos(FormaCobro, Referencia) SELECT FormaCobro, Referencia FROM @DatosTemp ORDER BY Importe DESC

  SELECT @IDR = MIN(ID) FROM @Datos
  WHILE @IDR IS NOT NULL
  BEGIN
   SELECT @FormaCobroRef = FormaCobro, @ReferenciaRef = Referencia FROM @Datos WHERE ID = @IDR

   IF @Ref = 1
   BEGIN
    IF @FormaCobroRef IS NOT NULL AND @ReferenciaRef IS NOT NULL
     SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@ReferenciaRef,4)),'No Aplica') + ','
   END
   ELSE
   BEGIN
    IF @FormaCobroRef IS NOT NULL AND @ReferenciaRef IS NOT NULL
     SELECT @Resultado = @Resultado + @FormaCobroRef + ','
   END
   
   SELECT @IDR = MIN(ID) FROM @Datos WHERE ID > @IDR
  END

  
  --IF @Ref = 1
  --BEGIN
  --  IF @FormaCobro1 IS NOT NULL AND @Referencia1 IS NOT NULL
  --    SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@Referencia1,4)),'No Aplica') + ','
  --  IF @FormaCobro2 IS NOT NULL AND @Referencia2 IS NOT NULL
  --    SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@Referencia2,4)),'No Aplica') + ','
  --  IF @FormaCobro3 IS NOT NULL AND @Referencia3 IS NOT NULL
  --    SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@Referencia3,4)),'No Aplica') + ','
  --  IF @FormaCobro4 IS NOT NULL AND @Referencia4 IS NOT NULL
  --    SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@Referencia4,4)),'No Aplica') + ','
  --  IF @FormaCobro5 IS NOT NULL AND @Referencia5 IS NOT NULL
  --    SELECT @Resultado = @Resultado + ISNULL(dbo.fneDocEsNumero(RIGHT(@Referencia5,4)),'No Aplica') + ','
  --END
  --ELSE
  --BEGIN
  --  IF @FormaCobro1 IS NOT NULL AND @Referencia1 IS NOT NULL
  --    SELECT @Resultado = @Resultado + @FormaCobro1 + ','
  --  IF @FormaCobro2 IS NOT NULL AND @Referencia2 IS NOT NULL
  --    SELECT @Resultado = @Resultado + @FormaCobro2 + ','
  --  IF @FormaCobro3 IS NOT NULL AND @Referencia3 IS NOT NULL
  --    SELECT @Resultado = @Resultado + @FormaCobro3 + ','
  --  IF @FormaCobro4 IS NOT NULL AND @Referencia4 IS NOT NULL
  --    SELECT @Resultado = @Resultado + @FormaCobro4 + ','
  --  IF @FormaCobro5 IS NOT NULL AND @Referencia5 IS NOT NULL
  --    SELECT @Resultado = @Resultado + @FormaCobro5 + ','
  --END
  
  IF SUBSTRING(@Resultado, LEN(@Resultado), 1)  = ','
    SET @Resultado = SUBSTRING(@Resultado, 1, LEN(@Resultado)-1)

  IF NULLIF(@Resultado,'') IS NULL
  BEGIN
    SELECT @InfoFormaPago = InfoFormaPago FROM CteEmpresaCFD WHERE Cliente = @Cliente AND Empresa = @Empresa

    IF @Ref = 1
      SELECT @Resultado = dbo.fneDocEsNumero(RIGHT(NULLIF(CuentaPago,''),4)) FROM CteCFDFormaPago WHERE Cliente = @Cliente AND Empresa = @Empresa AND FormaPago = @InfoFormaPago
    ELSE
      SELECT @Resultado = FormaPago.ClaveSAT FROM CteCFDFormaPago LEFT JOIN FormaPago ON CteCFDFormaPago.FormaPago = FormaPago.FormaPago  WHERE CteCFDFormaPago.Cliente = @Cliente AND CteCFDFormaPago.Empresa = @Empresa  AND CteCFDFormaPago.FormaPago = @InfoFormaPago
  END
    
  IF NULLIF(@Resultado,'') IS NULL
  BEGIN
    IF @EnviarA IS NOT NULL
      SELECT @InfoPago = InfoPago,
             @InfoFormaPago = InfoFormaPago
        FROM CteEnviarACFD
       WHERE Cliente = @Cliente
         AND EnviarA = @EnviarA
       
    IF @InfoPago IS NULL OR @InfoFormaPago IS NULL
      SELECT @InfoPago = InfoPago,
             @InfoFormaPago = InfoFormaPago
        FROM CteCFD
       WHERE Cliente = @Cliente

    SELECT @FormaCobro = NULLIF(FormaPago.ClaveSAT,''),
           @Referencia = ISNULL(dbo.fneDocEsNumero(RIGHT(NULLIF(CuentaPago,''),4)),'No Aplica')
      FROM CteCFDInfoPagoD
	  LEFT JOIN FormaPago ON CteCFDInfoPagoD.FormaPago = FormaPago.FormaPago
     WHERE CteCFDInfoPagoD.Cliente = @Cliente
       AND CteCFDInfoPagoD.InfoPago = @InfoPago
       AND CteCFDInfoPagoD.FormaPago = @InfoFormaPago
  END

  IF NULLIF(@Resultado,'') IS NULL
  BEGIN
    IF @Ref = 1
    BEGIN
      SET @Resultado = dbo.fneDocEsNumero(RIGHT(@Referencia,4))
      IF @Resultado IS NULL
        SELECT @Resultado = dbo.fneDocEsNumero(RIGHT(Cta,4)) FROM CteCFD WHERE Cliente = @Cliente
    END
    ELSE
      SET @Resultado = ISNULL(@FormaCobro, '')   
  END

  IF ISNULL(@Resultado,'') = '' AND @Ref != 1
     SELECT @Resultado = ISNULL(NULLIF(SATFormaPago.Clave,''), '') FROM Cxc JOIN Condicion ON Cxc.Condicion = Condicion.Condicion 
	   LEFT JOIN SATFormaPago ON Condicion.CFD_formaDePago = SATFormaPago.Descripcion WHERE Cxc.ID = @ID
       
  IF NULLIF(@Resultado,'') IS NULL
  BEGIN
    IF @Ref = 1
      SET @Resultado = ISNULL(NULLIF(@Referencia,''),'No Aplica')
    ELSE
    BEGIN
	  IF NULLIF(@FormaCobroref,'') IS NULL AND @ValidarMetodoPago = 0
      SET @Resultado = ISNULL(NULLIF(@FormaCobro,''), 'NA')
    END  
  END
  
  SET @Resultado = dbo.fnxpeDocCXCReferenciaMetodoCobro(@ID, @Ref, @Resultado)
    
  RETURN RTRIM(LTRIM(@Resultado))	
END
GO

/**************** fnTextoaTabla ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTextoaTabla') DROP FUNCTION fnTextoaTabla
GO
CREATE FUNCTION fnTextoaTabla (@Texto varchar(max), @Longitud int)
RETURNS @Resultado TABLE (CadenaOriginal varchar(255))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CadenaOriginal 	varchar(max)

  SELECT @Texto = ISNULL(RTRIM(@Texto), '')
  WHILE LEN(@Texto) > 0
  BEGIN   
      SELECT @CadenaOriginal = LTRIM(RTRIM(SUBSTRING(@Texto, 1, @Longitud-1)))
      SELECT @Texto = SUBSTRING(@Texto, @Longitud, LEN(@Texto))
    
    SELECT @CadenaOriginal = NULLIF(RTRIM(@CadenaOriginal), '')
    IF @CadenaOriginal IS NOT NULL
      INSERT @Resultado (CadenaOriginal)
      SELECT            @CadenaOriginal
  END
  
  RETURN 
END
GO

/**************** fnCFDVentaCadenaOriginal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDVentaCadenaOriginal') DROP FUNCTION fnCFDVentaCadenaOriginal
GO
CREATE FUNCTION fnCFDVentaCadenaOriginal ()
RETURNS @Resultado TABLE (OrdenExportacion varchar(255), ID int, CadenaOriginal varchar(255))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OrdenExportacion	varchar(255),
    @ID					int,
    @CadenaOriginal 	varchar(max),
	@ModuloID			int

  SELECT @ModuloID = ID FROM CFDFlexSesion WHERE Estacion = @@SPID AND Modulo = 'VTAS'
  DECLARE crCFDVentaCadenaOriginal CURSOR FOR
   SELECT REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Venta.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Venta.ID))) +
          REPLICATE(' ',12) + 
          REPLICATE(' ',7) +
          REPLICATE(' ',50)
          OrdenExportacion,
          Venta.ID ID,
          CFD.CadenaOriginal
     FROM Venta JOIN CFD
       ON CFD.ModuloID = Venta.ID AND CFD.Modulo = 'VTAS'
	WHERE Venta.ID = @ModuloID

  OPEN crCFDVentaCadenaOriginal
  FETCH NEXT FROM crCFDVentaCadenaOriginal INTO @OrdenExportacion, @ID, @CadenaOriginal
  WHILE @@FETCH_STATUS = 0
  BEGIN
    
    INSERT @Resultado ( OrdenExportacion,  ID,  CadenaOriginal)
    SELECT              @OrdenExportacion, @ID, CadenaOriginal
      FROM dbo.fnTextoaTabla(@CadenaOriginal, 130)
        
    FETCH NEXT FROM crCFDVentaCadenaOriginal INTO @OrdenExportacion, @ID, @CadenaOriginal
  END
  CLOSE crCFDVentaCadenaOriginal
  DEALLOCATE crCFDVentaCadenaOriginal

  RETURN 
END
GO
--SELECT * FROM fnCFDVentaCadenaOriginal()



/***************** CFDVentaCadenaOriginal *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaCadenaOriginal') AND TYPE = 'V') 
  DROP VIEW CFDVentaCadenaOriginal
GO
CREATE VIEW CFDVentaCadenaOriginal AS
SELECT * FROM dbo.fnCFDVentaCadenaOriginal()
GO
--SELECT * FROM CFDVentaCadenaOriginal

/*** VentaTCalcExportacion ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaTCalcExportacion') and type = 'V') drop view dbo.VentaTCalcExportacion
GO
CREATE VIEW VentaTCalcExportacion
--//WITH ENCRYPTION
AS 
SELECT 
   ID,
   SUM(ISNULL(ImporteDescuentoGlobal,0.0)) ImporteDescuentoGlobal,
   SUM(ISNULL(DescuentosTotales,0.0)) DescuentosTotales,      
   SUM(ISNULL(ImporteSobrePrecio,0.0)) ImporteSobrePrecio,     
   SUM(ISNULL(SubTotal,0.0)) SubTotal,               
   SUM(ISNULL(Impuesto1Total,0.0)) Impuesto1Total,         
   SUM(ISNULL(Impuesto2Total,0.0)) Impuesto2Total,         
   SUM(ISNULL(Impuesto3Total,0.0)) Impuesto3Total,         
   SUM(ISNULL(Retencion1Total,0.0)) Retencion1Total,         
   SUM(ISNULL(Retencion2Total,0.0)) Retencion2Total,         
   SUM(ISNULL(Impuestos,0.0)) Impuestos, 	          
   SUM(ISNULL(Retencion,0.0)) Retenciones,         
   SUM(ISNULL(ImporteTotal,0.0)) ImporteTotal,           
   SUM(ISNULL(TotalNeto,0.0)) TotalNeto              
 FROM VentaTCalc
 LEFT OUTER JOIN EmpresaCFD ON VentaTCalc.Empresa = EmpresaCFD.Empresa
GROUP BY ID
GO


/***************** CFDCorteCxc *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDCorteCxc') AND TYPE = 'V') DROP VIEW CFDCorteCxc
GO
CREATE VIEW CFDCorteCxc AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Corte.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Corte.ID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  
  Corte.ID ID,
  dbo.fnSerieConsecutivo(Corte.MovID) CorteSerie,  
  dbo.fnFolioConsecutivo(Corte.MovID) CorteFolio,  
  
  CONVERT(datetime,Corte.FechaRegistro, 126) CorteFechaRegistro,
  Corte.Mov CorteMov, 
  Corte.MovID CorteMovID,  
  Corte.Moneda CorteMoneda,
  Corte.TipoCambio CorteTipoCambio,
  Corte.Estatus CorteEstatus,  
  Corte.Ejercicio CorteEjercicio,
  Corte.Periodo CortePeriodo,
  Corte.CorteFechaD CorteFechaDe,
  Corte.FechaConclusion CorteFechaA,
  'Del ' + CONVERT(varchar, Corte.CorteFechaD, 103) + ' al ' + CONVERT(varchar, Corte.FechaConclusion, 103) CortePeriodoFechas,
  Corte.Concepto CorteConcepto,
  Corte.CorteCuentaDe CorteClienteDe,
  Corte.CorteCuentaA CorteClienteA,
    
  Empresa.GLN EmpresaGLN,
  Empresa.Nombre EmpresaNombre,
  Empresa.RFC EmpresaRFC,
  Empresa.Direccion EmpresaCalle,
  Empresa.DireccionNumero EmpresaNumeroExterior,
  Empresa.DireccionNumeroInt EmpresaNumeroInterior,
  Empresa.Colonia EmpresaColonia,
  Empresa.Poblacion EmpresaLocalidad,
  Empresa.Delegacion EmpresaMunicipio,
  Empresa.Estado EmpresaEstado,
  Empresa.Pais EmpresaPais,
  Empresa.CodigoPostal EmpresaCodigoPostal,

  Sucursal.GLN SucursalGLN,
  Sucursal.Nombre SucursalNombre,
  Sucursal.RFC SucursalRFC,
  Sucursal.Direccion SucursalCalle,
  Sucursal.DireccionNumero SucursalNumeroExterior,
  Sucursal.DireccionNumeroInt SucursalNumeroInterior,
  Sucursal.Colonia SucursalColonia,
  Sucursal.Delegacion + ', ' + Sucursal.Estado SucursalLocalidad,
  Sucursal.Delegacion SucursalMunicipio,
  Sucursal.Estado SucursalEstado,
  Sucursal.Pais SucursalPais,
  Sucursal.CodigoPostal SucursalCodigoPostal,  

  Cte.Cliente ClienteClave,
  Cte.Nombre ClienteNombre,
  Cte.RFC ClienteRFC,
  Cte.GLN ClienteGLN,  
  Cte.Direccion ClienteCalle,
  Cte.DireccionNumero ClienteNumeroExterior,
  Cte.DireccionNumeroInt ClienteNumeroInterior,
  Cte.Colonia ClienteColonia,
  Cte.Poblacion ClienteLocalidad,
  Cte.Delegacion ClienteMunicipio,
  Cte.Estado ClienteEstado,
  Cte.Pais ClientePais,
  Cte.CodigoPostal ClienteCodigoPostal,
  RTRIM(ISNULL(Cte.Direccion,'') + ' ' + ISNULL(Cte.DireccionNumero,'') + ' ' + ISNULL(Cte.DireccionNumeroInt,'')) + ', ' + ISNULL(Cte.Colonia,'') ClienteDireccion,

  YEAR(CFDFolio.fechaAprobacion) CFDanoAprobacion,
  CFDFolio.noAprobacion CFDnoAprobacion,
  LOWER(mt.CFD_TipoDeComprobante) CorteTipoComprobante
    
  FROM Corte
  JOIN Empresa  ON Corte.Empresa = Empresa.Empresa
  JOIN Sucursal ON Corte.Sucursal = Sucursal.Sucursal
  JOIN Cte		ON Corte.CorteCuentaTipo = 'Cliente' AND Cte.Cliente BETWEEN Corte.CorteCuentaDe AND Corte.CorteCuentaA
  JOIN MovTipo mt ON mt.Mov = Corte.Mov AND mt.Modulo = 'CORTE' 
  LEFT OUTER JOIN CFDFolio ON CFDFolio.Empresa = Corte.Empresa 
       AND CFDFolio.Modulo = mt.ConsecutivoModulo
       AND CFDFolio.Mov = mt.ConsecutivoMov
       AND CFDFolio.FechaAprobacion <= Corte.FechaRegistro 
       AND dbo.fnFolioConsecutivo(Corte.MovID) BETWEEN CFDFolio.FolioD AND CFDFolio.FolioA  
       AND ISNULL(dbo.fnSerieConsecutivo(Corte.MovID),'') = ISNULL(CFDFolio.Serie,'')
       --AND Venta.Sucursal = ISNULL(ISNULL(CFDFolio.Sucursal,0),Venta.Sucursal)
       AND (CASE WHEN ISNULL(CFDFolio.Nivel,'') = 'Sucursal' THEN ISNULL(CFDFolio.Sucursal,0) ELSE Corte.Sucursal END) = Corte.Sucursal
       AND CFDFolio.Estatus = 'ALTA'	      
  LEFT OUTER JOIN CFD ON CFD.ModuloID = Corte.ID AND CFD.Modulo = 'CORTE'       
GO

/***************** CFDCorteD *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDCorteD') AND TYPE = 'V') DROP VIEW CFDCorteD
GO
CREATE VIEW CFDCorteD AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CorteD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,CorteD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,CorteD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,CorteD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,CorteD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,CorteD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion,
  CorteD. Cuenta CorteCliente,
  CorteD.ID, 
  CorteD.Mov Movimiento,
  CorteD.MovID MovimientoFolio,
  CorteD.Fecha MovimientoFecha,
  CorteD.Vencimiento MovimientoVencimiento,
  CorteD.Moneda MovimientoMoneda,
  CorteD.Aplica MovimientoAplica,
  CorteD.AplicaID MovimientoAplicaFolio,  
  ISNULL(CorteD.Cargo, 0) MovimientoCargo,
  ISNULL(CorteD.Abono, 0) MovimientoAbono
  FROM CorteD
GO

/**************** fnCFDFlexRegimenFiscal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexRegimenFiscal') DROP FUNCTION fnCFDFlexRegimenFiscal
GO
CREATE FUNCTION fnCFDFlexRegimenFiscal 
	(
	@Empresa			varchar(5),
	@Modulo				varchar(5),
	@Concepto		    varchar(50)

	)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @RegimenFiscal		varchar(30),
    @Descripcion		varchar(100)
    
  SELECT @RegimenFiscal = FiscalRegimen FROM CFDFlexConcepto WHERE Empresa = @Empresa AND Modulo = @Modulo AND Concepto = @Concepto  
  SELECT @Descripcion = Descripcion FROM FiscalRegimen WHERE FiscalRegimen = @RegimenFiscal
  
  IF NULLIF(@Descripcion,'') IS NULL
  BEGIN
    SELECT @RegimenFiscal = FiscalRegimen FROM Empresa WHERE Empresa = @Empresa
    SELECT @Descripcion = ISNULL(Descripcion,FiscalRegimen) FROM FiscalRegimen WHERE FiscalRegimen = @RegimenFiscal
  END
  
  RETURN (@Descripcion)
END
GO

/***************** CFDVentaFiscalRegimen *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaFiscalRegimen') AND TYPE = 'V') 
  DROP VIEW CFDVentaFiscalRegimen
GO
CREATE VIEW CFDVentaFiscalRegimen AS
SELECT  REPLICATE('0', 20 - LEN(RTRIM(LTRIM(CONVERT(varchar, Venta.ID))))) + RTRIM(LTRIM(CONVERT(varchar, Venta.ID)))
        + REPLICATE('0', 12 - LEN(RTRIM(LTRIM(CONVERT(varchar, 20048))))) + RTRIM(LTRIM(CONVERT(varchar, 2048))) + REPLICATE('0', 7 - LEN(RTRIM(LTRIM(CONVERT(varchar, 0)))))
        + RTRIM(LTRIM(CONVERT(varchar, 0))) + REPLICATE(' ', 50 - LEN(RTRIM(LTRIM(CONVERT(varchar, dbo.fnCFDFlexRegimenFiscal(Venta.Empresa, 'VTAS', Venta.Concepto))))))
        + RTRIM(LTRIM(CONVERT(varchar, dbo.fnCFDFlexRegimenFiscal(Venta.Empresa, 'VTAS', Venta.Concepto))))
        OrdenExportacion,
        Venta.ID,
		dbo.fnCFDFlexRegimenFiscal(Venta.Empresa, 'VTAS', Venta.Concepto) EmisorRegimenFiscal
  FROM  Venta
GO

/**************** fneDocVentaFactorPrecio ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocVentaFactorPrecio') DROP FUNCTION fneDocVentaFactorPrecio
GO
CREATE FUNCTION fneDocVentaFactorPrecio
                (
                @ID                      int,
                @Renglon                 float,
                @RenglonSub              int
                )
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado                            float,
    @PrecioOriginal                       float,
    @PrecioSinImpuestos                   float,
    @Empresa                              varchar(5),
    @VentaPreciosImpuestoIncluido         bit,
    @Impuesto1                            float,
    @Impuesto2                            float,
    @Impuestos                            float,
    @Impuesto1Importe                     float,
    @Impuesto2Importe                     float,
    @Impuesto3Importe                     float,
    @ImpuestosImporte                     float,
    @Impuesto2BaseImpuesto1               bit,
    @DescuentosLineales                   float,
    @Impuesto2Info                        bit,
    @Impuesto3Info                        BIT,
    @ImporteSobrePrecio                          float
   
 
  SELECT @Empresa = Empresa FROM Venta WHERE ID = @ID 
  SELECT @VentaPreciosImpuestoIncluido = ISNULL(VentaPreciosImpuestoIncluido,0) FROM EmpresaCfg WHERE Empresa = @Empresa
 
SELECT
   @Impuesto2BaseImpuesto1 = ISNULL(Impuesto2BaseImpuesto1,0),
   @Impuesto2Info = ISNULL(Impuesto2Info,0),
   @Impuesto3Info = ISNULL(Impuesto3Info,0)
   FROM Version 
 
SELECT
   @PrecioOriginal = ISNULL(Precio,0.0),
   @Impuesto1 = ISNULL(Impuesto1,0.0),
   @Impuesto2 = CASE WHEN @Impuesto2Info = 0 THEN ISNULL(Impuesto2,0.0) ELSE 0.0 END,
   @Impuesto3Importe = CASE WHEN @Impuesto3Info = 0 THEN ISNULL(Impuesto3,0.0) ELSE 0.0 END,
   @DescuentosLineales = (ISNULL(DescuentosTotales,0.0)-ISNULL(ImporteDescuentoGlobal,0.0))/ISNULL(Cantidad,0.0),
   @ImporteSobrePrecio = ISNULL(ImporteSobrePrecio,0.0)/ISNULL(Cantidad,0.0)
   FROM VentaTCalc
  WHERE ID = @ID
    AND Renglon = @Renglon
    AND RenglonSub = @RenglonSub
 
IF @VentaPreciosImpuestoIncluido = 1
BEGIN  
   IF @Impuesto2BaseImpuesto1 = 1
   BEGIN
     SET @PrecioSinImpuestos = @PrecioOriginal - @DescuentosLineales
     SET @PrecioSinImpuestos = @PrecioSinImpuestos - @Impuesto3Importe
     SET @PrecioSinImpuestos = @PrecioSinImpuestos / (1 + (ISNULL(@Impuesto1,0.0)/100.0))
     SET @PrecioSinImpuestos = @PrecioSinImpuestos / (1 + (ISNULL(@Impuesto2,0.0)/100.0))
     SET @PrecioSinImpuestos = @PrecioSinImpuestos + @DescuentosLineales + @ImporteSobrePrecio
   END ELSE
   BEGIN
     SET @PrecioSinImpuestos = @PrecioOriginal - @DescuentosLineales 
     SET @Impuestos = (@Impuesto1/100.0) + (@Impuesto2/100.0)
     SET @PrecioSinImpuestos = (@PrecioSinImpuestos / ( 1 + @Impuestos) )  + @DescuentosLineales + @ImporteSobrePrecio
 
   END
 
END
ELSE
BEGIN
   SET @PrecioSinImpuestos = @PrecioOriginal + @ImporteSobrePrecio
END       
 IF ISNULL(@PrecioOriginal,0.0) = 0.0
   SET @Resultado = 0.0
 ELSE
   SET @Resultado = ISNULL(@PrecioSinImpuestos,0.0) / ISNULL(@PrecioOriginal,0.0)     
 
 RETURN (@Resultado)
END
GO

/***************** CFDVentaD *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaD') AND TYPE = 'V') 
  DROP VIEW CFDVentaD
GO
CREATE VIEW CFDVentaD AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion,
  Venta.Cliente VentaCliente,
  VentaD.ID, 
  VentaD.Cantidad - ISNULL(VentaD.CantidadObsequio,0.0) VentaDCantidad,
  VentaD.CantidadInventario VentaDCantidadInventario,
  VentaD.Unidad VentaDUnidad,
  Unidad.Clave UnidadClave,
  VentaD.Articulo VentaDArticulo,
  dbo.fnQueCodigo(EmpresaCFD.EAN13, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) EAN13,
  dbo.fnQueCodigo(EmpresaCFD.SKU, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) SKUCliente,
  dbo.fnQueCodigo(EmpresaCFD.SKUEmpresa, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) SKUEmpresa,
  dbo.fnQueCodigo(EmpresaCFD.DUN14, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) DUN14,
  Art.Descripcion1 VentaDDescripcion,
  Art.Descripcion2 VentaDDescripcion2,
  Art.TipoEmpaque ArtTipoEmpaque,
  CASE WHEN  Ecfg.VentaPrecioMoneda =1 then 
	CASE WHEN Vtc.Precio IS NULL THEN 0.0 ELSE(( (Vtc.Precio*dbo.fneDocVentaFactorPrecio(VentaD.ID, VentaD.Renglon, VentaD.RenglonSub))* ISNULL(VentaD.PrecioTipoCambio,1.0))/Venta.TipoCambio)* dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) END 
  ELSE  
	CASE WHEN Vtc.Precio IS NULL THEN 0.0 ELSE( (Vtc.Precio*dbo.fneDocVentaFactorPrecio(VentaD.ID, VentaD.Renglon, VentaD.RenglonSub)))* dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) END 
  END  VentaDPrecio ,
  CASE WHEN  Ecfg.VentaPrecioMoneda =1 then 
	 CASE WHEN Vtc.PrecioTotal IS NULL THEN 0.0 ELSE (((Vtc.PrecioTotal*dbo.fneDocVentaFactorPrecio(VentaD.ID, VentaD.Renglon, VentaD.RenglonSub))*ISNULL(VentaD.PrecioTipoCambio,1.0))/Venta.TipoCambio)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) END 
  ELSE  
	CASE WHEN Vtc.PrecioTotal IS NULL THEN 0.0 ELSE ((Vtc.PrecioTotal*dbo.fneDocVentaFactorPrecio(VentaD.ID, VentaD.Renglon, VentaD.RenglonSub)))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) END 
  END  VentaDPrecioTotal,
  Vtc.DescuentoLinea*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDDescuentoLinea,
  VentaD.DescuentoImporte*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDDescuentoImporte,
  vtc.Impuesto1 ventaDImpuesto1, 
  vtc.Impuesto2 ventaDImpuesto2, 
  vtc.Importe*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImporte,
  (Vtc.Importe/Vtc.Cantidad)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImporteUnitario,
  vtc.DescuentoLineal*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDDescLineal,
  vtc.DescuentosTotales*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDDescuentosTotales,
  vtc.ImporteSobrePrecio*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImporteSobrePrecio,
  vtc.SubTotal*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDSubTotal,
  (vtc.SubTotal/Vtc.Cantidad)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDSubTotalUnitario,
  vtc.Impuesto1Total*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImpuesto1Total,
  vtc.Impuesto2Total*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImpuesto2Total,
  vtc.Impuestos*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImpuestos,
  vtc.ImporteTotal*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImporteTotal,
  vtc.TotalNeto*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDTotalNeto,  
  TipoEmpaque.Clave TipoEmpaqueClave,
  TipoEmpaque.Tipo TipoEmpaqueTipo,

  VentaD.Renglon VentaDRenglon,
  VentaD.RenglonSub VentaDRenglonSub,
  VentaD.RenglonID VentaDRenglonID,
  VentaD.RenglonTipo VentaDRenglonTipo,
  VentaD.Almacen VentaDAlmacen,
  VentaD.EnviarA VentaDEnviarA,
  VentaD.Codigo VentaDCodigo,
  VentaD.SubCuenta VentaDSubCuenta,
  VentaD.PrecioSugerido VentaDPrecioSugerido,
  VentaD.DescuentoTipo VentaDDescuentoTipo,
  VentaD.Impuesto3 VentaDImpuesto3,
  VentaD.DescripcionExtra VentaDDescripcionExtra,
  VentaD.Costo VentaDCosto,
  VentaD.CostoActividad VentaDCostoActividad,
  VentaD.Paquete VentaDPaquete,
  VentaD.ContUso VentaDContUso,
  VentaD.Comision VentaDComision,
  VentaD.Aplica VentaDAplica,
  VentaD.AplicaID VentaDAplicaID,
  VentaD.CantidadPendiente VentaDCantidadPendiente,
  VentaD.CantidadReservada VentaDCantidadReservada,
  VentaD.CantidadCancelada VentaDCantidadCancelada,
  VentaD.CantidadOrdenada VentaDCantidadOrdenada,
  VentaD.CantidadEmbarcada VentaDCantidadEmbarcada,
  VentaD.CantidadA VentaDCantidadA,
  VentaD.Factor VentaDFactor,
  VentaD.SustitutoArticulo VentaDSustitutoArticulo,
  VentaD.SustitutoSubCuenta VentaDSustitutoSubCuenta,
  VentaD.FechaRequerida VentaDFechaRequerida,
  VentaD.HoraRequerida VentaDHoraRequerida,
  VentaD.Instruccion VentaDInstruccion,
  VentaD.Agente VentaDAgente,
  VentaD.Departamento VentaDDepartamento,
  VentaD.UltimoReservadoCantidad VentaDUltimoReservadoCantidad,
  VentaD.UltimoReservadoFecha VentaDUltimoReservadoFecha,
  VentaD.Sucursal VentaDSucursal,
  VentaD.PoliticaPrecios VentaDPoliticaPrecios,
  VentaD.SucursalOrigen VentaDSucursalOrigen,
  VentaD.AutoLocalidad VentaDAutoLocalidad,
  VentaD.UEN VentaDUEN,
  VentaD.Espacio VentaDEspacio,
  VentaD.CantidadAlterna VentaDCantidadAlterna,
  VentaD.PrecioMoneda VentaDPrecioMoneda,
  VentaD.PrecioTipoCambio VentaDPrecioTipoCambio,
  VentaD.Estado VentaDEstado,
  VentaD.ServicioNumero VentaDServicioNumero,
  VentaD.AgentesAsignados VentaDAgentesAsignados,
  VentaD.AFArticulo VentaDAFArticulo,
  VentaD.ExcluirPlaneacion VentaDExcluirPlaneacion,
  VentaD.Anexo VentaDAnexo,
  VentaD.AjusteCosteo VentaDAjusteCosteo,
  VentaD.CostoUEPS VentaDCostoUEPS,
  VentaD.CostoPEPS VentaDCostoPEPS,
  VentaD.UltimoCosto VentaDUltimoCosto,
  VentaD.PrecioLista VentaDPrecioLista,
  VentaD.DepartamentoDetallista VentaDDepartamentoDetallista,
  VentaD.PresupuestoEsp VentaDPresupuestoEsp,
  VentaD.Posicion VentaDPosicion,
  VentaD.Puntos VentaDPuntos,
  VentaD.CantidadObsequio VentaDCantidadObsequio,
  VentaD.OfertaID VentaDOfertaID,
  VentaD.ProveedorRef VentaDProveedorRef,
  VentaD.TransferirA VentaDTransferirA,
  VentaD.ArtEstatus VentaDArtEstatus,
  VentaD.ArtSituacion VentaDArtSituacion,
  VentaD.Tarima VentaDTarima,
  VentaD.ExcluirISAN VentaDExcluirISAN,
  VentaD.ContUso2 VentaDContUso2,
  VentaD.ContUso3 VentaDContUso3,
  VentaD.CostoEstandar VentaDCostoEstandar,
  VentaD.ABC VentaDABC,
  VentaD.OrdenCompra VentaDOrdenCompra,
  VentaD.TipoImpuesto1 VentaDTipoImpuesto1,
  VentaD.TipoImpuesto2 VentaDTipoImpuesto2,
  VentaD.TipoImpuesto3 VentaDTipoImpuesto3,
  VentaD.CostoPromedio VentaDCostoPromedio,
  VentaD.CostoReposicion VentaDCostoReposicion,
  VentaD.TipoComprobante VentaDTipoComprobante,
  VentaD.SustentoComprobante VentaDSustentoComprobante,
  VentaD.TipoIdentificacion VentaDTipoIdentificacion,
  VentaD.DerechoDevolucion VentaDDerechoDevolucion,
  VentaD.Establecimiento VentaDEstablecimiento,
  VentaD.PuntoEmision VentaDPuntoEmision,
  VentaD.SecuencialSRI VentaDSecuencialSRI,
  VentaD.AutorizacionSRI VentaDAutorizacionSRI,
  VentaD.VigenteA VentaDVigenteA,
  VentaD.SecuenciaRetencion VentaDSecuenciaRetencion,
  VentaD.Comprobante VentaDComprobante,
  VentaD.FechaContableMov VentaDFechaContableMov,
  VentaD.TipoRetencion1 VentaDTipoRetencion1,
  VentaD.TipoRetencion2 VentaDTipoRetencion2,
  VentaD.TipoRetencion3 VentaDTipoRetencion3,
  VentaD.Retencion1 VentaDRetencion1,
  VentaD.Retencion2 VentaDRetencion2,
  VentaD.Retencion3 VentaDRetencion3,
  vtc.ImporteDescuentoGlobal VentaDDescuentoGlobal
  FROM VentaD JOIN Art
    ON VentaD.Articulo = Art.Articulo JOIN VentaTCalc vtc
    ON vtc.ID = VentaD.ID AND vtc.Renglon = VentaD.Renglon AND vtc.RenglonSub = VentaD.RenglonSub LEFT OUTER JOIN Unidad 
    ON Unidad.Unidad = VentaD.Unidad LEFT OUTER JOIN ArtProv
    ON ArtProv.Proveedor = Art.Proveedor AND ArtProv.Articulo = Art.Articulo AND ISNULL(ArtProv.SubCuenta,'') = ISNULL(VentaD.SubCuenta,'') JOIN Venta --Modificacion DSG 29/03/2017 Correo
    ON Venta.ID = VentaD.ID LEFT OUTER JOIN EmpresaCFD 
    ON EmpresaCFD.Empresa = Venta.Empresa LEFT OUTER JOIN TipoEmpaque
    ON Art.tipoEmpaque=TipoEmpaque.TipoEmpaque JOIN MovTipo mt
    ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov LEFT OUTER JOIN EmpresaCfg Ecfg 
    ON Ecfg.Empresa = Venta.Empresa
	-- Bug 27233 Se deshabilita condición porque no se podía realizar una factura con anticipo.     
    --WHERE (VentaD.Cantidad - ISNULL(VentaD.CantidadObsequio,0.0) >0)
UNION
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Venta.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Venta.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,'999999999999'))))) + RTRIM(LTRIM(CONVERT(varchar,'999999999999'))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,'0'))))) + RTRIM(LTRIM(CONVERT(varchar,'0'))) +
  REPLICATE(' ',50)
  OrdenExportacion,
  Venta.Cliente VentaCliente,
  Venta.ID, 
  '1' VentaDCantidad,
  NULL AS VentaDCantidadInventario,
  'No Aplica' AS VentaDUnidad,
  NULL AS UnidadClave,
  'ANTICIPO' AS VentaDArticulo,
  NULL AS EAN13,
  NULL AS SKUCliente,
  NULL AS SKUEmpresa,
  NULL AS DUN14,
  'Anticipo Facturado' AS VentaDDescripcion,
  NULL AS VentaDDescripcion2,
  NULL AS ArtTipoEmpaque,
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDPrecio,
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDPrecioTotal,
  NULL AS VentaDDescuentoLinea,
  NULL AS VentaDDescuentoImporte,
  ((AnticiposImpuestos*100/(AnticiposFacturados-AnticiposImpuestos))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS ventaDImpuesto1, 
  NULL AS ventaDImpuesto2, 
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImporte,
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImporteUnitario,
  NULL AS VentaDDescLineal,
  NULL AS VentaDDescuentosTotales,
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImporteSobrePrecio,
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDSubTotal,
  NULL AS VentaDSubTotalUnitario,
  ((AnticiposImpuestos)*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImpuesto1Total,
  NULL AS VentaDImpuesto2Total,
  ((AnticiposImpuestos)*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImpuestos,
  ((AnticiposFacturados)*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImporteTotal,
  ((AnticiposFacturados)*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDTotalNeto,  
  NULL AS TipoEmpaqueClave,
  NULL AS TipoEmpaqueTipo,

  NULL AS VentaDRenglon,
  NULL AS VentaDRenglonSub,
  NULL AS VentaDRenglonID,
  NULL AS VentaDRenglonTipo,
  NULL AS VentaDAlmacen,
  NULL AS VentaDEnviarA,
  NULL AS VentaDCodigo,
  NULL AS VentaDSubCuenta,
  NULL AS VentaDPrecioSugerido,
  NULL AS VentaDDescuentoTipo,
  NULL AS VentaDImpuesto3,
  NULL AS VentaDDescripcionExtra,
  NULL AS VentaDCosto,
  NULL AS VentaDCostoActividad,
  NULL AS VentaDPaquete,
  NULL AS VentaDContUso,
  NULL AS VentaDComision,
  NULL AS VentaDAplica,
  NULL AS VentaDAplicaID,
  NULL AS VentaDCantidadPendiente,
  NULL AS VentaDCantidadReservada,
  NULL AS VentaDCantidadCancelada,
  NULL AS VentaDCantidadOrdenada,
  NULL AS VentaDCantidadEmbarcada,
  NULL AS VentaDCantidadA,
  NULL AS VentaDFactor,
  NULL AS VentaDSustitutoArticulo,
  NULL AS VentaDSustitutoSubCuenta,
  NULL AS VentaDFechaRequerida,
  NULL AS VentaDHoraRequerida,
  NULL AS VentaDInstruccion,
  NULL AS VentaDAgente,
  NULL AS VentaDDepartamento,
  NULL AS VentaDUltimoReservadoCantidad,
  NULL AS VentaDUltimoReservadoFecha,
  NULL AS VentaDSucursal,
  NULL AS VentaDPoliticaPrecios,
  NULL AS VentaDSucursalOrigen,
  NULL AS VentaDAutoLocalidad,
  NULL AS VentaDUEN,
  NULL AS VentaDEspacio,
  NULL AS VentaDCantidadAlterna,
  NULL AS VentaDPrecioMoneda,
  NULL AS VentaDPrecioTipoCambio,
  NULL AS VentaDEstado,
  NULL AS VentaDServicioNumero,
  NULL AS VentaDAgentesAsignados,
  NULL AS VentaDAFArticulo,
  NULL AS VentaDExcluirPlaneacion,
  NULL AS VentaDAnexo,
  NULL AS VentaDAjusteCosteo,
  NULL AS VentaDCostoUEPS,
  NULL AS VentaDCostoPEPS,
  NULL AS VentaDUltimoCosto,
  NULL AS VentaDPrecioLista,
  NULL AS VentaDDepartamentoDetallista,
  NULL AS VentaDPresupuestoEsp,
  NULL AS VentaDPosicion,
  NULL AS VentaDPuntos,
  NULL AS VentaDCantidadObsequio,
  NULL AS VentaDOfertaID,
  NULL AS VentaDProveedorRef,
  NULL AS VentaDTransferirA,
  NULL AS VentaDArtEstatus,
  NULL AS VentaDArtSituacion,
  NULL AS VentaDTarima,
  NULL AS VentaDExcluirISAN,
  NULL AS VentaDContUso2,
  NULL AS VentaDContUso3,
  NULL AS VentaDCostoEstandar,
  NULL AS VentaDABC,
  NULL AS VentaDOrdenCompra,
  NULL AS VentaDTipoImpuesto1,
  NULL AS VentaDTipoImpuesto2,
  NULL AS VentaDTipoImpuesto3,
  NULL AS VentaDCostoPromedio,
  NULL AS VentaDCostoReposicion,
  NULL AS VentaDTipoComprobante,
  NULL AS VentaDSustentoComprobante,
  NULL AS VentaDTipoIdentificacion,
  NULL AS VentaDDerechoDevolucion,
  NULL AS VentaDEstablecimiento,
  NULL AS VentaDPuntoEmision,
  NULL AS VentaDSecuencialSRI,
  NULL AS VentaDAutorizacionSRI,
  NULL AS VentaDVigenteA,
  NULL AS VentaDSecuenciaRetencion,
  NULL AS VentaDComprobante,
  NULL AS VentaDFechaContableMov,
  NULL AS VentaDTipoRetencion1,
  NULL AS VentaDTipoRetencion2,
  NULL AS VentaDTipoRetencion3,
  NULL AS VentaDRetencion1,
  NULL AS VentaDRetencion2,
  NULL AS VentaDRetencion3,
  NULL AS VentaDDescuentoGlobal  
  FROM Venta 
  JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
  JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
 WHERE AnticiposFacturados IS NOT NULL
-- AND RenglonTipo NOT IN ('J','C')
 UNION
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Ventad.Renglon+'90000000'))))) + RTRIM(LTRIM(CONVERT(varchar,Ventad.Renglon+'90000000'))) +
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion,
  Venta.Cliente VentaCliente,
  VentaD.ID, 
  VentaD.CantidadObsequio VentaDCantidad,
  VentaD.CantidadInventario VentaDCantidadInventario,
  VentaD.Unidad VentaDUnidad,
  Unidad.Clave UnidadClave,
  VentaD.Articulo VentaDArticulo,
  dbo.fnQueCodigo(EmpresaCFD.EAN13, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) EAN13,
  dbo.fnQueCodigo(EmpresaCFD.SKU, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) SKUCliente,
  dbo.fnQueCodigo(EmpresaCFD.SKUEmpresa, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) SKUEmpresa,
  dbo.fnQueCodigo(EmpresaCFD.DUN14, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) DUN14,
  Art.Descripcion1 VentaDDescripcion,
  Art.Descripcion2 VentaDDescripcion2,
  Art.TipoEmpaque ArtTipoEmpaque,
  0.0 VentaDPrecio ,
  0.0 VentaDPrecioTotal,
  0.0 VentaDDescuentoLinea,
  0.0 VentaDDescuentoImporte,
  vtc.Impuesto1 ventaDImpuesto1, 
  vtc.Impuesto2 ventaDImpuesto2, 
  0.0 VentaDImporte,
  0.0 VentaDImporteUnitario,
  0.0 VentaDDescLineal,
  0.0 VentaDDescuentosTotales,
  0.0 VentaDImporteSobrePrecio,
  0.0 VentaDSubTotal,
  0.0 VentaDSubTotalUnitario,
  0.0 VentaDImpuesto1Total,
  0.0 VentaDImpuesto2Total,
  0.0 VentaDImpuestos,
  0.0 VentaDImporteTotal,
  0.0 VentaDTotalNeto,  
  TipoEmpaque.Clave TipoEmpaqueClave,
  TipoEmpaque.Tipo TipoEmpaqueTipo,

  VentaD.Renglon VentaDRenglon,
  VentaD.RenglonSub VentaDRenglonSub,
  VentaD.RenglonID VentaDRenglonID,
  VentaD.RenglonTipo VentaDRenglonTipo,
  VentaD.Almacen VentaDAlmacen,
  VentaD.EnviarA VentaDEnviarA,
  VentaD.Codigo VentaDCodigo,
  VentaD.SubCuenta VentaDSubCuenta,
  VentaD.PrecioSugerido VentaDPrecioSugerido,
  VentaD.DescuentoTipo VentaDDescuentoTipo,
  VentaD.Impuesto3 VentaDImpuesto3,
  VentaD.DescripcionExtra VentaDDescripcionExtra,
  VentaD.Costo VentaDCosto,
  VentaD.CostoActividad VentaDCostoActividad,
  VentaD.Paquete VentaDPaquete,
  VentaD.ContUso VentaDContUso,
  VentaD.Comision VentaDComision,
  VentaD.Aplica VentaDAplica,
  VentaD.AplicaID VentaDAplicaID,
  VentaD.CantidadPendiente VentaDCantidadPendiente,
  VentaD.CantidadReservada VentaDCantidadReservada,
  VentaD.CantidadCancelada VentaDCantidadCancelada,
  VentaD.CantidadOrdenada VentaDCantidadOrdenada,
  VentaD.CantidadEmbarcada VentaDCantidadEmbarcada,
  VentaD.CantidadA VentaDCantidadA,
  VentaD.Factor VentaDFactor,
  VentaD.SustitutoArticulo VentaDSustitutoArticulo,
  VentaD.SustitutoSubCuenta VentaDSustitutoSubCuenta,
  VentaD.FechaRequerida VentaDFechaRequerida,
  VentaD.HoraRequerida VentaDHoraRequerida,
  VentaD.Instruccion VentaDInstruccion,
  VentaD.Agente VentaDAgente,
  VentaD.Departamento VentaDDepartamento,
  VentaD.UltimoReservadoCantidad VentaDUltimoReservadoCantidad,
  VentaD.UltimoReservadoFecha VentaDUltimoReservadoFecha,
  VentaD.Sucursal VentaDSucursal,
  VentaD.PoliticaPrecios VentaDPoliticaPrecios,
  VentaD.SucursalOrigen VentaDSucursalOrigen,
  VentaD.AutoLocalidad VentaDAutoLocalidad,
  VentaD.UEN VentaDUEN,
  VentaD.Espacio VentaDEspacio,
  VentaD.CantidadAlterna VentaDCantidadAlterna,
  VentaD.PrecioMoneda VentaDPrecioMoneda,
  VentaD.PrecioTipoCambio VentaDPrecioTipoCambio,
  VentaD.Estado VentaDEstado,
  VentaD.ServicioNumero VentaDServicioNumero,
  VentaD.AgentesAsignados VentaDAgentesAsignados,
  VentaD.AFArticulo VentaDAFArticulo,
  VentaD.ExcluirPlaneacion VentaDExcluirPlaneacion,
  VentaD.Anexo VentaDAnexo,
  VentaD.AjusteCosteo VentaDAjusteCosteo,
  VentaD.CostoUEPS VentaDCostoUEPS,
  VentaD.CostoPEPS VentaDCostoPEPS,
  VentaD.UltimoCosto VentaDUltimoCosto,
  VentaD.PrecioLista VentaDPrecioLista,
  VentaD.DepartamentoDetallista VentaDDepartamentoDetallista,
  VentaD.PresupuestoEsp VentaDPresupuestoEsp,
  VentaD.Posicion VentaDPosicion,
  VentaD.Puntos VentaDPuntos,
  VentaD.CantidadObsequio VentaDCantidadObsequio,
  VentaD.OfertaID VentaDOfertaID,
  VentaD.ProveedorRef VentaDProveedorRef,
  VentaD.TransferirA VentaDTransferirA,
  VentaD.ArtEstatus VentaDArtEstatus,
  VentaD.ArtSituacion VentaDArtSituacion,
  VentaD.Tarima VentaDTarima,
  VentaD.ExcluirISAN VentaDExcluirISAN,
  VentaD.ContUso2 VentaDContUso2,
  VentaD.ContUso3 VentaDContUso3,
  VentaD.CostoEstandar VentaDCostoEstandar,
  VentaD.ABC VentaDABC,
  VentaD.OrdenCompra VentaDOrdenCompra,
  VentaD.TipoImpuesto1 VentaDTipoImpuesto1,
  VentaD.TipoImpuesto2 VentaDTipoImpuesto2,
  VentaD.TipoImpuesto3 VentaDTipoImpuesto3,
  VentaD.CostoPromedio VentaDCostoPromedio,
  VentaD.CostoReposicion VentaDCostoReposicion,
  VentaD.TipoComprobante VentaDTipoComprobante,
  VentaD.SustentoComprobante VentaDSustentoComprobante,
  VentaD.TipoIdentificacion VentaDTipoIdentificacion,
  VentaD.DerechoDevolucion VentaDDerechoDevolucion,
  VentaD.Establecimiento VentaDEstablecimiento,
  VentaD.PuntoEmision VentaDPuntoEmision,
  VentaD.SecuencialSRI VentaDSecuencialSRI,
  VentaD.AutorizacionSRI VentaDAutorizacionSRI,
  VentaD.VigenteA VentaDVigenteA,
  VentaD.SecuenciaRetencion VentaDSecuenciaRetencion,
  VentaD.Comprobante VentaDComprobante,
  VentaD.FechaContableMov VentaDFechaContableMov,
  NULL AS VentaDTipoRetencion1,
  NULL AS VentaDTipoRetencion2,
  NULL AS VentaDTipoRetencion3,
  NULL AS VentaDRetencion1,
  NULL AS VentaDRetencion2,
  NULL AS VentaDRetencion3,
  vtc.ImporteDescuentoGlobal VentaDDescuentoGlobal
  FROM VentaD JOIN Art
    ON VentaD.Articulo = Art.Articulo JOIN VentaTCalc vtc
    ON vtc.ID = VentaD.ID AND vtc.Renglon = VentaD.Renglon AND vtc.RenglonSub = VentaD.RenglonSub LEFT OUTER JOIN Unidad 
    ON Unidad.Unidad = VentaD.Unidad LEFT OUTER JOIN ArtProv
    ON ArtProv.Proveedor = Art.Proveedor AND ArtProv.Articulo = Art.Articulo AND ISNULL(ArtProv.SubCuenta,'') = ISNULL(VentaD.SubCuenta,'') JOIN Venta --Modificacion DSG 29/03/2017 Correo
    ON Venta.ID = VentaD.ID LEFT OUTER JOIN EmpresaCFD 
    ON EmpresaCFD.Empresa = Venta.Empresa LEFT OUTER JOIN TipoEmpaque
    ON Art.tipoEmpaque=TipoEmpaque.TipoEmpaque JOIN MovTipo mt
    ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov LEFT OUTER JOIN EmpresaCfg Ecfg 
    ON Ecfg.Empresa = Venta.Empresa
  WHERE VentaD.CantidadObsequio >= 1
 
GO



--select * from VentaTCalc where ID = 15441
--select proveedor,articulo,* from artprov

/***************** CFDVentaDMovImpuesto *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDMovImpuesto') AND TYPE = 'V') 
  DROP VIEW CFDVentaDMovImpuesto
GO
CREATE VIEW CFDVentaDMovImpuesto AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  'IMPUESTO1' + REPLICATE(' ',50 - LEN('IMPUESTO1'))
  OrdenExportacion,
  VentaD.ID, 
  'VAT' VentaDImpuestoClave,
  ISNULL(VentaD.Impuesto1,0.0) VentaDImpuestoTasa,
  CASE WHEN ISNULL(VentaD.Impuesto1,0.0) > 0.0 THEN (VentaD.Precio*(ISNULL(VentaD.Impuesto1,0.0)/100.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) ELSE 0.0 END VentaDImpuestoImporte,
  'TRANSFERIDO' VentaDCategoriaImpuesto
  FROM VentaD
JOIN Venta ON VentaD.ID = Venta.ID
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
UNION ALL  
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  'IMPUESTO2' + REPLICATE(' ',50 - LEN('IMPUESTO2'))
  OrdenExportacion,
  VentaD.ID, 
  'GST' VentaDImpuestoClave,
  ISNULL(VentaD.Impuesto2,0.0) VentaDImpuestoTasa,
  CASE WHEN ISNULL(VentaD.Impuesto2,0.0) > 0.0 THEN (VentaD.Precio/(ISNULL(VentaD.Impuesto2,0.0)/100.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) ELSE 0.0 END VentaDImpuestoImporte,
  'TRANSFERIDO' VentaDCategoriaImpuesto  
  FROM VentaD  
JOIN Venta ON VentaD.ID = Venta.ID
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
GO

/***************** CFDVentaMovImpuesto *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaMovImpuesto') AND TYPE = 'V') 
  DROP VIEW CFDVentaMovImpuesto
GO
CREATE VIEW CFDVentaMovImpuesto AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  MovImpuesto.ModuloID ID,
  CONVERT(varchar(50),'IVA') Impuesto,
  CONVERT(varchar(50),'VAT') ImpuestoClave,
  ISNULL(MovImpuesto.Impuesto1,0.00) Tasa,
  SUM(ISNULL(MovImpuesto.Importe1,0.00)*ISNULL(dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)),0.00)) Importe,
  'TRANSFERIDO' CategoriaImpuesto     
  FROM MovImpuesto
JOIN Venta ON MovImpuesto.Modulo = 'VTAS' AND MovImpuesto.ModuloId = Venta.ID
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
 WHERE MovImpuesto.Modulo = 'VTAS'
   AND ISNULL(MovImpuesto.Excento1,0) <> 1
 GROUP BY MovImpuesto.ModuloID, MovImpuesto.Impuesto1
UNION ALL   
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  MovImpuesto.ModuloID ID,
  CONVERT(varchar(50),'IEPS') Impuesto,
  CONVERT(varchar(50),'GST') ImpuestoClave,
  ISNULL(MovImpuesto.Impuesto2,0.00) Tasa,
  SUM(ISNULL(MovImpuesto.Importe2,0.00)*ISNULL(dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)),0.00)) Importe,
  'TRANSFERIDO' CategoriaImpuesto      
  FROM MovImpuesto
JOIN Venta ON MovImpuesto.Modulo = 'VTAS' AND MovImpuesto.ModuloId = Venta.ID
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
 WHERE MovImpuesto.Modulo = 'VTAS'
   AND ISNULL(MovImpuesto.Excento2,0) <> 1 and MovImpuesto.Impuesto2>0.00
 GROUP BY MovImpuesto.ModuloID, MovImpuesto.Impuesto2
  UNION ALL   
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  MovImpuesto.ModuloID ID,
  CONVERT(varchar(50),'IEPS') Impuesto,
  CONVERT(varchar(50),'GST') ImpuestoClave,
  ISNULL(MovImpuesto.Impuesto3,0.00) Tasa,
  SUM(ISNULL(MovImpuesto.Importe3,0.00)*ISNULL(dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)),0.00)) Importe,
  'TRANSFERIDO' CategoriaImpuesto      
  FROM MovImpuesto
JOIN Venta ON MovImpuesto.Modulo = 'VTAS' AND MovImpuesto.ModuloId = Venta.ID
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
 WHERE MovImpuesto.Modulo = 'VTAS'
   AND ISNULL(MovImpuesto.Excento3,0) <> 1 and MovImpuesto.Impuesto3>0.00
 GROUP BY MovImpuesto.ModuloID, MovImpuesto.Impuesto3
GO

/***************** CFDVentaMovRetencion *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaMovRetencion') AND TYPE = 'V') 
  DROP VIEW CFDVentaMovRetencion
GO
CREATE VIEW CFDVentaMovRetencion AS
SELECT
  'OrdenExportacion'	= REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
						  REPLICATE(' ',12) + 
                          REPLICATE(' ',7) +
                          REPLICATE(' ',50),   
  'ID'					= MovImpuesto.ModuloID,
  'Impuesto'			= CONVERT(varchar(50),'ISR'),
  'ImpuestoClave'		= CONVERT(varchar(50),'GST'),
  'Tasa'				= ISNULL(MovImpuesto.Retencion1,0.00),
  'Importe'				= SUM((ISNULL(MovImpuesto.Retencion1,0.00)/100* ISNULL(MovImpuesto.SubTotal,0.00))*ISNULL(dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)),0.00)),
  'CategoriaImpuesto'	= 'RETENIDO'
FROM MovImpuesto
JOIN Venta ON MovImpuesto.Modulo = 'VTAS' AND MovImpuesto.ModuloId = Venta.ID
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN cte ON Cte.cliente = Venta.Cliente
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
 WHERE MovImpuesto.Modulo = 'VTAS'
   AND NULLIF(MovImpuesto.Retencion1,0.0) IS NOT NULL    
   AND NULLIF(Venta.Retencion,0.0) IS NOT NULL
   AND ISNULL(MovImpuesto.Excento1,0) <> 1
 GROUP BY MovImpuesto.ModuloID, MovImpuesto.Retencion1   
UNION ALL
SELECT
  'OrdenExportacion'	= REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
						  REPLICATE(' ',12) + 
                          REPLICATE(' ',7) +
                          REPLICATE(' ',50),   
  'ID'					= MovImpuesto.ModuloID,
  'Impuesto'			= CONVERT(varchar(50),'IVA'),
  'ImpuestoClave'		= CONVERT(varchar(50),'VAT'),
  'Tasa'				= ISNULL(MovImpuesto.Retencion2,0.00),
  'Importe'				= SUM((CASE WHEN ISNULL(v.Retencion2BaseImpuesto1,0) = 0 THEN ISNULL(MovImpuesto.SubTotal*(MovImpuesto.Retencion2/100.0), 0.0) ELSE ISNULL(MovImpuesto.Importe1*(MovImpuesto.Retencion2/100.0),0.0) END)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN))),
  'CategoriaImpuesto'	= 'RETENIDO'
FROM MovImpuesto
JOIN Venta ON MovImpuesto.Modulo = 'VTAS' AND MovImpuesto.ModuloId = Venta.ID
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN cte ON Cte.cliente = Venta.Cliente
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
JOIN version v ON 1 = 1
 WHERE MovImpuesto.Modulo = 'VTAS'
   AND NULLIF(MovImpuesto.Retencion2,0.0) IS NOT NULL    
   AND NULLIF(Venta.Retencion,0.0) IS NOT NULL
   AND ISNULL(MovImpuesto.Excento2,0) <> 1
 GROUP BY MovImpuesto.ModuloID, MovImpuesto.Retencion2   
GO

/**************** fnCFDVentaMovImpuestoExcento ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDVentaMovImpuestoExcento') DROP FUNCTION fnCFDVentaMovImpuestoExcento
GO
CREATE FUNCTION fnCFDVentaMovImpuestoExcento (@ID int, @Impuestos float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado 	float

  IF NOT EXISTS(SELECT * FROM CFDVentaMovImpuesto WHERE ID = @ID)
    SELECT @Resultado = NULL
  ELSE
  SELECT @Resultado = ISNULL(@Impuestos,0)
  
  RETURN (@Resultado)
END
GO

/**************** fnCFDVentaMovRetencionExcento ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDVentaMovRetencionExcento') DROP FUNCTION fnCFDVentaMovRetencionExcento
GO
CREATE FUNCTION fnCFDVentaMovRetencionExcento (@ID int, @Retenciones float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado 	float

  IF NOT EXISTS(SELECT * FROM CFDVentaMovRetencion WHERE ID = @ID)
    SELECT @Resultado = NULL
  ELSE
  SELECT @Resultado = ISNULL(@Retenciones,0)
  
  RETURN (@Resultado)
END
GO


/***************** CFDVentaDExt *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDExt') AND TYPE = 'V') 
  DROP VIEW CFDVentaDExt
GO
CREATE VIEW CFDVentaDExt AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion,
  VentaD.ID, 
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE VentaD.Cantidad - ISNULL(VentaD.CantidadObsequio,0.0) END VentaDCantidad,
  VentaD.CantidadInventario VentaDCantidadInventario,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE Unidad.Clave END VentaDUnidad,
  Unidad.Clave UnidadClave,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE VentaD.Articulo END VentaDArticulo,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE CONVERT(DECIMAL(20,2), dbo.fnVentaDTotalUSD(Venta.Moneda, (vtc.Importe/( VentaD.Cantidad - ISNULL(VentaD.CantidadObsequio,0.0))))) END VentaDPrecio ,

  VentaD.Renglon VentaDRenglon,
  VentaD.RenglonSub VentaDRenglonSub,
  VentaD.RenglonID VentaDRenglonID,
  VentaD.RenglonTipo VentaDRenglonTipo,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE sart.FraccionArancelaria END sartFraccionArancelaria,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE sart.Marca END sartMarca,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE sart.Modelo END sartModelo,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE sart.SubModelo END sartSubModelo,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE SerieLoteMov.SerieLote END SerieLote,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE 
      CONVERT(DECIMAL(20,2), (VentaD.Cantidad - ISNULL(VentaD.CantidadObsequio,0.0)) * 
	  CONVERT(DECIMAL(20,2), dbo.fnVentaDTotalUSD(Venta.Moneda, (vtc.Importe/( VentaD.Cantidad - ISNULL(VentaD.CantidadObsequio,0.0)))))) END VentaDTotalUSD
  FROM VentaD JOIN Art
    ON VentaD.Articulo = Art.Articulo JOIN VentaTCalc vtc
    ON vtc.ID = VentaD.ID AND vtc.Renglon = VentaD.Renglon AND vtc.RenglonSub = VentaD.RenglonSub LEFT OUTER JOIN Unidad 
    ON Unidad.Unidad = VentaD.Unidad LEFT OUTER JOIN ArtProv
    ON ArtProv.Proveedor = Art.Proveedor AND ArtProv.Articulo = Art.Articulo JOIN Venta
    ON Venta.ID = VentaD.ID LEFT OUTER JOIN EmpresaCFD 
    ON EmpresaCFD.Empresa = Venta.Empresa LEFT OUTER JOIN TipoEmpaque
    ON Art.tipoEmpaque=TipoEmpaque.TipoEmpaque JOIN MovTipo mt
    ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov LEFT OUTER JOIN EmpresaCfg Ecfg 
    ON Ecfg.Empresa = Venta.Empresa LEFT OUTER JOIN SATArticuloInfo sart
	ON VentaD.Articulo = sart.Articulo LEFT OUTER JOIN SerieLoteMov 
	ON SerieLoteMov.ID = VentaD.ID AND SerieLoteMov.RenglonID = VentaD.RenglonID LEFT JOIN VentaCFDIRelacionado vcfd
	ON VentaD.ID = vcfd.ID LEFT OUTER JOIN Empresa
	ON Venta.Empresa = Empresa.Empresa
	-- Bug 27233 Se deshabilita condición porque no se podía realizar una factura con anticipo.     
    --WHERE (VentaD.Cantidad - ISNULL(VentaD.CantidadObsequio,0.0) >0)
UNION
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Venta.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Venta.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,'999999999999'))))) + RTRIM(LTRIM(CONVERT(varchar,'999999999999'))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,'0'))))) + RTRIM(LTRIM(CONVERT(varchar,'0'))) +
  REPLICATE(' ',50)
  OrdenExportacion,
  Venta.ID, 
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE '1' END VentaDCantidad,
  NULL AS VentaDCantidadInventario,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE 'No Aplica' END VentaDUnidad,
  NULL AS UnidadClave,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE 'ANTICIPO' END AS VentaDArticulo,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE CONVERT(DECIMAL(20,2), dbo.fnVentaDTotalUSD(Venta.Moneda, ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN))))  END VentaDPrecio,

  NULL AS VentaDRenglon,
  NULL AS VentaDRenglonSub,
  NULL AS VentaDRenglonID,
  NULL AS VentaDRenglonTipo,
  NULL AS sartFraccionArancelaria,
  NULL AS sartMarca,
  NULL AS sartModelo,
  NULL AS sartSubModelo,
  NULL AS SerieLote,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE dbo.fnVentaDTotalUSD(Venta.Moneda, 1 * ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN))) END VentaDTotalUSD
  FROM Venta 
  JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
  JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov LEFT OUTER JOIN VentaCFDIRelacionado vcfd
   ON Venta.ID = vcfd.ID LEFT OUTER JOIN Empresa
   ON Venta.Empresa = Empresa.Empresa
 WHERE AnticiposFacturados IS NOT NULL
-- AND RenglonTipo NOT IN ('J','C')
 UNION
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Ventad.Renglon+'90000000'))))) + RTRIM(LTRIM(CONVERT(varchar,Ventad.Renglon+'90000000'))) +
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion,
  VentaD.ID, 
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE VentaD.CantidadObsequio END VentaDCantidad,
  VentaD.CantidadInventario VentaDCantidadInventario,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE VentaD.Unidad END VentaDUnidad,
  Unidad.Clave UnidadClave,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE VentaD.Articulo END VentaDArticulo,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE 0.0 END VentaDPrecio ,

  VentaD.Renglon VentaDRenglon,
  VentaD.RenglonSub VentaDRenglonSub,
  VentaD.RenglonID VentaDRenglonID,
  VentaD.RenglonTipo VentaDRenglonTipo,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE sart.FraccionArancelaria END sartFraccionArancelaria,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE sart.Marca  END sartMarca,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE sart.Modelo END sartModelo,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE sart.SubModelo END sartSubModelo,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE SerieLoteMov.SerieLote END SerieLote,
  0.0 VentaDTotalUSD
  FROM VentaD JOIN Art
    ON VentaD.Articulo = Art.Articulo JOIN VentaTCalc vtc
    ON vtc.ID = VentaD.ID AND vtc.Renglon = VentaD.Renglon AND vtc.RenglonSub = VentaD.RenglonSub LEFT OUTER JOIN Unidad 
    ON Unidad.Unidad = VentaD.Unidad LEFT OUTER JOIN ArtProv
    ON ArtProv.Proveedor = Art.Proveedor AND ArtProv.Articulo = Art.Articulo JOIN Venta
    ON Venta.ID = VentaD.ID LEFT OUTER JOIN EmpresaCFD 
    ON EmpresaCFD.Empresa = Venta.Empresa LEFT OUTER JOIN TipoEmpaque
    ON Art.tipoEmpaque=TipoEmpaque.TipoEmpaque JOIN MovTipo mt
    ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov LEFT OUTER JOIN EmpresaCfg Ecfg 
    ON Ecfg.Empresa = Venta.Empresa LEFT OUTER JOIN SATArticuloInfo sart
	ON VentaD.Articulo = sart.Articulo LEFT OUTER JOIN SerieLoteMov 
	ON SerieLoteMov.ID = VentaD.ID AND SerieLoteMov.RenglonID = VentaD.RenglonID LEFT JOIN VentaCFDIRelacionado vcfd
	ON VentaD.ID = vcfd.ID LEFT OUTER JOIN Empresa
	ON Venta.Empresa = Empresa.Empresa
  WHERE VentaD.CantidadObsequio >= 1
GO


/***************** CFDVentaINE *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaINE') AND TYPE = 'V') 
  DROP VIEW CFDVentaINE
GO
CREATE VIEW CFDVentaINE AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Venta.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Venta.ID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  Venta.ID ID,
  CASE ISNULL(Venta.EnviarA,-1) WHEN -1 THEN CteCFD.TipoProceso ELSE CteEnviarA.TipoProceso END TipoProceso,
  CASE ISNULL(Venta.EnviarA,-1) WHEN -1 THEN CteCFD.TipoComite ELSE CteEnviarA.TipoComite END TipoComite,
  CASE ISNULL(Venta.EnviarA,-1) WHEN -1 THEN CteCFD.IdContabilidad ELSE CteEnviarA.IdContabilidad END IdContabilidad,
  CASE ISNULL(Venta.EnviarA,-1) WHEN -1 THEN CteCFD.ClaveEntidad ELSE CteEnviarA.ClaveEntidad END ClaveEntidad,
  CASE ISNULL(Venta.EnviarA,-1) WHEN -1 THEN CteCFD.Ambito ELSE CteEnviarA.Ambito END Ambito,
  CASE ISNULL(Venta.EnviarA,-1) WHEN -1 THEN CteCFD.EntidadIdContabilidad ELSE CteEnviarA.EntidadIdContabilidad END EntidadIdContabilidad
  FROM Venta JOIN Empresa
    ON Venta.Empresa = Empresa.Empresa JOIN Cte
    ON Cte.Cliente = Venta.Cliente JOIN Sucursal
    ON Venta.Sucursal = Sucursal.Sucursal JOIN VentaTCalcExportacion vtce
    ON vtce.ID = Venta.ID JOIN MovTipo mt
    ON mt.Mov = Venta.Mov AND mt.Modulo = 'VTAS' LEFT OUTER JOIN EmpresaCFD 
    ON Venta.Empresa = EmpresaCFD.Empresa LEFT OUTER JOIN Condicion
    ON Condicion.Condicion = Venta.Condicion LEFT OUTER JOIN Descuento
    ON Descuento.Descuento = Venta.Descuento  LEFT OUTER JOIN Mon 
    ON Mon.Moneda =venta.Moneda LEFT OUTER JOIN CFDFolio 
    ON CFDFolio.Empresa = Venta.Empresa
       AND CFDFolio.Modulo = mt.ConsecutivoModulo
       AND CFDFolio.Mov = mt.ConsecutivoMov
       AND CFDFolio.FechaAprobacion <= Venta.FechaRegistro 
       AND dbo.fnFolioConsecutivo(Venta.MovID) BETWEEN CFDFolio.FolioD AND CFDFolio.FolioA  
       AND ISNULL(dbo.fnSerieConsecutivo(Venta.MovID),'') = ISNULL(CFDFolio.Serie,'')
       --AND Venta.Sucursal = ISNULL(ISNULL(CFDFolio.Sucursal,0),Venta.Sucursal)
       AND (CASE WHEN ISNULL(CFDFolio.Nivel,'') = 'Sucursal' THEN ISNULL(CFDFolio.Sucursal,0) ELSE Venta.Sucursal END) = Venta.Sucursal
       AND CFDFolio.Estatus = 'ALTA'	    
       LEFT OUTER JOIN CteEmpresaCFD 
    ON Venta.Cliente = CteEmpresaCFD.Cliente AND Venta.Empresa = CteEmpresaCFD.Empresa LEFT OUTER JOIN   CteDeptoEnviarA
    ON CteDeptoEnviarA.Empresa = Venta.Empresa AND CteDeptoEnviarA.Departamento = Venta.Departamento AND CteDeptoEnviarA.Cliente = Venta.Cliente AND CteDeptoEnviarA.EnviarA = Venta.EnviarA LEFT OUTER JOIN CteCFD
    ON CteCFD.Cliente = Venta.Cliente LEFT OUTER JOIN VentaEntrega 
    ON Venta.ID = VentaEntrega.ID LEFT OUTER JOIN CteEnviarA 
    ON Venta.Cliente = CteEnviarA.Cliente AND Venta.EnviarA = CteEnviarA.ID LEFT OUTER JOIN CteDepto
    ON Venta.Cliente = CteDepto.Cliente AND Venta.Departamento=CteDepto.Departamento LEFT OUTER JOIN CFD
    ON CFD.ModuloID = Venta.ID AND CFD.Modulo = 'VTAS'
GO


/***************** CFDVenta *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVenta') AND TYPE = 'V') 
  DROP VIEW CFDVenta
GO
CREATE VIEW CFDVenta AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Venta.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Venta.ID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  Venta.ID ID,
  dbo.fnSerieConsecutivo(Venta.MovID) VentaSerie,  
  dbo.fnFolioConsecutivo(Venta.MovID) VentaFolio,  
  CONVERT(datetime,Venta.FechaRegistro, 126) VentaFechaRegistro,
  Venta.Condicion VentaCondicion,
   vtce.ImporteDescuentoGlobal*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImporteDescuentoGlobal,
   vtce.ImporteSobrePrecio*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImporteSobrePrecio,
   (vtce.SubTotal -ISNULL((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0)),0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaSubTotal ,
   (vtce.Impuesto1Total-ISNULL(AnticiposImpuestos,0.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImpuesto1Total,
   vtce.Impuesto2Total*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImpuesto2Total,
   vtce.Impuesto3Total*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImpuesto3Total,
   --(vtce.ImporteTotal-ISNULL((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0)),0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImporteTotal,
   ((vtce.ImporteTotal-ISNULL((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0)),0))-(ISNULL(Venta.Retencion,0.0)+ISNULL(AnticiposImpuestos,0.0)))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImporteTotal,
   --vtce.TotalNeto*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaTotal,
  ((vtce.ImporteTotal-ISNULL((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0)),0))-(ISNULL(Venta.Retencion,0.0)+ISNULL(AnticiposImpuestos,0.0)))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaTotal,  
  vtce.DescuentosTotales*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDescuentoImporte,
  dbo.fnCFDVentaMovImpuestoExcento(Venta.ID,(vtce.Impuestos-ISNULL(AnticiposImpuestos,0.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN))) VentaImpuestos,
  Venta.FormaPagoTipo VentaFormaPago,
  LOWER(mt.CFD_TipoDeComprobante) VentaTipoComprobante,    
  CASE WHEN Venta.Estatus IN ('CONCLUIDO','PENDIENTE') THEN 'ORIGINAL' ELSE 'DELETE' END VentaEstatusCancelacion,
  CASE 
    WHEN mt.Clave IN ('VTAS.F','VTAS.FM','VTAS.FR') THEN 'INVOICE'
    WHEN mt.Clave IN ('VTAS.B','VTAS.D','VTAS.DF')  THEN 'CREDIT_NOTE' 
  END VentaTipoDocumento,
  Venta.Mov VentaMov, 
  Venta.MovID VentaMovID,
  dbo.fnNumeroEnEspanol(vtce.TotalNeto, CASE WHEN ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN) = 1 THEN 'M.N.' ELSE Venta.Moneda END) VentaImporteLetra,
  Venta.OrdenCompra VentaOrdenCompra,
  Venta.FechaOrdenCompra VentaOrdenCompraFecha,
  Mon.Clave  VentaMoneda ,
  Venta.TipoCambio VentaTipoCambio,
  Venta.Estatus VentaEstatus,
  Venta.Departamento,
  dbo.fnCFDVentaMovRetencionExcento(Venta.ID,Venta.Retencion)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaRetencionTotal,
  Venta.Vencimiento VentaVencimiento,
  Venta.FechaRequerida VentaFechaRequerida,
  Venta.FechaOrdenCompra VentaFechaOrdenCompra,
  Venta.ReferenciaOrdenCompra VentaReferenciaOrdenCompra,
  Venta.Atencion VentaAtencion,
  Venta.Observaciones VentaObservaciones,
  Venta.AtencionTelefono VentaAtencionTelefono,
  NULLIF(RIGHT(Venta.Referencia, 4),'No Aplica') NumCtaPago,
  mt.Clave VentaClaveAfectacion,
  mt.SubClave VentaSubClaveAfectacion,
  Empresa.GLN EmpresaGLN,
  Empresa.Nombre EmpresaNombre,
  Empresa.RFC EmpresaRFC,
  Empresa.Direccion EmpresaCalle,
  Empresa.DireccionNumero EmpresaNumeroExterior,
  Empresa.DireccionNumeroInt EmpresaNumeroInterior,
  Empresa.Colonia EmpresaColonia,
  Empresa.Poblacion EmpresaLocalidad,
  Empresa.Delegacion EmpresaMunicipio,
  Empresa.Estado EmpresaEstado,
  Empresa.Pais EmpresaPais,
  Empresa.CodigoPostal EmpresaCodigoPostal,
  Sucursal.GLN SucursalGLN,
  Sucursal.Nombre SucursalNombre,
  Sucursal.RFC SucursalRFC,
  Sucursal.Direccion SucursalCalle,
  Sucursal.DireccionNumero SucursalNumeroExterior,
  Sucursal.DireccionNumeroInt SucursalNumeroInterior,
  Sucursal.Colonia SucursalColonia,
  Sucursal.Delegacion + ', ' + Sucursal.Estado SucursalLocalidad,
  Sucursal.Delegacion SucursalMunicipio,
  Sucursal.Estado SucursalEstado,
  Sucursal.Pais SucursalPais,
  Sucursal.CodigoPostal SucursalCodigoPostal,

  CteEnviarA.GLN CteEnviarAGLN,
  CteEnviarA.Nombre CteEnviarANombre,
  CteEnviarA.Direccion CteEnviarACalle,
  CteEnviarA.DireccionNumero CteEnviarANumeroExterior,
  CteEnviarA.DireccionNumeroInt CteEnviarANumeroInterior,
  CteEnviarA.Colonia CteEnviarAColonia,
  CteEnviarA.Poblacion CteEnviarALocalidad,
  CteEnviarA.Delegacion CteEnviarAMunicipio,
  CteEnviarA.Estado CteEnviarAEstado,
  CteEnviarA.Pais CteEnviarAPais,
  CteEnviarA.CodigoPostal CteEnviarACodigoPostal,
  CteEnviarA.Clave CteEnviarAClave,

  CteEmpresaCFD.EmisorID ClienteEmisorID,
  ISNULL(CteDeptoEnviarA.ProveedorID, CteEmpresaCFD.ProveedorID) ClienteProveedorID,
  Cte.Cliente ClienteClave,
  Cte.Nombre ClienteNombre,
  Cte.RFC ClienteRFC,
  Cte.GLN ClienteGLN,  
  Cte.Direccion ClienteCalle,
  Cte.DireccionNumero ClienteNumeroExterior,
  Cte.DireccionNumeroInt ClienteNumeroInterior,
  Cte.Colonia ClienteColonia,
  Cte.Poblacion ClienteLocalidad,
  Cte.Delegacion ClienteMunicipio,
  Cte.Estado ClienteEstado,
  Cte.Pais ClientePais,
  Cte.CodigoPostal ClienteCodigoPostal,
  RTRIM(ISNULL(Cte.Direccion,'') + ' ' + ISNULL(Cte.DireccionNumero,'') + ' ' + ISNULL(Cte.DireccionNumeroInt,'')) + ', ' + ISNULL(Cte.Colonia,'') ClienteDireccion,
  CASE 
    WHEN Condicion.TipoCondicion = 'Credito' THEN 'DATE_OF_INVOICE' 
    WHEN Condicion.TipoCondicion = 'Contado' THEN 'EFFECTIVE_DATE'
  END VentaTipoPago,   
  Cte.PersonalCobrador ClientePersonalCobrador,
  CteCFD.ReceptorID ClienteReceptorID,
  CteDepto.Clave CteDeptoClave,
  CteDepto.Contacto CteDeptocontacto,
  ISNULL(Condicion.DiasVencimiento,0) CondicionDiasVencimiento,
  Condicion.CFD_MetodoDePago CondicionMetodoDePago, 
  Condicion.CFD_FormaDePago CondicionFormaDePago,
  Condicion.DescuentoProntoPago CondicionDescuentoProntoPago,
  Descuento.Clave VentaDescuentoGlobalClave,
  Descuento.Porcentaje VentaPorcentajeDescuentoGlobal,
  YEAR(CFDFolio.fechaAprobacion) CFDanoAprobacion,
  CFDFolio.noAprobacion CFDnoAprobacion,
  GETDATE() VariosAhora,
  RTRIM('VTAS')+CONVERT(varchar, Venta.ID) VariosModuloID,
  VentaEntrega.Embarque	VentaEntregaEmbarque,
  VentaEntrega.EmbarqueFecha VentaEntregaEmbarqueFecha,
  VentaEntrega.EmbarqueReferencia VentaEntregaEmbarqueReferencia,
  VentaEntrega.Recibo VentaEntregaRecibo,
  VentaEntrega.ReciboFecha VentaEntregaReciboFecha,
  VentaEntrega.ReciboReferencia VentaEntregaReciboReferencia,
  VentaEntrega.Sucursal VentaEntregaSucursal,
  VentaEntrega.SucursalOrigen VentaEntregaSucursalOrigen,
  VentaEntrega.EntregaMercancia VentaEntregaEntregaMercancia,
  VentaEntrega.TotalCajas VentaEntregaTotalCajas,

  CFD.Modulo CFDModulo,
  Venta.ID CFDModuloID,
  CFD.Fecha CFDFecha,
  CFD.Ejercicio CFDEjercicio,
  CFD.Periodo CFDPeriodo,
  CFD.Empresa CFDEmpresa,
  CFD.MovID CFDMovID,
  CFD.Serie CFDSerie,
  CFD.Folio CFDFolio,
  CFD.RFC CFDRFC,
  CFD.Aprobacion CFDAprobacion,
  CFD.Importe CFDImporte,
  CFD.Impuesto1 CFDImpuesto1,
  CFD.Impuesto2 CFDImpuesto2,
  CFD.FechaCancelacion CFDFechaCancelacion,
  CFD.noCertificado CFDnoCertificado,
  CFD.Sello CFDSello,
  CFD.CadenaOriginal CFDCadenaOriginal,
  CFD.CadenaOriginal1 CFDCadenaOriginal1,
  CFD.CadenaOriginal2 CFDCadenaOriginal2,
  CFD.CadenaOriginal3 CFDCadenaOriginal3,
  CFD.CadenaOriginal4 CFDCadenaOriginal4,
  CFD.CadenaOriginal5 CFDCadenaOriginal5,
  CFD.GenerarPDF CFDGenerarPDF,
  CFD.Retencion1 CFDRetencion1,
  CFD.Retencion2 CFDRetencion2,
  CFD.TipoCambio CFDTipoCambio,
  CFD.Timbrado CFDTimbrado,
  CFD.UUID CFDUUID,
  CFD.FechaTimbrado CFDFechaTimbrado,
  CFD.SelloSAT CFDSelloSAT,
  CFD.TFDVersion CFDTFDVersion,
  CFD.noCertificadoSAT CFDnoCertificadoSAT,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación' THEN '2' WHEN 'Exportación de Servicios' THEN 'A' ELSE NULL END vcfdTipoOperacion,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE CASE ISNULL(Empresa.ClavePedimento,'') WHEN '' THEN NULL ELSE SATClavePedimento.Clave END END vcfdClavePedimento,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE CASE ISNULL(Empresa.CertificadoOrigen,'') WHEN 'Funge como Certificado de Origen' THEN '1' WHEN 'No Funge como Certificado de Origen' THEN '0' ELSE NULL END END vcfdCertificadoOrigen,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE CASE ISNULL(Empresa.CertificadoOrigen,'') WHEN 'No Funge como Certificado de Origen' THEN NULL ELSE CASE ISNULL(Empresa.NumCertificadoOrigen,'') WHEN '' THEN NULL ELSE Empresa.NumCertificadoOrigen END END END vcfdNumCertificadoOrigen,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE CASE ISNULL(Empresa.NumeroExportadorConfiable,'') WHEN '' THEN NULL ELSE Empresa.NumeroExportadorConfiable END END vcfdNumeroExportadorConfiable,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE CASE ISNULL(vcfd.Incoterm,'') WHEN '' THEN NULL ELSE vcfd.Incoterm END END vcfdIncoterm,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE CASE ISNULL(vcfd.Subdivision,'') WHEN 'No tiene subdivisión' THEN '0' WHEN 'Si tiene subdivisión' THEN '1' ELSE NULL END END vcfdSubdivision,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE CASE ISNULL(Mon.Clave,'') WHEN 'USD' THEN Mon.TipoCambio ELSE dbo.fnMonTipoCambioUSD(Mon.Moneda) END END vcfdTipoCambioUSD,
  CteCFD.NumRegIdTrib CteNumRegIdTrib,
  CASE ISNULL(Empresa.TipoOperacion, '') WHEN 'Exportación de Servicios' THEN NULL ELSE CONVERT(DECIMAL(20,2), (SELECT SUM(VentaDTotalUSD) FROM CFDVentaDExt WHERE ID = Venta.ID)) END VentaTotalUSD,
  DestinatarioCFD.NumRegIdTrib DestinatarioNumRegIdTrib,
  CASE ISNULL(DestinatarioCFD.NumRegIdTrib,'') WHEN '' THEN Destinatario.RFC ELSE NULL END DestinatarioRFC,
  Destinatario.CURP DestinatarioCURP,
  Destinatario.Nombre DestinatarioNombre,
  Destinatario.Direccion DestinatarioDireccion,
  Destinatario.DireccionNumero DestinatarioDireccionNumero,
  Destinatario.DireccionNumeroInt DestinatarioDireccionNumeroInt,
  Destinatario.Colonia DestinatarioColonia,
  Destinatario.Poblacion DestinatarioPoblacion,
  Destinatario.Delegacion DestinatarioDelegacion,
  Destinatario.Estado DestinatarioEstado,
  Destinatario.CodigoPostal DestinatarioCodigoPostal,
  Destinatario.EntreCalles DestinatarioEntreCalles,
  CASE ISNULL(cdd.ClaveColonia,'')   WHEN '' THEN Destinatario.Colonia      ELSE cdd.ClaveColonia   END ClaveDestinatarioColonia,
  CASE ISNULL(cdd.ClaveLocalidad,'') WHEN '' THEN Destinatario.Poblacion    ELSE cdd.ClaveLocalidad END ClaveDestinatarioPoblacion,
  CASE ISNULL(cdd.ClaveMunicipio,'') WHEN '' THEN Destinatario.Delegacion   ELSE cdd.ClaveMunicipio END ClaveDestinatarioDelegacion,
  CASE ISNULL(cdd.ClaveEstado,'')    WHEN '' THEN Destinatario.Estado       ELSE cdd.ClaveEstado    END ClaveDestinatarioEstado,
  CASE ISNULL(cdd.ClavePais,'')      WHEN '' THEN Destinatario.Pais         ELSE cdd.ClavePais      END ClaveDestinatarioPais,
  CASE ISNULL(cdd.ClaveCP,'')        WHEN '' THEN Destinatario.CodigoPostal ELSE cdd.ClaveCP        END ClaveDestinatarioCodigoPostal, 
  CASE ISNULL(ed.ClaveColonia,'')    WHEN '' THEN Empresa.Colonia           ELSE ed.ClaveColonia    END ClaveEmpresaColonia,
  CASE ISNULL(ed.ClaveLocalidad,'')  WHEN '' THEN Empresa.Poblacion         ELSE ed.ClaveLocalidad  END ClaveEmpresaLocalidad,
  CASE ISNULL(ed.ClaveMunicipio,'')  WHEN '' THEN Empresa.Delegacion        ELSE ed.ClaveMunicipio  END ClaveEmpresaMunicipio,
  CASE ISNULL(ed.ClaveEstado,'')     WHEN '' THEN Empresa.Estado            ELSE ed.ClaveEstado     END ClaveEmpresaEstado,
  CASE ISNULL(ed.ClavePais,'')       WHEN '' THEN Empresa.Pais              ELSE ed.ClavePais       END ClaveEmpresaPais,
  CASE ISNULL(ed.ClaveCP,'')         WHEN '' THEN Empresa.CodigoPostal      ELSE ed.ClaveCP         END ClaveEmpresaCodigoPostal,
  CASE ISNULL(sd.ClaveColonia,'')    WHEN '' THEN Sucursal.Colonia          ELSE sd.ClaveColonia    END ClaveSucursalColonia,
  CASE ISNULL(sd.ClaveLocalidad,'')  WHEN '' THEN Sucursal.Poblacion        ELSE sd.ClaveLocalidad  END ClaveSucursalLocalidad,
  CASE ISNULL(sd.ClaveMunicipio,'')  WHEN '' THEN Sucursal.Delegacion       ELSE sd.ClaveMunicipio  END ClaveSucursalMunicipio,
  CASE ISNULL(sd.ClaveEstado,'')     WHEN '' THEN Sucursal.Estado           ELSE sd.ClaveEstado     END ClaveSucursalEstado,
  CASE ISNULL(sd.ClavePais,'')       WHEN '' THEN Sucursal.Pais             ELSE sd.ClavePais       END ClaveSucursalPais,
  CASE ISNULL(sd.ClaveCP,'')         WHEN '' THEN Sucursal.CodigoPostal     ELSE sd.ClaveCP         END ClaveSucursalCodigoPostal,
  CASE ISNULL(cad.ClaveColonia,'')   WHEN '' THEN CteEnviarA.Colonia        ELSE cad.ClaveColonia   END ClaveCteEnviarAColonia,
  CASE ISNULL(cad.ClaveLocalidad,'') WHEN '' THEN CteEnviarA.Poblacion      ELSE cad.ClaveLocalidad END ClaveCteEnviarALocalidad,
  CASE ISNULL(cad.ClaveMunicipio,'') WHEN '' THEN CteEnviarA.Delegacion     ELSE cad.ClaveMunicipio END ClaveCteEnviarAMunicipio,
  CASE ISNULL(cad.ClaveEstado,'')    WHEN '' THEN CteEnviarA.Estado         ELSE cad.ClaveEstado    END ClaveCteEnviarAEstado,
  CASE ISNULL(cad.ClavePais,'')      WHEN '' THEN CteEnviarA.Pais           ELSE cad.ClavePais      END ClaveCteEnviarAPais,
  CASE ISNULL(cad.ClaveCP,'')        WHEN '' THEN CteEnviarA.CodigoPostal   ELSE cad.ClaveCP        END ClaveCteEnviarACodigoPostal,
  CASE ISNULL(cd.ClaveColonia,'')    WHEN '' THEN Cte.Colonia               ELSE cd.ClaveColonia    END ClaveClienteColonia,
  CASE ISNULL(cd.ClaveLocalidad,'')  WHEN '' THEN Cte.Poblacion             ELSE cd.ClaveLocalidad  END ClaveClienteLocalidad,
  CASE ISNULL(cd.ClaveMunicipio,'')  WHEN '' THEN Cte.Delegacion            ELSE cd.ClaveMunicipio  END ClaveClienteMunicipio,
  CASE ISNULL(cd.ClaveEstado,'')     WHEN '' THEN Cte.Estado                ELSE cd.ClaveEstado     END ClaveClienteEstado,
  CASE ISNULL(cd.ClavePais,'')       WHEN '' THEN Cte.Pais                  ELSE cd.ClavePais       END ClaveClientePais,
  CASE ISNULL(cd.ClaveCP,'')         WHEN '' THEN Cte.CodigoPostal          ELSE cd.ClaveCP         END ClaveClienteCodigoPostal,
  CASE LEN(Empresa.RFC) WHEN 12 THEN NULL ELSE Empresa.RepresentanteCURP END EmpresaRepresentanteCURP,
  Cte.CURP ClienteCURP
  FROM Venta JOIN Empresa
    ON Venta.Empresa = Empresa.Empresa JOIN Cte
    ON Cte.Cliente = Venta.Cliente JOIN Sucursal
    ON Venta.Sucursal = Sucursal.Sucursal JOIN VentaTCalcExportacion vtce
    ON vtce.ID = Venta.ID JOIN MovTipo mt
    ON mt.Mov = Venta.Mov AND mt.Modulo = 'VTAS' LEFT OUTER JOIN EmpresaCFD 
    ON Venta.Empresa = EmpresaCFD.Empresa LEFT OUTER JOIN Condicion
    ON Condicion.Condicion = Venta.Condicion LEFT OUTER JOIN Descuento
    ON Descuento.Descuento = Venta.Descuento  LEFT OUTER JOIN Mon 
    ON Mon.Moneda =venta.Moneda LEFT OUTER JOIN CFDFolio 
    ON CFDFolio.Empresa = Venta.Empresa
       AND CFDFolio.Modulo = mt.ConsecutivoModulo
       AND CFDFolio.Mov = mt.ConsecutivoMov
       AND CFDFolio.FechaAprobacion <= Venta.FechaRegistro 
       AND dbo.fnFolioConsecutivo(Venta.MovID) BETWEEN CFDFolio.FolioD AND CFDFolio.FolioA  
       AND ISNULL(dbo.fnSerieConsecutivo(Venta.MovID),'') = ISNULL(CFDFolio.Serie,'')
       --AND Venta.Sucursal = ISNULL(ISNULL(CFDFolio.Sucursal,0),Venta.Sucursal)
       AND (CASE WHEN ISNULL(CFDFolio.Nivel,'') = 'Sucursal' THEN ISNULL(CFDFolio.Sucursal,0) ELSE Venta.Sucursal END) = Venta.Sucursal
       AND CFDFolio.Estatus = 'ALTA'	    
       LEFT OUTER JOIN CteEmpresaCFD 
    ON Venta.Cliente = CteEmpresaCFD.Cliente AND Venta.Empresa = CteEmpresaCFD.Empresa LEFT OUTER JOIN   CteDeptoEnviarA
    ON CteDeptoEnviarA.Empresa = Venta.Empresa AND CteDeptoEnviarA.Departamento = Venta.Departamento AND CteDeptoEnviarA.Cliente = Venta.Cliente AND CteDeptoEnviarA.EnviarA = Venta.EnviarA LEFT OUTER JOIN CteCFD
    ON CteCFD.Cliente = Venta.Cliente LEFT OUTER JOIN VentaEntrega 
    ON Venta.ID = VentaEntrega.ID LEFT OUTER JOIN CteEnviarA 
    ON Venta.Cliente = CteEnviarA.Cliente AND Venta.EnviarA = CteEnviarA.ID LEFT OUTER JOIN CteDepto
    ON Venta.Cliente = CteDepto.Cliente AND Venta.Departamento=CteDepto.Departamento LEFT OUTER JOIN CFD
    ON CFD.ModuloID = Venta.ID AND CFD.Modulo = 'VTAS' LEFT OUTER JOIN VentaCFDIRelacionado vcfd
	ON Venta.ID = vcfd.ID LEFT OUTER JOIN SATClavePedimento 
	ON Empresa.ClavePedimento = SATClavePedimento.Descripcion LEFT OUTER JOIN Cte Destinatario
	ON vcfd.Destinatario = Destinatario.Cliente LEFT OUTER JOIN CteCFD DestinatarioCFD
	ON Destinatario.Cliente = DestinatarioCFD.Cliente LEFT OUTER JOIN EmpresaDireccionFiscal ed
	ON Venta.Empresa = ed.Empresa LEFT OUTER JOIN CteDireccionFiscal cd
	ON Venta.Cliente = cd.Cliente LEFT OUTER JOIN SucursalDireccionFiscal sd
	ON Venta.Sucursal = sd.Sucursal LEFT OUTER JOIN CteDireccionFiscal cdd
	ON vcfd.Destinatario = cdd.Cliente LEFT OUTER JOIN CteEnviarADireccionFiscal cad
	ON Venta.Cliente = cad.Cliente AND Venta.EnviarA = cad.ID
GO


/**************** fnVentaDArticulo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnVentaDArticulo') DROP FUNCTION fnVentaDArticulo
GO
CREATE FUNCTION fnVentaDArticulo (@ID int, @Renglon float)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo  varchar(20)

  SELECT @Articulo = CASE ISNULL(vcfdTipoOperacion,'') WHEN 'A' THEN NULL ELSE CFDVentaD.VentaDArticulo END 
    FROM CFDVentaD JOIN CFDVenta ON CFDVentaD.ID = CFDVenta.ID 
   WHERE CFDVentaD.ID = @ID AND CFDVentaD.VentaDRenglon = @Renglon
    
  RETURN(@Articulo)
END
GO

/***************** CFDVentaSerieLoteMov *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaSerieLoteMov') AND TYPE = 'V') 
  DROP VIEW CFDVentaSerieLoteMov
GO
CREATE VIEW CFDVentaSerieLoteMov AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  RTRIM(SerieLoteMov.SerieLote) + REPLICATE (' ', 50 - LEN(RTRIM(SerieLoteMov.SerieLote)))
  OrdenExportacion, 
  SerieLoteMov.ID ID,
  SerieLoteMov.SerieLote,
  SerieLoteMov.Cantidad,
  SerieLoteMov.Propiedades,
  SerieLoteMov.Ubicacion,
  SerieLoteMov.Localizacion,
  SerieLoteMov.ArtCostoInv,
  SerieLoteprop.Fecha1,
  SerieLoteprop.Fecha2,
  SerieLoteprop.Fecha3,
  SerieLoteprop.PedimentoClave,
  SerieLoteprop.PedimentoRegimen,
  SerieLoteprop.AgenteAduanal,
  SerieLoteprop.Aduana,
  SerieLoteprop.PedimentoTipo,
  Aduana.GLN AduanaGLN
  FROM SerieLoteMov JOIN VentaD
    ON SerieLoteMov.ID = VentaD.ID AND SerieLoteMov.RenglonID = VentaD.RenglonID
    LEFT OUTER JOIN SerieLoteProp ON SerieLoteMov.Propiedades = SerieLoteProp.Propiedades
    LEFT OUTER JOIN Aduana ON SerieLoteProp.Aduana = Aduana.Aduana
  WHERE SerieLoteMov.Modulo = 'VTAS'
GO

/***************** CFDVentaPedimento *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaPedimento') AND TYPE = 'V') 
  DROP VIEW CFDVentaPedimento
GO
CREATE VIEW CFDVentaPedimento AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  RTRIM(SerieLoteMov.SerieLote) + REPLICATE (' ', 50 - LEN(RTRIM(SerieLoteMov.SerieLote)))
  OrdenExportacion, 
  SerieLoteMov.ID ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  SerieLoteMov.SerieLote,
  SerieLoteMov.Cantidad,
  SerieLoteMov.Propiedades,
  SerieLoteMov.Ubicacion,
  SerieLoteMov.Localizacion,
  SerieLoteMov.ArtCostoInv,
  SerieLoteprop.Fecha1,
  SerieLoteprop.Fecha2,
  SerieLoteprop.Fecha3,
  SerieLoteprop.PedimentoClave,
  SerieLoteprop.PedimentoRegimen,
  SerieLoteprop.AgenteAduanal,
  SerieLoteprop.Aduana,
  SerieLoteprop.PedimentoTipo,
  Aduana.GLN AduanaGLN
  FROM SerieLoteMov JOIN VentaD
    ON SerieLoteMov.ID = VentaD.ID AND SerieLoteMov.RenglonID = VentaD.RenglonID AND SerieLoteMov.Articulo = VentaD.Articulo
    JOIN SerieLoteProp ON SerieLoteMov.Propiedades = SerieLoteProp.Propiedades
    LEFT OUTER JOIN Aduana ON SerieLoteProp.Aduana = Aduana.Aduana
  WHERE SerieLoteMov.Modulo = 'VTAS'
GO

/***************** CFDSorianaPedidos *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDSorianaPedidos') AND TYPE = 'V') 
  DROP VIEW CFDSorianaPedidos
GO
CREATE VIEW CFDSorianaPedidos AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,SorianaArticulos.ID))))) + RTRIM(LTRIM(CONVERT(varchar,SorianaArticulos.ID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
SorianaArticulos.ID ID,
SorianaArticulos.Proveedor PedidosProveedor, 
SorianaArticulos.Remision PedidosRemision, 
SorianaArticulos.FolioPedido PedidosFolio, 
SorianaArticulos.Tienda PedidosTienda, 
count(distinct SorianaArticulos.Codigo)  PedidosCantidadArticulos
    FROM SorianaArticulos 
   GROUP BY ID, Proveedor, Remision, FolioPedido, Tienda
GO


/***************** CFDSorianaArticulos *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDSorianaArticulos') AND TYPE = 'V') 
  DROP VIEW CFDSorianaArticulos
GO
CREATE VIEW CFDSorianaArticulos AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,SorianaArticulos.ID))))) + RTRIM(LTRIM(CONVERT(varchar,SorianaArticulos.ID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  SorianaArticulos.ID ID,
  SorianaArticulos.Proveedor SorianaProveedor, 
  SorianaArticulos.Remision SorianaRemision, 
  SorianaArticulos.FolioPedido SorianaFolioPedido, 
  SorianaArticulos.Tienda SorianaTienda, 
  SorianaArticulos.Codigo SorianaCodigo,  
  convert(decimal (20,0),CantidadUnidadCompra) SorianaCantidadUnidadCompra,
  convert(money,CostoNetoUnidadCompra) SorianaCostoNetoUnidadCompra,
  convert(decimal (20,2),PorcentajeIEPS) SorianaPorcentajeIEPS,
  convert(decimal (20,2),PorcentajeIVA) SorianaPorcentajeIVA
   FROM SorianaArticulos 
GO


/***************** CFDSorianaCajaTarima *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDSorianaCajaTarima') AND TYPE = 'V') 
  DROP VIEW CFDSorianaCajaTarima
GO
CREATE VIEW CFDSorianaCajaTarima AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,SorianaCajasTarimas.ID))))) + RTRIM(LTRIM(CONVERT(varchar,SorianaCajasTarimas.ID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  SorianaCajasTarimas.ID ID,
  SorianaCajasTarimas.Proveedor SorianaProveedor,
  SorianaCajasTarimas.Remision SorianaRemision,
  SorianaCajasTarimas.NumeroCajaTarima SorianaNoCajaTarima,
  SorianaCajasTarimas.CodigoBarraCajaTarima SorianaCodigoCaja,
  SorianaCajasTarimas.SucursalDistribuir SorianaSucursalDistribuir,
  CONVERT(Decimal(20,0), SorianaCajasTarimas.CantidadArticulos) SorianaCantidadArticulos
   FROM SorianaCajasTarimas 
GO

/***************** CFDSorianaArtCajaTarima *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDSorianaArtCajaTarima') AND TYPE = 'V') 
  DROP VIEW CFDSorianaArtCajaTarima
GO
CREATE VIEW CFDSorianaArtCajaTarima AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,SorianaArtCajaTarima.ID))))) + RTRIM(LTRIM(CONVERT(varchar,SorianaArtCajaTarima.ID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  SorianaArtCajaTarima.ID ID,
 SorianaArtCajaTarima.Proveedor SorianaProveedor, 
 SorianaArtCajaTarima.Remision SorianaRemision, 
SorianaArtCajaTarima.FolioPedido SorianaFolioPedido,
SorianaArtCajaTarima.NumeroCajaTarima SorianaNoCaja,
SorianaArtCajaTarima.SucursalDistribuir SorianaSucursalDistribuir,
SorianaArtCajaTarima.Codigo SorianaCodigo,
CONVERT(Decimal(20,0), SorianaArtCajaTarima.CantidadUnidadCompra) SorianaCantidadUnidadCompra 
   FROM SorianaArtCajaTarima
GO

/**************** fnCFDCxcCadenaOriginal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDCxcCadenaOriginal') DROP FUNCTION fnCFDCxcCadenaOriginal
GO
CREATE FUNCTION fnCFDCxcCadenaOriginal ()
RETURNS @Resultado TABLE (OrdenExportacion varchar(255), ID int, CadenaOriginal varchar(255))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OrdenExportacion	varchar(255),
    @ID					int,
    @CadenaOriginal 	varchar(max),
	@ModuloID			int

  SELECT @ModuloID = ID FROM CFDFlexSesion WHERE Estacion = @@SPID AND Modulo = 'CXC'
  DECLARE crCFDCxcCadenaOriginal CURSOR FOR
   SELECT REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Cxc.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Cxc.ID))) +
          REPLICATE(' ',12) + 
          REPLICATE(' ',7) +
          REPLICATE(' ',50)
          OrdenExportacion,
          Cxc.ID ID,
          CFD.CadenaOriginal
     FROM Cxc JOIN CFD
       ON CFD.ModuloID = Cxc.ID AND CFD.Modulo = 'CXC'
	WHERE Cxc.ID = @ModuloID

  OPEN crCFDCxcCadenaOriginal
  FETCH NEXT FROM crCFDCxcCadenaOriginal INTO @OrdenExportacion, @ID, @CadenaOriginal
  WHILE @@FETCH_STATUS = 0
  BEGIN
    
    INSERT @Resultado ( OrdenExportacion,  ID,  CadenaOriginal)
    SELECT              @OrdenExportacion, @ID, CadenaOriginal
      FROM dbo.fnTextoaTabla(@CadenaOriginal, 130)
        
    FETCH NEXT FROM crCFDCxcCadenaOriginal INTO @OrdenExportacion, @ID, @CadenaOriginal

  END
  CLOSE crCFDCxcCadenaOriginal
  DEALLOCATE crCFDCxcCadenaOriginal

  RETURN 
END
GO
--SELECT * FROM fnCFDCxcCadenaOriginal()

/***************** CFDCxcCadenaOriginal *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDCxcCadenaOriginal') AND TYPE = 'V') 
  DROP VIEW CFDCxcCadenaOriginal
GO
CREATE VIEW CFDCxcCadenaOriginal AS
SELECT * FROM dbo.fnCFDCxcCadenaOriginal()
GO
--SELECT * FROM CFDCxcCadenaOriginal

/***************** CFDCXCMovImpuesto *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDCXCMovImpuesto') AND TYPE = 'V') 
  DROP VIEW CFDCXCMovImpuesto
GO
CREATE VIEW CFDCXCMovImpuesto AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  MovImpuesto.ModuloID ID,
  CONVERT(varchar(50),'IVA') Impuesto,
  CONVERT(varchar(50),'VAT') ImpuestoClave,
  MovImpuesto.Impuesto1 Tasa,
  SUM(MovImpuesto.Importe1*dbo.fnCFDTipoCambioMN(Cxc.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN))) Importe,
  'TRANSFERIDO' CategoriaImpuesto     
  FROM MovImpuesto
  JOIN CXC ON MovImpuesto.Modulo = 'Cxc' AND MovImpuesto.ModuloId = Cxc.ID
  JOIN EmpresaCFD ON Cxc.Empresa = EmpresaCFD.Empresa
  JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = Cxc.Mov
 WHERE MovImpuesto.Modulo = 'CXC'
   AND NULLIF(MovImpuesto.Importe1,0.0) IS NOT NULL
   AND ISNULL(MovImpuesto.Excento1,0) <> 1
 GROUP BY 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50),
  MovImpuesto.ModuloID,
  MovImpuesto.Impuesto1
UNION ALL   
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  MovImpuesto.ModuloID ID,
  CONVERT(varchar(50),'IEPS') Impuesto,
  CONVERT(varchar(50),'GST') ImpuestoClave,
  MovImpuesto.Impuesto2 Tasa,
  SUM(MovImpuesto.Importe2*dbo.fnCFDTipoCambioMN(Cxc.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN))) Importe,
  'TRANSFERIDO' CategoriaImpuesto      
  FROM MovImpuesto
  JOIN CXC ON MovImpuesto.Modulo = 'Cxc' AND MovImpuesto.ModuloId = Cxc.ID
  JOIN EmpresaCFD ON Cxc.Empresa = EmpresaCFD.Empresa
  JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = Cxc.Mov
 WHERE MovImpuesto.Modulo = 'CXC'
   AND NULLIF(MovImpuesto.Importe2,0.0) IS NOT NULL
   AND ISNULL(MovImpuesto.Excento2,0) <> 1
 GROUP BY 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50),
  MovImpuesto.ModuloID,
  MovImpuesto.Impuesto2
/*
UNION ALL
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  MovImpuesto.ModuloID ID,
  CONVERT(varchar(50),'IVA') Impuesto,
  CONVERT(varchar(50),'VAT') ImpuestoClave,
  MovImpuesto.Impuesto1 Tasa,
  MovImpuesto.Importe1*dbo.fnCFDTipoCambioMN(Cxc.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) Importe,
  'RETENIDO' CategoriaImpuesto      
  FROM MovImpuesto
  JOIN CXC ON MovImpuesto.Modulo = 'Cxc' AND MovImpuesto.ModuloId = Cxc.ID
  JOIN EmpresaCFD ON Cxc.Empresa = EmpresaCFD.Empresa
JOIN cte ON Cte.cliente = Cxc.Cliente
 WHERE MovImpuesto.Modulo = 'CXC'
   AND NULLIF(MovImpuesto.Importe1,0.0) IS NOT NULL    
   AND NULLIF(Cxc.Retencion,0.0) IS NOT NULL AND NULLIF(Cte.Pitex,'') IS NOT NULL
*/
GO

/***************** CFDCXCMovRetencion *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDCXCMovRetencion') AND TYPE = 'V') 
  DROP VIEW CFDCXCMovRetencion
GO
CREATE VIEW CFDCXCMovRetencion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  MovImpuesto.ModuloID ID,
  CONVERT(varchar(50),'ISR') Impuesto,
  CONVERT(varchar(50),'VAT') ImpuestoClave,
  MovImpuesto.Retencion1 Tasa,
  SUM(ISNULL(MovImpuesto.SubTotal*(MovImpuesto.Retencion1/100.0), 0.0)*dbo.fnCFDTipoCambioMN(Cxc.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN))) Importe,
  'RETENIDO' CategoriaImpuesto      
  FROM MovImpuesto
  JOIN CXC ON MovImpuesto.Modulo = 'Cxc' AND MovImpuesto.ModuloId = Cxc.ID
  JOIN EmpresaCFD ON Cxc.Empresa = EmpresaCFD.Empresa
  JOIN cte ON Cte.cliente = Cxc.Cliente
  JOIN version v ON 1 = 1
  JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = Cxc.Mov
 WHERE MovImpuesto.Modulo = 'CXC'
   AND NULLIF(MovImpuesto.Retencion1,0.0) IS NOT NULL    
--   AND NULLIF(Cxc.Retencion,0.0) IS NOT NULL
   AND ISNULL(MovImpuesto.Excento1,0) <> 1
 GROUP BY 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50),
  MovImpuesto.ModuloID,
  MovImpuesto.Retencion1 
UNION ALL
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  MovImpuesto.ModuloID ID,
  CONVERT(varchar(50),'IVA') Impuesto,
  CONVERT(varchar(50),'VAT') ImpuestoClave,
  MovImpuesto.Retencion2 Tasa,
  SUM((CASE WHEN ISNULL(v.Retencion2BaseImpuesto1,0) = 0 THEN ISNULL(MovImpuesto.SubTotal*(MovImpuesto.Retencion2/100.0), 0.0) ELSE ISNULL(MovImpuesto.Importe1*(MovImpuesto.Retencion2/100.0),0.0) END)*dbo.fnCFDTipoCambioMN(Cxc.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN))) Importe,
  'RETENIDO' CategoriaImpuesto      
  FROM MovImpuesto
  JOIN CXC ON MovImpuesto.Modulo = 'Cxc' AND MovImpuesto.ModuloId = Cxc.ID
  JOIN EmpresaCFD ON Cxc.Empresa = EmpresaCFD.Empresa
  JOIN cte ON Cte.cliente = Cxc.Cliente
  JOIN version v ON 1 = 1
  JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = Cxc.Mov
 WHERE MovImpuesto.Modulo = 'CXC'
   AND NULLIF(MovImpuesto.Retencion2,0.0) IS NOT NULL    
--   AND NULLIF(Cxc.Retencion2,0.0) IS NOT NULL
   AND ISNULL(MovImpuesto.Excento2,0) <> 1
 GROUP BY 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50),
  MovImpuesto.ModuloID,
  MovImpuesto.Retencion2 
GO

/**************** fnCFDCxcMovImpuestoExcento ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDCxcMovImpuestoExcento') DROP FUNCTION fnCFDCxcMovImpuestoExcento
GO
CREATE FUNCTION fnCFDCxcMovImpuestoExcento (@ID int, @Impuestos float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado 	float

  IF NOT EXISTS(SELECT * FROM CFDCxcMovImpuesto WHERE ID = @ID)
    SELECT @Resultado = NULL
  ELSE
  SELECT @Resultado = ISNULL(@Impuestos,0)
  
  RETURN (@Resultado)
END
GO

/**************** fnCFDCxcMovRetencionExcento ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDCxcMovRetencionExcento') DROP FUNCTION fnCFDCxcMovRetencionExcento
GO
CREATE FUNCTION fnCFDCxcMovRetencionExcento (@ID int, @Retenciones float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado 	float

  IF NOT EXISTS(SELECT * FROM CFDCxcMovRetencion WHERE ID = @ID)
    SELECT @Resultado = NULL
  ELSE
  SELECT @Resultado = ISNULL(@Retenciones,0)
  
  RETURN (@Resultado)
END
GO

/**************** fnCFDCxcImporte ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDCxcImporte') DROP FUNCTION fnCFDCxcImporte
GO
CREATE FUNCTION fnCFDCxcImporte
	(
	@ID				int,
	@Importe		float,
	@Renglon		int
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa			varchar(5),
    @CfgCobroImpuestos	int,
    @MovTipo			varchar(20),
    @AplicaID			varchar(20),
    @Aplica				varchar(20),
    @IDAplica			varchar(20),
    @Importe2			float,
    @Impuestos			float,
    @Retenciones		float,
    @Porcentaje			float, 
    @TipoCambio         float,
    @SAT_MN                  bit

  SELECT @Empresa = c.Empresa,
         @MovTipo = m.Clave,
         @TipoCambio = c.TipoCambio,
         @SAT_MN = m.SAT_MN
    FROM Cxc c
    JOIN MovTipo m
      ON c.Mov = m.Mov AND m.Modulo = 'CXC'
   WHERE c.ID = @ID
   
  SELECT @CfgCobroImpuestos = ISNULL(CxcCobroImpuestos, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa

  IF (@MovTipo IN ('CXC.C', 'CXC.CD', 'CXC.D', 'CXC.DM') AND @CfgCobroImpuestos = 0) OR @MovTipo NOT IN('CXC.F','CXC.FA','CXC.DFA','CXC.AF','CXC.CA','CXC.IM','CXC.RM','CXC.A','CXC.AR','CXC.AA','CXC.DE','CXC.CAP','CXC.RA')
  BEGIN
    IF @Renglon <> 0
    BEGIN
      SELECT @Aplica = Aplica,
             @AplicaID = AplicaID
        FROM CxcD
       WHERE ID = @ID
         AND Renglon = @Renglon

      SELECT @IDAplica = ID
        FROM Cxc
       WHERE Mov = @Aplica
         AND MovID = @AplicaID

      SELECT @Importe2 = ISNULL(Importe,0.0),
             @Impuestos = ISNULL(Impuestos,0.0),
             @Retenciones = ISNULL(Retencion,0.0)-- + ISNULL(Retencion2,0.0)
        FROM Cxc
       WHERE ID = @IDAplica
        
      SELECT @Porcentaje = @Importe/(@Importe2 + @Impuestos - @Retenciones)
      SELECT @Importe = @Importe - (@Porcentaje * @Impuestos) + (@Porcentaje * @Retenciones)

    END
    ELSE
    BEGIN
      SELECT @Impuestos = ISNULL(SUM(ISNULL(Importe,0.0)),0.0)/CASE WHEN @SAT_MN = 1 THEN @TipoCambio ELSE 1 END FROM CFDCXCMovImpuesto WHERE ID = @ID
      SELECT @Retenciones = ISNULL(SUM(ISNULL(Importe,0.0)),0.0)/CASE WHEN @SAT_MN = 1 THEN @TipoCambio ELSE 1 END FROM CFDCXCMovRetencion WHERE ID = @ID
      
      SELECT @Importe = @Importe - @Impuestos + @Retenciones
    END
  END
    ELSE
    BEGIN
      SELECT @Impuestos = (ISNULL(Impuestos,0.0)),
             @Retenciones = ISNULL(Retencion,0.0)
        FROM Cxc WHERE ID = @ID
      
      SELECT @Importe = @Importe - @Impuestos + @Retenciones
    END
    
  RETURN (@Importe)
END
GO


/***************** CFDCxc *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDCxc') AND TYPE = 'V') 
  DROP VIEW CFDCxc
GO
CREATE VIEW CFDCxc AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,c.ID))))) + RTRIM(LTRIM(CONVERT(varchar,c.ID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
'ID' = c.ID,
'EmpresaRFC'			= e.RFC,
'EmpresaNombre'			= e.Nombre,
'EmpresaCalle'			= e.Direccion,
'EmpresaNumeroExterior' = e.DireccionNumero,
'EmpresaNumeroInterior' = e.DireccionNumeroInt,
'EmpresaColonia'		= e.Colonia,
'EmpresaLocalidad'		= e.Poblacion,
'EmpresaMunicipio'		= e.Delegacion,
'EmpresaEstado'			= e.Estado,
'EmpresaPais'			= e.Pais,
'EmpresaCodigoPostal'	= e.CodigoPostal,
'SucursalGLN'            = s.GLN,
'SucursalNombre'         = s.Nombre,
'SucursalRFC'            = s.RFC,
'SucursalCalle'          = s.Direccion,
'SucursalNumeroExterior' = s.DireccionNumero,
'SucursalNumeroInterior' = s.DireccionNumeroInt,
'SucursalColonia'        = s.Colonia,
'SucursalLocalidad'      = s.Delegacion + ' ' + s.Estado,
'SucursalMunicipio'      = s.Delegacion,
'SucursalEstado'         = s.Estado,
'SucursalPais'           = s.Pais,
'SucursalCodigoPostal'   = s.CodigoPostal,
'CxcFechaRegistro'		= c.FechaRegistro,
'CxcSerie'				= dbo.fnSerieConsecutivo(C.MovID),
'CxcFolio'				= dbo.fnFolioConsecutivo(C.MovID),
'CxcCondicion'			= c.Condicion,
'CxcSubTotal'			= (SELECT sum(SubTotal) FROM MovImpuesto WHERE Modulo = 'CXC' AND ModuloID=c.ID)*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN)),--dbo.fnCFDCxcImporte(c.ID, (c.Importe+ISNULL(c.Impuestos,0.0)-(SELECT ISNULL(SUM(ISNULL(Importe,0.0)),0.0) FROM CFDCXCMovRetencion WHERE ID = c.ID)), 0)*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN)),
'CxcTipoComprobante'	= mt.CFD_tipoDeComprobante,
'CxcTotal'				= (SELECT sum(SubTotal) FROM MovImpuesto WHERE Modulo = 'CXC' AND ModuloID=c.ID)+(isnull((SELECT Importe FROM CFDCXCMovImpuesto WHERE ID = c.ID),0) -(SELECT ISNULL(SUM(ISNULL(Importe,0.0)),0.0) FROM CFDCXCMovRetencion WHERE ID = c.ID))*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN)),
'ClienteRFC'			= Cte.RFC, 
'ClienteNombre'			= Cte.Nombre,
'ClienteCalle'			= Cte.Direccion, 
'ClienteNumeroExterior' = Cte.DireccionNumero,
'ClienteNumeroInterior' = Cte.DireccionNumeroInt,
'ClienteColonia'		= Cte.Colonia,
'ClienteLocalidad'		= Cte.Poblacion,
'ClienteMunicipio'		= Cte.Delegacion,
'ClienteEstado'			= Cte.Estado,
'ClientePais'			= Cte.Pais,
'ClienteCodigoPostal'	= Cte.CodigoPostal,
'CFDanoAprobacion'		= YEAR(CFDFolio.FechaAprobacion),
'CFDnoAprobacion'		= CFDFolio.noAprobacion,
'CxcDCantidad'			= '1',
'CxcDUnidad'			= C.Concepto,
'CxcDArticulo'			= C.Concepto, 
'CxcDDescripcion'		= C.Concepto,
'CxcDPrecio'			= c.Importe*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN)),
'CxcDPrecioTotal'		= C.Importe*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN)),
'CxcImporteImpuesto1'	= dbo.fnCFDCxcMovImpuestoExcento(c.ID,((SELECT SUM(Importe1) FROM MovImpuesto WHERE Modulo = 'CXC' AND ModuloID=c.ID))*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN))) ,
'CxcImporteImpuesto2'	= dbo.fnCFDCxcMovImpuestoExcento(c.ID,((SELECT SUM(Importe2) FROM MovImpuesto WHERE Modulo = 'CXC' AND ModuloID=c.ID))*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN))) ,
'CxcImporte'			= c.Importe*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN)) , 
'CxcRetencion'			= dbo.fnCFDCxcMovRetencionExcento(c.ID,(SELECT ISNULL(SUM(ISNULL(Importe,0.0)),0.0) FROM CFDCXCMovRetencion WHERE ID = c.ID)*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN))),
'CXCVencimiento'		= c.Vencimiento,
'CXCMoneda'				= c.Moneda,
'CXCTipoCambio'			= c.TipoCambio,
'NumCtaPago'			= NULLIF(RIGHT(c.Referencia, 4),'No Aplica'),

  CFD.Modulo CFDModulo,
  CFD.ModuloID CFDModuloID,
  CFD.Fecha CFDFecha,
  CFD.Ejercicio CFDEjercicio,
  CFD.Periodo CFDPeriodo,
  CFD.Empresa CFDEmpresa,
  CFD.MovID CFDMovID,
  CFD.Serie CFDSerie,
  CFD.Folio CFDFolio,
  CFD.RFC CFDRFC,
  CFD.Aprobacion CFDAprobacion,
  CFD.Importe CFDImporte,
  CFD.Impuesto1 CFDImpuesto1,
  CFD.Impuesto2 CFDImpuesto2,
  CFD.FechaCancelacion CFDFechaCancelacion,
  CFD.noCertificado CFDnoCertificado,
  CFD.Sello CFDSello,
  CFD.CadenaOriginal CFDCadenaOriginal,
  CFD.CadenaOriginal1 CFDCadenaOriginal1,
  CFD.CadenaOriginal2 CFDCadenaOriginal2,
  CFD.CadenaOriginal3 CFDCadenaOriginal3,
  CFD.CadenaOriginal4 CFDCadenaOriginal4,
  CFD.CadenaOriginal5 CFDCadenaOriginal5,
  CFD.GenerarPDF CFDGenerarPDF,
  CFD.Retencion1 CFDRetencion1,
  CFD.Retencion2 CFDRetencion2,
  CFD.TipoCambio CFDTipoCambio,
  CFD.Timbrado CFDTimbrado,
  CFD.UUID CFDUUID,
  CFD.FechaTimbrado CFDFechaTimbrado,
  CFD.SelloSAT CFDSelloSAT,
  CFD.TFDVersion CFDTFDVersion,
  CFD.noCertificadoSAT CFDnoCertificadoSAT

FROM Cxc c
JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = c.Mov
JOIN Empresa e ON c.Empresa = e.Empresa
JOIN Sucursal s ON c.Sucursal = s.Sucursal
JOIN Cte Cte ON Cte.Cliente = c.Cliente
LEFT OUTER JOIN EmpresaCFD f ON e.Empresa = f.Empresa
LEFT OUTER JOIN CFDFolio ON CFDFolio.Mov = mt.ConsecutivoMov AND CFDFolio.Modulo = mt.Modulo AND CFDFolio.Empresa = e.Empresa
                         --AND CFDFolio.FechaAprobacion <= c.FechaRegistro 
                         AND dbo.fnFolioConsecutivo(c.MovID) BETWEEN CFDFolio.FolioD AND CFDFolio.FolioA  
                         AND ISNULL(dbo.fnSerieConsecutivo(c.MovID),'') = ISNULL(CFDFolio.Serie,'')
                         --AND c.Sucursal = ISNULL(ISNULL(CFDFolio.Sucursal,0),c.Sucursal)
LEFT OUTER JOIN CFD ON CFD.ModuloID = c.ID AND CFD.Modulo = 'CXC'
GO

/***************** CFDCxcFiscalRegimen *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDCxcFiscalRegimen') AND TYPE = 'V') 
  DROP VIEW CFDCxcFiscalRegimen
GO
CREATE VIEW CFDCxcFiscalRegimen AS
SELECT  REPLICATE('0', 20 - LEN(RTRIM(LTRIM(CONVERT(varchar, Cxc.ID))))) + RTRIM(LTRIM(CONVERT(varchar, Cxc.ID)))
        + REPLICATE('0',12 - LEN(RTRIM(LTRIM(CONVERT(varchar, 20048))))) + RTRIM(LTRIM(CONVERT(varchar, 2048))) + REPLICATE('0', 7 - LEN(RTRIM(LTRIM(CONVERT(varchar, 0)))))
        + RTRIM(LTRIM(CONVERT(varchar, 0))) + REPLICATE(' ', 50 - LEN(RTRIM(LTRIM(CONVERT(varchar, dbo.fnCFDFlexRegimenFiscal(Cxc.Empresa, 'CXC', Cxc.Concepto))))))
        + RTRIM(LTRIM(CONVERT(varchar, dbo.fnCFDFlexRegimenFiscal(Cxc.Empresa, 'CXC', Cxc.Concepto))))
        OrdenExportacion,
        Cxc.ID,
        dbo.fnCFDFlexRegimenFiscal(Cxc.Empresa, 'CXC', Cxc.Concepto) EmisorRegimenFiscal
  FROM  Cxc
GO

/**************** fnCFDFlexNumDocumento ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexNumDocumento') DROP FUNCTION fnCFDFlexNumDocumento
GO
CREATE FUNCTION dbo.fnCFDFlexNumDocumento
(@Empresa    varchar(5), @Aplica  varchar(20), @AplicaID varchar(20), @ID varchar(20)) 
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @Resultado      varchar(50),
  @Referencia     varchar(50),
  @Len            int,
  @Desde          int,
  @Hasta          int,
  @NoValidarOrigenDocumento bit,
  @ParcialidadNumero        int,
  @OrigenSerie          varchar(20),
  @OrigenFolio          int,
  @FolioFiscalOrig			varchar(50),
  @SerieFolioFiscalOrig		varchar(50),
  @Mov				    varchar(20),
  @CFDEsParcialidad			bit

  SELECT @Mov = Mov FROM Cxc WHERE ID = @ID
  SELECT @CFDEsParcialidad = ISNULL(CFDEsParcialidad,0) FROM MovTipo WHERE Modulo = 'CXC' AND Mov = @Mov

  SELECT @NoValidarOrigenDocumento = ISNULL(NoValidarOrigenDocumento,0)
    FROM EmpresaCFD
   WHERE Empresa = @Empresa
  
  IF @Aplica IN(SELECT Mov FROM MovTipo WHERE Clave = 'CXC.D' AND Modulo = 'CXC')
  BEGIN
    SELECT @Referencia = Referencia FROM Cxc WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID
    SELECT @Len = LEN(@Referencia)
    SELECT @Desde = CHARINDEX('(',@Referencia)
    IF @Desde > 0
      SELECT @Resultado = SUBSTRING(@Referencia,@Desde+1,@Len)

    SELECT @Hasta = CHARINDEX(')',@Resultado)
    SELECT @Resultado = LEFT(@Resultado,@Hasta-1)
    SELECT @Resultado= 'Parcialidad' + ' ' + REPLACE(@Resultado,'/',' de ')
  END
  ELSE
  IF @CFDEsParcialidad = 1
  BEGIN    
    SELECT @FolioFiscalOrig = dbo.fnCFDFlexCampoOrigen('CXC', @ID, 'FolioFiscalOrig')
    SELECT @SerieFolioFiscalOrig = dbo.fnCFDFlexCampoOrigen('CXC', @ID, 'SerieFolioFiscalOrig')
    SELECT @OrigenSerie = dbo.fnSerieConsecutivo(@SerieFolioFiscalOrig)
    SELECT @OrigenFolio = dbo.fnFolioConsecutivo(@SerieFolioFiscalOrig)
	SELECT @ParcialidadNumero = ISNULL(MAX(ParcialidadNumero),0) FROM CFD WHERE CONVERT(varchar(50),OrigenUUID) = @FolioFiscalOrig AND OrigenUUID IS NOT NULL AND ModuloID <> @ID
	
	IF @ParcialidadNumero = 0 AND NULLIF(@FolioFiscalOrig,'') IS NULL
      SELECT @ParcialidadNumero = ISNULL(MAX(ParcialidadNumero),0) FROM CFD WHERE OrigenSerie = @OrigenSerie AND OrigenFolio = @OrigenFolio AND OrigenSerie IS NOT NULL AND OrigenFolio IS NOT NULL AND ModuloID <> @ID
      
    SELECT @Resultado= 'Parcialidad' + ' ' + CONVERT(varchar, @ParcialidadNumero + 1)  
  END
                
  SELECT @Resultado = ISNULL(@Resultado,'')
  
  RETURN (@Resultado)
 END
GO

/***************** CFDCxcDetalle *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDCxcDetalle') AND TYPE = 'V') 
  DROP VIEW CFDCxcDetalle
GO
CREATE VIEW CFDCxcDetalle AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,c.ID))))) + RTRIM(LTRIM(CONVERT(varchar,c.ID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
'ID' = c.ID,
'Renglon' = ISNULL(d.Renglon,2048),
'CxcDCantidad'			= '1',
'CxcDUnidad'			= CASE WHEN dbo.fnCFDFlexNumDocumento(c.Empresa,d.Aplica,d.AplicaID, d.ID) = '' THEN c.Concepto ELSE 'no aplica' END,
'CxcDArticulo'			= CASE WHEN dbo.fnCFDFlexNumDocumento(c.Empresa,d.Aplica,d.AplicaID, d.ID) = '' THEN c.Concepto ELSE d.Aplica + ' ' + d.AplicaID END,
'CxcDDescripcion'		= ISNULL(NULLIF(dbo.fnCFDFlexNumDocumento(c.Empresa,d.Aplica,d.AplicaID, d.ID),''),c.Concepto),
'CxcDPrecio'			= ISNULL(dbo.fnCFDCxcImporte(d.ID, d.Importe, d.Renglon)*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN)),c.Importe*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN))),
'CxcDPrecioTotal'		= ISNULL(dbo.fnCFDCxcImporte(d.ID, d.Importe, d.Renglon)*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN)),c.Importe*dbo.fnCFDTipoCambioMN(C.TipoCambio, ISNULL(mt.SAT_MN, f.SAT_MN)))

FROM Cxc c
LEFT OUTER JOIN CxcD d ON c.ID = d.ID AND NULLIF(d.AplicaID,'') IS NOT NULL
JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = c.Mov
JOIN Empresa e ON c.Empresa = e.Empresa
JOIN Sucursal s ON c.Sucursal = s.Sucursal
JOIN Cte Cte ON Cte.Cliente = c.Cliente
LEFT OUTER JOIN EmpresaCFD f ON e.Empresa = f.Empresa
LEFT OUTER JOIN CFDFolio ON CFDFolio.Mov = mt.ConsecutivoMov AND CFDFolio.Modulo = mt.Modulo AND CFDFolio.Empresa = e.Empresa
                         AND dbo.fnFolioConsecutivo(c.MovID) BETWEEN CFDFolio.FolioD AND CFDFolio.FolioA  
                         AND ISNULL(dbo.fnSerieConsecutivo(c.MovID),'') = ISNULL(CFDFolio.Serie,'')
LEFT OUTER JOIN CFD ON CFD.ModuloID = c.ID AND CFD.Modulo = 'CXC'
GO

--REQ Q3069 CFDGT
/**************** fnListaTimbrarCFDIServidor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnListaTimbrarCFDIServidor') DROP FUNCTION fnListaTimbrarCFDIServidor
GO
CREATE FUNCTION fnListaTimbrarCFDIServidor 
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
  SELECT @EsGuatemala = ISNULL(EsGuatemala,0) FROM Empresa WHERE Empresa = @Empresa
  
  IF @EsGuatemala = 0  
    INSERT @Lista (Servidor)
    SELECT 'Aspel'
     UNION
    SELECT 'EDICOM'
     UNION
    SELECT 'SOLUCIONFACTIBLE'
     UNION
    SELECT 'MASTEREDI'
     UNION
    SELECT 'FEL'
     UNION
    SELECT 'KONESH'
     UNION
    SELECT 'Levicom'
    UNION
    SELECT 'INVOICEONE'
        UNION
    SELECT 'FacturaInteligente'
        UNION
    --SELECT 'ExpidetuFactura'
    -- UNION
    SELECT 'EKOMERCIO'
		UNION
    SELECT 'FormasDigitales'
    --    UNION
    --SELECT 'Servisim'
	--	UNION				--Bug 5234 (PRODRIGUEZ)
    --SELECT 'SERVICIOPAC'
  ELSE
    INSERT @Lista (Servidor)
    SELECT 'MYSUITEGUATEMALA'
  
  RETURN
END
GO
--SELECT * FROM dbo.fnListaTimbrarCFDIServidor(null)

--REQ Q3069 CFDGT
/**************** fnListaCFD_tipoDeComprobante ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnListaCFD_tipoDeComprobante') DROP FUNCTION fnListaCFD_tipoDeComprobante
GO
CREATE FUNCTION fnListaCFD_tipoDeComprobante
	(
	@Empresa			varchar(5)
	)
RETURNS @Lista TABLE
        (
	CFD_tipoDeComprobante		varchar(100)
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EsGuatemala			bit
  
  SELECT @EsGuatemala = 0
  SELECT @EsGuatemala = ISNULL(EsGuatemala,0) FROM Empresa WHERE Empresa = @Empresa
  
  IF @EsGuatemala = 0  
    INSERT @Lista (CFD_tipoDeComprobante)
    SELECT 'ingreso'
     UNION
    SELECT 'egreso'
     UNION
    SELECT 'traslado'
  ELSE
    INSERT @Lista (CFD_tipoDeComprobante)
    SELECT 'FACE63'
     UNION
    SELECT 'NCE64'
     UNION
    SELECT 'NDE65'

  RETURN
END
GO
--SELECT * FROM dbo.fnListaCFD_tipoDeComprobante(null)

--REQ Q3069 CFDGT
/**************** fnCFDVentafgtTipoActivo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDVentafgtTipoActivo') DROP FUNCTION fnCFDVentafgtTipoActivo
GO
CREATE FUNCTION fnCFDVentafgtTipoActivo
	(	
	@Modulo			varchar(5),
	@Mov			varchar(20)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(10)

  SELECT @Resultado = CFD_tipoDeComprobante FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
               
  RETURN (@Resultado)
END
GO
--SELECT dbo.fnCFDVentafgtTipoActivo('VTAS','Factura')

--REQ Q3069 CFDGT
/***************** CFDVentaMovImpuestofdgt *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaMovImpuestofdgt') AND TYPE = 'V') 
  DROP VIEW CFDVentaMovImpuestofdgt
GO
CREATE VIEW CFDVentaMovImpuestofdgt AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))))) + RTRIM(LTRIM(CONVERT(varchar,MovImpuesto.ModuloID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  MovImpuesto.ModuloID ID,
  CONVERT(varchar(50),'IVA') Impuesto,
  CONVERT(varchar(50),'VAT') ImpuestoClave,
  ISNULL(MovImpuesto.Impuesto1,0.00) Tasa,
  SUM(ISNULL(MovImpuesto.Importe1,0.00)*ISNULL(dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)),0.00)) Importe,
  'TRANSFERIDO' CategoriaImpuesto,
  MovImpuesto.SubTotal fdgtBaseImpuesto  
  FROM MovImpuesto
  JOIN Venta ON MovImpuesto.Modulo = 'VTAS' AND MovImpuesto.ModuloId = Venta.ID
  JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
  JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
 WHERE MovImpuesto.Modulo = 'VTAS'
   AND MovImpuesto.Excento1 <> 1
 GROUP BY MovImpuesto.ModuloID, MovImpuesto.Impuesto1, MovImpuesto.SubTotal
GO

--REQ Q3069 CFDGT
/**************** fnCFDVentafdgtFormEmail ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDVentafdgtFormEmail') DROP FUNCTION fnCFDVentafdgtFormEmail
GO
CREATE FUNCTION fnCFDVentafdgtFormEmail
	(	
	@Cliente			varchar(10),
	@Empresa			char(5)	
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255),
    @Perfil		varchar(255),
    @Enviar		bit

  SELECT @Perfil = DBMailPerfil FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT @Enviar = EnviarXML FROM CteCFD WHERE Cliente = @Cliente AND Almacenar = 1 AND AlmacenarTipo = 'ESPECIFICO'
    
  IF ISNULL(@Enviar,0) = 0
    SELECT @Enviar = CASE WHEN EnviarXML = 1 OR EnviarPDF = 1 THEN 1 ELSE 0 END FROM EmpresaCFD WHERE Empresa = @Empresa AND (AlmacenarPDF = 1 OR AlmacenarXML = 1) 

  IF ISNULL(@Enviar,0) = 1
    SELECT @Resultado = email_address FROM msdb.dbo.sysmail_account WHERE name = @Perfil
            
  RETURN (@Resultado)
END
GO
--SELECT dbo.fnCFDVentafdgtFormEmail('Intelisis','DEMO')

--REQ Q3069 CFDGT
/**************** fnCFDVentafdgtToEmail ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDVentafdgtToEmail') DROP FUNCTION fnCFDVentafdgtToEmail
GO
CREATE FUNCTION fnCFDVentafdgtToEmail 
	(
	@Cliente			varchar(10),
	@Empresa			char(5)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255),
    @Enviar		bit

  SELECT @Enviar = EnviarXML FROM CteCFD WHERE Cliente = @Cliente AND Almacenar = 1 AND AlmacenarTipo = 'ESPECIFICO'
    
  IF ISNULL(@Enviar,0) = 0
    SELECT @Enviar = CASE WHEN EnviarXML = 1 OR EnviarPDF = 1 THEN 1 ELSE 0 END FROM EmpresaCFD WHERE Empresa = @Empresa AND (AlmacenarPDF = 1 OR AlmacenarXML = 1) 

  IF ISNULL(@Enviar,0) = 1
    SELECT @Resultado = eMail1 FROM Cte WHERE Cliente = @Cliente
            
  RETURN (@Resultado)
END
GO
--SELECT dbo.fnCFDVentafdgtToEmail('01')

--REQ Q3069 CFDGT
/**************** fnCFDVentafdgtCcEmail ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDVentafdgtCcEmail') DROP FUNCTION fnCFDVentafdgtCcEmail
GO
CREATE FUNCTION fnCFDVentafdgtCcEmail
	(
	@Cliente			varchar(10),
	@Empresa			char(5)
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(max),
    @EnviarPara	varchar(255),
    @eMail		varchar(255),
    @Enviar		bit

  SELECT @Enviar = EnviarXML FROM CteCFD WHERE Cliente = @Cliente AND Almacenar = 1 AND AlmacenarTipo = 'ESPECIFICO'
    
  IF ISNULL(@Enviar,0) = 0
    SELECT @Enviar = CASE WHEN EnviarXML = 1 OR EnviarPDF = 1 THEN 1 ELSE 0 END FROM EmpresaCFD WHERE Empresa = @Empresa AND (AlmacenarPDF = 1 OR AlmacenarXML = 1) 

  IF ISNULL(@Enviar,0) = 1
  BEGIN
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
        IF @EnviarPara <> '' SELECT @EnviarPara = @EnviarPara+';'
        SELECT @EnviarPara = @EnviarPara + @eMail
      END
      FETCH NEXT FROM crCteCto INTO @eMail
    END
    CLOSE crCteCto
    DEALLOCATE crCteCto

    SELECT @Resultado = @EnviarPara
  END     
  
  RETURN (@Resultado)
END
GO
--SELECT dbo.fnCFDVentafdgtCcEmail('01')

--REQ Q3069 CFDGT
/**************** fnCFDVentafdgtFormatsEmail ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDVentafdgtFormatsEmail') DROP FUNCTION fnCFDVentafdgtFormatsEmail
GO
CREATE FUNCTION fnCFDVentafdgtFormatsEmail
	(
	@Cliente			varchar(10),
	@Empresa			char(5)
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(max),
    @EnviarXML	bit,
    @EnviarPDF	bit,
    @Enviar		bit
    

    SELECT @EnviarXML = EnviarXML, @EnviarPDF = EnviarPDF, @Enviar = Enviar
      FROM CteCFD 
     WHERE Cliente = @Cliente 
       AND Almacenar = 1 
       AND AlmacenarTipo = 'ESPECIFICO'
    IF @@ROWCOUNT = 0
      SELECT @Enviar = CASE WHEN EnviarXML = 1 OR EnviarPDF = 1 THEN 1 ELSE 0 END,
             @EnviarXML = EnviarXML, @EnviarPDF = EnviarPDF
        FROM EmpresaCFD 
       WHERE Empresa = @Empresa 
         AND (AlmacenarPDF = 1 OR AlmacenarXML = 1) 
  
  IF @Enviar = 1
    SELECT @Resultado = CASE WHEN @EnviarXML = 1 THEN 'XML,' END + CASE WHEN @EnviarPDF = 1 THEN 'PDF,' END
  
  IF LEN(@Resultado) > 0
    SELECT @Resultado = SUBSTRING(@Resultado, 0, LEN(@Resultado)-1)    
            
  RETURN (@Resultado)
END
GO
--SELECT dbo.fnCFDVentafdgtFormatsEmail('01', 'demo')

--REQ Q3069 CFDGT
/**************** fnCFDVentafdgtInformacionDeRegimenIsr ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDVentafdgtInformacionDeRegimenIsr') DROP FUNCTION fnCFDVentafdgtInformacionDeRegimenIsr
GO
CREATE FUNCTION fnCFDVentafdgtInformacionDeRegimenIsr 
	(
	@Empresa			char(5)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = FiscalRegimen FROM Empresa WHERE Empresa = @Empresa
            
  RETURN (@Resultado)
END
GO
--SELECT dbo.fnCFDVentafdgtInformacionDeRegimenIsr('01')

--REQ Q3069 CFDGT
/**************** fnCFDVentafdgtDispositivoElectronicoVendedor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDVentafdgtDispositivoElectronicoVendedor') DROP FUNCTION fnCFDVentafdgtDispositivoElectronicoVendedor
GO
CREATE FUNCTION fnCFDVentafdgtDispositivoElectronicoVendedor 
	(
	@Empresa			char(5)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

            
  RETURN (ISNULL(@Resultado,'No Aplica'))
END
GO
--SELECT dbo.fnCFDVentafdgtDispositivoElectronicoVendedor('01')

--REQ Q3069 CFDGT
/***************** CFDVentafdgt *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentafdgt') AND TYPE = 'V') 
  DROP VIEW CFDVentafdgt
GO
CREATE VIEW CFDVentafdgt AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Venta.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Venta.ID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  Venta.ID ID,
  dbo.fnSerieConsecutivo(Venta.MovID) VentaSerie,  
  dbo.fnFolioConsecutivo(Venta.MovID) VentaFolio,  
  CONVERT(datetime,Venta.FechaRegistro, 126) VentaFechaRegistro,
  Venta.Condicion VentaCondicion,
   vtce.ImporteDescuentoGlobal*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImporteDescuentoGlobal,
   vtce.ImporteSobrePrecio*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImporteSobrePrecio,
   (vtce.SubTotal -ISNULL((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0)),0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaSubTotal ,
   (vtce.Impuesto1Total-ISNULL(AnticiposImpuestos,0.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImpuesto1Total,
   vtce.Impuesto2Total*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImpuesto2Total,
   vtce.Impuesto3Total*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImpuesto3Total,
   (vtce.ImporteTotal-ISNULL((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0)),0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImporteTotal,
   --vtce.TotalNeto*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaTotal,
  ((vtce.ImporteTotal-ISNULL((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0)),0))-(ISNULL(Venta.Retencion,0.0)+ISNULL(AnticiposImpuestos,0.0)))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaTotal,  
  
  vtce.DescuentosTotales*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDescuentoImporte,
  (vtce.Impuestos-ISNULL(AnticiposImpuestos,0.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaImpuestos,
  Venta.FormaPagoTipo VentaFormaPago,
  LOWER(mt.CFD_TipoDeComprobante) VentaTipoComprobante,    
  CASE WHEN Venta.Estatus IN ('CONCLUIDO','PENDIENTE') THEN 'ORIGINAL' ELSE 'DELETE' END VentaEstatusCancelacion,
  CASE 
    WHEN mt.Clave IN ('VTAS.F','VTAS.FM','VTAS.FR') THEN 'INVOICE'
    WHEN mt.Clave IN ('VTAS.B','VTAS.D','VTAS.DF')  THEN 'CREDIT_NOTE' 
  END VentaTipoDocumento,
  Venta.Mov VentaMov, 
  Venta.MovID VentaMovID,
  dbo.fnNumeroEnEspanol(vtce.TotalNeto, CASE WHEN ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN) = 1 THEN 'M.N.' ELSE Venta.Moneda END) VentaImporteSinRetencionesLetra,
  dbo.fnNumeroEnEspanol(vtce.TotalNeto-ISNULL(Venta.Retencion,0.00), CASE WHEN ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN) = 1 THEN 'M.N.' ELSE Venta.Moneda END) VentaImporteLetra,
  Venta.OrdenCompra VentaOrdenCompra,
  Venta.FechaOrdenCompra VentaOrdenCompraFecha,
  CASE WHEN ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN) = 1 THEN 'M.N.' ELSE Venta.Moneda END VentaMoneda,
  Venta.TipoCambio VentaTipoCambio,
  Venta.Estatus VentaEstatus,
  Venta.Departamento,
  Venta.Retencion VentaRetencionTotal,
  Venta.Vencimiento VentaVencimiento,
  Venta.FechaRequerida VentaFechaRequerida,
  Venta.FechaOrdenCompra VentaFechaOrdenCompra,
  Venta.ReferenciaOrdenCompra VentaReferenciaOrdenCompra,
  Venta.Atencion VentaAtencion,
  Venta.Observaciones VentaObservaciones,
  Venta.AtencionTelefono VentaAtencionTelefono,
  Venta.Referencia VentaReferencia,
  NULLIF(RIGHT(Venta.Referencia, 4),'no indentificado') NumCtaPago,
  mt.Clave VentaClaveAfectacion,
  mt.SubClave VentaSubClaveAfectacion,
  Empresa.GLN EmpresaGLN,
  Empresa.Nombre EmpresaNombre,
  REPLACE(Empresa.RFC,'-','') EmpresaRFC,
  Empresa.Direccion EmpresaCalle,
  Empresa.DireccionNumero EmpresaNumeroExterior,
  Empresa.DireccionNumeroInt EmpresaNumeroInterior,
  Empresa.Colonia EmpresaColonia,
  Empresa.Poblacion EmpresaLocalidad,
  Empresa.Delegacion EmpresaMunicipio,
  Empresa.Estado EmpresaEstado,
  Empresa.Pais EmpresaPais,
  Empresa.CodigoPostal EmpresaCodigoPostal,
  Sucursal.Sucursal Sucursal,
  Sucursal.GLN SucursalGLN,
  Sucursal.Nombre SucursalNombre,
  REPLACE(Sucursal.RFC,'-','') SucursalRFC,
  Sucursal.Direccion SucursalCalle,
  Sucursal.DireccionNumero SucursalNumeroExterior,
  Sucursal.DireccionNumeroInt SucursalNumeroInterior,
  Sucursal.Colonia SucursalColonia,
  Sucursal.Delegacion + ', ' + Sucursal.Estado SucursalLocalidad,
  Sucursal.Delegacion SucursalMunicipio,
  Sucursal.Estado SucursalEstado,
  Sucursal.Pais SucursalPais,
  Sucursal.CodigoPostal SucursalCodigoPostal,

  CteEnviarA.GLN CteEnviarAGLN,
  CteEnviarA.Nombre CteEnviarANombre,
  CteEnviarA.Direccion CteEnviarACalle,
  CteEnviarA.DireccionNumero CteEnviarANumeroExterior,
  CteEnviarA.DireccionNumeroInt CteEnviarANumeroInterior,
  CteEnviarA.Colonia CteEnviarAColonia,
  CteEnviarA.Poblacion CteEnviarALocalidad,
  CteEnviarA.Delegacion CteEnviarAMunicipio,
  CteEnviarA.Estado CteEnviarAEstado,
  CteEnviarA.Pais CteEnviarAPais,
  CteEnviarA.CodigoPostal CteEnviarACodigoPostal,
  CteEnviarA.Clave CteEnviarAClave,

  CteEmpresaCFD.EmisorID ClienteEmisorID,
  ISNULL(CteDeptoEnviarA.ProveedorID, CteEmpresaCFD.ProveedorID) ClienteProveedorID,
  Cte.Cliente ClienteClave,
  Cte.Nombre ClienteNombre,
  REPLACE(Cte.RFC,'-','') ClienteRFC,
  Cte.GLN ClienteGLN,  
  Cte.Direccion ClienteCalle,
  Cte.DireccionNumero ClienteNumeroExterior,
  Cte.DireccionNumeroInt ClienteNumeroInterior,
  Cte.Colonia ClienteColonia,
  Cte.Poblacion ClienteLocalidad,
  Cte.Delegacion ClienteMunicipio,
  Cte.Estado ClienteEstado,
  Cte.Pais ClientePais,
  Cte.CodigoPostal ClienteCodigoPostal,
  Cte.Telefonos ClienteTelefonos,
  RTRIM(ISNULL(Cte.Direccion,'') + ' ' + ISNULL(Cte.DireccionNumero,'') + ' ' + ISNULL(Cte.DireccionNumeroInt,'')) + ', ' + ISNULL(Cte.Colonia,'') ClienteDireccion,
  CASE 
    WHEN Condicion.TipoCondicion = 'Credito' THEN 'DATE_OF_INVOICE' 
    WHEN Condicion.TipoCondicion = 'Contado' THEN 'EFFECTIVE_DATE'
  END VentaTipoPago,   
  Cte.PersonalCobrador ClientePersonalCobrador,
  CteCFD.ReceptorID ClienteReceptorID,
  CteDepto.Clave CteDeptoClave,
  CteDepto.Contacto CteDeptocontacto,
  ISNULL(Condicion.DiasVencimiento,0) CondicionDiasVencimiento,
  Condicion.CFD_MetodoDePago CondicionMetodoDePago, 
  Condicion.CFD_FormaDePago CondicionFormaDePago,
  Condicion.DescuentoProntoPago CondicionDescuentoProntoPago,
  Descuento.Clave VentaDescuentoGlobalClave,
  Descuento.Porcentaje VentaPorcentajeDescuentoGlobal,
  CFDFolio.fechaAprobacion CFDFoliofechaAprobacion,
  CFDFolio.FolioD CFDFolioFolioD,
  CFDFolio.FolioA CFDFolioFolioA,
  CFDFolio.noAprobacion CFDFolionoAprobacion,
  GETDATE() VariosAhora,
  RTRIM('VTAS')+CONVERT(varchar, Venta.ID) VariosModuloID,
  VentaEntrega.Embarque	VentaEntregaEmbarque,
  VentaEntrega.EmbarqueFecha VentaEntregaEmbarqueFecha,
  VentaEntrega.EmbarqueReferencia VentaEntregaEmbarqueReferencia,
  VentaEntrega.Recibo VentaEntregaRecibo,
  VentaEntrega.ReciboFecha VentaEntregaReciboFecha,
  VentaEntrega.ReciboReferencia VentaEntregaReciboReferencia,
  VentaEntrega.Sucursal VentaEntregaSucursal,
  VentaEntrega.SucursalOrigen VentaEntregaSucursalOrigen,
  VentaEntrega.EntregaMercancia VentaEntregaEntregaMercancia,
  VentaEntrega.TotalCajas VentaEntregaTotalCajas,

  CFD.Modulo CFDModulo,
  CFD.ModuloID CFDModuloID,
  CFD.Fecha CFDFecha,
  CFD.Ejercicio CFDEjercicio,
  CFD.Periodo CFDPeriodo,
  CFD.Empresa CFDEmpresa,
  CFD.MovID CFDMovID,
  CFD.Serie CFDSerie,
  CFD.Folio CFDFolio,
  CFD.RFC CFDRFC,
  CFD.Aprobacion CFDAprobacion,
  CFD.Importe CFDImporte,
  CFD.Impuesto1 CFDImpuesto1,
  CFD.Impuesto2 CFDImpuesto2,
  CFD.FechaCancelacion CFDFechaCancelacion,
  CFD.noCertificado CFDnoCertificado,
  CFD.Sello CFDSello,
  CFD.CadenaOriginal CFDCadenaOriginal,
  CFD.CadenaOriginal1 CFDCadenaOriginal1,
  CFD.CadenaOriginal2 CFDCadenaOriginal2,
  CFD.CadenaOriginal3 CFDCadenaOriginal3,
  CFD.CadenaOriginal4 CFDCadenaOriginal4,
  CFD.CadenaOriginal5 CFDCadenaOriginal5,
  CFD.GenerarPDF CFDGenerarPDF,
  CFD.Retencion1 CFDRetencion1,
  CFD.Retencion2 CFDRetencion2,
  CFD.TipoCambio CFDTipoCambio,
  CFD.Timbrado CFDTimbrado,
  CFD.UUID CFDUUID,
  CFD.FechaTimbrado CFDFechaTimbrado,
  CFD.SelloSAT CFDSelloSAT,
  CFD.TFDVersion CFDTFDVersion,
  CFD.noCertificadoSAT CFDnoCertificadoSAT,
  
  dbo.fnCFDVentafdgtFormEmail(Venta.Cliente, Venta.Empresa) fdgtFormEmail,
  dbo.fnCFDVentafdgtToEmail(Venta.Cliente, Venta.Empresa) fdgtToEmail,
  dbo.fnCFDVentafdgtCcEmail(Venta.Cliente, Venta.Empresa)  fdgtCcEmail,
  dbo.fnCFDVentafdgtFormatsEmail(Venta.Cliente, Venta.Empresa) fdgtFormatsEmail,
  
  dbo.fnCFDVentafdgtInformacionDeRegimenIsr(Venta.Empresa) fdgtInformacionDeRegimenIsr,
  dbo.fnCFDVentafdgtDispositivoElectronicoVendedor(Venta.Empresa) fdgtDispositivoElectronicoVendedor,
  mt.CFD_tipoDeComprobante mtTipoDeCombrobante
  FROM Venta JOIN Empresa
    ON Venta.Empresa = Empresa.Empresa JOIN EmpresaGral
    ON Empresa.Empresa = EmpresaGral.Empresa JOIN Cte
    ON Cte.Cliente = Venta.Cliente JOIN Sucursal
    ON Venta.Sucursal = Sucursal.Sucursal JOIN VentaTCalcExportacion vtce
    ON vtce.ID = Venta.ID JOIN MovTipo mt
    ON mt.Mov = Venta.Mov AND mt.Modulo = 'VTAS' LEFT OUTER JOIN EmpresaCFD 
    ON Venta.Empresa = EmpresaCFD.Empresa LEFT OUTER JOIN Condicion
    ON Condicion.Condicion = Venta.Condicion LEFT OUTER JOIN Descuento
    ON Descuento.Descuento = Venta.Descuento LEFT OUTER JOIN CFDFolio 
    ON CFDFolio.Empresa = Venta.Empresa
       AND CFDFolio.Modulo = mt.ConsecutivoModulo
       AND CFDFolio.Mov = mt.ConsecutivoMov
       AND CFDFolio.FechaAprobacion <= Venta.FechaRegistro 
       AND dbo.fnFolioConsecutivo(Venta.MovID) BETWEEN CFDFolio.FolioD AND CFDFolio.FolioA  
       AND ISNULL(dbo.fnSerieConsecutivo(Venta.MovID),'') = ISNULL(CFDFolio.Serie,'')
       --AND Venta.Sucursal = ISNULL(ISNULL(CFDFolio.Sucursal,0),Venta.Sucursal)
	   AND (CASE WHEN ISNULL(CFDFolio.Nivel,'') = 'Sucursal' THEN ISNULL(CFDFolio.Sucursal,0) ELSE Venta.Sucursal END) = Venta.Sucursal
       AND CFDFolio.Estatus = 'ALTA' 
       LEFT OUTER JOIN CteEmpresaCFD 
    ON Venta.Cliente = CteEmpresaCFD.Cliente AND Venta.Empresa = CteEmpresaCFD.Empresa LEFT OUTER JOIN   CteDeptoEnviarA
    ON CteDeptoEnviarA.Empresa = Venta.Empresa AND CteDeptoEnviarA.Departamento = Venta.Departamento AND CteDeptoEnviarA.Cliente = Venta.Cliente AND CteDeptoEnviarA.EnviarA = Venta.EnviarA LEFT OUTER JOIN CteCFD
    ON CteCFD.Cliente = Venta.Cliente LEFT OUTER JOIN VentaEntrega 
    ON Venta.ID = VentaEntrega.ID LEFT OUTER JOIN CteEnviarA 
    ON Venta.Cliente = CteEnviarA.Cliente AND Venta.EnviarA = CteEnviarA.ID LEFT OUTER JOIN CteDepto
    ON Venta.Cliente = CteDepto.Cliente AND Venta.Departamento=CteDepto.Departamento LEFT OUTER JOIN CFD
    ON CFD.ModuloID = Venta.ID AND CFD.Modulo = 'VTAS'
GO

--REQ Q3069 CFDGT
/***************** CFDVentaDfdgt *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDfdgt') AND TYPE = 'V') 
  DROP VIEW CFDVentaDfdgt
GO
CREATE VIEW CFDVentaDfdgt AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion,
  Venta.Cliente VentaCliente,
  VentaD.ID, 
  VentaD.Cantidad VentaDCantidad,
  VentaD.CantidadInventario VentaDCantidadInventario,
  VentaD.Unidad VentaDUnidad,
  Unidad.Clave UnidadClave,
  VentaD.Articulo VentaDArticulo,
  dbo.fnQueCodigo(EmpresaCFD.EAN13, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) EAN13,
  dbo.fnQueCodigo(EmpresaCFD.SKU, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) SKUCliente,
  dbo.fnQueCodigo(EmpresaCFD.SKUEmpresa, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) SKUEmpresa,
  dbo.fnQueCodigo(EmpresaCFD.DUN14, VentaD.Articulo, VentaD.SubCuenta, VentaD.Codigo, Venta.Cliente) DUN14,
  Art.Descripcion1 VentaDDescripcion,
  Art.Descripcion2 VentaDDescripcion2,
  Art.TipoEmpaque ArtTipoEmpaque,
  CASE WHEN Vtc.Precio IS NULL THEN 0.0 ELSE (Vtc.Precio*dbo.fneDocVentaFactorPrecio(VentaD.ID, VentaD.Renglon, VentaD.RenglonSub))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) END VentaDPrecio,
  CASE WHEN Vtc.PrecioTotal IS NULL THEN 0.0 ELSE (Vtc.PrecioTotal*dbo.fneDocVentaFactorPrecio(VentaD.ID, VentaD.Renglon, VentaD.RenglonSub))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) END VentaDPrecioTotal,
  Vtc.DescuentoLinea*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDDescuentoLinea,
  VentaD.DescuentoImporte*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDDescuentoImporte,
  vtc.Impuesto1 ventaDImpuesto1, 
  vtc.Impuesto2 ventaDImpuesto2, 
  vtc.Importe*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImporte,
  (Vtc.Importe/Vtc.Cantidad)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImporteUnitario,
  vtc.DescuentoLineal*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDDescLineal,
  vtc.DescuentosTotales*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDDescuentosTotales,
  vtc.ImporteSobrePrecio*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImporteSobrePrecio,
  CASE WHEN ISNULL(Art.Impuesto1Excento,0) = 1 THEN 0 ELSE vtc.SubTotal*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) END VentaDSubTotal,
  (vtc.SubTotal/Vtc.Cantidad)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDSubTotalUnitario,
  vtc.Impuesto1Total*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImpuesto1Total,
  vtc.Impuesto2Total*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImpuesto2Total,
  vtc.Impuestos*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImpuestos,
  vtc.ImporteTotal*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDImporteTotal,
  vtc.TotalNeto*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) VentaDTotalNeto,  
  TipoEmpaque.Clave TipoEmpaqueClave,
  TipoEmpaque.Tipo TipoEmpaqueTipo,

  VentaD.Renglon VentaDRenglon,
  VentaD.RenglonSub VentaDRenglonSub,
  VentaD.RenglonID VentaDRenglonID,
  VentaD.RenglonTipo VentaDRenglonTipo,
  VentaD.Almacen VentaDAlmacen,
  VentaD.EnviarA VentaDEnviarA,
  VentaD.Codigo VentaDCodigo,
  VentaD.SubCuenta VentaDSubCuenta,
  VentaD.PrecioSugerido VentaDPrecioSugerido,
  VentaD.DescuentoTipo VentaDDescuentoTipo,
  VentaD.Impuesto3 VentaDImpuesto3,
  VentaD.DescripcionExtra VentaDDescripcionExtra,
  VentaD.Costo VentaDCosto,
  VentaD.CostoActividad VentaDCostoActividad,
  VentaD.Paquete VentaDPaquete,
  VentaD.ContUso VentaDContUso,
  VentaD.Comision VentaDComision,
  VentaD.Aplica VentaDAplica,
  VentaD.AplicaID VentaDAplicaID,
  VentaD.CantidadPendiente VentaDCantidadPendiente,
  VentaD.CantidadReservada VentaDCantidadReservada,
  VentaD.CantidadCancelada VentaDCantidadCancelada,
  VentaD.CantidadOrdenada VentaDCantidadOrdenada,
  VentaD.CantidadEmbarcada VentaDCantidadEmbarcada,
  VentaD.CantidadA VentaDCantidadA,
  VentaD.Factor VentaDFactor,
  VentaD.SustitutoArticulo VentaDSustitutoArticulo,
  VentaD.SustitutoSubCuenta VentaDSustitutoSubCuenta,
  VentaD.FechaRequerida VentaDFechaRequerida,
  VentaD.HoraRequerida VentaDHoraRequerida,
  VentaD.Instruccion VentaDInstruccion,
  VentaD.Agente VentaDAgente,
  VentaD.Departamento VentaDDepartamento,
  VentaD.UltimoReservadoCantidad VentaDUltimoReservadoCantidad,
  VentaD.UltimoReservadoFecha VentaDUltimoReservadoFecha,
  VentaD.Sucursal VentaDSucursal,
  VentaD.PoliticaPrecios VentaDPoliticaPrecios,
  VentaD.SucursalOrigen VentaDSucursalOrigen,
  VentaD.AutoLocalidad VentaDAutoLocalidad,
  VentaD.UEN VentaDUEN,
  VentaD.Espacio VentaDEspacio,
  VentaD.CantidadAlterna VentaDCantidadAlterna,
  VentaD.PrecioMoneda VentaDPrecioMoneda,
  VentaD.PrecioTipoCambio VentaDPrecioTipoCambio,
  VentaD.Estado VentaDEstado,
  VentaD.ServicioNumero VentaDServicioNumero,
  VentaD.AgentesAsignados VentaDAgentesAsignados,
  VentaD.AFArticulo VentaDAFArticulo,
  VentaD.ExcluirPlaneacion VentaDExcluirPlaneacion,
  VentaD.Anexo VentaDAnexo,
  VentaD.AjusteCosteo VentaDAjusteCosteo,
  VentaD.CostoUEPS VentaDCostoUEPS,
  VentaD.CostoPEPS VentaDCostoPEPS,
  VentaD.UltimoCosto VentaDUltimoCosto,
  VentaD.PrecioLista VentaDPrecioLista,
  VentaD.DepartamentoDetallista VentaDDepartamentoDetallista,
  VentaD.PresupuestoEsp VentaDPresupuestoEsp,
  VentaD.Posicion VentaDPosicion,
  VentaD.Puntos VentaDPuntos,
  VentaD.CantidadObsequio VentaDCantidadObsequio,
  VentaD.OfertaID VentaDOfertaID,
  VentaD.ProveedorRef VentaDProveedorRef,
  VentaD.TransferirA VentaDTransferirA,
  VentaD.ArtEstatus VentaDArtEstatus,
  VentaD.ArtSituacion VentaDArtSituacion,
  VentaD.Tarima VentaDTarima,
  VentaD.ExcluirISAN VentaDExcluirISAN,
  VentaD.ContUso2 VentaDContUso2,
  VentaD.ContUso3 VentaDContUso3,
  VentaD.CostoEstandar VentaDCostoEstandar,
  VentaD.ABC VentaDABC,
  VentaD.OrdenCompra VentaDOrdenCompra,
  VentaD.TipoImpuesto1 VentaDTipoImpuesto1,
  VentaD.TipoImpuesto2 VentaDTipoImpuesto2,
  VentaD.TipoImpuesto3 VentaDTipoImpuesto3,
  VentaD.CostoPromedio VentaDCostoPromedio,
  VentaD.CostoReposicion VentaDCostoReposicion,
  VentaD.TipoComprobante VentaDTipoComprobante,
  VentaD.SustentoComprobante VentaDSustentoComprobante,
  VentaD.TipoIdentificacion VentaDTipoIdentificacion,
  VentaD.DerechoDevolucion VentaDDerechoDevolucion,
  VentaD.Establecimiento VentaDEstablecimiento,
  VentaD.PuntoEmision VentaDPuntoEmision,
  VentaD.SecuencialSRI VentaDSecuencialSRI,
  VentaD.AutorizacionSRI VentaDAutorizacionSRI,
  VentaD.VigenteA VentaDVigenteA,
  VentaD.SecuenciaRetencion VentaDSecuenciaRetencion,
  VentaD.Comprobante VentaDComprobante,
  VentaD.FechaContableMov VentaDFechaContableMov,
  NULL AS VentaDTipoRetencion1,
  NULL AS VentaDTipoRetencion2,
  NULL AS VentaDTipoRetencion3,
  NULL AS VentaDRetencion1,
  NULL AS VentaDRetencion2,
  NULL AS VentaDRetencion3,

  'DESCUENTO' fdgtOperacion,
  VentaDPrecioSugerido-VentaDImpuestos fdgtBase,
  ISNULL(VentaDDescuentoLinea,0) fdgtTasa,
  ISNULL(VentaDDescLineal,0.00)  fdgtMonto,

  ISNULL(VentaD.Impuesto1,0.0) VentaDImpuestoTasa,
  CASE WHEN ISNULL(VentaD.Impuesto1,0.0) > 0.0 THEN (VentaD.Precio*(ISNULL(VentaD.Impuesto1,0.0)/100.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) ELSE 0.0 END VentaDImpuestoImporte,
  VentaD.Precio*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) fdgtBaseImpuesto,
  
  vtc.DescuentoLinealSinDL,
  vtc.PrecioSinDL,
  vtc.DescuentosTotalesSinDL,
  vtc.ImporteSinDL,
  CASE Art.Tipo WHEN 'Servicio' THEN 'SERVICIO' ELSE 'BIEN' END fdgtCategoria
  FROM VentaD JOIN Art
    ON VentaD.Articulo = Art.Articulo JOIN VentaTCalc vtc
    ON vtc.ID = VentaD.ID AND vtc.Renglon = VentaD.Renglon AND vtc.RenglonSub = VentaD.RenglonSub LEFT OUTER JOIN Unidad 
    ON Unidad.Unidad = VentaD.Unidad LEFT OUTER JOIN ArtProv
    ON ArtProv.Proveedor = Art.Proveedor AND ArtProv.Articulo = Art.Articulo JOIN Venta
    ON Venta.ID = VentaD.ID LEFT OUTER JOIN EmpresaCFD 
    ON EmpresaCFD.Empresa = Venta.Empresa LEFT OUTER JOIN TipoEmpaque
    ON Art.tipoEmpaque=TipoEmpaque.TipoEmpaque JOIN MovTipo mt
    ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov JOIN CFDVentaD
    ON CFDVentaD.ID = VentaD.ID AND CFDVentaD.VentaDRenglon = VentaD.Renglon AND CFDVentaD.VentaDRenglonSub = VentaD.RenglonSub
UNION
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Venta.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Venta.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,'999999999999'))))) + RTRIM(LTRIM(CONVERT(varchar,'999999999999'))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,'0'))))) + RTRIM(LTRIM(CONVERT(varchar,'0'))) +
  REPLICATE(' ',50)
  OrdenExportacion,
  Venta.Cliente VentaCliente,
  Venta.ID, 
  '1' VentaDCantidad,
  NULL AS VentaDCantidadInventario,
  'PIEZA' AS VentaDUnidad,
  NULL AS UnidadClave,
  'ANTICIPO' AS VentaDArticulo,
  NULL AS EAN13,
  NULL AS SKUCliente,
  NULL AS SKUEmpresa,
  NULL AS DUN14,
  'Anticipo Facturado' AS VentaDDescripcion,
  NULL AS VentaDDescripcion2,
  NULL AS ArtTipoEmpaque,
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDPrecio,
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDPrecioTotal,
  NULL AS VentaDDescuentoLinea,
  NULL AS VentaDDescuentoImporte,
  ((AnticiposImpuestos*100/(AnticiposFacturados-AnticiposImpuestos))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS ventaDImpuesto1, 
  NULL AS ventaDImpuesto2, 
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImporte,
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImporteUnitario,
  NULL AS VentaDDescLineal,
  NULL AS VentaDDescuentosTotales,
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImporteSobrePrecio,
  ((AnticiposFacturados-ISNULL(AnticiposImpuestos,0.0))*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDSubTotal,
  NULL AS VentaDSubTotalUnitario,
  ((AnticiposImpuestos)*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImpuesto1Total,
  NULL AS VentaDImpuesto2Total,
  ((AnticiposImpuestos)*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImpuestos,
  ((AnticiposFacturados)*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDImporteTotal,
  ((AnticiposFacturados)*-1)*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) AS VentaDTotalNeto,  
  NULL AS TipoEmpaqueClave,
  NULL AS TipoEmpaqueTipo,

  NULL AS VentaDRenglon,
  NULL AS VentaDRenglonSub,
  NULL AS VentaDRenglonID,
  NULL AS VentaDRenglonTipo,
  NULL AS VentaDAlmacen,
  NULL AS VentaDEnviarA,
  NULL AS VentaDCodigo,
  NULL AS VentaDSubCuenta,
  NULL AS VentaDPrecioSugerido,
  NULL AS VentaDDescuentoTipo,
  NULL AS VentaDImpuesto3,
  NULL AS VentaDDescripcionExtra,
  NULL AS VentaDCosto,
  NULL AS VentaDCostoActividad,
  NULL AS VentaDPaquete,
  NULL AS VentaDContUso,
  NULL AS VentaDComision,
  NULL AS VentaDAplica,
  NULL AS VentaDAplicaID,
  NULL AS VentaDCantidadPendiente,
  NULL AS VentaDCantidadReservada,
  NULL AS VentaDCantidadCancelada,
  NULL AS VentaDCantidadOrdenada,
  NULL AS VentaDCantidadEmbarcada,
  NULL AS VentaDCantidadA,
  NULL AS VentaDFactor,
  NULL AS VentaDSustitutoArticulo,
  NULL AS VentaDSustitutoSubCuenta,
  NULL AS VentaDFechaRequerida,
  NULL AS VentaDHoraRequerida,
  NULL AS VentaDInstruccion,
  NULL AS VentaDAgente,
  NULL AS VentaDDepartamento,
  NULL AS VentaDUltimoReservadoCantidad,
  NULL AS VentaDUltimoReservadoFecha,
  NULL AS VentaDSucursal,
  NULL AS VentaDPoliticaPrecios,
  NULL AS VentaDSucursalOrigen,
  NULL AS VentaDAutoLocalidad,
  NULL AS VentaDUEN,
  NULL AS VentaDEspacio,
  NULL AS VentaDCantidadAlterna,
  NULL AS VentaDPrecioMoneda,
  NULL AS VentaDPrecioTipoCambio,
  NULL AS VentaDEstado,
  NULL AS VentaDServicioNumero,
  NULL AS VentaDAgentesAsignados,
  NULL AS VentaDAFArticulo,
  NULL AS VentaDExcluirPlaneacion,
  NULL AS VentaDAnexo,
  NULL AS VentaDAjusteCosteo,
  NULL AS VentaDCostoUEPS,
  NULL AS VentaDCostoPEPS,
  NULL AS VentaDUltimoCosto,
  NULL AS VentaDPrecioLista,
  NULL AS VentaDDepartamentoDetallista,
  NULL AS VentaDPresupuestoEsp,
  NULL AS VentaDPosicion,
  NULL AS VentaDPuntos,
  NULL AS VentaDCantidadObsequio,
  NULL AS VentaDOfertaID,
  NULL AS VentaDProveedorRef,
  NULL AS VentaDTransferirA,
  NULL AS VentaDArtEstatus,
  NULL AS VentaDArtSituacion,
  NULL AS VentaDTarima,
  NULL AS VentaDExcluirISAN,
  NULL AS VentaDContUso2,
  NULL AS VentaDContUso3,
  NULL AS VentaDCostoEstandar,
  NULL AS VentaDABC,
  NULL AS VentaDOrdenCompra,
  NULL AS VentaDTipoImpuesto1,
  NULL AS VentaDTipoImpuesto2,
  NULL AS VentaDTipoImpuesto3,
  NULL AS VentaDCostoPromedio,
  NULL AS VentaDCostoReposicion,
  NULL AS VentaDTipoComprobante,
  NULL AS VentaDSustentoComprobante,
  NULL AS VentaDTipoIdentificacion,
  NULL AS VentaDDerechoDevolucion,
  NULL AS VentaDEstablecimiento,
  NULL AS VentaDPuntoEmision,
  NULL AS VentaDSecuencialSRI,
  NULL AS VentaDAutorizacionSRI,
  NULL AS VentaDVigenteA,
  NULL AS VentaDSecuenciaRetencion,
  NULL AS VentaDComprobante,
  NULL AS VentaDFechaContableMov,
  NULL AS VentaDTipoRetencion1,
  NULL AS VentaDTipoRetencion2,
  NULL AS VentaDTipoRetencion3,
  NULL AS VentaDRetencion1,
  NULL AS VentaDRetencion2,
  NULL AS VentaDRetencion3,

  NULL AS fdgtOperacion,
  NULL AS fdgtBase,
  NULL AS fdgtTasa,
  NULL AS fdgtMonto,

  NULL AS VentaDImpuestoTasa,
  NULL AS VentaDImpuestoImporte,
  NULL AS fdgtBaseImpuesto,
  NULL AS DescuentoLinealSinDL,
  NULL AS PrecioSinDL,
  NULL AS DescuentosTotalesSinDL,
  NULL AS ImporteSinDL,
  NULL AS fdgtCategoria
  FROM Venta 
  JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
  JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
 WHERE AnticiposFacturados IS NOT NULL
GO

--REQ Q3069 CFDGT
/***************** CFDVentaDescuentofdgt *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDescuentofdgt') AND TYPE = 'V') 
  DROP VIEW CFDVentaDescuentofdgt
GO
CREATE VIEW CFDVentaDescuentofdgt AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,ID))) +
  REPLICATE(' ',12) + 
  REPLICATE(' ',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  ID,
  SUM(ImporteSinDL) Base,
  CONVERT(DECIMAL(10,2),(fdgtTasa)) Tasa,
  SUM(ISNULL(DescuentoLinealSinDL,0.0)) Importe  
  FROM CFDVentaDfdgt
 GROUP BY ID, CONVERT(DECIMAL(10,2),(fdgtTasa))
GO

/* *********************************************     FUNCIONES     **********************************************/

/**************** fneDocComillas ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocComillas') DROP FUNCTION fneDocComillas
GO
CREATE FUNCTION fneDocComillas 
	(
	@Texto				varchar(max) = ''
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TextoConComillas	varchar(max)

    SELECT @Texto = REPLACE(@Texto, CHAR(39), CHAR(39)+CHAR(39))
    
    IF SUBSTRING(ISNULL(@Texto,''),1,1) = CHAR(39)
      SET @Texto = CHAR(39) + ISNULL(@Texto,'') + CHAR(39) 
      
    SET @TextoConComillas = CHAR(39) + ISNULL(@Texto,'') + CHAR(39)
    
    
  RETURN (@TextoConComillas)
END
GO

/**************** fneDocLimpiarXML ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocLimpiarXML') DROP FUNCTION fneDocLimpiarXML
GO
CREATE FUNCTION fneDocLimpiarXML 
	(
	@XML				varchar(max),
	@TagSostener		varchar(max)
	)
RETURNS varchar(max)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Seguir				bit,
    @AtributoVacio		varchar(255),
    @Posicion			bigint,
    @Caracter			char(1),
    @Contador			int,
    @Atributo			varchar(255)
    
  --Quita los espacios de todos los atributos del xml que no esten en la lista a respetar
  SET @XML = '<?xml version="1.0" encoding="Windows-1252"?>' + @XML
  SELECT @XML = CONVERT(varchar(max),CONVERT(xml,@XML))
   
  SELECT @Seguir = 1, @AtributoVacio = '=""', @Posicion = 0  
  WHILE @Seguir = 1
  BEGIN
    SET @Posicion = ISNULL(PATINDEX('%=""%',@XML),0)      
    IF @Posicion > 0 
    BEGIN
      SET @Contador = @Posicion - 1
      SET @Caracter = SUBSTRING(@XML,@Contador,1)
      SET @AtributoVacio = '=""'
      WHILE @Caracter <> CHAR(32)
      BEGIN        
        SET @AtributoVacio = @Caracter + @AtributoVacio
        SET @Contador = @Contador - 1
        SET @Caracter = SUBSTRING(@XML,@Contador,1)
      END
	  SET @AtributoVacio = CHAR(32) + @AtributoVacio
      SELECT @Atributo = RTRIM(REPLACE(@AtributoVacio,'=""',''))
      IF ISNULL(PATINDEX('%' + @Atributo + '%',@TagSostener),0) = 0
        SET @XML = REPLACE(@XML,@AtributoVacio,'')
      ELSE
        SET @XML = REPLACE(@XML,@AtributoVacio,@Atributo + '="' + '_TAGRESPETAR_' + '"')
    END
     
    ELSE IF @Posicion = 0
      SET @Seguir = 0
  END   

  --Borra los valores de los tags que se van a respetar
  SET @Seguir = 1
  WHILE @Seguir = 1
  BEGIN
    SET @Posicion = ISNULL(PATINDEX('%="_TAGRESPETAR_"%',@XML),0)      
    IF @Posicion > 0 
    BEGIN
      SET @XML = REPLACE(@XML,'="_TAGRESPETAR_"','=""')
    END
    ELSE IF @Posicion = 0
      SET @Seguir = 0
  END   
  
  RETURN @XML
END
GO
/*
DECLARE @xml as varchar(max)
SET @xml = 
'<doc>
 <a>1</a>
 <b ba="" bb="2" bc="3" />
 <c bd="3"/>
 <d><d1>2</d1><d2></d2></d>
 <e ea="1" eb=""></e>
 <f><f1><f2><f3></f3></f2></f1></f>
</doc>'

SELECT dbo.fneDocLimpiarXML(@XML)
*/

/**************** fneDocDocumentoASecciones ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocDocumentoASecciones') DROP FUNCTION fneDocDocumentoASecciones
GO
CREATE FUNCTION fneDocDocumentoASecciones 
	(
	@Modulo				varchar(5), 
	@eDoc				varchar(50)
	)
RETURNS @Seccion TABLE
        (
	Nombre			varchar(50),
	Datos			varchar(max)
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SeccionNombre			varchar(50),
    @XML					varchar(max),
    @PosicionInicial		bigint,
    @PosicionFinal			bigint,
    @SeccionLongitud		bigint
    
  SELECT @XML = Documento FROM eDoc WHERE Modulo = @Modulo AND eDoc = @eDoc
    
  DECLARE creDocD CURSOR FOR
   SELECT RTRIM(ISNULL(Seccion,''))
     FROM eDocD
    WHERE Modulo = @Modulo
      AND eDoc = @eDoc
    ORDER BY Orden  

  OPEN creDocD
  FETCH NEXT FROM creDocD INTO @SeccionNombre
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SELECT @PosicionInicial  = ISNULL(PATINDEX('%' + '{' + @SeccionNombre + '}%',@XML),0) + LEN(@SeccionNombre) + 2 --+ 1  
    SELECT @PosicionFinal    = ISNULL(PATINDEX('%' + '{/' + @SeccionNombre + '}%',@XML),0)  
    SELECT @SeccionLongitud = @PosicionFinal - @PosicionInicial
    
    IF @SeccionLongitud > 0
      INSERT @Seccion (Nombre, Datos) VALUES (@SeccionNombre,SUBSTRING(@XML,@PosicionInicial,@SeccionLongitud))
    
    FETCH NEXT FROM creDocD INTO @SeccionNombre
  END
  CLOSE creDocD
  DEALLOCATE creDocD

  RETURN
END
GO
   
/**************** fneDocCampoXML ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocCampoXML') DROP FUNCTION fneDocCampoXML
GO
CREATE FUNCTION fneDocCampoXML 
	(
	@Modulo				varchar(5), 
	@eDoc				varchar(50)
	)
RETURNS @CampoXML TABLE
        (
	Campo			varchar(255)
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @XML				varchar(max),
  @Longitud			bigint,
  @Contador			bigint,
  @Caracter			char(1),
  @Campo			varchar(255),
  @Estado			int,
  @EstadoAnterior	int
  
  SELECT @XML = Documento FROM eDoc WHERE Modulo = @Modulo AND eDoc = @eDoc
  SELECT @Longitud = LEN(@XML), @Contador = 1, @Caracter = NULL, @Campo = '', @Estado = 0
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @Caracter = SUBSTRING(@XML,@Contador,1)
    SET @EstadoAnterior = @Estado    
    SET @Estado = CASE 
      WHEN @Estado = 0 AND @Caracter = '['         THEN 1
      WHEN @Estado = 1 AND @Caracter = ']'         THEN 2
      WHEN @Estado = 2 AND @Caracter = '['         THEN 1
      WHEN @Estado = 2 AND @Caracter <> '['        THEN 0
      WHEN @Estado = 1 AND LEN(@Campo) > 100       THEN 0 
      ELSE @Estado
    END

    IF @Estado = 0
    BEGIN
      IF @EstadoAnterior <> 0 SET @Campo = ''
    END
    IF @Estado = 1
    BEGIN
      SET @Campo = @Campo + @Caracter
    END
    IF @Estado = 2
    BEGIN
      SET @Campo = @Campo + @Caracter
      IF NOT EXISTS(SELECT * FROM @CampoXML WHERE Campo = @Campo) 
        INSERT @CampoXML (Campo) VALUES (@Campo)      
      SET @Campo = ''      
    END

    
    SET @Contador = @Contador + 1
  END
     
  RETURN
END
GO

/**************** fneDocCampoXMLTexto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocCampoXMLTexto') DROP FUNCTION fneDocCampoXMLTexto
GO
CREATE FUNCTION fneDocCampoXMLTexto 
	(
	@XML				varchar(max)
	)
RETURNS @CampoXML TABLE
        (
	Campo			varchar(255)
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Longitud			bigint,
  @Contador			bigint,
  @Caracter			char(1),
  @Campo			varchar(255),
  @Estado			int,
  @EstadoAnterior	int
  
  SELECT @Longitud = LEN(@XML), @Contador = 1, @Caracter = NULL, @Campo = '', @Estado = 0
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @Caracter = SUBSTRING(@XML,@Contador,1)
    SET @EstadoAnterior = @Estado    
    SET @Estado = CASE 
      WHEN @Estado = 0 AND @Caracter = '['         THEN 1
      WHEN @Estado = 1 AND @Caracter = ']'         THEN 2
      WHEN @Estado = 2 AND @Caracter = '['         THEN 1
      WHEN @Estado = 2 AND @Caracter <> '['        THEN 0
      WHEN @Estado = 1 AND LEN(@Campo) > 100       THEN 0 
      ELSE @Estado
    END

    IF @Estado = 0
    BEGIN
      IF @EstadoAnterior <> 0 SET @Campo = ''
    END
    IF @Estado = 1
    BEGIN
      SET @Campo = @Campo + @Caracter
    END
    IF @Estado = 2
    BEGIN
      SET @Campo = @Campo + @Caracter
      IF NOT EXISTS(SELECT * FROM @CampoXML WHERE Campo = @Campo) 
        INSERT @CampoXML (Campo) VALUES (@Campo)      
      SET @Campo = ''      
    END

    
    SET @Contador = @Contador + 1
  END
     
  RETURN
END
GO

/**************** fneDocSeccionXMLTexto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocSeccionXMLTexto') DROP FUNCTION fneDocSeccionXMLTexto
GO
CREATE FUNCTION fneDocSeccionXMLTexto 
	(
	@XML				varchar(max)
	)
RETURNS @SeccionXML TABLE
        (
	Seccion			varchar(100)
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Longitud			bigint,
  @Contador			bigint,
  @Caracter			char(1),
  @Seccion			varchar(100),
  @Estado			int,
  @EstadoAnterior	int
  
  SELECT @Longitud = LEN(@XML), @Contador = 1, @Caracter = NULL, @Seccion = '', @Estado = 0
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @Caracter = SUBSTRING(@XML,@Contador,1)
    SET @EstadoAnterior = @Estado    
    SET @Estado = CASE 
      WHEN @Estado = 0 AND @Caracter = '{'         THEN 1
      WHEN @Estado = 1 AND @Caracter = '}'         THEN 2
      WHEN @Estado = 2 AND @Caracter = '{'         THEN 1
      WHEN @Estado = 2 AND @Caracter <> '}'        THEN 0
      WHEN @Estado = 1 AND LEN(@Seccion) > 100     THEN 0
      WHEN @Estado = 1 AND @Caracter = '/'         THEN 0       
      ELSE @Estado
    END

    IF @Estado = 0
    BEGIN
      IF @EstadoAnterior <> 0 SET @Seccion = ''
    END
    IF @Estado = 1
    BEGIN
      SET @Seccion = @Seccion + @Caracter
    END
    IF @Estado = 2
    BEGIN
      SET @Seccion = @Seccion + @Caracter
      SET @Seccion = REPLACE(REPLACE(@Seccion,'{',''),'}','')
      IF NOT EXISTS(SELECT * FROM @SeccionXML WHERE Seccion = @Seccion) 
        INSERT @SeccionXML (Seccion) VALUES (@Seccion)      
      SET @Seccion = ''      
    END

    
    SET @Contador = @Contador + 1
  END
     
  RETURN
END
GO

/**************** fneDocConsecutivoInicial ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocConsecutivoInicial') DROP FUNCTION fneDocConsecutivoInicial
GO
CREATE FUNCTION fneDocConsecutivoInicial 
	(
	@Consecutivo				varchar(255)
	)
RETURNS int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Longitud			bigint,
  @Contador			bigint,
  @Caracter			char(1),
  @Inicial			varchar(100),
  @Estado			int,
  @EstadoAnterior	int,
  @Resultado		int
  
  SELECT @Longitud = LEN(@Consecutivo), @Contador = 1, @Caracter = NULL, @Inicial = '', @Estado = 0
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @Caracter = SUBSTRING(@Consecutivo,@Contador,1)
    SET @EstadoAnterior = @Estado    
    SET @Estado = CASE 
      WHEN @Estado = 0 AND @Caracter = '«'         THEN 1
      WHEN @Estado = 1 AND @Caracter = '|'         THEN 2
      WHEN @Estado = 2 AND @Caracter IN ('|','»')  THEN 3       
      ELSE @Estado
    END

    IF @Estado = 2 AND @Caracter IN ('0','1','2','3','4','5','6','7','8','9')
    BEGIN
      SET @Inicial = @Inicial + @Caracter
    END
    IF @Estado = 2
    BEGIN
      IF @EstadoAnterior <> 2 SET @Inicial = ''
    END
    IF @Estado = 3
    BEGIN
      IF @EstadoAnterior = 2 SELECT @Resultado = CONVERT(int,NULLIF(@Inicial,''))
      BREAK
    END
    
    SET @Contador = @Contador + 1
  END
  
  SELECT @Resultado = ISNULL(@Resultado,1)
     
  RETURN @Resultado
END
GO

--SELECT dbo.fneDocConsecutivoInicial('«Consecutivo1»')

/**************** fneDocConsecutivoIntervalo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocConsecutivoIntervalo') DROP FUNCTION fneDocConsecutivoIntervalo
GO
CREATE FUNCTION fneDocConsecutivoIntervalo 
	(
	@Consecutivo				varchar(255)
	)
RETURNS int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Longitud			bigint,
  @Contador			bigint,
  @Caracter			char(1),
  @Inicial			varchar(100),
  @Estado			int,
  @EstadoAnterior	int,
  @Resultado		int
  
  SELECT @Longitud = LEN(@Consecutivo), @Contador = 1, @Caracter = NULL, @Inicial = '', @Estado = 0
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @Caracter = SUBSTRING(@Consecutivo,@Contador,1)
    SET @EstadoAnterior = @Estado    
    SET @Estado = CASE 
      WHEN @Estado = 0 AND @Caracter = '«' THEN 1
      WHEN @Estado = 1 AND @Caracter = '|' THEN 2
      WHEN @Estado = 2 AND @Caracter = '|' THEN 3      
      WHEN @Estado = 3 AND @Caracter = '»' THEN 4       
      ELSE @Estado
    END

    IF @Estado = 3 AND @Caracter IN ('0','1','2','3','4','5','6','7','8','9')
    BEGIN
      SET @Inicial = @Inicial + @Caracter
    END
    IF @Estado = 3
    BEGIN
      IF @EstadoAnterior <> 3 SET @Inicial = ''
    END
    IF @Estado = 4
    BEGIN
      IF @EstadoAnterior = 3 SELECT @Resultado = CONVERT(int,NULLIF(@Inicial,''))
      BREAK
    END
    
    SET @Contador = @Contador + 1
  END
  
  SELECT @Resultado = ISNULL(@Resultado,1)
     
  RETURN @Resultado
END
GO
	
--SELECT dbo.fneDocConsecutivoIntervalo('«Consecutivo1|2»')	

--/**************** fneDocParsearConsecutivo ****************/
--IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocParsearConsecutivo') DROP FUNCTION dbo.fneDocParsearConsecutivo
--GO
--CREATE FUNCTION dbo.fneDocParsearConsecutivo 
--	(
--	@XML				varchar(max)
--	)
--RETURNS varchar(max)

----//WITH ENCRYPTION
--AS BEGIN
--  DECLARE
--    @LongitudTexto			bigint,
--    @Caracter				char(1),
--    @Contador				bigint,
--    @Estado					int,
--    @Consecutivo			varchar(50),
--    @EstadoAnterior			int,
--    @PosicionIni			bigint,
--    @PosicionFin			bigint,
--    @XMLResultado			varchar(max),
--    @Numero					int    
    
    
--  DECLARE @Consecutivos TABLE
--        (
--		Consecutivo			varchar(50),
--		Numero				int,
--		Intervalo			int	
--        ) 

--  SET @XMLResultado = @XML
  
--  IF CHARINDEX('«',@XML) = 0
--    RETURN @XMLResultado

--  SELECT @LongitudTexto = LEN(@XMLResultado), @Contador = 1, @Estado = 0, @Consecutivo = '', @PosicionIni = 0
--  WHILE @Contador <= @LongitudTexto
--  BEGIN
--    SELECT @Caracter = SUBSTRING(@XMLResultado,@Contador,1)
--    SET @EstadoAnterior = @Estado
--    SET @Estado = CASE 
--      WHEN @Estado = 0 AND @Caracter = '«'        THEN 1
--      WHEN @Estado = 1 AND @Caracter = '»'        THEN 2
--      WHEN @Estado = 2 AND @Caracter = '«'        THEN 1
--      WHEN @Estado = 2 AND @Caracter <> '«'       THEN 0
--      WHEN @Estado = 1 AND LEN(@Consecutivo) > 50 THEN 0 
--      ELSE @Estado
--    END

--    IF @Estado = 0
--    BEGIN
--      IF @EstadoAnterior <> 0 SET @Consecutivo = ''
--    END
--    IF @Estado = 1
--    BEGIN
--      IF @EstadoAnterior <> 1 SET @PosicionIni = @Contador
--      SET @Consecutivo = @Consecutivo + @Caracter
--    END
--    IF @Estado = 2
--    BEGIN
--      SET @PosicionFin = @Contador
--      SET @Consecutivo = @Consecutivo + @Caracter
--      IF NOT EXISTS(SELECT * FROM @Consecutivos WHERE Consecutivo = @Consecutivo) 
--        INSERT @Consecutivos (Consecutivo, Numero, Intervalo) VALUES (@Consecutivo, dbo.fneDocConsecutivoInicial(@Consecutivo), dbo.fneDocConsecutivoIntervalo(@Consecutivo))
--      ELSE
--        UPDATE @Consecutivos SET Numero = Numero + Intervalo WHERE Consecutivo = @Consecutivo  
      
--      SELECT @Numero = Numero FROM @Consecutivos WHERE Consecutivo = @Consecutivo     
      
--      SET @XMLResultado = SUBSTRING(@XMLResultado,1,@PosicionIni - 1) + CONVERT(varchar,@Numero) + SUBSTRING(@XMLResultado,@PosicionFin + 1,@LongitudTexto - @PosicionFin)
--      SET @Contador = @PosicionIni + LEN(CONVERT(varchar,@Numero)) - 1
--      SET @LongitudTexto = LEN(@XMLResultado)       
--      SET @Consecutivo = ''
--    END
     
--    SET @Contador = @Contador + 1
--  END
  
--  RETURN @XMLResultado
--END
--GO




/**************** fneDocSepararConsecutivo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocSepararConsecutivo') DROP FUNCTION dbo.fneDocSepararConsecutivo
GO
CREATE FUNCTION dbo.fneDocSepararConsecutivo 
	(
	@Texto				varchar(max)
	)
RETURNS varchar(max)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @LEN          bigint,
  @LEN2         int,
  @Posicion     int,
  @Posicion2    int
  
  SELECT @LEN = LEN(@Texto)
  
  SELECT @Posicion = CHARINDEX('«',@Texto,1)
  SELECT @Posicion2 = CHARINDEX('»',@Texto,1)
  
  SELECT @Texto = SUBSTRING(@Texto,@Posicion,@Posicion2-@Posicion+1)
  RETURN @Texto
END
GO


/**************** fneDocParsearConsecutivo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocParsearConsecutivo') DROP FUNCTION dbo.fneDocParsearConsecutivo
GO
CREATE FUNCTION dbo.fneDocParsearConsecutivo
	(
	@XML				varchar(max)
	)
RETURNS varchar(max)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @LEN          int,
  @LEN2         int,
  @Posicion     int,
  @ValorInicial int,
  @ValorFinal   int,
  @Total        int, 
  @Valor       varchar(max),
  @Consecutivo  varchar(max),
  @Texto        varchar(max),
  @Texto2       varchar(max),
  @Texto3       varchar(max),
  @Resultado    varchar(max) , 
  @XMLResultado varchar(max),
  @Cons         varchar(max),
  @Inicial      int, 
  @Interval     int,
  @Segundo      int,
  @Primero      int

  SET @XMLResultado = @XML
  
  IF CHARINDEX('«',@XML) = 0
    RETURN @XMLResultado
    
  DECLARE @Tabla table(Valor  varchar(max),Consecutivo varchar(max),Intervalo int, Inicial int, Total  int)
  SELECT @Texto = @XML+'«»'
  SET @Posicion = 1
  SELECT @LEN = LEN(@Texto)
  SELECT @ValorInicial = 1
  SELECT @ValorFinal = CHARINDEX('»',@Texto,@ValorInicial+1) 
  WHILE @ValorFinal<=@LEN 
  BEGIN
    SELECT @Texto2 =SUBSTRING(@Texto,@ValorInicial,@ValorFinal-@ValorInicial+ 1)
    SELECT @Valor = REPLACE(REPLACE(dbo.fneDocSepararConsecutivo(@Texto2),'»',''),'«','')
    
    IF NOT EXISTS(SELECT * FROM @Tabla WHERE Valor = @Valor)
    BEGIN
      IF @Valor LIKE('%|%')
      BEGIN
        SELECT @len2 = LEN(@Valor) 
        SELECT @Primero= CHARINDEX('|',@Valor,1)  
        SELECT @cons =SUBSTRING(@Valor,1,@Primero-1)
        SELECT @segundo =CHARINDEX('|',@Valor,@Primero+1)        
        IF @segundo >0
        BEGIN
          SELECT @Inicial = SUBSTRING(@Valor,@Primero+1,((@segundo)-(@Primero+1)))
          SELECT @Interval = SUBSTRING(@Valor,@segundo+1,((@len2+1)-(@segundo+1)))
        END
        ELSE
          SELECT @Inicial = SUBSTRING(@Valor,@Primero+1,((@LEN2+1)-(@Primero+1)))        
      END      
      INSERT @Tabla(Valor,Consecutivo,Inicial,Intervalo,Total)
      SELECT        @Valor,ISNULL(@cons,''),ISNULL(@Inicial,'1'),ISNULL(@Interval,'1'), ISNULL(@Inicial,'1')
      SELECT @Total = ISNULL(@Inicial,'1')      
      SELECT @Consecutivo = CONVERT(varchar,ISNULL(@Inicial,'1'))      
    END
    ELSE
    BEGIN
      SELECT @Total = Total +Intervalo
        FROM @Tabla WHERE Valor = @Valor        
      UPDATE @Tabla SET Total = @Total  WHERE Valor = @Valor
      SELECT @Consecutivo =CONVERT(varchar,Total)
        FROM @Tabla WHERE Valor = @Valor
    END
    IF @ValorFinal = @LEN
    SELECT @Consecutivo ='',  @Valor = ''  
    SELECT @Texto2 = REPLACE(@Texto2,'«'+@Valor+'»',@Consecutivo)    
    SELECT @Texto3 = ISNULL(@Texto3,'')+@Texto2    
    SELECT @ValorInicial = @ValorFinal+1
    SELECT @ValorFinal = CHARINDEX('»',@Texto,@ValorInicial+1)
    SELECT @Posicion = @ValorFinal+1
    SELECT @Valor = NULL,@Cons = NULL, @Inicial = NULL, @Interval = NULL
    IF @Posicion = 0 BREAK
    IF @ValorFinal =0 BREAK
  END    
  SELECT @XMLResultado = @Texto3
  RETURN @XMLResultado
END
GO

--select dbo.fneDocParsearConsecutivo('«c1|10|5»aaaaa«c2|1000|100»bbbbb«c1|10|5»ccccc«c3|100000|10000»xxxxxf«c1|10|5»ddddd«c4»f«c4»f«c4»f«c5|50000»f«c5|50000»f«c1|10|5»hhhhh«c2|1000|100»uuuuu«c3|100000|10000»a«c3|100000|10000»b«c3|100000|10000»c«c3|100000|10000»d«c3|100000|10000»e«c3|100000|10000»f«c3|100000|10000»g«c3|100000|10000»h«c3|100000|10000»i«c3|100000|10000»j«c3|100000|10000»')

--/**************** fneDocParsearCuenta ****************/
--IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocParsearCuenta') DROP FUNCTION dbo.fneDocParsearCuenta
--GO
--CREATE FUNCTION dbo.fneDocParsearCuenta 
--	(
--	@XML				varchar(max)
--	)
--RETURNS varchar(max)

----//WITH ENCRYPTION
--AS BEGIN
--  DECLARE
--    @LongitudTexto			int,
--    @Caracter				char(1),
--    @Cuenta					varchar(50),
--    @Estado					int,
--    @EstadoAnterior			int,
--    @PosicionIni			int,
--    @PosicionFin			int,
--    @XMLResultado			varchar(max),
--    @Numero					int,
--    @Contador				int    
    
    
--  DECLARE @Cuentas TABLE
--        (
--		Cuenta				varchar(50),
--		Numero				bigint
--        ) 

--  SET @XMLResultado = @XML

--  IF CHARINDEX('^',@XML) = 0
--    RETURN @XMLResultado

--  SELECT @LongitudTexto = LEN(@XMLResultado), @Contador = 1, @Estado = 0, @Cuenta = '', @PosicionIni = 0
--  WHILE @Contador <= @LongitudTexto
--  BEGIN
--    SELECT @Caracter = SUBSTRING(@XMLResultado,@Contador,1)
--    SET @EstadoAnterior = @Estado
--    SET @Estado = CASE 
--      WHEN @Estado = 0 AND @Caracter = '^'        THEN 1
--      WHEN @Estado = 1 AND @Caracter = '^'        THEN 2
--      WHEN @Estado = 2 AND @Caracter = '^'        THEN 1
--      WHEN @Estado = 2 AND @Caracter <> '^'       THEN 0
--      WHEN @Estado = 1 AND LEN(@Cuenta) > 50 THEN 0 
--      ELSE @Estado
--    END

--    IF @Estado = 0
--    BEGIN
--      IF @EstadoAnterior <> 0 SET @Cuenta = ''
--    END
--    IF @Estado = 1
--    BEGIN
--      IF @EstadoAnterior <> 1 SET @Cuenta = ''    
--      SET @Cuenta = @Cuenta + @Caracter
--    END
--    IF @Estado = 2
--    BEGIN
--      SET @Cuenta = @Cuenta + @Caracter
--      IF NOT EXISTS(SELECT * FROM @Cuentas WHERE Cuenta = @Cuenta) 
--        INSERT @Cuentas (Cuenta, Numero) VALUES (@Cuenta, 1)
--      ELSE
--        UPDATE @Cuentas SET Numero = Numero + 1 WHERE Cuenta = @Cuenta  
      
--      --SELECT @Numero = Numero FROM @Cuentas WHERE Cuenta = @Cuenta           
--      --SET @XMLResultado = SUBSTRING(@XMLResultado,1,@PosicionIni - 1) + CONVERT(varchar,@Numero) + SUBSTRING(@XMLResultado,@PosicionFin + 1,@LongitudTexto - @PosicionFin)
--      --SET @Contador = @PosicionIni + LEN(CONVERT(varchar,@Numero)) - 1
--      --SET @LongitudTexto = LEN(@XMLResultado)       
--      --SET @Consecutivo = ''
--    END
     
--    SET @Contador = @Contador + 1
--  END
  
--  DECLARE crCuentas CURSOR FOR
--   SELECT Cuenta, Numero
--     FROM @Cuentas

--  OPEN crCuentas
--  FETCH NEXT FROM crCuentas INTO @Cuenta, @Numero
--  WHILE @@FETCH_STATUS = 0
--  BEGIN
--    SET @XMLResultado = REPLACE(@XMLResultado,@Cuenta,'')
--    SET @Cuenta = REPLACE(@Cuenta,'^','~')
--    SET @XMLResultado = REPLACE(@XMLResultado,@Cuenta,RTRIM(LTRIM(CONVERT(varchar,@Numero))))
--    FETCH NEXT FROM crCuentas INTO @Cuenta, @Numero
--  END
--  CLOSE crCuentas
--  DEALLOCATE crCuentas
  
--  RETURN @XMLResultado
--END
--GO

/**************** fneDocParsearCuenta ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocParsearCuenta') DROP FUNCTION dbo.fneDocParsearCuenta
GO
CREATE FUNCTION dbo.fneDocParsearCuenta 
      (
      @XML                    varchar(max)
      )
RETURNS varchar(max)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @LEN          bigint,
  @LEN2         int,
  @Posicion     int,
  @Posicion2    int,
  @Posicion3    int,
  @ValorInicial int,
  @ValorFinal   int,
  @Total        int, 
  @Cuenta       varchar(max),
  @Texto        varchar(max),
  @Texto2       varchar(max),
  @Resultado    varchar(max) , 
  @XMLResultado varchar(max)
  
  DECLARE @Tabla table(Valor  varchar(max),Cantidad int)
  SET @XMLResultado = @XML
  IF CHARINDEX('^',@XML) = 0  RETURN @XMLResultado
  SELECT @Texto = @XML
  SET @Posicion = 1
  SELECT @LEN = LEN(@Texto)
  SELECT @LEN2 =  CHARINDEX('~',@Texto,1)

  WHILE @Posicion< @LEN
  BEGIN
    SELECT @Posicion2 =  CHARINDEX('^',@Texto,@Posicion)

    IF @Posicion = 0 
    SET @Posicion = @LEN2
    IF @ValorFinal IS NULL AND @ValorInicial IS NOT NULL
      SELECT @ValorFinal = @Posicion2
     
    IF @ValorInicial IS NULL
      SELECT @ValorInicial = @Posicion2+1  
    IF @ValorInicial IS NOT NULL AND @ValorFinal IS NOT NULL
    BEGIN
      SELECT @Texto2 = SUBSTRING (@Texto,@ValorInicial,(@ValorFinal-@ValorInicial))
      IF EXISTS (SELECT * FROM @Tabla WHERE Valor = @Texto2)
        UPDATE @Tabla SET Cantidad = Cantidad+1 WHERE Valor = @Texto2
      ELSE  
        INSERT @Tabla(Valor,cantidad)
        SELECT @Texto2,1
        SELECT @ValorInicial = NULL, @ValorFinal = NULL, @Texto2 = NULL
    
    END
    IF @Posicion2 = 0 BREAK
    SELECT @Posicion = @Posicion2+1

  END
  SELECT @Resultado = @Texto
  DECLARE crCuentas CURSOR local  FOR
   SELECT  Cantidad, Valor FROM @Tabla
  OPEN crCuentas
  FETCH NEXT FROM crCuentas INTO @Total, @Cuenta
  WHILE @@FETCH_STATUS = 0
  BEGIN

    SELECT @Resultado = REPLACE(@Resultado,'~'+@Cuenta+'~',CONVERT(varchar,@Total)) 
    SELECT @Resultado = REPLACE(@Resultado,'^'+@Cuenta+'^','') 
    SELECT @Cuenta = '',@Total = NULL
    FETCH NEXT FROM crCuentas INTO @Total, @Cuenta
  END
  CLOSE crCuentas
  DEALLOCATE crCuentas
  SELECT @XMLResultado = REPLACE(REPLACE(@Resultado,'^',''),'~','')

  RETURN @XMLResultado
END
GO

--SELECT dbo.fneDocParsearCuenta('AAA^C1^^C2^BBB^C1^EEE^C1^DDD^C1^CUENTA1:~C1~CUENTA2:~C2~XXX') 

/******************************* fneDocTraducirParseo *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocTraducirParseo')
DROP FUNCTION fneDocTraducirParseo
GO
CREATE FUNCTION fneDocTraducirParseo
  (
  @Modulo			varchar(5),
  @eDoc				varchar(50),
  @IDSeccion		int,
  @RID				int,
  @ValorOriginal	varchar(50)			
  )
RETURNS varchar(100)
AS

BEGIN
  DECLARE	
    @Resultado		varchar(100),
    @TablaSt		varchar(50)
  
  SELECT 
    @TablaSt = ISNULL(NULLIF(eddmc.TablaSt,''),edd.TablaSt) 
    FROM eDocD edd JOIN eDocDMapeoCampo eddmc
      ON eddmc.Modulo = edd.Modulo AND eddmc.eDoc = edd.eDoc AND eddmc.IDSeccion = edd.RID
   WHERE edd.Modulo = @Modulo
     AND RTRIM(edd.eDoc) = RTRIM(@eDoc)
     AND edd.RID = @IDSeccion
     AND eddmc.RID = @RID

  SELECT @Resultado = Valor
    FROM TablaStD 
   WHERE TablaSt = @TablaSt
     AND Nombre = @ValorOriginal

  SET @Resultado = ISNULL(@Resultado,@ValorOriginal)
    
  RETURN RTRIM(LTRIM(@Resultado))	
END
GO

--select dbo.fneDocTraducirParseo('VTAS', 'AMC7.1', 1, 12, 'Pesos')

/******************************* fneDocFechaObtenerNoPosiciones *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocFechaObtenerNoPosiciones')
DROP FUNCTION fneDocFechaObtenerNoPosiciones
GO

CREATE FUNCTION fneDocFechaObtenerNoPosiciones
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
			@Ultimol		int,			
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
    @Ultimol = 0,     
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

    IF @Caracter = 'L' 
    BEGIN
      IF (@Contador - @Ultimol = 1) OR (@Ultimol = 0) 
      IF NOT EXISTS(SELECT * FROM @Resultado WHERE Letra = 'L')
        INSERT @Resultado (Letra, Cantidad) VALUES ('L',1)
      ELSE
        UPDATE @Resultado SET Cantidad = Cantidad + 1 WHERE Letra = 'L'
      SET @Ultimos = @Contador
    END

    SET @Contador = @Contador + 1
  END

  RETURN
END
GO

/******************************* fneDocFormatoFecha *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocFormatoFecha')
DROP FUNCTION fneDocFormatoFecha
GO

CREATE FUNCTION fneDocFormatoFecha
  (
  @Fecha				datetime,
  @FormatoFecha				varchar(50)
  )

RETURNS varchar(50)
AS

BEGIN
  DECLARE	@FormatoFechaR			varchar(50),
			@Anyo					varchar(50),
			@Mes					varchar(50),
			@Dia					varchar(50),
			@Hora					varchar(50),
			@Minuto					varchar(50),
			@Segundo				varchar(50),
			@Milisegundo			varchar(50),			
			@AnyoCantidad			int,
			@MesCantidad			int,
			@DiaCantidad			int,
			@HoraCantidad			int,
			@MinutoCantidad			int,
			@SegundoCantidad		int,
			@MiliSegundoCantidad	int			

  DECLARE @Resultado	TABLE
	(
	Letra		varchar(50),
	Cantidad	int
	)

  IF NULLIF(RTRIM(@FormatoFecha),'') IS NULL RETURN CONVERT(varchar,@Fecha,126)

  SELECT @Anyo = '', @Mes = '', @Dia = '', @Hora = '', @Minuto = '', @Segundo = '', @Milisegundo = ''

  SET @FormatoFecha = UPPER(@FormatoFecha)

  INSERT @Resultado (Letra, Cantidad) SELECT Letra, Cantidad FROM fneDocFechaObtenerNoPosiciones(@FormatoFecha)

  SELECT @AnyoCantidad        = Cantidad FROM @Resultado WHERE Letra = 'A'
  SELECT @MesCantidad         = Cantidad FROM @Resultado WHERE Letra = 'M'
  SELECT @DiaCantidad         = Cantidad FROM @Resultado WHERE Letra = 'D'
  SELECT @HoraCantidad        = Cantidad FROM @Resultado WHERE Letra = 'H'
  SELECT @MinutoCantidad      = Cantidad FROM @Resultado WHERE Letra = 'N'
  SELECT @SegundoCantidad     = Cantidad FROM @Resultado WHERE Letra = 'S'
  SELECT @MilisegundoCantidad = Cantidad FROM @Resultado WHERE Letra = 'L'
  

  SELECT @AnyoCantidad        = ISNULL(@AnyoCantidad,0)
  SELECT @MesCantidad         = ISNULL(@MesCantidad,0) 
  SELECT @DiaCantidad         = ISNULL(@DiaCantidad,0) 
  SELECT @HoraCantidad        = ISNULL(@HoraCantidad,0) 
  SELECT @MinutoCantidad      = ISNULL(@MInutoCantidad,0) 
  SELECT @SegundoCantidad     = ISNULL(@SegundoCantidad,0)
  SELECT @MilisegundoCantidad = ISNULL(@MilisegundoCantidad,0)  

  SET @Anyo        = ISNULL(RIGHT(RTRIM(CONVERT(varchar,DATEPART(year,@Fecha))),@AnyoCantidad),'')
  SET @Mes         = ISNULL(RIGHT('0000' + RTRIM(CONVERT(varchar,DATEPART(month,@Fecha))),@MesCantidad),'')
  SET @Dia         = ISNULL(RIGHT('0000' + RTRIM(CONVERT(varchar,DATEPART(day,@Fecha))),@DiaCantidad),'')
  SET @Hora        = ISNULL(RIGHT('0000' + RTRIM(CONVERT(varchar,DATEPART(hour,@Fecha))),@HoraCantidad),'')
  SET @Minuto      = ISNULL(RIGHT('0000' + RTRIM(CONVERT(varchar,DATEPART(minute,@Fecha))),@MinutoCantidad),'')
  SET @Segundo     = ISNULL(RIGHT('0000' + RTRIM(CONVERT(varchar,DATEPART(second,@Fecha))),@SegundoCantidad),'')
  SET @Milisegundo = ISNULL(RIGHT('0000' + RTRIM(CONVERT(varchar,DATEPART(millisecond,@Fecha))),@MilisegundoCantidad),'')  

  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('A',@AnyoCantidad),@Anyo) 
  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('M',@MesCantidad),@Mes) 
  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('D',@DiaCantidad),@Dia) 
  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('H',@HoraCantidad),@Hora) 
  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('N',@MinutoCantidad),@Minuto) 
  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('S',@SegundoCantidad),@Segundo) 
  SET @FormatoFecha = REPLACE(@FormatoFecha,REPLICATE('L',@MilisegundoCantidad),@Milisegundo)   

  SET @FormatoFechaR = @FormatoFecha

  Return @FormatoFechaR
END
GO

--select dbo.fneDocFormatoFecha(getdate(),'AAAAMMDDHHNNSS.LLLL')

/******************************* fneDocObtenerTipoColumna *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocObtenerTipoColumna')
DROP FUNCTION fneDocObtenerTipoColumna
GO
CREATE FUNCTION fneDocObtenerTipoColumna
  (
  @Campo		varchar(255),
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

/**************** fnCFDFlexExtraerGUUID ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexExtraerGUUID') DROP FUNCTION dbo.fnCFDFlexExtraerGUUID
GO
CREATE FUNCTION dbo.fnCFDFlexExtraerGUUID 
	(
	@XML				varchar(max)
	)
RETURNS varchar(max)

--//WITH ENCRYPTION
AS BEGIN

  DECLARE
    @LongitudTexto			bigint,
    @Caracter				char(1),
    @Contador				bigint,
    @Estado					int,
    @XMLResultado			varchar(max)    
            
  SET @XMLResultado = ''
  SELECT @LongitudTexto = LEN(@XML), @Contador = 1, @Estado = 0
  WHILE @Contador <= @LongitudTexto
  BEGIN
    SELECT @Caracter = SUBSTRING(@XML,@Contador,1)
    SET @Estado = CASE 
      WHEN @Estado IN (0)   AND @Caracter IN ('U')  THEN 1
      WHEN @Estado IN (1)   AND @Caracter IN ('U')  THEN 2
      WHEN @Estado IN (2)   AND @Caracter IN ('I')  THEN 3
      WHEN @Estado IN (3)   AND @Caracter IN ('D')  THEN 4
      WHEN @Estado IN (4)   AND @Caracter IN ('=')  THEN 5
      WHEN @Estado IN (5)   AND @Caracter IN ('"')  THEN 6
      WHEN @Estado IN (6,7) AND @Caracter <>  '"'   THEN 7
      WHEN @Estado IN (7)   AND @Caracter IN ('"')  THEN 8
      ELSE 0
    END

    IF @Estado = 7
    BEGIN
      SET @XMLResultado = @XMLResultado + @Caracter
    END

    IF @Estado = 8
    BEGIN
      RETURN ISNULL(@XMLResultado,'')
    END
     
    SET @Contador = @Contador + 1
  END
    
  RETURN ISNULL(@XMLResultado,'')
END
GO

/**************** fnCFDFlexTipoOrigen ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexTipoOrigen') DROP FUNCTION fnCFDFlexTipoOrigen
GO
CREATE FUNCTION dbo.fnCFDFlexTipoOrigen
(@Modulo     varchar(5), @ID  int) 
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @Resultado      varchar(50),
  @Documento      varchar(max)
  
  SELECT @Documento = Documento FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID
  
  IF (SELECT PATINDEX('%version="2.2"%',@Documento))  <> 0 OR  (SELECT PATINDEX('%version="2.0"%',@Documento))<> 0
  SELECT @Resultado = 'CFD'
  
  IF (SELECT PATINDEX('%version="3.2"%',@Documento))  <> 0 OR  (SELECT PATINDEX('%version="3.0"%',@Documento))<> 0
  SELECT @Resultado = 'CFDI'
  
  SELECT @Resultado = ISNULL(@Resultado,'')
  RETURN (@Resultado)
 END

GO

/**************** fnCFDFlexIDOrigen ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexIDOrigen') DROP FUNCTION fnCFDFlexIDOrigen
GO
CREATE FUNCTION dbo.fnCFDFlexIDOrigen(@Modulo     varchar(5), @ID  int, @Nivel  int) 
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
    @Resultado   varchar(50),
    @OModulo     varchar(5), 
    @OID         int ,
    @Tipo        varchar(20)
    

  SET @Resultado = NULL  
 
  IF EXISTS(SELECT * FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID)   
  SELECT @Tipo = ISNULL(dbo.fnCFDFlexTipoOrigen(@Modulo,@ID),'CFD')
 
  IF @Tipo = 'CFD' AND @Nivel <>1
   SELECT  @Resultado =RTRIM(LTRIM(c.Modulo)) + '#' +CONVERT(varchar,c.ModuloID)
     FROM  CFD c 
    WHERE c.Modulo = @Modulo AND c.ModuloID = @ID  
      AND c.Sello IS NOT NULL 
      AND c.CadenaOriginal IS NOT NULL 
      AND c.Documento IS NOT NULL
      AND PATINDEX( '%tipoDeComprobante="ingreso" %',c.Documento)<>0
      
  IF @Tipo = 'CFDI'   AND @Nivel <>1
   SELECT  @Resultado =RTRIM(LTRIM(c.Modulo)) + '#' +CONVERT(varchar,c.ModuloID)
     FROM  CFD c 
    WHERE c.Modulo = @Modulo AND c.ModuloID = @ID  
      AND c.Sello IS NOT NULL 
      AND c.CadenaOriginal IS NOT NULL 
      AND c.Documento IS NOT NULL    
      AND c.UUID IS NOT NULL 
      AND PATINDEX( '%tipoDeComprobante="ingreso" %',c.Documento)<>0
      
  
    SELECT @OModulo = mf.OModulo, @OID = mf.OID
      FROM MovFLujo mf
     WHERE DModulo = @Modulo AND DID = @ID
     
     IF @Resultado IS NULL AND @Nivel < 31 AND @OID IS NOT NULL
     BEGIN
       SET @Nivel = @Nivel + 1
       SELECT @Resultado = dbo.fnCFDFlexIDOrigen(@OModulo, @OID,@Nivel)     
       
     END
     
  SELECT @Resultado = ISNULL(@Resultado,'')
  RETURN (@Resultado)
 END
GO

/**************** fnCFDFlexSepararID ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexSepararID') DROP FUNCTION fnCFDFlexSepararID
GO
CREATE FUNCTION dbo.fnCFDFlexSepararID
(@ID     varchar(50), @Tipo varchar(50)) 
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @Resultado      varchar(50),
  @Caracter       int,
  @Longitud		  int
  
  SELECT @Longitud = LEN(@ID)
  SELECT @Caracter= CHARINDEX('#',@ID)

  IF @Tipo = 'ID' AND @Caracter > 0
    SELECT @Resultado =  SUBSTRING(@ID, @Caracter + 1, @Longitud)
  
  IF @Tipo = 'Modulo' AND @Caracter > 0
    SELECT @Resultado =  SUBSTRING(@ID, 1, @Caracter -1 )
                            
  SELECT @Resultado = ISNULL(@Resultado,'')
  RETURN (@Resultado)
 END
GO

/**************** fnCFDFlexCampoOrigen ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexCampoOrigen') DROP FUNCTION fnCFDFlexCampoOrigen
GO
CREATE FUNCTION dbo.fnCFDFlexCampoOrigen
(@Modulo     varchar(5), @ID  int, @Campo varchar(20)) 
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @Resultado      varchar(50),
  @Resultado2     varchar(50),
  @IDOrigen       int,
  @ModuloOrigen   varchar(10),
  @Tipo           varchar(20)
  
  SELECT @Resultado2 = dbo.fnCFDFlexIDOrigen(@Modulo,@ID,1)
  
  SELECT @IDOrigen = CONVERT(int,dbo.fnCFDFlexSepararID(@Resultado2,'ID'))
  SELECT @ModuloOrigen = dbo.fnCFDFlexSepararID(@Resultado2,'Modulo')
  SELECT @Tipo = dbo.fnCFDFlexTipoOrigen(@ModuloOrigen,@IDOrigen)
  
  IF @Campo = 'UUID'
    SELECT @Resultado = CONVERT(varchar(50),UUID) FROM CFD WHERE Modulo = @ModuloOrigen AND ModuloID = @IDOrigen
  
  IF @Campo = 'Serie'
    SELECT @Resultado = Serie FROM CFD WHERE Modulo = @ModuloOrigen AND ModuloID = @IDOrigen
  
  IF @Campo = 'Folio'
    SELECT @Resultado = Folio FROM CFD WHERE Modulo = @ModuloOrigen AND ModuloID = @IDOrigen  
  
  IF @Campo = 'FolioFiscalOrig' AND @Tipo = 'CFDI'
    SELECT @Resultado = CONVERT(varchar(50),UUID) FROM CFD WHERE Modulo = @ModuloOrigen AND ModuloID = @IDOrigen
  ELSE
  IF @Campo = 'SerieFolioFiscalOrig' AND @Tipo = 'CFD'
    SELECT @Resultado = Serie+CONVERT(varchar,Folio) FROM CFD WHERE Modulo = @ModuloOrigen AND ModuloID = @IDOrigen
    
  IF @Campo = 'FechaFolioFiscalOrig'
     SELECT @Resultado = dbo.fneDocFormatoFecha(Fecha,'AAAA-MM-DDTHH:NN:SSZ') FROM CFD WHERE Modulo = @ModuloOrigen AND ModuloID = @IDOrigen
     
  IF @Campo = 'MontoFolioFiscalOrig'
  BEGIN
    IF @ModuloOrigen = 'VTAS'
      SELECT @Resultado = CONVERT(varchar,CONVERT(decimal(20,6),VentaImporteTotal)) FROM CFDVenta WHERE ID = @IDOrigen --BUG 14132
    ELSE
    IF @ModuloOrigen = 'CXC'
      SELECT @Resultado = CONVERT(varchar,CONVERT(decimal(20,6),CxcTotal)) FROM CFDCxc WHERE ID = @IDOrigen --BUG 14132
  END
                 
  SELECT @Resultado = ISNULL(@Resultado,'')
  RETURN (@Resultado)
 END
GO

/**************** fnCFDFlexListaDocOrigenNoAuto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexListaDocOrigenNoAuto') DROP FUNCTION fnCFDFlexListaDocOrigenNoAuto
GO
CREATE FUNCTION fnCFDFlexListaDocOrigenNoAuto (@ID int)
RETURNS @Resultado TABLE (ID int, Empresa varchar(5), Mov varchar(20), MovID varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Modulo		varchar(5)

  SET @Modulo = 'CXC'
  INSERT @Resultado (  ID, Empresa,   Mov,   MovID)
              SELECT o.ID, o.Empresa, o.Mov, o.MovID
                FROM Cxc c
                JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
                LEFT OUTER JOIN DocAuto da ON c.Origen = da.Mov AND c.OrigenID = da.MovID AND c.OrigenTipo = da.Modulo AND c.Empresa = da.Empresa
                JOIN Cxc o ON c.Origen = o.Mov AND c.OrigenID = o.MovID AND c.OrigenTipo = 'CXC' AND c.Empresa = o.Empresa
               WHERE mt.Clave = 'CXC.D' AND da.ID IS NULL AND c.Estatus = 'PENDIENTE' AND c.ID = @ID
               GROUP BY o.ID, o.Empresa, o.Mov, o.MovID
               UNION
              SELECT oo.ID, oo.Empresa, oo.Mov, oo.MovID
                FROM Cxc c
                JOIN CxcD d ON c.ID = d.ID
                JOIN Cxc o ON o.Mov = d.Aplica AND o.MovID = d.AplicaID
                JOIN CxcD od ON od.ID = o.ID
                JOIN Cxc oo ON oo.Mov = od.Aplica AND oo.MovID = od.AplicaID AND oo.Empresa = c.Empresa
                JOIN MovTipo mt ON mt.Mov = o.Mov AND mt.Modulo = 'cxc'
                LEFT OUTER JOIN DocAuto da ON oo.Origen = da.Mov AND oo.OrigenID = da.MovID
               WHERE da.Mov IS NULL AND da.MovID IS NULL AND c.ID = @ID AND mt.Clave = 'CXC.D' AND c.Empresa = oo.Empresa
               GROUP BY oo.ID, oo.Empresa, oo.Mov, oo.MovID
  RETURN 
END
GO
--SELECT * FROM fnCFDFlexListaDocOrigenNoAuto(410)

/**************** fnCFDFlexListaDocNoAuto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexListaDocNoAuto') DROP FUNCTION fnCFDFlexListaDocNoAuto
GO
CREATE FUNCTION fnCFDFlexListaDocNoAuto (@ID int)
RETURNS @Resultado TABLE (ID int, Referencia varchar(50))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OID			int,
    @OEmpresa		char(5),
    @OMov			varchar(20),
    @OMovID			varchar(20)


   SELECT
      @OID = ID,
      @OEmpresa = Empresa,
      @OMov = Mov,
      @OMovID = MovID
     FROM dbo.fnCFDFlexListaDocOrigenNoAuto(@ID)
     
   INSERT @Resultado (ID, Referencia)
               SELECT c.ID, @OMov + ' ' + @OMovID
                 FROM Cxc c
                 JOIN MovTipo mt
                   ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
                WHERE c.Origen = @OMov
                  AND c.OrigenID = @OMovID
                  AND c.Empresa = @OEmpresa
                  AND c.ID <> @OID
                  AND mt.Clave = 'CXC.D' AND c.Estatus = 'PENDIENTE'
                UNION
               SELECT c.ID, @OMov + ' ' + @OMovID
                 FROM Cxc c
                 JOIN CxcD d ON c.ID = d.ID
                 JOIN MovTipo mt
                   ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
                WHERE d.Aplica = @OMov
                  AND d.AplicaID = @OMovID
                  AND mt.Clave = 'CXC.D' AND c.Estatus = 'PENDIENTE'
                UNION
               SELECT c.ID, @OMov + ' ' + @OMovID
                 FROM Cxc c
                 JOIN MovTipo mt
                   ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
                 JOIN Cxc o ON c.Origen = o.Mov AND c.OrigenID = c.OrigenID AND c.Empresa = o.Empresa
                WHERE c.Origen = @OMov
                  AND c.OrigenID = @OMovID
                  AND c.Empresa = @OEmpresa
                  AND c.ID <> @OID
                  AND mt.Clave = 'CXC.D' AND c.Estatus = 'CONCLUIDO'
                UNION
               SELECT c.ID, @OMov + ' ' + @OMovID
                 FROM Cxc c
                 JOIN CxcD d ON c.ID = d.ID
                 JOIN MovTipo mt
                   ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
                 JOIN Cxc o ON c.Origen = o.Mov AND c.OrigenID = c.OrigenID AND c.Empresa = o.Empresa
                WHERE d.Aplica = @OMov
                  AND d.AplicaID = @OMovID
                  AND mt.Clave = 'CXC.D' AND c.Estatus = 'CONCLUIDO'
   RETURN
END
GO
--SELECT * FROM fnCFDFlexListaDocNoAuto(410)

/**************** fnCFDFlexOrigenDetalle ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexOrigenDetalle') DROP FUNCTION fnCFDFlexOrigenDetalle
GO
CREATE FUNCTION fnCFDFlexOrigenDetalle (@ID int)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OID			int,
    @OEmpresa		char(5),
    @OMov			varchar(20),
    @OMovID			varchar(20)
     
   SELECT @OMov = d.Aplica, @OMovID = d.AplicaID, @OEmpresa = c.Empresa FROM CXCD d JOIN CXC c ON d.ID = c.ID WHERE d.ID = @ID
   SELECT @OID = ID FROM CXC WHERE @OMov = Mov AND @OMovID = MovID AND @OEmpresa = Empresa

 RETURN(@OMov)
END
GO
--SELECT dbo.fnCFDFlexOrigenDetalle(288)


/* ***********************************     PROCEDIMIENTOS ALMACENADOS     ************************************/

/**************** spCFDFlexActualizaDocNoAuto  ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE ID = object_id('spCFDFlexActualizaDocNoAuto') AND type = 'P') DROP PROCEDURE dbo.spCFDFlexActualizaDocNoAuto
GO
CREATE PROCEDURE spCFDFlexActualizaDocNoAuto
	     @ID			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OID			int,
    @Contador		int,
    @Referencia		varchar(50),
    @ContadorFinal	int

  SELECT
     @Contador = 1,
     @ContadorFinal = COUNT(ID)
    FROM dbo.fnCFDFlexListaDocNoAuto(@ID)
  
  DECLARE crActualizaDocNoAuto CURSOR FOR
   SELECT ID, Referencia
     FROM dbo.fnCFDFlexListaDocNoAuto(@ID)
     
  OPEN crActualizaDocNoAuto
  FETCH NEXT FROM crActualizaDocNoAuto INTO @OID, @Referencia
  WHILE @@FETCH_STATUS <> -1
  BEGIN
  
    UPDATE Cxc
       SET Referencia = @Referencia+' ('+CONVERT(varchar,@Contador)+ '/' +CONVERT(varchar,@ContadorFinal)+ ')'
      FROM Cxc
     WHERE ID = @OID AND Estatus IN('PENDIENTE','CONCLUIDO')
    
    SELECT @Contador = @Contador + 1
    FETCH NEXT FROM crActualizaDocNoAuto INTO @OID, @Referencia
  END  -- While
  CLOSE crActualizaDocNoAuto
  DEALLOCATE crActualizaDocNoAuto 
  
  --select Referencia, * from Cxc where ID in (select ID FROM dbo.fnListaDocNoAuto(@ID))
  RETURN 
END
GO
--EXEC spCFDFlexActualizaDocNoAuto 219

/**************** speDocOrdenarSeccion ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocOrdenarSeccion') and type = 'P') drop procedure dbo.speDocOrdenarSeccion
GO             
CREATE PROCEDURE speDocOrdenarSeccion
                    @Estacion	int,
				    @Modulo		varchar(5),
                    @eDoc		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Orden		int,
    @Clave		varchar(255),
    @Actividad		varchar(10),
    @ActividadID	int


--  CREATE TABLE #Log (ID int NULL)
  BEGIN TRANSACTION
    SELECT @Orden = 0
    DECLARE crListaSt CURSOR FOR SELECT Clave FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID 
    OPEN crListaSt
    
    FETCH NEXT FROM crListaSt INTO @Clave
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Orden = @Orden + 1
        UPDATE eDocD SET Orden = @Orden WHERE Seccion = @Clave AND eDoc = @eDoc AND Modulo = @Modulo
      END
      FETCH NEXT FROM crListaSt INTO @Clave
    END -- While
    CLOSE crListaSt
    DEALLOCATE crListaSt

   -- DELETE ListaSt WHERE Estacion = @Estacion
  COMMIT TRANSACTION
--ROLLBACK TRAN
  RETURN
END
GO

/**************** speDocOrdenarSeccion ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocOrdenarSeccion') and type = 'P') drop procedure dbo.speDocOrdenarSeccion
GO             
CREATE PROCEDURE speDocOrdenarSeccion
                    @Estacion	int,
				    @Modulo		varchar(5),
                    @eDoc		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Orden		int,
    @Clave		varchar(255),
    @Actividad		varchar(10),
    @ActividadID	int


--  CREATE TABLE #Log (ID int NULL)
  BEGIN TRANSACTION
    SELECT @Orden = 0
    DECLARE crListaSt CURSOR FOR SELECT Clave FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID 
    OPEN crListaSt
    
    FETCH NEXT FROM crListaSt INTO @Clave
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Orden = @Orden + 1
        UPDATE eDocD SET Orden = @Orden WHERE Seccion = @Clave AND eDoc = @eDoc AND Modulo = @Modulo
      END
      FETCH NEXT FROM crListaSt INTO @Clave
    END -- While
    CLOSE crListaSt
    DEALLOCATE crListaSt

   -- DELETE ListaSt WHERE Estacion = @Estacion
  COMMIT TRANSACTION
--ROLLBACK TRAN
  RETURN
END
GO

/**************** speDocCopiar ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocCopiar') and type = 'P') drop procedure dbo.speDocCopiar
GO             
CREATE PROCEDURE speDocCopiar
		@Estacion		int,
		@OModulo		varchar(5),
		@OeDoc			varchar(50),
		@DModulo		varchar(5),
		@DeDoc			varchar(50)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion		varchar(50),
	@Ok					int,
	@OkRef				varchar(255),
	@Orden				int,
	@IDSeccion			int,	
	@Seccion			varchar(50),
	@SubSeccionDe		varchar(50),
	@Vista				varchar(100),
	@Cierre				bit,
	@TablaSt			varchar(50),
	@IDSeccionGenerar	int

  SET @Transaccion = 'speDocCopiar' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  BEGIN TRANSACTION @Transaccion

  INSERT eDoc (Modulo,   eDoc,   TipoXML, Documento, XSD, TipoCFD, DecimalesPorOmision, TipoCFDI, CaracterExtendidoAASCII, ConvertirPaginaCodigo437, ConvertirComillaDobleAASCII)
       SELECT  @DModulo, @DeDoc, TipoXML, Documento, XSD, TipoCFD, DecimalesPorOmision, TipoCFDI, CaracterExtendidoAASCII, ConvertirPaginaCodigo437, ConvertirComillaDobleAASCII
         FROM  eDoc
        WHERE  Modulo = @OModulo
          AND  eDoc = @OeDoc
  IF @@ERROR <> 0 SET @Ok = 1          
           
  DECLARE creDocD CURSOR FOR
   SELECT Orden, Seccion, SubSeccionDe, Vista, Cierre, TablaSt, RID
     FROM eDocD
    WHERE Modulo = @OModulo
      AND eDoc = @OeDoc

  OPEN creDocD
  FETCH NEXT FROM creDocD INTO @Orden, @Seccion, @SubSeccionDe, @Vista, @Cierre, @TablaSt, @IDSeccion
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    INSERT eDocD (Modulo,   eDoc,   Orden,  Seccion,  SubSeccionDe,  Vista,  Cierre,  TablaSt)
          VALUES (@DModulo, @DeDoc, @Orden, @Seccion, @SubSeccionDe, @Vista, @Cierre, @TablaSt)
    IF @@ERROR <> 0 SET @Ok = 1
    SET @IDSeccionGenerar = SCOPE_IDENTITY()
    
    IF @Ok IS NULL 
      INSERT eDocDMapeoCampo (Modulo,   eDoc,   IDSeccion,         CampoXML, CampoVista, FormatoOpcional, Traducir, Opcional, BorrarSiOpcional, TablaSt, Decimales, CaracterExtendidoAASCII, ConvertirPaginaCodigo437, ConvertirComillaDobleAASCII, NumericoNuloACero) --MEJORA5938
                      SELECT  @DModulo, @DeDoc, @IDSeccionGenerar, CampoXML, CampoVista, FormatoOpcional, Traducir, Opcional, BorrarSiOpcional, TablaSt, Decimales, CaracterExtendidoAASCII, ConvertirPaginaCodigo437, ConvertirComillaDobleAASCII, NumericoNuloACero  --MEJORA5938 
                        FROM  eDocDMapeoCampo
                       WHERE  IDSeccion = @IDSeccion
      IF @@ERROR <> 0 SET @Ok = 1           
      
    FETCH NEXT FROM creDocD INTO @Orden, @Seccion, @SubSeccionDe, @Vista, @Cierre, @TablaSt, @IDSeccion
  END
  CLOSE creDocD
  DEALLOCATE creDocD

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION @Transaccion
    SELECT 'Proceso Exitoso'     
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO

--EXEC speDocCopiar 54, 'VTAS', 'AMC7.1', 'VTAS', 'ABRAHAM'

/**************** speDocEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocEliminar') and type = 'P') drop procedure dbo.speDocEliminar
GO             
CREATE PROCEDURE speDocEliminar
		@Estacion		int,
		@Modulo		varchar(5),
		@eDoc			varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion		varchar(50),
	@Ok					int,
	@OkRef				varchar(255)

  SET @Transaccion = 'speDocEliminar' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  BEGIN TRANSACTION @Transaccion

  DELETE FROM eDocDMapeoCampo WHERE Modulo = @Modulo AND eDoc = @eDoc
  IF @@ERROR <> 0 SET @Ok = 1             
  
  IF @Ok IS NULL
  BEGIN
    DELETE FROM eDocD WHERE Modulo = @Modulo AND eDoc = @eDoc  
    IF @@ERROR <> 0 SET @Ok = 1                 
  END
  
  IF @Ok IS NULL
  BEGIN  
    DELETE FROM eDoc WHERE Modulo = @Modulo AND eDoc = @eDoc    
    IF @@ERROR <> 0 SET @Ok = 1                     
  END  
  
  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION @Transaccion
    SELECT 'Proceso Exitoso' 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO

/******************************* speDocGenerarInsercionesPlantilla *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocGenerarInsercionesPlantilla') and type = 'P') drop procedure dbo.speDocGenerarInsercionesPlantilla
GO             
CREATE PROCEDURE speDocGenerarInsercionesPlantilla
		@Modulo		varchar(5),
		@eDoc		varchar(50)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @InsercioneDoc		varchar(max)
  
  DECLARE @Insercion TABLE
          (
          RID			int identity(1,1),
          Datos			varchar(max)
          )

  INSERT @Insercion (Datos)
  SELECT '/********************************* ' + ISNULL(@Modulo,'') + '-' + ISNULL(@eDoc,'') + '-eDoc' + ' *********************************/'

  SELECT @InsercioneDoc = 'IF NOT EXISTS(SELECT * FROM eDoc WHERE Modulo = ' + dbo.fneDocComillas(Modulo) + ' AND eDoc = ' + dbo.fneDocComillas(eDoc) + ') ' + 
         'INSERT INTO eDoc (Modulo, eDoc, TipoXML, Documento, XSD, TipoCFD, DecimalesPorOmision, TipoCFDI, TimbrarEnTransaccion, CaracterExtendidoAASCII, ConvertirPaginaCodigo437, ConvertirComillaDobleAASCII) ' +
         'SELECT ' + dbo.fneDocComillas(Modulo) + ', ' + dbo.fneDocComillas(eDoc) + ',' + CONVERT(varchar,ISNULL(TipoXML,0))+ ', ' + dbo.fneDocComillas(RTRIM(Documento)) + ',' + dbo.fneDocComillas(XSD) + ', ' + CONVERT(varchar,ISNULL(TipoCFD,0)) + ', ' +  CONVERT(varchar,ISNULL(DecimalesPorOmision,2)) + ', ' + CONVERT(varchar,ISNULL(TipoCFDI,0)) + ', ' + CONVERT(varchar,ISNULL(TimbrarEnTransaccion,0)) + ',' + CONVERT(varchar,ISNULL(CaracterExtendidoAASCII,0)) + ',' + CONVERT(varchar,ISNULL(ConvertirPaginaCodigo437,0)) + ', ' + CONVERT(varchar,ISNULL(ConvertirComillaDobleAASCII,0)) + ' ' 
    FROM eDoc 
   WHERE Modulo = @Modulo 
     AND eDoc = @eDoc         

  INSERT @Insercion (Datos)           
  SELECT RTRIM(LTRIM(REPLACE(REPLACE(@InsercioneDoc,CHAR(10),''),CHAR(13),'')))
  
  INSERT @Insercion (Datos)
  SELECT CHAR(71) + CHAR(79)

  INSERT @Insercion (Datos)
  SELECT CHAR(32)

  INSERT @Insercion (Datos)
  SELECT '/* ' + ISNULL(@Modulo,'') + '-' + ISNULL(@eDoc,'') + '-eDocD*/' 

  INSERT @Insercion (Datos)
  SELECT 'IF NOT EXISTS(SELECT * FROM eDocD WHERE Modulo = ' + dbo.fneDocComillas(Modulo)+ ' AND eDoc = ' + dbo.fneDocComillas(eDoc) + ' AND Seccion = ' + dbo.fneDocComillas(Seccion) + ')      INSERT INTO eDocD (Modulo, eDoc, Orden, Seccion, SubSeccionDe, Vista , Cierre, TablaSt) SELECT ' + dbo.fneDocComillas(Modulo) + ', ' + dbo.fneDocComillas(eDoc) + ', '+ CONVERT(varchar,Orden) + ',  ' + dbo.fneDocComillas(Seccion) + ',' + dbo.fneDocComillas(SubSeccionDe) + ',' + dbo.fneDocComillas(Vista) + ',' + CONVERT(varchar,ISNULL(Cierre,0)) + ',' + dbo.fneDocComillas(TablaSt) + ' ' 
    FROM eDocD
   WHERE Modulo = @Modulo
     AND eDoc = @eDoc

  INSERT @Insercion (Datos)
  SELECT CHAR(71) + CHAR(79)

  INSERT @Insercion (Datos)
  SELECT CHAR(32)

  INSERT @Insercion (Datos)
  SELECT '/* ' + ISNULL(@Modulo,'') + '-' + ISNULL(@eDoc,'') + '-eDocDMapeoCampo*/' 

  INSERT @Insercion (Datos)
  SELECT 'IF NOT EXISTS(SELECT * FROM eDocDMapeoCampo eddmc JOIN eDocD edd ON edd.RID = eddmc.IDSeccion WHERE eddmc.Modulo = ' + dbo.fneDocComillas(edd.Modulo) + ' AND eddmc.eDoc = ' + dbo.fneDocComillas(edd.eDoc) + ' AND edd.Seccion = ' + dbo.fneDocComillas(edd.Seccion) + ' AND eddmc.CampoXML = ' + dbo.fneDocComillas(eddmc.CampoXML) + ')  INSERT eDocDMapeoCampo (Modulo, eDoc, IDSeccion, CampoXML, CampoVista, FormatoOpcional, Traducir, Opcional, BorrarSiOpcional, TablaSt, Decimales, CaracterExtendidoAASCII, ConvertirPaginaCodigo437, ConvertirComillaDobleAASCII, NumericoNuloACero) SELECT ' + dbo.fneDocComillas(edd.Modulo) + ', ' + dbo.fneDocComillas(edd.eDoc) + ', (SELECT RID FROM eDocD WHERE Modulo = ' + dbo.fneDocComillas(edd.Modulo) + ' AND eDoc = ' + dbo.fneDocComillas(edd.eDoc) + ' AND Seccion = ' + dbo.fneDocComillas(edd.Seccion) + '), ' + dbo.fneDocComillas(eddmc.CampoXML) + ',  ' + dbo.fneDocComillas(eddmc.CampoVista) + ',' + dbo.fneDocComillas(eddmc.FormatoOpcional) + ',' + CONVERT(varchar,ISNULL(eddmc.Traducir,0)) + ',' + CONVERT(varchar,ISNULL(eddmc.Opcional,0)) + ',' + dbo.fneDocComillas(eddmc.BorrarSiOpcional) + ', ' + dbo.fneDocComillas(eddmc.TablaSt) + ', ' + CONVERT(varchar,ISNULL(Decimales,2)) + ',' + CONVERT(varchar,ISNULL(eddmc.CaracterExtendidoAASCII,0)) + ',' + CONVERT(varchar,ISNULL(eddmc.ConvertirPaginaCodigo437,0)) + ',' + CONVERT(varchar,ISNULL(eddmc.ConvertirComillaDobleAASCII,0)) + ',' + CONVERT(varchar,ISNULL(eddmc.NumericoNuloACero,0)) + ' ' --MEJORA5938
    FROM eDocDMapeoCampo eddmc JOIN eDocD edd
      ON edd.eDoc = eddmc.eDoc AND edd.Modulo = eddmc.Modulo AND eddmc.IDSeccion = edd.RID
   WHERE eddmc.eDoc = @eDoc
     AND eddmc.Modulo = @Modulo
  INSERT @Insercion (Datos)
  SELECT CHAR(71) + CHAR(79)

  INSERT @Insercion (Datos)
  SELECT CHAR(32)
         
  SELECT * FROM @Insercion ORDER BY RID
END
GO

--exec speDocGenerarInsercionesPlantilla 'VTAS', 'AMC7.1'

/******************************* speDocXMLEliminarAtributoVacio *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocXMLEliminarAtributoVacio') and type = 'P') drop procedure dbo.speDocXMLEliminarAtributoVacio
GO             
CREATE PROCEDURE speDocXMLEliminarAtributoVacio
		@Path		varchar(max),
		@Atributo	varchar(max),
		@XML		xml OUTPUT
		


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @SQL			nvarchar(max)

    SET @SQL = N'SET ANSI_NULLS ON ' +
               N'SET ANSI_WARNINGS ON ' +
               N'SET QUOTED_IDENTIFIER ON ' +             
               'SET @XML.modify(' + CHAR(39) + 'delete ' + @Path + '[@' + @Atributo + '=""]/@' + @Atributo + CHAR(39) + ') '

    EXEC sp_executesql @SQL, N'@Path varchar(max), @Atributo varchar(max), @XML xml OUTPUT', @Path = @Path, @Atributo = @Atributo, @XML = @XML OUTPUT
END
GO


/******************************* speDocXMLEliminarElementoVacio *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocXMLEliminarElementoVacio') and type = 'P') drop procedure dbo.speDocXMLEliminarElementoVacio
GO             
CREATE PROCEDURE speDocXMLEliminarElementoVacio
		@Path		varchar(max),
		@XML		xml OUTPUT
		


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @SQL			nvarchar(max)
    
    IF NULLIF(@Path,'') IS NULL RETURN
    SET @SQL = N'SET ANSI_NULLS ON ' +
               N'SET ANSI_WARNINGS ON ' +
               N'SET QUOTED_IDENTIFIER ON ' +             
               'SET @XML.modify(' + CHAR(39) + 'delete ' + @Path + '[not(node())][count(' + @Path+ '/@*)=0]' + CHAR(39) + ') '
    
    EXEC sp_executesql @SQL, N'@Path varchar(max), @XML xml OUTPUT', @Path = @Path, @XML = @XML OUTPUT
    
END
GO


--SET @myDoc.modify('delete /Root/Location[@MachineHours=""]/@MachineHours')

/******************************* speDocXMLLimpiarAtributosAuto *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocXMLLimpiarAtributosAuto') and type = 'P') drop procedure dbo.speDocXMLLimpiarAtributosAuto
GO             
CREATE PROCEDURE speDocXMLLimpiarAtributosAuto
		@XML		xml OUTPUT,
		@Path		varchar(max)


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

DECLARE 
  @Contador				int, 
  @CantidadElementos	int,
  @SQL					nvarchar(max)

  
  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +             
             N'DECLARE @Contador			int, ' + 
             N'        @CantidadElementos	int, ' +
             N'        @NuevoPath			varchar(max),  ' +                          
             N'        @PathElemento		varchar(max),  ' +                                       
             N'        @PathAtributo		varchar(max)   ' +                                                    
             N'SET @CantidadElementos = @xml.query(' + CHAR(39) + 'count(' + ISNULL(@Path,'') + '@*)' + CHAR(39) + ').value(' + CHAR(39) + '.' + CHAR(39) + ',' + CHAR(39) + 'int' + CHAR(39) + ') ' + 
             N'SELECT @Contador = @CantidadElementos ' +             
             N'WHILE @Contador > 0 ' + 
             N'BEGIN ' +
             N'  SELECT  @PathAtributo = @xml.value(' + CHAR(39) + 'local-name((' + ISNULL(@Path,'') + '@*[sql:variable("@Contador")])[1])' + CHAR(39) + ',' + CHAR(39) + 'varchar(max)' + CHAR(39) + ') ' +              
             N'  SELECT @PathElemento = SUBSTRING(@Path,1,LEN(@PATH)-1) ' +             
             N'  EXEC speDocXMLEliminarAtributoVacio @PathElemento, @PathAtributo, @XML OUTPUT ' +
             N'  SELECT  @NuevoPath = @Path + @PathAtributo ' + 
             N'  SET @Contador = @Contador - 1 ' +             
             N'END ' 
             
  EXEC sp_executesql @SQL, N'@Path varchar(max), @XML xml OUTPUT', @Path = @Path, @XML = @XML OUTPUT
END
GO

/******************************* speDocXMLLimpiarAuto *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocXMLLimpiarAuto') and type = 'P') drop procedure dbo.speDocXMLLimpiarAuto
GO             
CREATE PROCEDURE speDocXMLLimpiarAuto
		@XML		xml OUTPUT,
		@Path		varchar(max)


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

DECLARE 
  @Contador				int, 
  @CantidadElementos	int,
  @SQL					nvarchar(max)

  
  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +             
             N'DECLARE @Contador			int, ' + 
             N'        @CantidadElementos	int, ' +
             N'        @NuevoPath			varchar(max),  ' +             
             N'        @PathElemento		varchar(max)   ' +                          
             N'SET @CantidadElementos = @xml.query(' + CHAR(39) + 'count(' + ISNULL(@Path,'') + '*)' + CHAR(39) + ').value(' + CHAR(39) + '.' + CHAR(39) + ',' + CHAR(39) + 'int' + CHAR(39) + ') ' + 
             N'SELECT @Contador = @CantidadElementos ' +             
             N'WHILE @Contador > 0 ' + 
             N'BEGIN ' +
             N'  SELECT  @NuevoPath = @Path + @xml.value(' + CHAR(39) + 'local-name((' + ISNULL(@Path,'') + '*[sql:variable("@Contador")])[1])' + CHAR(39) + ',' + CHAR(39) + 'varchar(max)' + CHAR(39) + ') + ' + CHAR(39) + '/' + CHAR(39) + ' ' + 
             --N'  SELECT @NuevoPath ' +
             N'  EXEC speDocXMLLimpiarAtributosAuto @XML OUTPUT, @NuevoPath ' +                           
             N'  EXEC speDocXMLLimpiarAuto @XML OUTPUT, @NuevoPath ' +
             N'  SELECT @PathElemento = SUBSTRING(@NuevoPath,1,LEN(@NuevoPath)-1) ' +        
             N'  EXEC speDocXMLEliminarElementoVacio @PathElemento, @XML OUTPUT ' +                               
             N'  SET @Contador = @Contador - 1 ' +             
             N'END ' 
             
  EXEC sp_executesql @SQL, N'@Path varchar(max), @XML xml OUTPUT', @Path = @Path, @XML = @XML OUTPUT
END
GO

/*
DECLARE @xml as xml
DECLARE @path as varchar(max)

SET @xml = 
'<doc>
 <a>1</a>
 <b ba="" bb="2" bc="3" />
 <c bd="3"/>
 <d><d1>2</d1><d2></d2></d>
 <e ea="1" eb=""></e>
 <f><f1><f2><f3></f3></f2></f1></f>
</doc>'
SET @Path = '/'

EXEC speDocXMLLimpiarAuto @XML OUTPUT, @Path
SELECT @XML
*/

/******************************* speDocCampoXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocCampoXML') AND TYPE = 'P')
DROP PROCEDURE speDocCampoXML
GO
CREATE PROCEDURE speDocCampoXML
				(
				@Modulo			varchar(5),
				@eDoc			varchar(50),
				@Seccion		varchar(50)
				)  
--//WITH ENCRYPTION
AS  
BEGIN  
  DECLARE		
    @iDatos				int,
    @XML				varchar(max),
    @XMLSeccion			varchar(max)
    
    SELECT @XML = Documento FROM eDoc WHERE Modulo = @Modulo AND eDoc = @eDoc

    SELECT @XMLSeccion = Datos FROM dbo.fneDocDocumentoASecciones(@Modulo, @eDoc) WHERE Nombre = @Seccion
        
    SELECT * FROM dbo.fneDocCampoXMLTexto(@XMLSeccion)
        
END  
GO

/******************************* speDocInsertarCamposXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocInsertarCamposXML') AND TYPE = 'P')
DROP PROCEDURE speDocInsertarCamposXML
GO
CREATE PROCEDURE speDocInsertarCamposXML
				(
				@Modulo			varchar(5),
				@eDoc			varchar(50),
				@IDSeccion		int
				)  
--//WITH ENCRYPTION
AS  
BEGIN  
  DECLARE		
    @iDatos				int,
    @XML				varchar(max),
    @XMLSeccion			varchar(max),
    @Seccion			varchar(50)
    
    SELECT @XML = Documento FROM eDoc WHERE Modulo = @Modulo AND eDoc = @eDoc

    SELECT @Seccion = Seccion FROM eDocD WHERE Modulo = @Modulo AND eDoc = @eDoc AND RID = @IDSeccion

    SELECT @XMLSeccion = Datos FROM dbo.fneDocDocumentoASecciones(@Modulo, @eDoc) WHERE Nombre = @Seccion
    
    DELETE FROM eDocDMapeoCampo WHERE Modulo = @Modulo AND eDoc = @eDoc AND IDSeccion = @IDSeccion
     
    INSERT eDocDMapeoCampo (Modulo,  eDoc,  IDSeccion,  CampoXML)    
                    SELECT  @Modulo, @eDoc, @IDSeccion, Campo 
                      FROM dbo.fneDocCampoXMLTexto(@XMLSeccion)
        
END  
GO

/******************************* speDocSeccionXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocSeccionXML') AND TYPE = 'P')
DROP PROCEDURE speDocSeccionXML
GO
CREATE PROCEDURE speDocSeccionXML
				(
				@Modulo			varchar(5),
				@eDoc			varchar(50)
				)  
--//WITH ENCRYPTION
AS  
BEGIN  
  DECLARE		
    @XML				varchar(max)
    
    SELECT @XML = Documento FROM eDoc WHERE Modulo = @Modulo AND eDoc = @eDoc
        
    SELECT * FROM dbo.fneDocSeccionXMLTexto(@XML)        
        
END  
GO


/******************************* speDocParsearTexto *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocParsearTexto') AND TYPE = 'P')
DROP PROCEDURE speDocParsearTexto
GO

CREATE PROCEDURE speDocParsearTexto
  (
  @Modulo			varchar(5),
  @eDoc				varchar(50),
  @IDSeccion		int,
  @Vista			varchar(50),
  @Texto			varchar(MAX) OUTPUT,
  @Ok				int		     OUTPUT,
  @OkRef			varchar(255) OUTPUT
  )
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
	@Largo									int,
	@Contador								int,
	@TextoRetorno							varchar(MAX),
	@Caracter								char(1),
	@Campo									varchar(255),
	@CampoTraducido							varchar(255),
	@Modo									int,
	@Traducir								bit,	
	@FormatoOpcional						varchar(50),
	@RID									int,
	@Decimales								int,
	@DecimalesPorOmision					int,
	@CaracterExtendidoAASCII				bit, --arcc
	@CaracterExtendidoAASCIIOmision			bit, --arcc	
	@ConvertirPaginaCodigo437				bit, --arcc
	@ConvertirPaginaCodigo437Omision		bit, --arcc	
	@ConvertirComillaDobleAASCII			bit, --arcc
	@ConvertirComillaDobleAASCIIOmision		bit, --arcc --MEJORA5938
	@NumericoNuloACero						bit, --MEJORA5938
	@NumericoNuloACeroTexto					varchar(50)  --MEJORA5938	

				
  SELECT @Largo = LEN(@Texto), @Contador = 1
  SELECT @TextoRetorno = Char(39)
  SELECT @Campo = '', @Modo = 0

  SELECT 
    @DecimalesPorOmision                = DecimalesPorOmision, 
    @CaracterExtendidoAASCIIOmision     = CaracterExtendidoAASCII, 
    @ConvertirPaginaCodigo437Omision    = ConvertirPaginaCodigo437,
    @ConvertirComillaDobleAASCIIOmision = ConvertirComillaDobleAASCII
    FROM eDoc 
   WHERE eDoc = @eDoc
  
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

      SELECT 
        @CampoTraducido              = RTRIM(CampoVista), 
        @FormatoOpcional             = ISNULL(FormatoOpcional,''), 
        @Traducir                    = ISNULL(Traducir,0), 
        @RID                         = RID, 
        @Decimales                   = Decimales,
        @CaracterExtendidoAASCII     = CaracterExtendidoAASCII, 
        @ConvertirPaginaCodigo437    = ConvertirPaginaCodigo437,
        @ConvertirComillaDobleAASCII = ConvertirComillaDobleAASCII,
        @NumericoNuloACero           = ISNULL(NumericoNuloACero,0)
        FROM eDocDMapeoCampo 
       WHERE RTRIM(Modulo) = RTRIM(@Modulo) 
         AND RTRIM(eDoc) = RTRIM(@eDoc) 
         AND IDSeccion = @IDSeccion 
         AND RTRIM(CampoXML) = RTRIM(@Campo)	

      SET @Decimales = ISNULL(ISNULL(@Decimales,@DecimalesPorOmision),2)      
      SET @CaracterExtendidoAASCII = ISNULL(ISNULL(@CaracterExtendidoAASCII,@CaracterExtendidoAASCIIOmision),0) --arcc      
      SET @ConvertirPaginaCodigo437 = ISNULL(ISNULL(@ConvertirPaginaCodigo437,@ConvertirPaginaCodigo437Omision),0) --arcc      
      SET @ConvertirComillaDobleAASCII = ISNULL(ISNULL(@ConvertirComillaDobleAASCII,@ConvertirComillaDobleAASCIIOmision),0) --arcc       
      SET @CampoTraducido = ISNULL(@CampoTraducido,@Campo)

      --MEJORA5938
      IF @NumericoNuloACero = 1 
        SET @NumericoNuloACeroTexto = '0.0'
      ELSE
        SET @NumericoNuloACeroTexto = 'NULL'

      IF @CampoTraducido <> @Campo
      BEGIN      
        IF dbo.fneDocObtenerTipoColumna(@CampoTraducido,@Vista) IN ('real','money','float','decimal','smallmoney') AND @CampoTraducido <> @Campo SET @CampoTraducido = 'ISNULL(RTRIM(LTRIM(CONVERT(varchar,CONVERT(DECIMAL(20,' + LTRIM(RTRIM(CONVERT(varchar,@Decimales))) + '),ISNULL(' + RTRIM(@CampoTraducido) + ',' + @NumericoNuloACeroTexto + '))))),' + CHAR(39) + CHAR(39) + ')' ELSE --MEJORA5938     
        IF dbo.fneDocObtenerTipoColumna(@CampoTraducido,@Vista) IN ('numeric','smallint','int','uniqueidentifier','tinyint','bit','bigint') AND @CampoTraducido <> @Campo SET @CampoTraducido = 'ISNULL(RTRIM(LTRIM(CONVERT(varchar,' + RTRIM(@CampoTraducido) + '))),' + CHAR(39) + CHAR(39) + ')' ELSE
        IF dbo.fneDocObtenerTipoColumna(@CampoTraducido,@Vista) IN ('smalldatetime','datetime') AND @CampoTraducido <> @Campo SET @CampoTraducido = 'ISNULL(RTRIM(LTRIM(dbo.fneDocFormatoFecha(' + RTRIM(@CampoTraducido) + ',' + CHAR(39) + RTRIM(@FormatoOpcional) + CHAR(39) + '))),' + CHAR(39) + CHAR(39) + ')' ELSE
        IF dbo.fneDocObtenerTipoColumna(@CampoTraducido,@Vista) IN ('varbinary','binary') AND @CampoTraducido <> @Campo SET @CampoTraducido = 'ISNULL(RTRIM(LTRIM(CONVERT(varchar,' + RTRIM(@CampoTraducido) + '))),' + CHAR(39) + CHAR(39) + ')' ELSE
        IF dbo.fneDocObtenerTipoColumna(@CampoTraducido,@Vista) IN ('varchar','char','nvarchar','nchar') AND @CampoTraducido <> @Campo SET @CampoTraducido = 'ISNULL(RTRIM(' + RTRIM(@CampoTraducido) + '),' + CHAR(39) + CHAR(39) + ')' ELSE
        IF dbo.fneDocObtenerTipoColumna(@CampoTraducido,@Vista) IS NULL AND @CampoTraducido <> @Campo SET @CampoTraducido = 'ISNULL(RTRIM(' + RTRIM(@CampoTraducido) + '),' + CHAR(39) + CHAR(39) + ')'        

        IF @Traducir = 1 SET @CampoTraducido = 'dbo.fneDocTraducirParseo(' + CHAR(39) + RTRIM(@Modulo) + CHAR(39) + ',' + CHAR(39) + RTRIM(@eDoc) + CHAR(39) + ',' + RTRIM(CONVERT(varchar,@IDSeccion)) + ',' + RTRIM(CONVERT(varchar,@RID)) + ',' + @CampoTraducido +  ')' ELSE --arcc
	    IF @Traducir = 0 SET @CampoTraducido = @CampoTraducido --arcc
        
        IF @CaracterExtendidoAASCII = 1 SET @CampoTraducido = CHAR(39) + ' +  dbo.fneDocXMLAUTF8Min(' + @CampoTraducido +  ',' + CONVERT(varchar,@ConvertirPaginaCodigo437) + ',' + CONVERT(varchar,@ConvertirComillaDobleAASCII) + ') + ' + CHAR(39) ELSE --arcc
	    IF @CaracterExtendidoAASCII = 0 SET @CampoTraducido = CHAR(39) + ' + ' + @CampoTraducido +  ' + ' + CHAR(39) --arcc
	    
--arcc
--select @CaracterExtendidoAASCII,@ConvertirPaginaCodigo437, @ConvertirComillaDobleAASCII, @Campo, @CampoTraducido
	    
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
--select @TextoRetorno + CHAR(39)
  SET @TextoRetorno = @TextoRetorno + CHAR(39)
  SET @Texto = @TextoRetorno
END
GO

/******************************* speDocParsearSeccion *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocParsearSeccion') AND TYPE = 'P')
DROP PROCEDURE speDocParsearSeccion
GO
CREATE PROCEDURE speDocParsearSeccion
  (
  @Estacion			int,
  @Modulo			varchar(5),			
  @eDoc				varchar(50),
  @IDSeccion		int,
  @Tabla			varchar(50),
  @ID				int,
  @Texto			varchar(MAX),
  @SubSeccionDe		varchar(50),
  @Cierre			bit,
  @Compilar			bit,  
  @Select			varchar(MAX) OUTPUT,
  @OrdenSeccion		int OUTPUT,
  @Ok				int OUTPUT,
  @OkRef			varchar(255) OUTPUT
  )
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @OrdenSeccionTexto	varchar(3)

  IF @SubSeccionDe IS NULL SET @OrdenSeccion = @OrdenSeccion + 1

  SET @OrdenSeccionTexto = REPLICATE('0',3-LEN(RTRIM(LTRIM(CONVERT(varchar,@OrdenSeccion))))) + RTRIM(LTRIM(CONVERT(varchar,@OrdenSeccion)))
  
  EXEC speDocParsearTexto @Modulo, @eDoc, @IDSeccion, @Tabla, @Texto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
  IF @Compilar = 0
  BEGIN
    SET @Select = 
        'INSERT eDocSeccionTemporal (Estacion, Modulo, ModuloID, OrdenExportacion, Documento) SELECT ' + 
        RTRIM(LTRIM(CONVERT(varchar,@Estacion))) + ', ' + CHAR(39) + RTRIM(@Modulo) + CHAR(39) + 
        ', ' + RTRIM(LTRIM(CONVERT(varchar,@ID))) + ', ' +  
          CASE ISNULL(@Cierre,0) 
            WHEN 0 THEN CHAR(39) + @OrdenSeccionTexto + CHAR(39) + ' + OrdenExportacion' 
            WHEN 1 THEN ' + RTRIM(' + CHAR(39) + @OrdenSeccionTexto + CHAR(39) + ' + OrdenExportacion) + REPLICATE(''Z'',255 - LEN(RTRIM(LTRIM(' + CHAR(39) + @OrdenSeccionTexto + CHAR(39) + ' + OrdenExportacion))))' 
         END + 
        ' COLLATE Modern_Spanish_CI_AS, ' + @Texto + ' FROM ' + RTRIM(@Tabla) + ' WHERE ID = ' + RTRIM(CONVERT(varchar,@ID)) 
  END ELSE IF @Compilar = 1
  BEGIN
    SET @Select = 
        'INSERT eDocSeccionTemporal (Estacion, Modulo, ModuloID, OrdenExportacion, Documento) SELECT ' + 
        '{Compilacion_Estacion}' + ', ' + CHAR(39) + RTRIM(@Modulo) + CHAR(39) + 
        ', ' + '{Compilacion_ID_Movimiento}' + ', ' +  
          CASE ISNULL(@Cierre,0) 
            WHEN 0 THEN CHAR(39) + @OrdenSeccionTexto + CHAR(39) + ' + OrdenExportacion' 
            WHEN 1 THEN ' + RTRIM(' + CHAR(39) + @OrdenSeccionTexto + CHAR(39) + ' + OrdenExportacion) + REPLICATE(''Z'',255 - LEN(RTRIM(LTRIM(' + CHAR(39) + @OrdenSeccionTexto + CHAR(39) + ' + OrdenExportacion))))' 
         END + 
        ' COLLATE Modern_Spanish_CI_AS, ' + @Texto + ' FROM ' + RTRIM(@Tabla) + ' WHERE ID = ' + '{Compilacion_ID_Movimiento}'   
  END
END
GO


/******************************* speDocLimpiarXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocLimpiarXML') AND TYPE = 'P')
DROP PROCEDURE speDocLimpiarXML
GO
CREATE PROCEDURE speDocLimpiarXML
  (
  @Modulo				varchar(5),
  @eDoc			varchar(50),
  @DocumentoTexto		varchar(MAX) OUTPUT
  )
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE 
    @BorrarSiOpcional			varchar(MAX)
    
  DECLARE crLimpiar CURSOR FOR
   SELECT REPLACE(REPLACE(LTRIM(RTRIM(BorrarSiOpcional)),CHAR(13),''),CHAR(10),'')
     FROM eDocDMapeoCampo
    WHERE eDoc = @eDoc
      AND Modulo = @Modulo
      AND NULLIF(BorrarSiOpcional,'') IS NOT NULL
	  AND Opcional = 1

  OPEN crLimpiar
  FETCH NEXT FROM crLimpiar INTO @BorrarSiOpcional
  WHILE @@FETCH_STATUS = 0
  BEGIN  
    SET @DocumentoTexto = REPLACE(@DocumentoTexto,@BorrarSiOpcional,'')  
    FETCH NEXT FROM crLimpiar INTO @BorrarSiOpcional
  END
  CLOSE crLimpiar
  DEALLOCATE crLimpiar

END
GO


/******************************* speDocBorrarSiOpcional *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocBorrarSiOpcional') AND TYPE = 'P')
DROP PROCEDURE speDocBorrarSiOpcional
GO
CREATE PROCEDURE speDocBorrarSiOpcional
  (
  @CampoXML		varchar(MAX),
  @Atributo		bit
  )
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @BorrarSiOpcional varchar(MAX)

  SET @Atributo = ISNULL(@Atributo,0)
  
  SET @BorrarSiOpcional = RTRIM(REPLACE(REPLACE(@CampoXML,']',''),'[',''))

  IF @Atributo = 0
    SET @BorrarSiOpcional = '<' + @BorrarSiOpcional + '></' + @BorrarSiOpcional + '>'  
  ELSE IF @Atributo = 1
    SET @BorrarSiOpcional = @BorrarSiOpcional + '=""'
    
  SELECT @BorrarSiOpcional
END
GO


/******************************* speDocGenerarXMLSchema *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocGenerarXMLSchema') AND TYPE = 'P')
DROP PROCEDURE speDocGenerarXMLSchema
GO

CREATE PROCEDURE speDocGenerarXMLSchema
  (
  @Modulo			varchar(5),
  @eDoc			varchar(50)
  ) 
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @IDSQL		varchar(100),
	  @XSD				nvarchar(MAX),
	  @XMLSchema		nvarchar(max),
	  @Clave			varchar(50)

  SELECT 
    @Clave = XSD 
    FROM eDoc 
   WHERE Modulo = @Modulo 
     AND eDoc = @eDoc
  
  SET @IDSQL = @Clave
  
  SELECT @XSD = REPLACE(REPLACE(LTRIM(RTRIM(XSD)),CHAR(13),''),CHAR(10),'')
    FROM eDocXSD 
   WHERE Clave = @Clave
     AND Modulo = @Modulo

  IF EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = @IDSQL)
  BEGIN

    SET @XMLSchema = 'DROP XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']'
    EXECUTE sp_executesql @XMLSchema
    
    BEGIN
      SET @XMLSchema = 'CREATE XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']' + ' AS ' + 'N' + CHAR(39) + RTRIM(@XSD) + CHAR(39)
      EXECUTE sp_executesql @XMLSchema
    END
  END
  ELSE
  BEGIN 
    IF NULLIF(RTRIM(@XSD),'') IS NOT NULL
    BEGIN
      SET @XMLSchema = 'CREATE XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']' + ' AS ' + 'N' + CHAR(39) + RTRIM(@XSD) + CHAR(39)
      EXECUTE sp_executesql @XMLSchema
    END
  END
END 
GO

/******************************* speDocValidarXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocValidarXML') AND TYPE = 'P')
DROP PROCEDURE speDocValidarXML
GO
CREATE PROCEDURE speDocValidarXML
  (
  @Modulo		varchar(5),
  @eDoc	varchar(50),
  @XMLValidar	varchar(MAX),
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

  SELECT 
    @Clave = XSD 
    FROM eDoc 
   WHERE Modulo = @Modulo 
     AND eDoc = @eDoc

 SET @IDSQL = @Clave
 
  IF EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = @IDSQL)
  BEGIN  
    --SET @Validacion = 'DECLARE @x XML (' + '[' + RTRIM(@IDSQL) + ']' + ') ' + 'BEGIN TRY SET @x = N' + CHAR(39) + RTRIM(@XMLValidar) + CHAR(39) + ' END TRY BEGIN CATCH SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() END CATCH'

    SET @Validacion = N'DECLARE @x XML (' + '[' + RTRIM(@IDSQL) + ']' + ') ' + 
                      N'BEGIN TRY ' + 
                      N'  SET @x = ' + CHAR(39) + RTRIM(@XMLValidar) + CHAR(39) + ' ' + 
                      N'END TRY ' + 
                      N'BEGIN CATCH ' +
                      N'  SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() ' +
                      N'  IF XACT_STATE() = -1 ' +
                      N'  BEGIN ' +
                      N'    ROLLBACK TRAN ' +
                      N'    SET @ErrorRef = ' + CHAR(39) + 'Error: ' + CHAR(39) + ' + CONVERT(varchar,@Error) + ' + CHAR(39) + ', ' + CHAR(39) + ' + @ErrorRef ' +
                      N'    RAISERROR(@ErrorRef,20,1) WITH LOG ' +
                      N'  END ' + 
                      N'END CATCH ' 


    SET @Parametros = N'@Error int OUTPUT, @ErrorRef varchar(255) OUTPUT'

    EXECUTE sp_executesql @Validacion, @Parametros, @Error = @Error OUTPUT, @ErrorRef = @ErrorRef OUTPUT
    IF @Error IS NOT NULL SELECT @Ok = @Error, @OkRef = @ErrorRef

    --SET @Parametros = '@Error int OUTPUT, @ErrorRef varchar(255) OUTPUT'
    --EXECUTE sp_executesql @Validacion, @Parametros, @Error = @Error OUTPUT, @ErrorRef = @ErrorRef OUTPUT
    --IF @Error IS NOT NULL SELECT @Ok = @Error, @OkRef = @ErrorRef
  END
END 
GO

/**************** fneDocCompilar ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocCompilar') DROP FUNCTION fneDocCompilar
GO
CREATE FUNCTION fneDocCompilar 
	(
	@Modulo				varchar(5),
	@eDoc				varchar(50)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado					bit,
    @UltimoCambio				datetime,
    @UltimaCompilacion			datetime

  SELECT @UltimoCambio = UltimoCambio, @UltimaCompilacion = UltimaCompilacion FROM eDoc WHERE Modulo = @Modulo AND eDoc = @eDoc
              
  IF @UltimoCambio = @UltimaCompilacion 
    SET @Resultado = 0
  ELSE
    SET @Resultado = 1
                  
  IF (SELECT ISNULL(COUNT(1),0) FROM eDocCompilacion WHERE Modulo = @Modulo AND eDoc = @eDoc) = 0 SET @Resultado = 1 --REQ 14790
                 
  RETURN (@Resultado)
END
GO

--SELECT dbo.fneDocCompilar('VTAS','CFDI_3.2')

/******************************* spCFDFlexValidarPlantillaConfiguracion *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCFDFlexValidarPlantillaConfiguracion') AND TYPE = 'P')
DROP PROCEDURE spCFDFlexValidarPlantillaConfiguracion
GO
CREATE PROCEDURE spCFDFlexValidarPlantillaConfiguracion
  (
  @Comprobante		varchar(50),
  @Modulo			char(5),
  @CFDI				bit,
  @Ok				int OUTPUT,
  @OkRef			varchar(255) OUTPUT
  )
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @TipoCFDI		float
  
  SELECT @TipoCFDI = ISNULL(TipoCFDI,0) FROM eDoc WHERE eDoc = @Comprobante AND Modulo = @Modulo
  
  IF @CFDI <> @TipoCFDI
    SELECT @Ok = 71685, @OkRef = @Comprobante
  
  END
GO

/******************************* spCFDFlexValidarXMLImporte *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCFDFlexValidarXMLImporte') AND TYPE = 'P')
DROP PROCEDURE spCFDFlexValidarXMLImporte
GO
CREATE PROCEDURE spCFDFlexValidarXMLImporte
  (
  @Empresa		char(5),
  @XML			varchar(MAX),
  @RutaError	varchar(255),
  @TipoCFDI		bit,
  @Ok			int OUTPUT,
  @OkRef		varchar(255) OUTPUT
  ) 
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @Tolerancia					float,
    @iDatos						int,
    @Ruta						varchar(255),
    @RutaXML					varchar(255),
    @Prefijo					varchar(255),
    @Impuesto					float,
    @Retencion					float,
    @TotalImpuestosRetenidos	float,
    @TotalImpuestosTrasladados	float,
    @Descuento					float,
    @SubTotal					float,
    @Total						float,
    @Importe					float,
	@fecha						datetime


  SELECT @Tolerancia = ISNULL(ToleranciaCalculo,0.0) FROM EmpresaCFD WHERE Empresa = @Empresa
  --SELECT @Tolerancia = 0.0

  DECLARE @Concepto TABLE
  (
	ValorUnitario				float,
	Cantidad					float,
	Importe						float,
	Diferencia					float
  )
    
  IF @TipoCFDI = 0
  BEGIN
    SET @XML = REPLACE(@XML,'xmlns=','xmlns' + CHAR(58) + 'Temp=')	  
    EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML
    SELECT @Ruta = '/'
  END
  ELSE
  BEGIN
    SET @Prefijo = '<ns xmlns' + CHAR(58) + 'cfdi="http' + CHAR(58) + '//www.sat.gob.mx/cfd/3" xmlns' + CHAR(58) + 'tfd="http' + CHAR(58) + '//www.sat.gob.mx/TimbreFiscalDigital"/>'
    EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML, @Prefijo
    SET @Ruta = '/cfdi' + CHAR(58)
  END
        
  SET @RutaXML = @Ruta + 'Comprobante' + @Ruta + 'Conceptos' + @Ruta + 'Concepto'
  INSERT @Concepto (ValorUnitario,            Cantidad,             Importe,             Diferencia)      
            SELECT ISNULL(ValorUnitario,0.0), ISNULL(Cantidad,0.0), ISNULL(importe,0.0), ABS(ISNULL(importe,0.0)-(ISNULL(ValorUnitario,0.0)*ISNULL(Cantidad,0.0)))
    FROM OPENXML (@iDatos, @RutaXML, 1) WITH (valorUnitario float, cantidad float, importe float)
  
  IF EXISTS(SELECT 1 FROM @Concepto WHERE Diferencia > @Tolerancia) SELECT @Ok = 25500, @OkRef = @RutaXML
  
  SELECT @Importe = SUM(Importe) FROM @Concepto
  
  IF @Ok IS NULL
  BEGIN
    SET @RutaXML = @Ruta + 'Comprobante' + @Ruta + 'Impuestos'
    SELECT @TotalImpuestosRetenidos	= ISNULL(totalImpuestosRetenidos,0.00),
           @TotalImpuestosTrasladados	= ISNULL(totalImpuestosTrasladados,0.00)
      FROM OPENXML (@iDatos, @RutaXML, 1) WITH (totalImpuestosRetenidos float, totalImpuestosTrasladados float)
  END      

  IF @Ok IS NULL
  BEGIN    
    SET @RutaXML = @Ruta + 'Comprobante' + @Ruta + 'Impuestos' + @Ruta + 'Traslados' + @Ruta + 'Traslado'
    SELECT @Impuesto	= ISNULL(SUM(importe),0.00)
      FROM OPENXML (@iDatos, @RutaXML, 1) WITH (importe float)

    IF (ABS(@TotalImpuestosTrasladados-@Impuesto) > @Tolerancia) SELECT @Ok = 25500, @OkRef = @RutaXML
  END

  IF @Ok IS NULL
  BEGIN  
    SET @RutaXML = @Ruta + 'Comprobante' + @Ruta + 'Impuestos' + @Ruta + 'Retenciones' + @Ruta + 'Retencion'
    SELECT @Retencion	= ISNULL(SUM(importe),0.00)
      FROM OPENXML (@iDatos, @RutaXML, 1) WITH (importe float)

 --   IF (ABS(@TotalImpuestosRetenidos-@Retencion) > @Tolerancia) SELECT @Ok = 25500, @OkRef = @RutaXML
  END
  
  IF @Ok IS NULL
  BEGIN       
    SET @RutaXML = @Ruta + 'Comprobante'
    SELECT @Descuento	= ISNULL(descuento,0.00),
           @SubTotal	= ISNULL(subTotal,0.00),
           @Total		= ISNULL(total,0.00),
		   @Fecha		= fecha
      FROM OPENXML (@iDatos, @RutaXML, 1) WITH (descuento float, subTotal float, total float, fecha varchar(100))

    IF (ABS(@Importe-(@SubTotal/*- @Descuento*/)) > @Tolerancia) OR (ABS((@SubTotal- @Descuento) - @TotalImpuestosRetenidos + @Impuesto - @Total) > @Tolerancia) SELECT @Ok = 25500, @OkRef = @RutaXML
    IF @TipoCFDI = 1 AND DATEDIFF(hour,@Fecha, getdate()) > 72 SELECT @Ok = 71650, @OkRef = 'Han Pasado Mas de 72 Horas Para Timbrar Este Comprobante'
  END

    
--if @Ok is null select @Ok = 1
END 
GO
--/* DEMO */ spAfectar 'VTAS', 290, 'AFECTAR', 'Todo', NULL, 'DEMO', @Estacion=3

--REQ Q3069 CFDGT
/******************************* spCFDFlexValidarXMLImportefdgt *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCFDFlexValidarXMLImportefdgt') AND TYPE = 'P')
DROP PROCEDURE spCFDFlexValidarXMLImportefdgt
GO
CREATE PROCEDURE spCFDFlexValidarXMLImportefdgt
  (
  @Empresa		char(5),
  @XML			varchar(MAX),
  @RutaError	varchar(255),
  @TipoCFDI		bit,
  @Ok			int OUTPUT,
  @OkRef		varchar(255) OUTPUT
  ) 
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @Tolerancia					float,
    @iDatos						int,
    @Ruta						varchar(255),
    @RutaXML					varchar(255),
    @RutaXML2					varchar(255),
    @Prefijo					varchar(255),
    @Impuesto					float,
    @Retencion					float,
    @TotalImpuestosRetenidos	float,
    @TotalImpuestosTrasladados	float,
    @Descuento					float,
    @SubTotal					float,
    @Total						float,
    @Importe					float

  SELECT @Tolerancia = ISNULL(ToleranciaCalculo,0.0) FROM EmpresaCFD WHERE Empresa = @Empresa

  DECLARE @Detalle TABLE
  (
	ValorUnitario				float,
	Cantidad					float,
	Importe						float,
	Diferencia					float
  )

  DECLARE @Detalle2 TABLE
  (
    ID							int IDENTITY,
	ValorUnitario				float,
	Cantidad					float,
	Importe						float,
	Diferencia					float
  )

  DECLARE @DetalleCantidad TABLE
  (
	ID							int IDENTITY,
	Cantidad					float
  )

  DECLARE @TotalImpuestos TABLE
  (
    ID							int IDENTITY,
	TotalDeImpuestos			float,
	TotalDeIVA					float
  )

  DECLARE @TotalImpuestos2 TABLE
  (
    ID							int IDENTITY,
	TotalDeIVA					float,
	Diferencia					float
  )

  DECLARE @Impuestos TABLE
  (
	ID							int IDENTITY,
	Tipo						varchar(10),
	Base						float,
	Tasa						float,
	Monto						float,
	MontoReal					float,
	Diferencia					float
  )

  DECLARE @Descuentos TABLE
  (
	ID							int IDENTITY,
	Tipo						varchar(10),
	Base						float,
	Tasa						float,
	Monto						float,
	MontoReal					float,
	Diferencia					float
  )

  IF @TipoCFDI = 1
  BEGIN
    SET @XML = REPLACE(@XML,'xmlns=','xmlns' + CHAR(58) + 'Temp=')	  
    IF CHARINDEX('<?xml version="1.0" encoding="Windows-1252"?>', @XML) = 0
      SET @XML = '<?xml version="1.0" encoding="Windows-1252"?>' + @XML
    EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML
    SELECT @Ruta = '/'
  END
        
  SET @RutaXML = '/FactDocGT/Detalles/Detalle'
  SET @RutaXML2 = '/FactDocGT/Detalles/Detalle/ValorSinDR'

  INSERT @DetalleCantidad (Cantidad)
    SELECT ISNULL(Cantidad,0.0)
    FROM OPENXML (@iDatos, @RutaXML, 2) WITH (Precio float, Cantidad float, Monto float)
  
  INSERT @Detalle2 (ValorUnitario,      Importe)
            SELECT ISNULL(Precio,0.0), ISNULL(Monto,0.0)
    FROM OPENXML (@iDatos, @RutaXML2, 2) WITH (Precio float, Cantidad float, Monto float)
    
  INSERT @Detalle (ValorUnitario, Cantidad,   Importe,   Diferencia)      
          SELECT d.ValorUnitario, c.Cantidad, d.Importe, ABS(ISNULL(d.Importe,0.0)-(ISNULL(d.ValorUnitario,0.0)*ISNULL(c.Cantidad,0.0)))
            FROM @Detalle2 d JOIN @detallecantidad c ON d.ID = c.ID
  
  IF EXISTS(SELECT 1 FROM @Detalle WHERE Diferencia > @Tolerancia) SELECT @Ok = 25500, @OkRef = @RutaXML

  IF @Ok IS NULL
  BEGIN      
    SET @RutaXML = '/FactDocGT/Detalles/Detalle/Impuestos'
    SET @RutaXML2 = '/FactDocGT/Detalles/Detalle/Impuestos/Impuesto'

    INSERT @Impuestos(Tipo, Base, Tasa, Monto, MontoReal, Diferencia)
               SELECT Tipo, Base, Tasa, Monto, (ISNULL(Base,0.0)*ISNULL(Tasa,0.0))/100, ABS(ISNULL(Monto,0.0)-((ISNULL(Base,0.0)*ISNULL(Tasa,0.0))/100))
      FROM OPENXML (@iDatos, @RutaXML2, 2) WITH (Tipo varchar(10), Base float, Tasa float, Monto float)
      WHERE Tipo = 'IVA'

    IF EXISTS(SELECT 1 FROM @Impuestos WHERE Diferencia > @Tolerancia) SELECT @Ok = 25500, @OkRef = @RutaXML
  END

  IF @Ok IS NULL
  BEGIN    
    INSERT @TotalImpuestos(TotalDeImpuestos, TotalDeIVA)
                    SELECT TotalDeImpuestos, TotalDeIVA
      FROM OPENXML (@iDatos, @RutaXML, 2) WITH (TotalDeImpuestos float, TotalDeIVA float)

    INSERT @TotalImpuestos2(Diferencia)
                     SELECT ABS(ISNULL(TotalDeIVA,0.0)-((ISNULL(Base,0.0)*ISNULL(Tasa,0.0))/100))
                       FROM @TotalImpuestos t JOIN @Impuestos i
                         ON t.ID = i.ID
  
    IF EXISTS(SELECT 1 FROM @TotalImpuestos2 WHERE Diferencia > @Tolerancia) SELECT @Ok = 25500, @OkRef = @RutaXML
  END

  IF @Ok IS NULL
  BEGIN    
    SET @RutaXML = '/FactDocGT/Detalles/Detalle/DescuentosYRecargos'
    SET @RutaXML2 = '/FactDocGT/Detalles/Detalle/DescuentosYRecargos/DescuentoORecargo'

    INSERT @Descuentos(Tipo, Base, Tasa, Monto, MontoReal, Diferencia)
               SELECT 'Descuento', Base, Tasa, Monto, (ISNULL(Base,0.0)*ISNULL(Tasa/100,0.0)), ABS(ISNULL(Monto,0.0)-((ISNULL(Base,0.0)*ISNULL(Tasa/100,0.0))))
      FROM OPENXML (@iDatos, @RutaXML2, 2) WITH (Base float, Tasa float, Monto float)

    IF (ABS((SELECT SUM(SumaDeDescuentos) FROM OPENXML (@iDatos, @RutaXML, 2) WITH (SumaDeDescuentos float))- (SELECT SUM(MontoReal) FROM @Descuentos)) > @Tolerancia) SELECT @Ok = 25500, @OkRef = @RutaXML  
  END

  IF @Ok IS NULL
  BEGIN    
    SET @RutaXML = '/FactDocGT/Totales/Impuestos'
    SET @RutaXML2 = '/FactDocGT/Totales'

    IF (ABS((SELECT SUM(Base) + SUM(MontoReal) FROM @Impuestos WHERE Tipo = 'IVA')) - (SELECT Total FROM OPENXML (@iDatos, @RutaXML2, 2) WITH (Total float)) > @Tolerancia) SELECT @Ok = 25500, @OkRef = @RutaXML
  END


  IF @Ok IS NULL
  BEGIN    
    SET @RutaXML = '/FactDocGT/Totales'
    SET @RutaXML2 = '/FactDocGT/Totales/DescuentosYRecargos'
  
    IF (ABS((SELECT (SubTotalSinDR - (SELECT SumaDeDescuentos FROM OPENXML (@iDatos, @RutaXML2, 2) WITH (SumaDeDescuentos float))) - SubTotalConDR FROM OPENXML (@iDatos, @RutaXML, 2) WITH (SubTotalSinDR float, SubTotalConDR float))) > @Tolerancia) SELECT @Ok = 25500, @OkRef = @RutaXML  
  END

--select @XML
--if @Ok is null select @Ok = 1
END 
GO
--/* DEMO */ spAfectar 'VTAS', 4527, 'AUTORIZAR', 'Todo', NULL, 'DEMO', @Estacion=2

/******************************* speDocXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocXML') AND TYPE = 'P')
DROP PROCEDURE speDocXML
GO

CREATE PROCEDURE speDocXML
  (
  @Estacion			int,			
  @Empresa			varchar(5),  
  @Modulo			varchar(5),		
  @Mov				varchar(20),
  @ID				int,
  @eDoc				varchar(50) = NULL,
  @Estatus			varchar(15),
  @Registrar		bit = 1,
  @CFDFlex			bit = 0,
  @XMLOut			varchar(max) OUTPUT,
  @Ok				int OUTPUT,
  @OkRef			varchar(255) OUTPUT,
  
  @LlamadaExterna	bit = 0,  
  @Contacto			varchar(10) = NULL  
  )
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE	@Documento				varchar(MAX),
			@Orden					int,
			@Seccion				varchar(50),
			@SubSeccionDe			varchar(50),
			@Vista					varchar(100),
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
			@ApuntadorValido		int,
			@XML					varchar(max),
			@MovTipoeDoc			varchar(50),
			@MovTipoEstatus			varchar(15),
			@LimpiarAutoXML			xml,
			@TipoXML				bit,
			@TagSostener			varchar(max),
			@Tag					varchar(255),				
			@SeccionVerificar		varchar(50),
			@TipoCFD				bit,
			@Compilar				bit,
			--REQ 14790
			@RutaErrorMapeo			varchar(max),
			@Referencia				varchar(max)

  SET @Compilar = dbo.fneDocCompilar(@Modulo, @eDoc)
  
  SELECT @MovTipoEstatus = NULL, @MovTipoeDoc = NULL
  
  DELETE CFDFlexSesion WHERE Estacion = @@SPID
  INSERT CFDFlexSesion(Estacion, Modulo, ID)
  VALUES (@@SPID, @Modulo, @ID)

  IF @LlamadaExterna = 0 
  BEGIN  
    IF @Modulo = 'VTAS' SELECT @Contacto = Cliente     FROM Venta    WHERE ID = @ID ELSE
    IF @Modulo = 'CXC'  SELECT @Contacto = Cliente     FROM Cxc      WHERE ID = @ID ELSE
    IF @Modulo = 'COMS' SELECT @Contacto = Proveedor   FROM Compra   WHERE ID = @ID ELSE
    IF @Modulo = 'CXP'  SELECT @Contacto = Proveedor   FROM Cxp      WHERE ID = @ID ELSE
    IF @Modulo = 'GAS'  SELECT @Contacto = Acreedor    FROM Gasto    WHERE ID = @ID  
  END ELSE
  BEGIN    
    IF @Mov IS NULL AND @Ok IS NULL SELECT @Ok = 10160 ELSE
    IF @Mov IS NOT NULL AND NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov) AND @Ok IS NULL SELECT @Ok = 14055 ELSE    
    IF @Contacto IS NOT NULL AND NOT EXISTS(SELECT * FROM MovTipoeDoc WHERE Modulo = @Modulo AND Mov = @Mov AND Contacto = @Contacto) AND @Ok IS NULL SELECT @Ok = 28020, @OkRef = @Contacto
  END

  IF @CFDFlex = 0
  BEGIN  
    --Primero busca que tipo de documento electronico generar segun el contacto
    SELECT @MovTipoeDoc = ISNULL(eDoc,''), @MovTipoEstatus = Estatus FROM MovTipoeDoc WHERE Contacto = @Contacto AND Mov = @Mov AND Modulo = @Modulo  

    --Si no hay configuracion especial, lo obtiene del tipo de movimiento
    IF NULLIF(@MovTipoeDoc,'') IS NULL AND NULLIF(@MovTipoEstatus,'') IS NULL  
      SELECT @MovTipoeDoc = ISNULL(eDoc,''), @MovTipoEstatus = eDocEstatus FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo

    --Si se invoca desde documento electronico y el estatus no es el correcto sale de el stored procedure
    IF @Estatus <> @MovTipoEstatus RETURN

    --Si eDoc es nulo, obtiene el tipo de documento electronico de MovTipo
    IF NULLIF(@eDoc,'') IS NULL SELECT @eDoc = NULLIF(@MovTipoeDoc,'') 

  END

  --Si no hay configurado ningun Tipo de documento electronico se sale.
  IF @eDoc IS NULL RETURN

  SET @OrdenSeccion = 0
  DELETE eDocSeccionTemporal WHERE Estacion = @Estacion		
  
  SELECT @Documento = Documento, @TipoXML = TipoXML, @TipoCFD = TipoCFD FROM eDoc WHERE Modulo = @Modulo AND eDoc = @eDoc
  SELECT @Codificacion = 'Windows-1252'

  IF @TipoCFD = 1
    SET @Prologo = '<?xml version="1.0" encoding="'+ RTRIM(@Codificacion) +'"?>' --ARCC
  ELSE  
    SET @Prologo = '' --ARCC Regresar despues de las pruebas
  
  --Verifica que las secciones de la plantilla coincidan con la lista de secciones especificada.
  SELECT @SeccionVerificar = NULL
  SELECT 
    @SeccionVerificar = edd.Seccion
    FROM dbo.fneDocDocumentoASecciones(@Modulo,@eDoc) s RIGHT JOIN eDocD edd
      ON s.Nombre = edd.Seccion
   WHERE edd.Modulo = @Modulo
     AND edd.eDoc = @eDoc   
     AND s.Nombre IS NULL 
  IF @SeccionVerificar IS NOT NULL SELECT @Ok = 71620, @OkRef = @SeccionVerificar

  IF @Compilar = 0 --Bug 20825
  BEGIN
    DECLARE @eDocCompilacion TABLE(CodigoSQL varchar(max) NULL)
    INSERT @eDocCompilacion(CodigoSQL)
    SELECT CodigoSQL 
      FROM eDocCompilacion
     WHERE eDoc = @eDoc
        AND Modulo = @Modulo
      ORDER BY Orden  
  END
  
  IF @Compilar = 1
  BEGIN
    DELETE FROM eDocCompilacion WHERE Modulo = @Modulo AND eDoc = @eDoc
    
    DECLARE creDocD CURSOR FAST_FORWARD FOR 
     SELECT medd.Orden, medd.Seccion, NULLIF(medd.SubSeccionDe,''), medd.Vista, medd.Cierre, medd.RID, ds.Datos 
       FROM eDocD medd JOIN dbo.fneDocDocumentoASecciones(@Modulo,@eDoc) ds
         ON ds.nombre = medd.Seccion
      WHERE medd.eDoc = @eDoc
        AND medd.Modulo = @Modulo
      ORDER BY Orden
  END ELSE IF @Compilar = 0
  BEGIN
    DECLARE creDocD CURSOR FAST_FORWARD FOR 
     SELECT CodigoSQL
       FROM @eDocCompilacion --Bug 20825
  END
  
  
  OPEN creDocD
  IF @Compilar = 1
    FETCH NEXT FROM creDocD INTO @Orden, @Seccion, @SubSeccionDe, @Vista, @Cierre, @IDSeccion, @DocumentoSeccion
  ELSE IF @Compilar = 0
     FETCH NEXT FROM creDocD INTO @Select
     
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN    
    IF @Compilar = 1
    BEGIN
      EXEC speDocParsearSeccion @Estacion, @Modulo, @eDoc, @IDSeccion, @Vista, @ID, @DocumentoSeccion, @SubSeccionDe, @Cierre, @Compilar, @Select OUTPUT, @OrdenSeccion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      INSERT eDocCompilacion (Modulo, eDoc, Orden, CodigoSQL) VALUES (@Modulo, @eDoc, @Orden, @Select)      
    END
    SET @Select = REPLACE(@Select,'{Compilacion_Estacion}',RTRIM(LTRIM(CONVERT(varchar,ISNULL(@Estacion,@@SPID)))))
    SET @Select = REPLACE(@Select,'{Compilacion_ID_Movimiento}',RTRIM(LTRIM(CONVERT(varchar,ISNULL(@ID,0.0)))))

	IF @Seccion = 'Encabezado' AND @Ok IS NULL
    BEGIN
      SELECT @NSelect = 'IF (SELECT ISNULL(COUNT(1),0) FROM ' + @Vista + ' WHERE ID = ' + CONVERT(varchar,@ID) + ' ) <> 1 SELECT @OK = 71680' --REQ 14790
      EXECUTE sp_executesql @NSelect, N'@OK int OUTPUT', @OK OUTPUT
    END
    
    IF @Ok IS NULL
    BEGIN
      SET @NSelect = @Select
      BEGIN TRY
        EXECUTE sp_executesql @NSelect
      END TRY
      BEGIN CATCH
        SELECT @Ok = 1, @OkRef = RTRIM(ISNULL(@eDoc,'')) + ':' + RTRIM(ISNULL(@Seccion,'')) + ':Error de mapeo, verifique la sintaxis de las expresiones SQL y que todas devuelvan valores tipo varchar (' + SUBSTRING(ERROR_MESSAGE(),1,48) + ')' 
        IF XACT_STATE() = -1
        BEGIN
          ROLLBACK TRAN
          RAISERROR(@OkRef,20,1) WITH LOG
        END 
      END CATCH    
    END

    IF @Compilar = 1
      FETCH NEXT FROM creDocD INTO @Orden, @Seccion, @SubSeccionDe, @Vista, @Cierre, @IDSeccion, @DocumentoSeccion
    ELSE IF @Compilar = 0
      FETCH NEXT FROM creDocD INTO @Select
  END	
  CLOSE creDocD
  DEALLOCATE creDocD

  DECLARE @SeccionTemporal TABLE(Documento text NULL, RID int, OrdenExportacion varchar(255)) --Bug 20825
  INSERT @SeccionTemporal(Documento,RID,OrdenExportacion)
  SELECT Documento,RID, OrdenExportacion
    FROM eDocSeccionTemporal
    WHERE Estacion = @Estacion AND Modulo = @Modulo AND ModuloID = @ID
    ORDER BY OrdenExportacion,RID

    
  SET @XML = ''
  DECLARE creDocSeccionTemporal CURSOR FAST_FORWARD FOR
   SELECT Documento
     FROM @SeccionTemporal--Bug 2082
     ORDER BY  OrdenExportacion,RID
  OPEN creDocSeccionTemporal
  FETCH NEXT FROM creDocSeccionTemporal INTO @DocumentoTexto
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    SET @XML = @XML + @DocumentoTexto
    FETCH NEXT FROM creDocSeccionTemporal INTO @DocumentoTexto
  END
  CLOSE creDocSeccionTemporal
  DEALLOCATE creDocSeccionTemporal

  IF @TipoXML = 1
  BEGIN
    SELECT @TagSostener = ''
    DECLARE crTagSostener CURSOR FOR
     SELECT Tag
       FROM eDocDTagSostener
      WHERE Modulo = @Modulo
        AND eDoc = @eDoc

    OPEN crTagSostener
    FETCH NEXT FROM crTagSostener INTO @Tag
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      SELECT @TagSostener = @TagSostener + ',' + @Tag 
      FETCH NEXT FROM crTagSostener INTO @Tag
    END
    CLOSE crTagSostener
    DEALLOCATE crTagSostener
   

  END  
  
  EXEC speDocLimpiarXML @Modulo, @eDoc, @XML OUTPUT

  SELECT @XML = dbo.fneDocParsearConsecutivo(@XML)  
  
  SELECT @XML = dbo.fneDocParsearCuenta(@XML)  

  IF @TipoXML = 1
    SELECT @XML = dbo.fneDocLimpiarXML(@XML, @TagSostener)
    
  IF @TipoXML = 1
  BEGIN
    --SET @XML=REPLACE(@XML,'&','&amp;');
    SET @XML = CONVERT(varchar(max),CONVERT(xml,@XML))
    EXEC speDocLimpiarXML @Modulo, @eDoc, @XML OUTPUT
    EXEC speDocValidarXML @Modulo, @eDoc, @XML, @Ok OUTPUT, @OkRef OUTPUT
  END  
  
  SELECT @XMLOut = @Prologo + @XML

  IF ISNULL(@Registrar,0) = 1 AND @Ok IS NULL
  BEGIN
    IF EXISTS(SELECT * FROM MoveDoc WHERE ID = @ID AND Modulo = @Modulo AND Empresa = @Empresa)
    BEGIN
      UPDATE MoveDoc
         SET eDoc = @XMLOUT
       WHERE ID = @ID
         AND Modulo = @Modulo
         AND Empresa = @Empresa
      IF @@ERROR <> 0 SET @Ok = 1     
    END     
    ELSE
    BEGIN
      INSERT MoveDoc (Empresa, Modulo, ID, eDoc) VALUES (@Empresa, @Modulo, @ID, @XMLOUT)
      IF @@ERROR <> 0 SET @Ok = 1           
    END           
  END
  
  IF @Compilar = 1 AND @Ok IS NULL UPDATE eDoc SET UltimaCompilacion = UltimoCambio WHERE Modulo = @Modulo AND eDoc = @eDoc
  
  --REQ 14790
  IF @OK IS NOT NULL
  BEGIN
    
    SELECT @RutaErrorMapeo = RTRIM(LTRIM(ISNULL(RutaTemporal,''))) + '\ErrorMapeo ' + CONVERT(VARCHAR(10),@@SPID) + '.txt' FROM EmpresaCFD WHERE Empresa = @Empresa
    IF RIGHT(@RutaErrorMapeo, 1) = '\' SELECT @RutaErrorMapeo = SUBSTRING(@RutaErrorMapeo, 1, LEN(@RutaErrorMapeo)-1)
    IF @OK = 1   
      SELECT @Referencia = @NSelect
    ELSE
      SELECT @Referencia = 'Error - ' + CONVERT(varchar(10),@Ok) + ' - ' + @OkRef
      
    EXEC spEliminarArchivo @RutaErrorMapeo, NULL, NULL
    EXEC spRegenerarArchivo @RutaErrorMapeo, @Referencia, NULL, NULL
 
  END
  ELSE
    EXEC spEliminarArchivo @RutaErrorMapeo, NULL, NULL
  
END
GO