/************** spMAFInsertarActivoFTipoIndicador ***************/
if exists (select * from sysobjects where id = object_id('dbo.spMAFInsertarActivoFTipoIndicador') and sysstat & 0xf = 4) drop procedure dbo.spMAFInsertarActivoFTipoIndicador
GO
CREATE PROCEDURE spMAFInsertarActivoFTipoIndicador
			@Empresa		varchar(5),
			@ID			int,
			@Articulo		varchar(20),
			@Serie			varchar(50),
			@Ok			int = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	@Tipo		varchar(50)
  	  
  DELETE FROM GestionActivoFIndicador WHERE ID = @ID
  IF @@ERROR <> 0 SET @Ok = 1
  
  IF @Ok IS NULL
  BEGIN  	  
    SELECT @Tipo = Tipo FROM ActivoF WHERE Articulo = @Articulo AND Serie = @Serie
    	
    INSERT GestionActivoFIndicador (ID,  Tipo,  Indicador,     Referencia,     LecturaAnterior)
                            SELECT @ID,  @Tipo, afi.Indicador, afi.Referencia, afi.Lectura 
                              FROM ActivoFIndicador afi JOIN ActivoF af
                                ON afi.ActivoFID = af.ID
                             WHERE af.Articulo = @Articulo 
                               AND af.Serie = @Serie
                               AND af.Empresa = @Empresa	
    IF @@ERROR <> 0 SET @Ok = 1                             
  END                           

END
GO

/************** spMAFPermiteEliminarActivoFTipoIndicador ***************/
if exists (select * from sysobjects where id = object_id('dbo.spMAFPermiteEliminarActivoFTipoIndicador') and sysstat & 0xf = 4) drop procedure dbo.spMAFPermiteEliminarActivoFTipoIndicador
GO
CREATE PROCEDURE spMAFPermiteEliminarActivoFTipoIndicador
			@Tipo			varchar(50),
			@ActivoFID		int,
			@Indicador		varchar(50),
			@DependeDe		varchar(20),
			@Modo			varchar(20)
--//WITH ENCRYPTION	
AS BEGIN
  DECLARE	@AFArticulo		varchar(20),
		@AFSerie		varchar(50)	
	
  IF @DependeDe = 'ActivoFTipo'	
  BEGIN  	
    IF @Modo = 'Preguntar' IF NOT EXISTS(SELECT * FROM GestionActivoFIndicador WHERE RTRIM(Tipo) = RTRIM(@Tipo) AND RTRIM(Indicador) = RTRIM(@Indicador)) AND NOT EXISTS(SELECT * FROM ActivoFIndicador afi JOIN ACTIVOF af ON afi.ActivoFID = af.ID WHERE af.Tipo = @Tipo AND afi.Indicador = @Indicador) SELECT 1 ELSE SELECT 0 ELSE  
    IF @Modo = 'Eliminar'  IF NOT EXISTS(SELECT * FROM GestionActivoFIndicador WHERE RTRIM(Tipo) = RTRIM(@Tipo) AND RTRIM(Indicador) = RTRIM(@Indicador)) AND NOT EXISTS(SELECT * FROM ActivoFIndicador afi JOIN ACTIVOF af ON afi.ActivoFID = af.ID WHERE af.Tipo = @Tipo AND afi.Indicador = @Indicador) DELETE FROM ActivoFTipoIndicador WHERE Tipo = @Tipo AND Indicador = @Indicador
  END
  ELSE 
  IF @DependeDe = 'ActivoF'
  BEGIN
    SELECT @AFArticulo = Articulo, @AFSerie = Serie FROM ActivoF WHERE ID = @ActivoFID    
    IF @Modo = 'Preguntar' IF NOT EXISTS(SELECT * FROM GestionActivoFIndicador gaf JOIN Gestion g ON gaf.ID = g.ID WHERE gaf.Indicador = @Indicador AND g.AFArticulo = @AFArticulo AND g.AFSerie = @AFSerie) SELECT 1 ELSE SELECT 0 ELSE  
    IF @Modo = 'Eliminar'  IF NOT EXISTS(SELECT * FROM GestionActivoFIndicador gaf JOIN Gestion g ON gaf.ID = g.ID WHERE gaf.Indicador = @Indicador AND g.AFArticulo = @AFArticulo AND g.AFSerie = @AFSerie) DELETE FROM ActivoFIndicador WHERE ActivoFID = @ActivoFID AND Indicador = @Indicador
  END
END
GO

/************** spMAFGenerarSolicitudInspeccion ***************/
if exists (select * from sysobjects where id = object_id('dbo.spMAFGenerarSolicitudInspeccion') and sysstat & 0xf = 4) drop procedure dbo.spMAFGenerarSolicitudInspeccion
GO
CREATE PROCEDURE spMAFGenerarSolicitudInspeccion
			@Empresa		varchar(5),
			@Sucursal		int,
			@Accion			varchar(20),
			@AFArticulo		varchar(20),
			@AFSerie		varchar(50),
			@Usuario		varchar(10),
			@Para			varchar(10),		
			@FechaVencimiento	datetime,
			@IDOrigen		int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT		
