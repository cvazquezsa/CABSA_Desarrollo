SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 72071) DELETE MensajeLista WHERE Mensaje = 72071
GO
INSERT INTO MensajeLista (Mensaje, Descripcion, Tipo) VALUES (72071,'El usuario no cuenta con sucursales definidas', 'CFG')
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Funciones
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** fnDescribirOpciones ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.fnDescribirOpciones') AND type = 'FN') DROP FUNCTION dbo.fnDescribirOpciones
GO
CREATE FUNCTION fnDescribirOpciones (@SubCuenta varchar(20))
RETURNS varchar(1000)
AS
BEGIN
  DECLARE
    @ret         varchar(1000),    -- retorno
    @s           varchar(20),      -- string
    @Opcion      char(1),          -- campo opcion
    @Numero      varchar(20),      -- campo numero
    @d           varchar(100),     -- Descripcion opcion
    @t           varchar(1000),    -- temporal
    @c           char(1),          -- opcion
    @n           varchar(20),      -- numero
    @o           int,              -- numero de opciones en SubCuenta
    @i           int,              -- indice
    @k           int               -- contador

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
              SELECT @d = ISNULL(Descripcion,'') FROM Opcion WHERE Opcion = @Opcion
              SELECT @t = @d + ' ' + ISNULL(Nombre,'') FROM OpcionD d WHERE d.Opcion = @Opcion AND d.Numero = @Numero

              -- Quitar espacios
              SELECT @t = LTRIM(RTRIM(@t))

              -- Concatenar descripcion
              IF LEN(@t) > 0
                BEGIN
                  SELECT @ret = @ret + @t + ', '
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
  SELECT @ret = LTRIM(RTRIM(@ret))

  -- Quitar ultima coma
  SELECT @k = LEN(@ret)
  IF @k > 0 SELECT @ret = SUBSTRING(@ret, 1 , @k - 1)

  -- Agregar punto final
  IF @o > 1 SELECT @ret = @ret + '.'

  RETURN @ret
