SET ANSI_DEFAULTS OFF
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/**************** spSeriesLotesMayoreo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSeriesLotesMayoreo') and type = 'P') drop procedure dbo.spSeriesLotesMayoreo
GO              
CREATE PROCEDURE spSeriesLotesMayoreo
		   @Sucursal			int,
		   @SucursalAlmacen		int,
                   @SucursalAlmacenDestino	int,	
	           @Empresa			char(5),
                   @Modulo                      char(5),
                   @Accion			char(20),
		   @AfectarCostos		bit,
		   @EsEntrada			bit, 
		   @EsSalida			bit, 
		   @EsTransferencia		bit,

                   @ID  			int, 
	           @RenglonID			int, 
                   @Almacen			char(10),
		   @AlmacenDestino		char(10),
                   @Articulo                    char(20),
		   @SubCuenta			varchar(50),
		   @ArtTipo			char(20),
		   @ArtSerieLoteInfo		bit,
		   @ArtLotesFijos		bit,	
		   @ArtCosto			float,
		   @ArtCostoInv			float,
                   @CantidadMovimiento 		float,
		   @Factor			float,
		   @MovTipo			char(20),
		   @AplicaMovTipo		char(20),
		   @AlmacenTipo			char(20),
		   @FechaEmision		datetime,

		   @CfgCosteoSeries		bit,                   
		   @CfgCosteoLotes		bit,
		   @ArtCostoIdentificado	bit, 	
		   @CfgValidarLotesCostoDif	bit,
		   @CfgVINAccesorioArt		bit, 
		   @CfgVINCostoSumaAccesorios	bit,

                   @Ok 				int		OUTPUT, 
                   @OkRef 			varchar(255)	OUTPUT,
		   @Temp			bit = 0,
		   @Tarima			varchar(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @SubCuentaNull		varchar(50),
    @SerieLote			varchar(50),
    @SerieLotePropiedades	varchar(50),
    @Propiedades		char(20),
    @Cliente			varchar(10),
    @Localizacion		varchar(10),
    @Cantidad			float,
    @CantidadAlterna		float,
    @CantidadTomada		float,
    @ArtCostoF			float,
    @ArtCostoInvF		float,
    @SumaCantidad		float,
    @SumaCantidadAlterna	float,
    @Requiere	        	float,
    @ExistenciaNueva 		float,
    @ExistenciaAnterior		float,
    @CosteoLotes		bit,
    @CostoPromedio		float,
    @UltimaEntrada		datetime,
    @UltimaSalida		datetime,
    @AlmacenTarima		varchar(20),
    @AlmacenDestinoTarima	varchar(20),
    @MovSubTipo				char(20),
    @PedimentoExtraccion	char(50),
--REQ 13386  
    @LDIArticulo                bit,
    @LDI                        bit,
    @OrigenTipo                 varchar(10),
    @WMS						bit,  --BUG3819
    @TarimaOrigen               varchar(20),
	@ArticuloTarjetasDef		varchar(20)



  DECLARE @SerieloteMovVal TABLE
                               ( 
                                 RenglonID        int         NULL, 
                                 SerieLote        varchar(50) NULL, 
                                 TarimaOrigen     varchar(20) NULL, 
                                 Cantidad         float       NULL, 
                                 SucursalAlmacen  int         NULL
                               )

  SELECT @WMS = ISNULL(WMS,0) FROM Alm WHERE Almacen = @Almacen  --BUG3819
  SELECT @ArticuloTarjetasDef = CxcArticuloTarjetasDef FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @OrigenTipo = OrigenTipo FROM Venta WHERE ID = @ID
  SELECT @LDI = ISNULL(InterfazLDI,0) FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT @LDIArticulo = ISNULL(LDI,0) FROM Art WHERE Articulo = @Articulo      

  SELECT @SubCuenta              = ISNULL(RTRIM(@SubCuenta), ''), 
         @SubCuentaNull          = NULLIF(RTRIM(@SubCuenta), ''),
         @Tarima		 = ISNULL(RTRIM(@Tarima), ''), 
         @UltimaEntrada          = NULL,
         @UltimaSalida           = NULL,
         @CosteoLotes	         = 0
         
  SELECT @MovSubTipo = NULLIF(RTRIM(mt.SubClave), '')
    FROM MovTipo mt
   WHERE mt.Modulo = @Modulo AND mt.Clave = @MovTipo

  SELECT @AlmacenTarima		 = dbo.fnAlmacenTarima(@Almacen, @Tarima),
         @AlmacenDestinoTarima	 = dbo.fnAlmacenTarima(@AlmacenDestino, @Tarima)

  IF ((@ArtTipo IN ('LOTE', 'PARTIDA') AND (@CfgCosteoLotes  = 1 OR @ArtCostoIdentificado = 1)) OR 
      (@ArtTipo IN ('SERIE', 'VIN')    AND (@CfgCosteoSeries = 1 OR @ArtCostoIdentificado = 1))) SELECT @CosteoLotes = 1
  IF (@AplicaMovTipo = 'COMS.CC' AND @MovTipo IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI')) OR (@AplicaMovTipo = 'VTAS.R' AND @MovTipo IN ('VTAS.F', 'VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX')) RETURN

  --IF @MovTipo IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR', 'VTAS.FM', 'COMS.CC') AND @CosteoLotes = 1 AND @ArtSerieLoteInfo = 0 SELECT @Ok = 20720
  -- Para corregir este problema hay que enviar la Serie/Lote a movimiento Final ??

  IF @EsEntrada = 1 SELECT @UltimaEntrada = @FechaEmision ELSE
  IF @EsSalida  = 1 SELECT @UltimaSalida  = @FechaEmision

  IF @EsEntrada = 1 AND @Modulo = 'INV' AND @MovTipo = 'INV.EI' AND @MovSubTipo = 'INV.EXT' AND @Accion = 'AFECTAR'
  BEGIN
  	SELECT @PedimentoExtraccion = NULLIF(RTRIM(i.PedimentoExtraccion), '')
  	  FROM Inv i
  	WHERE i.ID = @ID

    IF @PedimentoExtraccion IS NOT NULL AND (SELECT COUNT(*)
          FROM SerieLoteMov
         WHERE Empresa   = @Empresa
           AND Modulo    = @Modulo
           AND ID        = @ID
           AND RenglonID = @RenglonID
           AND Articulo  = @Articulo
           AND NULLIF(RTRIM(SubCuenta), '') = @SubCuentaNull) > 1
    SELECT @Ok = 73070, @OkRef = 'Producto ' + RTRIM(@Articulo)

  	IF @PedimentoExtraccion IS NOT NULL AND @Ok IS NULL
    BEGIN
  	  UPDATE SerieLoteMov SET SerieLote = @PedimentoExtraccion
       WHERE Empresa   = @Empresa
         AND Modulo    = @Modulo
         AND ID        = @ID
         AND RenglonID = @RenglonID
         AND Articulo  = @Articulo
         AND NULLIF(RTRIM(SubCuenta), '') = @SubCuentaNull
    END
  END

  SELECT @ArtCostoF = @ArtCosto / @Factor--, @ArtCostoInvF = @ArtCostoInv / @Factor
  SELECT @SumaCantidad = 0.0, @SumaCantidadAlterna = 0.0
  IF @Temp = 1
  BEGIN
    CREATE INDEX Llave ON #SerieLoteMov (ID, RenglonID, Articulo, SubCuenta, SerieLote, Modulo, Empresa)     
    DECLARE crSerieLoteMov CURSOR FOR 
     SELECT NULLIF(RTRIM(SerieLote), ''), ISNULL(Cantidad, 0.0)/**@Factor*/, ISNULL(CantidadAlterna, 0.0)/**@Factor*/, NULLIF(RTRIM(Propiedades), ''), NULLIF(RTRIM(Cliente), ''), NULLIF(RTRIM(Localizacion), ''), ISNULL(NULLIF(ArtCostoInv, 0), @ArtCostoInv) / @Factor 
       FROM #SerieLoteMov
      WHERE Empresa   = @Empresa
        AND Modulo    = @Modulo
        AND ID        = @ID
        AND RenglonID = @RenglonID
        AND Articulo  = @Articulo
        AND NULLIF(RTRIM(SubCuenta), '') = @SubCuentaNull
  END ELSE
		IF ISNULL(@AlmacenTarima,'') = ''
			DECLARE crSerieLoteMov CURSOR FOR 
			 SELECT NULLIF(RTRIM(SerieLote), ''), ISNULL(Cantidad, 0.0)/**@Factor*/, ISNULL(CantidadAlterna, 0.0)/**@Factor*/, NULLIF(RTRIM(Propiedades), ''), NULLIF(RTRIM(Cliente), ''), NULLIF(RTRIM(Localizacion), ''), ISNULL(NULLIF(ArtCostoInv, 0), @ArtCostoInv) / @Factor 
			   FROM SerieLoteMov
			  WHERE Empresa   = @Empresa
				AND Modulo    = @Modulo
				AND ID        = @ID
				AND RenglonID = @RenglonID
				AND Articulo  = @Articulo
				AND NULLIF(RTRIM(SubCuenta), '') = @SubCuentaNull
		ELSE 
			DECLARE crSerieLoteMov CURSOR FOR 
			 SELECT NULLIF(RTRIM(SerieLote), ''), ISNULL(Cantidad, 0.0)/**@Factor*/, ISNULL(CantidadAlterna, 0.0)/**@Factor*/, NULLIF(RTRIM(Propiedades), ''), NULLIF(RTRIM(Cliente), ''), NULLIF(RTRIM(Localizacion), ''), ISNULL(NULLIF(ArtCostoInv, 0), @ArtCostoInv) / @Factor 
			   FROM SerieLoteMov
			  WHERE Empresa   = @Empresa
				AND Modulo    = @Modulo
				AND ID        = @ID
				AND RenglonID = @RenglonID
				AND Articulo  = @Articulo
				AND NULLIF(RTRIM(SubCuenta), '') = @SubCuentaNull

  OPEN crSerieLoteMov
  FETCH NEXT FROM crSerieLoteMov INTO @SerieLote, @Cantidad, @CantidadAlterna, @Propiedades, @Cliente, @Localizacion, @ArtCostoInvF
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND (@Cantidad <> 0.0 OR @CantidadAlterna <> 0.0)
    BEGIN
      SELECT @SumaCantidad = @SumaCantidad + @Cantidad, @SumaCantidadAlterna = @SumaCantidadAlterna + @CantidadAlterna
      SELECT @ExistenciaNueva = 0.0, @ExistenciaAnterior = 0.0, @CostoPromedio = 0.0

      SELECT @ExistenciaAnterior = CASE @AlmacenTipo WHEN 'ACTIVOS FIJOS' THEN ISNULL(ExistenciaActivoFijo, 0.0) ELSE ISNULL(Existencia, 0.0) END,
             @SerieLotePropiedades = NULLIF(RTRIM(Propiedades), '')
        FROM SerieLote
       WHERE Sucursal  = @SucursalAlmacen
         AND Empresa   = @Empresa 
         AND Articulo  = @Articulo 
         AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'')
         AND SerieLote = @SerieLote 
         AND Almacen   = @Almacen
		 AND ISNULL(Tarima,'')    = ISNULL(@AlmacenTarima,'')

      IF (@EsSalida = 1 OR @EsTransferencia = 1 OR @Modulo = 'VTAS') AND @Propiedades <> @SerieLotePropiedades AND @Propiedades IS NULL 
      BEGIN
        SELECT @Propiedades = @SerieLotePropiedades
        IF @Temp = 1
          UPDATE #SerieLoteMov SET Propiedades = @Propiedades WHERE CURRENT OF crSerieLoteMov
        ELSE
          UPDATE SerieLoteMov SET Propiedades = @Propiedades WHERE CURRENT OF crSerieLoteMov
      END

      IF @CosteoLotes = 1
      BEGIN
        SELECT @CostoPromedio = ISNULL(SUM(ISNULL(Existencia, 0.0) * ISNULL(CostoPromedio, 0.0))/NULLIF(SUM(Existencia), 0.0), 0.0)
          FROM SerieLote
         WHERE Empresa 	 = @Empresa 
           AND Articulo  = @Articulo 
           AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta ,'')
           AND SerieLote = @SerieLote
           AND Almacen   = @Almacen
           AND ISNULL(Tarima,'') = ISNULL(@AlmacenTarima,'')
           AND Sucursal  = @SucursalAlmacen

        IF (@EsSalida = 1 OR @EsTransferencia = 1) AND @ArtLotesFijos = 1 AND @Accion <> 'CANCELAR'
          SELECT @ArtCostoInvF = @CostoPromedio
      END
	  
      IF (@EsEntrada = 1 OR @ArtSerieLoteInfo = 1) AND @Ok IS NULL
      BEGIN
        IF @ArtSerieLoteInfo = 1 SELECT @Cantidad = 0.0
        IF (@AlmacenTipo = 'ACTIVOS FIJOS' AND  @Accion <> 'CANCELAR')
		BEGIN

		  UPDATE SerieLote
             SET @ExistenciaNueva = ExistenciaActivoFijo = ISNULL(ExistenciaActivoFijo, 0.0) + @Cantidad,
                 UltimaEntrada = CASE WHEN @EsEntrada = 1 AND @Accion <> 'CANCELAR' THEN @FechaEmision ELSE UltimaEntrada END,
                 UltimaSalida  = CASE WHEN @EsSalida  = 1 AND @Accion <> 'CANCELAR' THEN @FechaEmision ELSE UltimaSalida  END
           WHERE Sucursal  = @SucursalAlmacen
             AND Empresa   = @Empresa 
             AND Articulo  = @Articulo 
             AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'')
             AND SerieLote = @SerieLote 
             AND Almacen   = @Almacen
             AND ISNULL(Tarima,'') = ISNULL(@AlmacenTarima,'')

		END
        ELSE
		IF @Accion = 'CANCELAR'        
		BEGIN
            DECLARE crSerieLote CURSOR FOR  
            SELECT slm.RenglonID, slm.SerieLote, slm.Tarima, slm.Cantidad, a.Sucursal
              FROM SerieloteMov slm
              JOIN Alm a ON slm.Sucursal = a.Sucursal
             WHERE Id = @ID
                AND Modulo = @Modulo
                AND slm.Tarima <> ''
                AND slm.Articulo = @Articulo
                AND ISNULL(slm.SubCuenta,'') = ISNULL(@SubCuenta,'')
				AND a.Almacen = @Almacen 
                AND slm.Empresa = @Empresa 
                AND slm.Sucursal = @Sucursal 
            OPEN crSerieLote  
            FETCH NEXT FROM crSerieLote INTO @RenglonID, @SerieLote, @TarimaOrigen, @Cantidad, @SucursalAlmacen  
            WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
            BEGIN 

               IF EXISTS (SELECT * FROM SerieLote WHERE Sucursal = @SucursalAlmacen AND Empresa = @Empresa AND Articulo  = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND SerieLote = @SerieLote AND Almacen = @Almacen AND ISNULL(Tarima,'') = ISNULL(@TarimaOrigen,'') )
                  UPDATE SerieLote
				     SET Existencia = 0,
					     UltimaEntrada  = UltimaEntrada,
					     UltimaSalida   = UltimaSalida
				   WHERE Sucursal             = @SucursalAlmacen 
                     AND Empresa              = @Empresa 
                     AND Articulo             = @Articulo 
                     AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') 
                     AND SerieLote            = @SerieLote 
                     AND Almacen              = @Almacen 
                     AND ISNULL(Tarima,'')    = ISNULL(@TarimaOrigen,'') 
                
               IF NOT EXISTS (SELECT * FROM @SerieloteMovVal WHERE RenglonID = @RenglonID AND SerieLote = @SerieLote AND TarimaOrigen = @TarimaOrigen AND @Cantidad = @Cantidad AND SucursalAlmacen = @SucursalAlmacen)
                 UPDATE SerieLote
                   SET @ExistenciaNueva = Existencia = ISNULL(Existencia, 0.0) + @Cantidad,
                       ExistenciaAlterna = ISNULL(ExistenciaAlterna, 0.0) + @CantidadAlterna,
                       UltimaEntrada     = CASE WHEN @EsEntrada = 1 AND @Accion <> 'CANCELAR' THEN @FechaEmision ELSE UltimaEntrada END,
                       UltimaSalida      = CASE WHEN @EsSalida  = 1 AND @Accion <> 'CANCELAR' THEN @FechaEmision ELSE UltimaSalida  END
                 WHERE Sucursal  = @SucursalAlmacen
                   AND Empresa   = @Empresa 
                   AND Articulo  = @Articulo 
                   AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'')
                   AND SerieLote = @SerieLote 
                   AND Almacen   = @Almacen
                   AND ISNULL(Tarima,'') = ISNULL(@AlmacenTarima,'') 

                   INSERT @SerieloteMovVal (RenglonID, SerieLote, TarimaOrigen, Cantidad, SucursalAlmacen)
                                     SELECT @RenglonID, @SerieLote, @TarimaOrigen, @Cantidad, @SucursalAlmacen 
  
              FETCH NEXT FROM crSerieLote INTO @RenglonID, @SerieLote, @TarimaOrigen, @Cantidad, @SucursalAlmacen
            END  
            CLOSE crSerieLote  
            DEALLOCATE crSerieLote 
        END    
		/*CABSA ticket 139
        IF EXISTS (SELECT * FROM SerieLote WHERE Sucursal = @SucursalAlmacen AND Empresa = @Empresa AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND SerieLote = @SerieLote AND Almacen = @Almacen AND ISNULL(Tarima,'') = ISNULL(@AlmacenTarima,''))             
        BEGIN
          IF @AlmacenTipo = 'ACTIVOS FIJOS'          
            UPDATE SerieLote 
               SET ExistenciaActivoFijo = ISNULL(ExistenciaActivoFijo,0) + @Cantidad, 
                   UltimaEntrada = @UltimaEntrada,
                   UltimaSalida = @UltimaSalida
             WHERE Sucursal = @SucursalAlmacen AND Empresa = @Empresa AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND SerieLote = @SerieLote AND Almacen = @Almacen AND ISNULL(Tarima,'') = ISNULL(@AlmacenTarima,'')
          ELSE
            UPDATE SerieLote 
               SET Existencia = ISNULL(Existencia,0) + @Cantidad, 
                   UltimaEntrada = @UltimaEntrada,
                   UltimaSalida = @UltimaSalida
             WHERE Sucursal = @SucursalAlmacen AND Empresa = @Empresa AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND SerieLote = @SerieLote AND Almacen = @Almacen AND ISNULL(Tarima,'') = ISNULL(@AlmacenTarima,'')
	    END
		*/
		
		
        IF NOT EXISTS (SELECT * FROM SerieLote WHERE Sucursal = @SucursalAlmacen AND Empresa = @Empresa AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') AND SerieLote = @SerieLote AND Almacen = @Almacen AND ISNULL(Tarima,'') = ISNULL(@AlmacenTarima,''))             
        BEGIN
          IF @AlmacenTipo = 'ACTIVOS FIJOS'          
            INSERT SerieLote (Sucursal,         Empresa,  Articulo,  SubCuenta,  SerieLote,  Almacen,  Tarima,         Propiedades,  Cliente,  Localizacion,  ExistenciaActivoFijo, UltimaEntrada,  UltimaSalida)
                      VALUES (@SucursalAlmacen, @Empresa, @Articulo, @SubCuenta, @SerieLote, @Almacen, @AlmacenTarima, @Propiedades, @Cliente, @Localizacion, @Cantidad,            @UltimaEntrada, @UltimaSalida)
          ELSE
            INSERT SerieLote (Sucursal,          Empresa,  Articulo,  SubCuenta,  SerieLote,  Almacen, Tarima,         Propiedades,  Cliente,  Localizacion,  Existencia, ExistenciaAlterna, UltimaEntrada,  UltimaSalida)
                      VALUES (@SucursalAlmacen, @Empresa, @Articulo, @SubCuenta, @SerieLote, @Almacen, @AlmacenTarima, @Propiedades, @Cliente, @Localizacion, @Cantidad,  @CantidadAlterna,  @UltimaEntrada, @UltimaSalida)
        
	    END
		
		IF NOT EXISTS(SELECT Sucursal,          Empresa,  Articulo,  SubCuenta,  SerieLote,  Almacen, Tarima,         Propiedades,  Cliente,  Localizacion,  Existencia, ExistenciaAlterna, UltimaEntrada,  UltimaSalida
						FROM SerieLote 
					   WHERE SerieLote = @SerieLote AND Articulo = @Articulo AND SubCuenta = @SubCuenta 
						 AND Almacen = @Almacen AND Tarima = @AlmacenTarima AND Sucursal = @SucursalAlmacen AND Empresa = @Empresa)
			BEGIN
				INSERT SerieLote (Sucursal,          Empresa,  Articulo,  SubCuenta,  SerieLote,  Almacen, Tarima,         Propiedades,  Cliente,  Localizacion,  Existencia, ExistenciaAlterna, UltimaEntrada,  UltimaSalida)
				VALUES (@SucursalAlmacen, @Empresa, @Articulo, @SubCuenta, @SerieLote, @Almacen, @AlmacenTarima, @Propiedades, @Cliente, @Localizacion, @Cantidad,  @CantidadAlterna,  @UltimaEntrada, @UltimaSalida)			
			END

        IF @ArtTipo IN ('SERIE', 'VIN') AND @ArtSerieLoteInfo = 0
        BEGIN
          IF @AlmacenTipo = 'ACTIVOS FIJOS'
          BEGIN
            --IF (SELECT ISNULL(SUM(ExistenciaActivoFijo), 0) FROM SerieLote WHERE Empresa = @Empresa AND Articulo  = @Articulo AND SerieLote = @SerieLote) <> 1.0 
			
			IF (SELECT ISNULL(SUM(ExistenciaActivoFijo), 0) FROM SerieLote WHERE Empresa = @Empresa AND Articulo  = @Articulo AND SerieLote = @SerieLote) > 1 --CABSA ticket 139
			BEGIN
			  --SELECT 6
			   IF @Accion <> 'CANCELAR'  SELECT @Ok = 20080
			END
          END ELSE
          BEGIN
--JGD
            IF (SELECT ISNULL(SUM(Existencia), 0) FROM SerieLote WHERE Empresa = @Empresa AND Articulo = @Articulo AND SerieLote = @SerieLote) <> 1.0 AND (((SELECT NotasBorrador FROM EmpresaCFG WHERE Empresa = @Empresa) = 0) OR @MovTipo NOT IN ('VTAS.N','VTAS.NR','VTAS.NO'))
              SELECT @Ok = 20080
          END
        END

      END ELSE
      IF (@EsSalida = 1 OR @EsTransferencia = 1) AND @ArtSerieLoteInfo = 0 AND @Ok IS NULL
        --BUG3819
       IF @WMS=1
       BEGIN
         --IF @AlmacenTarima<>'' --BUG2983
          EXEC spSeriesLotesMayoreoDisminuir @Sucursal, @SucursalAlmacen, @SucursalAlmacenDestino, @Empresa, @Accion, @Almacen, @AlmacenDestino, @Articulo, @SubCuentaNull, @SubCuenta, @ArtTipo, @SerieLote, @Propiedades, @Cliente, @Localizacion, @Cantidad, @EsSalida, @EsTransferencia, @AlmacenTipo, @FechaEmision, @Ok OUTPUT, @AlmacenTarima = @AlmacenTarima, @AlmacenDestinoTarima = @AlmacenDestinoTarima, @MovTipo = @MovTipo         
       END
       ELSE
        EXEC spSeriesLotesMayoreoDisminuir @Sucursal, @SucursalAlmacen, @SucursalAlmacenDestino, @Empresa, @Accion, @Almacen, @AlmacenDestino, @Articulo, @SubCuentaNull, @SubCuenta, @ArtTipo, @SerieLote, @Propiedades, @Cliente, @Localizacion, @Cantidad, @EsSalida, @EsTransferencia, @AlmacenTipo, @FechaEmision, @Ok OUTPUT, @AlmacenTarima = @AlmacenTarima, @AlmacenDestinoTarima = @AlmacenDestinoTarima, @MovTipo = @MovTipo         
          
--JGD
      IF @Ok = 20090 AND (SELECT NotasBorrador FROM EmpresaCFG WHERE Empresa = @Empresa) = 1 AND @ArtTipo IN ('SERIE','LOTE')
        SELECT @Ok = NULL

      IF @Ok IS NULL 
        EXEC spSerieLoteFlujo @Sucursal, @SucursalAlmacen, @SucursalAlmacenDestino, @Accion, @Empresa, @Modulo, @ID, @Articulo, @SubCuenta, @SerieLote, @Almacen, @RenglonID, @Tarima = @AlmacenTarima
--JGD
/*
      IF (SELECT NotasBorrador FROM EmpresaCFG WHERE Empresa = @Empresa) = 1 AND @ArtTipo IN ('SERIE','LOTE') AND @EsSalida = 1
        UPDATE SerieLote 
           SET Existencia = -1*@Cantidad
         WHERE Articulo = @Articulo AND SerieLote = @SerieLote AND Empresa = @Empresa 
           AND ISNULL(RTRIM(SubCuenta), '') = ISNULL(RTRIM(@SubCuenta), '')
           AND Almacen = @Almacen
           AND ISNULL(RTRIM(Tarima),'') = ISNULL(RTRIM(@AlmacenTarima),'')
           AND ISNULL(Existencia, 0) = 0
*/

      -- Calcular Costeo por Lotes
      IF @CosteoLotes = 1 AND (@AfectarCostos = 1 OR @MovTipo = 'COMS.CC') AND @ArtSerieLoteInfo = 0 AND @Ok IS NULL
      BEGIN
        IF @MovTipo IN ('COMS.B', 'COMS.CA', 'COMS.GX')
          EXEC spBonificarCostoPromedio @ExistenciaAnterior, @Accion, @MovTipo, @Cantidad, @ArtCostoInvF, @CostoPromedio OUTPUT
        ELSE
        BEGIN
          IF @CfgValidarLotesCostoDif = 1 AND ROUND(@ArtCostoInvF, 2) <> ROUND(@CostoPromedio, 2)
            IF (@EsEntrada = 1 AND ROUND(@ExistenciaAnterior - @Cantidad, 4) > 0.0) OR (@EsSalida  = 1 AND ROUND(@ExistenciaAnterior + @Cantidad, 4) > 0.0)
              SELECT @Ok = 20710

          IF @Ok IS NULL
            EXEC spCalcCostoPromedio @ExistenciaAnterior, @EsEntrada, @Cantidad, @ArtCostoInvF, @CostoPromedio OUTPUT
        END

        IF (@EsEntrada = 1 AND @Accion <> 'CANCELAR') OR (@EsSalida = 1 AND @Accion = 'CANCELAR') OR @MovTipo IN ('COMS.B', 'COMS.CA', 'COMS.GX')
          UPDATE SerieLote
             SET CostoPromedio = @CostoPromedio
           WHERE Empresa   = @Empresa 
             AND Articulo  = @Articulo 
             AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'')
             AND SerieLote = @SerieLote
             AND Almacen   = @Almacen
             AND ISNULL(Tarima,'') = ISNULL(@AlmacenTarima,'')
             AND Sucursal  = @SucursalAlmacen
      END

      IF @ArtTipo = 'VIN' 
        IF @EsEntrada = 1
        BEGIN
          UPDATE VIN 
             SET Costo = @ArtCostoF, CostoConGastos = @ArtCostoInvF
           WHERE VIN = @SerieLote

          IF @CfgVINAccesorioArt = 1 AND @CfgVINCostoSumaAccesorios = 1
            IF ABS(@CostoPromedio - (SELECT ROUND(SUM(PrecioDistribuidor), 0) FROM VINAccesorio WHERE VIN = @SerieLote AND Estatus = 'ALTA')) > 1.0
              SELECT @Ok = 20335, @OkRef = @SerieLote
        END ELSE
        IF @MovTipo IN ('VTAS.F', 'VTAS.FAR', 'VTAS.FC')
          UPDATE VIN 
             SET FechaFactura = @FechaEmision
           WHERE VIN = @SerieLote AND FechaFactura IS NULL

      IF @Ok IS NOT NULL 
        SELECT @OkRef = 'Articulo: '+RTRIM(@Articulo) + ' ' + @SubCuentaNull + ' ('+RTRIM(@SerieLote)+')'

      IF @CosteoLotes = 1 AND @ArtLotesFijos = 1 
      BEGIN
        IF @Temp = 1
          UPDATE #SerieLoteMov SET ArtCostoInv = @ArtCostoInvF * @Factor WHERE CURRENT OF crSerieLoteMov
        ELSE
          UPDATE SerieLoteMov SET ArtCostoInv = @ArtCostoInvF * @Factor WHERE CURRENT OF crSerieLoteMov
      END
	-- ETO Tarjetas 9-Feb-2007
