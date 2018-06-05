SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET NOCOUNT ON
GO

/* SP Planograma */
IF EXISTS (select * from sysobjects where id = object_id('dbo.vic_spColorPlano') and type = 'P') drop procedure dbo.vic_spColorPlano
GO
CREATE PROCEDURE vic_spColorPlano
    @Plano                          varchar(15), 
    @Accion                         varchar(50),
    @Valor                          varchar(200),   
    @TD                             char(1), --F (fecha), D (decimal), E (entero), T (texto)
    @Prom                           varchar(50) = null,
    @Color1                         int OUTPUT,
    @Leyenda1                       varchar(200) OUTPUT

--//WITH ENCRYPTION             
AS BEGIN
    DECLARE 
        @Orden                      int,
        @Color                      int,
        @Leyenda                    varchar(200),       
        @Expresion                  varchar(1000),
        @Bandera                    bit,
        @query                      varchar(max),
        @FechaValor                 datetime,
        @FechaProm                  datetime,
        @FechaV                     varchar(15),
        @FechaP                     varchar(15),
        @Plano_Temp                 varchar(15),
        @Nombre_Temp                varchar(50),
        @AplicaProm                 bit
    
    
    CREATE TABLE #ColorTemp (
        Color                       int, 
        Leyenda                     varchar(200)
    )
    SELECT @TD = UPPER(@TD)
    
    DECLARE crEvaluaExpresion CURSOR LOCAL STATIC
    FOR
        SELECT pad.Orden,
               pad.Color,
               pad.LeyendaColor,
               Expresion = UPPER(pad.Expresion)
          FROM vic_PlanoAcciones pa
               JOIN vic_PlanoAccionesDef pad ON pa.Plano = pa.Plano
                    AND pa.Nombre = pad.Nombre
         WHERE pa.Plano = @Plano
               AND pa.Plano = pad.Plano
               AND pa.Nombre = @Accion ORDER BY Orden   
    OPEN crEvaluaExpresion
    FETCH NEXT FROM crEvaluaExpresion INTO @Orden, @Color, @Leyenda, @Expresion
    WHILE @@FETCH_STATUS <> -1
    BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
        SELECT @Prom =ISNULL(@Prom,'')
            IF @TD = 'E' OR @TD = 'D'
            BEGIN
        
                BEGIN TRY
                  -- SELECT ' AQUI ANDO', @EXPRESION,@Valor ,@Prom 
                    SELECT @Expresion = REPLACE(@Expresion, 'VALOR', @Valor)
                    SELECT @Expresion = REPLACE(@Expresion, 'PROM', @Prom)
                   -- SELECT @Expresion 
                    SELECT @query = 'BEGIN TRY IF('+ISNULL(@Expresion,'')+')   ' +
                                    'INSERT INTO #ColorTemp (Color, Leyenda) VALUES ('+convert(varchar,@Color)+','+''''+ISNULL(@Leyenda,'')+''') END TRY BEGIN CATCH END CATCH'
                    --   select @query, 'AQUI ANDO'
                    EXEC(@query)
                 
                END TRY
                BEGIN CATCH
                END CATCH
            END
            
            IF @TD = 'F' 
            BEGIN
                BEGIN TRY
                    SELECT @FechaValor = convert(datetime, @Valor)
                    IF ISNULL(@Prom,'') <> ''  SELECT @FechaProm = convert(datetime, @Prom)
                    
                    SELECT @FechaV = CONVERT(VARCHAR, @FechaValor, 103)
                    SELECT @FechaP = CONVERT(VARCHAR, @FechaProm, 103)
                    
                    SELECT @Expresion = REPLACE(@Expresion, 'VALOR', ''''+@FechaV+'''')
                    SELECT @Expresion = REPLACE(@Expresion, 'PROM', ''''+@FechaP+'''')
                    
                    SELECT @query = 'BEGIN TRY IF('+ISNULL(@Expresion,'')+')   ' +
                                    'INSERT INTO #ColorTemp (Color, Leyenda) VALUES ('+convert(varchar,@Color)+','+''''+ISNULL(@Leyenda,'')+''') END TRY BEGIN CATCH END CATCH'
                    EXEC(@query)
                    
                END TRY
                BEGIN CATCH
                END CATCH
            END
            
            IF @TD = 'T' 
            BEGIN
                BEGIN TRY
                    SELECT @Expresion = REPLACE(@Expresion, 'VALOR', ''''+UPPER(@Valor)+'''')
                    IF @Prom IS NOT NULL SELECT @Expresion = REPLACE(@Expresion, 'PROM', ''''+@Prom+'''')
                    
                    SELECT @query = 'BEGIN TRY  IF('+ISNULL(@Expresion,'')+')   ' +
                                    'INSERT INTO #ColorTemp (Color, Leyenda) VALUES ('+convert(varchar,@Color)+','+''''+ISNULL(@Leyenda,'')+''') END TRY BEGIN CATCH END CATCH'
                    EXEC(@query)
                    
                END TRY
                BEGIN CATCH
                END CATCH
            END
        END
        FETCH NEXT FROM crEvaluaExpresion INTO @Orden, @Color, @Leyenda, @Expresion
    END
    CLOSE crEvaluaExpresion
    DEALLOCATE crEvaluaExpresion
    
    SET @Color1 = (SELECT Top 1 Color FROM #ColorTemp)
    SET @Leyenda1 = (SELECT Top 1 Leyenda FROM #ColorTemp)
    RETURN
END
GO

/* vic_spActualizaColorTemp  Actualiza el Color de los Planogramas */
IF EXISTS (select * from sysobjects where id = object_id('dbo.vic_spActualizaColorTemp') and type = 'P') drop procedure dbo.vic_spActualizaColorTemp
GO
CREATE PROCEDURE vic_spActualizaColorTemp
--//WITH ENCRYPTION
AS BEGIN
    DECLARE 
        @Estacion                   int,
        @Plano                      varchar(15),
        @Accion                     varchar(50),
        @AplicaProm                 bit,
        @Promedio                   varchar(12),
        @Valor                      varchar(200),
        @Color                      int,
        @Leyenda                    varchar(200),
        @TD                         varchar(1),
        @Elemento                   varchar(200),
    @xyz int
    SELECT * INTO #Plano FROM vic_planotemp

    DECLARE crEvaluaTemp CURSOR LOCAL STATIC
    FOR
        SELECT DISTINCT estacion, plano, nombre
          FROM #Plano
    OPEN crEvaluaTemp
    FETCH NEXT FROM crEvaluaTemp INTO @Estacion, @Plano, @Accion
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
    
        IF @@FETCH_STATUS <> -2 
        BEGIN
            SELECT @AplicaProm = ISNULL(AplicaProm, 0)
              FROM vic_planoacciones
             WHERE Plano = @Plano AND Nombre = @Accion
            
            IF ISNULL(@AplicaProm,0) = 1
            BEGIN
                BEGIN TRY
                    SELECT @Promedio = CONVERT(varchar, ROUND(AVG(convert(float,ISNULL(Valor_color,0))),2))
                      FROM #Plano
                     WHERE Estacion = @Estacion AND Plano = @Plano AND Nombre = @Accion
                END TRY
                BEGIN CATCH
                    SET @Promedio=NULL 
                END CATCH
            END
            
            IF ISNULL(@AplicaProm,0) = 1 AND @Promedio IS NULL
            BEGIN
                BEGIN TRY
                    IF ISNULL(@AplicaProm,0) = 1
                    SELECT @Promedio = CONVERT(varchar, AVG(convert(money,ISNULL(Valor_color,0))))
                      FROM #Plano
                     WHERE Estacion = @Estacion AND Plano = @Plano AND Nombre = @Accion
                END TRY
                BEGIN CATCH
                    SET @Promedio='0'
                END CATCH
            END
            
            DECLARE crEvaluaExpresion CURSOR LOCAL STATIC
            FOR
            
                SELECT Elemento, Valor_color
                  FROM #Plano
                 WHERE Estacion = @Estacion
                       AND Plano = @Plano
                       AND Nombre = @Accion

            OPEN crEvaluaExpresion
            FETCH NEXT FROM crEvaluaExpresion INTO @Elemento, @Valor
            WHILE @@FETCH_STATUS <> -1
            BEGIN
              
                IF @@FETCH_STATUS <> -2 
                BEGIN
            
                    --select @xyz =  dbo.fnEsIntegro (@valor)
                    IF ISNULL(@AplicaProm,0) = 1
                    BEGIN
                        BEGIN TRY
                            SELECT @Valor = CONVERT(VARCHAR, CONVERT(FLOAT, ISNULL(@Valor,0)))
                        END TRY
                        BEGIN CATCH
                            SELECT @Valor = REPLACE(@Valor,'.', '')
                            SELECT @Valor = REPLACE(@Valor,',', '.')
                        END CATCH
                            SET @TD='D' 
                    END 
                    ELSE IF @Valor like '%'+convert(varchar, year(getdate()))+'%'
                        SELECT @TD='F', @Promedio=''
                   
                  ELSE IF dbo.fnEsIntegro (@valor) = 1 SET @TD = 'E' ELSE SET @TD='T'
                    
                    --ELSE SET @TD='T'
                                   
            -- select @TD , @Valor ,@accion
                    EXEC vic_spColorPlano @Plano, @Accion, @Valor, @TD, @Promedio, @Color OUTPUT, @Leyenda OUTPUT
                    
                    IF @Color IS NULL AND @Leyenda IS NOT NULL
                        UPDATE #Plano
                           SET Descripcion = @Leyenda,
                               Color = 255,
                               Valor_color = @Valor
                        WHERE Plano = @Plano
                              AND Elemento = @Elemento
                              AND Nombre=@Accion  
                    ELSE IF @Leyenda IS NULL AND @Color IS NOT NULL
                        UPDATE #Plano
                           SET Descripcion = 'Vacio',
                               Color = @Color,
                               Valor_color=@Valor
                         WHERE Plano = @Plano
                               AND Elemento = @Elemento
                               AND Nombre=@Accion  
                    ELSE IF @Leyenda IS NULL AND @Color IS NULL                                      
                        UPDATE #Plano
                           SET Descripcion = 'Vacio',
                               Color = 255,
                               Valor_color = @Valor
                         WHERE Plano = @Plano
                               AND Elemento = @Elemento
                               AND Nombre=@Accion
                    ELSE                 
                        UPDATE #Plano
                           SET Descripcion = @Leyenda,
                               Color = @Color,
                               Valor_color=@Valor
                         WHERE Plano = @Plano
                               AND Elemento = @Elemento
                               AND Nombre=@Accion
                END
                FETCH NEXT FROM crEvaluaExpresion INTO @Elemento, @Valor
            END
            CLOSE crEvaluaExpresion
            DEALLOCATE crEvaluaExpresion        
        END
        FETCH NEXT FROM crEvaluaTemp INTO  @Estacion, @Plano, @Accion
    END
    CLOSE crEvaluaTemp
    DEALLOCATE crEvaluaTemp
    --select * from #Plano
    update p
       set p.Descripcion    = t.Descripcion,
           p.Color          = t.Color,
           p.Valor_color    = t.Valor_color
      from vic_planotemp p
           join #Plano t ON p.plano = t.Plano AND p.elemento = t.elemento AND p.Nombre = t.Nombre 
    
    RETURN
END
GO

/* vic_spEliminaPlano */
IF EXISTS (select * from sysobjects where id = object_id('dbo.vic_spEliminaPlano') and type = 'P') drop procedure dbo.vic_spEliminaPlano
GO
CREATE PROCEDURE vic_spEliminaPlano
				 @Plano varchar(50)
--//WITH ENCRYPTION
AS BEGIN
    DELETE FROM vic_plano_asignacion WHERE Plano = @Plano           
    DELETE FROM vic_Plano WHERE Plano = @Plano          
RETURN
END
GO

/* vic_spEliminaAccionPlano */
IF EXISTS (select * from sysobjects where id = object_id('dbo.vic_spEliminaAccionPlano') and type = 'P') drop procedure dbo.vic_spEliminaAccionPlano
GO
CREATE PROCEDURE vic_spEliminaAccionPlano
				 @Plano    varchar(15),
				 @Renglon  float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE       
   @Nombre      varchar(15)

  SELECT @Nombre = Nombre FROM vic_PlanoAcciones WHERE Plano = @Plano AND Renglon = @Renglon

  DELETE FROM vic_planoacciones WHERE Plano = @Plano AND Renglon = @Renglon
  DELETE FROM vic_PlanoAccionesDef WHERE Plano = @Plano AND Nombre = @Nombre
RETURN
END
GO

/* vic_spCopiaAccionesPlano */
IF EXISTS (select * from sysobjects where id = object_id('dbo.vic_spCopiaAccionesPlano') and type = 'P') drop procedure dbo.vic_spCopiaAccionesPlano
GO
CREATE PROCEDURE vic_spCopiaAccionesPlano
				 @Plano            varchar(15),
				 @Estacion         int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE  @Nombre          varchar(50),
		   @Estatus         varchar(15), 
		   @AplicaProm      bit, 
		   @QueryColor      varchar(2000), 
		   @Query           varchar(2000),
		   @Orden           int,
		   @Color           int,
		   @LeyendaColor    varchar(20),
		   @Expresion       varchar(1000),
		   @ClavePlano      varchar(15),
		   @Renglon         float,
		   @Ok              int,
		   @OkRef           varchar(255)

   CREATE TABLE #vic_PlanoAccionesTemp (
										 Plano           varchar(15)     NULL,
										 Nombre          varchar(50)     NULL,
										 Estatus         varchar(15)     NULL,
										 AplicaProm      bit             NULL,
										 QueryColor      varchar(2000)   NULL,
										 Query           varchar(2000)   NULL
									   )

   CREATE TABLE #vic_PlanoAccionesDefTemp (
											Plano           varchar(15)     NULL,
											Nombre          varchar(50)     NULL,
											Orden           int             NULL,
											Color           int             NULL,
											LeyendaColor    varchar(20)     NULL,
											Expresion       varchar(1000)   NULL 
										  )
            
BEGIN TRAN
  IF NOT EXISTS (SELECT 1 FROM vic_PlanoAcciones WHERE Plano = @Plano) SET @Ok = 73040

  IF @Ok IS NULL 
  BEGIN
  DECLARE crAcciones CURSOR LOCAL STATIC FOR
   SELECT Nombre, Estatus, AplicaProm, QueryColor, Query from vic_PlanoAcciones where Plano=@Plano
  OPEN crAcciones
  FETCH NEXT FROM crAcciones INTO @Nombre, @Estatus, @AplicaProm, @QueryColor, @Query
   WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
     IF @@FETCH_STATUS <> -2 
      BEGIN
       INSERT INTO #vic_PlanoAccionesTemp(Plano, Nombre, Estatus, AplicaProm, QueryColor, Query)
                                 VALUES (@Plano, @Nombre, @Estatus, @AplicaProm, @QueryColor, @Query)
       IF @@ERROR <> 0 SET @Ok = 1
      END
     FETCH NEXT FROM crAcciones INTO @Nombre, @Estatus, @AplicaProm, @QueryColor, @Query
    END
  CLOSE crAcciones
  DEALLOCATE crAcciones
            
  IF @Ok IS NULL BEGIN  
   DECLARE crAccionesDef CURSOR LOCAL STATIC FOR
    SELECT Nombre, Orden, Color, LeyendaColor, Expresion from vic_PlanoAccionesDef where Plano=@Plano
   OPEN crAccionesDef
   FETCH NEXT FROM crAccionesDef INTO @Nombre, @Orden, @Color, @LeyendaColor, @Expresion
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
     BEGIN
     IF @@FETCH_STATUS <> -2 
      BEGIN
       INSERT INTO #vic_PlanoAccionesDefTemp(Plano, Nombre, Orden, Color, LeyendaColor, Expresion)
                                     VALUES (@Plano, @Nombre, @Orden, @Color, @LeyendaColor, @Expresion)
       IF @@ERROR <> 0 SET  @Ok = 1 
      END
     FETCH NEXT FROM crAccionesDef INTO @Nombre, @Orden, @Color, @LeyendaColor, @Expresion
    END
   CLOSE crAccionesDef
   DEALLOCATE crAccionesDef
  END

  IF @Ok IS NULL BEGIN
   DECLARE crCopiaAcciones CURSOR LOCAL STATIC FOR
    SELECT Clave from ListaST where Estacion=@Estacion
   OPEN crCopiaAcciones
   FETCH NEXT FROM crCopiaAcciones INTO @ClavePlano
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
     BEGIN
      IF @@FETCH_STATUS <> -2 
       BEGIN
        IF ISNULL(@ClavePlano,'') <> '' AND EXISTS (SELECT 1 FROM vic_Plano WHERE Plano=@ClavePlano) AND @Ok IS NULL
         BEGIN
          SET @Renglon = 2048
          DELETE FROM vic_PlanoAcciones WHERE Plano = @ClavePlano
          DELETE FROM vic_PlanoAccionesDef WHERE Plano = @ClavePlano
          IF @@ERROR <> 0 SET @Ok = 1

          DECLARE crAcciones2 CURSOR LOCAL STATIC FOR
           SELECT Nombre, Estatus, AplicaProm, QueryColor, Query from #vic_PlanoAccionesTemp
          OPEN crAcciones2
          FETCH NEXT FROM crAcciones2 INTO @Nombre, @Estatus, @AplicaProm, @QueryColor, @Query
          WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
           BEGIN
            IF @@FETCH_STATUS <> -2 
             BEGIN
              INSERT INTO vic_PlanoAcciones(Plano, Renglon, RenglonSub, Nombre, Estatus, AplicaProm, QueryColor, Query)
                                    VALUES (@ClavePlano, @Renglon, 0, @Nombre, @Estatus, @AplicaProm, @QueryColor, @Query)
              IF @@ERROR <> 0 SET @Ok = 1
              SELECT @Renglon = @Renglon + 2048

              IF @Ok IS NULL
               INSERT INTO vic_PlanoAccionesDef(Plano, Nombre, RenglonSub, Orden, Color, LeyendaColor, Expresion)
                                   SELECT @ClavePlano, Nombre, 0, Orden, Color, LeyendaColor, Expresion from #vic_PlanoAccionesDefTemp WHERE Nombre=@Nombre 

               IF @@ERROR <> 0 SET @Ok = 1
            END
           FETCH NEXT FROM crAcciones2 INTO @Nombre, @Estatus, @AplicaProm, @QueryColor, @Query
          END
         CLOSE crAcciones2
         DEALLOCATE crAcciones2
        END
       END
      FETCH NEXT FROM crCopiaAcciones INTO @ClavePlano
     END
    CLOSE crCopiaAcciones
    DEALLOCATE crCopiaAcciones
    END
   END  

    IF @Ok IS NULL BEGIN
     COMMIT TRAN
     SELECT 'Proceso concluido'
     RETURN
    END
    ELSE BEGIN
     ROLLBACK TRAN 
     SELECT CONVERT(varchar,@Ok) + '. ' + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) + '. ' + ISNULL(@OkRef,'')
     RETURN
    END         
RETURN
END
GO

/* vic_spInsertaDatosPlano */
IF EXISTS (select * from sysobjects where id = object_id('dbo.vic_spInsertaDatosPlano') and type = 'P') drop procedure dbo.vic_spInsertaDatosPlano
GO
CREATE PROCEDURE vic_spInsertaDatosPlano
				 @Ok    int          OUTPUT, 
				 @OkRef varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Plano       varchar(15),
		  @Renglon     float,
          @Nombre      varchar(50),
          @cuantos     integer
      
   SELECT @cuantos = COUNT(*) FROM vic_Plano 

  IF @cuantos = 1 
  BEGIN
   DELETE FROM vic_planoacciones
   IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = 'Error al eliminar acciones de plano'
   
   IF @Ok IS NULL
    DELETE FROM vic_planoaccionesdef
   IF @@ERROR <> 0 SELECT @Ok = 1,  @OkRef = 'Error al eliminar detalle de acciones de plano'
   SET @Renglon = 0

   IF @Ok IS NULL BEGIN
   DECLARE crAcciones CURSOR LOCAL STATIC FOR
    SELECT Plano FROM vic_Plano
   OPEN crAcciones
   FETCH NEXT FROM crAcciones INTO @Plano
   WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL 
    BEGIN
     IF @@FETCH_STATUS <> -2 
      BEGIN
		IF NOT EXISTS (SELECT * FROM vic_planoacciones WHERE Plano = @Plano AND Nombre = 'Estatus')
			INSERT INTO vic_planoacciones (Plano, Renglon, RenglonSub, Nombre, Estatus, AplicaProm, QueryColor, Query)
								   VALUES (@Plano, @Renglon, 0, 'Estatus', 'ACTIVA',  0, '', "SELECT DISTINCT vl.Estatus, VL.local FROM vic_Local vl JOIN vic_plano_asignacion VP ON vl.Local = VP.Elemento WHERE VP.Plano = ")	
								                                                              
  
        IF @@ERROR <> 0 SET @Ok = 1
       END
      FETCH NEXT FROM crAcciones INTO @Plano
     END
    CLOSE crAcciones
    DEALLOCATE crAcciones
  END 

  IF @Ok IS NULL BEGIN
  DECLARE crAcciones CURSOR LOCAL STATIC FOR
   SELECT Plano, Nombre FROM vic_PlanoAcciones
  OPEN crAcciones
  FETCH NEXT FROM crAcciones INTO @Plano, @Nombre
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
   BEGIN
    IF @@FETCH_STATUS <> -2 
     BEGIN
      IF @Nombre='Estatus' AND @Ok IS NULL
       BEGIN
	    IF NOT EXISTS (SELECT * FROM vic_PlanoAccionesDef WHERE Plano = @Plano AND Nombre = @Nombre)
			INSERT INTO vic_PlanoAccionesDef (Plano, Nombre, RenglonSub, Orden, Color, LeyendaColor, Expresion) VALUES (@Plano, @Nombre, 0, 1, 15859453, 'Alta', 'VALOR =''Alta''')
        IF @@ERROR <> 0 SET @Ok = 1
        IF @Ok IS NULL
		 IF NOT EXISTS (SELECT * FROM vic_PlanoAccionesDef WHERE Plano = @Plano AND Nombre = @Nombre)
			INSERT INTO vic_PlanoAccionesDef (Plano, Nombre, RenglonSub, Orden, Color, LeyendaColor, Expresion) VALUES (@Plano, @Nombre, 0, 1, 16709867, 'Baja', 'VALOR =''Baja''')
       END	 
      END
     FETCH NEXT FROM crAcciones INTO @Plano, @Nombre
    END
  CLOSE crAcciones
  DEALLOCATE crAcciones
  END
END
RETURN
END
GO

/* Se crea un Tipo Plano WMS */
IF NOT EXISTS (SELECT * FROM VIC_TIPOPLANO)
	INSERT INTO vic_TipoPlano(TipoPlano, Icono, FiltroLista,					  TotalCamposFiltroLista, C1A, C1TD,	C1E,	 C2A, C2TD,	   C2E, 
							  FiltroElemento,																																								TotalCamposFiltroElemento, CFE1A, CFE1TD,  CFE1E,	   CFE2A, CFE2TD,  CFE2E,			  CFE3A, CFE3TD,  CFE3E,			  CFE4A, CFE4TD,  CFE4E, 
							  FiltroElementoEspecial,																																						TotalCamposFEE,			   CFEE1A, CFEE1TD, CFEE1E,     CFEE2A)
					  VALUES ('WMS',     NULL, 'SELECT Almacen, Nombre FROM Alm', 2,					  'I', 'Texto', 'Clave', 'I', 'Texto', 'Nombre', 
							  'SELECT local, nombre, estatus, tipo FROM vic_local WHERE not exists (select 1 from vic_plano_asignacion  where vic_plano_asignacion.elemento = vic_local.local) and Lote =', 4,						   'I',   'Texto', 'Posicion', 'I',   'Texto', 'Nombre Articulo', 'I',   'Texto', 'Estatus Posicion', 'I',   'Texto', 'Tipo Articulo',
							  'SELECT local FROM vic_local WHERE not exists (select 1 from vic_plano_asignacion  where vic_plano_asignacion.elemento = vic_local.local) and Lote =',						1,						   'I',    'Texto', 'Posicion', 'I')
GO

/* Se inserta la acción de Estatus */
DECLARE @Ok int,
		@OkRef varchar(255)

IF NOT EXISTS (SELECT * FROM vic_planoacciones) AND NOT EXISTS (SELECT * FROM vic_PlanoAccionesDef)
	EXEC vic_spInsertaDatosPlano @Ok OUTPUT, @OkRef OUTPUT
GO