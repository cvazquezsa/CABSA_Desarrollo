/* Configuracion MS SQL Server */

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/************** spArtR ***************/
if exists (select * from sysobjects where id = object_id('dbo.spArtR') and type = 'P') drop procedure dbo.spArtR
GO
CREATE PROCEDURE spArtR
	           @Empresa	 char(5),
	           @Modulo	 char(5),
	           @Articulo	 char(20),
	           @SubCuenta	 varchar(50),
	           @Almacen	 char(10),
		   @MovTipo	 char(20),
		   @Factor	 float,

		   @PendienteDif float,
		   @PendienteA	 float,
		   @PendienteN	 float,

		   @OrdenadoDif	 float,
		   @OrdenadoA	 float,
		   @OrdenadoN	 float

--//WITH ENCRYPTION
AS BEGIN
/*
  DECLARE
    @CompraPendiente	float,
    @VentaPendiente	float,
    @VentaRemisionada	float,
    @ProdPendiente	float,
    @CantidadOrdenada 	float,
    @InvPendiente	float

  SELECT @PendienteN = ISNULL(@PendienteN, 0.0), @PendienteA = ISNULL(@PendienteA, 0.0), 
         @OrdenadoN  = ISNULL(@OrdenadoN, 0.0),  @OrdenadoA  = ISNULL(@OrdenadoA, 0.0)

  SELECT @PendienteDif = @PendienteDif * @Factor, @PendienteA = @PendienteA * @Factor, @PendienteN = @PendienteN * @Factor,
	 @OrdenadoDif  = @OrdenadoDif  * @Factor, @OrdenadoA  = @OrdenadoA  * @Factor, @OrdenadoN  = @OrdenadoN  * @Factor

  SELECT @CompraPendiente = 0.0, @VentaPendiente = 0.0, @VentaRemisionada = 0.0, @CantidadOrdenada = 0.0, @InvPendiente = 0.0
  IF @PendienteDif IS NULL SELECT @PendienteDif = ISNULL(@PendienteN, 0.0) - ISNULL(@PendienteA, 0.0)
  IF @OrdenadoDif  IS NULL SELECT @OrdenadoDif  = ISNULL(@OrdenadoN, 0.0)  - ISNULL(@OrdenadoA, 0.0)

  IF @Modulo NOT IN ('VTAS', 'PROD', 'INV') SELECT @OrdenadoDif = 0.0

  -- En algunos movimientos el Pendiente no tiene importancia en ArtR
  IF @MovTipo IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.R', 'INV.SOL', 'INV.OT', 'INV.OI', 'INV.TI', 'INV.SM', 'COMS.O', 'COMS.OP', 'COMS.OG') AND NULLIF(RTRIM(@Almacen), '') IS NOT NULL AND (@PendienteDif <> 0.0 OR @OrdenadoDif <> 0.0)
  BEGIN
    SELECT @CantidadOrdenada = @OrdenadoDif
    IF @MovTipo = 'VTAS.R' SELECT @VentaRemisionada = @PendienteDif ELSE 
    IF @Modulo  = 'VTAS'   SELECT @VentaPendiente   = @PendienteDif ELSE
    IF @Modulo  = 'INV'    SELECT @InvPendiente     = @PendienteDif ELSE
    IF @Modulo  = 'PROD'   SELECT @ProdPendiente    = @PendienteDif ELSE
    IF @Modulo  = 'COMS'   SELECT @CompraPendiente  = @PendienteDif
    UPDATE ArtR
       SET VentaPendiente   = ISNULL(VentaPendiente,   0.0) + @VentaPendiente,
	   CantidadOrdenada = ISNULL(CantidadOrdenada, 0.0) + @CantidadOrdenada,
	   VentaRemisionada = ISNULL(VentaRemisionada, 0.0) + @VentaRemisionada,
	   ProdPendiente    = ISNULL(ProdPendiente,    0.0) + @ProdPendiente,
	   CompraPendiente  = ISNULL(CompraPendiente,  0.0) + @CompraPendiente,
	   InvPendiente     = ISNULL(InvPendiente,     0.0) + @InvPendiente,
	   TieneMovimientos = 1
     WHERE Empresa   = @Empresa
       AND Articulo  = @Articulo
       AND SubCuenta = ISNULL(@SubCuenta, '')
       AND Almacen   = @Almacen
    IF @@ROWCOUNT = 0
      INSERT ArtR (Empresa,  Articulo,  SubCuenta,               Almacen,  VentaPendiente,  CantidadOrdenada,  VentaRemisionada, ProdPendiente,  CompraPendiente,  InvPendiente, TieneMovimientos) 
           VALUES (@Empresa, @Articulo, ISNULL(@SubCuenta, ''), @Almacen, @VentaPendiente, @CantidadOrdenada, @VentaRemisionada, @ProdPendiente, @CompraPendiente, @InvPendiente, 1)
  END*/
  RETURN 
END
GO

