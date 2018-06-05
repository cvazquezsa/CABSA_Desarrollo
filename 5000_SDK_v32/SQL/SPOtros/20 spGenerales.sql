/* SP GENERALES LOCALES    */
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO 
/**************** spAfectacionUsuario ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectacionUsuario') and type = 'P') drop procedure dbo.spAfectacionUsuario
GO
CREATE PROCEDURE spAfectacionUsuario
			@SPID			int,
			@Usuario		varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DELETE AfectacionUsuario WHERE SPID = @SPID

  INSERT INTO AfectacionUsuario(SPID, Usuario) VALUES(@SPID, @Usuario)
END
GO

/**************** spReferenciaEnMovMovID ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReferenciaEnMovMovID') and type = 'P') drop procedure dbo.spReferenciaEnMovMovID
GO             
CREATE PROCEDURE spReferenciaEnMovMovID
		  	@Referencia 	varchar(50),
		  	@Mov 		varchar(20)	OUTPUT,
			@MovID  	varchar(20)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ultp	int,
    @p		int
  SELECT @Mov = NULL, @MovID = NULL, @Ultp = 0
  SELECT @Referencia = NULLIF(RTRIM(@Referencia), '')
  
  SELECT @p = CHARINDEX(' ', @Referencia)
  WHILE @p > 0
  BEGIN
    SELECT @Ultp = @p
    SELECT @p = CHARINDEX(' ', @Referencia, @p+1)
  END
  SELECT @Mov = RTRIM(SUBSTRING(@Referencia, 1, @Ultp-1)), @MovID = RTRIM(SUBSTRING(@Referencia, @Ultp+1, LEN(@Referencia)))
  RETURN
END
GO

/*
declare
  @Mov varchar(20),
  @MovID varchar(20)
exec spReferenciaEnMovMovID 'Factura Serv 123', @Mov OUTPUT, @MovID OUTPUT
select @Mov, @MovID
*/

-- spReferenciaEnModuloID 'Pedido 2', 'VTAS', @EnSilencio = 0
/**************** spReferenciaEnModuloID ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReferenciaEnModuloID') and type = 'P') drop procedure dbo.spReferenciaEnModuloID
GO             
CREATE PROCEDURE spReferenciaEnModuloID
		  	@Referencia 	varchar(50),
			@Modulo		varchar(5),
			@ID		int = NULL	OUTPUT,
			@EnSilencio	bit = 1
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mov	varchar(20),
    @MovID	varchar(20)
  EXEC spReferenciaEnMovMovID @Referencia, @Mov OUTPUT, @MovID OUTPUT
  EXEC spMovInfo @ID OUTPUT, @Modulo, @Mov = @Mov, @MovID = @MovID
  IF @EnSilencio = 0 SELECT 'ID' = @ID
  RETURN
END
GO

/**************** spMovIDEnSerieConsecutivo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovIDEnSerieConsecutivo') and type = 'P') drop procedure dbo.spMovIDEnSerieConsecutivo
GO             
CREATE PROCEDURE spMovIDEnSerieConsecutivo
			@MovID  	varchar(20),
			@Serie		varchar(50)	OUTPUT,
			@Consecutivo	bigint		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p		int
  SELECT @p = LEN(@MovID)
  
  WHILE @p >= 1 AND dbo.fnEsNumerico(SUBSTRING(@MovID, @p, 1)) = 1
    SELECT @p = @p - 1

  SELECT @Serie = NULLIF(RTRIM(SUBSTRING(@MovID, 1, @p)), ''), @Consecutivo = CONVERT(bigint, RTRIM(SUBSTRING(@MovID, @p+1, LEN(@MovID))))
  RETURN
END
GO

/*
declare
  @Serie 	varchar(20),
  @Consecutivo	int
exec spMovIDEnSerieConsecutivo 'A123', @Serie OUTPUT, @Consecutivo OUTPUT
select @Serie, @Consecutivo
*/

/**************** spReemplazar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReemplazar') and type = 'P') drop procedure dbo.spReemplazar
GO             
CREATE PROCEDURE spReemplazar
		  	@Que 	varchar(255),
		  	@Por 	varchar(255),
			@Texto  varchar(8000)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p	int
  SELECT @p = CHARINDEX(@Que, @Texto)
  WHILE @p > 0
  BEGIN
    SELECT @Texto = STUFF(@Texto, @p, LEN(@Que), @Por)
    SELECT @p = CHARINDEX(@Que, @Texto, @p + LEN(@Que) + 1)
  END
  RETURN
END
GO

/*
declare
  @texto varchar(8000)
select @texto = 'pepe heffes'
exec spReemplazar 'heffes', 'antar', @texto output
select @texto+'*'
*/

/**************** spExtraerPalabra ****************/
if exists (select * from sysobjects where id = object_id('dbo.spExtraerPalabra') and type = 'P') drop procedure dbo.spExtraerPalabra
GO             
CREATE PROCEDURE spExtraerPalabra
		  	@Texto 	  varchar(8000)	OUTPUT,
			@Palabra  varchar(8000)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN  DECLARE
    @p 		int,
    @l		char(1),
    @Salir	bit,
    @Brincar	bit,
    @Leer	char(1)

  SELECT @Salir = 0, @Leer = NULL, @p = 1, @Palabra = ''
  WHILE @Salir = 0 AND @p <= LEN(@Texto) 
  BEGIN    
    SELECT @Brincar = 0, @l = RTRIM(SUBSTRING(@Texto, @p, 1))
    IF @l IN ('"', "'")
    BEGIN
      IF @Leer IS NULL
        SELECT @Leer = @l, @Brincar = 1
      ELSE 
        IF @l = @Leer SELECT @Salir = 1 
    END
    IF @Leer IS NOT NULL AND @Brincar = 0 AND @Salir = 0
      SELECT @Palabra = RTRIM(@Palabra)+@l

    IF @Salir = 1 AND @Palabra <> ''
    BEGIN
      SELECT @Texto = NULLIF(RTRIM(SUBSTRING(@Texto, @p+1, LEN(@Texto))), '')
      IF @Texto IS NOT NULL
        IF SUBSTRING(@Texto, 1, 1) = ',' 
          SELECT @Texto = NULLIF(RTRIM(SUBSTRING(@Texto, 2, LEN(@Texto))), '')
    END
   
    SELECT @p = @p + 1
  END
  SELECT @Palabra = NULLIF(RTRIM(@Palabra), '')
  RETURN
END
GO

/*
DECLARE
  @Texto    varchar(255),
  @Palabra  varchar(255)
SELECT @Texto = "'N', '01222', 'HOLA'"
EXEC spExtraerPalabra @Texto OUTPUT, @Palabra OUTPUT
SELECT @Palabra, @Texto
EXEC spExtraerPalabra @Texto OUTPUT, @Palabra OUTPUT
SELECT @Palabra, @Texto
EXEC spExtraerPalabra @Texto OUTPUT, @Palabra OUTPUT
SELECT @Palabra, @Texto
*/


/**************** spExtraerDato ****************/
if exists (select * from sysobjects where id = object_id('dbo.spExtraerDato') and type = 'P') drop procedure dbo.spExtraerDato
GO             
CREATE PROCEDURE spExtraerDato
		  	@Texto 	  	varchar(8000)	OUTPUT,
			@Dato     	varchar(8000)	OUTPUT,
                        @Separador	varchar(10),
			@Alreves	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @up		int,
    @p 		int

  SELECT @Dato = NULL, @up = 0
  SELECT @p = CHARINDEX(@Separador, @Texto)
  IF @Alreves = 1
  BEGIN
    WHILE @p > 0 
    BEGIN
      SELECT @up = @p
      SELECT @p = CHARINDEX(@Separador, @Texto, @p+1)
    END
    SELECT @p = @up
  END

  IF @p > 0
  BEGIN
    IF @Alreves = 1
    BEGIN
      SELECT @Dato = NULLIF(LTRIM(RTRIM(SUBSTRING(@Texto, @p+1, LEN(@Texto)))), '')
      SELECT @Texto = NULLIF(LTRIM(RTRIM(SUBSTRING(@Texto, 1, @p-1))), '')
    END ELSE 
    BEGIN
      SELECT @Dato = NULLIF(LTRIM(RTRIM(SUBSTRING(@Texto, 1, @p-1))), '')
      SELECT @Texto = NULLIF(LTRIM(RTRIM(SUBSTRING(@Texto, @p+1, LEN(@Texto)))), '')
    END
  END ELSE
    SELECT @Dato = NULLIF(LTRIM(RTRIM(@Texto)), ''), @Texto = NULL

  RETURN
END
GO

/*
DECLARE
  @Texto    varchar(255),
  @Dato     varchar(20)
SELECT @Texto = 'Ficha.Layout'
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, '.', @Alreves = 1
SELECT '*'+@Dato+'*', @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ',', @Alreves = 1
SELECT '*'+@Dato+'*', @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ',', @Alreves = 1
SELECT '*'+@Dato+'*', @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ',', @Alreves = 1
SELECT '*'+@Dato+'*', @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ',', @Alreves = 1
SELECT '*'+@Dato+'*', @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ',', @Alreves = 1
SELECT '*'+@Dato+'*', @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ',', @Alreves = 1
SELECT '*'+@Dato+'*', @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ',', @Alreves = 1
SELECT '*'+@Dato+'*', @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ',', @Alreves = 1
SELECT '*'+@Dato+'*', @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ',', @Alreves = 1
SELECT '*'+@Dato+'*', @Texto
*/

/**************** spExtraerFloat ****************/
if exists (select * from sysobjects where id = object_id('dbo.spExtraerFloat') and type = 'P') drop procedure dbo.spExtraerFloat
GO             
CREATE PROCEDURE spExtraerFloat
		  	@Texto 	  	varchar(8000)	OUTPUT,
			@Float     	float		OUTPUT,
                        @Separador	varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FloatSt	varchar(255)

  SELECT @Float = NULL
  EXEC spExtraerDato @Texto OUTPUT, @FloatSt OUTPUT, @Separador
  IF dbo.fnEsNumerico(@FloatSt) = 1
    SELECT @Float = CONVERT(float, @FloatSt)
  RETURN
END
GO

/**************** spExtraerMoney ****************/
if exists (select * from sysobjects where id = object_id('dbo.spExtraerMoney') and type = 'P') drop procedure dbo.spExtraerMoney
GO             
CREATE PROCEDURE spExtraerMoney
		  	@Texto 	  	varchar(8000)	OUTPUT,
			@Money     	money		OUTPUT,
                        @Separador	varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MoneySt	varchar(255)

  SELECT @Money = NULL
  EXEC spExtraerDato @Texto OUTPUT, @MoneySt OUTPUT, @Separador
  IF dbo.fnEsNumerico(@MoneySt) = 1
    SELECT @Money = CONVERT(money, @MoneySt)
  RETURN
END
GO

/**************** spExtraerInt ****************/
if exists (select * from sysobjects where id = object_id('dbo.spExtraerInt') and type = 'P') drop procedure dbo.spExtraerInt
GO             
CREATE PROCEDURE spExtraerInt
		  	@Texto 	  	varchar(8000)	OUTPUT,
			@int     	int		OUTPUT,
                        @Separador	varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @IntSt	varchar(255)

  SELECT @Int = NULL
  EXEC spExtraerDato @Texto OUTPUT, @intSt OUTPUT, @Separador
  IF dbo.fnEsNumerico(@IntSt) = 1
    SELECT @Int = CONVERT(int, @IntSt)
  RETURN
END
GO




/*
DECLARE
  @Texto    varchar(255),
  @Dato     varchar(20)
SELECT @Texto = " 1430 ,SU67835,16/06/2004 ,13:50:55,16/06/2004 ,14:37:30, 7190 , 3575 , 3615"
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ',', @Alreves = 1
SELECT '*'+@Dato+'*', @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ','
SELECT @Dato, @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ','
SELECT @Dato, @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ','
SELECT @Dato, @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ','
SELECT @Dato, @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ','
SELECT @Dato, @Texto
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ','
SELECT @Dato, @Texto

DECLARE
  @Texto    varchar(255),
  @Dato     varchar(255)
SELECT @Texto = "5600-0002-0001-000            ,0101"
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ','
SELECT "Dato" = @Dato
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, ','
SELECT "Dato" = @Dato


DECLARE
  @Texto    varchar(255),
  @Dato     varchar(255),
  @Separador	varchar(10)

SELECT @Separador = CHAR(9),
       @Texto = "CYRP	200	Salida Diversa	03/19/03	TRI-N	Venta Aceptada	57	5	20.00"
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, @Separador
SELECT "Dato" = @Dato
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, @Separador
SELECT "Dato" = @Dato
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, @Separador
SELECT "Dato" = @Dato
EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, @Separador
SELECT "Dato" = @Dato

*/


/**************** spExtraerNumero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spExtraerNumero') and type = 'P') drop procedure dbo.spExtraerNumero
GO             
CREATE PROCEDURE spExtraerNumero
		  	@Texto 	  	varchar(8000)	OUTPUT,
			@Numero     	int		OUTPUT,
                        @Separador	varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dato     	varchar(255)

  EXEC spExtraerDato @Texto OUTPUT, @Dato OUTPUT, @Separador
  SELECT @Numero = CONVERT(int, @Dato)
  RETURN
END
GO
/*
declare
  @Ok int,
  @OkRef varchar(255)
exec spOpcionValidar 'ERPII', 'V4', 'GENERAR', @Ok OUTPUT, @OkRef OUTPUT
select @Ok, @OkRef
*/

/**************** spOpcionValidar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOpcionValidar') and type = 'P') drop procedure dbo.spOpcionValidar
GO
CREATE PROCEDURE spOpcionValidar
			@Articulo	char(20),
    			@SubCuenta	varchar(50),
			@Accion			char(20),
			@CfgOpcionBloquearDescontinuado		bit, --MEJORA5547
			@CfgOpcionPermitirDescontinuado		bit, --MEJORA5547
   		   	@Ok									int          	OUTPUT,
    		@OkRef								varchar(255) 	OUTPUT   	
    		   	
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p 			int,
    @Salir		bit,
    @l			char(1),
    @Opcion		char(1),
    @UltOpcion		char(1),
    @NumSt		char(20),
    @ListaEspecifica	varchar(50),
    @Numero		int,
    @Requeridos		int,
    @TieneDetalle	bit,
    @TipoDetalle	varchar(20),
    @Descontinuado	bit --MEJORA5547

  CREATE TABLE #Opcion(Opcion char(1) COLLATE Database_Default NULL, Numero int NULL)

  SELECT @SubCuenta = ISNULL(@SubCuenta,1) --JGD 12Sep2011. Solución Ticket 5889
  SELECT @Salir = 0, @p = 1, @Opcion = NULL, @NumSt = NULL
  WHILE @Salir = 0 AND @p <= LEN(@SubCuenta) AND @Ok IS NULL
  BEGIN
    SELECT @l = RTRIM(SUBSTRING(@SubCuenta, @p, 1))
    IF dbo.fnEsNumerico(@l) = 1
    BEGIN
      IF @Opcion IS NULL SELECT @Ok = 20045
      SELECT @NumSt = RTRIM(ISNULL(@NumSt, '')) + @l
    END ELSE 
    BEGIN
      IF @Opcion IS NOT NULL
      BEGIN
        IF @NumSt IS NULL
          SELECT @Numero = NULL
        ELSE
          SELECT @Numero = CONVERT(int, @NumSt)
        INSERT #Opcion (Opcion, Numero) VALUES (@Opcion, @Numero)
        SELECT @Opcion = NULL, @NumSt = NULL
      END
      SELECT @Opcion = @l
    END
    SELECT @p = @p + 1
  END
  IF @Opcion IS NOT NULL
  BEGIN
    SELECT @Numero = NULLIF(CONVERT(int, @NumSt), 0)
    INSERT #Opcion (Opcion, Numero) VALUES (@Opcion, @Numero)
    SELECT @Opcion = NULL, @NumSt = NULL
  END
  SELECT @Requeridos = 0
  SELECT @Requeridos = ISNULL(COUNT(*), 0) FROM ArtOpcion WHERE Articulo = @Articulo AND Requerido = 1 
  IF @Requeridos <> ISNULL((SELECT COUNT(*) FROM ArtOpcion ao, #Opcion o WHERE ao.Articulo = @Articulo AND ao.Requerido = 1 AND ao.Opcion = o.Opcion), 0) SELECT @Ok = 20046

  SELECT @UltOpcion = NULL
  DECLARE crOpcion CURSOR FOR 
   SELECT op.Opcion, op.Numero, o.TieneDetalle, NULLIF(RTRIM(UPPER(o.TipoDetalle)), ''), ISNULL(Descontinuado,0) --MEJORA5547
     FROM #Opcion op LEFT OUTER JOIN Opcion o --MEJORA5547
       ON op.Opcion = o.Opcion LEFT OUTER JOIN OpcionD od --MEJORA5547
       ON od.Opcion = o.Opcion AND od.Numero = op.Numero --MEJORA5547

  OPEN crOpcion
  FETCH NEXT FROM crOpcion INTO @Opcion, @Numero, @TieneDetalle, @TipoDetalle, @Descontinuado --MEJORA5547
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      IF @TieneDetalle IS NULL SELECT @Ok = 20042 
      ELSE 
      BEGIN
        IF @UltOpcion IS NOT NULL AND @Opcion <= @UltOpcion SELECT @Ok = 20049
        SELECT @UltOpcion = @Opcion
        SELECT @ListaEspecifica = NULL
        SELECT @ListaEspecifica = NULLIF(RTRIM(ListaEspecifica), '') FROM ArtOpcion WHERE Articulo = @Articulo AND Opcion = @Opcion
        IF @@ROWCOUNT = 0 SELECT @Ok = 20047
      END
      IF @Ok IS NULL
      BEGIN
        IF @TipoDetalle IN (NULL, 'NUMERO')
        BEGIN
          IF @TieneDetalle = 1
          BEGIN
            IF UPPER(@ListaEspecifica) IN (NULL, '(TODAS)')
            BEGIN
              IF NOT EXISTS(SELECT * FROM OpcionD WHERE Opcion = @Opcion AND Numero = @Numero) SELECT @Ok = 20048
              
            END ELSE
            IF UPPER(@ListaEspecifica) = '(ESPECIAL)'
            BEGIN
              IF NOT EXISTS(SELECT * FROM ArtOpcionD WHERE Articulo = @Articulo AND Opcion = @Opcion AND Numero = @Numero) SELECT @Ok = 20048
              IF @Accion = 'AFECTAR'
              BEGIN
                IF (SELECT TieneMovimientos FROM ArtOpcionD WHERE Articulo = @Articulo AND Opcion = @Opcion AND Numero = @Numero) = 0
                  UPDATE ArtOpcionD SET TieneMovimientos = 1 WHERE Articulo = @Articulo AND Opcion = @Opcion AND Numero = @Numero
              END

            END ELSE
            BEGIN
              IF NOT EXISTS(SELECT * FROM OpcionListaD WHERE Opcion = @Opcion AND Lista = @ListaEspecifica AND Numero = @Numero) SELECT @Ok = 20048
            END
            IF @Accion = 'AFECTAR' 
            BEGIN
              IF (SELECT TieneMovimientos FROM OpcionD WHERE Opcion = @Opcion AND Numero = @Numero) = 0
                UPDATE OpcionD SET TieneMovimientos = 1 WHERE Opcion = @Opcion AND Numero = @Numero
            END
            IF NULLIF(@Ok,0) IS NULL AND @CfgOpcionBloquearDescontinuado = 1 AND @CfgOpcionPermitirDescontinuado = 0 AND @Descontinuado = 1 SELECT @Ok = 20053 --MEJORA5547                      
          END ELSE 
            IF @Numero IS NOT NULL SELECT @Ok = 20048
        END ELSE
        BEGIN
          IF @Numero IS NULL SELECT @Ok = 20048
        END

        IF @Accion = 'AFECTAR'
        BEGIN
          IF (SELECT TieneMovimientos FROM Opcion WHERE Opcion = @Opcion) = 0
            UPDATE Opcion SET TieneMovimientos = 1 WHERE Opcion = @Opcion
          IF (SELECT TieneMovimientos FROM ArtOpcion WHERE Articulo = @Articulo AND Opcion = @Opcion) = 0
            UPDATE ArtOpcion SET TieneMovimientos = 1 WHERE Articulo = @Articulo AND Opcion = @Opcion
        END
      END
      IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@Articulo)+' - '+RTRIM(Descripcion)+' ('+@Opcion+LTRIM(CONVERT(char, @Numero))+')' FROM Opcion WHERE Opcion = @Opcion
    END
    FETCH NEXT FROM crOpcion INTO @Opcion, @Numero, @TieneDetalle, @TipoDetalle, @Descontinuado --MEJORA5547
  END
  CLOSE crOpcion
  DEALLOCATE crOpcion
  RETURN
END
GO


/* 
SET NOCOUNT ON
DECLARE @Ok int, @OkRef varchar(255)
SELECT @Ok = NULL, @OkRef = NULL
EXEC spOpcionValidar 'C920', 'C2', @Ok OUTPUT, @OkRef OUTPUT
SELECT @Ok, @OkRef

SELECT * FROM ARTOPCION where articulo = 'c920' and requerido = 1

*/

/**************** spOpcionHeredar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOpcionHeredar') and type = 'P') drop procedure dbo.spOpcionHeredar
GO
CREATE PROCEDURE spOpcionHeredar
			@SubCuenta	varchar(50),
			@Material	varchar(20),

    			@mSubCuenta	varchar(50)	OUTPUT,
   		   	@Ok             int          	OUTPUT,
    		   	@OkRef          varchar(255) 	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p 			int,
    @Salir		bit,
    @l			char(1),
    @Opcion		char(1),
    @NumSt		char(20),
    @Numero		int

  SELECT @mSubCuenta = NULL
  CREATE TABLE #Opcion(Opcion char(1) COLLATE Database_Default NULL, Numero int NULL)

  SELECT @Salir = 0, @p = 1, @Opcion = NULL, @NumSt = NULL
  WHILE @Salir = 0 AND @p <= LEN(@SubCuenta) AND @Ok IS NULL
  BEGIN
    SELECT @l = RTRIM(SUBSTRING(@SubCuenta, @p, 1))
    IF dbo.fnEsNumerico(@l) = 1
    BEGIN
      IF @Opcion IS NULL SELECT @Ok = 20045
      SELECT @NumSt = RTRIM(ISNULL(@NumSt, '')) + @l
    END ELSE 
    BEGIN
      IF @Opcion IS NOT NULL
      BEGIN
        IF @NumSt IS NULL
          SELECT @Numero = NULL
        ELSE
          SELECT @Numero = CONVERT(int, @NumSt)
        INSERT #Opcion (Opcion, Numero) VALUES (@Opcion, @Numero)
        SELECT @Opcion = NULL, @NumSt = NULL
      END
      SELECT @Opcion = @l
    END
    SELECT @p = @p + 1
  END
  IF @Opcion IS NOT NULL
  BEGIN
    SELECT @Numero = NULLIF(CONVERT(int, @NumSt), 0)
    INSERT #Opcion (Opcion, Numero) VALUES (@Opcion, @Numero)
    SELECT @Opcion = NULL, @NumSt = NULL
  END

  DECLARE crOpcion CURSOR FOR 
   SELECT o.Opcion, o.Numero
     FROM ArtOpcion ao, #Opcion o
    WHERE ao.Articulo = @Material AND ao.Opcion = o.Opcion
    ORDER BY Orden
     
  OPEN crOpcion
  FETCH NEXT FROM crOpcion INTO @Opcion, @Numero
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN     
      SELECT @mSubCuenta = ISNULL(@mSubCuenta, '') + @Opcion
      IF @Numero IS NOT NULL
        SELECT @mSubCuenta = @mSubCuenta + LTRIM(CONVERT(char, @Numero))
    END
    FETCH NEXT FROM crOpcion INTO @Opcion, @Numero
  END
  CLOSE crOpcion
  DEALLOCATE crOpcion

  RETURN
END
GO

/*

DECLARE @SubCuenta varchar(50)
EXEC spOpcionHeredar 'ABE31F312GH3I54JR3PQ', 'C920', @SubCuenta OUTPUT, NULL, NULL
SELECT @SubCuenta

*/

/**************** spOpcionExtraerNumero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOpcionExtraerNumero') and type = 'P') drop procedure dbo.spOpcionExtraerNumero
GO
CREATE PROCEDURE spOpcionExtraerNumero
			@SubCuenta	varchar(50),
    			@Letra		char(1),
			@Numero		int		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p		int,
    @NumeroSt 	varchar(50)

  SELECT @Numero = NULL, @NumeroSt = ''
  SELECT @p = CHARINDEX(@Letra, @SubCuenta)
  IF @p>0
  BEGIN
    SELECT @p = @p + 1
    WHILE @p <= LEN(@SubCuenta) AND dbo.fnEsNumerico(SUBSTRING(@SubCuenta, @p, 1)) = 1 
    BEGIN 
      SELECT @NumeroSt = ISNULL(@NumeroSt, '') + RTRIM(SUBSTRING(@SubCuenta, @p, 1))
      SELECT @p = @p + 1
    END
    IF LEN(@NumeroSt) > 0 SELECT @Numero = CONVERT(int, @NumeroSt)
  END
  
  RETURN
END
GO


/*
DECLARE
  @Numero int

EXEC spOpcionExtraerNumero 'A123B2873C8374D8723E', 'A', @Numero OUTPUT
SELECT @Numero
*/

