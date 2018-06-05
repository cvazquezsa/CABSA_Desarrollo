SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaFiltro') -- DROP TABLE SabanaFiltro
CREATE TABLE SabanaFiltro
(
	    Estacion            INT             NULL,
        OperadorVenta       VARCHAR(10)     NULL, 
        Venta               FLOAT           NULL, 
        OperadorExistencia  VARCHAR(10)     NULL, 
        Existencia          FLOAT           NULL,
        FechaD              DATETIME        NULL,
        FechaA              DATETIME        NULL,
        SucursalGrupo       VARCHAR(20)     NULL,
        Proveedor           VARCHAR(20)     NULL,
        Departamento        VARCHAR(50)     NULL,
        Seccion             VARCHAR(50)     NULL,
        Articulo            VARCHAR(20)     NULL,
        Fabricante          VARCHAR(50)     NULL,
)

EXEC spALTER_TABLE 'SabanaFiltro', 'Fabricante',          'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'SabanaFiltro', 'MostrarProvOmision',  'BIT DEFAULT 0'
GO

IF EXISTS(SELECT * FROM syscolumns WHERE id = OBJECT_ID('SabanaFiltro') AND NAME = 'OperadorVenta' AND length = 2)
  ALTER TABLE SabanaFiltro ALTER COLUMN OperadorVenta VARCHAR(10)
IF EXISTS(SELECT * FROM syscolumns WHERE id = OBJECT_ID('SabanaFiltro') AND NAME = 'OperadorExistencia' AND length = 2)
  ALTER TABLE SabanaFiltro ALTER COLUMN OperadorExistencia VARCHAR(10)
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaFiltroSucursal') -- DROP TABLE SabanaFiltroSucursal
CREATE TABLE SabanaFiltroSucursal
(
	    Estacion            INT             NULL,
        Sucursal            INT             NULL,        
)

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'Sabana') -- DROP TABLE Sabana
CREATE TABLE Sabana
(
	    ID                  INT IDENTITY(1, 1),
	    Estacion            INT             NULL,
        Articulo            VARCHAR(20)     NULL,
        Editorial           VARCHAR(100)    NULL, 
        VentaTotal          FLOAT           NULL, 
        ExistenciaTotal     FLOAT           NULL,
        Proveedor           VARCHAR(10)     NULL,
        FechaD              DATETIME        NULL,
        FechaA              DATETIME        NULL,
        Grupo               VARCHAR(50)     NULL,
        Trabajado           INT             NULL,
        UltimaEntrada       DATETIME        NULL,
        Orden               INT             NULL,
)

EXEC spALTER_TABLE 'Sabana', 'ID',                'INT IDENTITY(1, 1)'
EXEC spALTER_TABLE 'Sabana', 'Proveedor',         'VARCHAR(10) NULL'
EXEC spALTER_TABLE 'Sabana', 'Grupo',             'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'Sabana', 'FechaD',            'DATETIME NULL'
EXEC spALTER_TABLE 'Sabana', 'FechaA',            'DATETIME NULL'
EXEC spALTER_TABLE 'Sabana', 'Trabajado',         'INT NULL'
EXEC spALTER_TABLE 'Sabana', 'UltimaEntrada',     'DATETIME NULL'
EXEC spALTER_TABLE 'Sabana', 'Orden',             'INT NULL'
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaD') -- DROP TABLE SabanaD
CREATE TABLE SabanaD
(
        ID                  INT             NULL,
	    Estacion            INT             NULL,
	    Renglon             FLOAT           NULL,
	    Proveedor           VARCHAR(20)     NULL,
        Articulo            VARCHAR(20)     NULL,
        Sucursal            INT             NULL,
        Almacen             VARCHAR(10)     NULL,
        PrimeraEntrada      DATETIME        NULL,
        UltimaEntrada       DATETIME        NULL,

        Venta               FLOAT           NULL, 
        Existencia          FLOAT           NULL,
        Transito            FLOAT           NULL,
        Devuelto            FLOAT           NULL,
        Ordenado            FLOAT           NULL,
        TraspasoP           FLOAT           NULL,
        Sugerido            FLOAT           NULL,
        CantidadComprar     FLOAT           NULL,
        Traspaso            VARCHAR(2)      NULL DEFAULT('No')
        
)

EXEC spALTER_TABLE 'SabanaD', 'Renglon',          'FLOAT NULL'
EXEC spALTER_TABLE 'SabanaD', 'ID',               'INT'
EXEC spALTER_TABLE 'SabanaD', 'TraspasoP',        'FLOAT NULL'
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaTraspaso') -- DROP TABLE SabanaTraspaso
CREATE TABLE SabanaTraspaso
(
	    Estacion            INT             NULL,
        Articulo            VARCHAR(20)     NULL,
        Sucursal            INT             NULL,
        Almacen             VARCHAR(10)     NULL,
        AlmacenDestino      VARCHAR(10)     NULL,
        SucursalDestino     INT             NULL,
        PrimeraEntrada      DATETIME        NULL,
        UltimaEntrada       DATETIME        NULL,

        Venta               FLOAT           NULL, 
        Existencia          FLOAT           NULL,
        Transito            FLOAT           NULL,
        Devuelto            FLOAT           NULL,
        Ordenado            FLOAT           NULL,
        SugeridoTraspaso    FLOAT           NULL,
        CantidadTraspasar   FLOAT           NULL,
        
)

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaVentasPaso') -- DROP TABLE SabanaVentasPaso
CREATE TABLE SabanaVentasPaso
(
	    Estacion            INT             NULL,
        Articulo            VARCHAR(20)     NULL, 
        Sucursal            INT             NULL, 
        Almacen             VARCHAR(20)     NULL, 
        Ventas              FLOAT           NULL, 
        Disponible          FLOAT           NULL,
        DisponibleOriginal  FLOAT           NULL,
        Diferencia          FLOAT           NULL,
        VentaOriginal       FLOAT           NULL,
        PrimeraCompra       DATETIME        NULL,
        Factor              INT             NULL
)
GO

EXEC spALTER_TABLE 'SabanaVentasPaso', 'IDClasificacion',   'INT NULL'
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaArt') -- DROP TABLE SabanaArt
CREATE TABLE SabanaArt
(
	    Estacion            INT             NULL,
        Articulo            VARCHAR(20)     NULL, 
)


IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaVentas') -- DROP TABLE SabanaVentas
CREATE TABLE SabanaVentas
(
	    Estacion            INT             NULL,
        Articulo            VARCHAR(20)     NULL, 
        Sucursal            INT             NULL, 
        Almacen             VARCHAR(20)     NULL,
        Ventas              FLOAT           NULL, 
        Disponible          FLOAT           NULL,
        DisponibleOriginal  FLOAT           NULL,
        Diferencia          FLOAT           NULL,
        VentaOriginal       FLOAT           NULL,
        PrimeraCompra       DATETIME        NULL,
        UltimaCompra        DATETIME        NULL,
        Factor              INT             NULL,
        Compras             FLOAT           NULL,
        Transito            FLOAT           NULL,
        Devoluciones        FLOAT           NULL,
        Traspaso            FLOAT           NULL,
)

EXEC spALTER_TABLE 'SabanaVentas', 'Traspaso',        'FLOAT NULL'
EXEC spALTER_TABLE 'SabanaVentas', 'PVP',             'FLOAT NULL'
EXEC spALTER_TABLE 'SabanaVentas', 'DevolucionOrden', 'FLOAT NULL'
GO 
EXEC spADD_INDEX 'SabanaVentas', 'Consulta', 'Articulo, Almacen'
EXEC spADD_INDEX 'SabanaVentas', 'Diferencias', 'Diferencia'
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaTransito') -- DROP TABLE SabanaTransito
CREATE TABLE SabanaTransito
(
	    Estacion            INT             NULL,
        Articulo            VARCHAR(20)     NULL, 
        Almacen             varchar(20)     NULL, 
        Transito            FLOAT           NULL
)

EXEC spADD_INDEX 'SabanaTransito', 'Consulta', 'Articulo, Almacen'
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaTraspasoP') -- DROP TABLE SabanaTraspasoP
CREATE TABLE SabanaTraspasoP
(
	    Estacion            INT             NULL,
        Articulo            VARCHAR(20)     NULL, 
        Almacen             varchar(20)     NULL, 
        Traspaso            FLOAT           NULL
)

EXEC spADD_INDEX 'SabanaTraspasoP', 'Consulta', 'Articulo, Almacen'
GO


IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaCompras') -- DROP TABLE SabanaCompras
CREATE TABLE SabanaCompras
(
	    Estacion            INT             NULL,
        Articulo            VARCHAR(20)     NULL, 
        Almacen             varchar(20)     NULL, 
        Compras            FLOAT            NULL
)

