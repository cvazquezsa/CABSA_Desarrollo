/* SP PRODUCCION      */

-- PROD.O = Orden Produccion
-- PROD.A = Avance
-- PROD.R = Retroceso
-- PROD.E = Entrada Produccion

SET ANSI_NULLS OFF

/************** spProdAutoSerieLote *************/
if exists (select * from sysobjects where id = object_id('dbo.spProdAutoSerieLote') and type = 'P') drop procedure dbo.spProdAutoSerieLote
GO
CREATE PROCEDURE spProdAutoSerieLote
			@AutoLote	char(20),
			@Sucursal	int,
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ProdSerieLote	char(20),
    @Articulo		char(20),
    @SubCuenta		varchar(50)

  IF @AutoLote NOT IN ('NIVEL ORDEN', 'NIVEL ARTICULO', 'NIVEL OPCION', 'NIVEL RENGLON') RETURN

  IF @AutoLote = 'NIVEL ORDEN'
  BEGIN
    IF EXISTS(SELECT * FROM ProdD WHERE ID = @ID AND NULLIF(RTRIM(ProdSerieLote), '') IS NULL)
    BEGIN
      EXEC spConsecutivo 'Lote', @Sucursal, @ProdSerieLote OUTPUT
      UPDATE ProdD SET ProdSerieLote = @ProdSerieLote WHERE ID = @ID AND NULLIF(RTRIM(ProdSerieLote), '') IS NULL
    END
  END ELSE
  BEGIN
    IF @AutoLote = 'NIVEL ARTICULO'
      DECLARE crProdD CURSOR FOR
       SELECT Articulo, CONVERT(char, NULL)
         FROM ProdD 
        WHERE ID = @ID AND NULLIF(RTRIM(ProdSerieLote), '') IS NULL
        GROUP BY Articulo 
    ELSE
    IF @AutoLote = 'NIVEL OPCION'
      DECLARE crProdD CURSOR FOR
       SELECT Articulo, SubCuenta
         FROM ProdD 
        WHERE ID = @ID AND NULLIF(RTRIM(ProdSerieLote), '') IS NULL
        GROUP BY Articulo, SubCuenta
    ELSE
      DECLARE crProdD CURSOR FOR
       SELECT Articulo, SubCuenta
         FROM ProdD 
        WHERE ID = @ID AND NULLIF(RTRIM(ProdSerieLote), '') IS NULL
    OPEN crProdD
    FETCH NEXT FROM crProdD INTO @Articulo, @SubCuenta
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spConsecutivo 'Lote', @Sucursal, @ProdSerieLote OUTPUT

        IF @AutoLote = 'NIVEL ARTICULO' UPDATE ProdD SET ProdSerieLote = @ProdSerieLote WHERE ID = @ID AND Articulo = @Articulo ELSE
        IF @AutoLote = 'NIVEL OPCION'   UPDATE ProdD SET ProdSerieLote = @ProdSerieLote WHERE ID = @ID AND Articulo = @Articulo AND SubCuenta = @SubCuenta 
        ELSE UPDATE ProdD SET ProdSerieLote = @ProdSerieLote WHERE CURRENT OF crProdD
      END
      FETCH NEXT FROM crProdD INTO @Articulo, @SubCuenta
    END
    CLOSE crProdD 
    DEALLOCATE crProdD 
  END
  RETURN 
END
GO


-- select * from cb where codigo like 'mx%'
-- spProdAutoCB 'NIVEL UNITARIO', 0, 11
/************** spProdAutoCB *************/
if exists (select * from sysobjects where id = object_id('dbo.spProdAutoCB') and type = 'P') drop procedure dbo.spProdAutoCB
GO
CREATE PROCEDURE spProdAutoCB
			@AutoCB		char(20),
			@Sucursal	int,
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Codigo		varchar(30),
    @SerieLote		varchar(50),
    @Articulo		varchar(20),
    @SubCuenta		varchar(50),
    @Unidad		varchar(50),
    @Cantidad		float,
    @a			int,
    @Cuantos		int

  IF @AutoCB NOT IN ('NIVEL LOTE', 'NIVEL ARTICULO', 'NIVEL OPCION', 'NIVEL UNITARIO') RETURN

  IF @AutoCB = 'NIVEL LOTE'
    DECLARE crProdD CURSOR FOR
     SELECT ProdSerieLote, CONVERT(char, NULL), CONVERT(char, NULL), CONVERT(char, NULL), SUM(Cantidad)
       FROM ProdD 
      WHERE ID = @ID 
      GROUP BY ProdSerieLote
  ELSE
  IF @AutoCB = 'NIVEL ARTICULO'
    DECLARE crProdD CURSOR FOR
     SELECT ProdSerieLote, Articulo, CONVERT(char, NULL), Unidad, SUM(Cantidad)
       FROM ProdD 
      WHERE ID = @ID 
      GROUP BY ProdSerieLote, Articulo, Unidad
  ELSE
  IF @AutoCB = 'NIVEL OPCION'
    DECLARE crProdD CURSOR FOR
     SELECT ProdSerieLote, Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), ''), SUM(Cantidad)
       FROM ProdD 
      WHERE ID = @ID 
      GROUP BY ProdSerieLote, Articulo, SubCuenta, Unidad
  ELSE
    DECLARE crProdD CURSOR FOR
     SELECT ProdSerieLote, Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), ''), ISNULL(Cantidad, 0)
       FROM ProdD 
      WHERE ID = @ID 
  OPEN crProdD
  FETCH NEXT FROM crProdD INTO @SerieLote, @Articulo, @SubCuenta, @Unidad, @Cantidad
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @a = 1, @Cuantos = 1 
      IF @AutoCB = 'NIVEL UNITARIO' SELECT @Cuantos = CONVERT(int, @Cantidad), @Cantidad = 1.0

      WHILE @a <= @Cuantos
      BEGIN
        EXEC spConsecutivo 'Codigo Barras', @Sucursal, @Codigo OUTPUT
        IF @AutoCB = 'NIVEL LOTE' 
        BEGIN
          UPDATE CB
             SET TipoCuenta = 'Lotes', Cuenta = @SerieLote, Modulo = 'PROD', ModuloID = @ID
           WHERE Codigo = @Codigo
          IF @@ROWCOUNT = 0
            INSERT CB (Codigo, TipoCuenta, Cuenta, Modulo, ModuloID) VALUES (@Codigo, 'Lotes', @SerieLote, 'PROD', @ID)
        END ELSE
        BEGIN
          UPDATE CB 
             SET TipoCuenta = 'Articulos', Cuenta = @Articulo, SubCuenta = @SubCuenta, Cantidad = @Cantidad, Unidad = @Unidad, SerieLote = @SerieLote, Modulo = 'PROD', ModuloID = @ID
           WHERE Codigo = @Codigo
          IF @@ROWCOUNT = 0
            INSERT CB (Codigo, TipoCuenta, Cuenta, SubCuenta, Cantidad, Unidad, SerieLote, Modulo, ModuloID) VALUES (@Codigo, 'Articulos', @Articulo, @SubCuenta, @Cantidad, @Unidad, @SerieLote, 'PROD', @ID)
        END
        SELECT @a = @a + 1
      END
    END
    FETCH NEXT FROM crProdD INTO @SerieLote, @Articulo, @SubCuenta, @Unidad, @Cantidad
  END
  CLOSE crProdD 
  DEALLOCATE crProdD 
  RETURN 
END
GO

-- select * from cb

/**************** spProdRutaCentroInicial ****************/
--if exists (select * from sysobjects where id = object_id('dbo.spProdRutaCentroInicial') and type = 'P') drop procedure dbo.spProdRutaCentroInicial
GO
/*CREATE PROCEDURE spProdRutaCentroInicial
                        @ID			int,
			@Renglon		float,
			@RenglonSub		int,
			@Ruta			varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Orden		int,
    @OrdenDestino	int, 
    @Centro		char(10),
    @CentroDestino	char(10)

  SELECT @Orden = NULL
  SELECT @Orden = MIN(Orden) FROM ProdRutaD WHERE Ruta = @Ruta
  SELECT @Centro = MIN(Centro) FROM ProdRutaD WHERE Ruta = @Ruta AND Orden = @Orden
  SELECT @OrdenDestino = MIN(Orden) FROM ProdRutaD WHERE Ruta = @Ruta AND Orden > @Orden
  SELECT @CentroDestino = Centro FROM ProdRutaD WHERE Ruta = @Ruta AND Orden = @OrdenDestino
  UPDATE ProdD 
     SET Centro = @Centro,
         CentroDestino = @CentroDestino,
         Orden = @Orden,
         OrdenDestino = @OrdenDestino
   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
END*/
GO