--REQ 13386  
      IF @LDI = 1 OR @OrigenTipo = 'POS'
      BEGIN
        IF @OrigenTipo ='POS' and @Articulo = @ArticuloTarjetasDef 
          EXEC spValeSerieTarjeta @Empresa, @ID, @RenglonID, @MovTipo, @Accion, @Almacen, @AlmacenTipo, @Articulo, @ArtTipo, @SerieLote, @EsEntrada, @EsSalida, @FechaEmision, @Ok OUTPUT, @OkRef OUTPUT
        
        IF NULLIF(@OrigenTipo,'') IS NULL AND @Modulo = 'VTAS' AND Exists(SELECT * FROM ValeSerie WHERE Serie = @SerieLote AND Articulo = @Articulo)AND (@LDIArticulo = 0 OR (@LDIArticulo = 1 AND @MovTipo NOT IN('VTAS.N')))
          EXEC spValeSerieTarjeta @Empresa, @ID, @RenglonID, @MovTipo, @Accion, @Almacen, @AlmacenTipo, @Articulo, @ArtTipo, @SerieLote, @EsEntrada, @EsSalida, @FechaEmision, @Ok OUTPUT, @OkRef OUTPUT
      END
      ELSE   
        IF @Modulo = 'VTAS' AND Exists(SELECT * FROM ValeSerie WHERE Serie = @SerieLote AND Articulo = @Articulo)
          EXEC spValeSerieTarjeta @Empresa, @ID, @RenglonID, @MovTipo, @Accion, @Almacen, @AlmacenTipo, @Articulo, @ArtTipo, @SerieLote, @EsEntrada, @EsSalida, @FechaEmision, @Ok OUTPUT, @OkRef OUTPUT
            

      IF @Ok IS NULL --MEJORASLC
        EXEC spSerieLoteConsignacion @Empresa, @Articulo, @SubCuenta, @SerieLote, @Modulo, @ID, @Accion, @Cantidad, @EsEntrada, @EsSalida, @Ok OUTPUT, @OkRef OUTPUT  
    END 
   
    FETCH NEXT FROM crSerieLoteMov INTO @SerieLote, @Cantidad, @CantidadAlterna, @Propiedades, @Cliente, @Localizacion, @ArtCostoInvF
    IF @@ERROR <> 0 SELECT @Ok = 1
  END
  CLOSE crSerieLoteMov
  DEALLOCATE crSerieLoteMov
  
  -- Promediar Factor Alterno
/*  IF @ArtTipo = 'PARTIDA' AND @SumaCantidad > 0.0 AND @SumaCantidadAlterna > 0 AND @EsEntrada = 1 AND @Ok IS NULL
  BEGIN
    SELECT @Existencia = 0.0
    SELECT @Existencia = ISNULL(SUM(SaldoU), 0.0) FROM SaldoU WHERE Empresa=@Empresa AND Rama='INV' AND Cuenta=@Articulo
    SELECT @Existencia = @Existencia - @SumaCantidad
  END*/

  RETURN
END
GO
--BEGIN TRANSACTION
--DECLARE @Ok int, @OkRef varchar(255)
--EXEC spAfectar 'COMS', 1325, 'AFECTAR', 'Todo', null, 'INTELISIS', @SincroFinal=0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
--IF @@TRANCOUNT>0
--ROLLBACK