/**************** spOpcionExiste ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOpcionExiste') and type = 'P') drop procedure dbo.spOpcionExiste
GO
CREATE PROCEDURE spOpcionExiste
			@Texto		varchar(100),
    			@EnTexto	varchar(50),
			@Existe		bit		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @i		int,
    @r  	int,
    @Letra 	char(1),
    @RangoD	int,
    @RangoA	int,
    @Numero	int


  SELECT @Existe = 0
  SELECT @r = CHARINDEX(':', @Texto)
  IF @r > 0
  BEGIN
    SELECT @Letra = SUBSTRING(@Texto, 1, 1),
           @RangoD = CONVERT(int, SUBSTRING(@Texto, 2, @r-2)),
           @RangoA = CONVERT(int, SUBSTRING(@Texto, @r+1, LEN(@Texto)))
    EXEC spOpcionExtraerNumero @EnTexto, @Letra, @Numero OUTPUT
    IF @Numero IS NOT NULL AND @Numero BETWEEN @RangoD AND @RangoA SELECT @Existe = 1
  END ELSE
  BEGIN
    SELECT @i = CHARINDEX(@Texto, @EnTexto)
    IF @i > 0 AND (LEN(@Texto) = 1 OR LEN(@EnTexto) = @i OR dbo.fnEsNumerico(SUBSTRING(@EnTexto, @i+LEN(@Texto), 1)) = 0) SELECT @Existe = 1
  END
  RETURN
END
GO

/**************** spOpcionContinuar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOpcionContinuar') and type = 'P') drop procedure dbo.spOpcionContinuar
GO
CREATE PROCEDURE spOpcionContinuar
			@SiOpcion	varchar(100),
    			@SubCuenta	varchar(50),

			@Continuar	bit		OUTPUT,

   		   	@Ok             int          	OUTPUT,
    		   	@OkRef          varchar(255) 	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Texto	varchar(100),
    @p 		int,
    @pa		int,
    @Negar	bit,
    @Existe	bit

  SELECT @Continuar = 1
  IF @SiOpcion IS NULL OR @SubCuenta IS NULL RETURN

  SELECT @Negar = 0, @Existe = 0, @SiOpcion = NULLIF(RTRIM(@SiOpcion), ''), @SubCuenta = NULLIF(RTRIM(@SubCuenta), '')
  
  IF SUBSTRING(@SiOpcion, 1, 2) = '<>' SELECT @SiOpcion = RTRIM(SUBSTRING(@SiOpcion, 3, LEN(@SiOpcion))), @Negar = 1 ELSE
  IF SUBSTRING(@SiOpcion, 1, 1) = '='  SELECT @SiOpcion = RTRIM(SUBSTRING(@SiOpcion, 2, LEN(@SiOpcion)))

  SELECT @p = CHARINDEX(',', @SiOpcion)
  IF @p > 0
  BEGIN
    SELECT @Texto = NULL, @pa = 1
    WHILE @p > 0 AND @Existe = 0
    BEGIN
      SELECT @Texto = LTRIM(RTRIM(SUBSTRING(@SiOpcion, @pa, @p-@pa)))
      EXEC spOpcionExiste @Texto, @SubCuenta, @Existe OUTPUT

      SELECT @pa = @p + 1
      SELECT @p = CHARINDEX(',', @SiOpcion, @pa)
      IF @p = 0 SELECT @Texto = LTRIM(RTRIM(SUBSTRING(@SiOpcion, @pa, LEN(@SiOpcion))))
    END
  END ELSE SELECT @Texto = @SiOpcion

  EXEC spOpcionExiste @Texto, @SubCuenta, @Existe OUTPUT

  IF @Negar = 1 SELECT @Continuar = ~@Existe ELSE SELECT @Continuar = @Existe
  RETURN
END
GO

/*

SET NOCOUNT ON
DECLARE @Ok int, @OkRef varchar(255), @Continuar bit
SELECT @Ok = NULL, @OkRef = NULL
EXEC spOpcionContinuar 'C', 'C4POAE1J45', @Continuar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
SELECT @Continuar, @Ok, @OkRef

*/

/**************** spOpcionHeredarRango ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOpcionHeredarRango') and type = 'P') drop procedure dbo.spOpcionHeredarRango
GO
CREATE PROCEDURE spOpcionHeredarRango
			@SiOpcion	varchar(100),
			@SubCuenta	varchar(50),
			@mSubCuenta	varchar(50)	OUTPUT,

   		   	@Ok             int          	OUTPUT,
    		   	@OkRef          varchar(255) 	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @r		int,
    @Letra1	char(1),
    @Rango1D	int,
    @Rango1A	int,
    @Letra2	char(1),
    @Rango2D	int,
    @Rango2A	int,
    @Numero	int

  SELECT @r = CHARINDEX(':', @SiOpcion)
  SELECT @Letra1 = SUBSTRING(@SiOpcion, 1, 1),
         @Rango1D = CONVERT(int, SUBSTRING(@SiOpcion, 2, @r-2)),
         @Rango1A = CONVERT(int, SUBSTRING(@SiOpcion, @r+1, LEN(@SiOpcion)))

  SELECT @r = CHARINDEX(':', @mSubCuenta)
  SELECT @Letra2 = SUBSTRING(@mSubCuenta, 1, 1),
         @Rango2D = CONVERT(int, SUBSTRING(@mSubCuenta, 2, @r-2)),
         @Rango2A = CONVERT(int, SUBSTRING(@mSubCuenta, @r+1, LEN(@mSubCuenta)))

  EXEC spOpcionExtraerNumero @SubCuenta, @Letra1, @Numero OUTPUT

  SELECT @mSubCuenta = RTRIM(@Letra2) + CONVERT(varchar, @Numero - @Rango1D + @Rango2D)
  IF @Rango1D-@Rango1A <> @Rango2D-@Rango2A SELECT @Ok = 20990, @OkRef = RTRIM(@SiOpcion) + ' ' + RTRIM(@mSubCuenta)
  RETURN
END
GO

/************** spDiasMes *************/
if exists (select * from sysobjects where id = object_id('dbo.spDiasMes') and type = 'P') drop procedure dbo.spDiasMes
GO
CREATE PROCEDURE spDiasMes
			@Mes	int,
			@Ano	int,
			@Dias	int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN

  SELECT @Dias = 0
  IF @Mes IN (1,3,5,7,8,10,12) 
    SELECT @Dias = 31  
  ELSE 
  IF @Mes IN (4,6,9,11)        
    SELECT @Dias = 30 
  ELSE
  IF @Mes = 2                  
  BEGIN 
    IF @Ano % 4 = 0 
      SELECT @Dias = 29 
    ELSE SELECT @Dias = 28 
  END

  RETURN 
END
GO

/************** spIntToDateTime *************/
if exists (select * from sysobjects where id = object_id('dbo.spIntToDateTime') and type = 'P') drop procedure dbo.spIntToDateTime
GO
CREATE PROCEDURE spIntToDateTime
			@Dia	int,
			@Mes	int,
			@Ano	int,
			@Fecha	datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Fecha = CONVERT(datetime, CONVERT(varchar, @Dia) + '/' + CONVERT(varchar, @Mes) + '/' + CONVERT(varchar, @Ano), 103)
  RETURN
END
GO
/*
declare
  @Fecha datetime

EXEC spISO8601ToDateTime 2004,4,1, 14, 53, 23, 1, @Fecha OUTPUT
SELECT convert(varchar, @Fecha, 126)
*/


/************** spPrimerDiaMes *************/
if exists (select * from sysobjects where id = object_id('dbo.spPrimerDiaMes') and type = 'P') drop procedure dbo.spPrimerDiaMes
GO
CREATE PROCEDURE spPrimerDiaMes
			@Fecha	datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dia	int

  SELECT @Dia = DATEPART(day, @Fecha)
  SELECT @Fecha = DATEADD(day, -@Dia+1, @Fecha)
  RETURN
END
GO

/************** spISO8601ToDateTime *************/
if exists (select * from sysobjects where id = object_id('dbo.spISO8601ToDateTime') and type = 'P') drop procedure dbo.spISO8601ToDateTime
GO
CREATE PROCEDURE spISO8601ToDateTime
			@Ano		int,
			@Mes		int,
			@Dia		int,
			@Hora		int,
			@Minuto		int,
			@Segundo	int,
			@ms		int,
			@Fecha		datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Fecha = CONVERT(datetime, CONVERT(varchar, @Ano) + '-' + RIGHT('0'+CONVERT(varchar, @Mes), 2) + '-' + RIGHT('0'+CONVERT(varchar, @Dia), 2) + 'T' + RIGHT('0'+CONVERT(varchar, @Hora), 2) + ':' + RIGHT('0'+CONVERT(varchar, @Minuto), 2) + ':' + RIGHT('0'+CONVERT(varchar, @Segundo), 2)+ '.' + RIGHT('00'+CONVERT(varchar, @ms), 3), 126)
  RETURN
END
GO


/************** spAMDToDateTime *************/
if exists (select * from sysobjects where id = object_id('dbo.spAMDToDateTime') and type = 'P') drop procedure dbo.spAMDToDateTime
GO
CREATE PROCEDURE spAMDToDateTime
			@AMD	char(8),
			@Fecha	datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @AMD = '00000000' SELECT @AMD = NULL
  SELECT @Fecha = CONVERT(datetime, RTRIM(SUBSTRING(@AMD, 1, 4)) + '/' + RTRIM(SUBSTRING(@AMD, 5, 2)) + '/' + RTRIM(SUBSTRING(@AMD, 7, 2)), 111)
  RETURN
END
GO

/*

DECLARE
  @Fecha datetime

EXEC spAMDToDateTime '20020324', @Fecha OUTPUT
SELECT @Fecha
*/

/************** spAMDHMSToDateTime *************/
if exists (select * from sysobjects where id = object_id('dbo.spAMDHMSToDateTime') and type = 'P') drop procedure dbo.spAMDHMSToDateTime
GO
CREATE PROCEDURE spAMDHMSToDateTime
			@AMD	char(8),
			@HMS 	char(6),
			@Fecha	datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @AMD = '00000000' SELECT @AMD = NULL
  SELECT @Fecha = CONVERT(datetime, RTRIM(SUBSTRING(@AMD, 1, 4)) + '/' + RTRIM(SUBSTRING(@AMD, 5, 2)) + '/' + RTRIM(SUBSTRING(@AMD, 7, 2)) + ' ' + RTRIM(SUBSTRING(@HMS, 1, 2)) + ':' + RTRIM(SUBSTRING(@HMS, 3, 2)) + ':' + RTRIM(SUBSTRING(@HMS, 5, 2)), 111)
  RETURN
END
GO

/*

DECLARE
  @Fecha datetime

EXEC spAMDHMSToDateTime '20020324', '123456', @Fecha OUTPUT
SELECT @Fecha
*/


/************** spMDAToDateTime *************/
if exists (select * from sysobjects where id = object_id('dbo.spMDAToDateTime') and type = 'P') drop procedure dbo.spMDAToDateTime
GO
CREATE PROCEDURE spMDAToDateTime
			@MDA	char(8),
			@Fecha	datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @MDA = '00000000' SELECT @MDA = NULL
  SELECT @Fecha = CONVERT(datetime, RTRIM(SUBSTRING(@MDA, 1, 2)) + '/' + RTRIM(SUBSTRING(@MDA, 3, 2)) + '/' + RTRIM(SUBSTRING(@MDA, 5, 4)), 101)
  RETURN
END
GO

/*
DECLARE
  @Fecha datetime

EXEC spMDAToDateTime '01312002', @Fecha OUTPUT
SELECT @Fecha
*/



/************** spDMAToDateTime *************/
if exists (select * from sysobjects where id = object_id('dbo.spDMAToDateTime') and type = 'P') drop procedure dbo.spDMAToDateTime
GO
CREATE PROCEDURE spDMAToDateTime
			@DMA	char(10),
			@Fecha	datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @DMA = REPLACE(@DMA,'/','')
  SELECT @DMA = REPLACE(@DMA,'-','')
  IF @DMA = '00000000' SELECT @DMA = NULL
  SELECT @Fecha = CONVERT(datetime, RTRIM(SUBSTRING(@DMA, 1, 2)) + '/' + RTRIM(SUBSTRING(@DMA, 3, 2)) + '/' + RTRIM(SUBSTRING(@DMA, 5, 4)), 103)
  RETURN
END
GO

/*
DECLARE
  @Fecha datetime

EXEC spDMAToDateTime '01122002', @Fecha OUTPUT
SELECT @Fecha
EXEC spDMAToDateTime '01/12/2002', @Fecha OUTPUT
SELECT @Fecha
EXEC spDMAToDateTime '01-12-2002', @Fecha OUTPUT
SELECT @Fecha
*/

/************** spDMAHMSToDateTime *************/
if exists (select * from sysobjects where id = object_id('dbo.spDMAHMSToDateTime') and type = 'P') drop procedure dbo.spDMAHMSToDateTime
GO
CREATE PROCEDURE spDMAHMSToDateTime
			@DMA	char(8),
			@HMS    char(6),
			@Fecha	datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @DMA = '00000000' SELECT @DMA = NULL
  SELECT @Fecha = CONVERT(datetime, RTRIM(SUBSTRING(@DMA, 1, 2)) + '/' + RTRIM(SUBSTRING(@DMA, 3, 2)) + '/' + RTRIM(SUBSTRING(@DMA, 5, 4)) + ' ' + RTRIM(SUBSTRING(@HMS, 1, 2)) + ':' + RTRIM(SUBSTRING(@HMS, 3, 2)) + ':' + RTRIM(SUBSTRING(@HMS, 5, 2)), 103)
  RETURN
END
GO

/*
DECLARE
  @Fecha datetime

EXEC spDMAHMSToDateTime '01122002', '123456', @Fecha OUTPUT
SELECT @Fecha
*/


/************** spDateTimeToDMA *************/
if exists (select * from sysobjects where id = object_id('dbo.spDateTimeToDMA') and type = 'P') drop procedure dbo.spDateTimeToDMA
GO
CREATE PROCEDURE spDateTimeToDMA
			@Fecha	datetime,
			@DMA	char(8)	 OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dia	int,
    @Mes	int,
    @Ano	int,
    @A 		char(4),
    @M		char(2),
    @D 		char(2)

  SELECT @Dia = DAY(@Fecha),
         @Mes = MONTH(@Fecha),
         @Ano = YEAR(@Fecha)

  EXEC spLlenarCeros @Dia, 2, @D OUTPUT
  EXEC spLlenarCeros @Mes, 2, @M OUTPUT
  EXEC spLlenarCeros @Ano, 4, @A OUTPUT

  SELECT @DMA = @D+@M+@A
  RETURN
END
GO


/*
DECLARE
  @Fecha	datetime,
  @DMA 		char(8)

SELECT @Fecha = GETDATE()
EXEC spDateTimeToDMA @Fecha, @DMA OUTPUT
SELECT '*'+@DMA+'*'
*/



/************** spMinutosToHoras *************/
if exists (select * from sysobjects where id = object_id('dbo.spMinutosToHoras') and type = 'P') drop procedure dbo.spMinutosToHoras
GO
CREATE PROCEDURE spMinutosToHoras
			@Minutos	int,
			@HM		char(5) OUTPUT,
			@EnSilencio	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Horas	int,
    @H		char(2), 
    @M 		char(2)

  SELECT @Horas = NULL, @HM = NULL
  IF ISNULL(@Minutos, 0) <> 0
  BEGIN
    SELECT @Horas = @Minutos / 60
    SELECT @Minutos = @Minutos - (@Horas * 60)
    EXEC spLlenarCeros @Horas, 2, @H OUTPUT
    EXEC spLlenarCeros @Minutos, 2, @M OUTPUT
    SELECT @HM = @H+':'+@M
  END
  IF @EnSilencio = 0 SELECT @HM
  RETURN
END
GO

/************** spHorasToCantidad *************/
if exists (select * from sysobjects where id = object_id('dbo.spHorasToCantidad') and type = 'P') drop procedure dbo.spHorasToCantidad
GO
CREATE PROCEDURE spHorasToCantidad
			@Horas		varchar(5),
			@Cantidad	float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @H	int, 
    @M 	int

  SELECT @Cantidad = 0.0
  IF @Horas IS NOT NULL
  BEGIN
    SELECT @H = CONVERT(int, SUBSTRING(@Horas, 1, 2)),
           @M = CONVERT(int, SUBSTRING(@Horas, 4, 2))
    SELECT @Cantidad = @H + @M / 60.0
  END
  RETURN
END
GO

/*
DECLARE
  @Cantidad float
EXEC spHorasToCantidad '01:15', @Cantidad OUTPUT
SELECT @Cantidad
*/


/************** spCantidadToHoras *************/
if exists (select * from sysobjects where id = object_id('dbo.spCantidadToHoras') and type = 'P') drop procedure dbo.spCantidadToHoras
GO
CREATE PROCEDURE spCantidadToHoras
			@Cantidad	float,
			@Horas		varchar(5)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Minutos	float

  SELECT @Minutos = @Cantidad * 60
  EXEC spMinutosToHoras @Minutos, @Horas OUTPUT, 1
  RETURN
END
GO


/*
DECLARE
  @Horas varchar(5)
EXEC spCantidadToHoras 1.25, @Horas OUTPUT
SELECT @Horas
*/

/************** spDifHoras *************/
if exists (select * from sysobjects where id = object_id('dbo.spDifHoras') and type = 'P') drop procedure dbo.spDifHoras
GO
CREATE PROCEDURE spDifHoras
			@Hora1		varchar(5),
			@Hora2		varchar(5),
			@Diferencia	float	OUTPUT,
			@EnMinutos	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @Hora1Cantidad	float,
     @Hora2Cantidad	float
  
  EXEC spHorasToCantidad @Hora1, @Hora1Cantidad OUTPUT
  EXEC spHorasToCantidad @Hora2, @Hora2Cantidad OUTPUT

  SELECT @Diferencia = @Hora2Cantidad - @Hora1Cantidad
  IF @EnMinutos = 1 SELECT @Diferencia = ROUND(@Diferencia * 60.0, 4)
  RETURN
END
GO

/*
DECLARE
  @Dif	float
EXEC spDifHoras '09:00', '09:10', @Dif OUTPUT, @EnMinutos = 1
SELECT @Dif
*/


/*
DECLARE
  @FechaD datetime,
  @FechaA datetime,
  @Dias	  int
EXEC spPeriodoDA 'SEMANAL', '1/12/3', @FechaD OUTPUT, @FechaA OUTPUT
        SELECT @Dias = DATEDIFF(day, @FechaD, @FechaA)
select @FechaD, @FechaA, @Dias

*/

/**************** spPeriodoDAOtro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPeriodoDAOtro') and type = 'P') drop procedure dbo.spPeriodoDAOtro
GO             
CREATE PROCEDURE spPeriodoDAOtro
			@PeriodoTipo	varchar(50),
			@Fecha		datetime,
			@FechaD		datetime	OUTPUT,
			@FechaA		datetime	OUTPUT,
			@Empresa	varchar(5)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  -- Aqui van los otrs periodos estandar
  DECLARE
    @DiasPeriodo	float

  IF (SELECT Pais FROM Empresa WHERE Empresa = @Empresa) = 'Venezuela'
  BEGIN
    SELECT @DiasPeriodo = DiasPeriodo FROM PeriodoTipo WHERE PeriodoTipo = @PeriodoTipo
    SELECT @FechaD = @Fecha
    SELECT @FechaA = DATEADD(DAY, @DiasPeriodo - 1, @Fecha)
  END
  
  EXEC xpPeriodoDAOtro @PeriodoTipo, @Fecha, @FechaD OUTPUT, @FechaA OUTPUT, @Empresa
  RETURN
END
GO

/**************** spVerPeriodoDAOtro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerPeriodoDAOtro') and type = 'P') drop procedure dbo.spVerPeriodoDAOtro
GO             
CREATE PROCEDURE spVerPeriodoDAOtro
			@PeriodoTipo	varchar(50),
			@Fecha		datetime,
			@Empresa	varchar(5)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaD datetime,
    @FechaA datetime
  	
  EXEC spPeriodoDAOtro @PeriodoTipo, @Fecha, @FechaD OUTPUT, @FechaA OUTPUT, @Empresa
  SELECT 'FechaD' = @FechaD, 'FechaA' = @FechaA
  RETURN
END
GO

/**************** spPeriodoDA ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPeriodoDA') and type = 'P') drop procedure dbo.spPeriodoDA
GO             
CREATE PROCEDURE spPeriodoDA
			@PeriodoTipo	varchar(50),
			@Fecha		datetime,
			@FechaD		datetime	OUTPUT,
			@FechaA		datetime	OUTPUT,
			@Empresa	varchar(5)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dia		int,
    @Mes		int,
    @Ano		int,
    @Dias		int,
    @UltimoDiaPagado	datetime

  SELECT @FechaD = NULL, 
         @FechaA = NULL,
         @PeriodoTipo = UPPER(NULLIF(RTRIM(@PeriodoTipo), ''))

  IF @Fecha IS NULL OR @PeriodoTipo IS NULL RETURN
  -- No se incremente FechaD porque esta rutina NO supone el ultimo dia paga
  SELECT @FechaD = @Fecha
  IF @PeriodoTipo = 'SEMANAL'  
  BEGIN
    SELECT @Dias=7
    SELECT @FechaA = DATEADD(day, @Dias, @Fecha) 
    SELECT @UltimoDiaPagado = ISNULL(UltimoDiaPagado, @FechaD) 
       FROM PeriodoTipo  
    WHERE PeriodoTipo=@PeriodoTipo
    SELECT @UltimoDiaPagado=DATEADD(day, @Dias+1, @UltimoDiaPagado)
    IF @FechaA>@UltimoDiaPagado AND @FechaD<@UltimoDiaPagado  
    BEGIN
      SELECT @FechaA=@UltimoDiaPagado
      SELECT @Dias=DATEDIFF(day,@FechaA,@Fecha)
    END
  END ELSE
  IF @PeriodoTipo = 'CATORCENAL' SELECT @FechaA = DATEADD(day, 14, @Fecha) ELSE
  IF @PeriodoTipo = 'ANUAL'      SELECT @FechaA = DATEADD(year, 1, @Fecha) 
  ELSE 
  BEGIN
    SELECT @Dia = DATEPART(day, @Fecha),
           @Mes = DATEPART(month, @Fecha),
           @Ano = DATEPART(year, @Fecha)

    EXEC spDiasMes @Mes, @Ano, @Dias OUTPUT

    IF @PeriodoTipo = 'MENSUAL' 
    BEGIN
      IF @Dia = 1 
        EXEC spIntToDateTime @Dias, @Mes, @Ano, @FechaA OUTPUT
      ELSE SELECT @FechaA = DATEADD(month, 1, @Fecha)
    END
    IF @PeriodoTipo IN ('DECENAL', 'QUINCENAL', 'QUINCENAL 5-20')
    BEGIN
      IF @PeriodoTipo = 'DECENAL'   
      BEGIN 
        IF @Dia BETWEEN  1 AND 10 SELECT @Dia = 1  ELSE 
        IF @Dia BETWEEN 11 AND 20 SELECT @Dia = 11 
        ELSE SELECT @Dia = 21 
      END ELSE
      IF @PeriodoTipo = 'QUINCENAL' 
      BEGIN 
        IF @Dia BETWEEN 1 AND 15 SELECT @Dia = 1 
        ELSE SELECT @Dia = 16 
      END
      IF @PeriodoTipo = 'QUINCENAL 5-20' 
      BEGIN 
        IF @Dia BETWEEN 1 AND 4
        BEGIN
          IF @Mes > 1 SELECT @Mes = @Mes - 1 ELSE SELECT @Mes = 12, @Ano = @Ano - 1
          SELECT @Dia = 20
        END ELSE
        IF @Dia BETWEEN 5 AND 19 SELECT @Dia = 5 
        ELSE SELECT @Dia = 20 
      END

      EXEC spIntToDateTime @Dia, @Mes, @Ano, @FechaD OUTPUT
      IF @PeriodoTipo = 'DECENAL'
      BEGIN
        IF @Dia = 1  SELECT @Dia = 10 ELSE
        IF @Dia = 11 SELECT @Dia = 20 ELSE
        IF @Dia = 21 SELECT @Dia = @Dias
      END
      IF @PeriodoTipo = 'QUINCENAL'
      BEGIN
        IF @Dia = 1  SELECT @Dia = 15 ELSE
        IF @Dia = 16 SELECT @Dia = @Dias
      END
      IF @PeriodoTipo = 'QUINCENAL 5-20' 
      BEGIN 
        IF @Dia = 5  SELECT @Dia = 20 
        ELSE BEGIN
          SELECT @Dia = 5
          IF @Mes < 12 SELECT @Mes = @Mes + 1 ELSE SELECT @Mes = 1, @Ano = @Ano + 1
        END
      END
      EXEC spIntToDateTime @Dia, @Mes, @Ano, @FechaA OUTPUT
    END    
  END
  IF @PeriodoTipo NOT IN ('SEMANAL','MENSUAL','CATORCENAL','ANUAL','DECENAL', 'QUINCENAL', 'QUINCENAL 5-20')
    EXEC spPeriodoDAOtro @PeriodoTipo, @Fecha, @FechaD OUTPUT, @FechaA OUTPUT, @Empresa
  RETURN
END
GO

/*
declare
  @fechad datetime,
  @fechaa datetime
exec spPeriodoDA 'SEMANAL', '2/7/2', @fechad output, @fechaa output
select @fechad, @fechaa

*/

/**************** spZonaImp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spZonaImp') and type = 'P') drop procedure dbo.spZonaImp
GO             
CREATE PROCEDURE spZonaImp 
		  	@Zona 	  varchar(30),
			@Impuesto float 	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF NULLIF(RTRIM(@Zona), '') IS NOT NULL AND @Impuesto IS NOT NULL
    IF EXISTS(SELECT * FROM ZonaImp WHERE Zona = @Zona AND Impuesto = @Impuesto)
      SELECT @Impuesto = Porcentaje FROM ZonaImp WHERE Zona = @Zona AND Impuesto = @Impuesto
  RETURN
END
GO

/**************** spVerZonaImp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerZonaImp') and type = 'P') drop procedure dbo.spVerZonaImp
GO             
CREATE PROCEDURE spVerZonaImp
		  	@Zona 	  varchar(30),
			@Impuesto float
--//WITH ENCRYPTION
AS BEGIN
  EXEC spZonaImp @Zona, @Impuesto OUTPUT
  SELECT "Impuesto" = @Impuesto
  RETURN
END
GO


/**************** spIncEjercicioPeriodo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncEjercicioPeriodo') and type = 'P') drop procedure dbo.spIncEjercicioPeriodo
GO             
CREATE PROCEDURE spIncEjercicioPeriodo
			@Ejercicio	int	OUTPUT,
			@Periodo	int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Periodo = @Periodo + 1
  IF @Periodo > 12 SELECT @Ejercicio = @Ejercicio + 1, @Periodo = 1
END
GO

/**************** spDecEjercicioPeriodo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDecEjercicioPeriodo') and type = 'P') drop procedure dbo.spDecEjercicioPeriodo
GO             
CREATE PROCEDURE spDecEjercicioPeriodo
			@Ejercicio	int	OUTPUT,
			@Periodo	int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Periodo = @Periodo - 1
  IF @Periodo < 1 SELECT @Ejercicio = @Ejercicio - 1, @Periodo = 1
END
GO

/**************** spAgregarHora ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAgregarHora') and type = 'P') drop procedure dbo.spAgregarHora
GO             
CREATE PROCEDURE spAgregarHora 
			@Hora 	char(5), 
			@Fecha	datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @m	int,
    @h	int

  EXEC spExtraerFecha @Fecha OUTPUT
  SELECT @h = CONVERT(int, SUBSTRING(@Hora, 1, 2)),
         @m = CONVERT(int, SUBSTRING(@Hora, 4, 2))

  SELECT @Fecha = DATEADD(mi, @m, @Fecha)
  SELECT @Fecha = DATEADD(hh, @h, @Fecha)
  RETURN
END
GO

/**************** spMismoDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMismoDia') and type = 'P') drop procedure dbo.spMismoDia
GO             
CREATE PROCEDURE spMismoDia 
			@Fecha1 	datetime,
			@Fecha2		datetime,
			@MismoDia	bit	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  EXEC spExtraerFecha @Fecha1 OUTPUT
  EXEC spExtraerFecha @Fecha2 OUTPUT
  IF @Fecha1 = @Fecha2 SELECT @MismoDia = 1 ELSE SELECT @MismoDia = 0
  RETURN
END
GO

/**************** spRedondearFecha ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRedondearFecha') and type = 'P') drop procedure dbo.spRedondearFecha
GO             
CREATE PROCEDURE spRedondearFecha
			@Fecha 		datetime,	
			@FechaSinHora 	datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @FechaSinHora = @Fecha
  EXEC spExtraerFecha @FechaSinHora OUTPUT
  IF DATEDIFF (ss, @Fecha, @FechaSinHora) > 0
    SELECT @Fecha = DATEADD(day, 1, @FechaSinHora)
  ELSE SELECT @Fecha = @FechaSinHora
  RETURN
END
GO


-- select dbo.fnRenglonTipo('SERIE')
/**************** spRenglonTipo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRenglonTipo') and type = 'P') drop procedure dbo.spRenglonTipo
GO             
CREATE PROCEDURE spRenglonTipo
                    @ArtTipo		varchar(20),
                    @SubCuenta		varchar(50),
		    @RenglonTipo	char(1) 	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  -- 'C' y 'E' Componente de un Juego
  -- No poner 'C' ni 'N'
  SELECT @ArtTipo = NULLIF(RTRIM(UPPER(@ArtTipo)), ''), @RenglonTipo = 'N'
  IF @ArtTipo = 'SERIE'       SELECT @RenglonTipo = 'S' ELSE
  IF @ArtTipo = 'LOTE'        SELECT @RenglonTipo = 'L' ELSE
  IF @ArtTipo = 'VIN'         SELECT @RenglonTipo = 'V' ELSE
  IF @ArtTipo = 'JUEGO'	      SELECT @RenglonTipo = 'J' /*ELSE
  IF @ArtTipo = 'MATRIZ'      SELECT @RenglonTipo = 'M' ELSE
  IF @ArtTipo = 'PARTIDA'     SELECT @RenglonTipo = 'A' ELSE
  IF @ArtTipo = 'DOBLE UNIDAD' 
    IF UPPER(@SubCuenta) = 'PIEZAS' SELECT @RenglonTipo = 'P' 
    ELSE SELECT @RenglonTipo = 'U' 
*/
  RETURN