/**************** spInvCantidadReservarJuego ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvCantidadReservarJuego') and type = 'P') drop procedure dbo.spInvCantidadReservarJuego
GO             
CREATE PROCEDURE spInvCantidadReservarJuego
			@Empresa		char(5),
			@Modulo			char(5),
			@ID			int, 
			@Estatus		char(15),
			@Almacen		char(10),
		   	@AlmacenTipo		char(20),
		   	@AfectarConsignacion	bit,
			@RenglonID		int, 
			@CantidadJuego		float   OUTPUT,
			@CantidadMinimaJuego 	int	OUTPUT,			
			@Ok			int     OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @ArtTipo		char(20),
    @Cantidad		float,
    @Factor		float,
    @CantidadPendiente	float,
    @Disponible		float,
    @Necesita		float,
    @Obtenido		float,
    @ObtenidoMinimo	int,
    @Minimo		int,
    @FactorJuego	float

  SELECT @CantidadMinimaJuego = 0, @Minimo = NULL, @CantidadJuego = NULL
  IF @Modulo = 'VTAS' SELECT @CantidadJuego = NULLIF(Cantidad, 0.0) FROM VentaD WHERE ID = @ID AND RenglonID = @RenglonID AND RenglonTipo = 'J' ELSE
  IF @Modulo = 'INV'  SELECT @CantidadJuego = NULLIF(Cantidad, 0.0) FROM InvD   WHERE ID = @ID AND RenglonID = @RenglonID AND RenglonTipo = 'J' ELSE
  IF @Modulo = 'PROD' SELECT @CantidadJuego = NULLIF(Cantidad, 0.0) FROM ProdD  WHERE ID = @ID AND RenglonID = @RenglonID AND RenglonTipo = 'J'

  IF @Modulo = 'VTAS' DECLARE crComponentes CURSOR FOR SELECT d.Articulo, d.SubCuenta, d.Cantidad, d.CantidadPendiente, d.Factor, a.Tipo FROM VentaD d, Art a WHERE d.Articulo = a.Articulo AND ID = @ID AND RenglonID = @RenglonID AND RenglonTipo IN ('C', 'E') ELSE
  IF @Modulo = 'INV'  DECLARE crComponentes CURSOR FOR SELECT d.Articulo, d.SubCuenta, d.Cantidad, d.CantidadPendiente, d.Factor, a.Tipo FROM InvD d,   Art a WHERE d.Articulo = a.Articulo AND ID = @ID AND RenglonID = @RenglonID AND RenglonTipo IN ('C', 'E') ELSE
  IF @Modulo = 'PROD' DECLARE crComponentes CURSOR FOR SELECT d.Articulo, d.SubCuenta, d.Cantidad, d.CantidadPendiente, d.Factor, a.Tipo FROM ProdD d,  Art a WHERE d.Articulo = a.Articulo AND ID = @ID AND RenglonID = @RenglonID AND RenglonTipo IN ('C', 'E')
  OPEN crComponentes
  FETCH NEXT FROM crComponentes INTO @Articulo, @SubCuenta, @Cantidad, @CantidadPendiente, @Factor, @ArtTipo
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @FactorJuego = @CantidadJuego / @Cantidad
      IF @Estatus = 'PENDIENTE' SELECT @Necesita = @CantidadPendiente ELSE SELECT @Necesita = @Cantidad
      EXEC spArtSubDisponible @Empresa, @Almacen, @Articulo, @ArtTipo, @SubCuenta, @AfectarConsignacion, @AlmacenTipo, @Factor, @Disponible OUTPUT, @Ok OUTPUT
      IF @Necesita > @Disponible SELECT @Obtenido = @Disponible ELSE SELECT @Obtenido = @Necesita
      SELECT @ObtenidoMinimo = FLOOR(@Obtenido*@FactorJuego)
      IF @Minimo IS NULL SELECT @Minimo = @ObtenidoMinimo ELSE IF @ObtenidoMinimo < @Minimo SELECT @Minimo = @ObtenidoMinimo
    END
    FETCH NEXT FROM crComponentes INTO @Articulo, @SubCuenta, @Cantidad, @CantidadPendiente, @Factor, @ArtTipo
  END
  CLOSE crComponentes
  DEALLOCATE crComponentes
  SELECT @CantidadMinimaJuego = ISNULL(@Minimo, 0)
END
GO

/**************** spInvQuitarBasura ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvQuitarBasura') and type = 'P') drop procedure dbo.spInvQuitarBasura
GO
CREATE PROCEDURE spInvQuitarBasura
    		   @Empresa      		char(5),
    		   @Modulo	      		char(5),
                   @ID                  	int,
                   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Borrar	bit,
    @RenglonID	int,
    @Articulo	char(20)

  IF @Conexion = 0 
    BEGIN TRANSACTION
  DECLARE crSerieLoteMov CURSOR FOR
   SELECT DISTINCT RenglonID, Articulo FROM SerieLoteMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID
  OPEN crSerieLoteMov
  FETCH NEXT FROM crSerieLoteMov INTO @RenglonID, @Articulo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Borrar = 0
      IF @Modulo = 'VTAS' IF NOT EXISTS(SELECT * FROM VentaD  WHERE ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo) SELECT @Borrar = 1
      IF @Modulo = 'COMS' IF NOT EXISTS(SELECT * FROM CompraD WHERE ID = @ID AND RenglonID = @RenglonID AND (Articulo = @Articulo OR ArticuloMaquila = @Articulo)) SELECT @Borrar = 1
      IF @Modulo = 'INV'  IF NOT EXISTS(SELECT * FROM InvD    WHERE ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo) SELECT @Borrar = 1
      IF @Modulo = 'PROD' IF NOT EXISTS(SELECT * FROM ProdD   WHERE ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo) SELECT @Borrar = 1
      IF @Borrar = 1
        DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo
    END
    FETCH NEXT FROM crSerieLoteMov INTO @RenglonID, @Articulo
  END
  CLOSE crSerieLoteMov 
  DEALLOCATE crSerieLoteMov 
  IF @Conexion = 0 
    COMMIT TRANSACTION
END
GO

/**************** spWMSInvInventarioFisicoSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSInvInventarioFisicoSerieLote') and type = 'P') drop procedure dbo.spWMSInvInventarioFisicoSerieLote
GO             
CREATE PROCEDURE spWMSInvInventarioFisicoSerieLote
      	   @ID				int, 
      	   @Base			char(20),
      	   @Modulo			char(5),
		   @Almacen			char(10),
		   @IDGenerar		int,
		   @Ok				int OUTPUT,
		   @OkRef			varchar(255) OUTPUT 
		   		   		   
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @WMS			bit,
    @Articulo		varchar(20),
    @Tarima			varchar(20),
    @Unidad			varchar(50),
    @Empresa		char(5),
    @Sucursal		int,
    @TipoCosto		varchar(20),
    @Moneda			varchar(10),
    @TipoCambio		float,
    @FormaCosteo	varchar(20),
    @Costo			float,
    @Renglon		int,
    @RenglonID		int

  DECLARE @Posiciones TABLE
		(
		 Posicion		varchar(50)
		 )

  DECLARE @Tarimas TABLE
		(
		 Tarima			varchar(20)
		 )
    
  SELECT @WMS = ISNULL(WMS,0) FROM Alm WHERE Almacen = @Almacen
  
  IF @WMS = 1
  BEGIN
  
    SELECT @Empresa = Empresa,
           @Sucursal = Sucursal,
           @Moneda = Moneda,
           @TipoCambio = TipoCambio
      FROM Inv
     WHERE ID = @ID

    SELECT @FormaCosteo = FormaCosteo
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

    IF @FormaCosteo <> 'Articulo'
      SET @TipoCosto = (SELECT TipoCosteo FROM EmpresaCfg WHERE Empresa = @Empresa)
        
    INSERT @Posiciones
    SELECT DISTINCT l.Posicion
      FROM InvD i
      JOIN Art a
        ON i.Articulo = a.Articulo
       AND a.Tipo IN ('SERIE', 'LOTE')
      JOIN Tarima t
        ON t.Tarima = i.Tarima
      JOIN AlmPos l
        ON l.Posicion = t.Posicion
     WHERE ID = @ID

    INSERT @Tarimas
    SELECT DISTINCT i.Tarima
      FROM InvD i
      JOIN Art a
        ON i.Articulo = a.Articulo
       AND a.Tipo IN ('SERIE', 'LOTE')
      JOIN Tarima t
        ON t.Tarima = i.Tarima
      JOIN AlmPos l
        ON l.Posicion = t.Posicion
     WHERE ID = @ID

    IF EXISTS(
      SELECT d.Tarima
        FROM ArtDisponibleTarima d
        JOIN Tarima t ON d.Tarima = t.Tarima
        JOIN Art a ON a.Articulo = d.Articulo
        JOIN TMAD wd ON d.Tarima = wd.Tarima
        JOIN TMA w ON wd.ID = w.ID AND w.Estatus = 'PROCESAR'
       WHERE d.Disponible > 0
         AND t.Posicion IN (SELECT * FROM @Posiciones)
         AND t.Tarima NOT IN (SELECT * FROM @Tarimas)
         AND d.Almacen = @Almacen
         AND a.Tipo IN ('SERIE', 'LOTE'))
       SELECT @Ok = 20923

    DECLARE crInventarioFisico CURSOR FOR  
    SELECT d.Articulo, d.Tarima
      FROM ArtDisponibleTarima d
      JOIN Tarima t
        ON d.Tarima = t.Tarima
      JOIN Art a
        ON a.Articulo = d.Articulo
     WHERE d.Disponible > 0
       AND t.Posicion IN (SELECT * FROM @Posiciones)
       AND t.Tarima NOT IN (SELECT * FROM @Tarimas)
       AND d.Almacen = @Almacen
       AND a.Tipo IN ('SERIE', 'LOTE')
  
    OPEN crInventarioFisico  
    FETCH NEXT FROM crInventarioFisico INTO @Articulo, @Tarima
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN  
      IF @@FETCH_STATUS <> -2   
      BEGIN
      
        SELECT @Renglon = MAX(Renglon) + 2048,
               @RenglonID = MAX(RenglonID) + 1
          FROM InvD
         WHERE ID = @ID

        SELECT @Unidad = Unidad FROM Art WHERE Articulo = @Articulo
        EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, NULL, @Unidad, @TipoCosto, @Moneda, @TipoCambio, @Costo OUTPUT, NULL, 0
        
        INSERT InvD( ID, Renglon,  RenglonID,  Cantidad, Almacen,  Articulo,  Costo,  FechaRequerida,                Unidad,  CantidadInventario, Tarima)
        SELECT      @ID, @Renglon, @RenglonID, 0,        @Almacen, @Articulo, @Costo, dbo.fnFechaSinHora(GETDATE()), @Unidad, 0,                  @Tarima
        
      END  
      FETCH NEXT FROM crInventarioFisico INTO @Articulo, @Tarima
    END -- While  
    CLOSE crInventarioFisico  
    DEALLOCATE crInventarioFisico  
  
  END  
  RETURN
END
GO

/**************** spWMSInvInventarioFisico ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSInvInventarioFisico') and type = 'P') drop procedure dbo.spWMSInvInventarioFisico
GO             
CREATE PROCEDURE spWMSInvInventarioFisico
      	   @ID				int, 
      	   @Base			char(20),
      	   @Modulo			char(5),
		   @Almacen			char(10),
		   @IDGenerar		int
		   	   		   
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @WMS			bit
     
  SELECT @WMS = ISNULL(WMS,0) FROM Alm WHERE Almacen = @Almacen

  IF @Modulo = 'INV' AND @WMS = 1
  BEGIN

    CREATE TABLE #ExistenciaFisicaWMS (Articulo varchar(20) COLLATE Database_Default NOT NULL,  SubCuenta varchar(50) COLLATE Database_Default NULL,  Cantidad float NULL, Tarima varchar(20)  COLLATE Database_Default NULL, PosicionActual varchar(10)  COLLATE Database_Default NULL, PosicionReal varchar(10)  COLLATE Database_Default NULL)

    INSERT #ExistenciaFisicaWMS 
           (Articulo, SubCuenta, Cantidad, Tarima)
    SELECT Articulo, SubCuenta, Cantidad, Tarima
      FROM #ExistenciaFisica
   
    DELETE #ExistenciaFisica    
    INSERT #ExistenciaFisica 
           (Articulo,  SubCuenta,   Cantidad,                            CantidadA,                           Costo, ArtTipo,  Almacen,  Tarima, PosicionActual, PosicionReal)
    SELECT d.Articulo, d.SubCuenta, -t.Disponible * 1, -t.Disponible * 1, NULL,  a.Tipo,   @Almacen, d.Tarima, d.PosicionActual, d.PosicionReal
      FROM InvD d
      JOIN Art a 
        ON d.Articulo = a.Articulo
      --JOIN ArtDisponibleTarima t
	  JOIN ArtSubDisponibleTarima t --TASK3791
        ON d.Tarima = t.Tarima
       AND d.Articulo = t.Articulo
      LEFT OUTER JOIN ArtUnidad u
        ON d.Articulo = u.Articulo
       AND d.Unidad = u.Unidad       
     WHERE d.ID = @ID AND d.Articulo = a.Articulo
	   AND ISNULL(t.SubCuenta, '')=ISNULL(d.SubCuenta,'') --TASK3791

    INSERT #ExistenciaFisica 
            (Articulo,  SubCuenta,   Cantidad,                         CantidadA,                        Costo, ArtTipo,  Almacen,  Tarima, PosicionActual, PosicionReal)
    --SELECT  d.Articulo, d.SubCuenta, d.Cantidad * ISNULL(u.Factor, 1), d.Cantidad * ISNULL(u.Factor, 1), NULL,  a.Tipo,   @Almacen, d.Tarima, d.PosicionActual, d.PosicionReal
	SELECT  d.Articulo, d.SubCuenta, d.CantidadA * ISNULL(u.Factor, 1), d.CantidadA * ISNULL(u.Factor, 1), NULL,  a.Tipo,   @Almacen, d.Tarima, d.PosicionActual, d.PosicionReal --TASK3791
      FROM InvD d
      JOIN Art a 
        ON d.Articulo = a.Articulo
      --JOIN ArtDisponibleTarima t 
	  JOIN ArtSubDisponibleTarima t --TASK3791
        ON d.Tarima = t.Tarima
       AND d.Articulo = t.Articulo
      LEFT OUTER JOIN ArtUnidad u
        ON d.Articulo = u.Articulo
       AND d.Unidad = u.Unidad
     WHERE d.ID = @ID AND d.Articulo = a.Articulo
	   AND ISNULL(t.SubCuenta, '')=ISNULL(d.SubCuenta,'') --TASK3791
  END
  RETURN
END
GO
--TASK25114
--BUG24540
/**************** spWMSInventarioFisicoCambioArticulo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWMSInventarioFisicoCambioArticulo') and type = 'P') drop procedure dbo.spWMSInventarioFisicoCambioArticulo
GO
CREATE PROC spWMSInventarioFisicoCambioArticulo
			@Sucursal				int,    
			@ID						int,     
			@Empresa				char(5),     
			@Almacen				char(10),    
			@IDGenerar				int,     
			@Base					char(20),    
			@CfgSeriesLotesMayoreo	bit,    
			@Estatus				char(15), 

			@Ok						int				OUTPUT,     
			@OkRef					varchar(255)	OUTPUT    
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Renglon			float,
		  @RenglonAnt		float,
		  @Tarima			varchar(20),
		  @Articulo			varchar(20),
		  @RenglonSub		int,
		  @RenglonSubAnt	int,
		  @RenglonAux		int,
		  @RenglonSubAux	int,		  
		  @RenglonSubNuevo	int,
		  @Cantidad			float

  SELECT @RenglonAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @Renglon = MIN(Renglon)
      FROM InvD
     WHERE ID = @IDGenerar
       AND Renglon > @RenglonAnt

    IF @Renglon IS NULL BREAK
    
    SELECT @RenglonAnt = @Renglon

    SELECT @RenglonSubAnt = -1
    WHILE(1=1)
    BEGIN
      SELECT @RenglonSub = MIN(RenglonSub)
        FROM InvD
       WHERE ID = @IDGenerar
         AND Renglon = @Renglon
         AND RenglonSub > @RenglonSubAnt

      IF @RenglonSub IS NULL BREAK
    
      SELECT @RenglonSubAnt = @RenglonSub
      
      SELECT @Articulo = NULL, @Tarima = NULL, @Cantidad = NULL, @RenglonAux = NULL, @RenglonSubNuevo = NULL, @RenglonSubAux = NULL
      
      SELECT @Articulo = Articulo, @Tarima = Tarima, @Cantidad = Cantidad FROM InvD WHERE ID = @IDGenerar AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      
      IF @Cantidad > 0
      BEGIN
        SELECT @RenglonAux = Renglon, @RenglonSubAux = RenglonSub FROM InvD WHERE ID = @IDGenerar AND Renglon > @Renglon AND Articulo <> @Articulo AND Tarima = @Tarima
        
        IF @RenglonAux IS NOT NULL
        BEGIN
          SELECT @RenglonSubNuevo = MAX(RenglonSub) + 1 FROM InvD WHERE ID = @IDGenerar AND Renglon = @Renglon
          
          UPDATE InvD SET RenglonSub = @RenglonSubNuevo WHERE ID = @IDGenerar AND Renglon = @Renglon AND RenglonSub = @RenglonSub
          
          UPDATE InvD SET Renglon = @Renglon, RenglonSub = @RenglonSub WHERE ID = @IDGenerar AND Renglon = @RenglonAux AND RenglonSub = @RenglonSubAux
        END
      END
      
      --SELECT @RenglonAux = Renglon FROM InvD WHERE ID = @IDGenerar AND Articulo <> @Articulo AND Tarima = @Tarima
      
    END    
  END
  
  RETURN
END
GO
--REQ12615 WMS
/**************** spInvInventarioFisico ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvInventarioFisico') and type = 'P') drop procedure dbo.spInvInventarioFisico
GO             
CREATE PROCEDURE spInvInventarioFisico
		   @Sucursal			int,
      		   @ID				int, 
		   @Empresa			char(5), 
		   @Almacen			char(10),
		   @IDGenerar			int, 
		   @Base			char(20),
		   @CfgSeriesLotesMayoreo	bit,
		   @Estatus			char(15),

		   @Ok 				int 		OUTPUT, 
		   @OkRef 			varchar(255)	OUTPUT,
		   @Modulo			varchar(5) = 'INV',
		   @Proveedor			varchar(10) = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ZonaImpuesto		varchar(30),
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			money,
    @SucursalAlmacen		int,
    @RegistrarPrecios		bit,
    @MovAlmacen			char(10),
    @Tarima			varchar(20),
    @Moneda			char(10),
    @TipoCambio			float,
    @Articulo 			char(20),
    @ArtTipo			char(20),
    @Renglon			float,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @SubCuenta			varchar(50),
    @Unidad			varchar(50),
    @Cantidad			float,
    @CantidadABS		float,
    @CantidadA			float,
    @Existencia			float,
    @Factor			float,
    @FormaCosteo		varchar(20),
    @TipoCosteo			varchar(20),
    @Costo			float,
    @Precio			float,
    @Decimales			int,
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @SeriesLotesAutoOrden	varchar(20),
    @LotesFijos			bit,
    @Lote				varchar(50),
    @Contacto			varchar(10),
    @EnviarA			int,
    @FechaEmision		datetime,
    @Mov				varchar(20),
    @ContUso				varchar(20), --JGD 03Marzo2011 Ticket 3931
    @WMSSugerirEntarimado	bit, --JGD 03Marzo2011 Ticket 3623
    @PosicionActual varchar(10),
    @PosicionReal   varchar(10),
	
	--TASK25114
	--BUG24540 
    @WMS                   BIT, 
    @Departamento          VARCHAR(50), 
    @Familia               VARCHAR(50), 
    @SubFamilia            VARCHAR(50), 
    @UEN                   INT, 
    @UENTipo               VARCHAR(50), 
    @InvFisico             INT, 
    @ArticuloBlanco        VARCHAR(20), 
    @TarimaBlanco          VARCHAR(20), 
    @MonedaBlanco          VARCHAR(10),
	@Movx                  varchar(20)


  --TASK25114
  --TASK25114
  SELECT @ArticuloBlanco = Articulo, @TarimaBlanco = Tarima FROM WMSInventarioFisicoArtBlanco  
  SELECT @MonedaBlanco = MonedaCosto FROM Art WHERE Articulo = @ArticuloBlanco    
  --BUG24540
  SELECT @WMS = ISNULL(WMS, 0) FROM Alm WHERE Almacen = @Almacen

  -- Inicializar Variables
  SELECT @Renglon = 0, @RenglonID = 0, @Precio = NULL, @Contacto = NULL, @EnviarA = NULL, @FechaEmision = NULL

  SELECT @SeriesLotesAutoOrden    = UPPER(SeriesLotesAutoOrden),
         @FormaCosteo		  = UPPER(FormaCosteo),
         @TipoCosteo		  = ISNULL(NULLIF(RTRIM(UPPER(TipoCosteo)), ''), 'PROMEDIO'),
         @WMSSugerirEntarimado = WMSSugerirEntarimado
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @CfgMultiUnidades = MultiUnidades, 
         @CfgMultiUnidadesNivel = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'),
         @RegistrarPrecios = InvRegistrarPrecios 
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa
  SELECT @Moneda = Moneda, @TipoCambio = TipoCambio FROM Inv WHERE ID = @IDGenerar
  SELECT @SucursalAlmacen = Sucursal FROM Alm WHERE Almacen = @Almacen

    --BUG24540
  IF @WMS = 1 AND ISNULL(@ArticuloBlanco,'')<>'' --TASK2429PGC 05082015
  BEGIN
    SELECT @Base = 'TODO'	
    
    --TASK3750	
    --IF NOT EXISTS(SELECT * FROM SaldoU WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = 'INV' AND Grupo = @Almacen AND Cuenta = @ArticuloBlanco AND SubCuenta = '' AND SubGrupo = @TarimaBlanco)
	IF NOT EXISTS(SELECT * FROM SaldoUWMS WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = 'INV' AND Grupo = @Almacen AND Cuenta = @ArticuloBlanco AND SubCuenta = '' AND SubGrupo = @TarimaBlanco)
      --INSERT INTO SaldoU(      
	   INSERT INTO SaldoUWMS(     
				Sucursal,  Empresa, Rama,   Moneda,        Grupo,    SubGrupo,      Cuenta,         SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio)
	    SELECT @Sucursal, @Empresa, 'INV', @MonedaBlanco, @Almacen, @TarimaBlanco, @ArticuloBlanco, '',        0,     0,      0,            0,             GETDATE()	
  END

  --TASK25114
  --BUG24540
  IF @WMS = 1  
    EXEC spWMSInvInventarioFisicoSerieLote @ID, @Base, @Modulo, @Almacen, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
  
  IF @Ok IS NOT NULL RETURN

  IF @Modulo = 'COMS'
    SELECT @Mov = Mov, @ZonaImpuesto = ZonaImpuesto, @Contacto = Proveedor, @FechaEmision = FechaEmision
      FROM Compra
     WHERE ID = @IDGenerar
  ELSE BEGIN
    SELECT @Mov = Mov 
      FROM Inv
     WHERE ID = @IDGenerar

	CREATE TABLE #ExistenciaFisica (Articulo varchar(20) COLLATE Database_Default NOT NULL,  SubCuenta varchar(50) COLLATE Database_Default NULL,  Cantidad float NULL,  CantidadA float NULL, Costo float NULL, ArtTipo 	varchar(20)  COLLATE Database_Default NULL, Unidad varchar(50)  COLLATE Database_Default NULL, Almacen varchar(10) COLLATE Database_Default  NULL, Tarima varchar(20)  COLLATE Database_Default NULL, ContUso varchar(20) COLLATE Database_Default NULL, PosicionActual varchar(10) COLLATE Database_Default NULL,PosicionReal varchar(10) COLLATE Database_Default NULL) --TASK25114
		      
    INSERT #ExistenciaFisica (
           Articulo,   SubCuenta,   Almacen,   /*Unidad, */   Cantidad,                                           CantidadA,                                           ArtTipo,                   Costo,                         ContUso,             PosicionActual,               PosicionReal,             Tarima) --TASK25114
    SELECT d.Articulo, d.SubCuenta, d.Almacen, /*d.Unidad, */ SUM(ISNULL(d.Cantidad, 0.0)*ISNULL(d.Factor, 1.0)), SUM(ISNULL(d.CantidadA, 0.0)*ISNULL(d.Factor, 1.0)), NULLIF(RTRIM(a.Tipo), ''), ac.CostoPromedio/*, d.Factor*/,NULLIF(d.ContUso,''),ISNULL(d.PosicionActual,''), ISNULL(d.PosicionReal,''), Tarima
      FROM InvD d, Art a, ArtCostoSucursal ac
     WHERE d.ID = @ID 
       AND d.Articulo = a.Articulo
       AND UPPER(a.Tipo) NOT IN ('JUEGO', 'SERVICIO')
       AND ac.Articulo = a.Articulo AND ac.Empresa = @Empresa AND ac.Sucursal = @Sucursal
     GROUP BY d.Articulo, d.SubCuenta, a.Tipo, /*d.Unidad, */d.Almacen, ac.CostoPromedio/*, d.Factor*/,NULLIF(d.ContUso,''),ISNULL(d.PosicionActual,''), ISNULL(d.PosicionReal,''), Tarima --TASK25114
  --  HAVING Sum(d.Cantidad*ISNULL(d.Factor, 1.0)) > 0
     ORDER BY d.Articulo, d.SubCuenta, a.Tipo, /*d.Unidad, */d.Almacen, ac.CostoPromedio/*, d.Factor*/

    -- 7330
    -- Insertamos los Artículos sin existencia
    INSERT #ExistenciaFisica (
           Articulo,   SubCuenta,   Almacen,   Cantidad,                                           CantidadA,                                           ArtTipo,                   Costo,   ContUso,             PosicionActual,               PosicionReal,             Tarima) --TASK25114
    SELECT d.Articulo, d.SubCuenta, d.Almacen, SUM(ISNULL(d.Cantidad, 0.0)*ISNULL(d.Factor, 1.0)), SUM(ISNULL(d.CantidadA, 0.0)*ISNULL(d.Factor, 1.0)), NULLIF(RTRIM(a.Tipo), ''), NULL,    NULLIF(d.ContUso,''),ISNULL(d.PosicionActual,''), ISNULL(d.PosicionReal,''), Tarima
      FROM InvD d, Art a
     WHERE d.ID = @ID 
       AND d.Articulo = a.Articulo
       AND UPPER(a.Tipo) NOT IN ('JUEGO', 'SERVICIO')
       AND a.Articulo NOT IN(SELECT Articulo FROM #ExistenciaFisica)
     GROUP BY d.Articulo, d.SubCuenta, a.Tipo, d.Almacen, NULLIF(d.ContUso,''),ISNULL(d.PosicionActual,''), ISNULL(d.PosicionReal,''), Tarima --TASK25114
  --  HAVING Sum(d.Cantidad*ISNULL(d.Factor, 1.0)) > 0
     ORDER BY d.Articulo, d.SubCuenta, a.Tipo, d.Almacen
  END

   CREATE INDEX idx_ArtExistenciaFisica on #ExistenciaFisica(Articulo,Subcuenta,Almacen)  --TASK25114

  IF @Modulo = 'COMS'
    DECLARE crExistencia CURSOR FOR
     --SELECT e.Articulo, NULLIF(RTRIM(e.SubCuenta), ''), ISNULL(e.Disponible, 0.0), NULLIF(RTRIM(Art.Tipo), ''), Art.Unidad, e.Almacen, CASE WHEN @WMSSugerirEntarimado = 1 THEN e.Tarima ELSE NULLIF(RTRIM(e.Tarima), '') END, Art.ContUso
	 SELECT e.Articulo, NULLIF(RTRIM(e.SubCuenta), ''), ISNULL(e.Disponible, 0.0), NULLIF(RTRIM(Art.Tipo), ''), Art.Unidad, e.Almacen, NULLIF(RTRIM(e.Tarima), ''), Art.ContUso --TASK25114
       FROM ArtSubDisponibleTarima e
       JOIN Art ON Art.Articulo = e.Articulo
      WHERE e.Empresa  = @Empresa 
        AND e.Almacen  = ISNULL(@Almacen, e.Almacen)
        AND e.Disponible > 0
        AND Art.Proveedor = @Proveedor OR EXISTS(SELECT * FROM ArtProv ap WHERE ap.Articulo = e.Articulo AND ap.SubCuenta = ISNULL(RTRIM(e.SubCuenta), '') AND ap.Proveedor = @Proveedor)
  ELSE
  IF @Base = 'DISPONIBLE' 
    DECLARE crExistencia CURSOR FOR
     --SELECT e.Articulo, NULLIF(RTRIM(e.SubCuenta), ''), ISNULL(e.Disponible, 0.0), NULLIF(RTRIM(Art.Tipo), ''), Art.Unidad, e.Almacen, CASE WHEN @WMSSugerirEntarimado = 1 THEN e.Tarima ELSE NULLIF(RTRIM(e.Tarima), '') END, Art.ContUso
	 SELECT e.Articulo, NULLIF(RTRIM(e.SubCuenta), ''), ISNULL(e.Disponible, 0.0), NULLIF(RTRIM(Art.Tipo), ''), Art.Unidad, e.Almacen, NULLIF(RTRIM(e.Tarima), ''), Art.ContUso --TASK25114
       FROM ArtSubDisponibleTarima e, Art
      WHERE e.Articulo = Art.Articulo
        AND e.Empresa  = @Empresa 
        AND e.Almacen  = ISNULL(@Almacen, e.Almacen)
        AND e.Disponible > 0
  ELSE
  IF @Base = 'TODO' 
    DECLARE crExistencia CURSOR FOR
     --SELECT e.Articulo, NULLIF(RTRIM(e.SubCuenta), ''), ISNULL(e.Existencia, 0.0), NULLIF(RTRIM(Art.Tipo), ''), Art.Unidad, e.Almacen, CASE WHEN @WMSSugerirEntarimado = 1 THEN e.Tarima ELSE NULLIF(RTRIM(e.Tarima), '') END, Art.ContUso
	 SELECT e.Articulo, NULLIF(RTRIM(e.SubCuenta), ''), ISNULL(e.Existencia, 0.0), NULLIF(RTRIM(Art.Tipo), ''), Art.Unidad, e.Almacen, NULLIF(RTRIM(e.Tarima), ''), Art.ContUso --TASK25114
       FROM ArtSubExistenciaConsigAFTarima e, Art
      WHERE e.Articulo = Art.Articulo
        AND e.Empresa  = @Empresa 
        AND e.Almacen  = ISNULL(@Almacen, e.Almacen)
        AND e.Existencia > 0
        AND UPPER(Art.Tipo) NOT IN ('JUEGO', 'SERVICIO')
  ELSE
    DECLARE crExistencia CURSOR FOR
     --SELECT e.Articulo, NULLIF(RTRIM(e.SubCuenta), ''), ISNULL(e.Existencia, 0.0), NULLIF(RTRIM(Art.Tipo), ''), Art.Unidad, e.Almacen, CASE WHEN @WMSSugerirEntarimado = 1 THEN e.Tarima ELSE NULLIF(RTRIM(e.Tarima), '') END, Art.ContUso
	 SELECT e.Articulo, NULLIF(RTRIM(e.SubCuenta), ''), ISNULL(e.Existencia, 0.0), NULLIF(RTRIM(Art.Tipo), ''), Art.Unidad, e.Almacen, NULLIF(RTRIM(e.Tarima), ''), Art.ContUso --TASK25114
       FROM ArtSubExistenciaConsigAFTarima2 e, Art, InvD d
      WHERE e.Articulo = Art.Articulo
        AND e.Empresa  = @Empresa 
        AND e.Almacen  = ISNULL(@Almacen, e.Almacen)
        AND e.Existencia > 0
        AND d.ID = @ID AND d.Articulo = e.Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(e.SubCuenta, '')
        AND UPPER(Art.Tipo) NOT IN ('JUEGO', 'SERVICIO')
  OPEN crExistencia
  FETCH NEXT FROM crExistencia INTO @Articulo, @SubCuenta, @Existencia, @ArtTipo, @Unidad, @MovAlmacen, @Tarima, @ContUso
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN

	  --BUG24540
      SELECT @PosicionActual = NULL, @PosicionReal = NULL
      SELECT @PosicionActual = Posicion, @PosicionReal = Posicion FROM Tarima WHERE Tarima = @Tarima

      UPDATE #ExistenciaFisica 
         SET Cantidad  = Cantidad  - @Existencia,
             CantidadA = CantidadA - @Existencia
       WHERE Articulo  = @Articulo
         AND SubCuenta = @SubCuenta
         AND Almacen   = @Almacen
         AND CASE WHEN @WMSSugerirEntarimado = 1 THEN Tarima ELSE NULLIF(RTRIM(Tarima), '') END = @Tarima
         AND ContUso = @ContUso

      IF @@ROWCOUNT = 0
        INSERT #ExistenciaFisica (Articulo,  SubCuenta,  Cantidad,     CantidadA,    Costo, ArtTipo, /*Unidad, */Almacen,       Tarima,  ContUso)
                          VALUES (@Articulo, @SubCuenta, -@Existencia, -@Existencia, NULL,  @ArtTipo, /*@Unidad, */@MovAlmacen, @Tarima, @ContUso)
      IF @@ERROR <> 0 SELECT @Ok = 1
    END -- fetch_status
    FETCH NEXT FROM crExistencia INTO @Articulo, @SubCuenta, @Existencia, @ArtTipo, @Unidad, @MovAlmacen, @Tarima, @ContUso
    IF @@ERROR <> 0 SELECT @Ok = 1
  END -- While
  CLOSE crExistencia
  DEALLOCATE crExistencia

  -- Agrega los Articulos que no han tenido existencia
  IF @Base <> 'DISPONIBLE' AND @Modulo = 'INV'
    INSERT #ExistenciaFisica 
           (Articulo,  SubCuenta,   Cantidad,   CantidadA,  Costo, ArtTipo, /*Unidad, */Almacen,  Tarima,   ContUso,PosicionActual,PosicionReal)
    SELECT d.Articulo, d.SubCuenta, d.Cantidad, d.Cantidad, NULL,  a.Tipo,              @Almacen, d.Tarima, a.ContUso,d.PosicionActual,d.PosicionReal
      FROM InvD d, Art a
     WHERE d.ID = @ID AND d.Articulo = a.Articulo AND d.Articulo NOT IN (SELECT Articulo FROM #ExistenciaFisica)

  --REQ12615 WMS
  EXEC spWMSInvInventarioFisico @ID, @Base, @Modulo, @Almacen, @IDGenerar

  DELETE #ExistenciaFisica WHERE PosicionReal = NULL

  DECLARE crAjuste CURSOR FOR 
   SELECT Articulo, SubCuenta, ISNULL(Cantidad, 0.0), ISNULL(CantidadA, 0.0), ISNULL(Costo, 0.0), /*Unidad, */Almacen, Tarima, ArtTipo/*, ISNULL(Factor, 1.0)*/, ContUso, PosicionActual, PosicionReal
     FROM #ExistenciaFisica
  OPEN crAjuste
  FETCH NEXT FROM crAjuste INTO @Articulo, @SubCuenta, @Cantidad, @CantidadA, @Costo, /*@Unidad, */@MovAlmacen, @Tarima, @ArtTipo/*, @Factor*/,@ContUso, @PosicionActual, @PosicionReal
  IF @@ERROR <> 0 SELECT @Ok = 1




  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL



  BEGIN
    SELECT @Unidad = Unidad, @LotesFijos = ISNULL(LotesFijos, 0) FROM Art WHERE Articulo = @Articulo
    IF @CfgMultiUnidadesNivel = 'ARTICULO'
      EXEC xpArtUnidadFactor @Articulo, @SubCuenta, @Unidad, @Factor OUTPUT, @Decimales OUTPUT, @Ok OUTPUT
    ELSE
      EXEC xpUnidadFactor @Articulo, @SubCuenta, @Unidad, @Factor OUTPUT, @Decimales OUTPUT
    SELECT @Factor = ISNULL(NULLIF(@Factor, 0), 1)

    IF @FormaCosteo = 'ARTICULO' SELECT @TipoCosteo = TipoCosteo FROM Art WHERE Articulo = @Articulo
    EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0

    IF @Estatus = 'PENDIENTE' SELECT @Cantidad = @CantidadA 

    SELECT @CantidadABS = ISNULL(@Cantidad, 0.0)
    IF @Base = 'DISPONIBLE' SELECT @CantidadABS = -@CantidadABS

    IF @@FETCH_STATUS <> -2 AND ISNULL(@CantidadABS, 0.0) <> 0.0
    BEGIN
      SELECT @Renglon   = @Renglon + 2048,
             @RenglonID = @RenglonID + 1,
             @Lote      = NULL
      IF @CantidadABS < 0.0 SELECT @Costo = NULL
      EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
      IF @RegistrarPrecios = 1
        EXEC spPrecioEsp '(Precio Lista)', @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT

      -- Leer Inverso
      IF @LotesFijos = 1
      BEGIN
        IF @SeriesLotesAutoOrden = 'ASCENDENTE' 
          SELECT @Lote = (SELECT TOP 1 Lote FROM ArtLoteFijo WHERE Articulo = @Articulo ORDER BY Lote DESC) 
        ELSE
          SELECT @Lote = (SELECT TOP 1 Lote FROM ArtLoteFijo WHERE Articulo = @Articulo ORDER BY Lote)

        SELECT @Lote = NULLIF(RTRIM(@Lote), '')
        IF @Lote IS NOT NULL
          SELECT @Costo = MIN(CostoPromedio)*@Factor FROM SerieLote WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '') AND SerieLote = @Lote AND Almacen = @MovAlmacen AND Tarima = @Tarima
      END

      IF @Modulo = 'COMS'
      BEGIN
        SELECT @Impuesto1 = Impuesto1, @Impuesto2 = Impuesto2, @Impuesto3 = Impuesto3
          FROM Art
         WHERE Articulo = @Articulo

        EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
	    EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
	    EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
        EXEC spTipoImpuesto @Modulo, @IDGenerar, @Mov, @FechaEmision, @Empresa, @Sucursal, @Contacto, @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT

        INSERT INTO CompraD (Sucursal,  ID,         Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Cantidad,             CantidadInventario, Unidad,  Costo,  Almacen,     Tarima,  Impuesto1,  Impuesto2,  Impuesto3)
                     VALUES (@Sucursal, @IDGenerar, @Renglon, 0,          @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @CantidadABS/@Factor, @CantidadABS,       @Unidad, @Costo, @MovAlmacen, @Tarima, @Impuesto1, @Impuesto2, @Impuesto3)
      END ELSE
        INSERT INTO InvD (Sucursal,  ID,         Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Cantidad,             CantidadInventario, Unidad,  Costo,  Precio,  Almacen,     Tarima,  ContUso, PosicionActual, PosicionReal)
                  VALUES (@Sucursal, @IDGenerar, @Renglon, 0,          @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @CantidadABS/@Factor, @CantidadABS,       @Unidad, @Costo, @Precio, @MovAlmacen, @Tarima, @ContUso, @PosicionActual, @PosicionReal)
          --  select 'hola 54'
		


	  IF @@ERROR <> 0 SELECT @Ok = 1

      IF @LotesFijos = 1 AND @Lote IS NOT NULL AND @CantidadABS > 0
        INSERT SerieLoteMov (Empresa,  Sucursal,  Modulo,  ID,         RenglonID,  Articulo,  SubCuenta,              SerieLote, Cantidad) 
                     VALUES (@Empresa, @Sucursal, @Modulo, @IDGenerar, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), @Lote,     @CantidadABS) 
      ELSE
      --IF UPPER(@ArtTipo) IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA') AND @CfgSeriesLotesMayoreo = 1 
	  IF UPPER(@ArtTipo) IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA') AND @Cantidad < 0-- AND @CfgSeriesLotesMayoreo = 1--Cambio WMS  --TASK25114
      BEGIN