/**************** spProdExp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdExp') and type = 'P') drop procedure dbo.spProdExp
GO
CREATE PROCEDURE spProdExp
                        @ID			int,
			@Ruta			varchar(20),
			@ProdSerieLote		varchar(50),
    			@Producto		char(20),
    			@SubProducto		varchar(50),

    			@Articulo		char(20),
    			@SubCuenta		varchar(50),
    			@Cantidad		float,
    			@Unidad			varchar(50),
    			@Factor			float,
    			@Volumen		float,
    			@Almacen		char(10),

		    	@CfgMultiUnidades	bit,
		    	@CfgMultiUnidadesNivel	char(20),
			@CfgMermaIncluida	bit,
			@CfgDesperdicioIncluido bit,
			@CfgTipoMerma		char(1),

			@FechaRequerida		datetime,

			@RenglonExp		float	     OUTPUT,

   		   	@Ok             	int          OUTPUT,
    		   	@OkRef          	varchar(255) OUTPUT,
			@Modulo			char(5)	     = 'PROD',
			@RenglonID		int	     = NULL OUTPUT 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Veces		float,
    @ArtCantidad	float,
    @ArtUnidad		varchar(50),
    @ArtFactor	 	float,
    @ArtDecimales	int,
    @ArtTipo		char(20),
    @ArtTE		int,
    @ArtTEUnidad	char(10),
    @ArtEsFormula	bit,
    @SiOpcion		varchar(100),
    @Material		char(20),
    @mSubCuenta		varchar(50),
    @mCantidad		float,
    @mCantidadVeces	float,
    @mCantidadVecesNeto	float,
    @mUnidad		varchar(50),
    @mFactor		float,
    @mVolumen		float,
    @mMerma		float,
    @Merma		float,
    @mAlmacenOrigen	char(10), 
    @mAlmacenDestino	char(10),
    @mDesperdicio	float,
    @mCentro		char(10),
    @Desperdicio	float,
    @mCentroTipo	varchar(20),
    @mDecimales		int,
    @mFechaRequerida	datetime,
    @mTE		int,
    @mTEUnidad		char(10),
    @mArtTipo		char(20),
    @mArtTipoOpcion	char(20),
    @mArtEsFormula	bit,
    @UnaVez		bit,
    @Continuar		bit,
    @RenglonTipo	char(1),
    @RenglonSubNuevo	int

  SELECT @ArtCantidad = 0.0, @ArtUnidad = NULL, @UnaVez = 1
  SELECT @ArtCantidad = ISNULL(ProdCantidad, 0), @ArtUnidad = UnidadCompra, 
         @ArtTipo = Tipo, @ArtTE = ISNULL(TiempoEntrega, 0), @ArtTEUnidad = UPPER(ISNULL(TiempoEntregaUnidad, 'Dias')), 
         @ArtEsFormula = EsFormula
    FROM Art
   WHERE Articulo = @Articulo

  IF @ArtEsFormula = 0
    EXEC spDecTiempo @FechaRequerida, @ArtTE, @ArtTEUnidad, @mFechaRequerida OUTPUT 
  ELSE
    SELECT @mFechaRequerida = @FechaRequerida

  EXEC xpUnidadFactorProd @CfgMultiUnidades, @CfgMultiUnidadesNivel,
   		          @Articulo, @SubCuenta, @ArtUnidad, 
 		 	  @ArtFactor OUTPUT, @ArtDecimales OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @ArtCantidad = 0 OR @ArtFactor = 0.0 SELECT @Ok = 25030 
  IF @Ok IS NULL SELECT @Veces = (@Cantidad*@Factor) / (@ArtCantidad*@ArtFactor)

  IF ROUND(@Cantidad, 4) > 0.0 AND @Ok IS NULL
  BEGIN
    DECLARE crOrdenExp CURSOR LOCAL FOR 
     SELECT NULLIF(RTRIM(e.SiOpcion), ''), e.Material, NULLIF(RTRIM(e.SubCuenta), ''), ISNULL(e.Cantidad, 0.0), e.Unidad, NULLIF(e.Volumen, 0), ISNULL(e.Merma, 0.0), ISNULL(e.Desperdicio, 0.0), NULLIF(RTRIM(e.Almacen), ''), NULLIF(RTRIM(e.CentroTipo), ''), a.TiempoEntrega, a.TiempoEntregaUnidad, a.Tipo, a.TipoOpcion, a.EsFormula
       FROM ArtMaterial e, Art a
      WHERE e.Material = a.Articulo
        AND e.Articulo = @Articulo
      ORDER BY e.SiOpcion, e.Material, e.SubCuenta

    OPEN crOrdenExp
    FETCH NEXT FROM crOrdenExp INTO @SiOpcion, @Material, @mSubCuenta, @mCantidad, @mUnidad, @mVolumen, @mMerma, @mDesperdicio, @mAlmacenOrigen, @mCentroTipo, @mTE, @mTEUnidad, @mArtTipo, @mArtTipoOpcion, @mArtEsFormula
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        SELECT @Continuar = 1
        IF @SubCuenta IS NOT NULL AND @SiOpcion IS NOT NULL
          EXEC spOpcionContinuar @SiOpcion, @SubCuenta, @Continuar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF @Continuar = 1
        BEGIN
          EXEC xpUnidadFactorProd @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Material, @mSubCuenta, @mUnidad, @mFactor OUTPUT, @mDecimales OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL
          BEGIN
            IF @mSubCuenta IS NULL AND UPPER(@mArtTipoOpcion) = 'SI'
              EXEC spOpcionHeredar @SubCuenta, @Material, @mSubCuenta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
            ELSE IF CHARINDEX(':', @mSubCuenta) > 0 AND CHARINDEX(':', @SiOpcion) > 0 
              EXEC spOpcionHeredarRango @SiOpcion, @SubCuenta, @mSubCuenta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
         
            IF @Volumen IS NOT NULL AND @mVolumen IS NOT NULL
              SELECT @mCantidadVeces = @Volumen * @mVolumen
            ELSE 
              SELECT @mCantidadVeces = ROUND((@mCantidad/* *@mFactor*/) * @Veces, 10)

            SELECT @mCantidadVecesNeto = @mCantidadVeces

            IF @CfgTipoMerma = '#'
            BEGIN
              IF @CfgMermaIncluida       = 0 AND ISNULL(@mMerma, 0)       <> 0.0 SELECT @mCantidadVecesNeto = @mCantidadVecesNeto + @mMerma
              IF @CfgDesperdicioIncluido = 0 AND ISNULL(@mDesperdicio, 0) <> 0.0 SELECT @mCantidadVecesNeto = @mCantidadVecesNeto + @mDesperdicio
             END ELSE
            BEGIN
              IF @CfgMermaIncluida       = 0 AND ISNULL(@mMerma, 0)       <> 0.0 SELECT @mCantidadVecesNeto = @mCantidadVecesNeto * (1+(@mMerma/100))
              IF @CfgDesperdicioIncluido = 0 AND ISNULL(@mDesperdicio, 0) <> 0.0 SELECT @mCantidadVecesNeto = @mCantidadVecesNeto * (1+(@mDesperdicio/100))
            END
            SELECT @mCantidadVecesNeto = ROUND(@mCantidadVecesNeto, 10)

            IF @Modulo = 'PROD' 
            BEGIN
              IF @ArtEsFormula = 1
                SELECT @mAlmacenDestino = @Almacen
              ELSE BEGIN
                SELECT @mAlmacenDestino = NULL
                SELECT @mAlmacenDestino = MIN(c.Almacen),
                       @mCentro = MIN(c.Centro)
                  FROM ProdRutaD r, Centro c
                 WHERE r.Ruta = @Ruta AND r.Centro = c.Centro AND c.Tipo = @mCentroTipo

                IF @mCentroTipo IS NULL SELECT @Ok = 25310
                IF @mAlmacenDestino IS NULL SELECT @Ok = 25320
              END
            END

            IF @Ok IS NULL
              IF @mArtEsFormula = 1
	        EXEC spProdExp @ID, @Ruta, @ProdSerieLote, 
		               @Producto, @SubProducto, @Material, @mSubCuenta, @mCantidadVecesNeto, @mUnidad, @mFactor, @Volumen, @mAlmacenDestino,
			       @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CfgMermaIncluida, @CfgDesperdicioIncluido, @CfgTipoMerma, @mFechaRequerida, 
			       @RenglonExp OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
              ELSE 
              BEGIN
                IF @CfgTipoMerma = '#'
                  SELECT @Merma       = @mMerma, 
                         @Desperdicio = @mDesperdicio
                ELSE
                  SELECT @Merma       = CONVERT(float, @mCantidadVeces * (@mMerma/100)), 
                         @Desperdicio = CONVERT(float, @mCantidadVeces * (@mDesperdicio/100))
                       
                UPDATE ProdProgramaMaterial
                   SET CantidadP   = ISNULL(CantidadP,0) 	   + @Cantidad,
                       Cantidad    = ISNULL(Cantidad, 0)    	   + @mCantidadVecesNeto, 
                       Merma       = NULLIF(ISNULL(Merma, 0)       + @Merma, 0),
                       Desperdicio = NULLIF(ISNULL(Desperdicio, 0) + @Desperdicio, 0)
                 WHERE ID = @ID AND Producto = @Articulo AND SubProducto =  @SubCuenta AND Lote = @ProdSerieLote AND Articulo = @Material AND SubCuenta = @mSubCuenta AND Unidad = @mUnidad AND Factor = @mFactor AND AlmacenDestino = @mAlmacenDestino AND AlmacenOrigen = @mAlmacenOrigen AND FechaRequerida = @mFechaRequerida

                IF @@ROWCOUNT = 0
                BEGIN
                  SELECT @RenglonExp  = @RenglonExp + 2048, @RenglonID = @RenglonID + 1
                  IF @Modulo = 'PROD'
                    INSERT ProdProgramaMaterial (ID,  Renglon,     Producto,  SubProducto,  CantidadP, UnidadP, Lote,           Articulo,  SubCuenta,   Cantidad,            Unidad,   Factor,              AlmacenDestino,   AlmacenOrigen,   Merma,  Desperdicio,  FechaRequerida)
                                         VALUES (@ID, @RenglonExp, @Producto, @SubProducto, @Cantidad, @Unidad, @ProdSerieLote, @Material, @mSubCuenta, @mCantidadVecesNeto, @mUnidad, ISNULL(@mFactor, 1), @mAlmacenDestino, @mAlmacenOrigen, NULLIF(@Merma, 0), NULLIF(@Desperdicio, 0), @mFechaRequerida)
                  ELSE 
                  IF @Modulo = 'INV'
                    INSERT InvD (ID,  Renglon,     RenglonID,  ProdSerieLote,  Producto,  SubProducto,  Articulo,  SubCuenta,   Cantidad,            Unidad,   Tipo,     Factor,              Almacen,         CantidadInventario)
                         VALUES (@ID, @RenglonExp, @RenglonID, @ProdSerieLote, @Producto, @SubProducto, @Material, @mSubCuenta, @mCantidadVecesNeto, @mUnidad, 'Salida', ISNULL(@mFactor, 1), @mAlmacenOrigen, @mCantidadVecesNeto*ISNULL(@mFactor, 1))
                END
              END
          END
        END
        IF @Ok IS NOT NULL SELECT @OkRef = @Material
      END
      FETCH NEXT FROM crOrdenExp INTO @SiOpcion, @Material, @mSubCuenta, @mCantidad, @mUnidad, @mVolumen, @mMerma, @mDesperdicio, @mAlmacenOrigen, @mCentroTipo, @mTE, @mTEUnidad, @mArtTipo, @mArtTipoOpcion, @mArtEsFormula
    END
    CLOSE crOrdenExp
    DEALLOCATE crOrdenExp
  END
  IF @Ok IS NOT NULL 
    IF @OkRef IS NULL SELECT @OkRef = @Articulo ELSE SELECT @OkRef = RTRIM(@Articulo)+' / '+RTRIM(@OkRef)

  RETURN
END
GO