END
GO

/**************** spArtTipo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtTipo') and type = 'P') drop procedure dbo.spArtTipo
GO             
CREATE PROCEDURE spArtTipo
		    @RenglonTipo	char(1),	
                    @ArtTipo		varchar(20)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  SELECT @RenglonTipo = UPPER(@RenglonTipo), @ArtTipo = 'NORMAL'

  IF @RenglonTipo = 'S' SELECT @ArtTipo = 'SERIE'   ELSE
  IF @RenglonTipo = 'L' SELECT @ArtTipo = 'LOTE'    ELSE
  IF @RenglonTipo = 'V' SELECT @ArtTipo = 'VIN'     ELSE
  IF @RenglonTipo = 'J' SELECT @ArtTipo = 'JUEGO'   /*ELSE
  IF @RenglonTipo = 'M' SELECT @ArtTipo = 'MATRIZ'  ELSE
  IF @RenglonTipo = 'A' SELECT @ArtTipo = 'PARTIDA' ELSE
  IF @RenglonTipo IN ('P', 'U') SELECT @ArtTipo = 'DOBLE UNIDAD'
*/
  RETURN
END
GO

/**************** spRecorrerVencimiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRecorrerVencimiento') and type = 'P') drop procedure dbo.spRecorrerVencimiento
GO             
CREATE PROCEDURE spRecorrerVencimiento
                    @DiaSemana		varchar(20),
                    @Vencimiento	datetime	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SET DATEFIRST 7  
  DECLARE
    @Dia		int,
    @DiaEspecifico	int,
    @DiasMes		int,
    @Mes		int,
    @Ano		int,
    @DiaVence		int

  SELECT @Dia = 0
  SELECT @DiaSemana = RTRIM(UPPER(@DiaSemana))

  IF @DiaSemana = '(ESPECIAL)'
    EXEC xpRecorrerVencimiento @Vencimiento OUTPUT
  ELSE
  IF @DiaSemana IN ('QUINCENA', 'FIN DE MES') OR dbo.fnEsNumerico(@DiaSemana) = 1
  BEGIN
    SELECT @Ano = YEAR(@Vencimiento),
           @Mes = MONTH(@Vencimiento),
           @Dia = DAY(@Vencimiento)
    EXEC spDiasMes @Mes, @Ano, @DiasMes OUTPUT
    IF dbo.fnEsNumerico(@DiaSemana) = 1
    BEGIN
      SELECT @DiaEspecifico = CONVERT(int, @DiaSemana)
      IF @Dia > @DiaEspecifico 
      BEGIN
        SELECT @Mes = @Mes + 1
        IF @Mes > 12 SELECT @Mes = 1, @Ano = @Ano + 1        
      END 
      SELECT @Dia = @DiaEspecifico
      IF @Dia > @DiasMes SELECT @Dia = @DiasMes
    END ELSE
    BEGIN
      IF @DiaSemana = 'QUINCENA' AND @Dia <= 15 
        SELECT @Dia = 15 
      ELSE SELECT @Dia = @DiasMes
    END
    EXEC spIntToDateTime @Dia, @Mes, @Ano, @Vencimiento OUTPUT     
  END ELSE
  BEGIN
    IF @DiaSemana = 'DOMINGO'   SELECT @Dia = 1 ELSE
    IF @DiaSemana = 'LUNES'     SELECT @Dia = 2 ELSE
    IF @DiaSemana = 'MARTES'    SELECT @Dia = 3 ELSE
    IF @DiaSemana = 'MIERCOLES' SELECT @Dia = 4 ELSE
    IF @DiaSemana = 'JUEVES'    SELECT @Dia = 5 ELSE
    IF @DiaSemana = 'VIERNES'   SELECT @Dia = 6 ELSE
    IF @DiaSemana = 'SABADO'    SELECT @Dia = 7 
    ELSE RETURN
 
    SELECT @DiaVence = DATEPART(weekday, @Vencimiento)
    IF @Dia > 0 AND @Dia <> @DiaVence
    BEGIN
      IF @DiaVence < @Dia 
        SELECT @Vencimiento = DATEADD(day, @Dia - @DiaVence, @Vencimiento)
      ELSE
        SELECT @Vencimiento = DATEADD(day, 7 - @DiaVence + @Dia, @Vencimiento)     
    END
  END
  RETURN
END
GO

/**************** spVerificarVencimiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerificarVencimiento') and type = 'P') drop procedure dbo.spVerificarVencimiento
GO             
CREATE PROCEDURE spVerificarVencimiento
                    @Condicion		varchar(50),
                    @Vencimiento	datetime,
		    @FechaEmision	datetime,
                    @Ok 		int		OUTPUT 
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  IF UPPER(@Condicion) = '(FECHA)'
  BEGIN
    EXEC spExtraerFecha @Vencimiento OUTPUT
    EXEC spExtraerFecha @FechaEmision OUTPUT
    IF (@Vencimiento IS NULL) OR (@Vencimiento < @FechaEmision) SELECT @Ok = 30020
  END
  RETURN
END
GO
/*
DECLARE
  @FechaFinal	datetime
EXEC spCalcularDiasHabiles '5/4/6 10:00', 1, 'LUN-VIE', 1, @FechaFinal OUTPUT
SELECT @FechaFinal
*/

/**************** spCalcularDiasHabiles ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcularDiasHabiles') and type = 'P') drop procedure dbo.spCalcularDiasHabiles
GO             
CREATE PROCEDURE spCalcularDiasHabiles
                    @FechaActual	datetime,
		    @Dias		int,
    		    @DiasHabiles 	char(10),
		    @Todos		bit,
		    @FechaFinal		datetime	OUTPUT,
		    @ProyectoID		int	= NULL,
			@Jornada		varchar(20) = NULL

--//WITH ENCRYPTION
AS BEGIN
  SET DATEFIRST 7  
-- SET nocount ON
  DECLARE 
    @DiasAgregados	int,
    @DiaSemana		int,
    @Inc		int,
    @Control	bit


  IF @Jornada IS NOT NULL AND EXISTS(SELECT * FROM Jornada WHERE Jornada = @Jornada AND UPPER(Tipo) = 'CONTROL ASISTENCIA')
    SELECT @Control = 1

  IF @Dias < 0 SELECT @Inc = -1 ELSE SELECT @Inc = 1
  EXEC spExtraerFecha @FechaActual OUTPUT 
  SELECT @DiasAgregados = 0
  SELECT @FechaFinal = @FechaActual

  WHILE ABS(@DiasAgregados) < ABS(@Dias)
  BEGIN
    SELECT @FechaFinal = DATEADD(day, @Inc, @FechaFinal)

    IF @Control = 1
    BEGIN
      IF @FechaFinal IN (SELECT DISTINCT Fecha FROM JornadaTiempo WHERE Jornada = @Jornada)
          SELECT @DiasAgregados = @DiasAgregados + @Inc
        ELSE
          SELECT @DiasAgregados = @DiasAgregados
    END ELSE
    BEGIN
      IF @ProyectoID IS NOT NULL
      BEGIN
        IF NOT EXISTS(SELECT * FROM ProyectoInhabil WHERE ID = @ProyectoID AND Fecha = @FechaFinal)
          SELECT @DiasAgregados = @DiasAgregados + @Inc
      END ELSE 
      BEGIN
        SELECT @DiaSemana = DATEPART(weekday, @FechaFinal)
        IF @Todos = 1
        BEGIN
          IF (@DiasHabiles <> 'TODOS' AND @DiaSemana = 1) OR 
             (@DiasHabiles = 'LUN-VIE' AND @DiaSemana = 7) OR 
             (@FechaFinal IN (SELECT Fecha FROM DiaFestivo))
            SELECT @DiasAgregados = @DiasAgregados
          ELSE
            SELECT @DiasAgregados = @DiasAgregados + @Inc
        END ELSE
        BEGIN
          IF (@DiasHabiles <> 'TODOS' AND @DiaSemana = 1) OR 
             (@DiasHabiles = 'LUN-VIE' AND @DiaSemana = 7) OR 
             (@FechaFinal IN (SELECT Fecha FROM DiaFestivo WHERE EsLaborable = 0))
            SELECT @DiasAgregados = @DiasAgregados
          ELSE
            SELECT @DiasAgregados = @DiasAgregados + @Inc
        END
      END
    END
  END

  RETURN
END
GO

/*
DECLARE
  @Dias		int
  EXEC spDiasNoHabiles '1/12/3', '1/19/3', 'LUN-VIE', 0, 'Horario Completo', @Dias OUTPUT
SELECT @Dias
*/

/**************** spDiasNoHabiles ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDiasNoHabiles') and type = 'P') drop procedure dbo.spDiasNoHabiles
GO             
CREATE PROCEDURE spDiasNoHabiles
                    @FechaD		datetime,
                    @FechaA		datetime,
    		    @DiasHabiles 	char(10),
		    @Todos		bit,
		    @Jornada		varchar(20),
		    @Dias		int	      OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  SET DATEFIRST 7  
  DECLARE 
    @Fecha	datetime,
    @DiaSemana	int,
    @Control	bit

  SELECT @Dias = 0, @Fecha = @FechaD, @Control = 0
  IF @Jornada IS NOT NULL AND EXISTS(SELECT * FROM Jornada WHERE Jornada = @Jornada AND UPPER(Tipo) = 'CONTROL ASISTENCIA')
    SELECT @Control = 1

  WHILE @Fecha < @FechaA
  BEGIN
    SELECT @DiaSemana = DATEPART(weekday, @Fecha)
    IF @Control = 1
    BEGIN
      IF @Fecha NOT IN (SELECT DISTINCT Fecha FROM JornadaTiempo WHERE Jornada = @Jornada)
        SELECT @Dias = @Dias + 1
    END ELSE
    BEGIN
      IF @Todos = 1
      BEGIN
        IF (@DiasHabiles <> 'TODOS' AND @DiaSemana = 1) OR 
           (@DiasHabiles = 'LUN-VIE' AND @DiaSemana = 7) OR 
           (@Fecha IN (SELECT Fecha FROM DiaFestivo))
          SELECT @Dias = @Dias + 1
      END ELSE
      BEGIN
        IF (@DiasHabiles <> 'TODOS' AND @DiaSemana = 1) OR 
           (@DiasHabiles = 'LUN-VIE' AND @DiaSemana = 7) OR 
           (@Fecha IN (SELECT Fecha FROM DiaFestivo WHERE EsLaborable = 0))
          SELECT @Dias = @Dias + 1
      END
    END
    
    SELECT @Fecha = DATEADD(day, 1, @Fecha)
  END

  RETURN
END
GO

/**************** spRecorrerDiaHabil ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRecorrerDiaHabil') and type = 'P') drop procedure dbo.spRecorrerDiaHabil
GO             
CREATE PROCEDURE spRecorrerDiaHabil
    		    @DiasHabiles 	char(10),
		    @Todos		bit,
		    @Fecha		datetime	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  SELECT @Fecha = DATEADD(day, -1, @Fecha)
  EXEC spCalcularDiasHabiles @Fecha, 1, @DiasHabiles, @Todos, @Fecha OUTPUT
  RETURN
END
GO

/*
DECLARE
  @Fecha	datetime
SELECT @Fecha = '9/6/4'
EXEC spRetrocederDiaHabil 'LUN-VIE', 0, @Fecha OUTPUT
SELECT @Fecha
*/
/**************** spRetrocederDiaHabil ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRetrocederDiaHabil') and type = 'P') drop procedure dbo.spRetrocederDiaHabil
GO             
CREATE PROCEDURE spRetrocederDiaHabil
    		    @DiasHabiles 	char(10),
		    @Todos		bit,
		    @Fecha		datetime	OUTPUT,
		    @ProyectoID		int	= NULL 	

--//WITH ENCRYPTION
AS BEGIN
  SELECT @Fecha = DATEADD(day, 1, @Fecha)
  EXEC spCalcularDiasHabiles @Fecha, -1, @DiasHabiles, @Todos, @Fecha OUTPUT, @ProyectoID = @ProyectoID
  RETURN
END
GO

/**************** spIncTiempoUnidad ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncTiempoUnidad') and type = 'P') drop procedure dbo.spIncTiempoUnidad
GO             
CREATE PROCEDURE spIncTiempoUnidad
			@Fecha		datetime	OUTPUT,
			@Tiempo		float,
			@Unidad		varchar(50),
			@HorasDia	float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Entero		float,
    @Faccion		float

  SELECT @Entero = FLOOR(@Tiempo)
  SELECT @Faccion = @Tiempo - @Entero

  IF @Unidad = 'MS'       SELECT @Fecha = DATEADD(millisecond, 	@Entero, @Fecha) ELSE
  IF @Unidad = 'SEGUNDOS' SELECT @Fecha = DATEADD(second, 	@Entero, @Fecha) ELSE
  IF @Unidad = 'MINUTOS'  SELECT @Fecha = DATEADD(minute, 	@Entero, @Fecha) ELSE
  IF @Unidad = 'HORAS'    SELECT @Fecha = DATEADD(hour,   	@Entero, @Fecha) ELSE
  IF @Unidad = 'DIAS'     SELECT @Fecha = DATEADD(day,    	@Entero, @Fecha) ELSE
  IF @Unidad = 'SEMANAS'  SELECT @Fecha = DATEADD(week,   	@Entero, @Fecha) ELSE
  IF @Unidad = 'MESES'    SELECT @Fecha = DATEADD(month,  	@Entero, @Fecha) ELSE
  IF @Unidad = 'AÑOS'     SELECT @Fecha = DATEADD(year,   	@Entero, @Fecha) 

  IF @Faccion <> 0.0
  BEGIN
    IF @Unidad = 'SEGUNDOS' SELECT @Unidad = 'MS',       @Entero = 1000 * @Faccion ELSE
    IF @Unidad = 'MINUTOS'  SELECT @Unidad = 'SEGUNDOS', @Entero = 60 * @Faccion ELSE
    IF @Unidad = 'HORAS'    SELECT @Unidad = 'MINUTOS',  @Entero = 60 * @Faccion ELSE
    IF @Unidad = 'DIAS'     SELECT @Unidad = 'HORAS',    @Entero = @HorasDia * @Faccion ELSE
    IF @Unidad = 'SEMANAS'  SELECT @Unidad = 'DIAS',     @Entero = ROUND(7 * @Faccion, 0) ELSE
    IF @Unidad = 'MESES'    SELECT @Unidad = 'DIAS',     @Entero = ROUND(30.4 * @Faccion, 0) ELSE
    IF @Unidad = 'AÑOS'     SELECT @Unidad = 'MESES',    @Entero = 12 * @Faccion 
    ELSE SELECT @Unidad = NULL

    IF @Unidad IS NOT NULL
      EXEC spIncTiempoUnidad @Fecha OUTPUT, @Entero, @Unidad, @HorasDia
  END
  RETURN
END
GO

/**************** spIncTiempo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncTiempo') and type = 'P') drop procedure dbo.spIncTiempo
GO             
CREATE PROCEDURE spIncTiempo
			@Fecha	 		datetime,
		  	@Tiempo  		float,
			@Unidad	 		char(10),
			@Resultado 		datetime	OUTPUT,
			@Empresa		char(5) 	= NULL,
			@RecorrerDiaHabil	bit		= 0,
			@Todos			bit		= 0,
			@ProyectoID 		int		= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasHabiles 	char(20),
    @HorasDia		float

  SELECT @Resultado = @Fecha
  IF @Tiempo IS NOT NULL 
  BEGIN
    IF @ProyectoID IS NOT NULL
      SELECT @DiasHabiles = DiasHabiles, @HorasDia = HorasDia FROM Proyecto WHERE ID = @ProyectoID
    ELSE
      IF @Empresa IS NOT NULL
        SELECT @DiasHabiles = DiasHabiles, @HorasDia = HorasDia FROM EmpresaGral WHERE Empresa = @Empresa

    SELECT @Unidad = ISNULL(UPPER(@Unidad), 'DIAS') 
    EXEC spIncTiempoUnidad @Resultado OUTPUT, @Tiempo, @Unidad, @HorasDia
    IF @RecorrerDiaHabil = 1
      EXEC spRetrocederDiaHabil @DiasHabiles, @Todos, @Resultado, @ProyectoID = @ProyectoID
  END
  RETURN
END
GO

/**************** spDecTiempo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDecTiempo') and type = 'P') drop procedure dbo.spDecTiempo
GO             
CREATE PROCEDURE spDecTiempo
			@Fecha	 		datetime,
		  	@Tiempo  		float,
			@Unidad	 		char(10),
			@Resultado 		datetime	OUTPUT,
			@Empresa		char(5) 	= NULL,
			@RecorrerDiaHabil	bit		= 0,
			@Todos			bit		= 0
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Resultado = @Fecha
  IF @Tiempo IS NOT NULL 
  BEGIN
    SELECT @Tiempo = -@Tiempo
    EXEC spIncTiempo @Fecha, @Tiempo, @Unidad, @Resultado OUTPUT, @Empresa, @RecorrerDiaHabil, @Todos
  END
  RETURN
END
GO

-- spVerIncTiempo '1/1/6', 1.5, 'Dias', 'DEMO', 0

/**************** spVerIncTiempo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerIncTiempo') and type = 'P') drop procedure dbo.spVerIncTiempo
GO             
CREATE PROCEDURE spVerIncTiempo
			@Fecha	 		datetime,
		  	@Tiempo  		float,
			@Unidad	 		char(10),
			@Empresa		char(5) 	= NULL,
			@RecorrerDiaHabil	bit		= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	datetime
  EXEC spIncTiempo @Fecha, @Tiempo, @Unidad, @Resultado OUTPUT, @Empresa, @RecorrerDiaHabil
  SELECT "Resultado" = @Resultado
END
GO


/**************** spTiempoEnDias ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTiempoEnDias') and type = 'P') drop procedure dbo.spTiempoEnDias
GO             
CREATE PROCEDURE spTiempoEnDias
			@Empresa	char(5),
		  	@Tiempo 	float,
			@Unidad		char(10),
			@Dias		float	OUTPUT,
			@ProyectoID	int	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaFloat		float,
    @HorasDia		float

  SELECT @Dias = 0.0, @Unidad = UPPER(@Unidad)
  IF @ProyectoID IS NOT NULL
    SELECT @HorasDia = HorasDia FROM Proyecto WHERE ID = @ProyectoID
  ELSE
    SELECT @HorasDia = HorasDia FROM EmpresaGral WHERE Empresa = @Empresa
  IF @Unidad = 'SEGUNDOS' SELECT @Dias = (@Tiempo / @HorasDia / 60 / 60) ELSE
  IF @Unidad = 'MINUTOS'  SELECT @Dias = (@Tiempo / @HorasDia / 60) ELSE
  IF @Unidad = 'HORAS'    SELECT @Dias = (@Tiempo / @HorasDia) ELSE
  IF @Unidad = 'DIAS'     SELECT @Dias = @Tiempo        ELSE
  IF @Unidad = 'SEMANAS'  SELECT @Dias = @Tiempo * 7    ELSE
  IF @Unidad = 'MESES'    SELECT @Dias = ROUND(@Tiempo * 30.4, 0) ELSE
  IF @Unidad = 'AÑOS'     SELECT @Dias = ROUND(@Tiempo * 365, 0)

  RETURN
END
GO

-- spVerTiempoEnDias 'DEMO', 2, 'Años'
/**************** spVerTiempoEnDias ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerTiempoEnDias') and type = 'P') drop procedure dbo.spVerTiempoEnDias
GO             
CREATE PROCEDURE spVerTiempoEnDias
			@Empresa	char(5),
		  	@Tiempo 	float,
			@Unidad		char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dias	float
  EXEC spTiempoEnDias @Empresa, @Tiempo, @Unidad, @Dias OUTPUT
  SELECT 'Dias' = @Dias
  RETURN
END
GO


/**************** spIncDiasHabiles ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncDiasHabiles') and type = 'P') drop procedure dbo.spIncDiasHabiles
GO             
CREATE PROCEDURE spIncDiasHabiles
			@Empresa		char(5),
			@Todos			bit,
			@Fecha	 		datetime,
		  	@Dias	 		float,
			@Resultado 		datetime	OUTPUT,
			@ProyectoID		int	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasHabiles 	char(20),
    @Faccion		float

  IF @ProyectoID IS NOT NULL
    SELECT @DiasHabiles = DiasHabiles FROM Proyecto WHERE ID = @ProyectoID
  ELSE
    SELECT @DiasHabiles = DiasHabiles FROM EmpresaGral WHERE Empresa = @Empresa

  SELECT @Faccion = @Dias - FLOOR(@Dias)

  IF @Dias <> 0.0
    EXEC spCalcularDiasHabiles @Fecha, @Dias, @DiasHabiles, @Todos, @Resultado OUTPUT, @ProyectoID = @ProyectoID
  ELSE SELECT @Resultado = @Fecha

  IF @Faccion <> 0.0
    EXEC spIncTiempo @Resultado, @Faccion, 'DIAS', @Resultado OUTPUT, @Empresa, 1, @Todos, @ProyectoID = @ProyectoID
  RETURN
END
GO

-- spVerIncDiasHabiles 'DEMO', 0, '7/4/6 08:00', 0.125
/**************** spVerIncDiasHabiles ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerIncDiasHabiles') and type = 'P') drop procedure dbo.spVerIncDiasHabiles
GO             
CREATE PROCEDURE spVerIncDiasHabiles
			@Empresa		char(5),
			@Todos			bit,
			@Fecha	 		datetime,
		  	@Dias	 		float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasHabiles 	char(20),
    @Faccion		float,
    @Resultado 		datetime
  EXEC spIncDiasHabiles @Empresa, @Todos, @Fecha, @Dias, @Resultado OUTPUT
  SELECT 'Resultado' = @Resultado 
  RETURN
END
GO


/**************** spIncTiempoHabil ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncTiempoHabil') and type = 'P') drop procedure dbo.spIncTiempoHabil
GO             
CREATE PROCEDURE spIncTiempoHabil
			@Empresa		char(5),
			@Todos			bit,
			@Fecha	 		datetime,
		  	@Tiempo  		float,
			@Unidad	 		char(10),
			@Resultado 		datetime	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaFloat		float,
    @DiasHabiles 	char(20),
    @HorasDia		float,
    @Dias		float,
    @Faccion		float

  SELECT @Dias = 0.0, @Unidad = UPPER(@Unidad)
  SELECT @DiasHabiles = DiasHabiles, @HorasDia = HorasDia FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT @FechaFloat = CONVERT(float, @Fecha)
  SELECT @Faccion = (@FechaFloat - FLOOR(@FechaFloat)) * 24.0 / @HorasDia

  IF @Unidad = 'SEGUNDOS' SELECT @Faccion = @Faccion + (@Tiempo / @HorasDia / 60 / 60) ELSE
  IF @Unidad = 'MINUTOS'  SELECT @Faccion = @Faccion + (@Tiempo / @HorasDia / 60) ELSE
  IF @Unidad = 'HORAS'    SELECT @Faccion = @Faccion + (@Tiempo / @HorasDia) ELSE
  IF @Unidad = 'DIAS'     SELECT @Dias = @Tiempo        ELSE
  IF @Unidad = 'SEMANAS'  SELECT @Dias = @Tiempo * 7    ELSE
  IF @Unidad = 'MESES'    SELECT @Dias = ROUND(@Tiempo * 30.4, 0) ELSE
  IF @Unidad = 'AÑOS'     SELECT @Dias = ROUND(@Tiempo * 365, 0)

  IF @Faccion >= 1.0 SELECT @Dias = @Dias + FLOOR(@Faccion), @Faccion = @Faccion - FLOOR(@Faccion)
  IF @Dias <> 0.0
    EXEC spCalcularDiasHabiles @Fecha, @Dias, @DiasHabiles, @Todos, @Resultado OUTPUT
  ELSE SELECT @Resultado = @Fecha

  SELECT @Faccion = @Faccion + (@Dias - FLOOR(@Dias))
  IF @Faccion <> 0.0
    EXEC spIncTiempo @Resultado, @Faccion, 'DIAS', @Resultado OUTPUT, @Empresa, 1, @Todos
  RETURN
END
GO

-- spVerIncTiempoHabil 'DEMO', 0, '7/4/6 08:00', 1, 'HORAS'
/**************** spVerIncTiempoHabil ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerIncTiempoHabil') and type = 'P') drop procedure dbo.spVerIncTiempoHabil
GO             
CREATE PROCEDURE spVerIncTiempoHabil
			@Empresa		char(5),
			@Todos			bit,
			@Fecha	 		datetime,
		  	@Tiempo  		float,
			@Unidad	 		char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	datetime
  EXEC spIncTiempoHabil @Empresa, @Todos, @Fecha, @Tiempo, @Unidad, @Resultado OUTPUT
  SELECT "Resultado" = @Resultado
END
GO


/*
DECLARE
  @Fecha	datetime
SELECT @Fecha = '5/7/5'
EXEC spRecorrerDiaHabilEmpresa 'DEMO', @Fecha OUTPUT
SELECT @Fecha
*/