EXEC spADD_INDEX 'SabanaCompras', 'Consulta', 'Articulo, Almacen'
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaDevoluciones') -- DROP TABLE SabanaDevoluciones
CREATE TABLE SabanaDevoluciones
(
	    Estacion            INT             NULL,
        Articulo            VARCHAR(20)     NULL, 
        Almacen             varchar(20)     NULL, 
        Devoluciones        FLOAT           NULL
)

EXEC spADD_INDEX 'SabanaDevoluciones', 'Consulta', 'Articulo, Almacen'
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaSobrantes') -- DROP TABLE SabanaSobrantes
CREATE TABLE SabanaSobrantes
(
        ID                  INT IDENTITY(1, 1) NOT NULL,
	    Estacion            INT             NULL,
        Articulo            VARCHAR(20)     NULL, 
        Almacen             VARCHAR(20)     NULL, 
        Ventas              FLOAT           NULL, 
        Disponible          FLOAT           NULL,
        Sobrante            FLOAT           NULL,
        Orden               INT             NULL,
        PrimeraCompra       DATETIME        NULL
)

EXEC spADD_INDEX 'SabanaSobrantes', 'Consulta', 'Articulo, Almacen'
EXEC spADD_INDEX 'SabanaSobrantes', 'Diferencias', 'Sobrante'
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE TYPE = 'u' AND NAME = 'SabanaCompra') -- DROP TABLE SabanaCompra
CREATE TABLE SabanaCompra
(
	    Estacion            INT             NULL,
        Articulo            VARCHAR(20)     NULL, 
        Almacen             VARCHAR(20)     NULL,
        Ventas              FLOAT           NULL, 
        Disponible          FLOAT           NULL,
        Diferencia          FLOAT           NULL,
        Sugerido            FLOAT           NULL,
        EsTransferencia     BIT DEFAULT(0)  NOT NULL,
        SucursalOrigen      INT             NULL
)

EXEC spADD_INDEX 'SabanaCompra', 'Consulta', 'Articulo, Almacen'
EXEC spADD_INDEX 'SabanaCompra', 'EsTransferencia', 'EsTransferencia'
GO

if exists (select * from sysobjects where id = object_id('dbo.vsTransito2') and type = 'V') drop view dbo.vsTransito2
GO
CREATE VIEW vsTransito2
AS 
SELECT mt.Clave,
       c.FechaEmision 'FechaTransaccion',
       cd.Articulo 'SKU', 
       c.Almacen 'Almacen',
       sum(cd.CantidadPendiente * cd.Factor) 'InventarioUnidades'
  FROM Compra c 
  LEFT JOIN CompraD cd on cd.ID = c.ID
  LEFT JOIN MovTipo mt on mt.Mov = c.Mov
 WHERE c.Estatus = 'PENDIENTE' and mt.Clave = 'COMS.O' AND cd.CantidadPendiente IS NOT NULL
 GROUP BY mt.Clave, c.FechaEmision, cd.Articulo, c.Almacen
UNION ALL
SELECT mt.Clave,
       i.FechaEmision 'FechaTransaccion',
       id.Articulo 'SKU',
       i.Almacen 'Almacen', 
       SUM(id.CantidadPendiente * id.Factor) 'InventarioUnidades'
  FROM Inv i 
  JOIN InvD id ON id.ID = i.ID
  JOIN MovTipo mt ON mt.Mov = i.Mov 
 WHERE mt.Clave = 'INV.TI' AND i.Estatus = 'PENDIENTE' AND id.CantidadPendiente IS NOT NULL
 GROUP BY mt.Clave, i.FechaEmision, id.Articulo, i.Almacen
GO

