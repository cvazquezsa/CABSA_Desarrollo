SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/**************** fnSubcuenta ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'fnSubcuenta' AND Type = 'FN')  DROP FUNCTION fnSubcuenta
GO
CREATE FUNCTION fnSubcuenta (@SubCuenta varchar(20))
RETURNS varchar(1000)
AS
BEGIN
DECLARE
  @ret        varchar(1000),    -- retorno
  @s          varchar(20),      -- string
  @Opcion     char(1),          -- campo opcion
  @Numero     varchar(20),      -- campo numero
  @t          varchar(1000),    -- temporal
  @c          char(1),          -- opcion
  @n          varchar(20),      -- numero
  @o          int,              -- numero de opciones en SubCuenta
  @i          int,              -- indice
  @k          int               -- contador

-- Inicializar
SELECT @ret = ''
SELECT @s = LTRIM(RTRIM(ISNULL(@SubCuenta,''))) + '~'
SELECT @Opcion = ''
SELECT @Numero = ''
SELECT @t = ''
SELECT @c = ''
SELECT @n = ''
SELECT @o = 0
SELECT @i = 1
SELECT @k = LEN(@s)

-- Leer cadena de texto caracter por caracter
WHILE @i <= @k
  BEGIN
    SELECT @c = SUBSTRING(@s,@i,1)
    IF NOT ISNUMERIC(@c) = 1
      -- alfanumerico
      BEGIN
        IF LEN(@Numero) > 0
          BEGIN
            SELECT @t = ''
            SELECT @t = ISNULL(Nombre,'') FROM OpcionD d WHERE d.Opcion = @Opcion AND d.Numero = @Numero

            -- Quitar espacios
            SELECT @t = LTRIM(RTRIM(@t))

            -- Concatenar descripcion
            IF LEN(@t) > 0
              BEGIN
                SELECT @ret = @ret + @t + CHAR(32)
                SELECT @o = @o + 1
              END

            -- Siguiente opcion (si la hay)
            SELECT @Opcion = @c
            SELECT @Numero = ''

          END
        ELSE
          BEGIN
            SELECT @Opcion = @c
          END
      END
    ELSE
      -- Numerico
      BEGIN
        SELECT @Numero = @Numero + @c
      END

    -- Siguiente caracter
    SELECT @i = @i + 1
  END

  -- Quitar espacio al final
  SET @ret = UPPER(LTRIM(RTRIM(@ret)))

  RETURN @ret
END
GO


/**************** fnOrdenarSubcuenta ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'fnOrdenarSubcuenta' AND Type = 'FN')  DROP FUNCTION fnOrdenarSubcuenta
GO

CREATE FUNCTION fnOrdenarSubcuenta(
  @Articulo varchar(20),
  @SubCuenta varchar(20)
)
RETURNS varchar(20)
AS
BEGIN
DECLARE
  @ret        varchar(20),
  @o          char(1),
  @t          varchar(20),
  @c          char(1),
  @k          int

DECLARE @Orden TABLE(
  id          int IDENTITY(1,1),
  Opcion      char(1)
  )

SET @SubCuenta = LTRIM(RTRIM(@SubCuenta)) + '~'
SET @ret = ''
SET @o   = ''
SET @t   = ''
SET @c   = ''
SET @k   = 0

INSERT INTO @Orden
  SELECT a.Opcion
    FROM ArtOpcion a
    JOIN Opcion o ON(a.Opcion = o.Opcion)
   WHERE a.Articulo = @Articulo
   ORDER BY a.Orden, a.Opcion

DECLARE fnOrdenarSubcuenta_cursor CURSOR FOR SELECT Opcion FROM @Orden
OPEN fnOrdenarSubcuenta_cursor
FETCH NEXT FROM fnOrdenarSubcuenta_cursor INTO @o
WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @t = ''
    SET @k = CHARINDEX(@o,@SubCuenta,1)
    If @k > 0
      BEGIN
        SET @t = @o
        SET @k = @k + 1
        SET @c = SUBSTRING(@SubCuenta,@k,1)
        WHILE IsNumeric(@c) = 1
          BEGIN
            SET @t = @t + @c
            SELECT @k = @k + 1
            SELECT @c = SUBSTRING(@SubCuenta,@k,1)
          END
        SET @ret = @ret + @t
      END
    FETCH NEXT FROM fnOrdenarSubcuenta_cursor INTO @o
  END
CLOSE fnOrdenarSubcuenta_cursor
DEALLOCATE fnOrdenarSubcuenta_cursor
SET @ret = LTRIM(RTRIM(@ret))
RETURN @ret
END
GO


/**************** spDistAlmacenLista ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistAlmacenLista' AND Type = 'P')  DROP PROCEDURE spDistAlmacenLista
GO
CREATE PROCEDURE spDistAlmacenLista (
  @Empresa              varchar(5),
  @Origen				bit = 0
)
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @TablaAlm table(
  ID                    int IDENTITY(1,1),
  Almacen               varchar(10)   NULL,
  Nombre                varchar(100)  NULL,
  EsOrigen              bit,
  EsDestino             bit
)

DECLARE @TablaRet table(
  ID                    int IDENTITY(1,1),
  Clave                 varchar(10),
  Nombre                varchar(100),
  EsOrigen              bit,
  EsDestino              bit
)

INSERT INTO @TablaAlm (Almacen,Nombre,EsOrigen,EsDestino)
SELECT a.Almacen,a.Nombre,ISNULL(a.EsOrigen,0),ISNULL(a.EsDestino,0)
  FROM AlmDist a
  JOIN Alm b ON (a.Almacen = b.Almacen)
 WHERE a.Empresa = @Empresa
   AND a.Distribuir = 1
   AND a.EsOrigen = CASE WHEN @Origen = 0 THEN a.EsOrigen ELSE 1 END
   AND b.Estatus = 'ALTA'
ORDER BY a.Nombre

INSERT INTO @TablaRet (Clave,Nombre,EsOrigen,EsDestino)
  SELECT UPPER(LTRIM(RTRIM(ISNULL(Almacen,'')))), UPPER(LTRIM(RTRIM(ISNULL(Nombre,'')))),EsOrigen,EsDestino
  FROM @TablaAlm
  ORDER BY Nombre

SELECT Clave, Nombre FROM @TablaRet WHERE EsOrigen = 1
UNION ALL
SELECT Clave, Nombre FROM @TablaRet WHERE EsOrigen = 0

END
GO


/**************** spDistAlmacenesDestino ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistAlmacenesDestino' AND Type = 'P')  DROP PROCEDURE spDistAlmacenesDestino
GO
CREATE PROCEDURE spDistAlmacenesDestino (
  @Empresa           varchar(5)
)
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @TablaAlm table(
  ID                    int IDENTITY(1,1),
  Almacen               varchar(10)   NULL,
  Nombre                varchar(100)   NULL
)

DECLARE @TablaRet table(
  Clave                 varchar(10),
  Nombre                varchar(100)
)

INSERT INTO @TablaAlm (Almacen,Nombre)
SELECT a.Almacen,a.Nombre
  FROM AlmDist a
  JOIN Alm b ON (a.Almacen = b.Almacen)
 WHERE a.Empresa = @Empresa
   AND a.Distribuir = 1
   AND a.EsDestino = 1
   AND b.Estatus = 'ALTA'
ORDER BY a.Nombre

INSERT INTO @TablaRet (Clave,Nombre)
  SELECT UPPER(LTRIM(RTRIM(ISNULL(Almacen,'')))), UPPER(LTRIM(RTRIM(ISNULL(Nombre,''))))
  FROM @TablaAlm
  ORDER BY ID

SELECT Clave, Nombre FROM @TablaRet

END
GO


/**************** spDistAlmDist ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistAlmDist' AND Type = 'P')  DROP PROCEDURE spDistAlmDist
GO
CREATE PROCEDURE spDistAlmDist
 @Empresa              varchar(5),
 @Almacen              varchar(10),
 @Nombre               varchar(20),
 @Distribuir           bit
--//WITH ENCRYPTION
AS
BEGIN
SET NOCOUNT ON

SET @Empresa    = UPPER(LTRIM(RTRIM(ISNULL(@Empresa,''))))
SET @Almacen    = UPPER(LTRIM(RTRIM(ISNULL(@Almacen,''))))
SET @Nombre     = UPPER(LTRIM(RTRIM(ISNULL(@Nombre,''))))
SET @Distribuir = ISNULL(@Distribuir,0)

IF EXISTS (SELECT TOP 1 Empresa FROM AlmDist WHERE Empresa = @Empresa AND Almacen = @Almacen)
  BEGIN
    UPDATE AlmDist
       SET Nombre = @Nombre, Distribuir = @Distribuir
     WHERE Empresa = @Empresa AND Almacen = @Almacen
  END
ELSE
  BEGIN
    INSERT INTO AlmDist(Empresa,Almacen,Nombre,Distribuir)
    VALUES(@Empresa,@Almacen,@Nombre,@Distribuir)
  END

SET NOCOUNT OFF
END
GO


/**************** spDistAlmacen ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistAlmacen' AND Type = 'P')  DROP PROCEDURE spDistAlmacen
GO
CREATE PROCEDURE spDistAlmacen (
  @Empresa              varchar(5)
)
--//WITH ENCRYPTION
AS
BEGIN
SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))

DECLARE @TablaRet table(
  ID                    int IDENTITY(1,1),
  Almacen               varchar(10)   NULL,
  Nombre                varchar(100)  NULL,
  Direccion             varchar(100)  NULL,
  NombreMostar          varchar(100)  NULL,
  Distribuir            bit           NULL
)

INSERT INTO @TablaRet(Almacen,Nombre,Direccion,NombreMostar,Distribuir)
SELECT LTRIM(RTRIM(ISNULL(a.Almacen,''))),
       LTRIM(RTRIM(ISNULL(a.Nombre,''))),
       LTRIM(RTRIM(ISNULL(a.Direccion,''))),
       LTRIM(RTRIM(ISNULL(d.Nombre,''))),
       ISNULL(d.Distribuir,0)
  FROM Alm a
  LEFT JOIN AlmDist d ON (a.Almacen = d.Almacen)
 WHERE a.Estatus = 'ALTA'

SELECT
  Almacen               AS [Almacén],
  Nombre                AS [Nombre],
  Direccion             AS [Dirección] ,
  NombreMostar          AS [Nombre Mostar],
  Distribuir            AS [Distribuir]
FROM @TablaRet
ORDER BY ID

END
GO


/**************** spDistPorcentaje ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistPorcentaje' AND Type = 'P')  DROP PROCEDURE spDistPorcentaje
GO
CREATE PROCEDURE spDistPorcentaje (
  @Empresa              varchar(5),
  @AlmacenOrigen        varchar(10)
)
--//WITH ENCRYPTION
AS
BEGIN
SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))

DECLARE @TablaRet table(
  ID                    int IDENTITY(1,1),
  Almacen               varchar(10)   NULL,
  Nombre                varchar(100)  NULL,
  Direccion             varchar(100)  NULL,
  NombreMostar          varchar(100)  NULL,
  Porcentaje            float         NULL
)

INSERT INTO @TablaRet(Almacen,Nombre,Direccion,NombreMostar,Porcentaje)
SELECT LTRIM(RTRIM(ISNULL(a.Almacen,''))),
       LTRIM(RTRIM(ISNULL(a.Nombre,''))),
       LTRIM(RTRIM(ISNULL(a.Direccion,''))),
       LTRIM(RTRIM(ISNULL(d.Nombre,''))),
       ISNULL(d.Porcentaje,0)
  FROM Alm a
  LEFT JOIN AlmDist d ON (a.Almacen = d.Almacen)
 WHERE a.Estatus = 'ALTA'
   AND d.Empresa = @Empresa
   AND d.Distribuir = 1

DELETE FROM @TablaRet WHERE Almacen = @AlmacenOrigen

SELECT
  Almacen               AS [Almacen],
  Nombre                AS [Nombre],
  Direccion             AS [Direccion] ,
  NombreMostar          AS [NombreMostar],
  Porcentaje            AS [Porcentaje]
FROM @TablaRet
ORDER BY ID

END
GO

/**************** spDistMinMax ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistMinMax' AND Type = 'P')  DROP PROCEDURE spDistMinMax
GO
CREATE PROCEDURE spDistMinMax (
  @Empresa              varchar(5),
  @AlmacenOrigen        varchar(10),
  @Articulo             varchar(20)
)
--//WITH ENCRYPTION
AS
BEGIN

  SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @AlmacenOrigen = LTRIM(RTRIM(ISNULL(@AlmacenOrigen,'')))
  SET @Articulo = LTRIM(RTRIM(ISNULL(@Articulo,'')))

  DECLARE @Subcuenta      varchar(20)
  DECLARE @Descripcion    varchar(1000)
  DECLARE @SC1            varchar(20)
  DECLARE @SC2            varchar(20)
  DECLARE @Opcion1        varchar(1)
  DECLARE @Opcion2        varchar(1)
  DECLARE @i              int
  DECLARE @j              int
  DECLARE @iMax           int
  DECLARE @jMax           int

  DECLARE @Opciones       bit

  DECLARE @TablaAlm table(
    ID                    int IDENTITY(1,1),
    Almacen               varchar(10)   NULL
  )

  DECLARE @TablaOpcion table(
    ID                    int IDENTITY(1,1),
    Opcion                char(1)       NULL
  )

  DECLARE @TablaOpcionD table(
    ID                    int IDENTITY(1,1),
    Opcion                char(1)       NULL,
    Numero                int           NULL,
    Nombre                varchar(100)  NULL,
    InformacionAdicional  varchar(100)  NULL,
    Imagen                varchar(255)  NULL
  )

  DECLARE @TablaSubcuenta table(
    ID                    int IDENTITY(1,1),
    Articulo              varchar(20)   NULL,
    Subcuenta             varchar(20)   NULL,
    Disponible            float         NULL DEFAULT 0
  )

  DECLARE @TablaRet table(
    ID                    int IDENTITY(1,1),
    Empresa               varchar(5)    NULL,
    Almacen               varchar(10)   NULL,
    Articulo              varchar(20)   NULL,
    Subcuenta             varchar(100)  NULL,
    Descripcion           varchar(1000) NULL,
    Minimo                float         NULL DEFAULT 0,
    Maximo                float         NULL DEFAULT 0
  )

  SET @Subcuenta     = ''
  SET @SC1           = ''
  SET @SC2           = ''
  SET @Opcion1       = ''
  SET @Opcion2       = ''

  SET @i             = 0
  SET @j             = 0
  SET @iMax          = 0
  SET @jMax          = 0

  SELECT @Descripcion = UPPER(LTRIM(RTRIM(ISNULL(Descripcion1,'')))) FROM Art WHERE Articulo = @Articulo

  INSERT INTO @TablaAlm (Almacen)
  SELECT a.Almacen
    FROM AlmDist a
    JOIN Alm b ON (a.Almacen = b.Almacen)
   WHERE a.Empresa = @Empresa
     AND a.Distribuir = 1
     AND NOT a.Almacen = @AlmacenOrigen
     AND b.Estatus = 'ALTA'
  ORDER BY a.Nombre

  INSERT INTO @TablaOpcionD EXEC spVerOpcionD @Articulo

  IF EXISTS(SELECT TOP 1 ID FROM @TablaOpcionD) SET @Opciones = 1 ELSE SET @Opciones = 0

  IF @Opciones = 1
    BEGIN
      INSERT INTO @TablaOpcion (Opcion) SELECT Opcion FROM @TablaOpcionD GROUP BY Opcion

      SELECT @Opcion1 = Opcion FROM @TablaOpcion WHERE ID = 1
      SELECT @Opcion2 = Opcion FROM @TablaOpcion WHERE ID = 2

      SET @i = 1
      SELECT @iMax = MAX(ID) FROM @TablaOpcionD WHERE Opcion = @Opcion1
      SET @j = @iMax  + 1
      SELECT @jMax = MAX(ID) FROM @TablaOpcionD WHERE Opcion = @Opcion2

      /* Si @jMax es nula solo tiene una opcion */
      IF ISNULL(@jMax,0) = 0
      BEGIN
        WHILE @i <= @iMax
            BEGIN
                SELECT @SC1 = Opcion + CAST(Numero AS VARCHAR(10)) FROM @TablaOpcionD WHERE ID = (@i) + ' '  
                SET @Subcuenta = @SC1 

                INSERT INTO @TablaSubcuenta (Articulo,Subcuenta) VALUES(@Articulo,@Subcuenta)

              SET @SC1 = ''
              SET @i = @i + 1
            END
      END

      WHILE @i <= @iMax
        BEGIN
          SELECT @SC1 = Opcion + CAST(Numero AS VARCHAR(10)) FROM @TablaOpcionD WHERE ID = (@i) + ' '
          WHILE @j <= @jMax
            BEGIN
              SELECT @SC2 = Opcion + CAST(Numero AS VARCHAR(10)) FROM @TablaOpcionD WHERE ID = (@j)
              SET @Subcuenta = @SC1 + @SC2

              INSERT INTO @TablaSubcuenta (Articulo,Subcuenta) VALUES(@Articulo,@Subcuenta)

              SET @SC2 = ''
              SET @j = @j + 1
            END

          SET @j = @iMax  + 1
          SET @SC1 = ''
          SET @i = @i + 1
        END
    END
  ELSE
    BEGIN
      INSERT INTO @TablaSubcuenta (Articulo,Subcuenta) VALUES(@Articulo,@Subcuenta)
    END

  UPDATE @TablaSubcuenta
     SET Disponible = ISNULL(b.Disponible,0)
    FROM @TablaSubcuenta a INNER JOIN ArtSubDisponible b ON (a.Articulo = b.Articulo AND a.Subcuenta = b.Subcuenta)
   WHERE b.Empresa = @Empresa AND b.Almacen = @AlmacenOrigen

  DELETE FROM @TablaSubcuenta WHERE Disponible = 0

  INSERT INTO @TablaRet (Almacen,Articulo,Subcuenta)
  SELECT a.Almacen,s.Articulo,s.Subcuenta
    FROM @TablaAlm a
   CROSS JOIN @TablaSubcuenta s
   ORDER BY 1,2,3

  IF @Opciones = 1
    BEGIN
      UPDATE @TablaRet SET Descripcion = dbo.fnSubcuenta(Subcuenta)
    END
  ELSE
    BEGIN
      UPDATE @TablaRet SET Descripcion = @Descripcion
    END

  UPDATE @TablaRet SET Empresa = @Empresa

  UPDATE @TablaRet
     SET Minimo = ISNULL( b.Minimo,0), Maximo = ISNULL( b.Maximo,0)
    FROM @TablaRet a INNER JOIN ArtAlm b ON (a.Articulo = b.Articulo AND a.Subcuenta = b.Subcuenta AND a.Almacen = b.Almacen AND a.Empresa = b.Empresa)

  -->
  SELECT Almacen,Articulo,Subcuenta,Descripcion,Minimo,Maximo FROM @TablaRet ORDER BY ID
