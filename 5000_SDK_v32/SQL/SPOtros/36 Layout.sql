SET ANSI_NULLS OFF
GO
/**************** spLayoutDatos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutDatos') and type = 'P') drop procedure dbo.spLayoutDatos
GO
CREATE PROCEDURE spLayoutDatos
			@ArchivoID		int,			
			@Layout			varchar(50),
			@LayoutInsertarVacios	bit,
			@Lista			varchar(255),
			@Registro		int,
			@Campo			varchar(50),
			@SubCampo		varchar(50),
			@Valor			varchar(8000),
			@Mayusculas		bit,
			@Minusculas		bit,
			@DividirEntre100	bit
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Valor = NULLIF(LTRIM(RTRIM(@Valor)), '')
  IF @Valor IS NOT NULL
  BEGIN
    IF @Mayusculas = 1 SELECT @Valor = UPPER(@Valor) ELSE
    IF @Minusculas = 1 SELECT @Valor = LOWER(@Valor) 
    IF @DividirEntre100 = 1 AND dbo.fnEsNumerico(@Valor) = 1 
      SELECT @Valor = LTRIM(CONVERT(varchar, CONVERT(money, CONVERT(bigint, @Valor)/100.0)))
  END 

  IF @Valor IS NOT NULL OR @LayoutInsertarVacios = 1
    INSERT LayoutDatos (
            ArchivoID,  Layout,  Lista,  Registro,  Campo,  SubCampo,  Valor)
    VALUES (@ArchivoID, @Layout, @Lista, @Registro, @Campo, @SubCampo, @Valor)
END
GO      

/**************** spLayoutListaINI ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutListaINI') and type = 'P') drop procedure dbo.spLayoutListaINI
GO
CREATE PROCEDURE spLayoutListaINI
			@ArchivoID		int,			
			@Layout			varchar(50),
			@LayoutFormato		varchar(20),
			@LayoutInsertarVacios	bit,
			@Lista			varchar(255)	OUTPUT,
			@Datos			varchar(8000),
			@Registro		int		OUTPUT,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Seccion		varchar(255),
    @p			int,
    @Campo		varchar(50), 
    @Valor		varchar(8000),
    @Mayusculas		bit,
    @Minusculas		bit,
    @DividirEntre100	bit

  SELECT @Mayusculas = 0, @Minusculas = 0, @DividirEntre100 = 0
  SELECT @Datos = NULLIF(LTRIM(RTRIM(@Datos)), '')

  IF SUBSTRING(@Datos, 1, 1) = '[' AND SUBSTRING(@Datos, LEN(@Datos), 1) = ']'
  BEGIN
    SELECT @Seccion = SUBSTRING(@Datos, 2, LEN(@Datos)-2)
    IF @LayoutFormato = 'INI ESTATICO'
      SELECT @Lista = Lista FROM LayoutLista WHERE Layout = @Layout AND Lista = @Seccion
    ELSE
      SELECT @Lista = @Seccion
    SELECT @Registro = @Registro + 1
  END ELSE
  IF @Lista IS NOT NULL AND @Datos IS NOT NULL
  BEGIN
    SELECT @p = 0
    SELECT @p = CHARINDEX('=', @Datos)
    IF @p > 0
    BEGIN
      SELECT @Campo = RTRIM(SUBSTRING(@Datos, 1, @p-1)), 
	     @Valor = RTRIM(SUBSTRING(@Datos, @p+1, LEN(@Datos)))

      IF @LayoutFormato = 'INI ESTATICO'
      BEGIN
        SELECT @Campo = Campo, @Mayusculas = ISNULL(Mayusculas, 0), @Minusculas = ISNULL(Minusculas, 0), @DividirEntre100 = ISNULL(DividirEntre100, 0)
          FROM LayoutCampo 
         WHERE Layout = @Layout AND Lista = @Lista AND Campo = @Campo
        IF @@ROWCOUNT = 0 SELECT @Campo = NULL
      END
      IF @Campo IS NOT NULL
        EXEC spLayoutDatos @ArchivoID, @Layout, @LayoutInsertarVacios, @Lista, @Registro, @Campo, NULL, @Valor, @Mayusculas, @Minusculas, @DividirEntre100
    END
  END
END
GO

/**************** spLayoutListaEsRegistro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutListaEsRegistro') and type = 'P') drop procedure dbo.spLayoutListaEsRegistro
GO
CREATE PROCEDURE spLayoutListaEsRegistro
			@ArchivoID	int,			
			@Layout		varchar(50),
			@Lista		varchar(50)	OUTPUT,
			@Datos		varchar(8000),
			@EsRegistro	bit		OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			varchar(100), 
    @IDPosicion		int, 
    @ID2		varchar(100), 
    @ID2Posicion	int, 
    @IDLista		varchar(50)

  SELECT @EsRegistro = 0, @Lista = NULL
  DECLARE crLayoutLista CURSOR LOCAL FOR 
   SELECT IDRegistro, IDRegistroPosicion, IDRegistro2, IDRegistro2Posicion, Lista
     FROM LayoutLista
    WHERE Layout = @Layout
    ORDER BY Orden

  OPEN crLayoutLista
  FETCH NEXT FROM crLayoutLista INTO @ID, @IDPosicion, @ID2, @ID2Posicion, @IDLista
  WHILE @@FETCH_STATUS <> -1 AND @EsRegistro = 0
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF (@IDPosicion IS NULL AND CHARINDEX(@ID, @Datos) > 0) OR 
         (@IDPosicion IS NOT NULL AND SUBSTRING(@Datos, @IDPosicion, LEN(@ID)) = @ID) 
      BEGIN
        IF @ID2 IS NULL
          SELECT @EsRegistro = 1
        ELSE BEGIN
          IF (@ID2Posicion IS NULL AND CHARINDEX(@ID2, @Datos) > 0) OR 
             (@ID2Posicion IS NOT NULL AND SUBSTRING(@Datos, @ID2Posicion, LEN(@ID2)) = @ID2) 
            SELECT @EsRegistro = 1
        END
      END
      IF @EsRegistro = 1 SELECT @Lista = @IDLista
    END
    FETCH NEXT FROM crLayoutLista INTO @ID, @IDPosicion, @ID2, @ID2Posicion, @IDLista
  END
  CLOSE crLayoutLista
  DEALLOCATE crLayoutLista

  RETURN
END
GO

/**************** spLayoutListaEsComienzo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutListaEsComienzo') and type = 'P') drop procedure dbo.spLayoutListaEsComienzo
GO
CREATE PROCEDURE spLayoutListaEsComienzo
			@ArchivoID	int,			
			@Layout		varchar(50),
			@Lista		varchar(50)	OUTPUT,
			@Datos		varchar(8000),
			@EsComienzo	bit		OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		varchar(100), 
    @IDPosicion	int, 
    @IDLista	varchar(50)

  SELECT @EsComienzo = 0
  DECLARE crLayoutLista CURSOR LOCAL FOR 
   SELECT IDComienzo, IDComienzoPosicion, Lista
     FROM LayoutLista
    WHERE Layout = @Layout
    ORDER BY Orden

  OPEN crLayoutLista
  FETCH NEXT FROM crLayoutLista INTO @ID, @IDPosicion, @IDLista
  WHILE @@FETCH_STATUS <> -1 AND @EsComienzo = 0
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @IDPosicion IS NULL 
      BEGIN
        IF CHARINDEX(@ID, @Datos) > 0
         SELECT @EsComienzo = 1
      END ELSE
      BEGIN
        IF SUBSTRING(@Datos, @IDPosicion, LEN(@ID)) = @ID
          SELECT @EsComienzo = 1
      END
      IF @EsComienzo = 1 SELECT @Lista = @IDLista
    END
    FETCH NEXT FROM crLayoutLista INTO @ID, @IDPosicion, @IDLista
  END
  CLOSE crLayoutLista
  DEALLOCATE crLayoutLista

  RETURN
END
GO

/**************** spLayoutListaEsFin ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutListaEsFin') and type = 'P') drop procedure dbo.spLayoutListaEsFin
GO
CREATE PROCEDURE spLayoutListaEsFin
			@ArchivoID	int,			
			@Layout		varchar(50),
			@Lista		varchar(50)	OUTPUT,
			@Datos		varchar(8000),
			@EsFin		bit		OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		varchar(100), 
    @IDPosicion	int

  SELECT @EsFin = 0
  SELECT @ID = IDFin, @IDPosicion = IDFinPosicion
    FROM LayoutLista
   WHERE Layout = @Layout AND Lista = @Lista
   ORDER BY Orden

  IF @IDPosicion IS NULL 
  BEGIN
    IF CHARINDEX(@ID, @Datos) > 0
     SELECT @EsFin = 1
  END ELSE
  BEGIN
    IF SUBSTRING(@Datos, @IDPosicion, LEN(@ID)) = @ID
      SELECT @EsFin = 1
  END
  IF @EsFin = 1 SELECT @Lista = NULL
  RETURN
END
GO

/**************** spLayoutSubRegistro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutSubRegistro') and type = 'P') drop procedure dbo.spLayoutSubRegistro
GO
CREATE PROCEDURE spLayoutSubRegistro
			@ArchivoID			int,			
			@Layout				varchar(50),
			@LayoutFormato			varchar(20),
			@LayoutSeparador		varchar(10),
			@LayoutTextosEntreComillas	bit,
			@LayoutInsertarVacios		bit,
			@Lista				varchar(50),
			@Datos				varchar(8000),
			@Registro			int,
			@Campo				varchar(50),
			@Ok				int		OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SubCampo		varchar(50), 
    @PosicionSt		varchar(20), 
    @Posicion		int, 
    @TamanoSt		varchar(20), 
    @Tamano		int, 
    @TipoDatos		varchar(20),
    @Orden		int,
    @Mayusculas		bit,
    @Minusculas		bit,
    @DividirEntre100	bit,
    @Valor		varchar(8000),
    @Etiqueta		varchar(20),
    @p			int,
    @up			int,
    @Salir		bit

  SELECT @up = 1
  DECLARE crLayoutSubCampo CURSOR LOCAL FOR 
   SELECT SubCampo, NULLIF(RTRIM(Posicion), ''), NULLIF(RTRIM(Tamano), ''), TipoDatos, Orden, ISNULL(Mayusculas, 0), ISNULL(Minusculas, 0), ISNULL(DividirEntre100, 0)
     FROM LayoutSubCampo
    WHERE Layout = @Layout AND Lista = @Lista AND Campo = @Campo
    ORDER BY Orden
  OPEN crLayoutSubCampo
  FETCH NEXT FROM crLayoutSubCampo INTO @SubCampo, @PosicionSt, @TamanoSt, @TipoDatos, @Orden, @Mayusculas, @Minusculas, @DividirEntre100
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Valor = NULL, @Posicion = NULL

      IF @PosicionSt IS NULL
        SELECT @Posicion = @up 
      ELSE BEGIN
        IF dbo.fnEsNumerico(@PosicionSt) = 1 
          SELECT @Posicion = CONVERT(int, @PosicionSt)
        ELSE BEGIN
          SELECT @Etiqueta = dbo.fnCaracterEspecial(@PosicionSt)
          IF @Etiqueta IS NULL 
            SELECT @Etiqueta = dbo.fnQuitarComillas(@PosicionSt)
          IF @Etiqueta IS NOT NULL
            SELECT @Posicion = NULLIF(CHARINDEX(@Etiqueta, @Datos, 1), 0) + LEN(@Etiqueta) 
        END
      END

      IF @LayoutFormato = 'SEPARADOR'
      BEGIN
        EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, @LayoutSeparador
        IF @LayoutTextosEntreComillas = 1 
          SELECT @Valor = dbo.fnQuitarComillas(@Valor)
      END ELSE
      IF @LayoutFormato = 'ANCHO FIJO'
      BEGIN
        SELECT @Tamano = NULL
        IF dbo.fnEsNumerico(@TamanoSt) = 1 
        BEGIN
          SELECT @Tamano = CONVERT(int, @TamanoSt)
          SELECT @Valor = SUBSTRING(@Datos, @Posicion, @Tamano)
          SELECT @up = @Posicion + @Tamano 
        END ELSE 
	IF @TamanoSt IN ('(FIN LINEA)', '<CR>')
        BEGIN
          SELECT @Valor = SUBSTRING(@Datos, @Posicion, LEN(@Datos)) 
        END ELSE BEGIN
          SELECT @Etiqueta = dbo.fnCaracterEspecial(@TamanoSt)
          IF @Etiqueta IS NULL 
            SELECT @Etiqueta = dbo.fnQuitarComillas(@TamanoSt)
          IF @Etiqueta IS NOT NULL
          BEGIN
            SELECT @p = CHARINDEX(@Etiqueta, @Datos, @Posicion)
            IF @p > 0              
            BEGIN
              SELECT @Valor = SUBSTRING(@Datos, @Posicion, @p - @Posicion)
              SELECT @up = @p + LEN(@Etiqueta) 
            END ELSE 
              SELECT @Valor = SUBSTRING(@Datos, @Posicion, LEN(@Datos)), @p = LEN(@Datos)
          END
        END
      END
      EXEC spLayoutDatos @ArchivoID, @Layout, @LayoutInsertarVacios, @Lista, @Registro, @Campo, @SubCampo, @Valor, @Mayusculas, @Minusculas, @DividirEntre100
    END
    FETCH NEXT FROM crLayoutSubCampo INTO @SubCampo, @PosicionSt, @TamanoSt, @TipoDatos, @Orden, @Mayusculas, @Minusculas, @DividirEntre100
  END
  CLOSE crLayoutSubCampo
  DEALLOCATE crLayoutSubCampo
  RETURN
END
GO

/**************** spLayoutRegistro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutRegistro') and type = 'P') drop procedure dbo.spLayoutRegistro
GO
CREATE PROCEDURE spLayoutRegistro
			@ArchivoID			int,			
			@Layout				varchar(50),
			@LayoutFormato			varchar(20),
			@LayoutSeparador		varchar(10),
			@LayoutTextosEntreComillas	bit,
			@LayoutInsertarVacios		bit,
			@Lista				varchar(50),
			@Datos				varchar(8000),
			@Registro			int,
			@Ok				int		OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Campo		varchar(50), 
    @PosicionSt		varchar(20), 
    @Posicion		int, 
    @uPosicion		int, 
    @TamanoSt		varchar(20), 
    @Tamano		int, 
    @TipoDatos		varchar(20),
    @Orden		int,
    @Mayusculas		bit,
    @Minusculas		bit,
    @DividirEntre100	bit,
    @TieneSubCampos	bit,
    @Valor		varchar(8000),
    @Etiqueta		varchar(20),
    @p			int,
    @up			int,
    @Salir		bit

  SELECT @uPosicion = NULL, @up = 1
  DECLARE crLayoutCampo CURSOR LOCAL FOR 
   SELECT Campo, NULLIF(RTRIM(Posicion), ''), NULLIF(RTRIM(Tamano), ''), TipoDatos, Orden, ISNULL(Mayusculas, 0), ISNULL(Minusculas, 0), ISNULL(DividirEntre100, 0), ISNULL(TieneSubCampos, 0)
     FROM LayoutCampo
    WHERE Layout = @Layout AND Lista = @Lista
    ORDER BY Orden

  OPEN crLayoutCampo
  FETCH NEXT FROM crLayoutCampo INTO @Campo, @PosicionSt, @TamanoSt, @TipoDatos, @Orden, @Mayusculas, @Minusculas, @DividirEntre100, @TieneSubCampos
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Valor = NULL, @Posicion = NULL

      IF @PosicionSt IS NULL
        SELECT @Posicion = @up 
      ELSE BEGIN
        IF dbo.fnEsNumerico(@PosicionSt) = 1 
          SELECT @Posicion = CONVERT(int, @PosicionSt)
        ELSE BEGIN
          SELECT @Etiqueta = dbo.fnCaracterEspecial(@PosicionSt)
          IF @Etiqueta IS NULL 
            SELECT @Etiqueta = dbo.fnQuitarComillas(@PosicionSt)
          IF @Etiqueta IS NOT NULL
            SELECT @Posicion = NULLIF(CHARINDEX(@Etiqueta, @Datos, 1), 0) + LEN(@Etiqueta) 
        END
      END

      IF @LayoutFormato = 'SEPARADOR'
      BEGIN
        EXEC spExtraerDato @Datos OUTPUT, @Valor OUTPUT, @LayoutSeparador
        IF @LayoutTextosEntreComillas = 1 
          SELECT @Valor = dbo.fnQuitarComillas(@Valor)
      END ELSE
      IF @LayoutFormato = 'ANCHO FIJO'
      BEGIN
        IF @Posicion = 1 AND @uPosicion IS NOT NULL
          FETCH NEXT FROM crArchivoD INTO @Datos

        SELECT @Tamano = NULL
        IF dbo.fnEsNumerico(@TamanoSt) = 1 
        BEGIN
          SELECT @Tamano = CONVERT(int, @TamanoSt)
          SELECT @Valor = SUBSTRING(@Datos, @Posicion, @Tamano)
          SELECT @up = @Posicion + @Tamano
        END ELSE 
	IF @TamanoSt IN ('(FIN LINEA)', '<CR>')
          SELECT @Valor = SUBSTRING(@Datos, @Posicion, LEN(@Datos)) 
        ELSE BEGIN
          SELECT @Etiqueta = NULL, @p = 0
	  IF @TamanoSt NOT IN ('(LINEA VACIA)', '(FIN ARCHIVO)')
          BEGIN
            SELECT @Etiqueta = dbo.fnCaracterEspecial(@TamanoSt)
            IF @Etiqueta IS NULL 
              SELECT @Etiqueta = dbo.fnQuitarComillas(@TamanoSt)
            IF @Etiqueta IS NOT NULL
            BEGIN
              SELECT @p = CHARINDEX(@Etiqueta, @Datos, @Posicion)
              IF @p > 0 
              BEGIN
                SELECT @Valor = SUBSTRING(@Datos, @Posicion, @p - @Posicion)
                SELECT @up = @p + LEN(@Etiqueta) 
              END ELSE 
                SELECT @Valor = SUBSTRING(@Datos, @Posicion, LEN(@Datos)), @p = LEN(@Datos)
            END
          END
	  IF @TamanoSt IN ('(LINEA VACIA)', '(FIN ARCHIVO)') OR (@Etiqueta IS NOT NULL AND @p = 0)
          BEGIN
            SELECT @Salir = 0
            WHILE @Salir = 0
            BEGIN
              SELECT @p = 0
              IF @Etiqueta IS NOT NULL
              BEGIN
                SELECT @p = CHARINDEX(@Etiqueta, @Datos, @Posicion)
                SELECT @Salir = 1
              END
              IF @p = 0
                SELECT @p = LEN(@Datos)
 
              SELECT @Valor = ISNULL(@Valor, '') + SUBSTRING(@Datos, @Posicion, @p)
              IF @TamanoSt = '(LINEA VACIA)' AND NULLIF(RTRIM(@Datos), '') IS NULL
                SELECT @Salir = 1

              IF @Salir = 0
              BEGIN
                FETCH NEXT FROM crArchivoD INTO @Datos
                IF @@FETCH_STATUS <> 0 
                  SELECT @Salir = 1
                ELSE
                  SELECT @Valor = @Valor + CHAR(13), @Posicion = 1
              END
            END
          END
        END
      END
      EXEC spLayoutDatos @ArchivoID, @Layout, @LayoutInsertarVacios, @Lista, @Registro, @Campo, NULL, @Valor, @Mayusculas, @Minusculas, @DividirEntre100
      IF @TieneSubCampos = 1
        EXEC spLayoutSubRegistro @ArchivoID, @Layout, @LayoutFormato, @LayoutSeparador, @LayoutTextosEntreComillas, @LayoutInsertarVacios, @Lista, @Valor, @Registro, @Campo, @Ok OUTPUT, @OkRef OUTPUT

      SELECT @uPosicion = @Posicion, @up = @p
    END
    FETCH NEXT FROM crLayoutCampo INTO @Campo, @PosicionSt, @TamanoSt, @TipoDatos, @Orden, @Mayusculas, @Minusculas, @DividirEntre100, @TieneSubCampos
  END
  CLOSE crLayoutCampo
  DEALLOCATE crLayoutCampo
  RETURN
END
GO

/**************** spLayout ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayout') and type = 'P') drop procedure dbo.spLayout
GO
CREATE PROCEDURE spLayout
			@ArchivoID	int,			
			@Layout		varchar(50),
			@Ok		int		= NULL OUTPUT,
			@OkRef		varchar(255)	= NULL OUTPUT,
			@RaiseError	bit		= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ArchivoNombre		varchar(255),
    @LayoutFormato		varchar(20),	-- Ancho Fijo / Separador
    @LayoutIDLista		varchar(20),	-- Cada Registro / Comienzo - Fin
    @LayoutSeparador		varchar(10),
    @LayoutTextosEntreComillas	bit,
    @LayoutInsertarVacios	bit,
    @Datos			varchar(8000),
    @Lista			varchar(255),
    @Lista1			varchar(255),
    @EsComienzo			bit,
    @EsFin			bit,
    @EsRegistro			bit,
    @EsINI			bit,
    @Registro			int

  SELECT @Lista = NULL, @Registro = 0
  SELECT @ArchivoNombre = UPPER(Nombre) FROM Archivo WHERE ID = @ArchivoID
  SELECT @LayoutFormato = UPPER(Formato), @LayoutIDLista = UPPER(IDLista), @LayoutSeparador = dbo.fnCaracterEspecial(Separador), @LayoutTextosEntreComillas = ISNULL(TextosEntreComillas, 0), @LayoutInsertarVacios = ISNULL(InsertarVacios, 0)
    FROM Layout
   WHERE Layout = @Layout

  SELECT @Lista1 = MIN(Lista)
    FROM LayoutLista 
   WHERE Layout = @Layout

  IF @Ok IS NULL
  BEGIN
    BEGIN TRANSACTION

    DELETE LayoutDatos WHERE ArchivoID = @ArchivoID
    DECLARE crArchivoD CURSOR FOR 
     SELECT Datos
       FROM ArchivoD
      WHERE ID = @ArchivoID
      ORDER BY RID

    OPEN crArchivoD
    FETCH NEXT FROM crArchivoD INTO @Datos
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @LayoutFormato LIKE 'INI%' 
          EXEC spLayoutListaINI @ArchivoID, @Layout, @LayoutFormato, @LayoutInsertarVacios, @Lista OUTPUT, @Datos, @Registro OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        ELSE BEGIN
          IF @LayoutIDLista = 'CADA REGISTRO'
            EXEC spLayoutListaEsRegistro @ArchivoID, @Layout, @Lista OUTPUT, @Datos, @EsRegistro OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          ELSE
          IF @LayoutIDLista = 'COMIENZO - FIN'
          BEGIN
            SELECT @EsComienzo = 0, @EsFin = 0
            EXEC spLayoutListaEsComienzo @ArchivoID, @Layout, @Lista OUTPUT, @Datos, @EsComienzo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

            IF @EsComienzo = 1 
	      FETCH NEXT FROM crArchivoD INTO @Datos
            ELSE
              EXEC spLayoutListaEsFin @ArchivoID, @Layout, @Lista OUTPUT, @Datos, @EsFin OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          END ELSE
           SELECT @Lista = @Lista1
          IF @Lista IS NOT NULL AND @Ok IS NULL
          BEGIN
  	    SELECT @Registro = @Registro + 1
            EXEC spLayoutRegistro @ArchivoID, @Layout, @LayoutFormato, @LayoutSeparador, @LayoutTextosEntreComillas, @LayoutInsertarVacios, @Lista, @Datos, @Registro, @Ok OUTPUT, @OkRef OUTPUT
          END
        END
      END
      FETCH NEXT FROM crArchivoD INTO @Datos
    END
    CLOSE crArchivoD
    DEALLOCATE crArchivoD

    IF @Ok IS NULL
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
  END

  IF @RaiseError = 1
    EXEC spOk_RAISERROR @Ok, @OkRef
  RETURN
END
GO

/**************** spLayoutEstructura ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutEstructura') and type = 'P') drop procedure dbo.spLayoutEstructura
GO
CREATE PROCEDURE spLayoutEstructura
			@ArchivoID		int,
			@Layout			varchar(50),
			@LayoutSeparador	varchar(20),
			@Rama			varchar(255),
			@Nivel			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Lista	varchar(255),
    @Campo	varchar(50), 
    @Etiqueta	varchar(50), 
    @Valor	varchar(8000),
    @Nombre	varchar(100), 
    @CDATA	bit

  SELECT @Nivel = @Nivel + 1
  IF @Rama IS NULL
    DECLARE crLayoutEstructura CURSOR LOCAL FOR 
     SELECT Lista
       FROM #LayoutEstructura
      WHERE Nivel = @Nivel
      ORDER BY Lista
  ELSE 
    DECLARE crLayoutEstructura CURSOR LOCAL FOR 
     SELECT Lista
       FROM #LayoutEstructura
      WHERE Lista LIKE @Rama+@LayoutSeparador+'%' AND Nivel = @Nivel
      ORDER BY Lista

  OPEN crLayoutEstructura
  FETCH NEXT FROM crLayoutEstructura INTO @Lista
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN    
      EXEC spExtraerDato @Lista, @Etiqueta OUTPUT, @LayoutSeparador, @Alreves = 1      

      SELECT '<'+dbo.fnXMLParametro(@Etiqueta)+'>'

      DECLARE crLayoutDatos CURSOR LOCAL FOR 
       SELECT d.Campo, d.Valor, v.Nombre, ISNULL(c.CDATA, 0)
         FROM LayoutDatos d
         LEFT OUTER JOIN LayoutCampo c ON c.Layout = d.Layout AND c.Lista = d.Lista AND c.Campo = d.Campo
         LEFT OUTER JOIN LayoutCampoValor v ON v.Layout = d.Layout AND v.Lista = d.Lista AND v.Campo = d.Campo AND v.Valor = d.Valor 
        WHERE d.ArchivoID = @ArchivoID AND d.Layout = @Layout AND d.Lista = @Lista 
        ORDER BY c.Orden

      OPEN crLayoutDatos
      FETCH NEXT FROM crLayoutDatos INTO @Campo, @Valor, @Nombre, @CDATA
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
          SELECT dbo.fnTag2(@Campo, @Valor, 'Nombre', @Nombre, @CDATA)

        FETCH NEXT FROM crLayoutDatos INTO @Campo, @Valor, @Nombre, @CDATA
      END
      CLOSE crLayoutDatos
      DEALLOCATE crLayoutDatos

      EXEC spLayoutEstructura @ArchivoID, @Layout, @LayoutSeparador, @Lista, @Nivel
      SELECT '</'+dbo.fnXMLParametro(@Etiqueta)+'>'
    END
    FETCH NEXT FROM crLayoutEstructura INTO @Lista
  END
  CLOSE crLayoutEstructura
  DEALLOCATE crLayoutEstructura

  RETURN
END
GO


/**************** spLayoutCrearEstructura ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutCrearEstructura') and type = 'P') drop procedure dbo.spLayoutCrearEstructura
GO
CREATE PROCEDURE spLayoutCrearEstructura
			@ArchivoID		int,
			@Layout			varchar(50),
			@LayoutSeparador	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Seccion	varchar(255),
    @Lista	varchar(255)

  DECLARE crLayoutCrearEstructura CURSOR LOCAL FOR 
   SELECT DISTINCT Lista
     FROM LayoutDatos 
    ORDER BY Lista

  OPEN crLayoutCrearEstructura
  FETCH NEXT FROM crLayoutCrearEstructura INTO @Seccion
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    SELECT @Seccion = NULLIF(RTRIM(@Seccion), '')
    IF @@FETCH_STATUS <> -2 AND @Seccion IS NOT NULL
    BEGIN
      IF NOT EXISTS(SELECT * FROM #LayoutEstructura WHERE Lista = @Seccion)
        INSERT #LayoutEstructura (
               Lista,    Nivel) 
        SELECT @Seccion, dbo.fnEstructuraNivelSeparador(@Seccion, @LayoutSeparador)
      WHILE @Seccion IS NOT NULL
      BEGIN
        EXEC spExtraerDato @Seccion OUTPUT, @Lista OUTPUT, @LayoutSeparador, @Alreves = 1
        IF @Seccion IS NOT NULL AND NOT EXISTS(SELECT * FROM #LayoutEstructura WHERE Lista = @Seccion)
          INSERT #LayoutEstructura (
                 Lista,    Nivel)
          SELECT @Seccion, dbo.fnEstructuraNivelSeparador(@Seccion, @LayoutSeparador)
      END
    END
    FETCH NEXT FROM crLayoutCrearEstructura INTO @Seccion
  END
  CLOSE crLayoutCrearEstructura
  DEALLOCATE crLayoutCrearEstructura
  RETURN
END
GO

/**************** spLayoutDatosXML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutDatosXML') and type = 'P') drop procedure dbo.spLayoutDatosXML
GO
CREATE PROCEDURE spLayoutDatosXML
			@ArchivoID	int,
			@Layout		varchar(50),
			@EnSilencio	bit	      = 0,
			@XML		nvarchar(max) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Lista			varchar(255), 
    @ListaOrden			int,
    @Registro			int, 
    @LayoutFormato		varchar(20),
    @LayoutSeparador		varchar(20),
    @LayoutCodificacion		varchar(20),
    @LayoutTieneEstructura	bit,
    @Campo			varchar(50), 
    @SubCampo			varchar(50), 
    @Valor			varchar(8000),
    @Nombre			varchar(100),
    @CDATA			bit,
    @TieneSubCampos		bit,
    @x				nvarchar(max)

  IF @EnSilencio = 1 SELECT @XML = ''
  SELECT @LayoutCodificacion = Codificacion,
         @LayoutFormato = UPPER(Formato),         
         @LayoutTieneEstructura = ISNULL(TieneEstructura, 0),
         @LayoutSeparador = Separador
    FROM Layout
   WHERE Layout = @Layout

  SELECT @x = '<?xml'+
         dbo.fnXML('version','1.0')+
         dbo.fnXML('encoding', @LayoutCodificacion)+
         ' ?>' + 
         '<'+dbo.fnXMLParametro(@Layout)+'>'
  IF @EnSilencio = 1 SELECT @XML = @XML + @x ELSE SELECT @x

  IF @LayoutFormato IN ('INI ESTATICO', 'INI DINAMICO') AND @LayoutTieneEstructura = 1
  BEGIN
    CREATE TABLE #LayoutEstructura (Lista varchar(255) COLLATE Database_Default NOT NULL PRIMARY KEY, Nivel int NULL)
    EXEC spLayoutCrearEstructura @ArchivoID, @Layout, @LayoutSeparador
    EXEC spLayoutEstructura @ArchivoID, @Layout, @LayoutSeparador, NULL, 0
  END ELSE
  BEGIN
    DECLARE crLayoutDatosLista CURSOR LOCAL FOR 
     SELECT l.Orden, d.Lista, d.Registro
       FROM LayoutDatos d
       LEFT OUTER JOIN LayoutLista l ON l.Layout = d.Layout AND l.Lista = d.Lista
      WHERE d.ArchivoID = @ArchivoID AND d.Layout = @Layout
      GROUP BY l.Orden, d.Lista, d.Registro
      ORDER BY l.Orden, d.Lista, d.Registro

    OPEN crLayoutDatosLista
    FETCH NEXT FROM crLayoutDatosLista INTO @ListaOrden, @Lista, @Registro
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @x = '<'+dbo.fnXMLParametro(@Lista)+'>'
        IF @EnSilencio = 1 SELECT @XML = @XML + @x ELSE SELECT @x

        DECLARE crLayoutDatos CURSOR LOCAL FOR 
         SELECT d.Campo, d.Valor, v.Nombre, ISNULL(c.CDATA, 0), ISNULL(c.TieneSubCampos, 0)
           FROM LayoutDatos d
           LEFT OUTER JOIN LayoutCampo c ON c.Layout = d.Layout AND c.Lista = d.Lista AND c.Campo = d.Campo
           LEFT OUTER JOIN LayoutCampoValor v ON v.Layout = d.Layout AND v.Lista = d.Lista AND v.Campo = d.Campo AND v.Valor = d.Valor
          WHERE d.ArchivoID = @ArchivoID AND d.Layout = @Layout AND d.Lista = @Lista AND d.Registro = @Registro AND d.SubCampo IS NULL
          ORDER BY c.Orden

        OPEN crLayoutDatos
        FETCH NEXT FROM crLayoutDatos INTO @Campo, @Valor, @Nombre, @CDATA, @TieneSubCampos
        WHILE @@FETCH_STATUS <> -1 
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            IF @TieneSubCampos = 0
            BEGIN
              SELECT @x = dbo.fnTag2(@Campo, @Valor, 'Nombre', @Nombre, @CDATA)
              IF @EnSilencio = 1 SELECT @XML = @XML + @x ELSE SELECT @x
            END ELSE BEGIN
              SELECT @x = '<'+dbo.fnXMLParametro(@Campo)+'>'
              IF @EnSilencio = 1 SELECT @XML = @XML + @x ELSE SELECT @x

              DECLARE crLayoutSubDatos CURSOR LOCAL FOR 
               SELECT d.SubCampo, d.Valor, v.Nombre, ISNULL(c.CDATA, 0)
                 FROM LayoutDatos d
                 LEFT OUTER JOIN LayoutSubCampo c ON c.Layout = d.Layout AND c.Lista = d.Lista AND c.Campo = d.Campo AND c.SubCampo = d.SubCampo
                 LEFT OUTER JOIN LayoutSubCampoValor v ON v.Layout = d.Layout AND v.Lista = d.Lista AND v.Campo = d.Campo AND v.SubCampo = d.SubCampo AND v.Valor = d.Valor
                WHERE d.ArchivoID = @ArchivoID AND d.Layout = @Layout AND d.Lista = @Lista AND d.Registro = @Registro AND d.Campo = @Campo AND d.SubCampo IS NOT NULL
                ORDER BY c.Orden

              OPEN crLayoutSubDatos
              FETCH NEXT FROM crLayoutSubDatos INTO @SubCampo, @Valor, @Nombre, @CDATA
              WHILE @@FETCH_STATUS <> -1 
              BEGIN
                IF @@FETCH_STATUS <> -2 
                BEGIN
                  SELECT @x = dbo.fnTag2(@SubCampo, @Valor, 'Nombre', @Nombre, @CDATA)
	          IF @EnSilencio = 1 SELECT @XML = @XML + @x ELSE SELECT @x
                END
                FETCH NEXT FROM crLayoutSubDatos INTO @SubCampo, @Valor, @Nombre, @CDATA
              END
              CLOSE crLayoutSubDatos
              DEALLOCATE crLayoutSubDatos

              SELECT @x = '</'+dbo.fnXMLParametro(@Campo)+'>'  
              IF @EnSilencio = 1 SELECT @XML = @XML + @x ELSE SELECT @x
            END
          END
          FETCH NEXT FROM crLayoutDatos INTO @Campo, @Valor, @Nombre, @CDATA, @TieneSubCampos
        END
        CLOSE crLayoutDatos
        DEALLOCATE crLayoutDatos

        SELECT @x = '</'+dbo.fnXMLParametro(@Lista)+'>'  
        IF @EnSilencio = 1 SELECT @XML = @XML + @x ELSE SELECT @x
      END
      FETCH NEXT FROM crLayoutDatosLista INTO @ListaOrden, @Lista, @Registro
    END
    CLOSE crLayoutDatosLista
    DEALLOCATE crLayoutDatosLista
  END

  SELECT @x = '</'+dbo.fnXMLParametro(@Layout)+'>'
  IF @EnSilencio = 1 SELECT @XML = @XML + @x ELSE SELECT @x
  RETURN
END
GO