--REQ12615 WMS
/*
        IF EXISTS(SELECT * FROM SerieLoteMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '') AND RenglonID = @RenglonID)
        BEGIN
          /*IF @Cantidad > 0
            INSERT INTO SerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
              SELECT @Empresa, 'INV', @IDGenerar, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), SerieLote, Cantidad
                FROM SerieLoteMov 
               WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '') AND RenglonID = @RenglonID
                 AND SerieLote NOT IN (SELECT SerieLote FROM SerieLote WHERE Empresa = @Empresa AND Modulo = 'INV' AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '') AND Almacen = @Almacen AND (ISNULL(Existencia, 0) > 0 OR ISNULL(ExistenciaActivoFijo, 0) > 0))
          ELSE
            INSERT INTO SerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
              SELECT @Empresa, 'INV', @IDGenerar, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), SerieLote, Existencia
                FROM SerieLote
               WHERE Sucursal = @Sucursal
                 AND Empresa = @Empresa 
                 AND Articulo = @Articulo
                 AND SubCuenta = ISNULL(@SubCuenta, '')
                 AND Almacen = @Almacen
                 AND Existencia > 0 
                 AND SerieLote NOT IN (SELECT SerieLote FROM SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, ''))
*/
            INSERT INTO SerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
              SELECT @Empresa, @Modulo, @IDGenerar, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), sl.SerieLote, ABS(ISNULL(sl.Existencia, 0.0)-ISNULL(slm.Cantidad, 0.0))
                FROM SerieLote sl
                LEFT OUTER JOIN SerieLoteMov slm ON slm.Empresa = @Empresa AND slm.Modulo = @Modulo AND slm.ID = @ID AND slm.Articulo = @Articulo AND slm.SubCuenta = ISNULL(@SubCuenta, '') AND slm.SerieLote = sl.SerieLote
               WHERE sl.Sucursal = @Sucursal
                 AND sl.Empresa = @Empresa 
                 AND sl.Articulo = @Articulo
                 AND sl.SubCuenta = ISNULL(@SubCuenta, '')
                 AND sl.Almacen = @Almacen
                 AND sl.Tarima = @Tarima
                 AND ISNULL(sl.Existencia, 0.0) <> ISNULL(slm.Cantidad, 0.0)
        END