END
GO


/**************** spDistArticuloFactor ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistArticuloFactor' AND Type = 'P')  DROP PROCEDURE spDistArticuloFactor
GO
CREATE PROCEDURE spDistArticuloFactor (
  @Empresa                varchar(5),
  @AlmacenOrigen          varchar(10),
  @Articulo               varchar(20)
)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Subcuenta      varchar(20)
  DECLARE @Descripcion    varchar(1000)
  DECLARE @Disponible     float
  DECLARE @SC1            varchar(20)
  DECLARE @SC2            varchar(20)
  DECLARE @Opcion1        varchar(1)
  DECLARE @Opcion2        varchar(1)
  DECLARE @i              int
  DECLARE @j              int
  DECLARE @iMax           int
  DECLARE @jMax           int
  DECLARE @Opciones       bit

  DECLARE @TablaOpcion table(
    ID                    int IDENTITY(1,1),
    Opcion                char(1)       NULL
  )

  DECLARE @TablaOpcionD table(
    ID                    int IDENTITY(1,1),
    Opcion                char(1)       NULL,
    Numero                int           NULL,
    Nombre                varchar(100)  NULL,
    InformacionAdicional  varchar(100)  NULL,
    Imagen                varchar(255)  NULL
  )

  DECLARE @TablaSubcuenta table(
    ID                    int IDENTITY(1,1),
    Empresa               varchar(5),
    Almacen               varchar(10),
    Articulo              varchar(20)   NULL,
    Subcuenta             varchar(20)   NULL,
    Disponible            float         NULL
  )

  DECLARE @TablaRet table(
    ID                    int IDENTITY(1,1),
    Empresa               varchar(5)  NOT NULL,
    Articulo              varchar(20) NOT NULL,
    SubCuenta             varchar(50) NOT NULL,
    Descripcion           varchar(1000) NULL,
    Unidad                varchar(50) NULL DEFAULT 'pza',
    Factor                float       NULL DEFAULT 1
  )

  SET @Empresa       = UPPER(LTRIM(RTRIM(@Empresa)))
  SET @AlmacenOrigen = UPPER(LTRIM(RTRIM(@AlmacenOrigen)))
  SET @Articulo      = UPPER(LTRIM(RTRIM(@Articulo)))

  SET @Subcuenta     = ''
  SET @SC1           = ''
  SET @SC2           = ''
  SET @Opcion1       = ''
  SET @Opcion2       = ''
  SET @Disponible    = 0

  SET @i             = 0
  SET @j             = 0
  SET @iMax          = 0
  SET @jMax          = 0

  SELECT @Descripcion = UPPER(LTRIM(RTRIM(ISNULL(Descripcion1,'')))) FROM Art WHERE Articulo = @Articulo

  INSERT INTO @TablaOpcionD EXEC spVerOpcionD @Articulo

  IF EXISTS(SELECT TOP 1 ID FROM @TablaOpcionD) SET @Opciones = 1 ELSE SET @Opciones = 0

  IF @Opciones = 1
    BEGIN
      INSERT INTO @TablaOpcion (Opcion) SELECT Opcion FROM @TablaOpcionD GROUP BY Opcion

      SELECT @Opcion1 = Opcion FROM @TablaOpcion WHERE ID = 1
      SELECT @Opcion2 = Opcion FROM @TablaOpcion WHERE ID = 2

      SET @i = 1
      SELECT @iMax = MAX(ID) FROM @TablaOpcionD WHERE Opcion = @Opcion1
      SET @j = @iMax  + 1
      SELECT @jMax = MAX(ID) FROM @TablaOpcionD WHERE Opcion = @Opcion2

      /* Si @jMax es nula solo tiene una opcion */
      IF ISNULL(@jMax,0) = 0
      BEGIN
        WHILE @i <= @iMax
            BEGIN
                SELECT @SC1 = Opcion + CAST(Numero AS VARCHAR(10)) FROM @TablaOpcionD WHERE ID = (@i) + ' '  
                SET @Subcuenta = @SC1 

                INSERT INTO @TablaSubcuenta (Empresa,Almacen,Articulo,Subcuenta,Disponible) VALUES(@Empresa,@AlmacenOrigen,@Articulo,@Subcuenta,@Disponible)

              SET @SC1 = ''
              SET @i = @i + 1
            END
      END

      WHILE @i <= @iMax
        BEGIN
          SELECT @SC1 = Opcion + CAST(Numero AS VARCHAR(10)) FROM @TablaOpcionD WHERE ID = (@i) + ' '
          WHILE @j <= @jMax
            BEGIN
              SELECT @SC2 = Opcion + CAST(Numero AS VARCHAR(10)) FROM @TablaOpcionD WHERE ID = (@j)
              SET @Subcuenta = @SC1 + @SC2

              INSERT INTO @TablaSubcuenta (Empresa,Almacen,Articulo,Subcuenta,Disponible) VALUES(@Empresa,@AlmacenOrigen,@Articulo,@Subcuenta,@Disponible)

              SET @SC2 = ''
              SET @j = @j + 1
            END

          SET @j = @iMax  + 1
          SET @SC1 = ''
          SET @i = @i + 1
        END
    END
  ELSE
    BEGIN
      INSERT INTO @TablaSubcuenta (Empresa,Almacen,Articulo,Subcuenta,Disponible) VALUES(@Empresa,@AlmacenOrigen,@Articulo,@Subcuenta,@Disponible)
    END

  UPDATE @TablaSubcuenta SET Disponible = ISNULL(b.Disponible,0)
    FROM @TablaSubcuenta a INNER JOIN ArtSubDisponible b
      ON (a.Empresa = b.Empresa AND a.Almacen = b.Almacen AND a.Articulo = b.Articulo AND a.Subcuenta = b.Subcuenta)

  DELETE @TablaSubcuenta WHERE Disponible = 0

  INSERT INTO @TablaRet(Empresa,Articulo,SubCuenta)
  SELECT @Empresa,Articulo,Subcuenta FROM @TablaSubcuenta

  IF @Opciones = 1
     BEGIN
      UPDATE @TablaRet SET Descripcion = dbo.fnSubcuenta(Subcuenta)
    END
  ELSE
    BEGIN
      UPDATE @TablaRet SET Descripcion = @Descripcion
    END

  UPDATE @TablaRet SET Unidad = ISNULL(b.Unidad,'pza'), Factor = ISNULL(b.Factor,1)
    FROM @TablaRet a INNER JOIN DistArtUnidad b
      ON (a.Empresa = b.Empresa AND a.Articulo = b.Articulo AND a.SubCuenta = b.SubCuenta)

  -->
  SELECT ID,Empresa,Articulo,SubCuenta,Descripcion,Unidad,Factor FROM @TablaRet
