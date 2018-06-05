SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
--REQ12615 WMS todo el archivo


IF EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 45060) DELETE MensajeLista WHERE Mensaje=45060
GO
insert MensajeLista (Mensaje,Descripcion) VALUES (45060,'La Persona No Corresponde a la Sucursal') --BUG16763
GO

IF EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 13075) DELETE MensajeLista WHERE Mensaje=13075
GO
INSERT MensajeLista (Mensaje, Descripcion, Tipo, IE)
VALUES (13075, 'La Posicion actual no tiene configurado un Articulo específico','ERROR',0)
GO

IF EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 13025) DELETE MensajeLista WHERE Mensaje=13025
GO
INSERT MensajeLista (Mensaje, Descripcion, Tipo, IE)
VALUES (13025, 'No se puede hacer picking en la posicion actual','ERROR',0)
GO
--BUG5797
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 71027 )
  insert MensajeLista (Mensaje,Descripcion)      VALUES (71027,'El Usuario no tiene permiso para modificar La Posición Destino')
GO
--BUG5796
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 13039 )
  insert MensajeLista (Mensaje,Descripcion)      VALUES (13039,'No se puede Modificar el Anden de Recibo.')
GO

/**************** spProcesarTMASurtidoTransito2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProcesarTMASurtidoTransito2') and type = 'P') drop procedure dbo.spProcesarTMASurtidoTransito2
GO
CREATE PROCEDURE spProcesarTMASurtidoTransito2
    @Estacion                int,
    @Empresa                 char(5),
    @FechaEmision            datetime,
    @Usuario                 char(10),
    @CteCNO                  char(10) = NULL,
    @EnSilencio              bit = 0,
    @Ok                      int = NULL OUTPUT,
    @OkRef                   varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @NotaID                  int,
    @Mov                     varchar(20),
    @Estatus                 varchar(20),
    @Agente                  varchar(10),
    @TarimaSurtido           varchar(20),
    @Sucursal                int,
    @SurtidoID               int,
    @Renglon                 float,
    @Almacen                 char(10),
    @Posicion                char(10),
    @PosicionDestino         char(10),
    @Cantidad                float,
    @Aplica                  varchar(20),
    @AplicaID                varchar(20),
    @AplicaRenglon           float,
    @Zona                    varchar(50),
    @Tarima                  varchar(20),
    @CuantasNotas            int,
    @Cuantas                 int,
    @IDAplica                int,
    @MovDestino              varchar(20),
    @MovDestinoID            varchar(20),
    @Origen                  varchar(20),
    @OrigenID                varchar(20),
    @IDOrigen                int,
    @Montacarga              varchar(10),
    @IdO                     int,
    @IdMovO                  int,
    @OrigenO                 varchar(20),
    @OrigenIDO               varchar(20),
    @OrigenMov               varchar(20),
    @OrigenIDMov             varchar(20),
    @Modulo                  varchar(5),
    @Articulo                varchar(20),
    @SubCuenta               varchar(50),
    @NombreTrans             varchar(32)

  SET @CuantasNotas = 0
  SET @NombreTrans = 'spProcesarTMASurtidoTransito2' + CAST(@@SPID AS varchar)

  SELECT @Cuantas = COUNT(*) FROM ListaID WHERE Estacion = @Estacion

  IF @Cuantas > 0
    BEGIN
      BEGIN TRANSACTION @NombreTrans

      SELECT TOP 1 @Mov = Mov, @Estatus = 'SINAFECTAR'
        FROM MovTipo
       WHERE Clave = 'TMA.SUR'
         AND Modulo = 'TMA'

      CREATE TABLE #Surtido (ID int NULL, FechaEmision datetime NULL)

      DECLARE crEncabezado CURSOR LOCAL FOR
      SELECT DISTINCT t.Agente, t.TarimaSurtido, t.Sucursal, t.Almacen, t.Mov, t.MovID, t.Montacarga, t.Origen, OrigenID, t.ID, t.OrigenTipo
        FROM TMA t
        JOIN ListaID l ON (t.ID = l.ID)
       WHERE l.Estacion = @Estacion

      OPEN crEncabezado
      FETCH NEXT FROM crEncabezado INTO @Agente, @TarimaSurtido, @Sucursal, @Almacen, @Origen, @OrigenID, @Montacarga, @OrigenO, @OrigenIDO, @IDO, @Modulo
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
          INSERT TMA (Empresa,   Usuario,  Mov,   FechaEmision,  Estatus,  Sucursal,  Almacen,  Agente, Origen, OrigenID, Prioridad, TarimaSurtido, Montacarga)
          VALUES     (@Empresa, @Usuario, @Mov, @FechaEmision, @Estatus, @Sucursal, @Almacen, @Agente, @Origen, @OrigenID, 'Normal', @TarimaSurtido, @Montacarga)

          SELECT @SurtidoID = @@IDENTITY
          SELECT @Renglon = 0

          EXEC spMovCopiarSerielote @Sucursal, @Modulo, @IDO, @SurtidoID

          DECLARE crDetalle CURSOR LOCAL FOR
          SELECT d.Almacen, d.Posicion, d.PosicionDestino, d.CantidadPicking, t.Mov, t.MovID, d.Renglon, d.Zona, d.Tarima, o.ID, d.Articulo, d.SubCuenta --TASK2429PGC
            FROM TMA t
            JOIN TMAD d
              ON t.ID = d.ID
            JOIN TMA o ON o.Mov = t.Origen
             AND o.MovID = t.OrigenID
             AND o.Empresa = t.Empresa
            JOIN ListaID l
              ON l.ID = t.ID AND Estacion = @Estacion
           WHERE t.Agente = @Agente
             AND t.TarimaSurtido = @TarimaSurtido
             AND t.Sucursal = @Sucursal
             AND t.Almacen = @Almacen

          OPEN crDetalle
          FETCH NEXT FROM crDetalle INTO @Almacen, @Posicion, @PosicionDestino, @Cantidad, @Aplica, @AplicaID, @AplicaRenglon, @Zona, @Tarima, @IDOrigen, @Articulo, @SubCuenta --TASK2429PGC
          WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
            BEGIN
              IF @@FETCH_STATUS <> -2
              BEGIN
                SELECT @Renglon = @Renglon + 2048
                INSERT TMAD (ID,          Sucursal,  Renglon, Tarima,          Almacen,  Posicion,   PosicionDestino, CantidadPicking,  Aplica,  AplicaID,  AplicaRenglon,  Zona, TarimaPCK, Prioridad, EstaPendiente, Articulo, SubCuenta) --TASK2429PGC
                SELECT       @SurtidoID, @Sucursal, @Renglon, @TarimaSurtido, @Almacen, @Posicion,  @PosicionDestino, @Cantidad,       @Aplica, @AplicaID, @AplicaRenglon, @Zona, @Tarima, 'Normal', 1, @Articulo, @SubCuenta --TASK2429PGC

                UPDATE TMAD SET CantidadA  = 0, CantidadPendiente = ISNULL(CantidadPendiente, CantidadPicking) - @Cantidad WHERE ID = @IDOrigen AND Tarima = CASE WHEN CHARINDEX('-', @Tarima, 1) >0 THEN SUBSTRING(@Tarima, 1, CHARINDEX('-', @Tarima, 1)-1) ELSE @Tarima END

              END
              FETCH NEXT FROM crDetalle INTO @Almacen, @Posicion, @PosicionDestino, @Cantidad, @Aplica, @AplicaID, @AplicaRenglon, @Zona, @Tarima, @IDOrigen, @Articulo, @SubCuenta --TASK2429PGC
            END
          CLOSE crDetalle
          DEALLOCATE crDetalle

          INSERT VentaOrigen (ID, OrigenID, Sucursal, SucursalOrigen)
          SELECT @SurtidoID, v.ID, @Sucursal, @Sucursal
            FROM Venta v, ListaID l
           WHERE l.Estacion = @Estacion AND v.ID = l.ID

          INSERT #Surtido (ID) VALUES (@SurtidoID)
          SELECT @CuantasNotas = @CuantasNotas + 1

           FETCH NEXT FROM crEncabezado INTO @Agente, @TarimaSurtido, @Sucursal, @Almacen, @Origen, @OrigenID, @Montacarga, @OrigenO, @OrigenIDO, @IdO, @Modulo
        END

        CLOSE crEncabezado
        DEALLOCATE crEncabezado

        DECLARE crSurtido CURSOR LOCAL FOR SELECT ID FROM #Surtido
        OPEN crSurtido
        FETCH NEXT FROM crSurtido INTO @SurtidoID
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
          BEGIN

            EXEC spAfectar 'TMA', @SurtidoID, 'Afectar', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

            IF @Ok IN (80030, 80060) SELECT @Ok = NULL, @OkRef = NULL

            IF @Ok IS NULL
            BEGIN
              DECLARE crAplica CURSOR LOCAL FOR
              SELECT DISTINCT d.Aplica, d.AplicaID, t.ID
                FROM TMAD d
                JOIN TMA t ON d.Aplica = t.Mov AND d.AplicaID = t.MovID AND t.Empresa = @Empresa
               WHERE d.ID = @SurtidoID

              OPEN crAplica
              FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @IDAplica
              WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
                BEGIN
                  UPDATE TMA SET Estatus = 'CONCLUIDO' WHERE Mov = @Aplica AND MovID = @AplicaID AND Empresa = @Empresa AND Estatus = 'PROCESAR'
                  SELECT @MovDestino = Mov, @MovDestinoID = MovID FROM TMA WHERE ID = @SurtidoID

                  EXEC spMovFlujo @Sucursal, Afectar, @Empresa, 'TMA', @IDAplica, @Aplica, @AplicaID, 'TMA', @SurtidoID, @MovDestino, @MovDestinoID, @Ok OUTPUT

                  FETCH NEXT FROM crAplica INTO @Aplica, @AplicaID, @IDAplica
                END
              CLOSE crAplica
              DEALLOCATE crAplica

              FETCH NEXT FROM crSurtido INTO @SurtidoID
            END
          END
        CLOSE crSurtido
        DEALLOCATE crSurtido
    END
  ELSE
    BEGIN
      SET @OK = 10160
    END

  IF @Ok IS NULL
    BEGIN
      IF EXISTS (SELECT [name] FROM sys.dm_tran_active_transactions WHERE name = @NombreTrans) COMMIT TRANSACTION @NombreTrans
      IF @EnSilencio = 0
        BEGIN
          SELECT @OkRef = RTRIM(Convert(char, @Cuantas))+' Surtidos(s) Transito procesados.'
          IF @SurtidoID IS NOT NULL
            BEGIN
              IF @CuantasNotas = 1
                SELECT @OkRef = LTRIM(RTRIM(ISNULL(@OkRef,''))) + ' Se generó un ' + RTRIM(@Mov)
              ELSE
                SELECT @OkRef = LTRIM(RTRIM(ISNULL(@OkRef,''))) + ' Se generaron ' + CONVERT(varchar,@CuantasNotas) + ' ' + LTRIM(RTRIM(@Mov)) + '(s).'
            END
        END
    END
  ELSE
    BEGIN
      IF EXISTS (SELECT [name] FROM sys.dm_tran_active_transactions WHERE name = @NombreTrans) ROLLBACK TRANSACTION @NombreTrans
      IF @EnSilencio = 0
       BEGIN
        SELECT @Okref = Descripcion + ' ' + LTRIM(RTRIM(ISNULL(@OkRef,'')))
          FROM MensajeLista
         WHERE Mensaje = @Ok
       END
    END

   IF LTRIM(RTRIM(ISNULL(@Okref,''))) <> '' SET @Okref = REPLACE(@Okref,'<BR>','.')

END
GO
/************** spReconstruirSerieLoteMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReconstruirSerieLoteMov') AND type = 'P') drop procedure dbo.spReconstruirSerieLoteMov
GO
CREATE PROCEDURE spReconstruirSerieLoteMov
    @Empresa                      char(5),
    @Modulo                       varchar(5),
    @ModuloID                     int,
    @Ok                           int = NULL OUTPUT,
    @OkRef                        varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Articulo                     varchar(20),
    @SubCuenta                    varchar(50),
    @RenglonID                    int,
    @SerieLote                    varchar(50),
    @Cantidad                     float,
    @CantidadD                    float,
    @TotalRenglon                float,
    @Procesado                    bit,
    @idx                          int,
    @k                            int

  SET @Empresa    = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Modulo     = LTRIM(RTRIM(ISNULL(@Modulo,'')))
  SET @ModuloID   = LTRIM(RTRIM(ISNULL(@ModuloID,'')))
  SET @Procesado  = 0
  SET @RenglonID  = 0

  DECLARE @TablaD table (
    IDX                         int IDENTITY (1,1),
    Renglon                     float,
    RenglonSub                  int,
    RenglonID                   int,
    RenglonTipo                 char(1),
    Cantidad                    float,
    Articulo                    varchar(20),
    SubCuenta                   varchar(50)
  )

  DECLARE @SerieLoteMov Table(
    IDX                         int IDENTITY (1,1),
    Empresa                     varchar(5),
    Modulo                      varchar(5),
    ID                          int,
    RenglonID                   int,
    RenglonID2                  int,
    Articulo                    varchar(20),
    SubCuenta                   varchar(50),
    SerieLote                   varchar(50),
    Cantidad                    float,
    CantidadAlterna             float,
    Propiedades                 varchar(20),
    Ubicacion                   int,
    Cliente                     varchar(10),
    Localizacion                varchar(10),
    Sucursal                    int,
    ArtCostoInv                 money,
    Tarima                      varchar(20),
    AsignacionUbicacion         bit,
    Procesado                   bit
  )

  BEGIN TRY
    INSERT INTO @TablaD(Renglon,RenglonSub,RenglonID,RenglonTipo,Cantidad,Articulo,SubCuenta)
    SELECT Renglon,
           RenglonSub,
           RenglonID,
           RenglonTipo,
           Cantidad,
           LTRIM(RTRIM(ISNULL(Articulo,''))),
           LTRIM(RTRIM(ISNULL(SubCuenta,'')))
      FROM CompraD
     WHERE ID = @ModuloID
       AND RenglonTipo IN ('L','S')

    INSERT INTO @SerieLoteMov (Empresa,Modulo,ID,RenglonID,Articulo,SubCuenta,SerieLote,Cantidad,CantidadAlterna,Propiedades,Ubicacion,Cliente,Localizacion,Sucursal,ArtCostoInv,Tarima,AsignacionUbicacion)
    SELECT Empresa,
           Modulo,
           ID,
           RenglonID,
           LTRIM(RTRIM(ISNULL(Articulo,''))),
           LTRIM(RTRIM(ISNULL(SubCuenta,''))),
           LTRIM(RTRIM(ISNULL(SerieLote,''))),
           ISNULL(Cantidad,0),
           CantidadAlterna,
           Propiedades,
           Ubicacion,
           Cliente,
           Localizacion,
           Sucursal,
           ArtCostoInv,
           Tarima,
           AsignacionUbicacion
      FROM SerieLoteMov
     WHERE Empresa = @Empresa
       AND Modulo = @Modulo
       AND ID = @ModuloID

    SELECT @k = MAX(IDX) FROM @SerieLoteMov
    SET @k = ISNULL(@k,0)
    SET @idx = 0
    WHILE @idx < @k
      BEGIN
        SET @idx = @idx + 1  -->

        SELECT @RenglonID = RenglonID, @SerieLote = SerieLote, @Articulo = Articulo, @SubCuenta = SubCuenta, @Procesado = ISNULL(Procesado,0)
          FROM @SerieLoteMov
         WHERE IDX = @idx

        IF @Procesado = 0
          BEGIN
            UPDATE @SerieLoteMov
               SET RenglonID2 = @RenglonID,
                   Procesado = 1
             WHERE Articulo = @Articulo
               AND SubCuenta = @SubCuenta

              IF (SELECT COUNT(SerieLote) FROM @SerieLoteMov WHERE Articulo = @Articulo  AND SubCuenta = @SubCuenta AND SerieLote = @SerieLote) > 1
                BEGIN
                  SELECT @Cantidad = SUM(Cantidad) FROM @SerieLoteMov WHERE Articulo = @Articulo  AND SubCuenta = @SubCuenta AND SerieLote = @SerieLote
                  UPDATE @SerieLoteMov SET Cantidad = @Cantidad WHERE IDX = @idx

                  UPDATE @SerieLoteMov SET Cantidad = 0, Procesado = 1
                   WHERE IDX > @idx
                     AND RenglonID2 = @RenglonID
                     AND Articulo = @Articulo
                     AND SubCuenta = @SubCuenta
                     AND SerieLote = @SerieLote
                END
          END
      END

    SELECT @k = MAX(IDX) FROM @TablaD
    SET @k = ISNULL(@k,0)
    SET @Ok = NULL
    SET @idx = 0
    WHILE @idx < @k AND @Ok IS NULL
      BEGIN
        SET @idx = @idx + 1-->

        SELECT @RenglonID = RenglonID,
               @CantidadD = Cantidad
          FROM @TablaD WHERE IDX = @idx

        SELECT @TotalRenglon = SUM(Cantidad)
          FROM @SerieLoteMov
         WHERE RenglonID2 = @RenglonID

        IF @TotalRenglon <> @CantidadD SET @OK = 20330
      END

    DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ModuloID

    INSERT INTO SerieLoteMov(Empresa,Modulo,ID,RenglonID,Articulo,SubCuenta,SerieLote,Cantidad,CantidadAlterna,Propiedades,Ubicacion,Cliente,Localizacion,Sucursal,ArtCostoInv,Tarima,AsignacionUbicacion)
    SELECT Empresa,Modulo,ID,RenglonID2,Articulo,SubCuenta,SerieLote,Cantidad,CantidadAlterna,Propiedades,Ubicacion,Cliente,Localizacion,Sucursal,ArtCostoInv,Tarima,AsignacionUbicacion
      FROM @SerieLoteMov
     WHERE Procesado = 1
       AND Cantidad > 0
     ORDER BY RenglonID2, SerieLote

  END TRY

  BEGIN CATCH
    SET @OK = 1
    SET @OkRef = LEFT(LTRIM(RTRIM(ERROR_MESSAGE())),255)
  END CATCH

END
GO
--UserStory4436
/**************** spIntelisisWMSSolicitudEmpresa ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSSolicitudEmpresa')  AND type = 'P') drop procedure dbo.spIntelisisWMSSolicitudEmpresa
GO
CREATE PROCEDURE spIntelisisWMSSolicitudEmpresa
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

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  IF NOT EXISTS (SELECT * FROM UsuarioD WHERE Usuario = @Usuario)
    BEGIN
      SELECT @Texto = (SELECT Empresa FROM Empresa WHERE Estatus = 'ALTA' -- BUG6093
                       FOR XML AUTO)
    END

  IF EXISTS (SELECT * FROM UsuarioD WHERE Usuario = @Usuario)
     BEGIN
       SELECT @Texto = (SELECT u.Empresa
                          FROM UsuarioD u
                          JOIN Empresa e ON (u.Empresa = e.Empresa)
                         WHERE u.Usuario = @Usuario
                           AND e.Estatus = 'ALTA' -- BUG6093
                           FOR XML AUTO)
     END

  IF @@ERROR <> 0 SET @Ok = 1
    BEGIN
      SELECT @ReferenciaIS = Referencia
        FROM IntelisisService
       WHERE ID = @ID
      IF @@ERROR <> 0 SET @Ok = 1

      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    END
END
GO

--UserStory4436
/**************** spIntelisisWMSSolicitudSucursal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSSolicitudSucursal')           AND type = 'P') drop procedure dbo.spIntelisisWMSSolicitudSucursal
GO             
CREATE PROCEDURE spIntelisisWMSSolicitudSucursal
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
  		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@Usuario			varchar(20),
		@UsuarioSucursal    bit

  DECLARE @Sucursal TABLE(Sucursal    int,
                    Nombre      varchar(100))

 SELECT  @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'
 
 SELECT @UsuarioSucursal = AccesarOtrasSucursalesEnLinea FROM Usuario WHERE Usuario = @Usuario

 IF @UsuarioSucursal = 1
 BEGIN
   INSERT @Sucursal(Sucursal,Nombre)
   SELECT Sucursal, Nombre
     FROM Sucursal
    WHERE Estatus = 'ALTA' 

	
 END				   	
 IF  @UsuarioSucursal = 0
 BEGIN
   --EWQ. Tuning2
   IF NOT EXISTS(SELECT Sucursal FROM UsuarioSucursalAcceso WHERE Usuario=@Usuario)
    INSERT @Sucursal(Sucursal,Nombre)
    SELECT Sucursal, Nombre 
        FROM Sucursal
        WHERE Sucursal IN (SELECT Sucursal FROM Usuario WHERE Usuario=@Usuario) --BUGBUG23380
        AND Estatus = 'ALTA'
   ELSE
    INSERT @Sucursal(Sucursal,Nombre)
    SELECT Sucursal, Nombre 
      FROM Sucursal
     WHERE Sucursal IN (SELECT Sucursal FROM UsuarioSucursalAcceso WHERE Usuario=@Usuario) --BUGBUG23380
       AND Estatus = 'ALTA'
 END

  IF EXISTS(SELECT * FROM @Sucursal)
  BEGIN
   SELECT @Texto =(SELECT Sucursal, Nombre 
                     FROM @Sucursal
                   FOR XML AUTO)
  END

  IF NOT EXISTS(SELECT * FROM @Sucursal)
  BEGIN
   SELECT @Texto =(SELECT TOP 1 0 AS Sucursal,'' AS Nombre 
                   FROM Sucursal
                   FOR XML AUTO)
    SELECT @Ok = 10200, @OkRef = 'El Usuario no Cuenta con Sucursales Definidas'
  END


  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
   
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
   
  END
END
GO

--BUG24476
/**************** spIntelisisWMSValidaSucursal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSValidaSucursal')           AND type = 'P') drop procedure dbo.spIntelisisWMSValidaSucursal
GO             
CREATE PROCEDURE spIntelisisWMSValidaSucursal
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
  		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@Usuario			varchar(20),
		@UsuarioSucursal    bit,
		@NumeroSucursal     int,
		@Descripcion        varchar(100)

  SELECT  @NumeroSucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'NumeroSucursal'

 IF NOT EXISTS (SELECT Sucursal, Nombre FROM Sucursal WHERE Sucursal =@NumeroSucursal) SELECT @Ok=72060
 

 IF @Ok IS NULL
  SELECT @Texto =(SELECT Sucursal, Nombre FROM Sucursal WHERE Sucursal =@NumeroSucursal
                   FOR XML AUTO)   	
 
 IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1   
      IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok 
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion=' + CHAR(34) + ISNULL(@Descripcion,'') + CHAR(34) + '>' + CONVERT(varchar(max),isnull(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
   
  END
END
GO

--UserStory4436
/************** spIntelisisWMSValidarUsuario ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSValidarUsuario')           AND type = 'P') drop procedure dbo.spIntelisisWMSValidarUsuario
GO             
CREATE PROCEDURE spIntelisisWMSValidarUsuario
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
		
		@Empresa            varchar(5),
		@Sucursal2          varchar(100),
	    @Usuario			varchar(20),
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@UsuarioSucursal    bit,
		@Verifica           int,
		@Verifica2          int,
		@Sucursal			int,
		@MovilTarea			varchar(20),
		@Descripcion        varchar(100),
		@TipoAcomodador	    varchar(50) --BUG5663
		

  SELECT  @Empresa   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'
  SELECT  @Sucursal2= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'
  SELECT  @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SELECT @UsuarioSucursal = AccesarOtrasSucursalesEnLinea FROM Usuario WHERE Usuario = @Usuario
  SELECT @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @Sucursal2

  SELECT @TipoAcomodador = WMSTipoAcomodador FROM EmpresaCfg WHERE Empresa = @Empresa --BUG5663

  -- REQ 26135
  --IF NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND Estatus='ALTA')
  --IF NOT EXISTS(SELECT * FROM Agente a JOIN Usuario u ON u.DefAgente=a.Agente WHERE a.Agente = @Usuario AND a.Tipo = 'Agente' AND a.Estatus = 'ALTA' AND u.Estatus = 'ALTA')
  --IF NOT EXISTS(SELECT * FROM Agente a JOIN Usuario u ON u.DefAgente=a.Agente WHERE u.Usuario = @Usuario AND a.Tipo = 'Agente' AND a.Estatus = 'ALTA' AND u.Estatus = 'ALTA')
  IF NOT EXISTS(SELECT * FROM Agente a JOIN Usuario u ON u.DefAgente=a.Agente WHERE u.Usuario = @Usuario AND a.Tipo = @TipoAcomodador AND a.Estatus = 'ALTA' AND u.Estatus = 'ALTA') --BUG5663
  BEGIN
    SELECT @Ok = 71025, @OkRef = @Usuario
  END 
  
  IF @Ok IS NULL AND NOT EXISTS (SELECT * FROM UsuarioD WHERE Usuario = @Usuario AND Empresa = @Empresa ) SELECT @Ok = 45050, @OkRef = @Usuario --BUG16763
  
  --IF @UsuarioSucursal = 1
  --EWQ.Tuning2
  IF @UsuarioSucursal = 0 --BUG2330
  BEGIN
    IF @Ok IS NULL AND EXISTS (SELECT * FROM UsuarioSucursalAcceso WHERE Usuario = @Usuario) AND NOT EXISTS (SELECT * FROM UsuarioSucursalAcceso WHERE Usuario = @Usuario AND Sucursal =@Sucursal) SELECT @Ok = 45060, @OkRef = @Usuario --BUG16763
    --IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND Sucursal = @Sucursal)   SELECT @Ok = 45060, @OkRef = @Usuario --BUG16763 --UserStory4436
  END

  --IF @Verifica = 1 OR @Verifica2 =1 SELECT @Ok = 71020, @OkRef = @Usuario --BUG16763
  
  IF @Ok IS NULL
    SELECT @MovilTarea = WMSMovilTarea FROM EmpresaCfg WHERE Empresa = @Empresa
  
  IF @Ok IS NULL
    SELECT @Texto =((SELECT Usuario FROM Usuario FOR XML AUTO) + (SELECT WMSMovilTarea FROM EmpresaCfg WHERE Empresa = @Empresa FOR XML AUTO))

     
  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
    IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok --BUG16763
    
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.Validar.Usuario" SubReferencia="" Version="1.0"><Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--    <Parametro Campo="Empresa" Valor="DEMO"/> 
--    <Parametro Campo="Sucursal" Valor="Matriz"/>      
--    <Parametro Campo="Usuario" Valor="DEMO"/> 
--    </Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select @Resultado,@Ok,@OkRef
--GO

--UserStory4436
/**************** spISIntelisisTMAAfectarTMA_SADO ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisTMAAfectarTMA_SADO') and type = 'P') drop procedure dbo.spISIntelisisTMAAfectarTMA_SADO
GO
CREATE PROCEDURE spISIntelisisTMAAfectarTMA_SADO
    @ID                           int,
    @iSolicitud                   int,
    @Version                      float,
    @Resultado                    varchar(max) = NULL OUTPUT,
    @Ok                           int = NULL OUTPUT,
    @OkRef                        varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @IDGenerar                    int,
    @IDAcceso                     int,
    @MovTipo                      varchar(20),
    @ReferenciaIS                 varchar(100),
    @Usuario2                     varchar(10),
    @Estacion                     int,
    @SubReferencia                varchar(100),
    @Empresa                      varchar(5),
    @Mov                          varchar(20),
    @MovID                        varchar(20),
    @Sucursal                     int,
    @IdTma                        int,
    @Renglon                      float,
    @Tarima                       varchar(20),
    @SucursalNombre               varchar(100),
    @Posicion                     varchar(20),
    @PosicionDestino              varchar(20),
    @Usuario                      varchar(15),
    @Montacargas                  varchar(20),
    @Estatus                      varchar(20),
    @Agente                       varchar(20),
    @Modificar                    bit,
    @Procesado                    bit,
    @Mov2                         varchar(20),
    @Mov3                         varchar(20),
    @MovID2                       varchar(20),
    @PosicionDestinoGenerar       varchar(20),
    @DescripcionPosicionDestino   varchar(100),
    @PosicionDestinoOrigen        varchar(20),
    @RequiereMontacarga           int,
    @NombreTrans                  varchar(20)

  BEGIN TRY
    SET @Estacion = @@SPID
    SET @NombreTrans = 'AfectarTMA_SADO' + LTRIM(RTRIM(LEFT(CAST(@Estacion AS varchar), 5)))

    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovID'

    SELECT @IdTma = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'IdTma'

    SELECT @Renglon = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Renglon'

    SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Tarima'

    SELECT @Posicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Posicion'

    SELECT @PosicionDestino = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'PosicionDestino'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @SucursalNombre = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SucursalNombre'

    SELECT @Montacargas = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Montacarga'

    SET @Empresa         = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Mov             = LTRIM(RTRIM(ISNULL(@Mov,'')))
    SET @MovID           = LTRIM(RTRIM(ISNULL(@MovID,'')))
    SET @IdTma           = CAST(ISNULL(@IdTma,0) AS int)
    SET @Renglon         = CAST(ISNULL(@Renglon,0) AS float)
    SET @Tarima          = LTRIM(RTRIM(ISNULL(@Tarima,'')))
    SET @Posicion        = LTRIM(RTRIM(ISNULL(@Posicion,'')))
    SET @PosicionDestino = LTRIM(RTRIM(ISNULL(@PosicionDestino,'')))
    SET @Usuario         = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @SucursalNombre  = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))
    SET @Montacargas     = LTRIM(RTRIM(ISNULL(@Montacargas,'')))

    SELECT @MovTipo = Clave FROM MovTipo WHERE Mov = @Mov AND Modulo = 'TMA'
    SELECT @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @SucursalNombre
    SELECT @RequiereMontacarga = ISNULL(RequiereMontacarga,0) FROM MapeoMovMovil WHERE Modulo='TMA' AND Mov = @Mov
    SELECT @Modificar = ISNULL(ModificarPosicionSugeridaWMS,0), @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
    SELECT @Estatus = Estatus FROM TMA WHERE ID = @IdTma
    SELECT @Procesado = ISNULL(Procesado,0) FROM TMAD WHERE ID = @IdTma AND Renglon = @Renglon

    IF @MovTipo NOT IN('TMA.SADO','TMA.SRADO') SET @Ok = 35005
    IF @Ok IS NULL AND NOT (@Estatus = 'PENDIENTE') SET @OK = 10015
    IF @Ok IS NULL AND @Procesado = 1 SET @Ok = 60090
    IF @Ok IS NULL AND @Agente IS NULL SELECT @Ok = 20930
    IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID WHERE d.Tarima = @Tarima AND t.Empresa = @Empresa AND t.Mov = @Mov AND t.MovID = @MovID) SELECT @Ok = 13110
    IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM Montacarga WHERE Montacarga = @Montacargas) AND @RequiereMontacarga = 1 SELECT @Ok = 20948
    IF @Ok IS NULL
      BEGIN
        IF NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON (t.ID = d.ID) WHERE d.Posicion = @Posicion AND d.Tarima = @Tarima AND t.Empresa = @Empresa AND t.Mov = @Mov AND t.MovID = @MovID)
          BEGIN
            IF @Modificar = 0 SELECT @Ok = 71027
          END
      END

    IF @Ok IS NULL
      BEGIN
        BEGIN TRANSACTION @NombreTrans
        UPDATE TMAD SET CantidadA = 1 WHERE ID = @IdTma AND Renglon = @Renglon

        IF @MovTipo = 'TMA.SADO'
          BEGIN
            SELECT @Mov3 = TMAOrdenAcomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
            EXEC @IDGenerar = spAfectar 'TMA', @IdTma, 'GENERAR', 'Seleccion', @Mov3, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
            IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL, @OkRef = NULL

            IF @Ok IS NULL
              BEGIN
                UPDATE TMA SET Montacarga = @Montacargas, Agente = @Agente WHERE ID = @IDGenerar
                EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
                IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL, @OkRef = NULL
              END
          END

        IF @MovTipo = 'TMA.SRADO'
          BEGIN
            SELECT @Mov3 = TMAOrdenReacomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
            EXEC @IDGenerar = spAfectar 'TMA', @IdTma, 'GENERAR', 'Seleccion', @Mov3, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
            IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL, @OkRef = NULL

            IF @Ok IS NULL
              BEGIN
                UPDATE TMA SET Montacarga = @Montacargas, Agente = @Agente WHERE ID = @IDGenerar
                EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
                IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL, @OkRef = NULL
              END
          END

        IF @Ok IS NULL
          BEGIN
            SELECT @Mov2 = LTRIM(RTRIM(ISNULL(Mov,''))), @MovID2 = LTRIM(RTRIM(ISNULL(MovID,''))) FROM TMA WHERE ID = @IDGenerar
            SELECT @PosicionDestinoGenerar = LTRIM(RTRIM(ISNULL(PosicionDestino,''))) FROM TMAD WHERE ID = @IDGenerar
            SELECT @DescripcionPosicionDestino = LTRIM(RTRIM(ISNULL(Descripcion,''))) FROM AlmPos WHERE Posicion = @PosicionDestinoGenerar

            IF EXISTS (SELECT [name] FROM sys.dm_tran_active_transactions WHERE name = @NombreTrans) COMMIT TRANSACTION @NombreTrans
          END
        ELSE
          BEGIN
            IF EXISTS (SELECT [name] FROM sys.dm_tran_active_transactions WHERE name = @NombreTrans) ROLLBACK TRANSACTION @NombreTrans
            SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
          END

      END
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

 SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

 SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="TMA" ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) +'  Mov=' + CHAR(34) + ISNULL(@Mov2,'') + CHAR(34) +'  MovID=' + CHAR(34) + ISNULL(@MovID2,'') + CHAR(34)  +'  PosicionDestino=' + CHAR(34) + ISNULL(@PosicionDestinoGenerar,'') + CHAR(34) +'  DescripcionPosicionDestino=' + CHAR(34) + ISNULL(@DescripcionPosicionDestino,'') + CHAR(34) +  ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'
 SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO


--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.AfectarMov.TMA_SADO" SubReferencia="" Version="1.0"><Solicitud><TMA Empresa="DEMO " Mov="Solicitud Acomodo" MovID="16" Usuario="DEMO" Sucursal="Matriz" Montacarga="1" Tarima ="TM159" Posicion="A4" PosicionDestino="A1-4" /></Solicitud></Intelisis> '
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--SELECT convert(xml,@Resultado),@Ok,@OkRef

--GO


/**************** spISIntelisisTMAAfectarTMA_OADO****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisTMAAfectarTMA_OADO') and type = 'P') drop procedure dbo.spISIntelisisTMAAfectarTMA_OADO
GO             
CREATE PROCEDURE spISIntelisisTMAAfectarTMA_OADO
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
    @IDGenerar					int,
    @IDAcceso					int,	
    @MovTipo					varchar(20),
    @ReferenciaIS				varchar(100),
    @Usuario2					varchar(10),
    @Estacion					int,
    @SubReferencia				varchar(100),
    @Empresa   				    varchar(5),
    @Mov   					    varchar(20),
    @MovID   					varchar(20),
    @Sucursal                   int,
    @ID2                        int,
    @Tarima                     varchar(20),
    @Sucursal2                  varchar(100),
    @Posicion                   varchar(20),
    @PosicionDestino            varchar(20),
    @Usuario                    varchar(15),
    @Montacargas                varchar(20),
    @Estatus                    varchar(20),
    @Agente                     varchar(20),
    @Modificar                  bit,
    @Procesado                  bit,
    @Mov2  					    varchar(20),
    @Mov3  					    varchar(20),
    @MovID2   					varchar(20),
    @PosicionDGenerar           varchar(20),
    @Descripcion                varchar(100),
	@CantidadParcial            float, --17072014
    @ArticuloEsp			    varchar(20),
    @Factor                     FLOAT,
    @Unidad                     VARCHAR(20),
    @Almacen                    VARCHAR(20),
	@Disponible				    float, --BUG24139

	@PosicionDestinoOrigen      varchar(20), --BUG5797

	@RequiereMontacarga         int --BUG5899


 BEGIN TRANSACTION 
  --EWQ. Tuning
  --SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)  
  --SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  
   SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion
  

  
  IF @Ok IS NULL
  BEGIN  
     SELECT  @Empresa = NULLIF(Empresa,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Empresa    varchar(255))
     SELECT  @MovID = NULLIF(MovID,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(MovID    varchar(255))  
     SELECT  @Mov= NULLIF(Mov,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Mov    varchar(255)) 
     SELECT  @Tarima = NULLIF(Tarima,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Tarima   varchar(255))
     SELECT  @Posicion = NULLIF(Posicion,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Posicion   varchar(255))  
     SELECT  @PosicionDestino = NULLIF(PosicionDestino,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(PosicionDestino   varchar(255))  
     SELECT  @Usuario = NULLIF(Usuario,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Usuario   varchar(255))   
     SELECT  @Sucursal2 = NULLIF(Sucursal,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Sucursal   varchar(255))  
     SELECT  @Montacargas = NULLIF(Montacarga,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Montacarga   varchar(255))
     --17072014	
     SELECT  @CantidadParcial = ISNULL(CONVERT(float, CantidadParcial),0) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(CantidadParcial   varchar(255))	   
        
   END

  SELECT @Disponible = 0 --BUG24139
  
  SELECT @Agente = DefAgente, @Almacen=DefAlmacen, @Sucursal = Sucursal FROM Usuario WHERE Usuario = @Usuario

   SELECT @RequiereMontacarga=ISNULL(RequiereMontacarga,0) FROM MapeoMovMovil WHERE Modulo='TMA' AND Mov=@Mov --BUG5899

   SELECT @Modificar = ISNULL(ModificarPosicionSugeridaWMS,0) FROM Usuario WHERE Usuario = @Usuario --BUG5797

  SELECT @MovTipo = Clave FROM MovTipo WHERE Mov = @Mov AND Modulo = 'TMA'
  SELECT @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @Sucursal2
  IF @MovTipo NOT IN ('TMA.ORADO','TMA.OADO') SELECT @Ok = 35005, @OkRef = @Mov 
  IF @Ok IS NULL
  BEGIN 
    IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE  d.Tarima = @Tarima  AND t.Empresa = @Empresa AND t.Sucursal = @Sucursal AND t.Mov=@Mov AND t.MovID= @MovID) SELECT @Ok = 13110 --BUG5687
  --  IF NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE  d.Posicion = @Posicion AND t.Empresa = @Empresa AND t.Sucursal = @Sucursal AND t.Mov=@Mov AND t.MovID= @MovID AND d.Tarima = @Tarima ) SELECT @Ok = 13030
    --IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE  d.Tarima = @Tarima AND d.PosicionDestino = @PosicionDestino AND t.Empresa = @Empresa AND t.Mov=@Mov AND t.MovID= @MovID AND t.Sucursal = @Sucursal) SELECT @Ok = 13035 --BUG56857
	IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM Montacarga WHERE Montacarga = @Montacargas) AND @RequiereMontacarga=1 SELECT @Ok = 20948 --UserStory4436 --BUG5685 --BUG5899
	
  END

  --BUG5797
  IF @Ok IS NULL
  BEGIN
 --   SELECT @PosicionDestinoOrigen=d.PosicionDestino FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE  d.Tarima = @Tarima  AND t.Empresa = @Empresa AND t.Mov=@Mov AND t.MovID= @MovID
	--IF @PosicionDestinoOrigen<>@PosicionDestino
	IF NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE  d.Tarima = @Tarima AND d.PosicionDestino = @PosicionDestino AND t.Empresa = @Empresa AND t.Mov=@Mov AND t.MovID= @MovID AND t.Sucursal = @Sucursal)
	BEGIN
	  IF @Modificar=0 SELECT @Ok = 71027
	END
  END
  
  IF @Ok IS NULL 
  BEGIN  
  SELECT @ID2 = ID FROM TMA WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Mov = @Mov AND MovID = @MovID
  SELECT @Estatus = Estatus FROM TMA WHERE ID = @ID2
  
  SELECT @Procesado = ISNULL(Procesado, 0) FROM TMAD WHERE ID = @ID2 AND Tarima = @Tarima
  
  
  --SELECT @Modificar = ModificarPosicionSugeridaWMS FROM Usuario WHERE Usuario = @Usuario --BUG5797

  --15072014
  SET @ArticuloEsp=''
  SELECT @ArticuloEsp = ISNULL(b.Articulo,'') FROM Tarima a /*WITH(NOLOCK)*/
   INNER JOIN ArtDisponibleTarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima
   WHERE a.Almacen = @Almacen AND a.Estatus = 'ALTA' AND a.Posicion = @PosicionDestino


  IF @Ok IS NULL AND @ArticuloEsp='' AND @CantidadParcial>0 Select @Ok=13030

  IF @Ok IS NULL  
  IF NOT EXISTS(SELECT ISNULL(Posicion,'') FROM AlmPos WHERE Posicion=@PosicionDestino) SET @Ok=13030

    --EWQ. Tuning
    SELECT @Factor = dbo.fnArtUnidadFactor(@Empresa, @ArticuloEsp, UnidadTraspaso), 
           --@Minimo = MinimoTarima,
		   @Unidad = UnidadTraspaso
      FROM Art a
     WHERE a.Articulo = @ArticuloEsp

----  IF @Procesado= 0
----  BEGIN
    UPDATE TMAD 
       SET CantidadA = 1,
           PosicionDestino = @PosicionDestino --BUG6396
     WHERE Tarima = @Tarima  AND ID = @ID2     
----  END   

--  --17072014
--  IF @Ok IS NULL AND @CantidadParcial=0
--  BEGIN
--    UPDATE TMAD 
--       SET CantidadA=1
--     WHERE Tarima = @Tarima  AND ID = @ID2     
--  END     
  
  IF @Ok IS NULL AND @Estatus = 'Pendiente' AND @MovTipo = 'TMA.OADO'
  BEGIN 
    SELECT @Mov3 = TMAAcomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
    EXEC @IDGenerar =  spAfectar 'TMA', @ID2, 'GENERAR', 'Seleccion', @Mov3, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT 

    IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL
     
    SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
    IF @Agente IS NULL SELECT @Ok = 20930
    
    UPDATE TMA SET Montacarga = @Montacargas , Agente = @Agente
     WHERE ID = @IDGenerar
     
     IF @Ok IS NULL
     EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT ,@OkRef = @OkRef OUTPUT 
     IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL
     
  END
    
  IF @Ok IS NULL AND @Estatus = 'Pendiente' AND @MovTipo = 'TMA.ORADO'
  BEGIN
    SELECT @Mov3 = TMAReacomodo FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
    EXEC @IDGenerar =  spAfectar 'TMA', @ID2, 'GENERAR', 'Seleccion', @Mov3, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT 

        IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL
     
     
    SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
    IF @Agente IS NULL SELECT @Ok = 20930

	--17072014
	IF @Ok IS NULL AND @CantidadParcial>0
    BEGIN
      UPDATE TMAD 
         SET CantidadPicking=@CantidadParcial*@Factor, CantidadUnidad=@CantidadParcial
       WHERE Tarima = @Tarima  AND ID = @IDGenerar    
    END  
    
    UPDATE TMA SET Montacarga = @Montacargas , Agente = @Agente
    WHERE ID = @IDGenerar
  
    IF @Ok IS NULL
    EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT ,@OkRef = @OkRef OUTPUT 
    IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL

	--BUG24139	
	IF @Ok IS NULL AND @CantidadParcial>0
	BEGIN	  	
        SELECT @Disponible = ISNULL(b.Disponible,0) FROM Tarima a /*WITH(NOLOCK)*/ 
         INNER JOIN ArtDisponibleTarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima
         WHERE a.Almacen = @Almacen 
           AND a.Estatus = 'ALTA' 
           --AND a.Posicion = @Posicion 
           AND a.Tarima=@Tarima
	END
     
  END  

  IF @Ok IS NULL
  SELECT @ReferenciaIS = Referencia 
    FROM IntelisisService 
   WHERE ID = @ID 

  SELECT @Mov2='', @MovID2='', @PosicionDGenerar='', @Descripcion=''
  IF @Ok IS NULL   
  BEGIN      
    SELECT @Mov2 = isnull(Mov,'') , @MovID2 = isnull(MovID,'') FROM TMA WHERE ID = @IDGenerar  
    SELECT @PosicionDGenerar = isnull(PosicionDestino,'')  FROM TMAD WHERE ID = @IDGenerar
    SELECT @Descripcion = isnull(Descripcion,'') FROM AlmPos WHERE Posicion = @PosicionDGenerar
  END
  
 END
--SELECT @OK = 1
--SELECT * FROM TMA WHERE ID = @IDGenerar

    IF @@ERROR <> 0 SET @Ok = 1      
    IF @Ok IS NOT NULL SELECT @OkRef = REPLACE(Descripcion, '<BR>', '') FROM MensajeLista WHERE Mensaje = @Ok      
      
    --EWQ. Tuning  
    IF @Ok IS NULL   
    BEGIN  
      IF (SELECT Estatus FROM TMA WHERE ID = @IDGenerar) = 'SINAFECTAR'  
        SELECT @Ok = -1  
      ELSE  
        SELECT @OkRef = RTRIM(Mov)+' '+RTRIM(MovID) FROM TMA WHERE ID = @IDGenerar  		
    END
  
   --IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok 
   SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="TMA" ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) +'  Mov=' + CHAR(34) + ISNULL(@Mov2,'') + CHAR(34) +'  MovID=' + CHAR(34) + ISNULL(@MovID2,'') + CHAR(34)  +'  PosicionDestino=' + CHAR(34) + ISNULL(@PosicionDGenerar,'') + CHAR(34) +'  DescripcionPosicionDestino=' + CHAR(34) + ISNULL(@Descripcion,'') + CHAR(34) + '  Disponible=' + CHAR(34) + ISNULL(CONVERT(varchar,@Disponible),'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'
 
   IF @Ok IS NULL OR @Ok = -1
   BEGIN      
    COMMIT TRANSACTION
   END ELSE      
   BEGIN      
    ROLLBACK TRANSACTION       
   END     
END
GO

/************** spIntelisisMapeoMovMovilListado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisMapeoMovMovilListado') AND type = 'P') drop procedure dbo.spIntelisisMapeoMovMovilListado
GO
CREATE PROCEDURE spIntelisisMapeoMovMovilListado
    @ID            int,
    @iSolicitud    int,
    @Version       float,
    @Resultado     varchar(max) = NULL OUTPUT,
    @Ok            int = NULL OUTPUT,
    @OkRef         varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto              xml,
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @Clave              varchar(20),
    @Descripcion        varchar(100)

  SELECT @Clave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Clave'

  DECLARE @Tabla Table(
    Mov                      varchar(20),
    Modulo                   varchar(5),
    RequiereMontacarga       char(1),
    MovTransito              varchar(20),
    MovFinal                 varchar(20),
    ClaveAfectacion          varchar(20)
  )

  IF @Clave = 'TMA.SADO'
    INSERT INTO @Tabla(Mov, Modulo, RequiereMontacarga, MovTransito, Movfinal, ClaveAfectacion)
    SELECT ISNULL(mmm.Mov,''),
           ISNULL(mmm.Modulo,''),
           CAST(ISNULL(mmm.RequiereMontacarga,1) AS varchar),
           ISNULL(mmm.MovTransito,''),
           ISNULL(mmm.MovFinal,''),
           ISNULL(mt.Clave,'')
      FROM MapeoMovMovil mmm
      JOIN MovTipo mt ON (mmm.Mov = mt.Mov AND mt.Modulo = 'TMA' AND mt.SubClave IS NULL)
     WHERE mt.Clave IN (@Clave,'TMA.OADO')
    ORDER BY 3 DESC

  IF @Clave = 'TMA.OSUR'
    INSERT INTO @Tabla(Mov, Modulo, RequiereMontacarga, MovTransito, Movfinal, ClaveAfectacion)
    SELECT ISNULL(mmm.Mov,''),
           ISNULL(mmm.Modulo,''),
           CAST(ISNULL(mmm.RequiereMontacarga,1) AS varchar),
           ISNULL(mmm.MovTransito,''),
           ISNULL(mmm.MovFinal,''),
           ISNULL(mt.Clave,'')
      FROM MapeoMovMovil mmm
      JOIN MovTipo mt ON (mmm.Mov = mt.Mov AND mt.Modulo = 'TMA')
     WHERE mt.Clave IN (@Clave,'TMA.OPCKTARIMA')
    ORDER BY 3 DESC

  IF @Clave NOT IN ('TMA.SADO','TMA.OSUR')
    INSERT INTO @Tabla(Mov, Modulo, RequiereMontacarga, MovTransito, Movfinal, ClaveAfectacion)
        SELECT ISNULL(mmm.Mov,''),
           ISNULL(mmm.Modulo,''),
           CAST(ISNULL(mmm.RequiereMontacarga,1) AS varchar),
           ISNULL(mmm.MovTransito,''),
           ISNULL(mmm.MovFinal,''),
           ISNULL(mt.Clave,'')
      FROM MapeoMovMovil mmm
      JOIN MovTipo mt ON (mmm.Mov = mt.Mov AND mt.Modulo = 'TMA' AND mt.SubClave IS NULL)
     WHERE mt.Clave = ISNULL(@Clave, mt.Clave)
    ORDER BY 3 DESC

  SELECT @Texto = (SELECT * FROM @Tabla AS TMA FOR XML AUTO)

  --UserStory4436
  IF @Texto IS NULL
    SELECT @Ok = 70150, @OkRef = @Clave

  IF @@ERROR <> 0
    SET @Ok = 1

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @@ERROR <> 0
    SET @Ok = 1

  IF @Ok IS NOT NULL
    SELECT @Descripcion = Descripcion + ' ' + @OkRef FROM MensajeLista WHERE Mensaje = @Ok --UserStory4436

  SELECT @OkRef = ''  --UserStory4436

  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + '  Descripcion=' + CHAR(34) + ISNULL(@Descripcion,'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max), ISNULL(@Texto,'')) + '</Resultado></Intelisis>' --UserStory4436

  IF @@ERROR <> 0
    SET @Ok = 1

END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.MapeoMovMovilListado" SubReferencia="" Version="1.0"><Solicitud><Parametro Campo="Clave" Valor="TMA.SADO"/> </Solicitud></Intelisis> '
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado OUTPUT,@Ok Output,@OkRef Output,1,0,@Id Output
--select CONVERT(xml,@Resultado),@Ok,@OkRef

--GO





/************** spIntelisisMontacargaListado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisMontacargaListado') AND type = 'P') drop procedure dbo.spIntelisisMontacargaListado
GO             
CREATE PROCEDURE spIntelisisMontacargaListado
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
		
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100) 

  SELECT @Texto =(SELECT Montacarga FROM Montacarga
                   FOR XML AUTO)	

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    

      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1

  END
END
GO


--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.MontacargaListado" SubReferencia="" Version="1.0"><Solicitud></Solicitud></Intelisis> '
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado,@Ok Output,@OkRef Output,1,0,@Id Output

--GO




/************** spIntelisisWMSValidarMontacarga ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSValidarMontacarga')           AND type = 'P') drop procedure dbo.spIntelisisWMSValidarMontacarga
GO             
CREATE PROCEDURE spIntelisisWMSValidarMontacarga
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
		

	    @Montacarga			varchar(20),
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100)
		

  SELECT  @Montacarga   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Montacarga'



  IF NOT EXISTS (SELECT * FROM Montacarga WHERE Montacarga = @Montacarga )SET @Ok = 20948  --UserStory4436
  


  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '></Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.Validar.Montacarga" SubReferencia="" Version="1.0"><Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--    <Parametro Campo="Montacarga" Valor="2"/> 
--    </Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO',null,@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--select @Resultado,@Ok,@OkRef
--GO



--select * from IntelisisService order by ID desc
--BUG24692
--UserStory4436   
/************** spIntelisisTarimasPorAfectarListado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisTarimasPorAfectarListado') AND type = 'P') drop procedure dbo.spIntelisisTarimasPorAfectarListado
GO
CREATE PROCEDURE spIntelisisTarimasPorAfectarListado
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
    @Usuario                 varchar(20),
    @Mov                     varchar(20),
    @Clave                   varchar(20),
    @Agente                  varchar(10),
    @RequiereMontacarga      int,
    @SucursalNumero          int,
    @SucursalTmp             varchar(20)

  DECLARE @Tabla table(
    ID                       int,
    Mov                      varchar(20),
    MovID                    varchar(20),
    Renglon                  float,
    Almacen                  varchar(10),
    Tarima                   varchar(20),
    Articulo                 varchar(20),
    SubCuenta                varchar(50),
    ArtCambioClave           varchar(20),
    Descripcion1             varchar(100),
    Cantidad                 float,
    Unidad                   varchar(50),
    Posicion                 varchar(10),
    PosicionDestino          varchar(10)
    )

  BEGIN TRY

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @Agente = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Agente'

    SELECT @SucursalTmp = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SucursalNumero'

    SET @Usuario     = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @Mov         = LTRIM(RTRIM(ISNULL(@Mov,'')))
    SET @Agente      = LTRIM(RTRIM(ISNULL(@Agente,'')))
    SET @SucursalTmp = LTRIM(RTRIM(ISNULL(@SucursalTmp,'')))

    IF ISNUMERIC(@SucursalTmp) = 1
      SET @SucursalNumero = CAST(@SucursalTmp AS int)
    ELSE
      SET @SucursalNumero = NULL

    SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario

    IF NOT EXISTS(SELECT * FROM Agente WHERE Agente = @Agente) SELECT @Ok = 26090, @OkRef = @Agente

    SELECT @RequiereMontacarga = ISNULL(RequiereMontacarga,0) FROM MapeoMovMovil WHERE Modulo = 'TMA' AND Mov = @Mov

    INSERT INTO @Tabla(ID, Mov, MovID, Renglon, Almacen, Tarima, Posicion, PosicionDestino, Articulo, Subcuenta, ArtCambioClave, Cantidad, Unidad)
    SELECT t.ID, t.Mov, t.MovID, d.Renglon, d.Almacen, d.Tarima, d.Posicion, d.PosicionDestino, d.Articulo, d.SubCuenta, d.ArtCambioClave, d.CantidadPendiente, d.Unidad
      FROM TMAD d JOIN TMA t ON (t.ID = d.ID)
      JOIN MovTipo m ON (m.Mov = t.Mov AND m.Modulo = 'TMA')
      JOIN ArtDisponibleTarima a ON (d.Tarima = a.Tarima AND a.Empresa = t.Empresa AND a.Almacen = d.Almacen)
     WHERE t.Estatus = 'PENDIENTE'
       AND m.Clave IN ('TMA.SADO','TMA.SRADO','TMA.ORADO','TMA.OADO')
       AND (d.CantidadA IS NULL OR d.CantidadA = 0)
       AND (d.Procesado IS NULL OR d.Procesado = 0)
       AND t.Mov = @Mov
       AND (a.Articulo IS NOT NULL AND a.Articulo <> '')
       AND (d.PosicionDestino IS NOT NULL AND d.PosicionDestino <> '')
       AND d.Montacarga = CASE WHEN @RequiereMontacarga = 1 THEN @Agente ELSE d.Montacarga END
       AND t.Sucursal = @SucursalNumero
     GROUP BY t.ID, t.Mov, t.MovID, d.Renglon, d.Almacen, d.Tarima, d.Posicion, d.PosicionDestino, d.Articulo, d.SubCuenta, d.ArtCambioClave, d.CantidadPendiente, d.Unidad

    UPDATE @Tabla
       SET Descripcion1 = b.Descripcion1
      FROM @Tabla a
      JOIN Art b ON (a.Articulo = b.Articulo)

    SELECT @Texto = (SELECT CAST(ISNULL(ID,0) AS VARCHAR)         AS ID,
                            ISNULL(Mov,'')                        AS Mov,
                            ISNULL(MovID,'')                      AS MovID,
                            CAST(ISNULL(Renglon,0) AS VARCHAR)    AS Renglon,
                            ISNULL(Almacen,'')                    AS Almacen,
                            ISNULL(Tarima,'')                     AS Tarima,
                            ISNULL(Articulo,'')                   AS Articulo,
                            ISNULL(SubCuenta,'')                  AS SubCuenta,
                            ISNULL(ArtCambioClave,'')             AS ArtCambioClave,
                            LTRIM(RTRIM(ISNULL(Descripcion1,''))) AS Descripcion1,
                            CAST(ISNULL(Cantidad,0) AS VARCHAR)   AS Cantidad,
                            ISNULL(Unidad,'')                     AS Unidad,
                            ISNULL(Posicion,'')                   AS Posicion,
                            ISNULL(PosicionDestino,'')            AS PosicionDestino
                       FROM @Tabla AS TMA
                        FOR XML AUTO)

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TarimasPorAfectarListado" SubReferencia="" Version="1.0"> <Solicitud>  <Parametro Campo="Mov" Valor="Solicitud Acomodo" /> <Parametro Campo="Agente" Valor="3" /> </Solicitud> </Intelisis>'
--EXEC spIntelisisService 'DEMO',null,@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--select convert(xml,@Resultado),@Ok,@OkRef
--GO

--UserStory4436 
/************** spIntelisisWMSInfoTarimasPorAfectarListado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoTarimasPorAfectarListado') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoTarimasPorAfectarListado
GO
CREATE PROCEDURE spIntelisisWMSInfoTarimasPorAfectarListado
    @ID                           int,
    @iSolicitud                   int,
    @Version                      float,
    @Resultado                    varchar(max) = NULL OUTPUT,
    @Ok                           int = NULL OUTPUT,
    @OkRef                        varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                        xml,
    @ReferenciaIS                 varchar(100),
    @SubReferencia                varchar(100),
    @Empresa                      char(5),
    @Mov                          varchar(20),
    @MovID                        varchar(20),
    @IdTma                        int,
    @Renglon                      float,
    @Tarima                       varchar(20),
    @Posicion                     varchar(10),
    @LeerPosicionOrigen           bit,
    @CfgMultiUnidades             bit,
    @CfgMultiUnidadesNivel        char(20),
    @ArticuloEsp                  varchar(20),
    @Unidad_Art                   varchar(20),
    @Factor                       float,
    @Alm_Art                      char(20),
    @CantidadU                    float,
    @ValidarZona                  bit,
    @Cantidad                     float

  DECLARE @Tabla Table(
    IdTma                         int,
    Renglon                       float,
    Tarima                        varchar(20),
    Articulo                      varchar(20),
    Cantidad                      float,
    Descripcion1                  varchar(100),
    Almacen                       varchar(10),
    Posicion                      varchar(10),
    DescripcionPosicion           varchar(100),
    PosicionDestino               varchar(10),
    DescripcionPosicionDestino    varchar(100),
    Mov                           varchar(20),
    Folio                         varchar(20),
    LeerPosicionOrigen            bit,
    Unidad                        varchar(50),
    CantidadUnidad                float,
    ValidarZona                   bit
  )

  BEGIN TRY

    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovID'

    SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Tarima'

    SELECT @Posicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Posicion'

    SELECT @IdTma = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'IdTma'

    SELECT @Renglon = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Renglon'

    SET @Empresa    = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Mov        = LTRIM(RTRIM(ISNULL(@Mov,'')))
    SET @MovID      = LTRIM(RTRIM(ISNULL(@MovID,'')))
    SET @Tarima     = LTRIM(RTRIM(ISNULL(@Tarima,'')))
    SET @Posicion   = LTRIM(RTRIM(ISNULL(@Posicion,'')))
    SET @IdTma      = CAST(ISNULL(@IdTma,0) AS int)
    SET @Renglon    = CAST(ISNULL(@Renglon,0) AS float)

    SELECT @LeerPosicionOrigen = ISNULL(WMSLeerPosicionOrigen,1),
           @ValidarZona = ISNULL(WMSValidarZona,1)
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

    INSERT @Tabla(IdTma, Renglon, Tarima, Almacen, Articulo, Cantidad, Posicion, PosicionDestino, Mov, Folio, LeerPosicionOrigen, Unidad, CantidadUnidad, ValidarZona)
    SELECT @IdTma, @Renglon, Tarima, Almacen, Articulo,
           CASE WHEN ISNULL(CantidadPendiente, 0 ) > 0 THEN CantidadPendiente ELSE CantidadPicking END,
           Posicion, PosicionDestino, @Mov, @MovID, @LeerPosicionOrigen,
           Unidad, CantidadUnidad, @ValidarZona
      FROM TMAD
     WHERE ID = @IdTma
       AND Renglon = @Renglon

    SELECT TOP 1 @Cantidad = Cantidad FROM @Tabla

    IF ISNULL(@Cantidad,0) = 0
      BEGIN
        SELECT @Cantidad = ISNULL(Disponible,0) - ISNULL(Apartado,0)
          FROM ArtDisponibleTarima
         WHERE Tarima = @Tarima

         UPDATE @Tabla SET Cantidad = @Cantidad
      END

    UPDATE @Tabla
       SET DescripcionPosicion = b.Descripcion
      FROM @Tabla a
      JOIN AlmPos b ON (a.Almacen = b.Almacen AND a.Posicion = b.Posicion)

    UPDATE @Tabla
       SET DescripcionPosicionDestino = b.Descripcion
      FROM @Tabla a
      JOIN AlmPos b ON (a.Almacen = b.Almacen AND a.PosicionDestino = b.Posicion)

    UPDATE @Tabla
       SET Descripcion1 = b.Descripcion1
      FROM @Tabla a
      JOIN Art b ON (a.Articulo = b.Articulo)

    SELECT @Texto = (SELECT ISNULL(Tarima,'')                             AS Tarima,
                            ISNULL(Articulo,'')                           AS Articulo,
                            CAST(ISNULL(Cantidad,0) AS varchar)           AS Cantidad,
                            ISNULL(Descripcion1,'')                       AS Descripcion1,
                            ISNULL(Almacen,'')                            AS Almacen,
                            ISNULL(Posicion,'')                           AS Posicion,
                            ISNULL(DescripcionPosicion,'')                AS DescripcionPosicion,
                            ISNULL(PosicionDestino,'')                    AS PosicionDestino,
                            ISNULL(DescripcionPosicionDestino,'')         AS DescripcionPosicionDestino,
                            ISNULL(Mov,'')                                AS Mov,
                            ISNULL(Folio,'')                              AS Folio,
                            CAST(ISNULL(LeerPosicionOrigen,0) AS varchar) AS LeerPosicionOrigen,
                            ISNULL(Unidad,'')                             AS Unidad,
                            CAST(ISNULL(CantidadUnidad,0) AS varchar)     AS CantidadUnidad,
                            CAST(ISNULL(ValidarZona,0) AS varchar)        AS ValidarZona
                       FROM @Tabla AS TMA
                        FOR XML AUTO)

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.InfoTarimasPorAfectarListado" SubReferencia="" Version="1.0"> <Solicitud>  <Parametro Campo="Tarima" Valor="T1389" /> <Parametro Campo="Posicion" Valor="R01" /> </Solicitud> </Intelisis>'
--EXEC spIntelisisService 'DEMO',null,@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--select convert(xml,@Resultado),@Ok,@OkRef
--GO

/************** spIntelisisWMSOSurtidoPendientes ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSOSurtidoPendientes') AND type = 'P') drop procedure dbo.spIntelisisWMSOSurtidoPendientes
GO
CREATE PROCEDURE spIntelisisWMSOSurtidoPendientes
    @ID            int,
    @iSolicitud    int,
    @Version       float,
    @Resultado     varchar(max) = NULL OUTPUT,
    @Ok            int = NULL OUTPUT,
    @OkRef         varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa            varchar(5),
    @Sucursal2          varchar(100),
    @Usuario            varchar(20),
    @Texto              xml,
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @Mov                varchar(20),
    @MovC               varchar(20),
    @MovI               varchar(20),
    @MovID              varchar(20),
    @Montacarga         varchar(20),
    @Sucursal           int,
    @Agente             varchar(10),
    @Descripcion        varchar(100),
    @Movimiento         varchar(20),
    @Clave              varchar(20),
    @SubClave           varchar(20)

    DECLARE @Tabla table(
      Mov               varchar(20),
      MovID             varchar(20),
      Fecha             datetime,
      Prioridad         int,
      Completo          bit,
      Almacen           varchar(10),
      OrigenTipo        varchar(10),
      Origen            varchar(20),
      OrigenID          varchar(20)
    )

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Sucursal2= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SELECT @Montacarga = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Montacarga'

  SELECT  @Movimiento = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Movimiento'

  SELECT @Clave = Clave,
         @SubClave = SubClave
    FROM MovTipo
   WHERE Modulo = 'TMA'
     AND Mov = @Movimiento

  SELECT @Sucursal = Sucursal
    FROM Sucursal
   WHERE Nombre = @Sucursal2

  SELECT @Agente = DefAgente
    FROM Usuario
   WHERE Usuario = @Usuario

  IF @Agente IS NULL SELECT @Ok = 20930

  SELECT @MovC = TMAOrdenSurtido FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
  SELECT @MovI = TMAOrdenSurtidoPCK FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa

  INSERT INTO @Tabla(Mov,MovID,Fecha,Prioridad,Completo,Almacen,OrigenTipo,Origen,OrigenID)
  SELECT DISTINCT t.Mov,
                  t.MovID,
                  t.FechaEmision,
                  CASE WHEN t.Prioridad = 'Alta' THEN 1
                       WHEN t.Prioridad = 'Normal' THEN 2
                       WHEN t.Prioridad = 'Baja' THEN 3
                       WHEN t.Prioridad IS NULL THEN 4 END,
                  CASE WHEN @Clave = 'TMA.OSUR' AND t.Mov = @MovC THEN 1
                       WHEN @Clave = 'TMA.OSUR' AND t.Mov = @MovI THEN 0
                       WHEN @Clave = 'TMA.OPCKTARIMA' THEN 0 END,
                  t.Almacen,
                  t.OrigenTipo,
                  t.Origen,
                  t.OrigenID
    FROM TMA t
    JOIN TMAD d ON t.id = d.ID
    JOIN MovTipo m ON m.Mov = t.Mov AND m.Modulo = 'TMA'
   WHERE t.Estatus = 'PENDIENTE'
     AND m.Clave = @Clave
     AND d.Montacarga = @Agente
     AND t.Empresa = @Empresa
     AND t.Sucursal = @Sucursal
     AND d.procesado = 0
   ORDER BY t.FechaEmision ASC

  SELECT @Texto = (SELECT ISNULL(Mov,'') AS Mov,
                          ISNULL(MovID,'') AS MovID,
                          ISNULL(Fecha,'') AS Fecha,
                          CAST(ISNULL(Prioridad,0) AS varchar) AS Prioridad,
                          CAST(ISNULL(Completo,0) AS varchar) AS Completo,
                          ISNULL(Almacen,'') AS Almacen,
                          ISNULL(OrigenTipo,'') AS OrigenTipo,
                          ISNULL(Origen,'') AS Origen,
                          ISNULL(OrigenID,'') AS OrigenID
                     FROM @Tabla AS TMA
                    ORDER BY Prioridad, Fecha DESC
                   FOR XML AUTO)

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max), ISNULL(@Texto,'')) + '</Resultado></Intelisis>'

END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.OSUR.Pendiente" SubReferencia="" Version="1.0"><Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--    <Parametro Campo="Empresa" Valor="DEMO"/> 
--    <Parametro Campo="Sucursal" Valor="Matriz"/>      
--    <Parametro Campo="Usuario" Valor="DEMO"/> 
--    <Parametro Campo="Montacarga" Valor="1"/> 
--    </Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select convert(xml,@Resultado),@Ok,@OkRef
--GO


--UserStory4436
/************** spIntelisisWMSOSURMovListado ****************/
--BUG24617
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSOSURMovListado') AND type = 'P') drop procedure dbo.spIntelisisWMSOSURMovListado
GO
CREATE PROCEDURE spIntelisisWMSOSURMovListado
    @ID                           int,
    @iSolicitud                   int,
    @Version                      float,
    @Resultado                    varchar(max) = NULL OUTPUT,
    @Ok                           int = NULL OUTPUT,
    @OkRef                        varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                        xml,
    @ReferenciaIS                 varchar(100),
    @SubReferencia                varchar(100),
    @Mov                          varchar(20),
    @MovID                        varchar(20),
    @Empresa                      varchar(5),
    @Sucursal                     int,
    @Completo                     int,
    @Sucursal2                    varchar(100),
    @Articulo                     varchar(20),
    @Cantidad                     float,
    @Unidad                       varchar(20),
    @Descripcion                  varchar(100),
    @Movimiento                   varchar(20),
    @Clave                        varchar(20)

  DECLARE @Tabla Table(
    Tarima                        varchar(20),
    Articulo                      varchar(20),
    Cantidad                      varchar(100),
    Descripcion                   varchar(100),
    Posicion                      varchar(10),
    DescripcionPosicion           varchar(100),
    PosicionDestino               varchar(10),
    DescripcionPosicionDestino    varchar(100),
    Mov                           varchar(20),
    Folio                         varchar(20),
    Unidad                        varchar(20),
    ArtCambioClave                varchar(20)
  )

  SELECT @Sucursal2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Completo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Completo'

  SELECT @Movimiento = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Movimiento'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

   SELECT @Sucursal = Sucursal
     FROM Sucursal
    WHERE Nombre = @Sucursal2

   SELECT @Clave = Clave
     FROM MovTipo
    WHERE Modulo = 'TMA'
      AND Mov = @Movimiento

   IF @Completo = 1
     SELECT @Mov = TMAOrdenSurtido FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa

   IF @Completo = 0
     BEGIN
      IF @Clave IN('TMA.OPCKTARIMA')
        SELECT @Mov = TMAOrdenPCKTarima FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
      ELSE
        SELECT @Mov = TMAOrdenSurtidoPCK FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
     END

   INSERT @Tabla(Tarima, Articulo, Cantidad, Descripcion, Posicion, DescripcionPosicion, PosicionDestino, DescripcionPosicionDestino, Mov, Folio, Unidad, ArtCambioClave)
   SELECT d.Tarima,
          a.Articulo,
          --CONVERT(varchar,ISNULL(d.CantidadPicking/ISNULL(dbo.fnArtUnidadFactor(@Empresa, a.Articulo, d.Unidad),1) ,0)),
          CONVERT(varchar,ISNULL(d.CantidadPicking/ISNULL(dbo.fnArtUnidadFactor(@Empresa, a.Articulo, d.Unidad),1) ,0)),
          aa.Descripcion1,
          d.Posicion,
          ISNULL(ap.Descripcion,''),
          d.PosicionDestino,
          ISNULL(apd .Descripcion,''),
          t.Mov,
          t.MovID,
          d.Unidad,
          LTRIM(RTRIM(ISNULL(d.ArtCambioClave,'')))

     FROM TMAD d /*WITH(NOLOCK)*/ JOIN TMA t /*WITH(NOLOCK)*/ ON t.ID = d.ID
     JOIN MovTipo m /*WITH(NOLOCK)*/ ON m.Mov = t.Mov AND m.Modulo = 'TMA'
     JOIN ArtDisponibleTarima a /*WITH(NOLOCK)*/ ON a.Tarima = d.Tarima AND d.Almacen = a.Almacen AND a.Empresa = t.Empresa
     JOIN Art aa /*WITH(NOLOCK)*/ ON a.Articulo = aa.Articulo
     JOIN AlmPos ap /*WITH(NOLOCK)*/ ON ap.Posicion = d.Posicion AND d.Almacen = ap.Almacen
     JOIN AlmPos apd /*WITH(NOLOCK)*/ ON apd.Posicion = d.PosicionDestino AND apd.Almacen = d.Almacen
    WHERE t.Mov = @Mov
      AND t.MovID = @MovID
      AND t.Empresa = @Empresa
      AND t.Sucursal = @Sucursal
    AND t.Estatus IN('PENDIENTE', 'CONCLUIDO') --BUG15306
      --AND d.EstaPendiente = 0 --BUG15306
      --AND d.CantidadA IN (NULL,0)
      --AND d.Procesado = 0 --BUG15306


/*
  SELECT TOP 1 @Unidad=d.Unidad --REQ 04Abr2014
     FROM TMAD d /*WITH(NOLOCK)*/ JOIN TMA  t /*WITH(NOLOCK)*/ ON t.ID = d.ID
     JOIN MovTipo m /*WITH(NOLOCK)*/ ON m.Mov = t.Mov AND m.Modulo = 'TMA'
     JOIN ArtDisponibleTarima a /*WITH(NOLOCK)*/ ON a.Tarima = d.Tarima
     JOIN Art aa /*WITH(NOLOCK)*/ ON a.Articulo = aa.Articulo
   --01042014 Se filtra por Almacen en AlmPos
     JOIN AlmPos ap /*WITH(NOLOCK)*/ ON ap.Posicion = d.Posicion AND d.Almacen = ap.Almacen
     JOIN AlmPos apd /*WITH(NOLOCK)*/ ON apd.Posicion = d.PosicionDestino AND apd.Almacen = d.Almacen
    WHERE  t.Mov = @Mov
      AND t.MovID = @MovID
      AND t.Empresa = @Empresa
      AND t.Sucursal = @Sucursal
      AND t.Estatus IN('PENDIENTE', 'CONCLUIDO')
*/

    DECLARE crPendiente CURSOR FOR
    SELECT a.Articulo, ISNULL(SUM(ISNULL(d.CantidadPicking/ISNULL(dbo.fnArtUnidadFactor(@Empresa, a.Articulo, d.Unidad),1), 0)), 0) --REQ 28Mar2014
      FROM TMAD d /*WITH(NOLOCK)*/ JOIN TMA  t /*WITH(NOLOCK)*/ ON t.ID = d.ID
      JOIN MovTipo m /*WITH(NOLOCK)*/ ON m.Mov = t.Mov AND m.Modulo = 'TMA'
      JOIN ArtDisponibleTarima a /*WITH(NOLOCK)*/ ON a.Tarima = d.Tarima AND a.Almacen = d.Almacen AND a.Empresa = t.Empresa
      JOIN Art aa /*WITH(NOLOCK)*/ ON a.Articulo = aa.Articulo
          --01042014 Se filtra por almacen en AlmPos
      JOIN AlmPos ap /*WITH(NOLOCK)*/ ON ap.Posicion = d.Posicion AND d.Almacen = ap.Almacen
      JOIN AlmPos apd /*WITH(NOLOCK)*/ ON apd.Posicion = d.PosicionDestino AND apd.Almacen = d.Almacen
     WHERE t.origen = @Mov
       AND t.origenid = @MovID
       AND t.Empresa = @Empresa
       AND t.Sucursal = @Sucursal
       and t.estatus IN ('PROCESAR', 'CONCLUIDO')
     GROUP BY a.Articulo, d.Unidad

   OPEN crPendiente
   FETCH NEXT FROM crPendiente INTO @Articulo, @Cantidad
   WHILE @@FETCH_STATUS = 0 --AND @Ok IS NULL
   BEGIN
     UPDATE @Tabla
        SET Cantidad = (Cantidad - @Cantidad)
      WHERE Articulo = @Articulo
   FETCH NEXT FROM crPendiente INTO @Articulo, @Cantidad
   END
   CLOSE crPendiente
   DEALLOCATE crPendiente

  SELECT @Texto = (SELECT * FROM @Tabla TMA WHERE CONVERT(float, Cantidad) > 0.0 ORDER BY Posicion FOR XML AUTO)

  IF @Texto IS NULL
    SELECT @Ok = 14055, @OkRef = 'TMA'

  IF @@ERROR <> 0 SET @Ok = 1

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @@ERROR <> 0 SET @Ok = 1

  IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'

  IF @@ERROR <> 0 SET @Ok = 1

END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.OSUR.MovListado" SubReferencia="" Version="1.0"><Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--    <Parametro Campo="Empresa" Valor="DEMO"/> 
--    <Parametro Campo="Sucursal" Valor="Matriz"/>      
--    <Parametro Campo="Completo" Valor="1"/> 
--    <Parametro Campo="MovID" Valor="1"/> 
--    </Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select convert(xml,@Resultado),@Ok,@OkRef
--GO


/************** spIntelisisWMSOSURTarima ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSOSURTarima') AND type = 'P') drop procedure dbo.spIntelisisWMSOSURTarima
GO
CREATE PROCEDURE spIntelisisWMSOSURTarima
    @ID            int,
    @iSolicitud    int,
    @Version       float,
    @Resultado     varchar(max) = NULL OUTPUT,
    @Ok            int = NULL OUTPUT,
    @OkRef         varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                        xml,
    @ReferenciaIS                 varchar(100),
    @SubReferencia                varchar(100),
    @Mov                          varchar(20),
    @MovID                        varchar(20),
    @Empresa                      varchar(5),
    @Sucursal                     int,
    @Sucursal2                    varchar(100),
    @Tarima                       varchar(20),
    @Posicion                     varchar(10),
    @Articulo                     varchar(20),
    @Cantidad                     float,
    @CantidadUnidad               float,
    @Tipo                         varchar(20),
    @Disponible                   float,
    @DescripcionPosicion          varchar(100),
    @PosicionDestino              varchar(10),
    @DescripcionPosicionDestino   varchar(100)  ,
    @Completo                     int,
    @Codigo                       varchar(50),
    @Unidad                       varchar(20), --REQ 10122013
    @Factor                       float      ,  --28Mar2014
    @Movimiento                   varchar(20),
    @OrdenPCKTarima                     varchar(20)


  DECLARE @Tabla Table(
    Folio                         varchar(20),
    Tarima                        varchar(20),
    Posicion                      varchar(10),
    Tipo                          varchar(20),
    Articulo                      varchar(20),
    Cantidad                      varchar(100),
    CantidadUnidad                varchar(100),
    Unidad                        varchar(20),  --REQ 10122013
    DescripcionPosicion           varchar(100),
    PosicionDestino               varchar(10),
    DescripcionPosicionDestino    varchar(100),
    Codigo                        varchar(50)
  )

  SELECT @Sucursal2  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Mov  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MovID  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  SELECT @Movimiento = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Movimiento'

  SELECT @Tarima  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'

 SELECT @Completo  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Completo'

  SELECT @Articulo  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'
  
  IF @Completo = 0
  BEGIN
    SET @Movimiento = LTRIM(RTRIM(ISNULL(@Movimiento,'')))
    SELECT @OrdenPCKTarima = TMAOrdenPCKTarima FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
    SET @OrdenPCKTarima = LTRIM(RTRIM(ISNULL(@OrdenPCKTarima,'')))
    
    IF @Movimiento = @OrdenPCKTarima --TASK 6874  (Orden PCK Tarima )
      SELECT @Mov = TMAOrdenPCKTarima FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
    ELSE
      SELECT @Mov = TMAOrdenSurtidoPCK FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
      
  END
    
  IF @Completo = 1
    SELECT @Mov = TMAOrdenSurtido FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa

  IF @Completo = 3
    SELECT @Mov = TMASurtidoTransito FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
  

  SELECT @Articulo                   = LTRIM(RTRIM(ISNULL(a.Articulo,''))),
         @Cantidad                   = CONVERT(varchar,ISNULL(ISNULL(d.CantidadPendiente,d.CantidadPicking)/ISNULL(dbo.fnArtUnidadFactor(@Empresa, a.Articulo, d.Unidad),1) ,0)), --BUG24186
         --@Cantidad = ISNULL(d.CantidadPicking, 0),
         @CantidadUnidad             = ISNULL(d.CantidadUnidad, 0), --04Abr2014
         --@CantidadUnidad = ISNULL(d.CantidadPendiente, 0),
         @DescripcionPosicion        = ISNULL(ap.Descripcion,''), 
         @PosicionDestino            = d.PosicionDestino,
         @DescripcionPosicionDestino = ISNULL(apd .Descripcion,''),
         @Posicion                   = d.Posicion, 
         @Tipo                       = ap.Tipo,
         @Unidad                     = ISNULL(d.Unidad, '') --REQ 10122013
    FROM TMA t 
    JOIN TMAD d ON t.ID = d.ID
    JOIN ArtDisponibleTarima a ON d.Tarima = a.Tarima AND t.Empresa = a.Empresa AND a.Almacen = d.Almacen
    --JOIN AlmPos ap  /*WITH(NOLOCK)*/ ON ap.Posicion = d.Posicion
    --JOIN AlmPos apd  /*WITH(NOLOCK)*/ ON apd.Posicion = d.PosicionDestino
    --01042014. Se filtra por almacen en AlmPos
    JOIN AlmPos ap  ON ap.Posicion = d.Posicion AND d.Almacen = ap.Almacen
    JOIN AlmPos apd ON apd.Posicion = d.PosicionDestino AND apd.Almacen = d.Almacen
    JOIN MovTipo mt ON mt.Mov = t.Mov AND Modulo = 'TMA'
   WHERE  t.Empresa = @Empresa
     --AND t.Sucursal = @Sucursal
     AND d.Tarima = @Tarima
     --AND mt.Clave='TMA.OSUR'
     AND t.mov = @Mov
     AND t.MovID = @MovID

   ---------------------------------------------------------------------
   -- Esto no sirve ya que un articulo puede tener varios codigos de barras
   -- asi mismo los codigos de barras pueden pertenecesar no solo a articulos, sino a clientes, proveedores, etc.
   SELECT @Codigo = ISNULL(Codigo,'') 
     FROM CB 
    WHERE Cuenta = @Articulo
   ---------------------------------------------------------------------

  SELECT @Disponible = Disponible
    FROM ArtDisponibleTarima
   WHERE Articulo = @Articulo
     AND Tarima = @Tarima
     AND Empresa = @Empresa

  SELECT @Tipo = Tipo 
    FROM AlmPos 
   WHERE Posicion = @Posicion

  IF @Ok IS NULL
    INSERT @Tabla(Folio, Tarima, Posicion, Tipo, Articulo, 
                  Cantidad, CantidadUnidad, Unidad, DescripcionPosicion, PosicionDestino, 
                  DescripcionPosicionDestino, Codigo) 
    SELECT ISNULL(@MovID,''), ISNULL(@Tarima,''), ISNULL(@Posicion,''), ISNULL(@Tipo,''), ISNULL(@Articulo,''), 
           ISNULL(CONVERT(varchar,@Cantidad),''), ISNULL(CONVERT(varchar,@CantidadUnidad),''), ISNULL(CONVERT(varchar,@Unidad),''), ISNULL(@DescripcionPosicion,''), ISNULL(@PosicionDestino,''), 
           ISNULL(@DescripcionPosicionDestino,''), ISNULL(@Codigo,'')

  SELECT @Texto = ISNULL((SELECT * FROM @Tabla TMA
                           FOR XML AUTO), '')

  IF @@ERROR <> 0 SET @Ok = 1

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @@ERROR <> 0 SET @Ok = 1

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'

  IF @@ERROR <> 0 SET @Ok = 1

END
GO


--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
	
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.OSUR.Tarima" SubReferencia="" Version="1.0"> 
-- <Solicitud>
--  <Parametro Campo="Empresa" Valor="DEMO" /> 
--  <Parametro Campo="Sucursal" Valor="Matriz" /> 
--  <Parametro Campo="MovID" Valor="7" /> 
--  <Parametro Campo="Tarima" Valor="TM928" /> 
--  <Parametro Campo="Completo" Valor="0" /> 
--  </Solicitud>
--  </Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select convert(xml,@Resultado),@Ok,@OkRef
--GO


/**************** spISIntelisisTMAAfectarTMA_OSUR ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisTMAAfectarTMA_OSUR') and type = 'P') drop procedure dbo.spISIntelisisTMAAfectarTMA_OSUR
GO             
CREATE PROCEDURE spISIntelisisTMAAfectarTMA_OSUR
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
    @IDGenerar					int,
    @IDAcceso					int,	
    @MovTipo					varchar(20),
    @ReferenciaIS				varchar(100),
    @Usuario2					varchar(10),
    @Estacion					int,
    @SubReferencia				varchar(100),
    @Empresa   				    varchar(5),
    @Mov   					    varchar(20),
    @MovID   					varchar(20),
    @Sucursal                   int,
    @ID2                        int,
    @Tarima                     varchar(20),
    @Sucursal2                  varchar(100),
    @Posicion                   varchar(20),
--    @PosicionDestino            varchar(20),
    @Usuario                    varchar(15),
    @Montacargas                varchar(20),
    @Estatus                    varchar(20),
    @Agente                     varchar(20),
    @Modificar                  bit,
    @Procesado                  bit,
    @Mov2  					    varchar(20),
    @MovID2   					varchar(20),
    @PosicionDGenerar           varchar(20),
    @Descripcion                varchar(100),
    @Movimiento					varchar(20)

    
BEGIN TRANSACTION 
  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  

  
  IF @Ok IS NULL
  BEGIN  
     SELECT  @Empresa = NULLIF(Empresa,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Empresa    varchar(255))
     SELECT  @MovID = NULLIF(MovID,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(MovID    varchar(255))  
     SELECT  @Mov= NULLIF(Mov,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Mov    varchar(255)) 
     SELECT  @Tarima = NULLIF(Tarima,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Tarima   varchar(255))
     SELECT  @Posicion = NULLIF(Posicion,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Posicion   varchar(255))  
--     SELECT  @PosicionDestino = NULLIF(PosicionDestino,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
--       WITH(PosicionDestino   varchar(255))  
     SELECT  @Usuario = NULLIF(Usuario,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Usuario   varchar(255))   
     SELECT  @Sucursal2 = NULLIF(Sucursal,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Sucursal   varchar(255))  
     SELECT  @Montacargas = NULLIF(Montacarga,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Montacarga   varchar(255))  
        
   END
  SELECT @MovTipo = Clave FROM MovTipo WHERE Mov = @Mov AND Modulo = 'TMA'
  SELECT @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @Sucursal2
  IF @MovTipo NOT IN ('TMA.OSUR') SELECT @Ok = 35005, @OkRef = @Mov 
  IF @Ok IS NULL
  BEGIN  
--  SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE t.MovID = '3' AND t.Mov = 'Orden de Surtido' AND d.Tarima = 't164'  AND t.Empresa = 'demo' AND t.Sucursal = 0
--SELECT @MOV,@MOVID,@EMPRESA
    IF NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE t.MovID = @MovID AND t.Mov = @Mov AND d.Tarima = @Tarima  AND t.Empresa = @Empresa AND t.Sucursal = @Sucursal) SELECT @Ok = 13110
    IF NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE t.MovID = @MovID AND t.Mov = @Mov AND d.Tarima = @Tarima AND d.Posicion = @Posicion  AND t.Empresa = @Empresa AND t.Sucursal = @Sucursal) SELECT @Ok = 13190
    IF NOT EXISTS(SELECT * FROM Montacarga WHERE Montacarga = @Montacargas) SELECT @Ok = 20936


  END

  IF @Ok IS NULL 
  BEGIN  
  SELECT @ID2 = ID FROM TMA WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Mov = @Mov AND MovID = @MovID
  SELECT @Estatus = Estatus FROM TMA WHERE ID = @ID2

  SELECT @Procesado = ISNULL(Procesado,0)  FROM TMAD WHERE ID = @ID2 AND Tarima = @Tarima 
  
  SELECT @Modificar = ModificarPosicionSugeridaWMS FROM Usuario WHERE Usuario = @Usuario


--  IF @Procesado= 0
--  BEGIN
    UPDATE TMAD 
       SET CantidadA = 1
     WHERE Tarima = @Tarima  AND ID = @ID2
     
--  END   

  IF  @ID2 IS  NULL SET @Ok = 14055
  IF @Ok IS NULL AND @Estatus = 'PENDIENTE' AND @MovTipo = 'TMA.OSUR' 
  BEGIN 
     
--    UPDATE TMA SET Montacarga = @Montacargas , Agente = @Agente
     --WHERE ID = @ID2 'RJP 13072010 no es necesario actualizar el Agente y Montacargas en la Orden de Acomodo

    SELECT @Movimiento = TMASurtidoTransito FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa    
        
     EXEC @IDGenerar =  spAfectar 'TMA', @ID2, 'GENERAR', 'Seleccion', @Movimiento, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT
        IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL
     
    
    

    SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
    IF @Agente IS NULL SELECT @Ok = 20930
    
    UPDATE TMA SET Montacarga = @Montacargas , Agente = @Agente
     WHERE ID = @IDGenerar
    
    IF @Ok IS NULL   
      EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT ,@OkRef = @OkRef OUTPUT 
        IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL
     


  END
  
--select * from tma where id = @idgenerar
--select * from tmad where id = @idgenerar
  
    
  
  SELECT @ReferenciaIS = Referencia 
    FROM IntelisisService 
   WHERE ID = @ID 

  SELECT @Mov2 = Mov , @MovID2 = MovID  FROM TMA WHERE ID = @IDGenerar  
  SELECT @PosicionDGenerar = PosicionDestino  FROM TMAD WHERE ID = @IDGenerar
  SELECT @Descripcion = Descripcion FROM AlmPos WHERE Posicion = @PosicionDGenerar
 END

--select @ok = 1
   
   IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
  END
 IF @Ok IS NOT NULL 
 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok 
 SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="TMA" ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) +'  Mov=' + CHAR(34) + ISNULL(@Mov2,'') + CHAR(34) +'  MovID=' + CHAR(34) + ISNULL(@MovID2,'') + CHAR(34)  +'  PosicionDestino=' + CHAR(34) + ISNULL(@PosicionDGenerar,'') + CHAR(34) +'  DescripcionPosicionDestino=' + CHAR(34) + ISNULL(@Descripcion,'') + CHAR(34) +  ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'
END

GO


--update TMAD
--set Procesado = 0 
--where id = 546

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos=' <Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.AfectarMov.TMA_OSUR" SubReferencia="" Version="1.0">
-- <Solicitud>
--  <TMA Empresa="DEMO" Mov="Orden de Surtido" MovID="8" Usuario="DEMO" Sucursal="Matriz" Montacarga="mon01" Tarima="tm947" PosicionDestino="ucaotica" /> 
--  </Solicitud>
--  </Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--SELECT convert(xml,@Resultado),@Ok,@OkRef

--GO



/**************** spISIntelisisTMAAfectarTMA_SUR ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisTMAAfectarTMA_SUR') and type = 'P') drop procedure dbo.spISIntelisisTMAAfectarTMA_SUR
GO             
CREATE PROCEDURE spISIntelisisTMAAfectarTMA_SUR
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
    @IDGenerar					int,
    @IDAcceso					int,	
    @MovTipo					varchar(20),
    @ReferenciaIS				varchar(100),
    @Usuario2					varchar(10),
    @Estacion					int,
    @SubReferencia				varchar(100),
    @Empresa   				    varchar(5),
    @Mov   					    varchar(20),
    @MovID   					varchar(20),
    @Sucursal                   int,
    @ID2                        int,
    @Tarima                     varchar(20),
    @Sucursal2                  varchar(100),
--    @Posicion                   varchar(20),
    @PosicionDestino            varchar(20),
    @Usuario                    varchar(15),
    @Montacargas                varchar(20),
    @Estatus                    varchar(20),
    @Agente                     varchar(20),
    @Modificar                  bit,
    @Procesado                  bit,
    @Mov2  					    varchar(20),
    @MovID2   					varchar(20),
    @PosicionDGenerar           varchar(20),
    @Descripcion                varchar(100),
    @Movimiento					varchar(20),
    @Tipo						varchar(20)

    

  BEGIN TRANSACTION 
  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  

  
  IF @Ok IS NULL
  BEGIN  
     SELECT  @Empresa = NULLIF(Empresa,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Empresa    varchar(255))
     SELECT  @MovID = NULLIF(MovID,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(MovID    varchar(255))  
     SELECT  @Mov= NULLIF(Mov,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Mov    varchar(255)) 
     SELECT  @Tarima = NULLIF(Tarima,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Tarima   varchar(255))
--     SELECT  @Posicion = NULLIF(Posicion,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
--       WITH(Posicion   varchar(255))  
     SELECT  @PosicionDestino = NULLIF(PosicionDestino,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(PosicionDestino   varchar(255))  
     SELECT  @Usuario = NULLIF(Usuario,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Usuario   varchar(255))   
     SELECT  @Sucursal2 = NULLIF(Sucursal,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Sucursal   varchar(255))  
     SELECT  @Montacargas = NULLIF(Montacarga,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Montacarga   varchar(255))  
        
   END

  SELECT @MovID = t.MovID,@Mov=t.Mov FROM TMA t JOIN TMAD d  ON t.ID = d.ID WHERE t.Empresa = @Empresa AND t.Sucursal = @Sucursal AND d.Tarima = @Tarima 
  SELECT @MovTipo = Clave FROM MovTipo WHERE Mov = @Mov AND Modulo = 'TMA'
  SELECT @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @Sucursal2
  IF @MovTipo NOT IN ('TMA.TSUR') SELECT @Ok = 35005, @OkRef = @Mov 
  IF @Ok IS NULL
  BEGIN  
    
    IF NOT EXISTS(SELECT * FROM Montacarga WHERE Montacarga = @Montacargas) SELECT @Ok = 20936
    
    IF NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE  d.Tarima = @Tarima  AND t.Empresa = @Empresa AND t.Sucursal = @Sucursal AND t.Mov=@Mov AND t.MovID= @MovID) SELECT @Ok = 13110
 
    IF NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE  d.Tarima = @Tarima AND d.PosicionDestino = @PosicionDestino AND t.Empresa = @Empresa AND t.Sucursal = @Sucursal AND t.Mov=@Mov AND t.MovID= @MovID) SELECT @Ok = 13035

  END

  IF @Ok IS NULL 
  BEGIN  
  SELECT @Tipo = Tipo FROM AlmPos WHERE Posicion = @PosicionDestino
  SELECT @ID2 = ID FROM TMA WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Mov = @Mov AND MovID = @MovID
  SELECT @Estatus = Estatus FROM TMA WHERE ID = @ID2

  SELECT @Procesado = ISNULL(Procesado,0) FROM TMAD WHERE ID = @ID2 AND Tarima = @Tarima 
  
  SELECT @Modificar = ModificarPosicionSugeridaWMS FROM Usuario WHERE Usuario = @Usuario


--  IF @Procesado= 0
--  BEGIN
    UPDATE TMAD 
       SET CantidadA = 1
     WHERE Tarima = @Tarima  AND ID = @ID2
     
--  END   


  IF @Ok IS NULL AND @Estatus = 'PENDIENTE' AND @MovTipo = 'TMA.TSUR'-- AND @Tipo = 'Ubicacion'
  BEGIN 

    SELECT @Movimiento = TMASurtido FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa

    EXEC @IDGenerar =  spAfectar 'TMA', @ID2, 'GENERAR', 'Seleccion', @Movimiento, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT 
        IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL
     
     
    SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
    IF @Agente IS NULL SELECT @Ok = 20930
    
    UPDATE TMA SET Montacarga = @Montacargas , Agente = @Agente
     WHERE ID = @IDGenerar
    
    IF @Ok IS NULL     
      EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT ,@OkRef = @OkRef OUTPUT 
        IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL
     

--select Estatus, * from TMA where id = @IDGenerar
--select @Ok, Procesado, * from TMAD where id = @IDGenerar
--select Estatus, * from TMA where id = @ID2
--select @Ok, Procesado, * from TMAD where id = @ID2


  END
  
    
  IF @Ok IS NULL
  SELECT @ReferenciaIS = Referencia 
    FROM IntelisisService 
   WHERE ID = @ID 
   
  SELECT @Mov2 = Mov , @MovID2 = MovID  FROM TMA WHERE ID = @IDGenerar  
  SELECT @PosicionDGenerar = PosicionDestino  FROM TMAD WHERE ID = @IDGenerar
  SELECT @Descripcion = Descripcion FROM AlmPos WHERE Posicion = @PosicionDGenerar
  
 
 END
--SELECT @OK = 1
 IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
  END
  IF @Ok IS NOT NULL 
  SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok 
  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="TMA" ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) +'  Mov=' + CHAR(34) + ISNULL(@Mov2,'') + CHAR(34) +'  MovID=' + CHAR(34) + ISNULL(@MovID2,'') + CHAR(34)  +'  PosicionDestino=' + CHAR(34) + ISNULL(@PosicionDGenerar,'') + CHAR(34) +'  DescripcionPosicionDestino=' + CHAR(34) + ISNULL(@Descripcion,'') + CHAR(34) +  ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO


--update TMAD
--set Procesado = 0 
--where id = 546

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.AfectarMov.TMA_SUR" SubReferencia="" Version="1.0"><Solicitud><TMA Empresa="DEMO " Mov="Surtido  Transito" MovID="19" Usuario="DEMO" Sucursal="Matriz" Montacarga="MON01" Tarima ="T100" Posicion="A2" PosicionDestino="SC" /></Solicitud></Intelisis> '
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--SELECT convert(xml,@Resultado),@Ok,@OkRef

--go


--BUG473
/************** spIntelisisWMSValidarMovCOMS_O  ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSValidarMovCOMS_O ')           AND type = 'P') drop procedure dbo.spIntelisisWMSValidarMovCOMS_O 
GO         
CREATE PROCEDURE spIntelisisWMSValidarMovCOMS_O 
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
		
		@Empresa            varchar(5),
		@ID2                int,
		@Mov                varchar(20),
		@Mov2               varchar(20),
	    @MovID  			varchar(20),
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@UsuarioSucursal    bit,
		@Verifica           int,
		@Verifica2          int,
		@Sucursal           int,
		@Anden				varchar(10),

		--PGC17102014
		@OPreEntarimado    bit
			
		
  SELECT  @Empresa   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'
  SELECT  @Mov= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'
  SELECT  @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  IF @Mov NOT IN(SELECT Mov FROM MovTipo WHERE Clave ='COMS.O' AND Modulo='COMS') SET @Ok= 35005

  --BUG4573
  IF @Ok IS NULL AND NOT EXISTS(     
     SELECT *
	 FROM Compra 	 
	 WHERE Compra.Mov = @Mov 
	   AND Compra.MovID = @MovID 
	   AND Compra.Empresa =@Empresa)
	    SELECT @Ok=14055

  --BUG24090
  IF @Ok IS NULL AND NOT EXISTS(     
     SELECT *
	 FROM Compra 	 
	 JOIN Alm ON Compra.Almacen=Alm.Almacen
	 WHERE Compra.Mov = @Mov 
	   AND Compra.MovID = @MovID 
	   AND Compra.Empresa =@Empresa
	   AND Alm.WMS=1)
	    SELECT @Ok=20830

		
  ---RJP 18112010 El movimiento existe pero esta concluído
  if @Ok is NULL
     IF EXISTS(SELECT * FROM Compra WHERE Mov = @Mov and MovID = @MovID AND Empresa =@Empresa AND Estatus ='CONCLUIDO') SET @Ok =80010
  ---RJP 18112010 El movimiento existe pero esta concluído
  
  if @Ok is NULL   ---RJP 18112010 El Movimiento no existe en la base de datos
     IF NOT EXISTS(SELECT * FROM Compra WHERE Mov = @Mov and MovID = @MovID AND Empresa =@Empresa AND Estatus ='PENDIENTE')SET @Ok =14055
    
  if @Ok is NULL  ---- RJP 18112010, seguir con validaciones en caso de no haber errores
     --- SELECT @ID2 = ID FROM Compra WHERE Empresa = @Empresa AND  Mov = @Mov AND MovID = @MovID  
     SELECT @Anden = LTRIM(RTRIM(isnull(PosicionWMS,''))) FROM Compra WHERE Mov = @Mov and MovID = @MovID AND Empresa =@Empresa  --UserStory4436
	 If @Anden = ''
	    SET @Ok =80202
  
  --BUG24764
  SET @OPreEntarimado = NULL --UserStory4436
  --IF @Ok IS NULL --PGC24102014
    IF EXISTS(SELECT *
	            FROM Compra c	  
	           WHERE c.Mov = 'Orden Pre Entarimado' and c.OrigenID = @MovID AND c.Empresa =@Empresa AND Estatus ='PENDIENTE') 
	  SET @OPreEntarimado = 1

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok	  
	  --BUG24764
	  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '></Resultado></Intelisis>' --UserStory4436
      --SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) 
	   	 --                        + CASE WHEN @OPreEntarimado = 1 THEN ' OPreEntarimado=' + ISNULL(CONVERT(varchar,@OPreEntarimado),'') ELSE '' END + '></Resultado></Intelisis>' --UserStory4436
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.ValidarMov.COMS_O" SubReferencia="" Version="1.0"><Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--    <Parametro Campo="Empresa" Valor="DEMO"/> 
--    <Parametro Campo="Mov" Valor="Orden Compra"/>      
--    <Parametro Campo="MovID" Valor="2"/> 
--    </Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select @Resultado,@Ok,@OkRef
--GO


--BUG24692
/************** spIntelisisWMSDetalleMovCOMS_O  ****************/
--10062014
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSDetalleMovCOMS_O ')           AND type = 'P') drop procedure dbo.spIntelisisWMSDetalleMovCOMS_O 
GO             
CREATE PROCEDURE spIntelisisWMSDetalleMovCOMS_O 
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
		
		@Empresa            varchar(5),
		@ID2                 int,
		@Mov                varchar(20),
		@Mov2                varchar(20),
	    @MovID  			varchar(20),
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@UsuarioSucursal    bit,
		@Verifica           int,
		@Verifica2          int,
		@Sucursal         int,
		@Anden				varchar(10),
		@Descripcion		varchar(100)
		
		
  SELECT  @Empresa   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'
  SELECT  @Mov= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'
  SELECT  @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  
  DECLARE
  @Tabla Table(  
  Codigo                    varchar(30),
  Cantidad                  varchar(100),
  Unidad                    varchar(50),
  Articulo                  varchar(20),
  Descripcion               varchar(100),
  Tipo                      varchar(20)
  )		

  IF @Mov NOT IN(SELECT Mov FROM MovTipo WHERE Clave ='COMS.O' AND Modulo='COMS') SET @Ok= 35005

  ---RJP 18112010 El movimiento existe pero esta concluído
  if @Ok is NULL
     IF EXISTS(SELECT * FROM Compra WHERE Mov = @Mov and MovID = @MovID AND Empresa =@Empresa AND Estatus ='CONCLUIDO')SET @Ok =80010
  ---RJP 18112010 El movimiento existe pero esta concluído
  
  if @Ok is NULL   ---RJP 18112010 El Movimiento no existe en la base de datos
     IF NOT EXISTS(SELECT * FROM Compra WHERE Mov = @Mov and MovID = @MovID AND Empresa =@Empresa AND Estatus ='PENDIENTE')SET @Ok =14055
    
  if @Ok is NULL  ---- RJP 18112010, seguir con validaciones en caso de no haber errores
     --- SELECT @ID2 = ID FROM Compra WHERE Empresa = @Empresa AND  Mov = @Mov AND MovID = @MovID  
     SELECT @Anden = LTRIM(RTRIM(isnull(PosicionWMS,''))) FROM Compra WHERE Mov = @Mov and MovID = @MovID AND Empresa =@Empresa --BUG24692
	 If @Anden = ''
	    SET @Ok =80202
  
  IF @Ok IS NULL
    INSERT INTO @Tabla
    SELECT ISNULL(cb.Codigo,''), 
           ISNULL(d.CantidadA,0), 
           ISNULL(d.Unidad,''),
           ISNULL(d.Articulo,''),
           ISNULL(a.Descripcion1,''),
           ISNULL(a.Tipo,'')  
	    FROM Compra c
	    JOIN CompraD d ON d.ID=c.ID
	    JOIN CB cb ON cb.Cuenta=d.Articulo
      JOIN Art a ON d.Articulo = a.Articulo
	   WHERE c.Mov = @Mov and c.MovID = @MovID AND c.Empresa =@Empresa 
	   /*AND cb.CodigoPrincipal=1*/

  SELECT @Texto =(SELECT TMA.Codigo,
                         TMA.Cantidad,
                         TMA.Unidad,
                         TMA.Articulo,
                         TMA.Descripcion,
                         TMA.Tipo
                    FROM @Tabla TMA 
                   WHERE Cantidad>0 
                   FOR XML AUTO)

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
END
GO
/************** spIntelisisWMSActualizarAnden ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSActualizarAnden') AND type = 'P') drop procedure dbo.spIntelisisWMSActualizarAnden
GO
CREATE PROCEDURE spIntelisisWMSActualizarAnden
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
  @Empresa         varchar(5),
  @Almacen         varchar(10),
  @ID2             int,
  @Mov             varchar(20),
  @Anden           varchar(20),
  @MovID           varchar(20),
  @ReferenciaIS    varchar(100),
  @SubReferencia   varchar(100)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Anden = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Anden'

  SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Almacen = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Mov     = LTRIM(RTRIM(ISNULL(@Mov,'')))
  SET @MovID   = LTRIM(RTRIM(ISNULL(@MovID,'')))
  SET @Anden   = LTRIM(RTRIM(ISNULL(@Anden,'')))

  SELECT @ID2 = ID FROM Compra WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID

  IF NOT EXISTS(SELECT * FROM AlmPos WHERE Almacen = @Almacen AND Estatus = 'ALTA' AND Tipo = 'Recibo' AND Posicion = @Anden) SET @Ok = 13030

  IF NOT ISNULL(@Ok,0) = 0 SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

END TRY

BEGIN CATCH
  SET @Ok = 1
  SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
END CATCH

SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '></Resultado></Intelisis>'
SET @Resultado = REPLACE(@Resultado,'<BR>','.')

END
GO
--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.ActualizarAnden" SubReferencia="" Version="1.0"><Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--    <Parametro Campo="Empresa" Valor="DEMO"/> 
--    <Parametro Campo="Mov" Valor="Orden Compra"/>      
--    <Parametro Campo="MovID" Valor="3"/> 
--    <Parametro Campo="Anden" Valor="A4"/> 
--    </Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select @Resultado,@Ok,@OkRef
--GO


/************** spIntelisisWMSInfoOrdenCompra ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoOrdenCompra') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoOrdenCompra
GO
CREATE PROCEDURE spIntelisisWMSInfoOrdenCompra
    @ID            int,
    @iSolicitud    int,
    @Version       float,
    @Resultado     varchar(max) = NULL OUTPUT,
    @Ok            int = NULL OUTPUT,
    @OkRef         varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

    @Empresa                      varchar(5),
    @ID2                          int,
    @Mov                          varchar(20),
    @Anden                        varchar(20),
    @MovID                        varchar(20),
    @Texto                        xml,
    @ReferenciaIS                 varchar(100),
    @SubReferencia                varchar(100),
    @UsuarioSucursal              bit,
    @Verifica                     int,
    @Verifica2                    int,
    @Sucursal                     int,
    @ExisteOrden                  int,
    @LeerPosicionOrigen           int,
    @ModuloID                     int,
    @Usuario                      varchar(10),
    @ModificarPosicionSugeridaWMS bit

  DECLARE @Tabla Table(
    Proveedor                     varchar(20),
    NombreProveedor               varchar(50),
    FechaEntrega                  datetime,
    Anden                         varchar(20),
    Almacen                       varchar(10),
    LeerPosicionOrigen            int,
    ModificarPosicionSugeridaWMS  bit,
    ModuloID                      int
  )

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  SELECT @Usuario = Usuario FROM IntelisisService WHERE ID = @ID
  SELECT @ModificarPosicionSugeridaWMS = ModificarPosicionSugeridaWMS FROM Usuario WHERE Usuario = @Usuario

  SELECT @LeerPosicionOrigen = ISNULL(WMSLeerPosicionOrigen, 0) FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @ModuloID = ID FROM Compra WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID

  IF @Ok IS NULL
    INSERT Into @Tabla(Proveedor, NombreProveedor, FechaEntrega, Anden, Almacen, LeerPosicionOrigen, ModificarPosicionSugeridaWMS, ModuloID)
    SELECT c.Proveedor, p.Nombre, ISNULL(c.FechaEntrega, c.FechaEmision), c.PosicionWMS, c.Almacen, @LeerPosicionOrigen, @ModificarPosicionSugeridaWMS, @ModuloID
      FROM Compra c JOIN Prov p ON c.Proveedor = p.Proveedor
     WHERE c.Empresa = @Empresa AND c.ID = @ModuloID
  ELSE
    INSERT Into @Tabla(Proveedor, NombreProveedor, FechaEntrega, LeerPosicionOrigen, ModificarPosicionSugeridaWMS, Anden, Almacen, ModuloID)
    VALUES ('No existe', 'No existe', '', 'Sin Anden', 'Sin Almacen', @LeerPosicionOrigen, @ModificarPosicionSugeridaWMS, @ModuloID)

  SELECT @Texto = (SELECT ISNULL(Proveedor,'')                                    AS Proveedor,
                          ISNULL(NombreProveedor,'')                              AS NombreProveedor,
                          ISNULL(FechaEntrega,'')                                 AS FechaEntrega,
                          ISNULL(Anden,'')                                        AS Anden,
                          ISNULL(Almacen,'')                                      AS Almacen,
                          CAST(ISNULL(LeerPosicionOrigen,0) AS varchar)           AS LeerPosicionOrigen,
                          CAST(ISNULL(ModificarPosicionSugeridaWMS,0) AS varchar) AS ModificarPosicionSugeridaWMS,
                          CAST(ISNULL(ModuloID,0) AS varchar)                     AS ModuloID
                     FROM @Tabla AS OrdenCompra
                   FOR XML AUTO)

   SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

   IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
   SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
   SET @Resultado = REPLACE(@Resultado,'<BR>','.')

END
GO

--BUG5664
/**************** spIntelisisWMSInfoCB_COMS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoCB_COMS') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoCB_COMS
GO
CREATE PROCEDURE spIntelisisWMSInfoCB_COMS
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
		
		@Empresa            varchar(5),
		@Referencia         varchar(50), --RJP 23092010 Se agrega campo para capturar la Referencia
		@ID2                 int,
		@Mov                varchar(20),
		@CB                varchar(30),
		@Anden                varchar(20),
	    @MovID  			varchar(20),
	    @Articulo 			varchar(20),
	    @SubCuenta 			varchar(50),
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@UsuarioSucursal    bit,
		@Cantidad           float,
		@Caducidad          int,
		@FechaCaducidad     datetime,
		@Fecha              datetime,
		@Sucursal			int,
		@Cantidad2          float,
		@Tipo				varchar(20),
		@Serie				varchar(20),
		@RenglonID			int,
		@RenglonID2			int,
		@Sustituir          varchar(5),
		@TieneCaducidad		bit,
		@Propiedades		varchar(20),
		@UnidadCompra       varchar(20) --PGC06122013
		
  DECLARE  @Tabla Table(
  Cuenta                  varchar(20),
  SubCuenta               varchar(50),
  Descripcion             varchar(100),
  Unidad                  varchar(20),
  TieneCaducidad          bit,
  CaducidadMinima         int,
  CantidadPresentacion    float,
  Presentacion            varchar(50) NULL,
  Factor                  float,
  CantidadCamaTarima      int NULL,
  CamasTarima             int NULL,
  Amarre                  int NULL,
  Tipo                    varchar(20),
  SerieLoteInfo           int --BUG5756
  )			

  SELECT  @Empresa   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa' 
   SELECT  @CB = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Codigo'  


 IF NOT EXISTS(SELECT * FROM CB WHERE Codigo = @CB)SET @Ok = 72040


  IF @Ok IS NULL
  BEGIN
	SELECT @Articulo = Cuenta, @SubCuenta=ISNULL(SubCuenta,'') FROM CB WHERE Codigo = @CB   
	
	SELECT @Fecha = GETDATE()
	SELECT @Caducidad =ISNULL(CaducidadMinima,0), @TieneCaducidad = ISNULL(TieneCaducidad,0)  FROM Art WHERE Articulo = @Articulo

  END
	
    --25032014. Solicitud para que se muestre esto después de capturar el a´rticulo:
    -- Descripción (Descripcion1 de Tabla Art)
    -- Capacidad (CantidadPresentacion + Presentacion de Tabla Art)
    -- Factor de Empaque (Factor en tabla ArtUnidad donde Unidad sea igual a UnidadCompra de tabla Art)
    -- Cajas x Tarima (5 x 10) (CantidadCamaTarima y CamasTarima de Tabla Art)
    -- Amarre (50) (Total de Cajas por tarima) (Resultado de CamasTarima X CantidadCamaTarima  de tabla Art)

  --SELECT CantidadPresentacion, Presentacion, CantidadCamaTarima, CamasTarima FROM Art
  --SELECT * FROM ArtUnidad


  IF @Ok IS NULL
    BEGIN	  
      --EWQ. Tuning
      INSERT @Tabla(Cuenta, SubCuenta,               Descripcion,                Unidad,               TieneCaducidad,              CaducidadMinima,              CantidadPresentacion,              Presentacion,               Factor,              CantidadCamaTarima,              CamasTarima,                                  Amarre                   ,  Tipo , SerieLoteInfo)
      SELECT      c.Cuenta, ISNULL(c.SubCuenta, ''), ISNULL(a.Descripcion1, ''), ISNULL(c.Unidad, ''), ISNULL(a.TieneCaducidad, 0), ISNULL(a.CaducidadMinima, 0), ISNULL(a.CantidadPresentacion, 0), ISNULL(a.Presentacion, ''), ISNULL(au.Factor,0), ISNULL(a.CantidadCamaTarima, 0), ISNULL(a.CamasTarima, 0), ISNULL(a.CantidadCamaTarima*a.CamasTarima, 0), a.Tipo, a.SerieLoteInfo --BUG5756
        FROM CB c 
		JOIN Art a ON c.Cuenta = a.Articulo
	    LEFT OUTER JOIN ArtUnidad au ON AU.Articulo=a.Articulo AND au.Unidad=a.UnidadCompra 
       WHERE  c.Codigo = @CB 
    END    

  SELECT @Texto =ISNULL((SELECT Cuenta, SubCuenta, Descripcion, TieneCaducidad, CaducidadMinima, Unidad,
                         CONVERT(varchar, CantidadPresentacion) CantidadPresentacion, Presentacion, 
						 CONVERT(varchar, Factor) Factor, 
						 CONVERT(varchar, CantidadCamaTarima) CantidadCamaTarima, 
						 CONVERT(varchar, CamasTarima) CamasTarima, 
						 CONVERT(varchar, Amarre) Amarre,
						 Tipo,
						 SerieLoteInfo --BUG5756
						 FROM @Tabla FOR XML AUTO),'')

  IF @Texto IS NULL
	SELECT @Ok = 10530, @OkRef=''

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1  
   
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'	
      IF @@ERROR <> 0 SET @Ok = 1
    
  END

END
GO

/************** spIntelisisWMSValidarCB ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSValidarCB') AND type = 'P') drop procedure dbo.spIntelisisWMSValidarCB
GO
CREATE PROCEDURE spIntelisisWMSValidarCB
  @ID         int,
  @iSolicitud int,
  @Version    float,
  @Resultado  varchar(max) = NULL OUTPUT,
  @Ok         int = NULL OUTPUT,
  @OkRef      varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa            varchar(5),
    @Referencia         varchar(50),
    @ID2                int,
    @ModuloID           int,
    @Mov                varchar(20),
    @MovID              varchar(20),
    @CB                 varchar(30),
    @Anden              varchar(20),
    @Articulo           varchar(20),
    @SubCuenta          varchar(50),
    @Texto              xml,
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @UsuarioSucursal    bit,
    @Cantidad           float,
    @Caducidad          int,
    @FechaCaducidad     datetime,
    @Fecha              datetime,
    @Sucursal           int,
    @Cantidad2          float,
    @Tipo               varchar(20),
    @Serie              varchar(20),
    @RenglonID          int,
    @RenglonID2         int,
    @Sustituir          varchar(5),
    @TieneCaducidad     bit,
    @Propiedades        varchar(20),
    @UnidadCompra       varchar(20),
    @Factor             float,
    @Unidad             varchar(20),
    @ArtSerieLoteInfo   bit,
    @Renglon            float,
    @RenglonSub         int,
    @CantidadLote       float

  DECLARE @Tabla Table(
    Cuenta              varchar(20),
    SubCuenta           varchar(50),
    Descripcion         varchar(100),
    Unidad              varchar(20),
    TieneCaducidad      bit,
    CaducidadMinima     int
  )

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @ModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ModuloID'

  SELECT @Mov= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

   SELECT @CB = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Codigo'

  SELECT @Cantidad = CONVERT(float, Valor) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro') --28Mar2014
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Cantidad'

  SELECT @Referencia = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Referencia'

  SELECT @Serie = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Serie'

  SELECT @Sustituir = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sustituir'

  SELECT @TieneCaducidad = CONVERT(bit, Valor) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'TieneCaducidad'

  SET @FechaCaducidad = NULL
  IF @TieneCaducidad = 1 
    SELECT @FechaCaducidad = CONVERT(datetime, Valor) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'FechaCaducidad'

  SELECT @Propiedades = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Propiedades'

  SELECT @Renglon = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Renglon'

  SELECT @RenglonSub = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'RenglonSub'

  SELECT @RenglonID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'RenglonID'

  INSERT @Tabla(Cuenta,SubCuenta,Descripcion,Unidad,TieneCaducidad,CaducidadMinima)
  SELECT c.Cuenta,c.SubCuenta,a.Descripcion1,c.Unidad,a.TieneCaducidad,a.CaducidadMinima
    FROM CB c
    JOIN Art a ON c.Cuenta = a.Articulo
   WHERE c.Codigo = @CB 

  SELECT @ID2 = ID,
         @Sucursal = Sucursal
    FROM Compra
   WHERE ID = @ModuloID
  

  IF ISNULL(@CB,'') = '' SET @Ok = 72043 --BUG5752
  IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM CB WHERE Codigo = @CB) SET @Ok = 72040

  IF @Ok IS NULL
  BEGIN
    
    --BUG6249
    SELECT @Fecha = GETDATE()

    SELECT @Articulo = Cuenta,
           @SubCuenta = ISNULL(SubCuenta,''),
           @UnidadCompra = Unidad
      FROM CB
     WHERE Codigo = @CB 
     
    SELECT @Caducidad = ISNULL(CaducidadMinima,0),
           @Tipo = Tipo,
           @ArtSerieLoteInfo = SerieLoteInfo
      FROM Art
     WHERE Articulo = @Articulo

    IF NOT EXISTS(SELECT * FROM Compra c JOIN CompraD d ON c.ID = d.ID WHERE c.Empresa = @Empresa AND c.Mov = @Mov AND c.MovID = @MovID AND d.Articulo = @Articulo AND d.Unidad = @UnidadCompra)--BUG 23215
      SELECT @Ok =10530

    IF @Ok IS NULL AND @TieneCaducidad = 1 AND @FechaCaducidad IS NULL SET @Ok = 25125
    IF @Ok IS NULL AND @TieneCaducidad = 1 AND @FechaCaducidad < (@Fecha + @Caducidad) SET @Ok = 25126
    IF @Ok IS NULL AND LTRIM(RTRIM(ISNULL(@Referencia,''))) = '' SET @Ok = 80201
    
    --IF @Ok IS NULL
    --BEGIN
    --  BEGIN TRANSACTION
                  
    --  IF NOT EXISTS(SELECT * FROM FechaCaducidadMovil WHERE Empresa = @Empresa AND Modulo = 'COMS' AND ID = @ModuloID AND RenglonID = @RenglonID)
    --    INSERT FechaCaducidadMovil 
    --           (Empresa, Modulo, ID, RenglonID, Articulo,SubCuenta, Cantidad, FechaCaducidad,Procesado)
    --    SELECT @Empresa, 'COMS', @ModuloID, @RenglonID, @Articulo, @SubCuenta, @Cantidad, @FechaCaducidad, 0
    --  ELSE
    --    UPDATE FechaCaducidadMovil 
    --       SET FechaCaducidad = @FechaCaducidad, Cantidad = ISNULL(Cantidad,0) + ISNULL(@Cantidad,0) 
    --     WHERE Empresa = @Empresa 
    --       AND Modulo = 'COMS' 
    --       AND ID = @ModuloID
    --END  

    --- RJP 23092010 Actualizar la Referencia de la Factura para que la Entrada de compra se genere con la misma
    BEGIN TRANSACTION

    IF @OK IS NULL
    BEGIN
    	
    	UPDATE Compra SET Idioma = @Referencia WHERE ID = @ModuloID
    	UPDATE CompraD 
         SET FechaCaducidad = @FechaCaducidad
       WHERE ID = @ModuloID
         AND renglon = @Renglon
         AND RenglonSub = @RenglonSub
         AND RenglonID = @RenglonID
    END
    
    IF @Ok IS NULL -- AND @Sustituir = 'No'
    BEGIN
      --SELECT @Cantidad2 =CantidadA, @RenglonID = RenglonID , @UnidadCompra=Unidad FROM CompraD WHERE  ID = @ID2 AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'')  --BUG 20604
      SELECT @Cantidad2  = CantidadA
        FROM CompraD
       WHERE ID = @ModuloID
         AND Renglon = @Renglon
         AND RenglonSub = @RenglonSub
         AND RenglonID = @RenglonID
      
      IF UPPER(LTRIM(RTRIM(@Sustituir))) = 'SI'
      BEGIN
        IF @Tipo = 'Normal'
        BEGIN
          UPDATE CompraD
             SET CantidadA = ISNULL(@Cantidad,0)--, CantidadInventario=@Cantidad*@Factor
           WHERE ID = @ModuloID
             AND Renglon = @Renglon
             AND RenglonSub = @RenglonSub
             AND RenglonID = @RenglonID
           --AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Unidad = @UnidadCompra
        END

        IF @Tipo = 'Lote'
        BEGIN
          UPDATE SerieLoteMov
             SET Cantidad = @Cantidad
           WHERE Empresa = @Empresa 
             AND Modulo = 'COMS'
             AND ID = @ModuloID
             AND RenglonID = @RenglonID
             AND Articulo = @Articulo
             AND SubCuenta = @SubCuenta
             AND SerieLote = @Serie
             AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'')

           IF NOT EXISTS(SELECT * FROM SerieLoteMov WHERE ID = @ModuloID AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @Serie AND Modulo = 'COMS' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,''))
             INSERT SerieLoteMov (Empresa, Modulo,   ID,  RenglonID,  Articulo,  SubCuenta, SerieLote,  Cantidad, CantidadAlterna, Propiedades,             Ubicacion, Cliente, Localizacion,  Sucursal, ArtCostoInv)
             SELECT                    @Empresa,'COMS', @ID2, @RenglonID, @Articulo, @SubCuenta,    @Serie, @Cantidad,            NULL, ISNULL(@Propiedades,''),      NULL,    NULL,         NULL, @Sucursal,        NULL

          SELECT @CantidadLote = SUM(ISNULL(Cantidad,0))
            FROM SerieLoteMov
           WHERE ID = @ModuloID
             AND RenglonID = @RenglonID
             AND Articulo = @Articulo
             AND SubCuenta = @SubCuenta
             AND SerieLote = @Serie
             --AND SerieLote = @Serie
             AND Modulo = 'COMS'
             AND Empresa = @Empresa
             AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'')

          UPDATE CompraD
             SET CantidadA = ISNULL(@CantidadLote,0)  --, CantidadInventario=@Cantidad*@Factor
           WHERE ID = @ModuloID
             AND Renglon = @Renglon
             AND RenglonSub = @RenglonSub
             AND RenglonID = @RenglonID 
           --AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Unidad = @UnidadCompra
        END

        IF @@ERROR <> 0 SET @Ok = 1
      END

      IF UPPER(LTRIM(RTRIM(@Sustituir))) = 'NO'
      BEGIN
        UPDATE CompraD
           SET CantidadA = ISNULL(@Cantidad2,0.0) + @Cantidad--, CantidadInventario= (ISNULL(@Cantidad2,0.0)+@Cantidad)*@Factor
         WHERE ID = @ModuloID
           AND Renglon = @Renglon
           AND RenglonSub = @RenglonSub
           AND RenglonID = @RenglonID
         --AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND Unidad = @UnidadCompra

        IF @Tipo = 'Lote'
        BEGIN
          IF EXISTS(SELECT * FROM SerieLoteMov WHERE ID = @ModuloID AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @Serie AND Modulo = 'COMS' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,''))
              UPDATE SerieLoteMov SET Cantidad =  ISNULL(Cantidad,0) + ISNULL(@Cantidad,0)
               WHERE ID = @ModuloID
                 AND RenglonID = @RenglonID
                 AND Articulo = @Articulo
                 AND SubCuenta = @SubCuenta
                 AND SerieLote = @Serie
                 AND Modulo = 'COMS'
                 AND Empresa = @Empresa
                 AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'')
          ELSE
              INSERT SerieLoteMov(
                     Empresa, Modulo, ID, RenglonID, Articulo,
                     SubCuenta, SerieLote, Cantidad, CantidadAlterna, Propiedades,
                     Ubicacion, Cliente, Localizacion, Sucursal, ArtCostoInv)
              SELECT @Empresa, 'COMS', @ID2, @RenglonID, @Articulo,
                     @SubCuenta, @Serie, @Cantidad, NULL, ISNULL(@Propiedades,''),
                     NULL, NULL, NULL, @Sucursal, NULL	
        END

      END

      IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

      IF @Ok IS NULL AND @Tipo IN ('Serie', 'Lote') AND ISNULL(RTRIM(LTRIM(@Serie)),'') = '' AND @ArtSerieLoteInfo = 0 --BUG5733
        SET @Ok = 20051

      --BUG5689
      IF @Ok IS NULL AND @Cantidad NOT IN (0,1) AND @Tipo IN ('Serie') AND ISNULL(RTRIM(LTRIM(@Serie)),'') <> '' --BUG5733
        SET @Ok = 20332 --BUG5741         --SET @Ok = 20052

      IF @Ok IS NULL AND @Tipo IN ('Serie', 'Lote') AND ISNULL(RTRIM(LTRIM(@Serie)),'') <> ''  --BUG5733
      BEGIN
        /*
          SELECT @RenglonID = ISNULL(MAX(RenglonID),0) FROM SerieLoteMov WHERE Modulo = 'COMS' AND ID = @ID2 AND Articulo = @Articulo
          IF @RenglonID = 0
            SELECT @RenglonID = ISNULL(MAX(RenglonID),0) FROM SerieLoteMov WHERE Modulo = 'COMS' AND ID = @ID2
          IF NOT EXISTS(SELECT * FROM SerieLoteMov WHERE Modulo = 'COMS' AND ID = @ID2 AND Articulo = @Articulo)
            SELECT @RenglonID = @RenglonID + 1
        */
        
        --IF @Caducidad = 0
        --  SELECT @RenglonID = ISNULL(MAX(RenglonID),0) FROM CompraD WHERE ID = @ModuloID AND Articulo = @Articulo
        --ELSE
        --  SELECT @RenglonID = RenglonID FROM FechaCaducidadMovil WHERE ID = @ModuloID AND Articulo = @Articulo AND FechaCaducidad = @FechaCaducidad

        IF @Tipo IN ('Serie')
        BEGIN
          IF @Sustituir = 'No'
          BEGIN
            IF NOT EXISTS(SELECT * FROM SerieLoteMov WHERE ID = @ModuloID AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @Serie AND Modulo = 'COMS' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,''))
                INSERT SerieLoteMov (Empresa, Modulo,   ID,  RenglonID,  Articulo,  SubCuenta, SerieLote,  Cantidad, CantidadAlterna, Propiedades,            Ubicacion, Cliente, Localizacion,  Sucursal, ArtCostoInv)
                  SELECT                 @Empresa, 'COMS', @ID2, @RenglonID, @Articulo, @SubCuenta,    @Serie, @Cantidad,            NULL, ISNULL(@Propiedades,''),     NULL,    NULL,         NULL, @Sucursal,        NULL
            ELSE
              SELECT @Ok = 20080
          END
        END

      END
    END
  END

  SELECT @Texto =ISNULL((SELECT Cuenta, SubCuenta, Descripcion, TieneCaducidad, CaducidadMinima, @UnidadCompra as Unidad, @Sustituir as Sustituir FROM @Tabla ArtCB
                   FOR XML AUTO),'')

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
  END

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'

END
GO


--/************** spIntelisisWMSActualizarCantidadRecibida****************/
--if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSActualizarCantidadRecibida')           AND type = 'P') drop procedure dbo.spIntelisisWMSActualizarCantidadRecibida
--GO             
--CREATE PROCEDURE spIntelisisWMSActualizarCantidadRecibida
--		@ID				int,
--		@iSolicitud		int,
--		@Version		float,
--		@Resultado		varchar(max) = NULL OUTPUT,
--		@Ok				int = NULL OUTPUT,    
--		@OkRef			varchar(255) = NULL OUTPUT

----//WITH ENCRYPTION
--AS BEGIN
--  -- SET nocount ON
--  DECLARE 
--		@ID2                int,
--		@Empresa            varchar(5),
--		@Mov                varchar(20),
--		@CB                 varchar(30),
--		@Cantidad           float,
--		@Cantidad2           float,
--	    @MovID  			varchar(20),
--	    @Articulo 			varchar(20),
--	    @SubCuenta 			varchar(50),
--		@Texto				xml,
--		@ReferenciaIS		varchar(100),
--		@SubReferencia		varchar(100),
--		@Caducidad          datetime,
--		@FechaCaducidad     int,
--		@Fecha              datetime,
--		@Verifica           int,
--		@Verifica2          int,
--		@Sucursal           int
		
--  SELECT  @Empresa   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
--    WITH (Campo varchar(255), Valor varchar(255))
--   WHERE Campo = 'Empresa'
--  SELECT  @Mov= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
--    WITH (Campo varchar(255), Valor varchar(255))
--   WHERE Campo = 'Mov'
--  SELECT  @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
--    WITH (Campo varchar(255), Valor varchar(255))
--   WHERE Campo = 'MovID'   
--   SELECT  @CB = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
--    WITH (Campo varchar(255), Valor varchar(255))
--   WHERE Campo = 'Codigo'  
--  SELECT  @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
--    WITH (Campo varchar(255), Valor varchar(255))
--   WHERE Campo = 'Cantidad' 
  
 
--  IF @@ERROR <> 0 SET @Ok = 1
--  BEGIN 
--    SELECT @ReferenciaIS = Referencia 
--      FROM IntelisisService 
--     WHERE ID = @ID
--    IF @@ERROR <> 0 SET @Ok = 1
    
--    SELECT @ID2 = ID FROM Compra WHERE  Mov=@Mov AND MovID =@MovID AND Empresa=@Empresa
--    SELECT @Articulo = Cuenta,@SubCuenta=SubCuenta FROM CB WHERE Codigo = @CB
--    SELECT @Cantidad2 =CantidadA FROM CompraD WHERE  ID = @ID2 AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta,'') 
    
    
--    UPDATE CompraD
    
--       SET CantidadA = ISNULL(@Cantidad2,0.0)+@Cantidad
--     WHERE ID = @ID2 AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta,'') 
--    IF @@ERROR <> 0 SET @Ok = 1
--    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

--      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '></Resultado></Intelisis>'
--      IF @@ERROR <> 0 SET @Ok = 1
    
--  END
--END
--GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.ActualizarCantidadRecibida" SubReferencia="" Version="1.0"><Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--    <Parametro Campo="Empresa" Valor="DEMO"/> 
--    <Parametro Campo="Mov" Valor="Orden Compra"/>      
--    <Parametro Campo="MovID" Valor="3"/> 
--    <Parametro Campo="Codigo" Valor="3123123123123"/> 
--    <Parametro Campo="Cantidad" Valor="10"/> 
--    </Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select @Resultado,@Ok,@OkRef
--GO

--BUG24419
/************** spIntelisisWMSInfoCB ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoCB') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoCB
GO             
CREATE PROCEDURE spIntelisisWMSInfoCB
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
		
		@Empresa            varchar(5),
		@Referencia         varchar(50), --RJP 23092010 Se agrega campo para capturar la Referencia
		@ID2                 int,
		@Mov                varchar(20),
		@CB                varchar(30),
		@Anden                varchar(20),
	    @MovID  			varchar(20),
	    @Articulo 			varchar(20),
	    @SubCuenta 			varchar(50),
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@UsuarioSucursal    bit,
		@Cantidad           float,
		@Caducidad          int,
		@FechaCaducidad     datetime,
		@Fecha              datetime,
		@Sucursal			int,
		@Cantidad2          float,
		@Tipo				varchar(20),
		@Serie				varchar(20),
		@RenglonID			int,
		@RenglonID2			int,
		@Sustituir          varchar(5),
		@TieneCaducidad		bit,
		@Propiedades		varchar(20),
		@UnidadCompra       varchar(20) --PGC06122013
		
  DECLARE
   

  @Tabla Table(
  Cuenta                  varchar(20),
  SubCuenta               varchar(50),
  Descripcion             varchar(100),
  Unidad                  varchar(20),
  TieneCaducidad          bit,
  CaducidadMinima         int,
  CantidadPresentacion    float,
  Presentacion            varchar(50) NULL,
  Factor                  float,
  CantidadCamaTarima      int NULL,
  CamasTarima             int NULL,
  Amarre                  int NULL
  )			

  
  SELECT  @Empresa   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'
  SELECT  @Mov= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'
  SELECT  @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'   
   SELECT  @CB = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Codigo'  
  --RJP 23092010 Se agrega nuevo parámetro para la Referencia de la Factura
  SELECT  @Referencia = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Referencia' 
  SELECT  @Serie = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Serie'
  SELECT  @Sustituir = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sustituir'
  SELECT  @FechaCaducidad = CONVERT(datetime, Valor) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'FechaCaducidad'
  SELECT  @Propiedades = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Propiedades'


  --SELECT @ID2 = ID FROM Compra WHERE  Mov=@Mov AND MovID =@MovID AND Empresa=@Empresa
  IF NOT EXISTS(SELECT * FROM CB WHERE Codigo = @CB)SET @Ok = 72040

  IF @Ok IS NULL
  BEGIN
	SELECT @Articulo = Cuenta, @SubCuenta=ISNULL(SubCuenta,'') FROM CB WHERE Codigo = @CB   

    --EWQ. Tuning
	IF NOT EXISTS(SELECT * FROM Compra c JOIN CompraD d ON c.ID = d.ID WHERE c.Empresa = @Empresa AND c.Mov = @Mov AND c.MovID = @MovID AND d.Articulo = @Articulo) SELECT @Ok =10530

	SELECT @Fecha = GETDATE()
	SELECT @Caducidad =ISNULL(CaducidadMinima,0), @TieneCaducidad = ISNULL(TieneCaducidad,0)  FROM Art WHERE Articulo = @Articulo

	--REQ14032014. Validar que si el articulo tiene caducidad y la fecha de caducidad viene en NULL, enviar mensaje al móvil
	IF @TieneCaducidad = 1 AND @FechaCaducidad='99981231' SELECT @Ok=25125 --(Mensaje de Error: 'Es Necesario Especificar la Fecha de Caducidad')

	--- RJP 23092010 Actualizar la Referencia de la Factura para que la Entrada de compra se genere con la misma
	IF @Referencia = '' or @Referencia is NULL SET @Ok = 80201
  END
	
    --25032014. Solicitud para que se muestre esto después de capturar el a´rticulo:
    -- Descripción (Descripcion1 de Tabla Art)
    -- Capacidad (CantidadPresentacion + Presentacion de Tabla Art)
    -- Factor de Empaque (Factor en tabla ArtUnidad donde Unidad sea igual a UnidadCompra de tabla Art)
    -- Cajas x Tarima (5 x 10) (CantidadCamaTarima y CamasTarima de Tabla Art)
    -- Amarre (50) (Total de Cajas por tarima) (Resultado de CamasTarima X CantidadCamaTarima  de tabla Art)

  --SELECT CantidadPresentacion, Presentacion, CantidadCamaTarima, CamasTarima FROM Art
  --SELECT * FROM ArtUnidad

  IF @Ok IS NULL
    BEGIN	  
      --EWQ. Tuning
      INSERT @Tabla(Cuenta, SubCuenta,               Descripcion,                                    Unidad,               TieneCaducidad,              CaducidadMinima,              CantidadPresentacion,              Presentacion,               Factor,              CantidadCamaTarima,              CamasTarima,              Amarre)
      SELECT      c.Cuenta, ISNULL(c.SubCuenta, ''), ISNULL(a.Descripcion1, '')+'      Clave:'+RTRIM(c.Cuenta)+'.', ISNULL(c.Unidad, ''), ISNULL(a.TieneCaducidad, 0), ISNULL(a.CaducidadMinima, 0), ISNULL(a.CantidadPresentacion, 0), ISNULL(a.Presentacion, ''), ISNULL(au.Factor,0), ISNULL(a.CantidadCamaTarima, 0), ISNULL(a.CamasTarima, 0), ISNULL(a.CantidadCamaTarima*a.CamasTarima, 0)
        FROM CB c JOIN Art a ON c.Cuenta = a.Articulo
	    JOIN ArtUnidad au ON AU.Articulo=a.Articulo AND au.Unidad=a.UnidadCompra
       WHERE  c.Codigo = @CB 
    END    

  SELECT @Texto =ISNULL((SELECT Cuenta, SubCuenta, Descripcion, TieneCaducidad, CaducidadMinima, Unidad,
                         CONVERT(varchar, CantidadPresentacion) CantidadPresentacion, Presentacion, 
						 CONVERT(varchar, Factor) Factor, 
						 CONVERT(varchar, CantidadCamaTarima) CantidadCamaTarima, 
						 CONVERT(varchar, CamasTarima) CamasTarima, 
						 CONVERT(varchar, Amarre) Amarre
						 FROM @Tabla FOR XML AUTO),'')

  IF @Texto IS NULL
	SELECT @Ok = 10530, @OkRef=''

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1  
   
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
	SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END

END
GO

--BUG24423
/************** spIntelisisWMSAfectarOC ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSAfectarOC')           AND type = 'P') drop procedure dbo.spIntelisisWMSAfectarOC
GO   
CREATE PROCEDURE spIntelisisWMSAfectarOC
  @ID    int,      
  @iSolicitud  int,      
  @Version  float,      
  @Resultado  varchar(max) = NULL OUTPUT,      
  @Ok    int = NULL OUTPUT,          
  @OkRef   varchar(255) = NULL OUTPUT      
      
--//WITH ENCRYPTION      
AS BEGIN      
  -- SET nocount ON      
  DECLARE       
  @ID2                int,      
  @IDGenerar          int,      
  @IDAcceso           int,      
  @Estacion           int,      
  @Empresa            varchar(5),      
  @Mov                varchar(20),      
  @Mov2                varchar(20),      
  @Usuario            varchar(20),      
  @CB                 varchar(30),      
  @Cantidad           float,      
  @MovID              varchar(20),
  @Articulo           varchar(20),      
  @SubCuenta          varchar(50),      
  @Texto              xml,      
  @ReferenciaIS       varchar(100),      
  @SubReferencia      varchar(100),      
  @Caducidad          datetime,      
  @FechaCaducidad     int,      
  @Fecha              datetime,      
  @Verifica           int,      
  @Verifica2          int,      
  @Sucursal           int,      
  @Partidas           int, /*RJP 171110 Cuenta partidas con CantidadA > 0*/      
  @Referencia         varchar (50), ---- RJP 18112010 Referencia de la Entrada de Compra      
  @RenglonID          float,      
  @RenglonID2         float,      
  @RenglonSub         int,      
  @Renglon            int,      
  @Renglon2           int,      
  @Cantidad2          float,      
  @FechaCaducidad2    datetime,    

  @StrSQL             nvarchar(max),    
  @EsSSFA             varchar(2),    
  @TipoDocSF          varchar(10),    
  @FacturaSF          varchar(20),      
  @FechaFacturaSF     varchar(8),    
  @SubTotalSF         money,    
  @IEPSSF             money,    
  @IVASF              money,    
  @ImporteTotalSF     money,
  @Moneda			        varchar(10),    
  @TipoCambio		      float,
  @FechaEmision		    datetime,
  @Parametros		      nvarchar(max),
  @ArticuloCaducidad  varchar(20)

  DECLARE @TipoEntradaGenerar varchar(100) --BUG5977
  DECLARE @AndenRecibo varchar(10)
    
  SELECT @Parametros = '@ID					int, 
						@Empresa			varchar(5), 
						@Usuario			varchar(10), 
						@Mov				varchar(20), 
						@Moneda				varchar(10), 
						@TipoCambio			float, 
						@FechaEmision		datetime, 
						@Ok					int				OUTPUT, 
						@OkRef				varchar(255)	OUTPUT'

  BEGIN TRANSACTION       
  --EWQ. Tuning  
  --SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)          
  --SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso      
  SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion  
          
        
  SELECT  @Empresa   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'Empresa'      
  
  --EWQ. Tuning  
  SELECT  @Usuario = Usuario FROM IntelisisService WHERE ID = @ID  
    
  --SELECT  @Usuario = NULLIF(Usuario,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')       
  --  WITH(Usuario   varchar(255))         
  
  SELECT  @Mov= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'Mov'      
  SELECT  @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'MovID'         
    
  SELECT  @EsSSFA = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'EsSSFA'         
  SELECT  @TipoDocSF = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'TipoDocSF'   
   SELECT  @FacturaSF = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'FacturaSF'   
          
   --SELECT  @FechaFacturaSF = CONVERT(datetime, Valor) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')    
   SELECT  @FechaFacturaSF = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')    
    WITH (Campo varchar(255), Valor varchar(255))     
   WHERE Campo = 'FechaFacturaSF'      
     
   --TASK19875   
   SELECT  @SubTotalSF = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'SubTotalSF'        
   SELECT  @IEPSSF = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'IEPSSF'         
   SELECT  @IVASF = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'IVASF'         
   
   SELECT  @ImporteTotalSF = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'ImporteTotalSF'    

   SELECT  @TipoEntradaGenerar = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'TipoEntradaGenerar'    

  SELECT @AndenRecibo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')      
    WITH (Campo varchar(255), Valor varchar(255))      
   WHERE Campo = 'AndenRecibo'    
   
  IF @@ERROR <> 0 SET @Ok = 1      
  BEGIN       
        
    SELECT @ReferenciaIS = Referencia       
      FROM IntelisisService       
     WHERE ID = @ID      
    IF @@ERROR <> 0 SET @Ok = 1      
          
    SELECT @ID2 = ID FROM Compra WHERE  Mov=@Mov AND MovID=@MovID AND Empresa=@Empresa      
      
    /*RJP 171110 Valida que existan partidas recibidas para que la entrada de compra no se genere vacia*/      
    IF @OK is NULL      
    BEGIN      
       SELECT @Partidas = count(ID) FROM CompraD WHERE ID = @ID2  AND (CantidadA > 0 or CantidadA is not null)      
             
       --SELECT * FROM Compra      
       --SELECT * FROM CompraD WHERE ID = 61      
             
       --SELECT Partidas = count(ID) FROM CompraD WHERE ID = 61  AND (CantidadA > 0 or CantidadA is not null)      
             
    IF @Partidas = 0       
       SET @OK = 60010 ---No hay nada que afectar      
    END     
	 
    /*RJP 171110 Valida que existan partidas recibidas para que la entrada de compra no se genere vacia*/      
     
 --- RJP 06sep2010 Traer solo el primer movimiento que tenga la clave de afectación COMS.F      
 --- RJP 17Nov2010 Se condiciona la Generación de la Entrada de Compra, solo si no se ha incurrido en error      
 IF @Ok IS NULL      
 BEGIN            
     
      --IF @TipoEntradaGenerar = 'Entrada Compra'
      --BEGIN
      --  SELECT @Mov2 = CompraEntrada FROM EmpresaCfgMov WHERE Empresa = @Empresa
      --END
      
      --IF @TipoEntradaGenerar = 'Entrada Compra con Gastos'
      --BEGIN
      --  SELECT @Mov2 = CompraEntradaGastos FROM EmpresaCfgMov WHERE Empresa = @Empresa
      --END
              
      --IF @TipoEntradaGenerar = 'Entrada Importación'
      --BEGIN
      --  SELECT @Mov2 = CompraEntradaImportacion FROM EmpresaCfgMov WHERE Empresa = @Empresa
      --END
      SET @Mov2 = @TipoEntradaGenerar

         --EWQ. Tuning
       EXEC  @IDGenerar=spAfectar 'COMS', @ID2, 'GENERAR', 'Seleccion', @Mov2, @Usuario, @Estacion=@Estacion, @EnSilencio=1, @Conexion=1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT        

       --EXEC  @IDGenerar=spAfectar 'COMS', @ID2, 'GENERAR', 'Seleccion', @Mov, @Usuario, @Estacion=@Estacion, @EnSilencio=1, @Conexion=0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT        
       IF @Ok BETWEEN 80030 AND 81000
	     IF @Ok<>60010 --BUG5669
		      SELECT @Ok = NULL      
    END      
    --SELECT 'IDGenerar-->'+CAST(@IDGenerar AS VARCHAR)      
 --- RJP 17Nov2010 Se condiciona la Generación de la Entrada de Compra, solo si no se ha incurrido en error      
      
    --EWQ. Tuning2
    --SELECT * FROM FechaCaducidadMovil      
    DECLARE crRenglon CURSOR LOCAL FOR      
     SELECT d.Renglon, d.RenglonSub, f.Cantidad, f.FechaCaducidad, f.Articulo
       FROM FechaCaducidadMovil f      
       JOIN CompraD d ON f.ID = d.ID AND f.Articulo = d.Articulo      
      WHERE d.ID = @ID2      
        AND f.Procesado = 0      
        AND f.Cantidad > 0      
      
    OPEN crRenglon 
    --EWQ. Tuning2     
    FETCH NEXT FROM crRenglon INTO @Renglon, @RenglonSub, @Cantidad2, @FechaCaducidad2, @ArticuloCaducidad
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL      
    BEGIN 
      --EWQ. Tuning2         
--      SELECT * INTO #CompraDetalle FROM cCompraD WHERE ID = @IDGenerar AND Renglon = @Renglon AND RenglonSub = @RenglonSub      
--      IF @@ERROR <> 0 SELECT @Ok = 1      
  
      --EWQ. Tuning
      --EWQ. Tuning2
	    --IF @FechaCaducidad2>GETDATE() --TASK4606 UserStory4436
          UPDATE CompraD SET FechaCaducidad = @FechaCaducidad2 WHERE ID = @IDGenerar AND Articulo = @ArticuloCaducidad AND Cantidad = @Cantidad2 --AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND FechaCaducidad IS NULL --BUG10594      

      --EWQ. Tuning2     
--      IF @@ROWCOUNT = 0                 
--      BEGIN      
--        --UPDATE #CompraDetalle SET Renglon = (SELECT ISNULL(MAX(Renglon),0) FROM CompraD WHERE ID = @IDGenerar) + 2048, RenglonID = (SELECT ISNULL(MAX(RenglonID),0) FROM CompraD WHERE ID = @IDGenerar) + 1, Cantidad = @Cantidad2, FechaCaducidad = @FechaCaducidad2      
--        UPDATE #CompraDetalle SET Renglon = (SELECT ISNULL(MAX(Renglon),0) FROM CompraD WHERE ID = @IDGenerar) + 2048, RenglonID = (SELECT ISNULL(MAX(RenglonID),0) FROM CompraD WHERE ID = @IDGenerar) + 1, Cantidad = @Cantidad2, CantidadInventario = @Cantidad2, FechaCaducidad = @FechaCaducidad2 --BUG10594      
--        IF @@ERROR <> 0 SELECT @Ok = 1      
--            
--      --  IF NOT EXISTS(SELECT * FROM CompraD WHERE ID = @IDGenerar AND Renglon = @Renglon + 2048 AND RenglonSub = @RenglonSub)      
--        INSERT INTO cCompraD SELECT * FROM #CompraDetalle      
--        IF @@ERROR <> 0 SELECT @Ok = 1      
--      END      
--      
--      DROP TABLE #CompraDetalle      
--      IF @@ERROR <> 0 SELECT @Ok = 1      
      --EWQ. Tuning2
      FETCH NEXT FROM crRenglon INTO @Renglon, @RenglonSub, @Cantidad2, @FechaCaducidad2, @ArticuloCaducidad
    END      
    CLOSE crRenglon      
    DEALLOCATE crRenglon        

   -- DELETE SerieLoteMov WHERE ID = @IDGenerar AND Modulo = 'COMS'      
          
   -- SELECT @RenglonID = MAX(RenglonID)      
   --   FROM SerieLoteMovMovil      
   --  WHERE ID = @ID2      
   --    AND Modulo = 'COMS'      
   --    AND Empresa = @Empresa      
   --    AND Cantidad > 0      

   -- DECLARE crRenglonID CURSOR LOCAL FOR      
   --  SELECT RenglonID      
   --    FROM SerieLoteMovMovil      
   --   WHERE ID = @ID2      
   --     AND Procesado = 0      
   --     AND Cantidad > 0      
             
   -- OPEN crRenglonID      
   -- FETCH NEXT FROM crRenglonID INTO @RenglonID2      
   -- WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL      
   -- BEGIN      
   --   INSERT INTO SerieLoteMov (Empresa,  Modulo,   ID,         RenglonID,                        Articulo,   SubCuenta,   SerieLote,   Cantidad,                      CantidadAlterna,   Propiedades,   Ubicacion,   Cliente,   Localizacion,   Sucursal,   ArtCostoInv)      
	  --SELECT                   s.Empresa, s.Modulo, @IDGenerar, s.RenglonID, s.Articulo, s.SubCuenta, s.SerieLote, s.Cantidad, s.CantidadAlterna, s.Propiedades, s.Ubicacion, s.Cliente, s.Localizacion, s.Sucursal, s.ArtCostoInv      
   --     FROM SerieLoteMovMovil s      
   --    WHERE s.ID = @ID2      
   --      AND s.Procesado = 0      
   --      AND s.Cantidad > 0      
   --      AND s.RenglonID = @RenglonID2      
   --      AND s.Modulo = 'COMS'      
   --      AND s.Empresa = @Empresa     
		
   --   UPDATE SerieLoteMovMovil SET Procesado = 1 WHERE ID = @ID2 AND Procesado = 0 AND RenglonID = @RenglonID2      
      
   --   FETCH NEXT FROM crRenglonID INTO @RenglonID2      
   -- END      
   -- CLOSE crRenglonID      
   -- DEALLOCATE crRenglonID            
      
   -- UPDATE FechaCaducidadMovil SET Procesado = 1 WHERE ID = @ID2
         
    
  IF @Ok IS NULL  
    UPDATE Compra SET Usuario = @Usuario WHERE ID = @IDGenerar  
      
  --TASK19875   
  --SOLO PARA SSFA           
  IF @Ok IS NULL AND @EsSSFA='SI'    
  BEGIN       
    SET @StrSQL='UPDATE Compra ' +                   
                'SET TipoDocSF=NULLIF(RTRIM(' +'''' + @TipoDocSF + '''), '''')' +    
                ', FacturaNumeroSF=NULLIF(RTRIM(' +'''' + @FacturaSF + '''), '''')' +    
                ', FechaFacturaSF=' +'''' + @FechaFacturaSF + '''' +    
                ', SubTotalSF='+ CAST(@SubTotalSF AS VARCHAR(10)) +    
                ', IEPSSF='+ CAST(@IEPSSF AS VARCHAR(10)) +    
                ', IVASF=' + CAST(@IVASF AS VARCHAR(10)) +    
                ', ImporteTotalSF=' + CAST(@ImporteTotalSF AS VARCHAR(10)) +    
                ' WHERE ID=' + CAST(@IDGenerar AS VARCHAR(10))   

    EXEC(@StrSQL)

    SELECT @Moneda = Moneda, @TipoCambio = TipoCambio, @FechaEmision = FechaEmision FROM Compra WHERE ID = @ID

    --BUG24313
    /*
    SELECT @StrSQL = 'EXEC xpASCompraValidarCaptura @ID, ''AFECTAR'', ''Todo'', @Empresa, @Usuario, ''COMS'', @Mov,'''',
													''COMS.F'',@Moneda,@TipoCambio,''SINAFECTAR'',''CONCLUIDO'',@FechaEmision,@Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT'

    EXEC sp_executesql @StrSQL, @Parametros, @IDGenerar, @Empresa, @Usuario, @Mov, @Moneda, @TipoCambio, @FechaEmision, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    */
  END

  --BUG24313
  IF @Ok IS NULL  --BUG5669      
  
    -- BUG5977 
    IF EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'COMS' AND Mov = @Mov2 AND Clave = 'COMS.EI')
      BEGIN
        UPDATE CompraD 
           SET ImportacionProveedor = b.Proveedor
          FROM CompraD a 
         INNER JOIN Compra b
            ON (a.Aplica = b.Mov AND a.AplicaID = b.MovID)
         WHERE a.ID = @IDGenerar
      END
    ELSE
      BEGIN
        UPDATE CompraD SET ImportacionProveedor = NULL WHERE ID = @IDGenerar
      END
  
     --EWQ. Tuning  
   --EXEC spAfectar 'COMS', @IDGenerar, 'CONSECUTIVO', NULL, NULL, @Usuario, @Estacion=@Estacion, @EnSilencio=1, @Conexion=1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT        

   -- jolmosh ----------------------------------------------------------------------
   -- BUG7779
   SELECT @Sucursal = Sucursal FROM Compra WHERE ID = @ID2
   SET @Sucursal = ISNULL(@Sucursal,0)
   
   DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'COMS' AND ID = @IDGenerar
   EXEC spMovCopiarSerielote @Sucursal, 'COMS', @ID2, @IDGenerar
   
   EXEC spReconstruirSerieLoteMov 'DEMO', 'COMS', @IDGenerar, @OK, @OKRef
   
   IF @OK IS NULL
     BEGIN
       -- Actualizar anden de recino en Entrada de Compra generada
       -- La Orden de compra permanece con su mismo anden de recibo (PosicionWMS)
       UPDATE Compra SET PosicionWMS = @AndenRecibo WHERE ID = @IDGenerar 

       EXEC spAfectar 'COMS', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion = @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
     END
   
   IF @OK IS NULL
     BEGIN
     	 DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'COMS' AND ID = @ID2
     END  
   ---------------------------------------------------------------------------------

    IF @Ok = 80060 SELECT @Ok = NULL
       
    --BUG 20602  
    IF @Ok=10060 AND @EsSSFA='SI'  
    BEGIN    
     SET @Ok = NULL    
     --EWQ. Tuning  
     SET @StrSQL='UPDATE Compra  
                  SET TipoDocSF=NULL,  
                FacturaNumeroSF=NULL,  
                FechaFacturaSF=NULL,  
                SubTotalSF=NULL,  
                IEPSSF=NULL,  
       IVASF=NULL,  
                ImporteTotalSF=NULL   
                   WHERE ID=' + CAST(@IDGenerar AS VARCHAR(10))   
      EXEC(@StrSQL)    
    END            

--SELECT * FROM CompraD WHERE ID = @IDGenerar      
--SELECT * FROM SerieLoteMov WHERE ID = @IDGenerar      
   --SELECT @Ok      
 --- RJP 18112010 Dejar nuevamente la referencia de la Orden de Compra vacia           
    IF @OK IS NULL  
    BEGIN  
       SELECT @Referencia = Idioma from compra      
       where ID = @ID2   ---- Obtiene la referencia guardada en la OC      
       UPDATE Compra set Referencia = @Referencia      
       Where ID = @IDGenerar   ---- Guarda la Referencia en la Entrada de Compra      
    --- RJP 18112010 Dejar nuevamente la referencia de la Orden de Compra vacia      
    END      
      
    IF @@ERROR <> 0 SET @Ok = 1      
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok      
      
    --EWQ. Tuning  
    IF @Ok IS NULL   
    BEGIN  
      --IF (SELECT Estatus FROM Compra WHERE ID = @IDGenerar) = 'SINAFECTAR'  
      --  SELECT @Ok = -1
      --ELSE  
      SELECT @OkRef = RTRIM(Mov)+' '+RTRIM(MovID) FROM Compra WHERE ID = @IDGenerar --BUG5669
	END
	ELSE
	  SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok      
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '></Resultado></Intelisis>'
    SET @Resultado = REPLACE(@Resultado,'<BR>','.')      

    IF @@ERROR <> 0 SET @Ok = 1      
      
--if @ok is null select @ok = 1      
            
  IF @Ok IS NULL OR @Ok = -1
  BEGIN      
    COMMIT TRANSACTION
  END ELSE      
  BEGIN      
    ROLLBACK TRANSACTION       
  END  
  
--/*      
  IF @Ok IS NOT NULL      
  BEGIN  
    DELETE FechaCaducidadMovil WHERE ID = @ID2 AND Modulo = 'COMS'      
    DELETE SerieLoteMovMovil WHERE ID = @ID2 AND Modulo = 'COMS'      
  END      
--*/      
  END      
END   
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.AfectarCOMS_O" SubReferencia="" Version="1.0"> <Solicitud>  <Parametro Campo="Empresa" Valor="DEMO" /> <Parametro Campo="Mov" Valor="Orden Compra" /> <Parametro Campo="MovID" Valor="1" /> </Solicitud> </Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select @Resultado,@Ok,@OkRef
--GO



/************** spIntelisisWMSInfoTarimasSurtidoP ****************/
 if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoTarimasSurtidoP') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoTarimasSurtidoP
GO             
CREATE PROCEDURE spIntelisisWMSInfoTarimasSurtidoP
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
		
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@Tarima                    varchar(20),
		@Posicion                  varchar(10) 
        
  DECLARE
  @Tabla Table(
  Tarima                    varchar(20),
  Articulo                  varchar(20),
  Cantidad                  varchar(100),
  Unidad                    varchar(20),  
  Posicion                  varchar(10),
  DescripcionPosicion       varchar(100),
  PosicionDestino           varchar(10),
  DescripcionPosicionDestino  varchar(100)
  
  )		
  
  SELECT  @Tarima  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'
 
 INSERT @Tabla(Tarima,Articulo,    Cantidad,     Unidad,   Posicion,DescripcionPosicion, PosicionDestino,DescripcionPosicionDestino) 
      SELECT d.Tarima,a.Articulo,CONVERT(varchar, a.Disponible),aa.UnidadCompra,d.Posicion,ISNULL(ap.Descripcion,''),    d.PosicionDestino,ISNULL(apd .Descripcion,'')
      FROM TMAD d JOIN TMA  t ON t.ID = d.ID
      JOIN MovTipo m ON m.Mov = t.Mov AND m.Modulo = 'TMA'
      JOIN ArtDisponibleTarima a ON a.Tarima = d.Tarima
      JOIN Art aa ON a.Articulo = aa.Articulo
      JOIN AlmPos ap ON ap.Posicion = d.Posicion
      JOIN AlmPos apd ON apd.Posicion = d.PosicionDestino
     WHERE  t.Estatus = 'PENDIENTE'
       AND  m.Clave='TMA.OSUR'
       AND m.SubClave='TMA.OSURP'
       AND d.CantidadA IN (NULL,0)
       AND (d.Procesado is null or d.Procesado = 0)
       AND d.Tarima = ISNULL(@Tarima,d.Tarima)
   
       
       
   
    
  SELECT @Texto =(SELECT * FROM @Tabla TMA
                   FOR XML AUTO)	

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      BEGIN
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    END
  END
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.InfoTarimasSurtidoPikingListado" SubReferencia="" Version="1.0"><Solicitud>
--      <Parametro Campo="Tarima" Valor="T71"/> 
 
--</Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO',null,@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--select convert(xml,@Resultado),@Ok,@OkRef
--GO




/************** spIntelisisWMSValidarCBOSURP****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSValidarCBOSURP')           AND type = 'P') drop procedure dbo.spIntelisisWMSValidarCBOSURP
GO             
CREATE PROCEDURE spIntelisisWMSValidarCBOSURP
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
		

	
		@CB                varchar(30),
	    @Articulo 			varchar(20),
	    @SubCuenta 			varchar(50),
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@UsuarioSucursal    bit,
		@Verifica           int,
		@Verifica2          int,
		@Sucursal         int,
		@Tarima             varchar(30),
		@Cantidad           float
		



  SELECT  @Articulo   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'
  
   SELECT  @CB = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Codigo'  
     
   SELECT  @SubCuenta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SubCuenta'  
   
  SELECT  @Tarima  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima' 

  SELECT  @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Cantidad'   
   
  IF NOT EXISTS(SELECT * FROM CB WHERE Codigo = @CB AND Cuenta = @Articulo AND SubCuenta = ISNULL(@SubCuenta,''))SET @Ok = 72040


  IF NOT EXISTS(SELECT * FROM TMAD d JOIN TMA  t ON t.ID = d.ID  JOIN MovTipo m ON m.Mov = t.Mov AND m.Modulo = 'TMA'
      JOIN ArtDisponibleTarima a ON a.Tarima = d.Tarima WHERE a.Articulo = @Articulo AND m.Clave='TMA.OSUR'AND m.SubClave='TMA.OSURP' AND a.Tarima=@Tarima AND a.Disponible <=@Cantidad)SET @Ok = 20020
  
  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '></Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.ValidarCB.OSURP" SubReferencia="" Version="1.0"><Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--    <Parametro Campo="Articulo" Valor="001"/> 
--    <Parametro Campo="SubCuenta" Valor=""/>      
--    <Parametro Campo="Codigo" Valor="3123123123123"/> 
--    <Parametro Campo="Tarima" Valor="T71"/>      
--    <Parametro Campo="Cantidad" Valor="10"/> 
--    </Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select @Resultado,@Ok,@OkRef
--GO

          
/**************** spISIntelisisTMAAfectarTMA_OSURP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisTMAAfectarTMA_OSURP') and type = 'P') drop procedure dbo.spISIntelisisTMAAfectarTMA_OSURP
GO
CREATE PROCEDURE spISIntelisisTMAAfectarTMA_OSURP
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
    @IDGenerar               int,
    @IDAcceso                int,
    @MovTipo                 varchar(20),
    @ReferenciaIS            varchar(100),
    @Usuario2                varchar(10),
    @Estacion                int,
    @SubReferencia           varchar(100),
    @Empresa                 varchar(5),
    @Mov                     varchar(20),
    @MovID                   varchar(20),
    @Mov2                    varchar(20),
    @Mov3                    varchar(20),
    @MovID2                  varchar(20),
    @Sucursal                int,
    @ID2                     int,
    @Tarima                  varchar(20),
    @Sucursal2               varchar(100),
    @Posicion                varchar(20),
    @PosicionDestino         varchar(20),
    @Usuario                 varchar(15),
    @Cantidad                float(20),
    @Estatus                 varchar(20),
    @Articulo                varchar(20),
    @SubClave                varchar(20),
    @Procesado               bit,
    @Montacargas             varchar(20),
    @Agente                  varchar(20),
    @CB                      varchar(30),
    @SubCuenta               varchar(50),
    @Unidad                  varchar(20),
    @UnidadCompra            varchar(20),
    @Factor                  float ,
    @Almacen                 varchar(20),
    @Disponible              float,
    @Renglon                 float

  BEGIN TRANSACTION
  SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion
  IF @Ok IS NULL
  BEGIN
     SELECT  @Empresa = NULLIF(Empresa,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
       WITH(Empresa    varchar(255))
     SELECT  @MovID = NULLIF(MovID,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
       WITH(MovID    varchar(255))
     SELECT  @Mov= NULLIF(Mov,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
       WITH(Mov    varchar(255))
     SELECT  @Tarima = NULLIF(Tarima,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
       WITH(Tarima   varchar(255))
     SELECT  @Articulo = NULLIF(Articulo,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
       WITH(Articulo   varchar(255))
     SELECT  @Cantidad = CONVERT(float,Cantidad)FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
       WITH(Cantidad   varchar(255))
     SELECT  @Usuario = NULLIF(Usuario,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
       WITH(Usuario   varchar(255))
     SELECT  @Sucursal2 = NULLIF(Sucursal,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
       WITH(Sucursal   varchar(255))
     SELECT  @Montacargas = NULLIF(Montacarga,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
       WITH(Montacarga   varchar(255))
     SELECT  @SubCuenta = NULLIF(SubCuenta ,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
       WITH(SubCuenta    varchar(255))
     --SELECT  @CB = NULLIF(Codigo,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
     --  WITH(Codigo   varchar(255))
     SELECT  @Unidad = NULLIF(Unidad,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
       WITH(Unidad   varchar(255))
   END

  SELECT @MovTipo = Clave,@SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = 'TMA'

  IF @MovTipo <>'TMA.OSUR' AND @SubClave='TMA.OSURP'
        SELECT @Ok = 35005, @OkRef = @Mov

  SELECT @Factor = dbo.fnArtUnidadFactor(@Empresa, @Articulo, @Unidad) --04Abr2014

  SET @Cantidad = @Cantidad * @Factor --04Abr2014

  IF @OK IS NULL
     IF NOT EXISTS(SELECT * FROM TMAD d /*WITH(NOLOCK)*/ JOIN TMA t /*WITH(NOLOCK)*/ ON t.ID = d.ID JOIN MovTipo m /*WITH(NOLOCK)*/ ON m.Mov = t.Mov AND m.Modulo = 'TMA' AND t.MovID = @MovID
      JOIN ArtDisponibleTarima a /*WITH(NOLOCK)*/ ON a.Tarima = d.Tarima AND a.Almacen = d.Almacen AND a.Empresa = t.Empresa WHERE a.Articulo = @Articulo AND m.Clave = 'TMA.OSUR' AND m.SubClave = 'TMA.OSURP' AND a.Tarima = @Tarima) SET @Ok = 13070 --09Abr2014
  IF @OK IS NULL
     IF NOT EXISTS(SELECT * FROM TMAD d /*WITH(NOLOCK)*/ JOIN TMA t /*WITH(NOLOCK)*/ ON t.ID = d.ID JOIN MovTipo m /*WITH(NOLOCK)*/ ON m.Mov = t.Mov AND m.Modulo = 'TMA' AND t.MovID = @MovID
      --JOIN ArtDisponibleTarima a /*WITH(NOLOCK)*/ ON a.Tarima = d.Tarima WHERE a.Articulo = @Articulo AND m.Clave = 'TMA.OSUR' AND m.SubClave = 'TMA.OSURP' AND a.Tarima = @Tarima AND a.Disponible >= @Cantidad) SET @Ok = 20020 --09Abr2014
      JOIN ArtDisponibleTarima a /*WITH(NOLOCK)*/ ON a.Tarima = d.Tarima AND a.Almacen = d.Almacen AND a.Empresa = t.Empresa WHERE a.Articulo = @Articulo AND m.Clave = 'TMA.OSUR' AND m.SubClave = 'TMA.OSURP' AND a.Tarima = @Tarima AND a.Disponible >= @Cantidad) SET @Ok = 20020 --09Abr2014  --22851

  SELECT @Agente = DefAgente, @Almacen=DefAlmacen FROM Usuario WHERE Usuario = @Usuario  --BUG24426
    IF @Agente IS NULL SELECT @Ok = 20930

  IF @Ok=20020
  BEGIN
    SELECT @Disponible = ISNULL(b.Disponible,0)/ISNULL(@Factor,1)  FROM Tarima a /*WITH(NOLOCK)*/
     INNER JOIN ArtDisponibleTarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima
     WHERE a.Almacen = @Almacen
       AND a.Estatus = 'ALTA'
       AND a.Tarima=@Tarima
       AND b.Articulo=@Articulo
     AND b.Empresa=@Empresa
  END

  IF @Ok IS NULL AND @Cantidad < 1
    SELECT @OK = 20015

  IF @Ok IS NULL
  BEGIN

  SELECT @ID2 = ID FROM TMA WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID
  SELECT @Estatus = Estatus FROM TMA WHERE ID = @ID2

  SELECT @Procesado = ISNULL(Procesado,0),
         @Renglon = Renglon
    FROM TMAD
   WHERE ID = @ID2
     AND Tarima = @Tarima

    UPDATE TMAD
       SET CantidadA = @Cantidad
     WHERE Tarima = @Tarima  AND ID = @ID2

  IF @Ok IS NULL AND @Estatus = 'PENDIENTE' AND @MovTipo = 'TMA.OSUR'
  BEGIN
    SELECT @Mov3 = TMASurtidoTransitoPCK FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
    EXEC @IDGenerar =  spAfectar 'TMA', @ID2, 'GENERAR', 'Seleccion', @Mov3, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT

    UPDATE TMA SET Montacarga = @Montacargas , Agente = @Agente
    WHERE ID = @IDGenerar

    IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL
    EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT ,@OkRef = @OkRef OUTPUT

    IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL

  END

  IF @Ok IS NULL
  --SELECT @ReferenciaIS = Referencia
  --  FROM IntelisisService
  -- WHERE ID = @ID

  SELECT @Mov2 = Mov , @MovID2 = MovID  FROM TMA WHERE ID = @IDGenerar
 END
   IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
  END

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  IF @Ok = 20020 SELECT @OkRef = @OkRef + '. ' + 'Disponible actual = ' + CAST(ISNULL(@Disponible,0) AS varchar) --BUG24426

  --SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="TMA" ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) +'  Mov=' + CHAR(34) + ISNULL(@Mov2,'') + CHAR(34) + '  MovID=' + CHAR(34) + ISNULL(@MovID2,'') + CHAR(34) + ' Renglon=' + CHAR(34) + CAST(@Renglon AS varchar) + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'  
  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) 
  + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) 
  + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) 
  + '> <Resultado IntelisisServiceID=' 
        + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')                      + CHAR(34) 
        + ' Modulo='   + CHAR(34) + 'TMA'                                 + CHAR(34) 
        + ' ModuloID=' + CHAR(34) + CAST(ISNULL(@IDGenerar,0) AS VARCHAR) + CHAR(34) 
        + ' Mov='      + CHAR(34) + ISNULL(@Mov2,'')                      + CHAR(34) 
        + ' MovID='    + CHAR(34) + ISNULL(@MovID2,'')                    + CHAR(34) 
        + ' Renglon='  + CHAR(34) + CAST(ISNULL(@Renglon,0) AS varchar)   + CHAR(34) 
        + ' Ok='       + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'')       + CHAR(34) 
        + ' OkRef='    + CHAR(34) + ISNULL(@OkRef,'')                     + CHAR(34) 
   + '/></Intelisis>'
  
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.AfectarMov.TMA_OSURP" SubReferencia="" Version="1.0"> <Solicitud>  <TMA Empresa="DEMO" Mov="Orden de Surtido PCK" MovID="3" Usuario="DEMO" Sucursal="Matriz" Montacarga="mon01" Tarima ="T10" Posicion="D03" Codigo="301C" Cantidad="1"  /> </Solicitud> </Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--SELECT convert(xml,@Resultado),@Ok,@OkRef
--go

/**************** spISIntelisisTMAAfectarTMA_TSURP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisTMAAfectarTMA_TSURP') and type = 'P') drop procedure dbo.spISIntelisisTMAAfectarTMA_TSURP
GO
CREATE PROCEDURE [dbo].[spISIntelisisTMAAfectarTMA_TSURP]
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
    @ReferenciaIS            varchar(100),
    @Usuario2                varchar(10),
    @Estacion                int,
    @Empresa                 varchar(5),
    @Usuario                 varchar(15),
    @Agente                  varchar(20),
    @IDAcceso                int,
    @FechaEmision            datetime,
    @PosicionDestino         varchar (20),
    @SubReferencia           varchar(100),
    @Texto                   xml,
    @ID2                     int,
    @Descripcion             varchar(100),
    @Origen                  varchar(20),
    @OrigenID                varchar(20),
    @TarimaSSFA              varchar(20),
    @RefSucursalDes          varchar(100),
    @Sucursal                int,
    @PesoTarimaSSFA          float,
    @Montacarga              varchar(20),
    @Almacen                 varchar(10)
    -- ,@NombreTrans             varchar(32)

  DECLARE @Tabla             table (
    Msg                      varchar(255)
  )

  SELECT @Estacion = @@SPID

  IF @Ok IS NULL
  BEGIN
    SELECT @OrigenID = Valor
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'ID'

    SELECT @Montacarga = Valor
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Montacarga'

    SELECT @Empresa = Valor
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @PosicionDestino = Valor
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'PosicionDestino'

    SELECT @TarimaSSFA = Valor
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'TarimaSSFA'

    SELECT @PesoTarimaSSFA = ISNULL(CONVERT(float, Valor),0)
      FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'PesoTarimaSSFA'

    SELECT @RefSucursalDes = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'RefSucursalDes'
   END

  SET @RefSucursalDes = REPLACE(@RefSucursalDes, CHAR(10), '')
  SET @RefSucursalDes = REPLACE(@RefSucursalDes, CHAR(13), '')
  SELECT @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @RefSucursalDes

  SELECT @Origen = TMAOrdenSurtidoPCK FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa

  SELECT @FechaEmision = dbo.fnFechaSinHora(GETDATE())
  SELECT @Estacion = ISNULL(@Estacion,1)

  /* gina 20150820 La variable montacarta trae el valor del equipo no del agente, causando que la tarima no se cierre*/
  SELECT @Usuario = Usuario FROM IntelisisService WHERE ID = @ID
  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
  SELECT @Montacarga = @Agente

  --BUG24458
  IF @Ok IS NULL AND NOT EXISTS(SELECT *
    FROM TMA t
    JOIN TMAD d ON t.ID = d.ID
    JOIN MovTipo mt ON t.Mov = mt.Mov AND mt.Modulo='TMA'
   WHERE t.OrigenTipo = 'TMA'
     AND t.Origen = @Origen --BUG18816
   --AND t.OrigenID = @OrigenID --BUG18816 --20082014
     AND mt.Clave='TMA.TSUR' AND mt.SubClave='TMA.TSURP'
     AND t.Estatus = 'PROCESAR'
     AND d.PosicionDestino=@PosicionDestino
     AND t.SucursalFiltro = @Sucursal
     AND d.Montacarga=@Montacarga --20082014
   )
  AND EXISTS(
   SELECT *
     FROM TMA t
     JOIN TMAD d ON t.ID = d.ID
     JOIN MovTipo mt ON t.Mov = mt.Mov AND mt.Modulo='TMA'
    WHERE t.OrigenTipo = 'TMA'
      AND t.Origen = @Origen --BUG18816
    --AND t.OrigenID = @OrigenID --BUG18816 --20082014
      AND mt.Clave='TMA.TSUR' AND mt.SubClave='TMA.TSURP'
      AND t.Estatus = 'PROCESAR'
      AND d.PosicionDestino<>@PosicionDestino
      AND t.SucursalFiltro = @Sucursal
      AND d.Montacarga=@Montacarga --20082014
   )
    SELECT @Ok=13035

  --04Abr2014. Validar Posicion Destino
  IF @Ok IS NULL AND NOT EXISTS(SELECT *
    FROM TMA t
    JOIN TMAD d ON t.ID = d.ID
    JOIN MovTipo mt ON t.Mov = mt.Mov AND mt.Modulo='TMA'
   WHERE t.OrigenTipo = 'TMA'
     AND t.Origen = @Origen --BUG18816
   --AND t.OrigenID = @OrigenID --BUG18816 --20082014
     AND mt.Clave='TMA.TSUR' AND mt.SubClave='TMA.TSURP'
     AND t.Estatus = 'PROCESAR'
     AND d.PosicionDestino=@PosicionDestino
     AND t.SucursalFiltro = @Sucursal
     AND d.Montacarga=@Montacarga --20082014
   ) SELECT @Ok=60010

  -- SET @NombreTrans = 'AfectarTMA_TSURP' + CAST(@Estacion AS varchar)
  --SET @NombreTrans = 'TMA_TSURP'
  BEGIN TRANSACTION --@NombreTrans

  IF @Ok IS NULL
  BEGIN

    DELETE ListaID WHERE Estacion = @Estacion

    INSERT ListaID (Estacion,ID)
    SELECT @Estacion,d.ID
      FROM TMA t
      JOIN TMAD d ON t.ID = d.ID
      JOIN MovTipo mt ON t.Mov = mt.Mov AND mt.Modulo='TMA'
     WHERE t.OrigenTipo = 'TMA'
       AND t.Origen = @Origen --BUG18816
     --AND t.OrigenID = @OrigenID --BUG18816
       AND mt.Clave='TMA.TSUR' AND mt.SubClave='TMA.TSURP'
       AND t.Estatus = 'PROCESAR'
       AND d.PosicionDestino = @PosicionDestino
       AND t.SucursalFiltro = @Sucursal
       AND d.Montacarga = @Montacarga

    IF @Ok IS NULL AND EXISTS(
      SELECT *
        FROM TMA t
        JOIN TMAD d ON t.ID = d.ID
        JOIN MovTipo mt ON t.Mov = mt.Mov AND mt.Modulo='TMA'
       WHERE t.OrigenTipo = 'TMA'
         AND t.Origen = @Origen
         AND mt.Clave='TMA.TSUR' AND mt.SubClave='TMA.TSURP'
         AND t.Estatus = 'PROCESAR'
         AND d.PosicionDestino=@PosicionDestino
         AND t.SucursalFiltro = @Sucursal
         AND d.Montacarga=@Montacarga
       )
    BEGIN
      SET @Ok = 20947
      SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      INSERT @Tabla(Msg) SELECT @OkRef
      --SET @Ok = NULL
      SET @OkRef = NULL
    END

    IF @Ok IS NULL
    BEGIN
        EXEC spProcesarTMASurtidoTransito2 @Estacion, @Empresa, @FechaEmision, @Usuario, NULL, 0, @Ok OUTPUT ,@OkRef OUTPUT
        INSERT INTO @Tabla(msg) SELECT ISNULL(@OkRef, @PosicionDestino)
        SET @OkRef = NULL
    END

  END

  IF @Ok IS NULL
    BEGIN
      --IF EXISTS (SELECT [name] FROM sys.dm_tran_active_transactions WHERE name = @NombreTrans) COMMIT TRANSACTION @NombreTrans
      COMMIT TRANSACTION
    END
  ELSE
    BEGIN
      --IF EXISTS (SELECT [name] FROM sys.dm_tran_active_transactions WHERE name = @NombreTrans) ROLLBACK TRANSACTION @NombreTrans
      ROLLBACK TRANSACTION
      SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    END

  SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Msg,''))) AS Msg
                     FROM @Tabla Cierre
                   FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="TMA" Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/>'+ ISNULL(CONVERT(varchar(max),@Texto),'') +'</Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.Afectar.TSURP" SubReferencia="" Version="1.0">
--              <Solicitud>
--                <Parametro Campo="ID" Valor="483" />
--              </Solicitud>
--            </Intelisis>'

--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select @Resultado,@Ok,@OkRef
--GO


--/************** spIntelisisWMSValidarRecepcionArt****************/
--if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSValidarRecepcionArt')           AND type = 'P') drop procedure dbo.spIntelisisWMSValidarRecepcionArt
--GO             
--CREATE PROCEDURE spIntelisisWMSValidarRecepcionArt
--		@ID				int,
--		@iSolicitud		int,
--		@Version		float,
--		@Resultado		varchar(max) = NULL OUTPUT,
--		@Ok				int = NULL OUTPUT,    
--		@OkRef			varchar(255) = NULL OUTPUT

----//WITH ENCRYPTION
--AS BEGIN
--  -- SET nocount ON
--  DECLARE 
		
--		@Empresa            varchar(5),
--		@Mov                varchar(20),
--		@CB                 varchar(30),
--		@Cantidad           float,
--	    @MovID  			varchar(20),
--	    @Articulo 			varchar(20),
--	    @SubCuenta 			varchar(50),
--		@Texto				xml,
--		@ReferenciaIS		varchar(100),
--		@SubReferencia		varchar(100),
--		@Cantidad           float,
--		@Caducidad          int,
--		@FechaCaducidad     datetime,
--		@Fecha              datetime,
--		@Verifica           int,
--		@Verifica2          int,
--		@Sucursal           int
		
--  SELECT  @Empresa   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
--    WITH (Campo varchar(255), Valor varchar(255))
--   WHERE Campo = 'Empresa'
--  SELECT  @Mov= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
--    WITH (Campo varchar(255), Valor varchar(255))
--   WHERE Campo = 'Mov'
--  SELECT  @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
--    WITH (Campo varchar(255), Valor varchar(255))
--   WHERE Campo = 'MovID'   
--   SELECT  @CB = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
--    WITH (Campo varchar(255), Valor varchar(255))
--   WHERE Campo = 'Codigo'  
--  SELECT  @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
--    WITH (Campo varchar(255), Valor varchar(255))
--   WHERE Campo = 'Cantidad' 
  
 
--  IF @@ERROR <> 0 SET @Ok = 1
--  BEGIN 
--    SELECT @ReferenciaIS = Referencia 
--      FROM IntelisisService 
--     WHERE ID = @ID
--    IF @@ERROR <> 0 SET @Ok = 1
    
--    SELECT @Fecha = GETDATE()
--    SELECT @Caducidad =CaducidadMinima  FROM Art WHERE Articulo = @Articulo
    
--    SELECT @FechaCaducidad=FechaCaducidad FROM CompraD d JOIN Compra c ON c.ID=d.ID   WHERE c.Mov=@Mov AND c.MovID =@MovID AND c.Empresa=@Empresa AND d.Articulo= @Articulo AND d.SubCuenta=ISNULL(@SubCuenta,'')
--    SELECT @Articulo = Cuenta,@SubCuenta=SubCuenta FROM CB WHERE Codigo = @CB

    
--    IF NOT EXISTS(SELECT * FROM CompraD d JOIN Compra c ON c.ID=d.ID WHERE c.Estatus = 'PENDIENTE' AND c.Mov=@Mov AND c.MovID =@MovID AND c.Empresa=@Empresa AND d.Articulo =@Articulo AND d.SubCuenta = ISNULL(@Subcuenta,'') AND d.Cantidad >=@Cantidad)SET @Ok =13240
    
--    IF @FechaCaducidad < @Fecha+@Caducidad SET @Ok = 25126
    
--    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

--      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '></Resultado></Intelisis>'
--      IF @@ERROR <> 0 SET @Ok = 1
    
--  END
--END
--GO



--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.ValidarRecepcionArt" SubReferencia="" Version="1.0"><Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--    <Parametro Campo="Empresa" Valor="DEMO"/> 
--    <Parametro Campo="Mov" Valor="Orden Compra"/>      
--    <Parametro Campo="MovID" Valor="3"/> 
--    <Parametro Campo="Codigo" Valor="3123123123123"/> 
--    <Parametro Campo="Cantidad" Valor="10"/> 
--    </Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select @Resultado,@Ok,@OkRef
--GO

--BUG4588
/************** spIntelisisINVINV_IFListado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisINVINV_IFListado') AND type = 'P') drop procedure dbo.spIntelisisINVINV_IFListado
GO             
CREATE PROCEDURE spIntelisisINVINV_IFListado
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
		
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100) ,
		@Agente              varchar(20),
		@Descripcion        varchar(100)



  SELECT  @Agente   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'AgenteA'

  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Agente

  IF NOT EXISTS(SELECT * FROM Agente WHERE Agente = @Agente) SELECT @Ok = 26090, @OkRef=@Agente -- BUG16763
  
  SELECT @Texto =(SELECT Inv.* FROM Inv JOIN MovTipo mt ON Inv.Mov=mt.Mov AND mt.Modulo='INV'
                   WHERE Inv.Agente = @Agente AND 
                   mt.Clave = 'INV.IF' AND Estatus = 'SINAFECTAR'
                   FOR XML AUTO) 

  IF @Texto IS NULL -- BUG16763
	SELECT @Ok = 14055, @OkRef=@Agente -- BUG16763
	  
  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
    IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
    IF @@ERROR <> 0 SET @Ok = 1
   
  END
END
GO


--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.INV_IFListado" SubReferencia="" Version="1.0"><Solicitud>
--<Parametro Campo="AgenteA" Valor="DEMO"/> </Solicitud></Intelisis> '
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado OUTPUT,@Ok Output,@OkRef Output,1,0,@Id Output
--select CONVERT(xml,@Resultado),@Ok,@OkRef
--GO

--<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia="Intelisis.TMA.INV_IFListado" SubReferencia="" Version="1">
--  <Resultado IntelisisServiceID="459" Ok="26090" OkRef="El Agente No Existe" />
--</Intelisis>


/************** spIntelisisWMSValidarPosicionTarima ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSValidarPosicionTarima') AND type = 'P') drop procedure dbo.spIntelisisWMSValidarPosicionTarima
GO
CREATE PROCEDURE spIntelisisWMSValidarPosicionTarima
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
    @Posicion                varchar(20),
    @Tarima                  varchar(20),
    @Articulo                varchar(20),
    @TarimaCompleta          varchar(20),
    @ID2                     int,
    @Renglon                 int,
    @RenglonID               int,
    @Almacen                 varchar(20),
    @Cantidad                float,
    @SucursalOrigen          int,
    @FechaRequerida          datetime,
    @UnidadCompra            varchar(20),
    @FormaCosteo             varchar(20),
    @TipoCosteo              varchar(20),
    @Sucursal2               varchar(100),
    @Costo                   float,
    @Moneda                  varchar(20),
    @TipoCambio              float,
    @Empresa                 varchar(5),
    @Sucursal                int,
    @Cantidad1               float,
    @Sustituir               varchar(5),
    @SubCuenta               varchar(50),
    @Tipo                    varchar(20),
    @Serie                   varchar(20),
    @Propiedades             varchar(20),
    @Unidad                  varchar(20),
    @Factor                  float,
    @CantidadInventario      float,
    @PosicionActual          varchar(20), --TASK4606 UserStory4436
    @ExisteInvD              bit,
    @ExisteSerieLote         bit,
    @CantidadInventarioLote  float,
    @CantidadLote            float

  BEGIN TRANSACTION

  SELECT @ID2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ID'

  SELECT @Posicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'

  SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SELECT @TarimaCompleta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'TarimaCompleta'

  SELECT @Sustituir = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sustituir'

  SELECT @Cantidad1 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Cantidad'

  SELECT @Serie = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Serie'

  SELECT @Propiedades = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Propiedades'

  SELECT @Almacen        = Almacen,
         @SucursalOrigen = Sucursal,
         @FechaRequerida = FechaEmision,
         @Moneda         = Moneda,
         @TipoCambio     = TipoCambio,
         @Empresa        = Empresa,
         @Sucursal       = Sucursal
    FROM Inv
   WHERE ID = @ID2

  SELECT @FormaCosteo = FormaCosteo
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  IF @FormaCosteo = 'Articulo'
    SELECT @TipoCosteo = TipoCosteo
      FROM Art
     WHERE Articulo = @Articulo
  ELSE
    SELECT @TipoCosteo = TipoCosteo
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

  IF NOT EXISTS(SELECT * FROM CB WHERE Codigo = @Articulo)
    SET @Ok = 72050

  SELECT @Articulo = Cuenta,
         @SubCuenta=ISNULL(SubCuenta,''),
         @Unidad = Unidad
   FROM CB
  WHERE Codigo = @Articulo

  SELECT @UnidadCompra = UnidadCompra,
         @Tipo = Tipo
    FROM Art
   WHERE Articulo = @Articulo

  SELECT @Unidad = ISNULL(@Unidad, @UnidadCompra)

  SELECT @Factor = Factor
    FROM ArtUnidad
   WHERE Articulo = @Articulo
     AND Unidad = @Unidad

  SELECT @Factor = ISNULL(@Factor, 1)

  --TASK4606 UserStory4436
  IF NOT EXISTS(SELECT * FROM Tarima WHERE Tarima = @Tarima)
    SELECT @Ok = 13110, @OkRef=@Tarima

  SELECT @PosicionActual = Posicion FROM Tarima WHERE Tarima = @Tarima

  IF @Ok IS NULL
    IF NOT EXISTS (SELECT * FROM AlmPos WHERE Posicion = @Posicion) SET @Ok = 13030

  IF @Ok IS NULL
    IF NOT EXISTS (SELECT * FROM Art WHERE Articulo = @Articulo) SET @Ok = 10530

  IF @Ok IS NULL
    IF NOT EXISTS (SELECT * FROM Inv WHERE ID = @ID2) SET @Ok = 14055

  IF @Ok IS NULL
  BEGIN
    IF (SELECT COUNT(*) FROM InvD WHERE ID = @ID2 AND Tarima = @Tarima AND Articulo = @Articulo AND Unidad = @Unidad) > 0
      SET @ExisteInvD = 1
    ELSE
      SET @ExisteInvD = 0
  END

  IF @TarimaCompleta = 1
  BEGIN
    IF @Ok IS NULL
      IF NOT EXISTS (SELECT * FROM Tarima t JOIN ArtDisponibleTarima d ON t.Tarima = d.Tarima
                      WHERE t.Tarima = @Tarima AND t.Posicion = @Posicion AND d.Tarima = @Tarima AND d.Articulo = @Articulo)
        SET @Ok = 13110

    IF @Ok IS NULL
    BEGIN
      SELECT @Cantidad = Disponible
        FROM Tarima t
        JOIN ArtDisponibleTarima ON t.Tarima = ArtDisponibleTarima.Tarima
       WHERE t.Tarima = @Tarima
         AND t.Posicion = @Posicion
         AND ArtDisponibleTarima.Tarima = @Tarima
         AND ArtDisponibleTarima.Articulo = @Articulo
    END

  END

  IF @TarimaCompleta = 0
  BEGIN
    SET @Cantidad = @Cantidad1

    IF @Ok IS NULL
      IF NOT EXISTS (SELECT * FROM AlmPos WHERE Posicion = @Posicion AND ArticuloEsp = @Articulo /*AND Tipo = 'Domicilio'*/)
        SET @Ok = 13030 --BUG6198 - BUG6217
  END

  SELECT @Texto = (SELECT ISNULL(Disponible,0.0) Disponible,
                          ISNULL(ArtDisponibleTarima.Tarima,'') Tarima
                     FROM Tarima t JOIN ArtDisponibleTarima ON t.Tarima = ArtDisponibleTarima.Tarima
                    WHERE t.Tarima = @Tarima
                      AND t.Posicion = @Posicion
                      AND ArtDisponibleTarima.Tarima = @Tarima
                      AND ArtDisponibleTarima.Articulo = @Articulo
                   FOR XML AUTO)

  --BUG6198 - BUG6217
  --IF NOT @TarimaCompleta = 1
  --  SET @Cantidad = @Cantidad1

  SET @CantidadInventario = @Cantidad * @Factor

  IF @Ok IS NULL
    IF @Tipo IN ('Serie', 'Lote') AND LTRIM(RTRIM(ISNULL(@Serie,''))) = ''
      SET @Ok = 20051

  IF @Tipo IN ('Serie') AND (@Cantidad NOT IN (0,1))
    SET @Ok = 20052

  IF @Ok IS NULL AND @Tipo IN ('Serie', 'Lote')
  BEGIN
    SELECT @RenglonID = MAX(RenglonID) FROM SerieLoteMovMovil WHERE Modulo = 'INV' AND ID = @ID2 AND Articulo = @Articulo AND ISNULL(Tarima,'') = ISNULL(@Tarima,'')
    SET @RenglonID = ISNULL(@RenglonID,0)

    IF @RenglonID = 0
      SELECT @RenglonID = MAX(RenglonID) FROM SerieLoteMovMovil WHERE Modulo = 'INV' AND ID = @ID2

    SET @RenglonID = ISNULL(@RenglonID,0) + 1

    IF NOT EXISTS(SELECT * FROM SerieLoteMovMovil WHERE Modulo = 'INV' AND ID = @ID2 AND Articulo = @Articulo)
      SELECT @RenglonID = @RenglonID + 1

    IF @Ok IS NULL AND @Tipo IN ('Serie')
    BEGIN
      IF EXISTS(SELECT *
            FROM SerieLoteMovMovil
           WHERE Empresa = @Empresa
             AND Modulo = 'INV'
             AND ID = @ID2
             AND Articulo = @Articulo
             AND SubCuenta = @SubCuenta
             AND SerieLote = @Serie
          )
        SET @ExisteSerieLote = 1
      ELSE
        SET @ExisteSerieLote = 0

      IF @ExisteSerieLote = 1
        SET @OK = 20080

      IF @Ok IS NULL AND @ExisteSerieLote = 0 AND @ExisteInvD = 1
      BEGIN
        SELECT @Renglon = Renglon,
               @RenglonID = RenglonID
          FROM InvD
         WHERE ID = @ID2
           AND Tarima = @Tarima
           AND Articulo = @Articulo
           AND Unidad = @Unidad

        IF @Ok IS NULL AND @ExisteSerieLote = 0
        BEGIN
          INSERT SerieLoteMovMovil (Empresa, Modulo,   ID,  RenglonID,  Articulo,  SubCuenta, SerieLote,  Cantidad,          CantidadAlterna, Propiedades,             Ubicacion, Cliente, Localizacion,  Sucursal, ArtCostoInv, Tarima)
            SELECT                 @Empresa, 'INV', @ID2, @RenglonID, @Articulo, @SubCuenta,    @Serie, @CantidadInventario,            NULL, ISNULL(@Propiedades,''),      NULL,    NULL,         NULL, @Sucursal,        NULL,  @Tarima

          SELECT @CantidadInventarioLote = SUM(Cantidad)
            FROM SerieLoteMovMovil
           WHERE ID = @ID2 AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima

          SET @CantidadLote = @CantidadInventarioLote / @Factor

          UPDATE InvD SET Cantidad = @CantidadLote, CantidadInventario = ISNULL(@CantidadInventarioLote,0) WHERE ID = @ID2 AND Renglon = @Renglon AND RenglonID = @RenglonID
        END
      END

      IF @Ok IS NULL AND @ExisteSerieLote = 0 AND @ExisteInvD = 0
      BEGIN
        SELECT @Renglon = ISNULL(MAX(Renglon),0) + 2048,
               @RenglonID = ISNULL(MAX(RenglonID),0) + 1
          FROM InvD
         WHERE ID = @ID2

        EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, NULL, @UnidadCompra, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0

        INSERT InvD (  ID,  Renglon, RenglonSub,  RenglonID,  Cantidad,  Almacen,  Articulo,  Tarima,  Costo,  FechaRequerida, Unidad,  Factor,  CantidadInventario,  Sucursal,  SucursalOrigen,         Posicion, PosicionReal) --TASK4606 UserStory4436
        SELECT       @ID2, @Renglon,          0, @RenglonID, @Cantidad, @Almacen, @Articulo, @Tarima, @Costo, @FechaRequerida, @Unidad, @Factor, @CantidadInventario, @Sucursal, @SucursalOrigen, @PosicionActual, @Posicion

        IF EXISTS(SELECT * FROM SerieLoteMovMovil WHERE ID = @ID2 AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @Serie AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima)
          SET @ExisteSerieLote = 1
        ELSE
          SET @ExisteSerieLote = 0

        INSERT SerieLoteMovMovil (Empresa, Modulo,   ID,  RenglonID,  Articulo,  SubCuenta, SerieLote,  Cantidad,          CantidadAlterna, Propiedades,             Ubicacion, Cliente, Localizacion,  Sucursal, ArtCostoInv, Tarima)
          SELECT                 @Empresa, 'INV', @ID2, @RenglonID, @Articulo, @SubCuenta,    @Serie, @CantidadInventario,            NULL, ISNULL(@Propiedades,''),      NULL,    NULL,         NULL, @Sucursal,        NULL,  @Tarima

      END
    END

    IF @Ok IS NULL AND @Tipo IN ('Lote')
    BEGIN

      IF @ExisteInvD = 1
      BEGIN
        SELECT @Renglon = Renglon,
               @RenglonID = RenglonID
          FROM InvD
         WHERE ID = @ID2
           AND Tarima = @Tarima
           AND Articulo = @Articulo
           AND Unidad = @Unidad

      IF EXISTS(SELECT * FROM SerieLoteMovMovil WHERE ID = @ID2 AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @Serie AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima)
        SET @ExisteSerieLote = 1
      ELSE
        SET @ExisteSerieLote = 0

      IF @Ok IS NULL AND @TarimaCompleta = 1 AND EXISTS(SELECT * FROM SerieLoteMovMovil WHERE ID = @ID2 AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima)
      BEGIN
        UPDATE SerieLoteMovMovil SET SerieLote = @Serie WHERE ID = @ID2 AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima
        IF EXISTS(SELECT * FROM SerieLoteMovMovil WHERE ID = @ID2 AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @Serie AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima)
          SET @ExisteSerieLote = 1
        ELSE
          SET @ExisteSerieLote = 0
      END

      IF @ExisteSerieLote = 1 AND @Sustituir = 'No'
        UPDATE SerieLoteMovMovil SET Cantidad = Cantidad + @CantidadInventario WHERE ID = @ID2 AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @Serie AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima

      IF @ExisteSerieLote = 1 AND (@Sustituir = 'Si' OR @TarimaCompleta = 1)
        UPDATE SerieLoteMovMovil SET Cantidad = @CantidadInventario WHERE ID = @ID2 AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @Serie AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima

      IF @ExisteSerieLote = 0
        INSERT SerieLoteMovMovil (Empresa, Modulo,   ID,  RenglonID,  Articulo,  SubCuenta, SerieLote,  Cantidad,          CantidadAlterna, Propiedades,             Ubicacion, Cliente, Localizacion,  Sucursal, ArtCostoInv, Tarima)
          SELECT                 @Empresa, 'INV', @ID2, @RenglonID, @Articulo, @SubCuenta,    @Serie, @CantidadInventario,            NULL, ISNULL(@Propiedades,''),      NULL,    NULL,         NULL, @Sucursal,        NULL,  @Tarima

        IF @Sustituir = 'No'
        BEGIN
          UPDATE InvD SET Cantidad = Cantidad + @Cantidad1, CantidadInventario = ISNULL(CantidadInventario,0) + ISNULL(@CantidadInventario,0) WHERE ID = @ID2 AND Renglon = @Renglon AND RenglonID = @RenglonID
        END

        IF @Sustituir = 'Si' OR @TarimaCompleta = 1
        BEGIN
          SELECT @CantidadInventarioLote = SUM(Cantidad)
            FROM SerieLoteMovMovil
           WHERE ID = @ID2 AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima

          SET @CantidadLote = @CantidadInventarioLote / @Factor

          UPDATE InvD SET Cantidad = @CantidadLote, CantidadInventario = ISNULL(@CantidadInventarioLote,0) WHERE ID = @ID2 AND Renglon = @Renglon AND RenglonID = @RenglonID
        END
      END

      IF @ExisteInvD = 0
      BEGIN
        SELECT @Renglon = ISNULL(MAX(Renglon),0) + 2048,
               @RenglonID = ISNULL(MAX(RenglonID),0) + 1
          FROM InvD
         WHERE ID = @ID2

        EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, NULL, @UnidadCompra, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0

        INSERT InvD (  ID,  Renglon, RenglonSub,  RenglonID,  Cantidad,  Almacen,  Articulo,  Tarima,  Costo,  FechaRequerida, Unidad,  Factor,  CantidadInventario,  Sucursal,  SucursalOrigen,         Posicion, PosicionReal) --TASK4606 UserStory4436
        SELECT       @ID2, @Renglon,          0, @RenglonID, @Cantidad, @Almacen, @Articulo, @Tarima, @Costo, @FechaRequerida, @Unidad, @Factor, @CantidadInventario, @Sucursal, @SucursalOrigen, @PosicionActual, @Posicion

      IF EXISTS(SELECT * FROM SerieLoteMovMovil WHERE ID = @ID2 AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @Serie AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima)
        SET @ExisteSerieLote = 1
      ELSE
        SET @ExisteSerieLote = 0

      IF @ExisteSerieLote = 1 AND @Sustituir = 'No'
        UPDATE SerieLoteMovMovil SET Cantidad = Cantidad + @CantidadInventario WHERE ID = @ID2 AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @Serie AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima

      IF @ExisteSerieLote = 1 AND @Sustituir = 'Si'
        UPDATE SerieLoteMovMovil SET Cantidad = @CantidadInventario WHERE ID = @ID2 AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND SerieLote = @Serie AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Propiedades,'') = ISNULL(@Propiedades,'') AND ISNULL(Tarima,'') = @Tarima

      IF @ExisteSerieLote = 0
        INSERT SerieLoteMovMovil (Empresa, Modulo,   ID,  RenglonID,  Articulo,  SubCuenta, SerieLote,  Cantidad,          CantidadAlterna, Propiedades,             Ubicacion, Cliente, Localizacion,  Sucursal, ArtCostoInv, Tarima)
          SELECT                 @Empresa, 'INV', @ID2, @RenglonID, @Articulo, @SubCuenta,    @Serie, @CantidadInventario,            NULL, ISNULL(@Propiedades,''),      NULL,    NULL,         NULL, @Sucursal,        NULL,  @Tarima

      END
    END
  END

  IF @Ok IS NULL AND @Tipo NOT IN ('Serie', 'Lote')
  BEGIN
    IF @ExisteInvD = 1
    BEGIN
      SELECT @Renglon = Renglon,
             @RenglonID = RenglonID
        FROM InvD
       WHERE ID = @ID2
         AND Tarima = @Tarima
         AND Articulo = @Articulo
         AND Unidad = @Unidad
      IF @Sustituir = 'NO'
        UPDATE InvD SET Cantidad = Cantidad + @Cantidad1, CantidadInventario = ISNULL(CantidadInventario,0) + ISNULL(@CantidadInventario,0) WHERE ID = @ID2 AND Renglon = @Renglon AND RenglonID = @RenglonID
      IF @Sustituir = 'Si' AND @Cantidad1 > 0
        UPDATE InvD SET Cantidad = @Cantidad1, CantidadInventario = ISNULL(@CantidadInventario,0) WHERE ID = @ID2 AND Renglon = @Renglon AND RenglonID = @RenglonID
      IF @Sustituir = 'Si' AND @Cantidad1 = 0
        DELETE InvD WHERE ID = @ID2 AND Tarima = @Tarima AND Articulo = @Articulo AND Unidad = @Unidad
    END

    IF @ExisteInvD = 0
    BEGIN
      SELECT @Renglon = ISNULL(MAX(Renglon),0) + 2048,
              @RenglonID = ISNULL(MAX(RenglonID),0) + 1
        FROM InvD WHERE ID = @ID2

      EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, NULL, @UnidadCompra, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0

      INSERT InvD (  ID,  Renglon, RenglonSub,  RenglonID,  Cantidad,  Almacen,  Articulo,  Tarima,  Costo,  FechaRequerida, Unidad,  Factor,  CantidadInventario,  Sucursal,  SucursalOrigen,         Posicion, PosicionReal) --TASK4606 UserStory4436
      SELECT       @ID2, @Renglon,          0, @RenglonID, @Cantidad, @Almacen, @Articulo, @Tarima, @Costo, @FechaRequerida, @Unidad, @Factor, @CantidadInventario, @Sucursal, @SucursalOrigen, @PosicionActual, @Posicion
    END
  END

  IF @@ERROR <> 0
    SET @Ok = 1

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @@ERROR <> 0
    SET @Ok = 1

  IF @Ok IS NOT NULL
    SELECT @OkRef = Descripcion
      FROM MensajeLista
     WHERE Mensaje = @Ok

  IF @TarimaCompleta = 1
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
  ELSE
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'

  IF @@ERROR <> 0
    SET @Ok = 1

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
  END

END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.Validar.PosicionTarima" SubReferencia="" Version="1.0">
--              <Solicitud>
--                <Parametro Campo="ID" Valor="1348" />
--                <Parametro Campo="Posicion" Valor="02B" />
--                <Parametro Campo="Tarima" Valor="T2" /> 
--                <Parametro Campo="Articulo" Valor="301P" />
--                <Parametro Campo="TarimaCompleta" Valor="1" />
--                <Parametro Campo="Cantidad" Valor="10" />
--                <Parametro Campo="Sustituir" Valor="NO" />
--                <Parametro Campo="Serie" Valor="" />
--              </Solicitud>
--            </Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select convert(xml,@Resultado),@Ok,@OkRef
--GO



/************** spIntelisisINVAfectarINV_SOL****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisINVAfectarINV_SOL') AND type = 'P') drop procedure dbo.spIntelisisINVAfectarINV_SOL
GO             
CREATE PROCEDURE spIntelisisINVAfectarINV_SOL
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
		@ID2                int,
		@ID3                int,
		@IDGenerar          int,
		@IDAcceso           int,
		@Estacion           int,
		@Empresa            varchar(5),
		@Mov                varchar(20),
		@Mov2                varchar(20),
		@Usuario            varchar(20),
		@CB                 varchar(30),
		@Cantidad           float,
	    @MovID  			varchar(20),
	    @Articulo 			varchar(20),
	    @SubCuenta 			varchar(50),
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@Caducidad          datetime,
		@FechaCaducidad     int,
		@Fecha              datetime,
		@Verifica           int,
		@Verifica2          int,
		@Sucursal           int,
		@Partidas           int, /*RJP 171110 Cuenta partidas con CantidadA > 0*/
		@Referencia         varchar (50) ---- RJP 18112010 Referencia de la Entrada de Compra
	
		
  BEGIN TRANSACTION 
  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  		
		
  SELECT  @Empresa   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'
  SELECT  @Usuario = NULLIF(Usuario,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro') 
    WITH(Usuario   varchar(255))   
  SELECT  @Mov= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'
  SELECT  @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'   


  
  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
  
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
    SELECT @ID2 = ID FROM Compra WHERE  Mov=@Mov AND MovID =@MovID AND Empresa=@Empresa

    SELECT @ID3 = f.DID--, f.DMov, f.DMovID 
      FROM MovFlujo f 
      JOIN MovTipo t 
        ON f.DMov = t.Mov AND f.DModulo = t.Modulo
     WHERE f.OModulo = 'COMS' 
       AND f.OID = @ID2 
       AND f.DModulo = 'INV' 
       AND f.Empresa = @Empresa
       AND t.Clave = 'INV.SOL'


    /*RJP 171110 Valida que existan partidas recibidas para que la entrada de compra no se genere vacia*/
    IF @OK is NULL
    BEGIN
       SELECT @Partidas = count(ID) FROM InvD WHERE ID = @ID3
	   IF @Partidas = 0 
	      SET @OK = 60010 ---No hay nada que afectar
    END

	IF @Ok IS NULL
	BEGIN  
       SELECT @Mov2 = InvEntarimado FROM EmpresaCfgMov WHERE Empresa = @Empresa
       EXEC  @IDGenerar=spAfectar 'INV', @ID3, 'GENERAR', 'Pendiente', @Mov2, @Usuario, @Estacion=@Estacion, @EnSilencio=1, @Conexion=0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  
       IF @Ok BETWEEN 80030 AND 81000     SELECT @Ok = NULL
    END

    
    
    IF @Ok IS NULL 
     EXEC spAfectar 'INV', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion=@Estacion, @EnSilencio=1, @Conexion=0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  


    IF @OK IS NULL
       SELECT @Referencia = Idioma from compra
       where ID = @ID2 
	   UPDATE Inv set Referencia = @Referencia
	   Where ID = @IDGenerar 



    IF @@ERROR <> 0 SET @Ok = 1
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '></Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1


      
   IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
  END      
    
  END
END
GO


--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.INV.AfectarINV_SOL" SubReferencia="" Version="1.0"><Solicitud>   
--    <Parametro Campo="Empresa" Valor="DEMO"/>
--    <Parametro Campo="Usuario" Valor="DEMO"/> 
--    <Parametro Campo="Mov" Valor="Entrada Compra"/>      
--    <Parametro Campo="MovID" Valor="8"/> 
--    </Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select @Resultado,@Ok,@OkRef
--GO

/************** spIntelisisWMSSerieLoteProp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSSerieLoteProp') AND type = 'P') drop procedure dbo.spIntelisisWMSSerieLoteProp
GO             
CREATE PROCEDURE spIntelisisWMSSerieLoteProp
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
		
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@Propiedades        varchar(20),
		@Extra1             varchar(100),
		@Fecha1				datetime
  
  SELECT  @Propiedades  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Propiedades'

  SELECT  @Extra1  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Extra1'
   
   SELECT  @Fecha1  = CONVERT(datetime, Valor)FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Fecha1'
  
  IF NULLIF(RTRIM(LTRIM(@Propiedades)),'') IS NULL
    SELECT @Ok = 80203
    
  IF NOT EXISTS(SELECT * FROM SerieLoteProp WHERE Propiedades = @Propiedades) AND @Ok IS NULL
    INSERT SerieLoteProp (Propiedades, Extra1,Fecha1 )
    SELECT @Propiedades, @Extra1, @Fecha1 
  ELSE
  IF @Ok IS NULL
    SELECT @Ok = 80204

  SELECT @Texto =(SELECT @Propiedades Propiedades, @Extra1 Extra1 FROM SerieLoteProp
                   FOR XML AUTO)	

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
      IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
  
  END
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.SerieLoteProp" SubReferencia="" Version="1.0"> 
--<Solicitud>  
--  <Parametro Campo="Propiedades" Valor="Prop" /> 
--  <Parametro Campo="Extra1" Valor="Extra"/> 
--</Solicitud> 
--</Intelisis>'
--EXEC spIntelisisService 'DEMO',null,@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--select convert(xml,@Resultado),@Ok,@OkRef
--GO


/************** spIntelisisWMSSerieLotePropLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSSerieLotePropLista') AND type = 'P') drop procedure dbo.spIntelisisWMSSerieLotePropLista
GO             
CREATE PROCEDURE spIntelisisWMSSerieLotePropLista
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
		
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100)
		    
  SELECT @Texto =(SELECT Propiedades, Extra1 FROM SerieLoteProp
                   FOR XML AUTO)	

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
      IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'  --UserStory4436
      IF @@ERROR <> 0 SET @Ok = 1
  
  END
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.SerieLotePropLista" SubReferencia="" Version="1.0"> 
--<Solicitud>  
--</Solicitud> 
--</Intelisis>'
--EXEC spIntelisisService 'DEMO',null,@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--select convert(xml,@Resultado),@Ok,@OkRef
--GO


/************** spIntelisisWMSValidarSoloCB****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSValidarSoloCB') AND type = 'P') drop procedure dbo.spIntelisisWMSValidarSoloCB
GO             
CREATE PROCEDURE spIntelisisWMSValidarSoloCB
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
		@CB					varchar(30),
	    @Articulo 			varchar(20),
	    @SubCuenta 			varchar(50),
		@Cantidad           float,
		@Tarima				varchar(20),
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100)
		
  DECLARE
  @Tabla Table(
  CB				varchar(30),
  Articulo			varchar(10),
  Subcuenta			varchar(10),
  Tarima			varchar(20)
  )		
  
   SELECT  @CB = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Codigo'  
  SELECT  @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Cantidad' 
  SELECT  @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'


  
  IF NOT EXISTS(SELECT * FROM CB WHERE Codigo = @CB)SET @Ok = 72040
  IF @Ok IS NULL
  BEGIN
    SELECT @Articulo = Cuenta, @SubCuenta=ISNULL(SubCuenta,'') FROM CB WHERE Codigo = @CB       

    IF NOT EXISTS(SELECT * FROM Tarima WHERE Tarima = @Tarima AND Estatus = 'Alta') AND @Ok IS NULL
      SELECT @OK = 13110
    
    IF NOT EXISTS(SELECT * FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Articulo = @Articulo) AND @Ok IS NULL
      SELECT @Ok = 10530

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  
    INSERT @Tabla
    SELECT @CB, @Articulo, @SubCuenta, @Tarima   
  END    

   
  SELECT @Texto = (SELECT * FROM @Tabla CB
                   FOR XML AUTO)
  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
      
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.ValidarSoloCB" SubReferencia="" Version="1.0">
--              <Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--                <Parametro Campo="Codigo" Valor="55WMS"/> 
--                <Parametro Campo="Cantidad" Valor="10"/> 
--                <Parametro Campo="Tarima" Valor="T7"/> 
--              </Solicitud>
--            </Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select convert(xml,@Resultado),@Ok,@OkRef
--GO

/**************** spISIntelisisINVAfectarINV_IF ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisINVAfectarINV_IF') and type = 'P') drop procedure dbo.spISIntelisisINVAfectarINV_IF
GO              
CREATE PROCEDURE spISIntelisisINVAfectarINV_IF
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
    @IDGenerar					int,
    @IDAcceso					int,	
    @MovTipo					varchar(20),
    @ReferenciaIS				varchar(100),
    @Usuario2					varchar(10),
    @Estacion					int,
    @SubReferencia				varchar(100),
    @Empresa   				    varchar(5),
    @Mov   					    varchar(20),
    @MovID   					varchar(20),
    @Sucursal                   int,
    @ID2                        int,
    @Tarima                     varchar(20),
    @Sucursal2                  varchar(100),
    @Posicion                   varchar(20),
    @PosicionDestino            varchar(20),
    @Usuario                    varchar(15),
    @Montacargas                varchar(20),
    @Estatus                    varchar(20),
    @Agente                     varchar(20),
    @Modificar                  bit,
    @Procesado                  bit,
    @Mov2  					    varchar(20),
    @Mov3  					    varchar(20),
    @MovID2   					varchar(20),
    @PosicionDGenerar           varchar(20),
    @Descripcion                varchar(100),
    @RenglonID					float,
    @RenglonID2					float,
    @InvFisicoConteo			int
    

  BEGIN TRANSACTION 
  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso

  SELECT  @Usuario   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro') ---BUG19226
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'AgenteA'
  
  IF @Ok IS NULL
  BEGIN  
    SELECT  @ID2   = NULLIF(ID,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/INV') 
      WITH(ID    varchar(255))
  END
  			  
  SELECT @Mov = Mov, @MovID = MovID, @Estatus = Estatus, @Empresa = Empresa FROM Inv WHERE ID = @ID2
  SELECT @MovTipo = Clave FROM MovTipo WHERE Mov = @Mov AND Modulo = 'INV' 

  IF @MovTipo NOT IN('INV.IF') 
  SELECT @Ok = 35005, @OkRef = @Mov 
  
  IF @Ok IS NULL AND @Estatus = 'SINAFECTAR' AND @MovTipo = 'INV.IF'
  BEGIN
    SELECT @InvFisicoConteo = ISNULL(InvFisicoConteo,1) FROM EmpresaCfg WHERE Empresa = @Empresa
    SELECT @Mov3 = InvAjuste FROM EmpresaCfgMov WHERE Empresa = @Empresa
    
    /*
    IF @Ok IS NULL AND @InvFisicoConteo > 1
      EXEC spAfectar 'INV', @ID2, 'AFECTAR', 'Todo', @Mov3, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 0, @Ok = @Ok OUTPUT ,@OkRef = @OkRef OUTPUT
  	IF @Ok IS NULL AND @InvFisicoConteo > 2
      EXEC spAfectar 'INV', @ID2, 'AFECTAR', 'Todo', @Mov3, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 0, @Ok = @Ok OUTPUT ,@OkRef = @OkRef OUTPUT
    */
      
	IF @Ok IS NULL
	BEGIN
		DELETE FROM SerieLoteMov 
		 WHERE Empresa = @Empresa
		   AND Modulo = 'INV' 
		   AND ID = @ID2

    INSERT SerieLoteMov(
    	      Empresa, Modulo, ID, RenglonID, Articulo, 
            SubCuenta, SerieLote, Cantidad, CantidadAlterna, Propiedades, 
            Ubicacion, Cliente, Localizacion, Sucursal, ArtCostoInv, 
            Tarima)
    SELECT Empresa,Modulo,ID,RenglonID,Articulo,
           SubCuenta,SerieLote,Cantidad,CantidadAlterna,Propiedades,
           Ubicacion,Cliente,Localizacion,Sucursal,ArtCostoInv,
           Tarima
      FROM SerieLoteMovMovil 
	   WHERE Empresa = @Empresa
	     AND Modulo = 'INV' 
	     AND ID = @ID2
	END

	--SELECT @ID2, @Mov3
  
  --BUG6428 No aplica asignar consecutivo ya que solo se considera un conteo
  --IF LTRIM(RTRIM(ISNULL(@MovID,''))) = ''
  --  BEGIN
  --    EXEC spAfectar 'INV',
  --         @ID2,
  --         'CONSECUTIVO',
  --         'Seleccion',
  --         @Mov3,
  --         @Usuario,
  --         @Estacion,
  --         @EnSilencio = 1,
  --         @Conexion = 0,
  --         @Ok = @Ok OUTPUT,
  --         @OkRef = @OkRef OUTPUT
  --  END
  
  /*  --BUG6428
	EXEC @IDGenerar =  spAfectar 'INV', @ID2, 'AFECTAR', 'Seleccion', @Mov3, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 0, @Ok = @Ok OUTPUT , @OkRef = @OkRef OUTPUT 
	
	--select '@IDGenerar', @IDGenerar
    
	IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL

   SELECT @RenglonID = MAX(RenglonID)
     FROM SerieLoteMov
    WHERE ID = @IDGenerar
      AND Modulo = 'INV'
      AND Empresa = @Empresa

    DECLARE crRenglonID CURSOR LOCAL FOR
     SELECT RenglonID
       FROM SerieLoteMovMovil
      WHERE ID = @ID2
        AND Procesado = 0
       
    OPEN crRenglonID
    FETCH NEXT FROM crRenglonID INTO @RenglonID2
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      SELECT @RenglonID = @RenglonID + 1

      INSERT INTO SerieLoteMov (Empresa, Modulo, ID,		  RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, CantidadAlterna, Propiedades, Ubicacion, Cliente, Localizacion, Sucursal, ArtCostoInv)
      SELECT                    Empresa, Modulo, @IDGenerar, @RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, CantidadAlterna, Propiedades, Ubicacion, Cliente, Localizacion, Sucursal, ArtCostoInv
        FROM SerieLoteMovMovil
       WHERE ID = @ID2
         AND Procesado = 0
         AND RenglonID = @RenglonID2
         AND Modulo = 'INV'
         AND Empresa = @Empresa

      UPDATE SerieLoteMovMovil SET Procesado = 1 WHERE ID = @ID2 AND Procesado = 0 AND RenglonID = @RenglonID2

      FETCH NEXT FROM crRenglonID INTO @RenglonID2
    END
    CLOSE crRenglonID
    DEALLOCATE crRenglonID

    DELETE SerieLoteMov WHERE ID = @IDGenerar AND Modulo = 'INV' AND Empresa = @Empresa AND ISNULL(Cantidad, 0) <= 0

    IF @Ok IS NULL
    EXEC spAfectar 'INV', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion,@EnSilencio = 1, @Conexion = 0, @Ok = @Ok OUTPUT ,@OkRef = @OkRef OUTPUT 
	IF @Ok = 72060 SELECT @Ok = 80070 --UserStory4436

   */ --BUG6428
    
    
    IF @Ok BETWEEN 80030 AND 81000 
	  IF @Ok NOT IN (80070) --UserStory4436
	    SELECT @Ok = NULL , @OkRef = NULL

  END

--SELECT Conteo, * FROM Inv WHERE ID = @ID2  
--SELECT * FROM InvD WHERE ID = @ID2
--SELECT * FROM Inv WHERE ID = @IDGenerar  
--SELECT * FROM InvD WHERE ID = @IDGenerar
--SELECT * FROM SerieLoteMov WHERE ID = @IDGenerar


IF @Ok BETWEEN 80030 AND 81000 
  IF @Ok NOT IN (80070) --UserStory4436
    SELECT @Ok = NULL , @OkRef = NULL
--IF @Ok IS NULL SELECT @Ok = 1
  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
  END
 IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok 
 --SELECT @OkRef
 SELECT @OkRef = REPLACE(@OkRef, '<BR>' , '')
 SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="INV" ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) +'  Mov=' + CHAR(34) + ISNULL(@Mov2,'') + CHAR(34) +'  MovID=' + CHAR(34) + ISNULL(@MovID2,'') + CHAR(34)  +'  PosicionDestino=' + CHAR(34) + ISNULL(@PosicionDGenerar,'') + CHAR(34) +'  DescripcionPosicionDestino=' + CHAR(34) + ISNULL(@Descripcion,'') + CHAR(34) +  ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.INV.AfectarMov.INV_IF" SubReferencia="" Version="1.0"> 
--              <Solicitud>  
--                <INV ID="1124" /> 
--              </Solicitud> 
--            </Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--SELECT convert(xml,@Resultado),@Ok,@OkRef
--GO



/************** spIntelisisINVAfectarINV_SOL****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisINVAfectarINV_SOL') AND type = 'P') drop procedure dbo.spIntelisisINVAfectarINV_SOL
GO             
CREATE PROCEDURE spIntelisisINVAfectarINV_SOL
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
		@ID2                int,
		@ID3                int,
		@IDGenerar          int,
		@IDAcceso           int,
		@Estacion           int,
		@Empresa            varchar(5),
		@Mov                varchar(20),
		@Mov2                varchar(20),
		@Usuario            varchar(20),
		@CB                 varchar(30),
		@Cantidad           float,
	    @MovID  			varchar(20),
	    @Articulo 			varchar(20),
	    @SubCuenta 			varchar(50),
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@Caducidad          datetime,
		@FechaCaducidad     int,
		@Fecha              datetime,
		@Verifica           int,
		@Verifica2          int,
		@Sucursal           int,
		@Partidas           int, /*RJP 171110 Cuenta partidas con CantidadA > 0*/
		@Referencia         varchar (50) ---- RJP 18112010 Referencia de la Entrada de Compra
	
		
  BEGIN TRANSACTION 
  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  		
		
  SELECT  @Empresa   = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'
  SELECT  @Usuario = NULLIF(Usuario,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro') 
    WITH(Usuario   varchar(255))   
  SELECT  @Mov= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'
  SELECT  @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'   


  
  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
  
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
    SELECT @ID2 = ID FROM Compra WHERE  Mov=@Mov AND MovID =@MovID AND Empresa=@Empresa

    SELECT @ID3 = f.DID--, f.DMov, f.DMovID 
      FROM MovFlujo f 
      JOIN MovTipo t 
        ON f.DMov = t.Mov AND f.DModulo = t.Modulo
     WHERE f.OModulo = 'COMS' 
       AND f.OID = @ID2 
       AND f.DModulo = 'INV' 
       AND f.Empresa = @Empresa
       AND t.Clave = 'INV.SOL'


    /*RJP 171110 Valida que existan partidas recibidas para que la entrada de compra no se genere vacia*/
    IF @OK is NULL
    BEGIN
       SELECT @Partidas = count(ID) FROM InvD WHERE ID = @ID3
	   IF @Partidas = 0 
	      SET @OK = 60010 ---No hay nada que afectar
    END

	IF @Ok IS NULL
	BEGIN  
       SELECT @Mov2 = InvEntarimado FROM EmpresaCfgMov WHERE Empresa = @Empresa
       EXEC  @IDGenerar=spAfectar 'INV', @ID3, 'GENERAR', 'Pendiente', @Mov2, @Usuario, @Estacion=@Estacion, @EnSilencio=1, @Conexion=0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  
       IF @Ok BETWEEN 80030 AND 81000     SELECT @Ok = NULL
    END

    
    
    IF @Ok IS NULL 
     EXEC spAfectar 'INV', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion=@Estacion, @EnSilencio=1, @Conexion=0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  


    IF @OK IS NULL
       SELECT @Referencia = Idioma from compra
       where ID = @ID2 
	   UPDATE Inv set Referencia = @Referencia
	   Where ID = @IDGenerar 



    IF @@ERROR <> 0 SET @Ok = 1
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '></Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1


      
   IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
  END      
    
  END
END
GO


--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.INV.AfectarINV_SOL" SubReferencia="" Version="1.0"><Solicitud>   
--    <Parametro Campo="Empresa" Valor="DEMO"/>
--    <Parametro Campo="Usuario" Valor="DEMO"/> 
--    <Parametro Campo="Mov" Valor="Entrada Compra"/>      
--    <Parametro Campo="MovID" Valor="8"/> 
--    </Solicitud></Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select @Resultado,@Ok,@OkRef
--GO

/************** spIntelisisWMSTareasAsignadasListado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSTareasAsignadasListado') AND type = 'P') drop procedure dbo.spIntelisisWMSTareasAsignadasListado
GO
CREATE PROCEDURE spIntelisisWMSTareasAsignadasListado
  @ID                   int,
  @iSolicitud           int,
  @Version              float,
  @Resultado            varchar(max) = NULL OUTPUT,
  @Ok                   int = NULL OUTPUT,
  @OkRef                varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE
  @Texto                xml,
  @ReferenciaIS         varchar(100),
  @SubReferencia        varchar(100) ,
  @Agente               varchar(20),
  @IDAcceso             int,
  @Estacion             int,
  @ModuloID             int


DECLARE @TablaTmp table(
  ModuloID              int,
  Mov                   varchar(20),
  MovID                 varchar(20),
  RenglonID             float,
  Tarima                varchar(20),
  Prioridad             varchar(10),
  Clave                 varchar(20),
  Posicion              varchar(10),
  OrdenPosicion         int,
  PosicionDestino       varchar(10),
  TarimaCompleta        varchar(10),
  Orden                 varchar(10),
  Cantidad              float,
  CantidadPendiente     float,
  Articulo              varchar(20),
  CambioClave           varchar(20),
  Unidad                varchar(50),
  Almacen               varchar(20),
  OrigenTipo            varchar(10),
  Origen                varchar(20),
  OrigenID              varchar(20)
)

DECLARE @Tabla table(
  IDR                   int identity(1,1),
  ModuloID              int,
  Mov                   varchar(20),
  MovID                 varchar(20),
  RenglonID             float,
  Tarima                varchar(20),
  Prioridad             varchar(10),
  Clave                 varchar(20),
  Posicion              varchar(10),
  OrdenPosicion         int,
  PosicionDestino       varchar(10),
  TarimaCompleta        varchar(10),
  Orden                 varchar(10),
  Cantidad              float,
  CantidadPendiente     float,
  Articulo              varchar(20),
  CambioClave           varchar(20),
  Unidad                varchar(50),
  Almacen               varchar(20),
  OrigenTipo            varchar(10),
  Origen                varchar(20),
  OrigenID              varchar(20)
)

BEGIN TRY
  SELECT @Agente = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Agente'

  SET    @Agente   = LTRIM(RTRIM(ISNULL(@Agente,'')))
  SELECT @Agente   = DefAgente FROM Usuario WHERE Usuario = @Agente

  SET @Estacion = @@SPID

  IF NOT EXISTS(SELECT * FROM Agente WHERE Agente = @Agente) SET @Ok = 26090

  IF @Ok IS NULL
    BEGIN
      EXEC spWMSMontacargaTarea @Estacion, 1

      INSERT INTO @TablaTmp (
          ModuloID, Mov, MovID, RenglonID, Tarima,
          Prioridad, Clave, Posicion, PosicionDestino, TarimaCompleta,
          Cantidad, CantidadPendiente, Articulo, CambioClave, Unidad,
          Almacen, OrigenTipo, Origen, OrigenID
        )
      SELECT ISNULL(d.ID,0), w.Mov, w.MovID, d.Renglon, d.Tarima,
             w.Prioridad, w.Clave, ISNULL(d.Posicion,''), ISNULL(d.PosicionDestino,''), CASE WHEN w.Tarima = 'Picking' THEN '0' ELSE '1' END,
             --d.CantidadPendiente, d.CantidadPendiente, d.Articulo, d.ArtCambioClave, d.Unidad,
             d.CantidadPicking, d.CantidadPendiente, d.Articulo, d.ArtCambioClave, d.Unidad,
             w.Almacen, tm.OrigenTipo, tm.Origen, tm.OrigenID
      FROM WMSMontacargaTarea w
      LEFT JOIN Tarima t ON (w.Tarima = t.Tarima)
      JOIN TMAD d ON (w.ID = d.ID AND ISNULL(NULLIF(w.Tarima, 'Picking'), d.Tarima) = d.Tarima)
      JOIN TMA tm ON (d.ID = tm.ID)
      WHERE w.Montacarga = @Agente
        AND w.Estacion = @Estacion
        --AND d.CantidadPendiente > 0 -- BUG11519

      ----------------------------------------------------------------------------------------------------
      -- BUG11519
      DELETE @TablaTmp WHERE ISNULL(CantidadPendiente,0) = 0 AND Clave NOT IN('TMA.SRADO')
      ----------------------------------------------------------------------------------------------------

      ----------------------------------------------------------------------------------------------------
      -- Movimientos "Surtido de Tarima Completa" son congfigurables desde ERP
      DELETE @TablaTmp WHERE Clave IN('TMA.OPCKTARIMA', 'TMA.PCKTARIMA', 'TMA.PCKTARIMATRAN')
      -- Solo VOIT utiliza estos movimientos
      ----------------------------------------------------------------------------------------------------

      UPDATE @TablaTmp
         SET Orden = CASE Prioridad WHEN 'Alta' THEN 1 WHEN 'Media' THEN 2 ELSE 3 END

      UPDATE @TablaTmp
         SET OrdenPosicion = b.Orden
        FROM @TablaTmp a
        JOIN AlmPos b
          ON (a.Posicion = b.Posicion)

      INSERT INTO @Tabla (ModuloID, Mov, MovID, RenglonID, Tarima, Prioridad, Clave, Posicion, OrdenPosicion, PosicionDestino, TarimaCompleta, Orden, Cantidad, CantidadPendiente, Articulo, CambioClave, Unidad, Almacen, OrigenTipo, Origen, OrigenID)
      SELECT DISTINCT ModuloID, Mov, MovID, RenglonID, Tarima, Prioridad, Clave, Posicion, OrdenPosicion, PosicionDestino, TarimaCompleta, Orden, Cantidad, CantidadPendiente, Articulo, CambioClave, Unidad, Almacen, OrigenTipo, Origen, OrigenID
        FROM @TablaTmp
       ORDER BY ModuloID, OrdenPosicion, Tarima

      SELECT @Texto = (
        SELECT CAST(ISNULL(ModuloID,0) AS VARCHAR)          AS ModuloID,
               LTRIM(RTRIM(ISNULL(Mov,'')))                 AS Mov,
               LTRIM(RTRIM(ISNULL(MovID,'')))               AS MovID,
               CAST(ISNULL(RenglonID,0) AS VARCHAR)         AS RenglonID,
               LTRIM(RTRIM(ISNULL(Tarima,'')))              AS Tarima,
               LTRIM(RTRIM(ISNULL(Prioridad,'')))           AS Prioridad,
               LTRIM(RTRIM(ISNULL(Clave,'')))               AS Clave,
               LTRIM(RTRIM(ISNULL(Posicion,'')))            AS Posicion,
               CAST(ISNULL(OrdenPosicion,0) AS VARCHAR)     AS OrdenPosicion,
               LTRIM(RTRIM(ISNULL(PosicionDestino,'')))     AS PosicionDestino,
               LTRIM(RTRIM(ISNULL(TarimaCompleta,'')))      AS TarimaCompleta,
               LTRIM(RTRIM(ISNULL(Orden,'')))               AS Orden,
               CAST(ISNULL(Cantidad,0) AS VARCHAR)          AS Cantidad,
               CAST(ISNULL(CantidadPendiente,0) AS VARCHAR) AS CantidadPendiente,
               LTRIM(RTRIM(ISNULL(Articulo,'')))            AS Articulo,
               LTRIM(RTRIM(ISNULL(CambioClave,'')))         AS CambioClave,
               LTRIM(RTRIM(ISNULL(Unidad,'')))              AS Unidad,
               LTRIM(RTRIM(ISNULL(Almacen,'')))             AS Almacen,
               LTRIM(RTRIM(ISNULL(OrigenTipo,'')))          AS OrigenTipo,
               LTRIM(RTRIM(ISNULL(Origen,'')))              AS Origen,
               LTRIM(RTRIM(ISNULL(OrigenID,'')))            AS OrigenID
          FROM @Tabla AS TMA
         ORDER BY IDR
           FOR XML AUTO)
    END

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSSerieLoteProp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSSerieLoteProp') AND type = 'P') drop procedure dbo.spIntelisisWMSSerieLoteProp
GO             
CREATE PROCEDURE spIntelisisWMSSerieLoteProp
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
		
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@Propiedades        varchar(20),
		@Extra1             varchar(100),
		@Fecha1				datetime
  
  SELECT  @Propiedades  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Propiedades'

  SELECT  @Extra1  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Extra1'
   
   SELECT  @Fecha1  = CONVERT(datetime, Valor)FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Fecha1'
  
  IF NULLIF(RTRIM(LTRIM(@Propiedades)),'') IS NULL
    SELECT @Ok = 80203
    
  IF NOT EXISTS(SELECT * FROM SerieLoteProp WHERE Propiedades = @Propiedades) AND @Ok IS NULL
    INSERT SerieLoteProp (Propiedades, Extra1,Fecha1 )
    SELECT @Propiedades, @Extra1, @Fecha1 
  ELSE
  IF @Ok IS NULL
    SELECT @Ok = 80204

  SELECT @Texto =(SELECT @Propiedades Propiedades, @Extra1 Extra1 FROM SerieLoteProp
                   FOR XML AUTO)	

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
      IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
  
  END
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.SerieLoteProp" SubReferencia="" Version="1.0"> 
--<Solicitud>  
--  <Parametro Campo="Propiedades" Valor="Prop" /> 
--  <Parametro Campo="Extra1" Valor="Extra"/> 
--</Solicitud> 
--</Intelisis>'
--EXEC spIntelisisService 'DEMO',null,@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--select convert(xml,@Resultado),@Ok,@OkRef
--GO


/************** spIntelisisWMSSerieLotePropLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSSerieLotePropLista') AND type = 'P') drop procedure dbo.spIntelisisWMSSerieLotePropLista
GO             
CREATE PROCEDURE spIntelisisWMSSerieLotePropLista
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
		
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100)
		    
  SELECT @Texto =(SELECT Propiedades, Extra1 FROM SerieLoteProp
                   FOR XML AUTO)	

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
      IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
  
  END
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.SerieLotePropLista" SubReferencia="" Version="1.0"> 
--<Solicitud>  
--</Solicitud> 
--</Intelisis>'
--EXEC spIntelisisService 'DEMO',null,@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output,1
--select convert(xml,@Resultado),@Ok,@OkRef
--GO


/************** spIntelisisWMSValidarSoloCB****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSValidarSoloCB') AND type = 'P') drop procedure dbo.spIntelisisWMSValidarSoloCB
GO             
CREATE PROCEDURE spIntelisisWMSValidarSoloCB
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
		@CB					varchar(30),
	    @Articulo 			varchar(20),
	    @SubCuenta 			varchar(50),
		@Cantidad           float,
		@Tarima				varchar(20),
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100)
		
  DECLARE
  @Tabla Table(
  CB				varchar(30),
  Articulo			varchar(10),
  Subcuenta			varchar(10),
  Tarima			varchar(20)
  )		
  
   SELECT  @CB = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Codigo'  
  SELECT  @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Cantidad' 
  SELECT  @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'


  
  IF NOT EXISTS(SELECT * FROM CB WHERE Codigo = @CB)SET @Ok = 72040
  IF @Ok IS NULL
  BEGIN
    SELECT @Articulo = Cuenta, @SubCuenta=ISNULL(SubCuenta,'') FROM CB WHERE Codigo = @CB       

    IF NOT EXISTS(SELECT * FROM Tarima WHERE Tarima = @Tarima AND Estatus = 'Alta') AND @Ok IS NULL
      SELECT @OK = 13110
    
    IF NOT EXISTS(SELECT * FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Articulo = @Articulo) AND @Ok IS NULL
      SELECT @Ok = 10530

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  
    INSERT @Tabla
    SELECT @CB, @Articulo, @SubCuenta, @Tarima   
  END    

   
  SELECT @Texto = (SELECT * FROM @Tabla CB
                   FOR XML AUTO)
  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
      
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.TMA.ValidarSoloCB" SubReferencia="" Version="1.0">
--              <Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--                <Parametro Campo="Codigo" Valor="55WMS"/> 
--                <Parametro Campo="Cantidad" Valor="10"/> 
--                <Parametro Campo="Tarima" Valor="T7"/> 
--              </Solicitud>
--            </Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select convert(xml,@Resultado),@Ok,@OkRef
--GO


/************** spIntelisisWMSVaidaArticuloCB****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSVaidaArticuloCB') AND type = 'P') drop procedure dbo.spIntelisisWMSVaidaArticuloCB
GO             
CREATE PROCEDURE spIntelisisWMSVaidaArticuloCB
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
		@Texto				varchar(200),
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100),
		@CB1				varchar(30),
	    @CB2 				varchar(30),
		@Art1				varchar(30),
		@Art2				varchar(30),
		@MismoArticulo      varchar(1)
		
	SELECT  @CB1 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Codigo1'  
   SELECT  @CB2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Codigo2'  

   SELECT @art1 = Cuenta FROM CB WHERE Codigo = @CB1 
   SELECT @art2 = Cuenta FROM CB WHERE Codigo = @CB2
   
   SELECT @Art1 = rtrim(ltrim(@Art1))
   SELECT  @Art2 = rtrim(ltrim(@Art2))
   
   IF @Art1 = @Art2
     SELECT @MismoArticulo = 1
   ELSE
     SELECT @MismoArticulo = 0
   
   SELECT @Texto = '<MismoArticulo='  + CHAR(34) + isnull(@MismoArticulo,'') + CHAR(34) +'/>'
     
   IF @@ERROR <> 0 SET @Ok = 1
   BEGIN 
     SELECT @ReferenciaIS = Referencia 
       FROM IntelisisService 
      WHERE ID = @ID
     IF @@ERROR <> 0 SET @Ok = 1
      
     IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    
     SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '><Articulo Igual='  + CHAR(34) + isnull(@MismoArticulo,'') + CHAR(34) +' /></Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
  END
END
GO

/************** spIntelisisWMSListaDetalleINV****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSListaDetalleINV') AND type = 'P') drop procedure dbo.spIntelisisWMSListaDetalleINV
GO             
CREATE PROCEDURE spIntelisisWMSListaDetalleINV
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
		@ID2				int,
		@Texto				xml,
		@ReferenciaIS		varchar(100),
		@SubReferencia		varchar(100)
		
  SELECT  @ID2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro') 
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ID'  
   
  SELECT @Texto = (SELECT Renglon, 
                          ISNULL(Tarima,'')     AS Tarima,
                          ISNULL(Articulo,'')   AS Articulo, 
                          ISNULL(Cantidad,0.00) AS Cantidad,
                          ISNULL(Unidad,'')     AS Unidad 
                     FROM InvD WHERE ID = @ID2
                     FOR XML AUTO)
                     
  IF @@ERROR <> 0 SET @Ok = 1
  
  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok  
  
  SELECT @ReferenciaIS = Referencia 
    FROM IntelisisService 
   WHERE ID = @ID
  IF @@ERROR <> 0 SET @Ok = 1
      
  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    
  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
  IF @@ERROR <> 0 SET @Ok = 1
    
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.ListaDetalleINV" SubReferencia="" Version="1.0">
--              <Solicitud>    <Parametro Campo="Empresa" Valor="DEMO"/>
--                <Parametro Campo="ID" Valor="6766"/> 
--              </Solicitud>
--            </Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select convert(xml,@Resultado),@Ok,@OkRef
--GO


/************** spIntelisisArticuloEspPosicion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisArticuloEspPosicion') AND type = 'P') drop procedure dbo.spIntelisisArticuloEspPosicion
GO
CREATE PROCEDURE spIntelisisArticuloEspPosicion
    @ID                           int,
    @iSolicitud                   int,
    @Version                      float,
    @Resultado                    varchar(max) = NULL OUTPUT,
    @Ok                           int = NULL OUTPUT,
    @OkRef                        varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                        xml,
    @ReferenciaIS                 varchar(100),
    @SubReferencia                varchar(100),
    @Mov                          varchar(20),
    @MovID                        varchar(20),
    @Empresa                      varchar(5),
    @Almacen                      varchar(10),
    @Sucursal                     int,
    @Sucursal2                    varchar(100),
    @Tarima                       varchar(20),
    @Posicion                     varchar(10),
    @ArticuloEsp                  varchar(20),
    @ArtTipo                      varchar(20),
    @Descripcion1                 varchar(100),
    @UnidadCompra                 varchar(50),
    @Cantidad                     float,
    @Tipo                         varchar(20),
    @Disponible                   float,
    @DescripcionPosicion          varchar(100),
    @PosicionDestino              varchar(10),
    @DescripcionPosicionDestino   varchar(100),
    @Completo                     int,
    @Codigo                       varchar(50),
    @Descripcion                  varchar(100),
    @Zona                         varchar(50),
    @Pasillo                      varchar(50),
    @Fila                         varchar(50),
    @Nivel                        varchar(50),
    @Movimiento                   varchar(20),
    @IdTma                        int,
    @ArtCambioClave               varchar(20)

  DECLARE @Tabla Table(
    Folio                         varchar(20),
    Tarima                        varchar(20),
    Posicion                      varchar(10),
    Tipo                          varchar(20),
    ArticuloEsp                   varchar(20),
    ArtCambioClave                varchar(20),
    ArtTipo                       varchar(20),
    Descripcion1                  varchar(100),
    UnidadCompra                  varchar(50),
    DescripcionPosicion           varchar(100),
    PosicionDestino               varchar(10),
    DescripcionPosicionDestino    varchar(100),
    Zona                          varchar(50),
    Pasillo                       varchar(50),
    Fila                          varchar(50),
    Nivel                         varchar(50)
  )

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Sucursal2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Movimiento = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Movimiento'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'

  SELECT @Posicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'

  SET @Empresa    = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal2  = LTRIM(RTRIM(ISNULL(@Sucursal2,'')))
  SET @Almacen    = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Movimiento = LTRIM(RTRIM(ISNULL(@Movimiento,'')))
  SET @MovID      = LTRIM(RTRIM(ISNULL(@MovID,'')))
  SET @Tarima     = LTRIM(RTRIM(ISNULL(@Tarima,'')))
  SET @Posicion   = LTRIM(RTRIM(ISNULL(@Posicion,'')))

  SET @Mov = @Movimiento

  IF @Ok IS NULL
    IF NOT EXISTS(SELECT ISNULL(Posicion,'') FROM AlmPos WHERE Posicion = @Posicion) SET @Ok = 13030

  IF @Ok IS NULL
    IF NOT EXISTS(SELECT ISNULL(ArticuloEsp,'') FROM AlmPos WHERE Posicion = @Posicion) SET @Ok = 13075

  IF @Ok IS NULL
    BEGIN
      SELECT TOP 1 @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @Sucursal2

      SELECT @IdTma = ID
        FROM TMA
       WHERE Empresa = @Empresa
         AND Sucursal = @Sucursal
         AND Almacen = @Almacen
         AND Mov = @Mov
         AND MovID = @MovID

      SELECT @PosicionDestino = PosicionDestino
        FROM TMAD WHERE ID = @IdTma
         AND Almacen = @Almacen
         AND Posicion = @Posicion
         AND Tarima = @Tarima

      SELECT @Tipo = ap.Tipo,
             @DescripcionPosicion = ISNULL(ap.Descripcion,''),
             @ArticuloEsp = ap.ArticuloEsp,
             @ArtTipo = ar.Tipo,
             @Descripcion1 = ar.Descripcion1,
             @UnidadCompra = ar.UnidadCompra,
             @Zona = ISNULL(ap.Zona,''),
             @Pasillo = CAST(ISNULL(ap.Pasillo,0) AS Varchar(50)),
             @Fila = CAST(ISNULL(ap.Fila,0) AS Varchar(50)),
             @Nivel = CAST(ISNULL(ap.Nivel,0) AS Varchar(50))
        FROM AlmPos ap
        JOIN Art ar ON ar.Articulo = ap.ArticuloEsp
       WHERE ap.Posicion = @Posicion

      SELECT @DescripcionPosicionDestino = Descripcion
       FROM AlmPos
      WHERE Almacen = @Almacen
        AND Posicion = @PosicionDestino

      SELECT @ArtCambioClave = LTRIM(RTRIM(ISNULL(ArtCambioClave,'')))
        FROM TMAD WHERE ID = @IdTma
         AND Almacen = @Almacen
         AND Posicion = @Posicion
         AND Tarima = @Tarima
         AND Articulo = @ArticuloEsp

      INSERT @Tabla(
             Folio,Tarima,Posicion,Tipo,ArticuloEsp,
             ArtCambioClave,Descripcion1,UnidadCompra,DescripcionPosicion,PosicionDestino,
             ArtTipo,DescripcionPosicionDestino,Zona,Pasillo,Fila,
             Nivel)
      SELECT @MovID,@Tarima,@Posicion,@Tipo,@ArticuloEsp,
             @ArtCambioClave,@Descripcion1,@UnidadCompra,@DescripcionPosicion,@PosicionDestino,
             @ArtTipo,@DescripcionPosicionDestino,@Zona,@Pasillo,@Fila,
             @Nivel

      SELECT @Texto = (SELECT ISNULL(Folio,'')                      AS Folio,
                              ISNULL(Tarima,'')                     AS Tarima,
                              ISNULL(Posicion,'')                   AS Posicion,
                              ISNULL(Tipo,'')                       AS Tipo,
                              ISNULL(ArticuloEsp,'')                AS ArticuloEsp,
                              ISNULL(ArtCambioClave,'')             AS ArtCambioClave,
                              ISNULL(ArtTipo,'')                    AS ArtTipo,
                              ISNULL(Descripcion1,'')               AS Descripcion1,
                              ISNULL(UnidadCompra,'')               AS UnidadCompra,
                              ISNULL(DescripcionPosicion,'')        AS DescripcionPosicion,
                              ISNULL(PosicionDestino,'')            AS PosicionDestino,
                              ISNULL(DescripcionPosicionDestino,'') AS DescripcionPosicionDestino,
                              ISNULL(Zona,'')                       AS Zona,
                              ISNULL(Pasillo,'')                    AS Pasillo,
                              ISNULL(Fila,'')                       AS Fila,
                              ISNULL(Nivel,'')                      AS Nivel
                         FROM @Tabla AS TMA
                          FOR XML AUTO)

      IF @Texto IS NULL SET @Ok = 14055

    END

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')

END
GO
/************** spIntelisisArticuloUnidadListado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisArticuloUnidadListado') AND type = 'P') drop procedure dbo.spIntelisisArticuloUnidadListado
GO             
CREATE PROCEDURE spIntelisisArticuloUnidadListado
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
		
		@Texto						xml,
		@ReferenciaIS				varchar(100),
		@SubReferencia				varchar(100),
        @Mov						varchar(20),
        @MovID			            varchar(20),
        @Empresa				    varchar(5),
        @Sucursal			        int,
        @Sucursal2					varchar(100),
        @Tarima						varchar(20),
		@Posicion					varchar(10),
		@ArticuloEsp			    varchar(20),
		@Descripcion			    varchar(100),
		@Unidad						varchar(50),		
		@Cantidad			        float,
		@Tipo						varchar(20),
		@Disponible				    float,
	    @DescripcionPosicion		varchar(100),
		@PosicionDestino			varchar(10),
		@DescripcionPosicionDestino varchar(100)  ,
		@Completo                   int,
		@Codigo					    varchar(50),
		@CfgMultiUnidades	        bit,
		@CfgMultiUnidadesNivel      char(20)


  SELECT  @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'   
  SELECT  @ArticuloEsp  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ArticuloEsp'



   SELECT @CfgMultiUnidades         = ISNULL(MultiUnidades,0),
	      @CfgMultiUnidadesNivel    = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  IF @CfgMultiUnidadesNivel = 'ARTICULO'
      SELECT @Texto =(SELECT Unidad, ISNULL(Factor ,1) Factor
                        FROM ArtUnidad
					   WHERE Articulo=@ArticuloEsp
                FOR XML AUTO)
  IF @Texto IS NULL
      SELECT @Texto =(SELECT Unidad, ISNULL(Factor ,1) Factor
                        FROM Unidad
                FOR XML AUTO)	     
				  
  IF @Texto IS NULL -- BUG16763
	SELECT @Ok = 14055, @OkRef='' -- BUG16763	  

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    
    IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
    IF @@ERROR <> 0 SET @Ok = 1
   
  END
END
GO

/************** spIntelisisArticuloUnidadFactor ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisArticuloUnidadFactor') AND type = 'P') drop procedure dbo.spIntelisisArticuloUnidadFactor
GO
CREATE PROCEDURE spIntelisisArticuloUnidadFactor
    @ID            int,
    @iSolicitud    int,
    @Version       float,
    @Resultado     varchar(max) = NULL OUTPUT,
    @Ok            int = NULL OUTPUT,
    @OkRef         varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto                       xml,
    @ReferenciaIS                varchar(100),
    @SubReferencia               varchar(100),
    @Mov                         varchar(20),
    @MovID                       varchar(20),
    @Empresa                     varchar(5),
    @Sucursal                    int,
    @Sucursal2                   varchar(100),
    @Tarima                      varchar(20),
    @Posicion                    varchar(10),
    @ArticuloEsp                 varchar(20),
    @Descripcion                 varchar(100),
    @Unidad                      varchar(50),
    @Cantidad                    float,
    @Tipo                        varchar(20),
    @Disponible                  float,
    @DescripcionPosicion         varchar(100),
    @PosicionDestino             varchar(10),
    @DescripcionPosicionDestino  varchar(100)  ,
    @Completo                    int,
    @Codigo                      varchar(50),
    @CfgMultiUnidades            bit,
    @CfgMultiUnidadesNivel       char(20)

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @ArticuloEsp = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ArticuloEsp'

   SELECT @Unidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Unidad'

   SELECT @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Cantidad'

   SELECT @CfgMultiUnidades = ISNULL(MultiUnidades,0),
          @CfgMultiUnidadesNivel = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
     FROM EmpresaCfg2
    WHERE Empresa = @Empresa

  IF @CfgMultiUnidadesNivel = 'ARTICULO'
    SELECT @Texto = (SELECT Unidad,
                            ISNULL(Factor ,1) Factor,
                            ROUND(CAST(@Cantidad AS NUMERIC(8,2)) * CAST(ISNULL(Factor ,1) AS NUMERIC(8,2)),2) AS CantidadI
                       FROM ArtUnidad
                      WHERE Articulo = @ArticuloEsp and Unidad = @Unidad
                     FOR XML AUTO)

  IF @Texto IS NULL
    SELECT @Texto = (SELECT Unidad,
                            ISNULL(Factor ,1) Factor,
                            ROUND(CAST(@Cantidad AS NUMERIC(8,2)) * CAST(ISNULL(Factor ,1) AS NUMERIC(8,2)),2) AS CantidadI
                       FROM Unidad
                      WHERE Unidad = @Unidad
                     FOR XML AUTO)


  IF @Texto IS NULL
    SELECT @Ok = 14055, @OkRef = ''

  IF @@ERROR <> 0
    SET @Ok = 1

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @@ERROR <> 0
    SET @Ok = 1

  IF @Ok IS NOT NULL
    SELECT @Descripcion = Descripcion
      FROM MensajeLista
     WHERE Mensaje = @Ok

  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'

  IF @@ERROR <> 0
    SET @Ok = 1

END
GO

--BUG24695
/************** spIntelisisArticuloPosicionRADO ****************/
-- 05052014
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisArticuloPosicionRADO') AND type = 'P') drop procedure dbo.spIntelisisArticuloPosicionRADO
GO             
CREATE PROCEDURE spIntelisisArticuloPosicionRADO
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
		@Texto						xml,
		@ReferenciaIS				varchar(100),
		@SubReferencia				varchar(100),
        @Mov						varchar(20),
        @MovID			            varchar(20),
        @Empresa				    varchar(5),
        @Sucursal			        int,
        @Sucursal2					varchar(100),
        @Tarima						varchar(20),
		@Posicion					varchar(10),
		@ArticuloEsp			    varchar(20),
		@Descripcion1			    varchar(100),
		@UnidadCompra				varchar(50),		
		@Cantidad			        float,
		@Tipo						varchar(20),
		@Disponible				    float,
	    @DescripcionPosicion		varchar(100),
		@PosicionDestino			varchar(10),
		@DescripcionPosicionDestino varchar(100)  ,
		@Completo                   int,
		@Codigo					    varchar(50),
		@Descripcion			    varchar(100),
		@Almacen                    VARCHAR(20),
		@Usuario			        varchar(20),
        
            @Factor FLOAT,
            @Unidad VARCHAR(20),
            @Minimo FLOAT,
            --@Disponible FLOAT,
			@Agente VARCHAR(20),
			@PosicionD					varchar(10),
		        @Montacargas                varchar(20),
				 @IDAcceso					int,	
    @Estacion					int,
	@DescripcionExtra			    varchar(100) --PGC04082014

 --EWQ. Tuning      
 --SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)  
  --SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion



  DECLARE  @Tabla Table(
  Posicion						varchar(10),
  ArticuloEsp					varchar(20),
  Descripcion1			        varchar(150), --PGC04082014
  Unidad     					varchar(50),
  Cantidad						varchar(100)
  )
  
   SELECT  @Sucursal2  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'
  SELECT  @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'   
   SELECT  @Tarima  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'      
  SELECT  @Posicion  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'
   SELECT  @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'
   SELECT  @Montacargas = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Montacarga'

    SELECT @Agente = DefAgente, @Almacen=DefAlmacen, @Sucursal=Sucursal FROM Usuario WHERE Usuario = @Usuario

   --EWQ. Tuning
 ----  --Verificamos si existe algún acomodo o reacomodo pendiente
	----IF (SELECT COUNT(*) FROM TMA a /*WITH(NOLOCK)*/
 ----   INNER JOIN TMAD b /*WITH(NOLOCK)*/ ON a.ID = b.ID 
 ----   WHERE a.Mov IN('Solicitud Reacomodo','Solicitud Acomodo','Orden de Acomodo','Orden de Reacomodo')
	----AND a.Estatus = 'PENDIENTE' AND (b.Posicion = @Posicion OR b.PosicionDestino = @PosicionD) AND a.Almacen = @Almacen) > 0
	----BEGIN
	----	SELECT @Ok=13077   
	----END
	
  IF (SELECT COUNT(*) 
        FROM TMA a 
        JOIN MovTipo ON a.Mov = MovTipo.Mov AND MovTipo.Modulo = 'TMA'
        JOIN TMAD b /*WITH(NOLOCK)*/ ON a.ID = b.ID 
       WHERE MovTipo.Clave IN('TMA.ADO', 'TMA.OADO', 'TMA.ORADO', 'TMA.RADO', 'TMA.OSUR', 'TMA.TSUR')
         AND a.Estatus = 'PENDIENTE' 
         AND (b.Posicion = @Posicion OR b.PosicionDestino = @PosicionD) 
         AND a.Almacen = @Almacen) > 0 AND @Ok IS NULL
    SELECT @Ok=13077   

	--Verificamos que el movimiento sea de ubicación a ubicación
   IF (SELECT Tipo FROM AlmPos /*WITH(NOLOCK)*/ WHERE Almacen = @Almacen AND Posicion = @Posicion) <> 'Ubicacion' 
   BEGIN
      SELECT @Ok=13078    
   END
 
   IF (SELECT Tipo FROM AlmPos /*WITH(NOLOCK)*/ WHERE Almacen = @Almacen AND Posicion = @Posicion) <> 'Ubicacion' 
   BEGIN
      SELECT @Ok=13079
   END
   
    --BUG24180
    SELECT @Cantidad = Disponible FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Empresa = @Empresa
    
	IF @Cantidad <= 0 BEGIN 
       SELECT @Ok=13250
    END

	SET @ArticuloEsp=''
	SELECT @ArticuloEsp = isnull(b.Articulo,'') FROM Tarima a /*WITH(NOLOCK)*/
    INNER JOIN ArtDisponibleTarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima
    WHERE a.Almacen = @Almacen AND a.Estatus = 'ALTA' AND a.Posicion = @Posicion
    --BUG24363
    AND b.Tarima = @Tarima
    
	IF @ArticuloEsp='' Select @Ok=13030

    --EWQ. Tuning
    SELECT @Factor = dbo.fnArtUnidadFactor(@Empresa, @ArticuloEsp, UnidadTraspaso), 
           @Minimo = MinimoTarima,
		   @Unidad = UnidadTraspaso,
           @Descripcion1=a.Descripcion1,
		   --PGC04082014
		   @DescripcionExtra= ' CB:' + ISNULL(c.Codigo,'')+ 
             '-CAPACIDAD:'+CONVERT(varchar, ISNULL(a.CantidadPresentacion, 0))+ ' '+ ISNULL(a.Presentacion, '')
      FROM Art a
	  JOIN CB c ON c.Cuenta = a.Articulo --PGC04082014
     WHERE a.Articulo = @ArticuloEsp
	   /*AND c.CodigoPrincipal=1*/


--    SELECT @Factor = b.Factor, @Unidad = b.Unidad, @Minimo = MinimoTarima, @Descripcion1=a.Descripcion1
--    FROM Art a /*WITH(NOLOCK)*/ 
--    INNER JOIN ArtUnidad b /*WITH(NOLOCK)*/ ON a.Articulo =b.Articulo AND a.UnidadCompra = b.Unidad
--    WHERE a.Articulo = @ArticuloEsp   

--	SET @Disponible = 0
--    SELECT @Disponible = b.Disponible/@Factor FROM Tarima a /*WITH(NOLOCK)*/ 
--    INNER JOIN ArtDisponibleTarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima
--    WHERE a.Almacen = @Almacen AND a.Estatus = 'ALTA' AND a.Posicion = @Posicion
--
--	IF @Disponible >= @Minimo BEGIN
--		SELECT @Ok=13255
--    END

	SELECT @Cantidad=@Cantidad / @Factor
	IF @Ok IS NULL  
     INSERT @Tabla(Posicion, ArticuloEsp, Descripcion1, Unidad, Cantidad) 
	 SELECT ISNULL(@Posicion,''), ISNULL(@ArticuloEsp,''), ISNULL(@Descripcion1,'')+' '+@DescripcionExtra, ISNULL(@Unidad,''), ISNULL(@Cantidad,'')
        

   SELECT @Texto =(SELECT * FROM @Tabla TMA
                   FOR XML AUTO)
 
   IF @Ok IS NULL AND @Texto IS NULL -- BUG16763
	SELECT @Ok = 14055, @OkRef='' -- BUG16763	  
     
     IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
--SELECT @Resultado
GO

--BUG24695
/************** spIntelisisArticuloPosicionDestinoRADO ****************/
-- 05052014
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisArticuloPosicionDestinoRADO') AND type = 'P') drop procedure dbo.spIntelisisArticuloPosicionDestinoRADO
GO             
CREATE PROCEDURE spIntelisisArticuloPosicionDestinoRADO
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
		
		@Texto						xml,
		@ReferenciaIS				varchar(100),
		@SubReferencia				varchar(100),
        @Mov						varchar(20),
        @MovID			            varchar(20),
        @Empresa				    varchar(5),
        @Sucursal			        int,
        @Sucursal2					varchar(100),
        @Tarima						varchar(20),
		@Posicion					varchar(10),
		@ArticuloEsp			    varchar(20),
		@Descripcion1			    varchar(100),
		@UnidadCompra				varchar(50),		
		@Cantidad			        float,
		@Tipo						varchar(20),
		@Disponible				    float,
	    @DescripcionPosicion		varchar(100),
		@PosicionDestino			varchar(10),
		@DescripcionPosicionDestino varchar(100)  ,
		@Completo                   int,
		@Codigo					    varchar(50),
		@Descripcion			    varchar(100),
		@Almacen                    VARCHAR(20),
		@Usuario			        varchar(20),
        
            @Factor FLOAT,
            @Unidad VARCHAR(20),
            @Minimo FLOAT,
            --@Disponible FLOAT,
			@Agente VARCHAR(20)
		        
        
  DECLARE  @Tabla Table(
  Posicion						varchar(10),
  ArticuloEsp					varchar(20),
  Descripcion1			        varchar(100),
  UnidadCompra					varchar(50),
  Cantidad						varchar(100),
  DescripcionPosicion			varchar(100)
  )
  
   SELECT  @Sucursal2  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'
  SELECT  @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'   
   SELECT  @Tarima  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'      
  SELECT  @Posicion  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'
   SELECT  @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'


  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
   
  IF @Ok IS NULL  
  IF NOT EXISTS(SELECT ISNULL(Posicion,'') FROM AlmPos WHERE Posicion=@Posicion) SET @Ok=13030

        
  SELECT @Texto =(SELECT Descripcion FROM AlmPos WHERE Posicion=@Posicion 
                   FOR XML AUTO)
 
  
    IF @@ERROR <> 0 SET @Ok = 1
    
     IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
--SELECT @Resultado
GO

--BUG24695
/************** spISIntelisisTMAAfectarTMA_RADO ****************/
-- 05052014
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisTMAAfectarTMA_RADO') AND type = 'P') drop procedure dbo.spISIntelisisTMAAfectarTMA_RADO
GO             
CREATE PROCEDURE spISIntelisisTMAAfectarTMA_RADO
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  --SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  DECLARE 
		@Texto						xml,
		@ReferenciaIS				varchar(100),
		@SubReferencia				varchar(100),
        @Mov						varchar(20),
        @MovID			            varchar(20),
        @Empresa				    varchar(5),
        @Sucursal			        int,
        @Sucursal2					varchar(100),
        @Tarima						varchar(20),
		@Posicion					varchar(10),
		@ArticuloEsp			    varchar(20),
		@Descripcion1			    varchar(100),
		@UnidadCompra				varchar(50),		
		@Cantidad			        float,
		@Tipo						varchar(20),
		@Disponible				    float,
	    @DescripcionPosicion		varchar(100),
		@PosicionDestino			varchar(10),
		@DescripcionPosicionDestino varchar(100)  ,
		@Completo                   int,
		@Codigo					    varchar(50),
		@Descripcion			    varchar(100),
		@Almacen                    VARCHAR(20),
		@Usuario			        varchar(20),        
        @Factor                     FLOAT,
        @Unidad                     VARCHAR(20),
        @Minimo                     FLOAT,
        --@Disponible               FLOAT,
		@Agente                     VARCHAR(20),
		@PosicionD					varchar(10),
		@Montacargas                varchar(20),
		@IDAcceso					int,	
        @Estacion					int,
	    @Mov2  					    varchar(20),
        @Mov3  					    varchar(20),
        @MovID2   					varchar(20)
  
BEGIN TRANSACTION 
 --EWQ. Tuning
 --SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)  
  --SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion


  DECLARE  @Tabla Table(
  Posicion						varchar(10),
  ArticuloEsp					varchar(20),
  Descripcion1			        varchar(100),
  UnidadCompra					varchar(50),
  Cantidad						varchar(100),
  DescripcionPosicion			varchar(100)
  )
  
   SELECT  @Sucursal2  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'
  SELECT  @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'   
   SELECT  @Tarima  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'      
  SELECT  @Posicion  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'
   SELECT  @PosicionD  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'PosicionD'
   SELECT  @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'
   SELECT  @Montacargas = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Montacarga'

  SELECT @Agente = DefAgente, @Almacen=DefAlmacen, @Sucursal = Sucursal FROM Usuario WHERE Usuario = @Usuario

  --EWQ. Tuning
  --Verificamos si existe algún acomodo o reacomodo pendiente
  IF (SELECT COUNT(*) 
        FROM TMA a 
        JOIN MovTipo ON a.Mov = MovTipo.Mov AND MovTipo.Modulo = 'TMA'
        JOIN TMAD b /*WITH(NOLOCK)*/ ON a.ID = b.ID 
        --BUG24464
        --BUG24511
       WHERE MovTipo.Clave IN(/*'TMA.ADO', 'TMA.OADO', 'TMA.ORADO', 'TMA.RADO', */'TMA.OSUR', 'TMA.TSUR'/*, 'TMA.SADO', 'TMA.SRADO'*/)
         AND a.Estatus = 'PENDIENTE' 
         AND (b.Posicion = @Posicion OR b.PosicionDestino = @PosicionD) 
         AND a.Almacen = @Almacen) > 0 AND @Ok IS NULL
    SELECT @Ok=13077, @OkRef = NULL   

  --BUG24511    
  IF (SELECT COUNT(*) 
        FROM TMA a 
        JOIN MovTipo ON a.Mov = MovTipo.Mov AND MovTipo.Modulo = 'TMA'
        JOIN TMAD b /*WITH(NOLOCK)*/ ON a.ID = b.ID 
       WHERE MovTipo.Clave IN('TMA.ADO', 'TMA.OADO', 'TMA.ORADO', 'TMA.RADO', 'TMA.SADO', 'TMA.SRADO')
         AND a.Estatus = 'PENDIENTE' 
         AND (b.Posicion = @Posicion OR b.PosicionDestino = @PosicionD) 
         AND a.Almacen = @Almacen
         AND ISNULL(b.Procesado, 0) = 0
         ) > 0 AND @Ok IS NULL
    SELECT @Ok=13077, @OkRef = NULL       

--   --Verificamos si existe algún acomodo o reacomodo pendiente
--	IF (SELECT COUNT(*) 
--          FROM TMA a /*WITH(NOLOCK)*/
--    INNER JOIN TMAD b ON a.ID = b.ID 
--    WHERE a.Mov IN('Solicitud Reacomodo','Solicitud Acomodo','Orden de Acomodo','Orden de Reacomodo')
--	AND a.Estatus = 'PENDIENTE' AND (b.Posicion = @Posicion OR b.PosicionDestino = @PosicionD) AND a.Almacen = @Almacen) > 0
--	BEGIN
--		SELECT @Ok=13077   
--	END

	--Verificamos que el movimiento sea de ubicación a ubicación
   IF @Ok IS NULL AND (SELECT Tipo FROM AlmPos /*WITH(NOLOCK)*/ WHERE Almacen = @Almacen AND Posicion = @Posicion) <> 'Ubicacion' BEGIN
      SELECT @Ok=13078, @OkRef = @Posicion
   END
 
   --EWQ. Tuning
   IF @Ok IS NULL AND (SELECT Tipo FROM AlmPos /*WITH(NOLOCK)*/ WHERE Almacen = @Almacen AND Posicion = @PosicionD) <> 'Ubicacion' BEGIN
      SELECT @Ok=13079, @OkRef = @PosicionD
   END

   --EWQ. Tuning
   IF dbo.fnAlmPosTieneCapacidad(@Empresa, @Almacen, @PosicionD, @Tarima) = 0 --BUG24670
     SELECT @Ok = 13220, @OkRef = @PosicionD

    --BUG24180
    SELECT @Cantidad = Disponible FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Empresa = @Empresa

	IF @Cantidad <= 0 BEGIN 
       SELECT @Ok=13250
    END

	SET @ArticuloEsp=''
	SELECT @ArticuloEsp = isnull(b.Articulo,'') FROM Tarima a /*WITH(NOLOCK)*/
    INNER JOIN ArtDisponibleTarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima
    WHERE a.Almacen = @Almacen AND a.Estatus = 'ALTA' AND a.Posicion = @Posicion
    --BUG24364
     AND b.Tarima = @Tarima

	IF @Ok IS NULL AND @ArticuloEsp='' Select @Ok=13030

    IF @Ok IS NULL  
    IF NOT EXISTS(SELECT ISNULL(Posicion,'') FROM AlmPos WHERE Posicion=@PosicionD) SET @Ok=13030

    --EWQ. Tuning
    SELECT @Factor = dbo.fnArtUnidadFactor(@Empresa, @ArticuloEsp, UnidadTraspaso), 
           @Minimo = MinimoTarima,
		   @Unidad = UnidadTraspaso,
           @Descripcion1=a.Descripcion1
      FROM Art a
     WHERE a.Articulo = @ArticuloEsp

--    SELECT @Factor = b.Factor, @Unidad = b.Unidad, @Minimo = MinimoTarima
--    FROM Art a /*WITH(NOLOCK)*/ 
--    INNER JOIN ArtUnidad b /*WITH(NOLOCK)*/ ON a.Articulo =b.Articulo AND a.UnidadCompra = b.Unidad
--    WHERE a.Articulo = @ArticuloEsp
--
--	SET @Disponible = 0
--    SELECT @Disponible = b.Disponible/@Factor FROM Tarima a /*WITH(NOLOCK)*/ 
--    INNER JOIN ArtDisponibleTarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima
--    WHERE a.Almacen = @Almacen AND a.Estatus = 'ALTA' AND a.Posicion = @Posicion
--
--	IF @Disponible >= @Minimo BEGIN
--		SELECT @Ok=13255
--    END
	
	IF @Ok IS NULL
	BEGIN
		INSERT INTO TMA (Empresa, Mov, FechaEmision, Usuario, Referencia, Estatus, Sucursal, Almacen, Agente,
		Montacarga, Prioridad, SucursalOrigen, SucursalDestino)
		SELECT @Empresa, 'Reacomodo',dbo.fnFechaSinHora(getdate()), @Usuario, 'Reacomodo Directo','SINAFECTAR',
		@Sucursal, @Almacen, @Agente, @Montacargas, 'Normal', @Sucursal, @Sucursal

		SET @ID = @@IDENTITY    

		INSERT INTO TMAD (ID, Renglon, Tarima, Almacen, Posicion, PosicionDestino, Sucursal, Prioridad, Montacarga, Unidad, CantidadUnidad, CantidadPicking)
		SELECT @ID, 0, @Tarima, @Almacen, @Posicion, @PosicionD, @Sucursal,'Normal',@Agente,@Unidad,@Cantidad / @Factor, @Cantidad

		CREATE TABLE #MovR
		 (Folio VARCHAR(255) NULL, Descripcion VARCHAR(255) NULL,Tipo VARCHAR(20) NULL, Valor VARCHAR(255) NULL, ID INT NULL)
		INSERT INTO #MovR
		EXEC spAfectar 'TMA', @ID, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT ,@OkRef = @OkRef OUTPUT 
		IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL
	END

	IF @Ok IS NULL
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID

  SELECT @Mov2='', @MovID2=''
  IF @Ok IS NULL   
  BEGIN      
    SELECT @Mov2 = isnull(Mov,'') , @MovID2 = isnull(MovID,'') FROM TMA WHERE ID = @ID          
  END 

  IF @@ERROR <> 0 SET @Ok = 1      
    IF @Ok IS NOT NULL SELECT @OkRef = REPLACE(Descripcion, '<BR>', '') FROM MensajeLista WHERE Mensaje = @Ok   

  IF @Ok IS NULL   
    BEGIN  
      IF (SELECT Estatus FROM TMA WHERE ID = @ID) = 'SINAFECTAR'  
        SELECT @Ok = -1  
      ELSE          
        SELECT @OkRef = RTRIM(Mov)+' '+RTRIM(MovID) FROM TMA WHERE ID = @ID
    END

  IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(NULL,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'

  IF @@ERROR <> 0 SET @Ok = 1
  
  IF @Ok IS NULL OR @Ok = -1
  BEGIN
    COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
  END
  
  END
--SELECT @Resultado
GO

--BUG24696
/************** spIntelisisArticuloPosicionRADOPck ****************/
-- 05052014
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisArticuloPosicionRADOPck') AND type = 'P') drop procedure dbo.spIntelisisArticuloPosicionRADOPck
GO             
CREATE PROCEDURE spIntelisisArticuloPosicionRADOPck
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
		@Texto						xml,
		@ReferenciaIS				varchar(100),
		@SubReferencia				varchar(100),
        @Mov						varchar(20),
        @MovID			            varchar(20),
        @Empresa				    varchar(5),
        @Sucursal			        int,
        @Sucursal2					varchar(100),
        @Tarima						varchar(20),
		@Posicion					varchar(10),
		@ArticuloEsp			    varchar(20),
		@Descripcion1			    varchar(100),
		@UnidadCompra				varchar(50),		
		@Cantidad			        float,
		@Tipo						varchar(20),
		@Disponible				    float,
	    @DescripcionPosicion		varchar(100),
		@PosicionDestino			varchar(10),
		@DescripcionPosicionDestino varchar(100)  ,
		@Completo                   int,
		@Codigo					    varchar(50),
		@Descripcion			    varchar(100),
		@Almacen                    VARCHAR(20),
		@Usuario			        varchar(20),
        
            @Factor FLOAT,
            @Unidad VARCHAR(20),
            @Minimo FLOAT,
            --@Disponible FLOAT,
			@Agente VARCHAR(20),
			@PosicionD					varchar(10),
		        @Montacargas                varchar(20),
				 @IDAcceso					int,	
    @Estacion					int

 --EWQ. Tuning      
 --SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)  
  --SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion



  DECLARE  @Tabla Table(
  Posicion						varchar(10),
  ArticuloEsp					varchar(20),
  Descripcion1			        varchar(150), --PGC04082014
  Unidad     					varchar(50),
  Cantidad						varchar(100)
  )
  
   SELECT  @Sucursal2  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'
  SELECT  @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'      
  SELECT  @Posicion  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'
   SELECT  @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'
   SELECT  @Montacargas = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Montacarga'

    SELECT @Agente = DefAgente, @Almacen=DefAlmacen, @Sucursal=Sucursal FROM Usuario WHERE Usuario = @Usuario

   --Verificamos si existe algún acomodo o reacomodo pendiente
	IF (SELECT COUNT(*) FROM TMA a /*WITH(NOLOCK)*/
    INNER JOIN TMAD b /*WITH(NOLOCK)*/ ON a.ID = b.ID 
	INNER JOIN MovTipo m ON m.Mov = a.Mov AND m.Modulo = 'TMA'
    WHERE m.Clave IN ('TMA.OADO','TMA.ORADO','TMA.SADO','TMA.SRADO')
	AND a.Estatus = 'PENDIENTE' AND (b.Posicion = @Posicion) AND a.Almacen = @Almacen
	--BUG24511
	AND ISNULL(b.Procesado, 0) = 0
	) > 0
	BEGIN
		SELECT @Ok=13077   
	END

--	--Verificamos que el movimiento sea de ubicación a ubicación
--   IF (SELECT Tipo FROM AlmPos /*WITH(NOLOCK)*/ WHERE Almacen = @Almacen AND Posicion = @Posicion) <> 'Ubicacion' BEGIN
--      SELECT @Ok=13078    
--   END
-- 
--   IF (SELECT Tipo FROM AlmPos /*WITH(NOLOCK)*/ WHERE Almacen = @Almacen AND Posicion = @Posicion) <> 'Ubicacion' BEGIN
--      SELECT @Ok=13079
--   END

    SELECT @Cantidad = ISNULL(Disponible,0) FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen
    
	IF @Cantidad <= 0 BEGIN 
       SELECT @Ok=13250
    END
      
	SET @ArticuloEsp=''
	SELECT @ArticuloEsp = ISNULL(b.Articulo,'') FROM Tarima a /*WITH(NOLOCK)*/
    INNER JOIN ArtDisponibleTarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima
    WHERE a.Almacen = @Almacen AND a.Estatus = 'ALTA' AND a.Posicion = @Posicion
	IF @ArticuloEsp='' Select @Ok=13030

    SELECT @Factor = ISNULL(b.Factor,1), @Unidad = b.Unidad, @Minimo = ISNULL(MinimoTarima,1), 
	       @Descripcion1=a.Descripcion1+' '+'CB:' + ISNULL(c.Codigo,'')+' -CAPACIDAD:'+CONVERT(varchar, ISNULL(a.CantidadPresentacion, 0))+ ' '+ ISNULL(a.Presentacion, '') --PGC04082014
    FROM Art a /*WITH(NOLOCK)*/ 
    INNER JOIN ArtUnidad b /*WITH(NOLOCK)*/ ON a.Articulo =b.Articulo AND a.UnidadCompra = b.Unidad
	JOIN CB c ON c.Cuenta = a.Articulo --PGC04082014
    WHERE a.Articulo = @ArticuloEsp
	  /*AND c.CodigoPrincipal=1*/

	SET @Disponible = 0
    SELECT @Disponible = b.Disponible/@Factor FROM Tarima a /*WITH(NOLOCK)*/
    INNER JOIN ArtDisponibleTarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima
    WHERE a.Almacen = @Almacen AND a.Estatus = 'ALTA' AND a.Posicion = @Posicion

	--IF @Disponible >= @Minimo BEGIN
	--	SELECT @Ok=13255
 --   END

	SELECT @Cantidad=@Cantidad / @Factor
	IF @Ok IS NULL  
     INSERT @Tabla(Posicion, ArticuloEsp, Descripcion1, Unidad, Cantidad) 
	 SELECT ISNULL(@Posicion,''), ISNULL(@ArticuloEsp,''), ISNULL(@Descripcion1,''), ISNULL(@Unidad,''), ISNULL(@Cantidad,'')
        

   SELECT @Texto =(SELECT * FROM @Tabla TMA
                   FOR XML AUTO)
 
   IF @Ok IS NULL AND @Texto IS NULL -- BUG16763
	SELECT @Ok = 14055, @OkRef='' -- BUG16763	  
     
     IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
--SELECT @Resultado
GO
--BUG24696
/************** spIntelisisArticuloPosicionDestinoRADOPck ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisArticuloPosicionDestinoRADOPck') AND type = 'P') drop procedure dbo.spIntelisisArticuloPosicionDestinoRADOPck
GO             
CREATE PROCEDURE spIntelisisArticuloPosicionDestinoRADOPck
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
		
		@Texto						xml,
		@ReferenciaIS				varchar(100),
		@SubReferencia				varchar(100),
        @Mov						varchar(20),
        @MovID			            varchar(20),
        @Empresa				    varchar(5),
        @Sucursal			        int,
        @Sucursal2					varchar(100),
        @Tarima						varchar(20),
		@Posicion					varchar(10),
		@ArticuloEsp			    varchar(20),
		@Descripcion1			    varchar(100),
		@UnidadCompra				varchar(50),		
		@Cantidad			        float,
		@Tipo						varchar(20),
		@Disponible				    float,
	    @DescripcionPosicion		varchar(100),
		@PosicionDestino			varchar(10),
		@DescripcionPosicionDestino varchar(100)  ,
		@Completo                   int,
		@Codigo					    varchar(50),
		@Descripcion			    varchar(100),
		@Almacen                    VARCHAR(20),
		@Usuario			        varchar(20),
        
            @Factor FLOAT,
            @Unidad VARCHAR(20),
            @Minimo FLOAT,
            --@Disponible FLOAT,
			@Agente VARCHAR(20)
		        
        
  DECLARE  @Tabla Table(
  Posicion						varchar(10),
  ArticuloEsp					varchar(20),
  Descripcion1			        varchar(100),
  UnidadCompra					varchar(50),
  Cantidad						varchar(100),
  DescripcionPosicion			varchar(100)
  )
  
   SELECT  @Sucursal2  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'
  SELECT  @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'   
   SELECT  @Tarima  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'      
  SELECT  @Posicion  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'
   SELECT  @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'


  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario

  --Verificamos si existe algún acomodo o reacomodo pendiente	
	IF (SELECT COUNT(*) FROM TMA a /*WITH(NOLOCK)*/
    INNER JOIN TMAD b /*WITH(NOLOCK)*/ ON a.ID = b.ID 
	INNER JOIN MovTipo m ON m.Mov = a.Mov AND m.Modulo = 'TMA'
    WHERE m.Clave IN ('TMA.OADO','TMA.ORADO','TMA.SADO','TMA.SRADO')
	AND a.Estatus = 'PENDIENTE' AND (b.Posicion = @Posicion) AND a.Almacen = @Almacen
	--BUG24511
	AND ISNULL(b.Procesado, 0) = 0
	) > 0
	BEGIN
		SELECT @Ok=13077   
	END

   
  IF @Ok IS NULL  
  IF NOT EXISTS(SELECT ISNULL(Posicion,'') FROM AlmPos WHERE Posicion=@Posicion) SET @Ok=13030

        
  SELECT @Texto =(SELECT Descripcion FROM AlmPos WHERE Posicion=@Posicion 
                   FOR XML AUTO)
 
  
    IF @@ERROR <> 0 SET @Ok = 1
    
     IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
--SELECT @Resultado
GO
--BUG24696
/************** spIntelisisRADOPck_MovListado ****************/
-- 05052014
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisRADOPck_MovListado') AND type = 'P') drop procedure dbo.spIntelisisRADOPck_MovListado
GO             
CREATE PROCEDURE spIntelisisRADOPck_MovListado
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
		
		@Texto						xml,
		@ReferenciaIS				varchar(100),
		@SubReferencia				varchar(100),
        @Mov						varchar(20),
        @MovID			            varchar(20),
        @Empresa				    varchar(5),
        @Sucursal			        int,
        @Sucursal2					varchar(100),
        @Tarima						varchar(20),
		@Posicion					varchar(10),
		@ArticuloEsp			    varchar(20),
		@Descripcion1			    varchar(100),
		@UnidadCompra				varchar(50),		
		@Cantidad			        float,
		@Tipo						varchar(20),
		@Disponible				    float,
	    @DescripcionPosicion		varchar(100),
		@PosicionDestino			varchar(10),
		@DescripcionPosicionDestino varchar(100)  ,
		@Completo                   int,
		@Codigo					    varchar(50),
		@Descripcion			    varchar(100),
		@Almacen                    VARCHAR(20),
		@Usuario			        varchar(20),
        
            @Factor FLOAT,
            @Unidad VARCHAR(20),
            @Minimo FLOAT,
            --@Disponible FLOAT,
			@Agente VARCHAR(20),
			@PosicionD					varchar(10),
		        @Montacargas                varchar(20),
				 @IDAcceso					int,	
    @Estacion					int

 --EWQ. Tuning      
 --SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)  
  --SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion
  

  DECLARE  @Tabla Table(
  Tarima                        varchar(20),
  Posicion						varchar(10),
  FechaCaducidad                datetime,
  Disponible   				    varchar(100),
  Cantidad						varchar(100),
  Unidad     					varchar(50)
  --DescripcionPosicion           varchar(100)
  )
  
   SELECT  @Sucursal2  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'
  SELECT  @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'   
   SELECT  @ArticuloEsp  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ArticuloEsp'      
  SELECT  @Posicion  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'
  SELECT  @Usuario  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

   SELECT @Agente = DefAgente, @Almacen=DefAlmacen, @Sucursal=Sucursal FROM Usuario WHERE Usuario = @Usuario

-- 	--Verificamos si existe algún acomodo o reacomodo pendiente
	IF (SELECT COUNT(*) FROM TMA a /*WITH(NOLOCK)*/
    INNER JOIN TMAD b /*WITH(NOLOCK)*/ ON a.ID = b.ID 
	INNER JOIN MovTipo m ON m.Mov = a.Mov AND m.Modulo = 'TMA'
    WHERE m.Clave IN ('TMA.OADO','TMA.ORADO','TMA.SADO','TMA.SRADO')
	AND a.Estatus = 'PENDIENTE' AND (b.Posicion = @Posicion) AND a.Almacen = @Almacen
	--BUG24511
	AND ISNULL(b.Procesado, 0) = 0
	) > 0
	BEGIN
		SELECT @Ok=13077   
	END

   --Verificamos que el movimiento sea de ubicación a ubicación
--   IF (SELECT Tipo FROM AlmPos /*WITH(NOLOCK)*/ WHERE Almacen = @Almacen AND Posicion = @Posicion) <> 'Ubicacion' BEGIN
--      SELECT @Ok=13078    
--   END

	IF @Ok IS NULL
	BEGIN	  
	      INSERT @Tabla(Posicion, Tarima, FechaCaducidad, Disponible, Cantidad, Unidad /*, DescripcionPosicion*/)
	      SELECT b.Posicion, a.Tarima, b.FechaCaducidad, a.Disponible, a.Disponible/d.Factor AS Cantidad, c.UnidadCompra AS Unidad /*, ISNULL(ap.Descripcion,'')*/
            FROM ArtdisponibleTarima a /*WITH(NOLOCK)*/
	       INNER JOIN Tarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima AND a.Almacen = b.Almacen
           INNER JOIN Art c ON a.Articulo = c.Articulo
           INNER JOIN ArtUnidad d ON d.Articulo = a.Articulo AND d.Unidad = c.UnidadCompra
           INNER JOIN AlmPos ap ON ap.Almacen = a.Almacen AND ap.Posicion = b.Posicion	  
           WHERE a.Articulo = @ArticuloEsp AND ap.Tipo = 'Ubicacion' AND b.Estatus = 'ALTA'
             AND a.Disponible > 0 AND a.Almacen = @Almacen 
        ORDER BY a.Tarima
     END

   SELECT @Texto =(SELECT ISNULL(Tarima, '') 'Tarima', ISNULL(Posicion, '') 'Posicion', ISNULL(FechaCaducidad, '') 'FechaCaducidad', ISNULL(Disponible, '') 'Disponible', ISNULL(Cantidad, '') 'Cantidad', ISNULL(Unidad, '') 'Unidad' FROM @Tabla FOR XML AUTO)
 
   IF @Ok IS NULL AND @Texto IS NULL -- BUG16763
	SELECT @Ok = 14055, @OkRef='' -- BUG16763	  
     
     IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
--SELECT @Resultado
GO
--BUG24696
/************** spISIntelisisTMAAfectarTMA_RADOPck ****************/
-- 05052014
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisTMAAfectarTMA_RADOPck') AND type = 'P') drop procedure dbo.spISIntelisisTMAAfectarTMA_RADOPck
GO             
CREATE PROCEDURE spISIntelisisTMAAfectarTMA_RADOPck
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)	= NULL OUTPUT,
		@Ok				int				= NULL OUTPUT,    
		@OkRef			varchar(255)	= NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN  
  -- SET nocount ON
  DECLARE 
		@Texto						xml,
		@ReferenciaIS				varchar(100),
		@SubReferencia				varchar(100),
        @Mov						varchar(20),
        @MovID			            varchar(20),
        @Empresa				    varchar(5),
        @Sucursal			        int,
        @Sucursal2					varchar(100),
        @Tarima						varchar(20),
        @TarimaDestino				varchar(20),
		@Posicion					varchar(10),
		@ArticuloEsp			    varchar(20),
		@ArticuloDestino		    varchar(20),
		@Descripcion1			    varchar(100),
		@UnidadCompra				varchar(50),		
		@Cantidad			        float,
		@Tipo						varchar(20),
	    @DescripcionPosicion		varchar(100),
		@PosicionDestino			varchar(10),
		@DescripcionPosicionDestino varchar(100),
		@Completo                   int,
		@Codigo					    varchar(50),
		@Descripcion			    varchar(100),
		@Almacen                    VARCHAR(20),
		@Usuario			        varchar(20),
        
        @Factor                     FLOAT,
        @Unidad                     VARCHAR(20),
        @Minimo                     FLOAT,
		@Agente                     VARCHAR(20),
		@PosicionD					varchar(10),
		@Montacargas                varchar(20),
		@IDAcceso					int,	
        @Estacion					int,
		@CantidadPck                float,
		@MovAjuste					varchar(20),
        @RenglonID					float,    
        @RenglonID2					float,
        @ContMoneda					varchar(10),
		@RenglonTipo				varchar(1),
		@ArtTipo					varchar(20),
        @Costo						float,
        @TipoCosteo					varchar(20),
        @Concepto					varchar(50),
        @Observaciones				varchar(100)
 
  BEGIN TRANSACTION 
 
 SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion
    
   SELECT  @Sucursal2  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'
  SELECT  @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'   
   SELECT  @Tarima  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'      
  SELECT  @Posicion  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'
   SELECT  @PosicionD  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'PosicionD'
   SELECT  @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'
   SELECT  @Montacargas = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Montacarga'
   SELECT  @ArticuloEsp  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'
   SELECT  @CantidadPck = CONVERT(float, Valor) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro') 
    WITH (Campo varchar(255), Valor varchar(255))  
   WHERE Campo = 'CantidadPck'      

  SELECT @ContMoneda = ContMoneda ,
         @TipoCosteo = ISNULL(NULLIF(RTRIM(UPPER(TipoCosteo)), ''), 'PROMEDIO')
    FROM EmpresaCfg 
   WHERE Empresa = @Empresa

  SELECT @Agente = DefAgente, @Almacen=DefAlmacen, @Sucursal = Sucursal FROM Usuario WHERE Usuario = @Usuario

  --SELECT @MovAjuste = InvAjuste FROM EmpresaCfgMov WHERE Empresa = @Empresa  
  
  SELECT @MovAjuste = 'Ajuste Posicion WMS'

  SELECT @Concepto = Concepto FROM EmpresaConcepto WHERE Empresa = @Empresa AND Modulo = 'INV' AND Mov = @MovAjuste

  IF @CantidadPck <= 0 SET @Ok=20010

  --Verificamos si la Posicion destino es domicilio, que corresponda al artículo     
  SELECT @Tipo = Tipo, 
         @ArticuloDestino = ArticuloEsp
    FROM AlmPos 
   WHERE Posicion = @PosicionD  
     AND Almacen = @Almacen 
     AND Estatus = 'ALTA'  

  --EWQ. Tuning2
  SELECT @TarimaDestino = MIN(a.Tarima)
    FROM ArtDisponibleTarima a 
    JOIN Tarima t ON t.Tarima = a.Tarima 
    JOIN AlmPos p ON p.Posicion = t.Posicion  AND p.Almacen = @Almacen
   WHERE a.Articulo = @ArticuloDestino 
     AND p.Tipo = 'Domicilio' 
     AND a.Disponible > 0
     AND t.Estatus = 'ALTA' AND t.Tarima NOT LIKE '%-%'
     AND p.Posicion = @PosicionD
     AND p.ArticuloEsp = @ArticuloDestino

  IF @TarimaDestino IS NULL
    SELECT @TarimaDestino = MIN(a.Tarima)
      FROM ArtDisponibleTarima a 
      JOIN Tarima t ON t.Tarima = a.Tarima 
      JOIN AlmPos p ON p.Posicion = t.Posicion  AND p.Almacen = @Almacen
     WHERE a.Articulo = @ArticuloDestino 
       AND p.Tipo = 'Domicilio' 
       AND t.Estatus = 'ALTA' AND t.Tarima NOT LIKE '%-%'
       AND p.Posicion = @PosicionD
       AND p.ArticuloEsp = @ArticuloDestino

  IF @TarimaDestino IS NULL
    SELECT @TarimaDestino = MIN(a.Tarima)
      FROM ArtDisponibleTarima a 
      JOIN Tarima t ON t.Tarima = a.Tarima 
      JOIN AlmPos p ON p.Posicion = t.Posicion  AND p.Almacen = @Almacen
     WHERE a.Articulo = @ArticuloDestino 
       AND p.Tipo = 'Domicilio' 
       AND t.Estatus = 'BAJA' AND t.Tarima NOT LIKE '%-%'
       AND p.Posicion = @PosicionD
       AND p.ArticuloEsp = @ArticuloDestino

  IF @Ok IS NULL AND ISNULL(@Tipo, '') <> 'Domicilio' AND ISNULL(@Tipo, '') <> ''
    SELECT @Ok=13035

  IF @Ok IS NULL AND (@Tipo = 'Domicilio' AND ISNULL(@ArticuloDestino, '') <> ISNULL(@ArticuloEsp, '')) 
    SELECT @Ok=10530, @OkRef = @ArticuloEsp

  SELECT @Factor = dbo.fnArtUnidadFactor(@Empresa, @ArticuloEsp, UnidadTraspaso), 
         @Minimo = MinimoTarima,
         @ArtTipo = Tipo,
		 @Unidad = UnidadTraspaso
    FROM Art a
   WHERE a.Articulo = @ArticuloEsp

  EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT

  EXEC spVerCosto @Sucursal, @Empresa, NULL, @ArticuloEsp, NULL, @Unidad, @TipoCosteo, @ContMoneda, 1, @Costo OUTPUT, 0

  SELECT @Cantidad = Disponible/@Factor 
    FROM ArtDisponibleTarima /*WITH (NOLOCK)*/
   WHERE Tarima = @Tarima 
     AND Almacen = @Almacen   
     AND Articulo = @ArticuloEsp
     AND Empresa = @Empresa	  

  --Verificamos si existe algún acomodo o reacomodo pendiente
  IF (SELECT COUNT(*) 
        FROM TMA a 
        JOIN MovTipo ON a.Mov = MovTipo.Mov AND MovTipo.Modulo = 'TMA'
        JOIN TMAD b /*WITH(NOLOCK)*/ ON a.ID = b.ID 
        --BUG24455
        --BUG24511
       WHERE MovTipo.Clave IN(/*'TMA.ADO', 'TMA.OADO', 'TMA.ORADO', 'TMA.RADO', */'TMA.OSUR', 'TMA.TSUR'/*, 'TMA.SADO', 'TMA.SRADO'*/)
         AND a.Estatus = 'PENDIENTE' 
         AND b.Tarima = @Tarima 
         AND a.Almacen = @Almacen) > 0 AND @Ok IS NULL
    SELECT @Ok=13077   

  --BUG24511
  IF @Ok IS NULL AND (SELECT COUNT(*) 
        FROM TMA a 
        JOIN MovTipo ON a.Mov = MovTipo.Mov AND MovTipo.Modulo = 'TMA'
        JOIN TMAD b /*WITH(NOLOCK)*/ ON a.ID = b.ID 
       WHERE MovTipo.Clave IN('TMA.ADO', 'TMA.OADO', 'TMA.ORADO', 'TMA.RADO', 'TMA.SADO', 'TMA.SRADO')
         AND a.Estatus = 'PENDIENTE' 
         AND ISNULL(b.Procesado, 0) = 0
         AND b.Tarima = @Tarima 
         AND a.Almacen = @Almacen) > 0 AND @Ok IS NULL
    SELECT @Ok=13077   

  IF @Ok IS NULL AND NOT EXISTS(SELECT ISNULL(Posicion,'') FROM AlmPos WHERE Posicion=@PosicionD AND Almacen = @Almacen) SELECT @Ok=13030, @OkRef = @PosicionD
  IF @Ok IS NULL AND NOT EXISTS(SELECT ISNULL(Posicion,'') FROM AlmPos WHERE Posicion=@Posicion AND Almacen = @Almacen) SELECT @Ok=13030, @OkRef = @Posicion
  IF @Ok IS NULL AND @CantidadPCK > @Cantidad SELECT @Ok=20020, @OkRef = @ArticuloEsp

  IF @CantidadPck = @Cantidad 
    SELECT @Observaciones = 'Reacomodo Tarima Completa'
  ELSE
    SELECT @Observaciones = 'Reacomodo Picking'

  IF @Ok IS NULL
  BEGIN     
    INSERT INTO Inv (
				Empresa,  Mov,       FechaEmision,                  Moneda,      TipoCambio,  Usuario, Estatus,       Almacen,  Sucursal,  SucursalOrigen, Concepto,  Observaciones)  
		SELECT @Empresa, @MovAjuste, dbo.fnFechaSinHora(GETDATE()), @ContMoneda, 1,          @Usuario, 'SINAFECTAR', @Almacen, @Sucursal, @Sucursal,      @Concepto, @Observaciones

    SET @ID = @@IDENTITY  

    --BUG25368
    INSERT INTO InvD (
				ID, Renglon, RenglonSub, RenglonID, RenglonTipo,  Cantidad,     Almacen,  Articulo,     Costo,  Unidad,  Factor,  CantidadInventario,   Sucursal,  SucursalOrigen,  Tarima,         PosicionActual,  PosicionReal)  
		SELECT @ID, 2048,    0,          1,        @RenglonTipo, @CantidadPck, @Almacen, @ArticuloEsp, @Costo, @Unidad, @Factor, @CantidadPck*@Factor, @Sucursal, @Sucursal,       @TarimaDestino, @PosicionD,      @PosicionD

    --BUG25368
    INSERT INTO InvD (
				ID, Renglon, RenglonSub, RenglonID, RenglonTipo,   Cantidad,     Almacen,  Articulo,     Costo,  Unidad,  Factor,   CantidadInventario,   Sucursal,  SucursalOrigen,  Tarima,  PosicionActual, PosicionReal)  
		SELECT @ID, 2048,    1,          1,        @RenglonTipo, -@CantidadPck, @Almacen, @ArticuloEsp, @Costo, @Unidad, @Factor, -@CantidadPck*@Factor, @Sucursal, @Sucursal,       @Tarima, @Posicion,      @Posicion

    EXEC spAfectar 'INV', @ID, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT ,@OkRef = @OkRef OUTPUT 

	IF @Ok BETWEEN 80030 AND 81000 OR @Ok IS NULL SELECT @Ok = NULL , @OkRef = RTRIM(Mov)+' '+RTRIM(MovID) FROM Inv WHERE ID = @ID
  END
   

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
  END
     
  IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'

  IF @@ERROR <> 0 SET @Ok = 1
    
END
GO
--BUG24696
/**************** spIntelisisWMSInfoPesoTarima ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoPesoTarima') and type = 'P') drop procedure dbo.spIntelisisWMSInfoPesoTarima
GO             
CREATE PROCEDURE spIntelisisWMSInfoPesoTarima 
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
    @IDGenerar					int,
    @IDAcceso					int,	
    @MovTipo					varchar(20),
    @ReferenciaIS				varchar(100),
    @Usuario2					varchar(10),
    @Estacion					int,
    @SubReferencia				varchar(100),
    @Empresa   				    varchar(5),
    @Mov   					    varchar(20),
    @MovID   					varchar(20),
    @Sucursal                   int,
    @ID2                        int,
    @Tarima                     varchar(20),
    @Sucursal2                  varchar(100),
--    @Posicion                   varchar(20),
    @PosicionDestino            varchar(20),
    @Usuario                    varchar(15),
    @Montacargas                varchar(20),
    @Estatus                    varchar(20),
    @Agente                     varchar(20),
    @Modificar                  bit,
    @Procesado                  bit,
    @Mov2  					    varchar(20),
    @MovID2   					varchar(20),
    @PosicionDGenerar           varchar(20),
    @Descripcion                varchar(100),
    @Movimiento					varchar(20),
    @Tipo						varchar(20),
	@TarimaSurtido              varchar(20), --22042014. Tarima surtido para insertar a tabla asTMASurtido
	@PesoTarimaCalculado        float,
    @Texto				        xml    --30062014
    


   DECLARE @Tabla table(
		  PesoTarima   float)


--EWQ. Tuning
  --SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  --SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion
  

  
  IF @Ok IS NULL
  BEGIN  
     SELECT  @Empresa = NULLIF(Empresa,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Empresa    varchar(255))
     SELECT  @MovID = NULLIF(MovID,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(MovID    varchar(255))  
     SELECT  @Mov= NULLIF(Mov,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Mov    varchar(255)) 
     SELECT  @Tarima = NULLIF(Tarima,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Tarima   varchar(255))
--     SELECT  @Posicion = NULLIF(Posicion,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
--       WITH(Posicion   varchar(255))  
     SELECT  @PosicionDestino = NULLIF(PosicionDestino,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(PosicionDestino   varchar(255))  
     SELECT  @Usuario = NULLIF(Usuario,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Usuario   varchar(255))   
     SELECT  @Sucursal2 = NULLIF(Sucursal,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Sucursal   varchar(255))  
     SELECT  @Montacargas = NULLIF(Montacarga,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
       WITH(Montacarga   varchar(255))        
   END

  SELECT @MovTipo = Clave FROM MovTipo WHERE Mov = @Mov AND Modulo = 'TMA'
  SELECT @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @Sucursal2

  SELECT @ID2=t.ID, @MovID = t.MovID, @Mov=t.Mov FROM TMA t JOIN TMAD d  ON t.ID = d.ID WHERE t.Empresa = @Empresa AND d.Tarima = @Tarima AND t.Mov = @Mov AND t.MovID = @MovID

  IF @MovTipo NOT IN ('TMA.TSUR') SELECT @Ok = 35005, @OkRef = @Mov 
  IF @Ok IS NULL
  BEGIN  
    
    IF NOT EXISTS(SELECT * FROM Montacarga WHERE Montacarga = @Montacargas) SELECT @Ok = 20936
    
    IF NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE  d.Tarima = @Tarima  AND t.Empresa = @Empresa AND t.Mov=@Mov AND t.MovID= @MovID) SELECT @Ok = 13110
 
    IF NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d. ID  WHERE  d.Tarima = @Tarima AND d.PosicionDestino = @PosicionDestino AND t.Empresa = @Empresa AND t.Mov=@Mov AND t.MovID= @MovID) SELECT @Ok = 13035
  END

 IF @Ok IS NULL 
    INSERT INTO @Tabla   SELECT dbo.fnTarimaPeso(@ID2, @Tarima)

 SELECT @Texto =(SELECT CONVERT(varchar,PesoTarima) PesoTarima FROM @Tabla 
                   FOR XML AUTO)
 
IF @@ERROR <> 0 SET @Ok = 1
  BEGIN 
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1  
   
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +  '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'      --SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34)+ ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' PesoTarima=' + CHAR(34) + ISNULL(CONVERT(varchar, @PesoTarimaCalculado),'') + CHAR(34) +  ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
  END
END
GO
--BUG24696
/**************** spIntelisisWMSInfoCB_IF ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoCB_IF') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoCB_IF
GO
CREATE PROCEDURE spIntelisisWMSInfoCB_IF
    @ID            int,
    @iSolicitud    int,
    @Version       float,
    @Resultado     varchar(max) = NULL OUTPUT,
    @Ok            int = NULL OUTPUT,
    @OkRef         varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa            varchar(5),
    @Referencia         varchar(50), --RJP 23092010 Se agrega campo para capturar la Referencia
    @ID2                int,
    @Mov                varchar(20),
    @CB                 varchar(30),
    @Anden              varchar(20),
    @MovID              varchar(20),
    @Articulo           varchar(20),
    @SubCuenta          varchar(50),
    @Texto              xml,
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @UsuarioSucursal    bit,
    @Cantidad           float,
    @Caducidad          int,
    @FechaCaducidad     datetime,
    @Fecha              datetime,
    @Sucursal           int,
    @Cantidad2          float,
    @Tipo               varchar(20),
    @Serie              varchar(20),
    @RenglonID          int,
    @RenglonID2         int,
    @Sustituir          varchar(5),
    @TieneCaducidad     bit,
    @Propiedades        varchar(20),
    @UnidadCompra       varchar(20) --PGC06122013

  DECLARE  @Tabla Table(
    Cuenta                  varchar(20),
    SubCuenta               varchar(50),
    Descripcion             varchar(100),
    Unidad                  varchar(20),
    TieneCaducidad          bit,
    CaducidadMinima         int,
    CantidadPresentacion    float,
    Presentacion            varchar(50) NULL,
    Factor                  float,
    CantidadCamaTarima      int NULL,
    CamasTarima             int NULL,
    Amarre                  int NULL,
    Tipo                    varchar(20) NULL -- BUG6269
  )

  SELECT @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @CB = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Codigo'

  IF NOT EXISTS(SELECT * FROM CB WHERE Codigo = @CB)SET @Ok = 72040

  IF @Ok IS NULL
  BEGIN
    SELECT @Articulo = Cuenta, @SubCuenta=ISNULL(SubCuenta,'') FROM CB WHERE Codigo = @CB
    SELECT @Fecha = GETDATE()
    SELECT @Caducidad =ISNULL(CaducidadMinima,0), @TieneCaducidad = ISNULL(TieneCaducidad,0)  FROM Art WHERE Articulo = @Articulo
  END

    --25032014. Solicitud para que se muestre esto después de capturar el a´rticulo:
    -- Descripción (Descripcion1 de Tabla Art)
    -- Capacidad (CantidadPresentacion + Presentacion de Tabla Art)
    -- Factor de Empaque (Factor en tabla ArtUnidad donde Unidad sea igual a UnidadCompra de tabla Art)
    -- Cajas x Tarima (5 x 10) (CantidadCamaTarima y CamasTarima de Tabla Art)
    -- Amarre (50) (Total de Cajas por tarima) (Resultado de CamasTarima X CantidadCamaTarima  de tabla Art)

  --SELECT CantidadPresentacion, Presentacion, CantidadCamaTarima, CamasTarima FROM Art
  --SELECT * FROM ArtUnidad

  IF @Ok IS NULL
    BEGIN
      --EWQ. Tuning
      
      INSERT @Tabla(Cuenta, SubCuenta,               Descripcion,                Unidad,               TieneCaducidad,              CaducidadMinima,              CantidadPresentacion,              Presentacion,               Factor,              CantidadCamaTarima,              CamasTarima,              Amarre,                                        Tipo)
      SELECT      c.Cuenta, ISNULL(c.SubCuenta, ''), ISNULL(a.Descripcion1, ''), ISNULL(c.Unidad, ''), ISNULL(a.TieneCaducidad, 0), ISNULL(a.CaducidadMinima, 0), ISNULL(a.CantidadPresentacion, 0), ISNULL(a.Presentacion, ''), ISNULL(au.Factor,0), ISNULL(a.CantidadCamaTarima, 0), ISNULL(a.CamasTarima, 0), ISNULL(a.CantidadCamaTarima*a.CamasTarima, 0), ISNULL(a.Tipo, '')
        FROM CB c 
        JOIN Art a ON c.Cuenta = a.Articulo
	      JOIN ArtUnidad au ON AU.Articulo=a.Articulo AND au.Unidad=a.UnidadCompra
       WHERE  c.Codigo = @CB 
    END

  --SELECT @Texto = ISNULL((SELECT Cuenta, SubCuenta, Descripcion, TieneCaducidad, CaducidadMinima, Unidad,
  --                               CONVERT(varchar, CantidadPresentacion) CantidadPresentacion, Presentacion,
  --                               CONVERT(varchar, Factor) Factor,
  --                               CONVERT(varchar, CantidadCamaTarima) CantidadCamaTarima,
  --                               CONVERT(varchar, CamasTarima) CamasTarima,
  --                               CONVERT(varchar, Amarre) Amarre, Tipo  -- BUG6269
  --                          FROM @Tabla FOR XML AUTO),'')

  --BUG6415 
  SELECT @Texto = (SELECT Cuenta, SubCuenta, Descripcion, TieneCaducidad, CaducidadMinima, Unidad,
                          CONVERT(varchar, CantidadPresentacion) CantidadPresentacion, Presentacion,
                          CONVERT(varchar, Factor) Factor,
                          CONVERT(varchar, CantidadCamaTarima) CantidadCamaTarima,
                          CONVERT(varchar, CamasTarima) CamasTarima,
                          CONVERT(varchar, Amarre) Amarre, Tipo  -- BUG6269
                     FROM @Tabla FOR XML AUTO)

  IF @Texto IS NULL
	SELECT @Ok = 10530, @OkRef=''

  IF @@ERROR <> 0 SET @Ok = 1

  BEGIN
    SELECT @ReferenciaIS = Referencia
      FROM IntelisisService
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
  END

END
GO
--BUG24697
/**************** spISTMAGenerarTMA_SRADO ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISTMAGenerarTMA_SRADO') and type = 'P') drop procedure dbo.spISTMAGenerarTMA_SRADO
GO             
CREATE PROC spISTMAGenerarTMA_SRADO
			@ID				int,
			@Empresa		varchar(5),
			@Sucursal		int,
			@Usuario		varchar(10),
			@Tarima			varchar(20),
			@Posicion		varchar(10),
            @Articulo		varchar(20),
            @IDDestino      int             OUTPUT,
			@Ok				int				OUTPUT,
            @OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @IDOrigen				int,
          @Accion				char(20),
          @Modulo	      		char(5),
          @Mov	  	      		char(20),
          @MovID             	varchar(20),
          @MovTipo     			char(20),
          @MovMoneda			char(10),
          @MovTipoCambio		float,
          @FechaEmision      	datetime,
          @FechaAfectacion		datetime,
          @FechaConclusion		datetime,
          
          @Proyecto	      		varchar(50),
          @Autorizacion      	char(10),
          @DocFuente	      	int,
          @Observaciones     	varchar(255),
          @Concepto     		varchar(50),
          @Referencia			varchar(50),
          @Estatus           	char(15),
          @EstatusNuevo			char(15),
          @FechaRegistro     	datetime,
          @Ejercicio	      	int,
          @Periodo	      		int,
          @MovUsuario			char(10),
          
          @SucursalDestino		int,
          @SucursalOrigen		int,
          --BUG24305
          @SucursalFiltro		int

  SELECT  @IDOrigen				= @ID,
          @Accion				= 'AFECTAR',
          @Modulo	      		= 'TMA',
          @Mov	  	      		= TMA.Mov,
          @MovID             	= MovID,
          @MovTipo     			= MovTipo.Clave,
          @MovMoneda			= NULL,
          @MovTipoCambio		= NULL,
          @FechaEmision      	= GETDATE(),

          @Proyecto	      		= Proyecto,
          @Autorizacion      	= NULL,
          @DocFuente	      	= NULL,
          @Observaciones     	= 'Solicitud Patinero',
          @Concepto     		= Concepto,
          @Referencia			= Referencia,
          @Estatus           	= 'SINAFECTAR',
          @EstatusNuevo			= 'PENDIENTE',
          --BUG24305
          @SucursalFiltro		= SucursalFiltro,
          @SucursalDestino		= SucursalDestino
     FROM TMA
     JOIN MovTipo ON MovTipo.Modulo = 'TMA' AND MovTipo.Mov = TMA.Mov
    WHERE TMA.ID = @ID

  EXEC spExtraerFecha @FechaEmision OUTPUT

  EXEC spTMAReacomodoSolicitar @ID, @@SPID, @IDOrigen, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, 
							   @FechaConclusion, @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, @Estatus, 
							   @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @Sucursal, @SucursalDestino, @SucursalOrigen, 
							   @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @TarimaEsp = @Tarima, @PosicionEsp = @Posicion, 
							   @ArticuloEsp = @Articulo, @IDDestino = @IDDestino OUTPUT, 
							   --BUG24305
							   @SucursalFiltro = @SucursalFiltro

END
GO
--BUG24693
/************** spISIntelisisTMAProcesarTMA_SRADO ****************/
-- 17072014
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisTMAProcesarTMA_SRADO') AND type = 'P') drop procedure dbo.spISIntelisisTMAProcesarTMA_SRADO
GO             
CREATE PROCEDURE spISIntelisisTMAProcesarTMA_SRADO
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  --SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  DECLARE 
		@Texto						xml,
		@ReferenciaIS				varchar(100),
		@SubReferencia				varchar(100),
        @Mov						varchar(20),
        @MovID			            varchar(20),
        @Empresa				    varchar(5),
        @Sucursal			        int,
        @Sucursal2					varchar(100),
        @Tarima						varchar(20),
		@Posicion					varchar(10),
		@Articulo    			    varchar(20),
		@Descripcion1			    varchar(100),
		@UnidadCompra				varchar(50),		
		@Cantidad			        float,
		@Tipo						varchar(20),
		@Disponible				    float,
	    @DescripcionPosicion		varchar(100),
		@PosicionDestino			varchar(10),
		@DescripcionPosicionDestino varchar(100),
		@Completo                   int,
		@Codigo					    varchar(50),
		@Descripcion			    varchar(100),
		@Almacen                    VARCHAR(20),
		@Usuario			        varchar(20),
        
        @Factor                     FLOAT,
        @Unidad                     VARCHAR(20),
        @Minimo                     FLOAT,
        --@Disponible FLOAT,
		@Agente                     VARCHAR(20),
		@PosicionD					varchar(10),
		@Montacargas                varchar(20),
		@IDAcceso					int,	
        @Estacion					int,
	    @MovOrigen			        varchar(20),
        @MovIDOrigen		        varchar(20),
        @IDOrigen			        int,
		@Mov2  					    varchar(20),
        @Mov3  					    varchar(20),
        @MovID2   					varchar(20),
        @IDDestino			        int

  
BEGIN TRANSACTION 
 --EWQ. Tuning
 --SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)  
  --SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion
 
 
   SELECT  @Empresa = NULLIF(Empresa,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
     WITH(Empresa    varchar(255))
   SELECT  @Sucursal = NULLIF(Sucursal,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
     WITH(Sucursal    varchar(255))
   SELECT  @Usuario = NULLIF(Usuario,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
     WITH(Usuario   varchar(255)) 
   SELECT  @MovID = NULLIF(MovID,'') FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
     WITH(MovID    varchar(255))  
   SELECT  @Mov= NULLIF(Mov,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
     WITH(Mov    varchar(255)) 
   SELECT  @Tarima = NULLIF(Tarima,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
     WITH(Tarima   varchar(255))
   SELECT  @Posicion = NULLIF(Posicion,'')FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA') 
     WITH(Posicion   varchar(255))  
    SELECT  @Articulo  = Articulo FROM openxml (@iSolicitud,'/Intelisis/Solicitud/TMA')
      WITH(Articulo   varchar(255))

   SELECT @Agente = DefAgente, @Almacen=DefAlmacen, @Sucursal=Sucursal FROM Usuario WHERE Usuario = @Usuario

   IF NULLIF(RTRIM(@Articulo), '') IS NULL
     SELECT @Articulo = Articulo FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen

    --Verificamos si existe algún acomodo o reacomodo pendiente
	IF (SELECT COUNT(*) FROM TMA a /*WITH(NOLOCK)*/
    INNER JOIN TMAD b /*WITH(NOLOCK)*/ ON a.ID = b.ID 
	INNER JOIN MovTipo m ON m.Mov = a.Mov AND m.Modulo = 'TMA'
	--BUG24212
    WHERE m.Clave IN (/*'TMA.OADO',*/'TMA.ORADO',/*'TMA.SADO',*/'TMA.SRADO')
	AND a.Estatus = 'PENDIENTE' AND 
    b.PosicionDestino IN(SELECT Posicion FROM AlmPos WHERE Almacen=@Almacen AND ArticuloEsp=@Articulo AND Tipo='Domicilio') AND a.Almacen = @Almacen
    --BUG24511
    AND ISNULL(b.Procesado, 0) = 0
    ) > 0
	BEGIN
		SELECT @Ok=13077   
	END
  
  IF @OK IS NULL
  BEGIN    
    SELECT @IDOrigen = ID FROM TMA WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Mov = @Mov AND MovID = @MovID
    EXEC spISTMAGenerarTMA_SRADO  @IDOrigen,  @Empresa, @Sucursal, @Usuario, @Tarima, @Posicion, @Articulo, @IDDestino OUTPUT, @Ok OUTPUT , @OkRef OUTPUT
  END

  IF @Ok IS NULL AND @IDDestino IS NULL
    SELECT @Ok = 13125, @OkRef=@Articulo
   
  IF @Ok IS NULL
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @IDDestino 

  SELECT @Mov2='', @MovID2=''
  IF @Ok IS NULL   
  BEGIN      
    SELECT @Mov2 = isnull(Mov,'') , @MovID2 = isnull(MovID,'') FROM TMA WHERE ID = @IDDestino          
  END 

  IF @@ERROR <> 0 SET @Ok = 1      
    IF @Ok IS NOT NULL SELECT @OkRef = REPLACE(Descripcion, '<BR>', '') FROM MensajeLista WHERE Mensaje = @Ok   

  IF @Ok IS NULL   
    BEGIN  
      IF (SELECT Estatus FROM TMA WHERE ID = @IDDestino) = 'SINAFECTAR'  
        SELECT @Ok = -1  
      ELSE          
        SELECT @OkRef = RTRIM(Mov)+' '+RTRIM(MovID) FROM TMA WHERE ID = @IDDestino 
    END

  IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'

  IF @@ERROR <> 0 SET @Ok = 1
  
  IF @Ok IS NULL OR @Ok = -1
  BEGIN
    COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
  END
              
  END
--SELECT @Resultado
GO
--BUG24697
/************** spIntelisisArticuloPosicionORENT ****************/
-- 21072014
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisArticuloPosicionORENT') AND type = 'P') drop procedure dbo.spIntelisisArticuloPosicionORENT
GO             
CREATE PROCEDURE spIntelisisArticuloPosicionORENT
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
		@Texto						xml,
		@ReferenciaIS				varchar(100),
		@SubReferencia				varchar(100),
        @Mov						varchar(20),
        @MovID			            varchar(20),
        @Empresa				    varchar(5),
        @Sucursal			        int,
        @Sucursal2					varchar(100),
        @Tarima						varchar(20),
		@Posicion					varchar(10),
		@ArticuloEsp			    varchar(20),
		@Descripcion1			    varchar(150), --PGC04082014
		@UnidadCompra				varchar(50),		
		@Cantidad			        float,
		@Tipo						varchar(20),
		@Disponible				    float,
	    @DescripcionPosicion		varchar(100),
		@PosicionDestino			varchar(10),
		@DescripcionPosicionDestino varchar(100)  ,
		@Completo                   int,
		@Codigo					    varchar(50),
		@Descripcion			    varchar(100),
		@Almacen                    VARCHAR(20),
		@Usuario			        varchar(20),
        
            @Factor FLOAT,
            @Unidad VARCHAR(20),
            @Minimo FLOAT,
            --@Disponible FLOAT,
			@Agente VARCHAR(20),
			@PosicionD					varchar(10),
		        @Montacargas                varchar(20),
				 @IDAcceso					int,	
    @Estacion					int

 --EWQ. Tuning      
 --SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)  
  --SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion
  
  DECLARE  @Tabla Table(
  Posicion						varchar(10),
  ArticuloEsp					varchar(20),
  Descripcion1			        varchar(150), --PGC04082014
  Unidad     					varchar(50),
  Cantidad						varchar(100)
  )
  
   SELECT  @Sucursal2  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'
  SELECT  @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'   
   SELECT  @Tarima  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'      
  SELECT  @Posicion  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'
   SELECT  @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'
   SELECT  @Montacargas = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Montacarga'

    SELECT @Agente = DefAgente, @Almacen=DefAlmacen, @Sucursal=Sucursal FROM Usuario WHERE Usuario = @Usuario
	       
	--BUG24180
    SELECT @Cantidad = Disponible FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Empresa = @Empresa
	IF @Cantidad <= 0 BEGIN 
       SELECT @Ok=13250
    END

	SET @ArticuloEsp=''
	SELECT @ArticuloEsp = isnull(b.Articulo,'') FROM Tarima a /*WITH(NOLOCK)*/
    INNER JOIN ArtDisponibleTarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima
    WHERE a.Almacen = @Almacen AND a.Estatus = 'ALTA' AND a.Posicion = @Posicion
	IF @ArticuloEsp='' Select @Ok=13030

    --EWQ. Tuning
    SELECT @Factor = dbo.fnArtUnidadFactor(@Empresa, @ArticuloEsp, UnidadTraspaso), 
           @Minimo = MinimoTarima,
		   @Unidad = UnidadTraspaso,
           @Descripcion1=a.Descripcion1+' CB:' + ISNULL(c.Codigo,'')+ 
             '-CAPACIDAD:'+CONVERT(varchar, ISNULL(a.CantidadPresentacion, 0))+ ' '+ ISNULL(a.Presentacion, '')
      FROM Art a
	  JOIN CB c ON c.Cuenta = a.Articulo --PGC04082014
     WHERE a.Articulo = @ArticuloEsp
	   /*AND c.CodigoPrincipal=1*/

	SELECT @Cantidad=@Cantidad / @Factor
	IF @Ok IS NULL  
     INSERT @Tabla(Posicion, ArticuloEsp, Descripcion1, Unidad, Cantidad) 
	 SELECT ISNULL(@Posicion,''), ISNULL(@ArticuloEsp,''), ISNULL(@Descripcion1,''), ISNULL(@Unidad,''), ISNULL(@Cantidad,'')
        
   SELECT @Texto =(SELECT * FROM @Tabla TMA
                   FOR XML AUTO)
 
   IF @Ok IS NULL AND @Texto IS NULL -- BUG16763
	SELECT @Ok = 14055, @OkRef='' -- BUG16763	  
     
     IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    
  END
--SELECT @Resultado
GO
--BUG24697
/************** spISIntelisisTMAAfectarTMA_ORENT ****************/
-- 22072014
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisTMAAfectarTMA_ORENT') AND type = 'P') drop procedure dbo.spISIntelisisTMAAfectarTMA_ORENT
GO             
CREATE PROCEDURE spISIntelisisTMAAfectarTMA_ORENT
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  --SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  DECLARE 
		@Texto						xml,
		@ReferenciaIS				varchar(100),
		@SubReferencia				varchar(100),
        @Mov						varchar(20),
        @MovID			            varchar(20),
        @Empresa				    varchar(5),
        @Sucursal			        int,
        @Sucursal2					varchar(100),
        @Tarima						varchar(20),
		@Posicion					varchar(10),
		@ArticuloEsp			    varchar(20),
		@Descripcion1			    varchar(100),
		@UnidadCompra				varchar(50),		
		@Cantidad			        float,
		@Tipo						varchar(20),
		@Disponible				    float,
	    @DescripcionPosicion		varchar(100),
		@PosicionDestino			varchar(10),
		@DescripcionPosicionDestino varchar(100)  ,
		@Completo                   int,
		@Codigo					    varchar(50),
		@Descripcion			    varchar(100),
		@Almacen                    VARCHAR(20),
		@Usuario			        varchar(20),
        
            @Factor FLOAT,
            @Unidad VARCHAR(20),
            @Minimo FLOAT,
            --@Disponible FLOAT,
			@Agente VARCHAR(20),
			@PosicionD					varchar(10),
		        @Montacargas                varchar(20),
				 @IDAcceso					int,	
    @Estacion					int,
	 @Mov2  					    varchar(20),
    @Mov3  					    varchar(20),
    @MovID2   					varchar(20),
	@Modulo2                    varchar(5)
  
BEGIN TRANSACTION 
 --EWQ. Tuning
 --SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)  
  --SELECT @Estacion = EstacionTrabajo  FROM Acceso WHERE ID = @IDAcceso
  SELECT @Estacion=@@SPID --06052014. Se pasa spid a Estacion



  DECLARE  @Tabla Table(
  Posicion						varchar(10),
  ArticuloEsp					varchar(20),
  Descripcion1			        varchar(100),
  UnidadCompra					varchar(50),
  Cantidad						varchar(100),
  DescripcionPosicion			varchar(100)
  )
  
   SELECT  @Sucursal2  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'
  SELECT  @Empresa  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'   
   SELECT  @Tarima  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'      
  SELECT  @Posicion  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'
   SELECT  @PosicionD  = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'PosicionD'
   SELECT  @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'
   SELECT  @Montacargas = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Montacarga'
   SELECT  @Cantidad = ISNULL(CONVERT(float, Valor),0) FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro') 
       WITH(Campo varchar(255), Valor varchar(255))
    WHERE Campo = 'Cantidad'	


   SELECT @Agente = DefAgente, @Almacen=DefAlmacen, @Sucursal = Sucursal FROM Usuario WHERE Usuario = @Usuario
   
   IF @Cantidad <= 0 BEGIN 
     SELECT @Ok=13250
   END

   SET @ArticuloEsp=''
   SELECT @ArticuloEsp = isnull(b.Articulo,'') FROM Tarima a /*WITH(NOLOCK)*/
    INNER JOIN ArtDisponibleTarima b /*WITH(NOLOCK)*/ ON a.Tarima = b.Tarima
   WHERE a.Almacen = @Almacen AND a.Estatus = 'ALTA' AND a.Posicion = @Posicion

   IF @Ok IS NULL AND @ArticuloEsp='' Select @Ok=13030

   IF @Ok IS NULL  
     IF NOT EXISTS(SELECT ISNULL(Posicion,'') FROM AlmPos WHERE Posicion=@Posicion) SET @Ok=13030

    --EWQ. Tuning
    SELECT @Factor = dbo.fnArtUnidadFactor(@Empresa, @ArticuloEsp, UnidadTraspaso), 
           @Minimo = MinimoTarima,
		   @Unidad = UnidadTraspaso,
           @Descripcion1=a.Descripcion1
      FROM Art a
     WHERE a.Articulo = @ArticuloEsp

  IF @Ok IS NULL
	BEGIN
		INSERT INTO TMA (Empresa, Mov, FechaEmision, Usuario, Referencia, Estatus, Sucursal, Almacen, Agente,
		Montacarga, Prioridad, SucursalOrigen, SucursalDestino)
		SELECT @Empresa, 'Orden Re-Entarimado', dbo.fnFechaSinHora(getdate()), @Usuario, 'Solicitud desde IntelisisMobile','SINAFECTAR',
		@Sucursal, @Almacen, @Agente, @Montacargas, 'Normal', @Sucursal, @Sucursal

		SET @ID = @@IDENTITY    

		INSERT INTO TMAD (ID, Renglon, Tarima, Almacen, Posicion, PosicionDestino, Sucursal, Prioridad, Montacarga, Unidad, CantidadUnidad, CantidadPicking)
		SELECT @ID, 0, @Tarima, @Almacen, @Posicion, @PosicionD, @Sucursal,'Normal',@Agente,@Unidad, @Cantidad, @Cantidad*@Factor

		CREATE TABLE #MovR
		 (Folio VARCHAR(255) NULL, Descripcion VARCHAR(255) NULL,Tipo VARCHAR(20) NULL, Valor VARCHAR(255) NULL, ID INT NULL)
		INSERT INTO #MovR
		EXEC spAfectar 'TMA', @ID, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT ,@OkRef = @OkRef OUTPUT 
		IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL , @OkRef = NULL
	END

	IF @Ok IS NULL
  SELECT @ReferenciaIS = Referencia 
    FROM IntelisisService 
   WHERE ID = @ID 

  --PGC01082014
  SELECT @Mov2='', @MovID2='', @Descripcion='', @Modulo2=''
  IF @Ok IS NULL   
  BEGIN      
    --SELECT @Mov2 = isnull(Mov,'') , @MovID2 = isnull(MovID,'') FROM TMA WHERE ID = @ID   
	SELECT @Mov2=mv2.DMov, @MovID2=mv2.DMovid, @Modulo2=mv2.DModulo
     FROM MovFlujo mv1, MovFlujo mv2
    WHERE mv1.OModulo='TMA' 
	  AND mv1.OMov='Orden Re-Entarimado' 
	  AND mv1.OId=@ID
	  AND mv2.OModulo=mv1.DModulo
	  AND mv2.OMov=mv1.DMov
	  AND mv2.OId=mv1.DId
  END

  IF @@ERROR <> 0 SET @Ok = 1      
    IF @Ok IS NOT NULL SELECT @OkRef = REPLACE(Descripcion, '<BR>', '') FROM MensajeLista WHERE Mensaje = @Ok      
      
    --EWQ. Tuning  
    IF @Ok IS NULL   
    BEGIN  
      IF (SELECT Estatus FROM TMA WHERE ID = @ID) = 'SINAFECTAR'  
        SELECT @Ok = -1  
      ELSE  
        --SELECT @OkRef = RTRIM(Mov)+' '+RTRIM(MovID) FROM TMA WHERE ID = @ID
		SELECT @OkRef = RTRIM(@Mov2)+' '+RTRIM(@MovID2)
    END
      
     
     --IF @Ok IS NOT NULL SELECT @Descripcion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'


  IF @Ok IS NULL OR @Ok = -1
  BEGIN
    COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
  END
    
  END
--SELECT @Resultado
GO

/************** spIntelisisWMSInfoPosicion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoPosicion') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoPosicion
GO
CREATE PROCEDURE spIntelisisWMSInfoPosicion
    @ID                 int,
    @iSolicitud         int,
    @Version            float,
    @Resultado          varchar(max) = NULL OUTPUT,
    @Ok                 int = NULL OUTPUT,
    @OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto              xml,
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @Almacen            varchar(10),
    @Posicion           varchar(10),
    @Tarima             varchar(20),
    @Tipo               varchar(20)

  DECLARE
  @Tabla Table(
    Almacen             varchar(10),
    Posicion            varchar(10),
    Tipo                varchar(20),
    Descripcion         varchar(100),
    Pasillo             int,
    Fila                int,
    Nivel               int,
    Zona                varchar(50),
    Capacidad           int,
    Estatus             varchar(15),
    ArticuloEsp         varchar(20),
    Alto                float,
    Largo               float,
    Ancho               float,
    Volumen             float,
    PesoMaximo          float,
    Orden               int,
    TipoRotacion        varchar(10),
    CambioDomicilios    bit,
    TipoTarimaEsp       varchar(20),
    SubCuenta           varchar(50),
    Tarima              varchar(20)
  )

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Posicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'

  SELECT @Tipo = Tipo 
    FROM AlmPos 
   WHERE Almacen = @Almacen
     AND Posicion = @Posicion
     AND Estatus = 'ALTA' 

  IF @Tipo = 'Domicilio'
  BEGIN
    SELECT @Tarima = Tarima 
      FROM Tarima 
     WHERE Almacen = @Almacen 
       AND Posicion = @Posicion
       AND Estatus = 'ALTA'       
  END
   
  INSERT INTO @Tabla
  SELECT @Almacen,
         @Posicion,
         ISNULL(Tipo,''),
         ISNULL(Descripcion,''),
         ISNULL(Pasillo,0),
         ISNULL(Fila,0),
         ISNULL(Nivel,0),
         ISNULL(Zona,''),
         ISNULL(Capacidad,0),
         ISNULL(Estatus,''),
         ISNULL(ArticuloEsp,''),
         ISNULL(Alto,0),
         ISNULL(Largo,0),
         ISNULL(Ancho,0),
         ISNULL(Volumen,0),
         ISNULL(PesoMaximo,0),
         ISNULL(Orden,0),
         ISNULL(TipoRotacion,0),
         ISNULL(CambioDomicilios,''),
         ISNULL(TipoTarimaEsp,''),
         ISNULL(SubCuenta,''),
         ISNULL(@Tarima,'')
    FROM AlmPos
   WHERE Almacen = @Almacen
     AND Posicion = @Posicion

  SELECT @Texto = (SELECT * 
                     FROM @Tabla TMA
                      FOR XML AUTO)
  
  SET @Texto = ISNULL(@Texto,'')
    
  IF @@ERROR <> 0 SET @Ok = 1

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @@ERROR <> 0 
    SET @Ok = 1
  
  IF @Ok IS NOT NULL 
    SELECT @OkRef = Descripcion 
      FROM MensajeLista 
     WHERE Mensaje = @Ok

  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
  
  IF @@ERROR <> 0 
    SET @Ok = 1
END
GO

/************** spIntelisisWMSOrdenCompraLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSOrdenCompraLista') AND type = 'P') drop procedure dbo.spIntelisisWMSOrdenCompraLista
GO
CREATE PROCEDURE spIntelisisWMSOrdenCompraLista
    @ID            int,
    @iSolicitud    int,
    @Version       float,
    @Resultado     varchar(max) = NULL OUTPUT,
    @Ok            int = NULL OUTPUT,
    @OkRef         varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto              xml,
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @Empresa            char(5),
    @Usuario            varchar(10)

  DECLARE @Movimiento Table(
    Mov                 varchar(20))

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'
  
  INSERT @Movimiento(Mov)
  SELECT DISTINCT Mov
    FROM MapeoMovMovil
   WHERE Modulo = 'COMS'

  SELECT @Texto = ISNULL((SELECT * FROM @Movimiento Movimiento
                   FOR XML AUTO), '')
  IF NOT EXISTS(SELECT * FROM @Movimiento)
    SELECT @Ok = 25127, @OkRef = 'Es necesario configurar el mapeo de Movimientos Móvil'

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia
      FROM IntelisisService
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      BEGIN
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    END
  END

END
GO
/************** spIntelisisWMSEntradaCompraLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSEntradaCompraLista') AND type = 'P') drop procedure dbo.spIntelisisWMSEntradaCompraLista
GO
CREATE PROCEDURE spIntelisisWMSEntradaCompraLista
    @ID            int,
    @iSolicitud    int,
    @Version       float,
    @Resultado     varchar(max) = NULL OUTPUT,
    @Ok            int = NULL OUTPUT,
    @OkRef         varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto              xml,
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @Empresa            char(5),
    @Usuario            varchar(10),
    @MovCompra          varchar(20)

  DECLARE @Movimiento Table(
    Mov                 varchar(20))

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SELECT @MovCompra = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'
  
  INSERT @Movimiento(Mov)
  SELECT DISTINCT MovFinal
    FROM MapeoMovMovil
   WHERE Modulo = 'COMS'
     AND Mov = @MovCompra

  SELECT @Texto = ISNULL((SELECT * FROM @Movimiento Movimiento
                   FOR XML AUTO), '')
  IF NOT EXISTS(SELECT * FROM @Movimiento)
    SELECT @Ok = 25127, @OkRef = 'Es necesario configurar el mapeo de Movimientos Móvil'

  IF @@ERROR <> 0 SET @Ok = 1
  BEGIN
    SELECT @ReferenciaIS = Referencia
      FROM IntelisisService
     WHERE ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1
    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      BEGIN
      SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
      IF @@ERROR <> 0 SET @Ok = 1
    END
  END

END
GO

/************** spIntelisisWMSInfoTarima ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoTarima') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoTarima
GO
CREATE PROCEDURE spIntelisisWMSInfoTarima
    @ID                 int,
    @iSolicitud         int,
    @Version            float,
    @Resultado          varchar(max) = NULL OUTPUT,
    @Ok                 int = NULL OUTPUT,
    @OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto              xml,
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @ID2                varchar(20),
    @Empresa            varchar(5),
    @Almacen            varchar(10),
    @Tarima             varchar(20),
    @MultiUnidades      bit,
    @Posicion           varchar(10),
    @PosicionTipo       varchar(20),
    @Articulo           varchar(20),
    @Descripcion1       varchar(100),
    @SubCuenta          varchar(50),
    @ArticuloTipo       varchar(20),
    @Unidad             varchar(50),
    @Codigo             varchar(30),
    @SerieLote          varchar(50),
    @Disponible         float,
    @InvID              int

  DECLARE @Tabla table (
    Articulo          varchar(20),
    SubCuenta         varchar(50),
    Descripcion1      varchar(100),
    ArticuloTipo      varchar(20),
    Unidad            varchar(50),
    Codigo            varchar(30),
    SerieLote         varchar(50),
    Disponible        varchar(50)
  )

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @ID2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ID'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Posicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'

  SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'

  SELECT @MultiUnidades = MultiUnidades
    FROM EmpresaCfg2 WHERE Empresa = @Empresa
  SET @MultiUnidades = ISNULL(@MultiUnidades,0)

IF NOT EXISTS(SELECT * FROM Tarima WHERE Posicion = @Posicion AND Tarima = @Tarima)
  SET @Ok = 13190

IF @Ok IS NULL
  BEGIN
    SELECT @Articulo = LTRIM(RTRIM(ISNULL(ArticuloEsp,''))),
           @SubCuenta = LTRIM(RTRIM(ISNULL(SubCuenta,''))),
           @PosicionTipo = UPPER(LTRIM(RTRIM(ISNULL(Tipo,''))))
      FROM AlmPos
     WHERE Almacen = @Almacen AND Posicion = @Posicion

    IF ISNULL(@Articulo,'') = ''
      SELECT @Articulo = LTRIM(RTRIM(ISNULL(Articulo,''))),
             @SubCuenta = LTRIM(RTRIM(ISNULL(SubCuenta,'')))
        FROM Tarima
       WHERE Tarima = @Tarima

    SELECT @Descripcion1 = LTRIM(RTRIM(ISNULL(Descripcion1,''))),
           @ArticuloTipo = LTRIM(RTRIM(ISNULL(Tipo,'')))
      FROM Art
     WHERE Articulo = @Articulo

    SELECT @SerieLote = LTRIM(RTRIM(ISNULL(SerieLote,'')))
      FROM SerieLote
     WHERE Tarima = @Tarima

    SELECT @Disponible = ISNULL(Disponible,0)
      FROM ArtSubDisponibleTarima
     WHERE Tarima = @Tarima

     IF @MultiUnidades = 0
       SELECT @Unidad = UnidadTraspaso FROM Art WHERE Articulo = @Articulo
     ELSE
       SELECT @Unidad = Unidad FROM ArtUnidad WHERE Articulo = @Articulo

     SELECT @Codigo = LTRIM(RTRIM(ISNULL(Codigo,'')))
      FROM CB
     WHERE TipoCuenta = 'Articulos'
       AND Cuenta = @Articulo
       AND ISNULL(SubCuenta,'') = @SubCuenta
       AND Unidad = @Unidad

    IF @MultiUnidades = 1
    BEGIN
      IF NOT EXISTS (SELECT Unidad FROM ArtUnidad WHERE Articulo = @Articulo)
        SELECT @Ok = 20560, @OkRef = 'No está definida la unidad para el Artículo indicado'
    END

    IF @Ok IS NULL AND ISNULL(@Unidad,'') = ''
      SELECT @Ok = 20560, @OkRef = 'No está definida la unidad traspaso para el Artículo indicado'

    IF @Ok IS NULL
    BEGIN
      INSERT @Tabla(Articulo,SubCuenta,Descripcion1,ArticuloTipo,Unidad,Codigo,SerieLote,Disponible)
      VALUES (ISNULL(@Articulo,''),
              ISNULL(@SubCuenta,''),
              ISNULL(@Descripcion1,''),
              ISNULL(@ArticuloTipo,''),
              ISNULL(@Unidad,''),
              ISNULL(@Codigo,''),
              ISNULL(@SerieLote,''),
              CAST(ISNULL(@Disponible,0) AS varchar(50)))

      SELECT @Texto = (SELECT Articulo,
                              SubCuenta,
                              Descripcion1,
                              ArticuloTipo,
                              Unidad,
                              Codigo,
                              SerieLote,
                              Disponible
                         FROM @Tabla TMA
                       FOR XML AUTO)

      IF @Texto IS NULL
      BEGIN
        SET @Ok = 13110
        SELECT @OkRef = descripcion FROM Mensajelista WHERE Mensaje = 13110
      END

    END
  END

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @Ok IS NOT NULL
    SET @OkRef = @OkRef + ' ' + @Articulo

  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
END
GO

/************** spIntelisisWMSTotalCB ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSTotalCB ')           AND type = 'P') drop procedure dbo.spIntelisisWMSTotalCB
GO
CREATE PROCEDURE spIntelisisWMSTotalCB
    @ID            int,
    @iSolicitud    int,
    @Version       float,
    @Resultado     varchar(max) = NULL OUTPUT,
    @Ok            int = NULL OUTPUT,
    @OkRef         varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa            varchar(5),
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @ID2                int,
    @Mov                varchar(20),
    @MovID              varchar(20),
    @Articulo           varchar(20),
    @Descripcion        varchar(100),
    @Texto              xml

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Mov= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

   SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  DECLARE @Tabla Table(
    Articulo               varchar(20),
    Total                  varchar(100)
  )

  SELECT @ID2 = ID
    FROM Compra
   WHERE Empresa = @Empresa
     AND Mov = @Mov
     AND MovID = @MovID

  INSERT INTO @Tabla (Articulo, Total)
  SELECT @Articulo,
         CAST(ISNULL(sum(s.Cantidad),0) AS VARCHAR)
    FROM SerieLoteMovMovil s
   WHERE ID = @ID2
     AND Empresa = @Empresa
     AND Modulo = 'COMS'
     AND Articulo = @Articulo
     --AND RenglonID = ?

  SELECT @Texto = (SELECT TMA.Articulo,
                          TMA.Total
                     FROM @Tabla TMA
                      FOR XML AUTO)

  IF @@ERROR <> 0 SET @Ok = 1

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @@ERROR <> 0 SET @Ok = 1

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'">' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'

  IF @@ERROR <> 0 SET @Ok = 1

END
GO

/************** spIntelisisWMSInfoArticuloSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoArticuloSerieLote ') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoArticuloSerieLote
GO
CREATE PROCEDURE spIntelisisWMSInfoArticuloSerieLote
    @ID                 int,
    @iSolicitud         int,
    @Version            float,
    @Resultado          varchar(max) = NULL OUTPUT,
    @Ok                 int = NULL OUTPUT,
    @OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Empresa            varchar(5),
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @ModuloID           int,
    @RenglonID          int,
    @Mov                varchar(20),
    @MovID              varchar(20),
    @Articulo           varchar(20),
    @Descripcion1       varchar(100),
    @Texto              xml

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Mov= Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  SELECT @RenglonID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'RenglonID'

   SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  DECLARE @Tabla Table(
    RenglonID                 int,
    Articulo                  varchar(20),
    SubCuenta                 varchar(50),
    Descripcion1              varchar(100),
    SerieLote                 varchar(50),
    Cantidad                  float
  )

  SELECT @ModuloID = ID
    FROM Compra
   WHERE Empresa = @Empresa
     AND Mov = @Mov
     AND MovID = @MovID

  INSERT INTO @Tabla (RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
  SELECT ISNULL(s.RenglonID,0),
         ISNULL(s.Articulo,''),
         ISNULL(s.SubCuenta,''),
         ISNULL(s.SerieLote,''),
         ISNULL(s.Cantidad,0)
    FROM SerieLoteMov s
   WHERE s.Modulo = 'COMS'
     AND s.ID = @ModuloID
     AND s.RenglonID = @RenglonID

  DELETE @Tabla WHERE Cantidad = '0' OR LTRIM(RTRIM(ISNULL(SerieLote,''))) = ''

  UPDATE @Tabla
     SET Descripcion1 = ISNULL(b.Descripcion1,'')
    FROM @Tabla a
   INNER JOIN Art b ON (a.Articulo = b.Articulo)

  SELECT @Texto = (SELECT CAST(RenglonID AS varchar) AS RenglonID,
                          ISNULL(Articulo,'')        AS Articulo,
                          ISNULL(SubCuenta,'')       AS SubCuenta,
                          ISNULL(Descripcion1,'')    AS Descripcion1,
                          ISNULL(SerieLote,'')       AS SerieLote,
                          CAST(Cantidad AS varchar)  AS Cantidad
                     FROM @Tabla AS TMA
                      FOR XML AUTO)

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
/************** spIntelisisWMSArticuloCBLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSArticuloCBLista') AND type = 'P') drop procedure dbo.spIntelisisWMSArticuloCBLista
GO
CREATE PROCEDURE spIntelisisWMSArticuloCBLista
    @ID                 int,
    @iSolicitud         int,
    @Version            float,
    @Resultado          varchar(max) = NULL OUTPUT,
    @Ok                 int = NULL OUTPUT,
    @OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Texto              xml,
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @Articulo           varchar(20)

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  DECLARE @Tabla Table(
    Codigo              varchar(30),
    Unidad              varchar(50),
    Factor              varchar(255)
  )

  INSERT INTO @Tabla(Codigo, Unidad, Factor)
  SELECT ISNULL(c.Codigo,''),
         ISNULL(c.Unidad,''),
         CAST(ISNULL(a.Factor,0) AS varchar(255))
    FROM CB c
    JOIN ArtUnidad a ON (c.Cuenta = a.Articulo AND c.Unidad = a.Unidad)
   WHERE c.TipoCuenta = 'Articulos'
     AND c.Cuenta = @Articulo

  SELECT @Texto = (SELECT * FROM @Tabla AS TMA FOR XML AUTO)
  IF @Texto IS NULL SELECT @Ok = 20560

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @Ok IS NOT NULL
    BEGIN
      SELECT @OkRef = LTRIM(RTRIM(ISNULL(Descripcion,''))) FROM MensajeLista WHERE Mensaje = @Ok
      SET @OkRef = @OkRef + ' ' + @Articulo
      SET @OkRef = LTRIM(RTRIM(@OkRef))
    END
  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max), ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
END
GO


/**************** spIntelisisTMAAfectarMovTMA_OPCKTARIMA ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisTMAAfectarMovTMA_OPCKTARIMA') and type = 'P') drop procedure dbo.spIntelisisTMAAfectarMovTMA_OPCKTARIMA
GO
CREATE PROCEDURE spIntelisisTMAAfectarMovTMA_OPCKTARIMA
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
    @IDGenerar               int,
    @IDAcceso                int,
    @MovTipo                 varchar(20),
    @ReferenciaIS            varchar(100),
    @Estacion                int,
    @SubReferencia           varchar(100),
    @Empresa                 varchar(5),
    @Mov                     varchar(20),
    @MovID                   varchar(20),
    @Mov2                    varchar(20),
    @Mov3                    varchar(20),
    @MovID2                  varchar(20),
    @Sucursal                int,
    @ID2                     int,
    @Tarima                  varchar(20),
    @Sucursal2               varchar(100),
    @Posicion                varchar(20),
    @PosicionDestino         varchar(20),
    @Usuario                 varchar(15),
    @Cantidad                float(20),
    @Estatus                 varchar(20),
    @Articulo                varchar(20),
    @SubClave                varchar(20),
    @Procesado               bit,
    @Montacargas             varchar(20),
    @Agente                  varchar(20),
    @CB                      varchar(30),
    @SubCuenta               varchar(50),
    @Unidad                  varchar(20),
    @UnidadCompra            varchar(20),
    @Factor                  float ,
    @Almacen                 varchar(20),
    @Disponible              float,
    @PosicionDGenerar        varchar(20),
    @DescripcionPosicionD    varchar(20),
    @TarimaGenerar           varchar(20)

  BEGIN TRANSACTION

  SELECT @Estacion = @@SPID

  IF @Ok IS NULL
  BEGIN
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Sucursal2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Sucursal'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovID'

    SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Tarima'

    SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Articulo'

    SELECT @SubCuenta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SubCuenta'

    SELECT @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Cantidad'

    SELECT @Unidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Unidad'

    SELECT @Montacargas = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Montacargas'
  END

  SELECT @MovTipo = Clave
    FROM MovTipo
   WHERE Modulo = 'TMA'
     AND Mov = @Mov

  IF @MovTipo <> 'TMA.OPCKTARIMA'
    SELECT @Ok = 35005, @OkRef = @Mov

  SELECT @Factor = dbo.fnArtUnidadFactor(@Empresa, @Articulo, @Unidad)
  SET @Cantidad = @Cantidad * @Factor

  IF @Ok IS NULL
    IF NOT EXISTS(SELECT *
                    FROM TMAD d
                    JOIN TMA t ON (t.ID = d.ID )
                    JOIN MovTipo m ON (m.Mov = t.Mov AND m.Modulo = 'TMA' AND t.MovID = @MovID)
                    JOIN ArtDisponibleTarima a ON (a.Tarima = d.Tarima AND a.Almacen = d.Almacen AND a.Empresa = t.Empresa)
                   WHERE a.Articulo = @Articulo
                     AND m.Clave = @MovTipo
                     AND a.Tarima = @Tarima)
    SET @Ok = 13070

  IF @Ok IS NULL
    IF NOT EXISTS(SELECT *
                    FROM TMAD d
                    JOIN TMA t ON (t.ID = d.ID)
                    JOIN MovTipo m ON (m.Mov = t.Mov AND m.Modulo = 'TMA' AND t.MovID = @MovID)
                    JOIN ArtDisponibleTarima a ON (a.Tarima = d.Tarima AND a.Almacen = d.Almacen AND a.Empresa = t.Empresa)
                   WHERE a.Articulo = @Articulo
                   AND m.Clave = @MovTipo
                   AND a.Tarima = @Tarima)
    SET @Ok = 13070

  IF @Ok IS NULL
    IF NOT EXISTS(SELECT *
                    FROM TMAD d
                    JOIN TMA t ON (t.ID = d.ID)
                    JOIN MovTipo m ON (m.Mov = t.Mov AND m.Modulo = 'TMA' AND t.MovID = @MovID)
                    JOIN ArtDisponibleTarima a ON (a.Tarima = d.Tarima AND a.Almacen = d.Almacen AND a.Empresa = t.Empresa)
                   WHERE a.Articulo = @Articulo
                     AND m.Clave = @MovTipo
                     AND a.Tarima = @Tarima
                     AND a.Disponible >= @Cantidad)
    SET @Ok = 20020

  SELECT @Agente = DefAgente, 
         @Almacen = DefAlmacen 
    FROM Usuario
   WHERE Usuario = @Usuario

  IF @Agente IS NULL 
    SELECT @Ok = 20930

  IF @Ok = 20020
    SELECT @Disponible = ISNULL(b.Disponible,0)/ISNULL(@Factor,1) 
      FROM Tarima a
     INNER JOIN ArtDisponibleTarima b ON (a.Tarima = b.Tarima)
     WHERE a.Almacen = @Almacen
       AND a.Estatus = 'ALTA'
       AND a.Tarima = @Tarima
       AND b.Articulo = @Articulo
       AND b.Empresa = @Empresa

  IF @Ok IS NULL AND @Cantidad < 1
    SET @OK = 20015

  IF @Ok IS NULL
  BEGIN
    SELECT @ID2 = ID,
           @Estatus = Estatus
      FROM TMA
     WHERE Empresa = @Empresa
       AND Mov = @Mov
       AND MovID = @MovID

    SELECT @Procesado = ISNULL(Procesado,0)
      FROM TMAD
     WHERE ID = @ID2
       AND Tarima = @Tarima

    IF @Procesado = 0
      UPDATE TMAD
         SET CantidadA = @Cantidad
       WHERE ID = @ID2
         AND Tarima = @Tarima

    IF @Ok IS NULL AND @Estatus = 'PENDIENTE' AND @MovTipo = 'TMA.OPCKTARIMA'
    BEGIN
      SELECT @Mov3 = TMAPCKTarimaTransito
        FROM EmpresaCfgMovWMS
       WHERE Empresa = @Empresa

      EXEC @IDGenerar = spAfectar 'TMA', @ID2, 'GENERAR', 'Seleccion', @Mov3, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

      UPDATE TMA
         SET Montacarga = @Montacargas,
             Agente = @Agente
       WHERE ID = @IDGenerar

      IF @Ok BETWEEN 80030 AND 81000
        SELECT @Ok = NULL, @OkRef = NULL

      EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

      IF @Ok BETWEEN 80030 AND 81000
        SELECT @Ok = NULL, @OkRef = NULL
    END

    SELECT @ReferenciaIS = Referencia
      FROM IntelisisService
     WHERE ID = @ID

    SELECT @Mov2   = LTRIM(RTRIM(ISNULL(Mov,''))),
           @MovID2 = LTRIM(RTRIM(ISNULL(MovID,'')))
      FROM TMA
     WHERE ID = @IDGenerar

    SELECT @PosicionDGenerar = PosicionDestino, 
           @TarimaGenerar = Tarima
      FROM TMAD
     WHERE ID = @IDGenerar

    SELECT @DescripcionPosicionD = Descripcion
      FROM AlmPos
     WHERE ALmacen = @Almacen
       AND Posicion = @PosicionDGenerar

  END

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
  END

  IF @Ok IS NOT NULL
    SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  IF @Ok = 20020
    SELECT @OkRef = @OkRef + '. ' + 'Disponible Actual = '+ CAST(ISNULL(@Disponible,0) AS varchar)

  --SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="TMA" ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) +'  Mov=' + CHAR(34) + ISNULL(@Mov2,'') + CHAR(34) +'  MovID=' + CHAR(34) + ISNULL(@MovID2,'') + CHAR(34) + ' PosicionDestino=' + CHAR(34) + ISNULL(@PosicionDGenerar,'') + CHAR(34) +' DescripcionPosicionDestino=' + CHAR(34) + ISNULL(@DescripcionPosicionD,'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'
  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="TMA" ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) +'  Mov=' + CHAR(34) + ISNULL(@Mov2,'') + CHAR(34) + ' MovID=' + CHAR(34) + ISNULL(@MovID2,'') + CHAR(34) + ' PosicionDestino=' + CHAR(34) + ISNULL(@PosicionDGenerar,'') + CHAR(34) + ' DescripcionPosicionDestino=' + CHAR(34) + ISNULL(@DescripcionPosicionD,'') + CHAR(34)  + ' Tarima=' + CHAR(34) + ISNULL(@TarimaGenerar,'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'
  
END
GO

/**************** spIntelisisTMAAfectarMovTMA_PCKTARIMATRAN ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisTMAAfectarMovTMA_PCKTARIMATRAN') and type = 'P') drop procedure dbo.spIntelisisTMAAfectarMovTMA_PCKTARIMATRAN
GO
CREATE PROCEDURE spIntelisisTMAAfectarMovTMA_PCKTARIMATRAN
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
    @IDGenerar               int,
    @MovTipo                 varchar(20),
    @ReferenciaIS            varchar(100),
    @Usuario2                varchar(10),
    @Estacion                int,
    @SubReferencia           varchar(100),
    @Empresa                 varchar(5),
    @Mov                     varchar(20),
    @MovID                   varchar(20),
    @Sucursal                int,
    @ID2                     int,
    @Tarima                  varchar(20),
    @Sucursal2               varchar(100),
    @PosicionDestino         varchar(20),
    @Usuario                 varchar(15),
    @Montacargas             varchar(20),
    @Estatus                 varchar(20),
    @Agente                  varchar(20),
    @Modificar               bit,
    @Procesado               bit,
    @Mov2                    varchar(20),
    @MovID2                  varchar(20),
    @PosicionDGenerar        varchar(20),
    @Descripcion             varchar(100),
    @Movimiento              varchar(20),
    @Almacen                 varchar(20),
    @Cantidad                varchar(100)

  BEGIN TRANSACTION

  SELECT @Estacion = @@SPID

  IF @Ok IS NULL
  BEGIN
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Sucursal2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Sucursal'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovID'

    SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Tarima'

    SELECT @PosicionDestino = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'PosicionDestino'

    SELECT @Montacargas = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Montacargas'

    SELECT @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Cantidad'
   END

  SELECT @Sucursal = Sucursal
    FROM Sucursal
   WHERE Nombre = @Sucursal2

  SELECT @ID2 = ID,
         @Estatus = Estatus
    FROM TMA
   WHERE Empresa = @Empresa
     AND Sucursal = @Sucursal
     AND Mov = @Mov
     AND MovID = @MovID

  SELECT @Procesado = ISNULL(Procesado,0)
    FROM TMAD
   WHERE ID = @ID2
     AND Tarima = @Tarima

  SELECT @Modificar = ModificarPosicionSugeridaWMS
    FROM Usuario
   WHERE Usuario = @Usuario

  SELECT @MovTipo = Clave
    FROM MovTipo
   WHERE Mov = @Mov
     AND Modulo = 'TMA'

  IF @MovTipo NOT IN ('TMA.PCKTARIMATRAN')
    SELECT @Ok = 35005, @OkRef = @Mov

  IF @Ok IS NULL
  BEGIN
    IF NOT EXISTS(SELECT * FROM Montacarga WHERE Montacarga = @Montacargas)
      SET @Ok = 20948

    IF NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON (t.ID = d.ID) WHERE d.Tarima = @Tarima AND d.PosicionDestino = @PosicionDestino AND t.Empresa = @Empresa AND t.Sucursal = @Sucursal AND t.Mov = @Mov AND t.MovID = @MovID)
    BEGIN
      IF NOT EXISTS(SELECT * FROM TMA t JOIN TMAD d ON (t.ID = d.ID) WHERE CASE WHEN CHARINDEX('-', d.Tarima, 1) >0 THEN SUBSTRING(d.Tarima, 1, CHARINDEX('-', d.Tarima, 1)-1) ELSE d.Tarima END = @Tarima AND d.PosicionDestino = @PosicionDestino AND t.Empresa = @Empresa AND t.Sucursal = @Sucursal AND t.Mov = @Mov AND t.MovID = @MovID)
        SET @Ok = 13035
    END
  END

  IF @Ok IS NULL
  BEGIN

    UPDATE TMAD
       SET CantidadA = CAST(@Cantidad AS float)
     WHERE Tarima = @Tarima
       AND ID = @ID2

    IF @Ok IS NULL AND @Estatus = 'PENDIENTE' AND @MovTipo = 'TMA.PCKTARIMATRAN'
    BEGIN
      SELECT @Movimiento = TMAPCKTarima
        FROM EmpresaCfgMovWMS
       WHERE Empresa = @Empresa

      EXEC @IDGenerar = spAfectar 'TMA', @ID2, 'GENERAR', 'Seleccion', @Movimiento, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

      IF @Ok BETWEEN 80030 AND 81000
        SELECT @Ok = NULL , @OkRef = NULL

      SELECT @Agente = DefAgente
        FROM Usuario
       WHERE Usuario = @Usuario

      IF @Agente IS NULL
        SELECT @Ok = 20930

      IF @Ok IS NULL
      BEGIN
        UPDATE TMA
           SET Montacarga = @Montacargas,
               Agente = @Agente
         WHERE ID = @IDGenerar

        EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

        IF @Ok BETWEEN 80030 AND 81000
          SELECT @Ok = NULL , @OkRef = NULL
      END

      SELECT @Mov2 = Mov,
             @MovID2 = MovID
        FROM TMA
       WHERE ID = @IDGenerar

      SELECT @PosicionDGenerar = PosicionDestino
        FROM TMAD
       WHERE ID = @IDGenerar

      SELECT @Descripcion = Descripcion
        FROM AlmPos
       WHERE Almacen = @Almacen
         AND Posicion = @PosicionDGenerar

    END

  END

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
  END

  IF @Ok IS NOT NULL
    SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="TMA" ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) +'  Mov=' + CHAR(34) + ISNULL(@Mov2,'') + CHAR(34) +'  MovID=' + CHAR(34) + ISNULL(@MovID2,'') + CHAR(34)  +'  PosicionDestino=' + CHAR(34) + ISNULL(@PosicionDGenerar,'') + CHAR(34) +' DescripcionPosicionDestino=' + CHAR(34) + ISNULL(@Descripcion,'') + CHAR(34) +  ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'
END
GO

/************** spIntelisisWMSInventarioDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInventarioDetalle ')           AND type = 'P') drop procedure dbo.spIntelisisWMSInventarioDetalle
GO
CREATE PROCEDURE spIntelisisWMSInventarioDetalle
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
        Renglon                   float,
        RenglonSub                int,
        RenglonID                 int,
        PosicionReal              varchar(10),
        PosicionRealDescripcion   varchar(100),
        Almacen                   varchar(10),
        Tarima                    varchar(20),
        Articulo                  varchar(20),
        SubCuenta                 varchar(50),
        Descripcion1              varchar(100),
        Cantidad                  float,
        Unidad                    varchar(50),
        Factor                    float,
        CantidadInventario        float,
        ArticuloTipo              varchar(20),
        Movimiento                varchar(20)
      )

      INSERT INTO @Tabla(Renglon,RenglonSub,RenglonID,PosicionReal,Almacen,Tarima,Articulo,SubCuenta,Cantidad,Unidad,Factor,CantidadInventario)
      SELECT ISNULL(Renglon,0.0),
             ISNULL(RenglonSub,0),
             ISNULL(RenglonID,0),
             ISNULL(PosicionReal,''),
             ISNULL(Almacen,''),
             ISNULL(Tarima,''),
             ISNULL(Articulo,''),
             ISNULL(SubCuenta,''),
             ISNULL(Cantidad,0.0),
             ISNULL(Unidad,''),
             ISNULL(Factor,0.0),
             ISNULL(CantidadInventario,0.0)
        FROM InvD
       WHERE ID = @InventarioID

      DELETE @Tabla WHERE LTRIM(RTRIM(ISNULL(PosicionReal,''))) = ''
      DELETE @Tabla WHERE LTRIM(RTRIM(ISNULL(Tarima,''))) = ''

      UPDATE @Tabla 
         SET Movimiento = Mov
        FROM Inv 
       WHERE ID = @InventarioID

      UPDATE @Tabla
         SET Descripcion1 = ISNULL(b.Descripcion1, ''),
             ArticuloTipo = ISNULL(b.Tipo, '')
        FROM @Tabla a
       INNER JOIN Art b ON (a.Articulo = b.Articulo)

      UPDATE @Tabla
         SET PosicionRealDescripcion = ISNULL(b.Descripcion, '')
        FROM @Tabla a
       INNER JOIN AlmPos b ON (a.PosicionReal = b.Posicion)

      SELECT @Texto = (SELECT CAST(ISNULL(Renglon,0) AS varchar)            AS Renglon,
                              CAST(ISNULL(RenglonSub,0) AS varchar)         AS RenglonSub,
                              CAST(ISNULL(RenglonID,0) AS varchar)          AS RenglonID,
                              ISNULL(PosicionReal,'')                       AS PosicionReal,
                              ISNULL(PosicionRealDescripcion,'')            AS PosicionRealDescripcion,
                              ISNULL(Almacen,'')                            AS Almacen,
                              ISNULL(Tarima,'')                             AS Tarima,
                              ISNULL(Articulo,'')                           AS Articulo,
                              ISNULL(SubCuenta,'')                          AS SubCuenta,
                              ISNULL(Descripcion1,'')                       AS Descripcion1,
                              CAST(ISNULL(Cantidad,0) AS varchar)           AS Cantidad,
                              ISNULL(Unidad,'')                             AS Unidad,
                              CAST(ISNULL(Factor,0) AS varchar)             AS Factor,
                              CAST(ISNULL(CantidadInventario,0) AS varchar) AS CantidadInventario,
                              ISNULL(ArticuloTipo,'')                       AS ArticuloTipo,
                              ISNULL(Movimiento,'')                         AS Movimiento
                         FROM @Tabla AS TMA
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

/************** spIntelisisWMSInfoSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoSerieLote ')           AND type = 'P') drop procedure dbo.spIntelisisWMSInfoSerieLote
GO
CREATE PROCEDURE spIntelisisWMSInfoSerieLote
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
    @ModuloID                varchar(255),
    @RenglonID               varchar(255),
    @Articulo                varchar(20),
    @ModuloID2               int,
    @RenglonID2              int,
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Texto                   xml

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

  SET @Empresa    = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Modulo     = LTRIM(RTRIM(ISNULL(@Modulo,'')))
  SET @Articulo   = LTRIM(RTRIM(ISNULL(@Articulo,'')))
  SET @ModuloID2  = CAST(ISNULL(@ModuloID,'0') AS int)
  SET @RenglonID2 = CAST(ISNULL(@RenglonID,'0') AS int)

  IF @ModuloID2 > 0
    BEGIN
      DECLARE @Tabla Table(
        RenglonID            int,
        Articulo             varchar(20),
        SerieLote            varchar(50),
        Cantidad             float
      )

      INSERT INTO @Tabla(RenglonID,Articulo,SerieLote,Cantidad)
      SELECT ISNULL(RenglonID,0),
             ISNULL(Articulo,''),
             ISNULL(SerieLote,''),
             ISNULL(Cantidad,0.0)
        FROM SerieLoteMov   --SerieLoteMovMovil
       WHERE Empresa = @Empresa
         AND Modulo = @Modulo
         AND ID = @ModuloID
         AND RenglonID = @RenglonID2
         AND Articulo = @Articulo
      ORDER BY SerieLote

      SELECT @Texto = (SELECT CAST(RenglonID AS VARCHAR) AS RenglonID,
                              ISNULL(Articulo,'') AS Articulo,
                              ISNULL(SerieLote,'') AS SerieLote,
                              CAST(Cantidad AS VARCHAR) AS Cantidad
                         FROM @Tabla AS TMA
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

/************** spIntelisisWMSSerieLoteActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSSerieLoteActualizar ')           AND type = 'P') drop procedure dbo.spIntelisisWMSSerieLoteActualizar
GO
CREATE PROCEDURE spIntelisisWMSSerieLoteActualizar
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
    @ModuloID                varchar(255),
    @RenglonID               varchar(255),
    @Articulo                varchar(20),
    @SubCuenta               varchar(50),
    @SerieLote               varchar(50),
    @Cantidad                varchar(255),
    @ModuloID2               int,
    @RenglonID2              int,
    @Cantidad2               float,
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Texto                   xml

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

  SELECT @SerieLote = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SerieLote'

  SELECT @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Cantidad'

  SET @Empresa    = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Modulo     = LTRIM(RTRIM(ISNULL(@Modulo,'')))
  SET @ModuloID2  = CAST(ISNULL(@ModuloID,'0') AS int)
  SET @RenglonID2 = CAST(ISNULL(@RenglonID,'0') AS int)
  SET @Articulo   = LTRIM(RTRIM(ISNULL(@Articulo,'')))
  SET @SubCuenta  = LTRIM(RTRIM(ISNULL(@SubCuenta,'')))
  SET @SerieLote  = LTRIM(RTRIM(ISNULL(@SerieLote,'')))
  SET @Cantidad2  = CAST(ISNULL(@Cantidad,'0') AS float)

  IF @ModuloID > 0
    BEGIN
      DECLARE @Tabla Table(
        Empresa              varchar(5),
        Modulo               varchar(5),
        ModuloID             int,
        RenglonID            int,
        Articulo             varchar(20),
        SubCuenta            varchar(20),
        SerieLote            varchar(50),
        Cantidad             float
      )

      IF @Modulo = 'INV'
      BEGIN
       UPDATE SerieLoteMovMovil
          SET Cantidad = @Cantidad2
        WHERE Empresa = @Empresa
          AND Modulo = @Modulo
          AND ID = @ModuloID2
          AND RenglonID = @RenglonID2
          AND Articulo = @Articulo
          AND LTRIM(RTRIM(ISNULL(SubCuenta,''))) = @SubCuenta
          AND SerieLote = @SerieLote

       DELETE SerieLoteMovMovil
        WHERE Empresa = @Empresa
          AND Modulo = @Modulo
          AND ID = @ModuloID2
          AND RenglonID = @RenglonID2
          AND ISNULL(Cantidad,0) = 0

      INSERT INTO @Tabla (Empresa,Modulo,ModuloID,RenglonID,Articulo,SubCuenta,SerieLote,Cantidad)
      SELECT Empresa,Modulo,ID,RenglonID,Articulo,SubCuenta,SerieLote,Cantidad
        FROM SerieLoteMovMovil
       WHERE Empresa = @Empresa
         AND Modulo = @Modulo
         AND ID = @ModuloID2
         AND RenglonID = @RenglonID2
         AND Articulo = @Articulo
         AND LTRIM(RTRIM(ISNULL(SubCuenta,''))) = @SubCuenta
         AND SerieLote = @SerieLote
      END

      IF @Modulo = 'COMS'
        BEGIN
         UPDATE SerieLoteMov
            SET Cantidad = @Cantidad2
          WHERE Empresa = @Empresa
            AND Modulo = @Modulo
            AND ID = @ModuloID2
            AND RenglonID = @RenglonID2
            AND Articulo = @Articulo
            AND LTRIM(RTRIM(ISNULL(SubCuenta,''))) = @SubCuenta
            AND SerieLote = @SerieLote

         DELETE SerieLoteMov
          WHERE Empresa = @Empresa
            AND Modulo = @Modulo
            AND ID = @ModuloID2
            AND RenglonID = @RenglonID2
            AND ISNULL(Cantidad,0) = 0

        INSERT INTO @Tabla (Empresa,Modulo,ModuloID,RenglonID,Articulo,SubCuenta,SerieLote,Cantidad)
        SELECT Empresa,Modulo,ID,RenglonID,Articulo,SubCuenta,SerieLote,Cantidad
          FROM SerieLoteMov
         WHERE Empresa = @Empresa
           AND Modulo = @Modulo
           AND ID = @ModuloID2
           AND RenglonID = @RenglonID2
           AND Articulo = @Articulo
           AND LTRIM(RTRIM(ISNULL(SubCuenta,''))) = @SubCuenta
           AND SerieLote = @SerieLote
        END

      SELECT @Texto = (SELECT Empresa,
                              Modulo,
                              CAST(ModuloID AS VARCHAR) AS ModuloID,
                              CAST(RenglonID AS VARCHAR) AS RenglonID,
                              Articulo,
                              SubCuenta,
                              SerieLote,
                              CAST(Cantidad AS VARCHAR) AS Cantidad
                         FROM @Tabla AS TMA
                       FOR XML AUTO)

    END
  ELSE
    BEGIN
      SET @Ok = 10160
    END

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO

/************** spIntelisisWMSInventarioActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInventarioActualizar ')           AND type = 'P') drop procedure dbo.spIntelisisWMSInventarioActualizar
GO
CREATE PROCEDURE spIntelisisWMSInventarioActualizar
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
    @ModuloID                varchar(255),
    @Renglon                 varchar(255),
    @RenglonSub              varchar(255),
    @RenglonID               varchar(255),
    @Cantidad                varchar(255),
    @ModuloID2               int,
    @Renglon2                float,
    @RenglonSub2             int,
    @RenglonID2              int,
    @Cantidad2               float,
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Texto                   xml

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @ModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ModuloID'

  SELECT @Renglon = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Renglon'

  SELECT @RenglonSub = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'RenglonSub'

  SELECT @RenglonID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'RenglonID'

  SELECT @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Cantidad'

  SET @Empresa     = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @ModuloID2   = CAST(ISNULL(@ModuloID,'0') AS int)
  SET @Renglon2    = CAST(ISNULL(@Renglon,'0') AS float)
  SET @RenglonSub2 = CAST(ISNULL(@RenglonSub,'0') AS int)
  SET @RenglonID2  = CAST(ISNULL(@RenglonID,'0') AS int)
  SET @Cantidad2   = CAST(ISNULL(@Cantidad,'0') AS float)

  SET @Texto = ''

  IF @ModuloID > 0
    BEGIN
      UPDATE InvD
         SET Cantidad = @Cantidad2,
             CantidadInventario = (ISNULL(Factor,1) * @Cantidad2)
       WHERE ID = @ModuloID2
         AND Renglon = @Renglon2
         AND RenglonSub = @RenglonSub2
         AND RenglonID = @RenglonID2
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
END
GO

/************** spIntelisisWMSOrdenCompraActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSOrdenCompraActualizar ') AND type = 'P') drop procedure dbo.spIntelisisWMSOrdenCompraActualizar
GO
CREATE PROCEDURE spIntelisisWMSOrdenCompraActualizar
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
    @ModuloID                varchar(255),
    @Renglon                 varchar(255),
    @RenglonSub              varchar(255),
    @RenglonID               varchar(255),
    @Cantidad                varchar(255),
    @ModuloID2               int,
    @Renglon2                float,
    @RenglonSub2             int,
    @RenglonID2              int,
    @Cantidad2               float,
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Texto                   xml

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @ModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ModuloID'

  SELECT @Renglon = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Renglon'

  SELECT @RenglonSub = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'RenglonSub'

  SELECT @RenglonID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'RenglonID'

  SELECT @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Cantidad'

  SET @Empresa     = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @ModuloID2   = CAST(ISNULL(@ModuloID,'0') AS int)
  SET @Renglon2    = CAST(ISNULL(@Renglon,'0') AS float)
  SET @RenglonSub2 = CAST(ISNULL(@RenglonSub,'0') AS int)
  SET @RenglonID2  = CAST(ISNULL(@RenglonID,'0') AS int)
  SET @Cantidad2   = CAST(ISNULL(@Cantidad,'0') AS float)

  SET @Texto = ''

  IF @ModuloID > 0
    BEGIN
      UPDATE CompraD
         SET CantidadA = @Cantidad2
       WHERE ID = @ModuloID2
         AND Renglon = @Renglon2
         AND RenglonSub = @RenglonSub2
         AND RenglonID = @RenglonID2
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
END
GO

/************** spIntelisisWMSInfoDetalleMovCOMS_O ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoDetalleMovCOMS_O ') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoDetalleMovCOMS_O
GO
CREATE PROCEDURE spIntelisisWMSInfoDetalleMovCOMS_O
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
    @Mov                     varchar(20),
    @MovID                   varchar(20),
    @ID2                     int,
    @Tolerancia              float,
    @CaducidadMinima         int,
    @FechaHoy                datetime,
    @Fecha                   datetime,
    @Unidad                  varchar(50),
    @Codigo                  varchar(30),
    @idx                     int,
    @Articulo                varchar(20),
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Texto                   xml

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovID'

    SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Mov      = LTRIM(RTRIM(ISNULL(@Mov,'')))
    SET @MovID    = LTRIM(RTRIM(ISNULL(@MovID,'')))
    SET @FechaHoy = dbo.fnFechaSinHora(GETDATE())
    SELECT @ID2   = ID FROM Compra WHERE Mov = @Mov AND MovID = @MovID

    SELECT @Tolerancia = ISNULL(CompraRecibirDemasTolerancia,0)
      FROM EmpresaCfg2
     WHERE Empresa = @Empresa
       AND CompraRecibirDemas = 1

    SET @Tolerancia = ISNULL(@Tolerancia,0)

    IF @ID2 > 0
      BEGIN
        DECLARE @Tabla Table(
          idx                  int IDENTITY(1,1),
          Renglon              float,
          RenglonSub           int,
          RenglonID            int,
          Articulo             varchar(20),
          SubCuenta            varchar(50),
          Descripcion1         varchar(100),
          Cantidad             float,
          CantidadPendiente    float,
          CantidadCancelada    float,
          CantidadA            float,
          CantidadInventario   float,
          CantidadMaxima       float,
          FechaCaducidadMinima varchar(8),
          Unidad               varchar(50),
          Codigo               varchar(30),
          Factor               float,
          Tipo                 varchar(20),
          SerieLoteInfo        int
        )
        INSERT INTO @Tabla(Renglon,RenglonSub,RenglonID,Articulo,SubCuenta,Cantidad,CantidadPendiente,CantidadCancelada,CantidadA,CantidadInventario,CantidadMaxima,Unidad,Factor)
        SELECT ISNULL(Renglon,0),
               ISNULL(RenglonSub,0),
               ISNULL(RenglonID,0),
               ISNULL(Articulo,''),
               ISNULL(SubCuenta,''),
               ISNULL(Cantidad,0.0),
               ISNULL(CantidadPendiente,0.0),
               ISNULL(CantidadCancelada,0.0),
               ISNULL(CantidadA,0.0),
               ISNULL(CantidadInventario,0.0),
               ISNULL(Cantidad,0.0),
               ISNULL(Unidad,''),
               ISNULL(Factor,0.0)
          FROM CompraD
         WHERE ID = @ID2

        IF @Tolerancia > 0
          BEGIN
            UPDATE @Tabla SET CantidadMaxima = ROUND((CantidadPendiente - CantidadCancelada) * ((100 + @Tolerancia) / 100), 0)
          END
        ELSE
          BEGIN
            UPDATE @Tabla SET CantidadMaxima = ROUND((CantidadPendiente - CantidadCancelada), 0)
          END

        UPDATE @Tabla
           SET Descripcion1  = ISNULL(b.Descripcion1,''),
               Tipo          = ISNULL(b.Tipo,'Normal'),
               SerieLoteInfo = ISNULL(b.SerieLoteInfo,0)
          FROM @Tabla a
         INNER JOIN Art b ON (a.Articulo = b.Articulo)

        DECLARE InfoDetalle_cr CURSOR FOR SELECT idx,Articulo,Unidad FROM @Tabla
        OPEN InfoDetalle_cr
        FETCH NEXT FROM InfoDetalle_cr INTO @idx, @Articulo, @Unidad
        WHILE @@FETCH_STATUS = 0
          BEGIN
            SELECT @CaducidadMinima = CaducidadMinima
              FROM Art
             WHERE Articulo = @Articulo
               AND TieneCaducidad = 1
               AND ControlArticulo = 'Caducidad'

            SET @CaducidadMinima = ISNULL(@CaducidadMinima,0)

            IF @CaducidadMinima > 0
              BEGIN
                SET @Fecha = DATEADD(day, @CaducidadMinima, @FechaHoy)
                UPDATE @Tabla
                   SET FechaCaducidadMinima = CAST(DATEPART(YEAR,@Fecha) AS VARCHAR) + RIGHT('00' + CAST(DATEPART(MONTH,@Fecha) AS VARCHAR) ,2) + RIGHT('00' + CAST(DATEPART(DAY,@Fecha) AS VARCHAR),2)
                 WHERE idx = @idx
              END

            SELECT @Codigo = Codigo
              FROM CB
             WHERE TipoCuenta = 'Articulos'
               AND Cuenta = @Articulo
               AND Unidad = @Unidad

            UPDATE @Tabla SET Codigo = ISNULL(@Codigo,'') WHERE idx = @idx

            FETCH NEXT FROM InfoDetalle_cr INTO @idx, @Articulo, @Unidad
          END
        CLOSE InfoDetalle_cr
        DEALLOCATE InfoDetalle_cr

        SELECT @Texto = (SELECT CAST(Renglon AS varchar)            AS Renglon,
                                CAST(RenglonSub AS varchar)         AS RenglonSub,
                                CAST(RenglonID AS varchar)          AS RenglonID,
                                ISNULL(Articulo,'')                 AS Articulo,
                                ISNULL(SubCuenta,'')                AS SubCuenta,
                                ISNULL(Descripcion1,'')             AS Descripcion1,
                                CAST(Cantidad AS varchar)           AS Cantidad,
                                CAST(CantidadPendiente AS varchar)  AS CantidadPendiente,
                                CAST(CantidadCancelada AS varchar)  AS CantidadCancelada,
                                CAST(CantidadA AS varchar)          AS CantidadA,
                                CAST(CantidadInventario AS varchar) AS CantidadInventario,
                                CAST(CantidadMaxima AS varchar)     AS CantidadMaxima,
                                ISNULL(FechaCaducidadMinima,'')     AS FechaCaducidadMinima,
                                ISNULL(Unidad,'')                   AS Unidad,
                                ISNULL(Codigo,'')                   AS Codigo,
                                CAST(Factor AS varchar)             AS Factor,
                                ISNULL(Tipo,'')                     AS Tipo,
                                CAST(SerieLoteInfo AS varchar)      AS SerieLoteInfo
                           FROM @Tabla AS TMA
                         FOR XML AUTO)

      END
    ELSE
      BEGIN
        SET @Ok = 10160
      END

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  END TRY

  BEGIN CATCH
	  SET @Ok = 1
	  SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'

END
GO
/************** spIntelisisWMSValidarZona ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSValidarZona') AND type = 'P') drop procedure dbo.spIntelisisWMSValidarZona
GO
CREATE PROCEDURE spIntelisisWMSValidarZona
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
    @Almacen                 varchar(10),
    @Articulo                varchar(20),
    @ZonaPosicion            varchar(30),
    @ZonaArticulo            varchar(30),
    @PosicionDestino         varchar(10),
    @ZonaValida              bit,
    @i                       int,
    @k                       int

  DECLARE @TablaArtZona Table(
    idx                      int IDENTITY(1,1),
    Zona                     varchar(30),
    Articulo                 varchar(20),
    Orden                    int
  )

  DECLARE @Tabla Table(
    ZonaValida               bit
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

    SELECT @PosicionDestino = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'PosicionDestino'

    INSERT INTO @TablaArtZona (Zona,Articulo,Orden)
    SELECT LTRIM(RTRIM(ISNULL(Zona,''))),
           LTRIM(RTRIM(ISNULL(Articulo,''))),
           Orden
      FROM ArtZona
     WHERE Articulo = @Articulo
     ORDER BY Orden

    DELETE @TablaArtZona WHERE Zona = ''

    SELECT @ZonaPosicion = LTRIM(RTRIM(ISNULL(Zona,'')))
      FROM AlmPos
     WHERE Almacen = @Almacen
       AND Posicion = @PosicionDestino

    SELECT @k = MAX(idx) FROM @TablaArtZona
    SET @k = ISNULL(@k,0)

    IF LTRIM(RTRIM(ISNULL(@ZonaPosicion,''))) = '' OR @k = 0
      BEGIN
        SET @ZonaValida = 1
      END
    ELSE
      BEGIN
        SET @ZonaValida = 0
        SET @i = 1
        WHILE @i <= @k AND @ZonaValida = 0
          BEGIN
            SELECT @ZonaArticulo = Zona FROM @TablaArtZona WHERE idx = @i
            IF @ZonaPosicion = @ZonaArticulo SET @ZonaValida = 1
            -- >
            SET @i = @i + 1
          END
      END

    INSERT INTO @Tabla (ZonaValida) VALUES (@ZonaValida)

    SELECT @Texto = (SELECT CAST(ZonaValida AS varchar) AS ZonaValida
                       FROM @Tabla AS TMA
                        FOR XML AUTO)

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  END CATCH

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
END
GO
/************** spIntelisisWMSInfoSerieLoteSurtido ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoSerieLoteSurtido') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoSerieLoteSurtido
GO
CREATE PROCEDURE spIntelisisWMSInfoSerieLoteSurtido
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
    @Texto                   xml,
    @Almacen                 varchar(10),
    @Mov                     varchar(20),
    @MovID                   varchar(20),
    @Tarima                  varchar(20),
    @IdTma                   int,
    @Articulo                varchar(20),
    @SubCuenta               varchar(50),
    @ArtCambioClave          varchar(20),
    @Cantidad                float,
    @Cantidad2               varchar(100)

  DECLARE @Tabla table(
    IdTma                    int,
    RenglonID                float,
    Articulo                 varchar(20),
    SubCuenta                varchar(50),
    ArtCambioClave           varchar(20),
    Descripcion1             varchar(100),
    SerieLote                varchar(50),
    Cantidad                 float
  )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Almacen'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovID'

    SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Tarima'

    SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Articulo'

    SELECT @Subcuenta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Subcuenta'

    SELECT @ArtCambioClave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'ArtCambioClave'

    SELECT @Cantidad2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Cantidad'

    SET @Empresa        = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Almacen        = LTRIM(RTRIM(ISNULL(@Almacen,'')))
    SET @Mov            = LTRIM(RTRIM(ISNULL(@Mov,'')))
    SET @MovID          = LTRIM(RTRIM(ISNULL(@MovID,'')))
    SET @Tarima         = LTRIM(RTRIM(ISNULL(@Tarima,'')))
    SET @Articulo       = LTRIM(RTRIM(ISNULL(@Articulo,'')))
    SET @SubCuenta      = LTRIM(RTRIM(ISNULL(@SubCuenta,'')))
    SET @ArtCambioClave = LTRIM(RTRIM(ISNULL(@ArtCambioClave,'')))
    SET @Cantidad2      = LTRIM(RTRIM(ISNULL(@Cantidad2,'0')))

    IF ISNUMERIC(@Cantidad2) = 1
      SET @Cantidad = CAST(@Cantidad2 AS float)
    ELSE
      SET @Cantidad = 0

    SELECT @IdTma = ID
      FROM TMA
     WHERE Empresa = @Empresa
       AND Almacen = @Almacen
       AND Mov = @Mov
       AND MovID = @MovID

    IF ISNULL(@IdTma,0) > 0
      BEGIN
        INSERT INTO @Tabla (IdTma, Articulo, SubCuenta, ArtCambioClave, SerieLote, Cantidad)
        SELECT @IdTma, @Articulo, @Subcuenta, @ArtCambioClave,SerieLote, @Cantidad
          FROM TarimaSerieLote
         WHERE Tarima = @Tarima

        UPDATE @Tabla
           SET Descripcion1 = b.Descripcion1
          FROM @Tabla a
          JOIN Art b ON (a.Articulo = b.Articulo)

        SELECT @Texto = (
          SELECT CAST(ISNULL(RenglonID,0) AS VARCHAR)    AS RenglonID,
                 LTRIM(RTRIM(ISNULL(Articulo,'')))       AS Articulo,
                 LTRIM(RTRIM(ISNULL(SubCuenta,'')))      AS SubCuenta,
                 LTRIM(RTRIM(ISNULL(ArtCambioClave,''))) AS ArtCambioClave,
                 LTRIM(RTRIM(ISNULL(Descripcion1,'')))   AS Descripcion1,
                 LTRIM(RTRIM(ISNULL(SerieLote,'')))      AS SerieLote,
                 CAST(ISNULL(Cantidad,0) AS VARCHAR)     AS Cantidad
            FROM @Tabla AS TMA
             FOR XML AUTO)

      END
    ELSE
      BEGIN
        SET @Ok = 30120
      END

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LEFT(LTRIM(RTRIM(ERROR_MESSAGE())), 255)
  END CATCH

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
/************** spIntelisisWMSOSURTarimasPckListado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSOSURTarimasPckListado') AND type = 'P') drop procedure dbo.spIntelisisWMSOSURTarimasPckListado
GO
CREATE PROCEDURE spIntelisisWMSOSURTarimasPckListado
    @ID                           int,
    @iSolicitud                   int,
    @Version                      float,
    @Resultado                    varchar(max) = NULL OUTPUT,
    @Ok                           int = NULL OUTPUT,
    @OkRef                        varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ReferenciaIS                 varchar(100),
    @SubReferencia                varchar(100),
    @Texto                        xml,
    @Empresa                      varchar(5),
    @Sucursal                     int,
    @SucursalNombre               varchar(100),
    @Usuario                      varchar(20),
    @Agente                       varchar(10),
    @Mov                          varchar(20)

  DECLARE @Tabla table(
    IdTma                         int,
    Renglon                       float,
    Tarima                        varchar(20),
    MovID                         varchar(20),
    Cantidad                      float,
    Posicion                      varchar(10),
    PosicionDescripcion           varchar(100),
    PosicionDestino               varchar(10),
    PosicionDestinoDescripcion    varchar(100),
    Articulo                      varchar(20),
    SubCuenta                     varchar(50),
    ArtCambioClave                varchar(20),
    Descripcion1                  varchar(100),
    ArtTipo                       varchar(20),
    OrigenTipo                    varchar(10),
    Origen                        varchar(20),
    OrigenID                      varchar(20),
    IdVenta                       int,
    Cliente                       varchar(10),
    ClienteNombre                 varchar(100),
    Almacen                       varchar(10),
    Unidad                        varchar(50)
  )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @SucursalNombre = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SucursalNombre'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SET @Empresa        = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @SucursalNombre = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))
    SET @Usuario        = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @Mov            = LTRIM(RTRIM(ISNULL(@Mov,'')))

    SELECT @Sucursal = Sucursal
      FROM Sucursal
     WHERE Nombre = @SucursalNombre

    SELECT @Agente = LTRIM(RTRIM(DefAgente))
      FROM Usuario
     WHERE Usuario = @Usuario

    IF ISNULL(@Agente,'') = '' SELECT @Ok = 20930

    INSERT INTO @Tabla (
           IdTma, Renglon, Tarima, MovID, Cantidad,
           Posicion, PosicionDestino, Articulo, SubCuenta, ArtCambioClave,
           Unidad, OrigenTipo, Origen, OrigenID, Almacen
           )
    SELECT t.ID, d.Renglon, d.Tarima, t.MovID, d.CantidadPendiente,
           d.Posicion, d.PosicionDestino, d.Articulo, d.Subcuenta, d.ArtCambioClave,
           d.Unidad, t.OrigenTipo, t.Origen, t.OrigenID, d.Almacen
      FROM TMA t
      JOIN TMAD d ON (t.id = d.ID)
     WHERE t.Empresa = @Empresa
       AND t.Sucursal = @Sucursal
       AND t.Estatus = 'PENDIENTE'
       AND t.Mov = @Mov
       AND d.Montacarga = @Agente
       AND d.procesado = 0

    UPDATE @Tabla
       SET Idventa = b.ID,
           Cliente = b.Cliente
      FROM @Tabla a
      JOIN Venta b ON (a.Origen = b.Mov AND a.OrigenID = b.MovID)
     WHERE a.OrigenTipo = 'VTAS'

    UPDATE @Tabla
       SET Idventa = b.ID,
           Cliente = b.AlmacenDestino
      FROM @Tabla a
      JOIN Inv b ON (a.Origen = b.Mov AND a.OrigenID = b.MovID)
     WHERE a.OrigenTipo = 'INV'

    UPDATE @Tabla
       SET ClienteNombre = b.Nombre
      FROM @Tabla a
      JOIN Cte b ON (a.Cliente = b.Cliente)
     WHERE a.OrigenTipo = 'VTAS'

    UPDATE @Tabla
       SET ClienteNombre = b.Nombre
      FROM @Tabla a
      JOIN ALm b ON (a.Cliente = b.Almacen)
     WHERE a.OrigenTipo = 'INV'

    UPDATE @Tabla
       SET Descripcion1 = b.Descripcion1,
           ArtTipo = b.Tipo
      FROM @Tabla a
      JOIN Art b ON (a.Articulo = b.Articulo)

    UPDATE @Tabla
       SET PosicionDescripcion = b.Descripcion
      FROM @Tabla a
      JOIN AlmPos b ON (a.Almacen = b.Almacen AND a.Posicion = b.Posicion)

    UPDATE @Tabla
       SET PosicionDestinoDescripcion = b.Descripcion
      FROM @Tabla a
      JOIN AlmPos b ON (a.Almacen = b.Almacen AND a.PosicionDestino = b.Posicion)

    SELECT @Texto = (
      SELECT CAST(ISNULL(IdTma,0) AS VARCHAR)                    AS IdTma,
             CAST(ISNULL(Renglon,0) AS VARCHAR)                  AS Renglon,
             LTRIM(RTRIM(ISNULL(Tarima,'')))                     AS Tarima,
             LTRIM(RTRIM(ISNULL(MovID,'')))                      AS MovID,
             CAST(ISNULL(Cantidad,0) AS VARCHAR)                 AS Cantidad,
             LTRIM(RTRIM(ISNULL(Posicion,'')))                   AS Posicion,
             LTRIM(RTRIM(ISNULL(PosicionDescripcion,'')))        AS PosicionDescripcion,
             LTRIM(RTRIM(ISNULL(PosicionDestino,'')))            AS PosicionDestino,
             LTRIM(RTRIM(ISNULL(PosicionDestinoDescripcion,''))) AS PosicionDestinoDescripcion,
             LTRIM(RTRIM(ISNULL(Articulo,'')))                   AS Articulo,
             LTRIM(RTRIM(ISNULL(SubCuenta,'')))                  AS SubCuenta,
             LTRIM(RTRIM(ISNULL(ArtCambioClave,'')))             AS ArtCambioClave,
             LTRIM(RTRIM(ISNULL(Descripcion1,'')))               AS Descripcion1,
             LTRIM(RTRIM(ISNULL(ArtTipo,'')))                    AS ArtTipo,
             LTRIM(RTRIM(ISNULL(Origen,'')))                     AS Origen,
             LTRIM(RTRIM(ISNULL(OrigenID,'')))                   AS OrigenID,
             CAST(ISNULL(IdVenta,0) AS VARCHAR)                  AS IdVenta,
             LTRIM(RTRIM(ISNULL(Cliente,'')))                    AS Cliente,
             LTRIM(RTRIM(ISNULL(ClienteNombre,'')))              AS ClienteNombre,
             LTRIM(RTRIM(ISNULL(Almacen,'')))                    AS Almacen,
             LTRIM(RTRIM(ISNULL(Unidad,'')))                     AS Unidad
        FROM @Tabla AS TMA
         FOR XML AUTO)

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LEFT(LTRIM(RTRIM(ERROR_MESSAGE())), 255)
  END CATCH

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
/************** spIntelisisWMSInfoSerieLoteSurtidoConsolidado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoSerieLoteSurtidoConsolidado ')           AND type = 'P') drop procedure dbo.spIntelisisWMSInfoSerieLoteSurtidoConsolidado
GO
CREATE PROCEDURE spIntelisisWMSInfoSerieLoteSurtidoConsolidado
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
    @Texto                   xml,
    @Almacen                 varchar(10),
    @Tarima                  varchar(20),
    @Articulo                varchar(20),
    @SubCuenta               varchar(50),
    @ArtCambioClave          varchar(20),
    @Cantidad                float,
    @Cantidad2               varchar(100)

  DECLARE @Tabla table(
    Articulo                 varchar(20),
    SubCuenta                varchar(50),
    ArtCambioClave           varchar(20),
    Descripcion1             varchar(100),
    SerieLote                varchar(50),
    Cantidad                 float
  )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Almacen'

    SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Tarima'

    SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Articulo'

    SELECT @Subcuenta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Subcuenta'

    SELECT @ArtCambioClave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'ArtCambioClave'

    SELECT @Cantidad2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Cantidad'

    SET @Empresa        = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Almacen        = LTRIM(RTRIM(ISNULL(@Almacen,'')))
    SET @Tarima         = LTRIM(RTRIM(ISNULL(@Tarima,'')))
    SET @Articulo       = LTRIM(RTRIM(ISNULL(@Articulo,'')))
    SET @SubCuenta      = LTRIM(RTRIM(ISNULL(@SubCuenta,'')))
    SET @ArtCambioClave = LTRIM(RTRIM(ISNULL(@ArtCambioClave,'')))
    SET @Cantidad2      = LTRIM(RTRIM(ISNULL(@Cantidad2,'0')))

    IF ISNUMERIC(@Cantidad2) = 1
      SET @Cantidad = CAST(@Cantidad2 AS float)
    ELSE
      SET @Cantidad = 0

    INSERT INTO @Tabla (Articulo, SubCuenta, ArtCambioClave, SerieLote, Cantidad)
    SELECT @Articulo, @Subcuenta, @ArtCambioClave, SerieLote, @Cantidad
      FROM TarimaSerieLote
     WHERE Tarima = @Tarima

    UPDATE @Tabla
       SET Descripcion1 = b.Descripcion1
      FROM @Tabla a
      JOIN Art b ON (a.Articulo = b.Articulo)

    SELECT @Texto = (
      SELECT LTRIM(RTRIM(ISNULL(Articulo,'')))       AS Articulo,
             LTRIM(RTRIM(ISNULL(SubCuenta,'')))      AS SubCuenta,
             LTRIM(RTRIM(ISNULL(ArtCambioClave,''))) AS ArtCambioClave,
             LTRIM(RTRIM(ISNULL(Descripcion1,'')))   AS Descripcion1,
             LTRIM(RTRIM(ISNULL(SerieLote,'')))      AS SerieLote,
             CAST(ISNULL(Cantidad,0) AS VARCHAR)     AS Cantidad
        FROM @Tabla AS TMA
         FOR XML AUTO)

  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LEFT(LTRIM(RTRIM(ERROR_MESSAGE())), 255)
  END CATCH

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
/************** spIntelisisWMSMovil ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSMovil ') AND type = 'P') drop procedure dbo.spIntelisisWMSMovil
GO
CREATE PROCEDURE spIntelisisWMSMovil
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
    @Texto                   xml,
    @Mov                     varchar(20),
    @MovID                   varchar(20),
    @Renglon                 float,
    @Renglon2                varchar(100),
    @Generado                char(1),
    @Procesado               char(1),
    @IdTma                   int

  DECLARE @Tabla table(
    IdTma                    int,
    Mov                      varchar(20),
    MovID                    varchar(20),
    Renglon                  float,
    Generado                 char(1),
    Procesado                char(1)
  )

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovID'

    SELECT @Renglon2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Renglon'

    SELECT @Generado = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Generado'

    SELECT @Procesado = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Procesado'

    SET @Empresa   = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Mov       = LTRIM(RTRIM(ISNULL(@Mov,'')))
    SET @MovID     = LTRIM(RTRIM(ISNULL(@MovID,'')))
    SET @Renglon2  = LTRIM(RTRIM(ISNULL(@Renglon2,'0')))
    SET @Generado  = ISNULL(@Generado,'0')
    SET @Procesado = ISNULL(@Procesado,'0')


    IF ISNUMERIC(@Renglon2) = 1
      SET @Renglon = CAST(ISNULL(@Renglon2,'0') AS float)
    ELSE
      SET @Renglon = 0

    SELECT @IdTma = ID
      FROM TMA
     WHERE Empresa = @Empresa
       AND Mov = @Mov
       AND MovID = @MovID

    IF EXISTS(SELECT GeneradoEnMovil FROM TMAD WHERE ID = @IdTma AND GeneradoEnMovil = 1)
      SET @Generado = '1'

    IF @Renglon = 0
      BEGIN
        UPDATE TMAD
           SET GeneradoEnMovil  = CAST(@Generado AS bit),
               ProcesadoEnMovil = CAST(@Procesado AS bit)
         WHERE ID = @IdTma
      END
    ELSE
      BEGIN
        UPDATE TMAD
           SET GeneradoEnMovil  = CAST(@Generado AS bit),
               ProcesadoEnMovil = CAST(@Procesado AS bit)
         WHERE ID = @IdTma
           AND Renglon = @Renglon
      END

    INSERT INTO @Tabla (IdTma,Mov,MovID,Renglon,Generado,Procesado) VALUES (@IdTma,@Mov,@MovID,@Renglon,@Generado,@Procesado)

    SELECT @Texto = (
      SELECT CAST(ISNULL(IdTma,0) AS VARCHAR)     AS IdTma,
             LTRIM(RTRIM(ISNULL(Mov,'')))         AS Mov,
             LTRIM(RTRIM(ISNULL(MovID,'')))       AS MovID,
             CAST(ISNULL(Renglon,0) AS VARCHAR)   AS Renglon,
             LTRIM(RTRIM(ISNULL(Generado,'')))    AS Generado,
             LTRIM(RTRIM(ISNULL(Procesado,'')))   AS Procesado
        FROM @Tabla AS TMA
         FOR XML AUTO)

    IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END TRY

  BEGIN CATCH
    SET @Ok = 1
    SELECT @OkRef = LEFT(LTRIM(RTRIM(ERROR_MESSAGE())), 255)
  END CATCH

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
/************** spIntelisisWMSTarimasPorCerrarLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSTarimasPorCerrarLista') AND type = 'P') drop procedure dbo.spIntelisisWMSTarimasPorCerrarLista
GO
CREATE PROCEDURE spIntelisisWMSTarimasPorCerrarLista
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
  @Almacen                   varchar(10),
  @Sucursal                  int,
  @SucursalNombre            varchar(100),
  @Usuario                   varchar(20),
  @Agente                    varchar(10)

DECLARE @Tabla Table(
  Empresa                    varchar(5),
  Almacen                    varchar(10),
  ModuloID                   int,
  Mov                        varchar(20),
  MovID                      varchar(20),
  Movimiento                 varchar(40),
  Tarima                     varchar(20),
  Articulo                   varchar(20),
  Cantidad                   float,
  TarimaCierre               varchar(20),
  PosicionDestino            varchar(10),
  DescripcionPosicionDestino varchar(100),
  Fecha                      datetime,
  Referencia                 varchar(50),
  Observaciones              varchar(100)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @SucursalNombre = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SucursalNombre'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SET @Empresa         = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @SucursalNombre  = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))
  SET @Almacen         = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Usuario         = LTRIM(RTRIM(ISNULL(@Usuario,'')))

  SELECT TOP 1 @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @SucursalNombre
  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
  
  IF LTRIM(RTRIM(ISNULL(@Almacen,'')))= ''
    BEGIN
      SELECT @Almacen = LTRIM(RTRIM(ISNULL(DefAlmacen,''))) From Usuario WHERE Usuario = @Usuario
      SET @Almacen = LTRIM(RTRIM(ISNULL(@Almacen,'')))
    END

  INSERT INTO @Tabla(ModuloID, Mov, MovId, Fecha, Referencia, Observaciones, TarimaCierre)
  SELECT t.ID, t.Mov, t.MovID, t.FechaEmision, t.Referencia, t.Observaciones, t.TarimaSurtido
    FROM TMA t
    JOIN MovTipo m ON (t.Mov = m.Mov AND m.Modulo = 'TMA')
   WHERE t.Empresa = @Empresa
     AND t.Sucursal = @Sucursal
     --AND t.Almacen = @Almacen
     AND t.Agente = @Agente
     AND t.Estatus = 'PROCESAR'
     AND m.Clave = 'TMA.TSUR'
     AND m.SubClave = 'TMA.TSURP'

  UPDATE @Tabla
     SET Empresa = @Empresa,
         Almacen = @Almacen,
         Movimiento = LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,'')))

  UPDATE @Tabla
     SET Tarima = ISNULL(b.Tarima, ''),
         Articulo = b.Articulo,
         Cantidad = b.CantidadPicking,
         PosicionDestino = b.PosicionDestino
    FROM @Tabla a
    JOIN TMAD b ON(a.ModuloID = b.ID)

  UPDATE @Tabla
     SET DescripcionPosicionDestino = b.Descripcion
    FROM @Tabla a
    JOIN AlmPos b ON (a.Almacen = b.Almacen AND a.PosicionDestino = b.Posicion)

  SELECT @Texto = (SELECT CAST(ISNULL(ModuloID,0) AS varchar)                AS ModuloID,
                          ISNULL(Mov,'')                                     AS Mov,
                          ISNULL(MovID,'')                                   AS MovID,
                          ISNULL(Movimiento,'')                              AS Movimiento,
                          ISNULL(Tarima,'')                                  AS Tarima,
                          ISNULL(Articulo,'')                                AS Articulo,
                          CAST(ISNULL(Cantidad,0) AS varchar)                AS Cantidad,
                          ISNULL(TarimaCierre,'')                            AS TarimaCierre,
                          ISNULL(PosicionDestino,'')                         AS PosicionDestino,
                          ISNULL(DescripcionPosicionDestino,'')              AS DescripcionPosicionDestino,
                          CONVERT(varchar(11), ISNULL(Fecha,'20150101'),113) AS Fecha,
                          ISNULL(Referencia,'')                              AS Referencia,
                          ISNULL(Observaciones,'')                           AS Observaciones
                     FROM @Tabla AS TMA
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSTarimasPorCerrarCuenta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSTarimasPorCerrarCuenta') AND type = 'P') drop procedure dbo.spIntelisisWMSTarimasPorCerrarCuenta
GO
CREATE PROCEDURE spIntelisisWMSTarimasPorCerrarCuenta
    @ID                         int,
    @iSolicitud                 int,
    @Version                    float,
    @Resultado                  varchar(max) = NULL OUTPUT,
    @Ok                         int = NULL OUTPUT,
    @OkRef                      varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE
  @Texto                        xml,
  @ReferenciaIS                 varchar(100),
  @SubReferencia                varchar(100),
  @Empresa                      varchar(5),
  @Almacen                      varchar(10),
  @Sucursal                     int,
  @SucursalNombre               varchar(100),
  @Usuario                      varchar(20),
  @Agente                       varchar(10),
  @TarimasPorCerrar             int

DECLARE @Tabla Table(
  Empresa                       varchar(5),
  Almacen                       varchar(10),
  ModuloID                      int,
  Mov                           varchar(20),
  MovID                         varchar(20),
  Movimiento                    varchar(40),
  Tarima                        varchar(20),
  Articulo                      varchar(20),
  Cantidad                      float,
  TarimaCierre                  varchar(20),
  PosicionDestino               varchar(10),
  DescripcionPosicionDestino    varchar(100),
  Fecha                         datetime,
  Referencia                    varchar(50),
  Observaciones                 varchar(100)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @SucursalNombre = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SucursalNombre'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SET @Empresa         = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @SucursalNombre  = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))
  SET @Almacen         = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Usuario         = LTRIM(RTRIM(ISNULL(@Usuario,'')))

  SELECT TOP 1 @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @SucursalNombre
  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario

  IF LTRIM(RTRIM(ISNULL(@Almacen,''))) = '' SELECT @Almacen = LTRIM(RTRIM(ISNULL(DefAlmacen,''))) FROM Usuario WHERE Usuario = @Usuario

  INSERT INTO @Tabla(ModuloID, Mov, MovId, Fecha, Referencia, Observaciones, TarimaCierre)
  SELECT t.ID, t.Mov, t.MovID, t.FechaEmision, t.Referencia, t.Observaciones, t.TarimaSurtido
    FROM TMA t
    JOIN MovTipo m ON (t.Mov = m.Mov AND m.Modulo = 'TMA')
   WHERE t.Empresa = @Empresa
     AND t.Sucursal = @Sucursal
     AND t.Almacen = @Almacen
     AND t.Agente = @Agente
     AND t.Estatus = 'PROCESAR'
     AND m.Clave = 'TMA.TSUR'
     AND m.SubClave = 'TMA.TSURP'

  UPDATE @Tabla
     SET Empresa = @Empresa,
         Almacen = @Almacen,
         Movimiento = LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,'')))

  UPDATE @Tabla
     SET Tarima = ISNULL(b.Tarima,''),
         Articulo = b.Articulo,
         Cantidad = b.CantidadPicking,
         PosicionDestino = b.PosicionDestino
    FROM @Tabla a
    JOIN TMAD b ON(a.ModuloID = b.ID)

  UPDATE @Tabla
     SET DescripcionPosicionDestino = b.Descripcion
    FROM @Tabla a
    JOIN AlmPos b ON (a.Almacen = b.Almacen AND a.PosicionDestino = b.Posicion)

  SELECT @TarimasPorCerrar = COUNT(ModuloID) FROM @Tabla

  SELECT @Texto = (SELECT TOP 1 CAST(ISNULL(ModuloID,0) AS varchar)          AS ModuloID,
                          ISNULL(Almacen,'')                                 AS Almacen,
                          ISNULL(Mov,'')                                     AS Mov,
                          ISNULL(MovID,'')                                   AS MovID,
                          ISNULL(Movimiento,'')                              AS Movimiento,
                          ISNULL(Tarima,'')                                  AS Tarima,
                          ISNULL(Articulo,'')                                AS Articulo,
                          CAST(ISNULL(Cantidad,0) AS varchar)                AS Cantidad,
                          ISNULL(TarimaCierre,'')                            AS TarimaCierre,
                          ISNULL(PosicionDestino,'')                         AS PosicionDestino,
                          ISNULL(DescripcionPosicionDestino,'')              AS DescripcionPosicionDestino,
                          CONVERT(varchar(11), ISNULL(Fecha,'20150101'),113) AS Fecha,
                          ISNULL(Referencia,'')                              AS Referencia,
                          ISNULL(Observaciones,'')                           AS Observaciones,
                          CAST(ISNULL(@TarimasPorCerrar,0) AS varchar)       AS TarimasPorCerrar
                     FROM @Tabla AS TMA
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSCerrarTarimasSurtidoTransitoPCK ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSCerrarTarimasSurtidoTransitoPCK') AND type = 'P') drop procedure dbo.spIntelisisWMSCerrarTarimasSurtidoTransitoPCK
GO
CREATE PROCEDURE spIntelisisWMSCerrarTarimasSurtidoTransitoPCK
    @ID                 int,
    @iSolicitud         int,
    @Version            float,
    @Resultado          varchar(max) = NULL OUTPUT,
    @Ok                 int = NULL OUTPUT,
    @OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE
  @Texto                xml,
  @ReferenciaIS         varchar(100),
  @SubReferencia        varchar(100),
  @Empresa              varchar(5),
  @ListaMovimientos     varchar(max),
  @Numero               varchar(20),
  @Usuario              varchar(10),
  @Estacion             int,
  @EnSilencio		        bit,
  @Fecha                datetime,
  @Msg                  varchar(300),
  @Delimitador          char(1),
  @Inicio               int,
  @Fin                  int,
  @idx                  int,
  @Maximo               int,
  @MaxIdx               int

DECLARE @ListaID table (
  idx                   int IDENTITY(1,1),
  ID                    varchar(10)
)

DECLARE @Tabla table (
  Msg                   varchar(300)
)

BEGIN TRY
  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @ListaMovimientos = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ListaMovimientos'

  SET @EnSilencio = 0
  SET @Estacion = @@SPID
  SET @Fecha = GETDATE()

  SET @Delimitador = '~'
  SET @Maximo = 1000
  SET @idx = 0

  SET @Inicio = 1
  SET @Fin = CHARINDEX(@Delimitador, @ListaMovimientos)

  WHILE (@Inicio < (LEN(@ListaMovimientos) + 1)) AND (@idx < @Maximo)
    BEGIN
      -- >
      SET @idx = @idx + 1

      IF @Fin = 0 SET @Fin = (LEN(@ListaMovimientos) + 1)

      INSERT INTO @ListaID (ID) VALUES(SUBSTRING(@ListaMovimientos, @Inicio, (@Fin - @Inicio)))

      SET @Inicio = (@Fin + 1)
      SET @Fin = CHARINDEX(@Delimitador, @ListaMovimientos, @Inicio)
    END

  SELECT @Usuario = Usuario FROM IntelisisService WHERE ID = @ID

  DELETE ListaID WHERE Estacion = @Estacion

  SELECT @MaxIdx = MAX(idx) FROM @ListaID
  SET @MaxIdx = ISNULL(@MaxIdx,0)
  SET @idx = 0
  WHILE @idx < @MaxIdx
    BEGIN
      -->
      SET @idx = @idx + 1
      SELECT @Numero = ID FROM @ListaID WHERE idx = @idx

      IF ISNUMERIC(@Numero) = 1
        BEGIN
          INSERT INTO ListaID (Estacion,ID)
          VALUES (@Estacion,CAST(@Numero AS int))
        END
    END

  EXEC spProcesarTMASurtidoTransito @Estacion, @Empresa , @Fecha, @Usuario, NULL, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT

  SET @Msg = ISNULL(@OkRef, '')
  SET @Msg = REPLACE(@Msg,'<BR>','.')

  INSERT INTO @Tabla(Msg) VALUES(@Msg)
  SELECT @Texto = (SELECT ISNULL(Msg,'') AS Msg FROM @Tabla AS TMA FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END TRY

BEGIN CATCH
  SET @Ok = 1
  SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  SELECT @Msg = 'Error: ' + CAST(ERROR_NUMBER() AS varchar) + ', Procedimiento: ' + ERROR_PROCEDURE() + ', Linea: ' + CAST(ERROR_LINE() AS varchar)  + ', Mensaje: '  + ERROR_MESSAGE() + '.'
  INSERT INTO @Tabla(Msg) VALUES(@Msg)
  SELECT @Texto = (SELECT ISNULL(Msg,'') AS Msg FROM @Tabla AS TMA FOR XML AUTO)
  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END CATCH

END
GO
/************** spIntelisisWMSTarimasPorMarcarLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSTarimasPorMarcarLista') AND type = 'P') drop procedure dbo.spIntelisisWMSTarimasPorMarcarLista
GO
CREATE PROCEDURE spIntelisisWMSTarimasPorMarcarLista
    @ID                 int,
    @iSolicitud         int,
    @Version            float,
    @Resultado          varchar(max) = NULL OUTPUT,
    @Ok                 int = NULL OUTPUT,
    @OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE
  @Texto                xml,
  @ReferenciaIS         varchar(100),
  @SubReferencia        varchar(100),
  @Empresa              varchar(5),
  @Almacen              varchar(10),
  @ListaMovimientos     varchar(max),
  @Delimitador          char(1),
  @Inicio               int,
  @Fin                  int,
  @idx                  int,
  @Maximo               int,
  @MaxIdx               int

DECLARE @ListaID table (
  idx                   int IDENTITY(1,1),
  ID                    varchar(10)
)

DECLARE @Tabla Table(
  Empresa               varchar(5),
  Almacen               varchar(10),
  ModuloID              int,
  Mov                   varchar(20),
  MovID                 varchar(20),
  Renglon               float
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @ListaMovimientos = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ListaMovimientos'

  SET @Empresa          = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Almacen          = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @ListaMovimientos = LTRIM(RTRIM(ISNULL(@ListaMovimientos,'')))

  SET @Delimitador = '~'
  SET @Maximo = 1000
  SET @idx = 0
  SET @Inicio = 1
  SET @Fin = CHARINDEX(@Delimitador, @ListaMovimientos)

  WHILE (@Inicio < (LEN(@ListaMovimientos) + 1)) AND (@idx < @Maximo)
    BEGIN
      -- >
      SET @idx = @idx + 1

      IF @Fin = 0 SET @Fin = (LEN(@ListaMovimientos) + 1)

      INSERT INTO @ListaID (ID) VALUES(SUBSTRING(@ListaMovimientos, @Inicio, (@Fin - @Inicio)))

      SET @Inicio = (@Fin + 1)
      SET @Fin = CHARINDEX(@Delimitador, @ListaMovimientos, @Inicio)
    END

INSERT INTO @Tabla (Empresa, Almacen, ModuloID, Mov, MovID)
SELECT @Empresa, @Almacen, t.ID, t.Mov, t.MovID
  FROM TMA t
  JOIN @ListaID d ON (t.ID = d.ID)

INSERT INTO @Tabla (Empresa, Almacen, ModuloID, Mov, MovID)
SELECT @Empresa, @Almacen, t.ID, t.Mov, t.MovID
  FROM TMA t
  JOIN @Tabla d ON (t.Origen = d.Mov AND t.OrigenID = d.MovID)

UPDATE @Tabla
   SET Renglon = b.Renglon
  FROM @Tabla a
  JOIN TMAD b ON(a.ModuloID = b.ID)

  SELECT @Texto = (SELECT CAST(ISNULL(ModuloID,0) AS varchar) AS ModuloID,
                          ISNULL(Mov,'')                      AS Mov,
                          ISNULL(MovID,'')                    AS MovID,
                          CAST(ISNULL(Renglon,0) AS varchar)  AS Renglon
                     FROM @Tabla AS TMA
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSTarimasLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSTarimasLista') AND type = 'P') drop procedure dbo.spIntelisisWMSTarimasLista
GO
CREATE PROCEDURE spIntelisisWMSTarimasLista
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
  @Almacen                   varchar(10),
  @Mov                       varchar(20),
  @MovID                     varchar(20),
  @Articulo                  varchar(20),
  @Usuario                   varchar(20),
  @Tipo                      varchar(20),
  @Posicion                  varchar(20),
  @IdTma                     int

DECLARE @Tabla Table(
  Tarima                     varchar(20),
  Existencia                 float,
  Disponible                 float,
  Apartado                   float,
  Posicion                   varchar(10),
  Descripcion                varchar(100),
  Tipo                       varchar(20),
  Pasillo                    int,
  Fila                       int,
  Nivel                      int,
  Zona                       varchar(50),
  EstatusControlCalidad      varchar(50)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Almacen  = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Mov      = LTRIM(RTRIM(ISNULL(@Mov,'')))
  SET @MovID    = LTRIM(RTRIM(ISNULL(@MovID,'')))
  SET @Articulo = LTRIM(RTRIM(ISNULL(@Articulo,'')))

  SELECT @Usuario = Usuario FROM IntelisisService WHERE ID = @ID
  SET @Usuario = LTRIM(RTRIM(ISNULL(@Usuario,'')))

  IF LTRIM(RTRIM(ISNULL(@Almacen,''))) = ''
    SELECT @Almacen = LTRIM(RTRIM(ISNULL(DefAlmacen,''))) From Usuario WHERE Usuario = @Usuario

  SET @Almacen  = LTRIM(RTRIM(ISNULL(@Almacen,'')))

  SELECT @IdTma = ID FROM TMA WHERE Mov = @Mov AND MovID = @MovID
  SELECT @Posicion = Posicion FROM TMAD WHERE ID = @IdTma
  SELECT @Tipo = Tipo FROM AlmPos WHERE Posicion = @Posicion

  INSERT INTO @Tabla(Tarima, Existencia, Disponible, Apartado, Posicion, Descripcion, Tipo, Pasillo, Fila, Nivel, Zona, EstatusControlCalidad)
  SELECT t.Tarima,
        ISNULL(d.Disponible,0) + ISNULL(d.Apartado,0),
        ISNULL(d.Disponible,0),
        ISNULL(d.Apartado,0),
        a.Posicion,
        a.Descripcion,
        a.Tipo,
        ISNULL(a.Pasillo,0),
        ISNULL(a.Fila,0),
        ISNULL(a.Nivel,0),
        a.Zona,
        LTRIM(RTRIM(ISNULL(t.EstatusControlCalidad,'')))
    FROM Tarima t
    JOIN AlmPos a ON (t.Posicion = a.Posicion)
    JOIN ArtDisponibleTarima d ON (t.Tarima = d.Tarima)
   WHERE d.Empresa = @Empresa
     AND d.Almacen = @Almacen
     AND t.Estatus = 'ALTA'
     AND a.Tipo = @Tipo
     AND t.Articulo = @Articulo

  DELETE @Tabla WHERE LEN(EstatusControlCalidad) > 0

  SELECT @Texto = (SELECT DISTINCT
                          LTRIM(RTRIM(ISNULL(Tarima,'')))              AS Tarima,
                          CAST(ISNULL(Existencia,0) AS varchar)        AS Existencia,
                          CAST(ISNULL(Disponible,0) AS varchar)        AS Disponible,
                          CAST(ISNULL(Apartado,0) AS varchar)          AS Apartado,
                          LTRIM(RTRIM(ISNULL(Posicion,'')))            AS Posicion,
                          LTRIM(RTRIM(ISNULL(Descripcion,'')))         AS Descripcion,
                          LTRIM(RTRIM(ISNULL(Tipo,'')))                AS Tipo,
                          CAST(ISNULL(Pasillo,0) AS varchar)           AS Pasillo,
                          CAST(ISNULL(Fila,0) AS varchar)              AS Fila,
                          CAST(ISNULL(Nivel,0) AS varchar)             AS Nivel,
                          LTRIM(RTRIM(ISNULL(Zona,'')))                AS Zona
                     FROM @Tabla AS TMA
                    ORDER BY Tarima
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSCambiarTarima ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSCambiarTarima') AND type = 'P') drop procedure dbo.spIntelisisWMSCambiarTarima
GO
CREATE PROCEDURE spIntelisisWMSCambiarTarima
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
  @Almacen                   varchar(10),
  @Usuario                   varchar(20),
  @Mov                       varchar(20),
  @MovID                     varchar(20),
  @TarimaCambio              varchar(20),
  @TarimaCambioPosicion      varchar(20),
  @IdTma                     int

DECLARE @Tabla Table(
  IdTma                      int,
  Tarima                     varchar(20),
  Posicion                   varchar(10)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  SELECT @TarimaCambio = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'TarimaCambio'

  SELECT @TarimaCambioPosicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'TarimaCambioPosicion'

  SET @Empresa              = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Almacen              = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Mov                  = LTRIM(RTRIM(ISNULL(@Mov,'')))
  SET @MovID                = LTRIM(RTRIM(ISNULL(@MovID,'')))
  SET @TarimaCambio         = LTRIM(RTRIM(ISNULL(@TarimaCambio,'')))
  SET @TarimaCambioPosicion = LTRIM(RTRIM(ISNULL(@TarimaCambioPosicion,'')))

  SELECT @Usuario = Usuario FROM IntelisisService WHERE ID = @ID
  SET @Usuario = LTRIM(RTRIM(ISNULL(@Usuario,'')))

  IF LTRIM(RTRIM(ISNULL(@Almacen,''))) = ''
    SELECT @Almacen = LTRIM(RTRIM(ISNULL(DefAlmacen,''))) From Usuario WHERE Usuario = @Usuario

  SET @Almacen = LTRIM(RTRIM(ISNULL(@Almacen,'')))

  SELECT @IdTma = ID
    FROM TMA
   WHERE Empresa = @Empresa
     AND Almacen = @Almacen
     AND Mov     = @Mov
     AND MovID   = @MovID

  SET @IdTma = ISNULL(@IdTma,0)

  IF LEN(@TarimaCambio) > 0 AND LEN(@TarimaCambioPosicion) > 0
    BEGIN
        UPDATE TMAD
           SET Tarima = @TarimaCambio,
               Posicion = @TarimaCambioPosicion
         WHERE ID = @IdTma
    END

  INSERT INTO @Tabla(IdTma,Tarima,Posicion)
  VALUES (@IdTma,@TarimaCambio,@TarimaCambioPosicion)

  SELECT @Texto = (SELECT CAST(ISNULL(IdTma,0) AS varchar)  AS IdTma,
                          LTRIM(RTRIM(ISNULL(Tarima,'')))   AS Tarima,
                          LTRIM(RTRIM(ISNULL(Posicion,''))) AS Posicion
                     FROM @Tabla AS TMA
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSTarimasArticuloLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSTarimasArticuloLista') AND type = 'P') drop procedure dbo.spIntelisisWMSTarimasArticuloLista
GO
CREATE PROCEDURE spIntelisisWMSTarimasArticuloLista
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
  @Sucursal                  varchar(10),
  @Usuario                   varchar(20),
  @Articulo                  varchar(20),
  @Unidad                    varchar(50),
  @Tarima                    varchar(20)

DECLARE @Tabla Table(
  Tarima                     varchar(20),
  Almacen                    varchar(10),
  Posicion                   varchar(10),
  Articulo                   varchar(20),
  SubCuenta                  varchar(50),
  Cantidad                   float,
  Unidad                     varchar(50),
  Tipo                       varchar(20),
  Descripcion                varchar(100),
  Pasillo                    int,
  Fila                       int,
  Nivel                      int,
  Zona                       varchar(50),
  ArticuloEsp                varchar(20),
  Existencia                 float,
  Disponible                 float,
  Apartado                   float,
  EstatusControlCalidad      varchar(50)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'

  SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal = LTRIM(RTRIM(ISNULL(@Sucursal,'')))
  SET @Articulo = LTRIM(RTRIM(ISNULL(@Articulo,'')))
  SET @Tarima   = LTRIM(RTRIM(ISNULL(@Tarima,'')))
  
  SELECT @Usuario = Usuario FROM IntelisisService WHERE ID = @ID
  SET @Usuario = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  SELECT @Unidad = ISNULL(UnidadCompra, ISNULL(Unidad,'pza')) FROM Art WHERE Articulo = @Articulo

  INSERT INTO @Tabla(Tarima, Almacen, Posicion, Articulo, SubCuenta, Unidad, Tipo, Descripcion, Pasillo, Fila, Nivel, Zona, ArticuloEsp, Existencia, Disponible, Apartado, EstatusControlCalidad)
  SELECT t.Tarima,
         t.Almacen,
         t.Posicion,
         t.Articulo,
         t.SubCuenta,
         @Unidad,
         a.Tipo,
         a.Descripcion,
         ISNULL(a.Pasillo,0),
         ISNULL(a.Fila,0),
         ISNULL(a.Nivel,0),
         a.Zona,
         a.ArticuloEsp,
         ISNULL(d.Disponible,0) + ISNULL(d.Apartado,0),
         ISNULL(d.Disponible,0),
         ISNULL(d.Apartado,0),
         LTRIM(RTRIM(ISNULL(t.EstatusControlCalidad,'')))
    FROM Tarima t
    LEFT JOIN AlmPos a ON (t.Almacen = a.Almacen AND t.Posicion = a.Posicion)
    JOIN ArtDisponibleTarima d ON (t.Tarima = d.Tarima)
  JOIN Alm aa ON  (a.Almacen = aa.Almacen)
  JOIN Sucursal s ON (aa.Sucursal = s.Sucursal)
   WHERE t.Estatus = 'ALTA'
     AND s.Sucursal = @Sucursal
     AND d.Articulo = @Articulo
     AND d.Disponible > 0

  DELETE @Tabla WHERE LEN(EstatusControlCalidad) > 0
    
  IF LEN(ISNULL(@Tarima,'')) > 0 
    BEGIN
      DELETE @Tabla WHERE NOT Tarima = @Tarima 
      UPDATE @Tabla SET Articulo = @Articulo
    END
 
  UPDATE @Tabla SET Cantidad = Existencia 

  SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Tarima,'')))                AS Tarima,
                          LTRIM(RTRIM(ISNULL(Almacen,'')))               AS Almacen,
                          LTRIM(RTRIM(ISNULL(Posicion,'')))              AS Posicion,
                          LTRIM(RTRIM(ISNULL(Articulo,'')))              AS Articulo,
                          LTRIM(RTRIM(ISNULL(SubCuenta,'')))             AS SubCuenta,
                          CAST(ISNULL(Cantidad,0) AS varchar)            AS Cantidad,
                          LTRIM(RTRIM(ISNULL(Unidad,'')))                AS Unidad,
                          LTRIM(RTRIM(ISNULL(Tipo,'')))                  AS Tipo,
                          LTRIM(RTRIM(ISNULL(Descripcion,'')))           AS Descripcion,
                          CAST(ISNULL(Pasillo,0) AS varchar)             AS Pasillo,
                          CAST(ISNULL(Fila,0) AS varchar)                AS Fila,
                          CAST(ISNULL(Nivel,0) AS varchar)               AS Nivel,
                          LTRIM(RTRIM(ISNULL(Zona,'')))                  AS Zona,
                          LTRIM(RTRIM(ISNULL(ArticuloEsp,'')))           AS ArticuloEsp,
                          CAST(ISNULL(Existencia,0) AS varchar)          AS Existencia,
                          CAST(ISNULL(Disponible,0) AS varchar)          AS Disponible,
                          CAST(ISNULL(Apartado,0) AS varchar)            AS Apartado,
                          LTRIM(RTRIM(ISNULL(EstatusControlCalidad,''))) AS EstatusControlCalidad
                     FROM @Tabla AS TMA
                    ORDER BY Tarima
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSPosicionesArticuloLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSPosicionesArticuloLista') AND type = 'P') drop procedure dbo.spIntelisisWMSPosicionesArticuloLista
GO
CREATE PROCEDURE spIntelisisWMSPosicionesArticuloLista
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
  @Sucursal                  varchar(10),
  @Almacen                   varchar(10),
  @Tipo                      varchar(20),
  @Tarima                    varchar(20),
  @Articulo                  varchar(20),
  @TMAID                     int,
  @ValidarCapacidad          bit

DECLARE @Tabla Table(
  Almacen                    varchar(10),
  Posicion                   varchar(10),
  Tipo                       varchar(20),
  Descripcion                varchar(100),
  Pasillo                    int,
  Fila                       int,
  Nivel                      int,
  Zona                       varchar(50),
  Capacidad                  int,
  Estatus                    varchar(15),
  ArticuloEsp                varchar(20),
  Alto                       float,
  Largo                      float,
  Ancho                      float,
  Volumen                    float,
  PesoMaximo                 float,
  Orden                      int,
  TipoRotacion               varchar(10),
  Subtipo                    varchar(20)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Tipo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tipo'

  SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal = LTRIM(RTRIM(ISNULL(@Sucursal,'')))
  SET @Almacen  = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Tipo     = LTRIM(RTRIM(ISNULL(@Tipo,'')))
  SET @Tarima   = LTRIM(RTRIM(ISNULL(@Tarima,'')))
  SET @Articulo = LTRIM(RTRIM(ISNULL(@Articulo,'')))

  SET @TMAID = NULL
  SET @ValidarCapacidad = 1

  INSERT INTO @Tabla(Almacen, Posicion, Tipo, Descripcion, Pasillo, Fila, Nivel, Zona, Capacidad, Estatus, ArticuloEsp, Alto, Largo, Ancho, Volumen, PesoMaximo, Orden, TipoRotacion, Subtipo)
  SELECT Almacen, Posicion, Tipo, Descripcion, Pasillo, Fila, Nivel, Zona, Capacidad, Estatus, ArticuloEsp, Alto, Largo, Ancho, Volumen, PesoMaximo, Orden, TipoRotacion, Subtipo
    FROM dbo.fnWMSPosicionDestinoLista(@Almacen, @Articulo, @Tipo, @Empresa, @Tarima, @TMAID, @ValidarCapacidad)

  SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Almacen,'')))      AS Almacen,
                          LTRIM(RTRIM(ISNULL(Posicion,'')))     AS Posicion,
                          LTRIM(RTRIM(ISNULL(Tipo,'')))         AS Tipo,
                          LTRIM(RTRIM(ISNULL(Descripcion,'')))  AS Descripcion,
                          CAST(ISNULL(Pasillo,0) AS varchar)    AS Pasillo,
                          CAST(ISNULL(Fila,0) AS varchar)       AS Fila,
                          CAST(ISNULL(Nivel,0) AS varchar)      AS Nivel,
                          LTRIM(RTRIM(ISNULL(Zona,'')))         AS Zona,
                          CAST(ISNULL(Capacidad,0) AS varchar)  AS Capacidad,
                          LTRIM(RTRIM(ISNULL(Estatus,'')))      AS Estatus,
                          LTRIM(RTRIM(ISNULL(ArticuloEsp,'')))  AS ArticuloEsp,
                          CAST(ISNULL(Alto,0) AS varchar)       AS Alto,
                          CAST(ISNULL(Largo,0) AS varchar)      AS Largo,
                          CAST(ISNULL(Ancho,0) AS varchar)      AS Ancho,
                          CAST(ISNULL(Volumen,0) AS varchar)    AS Volumen,
                          CAST(ISNULL(PesoMaximo,0) AS varchar) AS PesoMaximo,
                          CAST(ISNULL(Orden,0) AS varchar)      AS Orden,
                          LTRIM(RTRIM(ISNULL(TipoRotacion,''))) AS TipoRotacion,
                          LTRIM(RTRIM(ISNULL(Subtipo,'')))      AS Subtipo
                     FROM @Tabla AS TMA
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSGenerarSolicitudReacomodo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSGenerarSolicitudReacomodo') AND type = 'P') drop procedure dbo.spIntelisisWMSGenerarSolicitudReacomodo
GO
CREATE PROCEDURE spIntelisisWMSGenerarSolicitudReacomodo
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
  @Sucursal                  varchar(10),
  @Almacen                   varchar(10),
  @Mov                       varchar(20),
  @MovID                     varchar(20),
  @MontaCarga                varchar(10),
  @Prioridad                 varchar(10),
  @Tarima                    varchar(20),
  @Posicion                  varchar(10),
  @PosicionDestino           varchar(10),
  @Zona                      varchar(50),
  @CantidadPicking           float,
  @CantidadPickingTmp        varchar(50),
  @Unidad                    varchar(50),
  @CantidadUnidad            float,
  @Articulo                  varchar(20),
  @SubCuenta                 varchar(50),
  @FechaEmision              datetime,
  @UltimoCambio              datetime,
  @Estatus                   varchar(15),
  @SucursalOrigen            varchar(10),
  @Renglon                   float,
  @Procesado                 bit,
  @GeneradoEnMovil           bit,
  @Usuario                   varchar(20),
  @Agente                    varchar(10),
  @TMAID                     int,
  @CapacidadPosicion         bit,
  @Estacion                  int,
  @CantidadPendiente         float,
  @NombreTrans               varchar(32)

DECLARE @Tabla Table(
  ModuloID                   int,
  Mov                        varchar(20),
  Movid                      varchar(20),
  Estatus                    varchar(15),
  Mensaje                    varchar(255)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MontaCarga = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MontaCarga'

  SELECT @Prioridad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Prioridad'

  SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'

  SELECT @Posicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'

  SELECT @PosicionDestino = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'PosicionDestino'

  SELECT @Zona = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Zona'

  SELECT @CantidadPickingTmp = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'CantidadPicking'

  SELECT @Unidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Unidad'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SELECT @SubCuenta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SubCuenta'

  SET @Empresa         = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal        = LTRIM(RTRIM(ISNULL(@Sucursal,'')))
  SET @Almacen         = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Mov             = LTRIM(RTRIM(ISNULL(@Mov,'')))
  SET @MontaCarga      = LTRIM(RTRIM(ISNULL(@MontaCarga,'')))
  SET @Prioridad       = LTRIM(RTRIM(ISNULL(@Prioridad,'')))
  SET @Tarima          = LTRIM(RTRIM(ISNULL(@Tarima,'')))
  SET @Posicion        = LTRIM(RTRIM(ISNULL(@Posicion,'')))
  SET @PosicionDestino = LTRIM(RTRIM(ISNULL(@PosicionDestino,'')))
  SET @Zona            = LTRIM(RTRIM(ISNULL(@Zona,'')))
  SET @CantidadPicking = CAST(LTRIM(RTRIM(ISNULL(@CantidadPickingTmp,'0'))) AS float)
  SET @Unidad          = LTRIM(RTRIM(ISNULL(@Unidad,'')))
  SET @Articulo        = LTRIM(RTRIM(ISNULL(@Articulo,'')))
  SET @SubCuenta       = LTRIM(RTRIM(ISNULL(@SubCuenta,'')))

  SET @CantidadUnidad  = NULL

  SELECT @Usuario = Usuario FROM IntelisisService WHERE ID = @ID
  SET @Usuario = LTRIM(RTRIM(ISNULL(@Usuario,'')))

  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
  SET @Agente = LTRIM(RTRIM(ISNULL(@Agente,'')))

  SET @TMAID = NULL
  SET @CapacidadPosicion = 0

  SET @FechaEmision    = GETDATE()
  SET @UltimoCambio    = GETDATE()
  SET @SucursalOrigen  = @Sucursal
  SET @Estatus         = 'SINAFECTAR'
  SET @Procesado       = 0
  SET @GeneradoEnMovil = 1
  SET @Estacion        = @@SPID
  SET @NombreTrans     = 'TMA_SRADO' + CAST(@Estacion AS varchar)

  INSERT INTO TMA (Empresa, Mov, FechaEmision, UltimoCambio, Usuario, Estatus, Sucursal, SucursalOrigen, Almacen, Agente, MontaCarga, Prioridad)
  SELECT @Empresa, @Mov, @FechaEmision, @UltimoCambio, @Usuario, @Estatus, @Sucursal, @SucursalOrigen, @Almacen, @Agente, @MontaCarga, @Prioridad

  SELECT @TMAID = SCOPE_IDENTITY()

  IF ISNULL(@TMAID,0) > 0
    BEGIN
      SET @Renglon = 2048
      IF LTRIM(RTRIM(ISNULL(@SubCuenta,''))) = '' SET @SubCuenta = NULL

      INSERT INTO TMAD (ID, Renglon, Sucursal, SucursalOrigen, Tarima, Almacen, Posicion, PosicionDestino, Zona, CantidadPicking, CantidadPendiente, Procesado, Prioridad, Montacarga, CapacidadPosicion, Unidad, CantidadUnidad, Articulo, SubCuenta, GeneradoEnMovil)
      VALUES (@TMAID, @Renglon, @Sucursal, @SucursalOrigen, @Tarima, @Almacen, @Posicion, @PosicionDestino, @Zona, @CantidadPicking, @CantidadPendiente, @Procesado, @Prioridad, @Agente, @CapacidadPosicion, @Unidad, @CantidadUnidad, @Articulo, @SubCuenta, @GeneradoEnMovil)

      EXEC spAfectar 'TMA', @TMAID, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

      IF ISNULL(@Ok,0) = 0
        BEGIN
          UPDATE TMA SET @UltimoCambio = GETDATE() WHERE ID = @TMAID
          SELECT @Movid = MovID, @Estatus = LTRIM(RTRIM(ISNULL(Estatus,''))) FROM TMA WHERE ID = @TMAID
        END
      ELSE
        BEGIN
          SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
        END
    END

  INSERT INTO @Tabla (ModuloID, Mov, Movid, Estatus, Mensaje)
  VALUES (@TMAID, @Mov, @Movid, @Estatus, @OkRef)

END TRY

BEGIN CATCH
  SET @Ok = 1
  SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
END CATCH

SELECT @Texto = (SELECT CAST(ISNULL(ModuloID,0) AS varchar) AS ModuloID,
                        LTRIM(RTRIM(ISNULL(Mov,'')))        AS Mov,
                        LTRIM(RTRIM(ISNULL(Movid,'')))      AS Movid,
                        LTRIM(RTRIM(ISNULL(Estatus,'')))    AS Estatus,
                        LTRIM(RTRIM(ISNULL(Mensaje,'')))    AS Mensaje
                   FROM @Tabla AS TMA
                    FOR XML AUTO)

SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
SET @Resultado = REPLACE(@Resultado,'<BR>','.')

END
GO
/************** spIntelisisWMSInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfo') AND type = 'P') drop procedure dbo.spIntelisisWMSInfo
GO
CREATE PROCEDURE spIntelisisWMSInfo
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
  @Articulo                  varchar(20),
  @Posicion                  varchar(20),
  @Tarima                    varchar(20)

DECLARE @TablaAlm table(
  Almacen                    varchar(10)
)

DECLARE @TablaTarima table(
  Tarima                     varchar(20)
)


DECLARE @Tabla Table(
  Almacen                    varchar(10),
  Articulo                   varchar(20),
  ArticuloDescripcion        varchar(100),
  SubCuenta                  varchar(50),
  Tarima                     varchar(20),
  Existencia                 float,
  Disponible                 float,
  Apartado                   float,
  Posicion                   varchar(10),
  Descripcion                varchar(100),
  Tipo                       varchar(20),
  Pasillo                    int,
  Fila                       int,
  Nivel                      int,
  Zona                       varchar(50),
  EstatusControlCalidad      varchar(50),
  TarimaEstatus              varchar(15),
  UnidadVenta                varchar(50),
  UnidadCompra               varchar(50),
  UnidadTraspaso             varchar(50),
  Factor                     float,
  ArticuloTipo               varchar(20)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @sSucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'

  SELECT @Posicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'

  SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal = CAST(ISNULL(@sSucursal,'0') AS int)
  SET @Articulo = LTRIM(RTRIM(ISNULL(@Articulo,'')))
  SET @Tarima   = LTRIM(RTRIM(ISNULL(@Tarima,'')))
  SET @Posicion = LTRIM(RTRIM(ISNULL(@Posicion,'')))

  IF LEN(@Articulo) > 0
    BEGIN
      IF NOT EXISTS (SELECT TOP 1 Articulo FROM Art WHERE Articulo = @Articulo)
        BEGIN
          SET @Ok = 1
          SET @OkRef = 'El artículo ' + @Articulo + ' no existe.'
        END
    END
  ELSE IF LEN(@Tarima) > 0
    BEGIN
      IF NOT EXISTS (SELECT TOP 1 Tarima FROM Tarima WHERE Tarima = @Tarima)
        BEGIN
          SET @Ok = 1
          SET @OkRef = 'La tarima ' + @Tarima + ' no existe.'
      END
    END
  ELSE IF LEN(@Posicion) > 0
    BEGIN
      IF NOT EXISTS (SELECT TOP 1 Posicion FROM AlmPos WHERE Posicion = @Posicion)
        BEGIN
          SET @Ok = 1
          SET @OkRef = 'La posición ' + @Posicion + ' no existe.'
      END
    END
  ELSE
    BEGIN
      SET @Ok = 1
      SET @OkRef = 'Parametros incorrectos.'
    END

  IF ISNULL(@Ok,0) = 0
    BEGIN
      INSERT INTO @TablaAlm (Almacen)
      SELECT Almacen
        FROM Alm
       WHERE Sucursal = @Sucursal
         AND WMS = 1
         AND Estatus = 'ALTA'

      -- Información artículo
      IF LEN(@Articulo) > 0
        BEGIN
          INSERT INTO @Tabla(ALmacen, Articulo, Tarima, Existencia, Disponible, Apartado, Posicion, Descripcion, Tipo, Pasillo, Fila, Nivel, Zona, EstatusControlCalidad, TarimaEstatus)
          SELECT a.Almacen,
                 @Articulo,
                 t.Tarima,
                 ISNULL(adt.Disponible,0) + ISNULL(adt.Apartado,0),
                 ISNULL(adt.Disponible,0),
                 ISNULL(adt.Apartado,0),
                 a.Posicion,
                 a.Descripcion,
                 a.Tipo,
                 ISNULL(a.Pasillo,0),
                 ISNULL(a.Fila,0),
                 ISNULL(a.Nivel,0),
                 a.Zona,
                 LTRIM(RTRIM(ISNULL(t.EstatusControlCalidad,''))),
                 t.Estatus
            FROM ArtDisponibleTarima adt
            LEFT JOIN Tarima t ON (adt.Tarima = t.Tarima)
            LEFT JOIN AlmPos a ON (a.Almacen = t.Almacen AND a.Posicion = t.Posicion)
            JOIN @TablaAlm al ON (a.Almacen = al.Almacen)
           WHERE adt.Empresa = @Empresa
             AND adt.Articulo = @Articulo
             AND adt.Disponible <> 0
        END
      -- Información tarima
      ELSE IF LEN(@Tarima) > 0
        BEGIN
          INSERT INTO @Tabla(Almacen, Articulo, Tarima, Existencia, Disponible, Apartado)
          SELECT Almacen, Articulo, Tarima, ISNULL(Disponible,0) + ISNULL(Apartado,0), Disponible, Apartado
            FROM ArtDisponibleTarima
           WHERE Empresa = @Empresa
             AND Tarima = @Tarima

          UPDATE @Tabla
             SET Posicion              = b.Posicion,
                 EstatusControlCalidad = b.EstatusControlCalidad,
                 TarimaEstatus         = b.Estatus
            FROM @Tabla a
           INNER JOIN Tarima b ON (a.Tarima = b.Tarima)

          UPDATE @Tabla
             SET Descripcion = b.Descripcion,
                 Tipo        = b.Tipo,
                 Pasillo     = b.Pasillo,
                 Fila        = b.Fila,
                 Nivel       = b.Nivel,
                 Zona        = b.Zona
            FROM @Tabla a
           INNER JOIN AlmPos b ON (a.Posicion = b.Posicion)
        END
      -- Información posición
      ELSE IF LEN(@Posicion) > 0
        BEGIN
          INSERT INTO @TablaTarima (Tarima)
          SELECT Tarima
            FROM Tarima
           WHERE Posicion = @Posicion

          INSERT INTO @Tabla(Tarima,Almacen,Posicion,TarimaEstatus,Articulo,SubCuenta, Existencia, Disponible, Apartado ,EstatusControlCalidad)
          SELECT adt.Tarima, adt.Almacen, @Posicion, t.Estatus, adt.Articulo,t.SubCuenta, ISNULL(adt.Disponible,0) + ISNULL(adt.Apartado,0) , adt.Disponible, adt.Apartado,t.EstatusControlCalidad
          FROM ArtDisponibleTarima adt
          JOIN @TablaTarima tt ON (adt.Tarima = tt.Tarima)
          JOIN Tarima t ON (tt.Tarima = t.Tarima)

          UPDATE @Tabla
             SET Descripcion = b.Descripcion,
                 Tipo        = b.Tipo,
                 Pasillo     = b.Pasillo,
                 Fila        = b.Fila,
                 Nivel       = b.Nivel,
                 Zona        = b.Zona
            FROM @Tabla a
           INNER JOIN AlmPos b ON (a.Posicion = b.Posicion)
        END

      UPDATE @Tabla
         SET ArticuloDescripcion = ISNULL(b.Descripcion1,''),
             UnidadVenta         = ISNULL(b.Unidad,''),
             UnidadCompra        = ISNULL(b.UnidadCompra,''),
             UnidadTraspaso      = ISNULL(b.UnidadTraspaso,''),
             ArticuloTipo        = ISNULL(b.Tipo,'') 
        FROM @Tabla a
       INNER JOIN Art b ON (a.Articulo = b.Articulo)

      UPDATE @Tabla
         SET Factor = b.Factor
        FROM @Tabla a
       INNER JOIN ArtUnidad b ON (a.Articulo = b.Articulo AND a.UnidadTraspaso = b.Unidad)

      SELECT @Texto = (SELECT DISTINCT
                              LTRIM(RTRIM(ISNULL(Almacen,'')))               AS Almacen,
                              LTRIM(RTRIM(ISNULL(Articulo,'')))              AS Articulo,
                              LTRIM(RTRIM(ISNULL(ArticuloDescripcion,'')))   AS ArticuloDescripcion,
                              LTRIM(RTRIM(ISNULL(SubCuenta,'')))             AS SubCuenta,
                              LTRIM(RTRIM(ISNULL(Tarima,'')))                AS Tarima,
                              CAST(ISNULL(Existencia,0) AS varchar)          AS Existencia,
                              CAST(ISNULL(Disponible,0) AS varchar)          AS Disponible,
                              CAST(ISNULL(Apartado,0) AS varchar)            AS Apartado,
                              LTRIM(RTRIM(ISNULL(Posicion,'')))              AS Posicion,
                              LTRIM(RTRIM(ISNULL(Descripcion,'')))           AS Descripcion,
                              LTRIM(RTRIM(ISNULL(Tipo,'')))                  AS Tipo,
                              CAST(ISNULL(Pasillo,0) AS varchar)             AS Pasillo,
                              CAST(ISNULL(Fila,0) AS varchar)                AS Fila,
                              CAST(ISNULL(Nivel,0) AS varchar)               AS Nivel,
                              LTRIM(RTRIM(ISNULL(Zona,'')))                  AS Zona,
                              LTRIM(RTRIM(ISNULL(EstatusControlCalidad,''))) AS EstatusControlCalidad,
                              LTRIM(RTRIM(ISNULL(TarimaEstatus,'')))         AS TarimaEstatus,
                              LTRIM(RTRIM(ISNULL(UnidadVenta,'')))           AS UnidadVenta,
                              LTRIM(RTRIM(ISNULL(UnidadCompra,'')))          AS UnidadCompra,
                              LTRIM(RTRIM(ISNULL(UnidadTraspaso,'')))        AS UnidadTraspaso,
                              CAST(ISNULL(Factor,0) AS varchar)              AS Factor,
                              LTRIM(RTRIM(ISNULL(ArticuloTipo,'')))          AS ArticuloTipo
                         FROM @Tabla AS TMA
                        ORDER BY Tarima
                          FOR XML AUTO)

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
/************** spIntelisisWMSAlmacenesLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSAlmacenesLista') AND type = 'P') drop procedure dbo.spIntelisisWMSAlmacenesLista
GO
CREATE PROCEDURE spIntelisisWMSAlmacenesLista
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
  @Usuario                   varchar(20),
  @Agente                    varchar(10),
  @DefAlmacen                varchar(10)

DECLARE @Tabla Table(
  Almacen                    varchar(10),
  DefAlmacen                 varchar(10)
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

  SET @Empresa        = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal       = CAST(ISNULL(@sSucursal,'0') AS int)
  SET @SucursalNombre = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))

  SELECT @Usuario = Usuario FROM IntelisisService WHERE ID = @ID
  SET @Usuario = LTRIM(RTRIM(ISNULL(@Usuario,'')))

  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
  SET @Agente = LTRIM(RTRIM(ISNULL(@Agente,'')))

  SELECT @DefAlmacen = DefAlmacen FROM Usuario WHERE Usuario = @Usuario

  INSERT INTO @Tabla (Almacen, DefAlmacen)
  SELECT Almacen, @DefAlmacen
    FROM Alm
   WHERE Sucursal = @Sucursal
     AND WMS = 1
     AND Estatus = 'ALTA'

  SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Almacen,'')))  AS Almacen,
                        LTRIM(RTRIM(ISNULL(DefAlmacen,''))) AS DefAlmacen
                    FROM @Tabla AS TMA
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
/************** spIntelisisWMSMonedasLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSMonedasLista') AND type = 'P') drop procedure dbo.spIntelisisWMSMonedasLista
GO
CREATE PROCEDURE spIntelisisWMSMonedasLista
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
  @Usuario                   varchar(20),
  @Agente                    varchar(10),
  @DefMoneda                 varchar(10)

DECLARE @Tabla Table(
  Moneda                    varchar(10),
  DefMoneda                 varchar(10)
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

  SET @Empresa        = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal       = CAST(ISNULL(@sSucursal,'0') AS int)
  SET @SucursalNombre = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))

  SELECT @Usuario = Usuario FROM IntelisisService WHERE ID = @ID
  SET @Usuario = LTRIM(RTRIM(ISNULL(@Usuario,'')))

  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario
  SET @Agente = LTRIM(RTRIM(ISNULL(@Agente,'')))

  SELECT @DefMoneda = DefMoneda FROM Usuario WHERE Usuario = @Usuario

  INSERT INTO @Tabla (Moneda, DefMoneda)
  SELECT Moneda, @DefMoneda
    FROM Mon

  SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Moneda,'')))  AS Moneda,
                        LTRIM(RTRIM(ISNULL(DefMoneda,''))) AS DefMoneda
                    FROM @Tabla AS TMA
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
/************** spIntelisisWMSGenerarInventarioFisico ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSGenerarInventarioFisico') AND type = 'P') drop procedure dbo.spIntelisisWMSGenerarInventarioFisico
GO
CREATE PROCEDURE spIntelisisWMSGenerarInventarioFisico
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
  @PosicionWMS               varchar(10),
  @FechaRequerida            datetime,
  @Vencimiento               datetime,
  @SucursalOrigen            int,
  @IdInv                     int

DECLARE @TablaPosicion table(
  PosicionWMS                varchar(10)
)

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

  IF ISNULL(@Agente,'') = ''
    SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario

  SET @FechaEmision   = @sFechaEmision
  SET @FechaEmision   = dbo.fnFechaSinHora(@FechaEmision)
  SET @FechaRequerida = @FechaEmision
  SET @Vencimiento    = @FechaEmision
  SET @SucursalOrigen = @Sucursal

  SET  @UltimoCambio             = GETDATE()
  SET  @Estatus                  = 'SINAFECTAR'
  SET  @Directo                  = 1
  SET  @AlmacenTransito          = '(TRANSITO)'

  INSERT INTO @TablaPosicion EXEC spRegresaPosicion 'INV', 'SALIDA', NULL, @Almacen, @Mov
  SELECT TOP 1 @PosicionWMS = PosicionWMS FROM @TablaPosicion

  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda

  INSERT INTO INV (Empresa, Mov, FechaEmision, UltimoCambio, Moneda, TipoCambio, Usuario, Observaciones, Estatus, Directo, Almacen, AlmacenTransito, FechaRequerida, Vencimiento, Sucursal, Agente, PosicionWMS, SucursalOrigen)
  VALUES (@Empresa, @Mov, @FechaEmision, @UltimoCambio, @Moneda, @TipoCambio, @Usuario, @Observaciones, @Estatus, @Directo, @Almacen, @AlmacenTransito, @FechaRequerida, @Vencimiento, @Sucursal, @Agente, @PosicionWMS, @SucursalOrigen)

  SET @IdInv = SCOPE_IDENTITY()

  INSERT INTO @Tabla (ModuloID, Mov, MovID, Estatus)
  SELECT ID, Mov, MovID, Estatus FROM INV WHERE ID = @IdInv

  SELECT @Texto = (SELECT CAST(ISNULL(ModuloID,0) AS varchar) AS ModuloID,
                        LTRIM(RTRIM(ISNULL(Mov,'')))          AS Mov,
                        LTRIM(RTRIM(ISNULL(MovID,'')))        AS MovID,
                        LTRIM(RTRIM(ISNULL(Estatus,'')))      AS Estatus
                    FROM @Tabla AS TMA
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
/************** spIntelisisWMSMovimientosRecoleccionLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSMovimientosRecoleccionLista') AND type = 'P') drop procedure dbo.spIntelisisWMSMovimientosRecoleccionLista
GO
CREATE PROCEDURE spIntelisisWMSMovimientosRecoleccionLista
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
  @Almacen                   varchar(10),
  @Sucursal                  int,
  @SucursalNombre            varchar(100),
  @Usuario                   varchar(20),
  @Agente                    varchar(10)

DECLARE @Tabla Table(
  ID                         int,
  Mov                        varchar(20),
  MovID                      varchar(20),
  Movimiento                 varchar(40)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @SucursalNombre = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SucursalNombre'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SET @Empresa         = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @SucursalNombre  = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))
  SET @Almacen         = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Usuario         = LTRIM(RTRIM(ISNULL(@Usuario,'')))

  SELECT TOP 1 @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @SucursalNombre
  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario

  IF LTRIM(RTRIM(ISNULL(@Almacen,'')))= ''
    BEGIN
      SELECT @Almacen = LTRIM(RTRIM(ISNULL(DefAlmacen,''))) From Usuario WHERE Usuario = @Usuario
      SET @Almacen = LTRIM(RTRIM(ISNULL(@Almacen,'')))
    END

  INSERT INTO @Tabla(Mov, MovID, Movimiento)
  SELECT DISTINCT t.Origen, t.OrigenID, LTRIM(RTRIM(ISNULL(t.Origen,''))) + ' ' + LTRIM(RTRIM(ISNULL(t.OrigenID,'')))
    FROM TMA t
    JOIN MovTipo m ON (t.Mov = m.Mov AND m.Modulo = 'TMA')
   WHERE t.Empresa = @Empresa
     AND t.Sucursal = @Sucursal
     AND t.Agente = @Agente
     AND m.Clave = 'TMA.TSUR'
     AND m.SubClave = 'TMA.TSURP'
     AND t.Estatus = 'PROCESAR'
     AND ISNULL(t.Empacado,0) = 0

  UPDATE @Tabla
     SET ID = ISNULL(b.ID, '0')
    FROM @Tabla a
    JOIN TMA b ON(a.Mov = b.Mov AND a.MovID = b.MovID)

  SELECT @Texto = (SELECT CAST(ISNULL(ID,0) AS varchar) AS ID,
                          ISNULL(Mov,'')                AS Mov,
                          ISNULL(MovID,'')              AS MovID,
                          ISNULL(Movimiento,'')         AS Movimiento
                     FROM @Tabla AS TMA
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
/************** spIntelisisWMSTarimasRecoleccionLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSTarimasRecoleccionLista') AND type = 'P') drop procedure dbo.spIntelisisWMSTarimasRecoleccionLista
GO
CREATE PROCEDURE spIntelisisWMSTarimasRecoleccionLista
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
  @Almacen                   varchar(10),
  @Sucursal                  int,
  @SucursalNombre            varchar(100),
  @Usuario                   varchar(20),
  @Agente                    varchar(10),
  @Origen                    varchar(20),
  @OrigenID                  varchar(20)

DECLARE @Tabla Table(
  Empresa                    varchar(5),
  Almacen                    varchar(10),
  ModuloID                   int,
  Mov                        varchar(20),
  MovID                      varchar(20),
  Movimiento                 varchar(40),
  Tarima                     varchar(20),
  Articulo                   varchar(20),
  Cantidad                   float,
  TarimaCierre               varchar(20),
  PosicionDestino            varchar(10),
  DescripcionPosicionDestino varchar(100),
  Fecha                      datetime,
  Referencia                 varchar(50),
  Observaciones              varchar(100)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @SucursalNombre = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SucursalNombre'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SELECT @Origen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Origen'

  SELECT @OrigenID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'OrigenID'

  SET @Empresa        = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @SucursalNombre = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))
  SET @Almacen        = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Usuario        = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  SET @Origen         = LTRIM(RTRIM(ISNULL(@Origen,'')))
  SET @OrigenID       = LTRIM(RTRIM(ISNULL(@OrigenID,'')))

  SELECT TOP 1 @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @SucursalNombre
  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario

  IF LTRIM(RTRIM(ISNULL(@Almacen,'')))= ''
    BEGIN
      SELECT @Almacen = LTRIM(RTRIM(ISNULL(DefAlmacen,''))) From Usuario WHERE Usuario = @Usuario
      SET @Almacen = LTRIM(RTRIM(ISNULL(@Almacen,'')))
    END

  INSERT INTO @Tabla(ModuloID, Mov, MovId, Fecha, Referencia, Observaciones, TarimaCierre)
  SELECT t.ID, t.Mov, t.MovID, t.FechaEmision, t.Referencia, t.Observaciones, t.TarimaSurtido
    FROM TMA t
    JOIN MovTipo m ON (t.Mov = m.Mov AND m.Modulo = 'TMA')
   WHERE t.Empresa = @Empresa
     AND t.Sucursal = @Sucursal
     AND t.Agente = @Agente
     AND t.Origen = @Origen
     AND t.OrigenID = @OrigenID
     AND m.Clave = 'TMA.TSUR'
     AND m.SubClave = 'TMA.TSURP'
     AND t.Estatus = 'PROCESAR'
     AND ISNULL(t.Empacado,0) = 0

  UPDATE @Tabla
     SET Empresa = @Empresa,
         Almacen = @Almacen,
         Movimiento = LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,'')))

  UPDATE @Tabla
     SET Tarima = ISNULL(b.Tarima, ''),
         Articulo = b.Articulo,
         Cantidad = b.CantidadPicking,
         PosicionDestino = b.PosicionDestino
    FROM @Tabla a
    JOIN TMAD b ON(a.ModuloID = b.ID)

  UPDATE @Tabla
     SET DescripcionPosicionDestino = b.Descripcion
    FROM @Tabla a
    JOIN AlmPos b ON (a.Almacen = b.Almacen AND a.PosicionDestino = b.Posicion)

  SELECT @Texto = (SELECT CAST(ISNULL(ModuloID,0) AS varchar)                AS ModuloID,
                          ISNULL(Mov,'')                                     AS Mov,
                          ISNULL(MovID,'')                                   AS MovID,
                          ISNULL(Movimiento,'')                              AS Movimiento,
                          ISNULL(Tarima,'')                                  AS Tarima,
                          ISNULL(Articulo,'')                                AS Articulo,
                          CAST(ISNULL(Cantidad,0) AS varchar)                AS Cantidad,
                          ISNULL(TarimaCierre,'')                            AS TarimaCierre,
                          ISNULL(PosicionDestino,'')                         AS PosicionDestino,
                          ISNULL(DescripcionPosicionDestino,'')              AS DescripcionPosicionDestino,
                          CONVERT(varchar(11), ISNULL(Fecha,'20150101'),113) AS Fecha,
                          ISNULL(Referencia,'')                              AS Referencia,
                          ISNULL(Observaciones,'')                           AS Observaciones
                     FROM @Tabla AS TMA
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
/************** spIntelisisWMSCerrarRecoleccion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSCerrarRecoleccion') AND type = 'P') drop procedure dbo.spIntelisisWMSCerrarRecoleccion
GO
CREATE PROCEDURE spIntelisisWMSCerrarRecoleccion
    @ID                 int,
    @iSolicitud         int,
    @Version            float,
    @Resultado          varchar(max) = NULL OUTPUT,
    @Ok                 int = NULL OUTPUT,
    @OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE
  @Texto                xml,
  @ReferenciaIS         varchar(100),
  @SubReferencia        varchar(100),
  @Empresa              varchar(5),
  @ListaMovimientos     varchar(max),
  @Numero               varchar(20),
  @Usuario              varchar(10),
  @Sucursal             int,
  @sSucursal            varchar(20),
  @SucursalNombre       varchar(20),
  @Paquete              varchar(20),
  @IDOrigen             int,
  @IDDestino            int,
  @Articulo             varchar(20),
  @Subcuenta            varchar(50),
  @Cantidad             float,
  @Tarima               varchar(20),
  @TarimaSurtido        varchar(20),
  @Posicion             varchar(10),
  @PosicionDestino      varchar(10),
  @Fecha                datetime,
  @Origen               varchar(20),
  @OrigenID             varchar(20),
  @Msg                  varchar(300),
  @Delimitador          char(1),
  @Inicio               int,
  @Fin                  int,
  @idx                  int,
  @Maximo               int,
  @MaxIdx               int

DECLARE @TablaPaquete table (
  Paquete               varchar(20),
  IDOrigen              int,
  IDDestino             int,
  Articulo              varchar(20),
  Subcuenta             varchar(50),
  Cantidad              float,
  Tarima                varchar(20),
  TarimaSurtido         varchar(20),
  Posicion              varchar(10),
  PosicionDestino       varchar(10),
  Sucursal              int,
  Usuario               varchar(10),
  Fecha                 datetime
)

DECLARE @Tabla table (
  Msg                   varchar(300)
)

BEGIN TRY
  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @sSucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @SucursalNombre = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SucursalNombre'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SELECT @IDOrigen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'IDOrigen'

   SELECT @Origen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Origen'

   SELECT @OrigenID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'OrigenID'

  SELECT @ListaMovimientos = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ListaMovimientos'

  SET @Empresa         = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @SucursalNombre  = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))
  SET @Usuario         = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  SET @ListaMovimientos = LTRIM(RTRIM(ISNULL(@ListaMovimientos,'')))

  IF ISNUMERIC(@sSucursal) = 1 SET @Sucursal = CAST(@sSucursal AS int)
  SET @Fecha = GETDATE()

  EXEC spConsecutivo 'WMSPaquete', @Sucursal, @Paquete OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  IF ISNULL(@OK, 0) = 0
    BEGIN

      SET @Delimitador = '~'
      SET @Maximo = 1000
      SET @idx = 0

      SET @Inicio = 1
      SET @Fin = CHARINDEX(@Delimitador, @ListaMovimientos)

      WHILE (@Inicio < (LEN(@ListaMovimientos) + 1)) AND (@idx < @Maximo)
        BEGIN
          -- >
          SET @idx = @idx + 1

          IF @Fin = 0 SET @Fin = (LEN(@ListaMovimientos) + 1)

          INSERT INTO @TablaPaquete (Paquete, IDOrigen, IDDestino, Sucursal, Usuario, Fecha)
          VALUES(@Paquete, @IDOrigen, SUBSTRING(@ListaMovimientos, @Inicio, (@Fin - @Inicio)), @Sucursal, @Usuario, @Fecha)

          SET @Inicio = (@Fin + 1)
          SET @Fin = CHARINDEX(@Delimitador, @ListaMovimientos, @Inicio)
        END

      UPDATE @TablaPaquete
         SET Articulo        = b.Articulo,
             Subcuenta       = b.SubCuenta,
             Cantidad        = b.CantidadPicking,
             Tarima          = b.Tarima,
             TarimaSurtido   = c.TarimaSurtido,
             Posicion        = b.Posicion,
             PosicionDestino = b.PosicionDestino
        FROM @TablaPaquete a
        JOIN TMAD b ON (a.IDDestino = b.ID)
        JOIN TMA c ON (a.IDOrigen = c.ID)

      UPDATE TMA
         SET Empacado = 1
        FROM TMA a
        JOIN @TablaPaquete b ON (a.ID = b.IDDestino)

      INSERT INTO WMSPaquete (Paquete, IDOrigen, IDDestino, Articulo, Subcuenta, Cantidad, Tarima, TarimaSurtido, Posicion, PosicionDestino, Sucursal, Usuario, Fecha)
      SELECT Paquete, IDOrigen, IDDestino, Articulo, Subcuenta, Cantidad, Tarima, TarimaSurtido, Posicion, PosicionDestino, Sucursal, Usuario, Fecha
        FROM @TablaPaquete

      SET @Msg = 'Paquete ' + @Paquete + ' registrado con éxito.'
      INSERT INTO @Tabla(Msg) VALUES(@Msg)
    END
  ELSE
   BEGIN
      SET @Msg = LTRIM(RTRIM(ISNULL(@OkRef,'')))
      INSERT INTO @Tabla(Msg) VALUES(@Msg)
   END

  SELECT @Texto = (SELECT ISNULL(Msg,'') AS Msg FROM @Tabla AS TMA FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSRecoleccionLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSRecoleccionLista') AND type = 'P') drop procedure dbo.spIntelisisWMSRecoleccionLista
GO
CREATE PROCEDURE spIntelisisWMSRecoleccionLista
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
  @Usuario                   varchar(20),
  @FechaHoy                  datetime,
  @Cuantos                   int,
  @Dias                      int,
  @Fecha                     datetime

DECLARE @Tabla Table(
  Paquete                    varchar(20),
  IDOrigen                   int,
  OrigenTipo                 varchar(10),
  Origen                     varchar(20),
  OrigenID                   varchar(20),
  MovOrigen                  varchar(50),
  TarimaSurtido              varchar(20),
  dtFecha                    datetime,
  sFecha                     varchar(12)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Usuario = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  
  SET @FechaHoy = dbo.fnFechaSinHora(getdate())
  SET @Cuantos  = 50
  SET @Dias     = 15
  SET @Fecha    = dateadd(day, (@dias * (-1)), @fechaHoy) 

  INSERT INTO @Tabla(Paquete, IDorigen, TarimaSurtido, dtFecha)
  SELECT TOP (@Cuantos) Paquete, IDorigen, TarimaSurtido, Fecha 
    FROM WMSPaquete
   WHERE Usuario = @Usuario
     AND Fecha > @Fecha
   GROUP BY Paquete, IDorigen, TarimaSurtido, Fecha 

  UPDATE @Tabla
     SET OrigenTipo = LTRIM(RTRIM(ISNULL(b.OrigenTipo,''))),
         Origen     = LTRIM(RTRIM(ISNULL(b.Origen,''))),
         OrigenID   = LTRIM(RTRIM(ISNULL(b.OrigenID,'')))
    FROM @Tabla a
    JOIN TMA b ON(a.IDOrigen = b.ID)

  UPDATE @Tabla 
     SET MovOrigen = Origen + ' ' + OrigenID,
         sFecha = CONVERT(varchar(20), dtFecha, 103)

  SELECT @Texto = (SELECT ISNULL(Tabla.Paquete,'')                  AS Paquete,
                          CAST(ISNULL(Tabla.IDOrigen,0) AS varchar) AS IDOrigen,
                          ISNULL(Tabla.OrigenTipo,'')               AS OrigenTipo,
                          ISNULL(Tabla.Origen,'')                   AS Origen,
                          CAST(ISNULL(Tabla.OrigenID,0) AS varchar) AS OrigenID,
                          ISNULL(Tabla.MovOrigen,'')                AS MovOrigen,
                          ISNULL(Tabla.TarimaSurtido,'')            AS TarimaSurtido,
                          ISNULL(Tabla.sFecha,'')                   AS Fecha
                     FROM @Tabla AS Tabla
                    ORDER BY Tabla.dtFecha DESC
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSRecoleccionImprimir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSRecoleccionImprimir') AND type = 'P') drop procedure dbo.spIntelisisWMSRecoleccionImprimir
GO
CREATE PROCEDURE spIntelisisWMSRecoleccionImprimir
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
  @Almacen                   varchar(10),
  @Sucursal                  int,
  @SucursalNombre            varchar(100),
  @Usuario                   varchar(20),
  @Agente                    varchar(10),
  @Paquete                   varchar(20),
  @Fecha                     varchar(20),
  @MovOrigen                 varchar(50),
  @Mov                       varchar(20),
  @MovID                     varchar(20),
  @Articulo                  varchar(20),
  @Subcuenta                 varchar(20),
  @Cantidad                  int,
  @Tarima                    varchar(20),
  @TarimaSurtido             varchar(20),
  @Posicion                  varchar(20),
  @PosicionDestino           varchar(20),
  @Linea                     varchar(255),
  @Interlinea                int,
  @xPos                      int,
  @yPos                      int

DECLARE @TablaPaquete table(
  idx                       int IDENTITY(1,1),
  Paquete                   varchar(20),
  IDOrigen                  int,
  IDDestino                 int,
  Articulo                  varchar(20),
  Subcuenta                 varchar(50),
  Cantidad                  float,
  Tarima                    varchar(20),
  TarimaSurtido             varchar(20),
  Posicion                  varchar(10),
  PosicionDestino           varchar(10),
  Sucursal                  int,
  Usuario                   varchar(10),
  Fecha                     datetime,
  Mov                       varchar(20),
  MovID                     varchar(20),
  OrigenTipo                varchar(10),
  Origen                    varchar(20),
  OrigenID                  varchar(20),
  Referencia                varchar(50),
  SucursalNombre            varchar(100),
  Almacen                   varchar(10),
  AlmacenNombre             varchar(100)
)

DECLARE @Tabla Table(
  idx                        int IDENTITY(1,1),
  Linea                      varchar(255)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SELECT @Paquete = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Paquete'

  SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Usuario = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  SET @Paquete = LTRIM(RTRIM(ISNULL(@Paquete,'')))

  SET @Interlinea = 30
  SET @xPos = 125
  SET @yPos = 60
    
  INSERT INTO @TablaPaquete (Paquete, IDOrigen, IDDestino, Articulo, Subcuenta, Cantidad, Tarima, TarimaSurtido, Posicion, PosicionDestino, Sucursal, Usuario, Fecha)
  SELECT Paquete, IDOrigen, IDDestino, Articulo, Subcuenta, Cantidad, Tarima, TarimaSurtido, Posicion, PosicionDestino, Sucursal, Usuario, Fecha
    FROM WMSPaquete
   WHERE Paquete = @Paquete
   ORDER BY IDDestino

  UPDATE @TablaPaquete
     SET Mov = b.Mov,
         MovID = b.MovID
    FROM @TablaPaquete a
    JOIN TMA b ON(a.IDDestino = b.ID)

  UPDATE @TablaPaquete
     SET OrigenTipo = b.OrigenTipo,
         Origen     = b.Origen,
         OrigenID   = b.OrigenID,
         Referencia = b.Referencia,
         Almacen    = b.Almacen
    FROM @TablaPaquete a
    JOIN TMA b ON(a.IDOrigen = b.ID)

  UPDATE @TablaPaquete
     SET SucursalNombre = b.Nombre
    FROM @TablaPaquete a
    JOIN Sucursal b ON(a.Sucursal = b.Sucursal)

  UPDATE @TablaPaquete
     SET AlmacenNombre = b.Nombre
    FROM @TablaPaquete a
    JOIN Alm b ON(a.Almacen = b.Almacen)

  -- CPCL
  SET @Linea = '! 0 200 200 200 1'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Título
  SET @yPos = @yPos + @Interlinea
  SET @Linea = 'TEXT 0 4 ' + CONVERT(varchar, @xPos) + ' ' + CONVERT(varchar, @yPos) + ' Paquete ' + @Paquete
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Fecha paquete
  SET @yPos = @yPos + (@Interlinea * 2)
  SELECT @Fecha = CONVERT(varchar,Fecha,126) FROM @TablaPaquete WHERE idx = 1
  SET @Fecha = REPLACE (@fecha,'T',' ')
  SET @Fecha = REPLACE (@fecha,'.','')
  SET @Fecha = LTRIM(RTRIM(ISNULL(@Fecha,'')))
  SET @Linea = 'TEXT 0 3 ' + CONVERT(varchar, @xPos) + ' ' + CONVERT(varchar, @yPos) + ' Fecha:  ' + @Fecha
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Movimiento origen
  SET @yPos = @yPos + @Interlinea
  SELECT @MovOrigen = Origen + ' '  + OrigenID FROM @TablaPaquete WHERE idx = 1
  SET @Linea = 'TEXT 0 3 ' + CONVERT(varchar, @xPos) + ' ' + CONVERT(varchar, @yPos) + ' Origen: ' + @MovOrigen
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Movimientos destino
  DECLARE crImprimirCPCL CURSOR FOR
    SELECT t.Mov, t.MovID, t.Articulo, t.Subcuenta, t.Cantidad, t.Tarima, t.TarimaSurtido, t.Posicion,t.PosicionDestino
      FROM @TablaPaquete t

  OPEN crImprimirCPCL
  FETCH NEXT FROM crImprimirCPCL INTO @Mov, @MovID, @Articulo, @Subcuenta, @Cantidad, @Tarima, @TarimaSurtido, @Posicion, @PosicionDestino
  WHILE @@FETCH_STATUS = 0
    BEGIN
      -- Titulo detalle
      SET @yPos = @yPos + (@Interlinea * 1.5)
      SET @Linea = 'TEXT 0 3 ' + CONVERT(varchar, @xPos) + ' ' + CONVERT(varchar, @yPos) + ' ' + @Mov + ' ' + @MovID
      INSERT INTO @Tabla (Linea) VALUES (@Linea)

      -- Subtítulos detalle
      SET @yPos = @yPos + @Interlinea
      SET @Linea = 'TEXT 0 2 ' + CONVERT(varchar, @xPos) + ' ' + CONVERT(varchar, @yPos) + ' ' + 'Articulo            Cantidad  Tarima              T. Surtido'
      INSERT INTO @Tabla (Linea) VALUES (@Linea)

      -- Detalle
      SET @yPos = @yPos + @Interlinea
      SET @Linea = 'TEXT 0 2 ' + CONVERT(varchar, @xPos) + ' ' + CONVERT(varchar, @yPos) + ' ' + @Articulo + SPACE(20 - LEN(@Articulo)) + CAST(@Cantidad AS varchar) + SPACE(10 - LEN(CAST(@Cantidad AS varchar))) + @Tarima +  + SPACE(20 - LEN(@Tarima)) + @TarimaSurtido
      INSERT INTO @Tabla (Linea) VALUES (@Linea)

      FETCH NEXT FROM crImprimirCPCL INTO @Mov, @MovID, @Articulo, @Subcuenta, @Cantidad, @Tarima, @TarimaSurtido, @Posicion, @PosicionDestino
    END
  CLOSE crImprimirCPCL
  DEALLOCATE crImprimirCPCL

  -- Fin de impresión
  SET @Linea = 'FORM'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = 'PRINT'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Longitud de impresión
  SET @yPos = @yPos + (@Interlinea * 2)
  SET @Linea = '! 0 200 200 ' + CONVERT(varchar, @yPos) + ' 1'

  UPDATE @Tabla SET Linea = @Linea WHERE idx = 1

  SELECT @Texto = (SELECT ISNULL(Tabla.Linea,'') AS Linea
                     FROM @Tabla AS Tabla
                    ORDER BY Tabla.idx
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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

/*
-- Pruebas
Set nocount on

Declare @Resultado Varchar(max),
        @Ok        int,
        @OkRef     varchar(255),
        @Id        int

Exec SpIntelisisService 'MTY4','DEMO','
<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.RecoleccionImprimir" SubReferencia="IntelisisMobile 1.0.2.7" Version="1.0">
  <Solicitud>
    <Parametro Campo="Empresa" Valor="DEMO" />
    <Parametro Campo="Usuario" Valor="MTY4" />
    <Parametro Campo="Paquete" Valor="P50" />
  </Solicitud>
</Intelisis>
',@Resultado output,@Ok Output,@OkRef Output,1,0,@Id Output,1

SELECT CAST(@Resultado AS XML) AS 'Resultado'
*/
GO

/************** spIntelisisWMSArticuloImprimir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSArticuloImprimir') AND type = 'P') drop procedure dbo.spIntelisisWMSArticuloImprimir
GO
CREATE PROCEDURE spIntelisisWMSArticuloImprimir
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
  @EmpresaNombre             varchar(100),
  @Almacen                   varchar(10),
  @Sucursal                  int,
  @SucursalNombre            varchar(100),
  @Usuario                   varchar(20),
  @Agente                    varchar(10),
  @OrigenTipo                varchar(50),
  @Origen                    varchar(20),
  @OrigenID                  varchar(20),
  @Articulo                  varchar(20),
  @ArtDescripcion            varchar(100),
  @Subcuenta                 varchar(20),
  @Tarima                    varchar(20),
  @TarimaSurtido             varchar(20),
  @Posicion                  varchar(20),
  @Cantidad                  varchar(20),
  @Unidad                    varchar(20),
  @PosicionDestino           varchar(20),
  @MovGenerado               varchar(20),
  @MovIDGenerado             varchar(20),
  @Fecha                     varchar(20),
  @Linea                     varchar(255)

DECLARE @Tabla Table(
  idx                        int IDENTITY(1,1),
  Linea                      varchar(255)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @SucursalNombre = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SucursalNombre'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SELECT @OrigenTipo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'OrigenTipo'

  SELECT @Origen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Origen'

  SELECT @OrigenID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'OrigenID'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'

  SELECT @Posicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'

  SELECT @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Cantidad'

  SELECT @Unidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Unidad'

  SELECT @PosicionDestino = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'PosicionDestino'

  SELECT @MovGenerado = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovGenerado'

  SELECT @MovIDGenerado = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovIDGenerado'

  SET @Empresa         = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @SucursalNombre  = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))
  SET @Usuario         = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  SET @OrigenTipo      = LTRIM(RTRIM(ISNULL(@OrigenTipo,'')))
  SET @Origen          = LTRIM(RTRIM(ISNULL(@Origen,'')))
  SET @OrigenID        = LTRIM(RTRIM(ISNULL(@OrigenID,'')))
  SET @Articulo        = LTRIM(RTRIM(ISNULL(@Articulo,'')))
  SET @Tarima          = LTRIM(RTRIM(ISNULL(@Tarima,'')))
  SET @Posicion        = LTRIM(RTRIM(ISNULL(@Posicion,'')))
  SET @Cantidad        = LTRIM(RTRIM(ISNULL(@Cantidad,'')))
  SET @Unidad          = LTRIM(RTRIM(ISNULL(@Unidad,'')))
  SET @PosicionDestino = LTRIM(RTRIM(ISNULL(@PosicionDestino,'')))
  SET @MovGenerado     = LTRIM(RTRIM(ISNULL(@MovGenerado,'')))
  SET @MovIDGenerado   = LTRIM(RTRIM(ISNULL(@MovIDGenerado,'')))

  SELECT @EmpresaNombre = LTRIM(RTRIM(ISNULL(Nombre,''))) FROM Empresa WHERE Empresa = @Empresa
  SELECT @ArtDescripcion = LTRIM(RTRIM(ISNULL(descripcion1,''))) FROM Art WHERE Articulo = @Articulo

  SET @Linea = '^XA'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Título
  SET @Linea = '^FWR'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FO600,75'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  --SET @Linea = '^A0,60,50'
  SET @Linea = '^A0,50,40'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FD' + @EmpresaNombre
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FS'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)


  -- Linea 1
  SET @Linea = '^CF0,40'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FO580,70'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^GB,700,5'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FS'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)


  -- Código de barras
  SET @Linea = '^FO350,80'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^BY4,3,200'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^BCR190'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FD' + @Articulo
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FS'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)


  -- Linea 2
  SET @Linea = '^CF0,40'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FO270,70'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^GB,700,5'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FS'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)


  -- Descripción del artículo
  SET @Linea = '^FWR'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FB650,3,0,C,0'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FO100,75'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  --SET @Linea = '^A0,50,40'
  SET @Linea = '^A0,40,30'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FD' + @ArtDescripcion
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FS'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Fin de impresión
  SET @Linea = '^XZ'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SELECT @Texto = (SELECT ISNULL(Tabla.Linea,'') AS Linea
                     FROM @Tabla AS Tabla
                    ORDER BY Tabla.idx
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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

/*
-- Pruebas
Set nocount on

Declare @Resultado Varchar(max),
        @Ok        int,
        @OkRef     varchar(255),
        @Id        int

Exec SpIntelisisService 'MTY4','DEMO','
<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.WMS.ArticuloImprimir" SubReferencia="IntelisisMobile 1.0.2.7" Version="1.0">
  <Solicitud>
    <Parametro Campo="Empresa" Valor="DEMO" />
    <Parametro Campo="SucursalNombre" Valor="Sucursal Monterrey" />
    <Parametro Campo="Usuario" Valor="MTY4" />
    <Parametro Campo="OrigenTipo" Valor="VTAS" />
    <Parametro Campo="Origen" Valor="Pedido" />
    <Parametro Campo="OrigenID" Valor="SM6" />
    <Parametro Campo="Articulo" Valor="0074" />
    <Parametro Campo="Tarima" Valor="T12177" />
    <Parametro Campo="Posicion" Valor="D74" />
    <Parametro Campo="Cantidad" Valor="2" />
    <Parametro Campo="Unidad" Valor="pza" />
    <Parametro Campo="PosicionDestino" Valor="PS-MONT" />
    <Parametro Campo="MovGenerado" Valor="Surtido Transito PCK" />
    <Parametro Campo="MovIDGenerado" Valor="SM34" />
  </Solicitud>
</Intelisis>
',@Resultado output,@Ok Output,@OkRef Output,1,0,@Id Output,1

SELECT CAST(@Resultado AS XML) AS 'Resultado'
*/
GO

/************** spIntelisisWMSPosicionTarimasLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSPosicionTarimasLista') AND type = 'P') drop procedure dbo.spIntelisisWMSPosicionTarimasLista
GO
CREATE PROCEDURE spIntelisisWMSPosicionTarimasLista
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
  @Usuario                   varchar(20),
  @Empresa                   varchar(5),
  @Sucursal                  int,
  @sSucursal                 varchar(20),
  @Almacen                   varchar(10),
  @Posicion                  varchar(10),
  @Tarima                    varchar(20),
  @Articulo                  varchar(20)

DECLARE @Tabla table(
  Tarima                     varchar(20),
  Existencia                 float,
  Disponible                 float,
  Apartado                   float
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @sSucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Posicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'

  SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SET @Empresa   = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @sSucursal = LTRIM(RTRIM(ISNULL(@sSucursal,'0')))
  SET @Almacen   = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Posicion  = LTRIM(RTRIM(ISNULL(@Posicion,'')))
  SET @Articulo  = LTRIM(RTRIM(ISNULL(@Articulo,'')))

  IF ISNUMERIC(@sSucursal) = 1
    SET @Sucursal = CAST(@sSucursal AS int)
  ELSE
    SET @Sucursal = 0

  SELECT @Usuario = Usuario FROM IntelisisService WHERE ID = @ID
  SET @Usuario = LTRIM(RTRIM(ISNULL(@Usuario,'')))

  IF LTRIM(RTRIM(ISNULL(@Almacen,''))) = ''
    BEGIN
      SELECT @Almacen = LTRIM(RTRIM(ISNULL(DefAlmacen,'')))
        FROM Usuario
       WHERE Usuario = @Usuario
       
      SET @Almacen = LTRIM(RTRIM(ISNULL(@Almacen,'')))
    END

  INSERT INTO @Tabla(Tarima, Existencia, Disponible, Apartado)
  SELECT t.Tarima,
         ISNULL(d.Disponible,0) + ISNULL(d.Apartado,0),
         ISNULL(d.Disponible,0),
         ISNULL(d.Apartado,0)
    FROM Tarima t
    JOIN AlmPos a ON (t.Posicion = a.Posicion)
    JOIN ArtDisponibleTarima d ON (t.Tarima = d.Tarima)
   WHERE d.Empresa  = @Empresa
     AND d.Almacen  = @Almacen
     AND d.Articulo = @Articulo
     AND t.Posicion = @Posicion
     AND t.Estatus  = 'ALTA'
     AND t.Tarima <> @Tarima

  SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Tarima,'')))       AS Tarima,
                          CAST(ISNULL(Existencia,0) AS varchar) AS Existencia,
                          CAST(ISNULL(Disponible,0) AS varchar) AS Disponible,
                          CAST(ISNULL(Apartado,0) AS varchar)   AS Apartado
                     FROM @Tabla AS TMA
                    ORDER BY Tarima
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSInventarioLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInventarioLista') AND type = 'P') drop procedure dbo.spIntelisisWMSInventarioLista
GO
CREATE PROCEDURE spIntelisisWMSInventarioLista
  @ID                   int,
  @iSolicitud           int,
  @Version              float,
  @Resultado            varchar(max) = NULL OUTPUT,
  @Ok                   int = NULL OUTPUT,
  @OkRef                varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ReferenciaIS       varchar(100),
    @SubReferencia      varchar(100),
    @Empresa            varchar(5),
    @Sucursal           int,
    @Usuario            varchar(10),
    @Agente             varchar(10),
    @Clave              varchar(20),
    @Texto              xml

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Clave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Clave'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario

  IF EXISTS(SELECT TOP 1 Agente FROM Agente WHERE Agente = @Agente)
    BEGIN
       DECLARE @TablaALm Table(
        Sucursal                  int,
        Almacen                   varchar(100)
      )

      DECLARE @Tabla Table(
        ID                        int,
        Movimiento                varchar(20),
        FechaEmision              datetime,
        Almacen                   varchar(100)
      )

      INSERT INTO @TablaALm(Sucursal, Almacen)
      SELECT @Sucursal, Almacen
        FROM Alm
       WHERE Sucursal = @Sucursal
         AND WMS = 1

      INSERT INTO @Tabla(ID, Movimiento, FechaEmision, Almacen)
      SELECT i.ID, i.Mov, i.FechaEmision, i.Almacen
        FROM Inv i
        JOIN MovTipo mt ON(i.Mov = mt.mov AND mt.Modulo = 'INV')
        JOIN @TablaALm t ON (i.almacen = t.Almacen)
       WHERE i.agente = @Agente
         AND mt.Clave = @Clave
         AND i.Estatus = 'SINAFECTAR'

      SELECT @Texto = (SELECT CAST(ISNULL(ID,0) AS varchar)                             AS ID,
                              ISNULL(Movimiento,'')                                     AS Movimiento,
                              CONVERT(varchar(11), ISNULL(FechaEmision,'19000101'),113) AS FechaEmision,
                              ISNULL(Almacen,'')                                        AS Almacen
                         FROM @Tabla AS TMA
                          FOR XML AUTO)

    END
  ELSE
    BEGIN
      SET @Ok = 26090
    END

  SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
/************** spIntelisisWMSMovimientosInvLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSMovimientosInvLista') AND type = 'P') drop procedure dbo.spIntelisisWMSMovimientosInvLista
GO
CREATE PROCEDURE spIntelisisWMSMovimientosInvLista
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
  @Modulo                    varchar(5),
  @Clave                     varchar(20)

DECLARE @Tabla Table(
  Movimiento                 varchar(20),
  Clave                      varchar(20),
  SubClave                   varchar(20)
)

BEGIN TRY
  SELECT @Modulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Modulo'

  SELECT @Clave = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Clave'
 
  SET @Modulo = LTRIM(RTRIM(ISNULL(@Modulo,'')))
  SET @Clave  = LTRIM(RTRIM(ISNULL(@Clave,'')))

  INSERT INTO @Tabla (Movimiento, Clave, SubClave)
  SELECT Mov, Clave, SubClave
    FROM MovTipo
   WHERE Modulo = @Modulo
     AND Clave = @Clave
   ORDER BY Orden 

  SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Movimiento,'')))  AS Movimiento,
                          LTRIM(RTRIM(ISNULL(Clave,'')))       AS Clave,
                          LTRIM(RTRIM(ISNULL(SubClave,'')))    AS SubClave
                     FROM @Tabla AS TMA
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
/************** spIntelisisWMSGuardarInventario ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSGuardarInventario') AND type = 'P') drop procedure dbo.spIntelisisWMSGuardarInventario
GO
CREATE PROCEDURE spIntelisisWMSGuardarInventario
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
    @Sucursal                int,
    @Usuario                 varchar(10),
    @xml                     xml

  DECLARE
    @Renglon                 float,
    @RenglonSub              int,
    @RenglonID               int,
    @RenglonTipo	           char(1),

    @Cantidad                float,
    @CantidadInventario      float,
    @Almacen                 varchar(10),
    @Factor                  float,

    @Posicion                varchar(10),
    @Tarima                  varchar(20) 
   
  DECLARE
    @InventarioID            int,
    @FechaRequerida          datetime,
    @Proveedor               varchar(10),
    @Articulo                varchar(20),
    @SubCuenta               varchar(50),
    @Unidad                  varchar(50),
    @Codigo                  varchar(30),
    @TipoCosteo              varchar(10),
    @MonedaCosto             varchar(10),
    @TipoCambio              float,
    @Costo                   money,
    @idx                     int,
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
    Subcuenta                varchar(20),
    Costo                    money,
    FechaRequerida           datetime,
    Unidad                   varchar(50),
    Factor                   float,
    Posicion                 varchar(10),
    Tarima                   varchar(20)
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

  SELECT @InventarioID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'InventarioID'

  SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal = LTRIM(RTRIM(ISNULL(@Sucursal,0)))
  SET @Usuario  = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  SET @InventarioID  = LTRIM(RTRIM(ISNULL(@InventarioID,0)))

  SET @Proveedor = NULL
  SET @SubCuenta = NULL

  INSERT INTO @TablaInvD (ID, Renglon, RenglonSub, RenglonID, Cantidad, Almacen, Articulo, Codigo, SubCuenta, Unidad, Factor, Posicion, Tarima)
  SELECT ID, Renglon, RenglonSub, RenglonID, Cantidad, Almacen, Articulo, Codigo, Subcuenta, Unidad, Factor, Posicion, Tarima
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
          Unidad      varchar (50)  '@Unidad',
          Factor      float         '@Factor',
          Posicion    varchar (10)  '@Posicion',
          Tarima      varchar (20)  '@Tarima');

  DECLARE TablaInvD_cursor CURSOR FOR SELECT IDX, Renglon, RenglonSub, RenglonID, Cantidad, Factor, Posicion, Tarima FROM @TablaInvD
  OPEN TablaInvD_cursor
  FETCH NEXT FROM TablaInvD_cursor INTO @idx, @Renglon, @RenglonSub, @RenglonID, @Cantidad, @Factor, @Posicion, @Tarima
  WHILE @@FETCH_STATUS = 0
    BEGIN
      IF ISNULL(@Factor,0) = 0 SET @Factor = 1

      IF @Renglon > 0
        BEGIN
          UPDATE InvD 
             SET Cantidad = ISNULL(@Cantidad,0),
                 CantidadInventario = ISNULL(@Cantidad,0) * ISNULL(@Factor,1)
           WHERE ID = @InventarioID
             AND Renglon = @Renglon
             AND RenglonSub = @RenglonSub
             AND RenglonID = @RenglonID
        END
      ELSE
        BEGIN

          SELECT @Articulo  = Articulo,
                 @SubCuenta = Subcuenta
            FROM @TablaInvD
           WHERE IDX = @idx

          SELECT @Unidad      = UnidadTraspaso,
                 @TipoCosteo  = TipoCosteo,
                 @MonedaCosto = MonedaCosto,
                 @RenglonTipo = UPPER(LEFT(Tipo,1))
            FROM Art
           WHERE Articulo = @Articulo 

           SELECT @Factor = Factor
           FROM ArtUnidad 
           WHERE Articulo = @Articulo
           AND Unidad = @Unidad

           SET @Factor = ISNULL(@Factor,1)

           SELECT @TipoCambio = TipoCambio
            FROM Mon
           WHERE Moneda = @MonedaCosto

           EXEC spVerCosto @sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @MonedaCosto, @TipoCambio, @Costo OUTPUT, 0
         
           --SELECT @Renglon = Max(Renglon) FROM @TablaInvD
           SELECT @Renglon = Max(Renglon) FROM InvD WHERE ID = @InventarioID
           SET @Renglon = ISNULL(@Renglon,0) + 2048

           SET @RenglonSub = ISNULL(@RenglonSub,0) 

           --SELECT @RenglonID = MAX(RenglonID) FROM @TablaInvD 
           SELECT @RenglonID = MAX(RenglonID) FROM InvD WHERE ID = @InventarioID
           SET @RenglonID = ISNULL(@RenglonID,0) + 1

           --UPDATE @TablaInvD 
           --   SET Renglon = @Renglon,
           --       RenglonSub = @RenglonSub,
           --       RenglonID = @RenglonID,
           --       Costo = @Costo 
           -- WHERE IDX = @idx

            SELECT @FechaRequerida = Fechaemision,
                   @Almacen = Almacen 
              FROM Inv 
             WHERE ID = @InventarioID

            SET @CantidadInventario = ISNULL(@Cantidad,0) * ISNULL(@Factor,1)

            INSERT INTO InvD (ID, Renglon, RenglonSub, RenglonID, Cantidad, Codigo, Almacen, Articulo, Costo, FechaRequerida, Unidad, Factor, CantidadInventario, Sucursal, SucursalOrigen, RenglonTipo, Tarima, PosicionActual, PosicionReal)
            VALUES (@InventarioID, @Renglon, @RenglonSub, @RenglonID, @Cantidad, @Codigo, @Almacen, @Articulo, @Costo, @FechaRequerida, @Unidad, @Factor, @CantidadInventario, @Sucursal, @Sucursal , @RenglonTipo, @Tarima, @Posicion, @Posicion)

        END

      FETCH NEXT FROM TablaInvD_cursor INTO @idx, @Renglon, @RenglonSub, @RenglonID, @Cantidad, @Factor, @Posicion, @Tarima
    END
  CLOSE TablaInvD_cursor
  DEALLOCATE TablaInvD_cursor

  SELECT @idx = MAX(IDX) FROM @TablaInvD

  INSERT INTO @Tabla (Mensaje) VALUES (CAST(ISNULL(@idx,0) AS varchar) + ' registros actualizados.')
   
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
/************** spIntelisisWMSGuardarSerieLoteMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSGuardarSerieLoteMov') AND type = 'P') drop procedure dbo.spIntelisisWMSGuardarSerieLoteMov
GO
CREATE PROCEDURE spIntelisisWMSGuardarSerieLoteMov
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
    @Sucursal                int,
    @Usuario                 varchar(10),
    @xml                     xml

  DECLARE
    @Modulo                  varchar(5),
    @ModuloID                int,
    @RenglonID               int,
    @Articulo                varchar(20),
    @SubCuenta               varchar(50),
    @SerieLote               varchar(50),
    @Cantidad                float,
    @Propiedades             varchar(20),
    @Tarima                  varchar(20),
    @idx                     int 

  DECLARE @TablaSerieLoteMov table(
    IDX                      int identity (1,1),
    Empresa                  varchar(5),
    Modulo                   varchar(5),
    ModuloID                 int,
    RenglonID                int,
    Articulo                 varchar(20),
    Subcuenta                varchar(50),
    SerieLote                varchar(50),
    Cantidad                 float,
    Propiedades              varchar(20),
    Sucursal                 int,
    Tarima                   varchar(20)
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

  INSERT INTO @TablaSerieLoteMov (Empresa, Modulo, ModuloID, RenglonID, Articulo, Subcuenta, SerieLote, Cantidad, Propiedades, Sucursal, Tarima)
  SELECT Empresa, Modulo, ModuloID, RenglonID, Articulo, Subcuenta, SerieLote, Cantidad, Propiedades, Sucursal, Tarima
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
          Sucursal    int          '@Sucursal',
          Tarima      varchar (20) '@Tarima'
          );

  ---- DEBUG --------------------------------------
  --select * from @TablaSerieLoteMov
  ---------------------------------------------------

  DECLARE TablaSerieLoteMov_cursor CURSOR FOR SELECT IDX, Empresa, Modulo, ModuloID, RenglonID, Articulo, Subcuenta, SerieLote, Cantidad, Propiedades, Sucursal, Tarima FROM @TablaSerieLoteMov
  OPEN TablaSerieLoteMov_cursor
  FETCH NEXT FROM TablaSerieLoteMov_cursor INTO @idx, @Empresa, @Modulo, @ModuloID, @RenglonID, @Articulo, @Subcuenta, @SerieLote, @Cantidad, @Propiedades, @Sucursal, @Tarima
  WHILE @@FETCH_STATUS = 0
    BEGIN
      ---- DEBUG --------------------------------------
      --SELECT @idx           AS idx, 
      --       @Empresa       AS Empresa, 
      --       @Modulo        AS Modulo, 
      --       @ModuloID      AS ModuloID,  
      --       @RenglonID     AS RenglonID, 
      --       @Articulo      AS Articulo, 
      --       @Subcuenta     AS Subcuenta, 
      --       @SerieLote     AS SerieLote, 
      --       @Cantidad      AS Cantidad, 
      --       @Propiedades   AS Propiedades, 
      --       @Sucursal      AS Sucursal, 
      --       @Tarima        AS Tarima      
      ---------------------------------------------------
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
                     Sucursal    = @Sucursal,
                     Tarima      = @Tarima
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
              INSERT INTO SerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, Subcuenta, SerieLote, Cantidad, Propiedades, Sucursal, Tarima)
              VALUES (@Empresa, @Modulo, @ModuloID, @RenglonID, @Articulo, @Subcuenta, @SerieLote, @Cantidad, @Propiedades, @Sucursal, @Tarima)
            END
        END

      FETCH NEXT FROM TablaSerieLoteMov_cursor INTO @idx, @Empresa, @Modulo, @ModuloID, @RenglonID, @Articulo, @Subcuenta, @SerieLote, @Cantidad, @Propiedades, @Sucursal, @Tarima
    END
  CLOSE TablaSerieLoteMov_cursor
  DEALLOCATE TablaSerieLoteMov_cursor

  SELECT @idx = MAX(IDX) FROM @TablaSerieLoteMov
  INSERT INTO @Tabla (Mensaje) VALUES (CAST(ISNULL(@idx,0) AS varchar) + ' registros actualizados.')
   
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
/************** spIntelisisWMSInfoTarimaArticulo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoTarimaArticulo') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoTarimaArticulo
GO
CREATE PROCEDURE spIntelisisWMSInfoTarimaArticulo
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
  @Posicion                  varchar(20),
  @Tarima                    varchar(20),
  @Articulo                  varchar(20),
  @SubCuenta                 varchar(50)

DECLARE @Tabla Table(
  Articulo                   varchar(20),
  ArticuloDescripcion        varchar(100),
  SubCuenta                  varchar(50),
  Tipo                       varchar(20),
  UnidadVenta                varchar(50),
  UnidadCompra               varchar(50),
  UnidadTraspaso             varchar(50),
  Factor                     float,
  Tarima                     varchar(20),
  EstatusControlCalidad      varchar(50),
  TarimaEstatus              varchar(15)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Sucursal'

  SELECT @Posicion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Posicion'

  SELECT @Tarima = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Tarima'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SELECT @SubCuenta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SubCuenta'

  SET @Empresa   = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal  = CAST(ISNULL(@Sucursal,'0') AS int)
  SET @Posicion  = LTRIM(RTRIM(ISNULL(@Posicion,'')))
  SET @Tarima    = LTRIM(RTRIM(ISNULL(@Tarima,'')))
  SET @Articulo  = LTRIM(RTRIM(ISNULL(@Articulo,'')))
  SET @SubCuenta = LTRIM(RTRIM(ISNULL(@SubCuenta,'')))

  IF NOT EXISTS (SELECT TOP 1 Tarima FROM Tarima WHERE Tarima = @Tarima)
    BEGIN
      SET @Ok = 1
      SET @OkRef = 'La tarima ' + @Tarima + ' no existe.'
    END

  IF ISNULL(@ok,0) = 0 AND NOT EXISTS (SELECT TOP 1 Articulo FROM Art WHERE Articulo = @Articulo)
    BEGIN
        SET @Ok = 1
        SET @OkRef = 'El artículo ' + @Articulo + ' no existe.'
      END
 
  IF ISNULL(@ok,0) = 0
    BEGIN
      INSERT INTO @Tabla(Articulo, ArticuloDescripcion, SubCuenta, Tipo, UnidadVenta, UnidadCompra, UnidadTraspaso, Tarima)
      SELECT Articulo, Descripcion1, @SubCuenta, Tipo, Unidad, UnidadCompra, ISNULL(UnidadTraspaso,'pza'), @Tarima 
        FROM Art 
       WHERE Articulo = @Articulo
    
      UPDATE @Tabla
         SET Factor = b.Factor
        FROM @Tabla a
        JOIN ArtUnidad b ON (a.Articulo = b.Articulo AND a.UnidadTraspaso = b.Unidad)
    
      UPDATE @Tabla
         SET TarimaEstatus = b.Estatus,
             EstatusControlCalidad = b.EstatusControlCalidad
        FROM @Tabla a
        JOIN Tarima b ON (a.Tarima = b.Tarima)
    END

  SELECT @Texto = (SELECT LTRIM(RTRIM(ISNULL(Articulo,'')))              AS Articulo,
                          LTRIM(RTRIM(ISNULL(ArticuloDescripcion,'')))   AS ArticuloDescripcion,
                          LTRIM(RTRIM(ISNULL(SubCuenta,'')))             AS SubCuenta,
                          LTRIM(RTRIM(ISNULL(Tipo,'')))                  AS Tipo,
                          LTRIM(RTRIM(ISNULL(UnidadVenta,'')))           AS UnidadVenta,
                          LTRIM(RTRIM(ISNULL(UnidadCompra,'')))          AS UnidadCompra,
                          LTRIM(RTRIM(ISNULL(UnidadTraspaso,'')))        AS UnidadTraspaso,
                          CAST(ISNULL(Factor,0) AS varchar)              AS Factor,
                          LTRIM(RTRIM(ISNULL(EstatusControlCalidad,''))) AS EstatusControlCalidad,
                          LTRIM(RTRIM(ISNULL(TarimaEstatus,'')))         AS TarimaEstatus
                     FROM @Tabla AS TMA
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
/************** spIntelisisWMSInfoOrdenCompraImprimir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoOrdenCompraImprimirCPLC')           AND type = 'P') drop procedure dbo.spIntelisisWMSInfoOrdenCompraImprimirCPLC
GO
CREATE PROCEDURE spIntelisisWMSInfoOrdenCompraImprimirCPLC
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
  @Mov                       varchar(20),
  @MovID                     varchar(20),
  @Articulo                  varchar(20),
  @Cantidad                  float,
  @Descripcion1              varchar(100),
  @Unidad                    varchar(50),
  @Texto                     xml,
  @ReferenciaIS              varchar(100),
  @SubReferencia             varchar(100),
  @DescripcionTexto          char(29),
  @CantidadTexto             char(8),
  @UnidadTexto               char(6),
  @PosY                      int,
  @Linea                     varchar(255),
  @AnchoDescripcion          int,
  @AnchoCantidad             int,
  @AnchoUnidad               int,
  @Interlineado              int

  -- Pruebas
  --DECLARE @i int
  
  DECLARE @Tabla Table(
    idx                      int IDENTITY(1,1),
    Linea                    varchar(255)
  )

  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  IF @OK IS NULL
  BEGIN
    IF NOT EXISTS(SELECT TOP 1 * FROM Compra WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID)
      SET @OK = 14055
  END

  IF @OK IS NULL
  BEGIN
    SET @AnchoDescripcion = 29
    SET @AnchoCantidad = 8
    SET @AnchoUnidad = 6
    SET @Interlineado = 30
    SET @PosY = 60

    -- Inicio de impresión
    SET @Linea = '! 0 200 200 210 1'
    INSERT INTO @Tabla (Linea) VALUES (@Linea)

    -- Encabezado
    SET @Linea = 'TEXT 0 3 10  10 ' + @Mov + ' ' + @MovID
    INSERT INTO @Tabla (Linea) VALUES (@Linea)

    SET @Linea = 'TEXT 0 2 10  50 Articulo                      Cantidad Unidad'
    INSERT INTO @Tabla (Linea) VALUES (@Linea)

    -- Detalle
    DECLARE crImprimirOC CURSOR FOR
     SELECT cd.Articulo, 
            LTRIM(RTRIM(ISNULL(a.Descripcion1, ''))), 
            cd.Cantidad, 
            LTRIM(RTRIM(ISNULL(cd.Unidad,'')))
       FROM Compra c
       JOIN CompraD cd ON (c.ID = cd.ID)
       JOIN Art a ON (cd.Articulo = a.Articulo)
      WHERE c.Empresa = @Empresa
        AND c.Mov = @Mov
        AND c.MovID = @MovID

    OPEN crImprimirOC
    FETCH NEXT FROM crImprimirOC INTO @Articulo, @Descripcion1, @Cantidad, @Unidad
    WHILE @@FETCH_STATUS = 0
    BEGIN
      SET @PosY = @PosY + @Interlineado
      SET @DescripcionTexto = LEFT(@Descripcion1,@AnchoDescripcion)
      SET @CantidadTexto    = RIGHT(SPACE(@AnchoCantidad) + CAST(@Cantidad AS varchar), @AnchoCantidad)
      SET @UnidadTexto      = RIGHT(SPACE(@AnchoUnidad) + @Unidad, @AnchoUnidad)

      SET @Linea = 'TEXT 0 2 10' + ' ' + CONVERT(varchar, @PosY) + ' ' + @DescripcionTexto + ' ' + @CantidadTexto + ' ' + @UnidadTexto
      INSERT INTO @Tabla (Linea) VALUES (@Linea)

      FETCH NEXT FROM crImprimirOC INTO @Articulo, @Descripcion1, @Cantidad, @Unidad
    END
    CLOSE crImprimirOC
    DEALLOCATE crImprimirOC
    
  END
  
  -- Fin de impresión
  SET @Linea = 'FORM'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = 'PRINT'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Longitud de impresión
  SET @PosY = @PosY + (@Interlineado * 2)
  SET @Linea = '! 0 200 200 ' + CONVERT(varchar, @PosY) + ' 1'
  UPDATE @Tabla SET Linea = @Linea WHERE idx = 1
  
  SELECT @Texto = (SELECT ISNULL(Tabla.Linea,'') AS Linea
                     FROM @Tabla AS Tabla
                    ORDER BY Tabla.idx
                      FOR XML AUTO)

  SELECT @ReferenciaIS = Referencia
    FROM IntelisisService
   WHERE ID = @ID

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  
  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),@Texto) + '</Resultado></Intelisis>'
END
GO
/************** spIntelisisWMSUsuarioCfg ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSUsuarioCfg') AND type = 'P') drop procedure dbo.spIntelisisWMSUsuarioCfg
GO
CREATE PROCEDURE spIntelisisWMSUsuarioCfg
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
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Texto                   xml,
    @Usuario                 varchar(5),
    @ModificarPosicion       bit

  BEGIN TRY
    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SET @Usuario = LTRIM(RTRIM(ISNULL(@Usuario,'')))

    DECLARE @Tabla Table(
      Usuario                varchar(10),
      ModificarPosicion      bit
    )

    INSERT INTO @Tabla (Usuario, ModificarPosicion)
    VALUES (@Usuario, 0)

    UPDATE @Tabla
       SET ModificarPosicion = b.ModificarPosicionSugeridaWMS
      FROM @Tabla a
      JOIN Usuario b
        ON (a.Usuario = b.Usuario)

    SELECT @Texto = (SELECT ISNULL(Usuario,'')                           AS Usuario,
                            CAST(ISNULL(ModificarPosicion,0) AS varchar) AS ModificarPosicion
                        FROM @Tabla AS TMA
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
/************** spIntelisisWMSInfoCodigoBarrasSurtido ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSInfoCodigoBarrasSurtido') AND type = 'P') drop procedure dbo.spIntelisisWMSInfoCodigoBarrasSurtido
GO
CREATE PROCEDURE spIntelisisWMSInfoCodigoBarrasSurtido
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
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Texto                   xml,
    @Empresa                 varchar(5),
    @Sucursal                int,
    @Almacen                 varchar(10),
    @Usuario                 varchar(10),
    @Mov                     varchar(20),
    @MovID                   varchar(20),
    @Renglon                 float,
    @RenglonSub              int,
    @RenglonID               int,
    @Articulo                varchar(20),
    @SubCuenta               varchar(50),
    @CodigoBarras            varchar(30),
    @DUN14                   varchar(30),
    @idr                     int

  BEGIN TRY
    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Sucursal = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Sucursal'

    SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Almacen'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovID'

    SELECT @Renglon = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Renglon'

    SELECT @RenglonSub = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'RenglonSub'

    SELECT @RenglonID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'RenglonID'

    SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Articulo'

    SELECT @SubCuenta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SubCuenta'

    SELECT @CodigoBarras = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'CodigoBarras'

    DECLARE @Tabla Table(
      IDR                 int identity(1,1),
      CodigoBarras        varchar(30),
      DUN14               varchar(30),
      Articulo            varchar(20),
      Articulo2           varchar(20),
      SubCuenta           varchar(50),
      SubCuenta2          varchar(50),
      Cantidad            float,
      CantidadInner       float,
      CantidadMaster      float,
      Cliente             varchar(99),
      Mensaje             varchar(255)
    )

    INSERT INTO @Tabla(CodigoBarras, Articulo, SubCuenta, Cantidad)
    SELECT TOP 1 Codigo, LTRIM(RTRIM(ISNULL(Cuenta,''))), LTRIM(RTRIM(ISNULL(SubCuenta,''))), ISNULL(Cantidad,1)
      FROM CB
     WHERE Codigo = @CodigoBarras
       AND TipoCuenta = 'Articulos'

    SELECT @idr = Max(IDR) FROM @Tabla

    IF ISNULL(@idr,0) = 0
      BEGIN
        INSERT INTO @Tabla(CodigoBarras, DUN14, CantidadInner, CantidadMaster, Cliente)
        SELECT TOP 1 Codigo, DUN14, CantidadINNER, CantidadMaster, Cliente
          FROM SterenDUN14
         WHERE DUN14 = @CodigoBarras

        UPDATE @Tabla
           SET Articulo = LTRIM(RTRIM(ISNULL(b.Cuenta,''))),
               SubCuenta = LTRIM(RTRIM(ISNULL(b.SubCuenta,'')))
          FROM @Tabla a
          JOIN CB b
            ON (a.CodigoBarras = b.Codigo AND b.TipoCuenta = 'Articulos')

        SELECT @idr = Max(IDR) FROM @Tabla
      END

    IF ISNULL(@idr,0) = 0
      BEGIN
        INSERT INTO @Tabla (Mensaje) SELECT 'Código no encontrado.'
      END
    ELSE
      BEGIN
        SELECT @DUN14 = LTRIM(RTRIM(ISNULL(DUN14,''))) FROM @Tabla WHERE IDR = 1

        IF LEN(@DUN14) > 0
          BEGIN
            UPDATE @Tabla SET Cantidad = CantidadMaster WHERE IDR = 1
          END

        IF NOT (SELECT Articulo FROM @Tabla WHERE IDR = 1) = @Articulo
          BEGIN
            UPDATE @Tabla
               SET Articulo2 = @Articulo,
                   Mensaje = 'Artículo incorrecto.'
             WHERE IDR = 1
          END
        ELSE IF NOT (SELECT SubCuenta FROM @Tabla WHERE IDR = 1) = @SubCuenta
          UPDATE @Tabla SET Mensaje = 'Opción Incorrecta.' WHERE IDR = 1
      END

    SELECT @Texto = (SELECT CAST(ISNULL(IDR,0) AS varchar)            AS IDR,
                            ISNULL(CodigoBarras,'')                   AS CodigoBarras,
                            ISNULL(DUN14,'')                          AS DUN14,
                            ISNULL(Articulo,'')                       AS Articulo,
                            ISNULL(Articulo2,'')                      AS Articulo2,
                            ISNULL(SubCuenta,'')                      AS SubCuenta,
                            ISNULL(SubCuenta2,'')                     AS SubCuenta2,
                            CAST(ISNULL(Cantidad,0) AS varchar)       AS Cantidad,
                            CAST(ISNULL(CantidadInner,0) AS varchar)  AS CantidadInner,
                            CAST(ISNULL(CantidadMaster,0) AS varchar) AS CantidadMaster,
                            ISNULL(Cliente,'')                        AS Cliente,
                            ISNULL(Mensaje,'')                        AS Mensaje
                        FROM @Tabla AS TMA
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
/************** spIntelisisWMSMovilLog ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSMovilLog') AND type = 'P') drop procedure dbo.spIntelisisWMSMovilLog
GO
CREATE PROCEDURE spIntelisisWMSMovilLog
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
    @ReferenciaIS            varchar(100),
    @SubReferencia           varchar(100),
    @Texto                   xml,
    @Aplicacion              varchar(50),
    @Empresa                 varchar(5),
    @Usuario                 varchar(10),
    @Modulo                  varchar(5),
    @ModuloID                int,
    @RenglonID               int,
    @Mov                     varchar(20),
    @MovID                   varchar(20),
    @Articulo                varchar(20),
    @Articulo2               varchar(20),
    @SubCuenta               varchar(50),
    @SubCuenta2              varchar(50),
    @Cantidad                float,
    @Cantidad2               float,
    @CodigoBarras            varchar(30),
    @FechaLog                datetime,
    @Mensaje                 varchar(255)

  BEGIN TRY
    SELECT @Aplicacion = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Aplicacion'

    SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Empresa'

    SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Usuario'

    SELECT @Modulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Modulo'

    SELECT @ModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'ModuloID'

    SELECT @RenglonID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'RenglonID'

    SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mov'

    SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'MovID'

    SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Articulo'

     SELECT @Articulo2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Articulo2'

    SELECT @SubCuenta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SubCuenta'

    SELECT @SubCuenta2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'SubCuenta2'

    SELECT @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Cantidad'

    SELECT @Cantidad2 = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Cantidad2'

    SELECT @CodigoBarras = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'CodigoBarras'

    SELECT @Mensaje = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
      WITH (Campo varchar(255), Valor varchar(255))
     WHERE Campo = 'Mensaje'

    DECLARE @Tabla Table(
      IDR                 int identity(1,1),
      Mensaje             varchar(255)
    )

    SET @Aplicacion        = LTRIM(RTRIM(ISNULL(@Aplicacion,'')))
    SET @Empresa           = LTRIM(RTRIM(ISNULL(@Empresa,'')))
    SET @Usuario           = LTRIM(RTRIM(ISNULL(@Usuario,'')))
    SET @Modulo            = LTRIM(RTRIM(ISNULL(@Modulo,'')))
    SET @ModuloID          = CAST(ISNULL(@ModuloID,0) AS int)
    SET @RenglonID         = CAST(ISNULL(@RenglonID,0) AS int)
    SET @Mov               = LTRIM(RTRIM(ISNULL(@Mov,'')))
    SET @MovID             = LTRIM(RTRIM(ISNULL(@MovID,'')))
    SET @Articulo          = LTRIM(RTRIM(ISNULL(@Articulo,'')))
    SET @Articulo2         = LTRIM(RTRIM(ISNULL(@Articulo2,'')))
    SET @Subcuenta         = LTRIM(RTRIM(ISNULL(@Subcuenta,'')))
    SET @Subcuenta2        = LTRIM(RTRIM(ISNULL(@Subcuenta2,'')))
    SET @Cantidad          = CAST(ISNULL(@Cantidad,'0') AS float)
    SET @Cantidad2         = CAST(ISNULL(@Cantidad2,'0') AS float)
    SET @CodigoBarras      = LTRIM(RTRIM(ISNULL(@CodigoBarras,'')))
    SET @Mensaje           = LTRIM(RTRIM(ISNULL(@Mensaje,'')))
    SET @FechaLog          = GETDATE()

    INSERT INTO MovilLog (
            Aplicacion,Empresa,Usuario,Modulo,
            ModuloID,RenglonID,Mov,MovID,Articulo,
            Articulo2,Subcuenta,Subcuenta2,Cantidad,Cantidad2,
            CodigoBarras,FechaLog,Mensaje)
    VALUES (
            @Aplicacion,@Empresa,@Usuario,@Modulo,
            @ModuloID,@RenglonID,@Mov,@MovID,@Articulo,
            @Articulo2,@Subcuenta,@Subcuenta2,@Cantidad,@Cantidad2,
            @CodigoBarras,@FechaLog,@Mensaje)

   INSERT INTO @Tabla (Mensaje) VALUES (@Mensaje)

    SELECT @Texto = (SELECT CAST(ISNULL(IDR,0) AS varchar) AS IDR,
                            ISNULL(Mensaje,'')             AS Mensaje
                       FROM @Tabla AS TMA
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
/************** spIntelisisWMSEtiquetaSurtidoImprimir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSEtiquetaSurtidoImprimir') AND type = 'P') drop procedure dbo.spIntelisisWMSEtiquetaSurtidoImprimir
GO
CREATE PROCEDURE spIntelisisWMSEtiquetaSurtidoImprimir
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
  @EmpresaNombre             varchar(100),
  @Almacen                   varchar(10),
  @Sucursal                  int,
  @SucursalNombre            varchar(100),
  @Usuario                   varchar(20),
  @Modulo                    varchar(5),
  @ModuloID                  int,
  @Renglon                   float,
  @Mov                       varchar(20),
  @MovID                     varchar(20),
  @Articulo                  varchar(20),
  @ArtDescripcion            varchar(100),
  @Subcuenta                 varchar(50),
  @Cantidad                  float,
  @CodigoBarras              varchar(30),
  @Linea                     varchar(255)


DECLARE @Tabla Table(
  idx                        int IDENTITY(1,1),
  Linea                      varchar(255)
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

  SELECT @Modulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Modulo'

  SELECT @ModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ModuloID'

  SELECT @Renglon = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Renglon'

  SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  SELECT @Articulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Articulo'

  SELECT @SubCUenta = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SubCUenta'

  SELECT @Cantidad = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Cantidad'

  SELECT @CodigoBarras = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'CodigoBarras'

  SET @Empresa         = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Sucursal        = CAST(ISNULL(@Sucursal,'0') AS int)
  SET @Usuario         = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  SET @Modulo          = LTRIM(RTRIM(ISNULL(@Modulo,'')))
  SET @ModuloID        = CAST(ISNULL(@ModuloID,'0') AS int)
  SET @Renglon         = CAST(ISNULL(@Renglon,'0') AS int)
  SET @Mov             = LTRIM(RTRIM(ISNULL(@Mov,'')))
  SET @MovID           = LTRIM(RTRIM(ISNULL(@MovID,'')))
  SET @Articulo        = LTRIM(RTRIM(ISNULL(@Articulo,'')))
  SET @Subcuenta       = LTRIM(RTRIM(ISNULL(@Subcuenta,'')))
  SET @Cantidad        = CAST(ISNULL(@Cantidad,'0') AS int)
  SET @CodigoBarras    = LTRIM(RTRIM(ISNULL(@CodigoBarras,'')))

  SELECT @EmpresaNombre = LTRIM(RTRIM(ISNULL(Nombre,''))) FROM Empresa WHERE Empresa = @Empresa
  SELECT @SucursalNombre = LTRIM(RTRIM(ISNULL(Nombre,''))) FROM Sucursal WHERE Sucursal = @Sucursal
  SELECT @ArtDescripcion = LTRIM(RTRIM(ISNULL(Descripcion1,''))) FROM Art WHERE Articulo = @Articulo

  SET @Linea = '^XA'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Título
  SET @Linea = '^FWR'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FO600,75'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^A0,50,40'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FD' + @EmpresaNombre
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FS'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Linea 1
  SET @Linea = '^CF0,40'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FO580,70'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^GB,700,5'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FS'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Código de barras
  SET @Linea = '^FO350,80'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^BY4,3,200'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^BCR190'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FD' + @Articulo
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FS'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Linea 2
  SET @Linea = '^CF0,40'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FO270,70'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^GB,700,5'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FS'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Descripción del artículo
  SET @Linea = '^FWR'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FB650,3,0,C,0'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FO100,75'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^A0,40,30'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FD' + @ArtDescripcion
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SET @Linea = '^FS'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  -- Fin de impresión
  SET @Linea = '^XZ'
  INSERT INTO @Tabla (Linea) VALUES (@Linea)

  SELECT @Texto = (SELECT ISNULL(Tabla.Linea,'') AS Linea
                     FROM @Tabla AS Tabla
                    ORDER BY Tabla.idx
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
/************** spIntelisisWMSMovimientoCompleto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSMovimientoCompleto') AND type = 'P') drop procedure dbo.spIntelisisWMSMovimientoCompleto
GO
CREATE PROCEDURE spIntelisisWMSMovimientoCompleto
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
  @Modulo                    varchar(5),
  @Mov                       varchar(20),
  @MovID                     varchar(20),
  @ModuloID                  int,
  @Mensaje                   varchar (255)

  DECLARE @Tabla Table(
    IDR                      int identity(1,1),
    Pendientes               int,
    MovimientoCompleto       bit,
    Mensaje                  varchar (255)
  )

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Modulo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Modulo'

  SELECT @Mov = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Mov'

  SELECT @MovID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'MovID'

  SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Modulo  = LTRIM(RTRIM(ISNULL(@Modulo,'')))
  SET @Mov     = LTRIM(RTRIM(ISNULL(@Mov,'')))
  SET @MovID   = LTRIM(RTRIM(ISNULL(@MovID,'')))

  IF @Modulo = 'TMA' SELECT @ModuloID = ID FROM TMA WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID

  IF ISNULL(@ModuloID ,0) = 0
    BEGIN
      SET @Ok = 14055
      INSERT INTO @Tabla (Mensaje)
      SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SET @Ok = NULL
    END
  ELSE
    BEGIN
      INSERT INTO @Tabla (Pendientes,MovimientoCompleto)
      SELECT ISNULL(SUM(CantidadPendiente),0), 0 FROM TMAD WHERE ID = @ModuloID

      IF (SELECT COUNT(IDR) FROM @Tabla) = 0 INSERT INTO @Tabla(Pendientes) VALUES (0)
      UPDATE @Tabla SET MovimientoCompleto = 1 WHERE Pendientes = 0
    END

  SELECT @Texto = (SELECT CAST(ISNULL(MovimientoCompleto,0) AS varchar) AS MovimientoCompleto,
                          ISNULL(Mensaje,'')                            AS Mensaje
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
/************** spIntelisisWMSGenerarSurtidoPerdido ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSGenerarSurtidoPerdido') AND type = 'P') drop procedure dbo.spIntelisisWMSGenerarSurtidoPerdido
GO
CREATE PROCEDURE spIntelisisWMSGenerarSurtidoPerdido
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
  @Texto           xml,
  @ReferenciaIS    varchar(100),
  @SubReferencia   varchar(100),
  @Empresa         varchar(5),
  @Usuario         varchar(10),
  @ModuloID        int,
  @MovGenerar      varchar(20),
  @MovIDGenerar    varchar(20),
  @IDGenerar       int,
  @Estacion        int,
  @Montacarga      varchar(20),
  @Agente          varchar(20),
  @NombreTrans     varchar(20)

  DECLARE @Tabla Table(
    IDR                 int identity(1,1),
    Mensaje             varchar (255)
  )

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SELECT @ModuloID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'ModuloID'

  SELECT @Montacarga = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Montacarga'

  SET @Empresa     = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @Usuario     = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  SET @ModuloID    = LTRIM(RTRIM(ISNULL(@ModuloID,'')))
  SET @Montacarga  = LTRIM(RTRIM(ISNULL(@Montacarga,'')))

  SET @Estacion = @@SPID
  SET @NombreTrans = 'TMA_SURPER' + LTRIM(RTRIM(LEFT(CAST(@Estacion AS varchar), 10)))

  IF ISNULL(@ModuloID,0) = 0
    BEGIN
      SET @Ok = 14055
      INSERT INTO @Tabla (Mensaje)
      SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SET @Ok = NULL
    END
  ELSE
    BEGIN
      BEGIN TRANSACTION @NombreTrans

      SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario

      SELECT @MovGenerar = TMASurtidoPerdido FROM EmpresaCfgMovWMS WHERE Empresa = @Empresa
      SET @MovGenerar = LTRIM(RTRIM(ISNULL(@MovGenerar,'')))

      EXEC @IDGenerar = spAfectar 'TMA', @ModuloID, 'GENERAR', 'Pendiente', @MovGenerar, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL, @OkRef = NULL

      IF ISNULL(@Ok,0) = 0
        BEGIN
          UPDATE TMA SET Montacarga = @Montacarga, Agente = @Agente WHERE ID = @IDGenerar
          UPDATE TMAD SET GeneradoEnMovil = 1 WHERE ID = @IDGenerar

          EXEC spAfectar 'TMA', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
          IF @Ok BETWEEN 80030 AND 81000 SELECT @Ok = NULL, @OkRef = NULL
        END

      IF ISNULL(@Ok,0) = 0
        BEGIN
          UPDATE TMAD SET ProcesadoEnMovil = 1 WHERE ID = @IDGenerar
          
          SELECT @MovIDGenerar = LTRIM(RTRIM(ISNULL(MovID,''))) FROM TMA WHERE ID = @IDGenerar

          INSERT INTO @Tabla (Mensaje)
          VALUES (@MovGenerar + ' ' + @MovIDGenerar + ' generado con éxito.' )

          IF EXISTS (SELECT [name] FROM sys.dm_tran_active_transactions WHERE name = @NombreTrans) COMMIT TRANSACTION @NombreTrans
        END
      ELSE
        BEGIN
          SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
          INSERT INTO @Tabla (Mensaje) VALUES (@OkRef)
          IF EXISTS (SELECT [name] FROM sys.dm_tran_active_transactions WHERE name = @NombreTrans) ROLLBACK TRANSACTION @NombreTrans
        END
    END

  SELECT @Texto = (SELECT ISNULL(Mensaje,'') AS Mensaje
                     FROM @Tabla AS Tabla
                      FOR XML AUTO)
END TRY

BEGIN CATCH
  SET @Ok = 1
  SELECT @OkRef = LTRIM(RTRIM(LEFT(ERROR_MESSAGE(),255)))
  IF EXISTS (SELECT [name] FROM sys.dm_tran_active_transactions WHERE name = @NombreTrans) ROLLBACK TRANSACTION @NombreTrans
END CATCH

-- >>
SELECT @ReferenciaIS = Referencia FROM IntelisisService WHERE ID = @ID
SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
SET @Resultado = REPLACE(@Resultado,'<BR>','.')
END
GO
/************** spIntelisisWMSOrdenSurtidoPckLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSOrdenSurtidoPckLista') AND type = 'P') drop procedure dbo.spIntelisisWMSOrdenSurtidoPckLista
GO
CREATE PROCEDURE spIntelisisWMSOrdenSurtidoPckLista
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
  @Usuario                   varchar(20),
  @FechaHoy                  datetime,
  @Cuantos                   int,
  @Dias                      int,
  @Fecha                     datetime

DECLARE @Tabla Table(
  IDR                        int identity(1,1),
  ID                         int,
  Mov                        varchar(20),
  MovID                      varchar(20),
  MovMovID                   varchar(40),
  OrigenTipo                 varchar(10),
  Origen                     varchar(20),
  OrigenID                   varchar(20),
  IDOrigen                   int
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SET @Empresa = LTRIM(RTRIM(ISNULL(@Empresa,'')))

  INSERT INTO @Tabla (ID, Mov, MovID, Origentipo, Origen, OrigenID)
  SELECT DISTINCT a.ID, a.Mov, a.MovID, a.Origentipo, a.Origen, a.OrigenID
    FROM TMA a
    JOIN TMA b ON (a.Mov = b.Origen AND a.MovID = b.OrigenID AND b.OrigenTipo = 'TMA')
   WHERE a.Empresa = @Empresa
     AND a.Mov     = 'Orden Surtido PCK'
     AND a.Estatus = 'PENDIENTE'
     AND b.Mov     = 'Surtido Transito PCK'
     AND b.Estatus = 'PROCESAR'

  UPDATE @Tabla
     SET IDOrigen = b.ID
    FROM @Tabla a
    JOIN Venta b ON(a.Origen = b.Mov AND a.OrigenID = b.MovID)

  UPDATE @Tabla SET MovMovID = LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,'')))

  SELECT @Texto = (SELECT CAST(ISNULL(ID,0) AS varchar)       AS ID,
                          LTRIM(RTRIM(ISNULL(Mov,'')))        AS Mov,
                          LTRIM(RTRIM(ISNULL(MovID,'')))      AS MovID,
                          LTRIM(RTRIM(ISNULL(MovMovID,'')))   AS MovMovID,
                          LTRIM(RTRIM(ISNULL(OrigenTipo,''))) AS OrigenTipo,
                          LTRIM(RTRIM(ISNULL(Origen,'')))     AS Origen,
                          CAST(ISNULL(OrigenID,0) AS varchar) AS OrigenID,
                          CAST(ISNULL(IDOrigen,0) AS varchar) AS IDOrigen
                     FROM @Tabla AS Tabla
                    ORDER BY IDR
                      FOR XML AUTO)

  IF @Ok IS NOT NULL SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
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
/************** spIntelisisWMSTarimasPorCerrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWMSTarimasPorCerrar') AND type = 'P') drop procedure dbo.spIntelisisWMSTarimasPorCerrar
GO
CREATE PROCEDURE spIntelisisWMSTarimasPorCerrar
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
  @Almacen                   varchar(10),
  @Sucursal                  int,
  @SucursalNombre            varchar(100),
  @Usuario                   varchar(20),
  @Agente                    varchar(10),
  @OrigenTipo                varchar(10),
  @Origen                    varchar(20),
  @OrigenID                  varchar(20)

DECLARE @Tabla Table(
  Empresa                    varchar(5),
  Almacen                    varchar(10),
  ModuloID                   int,
  Mov                        varchar(20),
  MovID                      varchar(20),
  Movimiento                 varchar(40),
  Tarima                     varchar(20),
  Articulo                   varchar(20),
  Cantidad                   float,
  TarimaCierre               varchar(20),
  PosicionDestino            varchar(10),
  DescripcionPosicionDestino varchar(100),
  Fecha                      datetime,
  Referencia                 varchar(50),
  Observaciones              varchar(100)
)

BEGIN TRY
  SELECT @Empresa = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Empresa'

  SELECT @SucursalNombre = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'SucursalNombre'

  SELECT @Almacen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Almacen'

  SELECT @Usuario = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Usuario'

  SELECT @OrigenTipo = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'OrigenTipo'

  SELECT @Origen = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'Origen'

  SELECT @OrigenID = Valor FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Campo varchar(255), Valor varchar(255))
   WHERE Campo = 'OrigenID'

  SET @Empresa        = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @SucursalNombre = LTRIM(RTRIM(ISNULL(@SucursalNombre,'')))
  SET @Almacen        = LTRIM(RTRIM(ISNULL(@Almacen,'')))
  SET @Usuario        = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  SET @OrigenTipo     = LTRIM(RTRIM(ISNULL(@OrigenTipo,'')))
  SET @Origen         = LTRIM(RTRIM(ISNULL(@Origen,'')))
  SET @OrigenID       = LTRIM(RTRIM(ISNULL(@OrigenID,'')))

  SELECT TOP 1 @Sucursal = Sucursal FROM Sucursal WHERE Nombre = @SucursalNombre
  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario

  IF LTRIM(RTRIM(ISNULL(@Almacen,'')))= ''
    BEGIN
      SELECT @Almacen = LTRIM(RTRIM(ISNULL(DefAlmacen,''))) From Usuario WHERE Usuario = @Usuario
      SET @Almacen = LTRIM(RTRIM(ISNULL(@Almacen,'')))
    END

  INSERT INTO @Tabla(ModuloID, Mov, MovId, Fecha, Referencia, Observaciones, TarimaCierre)
  SELECT t.ID, t.Mov, t.MovID, t.FechaEmision, t.Referencia, t.Observaciones, t.TarimaSurtido
    FROM TMA t
    JOIN MovTipo m ON (t.Mov = m.Mov AND m.Modulo = 'TMA')
   WHERE t.Empresa    = @Empresa
     AND t.Sucursal   = @Sucursal
     AND t.Agente     = @Agente
     AND m.Clave      = 'TMA.TSUR'
     AND m.SubClave   = 'TMA.TSURP'
     AND t.OrigenTipo = @OrigenTipo
     AND t.Origen	    = @Origen
     AND t.OrigenID   = @OrigenID
     AND t.Estatus    = 'PROCESAR'

  UPDATE @Tabla
     SET Empresa = @Empresa,
         Almacen = @Almacen,
         Movimiento = LTRIM(RTRIM(ISNULL(Mov,''))) + ' ' + LTRIM(RTRIM(ISNULL(MovID,'')))

  UPDATE @Tabla
     SET Tarima = ISNULL(b.Tarima, ''),
         Articulo = b.Articulo,
         Cantidad = b.CantidadPicking,
         PosicionDestino = b.PosicionDestino
    FROM @Tabla a
    JOIN TMAD b ON(a.ModuloID = b.ID)

  UPDATE @Tabla
     SET DescripcionPosicionDestino = b.Descripcion
    FROM @Tabla a
    JOIN AlmPos b ON (a.Almacen = b.Almacen AND a.PosicionDestino = b.Posicion)

  SELECT @Texto = (SELECT CAST(ISNULL(ModuloID,0) AS varchar)                AS ModuloID,
                          ISNULL(Mov,'')                                     AS Mov,
                          ISNULL(MovID,'')                                   AS MovID,
                          ISNULL(Movimiento,'')                              AS Movimiento,
                          ISNULL(Tarima,'')                                  AS Tarima,
                          ISNULL(Articulo,'')                                AS Articulo,
                          CAST(ISNULL(Cantidad,0) AS varchar)                AS Cantidad,
                          ISNULL(TarimaCierre,'')                            AS TarimaCierre,
                          ISNULL(PosicionDestino,'')                         AS PosicionDestino,
                          ISNULL(DescripcionPosicionDestino,'')              AS DescripcionPosicionDestino,
                          CONVERT(varchar(11), ISNULL(Fecha,'20150101'),113) AS Fecha,
                          ISNULL(Referencia,'')                              AS Referencia,
                          ISNULL(Observaciones,'')                           AS Observaciones
                     FROM @Tabla AS TMA
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
----------------------------------------------------------------------------------------------------
/**************** spIntelisisServiceProcesarWMS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesarWMS') and type = 'P') drop procedure dbo.spIntelisisServiceProcesarWMS
GO
CREATE PROCEDURE spIntelisisServiceProcesarWMS
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
AS BEGIN

  IF @Referencia = 'Intelisis.WMS.Solicitud.Empresa' EXEC spIntelisisWMSSolicitudEmpresa @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.Solicitud.Sucursal' EXEC spIntelisisWMSSolicitudSucursal @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.Validar.Usuario' EXEC spIntelisisWMSValidarUsuario @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.Validar.Montacarga' EXEC spIntelisisWMSValidarMontacarga @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  --BUG24476
  IF @Referencia = 'Intelisis.WMS.Solicitud.ValidaSucursal' EXEC spIntelisisWMSValidaSucursal @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.AfectarMov.TMA_SADO' EXEC spISIntelisisTMAAfectarTMA_SADO @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.AfectarMov.TMA_OADO' EXEC spISIntelisisTMAAfectarTMA_OADO @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.MapeoMovMovilListado' EXEC spIntelisisMapeoMovMovilListado  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.MontacargaListado' EXEC spIntelisisMontacargaListado  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  ELSE
  IF @Referencia = 'Intelisis.TarimasPorAfectarListado' EXEC spIntelisisTarimasPorAfectarListado  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  ELSE
  IF @Referencia = 'Intelisis.InfoTarimasPorAfectarListado' EXEC spIntelisisWMSInfoTarimasPorAfectarListado  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  ELSE
  IF @Referencia = 'Intelisis.WMS.OSUR.Pendiente' EXEC spIntelisisWMSOSurtidoPendientes  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  ELSE
  IF @Referencia = 'Intelisis.WMS.OSUR.MovListado' EXEC spIntelisisWMSOSURMovListado  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  ELSE
  IF @Referencia = 'Intelisis.WMS.OSUR.Tarima' EXEC spIntelisisWMSOSURTarima  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.AfectarMov.TMA_OSUR' EXEC spISIntelisisTMAAfectarTMA_OSUR @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.AfectarMov.TMA_SUR' EXEC spISIntelisisTMAAfectarTMA_SUR @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.ValidarMov.COMS_O' EXEC spIntelisisWMSValidarMovCOMS_O @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.ActualizarAnden' EXEC spIntelisisWMSActualizarAnden @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.InfoCOMS_O' EXEC spIntelisisWMSInfoOrdenCompra @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.ValidarCB' EXEC spIntelisisWMSValidarCB @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  --BUG24419
  IF @Referencia = 'Intelisis.TMA.InfoCB' EXEC spIntelisisWMSInfoCB @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  ELSE
  --BUG5664
  IF @Referencia = 'Intelisis.TMA.InfoCB_COMS' EXEC spIntelisisWMSInfoCB_COMS @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  ELSE
  IF @Referencia = 'Intelisis.TMA.ValidarSoloCB' EXEC spIntelisisWMSValidarSoloCB @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.AfectarCOMS_O' EXEC spIntelisisWMSAfectarOC @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.InfoTarimasSurtidoPikingListado' EXEC spIntelisisWMSInfoTarimasSurtidoP @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.ValidarCB.OSURP' EXEC spIntelisisWMSValidarCBOSURP @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.ValidarCntidadTarima.OSURP' EXEC spIntelisisWMSValidarCB @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.AfectarMov.TMA_OSURP' EXEC spISIntelisisTMAAfectarTMA_OSURP @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.Afectar.TSURP' EXEC spISIntelisisTMAAfectarTMA_TSURP @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.INV_IFListado' EXEC spIntelisisINVINV_IFListado @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.Validar.PosicionTarima' EXEC spIntelisisWMSValidarPosicionTarima @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.INV.AfectarMov.INV_IF' EXEC spISIntelisisINVAfectarINV_IF @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.INV.AfectarINV_SOL' EXEC spIntelisisINVAfectarINV_SOL @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.TareasAsignadasListado' EXEC spIntelisisWMSTareasAsignadasListado @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.SerieLoteProp' EXEC spIntelisisWMSSerieLoteProp @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.SerieLotePropLista' EXEC spIntelisisWMSSerieLotePropLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.VaidaArticuloCB' EXEC spIntelisisWMSVaidaArticuloCB @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.ListaDetalleINV' EXEC spIntelisisWMSListaDetalleINV @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE --BUG24419
  IF @Referencia = 'Intelisis.ArticuloEspPosicion' EXEC spIntelisisArticuloEspPosicion @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE -- TASK24092013 --BUG24419
  IF @Referencia = 'Intelisis.ArticuloUnidadListado' EXEC spIntelisisArticuloUnidadListado @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE -- TASK24092013 --BUG24419
  IF @Referencia = 'Intelisis.ArticuloUnidadFactor' EXEC spIntelisisArticuloUnidadFactor @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE-- TASK24092013
  --BUG24692
  IF @Referencia = 'Intelisis.TMA.DetalleMov.COMS_O' EXEC spIntelisisWMSDetalleMovCOMS_O @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  --BUG24693
  IF @Referencia = 'Intelisis.TMA.GenerarMov.TMA_SRADO' EXEC spISIntelisisTMAProcesarTMA_SRADO @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  --BUG24695
  IF @Referencia = 'Intelisis.ArticuloPosicionRADO' EXEC spIntelisisArticuloPosicionRADO @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE-- 26042014
  IF @Referencia = 'Intelisis.ArticuloEPosicionDestinoRADO' EXEC spIntelisisArticuloPosicionDestinoRADO @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE-- 26042014
  IF @Referencia = 'Intelisis.TMA.AfectarMov.TMA_RADO' EXEC spISIntelisisTMAAfectarTMA_RADO @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE -- 26042014
  --BUG24696
  IF @Referencia = 'Intelisis.ArticuloPosicionRADOPck' EXEC spIntelisisArticuloPosicionRADOPck @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.RADOPck.MovListado' EXEC spIntelisisRADOPck_MovListado  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  ELSE
  IF @Referencia = 'Intelisis.ArticuloEPosicionDestinoRADOPck' EXEC spIntelisisArticuloPosicionDestinoRADOPck @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.AfectarMov.TMA_RADOPck' EXEC spISIntelisisTMAAfectarTMA_RADOPck @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.InfoPesoTarima' EXEC spIntelisisWMSInfoPesoTarima @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.InfoCB_IF' EXEC spIntelisisWMSInfoCB_IF @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  --BUG24697
  IF @Referencia = 'Intelisis.ArticuloPosicionORENT' EXEC spIntelisisArticuloPosicionORENT @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.AfectarMov.TMA_ORENT' EXEC spISIntelisisTMAAfectarTMA_ORENT @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  --jolmosh
  IF @Referencia = 'Intelisis.WMS.InfoPosicion' EXEC spIntelisisWMSInfoPosicion @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.InfoTarima' EXEC spIntelisisWMSInfoTarima @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.OrdenCompraLista' EXEC spIntelisisWMSOrdenCompraLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.EntradaCompraLista' EXEC spIntelisisWMSEntradaCompraLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.TotalCB' EXEC spIntelisisWMSTotalCB @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.InfoArticuloSerieLote' EXEC spIntelisisWMSInfoArticuloSerieLote @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.ArticuloCBLista' EXEC spIntelisisWMSArticuloCBLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.AfectarMov.TMA_OPCKTARIMA' EXEC spIntelisisTMAAfectarMovTMA_OPCKTARIMA @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.TMA.AfectarMov.TMA_PCKTARIMATRAN' EXEC spIntelisisTMAAfectarMovTMA_PCKTARIMATRAN @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.InventarioDetalle' EXEC spIntelisisWMSInventarioDetalle @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.InfoSerieLote' EXEC spIntelisisWMSInfoSerieLote @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.SerieLoteActualizar' EXEC spIntelisisWMSSerieLoteActualizar @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.InventarioActualizar' EXEC spIntelisisWMSInventarioActualizar @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.OrdenCompraActualizar' EXEC spIntelisisWMSOrdenCompraActualizar @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.InfoDetalleMov.COMS_O' EXEC spIntelisisWMSInfoDetalleMovCOMS_O @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.ValidarZona' EXEC spIntelisisWMSValidarZona @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.InfoSerieLoteSurtido' EXEC spIntelisisWMSInfoSerieLoteSurtido @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.OSUR.TarimasPckListado' EXEC spIntelisisWMSOSURTarimasPckListado @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.InfoSerieLoteSurtidoConsolidado' EXEC spIntelisisWMSInfoSerieLoteSurtidoConsolidado @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.Movil' EXEC spIntelisisWMSMovil @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.TarimasPorCerrarLista' EXEC spIntelisisWMSTarimasPorCerrarLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.TarimasPorCerrarCuenta' EXEC spIntelisisWMSTarimasPorCerrarCuenta @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.CerrarTarimasSurtidoTransitoPCK' EXEC spIntelisisWMSCerrarTarimasSurtidoTransitoPCK @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.TarimasPorMarcarLista' EXEC spIntelisisWMSTarimasPorMarcarLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.TarimasLista' EXEC spIntelisisWMSTarimasLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.CambiarTarima' EXEC spIntelisisWMSCambiarTarima @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.TarimasArticuloLista' EXEC spIntelisisWMSTarimasArticuloLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.PocisionesArticuloLista' EXEC spIntelisisWMSPosicionesArticuloLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.GenerarSolicitudReacomodo' EXEC spIntelisisWMSGenerarSolicitudReacomodo @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.Info' EXEC spIntelisisWMSInfo @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.AlmacenesLista' EXEC spIntelisisWMSAlmacenesLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.MonedasLista' EXEC spIntelisisWMSMonedasLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.GenerarInventarioFisico' EXEC spIntelisisWMSGenerarInventarioFisico @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.MovimientosRecoleccionLista' EXEC spIntelisisWMSMovimientosRecoleccionLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.TarimasRecoleccionLista' EXEC spIntelisisWMSTarimasRecoleccionLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.CerrarRecoleccion' EXEC spIntelisisWMSCerrarRecoleccion @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.RecoleccionLista' EXEC spIntelisisWMSRecoleccionLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.RecoleccionImprimir' EXEC spIntelisisWMSRecoleccionImprimir @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.ArticuloImprimir' EXEC spIntelisisWMSArticuloImprimir @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.PosicionTarimasLista' EXEC spIntelisisWMSPosicionTarimasLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.InventarioLista' EXEC spIntelisisWMSInventarioLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.MovimientosInvLista' EXEC spIntelisisWMSMovimientosInvLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.GuardarInventario' EXEC spIntelisisWMSGuardarInventario @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.GuardarSerieLoteMov' EXEC spIntelisisWMSGuardarSerieLoteMov @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.InfoTarimaArticulo' EXEC spIntelisisWMSInfoTarimaArticulo @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE

  --PGC25022016
  IF @Referencia = 'Intelisis.TMA.InfoCOMS_OImprimir' EXEC spIntelisisWMSInfoOrdenCompraImprimirCPLC @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE

  -- STEREN
  IF @Referencia = 'Intelisis.WMS.UsuarioCfg' EXEC spIntelisisWMSUsuarioCfg @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.InfoCodigoBarrasSurtido' EXEC spIntelisisWMSInfoCodigoBarrasSurtido @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.MovilLog' EXEC spIntelisisWMSMovilLog @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.EtiquetaSurtidoImprimir' EXEC spIntelisisWMSEtiquetaSurtidoImprimir @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.MovimientoCompleto' EXEC spIntelisisWMSMovimientoCompleto @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.GenerarSurtidoPerdido' EXEC spIntelisisWMSGenerarSurtidoPerdido @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.OrdenSurtidoPckLista' EXEC spIntelisisWMSOrdenSurtidoPckLista @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.WMS.TarimasPorCerrar' EXEC spIntelisisWMSTarimasPorCerrar @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO



--BUG22851
--/**************** spIntelisisService ****************/
--if exists (select * from sysobjects where id = object_id('dbo.spIntelisisService') and type = 'P') drop procedure dbo.spIntelisisService
--GO             
--CREATE PROCEDURE spIntelisisService
--			@Usuario		varchar(10),
--			@Contrasena		varchar(32),
--			@Solicitud		varchar(max),			
--			@Resultado		varchar(max)	= NULL	OUTPUT,
--		  	@Ok			    int		        = NULL  OUTPUT,
--		  	@OkRef			varchar(255)	= NULL  OUTPUT,			
--			@Procesar		bit		        = 1,
--			@EliminarProcesado	bit		    = 1,
--			@ID			    int		        = NULL  OUTPUT,
--			@wms            bit             = 0

----//WITH ENCRYPTION
--AS BEGIN
--  DECLARE
--    @iSolicitud						int,
--    @Contenido						varchar(100),
--    @Sistema						varchar(100),
--    @Referencia						varchar(100),
--    @SubReferencia					varchar(100),
--	@Descripcion	                varchar(255),
--    @Version						float,
--    @ISDiasResguardoSolicitud		int,
--    @FechaDepuracion				datetime
    
--  SELECT @ISDiasResguardoSolicitud = ISDiasResguardoSolicitud FROM Version   

--  -- REQ 17083
--  IF NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario)
--  BEGIN
--    SELECT @Ok = 71020, @OkRef = @Usuario	
--  END
  
--  --IF @wms = 1 SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
--  --TASK 17083
--  --SELECT @ContrasenaEncriptada = dbo.fnPassword(UPPER(RTRIM(Contrasena))) FROM Usuario WHERE Usuario = @Usuario 

--  --IF EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND Contrasena = @Contrasena) OR EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND Contrasena = @ContrasenaEncriptada)--TASK 17083
--  IF @Ok IS NULL AND EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND Contrasena  IN(@Contrasena,dbo.fnPassword(UPPER(RTRIM(@Contrasena))))) --TASK 17083
--  BEGIN    
--    EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud
--    SELECT @Sistema = ISNULL(Sistema,''), @Contenido = ISNULL(Contenido,''), @Referencia = ISNULL(Referencia,''), @SubReferencia = ISNULL(SubReferencia,0), @Version = Version
--      FROM OPENXML (@iSolicitud, '/Intelisis',1) 
--      WITH (Sistema varchar(100), Contenido varchar(100), Referencia varchar(100), SubReferencia varchar(100), Version float) 
--    EXEC sp_xml_removedocument @iSolicitud

--    INSERT IntelisisService (
--            Sistema,  Contenido,  Referencia,  SubReferencia,  Version,  Usuario,  Solicitud)
--    VALUES (@Sistema, @Contenido, @Referencia, @SubReferencia, @Version, @Usuario, @Solicitud)
--    SELECT @ID = SCOPE_IDENTITY()
  
--    IF @Procesar = 1
--    BEGIN	  
--      EXEC spIntelisisServiceProcesar @ID
--      SELECT @Resultado = Resultado, @Ok = Ok, @OkRef = OkRef
--        FROM IntelisisService
--       WHERE ID = @ID
--      IF @EliminarProcesado = 1 
--        DELETE IntelisisService
--         WHERE ID = @ID	  
--    END
    
--    --Elimina los registros PROCESADOS anteriores a una fecha determinada para mantener la tabla pequeña.
--    SELECT @FechaDepuracion = dbo.fnFechaSinHora(DATEADD(DAY,0-(@ISDiasResguardoSolicitud + 1),GETDATE()))    
--    DELETE FROM IntelisisService WHERE Estatus = 'PROCESADO' AND FechaEstatus <= @FechaDepuracion

--  END ELSE IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND Contrasena  IN(@Contrasena,dbo.fnPassword(UPPER(RTRIM(@Contrasena))))) --TASK 17083
--    SELECT @Ok = 60230, @OkRef = @Usuario
			
--  IF @Ok IS NOT NULL AND @Ok IN (71020,60230)
--  BEGIN    
--	SELECT @Descripcion=Descripcion FROM MensajeLista WHERE Mensaje=@Ok    
--	SELECT @Resultado='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@Referencia,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Descripcion="' + ISNULL(@Descripcion,'') +'"> </Resultado></Intelisis>' 	
--  END
	  
--  RETURN
--END
--GO