/**************** spProdOrdenConcentrada ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdOrdenConcentrada') and type = 'P') drop procedure dbo.spProdOrdenConcentrada
GO
CREATE PROCEDURE spProdOrdenConcentrada
			@Sucursal		int,
		 	@Empresa		char(5),
			@Usuario		char(10),
                        @AutoReservar		bit,
			@InvMov			char(20),
			@Almacen		char(10),
			@AlmacenDestino		char(10),

	           	@Modulo			char(5),
                        @ID			int,
	           	@Mov			char(20),
	           	@MovID			varchar(20),
			@FechaEmision		datetime,
			@FechaRegistro		datetime,

			@CfgMultiUnidades	bit, 
			@CfgMultiUnidadesNivel	char(20),

   		   	@Ok             	int          OUTPUT,
    		   	@OkRef          	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Accion			 char(20),
    @Articulo			 char(20),
    @SubCuenta			 varchar(50),
    @Ruta			 varchar(20),
    @Cantidad			 float,
    @Unidad			 varchar(50),
    @CantidadInventario		 float,
    @ArtTipo			 char(20),
    @ArtImpuesto1		 float,
    @ArtImpuesto2		 float,
    @ArtImpuesto3		 money,
    @InvID			 int,
    @InvMovID			 varchar(20),
    @InvEstatus		 	 char(15),
    @Renglon			 float,
    @RenglonID			 int,
    @RenglonSub			 int,
    @Costo			 money,
    @FechaRequerida		 datetime,
    @IDGenerar			 int,
    @ContID			 int,
    @VolverAfectar		 bit,
    @RenglonTipo		 char(1)

   INSERT Inv (OrigenTipo, Origen,  OrigenID, Empresa,   Sucursal,  Usuario,  Estatus,      Mov,     FechaEmision,  Proyecto,   Moneda,   TipoCambio,   Referencia,   Observaciones,   Prioridad,   Almacen,  AlmacenDestino)
        SELECT @Modulo,    p.Mov,   p.MovID,  p.Empresa, @Sucursal, @Usuario, 'SINAFECTAR', @InvMov, @FechaEmision, p.Proyecto, p.Moneda, m.TipoCambio, p.Referencia, p.Observaciones, p.Prioridad, @Almacen, @AlmacenDestino
         FROM Prod p, Mon m
        WHERE m.Moneda = p.Moneda AND p.ID = @ID 
  SELECT @InvID = SCOPE_IDENTITY()

  SELECT @Renglon = 0.0, @RenglonID = 0

  DECLARE crProdExp CURSOR FOR 
   SELECT Articulo, SubCuenta, Unidad, FechaRequerida, SUM(Cantidad)
     FROM ProdProgramaMaterial
    WHERE ID = @ID AND ISNULL(NULLIF(AlmacenOrigen, '(DEMANDA)'), @Almacen) = @Almacen AND AlmacenDestino = @AlmacenDestino
    GROUP BY Articulo, SubCuenta, Unidad, FechaRequerida
    ORDER BY Articulo, SubCuenta, Unidad, FechaRequerida
  OPEN crProdExp
  FETCH NEXT FROM crProdExp INTO @Articulo, @SubCuenta, @Unidad, @FechaRequerida, @Cantidad 
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL AND ISNULL(@Cantidad, 0) <> 0
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
      SELECT @ArtTipo       = Tipo,
             @ArtImpuesto1  = Impuesto1,
             @ArtImpuesto2  = Impuesto2,
             @ArtImpuesto3  = Impuesto3
        FROM Art 
       WHERE Articulo = @Articulo

      EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
      SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

      INSERT InvD (Sucursal,  ID,     Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Almacen,  Articulo,  SubCuenta,  Cantidad,  Unidad,  CantidadInventario,  FechaRequerida)
           VALUES (@Sucursal, @InvID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadInventario, @FechaRequerida)
    END
    FETCH NEXT FROM crProdExp INTO @Articulo, @SubCuenta, @Unidad, @FechaRequerida, @Cantidad 
  END
  CLOSE crProdExp
  DEALLOCATE crProdExp

  IF @RenglonID > 0
  BEGIN
    UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @InvID
    IF @AutoReservar = 1 SELECT @Accion = 'RESERVARPARCIAL' ELSE SELECT @Accion = 'AFECTAR'
    IF @Ok IS NULL
      EXEC spInv @InvID, 'INV', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                 @InvMov OUTPUT, @InvMovID OUTPUT, @IDGenerar OUTPUT, @ContID OUTPUT,
                 @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT 
  END ELSE
    DELETE Inv WHERE ID = @InvID
  RETURN
END
GO

/**************** spProdOrdenDesglosada ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdOrdenDesglosada') and type = 'P') drop procedure dbo.spProdOrdenDesglosada
GO
CREATE PROCEDURE spProdOrdenDesglosada
			@Sucursal		int,
		 	@Empresa		char(5),
			@Usuario		char(10),
                        @AutoReservar		bit,
			@GenerarOrdenConsumo	bit,
			@InvMov			char(20),
			@Almacen		char(10),
			@AlmacenDestino		char(10),

	           	@Modulo			char(5),
                        @ID			int,
	           	@Mov			char(20),
	           	@MovID			varchar(20),
			@FechaEmision		datetime,
			@FechaRegistro		datetime,

			@CfgMultiUnidades	bit, 
			@CfgMultiUnidadesNivel	char(20),

   		   	@Ok             	int          OUTPUT,
    		   	@OkRef          	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Accion			 char(20),
    @Estatus			 char(15),
    @Producto			 char(20),
    @SubProducto		 varchar(50),
    @Articulo			 char(20),
    @SubCuenta			 varchar(50),
    @Ruta			 varchar(20),
    @Cantidad			 float,
    @Unidad			 varchar(50),
    @CantidadInventario		 float,
    @Lote		 	 varchar(50),
    @Factor			 float,
    @ArtTipo			 char(20),
    @ArtTipoOpcion		 char(20),
    @ArtSeProduce		 bit,
    @ArtImpuesto1		 float,
    @ArtImpuesto2		 float,
    @ArtImpuesto3		 money,
    @Merma			 float,
    @Desperdicio		 float,
    @InvID			 int,
    @InvMovID			 varchar(20),
    @InvEstatus		 	 char(15),
    @Renglon			 float,
    @RenglonID			 int,
    @RenglonSub			 int,
    @Costo			 money,
    @FechaRequerida		 datetime,
    @IDGenerar			 int,
    @ContID			 int,
    @VolverAfectar		 bit,
    @RenglonTipo		 char(1),
    @DetalleTipo		 varchar(20)

   SELECT @Estatus = 'SINAFECTAR', @DetalleTipo = NULL
   IF @GenerarOrdenConsumo = 1 
     SELECT @DetalleTipo = 'Salida'
   
   INSERT Inv (Sucursal,  OrigenTipo, Origen,  OrigenID, Empresa,   Usuario,  Estatus,  Mov,     FechaEmision,  Proyecto,   Moneda,   TipoCambio,   Referencia,   Observaciones,   Prioridad,   Almacen,  AlmacenDestino,  VerLote)
        SELECT @Sucursal, @Modulo,    p.Mov,   p.MovID,  p.Empresa, @Usuario, @Estatus, @InvMov, @FechaEmision, p.Proyecto, p.Moneda, m.TipoCambio, p.Referencia, p.Observaciones, p.Prioridad, @Almacen, @AlmacenDestino, 1
         FROM Prod p, Mon m
        WHERE m.Moneda = p.Moneda AND p.ID = @ID 
  SELECT @InvID = SCOPE_IDENTITY()

  SELECT @Renglon = 0.0, @RenglonID = 0

  IF @GenerarOrdenConsumo = 1 
    DECLARE crProdExp CURSOR FOR 
     SELECT Producto, SubProducto, Lote, Articulo, SubCuenta, Unidad, FechaRequerida, Cantidad, Factor, Merma, Desperdicio
       FROM ProdProgramaMaterial
      WHERE ID = @ID AND AlmacenDestino = @Almacen 
      ORDER BY Lote, Articulo, SubCuenta, Unidad, FechaRequerida, Producto, SubProducto
  ELSE
    DECLARE crProdExp CURSOR FOR 
     SELECT Producto, SubProducto, Lote, Articulo, SubCuenta, Unidad, FechaRequerida, Cantidad, Factor, Merma, Desperdicio
       FROM ProdProgramaMaterial
      WHERE ID = @ID AND AlmacenOrigen = @Almacen AND AlmacenDestino = @AlmacenDestino
      ORDER BY Lote, Articulo, SubCuenta, Unidad, FechaRequerida, Producto, SubProducto

  OPEN crProdExp
  FETCH NEXT FROM crProdExp INTO @Producto, @SubProducto, @Lote, @Articulo, @SubCuenta, @Unidad, @FechaRequerida, @Cantidad, @Factor, @Merma, @Desperdicio
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL AND ISNULL(@Cantidad, 0) <> 0
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
      SELECT @ArtTipo       = Tipo,
             @ArtTipoOpcion = TipoOpcion,
             @ArtSeProduce  = SeProduce,
             @ArtImpuesto1  = Impuesto1,
             @ArtImpuesto2  = Impuesto2,
             @ArtImpuesto3  = Impuesto3
        FROM Art 
       WHERE Articulo = @Articulo

      EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
      SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

      INSERT InvD (Sucursal,  ID,      Renglon, RenglonSub, RenglonID,  RenglonTipo,  Almacen,  Producto,  SubProducto,  ProdSerieLote,  Articulo,  SubCuenta,  Cantidad,  Merma,  Desperdicio,  Unidad,  CantidadInventario, Factor,  FechaRequerida,  Tipo)
           VALUES (@Sucursal, @InvID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Almacen, @Producto, @SubProducto, @Lote,          @Articulo, @SubCuenta, @Cantidad, @Merma, @Desperdicio, @Unidad, @CantidadInventario, @Factor, @FechaRequerida, @DetalleTipo)
      IF @ArtTipoOpcion <> 'NO' AND NULLIF(RTRIM(@SubCuenta), '') IS NULL AND EXISTS(SELECT * FROM ArtOpcion WHERE Articulo = @Articulo AND Requerido = 1) SELECT @Ok = 20730, @OkRef = @Articulo
      IF @ArtTipoOpcion =  'NO' AND NULLIF(RTRIM(@SubCuenta), '') IS NOT NULL SELECT @Ok = 20740, @OkRef = @Articulo
    END
    FETCH NEXT FROM crProdExp INTO @Producto, @SubProducto, @Lote, @Articulo, @SubCuenta, @Unidad, @FechaRequerida, @Cantidad, @Factor, @Merma, @Desperdicio
  END
  CLOSE crProdExp
  DEALLOCATE crProdExp

  IF @RenglonID > 0
  BEGIN
    UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @InvID  
    IF @AutoReservar = 1 SELECT @Accion = 'RESERVARPARCIAL' ELSE SELECT @Accion = 'AFECTAR'  
    IF @Ok IS NULL
      EXEC spInv @InvID, 'INV', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                 @InvMov OUTPUT, @InvMovID OUTPUT, @IDGenerar OUTPUT, @ContID OUTPUT,
                 @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar
    IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT 
  END ELSE
    DELETE Inv WHERE ID = @InvID
  RETURN
END
GO

-- spProdExplotar 0, 'DEMO', 'DEMO', 'AFECTAR', 'PROD', 7, '1/1/1', 1, NULL, NULL

/**************** spProdExplotar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdExplotar') and type = 'P') drop procedure dbo.spProdExplotar
GO
CREATE PROCEDURE spProdExplotar
			@Sucursal		int,
		 	@Empresa		char(5),
			@Usuario		char(10),
                        @Accion			char(20),
	           	@Modulo			char(5),
                        @ID			int,
			@FechaRegistro		datetime,
			@Preliminar		bit,

   		   	@Ok             	int          OUTPUT,
    		   	@OkRef          	varchar(255) OUTPUT,
			@EnSilencio		bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mov			 char(20),
    @MovID			 varchar(20),
    @MovAlmacen			 char(10),
    @FechaEmision		 datetime,
    @CfgMovOrdenConsumo		 char(20),
    @CfgMovOrdenTransferencia	 char(20),
    @CfgMovSolicitudMaterial 	 char(20),
    @CfgTransferenciaConcentrada bit, 
    @CfgMermaIncluida		 bit,
    @CfgDesperdicioIncluido	 bit,
    @CfgMultiUnidades		 bit,
    @CfgMultiUnidadesNivel	 char(20),
    @CfgTipoMerma		 char(1),
    @CfgProdAutoLote		 char(20),
    @AutoReservar		 bit,
    @GenerarOrdenConsumo	 bit,
    @InvID			 int,
    @InvMov			 char(20),
    @InvMovID			 varchar(20),
    @InvEstatus		 	 char(15),
    @IDGenerar			 int,
    @ContID			 int,
    @VolverAfectar		 bit,
    @Renglon			 float,
    @RenglonID			 int,
    @RenglonSub			 int,
    @Articulo			 char(20),
    @SubCuenta			 varchar(50),
    @Cantidad			 float,
    @Volumen			 float,
    @Unidad			 varchar(50),
    @Factor			 float,
    @Almacen			 char(10),
    @AlmacenSucursal		 int,
    @AlmacenDestino		 char(10),
    @Ruta			 varchar(20),
    @FechaEntrega		 datetime,
    @FechaOrdenar		 datetime,
    @ProdSerieLote		 varchar(50),
    @ArtSeProduce		 bit,
    @Decimales			 int,
    @Refrencia			 varchar(50),
    @RenglonExp			 float

  IF @FechaRegistro IS NULL SELECT @FechaRegistro = GETDATE()
  SELECT @Mov          = Mov, 
         @MovID	       = MovID, 
         @MovAlmacen   = Almacen,
         @FechaEmision = FechaEmision
    FROM Prod
   WHERE ID = @ID

  -- Cancelar Todas la Solicitudes de Material Hechas
  IF @Accion = 'CANCELAR'
  BEGIN
    DECLARE crInv CURSOR FOR
    SELECT ID, Mov, MovID, Estatus
      FROM Inv
     WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

    OPEN crInv
    FETCH NEXT FROM crInv INTO @InvID, @InvMov, @InvMovID, @InvEstatus
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @InvEstatus NOT IN ('CONFIRMAR', 'PENDIENTE') SELECT @Ok = 60060
        IF EXISTS(SELECT * FROM Inv WHERE OrigenTipo = 'INV' and Origen = @InvMov AND OrigenID = @InvMovID AND Estatus = 'CONCLUIDO') SELECT @Ok = 60060

        IF @InvID IS NOT NULL AND @Ok IS NULL
          EXEC spInv @InvID, 'INV', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL,
                     @InvMov OUTPUT, @InvMovID OUTPUT, @IDGenerar OUTPUT, @ContID OUTPUT,
                     @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar
        IF @Ok IS NOT NULL SELECT @OkRef = 'Produccion - '+RTRIM(@InvMov)+' '+LTRIM(CONVERT(char, @InvMovID))
      END
      FETCH NEXT FROM crInv INTO @InvID, @InvMov, @InvMovID, @InvEstatus
    END
    CLOSE crInv
    DEALLOCATE crInv

    RETURN
  END

  SELECT @CfgMovOrdenTransferencia = ProdOrdenTransferencia,
         @CfgMovSolicitudMaterial  = ProdSolicitudMaterial,
         @CfgMovOrdenConsumo       = ProdOrdenConsumo
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa 

  SELECT @CfgMermaIncluida 	 = ProdMermaIncluida,
         @CfgDesperdicioIncluido = ProdDesperdicioIncluido,
         @GenerarOrdenConsumo    = ProdGenerarConsumo,
         @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'),
         @CfgTipoMerma		 = ISNULL(ProdTipoMerma, '%'),
         @CfgProdAutoLote	 = ISNULL(UPPER(ProdAutoLote) , 'NO'),
         @CfgTransferenciaConcentrada = ProdTransferenciaConcentrada
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF @Ok IS NOT NULL RETURN

  SELECT @AutoReservar = AutoReservar,
         @FechaEntrega = FechaEntrega
    FROM Prod 
   WHERE ID = @ID

  SELECT @RenglonExp = 0 

  IF @Preliminar = 1 
  BEGIN
    DELETE ProdProgramaMaterial WHERE ID = @ID
    DELETE ProdProgramaRuta     WHERE ID = @ID
    EXEC spProdAutoSerieLote @CfgProdAutoLote, @Sucursal, @ID
  END

  -- Explotar Orden Produccion
  IF NOT EXISTS (SELECT * FROM ProdProgramaMaterial WHERE ID = @ID)
  BEGIN
    DECLARE crOrden CURSOR FOR 
     SELECT d.Renglon, d.RenglonSub, d.Articulo, d.SubCuenta, ISNULL(d.Cantidad, 0), d.Unidad, d.Factor, NULLIF(d.Volumen, 0), d.Almacen, d.ProdSerieLote, d.Ruta, a.SeProduce
       FROM ProdD d, Art a
      WHERE d.ID = @ID  AND d.Articulo = a.Articulo AND AutoGenerado = 0
    OPEN crOrden
    FETCH NEXT FROM crOrden INTO @Renglon, @RenglonSub, @Articulo, @SubCuenta, @Cantidad, @Unidad, @Factor, @Volumen, @Almacen, @ProdSerieLote, @Ruta, @ArtSeProduce
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL AND @Cantidad > 0
      BEGIN
        /*EXEC xpUnidadFactorProd @CfgMultiUnidades, @CfgMultiUnidadesNivel,
   	   	                @Articulo, @SubCuenta, @Unidad, 
 		 	        @Factor OUTPUT, @Decimales OUTPUT, @Ok OUTPUT, @OkRef OUTPUT*/
        IF @Ok IS NULL
          IF @ArtSeProduce = 1 
          BEGIN
