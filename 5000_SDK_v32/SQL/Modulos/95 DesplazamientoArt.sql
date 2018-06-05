SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/**************** spRecEmpresaNombre ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spRecEmpresaNombre' AND Type = 'P')  DROP PROCEDURE spRecEmpresaNombre
GO
CREATE PROCEDURE spRecEmpresaNombre
  @Empresa      varchar(5)
  --//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  IF EXISTS (SELECT TOP 1 Empresa FROM Empresa WHERE Empresa = @Empresa)
    BEGIN
      SELECT Nombre FROM Empresa WHERE Empresa = @Empresa
    END
END
GO

/**************** spRecArtInfoAdicional ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spRecArtInfoAdicional' AND Type = 'P')  DROP PROCEDURE spRecArtInfoAdicional
GO
CREATE PROCEDURE spRecArtInfoAdicional
  @Empresa      varchar(5),
  @Articulo     varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  IF EXISTS (SELECT TOP 1 Empresa FROM Empresa WHERE Empresa = @Empresa)
    BEGIN
      SELECT Datos
        FROM ArtInfoAdicional
       WHERE Articulo = @Articulo
       ORDER BY ID
    END
END
GO

/**************** spRecArtDescripcion ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spRecArtDescripcion' AND Type = 'P')  DROP PROCEDURE spRecArtDescripcion
GO
CREATE PROCEDURE spRecArtDescripcion
  @Empresa      varchar(5),
  @Articulo     varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  IF EXISTS (SELECT TOP 1 Empresa FROM Empresa WHERE Empresa = @Empresa)
    BEGIN
      SELECT LTRIM(RTRIM(Descripcion1))
        FROM Art
       WHERE Articulo = @Articulo
    END
END
GO

/**************** spRecArtRuta ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spRecArtRuta' AND Type = 'P')  DROP PROCEDURE spRecArtRuta
GO
CREATE PROCEDURE spRecArtRuta
  @Empresa      varchar(5),
  @Articulo     varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON

  DECLARE @Rama varchar(5)
  DECLARE @Tipo varchar(10)

  SET @Rama = 'INV'
  SET @Tipo = 'Imagen'

  IF EXISTS (SELECT TOP 1 Empresa FROM Empresa WHERE Empresa = @Empresa)
    BEGIN
      SELECT TOP 1 LTRIM(RTRIM(Direccion))
        FROM AnexoCta
       WHERE Rama = @Rama
         AND Tipo = @Tipo
         AND Cuenta = @Articulo
       ORDER BY Orden
    END
END
GO

/**************** spRecArtVenta ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spRecArtVenta' AND Type = 'P')  DROP PROCEDURE spRecArtVenta
GO
CREATE PROCEDURE spRecArtVenta
  @Empresa                   varchar(5),
  @Articulo                  varchar(20),
  @FechaDe                   datetime,
  @FechaA                    datetime,
  @PeriodoDesc               varchar(20)
--//WITH ENCRYPTION
AS BEGIN
SET NOCOUNT ON

DECLARE @Estatus             varchar(15)
DECLARE @Periodos            int
DECLARE @PrimerID            int
DECLARE @PrimerFecha         datetime
DECLARE @FechaT              datetime
DECLARE @Anio                int
DECLARE @Semana              int
DECLARE @AnioTmp             int
DECLARE @SemanaTmp           int
DECLARE @PrimerAnio          int
DECLARE @PrimerSemana        int
DECLARE @Cantidad            float
DECLARE @MaxID               int
DECLARE @idx                 int
DECLARE @b                   bit

DECLARE @Venta               table (Clave varchar(20) NULL)
DECLARE @VentaDev            table (Clave varchar(20) NULL)

DECLARE @TablaVenta table (
  VentaID                    int NULL,
  ID                         int IDENTITY (1, 1) NOT NULL,
  Fecha                      datetime NULL,
  Cantidad                   float NULL,
  Importe                    float NULL,
  Periodo                    varchar(10) NULL,
  Consecutivo                int NULL,
  DiaSemana                  int NULL,
  Semana                     int NULL,
  Mes                        int NULL,
  Bimestre                   int NULL,
  Trimestre                  int NULL,
  Cuatrimestre               int NULL,
  Semestre                   int NULL,
  Anio                       int NULL,
  DiaAnio                    int NULL
)

DECLARE @TablaDevolucion table (
  ID                         int IDENTITY (1, 1) NOT NULL,
  VentaID                    int NULL,
  Fecha                      datetime NULL,
  Cantidad                   float NULL,
  Importe                    float NULL,
  Semana                     int NULL,
  Mes                        int NULL,
  Anio                       int NULL
)

DECLARE @TablaResumen table (
  ID                         int IDENTITY (1, 1) NOT NULL,
  Consecutivo                int NULL,
  Cantidad                   float NULL,
  Importe                    float NULL,
  Anio                       int NULL,
  Semana                     int NULL,
  Mes                        int NULL,
  Bimestre                   int NULL,
  Trimestre                  int NULL,
  Cuatrimestre               int NULL,
  Semestre                   int NULL
)

DECLARE @TablaResultado table (
  Consecutivo                int IDENTITY (1, 1) NOT NULL,
  Cantidad                   float NULL,
  Importe                    float NULL,
  Anio                       int NULL,
  Semana                     int NULL
)

IF EXISTS (SELECT TOP 1 Empresa FROM Empresa WHERE Empresa = @Empresa)
  BEGIN

    IF @FechaDe > @FechaA
      BEGIN
        SET @FechaT  = @FechaDe
        SET @FechaDe = @FechaA
        SET @FechaA  = @FechaT
      END

    SET @FechaDe = DATEADD(second,-1,@FechaDe)
    SET @FechaA  = DATEADD(second,-1,@FechaA)
    SET @FechaA  = DATEADD(day,1,@FechaA)

    -- Claves afectacion ventas                         -- Movimientos
    INSERT INTO @Venta(Clave)       VALUES ('VTAS.F')   -- Factura - Factura Electrónica - Factura Logyx - Factura Logyx Calz. - Factura Matriz - Factura Matriz Calz. - Factura Sucursal CAN - Factura Sucursal COA - Factura Sucursal GDL - Factura Sucursal L - Factura Sucursal MTY - Factura Sucursal PN - Factura Sucursal VLL
    INSERT INTO @Venta(Clave)       VALUES ('VTAS.FM')  -- Factura Mostrador CO - Factura Mostrador L - Factura Mostrador PN - Factura MostradorCAN - Factura MostradorGDL - Factura MostradorMTY - Factura MostradorVLL
    INSERT INTO @Venta(Clave)       VALUES ('VTAS.FR')  -- Factura Recurrente
    INSERT INTO @VentaDev(Clave)    VALUES ('VTAS.D')   -- Cancelacion Factura - Devolucion Venta

    SET @Estatus = 'CONCLUIDO'
    SET @b = 0
    SET @PeriodoDesc = UPPER(LTRIM(RTRIM(@PeriodoDesc)))

    INSERT INTO @TablaVenta (VentaID,Fecha,Cantidad,Importe,DiaSemana,Semana,Mes,Anio,DiaAnio)
    SELECT v.ID,v.FechaEmision,ISNULL(d.Cantidad,0),ISNULL(d.Cantidad,0) * ISNULL(d.Precio,0.001),
           datepart(weekday,v.FechaEmision),
           datepart(week,v.FechaEmision),
           datepart(month,v.FechaEmision),
           datepart(year,v.FechaEmision),
           datepart(dayofyear,v.FechaEmision)
      FROM Venta v
      JOIN VentaD d ON(v.ID = d.ID)
      JOIN MovTipo m ON(v.Mov = m.Mov)
     WHERE v.Empresa      = @Empresa
       AND d.Articulo     = @Articulo
       AND v.Estatus      = @Estatus
       AND m.Clave IN (SELECT Clave FROM @Venta)
       AND v.FechaEmision BETWEEN @FechaDe AND @FechaA
    ORDER BY v.FechaEmision

    UPDATE @TablaVenta
    SET
        Bimestre     = CAST(((Mes + 1) / 2) AS INT),
        Trimestre    = CAST(((Mes + 2) / 3) AS INT),
        Cuatrimestre = CAST(((Mes + 3) / 4) AS INT),
        Semestre     = CAST(((Mes + 5) / 6) AS INT)

    SELECT @PrimerID = Min(ID) FROM @TablaVenta
    SET @PrimerID = ISNULL(@PrimerID,0)
    SELECT TOP 1 @PrimerAnio = Anio FROM @TablaVenta WHERE ID = @PrimerID
    SELECT TOP 1 @PrimerFecha = Fecha FROM @TablaVenta WHERE ID = @PrimerID
    SELECT TOP 1 @PrimerSemana = Semana FROM @TablaVenta WHERE ID = @PrimerID
    SET @Periodos = (ABS(DATEDIFF(DAY,@PrimerFecha,@FechaA)) / 7) + 2

    UPDATE @TablaVenta SET Consecutivo = (Semana - @PrimerSemana + 1) + ((Anio - @PrimerAnio) * 52)

    INSERT INTO @TablaResumen (Consecutivo,Anio,Semana,Cantidad,Importe)
    SELECT Consecutivo,Anio,Semana,SUM(Cantidad),SUM(Importe)
      FROM @TablaVenta
    GROUP BY Consecutivo,Semana,Anio

    SET @idx = 1
    WHILE @idx < @Periodos
      BEGIN
        INSERT INTO @TablaResultado (Cantidad,Importe) VALUES (0,0)
        SET @idx = @idx + 1
      END

    UPDATE @TablaResultado
       SET Anio = b.Anio, Semana = b.Semana , Cantidad = b.cAntidad, Importe = b.Importe
      FROM @TablaResultado a
     INNER JOIN
         @TablaResumen b
         ON a.Consecutivo = b.Consecutivo

    SELECT @idx = (MAX(Consecutivo) + 1) FROM @TablaResultado
    SET @b = 0

    WHILE @b = 0
      BEGIN
        SET @idx = @idx - 1
        IF EXISTS(SELECT TOP 1 Importe FROM @TablaResultado WHERE Importe = 0 AND Consecutivo = @idx)
          BEGIN
            DELETE @TablaResultado WHERE Consecutivo = @idx
          END
        ELSE
          BEGIN
            SET @b = 1
          END
        END

    SELECT @Anio = Anio FROM @TablaResultado WHERE Consecutivo = 1
    SELECT @Semana = Semana FROM @TablaResultado WHERE Consecutivo = 1
    SELECT @MaxID = MAX(Consecutivo) FROM @TablaResultado

    SET @idx = 2
    WHILE @idx < @MaxID
      BEGIN
        SELECT @AnioTmp = Anio FROM @TablaResultado WHERE Consecutivo = @idx
        SELECT @SemanaTmp = Semana FROM @TablaResultado WHERE Consecutivo = @idx

        SET @AnioTmp = ISNULL(@AnioTmp,0)
        SET @SemanaTmp = ISNULL(@SemanaTmp,0)

        IF @SemanaTmp = 0
          BEGIN
            SET @Semana = @Semana + 1
            IF @Semana > 52
              BEGIN
                SET @Semana = 1
                SET @Anio = @Anio + 1
              END
            UPDATE @TablaResultado SET Anio = @Anio, Semana = @Semana WHERE Consecutivo = @idx
          END
        ELSE
          BEGIN
            SELECT @Anio = Anio FROM @TablaResultado WHERE Consecutivo = @idx
            SELECT @Semana = Semana FROM @TablaResultado WHERE Consecutivo = @idx
          END

        SET @idx  = @idx + 1
      END

    INSERT INTO @TablaDevolucion (VentaID,Fecha,Cantidad,Importe,Semana,Mes,Anio)
     SELECT v.ID,v.FechaEmision,
            ISNULL(d.Cantidad,0),
            ISNULL(d.Cantidad,0) * ISNULL(d.Precio,0.001),
            datepart(week,v.FechaEmision),
            datepart(month,v.FechaEmision),
            datepart(year,v.FechaEmision)
       FROM Venta v
       JOIN VentaD d ON(v.ID = d.ID)
       JOIN MovTipo m ON(v.Mov = m.Mov)
      WHERE v.Empresa      = @Empresa
        AND d.Articulo     = @Articulo
        AND v.Estatus      = @Estatus
        AND m.Clave IN (SELECT Clave FROM @VentaDev)
        AND v.FechaEmision BETWEEN @FechaDe AND @FechaA
     ORDER BY v.FechaEmision

    DECLARE spRecArtVenta_01_cursor CURSOR FOR
      SELECT Anio,Semana,SUM(Cantidad)
        FROM @TablaDevolucion
      GROUP BY Anio,Semana

    OPEN spRecArtVenta_01_cursor
    FETCH NEXT FROM spRecArtVenta_01_cursor INTO @Anio,@Semana,@Cantidad
    WHILE @@FETCH_STATUS = 0
      BEGIN
        UPDATE @TablaResultado
           SET Cantidad = ISNULL(Cantidad,0) - ISNULL(@Cantidad,0)
        WHERE Anio = @Anio AND Semana = @Semana
        FETCH NEXT FROM spRecArtVenta_01_cursor INTO @Anio,@Semana,@Cantidad
      END
    CLOSE spRecArtVenta_01_cursor
    DEALLOCATE spRecArtVenta_01_cursor

   SELECT Consecutivo,Anio,Semana,Cantidad FROM @TablaResultado ORDER BY Consecutivo
  END
END
GO

/**************** spRecArtInfo ****************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spRecArtInfo' AND Type = 'P')  DROP PROCEDURE spRecArtInfo
GO
CREATE PROCEDURE spRecArtInfo
  @Empresa      varchar(5),
  @Articulo     varchar(20)
--//WITH ENCRYPTION
AS BEGIN
SET NOCOUNT ON
IF EXISTS (SELECT TOP 1 Empresa FROM Empresa WHERE Empresa = @Empresa)
BEGIN
  DECLARE @Concepto               varchar(255)
  DECLARE @Valor                  varchar(255)

  DECLARE @CompraID               int
  DECLARE @CompraDevID            int
  DECLARE @CompraCantidad		  float
  DECLARE @VentaID                int
  DECLARE @VentaDevID             int

  DECLARE @CompraMov              varchar(20)
  DECLARE @CompraMovID            varchar(20)
  DECLARE @CompraDevMov           varchar(20)
  DECLARE @CompraDevMovID         varchar(20)
  DECLARE @VentaMov               varchar(20)
  DECLARE @VentaMovID             varchar(20)
  DECLARE @VentaDevMov            varchar(20)
  DECLARE @VentaDevMovID          varchar(20)

  DECLARE @FechaCompra            datetime
  DECLARE @FechaPrimerVenta       datetime
  DECLARE @FechaUltimaVenta       datetime

  DECLARE @Moneda                 varchar(20)
  DECLARE @TipoCambio             float
  DECLARE @Proveedor              varchar(10)

  DECLARE @Almacen                varchar(10)
  DECLARE @Sucursal               int
  DECLARE @Cantidad               float

  DECLARE @CostoPromedio          float
  DECLARE @PrecioCosto            float
  DECLARE @PrecioPublico          float
  DECLARE @Margen                 float

  DECLARE @AlmacenPrincipal       varchar(10)
  DECLARE @InventarioBodegas      float
  DECLARE @InventarioTiendas      float

  DECLARE @Estatus                varchar(15)

  DECLARE @Compra                 table (Clave varchar(20) NULL)
  DECLARE @CompraDev              table (Clave varchar(20) NULL)
  DECLARE @Venta                  table (Clave varchar(20) NULL)
  DECLARE @VentaDev               table (Clave varchar(20) NULL)
  
  DECLARE @OrdenFecha			  datetime
  DECLARE @CompraEntrada		  bit

  DECLARE @TablaArticulo table (
    ID                            int IDENTITY (1, 1) NOT NULL,
    Concepto                      varchar(255) NULL,
    Valor                         varchar(255) NULL
  )

  -- Claves afectacion compras					      -- Movimientos
  INSERT INTO @Compra(Clave)      VALUES ('COMS.F')   -- Entrada Compra - Entrada Compra AF
  INSERT INTO @Compra(Clave)      VALUES ('COMS.O')   -- Control Calidad - Factura Importacion - Orden - Orden Compra - Orden Embarque Inter
  INSERT INTO @Compra(Clave)      VALUES ('COMS.EI')  -- Recibo Fiscal
  INSERT INTO @Compra(Clave)      VALUES ('COMS.EG')  -- Entrada Compra
  INSERT INTO @CompraDev(Clave)   VALUES ('COMS.D')   -- Devolucion Compra

  -- Claves afectacion ventas						  -- Movimientos
  INSERT INTO @Venta(Clave)       VALUES ('VTAS.F')   -- Factura - Factura Electrónica - Factura Logyx - Factura Logyx Calz. - Factura Matriz - Factura Matriz Calz. - Factura Sucursal CAN - Factura Sucursal COA - Factura Sucursal GDL - Factura Sucursal L - Factura Sucursal MTY - Factura Sucursal PN - Factura Sucursal VLL
  INSERT INTO @Venta(Clave)       VALUES ('VTAS.FM')  -- Factura Mostrador CO - Factura Mostrador L - Factura Mostrador PN - Factura MostradorCAN - Factura MostradorGDL - Factura MostradorMTY - Factura MostradorVLL
  INSERT INTO @Venta(Clave)       VALUES ('VTAS.FR')  -- Factura Recurrente
  INSERT INTO @VentaDev(Clave)    VALUES ('VTAS.D')   -- Cancelacion Factura - Devolucion Venta

  SET @Estatus = 'CONCLUIDO'

  SELECT TOP 1
		 @CompraID = c.ID,
		 @OrdenFecha = c.FechaEmision,
		 @CompraCantidad = SUM(d.Cantidad),
		 @PrecioCosto = SUM(c.TipoCambio * (ISNULL(d.Costo,0)))/COUNT(*)
    FROM Compra c
    JOIN CompraD d ON(c.ID = d.id)
    JOIN MovTipo m ON(c.Mov = m.Mov)
   WHERE c.Empresa  = @Empresa
     AND c.Estatus  = @Estatus
     AND d.Articulo = @Articulo
     AND m.Clave IN (SELECT Clave FROM @Compra)
GROUP BY C.ID, c.FechaEmision
ORDER BY c.FechaEmision ASC

IF ISNULL(@CompraID,'') <> ''
	BEGIN
	  SET @CompraEntrada = 1
	  SELECT @CompraMov = c.Mov,
			 @CompraMovID = c.MovID,
			 @FechaCompra = FechaEmision,
			 @Moneda = c.Moneda,
			 @TipoCambio = ISNULL(c.TipoCambio,1),
			 @Proveedor = c.Proveedor,
			 @Almacen = c.Almacen,
			 @Sucursal = c.Sucursal
		FROM Compra c
	   WHERE c.ID = @CompraID
	END   
ELSE
	BEGIN
		SELECT TOP 1
			   @CompraID = A.ID,
			   @OrdenFecha = A.FechaEmision,
			   @CompraCantidad = SUM(B.Cantidad),
			   @PrecioCosto = SUM(A.TipoCambio * ISNULL(B.Costo,0))/COUNT(*)
		  FROM INV A
		  JOIN INVD B ON A.ID = B.ID
		  JOIN MOVTIPO C ON A.Mov = c.Mov AND C.Modulo = 'INV'
		 WHERE A.Empresa  = @Empresa
		   AND A.Estatus  = @Estatus
		   AND B.ARTICULO = @Articulo
		   AND C.CLAVE = 'INV.E'
	  GROUP BY A.ID, A.FechaEmision
	  ORDER BY A.FechaEmision ASC
				   
	  SELECT @CompraMov = c.Mov,
			 @CompraMovID = c.MovID,
			 @FechaCompra = FechaEmision,
			 @Moneda = c.Moneda,
			 @TipoCambio = ISNULL(c.TipoCambio,1),
			 @Proveedor = '',
			 @Almacen = c.Almacen,
			 @Sucursal = c.Sucursal
		FROM Inv c
	   WHERE c.ID = @CompraID		   
	END


  SELECT @VentaID = MIN(d.ID)
    FROM VentaD d
    JOIN Venta v ON (d.ID = v.ID)
    JOIN MovTipo m ON(v.Mov = m.Mov)
   WHERE v.Empresa  = @Empresa
     AND v.Estatus  = @Estatus
     AND d.Articulo = @Articulo
     AND m.Clave IN (SELECT Clave FROM @Venta)

  SELECT @FechaPrimerVenta = FechaEmision FROM Venta WHERE ID = @VentaID

  SELECT @VentaID = MAX(d.ID)
    FROM VentaD d
    JOIN Venta v ON (d.ID = v.ID)
    JOIN MovTipo m ON(v.Mov = m.Mov)
   WHERE v.Empresa  = @Empresa
     AND v.Estatus  = @Estatus
     AND d.Articulo = @Articulo
     AND m.Clave IN (SELECT Clave FROM @Venta)

  SELECT @FechaUltimaVenta = FechaEmision FROM Venta WHERE ID = @VentaID

  SET @Concepto = 'Descripción'
  SELECT @Valor = ISNULL(Descripcion1,'') FROM Art WHERE Articulo = @Articulo
  SET @Valor = ISNULL(@Valor,'')
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Proveedor'
  IF ISNULL(@Proveedor,'') <> ''
	BEGIN
		SELECT @Valor = ISNULL(Nombre,'') FROM Prov WHERE Proveedor = @Proveedor
		SET @Valor = ISNULL(@Valor,'(Sin Valor)')		
		INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)		
	END
  ELSE
	BEGIN
		SET @Valor = '(Sin Valor)'
		INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)
	END
  
  IF @CompraEntrada = 1
	SET @Concepto = 'Primer compra'
  ELSE
	SET @Concepto = 'Primer entrada'
	
  SELECT @Valor = CONVERT(varchar(255),@FechaCompra,103)
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Primer Movimiento'
  SELECT @Valor = @CompraMovID
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Primer Cantidad'
/*
  SELECT @Cantidad = SUM(d.Cantidad)
    FROM CompraD d
    JOIN Compra c ON d.ID = c.ID
    JOIN MovTipo m ON(c.Mov = m.Mov)
   WHERE c.Empresa = @Empresa
     AND d.Articulo = @Articulo
     AND c.Estatus = @Estatus
     AND m.Clave IN (SELECT Clave FROM @Compra)*/

  SET @Cantidad = ISNULL(@CompraCantidad,0)
  SELECT @Valor = CONVERT(varchar(255), CONVERT(money, @Cantidad), 1)
  SET @Valor = SUBSTRING(@Valor, 1, LEN(@Valor)-3)
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Primer Costo'
  /*
  SELECT @PrecioCosto = @TipoCambio * ISNULL(d.Costo,0)
    FROM CompraD d
    JOIN Compra c ON d.ID = c.ID
   WHERE d.ID       = @CompraID
     AND d.Articulo = @Articulo
     AND c.Empresa  = @Empresa
	*/
  
  SET @Valor = "$ " + CAST(@PrecioCosto AS varchar(255))
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Costo promedio'
  SELECT @CostoPromedio = CostoPromedio FROM ArtCostoEmpresa WHERE Empresa = @Empresa AND Articulo = @Articulo
  SET @CostoPromedio = ISNULL (@CostoPromedio,0)
  SET @Valor =  "$ " + CAST(@CostoPromedio AS varchar(255))
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Precio público'
  SELECT @PrecioPublico = ISNULL(PrecioLista,0) FROM Art WHERE Articulo = @Articulo
  SET @PrecioPublico = ISNULL(@PrecioPublico,0)
  SET @Valor =  "$ " + CAST(@PrecioPublico AS varchar(255))
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Margen'
  IF @PrecioPublico > 0
    SET @Margen = @CostoPromedio / @PrecioPublico
  ELSE
    SET @Margen = 0
  SELECT @Valor =  CAST(@Margen AS varchar(255))
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Departamento'
  SELECT @Valor = '(Sin Valor)'
  IF @Valor <> '(Sin Valor)'
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Línea'
  SELECT @Valor = ISNULL(Linea,'(Sin Valor)')
    FROM Art
   WHERE Articulo = @Articulo
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Inventario bodegas'
  SELECT @AlmacenPrincipal = LTRIM(RTRIM(ISNULL(AlmacenPrincipal,''))) FROM Sucursal WHERE Sucursal = 0
  SELECT @InventarioBodegas = SUM(Disponible)
    FROM ArtDisponible
   WHERE Empresa = @Empresa
     AND Articulo = @Articulo
     AND Almacen = @AlmacenPrincipal
     
  SELECT @Valor = CONVERT(varchar(255), CONVERT(money, @InventarioBodegas), 1)
  SET @Valor = SUBSTRING(@Valor, 1, LEN(@Valor)-3)
  IF ISNULL(@Valor,'') = '' SET @VALOR = '0'
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Inventario tiendas'
  SELECT @InventarioTiendas = SUM(disponible)
    FROM ArtDisponible
   WHERE Empresa = @Empresa
     AND Articulo = @Articulo
     AND Almacen <> @AlmacenPrincipal
  SELECT @Valor = CONVERT(varchar(255), CONVERT(money, @InventarioTiendas), 1)
  SET @Valor = SUBSTRING(@Valor, 1, LEN(@Valor)-3)
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Primer venta tienda'
  SELECT @Valor = CONVERT(varchar(255),@FechaPrimerVenta,103)
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SET @Concepto = 'Ultima venta tienda'
  SELECT @Valor = CONVERT(varchar(255),@FechaUltimaVenta,103)
  INSERT INTO @TablaArticulo(Concepto,Valor) VALUES (@Concepto,@Valor)

  SELECT Concepto,Valor FROM @TablaArticulo ORDER BY ID

  END
END
GO