*/
        INSERT INTO SerieLoteMov (Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Tarima) --TASK25114
          SELECT @Empresa, @Modulo, @IDGenerar, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), sl.SerieLote, CASE WHEN UPPER(@ArtTipo) = 'LOTE' THEN ABS(ISNULL(sl.Existencia, 0.0)-ISNULL(slm.Cantidad, 0.0)) ELSE ISNULL(@Existencia, 0.0) END, @Tarima --TASK25114
            FROM SerieLote sl
            LEFT OUTER JOIN SerieLoteMov slm ON slm.Empresa = @Empresa AND slm.Modulo = @Modulo AND slm.ID = @ID AND slm.Articulo = @Articulo AND slm.SubCuenta = ISNULL(@SubCuenta, '') AND slm.SerieLote = sl.SerieLote
           WHERE sl.Sucursal = @Sucursal
             AND sl.Empresa = @Empresa 
             AND sl.Articulo = @Articulo
             AND sl.SubCuenta = ISNULL(@SubCuenta, '')
             AND sl.Almacen = @Almacen
             AND sl.Tarima = @Tarima
             AND ISNULL(sl.Existencia, 0.0) <> ISNULL(slm.Cantidad, 0.0)
                 
--REQ12615 WMS
      END

    END
    FETCH NEXT FROM crAjuste INTO @Articulo, @SubCuenta, @Cantidad, @CantidadA, @Costo, /*@Unidad, */@MovAlmacen, @Tarima, @ArtTipo/*, @Factor*/,@ContUso, @PosicionActual, @PosicionReal
    IF @@ERROR <> 0 SELECT @Ok = 1
  END









  CLOSE crAjuste
  DEALLOCATE crAjuste
  
  --TASK25114
  IF @WMS = 1
    EXEC spWMSInventarioFisicoCambioArticulo @Sucursal, @ID, @Empresa, @Almacen, @IDGenerar, @Base, @CfgSeriesLotesMayoreo, @Estatus, @Ok OUTPUT, @OkRef OUTPUT

  IF @Modulo = 'COMS'
  BEGIN
    UPDATE Compra SET RenglonID = @RenglonID + 1 WHERE ID = @IDGenerar
    DELETE CompraD WHERE ID = @IDGenerar AND NULLIF(ROUND(Cantidad, 10), 0) IS NULL
  END ELSE
  BEGIN
    UPDATE Inv SET RenglonID = @RenglonID + 1 WHERE ID = @IDGenerar
    DELETE InvD WHERE ID = @IDGenerar AND NULLIF(ROUND(Cantidad, 10), 0) IS NULL
  END

  IF @@ERROR <> 0 SELECT @Ok = 1
  IF NOT EXISTS(SELECT * FROM InvD WHERE ID = @IDGenerar) 
  BEGIN
    IF @Modulo = 'COMS'
      DELETE Compra WHERE ID = @IDGenerar
    ELSE
      DELETE Inv WHERE ID = @IDGenerar
    SELECT @Ok = 80070
  END
   
  EXEC xpInvInventarioFisico @Sucursal, @ID, @Empresa, @Almacen, @IDGenerar, @Base, @CfgSeriesLotesMayoreo, @Estatus, @Ok OUTPUT, @OkRef OUTPUT, @Modulo, @Proveedor
  RETURN