END
GO


/**************** spDistArticulos ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistArticulos' AND Type = 'P')  DROP PROCEDURE spDistArticulos
GO
CREATE PROCEDURE spDistArticulos (
  @Empresa              varchar(5),
  @Almacen              varchar(10),
  @Articulo             varchar(20),
  @Descripcion1         varchar(100),
  @Rama                 varchar(20),
  @Grupo                varchar(50),
  @Categoria            varchar(50),
  @Familia              varchar(50),
  @Linea                varchar(50),
  @Fabricante           varchar(50)
)
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @q              nvarchar(max)  -- query
DECLARE @a              char(1)        -- asterisco
DECLARE @p              char(1)        -- porciento
DECLARE @c              char(1)        -- comilla
DECLARE @r              char(1)        -- retorno
DECLARE @maximo         int            -- numero maximo de registros
DECLARE @comodin        int            -- posicion del caracter comodin (*)

DECLARE @ArticuloRet    varchar(20)    -- auxiliar para ciclo while
DECLARE @Disponible     FLOAT          -- disponibilidad del artículo (sin considerar opciones)
DECLARE @i              int            -- indice
DECLARE @k              int            -- limite

DECLARE @TablaPre table(
  [Articulo]            varchar(20)  NULL,
  [Descripcion]         varchar(100) NULL,
  [Rama]                varchar(20)  NULL,
  [Grupo]               varchar(50)  NULL,
  [Categoria]           varchar(50)  NULL,
  [Familia]             varchar(50)  NULL,
  [Linea]               varchar(50)  NULL,
  [Fabricante]          varchar(50)  NULL
)

DECLARE @TablaRet table(
  [ID]                  int IDENTITY(1,1),
  [Empresa]             varchar(5)   NULL,
  [Almacen]             varchar(10)  NULL,
  [Articulo]            varchar(20)  NULL,
  [Descripcion]         varchar(100) NULL,
  [Rama]                varchar(20)  NULL,
  [Grupo]               varchar(50)  NULL,
  [Categoria]           varchar(50)  NULL,
  [Familia]             varchar(50)  NULL,
  [Linea]               varchar(50)  NULL,
  [Fabricante]          varchar(50)  NULL,
  [Disponible]          float        NULL
)

SET @q = ''
SET @a = CHAR(42)
SET @p = CHAR(37)
SET @c = CHAR(39)
SET @r = CHAR(13)
SET @maximo = 100
SET @comodin = 0

SET @ArticuloRet = ''
SET @Disponible = 0
SET @i = 0
SET @k = 0

SET @Empresa      = ISNULL(@Empresa,'')
SET @Articulo     = ISNULL(@Articulo,'')
SET @Descripcion1 = ISNULL(@Descripcion1,'')
SET @Rama         = ISNULL(@Rama,'')
SET @Grupo        = ISNULL(@Grupo,'')
SET @Categoria    = ISNULL(@Categoria,'')
SET @Familia      = ISNULL(@Familia,'')
SET @Linea        = ISNULL(@Linea,'')
SET @Fabricante   = ISNULL(@Fabricante,'')


SET @q = N'
DECLARE @TablaTmp table(
  [Articulo]            varchar(20),
  [Descripcion]         varchar(100),
  [Rama]                varchar(20),
  [Grupo]               varchar(50),
  [Categoria]           varchar(50),
  [Familia]             varchar(50),
  [Linea]               varchar(50),
  [Fabricante]          varchar(50)
)
'

SET @q = @q + @r + 'INSERT INTO @TablaTmp([Articulo],[Descripcion],[Rama],[Grupo],[Categoria],[Familia],[Linea],[Fabricante])'
SET @q = @q + @r + 'SELECT LTRIM(RTRIM(Articulo)), LTRIM(RTRIM(Descripcion1)), LTRIM(RTRIM(Rama)), LTRIM(RTRIM(Grupo)), LTRIM(RTRIM(Categoria)), LTRIM(RTRIM(Familia)), LTRIM(RTRIM(Linea)), LTRIM(RTRIM(Fabricante))'
SET @q = @q + @r + 'FROM Art WHERE Estatus = ' + @c + 'ALTA' + @c + ' AND Tipo = '  + @c + 'Normal' + @c

IF LEN(@Articulo) > 0
  BEGIN
    SET @comodin = CHARINDEX(@a,@Articulo)
    IF @comodin > 0
      BEGIN
        SET @Articulo = LEFT(@Articulo, (@comodin - 1))
        SET @q = @q + @r + 'AND Articulo LIKE ' + @c +  @Articulo + @p + @c
      END
    ELSE
      BEGIN
        SET @q = @q + @r + 'AND Articulo = ' + @c +  @Articulo + @c
      END
  END
ELSE IF LEN(@Descripcion1) > 0
  BEGIN
    SET @comodin = CHARINDEX(@a,@Descripcion1)
    IF @comodin > 0
      BEGIN
        SET @Descripcion1 = LEFT(@Descripcion1, (@comodin - 1))
        SET @q = @q + @r + 'AND Descripcion1 LIKE ' + @c +  @Descripcion1 + @p + @c
      END
    ELSE
      BEGIN
        SET @q = @q + @r + 'AND Descripcion1 = ' + @c +  @Descripcion1 + @c
      END
  END

IF LEN(@Rama)         > 0 SET @q = @q + @r + 'AND Rama = '       + @c + @Rama       + @c
IF LEN(@Grupo)        > 0 SET @q = @q + @r + 'AND Grupo = '      + @c + @Grupo      + @c
IF LEN(@Categoria)    > 0 SET @q = @q + @r + 'AND Categoria = '  + @c + @Categoria  + @c
IF LEN(@Familia)      > 0 SET @q = @q + @r + 'AND Familia = '    + @c + @Familia    + @c
IF LEN(@Linea)        > 0 SET @q = @q + @r + 'AND Linea = '      + @c + @Linea      + @c
IF LEN(@Fabricante)   > 0 SET @q = @q + @r + 'AND Fabricante = ' + @c + @Fabricante + @c

SET @q = @q + @r + @r + 'SELECT TOP ' + CAST(@maximo AS VARCHAR(4)) + ' [Articulo],[Descripcion],[Rama],[Grupo],[Categoria],[Familia],[Linea],[Fabricante] FROM @TablaTmp'

INSERT INTO @TablaPre EXEC sp_executesql @q

INSERT INTO @TablaRet (Empresa,Almacen,Articulo,Descripcion,Rama,Grupo,Categoria,Familia,Linea,Fabricante,Disponible)
SELECT @Empresa,@ALmacen,Articulo,Descripcion,Rama,Grupo,Categoria,Familia,Linea,Fabricante,@Disponible
  FROM @TablaPre

SELECT @k = MAX(ID) FROM @TablaRet
SET @i = 0

WHILE @i < @k
  BEGIN
    SET @i = @i + 1
    -->

    SELECT @ArticuloRet = Articulo FROM @TablaRet WHERE ID = @i

    SELECT @Disponible = SUM(Disponible)
     FROM ArtSubDisponible
    WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @ArticuloRet

    IF ISNULL(@Disponible,0) > 0
      BEGIN
        UPDATE @TablaRet SET Disponible = @Disponible WHERE ID = @i
      END

  END

-- >>
SELECT
       ID          AS 'ID',
       Empresa     AS 'Empresa',
       Almacen     AS 'Almacen',
       Articulo    AS 'Artículo',
       Descripcion AS 'Descripción',
       Rama        AS 'Rama',
       Grupo       AS 'Grupo',
       Categoria   AS 'Categoría',
       Familia     AS 'Familia',
       Linea       AS 'Línea',
       Fabricante  AS 'Fabricante',
       Disponible  AS 'Disponible'
  FROM @TablaRet
ORDER BY ID

END
GO


/**************** spDistRamaLista ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistRamaLista' AND Type = 'P')  DROP PROCEDURE spDistRamaLista
GO
CREATE PROCEDURE spDistRamaLista
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @TablaRet table(
  Clave  int IDENTITY(1,1),
  Nombre varchar(100)
)

INSERT INTO @TablaRet (Nombre) VALUES ('')
INSERT INTO @TablaRet (Nombre)
SELECT UPPER(LTRIM(RTRIM(Rama))) FROM Art WHERE LEN(LTRIM(RTRIM(ISNULL(Rama,'')))) > 0 GROUP BY Rama ORDER BY 1

SELECT Clave, Nombre FROM @TablaRet ORDER BY 1
END
GO


/**************** spDistGrupoLista ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistGrupoLista' AND Type = 'P')  DROP PROCEDURE spDistGrupoLista
GO
CREATE PROCEDURE spDistGrupoLista
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @TablaRet table(
  Clave  int IDENTITY(1,1),
  Nombre varchar(100)
)

INSERT INTO @TablaRet (Nombre) VALUES ('')
INSERT INTO @TablaRet (Nombre)
SELECT UPPER(LTRIM(RTRIM(Grupo))) FROM Art WHERE LEN(LTRIM(RTRIM(ISNULL(Grupo,'')))) > 0 GROUP BY Grupo ORDER BY 1

SELECT Clave, Nombre FROM @TablaRet ORDER BY 1
END
GO


/**************** spDistCategoriaLista ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistCategoriaLista' AND Type = 'P')  DROP PROCEDURE spDistCategoriaLista
GO
CREATE PROCEDURE spDistCategoriaLista
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @TablaRet table(
  Clave  int IDENTITY(1,1),
  Nombre varchar(100)
)

INSERT INTO @TablaRet (Nombre) VALUES ('')
INSERT INTO @TablaRet (Nombre)
SELECT UPPER(LTRIM(RTRIM(Categoria))) FROM Art WHERE LEN(LTRIM(RTRIM(ISNULL(Categoria,'')))) > 0 GROUP BY Categoria ORDER BY 1

SELECT Clave, Nombre FROM @TablaRet ORDER BY 1
END
GO


/**************** spDistFamiliaLista ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistFamiliaLista' AND Type = 'P')  DROP PROCEDURE spDistFamiliaLista
GO
CREATE PROCEDURE spDistFamiliaLista
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @TablaRet table(
  Clave  int IDENTITY(1,1),
  Nombre varchar(100)
)

INSERT INTO @TablaRet (Nombre) VALUES ('')
INSERT INTO @TablaRet (Nombre)
SELECT UPPER(LTRIM(RTRIM(Familia))) FROM Art WHERE LEN(LTRIM(RTRIM(ISNULL(Familia,'')))) > 0 GROUP BY Familia ORDER BY 1

SELECT Clave, Nombre FROM @TablaRet ORDER BY 1
END
GO


/**************** spDistLineaLista ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistLineaLista' AND Type = 'P')  DROP PROCEDURE spDistLineaLista
GO
CREATE PROCEDURE spDistLineaLista
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @TablaRet table(
  Clave  int IDENTITY(1,1),
  Nombre varchar(100)
)

INSERT INTO @TablaRet (Nombre) VALUES ('')
INSERT INTO @TablaRet (Nombre)
SELECT UPPER(LTRIM(RTRIM(Linea))) FROM Art WHERE LEN(LTRIM(RTRIM(ISNULL(Linea,'')))) > 0 GROUP BY Linea ORDER BY 1

SELECT Clave, Nombre FROM @TablaRet ORDER BY 1
END
GO


/**************** spDistFabricanteLista ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistFabricanteLista' AND Type = 'P')  DROP PROCEDURE spDistFabricanteLista
GO
CREATE PROCEDURE spDistFabricanteLista
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @TablaRet table(
  Clave  int IDENTITY(1,1),
  Nombre varchar(100)
)

INSERT INTO @TablaRet (Nombre) VALUES ('')
INSERT INTO @TablaRet (Nombre)
SELECT UPPER(LTRIM(RTRIM(Fabricante))) FROM Art WHERE LEN(LTRIM(RTRIM(ISNULL(Fabricante,'')))) > 0 GROUP BY Fabricante ORDER BY 1

SELECT Clave, Nombre FROM @TablaRet ORDER BY 1
END
GO


/**************** spDistArticulo ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistArticulo' AND Type = 'P')  DROP PROCEDURE spDistArticulo
GO
CREATE PROCEDURE spDistArticulo
 @Articulo              varchar(20)
--//WITH ENCRYPTION
AS
BEGIN
SET @Articulo = LTRIM(RTRIM(ISNULL(@Articulo,'')))

SELECT LTRIM(RTRIM(ISNULL(Articulo,''))) AS Articulo,
       LTRIM(RTRIM(ISNULL(Descripcion1,''))) AS Descripcion1
  FROM Art
 WHERE Articulo = @Articulo

END
GO

/**************** spDistArticuloImagen ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistArticuloImagen' AND Type = 'P')  DROP PROCEDURE spDistArticuloImagen
GO
CREATE PROCEDURE spDistArticuloImagen (
  @Empresa              varchar(5),
  @Articulo             varchar(20)
)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Nombre       varchar(255)
  DECLARE @Direccion    varchar(255)
  DECLARE @Rama         varchar(5)
  DECLARE @Tipo         varchar(10)

  SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Articulo = LTRIM(RTRIM(ISNULL(@Articulo,'')))
  SET @Rama     = 'INV'
  SET @Tipo     = 'Imagen'

  SELECT TOP 1
         @Nombre    = LTRIM(RTRIM(ISNULL(Nombre,''))),
         @Direccion = LTRIM(RTRIM(ISNULL(Direccion,'')))
    FROM AnexoCta
   WHERE Rama = @Rama
     AND Tipo = @Tipo
     AND Cuenta = @Articulo
   ORDER BY Orden

  -- >
  SELECT @Nombre AS Nombre, @Direccion AS Direccion
END
GO


/**************** spDistDisponible ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistDisponible' AND Type = 'P')  DROP PROCEDURE spDistDisponible
GO
CREATE PROCEDURE spDistDisponible
  @Empresa                varchar(5),
  @AlmacenOrigen          varchar(10),
  @Articulo               varchar(20),
  @Corrida                int
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Subcuenta      varchar(20)
  DECLARE @Descripcion    varchar(1000)
  DECLARE @Disponible     float
  DECLARE @SC1            varchar(20)
  DECLARE @SC2            varchar(20)
  DECLARE @Opcion1        varchar(1)
  DECLARE @Opcion2        varchar(1)
  DECLARE @i              int
  DECLARE @j              int
  DECLARE @iMax           int
  DECLARE @jMax           int
  DECLARE @ArticuloCr     varchar(20)
  DECLARE @SubcuentaCr    varchar(20)
  DECLARE @TransferirCr   float
  DECLARE @Opciones       bit

  DECLARE @AlmacenOrigenNombre varchar(10)
  DECLARE @EsOrigen            bit
  DECLARE @EsDestino           bit

  DECLARE @TablaAlm table(
    ID                    int IDENTITY(1,1),
    Almacen               varchar(10)   NULL,
    Nombre                varchar(100)   NULL
  )

  DECLARE @TablaOpcion table(
    ID                    int IDENTITY(1,1),
    Opcion                char(1)       NULL
  )

  DECLARE @TablaOpcionD table(
    ID                    int IDENTITY(1,1),
    Opcion                char(1)       NULL,
    Numero                int           NULL,
    Nombre                varchar(100)  NULL,
    InformacionAdicional  varchar(100)  NULL,
    Imagen                varchar(255)  NULL
  )

  DECLARE @TablaSubcuenta table(
    ID                    int IDENTITY(1,1),
    Almacen               varchar(10)   NULL,
    Articulo              varchar(20)   NULL,
    Subcuenta             varchar(20)   NULL,
    Descripcion           varchar(1000) NULL
  )

  DECLARE @TablaTmp table(
    ID                    int IDENTITY(1,1),
    Empresa               varchar(5)    NULL,
    Almacen               varchar(10)   NULL,
    Nombre                varchar(100)  NULL,
    Articulo              varchar(20)   NULL,
    Subcuenta             varchar(100)  NULL,
    Descripcion           varchar(1000) NULL,
    Disponible            float         NULL,
    Transferir            float         NULL DEFAULT 0
  )

  DECLARE @TablaPre table(
    ID                    int IDENTITY(1,1),
    Empresa               varchar(5)    NULL,
    Almacen               varchar(10)   NULL,
    Nombre                varchar(100)  NULL,
    Articulo              varchar(20)   NULL,
    Subcuenta             varchar(100)  NULL,
    Descripcion           varchar(1000) NULL,
    Disponible            float         NULL DEFAULT 0,
    Transferir            float         NULL DEFAULT 0
  )

  DECLARE @TablaRet table(
    ID                    int IDENTITY(1,1),
    Empresa               varchar(5)    NULL,
    Almacen               varchar(10)   NULL,
    Nombre                varchar(100)  NULL,
    Articulo              varchar(20)   NULL,
    Subcuenta             varchar(100)  NULL,
    Descripcion           varchar(1000) NULL,
    Disponible            float         NULL,
    Transferir            float         NULL,
    Virtual               float         NULL
  )

  SET @Empresa       = UPPER(LTRIM(RTRIM(ISNULL(@Empresa,''))))
  SET @AlmacenOrigen = UPPER(LTRIM(RTRIM(ISNULL(@AlmacenOrigen,''))))
  SET @Articulo      = UPPER(LTRIM(RTRIM(ISNULL(@Articulo,''))))
  SET @Corrida       = ISNULL(@Corrida,0)

  SET @Subcuenta     = ''
  SET @SC1           = ''
  SET @SC2           = ''
  SET @Opcion1       = ''
  SET @Opcion2       = ''
  SET @Disponible    = 0

  SET @i             = 0
  SET @j             = 0
  SET @iMax          = 0
  SET @jMax          = 0

  SELECT @Descripcion = UPPER(LTRIM(RTRIM(ISNULL(Descripcion1,'')))) FROM Art WHERE Articulo = @Articulo  

  SELECT @EsDestino = EsDestino, @AlmacenOrigenNombre = Nombre
    FROM AlmDist
   WHERE Empresa = @Empresa AND Almacen = @AlmacenOrigen

  SET @EsDestino = ISNULL(@EsDestino,0)
  SET @AlmacenOrigenNombre = ISNULL(@AlmacenOrigenNombre,'')

  PRINT @EsDestino
  PRINT @AlmacenOrigenNombre

  IF @EsDestino = 0
    BEGIN
      INSERT INTO @TablaAlm (Almacen,Nombre) VALUES (@AlmacenOrigen,@AlmacenOrigenNombre)
      PRINT 'ES DESTINO'
    END

  INSERT INTO @TablaAlm (Almacen,Nombre)
  SELECT a.Almacen,a.Nombre
    FROM AlmDist a
    JOIN Alm b ON (a.Almacen = b.Almacen)
   WHERE a.Empresa = @Empresa
     AND a.Distribuir = 1
     AND a.EsDestino = 1
     AND b.Estatus = 'ALTA'
  ORDER BY a.Nombre

  INSERT INTO @TablaOpcionD EXEC spVerOpcionD @Articulo
  IF EXISTS(SELECT TOP 1 ID FROM @TablaOpcionD) SET @Opciones = 1 ELSE SET @Opciones = 0

  IF @Opciones = 1
    BEGIN
      INSERT INTO @TablaOpcion (Opcion) SELECT Opcion FROM @TablaOpcionD GROUP BY Opcion

      SELECT @Opcion1 = Opcion FROM @TablaOpcion WHERE ID = 1
      SELECT @Opcion2 = Opcion FROM @TablaOpcion WHERE ID = 2

      SET @i = 1
      SELECT @iMax = MAX(ID) FROM @TablaOpcionD WHERE Opcion = @Opcion1

      SET @j = @iMax + 1
      SELECT @jMax = MAX(ID) FROM @TablaOpcionD WHERE Opcion = @Opcion2
      
      /* Si @jMax es nula solo tiene una opcion */
      IF ISNULL(@jMax,0) = 0
      BEGIN
        WHILE @i <= @iMax
            BEGIN
                SELECT @SC1 = Opcion + CAST(Numero AS VARCHAR(10)) FROM @TablaOpcionD WHERE ID = (@i) + ' '  
                SET @Subcuenta = @SC1 

                INSERT INTO @TablaSubcuenta (Almacen,Articulo,Subcuenta) VALUES(@AlmacenOrigen,@Articulo,@Subcuenta)

              SET @SC1 = ''
              SET @i = @i + 1
            END
      END

      /* Tiene 2 opciones */
      WHILE @i <= @iMax
        BEGIN
          SELECT @SC1 = Opcion + CAST(Numero AS VARCHAR(10)) FROM @TablaOpcionD WHERE ID = (@i) + ' '   

          WHILE @j <= @jMax
            BEGIN
              SELECT @SC2 = Opcion + CAST(Numero AS VARCHAR(10)) FROM @TablaOpcionD WHERE ID = (@j)
              SET @Subcuenta = @SC1 + @SC2

              INSERT INTO @TablaSubcuenta (Almacen,Articulo,Subcuenta) VALUES(@AlmacenOrigen,@Articulo,@Subcuenta)

              SET @SC2 = ''
              SET @j = @j + 1
            END

          SET @j = @iMax  + 1
          SET @SC1 = ''
          SET @i = @i + 1
        END
    END
  ELSE
    BEGIN
      INSERT INTO @TablaSubcuenta (Almacen,Articulo,Subcuenta) VALUES(@AlmacenOrigen,@Articulo,@Subcuenta)
    END

  INSERT INTO @TablaTmp (Empresa,Almacen,Nombre,Articulo,Subcuenta,Descripcion,Disponible)
  SELECT @Empresa,@AlmacenOrigen,UPPER(a.Nombre),@Articulo,t.Subcuenta,t.Descripcion,0
    FROM @TablaSubcuenta t LEFT JOIN @TablaAlm a ON (t.Almacen = a.Almacen)
   WHERE a.Almacen = @AlmacenOrigen

  UPDATE @TablaTmp SET Disponible = ISNULL(b.Disponible,0)
    FROM @TablaTmp a INNER JOIN ArtSubDisponible b
      ON (a.Empresa = b.Empresa AND a.Almacen = b.Almacen AND a.Articulo = b.Articulo AND a.Subcuenta = b.Subcuenta)

  IF @Corrida > 0
    BEGIN
      IF EXISTS (SELECT TOP 1 Corrida FROM Distribucion WHERE Corrida = @Corrida)
        BEGIN
          UPDATE @TablaTmp SET Transferir = 1
            FROM @TablaTmp a INNER JOIN Distribucion b
              ON (a.Empresa = b.Empresa AND a.Almacen = b.Almacen AND a.Articulo = b.Articulo AND a.Subcuenta = b.Subcuenta)
           WHERE b.Corrida = @Corrida
        END
    END

  DELETE @TablaTmp WHERE Disponible = 0 AND Transferir = 0

  IF @Opciones = 1
    BEGIN
      UPDATE @TablaTmp SET Descripcion = dbo.fnSubcuenta(Subcuenta)
    END
  ELSE
    BEGIN
      UPDATE @TablaTmp SET Descripcion = @Descripcion
    END

  INSERT INTO @TablaPre (Empresa, Almacen,Nombre,Articulo,Subcuenta,Descripcion)
  SELECT t.Empresa, a.Almacen,a.Nombre,t.Articulo, t.Subcuenta,t.Descripcion
    FROM @TablaTmp t
   CROSS JOIN @TablaAlm a
   WHERE a.Almacen = @AlmacenOrigen

  INSERT INTO @TablaPre (Empresa, Almacen,Nombre,Articulo,Subcuenta,Descripcion)
  SELECT t.Empresa, a.Almacen,a.Nombre,t.Articulo, t.Subcuenta,t.Descripcion
    FROM @TablaTmp t
   CROSS JOIN @TablaAlm a
   WHERE a.Almacen <> @AlmacenOrigen

  UPDATE @TablaPre SET Disponible = ISNULL(b.Disponible,0)
    FROM @TablaPre a INNER JOIN ArtSubDisponible b
      ON (a.Empresa = b.Empresa AND a.Almacen = b.Almacen AND a.Articulo = b.Articulo AND a.Subcuenta = b.Subcuenta)

  INSERT INTO @TablaRet (Empresa,Almacen,Nombre,Articulo,Subcuenta,Descripcion,Disponible,Transferir,Virtual)
  SELECT Empresa,Almacen,Nombre,Articulo,Subcuenta,Descripcion,Disponible,0,Disponible
    FROM @TablaPre
   WHERE Almacen = @AlmacenOrigen
   ORDER BY Almacen, Subcuenta

  INSERT INTO @TablaRet (Empresa,Almacen,Nombre,Articulo,Subcuenta,Descripcion,Disponible,Transferir,Virtual)
  SELECT Empresa,Almacen,Nombre,Articulo,Subcuenta,Descripcion,Disponible,0,Disponible
    FROM @TablaPre
   WHERE NOT Almacen = @AlmacenOrigen
   ORDER BY Almacen, Subcuenta

  IF @Corrida > 0
    BEGIN
      UPDATE @TablaRet SET Transferir = ISNULL(b.Cantidad,0)
        FROM @TablaRet a INNER JOIN Distribucion b
          ON (a.Empresa = b.Empresa AND a.Almacen = b.AlmacenDestino AND a.Articulo = b.Articulo AND a.Subcuenta = b.SubCuenta)
       WHERE b.Almacen = @AlmacenOrigen
         AND b.Corrida = @Corrida

      DECLARE crDistDisponibleCorrida CURSOR FOR
      SELECT Articulo,Subcuenta FROM @TablaRet WHERE Almacen = @AlmacenOrigen GROUP BY Articulo,Subcuenta

      OPEN crDistDisponibleCorrida
      FETCH NEXT FROM crDistDisponibleCorrida INTO @ArticuloCr,@SubcuentaCr
      WHILE @@FETCH_STATUS = 0
        BEGIN
          SELECT @TransferirCr = SUM(Transferir) FROM @TablaRet WHERE Articulo = @ArticuloCr AND Subcuenta = @SubcuentaCr
          SET @TransferirCr = ISNULL(@TransferirCr,0)

          UPDATE @TablaRet SET Transferir = @TransferirCr WHERE Almacen = @AlmacenOrigen AND Articulo = @ArticuloCr AND Subcuenta = @SubcuentaCr

          FETCH NEXT FROM crDistDisponibleCorrida INTO @ArticuloCr,@SubcuentaCr
       END
      CLOSE crDistDisponibleCorrida
      DEALLOCATE crDistDisponibleCorrida

      UPDATE @TablaRet
         SET Virtual = Disponible - Transferir
       WHERE Almacen = @AlmacenOrigen

      UPDATE @TablaRet
         SET Virtual = Disponible + Transferir
       WHERE NOT Almacen = @AlmacenOrigen

    END

  -- >
  SELECT ID,Almacen,Nombre,Articulo,Subcuenta,Descripcion,Disponible,Transferir,Virtual FROM @TablaRet ORDER BY ID