--//WITH ENCRYPTION			
AS BEGIN
  DECLARE	@MAFSolicitudInspeccion		varchar(20),
		@FechaEmision			datetime,
		@IDGenerar			int,
		@MovIDGenerar			varchar(20),
		@Origen				varchar(20),		
		@OrigenID			varchar(20),
		@OrigenTipo			varchar(10)
		
		
		
  IF @Accion = 'AFECTAR' AND NOT EXISTS(SELECT * FROM Gestion g JOIN MovTipo mt ON g.Mov = mt.Mov WHERE Clave = 'GES.SRES' AND SubClave = 'MAF.SI' AND g.Estatus = 'PENDIENTE' AND g.AFArticulo = @AFArticulo AND g.AFSerie = @AFSerie)
  BEGIN  
    SET @FechaEmision = dbo.fnFechaSinHora(GETDATE())
    
    IF @Para IS NULL  
      SELECT @Para = MAFInspeccionUsuario FROM Empresacfg2    	  	

    --IF @IDOrigen IS NOT NULL SET @OrigenTipo = 'MAF/AF' ELSE SET @OrigenTipo = NULL
    
    	
    IF @Para IS NULL SELECT @Ok = 71010, @OkRef = 'Defina el Usuario Inspección en la configuración de Mantenimiento Activo Fijo de la empresa.'
  
    IF @Ok IS NULL
    BEGIN
      SELECT @MAFSolicitudInspeccion = MAFSolicitudInspeccion FROM EmpresaCfgMov WHERE Empresa = @Empresa
      IF NULLIF(@MAFSolicitudInspeccion,'') IS NULL SELECT @Ok = 14055, @OkRef = 'Defina el movimiento Solicitud Inspeccion en Movimientos por omisión.'
    END  

    IF @Ok IS NULL
    BEGIN
      INSERT Gestion (Empresa,  Mov,                     FechaEmision,  Usuario,  Estatus,      Sucursal,  FechaA,            Prioridad, AFArticulo,  AFSerie)
              VALUES (@Empresa, @MAFSolicitudInspeccion, @FechaEmision, @Usuario, 'SINAFECTAR', @Sucursal, @FechaVencimiento, 'Normal',  @AFArticulo, @AFSerie)
      SET @IDGenerar = SCOPE_IDENTITY()    	  	
      IF @@ERROR <> 0 SET @Ok = 1
    END  
  
    IF @Ok IS NULL
    BEGIN
      INSERT GestionPara (ID,         Usuario, Participacion)
                  VALUES (@IDGenerar, @Para,   'Requerido')  	
      IF @@ERROR <> 0 SET @Ok = 1            
    END
  
    IF @Ok IS NULL
    BEGIN
      EXEC spMAFInsertarActivoFTipoIndicador @Empresa, @IDGenerar, @AFArticulo, @AFSerie, @Ok OUTPUT, @OkRef OUTPUT
    END

    IF @Ok IS NULL
      EXEC spAfectar 'GES', @IDGenerar, @Accion, 'Todo', NULL, @Usuario, @@SPID, @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT 

    IF @Ok IS NULL AND @IDOrigen IS NOT NULL
    BEGIN
      SELECT @Origen = Mov, @OrigenID = MovID FROM Venta WHERE ID = @IDOrigen	
      SELECT @MovIDGenerar = MovID FROM Gestion WHERE ID = @IDGenerar
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'VTAS', @IDOrigen, @Origen, @OrigenID, 'GES', @IDGenerar, @MAFSolicitudInspeccion, @MovIDGenerar, @Ok OUTPUT
    END          
  END
  ELSE
  BEGIN
    IF @Accion = 'CANCELAR'
    BEGIN	
      SELECT 
        @Origen = OMov,
        @OrigenID = OMovID,
        @MAFSolicitudInspeccion = DMov,
        @MovIDGenerar = DMovID,
        @IDGenerar = DID
        FROM MovFlujo 
       WHERE OModulo = 'VTAS' 
         AND OID = @IDOrigen	
         AND DModulo = 'GES'
         
      IF @Ok IS NULL
        EXEC spAfectar 'GES', @IDGenerar, @Accion, 'Todo', NULL, @Usuario, @@SPID, @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT 

      IF @Ok IS NULL
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'VTAS', @IDOrigen, @Origen, @OrigenID, 'GES', @IDGenerar, @MAFSolicitudInspeccion, @MovIDGenerar, @Ok OUTPUT              
    END 	
  END	  
END
GO


/************** spMAFGenerarServicio ***************/
if exists (select * from sysobjects where id = object_id('dbo.spMAFGenerarServicio') and sysstat & 0xf = 4) drop procedure dbo.spMAFGenerarServicio
GO
CREATE PROCEDURE spMAFGenerarServicio
			@Empresa		varchar(5),
			@Sucursal		int,
			@Accion			varchar(20),
			@Usuario		varchar(10),
			@Servicio		varchar(50),
			@ID			int,			
			@AFArticulo		varchar(20),
			@AFSerie		varchar(50),
			@MAFCiclo			int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT		