END
GO

/**************** spCompraProrrateoPreparar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraProrrateoPreparar') and type = 'P') drop procedure dbo.spCompraProrrateoPreparar
GO
CREATE PROCEDURE spCompraProrrateoPreparar
		 	@Empresa		char(5),
                        @ID			int,

   		   	@Ok             	int          OUTPUT,
    		   	@OkRef          	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
DECLARE
    @RenglonID		int,
    @Articulo		char(20),
    @SubCuenta		varchar(20),
    @Cantidad		float,
    @prCantidad		float	

  DECLARE crCompraOP CURSOR FOR
   SELECT RenglonID, Articulo, SubCuenta, Cantidad
     FROM CompraD
    WHERE ID = @ID
  OPEN crCompraOP
  FETCH NEXT FROM crCompraOP INTO @RenglonID, @Articulo, @SubCuenta, @Cantidad
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC spCompraProrrateoArt NULL, @Empresa,  @ID, @RenglonID, @Articulo, @SubCuenta, @Cantidad
      SELECT @prCantidad = SUM(Cantidad) FROM CompraDProrrateo  WHERE ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
      IF @Cantidad <> @prCantidad
        UPDATE CompraD 
           SET CantidadInventario = @prCantidad*CantidadInventario/NULLIF(@Cantidad, 0), 
               Cantidad = @prCantidad 
         WHERE CURRENT OF crCompraOP
    END
    FETCH NEXT FROM crCompraOP INTO @RenglonID, @Articulo, @SubCuenta, @Cantidad
  END
  CLOSE crCompraOP
  DEALLOCATE crCompraOP
END
GO


/**************** spCompraProrrateo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraProrrateo') and type = 'P') drop procedure dbo.spCompraProrrateo
GO
CREATE PROCEDURE spCompraProrrateo
			@Sucursal		int,
		 	@Empresa		char(5),
			@Usuario		char(10),
                        @Accion			char(20),
	           	@Modulo			char(5),
                        @ID			int,
			@FechaRegistro		datetime,
    			@Mov			char(20),
    			@MovID			varchar(20),
    			@FechaEmision		datetime,
			@Ejercicio		int, 
			@Periodo		int,
    			@Moneda			char(10), 
    			@TipoCambio		float, 

   		   	@Ok             	int          OUTPUT,
    		   	@OkRef          	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ultSucursal	int,
    @prSucursal		int,
    @prAlmacen		char(10), 
    @Directo		bit,
    @GenerarMov		char(20),
    @GenerarMovID	varchar(20),
    @GenerarID		int,
    @IDGenerar		int,
    @ContID		int,
    @VolverAfectar	bit,
    @Importe		money,
    @Impuestos		money

  SELECT @GenerarMov = CompraOrden FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @Directo = Directo FROM Compra WHERE ID = @ID
  SELECT @ultSucursal = NULL

  IF @Accion = 'CANCELAR'
  BEGIN
    DECLARE crOC CURSOR FOR
    SELECT DID, DMov, DMovID
      FROM MovFlujo 
     WHERE Empresa = @Empresa AND OModulo = @Modulo AND OID = @ID
    OPEN crOC
    FETCH NEXT FROM crOC INTO @GenerarID, @GenerarMov, @GenerarMovID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        EXEC spInv @GenerarID, @Modulo, @Accion, 'TODO', @FechaRegistro, @GenerarMov, @Usuario, 1, 0, NULL, 
                   @GenerarMov, @GenerarMovID, @IDGenerar, @ContID, @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @GenerarID, @GenerarMov, @GenerarMovID, @Ok OUTPUT
      END
      FETCH NEXT FROM crOC INTO @GenerarID, @GenerarMov, @GenerarMovID
    END
    CLOSE crOC
    DEALLOCATE crOC
  END ELSE
  BEGIN
    DECLARE crAlmacen CURSOR FOR
     SELECT ISNULL(a.SucursalRef, a.Sucursal), a.Almacen 
       FROM CompraD d, CompraDProrrateo p, Alm a 
      WHERE d.ID = @ID 
        AND p.ID = d.ID AND p.Articulo = d.Articulo AND ISNULL(p.SubCuenta, '') = ISNULL(d.SubCuenta, '') AND p.RenglonID = d.RenglonID AND p.Almacen = a.Almacen
      GROUP BY ISNULL(a.SucursalRef, a.Sucursal), a.Almacen
      ORDER BY ISNULL(a.SucursalRef, a.Sucursal), a.Almacen
    OPEN crAlmacen
    FETCH NEXT FROM crAlmacen INTO @prSucursal, @prAlmacen
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @prSucursal = @ultSucursal SELECT @Ok = 30610, @OkRef = @prAlmacen
        IF @Ok IS NULL
        BEGIN
          SELECT @ultSucursal = @prSucursal
          SELECT @GenerarMovID = RTRIM(@MovID)+'-'+CONVERT(varchar, @prSucursal)
          EXEC @GenerarID = spMovCopiar @Sucursal, @Modulo, @ID, @Usuario, @FechaEmision, @GenerarMov = @GenerarMov, @GenerarMovID = @GenerarMovID, @EnSilencio = 1
          --DELETE CompraDProrrateo WHERE ID = @GenerarID
          IF @GenerarID IS NOT NULL
          BEGIN
            UPDATE Compra SET Almacen = @prAlmacen WHERE ID = @GenerarID
            UPDATE CompraD 
               SET CantidadInventario = p.Cantidad*d.CantidadInventario/NULLIF(d.Cantidad, 0),
                   Cantidad = p.Cantidad,
                   Almacen = @prAlmacen
              FROM CompraD d, CompraDProrrateo p
             WHERE d.ID = @GenerarID AND p.Almacen = @prAlmacen AND p.ID = @ID AND d.RenglonID = p.RenglonID AND d.Articulo = p.Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(p.SubCuenta, '')
            DELETE CompraD WHERE ID = @GenerarID AND Almacen <> @prAlmacen
            IF NOT EXISTS(SELECT * FROM CompraD WHERE ID = @GenerarID) 
              DELETE Compra WHERE ID = @GenerarID
            ELSE 
            BEGIN
              SELECT @Importe = SUM(Importe), @Impuestos = SUM(Impuestos) FROM CompraTCalc WHERE ID = @GenerarID
              UPDATE Compra SET Importe = @Importe, Impuestos = @Impuestos WHERE ID = @GenerarID
              EXEC spInv @GenerarID, @Modulo, @Accion, 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL, 
                         @GenerarMov, @GenerarMovID, @IDGenerar, @ContID, @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar
              EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @GenerarID, @GenerarMov, @GenerarMovID, @Ok OUTPUT
            END
          END
        END
      END
      FETCH NEXT FROM crAlmacen INTO @prSucursal, @prAlmacen
    END
    CLOSE crAlmacen
    DEALLOCATE crAlmacen
  END
  RETURN
END
GO

/*
Enrique Toral 19/Nov/2008
Rutina que cancela las partidas de cotizaciones no utilizadas que provienen de las mismas Requisiciones
al afectarse la orden de compra
Flujo Requisicion --> Cotizacion --> Orden de Compra
*/