END
GO


/**************** spDistCorridaUltima ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistCorridaUltima' AND Type = 'P')  DROP PROCEDURE spDistCorridaUltima
GO
CREATE PROCEDURE spDistCorridaUltima (
  @Empresa              varchar(5)
)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Corrida int
  SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SELECT @Corrida = MAX(Corrida) FROM DistCorrida WHERE Empresa = @Empresa
  SELECT ISNULL(@Corrida,0) AS Corrida
END
GO


/**************** spDistCorridaLista ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistCorridaLista' AND Type = 'P')  DROP PROCEDURE spDistCorridaLista
GO
CREATE PROCEDURE spDistCorridaLista (
  @Empresa              varchar(5),
  @Sucursal             int,
  @Usuario              varchar(10),
  @Estacion             int
)
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @Corrida        int
DECLARE @FechaRegistro  datetime
DECLARE @i              int
DECLARE @k              int

DECLARE @TablaRet table(
  ID                    int IDENTITY(1,1),
  Empresa               varchar(5)   NULL,
  Corrida               int          NULL,
  Almacen               varchar(10)  NULL,
  FechaRegistro         datetime     NULL,
  Procesado             bit          NULL
)

SET @Empresa   = LTRIM(RTRIM(ISNULL(@Empresa,'')))
SET @Sucursal  = UPPER(LTRIM(RTRIM(ISNULL(@Sucursal,''))))
SET @Usuario   = UPPER(LTRIM(RTRIM(ISNULL(@Usuario,''))))
SET @Estacion  = ISNULL(@Estacion,1)

INSERT INTO @TablaRet(Empresa,Corrida,Almacen,Procesado)
SELECT Empresa,Corrida,Almacen,Procesado
  FROM Distribucion
 WHERE Empresa = @Empresa AND Procesado = 0
GROUP BY Empresa,Corrida,Almacen,Procesado

SELECT @k = MAX(ID) FROM @TablaRet
SET @i = 1
WHILE NOT @i > @k
  BEGIN
     SET @FechaRegistro = NULL

     SELECT @Corrida = Corrida FROM @TablaRet WHERE ID = @i
     SELECT @FechaRegistro = ISNULL(FechaRegistro,0) FROM Distribucion WHERE Corrida = @Corrida
     UPDATE @TablaRet SET FechaRegistro = @FechaRegistro WHERE ID = @i
     -->
     SET @i = @i + 1
  END

SELECT ID,Empresa,Corrida,Almacen,FechaRegistro,Procesado FROM @TablaRet
ORDER BY Corrida

END
GO


/**************** spDistCorridaArticulos ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistCorridaArticulos' AND Type = 'P')  DROP PROCEDURE spDistCorridaArticulos
GO
CREATE PROCEDURE spDistCorridaArticulos (
  @Empresa              varchar(5),
  @Sucursal             int,
  @Usuario              varchar(10),
  @Estacion             int,
  @Corrida              int
)
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @TablaRet table(
  ID                    int IDENTITY(1,1),
  Almacen               varchar(10)  NULL,
  AlmacenNombre         varchar(100) NULL,
  Articulo              varchar(20)  NULL,
  Descripcion           varchar(100) NULL
)

SET @Empresa   = LTRIM(RTRIM(ISNULL(@Empresa,'')))
SET @Sucursal  = UPPER(LTRIM(RTRIM(ISNULL(@Sucursal,''))))
SET @Usuario   = UPPER(LTRIM(RTRIM(ISNULL(@Usuario,''))))
SET @Estacion  = ISNULL(@Estacion,1)
SET @Corrida   = ISNULL(@Corrida,0)

INSERT INTO @TablaRet(ALmacen,Articulo)
SELECT ALmacen,Articulo
  FROM Distribucion
 WHERE Empresa = @Empresa
   AND Corrida = @Corrida
GROUP BY ALmacen,Articulo
ORDER BY ALmacen,Articulo

UPDATE
    @TablaRet
SET
    AlmacenNombre  = LTRIM(RTRIM(ISNULL(b.Nombre,'')))
FROM
    @TablaRet a
INNER JOIN
   AlmDist b
ON
   a.Almacen = b.Almacen
WHERE b.Empresa = @Empresa

UPDATE
    @TablaRet
SET
    Descripcion  = LTRIM(RTRIM(ISNULL(b.Descripcion1,'')))
FROM
    @TablaRet a
INNER JOIN
   Art b
ON
   a.Articulo = b.Articulo

SELECT ID,Almacen,AlmacenNombre,Articulo,Descripcion FROM @TablaRet ORDER BY ID

END
GO


/**************** spDistCorridaActualizar ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistCorridaActualizar' AND Type = 'P')  DROP PROCEDURE spDistCorridaActualizar
GO
CREATE PROCEDURE spDistCorridaActualizar (
  @Empresa              varchar(5),
  @Corrida              int
)
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @ret            bit
DECLARE @UltimaCorrida  int

SET @ret = 0

BEGIN TRY
  IF EXISTS(SELECT * FROM DistCorrida WHERE Empresa = @Empresa)
    BEGIN
      SELECT TOP 1 @UltimaCorrida = Corrida FROM DistCorrida WHERE Empresa = @Empresa
      SET @UltimaCorrida = ISNULL(@UltimaCorrida,0)
      IF @Corrida > @UltimaCorrida
        BEGIN
          UPDATE DistCorrida SET Corrida = @Corrida WHERE Empresa = @Empresa
        END
    END
  ELSE
    BEGIN
      INSERT INTO DistCorrida (Empresa, Corrida) VALUES (@Empresa, @Corrida)
    END

  SET @ret = 1
END TRY

BEGIN CATCH
  SET @ret = 0
END CATCH

SELECT @ret
END
GO


/**************** spDistCorridaGuardar ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistCorridaGuardar' AND Type = 'P')  DROP PROCEDURE spDistCorridaGuardar
GO
CREATE PROCEDURE spDistCorridaGuardar (
  @Empresa              varchar(5),
  @Corrida              int
)
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @ret            bit
DECLARE @Transaccion    varchar(100)

SET @ret = 0

SET @Empresa = UPPER(LTRIM(RTRIM(ISNULL(@Empresa,''))))
SET @Corrida = ISNULL(@Corrida,0)

SET @Transaccion = '@Empresa' + CAST(@Corrida AS varchar(95))

BEGIN TRY
  IF EXISTS (SELECT TOP 1 Corrida FROM DistribucionT WHERE Empresa = @Empresa AND Corrida = @Corrida)
    BEGIN
      BEGIN TRANSACTION @Transaccion

      MERGE INTO Distribucion t
      USING DistribucionT s
         ON t.Empresa        = s.Empresa
        AND t.corrida        = s.corrida
        AND t.ALmacen        = s.ALmacen
        AND t.AlmacenDestino = s.AlmacenDestino
        AND t.Articulo       = s.Articulo
        AND t.SubCuenta      = s.SubCuenta
      WHEN MATCHED THEN
        UPDATE
           SET Cantidad      = s.Cantidad,
               FechaRegistro = s.FechaRegistro
      WHEN NOT MATCHED BY TARGET THEN
        INSERT(Empresa,Sucursal,Usuario,Estacion,Corrida,Almacen,AlmacenDestino,Articulo,SubCuenta,Cantidad,
               FechaRegistro,FechaProcesado,Procesado)
        VALUES(s.Empresa,s.Sucursal,s.Usuario,s.Estacion,s.Corrida,s.Almacen,s.AlmacenDestino,s.Articulo,s.SubCuenta,s.Cantidad,
               s.FechaRegistro,s.FechaProcesado,s.Procesado);

      DELETE DistribucionT WHERE Empresa = @Empresa AND Corrida = @Corrida

      SET @ret = 1
      COMMIT TRAN @Transaccion
    END
END TRY

BEGIN CATCH
  SET @ret = 0
END CATCH

SELECT @ret
END
GO


/**************** spDistCorridaLimpiar ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistCorridaLimpiar' AND Type = 'P')  DROP PROCEDURE spDistCorridaLimpiar
GO
CREATE PROCEDURE spDistCorridaLimpiar
  @Empresa              varchar(5),
  @Corrida              int
--//WITH ENCRYPTION
AS
BEGIN
DECLARE @ret bit
SET @ret = 1

IF EXISTS(SELECT TOP 1 Empresa FROM Distribucion WHERE Empresa = @Empresa AND Corrida = @Corrida)
  BEGIN
    BEGIN TRY
      INSERT INTO DistribucionHist (Empresa,Sucursal,Usuario,Estacion,Corrida,Almacen,AlmacenDestino,Articulo,SubCuenta,Cantidad,FechaRegistro,FechaProcesado,Procesado)
      SELECT Empresa,Sucursal,Usuario,Estacion,Corrida,Almacen,AlmacenDestino,Articulo,SubCuenta,Cantidad,FechaRegistro,FechaProcesado,Procesado
        FROM Distribucion WHERE Empresa = @Empresa AND Corrida = @Corrida AND Procesado = 1 AND ISNULL(Cantidad,0) > 0

      DELETE FROM Distribucion WHERE Empresa = @Empresa AND Corrida = @Corrida AND Procesado = 1
      DELETE FROM Distribucion WHERE Empresa = @Empresa AND Corrida = @Corrida AND ISNULL(Cantidad,0) = 0
    END TRY

    BEGIN CATCH
      SET @ret = 0
    END CATCH
  END

-->
SELECT @ret
END
GO


/**************** spDistCorridaCancelar ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistCorridaCancelar' AND Type = 'P')  DROP PROCEDURE spDistCorridaCancelar
GO
CREATE PROCEDURE spDistCorridaCancelar
  @Empresa              varchar(5),
  @Corrida              int
--//WITH ENCRYPTION
AS
BEGIN
DECLARE @ret bit
SET @ret = 1

IF EXISTS(SELECT TOP 1 Empresa FROM Distribucion WHERE Empresa = @Empresa AND Corrida = @Corrida)
  BEGIN
    BEGIN TRY
      INSERT INTO DistribucionHist (Empresa,Sucursal,Usuario,Estacion,Corrida,Almacen,AlmacenDestino,Articulo,SubCuenta,Cantidad,FechaRegistro,FechaProcesado,Procesado)
      SELECT Empresa,Sucursal,Usuario,Estacion,Corrida,Almacen,AlmacenDestino,Articulo,SubCuenta,Cantidad,FechaRegistro,FechaProcesado,Procesado
        FROM Distribucion WHERE Empresa = @Empresa AND Corrida = @Corrida AND Procesado = 0

      DELETE FROM Distribucion WHERE Empresa = @Empresa AND Corrida = @Corrida AND Procesado = 0
    END TRY

    BEGIN CATCH
      SET @ret = 0
    END CATCH
  END

-->
SELECT @ret
END
GO


/**************** spDistribucion ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistribucion' AND Type = 'P')  DROP PROCEDURE spDistribucion
GO
CREATE PROCEDURE spDistribucion (
  @Empresa              varchar(5),
  @Sucursal             int,
  @Usuario              varchar(10),
  @Estacion             int,
  @Corrida              int,
  @Almacen              varchar(10)
)
--//WITH ENCRYPTION
AS
BEGIN

-- Auxiliares
DECLARE
  @NombreTrans          varchar(255),
  @SPID                 varchar(20),
  @FechaHoy             datetime,
  @Cuenta               int,
  @Generados            int,
  @idx                  int,
  @MovIdLog             varchar(20),
  @EstatusLog           varchar(15),
  @Observacion          varchar(4000),
  @Mensaje              varchar(4000),
  @AlmacenOrigen        varchar(10),
  @ArtTipo              varchar(20)

-- Movimiento (Orden de Traspaso)
DECLARE
  @MovEstatus           varchar(15),
  @MovConsecutivo       bit,
  @MovReservar          bit

-- SpAfectar
DECLARE
  @Modulo               varchar(5),
  @Accion               varchar(20),
  @Base                 varchar(20),
  @GenerarMov           varchar(20),
  @SincroFinal          bit,
  @EnSilencio           bit,
  @Conexion             bit,
  @Ok                   int,
  @OkRef                varchar(255),
  @FechaRegistro        datetime

-- INV
DECLARE
  @ID                   int,
  @Mov                  varchar(20),
  @MovID                varchar(20),
  @FechaEmision         datetime,
  @Proyecto             varchar(50),
  @Moneda               varchar(10),
  @TipoCambio           float,
  @Concepto             varchar(50),
  @Referencia           varchar(50),
  @DocFuente            int,
  @Observaciones        varchar(100),
  @Estatus              varchar(15),
  @Situacion            varchar(50),
  @SituacionFecha       datetime,
  @SituacionUsuario     varchar(10),
  @SituacionNota        varchar(100),
  @Directo              bit,
  @RenglonID            int,
  @AlmacenDestino       varchar(10),
  @AlmacenTransito      varchar(10),
  @Largo                bit,
  @Condicion            varchar(50),
  @Vencimiento          datetime,
  @FormaEnvio           varchar(50),
  @Autorizacion         varchar(10),
  @OrigenTipo           varchar(10),
  @Origen               varchar(20),
  @OrigenID             varchar(20),
  @Poliza               varchar(20),
  @PolizaID             varchar(20),
  @FechaConclusion      datetime,
  @FechaCancelacion     datetime,
  @FechaOrigen          datetime,
  @FechaRequerida       datetime,
  @Peso                 float,
  @Volumen              float,
  @SucursalOrigen       int,
  @VerLote              bit,
  @UEN                  int,
  @VerDestino           bit,
  @Personal             varchar(10),
  @Conteo               int,
  @Agente               varchar(10),
  @ACRetencion          float,
  @SubModulo            varchar(5),
  @Motivo               varchar(8),
  @ReferenciaMES        varchar(50),
  @PedidoMES            varchar(50),
  @Serie                varchar(3),
  @IDMES                int,
  @IDMarcaje            int,
  @MovMES               bit,
  @Actividad            varchar(100),
  @PedimentoExtraccion  varchar(50),
  @PosicionWMS          varchar(10),
  @PosicionDWMS         varchar(10)

-- INVD
DECLARE
  @Renglon              float,
  @RenglonSub           int,
  @RenglonTipo          char(1),
  @Cantidad             float,
  @Codigo               varchar(30),
  @Articulo             varchar(20),
  @ArticuloDestino      varchar(20),
  @SubCuenta            varchar(50),
  @SubCuentaDestino     varchar(50),
  @Costo                money,
  @CostoInv             money,
  @ContUso              varchar(20),
  @Espacio              varchar(10),
  @CantidadA            float,
  @Paquete              int,
  @Aplica               varchar(20),
  @AplicaID             varchar(20),
  @DestinoTipo          varchar(10),
  @Destino              varchar(20),
  @DestinoID            varchar(20),
  @Cliente              varchar(10),
  @DefUnidad            varchar(50),
  @Unidad               varchar(50),
  @Factor               float,
  @CantidadInventario   float,
  @ProdSerieLote        varchar(50),
  @Merma                float,
  @Desperdicio          float,
  @Producto             varchar(20),
  @SubProducto          varchar(20),
  @Tipo                 varchar(20),
  @Precio               money,
  @SegundoConteo        float,
  @DescripcionExtra     varchar(100),
  @Posicion             varchar(10),
  @MultiUnidad          varchar(20)

SET @Empresa            = UPPER(LTRIM(RTRIM(ISNULL(@Empresa,''))))
SET @Sucursal           = UPPER(LTRIM(RTRIM(ISNULL(@Sucursal,''))))
SET @Usuario            = UPPER(LTRIM(RTRIM(ISNULL(@Usuario,''))))
SET @Estacion           = ISNULL(@Estacion,1)
SET @Corrida            = ISNULL(@Corrida,0)
SET @Almacen            = UPPER(LTRIM(RTRIM(ISNULL(@Almacen,''))))
SET @FechaHoy           = GETDATE()
SET @Generados          = 0

SELECT TOP 1
       @MovEstatus = LTRIM(RTRIM(ISNULL(Estatus,'SIN AFECTAR'))),
       @MovConsecutivo = ISNULL(Consecutivo,0),
       @MovReservar = ISNULL(Reservar,0)
  FROM DistribucionCfg
 WHERE Empresa = @Empresa

SELECT @MultiUnidad = NivelFactorMultiUnidad FROM EmpresaCFG2 WHERE Empresa = @Empresa
SELECT @Moneda = DefMoneda,@UEN = UEN FROM Usuario WHERE Usuario = @Usuario
SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
SELECT @DefUnidad = ISNULL(DefUnidad,'pza') FROM EmpresaGral WHERE Empresa = @Empresa
SELECT TOP 1 @AlmacenOrigen = Almacen FROM Distribucion WHERE Corrida = @Corrida
SELECT @SucursalOrigen = Sucursal FROM Alm WHERE ALmacen = @AlmacenOrigen

SET @ID                  = NULL
SET @Mov                 = 'Orden Traspaso'
SET @MovID               = NULL
SET @FechaEmision        = dbo.fnFechaSinHora(@FechaHoy)
SET @Proyecto            = NULL
SET @Concepto            = 'Traspaso entre sucursales'
SET @Referencia          = NULL
SET @DocFuente           = NULL
SET @Observaciones       = 'Corrida ' + CAST(@Corrida AS VARCHAR(20))
SET @Estatus             = 'SINAFECTAR'
SET @Situacion           = NULL
SET @SituacionFecha      = NULL
SET @SituacionUsuario    = NULL
SET @SituacionNota       = NULL
SET @Directo             = 1
SET @RenglonID           = NULL
SET @AlmacenDestino      = NULL
SET @AlmacenTransito     = '(TRANSITO)'
SET @Largo               = 0
SET @Condicion           = NULL
SET @Vencimiento         = @FechaEmision
SET @FormaEnvio          = NULL
SET @Autorizacion        = NULL
SET @OrigenTipo          = NULL
SET @Origen              = NULL
SET @OrigenID            = NULL
SET @Poliza              = NULL
SET @PolizaID            = NULL
SET @FechaConclusion     = NULL
SET @FechaCancelacion    = NULL
SET @FechaOrigen         = NULL
SET @FechaRequerida      = @FechaEmision
SET @Peso                = NULL
SET @Volumen             = NULL
SET @VerLote             = 0
SET @VerDestino          = 0
SET @Personal            = NULL
SET @Conteo              = NULL
SET @Agente              = @Usuario
SET @ACRetencion         = NULL
SET @SubModulo           = 'INV'
SET @Motivo              = NULL
SET @ReferenciaMES       = NULL
SET @PedidoMES           = NULL
SET @Serie               = NULL
SET @IDMES               = NULL
SET @IDMarcaje           = NULL
SET @MovMES              = NULL
SET @Actividad           = NULL
SET @PedimentoExtraccion = NULL
SET @PosicionWMS         = 0
SET @PosicionDWMS        = NULL
SET @RenglonSub          = 0
SET @RenglonTipo         = NULL

SET @Modulo              = 'INV'
SET @Accion              = 'AFECTAR'
SET @Base                = 'TODO'
SET @GenerarMov          = NULL
SET @SincroFinal         = 0
SET @EnSilencio          = 0
SET @Conexion            = 0

SET @Observacion         = ''
SET @Mensaje             = ''

DECLARE @Distribucion Table (
  Almacen               varchar(10)   NULL,
  AlmacenDestino        varchar(10)   NULL,
  Articulo              varchar(20)   NULL,
  SubCuenta             varchar(50)   NULL,
  Cantidad              float         NULL
)

DECLARE @AlmDestino Table (
  ID                    int IDENTITY(1,1),
  AlmacenDestino        varchar(10)   NULL
)

DECLARE @TablaAfectar table(
    Ok                  int,
    OkDesc              varchar(255),
    OkTipo              varchar(50),
    OkRef               varchar(255),
    IDGenerar           int
  )

INSERT INTO @Distribucion(Almacen,AlmacenDestino,Articulo,SubCuenta,Cantidad)
  SELECT @Almacen,AlmacenDestino,Articulo,SubCuenta,Cantidad
    FROM Distribucion
   WHERE Empresa  = @Empresa
     AND Corrida  = @Corrida
     AND Almacen  = @Almacen
     AND Usuario  = @Usuario
     AND Cantidad > 0
  ORDER BY Almacen,AlmacenDestino,Articulo,SubCuenta

INSERT INTO @AlmDestino (AlmacenDestino)
SELECT AlmacenDestino FROM @Distribucion GROUP BY AlmacenDestino ORDER BY AlmacenDestino

SELECT @Cuenta = MAX(ID) FROM @AlmDestino
SET @Cuenta = ISNULL(@Cuenta,0)

SET @idx = 1
WHILE @idx <= @Cuenta
  BEGIN
    SELECT @AlmacenDestino = AlmacenDestino FROM @AlmDestino WHERE ID = @idx
    SELECT @RenglonID = COUNT(AlmacenDestino) + 1 FROM @Distribucion WHERE AlmacenDestino = @AlmacenDestino

    INSERT INTO Inv
      (
        Empresa, Mov, MovID, FechaEmision, Proyecto,
        Moneda, TipoCambio, Concepto, Referencia, DocFuente,
        Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario,

        SituacionNota, Directo, RenglonID, Almacen, AlmacenDestino,
        AlmacenTransito, Largo, Condicion, Vencimiento, FormaEnvio,
        Autorizacion, Usuario, OrigenTipo, Origen,

        OrigenID, Poliza, PolizaID, FechaConclusion, FechaCancelacion,
        FechaOrigen, FechaRequerida, Peso, Volumen, Sucursal,
        SucursalOrigen, VerLote, UEN, VerDestino, Personal,

        Conteo, Agente, ACRetencion, SubModulo, Motivo,
        ReferenciaMES, PedidoMES, Serie, IDMES, IDMarcaje,
        MovMES, Actividad, PedimentoExtraccion, PosicionWMS, PosicionDWMS
      )
    VALUES
      (
        @Empresa, @Mov, @MovID, @FechaEmision, @Proyecto,
        @Moneda, @TipoCambio, @Concepto, @Referencia, @DocFuente,
        @Observaciones, @Estatus, @Situacion, @SituacionFecha, @SituacionUsuario,

        @SituacionNota, @Directo, @RenglonID, @Almacen, @AlmacenDestino,
        @AlmacenTransito, @Largo, @Condicion, @Vencimiento, @FormaEnvio,
        @Autorizacion, @Usuario, @OrigenTipo, @Origen,

        @OrigenID, @Poliza, @PolizaID, @FechaConclusion, @FechaCancelacion,
        @FechaOrigen, @FechaRequerida, @Peso, @Volumen, @Sucursal,
        @SucursalOrigen, @VerLote, @UEN, @VerDestino, @Personal,

        @Conteo, @Agente, @ACRetencion, @SubModulo, @Motivo,
        @ReferenciaMES, @PedidoMES, @Serie, @IDMES, @IDMarcaje,
        @MovMES, @Actividad, @PedimentoExtraccion, @PosicionWMS, @PosicionDWMS
    )

    SET @ID = SCOPE_IDENTITY()
    SET @RenglonID = 0

    DECLARE crDistribucion_01 CURSOR FOR
      SELECT Articulo,SubCuenta,Cantidad
      FROM @Distribucion
      WHERE AlmacenDestino = @AlmacenDestino

    OPEN crDistribucion_01
    FETCH NEXT FROM crDistribucion_01 INTO @Articulo,@SubCuenta,@Cantidad
    WHILE @@FETCH_STATUS = 0
      BEGIN
        SET @RenglonID = @RenglonID + 1
        SET @Renglon   = @RenglonID * 2048

        SELECT @Unidad = ISNULL(UnidadTraspaso,@DefUnidad), @ArtTipo = Tipo FROM Art WITH(NOLOCK) WHERE Articulo = @Articulo

        IF @MultiUnidad = 'Articulo'
            SELECT @Factor = Factor FROM ArtUnidad WITH(NOLOCK) WHERE Unidad = @Unidad AND Articulo = @Articulo

        IF @MultiUnidad = 'Unidad'
            SELECT @Factor = Factor FROM Unidad WITH(NOLOCK) WHERE Unidad = @Unidad

        IF ISNULL(@MultiUnidad,'') = '' OR ISNULL(@Factor, '') = ''
            SELECT @Factor = 1

        EXEC spRenglonTipo @ArtTipo,@SubCuenta,@RenglonTipo
        IF NOT @RenglonTipo IN('N','S','L','V','J') SET @RenglonTipo = 'N'

        EXEC spPrecioEsp '(Precio Lista)', @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT

        SET @CantidadInventario = @Cantidad * @Factor
		SET @Cantidad = @Cantidad / @Factor
        IF ISNULL(@SubCuenta,'') = '' SET @SubCuenta = NULL

        INSERT INTO InvD(
          ID,Renglon,RenglonSub,RenglonID,RenglonTipo,
          Almacen,Codigo,Articulo,SubCuenta,ArticuloDestino,
          SubCuentaDestino,Cantidad,Paquete,Costo,CantidadA,
          Aplica,AplicaID,ContUso,Unidad,Factor,
          CantidadInventario,FechaRequerida,ProdSerieLote,Merma,Desperdicio,
          Producto,SubProducto,Tipo,Sucursal,SucursalOrigen,
          Precio,CostoInv,Espacio,DestinoTipo,Destino,
          DestinoID,Cliente,SegundoConteo,DescripcionExtra,Posicion)
        VALUES(
          @ID,@Renglon,@RenglonSub,@RenglonID,@RenglonTipo,
          @Almacen,@Codigo,@Articulo,@SubCuenta,@ArticuloDestino,
          @SubCuentaDestino,@Cantidad,@Paquete,@Costo,@Cantidad,
          @Aplica,@AplicaID,@ContUso,@Unidad,@Factor,
          @CantidadInventario,@FechaRequerida,@ProdSerieLote,@Merma,@Desperdicio,
          @Producto,@SubProducto,@Tipo,@Sucursal,@SucursalOrigen,
          @Precio,@CostoInv,@Espacio,@DestinoTipo,@Destino,
          @DestinoID,@Cliente,@SegundoConteo,@DescripcionExtra,@Posicion)

        FETCH NEXT FROM crDistribucion_01 INTO @Articulo,@SubCuenta,@Cantidad
     END
    CLOSE crDistribucion_01
    DEALLOCATE crDistribucion_01

    IF @MovEstatus = 'SIN AFECTAR' AND @MovConsecutivo = 1
      BEGIN
        SET @Accion = 'Consecutivo'
        SET @Base = 'Todo'
        INSERT INTO @TablaAfectar
        EXECUTE spAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro, @Conexion, @Estacion
      END

    IF @MovEstatus = 'PENDIENTE'
      BEGIN
        SET @Accion = 'Afectar'
        SET @Base = 'Todo'
        INSERT INTO @TablaAfectar
        EXECUTE spAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro, @Conexion, @Estacion
      END

    IF @MovEstatus = 'PENDIENTE' AND @MovReservar = 1
      BEGIN
        SET @Accion = 'Reservar'
        SET @Base = 'Pendiente'
        INSERT INTO @TablaAfectar EXECUTE spAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro, @Conexion, @Estacion
      END

    BEGIN TRY
      SELECT @MovIdLog = MovID, @EstatusLog = Estatus FROM Inv WHERE ID = @ID
      SET @Observacion = ''

      INSERT INTO DistInvLog(Empresa,Sucursal,Usuario,Corrida,Estacion,Almacen,AlmacenDestino,Reservar,InvID,InvMov,InvMovId,Estatus,FechaLog,Observacion)
      VALUES(@Empresa,@Sucursal,@Usuario,@Estacion,@Corrida,@Almacen,@AlmacenDestino,@MovReservar,@ID,@Mov,@MovIdLog,@EstatusLog,GETDATE(),@Observacion)

      UPDATE Distribucion SET Procesado = 1, FechaProcesado = @FechaHoy
      WHERE Empresa = @Empresa AND Corrida = @Corrida AND Almacen = Almacen AND AlmacenDestino = @AlmacenDestino
    END TRY

    BEGIN CATCH
      SET @Observacion = 'Error en ' + ERROR_PROCEDURE() + ': ' + ERROR_MESSAGE()

      INSERT INTO DistInvLog(Empresa,Sucursal,Usuario,Estacion,Corrida,Almacen,AlmacenDestino,Reservar,InvID,InvMov,InvMovId,Estatus,FechaLog,Observacion)
      VALUES(@Empresa,@Sucursal,@Usuario,@Estacion,@Corrida,@Almacen,@AlmacenDestino,@MovReservar,@ID,@Mov,@MovIdLog,@EstatusLog,GETDATE(),@Observacion)
    END CATCH

    SET @Generados = @Generados + 1
    SET @idx = @idx + 1
  END

  -->
  SELECT @Generados
END
GO

/**************** spDistCorridaDestinos ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spDistCorridaDestinos' AND Type = 'P')  DROP PROCEDURE spDistCorridaDestinos
GO
CREATE PROCEDURE spDistCorridaDestinos (
  @Empresa              varchar(5),
  @Sucursal             int,
  @Usuario              varchar(10),
  @Estacion             int,
  @Corrida              int
)
--//WITH ENCRYPTION
AS
BEGIN
		SELECT a.AlmacenDestino Clave, b.Nombre Nombre
		FROM Distribucion a, AlmDist b
		WHERE a.Empresa = @Empresa AND a.Corrida = @Corrida
		AND a.AlmacenDestino = b.Almacen
		GROUP BY a.AlmacenDestino, b.Nombre
		ORDER BY a.AlmacenDestino, b.Nombre
END
GO