/****************** fnFechaUltimaCompra *********************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFechaUltimaCompra') DROP FUNCTION fnFechaUltimaCompra
GO
CREATE FUNCTION fnFechaUltimaCompra
(
	@Articulo       VARCHAR(20),
	@Almacen        VARCHAR(20)
)
RETURNS DATETIME
AS 
BEGIN
DECLARE 
    @Fecha          DATETIME 
    
    --SELECT @Almacen = AlmacenPrincipal FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT TOP 1 @Fecha = FechaEmision 
    FROM Compra c
    JOIN CompraD cd ON c.ID = cd.ID
    JOIN MovTipo mt ON c.Mov = mt.Mov AND 'COMS' = mt.Modulo
  WHERE c.Estatus = 'CONCLUIDO' AND mt.Clave IN ('COMS.F', 'COMS.EI', 'COMS.EG') AND cd.Articulo = @Articulo AND c.Almacen = @Almacen
  ORDER BY c.ID DESC

  RETURN (@Fecha)
END
GO


/****************** fnFechaPrimeraCompra *********************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFechaPrimeraCompra') DROP FUNCTION fnFechaPrimeraCompra
GO
CREATE FUNCTION fnFechaPrimeraCompra
(
	@Articulo       VARCHAR(20),
	@Almacen        VARCHAR(20)
)
RETURNS DATETIME
AS 
BEGIN
DECLARE 
    @Fecha          DATETIME 
  
  SELECT TOP 1 @Fecha = FechaEmision 
    FROM Compra c
    JOIN CompraD cd ON c.ID = cd.ID
    JOIN MovTipo mt ON c.Mov = mt.Mov AND 'COMS' = mt.Modulo
   WHERE cd.Articulo = @Articulo AND c.Almacen = @Almacen
  ORDER BY c.ID ASC

  RETURN (@Fecha)
END
GO

if exists (select * from sysobjects where id = object_id('dbo.vsCompras') and type = 'V') drop view dbo.vsCompras
GO
CREATE VIEW vsCompras
AS 
SELECT mt.Clave,
       c.FechaEmision 'FechaTransaccion',
       cd.Articulo 'SKU', 
       c.Almacen 'Almacen',
       sum(cd.CantidadPendiente * cd.Factor) 'InventarioUnidades' 
  FROM Compra c 
  LEFT JOIN CompraD cd on cd.ID = c.ID
  LEFT JOIN MovTipo mt on mt.Mov = c.Mov
 WHERE c.Estatus = 'PENDIENTE' and mt.Clave = 'COMS.O' AND cd.CantidadPendiente IS NOT NULL
 GROUP BY mt.Clave, c.fechaEmision, cd.Articulo, c.Almacen
GO
 
 
if exists (select * from sysobjects where id = object_id('dbo.vsDevoluciones') and type = 'V') drop view dbo.vsDevoluciones
GO
CREATE VIEW vsDevoluciones
AS 
SELECT mt.Clave,
       c.FechaEmision 'FechaTransaccion',
       cd.Articulo 'SKU', 
       c.Almacen 'Almacen',
       sum(cd.Cantidad * cd.Factor) 'InventarioUnidades' 
  FROM Compra c 
  LEFT JOIN CompraD cd on cd.ID = c.ID
  LEFT JOIN MovTipo mt on mt.Mov = c.Mov
 WHERE c.Estatus = 'CONCLUIDO' and mt.Clave = 'COMS.D' --AND cd.CantidadPendiente IS NOT NULL
 GROUP BY mt.Clave, c.FechaEmision, cd.Articulo, c.Almacen
GO


if exists (select * from sysobjects where id = object_id('dbo.vsTraspaso') and type = 'V') drop view dbo.vsTraspaso
GO
CREATE VIEW vsTraspaso  
AS  
SELECT mt.Clave,
       i.FechaEmision 'FechaTransaccion',
       id.Articulo 'SKU',
       i.Almacen 'Almacen', 
       SUM(id.CantidadPendiente * id.Factor) 'InventarioUnidades'
  FROM Inv i 
  JOIN InvD id ON id.ID = i.ID
  JOIN MovTipo mt ON mt.Mov = i.Mov 
 WHERE mt.Clave IN ('INV.OT', 'INV.OI') AND i.Estatus = 'PENDIENTE' AND id.CantidadPendiente IS NOT NULL 
GROUP BY mt.Clave, i.FechaEmision, id.Articulo, i.Almacen

GO

/**************** spSabanaFiltroSucursal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSabanaFiltroSucursal') and type = 'P') drop procedure dbo.spSabanaFiltroSucursal
GO
CREATE PROCEDURE spSabanaFiltroSucursal
        @Estacion           INT,
        @Grupo              VARCHAR(50)
--//WITH ENCRYPTION
AS 
BEGIN
  
  DELETE SabanaFiltroSucursal WHERE  Estacion = @Estacion
  
  IF NULLIF(@Grupo, '') IS NOT NULL
    INSERT SabanaFiltroSucursal SELECT @Estacion, Sucursal FROM Sucursal s WHERE s.Categoria = @Grupo  AND s.Estatus = 'ALTA'


END 
GO

/**************** spSabanaActualizarTraspaso ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSabanaActualizarTraspaso') and type = 'P') drop procedure dbo.spSabanaActualizarTraspaso
GO
CREATE PROCEDURE spSabanaActualizarTraspaso
        @Estacion           INT,
        @Articulo           VARCHAR(20),
        @Almacen            VARCHAR(20),
        @Valor              VARCHAR(2)
--//WITH ENCRYPTION
AS 
BEGIN
  
  UPDATE SabanaD SET Traspaso =  @Valor WHERE Estacion = @Estacion AND Articulo = @Articulo AND Almacen = @Almacen

END 
GO

/**************** spPlanArtSabanaValidar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtSabanaValidar') and type = 'P') drop procedure dbo.spPlanArtSabanaValidar
GO
CREATE Procedure dbo.spPlanArtSabanaValidar                    
        @Estacion           INT,
        @EstacionFija       INT,
        @Nivel              INT
--//WITH ENCRYPTION
As                    
BEGIN                        

  DECLARE 
          @OperadorVenta      VARCHAR(2), 
        @Venta              FLOAT, 
        @OperadorExistencia VARCHAR(2), 
        @Existencia         FLOAT,
        @FechaD             DATETIME,
        @FechaA             DATETIME,
        @SucursalGrupo      VARCHAR(20),
        @Proveedor          VARCHAR(20),
        @Departamento       VARCHAR(50),
        @Seccion            VARCHAR(50),
        @Articulo           VARCHAR(20),

        @OkRef              VARCHAR(255)
          
  --DELETE FROM SabanaFiltroSucursal WHERE Estacion = @Estacion AND Sucursal NOT IN (SELECT Clave FROM ListaSt li WHERE Estacion = @Estacion)
  
  SELECT @OkRef = 'OK'
  
  SELECT @OperadorVenta = OperadorVenta, @Venta = Venta, @OperadorExistencia = OperadorExistencia, @Existencia = Existencia,
         @FechaD = FechaD, @FechaA = FechaA, @SucursalGrupo = SucursalGrupo, @Proveedor = Proveedor, @Departamento = Departamento,
         @Seccion = Seccion, @Articulo = Articulo
    FROM SabanaFiltro
  WHERE Estacion = @EstacionFija 
  
  IF @Nivel = 1
  BEGIN
    IF NULLIF(@FechaD, '') IS NULL OR NULLIF(@FechaA, '') IS NULL
      SELECT @OkRef = 'Falta especificar la fecha' ELSE
    IF NULLIF(@Proveedor, '') IS NULL AND NULLIF(@Articulo, '') IS NULL
      SELECT @OkRef = 'Falta especificar el Proveedor' ELSE
    IF NULLIF(@Departamento, '') IS NULL AND NULLIF(@Articulo, '') IS NULL
      SELECT @OkRef = 'Falta especificar el Departamento' ELSE
    IF NULLIF(@SucursalGrupo, '') IS NULL 
      SELECT @OkRef = 'Falta especificar el Grupo de Sucursales'
  END ELSE 
  IF @Nivel = 2
  BEGIN
    DELETE FROM SabanaFiltroSucursal WHERE Estacion = @EstacionFija AND Sucursal NOT IN (SELECT Clave FROM ListaSt li WHERE Estacion = @Estacion)
    
    IF NOT EXISTS(SELECT * FROM SabanaFiltroSucursal WHERE Estacion = @EstacionFija)
      SELECT @OkRef = 'No hay sucursales seleccionadas'
  END
   
  SELECT @OkRef
  
END
GO

/**************** spPlanArtSabana ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtSabana') and type = 'P') drop procedure dbo.spPlanArtSabana
GO
CREATE Procedure dbo.spPlanArtSabana
        @Empresa                VARCHAR(5),
        @EstacionOriginal       INT,                    
        @Estacion               INT
--WITH ENCRYPTION                
As                    
BEGIN                        

  DECLARE 
  	    @OperadorVenta          VARCHAR(10), 
        @Venta                  FLOAT, 
        @OperadorExistencia     VARCHAR(10), 
        @Existencia             FLOAT,
        @FechaD                 DATETIME,
        @FechaA                 DATETIME,
        @SucursalGrupo          VARCHAR(20),
        @Proveedor              VARCHAR(20),
        @Departamento           VARCHAR(50),
        @Seccion                VARCHAR(50),
        @Fabricante             VARCHAR(50),
        @Articulo               VARCHAR(20),
        @CalcularPrecio         BIT,

        @Sucursal               INT, 
        @Diferencia             FLOAT,
        @SucursalOrigen         INT,
        @ID                     INT,
        @Requerido              INT,
        @Factor                 INT,
        @FechaCompra            DATETIME,
        @Fecha                  DATETIME,
        @Fecha2                 DATETIME,
        @Fecha3                 DATETIME,
        @Fecha4                 DATETIME,
        @Factor1                INT,
        
        @SQL                    VARCHAR(MAX),
        @MostrarGrises          BIT,
        @MostrarProvOmision     BIT,
        @EstatusPlan            VARCHAR(30)
        
  DELETE FROM SabanaVentasPaso WHERE Estacion =  @Estacion
  DELETE FROM SabanaVentas WHERE Estacion =  @Estacion
  DELETE FROM SabanaArt WHERE Estacion =  @Estacion
  DELETE FROM SabanaSobrantes WHERE Estacion =  @Estacion
  DELETE FROM SabanaTraspaso WHERE Estacion =  @Estacion
  DELETE FROM SabanaCompras WHERE Estacion =  @Estacion
  DELETE FROM SabanaTransito WHERE Estacion =  @Estacion
  DELETE FROM Sabana WHERE Estacion =  @Estacion
  DELETE FROM SabanaD WHERE Estacion =  @Estacion
  DELETE FROM SabanaTraspasoP WHERE Estacion =  @Estacion
  DELETE FROM SabanaDevoluciones WHERE Estacion =  @Estacion
  
  SELECT @Fecha = dbo.fnFechaSinHora(GETDATE())
  
  SELECT @OperadorVenta = OperadorVenta, @Venta = Venta, @OperadorExistencia = OperadorExistencia, @Existencia = Existencia,
         @FechaD = FechaD, @FechaA = FechaA, @SucursalGrupo = SucursalGrupo, @Proveedor = Proveedor, @Departamento = Departamento,
         @Seccion = Seccion, @Articulo = Articulo, @Fabricante = Fabricante, @MostrarProvOmision = MostrarProvOmision
    FROM SabanaFiltro WITH(NOLOCK)
  WHERE Estacion = @Estacion 
  
  SELECT @OperadorVenta = NULLIF(@OperadorVenta, '(TODOS)')
  SELECT @OperadorExistencia = NULLIF(@OperadorExistencia, '(TODOS)')
  
  IF @MostrarProvOmision = 0
  BEGIN
    IF NULLIF(@Articulo, '') IS NULL
    BEGIN
      IF NULLIF(@Seccion, '') IS NULL AND NULLIF(@Fabricante, '') IS NULL
        INSERT SabanaArt
        SELECT @Estacion, a.Articulo
          FROM Art a
          JOIN ArtProv ap ON a.Articulo = ap.Articulo
         WHERE ap.Proveedor = @Proveedor 
           AND a.Categoria = @Departamento
           AND a.Estatus = 'ALTA'
      ELSE IF NULLIF(@Seccion, '') IS NOT NULL AND NULLIF(@Fabricante, '') IS NULL
        INSERT SabanaArt
        SELECT @Estacion, a.Articulo
          FROM Art a
          JOIN ArtProv ap ON a.Articulo = ap.Articulo
         WHERE ap.Proveedor = @Proveedor 
           AND a.Categoria = @Departamento
           AND a.Familia = @Seccion
           AND a.Estatus = 'ALTA'
      ELSE IF NULLIF(@Seccion, '') IS NULL AND NULLIF(@Fabricante, '') IS NOT NULL
        INSERT SabanaArt
        SELECT @Estacion, a.Articulo
          FROM Art a
          JOIN ArtProv ap ON a.Articulo = ap.Articulo
         WHERE ap.Proveedor = @Proveedor 
           AND a.Categoria = @Departamento
           AND a.Fabricante = @Fabricante
           AND a.Estatus = 'ALTA'
      ELSE IF NULLIF(@Seccion, '') IS NOT NULL AND NULLIF(@Fabricante, '') IS NOT NULL
        INSERT SabanaArt
        SELECT @Estacion, a.Articulo
          FROM Art a
          JOIN ArtProv ap ON a.Articulo = ap.Articulo
         WHERE ap.Proveedor = @Proveedor 
           AND a.Categoria = @Departamento
           AND a.Familia = @Seccion
           AND a.Fabricante = @Fabricante
           AND a.Estatus = 'ALTA'
    END ELSE IF NULLIF(@Articulo, '') IS NOT NULL
    BEGIN
      SELECT @Proveedor = ISNULL(NULLIF(@Proveedor, ''), Proveedor) FROM Art WHERE Articulo = @Articulo
    
      INSERT SabanaArt
      SELECT @Estacion, a.Articulo
        FROM Art a
        JOIN ArtProv ap ON a.Articulo = ap.Articulo
       WHERE a.Articulo = @Articulo
         AND ap.Proveedor = @Proveedor
         AND a.Estatus = 'ALTA'
     
    END
  END ELSE
  BEGIN
    IF NULLIF(@Articulo, '') IS NULL
    BEGIN
      IF NULLIF(@Seccion, '') IS NULL AND NULLIF(@Fabricante, '') IS NULL
        INSERT SabanaArt
        SELECT @Estacion, a.Articulo
          FROM Art a
          JOIN ArtProv ap ON a.Articulo = ap.Articulo AND a.Proveedor = ap.Proveedor
         WHERE a.Proveedor = @Proveedor 
           AND a.Categoria = @Departamento
           AND a.Estatus = 'ALTA'
      ELSE IF NULLIF(@Seccion, '') IS NOT NULL AND NULLIF(@Fabricante, '') IS NULL
        INSERT SabanaArt
        SELECT @Estacion, a.Articulo
          FROM Art a
          JOIN ArtProv ap ON a.Articulo = ap.Articulo AND a.Proveedor = ap.Proveedor
         WHERE a.Proveedor = @Proveedor 
           AND a.Categoria = @Departamento
           AND a.Familia = @Seccion
           AND a.Estatus = 'ALTA'
      ELSE IF NULLIF(@Seccion, '') IS NULL AND NULLIF(@Fabricante, '') IS NOT NULL
        INSERT SabanaArt
        SELECT @Estacion, a.Articulo
          FROM Art a
          JOIN ArtProv ap ON a.Articulo = ap.Articulo AND a.Proveedor = ap.Proveedor
         WHERE a.Proveedor = @Proveedor 
           AND a.Categoria = @Departamento
           AND a.Fabricante = @Fabricante
           AND a.Estatus = 'ALTA'
      ELSE IF NULLIF(@Seccion, '') IS NOT NULL AND NULLIF(@Fabricante, '') IS NOT NULL
        INSERT SabanaArt
        SELECT @Estacion, a.Articulo
          FROM Art a
          JOIN ArtProv ap ON a.Articulo = ap.Articulo AND a.Proveedor = ap.Proveedor
         WHERE a.Proveedor = @Proveedor 
           AND a.Categoria = @Departamento
           AND a.Familia = @Seccion
           AND a.Fabricante = @Fabricante
           AND a.Estatus = 'ALTA'
    END ELSE IF NULLIF(@Articulo, '') IS NOT NULL
    BEGIN
      SELECT @Proveedor = Proveedor FROM Art WHERE Articulo = @Articulo
    
      INSERT SabanaArt
      SELECT @Estacion, a.Articulo
        FROM Art a
       WHERE a.Articulo = @Articulo
         --AND a.Proveedor = @Proveedor
         AND a.Estatus = 'ALTA'   
    END
  END 


  SELECT d.Articulo, a2.Sucursal AS Sucursal, a2.Almacen AS Almacen, Sum(d.Cantidad * d.Factor) AS Ventas, IsNull(ad.Disponible,0) AS Disponible    
    INTO #Ventas  
    FROM Venta v WITH(NOLOCK)        
    JOIN VentaD d WITH(NOLOCK) ON (v.ID = d.ID)        
    JOIN MovTipo mt ON v.Mov = mt.Mov  AND 'VTAS' = mt.Modulo
    JOIN Art a  WITH(NOLOCK) ON d.Articulo = a.Articulo
    JOIN Alm a2  WITH(NOLOCK) ON d.Almacen = a2.Almacen
    LEFT OUTER JOIN ArtDisponible ad WITH(NOLOCK) ON d.Articulo = ad.Articulo AND v.Almacen = ad.Almacen 
   WHERE mt.Clave IN ('VTAS.F', 'VTAS.N')  
     AND a.Estatus = 'ALTA'
     AND v.Estatus In ('CONCLUIDO','PROCESAR')         
     AND v.FechaEmision Between @FechaD And @FechaA
     AND v.Sucursal IN (SELECT Sucursal FROM SabanaFiltroSucursal WHERE Estacion = @Estacion)
     AND d.Articulo IN (SELECT Articulo FROM SabanaArt WHERE Estacion = @Estacion)
   GROUP BY d.Articulo, a2.Sucursal, a2.Almacen, ad.Disponible        

    IF @OperadorExistencia IS NOT NULL AND @OperadorVenta IS NOT NULL
      SELECT @SQL =' 
      INSERT SabanaVentas (Estacion, Articulo, Sucursal, Almacen, Disponible, Ventas, VentaOriginal)      
      SELECT ' + CONVERT(VARCHAR, @Estacion) + ', Articulo, Sucursal, Almacen, Disponible, SUM(Ventas), Ventas
        FROM #Ventas 
       WHERE ISNULL(Ventas, 0) ' + RTRIM(@OperadorVenta) + ' ' + CONVERT(VARCHAR, ISNULL(@Venta, 0)) + '
         AND ISNULL(Disponible, 0) ' + RTRIM(@OperadorExistencia) + ' ' + CONVERT(VARCHAR, ISNULL(@Existencia, 0)) + '
       GROUP BY Articulo, Sucursal, Almacen, Disponible, Ventas'
    ELSE IF @OperadorExistencia IS NULL AND @OperadorVenta IS NOT NULL
      SELECT @SQL =' 
      INSERT SabanaVentas (Estacion, Articulo, Sucursal, Almacen, Disponible, Ventas, VentaOriginal)      
      SELECT ' + CONVERT(VARCHAR, @Estacion) + ', Articulo, Sucursal, Almacen, Disponible, SUM(Ventas), Ventas
        FROM #Ventas 
       WHERE ISNULL(Ventas, 0) ' + RTRIM(@OperadorVenta) + ' ' + CONVERT(VARCHAR, ISNULL(@Venta, 0)) + '
       GROUP BY Articulo, Sucursal, Almacen, Disponible, Ventas'
    ELSE IF @OperadorExistencia IS NOT NULL AND @OperadorVenta IS NULL
      SELECT @SQL =' 
      INSERT SabanaVentas (Estacion, Articulo, Sucursal, Almacen, Disponible, Ventas, VentaOriginal)      
      SELECT ' + CONVERT(VARCHAR, @Estacion) + ', Articulo, Sucursal, Almacen, Disponible, SUM(Ventas), Ventas
        FROM #Ventas 
       WHERE ISNULL(Disponible, 0) ' + RTRIM(@OperadorExistencia) + ' ' + CONVERT(VARCHAR, ISNULL(@Existencia, 0)) + '
       GROUP BY Articulo, Sucursal, Almacen, Disponible, Ventas'
    ELSE IF @OperadorExistencia IS NULL AND @OperadorVenta IS NULL
      SELECT @SQL =' 
      INSERT SabanaVentas (Estacion, Articulo, Sucursal, Almacen, Disponible, Ventas, VentaOriginal)      
      SELECT ' + CONVERT(VARCHAR, @Estacion) + ', Articulo, Sucursal, Almacen, Disponible, SUM(Ventas), Ventas
        FROM #Ventas 
       GROUP BY Articulo, Sucursal, Almacen, Disponible, Ventas'

  EXEC(@SQL)
  
    --SELECT * FROM SabanaVentas WHERE Estacion = @Estacion
  
  INSERT SabanaVentasPaso(Estacion, Articulo, Sucursal, Almacen, Ventas, Disponible, VentaOriginal)
   SELECT DISTINCT @Estacion, s.Articulo, a.Sucursal, a.Almacen, 0, 0, 0
     FROM SabanaArt s WITH(NOLOCK)
     LEFT OUTER JOIN Alm a ON 1= 1
   WHERE Estacion = @Estacion
     AND a.Sucursal IN (SELECT Sucursal FROM SabanaFiltroSucursal WHERE Estacion = @Estacion)
   
  SELECT @SQL = NULL 
  
    IF @OperadorExistencia IS NOT NULL AND @OperadorVenta IS NOT NULL
      SELECT @SQL =' 
      INSERT SabanaVentas (Estacion, Articulo, Sucursal, Almacen, Ventas, VentaOriginal, Disponible)      
      SELECT ' + CONVERT(VARCHAR, @Estacion) + ', gp.Articulo, gp.Sucursal, gp.Almacen, 0, 0, ad.Disponible
        FROM SabanaVentasPaso gp WITH(NOLOCK)
        LEFT OUTER JOIN SabanaVentas g  WITH(NOLOCK) ON gp.Estacion = g.Estacion AND gp.Articulo = g.Articulo AND gp.Sucursal = g.Sucursal
        LEFT OUTER JOIN ArtDisponible ad WITH(NOLOCK) ON gp.Articulo = ad.Articulo AND gp.Almacen = ad.Almacen  
       WHERE gp.Estacion = ' + CONVERT(VARCHAR, ISNULL(@Estacion, 0)) + '
         AND g.Articulo IS NULL AND ISNULL(gp.Ventas, 0) ' + RTRIM(@OperadorVenta) + ' ' + CONVERT(VARCHAR, ISNULL(@Venta, 0)) + '
         AND ISNULL(ad.Disponible, 0) ' + RTRIM(@OperadorExistencia) + ' ' + CONVERT(VARCHAR, ISNULL(@Existencia, 0)) + '
       GROUP BY gp.Articulo, gp.Sucursal, gp.Almacen, ad.Disponible'
    IF @OperadorExistencia IS NULL AND @OperadorVenta IS NOT NULL
      SELECT @SQL =' 
      INSERT SabanaVentas (Estacion, Articulo, Sucursal, Almacen, Ventas, VentaOriginal, Disponible)     
      SELECT ' + CONVERT(VARCHAR, @Estacion) + ', gp.Articulo, gp.Sucursal, gp.Almacen, 0, 0, ad.Disponible
        FROM SabanaVentasPaso gp WITH(NOLOCK)
        LEFT OUTER JOIN SabanaVentas g WITH(NOLOCK) ON gp.Estacion = g.Estacion AND gp.Articulo = g.Articulo AND gp.Sucursal = g.Sucursal
        LEFT OUTER JOIN ArtDisponible ad WITH(NOLOCK) ON gp.Articulo = ad.Articulo AND gp.Almacen = ad.Almacen  
       WHERE gp.Estacion = ' + CONVERT(VARCHAR, ISNULL(@Estacion, 0)) + '
         AND g.Articulo IS NULL AND ISNULL(gp.Ventas, 0) ' + RTRIM(@OperadorVenta) + ' ' + CONVERT(VARCHAR, ISNULL(@Venta, 0)) + '
       GROUP BY gp.Articulo, gp.Sucursal, gp.Almacen, ad.Disponible'
    IF @OperadorExistencia IS NOT NULL AND @OperadorVenta IS NULL
      SELECT @SQL =' 
      INSERT SabanaVentas (Estacion, Articulo, Sucursal, Almacen, Ventas, VentaOriginal, Disponible)      
      SELECT ' + CONVERT(VARCHAR, @Estacion) + ', gp.Articulo, gp.Sucursal, gp.Almacen, 0, 0, ad.Disponible
        FROM SabanaVentasPaso gp WITH(NOLOCK)
        LEFT OUTER JOIN SabanaVentas g  WITH(NOLOCK) ON gp.Estacion = g.Estacion AND gp.Articulo = g.Articulo AND gp.Sucursal = g.Sucursal
        LEFT OUTER JOIN ArtDisponible ad WITH(NOLOCK) ON gp.Articulo = ad.Articulo AND gp.Almacen = ad.Almacen  
       WHERE gp.Estacion = ' + CONVERT(VARCHAR, ISNULL(@Estacion, 0)) + '
         AND g.Articulo IS NULL AND ISNULL(ad.Disponible, 0) ' + RTRIM(@OperadorExistencia) + ' ' + CONVERT(VARCHAR, ISNULL(@Existencia, 0)) + '
       GROUP BY gp.Articulo, gp.Sucursal, gp.Almacen, ad.Disponible'
    IF @OperadorExistencia IS NULL AND @OperadorVenta IS NULL
      SELECT @SQL =' 
      INSERT SabanaVentas (Estacion, Articulo, Sucursal, Almacen, Ventas, VentaOriginal, Disponible)   
      SELECT ' + CONVERT(VARCHAR, @Estacion) + ', gp.Articulo, gp.Sucursal, gp.Almacen, 0, 0, ad.Disponible
        FROM SabanaVentasPaso gp WITH(NOLOCK)
        LEFT OUTER JOIN SabanaVentas g  WITH(NOLOCK) ON gp.Estacion = g.Estacion AND gp.Articulo = g.Articulo AND gp.Sucursal = g.Sucursal
        LEFT OUTER JOIN ArtDisponible ad WITH(NOLOCK) ON gp.Articulo = ad.Articulo AND gp.Almacen = ad.Almacen  
      WHERE gp.Estacion = ' + CONVERT(VARCHAR, ISNULL(@Estacion, 0)) + '
        AND g.Articulo IS NULL
       GROUP BY gp.Articulo, gp.Sucursal, gp.Almacen, ad.Disponible'

  EXEC(@SQL)
      
  INSERT SabanaTransito(Estacion, Articulo, Almacen, Transito)
  SELECT @Estacion, SKU, Almacen, SUM(InventarioUnidades) 
    FROM vsTransito2  WITH(NOLOCK)
  WHERE SKU IN (SELECT Articulo FROM SabanaArt WHERE Estacion = @Estacion)
   GROUP BY SKU, Almacen 
   --ORDER BY SKU, CodigoTienda

  UPDATE SabanaVentas SET PrimeraCompra = dbo.fnFechaPrimeraCompra(Articulo, Almacen) WHERE Estacion = @Estacion
  UPDATE SabanaVentas SET UltimaCompra = dbo.fnFechaUltimaCompra(Articulo, Almacen) WHERE Estacion = @Estacion
    
  UPDATE SabanaVentas SET Factor = ROUND(DATEDIFF(dd, PrimeraCompra, @FechaA) / 30, 0) WHERE Estacion = @Estacion
  UPDATE SabanaVentas SET Factor=1 WHERE Factor=0
  UPDATE SabanaVentas SET Ventas = ROUND(Ventas/Factor, 0) WHERE Estacion = @Estacion
    
  UPDATE a
     SET a.Transito = ISNULL(b.Transito, 0)
    FROM SabanaVentas a
    LEFT OUTER JOIN SabanaTransito b ON a.Articulo = b.Articulo AND a.Almacen = b.Almacen AND a.Estacion = b.Estacion
  WHERE a.Estacion = @Estacion

  INSERT SabanaCompras(Estacion, Articulo, Almacen, Compras)
  SELECT @Estacion, SKU, Almacen, SUM(InventarioUnidades) 
    FROM vsCompras  WITH(NOLOCK)
  WHERE SKU IN (SELECT Articulo FROM SabanaArt WHERE Estacion = @Estacion)
   GROUP BY SKU, Almacen 
   --ORDER BY SKU, CodigoTienda
   
  UPDATE a
     SET a.Compras = ISNULL(b.Compras, 0)
    FROM SabanaVentas a
    LEFT OUTER JOIN SabanaCompras b ON a.Articulo = b.Articulo AND a.Almacen = b.Almacen AND a.Estacion = b.Estacion
    WHERE a.Estacion = @Estacion
    
  INSERT SabanaDevoluciones(Estacion, Articulo, Almacen, Devoluciones)
  SELECT @Estacion, SKU, Almacen, SUM(InventarioUnidades) 
    FROM vsDevoluciones  WITH(NOLOCK)
   WHERE FechaTransaccion BETWEEN @FechaD And @FechaA
     AND SKU IN (SELECT Articulo FROM SabanaArt WHERE Estacion = @Estacion)
   GROUP BY SKU, Almacen 
   --ORDER BY SKU, CodigoTienda
    
  INSERT SabanaTraspasoP(Estacion, Articulo, Almacen, Traspaso)
  SELECT @Estacion, SKU, Almacen, SUM(InventarioUnidades) 
    FROM vsTraspaso  WITH(NOLOCK)
   WHERE SKU IN (SELECT Articulo FROM SabanaArt WHERE Estacion = @Estacion)
   GROUP BY SKU, Almacen 
   --ORDER BY SKU, CodigoTienda
   
  UPDATE a
     SET a.Traspaso = ISNULL(b.Traspaso, 0)
    FROM SabanaVentas a
    LEFT OUTER JOIN SabanaTraspasoP b ON a.Articulo = b.Articulo AND a.Almacen = b.Almacen AND a.Estacion = b.Estacion
    WHERE a.Estacion = @Estacion


  UPDATE SabanaVentas SET DisponibleOriginal = Disponible  WHERE Estacion = @Estacion
    
  --UPDATE a
  --   SET a.Disponible = a.Disponible + ISNULL(b.Transito, 0), a.Diferencia = a.Diferencia + ISNULL(b.Transito, 0)
  --  FROM SabanaVentas a
  --  LEFT OUTER JOIN SabanaTransito b ON a.Articulo = b.Articulo AND a.Sucursal = b.Sucursal
  --  WHERE a.Estacion = @Estacion
  
  UPDATE a
    SET a.Diferencia = b.CantidadOriginal
   FROM SabanaVentas a
   LEFT OUTER JOIN PlanArtOP b ON a.Articulo = b.Articulo AND a.Almacen = b.Almacen
  WHERE a.Estacion = @Estacion
    AND b.Accion = 'Comprar'
    
    
--  SELECT * FROM SabanaVentas WHERE Articulo = '9786071708021'
    INSERT SabanaD(Estacion, Proveedor, Articulo, Sucursal, Almacen, PrimeraEntrada, UltimaEntrada, Venta, Existencia, Transito, Devuelto, Ordenado, TraspasoP, Sugerido, CantidadComprar) 
    SELECT @Estacion, @Proveedor, Articulo, Sucursal, Almacen, PrimeraCompra, UltimaCompra, VentaOriginal, ISNULL(DisponibleOriginal, 0), Transito, Devoluciones, Compras, Traspaso, Diferencia, 0
      FROM SabanaVentas  WITH(NOLOCK) WHERE ISNULL(Diferencia, 0) < 0 AND Estacion = @Estacion

    INSERT SabanaD(Estacion, Proveedor,  Articulo, Sucursal, Almacen, PrimeraEntrada, UltimaEntrada, Venta, Existencia, Transito, Devuelto, Ordenado, TraspasoP, Sugerido, CantidadComprar) 
    SELECT @Estacion, @Proveedor, Articulo, Sucursal, Almacen, PrimeraCompra, UltimaCompra, VentaOriginal, ISNULL(DisponibleOriginal, 0), Transito, Devoluciones, Compras, Traspaso, Diferencia, 0
      FROM SabanaVentas  WITH(NOLOCK) WHERE ISNULL(Diferencia, 0) >= 0 AND Estacion = @Estacion
    
    INSERT Sabana(Estacion, Articulo, VentaTotal, ExistenciaTotal, Proveedor, Grupo, FechaD, FechaA, UltimaEntrada)
      SELECT @Estacion, Articulo, SUM(Venta), SUM(Existencia), @Proveedor, @SucursalGrupo, @FechaD, @FechaA, MAX(UltimaEntrada)
      FROM SabanaD WITH(NOLOCK)
    WHERE Estacion = @Estacion
    GROUP BY Articulo
    
  UPDATE a
     SET a.ID = b.ID
    FROM SabanaD a
    LEFT OUTER JOIN Sabana b ON a.Articulo = b.Articulo AND a.Estacion = b.Estacion
    WHERE a.Estacion = @Estacion;

  WITH Orden (ID, RID) AS
  (
    SELECT
        ID
        , ROW_NUMBER() OVER (ORDER BY VentaTotal DESC, Articulo ASC) As [RID]
    FROM
        Sabana WHERE Estacion = @Estacion
  )

  UPDATE s
  SET Orden = t.RID
  FROM
    Orden t
    INNER JOIN
    Sabana As s
    On t.ID = s.ID
           
 END
GO

/**************** spSabanaTraspaso ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSabanaTraspaso') and type = 'P') drop procedure dbo.spSabanaTraspaso
GO
CREATE PROCEDURE spSabanaTraspaso
        @Estacion           INT,
        @Articulo           VARCHAR(20),
        @Sucursal           INT,
        @Almacen            VARCHAR(10)
--//WITH ENCRYPTION
AS 
BEGIN
  
  IF NOT EXISTS(SELECT * FROM SabanaTraspaso WHERE Estacion = @Estacion AND Articulo = @Articulo AND Sucursal = @Sucursal AND Almacen = @Almacen)
    INSERT SabanaTraspaso(Estacion, Articulo, Sucursal, Almacen, AlmacenDestino, SucursalDestino, PrimeraEntrada, UltimaEntrada, Venta, Existencia, Transito, Ordenado, SugeridoTraspaso, CantidadTraspasar)
      SELECT @Estacion, @Articulo, @Sucursal, @Almacen, gsd.Almacen, gsd.Sucursal, gsd.PrimeraEntrada, gsd.UltimaEntrada, gsd.Venta, gsd.Existencia, gsd.Transito, gsd.Ordenado, 0, 0
        FROM SabanaD gsd
      WHERE gsd.Estacion = @Estacion
      AND gsd.Articulo = @Articulo AND gsd.Almacen <> @Almacen


END 
GO

/**************** spSabanaLiberar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSabanaLiberar') and type = 'P') drop procedure dbo.spSabanaLiberar
GO
CREATE PROCEDURE spSabanaLiberar  
        @Sucursal               INT,  
        @Empresa                CHAR(5),  
        @Usuario                CHAR(10),  
        @Estacion               INT,  
        @Tipo                   INT  
--//WITH ENCRYPTION  
AS BEGIN   
  DECLARE  
    @Conteo            int,  
    @Modulo            char(5),  
    @Accion            char(20),  
    @Estatus            char(15),  
    @CompraMov            char(20),  
    @OrdenTransferencia     char(20),  
    @OrdenTraspaso        char(20),  
    @ID                int,  
    @Mov            char(20),  
    @MovID            varchar(20),  
    @Renglon            float,  
    @RenglonID            int,  
    @RenglonTipo        char(1),  
    @Articulo            char(20),  
    @Almacen            char(10),  
    @SucursalDestino        int,  
    @AlmacenDestino        char(10),  
    @FechaRegistro        datetime,  
    @FechaEmision        datetime,  
    @FechaEntrega        datetime,  
    @FechaEntregaEncabezado    datetime,  
    @MovMoneda            char(10),  
    @MovTipoCambio        float,  
    @MovZonaImpuesto        varchar(30),  
    @Cantidad            float,  
    @CantidadInventario        float,  
    @CantidadOrden        float,  
    @Unidad            varchar(50),  
    @Ruta            varchar(20),  
    @Proveedor            char(10),  
    @ArtTipo            char(20),  
    @ArtImpuesto1        float,  
    @ArtImpuesto2        float,  
    @ArtImpuesto3        money,  
    @ArtRetencion1        float,  
    @ArtRetencion2        float,  
    @ArtRetencion3        float,  
    @Moneda            char(10),  
    @TipoCambio            float,  
    @AutoReservar        bit,  
    @IDGenerar            int,  
    @ContID            int,  
    @Ok                int,  
    @OkRef            varchar(255),  
    @VolverAfectar        int,  
    @UltProv            char(10),  
    @UltRuta            varchar(20),  
    @UltAlmacen            char(10),  
    @UltAlmacenDestino        char(10),  
    @AfectarOrdenesDistribucion bit,  
    @CfgCompraCostoSugerido      char(20),  
    @CfgMultiUnidades        bit,  
    @CfgMultiUnidadesNivel    char(20),  
    @PlanLiberarCompra        char(30),  
    @PlanLiberarProduccion    char(30),  
    @PlanLiberarDistribucion    char(30),   
    @PlanUnidadDistribucion    varchar(20),  
    @Costo            money,  
    @PlanEditarOrdenes        bit,  
    @CompraMultiAlmacen        bit,  
    @CfgBackOrders        bit,   
    @VerDestino            bit,  
    @VentaID            int,  
    @VentaMov            varchar(20),  
    @VentaMovID            varchar(20),  
    @InvID            int,  
    @InvMov            varchar(20),  
    @InvMovID            varchar(20),  
    @DestinoTipo        varchar(10),  
    @Destino            varchar(20),  
    @DestinoID            varchar(20),  
    @ReferenciaProyecto        varchar(50),  
    @DescuentoProveedor     money,  
    @GandhiCategoria        varchar(50),  
    @CategoriaArticulo      varchar(50),  
    @UltCategoria           varchar(50),  
    @ArticuloError          varchar(20),  
    @ArtImpuesto1Ultimo     float,  
    @DescuentoProveedorUltimo  FLOAT,  
    @Disponible                 FLOAT,  
    @GandhiObservacion          VARCHAR(100),  
    @GandhiObservacionT          VARCHAR(100),  
    @GandhiFechaRequerida       DATETIME,  
    @GandhiPlanFechaEntrega     DATETIME,  
    @GandhiPlanRecepcion        VARCHAR(255),  
    @GandhiPlanVenta            VARCHAR(255),  
    @GandhiPlanProveedor        VARCHAR(255),  
    @GandhiPlanContabilidad     VARCHAR(255),  
    @MensajeGrises              VARCHAR(255),  
    @GandhiPlanCondicion        VARCHAR(50),  
    @GandhiPlanEstatus          VARCHAR(30),
    @LiveTime                   DATETIME,
    @TiempoE                    DATETIME  
  
  SELECT @FechaRegistro    = GETDATE(), @Conteo = 0, @AutoReservar = 0, @Ok = NULL, @OkRef = NULL, @PlanEditarOrdenes = 0, @VerDestino = 0, @MensajeGrises = ''  
  
  SELECT @FechaEmision = @FechaRegistro  
  EXEC spExtraerFecha @FechaEmision OUTPUT  
  
  SELECT @CompraMov          = CompraOrden,  
         @OrdenTransferencia = InvOrdenTransferencia,  
         @OrdenTraspaso      = InvOrdenTraspaso  
    FROM EmpresaCfgMov  
   WHERE Empresa = @Empresa  
  
  IF (SELECT ISNULL(PlanEditarOrdenes, 0) FROM UsuarioCfg2 WHERE Usuario = @Usuario) = 1  
    SELECT @CompraMov               = ISNULL(NULLIF(RTRIM(PlanOrdenCompra), ''), @CompraMov),  
           @OrdenTransferencia      = ISNULL(NULLIF(RTRIM(PlanOrdenTransferencia), ''), @OrdenTransferencia),  
           @OrdenTraspaso           = ISNULL(NULLIF(RTRIM(PlanOrdenTraspaso), ''), @OrdenTraspaso)
      FROM UsuarioCfg2
     WHERE Usuario = @Usuario  
  
  SELECT @Moneda = m.Moneda,   
         @TipoCambio = m.TipoCambio,  
         @CfgCompraCostoSugerido = cfg.CompraCostoSugerido,  
         @CfgBackOrders    = cfg.BackOrders    
    FROM EmpresaCfg cfg, Mon m  
   WHERE Empresa = @Empresa AND m.Moneda = cfg.ContMoneda  
  
  SELECT @AutoReservar              = ProdAutoReservar,  
         @AfectarOrdenesDistribucion = PlanAfectarOrdenesDistribucion,  
         @CfgMultiUnidades           = MultiUnidades,  
         @CfgMultiUnidadesNivel      = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'),  
         @PlanLiberarCompra         = ISNULL(UPPER(PlanLiberarCompra),    'ORDEN POR PROVEEDOR'),  
         @PlanLiberarProduccion         = ISNULL(UPPER(PlanLiberarProduccion), 'ORDEN POR SELECCION'),  
         @PlanLiberarDistribucion    = ISNULL(UPPER(PlanLiberarDistribucion), 'ORDEN POR ALMACEN'),  
         @PlanUnidadDistribucion     = ISNULL(UPPER(PlanUnidadDistribucion), 'COMPRA/PRODUCCION'),  
         @CompraMultiAlmacen         = CompraMultiAlmacen  
    FROM EmpresaCfg2   
   WHERE Empresa = @Empresa  
  
  BEGIN TRANSACTION  
  
    /********** Ordenes Compra **********/  
    IF @Tipo IN (1, 3)  
    BEGIN  
    SELECT @Mov = @CompraMov, @ID = NULL, @UltAlmacen = NULL, @Modulo = 'COMS', @UltProv = NULL, @Accion = 'CONSECUTIVO', @Estatus = 'CONFIRMAR'  
          
    DECLARE crLiberarProd CURSOR FOR   
     SELECT NULLIF(p.Sucursal, @Sucursal), p.Articulo, NULLIF(RTRIM(p.Almacen), ''), ISNULL(p.CantidadComprar, 0.0), a.UnidadCompra, NULLIF(RTRIM(p.Proveedor), ''), a.Tipo, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Retencion1, a.Retencion2, a.Retencion3
       FROM SabanaD p  
       JOIN Art a ON p.Articulo = a.Articulo  
     WHERE p.Estacion = @Estacion AND ISNULL(p.CantidadComprar, 0.0) > 0.0 
      ORDER BY p.Proveedor, p.Almacen, p.Articulo, p.CantidadComprar  
  
    OPEN crLiberarProd  
    FETCH NEXT FROM crLiberarProd INTO @SucursalDestino, @Articulo, @Almacen, @Cantidad, @Unidad, @Proveedor, @ArtTipo, @ArtImpuesto1, @ArtImpuesto2, @ArtImpuesto3, @ArtRetencion1, @ArtRetencion2, @ArtRetencion3
    WHILE @@FETCH_STATUS <> -1  AND @Ok IS NULL  
    BEGIN  
      IF @@FETCH_STATUS <> -2   
      BEGIN  
  
        IF @ID IS NULL OR @UltProv <> @Proveedor OR @PlanLiberarCompra = 'ORDEN POR RENGLON' OR (@UltAlmacen <> @Almacen AND @CompraMultiAlmacen = 0) 
        BEGIN  
          IF @Almacen IS NULL SELECT @Ok = 20820, @OkRef = @Articulo  
          IF @ID IS NOT NULL  
          BEGIN  
            UPDATE Compra SET RenglonID = @RenglonID WHERE ID = @ID   
            EXEC spInv @ID, @Modulo, @Accion, 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,   
                       @Mov, @MovID OUTPUT, @IDGenerar, @ContID, @Ok, @OkRef, @VolverAfectar  
            IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL  
            IF ISNULL(@GandhiPlanEstatus,'CONFIRMAR')='PENDIENTE'  
            BEGIN  
             EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'TODO', NULL,@Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT    
             IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL  
            END  
  
          END  
     
          SELECT @Moneda = ISNULL(NULLIF(DefMoneda, ''), 'Pesos') FROM Prov WHERE Proveedor = @Proveedor  
          SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda  
   
          INSERT Compra (Sucursal,  OrigenTipo, Empresa,  Usuario,  Estatus,  Mov,  FechaEmision,  Moneda,  TipoCambio,   Proveedor, Almacen,  Prioridad,   
                         Observaciones,      VerDestino,  FechaRequerida,         Proyecto,            Concepto)  
                 VALUES (@Sucursal, 'PLAN',     @Empresa, @Usuario, @Estatus, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Proveedor, @Almacen, 'Normal',    
                         @GandhiObservacion, @VerDestino, @GandhiFechaRequerida,  @ReferenciaProyecto, @CategoriaArticulo)  
  
          SELECT @ID = SCOPE_IDENTITY(), @Renglon = 0.0, @RenglonID = 0, @Conteo = @Conteo + 1  
  
          IF @Proveedor IS NOT NULL  
            UPDATE Compra   
               SET Proyecto     = ISNULL(c.Proyecto,p.Proyecto),   
                   FormaEnvio   = p.FormaEnvio,   
                   Agente       = p.Agente,   
                   Condicion    = ISNULL(NULLIF(@GandhiPlanCondicion, ''), p.Condicion),   
                   ZonaImpuesto = p.ZonaImpuesto,   
                   Idioma       = p.Idioma,  
                   Moneda       = m.Moneda,  
                   TipoCambio   = m.TipoCambio  
              FROM Compra c  
              JOIN Prov p ON c.Proveedor = p.Proveedor  
              JOIN Mon m ON c.Moneda = m.Moneda  
             WHERE c.ID = @ID AND p.Proveedor = @Proveedor AND m.Moneda = ISNULL(p.DefMoneda, @Moneda)  
  
          SELECT @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, @MovZonaImpuesto = ZonaImpuesto FROM Compra WHERE ID = @ID  
          SELECT @UltProv = @Proveedor, @UltAlmacen = @Almacen
        END  
  
        EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT  
        EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT  
        EXEC spZonaImp @MovZonaImpuesto, @ArtImpuesto1 OUTPUT  
        EXEC spZonaImp @MovZonaImpuesto, @ArtImpuesto2 OUTPUT  
        EXEC spZonaImp @MovZonaImpuesto, @ArtImpuesto3 OUTPUT  
        EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Contacto = @Proveedor, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @ArtImpuesto1 OUTPUT, @Impuesto2 = @ArtImpuesto2 OUTPUT, @Impuesto3 = @ArtImpuesto3 OUTPUT  
          
        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1  
        SELECT @CantidadOrden = ROUND(@Cantidad / (@CantidadInventario / @Cantidad), 4), @CantidadInventario = @Cantidad  
        EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, NULL, @Unidad, @CfgCompraCostoSugerido, @MovMoneda, @MovTipoCambio, @Costo OUTPUT, 0  
  
        SELECT @DestinoTipo = NULL, @Destino = NULL, @DestinoID = NULL            
  
        INSERT CompraD (Sucursal, ID, Renglon,   RenglonSub, RenglonID,  RenglonTipo,  Articulo,  SubCuenta,   Almacen,  Cantidad,       Unidad,  CantidadInventario,  Costo,  FechaEntrega,  FechaRequerida, Impuesto1,     Impuesto2,     Impuesto3,     Retencion1,     Retencion2,     Retencion3,     DestinoTipo,  Destino,  DestinoID)  
                VALUES (@Sucursal, @ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Articulo, NULL, @Almacen, @CantidadOrden, @Unidad, @CantidadInventario, @Costo, @FechaEntrega, @FechaEntrega,  @ArtImpuesto1, @ArtImpuesto2, @ArtImpuesto3, @ArtRetencion1, @ArtRetencion2, @ArtRetencion3, @DestinoTipo, @Destino, @DestinoID)  
  
      END  
      FETCH NEXT FROM crLiberarProd INTO @SucursalDestino, @Articulo, @Almacen, @Cantidad, @Unidad, @Proveedor, @ArtTipo, @ArtImpuesto1, @ArtImpuesto2, @ArtImpuesto3, @ArtRetencion1, @ArtRetencion2, @ArtRetencion3
    END  
    CLOSE crLiberarProd  
    DEALLOCATE crLiberarProd  
  
    IF @ID IS NOT NULL  
    BEGIN  
  
      UPDATE Compra SET RenglonID = @RenglonID WHERE ID = @ID   
      EXEC spInv @ID, @Modulo, @Accion, 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,  
                 @Mov, @MovID OUTPUT, @IDGenerar, @ContID, @Ok, @OkRef, @VolverAfectar                
      IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL  
      IF ISNULL(@GandhiPlanEstatus,'CONFIRMAR')='PENDIENTE'  
            BEGIN  
             EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'TODO', NULL,@Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT    
             IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL  
            END  
    END  
      
      DELETE FROM SabanaD  
       WHERE Estacion = @Estacion AND ISNULL(CantidadComprar, 0.0) > 0.0 AND Traspaso = 'No'  
         
      UPDATE SabanaD SET CantidadComprar = 0 WHERE Estacion = @Estacion AND ISNULL(CantidadComprar, 0.0) > 0.0 AND Traspaso = 'Si'  
    END  
  
    /********** Ordenes Distribucion **********/  
    IF @Tipo IN (2, 3)  
    BEGIN  
       
    SELECT @ID = NULL, @UltAlmacen = NULL, @UltAlmacenDestino = NULL, @Modulo = 'INV'  
    --IF @AfectarOrdenesDistribucion = 1   
      SELECT @Accion = 'AFECTAR'
     -- IF @GandhiPlanEstatus='CONFIRMAR'
     --   SET @Estatus = 'CONFIRMAR'
     --  ELSE
        SET @Estatus = 'SINAFECTAR'   
    --ELSE SELECT @Accion = 'CONSECUTIVO', @Estatus = 'CONFIRMAR'  
    DECLARE crLiberarProd CURSOR FOR   
     SELECT NULLIF(p.Sucursal, @Sucursal), p.Articulo, NULLIF(RTRIM(t.Almacen), ''), NULLIF(RTRIM(t.AlmacenDestino), ''), ISNULL(t.CantidadTraspasar, 0.0), CASE @PlanUnidadDistribucion WHEN 'VENTA' THEN a.Unidad WHEN 'TRASPASO' THEN ISNULL(a.UnidadTraspaso, a.UnidadCompra) ELSE a.UnidadCompra END, a.Tipo  
       FROM SabanaD p  
       JOIN SabanaTraspaso t ON p.Estacion = t.Estacion AND p.Articulo = t.Articulo AND p.Sucursal = t.Sucursal  
       JOIN Art a ON p.Articulo = a.Articulo  
       JOIN ArtProv p2 ON p.Proveedor = p2.Proveedor AND p.Articulo = p2.Articulo  
      WHERE p.Estacion = @Estacion AND p.Traspaso = 'SI' AND ISNULL(t.CantidadTraspasar, 0.0) > 0.0  
      ORDER BY p.Almacen, t.AlmacenDestino, a.Categoria, a.Familia, p.Articulo, t.CantidadTraspasar   
  
    OPEN crLiberarProd  
    FETCH NEXT FROM crLiberarProd INTO @SucursalDestino, @Articulo, @Almacen, @AlmacenDestino, @Cantidad, @Unidad, @ArtTipo  
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL  
    BEGIN  
      IF @@FETCH_STATUS <> -2   
      BEGIN  
        IF @UltAlmacen <> @Almacen OR @UltAlmacenDestino <> @AlmacenDestino OR @PlanLiberarDistribucion = 'ORDEN POR RENGLON'  
        BEGIN  
          IF @Almacen IS NULL SELECT @Ok = 20830, @OkRef = @Articulo  
          IF @AlmacenDestino IS NULL SELECT @Ok = 20840, @OkRef = @Articulo  
          IF @ID IS NOT NULL  
          BEGIN  
            UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @ID   
            --EXEC spInv @ID, @Modulo, @Accion, 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,   
            --           @Mov, @MovID OUTPUT, @IDGenerar, @ContID, @Ok, @OkRef, @VolverAfectar  
            --IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL  
            --  IF ISNULL(@GandhiPlanEstatus,'CONFIRMAR')='PENDIENTE'  
            --   BEGIN 
                EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'TODO', NULL,@Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT    
                IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL  
            --  END  
          END  
  
          IF (SELECT Sucursal FROM Alm WHERE Almacen = @Almacen) <> (SELECT Sucursal FROM Alm WHERE Almacen = @AlmacenDestino)  
            SELECT @Mov = @OrdenTraspaso  
          ELSE  
            SELECT @Mov = @OrdenTransferencia  
                       
          INSERT Inv (Sucursal,  OrigenTipo, Empresa,  Usuario,  Estatus,  Mov,  FechaEmision, FechaRequerida,                 Moneda,  TipoCambio,  Almacen,  AlmacenDestino,  Prioridad, Observaciones, Proyecto)  
          SELECT      @Sucursal, 'PLAN',     @Empresa, @Usuario, @Estatus, @Mov, @FechaEmision, @FechaEmision+15, @Moneda, @TipoCambio, @Almacen, @AlmacenDestino, 'Normal', 'Sabana de Compras', @ReferenciaProyecto  
          SELECT @ID = SCOPE_IDENTITY(), @Renglon = 0.0, @RenglonID = 0, @Conteo = @Conteo + 1  
          SELECT @UltAlmacen = @Almacen, @UltAlmacenDestino = @AlmacenDestino  
        END  
  
        SELECT @Disponible = 0  
          
        EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT  
        EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT  
        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1  
        SELECT @CantidadOrden = ROUND(@Cantidad / (@CantidadInventario / @Cantidad), 4), @CantidadInventario = @Cantidad  
        EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, NULL, @Unidad, @CfgCompraCostoSugerido, @MovMoneda, @MovTipoCambio, @Costo OUTPUT, 0  
  
        INSERT InvD (Sucursal,  ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Almacen,  Cantidad,       Unidad,  CantidadInventario, Costo)  
             VALUES (@Sucursal, @ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Articulo, NULL, @Almacen, @CantidadOrden, @Unidad, @CantidadInventario, @Costo)  
               
        UPDATE SabanaD SET Existencia = Existencia - @CantidadOrden WHERE Estacion = @Estacion AND Almacen = @Almacen AND Articulo = @Articulo  
  
      END  
      FETCH NEXT FROM crLiberarProd INTO @SucursalDestino, @Articulo, @Almacen, @AlmacenDestino, @Cantidad, @Unidad, @ArtTipo  
    END  
    CLOSE crLiberarProd  
    DEALLOCATE crLiberarProd  
  
    IF @ID IS NOT NULL  
    BEGIN  
      UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @ID   
      --EXEC spInv @ID, @Modulo, @Accion, 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,  
      --           @Mov, @MovID OUTPUT, @IDGenerar, @ContID, @Ok, @OkRef, @VolverAfectar  
      IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL  
     -- IF ISNULL(@GandhiPlanEstatus,'CONFIRMAR')='PENDIENTE'  
     --  BEGIN  
        EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'TODO', NULL,@Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT    
        IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL  
     --  END  
  
      DELETE FROM SabanaTraspaso   
       WHERE Estacion = @Estacion AND ISNULL(CantidadTraspasar, 0.0) > 0.0  
       
    END  
  
  END  
  
  IF @Ok IS NULL  
  BEGIN  
    COMMIT TRANSACTION  
    IF @Conteo = 1  
      SELECT 'Se Genero con Exito '+LTRIM(CONVERT(char, @Conteo))+' Orden. ' + @MensajeGrises  
    ELSE  
      SELECT 'Se Generaron con Exito '+LTRIM(CONVERT(char, @Conteo))+' Ordenes. ' + @MensajeGrises  
  END ELSE  
  BEGIN  
    ROLLBACK TRANSACTION  
    SELECT RTRIM(Descripcion)+' '+RTRIM(@OkRef) FROM MensajeLista WHERE Mensaje = @Ok    
  END  
  RETURN  
END  
GO



--EXEC spPlanArtSabana 0, 0
--SELECT * FROM SabanaD
--SELECT * FROM SabanaVentas gsv WHERE Estacion = 1