/**************** spCancelarRequisicionesPendientes ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCancelarRequisicionesPendientes') and sysstat & 0xf = 4) drop procedure dbo.spCancelarRequisicionesPendientes
GO             
CREATE PROCEDURE spCancelarRequisicionesPendientes
				@ID					int,
				@Accion				char(20),
				@Base				char(20),
				@Empresa			char(5),
				@Usuario			char(10),
				@Modulo				char(5),
				@Mov				char(20),
				@MovID				varchar(20),
				@MovTipo			char(20),
				@MovMoneda			char(10),
				@MovTipoCambio		float,
				@Estatus			char(15),
				@EstatusNuevo		char(15),
				@FechaEmision		datetime,
				@FechaRegistro		datetime,
				@FechaAfectacion	datetime,
				@Conexion			bit,
				@SincroFinal		bit,
				@Sucursal			int,
				
				@UtilizarID			int,
				@UtilizarMovTipo	char(20),

				@Ok					int		OUTPUT,
				@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @CfgCompraAutoCancelaCotizacion		bit,
--  @CfgCompraEstadoCotizacionInicial		varchar(30),
--  @CfgCompraEstadoCotizacionEnUso		varchar(30),
  @CfgCompraEstadoCotizacionCancelado	varchar(30),
  @IDC									int,
  @EmpresaRef							varchar(5),
  @Aplica								varchar(20),
  @AplicaID								varchar(20),
  @Articulo								varchar(20),
  @SubCuenta							varchar(50),
  @Almacen								varchar(10)
  
  SELECT @CfgCompraAutoCancelaCotizacion     = ISNULL(CompraAutoCancelaCotizacion, 0),
--		 @CfgCompraEstadoCotizacionInicial   = ec.CompraEstadoCotizacionInicial,
--		 @CfgCompraEstadoCotizacionEnUso     = ec.CompraEstadoCotizacionEnUso,
		 @CfgCompraEstadoCotizacionCancelado = 'Cancelada' --ec.CompraEstadoCotizacionCancelado
    FROM EmpresaCfg2 ec
   WHERE ec.Empresa = @Empresa
   
  IF @CfgCompraAutoCancelaCotizacion = 0
    RETURN
  
  CREATE TABLE #AplicaRequisicion(
  ID			int	NULL,
  Aplica		varchar(20)	COLLATE Database_Default NULL,
  AplicaID		varchar(20)	COLLATE Database_Default NULL,
  Articulo		varchar(20)	COLLATE Database_Default NULL)
  
  CREATE TABLE #AplicaCotizacion(
  ID			int	NULL,
  EmpresaRef	varchar(5)	COLLATE Database_Default NULL,
  Aplica		varchar(20)	COLLATE Database_Default NULL,
  AplicaID		varchar(20)	COLLATE Database_Default NULL,
  Articulo		varchar(20)	COLLATE Database_Default NULL,
  SubCuenta		varchar(50)	COLLATE Database_Default NULL,
  Almacen		varchar(10)	COLLATE Database_Default NULL,)

  INSERT INTO #AplicaRequisicion(ID, Aplica, AplicaID, Articulo)
  SELECT cd.ID, cd.Aplica, cd.AplicaID, cd.Articulo
  FROM CompraD cd
  JOIN MovTipo mt ON cd.Aplica = mt.Mov AND mt.Modulo = 'COMS' AND mt.Clave = 'COMS.R'
  WHERE ID = @ID

  INSERT INTO #AplicaCotizacion(ID, EmpresaRef, Aplica, AplicaID, Articulo, SubCuenta, Almacen)
  SELECT DISTINCT c.ID, ISNULL(cd.EmpresaRef, @Empresa), cd.Aplica, cd.AplicaID, cd.Articulo, ISNULL(cd.SubCuenta, ''), ISNULL(cd.Almacen, c.Almacen)
    FROM Compra c
    JOIN CompraD cd ON c.ID = cd.ID
    JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'COMS' AND mt.Clave = 'COMS.C'
    JOIN #AplicaRequisicion a ON cd.Aplica = a.Aplica AND cd.AplicaID = a.AplicaID AND cd.Articulo = a.Articulo
   WHERE c.Estatus = 'CONFIRMAR'
     AND ISNULL(cd.Estado, '') <> @CfgCompraEstadoCotizacionCancelado 
  
  DECLARE crCancelarRequisicionesPendientes CURSOR FOR
   SELECT c.ID, c.EmpresaRef, c.Aplica, c.AplicaID, c.Articulo, c.SubCuenta, c.Almacen
     FROM #AplicaCotizacion c

  OPEN crCancelarRequisicionesPendientes
  FETCH NEXT FROM crCancelarRequisicionesPendientes INTO @IDC, @EmpresaRef, @Aplica, @AplicaID, @Articulo, @SubCuenta, @Almacen
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN                         
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN

      UPDATE CompraD SET Estado = @CfgCompraEstadoCotizacionCancelado
       WHERE ID = @IDC AND ISNULL(EmpresaRef, @Empresa) = @EmpresaRef AND Aplica = @Aplica AND AplicaID = @AplicaID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta AND ISNULL(Almacen, @Almacen) = @Almacen

    END
  FETCH NEXT FROM crCancelarRequisicionesPendientes INTO @IDC, @EmpresaRef, @Aplica, @AplicaID, @Articulo, @SubCuenta, @Almacen
  END
  CLOSE crCancelarRequisicionesPendientes
  DEALLOCATE crCancelarRequisicionesPendientes

  DECLARE crCancelarRequisicionesPendientes2 CURSOR FOR
   SELECT DISTINCT c.ID
     FROM #AplicaCotizacion c
     JOIN Compra c2 ON c.ID = c2.ID
    WHERE c2.Estatus = 'CONFIRMAR'
   
  OPEN crCancelarRequisicionesPendientes2
  FETCH NEXT FROM crCancelarRequisicionesPendientes2 INTO @IDC
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL AND NOT EXISTS(SELECT * FROM CompraD cd WHERE ID = @IDC AND ISNULL(cd.Estado, '') <> @CfgCompraEstadoCotizacionCancelado)
  BEGIN                         
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC spAfectar 'COMS', @IDC, 'CANCELAR', NULL, NULL, @Usuario, 0, 1,
                     @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @FechaRegistro = @FechaRegistro, @Conexion = 1
    END
  FETCH NEXT FROM crCancelarRequisicionesPendientes2 INTO @IDC
  END
  CLOSE crCancelarRequisicionesPendientes2
  DEALLOCATE crCancelarRequisicionesPendientes2

  RETURN
END
GO

/**************** spEliminarOrdenesPendientes ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEliminarOrdenesPendientes') and sysstat & 0xf = 4) drop procedure dbo.spEliminarOrdenesPendientes
GO             
CREATE PROCEDURE spEliminarOrdenesPendientes
				@ID					int,
				@Accion				char(20),
				@Base				char(20),
				@Empresa	      	char(5),
				@Usuario			char(10),
				@Modulo	      		char(5),
				@Mov	  	      	char(20),
				@MovID             	varchar(20),
				@MovTipo     		char(20),
				@MovMoneda	      	char(10),
				@MovTipoCambio	 	float,
				@Estatus	 	    char(15),
				@EstatusNuevo	    char(15),
				@FechaEmision		datetime,
				@FechaRegistro		datetime,
				@FechaAfectacion    datetime,
				@Conexion			bit,
				@SincroFinal		bit,
				@Sucursal			int,

				@UtilizarID			int,
				@UtilizarMovTipo    char(20),

				@Ok					int		OUTPUT,
				@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Referencia						varchar(50),
    @AlmacenOrigen					char(10),
    @AlmacenDestino					char(10),
    @ArticuloDestino				char(20),
    @UnidadDestino					varchar(50),
    @Articulo						char(20), 
    @ArtTipo						varchar(20),
    @UnidadOrigen					varchar(50),
    @Renglon						float,
    @RenglonSub						int,
    @RenglonID						int,
    @RenglonTipo					char(1),
    @OCID							int,
    @CompraPerdidaID				int,
    @CompraPerdidaMov				char(20),
    @PedidoID						int, 
    @VentaPerdidaID					int,
    @VentaPerdidaMov				char(20),
    @CompraPerdidaAutoPorcentaje	float,
    @VentaPerdidaAutoPorcentaje		float,
    @CantidadOriginal				float,
    @CantidadPendiente				float

  IF @Modulo = 'COMS' AND (SELECT CompraPerdidaAuto FROM EmpresaCfg WHERE Empresa = @Empresa) = 1
  BEGIN
    SELECT @CompraPerdidaMov = CompraPerdida
      FROM EmpresaCfgMov 
     WHERE Empresa = @Empresa
     
    SELECT @CompraPerdidaAutoPorcentaje=ISNULL(CompraPerdidaAutoPorcentaje,0.0)
	  FROM EmpresaCfg
	 WHERE Empresa=@Empresa

    -- Eliminar Compra Pendientes Aplicadas
    DECLARE crComprasPendientes CURSOR FOR
     SELECT DISTINCT e.ID
       FROM CompraD d
       JOIN Compra e ON e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' AND e.Mov = d.Aplica AND e.MovID = d.AplicaID
       JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = e.Mov AND mt.Clave = 'COMS.O'
      WHERE d.ID = @ID
    OPEN crComprasPendientes
    FETCH NEXT FROM crComprasPendientes INTO @OCID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF EXISTS(SELECT * FROM CompraD WHERE ID = @OCID AND NULLIF(CantidadPendiente, 0.0) IS NOT NULL)
        BEGIN
          SELECT @CantidadOriginal = SUM(ISNULL(Cantidad,0)),
		         @CantidadPendiente = SUM(ISNULL(CantidadPendiente,0))
		    FROM CompraD WHERE ID = @OCID
		    
          IF 100-((@CantidadPendiente/@CantidadOriginal)*100) > @CompraPerdidaAutoPorcentaje
          BEGIN
            EXEC @CompraPerdidaID = spAfectar @Modulo, @OCID, 'GENERAR', 'PENDIENTE', @CompraPerdidaMov, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
            IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
            IF @Ok IS NULL
              EXEC spAfectar @Modulo, @CompraPerdidaID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT         
          END               
        END
      END
      FETCH NEXT FROM crComprasPendientes INTO @OCID
    END  -- While	
    CLOSE crComprasPendientes
    DEALLOCATE crComprasPendientes
  END  

  IF @Modulo = 'VTAS' AND (SELECT VentaPerdidaAuto FROM EmpresaCfg WHERE Empresa = @Empresa) = 1
  BEGIN
    SELECT @VentaPerdidaMov = VentaPerdida
      FROM EmpresaCfgMov 
     WHERE Empresa = @Empresa

	SELECT @VentaPerdidaAutoPorcentaje=ISNULL(VentaPerdidaAutoPorcentaje,0.0)
	  FROM EmpresaCfg
	 WHERE Empresa=@Empresa

    -- Eliminar Ventas Pendientes Aplicadas
    DECLARE crPedidosPendientes CURSOR FOR
     SELECT DISTINCT e.ID
       FROM VentaD d
       JOIN Venta e ON e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' AND e.Mov = d.Aplica AND e.MovID = d.AplicaID
       JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = e.Mov AND mt.Clave = 'VTAS.P'
      WHERE d.ID = @ID
    OPEN crPedidosPendientes
    FETCH NEXT FROM crPedidosPendientes INTO @PedidoID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
/*        IF EXISTS(SELECT * FROM VentaD WHERE ID = @PedidoID AND NULLIF(CantidadReservada, 0.0) IS NOT NULL)
          EXEC spAfectar @Modulo, @PedidoID, 'DESRESERVAR', 'RESERVADO', @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT*/

        IF EXISTS(SELECT * FROM VentaD WHERE ID = @PedidoID AND ISNULL(CantidadPendiente, 0.0) + ISNULL(CantidadReservada,0) + ISNULL(CantidadOrdenada,0) > 0)
        BEGIN
          SELECT @CantidadOriginal = SUM(ISNULL(Cantidad,0)),
		         @CantidadPendiente = SUM(ISNULL(CantidadPendiente,0) + ISNULL(CantidadReservada,0) + ISNULL(CantidadOrdenada,0))
		    FROM VentaD WHERE ID = @PedidoID

		  IF 100-((@CantidadPendiente/@CantidadOriginal)*100) > @VentaPerdidaAutoPorcentaje
          BEGIN
            EXEC @VentaPerdidaID = spAfectar @Modulo, @PedidoID, 'GENERAR', 'PENDIENTE', @VentaPerdidaMov, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
            IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
            IF @Ok IS NULL
              EXEC spAfectar @Modulo, @VentaPerdidaID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT         
          END
        END
      END
      FETCH NEXT FROM crPedidosPendientes INTO @PedidoID
    END  -- While	
    CLOSE crPedidosPendientes
    DEALLOCATE crPedidosPendientes
  END  

  RETURN