/**************** spRecorrerDiaHabilEmpresa ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRecorrerDiaHabilEmpresa') and type = 'P') drop procedure dbo.spRecorrerDiaHabilEmpresa
GO             
CREATE PROCEDURE spRecorrerDiaHabilEmpresa
    		    @Empresa 	char(5),
		    @Fecha	datetime	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasHabiles char(10)

  SELECT @DiasHabiles = DiasHabiles FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT @Fecha = DATEADD(day, -1, @Fecha)
  EXEC spCalcularDiasHabiles @Fecha, 1, @DiasHabiles, 0, @Fecha OUTPUT
  RETURN
END
GO

/**************** spRecorrerDiaHabilJornada ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRecorrerDiaHabilJornada') and type = 'P') drop procedure dbo.spRecorrerDiaHabilJornada
GO             
CREATE PROCEDURE spRecorrerDiaHabilJornada
    		    @Empresa 	char(5),
		    @Fecha	datetime	OUTPUT,
			@Jornada varchar(20) = NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasHabiles char(10)

  SELECT @DiasHabiles = DiasHabiles FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT @Fecha = DATEADD(day, -1, @Fecha)
  EXEC spCalcularDiasHabiles @Fecha, 1, @DiasHabiles, 0, @Fecha OUTPUT, NULL, @Jornada 
  RETURN
END
GO

/**************** spCalcularVencimientoCorte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcularVencimientoCorte') and type = 'P') drop procedure dbo.spCalcularVencimientoCorte
GO             
CREATE PROCEDURE spCalcularVencimientoCorte
			@CorteDia	int,
			@Vencimiento	datetime	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dia int

  SELECT @Dia = DATEPART(day, @Vencimiento)
  IF @Dia > @CorteDia
    SELECT @Vencimiento = DATEADD(month, 1, DATEADD(day, -@Dia+1, @Vencimiento))

  RETURN
END
GO

/**************** spCalcularVencimiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcularVencimiento') and type = 'P') drop procedure dbo.spCalcularVencimiento
GO             
CREATE PROCEDURE spCalcularVencimiento
		    @Modulo		char(5),
		    @Empresa		char(5),
		    @Contacto		char(10),

                    @Condicion		varchar(50),
		    @FechaEmision	datetime,
                    @Vencimiento	datetime        OUTPUT,
		    @Dias		int		OUTPUT,
                    @Ok 		int		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
    @DiasAgregados	 int,
    @DiaSemana		 int,
    @TipoDias		 char(10),
    @DiasHabiles 	 char(10),
    @PorMeses		 bit,
    @Meses		 int,
    @PorSemanas		 bit,
    @Semanas		 int,
    @RecorrerVencimiento varchar(20),
    @Corte		 bit,
    @CorteDia		 int,
    @CfgRecorrerVenceRevisionPago bit,
    @DiaRevision1	 varchar(10),
    @DiaRevision2	 varchar(10),
    @DiaPago1		 varchar(10),
    @DiaPago2		 varchar(10),
    @FechaRevision1	 datetime,
    @FechaRevision2	 datetime,
    @FechaPago1	 	 datetime,
    @FechaPago2	 	 datetime

  SELECT @Dias = 0, @RecorrerVencimiento = 'NO', @CfgRecorrerVenceRevisionPago = 0, @DiaRevision1 = NULL, @DiaRevision2 = NULL, @DiaPago1 = NULL, @DiaPago2 = NULL

  IF UPPER(@Condicion) = '(FECHA)'
  BEGIN
    IF @Vencimiento IS NULL SELECT @Vencimiento = @FechaEmision
    EXEC spExtraerFecha @Vencimiento OUTPUT
  END ELSE BEGIN
    IF @Modulo IN ('CXC', 'VTAS')
    BEGIN
      SELECT @CfgRecorrerVenceRevisionPago = ISNULL(CxcRecorrerVenceRevisionPago, 0)
        FROM EmpresaCfg2
       WHERE Empresa = @Empresa
      SELECT @RecorrerVencimiento = ISNULL(RTRIM(UPPER(RecorrerVencimiento)), 'NO'),
             @DiaRevision1 = NULLIF(RTRIM(DiaRevision1), ''),
             @DiaRevision2 = NULLIF(RTRIM(DiaRevision2), ''),
             @DiaPago1 = NULLIF(RTRIM(DiaPago1), ''),
             @DiaPago2 = NULLIF(RTRIM(DiaPago2), '')
        FROM Cte
       WHERE Cliente = @Contacto
      IF @DiaRevision1 IS NULL SELECT @DiaRevision1 = @DiaRevision2
      IF UPPER(@RecorrerVencimiento) = '(EMPRESA)'
        SELECT @RecorrerVencimiento = ISNULL(RTRIM(UPPER(CxcRecorrerVencimiento)), 'NO')
          FROM EmpresaCfg
         WHERE Empresa = @Empresa
    END ELSE
    IF @Modulo IN ('CXP', 'COMS', 'GAS')
      SELECT @RecorrerVencimiento = ISNULL(RTRIM(UPPER(CxpRecorrerVencimiento)), 'NO')
        FROM EmpresaCfg
       WHERE Empresa = @Empresa

    EXEC spExtraerFecha @FechaEmision OUTPUT

    IF @CfgRecorrerVenceRevisionPago = 1 AND @DiaRevision1 IS NOT NULL 
    BEGIN
      SELECT @FechaRevision1 = @FechaEmision
      EXEC spRecorrerVencimiento @DiaRevision1, @FechaRevision1 OUTPUT
      IF @DiaRevision2 IS NULL 
        SELECT @FechaRevision2 = @FechaRevision1
      ELSE BEGIN
        SELECT @FechaRevision2 = @FechaEmision
        EXEC spRecorrerVencimiento @DiaRevision2, @FechaRevision2 OUTPUT
      END 
      IF @FechaRevision2 < @FechaRevision1 
        SELECT @FechaEmision = @FechaRevision2 
      ELSE 
        SELECT @FechaEmision = @FechaRevision1
    END

    SELECT @Vencimiento = @FechaEmision

    SELECT @Condicion = NULLIF(RTRIM(@Condicion), '')
    IF @Condicion IS NOT NULL 
    BEGIN
      SELECT @Dias                = ISNULL(DiasVencimiento, 0),
             @TipoDias            = ISNULL(RTRIM(UPPER(TipoDias)), 'HABILES'),
             @DiasHabiles         = ISNULL(RTRIM(UPPER(DiasHabiles)), 'LUN-VIE'),
             @PorMeses            = ISNULL(PorMeses, 0),
             @Meses	          = ISNULL(Meses, 0),
             @PorSemanas          = ISNULL(PorSemanas, 0),
             @Semanas	          = ISNULL(Semanas, 0),
             @Corte		  = Corte,
             @CorteDia		  = ISNULL(CorteDia, 0)
        FROM Condicion 
       WHERE Condicion = @Condicion

      IF @Corte = 1 AND @CorteDia IS NOT NULL
        EXEC spCalcularVencimientoCorte @CorteDia, @FechaEmision OUTPUT
      IF @PorMeses = 1
        SELECT @Vencimiento = DATEADD(month, @Meses, @FechaEmision)
      ELSE
      IF @PorSemanas = 1
        SELECT @Vencimiento = DATEADD(week, @Semanas, @FechaEmision)
      ELSE
      IF @Dias > 0
      BEGIN
        IF @TipoDias = 'HABILES'
          EXEC spCalcularDiasHabiles @FechaEmision, @Dias, @DiasHabiles, 1, @Vencimiento OUTPUT
        ELSE 
          SELECT @Vencimiento = DATEADD(day, @Dias, @FechaEmision)
      END
      IF @RecorrerVencimiento <> 'NO' AND @Vencimiento <> @FechaEmision 
        EXEC spRecorrerVencimiento @RecorrerVencimiento, @Vencimiento OUTPUT
    END

    IF @CfgRecorrerVenceRevisionPago = 1 AND @DiaPago1 IS NOT NULL AND @Dias > 0 
    BEGIN
      SELECT @FechaPago1 = @Vencimiento
      EXEC spRecorrerVencimiento @DiaPago1, @FechaPago1 OUTPUT
      IF @DiaPago2 IS NULL 
        SELECT @FechaPago2 = @FechaPago1
      ELSE BEGIN
        SELECT @FechaPago2 = @Vencimiento
        EXEC spRecorrerVencimiento @DiaPago2, @FechaPago2 OUTPUT
      END 
      IF @FechaPago2 < @FechaPago1
        SELECT @Vencimiento = @FechaPago2
      ELSE 
        SELECT @Vencimiento = @FechaPago1
    END

  END 
  RETURN
END
GO

-- spVerVencimiento 'CXP', 'DEMO', 'P1', '90 Dias (Corte 19)', '10/1/1'

/**************** spVerVencimiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerVencimiento') and type = 'P') drop procedure dbo.spVerVencimiento
GO             
CREATE PROCEDURE spVerVencimiento
		    @Modulo		char(5),
		    @Empresa		char(5),
		    @Contacto		char(10),

                    @Condicion		varchar(50),
		    @FechaEmision	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Vencimiento datetime,
    @Dias	 int,
    @Ok 	 int

  SELECT @Ok = NULL
  EXEC spCalcularVencimiento @Modulo, @Empresa, @Contacto, @Condicion, @FechaEmision, @Vencimiento OUTPUT, @Dias OUTPUT, @Ok OUTPUT
  SELECT "Vencimiento" = @Vencimiento
  RETURN
END
GO

/**************** spAgregarDias ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAgregarDias') and type = 'P') drop procedure dbo.spAgregarDias
GO             
CREATE PROCEDURE spAgregarDias
                    @FechaActual	datetime,
		    @Dias		int,		    
    		    @DiasHabiles 	char(10),
                    @TipoDias		char(10),
		    @Todos		bit,
		    @FechaFinal		datetime	OUTPUT,
		    @PresentarResultado bit = 0
--//WITH ENCRYPTION
AS BEGIN

  IF @TipoDias = 'HABILES'
    EXEC spCalcularDiasHabiles @FechaActual, @Dias, @DiasHabiles, 1, @FechaFinal OUTPUT
  ELSE 
    SELECT @FechaFinal = DATEADD(day, @Dias, @FechaActual)

  IF @PresentarResultado = 1 
    SELECT "FechaFinal" = @FechaFinal
  RETURN
END
GO

/**************** spCalcularVencimientoPP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcularVencimientoPP') and type = 'P') drop procedure dbo.spCalcularVencimientoPP
GO             
CREATE PROCEDURE spCalcularVencimientoPP
		    @Modulo			char(5),
		    @Empresa			char(5),
		    @Contacto			char(10),

                    @Condicion			varchar(50),
		    @FechaEmision		datetime,
                    @Vencimiento		datetime        OUTPUT,
		    @Dias			int		OUTPUT,
		    @FechaProntoPago		datetime	OUTPUT,
                    @DescuentoProntoPago	float		OUTPUT,
		    @Tasa			varchar(50)	OUTPUT,
                    @Ok 			int		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE  
    @DiasAgregados	 int,
    @DiaSemana		 int,
    @TipoDias		 char(10),
    @DiasHabiles 	 char(10),
    @PP			 bit,
    @DiasPP		 int,
    @TipoDiasPP		 char(10),
    @DiasHabilesPP 	 char(10),
    @DescuentoPP	 float,
    @FechaPP		 varchar(20),
    @PorMeses		 bit,
    @Meses		 int,
    @PorSemanas		 bit,
    @Semanas		 int,
    @Corte		 bit,
    @CorteDia		 int,
    @RecorrerVencimiento varchar(20),
    @F			 datetime,
    @D			 int,
    @CfgRecorrerVenceRevisionPago bit,
    @DiaRevision1	 varchar(10),
    @DiaRevision2	 varchar(10),
    @DiaPago1		 varchar(10),
    @DiaPago2		 varchar(10),
    @FechaRevision1	 datetime,
    @FechaRevision2	 datetime,
    @FechaPago1	 	 datetime,
    @FechaPago2	 	 datetime

  IF UPPER(@Condicion) = '(FECHA)'
    EXEC spExtraerFecha @Vencimiento OUTPUT
  ELSE BEGIN
    SELECT @FechaProntoPago = NULL, @DescuentoProntoPago = NULL, @Dias = 0, @DiasPP = 0, @RecorrerVencimiento = 'NO', @CfgRecorrerVenceRevisionPago = 0, @DiaRevision1 = NULL, @DiaRevision2 = NULL, @DiaPago1 = NULL, @DiaPago2 = NULL

    IF @Modulo = 'CXC' 
    BEGIN
      SELECT @CfgRecorrerVenceRevisionPago = ISNULL(CxcRecorrerVenceRevisionPago, 0)
        FROM EmpresaCfg2
       WHERE Empresa = @Empresa
      SELECT @RecorrerVencimiento = ISNULL(RTRIM(UPPER(RecorrerVencimiento)), 'NO'),
             @DiaRevision1 = NULLIF(RTRIM(DiaRevision1), ''),
             @DiaRevision2 = NULLIF(RTRIM(DiaRevision2), ''),
             @DiaPago1 = NULLIF(RTRIM(DiaPago1), ''),
             @DiaPago2 = NULLIF(RTRIM(DiaPago2), '')
        FROM Cte
       WHERE Cliente = @Contacto
      IF @DiaRevision1 IS NULL SELECT @DiaRevision1 = @DiaRevision2
      IF UPPER(@RecorrerVencimiento) = '(EMPRESA)'
        SELECT @RecorrerVencimiento = ISNULL(RTRIM(UPPER(CxcRecorrerVencimiento)), 'NO')
          FROM EmpresaCfg
         WHERE Empresa = @Empresa
    END ELSE
    IF @Modulo = 'CXP'
      SELECT @RecorrerVencimiento = ISNULL(RTRIM(UPPER(CxpRecorrerVencimiento)), 'NO')
        FROM EmpresaCfg
       WHERE Empresa = @Empresa

    EXEC spExtraerFecha @FechaEmision OUTPUT

    IF @CfgRecorrerVenceRevisionPago = 1 AND @DiaRevision1 IS NOT NULL 
    BEGIN
      SELECT @FechaRevision1 = @FechaEmision
      EXEC spRecorrerVencimiento @DiaRevision1, @FechaRevision1 OUTPUT
      IF @DiaRevision2 IS NULL 
        SELECT @FechaRevision2 = @FechaRevision1
      ELSE BEGIN
        SELECT @FechaRevision2 = @FechaEmision
        EXEC spRecorrerVencimiento @DiaRevision2, @FechaRevision2 OUTPUT
      END 
      IF @FechaRevision2 < @FechaRevision1 
        SELECT @FechaEmision = @FechaRevision2 
      ELSE 
        SELECT @FechaEmision = @FechaRevision1
    END

    SELECT @Condicion = NULLIF(RTRIM(@Condicion), ''), @Vencimiento = @FechaEmision 
    IF @Condicion IS NOT NULL 
    BEGIN
      SELECT @Dias                = ISNULL(DiasVencimiento, 0),
             @TipoDias            = ISNULL(RTRIM(UPPER(TipoDias)), 'HABILES'),
             @DiasHabiles         = ISNULL(RTRIM(UPPER(DiasHabiles)), 'LUN-VIE'),
             @PorMeses            = ISNULL(PorMeses, 0),
             @Meses	          = ISNULL(Meses, 0),
             @PorSemanas          = ISNULL(PorSemanas, 0),
             @Semanas             = ISNULL(Semanas, 0),
             @PP	          = ProntoPago,
	     @DiasPP              = ISNULL(DiasProntoPago, 0),
             @TipoDiasPP          = ISNULL(RTRIM(UPPER(TipoDiasProntoPago)), 'HABILES'),
             @DiasHabilesPP       = ISNULL(RTRIM(UPPER(DiasHabilesProntoPago)), 'LUN-VIE'),
             @DescuentoPP         = NULLIF(DescuentoProntoPago, 0),
             @FechaPP		  = ISNULL(RTRIM(UPPER(FechaProntoPago)), 'EMISION'),
             @Corte		  = Corte,
             @CorteDia		  = ISNULL(CorteDia, 0),
             @Tasa		  = CASE WHEN InteresesDevengados=1 THEN NULLIF(RTRIM(Tasa), '') ELSE NULL END
        FROM Condicion 
       WHERE Condicion = @Condicion

      IF @Corte = 1 AND @CorteDia IS NOT NULL
        EXEC spCalcularVencimientoCorte @CorteDia, @FechaEmision OUTPUT
      IF @PorMeses = 1
        SELECT @Vencimiento = DATEADD(month, @Meses, @FechaEmision)
      ELSE
      IF @PorSemanas = 1
        SELECT @Vencimiento = DATEADD(week, @Semanas, @FechaEmision)
      ELSE
      IF @Dias > 0
      BEGIN
        IF @TipoDias = 'HABILES'
          EXEC spCalcularDiasHabiles @FechaEmision, @Dias, @DiasHabiles, 1, @Vencimiento OUTPUT
        ELSE 
          SELECT @Vencimiento = DATEADD(day, @Dias, @FechaEmision)
      END
      IF @PP = 1 
      BEGIN        
        SELECT @DescuentoProntoPago = @DescuentoPP, @FechaProntoPago = @FechaEmision
        IF @DiasPP > 0
        BEGIN
          IF @FechaPP = 'VENCIMIENTO' 
             SELECT @F = @Vencimiento, @D = -@DiasPP
          ELSE
             SELECT @F = @FechaEmision, @D = @DiasPP
          IF @TipoDiasPP = 'HABILES'
            EXEC spCalcularDiasHabiles @F, @D, @DiasHabilesPP, 1, @FechaProntoPago OUTPUT
          ELSE 
            SELECT @FechaProntoPago = DATEADD(day, @D, @F)
        END
      END
      IF @RecorrerVencimiento <> 'NO' AND @Vencimiento <> @FechaEmision 
        EXEC spRecorrerVencimiento @RecorrerVencimiento, @Vencimiento OUTPUT
    END 

    IF @CfgRecorrerVenceRevisionPago = 1 AND @DiaPago1 IS NOT NULL
    BEGIN
      SELECT @FechaPago1 = @Vencimiento
      EXEC spRecorrerVencimiento @DiaPago1, @FechaPago1 OUTPUT
      IF @DiaPago2 IS NULL 
        SELECT @FechaPago2 = @FechaPago1
      ELSE BEGIN
        SELECT @FechaPago2 = @Vencimiento
        EXEC spRecorrerVencimiento @DiaPago2, @FechaPago2 OUTPUT
      END 
      IF @FechaPago2 < @FechaPago1
        SELECT @Vencimiento = @FechaPago2
      ELSE 
        SELECT @Vencimiento = @FechaPago1
    END

  END
  RETURN
END
GO

/**************** spCalcularPeriodicidad **************** endonde lo pongo*/
if exists (select * from sysobjects where id = object_id('dbo.spCalcularPeriodicidad') and type = 'P') drop procedure dbo.spCalcularPeriodicidad
GO             
CREATE PROCEDURE spCalcularPeriodicidad
		    @FechaEmision	datetime,
		    @Periodicidad	char(20),
			@Vencimiento	datetime        OUTPUT,
		    @Ok 		int		OUTPUT, 
		    @OkRef 		varchar(255)	OUTPUT,	
		    @Reversa		bit		= 0
WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Dia	int

  EXEC spExtraerFecha @FechaEmision OUTPUT

  IF @Reversa = 0
  BEGIN
    IF dbo.fnEsNumerico(@Periodicidad) = 1 SELECT @Vencimiento = DATEADD(day,   CONVERT(int, @Periodicidad), @FechaEmision) ELSE  
    IF @Periodicidad = 'DIARIA'     SELECT @Vencimiento = DATEADD(day,   1, @FechaEmision) ELSE

    IF @Periodicidad = 'SEMANAL'    SELECT @Vencimiento = DATEADD(week,  1, @FechaEmision) ELSE
    IF @Periodicidad = 'CATORCENAL'     SELECT @Vencimiento = DATEADD(day,   14, @FechaEmision) ELSE
    IF @Periodicidad = 'MENSUAL'    SELECT @Vencimiento = DATEADD(month, 1, @FechaEmision) ELSE
    IF @Periodicidad = 'BIMESTRAL'  SELECT @Vencimiento = DATEADD(month, 2, @FechaEmision) ELSE
    IF @Periodicidad = 'TRIMESTRAL' SELECT @Vencimiento = DATEADD(month, 3, @FechaEmision) ELSE
    IF @Periodicidad = 'SEMESTRAL'  SELECT @Vencimiento = DATEADD(month, 6, @FechaEmision) ELSE
    IF @Periodicidad = 'ANUAL'      SELECT @Vencimiento = DATEADD(year,  1, @FechaEmision) ELSE
    IF @Periodicidad = 'QUINCENAL'
    BEGIN
      SELECT @Dia = DATEPART(dd, @FechaEmision)
      IF @Dia <= 15 
        SELECT @Vencimiento = DATEADD(dd, 15-@Dia, @FechaEmision) + 1
      ELSE
        SELECT @Vencimiento = DATEADD(dd, -DATEPART(dd, DATEADD(mm, 1, @FechaEmision)), DATEADD(mm, 1, @FechaEmision))+1
    END ELSE 
    IF @Periodicidad = '<DIAS>' SELECT @Ok =55140, @OkRef = @Periodicidad ELSE SELECT @Vencimiento = NULL
  END ELSE
  BEGIN
    IF dbo.fnEsNumerico(@Periodicidad) = 1 SELECT @Vencimiento = DATEADD(day,   -CONVERT(int, @Periodicidad), @FechaEmision) ELSE  
    IF @Periodicidad = 'DIARIA'     SELECT @Vencimiento = DATEADD(day,   -1, @FechaEmision) ELSE
    IF @Periodicidad = 'SEMANAL'    SELECT @Vencimiento = DATEADD(week,  -1, @FechaEmision) ELSE
   IF @Periodicidad = 'CATORCENAL'  SELECT @Vencimiento = DATEADD(day,   -14, @FechaEmision) ELSE
    IF @Periodicidad = 'MENSUAL'    SELECT @Vencimiento = DATEADD(month, -1, @FechaEmision) ELSE
    IF @Periodicidad = 'BIMESTRAL'  SELECT @Vencimiento = DATEADD(month, -2, @FechaEmision) ELSE
    IF @Periodicidad = 'TRIMESTRAL' SELECT @Vencimiento = DATEADD(month, -3, @FechaEmision) ELSE
    IF @Periodicidad = 'SEMESTRAL'  SELECT @Vencimiento = DATEADD(month, -6, @FechaEmision) ELSE
    IF @Periodicidad = 'ANUAL'      SELECT @Vencimiento = DATEADD(year,  -1, @FechaEmision) ELSE
    IF @Periodicidad = 'QUINCENAL'
    BEGIN
      SELECT @Dia = DATEPART(dd, @FechaEmision)
      IF @Dia > 15 
        SELECT @Vencimiento = DATEADD(dd, -(@Dia-15), @FechaEmision)+1
      ELSE
        SELECT @Vencimiento = DATEADD(dd, -DATEPART(dd, @FechaEmision), @FechaEmision)+1
    END ELSE 
    IF @Periodicidad = '<DIAS>' SELECT @Ok =55140, @OkRef = @Periodicidad ELSE SELECT @Vencimiento = NULL
  END
 
  RETURN
END
GO

/*
DECLARE
  @Vencimiento datetime
EXEC spCalcularPeriodicidad '15/2/1', 'Quincenal', @Vencimiento OUTPUT, NULL, NULL, 1
select @Vencimiento
*/
/**************** spDiaSemana ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDiaSemana') and type = 'P') drop procedure dbo.spDiaSemana
GO             
CREATE PROCEDURE spDiaSemana @Dia int, @Texto char(20) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  IF @Dia = 1 SELECT @Texto = 'Domingo'   ELSE
  IF @Dia = 2 SELECT @Texto = 'Lunes'     ELSE
  IF @Dia = 3 SELECT @Texto = 'Martes'    ELSE
  IF @Dia = 4 SELECT @Texto = 'Miercoles' ELSE
  IF @Dia = 5 SELECT @Texto = 'Jueves'    ELSE
  IF @Dia = 6 SELECT @Texto = 'Viernes'   ELSE
  IF @Dia = 7 SELECT @Texto = 'Sabado'    ELSE SELECT @Texto = NULL
  RETURN
END
GO

/**************** spMesNombre ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMesNombre') and type = 'P') drop procedure dbo.spMesNombre
GO             
CREATE PROCEDURE spMesNombre @Mes int, @Texto char(20) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  IF @Mes =  1 SELECT @Texto = 'Enero'      ELSE
  IF @Mes =  2 SELECT @Texto = 'Febrero'    ELSE
  IF @Mes =  3 SELECT @Texto = 'Marzo'      ELSE
  IF @Mes =  4 SELECT @Texto = 'Abril'      ELSE
  IF @Mes =  5 SELECT @Texto = 'Mayo'       ELSE
  IF @Mes =  6 SELECT @Texto = 'Junio'      ELSE
  IF @Mes =  7 SELECT @Texto = 'Julio'      ELSE 
  IF @Mes =  8 SELECT @Texto = 'Agosto'     ELSE
  IF @Mes =  9 SELECT @Texto = 'Septiembre' ELSE
  IF @Mes = 10 SELECT @Texto = 'Octubre'    ELSE
  IF @Mes = 11 SELECT @Texto = 'Noviembre'  ELSE 
  IF @Mes = 12 SELECT @Texto = 'Diciembre'  ELSE 
  IF @Mes = 13 SELECT @Texto = '13'         ELSE SELECT @Texto = NULL
  RETURN
END
GO

/*
declare
  @clave varchar(15)
 exec spLlenarCeros 123, 5, @clave output
 select @clave
*/
/************** spLlenarCeros *************/
if exists (select * from sysobjects where id = object_id('dbo.spLlenarCeros') and type = 'P') drop procedure dbo.spLlenarCeros
GO
CREATE PROCEDURE spLlenarCeros
			@Consecutivo	bigint,
			@Digitos	int,
			@Clave		varchar(16) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Negativo	bit
  SELECT @Negativo = 0
  IF @Consecutivo < 0 SELECT @Digitos = @Digitos - 1, @Consecutivo = -@Consecutivo, @Negativo = 1
  SELECT @Clave = LTRIM(Convert(char, @Consecutivo))
  IF @Digitos > 1  AND @Consecutivo < 10               SELECT @Clave = '0' + @Clave
  IF @Digitos > 2  AND @Consecutivo < 100              SELECT @Clave = '0' + @Clave
  IF @Digitos > 3  AND @Consecutivo < 1000             SELECT @Clave = '0' + @Clave
  IF @Digitos > 4  AND @Consecutivo < 10000            SELECT @Clave = '0' + @Clave
  IF @Digitos > 5  AND @Consecutivo < 100000           SELECT @Clave = '0' + @Clave
  IF @Digitos > 6  AND @Consecutivo < 1000000          SELECT @Clave = '0' + @Clave
  IF @Digitos > 7  AND @Consecutivo < 10000000         SELECT @Clave = '0' + @Clave
  IF @Digitos > 8  AND @Consecutivo < 100000000        SELECT @Clave = '0' + @Clave
  IF @Digitos > 9  AND @Consecutivo < 1000000000       SELECT @Clave = '0' + @Clave
  IF @Digitos > 10 AND @Consecutivo < 10000000000      SELECT @Clave = '0' + @Clave
  IF @Digitos > 11 AND @Consecutivo < 100000000000     SELECT @Clave = '0' + @Clave
  IF @Digitos > 12 AND @Consecutivo < 1000000000000    SELECT @Clave = '0' + @Clave
  IF @Digitos > 13 AND @Consecutivo < 10000000000000   SELECT @Clave = '0' + @Clave
  IF @Digitos > 14 AND @Consecutivo < 100000000000000  SELECT @Clave = '0' + @Clave
  IF @Digitos > 16 AND @Consecutivo < 1000000000000000 SELECT @Clave = '0' + @Clave
  IF @Negativo = 1 SELECT @Clave = '-' + @Clave
  SELECT @Clave = RTRIM(@Clave)
  RETURN 