--//WITH ENCRYPTION			
AS BEGIN
  DECLARE 
    @MAFServicioTaller		varchar(10),
    @MAFServicioUsuario		varchar(10),
    @MAFServicioMov		varchar(20),
    @MAFServicioConcepto	varchar(50),
    @MAFServicioCliente		varchar(10),
    @Tipo			varchar(50),
    @Moneda			varchar(10),
    @TipoCambio			float,
    @FechaEmision		datetime,
    @ServicioDescripcion	varchar(100),
    @AF				int,
    @Origen			varchar(20),
    @OrigenID			varchar(20),
    
    @IDGenerar			int,
    @MovGenerar			varchar(20),
    @MovIDGenerar		varchar(20),	    

    @Articulo			varchar(20),
    @SubCuenta			varchar(50),
    @Cantidad			float,
    @AlmacenEsp			varchar(10),
    @ListaPreciosEsp            varchar(20),
    @Unidad			varchar(50),
    @ArtTipo			varchar(20),    
    @Precio			float,
    @Renglon			float,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @Factor			float,
    @Decimales			int


    
  
  IF @Accion = 'AFECTAR'
  BEGIN      
  	
    SET @FechaEmision = dbo.fnFechaSinHora(GETDATE())  	

    IF @ID IS NOT NULL    
      SELECT @AFArticulo = AFArticulo, @AFSerie = AFSerie, @Origen = Mov, @OrigenID = MovID FROM Gestion WHERE ID = @ID
    
    SELECT 
      @MAFServicioTaller = NULLIF(MAFServicioTaller,''), 
      @MAFServicioUsuario = NULLIF(MAFServicioUsuario,''), 
      @MAFServicioMov = NULLIF(MAFServicioMov,''),  
      @MAFServicioConcepto = NULLIF(MAFServicioConcepto,''),
      @MAFServicioCliente = NULLIF(MAFServicioCliente,'')
      FROM EmpresaCfg2 
     WHERE Empresa = @Empresa 
     
    SELECT @Tipo = Tipo, @AF = ID FROM ActivoF WHERE Articulo = @AFArticulo AND Serie = @AFSerie
    
    SELECT 
      @MAFServicioTaller = ISNULL(NULLIF(ServicioTallerEsp,''),@MAFServicioTaller),     
      @MAFServicioUsuario = ISNULL(NULLIF(ServicioUsuarioEsp,''),@MAFServicioUsuario),     
      @MAFServicioMov = ISNULL(NULLIF(ServicioMovEsp,''),@MAFServicioMov),           
      @MAFServicioConcepto = ISNULL(NULLIF(ServicioConceptoEsp,''),@MAFServicioConcepto),
      @MAFServicioCliente = ISNULL(NULLIF(ServicioClienteEsp,''),@MAFServicioCliente),
      @ServicioDescripcion = SUBSTRING(Descripcion,1,100)                       
      FROM ActivoFTipoServicio      
     WHERE Tipo = @Tipo
       AND Servicio = @Servicio  
       
    SELECT @Moneda = NULLIF(DefMoneda,'') FROM Cte WHERE Cliente = @MAFServicioCliente
       
    SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
       
    IF @MAFServicioTaller IS NULL AND @Ok IS NULL SELECT @Ok = 20390, @OkRef = 'Defina el Taller en la configuración de Servicios del Activo Fijo.'            
    IF @MAFServicioUsuario IS NULL AND @Ok IS NULL SELECT @Ok = 71010
    IF @MAFServicioMov IS NULL AND @Ok IS NULL SELECT @Ok = 14055    
    IF @MAFServicioConcepto IS NULL AND @Ok IS NULL SELECT @Ok = 20480        
    IF @MAFServicioCliente IS NULL AND @Ok IS NULL SELECT @Ok = 40010            
    IF @Moneda IS NULL AND @Ok IS NULL SELECT @Ok = 30040
    
    IF @Ok IS NULL
    BEGIN
      INSERT Venta (Empresa,  Mov,             FechaEmision,  Concepto,             Moneda,  TipoCambio,  Usuario,             Estatus,      Directo, Prioridad, Cliente,             Almacen,            FechaRequerida, Vencimiento,   ServicioTipo, ServicioArticulo, ServicioSerie, ServicioDescripcion,  ServicioFecha, Sucursal,  AF,  AFArticulo,  AFSerie,  OrigenTipo, Origen,  OrigenID,  MAFCiclo)
	    VALUES (@Empresa, @MAFServicioMov, @FechaEmision, @MAFServicioConcepto, @Moneda, @TipoCambio, @MAFServicioUsuario, 'SINAFECTAR', 1,       'Normal',  @MAFServicioCliente, @MAFServicioTaller, @FechaEmision,  @FechaEmision, @Servicio,    @AFArticulo,      @AFSerie,      @ServicioDescripcion, @FechaEmision, @Sucursal, @AF, @AFArticulo, @AFSerie, 'GES',      @Origen, @OrigenID, @MAFCiclo)
      IF @@ERROR <> 0 SET @Ok = 1
      SET @IDGenerar = SCOPE_IDENTITY()
    END  

    IF @Ok IS NULL
    BEGIN
      DECLARE crServicioTipoPlantilla CURSOR FOR 
       SELECT stp.Articulo, stp.SubCuenta, stp.Cantidad, stp.AlmacenEsp, stp.ListaPreciosEsp, a.Unidad, a.Tipo
         FROM ServicioTipoPlantilla stp JOIN Art a
           ON a.Articulo = stp.Articulo
        WHERE stp.Tipo = @Servicio
        ORDER BY stp.Orden

      SET @Renglon = 2048.0
      SET @RenglonID = 1

      OPEN crServicioTipoPlantilla
      FETCH NEXT FROM crServicioTipoPlantilla INTO @Articulo, @SubCuenta, @Cantidad, @AlmacenEsp, @ListaPreciosEsp, @Unidad, @ArtTipo
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        EXEC spPCGet @Sucursal, @Empresa, @SubCuenta, NULL, @Unidad, @Moneda, @TipoCambio, @ListaPreciosEsp, @Precio OUTPUT

        EXEC spRenglonTipo @ArtTipo, @Subcuenta, @RenglonTipo OUTPUT        
        EXEC spUnidadFactor @Empresa, @Articulo, @SubCuenta, @Unidad, @Factor OUTPUT, @Decimales OUTPUT
	INSERT VentaD (ID,         Renglon,  RenglonSub,  RenglonID,  RenglonTipo,  Cantidad,  Unidad,  Almacen,                                           Articulo,  SubCuenta,  Precio,  FechaRequerida, Sucursal,  CantidadInventario)
	       VALUES (@IDGenerar, @Renglon, 0,           @RenglonID, @RenglonTipo, @Cantidad, @Unidad, ISNULL(NULLIF(@AlmacenEsp,''),@MAFServicioTaller), @Articulo, @SubCuenta, @Precio, @FechaEmision,  @Sucursal, @Cantidad * @Factor)
        IF @@ERROR <> 0 SET @Ok = 1	
        SET @Renglon = @Renglon + 2048.0
        SET @RenglonID = @RenglonID + 1
        FETCH NEXT FROM crServicioTipoPlantilla INTO @Articulo, @SubCuenta, @Cantidad, @AlmacenEsp, @ListaPreciosEsp, @Unidad, @ArtTipo
      END
      CLOSE crServicioTipoPlantilla
      DEALLOCATE crServicioTipoPlantilla
    END

    IF @Ok IS NULL
      EXEC spAfectar 'VTAS', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1, @@SPID

    IF @Ok IS NULL AND @ID IS NOT NULL
    BEGIN 
      SELECT @MovIDGenerar = MovID FROM Venta WHERE ID = @IDGenerar	
      EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'GES', @ID, @Origen, @OrigenID, 'VTAS', @IDGenerar, @MAFServicioMov, @MovIDGenerar, @Ok OUTPUT       
    END  
  END ELSE 	  
  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT 
      @IDGenerar = mf.DID 
      FROM MovFlujo mf JOIN MovTipo mt
        ON mt.Mov = mf.DMov AND mt.Modulo = mf.DModulo JOIN Venta v
        ON v.ID = mf.DID
     WHERE mf.OID = @ID 
       AND mf.OModulo = 'GES'   
       AND mt.Modulo = 'VTAS'
       AND mt.Clave = 'VTAS.S'
       AND v.Estatus IN ('CONFIRMAR','PENDIENTE')
       
       IF @IDGenerar IS NOT NULL
         EXEC spAfectar 'VTAS', @IDGenerar, 'CANCELAR', 'Todo', NULL, @Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1, @@SPID  	
  END	