--            EXEC spProdRutaCentroInicial @ID, @Renglon, @RenglonSub, @Ruta
            EXEC spProdExp @ID, @Ruta, @ProdSerieLote, 
  		           @Articulo, @SubCuenta, @Articulo, @SubCuenta, @Cantidad, @Unidad, @Factor, @Volumen, @Almacen,
		           @CfgMultiUnidades, @CfgMultiUnidadesNivel, @CfgMermaIncluida, @CfgDesperdicioIncluido, @CfgTipoMerma,
			   @FechaEntrega, 
                           @RenglonExp OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

            UPDATE ProdProgramaRuta
               SET Cantidad    = ISNULL(Cantidad, 0)    + @Cantidad
             WHERE ID = @ID AND Producto = @Articulo AND SubProducto =  @SubCuenta AND Lote = @ProdSerieLote AND Unidad = @Unidad AND Ruta = @Ruta

            IF @@ROWCOUNT = 0
            BEGIN
              SELECT @RenglonExp  = @RenglonExp + 2048
              INSERT ProdProgramaRuta (ID,  Renglon, OrdenID, Producto,  SubProducto, Lote, Cantidad,  Unidad, Ruta, Centro, Operacion, Orden)
              SELECT @ID, @RenglonExp, r.OrdenID, @Articulo, @SubCuenta,  @ProdSerieLote, @Cantidad, @Unidad, @Ruta, r.Centro, r.Operacion, r.Orden
                FROM ProdRutaD r
               WHERE r.Ruta = @Ruta
            END

          END ELSE SELECT @Ok = 25010, @OkRef = @Articulo
        IF @Ruta IS NOT NULL
        BEGIN
          IF (SELECT TieneMovimientos FROM ProdRuta WHERE Ruta = @Ruta) = 0
            UPDATE ProdRuta SET TieneMovimientos = 1 WHERE Ruta = @Ruta 
        END
      END
      FETCH NEXT FROM crOrden INTO @Renglon, @RenglonSub, @Articulo, @SubCuenta, @Cantidad, @Unidad, @Factor, @Volumen, @Almacen, @ProdSerieLote, @Ruta, @ArtSeProduce
    END
    CLOSE crOrden
    DEALLOCATE crOrden
    EXEC spProdProgramaRutaCalcFechas @ID
  END

  IF @Preliminar = 1 UPDATE Prod SET Estatus = 'BORRADOR' WHERE ID = @ID


  IF @Preliminar = 0
  BEGIN
    -- Generar Ordenes Transferencia
    DECLARE crProdExpOT CURSOR FOR
     SELECT DISTINCT AlmacenOrigen, AlmacenDestino 
       FROM ProdProgramaMaterial 
      WHERE ID = @ID AND AlmacenOrigen <> AlmacenDestino
    OPEN crProdExpOT
    FETCH NEXT FROM crProdExpOT INTO @Almacen, @AlmacenDestino
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF UPPER(@Almacen) = '(DEMANDA)' SELECT @Almacen = @MovAlmacen
        SELECT @AlmacenSucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
        IF @CfgTransferenciaConcentrada = 1 
          EXEC spProdOrdenConcentrada @AlmacenSucursal, @Empresa, @Usuario, @AutoReservar, @CfgMovOrdenTransferencia, @Almacen, @AlmacenDestino,
  	                              @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, 
                                      @CfgMultiUnidades, @CfgMultiUnidadesNivel,
        		              @Ok OUTPUT, @OkRef OUTPUT
        ELSE
          EXEC spProdOrdenDesglosada @AlmacenSucursal, @Empresa, @Usuario, @AutoReservar, 0, @CfgMovOrdenTransferencia, @Almacen, @AlmacenDestino,
         	                     @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, 
                                     @CfgMultiUnidades, @CfgMultiUnidadesNivel,
    		                     @Ok OUTPUT, @OkRef OUTPUT

      END
      FETCH NEXT FROM crProdExpOT INTO @Almacen, @AlmacenDestino
    END
    CLOSE crProdExpOT
    DEALLOCATE crProdExpOT

    -- Generar Consumos
    IF @GenerarOrdenConsumo = 1 AND @Ok IS NULL
    BEGIN
      DECLARE crProdExpSM CURSOR FOR
       SELECT DISTINCT AlmacenDestino FROM ProdProgramaMaterial WHERE ID = @ID 
      OPEN crProdExpSM
      FETCH NEXT FROM crProdExpSM INTO @Almacen
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          SELECT @AlmacenSucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
          EXEC spProdOrdenDesglosada @AlmacenSucursal, @Empresa, @Usuario, 0, 1, @CfgMovOrdenConsumo, @Almacen, NULL,
           	                     @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, 
                                     @CfgMultiUnidades, @CfgMultiUnidadesNivel,
    		                     @Ok OUTPUT, @OkRef OUTPUT
        END
        FETCH NEXT FROM crProdExpSM INTO @Almacen
      END
      CLOSE crProdExpSM
      DEALLOCATE crProdExpSM
    END
  END

  IF @Ok IS NULL OR @Ok >= 80000
    EXEC xpProdExplotar @Sucursal, @Empresa, @Usuario, @Accion, @Modulo, @ID, @FechaRegistro,@Preliminar,@Ok OUTPUT,@OkRef OUTPUT
    
  IF @Preliminar = 1 AND @EnSilencio = 0
  BEGIN
    IF @Ok IS NULL
      EXEC spAfectar @Modulo, @ID, 'VERIFICAR', 'TODO', NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IN (NULL, 80000)
      SELECT "Mensaje" = CONVERT(Char, NULL)
    ELSE
      SELECT "Mensaje" = Descripcion + ' '+RTRIM(@OkRef) 
        FROM MensajeLista
       WHERE Mensaje = @Ok  
  END 
  
  RETURN
