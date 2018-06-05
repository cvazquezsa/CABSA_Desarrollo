SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/**************** bpFacturasMostrador ****************/
if exists (select * from sysobjects where id = object_id('dbo.bpFacturasMostrador') and type = 'P') drop procedure dbo.bpFacturasMostrador
GO             
CREATE PROCEDURE bpFacturasMostrador
			@Empresa	char(5) = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ID		int

  SELECT @Empresa=NULLIF(RTRIM(@Empresa), '')
  IF @Empresa IS NOT NULL
    DECLARE crLista CURSOR FOR 
     SELECT v.ID 
       FROM Venta v, MovTipo mt 
      WHERE v.Mov = mt.Mov 
        AND mt.Modulo = 'VTAS' 
        AND mt.Clave = 'VTAS.FM' 
        AND v.Estatus = 'PROCESAR' 
        AND v.Empresa = @Empresa
  ELSE
    DECLARE crLista CURSOR FOR 
     SELECT v.ID 
       FROM Venta v, MovTipo mt 
      WHERE v.Mov = mt.Mov 
        AND mt.Modulo = 'VTAS' 
        AND mt.Clave = 'VTAS.FM' 
        AND v.Estatus = 'PROCESAR' 
  OPEN crLista
  FETCH NEXT FROM crLista INTO @ID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spAfectar 'VTAS', @ID
    END
    FETCH NEXT FROM crLista INTO @ID
  END -- While
  CLOSE crLista
  DEALLOCATE crLista

  RETURN
END
GO

-- spAceptarABCSugerido 'DEMO', 'Autos'
-- update art set abc = null where categoria = 'Autos'
-- select articulo, abc from art where categoria = 'Autos'
-- select * from artalm
/**************** spAceptarABCSugerido ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAceptarABCSugerido') and type = 'P') drop procedure dbo.spAceptarABCSugerido
GO             
CREATE PROCEDURE spAceptarABCSugerido
			@Estacion	int,
			@Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Categoria		varchar(50),
    @Articulo		char(20),
    @ABC		char(1),
    @Almacen		char(10),
    @Minimo		float, 
    @CantidadOrdenar	float

  DECLARE crArtCat CURSOR FOR
   SELECT RTRIM(Clave)
     FROM ListaSt
    WHERE Estacion = @Estacion
  
  OPEN crArtCat
  FETCH NEXT FROM crArtCat INTO @Categoria
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      DECLARE crABCSugerido CURSOR LOCAL FOR
       SELECT s.Articulo, s.ABC, a.AlmacenROP, c.Minimo, c.CantidadOrdenar
         FROM ABCSugerido s
         JOIN Art a ON a.Articulo = s.Articulo
         JOIN ArtCatABC c ON c.Categoria = @Categoria AND c.ABC = s.ABC
        WHERE s.Categoria = @Categoria 

      OPEN crABCSugerido
      FETCH NEXT FROM crABCSugerido INTO @Articulo, @ABC, @Almacen, @Minimo, @CantidadOrdenar
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          UPDATE Art SET ABC = @ABC WHERE Articulo = @Articulo
          UPDATE ArtAlm SET Minimo = @Minimo, CantidadOrdenarTiempo = @CantidadOrdenar WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = '' AND Almacen = @Almacen
          IF @@ROWCOUNT = 0
            INSERT ArtAlm 
                   (Empresa,  Articulo,  SubCuenta,  Almacen,  Minimo,  CantidadOrdenarTiempo) 
            VALUES (@Empresa, @Articulo, '',         @Almacen, @Minimo, @CantidadOrdenar) 
        END
        FETCH NEXT FROM crABCSugerido INTO @Articulo, @ABC, @Almacen, @Minimo, @CantidadOrdenar
      END
      CLOSE crABCSugerido
      DEALLOCATE crABCSugerido

      --DELETE ABCSugeridoCat WHERE Estacion = @Estacion AND Categoria = @Categoria
    END
    FETCH NEXT FROM crArtCat INTO @Categoria
  END
  CLOSE crArtCat
  DEALLOCATE crArtCat

  SELECT 'Proceso Concluido.'
  RETURN
END
GO

/* 
set nocount on
exec spAjustarOrdenes 'MEX', 'INT', 'INV'
*/

/**************** spAjustarOrdenes ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAjustarOrdenes') and type = 'P') drop procedure dbo.spAjustarOrdenes
GO             
CREATE PROCEDURE spAjustarOrdenes
			@Empresa	char(5),
			@Usuario	char(10),
			@Modulo		char(5),
		 	@Almacen	char(10) 	= NULL,
		 	@Articulo	char(20) 	= NULL,
			@Categoria	varchar(50) 	= NULL,
			@Grupo		varchar(50) 	= NULL,
			@Familia	varchar(50) 	= NULL,
			@Fabricante	varchar(50) 	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255),
    @Conteo		int,
    @FechaRegistro	datetime

  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0, @ID = NULL, 
         @FechaRegistro = GETDATE(), 
         @Almacen = NULLIF(NULLIF(NULLIF(RTRIM(@Almacen), ''), '(TODOS)'), '0'),
         @Articulo = NULLIF(NULLIF(NULLIF(RTRIM(@Articulo), ''), '(TODOS)'), '0'),
         @Categoria = NULLIF(NULLIF(NULLIF(RTRIM(@Categoria), ''), '(TODOS)'), '0'),
         @Grupo = NULLIF(NULLIF(NULLIF(RTRIM(@Grupo), ''), '(TODOS)'), '0'),
         @Familia = NULLIF(NULLIF(NULLIF(RTRIM(@Familia), ''), '(TODOS)'), '0'),
         @Fabricante = NULLIF(NULLIF(NULLIF(RTRIM(@Fabricante), ''), '(TODOS)'), '0')

  IF @Modulo = 'INV'
    DECLARE crOrdenes CURSOR FOR
     SELECT DISTINCT i.ID
       FROM Inv i, InvD d, MovTipo mt, Art a
      WHERE i.ID = d.ID AND i.Empresa = @Empresa AND i.Estatus = 'PENDIENTE'
        AND mt.Modulo = @Modulo AND mt.Mov = i.Mov AND mt.Clave IN (/*'INV.SOL', */'INV.OT', 'INV.OI')
        AND ISNULL(CantidadPendiente, 0) > 0 AND ISNULL(CantidadReservada, 0) = 0
        AND ((mt.Clave IN ('INV.OT', 'INV.OI') AND i.AlmacenDestino = ISNULL(@Almacen, i.AlmacenDestino))
       /*OR  (mt.Clave IN ('INV.SOL')          AND d.Almacen        = ISNULL(@Almacen, d.Almacen))*/)
        AND d.Articulo = a.Articulo
        AND ISNULL(a.Articulo, '') = ISNULL(ISNULL(@Articulo, a.Articulo), '')
        AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria), '')
        AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '')
        AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '')
        AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '')

  OPEN crOrdenes
  FETCH NEXT FROM crOrdenes INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      IF @Modulo = 'INV'
      BEGIN
        UPDATE InvD SET CantidadA = NULL WHERE ID = @ID
        UPDATE InvD SET CantidadA = d.CantidadPendiente
          FROM InvD d, Unidad u
         WHERE d.ID = @ID AND u.Unidad = d.Unidad AND ISNULL(d.CantidadPendiente, 0) < u.AutoAjuste
           AND ISNULL(u.AutoAjuste, 0) > 0
      END

      IF EXISTS (SELECT * FROM InvD WHERE ID = @ID AND ISNULL(CantidadA, 0) > 0)
      BEGIN
        UPDATE InvD SET CantidadPendiente = NULL, CantidadA = NULL WHERE ID = @ID AND ROUND(CantidadPendiente, 4) = 0 AND ISNULL(CantidadA, 0) > 0
        IF EXISTS (SELECT * FROM InvD WHERE ID = @ID AND ISNULL(CantidadA, 0) > 0)
        BEGIN
          EXEC spInv @ID, @Modulo, 'CANCELAR', 'SELECCION', @FechaRegistro, NULL, @Usuario, 0, 0, NULL,
                     NULL, NULL, NULL, NULL,
                     @Ok OUTPUT, @OkRef OUTPUT, NULL

          IF @Ok IS NULL SELECT @Conteo = @Conteo + 1 
        END
      END
    END
    FETCH NEXT FROM crOrdenes INTO @ID
  END  -- While	
  CLOSE crOrdenes
  DEALLOCATE crOrdenes

  IF @Ok IS NULL 
    SELECT @Mensaje = LTRIM(CONVERT(char, @Conteo))+' Ordenes Ajustadas.'
  ELSE
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

/**************** spArtMaterialAgregar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtMaterialAgregar') and type = 'P') drop procedure dbo.spArtMaterialAgregar
GO             
CREATE PROCEDURE spArtMaterialAgregar
                    @ArticuloOrigen	char(20),
                    @ArticuloDestino	char(20)

--//WITH ENCRYPTION
AS BEGIN
  INSERT ArtMaterial (Articulo,         SiOpcion, Material, SubCuenta, CAntidad, Unidad, Merma, Desperdicio, Almacen, CentroTipo, CostoAcumulado, Orden)
               SELECT @ArticuloDestino, SiOpcion, Material, SubCuenta, CAntidad, Unidad, Merma, Desperdicio, Almacen, CentroTipo, CostoAcumulado, Orden
                 FROM ArtMaterial WHERE Articulo = @ArticuloOrigen AND Material <> @ArticuloDestino
  IF EXISTS(SELECT * FROM ArtMaterial WHERE Articulo = @ArticuloOrigen AND Material <> @ArticuloDestino AND NULLIF(RTRIM(SiOpcion), '') IS NOT NULL)
    UPDATE Art SET ProdOpciones = 1 WHERE Articulo = @ArticuloDestino AND ProdOpciones = 0
END
GO

/* 
EXEC spGenerarArtQuiebre 100, 'DEMO', '1/1/4', '1/1/5', 'ALACENA MADERA'
SELECT * FROM ArtQuiebre
*/

/**************** spArtQuiebreActualizarFamilia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizarFamilia') and type = 'P') drop procedure dbo.spArtQuiebreActualizarFamilia
GO             
CREATE PROCEDURE spArtQuiebreActualizarFamilia
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @BasePresupuesto        varchar(20)

  SELECT @BasePresupuesto = UPPER(BasePresupuesto)
    FROM ArtFam 
   WHERE Familia = @Familia

  CREATE TABLE #ArtQuiebre (Articulo char(20) COLLATE Database_Default, Ventas float NULL, Devoluciones float NULL, Faltantes float NULL, Scanner float NULL, VentaAjustada float NULL)
  CREATE TABLE #CteQuiebre (Cliente char(10) COLLATE Database_Default, EnviarA int NULL, Ventas float NULL, Devoluciones float NULL)

  -- Articulos de la Familia
  INSERT #ArtQuiebre (Articulo)
  SELECT Articulo
    FROM Art
   WHERE Familia = @Familia AND Estatus IN ('ALTA', 'PROTOTIPO')

  -- Ventas
  INSERT #ArtQuiebre (Articulo, Ventas)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Ventas)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA

  -- Devoluciones
  INSERT #ArtQuiebre (Articulo, Devoluciones)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Devoluciones)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA 

  -- Faltantes
  INSERT #ArtQuiebre (Articulo, Faltantes)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.VP'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  -- Scanner
  INSERT #ArtQuiebre (Articulo, Scanner)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.EST'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
     AND v.Mov = 'Scanner'
   GROUP BY d.Articulo

  DELETE ArtQuiebre WHERE Familia = @Familia
  INSERT ArtQuiebre 
        (Familia,  Articulo, Ventas,      Devoluciones,      Faltantes,      DemandaNeta,                                                         Scanner)
  SELECT @Familia, q.Articulo, SUM(q.Ventas), SUM(q.Devoluciones), SUM(q.Faltantes), SUM(ISNULL(q.Ventas, 0)-ISNULL(q.Devoluciones, 0)+ISNULL(q.Faltantes, 0)), SUM(q.Scanner)
    FROM #ArtQuiebre q
    JOIN Art a ON a.Articulo = q.Articulo AND a.Estatus IN ('ALTA', 'PROTOTIPO')
   GROUP BY q.Articulo

  IF @BasePresupuesto = 'DEMANDA'
    UPDATE ArtQuiebre SET VentaAjustada = DemandaNeta WHERE Familia = @Familia
  ELSE
    UPDATE ArtQuiebre SET VentaAjustada = Scanner WHERE Familia = @Familia

  DELETE CteQuiebre WHERE Familia = @Familia
  INSERT CteQuiebre (Familia, Cliente, EnviarA, VentaNeta)
  SELECT @Familia, Cliente, ISNULL(EnviarA, 0), ISNULL(SUM(Ventas), 0) + ISNULL(SUM(Devoluciones), 0)
    FROM #CteQuiebre
   GROUP BY Cliente, ISNULL(EnviarA, 0)

  UPDATE ArtFam
     SET UltimoQuiebre = GETDATE(),
         QuiebreFechaD = @FechaD,
         QuiebreFechaA = @FechaA
   WHERE Familia = @Familia

  RETURN
END
GO

-- spArtQuiebreActualizar 100, 'DEMO', '3/1/5', '3/3/5', NULL
/**************** spArtQuiebreActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizar') and type = 'P') drop procedure dbo.spArtQuiebreActualizar
GO             
CREATE PROCEDURE spArtQuiebreActualizar
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Familia = NULLIF(NULLIF(RTRIM(@Familia), ''), '0')
  IF @Familia IS NOT NULL
    EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
  ELSE BEGIN
    DECLARE crArtFam CURSOR FOR
     SELECT Familia
       FROM ArtFam
      WHERE NULLIF(RTRIM(BasePresupuesto), '') IS NOT NULL
  
    OPEN crArtFam
    FETCH NEXT FROM crArtFam INTO @Familia
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
      END
      FETCH NEXT FROM crArtFam INTO @Familia
    END
    CLOSE crArtFam
    DEALLOCATE crArtFam
  END

  SELECT 'Proceso Concluido.'
  RETURN
END
GO


/**************** spCtePresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCtePresupuesto') and type = 'P') drop procedure dbo.spCtePresupuesto
GO             
CREATE PROCEDURE spCtePresupuesto
                        @Periodo                int,
			@Ejercicio              int,
                        @Familia                varchar(50),
                        @VentaNetaFam           float,
                        @PresupuestoFam         float,
                        @Moneda                 char(10) 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cliente        char(10),
    @EnviarA        int,
    @ListaPrecios   varchar(50),
    @Cantidad       float,
    @Precio         float,
    @Importe        money,
    @Articulo	    varchar(20) 

  DECLARE crCteQuiebre CURSOR FOR
   SELECT cq.Cliente, cq.EnviarA, c.ListaPrecios, cq.VentaNeta / @VentaNetaFam * @PresupuestoFam
     FROM CteQuiebre cq, Cte c
    WHERE cq.Familia = @Familia AND cq.Cliente = c.Cliente
  
  OPEN crCteQuiebre
  FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Articulo = MIN(Articulo) FROM ListaPreciosD WHERE Lista = @ListaPrecios
      EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, NULL, @Precio OUTPUT
      SELECT @Importe = @Precio * @Cantidad

      INSERT CtePresupuesto 
             (Cliente,  Ejercicio,  Periodo,  EnviarA,  Familia,  Cantidad,  Importe,  ImporteAjustado)
      VALUES (@Cliente, @Ejercicio, @Periodo, @EnviarA, @Familia, @Cantidad, @Importe, @Importe)

    END
    FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  END
  CLOSE crCteQuiebre
  DEALLOCATE crCteQuiebre

  RETURN
END
GO


-- spArtQuiebreProcesar 100, 'DEMO', 'DEMO', 0, 3, 2005, '1234', 'STOCK'
/**************** spArtQuiebreProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreProcesar') and type = 'P') drop procedure dbo.spArtQuiebreProcesar
GO             
CREATE PROCEDURE spArtQuiebreProcesar
			@Estacion	int,
			@Empresa	char(5),
                        @Usuario        char(10),
                        @Sucursal       int,
                        @Periodo        int,
			@Ejercicio      int,
                        @Cliente        char(10),
                        @Almacen        char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgCompraCostoSugerido  	char(20),
    @a                          int,
    @Ok                         int, 
    @OkRef                      varchar(255), 
    @Moneda		        char(10),
    @TipoCambio		        float,
    @ID                         int,
    @Mov                        varchar(20),
    @MovID                      varchar(20),
    @Fecha                      datetime,
    @Renglon                    float,
    @RenglonID                  int,
    @RenglonTipo                char(1),
    @UltFamilia                 varchar(50),
    @Familia                    varchar(50),
    @Articulo                   char(20),
    @SubCuenta                  varchar(50),
    @Proveedor                  char(10),
    @Precio                     float,
    @Costo                      float,
    @VentaAjustada              float,
    @VentaAjustadaFam           float,
    @Cantidad                   float,
    @CantidadInventario         float,
    @PresupuestoFam             float,
    @VentaNetaFam               float,
    @Unidad                     varchar(50),
    @FechaRegistro		datetime,
    @Impuesto1                  float,
    @Impuesto2                  float,
    @Impuesto3                  money,
    @ArtTipo                    varchar(20),
    @ListaPrecios               varchar(50),
    @Mensaje                    varchar(255),
    @Factor                     float  

  SELECT @a = 0, @Ok = NULL, @OkRef = NULL, @UltFamilia = NULL,
         @ListaPrecios = '(Precio Lista)',
         @SubCuenta = NULL,
         @Cliente = NULLIF(NULLIF(RTRIM(@Cliente), '0'), ''),
         @FechaRegistro = GETDATE()

  SELECT @Mov = VentaPresupuesto FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @CfgCompraCostoSugerido = cfg.CompraCostoSugerido,
         @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  EXEC spIntToDateTime 1, @Periodo, @Ejercicio, @Fecha OUTPUT
  DELETE CtePresupuesto WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo

  BEGIN TRANSACTION

  WHILE @a<12 AND @Ok IS NULL
  BEGIN
    SELECT @ID = NULL, @Renglon = 0.0, @RenglonID = 0
    SELECT @ID = ID FROM Venta WHERE Empresa = @Empresa AND Mov = @Mov AND FechaEmision = @Fecha AND Estatus <> 'CANCELADO'
    IF @ID IS NOT NULL
    BEGIN
      EXEC spDesAfectarPresupuesto 'VTAS', @Mov, @ID
      DELETE VentaD WHERE ID = @ID
    END ELSE
    BEGIN
      INSERT Venta (Sucursal,  Empresa,  Mov,  FechaEmision, Moneda,  TipoCambio,  Almacen,  Cliente,  Usuario,  FechaRequerida, ListaPreciosEsp, Estatus)
            VALUES (@Sucursal, @Empresa, @Mov, @Fecha,       @Moneda, @TipoCambio, @Almacen, @Cliente, @Usuario, @Fecha,         @ListaPrecios,   'SINAFECTAR')
      SELECT @ID = SCOPE_IDENTITY()
    END

    DECLARE crArtQuiebre CURSOR FOR
     SELECT aq.Familia, aq.Articulo, aq.VentaAjustada, a.Unidad, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Proveedor, a.Tipo
       FROM ArtQuiebre aq, Art a
      WHERE NULLIF(aq.VentaAjustada, 0) IS NOT NULL AND a.Articulo = aq.Articulo
      ORDER BY aq.Familia, aq.Articulo
  
    OPEN crArtQuiebre
    FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Familia <> @UltFamilia
        BEGIN
          SELECT @VentaAjustadaFam = SUM(VentaAjustada) FROM ArtQuiebre WHERE Familia = @Familia
          SELECT @VentaNetaFam = SUM(VentaNeta) FROM CteQuiebre WHERE Familia = @Familia
          SELECT @PresupuestoFam = Cantidad FROM ArtFamPresupuesto WHERE Familia = @Familia AND Ejercicio = YEAR(@Fecha) AND Periodo = MONTH(@Fecha)
          IF @a=0 EXEC spCtePresupuesto @Periodo, @Ejercicio, @Familia, @VentaNetaFam, @PresupuestoFam, @Moneda
          SELECT @UltFamilia = @Familia
        END
        SELECT @Cantidad = (@VentaAjustada / @VentaAjustadaFam) * @PresupuestoFam
        IF ISNULL(@Cantidad, 0.0) > 0.0
        BEGIN
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
          EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
          EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
          SELECT @Factor =  dbo.fnArtUnidadFactor(@Empresa, @Articulo,@Unidad)
          EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT
          INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Impuesto1,  Impuesto2,  Impuesto3,          Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Precio)
                 VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Impuesto1, @Impuesto2, @Impuesto3*@Factor, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @Fecha,          @Precio)
        END
      END
      FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    END
    CLOSE crArtQuiebre
    DEALLOCATE crArtQuiebre

    IF @ID IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID)
        EXEC spInv @ID, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,
                   @Mov, @MovID, NULL, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, NULL
      ELSE
        DELETE Venta WHERE ID = @ID
    END

    SELECT @a = @a + 1, @Fecha = DATEADD(month, 1, @Fecha)
  END

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = 'Proceso Concluido con Exito.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/* 
EXEC spGenerarArtQuiebre 100, 'DEMO', '1/1/4', '1/1/5', 'ALACENA MADERA'
SELECT * FROM ArtQuiebre
*/

/**************** spArtQuiebreActualizarFamilia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizarFamilia') and type = 'P') drop procedure dbo.spArtQuiebreActualizarFamilia
GO             
CREATE PROCEDURE spArtQuiebreActualizarFamilia
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @BasePresupuesto        varchar(20)

  SELECT @BasePresupuesto = UPPER(BasePresupuesto)
    FROM ArtFam 
   WHERE Familia = @Familia

  CREATE TABLE #ArtQuiebre (Articulo char(20) COLLATE Database_Default, Ventas float NULL, Devoluciones float NULL, Faltantes float NULL, Scanner float NULL, VentaAjustada float NULL)
  CREATE TABLE #CteQuiebre (Cliente char(10) COLLATE Database_Default, EnviarA int NULL, Ventas float NULL, Devoluciones float NULL)

  -- Articulos de la Familia
  INSERT #ArtQuiebre (Articulo)
  SELECT Articulo
    FROM Art
   WHERE Familia = @Familia AND Estatus IN ('ALTA', 'PROTOTIPO')

  -- Ventas
  INSERT #ArtQuiebre (Articulo, Ventas)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Ventas)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA

  -- Devoluciones
  INSERT #ArtQuiebre (Articulo, Devoluciones)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Devoluciones)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA 

  -- Faltantes
  INSERT #ArtQuiebre (Articulo, Faltantes)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.VP'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  -- Scanner
  INSERT #ArtQuiebre (Articulo, Scanner)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.EST'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
     AND v.Mov = 'Scanner'
   GROUP BY d.Articulo

  DELETE ArtQuiebre WHERE Familia = @Familia
  INSERT ArtQuiebre 
        (Familia,  Articulo, Ventas,      Devoluciones,      Faltantes,      DemandaNeta,                                                         Scanner)
  SELECT @Familia, q.Articulo, SUM(q.Ventas), SUM(q.Devoluciones), SUM(q.Faltantes), SUM(ISNULL(q.Ventas, 0)-ISNULL(q.Devoluciones, 0)+ISNULL(q.Faltantes, 0)), SUM(q.Scanner)
    FROM #ArtQuiebre q
    JOIN Art a ON a.Articulo = q.Articulo AND a.Estatus IN ('ALTA', 'PROTOTIPO')
   GROUP BY q.Articulo

  IF @BasePresupuesto = 'DEMANDA'
    UPDATE ArtQuiebre SET VentaAjustada = DemandaNeta WHERE Familia = @Familia
  ELSE
    UPDATE ArtQuiebre SET VentaAjustada = Scanner WHERE Familia = @Familia

  DELETE CteQuiebre WHERE Familia = @Familia
  INSERT CteQuiebre (Familia, Cliente, EnviarA, VentaNeta)
  SELECT @Familia, Cliente, ISNULL(EnviarA, 0), ISNULL(SUM(Ventas), 0) + ISNULL(SUM(Devoluciones), 0)
    FROM #CteQuiebre
   GROUP BY Cliente, ISNULL(EnviarA, 0)

  UPDATE ArtFam
     SET UltimoQuiebre = GETDATE(),
         QuiebreFechaD = @FechaD,
         QuiebreFechaA = @FechaA
   WHERE Familia = @Familia

  RETURN
END
GO

-- spArtQuiebreActualizar 100, 'DEMO', '3/1/5', '3/3/5', NULL
/**************** spArtQuiebreActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizar') and type = 'P') drop procedure dbo.spArtQuiebreActualizar
GO             
CREATE PROCEDURE spArtQuiebreActualizar
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Familia = NULLIF(NULLIF(RTRIM(@Familia), ''), '0')
  IF @Familia IS NOT NULL
    EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
  ELSE BEGIN
    DECLARE crArtFam CURSOR FOR
     SELECT Familia
       FROM ArtFam
      WHERE NULLIF(RTRIM(BasePresupuesto), '') IS NOT NULL
  
    OPEN crArtFam
    FETCH NEXT FROM crArtFam INTO @Familia
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
      END
      FETCH NEXT FROM crArtFam INTO @Familia
    END
    CLOSE crArtFam
    DEALLOCATE crArtFam
  END

  SELECT 'Proceso Concluido.'
  RETURN
END
GO


/**************** spCtePresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCtePresupuesto') and type = 'P') drop procedure dbo.spCtePresupuesto
GO             
CREATE PROCEDURE spCtePresupuesto
                        @Periodo                int,
			@Ejercicio              int,
                        @Familia                varchar(50),
                        @VentaNetaFam           float,
                        @PresupuestoFam         float,
                        @Moneda                 char(10) 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cliente        char(10),
    @EnviarA        int,
    @ListaPrecios   varchar(50),
    @Cantidad       float,
    @Precio         float,
    @Importe        money,
    @Articulo	    varchar(20) 

  DECLARE crCteQuiebre CURSOR FOR
   SELECT cq.Cliente, cq.EnviarA, c.ListaPrecios, cq.VentaNeta / @VentaNetaFam * @PresupuestoFam
     FROM CteQuiebre cq, Cte c
    WHERE cq.Familia = @Familia AND cq.Cliente = c.Cliente
  
  OPEN crCteQuiebre
  FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Articulo = MIN(Articulo) FROM ListaPreciosD WHERE Lista = @ListaPrecios
      EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, NULL, @Precio OUTPUT
      SELECT @Importe = @Precio * @Cantidad

      INSERT CtePresupuesto 
             (Cliente,  Ejercicio,  Periodo,  EnviarA,  Familia,  Cantidad,  Importe,  ImporteAjustado)
      VALUES (@Cliente, @Ejercicio, @Periodo, @EnviarA, @Familia, @Cantidad, @Importe, @Importe)

    END
    FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  END
  CLOSE crCteQuiebre
  DEALLOCATE crCteQuiebre

  RETURN
END
GO


-- spArtQuiebreProcesar 100, 'DEMO', 'DEMO', 0, 3, 2005, '1234', 'STOCK'
/**************** spArtQuiebreProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreProcesar') and type = 'P') drop procedure dbo.spArtQuiebreProcesar
GO             
CREATE PROCEDURE spArtQuiebreProcesar
			@Estacion	int,
			@Empresa	char(5),
                        @Usuario        char(10),
                        @Sucursal       int,
                        @Periodo        int,
			@Ejercicio      int,
                        @Cliente        char(10),
                        @Almacen        char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgCompraCostoSugerido  	char(20),
    @a                          int,
    @Ok                         int, 
    @OkRef                      varchar(255), 
    @Moneda		        char(10),
    @TipoCambio		        float,
    @ID                         int,
    @Mov                        varchar(20),
    @MovID                      varchar(20),
    @Fecha                      datetime,
    @Renglon                    float,
    @RenglonID                  int,
    @RenglonTipo                char(1),
    @UltFamilia                 varchar(50),
    @Familia                    varchar(50),
    @Articulo                   char(20),
    @SubCuenta                  varchar(50),
    @Proveedor                  char(10),
    @Precio                     float,
    @Costo                      float,
    @VentaAjustada              float,
    @VentaAjustadaFam           float,
    @Cantidad                   float,
    @CantidadInventario         float,
    @PresupuestoFam             float,
    @VentaNetaFam               float,
    @Unidad                     varchar(50),
    @FechaRegistro		datetime,
    @Impuesto1                  float,
    @Impuesto2                  float,
    @Impuesto3                  money,
    @ArtTipo                    varchar(20),
    @ListaPrecios               varchar(50),
    @Mensaje                    varchar(255)

  SELECT @a = 0, @Ok = NULL, @OkRef = NULL, @UltFamilia = NULL,
         @ListaPrecios = '(Precio Lista)',
         @SubCuenta = NULL,
         @Cliente = NULLIF(NULLIF(RTRIM(@Cliente), '0'), ''),
         @FechaRegistro = GETDATE()

  SELECT @Mov = VentaPresupuesto FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @CfgCompraCostoSugerido = cfg.CompraCostoSugerido,
         @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  EXEC spIntToDateTime 1, @Periodo, @Ejercicio, @Fecha OUTPUT
  DELETE CtePresupuesto WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo

  BEGIN TRANSACTION

  WHILE @a<12 AND @Ok IS NULL
  BEGIN
    SELECT @ID = NULL, @Renglon = 0.0, @RenglonID = 0
    SELECT @ID = ID FROM Venta WHERE Empresa = @Empresa AND Mov = @Mov AND FechaEmision = @Fecha AND Estatus <> 'CANCELADO'
    IF @ID IS NOT NULL
    BEGIN
      EXEC spDesAfectarPresupuesto 'VTAS', @Mov, @ID
      DELETE VentaD WHERE ID = @ID
    END ELSE
    BEGIN
      INSERT Venta (Sucursal,  Empresa,  Mov,  FechaEmision, Moneda,  TipoCambio,  Almacen,  Cliente,  Usuario,  FechaRequerida, ListaPreciosEsp, Estatus)
            VALUES (@Sucursal, @Empresa, @Mov, @Fecha,       @Moneda, @TipoCambio, @Almacen, @Cliente, @Usuario, @Fecha,         @ListaPrecios,   'SINAFECTAR')
      SELECT @ID = SCOPE_IDENTITY()
    END

    DECLARE crArtQuiebre CURSOR FOR
     SELECT aq.Familia, aq.Articulo, aq.VentaAjustada, a.Unidad, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Proveedor, a.Tipo
       FROM ArtQuiebre aq, Art a
      WHERE NULLIF(aq.VentaAjustada, 0) IS NOT NULL AND a.Articulo = aq.Articulo
      ORDER BY aq.Familia, aq.Articulo
  
    OPEN crArtQuiebre
    FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Familia <> @UltFamilia
        BEGIN
          SELECT @VentaAjustadaFam = SUM(VentaAjustada) FROM ArtQuiebre WHERE Familia = @Familia
          SELECT @VentaNetaFam = SUM(VentaNeta) FROM CteQuiebre WHERE Familia = @Familia
          SELECT @PresupuestoFam = Cantidad FROM ArtFamPresupuesto WHERE Familia = @Familia AND Ejercicio = YEAR(@Fecha) AND Periodo = MONTH(@Fecha)
          IF @a=0 EXEC spCtePresupuesto @Periodo, @Ejercicio, @Familia, @VentaNetaFam, @PresupuestoFam, @Moneda
          SELECT @UltFamilia = @Familia
        END
        SELECT @Cantidad = (@VentaAjustada / @VentaAjustadaFam) * @PresupuestoFam
        IF ISNULL(@Cantidad, 0.0) > 0.0
        BEGIN
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
          EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
          EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

          EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT
          INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Impuesto1,  Impuesto2,  Impuesto3,  Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Precio)
                 VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Impuesto1, @Impuesto2, @Impuesto3, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @Fecha,          @Precio)
        END
      END
      FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    END
    CLOSE crArtQuiebre
    DEALLOCATE crArtQuiebre

    IF @ID IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID)
        EXEC spInv @ID, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,
                   @Mov, @MovID, NULL, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, NULL
      ELSE
        DELETE Venta WHERE ID = @ID
    END

    SELECT @a = @a + 1, @Fecha = DATEADD(month, 1, @Fecha)
  END

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = 'Proceso Concluido con Exito.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/* 
EXEC spGenerarArtQuiebre 100, 'DEMO', '1/1/4', '1/1/5', 'ALACENA MADERA'
SELECT * FROM ArtQuiebre
*/

/**************** spArtQuiebreActualizarFamilia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizarFamilia') and type = 'P') drop procedure dbo.spArtQuiebreActualizarFamilia
GO             
CREATE PROCEDURE spArtQuiebreActualizarFamilia
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @BasePresupuesto        varchar(20)

  SELECT @BasePresupuesto = UPPER(BasePresupuesto)
    FROM ArtFam 
   WHERE Familia = @Familia

  CREATE TABLE #ArtQuiebre (Articulo char(20) COLLATE Database_Default, Ventas float NULL, Devoluciones float NULL, Faltantes float NULL, Scanner float NULL, VentaAjustada float NULL)
  CREATE TABLE #CteQuiebre (Cliente char(10) COLLATE Database_Default, EnviarA int NULL, Ventas float NULL, Devoluciones float NULL)

  -- Articulos de la Familia
  INSERT #ArtQuiebre (Articulo)
  SELECT Articulo
    FROM Art
   WHERE Familia = @Familia AND Estatus IN ('ALTA', 'PROTOTIPO')

  -- Ventas
  INSERT #ArtQuiebre (Articulo, Ventas)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Ventas)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA

  -- Devoluciones
  INSERT #ArtQuiebre (Articulo, Devoluciones)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Devoluciones)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA 

  -- Faltantes
  INSERT #ArtQuiebre (Articulo, Faltantes)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.VP'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  -- Scanner
  INSERT #ArtQuiebre (Articulo, Scanner)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.EST'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
     AND v.Mov = 'Scanner'
   GROUP BY d.Articulo

  DELETE ArtQuiebre WHERE Familia = @Familia
  INSERT ArtQuiebre 
        (Familia,  Articulo, Ventas,      Devoluciones,      Faltantes,      DemandaNeta,                                                         Scanner)
  SELECT @Familia, q.Articulo, SUM(q.Ventas), SUM(q.Devoluciones), SUM(q.Faltantes), SUM(ISNULL(q.Ventas, 0)-ISNULL(q.Devoluciones, 0)+ISNULL(q.Faltantes, 0)), SUM(q.Scanner)
    FROM #ArtQuiebre q
    JOIN Art a ON a.Articulo = q.Articulo AND a.Estatus IN ('ALTA', 'PROTOTIPO')
   GROUP BY q.Articulo

  IF @BasePresupuesto = 'DEMANDA'
    UPDATE ArtQuiebre SET VentaAjustada = DemandaNeta WHERE Familia = @Familia
  ELSE
    UPDATE ArtQuiebre SET VentaAjustada = Scanner WHERE Familia = @Familia

  DELETE CteQuiebre WHERE Familia = @Familia
  INSERT CteQuiebre (Familia, Cliente, EnviarA, VentaNeta)
  SELECT @Familia, Cliente, ISNULL(EnviarA, 0), ISNULL(SUM(Ventas), 0) + ISNULL(SUM(Devoluciones), 0)
    FROM #CteQuiebre
   GROUP BY Cliente, ISNULL(EnviarA, 0)

  UPDATE ArtFam
     SET UltimoQuiebre = GETDATE(),
         QuiebreFechaD = @FechaD,
         QuiebreFechaA = @FechaA
   WHERE Familia = @Familia

  RETURN
END
GO

-- spArtQuiebreActualizar 100, 'DEMO', '3/1/5', '3/3/5', NULL
/**************** spArtQuiebreActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizar') and type = 'P') drop procedure dbo.spArtQuiebreActualizar
GO             
CREATE PROCEDURE spArtQuiebreActualizar
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Familia = NULLIF(NULLIF(RTRIM(@Familia), ''), '0')
  IF @Familia IS NOT NULL
    EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
  ELSE BEGIN
    DECLARE crArtFam CURSOR FOR
     SELECT Familia
       FROM ArtFam
      WHERE NULLIF(RTRIM(BasePresupuesto), '') IS NOT NULL
  
    OPEN crArtFam
    FETCH NEXT FROM crArtFam INTO @Familia
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
      END
      FETCH NEXT FROM crArtFam INTO @Familia
    END
    CLOSE crArtFam
    DEALLOCATE crArtFam
  END

  SELECT 'Proceso Concluido.'
  RETURN
END
GO


/**************** spCtePresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCtePresupuesto') and type = 'P') drop procedure dbo.spCtePresupuesto
GO             
CREATE PROCEDURE spCtePresupuesto
                        @Periodo                int,
			@Ejercicio              int,
                        @Familia                varchar(50),
                        @VentaNetaFam           float,
                        @PresupuestoFam         float,
                        @Moneda                 char(10) 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cliente        char(10),
    @EnviarA        int,
    @ListaPrecios   varchar(50),
    @Cantidad       float,
    @Precio         float,
    @Importe        money,
    @Articulo	    varchar(20) 

  DECLARE crCteQuiebre CURSOR FOR
   SELECT cq.Cliente, cq.EnviarA, c.ListaPrecios, cq.VentaNeta / @VentaNetaFam * @PresupuestoFam
     FROM CteQuiebre cq, Cte c
    WHERE cq.Familia = @Familia AND cq.Cliente = c.Cliente
  
  OPEN crCteQuiebre
  FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Articulo = MIN(Articulo) FROM ListaPreciosD WHERE Lista = @ListaPrecios
      EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, NULL, @Precio OUTPUT
      SELECT @Importe = @Precio * @Cantidad

      INSERT CtePresupuesto 
             (Cliente,  Ejercicio,  Periodo,  EnviarA,  Familia,  Cantidad,  Importe,  ImporteAjustado)
      VALUES (@Cliente, @Ejercicio, @Periodo, @EnviarA, @Familia, @Cantidad, @Importe, @Importe)

    END
    FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  END
  CLOSE crCteQuiebre
  DEALLOCATE crCteQuiebre

  RETURN
END
GO


-- spArtQuiebreProcesar 100, 'DEMO', 'DEMO', 0, 3, 2005, '1234', 'STOCK'
/**************** spArtQuiebreProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreProcesar') and type = 'P') drop procedure dbo.spArtQuiebreProcesar
GO             
CREATE PROCEDURE spArtQuiebreProcesar
			@Estacion	int,
			@Empresa	char(5),
                        @Usuario        char(10),
                        @Sucursal       int,
                        @Periodo        int,
			@Ejercicio      int,
                        @Cliente        char(10),
                        @Almacen        char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgCompraCostoSugerido  	char(20),
    @a                          int,
    @Ok                         int, 
    @OkRef                      varchar(255), 
    @Moneda		        char(10),
    @TipoCambio		        float,
    @ID                         int,
    @Mov                        varchar(20),
    @MovID                      varchar(20),
    @Fecha                      datetime,
    @Renglon                    float,
    @RenglonID                  int,
    @RenglonTipo                char(1),
    @UltFamilia                 varchar(50),
    @Familia                    varchar(50),
    @Articulo                   char(20),
    @SubCuenta                  varchar(50),
    @Proveedor                  char(10),
    @Precio                     float,
    @Costo                      float,
    @VentaAjustada              float,
    @VentaAjustadaFam           float,
    @Cantidad                   float,
    @CantidadInventario         float,
    @PresupuestoFam             float,
    @VentaNetaFam               float,
    @Unidad                     varchar(50),
    @FechaRegistro		datetime,
    @Impuesto1                  float,
    @Impuesto2                  float,
    @Impuesto3                  money,
    @ArtTipo                    varchar(20),
    @ListaPrecios               varchar(50),
    @Mensaje                    varchar(255)

  SELECT @a = 0, @Ok = NULL, @OkRef = NULL, @UltFamilia = NULL,
         @ListaPrecios = '(Precio Lista)',
         @SubCuenta = NULL,
         @Cliente = NULLIF(NULLIF(RTRIM(@Cliente), '0'), ''),
         @FechaRegistro = GETDATE()

  SELECT @Mov = VentaPresupuesto FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @CfgCompraCostoSugerido = cfg.CompraCostoSugerido,
         @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  EXEC spIntToDateTime 1, @Periodo, @Ejercicio, @Fecha OUTPUT
  DELETE CtePresupuesto WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo

  BEGIN TRANSACTION

  WHILE @a<12 AND @Ok IS NULL
  BEGIN
    SELECT @ID = NULL, @Renglon = 0.0, @RenglonID = 0
    SELECT @ID = ID FROM Venta WHERE Empresa = @Empresa AND Mov = @Mov AND FechaEmision = @Fecha AND Estatus <> 'CANCELADO'
    IF @ID IS NOT NULL
    BEGIN
      EXEC spDesAfectarPresupuesto 'VTAS', @Mov, @ID
      DELETE VentaD WHERE ID = @ID
    END ELSE
    BEGIN
      INSERT Venta (Sucursal,  Empresa,  Mov,  FechaEmision, Moneda,  TipoCambio,  Almacen,  Cliente,  Usuario,  FechaRequerida, ListaPreciosEsp, Estatus)
            VALUES (@Sucursal, @Empresa, @Mov, @Fecha,       @Moneda, @TipoCambio, @Almacen, @Cliente, @Usuario, @Fecha,         @ListaPrecios,   'SINAFECTAR')
      SELECT @ID = SCOPE_IDENTITY()
    END

    DECLARE crArtQuiebre CURSOR FOR
     SELECT aq.Familia, aq.Articulo, aq.VentaAjustada, a.Unidad, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Proveedor, a.Tipo
       FROM ArtQuiebre aq, Art a
      WHERE NULLIF(aq.VentaAjustada, 0) IS NOT NULL AND a.Articulo = aq.Articulo
      ORDER BY aq.Familia, aq.Articulo
  
    OPEN crArtQuiebre
    FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Familia <> @UltFamilia
        BEGIN
          SELECT @VentaAjustadaFam = SUM(VentaAjustada) FROM ArtQuiebre WHERE Familia = @Familia
          SELECT @VentaNetaFam = SUM(VentaNeta) FROM CteQuiebre WHERE Familia = @Familia
          SELECT @PresupuestoFam = Cantidad FROM ArtFamPresupuesto WHERE Familia = @Familia AND Ejercicio = YEAR(@Fecha) AND Periodo = MONTH(@Fecha)
          IF @a=0 EXEC spCtePresupuesto @Periodo, @Ejercicio, @Familia, @VentaNetaFam, @PresupuestoFam, @Moneda
          SELECT @UltFamilia = @Familia
        END
        SELECT @Cantidad = (@VentaAjustada / @VentaAjustadaFam) * @PresupuestoFam
        IF ISNULL(@Cantidad, 0.0) > 0.0
        BEGIN
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
          EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
          EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

          EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT
          INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Impuesto1,  Impuesto2,  Impuesto3,  Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Precio)
                 VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Impuesto1, @Impuesto2, @Impuesto3, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @Fecha,          @Precio)
        END
      END
      FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    END
    CLOSE crArtQuiebre
    DEALLOCATE crArtQuiebre

    IF @ID IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID)
        EXEC spInv @ID, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,
                   @Mov, @MovID, NULL, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, NULL
      ELSE
        DELETE Venta WHERE ID = @ID
    END

    SELECT @a = @a + 1, @Fecha = DATEADD(month, 1, @Fecha)
  END

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = 'Proceso Concluido con Exito.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/* 
EXEC spGenerarArtQuiebre 100, 'DEMO', '1/1/4', '1/1/5', 'ALACENA MADERA'
SELECT * FROM ArtQuiebre
*/

/**************** spArtQuiebreActualizarFamilia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizarFamilia') and type = 'P') drop procedure dbo.spArtQuiebreActualizarFamilia
GO             
CREATE PROCEDURE spArtQuiebreActualizarFamilia
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @BasePresupuesto        varchar(20)

  SELECT @BasePresupuesto = UPPER(BasePresupuesto)
    FROM ArtFam 
   WHERE Familia = @Familia

  CREATE TABLE #ArtQuiebre (Articulo char(20) COLLATE Database_Default, Ventas float NULL, Devoluciones float NULL, Faltantes float NULL, Scanner float NULL, VentaAjustada float NULL)
  CREATE TABLE #CteQuiebre (Cliente char(10) COLLATE Database_Default, EnviarA int NULL, Ventas float NULL, Devoluciones float NULL)

  -- Articulos de la Familia
  INSERT #ArtQuiebre (Articulo)
  SELECT Articulo
    FROM Art
   WHERE Familia = @Familia AND Estatus IN ('ALTA', 'PROTOTIPO')

  -- Ventas
  INSERT #ArtQuiebre (Articulo, Ventas)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Ventas)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA

  -- Devoluciones
  INSERT #ArtQuiebre (Articulo, Devoluciones)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Devoluciones)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA 

  -- Faltantes
  INSERT #ArtQuiebre (Articulo, Faltantes)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.VP'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  -- Scanner
  INSERT #ArtQuiebre (Articulo, Scanner)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.EST'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
     AND v.Mov = 'Scanner'
   GROUP BY d.Articulo

  DELETE ArtQuiebre WHERE Familia = @Familia
  INSERT ArtQuiebre 
        (Familia,  Articulo, Ventas,      Devoluciones,      Faltantes,      DemandaNeta,                                                         Scanner)
  SELECT @Familia, q.Articulo, SUM(q.Ventas), SUM(q.Devoluciones), SUM(q.Faltantes), SUM(ISNULL(q.Ventas, 0)-ISNULL(q.Devoluciones, 0)+ISNULL(q.Faltantes, 0)), SUM(q.Scanner)
    FROM #ArtQuiebre q
    JOIN Art a ON a.Articulo = q.Articulo AND a.Estatus IN ('ALTA', 'PROTOTIPO')
   GROUP BY q.Articulo

  IF @BasePresupuesto = 'DEMANDA'
    UPDATE ArtQuiebre SET VentaAjustada = DemandaNeta WHERE Familia = @Familia
  ELSE
    UPDATE ArtQuiebre SET VentaAjustada = Scanner WHERE Familia = @Familia

  DELETE CteQuiebre WHERE Familia = @Familia
  INSERT CteQuiebre (Familia, Cliente, EnviarA, VentaNeta)
  SELECT @Familia, Cliente, ISNULL(EnviarA, 0), ISNULL(SUM(Ventas), 0) + ISNULL(SUM(Devoluciones), 0)
    FROM #CteQuiebre
   GROUP BY Cliente, ISNULL(EnviarA, 0)

  UPDATE ArtFam
     SET UltimoQuiebre = GETDATE(),
         QuiebreFechaD = @FechaD,
         QuiebreFechaA = @FechaA
   WHERE Familia = @Familia

  RETURN
END
GO

-- spArtQuiebreActualizar 100, 'DEMO', '3/1/5', '3/3/5', NULL
/**************** spArtQuiebreActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizar') and type = 'P') drop procedure dbo.spArtQuiebreActualizar
GO             
CREATE PROCEDURE spArtQuiebreActualizar
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Familia = NULLIF(NULLIF(RTRIM(@Familia), ''), '0')
  IF @Familia IS NOT NULL
    EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
  ELSE BEGIN
    DECLARE crArtFam CURSOR FOR
     SELECT Familia
       FROM ArtFam
      WHERE NULLIF(RTRIM(BasePresupuesto), '') IS NOT NULL
  
    OPEN crArtFam
    FETCH NEXT FROM crArtFam INTO @Familia
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
      END
      FETCH NEXT FROM crArtFam INTO @Familia
    END
    CLOSE crArtFam
    DEALLOCATE crArtFam
  END

  SELECT 'Proceso Concluido.'
  RETURN
END
GO


/**************** spCtePresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCtePresupuesto') and type = 'P') drop procedure dbo.spCtePresupuesto
GO             
CREATE PROCEDURE spCtePresupuesto
                        @Periodo                int,
			@Ejercicio              int,
                        @Familia                varchar(50),
                        @VentaNetaFam           float,
                        @PresupuestoFam         float,
                        @Moneda                 char(10) 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cliente        char(10),
    @EnviarA        int,
    @ListaPrecios   varchar(50),
    @Cantidad       float,
    @Precio         float,
    @Importe        money,
    @Articulo	    varchar(20) 

  DECLARE crCteQuiebre CURSOR FOR
   SELECT cq.Cliente, cq.EnviarA, c.ListaPrecios, cq.VentaNeta / @VentaNetaFam * @PresupuestoFam
     FROM CteQuiebre cq, Cte c
    WHERE cq.Familia = @Familia AND cq.Cliente = c.Cliente
  
  OPEN crCteQuiebre
  FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Articulo = MIN(Articulo) FROM ListaPreciosD WHERE Lista = @ListaPrecios
      EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, NULL, @Precio OUTPUT
      SELECT @Importe = @Precio * @Cantidad

      INSERT CtePresupuesto 
             (Cliente,  Ejercicio,  Periodo,  EnviarA,  Familia,  Cantidad,  Importe,  ImporteAjustado)
      VALUES (@Cliente, @Ejercicio, @Periodo, @EnviarA, @Familia, @Cantidad, @Importe, @Importe)

    END
    FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  END
  CLOSE crCteQuiebre
  DEALLOCATE crCteQuiebre

  RETURN
END
GO


-- spArtQuiebreProcesar 100, 'DEMO', 'DEMO', 0, 3, 2005, '1234', 'STOCK'
/**************** spArtQuiebreProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreProcesar') and type = 'P') drop procedure dbo.spArtQuiebreProcesar
GO             
CREATE PROCEDURE spArtQuiebreProcesar
			@Estacion	int,
			@Empresa	char(5),
                        @Usuario        char(10),
                        @Sucursal       int,
                        @Periodo        int,
			@Ejercicio      int,
                        @Cliente        char(10),
                        @Almacen        char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgCompraCostoSugerido  	char(20),
    @a                          int,
    @Ok                         int, 
    @OkRef                      varchar(255), 
    @Moneda		        char(10),
    @TipoCambio		        float,
    @ID                         int,
    @Mov                        varchar(20),
    @MovID                      varchar(20),
    @Fecha                      datetime,
    @Renglon                    float,
    @RenglonID                  int,
    @RenglonTipo                char(1),
    @UltFamilia                 varchar(50),
    @Familia                    varchar(50),
    @Articulo                   char(20),
    @SubCuenta                  varchar(50),
    @Proveedor                  char(10),
    @Precio                     float,
    @Costo                      float,
    @VentaAjustada              float,
    @VentaAjustadaFam           float,
    @Cantidad                   float,
    @CantidadInventario         float,
    @PresupuestoFam             float,
    @VentaNetaFam               float,
    @Unidad                     varchar(50),
    @FechaRegistro		datetime,
    @Impuesto1                  float,
    @Impuesto2                  float,
    @Impuesto3                  money,
    @ArtTipo                    varchar(20),
    @ListaPrecios               varchar(50),
    @Mensaje                    varchar(255)

  SELECT @a = 0, @Ok = NULL, @OkRef = NULL, @UltFamilia = NULL,
         @ListaPrecios = '(Precio Lista)',
         @SubCuenta = NULL,
         @Cliente = NULLIF(NULLIF(RTRIM(@Cliente), '0'), ''),
         @FechaRegistro = GETDATE()

  SELECT @Mov = VentaPresupuesto FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @CfgCompraCostoSugerido = cfg.CompraCostoSugerido,
         @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  EXEC spIntToDateTime 1, @Periodo, @Ejercicio, @Fecha OUTPUT
  DELETE CtePresupuesto WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo

  BEGIN TRANSACTION

  WHILE @a<12 AND @Ok IS NULL
  BEGIN
    SELECT @ID = NULL, @Renglon = 0.0, @RenglonID = 0
    SELECT @ID = ID FROM Venta WHERE Empresa = @Empresa AND Mov = @Mov AND FechaEmision = @Fecha AND Estatus <> 'CANCELADO'
    IF @ID IS NOT NULL
    BEGIN
      EXEC spDesAfectarPresupuesto 'VTAS', @Mov, @ID
      DELETE VentaD WHERE ID = @ID
    END ELSE
    BEGIN
      INSERT Venta (Sucursal,  Empresa,  Mov,  FechaEmision, Moneda,  TipoCambio,  Almacen,  Cliente,  Usuario,  FechaRequerida, ListaPreciosEsp, Estatus)
            VALUES (@Sucursal, @Empresa, @Mov, @Fecha,       @Moneda, @TipoCambio, @Almacen, @Cliente, @Usuario, @Fecha,         @ListaPrecios,   'SINAFECTAR')
      SELECT @ID = SCOPE_IDENTITY()
    END

    DECLARE crArtQuiebre CURSOR FOR
     SELECT aq.Familia, aq.Articulo, aq.VentaAjustada, a.Unidad, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Proveedor, a.Tipo
       FROM ArtQuiebre aq, Art a
      WHERE NULLIF(aq.VentaAjustada, 0) IS NOT NULL AND a.Articulo = aq.Articulo
      ORDER BY aq.Familia, aq.Articulo
  
    OPEN crArtQuiebre
    FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Familia <> @UltFamilia
        BEGIN
          SELECT @VentaAjustadaFam = SUM(VentaAjustada) FROM ArtQuiebre WHERE Familia = @Familia
          SELECT @VentaNetaFam = SUM(VentaNeta) FROM CteQuiebre WHERE Familia = @Familia
          SELECT @PresupuestoFam = Cantidad FROM ArtFamPresupuesto WHERE Familia = @Familia AND Ejercicio = YEAR(@Fecha) AND Periodo = MONTH(@Fecha)
          IF @a=0 EXEC spCtePresupuesto @Periodo, @Ejercicio, @Familia, @VentaNetaFam, @PresupuestoFam, @Moneda
          SELECT @UltFamilia = @Familia
        END
        SELECT @Cantidad = (@VentaAjustada / @VentaAjustadaFam) * @PresupuestoFam
        IF ISNULL(@Cantidad, 0.0) > 0.0
        BEGIN
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
          EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
          EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

          EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT
          INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Impuesto1,  Impuesto2,  Impuesto3,  Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Precio)
                 VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Impuesto1, @Impuesto2, @Impuesto3, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @Fecha,          @Precio)
        END
      END
      FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    END
    CLOSE crArtQuiebre
    DEALLOCATE crArtQuiebre

    IF @ID IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID)
        EXEC spInv @ID, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,
                   @Mov, @MovID, NULL, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, NULL
      ELSE
        DELETE Venta WHERE ID = @ID
    END

    SELECT @a = @a + 1, @Fecha = DATEADD(month, 1, @Fecha)
  END

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = 'Proceso Concluido con Exito.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/* 
EXEC spGenerarArtQuiebre 100, 'DEMO', '1/1/4', '1/1/5', 'ALACENA MADERA'
SELECT * FROM ArtQuiebre
*/

/**************** spArtQuiebreActualizarFamilia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizarFamilia') and type = 'P') drop procedure dbo.spArtQuiebreActualizarFamilia
GO             
CREATE PROCEDURE spArtQuiebreActualizarFamilia
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @BasePresupuesto        varchar(20)

  SELECT @BasePresupuesto = UPPER(BasePresupuesto)
    FROM ArtFam 
   WHERE Familia = @Familia

  CREATE TABLE #ArtQuiebre (Articulo char(20) COLLATE Database_Default, Ventas float NULL, Devoluciones float NULL, Faltantes float NULL, Scanner float NULL, VentaAjustada float NULL)
  CREATE TABLE #CteQuiebre (Cliente char(10) COLLATE Database_Default, EnviarA int NULL, Ventas float NULL, Devoluciones float NULL)

  -- Articulos de la Familia
  INSERT #ArtQuiebre (Articulo)
  SELECT Articulo
    FROM Art
   WHERE Familia = @Familia AND Estatus IN ('ALTA', 'PROTOTIPO')

  -- Ventas
  INSERT #ArtQuiebre (Articulo, Ventas)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Ventas)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA

  -- Devoluciones
  INSERT #ArtQuiebre (Articulo, Devoluciones)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Devoluciones)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA 

  -- Faltantes
  INSERT #ArtQuiebre (Articulo, Faltantes)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.VP'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  -- Scanner
  INSERT #ArtQuiebre (Articulo, Scanner)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.EST'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
     AND v.Mov = 'Scanner'
   GROUP BY d.Articulo

  DELETE ArtQuiebre WHERE Familia = @Familia
  INSERT ArtQuiebre 
        (Familia,  Articulo, Ventas,      Devoluciones,      Faltantes,      DemandaNeta,                                                         Scanner)
  SELECT @Familia, q.Articulo, SUM(q.Ventas), SUM(q.Devoluciones), SUM(q.Faltantes), SUM(ISNULL(q.Ventas, 0)-ISNULL(q.Devoluciones, 0)+ISNULL(q.Faltantes, 0)), SUM(q.Scanner)
    FROM #ArtQuiebre q
    JOIN Art a ON a.Articulo = q.Articulo AND a.Estatus IN ('ALTA', 'PROTOTIPO')
   GROUP BY q.Articulo

  IF @BasePresupuesto = 'DEMANDA'
    UPDATE ArtQuiebre SET VentaAjustada = DemandaNeta WHERE Familia = @Familia
  ELSE
    UPDATE ArtQuiebre SET VentaAjustada = Scanner WHERE Familia = @Familia

  DELETE CteQuiebre WHERE Familia = @Familia
  INSERT CteQuiebre (Familia, Cliente, EnviarA, VentaNeta)
  SELECT @Familia, Cliente, ISNULL(EnviarA, 0), ISNULL(SUM(Ventas), 0) + ISNULL(SUM(Devoluciones), 0)
    FROM #CteQuiebre
   GROUP BY Cliente, ISNULL(EnviarA, 0)

  UPDATE ArtFam
     SET UltimoQuiebre = GETDATE(),
         QuiebreFechaD = @FechaD,
         QuiebreFechaA = @FechaA
   WHERE Familia = @Familia

  RETURN
END
GO

-- spArtQuiebreActualizar 100, 'DEMO', '3/1/5', '3/3/5', NULL
/**************** spArtQuiebreActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizar') and type = 'P') drop procedure dbo.spArtQuiebreActualizar
GO             
CREATE PROCEDURE spArtQuiebreActualizar
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Familia = NULLIF(NULLIF(RTRIM(@Familia), ''), '0')
  IF @Familia IS NOT NULL
    EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
  ELSE BEGIN
    DECLARE crArtFam CURSOR FOR
     SELECT Familia
       FROM ArtFam
      WHERE NULLIF(RTRIM(BasePresupuesto), '') IS NOT NULL
  
    OPEN crArtFam
    FETCH NEXT FROM crArtFam INTO @Familia
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
      END
      FETCH NEXT FROM crArtFam INTO @Familia
    END
    CLOSE crArtFam
    DEALLOCATE crArtFam
  END

  SELECT 'Proceso Concluido.'
  RETURN
END
GO


/**************** spCtePresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCtePresupuesto') and type = 'P') drop procedure dbo.spCtePresupuesto
GO             
CREATE PROCEDURE spCtePresupuesto
                        @Periodo                int,
			@Ejercicio              int,
                        @Familia                varchar(50),
                        @VentaNetaFam           float,
                        @PresupuestoFam         float,
                        @Moneda                 char(10) 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cliente        char(10),
    @EnviarA        int,
    @ListaPrecios   varchar(50),
    @Cantidad       float,
    @Precio         float,
    @Importe        money,
    @Articulo	    varchar(20) 

  DECLARE crCteQuiebre CURSOR FOR
   SELECT cq.Cliente, cq.EnviarA, c.ListaPrecios, cq.VentaNeta / @VentaNetaFam * @PresupuestoFam
     FROM CteQuiebre cq, Cte c
    WHERE cq.Familia = @Familia AND cq.Cliente = c.Cliente
  
  OPEN crCteQuiebre
  FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Articulo = MIN(Articulo) FROM ListaPreciosD WHERE Lista = @ListaPrecios
      EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, NULL, @Precio OUTPUT
      SELECT @Importe = @Precio * @Cantidad

      INSERT CtePresupuesto 
             (Cliente,  Ejercicio,  Periodo,  EnviarA,  Familia,  Cantidad,  Importe,  ImporteAjustado)
      VALUES (@Cliente, @Ejercicio, @Periodo, @EnviarA, @Familia, @Cantidad, @Importe, @Importe)

    END
    FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  END
  CLOSE crCteQuiebre
  DEALLOCATE crCteQuiebre

  RETURN
END
GO


-- spArtQuiebreProcesar 100, 'DEMO', 'DEMO', 0, 3, 2005, '1234', 'STOCK'
/**************** spArtQuiebreProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreProcesar') and type = 'P') drop procedure dbo.spArtQuiebreProcesar
GO             
CREATE PROCEDURE spArtQuiebreProcesar
			@Estacion	int,
			@Empresa	char(5),
                        @Usuario        char(10),
                        @Sucursal       int,
                        @Periodo        int,
			@Ejercicio      int,
                        @Cliente        char(10),
                        @Almacen        char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgCompraCostoSugerido  	char(20),
    @a                          int,
    @Ok                         int, 
    @OkRef                      varchar(255), 
    @Moneda		        char(10),
    @TipoCambio		        float,
    @ID                         int,
    @Mov                        varchar(20),
    @MovID                      varchar(20),
    @Fecha                      datetime,
    @Renglon                    float,
    @RenglonID                  int,
    @RenglonTipo                char(1),
    @UltFamilia                 varchar(50),
    @Familia                    varchar(50),
    @Articulo                   char(20),
    @SubCuenta                  varchar(50),
    @Proveedor                  char(10),
    @Precio                     float,
    @Costo                      float,
    @VentaAjustada              float,
    @VentaAjustadaFam           float,
    @Cantidad                   float,
    @CantidadInventario         float,
    @PresupuestoFam             float,
    @VentaNetaFam               float,
    @Unidad                     varchar(50),
    @FechaRegistro		datetime,
    @Impuesto1                  float,
    @Impuesto2                  float,
    @Impuesto3                  money,
    @ArtTipo                    varchar(20),
    @ListaPrecios               varchar(50),
    @Mensaje                    varchar(255)

  SELECT @a = 0, @Ok = NULL, @OkRef = NULL, @UltFamilia = NULL,
         @ListaPrecios = '(Precio Lista)',
         @SubCuenta = NULL,
         @Cliente = NULLIF(NULLIF(RTRIM(@Cliente), '0'), ''),
         @FechaRegistro = GETDATE()

  SELECT @Mov = VentaPresupuesto FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @CfgCompraCostoSugerido = cfg.CompraCostoSugerido,
         @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  EXEC spIntToDateTime 1, @Periodo, @Ejercicio, @Fecha OUTPUT
  DELETE CtePresupuesto WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo

  BEGIN TRANSACTION

  WHILE @a<12 AND @Ok IS NULL
  BEGIN
    SELECT @ID = NULL, @Renglon = 0.0, @RenglonID = 0
    SELECT @ID = ID FROM Venta WHERE Empresa = @Empresa AND Mov = @Mov AND FechaEmision = @Fecha AND Estatus <> 'CANCELADO'
    IF @ID IS NOT NULL
    BEGIN
      EXEC spDesAfectarPresupuesto 'VTAS', @Mov, @ID
      DELETE VentaD WHERE ID = @ID
    END ELSE
    BEGIN
      INSERT Venta (Sucursal,  Empresa,  Mov,  FechaEmision, Moneda,  TipoCambio,  Almacen,  Cliente,  Usuario,  FechaRequerida, ListaPreciosEsp, Estatus)
            VALUES (@Sucursal, @Empresa, @Mov, @Fecha,       @Moneda, @TipoCambio, @Almacen, @Cliente, @Usuario, @Fecha,         @ListaPrecios,   'SINAFECTAR')
      SELECT @ID = SCOPE_IDENTITY()
    END

    DECLARE crArtQuiebre CURSOR FOR
     SELECT aq.Familia, aq.Articulo, aq.VentaAjustada, a.Unidad, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Proveedor, a.Tipo
       FROM ArtQuiebre aq, Art a
      WHERE NULLIF(aq.VentaAjustada, 0) IS NOT NULL AND a.Articulo = aq.Articulo
      ORDER BY aq.Familia, aq.Articulo
  
    OPEN crArtQuiebre
    FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Familia <> @UltFamilia
        BEGIN
          SELECT @VentaAjustadaFam = SUM(VentaAjustada) FROM ArtQuiebre WHERE Familia = @Familia
          SELECT @VentaNetaFam = SUM(VentaNeta) FROM CteQuiebre WHERE Familia = @Familia
          SELECT @PresupuestoFam = Cantidad FROM ArtFamPresupuesto WHERE Familia = @Familia AND Ejercicio = YEAR(@Fecha) AND Periodo = MONTH(@Fecha)
          IF @a=0 EXEC spCtePresupuesto @Periodo, @Ejercicio, @Familia, @VentaNetaFam, @PresupuestoFam, @Moneda
          SELECT @UltFamilia = @Familia
        END
        SELECT @Cantidad = (@VentaAjustada / @VentaAjustadaFam) * @PresupuestoFam
        IF ISNULL(@Cantidad, 0.0) > 0.0
        BEGIN
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
          EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
          EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

          EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT
          INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Impuesto1,  Impuesto2,  Impuesto3,  Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Precio)
                 VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Impuesto1, @Impuesto2, @Impuesto3, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @Fecha,          @Precio)
        END
      END
      FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    END
    CLOSE crArtQuiebre
    DEALLOCATE crArtQuiebre

    IF @ID IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID)
        EXEC spInv @ID, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,
                   @Mov, @MovID, NULL, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, NULL
      ELSE
        DELETE Venta WHERE ID = @ID
    END

    SELECT @a = @a + 1, @Fecha = DATEADD(month, 1, @Fecha)
  END

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = 'Proceso Concluido con Exito.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/* 
EXEC spGenerarArtQuiebre 100, 'DEMO', '1/1/4', '1/1/5', 'ALACENA MADERA'
SELECT * FROM ArtQuiebre
*/

/**************** spArtQuiebreActualizarFamilia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizarFamilia') and type = 'P') drop procedure dbo.spArtQuiebreActualizarFamilia
GO             
CREATE PROCEDURE spArtQuiebreActualizarFamilia
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @BasePresupuesto        varchar(20)

  SELECT @BasePresupuesto = UPPER(BasePresupuesto)
    FROM ArtFam 
   WHERE Familia = @Familia

  CREATE TABLE #ArtQuiebre (Articulo char(20) COLLATE Database_Default, Ventas float NULL, Devoluciones float NULL, Faltantes float NULL, Scanner float NULL, VentaAjustada float NULL)
  CREATE TABLE #CteQuiebre (Cliente char(10) COLLATE Database_Default, EnviarA int NULL, Ventas float NULL, Devoluciones float NULL)

  -- Articulos de la Familia
  INSERT #ArtQuiebre (Articulo)
  SELECT Articulo
    FROM Art
   WHERE Familia = @Familia AND Estatus IN ('ALTA', 'PROTOTIPO')

  -- Ventas
  INSERT #ArtQuiebre (Articulo, Ventas)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Ventas)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA

  -- Devoluciones
  INSERT #ArtQuiebre (Articulo, Devoluciones)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Devoluciones)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA 

  -- Faltantes
  INSERT #ArtQuiebre (Articulo, Faltantes)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.VP'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  -- Scanner
  INSERT #ArtQuiebre (Articulo, Scanner)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.EST'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
     AND v.Mov = 'Scanner'
   GROUP BY d.Articulo

  DELETE ArtQuiebre WHERE Familia = @Familia
  INSERT ArtQuiebre 
        (Familia,  Articulo, Ventas,      Devoluciones,      Faltantes,      DemandaNeta,                                                         Scanner)
  SELECT @Familia, q.Articulo, SUM(q.Ventas), SUM(q.Devoluciones), SUM(q.Faltantes), SUM(ISNULL(q.Ventas, 0)-ISNULL(q.Devoluciones, 0)+ISNULL(q.Faltantes, 0)), SUM(q.Scanner)
    FROM #ArtQuiebre q
    JOIN Art a ON a.Articulo = q.Articulo AND a.Estatus IN ('ALTA', 'PROTOTIPO')
   GROUP BY q.Articulo

  IF @BasePresupuesto = 'DEMANDA'
    UPDATE ArtQuiebre SET VentaAjustada = DemandaNeta WHERE Familia = @Familia
  ELSE
    UPDATE ArtQuiebre SET VentaAjustada = Scanner WHERE Familia = @Familia

  DELETE CteQuiebre WHERE Familia = @Familia
  INSERT CteQuiebre (Familia, Cliente, EnviarA, VentaNeta)
  SELECT @Familia, Cliente, ISNULL(EnviarA, 0), ISNULL(SUM(Ventas), 0) + ISNULL(SUM(Devoluciones), 0)
    FROM #CteQuiebre
   GROUP BY Cliente, ISNULL(EnviarA, 0)

  UPDATE ArtFam
     SET UltimoQuiebre = GETDATE(),
         QuiebreFechaD = @FechaD,
         QuiebreFechaA = @FechaA
   WHERE Familia = @Familia

  RETURN
END
GO

-- spArtQuiebreActualizar 100, 'DEMO', '3/1/5', '3/3/5', NULL
/**************** spArtQuiebreActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizar') and type = 'P') drop procedure dbo.spArtQuiebreActualizar
GO             
CREATE PROCEDURE spArtQuiebreActualizar
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Familia = NULLIF(NULLIF(RTRIM(@Familia), ''), '0')
  IF @Familia IS NOT NULL
    EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
  ELSE BEGIN
    DECLARE crArtFam CURSOR FOR
     SELECT Familia
       FROM ArtFam
      WHERE NULLIF(RTRIM(BasePresupuesto), '') IS NOT NULL
  
    OPEN crArtFam
    FETCH NEXT FROM crArtFam INTO @Familia
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
      END
      FETCH NEXT FROM crArtFam INTO @Familia
    END
    CLOSE crArtFam
    DEALLOCATE crArtFam
  END

  SELECT 'Proceso Concluido.'
  RETURN
END
GO


/**************** spCtePresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCtePresupuesto') and type = 'P') drop procedure dbo.spCtePresupuesto
GO             
CREATE PROCEDURE spCtePresupuesto
                        @Periodo                int,
			@Ejercicio              int,
                        @Familia                varchar(50),
                        @VentaNetaFam           float,
                        @PresupuestoFam         float,
                        @Moneda                 char(10) 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cliente        char(10),
    @EnviarA        int,
    @ListaPrecios   varchar(50),
    @Cantidad       float,
    @Precio         float,
    @Importe        money,
    @Articulo	    varchar(20) 

  DECLARE crCteQuiebre CURSOR FOR
   SELECT cq.Cliente, cq.EnviarA, c.ListaPrecios, cq.VentaNeta / @VentaNetaFam * @PresupuestoFam
     FROM CteQuiebre cq, Cte c
    WHERE cq.Familia = @Familia AND cq.Cliente = c.Cliente
  
  OPEN crCteQuiebre
  FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Articulo = MIN(Articulo) FROM ListaPreciosD WHERE Lista = @ListaPrecios
      EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, NULL, @Precio OUTPUT
      SELECT @Importe = @Precio * @Cantidad

      INSERT CtePresupuesto 
             (Cliente,  Ejercicio,  Periodo,  EnviarA,  Familia,  Cantidad,  Importe,  ImporteAjustado)
      VALUES (@Cliente, @Ejercicio, @Periodo, @EnviarA, @Familia, @Cantidad, @Importe, @Importe)

    END
    FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  END
  CLOSE crCteQuiebre
  DEALLOCATE crCteQuiebre

  RETURN
END
GO


-- spArtQuiebreProcesar 100, 'DEMO', 'DEMO', 0, 3, 2005, '1234', 'STOCK'
/**************** spArtQuiebreProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreProcesar') and type = 'P') drop procedure dbo.spArtQuiebreProcesar
GO             
CREATE PROCEDURE spArtQuiebreProcesar
			@Estacion	int,
			@Empresa	char(5),
                        @Usuario        char(10),
                        @Sucursal       int,
                        @Periodo        int,
			@Ejercicio      int,
                        @Cliente        char(10),
                        @Almacen        char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgCompraCostoSugerido  	char(20),
    @a                          int,
    @Ok                         int, 
    @OkRef                      varchar(255), 
    @Moneda		        char(10),
    @TipoCambio		        float,
    @ID                         int,
    @Mov                        varchar(20),
    @MovID                      varchar(20),
    @Fecha                      datetime,
    @Renglon                    float,
    @RenglonID                  int,
    @RenglonTipo                char(1),
    @UltFamilia                 varchar(50),
    @Familia                    varchar(50),
    @Articulo                   char(20),
    @SubCuenta                  varchar(50),
    @Proveedor                  char(10),
    @Precio                     float,
    @Costo                      float,
    @VentaAjustada              float,
    @VentaAjustadaFam           float,
    @Cantidad                   float,
    @CantidadInventario         float,
    @PresupuestoFam             float,
    @VentaNetaFam               float,
    @Unidad                     varchar(50),
    @FechaRegistro		datetime,
    @Impuesto1                  float,
    @Impuesto2                  float,
    @Impuesto3                  money,
    @ArtTipo                    varchar(20),
    @ListaPrecios               varchar(50),
    @Mensaje                    varchar(255)

  SELECT @a = 0, @Ok = NULL, @OkRef = NULL, @UltFamilia = NULL,
         @ListaPrecios = '(Precio Lista)',
         @SubCuenta = NULL,
         @Cliente = NULLIF(NULLIF(RTRIM(@Cliente), '0'), ''),
         @FechaRegistro = GETDATE()

  SELECT @Mov = VentaPresupuesto FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @CfgCompraCostoSugerido = cfg.CompraCostoSugerido,
         @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  EXEC spIntToDateTime 1, @Periodo, @Ejercicio, @Fecha OUTPUT
  DELETE CtePresupuesto WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo

  BEGIN TRANSACTION

  WHILE @a<12 AND @Ok IS NULL
  BEGIN
    SELECT @ID = NULL, @Renglon = 0.0, @RenglonID = 0
    SELECT @ID = ID FROM Venta WHERE Empresa = @Empresa AND Mov = @Mov AND FechaEmision = @Fecha AND Estatus <> 'CANCELADO'
    IF @ID IS NOT NULL
    BEGIN
      EXEC spDesAfectarPresupuesto 'VTAS', @Mov, @ID
      DELETE VentaD WHERE ID = @ID
    END ELSE
    BEGIN
      INSERT Venta (Sucursal,  Empresa,  Mov,  FechaEmision, Moneda,  TipoCambio,  Almacen,  Cliente,  Usuario,  FechaRequerida, ListaPreciosEsp, Estatus)
            VALUES (@Sucursal, @Empresa, @Mov, @Fecha,       @Moneda, @TipoCambio, @Almacen, @Cliente, @Usuario, @Fecha,         @ListaPrecios,   'SINAFECTAR')
      SELECT @ID = SCOPE_IDENTITY()
    END

    DECLARE crArtQuiebre CURSOR FOR
     SELECT aq.Familia, aq.Articulo, aq.VentaAjustada, a.Unidad, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Proveedor, a.Tipo
       FROM ArtQuiebre aq, Art a
      WHERE NULLIF(aq.VentaAjustada, 0) IS NOT NULL AND a.Articulo = aq.Articulo
      ORDER BY aq.Familia, aq.Articulo
  
    OPEN crArtQuiebre
    FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Familia <> @UltFamilia
        BEGIN
          SELECT @VentaAjustadaFam = SUM(VentaAjustada) FROM ArtQuiebre WHERE Familia = @Familia
          SELECT @VentaNetaFam = SUM(VentaNeta) FROM CteQuiebre WHERE Familia = @Familia
          SELECT @PresupuestoFam = Cantidad FROM ArtFamPresupuesto WHERE Familia = @Familia AND Ejercicio = YEAR(@Fecha) AND Periodo = MONTH(@Fecha)
          IF @a=0 EXEC spCtePresupuesto @Periodo, @Ejercicio, @Familia, @VentaNetaFam, @PresupuestoFam, @Moneda
          SELECT @UltFamilia = @Familia
        END
        SELECT @Cantidad = (@VentaAjustada / @VentaAjustadaFam) * @PresupuestoFam
        IF ISNULL(@Cantidad, 0.0) > 0.0
        BEGIN
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
          EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
          EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

          EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT
          INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Impuesto1,  Impuesto2,  Impuesto3,  Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Precio)
                 VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Impuesto1, @Impuesto2, @Impuesto3, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @Fecha,          @Precio)
        END
      END
      FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    END
    CLOSE crArtQuiebre
    DEALLOCATE crArtQuiebre

    IF @ID IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID)
        EXEC spInv @ID, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,
                   @Mov, @MovID, NULL, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, NULL
      ELSE
        DELETE Venta WHERE ID = @ID
    END

    SELECT @a = @a + 1, @Fecha = DATEADD(month, 1, @Fecha)
  END

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = 'Proceso Concluido con Exito.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/* 
EXEC spGenerarArtQuiebre 100, 'DEMO', '1/1/4', '1/1/5', 'ALACENA MADERA'
SELECT * FROM ArtQuiebre
*/

/**************** spArtQuiebreActualizarFamilia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizarFamilia') and type = 'P') drop procedure dbo.spArtQuiebreActualizarFamilia
GO             
CREATE PROCEDURE spArtQuiebreActualizarFamilia
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @BasePresupuesto        varchar(20)

  SELECT @BasePresupuesto = UPPER(BasePresupuesto)
    FROM ArtFam 
   WHERE Familia = @Familia

  CREATE TABLE #ArtQuiebre (Articulo char(20) COLLATE Database_Default, Ventas float NULL, Devoluciones float NULL, Faltantes float NULL, Scanner float NULL, VentaAjustada float NULL)
  CREATE TABLE #CteQuiebre (Cliente char(10) COLLATE Database_Default, EnviarA int NULL, Ventas float NULL, Devoluciones float NULL)

  -- Articulos de la Familia
  INSERT #ArtQuiebre (Articulo)
  SELECT Articulo
    FROM Art
   WHERE Familia = @Familia AND Estatus IN ('ALTA', 'PROTOTIPO')

  -- Ventas
  INSERT #ArtQuiebre (Articulo, Ventas)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Ventas)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA

  -- Devoluciones
  INSERT #ArtQuiebre (Articulo, Devoluciones)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Devoluciones)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA 

  -- Faltantes
  INSERT #ArtQuiebre (Articulo, Faltantes)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.VP'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  -- Scanner
  INSERT #ArtQuiebre (Articulo, Scanner)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.EST'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
     AND v.Mov = 'Scanner'
   GROUP BY d.Articulo

  DELETE ArtQuiebre WHERE Familia = @Familia
  INSERT ArtQuiebre 
        (Familia,  Articulo, Ventas,      Devoluciones,      Faltantes,      DemandaNeta,                                                         Scanner)
  SELECT @Familia, q.Articulo, SUM(q.Ventas), SUM(q.Devoluciones), SUM(q.Faltantes), SUM(ISNULL(q.Ventas, 0)-ISNULL(q.Devoluciones, 0)+ISNULL(q.Faltantes, 0)), SUM(q.Scanner)
    FROM #ArtQuiebre q
    JOIN Art a ON a.Articulo = q.Articulo AND a.Estatus IN ('ALTA', 'PROTOTIPO')
   GROUP BY q.Articulo

  IF @BasePresupuesto = 'DEMANDA'
    UPDATE ArtQuiebre SET VentaAjustada = DemandaNeta WHERE Familia = @Familia
  ELSE
    UPDATE ArtQuiebre SET VentaAjustada = Scanner WHERE Familia = @Familia

  DELETE CteQuiebre WHERE Familia = @Familia
  INSERT CteQuiebre (Familia, Cliente, EnviarA, VentaNeta)
  SELECT @Familia, Cliente, ISNULL(EnviarA, 0), ISNULL(SUM(Ventas), 0) + ISNULL(SUM(Devoluciones), 0)
    FROM #CteQuiebre
   GROUP BY Cliente, ISNULL(EnviarA, 0)

  UPDATE ArtFam
     SET UltimoQuiebre = GETDATE(),
         QuiebreFechaD = @FechaD,
         QuiebreFechaA = @FechaA
   WHERE Familia = @Familia

  RETURN
END
GO

-- spArtQuiebreActualizar 100, 'DEMO', '3/1/5', '3/3/5', NULL
/**************** spArtQuiebreActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizar') and type = 'P') drop procedure dbo.spArtQuiebreActualizar
GO             
CREATE PROCEDURE spArtQuiebreActualizar
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Familia = NULLIF(NULLIF(RTRIM(@Familia), ''), '0')
  IF @Familia IS NOT NULL
    EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
  ELSE BEGIN
    DECLARE crArtFam CURSOR FOR
     SELECT Familia
       FROM ArtFam
      WHERE NULLIF(RTRIM(BasePresupuesto), '') IS NOT NULL
  
    OPEN crArtFam
    FETCH NEXT FROM crArtFam INTO @Familia
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
      END
      FETCH NEXT FROM crArtFam INTO @Familia
    END
    CLOSE crArtFam
    DEALLOCATE crArtFam
  END

  SELECT 'Proceso Concluido.'
  RETURN
END
GO


/**************** spCtePresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCtePresupuesto') and type = 'P') drop procedure dbo.spCtePresupuesto
GO             
CREATE PROCEDURE spCtePresupuesto
                        @Periodo                int,
			@Ejercicio              int,
                        @Familia                varchar(50),
                        @VentaNetaFam           float,
                        @PresupuestoFam         float,
                        @Moneda                 char(10) 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cliente        char(10),
    @EnviarA        int,
    @ListaPrecios   varchar(50),
    @Cantidad       float,
    @Precio         float,
    @Importe        money,
    @Articulo	    varchar(20) 

  DECLARE crCteQuiebre CURSOR FOR
   SELECT cq.Cliente, cq.EnviarA, c.ListaPrecios, cq.VentaNeta / @VentaNetaFam * @PresupuestoFam
     FROM CteQuiebre cq, Cte c
    WHERE cq.Familia = @Familia AND cq.Cliente = c.Cliente
  
  OPEN crCteQuiebre
  FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Articulo = MIN(Articulo) FROM ListaPreciosD WHERE Lista = @ListaPrecios
      EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, NULL, @Precio OUTPUT
      SELECT @Importe = @Precio * @Cantidad

      INSERT CtePresupuesto 
             (Cliente,  Ejercicio,  Periodo,  EnviarA,  Familia,  Cantidad,  Importe,  ImporteAjustado)
      VALUES (@Cliente, @Ejercicio, @Periodo, @EnviarA, @Familia, @Cantidad, @Importe, @Importe)

    END
    FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  END
  CLOSE crCteQuiebre
  DEALLOCATE crCteQuiebre

  RETURN
END
GO


-- spArtQuiebreProcesar 100, 'DEMO', 'DEMO', 0, 3, 2005, '1234', 'STOCK'
/**************** spArtQuiebreProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreProcesar') and type = 'P') drop procedure dbo.spArtQuiebreProcesar
GO             
CREATE PROCEDURE spArtQuiebreProcesar
			@Estacion	int,
			@Empresa	char(5),
                        @Usuario        char(10),
                        @Sucursal       int,
                        @Periodo        int,
			@Ejercicio      int,
                        @Cliente        char(10),
                        @Almacen        char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgCompraCostoSugerido  	char(20),
    @a                          int,
    @Ok                         int, 
    @OkRef                      varchar(255), 
    @Moneda		        char(10),
    @TipoCambio		        float,
    @ID                         int,
    @Mov                        varchar(20),
    @MovID                      varchar(20),
    @Fecha                      datetime,
    @Renglon                    float,
    @RenglonID                  int,
    @RenglonTipo                char(1),
    @UltFamilia                 varchar(50),
    @Familia                    varchar(50),
    @Articulo                   char(20),
    @SubCuenta                  varchar(50),
    @Proveedor                  char(10),
    @Precio                     float,
    @Costo                      float,
    @VentaAjustada              float,
    @VentaAjustadaFam           float,
    @Cantidad                   float,
    @CantidadInventario         float,
    @PresupuestoFam             float,
    @VentaNetaFam               float,
    @Unidad                     varchar(50),
    @FechaRegistro		datetime,
    @Impuesto1                  float,
    @Impuesto2                  float,
    @Impuesto3                  money,
    @ArtTipo                    varchar(20),
    @ListaPrecios               varchar(50),
    @Mensaje                    varchar(255)

  SELECT @a = 0, @Ok = NULL, @OkRef = NULL, @UltFamilia = NULL,
         @ListaPrecios = '(Precio Lista)',
         @SubCuenta = NULL,
         @Cliente = NULLIF(NULLIF(RTRIM(@Cliente), '0'), ''),
         @FechaRegistro = GETDATE()

  SELECT @Mov = VentaPresupuesto FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @CfgCompraCostoSugerido = cfg.CompraCostoSugerido,
         @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  EXEC spIntToDateTime 1, @Periodo, @Ejercicio, @Fecha OUTPUT
  DELETE CtePresupuesto WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo

  BEGIN TRANSACTION

  WHILE @a<12 AND @Ok IS NULL
  BEGIN
    SELECT @ID = NULL, @Renglon = 0.0, @RenglonID = 0
    SELECT @ID = ID FROM Venta WHERE Empresa = @Empresa AND Mov = @Mov AND FechaEmision = @Fecha AND Estatus <> 'CANCELADO'
    IF @ID IS NOT NULL
    BEGIN
      EXEC spDesAfectarPresupuesto 'VTAS', @Mov, @ID
      DELETE VentaD WHERE ID = @ID
    END ELSE
    BEGIN
      INSERT Venta (Sucursal,  Empresa,  Mov,  FechaEmision, Moneda,  TipoCambio,  Almacen,  Cliente,  Usuario,  FechaRequerida, ListaPreciosEsp, Estatus)
            VALUES (@Sucursal, @Empresa, @Mov, @Fecha,       @Moneda, @TipoCambio, @Almacen, @Cliente, @Usuario, @Fecha,         @ListaPrecios,   'SINAFECTAR')
      SELECT @ID = SCOPE_IDENTITY()
    END

    DECLARE crArtQuiebre CURSOR FOR
     SELECT aq.Familia, aq.Articulo, aq.VentaAjustada, a.Unidad, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Proveedor, a.Tipo
       FROM ArtQuiebre aq, Art a
      WHERE NULLIF(aq.VentaAjustada, 0) IS NOT NULL AND a.Articulo = aq.Articulo
      ORDER BY aq.Familia, aq.Articulo
  
    OPEN crArtQuiebre
    FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Familia <> @UltFamilia
        BEGIN
          SELECT @VentaAjustadaFam = SUM(VentaAjustada) FROM ArtQuiebre WHERE Familia = @Familia
          SELECT @VentaNetaFam = SUM(VentaNeta) FROM CteQuiebre WHERE Familia = @Familia
          SELECT @PresupuestoFam = Cantidad FROM ArtFamPresupuesto WHERE Familia = @Familia AND Ejercicio = YEAR(@Fecha) AND Periodo = MONTH(@Fecha)
          IF @a=0 EXEC spCtePresupuesto @Periodo, @Ejercicio, @Familia, @VentaNetaFam, @PresupuestoFam, @Moneda
          SELECT @UltFamilia = @Familia
        END
        SELECT @Cantidad = (@VentaAjustada / @VentaAjustadaFam) * @PresupuestoFam
        IF ISNULL(@Cantidad, 0.0) > 0.0
        BEGIN
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
          EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
          EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

          EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT
          INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Impuesto1,  Impuesto2,  Impuesto3,  Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Precio)
                 VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Impuesto1, @Impuesto2, @Impuesto3, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @Fecha,          @Precio)
        END
      END
      FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    END
    CLOSE crArtQuiebre
    DEALLOCATE crArtQuiebre

    IF @ID IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID)
        EXEC spInv @ID, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,
                   @Mov, @MovID, NULL, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, NULL
      ELSE
        DELETE Venta WHERE ID = @ID
    END

    SELECT @a = @a + 1, @Fecha = DATEADD(month, 1, @Fecha)
  END

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = 'Proceso Concluido con Exito.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/* 
EXEC spGenerarArtQuiebre 100, 'DEMO', '1/1/4', '1/1/5', 'ALACENA MADERA'
SELECT * FROM ArtQuiebre
*/

/**************** spArtQuiebreActualizarFamilia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizarFamilia') and type = 'P') drop procedure dbo.spArtQuiebreActualizarFamilia
GO             
CREATE PROCEDURE spArtQuiebreActualizarFamilia
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @BasePresupuesto        varchar(20)

  SELECT @BasePresupuesto = UPPER(BasePresupuesto)
    FROM ArtFam 
   WHERE Familia = @Familia

  CREATE TABLE #ArtQuiebre (Articulo char(20) COLLATE Database_Default, Ventas float NULL, Devoluciones float NULL, Faltantes float NULL, Scanner float NULL, VentaAjustada float NULL)
  CREATE TABLE #CteQuiebre (Cliente char(10) COLLATE Database_Default, EnviarA int NULL, Ventas float NULL, Devoluciones float NULL)

  -- Articulos de la Familia
  INSERT #ArtQuiebre (Articulo)
  SELECT Articulo
    FROM Art
   WHERE Familia = @Familia AND Estatus IN ('ALTA', 'PROTOTIPO')

  -- Ventas
  INSERT #ArtQuiebre (Articulo, Ventas)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Ventas)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA

  -- Devoluciones
  INSERT #ArtQuiebre (Articulo, Devoluciones)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  INSERT #CteQuiebre (Cliente, EnviarA, Devoluciones)
  SELECT v.Cliente, v.EnviarA, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.D', 'VTAS.DF')
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY v.Cliente, v.EnviarA 

  -- Faltantes
  INSERT #ArtQuiebre (Articulo, Faltantes)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.VP'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  -- Scanner
  INSERT #ArtQuiebre (Articulo, Scanner)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.EST'
    JOIN VentaD d ON d.ID = v.ID
    JOIN Art a ON a.Articulo = d.Articulo AND a.Familia = @Familia
   WHERE v.Empresa = @Empresa AND v.Estatus = 'CONCLUIDO' AND v.FechaEmision BETWEEN @FechaD AND @FechaA
     AND v.Mov = 'Scanner'
   GROUP BY d.Articulo

  DELETE ArtQuiebre WHERE Familia = @Familia
  INSERT ArtQuiebre 
        (Familia,  Articulo, Ventas,      Devoluciones,      Faltantes,      DemandaNeta,                                                         Scanner)
  SELECT @Familia, q.Articulo, SUM(q.Ventas), SUM(q.Devoluciones), SUM(q.Faltantes), SUM(ISNULL(q.Ventas, 0)-ISNULL(q.Devoluciones, 0)+ISNULL(q.Faltantes, 0)), SUM(q.Scanner)
    FROM #ArtQuiebre q
    JOIN Art a ON a.Articulo = q.Articulo AND a.Estatus IN ('ALTA', 'PROTOTIPO')
   GROUP BY q.Articulo

  IF @BasePresupuesto = 'DEMANDA'
    UPDATE ArtQuiebre SET VentaAjustada = DemandaNeta WHERE Familia = @Familia
  ELSE
    UPDATE ArtQuiebre SET VentaAjustada = Scanner WHERE Familia = @Familia

  DELETE CteQuiebre WHERE Familia = @Familia
  INSERT CteQuiebre (Familia, Cliente, EnviarA, VentaNeta)
  SELECT @Familia, Cliente, ISNULL(EnviarA, 0), ISNULL(SUM(Ventas), 0) + ISNULL(SUM(Devoluciones), 0)
    FROM #CteQuiebre
   GROUP BY Cliente, ISNULL(EnviarA, 0)

  UPDATE ArtFam
     SET UltimoQuiebre = GETDATE(),
         QuiebreFechaD = @FechaD,
         QuiebreFechaA = @FechaA
   WHERE Familia = @Familia

  RETURN
END
GO

-- spArtQuiebreActualizar 100, 'DEMO', '3/1/5', '3/3/5', NULL
/**************** spArtQuiebreActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreActualizar') and type = 'P') drop procedure dbo.spArtQuiebreActualizar
GO             
CREATE PROCEDURE spArtQuiebreActualizar
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
			@Familia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Familia = NULLIF(NULLIF(RTRIM(@Familia), ''), '0')
  IF @Familia IS NOT NULL
    EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
  ELSE BEGIN
    DECLARE crArtFam CURSOR FOR
     SELECT Familia
       FROM ArtFam
      WHERE NULLIF(RTRIM(BasePresupuesto), '') IS NOT NULL
  
    OPEN crArtFam
    FETCH NEXT FROM crArtFam INTO @Familia
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spArtQuiebreActualizarFamilia @Estacion, @Empresa, @FechaD, @FechaA, @Familia
      END
      FETCH NEXT FROM crArtFam INTO @Familia
    END
    CLOSE crArtFam
    DEALLOCATE crArtFam
  END

  SELECT 'Proceso Concluido.'
  RETURN
END
GO


/**************** spCtePresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCtePresupuesto') and type = 'P') drop procedure dbo.spCtePresupuesto
GO             
CREATE PROCEDURE spCtePresupuesto
                        @Periodo                int,
			@Ejercicio              int,
                        @Familia                varchar(50),
                        @VentaNetaFam           float,
                        @PresupuestoFam         float,
                        @Moneda                 char(10) 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cliente        char(10),
    @EnviarA        int,
    @ListaPrecios   varchar(50),
    @Cantidad       float,
    @Precio         float,
    @Importe        money,
    @Articulo	    varchar(20) 

  DECLARE crCteQuiebre CURSOR FOR
   SELECT cq.Cliente, cq.EnviarA, c.ListaPrecios, cq.VentaNeta / @VentaNetaFam * @PresupuestoFam
     FROM CteQuiebre cq, Cte c
    WHERE cq.Familia = @Familia AND cq.Cliente = c.Cliente
  
  OPEN crCteQuiebre
  FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Articulo = MIN(Articulo) FROM ListaPreciosD WHERE Lista = @ListaPrecios
      EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, NULL, @Precio OUTPUT
      SELECT @Importe = @Precio * @Cantidad

      INSERT CtePresupuesto 
             (Cliente,  Ejercicio,  Periodo,  EnviarA,  Familia,  Cantidad,  Importe,  ImporteAjustado)
      VALUES (@Cliente, @Ejercicio, @Periodo, @EnviarA, @Familia, @Cantidad, @Importe, @Importe)

    END
    FETCH NEXT FROM crCteQuiebre INTO @Cliente, @EnviarA, @ListaPrecios, @Cantidad
  END
  CLOSE crCteQuiebre
  DEALLOCATE crCteQuiebre

  RETURN
END
GO


-- spArtQuiebreProcesar 100, 'DEMO', 'DEMO', 0, 3, 2005, '1234', 'STOCK'
/**************** spArtQuiebreProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtQuiebreProcesar') and type = 'P') drop procedure dbo.spArtQuiebreProcesar
GO             
CREATE PROCEDURE spArtQuiebreProcesar
			@Estacion	int,
			@Empresa	char(5),
                        @Usuario        char(10),
                        @Sucursal       int,
                        @Periodo        int,
			@Ejercicio      int,
                        @Cliente        char(10),
                        @Almacen        char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgCompraCostoSugerido  	char(20),
    @a                          int,
    @Ok                         int, 
    @OkRef                      varchar(255), 
    @Moneda		        char(10),
    @TipoCambio		        float,
    @ID                         int,
    @Mov                        varchar(20),
    @MovID                      varchar(20),
    @Fecha                      datetime,
    @Renglon                    float,
    @RenglonID                  int,
    @RenglonTipo                char(1),
    @UltFamilia                 varchar(50),
    @Familia                    varchar(50),
    @Articulo                   char(20),
    @SubCuenta                  varchar(50),
    @Proveedor                  char(10),
    @Precio                     float,
    @Costo                      float,
    @VentaAjustada              float,
    @VentaAjustadaFam           float,
    @Cantidad                   float,
    @CantidadInventario         float,
    @PresupuestoFam             float,
    @VentaNetaFam               float,
    @Unidad                     varchar(50),
    @FechaRegistro		datetime,
    @Impuesto1                  float,
    @Impuesto2                  float,
    @Impuesto3                  money,
    @ArtTipo                    varchar(20),
    @ListaPrecios               varchar(50),
    @Mensaje                    varchar(255)

  SELECT @a = 0, @Ok = NULL, @OkRef = NULL, @UltFamilia = NULL,
         @ListaPrecios = '(Precio Lista)',
         @SubCuenta = NULL,
         @Cliente = NULLIF(NULLIF(RTRIM(@Cliente), '0'), ''),
         @FechaRegistro = GETDATE()

  SELECT @Mov = VentaPresupuesto FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @CfgCompraCostoSugerido = cfg.CompraCostoSugerido,
         @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  EXEC spIntToDateTime 1, @Periodo, @Ejercicio, @Fecha OUTPUT
  DELETE CtePresupuesto WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo

  BEGIN TRANSACTION

  WHILE @a<12 AND @Ok IS NULL
  BEGIN
    SELECT @ID = NULL, @Renglon = 0.0, @RenglonID = 0
    SELECT @ID = ID FROM Venta WHERE Empresa = @Empresa AND Mov = @Mov AND FechaEmision = @Fecha AND Estatus <> 'CANCELADO'
    IF @ID IS NOT NULL
    BEGIN
      EXEC spDesAfectarPresupuesto 'VTAS', @Mov, @ID
      DELETE VentaD WHERE ID = @ID
    END ELSE
    BEGIN
      INSERT Venta (Sucursal,  Empresa,  Mov,  FechaEmision, Moneda,  TipoCambio,  Almacen,  Cliente,  Usuario,  FechaRequerida, ListaPreciosEsp, Estatus)
            VALUES (@Sucursal, @Empresa, @Mov, @Fecha,       @Moneda, @TipoCambio, @Almacen, @Cliente, @Usuario, @Fecha,         @ListaPrecios,   'SINAFECTAR')
      SELECT @ID = SCOPE_IDENTITY()
    END

    DECLARE crArtQuiebre CURSOR FOR
     SELECT aq.Familia, aq.Articulo, aq.VentaAjustada, a.Unidad, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Proveedor, a.Tipo
       FROM ArtQuiebre aq, Art a
      WHERE NULLIF(aq.VentaAjustada, 0) IS NOT NULL AND a.Articulo = aq.Articulo
      ORDER BY aq.Familia, aq.Articulo
  
    OPEN crArtQuiebre
    FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Familia <> @UltFamilia
        BEGIN
          SELECT @VentaAjustadaFam = SUM(VentaAjustada) FROM ArtQuiebre WHERE Familia = @Familia
          SELECT @VentaNetaFam = SUM(VentaNeta) FROM CteQuiebre WHERE Familia = @Familia
          SELECT @PresupuestoFam = Cantidad FROM ArtFamPresupuesto WHERE Familia = @Familia AND Ejercicio = YEAR(@Fecha) AND Periodo = MONTH(@Fecha)
          IF @a=0 EXEC spCtePresupuesto @Periodo, @Ejercicio, @Familia, @VentaNetaFam, @PresupuestoFam, @Moneda
          SELECT @UltFamilia = @Familia
        END
        SELECT @Cantidad = (@VentaAjustada / @VentaAjustadaFam) * @PresupuestoFam
        IF ISNULL(@Cantidad, 0.0) > 0.0
        BEGIN
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
          EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
          EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

          EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT
          INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Impuesto1,  Impuesto2,  Impuesto3,  Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Precio)
                 VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Impuesto1, @Impuesto2, @Impuesto3, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @Fecha,          @Precio)
        END
      END
      FETCH NEXT FROM crArtQuiebre INTO @Familia, @Articulo, @VentaAjustada, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Proveedor, @ArtTipo
    END
    CLOSE crArtQuiebre
    DEALLOCATE crArtQuiebre

    IF @ID IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID)
        EXEC spInv @ID, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,
                   @Mov, @MovID, NULL, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, NULL
      ELSE
        DELETE Venta WHERE ID = @ID
    END

    SELECT @a = @a + 1, @Fecha = DATEADD(month, 1, @Fecha)
  END

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = 'Proceso Concluido con Exito.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/**************** spAutoAplicarRef ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAutoAplicarRef') and type = 'P') drop procedure dbo.spAutoAplicarRef
GO             
CREATE PROCEDURE spAutoAplicarRef
			@Modulo		char(5),
			@Empresa	char(5),
                        @Usuario	char(10),
			@Sucursal	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo		int,
    @AplicaOk		int,
    @AplicaOkRef	varchar(255),
    @AplicaSucursal	int,
    @Ok			int,
    @OkRef		varchar(255),
    @FechaRegistro	datetime,
    @AplicacionMov	varchar(20),
    @AplicacionMovID	varchar(20),
    @AplicacionID	int,
    @ID			int,
    @Mov		char(20),
    @MovID		varchar(20),
    @Referencia		varchar(50),
    @Contacto		char(10),
    @Saldo		money,
    @Importe		money,
    @Moneda		char(10),
    @RefID		int,
    @RefMov		varchar(20),
    @RefMovID		varchar(20),
    @RefSaldo		money

  SELECT @FechaRegistro = GETDATE(), @Ok = NULL, @OkRef = NULL, @Conteo = 0
  SELECT @AplicacionMov = CASE @Modulo WHEN 'CXC' THEN CxcAplicacion ELSE CxpAplicacion END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Modulo = 'CXC'
    DECLARE crCreditos CURSOR FOR
      SELECT c.ID, c.Mov, c.MovID, c.Cliente, NULLIF(RTRIM(c.Referencia), ''), c.Saldo, c.Moneda
        FROM Cxc c, MovTipo mt
       WHERE mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.DA', 'CXC.NC', 'CXC.DAC', 'CXC.NCD', 'CXC.NCF', 'CXC.NCP', 'CXC.DV')
         AND c.Estatus = 'PENDIENTE' AND c.Empresa = @Empresa AND ISNULL(c.Saldo, 0) > 0
  ELSE
    DECLARE crCreditos CURSOR FOR
      SELECT c.ID, c.Mov, c.MovID, c.Proveedor, NULLIF(RTRIM(c.Referencia), ''), c.Saldo, c.Moneda
        FROM Cxp c, MovTipo mt
       WHERE mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXP.A', 'CXP.DA', 'CXP.NC', 'CXP.DAC', 'CXP.NCD', 'CXP.NCF', 'CXP.NCP')
         AND c.Estatus = 'PENDIENTE' AND c.Empresa = @Empresa AND ISNULL(c.Saldo, 0) > 0

  OPEN crCreditos
  FETCH NEXT FROM crCreditos INTO @ID, @Mov, @MovID, @Contacto, @Referencia, @Saldo, @Moneda
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @AplicaOk = NULL, @AplicaOkRef = NULL
      EXEC spAplicaOk @Empresa, @Usuario, @Modulo, @ID, @AplicaOk OUTPUT, @AplicaOkRef OUTPUT, @AplicaSucursal OUTPUT
      IF @AplicaOk IS NULL
      BEGIN
        SELECT @RefID = NULL, @RefSaldo = 0.0
        IF @Modulo = 'CXC'
          SELECT @RefID = MIN(ID) FROM Cxc c, MovTipo mt WHERE mt.Mov = c.Mov AND mt.Modulo = @Modulo AND mt.Clave IN ('CXC.F','CXC.FA','CXC.AF','CXC.CA','CXC.CAD','CXC.CAP','CXC.CD','CXC.D','CXC.DM','CXC.DA','CXC.IM','CXC.RM') AND c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND c.Cliente = @Contacto   AND c.Moneda = @Moneda AND (RTRIM(c.Mov)+' '+RTRIM(c.MovID) = @Referencia OR (@Referencia IS NULL AND ROUND(c.Saldo, 0) = ROUND(@Saldo, 0)))
        ELSE
          SELECT @RefID = MIN(ID) FROM Cxp c, MovTipo mt WHERE mt.Mov = c.Mov AND mt.Modulo = @Modulo AND mt.Clave IN ('CXP.F','CXP.FA','CXP.AF','CXP.CA', 'CXP.CAD','CXP.CAP','CXP.CD','CXP.D','CXP.DM','CXP.DA') AND c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND c.Proveedor = @Contacto AND c.Moneda = @Moneda AND (RTRIM(c.Mov)+' '+RTRIM(c.MovID) = @Referencia OR (@Referencia IS NULL AND ROUND(c.Saldo, 0) = ROUND(@Saldo, 0)))

        IF @RefID IS NOT NULL
        BEGIN
          IF @Modulo = 'CXC'
            SELECT @RefMov = Mov, @RefMovID = MovID, @RefSaldo = ISNULL(Saldo, 0) FROM Cxc WHERE ID = @RefID
          ELSE
            SELECT @RefMov = Mov, @RefMovID = MovID, @RefSaldo = ISNULL(Saldo, 0) FROM Cxp WHERE ID = @RefID
        END

        IF @RefSaldo > 0.0
        BEGIN
          EXEC spCx @ID, @Modulo, 'GENERAR', 'TODO', @FechaRegistro, @AplicacionMov, @Usuario, 0, 0, @AplicacionMov OUTPUT, @AplicacionMovID OUTPUT, @AplicacionID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IN (NULL, 80030) AND @AplicacionID IS NOT NULL
          BEGIN
            SELECT @Ok = NULL, @OkRef = NULL
            IF @RefSaldo > @Saldo 
              SELECT @Importe = @Saldo 
            ELSE SELECT @Importe = @RefSaldo
            
            IF @Modulo = 'CXC'
            BEGIN
              UPDATE Cxc SET Importe = @Importe WHERE ID = @AplicacionID
              INSERT CxcD (ID, Renglon, Importe, Aplica, AplicaID) VALUES (@AplicacionID, 2048, @Importe, @RefMov, @RefMovID)
            END 
            ELSE BEGIN
              UPDATE Cxp SET Importe = @Importe WHERE ID = @AplicacionID
              INSERT CxpD (ID, Renglon, Importe, Aplica, AplicaID) VALUES (@AplicacionID, 2048, @Importe, @RefMov, @RefMovID)
            END

            EXEC spCx @AplicacionID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @AplicacionMov OUTPUT, @AplicacionMovID OUTPUT, @AplicacionID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
            IF @Ok IS NULL
              SELECT @Conteo = @Conteo + 1
          END
        END
      END
    END
    FETCH NEXT FROM crCreditos INTO @ID, @Mov, @MovID, @Contacto, @Referencia, @Saldo, @Moneda
  END  -- While	
  CLOSE crCreditos
  DEALLOCATE crCreditos

  IF @Ok IS NULL SELECT @OkRef = RTRIM(Convert(char, @Conteo))+' Aplicaciones Realizadas.'
  SELECT @OkRef
  RETURN 
END
GO

/**************** spAvanzarListaProdSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAvanzarListaProdSerieLote') and type = 'P') drop procedure dbo.spAvanzarListaProdSerieLote
GO             
CREATE PROCEDURE spAvanzarListaProdSerieLote
		    @Empresa		char(5),
		    @Usuario		char(10),
		    @Estacion		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok		int,
    @OkRef	varchar(255),
    @SerieLote	varchar(50),
    @Mensaje	varchar(255)

  DECLARE crListaProdSerieLote CURSOR FOR
   SELECT SerieLote
     FROM ListaProdSerieLote
    WHERE Estacion = @Estacion
  OPEN crListaProdSerieLote
  FETCH NEXT FROM crListaProdSerieLote INTO @SerieLote
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spAvanzarProdSerieLote @Empresa, @Usuario, @SerieLote, 1, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL DELETE ListaProdSerieLote WHERE CURRENT OF crListaProdSerieLote
    END
    FETCH NEXT FROM crListaProdSerieLote INTO @SerieLote
  END
  CLOSE crListaProdSerieLote
  DEALLOCATE crListaProdSerieLote
  IF @Ok IS NULL 
    SELECT @Mensaje = 'Avance Realizado con Exito.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

-- select * from ctepresupuesto
-- select * from venta
-- spAvanzarProdSerieLote 'SAM', 'MASTER1', '789'
/**************** spAvanzarProdSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAvanzarProdSerieLote') and type = 'P') drop procedure dbo.spAvanzarProdSerieLote
GO             
CREATE PROCEDURE spAvanzarProdSerieLote
		    @Empresa		char(5),
		    @Usuario		char(10),
		    @ProdSerieLote	varchar(20),
		    @EnSilencio		bit 		= 0,
    		    @Ok			int		= NULL	OUTPUT,
    		    @OkRef		varchar(255)	= NULL	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaRegistro		datetime,
    @MovAvance			varchar(20),
    @MovEntradaProduccion	varchar(20),
    @ID				int,
    @Mov			char(20),
    @MovID			char(20),
    @IDGenerar			int,
    @Mensaje			varchar(255)

  SELECT @FechaRegistro = GETDATE()
  SELECT @MovAvance = ProdAvance,
         @MovEntradaProduccion = ProdEntradaProduccion
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @ID = MIN(ID) FROM ProdSerieLotePendiente WHERE Empresa = @Empresa AND ProdSerieLote = @ProdSerieLote
  IF @ID IS NOT NULL
  BEGIN
    BEGIN TRANSACTION
    -- Generar Avance
    IF EXISTS(SELECT * FROM ProdD WHERE ID = @ID AND NULLIF(RTRIM(CentroDestino), '') IS NOT NULL)
    BEGIN
      UPDATE ProdD SET CantidadA = NULL WHERE ID = @ID
      UPDATE ProdD SET CantidadA = NULLIF(CantidadPendiente, 0) WHERE ID = @ID AND NULLIF(RTRIM(CentroDestino), '') IS NOT NULL AND ProdSerieLote = @ProdSerieLote
      IF EXISTS(SELECT * FROM ProdD WHERE ID = @ID AND CantidadA IS NOT NULL)
      BEGIN
        EXEC spInv @ID, 'PROD', 'GENERAR', 'SELECCION', @FechaRegistro, @MovAvance, @Usuario, 1, 0, NULL,
                   @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, NULL
        IF @Ok IN (80030, 80060) SELECT @Ok = NULL, @OkRef = NULL
        IF @IDGenerar IS NOT NULL AND @Ok IS NULL
          EXEC spInv @IDGenerar, 'PROD', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                     @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, NULL,
                     @Ok OUTPUT, @OkRef OUTPUT, NULL        
      END
    END ELSE

    -- Generar Entrada
    IF EXISTS(SELECT * FROM ProdD WHERE ID = @ID AND NULLIF(RTRIM(CentroDestino), '') IS NULL)
    BEGIN
      UPDATE ProdD SET CantidadA = NULL WHERE ID = @ID
      UPDATE ProdD SET CantidadA = NULLIF(CantidadPendiente, 0) WHERE ID = @ID AND NULLIF(RTRIM(CentroDestino), '') IS NULL AND ProdSerieLote = @ProdSerieLote
      IF EXISTS(SELECT * FROM ProdD WHERE ID = @ID AND CantidadA IS NOT NULL)
      BEGIN
        EXEC spInv @ID, 'PROD', 'GENERAR', 'SELECCION', @FechaRegistro, @MovEntradaProduccion, @Usuario, 1, 0, NULL,
                   @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, NULL
        IF @Ok IN (80030, 80060) SELECT @Ok = NULL, @OkRef = NULL
        IF @IDGenerar IS NOT NULL AND @Ok IS NULL
          EXEC spInv @IDGenerar, 'PROD', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                     @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, NULL,
                     @Ok OUTPUT, @OkRef OUTPUT, NULL        
      END
    END

    IF @Ok IS NULL
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
  END ELSE
    SELECT @Ok = 25255, @OkRef = @ProdSerieLote

  IF @EnSilencio = 0 
  BEGIN
    IF @Ok IS NULL 
      SELECT @Mensaje = 'Avance Realizado con Exito.'
    ELSE
      SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

    SELECT @Mensaje
  END
  RETURN
END
GO

/**************** spCalcularVIN_ISAN ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcularVIN_ISAN') and type = 'P') drop procedure dbo.spCalcularVIN_ISAN
GO             
CREATE PROCEDURE spCalcularVIN_ISAN
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo		char(20),
    @PrecioSinISAN	float,
    @LimiteInferior	money,
    @LimiteSuperior	money,
    @Cuota		money,
    @Porcentaje		float,
    @ISAN		money,
    @Cuantos		int,
    @Ok			int,
    @OkRef		varchar(255)

  SELECT @Cuantos = 0, @Ok = NULL, @OkRef = NULL
  BEGIN TRANSACTION
    DECLARE crArt CURSOR FOR
      SELECT Articulo, Precio2
        FROM Art
       WHERE Tipo = 'VIN' AND ISNULL(Precio2, 0) IS NOT NULL

    OPEN crArt
    FETCH NEXT FROM crArt INTO @Articulo, @PrecioSinISAN
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @LimiteInferior = ISNULL(LimiteInferior, 0), 
               @LimiteSuperior = ISNULL(LimiteSuperior, 0),
               @Cuota          = ISNULL(Cuota, 0),
               @Porcentaje     = ISNULL(Porcentaje, 0)
          FROM TablaImpuestoD 
         WHERE TablaImpuesto = 'ISAN' AND PeriodoTipo = '(sin Periodo)'
               AND @PrecioSinISAN BETWEEN LimiteInferior AND LimiteSuperior
        IF @@ROWCOUNT = 0 SELECT @Ok = 1
        SELECT @ISAN = ((@PrecioSinISAN-@LimiteInferior)*(@Porcentaje/100.0))+@Cuota

        SELECT @LimiteInferior = ISNULL(LimiteInferior, 0), 
               @LimiteSuperior = ISNULL(LimiteSuperior, 0),
               @Cuota          = ISNULL(Cuota, 0),
               @Porcentaje     = ISNULL(Porcentaje, 0)
          FROM TablaImpuestoD 
         WHERE TablaImpuesto = 'ISAN (Lujo)' AND PeriodoTipo = '(sin Periodo)'
               AND @PrecioSinISAN BETWEEN LimiteInferior AND LimiteSuperior
        IF @@ROWCOUNT > 0 
          SELECT @ISAN = @ISAN - ((@PrecioSinISAN-@LimiteInferior)*(@Porcentaje/100.0))+@Cuota

        UPDATE Art
           SET Precio3     = @ISAN,
               PrecioLista = @PrecioSinISAN + @ISAN
         WHERE CURRENT of crArt

        SELECT @Cuantos = @Cuantos + 1
      END
      FETCH NEXT FROM crArt INTO @Articulo, @PrecioSinISAN
    END  -- While	
    CLOSE crArt
    DEALLOCATE crArt

  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  IF @Ok IS NULL SELECT @OkRef = RTRIM(Convert(char, @Cuantos))+' Precios Calculados.' ELSE
  IF @Ok = 1     SELECT @OkRef = 'No Esta Correctamente Definida la Tabla de Impuestos: ISAN' 
  SELECT @OkRef
  RETURN 
END
GO

-- select * from listast
-- spCBLote 10, 'DEMO', 'PROD', 2
/**************** spCBLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCBLote') and type = 'P') drop procedure dbo.spCBLote
GO             
CREATE PROCEDURE spCBLote
                    @Estacion		int,
		    @Empresa		char(5),
		    @Modulo		char(5),
		    @ID			int,
		    @AplicaMov		char(20)	= NULL,
		    @AplicaMovID	varchar(20)	= NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CfgCompraCostoSugerido  	char(20),
    @CfgCBSerieLote		bit,
    @Moneda			char(10),
    @TipoCambio			float,
    @Sucursal			int,
    @Cliente			char(10),
    @Proveedor			char(10),
    @Idioma			varchar(50),
    @Almacen			char(10),
    @FechaRequerida		datetime,
    @ArtTipo			varchar(20),
    @MovTipo			char(20),
    @Clave			varchar(100),
    @TipoCuenta			char(20),
    @Cuenta			char(20),
    @SubCuenta			varchar(50),
    @Unidad			varchar(50),
    @Cantidad			float,
    @SerieLote			varchar(50),
    @Renglon			float,
    @RenglonID			int,
    @Directo			bit,
    @TienePaquetes		bit,
    @Paquete			int,
    @ZonaImpuesto		varchar(50),
    @Estatus                    char(15)

  SELECT @Renglon = 0.0, @RenglonID = 0, @Proveedor = NULL, @TienePaquetes = 0, @Paquete = NULL,
         @AplicaMov = NULLIF(NULLIF(RTRIM(@AplicaMov), ''), '0'),
         @AplicaMovID = NULLIF(NULLIF(RTRIM(@AplicaMovID), ''), '0')

  SELECT @CfgCompraCostoSugerido = CompraCostoSugerido,
         @CfgCBSerieLote = ISNULL(CBSerieLote, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF @Modulo = 'VTAS' SELECT @Estatus = Estatus, @ZonaImpuesto = ZonaImpuesto, @Directo = e.Directo, @Sucursal = e.Sucursal, @Moneda = e.Moneda, @TipoCambio = e.TipoCambio, @Almacen = e.Almacen, @FechaRequerida = e.FechaRequerida, @Cliente = e.Cliente,     @MovTipo = mt.Clave FROM Venta e,  MovTipo mt WHERE e.Mov = mt.Mov AND mt.Modulo = @Modulo AND e.ID = @ID ELSE
  IF @Modulo = 'INV'  SELECT @Estatus = Estatus, @Directo = e.Directo, @Sucursal = e.Sucursal, @Moneda = e.Moneda, @TipoCambio = e.TipoCambio, @Almacen = e.Almacen, @FechaRequerida = e.FechaRequerida, 				 @MovTipo = mt.Clave FROM Inv e,    MovTipo mt WHERE e.Mov = mt.Mov AND mt.Modulo = @Modulo AND e.ID = @ID ELSE
  IF @Modulo = 'COMS' SELECT @Estatus = Estatus, @ZonaImpuesto = ZonaImpuesto, @Directo = e.Directo, @Sucursal = e.Sucursal, @Moneda = e.Moneda, @TipoCambio = e.TipoCambio, @Almacen = e.Almacen, @FechaRequerida = e.FechaRequerida, @Proveedor = e.Proveedor, @MovTipo = mt.Clave FROM Compra e, MovTipo mt WHERE e.Mov = mt.Mov AND mt.Modulo = @Modulo AND e.ID = @ID ELSE
  IF @Modulo = 'PROD' SELECT @Estatus = Estatus, @Directo = e.Directo, @Sucursal = e.Sucursal, @Moneda = e.Moneda, @TipoCambio = e.TipoCambio, @Almacen = e.Almacen, @FechaRequerida = ISNULL(e.FechaEntrega, e.FechaEmision),   	 @MovTipo = mt.Clave FROM Prod e,   MovTipo mt WHERE e.Mov = mt.Mov AND mt.Modulo = @Modulo AND e.ID = @ID 

  SELECT @Idioma = NULL
  IF @Modulo = 'VTAS' SELECT @Idioma = NULLIF(RTRIM(Idioma), '') FROM Cte  WHERE Cliente   = @Cliente ELSE
  IF @Modulo = 'COMS' SELECT @Idioma = NULLIF(RTRIM(Idioma), '') FROM Prov WHERE Proveedor = @Proveedor

  IF @Modulo = 'VTAS' SELECT @Renglon = ISNULL(MAX(Renglon), 0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM VentaD  WHERE ID = @ID ELSE
  IF @Modulo = 'INV'  SELECT @Renglon = ISNULL(MAX(Renglon), 0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM InvD    WHERE ID = @ID ELSE
  IF @Modulo = 'COMS' SELECT @Renglon = ISNULL(MAX(Renglon), 0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM CompraD WHERE ID = @ID ELSE
  IF @Modulo = 'PROD' SELECT @Renglon = ISNULL(MAX(Renglon), 0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM ProdD   WHERE ID = @ID 

  CREATE TABLE #CBLote (
		ID		int		NOT NULL IDENTITY(1,1),

		SerieLote	char(20)	COLLATE Database_Default NULL,
            	Cuenta	 	char(20) 	COLLATE Database_Default NULL, 
		SubCuenta 	varchar(50) 	COLLATE Database_Default NULL,
		Unidad		varchar(50)	COLLATE Database_Default NULL,
		Cantidad	float		NULL,
		Paquete		int		NULL,

   CONSTRAINT priTempCBLote PRIMARY KEY CLUSTERED (ID))

  DECLARE crLista CURSOR 
      FOR SELECT NULLIF(RTRIM(Clave), '') FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID
  OPEN crLista
  FETCH NEXT FROM crLista INTO @Clave
  WHILE @@FETCH_STATUS <> -1 AND @Clave IS NOT NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @TipoCuenta = NULL, @Cuenta = NULL, @SubCuenta = NULL, @Unidad = NULL, @Cantidad = 1.0, @SerieLote = NULL
      IF @Idioma IS NOT NULL
      BEGIN
        SELECT @Cuenta = NULLIF(RTRIM(Articulo), '') FROM ArtIdioma WHERE Codigo = @Clave AND Idioma = @Idioma
        IF @Cuenta IS NOT NULL SELECT @TipoCuenta = 'Articulos'
      END

      IF @TipoCuenta IS NULL 
      BEGIN
        SELECT @TipoCuenta = NULLIF(RTRIM(TipoCuenta), ''), @Cuenta = NULLIF(RTRIM(Cuenta), ''), @SubCuenta = NULLIF(RTRIM(SubCuenta), ''), @Unidad = NULLIF(RTRIM(Unidad), ''), @Cantidad = ISNULL(Cantidad, 1.0), @SerieLote = NULLIF(RTRIM(SerieLote), '')
          FROM CB
         WHERE Codigo = @Clave
        IF @TipoCuenta = 'Articulos' AND @CfgCBSerieLote = 1 AND @Modulo <> 'PROD'
          IF (SELECT Tipo FROM Art WHERE Articulo = @Cuenta) IN ('SERIE','LOTE','VIN','PARTIDA') SELECT @SerieLote = @Clave
      END
      
      IF @TipoCuenta IS NULL 
      BEGIN
        IF EXISTS(SELECT * FROM ProdSerieLotePendiente WHERE Empresa = @Empresa AND ProdSerieLote = @Clave)
           SELECT @TipoCuenta = 'Lotes', @SerieLote = @Clave, @Cuenta = NULL
        ELSE BEGIN          
          IF EXISTS(SELECT Articulo FROM Art WHERE Articulo = @Clave)
            SELECT @Cuenta = @Clave, @TipoCuenta = 'Articulos'             
          ELSE IF @Clave = '+' SELECT @TienePaquetes = 1, @Paquete = ISNULL(@Paquete, 0) + 1
       END
      END ELSE
        IF UPPER(@TipoCuenta) = 'LOTES' SELECT @SerieLote = @Cuenta, @Cuenta = NULL

      IF @CfgCBSerieLote = 0 AND (NOT (@MovTipo IN ('INV.SM', 'INV.CM') OR @Modulo = 'PROD')) SELECT @SerieLote = NULL
      INSERT #CBLote (SerieLote, Cuenta, SubCuenta, Unidad, Cantidad, Paquete) VALUES (@SerieLote, @Cuenta, @SubCuenta, @Unidad, @Cantidad, @Paquete) 
    END
    FETCH NEXT FROM crLista INTO @Clave
  END
  CLOSE crLista
  DEALLOCATE crLista

  IF @CfgCBSerieLote = 0 OR @Modulo = 'PROD'
  BEGIN
    DECLARE crCBLote CURSOR FOR
     SELECT SerieLote, Cuenta, SubCuenta, Unidad, Paquete, SUM(Cantidad)
       FROM #CBLote
      GROUP BY Paquete, SerieLote, Cuenta, SubCuenta, Unidad
      ORDER BY Paquete, SerieLote, Cuenta, SubCuenta, Unidad
    OPEN crCBLote
    FETCH NEXT FROM crCBLote INTO @SerieLote, @Cuenta, @SubCuenta, @Unidad, @Paquete, @Cantidad
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @TienePaquetes = 1 SELECT @Paquete = ISNULL(@Paquete, 0) + 1
        IF @Cuenta IS NULL AND @SerieLote IS NOT NULL AND @Modulo = 'PROD'
          EXEC spCBLoteProdSerieLote @Empresa, @Modulo, @ID, @MovTipo, @Estatus, @Sucursal, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CfgCompraCostoSugerido,
        			     @Moneda, @TipoCambio, @Proveedor, @Almacen, @FechaRequerida,
	  		             @Cuenta, @SubCuenta, @Unidad, @Cantidad, @SerieLote, @Renglon OUTPUT, @RenglonID OUTPUT, @AplicaMov, @AplicaMovID, @Paquete, @ZonaImpuesto
        ELSE
          IF @Cuenta IS NOT NULL
            EXEC spCBLoteRenglon @Empresa, @Modulo, @ID, @MovTipo, @Estatus, @Sucursal, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CfgCompraCostoSugerido,
	  		         @Moneda, @TipoCambio, @Proveedor, @Almacen, @FechaRequerida,
			         @Cuenta, @SubCuenta, @Unidad, @Cantidad, @SerieLote, @Renglon OUTPUT, @RenglonID OUTPUT, @AplicaMov, @AplicaMovID, @Paquete, @ZonaImpuesto
      END
      FETCH NEXT FROM crCBLote INTO @SerieLote, @Cuenta, @SubCuenta, @Unidad, @Paquete, @Cantidad
    END
    CLOSE crCBLote
    DEALLOCATE crCBLote
  END ELSE 
  BEGIN
    DECLARE crCBLote CURSOR FOR
     SELECT Cuenta, SubCuenta, Unidad, Paquete, SUM(Cantidad)
       FROM #CBLote
      GROUP BY Paquete, Cuenta, SubCuenta, Unidad
      ORDER BY Paquete, Cuenta, SubCuenta, Unidad
    OPEN crCBLote
    FETCH NEXT FROM crCBLote INTO @Cuenta, @SubCuenta, @Unidad, @Paquete, @Cantidad
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @TienePaquetes = 1 SELECT @Paquete = ISNULL(@Paquete, 0) + 1
        IF @Cuenta IS NOT NULL
        BEGIN
          EXEC spCBLoteRenglon @Empresa, @Modulo, @ID, @MovTipo, @Estatus, @Sucursal, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CfgCompraCostoSugerido,
       		               @Moneda, @TipoCambio, @Proveedor, @Almacen, @FechaRequerida,
			       @Cuenta, NULL, @Unidad, @Cantidad, @SerieLote, @Renglon OUTPUT, @RenglonID OUTPUT, @AplicaMov, @AplicaMovID, @Paquete, @ZonaImpuesto
          INSERT SerieLoteMov (
                 Empresa,  Modulo,  ID,  RenglonID,  Articulo, SubCuenta,              SerieLote, Cantidad)
          SELECT @Empresa, @Modulo, @ID, @RenglonID, @Cuenta,  ISNULL(@SubCuenta, ''), SerieLote, SUM(Cantidad)
            FROM #CBLote
           WHERE Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(Unidad, '') = ISNULL(@Unidad, '') AND ISNULL(Paquete, 0) = ISNULL(@Paquete, 0)
             AND NULLIF(SerieLote, '') IS NOT NULL
           GROUP BY SerieLote
           ORDER BY SerieLote
        END
      END
      FETCH NEXT FROM crCBLote INTO @SerieLote, @SubCuenta, @Unidad, @Paquete, @Cantidad
    END
    CLOSE crCBLote
    DEALLOCATE crCBLote
  END

  IF @Estatus <> 'PENDIENTE'
  BEGIN
    IF @AplicaMov IS NOT NULL OR @AplicaMovID IS NOT NULL SELECT @Directo = 0
    IF @Modulo = 'VTAS' UPDATE Venta  SET RenglonID = @RenglonID, Directo = @Directo WHERE ID = @ID ELSE
    IF @Modulo = 'INV'  UPDATE Inv    SET RenglonID = @RenglonID, Directo = @Directo WHERE ID = @ID ELSE
    IF @Modulo = 'COMS' UPDATE Compra SET RenglonID = @RenglonID, Directo = @Directo WHERE ID = @ID ELSE
    IF @Modulo = 'PROD' UPDATE Prod   SET RenglonID = @RenglonID, Directo = @Directo WHERE ID = @ID 

    IF @MovTipo IN ('PROD.A', 'PROD.R', 'PROD.E')
      EXEC spProdAvanceTiempoCentro @ID, @MovTipo, @Moneda, @TipoCambio
  END
  RETURN
END
GO

/**************** spCBLoteProdSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCBLoteProdSerieLote') and type = 'P') drop procedure dbo.spCBLoteProdSerieLote
GO             
CREATE PROCEDURE spCBLoteProdSerieLote
		    @Empresa			char(5),
		    @Modulo			char(5),
		    @ID				int,
		    @MovTipo			char(20),
                    @Estatus                    char(15), 
		    @Sucursal			int,
		    @CfgMultiUnidades		bit,
		    @CfgMultiUnidadesNivel	char(20),
		    @CfgCompraCostoSugerido  	char(20),
		    @Moneda			char(10),
		    @TipoCambio			float,
		    @Proveedor			char(10),
		    @Almacen			char(10),
		    @FechaRequerida		datetime,
		    @Cuenta			char(20),
 		    @SubCuenta			varchar(50),
		    @Unidad			varchar(50),
		    @Cantidad			float,
		    @SerieLote			varchar(50),
		    @Renglon			float	OUTPUT,
		    @RenglonID			int	OUTPUT,
		    @AplicaMov			char(20)	= NULL,
		    @AplicaMovID		varchar(20)	= NULL,
		    @Paquete			int		= NULL,
	            @ZonaImpuesto		varchar(50)	= NULL 	

--//WITH ENCRYPTION
AS BEGIN
  DECLARE crProdSerieLote CURSOR FOR
   SELECT Articulo, SubCuenta, Unidad, CantidadPendiente 
     FROM ProdSerieLotePendiente WHERE Empresa = @Empresa AND ProdSerieLote = @SerieLote

  OPEN crProdSerieLote
  FETCH NEXT FROM crProdSerieLote INTO @Cuenta, @SubCuenta, @Unidad, @Cantidad
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spCBLoteRenglon @Empresa, @Modulo, @ID, @MovTipo, @Estatus, @Sucursal, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CfgCompraCostoSugerido,
	   	           @Moneda, @TipoCambio, @Proveedor, @Almacen, @FechaRequerida,
			   @Cuenta, @SubCuenta, @Unidad, @Cantidad, @SerieLote, @Renglon OUTPUT, @RenglonID OUTPUT, @AplicaMov, @AplicaMovID, @Paquete, @ZonaImpuesto
    FETCH NEXT FROM crProdSerieLote INTO @Cuenta, @SubCuenta, @Unidad, @Cantidad
  END
  CLOSE crProdSerieLote
  DEALLOCATE crProdSerieLote
END
GO

/**************** spCBLoteRenglon ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCBLoteRenglon') and type = 'P') drop procedure dbo.spCBLoteRenglon
GO             
CREATE PROCEDURE spCBLoteRenglon
		    @Empresa			char(5),
		    @Modulo			char(5),
		    @ID				int,
		    @MovTipo			char(20),
                    @Estatus                    char(15), 
		    @Sucursal			int,
		    @CfgMultiUnidades		bit,
		    @CfgMultiUnidadesNivel	char(20),
		    @CfgCompraCostoSugerido  	char(20),
		    @Moneda			char(10),
		    @TipoCambio			float,
		    @Proveedor			char(10),
		    @Almacen			char(10),
		    @FechaRequerida		datetime,
		    @Cuenta			char(20),
 		    @SubCuenta			varchar(50),
		    @Unidad			varchar(50),
		    @Cantidad			float,
		    @SerieLote			varchar(50),
		    @Renglon			float	OUTPUT,
		    @RenglonID			int	OUTPUT,
		    @AplicaMov			char(20)	= NULL,
		    @AplicaMovID		varchar(20)	= NULL,
		    @Paquete			int		= NULL,
	            @ZonaImpuesto		varchar(50)	= NULL 	

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo			char(20),
    @ArtTipo			char(20),
    @ArtImpuesto1		float,
    @ArtImpuesto2		float,
    @ArtImpuesto3		money,
    @ArtRuta			char(20),
    @Ruta			char(20),
    @Orden			int,
    @Centro			char(10),
    @Tipo			char(20),
    @RenglonTipo		char(1),
    @RenglonSub                 int,
    @Costo			float,
    @CantidadInventario		float,
    @Precio			float,
    @ListaPrecios		varchar(30),
    @FechaEmision		datetime,
    @Contacto			varchar(10),
    @EnviarA			int,
    @Mov			varchar(20),
    @Factor                     float

  SELECT @Articulo = NULL, @Contacto = NULL, @EnviarA = NULL
  SELECT @Articulo      = Articulo,
         @ArtTipo       = Tipo,
         @ArtImpuesto1  = Impuesto1,
         @ArtImpuesto2  = Impuesto2,
         @ArtImpuesto3  = Impuesto3,
         @ArtRuta	= ProdRuta, 
         @Unidad        = ISNULL(@Unidad, CASE WHEN @Modulo IN ('COMS', 'PROD') THEN UnidadCompra ELSE Unidad END)
    FROM Art 
   WHERE Articulo = @Cuenta AND UPPER(Estatus) = 'ALTA'

  IF @Modulo = 'VTAS' SELECT @Mov = Mov, @FechaEmision = FechaEmision, @Contacto = Cliente, @EnviarA = EnviarA FROM Venta  WHERE ID = @ID ELSE
  IF @Modulo = 'COMS' SELECT @Mov = Mov, @FechaEmision = FechaEmision, @Contacto = Proveedor                   FROM Compra WHERE ID = @ID
  
  EXEC spZonaImp @ZonaImpuesto, @ArtImpuesto1 OUTPUT
  EXEC spZonaImp @ZonaImpuesto, @ArtImpuesto2 OUTPUT
  EXEC spZonaImp @ZonaImpuesto, @ArtImpuesto3 OUTPUT
  EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Contacto = @Contacto, @EnviarA = @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @ArtImpuesto1 OUTPUT, @Impuesto2 = @ArtImpuesto2 OUTPUT, @Impuesto3 = @ArtImpuesto3 OUTPUT
  SELECT @Factor =  dbo.fnArtUnidadFactor(@Empresa, @Articulo,@Unidad)
  IF @CfgMultiUnidades = 0 SELECT @Unidad = NULL
  IF @Articulo IS NOT NULL
  BEGIN
    EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
    EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
    EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT

    SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

    IF @Modulo = 'INV'
    BEGIN
      IF @Estatus = 'PENDIENTE'
      BEGIN
        SELECT @Renglon = Renglon, @RenglonSub = RenglonSub FROM InvD WHERE ID = @ID AND Almacen = @Almacen AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(ProdSerieLote, '') = ISNULL(@SerieLote, '')
        UPDATE InvD SET CantidadA = ISNULL(CantidadA, 0) + ISNULL(@Cantidad, 0) WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END ELSE
        INSERT InvD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  ProdSerieLote, Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Aplica,     AplicaID,     Paquete)
             VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @SerieLote,    @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @FechaRequerida, @AplicaMov, @AplicaMovID, @Paquete)
    END ELSE
    IF @Modulo = 'VTAS'
    BEGIN
      IF @Estatus = 'PENDIENTE'
      BEGIN
        SELECT @Renglon = Renglon, @RenglonSub = RenglonSub FROM VentaD WHERE ID = @ID AND Almacen = @Almacen AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
        UPDATE VentaD SET CantidadA = ISNULL(CantidadA, 0) + ISNULL(@Cantidad, 0) WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END ELSE
      BEGIN
        SELECT @ListaPrecios = ListaPreciosEsp FROM Venta WHERE ID = @ID
        EXEC spPrecioEsp @ListaPrecios, @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT
        INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Impuesto1,     Impuesto2,     Impuesto3,              Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Precio,  Aplica,     AplicaID,     Paquete)
               VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @ArtImpuesto1, @ArtImpuesto2, @ArtImpuesto3*@Factor, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @FechaRequerida, @Precio, @AplicaMov, @AplicaMovID, @Paquete)
      END
    END ELSE
    IF @Modulo = 'COMS'
      IF @Estatus = 'PENDIENTE'
      BEGIN
        SELECT @Renglon = Renglon, @RenglonSub = RenglonSub FROM CompraD WHERE ID = @ID AND Almacen = @Almacen AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
        UPDATE CompraD SET CantidadA = ISNULL(CantidadA, 0) + ISNULL(@Cantidad, 0) WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END ELSE
        INSERT CompraD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Impuesto1,     Impuesto2,     Impuesto3,             Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Aplica,     AplicaID,     Paquete)
                VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @ArtImpuesto1, @ArtImpuesto2, @ArtImpuesto3*@Factor, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @FechaRequerida, @AplicaMov, @AplicaMovID, @Paquete)
    ELSE
    IF @Modulo = 'PROD'
    BEGIN
      IF @Estatus = 'PENDIENTE'
      BEGIN
        SELECT @Renglon = Renglon, @RenglonSub = RenglonSub FROM ProdD WHERE ID = @ID AND Almacen = @Almacen AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(ProdSerieLote, '') = ISNULL(@SerieLote, '')
        UPDATE ProdD SET CantidadA = ISNULL(CantidadA, 0) + ISNULL(@Cantidad, 0) WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END ELSE
      BEGIN
        SELECT @Ruta = NULL, @Centro = NULL, @Tipo = NULL
        IF @MovTipo = 'PROD.E' SELECT @Tipo = 'Entrada'
        IF @SerieLote IS NULL 
          SELECT @Ruta = @ArtRuta 
        ELSE 
          SELECT @Ruta = MIN(Ruta), @Orden = MIN(Orden), @Centro = MIN(Centro)
            FROM ProdSerieLotePendiente 
           WHERE Empresa = @Empresa AND ProdSerieLote = @SerieLote AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')

        INSERT ProdD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  ProdSerieLote, Ruta,  Orden,  Centro,  Tipo,  Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  Costo,  FechaRequerida,  Aplica,     AplicaID,     Paquete)
              VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @SerieLote,    @Ruta, @Orden, @Centro, @Tipo, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @Costo, @FechaRequerida, @AplicaMov, @AplicaMovID, @Paquete)
      END
    END
  END
END
GO

/**************** spCerrarSucursalVentas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCerrarSucursalVentas') and type = 'P') drop procedure dbo.spCerrarSucursalVentas
GO             
CREATE PROCEDURE spCerrarSucursalVentas
			@Estacion	int,
                    	@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@Fecha		datetime,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FacturaMov		varchar(20)

  SELECT @FacturaMov = VentaFacturaNota FROM EmpresaCfgMov WHERE Empresa = @Empresa

  -- Procesar Notas
  DELETE ListaID WHERE Estacion = @Estacion
  INSERT ListaID (Estacion, ID) SELECT @Estacion, v.ID FROM Venta v, MovTipo mt WHERE v.Empresa = @Empresa AND v.Sucursal = @Sucursal AND v.Estatus = 'PROCESAR' AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR')
  IF EXISTS(SELECT * FROM ListaID WHERE Estacion = @Estacion)
    EXEC spProcesarVentaN @Estacion, @Empresa, @FacturaMov, @Fecha, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  -- Procesar Facturas Mostrador
  IF @Ok IS NULL
  BEGIN
    DELETE ListaID WHERE Estacion = @Estacion 
    INSERT ListaID (Estacion, ID) SELECT @Estacion, v.ID FROM Venta v, MovTipo mt WHERE v.Empresa = @Empresa AND v.Sucursal = @Sucursal AND v.Estatus = 'PROCESAR' AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.FM'
    IF EXISTS(SELECT * FROM ListaID WHERE Estacion = @Estacion)
      EXEC spProcesarVentaFM @Estacion, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END
  RETURN
END
GO

/**************** spCompactarOrdenes ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompactarOrdenes') and type = 'P') drop procedure dbo.spCompactarOrdenes
GO             
CREATE PROCEDURE spCompactarOrdenes
			@Empresa	char(5),
			@Usuario	char(10),
			@Modulo		char(5),
			@AlmacenEsp	char(10) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok			int,
    @OkRef		varchar(255),
    @FechaEmision	datetime,
    @FechaRegistro	datetime,
    @Sucursal		int,
    @Mov		char(20),
    @Proyecto		varchar(50),    
    @Almacen		char(10), 
    @AlmacenDestino	char(10), 
    @Moneda		char(10),
    @Paquete		int,
    @Costo		float,
    @Precio		float,
 
    @UltSucursal	int,
    @UltMov		char(20),
    @UltProyecto	varchar(50), 
    @UltAlmacen		char(10), 
    @UltAlmacenDestino	char(10), 
    @UltMoneda		char(10), 
 
    @FechaRequerida	datetime,
    @MovID		varchar(20), 
    @Articulo		char(20), 
    @SubCuenta		varchar(50), 
    @Cantidad		float, 
    @CantidadA		float, 
    @CantidadInventario	float, 
    @Factor		float,
    @Unidad		varchar(50), 
    @Conteo		int,
    @ID			int,
    @Renglon		float,
    @MultiAlmacen	bit,
    @Mensaje		varchar(255),
    @AutoReservar	bit,
    @SinReservar	bit

  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0, @ID = NULL, @Renglon = 0,
         @UltMov = NULL, @UltProyecto= NULL, @UltAlmacen = NULL, @UltAlmacenDestino = NULL, @UltMoneda = NULL,
         @FechaEmision = GETDATE(), @FechaRegistro = GETDATE(), @AlmacenEsp = NULLIF(NULLIF(RTRIM(@AlmacenEsp), ''), '(TODOS)'),
         @SinReservar = 0
  
  EXEC spExtraerFecha @FechaEmision OUTPUT

  SELECT @AutoReservar = PedidosReservar
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @MultiAlmacen = InvMultiAlmacen
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  EXEC xpCompactarOrdenes @Empresa, @Usuario, @Modulo, @AlmacenEsp, @SinReservar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    CREATE TABLE #Reservar (
	  Renglon	float	NOT NULL PRIMARY KEY,
  	  Cantidad	float	NULL)

    DECLARE crOrdenes CURSOR FOR
     SELECT i.Mov, i.MovID, i.Sucursal, i.Proyecto, i.Moneda, d.Almacen, i.AlmacenDestino, d.FechaRequerida, d.Articulo, d.SubCuenta, "Cantidad" = ISNULL(CantidadPendiente, 0)+ISNULL(CantidadReservada, 0), NULLIF(CantidadReservada, 0), d.Unidad, ISNULL(d.Factor, 1.0), "Paquete" = CONVERT(int, (ISNULL(CantidadPendiente, 0)+ISNULL(CantidadReservada, 0))) / (Cantidad/NULLIF(Paquete, 0)), Costo, Precio
       FROM Inv i, InvD d, MovTipo mt
      WHERE i.ID = d.ID AND i.Empresa = @Empresa AND i.Estatus = 'PENDIENTE'
        AND mt.Modulo = @Modulo AND mt.Mov = i.Mov AND mt.Clave IN (/*'INV.SOL', */'INV.OT', 'INV.OI')
        AND ISNULL(CantidadPendiente, 0)+ISNULL(CantidadReservada, 0) > 0
        AND ((mt.Clave IN ('INV.OT', 'INV.OI') AND i.AlmacenDestino = ISNULL(@AlmacenEsp, i.AlmacenDestino))
         /*OR  (mt.Clave IN ('INV.SOL')          AND d.Almacen        = ISNULL(@AlmacenEsp, d.Almacen))*/)
      ORDER BY i.Mov, i.Sucursal, i.Proyecto, i.Moneda, i.AlmacenDestino, i.Almacen, d.FechaRequerida, d.Articulo, d.SubCuenta

    OPEN crOrdenes
    FETCH NEXT FROM crOrdenes INTO @Mov, @MovID, @Sucursal, @Proyecto, @Moneda, @Almacen, @AlmacenDestino, @FechaRequerida, @Articulo, @SubCuenta, @Cantidad, @CantidadA, @Unidad, @Factor, @Paquete, @Costo, @Precio
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @Mov <> @UltMov OR @Proyecto <> @UltProyecto OR @Moneda <> @UltMoneda OR @AlmacenDestino <> @UltAlmacenDestino OR (@Almacen <> @UltAlmacen AND @MultiAlmacen = 0) 
        BEGIN
          IF @ID IS NOT NULL AND @Ok IS NULL
          BEGIN
            EXEC spInv @ID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, NULL,
                       NULL, NULL, NULL, NULL,
                       @Ok OUTPUT, @OkRef OUTPUT, NULL
            IF @SinReservar = 0 AND @AutoReservar = 0 AND EXISTS(SELECT * FROM #Reservar) AND @Ok IS NULL 
            BEGIN
              UPDATE InvD
                 SET CantidadA = r.Cantidad
                FROM InvD d, #Reservar r
               WHERE d.ID = @ID AND d.Renglon = r.Renglon

              EXEC spInv @ID, @Modulo, 'RESERVAR', 'SELECCION', @FechaRegistro, NULL, @Usuario, 0, 0, NULL,
                         NULL, NULL, NULL, NULL,
                         @Ok OUTPUT, @OkRef OUTPUT, NULL
            END
            TRUNCATE TABLE #Reservar 
          END
          IF @Ok IS NULL
          BEGIN
            INSERT Inv (Sucursal,  Empresa,  Mov,  Proyecto,  FechaEmision,  Moneda, TipoCambio,    Almacen,  AlmacenDestino,  Usuario,  Estatus,      Directo, OrigenTipo)
                 SELECT @Sucursal, @Empresa, @Mov, @Proyecto, @FechaEmision, @Moneda, m.TipoCambio, @Almacen, @AlmacenDestino, @Usuario, 'SINAFECTAR', 0,       'COMPACTADA'
                   FROM Mon m 
                  WHERE m.Moneda = @Moneda
            SELECT @ID = SCOPE_IDENTITY()
            SELECT @Renglon = 0.0, @Conteo = @Conteo + 1
          END
          SELECT @UltMov = @Mov, @UltProyecto = @Proyecto, @UltMoneda = @Moneda, @UltAlmacen = @Almacen, @UltAlmacenDestino = @AlmacenDestino
        END
        IF @ID IS NOT NULL AND @Ok IS NULL
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0, @CantidadInventario = @Cantidad * @Factor
          IF @SinReservar = 0 AND @AutoReservar = 0 AND @CantidadA IS NOT NULL
            INSERT #Reservar (Renglon, Cantidad) VALUES (@Renglon, @CantidadA)
  
          INSERT InvD (Sucursal,  ID,  Renglon,  RenglonSub, RenglonID, Aplica, AplicaID, Almacen,  Articulo,  SubCuenta,  Unidad,  Cantidad,  Factor,  CantidadInventario,  Paquete,  FechaRequerida,  Costo,  Precio)
               VALUES (@Sucursal, @ID, @Renglon, 0,          0,         @Mov,   @MovID,   @Almacen, @Articulo, @SubCuenta, @Unidad, @Cantidad, @Factor, @CantidadInventario, @Paquete, @FechaRequerida, @Costo, @Precio)
        END
      END
      FETCH NEXT FROM crOrdenes INTO @Mov, @MovID, @Sucursal, @Proyecto, @Moneda, @Almacen, @AlmacenDestino, @FechaRequerida, @Articulo, @SubCuenta, @Cantidad, @CantidadA, @Unidad, @Factor, @Paquete, @Costo, @Precio
    END  -- While	
    CLOSE crOrdenes
    DEALLOCATE crOrdenes
  END

  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    EXEC spInv @ID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, NULL,
               NULL, NULL, NULL, NULL,
               @Ok OUTPUT, @OkRef OUTPUT, NULL
    IF @SinReservar = 0 AND @AutoReservar = 0 AND EXISTS(SELECT * FROM #Reservar) AND @Ok IS NULL 
    BEGIN
      UPDATE InvD
         SET CantidadA = r.Cantidad
        FROM InvD d, #Reservar r
       WHERE d.ID = @ID AND d.Renglon = r.Renglon

      EXEC spInv @ID, @Modulo, 'RESERVAR', 'SELECCION', @FechaRegistro, NULL, @Usuario, 0, 0, NULL,
                 NULL, NULL, NULL, NULL,
                 @Ok OUTPUT, @OkRef OUTPUT, NULL
    END
    TRUNCATE TABLE #Reservar 
  END

  IF @Ok IS NULL 
    SELECT @Mensaje = LTRIM(CONVERT(char, @Conteo))+' Ordenes Realizadas.'
  ELSE
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN 
END
GO
/* 
set nocount on
exec spCompactarOrdenes 'DEMO', 'DEMO', 'INV'
*/

-- spCompraAsignarPedimento 101, 'DEMO', 589, 0, '26'
/**************** spCompraAsignarPedimento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraAsignarPedimento') and type = 'P') drop procedure dbo.spCompraAsignarPedimento
GO             
CREATE PROCEDURE spCompraAsignarPedimento
		   @Estacion	int,
                   @Empresa	char(5),
                   @ID		int,
                   @Sucursal	int,
		   @Pedimento	char(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo		char(20),
    @ArtTipo		varchar(20),
    @SubCuenta		varchar(20),
    @Cantidad		float,
    @RenglonID		int

  SELECT @Pedimento = NULLIF(NULLIF(RTRIM(@Pedimento), ''), '0')

  IF @Pedimento IS NOT NULL AND NOT EXISTS(SELECT * FROM SerieLoteProp WHERE Propiedades = @Pedimento)
  BEGIN
    RAISERROR('El Pedimento Indicado No Existe',16,-1)               
    RETURN
  END

  BEGIN TRANSACTION
    DECLARE crCompra CURSOR FOR
     SELECT d.Articulo, ISNULL(RTRIM(d.SubCuenta), ''), ISNULL(d.Cantidad, 0.0), d.RenglonID, a.Tipo
       FROM ListaIDRenglon l, CompraD d, Art a 
      WHERE d.ID = @ID AND d.Articulo = a.Articulo AND UPPER(a.Tipo) IN ('LOTE', 'PARTIDA')
        AND l.Estacion = @Estacion AND l.Modulo = 'COMS' AND l.ID = d.ID AND l.Renglon = d.Renglon AND l.RenglonSub = d.RenglonSub
    OPEN crCompra
    FETCH NEXT FROM crCompra INTO @Articulo, @SubCuenta, @Cantidad, @RenglonID, @ArtTipo
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Cantidad <> 0.0
      BEGIN
        IF @Pedimento IS NULL
          DELETE SerieLoteMov 
           WHERE Empresa = @Empresa AND Modulo = 'COMS' AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo 
        ELSE BEGIN
          UPDATE SerieLoteMov 
             SET SerieLote = CASE WHEN @ArtTipo = 'VIN' THEN SerieLote ELSE @Pedimento END, Cantidad = @Cantidad, Propiedades = @Pedimento
           WHERE Empresa = @Empresa AND Modulo = 'COMS' AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
          IF @@ROWCOUNT = 0
  	    INSERT SerieLoteMov (Sucursal, Empresa, Modulo,  ID,  RenglonID,  Articulo, SubCuenta,   SerieLote,  Cantidad,  Propiedades)
                         VALUES (@Sucursal, @Empresa, 'COMS', @ID, @RenglonID, @Articulo, @SubCuenta, @Pedimento, @Cantidad, @Pedimento)
        END
      END
      FETCH NEXT FROM crCompra INTO @Articulo, @SubCuenta, @Cantidad, @RenglonID, @ArtTipo
    END
    CLOSE crCompra
    DEALLOCATE crCompra
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spCompraCalcPesoVolumen ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraCalcPesoVolumen') and type = 'P') drop procedure dbo.spCompraCalcPesoVolumen
GO             
CREATE PROCEDURE spCompraCalcPesoVolumen
		   @Empresa		char(5),
                   @ID			int,
		   @CfgMultiUnidades	bit,
		   @PesoTotal		float	OUTPUT,
    		   @VolumenTotal	float	OUTPUT,
		   @PesoVolumenTotal	float	OUTPUT,
		   @PedimentoEspecifico	char(20) = NULL,
           @ProrrateoNivel      varchar(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
DECLARE
    @Articulo	char(20),
    @CantidadF	float,
    @Peso	float,
    @Volumen	float

  SELECT @PesoTotal = 0.0, @VolumenTotal = 0.0, @PesoVolumenTotal = 0.0
  IF @PedimentoEspecifico IS NULL
    DECLARE crCompraD CURSOR FOR
     SELECT d.Articulo, (d.Cantidad*d.Factor), ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0)
       FROM CompraD d, Art a
      WHERE d.ID = @ID AND d.Articulo = a.Articulo 
  ELSE
    DECLARE crCompraD CURSOR FOR
     SELECT d.Articulo, (d.Cantidad*d.Factor), ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0)
       FROM CompraD d, Art a, SerieLoteMov s
      WHERE d.ID = @ID AND d.Articulo = a.Articulo 
        AND s.Empresa = @Empresa AND s.Modulo = 'COMS' AND s.ID = d.ID AND s.RenglonID = d.RenglonID AND s.Articulo = d.Articulo AND s.SerieLote = @PedimentoEspecifico

  OPEN crCompraD
  FETCH NEXT FROM crCompraD INTO @Articulo, @CantidadF, @Peso, @Volumen
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @CantidadF > 0.0 
      SELECT @PesoTotal = @PesoTotal + (@Peso * @CantidadF),
             @VolumenTotal = @VolumenTotal + (@Volumen * @CantidadF),
             @PesoVolumenTotal = @PesoVolumenTotal + (@Peso * @Volumen * @CantidadF)             
    FETCH NEXT FROM crCompraD INTO @Articulo, @CantidadF, @Peso, @Volumen
  END 
  CLOSE crCompraD
  DEALLOCATE crCompraD

  RETURN
END
GO
-- select * from compra

/**************** spCompraCostoInv ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraCostoInv') and type = 'P') drop procedure dbo.spCompraCostoInv
GO             
CREATE PROCEDURE spCompraCostoInv
	@ID	 int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@MovTipo		 				VARCHAR(20),
	@SubMovTipo         			VARCHAR(20),
	@Concepto		 				VARCHAR(50),
	@Acreedor		 				CHAR(10),
	@RenglonID		 				INT,
	@DescuentoGlobal				FLOAT,
	@Importe		 				MONEY,
	@Retencion		 				FLOAT,
	@Retencion2		 				FLOAT,
	@Retencion3		 				FLOAT,
	@Impuestos		 				FLOAT,
	@Moneda		 					CHAR(10),
	@TipoCambio		 				FLOAT,
	@Prorrateo		 				CHAR(20),
	@PedimentoEspecifico			CHAR(20),
	@Multiple		 				BIT,
	@CompraCostosImpuestoIncluido 	BIT,
	@ImporteProrratear	 			FLOAT,
	@Mensaje		 				VARCHAR(255),
	@ProrrateoNivel     			VARCHAR(20),
	@Empresa      					VARCHAR(5),
	@Mov          					VARCHAR(20),
	@Proveedor    					VARCHAR(10),
	@Articulo     					VARCHAR(20),
	@Material						VARCHAR(20),
	@Lanzamiento  					VARCHAR(100),
	@Costo        					FLOAT

	IF (SELECT Estatus FROM Compra WHERE ID = @ID) NOT IN ('SINAFECTAR', 'CONFIRMAR')
	BEGIN
		SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
		RAISERROR (@Mensaje,16,-1) 
		RETURN
	END
  
	SELECT @CompraCostosImpuestoIncluido = ISNULL(cfg.CompraCostosImpuestoIncluido, 0) 
	FROM EmpresaCfg2 cfg 
	JOIN Compra c ON cfg.Empresa = c.Empresa
	WHERE c.ID = @ID
	
	SELECT @Empresa = c.Empresa, @Mov = c.Mov, @Proveedor = c.Proveedor, @DescuentoGlobal = ISNULL(c.DescuentoGlobal, 0.0), @MovTipo = mt.Clave, @SubMovTipo = mt.SubClave 
	FROM Compra c 
    JOIN MovTipo mt ON mt.Modulo = 'COMS' AND mt.Mov = c.Mov 
	WHERE c.ID = @ID

	IF @Mov = 'EntradaCompraMaquila'
	BEGIN
		UPDATE CompraD SET CostoInv = 0 WHERE ID = @ID

		DECLARE crMESCosto CURSOR FOR
		SELECT d.Articulo, d.MesLanzamiento
		FROM CompraD d
		WHERE d.ID = @ID
		GROUP BY d.Articulo, d.MesLanzamiento
     
		OPEN crMESCosto
		FETCH NEXT FROM crMESCosto INTO @Articulo, @Lanzamiento
		WHILE @@FETCH_STATUS = 0
		BEGIN
		
		SELECT @Costo = NULL
      
/*      SELECT @Costo = SUM(d.Costo)
        FROM Inv e
        JOIN InvD d ON e.ID = d.ID
        JOIN ArtMaterial am ON d.Articulo = am.Material
       WHERE e.Empresa = @Empresa
         AND e.Estatus = 'CONCLUIDO'
         AND e.Mov = 'Entrada Produccion'
         AND am.Articulo = @Articulo AND d.MesLanzamiento = @Lanzamiento
  */
      SELECT @Costo = SUM(d.Costo)
        FROM Inv e
        JOIN InvD d ON e.ID = d.ID
        JOIN PrevisionesConsumoMes p ON d.MesLanzamiento = p.Lanzamiento AND d.Articulo = p.Hijo  AND p.FaseConsumo = 'Ext'
       WHERE e.Empresa = @Empresa
         AND e.Estatus = 'CONCLUIDO'
         AND e.Mov = 'Entrada Produccion'
         AND p.Padre = @Articulo
         AND d.MesLanzamiento = @Lanzamiento
    
     	UPDATE CompraD SET CostoInv = ISNULL(Costo, 0) +  ISNULL(@Costo, 0)
    	 WHERE ID = @ID
    	   AND Articulo = @Articulo

/*
     	UPDATE CompraD SET CostoInv = ISNULL(a.CostoEstandar, 0) + ISNULL(ap.CostoAutorizado, 0)
  	    FROM Art a, ArtProv ap
  	   WHERE CompraD.Articulo = a.Articulo 
  	     AND ap.Articulo = a.Articulo AND ap.Proveedor = @Proveedor
  	     AND CompraD.ID = @ID
*/
      FETCH NEXT FROM crMESCosto INTO @Articulo, @Lanzamiento
    END
    
    CLOSE crMESCosto
    DEALLOCATE crMESCosto

  END
  ELSE
  BEGIN
    UPDATE CompraD SET CostoInv = Costo * ((100.0-@DescuentoGlobal)/100.0) WHERE ID = @ID
    UPDATE CompraD SET CostoInv = CASE WHEN DescuentoTipo = '$' THEN CostoInv - DescuentoLinea ELSE CostoInv * ((100.0-ISNULL(DescuentoLinea, 0.0))/100.0) END WHERE ID = @ID
	DELETE FROM CompraGastoProrrateo WHERE ID = @ID

    IF @MovTipo = 'COMS.EI' OR @SubMovTipo = 'COMS.EIMPO' UPDATE CompraD SET ValorAduana = Costo WHERE ID = @ID

    DECLARE crGastoDiverso CURSOR FOR
     SELECT Concepto, Acreedor, RenglonID, ISNULL(Importe, 0), ISNULL(Impuestos, 0), Moneda, TipoCambio, NULLIF(RTRIM(UPPER(Prorrateo)), ''), NULLIF(RTRIM(PedimentoEspecifico), ''), ISNULL(Multiple, 0), NULLIF(ProrrateoNivel, '')
       FROM CompraGastoDiverso
      WHERE ID = @ID 
    OPEN crGastoDiverso
    FETCH NEXT FROM crGastoDiverso INTO @Concepto, @Acreedor, @RenglonID, @Importe, @Impuestos, @Moneda, @TipoCambio, @Prorrateo, @PedimentoEspecifico, @Multiple, @ProrrateoNivel
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Multiple = 1
        BEGIN
          SELECT @Importe = ISNULL(SUM(Importe), 0),
	         @Retencion = ISNULL(SUM(Retencion), 0),
	         @Retencion2 = ISNULL(SUM(Retencion2), 0),
	         @Retencion3 = ISNULL(SUM(Retencion3), 0),
                 @Impuestos = ISNULL(SUM(Impuestos), 0)
            FROM CompraGastoDiversoD 
           WHERE ID = @ID AND Concepto = @Concepto AND Acreedor = @Acreedor AND RenglonID = @RenglonID

          UPDATE CompraGastoDiverso 
             SET Importe    = @Importe,
	         Retencion  = @Retencion,
	         Retencion2 = @Retencion2,
	         Retencion3 = @Retencion3,
                 Impuestos  = @Impuestos
           WHERE CURRENT OF crGastoDiverso
        END

        IF @CompraCostosImpuestoIncluido = 0
          SELECT @ImporteProrratear = @Importe 
        ELSE SELECT @ImporteProrratear = @Importe + @Impuestos

        IF @Prorrateo NOT IN (NULL, 'NO')
          EXEC spCompraProratear @ID, @Prorrateo, @ImporteProrratear, @Moneda, @TipoCambio, @PedimentoEspecifico, @MovTipo, @Concepto, @RenglonID, @ProrrateoNivel 
      END
      FETCH NEXT FROM crGastoDiverso INTO @Concepto, @Acreedor, @RenglonID, @Importe, @Impuestos, @Moneda, @TipoCambio, @Prorrateo, @PedimentoEspecifico, @Multiple, @ProrrateoNivel
    END
    CLOSE crGastoDiverso
    DEALLOCATE crGastoDiverso

    IF @MovTipo = 'COMS.EI' 
      UPDATE CompraD 
         SET CostoInv = CostoInv + ISNULL(ValorAduana*(ImportacionImpuesto1/100.0), 0.0) + ISNULL(ValorAduana*(ImportacionImpuesto2/100.0), 0.0)
       WHERE ID = @ID
  END
  
END
GO
/**************** spCompraDevTodo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraDevTodo') and type = 'P') drop procedure dbo.spCompraDevTodo
GO             
CREATE PROCEDURE spCompraDevTodo
			@ID		int,
			@Empresa	char(5),
			@Sucursal	int,
			@Almacen	char(10),
			@Proveedor	char(10)
--//WITH ENCRYPTION
AS BEGIN
  DELETE CompraD WHERE ID = @ID
  DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'COMS' AND ID = @ID
  EXEC spInvInventarioFisico @Sucursal, NULL, @Empresa, NULL, @ID, 'DISPONIBLE', 1, 'SINAFECTAR', NULL, NULL, @Modulo = 'COMS', @Proveedor = @Proveedor
  RETURN
END
GO

-- spCompraGarantiaCostos 8
/**************** spCompraGarantiaCostos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraGarantiaCostos') and type = 'P') drop procedure dbo.spCompraGarantiaCostos
GO             
CREATE PROCEDURE spCompraGarantiaCostos
		    	@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa			char(5),
    @Proveedor			char(10),
    @FechaRegistro		datetime,
    @FechaEmision		datetime,
    @Directo			bit,
    @Usuario			char(10),
    @GarantiaCostos		bit,
    @GarantiaCostosPlazo	float,
    @CompraPerdidaID		int,		
    @CompraPerdidaMov		char(20),
    @CompraPerdidaMovID		varchar(20),
    @AplicaID			int, 
    @AplicaMov			varchar(20),
    @AplicaMovID		varchar(20), 
    @AplicaRenglon		float, 
    @AplicaRenglonSub		int,
    @AplicaCantidad		float,
    @AplicaCantidadInventario	float,
    @AplicaCosto		float,
    @Renglon			float,
    @RenglonSub			int,
    @RenglonID			int,
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @Cantidad			float,
    @CantidadInventario		float,
    @Costo			float,
    @Ok				int,
    @OkRef			varchar(255),
    @Mensaje			varchar(255)

  SELECT @Mensaje = NULL, @Ok = NULL, @OkRef = NULL, @CompraPerdidaID = NULL, @FechaRegistro = GETDATE()
  SELECT @Directo = Directo, @Empresa = Empresa, @Proveedor = Proveedor, @FechaEmision = FechaEmision, @Usuario = Usuario
    FROM Compra
   WHERE ID = @ID
  SELECT @GarantiaCostos      = ISNULL(GarantiaCostos, 0),
         @GarantiaCostosPlazo = ISNULL(GarantiaCostosPlazo, 0)
    FROM Prov
   WHERE Proveedor = @Proveedor

  IF @GarantiaCostos = 1
  BEGIN
    BEGIN TRANSACTION

    SELECT @Renglon = 0.0, @RenglonID = 0
    SELECT @CompraPerdidaMov = CompraPerdida
      FROM EmpresaCfgMov 
     WHERE Empresa = @Empresa

    DECLARE crCompraPendiente CURSOR FOR
     SELECT e.ID, e.Mov, e.MovID, d.Renglon, d.RenglonSub
       FROM CompraD d
       JOIN Compra e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' AND DATEADD(day, @GarantiaCostosPlazo, e.FechaEmision) < @FechaEmision
       JOIN MovTipo mt ON mt.Modulo = 'COMS' AND mt.Mov = e.Mov AND mt.Clave = 'COMS.O'
      WHERE ISNULL(d.CantidadPendiente, 0) > 0 
    OPEN crCompraPendiente
    FETCH NEXT FROM crCompraPendiente INTO @AplicaID, @AplicaMov, @AplicaMovID, @AplicaRenglon, @AplicaRenglonSub
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @CompraPerdidaID IS NULL
        BEGIN
          INSERT Compra (
                 Sucursal, Empresa, Mov,               Estatus,      FechaEmision, Moneda, TipoCambio, Usuario, Almacen, Proveedor) 
          SELECT Sucursal, Empresa, @CompraPerdidaMov, 'SINAFECTAR', FechaEmision, Moneda, TipoCambio, Usuario, Almacen, Proveedor
            FROM Compra
           WHERE ID = @ID
          SELECT @CompraPerdidaID = SCOPE_IDENTITY()
        END
        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
        INSERT CompraD (
               ID,               Renglon,  RenglonID,  RenglonTipo, Impuesto1, Impuesto2, Impuesto3, Almacen, Articulo, SubCuenta, Cantidad,          Unidad, CantidadInventario,                                         Costo, FechaRequerida, Aplica,     AplicaID,     Paquete)
        SELECT @CompraPerdidaID, @Renglon, @RenglonID, RenglonTipo, Impuesto1, Impuesto2, Impuesto3, Almacen, Articulo, SubCuenta, CantidadPendiente, Unidad, CantidadPendiente*CantidadInventario/NULLIF(Cantidad, 0.0), Costo, FechaRequerida, @AplicaMov, @AplicaMovID, Paquete
          FROM CompraD
         WHERE ID = @AplicaID AND Renglon = @AplicaRenglon AND RenglonSub = @AplicaRenglonSub
      END
      FETCH NEXT FROM crCompraPendiente INTO @AplicaID, @AplicaMov, @AplicaMovID, @AplicaRenglon, @AplicaRenglonSub
    END  -- While	
    CLOSE crCompraPendiente
    DEALLOCATE crCompraPendiente

    IF @CompraPerdidaID IS NOT NULL
      EXEC spInv @CompraPerdidaID, 'COMS', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                 @CompraPerdidaMov, @CompraPerdidaMovID OUTPUT, NULL, NULL,
                 @Ok OUTPUT, @OkRef OUTPUT, 0

    DECLARE crComprasD CURSOR FOR
     SELECT d.Renglon, d.RenglonSub, d.Articulo, d.SubCuenta, ISNULL(d.Cantidad, 0.0), ISNULL(d.CantidadInventario, 0.0), d.Costo
       FROM CompraD d
      WHERE d.ID = @ID AND d.Aplica IS NULL
    OPEN crComprasD
    FETCH NEXT FROM crComprasD INTO @Renglon, @RenglonSub, @Articulo, @SubCuenta, @Cantidad, @CantidadInventario, @Costo
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        DECLARE crCompraPendiente CURSOR LOCAL FOR
         SELECT e.ID, e.Mov, e.MovID, d.Renglon, d.RenglonSub, ISNULL(d.CantidadPendiente, 0.0), d.Costo
           FROM CompraD d
           JOIN Compra e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' AND DATEADD(day, @GarantiaCostosPlazo, e.FechaEmision) >= @FechaEmision
           JOIN MovTipo mt ON mt.Modulo = 'COMS' AND mt.Mov = e.Mov AND mt.Clave = 'COMS.O'
          WHERE d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Costo < @Costo AND ISNULL(d.CantidadPendiente, 0) > 0  
        OPEN crCompraPendiente
        FETCH NEXT FROM crCompraPendiente INTO @AplicaID, @AplicaMov, @AplicaMovID, @AplicaRenglon, @AplicaRenglonSub, @AplicaCantidad, @AplicaCosto
        WHILE @@FETCH_STATUS <> -1 AND @Cantidad > 0.0 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 AND @Cantidad > 0.0
          BEGIN
            IF @AplicaCantidad > @Cantidad SELECT @AplicaCantidad = @Cantidad
            SELECT @AplicaCantidadInventario = @AplicaCantidad*@CantidadInventario/NULLIF(@Cantidad, 0.0)
            SELECT @AplicaRenglonSub = MAX(RenglonSub) + 1 FROM CompraD WHERE ID = @ID AND Renglon = @Renglon

            INSERT CompraD (
                   ID,  RenglonSub,        Renglon, RenglonID, RenglonTipo, Impuesto1, Impuesto2, Impuesto3, Almacen, Articulo, SubCuenta, Cantidad,        Unidad, CantidadInventario,        Costo,        FechaRequerida, FechaEntrega, Aplica,     AplicaID,     Paquete, Cliente, Retencion1, Retencion2, Retencion3, Descuento, DescuentoTipo, DescuentoLinea, DescuentoImporte, DescripcionExtra, ReferenciaExtra, DestinoTipo, Destino, DestinoID, ContUso)
            SELECT @ID, @AplicaRenglonSub, Renglon, RenglonID, RenglonTipo, Impuesto1, Impuesto2, Impuesto3, Almacen, Articulo, SubCuenta, @AplicaCantidad, Unidad, @AplicaCantidadInventario, @AplicaCosto, FechaRequerida, FechaEntrega, @AplicaMov, @AplicaMovID, Paquete, Cliente, Retencion1, Retencion2, Retencion3, Descuento, DescuentoTipo, DescuentoLinea, DescuentoImporte, DescripcionExtra, ReferenciaExtra, DestinoTipo, Destino, DestinoID, ContUso
              FROM CompraD
             WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

            SELECT @Cantidad = @Cantidad - @AplicaCantidad, @CantidadInventario = @CantidadInventario - @AplicaCantidadInventario,
                   @Directo = 0  
            IF @Cantidad > 0.0
              UPDATE CompraD
                 SET Cantidad = Cantidad - @AplicaCantidad,
                     CantidadInventario = CantidadInventario - @AplicaCantidadInventario
               WHERE CURRENT OF crComprasD
            ELSE
              DELETE CompraD
               WHERE CURRENT OF crComprasD
          END
          FETCH NEXT FROM crCompraPendiente INTO @AplicaID, @AplicaMov, @AplicaMovID, @AplicaRenglon, @AplicaRenglonSub, @AplicaCantidad, @AplicaCosto
        END  -- While	
        CLOSE crCompraPendiente
        DEALLOCATE crCompraPendiente
      END
      FETCH NEXT FROM crComprasD INTO @Renglon, @RenglonSub, @Articulo, @SubCuenta, @Cantidad, @CantidadInventario, @Costo
    END  -- While	
    CLOSE crComprasD
    DEALLOCATE crComprasD

    UPDATE Compra SET Directo = @Directo WHERE ID = @ID AND Directo <> @Directo

    IF @Ok IS NULL
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
  END

  IF @Ok IS NULL 
    SELECT @Mensaje = 'Proceso Concluido con Exito.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
END
GO

/**************** spCompraProratear ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraProratear') and type = 'P') drop procedure dbo.spCompraProratear
GO             
CREATE PROCEDURE spCompraProratear
                   @ID				int,
		   @BaseProrrateo		char(20),
		   @BaseImporte		        float,
	   	   @GastoMoneda			char(10),
		   @GastoTipoCambio		float,
		   @PedimentoEspecifico 	char(20) = NULL,
		   @MovTipo			varchar(20) = NULL,
           @Concepto        varchar(50) = NULL, -- Valor Aduana
           @RenglonID       float = NULL,
           @ProrrateoNivel  varchar(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa			char(5),
    @CfgMultiUnidades		bit,
    @Ok				int,
    @OkRef			varchar(255),
    @Renglon			float,
    @RenglonSub			int,
    @Articulo			char(20),
    @Cantidad			float,
    @CantidadF			float,
    @CostoLinea			float,   
    @Peso			float,
    @PesoLinea			float,
    @Volumen			float,
    @VolumenLinea		float,
    @PesoVolumenLinea		float,
    @FactorCosto		float,
    @Arancel			varchar(50),
    @ArancelPorcentaje		float,
    @MovMoneda			char(10),
    @MovTipoCambio		float,
    @ImporteTotal		money,
    @CantidadTotal 		float,
    @PesoTotal			float,
    @VolumenTotal		float,
    @PesoVolumenTotal		float,
    @CostoArancel		float,
    @ArancelTotal		money,
    @NuevoCosto			float,
    @IncCosto			float,
    @MovUnidad			varchar(50),
    @ValorAduana        bit,
    @SubTotalSD         money,
    @NuevoCostoSD       float,
    @IncCostoSD         float,
    @ImporteTotalSD     money,
    @MovMonedaD         char(10),
    @MovTipoCambioD     float

  SELECT @Ok = NULL, @BaseProrrateo = UPPER(@BaseProrrateo), @ProrrateoNivel = UPPER(NULLIF(@ProrrateoNivel, ''))
  EXEC spInvCalcFactor 'COMS', @ID
  SELECT @Empresa = Empresa FROM Compra WHERE ID = @ID 
  SELECT @CfgMultiUnidades = MultiUnidades FROM EmpresaCfg2 WHERE Empresa = @Empresa
  SELECT @ValorAduana = ValorAduana FROM Concepto WHERE Modulo = 'COMSG' AND Concepto = @Concepto

  IF @PedimentoEspecifico IS NULL
  BEGIN
    IF @ProrrateoNivel IS NULL
      SELECT @ImporteTotal = SUM(SubTotal) 
        FROM CompraTCalc 
       WHERE ID = @ID 
    ELSE IF @ProrrateoNivel = 'PROVEEDOR'
      SELECT @ImporteTotal = SUM(SubTotal) 
        FROM CompraTCalc 
       WHERE ID = @ID 
         AND ImportacionProveedor IN (SELECT Proveedor FROM CompraGastoDiversoProv WHERE ID = @ID AND Concepto = @Concepto)
    ELSE IF @ProrrateoNivel = 'REFERENCIA'
      SELECT @ImporteTotal = SUM(SubTotal) 
        FROM CompraTCalc 
       WHERE ID = @ID 
         AND ImportacionReferencia IN (SELECT Referencia FROM CompraGastoDiversoRef WHERE ID = @ID AND Concepto = @Concepto)
    ELSE IF @ProrrateoNivel = 'ARTICULO'
      SELECT @ImporteTotal = SUM(SubTotal) 
        FROM CompraTCalc 
       WHERE ID = @ID 
         AND Articulo IN (SELECT Articulo FROM CompraGastoDiversoArt WHERE ID = @ID AND Concepto = @Concepto)
  END ELSE 
    SELECT @ImporteTotal = SUM(d.SubTotal) 
      FROM CompraTCalc d, SerieLoteMov s 
     WHERE d.ID = @ID 
       AND s.Empresa = @Empresa AND s.Modulo = 'COMS' AND s.ID = d.ID AND s.RenglonID = d.RenglonID AND s.Articulo = d.Articulo AND s.SerieLote = @PedimentoEspecifico


  IF @PedimentoEspecifico IS NULL
  BEGIN
    IF @ProrrateoNivel IS NULL
      SELECT @ImporteTotalSD = SUM(CantidadNeta * Costo) 
        FROM CompraTCalc 
       WHERE ID = @ID 
    ELSE IF @ProrrateoNivel = 'PROVEEDOR'
      SELECT @ImporteTotalSD = SUM(CantidadNeta * Costo) 
        FROM CompraTCalc 
       WHERE ID = @ID 
         AND ImportacionProveedor IN (SELECT Proveedor FROM CompraGastoDiversoProv WHERE ID = @ID AND Concepto = @Concepto)
    ELSE IF @ProrrateoNivel = 'REFERENCIA'
      SELECT @ImporteTotalSD = SUM(CantidadNeta * Costo) 
        FROM CompraTCalc 
       WHERE ID = @ID 
         AND ImportacionReferencia IN (SELECT Referencia FROM CompraGastoDiversoRef WHERE ID = @ID AND Concepto = @Concepto)
    ELSE IF @ProrrateoNivel = 'ARTICULO'
      SELECT @ImporteTotalSD = SUM(CantidadNeta * Costo) 
        FROM CompraTCalc 
       WHERE ID = @ID 
         AND Articulo IN (SELECT Articulo FROM CompraGastoDiversoArt WHERE ID = @ID AND Concepto = @Concepto)
  END
  ELSE
    SELECT @ImporteTotalSD = SUM(d.CantidadNeta * d.Costo) 
      FROM CompraTCalc d, SerieLoteMov s 
     WHERE d.ID = @ID 
       AND s.Empresa = @Empresa AND s.Modulo = 'COMS' AND s.ID = d.ID AND s.RenglonID = d.RenglonID AND s.Articulo = d.Articulo AND s.SerieLote = @PedimentoEspecifico


  IF @BaseProrrateo = 'CANTIDAD'
  BEGIN
    IF @PedimentoEspecifico IS NULL
    BEGIN
      IF @ProrrateoNivel IS NULL
        SELECT @CantidadTotal = SUM(Cantidad*Factor)
          FROM CompraD 
         WHERE ID = @ID 
      ELSE IF @ProrrateoNivel = 'PROVEEDOR'
        SELECT @CantidadTotal = SUM(Cantidad*Factor)
          FROM CompraD 
         WHERE ID = @ID 
           AND ImportacionProveedor IN (SELECT Proveedor FROM CompraGastoDiversoProv WHERE ID = @ID AND Concepto = @Concepto)
      ELSE IF @ProrrateoNivel = 'REFERENCIA'
        SELECT @CantidadTotal = SUM(Cantidad*Factor)
          FROM CompraD 
         WHERE ID = @ID 
           AND ImportacionReferencia IN (SELECT Referencia FROM CompraGastoDiversoRef WHERE ID = @ID AND Concepto = @Concepto)
      ELSE IF @ProrrateoNivel = 'ARTICULO'
        SELECT @CantidadTotal = SUM(Cantidad*Factor)
          FROM CompraD 
         WHERE ID = @ID 
           AND Articulo IN (SELECT Articulo FROM CompraGastoDiversoArt WHERE ID = @ID AND Concepto = @Concepto)
    END
    ELSE
      SELECT @CantidadTotal = SUM(d.Cantidad*d.Factor) 
        FROM CompraD d, SerieLoteMov s 
       WHERE d.ID = @ID 
         AND s.Empresa = @Empresa AND s.Modulo = 'COMS' AND s.ID = d.ID AND s.RenglonID = d.RenglonID AND s.Articulo = d.Articulo AND s.SerieLote = @PedimentoEspecifico
  END

  IF @BaseProrrateo = 'ARANCEL'
  BEGIN
    IF @PedimentoEspecifico IS NULL
    BEGIN
      IF @ProrrateoNivel IS NULL
        SELECT @ArancelTotal = SUM(d.SubTotal*(aa.Porcentaje/100.0))
          FROM CompraTCalc d, Art a, ArtArancel aa 
         WHERE d.ID = @ID AND d.Articulo =a.Articulo AND a.Arancel = aa.Arancel
      ELSE IF @ProrrateoNivel = 'PROVEEDOR'
        SELECT @ArancelTotal = SUM(d.SubTotal*(aa.Porcentaje/100.0))
          FROM CompraTCalc d, Art a, ArtArancel aa 
         WHERE d.ID = @ID AND d.Articulo =a.Articulo AND a.Arancel = aa.Arancel
           AND ImportacionProveedor IN (SELECT Proveedor FROM CompraGastoDiversoProv WHERE ID = @ID AND Concepto = @Concepto)
      ELSE IF @ProrrateoNivel = 'REFERENCIA'
        SELECT @ArancelTotal = SUM(d.SubTotal*(aa.Porcentaje/100.0))
          FROM CompraTCalc d, Art a, ArtArancel aa 
         WHERE d.ID = @ID AND d.Articulo =a.Articulo AND a.Arancel = aa.Arancel
           AND ImportacionReferencia IN (SELECT Referencia FROM CompraGastoDiversoRef WHERE ID = @ID AND Concepto = @Concepto)
      ELSE IF @ProrrateoNivel = 'ARTICULO'
        SELECT @ArancelTotal = SUM(d.SubTotal*(aa.Porcentaje/100.0))
          FROM CompraTCalc d, Art a, ArtArancel aa 
         WHERE d.ID = @ID AND d.Articulo =a.Articulo AND a.Arancel = aa.Arancel 
           AND d.Articulo IN (SELECT Articulo FROM CompraGastoDiversoArt WHERE ID = @ID AND Concepto = @Concepto)
    END ELSE
      SELECT @ArancelTotal = SUM(d.SubTotal*(aa.Porcentaje/100.0)) 
        FROM CompraTCalc d, Art a, ArtArancel aa, SerieLoteMov s 
       WHERE d.ID = @ID AND d.Articulo =a.Articulo AND a.Arancel = aa.Arancel 
         AND s.Empresa = @Empresa AND s.Modulo = 'COMS' AND s.ID = d.ID AND s.RenglonID = d.RenglonID AND s.Articulo = d.Articulo AND s.SerieLote = @PedimentoEspecifico
  END
  
  IF @BaseProrrateo IN ('PESO/VOLUMEN', 'PESO', 'VOLUMEN')
    EXEC spCompraCalcPesoVolumen @Empresa, @ID, @CfgMultiUnidades, @PesoTotal OUTPUT, @VolumenTotal OUTPUT, @PesoVolumenTotal OUTPUT, @PedimentoEspecifico, @ProrrateoNivel

  SELECT @MovMoneda = Moneda, @MovTipoCambio = TipoCambio FROM Compra WHERE ID = @ID

  IF (@MovMoneda <> @GastoMoneda) OR (@GastoTipoCambio <> @MovTipoCambio)
    SELECT @FactorCosto = @GastoTipoCambio / @MovTipoCambio 
  ELSE SELECT @FactorCosto = 1.0

  BEGIN TRANSACTION
    IF @PedimentoEspecifico IS NULL
    BEGIN
      IF @ProrrateoNivel IS NULL
        DECLARE crCompraD CURSOR FOR
         SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Unidad, d.Cantidad, d.Cantidad*d.Factor, d.SubTotal, ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0), a.Arancel, ISNULL(aa.Porcentaje, 0.0), d.CantidadNeta*d.Costo, d.MonedaD, d.TipoCambioD
           FROM CompraTCalc d
           JOIN Art a ON d.Articulo = a.Articulo 
           LEFT OUTER JOIN ArtArancel aa ON a.Arancel = aa.Arancel
          WHERE d.ID = @ID
      ELSE IF @ProrrateoNivel = 'PROVEEDOR'
        DECLARE crCompraD CURSOR FOR
         SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Unidad, d.Cantidad, d.Cantidad*d.Factor, d.SubTotal, ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0), a.Arancel, ISNULL(aa.Porcentaje, 0.0), d.CantidadNeta*d.Costo, d.MonedaD, d.TipoCambioD
           FROM CompraTCalc d
           JOIN Art a ON d.Articulo = a.Articulo 
           LEFT OUTER JOIN ArtArancel aa ON a.Arancel = aa.Arancel
          WHERE d.ID = @ID
           AND ImportacionProveedor IN (SELECT Proveedor FROM CompraGastoDiversoProv WHERE ID = @ID AND Concepto = @Concepto)
      ELSE IF @ProrrateoNivel = 'REFERENCIA'
        DECLARE crCompraD CURSOR FOR
         SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Unidad, d.Cantidad, d.Cantidad*d.Factor, d.SubTotal, ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0), a.Arancel, ISNULL(aa.Porcentaje, 0.0), d.CantidadNeta*d.Costo, d.MonedaD, d.TipoCambioD
           FROM CompraTCalc d
           JOIN Art a ON d.Articulo = a.Articulo 
           LEFT OUTER JOIN ArtArancel aa ON a.Arancel = aa.Arancel
          WHERE d.ID = @ID
           AND ImportacionReferencia IN (SELECT Referencia FROM CompraGastoDiversoRef WHERE ID = @ID AND Concepto = @Concepto)
      ELSE IF @ProrrateoNivel = 'ARTICULO'
        DECLARE crCompraD CURSOR FOR
         SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Unidad, d.Cantidad, d.Cantidad*d.Factor, d.SubTotal, ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0), a.Arancel, ISNULL(aa.Porcentaje, 0.0), d.CantidadNeta*d.Costo, d.MonedaD, d.TipoCambioD
           FROM CompraTCalc d
           JOIN Art a ON d.Articulo = a.Articulo 
           LEFT OUTER JOIN ArtArancel aa ON a.Arancel = aa.Arancel
          WHERE d.ID = @ID
           AND d.Articulo IN (SELECT Articulo FROM CompraGastoDiversoArt WHERE ID = @ID AND Concepto = @Concepto)
    END
    ELSE
      DECLARE crCompraD CURSOR FOR
       SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Unidad, d.Cantidad, d.Cantidad*d.Factor, d.SubTotal, ISNULL(a.Peso, 0.0), ISNULL(a.Volumen, 0.0), a.Arancel, ISNULL(aa.Porcentaje, 0.0), d.CantidadNeta*d.Costo, d.MonedaD, d.TipoCambioD
         FROM CompraTCalc d
         JOIN Art a ON d.Articulo = a.Articulo 
         LEFT OUTER JOIN ArtArancel aa ON a.Arancel = aa.Arancel
         JOIN SerieLoteMov s ON d.ID = s.ID AND d.RenglonID = s.RenglonID AND d.Articulo = s.Articulo 
        WHERE d.ID = @ID AND s.Empresa = @Empresa AND s.Modulo = 'COMS' AND s.SerieLote = @PedimentoEspecifico

    OPEN crCompraD
    FETCH NEXT FROM crCompraD INTO @Renglon, @RenglonSub, @Articulo, @MovUnidad, @Cantidad, @CantidadF, @CostoLinea, @Peso, @Volumen, @Arancel, @ArancelPorcentaje, @SubTotalSD, @MovMonedaD, @MovTipoCambioD
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Cantidad > 0.0 AND @CostoLinea > 0.0
      BEGIN

        SELECT @MovMoneda = ISNULL(@MovMonedaD, @MovMoneda), @MovTipoCambio = ISNULL(@MovTipoCambioD, @MovTipoCambio)

        IF (@MovMoneda <> @GastoMoneda) OR (@GastoTipoCambio <> @MovTipoCambio)
          SELECT @FactorCosto = @GastoTipoCambio / @MovTipoCambio 
        ELSE SELECT @FactorCosto = 1.0

        SELECT @PesoLinea = @Peso * @CantidadF,
	       @VolumenLinea = @Volumen * @CantidadF,
               @PesoVolumenLinea = @Peso * @Volumen * @CantidadF
        SELECT @CostoArancel = @CostoLinea * (@ArancelPorcentaje/100.0)
   
        SELECT @NuevoCosto = 0.0, @NuevoCostoSD = 0.0
        IF @BaseProrrateo IN ('COSTO', 'CONTRIBUCION') 	SELECT @NuevoCosto = (@CostoLinea * @BaseImporte) / @ImporteTotal      		ELSE
        IF @BaseProrrateo = 'CANTIDAD'                 	SELECT @NuevoCosto = (@CantidadF * @BaseImporte)  / @CantidadTotal      	ELSE
        IF @BaseProrrateo = 'PESO'         		SELECT @NuevoCosto = (@PesoLinea * @BaseImporte)     / @PesoTotal           	ELSE
        IF @BaseProrrateo = 'VOLUMEN'      		SELECT @NuevoCosto = (@VolumenLinea * @BaseImporte) / @VolumenTotal         	ELSE
        IF @BaseProrrateo = 'PESO/VOLUMEN' 		SELECT @NuevoCosto = (@PesoVolumenLinea * @BaseImporte) / @PesoVolumenTotal 	ELSE
        IF @BaseProrrateo = 'ARANCEL'
        BEGIN
          SELECT @NuevoCosto = ISNULL((@CostoArancel * @BaseImporte) / @ArancelTotal,0.0)
          --IF ISNULL(@ArancelPorcentaje, 0.0) = 0.0 SELECT @Ok = -1, @OkRef = 'Error - Falta Configurar el Arancel del Articulo: '+RTRIM(@Articulo)
        END

        IF @BaseProrrateo IN ('COSTO', 'CONTRIBUCION') 	SELECT @NuevoCostoSD = (@SubTotalSD * @BaseImporte) / @ImporteTotalSD      		ELSE
        IF @BaseProrrateo = 'CANTIDAD'                 	SELECT @NuevoCostoSD = (@CantidadF * @BaseImporte)  / @CantidadTotal      	ELSE
        IF @BaseProrrateo = 'PESO'         		SELECT @NuevoCostoSD = (@PesoLinea * @BaseImporte)     / @PesoTotal           	ELSE
        IF @BaseProrrateo = 'VOLUMEN'      		SELECT @NuevoCostoSD = (@VolumenLinea * @BaseImporte) / @VolumenTotal         	ELSE
        IF @BaseProrrateo = 'PESO/VOLUMEN' 		SELECT @NuevoCostoSD = (@PesoVolumenLinea * @BaseImporte) / @PesoVolumenTotal 	ELSE
        IF @BaseProrrateo = 'ARANCEL'
        BEGIN
          SELECT @NuevoCosto = ISNULL((@CostoArancel * @BaseImporte) / @ArancelTotal,0.0)
          --IF ISNULL(@ArancelPorcentaje, 0.0) = 0.0 SELECT @Ok = -1, @OkRef = 'Error - Falta Configurar el Arancel del Articulo: '+RTRIM(@Articulo)
        END

        SELECT @IncCosto = ISNULL(((@NuevoCosto*@FactorCosto)/@Cantidad),0.0)
        SELECT @IncCostoSD = ISNULL(((@NuevoCostoSD*@FactorCosto)/@Cantidad),0.0)

        --SELECT @IncCosto, @IncCostoSD

        IF @MovTipo NOT IN ('COMS.EI', 'COMS.O') OR @BaseProrrateo = 'CONTRIBUCION' 
          UPDATE CompraD SET CostoInv = CostoInv + @IncCosto WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        ELSE
        BEGIN
        --SELECT @Concepto, @ValorAduana
          IF @ValorAduana = 1
          BEGIN
            UPDATE CompraD SET CostoInv = CostoInv + @IncCosto, ValorAduana = ValorAduana + @IncCostoSD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
            INSERT CompraGastoProrrateo(ID,  Renglon,  RenglonSub,  Articulo,  IDRenglon,  Concepto, ValorAlmacen, ValorAduana)
                                    VALUES (@ID, @Renglon, @RenglonSub, @Articulo, @RenglonID, @Concepto, @IncCosto, @IncCosto)
          END
          ELSE
          BEGIN
            UPDATE CompraD SET CostoInv = CostoInv + @IncCosto WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
            INSERT CompraGastoProrrateo(ID,  Renglon,  RenglonSub,  Articulo,  IDRenglon,  Concepto, ValorAlmacen, ValorAduana)
                                    VALUES (@ID, @Renglon, @RenglonSub, @Articulo, @RenglonID, @Concepto, @IncCosto, 0)
          END
        END
      END
      FETCH NEXT FROM crCompraD INTO @Renglon, @RenglonSub, @Articulo, @MovUnidad, @Cantidad, @CantidadF, @CostoLinea, @Peso, @Volumen, @Arancel, @ArancelPorcentaje, @SubTotalSD, @MovMonedaD, @MovTipoCambioD
    END 
    CLOSE crCompraD
    DEALLOCATE crCompraD
  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE BEGIN
    ROLLBACK TRANSACTION
    RAISERROR(@OkRef,16,-1) 
  END 

  RETURN
END
GO

--  spCompraProratearAplica 100, 'Costo', 500, 15, 94
/**************** spCompraProratearAplica ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraProratearAplica') and type = 'P') drop procedure dbo.spCompraProratearAplica
GO             
CREATE PROCEDURE spCompraProratearAplica
                   @ID			int,
		   @BaseProrrateo	char(20),
		   @BaseImporte		float,
		   @PorcentajeImpuesto	float,
                   @AplicaID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal		int,
    @Empresa		char(5),
    @CfgMultiUnidades	bit,
    @Ok			int,
    @OkRef		varchar(255),
    @Renglon		float,
    @RenglonSub		int,
    @RenglonID		int,
    @RenglonTipo	char(1),
    @Articulo		char(20),
    @ArtTipo		varchar(20),
    @Cantidad		float,
    @CantidadF		float,
    @CantidadInventario	float,
    @CostoArancel	float,
    @ArancelTotal	float,
    @Costo		float,
    @CostoLinea		float,
    @DescuentoTipo	char(1),
    @DescuentoLinea	float,
    @Peso		float,
    @PesoLinea		float,
    @Volumen		float,
    @VolumenLinea	float,
    @PesoVolumenLinea	float,
    @Arancel		varchar(50),
    @ArancelPorcentaje	float,
    @Moneda		char(10),
    @TipoCambio		float,
    @Almacen		char(10),
    @AplicaMoneda	char(10),
    @AplicaTipoCambio	float,
    @AplicaFactor	float,
    @ImporteTotal	float,
    @CantidadTotal 	float,
    @PesoTotal		float,
    @VolumenTotal	float,
    @PesoVolumenTotal	float,
    @NuevoCosto		float,
    @NuevoCostoUnitario float,
    @CostoTotal		float,
    @MovUnidad		varchar(50),
    @Mov		char(20),
    @MovID		varchar(20),
    @AplicaMov		char(20),
    @AplicaMovID	varchar(20),	
    @RedondeoMonetarios	int,
    @MovTipo		varchar(20),
    @Codigo		varchar(30),
    @SubCuenta		varchar(50),
    @AlmacenSucursal	int,
    @Factor		float,
    @Existencia		float

  SELECT @RedondeoMonetarios = RedondeoMonetarios FROM Version 
  SELECT @Ok = NULL, @OkRef = NULL, @BaseProrrateo = UPPER(@BaseProrrateo)

  SELECT @Mov = Mov, @MovID = MovID, @Sucursal = Sucursal FROM Compra WHERE ID = @ID
  SELECT @AplicaMov = Mov, @AplicaMovID = MovID, @Empresa = Empresa, @AplicaMoneda = Moneda, @ImporteTotal = ISNULL(Importe, 0.0)
    FROM Compra 
   WHERE ID = @AplicaID
  SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'COMS' AND Mov = @Mov

  SELECT @CfgMultiUnidades = MultiUnidades FROM EmpresaCfg2 WHERE Empresa = @Empresa

  IF @BaseProrrateo = 'CANTIDAD' 
    SELECT @CantidadTotal = SUM(Cantidad*Factor) FROM CompraD WHERE ID = @AplicaID
  ELSE
  IF @BaseProrrateo IN ('PESO/VOLUMEN', 'PESO', 'VOLUMEN')
    EXEC spCompraCalcPesoVolumen @Empresa, @AplicaID, @CfgMultiUnidades, @PesoTotal OUTPUT, @VolumenTotal	OUTPUT, @PesoVolumenTotal OUTPUT
  ELSE
  IF @BaseProrrateo = 'ARANCEL'
    SELECT @ArancelTotal = SUM(t.SubTotal*(aa.Porcentaje/100.0)) FROM CompraTCalc t, Art a, ArtArancel aa WHERE t.ID = @AplicaID AND t.Articulo =a.Articulo AND a.Arancel = aa.Arancel
  
  SELECT @CostoTotal = 0.0
  SELECT @Moneda = Moneda, @TipoCambio = TipoCambio FROM Compra WHERE ID = @ID

  EXEC spMoneda NULL, @Moneda, @TipoCambio, @AplicaMoneda, @AplicaFactor OUTPUT, @AplicaTipoCambio OUTPUT, @Ok OUTPUT
  IF @Ok IS NOT NULL SELECT @OkRef = 'Error - Tipo Cambio'
  BEGIN TRANSACTION
    DELETE CompraD WHERE ID = @ID

    DECLARE crAplica CURSOR FOR
     SELECT d.Renglon, d.RenglonSub, d.RenglonID, d.RenglonTipo, d.Almacen, d.Codigo, d.Articulo, NULLIF(RTRIM(d.SubCuenta), ''), d.Cantidad, d.Cantidad*d.Factor, d.Unidad, ISNULL(NULLIF(d.Factor, 0.0), 1.0), ISNULL(d.CantidadInventario, d.Cantidad), d.Costo, d.DescuentoTipo, d.DescuentoLinea, a.Peso, a.Volumen, a.Arancel, aa.Porcentaje, a.Tipo
       FROM CompraD d
       JOIN Art a ON d.Articulo = a.Articulo 
       LEFT OUTER JOIN ArtArancel aa ON a.Arancel = aa.Arancel
      WHERE d.ID = @AplicaID
    OPEN crAplica 
    FETCH NEXT FROM crAplica INTO @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @Almacen, @Codigo, @Articulo, @SubCuenta, @Cantidad, @CantidadF, @MovUnidad, @Factor, @CantidadInventario, @Costo, @DescuentoTipo, @DescuentoLinea, @Peso, @Volumen, @Arancel, @ArancelPorcentaje, @ArtTipo
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Cantidad > 0.0 AND @Costo > 0.0 AND @Ok IS NULL
      BEGIN
        SELECT @AlmacenSucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
        SELECT @CostoLinea = @Costo * @Cantidad, 
	       @PesoLinea = @Peso * @CantidadF,
	       @VolumenLinea = @Volumen * @CantidadF,
	       @PesoVolumenLinea = @Peso * @Volumen * @CantidadF
        SELECT @CostoArancel = @CostoLinea * (@ArancelPorcentaje/100.0)

  	IF @DescuentoLinea > 0.0 
  	BEGIN
          IF @DescuentoTipo <> '$' 
            SELECT @CostoLinea = @CostoLinea - (@CostoLinea * (@DescuentoLinea/100.0))
          ELSE SELECT @CostoLinea = @CostoLinea - (@DescuentoLinea * @Cantidad)
        END

        SELECT @NuevoCosto = 0.0
        IF @BaseProrrateo = 'COSTO'        SELECT @NuevoCosto = (@CostoLinea * @BaseImporte) / @ImporteTotal ELSE
        IF @BaseProrrateo = 'CANTIDAD'     SELECT @NuevoCosto = (@CantidadF * @BaseImporte)  / @CantidadTotal ELSE
        IF @BaseProrrateo = 'PESO'         SELECT @NuevoCosto = (@PesoLinea * @BaseImporte) / @PesoTotal ELSE
        IF @BaseProrrateo = 'VOLUMEN'      SELECT @NuevoCosto = (@VolumenLinea * @BaseImporte) / @VolumenTotal ELSE
        IF @BaseProrrateo = 'PESO/VOLUMEN' SELECT @NuevoCosto = (@PesoVolumenLinea * @BaseImporte) / @PesoVolumenTotal ELSE
        IF @BaseProrrateo = 'ARANCEL'
        BEGIN
          SELECT @NuevoCosto = (@CostoArancel * @BaseImporte) / @ArancelTotal
          --IF ISNULL(@ArancelPorcentaje, 0.0) = 0.0 SELECT @Ok = -1, @OkRef = 'Error - Falta Configurar el Arancel del Articulo: '+RTRIM(@Articulo)
        END
        IF @NuevoCosto > 0.0
        BEGIN
          SELECT @NuevoCostoUnitario = @NuevoCosto/@Cantidad
	  SELECT @CostoTotal = @CostoTotal + ROUND(@NuevoCosto, @RedondeoMonetarios)
          IF @MovTipo = 'COMS.GX'
          BEGIN
            IF UPPER(@ArtTipo) IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA') 
            BEGIN
               SELECT @Existencia = SUM(s.Existencia)
                 FROM SerieLoteMov m
                 JOIN SerieLote s ON s.Sucursal = m.Sucursal AND s.Empresa = m.Empresa AND s.Articulo = m.Articulo AND ISNULL(s.SubCuenta, '') = ISNULL(m.SubCuenta, '') AND s.Almacen = @Almacen AND s.SerieLote = m.SerieLote
                WHERE m.Empresa = @Empresa AND m.Modulo = 'COMS' AND m.ID = @AplicaID AND m.RenglonID = @RenglonID AND m.Articulo = @Articulo AND ISNULL(m.SubCuenta, '') = ISNULL(@SubCuenta, '')               
            END ELSE 
            BEGIN
              IF @SubCuenta IS NULL
                SELECT @Existencia = ISNULL(SUM(Inventario), 0.0) FROM ArtExistenciaInv WHERE Sucursal = @AlmacenSucursal AND Empresa = @Empresa AND Articulo = @Articulo
              ELSE
                SELECT @Existencia = ISNULL(SUM(Inventario), 0.0) FROM ArtSubExistenciaInv WHERE Sucursal = @AlmacenSucursal AND Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta
            END
            SELECT @Existencia = ISNULL(@Existencia, 0.0)

            IF @Existencia < @CantidadInventario
            BEGIN
              SELECT @CantidadInventario = @CantidadInventario - @Existencia
              INSERT CompraD (
                     Sucursal,  ID,  Renglon,  RenglonSub,    RenglonID,  RenglonTipo,  Codigo,  Articulo,  SubCuenta,  Almacen,  Cantidad,                    Unidad,     Factor,  CantidadInventario,  Costo,               Impuesto1,           DescuentoTipo, EsEstadistica) 
              SELECT @Sucursal, @ID, @Renglon, @RenglonSub+1, 0,          @RenglonTipo, @Codigo, @Articulo, @SubCuenta, @Almacen, @CantidadInventario/@Factor, @MovUnidad, @Factor, @CantidadInventario, @NuevoCostoUnitario, @PorcentajeImpuesto, NULL,          1
              SELECT @CantidadInventario = @Existencia
            END
          END
          IF @CantidadInventario > 0.0
          BEGIN
            INSERT CompraD (
                   Sucursal,  ID,  Renglon,  RenglonSub,  RenglonID,  RenglonTipo,  Codigo,  Articulo,  SubCuenta,  Almacen,  Cantidad,                    Unidad,     Factor,  CantidadInventario,  Costo,               Impuesto1,           DescuentoTipo) 
            SELECT @Sucursal, @ID, @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @Codigo, @Articulo, @SubCuenta, @Almacen, @CantidadInventario/@Factor, @MovUnidad, @Factor, @CantidadInventario, @NuevoCostoUnitario, @PorcentajeImpuesto, NULL
            IF UPPER(@ArtTipo) IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA') 
            BEGIN
              DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'COMS' AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')

              INSERT SerieLoteMov (Empresa, Sucursal, Modulo, ID, RenglonID, Articulo, SubCuenta,    SerieLote, Cantidad)
              SELECT @Empresa, @Sucursal, 'COMS', @ID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), s.SerieLote, s.Existencia
                FROM SerieLoteMov m
                JOIN SerieLote s ON s.Sucursal = m.Sucursal AND s.Empresa = m.Empresa AND s.Articulo = m.Articulo AND ISNULL(s.SubCuenta, '') = ISNULL(m.SubCuenta, '') AND s.Almacen = @Almacen AND s.SerieLote = m.SerieLote AND ISNULL(s.Existencia, 0.0) > 0.0
               WHERE m.Empresa = @Empresa AND m.Modulo = 'COMS' AND m.ID = @AplicaID AND m.RenglonID = @RenglonID AND m.Articulo = @Articulo AND ISNULL(m.SubCuenta, '') = ISNULL(@SubCuenta, '')               
            END
          END
        END
      END
      FETCH NEXT FROM crAplica INTO @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @Almacen, @Codigo, @Articulo, @SubCuenta, @Cantidad, @CantidadF, @MovUnidad, @Factor, @CantidadInventario, @Costo, @DescuentoTipo, @DescuentoLinea, @Peso, @Volumen, @Arancel, @ArancelPorcentaje, @ArtTipo
    END 
    IF @BaseImporte <> @CostoTotal
      UPDATE CompraD SET Costo = Costo + (@BaseImporte - @CostoTotal) / (Cantidad*Factor) WHERE ID = @ID AND Renglon = @Renglon

    CLOSE crAplica 
    DEALLOCATE crAplica 
    UPDATE Compra SET RenglonID = @RenglonID + 1, ProrrateoAplicaID = @AplicaID WHERE ID = @ID
 
    EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'COMS', @ID, @Mov, @MovID, 'COMS', @AplicaID, @AplicaMov, @AplicaMovID, @Ok OUTPUT

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT "Prorrateo Concluido"
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @OkRef
  END
  RETURN
END
GO

-- spContPolizaCierre 1, 'DEMO', 'Cierre', 'Pesos', 'R', 'DEMO', '22/8/3'
/**************** spContPolizaCierre ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContPolizaCierre') and type = 'P') drop procedure dbo.spContPolizaCierre
GO             
CREATE PROCEDURE spContPolizaCierre
                    @Estacion		int,
		    @Empresa		char(5),
                    @MovCierre		char(20),
		    @Moneda		char(10),
                    @CtaResultados	char(20),
		    @Usuario		char(10),
		    @FechaTrabajo	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal		int,
    @ID			int,
    @Renglon		float,
    @TipoCambio		float,
    @Cuenta		char(20),
    @CuentaCierre	char(20),
    @Rama  		char(20),
    @EsAcreedora	bit,
    @Periodo 		int, 
    @Ejercicio		int,
    @EjercicioInicio	datetime, 
    @EjercicioFinal 	datetime,
    @Ok			int,
    @Importe		money

  SELECT @Ok = NULL
  SELECT @EjercicioInicio = EjercicioInicio, @EjercicioFinal = EjercicioFinal
    FROM EmpresaGral
   WHERE Empresa = @Empresa
  SELECT @CuentaCierre = NULLIF(RTRIM(ContCuentaCierre), '') FROM EmpresaCfg WHERE Empresa = @Empresa
  EXEC spPeriodoEjercicio @Empresa, 'CONT', @FechaTrabajo, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  DELETE VerContListaCta  WHERE Estacion = @Estacion
  DELETE VerContListaRama WHERE Estacion = @Estacion
  INSERT VerContListaRama (Estacion, Cuenta) VALUES (@Estacion, @CtaResultados)
  SELECT @Sucursal = Sucursal FROM UsuarioSucursal WHERE Usuario = @Usuario

  DECLARE crRecorrerRama CURSOR FOR
   SELECT Cuenta 
     FROM VerContListaRama 
    WHERE Estacion = @Estacion

  OPEN crRecorrerRama
  FETCH NEXT FROM crRecorrerRama INTO @Rama
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spContRecorrerRama @Estacion, @Rama

    FETCH NEXT FROM crRecorrerRama INTO @Rama
  END
  CLOSE crRecorrerRama
  DEALLOCATE crRecorrerRama

  BEGIN TRANSACTION
    EXEC spExtraerFecha @FechaTrabajo OUTPUT
    SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
    INSERT Cont (Sucursal, Empresa,  Mov,        FechaEmision,  FechaContable, Moneda, TipoCambio,   Usuario,  Estatus)
         VALUES (@Sucursal, @Empresa, @MovCierre, @FechaTrabajo, @FechaTrabajo, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR')
    SELECT @ID = SCOPE_IDENTITY()
    SELECT @Renglon = 0

    DECLARE crListaCta CURSOR FOR 
     SELECT l.Cuenta, c.EsAcreedora 
       FROM VerContListaCta l, Cta c
      WHERE l.Estacion = @Estacion
        AND l.Cuenta = c.Cuenta

    OPEN crListaCta
    FETCH NEXT FROM crListaCta INTO @Cuenta, @EsAcreedora
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
	EXEC spContPolizaDCierre @Sucursal, @ID, @Empresa, @Moneda, @Cuenta, @EsAcreedora, @Ejercicio, /*@EjercicioInicio, @EjercicioFinal, */@Renglon OUTPUT
      FETCH NEXT FROM crListaCta INTO @Cuenta, @EsAcreedora
    END
    CLOSE crListaCta
    DEALLOCATE crListaCta
    IF @CuentaCierre IS NOT NULL
    BEGIN
      SELECT @EsAcreedora = EsAcreedora FROM Cta WHERE Cuenta = @CuentaCierre
      EXEC spContPolizaCuentaCierre @Sucursal, @ID, @Empresa, @Moneda, @CuentaCierre, @EsAcreedora, @Ejercicio, @Renglon OUTPUT
    END
  COMMIT TRANSACTION

  SELECT "Se Creo el Movimiento: "+RTRIM(@MovCierre)

  RETURN
END
GO

/**************** spContPolizaCuentaCierre ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContPolizaCuentaCierre') and type = 'P') drop procedure dbo.spContPolizaCuentaCierre
GO             
CREATE PROCEDURE spContPolizaCuentaCierre
    		    @Sucursal		int,
    		    @ID			int,
		    @Empresa		char(5),
		    @Moneda		char(10),
    		    @Cuenta		char(20),
		    @EsAcreedora	bit,
    		    @Ejercicio		int,
		    @Renglon		float 	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Debe		money,
    @Haber		money,
    @Saldo		money,
    @SubCuenta		varchar(50),
    @SucursalContable	int

  DECLARE crContD CURSOR FOR
   SELECT SucursalContable, NULLIF(RTRIM(SubCuenta), ''), SUM(ISNULL(Debe, 0))-SUM(ISNULL(Haber, 0))
     FROM ContD
    WHERE ID = @ID
    GROUP BY SucursalContable, SubCuenta
    ORDER BY SucursalContable, SubCuenta

  OPEN crContD
  FETCH NEXT FROM crContD INTO @SucursalContable, @SubCuenta, @Saldo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
	    IF @@FETCH_STATUS <> -2 AND ISNULL(@Saldo, 0) <> 0
    BEGIN
      IF @Saldo < 0
        SELECT @Debe = -@Saldo, @Haber = NULL 
      ELSE 
        SELECT @Haber = @Saldo, @Debe = NULL 
      SELECT @Renglon = @Renglon + 2048
      INSERT ContD (Sucursal, SucursalContable, ID, Renglon, Cuenta, SubCuenta, Debe, Haber) 
            VALUES (@Sucursal, @SucursalContable, @ID, @Renglon, @Cuenta, @SubCuenta, @Debe, @Haber)
    END
    FETCH NEXT FROM crContD INTO @SucursalContable, @SubCuenta, @Saldo
  END
  CLOSE crContD
  DEALLOCATE crContD
END
GO

/**************** spContPolizaDCierre ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContPolizaDCierre') and type = 'P') drop procedure dbo.spContPolizaDCierre
GO             
CREATE PROCEDURE spContPolizaDCierre
    		    @Sucursal		int,
    		    @ID			int,
		    @Empresa		char(5),
		    @Moneda		char(10),
    		    @Cuenta		char(20),
		    @EsAcreedora	bit,
    		    @Ejercicio		int,
--    		    @EjercicioInicio	datetime, 
--    		    @EjercicioFinal 	datetime,
		    @Renglon		float 	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Debe		money,
    @Haber		money,
    @Saldo		money,
    @SubCuenta		varchar(50),
    @SucursalContable	int

/*  IF @EjercicioInicio IS NOT NULL AND @EjercicioFinal IS NOT NULL
    DECLARE crContSaldos CURSOR FOR
     SELECT d.SucursalContable, NULLIF(RTRIM(d.SubCuenta), ''), SUM(ISNULL(d.Debe, 0))-SUM(ISNULL(d.Haber, 0))
       FROM ContD d
       JOIN Cont c ON c.ID = d.ID AND c.Empresa = @Empresa AND c.Moneda = @Moneda AND c.Estatus = 'CONCLUIDO' AND c.FechaContable BETWEEN @EjercicioInicio AND @EjercicioFinal
       JOIN MovTipo m ON c.Mov = m.Mov AND m.Modulo = 'CONT' AND m.Clave <> 'CONT.PR'
      WHERE d.Cuenta = @Cuenta
      GROUP BY d.SucursalContable, d.SubCuenta
      ORDER BY d.SucursalContable, d.SubCuenta
  ELSE*/
    DECLARE crContSaldos CURSOR FOR
     SELECT Sucursal, NULLIF(RTRIM(SubCuenta), ''), ISNULL(SUM(ISNULL(Cargos, 0.0) - ISNULL(Abonos, 0.0)), 0.0)
       FROM Acum a
      WHERE a.Empresa = @Empresa
        AND a.Rama = 'CONT'
        AND a.Moneda = @Moneda
        AND a.Cuenta = @Cuenta
        AND a.Ejercicio = @Ejercicio
      GROUP BY Sucursal, SubCuenta
      ORDER BY Sucursal, SubCuenta

  OPEN crContSaldos
  FETCH NEXT FROM crContSaldos INTO @SucursalContable, @SubCuenta, @Saldo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND ISNULL(@Saldo, 0) <> 0
    BEGIN
      IF @EsAcreedora = 1
        SELECT @Debe = -@Saldo, @Haber = NULL 
      ELSE 
        SELECT @Haber = @Saldo, @Debe = NULL 
      SELECT @Renglon = @Renglon + 2048
      INSERT ContD (Sucursal, SucursalContable, ID, Renglon, Cuenta, SubCuenta, Debe, Haber) 
            VALUES (@Sucursal, @SucursalContable, @ID, @Renglon, @Cuenta, @SubCuenta, @Debe, @Haber)
    END
    FETCH NEXT FROM crContSaldos INTO @SucursalContable, @SubCuenta, @Saldo
  END
  CLOSE crContSaldos
  DEALLOCATE crContSaldos
END
GO

/**************** spContRecorrerRama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContRecorrerRama') and type = 'P') drop procedure dbo.spContRecorrerRama
GO             
CREATE PROCEDURE spContRecorrerRama
                    @Estacion		int,
                    @Rama		char(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cuenta  		char(20),
    @EsAcumulativa	bit

  DECLARE crRecorrerCta CURSOR FOR
   SELECT Cuenta, EsAcumulativa 
     FROM Cta 
    WHERE Rama = @Rama 

  OPEN crRecorrerCta
  FETCH NEXT FROM crRecorrerCta INTO @Cuenta, @EsAcumulativa
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @EsAcumulativa = 0
        INSERT VerContListaCta (Estacion, Cuenta) VALUES (@Estacion, @Cuenta)
      ELSE
        INSERT VerContListaRama (Estacion, Cuenta) VALUES (@Estacion, @Cuenta)
    END
    FETCH NEXT FROM crRecorrerCta INTO @Cuenta, @EsAcumulativa
  END
  CLOSE crRecorrerCta
  DEALLOCATE crRecorrerCta
  RETURN
END
GO

-- spConversion 24, 0, 'MEX'
/**************** spConversion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spConversion') and type = 'P') drop procedure dbo.spConversion
GO             
CREATE PROCEDURE spConversion
		    @ID			int,
		    @Sucursal		int,
		    @Empresa		char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaRegistro	datetime,
    @IDCredito		int,
    @IDCargo		int,
    @IDAplicacion	int,
    @IDMovimiento	int,
    @Cuenta		char(10),
    @Usuario		char(10),
    @Modulo 		char(5),
    @FechaEmision	datetime,
    @MovCargo		char(20),
    @MovIDCargo		char(20),
    @Mov		char(20),
    @MovID		varchar(20),
    @MovMoneda		char(10),
    @MovTipoCambio	float,
    @Movimiento		char(20),
    @MovimientoID	varchar(20),
    @Moneda		char(10),
    @TipoCambio		float,
    @Saldo		money,
    @SaldoMoneda	char(10),
    @SaldoTipoCambio	float,
    @SaldoFactor	float,
    @SaldoImporte	money,
    @SaldoImpuestos	money,
    @ImporteTotal	money,
    @Importe		money,
    @Impuestos		money,
    @MovAplicacion	char(20),
    @MovIDAplicacion	varchar(20),
    @DifCambiaria 	money,
    @IVAFiscal		float,
    @IEPSFiscal		float,
    @concepto		varchar(30),
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL

  SELECT @FechaRegistro = GETDATE()
  SELECT @Cuenta = Cuenta, 
         @Modulo = Modulo,
         @Usuario = Usuario,
         @FechaEmision = FechaEmision,
         @Mov = Mov,
         @MovID = MovID,
         @MovMoneda = MovMoneda,
         @MovTipoCambio = MovTipoCambio,
         @Movimiento = Movimiento,
         @Moneda = Moneda,
         @TipoCambio = TipoCambio
    FROM Conversion
   WHERE ID = @ID

/*
  IF (@Modulo = 'CXC' AND @Mov NOT EXISTS (SELECT * FROM MovTipoCxcCredito WHERE Mov = @Mov)) OR
     (@Modulo = 'CXP' AND @Mov NOT EXISTS (SELECT * FROM MovTipoCxpCargo WHERE Mov = @Mov))
  BEGIN
    EXEC spConversionOtros @ID, @Sucursal, @Empresa
    RETURN
  END
 */

  SELECT @MovCargo = CASE @Modulo WHEN 'CXC' THEN CxcConversionCargo ELSE CxpConversionCredito END,
         @MovAplicacion = CASE @Modulo WHEN 'CXC' THEN CxcAplicacion ELSE CxpAplicacion END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Modulo = 'CXC' SELECT @IDCredito = ID, @Saldo = Saldo, @SaldoMoneda = ClienteMoneda,   @SaldoTipoCambio = ClienteTipoCambio,   @SaldoFactor = CONVERT(float, Impuestos)/(CONVERT(float, Impuestos)+NULLIF(Importe, 0)), @IVAFiscal = IVAFiscal, @IEPSFiscal = IEPSFiscal FROM Cxc WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus = 'PENDIENTE' AND Cliente = @Cuenta ELSE
  IF @Modulo = 'CXP' SELECT @IDCredito = ID, @Saldo = Saldo, @SaldoMoneda = ProveedorMoneda, @SaldoTipoCambio = ProveedorTipoCambio, @SaldoFactor = CONVERT(float, Impuestos)/(CONVERT(float, Impuestos)+NULLIF(Importe, 0)), @IVAFiscal = IVAFiscal, @IEPSFiscal = IEPSFiscal,@concepto=concepto FROM Cxp WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus = 'PENDIENTE' AND Proveedor = @Cuenta

  SELECT @ImporteTotal = (@Saldo * @MovTipoCambio) / @TipoCambio
  SELECT @SaldoImpuestos = @Saldo * @SaldoFactor,  @Impuestos = @ImporteTotal * @SaldoFactor
  SELECT @SaldoImporte = @Saldo - @SaldoImpuestos, @Importe = @ImporteTotal - @Impuestos

  SELECT @DifCambiaria = @ImporteTotal - ((@Saldo * @SaldoTipoCambio) / @TipoCambio)

  IF @IDCredito IS NOT NULL
  BEGIN
    BEGIN TRANSACTION

    EXEC @IDCargo = spMovCopiar @Sucursal, @Modulo, @IDCredito, @Usuario, @FechaEmision, 1
    IF @IDCargo IS NOT NULL
    BEGIN
      --BUG15149    
      IF @Modulo = 'CXC' UPDATE Cxc SET Mov = @MovCargo, Moneda = @MovMoneda, TipoCambio = @MovTipoCambio, Usuario = @Usuario, Importe = @SaldoImporte, Impuestos = @SaldoImpuestos, IVAFiscal = @IVAFiscal, IEPSFiscal = @IEPSFiscal, AplicaManual = 0, ClienteTipoCambio   = @MovTipoCambio WHERE ID = @IDCargo ELSE
      IF @Modulo = 'CXP' UPDATE Cxp SET Mov = @MovCargo, Moneda = @MovMoneda, TipoCambio = @MovTipoCambio, Usuario = @Usuario, Importe = @SaldoImporte, Impuestos = @SaldoImpuestos, IVAFiscal = @IVAFiscal, IEPSFiscal = @IEPSFiscal, AplicaManual = 0, ProveedorTipoCambio = @MovTipoCambio WHERE ID = @IDCargo 

      EXEC spCx @IDCargo, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                @MovCargo, @MovIDCargo OUTPUT, NULL, 
                @Ok OUTPUT, @OkRef OUTPUT
    END
    IF @Ok IS NULL
    BEGIN
      EXEC spCx @IDCredito, @Modulo, 'GENERAR', 'TODO', @FechaRegistro, @MovAplicacion, @Usuario, 1, 0,
                NULL, NULL, @IDAplicacion OUTPUT, 
                @Ok OUTPUT, @OkRef OUTPUT
                
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      IF @IDAplicacion IS NOT NULL AND @Ok IS NULL
      BEGIN
        IF @Modulo = 'CXC'
        BEGIN
          --BUG15149
          UPDATE Cxc SET Moneda = @MovMoneda, TipoCambio = @MovTipoCambio, ClienteTipoCambio = @MovTipoCambio WHERE ID = @IDAplicacion
          INSERT CxcD (ID, Renglon, Aplica, AplicaID, Importe) VALUES (@IDAplicacion, 2048, @MovCargo, @MovIDCargo, @Saldo) 
        END
        IF @Modulo = 'CXP'
        BEGIN
          --BUG15149
         UPDATE Cxp SET Moneda = @MovMoneda, TipoCambio = @MovTipoCambio, ProveedorTipoCambio = @MovTipoCambio, concepto=@concepto  WHERE ID = @IDAplicacion
         INSERT CxpD (ID, Renglon, Aplica, AplicaID, Importe) VALUES (@IDAplicacion, 2048, @MovCargo, @MovIDCargo, @Saldo) 
        END

        EXEC spCx @IDAplicacion, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                  @MovAplicacion, @MovIDAplicacion OUTPUT, NULL, 
                  @Ok OUTPUT, @OkRef OUTPUT
      END
    END

    IF @Ok IS NULL
    BEGIN
      IF @Modulo = 'CXC'
        INSERT Cxc (Sucursal, Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus,
                    Cliente, ClienteMoneda, ClienteTipoCambio, Importe, Impuestos, DiferenciaCambiaria, IVAFiscal, IEPSFiscal)
            VALUES (@Sucursal, @Empresa, @Movimiento, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR',
                    @Cuenta, @Moneda,       @TipoCambio,       @Importe, @Impuestos, @DifCambiaria, @IVAFiscal, @IEPSFiscal)
      ELSE
      IF @Modulo = 'CXP'
        INSERT Cxp (Sucursal, Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus,
                    Proveedor, ProveedorMoneda, ProveedorTipoCambio, Importe, Impuestos, DiferenciaCambiaria, IVAFiscal, IEPSFiscal)
            VALUES (@Sucursal, @Empresa, @Movimiento, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR',
                    @Cuenta,   @Moneda,          @TipoCambio,       @Importe, @Impuestos, @DifCambiaria, @IVAFiscal, @IEPSFiscal)
      SELECT @IDMovimiento = SCOPE_IDENTITY()
      EXEC spCx @IDMovimiento, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                @Movimiento, @MovimientoID OUTPUT, NULL, 
                @Ok OUTPUT, @OkRef OUTPUT
    END

    IF @Ok IS NULL
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
  END
  IF @Ok IS NULL 
    SELECT @Mensaje = 'Conversion Realizada.<BR><BR>'+RTRIM(@Movimiento)+' '+RTRIM(@MovimientoID)
  ELSE
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN 
END
GO


-- select * from conversion
-- spConversion 15, 0, 'DEMO'

-- spCorteCostoPiso 'DA', 0, 'JL', '9/25/3', '9/30/02'
/*
declare
  @saldo money
exec spVerCostoPiso 'DA', '3FABP04B89M125446', 0, 1, '9/30/02', @Saldo OUTPUT
select @saldo
*/

/**************** spCorteCostoPiso ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteCostoPiso') and type = 'P') drop procedure dbo.spCorteCostoPiso
GO             
CREATE PROCEDURE spCorteCostoPiso
			@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@FechaEmision	datetime,
			@FechaCorte	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @UltimoPagoCostoPiso	datetime,
    @Concepto			varchar(50),
    @VIN			varchar(20),
    @Acreedor			varchar(10),
    @Saldo			money,
    @GastoMov			char(20), 
    @GastoID			int,
    @Renglon			float,
    @Moneda			char(10),
    @TipoCambio			float,
    @PorcentajeDeducible	float,
    @PorcentajeImpuestos	float,
    @Impuestos			money,
    @Ok				int,
    @OkRef			varchar(255),
    @Mensaje			varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @Renglon = 0.0
  SELECT @GastoMov = Gasto FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @UltimoPagoCostoPiso = UltimoPagoCostoPiso,
         @Concepto = ConceptoGastoCostoPiso,
         @Acreedor = FordCliente
    FROM EmpresaGral 
   WHERE Empresa = @Empresa
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  CREATE TABLE #CorteCostoPiso (
     VIN 	varchar(20) 	COLLATE Database_Default NULL,
     Saldo      money    	NULL)

  SELECT @PorcentajeDeducible = PorcentajeDeducible, @PorcentajeImpuestos = Impuestos FROM Concepto WHERE Modulo = 'GAS' AND Concepto = @Concepto
  INSERT Gasto (Sucursal, Empresa,  Mov,       FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,    UltimoCambio, Acreedor,  Clase,   SubClase,   Condicion,   Prioridad, CostoPisoD, CostoPisoA)
        SELECT @Sucursal, @Empresa, @GastoMov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'BORRADOR', GETDATE(),    @Acreedor, c.Clase, c.SubClase, p.Condicion, 'Normal',  @UltimoPagoCostoPiso, @FechaCorte
          FROM Concepto c, Prov p
         WHERE c.Modulo = 'GAS' AND c.Concepto = @Concepto AND p.Proveedor = @Acreedor
  SELECT @GastoID = SCOPE_IDENTITY()

  DECLARE crCorteCostoPiso CURSOR FOR
   SELECT VIN
     FROM VIN
    WHERE TipoUnidad = 'Nuevo' AND (UltimoPagoCostoPiso IS NULL OR UltimoPagoCostoPiso = @UltimoPagoCostoPiso)

  OPEN crCorteCostoPiso
  FETCH NEXT FROM crCorteCostoPiso INTO @VIN
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC spVerCostoPiso @Empresa, @VIN, 0, 1, @FechaCorte, @Saldo OUTPUT
      IF NULLIF(@Saldo, 0) IS NOT NULL
      BEGIN
        SELECT @Renglon = @Renglon + 2048.0, @Saldo = ROUND(@Saldo, 2)
        SELECT @Impuestos = @Saldo * (@PorcentajeImpuestos / 100)
        INSERT GastoD (ID,       Renglon,  Concepto,  Fecha,       Referencia,  Cantidad,  Precio, Importe, Impuestos,  Sucursal,  PorcentajeDeducible,  VIN)
               VALUES (@GastoID, @Renglon, @Concepto, @FechaCorte, @VIN,        1,         @Saldo, @Saldo,  @Impuestos, @Sucursal, @PorcentajeDeducible, @VIN)
      END
    END
    FETCH NEXT FROM crCorteCostoPiso INTO @VIN
  END
  CLOSE crCorteCostoPiso
  DEALLOCATE crCorteCostoPiso

  IF @Ok IS NULL 
    SELECT @Mensaje = 'Gasto Generado con Exito. (Borrador)'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO
 
/**************** spCorteInv ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteInv') and type = 'P') drop procedure dbo.spCorteInv
GO             
CREATE PROCEDURE spCorteInv
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Fecha	datetime
  SELECT @Fecha = GETDATE()
  EXEC spExtraerFecha @Fecha OUTPUT
  DELETE CorteCosto WHERE Fecha = @Fecha
  DELETE CorteExistencia WHERE Fecha = @Fecha

  INSERT CorteCosto (Fecha,  Empresa, Sucursal, Articulo, SubCuenta, CostoPromedio, UltimoCosto, UltimoCostoSinGastos, CostoEstandar, CostoReposicion)
              SELECT @Fecha, Empresa, Sucursal, Articulo, '',        CostoPromedio, UltimoCosto, UltimoCostoSinGastos, CostoEstandar, CostoReposicion
                FROM ArtCostoSucursal
  INSERT CorteCosto (Fecha,  Empresa, Sucursal, Articulo, SubCuenta,                                CostoPromedio, UltimoCosto, UltimoCostoSinGastos, CostoEstandar, CostoReposicion)
              SELECT @Fecha, Empresa, Sucursal, Articulo, ISNULL(NULLIF(RTRIM(SubCuenta), ''), ''), CostoPromedio, UltimoCosto, UltimoCostoSinGastos, CostoEstandar, CostoReposicion
                FROM ArtSubCostoSucursal
  INSERT CorteExistencia (Fecha,  Empresa,   Articulo,   SubCuenta,                                  Sucursal,     Almacen,   Existencia)
                   SELECT @Fecha, e.Empresa, e.Articulo, ISNULL(NULLIF(RTRIM(e.SubCuenta), ''), ''), Alm.Sucursal, e.Almacen, e.Existencia
                     FROM ArtSubExistenciaConsig e, Alm
                    WHERE e.Almacen = Alm.Almacen
  RETURN
END
GO
 
/**************** spCtaSituacionLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCtaSituacionLote') and type = 'P') drop procedure dbo.spCtaSituacionLote
GO             
CREATE PROCEDURE spCtaSituacionLote
                    @Estacion	int,
		    @Empresa	char(5),
		    @Rama	char(5),
		    @Situacion	varchar(50)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mensaje	varchar(255)

  IF @Rama = 'RH' UPDATE Personal SET Situacion = @Situacion FROM Personal p, CtaLote l WHERE l.Estacion = @Estacion AND p.Personal = l.Cuenta
  SELECT @Mensaje = LTRIM(CONVERT(char, @@ROWCOUNT))+' Cuentas Afectadas.'
  SELECT @Mensaje
  RETURN
END
GO


-- spCxcVoucherAfectar 3
/**************** spCxcVoucherAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxcVoucherAfectar') and type = 'P') drop procedure dbo.spCxcVoucherAfectar
GO             
CREATE PROCEDURE spCxcVoucherAfectar
		    @ID		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @Usuario		char(10),
    @Cliente		char(10),
    @Mov		varchar(20),
    @CxcMov		varchar(20),
    @CxcMovID		varchar(20),
    @FechaEmision	datetime,
    @IDAplica		int,
    @Aplica		varchar(20),
    @AplicaID		varchar(20),
    @AplicaImporte	money,
    @AplicaImpuestos	money,
    @Referencia		varchar(50),
    @Concepto		varchar(50),
    @Cargo		money,
    @Abono		money,
    @ImporteTotal	money,
    @Importe		money,
    @Renglon		float,
    @Impuesto		float,
    @EnviarA		int,
    @Nuevo		bit,
    @Aceptar		bit,
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255),
    @MovNCredito	varchar(20),
    @MovNCargo		varchar(20),
    @EsReferencia	bit,
    @EsCredito		bit,
    @FechaRegistro	datetime

  SELECT @Ok = NULL, @OkRef = NULL, @FechaRegistro = GETDATE()
  SELECT @FechaEmision = FechaEmision, @Empresa = Empresa, @Usuario = Usuario, @ImporteTotal = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0),
         @CxcMov = Mov, @CxcMovID = MovID
    FROM Cxc 
   WHERE ID = @ID
  SELECT @MovNCredito = CxcNCreditoVoucher,
         @MovNCargo   = CxcNCargoVoucher
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  BEGIN TRANSACTION

  EXEC xpCxcVoucherAfectar @ID, @Ok OUTPUT, @OkRef OUTPUT
  IF @CxcMovID IS NULL AND @Ok IS NULL
  BEGIN
    EXEC spCx @ID, 'CXC', 'CONSECUTIVO', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
              @CxcMov OUTPUT, @CxcMovID OUTPUT, NULL, 
              @Ok OUTPUT, @OkRef OUTPUT
    IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL
  END 

  UPDATE Cxc SET AplicaManual = 1 WHERE ID = @ID
  DELETE CxcD WHERE ID = @ID

  SELECT @Renglon = 0.0
  DECLARE crCxcVoucher CURSOR FOR
   SELECT Mov, NULLIF(RTRIM(Referencia), ''), NULLIF(RTRIM(Concepto), ''), NULLIF(EnviarA, 0), ISNULL(Cargo, 0.0), ISNULL(Abono, 0.0), ISNULL(Nuevo, 0), ISNULL(Aceptar, 0)
     FROM CxcVoucher
    WHERE ID = @ID
  OPEN crCxcVoucher
  FETCH NEXT FROM crCxcVoucher INTO @Mov, @Referencia, @Concepto, @EnviarA, @Cargo, @Abono, @Nuevo, @Aceptar
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Importe = @Cargo - @Abono,
             @EsReferencia = 0,
             @EsCredito = 0
      IF @Importe <> 0.0
      BEGIN
        IF @Nuevo = 1
        BEGIN
          EXEC spCteImpuesto @Empresa, @Cliente, @EnviarA, @Impuesto OUTPUT
          IF @Importe < 0.0 SELECT @EsCredito = 1
          IF @Aceptar = 1
            SELECT @Aplica = @Mov
          ELSE BEGIN
            SELECT @EsCredito = ~@EsCredito
            SELECT @Aplica = NULL
            SELECT @Aplica = NULLIF(RTRIM(MovGenerar), '') FROM EmpresaCfgCxcVoucher WHERE Empresa = @Empresa AND Mov = @Mov
            IF @Aplica IS NULL
              IF @EsCredito = 1 SELECT @Aplica = @MovNCredito ELSE SELECT @Aplica = @MovNCargo
          END
  
          SELECT @AplicaImporte = ABS(@Importe) / (1+(@Impuesto/100.0))
          SELECT @AplicaImpuestos = ABS(@Importe) - @AplicaImporte
          INSERT Cxc (
                 Sucursal, Empresa, Mov,     FechaEmision, Proyecto, Moneda,         TipoCambio,       Usuario, Referencia,  Estatus,      Concepto,  Cliente, ClienteEnviarA,                   ClienteMoneda, ClienteTipoCambio,  Condicion, Vencimiento,  Importe,        Impuestos,        AplicaManual, OrigenTipo, Origen, OrigenID)
          SELECT Sucursal, Empresa, @Aplica, FechaEmision, Proyecto, ClienteMoneda, ClienteTipoCambio, Usuario, @Referencia, 'SINAFECTAR', @Concepto, Cliente, ISNULL(@EnviarA, ClienteEnviarA), ClienteMoneda, ClienteTipoCambio, '(Fecha)',  FechaEmision, @AplicaImporte, @AplicaImpuestos, 0,            'CXC',      Mov,    MovID
            FROM Cxc
           WHERE ID = @ID
          SELECT @IDAplica = SCOPE_IDENTITY()
          UPDATE CxcVoucher SET IDAplica = @IDAplica WHERE CURRENT OF crCxcVoucher

          EXEC spCx @IDAplica, 'CXC', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, 
                    @Aplica OUTPUT, @AplicaID OUTPUT, NULL, 
                    @Ok OUTPUT, @OkRef OUTPUT

          -- Unicamente en Movimientos Nuevos se puede no Aceptar 
          IF @Aceptar = 0 SELECT @EsReferencia = 1
        END ELSE
          SELECT @Aplica = @Mov, @AplicaID = @Referencia 

        SELECT @Renglon = @Renglon + 2048.0
        INSERT CxcD 
               (ID,  Renglon,  Aplica,  AplicaID,  Importe,  EsReferencia)
        VALUES (@ID, @Renglon, @Aplica, @AplicaID, @Importe, @EsReferencia)
      END
    END
    FETCH NEXT FROM crCxcVoucher INTO @Mov, @Referencia, @Concepto, @EnviarA, @Cargo, @Abono, @Nuevo, @Aceptar
  END
  CLOSE crCxcVoucher
  DEALLOCATE crCxcVoucher

  IF @Ok IS NULL
  BEGIN
    EXEC spCx @ID, 'CXC', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
              @CxcMov OUTPUT, @CxcMovID OUTPUT, NULL, 
              @Ok OUTPUT, @OkRef OUTPUT
    IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
  END

  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  IF @Ok IS NULL 
    SELECT @Mensaje = 'Voucher Afectado con Exito.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO


/**************** spCxcVoucherCancelar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCxcVoucherCancelar') and type = 'P') drop procedure dbo.spCxcVoucherCancelar
GO             
CREATE PROCEDURE spCxcVoucherCancelar
		    	@ID		int,
			@Usuario	char(10),
		    	@FechaRegistro	datetime,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @IDAplica	int,
    @Aplica	char(20),
    @AplicaID	varchar(20)

  DECLARE crCxcVoucher CURSOR FOR
   SELECT c.ID, c.Mov, c.MovID
     FROM CxcVoucher v, Cxc c
    WHERE v.ID = @ID AND c.ID = v.IDAplica AND c.Estatus IN ('PENDIENTE', 'CONCLUIDO')
  OPEN crCxcVoucher
  FETCH NEXT FROM crCxcVoucher INTO @IDAplica, @Aplica, @AplicaID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spCx @IDAplica, 'CXC', 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                @Aplica, @AplicaID, NULL, 
                @Ok OUTPUT, @OkRef OUTPUT
    END
    FETCH NEXT FROM crCxcVoucher INTO @IDAplica, @Aplica, @AplicaID
  END
  CLOSE crCxcVoucher
  DEALLOCATE crCxcVoucher
  RETURN
END
GO

/**************** spDesReservarOrdenes ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDesReservarOrdenes') and type = 'P') drop procedure dbo.spDesReservarOrdenes
GO             
CREATE PROCEDURE spDesReservarOrdenes
			@Empresa	char(5),
			@Usuario	char(10),
			@Modulo		char(5),
		 	@Almacen	char(10) 	= NULL,
		 	@Articulo	char(20) 	= NULL,
			@Categoria	varchar(50) 	= NULL,
			@Grupo		varchar(50) 	= NULL,
			@Familia	varchar(50) 	= NULL,
			@Fabricante	varchar(50) 	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255),
    @Conteo		int,
    @FechaRegistro	datetime

  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0, @ID = NULL, 
         @FechaRegistro = GETDATE(), 
         @Almacen = NULLIF(NULLIF(NULLIF(RTRIM(@Almacen), ''), '(TODOS)'), '0'),
         @Articulo = NULLIF(NULLIF(NULLIF(RTRIM(@Articulo), ''), '(TODOS)'), '0'),
         @Categoria = NULLIF(NULLIF(NULLIF(RTRIM(@Categoria), ''), '(TODOS)'), '0'),
         @Grupo = NULLIF(NULLIF(NULLIF(RTRIM(@Grupo), ''), '(TODOS)'), '0'),
         @Familia = NULLIF(NULLIF(NULLIF(RTRIM(@Familia), ''), '(TODOS)'), '0'),
         @Fabricante = NULLIF(NULLIF(NULLIF(RTRIM(@Fabricante), ''), '(TODOS)'), '0')

  IF @Modulo = 'INV'
    DECLARE crOrdenes CURSOR FOR
     SELECT DISTINCT i.ID
       FROM Inv i, InvD d, Art a 
      WHERE i.ID = d.ID AND i.Empresa = @Empresa AND i.Estatus = 'PENDIENTE'
        AND ISNULL(CantidadReservada, 0) > 0
        AND i.AlmacenDestino = ISNULL(@Almacen, i.AlmacenDestino)
        AND d.Articulo = a.Articulo
        AND ISNULL(a.Articulo, '') = ISNULL(ISNULL(@Articulo, a.Articulo), '')
        AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria), '')
        AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '')
        AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '')
        AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '')
  IF @Modulo = 'VTAS'
    DECLARE crOrdenes CURSOR FOR
     SELECT DISTINCT v.ID
       FROM Venta v, VentaD d, Art a 
      WHERE v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus = 'PENDIENTE'
        AND ISNULL(CantidadReservada, 0) > 0
        AND v.Almacen = ISNULL(@Almacen, v.Almacen)
        AND d.Articulo = a.Articulo
        AND ISNULL(a.Articulo, '') = ISNULL(ISNULL(@Articulo, a.Articulo), '')
        AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria), '')
        AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '')
        AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '')
        AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '')

  OPEN crOrdenes
  FETCH NEXT FROM crOrdenes INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      IF @Modulo = 'INV'
      BEGIN
        UPDATE InvD SET CantidadA = NULL WHERE ID = @ID
        UPDATE InvD SET CantidadA = CantidadReservada WHERE ID = @ID 
      END ELSE
      IF @Modulo = 'VTAS'
      BEGIN
        UPDATE VentaD SET CantidadA = NULL WHERE ID = @ID
        UPDATE VentaD SET CantidadA = CantidadReservada WHERE ID = @ID 
      END 

      EXEC spInv @ID, @Modulo, 'DESRESERVAR', 'SELECCION', @FechaRegistro, NULL, @Usuario, 0, 0, NULL,
                 NULL, NULL, NULL, NULL,
                 @Ok OUTPUT, @OkRef OUTPUT, NULL
      IF @Ok IS NULL SELECT @Conteo = @Conteo + 1 
    END
    FETCH NEXT FROM crOrdenes INTO @ID
  END  -- While	
  CLOSE crOrdenes
  DEALLOCATE crOrdenes

  IF @Ok IS NULL 
    SELECT @Mensaje = LTRIM(CONVERT(char, @Conteo))+' Movimientos Desreservados.'
  ELSE
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

/**************** spDocAuto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDocAuto') and type = 'P') drop procedure dbo.spDocAuto
GO             
CREATE PROCEDURE spDocAuto
		    @ID				int,
		    @InteresesMov	char(20),
            @DocMov			char(20),
            @Usuario		char(10) = NULL,
		    @Conexion		bit      = 0,
		    @SincroFinal	bit      = 0,
    		@Ok				int	 	= NULL OUTPUT,
    		@OkRef			varchar(255)	= NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal			int,
    @a				int,
    @Empresa			char(5),
    @Modulo			char(5),
    @Cuenta			char(10),
    @Moneda			char(10),
    @Mov			char(20),
    @MovID			varchar(20), 
    @MovTipo			char(20),
    @MovAplicaImporte		money,
    @Condicion			varchar(50),
    @Importe			money,
    @Impuestos			money,
    @ImporteDocumentar		money,
    @ImporteTotal		money,
    @Intereses          	money,
    @InteresesImpuestos 	money,
    @InteresesConcepto		varchar(50),
    @InteresesAplicaImporte	money,
    @NumeroDocumentos		int,
    @PrimerVencimiento		datetime,
    @Periodo			varchar(15),
    @Concepto			varchar(50),
    @Observaciones		varchar(100),
    @Estatus			char(15),
    @DocEstatus			char(15),
    @FechaEmision		datetime,
    @FechaRegistro		datetime,
    @MovUsuario			char(10),
    @Proyecto			varchar(50),
    @Referencia			varchar(50),
    @TipoCambio			float,
    @Saldo			money,
    @InteresesID		int,
    @InteresesMovID		varchar(20),
    @DocID			int,
    @DocMovID			varchar(20),
    @DocImporte			money,
    @SumaImporte1		money,
    @SumaImporte2		money,
    @SumaImporte3		money,
    @DocAutoFolio		char(20),
    @Importe1			money,
    @Importe2			money,
    @Importe3			money,
    @Dif			money,
    @Vencimiento		datetime,
    @Dia			int,
    @EsQuince			bit,
    @ImpPrimerDoc		bit,
    @Mensaje			varchar(255),
    @PPFechaEmision		datetime,
    @PPVencimiento 		datetime, 
    @PPDias 			int, 
    @PPFechaProntoPago 		datetime, 
    @PPDescuentoProntoPago	float,
    @ClienteEnviarA		int,
    @Cobrador			varchar(50),	
    @PersonalCobrador		char(10),
    @Agente			char(10),
    @DesglosarImpuestos		bit,
    @AplicaImpuestos		money,	
    @RedondeoMonetarios		int,
    @Tasa			varchar(50),
    @RamaID			int,
    @InteresPorcentaje		float,
    @PagoMensual		money,
    @CapitalAnterior		money,
    @CapitalInsoluto		money,
    @CfgDocAutoBorrador		bit,
	@Retencion1				float,
    @Retencion2				float,
    @Retencion3				float,    
    @FactorAplica			float,
    @aplicaRetenciones		float

  SELECT @RedondeoMonetarios = RedondeoMonetarios FROM Version 
  -- Inicializar Variables
  SELECT @EsQuince = 0, @Saldo = 0.0, @Proyecto = NULL, @FechaRegistro = GETDATE(), @SumaImporte1 = 0.0, @SumaImporte2 = 0.0, @SumaImporte3 = 0.0, @DesglosarImpuestos = 0

  -- Leer DocAuto
  SELECT @Sucursal = Sucursal, @Empresa = Empresa, @Modulo = Modulo, @Cuenta = Cuenta, @Moneda = Moneda, @Mov = Mov, @MovID = MovID, @ImporteDocumentar = ImporteDocumentar, 
         @Intereses = ISNULL(Intereses, 0.0), @InteresesImpuestos = ISNULL(InteresesImpuestos, 0.0), @InteresesConcepto = InteresesConcepto,
         @NumeroDocumentos = NumeroDocumentos, @PrimerVencimiento = PrimerVencimiento, @Periodo = UPPER(Periodo), 
         @Concepto = Concepto, @Observaciones = Observaciones, @Estatus = Estatus, @FechaEmision = FechaEmision, @MovUsuario = Usuario,
         @ImpPrimerDoc = ImpPrimerDoc, @Condicion = Condicion, @InteresPorcentaje = NULLIF(Interes/100, 0)
    FROM DocAuto
   WHERE ID = @ID

  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov

  SELECT @PPFechaEmision = @FechaEmision,
         @DocMov = NULLIF(NULLIF(RTRIM(@DocMov), ''), '0')

  IF @DocMov IS NULL SELECT @Ok = 10160

  SELECT @CfgDocAutoBorrador = ISNULL(CASE @Modulo WHEN 'CXC' THEN CxcDocAutoBorrador ELSE CxpDocAutoBorrador END, 0)
    FROM EmpresaCfg2
     WHERE Empresa = @Empresa

  IF @CfgDocAutoBorrador = 1 SELECT @DocEstatus = 'BORRADOR' ELSE SELECT @DocEstatus = 'SINAFECTAR'

  IF @MovTipo IN ('CXC.A', 'CXC.AR', 'CXC.DA', 'CXC.NC', 'CXC.DAC', 'CXP.A', 'CXP.DA', 'CXP.NC', 'CXP.DAC') 
  BEGIN
    SELECT @Intereses = 0.0, @InteresesImpuestos = 0.0
    SELECT @DocAutoFolio = CASE @Modulo WHEN 'CXC' THEN NULLIF(RTRIM(CxcDocAnticipoAutoFolio), '') WHEN 'CXP' THEN NULLIF(RTRIM(CxpDocAnticipoAutoFolio), '') ELSE NULL END
      FROM EmpresaCfg
     WHERE Empresa = @Empresa
  END ELSE 
    SELECT @DocAutoFolio = CASE @Modulo WHEN 'CXC' THEN NULLIF(RTRIM(CxcDocAutoFolio), '') WHEN 'CXP' THEN NULLIF(RTRIM(CxpDocAutoFolio), '') ELSE NULL END
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

  IF @Modulo = 'CXC'
    SELECT @DesglosarImpuestos = ISNULL(CxcCobroImpuestos, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa

  IF @Estatus = 'SINAFECTAR' AND @NumeroDocumentos > 0
  BEGIN
    IF @Modulo = 'CXC' SELECT @RamaID = ID, @Importe = ISNULL(Importe, 0.0), @Impuestos = ISNULL(Impuestos, 0.0), @Retencion1 = Retencion, @Retencion2 = retencion2, @Retencion3 = Retencion3, @Saldo = ISNULL(Saldo, 0.0), @Proyecto = Proyecto, @ClienteEnviarA = ClienteEnviarA, @Agente = Agente, @Cobrador = Cobrador, @PersonalCobrador = PersonalCobrador FROM Cxc WHERE Empresa = @Empresa AND Cliente = @Cuenta AND Mov = @Mov AND MovID = @MovID AND Estatus = 'PENDIENTE' ELSE
    IF @Modulo = 'CXP' SELECT @RamaID = ID, @Importe = ISNULL(Importe, 0.0), @Impuestos = ISNULL(Impuestos, 0.0), @Retencion1 = Retencion, @Retencion2 = retencion2, @Retencion3 = Retencion3, @Saldo = ISNULL(Saldo, 0.0), @Proyecto = Proyecto FROM Cxp WHERE Empresa = @Empresa AND Proveedor = @Cuenta AND Mov = @Mov AND MovID = @MovID AND Estatus = 'PENDIENTE'

    SELECT @ImporteTotal = @ImporteDocumentar + @Intereses + @InteresesImpuestos

    IF @Saldo < @ImporteDocumentar SELECT @Ok = 35190
    IF @Ok IS NULL
    BEGIN
      IF @Conexion = 0 BEGIN TRANSACTION
        IF @Intereses > 0.0 
        BEGIN
          SELECT @Referencia = RTRIM(@Mov)+' '+LTRIM(CONVERT(char, @MovID))
          IF @Modulo = 'CXC'
          BEGIN
            -- 6024
            INSERT Cxc (Sucursal, OrigenTipo, Origen, OrigenID, Empresa, Mov, FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Observaciones, Estatus,
                        Cliente, ClienteMoneda, ClienteTipoCambio, Importe, Impuestos,
                        ClienteEnviarA, Agente, Cobrador, PersonalCobrador, Tasa, RamaID, NoAutoAjustar)
                VALUES (@Sucursal, @Modulo, @Mov, @MovID, @Empresa, @InteresesMov, @FechaEmision, @InteresesConcepto, @Proyecto, @Moneda, @TipoCambio, @Usuario, @Referencia, @Observaciones, @DocEstatus,
                        @Cuenta, @Moneda,       @TipoCambio,       @Intereses, @InteresesImpuestos,
                        @ClienteEnviarA, @Agente, @Cobrador, @PersonalCobrador, @Tasa, @RamaID, 1)
            SELECT @InteresesID = SCOPE_IDENTITY()
          END ELSE
          IF @Modulo = 'CXP'
          BEGIN
            -- 6024
            INSERT Cxp (Sucursal, OrigenTipo, Origen, OrigenID, Empresa, Mov, FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Observaciones, Estatus,
                        Proveedor, ProveedorMoneda, ProveedorTipoCambio, Importe, Impuestos, Tasa, RamaID, NoAutoAjustar)
                VALUES (@Sucursal, @Modulo, @Mov, @MovID, @Empresa, @InteresesMov, @FechaEmision, @InteresesConcepto, @Proyecto, @Moneda, @TipoCambio, @Usuario, @Referencia, @Observaciones, @DocEstatus,
                        @Cuenta,   @Moneda,         @TipoCambio,    @Intereses, @InteresesImpuestos, @Tasa, @RamaID, 1)
            SELECT @InteresesID = SCOPE_IDENTITY()
          END 

          IF @CfgDocAutoBorrador = 0
            EXEC spCx @InteresesID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                      @InteresesMov OUTPUT, @InteresesMovID OUTPUT, NULL, 
                      @Ok OUTPUT, @OkRef OUTPUT
        END ELSE SELECT @InteresesImpuestos = 0.0

        IF @Periodo = 'QUINCENAL' 
        BEGIN
          SELECT @Dia = DATEPART(dd, @PrimerVencimiento)
          IF @Dia <= 15 
            SELECT @EsQuince = 1, @PrimerVencimiento = DATEADD(dd, 15-@Dia, @PrimerVencimiento)
          ELSE 
            SELECT @EsQuince = 0, @PrimerVencimiento = DATEADD(dd, -DATEPART(dd, @PrimerVencimiento), DATEADD(mm, 1, @PrimerVencimiento))
        END

        IF @ImpPrimerDoc = 1 AND @ImporteDocumentar = @Importe + @Impuestos
          SELECT @ImporteDocumentar = @Importe

        SELECT @a = 1, 
               @MovAplicaImporte       = ROUND(@ImporteDocumentar / @NumeroDocumentos, @RedondeoMonetarios),
               @InteresesAplicaImporte = ROUND((@Intereses + @InteresesImpuestos) / @NumeroDocumentos, @RedondeoMonetarios),
               @Vencimiento            = @PrimerVencimiento
        SELECT @PagoMensual = @MovAplicaImporte + ISNULL(@InteresesAplicaImporte, 0)

	IF @ImpPrimerDoc = 1 
          SELECT @DocImporte = @MovAplicaImporte 
        ELSE SELECT @DocImporte = @MovAplicaImporte + @InteresesAplicaImporte

        SELECT @CapitalAnterior = @ImporteDocumentar
        WHILE (@a <= @NumeroDocumentos) AND @Ok IS NULL
        BEGIN
          SELECT @Importe1 = 0.0, @Importe2 = 0.0, @Importe3 = 0.0 
          IF @ImpPrimerDoc = 1 AND @a = 1 
          BEGIN
            SELECT @Importe1 = @DocImporte + @Impuestos + @Intereses + @InteresesImpuestos,
                   @Importe2 = @DocImporte + @Impuestos,
                   @Importe3 = @Intereses + @InteresesImpuestos
          END ELSE 
          BEGIN
            SELECT @Importe1 = @DocImporte, @Importe2 = @MovAplicaImporte
            IF @ImpPrimerDoc = 1 
              SELECT @Importe3 = 0.0 
            ELSE BEGIN
              SELECT @Importe3 = @InteresesAplicaImporte
              IF @InteresPorcentaje IS NOT NULL
              BEGIN
                SELECT @CapitalInsoluto = (@ImporteDocumentar * POWER(1+@InteresPorcentaje, @a)) - (@PagoMensual * ((POWER(1+@InteresPorcentaje, @a)-1)/@InteresPorcentaje))
                SELECT @Importe2 = @CapitalAnterior - @CapitalInsoluto
                SELECT @Importe3 = @MovAplicaImporte + @InteresesAplicaImporte - @Importe2
                SELECT @CapitalAnterior = @CapitalInsoluto
              END
            END            
          END
          SELECT @SumaImporte1 = @SumaImporte1 + @Importe1,
                 @SumaImporte2 = @SumaImporte2 + @Importe2,
                 @SumaImporte3 = @SumaImporte3 + @Importe3

          IF @a = @NumeroDocumentos 
          BEGIN 
            SELECT @Dif = @SumaImporte2 - @ImporteDocumentar
            IF @Dif <> 0.0
              SELECT @Importe1 = @Importe1 - @Dif, @Importe2 = @Importe2 - @Dif

            SELECT @Dif = @SumaImporte3 - (@Intereses + @InteresesImpuestos)
            IF @Dif <> 0.0
              SELECT @Importe1 = @Importe1 - @Dif, @Importe3 = @Importe3 - @Dif
          END

          SELECT @Referencia = RTRIM(@Mov)+' '+LTRIM(CONVERT(char, @MovID))+' ('+LTRIM(CONVERT(char, @a))+'/'+LTRIM(CONVERT(char, @NumeroDocumentos))+')'
          IF @Mov = @DocAutoFolio SELECT @DocMovID = RTRIM(@MovID)+'-'+LTRIM(CONVERT(char, @a)) ELSE SELECT @DocMovID = NULL

          EXEC spCalcularVencimientoPP @Modulo, @Empresa, @Cuenta, @Condicion, @PPFechaEmision, @PPVencimiento OUTPUT, @PPDias OUTPUT, @PPFechaProntoPago OUTPUT, @PPDescuentoProntoPago OUTPUT, @Tasa OUTPUT, @Ok OUTPUT

          IF @Modulo = 'CXC'
          BEGIN
            INSERT Cxc (Sucursal, OrigenTipo, Origen, OrigenID, Empresa, Mov, MovID,     FechaEmision,  Concepto,  Proyecto,  Moneda,  TipoCambio,  Usuario,  Referencia,  Observaciones,  Estatus,
                        Cliente, ClienteMoneda, ClienteTipoCambio, Importe,     Condicion, Vencimiento, AplicaManual, FechaProntoPago, DescuentoProntoPago,
			ClienteEnviarA, Agente, Cobrador, PersonalCobrador, Tasa, RamaID)
                VALUES (@Sucursal, @Modulo, @Mov, @MovID, @Empresa, @DocMov, @DocMovID, @FechaEmision, @Concepto, @Proyecto, @Moneda, @TipoCambio, @Usuario, @Referencia, @Observaciones, @DocEstatus,
                        @Cuenta, @Moneda,       @TipoCambio, @Importe1, '(Fecha)', @Vencimiento, 1, @PPFechaProntoPago, @PPDescuentoProntoPago,
			@ClienteEnviarA, @Agente, @Cobrador, @PersonalCobrador, @Tasa, @RamaID)
            SELECT @DocID = SCOPE_IDENTITY()

	    IF @Importe2 > 0.0 
              INSERT CxcD (Sucursal, ID,     Renglon, Aplica, AplicaID, Importe)
                   VALUES (@Sucursal, @DocID, 2048,    @Mov,   @MovID,   @Importe2)

	    IF @Importe3 > 0.0 
              INSERT CxcD (Sucursal, ID,     Renglon, Aplica,        AplicaID,        Importe)
                   VALUES (@Sucursal, @DocID, 4096,    @InteresesMov, @InteresesMovID, @Importe3)

            IF @DesglosarImpuestos = 1
            BEGIN
              SELECT @FactorAplica = @MovAplicaImporte / (ISNULL(@Importe,0) + ISNULL(@Impuestos,0) - ISNULL(@Retencion1,0) - ISNULL(@Retencion2,0) - ISNULL(@Retencion3,0))
              SELECT @AplicaRetenciones = ISNULL(@FactorAplica,0) * (ISNULL(@Retencion1,0) + ISNULL(@Retencion2,0) + ISNULL(@Retencion3,0))

              SELECT @AplicaImpuestos = @FactorAplica*@Impuestos--NULLIF(SUM(d.Importe*c.IVAFiscal*ISNULL(c.IEPSFiscal, 1)), 0)
                FROM CxcD d, Cxc c
               WHERE d.ID = @DocID AND c.Empresa = @Empresa AND c.Mov = d.Aplica AND c.MovID = d.AplicaID AND c.Estatus = 'PENDIENTE'
              IF @AplicaImpuestos IS NOT NULL
                UPDATE Cxc SET Importe = Importe - @AplicaImpuestos + @AplicaRetenciones, Impuestos = @AplicaImpuestos, Retencion = @Retencion1*@FactorAplica, REtencion2 = @Retencion2 * @FactorAplica, Retencion3 = @Retencion3*@FactorAplica WHERE ID = @DocID
            END

          END ELSE
          IF @Modulo = 'CXP'
          BEGIN
            INSERT Cxp (Sucursal, OrigenTipo, Origen, OrigenID, Empresa, Mov, MovID, FechaEmision,  Concepto,  Proyecto,  Moneda,  TipoCambio,  Usuario,  Referencia,  Observaciones,  Estatus,
                        Proveedor, ProveedorMoneda, ProveedorTipoCambio, Importe,     Condicion, Vencimiento, AplicaManual, FechaProntoPago, DescuentoProntoPago, Tasa, RamaID)
                VALUES (@Sucursal, @Modulo, @Mov, @MovID, @Empresa, @DocMov, @DocMovID, @FechaEmision, @Concepto, @Proyecto, @Moneda, @TipoCambio, @Usuario, @Referencia, @Observaciones, @DocEstatus,
                        @Cuenta,   @Moneda,         @TipoCambio,         @Importe1, '(Fecha)', @Vencimiento, 1, @PPFechaProntoPago, @PPDescuentoProntoPago, @Tasa, @RamaID)
            SELECT @DocID = SCOPE_IDENTITY()

	    IF @Importe2 > 0.0 
              INSERT CxpD (Sucursal, ID,     Renglon, Aplica, AplicaID, Importe)
                   VALUES (@Sucursal, @DocID, 2048,    @Mov,   @MovID,   @Importe2)

	    IF @Importe3 > 0.0 
              INSERT CxpD (Sucursal, ID,     Renglon, Aplica,        AplicaID,        Importe)
                   VALUES (@Sucursal, @DocID, 4096,    @InteresesMov, @InteresesMovID, @Importe3)
          END 
          --IF @a <> @NumeroDocumentos  
          IF @CfgDocAutoBorrador = 0
            EXEC spCx @DocID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                      @DocMov OUTPUT, @DocMovID OUTPUT, NULL, 
                      @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL
          BEGIN
            SELECT @PPFechaEmision = DATEADD(day, 1, @Vencimiento)
            IF dbo.fnEsNumerico(@Periodo) = 1 SELECT @Vencimiento = DATEADD(day,   CONVERT(int, @Periodo)*@a, @PrimerVencimiento) ELSE
            IF @Periodo = 'SEMANAL'    SELECT @Vencimiento = DATEADD(wk, @a,    @PrimerVencimiento) ELSE
            IF @Periodo = 'MENSUAL'    SELECT @Vencimiento = DATEADD(mm, @a,    @PrimerVencimiento) ELSE
            IF @Periodo = 'BIMESTRAL'  SELECT @Vencimiento = DATEADD(mm, @a*2,  @PrimerVencimiento) ELSE
            IF @Periodo = 'TRIMESTRAL' SELECT @Vencimiento = DATEADD(mm, @a*3,  @PrimerVencimiento) ELSE
            IF @Periodo = 'SEMESTRAL'  SELECT @Vencimiento = DATEADD(mm, @a*6,  @PrimerVencimiento) ELSE
            IF @Periodo = 'ANUAL'      SELECT @Vencimiento = DATEADD(yy, @a,    @PrimerVencimiento) ELSE
            IF @Periodo = 'QUINCENAL' 
            BEGIN
              IF @EsQuince = 1 
                SELECT @EsQuince = 0, @Vencimiento = DATEADD(dd, -15, DATEADD(mm, 1, @Vencimiento)) 
              ELSE 
                SELECT @EsQuince = 1, @Vencimiento = DATEADD(dd, 15, @Vencimiento)
            END ELSE SELECT @Ok = 55140
            
            SELECT @a = @a + 1
          END
        END -- while

      IF @Conexion = 0
      BEGIN
        IF @Ok IS NULL
          COMMIT TRANSACTION
        ELSE
          ROLLBACK TRANSACTION
      END
    END
  END ELSE SELECT @Ok = 60040

  IF @Ok IS NULL 
    SELECT @Mensaje = "Proceso Concluido."
  ELSE BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok  
    IF @OkRef IS NOT NULL SELECT @Mensaje = RTRIM(@Mensaje)+'<BR><BR>'+@OkRef
  END
  IF @Conexion = 0
    SELECT @Mensaje

  RETURN
END
GO

/**************** spEspacioConsumo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEspacioConsumo') and type = 'P') drop procedure dbo.spEspacioConsumo
GO             
CREATE PROCEDURE spEspacioConsumo
			@Ejercicio	int,
			@Periodo	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Total	money

  CREATE TABLE #EspacioConsumo (
	Espacio		char(10)	COLLATE Database_Default NULL,
	Importe		money		NULL
  )

  DELETE EspacioConsumo WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo

  INSERT #EspacioConsumo (Espacio, Importe)
  SELECT d.Espacio, SUM(CASE WHEN mt.Clave = 'INV.E' THEN -d.Cantidad ELSE d.Cantidad END*d.Costo*i.TipoCambio)
    FROM Inv i, InvD d, MovTipo mt 
   WHERE i.Estatus = 'CONCLUIDO' 
     AND NULLIF(RTRIM(d.Espacio), '') IS NOT NULL
     AND YEAR(i.FechaEmision) = @Ejercicio AND MONTH(i.FechaEmision) = @Periodo
     AND i.ID = d.ID AND mt.Modulo = 'INV' AND mt.Mov = i.Mov AND mt.Clave IN ('INV.E', 'INV.S')
   GROUP BY d.Espacio 
   ORDER BY d.Espacio 

  INSERT #EspacioConsumo (Espacio, Importe)
  SELECT NULLIF(RTRIM(v.Espacio), ''), SUM(mt.Factor*d.CostoTotal*v.TipoCambio)
    FROM Venta v, VentaTCalc d, Art a, MovTipo mt
   WHERE d.ID = v.ID AND d.Articulo = a.Articulo AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov
     AND v.Estatus = 'CONCLUIDO' AND mt.Clave IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.D', 'VTAS.DF', 'VTAS.DFC')
     AND YEAR(v.FechaEmision) = @Ejercicio AND MONTH(v.FechaEmision) = @Periodo
     AND UPPER(a.AutoRecaudacion) = 'CONSUMO'
   GROUP BY v.Espacio
   ORDER BY v.Espacio

  SELECT @Total = NULLIF(SUM(Importe), 0) FROM #EspacioConsumo
  INSERT EspacioConsumo (Espacio,                    Ejercicio,  Periodo,  Importe,      Porcentaje)
                  SELECT NULLIF(RTRIM(Espacio), ''), @Ejercicio, @Periodo, SUM(Importe), (SUM(Importe) / @Total) *100
                    FROM #EspacioConsumo
                   WHERE NULLIF(RTRIM(Espacio), '') IS NOT NULL
                   GROUP BY NULLIF(RTRIM(Espacio), '')
                   ORDER BY NULLIF(RTRIM(Espacio), '')
  RETURN
END
GO

/**************** spEspacioIngreso ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEspacioIngreso') and type = 'P') drop procedure dbo.spEspacioIngreso
GO             
CREATE PROCEDURE spEspacioIngreso
			@Ejercicio	int,
			@Periodo	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Total	money

  DELETE EspacioIngreso WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo

  INSERT EspacioIngreso (Espacio, Ejercicio, Periodo, Importe)
  SELECT NULLIF(RTRIM(v.Espacio), ''), @Ejercicio, @Periodo, SUM(mt.Factor*CASE WHEN UPPER(a.AutoRecaudacion) = 'INGRESO PRECIO' THEN d.SubTotal*v.TipoCambio WHEN UPPER(a.AutoRecaudacion) = 'INGRESO COSTO' THEN d.Costo*v.TipoCambio ELSE NULL END)
    FROM Venta v, VentaTCalc d, Art a, MovTipo mt
   WHERE d.ID = v.ID AND d.Articulo = a.Articulo AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov
     AND v.Estatus = 'CONCLUIDO' AND mt.Clave IN ('VTAS.F', 'VTAS.FAR', 'VTAS.D', 'VTAS.DF')
     AND YEAR(v.FechaEmision) = @Ejercicio AND MONTH(v.FechaEmision) = @Periodo
     AND UPPER(a.AutoRecaudacion) IN ('INGRESO PRECIO', 'INGRESO COSTO')
   GROUP BY v.Espacio
   ORDER BY v.Espacio

  SELECT @Total = NULLIF(SUM(Importe), 0) FROM EspacioIngreso WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo
  UPDATE EspacioIngreso SET Porcentaje = (Importe / @Total) * 100 WHERE Ejercicio = @Ejercicio AND Periodo = @Periodo
  RETURN
END
GO

-- spEspacioResultadoCerrar 2002, 12
/**************** spEspacioResultadoCerrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEspacioResultadoCerrar') and type = 'P') drop procedure dbo.spEspacioResultadoCerrar
GO             
CREATE PROCEDURE spEspacioResultadoCerrar
			@Ejercicio	int,
			@Periodo	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255),
    @ConceptoAmortizacionPerdida	varchar(50)

  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @ConceptoAmortizacionPerdida = AmortizacionPerdida
    FROM AutoCfg

  IF NOT EXISTS(SELECT * FROM Version WHERE AutoEjercicio = @Ejercicio AND AutoPeriodo = @Periodo)
    SELECT @Ok = 55165

  IF @Ok IS NULL
  BEGIN
    INSERT EspacioCierre (Espacio, Ejercicio, Periodo, SaldoAFavor)
    SELECT e.Espacio, @Ejercicio, @Periodo, ISNULL(r.Egreso, 0)
      FROM Espacio e, EspacioResultado r
     WHERE r.Espacio = e.Espacio AND r.Ejercicio = @Ejercicio AND r.Periodo = @Periodo AND r.Concepto = @ConceptoAmortizacionPerdida

    UPDATE Espacio
       SET SaldoAFavor = ISNULL(e.SaldoAFavor, 0) - c.SaldoAFavor
      FROM Espacio e, EspacioCierre c
     WHERE c.Espacio = e.Espacio AND c.Ejercicio = @Ejercicio AND c.Periodo = @Periodo
  END

  IF @Ok IS NULL 
  BEGIN
    SELECT @Mensaje = 'Ejercicio '+CONVERT(varchar, @Ejercicio)+', Periodo '+CONVERT(varchar, @Periodo)+' Cerrado.'
    EXEC spIncEjercicioPeriodo @Ejercicio OUTPUT, @Periodo OUTPUT
    UPDATE Version SET AutoEjercicio = @Ejercicio, AutoPeriodo = @Periodo
  END ELSE
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

/*
EXEC spExplotarPresupuesto 1, 'DEMO', '1/1/4', '1/1/5'
select * from ArtExplosion
*/

/**************** spExplotarPresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spExplotarPresupuesto') and type = 'P') drop procedure dbo.spExplotarPresupuesto
GO             
CREATE PROCEDURE spExplotarPresupuesto
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo	char(20),
    @Cantidad	float

  CREATE TABLE #ArtExplosion (Articulo char(20) COLLATE Database_Default, Explosionado bit NULL DEFAULT 0, Cantidad float NULL)

  INSERT #ArtExplosion (Articulo, Cantidad)
  SELECT d.Articulo, SUM(d.Cantidad)
    FROM Venta v
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.PR'
    JOIN VentaD d ON d.ID = v.ID
   WHERE v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND d.FechaRequerida BETWEEN @FechaD AND @FechaA
   GROUP BY d.Articulo

  WHILE EXISTS(SELECT * FROM #ArtExplosion WHERE Explosionado = 0)
  BEGIN
    DECLARE crExplosion CURSOR LOCAL FOR
     SELECT Articulo, Cantidad
       FROM #ArtExplosion
      WHERE Explosionado = 0

    OPEN crExplosion
    FETCH NEXT FROM crExplosion INTO @Articulo, @Cantidad
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        UPDATE #ArtExplosion SET Explosionado = 1 WHERE CURRENT OF crExplosion
        INSERT #ArtExplosion (Articulo, Cantidad)
        SELECT Material, Cantidad*@Cantidad
          FROM ArtMaterial
         WHERE Articulo = @Articulo
      END
      FETCH NEXT FROM crExplosion INTO @Articulo, @Cantidad
    END
    CLOSE crExplosion
    DEALLOCATE crExplosion
  END

  DELETE ArtExplosion WHERE Estacion = @Estacion
  INSERT ArtExplosion (Estacion, Articulo, Cantidad)
  SELECT @Estacion, Articulo, SUM(Cantidad)
    FROM #ArtExplosion
   GROUP BY Articulo

  RETURN
END
GO

-- spFacturacionRapida 349334, 'INT', 'MEX'
-- spFacturacionRapida 25777, 'DEMO', 'ASA'
-- spFacturacionRapida 30, 'DEMO', 'DEMO', 1
/**************** spFacturacionRapida ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFacturacionRapida') and type = 'P') drop procedure dbo.spFacturacionRapida
GO             
CREATE PROCEDURE spFacturacionRapida
			@ID		int,
			@Usuario	char(10),
			@Empresa	char(5),
			@FacturacionRapidaAgrupada bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FacturaMov			char(20),
    @FacturaMovID		varchar(20),
    @FacturaMovIDInicial	varchar(20),
    @FacturaMovIDFinal		varchar(20),
    @IDFactura			int,
    @Ok				int,
    @OkRef			varchar(255),
    @Mensaje			varchar(255),
    @FechaRegistro		datetime,
    @Conteo			int,
    @RenglonesCompletos		bit,
    @Salir			bit,
    @Base			char(20)

  SELECT @Ok = NULL, @OkRef = NULL, 
         @FacturaMovIDInicial = NULL, 
         @FacturaMovIDFinal = NULL, 
         @Conteo = 0, 
         @Salir = 0,
         @FechaRegistro = GETDATE(), 
         @Base = 'PENDIENTE'

  BEGIN TRANSACTION 

  EXEC xpFacturacionRapida @ID, @Usuario, @Empresa, @FacturacionRapidaAgrupada, @Base OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    SELECT @RenglonesCompletos = VentaRenCompletosFactRapida
      FROM EmpresaCfg2
     WHERE Empresa = @Empresa

    SELECT @FacturaMov = VentaFactura
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa

    IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID AND ISNULL(CantidadPendiente, 0.0) > 0.0)
      EXEC spInv @ID, 'VTAS', 'RESERVAR', @Base, @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                 NULL, NULL, NULL, NULL,
                 @Ok OUTPUT, @OkRef OUTPUT, NULL

    IF @Ok = 60010 SELECT @Ok = NULL
  END

  IF @RenglonesCompletos = 1 AND @Ok IS NULL
  BEGIN
    UPDATE VentaD SET CantidadA = NULL WHERE ID = @ID
    UPDATE VentaD
       SET CantidadA = NULLIF(CantidadReservada, 0)
     WHERE ID = @ID AND ISNULL(CantidadReservada, 0) <> 0 AND (ISNULL(CantidadPendiente, 0) <> 0 OR ISNULL(CantidadOrdenada, 0) <> 0)

    IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID AND NULLIF(CantidadA, 0) IS NOT NULL)
      EXEC spInv @ID, 'VTAS', 'DESRESERVAR', 'SELECCION', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                 NULL, NULL, NULL, NULL,
                 @Ok OUTPUT, @OkRef OUTPUT, NULL
  END

  WHILE @Ok IS NULL AND @Salir = 0 AND EXISTS(SELECT * FROM VentaD d, Art a WHERE d.Articulo = a.Articulo AND d.ID = @ID AND (ISNULL(d.CantidadReservada, 0) > 0 OR (ISNULL(d.CantidadPendiente, 0) > 0 AND a.Tipo IN ('SERVICIO', 'JUEGO'))))
  BEGIN
    UPDATE VentaD SET CantidadA = NULL WHERE ID = @ID
    UPDATE VentaD
       SET CantidadA = NULLIF(CantidadReservada, 0)
     WHERE ID = @ID AND ISNULL(CantidadReservada, 0) <> 0 

    UPDATE VentaD
       SET CantidadA = NULLIF(CantidadPendiente, 0)
      FROM VentaD d, Art a
     WHERE d.ID = @ID AND d.Articulo = a.Articulo AND UPPER(a.Tipo) IN ('SERVICIO', 'JUEGO') AND ISNULL(d.CantidadPendiente, 0) <> 0

    EXEC spInv @ID, 'VTAS', 'GENERAR', 'SELECCION', @FechaRegistro, @FacturaMov, @Usuario, 1, 0, NULL,
               NULL, NULL, @IDFactura OUTPUT, NULL,
               @Ok OUTPUT, @OkRef OUTPUT, NULL, @FacturacionRapidaAgrupada = @FacturacionRapidaAgrupada

    IF NOT EXISTS(SELECT * FROM VentaD WHERE ID = @IDFactura)
    BEGIN
      DELETE Venta WHERE ID = @IDFactura
      SELECT @Salir = 1
    END

    IF @Ok = 80030 AND @IDFactura IS NOT NULL AND @Salir = 0
    BEGIN
      SELECT @Ok = NULL, @OkRef = NULL

      EXEC spInv @IDFactura, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                 NULL, @FacturaMovID OUTPUT, NULL, NULL,
                 @Ok OUTPUT, @OkRef OUTPUT, NULL, @FacturacionRapidaAgrupada = @FacturacionRapidaAgrupada
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      IF @Ok IS NULL 
      BEGIN         
        SELECT @Conteo = @Conteo + 1
        IF @Conteo = 1 SELECT @FacturaMovIDInicial = @FacturaMovID
        SELECT @FacturaMovIDFinal = @FacturaMovID
      END
    END
  END

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = LTRIM(CONVERT(char, @Conteo))+' Facturas Realizadas.<BR><BR>De: '+RTRIM(@FacturaMov)+' '+RTRIM(@FacturaMovIDInicial)+'<BR>  A: '+RTRIM(@FacturaMov)+' '+RTRIM(@FacturaMovIDFinal)
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN 
END
GO

-- spFusionarCx 'DEMO', 'DEMO', 0, 'CXP', '1/1/3', 'SHCP', 'Documento'
/**************** spFusionarCx ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFusionarCx') and type = 'P') drop procedure dbo.spFusionarCx
GO             
CREATE PROCEDURE spFusionarCx
			@Empresa	char(5),
			@Usuario	char(10),
			@Sucursal	int,
			@Modulo		char(5),
			@FechaEmision	datetime,
			@Contacto	char(10),
			@CxMov		char(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Moneda		char(10),
    @TipoCambio		float,
    @Vencimiento	datetime,
    @Importe		money,
    @Mov		char(20),
    @MovID		varchar(20),
    @CxID		int,
    @Renglon		float,
    @Ok			int,
    @OkRef		varchar(255),
    @Conteo		int,
    @Mensaje		varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0
  CREATE TABLE #Aplica (
	Moneda		char(10) 	COLLATE Database_Default NULL,
	Contacto	char(10) 	COLLATE Database_Default NULL,
	Vencimiento	datetime	NULL,
	Mov		char(20)	COLLATE Database_Default NULL,
	MovID		varchar(20)	COLLATE Database_Default NULL,
	Importe		money		NULL,
	Renglon		float		NULL)

  IF @Modulo = 'CXC'
     INSERT #Aplica (Moneda, Contacto, Vencimiento, Mov, MovID, Importe)
     SELECT c.Moneda, c.Cliente, c.Vencimiento, c.Mov, c.MovID, c.Saldo
       FROM Cxc c, MovTipo mt
      WHERE c.Empresa = @Empresa AND c.Cliente = @Contacto AND c.Estatus = 'PENDIENTE' AND NULLIF(c.Saldo, 0) IS NOT NULL
        AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.F','CXC.FA','CXC.AF','CXC.CA','CXC.CAD','CXC.CAP','CXC.CD','CXC.D','CXC.DM','CXC.DA','CXC.IM','CXC.RM')
  IF @Modulo = 'CXP'
     INSERT #Aplica (Moneda, Contacto, Vencimiento, Mov, MovID, Importe)
     SELECT c.Moneda, c.Proveedor, c.Vencimiento, c.Mov, c.MovID, c.Saldo
       FROM Cxp c, MovTipo mt
      WHERE c.Empresa = @Empresa AND c.Proveedor = @Contacto AND c.Estatus = 'PENDIENTE' AND NULLIF(c.Saldo, 0) IS NOT NULL
        AND mt.Modulo = @Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('CXP.F','CXP.FA','CXP.AF','CXP.CA', 'CXP.CAD','CXP.CAP','CXP.CD','CXP.D','CXP.DM','CXP.DA')

  DECLARE crAplica CURSOR FOR
   SELECT Moneda, Contacto, Vencimiento, SUM(Importe)
     FROM #Aplica
    GROUP BY Moneda, Contacto, Vencimiento
   HAVING COUNT(*) > 1
    ORDER BY Moneda, Contacto, Vencimiento
  
  OPEN crAplica
  FETCH NEXT FROM crAplica INTO @Moneda, @Contacto, @Vencimiento, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @Renglon = 0.0
      UPDATE #Aplica 
         SET @Renglon = Renglon = ISNULL(Renglon, 0) + @Renglon + 2048.0 
       WHERE Moneda = @Moneda AND Contacto = @Contacto AND Vencimiento = @Vencimiento
      SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
      IF @Modulo = 'CXC'
      BEGIN
        INSERT Cxc (Sucursal, Empresa,  Mov,    FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      Cliente,   ClienteMoneda, ClienteTipoCambio, Importe,  Condicion, Vencimiento,  AplicaManual, PersonalCobrador)
            SELECT @Sucursal, @Empresa, @CxMov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Contacto, @Moneda,       @TipoCambio,       @Importe, '(Fecha)', @Vencimiento, 1,            c.PersonalCobrador
              FROM Cte c
             WHERE c.Cliente = @Contacto         
        SELECT @CxID = SCOPE_IDENTITY()
        INSERT CxcD (Sucursal,  ID,   Renglon, Aplica, AplicaID, Importe)
             SELECT @Sucursal, @CxID, Renglon, Mov,    MovID,    Importe
               FROM #Aplica
              WHERE Moneda = @Moneda AND Contacto = @Contacto AND Vencimiento = @Vencimiento
      END ELSE
      IF @Modulo = 'CXP'
      BEGIN
        INSERT Cxp (Sucursal,  Empresa,  Mov,    FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      Proveedor, ProveedorMoneda, ProveedorTipoCambio, Importe,  Condicion, Vencimiento,  AplicaManual)
            VALUES (@Sucursal, @Empresa, @CxMov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Contacto, @Moneda,         @TipoCambio,         @Importe, '(Fecha)', @Vencimiento, 1)
        SELECT @CxID = SCOPE_IDENTITY()
        INSERT CxpD (Sucursal,  ID,   Renglon, Aplica, AplicaID, Importe)
             SELECT @Sucursal, @CxID, Renglon, Mov,    MovID,    Importe
               FROM #Aplica
              WHERE Moneda = @Moneda AND Contacto = @Contacto AND Vencimiento = @Vencimiento
      END      
      EXEC spAfectar @Modulo, @CxID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok IS NULL SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crAplica INTO @Moneda, @Contacto, @Vencimiento, @Importe
  END
  CLOSE crAplica
  DEALLOCATE crAplica

  IF @Ok IS NULL 
    SELECT @Mensaje = LTRIM(CONVERT(char, @Conteo))+' Documentos Generados.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

/**************** spGenerarComisionesLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarComisionesLote') and type = 'P') drop procedure dbo.spGenerarComisionesLote
GO             
CREATE PROCEDURE spGenerarComisionesLote
			@Sucursal	int,
			@Empresa	char(5),
			@Usuario	char(10),
			@FechaCorte	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo		int,
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255),
    @FechaEmision	datetime,
    @FechaRegistro	datetime,
    @AgentMov		char(20),
    @AgentMovID		varchar(20),
    @AgentComision	char(20),
    @AgentDevolucion	char(20),
    @Referencia		varchar(50),
    @Observaciones	varchar(100),
    @ID			int,
    @Mov		char(20),
    @MovID		varchar(20),
    @MovTipo		varchar(20),
    @Moneda		char(10),
    @TipoCambio		float,
    @Agente		char(10),
    @Comision		money,
    @AgentID		int,
    @IDGenerar		int

  SELECT @Conteo = 0, @Ok = NULL, @OkRef = NULL, @FechaEmision = GETDATE(), @FechaRegistro = GETDATE()
  EXEC spExtraerFecha @FechaEmision OUTPUT
  EXEC spExtraerFecha @FechaCorte OUTPUT

  SELECT @AgentComision   = AgentComision,
	 @AgentDevolucion = AgentDevolucion
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  DECLARE crComisionLote CURSOR FOR
   SELECT c.ID, c.Mov, c.MovID, mt.Clave, c.Moneda, c.TipoCambio, NULLIF(RTRIM(c.Agente), ''), ISNULL(c.ComisionTotal, 0), '('+RTRIM(Cliente)+', '+CONVERT(varchar, (ISNULL(c.ComisionTotal, 0)/Importe)*100)+'%)'
     FROM Cxc c, MovTipo mt 
    WHERE c.Estatus = 'CONCLUIDO' AND c.ComisionCorte IS NULL AND c.FechaConclusion <= @FechaCorte
      AND mt.Modulo = 'CXC' AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.F', 'CXC.NC')
      AND c.Empresa = @Empresa AND NULLIF(RTRIM(c.Agente), '') IS NOT NULL

  OPEN crComisionLote
  FETCH NEXT FROM crComisionLote INTO @ID, @Mov, @MovID, @MovTipo, @Moneda, @TipoCambio, @Agente, @Comision, @Observaciones
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @Conteo = @Conteo + 1, @Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID)
      IF @MovTipo = 'CXC.NC' SELECT @AgentMov = @AgentDevolucion ELSE SELECT @AgentMov = @AgentComision
      INSERT Agent (Sucursal, Empresa,   Mov,       FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,     Agente,   Importe,   Observaciones,  Referencia,  OrigenTipo, Origen, OrigenID)
            VALUES (@Sucursal, @Empresa, @AgentMov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Agente, @Comision, @Observaciones, @Referencia, 'CXC',      @Mov,   @MovID)
      SELECT @AgentID = SCOPE_IDENTITY()
      EXEC spCx @AgentID, 'AGENT', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0,
                @AgentMov OUTPUT, @AgentMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      IF @Ok IS NULL
        EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'CXC', @ID, @Mov, @MovID, 'AGENT', @AgentID, @AgentMov, @AgentMovID, @Ok OUTPUT
      IF @Ok IS NULL
        UPDATE Cxc SET ComisionCorte = @FechaEmision WHERE CURRENT OF crComisionLote
    END
    FETCH NEXT FROM crComisionLote INTO @ID, @Mov, @MovID, @MovTipo, @Moneda, @TipoCambio, @Agente, @Comision, @Observaciones
  END  -- While	
  CLOSE crComisionLote
  DEALLOCATE crComisionLote

  IF @Ok IS NULL 
    SELECT @Mensaje = LTRIM(CONVERT(char, @Conteo))+' Comisiones Generadas.'
  ELSE
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

/*
Orden Compra   (Aplica)
1520           (AplicaID)
Factura # 123  (Referencia Opcional)
D2821S         (Articulo)
5              (Cantidad)
MX89686325     (Numero de serie de los equipos)
SG89686325     (Numero de serie de los equipos)
US89686325     (Numero de serie de los equipos)
JP89686325     (Numero de serie de los equipos)
ESA9686325     (Numero de serie de los equipos)
D2821S         (Articulo)
6              (Cantidad)
MX89686423     (Numero de serie de los equipos)
SG89686423     (Numero de serie de los equipos)
US89686423     (Numero de serie de los equipos)
JP89686423     (Numero de serie de los equipos)
ESA9686423     (Numero de serie de los equipos)
TT89686423     (Numero de serie de los equipos)
D2814A         (Articulo)
20             (Cantidad)
TW89564758     (Numero de serie de los equipos)
2	       (Cantidad)
TT89564758     (Numero de serie de los equipos)
5	       (Cantidad)
MY89564758     (Numero de serie de los equipos)
8	       (Cantidad)
CN89564758     (Numero de serie de los equipos)
3	       (Cantidad)
HU89564758     (Numero de serie de los equipos)
2	       (Cantidad)
Orden Compra   (Aplica)
1521           (AplicaID)
D2821S         (Articulo)
5              (Cantidad)
MX89686125     (Numero de serie de los equipos)
SG89686225     (Numero de serie de los equipos)
US89686325     (Numero de serie de los equipos)
JP89686425     (Numero de serie de los equipos)
ESA9686525     (Numero de serie de los equipos)
*/

/* spImportarInv */
if exists (select * from sysobjects where id = object_id('dbo.spImportarInv') and type = 'P') drop procedure dbo.spImportarInv
GO             
CREATE PROCEDURE spImportarInv
			@Estacion 	int,
			@Empresa	char(5),
			@Modulo		char(5),
			@ID		int,
                        @Sucursal	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @a			float,
    @Mov		char(20),
    @Cliente		char(10),
    @Proveedor		char(10),
    @Clave		char(20),
    @PrimerAplica	char(20),
    @PrimerAplicaID	varchar(20),
    @Aplica		char(20),
    @AplicaID		varchar(20),
    @ArtTipo		char(20),
    @Articulo		char(20),
    @Cantidad		float,
    @SerieLote		varchar(50),
    @CantidadSerieLote	float,
    @Renglon		float,
    @RenglonID		int,
    @Almacen		char(10),
    @FechaRequerida	datetime,
    @FechaEntrega	datetime,
    @Costo	        float,
    @Precio		float,
    @Impuesto1		float,
    @Impuesto2		float,
    @Impuesto3		money,
    @ZonaImpuesto	varchar(50), 
    @DescuentoTipo	char(1),
    @DescuentoLinea	float,
    @DescripcionExtra	varchar(100),
    @FechaEmision	datetime,
    @Usuario		char(10),

    @Concepto		varchar(50),
    @Proyecto		varchar(50),
    @Moneda  		char(10),
    @TipoCambio		float,
    @Referencia 	varchar(50),
    @Observaciones 	varchar(100),
    @FormaEnvio 	varchar(50),
    @Condicion  	varchar(50),
    @Vencimiento	datetime,
    @Descuento		varchar(30),
    @DescuentoGlobal 	float,
    @SobrePrecio	float,
    @CfgCompraCostoSugerido char(20),
    @CfgTipoCosteo	varchar(20),
    @Contacto		varchar(10),
    @EnviarA		int,

    @Ok			int,
    @OkRef		varchar(255)

  SELECT @CfgCompraCostoSugerido = CompraCostoSugerido, @CfgTipoCosteo = TipoCosteo FROM EmpresaCfg WHERE Empresa = @Empresa

  SELECT @Ok = NULL, @OkRef = NULL, 
	 @Aplica = NULL, @AplicaID = NULL, @PrimerAplica = NULL, @PrimerAplicaID = NULL, 
         @ArtTipo = NULL, @Articulo = NULL, @Cantidad = NULL, @SerieLote = NULL, @CantidadSerieLote = NULL,
         @Almacen = NULL, @FechaRequerida = NULL, @FechaEntrega = NULL, 
         @Renglon = 2048, @RenglonID = 1,
         @Concepto = NULL, @Proyecto = NULL, @Moneda = NULL, @TipoCambio = NULL, @Referencia = NULL, @Observaciones = NULL, 
         @FormaEnvio = NULL, @Condicion = NULL, @Vencimiento = NULL, @Descuento = NULL, @DescuentoGlobal = NULL, @SobrePrecio = NULL,
         @Cliente = NULL, @Proveedor = NULL, @FechaEmision = GETDATE(), @ZonaImpuesto = NULL , @Contacto = NULL, @EnviarA = NULL

  EXEC spExtraerFecha @FechaEmision OUTPUT

  BEGIN TRANSACTION
    IF @Modulo = 'COMS' DELETE CompraD WHERE ID = @ID ELSE
    IF @Modulo = 'INV'  DELETE InvD    WHERE ID = @ID ELSE
    IF @Modulo = 'VTAS' DELETE VentaD  WHERE ID = @ID 
    DELETE SerieLoteMov 
     WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID

    IF @Modulo = 'COMS' SELECT @Mov = Mov, @Moneda = Moneda, @TipoCambio = TipoCambio, @Usuario = Usuario, @Almacen = Almacen, @ZonaImpuesto = ZonaImpuesto, @Proveedor = Proveedor, @FechaRequerida = FechaRequerida, @FechaEntrega = FechaEntrega FROM Compra WHERE ID = @ID ELSE
    IF @Modulo = 'INV'  SELECT @Mov = Mov, @Moneda = Moneda, @TipoCambio = TipoCambio, @Usuario = Usuario, @Almacen = Almacen FROM Inv    WHERE ID = @ID ELSE
    IF @Modulo = 'VTAS' SELECT @Mov = Mov, @Moneda = Moneda, @TipoCambio = TipoCambio, @Usuario = Usuario, @Almacen = Almacen, @ZonaImpuesto = ZonaImpuesto, @Cliente = Cliente FROM Venta  WHERE ID = @ID

    DECLARE crImportarInv CURSOR SCROLL FOR 
     SELECT NULLIF(RTRIM(Clave), '')
       FROM ImportarInv
      WHERE Estacion = @Estacion

    OPEN crImportarInv
    FETCH NEXT FROM crImportarInv INTO @Clave
    IF @@Error <> 0 SELECT @Ok = 1
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Clave IS NOT NULL
      BEGIN
        IF EXISTS(SELECT * FROM MovTipo WHERE UPPER(Mov) = UPPER(@Clave) AND Modulo = @Modulo)
        BEGIN
          IF @Aplica IS NOT NULL AND @AplicaID IS NOT NULL
          BEGIN
            IF @Modulo = 'COMS'
            BEGIN
              UPDATE Compra 
                 SET RenglonID = @RenglonID , Concepto = @Concepto, Proyecto = @Proyecto, Referencia = @Referencia, Observaciones = @Observaciones,
                     FormaEnvio = @FormaEnvio, Condicion = @Condicion, Vencimiento = @Vencimiento, Descuento = @Descuento, DescuentoGlobal = @DescuentoGlobal,
                     Almacen = @Almacen, Proveedor = @Proveedor, FechaRequerida = @FechaRequerida, FechaEntrega = @FechaEntrega, Directo = 0
               WHERE ID = @ID 

               INSERT Compra (Sucursal, Empresa, Mov, Estatus, FechaEmision, Moneda, TipoCambio, Usuario, Almacen, Proveedor) 
                      VALUES (@Sucursal, @Empresa, @Mov, 'SINAFECTAR', @FechaEmision, @Moneda, @TipoCambio, @Usuario, @Almacen, @Proveedor)
               SELECT @ID = SCOPE_IDENTITY()
            END ELSE
            IF @Modulo = 'INV' 
            BEGIN
              UPDATE Inv
                 SET RenglonID = @RenglonID , Concepto = @Concepto, Proyecto = @Proyecto, Referencia = @Referencia, Observaciones = @Observaciones,
                     FormaEnvio = @FormaEnvio, Condicion = @Condicion, Vencimiento = @Vencimiento,
                     Almacen = @Almacen, Directo = 0
               WHERE ID = @ID 

               INSERT Inv (Sucursal, Empresa, Mov, Estatus, FechaEmision, Moneda, TipoCambio, Usuario, Almacen) 
                   VALUES (@Sucursal, @Empresa, @Mov, 'SINAFECTAR', @FechaEmision, @Moneda, @TipoCambio, @Usuario, @Almacen)
               SELECT @ID = SCOPE_IDENTITY()
            END ELSE
            IF @Modulo = 'PROD' 
            BEGIN
              UPDATE Prod
                 SET RenglonID = @RenglonID , Concepto = @Concepto, Proyecto = @Proyecto, Referencia = @Referencia, Observaciones = @Observaciones,
                     Almacen = @Almacen, Directo = 0
               WHERE ID = @ID 

               INSERT Prod (Sucursal, Empresa, Mov, Estatus, FechaEmision, Moneda, TipoCambio, Usuario, Almacen) 
                   VALUES (@Sucursal, @Empresa, @Mov, 'SINAFECTAR', @FechaEmision, @Moneda, @TipoCambio, @Usuario, @Almacen)
               SELECT @ID = SCOPE_IDENTITY()
            END ELSE
            IF @Modulo = 'VTAS' 
            BEGIN
              UPDATE Venta
                 SET RenglonID = @RenglonID , Concepto = @Concepto, Proyecto = @Proyecto, Referencia = @Referencia, Observaciones = @Observaciones,
                     FormaEnvio = @FormaEnvio, Condicion = @Condicion, Vencimiento = @Vencimiento, Descuento = @Descuento, DescuentoGlobal = @DescuentoGlobal, SobrePrecio = @SobrePrecio,
                     Almacen = @Almacen, Cliente = @Cliente, Directo = 0
               WHERE ID = @ID 

               INSERT Venta (Sucursal, Empresa, Mov, Estatus, FechaEmision, Moneda, TipoCambio, Usuario, Almacen, Cliente) 
                     VALUES (@Sucursal, @Empresa, @Mov, 'SINAFECTAR', @FechaEmision, @Moneda, @TipoCambio, @Usuario, @Almacen, @Cliente)
               SELECT @ID = SCOPE_IDENTITY()
	    END
          END

          SELECT @Aplica = @Clave

	  -- AplicaID
          FETCH NEXT FROM crImportarInv INTO @Clave
          IF @@FETCH_STATUS = 0 
            SELECT @AplicaID = RTRIM(@Clave)

          IF @@Error <> 0 SELECT @Ok = 1
          IF @Ok IS NULL 
          BEGIN
            IF @Modulo = 'COMS'
              SELECT @Concepto = Concepto, @Proyecto = Proyecto, @Moneda = Moneda, @TipoCambio = TipoCambio, @Referencia = Referencia, @Observaciones = Observaciones,
                     @FormaEnvio = FormaEnvio, @Condicion = Condicion, @Vencimiento = Vencimiento, @Descuento = Descuento, @DescuentoGlobal = DescuentoGlobal,
                     @Almacen = Almacen, @Proveedor = Proveedor, @FechaRequerida = FechaRequerida, @FechaEntrega = FechaEntrega,
                     @Contacto = Proveedor
                FROM Compra 
               WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
            ELSE
            IF @Modulo = 'INV' 
              SELECT @Concepto = Concepto, @Proyecto = Proyecto, @Moneda = Moneda, @TipoCambio = TipoCambio, @Referencia = Referencia, @Observaciones = Observaciones,
                     @FormaEnvio = FormaEnvio, @Condicion = Condicion, @Vencimiento = Vencimiento,
                     @Almacen = @Almacen
                FROM Inv
               WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

            ELSE
            IF @Modulo = 'PROD' 
              SELECT @Concepto = Concepto, @Proyecto = Proyecto, @Moneda = Moneda, @TipoCambio = TipoCambio, @Referencia = Referencia, @Observaciones = Observaciones,
                     @Almacen = @Almacen
                FROM Inv
               WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

            ELSE
            IF @Modulo = 'VTAS' 
              SELECT @Concepto = Concepto, @Proyecto = Proyecto, @Moneda = Moneda, @TipoCambio = TipoCambio, @Referencia = Referencia, @Observaciones = Observaciones,
                     @FormaEnvio = FormaEnvio, @Condicion = Condicion, @Vencimiento = Vencimiento, @Descuento = Descuento, @DescuentoGlobal = DescuentoGlobal, @SobrePrecio = SobrePrecio,
                     @Almacen = Almacen, @Cliente = Cliente,
                     @Contacto = Cliente, @EnviarA = EnviarA
                FROM Venta
               WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
          END

	  -- Referencia
          FETCH NEXT FROM crImportarInv INTO @Clave
          IF @@FETCH_STATUS = 0 
          BEGIN
            IF EXISTS(SELECT * FROM Art WHERE Articulo = @Clave)
              FETCH PRIOR FROM crImportarInv INTO @Clave
            ELSE
              SELECT @Referencia = RTRIM(@Clave)
          END

        END ELSE 
        BEGIN
          SELECT @ArtTipo = NULL, @Articulo = NULL
          SELECT @Articulo = Articulo, @ArtTipo = Tipo FROM Art WHERE Articulo = UPPER(@Clave)
          IF @Articulo IS NOT NULL
          BEGIN
  	    -- Cantidad
            FETCH NEXT FROM crImportarInv INTO @Clave
            IF @@FETCH_STATUS = 0 
	      IF dbo.fnEsNumerico(@Clave) = 1 SELECT @Cantidad = CONVERT(float, @Clave) ELSE SELECT @Cantidad = NULL

            IF @@Error <> 0 SELECT @Ok = 1

            IF @ArtTipo IN ('SERIE', 'LOTE', 'VIN')
            BEGIN
              SELECT @a = 0
              WHILE @a < @Cantidad AND @Ok IS NULL
              BEGIN
      	        -- Serie o Lote
                FETCH NEXT FROM crImportarInv INTO @Clave
                IF EXISTS(SELECT * FROM Art WHERE Articulo = @Clave)
                  SELECT @a = @Cantidad
                ELSE BEGIN
                  IF @@FETCH_STATUS = 0 SELECT @SerieLote = @Clave
                  IF @@Error <> 0 SELECT @Ok = 1

        	  -- Cantidad Lote
                  IF @ArtTipo = 'LOTE'
                  BEGIN
                    SELECT @CantidadSerieLote = @Cantidad
                    /*FETCH NEXT FROM crImportarInv INTO @Clave
              	    IF @@FETCH_STATUS = 0 
		      IF dbo.fnEsNumerico(@Clave) = 1 SELECT @CantidadSerieLote = CONVERT(float, @Clave) ELSE SELECT @CantidadSerieLote = NULL
                    IF @@Error <> 0 SELECT @Ok = 1*/
		  END ELSE SELECT @CantidadSerieLote = 1

                  IF @Ok IS NULL
                    INSERT SerieLoteMov (Sucursal, Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
                                 VALUES (@Sucursal, @Empresa, @Modulo, @ID, @RenglonID, @Articulo, '', @SerieLote, @CantidadSerieLote)
                  SELECT @a = @a + @CantidadSerieLote
                END
	      END
	    END

	    -- Insertar el Detalle
            IF @Ok IS NULL
            BEGIN
              SELECT @Costo = NULL, @Precio = NULL, @Impuesto1 = NULL, @Impuesto2 = NULL, @Impuesto3 = NULL, @DescuentoTipo = NULL, @DescuentoLinea = NULL, @DescripcionExtra = NULL
              IF @Aplica IS NOT NULL AND @AplicaID IS NOT NULL
              BEGIN
                IF @Modulo = 'COMS' 
                  SELECT @Almacen = d.Almacen, @FechaRequerida = d.FechaRequerida, @FechaEntrega = d.FechaEntrega, @Costo = d.Costo,
                         @Impuesto1 = d.Impuesto1, @Impuesto2 = d.Impuesto2, @Impuesto3 = d.Impuesto3, @DescuentoTipo = d.DescuentoTipo, @DescuentoLinea = d.DescuentoLinea, @DescripcionExtra = d.DescripcionExtra
                    FROM Compra e, CompraD d
                   WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Mov = @Aplica AND e.MovID = @AplicaID AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND d.Articulo = @Articulo 
                ELSE
                IF @Modulo = 'INV' 
                  SELECT @Almacen = d.Almacen, @Costo = d.Costo
                    FROM Inv e, InvD d
                   WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Mov = @Aplica AND e.MovID = @AplicaID AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND d.Articulo = @Articulo 
                ELSE
                IF @Modulo = 'PROD' 
                  SELECT @Almacen = d.Almacen, @Costo = d.Costo
                    FROM Prod e, ProdD d
                   WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Mov = @Aplica AND e.MovID = @AplicaID AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND d.Articulo = @Articulo 
                ELSE
                IF @Modulo = 'VTAS' 
                  SELECT @Almacen = d.Almacen, @Precio = Precio, @Impuesto1 = d.Impuesto1, @Impuesto2 = d.Impuesto2, @Impuesto3 = d.Impuesto3, @DescuentoTipo = d.DescuentoTipo, @DescuentoLinea = d.DescuentoLinea, @DescripcionExtra = d.DescripcionExtra
                    FROM Venta e, VentaD d
                   WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Mov = @Aplica AND e.MovID = @AplicaID AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND d.Articulo = @Articulo 
              END ELSE BEGIN
                SELECT @Aplica = NULL, @AplicaID = NULL

                IF @Modulo = 'COMS'
		  EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, NULL, NULL, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
                ELSE 
		  EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, NULL, NULL, @CfgTipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0

                SELECT @Impuesto1 = Impuesto1, @Impuesto2 = Impuesto2, @Impuesto3 = Impuesto3 FROM Art WHERE Articulo = @Articulo
              END

              EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
              EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
              EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
              EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Contacto, @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
              
              IF @Modulo = 'COMS' 
                INSERT CompraD (Sucursal, ID, Renglon, RenglonSub, RenglonID, Aplica, AplicaID, Articulo, Cantidad, DescripcionExtra, Almacen, FechaRequerida, FechaEntrega, Costo, Impuesto1, Impuesto2, Impuesto3, DescuentoTipo, DescuentoLinea)
                        VALUES (@Sucursal, @ID, @Renglon, 0, @RenglonID, @Aplica, @AplicaID, @Articulo, @Cantidad, @DescripcionExtra, @Almacen, @FechaRequerida, @FechaEntrega, @Costo, @Impuesto1, @Impuesto2, @Impuesto3, @DescuentoTipo, @DescuentoLinea)
              ELSE
              IF @Modulo = 'INV' 
                INSERT InvD (Sucursal, ID, Renglon, RenglonSub, RenglonID, Aplica, AplicaID, Articulo, Cantidad, Costo, Almacen)
                     VALUES (@Sucursal, @ID, @Renglon, 0, @RenglonID, @Aplica, @AplicaID, @Articulo, @Cantidad, @Costo, @Almacen)
              ELSE
              IF @Modulo = 'PROD' 
                INSERT ProdD (Sucursal, ID, Renglon, RenglonSub, RenglonID, Aplica, AplicaID, Articulo, Cantidad, Costo, Almacen)
                     VALUES (@Sucursal, @ID, @Renglon, 0, @RenglonID, @Aplica, @AplicaID, @Articulo, @Cantidad, @Costo, @Almacen)
              ELSE
              IF @Modulo = 'VTAS' 
                INSERT VentaD (Sucursal, ID, Renglon, RenglonSub, RenglonID, Aplica, AplicaID, Articulo, Cantidad, DescripcionExtra, Precio, Impuesto1, Impuesto2, Impuesto3, DescuentoTipo, DescuentoLinea, Almacen)
                       VALUES (@Sucursal, @ID, @Renglon, 0, @RenglonID, @Aplica, @AplicaID, @Articulo, @Cantidad, @DescripcionExtra, @Precio, @Impuesto1, @Impuesto2, @Impuesto3, @DescuentoTipo, @DescuentoLinea, @Almacen)

              SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1
            END
          END ELSE 
          BEGIN
            SELECT @Ok = 1, @OkRef = 'No Existe el Articulo: '+RTRIM(@Clave)
            RAISERROR(@OkRef,16,-1) 
          END
        END
      END 
      FETCH NEXT FROM crImportarInv INTO @Clave
    END 
    CLOSE crImportarInv
    DEALLOCATE crImportarInv

    -- Actualizar Encabezado
    IF @Ok IS NULL
    BEGIN
      IF @Aplica IS NOT NULL AND @AplicaID IS NOT NULL
      BEGIN
        IF @Modulo = 'COMS'
          UPDATE Compra 
             SET RenglonID = @RenglonID , Concepto = @Concepto, Proyecto = @Proyecto, Referencia = @Referencia, Observaciones = @Observaciones,
                 FormaEnvio = @FormaEnvio, Condicion = @Condicion, Vencimiento = @Vencimiento, Descuento = @Descuento, DescuentoGlobal = @DescuentoGlobal,
                 Almacen = @Almacen, Proveedor = @Proveedor, FechaRequerida = @FechaRequerida, FechaEntrega = @FechaEntrega, Directo = 0
           WHERE ID = @ID 
        ELSE
        IF @Modulo = 'INV' 
          UPDATE Inv
             SET RenglonID = @RenglonID , Concepto = @Concepto, Proyecto = @Proyecto, Referencia = @Referencia, Observaciones = @Observaciones,
                 FormaEnvio = @FormaEnvio, Condicion = @Condicion, Vencimiento = @Vencimiento,
                 Almacen = @Almacen, Directo = 0
           WHERE ID = @ID 
        ELSE
        IF @Modulo = 'PROD' 
          UPDATE Prod
             SET RenglonID = @RenglonID , Concepto = @Concepto, Proyecto = @Proyecto, Referencia = @Referencia, Observaciones = @Observaciones,
                 Almacen = @Almacen, Directo = 0
           WHERE ID = @ID 
        ELSE
        IF @Modulo = 'VTAS' 
          UPDATE Venta
             SET RenglonID = @RenglonID , Concepto = @Concepto, Proyecto = @Proyecto, Referencia = @Referencia, Observaciones = @Observaciones,
                 FormaEnvio = @FormaEnvio, Condicion = @Condicion, Vencimiento = @Vencimiento, Descuento = @Descuento, DescuentoGlobal = @DescuentoGlobal, SobrePrecio = @SobrePrecio,
                 Almacen = @Almacen, Cliente = @Cliente, Directo = 0
           WHERE ID = @ID 
      END ELSE
      BEGIN
        IF @Modulo = 'COMS' UPDATE Compra SET RenglonID = @RenglonID WHERE ID = @ID ELSE
        IF @Modulo = 'INV'  UPDATE Inv    SET RenglonID = @RenglonID WHERE ID = @ID ELSE
        IF @Modulo = 'PROD' UPDATE Prod   SET RenglonID = @RenglonID WHERE ID = @ID ELSE
        IF @Modulo = 'VTAS' UPDATE Venta  SET RenglonID = @RenglonID WHERE ID = @ID 
      END
    END
  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  RETURN
END
GO


/* spImportarInvArt */
if exists (select * from sysobjects where id = object_id('dbo.spImportarInvArt') and type = 'P') drop procedure dbo.spImportarInvArt
GO             
CREATE PROCEDURE spImportarInvArt 
		    @Estacion 	int,
                    @ID		int,
		    @Sucursal	int
--//WITH ENCRYPTION
AS BEGIN
  SET nocount ON
  DECLARE
    @Empresa		char(5),
    @Cliente		char(10),
    @Renglon		float,
    @RenglonID		int,
    @Articulo		char(20),
    @UltArticulo	char(20),
    @ArtTipo		char(20),
    @Categoria		varchar(50),
    @Moneda		char(10),
    @Impuesto		float,
    @Descripcion	varchar(100),
    @UltDescripcion	varchar(100),
    @Serie		varchar(50),
    @UltSerie		varchar(50),
    @Ubicacion		varchar(100),
    @Cantidad		float,
    @EnviarA		int

  SELECT @UltArticulo = NULL, @UltDescripcion = NULL, @UltSerie = NULL, @Cantidad = 0.0,  @RenglonID = 1, @Renglon = 2048, @Cantidad = 0
  SELECT @Empresa = Empresa, @Cliente = Cliente
    FROM Venta 
   WHERE ID = @ID

  SELECT @Categoria = NULLIF(RTRIM(ArtExpressCategoria), ''), 
         @Impuesto = DefImpuesto
    FROM EmpresaGral 
   WHERE Empresa = @Empresa

  SELECT @Moneda = NULLIF(RTRIM(ContMoneda), '')
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  BEGIN TRANSACTION
    DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'VTAS' AND ID = @ID
    DELETE VentaD WHERE ID = @ID
    DECLARE crImportarInvArt CURSOR FOR 
     SELECT NULLIF(RTRIM(Articulo), ''), NULLIF(RTRIM(Descripcion), ''), NULLIF(RTRIM(Serie), ''), NULLIF(RTRIM(Ubicacion), '')
       FROM ImportarInvArt
      WHERE Estacion = @Estacion

    OPEN crImportarInvArt
    FETCH NEXT FROM crImportarInvArt INTO @Articulo, @Descripcion, @Serie, @Ubicacion
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Articulo IS NOT NULL 
      BEGIN
        SELECT @EnviarA = NULL, @UltArticulo = @Articulo, @UltDescripcion = @Descripcion, @UltSerie = @Serie
        IF @Serie IS NOT NULL
        BEGIN
          IF @Ubicacion IS NOT NULL
          BEGIN
            -- Checar Enviar a
            IF dbo.fnEsNumerico(@Ubicacion) = 1
              SELECT @EnviarA = MIN(ID) FROM CteEnviarA WHERE Cliente = @Cliente AND ID = CONVERT(int, RTRIM(@Ubicacion))
            ELSE 
              SELECT @EnviarA = MIN(ID) FROM CteEnviarA WHERE Cliente = @Cliente AND UPPER(Nombre) LIKE '%'+UPPER(RTRIM(@Ubicacion))+'%'
            IF @EnviarA IS NULL
            BEGIN
              SELECT @EnviarA = ISNULL(MAX(ID), 0) + 1 FROM CteEnviarA WHERE Cliente = @Cliente
              INSERT CteEnviarA (Cliente, ID, Nombre) VALUES (@Cliente, @EnviarA, @Ubicacion)
            END
          END
          -- Insertar la Serie
          INSERT SerieLoteMov (Sucursal, Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Ubicacion)
                       VALUES (@Sucursal, @Empresa, 'VTAS', @ID, @RenglonID, @Articulo, '', @Serie, 1, @EnviarA)
        END
        SELECT @Cantidad = @Cantidad + 1
      END 
      SELECT @Articulo = NULL
      FETCH NEXT FROM crImportarInvArt INTO @Articulo, @Descripcion, @Serie, @Ubicacion
      IF @Articulo <> @UltArticulo AND @UltArticulo IS NOT NULL
      BEGIN
        -- Checar Articulo
        IF NOT EXISTS(SELECT * FROM Art WHERE Articulo = @UltArticulo)
        BEGIN
          IF @UltSerie IS NULL SELECT @ArtTipo = 'Normal' ELSE SELECT @ArtTipo = 'Serie'
          INSERT Art (Articulo, Descripcion1, Categoria, MonedaCosto, MonedaPrecio, Impuesto1, Estatus, Tipo) 
              VALUES (@UltArticulo, @UltDescripcion, @Categoria, @Moneda, @Moneda, @Impuesto, 'NORMAL', @ArtTipo)
        END
        INSERT VentaD (Sucursal, ID, Renglon, RenglonSub, RenglonID, Articulo, Cantidad, Impuesto1)
               VALUES (@Sucursal, @ID, @Renglon, 0, @RenglonID, @UltArticulo, @Cantidad, @Impuesto)
        SELECT @RenglonID = @RenglonID + 1, @Renglon = @Renglon + 2048, @Cantidad = 0
      END
    END 
    CLOSE crImportarInvArt
    DEALLOCATE crImportarInvArt

  COMMIT TRANSACTION 
  RETURN
END
GO

/**************** spInvCalcPesoVolumen ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvCalcPesoVolumen') and type = 'P') drop procedure dbo.spInvCalcPesoVolumen
GO             
CREATE PROCEDURE spInvCalcPesoVolumen
		   @Empresa		char(5),
                   @ID			int,
		   @CfgMultiUnidades	bit,
		   @PesoTotal		float	OUTPUT,
    		   @VolumenTotal	float	OUTPUT,
		   @PesoVolumenTotal	float	OUTPUT,
		   @PedimentoEspecifico	char(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
DECLARE
    @Articulo	char(20),
    @CantidadF	float,
    @Peso	float,
    @Volumen	float

  SELECT @PesoTotal = 0.0, @VolumenTotal = 0.0, @PesoVolumenTotal = 0.0
  IF @PedimentoEspecifico IS NULL
    DECLARE crInvD CURSOR FOR
     SELECT d.Articulo, (d.Cantidad*d.Factor), a.Peso, a.Volumen
       FROM InvD d, Art a
      WHERE d.ID = @ID AND d.Articulo = a.Articulo 
  ELSE
    DECLARE crInvD CURSOR FOR
     SELECT d.Articulo, (d.Cantidad*d.Factor), a.Peso, a.Volumen
       FROM InvD d, Art a, SerieLoteMov s
      WHERE d.ID = @ID AND d.Articulo = a.Articulo 
        AND s.Empresa = @Empresa AND s.Modulo = 'INV' AND s.ID = d.ID AND s.RenglonID = d.RenglonID AND s.Articulo = d.Articulo AND s.SerieLote = @PedimentoEspecifico

  OPEN crInvD
  FETCH NEXT FROM crInvD INTO @Articulo, @CantidadF, @Peso, @Volumen
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @CantidadF > 0.0 
      SELECT @PesoTotal = @PesoTotal + (@Peso * @CantidadF),
             @VolumenTotal = @VolumenTotal + (@Volumen * @CantidadF),
             @PesoVolumenTotal = @PesoVolumenTotal + (@Peso * @Volumen * @CantidadF)             
    FETCH NEXT FROM crInvD INTO @Articulo, @CantidadF, @Peso, @Volumen
  END 
  CLOSE crInvD
  DEALLOCATE crInvD

  RETURN
END
GO

/**************** spInvCostoInv ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvCostoInv') and type = 'P') drop procedure dbo.spInvCostoInv
GO             
CREATE PROCEDURE spInvCostoInv
                    @ID	 int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Concepto		 varchar(50),
    @Acreedor		 char(10),
    @RenglonID		 int,
    @Importe		 money,
    @Retencion		 float,
    @Retencion2		 float,
    @Retencion3		 money,
    @Impuestos		 float,
    @Moneda		 char(10),
    @TipoCambio		 float,
    @Prorrateo		 char(20),
    @PedimentoEspecifico char(20),
    @Multiple		 bit,
    @Mensaje		 varchar(255)

  IF (SELECT Estatus FROM Inv WHERE ID = @ID) NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
    RETURN
  END

  UPDATE InvD SET CostoInv = Costo WHERE ID = @ID
  DECLARE crGastoDiverso CURSOR FOR
   SELECT Concepto, Acreedor, RenglonID, Importe, Moneda, TipoCambio, NULLIF(RTRIM(UPPER(Prorrateo)), ''), NULLIF(RTRIM(PedimentoEspecifico), ''), ISNULL(Multiple, 0)
     FROM InvGastoDiverso
    WHERE ID = @ID 
  OPEN crGastoDiverso
  FETCH NEXT FROM crGastoDiverso INTO @Concepto, @Acreedor, @RenglonID, @Importe, @Moneda, @TipoCambio, @Prorrateo, @PedimentoEspecifico, @Multiple
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Multiple = 1
      BEGIN
        SELECT @Importe = SUM(Importe),
	       @Retencion = SUM(Retencion),
	       @Retencion2 = SUM(Retencion2),
	       @Retencion3 = SUM(Retencion3),
               @Impuestos = SUM(Impuestos)
          FROM InvGastoDiversoD 
         WHERE ID = @ID AND Concepto = @Concepto AND Acreedor = @Acreedor AND RenglonID = @RenglonID

        UPDATE InvGastoDiverso 
           SET Importe    = @Importe,
	       Retencion  = @Retencion,
	       Retencion2 = @Retencion2,
	       Retencion3 = @Retencion3,
               Impuestos  = @Impuestos
         WHERE CURRENT OF crGastoDiverso
      END
      IF @Prorrateo NOT IN (NULL, 'NO')
        EXEC spInvProratear @ID, @Prorrateo, @Importe, @Moneda, @TipoCambio, @PedimentoEspecifico
    END
    FETCH NEXT FROM crGastoDiverso INTO @Concepto, @Acreedor, @RenglonID, @Importe, @Moneda, @TipoCambio, @Prorrateo, @PedimentoEspecifico, @Multiple
  END
  CLOSE crGastoDiverso
  DEALLOCATE crGastoDiverso
END
GO

/**************** spInvFusionarBorradores ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvFusionarBorradores') and type = 'P') drop procedure dbo.spInvFusionarBorradores
GO             
CREATE PROCEDURE spInvFusionarBorradores
                    @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		    int,
    @Renglon	float,
    @RenglonID  int,
	@Almacen    varchar(10),
	@WMS        bit,
	@Ok         int,
    @OkRef      varchar(255)

  SELECT @Renglon = 0.0
  SELECT @ID = MIN(ID) FROM ListaID WHERE Estacion = @Estacion

  SELECT @Almacen = Almacen 
    FROM Inv 
   WHERE ID = @ID 
  
  SELECT @WMS = WMS
    FROM Alm
   WHERE Almacen = @Almacen

  CREATE TABLE #Borrador (
							ID			        int		    NOT NULL IDENTITY(1, 1) PRIMARY KEY,
							Renglon			    float		NULL,
							RenglonID		    int			NULL,
							Articulo		    char(20)	COLLATE Database_Default NULL,
							SubCuenta		    varchar(20)	COLLATE Database_Default NULL,
							Unidad			    varchar(50)	COLLATE Database_Default NULL,
							Almacen			    char(10)	COLLATE Database_Default NULL,
							Cantidad		    float		NULL,
							CantidadInventario	float		NULL,
							Tarima              varchar(20) NULL,
							PosicionActual      varchar(10) NULL,
							PosicionReal        varchar(10) NULL
						 )
  
  IF ISNULL(@WMS,0) = 0
  BEGIN
	  INSERT #Borrador (Articulo, SubCuenta, Unidad, Almacen, Cantidad, CantidadInventario)
	  SELECT d.Articulo, d.SubCuenta, d.Unidad, i.Almacen, "Cantidad" = SUM(d.Cantidad), "CantidadInventario" = SUM(d.CantidadInventario) 
		FROM Inv i
		JOIN InvD d ON i.ID = d.ID 
		JOIN ListaID l ON i.ID = l.ID AND l.Estacion = @Estacion
	   GROUP BY d.Articulo, d.SubCuenta, d.Unidad, i.Almacen
	   ORDER BY d.Articulo, d.SubCuenta, d.Unidad, i.Almacen
  END

  IF ISNULL(@WMS,0) = 1
  BEGIN
	  INSERT #Borrador (Articulo, SubCuenta, Unidad, Almacen, Cantidad, CantidadInventario, Tarima, PosicionActual, PosicionReal)
	  SELECT d.Articulo, d.SubCuenta, d.Unidad, i.Almacen, "Cantidad" = SUM(d.Cantidad), "CantidadInventario" = SUM(d.CantidadInventario), d.Tarima, d.PosicionActual, d.PosicionReal
		FROM Inv i
		JOIN InvD d ON i.ID = d.ID 
		JOIN ListaID l ON i.ID = l.ID AND l.Estacion = @Estacion
	   GROUP BY d.Articulo, d.SubCuenta, d.Unidad, i.Almacen, d.Tarima, d.PosicionActual, d.PosicionReal
	   ORDER BY d.Articulo, d.SubCuenta, d.Unidad, i.Almacen, d.Tarima, d.PosicionActual, d.PosicionReal
  END
  
  IF @Ok IS NULL
  BEGIN
	UPDATE #Borrador SET @Renglon = Renglon = ISNULL(Renglon, 0) + @Renglon + 2048.0
	UPDATE #Borrador SET @RenglonID = RenglonID = ISNULL(RenglonID, 0) + @RenglonID + 1 
	DELETE InvD WHERE ID = @ID
  END

  IF @Ok IS NULL AND @WMS = 0
  BEGIN
	  INSERT InvD (ID,  Renglon, RenglonID, Articulo, SubCuenta, Unidad, Almacen, Cantidad, CantidadInventario)
			SELECT @ID, Renglon, RenglonID, Articulo, SubCuenta, Unidad, Almacen, Cantidad, CantidadInventario
			  FROM #Borrador
	  DELETE InvD WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion AND ID <> @ID)
	  DELETE Inv  WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion AND ID <> @ID)

	  SELECT @OkRef = CONVERT(varchar, COUNT(*))+ ' Movimientos Fusionados.' 
		FROM ListaID 
	   WHERE Estacion = @Estacion
  END

  IF @Ok IS NULL AND @WMS = 1
  BEGIN
	  INSERT InvD (ID,  Renglon, RenglonID, Articulo, SubCuenta, Unidad, Almacen, Cantidad, CantidadInventario, Tarima, PosicionActual, PosicionReal)
			SELECT @ID, Renglon, RenglonID, Articulo, SubCuenta, Unidad, Almacen, Cantidad, CantidadInventario, Tarima, PosicionActual, PosicionReal
			  FROM #Borrador
	  DELETE InvD WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion AND ID <> @ID)
	  DELETE Inv  WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion AND ID <> @ID)

	  SELECT @OkRef = CONVERT(varchar, COUNT(*))+ ' Movimientos Fusionados.' 
		FROM ListaID 
	   WHERE Estacion = @Estacion
  END

  SELECT @OkRef
  RETURN
END
GO

/**************** spInvProratear ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvProratear') and type = 'P') drop procedure dbo.spInvProratear
GO             
CREATE PROCEDURE spInvProratear
                   @ID				int,
		   @BaseProrrateo		char(20),
		   @BaseImporte		        float,
	   	   @GastoMoneda			char(10),
		   @GastoTipoCambio		float,
		   @PedimentoEspecifico 	char(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @CfgMultiUnidades	bit,
    @Ok			int,
    @OkRef		varchar(255),
    @Renglon		float,
    @RenglonSub		int,
    @Articulo		char(20),
    @Cantidad		float,
    @CantidadF		float,
    @CostoLinea		float,   
    @Peso		float,
    @PesoLinea		float,
    @Volumen		float,
    @VolumenLinea	float,
    @PesoVolumenLinea	float,
    @FactorCosto	float,
    @Arancel		varchar(50),
    @ArancelPorcentaje	float,
    @MovMoneda		char(10),
    @MovTipoCambio	float,
    @ImporteTotal	money,
    @CantidadTotal 	float,
    @PesoTotal		float,
    @VolumenTotal	float,
    @PesoVolumenTotal	float,
    @CostoArancel	float,
    @ArancelTotal	money,
    @NuevoCosto		float,
    @MovUnidad		varchar(50)

  SELECT @Ok = NULL, @BaseProrrateo = UPPER(@BaseProrrateo)
  EXEC spInvCalcFactor 'INV', @ID
  SELECT @Empresa = Empresa FROM Inv WHERE ID = @ID 
  SELECT @CfgMultiUnidades = MultiUnidades FROM EmpresaCfg2 WHERE Empresa = @Empresa

  IF @PedimentoEspecifico IS NULL
    SELECT @ImporteTotal = SUM(Costo*Cantidad) 
      FROM InvD
     WHERE ID = @ID 
  ELSE
    SELECT @ImporteTotal = SUM(d.Costo*d.Cantidad) 
      FROM InvD d, SerieLoteMov s 
     WHERE d.ID = @ID 
       AND s.Empresa = @Empresa AND s.Modulo = 'INV' AND s.ID = d.ID AND s.RenglonID = d.RenglonID AND s.Articulo = d.Articulo AND s.SerieLote = @PedimentoEspecifico


  IF @BaseProrrateo = 'CANTIDAD'
  BEGIN
    IF @PedimentoEspecifico IS NULL
      SELECT @CantidadTotal = SUM(Cantidad*Factor) 
        FROM InvD 
       WHERE ID = @ID
    ELSE
      SELECT @CantidadTotal = SUM(d.Cantidad*d.Factor) 
        FROM InvD d, SerieLoteMov s 
       WHERE d.ID = @ID 
         AND s.Empresa = @Empresa AND s.Modulo = 'INV' AND s.ID = d.ID AND s.RenglonID = d.RenglonID AND s.Articulo = d.Articulo AND s.SerieLote = @PedimentoEspecifico
  END

  IF @BaseProrrateo = 'ARANCEL'
  BEGIN
    IF @PedimentoEspecifico IS NULL
      SELECT @ArancelTotal = SUM(d.Costo*d.Cantidad*(aa.Porcentaje/100.0)) 
        FROM InvD d, Art a, ArtArancel aa 
       WHERE d.ID = @ID AND d.Articulo =a.Articulo AND a.Arancel = aa.Arancel
    ELSE
      SELECT @ArancelTotal = SUM(d.Costo*d.Cantidad*(aa.Porcentaje/100.0)) 
        FROM InvD d, Art a, ArtArancel aa, SerieLoteMov s 
       WHERE d.ID = @ID AND d.Articulo =a.Articulo AND a.Arancel = aa.Arancel 
         AND s.Empresa = @Empresa AND s.Modulo = 'INV' AND s.ID = d.ID AND s.RenglonID = d.RenglonID AND s.Articulo = d.Articulo AND s.SerieLote = @PedimentoEspecifico
  END
  
  IF @BaseProrrateo IN ('PESO/VOLUMEN', 'PESO', 'VOLUMEN')
    EXEC spInvCalcPesoVolumen @Empresa, @ID, @CfgMultiUnidades, @PesoTotal OUTPUT, @VolumenTotal OUTPUT, @PesoVolumenTotal OUTPUT, @PedimentoEspecifico

  SELECT @MovMoneda = Moneda, @MovTipoCambio = TipoCambio FROM Inv WHERE ID = @ID
  IF @MovMoneda <> @GastoMoneda 
    SELECT @FactorCosto = @GastoTipoCambio / @MovTipoCambio 
  ELSE SELECT @FactorCosto = 1.0

  BEGIN TRANSACTION
    IF @PedimentoEspecifico IS NULL
      DECLARE crInvD CURSOR FOR
       SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Unidad, d.Cantidad, d.Cantidad*d.Factor, d.Cantidad*d.Costo, a.Peso, a.Volumen, a.Arancel, aa.Porcentaje
         FROM InvD d
         JOIN Art a ON d.Articulo = a.Articulo
         LEFT OUTER JOIN ArtArancel aa ON a.Arancel = aa.Arancel
        WHERE d.ID = @ID
    ELSE
      DECLARE crInvD CURSOR FOR
       SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Unidad, d.Cantidad, d.Cantidad*d.Factor, d.Cantidad*d.Costo, a.Peso, a.Volumen, a.Arancel, aa.Porcentaje
         FROM InvD d
         JOIN Art a ON d.Articulo = a.Articulo 
         LEFT OUTER JOIN ArtArancel aa ON a.Arancel = aa.Arancel
         JOIN SerieLoteMov s ON d.ID = s.ID AND d.RenglonID = s.RenglonID AND d.Articulo = s.Articulo 
        WHERE d.ID = @ID AND s.Empresa = @Empresa AND s.Modulo = 'INV' AND s.SerieLote = @PedimentoEspecifico

    OPEN crInvD
    FETCH NEXT FROM crInvD INTO @Renglon, @RenglonSub, @Articulo, @MovUnidad, @Cantidad, @CantidadF, @CostoLinea, @Peso, @Volumen, @Arancel, @ArancelPorcentaje
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Cantidad > 0.0 AND @CostoLinea > 0.0
      BEGIN
        SELECT @PesoLinea = @Peso * @CantidadF,
	       @VolumenLinea = @Volumen * @CantidadF,
               @PesoVolumenLinea = @Peso * @Volumen * @CantidadF
        SELECT @CostoArancel = @CostoLinea * (@ArancelPorcentaje/100.0)
   
        SELECT @NuevoCosto = 0.0
        IF @BaseProrrateo = 'COSTO'        SELECT @NuevoCosto = (@CostoLinea * @BaseImporte) / @ImporteTotal      	ELSE
        IF @BaseProrrateo = 'CANTIDAD'     SELECT @NuevoCosto = (@CantidadF * @BaseImporte)  / @CantidadTotal      	ELSE
        IF @BaseProrrateo = 'PESO'         SELECT @NuevoCosto = (@PesoLinea * @BaseImporte)     / @PesoTotal           	ELSE
        IF @BaseProrrateo = 'VOLUMEN'      SELECT @NuevoCosto = (@VolumenLinea * @BaseImporte) / @VolumenTotal         	ELSE
        IF @BaseProrrateo = 'PESO/VOLUMEN' SELECT @NuevoCosto = (@PesoVolumenLinea * @BaseImporte) / @PesoVolumenTotal 	ELSE
        IF @BaseProrrateo = 'ARANCEL'
        BEGIN
          SELECT @NuevoCosto = (@CostoArancel * @BaseImporte) / @ArancelTotal
          --IF ISNULL(@ArancelPorcentaje, 0.0) = 0.0 SELECT @Ok = -1, @OkRef = 'Error - Falta Configurar el Arancel del Articulo: '+RTRIM(@Articulo)
        END

        UPDATE InvD SET CostoInv = CostoInv + ((@NuevoCosto*@FactorCosto)/@Cantidad) WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END
      FETCH NEXT FROM crInvD INTO @Renglon, @RenglonSub, @Articulo, @MovUnidad, @Cantidad, @CantidadF, @CostoLinea, @Peso, @Volumen, @Arancel, @ArancelPorcentaje
    END 
    CLOSE crInvD
    DEALLOCATE crInvD
  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE BEGIN
    ROLLBACK TRANSACTION
    RAISERROR(@OkRef,16,-1) 
  END 

  RETURN
END
GO

/**************** spInvTraspasarTodo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvTraspasarTodo') and type = 'P') drop procedure dbo.spInvTraspasarTodo
GO             
CREATE PROCEDURE spInvTraspasarTodo
			@ID		int,
			@Empresa	char(5),
			@Sucursal	int,
			@Almacen	char(10)
--//WITH ENCRYPTION
AS BEGIN
  DELETE InvD WHERE ID = @ID
  DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID
  EXEC spInvInventarioFisico @Sucursal, NULL, @Empresa, @Almacen, @ID, 'DISPONIBLE', 1, 'SINAFECTAR', NULL, NULL
  RETURN
END
GO

/**************** spListaProdSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spListaProdSerieLote') and type = 'P') drop procedure dbo.spListaProdSerieLote
GO             
CREATE PROCEDURE spListaProdSerieLote
			@Estacion	int

--//WITH ENCRYPTION
AS BEGIN
  INSERT ListaProdSerieLote (Estacion, SerieLote)
  SELECT Estacion, CONVERT(varchar(20), Datos)
    FROM ListaDatos
   WHERE Estacion = @Estacion AND NULLIF(RTRIM(CONVERT(varchar(20), Datos)), '') IS NOT NULL
  RETURN
END
GO

/**************** spListaStBorrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spListaStBorrar') and type = 'P') drop procedure dbo.spListaStBorrar
GO             
CREATE PROCEDURE spListaStBorrar
                    @Estacion		int

--//WITH ENCRYPTION
AS BEGIN
  DELETE ListaSt WHERE Estacion = @Estacion
END
GO

/**************** spModificarAlmacenPedidos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spModificarAlmacenPedidos') and type = 'P') drop procedure dbo.spModificarAlmacenPedidos
GO             
CREATE PROCEDURE spModificarAlmacenPedidos
                    	@ID		int,
			@Almacen	char(10),
			@Reservar	char(2) = 'NO'

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @Renglon		float,
     @RenglonSub	int,
     @AlmacenTipo 	char(20) 

  SELECT @Almacen     = Almacen,
         @AlmacenTipo = Tipo
    FROM Alm 
   WHERE UPPER(Almacen) = UPPER(@Almacen)
  IF @Almacen IS NULL RETURN
  IF (EXISTS(SELECT * 
               FROM VentaD 
              WHERE ID = @ID
                AND (ISNULL(CantidadReservada, 0) > 0 OR ISNULL(CantidadOrdenada, 0) > 0)))
  BEGIN
    RAISERROR('Tiene Articulos Reservados y/o Ordenados, No se puede cambiar el Almacen',16,-1)               
    RETURN
  END
  IF @AlmacenTipo <> (SELECT Alm.Tipo FROM Venta, Alm WHERE Venta.ID = @ID AND Alm.Almacen = Venta.Almacen)
  BEGIN
    RAISERROR('Los Almacenes deben de ser del Mismo Tipo',16,-1)               
    RETURN
  END
  BEGIN TRANSACTION
    UPDATE Venta SET Almacen = @Almacen WHERE ID = @ID

    -- Hacer el update renglon por renglon para que funcione bien el trigger
    DECLARE crVentaD CURSOR FOR
     SELECT Renglon, RenglonSub FROM VentaD WHERE ID = @ID
    OPEN crVentaD
    FETCH NEXT FROM crVentaD INTO @Renglon, @RenglonSub
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        UPDATE VentaD SET Almacen = @Almacen WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END
      FETCH NEXT FROM crVentaD INTO @Renglon, @RenglonSub
    END
    CLOSE crVentaD
    DEALLOCATE crVentaD
  COMMIT TRANSACTION

  IF UPPER(@Reservar) <> 'NO'
    EXEC spAfectar 'VTAS', @ID, 'RESERVARPARCIAL', 'PENDIENTE', NULL
  ELSE SELECT NULL, NULL, NULL, NULL, NULL
  RETURN
END
GO

-- spModificarAlmacenSolicitudes 9, 'DELTA'
/**************** spModificarAlmacenSolicitudes ****************/
if exists (select * from sysobjects where id = object_id('dbo.spModificarAlmacenSolicitudes') and type = 'P') drop procedure dbo.spModificarAlmacenSolicitudes
GO             
CREATE PROCEDURE spModificarAlmacenSolicitudes
                    	@ID		int,
			@Almacen	char(10),
			@Reservar	char(2) = 'NO',
			@Renglon	float = NULL,
			@RenglonSub	int   = NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @AlmacenTipo 	char(20) 

  SELECT @Almacen     = Almacen,
         @AlmacenTipo = Tipo
    FROM Alm 
   WHERE UPPER(Almacen) = UPPER(@Almacen)
  IF @Almacen IS NULL RETURN

  IF @Renglon IS NULL
  BEGIN
    IF (EXISTS(SELECT * 
                 FROM InvD 
                WHERE ID = @ID
                  AND (ISNULL(CantidadReservada, 0) > 0 OR ISNULL(CantidadOrdenada, 0) > 0)))
    BEGIN
      RAISERROR('Tiene Articulos Reservados y/o Ordenados, No se puede cambiar el Almacen',16,-1)               
      RETURN
    END
    IF @AlmacenTipo <> (SELECT Alm.Tipo FROM Inv, Alm WHERE Inv.ID = @ID AND Alm.Almacen = Inv.Almacen)
    BEGIN
      RAISERROR('Los Almacenes deben de ser del Mismo Tipo',16,-1)               
      RETURN
    END
    BEGIN TRANSACTION
      UPDATE Inv SET Almacen = @Almacen WHERE ID = @ID

      -- Hacer el update renglon por renglon para que funcione bien el trigger
      DECLARE crInvD CURSOR FOR
       SELECT Renglon, RenglonSub FROM InvD WHERE ID = @ID
      OPEN crInvD
      FETCH NEXT FROM crInvD INTO @Renglon, @RenglonSub
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          UPDATE InvD SET Almacen = @Almacen WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        END
        FETCH NEXT FROM crInvD INTO @Renglon, @RenglonSub
      END
      CLOSE crInvD
      DEALLOCATE crInvD
    COMMIT TRANSACTION
  END ELSE 
  BEGIN
    IF (EXISTS(SELECT * 
                 FROM InvD 
                WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
                  AND (ISNULL(CantidadReservada, 0) > 0 OR ISNULL(CantidadOrdenada, 0) > 0)))
    BEGIN
      RAISERROR('Tiene Articulos Reservados y/o Ordenados, No se puede cambiar el Almacen',16,-1)               
      RETURN
    END
    IF @AlmacenTipo <> (SELECT Alm.Tipo FROM InvD, Alm WHERE InvD.ID = @ID AND InvD.Renglon = @Renglon AND InvD.RenglonSub = @RenglonSub AND Alm.Almacen = InvD.Almacen)
    BEGIN
      RAISERROR('Los Almacenes deben de ser del Mismo Tipo',16,-1)               
      RETURN
    END
    BEGIN TRANSACTION
      UPDATE InvD SET Almacen = @Almacen WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
    COMMIT TRANSACTION
  END

  IF UPPER(@Reservar) <> 'NO'
    EXEC spAfectar 'INV', @ID, 'RESERVARPARCIAL', 'PENDIENTE', NULL
  ELSE SELECT NULL, NULL, NULL, NULL, NULL
  RETURN
END
GO

/**************** spModificarCostoPromedioAlmacen ****************/
if exists (select * from sysobjects where id = object_id('dbo.spModificarCostoPromedioAlmacen') and type = 'P') drop procedure dbo.spModificarCostoPromedioAlmacen
GO             
CREATE PROCEDURE spModificarCostoPromedioAlmacen
			@Empresa	char(5),
			@Usuario	char(10),
			@Lista		varchar(20),
			@Estacion	int,
			@Almacen	char(10),
			@FechaEmision	datetime,
			@AjusteMov	char(20),
			@Moneda		char(10),
			@TipoCambio	float,
			@Factor		float,
			@Conteo		int		OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Sucursal		int,
    @Renglon		float,
    @RenglonID		int,
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Cantidad		float,
    @Unidad		varchar(50),
    @ArtTipo		varchar(20),
    @RenglonTipo	char(1),
    @AjusteID		int,
    @AjusteMovID	varchar(20),
    @FechaRegistro	datetime,
    @Costo		float,
    @Referencia		varchar(50),
    @Tarima		varchar(20)

  IF EXISTS(SELECT * FROM ArtReservado ar, ListaSt l WHERE ar.Empresa = @Empresa AND ar.Almacen = @Almacen AND ISNULL(ar.Reservado, 0) <> 0 AND l.Estacion = @Estacion AND l.Clave = ar.Articulo)
  BEGIN
    SELECT @Ok = 20980, @OkRef = @Almacen
    RETURN
  END

  IF @Factor = -1 SELECT @Referencia = 'Salida' ELSE SELECT @Referencia = 'Entrada' 
  INSERT Inv (Empresa,  Usuario,  Estatus,     Mov,        FechaEmision,  Referencia,  Moneda,  TipoCambio,  Almacen,  Directo, VerLote)
      VALUES (@Empresa, @Usuario, 'CONFIRMAR', @AjusteMov, @FechaEmision, @Referencia, @Moneda, @TipoCambio, @Almacen, 0, 1)
  SELECT @AjusteID = SCOPE_IDENTITY()

  SELECT @Renglon = 0.0, @RenglonID = 0
  SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @Almacen

  DECLARE crAjuste CURSOR FOR
   SELECT e.Articulo, e.SubCuenta, e.Tarima, ISNULL(e.Inventario, 0.0)*@Factor, a.Unidad, a.Tipo
     FROM ArtSubExistenciaInvTarima e, Art a, ListaSt l
    WHERE e.Articulo = a.Articulo AND e.Empresa = @Empresa AND e.Almacen = @Almacen
      AND l.Estacion = @Estacion AND l.Clave = a.Articulo

  OPEN crAjuste
  FETCH NEXT FROM crAjuste INTO @Articulo, @SubCuenta, @Tarima, @Cantidad, @Unidad, @ArtTipo
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Cantidad <> 0.0
    BEGIN
      EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT

      SELECT @Renglon   = @Renglon + 2048, @RenglonID = @RenglonID + 1, @Costo = NULL
      IF @Factor = 1
        EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @Moneda, @TipoCambio, @Lista, @Costo OUTPUT
      INSERT INTO InvD (Sucursal,  ID,        Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Cantidad,  CantidadInventario,  Unidad, Almacen,  Tarima,  Costo)
                VALUES (@Sucursal, @AjusteID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Cantidad, @Cantidad,          @Unidad, @Almacen, @Tarima, @Costo)
      IF UPPER(@ArtTipo) IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA') 
        INSERT INTO SerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
          SELECT @Empresa, 'INV', @AjusteID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), SerieLote, Existencia
            FROM SerieLote
           WHERE Sucursal = @Sucursal
             AND Empresa = @Empresa 
             AND Articulo = @Articulo
             AND SubCuenta = ISNULL(@SubCuenta, '')
             AND Almacen = @Almacen
             AND Tarima = @Tarima
             AND ISNULL(Existencia, 0) > 0 
    END
    FETCH NEXT FROM crAjuste INTO @Articulo, @SubCuenta, @Tarima, @Cantidad, @Unidad, @ArtTipo
    IF @@ERROR <> 0 SELECT @Ok = 1
  END
  CLOSE crAjuste
  DEALLOCATE crAjuste

  IF @RenglonID > 0
  BEGIN
    UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @AjusteID
    SELECT @FechaRegistro = GETDATE()
    /*EXEC spInv @AjusteID, 'INV', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
               @AjusteMov, @AjusteMovID OUTPUT, NULL, NULL,
               @Ok OUTPUT, @OkRef OUTPUT, 0*/
    IF @Ok IS NULL SELECT @Conteo = @Conteo + 1
  END ELSE
    DELETE Inv WHERE ID = @AjusteID

  RETURN
END
GO

-- spModificarCostoPromedioSucursal 'DEMO', 'DEMO', ''
/**************** spModificarCostoPromedioSucursal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spModificarCostoPromedioSucursal') and type = 'P') drop procedure dbo.spModificarCostoPromedioSucursal
GO             
CREATE PROCEDURE spModificarCostoPromedioSucursal
			@Empresa	char(5),
			@Usuario	char(10),
			@Lista		varchar(20),
			@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255),
    @Conteo		int,
    @AjusteMov		char(20),
    @Almacen		char(10),
    @Moneda		char(10),
    @TipoCambio		float,
    @FechaEmision	datetime,
    @SucursalPrincipal	int,
    @Factor		float

  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0, @FechaEmision = GETDATE(),
         @Lista = NULLIF(NULLIF(RTRIM(@Lista), ''), '0')
  IF @Lista IS NULL SELECT @Ok = 52020

  EXEC spExtraerFecha @FechaEmision OUTPUT
  SELECT @Moneda = NULLIF(RTRIM(ContMoneda), '') FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
  SELECT @AjusteMov = InvAjuste FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @SucursalPrincipal = Sucursal FROM Version

  DECLARE crAlmacen CURSOR FOR
   SELECT a.Almacen, se.Factor
     FROM Alm a, SalidaEntrada se 
    WHERE a.Sucursal = @SucursalPrincipal OR a.Sucursal IN (SELECT Sucursal FROM Sucursal WHERE SucursalPrincipal = @SucursalPrincipal AND EnLinea = 1)
    ORDER BY se.Factor

  OPEN crAlmacen
  FETCH NEXT FROM crAlmacen INTO @Almacen, @Factor
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spModificarCostoPromedioAlmacen @Empresa, @Usuario, @Lista, @Estacion, @Almacen, @FechaEmision, @AjusteMov, @Moneda, @TipoCambio, @Factor, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    FETCH NEXT FROM crAlmacen INTO @Almacen, @Factor
    IF @@ERROR <> 0 SELECT @Ok = 1
  END
  CLOSE crAlmacen
  DEALLOCATE crAlmacen
  
  IF @Ok IS NULL 
    SELECT @Mensaje = LTRIM(CONVERT(char, @Conteo))+' Ajustes Generados (por Confirmar).<BR><BR>Favor de Afectar Primero las Salidas y Despues las Entradas.'
  ELSE
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

/**************** spMovContratoGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovContratoGenerar') and type = 'P') drop procedure dbo.spMovContratoGenerar
GO             
CREATE PROCEDURE spMovContratoGenerar
			@Accion		char(20),
			@Empresa	char(5),
    			@Sucursal	int,
			@Usuario	char(10),		
    			@Modulo		char(5),
    			@ID		int,
			@Mov		char(20),
			@MovID		varchar(20),
			@FechaRegistro	datetime,
    			@Ok		int		OUTPUT,
    			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DestinoID		int,
    @DestinoMov		char(20),
    @DestinoMovID	varchar(20),
    @Mensaje		varchar(255),
    @VigenciaDesde 	datetime,
    @VigenciaHasta 	datetime,
    @Fecha		datetime,
    @Periodicidad	varchar(50) 

  IF @Accion = 'CANCELAR'
  BEGIN
    IF @Modulo = 'VTAS'
      DECLARE crCancelarContrato CURSOR FOR
       SELECT ID, Mov, MovID
         FROM Venta
        WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
    ELSE
    IF @Modulo = 'GAS'
      DECLARE crCancelarContrato CURSOR FOR
       SELECT ID, Mov, MovID
         FROM Gasto
        WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

    OPEN crCancelarContrato
    FETCH NEXT FROM crCancelarContrato INTO @DestinoID, @DestinoMov, @DestinoMovID
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Modulo = 'VTAS'
          EXEC spInv @DestinoID, @Modulo, 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL, 
                     @DestinoMov, @DestinoMovID OUTPUT, NULL, NULL, 
                     @Ok OUTPUT, @OkRef OUTPUT, NULL
        ELSE
        IF @Modulo = 'GAS'
          EXEC spGasto @DestinoID, @Modulo, 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, 
                       @DestinoMov, @DestinoMovID OUTPUT, NULL, 
                       @Ok OUTPUT, @OkRef OUTPUT
      END
      FETCH NEXT FROM crCancelarContrato INTO @DestinoID, @DestinoMov, @DestinoMovID
    END  -- While
    CLOSE crCancelarContrato
    DEALLOCATE crCancelarContrato
  END ELSE
  BEGIN
    IF @Modulo = 'VTAS' SELECT @Periodicidad = Periodicidad, @VigenciaDesde = VigenciaDesde, @VigenciaHasta = VigenciaHasta FROM Venta WHERE ID = @ID ELSE
    IF @Modulo = 'GAS'  SELECT @Periodicidad = Periodicidad, @VigenciaDesde = VigenciaDesde, @VigenciaHasta = VigenciaHasta FROM Gasto WHERE ID = @ID 

    SELECT @DestinoMov = NULL
    SELECT @DestinoMov = NULLIF(RTRIM(MovDestino), '') FROM EmpresaCfgMovContrato WHERE Empresa = @Empresa AND Modulo = @Modulo AND MovOrigen = @Mov
    IF @DestinoMov IS NULL
      SELECT @Ok = 10026, @OkRef = @Mov

    SELECT @Fecha = @VigenciaDesde
    WHILE @Fecha <= @VigenciaHasta AND @Ok IS NULL
    BEGIN
      IF @Modulo = 'VTAS'
        EXEC spInv @ID, @Modulo, 'GENERAR', 'TODO', @FechaRegistro, @DestinoMov, @Usuario, 1, 0, NULL, 
                   @Mov, @MovID, @DestinoID OUTPUT, NULL, 
                   @Ok OUTPUT, @OkRef OUTPUT, NULL
      ELSE
      IF @Modulo = 'GAS'
        EXEC spGasto @ID, @Modulo, 'GENERAR', 'TODO', @FechaRegistro, @DestinoMov, @Usuario, 1, 0, 
                     @Mov, @MovID, @DestinoID OUTPUT, 
                     @Ok OUTPUT, @OkRef OUTPUT

      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL

      IF @Ok IS NULL AND NULLIF(@DestinoID, 0) IS NOT NULL
      BEGIN
        IF @Modulo = 'VTAS'
        BEGIN
          UPDATE Venta  SET FechaEmision = @Fecha, FechaRequerida = @Fecha WHERE ID = @DestinoID
          UPDATE VentaD SET FechaRequerida = @Fecha WHERE ID = @DestinoID
        END ELSE
        IF @Modulo = 'GAS'
          UPDATE Gasto SET FechaEmision = @Fecha, FechaRequerida = @Fecha WHERE ID = @DestinoID

        IF @Modulo = 'VTAS'
          EXEC spInv @DestinoID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL, 
                     @DestinoMov, @DestinoMovID OUTPUT, NULL, NULL, 
                     @Ok OUTPUT, @OkRef OUTPUT, NULL
        ELSE
        IF @Modulo = 'GAS'
          EXEC spGasto @DestinoID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, 
                       @DestinoMov, @DestinoMovID OUTPUT, NULL, 
                       @Ok OUTPUT, @OkRef OUTPUT
      END

      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      IF @Ok IS NULL 
        EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @DestinoID, @DestinoMov, @DestinoMovID, @Ok OUTPUT

      IF @Ok IS NULL
        EXEC spCalcularPeriodicidad @Fecha, @Periodicidad, @Fecha OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    END
  END

  RETURN
END
GO

/**************** spMovCopiarMeses ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovCopiarMeses') and type = 'P') drop procedure dbo.spMovCopiarMeses
GO             
CREATE PROCEDURE spMovCopiarMeses
		     @Sucursal		int,
		     @Modulo		char(5),
		     @ID		int,
		     @Usuario		char(10),
		     @FechaD		datetime,
		     @FechaA		datetime,
		     @Afectar		bit = 0,
		     @TiempoUnidad	varchar(50) = 'meses',
			 @Ensilencio	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaEmision	datetime,
    @Cuantos		int,
    @Mov		char(20),
    @MovID		varchar(20),
    @ResultadoID	int,
    @ContID		int,
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255),
    @VolverAfectar	bit,
    @FechaRegistro 	datetime,
    @IDGenerar 		int

  SELECT @FechaRegistro = GETDATE(), @VolverAfectar = 0, @Ok = NULL, @Cuantos = 0, @FechaEmision = @FechaD
  WHILE @FechaEmision<=@FechaA AND @Ok IS NULL
  BEGIN
    EXEC @IDGenerar = spMovCopiar @Sucursal, @Modulo, @ID, @Usuario, @FechaEmision, 1, @CopiarSucursalDestino = 1
    IF @IDGenerar IS NOT NULL
    BEGIN
      IF @Afectar = 1 
        EXEC spAfectar @Modulo, @IDGenerar, 'AFECTAR', 'TODO', NULL, @Usuario, 0, @Ensilencio, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL SELECT @Cuantos = @Cuantos + 1

      IF @TiempoUnidad = 'dias'    SELECT @FechaEmision = DATEADD(day, 1, @FechaEmision) ELSE
      IF @TiempoUnidad = 'semanas' SELECT @FechaEmision = DATEADD(week, 1, @FechaEmision) ELSE
      IF @TiempoUnidad = 'años'    SELECT @FechaEmision = DATEADD(year, 1, @FechaEmision)
      ELSE SELECT @FechaEmision = DATEADD(month, 1, @FechaEmision)
    END  -- While	
  END
  IF @Ok IS NULL
    SELECT @Mensaje = RTRIM(Convert(char, @Cuantos))+' Movimientos generados.'
  ELSE
    SELECT @Mensaje = RTRIM(Descripcion)+' '+RTRIM(@OkRef) FROM MensajeLista WHERE Mensaje = @Ok

  IF @Ensilencio = 0
  BEGIN
    SELECT @Mensaje
    RETURN 
  END
  RETURN 
END
GO

/**************** spMovCopiarSucusal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovCopiarSucusal') and type = 'P') drop procedure dbo.spMovCopiarSucusal
GO             
CREATE PROCEDURE spMovCopiarSucusal
		     @Sucursal		int,
		     @Estacion		int,
		     @ID		int,
		     @Usuario		char(10),
		     @FechaTrabajo	datetime,
		     @Afectar		bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cuantos		int,
    @Mov		char(20),
    @MovID		varchar(20),
    @ResultadoID	int,
    @ContID		int,
    @Ok			int,
    @OkRef		varchar(255),
    @VolverAfectar	bit,
    @FechaRegistro 	datetime,
    @EnviarA		int,
    @Clave 		varchar(100),
    @IDGenerar 		int

  SELECT @FechaRegistro = GETDATE(), @VolverAfectar = 0, @Ok = NULL, @Cuantos = 0
  BEGIN TRANSACTION
    DECLARE crListaSt CURSOR FOR
      SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion

    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @Clave
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF dbo.fnEsNumerico(@Clave) = 1 
        BEGIN
          SELECT @EnviarA = CONVERT(int, @Clave)
          EXEC @IDGenerar = spMovCopiar @Sucursal, 'VTAS', @ID, @Usuario, @FechaTrabajo, 1
          IF @IDGenerar IS NOT NULL
          BEGIN
            SELECT @Cuantos = @Cuantos + 1
            UPDATE Venta  SET EnviarA = @EnviarA WHERE ID = @IDGenerar
            UPDATE VentaD SET EnviarA = @EnviarA WHERE ID = @IDGenerar
            IF @Afectar = 1 
              EXEC spInv @IDGenerar, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, NULL,
                         @Mov OUTPUT, @MovID OUTPUT, @ResultadoID OUTPUT, @ContID OUTPUT,
                         @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT
          END
        END
      END

      FETCH NEXT FROM crListaSt INTO @Clave
    END  -- While	
    CLOSE crListaSt
    DEALLOCATE crListaSt
  COMMIT TRANSACTION

  SELECT RTRIM(Convert(char, @Cuantos))+' Movimientos generados.'
  RETURN 
END
GO

/**************** spMovRecurrenteGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovRecurrenteGenerar') and type = 'P') drop procedure dbo.spMovRecurrenteGenerar
GO             
CREATE PROCEDURE spMovRecurrenteGenerar
			@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@Estacion	int,
			@FechaTrabajo	datetime	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Modulo	char(5),
    @ID		int,
    @IDGenerar	int,
    @Ok		int,
    @OkRef	varchar(255),
    @Conteo	int,
    @MovOrigen	char(20),
    @MovDestino	char(20),
    @Mensaje	varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0
  DECLARE crModuloID CURSOR FOR
   SELECT Modulo, ID FROM ListaModuloID WHERE Estacion = @Estacion
  OPEN crModuloID
  FETCH NEXT FROM crModuloID INTO @Modulo, @ID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Modulo = 'VTAS' SELECT @MovOrigen = Mov FROM Venta WHERE ID = @ID ELSE
      IF @Modulo = 'GAS'  SELECT @MovOrigen = Mov FROM Gasto WHERE ID = @ID 

      SELECT @MovDestino = NULL
      SELECT @MovDestino = NULLIF(RTRIM(MovDestino), '') FROM EmpresaCfgMovRecurrente WHERE Empresa = @Empresa AND Modulo = @Modulo AND MovOrigen = @MovOrigen
      IF @MovDestino IS NULL
        SELECT @Ok = 10025, @OkRef = @MovOrigen

      IF @Ok IS NULL
        EXEC @IDGenerar = spAfectar @Modulo, @ID, 'GENERAR', 'TODO', @MovDestino, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

      IF @FechaTrabajo IS NOT NULL
      BEGIN
        IF @Modulo = 'VTAS' UPDATE Venta SET FechaEmision = @FechaTrabajo WHERE ID = @IDGenerar ELSE
        IF @Modulo = 'GAS'  UPDATE Gasto SET FechaEmision = @FechaTrabajo WHERE ID = @IDGenerar 
      END

      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL

      IF @Ok IS NULL AND NULLIF(@IDGenerar, 0) IS NOT NULL
        EXEC spAfectar @Modulo, @IDGenerar, 'AFECTAR', 'TODO', NULL, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      IF @Ok IS NULL SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crModuloID INTO @Modulo, @ID
  END
  CLOSE crModuloID
  DEALLOCATE crModuloID

  IF @Ok IS NULL 
    SELECT @Mensaje = LTRIM(CONVERT(char, @Conteo))+' Movimientos Generados.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

/**************** spMovSituacionLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovSituacionLote') and type = 'P') drop procedure dbo.spMovSituacionLote
GO             
CREATE PROCEDURE spMovSituacionLote		
                    @Estacion	int,
		    @Empresa	char(5),
		    @Modulo	char(5),
		    @Mov	char(20),
		    @Estatus	char(15),
		    @Situacion	varchar(50)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mensaje	varchar(255)

  IF @Modulo = 'DIN' UPDATE Dinero SET Situacion = @Situacion FROM Dinero d, MovLote l WHERE d.Empresa = @Empresa AND d.Mov = @Mov AND d.Estatus = @Estatus AND l.Estacion = @Estacion AND d.MovID = l.MovID ELSE
  IF @Modulo = 'CXC' UPDATE Cxc    SET Situacion = @Situacion FROM Cxc c,    MovLote l WHERE c.Empresa = @Empresa AND c.Mov = @Mov AND c.Estatus = @Estatus AND l.Estacion = @Estacion AND c.MovID = l.MovID ELSE
  IF @Modulo = 'CXP' UPDATE Cxp    SET Situacion = @Situacion FROM Cxp p,    MovLote l WHERE p.Empresa = @Empresa AND p.Mov = @Mov AND p.Estatus = @Estatus AND l.Estacion = @Estacion AND p.MovID = l.MovID 

  SELECT @Mensaje = LTRIM(CONVERT(char, @@ROWCOUNT))+' Movimientos Afectados.'
  SELECT @Mensaje
  RETURN
END
GO

/**************** spNeteo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNeteo') and type = 'P') drop procedure dbo.spNeteo
GO
CREATE PROCEDURE spNeteo
                   @ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @Usuario		char(10),
    @Moneda		char(10),

    @Cliente		char(10),
    @CxcID		int,
    @CxcMov		char(20),
    @CxcMovID		char(20),
    @CxcSaldo		money,
    @CxcNeteoID		int,
    @CxcNeteoMov	char(20),
    @CxcNeteoMovID	varchar(20),

    @Proveedor		char(10),
    @CxpID		int,
    @CxpMov		char(20),
    @CxpMovID		char(20),
    @CxpSaldo		money,
    @CxpNeteoID		int,
    @CxpNeteoMov	char(20),
    @CxpNeteoMovID	varchar(20),

    @Importe		money,
    @FechaRegistro	datetime,
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255)

  SELECT @Moneda = Moneda, @Empresa = Empresa, @Usuario = Usuario, @Cliente = Cliente, @CxcMov = CxcMov, @CxcMovID = CxcMovID, @Proveedor = Proveedor, @CxpMov = CxpMov, @CxpMovID = CxpMovID FROM Neteo WHERE ID = @ID
  SELECT @CxcNeteoMov = CxcNeteo, @CxpNeteoMov = CxpNeteo FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @CxcID = ID, @CxcSaldo = Saldo FROM Cxc WHERE Cliente   = @Cliente   AND Empresa = @Empresa AND Moneda = @Moneda AND Mov = @CxcMov AND MovID = @CxcMovID AND Estatus = 'PENDIENTE'
  SELECT @CxpID = ID, @CxpSaldo = Saldo FROM Cxp WHERE Proveedor = @Proveedor AND Empresa = @Empresa AND Moneda = @Moneda AND Mov = @CxpMov AND MovID = @CxpMovID AND Estatus = 'PENDIENTE'

  IF @CxcSaldo > @CxpSaldo SELECT @Importe = @CxpSaldo ELSE SELECT @Importe = @CxcSaldo 
  SELECT @FechaRegistro = GETDATE()

  IF @CxcID IS NOT NULL AND @CxpID IS NOT NULL 
  BEGIN
    BEGIN TRANSACTION
      EXEC spCx @CxpID, 'CXP', 'GENERAR', 'TODO', @FechaRegistro, @CxpNeteoMov, @Usuario, 1, 0, @CxpNeteoMov OUTPUT, @CxpNeteoMovID OUTPUT, @CxpNeteoID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      IF @Ok IS NULL
      BEGIN
        UPDATE Cxp  SET Importe = @Importe, Impuestos = NULL, Retencion = NULL, Retencion2 = NULL, Retencion3 = NULL, ProveedorMoneda = Moneda, ProveedorTipoCambio = TipoCambio, AplicaManual = 1 WHERE ID = @CxpNeteoID
        UPDATE CxpD SET Importe = @Importe WHERE ID = @CxpNeteoID
        EXEC spCx @CxpNeteoID, 'CXP', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @CxpNeteoMov OUTPUT, @CxpNeteoMovID OUTPUT, @CxpNeteoID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      END
      IF @Ok IS NULL
      BEGIN
        EXEC spCx @CxcID, 'CXC', 'GENERAR', 'TODO', @FechaRegistro, @CxcNeteoMov, @Usuario, 1, 0, @CxcNeteoMov OUTPUT, @CxcNeteoMovID OUTPUT, @CxcNeteoID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
        IF @Ok IS NULL
        BEGIN
          UPDATE Cxc  SET Importe = @Importe, Impuestos = NULL, Retencion = NULL, ClienteMoneda = Moneda, ClienteTipoCambio = TipoCambio, AplicaManual = 1 WHERE ID = @CxcNeteoID
          UPDATE CxcD SET Importe = @Importe WHERE ID = @CxcNeteoID
          EXEC spCx @CxcNeteoID, 'CXC', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @CxcNeteoMov OUTPUT, @CxcNeteoMovID OUTPUT, @CxcNeteoID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        END
      END
     IF @Ok IS NULL
       COMMIT TRANSACTION
     ELSE
       ROLLBACK TRANSACTION
  END
  IF @Ok IS NULL 
    SELECT @Mensaje = 'Neteo Generado por '+CONVERT(varchar, ISNULL(@Importe, 0))+' '+RTRIM(@Moneda)
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

-- spNeteo 8
-- select * from neteo

/**************** spNominaFusionarBorradores ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaFusionarBorradores') and type = 'P') drop procedure dbo.spNominaFusionarBorradores
GO             
CREATE PROCEDURE spNominaFusionarBorradores
                    @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int,
    @Renglon	float

  SELECT @ID = MIN(ID) FROM ListaID WHERE Estacion = @Estacion
  SELECT @Renglon = MAX(Renglon) FROM NominaD WHERE ID = @ID
  UPDATE NominaD SET ID = @ID, @Renglon = Renglon = @Renglon + 1.0 WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion AND ID <> @ID)

  DELETE Nomina  WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion AND ID <> @ID)

  SELECT CONVERT(varchar, COUNT(*))+ ' Movimientos Fusionados.' FROM ListaID WHERE Estacion = @Estacion
  RETURN
END
GO

/**************** spNominaFusionarBorradoresConcentrado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaFusionarBorradoresConcentrado') and type = 'P') drop procedure dbo.spNominaFusionarBorradoresConcentrado
GO             
CREATE PROCEDURE spNominaFusionarBorradoresConcentrado
                    @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int,
    @Renglon	float

  SELECT @Renglon = 0.0
  SELECT @ID = MIN(ID) FROM ListaID WHERE Estacion = @Estacion

  CREATE TABLE #Borrador (
	ID			int		NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Renglon			float		NULL,
	Modulo			char(5)		COLLATE Database_Default NULL,
	Personal		char(10)	COLLATE Database_Default NULL,
	Concepto		varchar(50)	COLLATE Database_Default NULL,
	Cuenta			char(10)	COLLATE Database_Default NULL,
	Referencia 		varchar(50) 	COLLATE Database_Default NULL,
	Beneficiario		varchar(100) 	COLLATE Database_Default NULL,
	FormaPago 		varchar(50) 	COLLATE Database_Default NULL,
	Movimiento		varchar(20)	COLLATE Database_Default NULL,
	ContUso			varchar(20)	COLLATE Database_Default NULL,
	CuentaContable		varchar(20)	COLLATE Database_Default NULL,

	Importe			money		NULL,
	Cantidad		float		NULL)

  SELECT "Renglon" = MIN(Renglon), Concepto
    INTO #Conceptos
    FROM NominaD
   WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
   GROUP BY Concepto
   ORDER BY Concepto

  INSERT #Borrador 
         (Modulo,  Personal,   Concepto,   Cuenta,   Referencia,   Beneficiario,   FormaPago,   Movimiento,   ContUso,   CuentaContable,   Importe,                    Cantidad)
  SELECT d.Modulo, d.Personal, d.Concepto, d.Cuenta, d.Referencia, d.Beneficiario, d.FormaPago, d.Movimiento, d.ContUso, d.CuentaContable, "Importe" = SUM(d.Importe), "Cantidad" = SUM(d.Cantidad) 
    FROM NominaD d
    LEFT OUTER JOIN #Conceptos c ON c.Concepto = d.Concepto
   WHERE d.ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
   GROUP BY d.Modulo,      d.Personal, c.Renglon, d.Concepto, d.Cuenta, d.Referencia, d.Beneficiario, d.FormaPago, d.Movimiento, d.ContUso, d.CuentaContable
   ORDER BY d.Modulo DESC, d.Personal, c.Renglon, d.Concepto, d.Cuenta, d.Referencia, d.Beneficiario, d.FormaPago, d.Movimiento, d.ContUso, d.CuentaContable

  UPDATE #Borrador SET @Renglon = Renglon = ISNULL(Renglon, 0) + @Renglon + 2048.0

  DELETE NominaD WHERE ID = @ID
  INSERT NominaD (ID,  Renglon, Modulo, Personal, Concepto, Cuenta, Referencia, Beneficiario, FormaPago, Movimiento, ContUso, CuentaContable, Importe, Cantidad)
           SELECT @ID, Renglon, Modulo, Personal, Concepto, Cuenta, Referencia, Beneficiario, FormaPago, Movimiento, ContUso, CuentaContable, Importe, Cantidad
            FROM #Borrador
  DELETE NominaD WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion AND ID <> @ID)
  DELETE Nomina  WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion AND ID <> @ID)

  SELECT CONVERT(varchar, COUNT(*))+ ' Movimientos Fusionados.' FROM ListaID WHERE Estacion = @Estacion
  RETURN
END
GO

/**************** spProcesarCB ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProcesarCB') and type = 'P') drop procedure dbo.spProcesarCB
GO             
CREATE PROCEDURE spProcesarCB
                    @Estacion		int,
		    @Empresa		char(5),
		    @Modulo		char(5),
		    @ID			int,
		    @AplicaMov		char(20),
		    @AplicaMovID	varchar(20),
	            @Cliente		char(10),
		    @Localizacion	varchar(20),
                    @ConSeriesLotes	bit
--//WITH ENCRYPTION
AS BEGIN
  EXEC spCBLote @Estacion, @Empresa, @Modulo, @ID, @AplicaMov, @AplicaMovID
  SET nocount ON
  RETURN
END
GO

/**************** spProcesarCBInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProcesarCBInfo') and type = 'P') drop procedure dbo.spProcesarCBInfo
GO             
CREATE PROCEDURE spProcesarCBInfo
                    @Estacion		int,
		    @Empresa		char(5),
		    @Modulo		char(5),
		    @ID			int,
		    @Renglon		float,
		    @RenglonSub		int
--//WITH ENCRYPTION
AS BEGIN
  UPDATE ProcesarCBInfo
     SET Empresa    = @Empresa, 
         Modulo     = @Modulo,
         ID         = @ID,
         Renglon    = @Renglon,
         RenglonSub = @RenglonSub
   WHERE Estacion = @Estacion
  IF @@ROWCOUNT = 0
    INSERT ProcesarCBInfo (Estacion,  Empresa,  Modulo,  ID,  Renglon,  RenglonSub) 
                   VALUES (@Estacion, @Empresa, @Modulo, @ID, @Renglon, @RenglonSub)
  RETURN
END
GO

/**************** spProcesarVentaFM ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProcesarVentaFM') and type = 'P') drop procedure dbo.spProcesarVentaFM
GO             
CREATE PROCEDURE spProcesarVentaFM
                    @Estacion		int,
		    @EnSilencio		bit	 	= 0,
		    @Ok			int	 	= NULL	OUTPUT,
		    @OkRef		varchar(255)	= NULL	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Conteo		int,
    @ID			int,
    @FechaRegistro	datetime,
    @Mensaje		varchar(255),
    @CFDEmpresa         varchar(5),
    @CFDID              int,
    @CFDModulo          varchar(5),
    @FacturaMov         varchar(20),  
    @FacturaMovID       varchar(20),
    @CFDMov             varchar(20),
    @CFDMovID           varchar(20),
    @CFDEstatusNuevo    varchar(15),
    @FacturaEstatus     varchar(15),
    @Empresa            varchar(5)   
    
  DECLARE @TablaCFD table(   
                        Empresa        varchar(5),
                        Modulo         varchar(5),
                        Mov            varchar(20),
                        MovID          varchar(20),
                        ID             int,
                        EstatusNuevo   varchar(15))    

  SELECT @FechaRegistro = GETDATE(), @Conteo = 0
  CREATE TABLE #ProcesarVentaFM(ID int NOT NULL)
  
  

  INSERT #ProcesarVentaFM (ID)
  SELECT ID FROM ListaID WHERE Estacion = @Estacion 
  
  BEGIN TRANSACTION 
    DECLARE crProcesarVentaFM CURSOR LOCAL
        FOR SELECT ID FROM #ProcesarVentaFM
    OPEN crProcesarVentaFM
    FETCH NEXT FROM crProcesarVentaFM INTO @ID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        /*AR 11/09/07 */
        UPDATE Venta SET OrigenTipo = 'VMOS' WHERE ID = @ID
        
       IF EXISTS (SELECT Convert(float, Disponible) FROM Venta v 
                    JOIN VentaD d ON v.ID = d.ID
                    JOIN ArtDisponible a ON d.Articulo = a.Articulo AND ISNULL(d.almacen,v.Almacen) = a.almacen AND v.Empresa = a.Empresa
                   WHERE v.ID = @ID AND a.Disponible < 0)
          SELECT @Ok = 20025      

        IF EXISTS (SELECT v.ID FROM Venta v
                     JOIN VentaD d ON v.ID = d.ID 
                     JOIN SerieLoteMov sm ON sm.Empresa = v.Empresa AND sm.Modulo = 'VTAS' AND sm.ID = d.ID AND d.RenglonID = sm.RenglonID AND d.Articulo = sm.Articulo AND ISNULL(d.SubCuenta,'') = ISNULL(sm.SubCuenta,'')
                     JOIN SerieLote sl ON sl.Sucursal = v.Sucursal AND sl.Empresa = v.Empresa AND sl.Articulo = sm.Articulo AND ISNULL(sl.SubCuenta,'') = ISNULL(sm.SubCuenta,'') AND sl.Serielote = sm.SerieLote AND sl.Almacen = d.Almacen
                    WHERE v.ID = @ID AND Existencia < 0)   
          SELECT @Ok = 20510

        IF @OK IS NULL
  --      EXEC spAfectar 'VTAS', @ID, @EnSilencio = @EnSilencio, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
          EXEC spInv @ID, 'VTAS', 'AFECTAR', 'TODO', @FechaRegistro, NULL, NULL, 1, 0, NULL,
                      NULL, NULL, NULL, NULL,
                      @Ok OUTPUT, @OkRef OUTPUT, 0
        SELECT @Conteo = @Conteo + 1
          IF @Ok IS NULL
          BEGIN
            SELECT @FacturaEstatus = Estatus, @FacturaMov = Mov, @FacturaMovID = MovID, @Empresa = Empresa  FROM Venta WHERE ID = @ID
            INSERT @TablaCFD(Empresa,  ID,         Modulo, Mov,          MovID,         EstatusNuevo)
            SELECT           @Empresa, @ID, 'VTAS', @FacturaMov,  @FacturaMovID, @FacturaEstatus
          END         
       END
      FETCH NEXT FROM crProcesarVentaFM INTO @ID
    END -- While
    CLOSE crProcesarVentaFM
    DEALLOCATE crProcesarVentaFM
  IF @Ok IS NULL
    COMMIT TRANSACTION 
    IF @Ok IS NULL
    BEGIN
      DECLARE crcfd CURSOR LOCAL FOR
       SELECT Empresa,ID,Modulo,Mov,MovID,EstatusNuevo
         FROM @TablaCFD
      OPEN crcfd
      FETCH NEXT FROM crcfd INTO @CFDEmpresa,@CFDID,@CFDModulo,@CFDMov,@CFDMovID,@CFDEstatusNuevo
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        EXEC spCFDFlexAfectarSinMovFinal @CFDEmpresa,@CFDModulo, @CFDMov, @CFDMovID, @CFDID, @CFDEstatusNuevo, NULL, NULL
        SELECT @CFDEmpresa = NULL, @CFDModulo= NULL, @CFDMov= NULL, @CFDMovID= NULL, @CFDID= NULL
        FETCH NEXT FROM crcfd INTO @CFDEmpresa,@CFDID,@CFDModulo,@CFDMov,@CFDMovID,@CFDEstatusNuevo
      END
      CLOSE crcfd
      DEALLOCATE crcfd 
    END     
    
  ELSE
    ROLLBACK TRANSACTION 

  DELETE ListaID WHERE Estacion = @Estacion 

  IF @Ok IS NULL 
    SELECT @Mensaje = CONVERT(varchar, @Conteo)+' Movimientos Procesados.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO


/**************** spProcesarVentaInvD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProcesarVentaInvD') and type = 'P') drop procedure dbo.spProcesarVentaInvD
GO             
CREATE PROCEDURE spProcesarVentaInvD
                    @Estacion		int,
		    @Modulo		char(5),
		    @Accion		char(20)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ID		int,
    @Cuantos	int

  SELECT @Accion = UPPER(@Accion), @Cuantos = 0
  DECLARE crLista CURSOR 
      FOR SELECT ID FROM ListaID WHERE Estacion = @Estacion
  OPEN crLista
  FETCH NEXT FROM crLista INTO @ID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spAfectar @Modulo, @ID, @Accion, 'SELECCION'
      SELECT @Cuantos = @Cuantos + 1
    END
    FETCH NEXT FROM crLista INTO @ID
  END -- While
  CLOSE crLista
  DEALLOCATE crLista

  DELETE ListaID WHERE Estacion = @Estacion
  SELECT RTRIM(Convert(char, @Cuantos))+' Movimiento(s) procesados.'
  RETURN
END
GO

-- spProcesarVentaN 444, 'OMSA', 'Factura', '5/10/05', 'INTELISIS'
-- SELECT DISTINCT FechaEmision FROM Venta v, ListaID l WHERE l.Estacion = 102 AND v.ID = l.ID

--REQ 15448
/************************ spVentasProcesarNCredito  *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spVentasProcesarNCredito') AND type = 'P') DROP PROCEDURE dbo.spVentasProcesarNCredito
GO             
CREATE PROCEDURE spVentasProcesarNCredito
                    @Estacion		int,
		    @Empresa		char(5),
		    @Sucursal           int,
		    @FacturaMov		char(20),
		    @DevolucionMov      char(20),
		    @FechaEmision	datetime,
		    @Usuario		char(10),
		    @Moneda             varchar(10), 
		    @TipoCambio         float, 
		    @AlmacenEncabezado  varchar(10), 
		    @Cliente            varchar(10), 
		    @EnviarA            int, 
		    @Condicion          varchar(50), 
		    @Concepto           varchar(50),
		    @Agente             varchar(10), 
		    @UEN                int,
                    @CfgCosteoSeries	bit,
                    @CfgCosteoLotes	bit,
		    @VentaMultiAlmacen	bit,
		    @VentaEstatus       varchar(15),
		    @CteCNO		char(10) 	= NULL,
		    @EnSilencio		bit	 	= 0,
		    @FacturaFechaEmision datetime,
		     @FacturaFechaEmisionInicio  datetime,
		    @Ok			int	 	= NULL	OUTPUT,
		    @OkRef		varchar(255)	= NULL	OUTPUT
  

            
--//WITH ENCRYPTION             
AS BEGIN
  DECLARE 
    @DevolucionID               int,
    @Renglon                    float,   
    @TipoCosteo			varchar(20),
    @FacturaID			int,
    @FacturaMovID		varchar(20),
    @NotaID			int,
    @AjusteID			int,
    @Cuantas			int,
    @CuantasFacturas		int,
    @Almacen			char(10),
    @Posicion			char(10),
    @ArtTipo			char(20),
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @Unidad			varchar(50),
    @Factor			float,
    @Cantidad			float,
    @CantidadInventario		float,
    @Disponible			float,
    @MonedaCosto		char(10),
    @Costo			float,
    @Precio        		float,
    @PrecioNeto        		float,
    @Proveedor			char(10),
    @DescuentoTipo		char(1),
    @DescuentoLinea		float,
    @DescuentoGlobal		float,
    @SobrePrecio		float,
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @RenglonID			int,
    @FactorCosto		float,
    @TipoCambioCosto		float,
    @ImporteTotal		money,
    @CfgCosteoNivelSubCuenta 	bit,
    @FechaRegistro		datetime,
    @LeyendaEstatus		varchar(50),
    @CerrarSucursalAuto		bit,
    @ArtCostoIdentificado	bit,
    @Accion			char(20),
    @LotesFijos			bit,
    @Lote			varchar(50),
    @RenglonTipo		char(1),
    @PrecioMonedaD		varchar(10),
    @PrecioTipoCambioD	        float,
    @CantidadObsequio	        float,
    @OfertaID	                int,
    @PrecioSugerido	        float,
    @DescuentoImporte	        money,
    @Puntos	                float,
    @Comision	                float,
    @CantidadAjusteLote         float,
    @OrigenID                   int,
    @OrigenRenglon              float,
    @OrigenRenglonSub           int,
    @CfgAnticipoArticuloServicio varchar(20),
    @ArtOfertaFP                varchar(20),
    @ArtOfertaImporte           varchar(20)
--POS
  SELECT @ArtOfertaFP = ArtOfertaFP, @ArtOfertaImporte = ArtOfertaImporte
    FROM POSCfg WHERE Empresa = @Empresa
    
  SELECT @TipoCosteo		  = ISNULL(NULLIF(RTRIM(UPPER(TipoCosteo)), ''), 'PROMEDIO'),
         @CfgCosteoSeries	  = ISNULL(CosteoSeries, 0),
         @CfgCosteoLotes	  = ISNULL(CosteoLotes, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa    
  SELECT @CfgAnticipoArticuloServicio = NULLIF(CxcAnticipoArticuloServicio,'')    FROM EmpresaCfg2
   WHERE Empresa = @Empresa  

  INSERT Venta (Sucursal,  SucursalOrigen, Empresa,  Mov,            FechaEmision,         Moneda,  TipoCambio,  Almacen,            Cliente,  EnviarA,  Condicion,  Concepto,  Usuario,  Estatus,         OrigenTipo, Agente,  UEN,  FormaPagoTipo)
        VALUES (@Sucursal, @Sucursal,      @Empresa, @DevolucionMov, @FacturaFechaEmision, @Moneda, @TipoCambio, @AlmacenEncabezado, @Cliente, @EnviarA, @Condicion, NULL, @Usuario, @VentaEstatus,  'VMOS',      @Agente, @UEN, 'Varios')
  SELECT @DevolucionID = SCOPE_IDENTITY()  

  INSERT VentaProcesarNotas(IDOrigen, ID,            Renglon,   RenglonSub,   Almacen,   Posicion,   Articulo,   SubCuenta,   RenglonTipo,   Unidad,   Impuesto1,               Impuesto2,               Impuesto3,               Cantidad,   CantidadInventario,   DescuentoTipo,              DescuentoLinea,               Precio,               DescuentoGlobal,               SobrePrecio,               MonedaCosto,     Tipo,     CostoIdentificado,     PrecioMoneda,   PrecioTipoCambio,   CantidadObsequio,   OfertaID,   PrecioSugerido,   DescuentoImporte,  Puntos,    Comision)
  SELECT                    v.ID,     @DevolucionID, d.Renglon, d.RenglonSub, d.Almacen, d.Posicion, d.Articulo, d.SubCuenta, d.RenglonTipo, d.Unidad, ISNULL(d.Impuesto1,0.0), ISNULL(d.Impuesto2,0.0), ISNULL(d.Impuesto3,0.0), d.Cantidad, d.CantidadInventario, ISNULL(d.DescuentoTipo,''), ISNULL(d.DescuentoLinea,0.0), ISNULL(d.Precio,0.0), ISNULL(v.DescuentoGlobal,0.0), ISNULL(v.SobrePrecio,0.0), Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision 
    FROM Venta v, VentaD d, ListaID l, Art
   WHERE v.ID = d.ID AND d.ID = l.ID 
     --AND v.FechaEmision = @FacturaFechaEmision
     AND CONVERT(char(10), v.FechaEmision, 121)  BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND   CONVERT(char(10), @FacturaFechaEmision, 121)
     AND l.Estacion = @Estacion
     AND d.ProcesadoID IS NULL
     AND Art.Articulo = d.Articulo
     AND ((d.Cantidad < 0.0) AND d.Articulo NOT IN (@CfgAnticipoArticuloServicio,@ArtOfertaFP,@ArtOfertaImporte ))
     
  GROUP BY v.ID, d.Renglon, d.RenglonSub, d.Almacen, d.Posicion, d.Articulo, Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.SubCuenta, d.RenglonTipo, d.Unidad, d.Impuesto1, d.Impuesto2, d.Impuesto3, d.DescuentoTipo, d.DescuentoLinea, d.Precio, v.DescuentoGlobal, v.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision, d.Cantidad, d.CantidadInventario
  ORDER BY v.ID, d.Renglon, d.RenglonSub, d.Almacen, d.Posicion, d.Articulo, Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.SubCuenta, d.RenglonTipo, d.Unidad, d.Impuesto1, d.Impuesto2, d.Impuesto3, d.DescuentoTipo, d.DescuentoLinea, d.Precio, v.DescuentoGlobal, v.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision, d.Cantidad, d.CantidadInventario

  
  SELECT @Renglon = 0, @RenglonID = 0
  -- Devoluciones
  DECLARE crNotas CURSOR LOCAL FOR 
   SELECT d.Almacen, d.Posicion, d.Articulo, d.SubCuenta, d.RenglonTipo, d.Unidad, ISNULL(ROUND(d.Impuesto1, 4),0.0), ISNULL(ROUND(d.Impuesto2, 4),0.0), ISNULL(ROUND(d.Impuesto3, 4),0.0), SUM(d.Cantidad*-1), SUM(d.CantidadInventario), ISNULL(d.DescuentoTipo,''), ISNULL(d.DescuentoLinea,0.0), ISNULL(d.Precio,0.0), ISNULL(d.DescuentoGlobal,0.0), ISNULL(d.SobrePrecio,0.0), d.MonedaCosto, d.Tipo, d.CostoIdentificado, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision
     FROM VentaProcesarNotas d
    WHERE d.ID  = @DevolucionID
      AND d.IDOrigen IN(SELECT ID FROM ListaID WHERE Estacion = @Estacion)
      AND ((d.Cantidad < 0.0) AND d.Articulo NOT IN (@CfgAnticipoArticuloServicio,@ArtOfertaFP,@ArtOfertaImporte ))
    GROUP BY d.Almacen, d.Posicion, d.Articulo, d.MonedaCosto, d.Tipo, d.CostoIdentificado, d.SubCuenta, d.RenglonTipo, d.Unidad, ROUND(d.Impuesto1, 4), ROUND(d.Impuesto2, 4), ROUND(d.Impuesto3, 4), d.DescuentoTipo, d.DescuentoLinea, d.Precio, d.DescuentoGlobal, d.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision
    ORDER BY d.Almacen, d.Posicion, d.Articulo, d.MonedaCosto, d.Tipo, d.CostoIdentificado, d.SubCuenta, d.RenglonTipo, d.Unidad, ROUND(d.Impuesto1, 4), ROUND(d.Impuesto2, 4), ROUND(d.Impuesto3, 4), d.DescuentoTipo, d.DescuentoLinea, d.Precio, d.DescuentoGlobal, d.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision

  OPEN crNotas
  FETCH NEXT FROM crNotas INTO @Almacen, @Posicion, @Articulo, @SubCuenta, @RenglonTipo, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @Precio, @DescuentoGlobal, @SobrePrecio, @MonedaCosto, @ArtTipo, @ArtCostoIdentificado, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @PrecioNeto = dbo.fnSubTotal(@Precio, @DescuentoGlobal, @SobrePrecio)
      IF @VentaMultiAlmacen = 0 AND @Almacen <> @AlmacenEncabezado SELECT @Ok = 20860, @OkRef = @Almacen
      SELECT @Costo = NULL
      EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0, @Precio = @PrecioNeto
      SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1
      INSERT VentaD (Sucursal,  SucursalOrigen, ID,    Renglon, RenglonSub, RenglonID,  RenglonTipo,  Almacen,  Posicion,  Articulo,  SubCuenta,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,  Cantidad,  CantidadInventario,  DescuentoTipo,  DescuentoLinea,  Precio,      Costo,  UEN,  Agente,  PrecioMoneda,   PrecioTipoCambio,   CantidadObsequio,  OfertaID,  PrecioSugerido,   DescuentoImporte, Puntos,  Comision)
             VALUES (@Sucursal, @Sucursal,      @DevolucionID, @Renglon,         0, @RenglonID, @RenglonTipo, @Almacen, @Posicion, @Articulo, @SubCuenta, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @PrecioNeto, @Costo, @UEN, @Agente, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision)

      IF (@ArtTipo IN ('SERIE', 'VIN') AND (@CfgCosteoSeries = 1 OR @ArtCostoIdentificado = 1)) OR (@ArtTipo IN ('LOTE', 'PARTIDA') AND (@CfgCosteoLotes = 1 OR @ArtCostoIdentificado = 1)) 
      BEGIN
        INSERT SerieLoteMov (Empresa,  Modulo, ID,    RenglonID,  Articulo,  SubCuenta,              SerieLote,   ArtCostoInv,   Cantidad,        CantidadAlterna,        Sucursal, Propiedades)
                      SELECT @Empresa, 'VTAS', @DevolucionID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), s.SerieLote, s.ArtCostoInv, SUM(s.Cantidad), SUM(s.CantidadAlterna), @Sucursal,ISNULL(s.Propiedades, '')
                        FROM SerieLoteMov s, Venta v, VentaD d, ListaID l, Art
                       WHERE v.ID = d.ID AND d.ID = l.ID 
                         --AND v.FechaEmision = @FacturaFechaEmision
                         AND CONVERT(char(10), v.FechaEmision, 121) BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND   CONVERT(char(10), @FacturaFechaEmision, 121)
                         AND l.Estacion = @Estacion
                         AND (d.Cantidad < 0.0 OR d.Articulo NOT IN (@CfgAnticipoArticuloServicio,@ArtOfertaFP,@ArtOfertaImporte )) 
                         AND Art.Articulo = d.Articulo
                         AND s.Empresa = @Empresa AND s.Modulo = 'VTAS' AND s.ID = v.ID AND s.RenglonID = d.RenglonID AND s.Articulo = @Articulo AND ISNULL(s.SubCuenta, '') = ISNULL(@SubCuenta, '') 
                         AND d.Almacen = @Almacen AND ISNULL(d.Posicion, '') = ISNULL(@Posicion, '') AND d.Articulo = @Articulo AND Art.MonedaCosto = @MonedaCosto AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @Unidad AND ISNULL(ROUND(d.Impuesto1, 4),0.0) = @Impuesto1 AND ISNULL(ROUND(d.Impuesto2, 4),0.0) = @Impuesto2 AND ISNULL(ROUND(d.Impuesto3, 4),0.0) = @Impuesto3 AND ISNULL(d.DescuentoTipo,'') = @DescuentoTipo AND ISNULL(d.DescuentoLinea,0.0) = @DescuentoLinea AND ISNULL(d.Precio,0.0) = @Precio AND ISNULL(ROUND(v.DescuentoGlobal, 10),0.0) = ISNULL(ROUND(@DescuentoGlobal, 10),0.0) AND ISNULL(ROUND(v.SobrePrecio, 10),0.0) = ISNULL(ROUND(@SobrePrecio, 10),0.0)
                       GROUP BY s.SerieLote, s.ArtCostoInv, s.Propiedades

        SELECT @Costo = ISNULL(SUM(m.Cantidad*ISNULL(s.CostoPromedio*Mon.TipoCambio, 0.0))/NULLIF(SUM(m.Cantidad), 0.0), 0.0)/@TipoCambio
          FROM SerieLoteMov m, SerieLote s, Art a, Mon
          WHERE m.Empresa = @Empresa AND m.Modulo = 'VTAS' AND m.ID = @DevolucionID AND m.RenglonID = @RenglonID AND m.Articulo = @Articulo AND m.SubCuenta = ISNULL(@SubCuenta, '')
            AND s.Empresa = @Empresa AND s.Articulo = @Articulo AND s.SubCuenta = ISNULL(@SubCuenta, '') AND s.SerieLote = m.SerieLote AND s.Sucursal = @Sucursal AND s.Almacen = @Almacen 
            AND a.Articulo = @Articulo
            AND Mon.Moneda = a.MonedaCosto


        UPDATE SerieLoteMov 
           SET ArtCostoInv = s.CostoPromedio
          FROM SerieLoteMov m, SerieLote s
          WHERE m.Empresa = @Empresa AND m.Modulo = 'VTAS' AND m.ID = @DevolucionID AND m.RenglonID = @RenglonID AND m.Articulo = @Articulo AND m.SubCuenta = ISNULL(@SubCuenta, '')
            AND s.Empresa = @Empresa AND s.Articulo = @Articulo AND s.SubCuenta = ISNULL(@SubCuenta, '') AND s.SerieLote = m.SerieLote AND s.Sucursal = @Sucursal AND s.Almacen = @Almacen

        UPDATE VentaD SET Costo = @Costo WHERE ID = @FacturaID AND Renglon = @Renglon AND RenglonSub = 0
      END


    END
    FETCH NEXT FROM crNotas INTO @Almacen, @Posicion, @Articulo, @SubCuenta, @RenglonTipo, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @Precio, @DescuentoGlobal, @SobrePrecio, @MonedaCosto, @ArtTipo, @ArtCostoIdentificado, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision
  END -- While
  CLOSE crNotas
  DEALLOCATE crNotas
  
  IF @DevolucionID IS NOT NULL
  BEGIN
    INSERT #Devoluciones (ID, FechaEmision) 
    VALUES (@DevolucionID, @FacturaFechaEmision)  
 
    INSERT VentaOrigen (ID, OrigenID, Sucursal, SucursalOrigen)
    SELECT @DevolucionID, v.ID, @Sucursal, @Sucursal 
      FROM Venta v, VentaD d, ListaID l
     WHERE l.Estacion = @Estacion 
       AND v.ID = d.ID 
       AND d.ID = l.ID 
       --AND v.FechaEmision = @FacturaFechaEmision  
       AND CONVERT(char(10), v.FechaEmision, 121)  BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND   CONVERT(char(10), @FacturaFechaEmision, 121)
       AND d.Cantidad <0.0   
  END   

END
GO  


/************************ spVentasProcesarN2  *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spVentasProcesarN2') AND type = 'P') DROP PROCEDURE dbo.spVentasProcesarN2
GO             
CREATE PROCEDURE spVentasProcesarN2
                    @Estacion		int,
		    @Empresa		char(5),
		    @Sucursal           int,
		    @FacturaMov		char(20),
		    @DevolucionMov      char(20),
		    @FechaEmision	datetime,
		    @Usuario		char(10),
		    @Moneda             varchar(10), 
		    @TipoCambio         float, 
		    @AlmacenEncabezado  varchar(10), 
		    @Cliente            varchar(10), 
		    @EnviarA            int, 
		    @Condicion          varchar(50), 
		    @Concepto           varchar(50),
		    @Agente             varchar(10), 
		    @UEN                int,
                    @CfgCosteoSeries	bit,
                    @CfgCosteoLotes	bit,
		    @VentaMultiAlmacen	bit,
		    @VentaEstatus       varchar(15),
		    @CteCNO		char(10) 	= NULL,
		    @EnSilencio		bit	 	= 0,
		    @FacturaFechaEmision datetime,
		    @FacturaFechaEmisionInicio  datetime,
		    @Ok			int	 	= NULL	OUTPUT,
		    @OkRef		varchar(255)	= NULL	OUTPUT
  

            
--//WITH ENCRYPTION             
AS BEGIN
  DECLARE 
    @FacturaID                  int,
    @Renglon                    float,   
    @TipoCosteo			varchar(20),
    @FacturaMovID		varchar(20),
    @NotaID			int,
    @AjusteID			int,
    @Cuantas			int,
    @CuantasFacturas		int,
    @Almacen			char(10),
    @Posicion			char(10),
    @ArtTipo			char(20),
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @Unidad			varchar(50),
    @Factor			float,
    @Cantidad			float,
    @CantidadInventario		float,
    @Disponible			float,
    @MonedaCosto		char(10),
    @Costo			float,
    @Precio        		float,
    @PrecioNeto        		float,
    @Proveedor			char(10),
    @DescuentoTipo		char(1),
    @DescuentoLinea		float,
    @DescuentoGlobal		float,
    @SobrePrecio		float,
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @RenglonID			int,
    @FactorCosto		float,
    @TipoCambioCosto		float,
    @ImporteTotal		money,
    @CfgCosteoNivelSubCuenta 	bit,
    @FechaRegistro		datetime,
    @LeyendaEstatus		varchar(50),
    @CerrarSucursalAuto		bit,
    @ArtCostoIdentificado	bit,
    @Accion			char(20),
    @LotesFijos			bit,
    @Lote			varchar(50),
    @RenglonTipo		char(1),
    @PrecioMonedaD		varchar(10),
    @PrecioTipoCambioD	        float,
    @CantidadObsequio	        float,
    @OfertaID	                int,
    @PrecioSugerido	        float,
    @DescuentoImporte	        money,
    @Puntos	                float,
    @Comision	                float,
    @CantidadAjusteLote         float,
    @OrigenID                   int,
    @OrigenRenglon              float,
    @OrigenRenglonSub           int,
    @CfgAnticipoArticuloServicio varchar(20),
    @ArtOfertaFP                varchar(20),
    @ArtOfertaImporte           varchar(20)



--POS
  SELECT @ArtOfertaFP = ArtOfertaFP, @ArtOfertaImporte = ArtOfertaImporte
    FROM POSCfg WHERE Empresa = @Empresa
    
  SELECT @CfgAnticipoArticuloServicio = NULLIF(CxcAnticipoArticuloServicio,'')    FROM EmpresaCfg2
   WHERE Empresa = @Empresa  
   
  SELECT @TipoCosteo		  = ISNULL(NULLIF(RTRIM(UPPER(TipoCosteo)), ''), 'PROMEDIO'),
         @CfgCosteoSeries	  = ISNULL(CosteoSeries, 0),
         @CfgCosteoLotes	  = ISNULL(CosteoLotes, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa    
  SELECT @CfgAnticipoArticuloServicio = NULLIF(CxcAnticipoArticuloServicio,'')    FROM EmpresaCfg2
   WHERE Empresa = @Empresa     




  INSERT Venta (Sucursal,  SucursalOrigen, Empresa,  Mov,            FechaEmision,         Moneda,  TipoCambio,  Almacen,            Cliente,  EnviarA,  Condicion,  Concepto,  Usuario,  Estatus,         OrigenTipo, Agente,  UEN,  FormaPagoTipo)
        VALUES (@Sucursal, @Sucursal,      @Empresa, @FacturaMov, @FacturaFechaEmision, @Moneda, @TipoCambio, @AlmacenEncabezado, @Cliente, @EnviarA, @Condicion, @Concepto, @Usuario, @VentaEstatus,  'VMOS',      @Agente, @UEN, 'Varios')
  SELECT @FacturaID = SCOPE_IDENTITY()  
  
  INSERT VentaProcesarNotas(IDOrigen, ID        ,  Renglon,   RenglonSub,   Almacen,   Posicion,   Articulo,   SubCuenta,   RenglonTipo,   Unidad,   Impuesto1,               Impuesto2,               Impuesto3,               Cantidad,   CantidadInventario,   DescuentoTipo,              DescuentoLinea,               Precio,               DescuentoGlobal,               SobrePrecio,               MonedaCosto,     Tipo,     CostoIdentificado,     PrecioMoneda,   PrecioTipoCambio,   CantidadObsequio,   OfertaID,   PrecioSugerido,   DescuentoImporte,  Puntos,    Comision)
  SELECT                    v.ID,     @FacturaID, d.Renglon, d.RenglonSub, d.Almacen, d.Posicion, d.Articulo, d.SubCuenta, d.RenglonTipo, d.Unidad, ISNULL(d.Impuesto1,0.0), ISNULL(d.Impuesto2,0.0), ISNULL(d.Impuesto3,0.0), d.Cantidad, d.CantidadInventario, ISNULL(d.DescuentoTipo,''), ISNULL(d.DescuentoLinea,0.0), ISNULL(d.Precio,0.0), ISNULL(v.DescuentoGlobal,0.0), ISNULL(v.SobrePrecio,0.0), Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision 
    FROM Venta v, VentaD d, ListaID l, Art
   WHERE v.ID = d.ID AND d.ID = l.ID 
     --AND v.FechaEmision = @FacturaFechaEmision
     AND CONVERT(char(10), v.FechaEmision, 121)  BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND   CONVERT(char(10), @FacturaFechaEmision, 121)
     AND l.Estacion = @Estacion
     AND Art.Articulo = d.Articulo
     AND (d.Cantidad > 0.0 OR d.Articulo IN (@CfgAnticipoArticuloServicio,@ArtOfertaFP,@ArtOfertaImporte )) 
     AND d.ProcesadoID IS NULL
  GROUP BY v.ID, d.Renglon, d.RenglonSub, d.Almacen, d.Posicion, d.Articulo, Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.SubCuenta, d.RenglonTipo, d.Unidad, d.Impuesto1, d.Impuesto2, d.Impuesto3, d.DescuentoTipo, d.DescuentoLinea, d.Precio, v.DescuentoGlobal, v.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision, d.Cantidad, d.CantidadInventario
  ORDER BY v.ID, d.Renglon, d.RenglonSub, d.Almacen, d.Posicion, d.Articulo, Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.SubCuenta, d.RenglonTipo, d.Unidad, d.Impuesto1, d.Impuesto2, d.Impuesto3, d.DescuentoTipo, d.DescuentoLinea, d.Precio, v.DescuentoGlobal, v.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision, d.Cantidad, d.CantidadInventario
 
  
  SELECT @Renglon = 0, @RenglonID = 0
  DECLARE crNotas CURSOR LOCAL  FOR 
   SELECT d.Almacen, d.Posicion, d.Articulo, d.SubCuenta, d.RenglonTipo, d.Unidad, ISNULL(ROUND(d.Impuesto1, 4),0.0), ISNULL(ROUND(d.Impuesto2, 4),0.0), ISNULL(ROUND(d.Impuesto3, 4),0.0), SUM(d.Cantidad), SUM(d.CantidadInventario), ISNULL(d.DescuentoTipo,''), ISNULL(d.DescuentoLinea,0.0), ISNULL(d.Precio,0.0), ISNULL(d.DescuentoGlobal,0.0), ISNULL(d.SobrePrecio,0.0), d.MonedaCosto, d.Tipo, d.CostoIdentificado, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision
     FROM VentaProcesarNotas d
    WHERE d.ID  = @FacturaID
      AND d.IDOrigen IN(SELECT ID FROM ListaID WHERE Estacion = @Estacion)
      AND (d.Cantidad > 0.0 OR d.Articulo  IN (@CfgAnticipoArticuloServicio,@ArtOfertaFP,@ArtOfertaImporte ))    
      
   GROUP BY d.Almacen, d.Posicion, d.Articulo, d.MonedaCosto, d.Tipo, d.CostoIdentificado, d.SubCuenta, d.Unidad, d.RenglonTipo, ROUND(d.Impuesto1, 4), ROUND(d.Impuesto2, 4), ROUND(d.Impuesto3, 4), d.DescuentoTipo, d.DescuentoLinea, d.Precio, d.DescuentoGlobal, d.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision
   ORDER BY d.Almacen, d.Posicion, d.Articulo, d.MonedaCosto, d.Tipo, d.CostoIdentificado, d.SubCuenta, d.Unidad, d.RenglonTipo, ROUND(d.Impuesto1, 4), ROUND(d.Impuesto2, 4), ROUND(d.Impuesto3, 4), d.DescuentoTipo, d.DescuentoLinea, d.Precio, d.DescuentoGlobal, d.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision
    
  OPEN crNotas
  FETCH NEXT FROM crNotas INTO @Almacen, @Posicion, @Articulo, @SubCuenta, @RenglonTipo, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @Precio, @DescuentoGlobal, @SobrePrecio, @MonedaCosto, @ArtTipo, @ArtCostoIdentificado, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @PrecioNeto = dbo.fnSubTotal(@Precio, @DescuentoGlobal, @SobrePrecio)
      IF @VentaMultiAlmacen = 0 AND @Almacen <> @AlmacenEncabezado SELECT @Ok = 20860, @OkRef = @Almacen
      SELECT @Costo = NULL
      EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0, @Precio = @PrecioNeto
      SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1
      INSERT VentaD (Sucursal,  SucursalOrigen, ID,         Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Almacen,  Posicion,  Articulo,  SubCuenta,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,  Cantidad,  CantidadInventario,  DescuentoTipo,  DescuentoLinea,  Precio,      Costo,  UEN,  Agente, PrecioMoneda, PrecioTipoCambio, CantidadObsequio, OfertaID, PrecioSugerido, DescuentoImporte, Puntos, Comision)
             VALUES (@Sucursal, @Sucursal,      @FacturaID, @Renglon,          0, @RenglonID, @RenglonTipo, @Almacen, @Posicion, @Articulo, @SubCuenta, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @PrecioNeto, @Costo, @UEN, @Agente, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision)
  
      IF (@ArtTipo IN ('SERIE', 'VIN') AND (@CfgCosteoSeries = 1 OR @ArtCostoIdentificado = 1)) OR (@ArtTipo IN ('LOTE', 'PARTIDA') AND (@CfgCosteoLotes = 1 OR @ArtCostoIdentificado = 1)) OR ((SELECT NotasBorrador FROM EmpresaCFG WHERE Empresa = @Empresa) = 1 AND @ArtTipo IN ('SERIE','LOTE'))
        INSERT SerieLoteMov (Empresa,  Modulo, ID,         RenglonID,  Articulo,  SubCuenta,              SerieLote,   ArtCostoInv,  Cantidad,        CantidadAlterna,        Sucursal,  Propiedades)
                      SELECT @Empresa, 'VTAS', @FacturaID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), s.SerieLote, s.ArtCostoInv, SUM(s.Cantidad), SUM(s.CantidadAlterna), @Sucursal,ISNULL(s.Propiedades, '')
                        FROM SerieLoteMov s, Venta v, VentaD d, ListaID l, Art
                       WHERE v.ID = d.ID AND d.ID = l.ID 
                         --AND v.FechaEmision = @FacturaFechaEmision
                         AND CONVERT(char(10), v.FechaEmision, 121)  BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND   CONVERT(char(10), @FacturaFechaEmision, 121)
                         AND l.Estacion = @Estacion
                         AND (d.Cantidad > 0.0 OR d.Articulo IN (@CfgAnticipoArticuloServicio,@ArtOfertaFP,@ArtOfertaImporte )) 
                         AND Art.Articulo = d.Articulo
                         AND s.Empresa = @Empresa AND s.Modulo = 'VTAS' AND s.ID = v.ID AND s.RenglonID = d.RenglonID AND s.Articulo = @Articulo AND ISNULL(s.SubCuenta, '') = ISNULL(@SubCuenta, '') 
                         AND d.Almacen = @Almacen AND ISNULL(d.Posicion, '') = ISNULL(@Posicion, '') AND d.Articulo = @Articulo AND Art.MonedaCosto = @MonedaCosto AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @Unidad AND ISNULL(ROUND(d.Impuesto1, 4),0.0) = @Impuesto1 AND ISNULL(ROUND(d.Impuesto2, 4),0.0) = @Impuesto2 AND ISNULL(ROUND(d.Impuesto3, 4),0.0) = @Impuesto3 AND ISNULL(d.DescuentoTipo,'') = @DescuentoTipo AND ISNULL(d.DescuentoLinea,0.0) = @DescuentoLinea AND ISNULL(d.Precio,0.0) = @Precio AND ISNULL(ROUND(v.DescuentoGlobal, 10),0.0) = ISNULL(ROUND(@DescuentoGlobal, 10),0.0) AND ISNULL(ROUND(v.SobrePrecio, 10),0.0) = ISNULL(ROUND(@SobrePrecio, 10),0.0)
                       GROUP BY s.SerieLote, s.ArtCostoInv, s.Propiedades
    --JGD se igualaron a NULL @DescuentoGlobal y @SobrePrecio
    END
    FETCH NEXT FROM crNotas INTO @Almacen, @Posicion, @Articulo, @SubCuenta, @RenglonTipo, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @Precio, @DescuentoGlobal, @SobrePrecio, @MonedaCosto, @ArtTipo, @ArtCostoIdentificado, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision
  END -- While
  CLOSE crNotas
  DEALLOCATE crNotas
  IF @FacturaID IS NOT NULL
  BEGIN
    INSERT VentaOrigen (ID, OrigenID, Sucursal, SucursalOrigen)
    SELECT @FacturaID, v.ID, @Sucursal, @Sucursal 
      FROM Venta v, VentaD d, ListaID l
     WHERE l.Estacion = @Estacion 
       AND v.ID = d.ID 
       AND d.ID = l.ID 
       --AND v.FechaEmision = @FacturaFechaEmision  
       AND CONVERT(char(10), v.FechaEmision, 121)  BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND  CONVERT(char(10), @FacturaFechaEmision, 121) 
       AND d.Cantidad >0.0  
    INSERT #Facturas (ID, FechaEmision) VALUES (@FacturaID, @FacturaFechaEmision)
  END  
 
END
GO  



/**************** spProcesarVentaN ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProcesarVentaN') and type = 'P') drop procedure dbo.spProcesarVentaN
GO             
CREATE PROCEDURE spProcesarVentaN
                    @Estacion		int,
		    @Empresa		char(5),
		    @FacturaMov		char(20),
		    @FechaEmision	datetime,
		    @Usuario		char(10),
		    @CteCNO		char(10) 	= NULL,
		    @EnSilencio		bit	 	= 0,
		    @Ok			int	 	= NULL	OUTPUT,
		    @OkRef		varchar(255)	= NULL	OUTPUT,
		    @DevolucionMov	char(20)        = NULL,
		    @Sucursal           int             = NULL

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @TipoCosteo			varchar(20),
    @VentaMultiAlmacen		bit,
    @FacturaID			int,
    @FacturaFechaEmision	datetime,
    @FacturaMovID		varchar(20),
    @NotaID			int,
    @AjusteID			int,
    @Cuantas			int,
    @CuantasFacturas		int,
    @CuantasDevoluciones	int,
    @Cliente			char(10),
    @EnviarA			int,
    @ClienteVMOS		char(10),
    @VentaEstatus		char(15),
    @EstatusVMOS		char(15),
    @AlmacenEncabezado		char(10),
    @Almacen			char(10),
    @Posicion			char(10),
    @ArtTipo			char(20),
    @Moneda			char(10),
    @TipoCambio			float,
    @Concepto			varchar(50),
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @Unidad			varchar(50),
    @Factor			float,
    @Cantidad			float,
    @CantidadInventario		float,
    @Disponible			float,
    @MonedaCosto		char(10),
    @Costo			float,
    @Precio        		float,
    @PrecioNeto        		float,
    @Proveedor			char(10),
    @DescuentoTipo		char(1),
    @DescuentoLinea		float,
    @DescuentoGlobal		float,
    @SobrePrecio		float,
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @Renglon			float,
    @RenglonID			int,
    @FactorCosto		float,
    @TipoCambioCosto		float,
    @ImporteTotal		money,
    @Agente			char(10),
    @UEN			int,
    @CfgCosteoNivelSubCuenta 	bit,
    @AjusteMov			char(20),
    @AjusteMovID		varchar(20),
    @Condicion			varchar(50),
    @FechaRegistro		datetime,
    @LeyendaEstatus		varchar(50),
    @CerrarSucursalAuto		bit,
    @CfgCosteoSeries		bit,
    @CfgCosteoLotes		bit,
    @ArtCostoIdentificado	bit,
    @SeriesLotesAutoOrden	varchar(20), 
    @AsignarConsecutivo		bit,
    @Accion			char(20),
    @LotesFijos			bit,
    @Lote			varchar(50),
    @RenglonTipo		char(1),
    @PrecioMonedaD		varchar(10),
    @PrecioTipoCambioD	        float,
--JGD 19Abril2011. Ticket 4390 Uso de Variables para pasar la Información de las Ofertas aplicadas a las Notas, hacia la Factura generada
    @CantidadObsequio	        float,
    @OfertaID	                int,
    @PrecioSugerido	        float,
    @DescuentoImporte	        money,
    @Puntos	                float,
    @Comision	                float,
    @CantidadAjusteLote         float,--Fin JGD 19Abril2011. Ticket 4390
    @GenerarNCAlProcesar        bit ,
    @DevolucionID               int ,
    @DevolucionMovID            varchar(20),
    @CfgAnticipoArticuloServicio varchar(20),
    @ArtOfertaFP                varchar(20),
    @ArtOfertaImporte           varchar(20),
    @CFDEmpresa                 varchar(5),
    @CFDID                      int,
    @CFDModulo                  varchar(5),
    @CFDMov                     varchar(20),
    @CFDMovID                   varchar(20),
    @CFDEstatusNuevo            varchar(15),
    @FacturaEstatus             varchar(15),
    @DevolucionEstatus          varchar(15),
    @FacturaGlobalPeriodo   bit,
    @FacturaFechaEmisionInicio datetime,
    @ZonaImpuesto				varchar(20),
    @ContUso					varchar(20),
    @ContUso2					varchar(20),
    @ContUso3					varchar(20),
    @SerieLote					varchar(50),
    @ListaID					int,
    @ExisteSerieLote			bit,
	@ArtRedondeo				varchar(20)
    
  DECLARE @TablaCFD table(   
                        Empresa        varchar(5),
                        Modulo         varchar(5),
                        Mov            varchar(20),
                        MovID          varchar(20),
                        ID             int,
                        EstatusNuevo   varchar(15))          
                              
--23063

  SELECT @ArtRedondeo = Articulo
    FROM Art 
   WHERE Articulo = (SELECT RedondeoVentaCodigo FROM POSCfg WHERE Empresa = @Empresa)

 SET @FacturaGlobalPeriodo=0 
  IF NOT EXISTS(SELECT * FROM ListaID WHERE Estacion = @Estacion) OR ((SELECT Clave FROM MovTipo WHERE Modulo = 'VTAS' AND Mov = @FacturaMov) <> 'VTAS.F')
  BEGIN
    SELECT NULL
    RETURN
  END
  
--POS
  SELECT @ArtOfertaFP = ArtOfertaFP, @ArtOfertaImporte = ArtOfertaImporte
    FROM POSCfg WHERE Empresa = @Empresa
    
  SELECT @CfgAnticipoArticuloServicio = NULLIF(CxcAnticipoArticuloServicio,'')    FROM EmpresaCfg2
   WHERE Empresa = @Empresa  
          
 

  SELECT @EnviarA = NULL, @NotaID = NULL, @AjusteID = NULL, @ImporteTotal = 0.0, @Condicion = NULL, @FacturaMovID = NULL,
         @FechaRegistro = GETDATE(), @LeyendaEstatus = '', @Agente = NULL, @UEN = NULL, @Proveedor = NULL, @CuantasFacturas = 0

  SELECT @AjusteMov = InvAjuste
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @CfgCosteoNivelSubCuenta = CosteoNivelSubCuenta,
         @ClienteVMOS             = NULLIF(RTRIM(ClienteFacturaVMOS), ''),
         @EstatusVMOS             = ISNULL(NULLIF(RTRIM(EstatusFacturaVMOS), ''), 'BORRADOR'),
         @AsignarConsecutivo      = ISNULL(AsignarConsecutivoFacturaVMOS, 0),
         @TipoCosteo		  = ISNULL(NULLIF(RTRIM(UPPER(TipoCosteo)), ''), 'PROMEDIO'),
         @CfgCosteoSeries	  = ISNULL(CosteoSeries, 0),
         @CfgCosteoLotes	  = ISNULL(CosteoLotes, 0),
	 @SeriesLotesAutoOrden    = UPPER(SeriesLotesAutoOrden),
	 @GenerarNCAlProcesar    = ISNULL(GenerarNCAlProcesar, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  --IF @CteCNO IS NULL SELECT @EstatusVMOS = 'BORRADOR'

  SELECT @VentaEstatus = @EstatusVMOS
  IF @EstatusVMOS = 'CONCLUIDO'  SELECT @VentaEstatus = 'BORRADOR'

  IF @VentaEstatus = 'BORRADOR'   SELECT @LeyendaEstatus = ' (Borrador)'      ELSE
  IF @VentaEstatus = 'CONFIRMAR'  SELECT @LeyendaEstatus = ' (por Confirmar)' ELSE
  IF @VentaEstatus = 'SINAFECTAR' SELECT @LeyendaEstatus = ' (Sin Afectar)'  

  SELECT @VentaMultiAlmacen = VentaMultiAlmacen
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa
  IF @Sucursal IS NULL
    SELECT @Sucursal = Sucursal FROM UsuarioSucursal WHERE Usuario = @Usuario
    
  SELECT @CerrarSucursalAuto = CerrarSucursalAuto FROM EmpresaGral WHERE Empresa = @Empresa

  EXEC spExtraerFecha @FechaEmision OUTPUT

  DECLARE crLista CURSOR 
      FOR SELECT ID FROM ListaID WHERE Estacion = @Estacion
  OPEN crLista
  FETCH NEXT FROM crLista INTO @NotaID
  CLOSE crLista
  DEALLOCATE crLista
  IF @NotaID IS NULL 
  BEGIN
    SELECT @Ok = 10160
    IF @EnSilencio = 1 RETURN
  END

  IF EXISTS(SELECT * FROM Inv WHERE Empresa = @Empresa AND Estatus = 'CONFIRMAR' AND OrigenTipo = 'VMOS' AND Sucursal = @Sucursal)
  BEGIN
    SELECT @Ok = 10170
    IF @EnSilencio = 1 RETURN
  END

  SELECT @ImporteTotal = SUM(ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0))
    FROM Venta v, ListaID l
   WHERE v.ID = l.ID
     AND l.Estacion = @Estacion

  IF @ImporteTotal < 0.0 AND @GenerarNCAlProcesar = 0
  BEGIN
    SELECT @Ok = 10180
    IF @EnSilencio = 1 RETURN
  END

  SELECT @AlmacenEncabezado = Almacen, 
         @Cliente = ISNULL(@CteCNO, ISNULL(@ClienteVMOS, Cliente)), 
         @Moneda = Moneda, 
         @TipoCambio = TipoCambio, 
         @Concepto = Concepto, 
         @ZonaImpuesto=ZonaImpuesto
    FROM Venta 
   WHERE ID = @NotaID

  IF @CteCNO IS NOT NULL
  BEGIN
    SELECT @Cliente = ISNULL(NULLIF(RTRIM(FacturarCte), ''), Cliente),
           @EnviarA = FacturarCteEnviarA,
           @Condicion = Condicion,	
           @Agente = Agente
      FROM Cte
     WHERE Cliente = @CteCNO
     SELECT @UEN = UEN FROM Usuario WHERE Usuario = @Usuario
  END
--23063
SELECT  @FacturaGlobalPeriodo=FacturaGlobalPeriodo FROM Empresacfg where Empresa=@Empresa 

  CREATE TABLE #Facturas (ID int NULL, FechaEmision datetime NULL)
  CREATE TABLE #Devoluciones (ID int NULL, FechaEmision datetime NULL) 
  BEGIN TRANSACTION
    DECLARE crFechaEmision CURSOR LOCAL FOR
    SELECT DISTINCT CASE WHEN @FacturaGlobalPeriodo=1 THEN ( CASE WHEN Month(FechaEmision)=MONTH( GETDATE ()) THEN GETDATE() ELSE (dateadd(day,-1,left(convert(varchar(8),dateadd(month,1,FechaEmision),112),6)+'01')) END ) ELSE FechaEmision END, Sucursal
     --SELECT DISTINCT FechaEmision, Sucursal
       FROM Venta v, ListaID l
      WHERE l.Estacion = @Estacion AND v.ID = l.ID
    OPEN crFechaEmision
    FETCH NEXT FROM crFechaEmision INTO @FacturaFechaEmision, @Sucursal
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
	  IF @FacturaGlobalPeriodo =1
		SET @FacturaFechaEmisionInicio=CAST( '01' + '/' + CAST(Month(@FacturaFechaEmision)as  varchar) + '/' + CAST( YEAR(@FacturaFechaEmision) as varchar)  AS DATETIME)
	  ELSE 
		SET @FacturaFechaEmisionInicio=@FacturaFechaEmision
		
      IF @GenerarNCAlProcesar = 0
      BEGIN

        INSERT Venta (Sucursal,  SucursalOrigen, Empresa,  Mov,         FechaEmision,         Moneda,  TipoCambio,  Almacen,            Cliente,  EnviarA,  Condicion,  Concepto,  Usuario,  Estatus,       OrigenTipo, Agente,  UEN, FormaPagoTipo,ZonaImpuesto )
              VALUES (@Sucursal, @Sucursal,      @Empresa, @FacturaMov, @FacturaFechaEmision, @Moneda, @TipoCambio, @AlmacenEncabezado, @Cliente, @EnviarA, @Condicion, @Concepto, @Usuario, @VentaEstatus, 'VMOS',     @Agente, @UEN, 'Varios',@ZonaImpuesto)
        SELECT @FacturaID = SCOPE_IDENTITY()
  
        SELECT @Renglon = 0, @RenglonID = 0
        -- Devoluciones
        DECLARE crNotas CURSOR LOCAL
            FOR SELECT d.Almacen, d.Posicion, d.Articulo, d.SubCuenta, d.RenglonTipo, d.Unidad, ISNULL(ROUND(d.Impuesto1, 4),0.0), ISNULL(ROUND(d.Impuesto2, 4),0.0), ISNULL(ROUND(d.Impuesto3, 4),0.0), SUM(d.Cantidad), SUM(d.CantidadInventario), ISNULL(d.DescuentoTipo,''), ISNULL(d.DescuentoLinea,0.0), ISNULL(d.Precio,0.0), ISNULL(v.DescuentoGlobal,0.0), ISNULL(v.SobrePrecio,0.0), Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision
                  FROM Venta v, VentaD d, ListaID l, Art
                 WHERE v.ID = d.ID AND d.ID = l.ID 
                   AND CONVERT(char(10), v.FechaEmision, 121)  BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND   CONVERT(char(10), @FacturaFechaEmision, 121)
                   --AND v.FechaEmision = @FacturaFechaEmision
                   AND l.Estacion = @Estacion
                   AND d.Cantidad < 0.0
                   AND Art.Articulo = d.Articulo
				   AND d.Articulo <> @ArtRedondeo
                 GROUP BY d.Almacen, d.Posicion, d.Articulo, Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.SubCuenta, d.RenglonTipo, d.Unidad, ROUND(d.Impuesto1, 4), ROUND(d.Impuesto2, 4), ROUND(d.Impuesto3, 4), d.DescuentoTipo, d.DescuentoLinea, d.Precio, v.DescuentoGlobal, v.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision
                 ORDER BY d.Almacen, d.Posicion, d.Articulo, Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.SubCuenta, d.RenglonTipo, d.Unidad, ROUND(d.Impuesto1, 4), ROUND(d.Impuesto2, 4), ROUND(d.Impuesto3, 4), d.DescuentoTipo, d.DescuentoLinea, d.Precio, v.DescuentoGlobal, v.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision
    
        OPEN crNotas
        FETCH NEXT FROM crNotas INTO @Almacen, @Posicion, @Articulo, @SubCuenta, @RenglonTipo, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @Precio, @DescuentoGlobal, @SobrePrecio, @MonedaCosto, @ArtTipo, @ArtCostoIdentificado, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            SELECT @PrecioNeto = dbo.fnSubTotal(@Precio, @DescuentoGlobal, @SobrePrecio)
            IF @VentaMultiAlmacen = 0 AND @Almacen <> @AlmacenEncabezado SELECT @Ok = 20860, @OkRef = @Almacen
            SELECT @Costo = NULL
            EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0, @Precio = @PrecioNeto
            SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1
            INSERT VentaD (Sucursal,  SucursalOrigen, ID,         Renglon, RenglonSub, RenglonID,  RenglonTipo,  Almacen,  Posicion,  Articulo,  SubCuenta,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,  Cantidad,  CantidadInventario,  DescuentoTipo,  DescuentoLinea,  Precio,      Costo,  UEN,  Agente, PrecioMoneda, PrecioTipoCambio, CantidadObsequio, OfertaID, PrecioSugerido, DescuentoImporte, Puntos, Comision)
                   VALUES (@Sucursal, @Sucursal,      @FacturaID, @Renglon,         0, @RenglonID, @RenglonTipo, @Almacen, @Posicion, @Articulo, @SubCuenta, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @PrecioNeto, @Costo, @UEN, @Agente, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision)
    
            IF (@ArtTipo IN ('SERIE', 'VIN') AND (@CfgCosteoSeries = 1 OR @ArtCostoIdentificado = 1)) OR (@ArtTipo IN ('LOTE', 'PARTIDA') AND (@CfgCosteoLotes = 1 OR @ArtCostoIdentificado = 1)) 
            BEGIN
              INSERT SerieLoteMov (Empresa,  Modulo, ID,         RenglonID,  Articulo,  SubCuenta,              SerieLote,   ArtCostoInv,   Cantidad,        CantidadAlterna,        Sucursal, Propiedades)
                            SELECT @Empresa, 'VTAS', @FacturaID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), s.SerieLote, s.ArtCostoInv, SUM(s.Cantidad), SUM(s.CantidadAlterna), @Sucursal,ISNULL(s.Propiedades, '')
                              FROM SerieLoteMov s, Venta v, VentaD d, ListaID l, Art
                             WHERE v.ID = d.ID AND d.ID = l.ID 
                               AND CONVERT(char(10), v.FechaEmision, 121)  BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND   CONVERT(char(10), @FacturaFechaEmision, 121)
                               --AND v.FechaEmision = @FacturaFechaEmision
                               AND l.Estacion = @Estacion
                               AND d.Cantidad < 0.0
                               AND Art.Articulo = d.Articulo
                               AND s.Empresa = @Empresa AND s.Modulo = 'VTAS' AND s.ID = v.ID AND s.RenglonID = d.RenglonID AND s.Articulo = @Articulo AND ISNULL(s.SubCuenta, '') = ISNULL(@SubCuenta, '') 
                               AND d.Almacen = @Almacen AND ISNULL(d.Posicion, '') = ISNULL(@Posicion, '') AND d.Articulo = @Articulo AND Art.MonedaCosto = @MonedaCosto AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @Unidad AND ISNULL(ROUND(d.Impuesto1, 4),0.0) = @Impuesto1 AND ISNULL(ROUND(d.Impuesto2, 4),0.0) = @Impuesto2 AND ISNULL(ROUND(d.Impuesto3, 4),0.0) = @Impuesto3 AND ISNULL(d.DescuentoTipo,'') = @DescuentoTipo AND ISNULL(d.DescuentoLinea,0.0) = @DescuentoLinea AND ISNULL(d.Precio,0.0) = @Precio AND ISNULL(ROUND(v.DescuentoGlobal, 10),0.0) = ISNULL(ROUND(@DescuentoGlobal, 10),0.0) AND ISNULL(ROUND(v.SobrePrecio, 10),0.0) = ISNULL(ROUND(@SobrePrecio, 10),0.0)
                             GROUP BY s.SerieLote, s.ArtCostoInv, s.Propiedades
                     
              --JGD se igualaron a NULL @DescuentoGlobal y @SobrePrecio
              SELECT @Costo = ISNULL(SUM(m.Cantidad*ISNULL(s.CostoPromedio*Mon.TipoCambio, 0.0))/NULLIF(SUM(m.Cantidad), 0.0), 0.0)/@TipoCambio
                FROM SerieLoteMov m, SerieLote s, Art a, Mon
                WHERE m.Empresa = @Empresa AND m.Modulo = 'VTAS' AND m.ID = @FacturaID AND m.RenglonID = @RenglonID AND m.Articulo = @Articulo AND m.SubCuenta = ISNULL(@SubCuenta, '')
                  AND s.Empresa = @Empresa AND s.Articulo = @Articulo AND s.SubCuenta = ISNULL(@SubCuenta, '') AND s.SerieLote = m.SerieLote AND s.Sucursal = @Sucursal AND s.Almacen = @Almacen 
                  AND a.Articulo = @Articulo
                  AND Mon.Moneda = a.MonedaCosto
    
		    -- Esto sirve para ponerle costo a ArtCostoInv
              UPDATE SerieLoteMov 
                 SET ArtCostoInv = s.CostoPromedio
                FROM SerieLoteMov m, SerieLote s
                WHERE m.Empresa = @Empresa AND m.Modulo = 'VTAS' AND m.ID = @FacturaID AND m.RenglonID = @RenglonID AND m.Articulo = @Articulo AND m.SubCuenta = ISNULL(@SubCuenta, '')
                  AND s.Empresa = @Empresa AND s.Articulo = @Articulo AND s.SubCuenta = ISNULL(@SubCuenta, '') AND s.SerieLote = m.SerieLote AND s.Sucursal = @Sucursal AND s.Almacen = @Almacen
    
              UPDATE VentaD SET Costo = @Costo WHERE ID = @FacturaID AND Renglon = @Renglon AND RenglonSub = 0
            END
          END
          FETCH NEXT FROM crNotas INTO @Almacen, @Posicion, @Articulo, @SubCuenta, @RenglonTipo, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @Precio, @DescuentoGlobal, @SobrePrecio, @MonedaCosto, @ArtTipo, @ArtCostoIdentificado, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision
        END -- While
        CLOSE crNotas
        DEALLOCATE crNotas
        -- Ventas
        DECLARE crNotas CURSOR LOCAL
            FOR SELECT d.Almacen, d.Posicion, d.Articulo, d.SubCuenta, d.RenglonTipo, d.Unidad, ISNULL(ROUND(d.Impuesto1, 4),0.0), ISNULL(ROUND(d.Impuesto2, 4),0.0), ISNULL(ROUND(d.Impuesto3, 4),0.0), SUM(d.Cantidad), SUM(d.CantidadInventario), ISNULL(d.DescuentoTipo,''), ISNULL(d.DescuentoLinea,0.0), ISNULL(d.Precio,0.0), ISNULL(v.DescuentoGlobal,0.0), ISNULL(v.SobrePrecio,0.0), Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision,d.ContUso,d.ContUso2,d.ContUso3, l.ID
                  FROM Venta v, VentaD d, ListaID l, Art
                 WHERE v.ID = d.ID AND d.ID = l.ID 
                   AND CONVERT(char(10), v.FechaEmision, 121)  BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND   CONVERT(char(10), @FacturaFechaEmision, 121)
                  --AND v.FechaEmision = @FacturaFechaEmision
                   AND l.Estacion = @Estacion
                   AND d.Cantidad > 0.0
                   AND Art.Articulo = d.Articulo
				   AND d.Articulo <> @ArtRedondeo
                 GROUP BY d.Almacen, d.Posicion, d.Articulo, Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.SubCuenta, d.Unidad, d.RenglonTipo, ROUND(d.Impuesto1, 4), ROUND(d.Impuesto2, 4), ROUND(d.Impuesto3, 4), d.DescuentoTipo, d.DescuentoLinea, d.Precio, v.DescuentoGlobal, v.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision,d.ContUso,d.ContUso2,d.ContUso3, l.ID
                 ORDER BY d.Almacen, d.Posicion, d.Articulo, Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.SubCuenta, d.Unidad, d.RenglonTipo, ROUND(d.Impuesto1, 4), ROUND(d.Impuesto2, 4), ROUND(d.Impuesto3, 4), d.DescuentoTipo, d.DescuentoLinea, d.Precio, v.DescuentoGlobal, v.SobrePrecio, d.PrecioMoneda, d.PrecioTipoCambio, d.CantidadObsequio, d.OfertaID, d.PrecioSugerido, d.DescuentoImporte, d.Puntos, d.Comision,d.ContUso,d.ContUso2,d.ContUso3, l.ID
    
        OPEN crNotas
        FETCH NEXT FROM crNotas INTO @Almacen, @Posicion, @Articulo, @SubCuenta, @RenglonTipo, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @Precio, @DescuentoGlobal, @SobrePrecio, @MonedaCosto, @ArtTipo, @ArtCostoIdentificado, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision,@ContUso,@ContUso2,@ContUso3, @ListaID
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            SELECT @PrecioNeto = dbo.fnSubTotal(@Precio, @DescuentoGlobal, @SobrePrecio)
            IF @VentaMultiAlmacen = 0 AND @Almacen <> @AlmacenEncabezado SELECT @Ok = 20860, @OkRef = @Almacen
            SELECT @Costo = NULL
            EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0, @Precio = @PrecioNeto
            SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1
            INSERT VentaD (Sucursal,  SucursalOrigen, ID,         Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Almacen,  Posicion,  Articulo,  SubCuenta,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,  Cantidad,  CantidadInventario,  DescuentoTipo,  DescuentoLinea,  Precio,      Costo,  UEN,  Agente, PrecioMoneda, PrecioTipoCambio, CantidadObsequio, OfertaID, PrecioSugerido, DescuentoImporte, Puntos, Comision,ContUso,ContUso2,ContUso3)
                   VALUES (@Sucursal, @Sucursal,      @FacturaID, @Renglon,          0, @RenglonID, @RenglonTipo, @Almacen, @Posicion, @Articulo, @SubCuenta, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @PrecioNeto, @Costo, @UEN, @Agente, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision,@ContUso,@ContUso2,@ContUso3)

			IF (SELECT NotasBorrador FROM EmpresaCFG WHERE Empresa = @Empresa) = 0 BEGIN
			  SELECT @SerieLote = SerieLote
			    FROM SerieLoteMov
  		       WHERE ID = @ListaID 
			     AND Empresa = @Empresa 
			     AND Sucursal = @Sucursal
			     AND Modulo = 'VTAS' 
			     AND Articulo = @Articulo 
			     AND ISNULL(Subcuenta, '') = ISNULL(@SubCuenta, '') 

			  SELECT @ExisteSerieLote = 0
			  IF EXISTS(SELECT SerieLote FROM SerieLote WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Almacen = @Almacen AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND SerieLote = @SerieLote)
			    SELECT @ExisteSerieLote = 1
			END
    
            IF (@ArtTipo IN ('SERIE', 'VIN') AND (@CfgCosteoSeries = 1 OR @ArtCostoIdentificado = 1)) OR 
               (@ArtTipo IN ('LOTE', 'PARTIDA') AND (@CfgCosteoLotes = 1 OR @ArtCostoIdentificado = 1)) OR 
               ((SELECT NotasBorrador FROM EmpresaCFG WHERE Empresa = @Empresa) = 1 AND @ArtTipo IN ('SERIE','LOTE')) OR
               ((SELECT NotasBorrador FROM EmpresaCFG WHERE Empresa = @Empresa) = 0 AND @ArtTipo IN ('SERIE','LOTE') AND @ExisteSerieLote = 1)
              INSERT SerieLoteMov (Empresa,  Modulo, ID,         RenglonID,  Articulo,  SubCuenta,              SerieLote,   ArtCostoInv,  Cantidad,        CantidadAlterna,        Sucursal,  Propiedades)
                            SELECT @Empresa, 'VTAS', @FacturaID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), s.SerieLote, s.ArtCostoInv, SUM(s.Cantidad), SUM(s.CantidadAlterna), @Sucursal,ISNULL(s.Propiedades, '')
                              FROM SerieLoteMov s, Venta v, VentaD d, ListaID l, Art
                             WHERE v.ID = d.ID AND d.ID = l.ID 
                               AND CONVERT(char(10), v.FechaEmision, 121)  BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND   CONVERT(char(10), @FacturaFechaEmision, 121)
                               --AND v.FechaEmision = @FacturaFechaEmision
                               AND l.Estacion = @Estacion
                               AND d.Cantidad > 0.0
                               AND Art.Articulo = d.Articulo
                               AND s.Empresa = @Empresa AND s.Modulo = 'VTAS' AND s.ID = v.ID AND s.RenglonID = d.RenglonID AND s.Articulo = @Articulo AND ISNULL(s.SubCuenta, '') = ISNULL(@SubCuenta, '') 
                               AND d.Almacen = @Almacen AND ISNULL(d.Posicion, '') = ISNULL(@Posicion, '') AND d.Articulo = @Articulo AND Art.MonedaCosto = @MonedaCosto AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @Unidad AND ISNULL(ROUND(d.Impuesto1, 4),0.0) = @Impuesto1 AND ISNULL(ROUND(d.Impuesto2, 4),0.0) = @Impuesto2 AND ISNULL(ROUND(d.Impuesto3, 4),0.0) = @Impuesto3 AND ISNULL(d.DescuentoTipo,'') = @DescuentoTipo AND ISNULL(d.DescuentoLinea,0.0) = @DescuentoLinea AND ISNULL(d.Precio,0.0) = @Precio AND ISNULL(ROUND(v.DescuentoGlobal, 10),0.0) = ISNULL(ROUND(@DescuentoGlobal, 10),0.0) AND ISNULL(ROUND(v.SobrePrecio, 10),0.0) = ISNULL(ROUND(@SobrePrecio, 10),0.0)
                             GROUP BY s.SerieLote, s.ArtCostoInv, s.Propiedades
          --JGD se igualaron a NULL @DescuentoGlobal y @SobrePrecio
          END
          FETCH NEXT FROM crNotas INTO @Almacen, @Posicion, @Articulo, @SubCuenta, @RenglonTipo, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @Precio, @DescuentoGlobal, @SobrePrecio, @MonedaCosto, @ArtTipo, @ArtCostoIdentificado, @PrecioMonedaD, @PrecioTipoCambioD, @CantidadObsequio, @OfertaID, @PrecioSugerido, @DescuentoImporte, @Puntos, @Comision,@ContUso,@ContUso2,@ContUso3, @ListaID
        END -- While
        CLOSE crNotas
        DEALLOCATE crNotas
    
        INSERT VentaOrigen (ID, OrigenID, Sucursal, SucursalOrigen)
        SELECT @FacturaID, v.ID, @Sucursal, @Sucursal 
          FROM Venta v, ListaID l
         WHERE l.Estacion = @Estacion AND v.ID = l.ID AND  CONVERT(char(10), v.FechaEmision, 121) BETWEEN  CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND CONVERT(char(10), @FacturaFechaEmision, 121)
         
    
        INSERT #Facturas (ID, FechaEmision) VALUES (@FacturaID, @FacturaFechaEmision)
        SELECT @CuantasFacturas = @CuantasFacturas + 1
      END   
      ELSE
      BEGIN
        IF EXISTS (SELECT * FROM  Venta v JOIN VentaD d ON v.ID = d.ID JOIN  ListaID l  ON l.ID = v.ID AND l.Estacion = @Estacion WHERE v.ID = d.ID AND d.ID = l.ID AND (CONVERT(char(10), v.FechaEmision, 121)  BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND   CONVERT(char(10), @FacturaFechaEmision, 121)) AND l.Estacion = @Estacion AND ((d.Cantidad < 0.0) AND d.Articulo NOT IN (@CfgAnticipoArticuloServicio,@ArtOfertaFP,@ArtOfertaImporte )) AND d.ProcesadoID IS NULL)               
          EXEC spVentasProcesarNCredito  @Estacion, @Empresa, @Sucursal, @FacturaMov, @DevolucionMov, @FechaEmision, @Usuario, @Moneda, @TipoCambio, @AlmacenEncabezado, @Cliente, @EnviarA, @Condicion, @Concepto, @Agente, @UEN, @CfgCosteoSeries, @CfgCosteoLotes, @VentaMultiAlmacen, @VentaEstatus, @CteCNO, @EnSilencio, @FacturaFechaEmision,@FacturaFechaEmisionInicio,  @Ok OUTPUT, @OkRef  OUTPUT
--select @Estacion, @Empresa, @Sucursal, @FacturaMov, @DevolucionMov, @FechaEmision, @Usuario, @Moneda, @TipoCambio, @AlmacenEncabezado, @Cliente, @EnviarA, @Condicion, @Concepto, @Agente, @UEN, @CfgCosteoSeries, @CfgCosteoLotes, @VentaMultiAlmacen, @VentaEstatus, @CteCNO, @EnSilencio, @FacturaFechaEmision  
        --IF EXISTS (SELECT * FROM  Venta v JOIN VentaD d ON v.ID = d.ID JOIN  ListaID l  ON l.ID = v.ID AND l.Estacion = @Estacion WHERE v.ID = d.ID AND d.ID = l.ID AND v.FechaEmision = @FacturaFechaEmision AND l.Estacion = @Estacion AND ((d.Cantidad > 0.0)OR d.Articulo IN (@CfgAnticipoArticuloServicio,@ArtOfertaFP,@ArtOfertaImporte )) AND d.ProcesadoID IS NULL)
        IF EXISTS (SELECT * FROM  Venta v JOIN VentaD d ON v.ID = d.ID JOIN  ListaID l  ON l.ID = v.ID AND l.Estacion = @Estacion WHERE v.ID = d.ID AND d.ID = l.ID AND (CONVERT(char(10), v.FechaEmision, 121)  BETWEEN CONVERT(char(10), @FacturaFechaEmisionInicio, 121) AND   CONVERT(char(10), @FacturaFechaEmision, 121)) AND l.Estacion = @Estacion AND ((d.Cantidad > 0.0)OR d.Articulo IN (@CfgAnticipoArticuloServicio,@ArtOfertaFP,@ArtOfertaImporte )) AND d.ProcesadoID IS NULL)  
          EXEC spVentasProcesarN2  @Estacion, @Empresa, @Sucursal, @FacturaMov, @DevolucionMov, @FechaEmision, @Usuario, @Moneda, @TipoCambio, @AlmacenEncabezado, @Cliente, @EnviarA, @Condicion, @Concepto, @Agente, @UEN, @CfgCosteoSeries, @CfgCosteoLotes, @VentaMultiAlmacen, @VentaEstatus, @CteCNO, @EnSilencio, @FacturaFechaEmision,@FacturaFechaEmisionInicio, @Ok OUTPUT, @OkRef  OUTPUT          
          
      END 
      FETCH NEXT FROM crFechaEmision INTO @FacturaFechaEmision, @Sucursal
    END -- While
    CLOSE crFechaEmision
    DEALLOCATE crFechaEmision

    -- Auto Ajuste

    CREATE TABLE #tmpAjuste (
      Id         int identity(1,1) NOT NULL,
      Estacion   int               NULL,
      Almacen    varchar(20)       COLLATE DATABASE_DEFAULT NULL,
      Articulo   varchar(20)       COLLATE DATABASE_DEFAULT NULL,
      Subcuenta  varchar(20)       COLLATE DATABASE_DEFAULT NULL,
      Disponible float             NULL,
      Unidad     varchar(50)       COLLATE DATABASE_DEFAULT NULL,
      Lotesfijos bit               NOT NULL DEFAULT 0)

    INSERT INTO #tmpAjuste (Estacion, Almacen, Articulo, Subcuenta, Disponible, Unidad, lotesFijos)
    SELECT @Estacion, d.Almacen, d.Articulo, NULLIF(RTRIM(d.SubCuenta), ''), ROUND(d.Disponible, 4), a.Unidad, ISNULL(a.LotesFijos, 0)
      FROM ArtSubDisponible d, Art a, Alm
     WHERE a.Articulo = d.Articulo AND ROUND(d.Disponible, 4) < 0.0
       AND d.Almacen = alm.Almacen AND alm.Sucursal = @Sucursal AND d.Empresa = @Empresa

-- Inserta Aquellos Articulos Serie/Lote que tienen existencia de cierto lote pero negativos en el lote que se vendio.
    IF (SELECT NotasBorrador FROM EmpresaCFG WHERE Empresa = @Empresa) = 1 
      INSERT INTO #tmpAjuste (Estacion, Almacen, Articulo, Subcuenta, Disponible, Unidad, lotesFijos)
      SELECT @Estacion, d.Almacen, d.Articulo, NULLIF(RTRIM(d.SubCuenta), ''), ROUND(SUM(ABS(s.Existencia)), 4), a.Unidad, ISNULL(a.LotesFijos, 0)
        FROM ArtSubDisponible d
        JOIN Art a  ON a.Articulo = d.Articulo
        JOIN Alm ON d.Almacen = alm.Almacen
        JOIN SerieLote s ON s.Articulo = a.Articulo AND s.Empresa = @Empresa AND s.Sucursal = @sucursal   
        JOIN SerieLoteMov sm ON sm.articulo = s.Articulo AND sm.SerieLote = s.SerieLote AND sm.Empresa = s.Empresa AND sm.Sucursal = s.Sucursal
        JOIN ListaID l ON l.ID = sm.ID AND l.Estacion = @Estacion 
       WHERE  ROUND(d.Disponible, 4) >= 0.0 AND s.Existencia < 0
         AND alm.Sucursal = @Sucursal AND d.Empresa = @Empresa AND a.Tipo IN ('SERIE','LOTE')
       GROUP BY d.Almacen, d.Articulo, d.Subcuenta, a.Unidad, a.lotesFijos


    SELECT @Renglon = 0, @RenglonID = 0
    DECLARE crRojo CURSOR 
        FOR SELECT Almacen, Articulo, Subcuenta, Disponible, Unidad, lotesFijos FROM #tmpAjuste WHERE Estacion = @Estacion
    OPEN crRojo
    FETCH NEXT FROM crRojo INTO @Almacen, @Articulo, @SubCuenta, @Disponible, @Unidad, @LotesFijos
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN 
        IF @Renglon = 0
        BEGIN
          INSERT Inv (Sucursal,  SucursalOrigen, Empresa,  Mov,         FechaEmision,  Moneda,  TipoCambio,  Almacen,            Concepto,  Usuario,  Estatus,    OrigenTipo, UEN)
              VALUES (@Sucursal, @Sucursal,      @Empresa, @AjusteMov, @FechaEmision, @Moneda, @TipoCambio, @AlmacenEncabezado, @Concepto, @Usuario, 'CONFIRMAR', 'VMOS', @UEN)
          SELECT @AjusteID = SCOPE_IDENTITY()
        END
        SELECT @Lote = NULL, @Costo = NULL
        SELECT @Factor = ISNULL(Factor, 1) FROM Unidad WHERE Unidad = @Unidad

        -- Leer Inverso
        IF @LotesFijos = 1
        BEGIN
          IF @SeriesLotesAutoOrden = 'ASCENDENTE' 
            SELECT @Lote = (SELECT TOP 1 Lote FROM ArtLoteFijo WHERE Articulo = @Articulo ORDER BY Lote DESC) 
          ELSE
            SELECT @Lote = (SELECT TOP 1 Lote FROM ArtLoteFijo WHERE Articulo = @Articulo ORDER BY Lote)

          SELECT @Lote = NULLIF(RTRIM(@Lote), '')
          IF @Lote IS NOT NULL
            SELECT @Costo = MIN(CostoPromedio)*@Factor FROM SerieLote WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '') AND SerieLote = @Lote AND Almacen = @Almacen
        END

        IF @Costo IS NULL
          EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0

        SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1 
        INSERT InvD (Sucursal,  SucursalOrigen, ID,        Renglon,  RenglonSub, RenglonID,  Almacen,  Articulo,  SubCuenta,  Unidad,  Cantidad,              CantidadInventario, Costo)
             VALUES (@Sucursal, @Sucursal,      @AjusteID, @Renglon, 0,          @RenglonID, @Almacen, @Articulo, @SubCuenta, @Unidad, -@Disponible/@Factor, -@Disponible,        @Costo)

        IF @LotesFijos = 1 AND @Lote IS NOT NULL
          INSERT SerieLoteMov (Empresa,  Sucursal,  Modulo, ID,        RenglonID,  Articulo,  SubCuenta,              SerieLote, Cantidad) 
                       VALUES (@Empresa, @Sucursal, 'INV',  @AjusteID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), @Lote,     -@Disponible/@Factor)
        ELSE
        -- Inicio Ajustes de Articulos Tipo Lote vendidos Sin Existencia
        IF (SELECT NotasBorrador FROM EmpresaCFG WHERE Empresa = @Empresa) = 1 AND @ArtTipo IN ('SERIE','LOTE')
        BEGIN
          INSERT SerieLoteMov (Empresa,  Modulo, ID,         RenglonID,  Articulo,  SubCuenta,              SerieLote,   ArtCostoInv,  Cantidad,        CantidadAlterna,        Sucursal,Propiedades)
                       SELECT @Empresa, 'INV', @AjusteID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), s.SerieLote, s.ArtCostoInv, SUM(ABS(sl.Existencia)), SUM(ABS(sl.Existencia)), @Sucursal,ISNULL(s.Propiedades, '')
                         FROM SerieLoteMov s
                         JOIN ListaID l ON l.ID = s.ID AND l.Estacion = @Estacion 
                         JOIN Serielote sl ON s.articulo = sl.Articulo AND s.SerieLote = sl.SerieLote AND s.Empresa = sl.Empresa AND s.Sucursal = sl.Sucursal 
                        WHERE s.Empresa = @Empresa AND s.Modulo = 'VTAS' 
                          AND s.Articulo = @Articulo AND s.Sucursal = @Sucursal AND sl.Existencia < 0
                        GROUP BY s.SerieLote, s.ArtCostoInv, s.Propiedades


          IF EXISTS (SELECT s.ID FROM SerieLoteMov s
                                 JOIN ListaID l ON l.ID = s.ID AND l.Estacion = @Estacion 
                                 JOIN Serielote sl ON s.articulo = sl.Articulo AND s.SerieLote = sl.SerieLote AND s.Empresa = sl.Empresa AND s.Sucursal = sl.Sucursal 
                                WHERE s.Empresa = @Empresa AND s.Modulo = 'VTAS' AND s.Articulo = @Articulo AND s.Sucursal = @Sucursal AND sl.Existencia < 0)
          BEGIN
            SELECT @CantidadAjusteLote = NULL
            SELECT @CantidadAjusteLote = SUM(ABS(sl.Existencia)) 
              FROM SerieLoteMov s   
              JOIN Serielote sl ON s.articulo = sl.Articulo AND s.SerieLote = sl.SerieLote AND s.Empresa = sl.Empresa AND s.Sucursal = sl.Sucursal 
             WHERE s.Empresa = @Empresa AND s.Modulo = 'INV' AND s.ID = @AjusteID
               AND s.RenglonID = @RenglonID AND ISNULL(s.SubCuenta, '') = ISNULL(@SubCuenta, '') 
               AND s.Articulo = @Articulo
               AND s.Sucursal = @Sucursal
               AND sl.Existencia < 0
             GROUP BY s.SerieLote, s.ArtCostoInv, s.Propiedades

            IF @CantidadAjusteLote IS NOT NULL
            BEGIN 
              IF NULLIF(-@Disponible/@Factor,0.0) <> @CantidadAjusteLote 
                UPDATE InvD SET Cantidad = @CantidadAjusteLote WHERE ID = @AjusteID AND Renglon = @Renglon AND RenglonID = @RenglonID AND Articulo = @Articulo
            END
          END
        END --Fin Ajustes de Articulos Tipo Lote vendidos Sin Existencia

      END
      FETCH NEXT FROM crRojo INTO @Almacen, @Articulo, @SubCuenta, @Disponible, @Unidad, @LotesFijos
    END -- While
    CLOSE crRojo
    DEALLOCATE crRojo

    DELETE ListaID WHERE Estacion = @Estacion
    SELECT @Cuantas = @@ROWCOUNT

    IF @CerrarSucursalAuto = 1 AND @AjusteID IS NOT NULL AND @Ok IS NULL
      EXEC spInv @AjusteID, 'INV', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                 @AjusteMov, @AjusteMovID OUTPUT, NULL, NULL,
                 @Ok OUTPUT, @OkRef OUTPUT, 0
                 
    IF @CerrarSucursalAuto = 1 OR @AsignarConsecutivo = 1 OR (@EstatusVMOS = 'CONCLUIDO' AND @AjusteID IS NULL) AND @Ok IS NULL
    AND EXISTS(SELECT * FROM #Devoluciones  WHERE ID IS NOT NULL)
    BEGIN
      DECLARE crDevolucion CURSOR LOCAL FOR
       SELECT ID
         FROM #Devoluciones
        WHERE ID IS NOT NULL         
      OPEN crDevolucion
      FETCH NEXT FROM crDevolucion INTO @DevolucionID
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        IF @EstatusVMOS = 'CONCLUIDO' SELECT @Accion = 'AFECTAR' ELSE SELECT @Accion = 'CONSECUTIVO' 
        EXEC spInv @DevolucionID, 'VTAS', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                   @DevolucionMov  OUTPUT, @DevolucionMovID OUTPUT, NULL, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, 0
        IF @Ok IN (80030, 80060) SELECT @Ok = NULL, @OkRef = NULL           
        IF @Ok IS NULL
        BEGIN
          SELECT @DevolucionEstatus = Estatus FROM Venta WHERE ID = @DevolucionID
          INSERT @TablaCFD(Empresa,  ID,         Modulo, Mov,          MovID,         EstatusNuevo)
          SELECT           @Empresa, @DevolucionID, 'VTAS', @DevolucionMov,  @DevolucionMovID, @DevolucionEstatus
        END                    
                 
        
        FETCH NEXT FROM crDevolucion INTO @DevolucionID
      END
      CLOSE crDevolucion
      DEALLOCATE crDevolucion
      SELECT @LeyendaEstatus = ''
    END                 

    IF @CerrarSucursalAuto = 1 OR @AsignarConsecutivo = 1 OR (@EstatusVMOS = 'CONCLUIDO' AND @AjusteID IS NULL) AND @Ok IS NULL
    BEGIN
      DECLARE crFacturas CURSOR LOCAL FOR
       SELECT ID
         FROM #Facturas
      OPEN crFacturas
      FETCH NEXT FROM crFacturas INTO @FacturaID
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        IF @EstatusVMOS = 'CONCLUIDO' SELECT @Accion = 'AFECTAR' ELSE SELECT @Accion = 'CONSECUTIVO' 
        EXEC spInv @FacturaID, 'VTAS', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                   @FacturaMov OUTPUT, @FacturaMovID OUTPUT, NULL, NULL,
                   @Ok OUTPUT, @OkRef OUTPUT, 0
        IF @Ok IN (80030, 80060) SELECT @Ok = NULL, @OkRef = NULL
        IF @Ok IS NULL
        BEGIN
          SELECT @FacturaEstatus = Estatus FROM Venta WHERE ID = @FacturaID
          INSERT @TablaCFD(Empresa,  ID,         Modulo, Mov,          MovID,         EstatusNuevo)
          SELECT           @Empresa, @FacturaID, 'VTAS', @FacturaMov,  @FacturaMovID, @FacturaEstatus
        END         
        
        FETCH NEXT FROM crFacturas INTO @FacturaID
      END
      CLOSE crFacturas
      DEALLOCATE crFacturas
      SELECT @LeyendaEstatus = ''
    END
    IF @GenerarNCAlProcesar = 1
    BEGIN
      SELECT TOP 1 @FacturaID = ID FROM #Facturas
      SELECT @FacturaMovID = MovID FROM Venta WHERE ID = @FacturaID
      SELECT TOP 1 @DevolucionID = ID FROM #Devoluciones
      SELECT @DevolucionMovID = MovID FROM Venta WHERE ID = @DevolucionID      
    END


  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    IF @EnSilencio = 0
    BEGIN
      SELECT @OkRef = RTRIM(Convert(char, @Cuantas))+' Nota(s) procesadas.'
      IF @AjusteID IS NOT NULL SELECT @OkRef = RTRIM(@OkRef)  + '<BR>Se Genero: '+RTRIM(@AjusteMov)+' (por Confirmar) en Inventarios'
      
      IF @DevolucionID IS NOT NULL
      BEGIN
        SELECT @CuantasDevoluciones = COUNT(ID) FROM #Devoluciones
        IF @CuantasDevoluciones = 1 
          SELECT @OkRef = RTRIM(@OkRef) + '<BR>Se Genero: '+RTRIM(@DevolucionMov)+' '+ISNULL(RTRIM(@DevolucionMovID), '')+' '+@LeyendaEstatus
        ELSE
          SELECT @OkRef = RTRIM(@OkRef) + '<BR>Se Generaron: '+CONVERT(varchar, @CuantasDevoluciones)+' '+RTRIM(@DevolucionMov)+'(s) '+@LeyendaEstatus
      END
      IF @FacturaID IS NOT NULL
      BEGIN
        IF @GenerarNCAlProcesar = 1
        BEGIN
          SELECT @CuantasFacturas = COUNT(ID) FROM #Facturas
          IF @CuantasFacturas = 1 
            SELECT @OkRef = RTRIM(@OkRef) + '<BR>Se Genero: '+RTRIM(@FacturaMov)+' '+ISNULL(RTRIM(@FacturaMovID), '')+' '+@LeyendaEstatus
          ELSE
            SELECT @OkRef = RTRIM(@OkRef) + '<BR>Se Generaron: '+CONVERT(varchar, @CuantasFacturas)+' '+RTRIM(@FacturaMov)+'(s) '+@LeyendaEstatus          
        END
        ELSE
        BEGIN
          IF @CuantasFacturas = 1 
            SELECT @OkRef = RTRIM(@OkRef) + '<BR>Se Genero: '+RTRIM(@FacturaMov)+' '+ISNULL(RTRIM(@FacturaMovID), '')+' '+@LeyendaEstatus
          ELSE
            SELECT @OkRef = RTRIM(@OkRef) + '<BR>Se Generaron: '+CONVERT(varchar, @CuantasFacturas)+' '+RTRIM(@FacturaMov)+'(s) '+@LeyendaEstatus
        END  
      END
      SELECT @OkRef
    END
    IF @Ok IS NULL
    BEGIN
      DECLARE crcfd CURSOR LOCAL FOR
       SELECT Empresa,ID,Modulo,Mov,MovID,EstatusNuevo
         FROM @TablaCFD
      OPEN crcfd
      FETCH NEXT FROM crcfd INTO @CFDEmpresa,@CFDID,@CFDModulo,@CFDMov,@CFDMovID,@CFDEstatusNuevo
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        EXEC spCFDFlexAfectarSinMovFinal @CFDEmpresa,@CFDModulo, @CFDMov, @CFDMovID, @CFDID, @CFDEstatusNuevo, NULL, NULL
       -- SELECT @CFDEmpresa = NULL, @CFDModulo= NULL, @CFDMov= NULL, @CFDMovID= NULL, @CFDID= NULL
        FETCH NEXT FROM crcfd INTO @CFDEmpresa,@CFDID,@CFDModulo,@CFDMov,@CFDMovID,@CFDEstatusNuevo
      END
      CLOSE crcfd
      DEALLOCATE crcfd 
    END     
  END ELSE

  BEGIN
    ROLLBACK TRANSACTION

    IF @EnSilencio = 0
      SELECT Descripcion+' '+RTRIM(@OkRef) 
        FROM MensajeLista
       WHERE Mensaje = @Ok
  
  END

  RETURN
END
GO	



--REQ 15448





-- spProcesarVentaNConsumo 100.0, 'DEMO', 'Factura', '12/27/2004 17:44:17', 'DEMO', 'MEX', @Sugerir=1
/**************** spProcesarVentaNConsumo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProcesarVentaNConsumo') and type = 'P') drop procedure dbo.spProcesarVentaNConsumo
GO             
CREATE PROCEDURE spProcesarVentaNConsumo
                    @Estacion		int,
		    @Empresa		char(5),
		    @FacturaMov		char(20),
		    @FechaEmision	datetime,
		    @Usuario		char(10),
		    @CteCNO		char(10) 	= NULL,
		    @EnSilencio		bit	 	= 0,
		    @Ok			int	 	= NULL	OUTPUT,
		    @OkRef		varchar(255)	= NULL	OUTPUT,
		    @Sugerir		bit		= 0

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @TipoCosteo			varchar(20),
    @VentaMultiAlmacen		bit,
    @OrigenID			int,
    @VentaID			int,
    @FacturaID			int,
    @FacturaAseguradoraID	int,
    @FacturaFechaEmision	datetime,
    @FacturaMovID		varchar(20),
    @NotaID			int,
    @AjusteID			int,
    @Cuantas			int,
    @CuantasFacturas		int,
    @Cliente			char(10),
    @Aseguradora		char(10),
    @EnviarA			int,
    @ClienteVMOS		char(10),
    @VentaEstatus		char(15),
    @EstatusVMOS		char(15),
    @AlmacenEncabezado		char(10),
    @Almacen			char(10),
    @Posicion			char(10),
    @ArtTipo			char(20),
    @Moneda			char(10),
    @TipoCambio			float,
    @Concepto			varchar(50),
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @Unidad			varchar(50),
    @Factor			float,
    @Cantidad			float,
    @CantidadInventario		float,
    @Disponible			float,
    @MonedaCosto		char(10),
    @Costo			float,
    @Precio        		float,
    @PrecioNeto        		float,
    @Importe			money,
    @ImporteLinea		money,
    @Proveedor			char(10),
    @DescuentoTipo		char(1),
    @DescuentoLinea		float,
    @DescuentoGlobal		float,
    @SobrePrecio		float,
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @Renglon			float,
    @RenglonID			int,
    @FactorCosto		float,
    @TipoCambioCosto		float,
    @ImporteTotal		money,
    @Agente			char(10),
    @UEN			int,
    @CfgCosteoNivelSubCuenta 	bit,
    @Sucursal			int,
    @AjusteMov			char(20),
    @AjusteMovID		varchar(20),
    @Condicion			varchar(50),
    @FechaRegistro		datetime,
    @LeyendaEstatus		varchar(50),
    @CfgCosteoSeries		bit,
    @CfgCosteoLotes		bit,
    @ArtCostoIdentificado	bit,
    @SeriesLotesAutoOrden	varchar(50), 
    @AsignarConsecutivo		bit,
    @Accion			char(20),
    @LotesFijos			bit,
    @Lote			varchar(50),
    @RenglonTipo		char(1),
    @Dif			money

  IF @Sugerir = 1
    DELETE SugerirFacturaNConsumo WHERE Estacion = @Estacion

  IF NOT EXISTS(SELECT * FROM ListaID WHERE Estacion = @Estacion) OR ((SELECT Clave FROM MovTipo WHERE Modulo = 'VTAS' AND Mov = @FacturaMov) <> 'VTAS.F')
  BEGIN
    IF @EnSilencio = 0 AND @Sugerir = 0
      SELECT NULL

    RETURN
  END

  SELECT @EnviarA = NULL, @NotaID = NULL, @AjusteID = NULL, @ImporteTotal = 0.0, @Condicion = NULL, @FacturaMovID = NULL,
         @FechaRegistro = GETDATE(), @LeyendaEstatus = '', @Agente = NULL, @UEN = NULL, @Proveedor = NULL, @CuantasFacturas = 0,
         @FacturaID = NULL, @FacturaAseguradoraID = NULL   

  SELECT @AjusteMov = InvAjuste
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @CfgCosteoNivelSubCuenta = CosteoNivelSubCuenta,
         @ClienteVMOS             = NULLIF(RTRIM(ClienteFacturaVMOS), ''),
         @EstatusVMOS             = ISNULL(NULLIF(RTRIM(EstatusFacturaVMOS), ''), 'BORRADOR'),
         @AsignarConsecutivo      = ISNULL(AsignarConsecutivoFacturaVMOS, 0),
         @TipoCosteo		  = ISNULL(NULLIF(RTRIM(UPPER(TipoCosteo)), ''), 'PROMEDIO'),
         @CfgCosteoSeries	  = ISNULL(CosteoSeries, 0),
         @CfgCosteoLotes	  = ISNULL(CosteoLotes, 0),
	 @SeriesLotesAutoOrden    = UPPER(SeriesLotesAutoOrden)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  --IF @CteCNO IS NULL SELECT @EstatusVMOS = 'BORRADOR'

  SELECT @VentaEstatus = @EstatusVMOS
  IF @EstatusVMOS = 'CONCLUIDO'  SELECT @VentaEstatus = 'BORRADOR'

  IF @VentaEstatus = 'BORRADOR'   SELECT @LeyendaEstatus = ' (Borrador)'      ELSE
  IF @VentaEstatus = 'CONFIRMAR'  SELECT @LeyendaEstatus = ' (por Confirmar)' ELSE
  IF @VentaEstatus = 'SINAFECTAR' SELECT @LeyendaEstatus = ' (Sin Afectar)'  

  SELECT @VentaMultiAlmacen = VentaMultiAlmacen
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT @Sucursal = Sucursal FROM UsuarioSucursal WHERE Usuario = @Usuario

  EXEC spExtraerFecha @FechaEmision OUTPUT

  DECLARE crLista CURSOR 
      FOR SELECT ID FROM ListaID WHERE Estacion = @Estacion
  OPEN crLista
  FETCH NEXT FROM crLista INTO @NotaID
  CLOSE crLista
  DEALLOCATE crLista

  IF @NotaID IS NULL 
    SELECT @Ok = 10160

  IF EXISTS(SELECT * FROM Inv WHERE Empresa = @Empresa AND Estatus = 'CONFIRMAR' AND OrigenTipo = 'VMOS' AND Sucursal = @Sucursal)
    SELECT @Ok = 10170

  SELECT @ImporteTotal = SUM(ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0))
    FROM Venta v, ListaID l
   WHERE v.ID = l.ID
     AND l.Estacion = @Estacion

  IF @ImporteTotal < 0.0
    SELECT @Ok = 10180

  IF @Ok IS NOT NULL AND @EnSilencio = 1 RETURN

  SELECT @AlmacenEncabezado = Almacen, 
         @Cliente = ISNULL(@CteCNO, ISNULL(@ClienteVMOS, Cliente)), 
         @Moneda = Moneda, 
         @TipoCambio = TipoCambio, 
         @Concepto = Concepto 
    FROM Venta 
   WHERE ID = @NotaID

  IF @CteCNO IS NOT NULL
  BEGIN
    SELECT @Cliente = ISNULL(NULLIF(RTRIM(FacturarCte), ''), Cliente),
           @Aseguradora = NULLIF(RTRIM(Aseguradora), ''),
           @EnviarA = FacturarCteEnviarA,
           @Condicion = Condicion,
           @Agente = Agente
      FROM Cte
     WHERE Cliente = @CteCNO
     SELECT @UEN = UEN FROM Usuario WHERE Usuario = @Usuario
  END

  CREATE TABLE #Facturas (ID int NULL, FechaEmision datetime NULL)

  BEGIN TRANSACTION

  SELECT @FacturaFechaEmision = @FechaEmision 			/* Una Sola Factura sin Importar los Dias que esta Procesando */
  IF @Sugerir = 0
  BEGIN
    INSERT Venta (
           Sucursal,  SucursalOrigen, Empresa,  Mov,         FechaEmision,         Moneda,  TipoCambio,  Almacen,            Cliente,   EnviarA,   Condicion,   Concepto,  Usuario,  Estatus,       OrigenTipo, Agente,   UEN)
    SELECT @Sucursal, @Sucursal,      @Empresa, @FacturaMov, @FacturaFechaEmision, @Moneda, @TipoCambio, @AlmacenEncabezado, c.Cliente, c.EnviarA, c.Condicion, @Concepto, @Usuario, @VentaEstatus, 'VMOS',     c.Agente, @UEN
      FROM Cte c
     WHERE c.Cliente = @Cliente
    SELECT @FacturaID = SCOPE_IDENTITY()

    IF @Aseguradora IS NOT NULL
    BEGIN
      INSERT Venta (
             Sucursal,  SucursalOrigen, Empresa,  Mov,         FechaEmision,         Moneda,  TipoCambio,  Almacen,            Cliente,   EnviarA,   Condicion,   Concepto,  Usuario,  Estatus,       OrigenTipo, Agente,   UEN)
      SELECT @Sucursal, @Sucursal,      @Empresa, @FacturaMov, @FacturaFechaEmision, @Moneda, @TipoCambio, @AlmacenEncabezado, c.Cliente, c.EnviarA, c.Condicion, @Concepto, @Usuario, @VentaEstatus, 'VMOS',     c.Agente, @UEN
        FROM Cte c
       WHERE c.Cliente = @Aseguradora
      SELECT @FacturaAseguradoraID = SCOPE_IDENTITY()
    END
  END
  SELECT @Renglon = 0, @RenglonID = 0

  DECLARE crNotas CURSOR LOCAL
      FOR SELECT d.Almacen, d.Posicion, d.Articulo, d.SubCuenta, d.RenglonTipo, d.Unidad, ROUND(d.Impuesto1, 4), ROUND(d.Impuesto2, 4), ROUND(d.Impuesto3, 4), SUM(d.Cantidad), SUM(d.CantidadInventario), d.DescuentoTipo, d.DescuentoLinea, d.Precio, SUM(d.ImporteTotal), v.DescuentoGlobal, v.SobrePrecio, Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado
            FROM Venta v, VentaTCalc d, ListaID l, Art
           WHERE v.ID = d.ID AND d.ID = l.ID 
             AND l.Estacion = @Estacion
             AND Art.Articulo = d.Articulo
           GROUP BY d.Almacen, d.Posicion, d.Articulo, Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.SubCuenta, d.Unidad, d.RenglonTipo, ROUND(d.Impuesto1, 4), ROUND(d.Impuesto2, 4), ROUND(d.Impuesto3, 4), d.DescuentoTipo, d.DescuentoLinea, d.Precio, v.DescuentoGlobal, v.SobrePrecio
           ORDER BY d.Almacen, d.Posicion, d.Articulo, Art.MonedaCosto, Art.Tipo, Art.CostoIdentificado, d.SubCuenta, d.Unidad, d.RenglonTipo, ROUND(d.Impuesto1, 4), ROUND(d.Impuesto2, 4), ROUND(d.Impuesto3, 4), d.DescuentoTipo, d.DescuentoLinea, d.Precio, v.DescuentoGlobal, v.SobrePrecio

  OPEN crNotas
  FETCH NEXT FROM crNotas INTO @Almacen, @Posicion, @Articulo, @SubCuenta, @RenglonTipo, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @Precio, @ImporteLinea, @DescuentoGlobal, @SobrePrecio, @MonedaCosto, @ArtTipo, @ArtCostoIdentificado
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @PrecioNeto = dbo.fnSubTotal(@Precio, @DescuentoGlobal, @SobrePrecio)
      SELECT @Importe = @Cantidad * @PrecioNeto

      IF NULLIF(@DescuentoLinea, 0.0) IS NOT NULL
      BEGIN
        IF ISNULL(@DescuentoTipo, '') <> '$' 
          SELECT @Importe = @Importe * (1-(@DescuentoLinea/100.0))
        SELECT @Importe = @Importe - @DescuentoLinea
      END
      SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1

      IF @Sugerir = 1
        INSERT SugerirFacturaNConsumo (Estacion, Renglon, RenglonID, Articulo, SubCuenta, Cantidad, Unidad, Importe) VALUES (@Estacion, @Renglon, @RenglonID, @Articulo, @SubCuenta, @Cantidad, @Unidad, @ImporteLinea)
      ELSE BEGIN
        IF @VentaMultiAlmacen = 0 AND @Almacen <> @AlmacenEncabezado SELECT @Ok = 20860, @OkRef = @Almacen

        IF @Aseguradora IS NOT NULL AND EXISTS(SELECT * FROM SugerirFacturaNConsumo WHERE Estacion = @Estacion AND Renglon = @Renglon AND RenglonID = @RenglonID AND Articulo = @Articulo AND EstaCubierto = 1)
          SELECT @VentaID = @FacturaAseguradoraID
        ELSE
          SELECT @VentaID = @FacturaID

        SELECT @Costo = NULL
        EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0, @Precio = @PrecioNeto
        INSERT VentaD (Sucursal,  SucursalOrigen, ID,       Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Almacen,  Posicion,  Articulo,  SubCuenta,  Unidad,  Impuesto1,  Impuesto2,  Impuesto3,  Cantidad,  CantidadInventario,  DescuentoTipo,  DescuentoLinea,  Precio,      Costo,  UEN,  Agente)
               VALUES (@Sucursal, @Sucursal,      @VentaID, @Renglon,          0, @RenglonID, @RenglonTipo, @Almacen, @Posicion, @Articulo, @SubCuenta, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @PrecioNeto, @Costo, @UEN, @Agente)
        IF (@ArtTipo IN ('SERIE', 'VIN') AND (@CfgCosteoSeries = 1 OR @ArtCostoIdentificado = 1)) OR (@ArtTipo IN ('LOTE', 'PARTIDA') AND (@CfgCosteoLotes = 1 OR @ArtCostoIdentificado = 1)) 
          INSERT SerieLoteMov (Empresa,  Modulo, ID,       RenglonID,  Articulo,  SubCuenta,              SerieLote,   ArtCostoInv,  Cantidad,        CantidadAlterna,        Sucursal)
                        SELECT @Empresa, 'VTAS', @VentaID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), s.SerieLote, s.ArtCostoInv, SUM(s.Cantidad), SUM(s.CantidadAlterna), @Sucursal
                          FROM SerieLoteMov s, Venta v, VentaD d, ListaID l, Art
                         WHERE v.ID = d.ID AND d.ID = l.ID 
                           AND l.Estacion = @Estacion
                           AND Art.Articulo = d.Articulo
                           AND s.Empresa = @Empresa AND s.Modulo = 'VTAS' AND s.ID = v.ID AND s.RenglonID = d.RenglonID AND s.Articulo = @Articulo AND ISNULL(s.SubCuenta, '') = ISNULL(@SubCuenta, '') 
                           AND d.Almacen = @Almacen AND ISNULL(d.Posicion, '') = ISNULL(@Posicion, '') AND d.Articulo = @Articulo AND Art.MonedaCosto = @MonedaCosto AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @Unidad AND ROUND(d.Impuesto1, 4) = @Impuesto1 AND ROUND(d.Impuesto2, 4) = @Impuesto2 AND ROUND(d.Impuesto3, 4) = @Impuesto3 AND d.DescuentoTipo = @DescuentoTipo AND d.DescuentoLinea = @DescuentoLinea AND d.Precio = @Precio AND ROUND(v.DescuentoGlobal, 10) = ROUND(@DescuentoGlobal, 10) AND ROUND(v.SobrePrecio, 10) = ROUND(@SobrePrecio, 10)
                         GROUP BY s.SerieLote, s.ArtCostoInv
      END
    END
    FETCH NEXT FROM crNotas INTO @Almacen, @Posicion, @Articulo, @SubCuenta, @RenglonTipo, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @Cantidad, @CantidadInventario, @DescuentoTipo, @DescuentoLinea, @Precio, @ImporteLinea, @DescuentoGlobal, @SobrePrecio, @MonedaCosto, @ArtTipo, @ArtCostoIdentificado
  END -- While
  CLOSE crNotas
  DEALLOCATE crNotas

  IF @Sugerir = 1
    EXEC spSugerirFacturaNConsumo @Estacion, @Empresa, @CteCNO, @Moneda, @TipoCambio, @Renglon, @RenglonID, @Ok OUTPUT, @OkRef OUTPUT

  IF @Sugerir = 0
  BEGIN
    INSERT #Facturas (ID, FechaEmision) VALUES (@FacturaID, @FacturaFechaEmision)
    SELECT @CuantasFacturas = @CuantasFacturas + 1

    IF @Aseguradora IS NOT NULL
    BEGIN 
      -- Cargo al Cliente
      INSERT VentaD (
             Sucursal,  SucursalOrigen, ID,         Renglon,  RenglonSub, RenglonID, RenglonTipo, Almacen,            Articulo, Unidad, Cantidad, CantidadInventario, Precio,                           UEN,  Agente)
      SELECT @Sucursal, @Sucursal,      @FacturaID, Renglon,           0, RenglonID, 'N',         @AlmacenEncabezado, Articulo, Unidad, Cantidad, Cantidad,           Importe/NULLIF(ABS(Cantidad), 0), @UEN, @Agente
        FROM SugerirFacturaNConsumo
       WHERE Estacion = @Estacion AND Extra = 1

      -- Abono a la Aseguradora
      INSERT VentaD (
             Sucursal,  SucursalOrigen, ID,                    Renglon,  RenglonSub, RenglonID, RenglonTipo, Almacen,            Articulo, Unidad, Cantidad,  CantidadInventario, Precio,                           UEN,  Agente)
      SELECT @Sucursal, @Sucursal,      @FacturaAseguradoraID, Renglon,           0, RenglonID, 'N',         @AlmacenEncabezado, Articulo, Unidad, -Cantidad, -Cantidad,          Importe/NULLIF(ABS(Cantidad), 0), @UEN, @Agente
        FROM SugerirFacturaNConsumo
       WHERE Estacion = @Estacion AND Extra = 1

      IF NOT EXISTS(SELECT * FROM VentaD WHERE ID = @FacturaAseguradoraID)
        DELETE Venta WHERE ID = @FacturaAseguradoraID
      ELSE BEGIN
        INSERT #Facturas (ID, FechaEmision) VALUES (@FacturaAseguradoraID, @FacturaFechaEmision)
        SELECT @CuantasFacturas = @CuantasFacturas + 1
      END
    END
  END

  IF @Sugerir = 0 
  BEGIN
    IF @FacturaAseguradoraID IS NOT NULL
    BEGIN
      IF NOT EXISTS(SELECT * FROM VentaD WHERE ID = @FacturaAseguradoraID)
      BEGIN
        DELETE Venta  WHERE ID = @FacturaAseguradoraID
        DELETE VentaD WHERE ID = @FacturaAseguradoraID
        SELECT @OrigenID = @FacturaAseguradoraID
      END
    END
    IF NOT EXISTS(SELECT * FROM VentaD WHERE ID = @FacturaID)
    BEGIN
      DELETE Venta  WHERE ID = @FacturaID
      DELETE VentaD WHERE ID = @FacturaID
      SELECT @OrigenID = @FacturaAseguradoraID
      SELECT @FacturaID = NULL
    END ELSE
      SELECT @OrigenID = @FacturaID

    INSERT VentaOrigen (ID, OrigenID, Sucursal, SucursalOrigen)
    SELECT @OrigenID, v.ID, @Sucursal, @Sucursal 
      FROM Venta v, ListaID l
     WHERE l.Estacion = @Estacion AND v.ID = l.ID --AND v.FechaEmision = @FacturaFechaEmision		/* Una Sola Factura sin Importar los Dias que esta Procesando */

    DELETE ListaID WHERE Estacion = @Estacion
    SELECT @Cuantas = @@ROWCOUNT
  END

  IF @Sugerir = 0 AND @Ok IS NULL AND (@AsignarConsecutivo = 1 OR (@EstatusVMOS = 'CONCLUIDO' AND @AjusteID IS NULL))
  BEGIN
    DECLARE crFacturas CURSOR LOCAL FOR
     SELECT v.ID
       FROM #Facturas t
       JOIN Venta v ON v.ID = t.ID
    OPEN crFacturas
    FETCH NEXT FROM crFacturas INTO @FacturaID
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      IF @EstatusVMOS = 'CONCLUIDO' SELECT @Accion = 'AFECTAR' ELSE SELECT @Accion = 'CONSECUTIVO' 
	  BEGIN
	    EXEC spAfectar 'VTAS', @FacturaID, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
		IF @Ok IS NULL
		  SELECT @FacturaMovID = MovID FROM Venta WHERE ID = @FacturaID
	  END
      --EXEC spInv @FacturaID, 'VTAS', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
      --           @FacturaMov OUTPUT, @FacturaMovID OUTPUT, NULL, NULL,
      --           @Ok OUTPUT, @OkRef OUTPUT, 0
      IF @Ok IN (80030, 80060) SELECT @Ok = NULL, @OkRef = NULL
      FETCH NEXT FROM crFacturas INTO @FacturaID
    END
    CLOSE crFacturas
    DEALLOCATE crFacturas
    SELECT @LeyendaEstatus = ''
  END

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    
    IF @EnSilencio = 0 AND @Sugerir = 0
    BEGIN
      SELECT @OkRef = RTRIM(Convert(char, @Cuantas))+' Nota(s) procesadas.'
      IF @AjusteID IS NOT NULL SELECT @OkRef = RTRIM(@OkRef)  + '<BR>Se Genero: '+RTRIM(@AjusteMov)+' (por Confirmar) en Inventarios'
      IF @FacturaID IS NOT NULL
      BEGIN
        IF @CuantasFacturas = 1 
          SELECT @OkRef = RTRIM(@OkRef) + '<BR>Se Genero: '+RTRIM(@FacturaMov)+' '+ISNULL(RTRIM(@FacturaMovID), '')+' '+@LeyendaEstatus
        ELSE
          SELECT @OkRef = RTRIM(@OkRef) + '<BR>Se Generaron: '+CONVERT(varchar, @CuantasFacturas)+' '+RTRIM(@FacturaMov)+'(s) '+@LeyendaEstatus
      END
      SELECT @OkRef
    END
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION

    IF @EnSilencio = 0 AND @Sugerir = 0
      SELECT Descripcion+' '+RTRIM(@OkRef) 
        FROM MensajeLista
       WHERE Mensaje = @Ok  
  END

  RETURN
END
GO

/**************** spProdAsignarLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdAsignarLote') and type = 'P') drop procedure dbo.spProdAsignarLote
GO             
CREATE PROCEDURE spProdAsignarLote
		   @Estacion	int,
                   @Empresa	char(5),
                   @ID		int,
                   @Sucursal	int,
		   @Lote	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo		char(20),
    @SubCuenta		varchar(20),
    @Cantidad		float,
    @RenglonID		int

  SELECT @Lote = NULLIF(NULLIF(RTRIM(@Lote), ''), '0')

  IF @Lote IS NOT NULL AND EXISTS(SELECT * FROM SerieLote WHERE SerieLote = @Lote)
  BEGIN
    RAISERROR('El Lote Indicado Ya Existe',16,-1)               
    RETURN
  END

  BEGIN TRANSACTION
    DECLARE crProd CURSOR FOR
     SELECT d.Articulo, ISNULL(RTRIM(d.SubCuenta), ''), ISNULL(d.Cantidad, 0.0), d.RenglonID
       FROM ListaIDRenglon l, ProdD d, Art a 
      WHERE d.ID = @ID AND d.Articulo = a.Articulo AND UPPER(a.Tipo) IN ('LOTE', 'PARTIDA')
        AND l.Estacion = @Estacion AND l.Modulo = 'PROD' AND l.ID = d.ID AND l.Renglon = d.Renglon AND l.RenglonSub = d.RenglonSub
    OPEN crProd
    FETCH NEXT FROM crProd INTO @Articulo, @SubCuenta, @Cantidad, @RenglonID
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Cantidad <> 0.0
      BEGIN
        IF @Lote IS NULL
          DELETE SerieLoteMov 
           WHERE Empresa = @Empresa AND Modulo = 'PROD' AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo
        ELSE BEGIN
          UPDATE SerieLoteMov 
             SET SerieLote = @Lote, Cantidad = @Cantidad
           WHERE Empresa = @Empresa AND Modulo = 'PROD' AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo
          IF @@ROWCOUNT = 0
  	    INSERT SerieLoteMov (Sucursal,  Empresa,  Modulo, ID,  RenglonID,  Articulo, SubCuenta,   SerieLote,  Cantidad)
                         VALUES (@Sucursal, @Empresa, 'PROD', @ID, @RenglonID, @Articulo, @SubCuenta, @Lote,      @Cantidad)
        END
      END
      FETCH NEXT FROM crProd INTO @Articulo, @SubCuenta, @Cantidad, @RenglonID
    END
    CLOSE crProd
    DEALLOCATE crProd
  COMMIT TRANSACTION
  RETURN
END
GO

/*
select * from gastod where id = 8
*/
/**************** spReasignarAgente ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReasignarAgente') and type = 'P') drop procedure dbo.spReasignarAgente
GO             
CREATE PROCEDURE spReasignarAgente
			@AgenteD	char(10),
			@AgenteA	char(10)
--//WITH ENCRYPTION
AS BEGIN
  BEGIN TRANSACTION
    UPDATE Venta        SET Agente = @AgenteA         WHERE Agente = @AgenteD
    UPDATE VentaD       SET Agente = @AgenteA         WHERE Agente = @AgenteD
    UPDATE VentaDAgente SET Agente = @AgenteA         WHERE Agente = @AgenteD
    UPDATE Cte          SET Agente = @AgenteA         WHERE Agente = @AgenteD
    UPDATE Cte          SET AgenteServicio = @AgenteA WHERE AgenteServicio = @AgenteD
    UPDATE Prov         SET Agente = @AgenteA         WHERE Agente = @AgenteD
    UPDATE ProyD        SET Agente = @AgenteA         WHERE Agente = @AgenteD
    UPDATE Cxc          SET Agente = @AgenteA         WHERE Agente = @AgenteD
    UPDATE Agent        SET Agente = @AgenteA         WHERE Agente = @AgenteD
  COMMIT TRANSACTION
  SELECT 'Proceso Concluido.'
  RETURN
END
GO
-- spReasignarAgente 'A1', 'PP'

/**************** spReasignarCobrador ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReasignarCobrador') and type = 'P') drop procedure dbo.spReasignarCobrador
GO             
CREATE PROCEDURE spReasignarCobrador
			@Empresa	char(5),
			@PersonalD	char(10),
			@PersonalA	char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo int

  IF NOT EXISTS(SELECT * FROM Personal WHERE Personal = @PersonalA)
    SELECT 'La Persona Indicada No Existe'
  ELSE BEGIN
    SELECT @Conteo = 0
    UPDATE Cxc SET PersonalCobrador = @PersonalA WHERE Empresa = @Empresa AND PersonalCobrador = @PersonalD AND Estatus = 'PENDIENTE'
    SELECT @Conteo = @@ROWCOUNT
  
    SELECT LTRIM(CONVERT(char, @Conteo))+' Movimientos Reasignados.'
  END
  RETURN
END
GO

/**************** spReevaluarLotesImportados ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReevaluarLotesImportados') and type = 'P') drop procedure dbo.spReevaluarLotesImportados
GO             
CREATE PROCEDURE spReevaluarLotesImportados
		    @Empresa		char(5),
		    @Usuario		char(10),
		    @FechaEmision 	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Moneda		char(10),
    @TipoCambio		float,
    @Renglon		float,
    @RenglonID		int,
    @UltAlmacen		char(10),
    @Almacen		char(10),
    @Articulo		char(20),
    @SubCuenta		varchar(20),
    @Unidad		varchar(50),
    @SerieLote		varchar(50),
    @Cantidad		float,
    @Costo		float,
    @Sucursal		int,
    @ReevaluacionID	int,
    @ReevaluacionMov	char(20),
    @Conteo		int,
    @UltFactor		float,
    @Factor		float,
    @Referencia		varchar(50),
    @Mensaje		varchar(255)

  SELECT @Conteo = 0, @UltAlmacen = NULL, @UltFactor = NULL
  SELECT @ReevaluacionMov = InvReevaluacion
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  CREATE TABLE #Lotes (
	ID			int		NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Almacen			char(10)	COLLATE Database_Default NULL,
	Articulo		char(20)	COLLATE Database_Default NULL,
	SubCuenta		varchar(20)	COLLATE Database_Default NULL,
	Unidad			varchar(50)	COLLATE Database_Default NULL,
        SerieLote		varchar(20)	COLLATE Database_Default NULL,
	Cantidad		float		NULL,
        Costo			float		NULL)


  INSERT INTO #Lotes (Almacen, Articulo, SubCuenta, Unidad, SerieLote, Cantidad, Costo)
  SELECT s.Almacen, d.Articulo, s.SubCuenta, d.Unidad, s.SerieLote, s.Existencia, "Costo" = (SUM(d.Cantidad*ISNULL(d.CostoInv, d.Costo))/SUM(d.Cantidad)*Mon.TipoCambio)/@TipoCambio
    FROM SerieLote s, SerieLoteMov m, Compra c, CompraD d, MovTipo mt, Mon
   WHERE s.Empresa = @Empresa AND s.Empresa = m.Empresa AND s.Articulo = m.Articulo AND s.SubCuenta = m.SubCuenta AND s.SerieLote = m.SerieLote 
     AND m.Modulo = 'COMS' AND m.ID = c.ID AND c.Estatus = 'CONCLUIDO' AND c.Empresa = s.Empresa
     AND d.ID = c.ID AND d.Almacen = s.Almacen AND d.Articulo = s.Articulo AND ISNULL(d.SubCuenta, '') = s.SubCuenta AND d.RenglonID = m.RenglonID
     AND mt.Modulo = m.Modulo AND mt.Mov = c.Mov AND mt.Clave IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI')
     AND c.TipoCambio <> 1 AND s.Existencia > 0
     AND Mon.Moneda = c.Moneda
   GROUP BY s.Almacen, d.Articulo, s.SubCuenta, d.Unidad, s.SerieLote, s.Existencia, Mon.TipoCambio
   ORDER BY s.Almacen, d.Articulo, s.SubCuenta, d.Unidad, s.SerieLote, s.Existencia, Mon.TipoCambio

  -- Generar Reevaluaciones
  SELECT @UltAlmacen = NULL
  DECLARE crLotes CURSOR FOR
   SELECT se.Factor, l.Almacen, a.Sucursal, l.Articulo, l.SubCuenta, l.Unidad, SUM(l.Cantidad)*se.Factor, SUM(l.Costo*l.Cantidad)/SUM(l.Cantidad)
     FROM SalidaEntrada se, #Lotes l, Alm a
    WHERE l.Almacen = a.Almacen
    GROUP BY se.Factor, l.Almacen, a.Sucursal, l.Articulo, l.SubCuenta, l.Unidad
    ORDER BY se.Factor, l.Almacen, a.Sucursal, l.Articulo, l.SubCuenta, l.Unidad

  OPEN crLotes
  FETCH NEXT FROM crLotes INTO @Factor, @Almacen, @Sucursal, @Articulo, @SubCuenta, @Unidad, @Cantidad, @Costo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN       
      IF @Factor <> @UltFactor OR @Almacen <> @UltAlmacen
      BEGIN
        IF @Factor = -1 SELECT @Referencia = 'Salida' ELSE SELECT @Referencia = 'Entrada' 
        INSERT Inv (Sucursal,  Empresa,  Mov,              FechaEmision,  Referencia,  Moneda,  TipoCambio,  Almacen,  Usuario,  Estatus)
            VALUES (@Sucursal, @Empresa, @ReevaluacionMov, @FechaEmision, @Referencia, @Moneda, @TipoCambio, @Almacen, @Usuario, 'CONFIRMAR')
        SELECT @ReevaluacionID = SCOPE_IDENTITY()
        SELECT @UltAlmacen = @Almacen, @UltFactor = @Factor, @Renglon = 0.0, @RenglonID = 0, @Conteo = @Conteo + 1
      END

      SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1
      IF @Factor = -1 SELECT @Costo = NULL
      INSERT InvD (Sucursal,  ID,              Renglon,  RenglonSub, RenglonID,  Almacen,  Articulo,  SubCuenta,              Unidad,  Cantidad,  CantidadInventario, Costo)
           VALUES (@Sucursal, @ReevaluacionID, @Renglon, 0,          @RenglonID, @Almacen, @Articulo, NULLIF(@SubCuenta, ''), @Unidad, @Cantidad, @Cantidad,          @Costo)
      INSERT SerieLoteMov (Sucursal,  Empresa,  Modulo, ID,              RenglonID,  Articulo,  SubCuenta,  SerieLote, Cantidad)
                    SELECT @Sucursal, @Empresa, 'INV',  @ReevaluacionID, @RenglonID, @Articulo, @SubCuenta, SerieLote, Cantidad
                      FROM #Lotes
                     WHERE Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta
    END
    FETCH NEXT FROM crLotes INTO @Factor, @Almacen, @Sucursal, @Articulo, @SubCuenta, @Unidad, @Cantidad, @Costo
  END -- While
  CLOSE crLotes
  DEALLOCATE crLotes

  SELECT @Mensaje = LTRIM(CONVERT(char, @Conteo))+' Reevaluaciones Generadas (por Confirmar).<BR><BR>Favor de Afectar Primero las Salidas y Despues las Entradas.'
  SELECT @Mensaje
  RETURN
END
GO

-- spReevaluarLotesImportados 'DEMO', 'DEMO', '1/1/3'

-- EXEC spSugerirABC 1, 'DEMO', '1/1/4', '1/1/5', 'Autos'
-- select * from abcsugerido
/**************** spSugerirABC ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirABC') and type = 'P') drop procedure dbo.spSugerirABC
GO             
CREATE PROCEDURE spSugerirABC
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Categoria		varchar(50),
    @ABC		char(1),
    @ABCPorcentaje	float,
    @Articulo		char(20),
    @Cantidad		float,
    @Valor		float,
    @ValorTotal		money,
    @Participacion	float,
    @ParticipacionAcum	float,
    @FechaHora		datetime

  EXEC spExplotarPresupuesto @Estacion, @Empresa, @FechaD, @FechaA
 
  SELECT @FechaHora = GETDATE()
  DELETE ABCSugeridoCat WHERE Estacion = @Estacion
  INSERT ABCSugeridoCat (Estacion, Categoria, FechaHora) SELECT @Estacion, Clave, @FechaHora FROM ListaSt WHERE Estacion = @Estacion

  DECLARE crArtCat CURSOR FOR
   SELECT Categoria 
     FROM ABCSugeridoCat 
    WHERE Estacion = @Estacion
  
  OPEN crArtCat
  FETCH NEXT FROM crArtCat INTO @Categoria
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      DELETE ABCSugerido WHERE Categoria = @Categoria
      UPDATE Art SET ABC = NULL WHERE Categoria = @Categoria
      SELECT @ABC = MIN(ABC) FROM ArtCatABC WHERE Categoria = @Categoria
      SELECT @ABCPorcentaje = ISNULL(Porcentaje, 0) FROM ArtCatABC WHERE Categoria = @Categoria AND ABC = @ABC

      SELECT @ValorTotal = NULLIF(SUM(e.Cantidad*a.CostoEstandar), 0)
        FROM ArtExplosion e
        JOIN Art a ON a.Articulo = e.Articulo AND a.Categoria = @Categoria
       WHERE e.Estacion = @Estacion AND NULLIF(e.Cantidad*a.CostoEstandar, 0) IS NOT NULL

      SELECT @ParticipacionAcum = 0.0
      DECLARE crArt CURSOR LOCAL FOR
       SELECT a.Articulo, ISNULL(e.Cantidad, 0), ISNULL(e.Cantidad*a.CostoEstandar, 0), ISNULL(e.Cantidad*a.CostoEstandar/@ValorTotal, 0)*100
         FROM Art a
         LEFT OUTER JOIN ArtExplosion e ON e.Articulo = a.Articulo AND e.Estacion = @Estacion 
        WHERE a.Categoria = @Categoria 
        ORDER BY e.Cantidad*a.CostoEstandar DESC

      OPEN crArt
      FETCH NEXT FROM crArt INTO @Articulo, @Cantidad, @Valor, @Participacion
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          IF @ParticipacionAcum + @Participacion > @ABCPorcentaje
          BEGIN
            SELECT @ABC = MIN(ABC) FROM ArtCatABC WHERE Categoria = @Categoria AND ABC > @ABC
            SELECT @ABCPorcentaje = @ABCPorcentaje + ISNULL(Porcentaje, 0) FROM ArtCatABC WHERE Categoria = @Categoria AND ABC = @ABC        
          END

          INSERT ABCSugerido 
                 (Categoria,  Articulo,   ABC,  Cantidad,  Valor,  Participacion)
          VALUES (@Categoria, @Articulo, @ABC, @Cantidad, @Valor, @Participacion)

          SELECT @ParticipacionAcum = @ParticipacionAcum + @Participacion
        END
        FETCH NEXT FROM crArt INTO @Articulo, @Cantidad, @Valor, @Participacion
      END
      CLOSE crArt
      DEALLOCATE crArt
    END
    FETCH NEXT FROM crArtCat INTO @Categoria
  END
  CLOSE crArtCat
  DEALLOCATE crArtCat

  SELECT 'Proceso Concluido.'
  RETURN
END
GO

/**************** spSugerirFacturaNConsumo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSugerirFacturaNConsumo') and type = 'P') drop procedure dbo.spSugerirFacturaNConsumo
GO             
CREATE PROCEDURE spSugerirFacturaNConsumo
                    @Estacion		int,
		    @Empresa		char(5),
		    @CteCNO		char(10),
		    @Moneda		char(10),
		    @TipoCambio		float,
		    @Renglon		float 		OUTPUT,
		    @RenglonID		int		OUTPUT,
		    @Ok			int 		OUTPUT,
		    @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Aseguradora	char(10),
    @Deducible		money,
    @ImporteDeducible	money,
    @AjusteCobertura	money,
    @DeducibleMoneda	char(10),
    @CoAseguro		float,
    @ImporteCoaseguro	money,
    @Importe		money,
    @ImporteMaximo	money,
    @ImporteCliente	money,
    @ImporteAseguradora	money,
    @SumaAseguradora	money,
    @SumaImporte	money,
    @PolizaImporte	money,
    @TipoSeguro		varchar(50),
    @EstaCubierto	bit,
    @Articulo		char(20),
    @ArtDeducible	char(20),
    @ArtCoaseguro	char(20),
    @ArtAjusteCobertura	char(20)

  SELECT @AjusteCobertura = 0.0
  SELECT @ArtDeducible       = NULLIF(NConsumoArtDeducible, ''),
         @ArtCoaseguro       = NULLIF(NConsumoArtCoaseguro, ''),
         @ArtAjusteCobertura = NULLIF(NConsumoArtAjusteCobertura, '')
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  IF @ArtDeducible IS NULL SELECT @Ok = 10031 ELSE
  IF @ArtCoaseguro IS NULL SELECT @Ok = 10032

  SELECT @Aseguradora = NULL
  SELECT @Aseguradora = NULLIF(RTRIM(c.Aseguradora), ''),
         @Deducible = (ISNULL(c.Deducible, 0.0)*CASE WHEN m.Moneda = @Moneda THEN @TipoCambio ELSE m.TipoCambio END)/@TipoCambio,
         @CoAseguro = c.CoAseguro,
         @TipoSeguro = NULLIF(RTRIM(c.PolizaTipo), ''),
         @PolizaImporte = NULLIF(c.PolizaImporte, 0.0)
    FROM Cte c, Mon m
   WHERE c.Cliente = @CteCNO AND m.Moneda = DeducibleMoneda

  IF @Ok IS NOT NULL OR @Aseguradora IS NULL RETURN

  SELECT @SumaImporte = 0.0, @SumaAseguradora = 0.0
  DECLARE crFactura CURSOR FOR 
   SELECT Articulo, ISNULL(Importe, 0.0)
     FROM SugerirFacturaNConsumo
    WHERE Estacion = @Estacion
  OPEN crFactura
  FETCH NEXT FROM crFactura INTO @Articulo, @Importe
  WHILE @@FETCH_STATUS <> -1 
  BEGIN                         
    IF @@FETCH_STATUS <> -2 AND @@ERROR = 0
    BEGIN
      SELECT @EstaCubierto = 1
      SELECT @SumaImporte = @SumaImporte + @Importe
      SELECT @ImporteMaximo = NULL, @ImporteCliente = 0.0, @ImporteAseguradora = 0.0

      SELECT @ImporteMaximo = NULLIF(ImporteMaximo, 0)
        FROM SeguroTipoPolizaEx
       WHERE Tipo = @TipoSeguro AND Articulo = @Articulo
      IF @@ROWCOUNT > 0 
        SELECT @EstaCubierto = 0
      ELSE
      IF @PolizaImporte IS NOT NULL
      BEGIN
        IF @SumaAseguradora + @AjusteCobertura < @PolizaImporte
        BEGIN
          IF @SumaAseguradora + @Importe > @PolizaImporte
            SELECT @EstaCubierto = 0, @AjusteCobertura = @PolizaImporte - @SumaAseguradora
        END ELSE
          SELECT @EstaCubierto = 0
      END

      IF @EstaCubierto = 1
        SELECT @ImporteAseguradora = @Importe, @SumaAseguradora = @SumaAseguradora + @Importe
      ELSE
        SELECT @ImporteCliente = @Importe

/*      IF @@ROWCOUNT = 0 AND (@PolizaImporte IS NULL OR @SumaAseguradora + @Importe <= @PolizaImporte)
        SELECT @EstaCubierto = 1, @ImporteAseguradora = @Importe, @SumaAseguradora = @SumaAseguradora + @Importe
      ELSE 
        SELECT @EstaCubierto = 0, @ImporteCliente = @Importe*/

/*      IF @@ROWCOUNT = 0
      BEGIN
        SELECT @EstaCubierto = 1
        IF @PolizaImporte IS NOT NULL AND @SumaAseguradora + @Importe > @PolizaImporte
          SELECT @AjusteCobertura = @PolizaImporte - (@SumaAseguradora + @Importe)
      END ELSE 
        SELECT @EstaCubierto = 0

      IF @EstaCubierto = 1
        SELECT @ImporteAseguradora = @Importe, @SumaAseguradora = @SumaAseguradora + @Importe
      ELSE
        SELECT @ImporteCliente = @Importe*/

      UPDATE SugerirFacturaNConsumo
         SET EstaCubierto = @EstaCubierto
       WHERE CURRENT OF crFactura
    END
    FETCH NEXT FROM crFactura INTO @Articulo, @Importe
  END
  CLOSE crFactura
  DEALLOCATE crFactura

  SELECT @SumaAseguradora = @SumaAseguradora + @AjusteCobertura
  IF @SumaAseguradora > @Deducible 
  BEGIN
    SELECT @ImporteDeducible = @Deducible 
    IF ISNULL(@ImporteDeducible, 0.0) <> 0.0
    BEGIN
      SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1
      INSERT SugerirFacturaNConsumo (
             Estacion,  Renglon,  RenglonID,  Articulo, Cantidad, Unidad, Importe,           Extra)
      SELECT @Estacion, @Renglon, @RenglonID, Articulo, 1,        Unidad, @ImporteDeducible, 1
        FROM Art
       WHERE Articulo = @ArtDeducible

      SELECT @SumaAseguradora = @SumaAseguradora - @ImporteDeducible 
  
      SELECT @ImporteCoaseguro = @SumaAseguradora * (@CoAseguro / 100.0)

      IF ISNULL(@ImporteCoaseguro, 0.0) <> 0.0
      BEGIN
        SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1
        INSERT SugerirFacturaNConsumo (
               Estacion,  Renglon,  RenglonID,  Articulo, Cantidad, Unidad, Importe,           Extra)
        SELECT @Estacion, @Renglon, @RenglonID, Articulo, 1,        Unidad, @ImporteCoaseguro, 1
          FROM Art
         WHERE Articulo = @ArtCoaseguro
      END
    END
    IF ISNULL(@AjusteCobertura, 0.0) <> 0.0
    BEGIN
      SELECT @Renglon = @Renglon + 2048, @RenglonID = @RenglonID + 1
      INSERT SugerirFacturaNConsumo (
             Estacion,  Renglon,  RenglonID,  Articulo, Cantidad, Unidad, Importe,          Extra, EstaCubierto)
      SELECT @Estacion, @Renglon, @RenglonID, Articulo, -1,       Unidad, @AjusteCobertura, 1,     1
        FROM Art
       WHERE Articulo = @ArtAjusteCobertura
    END
  END ELSE
    UPDATE SugerirFacturaNConsumo 
       SET EstaCubierto = 0 
     WHERE Estacion = @Estacion

  RETURN
END
GO

/**************** spTraspasarAuxiliar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTraspasarAuxiliar') and type = 'P') drop procedure dbo.spTraspasarAuxiliar
GO             
CREATE PROCEDURE spTraspasarAuxiliar
			@Empresa	char(5),
			@Modulo		char(5),
			@CuentaD	char(20),
			@CuentaA	char(20),
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal	int,
    @Rama	char(5),
    @Ejercicio	int,
    @Periodo	int,
    @Moneda	char(10),
    @Grupo	char(10),
    @SubCuenta	varchar(50),
    @Cargos	money,
    @Abonos	money,
    @Saldo	money

  -- Auxiliar
  UPDATE Auxiliar 
     SET Cuenta = @CuentaA 
    FROM Auxiliar a, Rama r
    WHERE a.Rama = r.Rama and r.Mayor = @Modulo AND a.Empresa = @Empresa AND a.Cuenta = @CuentaD

  -- Acumulados
  DECLARE crAcum CURSOR FOR
   SELECT a.Sucursal, a.Rama, a.Ejercicio, a.Periodo, a.Moneda, a.Grupo, a.SubCuenta, SUM(a.Cargos), SUM(a.Abonos)
     FROM Acum a, Rama r
    WHERE a.Rama = r.Rama and r.Mayor = @Modulo AND a.Empresa = @Empresa AND a.Cuenta = @CuentaD
    GROUP BY a.Sucursal, a.Rama, a.Ejercicio, a.Periodo, a.Moneda, a.Grupo, a.SubCuenta
    ORDER BY a.Sucursal, a.Rama, a.Ejercicio, a.Periodo, a.Moneda, a.Grupo, a.SubCuenta

  OPEN crAcum
  FETCH NEXT FROM crAcum INTO @Sucursal, @Rama, @Ejercicio, @Periodo, @Moneda, @Grupo, @SubCuenta, @Cargos, @Abonos
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      UPDATE Acum 
         SET Cargos = ISNULL(Cargos, 0) + ISNULL(@Cargos, 0),
             Abonos = ISNULL(Abonos, 0) + ISNULL(@Abonos, 0)
       WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Rama = @Rama AND Ejercicio = @Ejercicio AND Periodo = @Periodo AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @CuentaA AND SubCuenta = @SubCuenta
      IF @@ROWCOUNT = 0
        INSERT Acum (Sucursal, Empresa, Rama, Ejercicio, Periodo, Moneda, Grupo, Cuenta, SubCuenta, Cargos, Abonos)
             VALUES (@Sucursal, @Empresa, @Rama, @Ejercicio, @Periodo, @Moneda, @Grupo, @CuentaA, @SubCuenta, @Cargos, @Abonos)
    END
    FETCH NEXT FROM crAcum INTO @Sucursal, @Rama, @Ejercicio, @Periodo, @Moneda, @Grupo, @SubCuenta, @Cargos, @Abonos
  END
  CLOSE crAcum
  DEALLOCATE crAcum
  UPDATE Acum 
     SET Cargos = NULL, Abonos = NULL
    FROM Acum a, Rama r
   WHERE a.Rama = r.Rama and r.Mayor = @Modulo AND a.Empresa = @Empresa AND a.Cuenta = @CuentaD

  -- Saldos
  DECLARE crSaldo CURSOR FOR
   SELECT s.Sucursal, s.Rama, s.Moneda, s.Grupo, s.SubCuenta, SUM(s.Saldo)
     FROM Saldo s, Rama r
    WHERE s.Rama = r.Rama and r.Mayor = @Modulo AND s.Empresa = @Empresa AND s.Cuenta = @CuentaD
    GROUP BY s.Sucursal, s.Rama, s.Moneda, s.Grupo, s.SubCuenta
    ORDER BY s.Sucursal, s.Rama, s.Moneda, s.Grupo, s.SubCuenta

  OPEN crSaldo
  FETCH NEXT FROM crSaldo INTO @Sucursal, @Rama, @Moneda, @Grupo, @SubCuenta, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      UPDATE Saldo
         SET Saldo = ISNULL(Saldo, 0) + ISNULL(@Saldo, 0)
       WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @CuentaA AND SubCuenta = @SubCuenta
      IF @@ROWCOUNT = 0
        INSERT Saldo (Sucursal, Empresa, Rama, Moneda, Grupo, Cuenta, SubCuenta, Saldo)
              VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Grupo, @CuentaA, @SubCuenta, @Saldo)
    END
    FETCH NEXT FROM crSaldo INTO @Sucursal, @Rama, @Moneda, @Grupo, @SubCuenta, @Saldo
  END
  CLOSE crSaldo
  DEALLOCATE crSaldo
  UPDATE Saldo
     SET Saldo = NULL
    FROM Saldo s, Rama r
   WHERE s.Rama = r.Rama and r.Mayor = @Modulo AND s.Empresa = @Empresa AND s.Cuenta = @CuentaD

  RETURN
END
GO

/**************** spTraspasarMovimientos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTraspasarMovimientos') and type = 'P') drop procedure dbo.spTraspasarMovimientos
GO             
CREATE PROCEDURE spTraspasarMovimientos
			@Empresa	char(5),
			@Modulo		char(5),
			@CuentaD	char(20),
			@CuentaA	char(20)
			
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok	    	int,
    @OkRef	varchar(255),
    @Mensaje	varchar(255),
    @Conteo 	int

  SELECT @Conteo = 0, @Ok = NULL, @OkRef = NULL
  IF @CuentaD = @CuentaA SELECT @Ok = 40050
  IF @Modulo = 'CXC'
  BEGIN
    IF NOT EXISTS(SELECT * FROM Cte WHERE Cliente = @CuentaD) SELECT @Ok = 26060, @OkRef = @CuentaD ELSE
    IF NOT EXISTS(SELECT * FROM Cte WHERE Cliente = @CuentaA) SELECT @Ok = 26060, @OkRef = @CuentaA 
  END ELSE
  IF @Modulo = 'CXP'
  BEGIN
    IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = @CuentaD) SELECT @Ok = 26050, @OkRef = @CuentaD ELSE
    IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = @CuentaA) SELECT @Ok = 26050, @OkRef = @CuentaA 
  END 

  IF @Ok IS NULL
  BEGIN
    BEGIN TRANSACTION 

    IF @Modulo = 'CXC' UPDATE Cxc SET Cliente   = @CuentaA WHERE Empresa = @Empresa AND Cliente   = @CuentaD ELSE
    IF @Modulo = 'CXP' UPDATE Cxp SET Proveedor = @CuentaA WHERE Empresa = @Empresa AND Proveedor = @CuentaD
    SELECT @Conteo = @@ROWCOUNT
    EXEC spTraspasarAuxiliar @Empresa, @Modulo, @CuentaD, @CuentaA, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL 
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
  END
  IF @Ok IS NULL 
    SELECT @Mensaje = LTRIM(CONVERT(char, @Conteo))+' Movimientos Traspasados.'
  ELSE
    SELECT @Mensaje = RTRIM(Descripcion)+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

/**************** spTraspasarSaldos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTraspasarSaldos') and type = 'P') drop procedure dbo.spTraspasarSaldos
GO             
CREATE PROCEDURE spTraspasarSaldos
                    @Empresa	char(5),
		    @Ejercicio	int,
                    @Procesando bit = 0

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Ahora		datetime,
    @EjercicioAnterior	int,
    @Sucursal		int,
    @Rama		char(5), 
    @Moneda		char(10),
    @Grupo		char(10),
    @SubGrupo		varchar(10),
    @Cuenta		char(20),
    @SubCuenta		varchar(50),
    @Cargos		money,
    @Abonos		money,
    @CargoInicial	money,
    @AbonoInicial	money,
    @CargosU		float,
    @AbonosU		float,
    @CargoInicialU	float,
    @AbonoInicialU	float,
    @EjercicioInicio	datetime,
    @EjercicioFinal	datetime,
    @SeCreoEjercicio	bit,
    @SeModificioGral	bit,
    @Mensaje		char(150),

	@WMSAuxiliar	   bit -- TASK1964

  SELECT @Ahora = GETDATE(), @EjercicioAnterior = @Ejercicio - 1, @SeCreoEjercicio = 0, @SeModificioGral = 0

  BEGIN TRANSACTION
    /* Acum */
    DECLARE crAcum CURSOR FOR
     SELECT Sucursal, Rama, Moneda, Grupo, Cuenta, SubCuenta, "Cargos"=ISNULL(SUM(Cargos), 0.0), "Abonos"=ISNULL(SUM(Abonos), 0.0)
       FROM Acum
      WHERE Empresa = @Empresa AND Ejercicio = @EjercicioAnterior
      GROUP BY Sucursal, Rama, Moneda, Grupo, Cuenta, SubCuenta
      ORDER BY Sucursal, Rama, Moneda, Grupo, Cuenta, SubCuenta

    OPEN crAcum
    FETCH NEXT FROM crAcum INTO @Sucursal, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, @Cargos, @Abonos
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Cargos > @Abonos 
          SELECT @CargoInicial = @Cargos - @Abonos, @AbonoInicial = 0.0
        ELSE
          SELECT @CargoInicial = 0.0, @AbonoInicial = @Abonos - @Cargos

        UPDATE Acum
           SET Cargos 	    = @CargoInicial, Abonos = @AbonoInicial,
               UltimoCambio = @Ahora
         WHERE Sucursal  = @Sucursal
           AND Rama 	 = @Rama
           AND Empresa 	 = @Empresa 
           AND Ejercicio = @Ejercicio
           AND Periodo 	 = 0
           AND Moneda 	 = @Moneda
           AND Grupo 	 = @Grupo
           AND Cuenta 	 = @Cuenta
           AND SubCuenta = @SubCuenta

         IF @@ROWCOUNT = 0
         BEGIN
           SELECT @SeCreoEjercicio = 1
           INSERT Acum (Sucursal, Empresa, Rama, Ejercicio, Periodo, Moneda, Grupo, Cuenta, SubCuenta, Cargos, Abonos, UltimoCambio)
                VALUES (@Sucursal, @Empresa, @Rama, @Ejercicio, 0, @Moneda, @Grupo, @Cuenta, @SubCuenta, @CargoInicial, @AbonoInicial, @Ahora)
         END
      END
      FETCH NEXT FROM crAcum INTO @Sucursal, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, @Cargos, @Abonos
    END -- While
    CLOSE crAcum
    DEALLOCATE crAcum

    /* AcumU */
    DECLARE crAcumU CURSOR FOR
     SELECT Sucursal, Rama, Moneda, Grupo, SubGrupo, Cuenta, SubCuenta, "Cargos"=ISNULL(SUM(Cargos), 0.0), "Abonos"=ISNULL(SUM(Abonos), 0.0), "CargosU"=ISNULL(SUM(CargosU), 0.0), "AbonosU"=ISNULL(SUM(AbonosU), 0.0)
       FROM AcumU
      WHERE Empresa = @Empresa AND Ejercicio = @EjercicioAnterior
      GROUP BY Sucursal, Rama, Moneda, Grupo, SubGrupo, Cuenta, SubCuenta
      ORDER BY Sucursal, Rama, Moneda, Grupo, SubGrupo, Cuenta, SubCuenta
    OPEN crAcumU
    FETCH NEXT FROM crAcumU INTO @Sucursal, @Rama, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta, @Cargos, @Abonos, @CargosU, @AbonosU
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Cargos > @Abonos 
          SELECT @CargoInicial = @Cargos - @Abonos, @AbonoInicial = 0.0
        ELSE
          SELECT @CargoInicial = 0.0, @AbonoInicial = @Abonos - @Cargos

        IF @CargosU > @AbonosU 
          SELECT @CargoInicialU = @CargosU - @AbonosU, @AbonoInicialU = 0.0
        ELSE
          SELECT @CargoInicialU = 0.0, @AbonoInicialU = @AbonosU - @CargosU

        IF @WMSAuxiliar = 1 -- TASK1964
        BEGIN
          IF @SubGrupo <> '' -- TASK1964
          BEGIN
            UPDATE AcumUWMS
               SET Cargos 	    = @CargoInicial,  Abonos  = @AbonoInicial,
                   CargosU	    = @CargoInicialU, AbonosU = @AbonoInicialU,
                   UltimoCambio = @Ahora
             WHERE Sucursal  = @Sucursal
               AND Rama 	 = @Rama
               AND Empresa   = @Empresa 
               AND Ejercicio = @Ejercicio
               AND Periodo   = 0
               AND Moneda    = @Moneda
               AND Grupo     = @Grupo
               AND SubGrupo  = @SubGrupo
               AND Cuenta    = @Cuenta
               AND SubCuenta = @SubCuenta
 
            IF @@ROWCOUNT = 0
            BEGIN
               SELECT @SeCreoEjercicio = 1
               INSERT AcumUWMS (Sucursal, Empresa, Rama, Ejercicio, Periodo, Moneda, Grupo,  SubGrupo, Cuenta, SubCuenta, Cargos, Abonos, CargosU, AbonosU, UltimoCambio)
                        VALUES (@Sucursal, @Empresa, @Rama, @Ejercicio, 0, @Moneda, @Grupo,  @SubGrupo, @Cuenta, @SubCuenta, @CargoInicial, @AbonoInicial, @CargoInicialU, @AbonoInicialU, @Ahora)
            END
          END ELSE BEGIN -- TASK1964
            UPDATE AcumU
               SET Cargos 	    = @CargoInicial,  Abonos  = @AbonoInicial,
                   CargosU	    = @CargoInicialU, AbonosU = @AbonoInicialU,
                   UltimoCambio = @Ahora
             WHERE Sucursal  = @Sucursal
               AND Rama 	 = @Rama
               AND Empresa   = @Empresa 
               AND Ejercicio = @Ejercicio
               AND Periodo   = 0
               AND Moneda    = @Moneda
               AND Grupo     = @Grupo
               AND SubGrupo  = @SubGrupo
               AND Cuenta    = @Cuenta
               AND SubCuenta = @SubCuenta
 
            IF @@ROWCOUNT = 0
            BEGIN
               SELECT @SeCreoEjercicio = 1
               INSERT AcumU (Sucursal, Empresa, Rama, Ejercicio, Periodo, Moneda, Grupo,  SubGrupo, Cuenta, SubCuenta, Cargos, Abonos, CargosU, AbonosU, UltimoCambio)
                         VALUES (@Sucursal, @Empresa, @Rama, @Ejercicio, 0, @Moneda, @Grupo,  @SubGrupo, @Cuenta, @SubCuenta, @CargoInicial, @AbonoInicial, @CargoInicialU, @AbonoInicialU, @Ahora)
            END
          END -- TASK1964
        END ELSE BEGIN -- TASK1964
          EXEC dbo.sp_executesql N'
            UPDATE AcumU
               SET Cargos 	    = @CargoInicial,  Abonos  = @AbonoInicial,
                   CargosU	    = @CargoInicialU, AbonosU = @AbonoInicialU,
                   UltimoCambio = @Ahora
             WHERE Sucursal  = @Sucursal
               AND Rama 	 = @Rama
               AND Empresa   = @Empresa 
               AND Ejercicio = @Ejercicio
               AND Periodo   = 0
               AND Moneda    = @Moneda
               AND Grupo 	 = @Grupo
               AND SubGrupo  = @SubGrupo
               AND Cuenta    = @Cuenta
               AND SubCuenta = @SubCuenta
 
            IF @@ROWCOUNT = 0
            BEGIN
              SELECT @SeCreoEjercicio = 1
              INSERT AcumU (Sucursal, Empresa, Rama, Ejercicio, Periodo, Moneda, Grupo, SubGrupo, Cuenta, SubCuenta, Cargos, Abonos, CargosU, AbonosU, UltimoCambio)
                    VALUES (@Sucursal, @Empresa, @Rama, @Ejercicio, 0, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta, @CargoInicial, @AbonoInicial, @CargoInicialU, @AbonoInicialU, @Ahora)
            END',
            N'@Sucursal int, @Empresa varchar(5), @Rama varchar(5), @Ejercicio int, @Moneda varchar(20), @Grupo varchar(10), @SubGrupo varchar(20), @Cuenta varchar(20), 
			  @SubCuenta varchar(50), @CargoInicial money, @AbonoInicial money, @CargoInicialU float, @AbonoInicialU float, @Ahora datetime',
			  @Sucursal, @Empresa, @Rama, @Ejercicio, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta, @CargoInicial, @AbonoInicial, @CargoInicialU, @AbonoInicialU, @Ahora
        END -- TASK1964
      END
      FETCH NEXT FROM crAcumU INTO @Sucursal, @Rama, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta, @Cargos, @Abonos, @CargosU, @AbonosU
    END -- While
    CLOSE crAcumU
    DEALLOCATE crAcumU

    IF @Procesando = 0
    BEGIN
      SELECT @EjercicioInicio = EjercicioInicio, @EjercicioFinal = EjercicioFinal
        FROM EmpresaGral
       WHERE Empresa = @Empresa
      IF (DATEPART(yy, @EjercicioInicio) = @EjercicioAnterior) OR (DATEPART(yy, @EjercicioFinal) = @EjercicioAnterior)
      BEGIN
        SELECT @SeModificioGral = 1
        SELECT @EjercicioInicio = DATEADD(yy, 1, @EjercicioInicio), @EjercicioFinal = DATEADD(yy, 1, @EjercicioFinal)
        UPDATE EmpresaGral
           SET EjercicioInicio = @EjercicioInicio, EjercicioFinal = @EjercicioFinal
         WHERE Empresa = @Empresa
      END
    END
  COMMIT TRANSACTION

  IF @Procesando = 0
  BEGIN
    SELECT @Mensaje = "Proceso Concluido."
    IF @SeCreoEjercicio = 1 SELECT @Mensaje = RTRIM(@Mensaje) + '<BR><BR>Se Creo el Ejercicio: '+LTRIM(Convert(char, @Ejercicio))
    IF @SeModificioGral = 1 SELECT @Mensaje = RTRIM(@Mensaje) + '<BR><BR>Inicia: '+RTRIM(Convert(char, @EjercicioInicio, 103))
    IF @SeModificioGral = 1 SELECT @Mensaje = RTRIM(@Mensaje) + '<BR>Termina: '+RTRIM(Convert(char, @EjercicioFinal, 103))
    SELECT @Mensaje
  END
  RETURN
END
GO

/**************** spVentaActualizarPrecios ****************/
--if exists (select * from sysobjects where id = object_id('dbo.spVentaActualizarPrecios') and type = 'P') drop procedure dbo.spVentaActualizarPrecios
GO             
/*CREATE PROCEDURE spVentaActualizarPrecios
                    @ID		int
--//WITH ENCRYPTION
AS BEGIN
  UPDATE VentaD
     SET Precio = m.TipoCambio * d.Precio / d.PrecioTipoCambio,
         PrecioTipoCambio = m.TipoCambio
    FROM VentaD d, Mon m
   WHERE d.ID = @ID AND d.PrecioMoneda = m.Moneda
END*/
GO

/**************** spVentaActualizarPreciosChecar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaActualizarPreciosChecar') and type = 'P') drop procedure dbo.spVentaActualizarPreciosChecar
GO             
CREATE PROCEDURE spVentaActualizarPreciosChecar
                    @ID		int
--//WITH ENCRYPTION
AS BEGIN
  IF EXISTS(SELECT * FROM VentaD d, Mon m WHERE d.ID = @ID AND d.PrecioMoneda = m.Moneda AND d.PrecioTipoCambio <> m.TipoCambio)
    SELECT CONVERT(bit, 1)
  ELSE
    SELECT CONVERT(bit, 0)
END
GO

/**************** spVentaCancelarPicos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaCancelarPicos') and type = 'P') drop procedure dbo.spVentaCancelarPicos
GO             
CREATE PROCEDURE spVentaCancelarPicos
			@Empresa	char(5),
			@Unidad		varchar(50),
			@Tope		float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal		int,
    @ID			int,
    @Renglon		float,
    @RenglonSub		int,
    @Cantidad		float,
    @DescuentoGlobal	float,
    @SobrePrecio	float,
    @FechaCancelacion	datetime,
    @CfgMultiUnidades	bit

  SELECT @FechaCancelacion = GETDATE()
  SELECT @FechaCancelacion = DATEADD(ms, -DATEPART(ms, @FechaCancelacion), @FechaCancelacion)
  SELECT @CfgMultiUnidades = MultiUnidades FROM EmpresaCfg2 WHERE Empresa = @Empresa
  BEGIN TRANSACTION
    DECLARE crVentaD CURSOR FOR
     SELECT v.Sucursal, v.ID, d.Renglon, d.RenglonSub, d.CantidadPendiente
       FROM Venta v, VentaD d, MovTipo mt
      WHERE v.ID = d.ID 
        AND v.Mov = mt.Mov AND mt.Clave = 'VTAS.P' 
        AND v.Empresa = @Empresa AND v.Estatus = 'PENDIENTE'
        AND d.Unidad = @Unidad
        AND d.CantidadPendiente <= @Tope
    OPEN crVentaD
    FETCH NEXT FROM crVentaD INTO @Sucursal, @ID, @Renglon, @RenglonSub, @Cantidad
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        UPDATE VentaD SET CantidadCancelada = ISNULL(CantidadCancelada, 0.0) + @Cantidad, CantidadPendiente = NULL WHERE CURRENT OF crVentaD
        INSERT VentaDLogPicos (Sucursal, SucursalOrigen, ID, Renglon, RenglonSub, CantidadCancelada, FechaCancelacion) 
                       VALUES (@Sucursal, @Sucursal, @ID, @Renglon, @RenglonSub, @Cantidad, @FechaCancelacion)

      END
      FETCH NEXT FROM crVentaD INTO @Sucursal, @ID, @Renglon, @RenglonSub, @Cantidad
    END
    CLOSE crVentaD
    DEALLOCATE crVentaD

    DECLARE crVenta CURSOR FOR
     SELECT DISTINCT ID FROM VentaDLogPicos 
      WHERE FechaCancelacion = @FechaCancelacion
    OPEN crVenta
    FETCH NEXT FROM crVenta INTO @ID
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF NOT EXISTS(SELECT * FROM VentaD WHERE ID = @ID AND (ISNULL(CantidadPendiente, 0.0) <> 0.0 OR ISNULL(CantidadOrdenada, 0.0) <> 0.0 OR ISNULL(CantidadReservada, 0.0) <> 0.0))
        BEGIN
          UPDATE Venta SET Estatus = 'CONCLUIDO' WHERE ID = @ID
          SELECT @DescuentoGlobal = DescuentoGlobal, @SobrePrecio = SobrePrecio FROM Venta WHERE ID = @ID
	  EXEC spInvReCalcEncabezado @ID, 'VTAS', 0, @CfgMultiUnidades, @DescuentoGlobal, @SobrePrecio
        END
      END
      FETCH NEXT FROM crVenta INTO @ID
    END
    CLOSE crVenta
    DEALLOCATE crVenta
  COMMIT TRANSACTION
END
GO

/**************** spVentaSurtirColor ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaSurtirColor') and type = 'P') drop procedure dbo.spVentaSurtirColor
GO             
CREATE PROCEDURE spVentaSurtirColor
                    @Estacion		int,
		    @Accion		char(20),
		    @Cantidad		float,
		    @TipoCantidad	char(1)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @FechaRegistro	datetime,
    @Mov		char(20),
    @MovID		varchar(20),		
    @IDGenerar		int,		
    @ContID		int,		
    @Ok               	int,		
    @OkRef            	varchar(255),	
    @VolverAfectar	int,
    @UltID		int,
    @ID			int,
    @Renglon		float,
    @RenglonSub		int,
    @CantidadA		float,
    @SumaCantidad 	float,
    @Cuantos		int

  SELECT @FechaRegistro = GETDATE()
  SELECT @Accion = UPPER(@Accion), @Cuantos = 0, @UltID = NULL, @SumaCantidad = 0.0, @Ok = NULL, @VolverAfectar = 0
  BEGIN TRANSACTION
    DECLARE crLista CURSOR FOR
     SELECT ID, Renglon, RenglonSub
       FROM ListaIDRenglon
      WHERE Estacion = @Estacion
      ORDER BY ID, Renglon, RenglonSub
    OPEN crLista
    FETCH NEXT FROM crLista INTO @ID, @Renglon, @RenglonSub
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        DELETE ListaIDRenglon WHERE CURRENT OF crLista

        IF @UltID <> @ID 
        BEGIN
          UPDATE VentaD SET CantidadA = NULL WHERE ID = @ID

          IF @SumaCantidad > 0.0
          BEGIN
            EXEC spInv @UltID, 'VTAS', @Accion, 'SELECCION', @FechaRegistro, NULL, NULL, 1, 0, NULL,
                 @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @ContID OUTPUT,
                 @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT

            UPDATE VentaD SET CantidadA = NULL WHERE ID = @UltID
            SELECT @Cuantos = @Cuantos + 1
          END
          SELECT @UltID = @ID, @SumaCantidad = 0.0
        END

        IF @Accion = 'RESERVAR' 
          SELECT @CantidadA = CantidadPendiente FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
        ELSE
          SELECT @CantidadA = CantidadReservada FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
        IF @TipoCantidad = '%' SELECT @CantidadA = ROUND(@CantidadA * (@Cantidad/100.0), 0) ELSE
        IF @TipoCantidad = '#' SELECT @CantidadA = @Cantidad

        IF @CantidadA > 0.0
        BEGIN
          UPDATE VentaD 
             SET CantidadA = @CantidadA 
           WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub  

          SELECT @SumaCantidad = @SumaCantidad + @CantidadA
        END
      END
      FETCH NEXT FROM crLista INTO @ID, @Renglon, @RenglonSub
    END -- While
    CLOSE crLista
    DEALLOCATE crLista

    IF @SumaCantidad > 0.0
    BEGIN
      EXEC spInv @UltID, 'VTAS', @Accion, 'SELECCION', @FechaRegistro, NULL, NULL, 1, 0, NULL,
                 @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @ContID OUTPUT,
                 @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT
      UPDATE VentaD SET CantidadA = NULL WHERE ID = @UltID
      SELECT @Cuantos = @Cuantos + 1
    END
  COMMIT TRANSACTION
  SELECT RTRIM(Convert(char, @Cuantos))+' Movimiento(s) procesados.'
  RETURN
END
GO
/**************** spResultadoVendedores ****************/
if exists (select * from sysobjects where id = object_id('dbo.spResultadoVendedores') and type = 'P') drop procedure dbo.spResultadoVendedores
GO
CREATE PROC spResultadoVendedores
 @Empresa varchar(5),
 @Agente  varchar(10),
 @Moneda  varchar(10),
 @ArtCat  varchar(50),
 @FechaD  datetime,
 @FechaA  datetime
--//WITH ENCRYPTION
AS BEGIN

IF @Agente IN ('Todos', '(Todos)', 'Todas', '(Todas)', '') SELECT @Agente = NULL
IF @ArtCat IN ('Todos', '(Todos)', 'Todas', '(Todas)', '') SELECT @ArtCat = NULL

SELECT v.Agente, a.Categoria, ISNULL(ao.Importe,0) Objetivo, SUM(v.Importe) Venta,
       Porcentaje = CASE WHEN ISNULL(ao.Importe,0) = 0 THEN 0
                    ELSE SUM(v.Importe)/ISNULL(ao.Importe,0) END
  FROM Venta v
  JOIN MovTipo mt ON 'VTAS' = mt.Modulo AND v.Mov = mt.Mov
  JOIN VentaD vd ON v.ID = vd.ID
  JOIN Art a ON vd.Articulo = a.Articulo
  LEFT JOIN AgenteObjetivos ao ON v.Agente = ao.Agente AND a.Categoria = ao.ArtCat AND v.Moneda = ao.Moneda
 WHERE mt.Clave ='VTAS.F'
   AND v.Estatus = 'CONCLUIDO'
   AND v.Moneda = @Moneda
   AND v.Agente = ISNULL(@Agente, v.Agente)
   AND a.Categoria = ISNULL(@ArtCat, a.Categoria)
   AND v.FechaEmision BETWEEN @FechaD AND @FechaA
 GROUP BY v.Agente, a.Categoria, ao.Importe

-- SELECT * FROM AgenteObjetivos

RETURN
END
GO


/************************ spProcesarVentaRedondeo *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spProcesarVentaRedondeo') AND type = 'P') DROP PROCEDURE dbo.spProcesarVentaRedondeo
GO
CREATE PROCEDURE spProcesarVentaRedondeo
				 @Empresa			varchar(5),
				 @Sucursal			int,
				 @Usuario			varchar(10),
				 @FechaEmision		datetime

WITH ENCRYPTION
AS BEGIN

DECLARE @CfgFormaPagoOmision		varchar(50),
		@UsuarioDefFormaPago		varchar(50),
		@RedondeoVenta				bit,
		@RedondeoVentaCodigo		varchar(30),
		@RedondeoVentaMov			varchar(20),
		@RedondeoVentaProv			varchar(10),
		@RedondeoVentaConcepto		varchar(50),
		@RedondeoVentaCtaDinero		varchar(10),
		@RedondeoVentaCondicion		varchar(50),
		@RedondeosMonetarios		int,
		@ArtRedondeo				varchar(20),
		@ImporteRedondeo			money,
		@ContMoneda					varchar(10),
		@ContTipoCambio				float,
		@ProvDefMoneda				varchar(10),
		@ProvDefMonedaTC			float,
		@UltimoCambio				datetime,
		@Vencimiento				datetime,
		@Dias						int,
		@Ok							int,
		@OkRef						varchar(255),
		@IDNuevo					int,
		@MovID						varchar(20)

	BEGIN TRAN

	SET @UltimoCambio = GETDATE()
	SELECT @CfgFormaPagoOmision = NULLIF(FormaPagoOmision,'') 
	  FROM EmpresaCfg
	 WHERE Empresa = @Empresa

	SELECT @UsuarioDefFormaPago = ISNULL(NULLIF(DefFormaPago,''), @CfgFormaPagoOmision)
	  FROM Usuario 
	 WHERE Usuario = @Usuario

	SELECT @RedondeoVenta			= ISNULL(RedondeoVenta,0),
		   @RedondeoVentaCodigo		= NULLIF(RedondeoVentaCodigo,''),
		   @RedondeoVentaMov		= NULLIF(RedondeoVentaMov,''),
		   @RedondeoVentaProv		= NULLIF(RedondeoVentaProv,''),
		   @RedondeoVentaConcepto	= NULLIF(RedondeoVentaConcepto,''),
		   @RedondeoVentaCtaDinero	= NULLIF(RedondeoVentaCtaDinero,''),
		   @RedondeoVentaCondicion	= NULLIF(RedondeoVentaCondicion,''),
		   @RedondeosMonetarios		= ISNULL(RedondeosMonetarios,2)
	  FROM POSCfg 
	 WHERE Empresa = @Empresa

	SELECT @ContMoneda = ec.ContMoneda
      FROM EmpresaCfg ec	  
	 WHERE ec.Empresa = @Empresa

	SELECT @ContTipoCambio = TipoCambio FROM Mon WHERE Moneda = @ContMoneda

	SELECT @ProvDefMoneda = ISNULL(NULLIF(DefMoneda,''),@ContMoneda)
	  FROM Prov
	 WHERE Proveedor = @RedondeoVentaProv

	SELECT @ProvDefMonedaTC = TipoCambio FROM Mon WHERE Moneda = @ProvDefMoneda

	SELECT @ArtRedondeo	= NULLIF(Cuenta,'')
	  FROM CB 
	 WHERE Codigo = @RedondeoVentaCodigo

	CREATE TABLE #VentaRedondeo	(ID int NULL)
	DELETE FROM #VentaRedondeo

	INSERT INTO #VentaRedondeo (ID)
	SELECT v.ID 
	  FROM Venta v 
	  JOIN VentaD vd ON v.ID = vd.ID AND vd.Articulo = @ArtRedondeo
	 WHERE v.FechaEmision = @FechaEmision
	   AND v.POSRedondeoVerif = 0
	   AND v.Sucursal = @Sucursal
	   AND v.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
	 GROUP BY v.ID
	
	SELECT @ImporteRedondeo = ROUND(SUM(ISNULL(Precio, 0)),@RedondeosMonetarios)
	  FROM VentaD 
	 WHERE ID IN (SELECT ID FROM #VentaRedondeo)
	   AND Articulo = @ArtRedondeo

	IF @RedondeoVenta = 0
		SELECT @Ok = 20500, @OkRef = 'No esta Configurada esta Opción'

	IF (@RedondeoVentaCodigo IS NULL OR @RedondeoVentaMov  IS NULL OR @RedondeoVentaProv  IS NULL 
	   OR @RedondeoVentaCtaDinero IS NULL OR @RedondeoVentaCondicion IS NULL OR @ArtRedondeo IS NULL) AND @Ok IS NULL
		SELECT @Ok = 20500, @OkRef = 'Es necesario completar la Configuración'

	IF NOT EXISTS (SELECT * FROM #VentaRedondeo)
		SELECT @Ok = 60010, @OkRef = 'No hay Movimientos que Afectar'

	IF ISNULL(@ImporteRedondeo, 0) <= 0 AND @Ok IS NULL
		SELECT @Ok = 60010, @OkRef = 'El Importe de las Operaciones no es el Correcto'


	IF @Ok IS NULL
	BEGIN
		EXEC spCalcularVencimiento 'CXP', @Empresa, @RedondeoVentaProv, @RedondeoVentaCondicion, @FechaEmision, 
									@Vencimiento OUTPUT, @Dias OUTPUT, @Ok OUTPUT
	
		INSERT INTO Cxp (Empresa, Mov,					FechaEmision,  UltimoCambio,	Concepto,				Moneda,		TipoCambio,		 Usuario,  Estatus,		    
						Proveedor,			ProveedorMoneda, ProveedorTipoCambio,	CtaDinero,					Condicion,					Vencimiento,	FormaPago,				
						Importe,			Impuestos,	AplicaManual, Sucursal, SucursalOrigen)
		VALUES			(@Empresa, @RedondeoVentaMov,	@FechaEmision, @UltimoCambio,	@RedondeoVentaConcepto, @ContMoneda,@ContTipoCambio, @Usuario, 'SINAFECTAR',	
						@RedondeoVentaProv, @ProvDefMoneda,  @ProvDefMonedaTC,		@RedondeoVentaCtaDinero,	@RedondeoVentaCondicion,	@Vencimiento,	@UsuarioDefFormaPago,	
						@ImporteRedondeo,	0.00,		0,			  @Sucursal, @Sucursal)

		SELECT @IDNuevo = IDENT_CURRENT('Cxp')

		IF @@ERROR <> 0 SELECT @Ok = 1

		IF @Ok IS NULL
			EXEC spAfectar 'CXP', @IDNuevo, 'AFECTAR', 'Todo', NULL, @Usuario,	@EnSilencio = 1, @Conexion = 1, @Ok = @ok OUTPUT, @OkRef = @OkRef OUTPUT

		SELECT @MovID = MovID FROM Cxp WHERE ID = @IDNuevo

		IF @Ok IS NULL		
			INSERT INTO VentaOrigenRedondeo (ID, OrigenID, Sucursal)
			SELECT							 ID, @IDNuevo, @Sucursal
			  FROM #VentaRedondeo

		IF @@ERROR <> 0 SELECT @Ok = 1

		IF @Ok IS NULL		
			UPDATE Venta SET POSRedondeoVerif = 1 WHERE ID IN (SELECT ID FROM #VentaRedondeo)
	END

	IF @Ok IS NULL
	BEGIN
		COMMIT TRAN
		SELECT @OkRef = 'Se Generó el Movimiento ' + @RedondeoVentaMov + ' ' + @MovID
		
		SELECT @OkRef
	END
	ELSE
	BEGIN
		SELECT @OkRef = Descripcion + ', '  + @OkRef
		  FROM MensajeLista 
		 WHERE Mensaje = @Ok

		SELECT @OkRef
		ROLLBACK TRAN
	END

END
GO