END
GO

/************** spMAFActualizarIndicadorAF ***************/
if exists (select * from sysobjects where id = object_id('dbo.spMAFActualizarIndicadorAF') and sysstat & 0xf = 4) drop procedure dbo.spMAFActualizarIndicadorAF
GO
CREATE PROCEDURE spMAFActualizarIndicadorAF
			@ID			int,			
			@FechaConclusion	datetime,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT		
--//WITH ENCRYPTION			
AS BEGIN
  DECLARE	@ActivoFID		int,
		@AFArticulo		varchar(20),
		@AFSerie		varchar(50),
		@Inspeccion		int,
		@InspeccionUnidad	varchar(20),
		@SiguienteInspeccion	datetime
		
  SELECT @AFArticulo = AFArticulo, @AFSerie = AFSerie FROM Gestion WHERE ID = @ID
  SELECT @ActivoFID = ID,  @Inspeccion = Inspeccion, @InspeccionUnidad = InspeccionUnidad FROM ActivoF WHERE Articulo = @AFArticulo AND Serie = @AFSerie	
  
  UPDATE ActivoFIndicador
     SET Lectura = gafi.Lectura 
    FROM ActivoFIndicador afi JOIN GestionActivoFIndicador gafi
      ON afi.Indicador = gafi.Indicador
   WHERE afi.ActivoFID = @ActivoFID   
     AND gafi.ID = @ID
  IF @@ERROR <> 0 SET @Ok = 1   
  
  IF @Ok IS NULL
  BEGIN
    SET @SiguienteInspeccion = CASE @InspeccionUnidad
      WHEN 'Dias'    THEN DATEADD(dd,@Inspeccion,@FechaConclusion)
      WHEN 'Semanas' THEN DATEADD(ww,@Inspeccion,@FechaConclusion)        	
      WHEN 'Meses'   THEN DATEADD(mm,@Inspeccion,@FechaConclusion)        	
      WHEN 'Años'    THEN DATEADD(yy,@Inspeccion,@FechaConclusion)        	
    END  
    UPDATE ActivoF SET UltimaInspeccion = @FechaConclusion, SiguienteInspeccion = @SiguienteInspeccion WHERE Articulo = @AFArticulo AND Serie = @AFSerie
  END  
END
GO