END
GO

/************** spQuitarCerosIzq *************/
if exists (select * from sysobjects where id = object_id('dbo.spQuitarCerosIzq') and type = 'P') drop procedure dbo.spQuitarCerosIzq
GO
CREATE PROCEDURE spQuitarCerosIzq
			@Clave		char(30) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  WHILE SUBSTRING(@Clave, 1, 1) = '0'
    SELECT @Clave = SUBSTRING(@Clave, 2, LEN(@Clave)-1)
  RETURN 
END
GO


/*
declare
  @clave varchar(15)
 SELECT @Clave = '"Hola"'
 exec spQuitarEntreComillas @clave output
 select @clave
*/


/************** spQuitarEntreComillas *************/
if exists (select * from sysobjects where id = object_id('dbo.spQuitarEntreComillas') and type = 'P') drop procedure dbo.spQuitarEntreComillas
GO
CREATE PROCEDURE spQuitarEntreComillas
			@Clave		varchar(50) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF SUBSTRING(@Clave, 1, 1) IN ('"', "'") AND SUBSTRING(@Clave, LEN(@Clave), 1) IN ('"', "'")
    SELECT @Clave = SUBSTRING(@Clave, 2, LEN(@Clave)-2)
  RETURN 
END
GO



/*
declare
  @clave varchar(15)
 SELECT @Clave = '123 45 67'
 exec spQuitarEspacios @clave output
 select '*'+@clave+'*'
*/

/************** spQuitarEspacios *************/
if exists (select * from sysobjects where id = object_id('dbo.spQuitarEspacios') and type = 'P') drop procedure dbo.spQuitarEspacios
GO
CREATE PROCEDURE spQuitarEspacios
			@Clave		varchar(100) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p	int

  SELECT @Clave = RTRIM(LTRIM(@Clave))
  SELECT @p = CHARINDEX(' ', @Clave)
  WHILE @p > 0
  BEGIN
    SELECT @Clave = SUBSTRING(@Clave, 1, @p-1) + SUBSTRING(@Clave, @p + 1, LEN(@Clave))
    SELECT @p = CHARINDEX(' ', @Clave)
  END    
  RETURN 
END
GO


/**************** spDateTimeEnHora ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDateTimeEnHora') and type = 'P') drop procedure dbo.spDateTimeEnHora
GO             
CREATE PROCEDURE spDateTimeEnHora
    		   @Fecha datetime,
		   @Hora  char(5) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @H	 int,
    @M	 int,
    @HSt char(2),
    @MSt char(2)

  SELECT @H = DATEPART(hh, @Fecha),
         @M = DATEPART(mi, @Fecha)

  EXEC spLlenarCeros @H, 2, @HSt OUTPUT
  EXEC spLlenarCeros @M, 2, @MSt OUTPUT
  SELECT @Hora = @HSt+':'+@MSt
  RETURN
END
GO

-- spAgregarClienteExpress '(CONSECUTIVO)', 'Jacinto Ramirez', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '102', 'Cliente', '0', 'Pesos', 'A', 'A[0-9]%', 5.0, '0', '0', 0.0, 'DEMO'
if exists (select * from sysobjects where id = object_id('dbo.spAgregarClienteExpress') and type = 'P') drop procedure dbo.spAgregarClienteExpress
GO
CREATE PROCEDURE spAgregarClienteExpress
		   @Clave		          varchar(20),
       @Nombre	     	    varchar(100),
		   @Direccion 		    varchar(100),
		   @Delegacion		    varchar(50),
		   @Colonia 		      varchar(30),
       @Ruta		          varchar(50),
		   @Poblacion 		    varchar(30),
		   @Estado 		        varchar(30),
		   @Pais 		          varchar(30),
		   @CodigoPostal 	    varchar(15),
		   @RFC 		          varchar(15),
		   @Telefonos		      varchar(100),
		   @Contacto		      varchar(50),
		   @eMail		          varchar(50),
		   @Categoria		      varchar(50),
		   @Grupo		          varchar(50),
		   @Familia		        varchar(50),
		   @Agente		        varchar(10),
       @Tipo		          varchar(20),
		   @Comentarios		    varchar(255),		
		   @Moneda		        varchar(10),
       @Prefijo		        varchar(5),
       @PrefijoLike		    char(10),
       @Digitos		        int,
		   @Condicion		      varchar(50),
		   @Credito		        varchar(50) = NULL,
		   @CPID		          int	        = NULL,
		   @Empresa		        varchar(5)  = NULL,
		   @Cta			          varchar(20) = NULL,
		   @PersonalNombres	  varchar(50) = NULL,
		   @PersonalAPaterno	varchar(50) = NULL,
		   @PersonalAMaterno	varchar(50) = NULL,
       @MapaLatitud       float,
       @MapaLongitud      float,
       @MapaUbicacion     varchar(255),
		   @IEPS		          varchar(20) = NULL,
		   @Sucursal		      int	        = NULL,
		   @ZonaImpuesto	    varchar(30) = NULL,
		   @FueraLinea		    bit	        = 0
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
    @OkRegistro bit

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
         @eMail		= RTRIM(NULLIF(@eMail,'0')), 
         @Categoria	= RTRIM(NULLIF(@Categoria,'0')), 
         @Grupo		= RTRIM(NULLIF(@Grupo,'0')), 
         @Familia	= RTRIM(NULLIF(@Familia,'0')), 
         @Agente	= RTRIM(NULLIF(@Agente,'0')), 
         @Tipo		= RTRIM(NULLIF(@Tipo,'0')), 
	 @Prefijo 	= RTRIM(NULLIF(@Prefijo,'0')), 
	 @PrefijoLike 	= RTRIM(NULLIF(@PrefijoLike,'0')),
	 @Condicion 	= RTRIM(NULLIF(@Condicion,'0')),
	 @Credito 	= RTRIM(NULLIF(@Credito,'0')),
         @CPID	        = NULLIF(@CPID, 0),
	 @Empresa 	= RTRIM(NULLIF(@Empresa,'0')),
	 @Cta	 	= RTRIM(NULLIF(@Cta,'0')),
         @PersonalNombres  = RTRIM(NULLIF(@PersonalNombres,'0')),
         @PersonalAPaterno = RTRIM(NULLIF(@PersonalAPaterno,'0')),
         @PersonalAMaterno = RTRIM(NULLIF(@PersonalAMaterno,'0')),
         @IEPS             = RTRIM(NULLIF(@IEPS,'0')),
         @ZonaImpuesto     = RTRIM(NULLIF(@ZonaImpuesto,'0'))

  SELECT @PrefijoSucursal = NULL, @Ok = NULL, @OkRef = NULL, @UsarPrefijoSucursal = 0

  SELECT @UsarPrefijoSucursal = CteExpressUsarPrefijoSucursal,
         @Condicion = CteExpressCondicion,
         @ConsecutivoGral = SugerirConsecCentralizado 
    FROM EmpresaGral 
   WHERE Empresa = @Empresa

  IF @UsarPrefijoSucursal = 1
    SELECT @PrefijoSucursal = NULLIF(RTRIM(Prefijo), '') FROM Sucursal s, Version v WHERE s.Sucursal = v.Sucursal

  IF @CPID IS NOT NULL
    SELECT @CodigoPostal = CodigoPostal, @Colonia = Colonia, @Delegacion = Delegacion, @Ruta = Ruta,
           @Estado = Estado, @Pais = 'Mexico'
      FROM CodigoPostal
     WHERE ID = @CPID

  IF @PrefijoSucursal IS NOT NULL SELECT @Prefijo = @PrefijoSucursal, @PrefijoLike = RTRIM(@PrefijoSucursal)+'[0-9]%'

  IF @Tipo IS NULL SELECT @Tipo = 'Cliente'
  IF @Clave = '(RFC)'
  BEGIN
    IF NOT EXISTS(SELECT * FROM Cte WHERE UPPER(RTRIM(LTRIM(RFC)))=UPPER(RTRIM(LTRIM(@RFC))))--WHERE UPPER(RFC)=UPPER(@RFC))
      --SELECT @Clave = SUBSTRING(@RFC, 1, 10)
      SELECT @Clave = RTRIM(LTRIM(@RFC))
    ELSE 
      SELECT @Clave = '(CONSECUTIVO)'
  END
  IF @Clave = '(TELEFONO)'
  BEGIN
    SELECT @Clave = SUBSTRING(@Telefonos, 1, 10)
    SELECT @Pos = PATINDEX('% %', @Clave)
    IF @Pos > 1 SELECT @Clave = SUBSTRING(RTRIM(LTRIM(@Clave)), 1, @Pos-1)--SUBSTRING(@Clave, 1, @Pos-1)
  END

  IF @Clave IN ('(CONSECUTIVO)', NULL)
  BEGIN
    IF @ConsecutivoGral = 1 
      EXEC spConsecutivo 'Cte', @Sucursal, @Clave OUTPUT
    ELSE BEGIN
      SELECT @Clave = MAX(RTRIM(LTRIM(Cliente))) FROM Cte WHERE Cliente LIKE RTRIM(@PrefijoLike)--MAX(Cliente) FROM Cte WHERE Cliente LIKE @PrefijoLike
      IF @Clave IS NULL 
        SELECT @Consecutivo = 1
      ELSE SELECT @Consecutivo = Convert(int, STUFF(@Clave, 1, LEN(RTRIM(@Prefijo)), NULL)) + 1
      EXEC spLlenarCeros @Consecutivo, @Digitos, @Clave OUTPUT
      SELECT @Clave = RTRIM(@Prefijo) + RTRIM(LTRIM(@Clave))--LTRIM(@Clave)      
    END
  END

  SELECT @Clave = NULLIF(RTRIM(LTRIM(@Clave)), '')--NULLIF(RTRIM(@Clave), '')
/*
  SELECT @Clave = NULLIF(RTRIM(LTRIM(@Clave)), '')
  IF @Clave IS NULL RETURN 
*/
  IF @Clave IS NULL 
  BEGIN
    SELECT @Mensaje = 'Es Necesario Configurar el Consecutivo General del Tipo Cte.'
    RAISERROR (@Mensaje, 16, -1) 
  RETURN 
  END
  ELSE
  BEGIN
    EXEC spRegistroOk 'RFC', @RFC, @Empresa, 1, @OkRegistro OUTPUT 
    IF @OkRegistro = 0
    BEGIN
      SELECT @Mensaje = 'EL RFC es Incorrecto: "'+RTRIM(LTRIM(@RFC))+'"'
      RAISERROR (@Mensaje, 16, -1) 
     RETURN 
    END
  END

  BEGIN TRANSACTION
    IF NOT EXISTS(SELECT * FROM Cte WHERE RTRIM(LTRIM(Cliente)) = RTRIM(LTRIM(@Clave)))--Cliente = @Clave)
    BEGIN
      IF EXISTS(SELECT * FROM Cte WHERE UPPER(Nombre) = UPPER(@Nombre) AND UPPER(RTRIM(LTRIM(RFC)))=UPPER(RTRIM(LTRIM(@RFC))))--UPPER(RFC)=UPPER(@RFC))
      BEGIN
        SELECT @Clave = Cliente FROM Cte WHERE UPPER(Nombre) = UPPER(@Nombre) AND UPPER(RTRIM(LTRIM(RFC)))=UPPER(RTRIM(LTRIM(@RFC)))--UPPER(RFC)=UPPER(@RFC)
        SELECT @Ok = 1
      END
      ELSE IF EXISTS(SELECT * FROM Cte WHERE UPPER(RTRIM(LTRIM(RFC)))=UPPER(RTRIM(LTRIM(@RFC))))
      BEGIN
        SELECT @Clave = Cliente FROM Cte WHERE UPPER(RTRIM(LTRIM(RFC)))=UPPER(RTRIM(LTRIM(@RFC)))
        SELECT @Mensaje = 'El RFC Ya Existe en "'+RTRIM(LTRIM(@Clave))+'"'
	    RAISERROR (@Mensaje, 16, -1)
      END
      ELSE BEGIN
        IF @Categoria IS NOT NULL AND NOT EXISTS(SELECT * FROM CteCat   WHERE UPPER(Categoria) = UPPER(@Categoria)) SELECT @Ok = 10060, @OkRef = @Categoria  	ELSE
        IF @Grupo     IS NOT NULL AND NOT EXISTS(SELECT * FROM CteGrupo WHERE UPPER(Grupo)     = UPPER(@Grupo))     SELECT @Ok = 10060, @OkRef = @Grupo     	ELSE
        IF @Familia   IS NOT NULL AND NOT EXISTS(SELECT * FROM CteFam   WHERE UPPER(Familia)   = UPPER(@Familia))   SELECT @Ok = 10060, @OkRef = @Familia	

        SELECT @NombreCorto = LEFT(@Nombre, 20)
        INSERT Cte (Cliente,          Tipo,  Nombre,  NombreCorto,  Direccion,  Delegacion,  Colonia,  Estado,  Pais,  Ruta,  Poblacion,  CodigoPostal,  RFC,  IEPS,  ZonaImpuesto,  Telefonos,  Contacto1, eMail1, Categoria,  Grupo,  Familia,  DefMoneda, Condicion,  Credito,  Agente,  Estatus, Alta,      Cuenta, PersonalNombres,  PersonalApellidoPaterno, PersonalApellidoMaterno, FueraLinea, MapaLatitud, MapaLongitud, MapaUbicacion)
            VALUES (/*LEFT(@Clave, 10)*/LEFT(RTRIM(LTRIM(@Clave)), 10), @Tipo, @Nombre, @NombreCorto, @Direccion, @Delegacion, @Colonia, @Estado, @Pais, @Ruta, @Poblacion, @CodigoPostal, /*@RFC*/RTRIM(LTRIM(@RFC)), @IEPS, @ZonaImpuesto, @Telefonos, @Contacto, @eMail, @Categoria, @Grupo, @Familia, @Moneda,   @Condicion, @Credito, @Agente, 'ALTA',  GETDATE(), @Cta,   @PersonalNombres, @PersonalAPaterno, @PersonalAMaterno, @FueraLinea, @MapaLatitud, @MapaLongitud, @MapaUbicacion)

        IF @Comentarios IS NOT NULL 
          IF EXISTS(SELECT * FROM NotaCta WHERE Rama = 'CXC' AND RTRIM(LTRIM(Cuenta)) = RTRIM(LTRIM(@Clave)))--Cuenta = @Clave)
            UPDATE NotaCta SET Comentarios = @Comentarios WHERE Rama = 'CXC' AND RTRIM(LTRIM(Cuenta)) = RTRIM(LTRIM(@Clave))--Cuenta = @Clave
          ELSE
            INSERT NotaCta (Rama, Cuenta, Comentarios) VALUES ('CXC', @Clave, @Comentarios)
      END
    END

  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  IF @Ok = 10060--NOT EXISTS (SELECT * FROM Cte WHERE RTRIM(LTRIM(Cliente)) = RTRIM(LTRIM(@Clave)) /*AND RTRIM(LTRIM(RFC)) = RTRIM(LTRIM(@RFC))*/)
  BEGIN
    SELECT @Mensaje = '"'+LTRIM(RTRIM(ISNULL(@OkRef, '')))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    RAISERROR (@Mensaje,16,-1) 
  END 
  ELSE IF @Ok IS NULL AND EXISTS (SELECT * FROM Cte WHERE RTRIM(LTRIM(Cliente)) = RTRIM(LTRIM(@Clave)) AND RTRIM(LTRIM(RFC)) = RTRIM(LTRIM(@RFC)))
  BEGIN
	SELECT "Clave" = RTRIM(LTRIM(@Clave))
	RETURN
  END
  ELSE IF @Ok IS NOT NULL
  BEGIN
	SELECT "Clave" = RTRIM(LTRIM(@Clave))
    RETURN 
  END
  ELSE
    SELECT "Clave" = RTRIM(LTRIM(@Clave))
  RETURN
END
GO

/*
  DECLARE @Clave char(20), @Consecutivo	int, @Digitos int

  SELECT @Digitos = 4

  SELECT @Clave = MAX(Cliente) FROM Cte WHERE Cliente LIKE 'C%'
  IF @Clave IS NULL 
    SELECT @Consecutivo = 1
  ELSE SELECT @Consecutivo = Convert(int, STUFF(@Clave, 1, DATALENGTH(RTRIM('C')), NULL)) + 1
  IF @Consecutivo = 1000 AND @Digitos = 4
  BEGIN
    SELECT @Clave = MAX(Cliente) FROM Cte WHERE Cliente LIKE 'C%' AND Cliente > 'C1000'
    IF @Clave IS NULL 
      SELECT @Consecutivo = 1
    ELSE SELECT @Consecutivo = Convert(int, STUFF(@Clave, 1, DATALENGTH(RTRIM('C')), NULL)) + 1
  END

  EXEC spLlenarCeros 1001, 4, @Clave OUTPUT
  SELECT @Clave
*/

-- spAgregarProveedorExpress '(CONSECUTIVO)', 'Jacinto Ramirez', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '102', 'Acreedor', 'Pesos', 5.0, '0', 0.0, 'DEMO'
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

-- spAgregarArticuloExpress '(CONSECUTIVO)', '12345', 'Normal', '0', 'Pesos', '1222', '15', '0', '0', '0', '0', 'AA', 'AA[0-9]%', 5.0, 'FOTAO'
/************** spAgregarArticuloExpress *************/
if exists (select * from sysobjects where id = object_id('dbo.spAgregarArticuloExpress') and type = 'P') drop procedure dbo.spAgregarArticuloExpress
GO
CREATE PROCEDURE spAgregarArticuloExpress
		   @Clave		char(20),
                   @Descripcion     	varchar(100),
		   @Tipo		char(20),
		   @Unidad		varchar(50),
		   @Moneda		char(10),
		   @PrecioLista		float,
		   @Impuesto1		float,
		   @Impuesto2		float,
		   @Impuesto3		float,
		   @Categoria		varchar(50),
		   @Comentarios		varchar(255),
                   @Prefijo		char(5),
                   @PrefijoLike		char(10),
                   @Digitos		int,
		   @Empresa		char(5) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Pos		int,
    @Consecutivo	int,
    @PrefijoSucursal	char(5),
    @TipoCosteo		char(20),
    @UsarPrefijoSucursal bit

  IF @Empresa IS NOT NULL
    SELECT @TipoCosteo  = TipoCosteo
      FROM EmpresaCfg
     WHERE Empresa = @Empresa   

  SELECT @Clave 	= UPPER(RTRIM(NULLIF(@Clave,'0'))),
	 @Descripcion 	= RTRIM(NULLIF(@Descripcion,'0')), 
	 @Tipo  	= RTRIM(NULLIF(@Tipo,'0')), 
	 @Unidad 	= RTRIM(NULLIF(@Unidad,'0')), 
         @Categoria	= RTRIM(NULLIF(@Categoria,'0')), 
	 @Moneda 	= RTRIM(NULLIF(@Moneda,'0')), 
	 @Prefijo 	= RTRIM(NULLIF(@Prefijo,'0')), 
	 @PrefijoLike 	= RTRIM(NULLIF(@PrefijoLike,'0')),
         @PrecioLista   = NULLIF(@PrecioLista, 0),
         @Impuesto1     = ISNULL(@Impuesto1, 0), 
         @Impuesto2     = NULLIF(@Impuesto2, 0),
         @Impuesto3     = NULLIF(@Impuesto3, 0)

  SELECT @PrefijoSucursal = NULL, @UsarPrefijoSucursal = 0

  SELECT @UsarPrefijoSucursal = ArtExpressUsarPrefijoSucursal FROM EmpresaGral WHERE Empresa = @Empresa

  IF @UsarPrefijoSucursal = 1
    SELECT @PrefijoSucursal = NULLIF(RTRIM(Prefijo), '') FROM Sucursal s, Version v WHERE s.Sucursal = v.Sucursal

  IF @PrefijoSucursal IS NOT NULL SELECT @Prefijo = @PrefijoSucursal, @PrefijoLike = RTRIM(@PrefijoSucursal)+'[0-9]%'

  IF @Clave IN ('(CONSECUTIVO)', NULL)
  BEGIN
    SELECT @Clave = MAX(Articulo) FROM Art WHERE Articulo LIKE @PrefijoLike AND Estatus = 'ALTA'
    IF @Clave IS NULL 
      SELECT @Consecutivo = 1
    ELSE SELECT @Consecutivo = Convert(int, STUFF(@Clave, 1, DATALENGTH(RTRIM(@Prefijo)), NULL)) + 1
    EXEC spLlenarCeros @Consecutivo, @Digitos, @Clave OUTPUT
    SELECT @Clave = RTRIM(@Prefijo) + LTRIM(@Clave)
  END

  BEGIN TRANSACTION
    IF NOT EXISTS(SELECT * FROM Art WHERE Articulo = @Clave)
    BEGIN
      IF EXISTS(SELECT * FROM Art WHERE UPPER(Descripcion1) = UPPER(@Descripcion))
        SELECT @Clave = Articulo FROM Art WHERE UPPER(Descripcion1) = UPPER(@Descripcion)
      ELSE BEGIN
        INSERT Art (Articulo, Descripcion1, Tipo,  Unidad,  UnidadCompra, PrecioLista,  MonedaPrecio, MonedaCosto, Impuesto1,  Impuesto2,  Impuesto3,  Categoria,  Estatus, TipoCosteo)
            VALUES (@Clave,   @Descripcion, @Tipo, @Unidad, @Unidad,      @PrecioLista, @Moneda,      @Moneda,     @Impuesto1, @Impuesto2, @Impuesto3, @Categoria, 'ALTA', @TipoCosteo)

        IF @Comentarios IS NOT NULL 
          IF EXISTS(SELECT * FROM NotaCta WHERE Rama = 'INV' AND Cuenta = @Clave)
            UPDATE NotaCta SET Comentarios = @Comentarios WHERE Rama = 'INV' AND Cuenta = @Clave
          ELSE
            INSERT NotaCta (Rama, Cuenta, Comentarios) VALUES ('INV', @Clave, @Comentarios)
      END
    END
  COMMIT TRANSACTION

  SELECT "Clave" = @Clave
  RETURN 
END
GO

/************** spConceptoExpress *************/
if exists (select * from sysobjects where id = object_id('dbo.spConceptoExpress') and type = 'P') drop procedure dbo.spConceptoExpress
GO
CREATE PROCEDURE spConceptoExpress
			@ID	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Modulo     char(5),
    @Concepto	varchar(50),
    @Clase	varchar(50),
    @SubClase	varchar(50)
    
  SELECT @Modulo = Modulo,
	 @Concepto = Concepto,
         @Clase = Clase,
         @SubClase = SubClase
    FROM ConceptoExpress
   WHERE ID = @ID
  IF NOT EXISTS(SELECT * FROM Concepto WHERE Modulo = @Modulo AND Concepto = @Concepto)
  BEGIN
    INSERT Concepto (Modulo,  Concepto,  Clase,  SubClase) 
             VALUES (@Modulo, @Concepto, @Clase, @SubClase) 
  END
END
GO


/************** spVerCamposTabla *************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCamposTabla') and type = 'P') drop procedure dbo.spVerCamposTabla
GO
CREATE PROCEDURE spVerCamposTabla
			@Tabla	char(100)
--//WITH ENCRYPTION
AS BEGIN
  SELECT "Campo"= c.name 
    FROM sysobjects o, syscolumns c 
   WHERE c.id = o.id 
     AND o.id = object_id(@Tabla) 
     AND o.sysstat & 0xf = 3
     AND c.name not LIKE 'Logico[0-9]'
END
GO

/************** spEstaImpreso *************/
if exists (select * from sysobjects where id = object_id('dbo.spEstaImpreso') and type = 'P') drop procedure dbo.spEstaImpreso
GO
CREATE PROCEDURE spEstaImpreso
			@Modulo	char(5),
			@ID	int
--//WITH ENCRYPTION
AS BEGIN
  IF @Modulo = 'VTAS' UPDATE Venta  SET EstaImpreso = 1 WHERE ID = @ID AND EstaImpreso = 0 ELSE
  IF @Modulo = 'CXC'  UPDATE Cxc    SET EstaImpreso = 1 WHERE ID = @ID AND EstaImpreso = 0 ELSE
  IF @Modulo = 'CXP'  UPDATE Cxp    SET EstaImpreso = 1 WHERE ID = @ID AND EstaImpreso = 0 ELSE
  IF @Modulo = 'DIN'  UPDATE Dinero SET EstaImpreso = 1 WHERE ID = @ID AND EstaImpreso = 0 ELSE
  IF @Modulo = 'GAS'  UPDATE Gasto  SET EstaImpreso = 1 WHERE ID = @ID AND EstaImpreso = 0 ELSE
  IF @Modulo = 'INV'  UPDATE Inv    SET EstaImpreso = 1 WHERE ID = @ID AND EstaImpreso = 0 ELSE
  IF @Modulo = 'COMS' UPDATE Compra SET EstaImpreso = 1 WHERE ID = @ID AND EstaImpreso = 0 
END
GO


/************** spCopiarUsuarioCfg *************/
if exists (select * from sysobjects where id = object_id('dbo.spCopiarUsuarioCfg') and sysstat & 0xf = 4) drop procedure dbo.spCopiarUsuarioCfg
GO
CREATE PROCEDURE spCopiarUsuarioCfg
                   @UsuarioD    char(10),
                   @UsuarioA	char(10)