END
GO

--Ubicaciones 
/*********************************** spValidaCantUbic ************************************************/
IF EXISTS(SELECT * FROM dbo.SysObjects WHERE Id = Object_Id('[dbo].[spValidaCantUbic]'))
	DROP PROCEDURE spValidaCantUbic
GO
CREATE PROCEDURE spValidaCantUbic
        @ID		int,                
        @Existencia float
   --//WITH ENCRYPTION     
 AS
 DECLARE @cantidadA float

 SELECT @cantidadA=SUM(Cantidad)  FROM InvArtUbicacionD WHERE  RID=@ID
 IF @cantidadA>@Existencia
 UPDATE  InvArtUbicacionD SET Cantidad=0 WHERE  RID=@ID
 SELECT @cantidadA
 GO
 
 
 /******************************** spAsignarUbicaciones ********************************************************/
 IF EXISTS(SELECT * FROM dbo.SysObjects WHERE Id = Object_Id('[dbo].[spAsignarUbicaciones]'))
	DROP PROCEDURE spAsignarUbicaciones
GO
CREATE PROCEDURE spAsignarUbicaciones
        @ID		int,
        @Almacen	varchar(20),
        @Articulo		varchar(20),
        @Renglon  float(8),
        @Empresa  varchar(15) 
--//WITH ENCRYPTION     
 AS
 DECLARE @AlmacenB varchar(20),
 @ArticuloB varchar(20)
 
SELECT TOP 1 @AlmacenB = Almacen,@ArticuloB=Articulo  FROM invArtUbicaciones WHERE Articulo=@Articulo AND Renglon=@Renglon AND ID =@ID
IF @AlmacenB<>@Almacen  OR @ArticuloB<>@Articulo
DELETE FROM invArtUbicaciones WHERE Articulo=@Articulo AND Renglon=@Renglon AND ID =@ID

 IF NOT EXISTS(SELECT   Articulo FROM invArtUbicaciones WHERE Articulo=@Articulo AND Renglon=@Renglon AND ID =@ID)
     INSERT INTO invArtUbicaciones(id,Articulo,SubCuenta,SerieLote,Unidad,Existencia,Posicion,Renglon,Almacen, Renglonsub, RenglonId)
							SELECT id.id,el.Articulo,el.SubCuenta,el.SerieLote,el.Unidad,el.Existencia,el.Posicion,id.Renglon,el.Almacen, id.RenglonSub, id.RenglonId
							FROM ExistenciaAlternaPosicionSerieLote el 
							--JOIN Art ON el.Articulo=Art.Articulo 
							inner join invd id on EL.ARTICULO=ID.ARTICULO AND ISNULL(el.SUBCUENTA,'')= ISNULL(id.subcuenta,'')
							WHERE el.Articulo=@Articulo and id.id=@ID AND el.Almacen=@Almacen AND  id.Renglon=@Renglon  AND el.Empresa=@Empresa and el.Existencia>0



GO
EXEC spAlter_Table 'InvD','AsignacionUbicacion','bit NOT NULL DEFAULT 0'
EXEC spAlter_Table 'SerieLoteMov','AsignacionUbicacion','bit NOT NULL DEFAULT 0'
/******************************* xpAntesAfectarCambioPosicion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.xpAntesAfectarCambioPosicion') and type = 'P') drop procedure dbo.xpAntesAfectarCambioPosicion
GO             
CREATE PROCEDURE xpAntesAfectarCambioPosicion 
  @Empresa		varchar(20),
  @ID			int,
  @Mov			varchar(20),
  @movtipo		varchar(20),
  @Accion		varchar(20),
  @Estatus		varchar(20),
  @Ok			int OUTPUT,
  @OkRef		varchar(255) OUTPUT

AS BEGIN
DECLARE 
	@Renglon				float,
	@RenglonSub				int,
	@RenglonID				int,
	@CantidadA				float,
	@CantidadInventario		float,
	@Articulo				varchar(20),
	@Subcuenta				varchar(50),
	@Unidad					varchar(50), 
	@SerieLote				varchar(50),
	@Decimales				int,
	@Factor					int,
	@CfgMultiUnidades		bit,
	@CfgMultiUnidadesNivel  char(20),
	@RenglonUltimo			float,
	@RenglonIDUltimo		int,
	@RID					int,
	@PosicionDestino		varchar(10),	
	@Posicionactual		varchar(10)



  IF @MovTipo NOT IN ('INV.CPOS') RETURN
  IF @Estatus IN ('CONFIRMAR', 'SINAFECTAR') AND @Accion = 'AFECTAR'
  BEGIN 
  
  DELETE SerieLoteMov WHERE ID = @ID AND AsignacionUbicacion = 1
  DELETE InvD WHERE ID = @ID AND AsignacionUbicacion = 1


  SELECT @CfgMultiUnidades         = MultiUnidades,
	 @CfgMultiUnidadesNivel    = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  CREATE TABLE #RenglonActualizado (ID int, Renglon Float)

  SELECT @RenglonUltimo = MAX(Renglon), @RenglonIDUltimo = MAX(RenglonID) FROM InvD WHERE ID = @ID

  
  IF EXISTS ( SELECT e.ID FROM InvD d
JOIN InvArtUbicaciones e ON d.ID = e.ID AND d.Renglon = e.Renglon AND d.Articulo = d.Articulo  AND d.REnglonSub = e.Renglonsub
     WHERE d.ID = @ID AND e.Articulo <> d.Articulo)
	 SELECT @Ok = 1, @OkRef = 'El Articulo ya no Corresponde al Cambio de Ubicaciones' 


  --IF EXISTS ( SELECT e.ID FROM InvD d
  --LEFT OUTER JOIN InvArtUbicaciones e ON d.ID = e.ID AND d.Renglon = e.Renglon AND d.Articulo = d.Articulo  AND d.REnglonSub = e.Renglonsub
  --    LEFT OUTER JOIN InvArtUbicacionD ed ON e.RID = ed.RID
  --   WHERE d.ID = @ID AND ISNULL(ed.cantidad,e.CantidadA) IS NULL)
	 --SELECT @Ok = 1, @OkRef = 'Falta Especificar Cantidad en Detalle Ubicaciones' 

--SELECT REnglon, REnglonSub, REnglonID, Articulo, Subcuenta, SerieLote,  Unidad, ISNULL(d.cantidad,CantidadA), ISNuLL(d.posicion, PosicionDestino)  
--	FROM InvArtUbicaciones e
--	  LEFT OUTER JOIN InvArtUbicacionD d ON e.RID = d.RID
--	 WHERE ID = @ID AND d.RenglonInvD IS NULL  AND ISNULL(d.cantidad,e.CantidadA) IS NOT NULL
--	-- GROUP BY ID, REnglon, REnglonSub, REnglonID, Articulo, Subcuenta, SerieLote, Unidad,  PosicionDestino, ISNuLL(d.posicion, PosicionDestino) 
	 

  DECLARE CrVaciarDetallePosicion CURSOR FOR 
    SELECT REnglon, REnglonSub, REnglonID, Articulo, Subcuenta, SerieLote,  Unidad, Sum(ISNULL(d.cantidad,CantidadA)), ISNuLL(d.posicion, PosicionDestino) , e.Posicion
    FROM InvArtUbicaciones e
      LEFT OUTER JOIN InvArtUbicacionD d ON e.RID = d.RID
     WHERE ID = @ID AND d.RenglonInvD IS NULL  AND ISNULL(d.cantidad,e.CantidadA) IS NOT NULL
     GROUP BY ID, REnglon, REnglonSub, REnglonID, Articulo, Subcuenta, SerieLote, Unidad,  ISNuLL(d.posicion, PosicionDestino), e.Posicion 
	 
  OPEN CrVaciarDetallePosicion
  FETCH NEXT FROM CrVaciarDetallePosicion INTO @Renglon, @RenglonSub, @REnglonID, @Articulo, @Subcuenta, @SerieLote,  @Unidad, @CantidadA, @PosicionDestino, @PosicionActual
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF EXISTS (SELECT ID FROM InvD WHERE Id = @ID AND renglon = @Renglon AND @RenglonSub = RenglonSub AND Articulo = @Articulo )
      BEGIN
        SELECT @Factor = 1.0
        IF @CfgMultiUnidades = 1
        BEGIN
          IF @CfgMultiUnidadesNivel = 'ARTICULO'
            EXEC xpArtUnidadFactor @Articulo, @SubCuenta, @Unidad, @Factor OUTPUT, @Decimales OUTPUT, NULL
          ELSE
            EXEC xpUnidadFactor @Articulo, @SubCuenta, @Unidad, @Factor OUTPUT, @Decimales OUTPUT

          SELECT @Factor = ISNULL(NULLIF(@Factor, 0), 1)
        END
        SELECT @CantidadInventario = @CantidadA * ISNULL(@Factor, 1.0)
  
        IF NOT EXISTS (SELECT ID FROM #RenglonActualizado WHERE ID = @ID and REnglon = @Renglon)
        BEGIN
          UPDATE InvD SET Cantidad = @CantidadA, Unidad = @Unidad, CantidadInventario = @CantidadInventario, Posicion = @PosicionActual, PosicionDestino = @PosicionDestino WHERE ID = @ID AND Renglon = @Renglon AND Articulo = @Articulo 

          IF @SerieLote IS NOT NULL
          INSERT SerieLoteMov (Empresa,  Modulo,  ID,  RenglonID,  Articulo, SubCuenta, SerieLote, Cantidad, AsignacionUbicacion)
          SELECT @Empresa, 'INV', @ID, @RenglonID, Articulo,  ISNULL(SubCuenta, ''), SerieLote, SUM(ISNULL(d.cantidad,CantidadA)), 1
            FROM InvArtUbicaciones e
            LEFT OUTER JOIN InvArtUbicacionD d ON e.RID = d.RID
           WHERE ID = @ID
             AND REnglon = @REnglon And REnglonSub = @REnglonSub AND REnglonID = @RenglonId AND Articulo = @Articulo AND ISNuLL(Subcuenta,'') = ISNULL(@Subcuenta,'') AND SerieLote = @SerieLote AND Unidad = @Unidad AND   ISNULL(d.posicion, PosicionDestino) = @PosicionDestino AND e.posicion = @PosicionActual
           GROUP BY ID, REnglon, REnglonSub, REnglonID, Articulo, Subcuenta, SerieLote, Unidad,  ISNuLL(d.posicion, PosicionDestino), e.Posicion 



          INSERT #RenglonActualizado (ID, Renglon) VALUES (@ID, @Renglon)   

		  UPDATE InvArtUbicaciones SET RenglonInvD = @Renglon FROM InvArtUbicaciones e
            LEFT OUTER JOIN InvArtUbicacionD d ON e.RID = d.RID
           WHERE ID = @ID
             AND REnglon = @REnglon And REnglonSub = @REnglonSub AND REnglonID = @RenglonId AND Articulo = @Articulo AND ISNULL(Subcuenta,'') = ISNULL(@Subcuenta,'') AND SerieLote = @SerieLote AND Unidad = @Unidad AND   ISNULL(d.posicion, PosicionDestino) = @PosicionDestino AND e.posicion = @PosicionActual

        END
        ELSE 
        BEGIN
          SELECT @RenglonUltimo = @RenglonUltimo + 2048, @RenglonIDultimo = @RenglonIDUltimo + 1
          INSERT InvD (ID,         Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Aplica,     AplicaID,     Almacen,  Producto,  SubProducto,  ProdSerieLote,  Articulo,  SubCuenta,  Cantidad,  Merma,  Desperdicio,  Unidad,  CantidadInventario, Factor,  Tipo, Posicion, PosicionDestino, AsignacionUbicacion)
          SELECT @ID, @RenglonUltimo, 0,          @RenglonIDultimo, RenglonTipo, NULL, NULL, Almacen, Producto, SubProducto, ProdSerieLote, Articulo, SubCuenta, @CantidadA, Merma, Desperdicio, @Unidad, @CantidadInventario, @Factor, Tipo, @PosicionActual, @PosicionDestino, 1
            FROM InvD
           WHERE ID = @ID AND Renglon = @Renglon AND Articulo = @Articulo 


          IF @SerieLote IS NOT NULL
          INSERT SerieLoteMov (Empresa,  Modulo,  ID,  RenglonID,  Articulo, SubCuenta, SerieLote, Cantidad, AsignacionUbicacion)
          SELECT @Empresa, 'INV', @ID, @RenglonIDUltimo, Articulo,  ISNULL(SubCuenta, ''), SerieLote, SUM(ISNULL(d.cantidad,CantidadA)), 1 
            FROM InvArtUbicaciones e
            LEFT OUTER JOIN InvArtUbicacionD d ON  e.RID = d.RID
           WHERE ID = @ID
             AND REnglon = @REnglon And REnglonSub = @REnglonSub AND REnglonID = @RenglonId AND Articulo = @Articulo AND ISNULL(Subcuenta,'') = ISNULL(@Subcuenta,'') AND SerieLote = @SerieLote AND Unidad = @Unidad AND   ISNULL(d.posicion, PosicionDestino) = @PosicionDestino AND e.posicion = @PosicionActual
           GROUP BY ID, REnglon, REnglonSub, REnglonID, Articulo, Subcuenta, SerieLote, Unidad,  ISNuLL(d.posicion, PosicionDestino), e.Posicion 


		  UPDATE InvArtUbicaciones SET RenglonInvD = @RenglonIDUltimo             FROM InvArtUbicaciones e
            LEFT OUTER JOIN InvArtUbicacionD d ON e.RID = d.RID
           WHERE ID = @ID
             AND REnglon = @REnglon And REnglonSub = @REnglonSub AND REnglonID = @RenglonId AND Articulo = @Articulo AND ISNULL(Subcuenta,'') = ISNULL(@Subcuenta,'') AND SerieLote = @SerieLote AND Unidad = @Unidad AND   ISNULL(d.posicion, PosicionDestino) = @PosicionDestino

        END
      END
      ELSE
      BEGIN 
        SELECT @RID = RID FROM InvArtUbicaciones WHERE ID = @ID AND renglon = @Renglon AND @RenglonSub = RenglonSub AND Articulo = @Articulo 
        DELETE InvArtUbicaciones WHERE RID = @RID
        DELETE InvArtUbicacionD WHERE RID = @RID
      END
    END
  FETCH NEXT FROM CrVaciarDetallePosicion INTO @Renglon, @RenglonSub, @REnglonID, @Articulo, @Subcuenta, @SerieLote,  @Unidad, @CantidadA, @PosicionDestino, @PosicionActual
  END  -- While
  CLOSE CrVaciarDetallePosicion
  DEALLOCATE CrVaciarDetallePosicion

  IF @Ok IS NULL
    UPDATE Inv SET Estatus = 'CONFIRMAR' WHERE ID = @ID
--Probar si no se afecta el movimiento y se vuelve a mandatr a afectar
END


END
GO
/*************** spActualizarUbicaciones  ********************/
IF EXISTS(SELECT * FROM dbo.SysObjects WHERE Id = Object_Id('[dbo].[spActualizarUbicaciones]'))
	DROP PROCEDURE spActualizarUbicaciones