/************** spMAFCalcularActivoFTipoServicioCondicion ***************/
if exists (select * from sysobjects where id = object_id('dbo.spMAFCalcularActivoFTipoServicioCondicion') and sysstat & 0xf = 4) drop procedure dbo.spMAFCalcularActivoFTipoServicioCondicion
GO
CREATE PROCEDURE spMAFCalcularActivoFTipoServicioCondicion
			@AFArticulo		varchar(20),
			@AFSerie		varchar(50),
			@Indicador		varchar(50),
			@Servicio		varchar(50),
			@Lectura		varchar(100),			
			@Resultado		bit		OUTPUT,
			@Operador		varchar(1)	OUTPUT,
			@Automatico		bit,
			@MAFCiclo			int		OUTPUT, --ARCC MAFCiclo
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT		
--//WITH ENCRYPTION			
AS BEGIN
  DECLARE	@Tipo		varchar(50),
		@TipoDato	varchar(20),
		@Condicion	varchar(20),
		@Valor1		varchar(100),
		@Valor2		varchar(100),
		
		@Texto1		varchar(100),
		@Texto2		varchar(100),
		@Numerico1	float,
		@Numerico2	float,
		@Fecha1		datetime,
		@Fecha2		datetime,
		@Logico		bit,
		
		@TextoL		varchar(100),
		@NumericoL	float,
		@FechaL		datetime,
		@LogicoL	bit,
		
		@FechaLimite	datetime

  SET @MAFCiclo = NULL		

  SELECT @Tipo = Tipo FROM ActivoF WHERE Articulo = @AFArticulo AND Serie = @AFSerie
  SELECT @TipoDato = TipoDato FROM ActivoFTipoIndicador WHERE Tipo = @Tipo AND Indicador = @Indicador
  
  IF @Automatico = 1 AND @TipoDato = 'FECHA'
  BEGIN
    SET @Lectura = CONVERT(varchar,GETDATE())
  END ELSE 
  BEGIN
    IF @Automatico = 1 AND @TipoDato <> 'FECHA'
    BEGIN
      SET @Resultado = 0
      SELECT @Operador = ISNULL(Operador,'') FROM ActivoFTipoServicioCondicion WHERE Tipo = @Tipo AND Servicio = @Servicio AND Indicador = @Indicador    	
      RETURN	
    END	
  END	  
    
  
  SELECT @Operador = ISNULL(Operador,''), @Condicion = Condicion, @Valor1 = Valor, @Valor2 = Valor2 FROM ActivoFTipoServicioCondicion WHERE Tipo = @Tipo AND Servicio = @Servicio AND Indicador = @Indicador    
      
  SELECT UPPER(RTRIM(LTRIM(Valor))) Valor INTO #ActivoFTipoIndicadorLista FROM ActivoFTipoIndicadorLista WHERE Tipo = @Tipo AND Indicador = @Indicador
  
  IF UPPER(RTRIM(LTRIM(@Lectura))) NOT IN (SELECT Valor FROM #ActivoFTipoIndicadorLista) AND EXISTS(SELECT * FROM #ActivoFTipoIndicadorLista)
    SELECT @Ok = 10060, @OkRef = 'Lectura incorrecta en el indicador ' + RTRIM(@Indicador) + '. Lectura:' + @Lectura       

  IF UPPER(RTRIM(LTRIM(@Valor1))) NOT IN (SELECT Valor FROM #ActivoFTipoIndicadorLista) AND EXISTS(SELECT * FROM #ActivoFTipoIndicadorLista) AND @Ok IS NULL
    SELECT @Ok = 10060, @OkRef = 'Parámetro incorrecto en el indicador ' + RTRIM(@Indicador) + '. Parámetro:' + @Valor1

  IF UPPER(RTRIM(LTRIM(@Valor2))) NOT IN (SELECT Valor FROM #ActivoFTipoIndicadorLista) AND EXISTS(SELECT * FROM #ActivoFTipoIndicadorLista) AND @Ok IS NULL
    SELECT @Ok = 10060, @OkRef = 'Parámetro incorrecto en el indicador ' + RTRIM(@Indicador) + '. Parámetro:' + @Valor2        

  IF RTRIM(@TipoDato) = 'TEXTO' AND @Ok IS NULL
  BEGIN
    SET @Texto1 = LTRIM(RTRIM(UPPER(@Valor1)))
    SET @Texto2 = LTRIM(RTRIM(UPPER(@Valor2)))
    SET @TextoL = LTRIM(RTRIM(UPPER(@Lectura)))	
    IF @Condicion NOT IN ('IGUAL QUE','ENTRE','DIFERENTE QUE','MAYOR QUE','MENOR QUE','MAYOR O IGUAL QUE','MENOR O IGUAL QUE') AND @Ok IS NULL SELECT @Ok = 10060, @OkRef = 'Condición incorrecta en el indicador ' + RTRIM(@Indicador) + '. Condición:' + @Condicion        
    IF @Condicion = 'IGUAL QUE' AND @Ok IS NULL
    BEGIN
      IF @TextoL = @Texto1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'ENTRE' AND @Ok IS NULL
    BEGIN
      IF @TextoL >= @Texto1 AND @TextoL <= @Texto2 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'DIFERENTE QUE' AND @Ok IS NULL
    BEGIN
      IF @TextoL <> @Texto1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MAYOR QUE' AND @Ok IS NULL
    BEGIN
      IF @TextoL > @Texto1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MENOR QUE' AND @Ok IS NULL
    BEGIN
      IF @TextoL < @Texto1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MAYOR O IGUAL QUE' AND @Ok IS NULL
    BEGIN
      IF @TextoL >= @Texto1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MENOR O IGUAL QUE' AND @Ok IS NULL
    BEGIN
      IF @TextoL <= @Texto1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	  	
  END    		
  
  IF RTRIM(@TipoDato) = 'NUMERICO' AND @Ok IS NULL
  BEGIN
    SET @Numerico1 = CONVERT(float,@Valor1)
    IF @@ERROR <> 0 SELECT @Ok = 10060, @OkRef = 'Parámetro incorrecto en el indicador ' + RTRIM(@Indicador) + '. Parámetro:' + @Valor1
    SET @Numerico2 = CONVERT(float,@Valor2)
    IF @@ERROR <> 0 SELECT @Ok = 10060, @OkRef = 'Parámetro incorrecto en el indicador ' + RTRIM(@Indicador) + '. Parámetro:' + @Valor2
    SET @NumericoL = CONVERT(float,@Lectura)	
    IF @@ERROR <> 0 SELECT @Ok = 10060, @OkRef = 'Lectura incorrecta en el indicador ' + RTRIM(@Indicador) + '. Lectura:' + @Lectura 
    IF @Condicion NOT IN ('IGUAL QUE','ENTRE','CADA','DIFERENTE QUE','MAYOR QUE','MENOR QUE','MAYOR O IGUAL QUE','MENOR O IGUAL QUE') AND @Ok IS NULL SELECT @Ok = 10060, @OkRef = 'Condición incorrecta en el indicador ' + RTRIM(@Indicador) + '. Condición:' + @Condicion  --ARCC MAFCiclo           
    IF @Condicion = 'IGUAL QUE' AND @Ok IS NULL
    BEGIN
      IF @NumericoL = @Numerico1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'ENTRE' AND @Ok IS NULL
    BEGIN
      IF @NumericoL >= @Numerico1 AND @NumericoL <= @Numerico2 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'CADA' AND @Ok IS NULL --ARCC MAFCiclo
    BEGIN
      IF (CONVERT(int,@NumericoL) % CONVERT(int,@Numerico1)) <= (CONVERT(int,@Numerico2) - CONVERT(int,@Numerico1)) AND (CONVERT(int,@NumericoL) / CONVERT(int,@Numerico1) > 0)
      BEGIN
        SET @Resultado = 1 
	SET @MAFCiclo = CONVERT(int,@NumericoL) / CONVERT(int,@Numerico1)
      END
      ELSE 
        SET @Resultado = 0
    END	    
    IF @Condicion = 'DIFERENTE QUE' AND @Ok IS NULL
    BEGIN
      IF @NumericoL <> @Numerico1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MAYOR QUE' AND @Ok IS NULL
    BEGIN
      IF @NumericoL > @Numerico1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MENOR QUE' AND @Ok IS NULL
    BEGIN
      IF @NumericoL < @Numerico1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MAYOR O IGUAL QUE' AND @Ok IS NULL
    BEGIN
      IF @NumericoL >= @Numerico1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MENOR O IGUAL QUE' AND @Ok IS NULL
    BEGIN
      IF @NumericoL <= @Numerico1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	  	
  END    		

  IF RTRIM(@TipoDato) = 'FECHA' AND @Ok IS NULL
  BEGIN
    SET @Fecha1 = CONVERT(datetime,RTRIM(@Valor1))
    IF @@ERROR <> 0 SELECT @Ok = 10060, @OkRef = 'Parámetro incorrecto en el Indicador ' + RTRIM(@Indicador) + '. Parámetro:' + @Valor1
    SET @Fecha2 = CONVERT(datetime,RTRIM(@Valor2))
    IF @@ERROR <> 0 SELECT @Ok = 10060, @OkRef = 'Parámetro incorrecto en el indicador ' + RTRIM(@Indicador) + '. Parámetro:' + @Valor2
    SET @FechaL = CONVERT(datetime,RTRIM(@Lectura))	
    IF @@ERROR <> 0 SELECT @Ok = 10060, @OkRef = 'Lectura incorrecta en el indicador ' + RTRIM(@Indicador) + '. Lectura:' + @Lectura 
    IF @Condicion NOT IN ('IGUAL QUE','ENTRE','DIFERENTE QUE','MAYOR QUE','MENOR QUE','MAYOR O IGUAL QUE','MENOR O IGUAL QUE') AND @Ok IS NULL SELECT @Ok = 10060, @OkRef = 'Condición incorrecta en el indicador ' + RTRIM(@Indicador) + '. Condición:' + @Condicion             
    IF @Condicion = 'IGUAL QUE' AND @Ok IS NULL
    BEGIN
      IF @FechaL = @Fecha1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'ENTRE' AND @Ok IS NULL
    BEGIN
      IF @FechaL >= @Fecha1 AND @FechaL <= @Fecha2 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'DIFERENTE QUE' AND @Ok IS NULL
    BEGIN
      IF @FechaL <> @Fecha1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MAYOR QUE' AND @Ok IS NULL
    BEGIN
      IF @FechaL > @Fecha1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MENOR QUE' AND @Ok IS NULL
    BEGIN
      IF @FechaL < @Fecha1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MAYOR O IGUAL QUE' AND @Ok IS NULL
    BEGIN
      IF @FechaL >= @Fecha1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	
    IF @Condicion = 'MENOR O IGUAL QUE' AND @Ok IS NULL
    BEGIN
      IF @FechaL <= @Fecha1 SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	  	
  END    		  

  IF RTRIM(@TipoDato) = 'VENCIMIENTO' AND @Ok IS NULL
  BEGIN
    SET @Numerico1 = CONVERT(int,RTRIM(@Valor1))
    IF @@ERROR <> 0 SELECT @Ok = 10060, @OkRef = 'Parámetro incorrecto en el indicador ' + RTRIM(@Indicador) + '. Parámetro:' + @Valor1
    SET @Texto2 = UPPER(LTRIM(RTRIM(@Valor2)))
    SET @FechaL = CONVERT(datetime,RTRIM(@Lectura))	
    IF @@ERROR <> 0 SELECT @Ok = 10060, @OkRef = 'Lectura incorrecta en el indicador ' + RTRIM(@Indicador) + '. Lectura:' + @Lectura 
    IF @Texto2 NOT IN ('DIAS','SEMANAS','MESES','AÑOS') AND @Ok IS NULL SELECT @Ok = 10060, @OkRef = 'Parámetro incorrecto en el indicador ' + RTRIM(@Indicador) + '. Parámetro:' + @Valor2    
    IF @Condicion NOT IN ('FALTAN MENOS DE','PASARON MAS DE') AND @Ok IS NULL SELECT @Ok = 10060, @OkRef = 'Condición incorrecta en el indicador ' + RTRIM(@Indicador) + '. Condición:' + @Condicion  
    IF @Condicion = 'FALTAN MENOS DE' AND @Ok IS NULL
    BEGIN
      IF @Texto2 = 'DIAS' SET @FechaLimite = DATEADD(dd,0-@Numerico1,@FechaL)  
      IF @Texto2 = 'SEMANAS' SET @FechaLimite = DATEADD(ww,0-@Numerico1,@FechaL)  
      IF @Texto2 = 'MESES' SET @FechaLimite = DATEADD(mm,0-@Numerico1,@FechaL)  
      IF @Texto2 = 'AÑOS' SET @FechaLimite = DATEADD(mm,0-@Numerico1,@FechaL)  
      
      IF GETDATE() >= @FechaLimite SET @Resultado = 1 ELSE SET @Resultado = 0
    END	
    IF @Condicion = 'PASARON MAS DE' AND @Ok IS NULL
    BEGIN
      IF @Texto2 = 'DIAS' SET @FechaLimite = DATEADD(dd,@Numerico1,@FechaL)  
      IF @Texto2 = 'SEMANAS' SET @FechaLimite = DATEADD(ww,@Numerico1,@FechaL)  
      IF @Texto2 = 'MESES' SET @FechaLimite = DATEADD(mm,@Numerico1,@FechaL)  
      IF @Texto2 = 'AÑOS' SET @FechaLimite = DATEADD(mm,@Numerico1,@FechaL)  
      
      IF GETDATE() >= @FechaLimite SET @Resultado = 1 ELSE SET @Resultado = 0
    END	
  END    		  

  IF RTRIM(@TipoDato) = 'LOGICO' AND @Ok IS NULL
  BEGIN
    SET @Logico = CONVERT(bit,@Valor1)
    IF @@ERROR <> 0 SELECT @Ok = 10060, @OkRef = 'Parámetro incorrecto en el indicador ' + RTRIM(@Indicador) + '. Parámetro:' + @Valor1
    SET @LogicoL = CONVERT(bit,@Lectura)	
    IF @@ERROR <> 0 SELECT @Ok = 10060, @OkRef = 'Lectura incorrecta en el indicador ' + RTRIM(@Indicador) + '. Lectura:' + @Lectura 
    IF @Condicion NOT IN ('IGUAL QUE') AND @Ok IS NULL SELECT @Ok = 10060, @OkRef = 'Condición incorrecta en el indicador ' + RTRIM(@Indicador) + '. Condición:' + @Condicion             
    IF @Condicion = 'IGUAL QUE' AND @Ok IS NULL
    BEGIN
      IF @LogicoL = @Logico SET @Resultado = 1 ELSE SET @Resultado = 0  	
    END	    
  END    		
  
END
GO

/************** spMAFCalcularActivoFTipoServicio ***************/
if exists (select * from sysobjects where id = object_id('dbo.spMAFCalcularActivoFTipoServicio') and sysstat & 0xf = 4) drop procedure dbo.spMAFCalcularActivoFTipoServicio
GO
CREATE PROCEDURE spMAFCalcularActivoFTipoServicio
			@AFArticulo		varchar(20),
			@AFSerie		varchar(50),
			@Servicio		varchar(50),
			@Resultado		bit		OUTPUT,
			@Automatico		bit,
			@MAFCiclo			int		OUTPUT, --ARCC MAFCiclo
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT					
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	@Tipo			varchar(50),
		@ActivoFID		int,
		
		@Indicador		varchar(50),
		@Lectura		varchar(100),
		@ResultadoCondicion	bit,
		@SQL			nvarchar(MAX),
		@Operador		varchar(1),
		@ResultadoOperador	varchar(5),
		@RetornoEjecucion	int,
		@TotalCondiciones	int,
		@Contador		int,
		@CaracterNulo		varchar(1)

  SELECT @Tipo = Tipo, @ActivoFID = ID FROM ActivoF WHERE Articulo = @AFArticulo AND Serie = @AFSerie

   SELECT @TotalCondiciones = Count(*)
     FROM ActivoFTipoServicioCondicion aftsc
    WHERE aftsc.Tipo = @Tipo AND aftsc.Servicio = @Servicio

  SET @Contador = 1
  SET @CaracterNulo = 'X'
  SET @SQL = 'SET @Resultado = CASE '  
  DECLARE crActivoFTipoServicioCondicion CURSOR FOR 
   SELECT aftsc.Indicador, afi.Lectura
     FROM ActivoFTipoServicioCondicion aftsc JOIN ActivoFIndicador afi
       ON aftsc.Indicador = afi.Indicador
    WHERE afi.ActivoFID = @ActivoFID AND aftsc.Tipo = @Tipo AND aftsc.Servicio = @Servicio
   ORDER BY aftsc.Orden

  OPEN crActivoFTipoServicioCondicion
  FETCH NEXT FROM crActivoFTipoServicioCondicion INTO @Indicador, @Lectura  
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN

    EXEC spMAFCalcularActivoFTipoServicioCondicion @AFArticulo, @AFSerie, @Indicador, @Servicio, @Lectura, @ResultadoCondicion OUTPUT, @Operador OUTPUT, @Automatico, @MAFCiclo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT --ARCC MAFCiclo    
    IF @Contador = @TotalCondiciones AND NULLIF(@Operador,'') IS NOT NULL SELECT @Ok = 10060, @OkRef = 'Operador incorrecto. Servicio:' + @Servicio    
    IF @Contador = @TotalCondiciones SET @CaracterNulo = ''
    SET @ResultadoOperador =
      CASE LTRIM(RTRIM(UPPER(@Operador)))
        WHEN 'Y' THEN ' & '
        WHEN 'O' THEN ' | '
        WHEN ''  THEN @CaracterNulo
      END

    IF @ResultadoOperador = 'X' SELECT @Ok = 10060, @OkRef = 'Operador incorrecto. Servicio:' + @Servicio
             
    SET @SQL = @SQL + RTRIM(CONVERT(varchar,@ResultadoCondicion)) + ISNULL(@ResultadoOperador,'')
    SET @Contador = @Contador + 1	
    FETCH NEXT FROM crActivoFTipoServicioCondicion INTO @Indicador, @Lectura
  END
  CLOSE crActivoFTipoServicioCondicion
  DEALLOCATE crActivoFTipoServicioCondicion
  IF @Ok IS NULL
  BEGIN
    SET @SQL = @SQL + ' WHEN 1 THEN 1 ELSE 0 END'
    EXEC @RetornoEjecucion = sp_executesql @SQL, N'@Resultado bit OUTPUT', @Resultado = @Resultado OUTPUT
    IF @RetornoEjecucion <> 0 SELECT @Ok = 1
  END

  IF @Ok IS NULL AND @Resultado = 1
  BEGIN
    IF EXISTS(SELECT * FROM MAFServicioAbierto WHERE AFArticulo = @AFArticulo AND AFSerie = @AFSerie AND ServicioTipo = @Servicio) OR EXISTS(SELECT * FROM MAFServicioUnico WHERE AFArticulo = @AFArticulo AND AFSerie = @AFSerie AND ServicioTipo = @Servicio) 
       OR EXISTS(SELECT * FROM MAFServicioCiclico WHERE AFArticulo = @AFArticulo AND AFSerie = @AFSerie AND ServicioTipo = @Servicio AND MAFCiclo = @MAFCiclo)
      SET @Resultado = 0  	
  END      
END
GO

/************** spMAFGenerarServicios ***************/
if exists (select * from sysobjects where id = object_id('dbo.spMAFGenerarServicios') and sysstat & 0xf = 4) drop procedure dbo.spMAFGenerarServicios
GO
CREATE PROCEDURE spMAFGenerarServicios
			@Empresa		varchar(5), 
			@Sucursal		int, 
			@Accion			varchar(20), 
			@Usuario		varchar(10), 
			@ID			int,
			@AFArticulo		varchar(20),
			@AFSerie		varchar(50),
			@Automatico		bit,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT		
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	@Tipo			varchar(50),
		@ActivoFID		int,
		@Servicio		varchar(50), 
		@Unico			bit,
		@Inspeccion		int,
		@InspeccionUnidad	varchar(20),
		@Resultado		bit,
		@MAFCiclo			int --ARCC MAFCiclo
		
		

  SELECT @Tipo = Tipo, @ActivoFID = ID FROM ActivoF WHERE Articulo = @AFArticulo AND Serie = @AFSerie


  DECLARE crActivoFTipoServicio CURSOR FOR 
   SELECT afts.Servicio, afts.Unico, afts.Inspeccion, afts.InspeccionUnidad
     FROM ActivoFTipoServicio afts
    WHERE afts.Tipo = @Tipo

  OPEN crActivoFTipoServicio
  FETCH NEXT FROM crActivoFTipoServicio INTO @Servicio, @Unico, @Inspeccion, @InspeccionUnidad 
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    SET @MAFCiclo = NULL --ARCC MAFCiclo
    EXEC spMAFCalcularActivoFTipoServicio @AFArticulo, @AFSerie, @Servicio, @Resultado OUTPUT, @Automatico, @MAFCiclo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT --ARCC MAFCiclo
    
    IF @Ok IS NULL AND @Resultado = 1
      EXEC spMAFGenerarServicio @Empresa, @Sucursal, @Accion, @Usuario, @Servicio, @ID, @AFArticulo, @AFSerie, @MAFCiclo, @Ok OUTPUT, @OkRef OUTPUT --ARCC MAFCiclo
      
    
    FETCH NEXT FROM crActivoFTipoServicio INTO @Servicio, @Unico, @Inspeccion, @InspeccionUnidad 
  END
  CLOSE crActivoFTipoServicio
  DEALLOCATE crActivoFTipoServicio
      
END
GO

/**************** spMAFConcluirServicioMAF ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMAFConcluirServicioMAF') and sysstat & 0xf = 4) drop procedure dbo.spMAFConcluirServicioMAF
GO             
CREATE PROCEDURE spMAFConcluirServicioMAF
		@Modulo			varchar(5), 
		@AplicaEstatusNuevo	varchar(15), 
		@Accion			varchar(20), 
		@Empresa		varchar(5), 
		@Sucursal		int, 
		@Usuario		varchar(10), 
		@AplicaFechaConclusion	datetime, 
		@IDAplica		int, 
		@ID			int,
		@EstatusNuevo		varchar(15),
		@Ok			int OUTPUT, 
		@OkRef			varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SubClaveAplica		varchar(20),
    @CfgMAF			bit,
    @AFArticuloAplica		varchar(20),
    @AFSerieAplica		varchar(50),
    @AFID			int,
    @EstatusAF			varchar(15),
    @Horas			float,
    @Costo			money,
    @Articulo			varchar(20),
    @SubCuenta			varchar(50),
    @Cantidad			float,
    @Tipo			varchar(20),
    @Unidad			varchar(50),
    @TipoCosteo			varchar(20),
    @Moneda			varchar(10),
    @TipoCambio			float,
    @CostoArticulo		money,
    @ServicioMovAFEsp		varchar(20)
    
    IF @Modulo = 'VTAS' AND @AplicaEstatusNuevo IN ('CONCLUIDO','CANCELADO') AND @Accion IN ('AFECTAR','CANCELAR')
    BEGIN
      SELECT @CfgMAF = MAF FROM EmpresaGral WHERE Empresa = @Empresa          	        	
      IF @CfgMAF = 1
      BEGIN    
        SELECT @SubClaveAplica = mt.SubClave, @AFArticuloAplica = AFArticulo, @AFSerieAplica = AFSerie FROM Venta v JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' WHERE ID = @IDAplica           
        IF @SubClaveAplica = 'MAF.S' 
        BEGIN              	
          EXEC spMAFGenerarSolicitudInspeccion @Empresa, @Sucursal, @Accion, @AFArticuloAplica, @AFSerieAplica, @Usuario, NULL, @AplicaFechaConclusion, @IDAplica, @Ok OUTPUT, @OkRef OUTPUT            	
        END        
      END        
    END      
END
GO