--//WITH ENCRYPTION
AS BEGIN
 DELETE UsuarioAlm WHERE Usuario = @UsuarioA
 INSERT UsuarioAlm (Usuario, Almacen) SELECT @UsuarioA, Almacen FROM UsuarioAlm WHERE Usuario = @UsuarioD

 DELETE UsuarioPrecios WHERE Usuario = @UsuarioA
 INSERT UsuarioPrecios (Usuario, ListaPrecios) SELECT @UsuarioA, ListaPrecios FROM UsuarioPrecios WHERE Usuario = @UsuarioD

 DELETE UsuarioSucursalAcceso WHERE Usuario = @UsuarioA
 INSERT UsuarioSucursalAcceso (Usuario, Sucursal) SELECT @UsuarioA, Sucursal FROM UsuarioSucursalAcceso WHERE Usuario = @UsuarioD

 DELETE UsuarioMovCancelacionEx WHERE Usuario = @UsuarioA
 INSERT UsuarioMovCancelacionEx (Usuario, Modulo, Mov) SELECT @UsuarioA, Modulo, Mov FROM UsuarioMovCancelacionEx WHERE Usuario = @UsuarioD

 DELETE UsuarioMovImporteMaximo WHERE Usuario = @UsuarioA
 INSERT UsuarioMovImporteMaximo (Usuario, Modulo, Mov, ImporteMaximo, NoDeducibleMaximo, DescuentoGlobalMaximo, DescuentoLineaMaximo) SELECT @UsuarioA, Modulo, Mov, ImporteMaximo, NoDeducibleMaximo, DescuentoGlobalMaximo, DescuentoLineaMaximo FROM UsuarioMovImporteMaximo WHERE Usuario = @UsuarioD

 DELETE UsuarioModuloEx WHERE Usuario = @UsuarioA
 INSERT UsuarioModuloEx (Usuario, Modulo, BloquearFiltroSucursal) SELECT @UsuarioA, Modulo, BloquearFiltroSucursal FROM UsuarioModuloEx WHERE Usuario = @UsuarioD
 
/* 
 DELETE UsuarioImpresora WHERE Usuario = @UsuarioA
 INSERT UsuarioImpresora (Usuario, Impresora, Orden) SELECT @UsuarioA, Impresora, Orden FROM UsuarioImpresora WHERE Usuario = @UsuarioD
*/
 UPDATE a
    SET --SincroC                 = a.SincroC,
        DefAgente		= d.DefAgente,
	DefAlmacen		= d.DefAlmacen,
	DefAlmacenTrans		= d.DefAlmacenTrans,
	DefCtaDinero		= d.DefCtaDinero,
	DefCtaDineroTrans	= d.DefCtaDineroTrans,
        DefMoneda		= d.DefMoneda,
	DefProyecto		= d.DefProyecto,
	DefLocalidad		= d.DefLocalidad,
	DefCliente		= d.DefCliente,
        DefActividad		= d.DefActividad,
        DefMovVentas		= d.DefMovVentas,
	DefZonaImpuesto		= d.DefZonaImpuesto,
	Afectar			= d.Afectar,
	Cancelar		= d.Cancelar,
	Desafectar		= d.Desafectar,
	Autorizar		= d.Autorizar,
	AutorizarVenta		= d.AutorizarVenta,
	AutorizarCompra		= d.AutorizarCompra,
	AutorizarCxp		= d.AutorizarCxp,
	AutorizarGasto		= d.AutorizarGasto,
        AutorizarDinero	        = d.AutorizarDinero,
        AutorizarPV             = d.AutorizarPV,
	AutorizarSeriesLotes	= d.AutorizarSeriesLotes,
        AutorizarGestion        = d.AutorizarGestion,
	AfectarOtrosMovs	= d.AfectarOtrosMovs,
	CancelarOtrosMovs	= d.CancelarOtrosMovs,
	ConsultarOtrosMovs	= d.ConsultarOtrosMovs,
	ConsultarOtrosMovsGrupo = d.ConsultarOtrosMovsGrupo,
	ModificarOtrosMovs	= d.ModificarOtrosMovs,
	ModificarVencimientos	= d.ModificarVencimientos,
	ModificarEntregas	= d.ModificarEntregas,
	ModificarFechaRequerida = d.ModificarFechaRequerida,
	ModificarEnvios		= d.ModificarEnvios,
	ModificarReferencias	= d.ModificarReferencias,
	ModificarAlmacenEntregas= d.ModificarAlmacenEntregas,
	ModificarSituacion	= d.ModificarSituacion,
	ModificarAgente		= d.ModificarAgente,
	ModificarUsuario	= d.ModificarUsuario,
	ModificarListaPrecios	= d.ModificarListaPrecios,
	ModificarZonaImpuesto	= d.ModificarZonaImpuesto,
	ModificarSucursalDestino= d.ModificarSucursalDestino,
	ConsultarOtrasEmpresas  = d.ConsultarOtrasEmpresas,
	ConsultarOtrasSucursales= d.ConsultarOtrasSucursales,
	AgregarCteExpress	= d.AgregarCteExpress,
	AgregarArtExpress	= d.AgregarArtExpress,
	Costos			= d.Costos,
	BloquearCostos		= d.BloquearCostos,
	VerInfoDeudores		= d.VerInfoDeudores,
	VerInfoAcreedores	= d.VerInfoAcreedores,
	VerComisionesPendientes	= d.VerComisionesPendientes,
	BloquearEncabezadoVenta	= d.BloquearEncabezadoVenta,
	BloquearCxcCtaDinero	= d.BloquearCxcCtaDinero,
	BloquearCxpCtaDinero	= d.BloquearCxpCtaDinero,
	BloquearDineroCtaDinero	= d.BloquearDineroCtaDinero,
	EnviarExcel		= d.EnviarExcel,
	ImprimirMovs		= d.ImprimirMovs,
	PreliminarMovs		= d.PreliminarMovs,
	Reservar		= d.Reservar,
	DesReservar		= d.DesReservar,
	Asignar			= d.Asignar,
	DesAsignar		= d.DesAsignar,
	ModificarAlmacenPedidos	= d.ModificarAlmacenPedidos,
	ModificarConceptos	= d.ModificarConceptos,
	BloquearPrecios		= d.BloquearPrecios,
	BloquearDescGlobal	= d.BloquearDescGlobal,
	BloquearDescLinea	= d.BloquearDescLinea,
	BloquearCondiciones	= d.BloquearCondiciones,
	BloquearAlmacen		= d.BloquearAlmacen,
	BloquearMoneda		= d.BloquearMoneda,
	BloquearAgente		= d.BloquearAgente,
	BloquearFechaEmision	= d.BloquearFechaEmision,
	BloquearProyecto	= d.BloquearProyecto,
	AccesarOtrasSucursalesEnLinea = d.AccesarOtrasSucursalesEnLinea,
	AfectarOtrasSucursalesEnLinea = d.AfectarOtrasSucursalesEnLinea,
	--Sucursal		= d.Sucursal,
	DefCajero		= d.DefCajero,
	DefEmpresa		= d.DefEmpresa,
	ContrasenaFecha		= d.ContrasenaFecha,
	BloquearCobroInmediato	= d.BloquearCobroInmediato,
	ConsultarCompraPendiente= d.ConsultarCompraPendiente,
        Refacturar              = d.Refacturar,
	DefListaPreciosEsp	= d.DefListaPreciosEsp,
	LimiteTableroControl	= d.LimiteTableroControl,
        CteInfo			= d.CteInfo,
        CteBloquearOtrosDatos   = d.CteBloquearOtrosDatos,
        ArtBloquearOtrosDatos   = d.ArtBloquearOtrosDatos,
	CteSucursalVenta	= d.CteSucursalVenta,
        ImpresionInmediata	= d.ImpresionInmediata,
        CambioValidarCobertura  = d.CambioValidarCobertura,
        AccesoTotalCuentas      = d.AccesoTotalCuentas,
        MostrarCampos		= d.MostrarCampos,
	AsistentePrecios	= d.AsistentePrecios,
        CambioVerPosicionEmpresa= d.CambioVerPosicionEmpresa,
	CambioVerPosicionSucursal=d.CambioVerPosicionSucursal,
	CambioVerPosicionOtraSucursal=d.CambioVerPosicionOtraSucursal,
        CambioAutorizarOperacionLimite=d.CambioAutorizarOperacionLimite,
        AutoDobleCapturaPrecios = d.AutoDobleCapturaPrecios,
        AutoArtGrupo            = d.AutoArtGrupo,
        AutoAgregarRecaudacionConsumo = d.AutoAgregarRecaudacionConsumo,
        AutoDiesel	        = d.AutoDiesel,
        BloquearActividad	= d.BloquearActividad,
        UEN			= d.UEN,
        CteMov			= d.CteMov,
        CteArt			= d.CteArt,
        ProvMov			= d.ProvMov,
        ArtMov			= d.ArtMov,
        DefContUso		= d.DefContUso,
        BloquearContUso		= d.BloquearContUso,
        ModificarReferenciasSiempre = d.ModificarReferenciasSiempre,
        Observaciones           = d.Observaciones, 
        TraspasarTodo		= d.TraspasarTodo,
        ModificarAgenteCxcPendiente = d.ModificarAgenteCxcPendiente,
        BloquearNotasNegativas  = d.BloquearNotasNegativas,
	ModificarSerieLoteProp  = d.ModificarSerieLoteProp,
        NominaEliminacionParcial= d.NominaEliminacionParcial,
        CtaDineroInfo           = d.CtaDineroInfo,
        ModificarProyUENActCC   = d.ModificarProyUENActCC,
        DefFormaPago		= d.DefFormaPago,
	BloquearFormaPago	= d.BloquearFormaPago,
	PVAbrirCajonSiempre	= d.PVAbrirCajonSiempre,
	PVBloquearEgresos	= d.PVBloquearEgresos,
        PVCobrarNotasEstatusBorrador = d.PVCobrarNotasEstatusBorrador,
        PVModificarEstatusBorrador   = d.PVModificarEstatusBorrador,
        ModificarPropiedadesLotes    = d.ModificarPropiedadesLotes,
        BloquearPersonalCfg     = d.BloquearPersonalCfg,
        ModificarMovsNominaVigentes = d.ModificarMovsNominaVigentes,
        BloquearFacturacionDirecta  = d.BloquearFacturacionDirecta,
        BloquearInvSalidaDirecta    = d.BloquearInvSalidaDirecta,
        ModificarDatosVIN           = d.ModificarDatosVIN,
        ModificarDatosCliente       = d.ModificarDatosCliente,
	CxcExpress		    = d.CxcExpress,
	CxpExpress		    = d.CxpExpress,
        SubModuloAtencion           = d.SubModuloAtencion,
        BloquearCancelarFactura	    = d.BloquearCancelarFactura, 
        CambioPresentacionExpress   = d.CambioPresentacionExpress,
        ModificarConsecutivos       = d.ModificarConsecutivos,
        ModificarVINFechaBaja	    = d.ModificarVINFechaBaja,
        ModificarVINFechaPago	    = d.ModificarVINFechaPago,
	ModificarVINAccesorio	    = d.ModificarVINAccesorio,
        PVEditarNota		    = d.PVEditarNota,
        ModificarDescGlobalImporte  = d.ModificarDescGlobalImporte,
        ConsultarClientesOtrosAgentes=d.ConsultarClientesOtrosAgentes,
        ACLCUsoEspecifico           = d.ACLCUsoEspecifico,
        ACEditarTablaAmortizacion   = d.ACEditarTablaAmortizacion,
	PlantillasOffice	    = d.PlantillasOffice,
	ConfigPlantillasOffice	    = d.ConfigPlantillasOffice,
        BloquearArtMaterial	    = d.BloquearArtMaterial,
        InfoPath		    = d.InfoPath,
        InfoPathExe		    = d.InfoPathExe,
        ContrasenaNuncaExpira	    = d.ContrasenaNuncaExpira,
	FEA			    = d.FEA,
	FEACertificado		    = d.FEACertificado,
	FEALlave		    = d.FEALlave,
        AgregarProvExpress          = d.AgregarProvExpress,
        Menu			    = d.Menu,
        MenuAccesoTotal		    = d.MenuAccesoTotal,
        BloquearPDF		    = d.BloquearPDF,
        VerificarOrtografia	    = d.VerificarOrtografia,
        ContSinOrigen               = d.ContSinOrigen,
        UnidadOrganizacional	    = d.UnidadOrganizacional,
        ProyMov			    = d.ProyMov,
        CompraDevTodo		    = d.CompraDevTodo,
        BloquearWebContenido	    = d.BloquearWebContenido,
        BloquearWebHTML		    = d.BloquearWebHTML, 
        DBMailPerfil		    = d.DBMailPerfil,
        InformacionConfidencial	    = d.InformacionConfidencial,
        PerfilForma		    = d.PerfilForma,
        Licenciamiento		    = d.Licenciamiento,
        SituacionArea		    = d.SituacionArea,
        ModificarTipoImpuesto	= d.ModificarTipoImpuesto,
        -- 'CORTE'
        AfectarCORTE			= d.AfectarCORTE
   FROM Usuario a, Usuario d 
  WHERE a.Usuario = @UsuarioA AND d.Usuario = @UsuarioD

 UPDATE a
    SET --SincroC                         = a.SincroC,   
        CxcMovExpress 		     	= d.CxcMovExpress,
	CxpMovExpress		     	= d.CxpMovExpress,
	ModificarAnexosMovConcluidos 	= d.ModificarAnexosMovConcluidos,
	ControlAlmacenes		= d.ControlAlmacenes,
        ControlAlmacenesEnAlm		= d.ControlAlmacenesEnAlm,
	ControlListasPrecios		= d.ControlListasPrecios,
	ModificarObservaciones		= d.ModificarObservaciones,
	BloquearMonedaArtPrecio		= d.BloquearMonedaArtPrecio,
	BloquearMonedaArtCosto		= d.BloquearMonedaArtCosto,
	AfectarLote			= d.AfectarLote,
	CancelarLote			= d.CancelarLote,
	ContabilizarLote		= d.ContabilizarLote,
	GastoModificarProrrateo		= d.GastoModificarProrrateo,
	LimitarCompraLocal		= d.LimitarCompraLocal,
	VentaSugerirDisponible		= d.VentaSugerirDisponible,
	CompraSugerirDisponible		= d.CompraSugerirDisponible,
	Digitalizar			= d.Digitalizar,
	AutorizarProdAvances		= d.AutorizarProdAvances,
	ModificarProdCostosAd		= d.ModificarProdCostosAd,
	ModificarClienteBackOrder	= d.ModificarClienteBackOrder,
        InvFisicoAlmacen		= d.InvFisicoAlmacen,
        PedidoGenerarOT			= d.PedidoGenerarOT,
        PedidoGenerarOTAbrir            = d.PedidoGenerarOTAbrir,
        BloquearMaestrosPersonal	= d.BloquearMaestrosPersonal, 
        GastosPV			= d.GastosPV,
        CompraGenerarOrdenesAlProcesar	= d.CompraGenerarOrdenesAlProcesar,
        GastosEditarDeducible		= d.GastosEditarDeducible,
        PlanEditarOrdenes		= d.PlanEditarOrdenes,
	TraspasarMovimientos		= d.TraspasarMovimientos,
        BloquearAltaExpressPersonal     = d.BloquearAltaExpressPersonal,
        CancelarEmbarquesExplorador	= d.CancelarEmbarquesExplorador,
        OcultarDineroCtaDineroSaldo     = d.OcultarDineroCtaDineroSaldo,
        RecibirDemasSinLimites		= d.RecibirDemasSinLimites,
        ModificarFactorMovTipo          = d.ModificarFactorMovTipo,
        BloquearListaMateriales		= d.BloquearListaMateriales,
        VINTransferirComponentes	= d.VINTransferirComponentes,
        ModificarEstatusCuotaCx		= d.ModificarEstatusCuotaCx,
        ModificarGestionAgenda		= d.ModificarGestionAgenda,
        AgendaAccesoOtrosModulos	= d.AgendaAccesoOtrosModulos,
		--BUG22169
		InterfazExentus             = d.InterfazExentus,
		AccesoInterfazExentus       = d.AccesoInterfazExentus
   FROM UsuarioCfg2 a, UsuarioCfg2 d 
  WHERE a.Usuario = @UsuarioA AND d.Usuario = @UsuarioD

  EXEC xpCopiarUsuarioCfg @UsuarioD, @UsuarioA

  /* Se integra planograma WMS */
  UPDATE a
       SET a.vic_VerPlanoGramaDiseno        = d.vic_VerPlanoGramaDiseno,
           a.vic_VerPlanoGramaProduccion    = d.vic_VerPlanoGramaProduccion,
           a.vic_CopiarAccionesPlanoGrama   = d.vic_CopiarAccionesPlanoGrama,
           a.vic_ActualizarPlanoGrama       = d.vic_ActualizarPlanoGrama,
           a.vic_EliminarPlanoGrama         = d.vic_EliminarPlanoGrama,
           a.vic_AccionesPlanoGrama         = d.vic_AccionesPlanoGrama,
           a.VicAgregaCondic                = d.VicAgregaCondic,
           a.VicActualizaCondic             = d.VicActualizaCondic,
           a.VicInactivaCondic              = d.VicInactivaCondic,
           a.VicEliminaCondic               = d.VicEliminaCondic
      FROM Usuario a, Usuario d
     WHERE a.Usuario = @UsuarioA AND d.Usuario = @UsuarioD
    
    IF NOT EXISTS(SELECT 1 FROM vic3DescUsuarioCarpeta u WHERE u.Usuario = @UsuarioA)
    BEGIN 
        INSERT vic3DescUsuarioCarpeta (
               Usuario  , Contrato, Generales, FirFisica, Fiador, Fianza, Fechas, CondRenta, CondVenta, CondServicio, Condiciones, Relaciones, Minutas, Solicitudes, Tramites, Prorrogas, Caracteristicas, Documento, Tareas, Comentarios, CondContrac, Locales, Extra)
        SELECT @UsuarioA,        0,         0,         0,      0,      0,      0,         0,         0,            0,           0,          0,       0,           0,        0,         0,               0,         0,      0,           0,           0,       0,     0
    END 
    
    UPDATE a
       SET a.Contrato				= b.Contrato,
           a.Generales				= b.Generales,
           a.FirFisica				= b.FirFisica,
           a.Fiador					= b.Fiador,
           a.Fianza					= b.Fianza,
           a.Fechas					= b.Fechas,
           a.CondRenta				= b.CondRenta,
           a.CondVenta				= b.CondVenta,
           a.CondServicio			= b.CondServicio,
           a.Condiciones			= b.Condiciones,
           a.Relaciones				= b.Relaciones,
           a.Minutas				= b.Minutas,
           a.Solicitudes			= b.Solicitudes,
           a.Tramites				= b.Tramites,
           a.Prorrogas				= b.Prorrogas,
           a.Caracteristicas		= b.Caracteristicas,
           a.Documento				= b.Documento,
           a.Tareas					= b.Tareas,
           a.Comentarios			= b.Comentarios,
           a.CondContrac			= b.CondContrac,
           a.Locales				= b.Locales,
           a.Extra					= b.Extra
      FROM vic3DescUsuarioCarpeta a, 
           vic3DescUsuarioCarpeta b
     WHERE a.Usuario = @UsuarioA 
       AND b.Usuario = @UsuarioD

  RETURN
END
GO

-- spCopiarUsuarioAcceso 'DEMO', 'CARLOS'
/************** spCopiarUsuarioAcceso *************/
if exists (select * from sysobjects where id = object_id('dbo.spCopiarUsuarioAcceso') and sysstat & 0xf = 4) drop procedure dbo.spCopiarUsuarioAcceso
GO
CREATE PROCEDURE spCopiarUsuarioAcceso
                   @UsuarioD    char(10),
                   @UsuarioA	char(10)
--//WITH ENCRYPTION
AS BEGIN


 UPDATE a
    SET --SincroC                         = a.SincroC,   
        MenuPrincipal 		     	= d.MenuPrincipal,
	MovsEdicion		     	= d.MovsEdicion,
	MovsConsulta		 	= d.MovsConsulta,
	MovsAutorizar			= d.MovsAutorizar,
	Reportes			= d.Reportes
   FROM UsuarioAcceso a, UsuarioAcceso d 
  WHERE a.Usuario = @UsuarioA AND d.Usuario = @UsuarioD

  IF @@ROWCOUNT= 0
    INSERT UsuarioAcceso 
          (Usuario,   MenuPrincipal, MovsEdicion, MovsConsulta, MovsAutorizar, Reportes)
    SELECT @UsuarioA, MenuPrincipal, MovsEdicion, MovsConsulta, MovsAutorizar, Reportes
      FROM UsuarioAcceso
     WHERE Usuario = @UsuarioD

  DELETE UsuarioMenuOpcion WHERE Usuario = @UsuarioA
  INSERT UsuarioMenuOpcion (
         Usuario,   Menu, Opcion, Estatus)
  SELECT @UsuarioA, Menu, Opcion, Estatus
    FROM UsuarioMenuOpcion
   WHERE Usuario = @UsuarioD

  DELETE UsuarioAccesoForma WHERE Usuario = @UsuarioA
  INSERT UsuarioAccesoForma (
         Usuario, Forma)
  SELECT @UsuarioA, Forma
    FROM UsuarioAccesoForma
   WHERE Usuario = @UsuarioD
   

  RETURN
END
GO

/************** spAsignarAcceso *************/
if exists (select * from sysobjects where id = object_id('dbo.spAsignarAcceso') and sysstat & 0xf = 4) drop procedure dbo.spAsignarAcceso
GO
CREATE PROCEDURE spAsignarAcceso
                   @ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal			int,
    @Usuario			char(10),
    @Empresa			char(5),
    @ModuloCambios		bit,
    @CambiarFechaTrabajoAcceso	bit,
    @EstacionTrabajo		int,	
    @Mensaje			varchar(255)

  SELECT @ModuloCambios = 0
  SELECT @EstacionTrabajo = EstacionTrabajo, @Sucursal = Sucursal, @Usuario = Usuario, @Empresa = Empresa FROM Acceso WHERE ID = @ID
/*
  IF NOT EXISTS(SELECT * FROM EstacionTrabajo WHERE EstacionTrabajo = @EstacionTrabajo)
    INSERT EstacionTrabajo (EstacionTrabajo, Empresa, Sucursal, Usuario) VALUES (@EstacionTrabajo, @Empresa, @Sucursal, @Usuario)
  ELSE BEGIN
    SELECT @Mensaje = 'La Estacion de Trabajo '+CONVERT(varchar, @EstacionTrabajo)+' en Uso. Usuario = '+RTRIM(@Usuario)+', Empresa = '+RTRIM(@Empresa)
    RAISERROR (@Mensaje,16,-1) 
  END
*/
  UPDATE Acceso 
     SET FechaRegistro = GETDATE()/*, Contrasena = NULL */
   WHERE ID = @ID

  UPDATE UsuarioSucursal
     SET Sucursal = @Sucursal,
         Empresa = @Empresa
   WHERE Usuario = @Usuario
  IF @@ROWCOUNT = 0
    INSERT UsuarioSucursal (Usuario, Sucursal, Empresa) VALUES (@Usuario, @Sucursal, @Empresa)

  SELECT @ModuloCambios = ISNULL(Cambios, 0),
         @CambiarFechaTrabajoAcceso = ISNULL(CambiarFechaTrabajoAcceso, 1)
    FROM EmpresaGral 
   WHERE Empresa = @Empresa

  IF @ModuloCambios = 0 AND @CambiarFechaTrabajoAcceso = 1
    EXEC spFechaTrabajo @Sucursal
 
  RETURN
END
GO

/********************* spDesAsignarAcceso **********************/
if exists (select * from sysobjects where id = object_id('dbo.spDesAsignarAcceso') and sysstat & 0xf = 4) drop procedure dbo.spDesAsignarAcceso
GO
CREATE PROCEDURE spDesAsignarAcceso
	@ID		INT
--//WITH ENCRYPTION
AS BEGIN
	DECLARE
		@EstacionTrabajo	INT 

	UPDATE Acceso SET FechaSalida = GETDATE() WHERE ID=@ID
	UPDATE AccesoMes SET FechaSalida = GETDATE() WHERE ID = @ID
  
	/*  SELECT @EstacionTrabajo = EstacionTrabajo FROM Acceso WHERE ID = @ID
	DELETE EstacionTrabajo WHERE EstacionTrabajo = @EstacionTrabajo*/
	RETURN
END
GO

-- spGrupoTrabajo 'Supervision'
/************** spGrupoTrabajo *************/
if exists (select * from sysobjects where id = object_id('dbo.spGrupoTrabajo') and sysstat & 0xf = 4) drop procedure dbo.spGrupoTrabajo
GO
CREATE PROCEDURE spGrupoTrabajo
			@GrupoTrabajo	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Multiple 	bit
  
  SELECT @Multiple = Multiple FROM GrupoTrabajo WHERE GrupoTrabajo = @GrupoTrabajo
  IF @Multiple = 1
    SELECT DISTINCT u.Usuario FROM Usuario u, GrupoTrabajoD g WHERE g.GrupoTrabajo = @GrupoTrabajo AND u.GrupoTrabajo = g.GrupoTrabajoD
  ELSE
    SELECT Usuario FROM Usuario WHERE GrupoTrabajo = @GrupoTrabajo
END
GO


/************** spR3 *************/
if exists (select * from sysobjects where id = object_id('dbo.spR3') and sysstat & 0xf = 4) drop procedure dbo.spR3
GO
CREATE PROCEDURE spR3
			@a1	float,
			@a2	float,
			@b1	float,
			@b2	float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @b2 = (@a2*@b1)/@a1
END
GO


/************** spSerieLoteRango *************/
if exists (select * from sysobjects where id = object_id('dbo.spSerieLoteRango') and sysstat & 0xf = 4) drop procedure dbo.spSerieLoteRango
GO
CREATE PROCEDURE spSerieLoteRango
			@Empresa	char(5),
			@Sucursal	int,
			@Modulo		char(5),
			@ID		int,
			@RenglonID	int,
			@Articulo	char(20),
			@SubCuenta	varchar(50),
			@SerieInicial	varchar(50),
			@Cantidad	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @a			int,
    @p			int,
    @d			int,
    @Consecutivo	int,
    @ConsecutivoSt	varchar(20),
    @SerieLote		varchar(50)

  SELECT @SubCuenta = ISNULL(NULLIF(@SubCuenta, '0'), '')
  SELECT @p = dbo.fnPosUltAlfa(@SerieInicial)	-- V539-21767 = 5
  SELECT @d = LEN(@SerieInicial) - @p

  SELECT @a = 1
  SELECT @Consecutivo = CONVERT(int, SUBSTRING(@SerieInicial, @p+1, @d))
  IF ISNULL(@Consecutivo, 0) = 0 SELECT @Consecutivo = 1
  WHILE @a<=@Cantidad
  BEGIN
    EXEC spLlenarCeros @Consecutivo, @d, @ConsecutivoSt OUTPUT
    SELECT @SerieLote = SUBSTRING(@SerieInicial, 1, @p) + @ConsecutivoSt