GO
CREATE PROCEDURE spActualizarUbicaciones
        @ID		   int,
        @Renglon   float,
        @Articulo  char(20),
        @Almacen   varchar(10),
        @Empresa   char(20)
--//WITH ENCRYPTION       
AS
DECLARE @SerieLote			varchar(50),		
		@CantidadA			float,
		@Existencia			float,
		@ExistenciaAnterior	float,
		@Unidad				varchar(50),
		@PosicionDestino	varchar(10),
		@Posicion			varchar(10),
		@RID				int,
		@CantidadDetalle	float	
		
		
CREATE TABLE #invArtUbicacionesTemp
  (
    RID				int		NOT NULL,
	ID				int		NULL,
	Renglon			float NULL,
	RenglonSub		int  NULL,
	RenglonID		int  NULL,
	Articulo		char(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	SerieLote		varchar(50)	NULL,
	Unidad			varchar(50)	NULL,
	Existencia		float		NULL,
	Posicion		varchar(10)	NULL,
	CantidadA		float		NULL,
	PosicionDestino	varchar(10)	NULL,
	RenglonInvD		float      NULL,
	Almacen			varchar(10) NULL
   )
    CREATE TABLE #InvArtUbicacionDTemp (
	
	RID				int		NOT NULL ,			
	Posicion		varchar(10)	NOT NULL,
	Cantidad		float		NULL,
	RenglonInvD		float      NULL
	)
	
  INSERT INTO #invArtUbicacionesTemp(rid,id,Articulo,SubCuenta,SerieLote,Unidad,Existencia,Posicion,Renglon,Almacen, Renglonsub, RenglonId,CantidadA,PosicionDestino)
							SELECT rid,id,Articulo,SubCuenta,SerieLote,Unidad,Existencia,Posicion,Renglon,Almacen, Renglonsub, RenglonId,CantidadA,PosicionDestino
							FROM invArtUbicaciones
							WHERE id=@ID AND Renglon=@Renglon AND Articulo =@Articulo AND Almacen=@Almacen 
							

					
DELETE FROM invArtUbicaciones WHERE  id=@ID	AND renglon =@Renglon AND Articulo =@Articulo AND Almacen=@Almacen

INSERT INTO invArtUbicaciones(id,Articulo,SubCuenta,SerieLote,Unidad,Existencia,Posicion,Renglon,Almacen, Renglonsub, RenglonId)
							SELECT id.id,el.Articulo,el.SubCuenta,el.SerieLote,el.Unidad,el.Existencia,el.Posicion,id.Renglon,el.Almacen, id.RenglonSub, id.RenglonId
							FROM ExistenciaAlternaPosicionSerieLote el 
							--JOIN Art ON el.Articulo=Art.Articulo 
							inner join invd id on EL.ARTICULO=ID.ARTICULO AND ISNULL(el.SUBCUENTA,'')= ISNULL(id.subcuenta,'')
							WHERE el.Articulo=@Articulo and id.id=@ID AND el.Almacen=@Almacen AND  id.Renglon=@Renglon  AND el.Empresa=@Empresa and el.Existencia>0
							
  
 DECLARE crUbicaciones CURSOR FOR
	 SELECT RID,ID,Renglon,Articulo, SerieLote, Unidad, Existencia,Posicion,Almacen 
	FROM invArtUbicaciones WHERE id=@ID and renglon =@Renglon AND Articulo =@Articulo AND Almacen=@Almacen
							
 OPEN crUbicaciones
    FETCH NEXT FROM crUbicaciones INTO @RID,@ID,@Renglon,@Articulo, @SerieLote, @Unidad, @Existencia,@Posicion,@Almacen
    WHILE @@FETCH_STATUS = 0 
    BEGIN 
		SELECT @CantidadA=CantidadA,@PosicionDestino=PosicionDestino,@ExistenciaAnterior= Existencia FROM  #invArtUbicacionesTemp 
		WHERE Articulo=@Articulo AND SerieLote=@SerieLote AND Unidad=@Unidad AND  Posicion=@Posicion AND Almacen=@Almacen
		
		IF @Existencia>=@CantidadA
		UPDATE invArtUbicaciones SET CantidadA=@CantidadA,PosicionDestino=@PosicionDestino 
		WHERE Articulo=@Articulo AND SerieLote=@SerieLote AND Unidad=@Unidad AND  Posicion=@Posicion AND Almacen=@Almacen
		/*detalle de ubicaciones */
		INSERT INTO #InvArtUbicacionDTemp(rid,Posicion,Cantidad,RenglonInvD)
							SELECT rid,Posicion,Cantidad,RenglonInvD
							FROM InvArtUbicacionD
							WHERE rid=@RID 
		DELETE FROM InvArtUbicacionD WHERE rid=@RID 
		SELECT @CantidadDetalle =SUM(Cantidad) FROM #InvArtUbicacionDTemp WHERE  rid=@RID 
		IF @Existencia>@CantidadDetalle
		BEGIN
		 INSERT INTO InvArtUbicacionD(rid,Posicion,Cantidad,RenglonInvD) 
		 SELECT rid,Posicion,Cantidad,RenglonInvD FROM #InvArtUbicacionDTemp WHERE  rid=@RID 
		END
		
							
	FETCH NEXT FROM crUbicaciones INTO @RID,@ID,@Renglon,@Articulo, @SerieLote, @Unidad, @Existencia,@Posicion,@Almacen

    END  							
CLOSE crUbicaciones
DEALLOCATE crUbicaciones


GO