END
GO
--------------------------------------------------------------------------------------------------------------------------
/************** fnOrdenarOpciones ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.fnOrdenarOpciones') AND type = 'FN') DROP FUNCTION dbo.fnOrdenarOpciones
GO
CREATE FUNCTION fnOrdenarOpciones(@Articulo varchar(20), @SubCuenta varchar(20))
RETURNS varchar(20)
AS
BEGIN
DECLARE
  @ret        varchar(20),
  @o          char(1),
  @t          varchar(20),
  @c          char(1),
  @k          int

DECLARE @Orden table(
  id          int IDENTITY(1,1),
  Opcion      char(1)
)

SET @SubCuenta = LTRIM(RTRIM(@SubCuenta)) + '~'
SET @ret = ''
SET @o = ''
SET @t = ''
SET @c = ''
SET @k = 0

INSERT INTO @Orden
SELECT a.Opcion
  FROM ArtOpcion a
  JOIN Opcion o ON(a.Opcion = o.Opcion)
 WHERE a.Articulo = @Articulo
 ORDER BY a.Orden, a.Opcion

DECLARE fnOrdenarOpciones_cursor CURSOR FOR SELECT Opcion FROM @Orden
OPEN fnOrdenarOpciones_cursor
FETCH NEXT FROM fnOrdenarOpciones_cursor INTO @o
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
    FETCH NEXT FROM fnOrdenarOpciones_cursor INTO @o
  END
CLOSE fnOrdenarOpciones_cursor
DEALLOCATE fnOrdenarOpciones_cursor
SET @ret = LTRIM(RTRIM(@ret))
RETURN @ret
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Procedimientos
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionMensaje ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionMensaje') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionMensaje
GO
CREATE PROCEDURE spIntelisisDistribucionMensaje
  @ID              int,
  @iSolicitud      int,
  @Version         float,
  @Resultado       varchar(max) = NULL OUTPUT,
  @Ok              int = NULL OUTPUT,
  @OkRef           varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto         xml,
    @ReferenciaIS  varchar(100),
    @SubReferencia varchar(100),
    @sMensaje      varchar(20),
    @Mensaje       int

  DECLARE @Tabla   table(
    Mensaje        int,
    Descripcion    varchar(255),
    Tipo           varchar(50)
    )

  BEGIN TRY
    SELECT @sMensaje = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
      WHERE Campo = 'Mensaje'

    SET @sMensaje = ISNULL(@sMensaje,'0')
    SET @Mensaje = CAST(@sMensaje AS int)

    INSERT INTO @Tabla (Mensaje, Descripcion, Tipo)
    SELECT @Mensaje, Descripcion, Tipo FROM MensajeLista WHERE Mensaje = @Mensaje

    SELECT @Texto = (SELECT CAST(ISNULL(Mensaje,0) AS varchar)   AS Ok,
                            LTRIM(RTRIM(ISNULL(Descripcion,''))) AS Descripcion,
                            LTRIM(RTRIM(ISNULL(Tipo,'')))        AS Tipo
                       FROM @Tabla AS Tabla
                        FOR XML AUTO)

    IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionEmpresa ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionEmpresa') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionEmpresa
GO
CREATE PROCEDURE spIntelisisDistribucionEmpresa
  @ID              int,
  @iSolicitud      int,
  @Version         float,
  @Resultado       varchar(max) = NULL OUTPUT,
  @Ok              int = NULL OUTPUT,
  @OkRef           varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto         xml,
    @ReferenciaIS  varchar(100),
    @SubReferencia varchar(100),
    @Usuario       varchar(20)

  DECLARE @Tabla   table(
    Empresa        varchar(5)
  )

  BEGIN TRY
    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SET @Usuario = ISNULL(@Usuario,'')

    IF EXISTS (SELECT * FROM UsuarioD WHERE Usuario = @Usuario)
      BEGIN
        INSERT INTO @Tabla (Empresa)
        SELECT u.Empresa
          FROM UsuarioD u
          JOIN Empresa e ON (u.Empresa = e.Empresa)
         WHERE u.Usuario = @Usuario
           AND e.Estatus = 'ALTA'
      END
    ELSE
      BEGIN
        INSERT INTO @Tabla (Empresa)
        SELECT Empresa FROM Empresa WHERE Estatus = 'ALTA'
      END

    SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Empresa,''))) AS Empresa
                      FROM @Tabla AS Tabla
                       FOR XML AUTO)

    IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionEmpresaCfg ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionEmpresaCfg') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionEmpresaCfg
GO
CREATE PROCEDURE spIntelisisDistribucionEmpresaCfg
  @ID              int,
  @iSolicitud      int,
  @Version         float,
  @Resultado       varchar(max) = NULL OUTPUT,
  @Ok              int = NULL OUTPUT,
  @OkRef           varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                   xml,
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Empresa                 varchar(5),
    @CB                      bit,
    @CBDirAlmacen            bit,
    @CBPreguntarCantidad     bit,
    @CBProcesarLote          bit,
    @CBSerieLote             bit,
    @CBSubCodigos            bit,
    @CBSubCuentas            bit

  DECLARE @Tabla   table(
    CB                       bit,
    CBDirAlmacen             bit,
    CBPreguntarCantidad      bit,
    CBProcesarLote           bit,
    CBSerieLote              bit,
    CBSubCodigos             bit,
    CBSubCuentas             bit
  )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SET @Empresa = ISNULL(@Empresa,'')

    INSERT INTO @Tabla (CB, CBDirAlmacen, CBPreguntarCantidad, CBProcesarLote, CBSerieLote, CBSubCodigos, CBSubCuentas)
    SELECT ISNULL(CB,0),
           ISNULL(CBDirAlmacen,0),
           ISNULL(CBPreguntarCantidad,0),
           ISNULL(CBProcesarLote,0),
           ISNULL(CBSerieLote,0),
           ISNULL(CBSubCodigos,0),
           ISNULL(CBSubCuentas,0)
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

    SELECT @Texto = (SELECT CAST(ISNULL(CB,0) AS varchar)                  AS CB,
                            CAST(ISNULL(CBDirAlmacen,0) AS varchar)        AS CBDirAlmacen,
                            CAST(ISNULL(CBPreguntarCantidad,0) AS varchar) AS CBPreguntarCantidad,
                            CAST(ISNULL(CBProcesarLote,0) AS varchar)      AS CBProcesarLote,
                            CAST(ISNULL(CBSerieLote,0) AS varchar)         AS CBSerieLote,
                            CAST(ISNULL(CBSubCodigos,0) AS varchar)        AS CBSubCodigos,
                            CAST(ISNULL(CBSubCuentas,0) AS varchar)        AS CBSubCuentas
                       FROM @Tabla AS Tabla
                        FOR XML AUTO)

    IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionSucursal ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionSucursal') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionSucursal
GO
CREATE PROCEDURE spIntelisisDistribucionSucursal
  @ID              int,
  @iSolicitud      int,
  @Version         float,
  @Resultado       varchar(max) = NULL OUTPUT,
  @Ok              int = NULL OUTPUT,
  @OkRef           varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto              xml,
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @Usuario            varchar(20),
    @UsuarioSucursal    bit

  DECLARE @Tabla        table(
    Sucursal            int,
    Nombre              varchar(100)
    )

  BEGIN TRY
    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
      WHERE Campo = 'Usuario'

    SET @Usuario = ISNULL(@Usuario,'')
    SELECT @UsuarioSucursal = AccesarOtrasSucursalesEnLinea FROM Usuario WHERE Usuario = @Usuario

    IF @UsuarioSucursal = 1
      BEGIN
        INSERT @Tabla (Sucursal, Nombre)
        SELECT Sucursal, Nombre
          FROM Sucursal
         WHERE Estatus = 'ALTA'
      END
    ELSE
      BEGIN
        IF NOT EXISTS(SELECT Sucursal FROM UsuarioSucursalAcceso WHERE Usuario = @Usuario)
          BEGIN
            INSERT @Tabla(Sucursal,Nombre)
            SELECT Sucursal, Nombre
              FROM Sucursal
              WHERE Sucursal IN (SELECT Sucursal FROM Usuario WHERE Usuario = @Usuario)
              AND Estatus = 'ALTA'
          END
        ELSE
          BEGIN
            INSERT @Tabla(Sucursal, Nombre)
            SELECT Sucursal, Nombre
              FROM Sucursal
             WHERE Sucursal IN (SELECT Sucursal FROM UsuarioSucursalAcceso WHERE Usuario = @Usuario)
               AND Estatus = 'ALTA'
          END
      END

    If (SELECT COUNT(Sucursal) FROM @Tabla) > 0
      BEGIN
        SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Sucursal,''))) AS Sucursal,
                                LTRIM(RTRIM(ISNULL(Nombre,'')))   AS Nombre
                           FROM @Tabla AS Tabla
                            FOR XML AUTO)
      END
    ELSE
      BEGIN
        SET @Texto = ''
        SET @OK = 72071
      END

    IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionInventarioFisicoLista ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionInventarioFisicoLista') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionInventarioFisicoLista
GO
CREATE PROCEDURE spIntelisisDistribucionInventarioFisicoLista
  @ID              int,
  @iSolicitud      int,
  @Version         float,
  @Resultado       varchar(max) = NULL OUTPUT,
  @Ok              int = NULL OUTPUT,
  @OkRef           varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                   xml,
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Empresa                 varchar(5),
    @Usuario                 varchar(10),
    @Agente                  varchar(10)

  DECLARE @Tabla table(
    ID                       int,
    Mov                      varchar(20),
    MovID                    varchar(20),
    Almacen                  varchar(10),
    AlmacenNombre            varchar(100),
    fFechaEmision            datetime,
    FechaEmision             varchar(10)
    )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SET @Empresa = ISNULL(@Empresa,'')
    SET @Usuario = ISNULL(@Usuario,'')
    SET @Agente  = ISNULL(@Usuario,'')

    --SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario

    IF NOT EXISTS(SELECT * FROM Agente WHERE Agente = @Agente) SET @Ok = 26090

    IF ISNULL(@Ok, 0) = 0
      BEGIN
        INSERT INTO @Tabla (ID, Mov, MovID, Almacen, AlmacenNombre, fFechaEmision)
        SELECT i.ID, i.Mov, i.MovID, i.Almacen, a.Nombre, i.FechaEmision
          FROM Inv i
          JOIN MovTipo m ON (i.Mov = m.Mov AND m.Modulo = 'INV')
          JOIN Alm a ON (i.almacen = a.Almacen)
         WHERE i.Agente = @Agente
           AND m.Clave = 'INV.IF'
           AND i.Estatus = 'SINAFECTAR'

        UPDATE @Tabla SET FechaEmision = CAST(YEAR(fFechaEmision) AS varchar) + '-'
                                       + RIGHT('00' + CAST(MONTH(fFechaEmision) AS varchar),2) + '-'
                                       + RIGHT('00' + CAST(DAY(fFechaEmision) AS varchar), 2)

        SELECT @Texto = (SELECT CAST(ISNULL(ID,0) AS varchar)          AS ID,
                                LTRIM(RTRIM(ISNULL(Mov,'')))           AS Mov,
                                LTRIM(RTRIM(ISNULL(MovID,'')))         AS MovID,
                                LTRIM(RTRIM(ISNULL(Almacen,'')))       AS Almacen,
                                LTRIM(RTRIM(ISNULL(AlmacenNombre,''))) AS AlmacenNombre,
                                LTRIM(RTRIM(ISNULL(FechaEmision,'')))  AS FechaEmision
                           FROM @Tabla AS Tabla
                            FOR XML AUTO)
      END
    -- ELSE
      -- BEGIN
        -- SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      -- END

  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionInventarioDetalle ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionInventarioDetalle ') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionInventarioDetalle
GO
CREATE PROCEDURE spIntelisisDistribucionInventarioDetalle
  @ID                                  int,
  @iSolicitud                          int,
  @Version                             float,
  @Resultado                           varchar(max) = NULL OUTPUT,
  @Ok                                  int = NULL OUTPUT,
  @OkRef                               varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
-- SET nocount ON
DECLARE
  @Empresa                             varchar(5),
  @ReferenciaIS                        varchar(100),
  @SubReferencia                       varchar(100),
  @InventarioID                        int,
  @Texto                               xml

DECLARE
  @IDR                                 int,
  @Articulo                            varchar(20),
  @SubCuenta                           varchar(50),
  @DescripcionSubCuenta                varchar(1000),
  @Unidad                              varchar(50),
  @Codigo                              varchar(30),
  @CodigoTmp                           varchar(30),
  @RenglonID                           int,
  @Opcion                              varchar (20),
  @Juego                               varchar(10),
  @DescripcionJuego                    varchar(100),
  @CantidadJuego                       float,
  @SubCuentaOpcion                     varchar(50)

SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
  WITH (Campo varchar(255), Valor varchar(255))
 WHERE Campo = 'Empresa'

SELECT @InventarioID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
  WITH (Campo varchar(255), Valor varchar(255))
 WHERE Campo = 'InventarioID'

SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
SET @InventarioID = ISNULL(@InventarioID,0)

IF @InventarioID > 0
  BEGIN
    DECLARE @Tabla Table(
      IDR                                int identity (1,1),
      ID                                 int,
      Movimiento                         varchar(20),
      MovimientoID                       varchar(20),
      Renglon                            float,
      RenglonSub                         int,
      RenglonID                          int,
      RenglonTipo                        char(1),
      Almacen                            varchar(10),
      Articulo                           varchar(20),
      Codigo                             varchar(30),
      SubCuenta                          varchar(50),
      Descripcion1                       varchar(100),
      Descripcion2                       varchar(255),
      NombreCorto                        varchar(20),
      DescripcionSubCuenta               varchar(1000),
      Cantidad                           float,
      Unidad                             varchar(50),
      Factor                             float,
      CantidadInventario                 float,
      Tipo                               varchar(20),
      TipoOpcion                         varchar(20),
      Juego                              varchar(10),
      DescripcionJuego                   varchar(100),
      CantidadJuego                      float,
      Opcion                             varchar(20),
      SubCuentaOpcion                    varchar(50),
      DescripcionSubCuentaOpcion         varchar(1000)
    )

    INSERT INTO @Tabla(ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Almacen, Articulo, SubCuenta, Cantidad, Unidad, Factor, CantidadInventario)
    SELECT @InventarioID,
           ISNULL(Renglon,0.0),
           ISNULL(RenglonSub,0),
           ISNULL(RenglonID,0),
           ISNULL(RenglonTipo,'N'),
           ISNULL(Almacen,''),
           ISNULL(Articulo,''),
           ISNULL(SubCuenta,''),
           ISNULL(Cantidad,0.0),
           ISNULL(Unidad,''),
           ISNULL(Factor,0.0),
           ISNULL(CantidadInventario,0.0)
      FROM InvD
     WHERE ID = @InventarioID

    UPDATE @Tabla
       SET Movimiento = b.Mov,
           MovimientoID = b.MovID
      FROM @tabla a
     INNER JOIN Inv b ON (a.ID = b.ID)

    UPDATE @Tabla
       SET Descripcion1 = ISNULL(b.Descripcion1, ''),
           Descripcion2 = ISNULL(b.Descripcion2, ''),
           NombreCorto  = ISNULL(b.NombreCorto, ''),
           Tipo         = ISNULL(b.Tipo, ''),
           TipoOpcion   = ISNULL(b.TipoOpcion, '')
      FROM @Tabla a
     INNER JOIN Art b ON (a.Articulo = b.Articulo)

    UPDATE @Tabla SET DescripcionSubCuenta = dbo.fnDescribirOpciones(Subcuenta)

    UPDATE @Tabla
       SET Codigo = ISNULL(b.Codigo, '')
      FROM @Tabla a
     INNER JOIN CB b ON (a.Articulo = b.Cuenta AND ISNULL(a.SubCuenta,'') = ISNULL(b.SubCuenta,'') AND a.Unidad = b.Unidad)
     WHERE b.TipoCuenta = 'Articulos'

    DECLARE InventarioDetalleJuego_cursor CURSOR FOR SELECT IDR, RenglonID, Articulo FROM @Tabla WHERE RenglonTipo = 'J'
    OPEN InventarioDetalleJuego_cursor
    FETCH NEXT FROM InventarioDetalleJuego_cursor INTO @IDR, @RenglonID, @Articulo
    WHILE @@FETCH_STATUS = 0
      BEGIN

        DECLARE Juego_cursor CURSOR FOR SELECT Articulo FROM @Tabla WHERE RenglonID = @RenglonID AND RenglonTipo = 'C'
        OPEN Juego_cursor
        FETCH NEXT FROM Juego_cursor INTO @Opcion
        WHILE @@FETCH_STATUS = 0
          BEGIN
            SELECT TOP 1 @Juego = Juego, @SubCuentaOpcion = SubCuenta
              FROM ArtJuegoD
              WHERE Articulo = @Articulo
                AND Opcion = @Opcion

            UPDATE @Tabla
                SET Juego = @Juego,
                    Opcion = @Opcion,
                    SubCuentaOpcion = @SubCuentaOpcion
              WHERE RenglonID = @RenglonID
                AND Articulo = @Opcion

            SELECT @DescripcionJuego = Descripcion,
                    @CantidadJuego = Cantidad
              FROM ArtJuego
              WHERE articulo = @Articulo
                AND Juego = @Juego

              UPDATE @Tabla
                SET DescripcionJuego = @DescripcionJuego,
                    CantidadJuego = @CantidadJuego
              WHERE RenglonID = @RenglonID
                AND Articulo = @Opcion

            UPDATE @Tabla SET DescripcionSubCuentaOpcion = dbo.fnDescribirOpciones(SubCuentaOpcion)
              WHERE RenglonID = @RenglonID
                AND RenglonTipo = 'C'
                AND LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) <> ''

          -->
          FETCH NEXT FROM Juego_cursor INTO @Opcion
        END
        CLOSE Juego_cursor
        DEALLOCATE Juego_cursor
        -->
        FETCH NEXT FROM InventarioDetalleJuego_cursor INTO @IDR, @RenglonID, @Articulo
      END

    CLOSE InventarioDetalleJuego_cursor
    DEALLOCATE InventarioDetalleJuego_cursor

    SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Movimiento,'')))                 AS Movimiento,
                            LTRIM(RTRIM(ISNULL(MovimientoID,'')))               AS MovimientoID,
                            CAST(ISNULL(Renglon,0) AS varchar)                  AS Renglon,
                            CAST(ISNULL(RenglonSub,0) AS varchar)               AS RenglonSub,
                            CAST(ISNULL(RenglonID,0) AS varchar)                AS RenglonID,
                            LTRIM(RTRIM(ISNULL(RenglonTipo,'N')))               AS RenglonTipo,
                            LTRIM(RTRIM(ISNULL(Almacen,'')))                    AS Almacen,
                            LTRIM(RTRIM(ISNULL(Articulo,'')))                   AS Articulo,
                            LTRIM(RTRIM(ISNULL(Codigo,'')))                     AS Codigo,
                            LTRIM(RTRIM(ISNULL(Descripcion1,'')))               AS Descripcion1,
                            LTRIM(RTRIM(ISNULL(Descripcion2,'')))               AS Descripcion2,
                            LTRIM(RTRIM(ISNULL(NombreCorto,'')))                AS NombreCorto,
                            LTRIM(RTRIM(ISNULL(SubCuenta,'')))                  AS SubCuenta,
                            LTRIM(RTRIM(ISNULL(DescripcionSubCuenta,'')))       AS DescripcionSubCuenta,
                            CAST(ISNULL(Cantidad,0) AS varchar)                 AS Cantidad,
                            LTRIM(RTRIM(ISNULL(Unidad,'')))                     AS Unidad,
                            CAST(ISNULL(Factor,1) AS varchar)                   AS Factor,
                            CAST(ISNULL(CantidadInventario,0) AS varchar)       AS CantidadInventario,
                            LTRIM(RTRIM(ISNULL(Tipo,'')))                       AS Tipo,
                            LTRIM(RTRIM(ISNULL(TipoOpcion,'')))                 AS TipoOpcion,
                            LTRIM(RTRIM(ISNULL(Juego,'')))                      AS Juego,
                            LTRIM(RTRIM(ISNULL(DescripcionJuego,'')))           AS DescripcionJuego,
                            CAST(ISNULL(CantidadJuego,0) AS varchar)            AS CantidadJuego,
                            LTRIM(RTRIM(ISNULL(Opcion,'')))                     AS Opcion,
                            LTRIM(RTRIM(ISNULL(SubCuentaOpcion,'')))            AS SubCuentaOpcion,
                            LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) AS DescripcionSubCuentaOpcion
                       FROM @Tabla AS Tabla
                     FOR XML AUTO)

  END
ELSE
  BEGIN
    SET @Ok = 10160
  END

SELECT @ReferenciaIS = Referencia
  FROM IntelisisService
 WHERE ID = @ID

IF @Ok IS NOT NULL
  SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionInventarioEstatus ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionInventarioEstatus ') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionInventarioEstatus
GO
CREATE PROCEDURE spIntelisisDistribucionInventarioEstatus
    @ID                      int,
    @iSolicitud              int,
    @Version                 float,
    @Resultado               varchar(max) = NULL OUTPUT,
    @Ok                      int = NULL OUTPUT,
    @OkRef                   varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa                 varchar(5),
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @InventarioID            int,
    @Estatus                 varchar (15),
    @Texto                   xml

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @InventarioID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'InventarioID'

  SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @InventarioID = ISNULL(@InventarioID,0)
  
  IF @InventarioID > 0
    BEGIN
      DECLARE @Tabla Table(
        Estatus              varchar(15)
      )

      SELECT @Estatus = Estatus FROM INV WHERE ID = @InventarioID
      SET @Estatus = LTRIM(RTRIM(ISNULL(@Estatus,'')))
      INSERT INTO @Tabla (Estatus) VALUES(@Estatus)

      SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Estatus,''))) AS Estatus
                         FROM @Tabla AS Tabla
                       FOR XML AUTO)
    END
  ELSE
    BEGIN
      SET @Ok = 10160 -- 'No Selecciono Ningun Movimiento'
    END

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @Ok IS NOT NULL
    SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionMovimientosInventarioLista ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionMovimientosInventarioLista') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionMovimientosInventarioLista
GO
CREATE PROCEDURE spIntelisisDistribucionMovimientosInventarioLista
  @ID              int,
  @iSolicitud      int,
  @Version         float,
  @Resultado       varchar(max) = NULL OUTPUT,
  @Ok              int = NULL OUTPUT,
  @OkRef           varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto         xml,
    @ReferenciaIS  varchar(100),
    @SubReferencia varchar(100),
    @Empresa       varchar(5),
    @Usuario       varchar(10)

  DECLARE @Tabla   table(
    Mov            varchar(20),
    Orden          int,
    Clave          varchar(20),
    SubClave       varchar(20)
    )

  BEGIN TRY
     SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
      WHERE Campo = 'Empresa'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
      WHERE Campo = 'Usuario'

    SET @Empresa = ISNULL(@Empresa,'')
    SET @Usuario = ISNULL(@Usuario,'')

    INSERT INTO @Tabla (Mov, Orden, Clave, SubClave)
    SELECT Mov, Orden, Clave, SubClave
      FROM MovTipo
     WHERE Modulo = 'INV'
       AND Clave = 'INV.IF'

    SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Mov,'')))      AS Mov,
                            CAST(ISNULL(Orden,0) AS varchar)  AS Orden,
                            LTRIM(RTRIM(ISNULL(Clave,'')))    AS Clave,
                            LTRIM(RTRIM(ISNULL(SubClave,''))) AS SubClave
                       FROM @Tabla AS Tabla
                        FOR XML AUTO)

    IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionAlmacenesLista ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionAlmacenesLista') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionAlmacenesLista
GO
CREATE PROCEDURE spIntelisisDistribucionAlmacenesLista
  @ID              int,
  @iSolicitud      int,
  @Version         float,
  @Resultado       varchar(max) = NULL OUTPUT,
  @Ok              int = NULL OUTPUT,
  @OkRef           varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto         xml,
    @ReferenciaIS  varchar(100),
    @SubReferencia varchar(100),
    @Empresa       varchar(5),
    @sSucursal     varchar(10),
    @Sucursal      int

  DECLARE @Tabla   table(
    Almacen        varchar(20),
    AlmacenNombre  varchar(100)
    )

  BEGIN TRY
     SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
      WHERE Campo = 'Empresa'

    SELECT @sSucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
      WHERE Campo = 'Sucursal'

    SET @Empresa   = ISNULL(@Empresa,'')
    SET @sSucursal = ISNULL(@sSucursal,'')

    IF ISNUMERIC (@sSucursal) = 1
      SET @Sucursal = CAST(@sSucursal AS int)


    IF ISNULL(@Sucursal,(-1)) >= 0
      BEGIN
        INSERT INTO @Tabla (Almacen, AlmacenNombre)
        SELECT ALmacen, Nombre
         FROM Alm
        WHERE Sucursal = @Sucursal
          AND Estatus = 'ALTA'
          AND Tipo = 'Normal'
          AND Almacen <> '(TRANSITO)'
      END
    ELSE
      BEGIN
        INSERT INTO @Tabla (Almacen, AlmacenNombre)
        SELECT ALmacen, Nombre
         FROM Alm
        WHERE Estatus = 'ALTA'
          AND Tipo = 'Normal'
          AND Almacen <> '(TRANSITO)'
      END

    SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Almacen,'')))       AS Almacen,
                            LTRIM(RTRIM(ISNULL(AlmacenNombre,''))) AS AlmacenNombre
                       FROM @Tabla AS Tabla
                        FOR XML AUTO)

    IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionMonedasLista ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionMonedasLista') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionMonedasLista
GO
CREATE PROCEDURE spIntelisisDistribucionMonedasLista
  @ID              int,
  @iSolicitud      int,
  @Version         float,
  @Resultado       varchar(max) = NULL OUTPUT,
  @Ok              int = NULL OUTPUT,
  @OkRef           varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto         xml,
    @ReferenciaIS  varchar(100),
    @SubReferencia varchar(100),
    @Empresa       varchar(5)

  DECLARE @Tabla   table(
    IDR            int identity (1,1),
    Moneda         varchar(10),
    Orden          int,
    TipoCambio     float
    )

  BEGIN TRY
     SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
      WHERE Campo = 'Empresa'

    SET @Empresa = ISNULL(@Empresa,'')

    INSERT INTO @Tabla (Moneda, Orden, TipoCambio)
    SELECT Moneda, Orden, TipoCambio
      FROM Mon
     WHERE TipoCambio = 1

    INSERT INTO @Tabla (Moneda, Orden, TipoCambio)
    SELECT Moneda, Orden, TipoCambio
      FROM Mon
     WHERE TipoCambio <> 1

    SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Moneda,'')))       AS Moneda,
                            CAST(ISNULL(Orden,0) AS varchar)      AS Orden,
                            CAST(ISNULL(TipoCambio,0) AS varchar) AS TipoCambio
                       FROM @Tabla AS Tabla
                      ORDER BY IDR
                        FOR XML AUTO)

    IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionGenerarInventario ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisDistribucionGenerarInventario') AND type = 'P') drop procedure dbo.spIntelisisDistribucionGenerarInventario
GO
CREATE PROCEDURE spIntelisisDistribucionGenerarInventario
  @ID                        int,
  @iSolicitud                int,
  @Version                   float,
  @Resultado                 varchar(max) = NULL OUTPUT,
  @Ok                        int = NULL OUTPUT,
  @OkRef                     varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE
  @Texto                     xml,
  @ReferenciaIS              varchar(100),
  @SubReferencia             varchar(100),
  @Empresa                   varchar(5),
  @Sucursal                  int,
  @sSucursal                 varchar(20),
  @SucursalNombre            varchar(100),
  @Almacen                   varchar(10),
  @Mov                       varchar(20),
  @FechaEmision              datetime,
  @sFechaEmision             varchar(10),
  @Observaciones             varchar(100),
  @Agente                    varchar(10),
  @Usuario                   varchar(10),
  @UltimoCambio              datetime,
  @Moneda                    varchar(10),
  @TipoCambio                float,
  @Estatus                   varchar(15),
  @Directo                   bit,
  @AlmacenTransito           varchar(10),
  @FechaRequerida            datetime,
  @Vencimiento               datetime,
  @SucursalOrigen            int,
  @IdInv                     int

DECLARE @Tabla Table(
  ModuloID                   int,
  Mov                        varchar(20),
  MovID                      varchar(20),
  Estatus                    varchar(15)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @sSucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @SucursalNombre = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SucursalNombre'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Moneda = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Moneda'

  SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @sFechaEmision = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'FechaEmision'

  SELECT @Observaciones = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Observaciones'

  SELECT @Agente = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Agente'

  SET @Empresa        = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal       = CAST(ISNULL(@sSucursal,'0') AS int)
  SET @SucursalNombre = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))
  SET @Almacen        = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Moneda         = LTRIM(RTRIM(ISNULL(@Moneda,'')))
  SET @Mov            = LTRIM(RTRIM(ISNULL(@Mov,'')))
  SET @sFechaEmision  = LTRIM(RTRIM(ISNULL(@sFechaEmision,'')))
  SET @Observaciones  = LTRIM(RTRIM(ISNULL(@Observaciones,'')))
  SET @Agente         = LTRIM(RTRIM(ISNULL(@Agente,'')))

  SELECT @Usuario = Usuario FROM IntelisisService WHERE ID = @ID
  SET @Usuario = LTRIM(RTRIM(ISNULL(@Usuario,'')))

  IF ISNULL(@Agente,'') = '' SET @Agente = LTRIM(RTRIM(ISNULL(@Usuario,'')))

  SET @FechaEmision    = @sFechaEmision
  SET @FechaEmision    = dbo.fnFechaSinHora(@FechaEmision)
  SET @FechaRequerida  = @FechaEmision
  SET @Vencimiento     = @FechaEmision
  SET @SucursalOrigen  = @Sucursal

  SET @UltimoCambio    = GETDATE()
  SET @Estatus         = 'SINAFECTAR'
  SET @Directo         = 1
  SET @AlmacenTransito = '(TRANSITO)'

  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda

  INSERT INTO INV (Empresa, Mov, FechaEmision, UltimoCambio, Moneda, TipoCambio, Usuario, Observaciones, Estatus, Directo, Almacen, AlmacenTransito, FechaRequerida, Vencimiento, Sucursal, Agente, SucursalOrigen)
  VALUES (@Empresa, @Mov, @FechaEmision, @UltimoCambio, @Moneda, @TipoCambio, @Usuario, @Observaciones, @Estatus, @Directo, @Almacen, @AlmacenTransito, @FechaRequerida, @Vencimiento, @Sucursal, @Agente, @SucursalOrigen)

  SET @IdInv = SCOPE_IDENTITY()

  INSERT INTO @Tabla (ModuloID, Mov, MovID, Estatus)
  SELECT ID, Mov, MovID, Estatus FROM INV WHERE ID = @IdInv

  SELECT @Texto = (SELECT CAST(ISNULL(ModuloID,0) AS varchar) AS ModuloID,
                          LTRIM(RTRIM(ISNULL(Mov,'')))        AS Mov,
                          LTRIM(RTRIM(ISNULL(MovID,'')))      AS MovID,
                          LTRIM(RTRIM(ISNULL(Estatus,'')))    AS Estatus
                     FROM @Tabla AS Tabla
                      FOR XML AUTO)

END TRY

BEGIN CATCH
  SET @Ok = 1
  SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
END CATCH

SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionCbInfo ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionCbInfo ') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionCbInfo
GO
CREATE PROCEDURE spIntelisisDistribucionCbInfo
  @ID                                  int,
  @iSolicitud                          int,
  @Version                             float,
  @Resultado                           varchar(max) = NULL OUTPUT,
  @Ok                                  int = NULL OUTPUT,
  @OkRef                               varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
-- SET nocount ON
DECLARE
  @Texto                               xml,
  @ReferenciaIS                        varchar(100),
  @SubReferencia                       varchar(100),
  @CodigoBarras                        varchar(30)

DECLARE
  @IDR                                 int,
  @Articulo                            varchar(20),
  @SubCuenta                           varchar(50),
  @DescripcionSubCuenta                varchar(1000),
  @Unidad                              varchar(50),
  @Codigo                              varchar(30),
  @CodigoTmp                           varchar(30),
  @RenglonID                           int,
  @Opcion                              varchar (20),
  @Juego                               varchar(10),
  @DescripcionJuego                    varchar(100),
  @CantidadJuego                       float,
  @SubCuentaOpcion                     varchar(50)

SELECT @CodigoBarras = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
  WITH (Campo varchar(255), Valor varchar(255))
 WHERE Campo = 'CodigoBarras'

SET @CodigoBarras = LTRIM(RTRIM(ISNULL(@CodigoBarras,'')))

DECLARE @Tabla table(
  IDR                                  int identity (1,1),
  ID                                   int,
  Movimiento                           varchar(20),
  MovimientoID                         varchar(20),
  Renglon                              float,
  RenglonSub                           int,
  RenglonID                            int,
  RenglonTipo                          char(1),
  Almacen                              varchar(10),
  Articulo                             varchar(20),
  Codigo                               varchar(30),
  SubCuenta                            varchar(50),
  Descripcion1                         varchar(100),
  Descripcion2                         varchar(255),
  NombreCorto                          varchar(20),
  DescripcionSubCuenta                 varchar(1000),
  Cantidad                             float,
  Unidad                               varchar(50),
  Factor                               float,
  CantidadInventario                   float,
  Tipo                                 varchar(20),
  TipoOpcion                           varchar(20),
  Juego                                varchar(10),
  DescripcionJuego                     varchar(100),
  CantidadJuego                        float,
  Opcion                               varchar(20),
  SubCuentaOpcion                      varchar(50),
  DescripcionSubCuentaOpcion           varchar(1000)
)

INSERT INTO @Tabla (Articulo, Codigo, SubCuenta, Unidad, Factor)
SELECT Cuenta, @CodigoBarras, SubCuenta, Unidad, Cantidad
  FROM CB
 WHERE Codigo = @CodigoBarras

UPDATE @Tabla
   SET Descripcion1 = ISNULL(b.Descripcion1, ''),
       Descripcion2 = ISNULL(b.Descripcion2, ''),
       NombreCorto = ISNULL(b.NombreCorto, ''),
       Tipo = ISNULL(b.Tipo, ''),
       RenglonTipo = LEFT(ISNULL(b.Tipo, ''),1),
       TipoOpcion = UPPER(ISNULL(b.TipoOpcion,'No'))
  FROM @Tabla a
INNER JOIN Art b ON (a.Articulo = b.Articulo)

UPDATE @Tabla SET DescripcionSubCuenta = dbo.fnDescribirOpciones(Subcuenta)

DECLARE InventarioCBInfo_cursor CURSOR FOR SELECT IDR, RenglonID, Articulo FROM @Tabla WHERE RenglonTipo = 'J'
OPEN InventarioCBInfo_cursor
FETCH NEXT FROM InventarioCBInfo_cursor INTO @IDR, @RenglonID, @Articulo
WHILE @@FETCH_STATUS = 0
  BEGIN
    DECLARE Juego_cursor CURSOR FOR SELECT Articulo FROM @Tabla WHERE RenglonID = @RenglonID AND RenglonTipo = 'C'
    OPEN Juego_cursor
    FETCH NEXT FROM Juego_cursor INTO @Opcion
    WHILE @@FETCH_STATUS = 0
      BEGIN
        SELECT TOP 1 @Juego = Juego, @SubCuentaOpcion = SubCuenta
          FROM ArtJuegoD
         WHERE Articulo = @Articulo
           AND Opcion = @Opcion

        UPDATE @Tabla
           SET Juego = @Juego,
               Opcion = @Opcion,
               SubCuentaOpcion = @SubCuentaOpcion
         WHERE RenglonID = @RenglonID
           AND Articulo = @Opcion

        SELECT @DescripcionJuego = Descripcion,
               @CantidadJuego = Cantidad
         FROM ArtJuego
         WHERE articulo = @Articulo
           AND Juego = @Juego

        UPDATE @Tabla
           SET DescripcionJuego = @DescripcionJuego,
               CantidadJuego = @CantidadJuego
         WHERE RenglonID = @RenglonID
           AND Articulo = @Opcion

        UPDATE @Tabla SET DescripcionSubCuentaOpcion = dbo.fnDescribirOpciones(SubCuentaOpcion)
         WHERE RenglonID = @RenglonID
           AND RenglonTipo = 'C'
           AND LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) <> ''

      -->
      FETCH NEXT FROM Juego_cursor INTO @Opcion
    END
    CLOSE Juego_cursor
    DEALLOCATE Juego_cursor
    -->
    FETCH NEXT FROM InventarioCBInfo_cursor INTO @IDR, @RenglonID, @Articulo
  END

CLOSE InventarioCBInfo_cursor
DEALLOCATE InventarioCBInfo_cursor

SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Movimiento,'')))                 AS Movimiento,
                        LTRIM(RTRIM(ISNULL(MovimientoID,'')))               AS MovimientoID,
                        CAST(ISNULL(Renglon,0) AS varchar)                  AS Renglon,
                        CAST(ISNULL(RenglonSub,0) AS varchar)               AS RenglonSub,
                        CAST(ISNULL(RenglonID,0) AS varchar)                AS RenglonID,
                        LTRIM(RTRIM(ISNULL(RenglonTipo,'N')))               AS RenglonTipo,
                        LTRIM(RTRIM(ISNULL(Almacen,'')))                    AS Almacen,
                        LTRIM(RTRIM(ISNULL(Articulo,'')))                   AS Articulo,
                        LTRIM(RTRIM(ISNULL(Codigo,'')))                     AS Codigo,
                        LTRIM(RTRIM(ISNULL(Descripcion1,'')))               AS Descripcion1,
                        LTRIM(RTRIM(ISNULL(Descripcion2,'')))               AS Descripcion2,
                        LTRIM(RTRIM(ISNULL(NombreCorto,'')))                AS NombreCorto,
                        LTRIM(RTRIM(ISNULL(SubCuenta,'')))                  AS SubCuenta,
                        LTRIM(RTRIM(ISNULL(DescripcionSubCuenta,'')))       AS DescripcionSubCuenta,
                        CAST(ISNULL(Cantidad,0) AS varchar)                 AS Cantidad,
                        LTRIM(RTRIM(ISNULL(Unidad,'')))                     AS Unidad,
                        CAST(ISNULL(Factor,1) AS varchar)                   AS Factor,
                        CAST(ISNULL(CantidadInventario,0) AS varchar)       AS CantidadInventario,
                        LTRIM(RTRIM(ISNULL(Tipo,'')))                       AS Tipo,
                        LTRIM(RTRIM(ISNULL(TipoOpcion,'')))                 AS TipoOpcion,
                        LTRIM(RTRIM(ISNULL(Juego,'')))                      AS Juego,
                        LTRIM(RTRIM(ISNULL(DescripcionJuego,'')))           AS DescripcionJuego,
                        CAST(ISNULL(CantidadJuego,0) AS varchar)            AS CantidadJuego,
                        LTRIM(RTRIM(ISNULL(Opcion,'')))                     AS Opcion,
                        LTRIM(RTRIM(ISNULL(SubCuentaOpcion,'')))            AS SubCuentaOpcion,
                        LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) AS DescripcionSubCuentaOpcion
                    FROM @Tabla AS Tabla
                  FOR XML AUTO)

SELECT @ReferenciaIS = Referencia
  FROM IntelisisService
 WHERE ID = @ID

IF @Ok IS NOT NULL
  SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionArticuloInfo ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionArticuloInfo ') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionArticuloInfo
GO
CREATE PROCEDURE spIntelisisDistribucionArticuloInfo
  @ID                                  int,
  @iSolicitud                          int,
  @Version                             float,
  @Resultado                           varchar(max) = NULL OUTPUT,
  @Ok                                  int = NULL OUTPUT,
  @OkRef                               varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE
  @Texto                               xml,
  @ReferenciaIS                        varchar(100),
  @SubReferencia                       varchar(100)

DECLARE
  @IDR                                 int,
  @Articulo                            varchar(20),
  @SubCuenta                           varchar(50),
  @DescripcionSubCuenta                varchar(1000),
  @Unidad                              varchar(50),
  @Codigo                              varchar(30),
  @CodigoTmp                           varchar(30),
  @RenglonID                           int,
  @Opcion                              varchar (20),
  @Juego                               varchar(10),
  @DescripcionJuego                    varchar(100),
  @CantidadJuego                       float,
  @SubCuentaOpcion                     varchar(50)

SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
  WITH (Campo varchar(255), Valor varchar(255))
 WHERE Campo = 'Articulo'

SET @Articulo = LTRIM(RTRIM(ISNULL(@Articulo,'')))

DECLARE @Tabla table(
  IDR                                  int identity (1,1),
  ID                                   int,
  Movimiento                           varchar(20),
  MovimientoID                         varchar(20),
  Renglon                              float,
  RenglonSub                           int,
  RenglonID                            int,
  RenglonTipo                          char(1),
  Almacen                              varchar(10),
  Articulo                             varchar(20),
  Codigo                               varchar(30),
  SubCuenta                            varchar(50),
  Descripcion1                         varchar(100),
  Descripcion2                         varchar(255),
  NombreCorto                          varchar(20),
  DescripcionSubCuenta                 varchar(1000),
  Cantidad                             float,
  Unidad                               varchar(50),
  Factor                               float,
  CantidadInventario                   float,
  Tipo                                 varchar(20),
  TipoOpcion                           varchar(20),
  Juego                                varchar(10),
  DescripcionJuego                     varchar(100),
  CantidadJuego                        float,
  Opcion                               varchar(20),
  SubCuentaOpcion                      varchar(50),
  DescripcionSubCuentaOpcion           varchar(1000)
)

INSERT INTO @Tabla (Articulo, SubCuenta, Unidad, Factor)
SELECT TOP 1 Articulo, NULL, Unidad, Factor
  FROM ArtUnidad
 WHERE Articulo = @Articulo
   AND Factor = 1

SELECT @IDR = ISNULL(MAX(IDR),0) from @Tabla

IF ISNULL(@IDR,'0') = 0
  BEGIN
    INSERT INTO @Tabla (Articulo, SubCuenta, Unidad, Factor)
      SELECT Articulo, NULL, UnidadTraspaso, Factor
        FROM Art
       WHERE Articulo = @Articulo
  END

UPDATE @Tabla
   SET Descripcion1 = ISNULL(b.Descripcion1, ''),
       Descripcion2 = ISNULL(b.Descripcion2, ''),
       NombreCorto = ISNULL(b.NombreCorto, ''),
       Tipo = ISNULL(b.Tipo, ''),
       RenglonTipo = LEFT(ISNULL(b.Tipo, ''),1),
       TipoOpcion = UPPER(ISNULL(b.TipoOpcion,'No'))
  FROM @Tabla a
 INNER JOIN Art b ON (a.Articulo = b.Articulo)

UPDATE @Tabla SET DescripcionSubCuenta = dbo.fnDescribirOpciones(Subcuenta)

UPDATE @Tabla
   SET Codigo = ISNULL(b.Codigo, '')
  FROM @Tabla a
 INNER JOIN CB b ON (a.Articulo = b.Cuenta AND ISNULL(a.SubCuenta,'') = ISNULL(b.SubCuenta,'') AND a.Unidad = b.Unidad)
 WHERE b.TipoCuenta = 'Articulos'

DECLARE InventarioArticuloInfo_cursor CURSOR FOR SELECT IDR, RenglonID, Articulo FROM @Tabla WHERE RenglonTipo = 'J'
OPEN InventarioArticuloInfo_cursor
FETCH NEXT FROM InventarioArticuloInfo_cursor INTO @IDR, @RenglonID, @Articulo
WHILE @@FETCH_STATUS = 0
  BEGIN
    DECLARE Juego_cursor CURSOR FOR SELECT Articulo FROM @Tabla WHERE RenglonID = @RenglonID AND RenglonTipo = 'C'
    OPEN Juego_cursor
    FETCH NEXT FROM Juego_cursor INTO @Opcion
    WHILE @@FETCH_STATUS = 0
      BEGIN
        SELECT TOP 1 @Juego = Juego, @SubCuentaOpcion = SubCuenta
          FROM ArtJuegoD
         WHERE Articulo = @Articulo
           AND Opcion = @Opcion

        UPDATE @Tabla
           SET Juego = @Juego,
               Opcion = @Opcion,
               SubCuentaOpcion = @SubCuentaOpcion
         WHERE RenglonID = @RenglonID
           AND Articulo = @Opcion

        SELECT @DescripcionJuego = Descripcion,
                @CantidadJuego = Cantidad
          FROM ArtJuego
         WHERE articulo = @Articulo
           AND Juego = @Juego

        UPDATE @Tabla
           SET DescripcionJuego = @DescripcionJuego,
               CantidadJuego = @CantidadJuego
         WHERE RenglonID = @RenglonID
           AND Articulo = @Opcion

        UPDATE @Tabla SET DescripcionSubCuentaOpcion = dbo.fnDescribirOpciones(SubCuentaOpcion)
         WHERE RenglonID = @RenglonID
           AND RenglonTipo = 'C'
           AND LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) <> ''

      -->
      FETCH NEXT FROM Juego_cursor INTO @Opcion
    END
    CLOSE Juego_cursor
    DEALLOCATE Juego_cursor
    -->
    FETCH NEXT FROM InventarioArticuloInfo_cursor INTO @IDR, @RenglonID, @Articulo
  END

CLOSE InventarioArticuloInfo_cursor
DEALLOCATE InventarioArticuloInfo_cursor

SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Movimiento,'')))                 AS Movimiento,
                        LTRIM(RTRIM(ISNULL(MovimientoID,'')))               AS MovimientoID,
                        CAST(ISNULL(Renglon,0) AS varchar)                  AS Renglon,
                        CAST(ISNULL(RenglonSub,0) AS varchar)               AS RenglonSub,
                        CAST(ISNULL(RenglonID,0) AS varchar)                AS RenglonID,
                        LTRIM(RTRIM(ISNULL(RenglonTipo,'N')))               AS RenglonTipo,
                        LTRIM(RTRIM(ISNULL(Almacen,'')))                    AS Almacen,
                        LTRIM(RTRIM(ISNULL(Articulo,'')))                   AS Articulo,
                        LTRIM(RTRIM(ISNULL(Codigo,'')))                     AS Codigo,
                        LTRIM(RTRIM(ISNULL(Descripcion1,'')))               AS Descripcion1,
                        LTRIM(RTRIM(ISNULL(Descripcion2,'')))               AS Descripcion2,
                        LTRIM(RTRIM(ISNULL(NombreCorto,'')))                AS NombreCorto,
                        LTRIM(RTRIM(ISNULL(SubCuenta,'')))                  AS SubCuenta,
                        LTRIM(RTRIM(ISNULL(DescripcionSubCuenta,'')))       AS DescripcionSubCuenta,
                        CAST(ISNULL(Cantidad,0) AS varchar)                 AS Cantidad,
                        LTRIM(RTRIM(ISNULL(Unidad,'')))                     AS Unidad,
                        CAST(ISNULL(Factor,1) AS varchar)                   AS Factor,
                        CAST(ISNULL(CantidadInventario,0) AS varchar)       AS CantidadInventario,
                        LTRIM(RTRIM(ISNULL(Tipo,'')))                       AS Tipo,
                        LTRIM(RTRIM(ISNULL(TipoOpcion,'')))                 AS TipoOpcion,
                        LTRIM(RTRIM(ISNULL(Juego,'')))                      AS Juego,
                        LTRIM(RTRIM(ISNULL(DescripcionJuego,'')))           AS DescripcionJuego,
                        CAST(ISNULL(CantidadJuego,0) AS varchar)            AS CantidadJuego,
                        LTRIM(RTRIM(ISNULL(Opcion,'')))                     AS Opcion,
                        LTRIM(RTRIM(ISNULL(SubCuentaOpcion,'')))            AS SubCuentaOpcion,
                        LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) AS DescripcionSubCuentaOpcion
                    FROM @Tabla AS Tabla
                  FOR XML AUTO)

SELECT @ReferenciaIS = Referencia
  FROM IntelisisService
 WHERE ID = @ID

IF @Ok IS NOT NULL
  SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionGuardarInventario ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionGuardarInventario') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionGuardarInventario
GO
CREATE PROCEDURE spIntelisisDistribucionGuardarInventario
    @ID                      int,
    @iSolicitud              int,
    @Version                 float,
    @Resultado               varchar(max) = NULL OUTPUT,
    @Ok                      int = NULL OUTPUT,
    @OkRef                   varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                   xml,
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Empresa                 varchar(5),
    @Sucursal                int,
    @Usuario                 varchar(10),
    @xml                     xml

  DECLARE
    @InvID                   int,
    @FechaRequerida          datetime,
    @Proveedor               varchar(10),
    @Articulo                varchar(20),
    @SubCuenta               varchar(50),
    @Unidad                  varchar(50),
    @TipoCosteo              varchar(10),
    @MonedaCosto             varchar(10),
    @TipoCambio              float,
    @Costo                   money,
    @i                       int,
    @k                       int

  DECLARE @TablaInvD table(
    IDX                      int identity (1,1),
    ID                       int,
    Renglon                  float,
    RenglonSub               int,
    RenglonID                int,
    Cantidad                 float,
    Almacen                  varchar(10),
    Articulo                 varchar(20),
    Codigo                   varchar(30),
    Subcuenta                varchar(50),
    Costo                    money,
    FechaRequerida           datetime,
    Unidad                   varchar(50),
    Factor                   float
  )

  DECLARE @Tabla Table(
    Mensaje                  varchar(255)
 )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Sucursal'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Sucursal = LTRIM(RTRIM(ISNULL(@Sucursal,'')))
    SET @Usuario  = LTRIM(RTRIM(ISNULL(@Usuario,'')))

    SET @Proveedor = NULL
    SET @SubCuenta = NULL

    INSERT INTO @TablaInvD (ID, Renglon, RenglonSub, RenglonID, Cantidad, Almacen, Articulo, Codigo, SubCuenta, Unidad, Factor)
    SELECT ID, Renglon, RenglonSub, RenglonID, Cantidad, Almacen, Articulo, Codigo, Subcuenta, Unidad, Factor
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Tabla')
      WITH (ID          int           '@ID',
            Renglon     float         '@Renglon',
            RenglonSub  int           '@RenglonSub',
            RenglonID   int           '@RenglonID',
            Cantidad    float         '@Cantidad',
            Almacen     varchar (10)  '@Almacen',
            Articulo    varchar (20)  '@Articulo',
            Codigo      varchar (30)  '@Codigo',
            Subcuenta   varchar (50)  '@Subcuenta',
            --Costo       money         '@Costo',
            Unidad      varchar (50)  '@Unidad',
            Factor      float         '@Factor');

    SELECT @k = MAX(IDX) FROM @TablaInvD
    SET    @k = ISNULL(@k, 0)

    SET @i = 0
    WHILE @i < @k
      BEGIN
        SET @i = @i + 1
        -->

        SELECT @Articulo  = Articulo,
               @SubCuenta = Subcuenta,
               @Unidad    = Unidad
          FROM @tablaInvD
         WHERE IDX = @i

        SELECT @TipoCosteo  = TipoCosteo,
               @MonedaCosto = MonedaCosto
          FROM Art
         WHERE Articulo = @Articulo

        SELECT @TipoCambio = TipoCambio
          FROM Mon
         WHERE Moneda = @MonedaCosto

        EXEC spVerCosto @sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @MonedaCosto, @TipoCambio, @Costo OUTPUT, 0

        UPDATE @TablaInvD SET Costo = @Costo WHERE IDX = @i
      END

    SELECT @InvID = ID FROM @TablaInvD WHERE IDX = @k
    SELECT @FechaRequerida = Fechaemision FROM Inv WHERE ID = @InvID

    UPDATE @TablaInvD SET FechaRequerida = @FechaRequerida


    MERGE INTO InvD t
    USING @TablaInvD s
       ON t.ID         = s.ID
      AND t.Renglon    = s.Renglon
      AND t.RenglonSub = s.RenglonSub
      AND t.RenglonID  = s.RenglonID
     WHEN MATCHED THEN
          UPDATE
             SET Cantidad           = s.Cantidad,
                 Codigo             = s.Codigo,
                 Costo              = s.Costo,
                 CantidadInventario = ISNULL(s.Cantidad, 0) * ISNULL(s.Factor, 1),
                 FechaRequerida     = s.FechaRequerida
     WHEN NOT MATCHED BY TARGET THEN
          INSERT(ID, Renglon, RenglonSub, RenglonID, Cantidad, Codigo, Almacen, Articulo, Costo, FechaRequerida, Unidad, Factor, CantidadInventario)
          VALUES(s.ID, s.Renglon, s.RenglonSub, s.RenglonID, s.Cantidad, s.Codigo, s.Almacen, s.Articulo, s.Costo, s.FechaRequerida, s.Unidad, s.Factor, ISNULL(s.Cantidad, 0) * ISNULL(s.Factor, 1));

    DELETE InvD WHERE ID = @InvID AND Cantidad = 0

    INSERT INTO @Tabla (Mensaje) VALUES ('Inventario guardado con éxito.')

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
    INSERT INTO @Tabla (Mensaje) VALUES (@OkRef)
  END CATCH

  SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Mensaje,''))) AS Mensaje
                       FROM @Tabla AS Tabla
                        FOR XML AUTO)

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionSerieLoteLista ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionSerieLoteLista ') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionSerieLoteLista
GO
CREATE PROCEDURE spIntelisisDistribucionSerieLoteLista
  @ID                        int,
  @iSolicitud                int,
  @Version                   float,
  @Resultado                 varchar(max) = NULL OUTPUT,
  @Ok                        int = NULL OUTPUT,
  @OkRef                     varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
-- SET nocount ON
DECLARE
  @ReferenciaIS              varchar(100),
  @SubReferencia             varchar(100),
  @Texto                     xml,
  @Empresa                   varchar(5),
  @Almacen                   varchar(10),
  @Articulo                  varchar(20),
  @SubCuenta                 varchar(50)

DECLARE @Tabla Table(
  IDR                        int identity(1,1),
  SerieLote                  varchar(50),
  Existencia                 float
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SELECT @SubCuenta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SubCuenta'

  SET @Empresa   = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Almacen   = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Articulo  = LTRIM(RTRIM(ISNULL(@Articulo,'')))
  SET @SubCuenta = LTRIM(RTRIM(ISNULL(@SubCuenta,'')))

  INSERT INTO @Tabla(SerieLote, Existencia)
  SELECT SerieLote, Existencia
    FROM SerieLote
   WHERE Empresa = @Empresa
     AND Almacen = @Almacen
     AND Articulo = @Articulo
     AND SubCuenta = @SubCuenta
     AND Existencia > 0
   ORDER BY Existencia DESC, SerieLote

  SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(SerieLote,'')))    AS SerieLote,
                          CAST(ISNULL(Existencia,0) AS varchar) AS Existencia
                     FROM @Tabla AS Tabla
                    ORDER BY IDR
                      FOR XML AUTO)

END TRY

BEGIN CATCH
  SET @Ok = 1
  SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
END CATCH

SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionGuardarSerieLoteMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisDistribucionGuardarSerieLoteMov') AND type = 'P') drop procedure dbo.spIntelisisDistribucionGuardarSerieLoteMov
GO
CREATE PROCEDURE spIntelisisDistribucionGuardarSerieLoteMov
  @ID                        int,
  @iSolicitud                int,
  @Version                   float,
  @Resultado                 varchar(max) = NULL OUTPUT,
  @Ok                        int = NULL OUTPUT,
  @OkRef                     varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
-- SET nocount ON
DECLARE
  @Texto                     xml,
  @ReferenciaIS              varchar(100),
  @SubReferencia             varchar(100),
  @Empresa                   varchar(5),
  @Sucursal                  int,
  @Usuario                   varchar(10),
  @xml                       xml

DECLARE
  @Modulo                    varchar(5),
  @ModuloID                  int,
  @RenglonID                 int,
  @Articulo                  varchar(20),
  @SubCuenta                 varchar(50),
  @SerieLote                 varchar(50),
  @Cantidad                  float,
  @Propiedades               varchar(20),
  @idx                       int

DECLARE @TablaSerieLoteMov table(
  IDX                        int identity (1,1),
  Empresa                    varchar(5),
  Modulo                     varchar(5),
  ModuloID                   int,
  RenglonID                  int,
  Articulo                   varchar(20),
  Subcuenta                  varchar(50),
  SerieLote                  varchar(50),
  Cantidad                   float,
  Propiedades                varchar(20),
  Sucursal                   int
)

DECLARE @Tabla Table(
  Mensaje                    varchar(255)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SELECT @ModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ModuloID'

  SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal = LTRIM(RTRIM(ISNULL(@Sucursal,0)))
  SET @Usuario  = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  SET @ModuloID = LTRIM(RTRIM(ISNULL(@ModuloID,0)))

  INSERT INTO @TablaSerieLoteMov (Empresa, Modulo, ModuloID, RenglonID, Articulo, Subcuenta, SerieLote, Cantidad, Propiedades, Sucursal)
  SELECT Empresa, Modulo, ModuloID, RenglonID, Articulo, Subcuenta, SerieLote, Cantidad, Propiedades, Sucursal
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Tabla')
    WITH (
          Empresa     varchar (5)  '@Empresa',
          Modulo      varchar (5)  '@Modulo',
          ModuloID    int          '@ModuloID',
          RenglonID   int          '@RenglonID',
          Articulo    varchar (20) '@Articulo',
          Subcuenta   varchar (50) '@Subcuenta',
          SerieLote   varchar (50) '@SerieLote',
          Cantidad    float        '@Cantidad',
          Propiedades varchar (20) '@Propiedades',
          Sucursal    int          '@Sucursal'
          );


  DECLARE TablaSerieLoteMov_cursor CURSOR FOR SELECT IDX, Empresa, Modulo, ModuloID, RenglonID, Articulo, Subcuenta, SerieLote, Cantidad, Propiedades, Sucursal FROM @TablaSerieLoteMov
  OPEN TablaSerieLoteMov_cursor
  FETCH NEXT FROM TablaSerieLoteMov_cursor INTO @idx, @Empresa, @Modulo, @ModuloID, @RenglonID, @Articulo, @Subcuenta, @SerieLote, @Cantidad, @Propiedades, @Sucursal
  WHILE @@FETCH_STATUS = 0
    BEGIN
      IF EXISTS(SELECT TOP 1 ID
                  FROM SerieLoteMov
                 WHERE Empresa   = @Empresa
                   AND Modulo    = @Modulo
                   AND ID        = @ModuloID
                   AND RenglonID = @RenglonID
                   AND Articulo  = @Articulo
                   AND SubCuenta = @SubCuenta
                   AND SerieLote = @SerieLote
                 )
        BEGIN
          IF ISNULL(@Cantidad,0) > 0
            BEGIN
              UPDATE SerieLoteMov
                 SET Cantidad    = @Cantidad,
                     Propiedades = @Propiedades,
                     Sucursal    = @Sucursal
               WHERE Empresa     = @Empresa
                 AND Modulo      = @Modulo
                 AND ID          = @ModuloID
                 AND RenglonID   = @RenglonID
                 AND Articulo    = @Articulo
                 AND SubCuenta   = @SubCuenta
                 AND SerieLote   = @SerieLote
            END
          ELSE
            BEGIN
              DELETE SerieLoteMov
               WHERE Empresa     = @Empresa
                 AND Modulo      = @Modulo
                 AND ID          = @ModuloID
                 AND RenglonID   = @RenglonID
                 AND Articulo    = @Articulo
                 AND SubCuenta   = @SubCuenta
                 AND SerieLote   = @SerieLote
            END
        END
      ELSE
        BEGIN
          IF ISNULL(@Cantidad,0) > 0
            BEGIN
              INSERT INTO SerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, Subcuenta, SerieLote, Cantidad, Propiedades, Sucursal)
              VALUES (@Empresa, @Modulo, @ModuloID, @RenglonID, @Articulo, @Subcuenta, @SerieLote, @Cantidad, @Propiedades, @Sucursal)
            END
        END

      FETCH NEXT FROM TablaSerieLoteMov_cursor INTO @idx, @Empresa, @Modulo, @ModuloID, @RenglonID, @Articulo, @Subcuenta, @SerieLote, @Cantidad, @Propiedades, @Sucursal
    END
  CLOSE TablaSerieLoteMov_cursor
  DEALLOCATE TablaSerieLoteMov_cursor

  SELECT @idx = MAX(IDX) FROM @TablaSerieLoteMov
  INSERT INTO @Tabla (Mensaje) VALUES (CAST(ISNULL(@idx,0) AS varchar) + ' registros actualizados.')

  IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
END TRY

BEGIN CATCH
  SET @Ok = 1
  SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
END CATCH

SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Mensaje,''))) AS Mensaje
                      FROM @Tabla AS Tabla
                      FOR XML AUTO)

SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionInfoSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisDistribucionInfoSerieLote ')           AND type = 'P') drop procedure dbo.spIntelisisDistribucionInfoSerieLote
GO
CREATE PROCEDURE spIntelisisDistribucionInfoSerieLote
  @ID                        int,
  @iSolicitud                int,
  @Version                   float,
  @Resultado                 varchar(max) = NULL OUTPUT,
  @Ok                        int = NULL OUTPUT,
  @OkRef                     varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
-- SET nocount ON
DECLARE
  @Empresa                   varchar(5),
  @Modulo                    varchar(5),
  @ModuloID                  varchar(255),
  @RenglonID                 varchar(255),
  @Articulo                  varchar(20),
  @SubCuenta                 varchar(50),
  @ModuloID2                 int,
  @RenglonID2                int,
  @ReferenciaIS              varchar(100),
  @SubReferencia             varchar(100),
  @Texto                     xml

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Modulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Modulo'

  SELECT @ModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ModuloID'

  SELECT @RenglonID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'RenglonID'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SELECT @SubCuenta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SubCuenta'

  SET @Empresa    = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Modulo     = LTRIM(RTRIM(ISNULL(@Modulo,'')))
  SET @Articulo   = LTRIM(RTRIM(ISNULL(@Articulo,'')))
  SET @SubCuenta  = LTRIM(RTRIM(ISNULL(@SubCuenta,'')))
  SET @ModuloID2  = CAST(ISNULL(@ModuloID,'0') AS int)
  SET @RenglonID2 = CAST(ISNULL(@RenglonID,'0') AS int)

  IF @ModuloID2 > 0
    BEGIN
      DECLARE @Tabla Table(
        RenglonID            int,
        Articulo             varchar(20),
        SubCuenta            varchar(50),
        SerieLote            varchar(50),
        Cantidad             float
      )

      INSERT INTO @Tabla(RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
      SELECT ISNULL(RenglonID,0),
             ISNULL(Articulo,''),
             ISNULL(SubCuenta,''),
             ISNULL(SerieLote,''),
             ISNULL(Cantidad,0.0)
        FROM SerieLoteMov
       WHERE Empresa = @Empresa
         AND Modulo = @Modulo
         AND ID = @ModuloID
         AND RenglonID = @RenglonID2
         AND Articulo  = @Articulo
         AND SubCuenta = @SubCuenta
       ORDER BY SerieLote

    END
  ELSE
    BEGIN
      SET @Ok = 10160
    END

  IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
END TRY

BEGIN CATCH
  SET @Ok = 1
  SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
END CATCH

SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

SELECT @Texto = (SELECT CAST(ISNULL(RenglonID,0) AS VARCHAR) AS RenglonID,
                        LTRIM(RTRIM(ISNULL(Articulo,'')))    AS Articulo,
                        LTRIM(RTRIM(ISNULL(SubCuenta,'')))   AS SubCuenta,
                        LTRIM(RTRIM(ISNULL(SerieLote,'')))   AS SerieLote,
                        CAST(ISNULL(Cantidad,0) AS VARCHAR)  AS Cantidad
                    FROM @Tabla AS Tabla
                  FOR XML AUTO)

SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recepcion
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionMovimientosRecepcionLista ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionMovimientosRecepcionLista') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionMovimientosRecepcionLista
GO
CREATE PROCEDURE spIntelisisDistribucionMovimientosRecepcionLista
  @ID              int,
  @iSolicitud      int,
  @Version         float,
  @Resultado       varchar(max) = NULL OUTPUT,
  @Ok              int = NULL OUTPUT,
  @OkRef           varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto         xml,
    @ReferenciaIS  varchar(100),
    @SubReferencia varchar(100),
    @Empresa       varchar(5),
    @Usuario       varchar(10)

  DECLARE @Tabla   table(
    Mov            varchar(20),
    Orden          int,
    Clave          varchar(20),
    SubClave       varchar(20)
    )

  BEGIN TRY
     SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
      WHERE Campo = 'Empresa'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
      WHERE Campo = 'Usuario'

    SET @Empresa = ISNULL(@Empresa,'')
    SET @Usuario = ISNULL(@Usuario,'')

    INSERT INTO @Tabla (Mov, Orden, Clave, SubClave)
    SELECT Mov, Orden, Clave, SubClave
      FROM MovTipo
     WHERE Modulo = 'COMS'
       AND Clave = 'COMS.O'
       AND Mov IN ('Orden Compra')
     ORDER BY Orden

    INSERT INTO @Tabla (Mov, Orden, Clave, SubClave)
    SELECT Mov, Orden, Clave, SubClave
      FROM MovTipo
     WHERE Modulo = 'INV'
       AND Clave = 'INV.TI'
       AND LTRIM(RTRIM(ISNULL(SubClave,''))) = ''
       AND Mov IN ('Transito')
     ORDER BY Orden

    SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Mov,'')))      AS Mov,
                            CAST(ISNULL(Orden,0) AS varchar)  AS Orden,
                            LTRIM(RTRIM(ISNULL(Clave,'')))    AS Clave,
                            LTRIM(RTRIM(ISNULL(SubClave,''))) AS SubClave
                       FROM @Tabla AS Tabla
                        FOR XML AUTO)

    IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionOrdenCompraLista ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionOrdenCompraLista') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionOrdenCompraLista
GO
CREATE PROCEDURE spIntelisisDistribucionOrdenCompraLista
  @ID                        int,
  @iSolicitud                int,
  @Version                   float,
  @Resultado                 varchar(max) = NULL OUTPUT,
  @Ok                        int = NULL OUTPUT,
  @OkRef                     varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                   xml,
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Empresa                 varchar(5),
    @Usuario                 varchar(10),
    @Agente                  varchar(10),
    @Mov                     varchar(20),
    @Orden                   varchar(20),
    @Clave                   varchar(20),
    @SubClave                varchar(20)

  DECLARE @Tabla table(
    ID                       int,
    Mov                      varchar(20),
    MovID                    varchar(20),
    Movimiento               varchar(40),
    Almacen                  varchar(10),
    AlmacenNombre            varchar(100),
    Proveedor                varchar(10),
    ProveedorNombre          varchar(100),
    fFechaEmision            datetime,
    FechaEmision             varchar(10)
    )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @Agente = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Agente'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @Orden = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Orden'

    SELECT @Clave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Clave'

    SELECT @SubClave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SubClave'

    SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Usuario  = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @Agente   = LTRIM(RTRIM(ISNULL(@Agente,'')))
    SET @Mov      = LTRIM(RTRIM(ISNULL(@Mov,'')))
    SET @Orden    = LTRIM(RTRIM(ISNULL(@Orden,'')))
    SET @Clave    = LTRIM(RTRIM(ISNULL(@Clave,'')))
    SET @SubClave = LTRIM(RTRIM(ISNULL(@SubClave,'')))

    IF LTRIM(RTRIM(ISNULL(@Agente,''))) = '' SET @Agente = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    IF LTRIM(RTRIM(ISNULL(@Agente,''))) = '' SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
    IF NOT EXISTS(SELECT * FROM Agente WHERE Agente = @Agente) SET @Ok = 26090

    IF ISNULL(@Ok, 0) = 0
      BEGIN
        INSERT INTO @Tabla (ID, Mov, MovID, Almacen, AlmacenNombre, Proveedor, ProveedorNombre, fFechaEmision)
        SELECT c.ID, c.Mov, c.MovID, c.Almacen, a.Nombre, c.Proveedor, p.Nombre, c.FechaEmision
          FROM Compra c
          JOIN Alm a ON (c.Almacen = a.Almacen)
          JOIN Prov p ON (c.Proveedor = p.Proveedor)
         WHERE c.Agente = @Agente
           AND c.Estatus = 'PENDIENTE'
           AND c.Mov = @Mov

        UPDATE @Tabla SET FechaEmision = CAST(YEAR(fFechaEmision) AS varchar) + '-' + RIGHT('00' + CAST(MONTH(fFechaEmision) AS varchar),2) + '-' + RIGHT('00' + CAST(DAY(fFechaEmision) AS varchar), 2)
        UPDATE @Tabla SET Movimiento = RTRIM(LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,''))))

        SELECT @Texto = (SELECT CAST(ISNULL(ID,0) AS varchar)            AS ID,
                                LTRIM(RTRIM(ISNULL(Mov,'')))             AS Mov,
                                LTRIM(RTRIM(ISNULL(MovID,'')))           AS MovID,
                                LTRIM(RTRIM(ISNULL(Movimiento,'')))      AS Movimiento,
                                LTRIM(RTRIM(ISNULL(Almacen,'')))         AS Almacen,
                                LTRIM(RTRIM(ISNULL(AlmacenNombre,'')))   AS AlmacenNombre,
                                LTRIM(RTRIM(ISNULL(Proveedor,'')))       AS Proveedor,
                                LTRIM(RTRIM(ISNULL(ProveedorNombre,''))) AS ProveedorNombre,
                                LTRIM(RTRIM(ISNULL(FechaEmision,'')))    AS FechaEmision
                           FROM @Tabla AS Tabla
                            FOR XML AUTO)

      END
    -- ELSE
      -- BEGIN
        -- SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      -- END

  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionOrdenCompraDetalle ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionOrdenCompraDetalle ') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionOrdenCompraDetalle
GO
CREATE PROCEDURE spIntelisisDistribucionOrdenCompraDetalle
    @ID                                int,
    @iSolicitud                        int,
    @Version                           float,
    @Resultado                         varchar(max) = NULL OUTPUT,
    @Ok                                int = NULL OUTPUT,
    @OkRef                             varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa                           varchar(5),
    @ReferenciaIS                      varchar(100),
    @SubReferencia                     varchar(100),
    @OrdenCompraID                     int,
    @Texto                             xml

  DECLARE
    @CfgCompraRecibirDemas             bit,
    @CfgCompraRecibirDemasTolerancia   float,
    @CfgRecibirDemasSinLimites         bit

  DECLARE
    @idx                               int,
    @Articulo                          varchar(20),
    @SubCuenta                         varchar(50),
    @Unidad                            varchar(50),
    @Codigo                            varchar(30),
    @CodigoTmp                         varchar(30)

  DECLARE @TablaCB table(
    Codigo                             varchar(30)
  )

  DECLARE @Tabla Table(
    IDX                                int identity (1,1),
    ID                                 int,
    Movimiento                         varchar(20),
    MovimientoID                       varchar(20),
    Renglon                            float,
    RenglonSub                         int,
    RenglonID                          int,
    Almacen                            varchar(10),
    Articulo                           varchar(20),
    Codigo                             varchar(max),
    SubCuenta                          varchar(50),
    Descripcion1                       varchar(100),
    Descripcion2                       varchar(255),
    NombreCorto                        varchar(20),
    Cantidad                           float,
    CantidadPendiente                  float,
    CantidadA                          float,
    CantidadMaxima                     float,
    Unidad                             varchar(50),
    Factor                             float,
    CantidadInventario                 float,
    Tipo                               varchar(20)
  )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @OrdenCompraID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'OrdenCompraID'

    SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @OrdenCompraID = ISNULL(@OrdenCompraID,0)

    IF @OrdenCompraID > 0
      BEGIN
        SELECT @CfgCompraRecibirDemas = ISNULL(CompraRecibirDemas,0),
               @CfgCompraRecibirDemasTolerancia = ISNULL(CompraRecibirDemasTolerancia,0)
          FROM EmpresaCfg2 WHERE Empresa = @Empresa

        IF @CfgCompraRecibirDemas = 1 AND @CfgCompraRecibirDemasTolerancia = 0
          SET @CfgRecibirDemasSinLimites = 1
        ELSE
          SET @CfgRecibirDemasSinLimites = 0

        INSERT INTO @Tabla(ID, Renglon, RenglonSub, RenglonID, Almacen, Articulo, Codigo, SubCuenta, Cantidad, CantidadPendiente, Unidad, Factor)
        SELECT @OrdenCompraID,
               ISNULL(Renglon,0.0),
               ISNULL(RenglonSub,0),
               ISNULL(RenglonID,0),
               ISNULL(Almacen,''),
               LTRIM(RTRIM(ISNULL(Articulo,''))),
               LTRIM(RTRIM(ISNULL(Codigo,''))),
               LTRIM(RTRIM(ISNULL(SubCuenta,''))),
               ISNULL(Cantidad,0.0),
               ISNULL(CantidadPendiente,0.0),
               ISNULL(Unidad,''),
               ISNULL(Factor,0.0)
          FROM CompraD
         WHERE ID = @OrdenCompraID

        UPDATE @Tabla
           SET Movimiento = b.Mov,
               MovimientoID = b.MovID
          FROM @tabla a
         INNER JOIN Compra b ON (a.ID = b.ID)

        UPDATE @Tabla
           SET Descripcion1 = ISNULL(b.Descripcion1, ''),
               Descripcion2 = ISNULL(b.Descripcion2, ''),
               NombreCorto  = ISNULL(b.NombreCorto, ''),
               Tipo         = ISNULL(b.Tipo, '')
          FROM @Tabla a
         INNER JOIN Art b ON (a.Articulo = b.Articulo)

        IF @CfgCompraRecibirDemas = 0
          BEGIN
            UPDATE @Tabla SET CantidadMaxima = Cantidad
          END
        ELSE
          BEGIN
            IF @CfgRecibirDemasSinLimites = 1
              UPDATE @Tabla SET CantidadMaxima = 0  -- (Sin limite)
            ELSE
              UPDATE @Tabla SET CantidadMaxima = CAST(Cantidad * (1 + (@CfgCompraRecibirDemasTolerancia / 100)) AS int)
          END

        SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Movimiento,'')))           AS Movimiento,
                                LTRIM(RTRIM(ISNULL(MovimientoID,'')))         AS MovimientoID,
                                CAST(ISNULL(Renglon,0) AS varchar)            AS Renglon,
                                CAST(ISNULL(RenglonSub,0) AS varchar)         AS RenglonSub,
                                CAST(ISNULL(RenglonID,0) AS varchar)          AS RenglonID,
                                LTRIM(RTRIM(ISNULL(Almacen,'')))              AS Almacen,
                                LTRIM(RTRIM(ISNULL(Articulo,'')))             AS Articulo,
                                LTRIM(RTRIM(ISNULL(Codigo,'')))               AS Codigo,
                                LTRIM(RTRIM(ISNULL(SubCuenta,'')))            AS SubCuenta,
                                LTRIM(RTRIM(ISNULL(Descripcion1,'')))         AS Descripcion1,
                                LTRIM(RTRIM(ISNULL(Descripcion2,'')))         AS Descripcion2,
                                LTRIM(RTRIM(ISNULL(NombreCorto,'')))          AS NombreCorto,
                                CAST(ISNULL(Cantidad,0) AS varchar)           AS Cantidad,
                                CAST(ISNULL(CantidadPendiente,0) AS varchar)  AS CantidadPendiente,
                                CAST(ISNULL(CantidadA,0) AS varchar)          AS CantidadA,
                                CAST(ISNULL(CantidadMaxima,0) AS varchar)     AS CantidadMaxima,
                                LTRIM(RTRIM(ISNULL(Unidad,'')))               AS Unidad,
                                CAST(ISNULL(Factor,1) AS varchar)             AS Factor,
                                CAST(ISNULL(CantidadInventario,0) AS varchar) AS CantidadInventario,
                                LTRIM(RTRIM(ISNULL(Tipo,'')))                 AS Tipo
                            FROM @Tabla AS Tabla
                          FOR XML AUTO)

      END
    ELSE
      BEGIN
        SET @Ok = 10160
      END

  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionOrdenCompraCodigos ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionOrdenCompraCodigos ') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionOrdenCompraCodigos
GO
CREATE PROCEDURE spIntelisisDistribucionOrdenCompraCodigos
    @ID                                int,
    @iSolicitud                        int,
    @Version                           float,
    @Resultado                         varchar(max) = NULL OUTPUT,
    @Ok                                int = NULL OUTPUT,
    @OkRef                             varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa                           varchar(5),
    @ReferenciaIS                      varchar(100),
    @SubReferencia                     varchar(100),
    @OrdenCompraID                     int,
    @Texto                             xml

  DECLARE
    @Articulo                          varchar(20)

  DECLARE @Tabla Table(
    IDX                                int identity (1,1),
    Codigo                             varchar(30),
    Articulo                           varchar(20),
    Unidad                             varchar(50),
    Factor                             float
  )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @OrdenCompraID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'OrdenCompraID'

    SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @OrdenCompraID = ISNULL(@OrdenCompraID,0)

    IF @OrdenCompraID > 0
      BEGIN
        DECLARE CompraD_cursor CURSOR FOR SELECT Articulo FROM CompraD WHERE ID  = @OrdenCompraID
        OPEN CompraD_cursor
        FETCH NEXT FROM CompraD_cursor INTO @Articulo
        WHILE @@FETCH_STATUS = 0
          BEGIN
            INSERT INTO @Tabla (Codigo, Articulo, Unidad, Factor)
            SELECT Codigo, Cuenta, Unidad, Cantidad
              FROM CB
             WHERE TipoCuenta = 'Articulos'
               AND Cuenta = @Articulo
            -->
            FETCH NEXT FROM CompraD_cursor INTO @Articulo
          END
        CLOSE CompraD_cursor
        DEALLOCATE CompraD_cursor

        SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Codigo,'')))   AS Codigo,
                                LTRIM(RTRIM(ISNULL(Articulo,''))) AS Articulo,
                                LTRIM(RTRIM(ISNULL(Unidad,'')))   AS Unidad,
                                CAST(ISNULL(Factor,0) AS varchar) AS Factor
                            FROM @Tabla AS Tabla
                          FOR XML AUTO)
      END
    ELSE
      BEGIN
        SET @Ok = 10160
      END
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionAfectarOrdenCompra ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionAfectarOrdenCompra') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionAfectarOrdenCompra
GO
CREATE PROCEDURE spIntelisisDistribucionAfectarOrdenCompra
    @ID                      int,
    @iSolicitud              int,
    @Version                 float,
    @Resultado               varchar(max) = NULL OUTPUT,
    @Ok                      int = NULL OUTPUT,
    @OkRef                   varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa                 varchar(5),
    @Sucursal                int,
    @Usuario                 varchar(10),
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @xml                     xml,
    @Texto                   xml

  DECLARE
    @sModuloID               varchar(100),
    @ModuloID                int,
    @MovimientoGenerar       varchar(20),
    @IDGenerar               int,
    @Estacion                int,
    @Mensaje                 varchar(255)

  SET @IDGenerar = 0
  SET @Mensaje   = ''
  SET @Estacion  = @@SPID

  DECLARE @TablaCompraD table(
    IDX                      int identity (1,1),
    ID                       int,
    Renglon                  float,
    RenglonSub               int,
    RenglonID                int,
    Articulo                 varchar(20),
    SubCuenta                varchar(50),
    CantidadA                float
  )

DECLARE @TablaSerieLoteMov table(
    IDX                      int identity (1,1),
    Empresa                  varchar(5),
    Modulo                   varchar(5),
    ID                       int,
    RenglonID                int,
    Articulo                 varchar(20),
    SubCuenta                varchar(50),
    SerieLote                varchar(50),
    Cantidad                 float,
    Sucursal                 int
  )

  DECLARE @Tabla Table(
    Mensaje                  varchar(255)
 )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Sucursal'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @sModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'ModuloID'

    SELECT @MovimientoGenerar = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovimientoGenerar'

    SET @Empresa           = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Sucursal          = LTRIM(RTRIM(ISNULL(@Sucursal,'')))
    SET @Usuario           = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @ModuloID          = CAST(ISNULL(@sModuloID,'0') AS int)
    SET @MovimientoGenerar = LTRIM(RTRIM(ISNULL(@MovimientoGenerar,'')))

    INSERT INTO @TablaCompraD (ID, Renglon, RenglonSub, RenglonID, Articulo, SubCuenta, CantidadA)
    SELECT ID, Renglon, RenglonSub, RenglonID, Articulo, SubCuenta, CantidadA
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Tabla')
      WITH (ID          int           '@ID',
            Renglon     float         '@Renglon',
            RenglonSub  int           '@RenglonSub',
            RenglonID   int           '@RenglonID',
            Articulo    varchar (20)  '@Articulo',
            SubCuenta   varchar (50)  '@SubCuenta',
            CantidadA   float         '@CantidadA');

    INSERT INTO @TablaSerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal)
    SELECT Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Tabla2')
      WITH (Empresa     varchar (5)   '@Empresa',
            Modulo      varchar (5)   '@Modulo',
            ID          int           '@ID',
            RenglonID   int           '@RenglonID',
            Articulo    varchar (20)  '@Articulo',
            SubCuenta   varchar (50)  '@SubCuenta',
            SerieLote   varchar (50)  '@SerieLote',
            Cantidad    float         '@Cantidad',
            Sucursal    int           '@Sucursal');

    BEGIN TRANSACTION

    UPDATE CompraD
       SET CantidadA = ISNULL(b.CantidadA,0)
      FROM CompraD a
      JOIN @TablaCompraD b
        ON (a.ID        = b.ID
       AND a.Renglon    = b.Renglon
       AND a.RenglonSub = b.RenglonSub
       AND a.RenglonID  = b.RenglonID)

    EXEC @IDGenerar = spAfectar 'COMS', @ModuloID, 'GENERAR', 'Seleccion', @MovimientoGenerar, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF ISNULL(@OK,0) = 0 OR ISNULL(@OK,0) BETWEEN 80030 AND 81000
      BEGIN
        SET @Ok = NULL
        SET @OkRef = NULL

        IF (SELECT COUNT(IDX) FROM @TablaSerieLoteMov) > 0
          BEGIN
            UPDATE @TablaSerieLoteMov SET ID = @IDGenerar

            INSERT INTO SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal)
            SELECT Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal
              FROM @TablaSerieLoteMov
             ORDER BY IDX
          END

        IF @MovimientoGenerar = 'Entrada Compra'
          BEGIN
            EXEC spAfectar 'COMS', @IDGenerar, 'AFECTAR', 'TODO', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
            IF @OK BETWEEN 80030 AND 81000 SET @OK = NULL

            SELECT @Mensaje = 'Se generó el movimiento ' + LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,''))) + ' (' + LTRIM(RTRIM(ISNULL(Estatus,''))) + ').' FROM Compra WHERE ID = @IDGenerar
            INSERT INTO @Tabla (Mensaje) VALUES(@Mensaje)
          END

        ELSE IF @MovimientoGenerar = 'Entrada con Gastos'
          BEGIN
            EXEC spAfectar 'COMS', @IDGenerar, 'CONSECUTIVO', NULL, NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
            IF @OK BETWEEN 80030 AND 81000 SET @OK = NULL

            SELECT @Mensaje = 'Se generó el movimiento ' + LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,''))) + ' (' + LTRIM(RTRIM(ISNULL(Estatus,''))) + ').' FROM Compra WHERE ID = @IDGenerar
            INSERT INTO @Tabla (Mensaje) VALUES(@Mensaje)
          END

        ELSE IF @MovimientoGenerar = 'Entrada Importacion'
          BEGIN
            EXEC spAfectar 'COMS', @IDGenerar, 'CONSECUTIVO', NULL, NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
            IF @OK BETWEEN 80030 AND 81000 SET @OK = NULL

            SELECT @Mensaje = 'Se generó el movimiento ' + LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,''))) + ' (' + LTRIM(RTRIM(ISNULL(Estatus,''))) + ').' FROM Compra WHERE ID = @IDGenerar
            INSERT INTO @Tabla (Mensaje) VALUES(@Mensaje)
          END

      END
    ELSE
      BEGIN
        SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
        INSERT INTO @Tabla (Mensaje) VALUES(@Mensaje)
      END

   IF ISNULL(@OK,0) = 0
    BEGIN
      COMMIT TRANSACTION
    END ELSE
    BEGIN
      ROLLBACK TRANSACTION

      IF NOT @OK BETWEEN 80030 AND 81000
        BEGIN
          SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
          INSERT INTO @Tabla (Mensaje) VALUES(@Mensaje)
        END
    END

  END TRY

  BEGIN CATCH
    SELECT @Mensaje = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
    INSERT INTO @Tabla (Mensaje) VALUES (@Mensaje)

    SET @Ok = 1
    SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  END CATCH

  SELECT @Texto = (SELECT TOP 5 LTRIM(RTRIM(ISNULL(Mensaje,''))) AS Mensaje FROM @Tabla AS Tabla FOR XML AUTO)

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionTransitoLista ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionTransitoLista') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionTransitoLista
GO
CREATE PROCEDURE spIntelisisDistribucionTransitoLista
  @ID                        int,
  @iSolicitud                int,
  @Version                   float,
  @Resultado                 varchar(max) = NULL OUTPUT,
  @Ok                        int = NULL OUTPUT,
  @OkRef                     varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                   xml,
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Empresa                 varchar(5),
    @Usuario                 varchar(10),
    @Agente                  varchar(10),
    @Mov                     varchar(20),
    @Orden                   varchar(20),
    @Clave                   varchar(20),
    @SubClave                varchar(20)

  DECLARE @Tabla table(
    ID                       int,
    Mov                      varchar(20),
    MovID                    varchar(20),
    Movimiento               varchar(40),
    Almacen                  varchar(10),
    AlmacenNombre            varchar(100),
    AlmacenTransito          varchar(10),
    AlmacenTransitoNombre    varchar(100),
    AlmacenDestino           varchar(10),
    AlmacenDestinoNombre     varchar(100),
    fFechaEmision            datetime,
    FechaEmision             varchar(10)
    )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @Agente = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Agente'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @Orden = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Orden'

    SELECT @Clave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Clave'

    SELECT @SubClave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SubClave'

    SET @Empresa        = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Usuario        = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @Agente         = LTRIM(RTRIM(ISNULL(@Agente,'')))
    SET @Mov            = LTRIM(RTRIM(ISNULL(@Mov,'')))
    SET @Orden          = LTRIM(RTRIM(ISNULL(@Orden,'')))
    SET @Clave          = LTRIM(RTRIM(ISNULL(@Clave,'')))
    SET @SubClave       = LTRIM(RTRIM(ISNULL(@SubClave,'')))

    IF LTRIM(RTRIM(ISNULL(@Agente,''))) = '' SET @Agente = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    IF LTRIM(RTRIM(ISNULL(@Agente,''))) = '' SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
    IF NOT EXISTS(SELECT * FROM Agente WHERE Agente = @Agente) SET @Ok = 26090

    IF ISNULL(@Ok, 0) = 0
      BEGIN
        INSERT INTO @Tabla (ID, Mov, MovID, Almacen, AlmacenTransito, AlmacenDestino, fFechaEmision)
        SELECT i.ID, i.Mov, i.MovID, i.Almacen, i.AlmacenTransito, i.AlmacenDestino, i.FechaEmision
          FROM Inv i
         WHERE i.Estatus = 'PENDIENTE'
           AND i.Mov = @Mov
           AND i.Agente = @Agente

        UPDATE @Tabla
           SET AlmacenNombre = b.Nombre
          FROM @Tabla a
         INNER JOIN ALm b
            ON (a.Almacen = b.Almacen)

        UPDATE @Tabla
           SET AlmacenTransitoNombre = b.Nombre
          FROM @Tabla a
         INNER JOIN ALm b
            ON (a.AlmacenTransito = b.Almacen)

        UPDATE @Tabla
           SET AlmacenDestinoNombre = b.Nombre
          FROM @Tabla a
         INNER JOIN ALm b
            ON (a.AlmacenDestino = b.Almacen)

        UPDATE @Tabla SET FechaEmision = CAST(YEAR(fFechaEmision) AS varchar) + '-' + RIGHT('00' + CAST(MONTH(fFechaEmision) AS varchar),2) + '-' + RIGHT('00' + CAST(DAY(fFechaEmision) AS varchar), 2)
        UPDATE @Tabla SET Movimiento = RTRIM(LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,''))))

        SELECT @Texto = (SELECT CAST(ISNULL(ID,0) AS varchar)                   AS ID,
                                LTRIM(RTRIM(ISNULL(Mov,'')))                    AS Mov,
                                LTRIM(RTRIM(ISNULL(MovID,'')))                  AS MovID,
                                LTRIM(RTRIM(ISNULL(Movimiento,'')))             AS Movimiento,
                                LTRIM(RTRIM(ISNULL(Almacen,'')))                AS Almacen,
                                LTRIM(RTRIM(ISNULL(AlmacenNombre,'')))          AS AlmacenNombre,
                                LTRIM(RTRIM(ISNULL(AlmacenTransito,'')))        AS AlmacenTransito,
                                LTRIM(RTRIM(ISNULL(AlmacenTransitoNombre,'')))  AS AlmacenTransitoNombre,
                                LTRIM(RTRIM(ISNULL(AlmacenDestino,'')))         AS AlmacenDestino,
                                LTRIM(RTRIM(ISNULL(AlmacenDestinoNombre,'')))   AS AlmacenDestinoNombre,
                                LTRIM(RTRIM(ISNULL(FechaEmision,'')))           AS FechaEmision
                           FROM @Tabla AS Tabla
                            FOR XML AUTO)
      END

  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionTransitoDetalle ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionTransitoDetalle ') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionTransitoDetalle
GO
CREATE PROCEDURE spIntelisisDistribucionTransitoDetalle
    @ID                                int,
    @iSolicitud                        int,
    @Version                           float,
    @Resultado                         varchar(max) = NULL OUTPUT,
    @Ok                                int = NULL OUTPUT,
    @OkRef                             varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa                           varchar(5),
    @ReferenciaIS                      varchar(100),
    @SubReferencia                     varchar(100),
    @TransitoID                        int,
    @Texto                             xml

  DECLARE
    @IDR                               int,
    @Articulo                          varchar(20),
    @SubCuenta                         varchar(50),
    @DescripcionSubCuenta              varchar(1000),
    @Unidad                            varchar(50),
    @Codigo                            varchar(30),
    @CodigoTmp                         varchar(30),
    @RenglonID                         int,
    @Opcion                            varchar (20),
    @Juego                             varchar(10),
    @DescripcionJuego                  varchar(100),
    @CantidadJuego                     float,
    @SubCuentaOpcion                   varchar(50)

  DECLARE @TablaCB table(
    Codigo                             varchar(30)
  )

  DECLARE @Tabla Table(
    IDR                                int identity (1,1),
    ID                                 int,
    Movimiento                         varchar(20),
    MovimientoID                       varchar(20),
    Renglon                            float,
    RenglonSub                         int,
    RenglonID                          int,
    RenglonTipo                        char(1),
    Almacen                            varchar(10),
    Articulo                           varchar(20),
    Codigo                             varchar(max),
    SubCuenta                          varchar(50),
    Descripcion1                       varchar(100),
    Descripcion2                       varchar(255),
    NombreCorto                        varchar(20),
    DescripcionSubCuenta               varchar(1000),
    Cantidad                           float,
    CantidadPendiente                  float,
    CantidadA                          float,
    CantidadMaxima                     float,
    Unidad                             varchar(50),
    Factor                             float,
    CantidadInventario                 float,
    Tipo                               varchar(20),
    TipoOpcion                         varchar(20),
    Juego                              varchar(10),
    DescripcionJuego                   varchar(100),
    CantidadJuego                      float,
    Opcion                             varchar(20),
    SubCuentaOpcion                    varchar(50),
    DescripcionSubCuentaOpcion         varchar(1000)
  )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @TransitoID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'TransitoID'

    SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @TransitoID = ISNULL(@TransitoID,0)

    IF @TransitoID > 0
      BEGIN
        INSERT INTO @Tabla(ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Almacen, Articulo, Codigo, SubCuenta, Cantidad, CantidadPendiente, Unidad, Factor)
        SELECT @TransitoID,
               ISNULL(Renglon,0.0),
               ISNULL(RenglonSub,0),
               ISNULL(RenglonID,0),
               ISNULL(RenglonTipo,'N'),
               ISNULL(Almacen,''),
               LTRIM(RTRIM(ISNULL(Articulo,''))),
               LTRIM(RTRIM(ISNULL(Codigo,''))),
               LTRIM(RTRIM(ISNULL(SubCuenta,''))),
               ISNULL(Cantidad,0.0),
               ISNULL(CantidadPendiente,0.0),
               ISNULL(Unidad,''),
               ISNULL(Factor,0.0)
          FROM InvD
         WHERE ID = @TransitoID

        UPDATE @Tabla
           SET Movimiento = b.Mov,
               MovimientoID = b.MovID
          FROM @tabla a
         INNER JOIN Inv b ON (a.ID = b.ID)

        UPDATE @Tabla
           SET Descripcion1 = ISNULL(b.Descripcion1, ''),
               Descripcion2 = ISNULL(b.Descripcion2, ''),
               NombreCorto  = ISNULL(b.NombreCorto, ''),
               Tipo         = ISNULL(b.Tipo, ''),
               TipoOpcion   = ISNULL(b.TipoOpcion, '')
          FROM @Tabla a
         INNER JOIN Art b ON (a.Articulo = b.Articulo)

        UPDATE @Tabla SET CantidadMaxima = CantidadPendiente
        UPDATE @Tabla SET DescripcionSubCuenta = dbo.fnDescribirOpciones(Subcuenta)

        DECLARE TransitoDetalleJuego_cursor CURSOR FOR SELECT IDR, RenglonID, Articulo FROM @Tabla WHERE RenglonTipo = 'J'
        OPEN TransitoDetalleJuego_cursor
        FETCH NEXT FROM TransitoDetalleJuego_cursor INTO @IDR, @RenglonID, @Articulo
        WHILE @@FETCH_STATUS = 0
          BEGIN

            DECLARE Juego_cursor CURSOR FOR SELECT Articulo FROM @Tabla WHERE RenglonID = @RenglonID AND RenglonTipo = 'C'
            OPEN Juego_cursor
            FETCH NEXT FROM Juego_cursor INTO @Opcion
            WHILE @@FETCH_STATUS = 0
              BEGIN
                SELECT TOP 1 @Juego = Juego, @SubCuentaOpcion = SubCuenta
                  FROM ArtJuegoD
                 WHERE Articulo = @Articulo
                   AND Opcion = @Opcion

                UPDATE @Tabla
                   SET Juego = @Juego,
                       Opcion = @Opcion,
                       SubCuentaOpcion = @SubCuentaOpcion
                 WHERE RenglonID = @RenglonID
                   AND Articulo = @Opcion

                SELECT @DescripcionJuego = Descripcion,
                       @CantidadJuego = Cantidad
                  FROM ArtJuego
                 WHERE articulo = @Articulo
                   AND Juego = @Juego

                 UPDATE @Tabla
                    SET DescripcionJuego = @DescripcionJuego,
                        CantidadJuego = @CantidadJuego
                  WHERE RenglonID = @RenglonID
                    AND Articulo = @Opcion

                UPDATE @Tabla SET DescripcionSubCuentaOpcion = dbo.fnDescribirOpciones(SubCuentaOpcion)
                 WHERE RenglonID = @RenglonID
                   AND RenglonTipo = 'C'
                   AND LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) <> ''

              -->
              FETCH NEXT FROM Juego_cursor INTO @Opcion
            END
            CLOSE Juego_cursor
            DEALLOCATE Juego_cursor
            -->
            FETCH NEXT FROM TransitoDetalleJuego_cursor INTO @IDR, @RenglonID, @Articulo
          END

        CLOSE TransitoDetalleJuego_cursor
        DEALLOCATE TransitoDetalleJuego_cursor

        SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Movimiento,'')))                 AS Movimiento,
                                LTRIM(RTRIM(ISNULL(MovimientoID,'')))               AS MovimientoID,
                                CAST(ISNULL(Renglon,0) AS varchar)                  AS Renglon,
                                CAST(ISNULL(RenglonSub,0) AS varchar)               AS RenglonSub,
                                CAST(ISNULL(RenglonID,0) AS varchar)                AS RenglonID,
                                LTRIM(RTRIM(ISNULL(RenglonTipo,'N')))               AS RenglonTipo,
                                LTRIM(RTRIM(ISNULL(Almacen,'')))                    AS Almacen,
                                LTRIM(RTRIM(ISNULL(Articulo,'')))                   AS Articulo,
                                LTRIM(RTRIM(ISNULL(Codigo,'')))                     AS Codigo,
                                LTRIM(RTRIM(ISNULL(SubCuenta,'')))                  AS SubCuenta,
                                LTRIM(RTRIM(ISNULL(Descripcion1,'')))               AS Descripcion1,
                                LTRIM(RTRIM(ISNULL(Descripcion2,'')))               AS Descripcion2,
                                LTRIM(RTRIM(ISNULL(NombreCorto,'')))                AS NombreCorto,
                                LTRIM(RTRIM(ISNULL(DescripcionSubCuenta,'')))       AS DescripcionSubCuenta,
                                CAST(ISNULL(Cantidad,0) AS varchar)                 AS Cantidad,
                                CAST(ISNULL(CantidadPendiente,0) AS varchar)        AS CantidadPendiente,
                                CAST(ISNULL(CantidadA,0) AS varchar)                AS CantidadA,
                                CAST(ISNULL(CantidadMaxima,0) AS varchar)           AS CantidadMaxima,
                                LTRIM(RTRIM(ISNULL(Unidad,'')))                     AS Unidad,
                                CAST(ISNULL(Factor,1) AS varchar)                   AS Factor,
                                CAST(ISNULL(CantidadInventario,0) AS varchar)       AS CantidadInventario,
                                LTRIM(RTRIM(ISNULL(Tipo,'')))                       AS Tipo,
                                LTRIM(RTRIM(ISNULL(TipoOpcion,'')))                 AS TipoOpcion,
                                LTRIM(RTRIM(ISNULL(Juego,'')))                      AS Juego,
                                LTRIM(RTRIM(ISNULL(DescripcionJuego,'')))           AS DescripcionJuego,
                                CAST(ISNULL(CantidadJuego,0) AS varchar)            AS CantidadJuego,
                                LTRIM(RTRIM(ISNULL(Opcion,'')))                     AS Opcion,
                                LTRIM(RTRIM(ISNULL(SubCuentaOpcion,'')))            AS SubCuentaOpcion,
                                LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) AS DescripcionSubCuentaOpcion
                            FROM @Tabla AS Tabla
                           ORDER BY IDR
                          FOR XML AUTO)

      END
    ELSE
      BEGIN
        SET @Ok = 10160
      END

  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionInfoSerieLoteMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisDistribucionInfoSerieLoteMov ')           AND type = 'P') drop procedure dbo.spIntelisisDistribucionInfoSerieLoteMov
GO
CREATE PROCEDURE spIntelisisDistribucionInfoSerieLoteMov
  @ID                        int,
  @iSolicitud                int,
  @Version                   float,
  @Resultado                 varchar(max) = NULL OUTPUT,
  @Ok                        int = NULL OUTPUT,
  @OkRef                     varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
-- SET nocount ON
DECLARE
  @Empresa                   varchar(5),
  @Modulo                    varchar(5),
  @ModuloID                  varchar(255),
  @ModuloID2                 int,
  @ReferenciaIS              varchar(100),
  @SubReferencia             varchar(100),
  @Texto                     xml

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Modulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Modulo'

  SELECT @ModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ModuloID'

  SET @Empresa    = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Modulo     = LTRIM(RTRIM(ISNULL(@Modulo,'')))
  SET @ModuloID2  = CAST(ISNULL(@ModuloID,'0') AS int)

  IF @ModuloID2 > 0
    BEGIN
      DECLARE @Tabla Table(
        RenglonID            int,
        Articulo             varchar(20),
        SubCuenta            varchar(50),
        SerieLote            varchar(50),
        Cantidad             float
      )

      INSERT INTO @Tabla(RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
      SELECT ISNULL(RenglonID,0),
             ISNULL(Articulo,''),
             ISNULL(SubCuenta,''),
             ISNULL(SerieLote,''),
             ISNULL(Cantidad,0.0)
        FROM SerieLoteMov
       WHERE Empresa = @Empresa
         AND Modulo = @Modulo
         AND ID = @ModuloID
       ORDER BY SerieLote

    END
  ELSE
    BEGIN
      SET @Ok = 10160
    END

  IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
END TRY

BEGIN CATCH
  SET @Ok = 1
  SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
END CATCH

SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

SELECT @Texto = (SELECT CAST(ISNULL(RenglonID,0) AS VARCHAR) AS RenglonID,
                        LTRIM(RTRIM(ISNULL(Articulo,'')))    AS Articulo,
                        LTRIM(RTRIM(ISNULL(SubCuenta,'')))   AS SubCuenta,
                        LTRIM(RTRIM(ISNULL(SerieLote,'')))   AS SerieLote,
                        CAST(ISNULL(Cantidad,0) AS VARCHAR)  AS Cantidad
                    FROM @Tabla AS Tabla
                  FOR XML AUTO)

SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionAfectarTransito ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionAfectarTransito') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionAfectarTransito
GO
CREATE PROCEDURE spIntelisisDistribucionAfectarTransito
    @ID                      int,
    @iSolicitud              int,
    @Version                 float,
    @Resultado               varchar(max) = NULL OUTPUT,
    @Ok                      int = NULL OUTPUT,
    @OkRef                   varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa                 varchar(5),
    @Sucursal                int,
    @Usuario                 varchar(10),
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @xml                     xml,
    @Texto                   xml

  DECLARE
    @sModuloID               varchar(100),
    @ModuloID                int,
    @MovimientoGenerar       varchar(20),
    @IDGenerar               int,
    @Estacion                int,
    @FechaRegistro           datetime,
    @Mensaje                 varchar(255)

  SET @IDGenerar     = 0
  SET @Mensaje       = ''
  SET @Estacion      = @@SPID
  SET @FechaRegistro = dbo.fnFechaSinHora(GETDATE())

  DECLARE @TablaInvD table(
    IDX                      int identity (1,1),
    ID                       int,
    Renglon                  float,
    RenglonSub               int,
    RenglonID                int,
    Articulo                 varchar(20),
    SubCuenta                varchar(50),
    CantidadA                float
  )
  -- PENDIENTE SERIE lOTE ??? VERIFICAR EN ERP
  DECLARE @TablaSerieLoteMov table(
    IDX                      int identity (1,1),
    Empresa                  varchar(5),
    Modulo                   varchar(5),
    ID                       int,
    RenglonID                int,
    Articulo                 varchar(20),
    SubCuenta                varchar(50),
    SerieLote                varchar(50),
    Cantidad                 float,
    Sucursal                 int
  )

  DECLARE @Tabla Table(
    Mensaje                  varchar(255)
 )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Sucursal'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @sModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'ModuloID'

    SELECT @MovimientoGenerar = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovimientoGenerar'

    SET @Empresa           = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Sucursal          = LTRIM(RTRIM(ISNULL(@Sucursal,'')))
    SET @Usuario           = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @ModuloID          = CAST(ISNULL(@sModuloID,'0') AS int)
    SET @MovimientoGenerar = LTRIM(RTRIM(ISNULL(@MovimientoGenerar,'')))

    INSERT INTO @TablaInvD (ID, Renglon, RenglonSub, RenglonID, Articulo, SubCuenta, CantidadA)
    SELECT ID, Renglon, RenglonSub, RenglonID, Articulo, SubCuenta, CantidadA
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Tabla')
      WITH (ID          int           '@ID',
            Renglon     float         '@Renglon',
            RenglonSub  int           '@RenglonSub',
            RenglonID   int           '@RenglonID',
            Articulo    varchar (20)  '@Articulo',
            SubCuenta   varchar (50)  '@SubCuenta',
            CantidadA   float         '@CantidadA');

    INSERT INTO @TablaSerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal)
    SELECT Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Tabla2')
      WITH (Empresa     varchar (5)   '@Empresa',
            Modulo      varchar (5)   '@Modulo',
            ID          int           '@ID',
            RenglonID   int           '@RenglonID',
            Articulo    varchar (20)  '@Articulo',
            SubCuenta   varchar (50)  '@SubCuenta',
            SerieLote   varchar (50)  '@SerieLote',
            Cantidad    float         '@Cantidad',
            Sucursal    int           '@Sucursal');

    UPDATE InvD
       SET CantidadA = ISNULL(b.CantidadA,0)
      FROM InvD a
      JOIN @TablaInvD b
        ON (a.ID        = b.ID
       AND a.Renglon    = b.Renglon
       AND a.RenglonSub = b.RenglonSub
       AND a.RenglonID  = b.RenglonID)

    -- Actualizar SerieLoteMov -----------------------------------------------------------------------------
    -- VERIFICAR si es necesario mejor usar MERGE ----------------------------------------------------------
    DELETE SerieLoteMov WHERE Empresa = @Empresa AND ID = @ModuloID

    INSERT INTO SerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal)
    SELECT Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal
      FROM @TablaSerieLoteMov
    --------------------------------------------------------------------------------------------------------

    EXEC @IDGenerar = spAfectar 'INV', @ModuloID, 'GENERAR', 'Seleccion', @MovimientoGenerar, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF ISNULL(@OK,0) = 0 OR ISNULL(@OK,0) BETWEEN 80030 AND 81000
      BEGIN
        SET @Ok = NULL
        SET @OkRef = NULL

        IF @MovimientoGenerar = 'Recibo Traspaso'
          BEGIN
           EXEC spAfectar 'INV', @IDGenerar, 'AFECTAR', 'TODO', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

            IF @OK BETWEEN 80030 AND 81000 SET @OK = NULL

            SELECT @Mensaje = 'Se generó el movimiento ' + LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,''))) + ' (' + LTRIM(RTRIM(ISNULL(Estatus,''))) + ').' FROM Inv WHERE ID = @IDGenerar
            INSERT INTO @Tabla (Mensaje) VALUES(@Mensaje)
          END

      END
    ELSE
      BEGIN
        SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
        INSERT INTO @Tabla (Mensaje) VALUES(@Mensaje)
      END

  END TRY

  BEGIN CATCH
    SELECT @Mensaje = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
    INSERT INTO @Tabla (Mensaje) VALUES (@Mensaje)

    SET @Ok = 1
    SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  END CATCH

  SELECT @Texto = (SELECT TOP 5 LTRIM(RTRIM(ISNULL(Mensaje,''))) AS Mensaje FROM @Tabla AS Tabla FOR XML AUTO)

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Surtido
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionMovimientosSurtidoLista ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionMovimientosSurtidoLista') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionMovimientosSurtidoLista
GO
CREATE PROCEDURE spIntelisisDistribucionMovimientosSurtidoLista
  @ID              int,
  @iSolicitud      int,
  @Version         float,
  @Resultado       varchar(max) = NULL OUTPUT,
  @Ok              int = NULL OUTPUT,
  @OkRef           varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto         xml,
    @ReferenciaIS  varchar(100),
    @SubReferencia varchar(100),
    @Empresa       varchar(5),
    @Usuario       varchar(10)

  DECLARE @Tabla   table(
    Mov            varchar(20),
    Orden          int,
    Clave          varchar(20),
    SubClave       varchar(20)
    )

  BEGIN TRY
     SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
      WHERE Campo = 'Empresa'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
      WHERE Campo = 'Usuario'

    SET @Empresa = ISNULL(@Empresa,'')
    SET @Usuario = ISNULL(@Usuario,'')

    INSERT INTO @Tabla (Mov, Orden, Clave, SubClave)
    SELECT Mov, Orden, Clave, SubClave
      FROM MovTipo
     WHERE Modulo = 'VTAS'
       AND Clave = 'VTAS.P'
       AND Mov IN ('Orden Surtido')
     ORDER BY Orden

    INSERT INTO @Tabla (Mov, Orden, Clave, SubClave)
    SELECT Mov, Orden, Clave, SubClave
      FROM MovTipo
     WHERE Modulo = 'INV'
       --AND Clave = 'INV.OI'
       AND Clave = 'INV.SI'
       --AND Mov IN ('Orden Traspaso')
       AND Mov IN ('Salida Traspaso')
     ORDER BY Orden

    SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Mov,'')))      AS Mov,
                            CAST(ISNULL(Orden,0) AS varchar)  AS Orden,
                            LTRIM(RTRIM(ISNULL(Clave,'')))    AS Clave,
                            LTRIM(RTRIM(ISNULL(SubClave,''))) AS SubClave
                       FROM @Tabla AS Tabla
                        FOR XML AUTO)

    IF NOT ISNULL(@Ok, 0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionOrdenSurtidoLista ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionOrdenSurtidoLista') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionOrdenSurtidoLista
GO
CREATE PROCEDURE spIntelisisDistribucionOrdenSurtidoLista
  @ID                        int,
  @iSolicitud                int,
  @Version                   float,
  @Resultado                 varchar(max) = NULL OUTPUT,
  @Ok                        int = NULL OUTPUT,
  @OkRef                     varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                   xml,
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Empresa                 varchar(5),
    @Usuario                 varchar(10),
    @Agente                  varchar(10),
    @Mov                     varchar(20),
    @Orden                   varchar(20),
    @Clave                   varchar(20),
    @SubClave                varchar(20)

  DECLARE @Tabla table(
    ID                       int,
    Mov                      varchar(20),
    MovID                    varchar(20),
    Movimiento               varchar(40),
    Almacen                  varchar(10),
    AlmacenNombre            varchar(100),
    AlmacenDestino           varchar(10),
    AlmacenDestinoNombre     varchar(100),
    fFechaEmision            datetime,
    FechaEmision             varchar(10)
    )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @Agente = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Agente'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @Orden = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Orden'

    SELECT @Clave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Clave'

    SELECT @SubClave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SubClave'

    SET @Empresa        = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Usuario        = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @Agente         = LTRIM(RTRIM(ISNULL(@Agente,'')))
    SET @Mov            = LTRIM(RTRIM(ISNULL(@Mov,'')))
    SET @Orden          = LTRIM(RTRIM(ISNULL(@Orden,'')))
    SET @Clave          = LTRIM(RTRIM(ISNULL(@Clave,'')))
    SET @SubClave       = LTRIM(RTRIM(ISNULL(@SubClave,'')))

    IF LTRIM(RTRIM(ISNULL(@Agente,''))) = '' SET @Agente = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    IF LTRIM(RTRIM(ISNULL(@Agente,''))) = '' SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
    IF NOT EXISTS(SELECT * FROM Agente WHERE Agente = @Agente) SET @Ok = 26090

    IF ISNULL(@Ok, 0) = 0
      BEGIN
        INSERT INTO @Tabla (ID, Mov, MovID, Almacen, AlmacenDestino, fFechaEmision)
        SELECT v.ID, v.Mov, v.MovID, v.Almacen, v.AlmacenDestino, v.FechaEmision
          FROM Venta v
         WHERE v.Estatus = 'PENDIENTE'
           AND v.Mov = @Mov
           AND v.Agente = @Agente
           AND LTRIM(RTRIM(ISNULL(v.Situacion,''))) IN ('Autorizado','')

        DELETE a
          FROM @Tabla AS a
          JOIN Venta  AS b
            ON a.MovID = b.OrigenID
         WHERE b.OrigenTipo = 'VTAS'
           AND b.Origen = 'Orden Surtido'
           AND b.Estatus <> 'CANCELADO'

        UPDATE @Tabla
           SET AlmacenNombre = b.Nombre
          FROM @Tabla a
         INNER JOIN ALm b
            ON (a.Almacen = b.Almacen)

        UPDATE @Tabla
           SET AlmacenDestinoNombre = b.Nombre
          FROM @Tabla a
         INNER JOIN ALm b
            ON (a.AlmacenDestino = b.Almacen)

        UPDATE @Tabla SET FechaEmision = CAST(YEAR(fFechaEmision) AS varchar) + '-' + RIGHT('00' + CAST(MONTH(fFechaEmision) AS varchar),2) + '-' + RIGHT('00' + CAST(DAY(fFechaEmision) AS varchar), 2)
        UPDATE @Tabla SET Movimiento = RTRIM(LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,''))))

        SELECT @Texto = (SELECT CAST(ISNULL(ID,0) AS varchar)                   AS ID,
                                LTRIM(RTRIM(ISNULL(Mov,'')))                    AS Mov,
                                LTRIM(RTRIM(ISNULL(MovID,'')))                  AS MovID,
                                LTRIM(RTRIM(ISNULL(Movimiento,'')))             AS Movimiento,
                                LTRIM(RTRIM(ISNULL(Almacen,'')))                AS Almacen,
                                LTRIM(RTRIM(ISNULL(AlmacenNombre,'')))          AS AlmacenNombre,
                                LTRIM(RTRIM(ISNULL(AlmacenDestino,'')))         AS AlmacenDestino,
                                LTRIM(RTRIM(ISNULL(AlmacenDestinoNombre,'')))   AS AlmacenDestinoNombre,
                                LTRIM(RTRIM(ISNULL(FechaEmision,'')))           AS FechaEmision
                           FROM @Tabla AS Tabla
                            FOR XML AUTO)
      END

  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionOrdenSurtidoDetalle ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionOrdenSurtidoDetalle ') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionOrdenSurtidoDetalle
GO
CREATE PROCEDURE spIntelisisDistribucionOrdenSurtidoDetalle
    @ID                                int,
    @iSolicitud                        int,
    @Version                           float,
    @Resultado                         varchar(max) = NULL OUTPUT,
    @Ok                                int = NULL OUTPUT,
    @OkRef                             varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa                           varchar(5),
    @ReferenciaIS                      varchar(100),
    @SubReferencia                     varchar(100),
    @OrdenSurtidoID                    int,
    @Texto                             xml

  DECLARE
    @IDR                               int,
    @Articulo                          varchar(20),
    @SubCuenta                         varchar(50),
    @DescripcionSubCuenta              varchar(1000),
    @Unidad                            varchar(50),
    @Codigo                            varchar(30),
    @CodigoTmp                         varchar(30),
    @RenglonID                         int,
    @Opcion                            varchar (20),
    @Juego                             varchar(10),
    @DescripcionJuego                  varchar(100),
    @CantidadJuego                     float,
    @SubCuentaOpcion                   varchar(50)

  --DECLARE @TablaCB table(
  --  Codigo                             varchar(30)
  --)

  DECLARE @Tabla Table(
    IDR                                int identity (1,1),
    ID                                 int,
    Movimiento                         varchar(20),
    MovimientoID                       varchar(20),
    Renglon                            float,
    RenglonSub                         int,
    RenglonID                          int,
    RenglonTipo                        char(1),
    Almacen                            varchar(10),
    Articulo                           varchar(20),
    Codigo                             varchar(max),
    SubCuenta                          varchar(50),
    Descripcion1                       varchar(100),
    Descripcion2                       varchar(255),
    NombreCorto                        varchar(20),
    DescripcionSubCuenta               varchar(1000),
    Cantidad                           float,
    CantidadPendiente                  float,
    CantidadA                          float,
    CantidadMaxima                     float,
    Unidad                             varchar(50),
    Factor                             float,
    CantidadInventario                 float,
    Tipo                               varchar(20),
    TipoOpcion                         varchar(20),
    Juego                              varchar(10),
    DescripcionJuego                   varchar(100),
    CantidadJuego                      float,
    Opcion                             varchar(20),
    SubCuentaOpcion                    varchar(50),
    DescripcionSubCuentaOpcion         varchar(1000)
  )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @OrdenSurtidoID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'OrdenSurtidoID'

    SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @OrdenSurtidoID = ISNULL(@OrdenSurtidoID,0)

    IF @OrdenSurtidoID > 0
      BEGIN
        INSERT INTO @Tabla(ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Almacen, Articulo, Codigo, SubCuenta, Cantidad, CantidadPendiente, Unidad, Factor)
        SELECT @OrdenSurtidoID,
               ISNULL(Renglon,0.0),
               ISNULL(RenglonSub,0),
               ISNULL(RenglonID,0),
               ISNULL(RenglonTipo,'N'),
               ISNULL(Almacen,''),
               LTRIM(RTRIM(ISNULL(Articulo,''))),
               LTRIM(RTRIM(ISNULL(Codigo,''))),
               LTRIM(RTRIM(ISNULL(SubCuenta,''))),
               ISNULL(Cantidad,0.0),
               ISNULL(CantidadPendiente,0.0) + ISNULL(CantidadReservada,0.0),
               ISNULL(Unidad,''),
               ISNULL(Factor,0.0)
          FROM VentaD
         WHERE ID = @OrdenSurtidoID

        UPDATE @Tabla
           SET Movimiento = b.Mov,
               MovimientoID = b.MovID
          FROM @tabla a
         INNER JOIN Venta b ON (a.ID = b.ID)

        UPDATE @Tabla
           SET Descripcion1 = ISNULL(b.Descripcion1, ''),
               Descripcion2 = ISNULL(b.Descripcion2, ''),
               NombreCorto  = ISNULL(b.NombreCorto, ''),
               Tipo         = ISNULL(b.Tipo, ''),
               TipoOpcion   = ISNULL(b.TipoOpcion, '')
          FROM @Tabla a
         INNER JOIN Art b ON (a.Articulo = b.Articulo)

        UPDATE @Tabla SET CantidadMaxima = CantidadPendiente
        UPDATE @Tabla SET DescripcionSubCuenta = dbo.fnDescribirOpciones(Subcuenta)

        DECLARE OrdenSurtidoDetalleJuego_cursor CURSOR FOR SELECT IDR, RenglonID, Articulo FROM @Tabla WHERE RenglonTipo = 'J'
        OPEN OrdenSurtidoDetalleJuego_cursor
        FETCH NEXT FROM OrdenSurtidoDetalleJuego_cursor INTO @IDR, @RenglonID, @Articulo
        WHILE @@FETCH_STATUS = 0
          BEGIN

            DECLARE Juego_cursor CURSOR FOR SELECT Articulo FROM @Tabla WHERE RenglonID = @RenglonID AND RenglonTipo = 'C'
            OPEN Juego_cursor
            FETCH NEXT FROM Juego_cursor INTO @Opcion
            WHILE @@FETCH_STATUS = 0
              BEGIN
                SELECT TOP 1 @Juego = Juego, @SubCuentaOpcion = SubCuenta
                  FROM ArtJuegoD
                 WHERE Articulo = @Articulo
                   AND Opcion = @Opcion

                UPDATE @Tabla
                   SET Juego = @Juego,
                       Opcion = @Opcion,
                       SubCuentaOpcion = @SubCuentaOpcion
                 WHERE RenglonID = @RenglonID
                   AND Articulo = @Opcion

                SELECT @DescripcionJuego = Descripcion,
                       @CantidadJuego = Cantidad
                  FROM ArtJuego
                 WHERE articulo = @Articulo
                   AND Juego = @Juego

                 UPDATE @Tabla
                    SET DescripcionJuego = @DescripcionJuego,
                        CantidadJuego = @CantidadJuego
                  WHERE RenglonID = @RenglonID
                    AND Articulo = @Opcion

                UPDATE @Tabla SET DescripcionSubCuentaOpcion = dbo.fnDescribirOpciones(SubCuentaOpcion)
                 WHERE RenglonID = @RenglonID
                   AND RenglonTipo = 'C'
                   AND LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) <> ''

              -->
              FETCH NEXT FROM Juego_cursor INTO @Opcion
            END
            CLOSE Juego_cursor
            DEALLOCATE Juego_cursor
            -->
            FETCH NEXT FROM OrdenSurtidoDetalleJuego_cursor INTO @IDR, @RenglonID, @Articulo
          END

        CLOSE OrdenSurtidoDetalleJuego_cursor
        DEALLOCATE OrdenSurtidoDetalleJuego_cursor

        SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Movimiento,'')))                 AS Movimiento,
                                LTRIM(RTRIM(ISNULL(MovimientoID,'')))               AS MovimientoID,
                                CAST(ISNULL(Renglon,0) AS varchar)                  AS Renglon,
                                CAST(ISNULL(RenglonSub,0) AS varchar)               AS RenglonSub,
                                CAST(ISNULL(RenglonID,0) AS varchar)                AS RenglonID,
                                LTRIM(RTRIM(ISNULL(RenglonTipo,'N')))               AS RenglonTipo,
                                LTRIM(RTRIM(ISNULL(Almacen,'')))                    AS Almacen,
                                LTRIM(RTRIM(ISNULL(Articulo,'')))                   AS Articulo,
                                LTRIM(RTRIM(ISNULL(Codigo,'')))                     AS Codigo,
                                LTRIM(RTRIM(ISNULL(SubCuenta,'')))                  AS SubCuenta,
                                LTRIM(RTRIM(ISNULL(Descripcion1,'')))               AS Descripcion1,
                                LTRIM(RTRIM(ISNULL(Descripcion2,'')))               AS Descripcion2,
                                LTRIM(RTRIM(ISNULL(NombreCorto,'')))                AS NombreCorto,
                                LTRIM(RTRIM(ISNULL(DescripcionSubCuenta,'')))       AS DescripcionSubCuenta,
                                CAST(ISNULL(Cantidad,0) AS varchar)                 AS Cantidad,
                                CAST(ISNULL(CantidadPendiente,0) AS varchar)        AS CantidadPendiente,
                                CAST(ISNULL(CantidadA,0) AS varchar)                AS CantidadA,
                                CAST(ISNULL(CantidadMaxima,0) AS varchar)           AS CantidadMaxima,
                                LTRIM(RTRIM(ISNULL(Unidad,'')))                     AS Unidad,
                                CAST(ISNULL(Factor,1) AS varchar)                   AS Factor,
                                CAST(ISNULL(CantidadInventario,0) AS varchar)       AS CantidadInventario,
                                LTRIM(RTRIM(ISNULL(Tipo,'')))                       AS Tipo,
                                LTRIM(RTRIM(ISNULL(TipoOpcion,'')))                 AS TipoOpcion,
                                LTRIM(RTRIM(ISNULL(Juego,'')))                      AS Juego,
                                LTRIM(RTRIM(ISNULL(DescripcionJuego,'')))           AS DescripcionJuego,
                                CAST(ISNULL(CantidadJuego,0) AS varchar)            AS CantidadJuego,
                                LTRIM(RTRIM(ISNULL(Opcion,'')))                     AS Opcion,
                                LTRIM(RTRIM(ISNULL(SubCuentaOpcion,'')))            AS SubCuentaOpcion,
                                LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) AS DescripcionSubCuentaOpcion
                            FROM @Tabla AS Tabla
                           ORDER BY IDR
                          FOR XML AUTO)

      END
    ELSE
      BEGIN
        SET @Ok = 10160
      END

  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionMovimientosGenerar ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionMovimientosGenerar') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionMovimientosGenerar
GO
CREATE PROCEDURE spIntelisisDistribucionMovimientosGenerar
    @ID                      int,
    @iSolicitud              int,
    @Version                 float,
    @Resultado               varchar(max) = NULL OUTPUT,
    @Ok                      int = NULL OUTPUT,
    @OkRef                   varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa                 varchar(5),
    @Modulo                  varchar(5),
    @Origen                  varchar(50),
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @xml                     xml,
    @Texto                   xml

  DECLARE
    @sModuloID               varchar(100),
    @ModuloID                int,
    @MovimientoGenerar       varchar(20),
    @IDGenerar               int,
    @Estacion                int,
    @Mensaje                 varchar(255)

  SET @IDGenerar = 0
  SET @Mensaje   = ''
  SET @Estacion  = @@SPID

  DECLARE @Tabla table(
    Modulo                   varchar(20),
    Origen                   varchar(50),
    Destino                  varchar(50),
    Orden                    int,
    Generar                  varchar(100)
  )

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
    WHERE Campo = 'Empresa'

  SELECT @Modulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
    WHERE Campo = 'Modulo'

  SELECT @Origen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
    WHERE Campo = 'Origen'

  SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Modulo  = LTRIM(RTRIM(ISNULL(@Modulo,'')))
  SET @Origen  = LTRIM(RTRIM(ISNULL(@Origen,'')))

  INSERT INTO @Tabla (Modulo, Origen, Destino, Orden, Generar)
  SELECT Modulo, OMov, DMov, Orden, Nombre
    FROM CfgMovFlujo
   WHERE Modulo = @Modulo
     AND OMov = @Origen
   ORDER BY Orden

  SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Modulo,'')))  AS Modulo,
                          LTRIM(RTRIM(ISNULL(Origen,'')))  AS Origen,
                          LTRIM(RTRIM(ISNULL(Destino,''))) AS Destino,
                          CAST(ISNULL(Orden,0) AS varchar) AS Orden,
                          LTRIM(RTRIM(ISNULL(Generar,''))) AS Generar
                     FROM @Tabla AS Tabla
                      FOR XML AUTO)

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionAfectarOrdenSurtido ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionAfectarOrdenSurtido') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionAfectarOrdenSurtido
GO
CREATE PROCEDURE spIntelisisDistribucionAfectarOrdenSurtido
    @ID                      int,
    @iSolicitud              int,
    @Version                 float,
    @Resultado               varchar(max) = NULL OUTPUT,
    @Ok                      int = NULL OUTPUT,
    @OkRef                   varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa                 varchar(5),
    @Sucursal                int,
    @Usuario                 varchar(10),
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @xml                     xml,
    @Texto                   xml

  DECLARE
    @sModuloID               varchar(100),
    @ModuloID                int,
    @MovimientoGenerar       varchar(20),
    @IDGenerar               int,
    @Estacion                int,
    @FechaRegistro           datetime,
    @Mensaje                 varchar(255)

  SET @IDGenerar     = 0
  SET @Mensaje       = ''
  SET @Estacion      = @@SPID
  SET @FechaRegistro = dbo.fnFechaSinHora(GETDATE())

  DECLARE @TablaVentaD table(
    IDX                      int identity (1,1),
    ID                       int,
    Renglon                  float,
    RenglonSub               int,
    RenglonID                int,
    Articulo                 varchar(20),
    SubCuenta                varchar(50),
    CantidadA                float
  )

  DECLARE @TablaSerieLoteMov table(
    IDX                      int identity (1,1),
    Empresa                  varchar(5),
    Modulo                   varchar(5),
    ID                       int,
    RenglonID                int,
    Articulo                 varchar(20),
    SubCuenta                varchar(50),
    SerieLote                varchar(50),
    Cantidad                 float,
    Sucursal                 int
  )

  DECLARE @Tabla Table(
    Mensaje                  varchar(255)
 )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Sucursal'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @sModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'ModuloID'

    SELECT @MovimientoGenerar = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovimientoGenerar'

    SET @Empresa           = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Sucursal          = LTRIM(RTRIM(ISNULL(@Sucursal,'')))
    SET @Usuario           = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @ModuloID          = CAST(ISNULL(@sModuloID,'0') AS int)
    SET @MovimientoGenerar = LTRIM(RTRIM(ISNULL(@MovimientoGenerar,'')))

    INSERT INTO @TablaVentaD (ID, Renglon, RenglonSub, RenglonID, Articulo, SubCuenta, CantidadA)
    SELECT ID, Renglon, RenglonSub, RenglonID, Articulo, SubCuenta, CantidadA
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Tabla')
      WITH (ID          int           '@ID',
            Renglon     float         '@Renglon',
            RenglonSub  int           '@RenglonSub',
            RenglonID   int           '@RenglonID',
            Articulo    varchar (20)  '@Articulo',
            SubCuenta   varchar (50)  '@SubCuenta',
            CantidadA   float         '@CantidadA');

    INSERT INTO @TablaSerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal)
    SELECT Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Tabla2')
      WITH (Empresa     varchar (5)   '@Empresa',
            Modulo      varchar (5)   '@Modulo',
            ID          int           '@ID',
            RenglonID   int           '@RenglonID',
            Articulo    varchar (20)  '@Articulo',
            SubCuenta   varchar (50)  '@SubCuenta',
            SerieLote   varchar (50)  '@SerieLote',
            Cantidad    float         '@Cantidad',
            Sucursal    int           '@Sucursal');

    UPDATE VentaD
       SET CantidadA = ISNULL(b.CantidadA,0)
      FROM VentaD a
      JOIN @TablaVentaD b
        ON (a.ID        = b.ID
       AND a.Renglon    = b.Renglon
       AND a.RenglonSub = b.RenglonSub
       AND a.RenglonID  = b.RenglonID)

    EXEC @IDGenerar = spAfectar 'VTAS', @ModuloID, 'GENERAR', 'Seleccion', @MovimientoGenerar, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF ISNULL(@OK,0) = 0 OR ISNULL(@OK,0) BETWEEN 80030 AND 81000
      BEGIN
        SET @Ok = NULL
        SET @OkRef = NULL

        IF (SELECT COUNT(IDX) FROM @TablaSerieLoteMov) > 0
          BEGIN
            UPDATE @TablaSerieLoteMov SET ID = @IDGenerar

            INSERT INTO SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal)
            SELECT Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal
              FROM @TablaSerieLoteMov
             ORDER BY IDX
          END

        SELECT @Mensaje = 'Se generó el movimiento ' + LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,''))) + ' (' + LTRIM(RTRIM(ISNULL(Estatus,''))) + ').' FROM Venta WHERE ID = @IDGenerar
        INSERT INTO @Tabla (Mensaje) VALUES(@Mensaje)

      END
    ELSE
      BEGIN
        SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
        INSERT INTO @Tabla (Mensaje) VALUES(@Mensaje)
      END

  END TRY

  BEGIN CATCH
    SELECT @Mensaje = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
    INSERT INTO @Tabla (Mensaje) VALUES (@Mensaje)

    SET @Ok = 1
    SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  END CATCH

  SELECT @Texto = (SELECT TOP 5 LTRIM(RTRIM(ISNULL(Mensaje,''))) AS Mensaje FROM @Tabla AS Tabla FOR XML AUTO)

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisDistribucionSalidaTraspasoLista ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionSalidaTraspasoLista') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionSalidaTraspasoLista
GO
CREATE PROCEDURE spIntelisisDistribucionSalidaTraspasoLista
  @ID                        int,
  @iSolicitud                int,
  @Version                   float,
  @Resultado                 varchar(max) = NULL OUTPUT,
  @Ok                        int = NULL OUTPUT,
  @OkRef                     varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                   xml,
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Empresa                 varchar(5),
    @Usuario                 varchar(10),
    @Agente                  varchar(10),
    @Mov                     varchar(20),
    @Orden                   varchar(20),
    @Clave                   varchar(20),
    @SubClave                varchar(20)

  DECLARE @Tabla table(
    ID                       int,
    Mov                      varchar(20),
    MovID                    varchar(20),
    Movimiento               varchar(40),
    Almacen                  varchar(10),
    AlmacenNombre            varchar(100),
    AlmacenTransito          varchar(10),
    AlmacenTransitoNombre    varchar(100),
    AlmacenDestino           varchar(10),
    AlmacenDestinoNombre     varchar(100),
    fFechaEmision            datetime,
    FechaEmision             varchar(10),
    Origen                   varchar(20),
    OrigenID                 varchar(20)
    )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @Agente = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Agente'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @Orden = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Orden'

    SELECT @Clave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Clave'

    SELECT @SubClave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SubClave'

    SET @Empresa        = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Usuario        = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @Agente         = LTRIM(RTRIM(ISNULL(@Agente,'')))
    SET @Mov            = LTRIM(RTRIM(ISNULL(@Mov,'')))
    SET @Orden          = LTRIM(RTRIM(ISNULL(@Orden,'')))
    SET @Clave          = LTRIM(RTRIM(ISNULL(@Clave,'')))
    SET @SubClave       = LTRIM(RTRIM(ISNULL(@SubClave,'')))

    IF LTRIM(RTRIM(ISNULL(@Agente,''))) = '' SET @Agente = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    IF LTRIM(RTRIM(ISNULL(@Agente,''))) = '' SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
    IF NOT EXISTS(SELECT * FROM Agente WHERE Agente = @Agente) SET @Ok = 26090

    IF ISNULL(@Ok, 0) = 0
      BEGIN
        INSERT INTO @Tabla (ID, Mov, MovID, Almacen, AlmacenTransito, AlmacenDestino, fFechaEmision, Origen, OrigenID)
        SELECT i.ID, i.Mov, i.MovID, i.Almacen, i.AlmacenTransito, i.AlmacenDestino, i.FechaEmision, i.Origen, i.OrigenID
          FROM Inv i
         WHERE i.Estatus = 'SINAFECTAR'
           AND i.Mov = @Mov
           AND LTRIM(RTRIM(ISNULL(i.MovID,''))) = ''
           AND i.Agente = @Agente

        UPDATE @Tabla
           SET AlmacenNombre = b.Nombre
          FROM @Tabla a
         INNER JOIN ALm b
            ON (a.Almacen = b.Almacen)

        UPDATE @Tabla
           SET AlmacenTransitoNombre = b.Nombre
          FROM @Tabla a
         INNER JOIN ALm b
            ON (a.AlmacenTransito = b.Almacen)

        UPDATE @Tabla
           SET AlmacenDestinoNombre = b.Nombre
          FROM @Tabla a
         INNER JOIN ALm b
            ON (a.AlmacenDestino = b.Almacen)

        UPDATE @Tabla SET FechaEmision = CAST(YEAR(fFechaEmision) AS varchar) + '-' + RIGHT('00' + CAST(MONTH(fFechaEmision) AS varchar),2) + '-' + RIGHT('00' + CAST(DAY(fFechaEmision) AS varchar), 2)
        UPDATE @Tabla SET Movimiento = RTRIM(LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,''))))

        SELECT @Texto = (SELECT CAST(ISNULL(ID,0) AS varchar)                   AS ID,
                                LTRIM(RTRIM(ISNULL(Mov,'')))                    AS Mov,
                                LTRIM(RTRIM(ISNULL(MovID,'')))                  AS MovID,
                                LTRIM(RTRIM(ISNULL(Movimiento,'')))             AS Movimiento,
                                LTRIM(RTRIM(ISNULL(Almacen,'')))                AS Almacen,
                                LTRIM(RTRIM(ISNULL(AlmacenNombre,'')))          AS AlmacenNombre,
                                LTRIM(RTRIM(ISNULL(AlmacenTransito,'')))        AS AlmacenTransito,
                                LTRIM(RTRIM(ISNULL(AlmacenTransitoNombre,'')))  AS AlmacenTransitoNombre,
                                LTRIM(RTRIM(ISNULL(AlmacenDestino,'')))         AS AlmacenDestino,
                                LTRIM(RTRIM(ISNULL(AlmacenDestinoNombre,'')))   AS AlmacenDestinoNombre,
                                LTRIM(RTRIM(ISNULL(FechaEmision,'')))           AS FechaEmision,
                                LTRIM(RTRIM(ISNULL(Origen,'')))                 AS Origen,
                                LTRIM(RTRIM(ISNULL(OrigenID,'')))               AS OrigenID
                           FROM @Tabla AS Tabla
                            FOR XML AUTO)
      END

  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionSalidaTraspasoDetalle ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionSalidaTraspasoDetalle ') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionSalidaTraspasoDetalle
GO
CREATE PROCEDURE spIntelisisDistribucionSalidaTraspasoDetalle
    @ID                                int,
    @iSolicitud                        int,
    @Version                           float,
    @Resultado                         varchar(max) = NULL OUTPUT,
    @Ok                                int = NULL OUTPUT,
    @OkRef                             varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa                           varchar(5),
    @ReferenciaIS                      varchar(100),
    @SubReferencia                     varchar(100),
    @SalidaTraspasoID                        int,
    @Texto                             xml

  DECLARE
    @IDR                               int,
    @Articulo                          varchar(20),
    @SubCuenta                         varchar(50),
    @DescripcionSubCuenta              varchar(1000),
    @Unidad                            varchar(50),
    @Codigo                            varchar(30),
    @CodigoTmp                         varchar(30),
    @RenglonID                         int,
    @Opcion                            varchar (20),
    @Juego                             varchar(10),
    @DescripcionJuego                  varchar(100),
    @CantidadJuego                     float,
    @SubCuentaOpcion                   varchar(50)

  DECLARE @TablaCB table(
    Codigo                             varchar(30)
  )

  DECLARE @Tabla Table(
    IDR                                int identity (1,1),
    ID                                 int,
    Movimiento                         varchar(20),
    MovimientoID                       varchar(20),
    Renglon                            float,
    RenglonSub                         int,
    RenglonID                          int,
    RenglonTipo                        char(1),
    Almacen                            varchar(10),
    Articulo                           varchar(20),
    Codigo                             varchar(max),
    SubCuenta                          varchar(50),
    Descripcion1                       varchar(100),
    Descripcion2                       varchar(255),
    NombreCorto                        varchar(20),
    DescripcionSubCuenta               varchar(1000),
    Cantidad                           float,
    CantidadPendiente                  float,
    CantidadA                          float,
    CantidadMaxima                     float,
    Unidad                             varchar(50),
    Factor                             float,
    CantidadInventario                 float,
    Tipo                               varchar(20),
    TipoOpcion                         varchar(20),
    Juego                              varchar(10),
    DescripcionJuego                   varchar(100),
    CantidadJuego                      float,
    Opcion                             varchar(20),
    SubCuentaOpcion                    varchar(50),
    DescripcionSubCuentaOpcion         varchar(1000)
  )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @SalidaTraspasoID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SalidaTraspasoID'

    SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @SalidaTraspasoID = ISNULL(@SalidaTraspasoID,0)

    IF @SalidaTraspasoID > 0
      BEGIN
        INSERT INTO @Tabla(ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Almacen, Articulo, Codigo, SubCuenta, Cantidad, CantidadPendiente, Unidad, Factor)
        SELECT @SalidaTraspasoID,
               ISNULL(Renglon,0.0),
               ISNULL(RenglonSub,0),
               ISNULL(RenglonID,0),
               ISNULL(RenglonTipo,'N'),
               ISNULL(Almacen,''),
               LTRIM(RTRIM(ISNULL(Articulo,''))),
               LTRIM(RTRIM(ISNULL(Codigo,''))),
               LTRIM(RTRIM(ISNULL(SubCuenta,''))),
               ISNULL(Cantidad,0.0),
               ISNULL(Cantidad,0.0), --ISNULL(CantidadPendiente,0.0),
               ISNULL(Unidad,''),
               ISNULL(Factor,0.0)
          FROM InvD
         WHERE ID = @SalidaTraspasoID

        UPDATE @Tabla
           SET Movimiento = b.Mov,
               MovimientoID = b.MovID
          FROM @tabla a
         INNER JOIN Inv b ON (a.ID = b.ID)

        UPDATE @Tabla
           SET Descripcion1 = ISNULL(b.Descripcion1, ''),
               Descripcion2 = ISNULL(b.Descripcion2, ''),
               NombreCorto  = ISNULL(b.NombreCorto, ''),
               Tipo         = ISNULL(b.Tipo, ''),
               TipoOpcion   = ISNULL(b.TipoOpcion, '')
          FROM @Tabla a
         INNER JOIN Art b ON (a.Articulo = b.Articulo)

        UPDATE @Tabla SET CantidadMaxima = CantidadPendiente
        UPDATE @Tabla SET DescripcionSubCuenta = dbo.fnDescribirOpciones(Subcuenta)

        DECLARE SalidaTraspasoDetalleJuego_cursor CURSOR FOR SELECT IDR, RenglonID, Articulo FROM @Tabla WHERE RenglonTipo = 'J'
        OPEN SalidaTraspasoDetalleJuego_cursor
        FETCH NEXT FROM SalidaTraspasoDetalleJuego_cursor INTO @IDR, @RenglonID, @Articulo
        WHILE @@FETCH_STATUS = 0
          BEGIN

            DECLARE Juego_cursor CURSOR FOR SELECT Articulo FROM @Tabla WHERE RenglonID = @RenglonID AND RenglonTipo = 'C'
            OPEN Juego_cursor
            FETCH NEXT FROM Juego_cursor INTO @Opcion
            WHILE @@FETCH_STATUS = 0
              BEGIN
                SELECT TOP 1 @Juego = Juego, @SubCuentaOpcion = SubCuenta
                  FROM ArtJuegoD
                 WHERE Articulo = @Articulo
                   AND Opcion = @Opcion

                UPDATE @Tabla
                   SET Juego = @Juego,
                       Opcion = @Opcion,
                       SubCuentaOpcion = @SubCuentaOpcion
                 WHERE RenglonID = @RenglonID
                   AND Articulo = @Opcion

                SELECT @DescripcionJuego = Descripcion,
                       @CantidadJuego = Cantidad
                  FROM ArtJuego
                 WHERE articulo = @Articulo
                   AND Juego = @Juego

                 UPDATE @Tabla
                    SET DescripcionJuego = @DescripcionJuego,
                        CantidadJuego = @CantidadJuego
                  WHERE RenglonID = @RenglonID
                    AND Articulo = @Opcion

                UPDATE @Tabla SET DescripcionSubCuentaOpcion = dbo.fnDescribirOpciones(SubCuentaOpcion)
                 WHERE RenglonID = @RenglonID
                   AND RenglonTipo = 'C'
                   AND LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) <> ''

              -->
              FETCH NEXT FROM Juego_cursor INTO @Opcion
            END
            CLOSE Juego_cursor
            DEALLOCATE Juego_cursor
            -->
            FETCH NEXT FROM SalidaTraspasoDetalleJuego_cursor INTO @IDR, @RenglonID, @Articulo
          END

        CLOSE SalidaTraspasoDetalleJuego_cursor
        DEALLOCATE SalidaTraspasoDetalleJuego_cursor

        SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Movimiento,'')))                 AS Movimiento,
                                LTRIM(RTRIM(ISNULL(MovimientoID,'')))               AS MovimientoID,
                                CAST(ISNULL(Renglon,0) AS varchar)                  AS Renglon,
                                CAST(ISNULL(RenglonSub,0) AS varchar)               AS RenglonSub,
                                CAST(ISNULL(RenglonID,0) AS varchar)                AS RenglonID,
                                LTRIM(RTRIM(ISNULL(RenglonTipo,'N')))               AS RenglonTipo,
                                LTRIM(RTRIM(ISNULL(Almacen,'')))                    AS Almacen,
                                LTRIM(RTRIM(ISNULL(Articulo,'')))                   AS Articulo,
                                LTRIM(RTRIM(ISNULL(Codigo,'')))                     AS Codigo,
                                LTRIM(RTRIM(ISNULL(SubCuenta,'')))                  AS SubCuenta,
                                LTRIM(RTRIM(ISNULL(Descripcion1,'')))               AS Descripcion1,
                                LTRIM(RTRIM(ISNULL(Descripcion2,'')))               AS Descripcion2,
                                LTRIM(RTRIM(ISNULL(NombreCorto,'')))                AS NombreCorto,
                                LTRIM(RTRIM(ISNULL(DescripcionSubCuenta,'')))       AS DescripcionSubCuenta,
                                CAST(ISNULL(Cantidad,0) AS varchar)                 AS Cantidad,
                                CAST(ISNULL(CantidadPendiente,0) AS varchar)        AS CantidadPendiente,
                                CAST(ISNULL(CantidadA,0) AS varchar)                AS CantidadA,
                                CAST(ISNULL(CantidadMaxima,0) AS varchar)           AS CantidadMaxima,
                                LTRIM(RTRIM(ISNULL(Unidad,'')))                     AS Unidad,
                                CAST(ISNULL(Factor,1) AS varchar)                   AS Factor,
                                CAST(ISNULL(CantidadInventario,0) AS varchar)       AS CantidadInventario,
                                LTRIM(RTRIM(ISNULL(Tipo,'')))                       AS Tipo,
                                LTRIM(RTRIM(ISNULL(TipoOpcion,'')))                 AS TipoOpcion,
                                LTRIM(RTRIM(ISNULL(Juego,'')))                      AS Juego,
                                LTRIM(RTRIM(ISNULL(DescripcionJuego,'')))           AS DescripcionJuego,
                                CAST(ISNULL(CantidadJuego,0) AS varchar)            AS CantidadJuego,
                                LTRIM(RTRIM(ISNULL(Opcion,'')))                     AS Opcion,
                                LTRIM(RTRIM(ISNULL(SubCuentaOpcion,'')))            AS SubCuentaOpcion,
                                LTRIM(RTRIM(ISNULL(DescripcionSubCuentaOpcion,''))) AS DescripcionSubCuentaOpcion
                            FROM @Tabla AS Tabla
                           ORDER BY IDR
                          FOR XML AUTO)

      END
    ELSE
      BEGIN
        SET @Ok = 10160
      END

  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/************** spIntelisisDistribucionAfectarSalidaTraspaso ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisDistribucionAfectarSalidaTraspaso') AND type = 'P') DROP PROCEDURE dbo.spIntelisisDistribucionAfectarSalidaTraspaso
GO
CREATE PROCEDURE spIntelisisDistribucionAfectarSalidaTraspaso
    @ID                      int,
    @iSolicitud              int,
    @Version                 float,
    @Resultado               varchar(max) = NULL OUTPUT,
    @Ok                      int = NULL OUTPUT,
    @OkRef                   varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa                 varchar(5),
    @Sucursal                int,
    @Usuario                 varchar(10),
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @xml                     xml,
    @Texto                   xml

  DECLARE
    @sModuloID               varchar(100),
    @ModuloID                int,
    @MovimientoGenerar       varchar(20),
    @IDGenerar               int,
    @Estacion                int,
    @FechaRegistro           datetime,
    @Mensaje                 varchar(255)

  DECLARE @TablaInvD table(
    IDX                      int identity (1,1),
    ID                       int,
    Renglon                  float,
    RenglonSub               int,
    RenglonID                int,
    Articulo                 varchar(20),
    SubCuenta                varchar(50),
    CantidadA                float
  )

  DECLARE @TablaSerieLoteMov table(
    IDX                      int identity (1,1),
    Empresa                  varchar(5),
    Modulo                   varchar(5),
    ID                       int,
    RenglonID                int,
    Articulo                 varchar(20),
    SubCuenta                varchar(50),
    SerieLote                varchar(50),
    Cantidad                 float,
    Sucursal                 int
  )

  DECLARE @Tabla Table(
    Mensaje                  varchar(255)
 )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Sucursal'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @sModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'ModuloID'

    SELECT @MovimientoGenerar = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovimientoGenerar'

    SET @Empresa           = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Sucursal          = LTRIM(RTRIM(ISNULL(@Sucursal,'')))
    SET @Usuario           = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @ModuloID          = CAST(ISNULL(@sModuloID,'0') AS int)
    SET @MovimientoGenerar = LTRIM(RTRIM(ISNULL(@MovimientoGenerar,'')))

    SET @IDGenerar         = 0
    SET @Mensaje           = ''
    SET @Estacion          = @@SPID
    SET @FechaRegistro     = dbo.fnFechaSinHora(GETDATE())

    INSERT INTO @TablaInvD (ID, Renglon, RenglonSub, RenglonID, Articulo, SubCuenta, CantidadA)
    SELECT ID, Renglon, RenglonSub, RenglonID, Articulo, SubCuenta, CantidadA
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Tabla')
      WITH (ID          int           '@ID',
            Renglon     float         '@Renglon',
            RenglonSub  int           '@RenglonSub',
            RenglonID   int           '@RenglonID',
            Articulo    varchar (20)  '@Articulo',
            SubCuenta   varchar (50)  '@SubCuenta',
            CantidadA   float         '@CantidadA');

    INSERT INTO @TablaSerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal)
    SELECT Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Tabla2')
      WITH (Empresa     varchar (5)   '@Empresa',
            Modulo      varchar (5)   '@Modulo',
            ID          int           '@ID',
            RenglonID   int           '@RenglonID',
            Articulo    varchar (20)  '@Articulo',
            SubCuenta   varchar (50)  '@SubCuenta',
            SerieLote   varchar (50)  '@SerieLote',
            Cantidad    float         '@Cantidad',
            Sucursal    int           '@Sucursal');

    UPDATE InvD
       SET CantidadA = ISNULL(b.CantidadA,0)
      FROM InvD a
      JOIN @TablaInvD b
        ON (a.ID        = b.ID
       AND a.Renglon    = b.Renglon
       AND a.RenglonSub = b.RenglonSub
       AND a.RenglonID  = b.RenglonID)

    DELETE SerieLoteMov WHERE Empresa = @Empresa AND ID = @ModuloID

    INSERT INTO SerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal)
    SELECT Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Sucursal
      FROM @TablaSerieLoteMov

    EXEC @IDGenerar = spAfectar 'INV', @ModuloID, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF ISNULL(@OK,0) BETWEEN 80030 AND 81000
      BEGIN
        SELECT @Mensaje = RTRIM(LTRIM(ISNULL(Descripcion,''))) + ' '  + RTRIM(LTRIM(ISNULL(@OkRef,''))) FROM MensajeLista WHERE Mensaje = @Ok

        INSERT INTO @Tabla (Mensaje) VALUES (@Mensaje)

        SET @Ok = NULL
        SET @OkRef = NULL
      END
    ELSE
      BEGIN
        SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
        INSERT INTO @Tabla (Mensaje) VALUES(@Mensaje)
      END

  END TRY

  BEGIN CATCH
    SELECT @Mensaje = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
    INSERT INTO @Tabla (Mensaje) VALUES (@Mensaje)

    SET @Ok = 1
    SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  END CATCH

  SELECT @Texto = (SELECT TOP 5 LTRIM(RTRIM(ISNULL(Mensaje,''))) AS Mensaje FROM @Tabla AS Tabla FOR XML AUTO)

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************** spIntelisisServiceProcesarDistribucion ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spIntelisisServiceProcesarDistribucion') AND type = 'P') DROP PROCEDURE dbo.spIntelisisServiceProcesarDistribucion
GO
CREATE PROCEDURE spIntelisisServiceProcesarDistribucion
  @Sistema         varchar(100),
  @ID              int,
  @iSolicitud      int,
  @Solicitud       varchar(max),
  @Version         float,
  @Referencia      varchar(100),
  @SubReferencia   varchar(100),
  @Resultado       varchar(max) OUTPUT,
  @Ok              int          OUTPUT,
  @OkRef           varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  IF @Referencia = 'Intelisis.Distribucion.Mensaje' EXEC spIntelisisDistribucionMensaje @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.Distribucion.Empresa' EXEC spIntelisisDistribucionEmpresa @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.Distribucion.EmpresaCfg' EXEC spIntelisisDistribucionEmpresaCfg @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.Distribucion.Sucursal' EXEC spIntelisisDistribucionSucursal @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.Distribucion.InventarioFisicoLista' EXEC spIntelisisDistribucionInventarioFisicoLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.Distribucion.InventarioDetalle' EXEC spIntelisisDistribucionInventarioDetalle @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.Distribucion.InventarioEstatus' EXEC spIntelisisDistribucionInventarioEstatus @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.Distribucion.MovimientosInventarioLista' EXEC spIntelisisDistribucionMovimientosInventarioLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.Distribucion.AlmacenesLista' EXEC spIntelisisDistribucionAlmacenesLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.Distribucion.MonedasLista' EXEC spIntelisisDistribucionMonedasLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.Distribucion.GenerarInventario' EXEC spIntelisisDistribucionGenerarInventario @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.Distribucion.CbInfo' EXEC spIntelisisDistribucionCbInfo @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.ArticuloInfo' EXEC spIntelisisDistribucionArticuloInfo @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.GuardarInventario' EXEC spIntelisisDistribucionGuardarInventario @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.SerieLoteLista' EXEC spIntelisisDistribucionSerieLoteLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.GuardarSerieLoteMov' EXEC spIntelisisDistribucionGuardarSerieLoteMov @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.InfoSerieLote' EXEC spIntelisisDistribucionInfoSerieLote @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.MovimientosRecepcionLista' EXEC spIntelisisDistribucionMovimientosRecepcionLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.OrdenCompraLista' EXEC spIntelisisDistribucionOrdenCompraLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.OrdenCompraDetalle' EXEC spIntelisisDistribucionOrdenCompraDetalle @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.OrdenCompraCodigos' EXEC spIntelisisDistribucionOrdenCompraCodigos @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.AfectarOrdenCompra' EXEC spIntelisisDistribucionAfectarOrdenCompra @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.MovimientosSurtidoLista' EXEC spIntelisisDistribucionMovimientosSurtidoLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.TransitoLista' EXEC spIntelisisDistribucionTransitoLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.TransitoDetalle' EXEC spIntelisisDistribucionTransitoDetalle @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.InfoSerieLoteMov' EXEC spIntelisisDistribucionInfoSerieLoteMov @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.AfectarTransito' EXEC spIntelisisDistribucionAfectarTransito @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.OrdenSurtidoLista' EXEC spIntelisisDistribucionOrdenSurtidoLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.OrdenSurtidoDetalle' EXEC spIntelisisDistribucionOrdenSurtidoDetalle @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.MovimientosGenerar' EXEC spIntelisisDistribucionMovimientosGenerar @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.AfectarOrdenSurtido' EXEC spIntelisisDistribucionAfectarOrdenSurtido @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.SalidaTraspasoLista' EXEC spIntelisisDistribucionSalidaTraspasoLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.SalidaTraspasoDetalle' EXEC spIntelisisDistribucionSalidaTraspasoDetalle @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef ELSE
  IF @Referencia = 'Intelisis.Distribucion.AfectarSalidaTraspaso' EXEC spIntelisisDistribucionAfectarSalidaTraspaso @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