--    IF NOT EXISTS(SELECT * FROM SerieLoteMov WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Modulo = @Modulo AND ID = @ID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @SerieLote)
      INSERT SerieLoteMov (Empresa,  Sucursal,  Modulo,  ID,  RenglonID,  Articulo,  SubCuenta,  SerieLote,  Cantidad) 
                   VALUES (@Empresa, @Sucursal, @Modulo, @ID, @RenglonID, @Articulo, @SubCuenta, @SerieLote, 1) 
    SELECT @Consecutivo = @Consecutivo + 1, @a = @a + 1
  END  
END
GO


/************** spVencimientoDiaEspecifico *************/
if exists (select * from sysobjects where id = object_id('dbo.spVencimientoDiaEspecifico') and sysstat & 0xf = 4) drop procedure dbo.spVencimientoDiaEspecifico
GO
CREATE PROCEDURE spVencimientoDiaEspecifico
			@Fecha		datetime,
			@DiaEspecifico	int,
			@Vencimiento	datetime	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dias	int,
    @Dia	int,
    @Mes	int,
    @Ano	int

  SELECT @Mes = MONTH(@Fecha), @Ano = YEAR(@Fecha)
  EXEC spDiasMes @Mes, @Ano, @Dias OUTPUT
  IF @DiaEspecifico = 31 OR @DiaEspecifico > @Dias 
    SELECT @Dia = @Dias
  ELSE
    SELECT @Dia = @DiaEspecifico

  EXEC spIntToDateTime @Dia, @Mes, @Ano, @Vencimiento OUTPUT  
  RETURN
END
GO

/************** spMovFormaAnexo *************/
if exists (select * from sysobjects where id = object_id('dbo.spMovFormaAnexo') and sysstat & 0xf = 4) drop procedure dbo.spMovFormaAnexo
GO
CREATE PROCEDURE spMovFormaAnexo
			@Modulo		char(5),
			@ID		int,
			@Clave		varchar(100),
			@Nombre		varchar(100),
			@Tipo		varchar(20),
			@Datos		text		= NULL,
			@Usuario	char(10)	= NULL,
			@Eliminar	bit		= 0			
--//WITH ENCRYPTION
AS BEGIN
  IF @Eliminar = 1 
    UPDATE MovFormaAnexo 
       SET Datos = NULL,
           Usuario = @Usuario,
           UltimoCambio = GETDATE()
     WHERE Modulo = @Modulo AND ID = @ID AND Nombre = @Nombre
  ELSE BEGIN
    IF EXISTS(SELECT ID FROM MovFormaAnexo WHERE Modulo = @Modulo AND ID = @ID AND Nombre = @Nombre)
      UPDATE MovFormaAnexo 
         SET Clave = @Clave,
             Tipo = @Tipo,
             Datos = @Datos,
             Usuario = @Usuario,
             UltimoCambio = GETDATE()
       WHERE Modulo = @Modulo AND ID = @ID AND Nombre = @Nombre
    ELSE
      INSERT MovFormaAnexo (Modulo, ID, Nombre, Clave, Tipo, Datos, Usuario, UltimoCambio) VALUES (@Modulo, @ID, @Nombre, @Clave, @Tipo, @Datos, @Usuario, GETDATE())
  END
  RETURN
END
GO


-- spVerMovFormaAnexo 'VTAS', 63, 'Cotizacion'
/************** spVerMovFormaAnexo *************/
if exists (select * from sysobjects where id = object_id('dbo.spVerMovFormaAnexo') and sysstat & 0xf = 4) drop procedure dbo.spVerMovFormaAnexo
GO
CREATE PROCEDURE spVerMovFormaAnexo
			@Modulo		char(5),
			@ID		int,
			@Mov		varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  SELECT m.Clave, m.Nombre, m.Tipo, 'Icono' = CONVERT(int, 731), Usuario, UltimoCambio
    FROM MovFormaAnexo m
   WHERE m.Modulo = @Modulo AND m.ID = @ID AND Datos IS NOT NULL
  UNION ALL
  SELECT fa.Clave, fa.Nombre, fa.Tipo, 'Icono' = CONVERT(int, 732), 'Usuario' = CONVERT(varchar(10), NULL), 'UltimoCambio' = CONVERT(datetime, NULL)
    FROM MovTipoFormaAnexo fa
   WHERE fa.Modulo = @Modulo AND fa.Mov = @Mov AND fa.Nombre NOT IN (SELECT m.Nombre FROM MovFormaAnexo m WHERE m.Modulo = @Modulo AND m.ID = @ID AND Datos IS NOT NULL)

  ORDER BY Nombre
  RETURN
END
GO


/*************** spMovTipoInstruccion *******************/
if exists (select * from sysobjects where id = object_id('dbo.spMovTipoInstruccion') and type = 'P') drop procedure dbo.spMovTipoInstruccion
GO
CREATE PROCEDURE spMovTipoInstruccion
			@Modulo 	char(5), 
			@Mov 		varchar(20), 
			@Instruccion 	varchar(50),
			@Valor		varchar(255) 	OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @idoc	int,
    @doc	varchar(8000),
    @path	varchar(255),
    @Resultado	varchar(255)

  SELECT @Resultado = NULL
  SELECT @doc = CONVERT(varchar(8000), Instrucciones) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  IF NULLIF(RTRIM(@doc), '') IS NOT NULL
  BEGIN
    EXEC sp_xml_preparedocument @idoc OUTPUT, @doc
    IF EXISTS(SELECT * FROM OPENXML (@idoc, '/MovTipo', 1) WITH (Modulo varchar(5), Mov varchar(20)) WHERE Modulo = @Modulo AND Mov = @Mov)
    BEGIN
      SELECT @path = '/MovTipo/'+@Instruccion  
      SELECT @Resultado = RTRIM(Valor)
        FROM OPENXML (@idoc, @Path, 1)
               WITH (Valor  varchar(255))
      IF @@ROWCOUNT > 0 SELECT @Valor = @Resultado
    END ELSE SELECT @Ok = 10480, @OkRef = @Instruccion
    EXEC sp_xml_removedocument @idoc
  END

  RETURN
END
GO

/*
declare
  @valor varchar(255),
  @Ok	int,
  @OkRef varchar(255)
exec spMovTipoInstruccion 'VTAS', 'Factura', 'AfectarCostos', @Valor OUTPUT, @Ok OUTPUT, @okRef OUTPUT
select @valor, @Ok, @OkRef
*/


/*************** spMovTipoInstruccionBit *******************/
if exists (select * from sysobjects where id = object_id('dbo.spMovTipoInstruccionBit') and type = 'P') drop procedure dbo.spMovTipoInstruccionBit
GO
CREATE PROCEDURE spMovTipoInstruccionBit
			@Modulo 	char(5), 
			@Mov 		varchar(20), 
			@Instruccion 	varchar(50),
			@Valor		bit	 	OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ValorSt	varchar(255)

  SELECT @ValorSt = CONVERT(varchar, @Valor)
  EXEC spMovTipoInstruccion @Modulo, @Mov, @Instruccion, @ValorSt OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  SELECT @Valor = CONVERT(bit, @ValorSt)

  RETURN
END
GO


/*
declare
  @valor bit,
  @Ok	int,
  @OkRef varchar(255)
SELECT @valor = 1
exec spMovTipoInstruccion 'VTAS', 'Factura', 'AfectarCostos', @Valor OUTPUT, @Ok OUTPUT, @okRef OUTPUT
select @valor, @Ok, @OkRef
*/

-- spSysTablaReg
-- select * from SysTablaReg
/*************** spSysTablaReg **************/
if exists (select * from sysobjects where id = object_id('dbo.spSysTablaReg') and type = 'p') drop procedure dbo.spSysTablaReg
GO
CREATE PROCEDURE dbo.spSysTablaReg
        			@Nombre         sysname         = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Tabla              nvarchar(50),
    @Instruccion        nvarchar(1000),
    @i                  int,
    @Tipo               varchar(50),
    @Fecha		datetime

  SELECT @Fecha = GETDATE()
  DECLARE crTablas CURSOR LOCAL FOR
    SELECT name
      FROM sysobjects 
     WHERE type = 'u'
       AND name = ISNULL(@Nombre, name)

  OPEN crTablas
  FETCH NEXT FROM crTablas INTO @Tabla
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      SELECT @Instruccion = '', @i = 0, @Tipo = NULL
      SELECT @Instruccion = N'SELECT @i = COUNT(*) FROM ' + RTRIM(@Tabla)
      EXEC sp_ExecuteSQL @Instruccion, N'@i int output',@i OUTPUT
      UPDATE SysTablaReg
         SET Registros = @i,
             Fecha = @Fecha
       WHERE SysTabla = @Tabla
      IF @@ROWCOUNT = 0
        INSERT SysTablaReg (SysTabla, Registros, Fecha) VALUES (@Tabla, @i, @Fecha)
    END
    FETCH NEXT FROM crTablas INTO @Tabla
  END
  CLOSE crTablas
  DEALLOCATE crTablas
 
  RETURN
END
GO

-- spFormaPago 'American Express'
/**************** spFormaPago ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaPago') and type = 'P') drop procedure dbo.spFormaPago
GO             
CREATE PROCEDURE spFormaPago
		  	@Tipo	varchar(50)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Tipo = NULLIF(NULLIF(RTRIM(@Tipo), ''), '0')
  IF @Tipo IS NULL
    SELECT FormaPago FROM FormaPago ORDER BY Orden
  ELSE
    SELECT fp.FormaPago 
      FROM FormaPago fp 
      JOIN FormaPagoTipo t ON t.Tipo = @Tipo 
      JOIN FormaPagoTipoD d ON d.Tipo = t.Tipo AND d.FormaPago = fp.FormaPago
     ORDER BY fp.Orden
  RETURN
END
GO

-- 9150
/**************** fnFormaPagoAcceso ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaPagoAcceso' AND type = 'fn') DROP FUNCTION fnFormaPagoAcceso
GO
CREATE FUNCTION fnFormaPagoAcceso(
				@Empresa		varchar(5),
				@FormaPago		varchar(50), 
				@Modulo			varchar(5), 
				@Mov			varchar(20), 
				@Usuario		varchar(10), 
				@Campo			varchar(20),
				@CobroIntegrado	bit,
				@NivelAcceso	bit,
				@NivelAccesoEsp	bit)
RETURNS bit
AS
BEGIN
  DECLARE @Valor			bit

  SELECT @Valor = 0
  
  IF @NivelAcceso = 1 AND @NivelAccesoEsp = 1
  BEGIN
    IF NOT EXISTS(SELECT FormaPago FROM FormaPagoAcceso WHERE FormaPago = @FormaPago AND ISNULL(Nivel, '') <> '(Todos)')
      SELECT  @Valor = 1
    ELSE
      IF EXISTS(SELECT FormaPago FROM FormaPagoAcceso WHERE FormaPago = @FormaPago AND Nivel IN(@Usuario, '(Todos)'))
        SELECT @Valor = 1
  END
  ELSE IF @NivelAcceso = 1 AND @NivelAccesoEsp = 0
    SELECT @Valor = 1
  ELSE IF @NivelAcceso = 0
    SELECT @Valor = 1    
    
  RETURN @Valor
END
GO

/**************** fnFormaPagoMovEsp ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaPagoMovEsp' AND type = 'fn') DROP FUNCTION fnFormaPagoMovEsp
GO
CREATE FUNCTION fnFormaPagoMovEsp(
				@Empresa		varchar(5),
				@FormaPago		varchar(50), 
				@Modulo			varchar(5), 
				@Mov			varchar(20), 
				@Usuario		varchar(10), 
				@Campo			varchar(20),
				@CobroIntegrado	bit,
				@NivelAcceso	bit,
				@NivelAccesoEsp	bit)
RETURNS bit
AS
BEGIN
  DECLARE @Valor				bit,
		  @CfgCobroIntegrado	bit
		  
  SELECT @CfgCobroIntegrado = CobroIntegrado FROM FormaPago WHERE FormaPago = @FormaPago

  SELECT @Valor = 0

  IF NOT EXISTS(SELECT FormaPago FROM FormaPagoMovEsp WHERE FormaPago = @FormaPago AND Modulo = @Modulo)
    SELECT @Valor = 1
  ELSE IF EXISTS(SELECT FormaPago FROM FormaPagoMovEsp WHERE FormaPago = @FormaPago AND Modulo = @Modulo)
  BEGIN
    IF @Campo <> '(Forma Pago)'
    BEGIN
      IF EXISTS(SELECT FormaPago FROM FormaPagoMovEsp WHERE FormaPago = @FormaPago AND Modulo = @Modulo AND Mov IN(@Mov, '(Todos)') AND ConDesglose IN(@Campo, '(Todos)'))
        SELECT @Valor = 1
      ELSE IF @Campo = '(Forma Pago 1)' AND ISNULL(@CobroIntegrado, 0) = 1
        IF EXISTS(SELECT FormaPago FROM FormaPagoMovEsp WHERE FormaPago = @FormaPago AND Modulo = @Modulo AND Mov IN(@Mov, '(Todos)') AND ConDesglose IN(@Campo, '(Todos)', 'Si'))
          SELECT @Valor = 1
    END
    ELSE IF @Campo = '(Forma Pago)'
      IF EXISTS(SELECT FormaPago FROM FormaPagoMovEsp WHERE FormaPago = @FormaPago AND Modulo = @Modulo AND Mov IN(@Mov, '(Todos)'))
        SELECT @Valor = 1
      
    IF ISNULL(@CobroIntegrado, 0) = 1 AND ISNULL(@CfgCobroIntegrado, 0) = 0
      SELECT @Valor = 0
    END  
    
  RETURN @Valor
END
GO

/**************** fnFormaPagoAyudaCaptura ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaPagoAyudaCaptura' AND type = 'TF') DROP FUNCTION fnFormaPagoAyudaCaptura
GO
CREATE FUNCTION fnFormaPagoAyudaCaptura(@Empresa varchar(5), @Modulo varchar(5), @Mov varchar(20), @Usuario varchar(10), @Campo varchar(20), @CobroIntegrado bit, @Tipo varchar(50))
RETURNS @Resultado TABLE (FormaPago varchar(50))
AS
BEGIN
  DECLARE @NivelAcceso		bit,
		  @NivelAccesoEsp	bit
		  
  SELECT @NivelAcceso	 = ISNULL(NivelAcceso, 0),
		 @NivelAccesoEsp = ISNULL(NivelAccesoEsp, 0)
    FROM EmpresaGral
   WHERE Empresa = @Empresa
   
  SELECT @Tipo = NULLIF(NULLIF(RTRIM(@Tipo), ''), '0')
  
  IF @Tipo IS NULL
    INSERT INTO @Resultado(
		    FormaPago) 
     SELECT fp.FormaPago
       FROM FormaPago fp
      WHERE dbo.fnFormaPagoMovEsp(@Empresa, fp.FormaPago, @Modulo, @Mov, @Usuario, @Campo, @CobroIntegrado, @NivelAcceso, @NivelAccesoEsp) = 1
        AND dbo.fnFormaPagoAcceso(@Empresa, fp.FormaPago, @Modulo, @Mov, @Usuario, @Campo, @CobroIntegrado, @NivelAcceso, @NivelAccesoEsp) = 1
      ORDER BY fp.Orden
  ELSE
    INSERT INTO @Resultado(
		    FormaPago) 
     SELECT fp.FormaPago
       FROM FormaPago fp 
       JOIN FormaPagoTipo t ON t.Tipo = @Tipo 
       JOIN FormaPagoTipoD d ON d.Tipo = t.Tipo AND d.FormaPago = fp.FormaPago
      WHERE dbo.fnFormaPagoMovEsp(@Empresa, fp.FormaPago, @Modulo, @Mov, @Usuario, @Campo, @CobroIntegrado, @NivelAcceso, @NivelAccesoEsp) = 1
        AND dbo.fnFormaPagoAcceso(@Empresa, fp.FormaPago, @Modulo, @Mov, @Usuario, @Campo, @CobroIntegrado, @NivelAcceso, @NivelAccesoEsp) = 1       
      ORDER BY fp.Orden  
  RETURN
END
GO

/**************** fnFormaPagoVerificar ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaPagoVerificar' AND type = 'fn') DROP FUNCTION fnFormaPagoVerificar
GO
CREATE FUNCTION fnFormaPagoVerificar(
				@Empresa		varchar(5),
				@FormaPago		varchar(50), 
				@Modulo			varchar(5), 
				@Mov			varchar(20), 
				@Usuario		varchar(10), 
				@Campo			varchar(20),
				@CobroIntegrado	bit)
RETURNS bit
AS
BEGIN
  DECLARE @Valor	bit
  
  IF NOT EXISTS(SELECT FormaPago FROM dbo.fnFormaPagoAyudaCaptura(@Empresa, @Modulo, @Mov, @Usuario, @Campo, @CobroIntegrado, '') WHERE FormaPago = @FormaPago)
    SELECT @Valor = 0
  ELSE
    SELECT @Valor = 1

  RETURN @Valor
END
GO


/*
declare @llave varchar(8000)
exec spTableLlavePrimariaOD 'VentaD', 'x', 'y', @llave output
select @llave
*/
/**************** spTableLlavePrimariaOD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTableLlavePrimariaOD') and type = 'P') drop procedure dbo.spTableLlavePrimariaOD
GO             
CREATE PROCEDURE spTableLlavePrimariaOD
		  	@Tabla		varchar(100),
			@Origen		varchar(100),
			@Destino	varchar(100),
			@Llave		varchar(8000) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Campo	varchar(255)

  SELECT @Llave = ''
  DECLARE crLlave CURSOR LOCAL FOR
  SELECT syscolumns.name
    FROM sysobjects
    JOIN syscolumns 
    JOIN sysindexes ON syscolumns.id=sysindexes.id
    JOIN sysindexkeys ON sysindexes.id = sysindexkeys.id
     AND sysindexes.indid=sysindexkeys.indid			
	  ON sysobjects.id = syscolumns.id
   WHERE sysindexes.status & 0x800 = 0x800
     AND syscolumns.colid=sysindexkeys.colid
     AND sysobjects.name=@Tabla
  OPEN crLlave
  FETCH NEXT FROM crLlave INTO @Campo
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@Campo), '') IS NOT NULL
    BEGIN
      IF @Llave <> '' SELECT @Llave = @Llave +' AND '
      SELECT @Llave = @Llave + @Origen+'.'+@Campo+' = '+@Destino+'.'+@Campo
    END
    FETCH NEXT FROM crLlave INTO @Campo
  END
  CLOSE crLlave
  DEALLOCATE crLlave

  RETURN
END
GO


/**************** spArchivoEnXML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArchivoEnXML') and type = 'P') drop procedure dbo.spArchivoEnXML
GO
CREATE PROCEDURE spArchivoEnXML
			@Archivo	varchar(max),
			@XML		xml		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	
    @SQL	nvarchar(max)
  SELECT @SQL = 'SELECT @XML = CONVERT(xml, BulkColumn, 2) FROM OPENROWSET(BULK ' + CHAR(39) + @Archivo + CHAR(39) + ', SINGLE_BLOB) AS Document'
  EXEC sp_executesql @SQL, N'@XML xml OUTPUT', @XML OUTPUT
END
go

/*
Declare @ISOweek int
  exec spISOweek '30/12/2003',@ISOweek OUTPUT
  select @ISOweek
*/
/********** spISOweek *********/
if exists (select * from sysobjects where id =object_id('dbo.spISOweek') and type = 'P') drop procedure dbo.spISOweek
GO  
CREATE PROCEDURE spISOweek
  @DATE datetime,
  @ISOweek int = 0 OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @PrimerDia	int

  SELECT @PrimerDia = @@DATEFIRST 
  SET DATEFIRST 1

  SET @ISOweek= DATEPART(wk,@DATE)+ 1 -DATEPART(wk,CAST(DATEPART(yy,@DATE) as CHAR(4))+'0104')
--Special cases: Jan 1-3 may belong to the previous year
  IF (@ISOweek=0) 
    SET @ISOweek=dbo.ISOweek(CAST(DATEPART(yy,@DATE)-1 AS CHAR(4))+'12'+ CAST(24+DATEPART(DAY,@DATE) AS CHAR(2)))+1
--Special case: Dec 29-31 may belong to the next year
  IF ((DATEPART(mm,@DATE)=12) AND ((DATEPART(dd,@DATE)-DATEPART(dw,@DATE))>= 28))
  SET @ISOweek=1
  SET DATEFIRST @PrimerDia
END
GO
--JGD 06Julio2011 Ticket 4867
/********** spPeriodoDACatorcena *********/
if exists (select * from sysobjects where id =object_id('dbo.spPeriodoDACatorcena') and type = 'P') drop procedure dbo.spPeriodoDACatorcena
GO  
CREATE PROCEDURE spPeriodoDACatorcena
	@Fecha datetime,
	@FechaA	datetime	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @Salida int,
        @SemanaIF bit,
        @UltimoDia	int,
        @DiaNombre varchar(10),
        @Dia int,
        @Mes		int,
        @Ano		int,
        @Dias int

  SELECT @UltimoDia = @@DATEFIRST 
  SET DATEFIRST 7

  SELECT @Dia = DATEPART(day, @Fecha),
         @Mes = DATEPART(month, @Fecha),
         @Ano = DATEPART(year, @Fecha)

  EXEC spISOweek @Fecha, @Salida OUTPUT

  SELECT @SemanaIF = @Salida%2

  IF @SemanaIF = 1
  BEGIN
    SELECT @DiaNombre = dbo.fnDiaSemanaEspanol (@Fecha)
    IF @DiaNombre = 'Lunes' SELECT @Dia = 1 --Inicio 1ra Semana de la Catorcena
    IF @DiaNombre = 'Martes' SELECT @Dia = 2
    IF @DiaNombre = 'Miercoles' SELECT @Dia = 3
    IF @DiaNombre = 'Jueves' SELECT @Dia = 4   
    IF @DiaNombre = 'Viernes' SELECT @Dia = 5
    IF @DiaNombre = 'Sabado' SELECT @Dia = 6
    IF @DiaNombre = 'Domingo' SELECT @Dia = 7

    SELECT @Dia = 14 - @Dia
    SELECT @FechaA = DATEADD(day,@Dia,@Fecha)    
  END
  IF @SemanaIF = 0
  BEGIN
    SELECT @DiaNombre = dbo.fnDiaSemanaEspanol (@Fecha)
    IF @DiaNombre = 'Lunes' SELECT @Dia = 8 --Inicio 2da Semana de la Catorcena
    IF @DiaNombre = 'Martes' SELECT @Dia = 9
    IF @DiaNombre = 'Miercoles' SELECT @Dia = 10
    IF @DiaNombre = 'Jueves' SELECT @Dia = 11   
    IF @DiaNombre = 'Viernes' SELECT @Dia = 12
    IF @DiaNombre = 'Sabado' SELECT @Dia = 13
    IF @DiaNombre = 'Domingo' SELECT @Dia = 14

    SELECT @Dia = 14 - @Dia
    SELECT @FechaA = DATEADD(day,@Dia,@Fecha)

  END
  SET DATEFIRST @UltimoDia
RETURN
END
GO
--Fin JGD 06Julio2011 Ticket 4867