END
GO
	 
/* 
 SET NOCOUNT ON
 EXEC spProdExplotar 0, 'DEMO', 'DEMO', 'AFECTAR', 'PROD', 1, '1/1/1', 1, NULL, NULL
delete ProdProgramaMaterial
*/


/**************** spDemandaAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDemandaAceptar') and type = 'P') drop procedure dbo.spDemandaAceptar
GO             
CREATE PROCEDURE spDemandaAceptar
                    @Estacion	int,
		    @Modulo	char(5),
		    @ID		int,
    		    @MovTipo	char(20)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Sucursal			int,
    @Empresa			char(5),
    @Moneda			char(10),
    @TipoCambio			float,
    @CfgCompraCostoSugerido  	char(20),
    @Mov			char(20),
    @MovID			varchar(20),
    @Renglon			float,
    @RenglonID			int,
    @LModulo			char(5),
    @LID			int,
    @LRenglon			float,
    @LRenglonSub		int,
    @FechaEmision		datetime,
    @FechaRequerida		datetime,
    @FechaEntrega		datetime,
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @ProdRuta			varchar(20),
    @RenglonTipo		char(1),
    @Almacen			char(10),
    @Proveedor			char(10),
    @Cantidad			float,
    @CantidadInventario		float, 
    @Factor			float,
    @Unidad			varchar(50),
    @DescripcionExtra		varchar(100),
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @Retencion1			float,
    @Retencion2			float,
    @Retencion3			float,
    @Costo			money,
    @ProdSerieLote		char(20),
    @TiempoEntrega		int,
    @TiempoEntregaUnidad	varchar(10),
    @ListaPreciosEsp		varchar(20),
    @ZonaImpuesto		varchar(50), 
    @DescuentoCompra		float

  SELECT @Renglon = 0.0, @RenglonID = 0, @Proveedor = NULL, @ProdSerieLote = NULL
  IF @Modulo = 'PROD'
  BEGIN
    SELECT @Sucursal = Sucursal, @Empresa = Empresa, @Moneda = Moneda, @TipoCambio = TipoCambio, @FechaEmision = FechaEmision FROM Prod WHERE ID = @ID
    SELECT @Renglon = ISNULL(MAX(Renglon), 0.0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM ProdD WHERE ID = @ID 
  END ELSE
  IF @Modulo = 'INV'
  BEGIN
    SELECT @Sucursal = Sucursal, @Empresa = Empresa, @Moneda = Moneda, @TipoCambio = TipoCambio, @FechaEmision = FechaEmision FROM Inv WHERE ID = @ID
    SELECT @Renglon = ISNULL(MAX(Renglon), 0.0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM InvD WHERE ID = @ID 
  END ELSE
  IF @Modulo = 'COMS'
  BEGIN
    SELECT @Sucursal = Sucursal, @Empresa = Empresa, @Moneda = Moneda, @TipoCambio = TipoCambio, @Proveedor = Proveedor, @FechaEmision = FechaEmision, @ListaPreciosEsp = NULLIF(RTRIM(ListaPreciosEsp), ''), @ZonaImpuesto = ZonaImpuesto FROM Compra WHERE ID = @ID
    SELECT @Renglon = ISNULL(MAX(Renglon), 0.0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM CompraD WHERE ID = @ID 
  END

  SELECT @CfgCompraCostoSugerido = CompraCostoSugerido
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  BEGIN TRANSACTION
    DECLARE crLista CURSOR FOR
     SELECT Modulo, ID, Renglon, RenglonSub
       FROM ListaIDRenglon
      WHERE Estacion = @Estacion
      ORDER BY IDInterno

    OPEN crLista
    FETCH NEXT FROM crLista INTO @LModulo, @LID, @LRenglon, @LRenglonSub
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @DescripcionExtra = NULL
        IF @LModulo = 'VTAS'
          SELECT @Mov = e.Mov, @MovID = e.MovID, @RenglonTipo = RenglonTipo, @Articulo = d.Articulo, @SubCuenta = d.SubCuenta, @Almacen = d.Almacen, @Cantidad = d.CantidadPendiente, @Unidad = d.Unidad, @Factor = d.Factor, @FechaRequerida = d.FechaRequerida, @DescripcionExtra = d.DescripcionExtra
            FROM Venta e, VentaD d
           WHERE e.ID = d.ID AND d.ID = @LID AND d.Renglon = @LRenglon AND d.RenglonSub = @LRenglonSub
        ELSE
        IF @LModulo = 'INV'
          SELECT @Mov = e.Mov, @MovID = e.MovID, @RenglonTipo = RenglonTipo, @Articulo = d.Articulo, @SubCuenta = d.SubCuenta, @Almacen = d.Almacen, @Cantidad = d.CantidadPendiente, @Unidad = d.Unidad, @Factor = d.Factor, @FechaRequerida = d.FechaRequerida
            FROM Inv e, InvD d
           WHERE e.ID = d.ID AND d.ID = @LID AND d.Renglon = @LRenglon AND d.RenglonSub = @LRenglonSub

        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1,
               @CantidadInventario = @Cantidad * @Factor
        IF @Modulo = 'PROD'
        BEGIN
          SELECT @ProdRuta = ProdRuta, @TiempoEntrega = TiempoEntrega, @TiempoEntregaUnidad = TiempoEntregaUnidad FROM Art WHERE Articulo = @Articulo

          EXEC spIncTiempo @FechaEmision, @TiempoEntrega, @TiempoEntregaUnidad, @FechaEntrega OUTPUT
          INSERT ProdD (ID, Renglon, RenglonSub, RenglonID, RenglonTipo,  DestinoTipo, Destino, DestinoID, Articulo, SubCuenta,   Almacen,  Cantidad,  Unidad,  CantidadInventario,  FechaRequerida,  FechaEntrega,  DescripcionExtra,  ProdSerieLote,  Ruta) 
                VALUES (@ID, @Renglon, 0,        @RenglonID, @RenglonTipo, @LModulo,   @Mov,    @MovID,    @Articulo, @SubCuenta, @Almacen, @Cantidad, @Unidad, @CantidadInventario, @FechaRequerida, @FechaEntrega, @DescripcionExtra, @ProdSerieLote, @ProdRuta)
        END ELSE
        IF @Modulo = 'INV'
        BEGIN
          INSERT InvD (ID,  Renglon,  RenglonSub,RenglonID, RenglonTipo,  DestinoTipo, Destino, DestinoID, Articulo, SubCuenta,   Almacen,  Cantidad,  Unidad, CantidadInventario,  FechaRequerida) 
               VALUES (@ID, @Renglon, 0,        @RenglonID, @RenglonTipo, @LModulo,   @Mov,    @MovID,    @Articulo, @SubCuenta, @Almacen, @Cantidad, @Unidad, @CantidadInventario, @FechaRequerida)
        END ELSE
        IF @Modulo = 'COMS'
        BEGIN
          SELECT @Impuesto1 = Impuesto1, @Impuesto2 = Impuesto2, @Impuesto3 = Impuesto3, @Retencion1 = Retencion1, @Retencion2 = Retencion2, @Retencion3 = Retencion3, @DescuentoCompra = DescuentoCompra
            FROM Art
           WHERE Articulo = @Articulo

          EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
          EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
          EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
          EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Contacto = @Proveedor, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT
          IF @ListaPreciosEsp IS NOT NULL
            EXEC spPrecioEsp @ListaPreciosEsp, @Moneda, @Articulo, @SubCuenta, @Costo OUTPUT
          ELSE
            EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
           
          INSERT CompraD (ID, Renglon, RenglonSub, RenglonID, RenglonTipo,  DestinoTipo, Destino, DestinoID, Articulo, SubCuenta,   Almacen,  Cantidad,  Unidad, CantidadInventario,  FechaRequerida,  Impuesto1,  Impuesto2,  Impuesto3,  Retencion1,  Retencion2,  Retencion3,  Costo,  DescripcionExtra, DescuentoLinea) 
                 VALUES (@ID, @Renglon, 0,        @RenglonID, @RenglonTipo, @LModulo,   @Mov,    @MovID,    @Articulo, @SubCuenta, @Almacen, @Cantidad, @Unidad, @CantidadInventario, @FechaRequerida, @Impuesto1, @Impuesto2, @Impuesto3, @Retencion1, @Retencion2, @Retencion3, @Costo, @DescripcionExtra, @DescuentoCompra)
        END
      END
      FETCH NEXT FROM crLista INTO @LModulo, @LID, @LRenglon, @LRenglonSub
    END -- While
    CLOSE crLista
    DEALLOCATE crLista

    IF @Modulo = 'PROD' 
    BEGIN
      SELECT @FechaEntrega = MIN(FechaRequerida) FROM ProdD WHERE ID = @ID
      UPDATE Prod   SET VerDestino = 1, RenglonID = @RenglonID, FechaEntrega = @FechaEntrega WHERE ID = @ID 
    END ELSE
    IF @Modulo = 'INV' 
      UPDATE Inv SET VerDestino = 1, RenglonID = @RenglonID WHERE ID = @ID
    ELSE
    IF @Modulo = 'COMS' UPDATE Compra SET VerDestino = 1, RenglonID = @RenglonID WHERE ID = @ID

    DELETE ListaIDRenglon WHERE Estacion = @Estacion
  COMMIT TRANSACTION
  RETURN
END
GO


/**************** spOfertaAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaAceptar') and type = 'P') drop procedure dbo.spOfertaAceptar
GO             
CREATE PROCEDURE spOfertaAceptar
                    @Estacion	int,
		    @Modulo	char(5),
		    @ID		int,
    		    @MovTipo	char(20)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Sucursal			int,
    @Empresa			char(5),
    @Moneda			char(10),
    @TipoCambio			float,
    @CfgCompraCostoSugerido  	char(20),
    @Mov			char(20),
    @MovInserta     varchar(20),
    @MovID			varchar(20),
    @Renglon			float,
    @RenglonID			int,
    @LModulo			char(5),
    @LID			int,
    @LRenglon			float,
    @LRenglonSub		int,
    @FechaEmision		datetime,
    @FechaRequerida		datetime,
    @FechaEntrega		datetime,
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @ProdRuta			varchar(20),
    @RenglonTipo		char(1),
    @Almacen			char(10),
    @Proveedor			char(10),
    @ProveedorD			char(10),
    @Referencia			varchar(50),
    @ReferenciaD		varchar(50),
    @Cantidad			float,
    @CantidadInventario		float, 
    @Factor			float,
    @Unidad			varchar(50),
    @DescripcionExtra		varchar(100),
    @DescuentoTipo		char(1),
    @DescuentoLinea		float,
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @Retencion1			float,
    @Retencion2			float,
    @Retencion3			float,
    @Costo			money,
    @ProdSerieLote		char(20),
    @TiempoEntrega		int,
    @TiempoEntregaUnidad	varchar(10),
    @ListaPreciosEsp		varchar(20),
    @ImportacionProveedor	varchar(10),
    @ImportacionReferencia	varchar(50),
    @Pais			varchar(50),
    @TratadoComercial		varchar(50),
    @ProgramaSectorial		varchar(50),
    @ValorAduana		money,
    @ID1			char(2),
    @ID2			char(2),
    @FormaPago			varchar(50),
    @ImportacionImpuesto1	float,
    @ImportacionImpuesto2	float,
    @MonedaD                varchar(10),
    @TipoCambioD            float,
    @Destino                varchar(20),
    @DestinoID              varchar(20),
    @SubClave               varchar(20)


  SELECT @Renglon = 0.0, @RenglonID = 0, @Proveedor = NULL, @ProdSerieLote = NULL, @ImportacionProveedor = NULL, @ImportacionReferencia = NULL
  IF @Modulo = 'COMS'
  BEGIN
    SELECT @Sucursal = Sucursal, @Empresa = Empresa, @MovInserta = Mov, @Moneda = Moneda, @TipoCambio = TipoCambio, @Proveedor = Proveedor, @Referencia = Referencia, @FechaEmision = FechaEmision, @ListaPreciosEsp = NULLIF(RTRIM(ListaPreciosEsp), '') FROM Compra WHERE ID = @ID
    SELECT @Renglon = ISNULL(MAX(Renglon), 0.0), @RenglonID = ISNULL(MAX(RenglonID), 0) FROM CompraD WHERE ID = @ID 
  END

  BEGIN TRANSACTION
    DECLARE crLista CURSOR FOR
     SELECT l.Modulo, l.ID, l.Renglon, l.RenglonSub
       FROM ListaIDRenglon l
      WHERE l.Estacion = @Estacion
      ORDER BY l.Modulo, l.ID, l.Renglon, l.RenglonSub

    OPEN crLista
    FETCH NEXT FROM crLista INTO @LModulo, @LID, @LRenglon, @LRenglonSub
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @DescripcionExtra = NULL
        SELECT @Renglon = @Renglon + 2048.0

        IF @LModulo = 'COMS'
        BEGIN
          SELECT @Mov = e.Mov, @MovID = e.MovID, @RenglonTipo = RenglonTipo, @Articulo = d.Articulo, @SubCuenta = d.SubCuenta, @Almacen = d.Almacen, @Cantidad = d.CantidadPendiente, @Unidad = d.Unidad, @Factor = d.Factor, @FechaRequerida = d.FechaRequerida, 
                 @DescripcionExtra = d.DescripcionExtra, @DescuentoTipo = DescuentoTipo, @DescuentoLinea = DescuentoLinea,
                 @Impuesto1 = Impuesto1, @Impuesto2 = Impuesto2, @Impuesto3 = Impuesto3, @Retencion1 = Retencion1, @Retencion2 = Retencion2, @Retencion3 = Retencion3, @Costo = d.Costo,
                 @ProveedorD = e.Proveedor, @ReferenciaD = e.Referencia, @Pais = d.Pais, @TratadoComercial = d.TratadoComercial, @ProgramaSectorial = d.ProgramaSectorial, @ValorAduana = d.ValorAduana, @ID1 = d.ID1, @ID2 = d.ID2,
    	         @FormaPago = d.FormaPago, @ImportacionImpuesto1 = d.ImportacionImpuesto1, @ImportacionImpuesto2 = d.ImportacionImpuesto2, @MonedaD = e.Moneda, @TipocambioD = e.TipoCambio,
               @Destino=d.Destino, @DestinoID=d.DestinoID
            FROM Compra e, CompraD d
           WHERE e.ID = d.ID AND d.ID = @LID AND d.Renglon = @LRenglon AND d.RenglonSub = @LRenglonSub
        END

        SELECT @CantidadInventario = @Cantidad * @Factor

        IF @Modulo = 'COMS'
        BEGIN      
          SELECT @SubClave = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @MovInserta
          
          IF @MovTipo = 'COMS.EI' OR @SubClave = 'COMS.EIMPO' SELECT @ImportacionProveedor = @ProveedorD, @ImportacionReferencia = @ReferenciaD
          INSERT CompraD (ID, Renglon, RenglonSub, RenglonID, RenglonTipo,  Aplica,  AplicaID,  Articulo,  SubCuenta,  Almacen,  Cantidad,  Unidad,  CantidadInventario,  FechaRequerida,  Impuesto1,  Impuesto2,  Impuesto3,  Retencion1,  Retencion2,  Retencion3,  Costo,  DescripcionExtra,  DescuentoTipo,  DescuentoLinea,  ImportacionProveedor,  ImportacionReferencia,  Pais,  TratadoComercial,  ProgramaSectorial,  ValorAduana,  ID1,  ID2,  FormaPago,  ImportacionImpuesto1,  ImportacionImpuesto2, MonedaD, TipoCambioD,Destino, DestinoID)
                 VALUES (@ID, @Renglon, 0,        @RenglonID, @RenglonTipo, @Mov,    @MovID,    @Articulo, @SubCuenta, @Almacen, @Cantidad, @Unidad, @CantidadInventario, @FechaRequerida, @Impuesto1, @Impuesto2, @Impuesto3, @Retencion1, @Retencion2, @Retencion3, @Costo, @DescripcionExtra, @DescuentoTipo, @DescuentoLinea, @ImportacionProveedor, @ImportacionReferencia, @Pais, @TratadoComercial, @ProgramaSectorial, @ValorAduana, @ID1, @ID2, @FormaPago, @ImportacionImpuesto1, @ImportacionImpuesto2, @MonedaD, @TipoCambioD, @Destino, @DestinoID)
        END
      END
      FETCH NEXT FROM crLista INTO @LModulo, @LID, @LRenglon, @LRenglonSub
    END -- While
    CLOSE crLista
    DEALLOCATE crLista

    SELECT @RenglonID = 0
    IF @Modulo = 'COMS' 
    BEGIN
      DECLARE crRenglonID CURSOR FOR
       SELECT RenglonTipo
         FROM CompraD 
        WHERE ID = @ID
        ORDER BY Renglon, RenglonSub
      OPEN crRenglonID
      FETCH NEXT FROM crRenglonID INTO @RenglonTipo
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          IF @RenglonTipo NOT IN ('C', 'E') SELECT @RenglonID = @RenglonID + 1
          UPDATE CompraD SET RenglonID = @RenglonID WHERE CURRENT OF crRenglonID
        END
        FETCH NEXT FROM crRenglonID INTO @RenglonTipo
      END -- While
      CLOSE crRenglonID
      DEALLOCATE crRenglonID
      UPDATE Compra SET Directo = 0, RenglonID = @RenglonID WHERE ID = @ID
    END

    DELETE ListaIDRenglon WHERE Estacion = @Estacion
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spProdAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdAceptar') and type = 'P') drop procedure dbo.spProdAceptar
GO             
CREATE PROCEDURE spProdAceptar
                    @Estacion	int,
		    @ID		int,
    		    @MovTipo	char(20)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @DestinoTipo	char(10),
    @Destino		char(20),
    @DestinoID		varchar(20),
    @Aplica		char(20),
    @AplicaID		varchar(20),
    @Renglon		float,
    @RenglonID		int,
    @LModulo		char(5),
    @LID		int,
    @LRenglon		float,
    @LRenglonSub	int,
    @FechaRequerida	datetime,
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @ProdRuta		varchar(20),
    @RenglonTipo	char(1),
    @Almacen		char(10),
    @Cantidad		float,
    @Unidad		varchar(50),
    @Factor		float,
    @Costo		money,
    @ProdSerieLote	varchar(50),
    @ArtTipo		char(20),
    @Centro		char(10)

  SELECT @Renglon = 0.0, @RenglonID = 0
  SELECT @Renglon = ISNULL(MAX(Renglon), 0.0), @RenglonID = ISNULL(MAX(RenglonID), 0) 
    FROM ProdD 
   WHERE ID = @ID 
  
  BEGIN TRANSACTION
    DECLARE crLista CURSOR FOR
     SELECT Modulo, ID, Renglon, RenglonSub
       FROM ListaIDRenglon
      WHERE Estacion = @Estacion
      ORDER BY IDInterno

    OPEN crLista
    FETCH NEXT FROM crLista INTO @LModulo, @LID, @LRenglon, @LRenglonSub
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Aplica = p.Mov, @AplicaID = p.MovID, @DestinoTipo = d.DestinoTipo, @Destino = d.Destino, @DestinoID = d.DestinoID, 
               @Articulo = d.Articulo, @SubCuenta = d.SubCuenta, @Almacen = d.Almacen, @Costo = d.Costo, @Unidad = d.Unidad, @Factor = d.Factor, @ProdSerieLote = d.ProdSerieLote, @ArtTipo = a.Tipo, @FechaRequerida = d.FechaRequerida, 
               @Cantidad = d.CantidadPendiente,
               @Centro = CASE WHEN @MovTipo IN ('PROD.A', 'PROD.R', 'PROD.E') THEN d.Centro ELSE NULL END,
               @ProdRuta = a.ProdRuta
          FROM Prod p, ProdD d, Art a
         WHERE p.ID = d.ID AND a.Articulo = d.Articulo 
           AND p.ID = @LID AND d.Renglon = @LRenglon AND d.RenglonSub = @LRenglonSub

	SELECT @Costo = NULL
        IF @MovTipo <> 'PROD.O' SELECT @DestinoTipo = NULL, @Destino = NULL, @DestinoID = NULL

        EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

        INSERT ProdD (ID, Renglon,   RenglonSub, RenglonID,  RenglonTipo,  Aplica,  AplicaID,  DestinoTipo,  Destino,  DestinoID,  Articulo,  SubCuenta,  Almacen,  Cantidad,  Unidad,   Factor,  Costo,  Centro, ProdSerieLote,  Ruta,      FechaRequerida)
              VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Aplica, @AplicaID, @DestinoTipo, @Destino, @DestinoID, @Articulo, @SubCuenta, @Almacen, @Cantidad, @Unidad, @Factor, @Costo, @Centro, @ProdSerieLote, @ProdRuta, @FechaRequerida) 
      END
      FETCH NEXT FROM crLista INTO @LModulo, @LID, @LRenglon, @LRenglonSub
    END -- While
    CLOSE crLista
    DEALLOCATE crLista

    UPDATE Prod   
       SET Directo = 0, RenglonID = @RenglonID 
     WHERE ID = @ID 

    DELETE ListaIDRenglon WHERE Estacion = @Estacion
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spProdProgramaRutaHoras ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdProgramaRutaHoras') and type = 'P') drop procedure dbo.spProdProgramaRutaHoras
GO
CREATE PROCEDURE spProdProgramaRutaHoras
			@Ruta		char(20),
			@Orden		int,
			@Centro		char(10),
			@Operacion	varchar(100),
			@Cantidad	float,
			@TCola		float	OUTPUT,
    			@TFijo	   	float	OUTPUT,
    			@TVariable	float	OUTPUT,
			@TEspera	float	OUTPUT,
			@TMovimiento	float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @OrdenDestino  int,
    @CentroDestino char(10)

  SELECT @TCola = NULL, @TEspera = NULL, @TMovimiento = NULL

  SELECT @TCola = TiempoCola, @TEspera = TiempoEspera
    FROM Centro
   WHERE Centro = @Centro

  IF @Orden IS NULL
    SELECT @Orden = Orden
      FROM ProdRutaD
     WHERE Ruta = @Ruta AND Centro = @Centro AND NULLIF(RTRIM(Operacion), '') = NULLIF(RTRIM(@Operacion), '')

  SELECT @TFijo = TiempoFijo, @TVariable = TiempoVariable
    FROM ProdRutaD
   WHERE Ruta = @Ruta AND Orden = @Orden AND Centro = @Centro AND NULLIF(RTRIM(Operacion), '') = NULLIF(RTRIM(@Operacion), '')

  SELECT @OrdenDestino = MIN(Orden)
    FROM ProdRutaD
   WHERE Ruta = @Ruta AND Orden > @Orden

  SELECT @CentroDestino = Centro
    FROM ProdRutaD
   WHERE Ruta = @Ruta AND Orden = @OrdenDestino

  SELECT @TMovimiento = Tiempo
    FROM CentroMovimiento
   WHERE Centro = @Centro AND CentroDestino = @CentroDestino

  SELECT @TVariable = @TVariable * @Cantidad

  RETURN    
END
GO

/**************** spProdProgramaRutaCalcDiasCarga ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdProgramaRutaCalcDiasCarga') and type = 'P') drop procedure dbo.spProdProgramaRutaCalcDiasCarga
GO
CREATE PROCEDURE spProdProgramaRutaCalcDiasCarga
				@Estacion	char(10),	
				@HorasCarga	float,
				@DiasCarga	float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CapacidadSemana	float
  SELECT @CapacidadSemana = Capacidad FROM PlanEstacionCapacidadCalc WHERE Estacion = @Estacion
  SELECT @DiasCarga = @HorasCarga / (@CapacidadSemana / 7)
  RETURN
END
GO

/**************** spProdProgramaRutaCalcFechas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdProgramaRutaCalcFechas') and type = 'P') drop procedure dbo.spProdProgramaRutaCalcFechas
GO
CREATE PROCEDURE spProdProgramaRutaCalcFechas
                        @ID		int,
			@FechaInicio	datetime = NULL,
			@FechaEntrega	datetime = NULL,
			@Calcular	char(20) = 'FECHA INICIO',  -- FECHA INICIO o FECHA ENTREGA
			@VerResultado	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Lote		varchar(50),
    @Producto		char(20),
    @SubProducto	varchar(50),
    @Ruta        	char(20),
    @Centro	 	char(10),
    @UltCentro		char(10),
    @Operacion	 	varchar(100),
    @UltOperacion	varchar(100),
    @Orden		int,
    @Cantidad	 	float,
    @Estacion		char(10),
    @TCola		float,
    @TFijo		float,
    @TVariable		float,
    @TEspera		float,
    @TMovimiento	float,
    @HorasCarga	 	float,
    @DiasCarga	 	float,
    @DiasEntrega	float

  SELECT @Calcular = UPPER(@Calcular)
  IF @Calcular = 'FECHA INICIO'
  BEGIN
    IF @FechaEntrega IS NULL SELECT @FechaEntrega = FechaEntrega FROM Prod WHERE ID = @ID
  END ELSE
  BEGIN
    IF @FechaInicio  IS NULL SELECT @FechaInicio  = FechaInicio  FROM Prod WHERE ID = @ID
  END

  -- Dias y Horas de Carga
  SELECT @UltCentro = NULL, @UltOperacion = NULL
  DECLARE crProgramaRuta CURSOR SCROLL FOR 
   SELECT Ruta, Orden, Centro, Operacion, Cantidad, Estacion
     FROM ProdProgramaRuta
    WHERE ID = @ID
    ORDER BY Lote, Producto, SubProducto, Ruta, Orden, Centro, Operacion
  OPEN crProgramaRuta
  FETCH NEXT FROM crProgramaRuta INTO @Ruta, @Orden, @Centro, @Operacion, @Cantidad, @Estacion
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spProdProgramaRutaHoras @Ruta, @Orden, @Centro, @Operacion, @Cantidad, @TCola OUTPUT, @TFijo OUTPUT, @TVariable OUTPUT, @TEspera OUTPUT, @TMovimiento OUTPUT
      SELECT @HorasCarga = ISNULL(@TFijo, 0) + ISNULL(@TVariable, 0) 
      IF @Centro = @UltCentro AND @Operacion <> @UltOperacion SELECT @TCola = NULL
      SELECT @UltCentro = @Centro, @UltOperacion = @Operacion
    END
    FETCH NEXT FROM crProgramaRuta INTO @Ruta, @Orden, @Centro, @Operacion, @Cantidad, @Estacion
    IF @Centro = @UltCentro SELECT @TEspera = NULL

    FETCH PRIOR FROM crProgramaRuta INTO @Ruta, @Orden, @Centro, @Operacion, @Cantidad, @Estacion
    EXEC spProdProgramaRutaCalcDiasCarga @Estacion, @HorasCarga, @DiasCarga OUTPUT

    SELECT @DiasEntrega = @DiasCarga + ((ISNULL(@TCola, 0) + ISNULL(@TEspera, 0) + ISNULL(@TMovimiento,0)) / 24)

    UPDATE ProdProgramaRuta 
       SET TiempoCola = @TCola, 
           TiempoFijo = @TFijo, 
           TiempoVariable = @TVariable, 
           TiempoEspera = @TEspera, 
           TiempoMovimiento = @TMovimiento, 
           DiasCarga = @DiasCarga,
           DiasEntrega = @DiasEntrega
     WHERE CURRENT OF crProgramaRuta
    FETCH NEXT FROM crProgramaRuta INTO @Ruta, @Orden, @Centro, @Operacion, @Cantidad, @Estacion
  END
  CLOSE crProgramaRuta
  DEALLOCATE crProgramaRuta

  IF @Calcular = 'FECHA INICIO'
  BEGIN
    SELECT @FechaInicio = @FechaEntrega
    DECLARE crProgramaFechas CURSOR FOR 
     SELECT Lote, Producto, SubProducto, Ruta, Orden, Centro, Operacion, "DiasEntrega" = FLOOR(MAX(DiasEntrega))
       FROM ProdProgramaRuta
      WHERE ID = @ID
     GROUP BY Lote, Producto, SubProducto, Ruta, Orden, Centro, Operacion
     ORDER BY Lote, Producto, SubProducto, Ruta, Orden DESC, Centro, Operacion
  END ELSE
  BEGIN
    SELECT @FechaEntrega = @FechaInicio 
    DECLARE crProgramaFechas CURSOR FOR 
     SELECT Lote, Producto, SubProducto, Ruta, Orden, Centro, Operacion, "DiasEntrega" = FLOOR(MAX(DiasEntrega))
       FROM ProdProgramaRuta
      WHERE ID = @ID
     GROUP BY Lote, Producto, SubProducto, Ruta, Orden, Centro, Operacion
     ORDER BY Lote, Producto, SubProducto, Ruta, Orden, Centro, Operacion
  END

  OPEN crProgramaFechas
  FETCH NEXT FROM crProgramaFechas INTO @Lote, @Producto, @SubProducto, @Ruta, @Orden, @Centro, @Operacion, @DiasEntrega
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN   
      IF @Calcular = 'FECHA INICIO'
      BEGIN
        UPDATE ProdProgramaRuta 
           SET FechaProcesoInicio = DATEADD(day, -FLOOR(DiasEntrega), @FechaInicio),
               FechaProcesoTermino = @FechaInicio
         WHERE ID = @ID AND Lote = @Lote AND Producto = @Producto AND SubProducto = @SubProducto AND Ruta = @Ruta AND Orden = @Orden AND Centro = @Centro AND Operacion = @Operacion
        SELECT @FechaInicio = DATEADD(day, -@DiasEntrega, @FechaInicio)
      END ELSE
      BEGIN
        UPDATE ProdProgramaRuta 
           SET FechaProcesoTermino = DATEADD(day, FLOOR(DiasEntrega), @FechaEntrega),
               FechaProcesoInicio = @FechaEntrega
         WHERE ID = @ID AND Lote = @Lote AND Producto = @Producto AND SubProducto = @SubProducto AND Ruta = @Ruta AND Orden = @Orden AND Centro = @Centro AND Operacion = @Operacion
        SELECT @FechaEntrega = DATEADD(day, @DiasEntrega, @FechaEntrega)
      END
    END
    FETCH NEXT FROM crProgramaFechas INTO @Lote, @Producto, @SubProducto, @Ruta, @Orden, @Centro, @Operacion, @DiasEntrega
  END
  CLOSE crProgramaFechas
  DEALLOCATE crProgramaFechas

  UPDATE Prod 
     SET FechaInicio = ISNULL(@FechaInicio, FechaInicio), FechaEntrega = ISNULL(FechaEntrega, @FechaEntrega)
   WHERE ID = @ID

  IF @VerResultado = 1
    SELECT "FechaInicio" = @FechaInicio, "FechaEntrega" = @FechaEntrega
  RETURN
END
GO


/**************** spProdProgramaRutaQuitar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdProgramaRutaQuitar') and type = 'P') drop procedure dbo.spProdProgramaRutaQuitar
GO
CREATE PROCEDURE spProdProgramaRutaQuitar
			@ID		int,
			@Renglon	float,
			@OrdenID	int
--//WITH ENCRYPTION
AS BEGIN 
  BEGIN TRANSACTION
    DELETE ProdProgramaRuta WHERE ID = @ID AND Renglon = @Renglon AND OrdenID = @OrdenID
    EXEC spProdProgramaRutaCalcFechas @ID
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spProdProgramaRutaDividir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdProgramaRutaDividir') and type = 'P') drop procedure dbo.spProdProgramaRutaDividir
GO
CREATE PROCEDURE spProdProgramaRutaDividir
			@ID		int,
			@Renglon	float,
			@OrdenID	int
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Max	int
  SELECT @Max = MAX(OrdenID) FROM ProdProgramaRuta WHERE ID = @ID AND Renglon = @Renglon
  BEGIN TRANSACTION
    INSERT ProdProgramaRuta (Sucursal, ID, Renglon, OrdenID, Producto, SubProducto, Lote, Cantidad, Unidad, Ruta, Centro, Estacion, Operacion, Orden)
               SELECT Sucursal, ID, Renglon, @Max+1, Producto, SubProducto, Lote, Cantidad/2, Unidad, Ruta, Centro, Estacion, Operacion, Orden
                 FROM ProdProgramaRuta
                WHERE ID = @ID AND Renglon = @Renglon AND OrdenID = @OrdenID
    UPDATE ProdProgramaRuta SET Cantidad = Cantidad/2 WHERE ID = @ID AND Renglon = @Renglon AND OrdenID = @OrdenID
    EXEC spProdProgramaRutaCalcFechas @ID
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spProdProgramaRutaUnir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdProgramaRutaUnir') and type = 'P') drop procedure dbo.spProdProgramaRutaUnir
GO
CREATE PROCEDURE spProdProgramaRutaUnir
			@ID		int,
			@Renglon	float,
			@OrdenID	int
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Sucursal		int,
    @Lote		varchar(50),
    @Producto		char(20),
    @SubProducto	varchar(50),
    @Unidad		varchar(50),
    @Ruta		char(20),
    @Centro		char(10),
    @Estacion		char(10),
    @Operacion		varchar(100),
    @Orden		int,
    @SUM_Cantidad	float

  SELECT @Sucursal = Sucursal,
         @Lote = Lote,
         @Producto = Producto,
         @SubProducto = SubProducto,
         @Unidad = Unidad, 
         @Ruta = Ruta,
         @Centro = Centro,
         @Estacion = NULLIF(RTRIM(Estacion), ''),
         @Operacion = Operacion,
         @Orden = Orden
    FROM ProdProgramaRuta 
   WHERE ID = @ID AND Renglon = @Renglon AND OrdenID = @OrdenID

   SELECT @SUM_Cantidad = SUM(Cantidad)
     FROM ProdProgramaRuta 
    WHERE ID = @ID AND Lote = @Lote AND Producto = @Producto AND SubProducto = @SubProducto AND Unidad = @Unidad AND Ruta = @Ruta AND Centro = @Centro AND NULLIF(RTRIM(Estacion), '') = @Estacion AND Operacion = @Operacion AND Orden = @Orden

  BEGIN TRANSACTION
    DELETE ProdProgramaRuta WHERE ID = @ID AND Lote = @Lote AND Producto = @Producto AND SubProducto = @SubProducto AND Unidad = @Unidad AND Ruta = @Ruta AND Centro = @Centro AND NULLIF(RTRIM(Estacion), '') = @Estacion AND Operacion = @Operacion AND Orden = @Orden
    INSERT ProdProgramaRuta (Sucursal, ID, Renglon, OrdenID, Producto, SubProducto, Lote, Cantidad, Unidad, Ruta, Centro, Estacion, Operacion, Orden)
                     VALUES (@Sucursal, @ID, @Renglon, @OrdenID, @Producto, @SubProducto, @Lote, @SUM_Cantidad, @Unidad, @Ruta, @Centro, @Estacion, @Operacion, @Orden)
    EXEC spProdProgramaRutaCalcFechas @ID
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spProdProgramaMaterialQuitar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdProgramaMaterialQuitar') and type = 'P') drop procedure dbo.spProdProgramaMaterialQuitar
GO
CREATE PROCEDURE spProdProgramaMaterialQuitar
			@ID		int,
			@Renglon	float
--//WITH ENCRYPTION
AS BEGIN 
  BEGIN TRANSACTION
    DELETE ProdProgramaMaterial WHERE ID = @ID AND Renglon = @Renglon 
  COMMIT TRANSACTION
  RETURN
END
GO


/**************** spProdProgramaMaterialDividir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdProgramaMaterialDividir') and type = 'P') drop procedure dbo.spProdProgramaMaterialDividir
GO
CREATE PROCEDURE spProdProgramaMaterialDividir
			@ID		int,
			@Renglon	float
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Max	int
  SELECT @Max = MAX(Renglon) FROM ProdProgramaMaterial WHERE ID = @ID 
  BEGIN TRANSACTION
    INSERT ProdProgramaMaterial (Sucursal, ID, Renglon, Producto, SubProducto, CantidadP, UnidadP, Lote, Articulo, SubCuenta, Cantidad, Unidad, Merma, Desperdicio, Factor, AlmacenDestino, AlmacenOrigen, FechaRequerida)
               SELECT Sucursal, ID, @Max+1, Producto, SubProducto, CantidadP, UnidadP, Lote, Articulo, SubCuenta, Cantidad/2, Unidad, Merma/2, Desperdicio/2, Factor, AlmacenDestino, AlmacenOrigen, FechaRequerida
                 FROM ProdProgramaMaterial
                WHERE ID = @ID AND Renglon = @Renglon 
    UPDATE ProdProgramaMaterial SET Cantidad = Cantidad/2, Merma = Merma/2, Desperdicio = Desperdicio/2 WHERE ID = @ID AND Renglon = @Renglon 
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spProdProgramaMaterialUnir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdProgramaMaterialUnir') and type = 'P') drop procedure dbo.spProdProgramaMaterialUnir
GO
CREATE PROCEDURE spProdProgramaMaterialUnir
			@ID		int,
			@Renglon	float
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Sucursal		int,
    @Lote		varchar(50),
    @Producto		char(20),
    @SubProducto	varchar(50),
    @CantidadP		float,
    @UnidadP		varchar(50),
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Unidad		varchar(50),
    @AlmacenDestino	char(10),
    @AlmacenOrigen	char(10),
    @FechaRequerida	datetime,
    @SUM_Cantidad	float,
    @SUM_Merma		float,
    @SUM_Desperdicio	float

  SELECT @Sucursal = Sucursal, 
         @Lote = Lote,
         @Producto = Producto,
         @SubProducto = SubProducto,
         @CantidadP = CantidadP,
         @UnidadP = UnidadP,
         @Articulo = Articulo,
         @SubCuenta = SubCuenta,
         @Unidad = Unidad,
	 @AlmacenOrigen = AlmacenOrigen,
	 @AlmacenDestino = AlmacenDestino,
         @FechaRequerida = FechaRequerida
    FROM ProdProgramaMaterial 
   WHERE ID = @ID AND Renglon = @Renglon 

   SELECT @SUM_Cantidad = SUM(Cantidad)
     FROM ProdProgramaMaterial 
    WHERE ID = @ID AND Lote = @Lote AND Producto = @Producto AND SubProducto = @SubProducto AND UnidadP = @UnidadP AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Unidad = @Unidad AND AlmacenOrigen = @AlmacenOrigen AND AlmacenDestino = @AlmacenDestino AND FechaRequerida = @FechaRequerida

  BEGIN TRANSACTION
    DELETE ProdProgramaMaterial WHERE ID = @ID AND Lote = @Lote AND Producto = @Producto AND SubProducto = @SubProducto AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Unidad = @Unidad AND AlmacenOrigen = @AlmacenOrigen AND AlmacenDestino = @AlmacenDestino AND FechaRequerida = @FechaRequerida
    INSERT ProdProgramaMaterial (Sucursal, ID, Renglon, Producto, SubProducto, CantidadP, UnidadP, Lote, Articulo, SubCuenta, Cantidad, Unidad, AlmacenOrigen, AlmacenDestino, FechaRequerida)
                         VALUES (@Sucursal, @ID, @Renglon, @Producto, @SubProducto, @CantidadP, @UnidadP, @Lote, @Articulo, @SubCuenta, @SUM_Cantidad, @Unidad, @AlmacenOrigen, @AlmacenDestino, @FechaRequerida)
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spProdProgramaEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProdProgramaEliminar') and type = 'P') drop procedure dbo.spProdProgramaEliminar
GO
CREATE PROCEDURE spProdProgramaEliminar
			@ID		int
--//WITH ENCRYPTION
AS BEGIN 
  BEGIN TRANSACTION
    DELETE ProdProgramaMaterial WHERE ID = @ID 
    DELETE ProdProgramaRuta WHERE ID = @ID 
    UPDATE Prod SET Estatus = 'CONFIRMAR' WHERE ID = @ID
  COMMIT TRANSACTION
  RETURN
END
GO
