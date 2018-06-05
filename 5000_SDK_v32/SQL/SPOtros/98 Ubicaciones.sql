SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO


/****** PlugInAlmacenTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'PlugInAlmacenTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('PlugInAlmacenTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.PlugInAlmacenTemp') AND type = 'U') 
  CREATE TABLE dbo.PlugInAlmacenTemp (
           Estacion             int             NOT NULL,
	   Usuario		varchar(10)	NOT NULL,
	   Empresa		varchar(5)	NOT NULL,
	   Almacen		varchar(10)	NOT NULL,
  CONSTRAINT priPlugInAlmacenTemp PRIMARY KEY CLUSTERED (Estacion)   
	   )
GO

/**************** spInsertarAlmPosTemp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInsertarAlmPosTemp') and type = 'P') drop procedure dbo.spInsertarAlmPosTemp
GO             
CREATE PROCEDURE spInsertarAlmPosTemp
		@Estacion       int,
		@Empresa	varchar(5),
                @Usuario	varchar(10),                
                @Almacen	varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DELETE PlugInAlmacenTemp WHERE Estacion = @Estacion
  
  INSERT PlugInAlmacenTemp(Estacion , Empresa,  Usuario,  Almacen)
  SELECT                   @Estacion, @Empresa, @Usuario, @Almacen
  
  RETURN       
END
GO




/**************** spGenerarXmlAlmExistenciaPos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarXmlAlmExistenciaPos') and type = 'P') drop procedure dbo.spGenerarXmlAlmExistenciaPos
GO             
CREATE PROCEDURE spGenerarXmlAlmExistenciaPos
		@Estacion       int


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE 
@Empresa varchar(5),
@Almacen varchar(10),
@Xml1    varchar(max),
@Xml2    varchar(max),
@Xml     varchar(max)

DECLARE @Tabla table(
        Empresa         varchar(5),
        Almacen         varchar(10),
        Articulo        varchar(20),
        Descripcion     varchar(100),
        SerieLote       varchar(50),
        SubCuenta       varchar(50),
        Unidad          varchar(50),
        Existencia      float,
        Posicion        varchar(10),
        Pasillo         int,
        Fila            int,
        Nivel           int,
        Zona            varchar(50),
        Capacidad       int,
        Alto            float,
        Largo           float,
        Volumen         float,
        Tipo            varchar(20))

  SELECT @Empresa = Empresa ,@Almacen = Almacen
    FROM PlugInAlmacenTemp
   WHERE Estacion = @Estacion 

  INSERT @Tabla(Empresa,               Almacen,             Articulo,  Unidad,            SerieLote,              SubCuenta,              Existencia,             Posicion,              Pasillo,             Fila,             Nivel,             Zona,              Capacidad,             Alto,             Largo,              Volumen,             Tipo, Descripcion)
  SELECT        ISNULL(e.Empresa,''), ISNULL(e.Almacen,''), ISNULL(e.Articulo,''), ISNULL(e.Unidad,''), ISNULL(e.SerieLote,''), ISNULL(e.SubCuenta,''), ISNULL(e.Existencia,0), ISNULL(e.Posicion,''), ISNULL(a.Pasillo,0), ISNULL(a.Fila,0), ISNULL(a.Nivel,0), ISNULL(a.Zona,''), ISNULL(a.Capacidad,0), ISNULL(a.Alto,0), ISNULL(a.Largo,0),  ISNULL(a.Volumen,0), ISNULL(a.Tipo,''), ISNULL(ar.Descripcion1,'')
    FROM    ExistenciaAlternaPosicionSerieLote e JOIN AlmPos a ON e.Almacen = a.Almacen AND e.Posicion = a.Posicion
    JOIN Art ar ON e.Articulo = ar.Articulo
   WHERE e.Almacen = @Almacen
     AND e.Empresa = @Empresa 
     AND e.Existencia <> 0.0 
     
  SELECT @Xml1 = (SELECT * FROM AlmPos  AlmacenPosicion WHERE AlmacenPosicion.Almacen = @Almacen FOR XML AUTO)     
  SELECT @Xml2 = (SELECT * FROM @Tabla  ExistenciaPosicion FOR XML AUTO)   

  SELECT @Xml = '<?xml version="1.0" encoding="windows-1252"?><ExistenciaPosicionAlmacen>'+ISNULL(@Xml1,'')+ISNULL(@Xml2,'')+'</ExistenciaPosicionAlmacen>'   

  SELECT 'Resultado' = CONVERT(xml,@Xml)   

  RETURN       
END
GO


--exec sp_executesql N'exec spGenerarXmlAlmExistenciaPos @P1
--',N'@P1 nvarchar(1)',N'1'

/**************** spGeneraCambioPosicion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGeneraCambioPosicion') and type = 'P') drop procedure dbo.spGeneraCambioPosicion
GO            
CREATE PROCEDURE spGeneraCambioPosicion
                @Estacion       int,
                @Xml            varchar(max)
 
 
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE
  @iSolicitud int,
  @SerieLote     varchar(50),
  @SubCuenta     varchar(50),
  @Posicion      varchar(50),
  @Articulo      varchar(20),
  @ExistenciaO   float,
  @ExistenciaD   float,
  @ExistenciaD2  float,
  @ID            int,
  @IDGenerar     int,
  @Renglon       float,
  @RenglonID     int,
  @Renglontipo   varchar(1),
  @ArticuloD     varchar(20),
  @SubCuentaD    varchar(50),
  @CantidadD     float,
  @UnidadD       varchar(50),
  @PosicionO     varchar(10),
  @PosicionD     varchar(10),
  @Mov           varchar(20),
  @Moneda        varchar(20),
  @Fecha         datetime,
  @TipoCambio    float,
  @Sucursal      int,
  @Unidad        varchar(50),
  @ArtTipo       varchar(20),
  @Ok            int,
  @OkRef         varchar(255),
  @SerieLoteD    varchar(50),
  @Empresa       varchar(5),
  @Almacen       varchar(10),
  @Usuario       varchar(10),
  @CfgTipoCosteo varchar(20),
  @ArtTipoCosteo varchar(20),
  @CfgFormaCosteo varchar(20),
  @TipoCosteo    varchar(20),
  @Costo         float
 
DECLARE @Tabla table(
  Almacen       varchar(10),
  SerieLote     varchar(50),
  SubCuenta     varchar(50),
  Unidad        varchar(50),
  Posicion      varchar(50),
  Articulo      varchar(20),
  Existencia    float)
 
DECLARE @Tabla2 table(
  Almacen       varchar(10),
  SerieLote     varchar(50),
  SubCuenta     varchar(50),
  Unidad        varchar(50),
  Posicion      varchar(50),
  Articulo      varchar(20),
  Existencia    float) 
 
 
 
  DECLARE @Tabla4 table(
  ID            int IDENTITY,
  Almacen       varchar(10),
  SerieLote     varchar(50),
  SubCuenta     varchar(50),
  Unidad        varchar(50),
  Posicion      varchar(50),
  PosicionO     varchar(50),
  Articulo      varchar(20),
  Existencia    float,
  ExistenciaO   float,
  ExistenciaD   float) 
 
  BEGIN TRAN
  SELECT @Fecha = dbo.fnFechaSinHora(GETDATE())
 
  SELECT @Empresa = Empresa, @Usuario = Usuario
    FROM PlugInAlmacenTemp
   WHERE Estacion = @Estacion 
  SELECT @Mov = Mov FROM MovTipo WHERE Modulo = 'INV' AND Clave = 'INV.CPOS'
  SELECT @Moneda = ContMoneda, @CfgTipoCosteo = ISNULL(UPPER(RTRIM(TipoCosteo)), 'PROMEDIO'),@CfgFormaCosteo             = ISNULL(UPPER(RTRIM(FormaCosteo)), 'EMPRESA')
    FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @TipoCambio =  TipoCambio FROM Mon WHERE Moneda = @Moneda
  SELECT @TipoCambio = ISNULL(@TipoCambio,1.0)
 
  EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Xml
  INSERT @Tabla(Almacen,     SerieLote,            Posicion,            Articulo,            Existencia,                      SubCuenta, Unidad)
  SELECT NULLIF(Almacen,''), NULLIF(SerieLote,''), NULLIF(Posicion,''), NULLIF(Articulo,''), ISNULL(NULLIF(Existencia,''),0), NULLIF(SubCuenta,''), NULLIF(Unidad,'')
    FROM OPENXML (@iSolicitud, '/ExistenciaPosicionAlmacen/AlmacenPosicion',1) 
    WITH (Almacen varchar(20), SerieLote     varchar(50),  SubCuenta     varchar(50),  Posicion      varchar(50),  Articulo      varchar(20),  Existencia    float,Unidad varchar(50))
  EXEC sp_xml_removedocument @iSolicitud 
  IF @@ERROR <>0 SET @Ok = 1
 
  SELECT TOP 1 @Almacen = Almacen  FROM @Tabla WHERE NULLIF(Almacen,'') IS NOT NULL
  SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
  
  
  INSERT @Tabla2(Almacen,     SerieLote,            Posicion,            Articulo,            Existencia,                      SubCuenta,Unidad)
  SELECT NULLIF(Almacen,''), NULLIF(SerieLote,''), NULLIF(Posicion,''), NULLIF(Articulo,''), ISNULL(NULLIF(Existencia,''),0), NULLIF(SubCuenta,''), NULLIF(Unidad,'')
    FROM ExistenciaAlternaPosicionSerieLote
   WHERE Almacen = @Almacen
     AND Empresa = @Empresa
  UNION ALL  
  SELECT NULLIF(Almacen,''), NULLIF(SerieLote,''), NULLIF(Posicion,''), NULLIF(Articulo,''), 0, NULLIF(SubCuenta,''), NULLIF(Unidad,'')
    FROM @Tabla  
    EXCEPT
  SELECT NULLIF(Almacen,''), NULLIF(SerieLote,''), NULLIF(Posicion,''), NULLIF(Articulo,''), 0, NULLIF(SubCuenta,''), NULLIF(Unidad,'')
    FROM ExistenciaAlternaPosicionSerieLote
   WHERE Almacen = @Almacen
     AND Empresa = @Empresa     
  IF @@ERROR <>0 SET @Ok = 1
 
 
  INSERT @Tabla4(Almacen,  Articulo,                      SerieLote,                       Posicion,                       SubCuenta,                        Unidad,                       ExistenciaO,                  Existencia, ExistenciaD) 
  SELECT         @Almacen, ISNULL(a.Articulo,b.Articulo), ISNULL(a.SerieLote,b.SerieLote), ISNULL(a.Posicion,b.Posicion),  ISNULL(a.SubCuenta,b.SubCuenta) , ISNULL(a.Unidad,b.Unidad),    ISNULL(b.Existencia,0),       ISNULL(a.Existencia,0)  -ISNULL(b.Existencia,0)   ,ISNULL(a.Existencia,0)                
    FROM @Tabla a  LEFT JOIN @Tabla2 b ON a.Almacen = b.Almacen AND a.Articulo = b.Articulo  AND a.Posicion = b.Posicion AND ISNULL(a.SubCuenta,'') = ISNULL(b.SubCuenta,'') AND ISNULL(a.SerieLote,'') = ISNULL(b.SerieLote,'') AND a.Unidad = b.Unidad
  IF @@ERROR <>0 SET @Ok = 1
  DELETE @Tabla4 WHERE ExistenciaD = ExistenciaO
 
  IF @Ok IS NULL
  BEGIN
    DECLARE crExistenciaOrigen CURSOR FOR
     SELECT Articulo, ISNULL(SerieLote,''), Posicion, ISNULL(SubCuenta,''),ExistenciaO, Existencia, Unidad
       FROM @Tabla4
      WHERE  Existencia <= 0.0
 
    OPEN crExistenciaOrigen
    FETCH NEXT FROM crExistenciaOrigen INTO @Articulo, @SerieLote, @Posicion, @SubCuenta, @ExistenciaO, @ExistenciaD, @Unidad
    WHILE @@FETCH_STATUS = 0
    BEGIN
   
      DECLARE crExistenciaDestino CURSOR FOR
       SELECT ID, Existencia
         FROM @Tabla4
        WHERE  Existencia > =0.0
          AND Articulo = @Articulo
          AND ISNULL(SerieLote,'') = @SerieLote
          AND ISNULL(SubCuenta,'') = @SubCuenta
          AND Unidad = @Unidad
          AND ExistenciaD <> ExistenciaO
     
      OPEN crExistenciaDestino
      FETCH NEXT FROM crExistenciaDestino INTO @ID, @ExistenciaD2
      WHILE @@FETCH_STATUS = 0 AND @ExistenciaD <= 0
      BEGIN
     
        UPDATE @Tabla4 SET PosicionO = @Posicion WHERE ID = @ID
        IF @@ERROR <>0 SET @Ok = 1
        SELECT @ExistenciaD = @ExistenciaD - @ExistenciaD2
        FETCH NEXT FROM crExistenciaDestino INTO @ID, @ExistenciaD2
      END
      CLOSE crExistenciaDestino
      DEALLOCATE crExistenciaDestino
 
      FETCH NEXT FROM crExistenciaOrigen INTO @Articulo, @SerieLote, @Posicion, @SubCuenta, @ExistenciaO, @ExistenciaD, @Unidad
      END
    CLOSE crExistenciaOrigen
    DEALLOCATE crExistenciaOrigen
  END
 
  DELETE @Tabla4 WHERE PosicionO IS NULL
 
  INSERT Inv (Empresa,  Mov,  FechaEmision, Concepto, Proyecto, Moneda,  TipoCambio, Usuario, Estatus,       Almacen,  Sucursal)
  SELECT      @Empresa, @Mov, @Fecha,       NULL,     NULL,     @Moneda,@TipoCambio, @Usuario, 'SINAFECTAR', @Almacen, @Sucursal
  SELECT @IDGenerar = SCOPE_IDENTITY()
  IF @@ERROR <>0 SET @Ok = 1
 
  IF @Ok IS NULL
  BEGIN
    DECLARE crInvD CURSOR FOR
     SELECT Articulo, ISNULL(SubCuenta,''), Existencia, Unidad, Almacen, PosicionO, Posicion, NULLIF(SerieLote,'')
       FROM @Tabla4
      WHERE  ISNULL(Existencia,0) <> 0.0
       SELECT @Renglon = 2048.0, @RenglonID = 1
    OPEN crInvD
    FETCH NEXT FROM crInvD INTO @ArticuloD, @SubCuentaD, @CantidadD, @UnidadD, @Almacen, @PosicionO, @PosicionD, @SerieLoteD
    WHILE @@FETCH_STATUS = 0 --AND @ExistenciaD <> 0
    BEGIN
      SELECT @ArtTipo = Tipo, @ArtTipoCosteo = ISNULL(NULLIF(RTRIM(TipoCosteo), ''), @CfgTipoCosteo) FROM Art WHERE Articulo = @Articulo
      EXEC spRenglonTipo @ArtTipo, @Subcuenta, @RenglonTipo OUTPUT
      
      IF @CfgFormaCosteo = 'EMPRESA' SELECT @TipoCosteo = @CfgTipoCosteo ELSE SELECT @TipoCosteo = @ArtTipoCosteo
      EXEC spVerCosto @Sucursal, @Empresa, NULL, @ArticuloD, @SubCuentaD, @UnidadD, @TipoCosteo, @Moneda, 1.0, @Costo OUTPUT, 0
      
      INSERT InvD(ID,         Renglon,  RenglonID,  RenglonTipo,  Articulo,   SubCuenta,   Cantidad,   Unidad,   Almacen,  Posicion,   PosicionDestino, Factor, CantidadInventario, Costo)
      SELECT      @IDGenerar, @Renglon, @RenglonID, @Renglontipo, @ArticuloD, @SubCuentaD, @CantidadD, @UnidadD, @Almacen, @PosicionO, @PosicionD,      1,      @CantidadD,         @Costo
      IF @@ERROR <>0 SET @Ok = 1
     
      IF @SerieLoteD IS NOT NULL
        INSERT SerieLoteMov(Empresa, Modulo, ID,          RenglonID,  Articulo,   SubCuenta,   SerieLote, Cantidad,     Sucursal)
        SELECT              @Empresa, 'INV', @IDGenerar, @RenglonID, @ArticuloD, @SubCuentaD, @SerieLoteD, @CantidadD, @Sucursal
      IF @@ERROR <>0 SET @Ok = 1
     
      SELECT @Renglon = ISNULL(@Renglon,2048.0)+2048.0, @RenglonID = @RenglonID +1
     
      
      FETCH NEXT FROM crInvD INTO @ArticuloD, @SubCuentaD, @CantidadD, @UnidadD, @Almacen, @PosicionO, @PosicionD, @SerieLoteD
    END
    CLOSE crInvD
    DEALLOCATE crInvD 
  END
  DELETE InvD WHERE Cantidad = 0 AND ID = @IDGenerar
  
  IF NOT EXISTS(SELECT * FROM InvD WHERE ID = @IDGenerar)
    SET @Ok = 60010
  
  IF @Ok IS NULL
    EXEC  spAfectar 'INV', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, NULL, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @EnSilencio = 1, @Conexion = 0
 
 
 
  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Resultado' ='PROCESO CONCLUIDO EXISTOSAMENTE'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT 'Resultado' =  ISNULL(@OkRef,'') + ISNULL(Descripcion,'') FROM MensajeLista WHERE Mensaje = @Ok
  END
 
  RETURN      
END
GO

--exec sp_executesql N'exec spGeneraCambioPosicion @P1,@P2
--',N'@P1 int,@P2 text',1,'<?xml version="1.0"?>
--<ExistenciaPosicionAlmacen>
--  <AlmacenPosicion Almacen="ALMGRAL" SerieLote="" Posicion="UBICACION2" Articulo="ART01" Existencia="3" SubCuenta="" Unidad="pza"/>
--  <AlmacenPosicion Almacen="ALMGRAL" SerieLote="" Posicion="UBUCACION3" Articulo="ART01" Existencia="2" SubCuenta="" Unidad="pza"/>
--</ExistenciaPosicionAlmacen>
--'