/**************** xpImportarPDA_ML ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpImportarPDA_ML') and type = 'P') drop procedure dbo.xpImportarPDA_ML
GO
CREATE PROCEDURE xpImportarPDA_ML
        @Empresa char(5),
        @Usuario char(10),
        @IDPDA    int,
        @Output int OUTPUT
AS  
BEGIN  
DECLARE  
       @ID              int,
       @Modulo          char(10),
       @Movimiento      char(20),
       @Concepto        char(50),
       @Aplica          char(20),
       @AplicaID        char(20),
       @Articulo        char(20),
       @Cliente         char(10),
       @Almacen         char(10),
       @Moneda          char(10),
       @TC              float,
       @Cantidad        float,
       @Inventario      float,
       @Precio          float,
       @Impuesto        money,
       @Descuento       money,
       @Fecha           datetime,
       @TipoPago        char(50),   -- Gastos
       @Total           money,  -- Gastos y Cobranza
       @Condicion       char(50),
       @Importe         money,
       @FormaPago1      char(50),
       @Importe1        money,
       @Referencia1     char(50),
       @FormaPago2      char(50),
       @Importe2        money,
       @Referencia2     char(50),
       @FormaPago3      char(50),
       @Importe3        money,
       @Referencia3     char(50),
       @Agente          char(10),
       @DiasEntrega     int,
       @TipoDias        char(20),
       @DiasHabiles     char(20),
       @FechaRequerida  datetime,
       @Sucursal        int,
       @Renglon         float,
       @Unidad          char(10),
       @MonedaPrecio    char(10),
       @TCMonedaPrecio  float,
       @DiasCondicion   int,
       @MesesCondicion  int,
       @Caja            char(10),
       @Costo           money,
       @CostoDevolucion char(50),
       @Vencimiento     datetime,
       @Factor          int,
       @CantidadFactor  float,
       @Descuento_Global      char(50),
       @Descuento_Global_Cant money
  
  
  SELECT TOP 1 @Modulo = Modulo
    FROM MovimientosPDA
   WHERE Usuario = @Usuario AND ID = @IDPDA
   
  DECLARE crMovimientosPDA CURSOR FOR
   SELECT Concepto, Aplica, AplicaID, Articulo, Cliente, Cantidad, Inventario, Precio, Impuesto, Descuento, Total
     FROM MovimientosPDA  
    WHERE Usuario = @Usuario AND ID = @IDPDA  
      AND Movimiento not in ('Contado', 'Cobro')  
   
  SELECT @Renglon = 0
  IF @Modulo = 'VTAS'
  BEGIN
    SELECT TOP 1 @Cliente = Cliente, @Modulo = Modulo, @Movimiento = Movimiento, @Condicion = Tipo_Pago,
                 @Fecha= convert(Smalldatetime,Fecha,102), @Descuento_Global = Descuento_Global, -- Se incluyo Smalldatetime
                 @Descuento_Global_Cant = Descuento_Global_Cant, @Inventario = Inventario,
                 @importe = Total, @impuesto = Impuesto -- Add Importe e Impuestos
      FROM MovimientosPDA
     WHERE Usuario = @Usuario AND ID = @IDPDA
       AND Movimiento <> 'Contado'
         
    SELECT @Moneda = DefMoneda FROM Cte WHERE Cliente = @Cliente
    SELECT @TC = TipoCambio FROM Mon WHERE Moneda = @Moneda
    SELECT @Agente = DefAgente, @Almacen = DefAlmacen, @Sucursal = Sucursal FROM Usuario WHERE Usuario = @Usuario
     
    IF @Movimiento = 'Pedido'
    BEGIN
      SELECT @DiasEntrega = VentaTEEstandar, @TipoDias = VentaTEEstandarTipoDias
        FROM EmpresaCfg WHERE Empresa = @Empresa
         
      SELECT @DiasHabiles = DiasHabiles FROM EmpresaGral WHERE Empresa = @Empresa
      EXEC spAgregarDias @Fecha, @DiasEntrega, @DiasHabiles, @TipoDias, 0, @FechaRequerida OUTPUT, 0
    END
     
    -- Insertar encabezado de Ventas
    INSERT INTO Venta(Empresa, Mov,  FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Directo, Cliente, Almacen, Condicion, Agente, FechaRequerida, Sucursal, SucursalOrigen, OrigenTipo, Referencia, Descuento, DescuentoGlobal, Importe, Impuestos, Concepto)
    -- Se le agregó Importe, Impuestos y Concepto
    VALUES (@Empresa, @Movimiento, @Fecha, @Moneda, @TC, @Usuario, 'SINAFECTAR', 1, @Cliente, @Almacen, @Condicion, @Agente, @FechaRequerida, @Sucursal, @Sucursal, 'PDA', @IDPDA, @Descuento_Global, @Descuento_Global_Cant, @Importe, @impuesto, 'Rutas')
    SELECT @ID = SCOPE_IDENTITY()
     
    IF EXISTS(SELECT * FROM MovimientosPDA WHERE Usuario = @Usuario AND ID = @IDPDA AND Movimiento = 'Contado')
    BEGIN
      SELECT @FormaPago1 = RTRIM(NULLIF(Forma1,'')),
             @Importe1 = ISNULL(Importe1,0),
             @Referencia1 = NULLIF(Referencia1,''),
             @FormaPago2 = RTRIM(NULLIF(Forma2,'')),
             @Importe2 = ISNULL(Importe2,0),
             @Referencia2 = NULLIF(Referencia2,''),
             @FormaPago3 = RTRIM(NULLIF(Forma3,'')),
             @Importe3 = ISNULL(Importe3,0),
             @Referencia3 = NULLIF(Referencia3,'')
        FROM MovimientosPDA
       WHERE Usuario = @Usuario AND ID = @IDPDA AND Movimiento = 'Contado'
        
      SELECT @Caja = DefCtaDinero FROM Usuario WHERE Usuario = @Usuario
        
      INSERT INTO VentaCobro(ID, Importe1, Importe2, Importe3, FormaCobro1, FormaCobro2, FormaCobro3, Referencia1, Referencia2, Referencia3, CtaDinero, Cajero)
      VALUES(@ID, @Importe1, @Importe2, @Importe3, @FormaPago1, @FormaPago2, @FormaPago3, @Referencia1, @Referencia2, @Referencia3, @Caja, @Agente)
    END
    ELSE
    BEGIN
      
      EXEC spCalcularVencimiento 'CXC', @Empresa, @Cliente, @Condicion, @Fecha, @Vencimiento OUTPUT, NULL, NULL          -- select @cliente, @condicion, @fecha, @vencimiento
      UPDATE Venta SET Vencimiento = @Vencimiento WHERE ID = @ID
    
    END
  END
    
  IF @Modulo = 'CXC'
  BEGIN
    
    SELECT TOP 1 @Cliente = Cliente, @Modulo = Modulo, @Movimiento = Movimiento, @Condicion = Tipo_Pago,
                 @Fecha= convert(Smalldatetime,Fecha,102), @Importe = Total, @Inventario = Inventario,  -- Se incluyo SmallDataTime
                 @FormaPago1 = NULLIF(Forma1,''), @Importe1 = ISNULL(Importe1,0), @Referencia1 = NULLIF(Referencia1,''),
                 @FormaPago2 = NULLIF(Forma2,''), @Importe2 = ISNULL(Importe2,0), @Referencia2 = NULLIF(Referencia2,''),
                 @FormaPago3 = NULLIF(Forma3,''), @Importe3 = ISNULL(Importe3,0), @Referencia3 = NULLIF(Referencia3,'')
      FROM MovimientosPDA
     WHERE Usuario = @Usuario AND ID = @IDPDA
       AND Movimiento = 'Cobro'
         
    SELECT @Moneda = DefMoneda FROM Cte WHERE Cliente = @Cliente
    SELECT @TC = TipoCambio FROM Mon WHERE Moneda = @Moneda
         
--         SELECT @Moneda = 'Pesos'
    SELECT @Agente = DefAgente, @Almacen = DefAlmacen, @Sucursal = Sucursal, @Caja = DefCtaDinero
      FROM Usuario WHERE Usuario = @Usuario
         
    INSERT INTO Cxc(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Cliente, ClienteMoneda, ClienteTipoCambio, CtaDinero, Importe, AplicaManual, ConDesglose, FormaCobro1, FormaCobro2, FormaCobro3, Importe1, Importe2, Importe3, Referencia1, Referencia2, Referencia3, Agente, Sucursal, Sucursalorigen)
             VALUES(@Empresa, @Movimiento, @Fecha, @Moneda, @TC, @usuario, 'SINAFECTAR', @Cliente, @Moneda, @TC, @Caja, @Importe, 1, 1, @FormaPago1, @FormaPago2, @FormaPago3, @Importe1, @Importe2, @Importe3, @Referencia1, @Referencia2, @Referencia3, @Agente, @Sucursal, @Sucursal)
    SELECT @ID = SCOPE_IDENTITY()
  END
      
  OPEN crMovimientosPDA
  FETCH NEXT FROM crMovimientosPDA INTO @Concepto, @Aplica, @AplicaID, @Articulo, @Cliente, @Cantidad, @Inventario, @Precio, @Impuesto, @Descuento, @Total
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @Modulo = 'VTAS'
    BEGIN
      SELECT @Renglon = @Renglon + 2048
      SELECT @Unidad = Unidad, @MonedaPrecio = MonedaPrecio, @Impuesto = Impuesto1
        FROM Art
       WHERE Articulo = @Articulo
           
      SELECT @TCMonedaPrecio = TipoCambio FROM Mon WHERE Moneda = @MonedaPrecio
           
      IF @Movimiento = 'Devolucion Venta'
      BEGIN
        SELECT @CostoDevolucion = SugerirCostoDev FROM EmpresaCfg WHERE Empresa = @Empresa
        EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, '0', @Unidad, @CostoDevolucion, @Moneda, @TC, @Costo OUTPUT, 0
      END
           
-- El sig codigo funciona solo para los facotres           
      SELECT @CantidadFactor = @Cantidad
      SELECT @Factor = VentaFactorDinamico FROM EmpresaCfg2 WHERE (Empresa=@Empresa)
           
      IF @Factor = 1
      BEGIN

        SELECT @CantidadFactor = ArtUnidad.Factor
          FROM Art, ArtUnidad ArtUnidad
         WHERE Art.Articulo = ArtUnidad.Articulo
           AND Art.Unidad = ArtUnidad.Unidad
           AND ((Art.Articulo=@Articulo) AND (Art.Estatus='Alta'))  

      END
        
      INSERT INTO  VentaD(ID, Renglon, RenglonID, RenglonTipo, Cantidad, Almacen, Articulo, Precio, Impuesto1, Unidad, Factor, CantidadInventario, FechaRequerida, Agente, Sucursal, SucursalOrigen, PrecioMoneda, PrecioTipoCambio, Costo, DescuentoLinea)
      VALUES(@ID, @Renglon, 1, 'N', @Cantidad, @Almacen, @Articulo, @Precio, @Impuesto,                        @Unidad, @Inventario, @Cantidad, @FechaRequerida, @Agente, @Sucursal, @Sucursal, @MonedaPrecio, @TCMonedaPrecio, @Costo, @Descuento)
           
    END
         
    IF @Modulo = 'CXC'
    BEGIN
      SELECT @Renglon = @Renglon + 2048
           
      INSERT INTO CxcD(ID, Renglon, Importe, Aplica, AplicaID)
      VALUES(@ID, @Renglon, @Total, @Aplica, @AplicaID)
    END
    FETCH NEXT FROM crMovimientosPDA INTO @Concepto, @Aplica, @AplicaID, @Articulo, @Cliente, @Cantidad, @Inventario, @Precio, @Impuesto, @Descuento, @Total
  END
  CLOSE crMovimientosPDA
  DEALLOCATE crMovimientosPDA
       
--EXEC spAfectar @Modulo, @ID, 'SIN AFECTAR', 'TODO', NULL, @Usuario         
  IF @ID is null  set @ID=0
  SET @Output=@ID
  RETURN
 END
 GO
 
 /**************** spPocket_ML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPocket_ML') and type = 'P') drop procedure dbo.spPocket_ML
GO
CREATE PROCEDURE spPocket_ML
						@Accion     Varchar(30) = '',
                        @Dato       Varchar(50) = '',
                        @Dato2      Varchar(50) = '',
                        @Dato3      Varchar(50) = '',
                        @Dato4      Varchar(50) = '',
                        @Dato5      Varchar(50) = ''
WITH ENCRYPTION
AS BEGIN
DECLARE
 @Temp   VARCHAR(100),
 @Temp2 int
    SET DATEFORMAT DMY
    SET NOCOUNT ON

    --insert into INTELISIS_PEDIDO.dbo.Table_1 values(@Dato,@Dato2,@Accion)  

-- CAMPOS NECESARIOS ALMACEN - NOMBRE - TIPO   
  IF @Accion = 'ALMACEN'
  BEGIN
    SELECT Almacen , Nombre, Tipo
      FROM Alm
     WHERE Tipo='Normal' 
       AND Estatus='ALTA'
  END
  
--@DATO = USUARIO  
  IF @Accion = 'USUARIO'
  BEGIN
    SELECT Usuario, Contrasena, Nombre, Sucursal, DefEmpresa, DefAgente, DefAlmacen, DefCtaDinero, DefMoneda, BloquearPrecios, BloquearDescLinea  ,ModificarListaPrecios
      FROM Usuario
     WHERE Estatus='ALTA'
  END
  
  IF @Accion = 'USUARIOD'
  BEGIN
    SELECT Usuario, Empresa
    FROM UsuarioD
  END
  
  IF @Accion = 'DESCUENTOS'
  BEGIN
    SELECT Descuento, Porcentaje
      FROM Descuento
  END
  
  IF @Accion = 'CONDICIONES'
  BEGIN
    SELECT Condicion, TipoCondicion, DiasVencimiento, Interes
      FROM Condicion
     WHERE TipoCondicion <> ''
  END
  
  IF @Accion = 'CLIENTE'
  BEGIN
    SELECT Cliente, Nombre, Direccion, EntreCalles, Delegacion, Colonia, Poblacion,
           Estado, Pais,  CodigoPostal, RFC, Telefonos, Contacto1, eMail1, Credito,
           ZonaImpuesto, Descuento, Agente,  ListaPrecios, ListaPreciosEsp, DefMoneda,
           CreditoLimite, Cobrador, AlmacenDef, SucursalEmpresa,
           FormasPagoRestringidas, BloquearMorosos, Condicion , 9283 as 'IDRuta', 'mexico' as 'Ruta', '09/05/2010' as 'DiaVisita'
      FROM Cte
     WHERE Estatus='ALTA'
       AND Tipo='Cliente'
  END
--select * from Cte  
  
--@DATO = EMPRESA  
--@DATO = ALMACEN  
  IF @Accion = 'ARTICULO'
  BEGIN
    SELECT Art.Articulo, Art.Descripcion1, Art.Grupo, Art.Categoria, Art.Familia, Art.Linea,
           Art.Impuesto1, Art.Impuesto2, Art.Impuesto3,
           Art.Unidad, Art.UnidadCantidad, Art.Peso, Art.Tipo, Art.TipoOpcion, Art.MonedaPrecio,
           Art.PrecioLista, Art.PrecioMinimo, Art.Unidad, Art.AlmacenROP, Art.Precio2 , Art.Precio3, Art.Precio4, Art.Precio5,
           Art.Precio6, Art.Precio7, Art.Precio8, Art.Precio9, Art.Precio10, Art.Utilidad,
           Art.AlmacenROP, 100 As Disponible,  Art.Estatus
      FROM Art
     WHERE ESTATUS = 'ALTA'
  END
  
  IF @Accion = 'UNIDAD'
  BEGIN
    SELECT dbo.ListaPreciosDUnidad.Articulo, dbo.ListaPreciosDUnidad.Lista, dbo.ListaPreciosDUnidad.Unidad, dbo.ListaPreciosDUnidad.Precio
      FROM dbo.ListaPreciosDUnidad INNER JOIN
           dbo.Art ON dbo.ListaPreciosDUnidad.Articulo = dbo.Art.Articulo
     WHERE (dbo.Art.Estatus = 'ALTA')
     ORDER BY ListaPreciosDUnidad.Articulo, ListaPreciosDUnidad.Lista, ListaPreciosDUnidad.Unidad
  END
  
  IF @Accion = 'DESCUENTOS'
  BEGIN
    SELECT Descuento, Porcentaje
      FROM Descuento
  END
  
  IF @Accion = 'CXC'
  BEGIN
    SELECT c.Movid, c.Vencimiento, c.Mov, c.Cliente, t.Nombre,
           c.Saldo * m.Factor as Cargo, c.Empresa 
      FROM Cxc c, MovTipo m, Cte t
     WHERE c.Cliente = t.Cliente  
       AND c.Mov = m.Mov
       AND m.Modulo = 'CXC'
       AND m.clave  IN ('CXC.F', 'CXC.D')
       AND c.Estatus = 'PENDIENTE'
  END  
  
--@DATO = EMPRESA  
--@DATO2 = USUARIO  
  IF @Accion = 'EMPRESA'
  BEGIN
    SELECT VentaPreciosImpuestoIncluido, Empresa , FacturasPendientes, (SELECT top 1 DefImpuesto From EmpresaGral) as 'DefImpuesto'
      FROM EmpresaCFG
  END
  
  IF @Accion = 'CONDICIONES'
  BEGIN
    SELECT Condicion, TipoCondicion, DiasVencimiento, Interes
      FROM Condicion
     WHERE TipoCondicion <> ''
  END
  
  IF @Accion = 'LISTAPRECIOS'
  BEGIN
    SELECT dbo.ListaPreciosEsp.Lista, dbo.ListaPrecios.Descripcion
      FROM dbo.ListaPreciosEsp FULL OUTER JOIN
           dbo.ListaPrecios ON dbo.ListaPreciosEsp.Lista = dbo.ListaPrecios.Lista
  END
  
  IF @Accion = 'SERIELOTE'
  BEGIN
    SELECT SerieLote, (CASE WHEN Existencia  IS null THEN 0 ELSE Existencia END) as Existencia FROM SerieLote
     WHERE Articulo = @Dato
       AND Almacen = @Dato2
  END
  
  --------------------------------------------------------------------  
  ---       MOVILINK        
  --------------------------------------------------------------------  
  IF @Accion = 'CLIENTE_BUSQUEDA'
    IF @Dato='Cliente'
    BEGIN
      SELECT COUNT(Cliente)
        FROM Cte
       WHERE Estatus = 'ALTA'
         AND Tipo = 'Cliente'
         AND Cliente like '%' + @Dato2 + '%'
    END
    ELSE
    BEGIN
      SELECT COUNT(Cliente)
        FROM Cte
       WHERE Estatus = 'ALTA'
         AND Tipo = 'Cliente'    
         AND Nombre like '%' + @Dato2 + '%'
    END
  
  IF @Accion = 'CLIENTE_RES_BUSQUEDA'
    IF @Dato='Cliente'
    BEGIN
      SELECT '00000', 'Nueva Busqueda'
       UNION ALL
      SELECT Cliente, RTRIM(Cliente) + ' - ' + Nombre
        FROM Cte
       WHERE Estatus = 'ALTA'
         AND Tipo = 'Cliente'
         AND Cliente like '%' + @Dato2 + '%'
    END
    ELSE
    BEGIN
      SELECT '0000', 'Nueva Busqueda'
       UNION ALL
      SELECT Cliente, RTRIM(Cliente) + ' - ' + Nombre
        FROM Cte
       WHERE Estatus = 'ALTA'
         AND Tipo = 'Cliente'
         AND Nombre like '%' + @Dato2 + '%'
    END  
  
  IF @Accion = 'CLIENTE_CLIENTE'
  BEGIN
    SELECT Cliente, Nombre, Agente,AlmacenDef, Cobrador,CodigoPostal,Colonia, Contacto1,Credito,CreditoLimite,DefMoneda,Delegacion,Descuento,Direccion, eMail1,EntreCalles, Estado, ListaPreciosEsp, Pais,Poblacion,RFC,SucursalEmpresa,Telefonos, ZonaImpuesto, Condicion
      FROM Cte
     WHERE Estatus = 'ALTA'
       AND Tipo = 'Cliente'
       AND Cliente = @Dato
  END  
  
  IF @Accion = 'ARTICULO_RES_BUSQUEDA'  
  BEGIN  
    IF @Dato4 like '%Pedido%'  
    BEGIN  
      IF @Dato='Articulo'  
      --DONDE PrecioLista>0 hasta cambio de version de SPAFECTAR  para los cuatro selects de articulo  
      BEGIN  
        SELECT CASE WHEN Art.Articulo IS NULL THEN '' ELSE Art.Articulo END AS Articulo,
               CASE WHEN Art.Articulo IS NULL THEN '' ELSE Art.Articulo END AS Expr1,
               CASE WHEN Descripcion1 IS NULL THEN '' ELSE Descripcion1 END AS Expr2, CASE WHEN Familia IS NULL THEN '' ELSE Familia END AS Expr3, CASE WHEN Grupo IS NULL
                                              THEN '' ELSE Grupo END AS Expr4, CASE WHEN Linea IS NULL THEN '' ELSE Linea END AS Expr5, CASE WHEN AlmacenROP IS NULL
                                              THEN '' ELSE AlmacenROP END AS Expr6, CASE WHEN Peso IS NULL THEN '' ELSE Peso END AS Expr7, CASE WHEN PrecioLista IS NULL
                                              THEN '' ELSE PrecioLista END AS Expr8, CASE WHEN Tipo IS NULL THEN '' ELSE Tipo END AS Expr9, CASE WHEN Unidad IS NULL
                                              THEN '' ELSE Unidad END AS Expr10,
               CONVERT(varchar (30), CONVERT(money,SUM(CASE WHEN Disponible IS NULL OR Disponible = 0  THEN '0' ELSE Disponible END)),1) AS Expr11
          FROM Art LEFT OUTER JOIN
               ArtExistenciaReservado ON Art.Articulo = ArtExistenciaReservado.Articulo
         WHERE (Art.Estatus = 'ALTA') and PrecioLista>0
         GROUP BY Art.Articulo,
               CASE WHEN Unidad IS NULL THEN '' ELSE Unidad END, CASE WHEN Tipo IS NULL THEN '' ELSE Tipo END,
               CASE WHEN PrecioLista IS NULL THEN '' ELSE PrecioLista END, CASE WHEN Peso IS NULL THEN '' ELSE Peso END,
               CASE WHEN AlmacenROP IS NULL THEN '' ELSE AlmacenROP END, CASE WHEN Linea IS NULL THEN '' ELSE Linea END,
               CASE WHEN Grupo IS NULL THEN '' ELSE Grupo END,
               CASE WHEN Familia IS NULL THEN '' ELSE Familia END,
               CASE WHEN Descripcion1 IS NULL THEN '' ELSE Descripcion1 END,
               CASE WHEN Art.Articulo IS NULL THEN '' ELSE Art.Articulo END
        HAVING (Art.Articulo LIKE '%' + @Dato2 + '%')
         ORDER BY Art.Articulo  
      END  
      ELSE  
      BEGIN  
        SELECT CASE WHEN Art.Articulo IS NULL THEN '' ELSE Art.Articulo END AS Articulo,
               CASE WHEN Art.Articulo IS NULL THEN '' ELSE Art.Articulo END AS Expr1,
               CASE WHEN Descripcion1 IS NULL THEN '' ELSE Descripcion1 END AS Expr2,
               CASE WHEN Familia IS NULL THEN '' ELSE Familia END AS Expr3,
               CASE WHEN Grupo IS NULL THEN '' ELSE Grupo END AS Expr4,
               CASE WHEN Linea IS NULL THEN '' ELSE Linea END AS Expr5,
               CASE WHEN AlmacenROP IS NULL THEN '' ELSE AlmacenROP END AS Expr6,
               CASE WHEN Peso IS NULL THEN '' ELSE Peso END AS Expr7,
               CASE WHEN PrecioLista IS NULL THEN '' ELSE PrecioLista END AS Expr8,
               CASE WHEN Tipo IS NULL THEN '' ELSE Tipo END AS Expr9,
               CASE WHEN Unidad IS NULL THEN '' ELSE Unidad END AS Expr10,
               CONVERT(varchar (30), CONVERT(money,SUM(CASE WHEN Disponible IS NULL OR Disponible = 0 THEN '0' ELSE Disponible END)),1) AS Expr11
          FROM Art LEFT OUTER JOIN
               ArtExistenciaReservado ON Art.Articulo = ArtExistenciaReservado.Articulo
         WHERE (Art.Estatus = 'ALTA') AND PrecioLista > 0
         GROUP BY Art.Articulo, Descripcion1, 
                  CASE WHEN Unidad IS NULL THEN '' ELSE Unidad END,
                  CASE WHEN Tipo IS NULL THEN '' ELSE Tipo END,
                  CASE WHEN PrecioLista IS NULL THEN '' ELSE PrecioLista END,
                  CASE WHEN Peso IS NULL THEN '' ELSE Peso END,
                  CASE WHEN AlmacenROP IS NULL THEN '' ELSE AlmacenROP END,
                  CASE WHEN Linea IS NULL THEN '' ELSE Linea END,
                  CASE WHEN Grupo IS NULL THEN '' ELSE Grupo END, CASE WHEN Familia IS NULL THEN '' ELSE Familia END,
                  CASE WHEN Descripcion1 IS NULL THEN '' ELSE Descripcion1 END,
                  CASE WHEN Art.Articulo IS NULL THEN '' ELSE Art.Articulo END
        HAVING (Art.Descripcion1 LIKE '%' + @Dato2 + '%')
         ORDER BY Art.Articulo  
      
      END
    END
    ELSE
    BEGIN
      IF @Dato = 'Articulo'
      BEGIN
       SELECT CASE WHEN Articulo IS NULL THEN '' ELSE Articulo END,
              CASE WHEN Articulo IS NULL THEN '' ELSE Articulo END,
              CASE WHEN Descripcion1 IS NULL THEN '' ELSE Descripcion1 END,
              CASE WHEN Familia  IS NULL THEN '' ELSE Familia END,
              CASE WHEN Grupo IS NULL THEN '' ELSE Grupo END,
              CASE WHEN Linea IS NULL THEN '' ELSE Linea END,
              CASE WHEN AlmacenROP IS NULL THEN '' ELSE AlmacenROP END,
              CASE WHEN Peso IS NULL THEN '' ELSE Peso END,
              CASE WHEN PrecioLista IS NULL THEN '' ELSE PrecioLista END,
              CASE WHEN Tipo IS NULL THEN '' ELSE Tipo END,
              CASE WHEN Unidad  IS NULL THEN '' ELSE Unidad END
         FROM Art
        WHERE Art.Estatus = 'ALTA' AND PrecioLista > 0
          AND Art.Articulo like  '%' + @Dato2 + '%'
        ORDER BY  Art.Articulo
       
      END  
      ELSE  
      BEGIN  
        SELECT CASE WHEN Articulo IS NULL THEN '' ELSE Articulo END,
               CASE WHEN Articulo IS NULL THEN '' ELSE Articulo END,
               CASE WHEN Descripcion1 IS NULL THEN '' ELSE Descripcion1 END,
               CASE WHEN Familia  IS NULL THEN '' ELSE Familia END,
               CASE WHEN Grupo IS NULL THEN '' ELSE Grupo END,
               CASE WHEN Linea IS NULL THEN '' ELSE Linea END,
               CASE WHEN AlmacenROP IS NULL THEN '' ELSE AlmacenROP END,
               CASE WHEN Peso IS NULL THEN '' ELSE Peso END,
               CASE WHEN PrecioLista IS NULL THEN '' ELSE PrecioLista END,
               CASE WHEN Tipo IS NULL THEN '' ELSE Tipo END,
               CASE WHEN Unidad  IS NULL THEN '' ELSE Unidad END
          FROM Art
         WHERE Art.Estatus = 'ALTA' AND PrecioLista > 0
           AND Descripcion1 like  '%' + @Dato2 + '%'
         ORDER BY Art.Articulo  
       
      END  
    END  
  END   
  IF @Accion = 'ARTICULO_ARTICULO'  
  BEGIN  
    SELECT CASE WHEN Articulo IS NULL THEN '' ELSE Articulo END,
           CASE WHEN Descripcion1 IS NULL THEN '' ELSE Descripcion1 END,
           CASE WHEN Familia  IS NULL THEN '' ELSE Familia END,
           CASE WHEN Grupo IS NULL THEN '' ELSE Grupo END,
           CASE WHEN Linea IS NULL THEN '' ELSE Linea END,
           CASE WHEN AlmacenROP IS NULL THEN '' ELSE AlmacenROP END,
           CASE WHEN Peso IS NULL THEN '' ELSE Peso END,
           CASE WHEN PrecioLista IS NULL THEN '' ELSE PrecioLista END,
           CASE WHEN Tipo IS NULL THEN '' ELSE Tipo END,
           CASE WHEN Unidad  IS NULL THEN '' ELSE Unidad END
      FROM Art
     WHERE ESTATUS = 'ALTA'
       AND Articulo like  '%' + @Dato + '%'
     ORDER BY Articulo
  END
   
  IF @Accion = 'CXC_RES_BUSQUEDA'
  BEGIN
    SELECT '0000', 'Nueva Busqueda'
     UNION ALL
    SELECT t.Cliente, RTRIM(t.Cliente) + ' - ' + t.Nombre
      FROM Cxc c, MovTipo m, Cte t
     WHERE c.Cliente = t.Cliente
       AND c.Mov = m.Mov
       AND m.Modulo = 'CXC'
       AND m.clave  IN ('CXC.F', 'CXC.D')
       AND c.Estatus = 'PENDIENTE'
       AND t.Agente = (SELECT u.DefAgente FROM Usuario u WHERE u.Usuario = @Dato)
     GROUP BY t.Cliente, RTRIM(t.Cliente) + ' - ' + t.Nombre     
  END  
   
  IF @Accion = 'VALIDAUSUARIO'  
  BEGIN   
    SET @Temp = (SELECT Nombre FROM Usuario WHERE Usuario = @Dato AND Estatus = 'Alta')  

    IF @Temp IS NULL
      SET @Temp2 = 5/0  
     
    IF (SELECT COUNT(Sucursal)+COUNT(DefEmpresa) FROM Usuario WHERE Usuario = @Dato) <> 2  
      SET @Temp2 = 5/0  
    
    RETURN           
  END   
END
GO

/***************** spExisteArchivo *******************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spExisteArchivo') and TYPE = 'P') DROP PROCEDURE dbo.spExisteArchivo
GO             
CREATE PROC spExisteArchivo
			@FileName varchar(255) 
--//WITH ENCRYPTION
AS BEGIN  
SET NOCOUNT ON 
DECLARE @File_Exists int
EXEC Master.dbo.xp_fileexist @FileName, @File_Exists OUT 
IF @File_Exists = 0 
	SELECT 'El archivo no existe '
ELSE
	select ''
END
GO
