/**************** fnSAUXArticuloNoDisponibleSolConcluida ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSAUXArticuloNoDisponibleSolConcluida') DROP FUNCTION fnSAUXArticuloNoDisponibleSolConcluida
GO
CREATE FUNCTION fnSAUXArticuloNoDisponibleSolConcluida
	(
	@Empresa				varchar (5),
	@Origen					varchar (20),
	@OrigenID				varchar (20),
	@OrigenSAUX				varchar (20),
	@OrigenIDSAUX			varchar (20),
	@Cantidad				int
	)
RETURNS @Resultado TABLE
        (
        Articulo		varchar(20) COLLATE DATABASE_DEFAULT NULL
        )

--//WITH ENCRYPTION
AS BEGIN
  
  INSERT @Resultado
  SELECT d.Articulo
    FROM SAUX s
    JOIN SAUX os ON s.Origen = os.Mov AND s.OrigenID = os.MovID AND s.Empresa = os.Empresa
    JOIN Inv i   ON i.Origen = s.Mov AND i.OrigenID = s.MovID AND i.Empresa = s.Empresa
    JOIN InvD d  ON i.ID = d.ID
   WHERE os.Mov = @Origen
     AND os.MovID = @OrigenID
     AND os.Empresa = @Empresa
     AND i.Estatus IN ('PENDIENTE', 'CONCLUIDO')
   GROUP BY d.Articulo
   UNION ALL
  SELECT d.Articulo
    FROM Inv s
    JOIN InvD d ON s.ID = d.ID
   WHERE s.Origen = @OrigenSAUX
     AND s.OrigenID = @OrigenIDSAUX
     AND d.Cantidad = ISNULL(@Cantidad,1)
     AND s.Empresa = @Empresa
     AND s.Estatus IN ('PENDIENTE', 'CONCLUIDO')
   GROUP BY d.Articulo
   
  RETURN
END
GO

/**************** fnSAUXArticuloNoDisponibleServicioConcluido ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSAUXArticuloNoDisponibleServicioConcluido') DROP FUNCTION fnSAUXArticuloNoDisponibleServicioConcluido
GO
CREATE FUNCTION fnSAUXArticuloNoDisponibleServicioConcluido 
	(
	@Empresa				varchar (5),
	@Origen					varchar (20),
	@OrigenID				varchar (20),
	@OrigenSAUX				varchar (20),
	@OrigenIDSAUX			varchar (20),
	@OrigenSS				varchar (20),
	@OrigenIDSS				varchar (20),
	@Cantidad				int
	)
RETURNS @Resultado TABLE
        (
        Articulo		varchar(20) COLLATE DATABASE_DEFAULT NULL
        )

--//WITH ENCRYPTION
AS BEGIN
  
  INSERT @Resultado
  SELECT d.Articulo
    FROM SAUX s
    JOIN SAUX os ON s.Origen = os.Mov AND s.OrigenID = os.MovID AND s.Empresa = os.Empresa
    JOIN Inv i   ON i.Origen = s.Mov AND i.OrigenID = s.MovID AND i.Empresa = s.Empresa
    JOIN InvD d  ON i.ID = d.ID
   WHERE s.Origen = @OrigenSS
     AND s.OrigenID = @OrigenIDSS
     AND s.Empresa = @Empresa
     AND i.Estatus IN ('PENDIENTE', 'CONCLUIDO')
   GROUP BY d.Articulo     
   UNION ALL
  SELECT d.Articulo
    FROM SAUX s
    JOIN SAUX os ON s.Origen = os.Mov AND s.OrigenID = os.MovID AND s.Empresa = os.Empresa
    JOIN Inv i   ON i.Origen = s.Mov AND i.OrigenID = s.MovID AND i.Empresa = s.Empresa
    JOIN InvD d  ON i.ID = d.ID
   WHERE os.Mov = @Origen
     AND os.MovID = @OrigenID
     AND os.Empresa = @Empresa
     AND i.Estatus IN ('PENDIENTE', 'CONCLUIDO')
   GROUP BY d.Articulo
   UNION ALL
  SELECT d.Articulo
    FROM Inv s
    JOIN InvD d ON s.ID = d.ID
   WHERE s.Origen = @OrigenSAUX
     AND s.OrigenID = @OrigenIDSAUX
     AND d.Cantidad = ISNULL(@Cantidad,1)
     AND s.Empresa = @Empresa
     AND s.Estatus IN ('PENDIENTE', 'CONCLUIDO')
   GROUP BY d.Articulo
   
  RETURN
END
GO

/**************** fnSAUXArticuloNoDisponibleServicio ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSAUXArticuloNoDisponibleServicio') DROP FUNCTION fnSAUXArticuloNoDisponibleServicio
GO
CREATE FUNCTION fnSAUXArticuloNoDisponibleServicio
	(
	@Empresa				varchar (5),
	@IDOrigen				int,
	@Origen					varchar (20),
	@OrigenID				varchar (20),
	@Articulo				varchar (20),
	@ID						int
	)
RETURNS @Resultado TABLE
        (
        Servicio		varchar(20) COLLATE DATABASE_DEFAULT NULL
        )

--//WITH ENCRYPTION
AS BEGIN
  
  INSERT @Resultado
  SELECT Servicio
    FROM SAUXD
   WHERE ID = @IDOrigen
     AND Producto = @Articulo
     AND Estado IN ('SINAFECTAR', 'CONCLUIDO')
     AND Servicio NOT IN(SELECT d.Servicio
                           FROM SAUXD d JOIN SAUX s
                             ON d.ID = s.ID
                          WHERE d.ID <> @ID
                            AND d.Producto = @Articulo
                            AND s.Estatus IN ('PENDIENTE', 'CONCLUIDO')
                            AND s.Origen = @Origen
                            AND s.OrigenID = @OrigenID
                            AND s.Empresa = @Empresa
                            AND d.Servicio IN(SELECT sd.Servicio
                                                FROM SAUX s
                                                JOIN SAUXD sd ON s.ID = sd.ID
                                                JOIN SAUX os  ON s.Origen = os.Mov AND s.OrigenID = os.MovID AND s.Empresa = os.Empresa
                                                JOIN Inv i    ON i.Origen = s.Mov AND i.OrigenID = s.MovID AND s.Empresa = i.Empresa
                                                JOIN InvD d   ON i.ID = d.ID
                                               WHERE os.Mov = @Origen
                                                 AND os.MovID = @OrigenID
                                                 AND os.Empresa = @Empresa
                                                 AND i.Estatus IN ('PENDIENTE', 'CONCLUIDO')
                                               GROUP BY sd.Servicio
                                               )
						  GROUP BY d.Servicio
						 )
   
  RETURN
END
GO

/**************** fnValidarIndicadores ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnValidarIndicadores') DROP FUNCTION fnValidarIndicadores
GO
CREATE FUNCTION fnValidarIndicadores
 (@ID int, @Indicador varchar(20), @Valor	varchar(255))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado	bit,  
  @Tipo			varchar(30)
  
  SET @Resultado = 0

  IF NOT EXISTS(SELECT * FROM SAUXDIndicador WHERE ID = @ID) AND ISNULL(@ID,0) <> 0
    SET @Resultado = 1
  
  IF ISNULL(@ID,0) <> 0
    DECLARE crVerificar CURSOR FOR
     SELECT s.Indicador, i.Tipo
       FROM SAUXDIndicador s
       JOIN SAUXIndicador i ON s.Indicador = i.Indicador
	   JOIN SAUXIndicadorD d ON i.Indicador = d.Indicador
      WHERE ID = @ID
        AND s.Indicador = @Indicador
  ELSE
    DECLARE crVerificar CURSOR FOR
     SELECT i.Indicador, i.Tipo
       FROM SAUXIndicador i
      WHERE i.Indicador = @Indicador    


  OPEN crVerificar
  FETCH NEXT FROM crVerificar INTO @Indicador, @Tipo
  WHILE @@FETCH_STATUS = 0 
  BEGIN

--SELECT @Indicador, @Tipo, @Valor, @Valor, ISNUMERIC(@Valor)
    
    IF @Tipo = 'Numérico' AND @Resultado = 0 AND ISNUMERIC(@Valor) = 0      
	  SET @Resultado = 1
    ELSE
    IF @Tipo = 'Alfanumérico Variable' AND @Resultado = 0
	  IF @Valor = '' OR ISNUMERIC(@Valor) = 1
	    SET @Resultado = 1
    ELSE
    IF @Tipo = 'Lista Opcional' AND @Resultado = 0
	  IF @Valor = ''
	    SET @Resultado = 1

    IF @Tipo <> 'Lista Opcional' AND @Resultado = 0 AND ISNULL(@ID,0) <> 0
      IF @Valor NOT IN (SELECT Parametro FROM SAUXIndicadorD WHERE Indicador = @Indicador)
	    SET @Resultado = 1
	            
    FETCH NEXT FROM crVerificar INTO @Indicador, @Tipo--, @Valor
  END
  CLOSE crVerificar
  DEALLOCATE crVerificar

  RETURN (@Resultado)
END
GO

/**************** fnValidarIndicadoresID ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnValidarIndicadoresID') DROP FUNCTION fnValidarIndicadoresID
GO
CREATE FUNCTION fnValidarIndicadoresID
 (@ID int)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado	bit,
  @Indicador	varchar(20),
  @Valor		varchar(255),
  @Tipo			varchar(30)
  
  SET @Resultado = 0

  --IF NOT EXISTS( SELECT * FROM SAUXDIndicador WHERE ID = @ID)
  --  SET @Resultado = 1
  
  DECLARE crVerificar CURSOR FOR
   SELECT s.Indicador, i.Tipo, RTRIM(ISNULL(s.Valor, ''))
     FROM SAUXDIndicador s
     JOIN SAUXIndicador i ON s.Indicador = i.Indicador
    WHERE ID = @ID

  OPEN crVerificar
  FETCH NEXT FROM crVerificar INTO @Indicador, @Tipo, @Valor
  WHILE @@FETCH_STATUS = 0 
  BEGIN

--    SELECT @Indicador, @Tipo, @Valor, @Valor, @Valor
    
    IF @Tipo = 'Numérico' AND @Resultado = 0
	  IF @Valor IS NULL 
	    SET @Resultado = 1
	ELSE  
    IF @Tipo = 'Lista Fija' AND @Resultado = 0
	  IF @Valor = ''
	    SET @Resultado = 1
    ELSE
    IF @Tipo = 'Alfanumérico Variable' AND @Resultado = 0
	  IF @Valor = ''
	    SET @Resultado = 1
    ELSE
    IF @Tipo = 'Lista Opcional' AND @Resultado = 0
	  IF @Valor = ''
	    SET @Resultado = 1

    FETCH NEXT FROM crVerificar INTO @Indicador, @Tipo, @Valor
  END
  CLOSE crVerificar
  DEALLOCATE crVerificar
  
  RETURN (@Resultado)
END
GO 
--/* DEMO */ spAfectar 'SAUX', 563, 'AFECTAR', 'Todo', NULL, 'DEMO', @Estacion=2


/**************** spContactoLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContactoLista') and type = 'P') drop procedure dbo.spContactoLista
GO
CREATE PROCEDURE spContactoLista
   @ContactoTipo	varchar(10)
 	
--//WITH ENCRYPTION
AS BEGIN 

  SELECT Contacto, Nombre, Tipo FROM
  (SELECT Cliente as Contacto, Nombre as Nombre, 'Cliente' as Tipo FROM Cte
    UNION ALL
   SELECT Proveedor as Contacto, Nombre as Nombre, 'Proveedor' as Tipo FROM Prov
   )ContactoLista
   WHERE Tipo = @ContactoTipo
  RETURN
END
GO


/**************** spLugarConsumo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLugarConsumo') and type = 'P') drop procedure dbo.spLugarConsumo
GO
CREATE PROCEDURE spLugarConsumo
		    @Articulo			varchar(20)
		       
--//WITH ENCRYPTION
AS BEGIN 

     SELECT '(Sol. Pendiente)' AS Clave, 'Solicitud Pendiente' AS Descripcion
      UNION ALL
	 SELECT '(Sol. Concluida)' AS Clave, 'Solicitud Concluida' AS Descripcion
	  UNION ALL
	 SELECT s.Servicio AS Clave, s.Descripcion AS Descripcion
	   FROM SAUXArtServicio a
	   JOIN SAUXServicio s ON a.Servicio=s.Servicio
	  WHERE a.Articulo = @Articulo

  RETURN
END
GO


/**************** spSAUXMovConsumoDirecto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSAUXMovConsumoDirecto') and type = 'P') drop procedure dbo.spSAUXMovConsumoDirecto
GO
CREATE PROCEDURE spSAUXMovConsumoDirecto
		    @ConsumoDirecto		bit
   
--//WITH ENCRYPTION
AS BEGIN 

  IF @ConsumoDirecto = 0
    SELECT Mov FROM MovTipo WHERE Modulo = 'Inv' AND Clave = 'INV.SM' AND SubClave = 'INV.SAUX'
  ELSE
    SELECT Mov FROM MovTipo WHERE Modulo = 'Inv' AND Clave = 'INV.CM' AND SubClave = 'INV.SAUX'

  RETURN
END
GO


/**************** spSAUXGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSAUXGenerar') and type = 'P') drop procedure dbo.spSAUXGenerar
GO
CREATE PROCEDURE spSAUXGenerar
		    @Modulo			varchar(5),
    		@ID		        int,			
 		    @Accion			varchar(20),
 		    @Base			varchar(20),
 		    @FechaRegistro	datetime,
 		    @GenerarMov		char(20),
    		@Empresa        varchar(5),
		    @Sucursal		int,
		    @Usuario		varchar(10),
		    @Conexion		bit,
		    @SincroFinal	bit,
		    @Mov			varchar(20),
            @MovID			varchar(20),
		    @MovTipo		varchar(20),
		    @Almacen		varchar(10),
		    @FechaEmision	datetime,
		    @ModuloDestino	varchar(5),
		    @MovDestino		varchar(20),
		    
    		@Ok             int           	OUTPUT,
    		@OkRef          varchar(255)  	OUTPUT
   
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
		@CfgMultiUnidades		bit,
		@CfgMultiUnidadesNivel	char(20),
		@Moneda					varchar(10),
		@TipoCambio				float,
		@TipoCosteo				varchar(20),
		@IDGenerar				int,
		@MovIDDestino			varchar(20),
		@DetalleTipo			varchar(20),
		@Articulo				varchar(20),
		@Servicio				varchar(20),
		@Cantidad				float,
		@ContID					int,
		@Renglon				float,
		@SubProducto			varchar(50),
		@SubCuenta				varchar(50),
		@ArtTipo	         	varchar(20),
		@VolverAfectar			int,
		@RenglonID				int,
		@Merma					float,
		@Unidad					varchar(50),
		@RenglonTipo			char(1),
		@Desperdicio			float,
		@CantidadInventario		float,
		@Costo					float,
		@MovIDGenerar			varchar(20),
		@CantidadArt			float,
		@FechaEntrega			datetime,
		@Juego					varchar	(10),
		@RenglonJgo				float,
		@Opcion					varchar (20),
		@FechaRequerida			datetime,
		@AccionSAUX				varchar(20)

		
    		     
    IF @Accion = 'CANCELAR'
    BEGIN
	  SELECT @IDGenerar = NULL
      IF @Modulo = 'VTAS'
	    SELECT @IDGenerar = s.ID, @MovDestino = s.Mov, @MovIDDestino = s.MovID
	      FROM SAUX s
	      JOIN Venta v 
	        ON s.OrigenTipo = @Modulo
	       AND s.Origen = v.Mov 
	       AND s.OrigenID = v.MovID
	       AND s.Empresa = v.Empresa
	     WHERE s.OrigenTipo = @Modulo 
	       AND s.Origen = @Mov 
	       AND s.OrigenID = @MovID
	       AND s.Empresa = @Empresa
      ELSE
      IF @Modulo = 'COMS'
	    SELECT @IDGenerar = s.ID, @MovDestino = s.Mov, @MovIDDestino = s.MovID
	      FROM SAUX s
	      JOIN Compra v 
	        ON s.OrigenTipo = @Modulo
	       AND s.Origen = v.Mov 
	       AND s.OrigenID = v.MovID
	       AND s.Empresa = v.Empresa
	     WHERE s.OrigenTipo = @Modulo 
	       AND s.Origen = @Mov 
	       AND s.OrigenID = @MovID
	       AND s.Empresa = @Empresa
      
	   	  
	  IF @IDGenerar IS NOT NULL
        EXEC spAfectar @ModuloDestino, @IDGenerar, @Accion, 'Todo', NULL, @Usuario, @@SPID, @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT 	         	         

	  RETURN
	END

	SELECT @Renglon = 0.0, @RenglonID = 0
	IF @Ok IS NULL
	  IF @Modulo = 'VTAS'
	    INSERT SAUX (Empresa,  Sucursal,   Usuario,  Mov,         MovID, Contacto,   EnviarA,   FechaEmision,  FechaEntrega,   Concepto,   Proyecto,   Referencia,   Observaciones,   Estatus,       Situacion,   SituacionFecha,   SituacionUsuario,   SituacionNota,   Origen, OrigenID, OrigenTipo, UltimoCambio, TipoContacto, UEN)
 	    SELECT       @Empresa, v.Sucursal, @Usuario, @MovDestino, NULL,  v.Cliente, v.EnviarA, @FechaEmision, v.FechaEntrega, v.Concepto, v.Proyecto, v.Referencia, v.Observaciones, 'SINAFECTAR',  v.Situacion, v.SituacionFecha, v.SituacionUsuario, v.SituacionNota, @Mov,   @MovID,   @Modulo,    @FechaEmision, 'Cliente',    UEN
	      FROM Venta v
         WHERE v.ID = @ID
      ELSE
	  IF @Modulo = 'COMS'
	    INSERT SAUX (Empresa,  Sucursal,   Usuario,  Mov,         MovID, Contacto,     FechaEmision,  FechaEntrega,   Concepto,   Proyecto,   Referencia,   Observaciones,   Estatus,       Situacion,   SituacionFecha,   SituacionUsuario,   SituacionNota,   Origen, OrigenID, OrigenTipo, UltimoCambio, TipoContacto, UEN)
 	    SELECT       @Empresa, v.Sucursal, @Usuario, @MovDestino, NULL,  v.Proveedor, @FechaEmision, v.FechaEntrega, v.Concepto, v.Proyecto, v.Referencia, v.Observaciones, 'SINAFECTAR',  v.Situacion, v.SituacionFecha, v.SituacionUsuario, v.SituacionNota, @Mov,   @MovID,   @Modulo,    @FechaEmision, 'Proveedor',  UEN
	      FROM Compra v
         WHERE v.ID = @ID
            
      SELECT @IDGenerar = @@IDENTITY

    IF @Modulo = 'VTAS'
	  DECLARE crArticulo CURSOR FOR
	   SELECT d.Articulo, d.SubCuenta, d.Cantidad, v.FechaEntrega
	     FROM VentaD d
	     JOIN Venta v	 ON v.ID = d.ID
	    WHERE d.ID = @ID
	ELSE
    IF @Modulo = 'COMS'
	  DECLARE crArticulo CURSOR FOR
	   SELECT d.Articulo, d.SubCuenta, d.Cantidad, v.FechaEntrega
	     FROM CompraD d
	     JOIN Compra v	 ON v.ID = d.ID
	    WHERE d.ID = @ID	
	OPEN crArticulo
	FETCH NEXT FROM crArticulo INTO @Articulo, @SubProducto, @CantidadArt, @FechaEntrega
	WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
	BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
	  BEGIN
	    DECLARE crDetalle CURSOR FOR
	     SELECT Servicio, ISNULL(Cantidad,1) * @CantidadArt
		   FROM SAUXArtServicio
		  WHERE Articulo = @Articulo
		OPEN crDetalle
		FETCH NEXT FROM crDetalle INTO @Servicio, @Cantidad
		WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL AND ISNULL(@Cantidad, 0) <> 0
		BEGIN
	      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
	      BEGIN
			SELECT @Renglon = @Renglon + 2048.0
			IF @Modulo = 'VTAS'
	          SELECT TOP 1 @FechaRequerida = FechaRequerida FROM VentaD WHERE ID = @ID AND Articulo = @Articulo
            ELSE
			IF @Modulo = 'COMS'
	          SELECT TOP 1 @FechaRequerida = FechaRequerida FROM CompraD WHERE ID = @ID AND Articulo = @Articulo
	        
			INSERT SAUXD (ID,         Renglon, Producto,  SubProducto,  Servicio,  Codigo, Cantidad,  CantidadPendeiente, CantidadCancelada, CantidadA, FechaRequerida, FechaInicio, FechaFin,  FechaEntrega, Observaciones, Prioridad,       Estado, Aplica, AplicaID)
				 VALUES (@IDGenerar, @Renglon, @Articulo, @SubProducto, @Servicio, NULL,   @Cantidad, @Cantidad,          0,                 NULL,      NULL,           NULL,        NULL,     @FechaEntrega, NULL,          'Normal',  'SINAFECTAR',   @Mov,   @MovID)

	        UPDATE SAUXD SET FechaRequerida = @FechaRequerida WHERE ID = @IDGenerar AND Renglon = @Renglon
				 
	      END
	      FETCH NEXT FROM crDetalle INTO @Servicio, @Cantidad
		END
		CLOSE crDetalle
		DEALLOCATE crDetalle

      END
      FETCH NEXT FROM crArticulo INTO @Articulo, @SubProducto, @CantidadArt, @FechaEntrega
	END
	CLOSE crArticulo
	DEALLOCATE crArticulo

	IF @Accion = 'RESERVARPARCIAL'
	  SET @AccionSAUX = 'AFECTAR'
	ELSE
	  SET @AccionSAUX = @Accion

	IF ISNULL(@Renglon,0) = 0
	  DELETE Inv WHERE ID = @IDGenerar
	ELSE
	IF @Ok IS NULL
      EXEC spAfectar @Modulo = @ModuloDestino, @ID = @IDGenerar, @Accion = @AccionSAUX, @Base = 'Todo', @GenerarMov = NULL,
                     @Usuario = @Usuario ,@Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
                                          
--SELECT @Ok = 1
  END    
  GO  


/**************** spSAUXGenerarInv ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSAUXGenerarInv') and type = 'P') drop procedure dbo.spSAUXGenerarInv
GO
CREATE PROCEDURE spSAUXGenerarInv
		    @Modulo			varchar(5),
    		@ID		        int,			
 		    @Accion			varchar(20),
    		@Empresa        varchar(5),
		    @Sucursal		int,
		    @Usuario		varchar(10),
		    @Mov			varchar(20),
            @MovID			varchar(20),
            @Estatus		varchar(15),
		    @MovTipo		varchar(20),
		    @Almacen		varchar(10),
		    @FechaEmision	datetime,
		    @ModuloDestino	varchar(5),
		    @MovDestino		varchar(20),
		    
    		@Ok             int           	OUTPUT,
    		@OkRef          varchar(255)  	OUTPUT
   
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
		@CfgMultiUnidades		bit,
		@CfgMultiUnidadesNivel	char(20),
		@Moneda					varchar(10),
		@TipoCambio				float,
		@TipoCosteo				varchar(20),
		@IDGenerar				int,
		@MovIDDestino			varchar(20),
		@DetalleTipo			varchar(20),
		@Articulo				varchar(20),
		@Material				varchar(20),
		@Cantidad				float,
		@ContID					int,
		@Renglon				float,
		@SubProducto			varchar(50),
		@SubCuenta				varchar(50),
		@ArtTipo	         	varchar(20),
		@VolverAfectar			int,
		@RenglonID				int,
		@Merma					float,
		@Unidad					varchar(50),
		@RenglonTipo			char(1),
		@Desperdicio			float,
		@CantidadInventario		float,
		@Costo					float,
		@MovIDGenerar			varchar(20),
		@IDOrigenModulo			int,
		@CantidadArt			float,
		@Juego					varchar	(10),
		@RenglonJgo				float,
		@Opcion					varchar (20),
		@Origen					varchar (20),
		@OrigenID				varchar (20),
		@IDOrigen				int,
        @EstatusOrigen			varchar(15),
        @OrigenTipo				char(5),

		@OrigenSAUX				varchar (20),
		@OrigenIDSAUX			varchar (20),
        @OrigenTipoSAUX			char(5),
        @OrigenSS				varchar (20),
		@OrigenIDSS				varchar (20),
		@SucursalAlmacen		int,
		@AlmacenSucursal		varchar(10)

		
    SELECT @Origen = Origen,
		   @OrigenID = OrigenID,
		   @OrigenTipo = OrigenTipo
      FROM SAUX 
     WHERE ID = @ID
 
    SELECT @OrigenSAUX = @Origen,
           @OrigenIDSAUX = @OrigenID,
           @OrigenTipoSAUX = @OrigenTipo
     
    IF @MovTipo = 'SAUX.S'    
      SELECT @IDOrigen = ID,
		     @Origen = Origen,
  		     @OrigenID = OrigenID,
		     @OrigenTipo = OrigenTipo
        FROM SAUX 
       WHERE ID = (SELECT ID FROM SAUX WHERE Mov = @Origen AND MovID = @OrigenID AND Empresa = @Empresa)
      
    IF @OrigenTipo = 'VTAS'
      SELECT @IDOrigenModulo = ID FROM Venta WHERE Mov = @Origen AND MovID = @OrigenID

    IF @OrigenTipo = 'COMS'
      SELECT @IDOrigenModulo = ID FROM Compra WHERE Mov = @Origen AND MovID = @OrigenID
      
--SELECT @Origen, @OrigenID, @OrigenTipo, @IDOrigenModulo, @IDOrigen

    SELECT @CfgMultiUnidades         = MultiUnidades,
		   @CfgMultiUnidadesNivel    = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
	  FROM EmpresaCfg2 
     WHERE Empresa = @Empresa
     
    SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
	SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
	SELECT @TipoCosteo = ISNULL(NULLIF(RTRIM(UPPER(TipoCosteo)), ''), 'PROMEDIO')
	  FROM EmpresaCfg
	 WHERE Empresa = @Empresa

    IF @Accion = 'CANCELAR'
    BEGIN
	  SELECT @IDGenerar = NULL
	  
	  DECLARE crCancelar CURSOR FOR
	   SELECT ID, Mov, MovID
	    FROM Inv
	   WHERE OrigenTipo = @Modulo 
	     AND Origen = @Mov 
	     AND OrigenID = @MovID 
	     AND Estatus IN ('CONCLUIDO', 'PENDIENTE')
	     AND Empresa = @Empresa
  
	  OPEN crCancelar
      FETCH NEXT FROM crCancelar INTO @IDGenerar, @MovDestino, @MovIDDestino
	  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
	    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
	    BEGIN

	      IF @IDGenerar IS NOT NULL
	        EXEC spInv @IDGenerar, @ModuloDestino, 'CANCELAR', 'TODO', @FechaEmision, NULL, @Usuario, 1, 0, NULL, 
			    	   @MovDestino, @MovIDDestino OUTPUT, @IDGenerar, @ContID, 
				       @Ok OUTPUT, @OkRef OUTPUT, @VolverAfectar OUTPUT
	    END
	          
	    FETCH NEXT FROM crCancelar INTO @IDGenerar, @MovDestino, @MovIDDestino
	          
	  END
      CLOSE crCancelar
      DEALLOCATE crCancelar


--if @ok IN (NULL, 80030) select @Ok = 1 -- breakpoint							   
	  RETURN
	END
   
    IF (SELECT COUNT(*) FROM ArtMaterial WHERE Articulo IN (SELECT Producto FROM SAUXD WHERE ID = @ID GROUP BY Producto) AND ISNULL(Cantidad,0) < 1) > 0 AND @Ok IS NULL
    BEGIN      
      SELECT @Ok = 25315, @OkRef = (SELECT TOP 1 Articulo FROM ArtMaterial WHERE Articulo IN (SELECT Producto FROM SAUXD WHERE ID = @ID GROUP BY Producto) AND ISNULL(Cantidad,0) < 1) + ' - ' + (SELECT TOP 1 Material FROM ArtMaterial WHERE Articulo IN (SELECT Producto FROM SAUXD WHERE ID = @ID GROUP BY Producto) AND ISNULL(Cantidad,0) < 1)
    END

    IF (SELECT COUNT(*) FROM ArtMaterial WHERE Articulo IN (SELECT Producto FROM SAUXD WHERE ID = @ID GROUP BY Producto) AND ISNULL(NULLIF(LugarConsumo,''),'(Sol. Pendiente)') = '(Sol. Pendiente)') > 0
      IF @MovTipo = 'SAUX.SS' 
        IF @Estatus = 'PENDIENTE' AND @Accion = 'AFECTAR'
          SELECT @MovDestino = NULL
	    ELSE
	     RETURN

	    SELECT @IDOrigen = ID,
	           @EstatusOrigen = Estatus
	      FROM SAUX 
	     WHERE Mov = (SELECT Origen FROM SAUX WHERE Mov = @Mov AND MovID = @MovID AND Empresa = @Empresa)
	       AND MovID = (SELECT OrigenID FROM SAUX WHERE Mov = @Mov AND MovID = @MovID AND Empresa = @Empresa)
	       AND Estatus IN ('CONCLUIDO', 'PENDIENTE')
	       AND Empresa = @Empresa


--SELECT @Origen, @OrigenID, @ID, @Modulo, @MovTipo, @Mov, @IDOrigenModulo, @IDOrigen, @EstatusOrigen

    IF @EstatusOrigen = 'CONCLUIDO'
  	  DECLARE crEncabezado CURSOR FOR
	   SELECT DISTINCT m.Almacen, CASE WHEN m.LugarConsumo = '(Sol. Concluida)' THEN (SELECT TOP 1 SAUXMovInvConcluida FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'SAUX.SS') ELSE (SELECT Movimiento FROM SAUXServicio WHERE Servicio = m.LugarConsumo) END
	     FROM SAUXD d JOIN ArtMaterial m
	       ON d.Producto = m.Articulo JOIN Art a 
	       ON a.Articulo = m.Articulo JOIN SAUXServicio s
	       ON d.Servicio = s.Servicio	     
        WHERE m.Articulo IN (CASE WHEN @OrigenTipo = 'VTAS' THEN (SELECT d.Articulo FROM VentaD d JOIN Art a ON a.Articulo = d.Articulo WHERE ID = @IDOrigenModulo AND a.Tipo = 'Servicio' AND a.SAUX = 1)
							                                ELSE (SELECT d.Articulo FROM CompraD d JOIN Art a ON a.Articulo = d.Articulo WHERE ID = @IDOrigenModulo AND a.Tipo = 'Servicio' AND a.SAUX = 1)END)
          AND m.Material NOT IN ((SELECT Articulo FROM dbo.fnSAUXArticuloNoDisponibleSolConcluida(@Empresa, @Origen, @OrigenID, @OrigenSAUX, @OrigenIDSAUX, m.Cantidad)))		  
    ELSE
    IF @MovTipo = 'SAUX.SS'
  	  DECLARE crEncabezado CURSOR FOR
	   SELECT DISTINCT m.Almacen, CASE WHEN ISNULL(NULLIF(m.LugarConsumo,''),'(Sol. Pendiente)') = '(Sol. Pendiente)' THEN (SELECT TOP 1 SAUXMovInvPendiente FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'SAUX.SS') END
	     FROM SAUXD d JOIN ArtMaterial m
	       ON d.Producto = m.Articulo JOIN Art a 
	       ON a.Articulo = m.Articulo JOIN SAUXServicio s
	       ON d.Servicio = s.Servicio
        WHERE m.Articulo IN (CASE WHEN @OrigenTipo = 'VTAS' THEN (SELECT d.Articulo FROM VentaD d JOIN Art a ON a.Articulo = d.Articulo WHERE ID = @IDOrigenModulo AND a.Tipo = 'Servicio' AND a.SAUX = 1)
															ELSE (SELECT d.Articulo FROM CompraD d JOIN Art a ON a.Articulo = d.Articulo WHERE ID = @IDOrigenModulo AND a.Tipo = 'Servicio' AND a.SAUX = 1)END)
		  AND ISNULL(NULLIF(m.LugarConsumo,''),'(Sol. Pendiente)') = '(Sol. Pendiente)'

    ELSE
 	IF @MovTipo = 'SAUX.S'
  	  DECLARE crEncabezado CURSOR FOR
	   SELECT DISTINCT Almacen, CASE WHEN LugarConsumo = '(Sol. Concluida)' THEN (SELECT TOP 1 SAUXMovInvConcluida FROM MovTipo WHERE Modulo = @Modulo AND Clave = 'SAUX.SS') ELSE (SELECT Movimiento FROM SAUXServicio WHERE Servicio = LugarConsumo) END
         FROM ArtMaterial
        WHERE Articulo IN (CASE WHEN @OrigenTipo = 'VTAS' THEN (SELECT d.Articulo FROM VentaD d JOIN Art a ON a.Articulo = d.Articulo WHERE ID = @IDOrigenModulo AND a.Tipo = 'Servicio' AND a.SAUX = 1)
                                                          ELSE (SELECT d.Articulo FROM CompraD d JOIN Art a ON a.Articulo = d.Articulo WHERE ID = @IDOrigenModulo AND a.Tipo = 'Servicio' AND a.SAUX = 1)END)
          AND LugarConsumo in (        
							   SELECT DISTINCT s.Servicio
	                             FROM SAUXD d JOIN Art a 
	                               ON a.Articulo = d.Producto JOIN SAUXServicio s
	                               ON d.Servicio = s.Servicio	     
                                WHERE d.Producto IN (CASE WHEN @OrigenTipo = 'VTAS' THEN (SELECT d.Articulo FROM VentaD d JOIN Art a ON a.Articulo = d.Articulo WHERE ID = @IDOrigenModulo AND a.Tipo = 'Servicio' AND a.SAUX = 1)
																					ELSE (SELECT d.Articulo FROM CompraD d JOIN Art a ON a.Articulo = d.Articulo WHERE ID = @IDOrigenModulo AND a.Tipo = 'Servicio' AND a.SAUX = 1)END)
		                          AND d.ID = @ID
		                       )

	OPEN crEncabezado
    FETCH NEXT FROM crEncabezado INTO @Almacen, @MovDestino
	WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
	BEGIN
	  IF @@FETCH_STATUS <> -2 AND @Ok IS NULL AND @MovDestino IS NOT NULL
      BEGIN
      
	    SELECT @DetalleTipo = 'Salida', @Renglon = 0.0, @RenglonID = 0
	    SELECT @SucursalAlmacen = Sucursal FROM Alm WHERE Almacen = @Almacen
	    
	    IF @SucursalAlmacen <> @Sucursal
	      SELECT @AlmacenSucursal = AlmacenPrincipal FROM Sucursal WHERE Sucursal = @Sucursal
	    ELSE
	      SELECT @AlmacenSucursal = @Almacen

        IF NULLIF(@AlmacenSucursal,'') IS NULL SET @OK = 10570
        
	    IF @OrigenTipo = 'VTAS' AND @OK IS NULL
	      INSERT Inv (OrigenTipo, Origen, OrigenID, Empresa,  Usuario,  Estatus,      Mov,         FechaEmision,  Proyecto,   Moneda,   TipoCambio,   Referencia,   Observaciones,   Prioridad,   Almacen,          Directo, VerLote, UEN,   Concepto)
	           SELECT @Modulo,    @Mov,   @MovID,   @Empresa, @Usuario, 'SINAFECTAR', @MovDestino, @FechaEmision, v.Proyecto, v.Moneda, m.TipoCambio, v.Referencia, v.Observaciones, v.Prioridad, @AlmacenSucursal, 0,       1,       v.UEN, v.Concepto
	        FROM Venta v, Mon m
           WHERE m.Moneda = v.Moneda AND v.ID = @IDOrigenModulo
        ELSE
	    IF @OrigenTipo = 'COMS' AND @OK IS NULL
	      INSERT Inv (OrigenTipo, Origen, OrigenID, Empresa,  Usuario,  Estatus,      Mov,         FechaEmision,  Proyecto,   Moneda,   TipoCambio,   Referencia,   Observaciones,   Prioridad,   Almacen,          Directo, VerLote, UEN,   Concepto)
	           SELECT @Modulo,    @Mov,   @MovID,   @Empresa, @Usuario, 'SINAFECTAR', @MovDestino, @FechaEmision, v.Proyecto, v.Moneda, m.TipoCambio, v.Referencia, v.Observaciones, v.Prioridad, @AlmacenSucursal, 0,       1,       v.UEN, v.Concepto
	        FROM Compra v, Mon m
           WHERE m.Moneda = v.Moneda AND v.ID = @IDOrigenModulo        
         
        SELECT @IDGenerar = @@IDENTITY

		IF @OrigenTipo = 'VTAS'		
	      DECLARE crArticulo CURSOR FOR	
	       SELECT d.Articulo, d.SubCuenta, d.Cantidad
	         FROM VentaD d
	         JOIN Art a ON a.Articulo = d.Articulo
	        WHERE ID = @IDOrigenModulo
		      AND a.Tipo = 'Servicio'
		      AND a.SAUX = 1
        ELSE
		IF @OrigenTipo = 'COMS'		
	      DECLARE crArticulo CURSOR FOR	
	       SELECT d.Articulo, d.SubCuenta, d.Cantidad
	         FROM CompraD d
	         JOIN Art a ON a.Articulo = d.Articulo
	        WHERE ID = @IDOrigenModulo
		      AND a.Tipo = 'Servicio'
		      AND a.SAUX = 1
        
	    OPEN crArticulo
	    FETCH NEXT FROM crArticulo INTO @Articulo, @SubProducto, @CantidadArt
	    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
	    BEGIN
          IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
	      BEGIN
	        SELECT @OrigenSS = NULL, @OrigenIDSS = NULL
	        SELECT @OrigenSS = Origen,
	               @OrigenIDSS = OrigenID 
	          FROM SAUX 
	         WHERE ID = @ID

 	        IF @MovTipo = 'SAUX.SS'
	          DECLARE crDetalle CURSOR FOR
	           SELECT m.Material, m.SubCuenta, ISNULL(m.Cantidad,1) * @CantidadArt, m.Merma, m.Desperdicio, m.Unidad, m.Almacen
		         FROM ArtMaterial m
		         JOIN Art a ON a.Articulo = m.Articulo
		        WHERE m.Articulo = @Articulo
		          AND ISNULL(NULLIF(m.LugarConsumo,''), '(Sol. Pendiente)') = '(Sol. Pendiente)'
		          AND m.Almacen = @Almacen
	    
	        ELSE
	        IF @EstatusOrigen = 'CONCLUIDO'
	          DECLARE crDetalle CURSOR FOR
	           SELECT m.Material, m.SubCuenta, ISNULL(m.Cantidad,1) * @CantidadArt, m.Merma, m.Desperdicio, m.Unidad, m.Almacen
		         FROM ArtMaterial m
		         JOIN Art a ON a.Articulo = m.Articulo
		        WHERE m.Articulo = @Articulo
		          AND m.Almacen = @Almacen
				  AND m.Material NOT IN ((SELECT Articulo FROM dbo.fnSAUXArticuloNoDisponibleServicioConcluido(@Empresa, @Origen, @OrigenID, @OrigenSAUX, @OrigenIDSAUX, @OrigenSS, @OrigenIDSS, m.Cantidad)))
	        ELSE
 	        IF @MovTipo = 'SAUX.S'	        
	          DECLARE crDetalle CURSOR FOR
	           SELECT m.Material, m.SubCuenta, ISNULL(m.Cantidad,1) * @CantidadArt, m.Merma, m.Desperdicio, m.Unidad, m.Almacen
		         FROM ArtMaterial m
		         JOIN Art a ON a.Articulo = m.Articulo
		        WHERE m.Articulo = @Articulo
		          AND m.Almacen = @Almacen
		          AND m.LugarConsumo IN (SELECT Servicio FROM dbo.fnSAUXArticuloNoDisponibleServicio(@Empresa, @IDOrigen, @Origen, @OrigenID, @Articulo, @ID))
	    
		    OPEN crDetalle
		    FETCH NEXT FROM crDetalle INTO @Material, @SubCuenta, @Cantidad, @Merma, @Desperdicio, @Unidad, @Almacen
		    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL AND ISNULL(@Cantidad, 0) <> 0
		    BEGIN
	          IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
	          BEGIN

			    EXEC xpCantidadInventario @Material, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
			    SELECT @ArtTipo = Tipo
		          FROM Art 
			     WHERE Articulo = @Material

			    EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
			    SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
                SELECT @Costo = NULL
                EXEC spVerCosto @Sucursal, @Empresa, NULL, @Material, @SubCuenta, @Unidad, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0
                
                SELECT @SucursalAlmacen = Sucursal FROM Alm WHERE Almacen = @Almacen
                
                IF @SucursalAlmacen <> @Sucursal
                  SELECT @AlmacenSucursal = AlmacenPrincipal FROM Sucursal WHERE Sucursal = @Sucursal
                ELSE
                  SELECT @AlmacenSucursal = @Almacen
                
                IF NULLIF(@AlmacenSucursal,'') IS NULL SET @OK = 10570

                IF @AlmacenSucursal = '(Demanda)' SELECT @OK = 20830, @OkRef = @AlmacenSucursal + ' ' + @Material + ' ' + @SubCuenta
            
                IF @Ok IS NULL
			      INSERT InvD (ID,     Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Aplica, AplicaID, Almacen,         Producto,  SubProducto,  ProdSerieLote,             Articulo,  SubCuenta,  Cantidad,  Merma,  Desperdicio,  Unidad,  CantidadInventario,  Factor, Tipo,         Costo)
			  	  VALUES (@IDGenerar, @Renglon, 0,          @RenglonID, @RenglonTipo, @Mov,   @MovID,   @AlmacenSucursal, @Articulo, @SubProducto,  @Origen + ' ' + @OrigenID, @Material, @SubCuenta, @Cantidad, @Merma, @Desperdicio, @Unidad, @CantidadInventario, 1,	     @DetalleTipo, @Costo)
	          END
	          
	          FETCH NEXT FROM crDetalle INTO @Material, @SubCuenta, @Cantidad, @Merma, @Desperdicio, @Unidad, @Almacen
	          
		    END
		    CLOSE crDetalle
		    DEALLOCATE crDetalle

          END
          FETCH NEXT FROM crArticulo INTO @Articulo, @SubProducto, @CantidadArt
	    END
	    CLOSE crArticulo
	    DEALLOCATE crArticulo       

	    IF NOT EXISTS(SELECT * FROM InvD WHERE ID = @IDGenerar)
	    BEGIN
	      DELETE InvD WHERE ID = @IDGenerar
	      DELETE Inv WHERE ID = @IDGenerar
	    END
	    ELSE
	    IF @Ok IS NULL
	    BEGIN
	
	      EXEC spInv @IDGenerar, @ModuloDestino, @Accion, 'TODO', @FechaEmision, NULL, @Usuario, 1, 0, NULL, 
                     @MovDestino, @MovIDGenerar OUTPUT, NULL, NULL, 
                     @Ok OUTPUT, @OkRef OUTPUT
                    
	      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @ModuloDestino, @IDGenerar, @MovDestino, @MovIDGenerar, @Ok OUTPUT
	    END	    

	  END
	FETCH NEXT FROM crEncabezado INTO @Almacen, @MovDestino
    END
	CLOSE crEncabezado
	DEALLOCATE crEncabezado

--SELECT * FROM Inv WHERE ID = @IDGenerar
--if @ok IN (NULL, 80030) select @Ok = 1 -- breakpoint
  END    
  GO
--/* DEMO */ spAfectar 'VTAS', 3467, 'AFECTAR', 'Todo', NULL, 'DEMO', @Estacion=1



/**************** spFlujoSAUX ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFlujoSAUX') and type = 'P') drop procedure dbo.spFlujoSAUX
GO
CREATE PROCEDURE spFlujoSAUX
		    @Modulo			varchar(5),
    		@ID		        int,			
 		    @Accion			varchar(20),
 		    @Base			varchar(20),
 		    @MovGenerar		char(20),
 		    @FechaRegistro	datetime,
    		@Empresa        varchar(5),
		    @Sucursal		int,
		    @Usuario		varchar(10),
		    @Conexion		bit,
		    @SincroFinal	bit,
		    @Mov			varchar(20),
            @MovID			varchar(20),
		    @MovTipo		varchar(20),
		    @Almacen		varchar(10),
		    @FechaEmision	datetime,
		    @Proyecto	    varchar(50),

    		@Ok             int           	OUTPUT,
    		@OkRef          varchar(255)  	OUTPUT
   
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
		@ModuloDestino			varchar(5),
		@MovDestino				varchar(20),
		@ModuloOrigen			varchar(20),
		@Estatus				varchar(20),
		@EstatusGenerar			varchar(20),
		@Articulo				varchar(20),
		@Material				varchar(20),
		@Cantidad				float,
		@IDGenerar				int,
		@Renglon				float,
		@RenglonID				int,
		@Merma					float,
		@Desperdicio			float,
		@Unidad					varchar(50),
		@MovIDGenerar			varchar(20),
		@IDCancelar				int,
		@MovIDDestino			varchar(20),
		@Moneda					varchar(10),
		@TipoCambio				float,
		@TipoCosteo				varchar(20),
		@Costo					float,
		@CfgMultiUnidades		bit,
		@CfgMultiUnidadesNivel	char(20),
		@ContID					int,
		@VolverAfectar			int,
		@ArtTipo	         	varchar(20),
		@SubCuenta				varchar(50),
		@Factor					float,
		@CantidadInventario		float,
		@RenglonTipo			char(1),
		@DetalleTipo			varchar(20),
		@SubProducto			varchar(50),
		@MovSS					varchar(20),
		@MovIDSS				varchar(20),
		@IDSS					int,
		@DID					int,
		@EstatusD				varchar(20)
                       
  IF @Modulo = 'INV'
    SELECT @Estatus = Estatus FROM Inv WHERE ID = @ID


  SELECT TOP 1
		 @MovDestino = ISNULL(RTRIM(LTRIM(SAUXMov)),''),
         @ModuloDestino = 'SAUX'
    FROM MovTipo 
   WHERE Mov = @Mov 
     AND Modulo = @Modulo 
     AND Clave = @MovTipo

--  SELECT @ModuloDestino, @Modulo, @MovDestino
  
  IF @Modulo = 'VTAS' AND NOT EXISTS(SELECT * FROM Art WHERE Articulo IN (SELECT Articulo FROM VentaD WHERE ID = @ID)AND SAUX = 1 AND Tipo = 'Servicio')  
    RETURN
  ELSE
  IF @Modulo = 'COMS' AND NOT EXISTS(SELECT * FROM Art WHERE Articulo IN (SELECT Articulo FROM CompraD WHERE ID = @ID)AND SAUX = 1 AND Tipo = 'Servicio')
    RETURN    
  ELSE
  IF @ModuloDestino = 'SAUX' AND @Modulo IN ('VTAS', 'COMS') AND @MovDestino <> ''
  BEGIN  
  
    SELECT @IDSS = s.ID,
           @MovSS = s.Mov,
           @MovIDSS = s.MovID
	  FROM SAUX s
	  JOIN Venta v 
	    ON s.OrigenTipo = @Modulo
	   AND s.Origen = v.Mov 
	   AND s.OrigenID = v.MovID 
	   AND s.Empresa = v.Empresa
     WHERE s.OrigenTipo = @Modulo
       AND s.Origen = @Mov 
       AND s.OrigenID = @MovID
       AND s.Empresa = @Empresa


     IF EXISTS(SELECT * FROM SAUX WHERE Origen = @MovSS AND OrigenID = @MovIDSS AND Estatus <> 'CANCELADO') AND @Accion = 'CANCELAR'
       SELECT @Ok = 60060

    IF @Accion = 'CANCELAR'
    BEGIN
      IF @Modulo = 'COMS'
        SELECT @DID = DID FROM MovFlujo WHERE OID = @ID AND OModulo = 'COMS' AND DModulo = 'SAUX'

      IF @Modulo = 'VTAS'
        SELECT @DID = DID FROM MovFlujo WHERE OID = @ID AND OModulo = 'VTAS' AND DModulo = 'SAUX'
      
      SELECT @EstatusD = Estatus FROM SAUX WHERE ID = @DID
      IF @EstatusD = 'CONCLUIDO'
        SELECT @OK = 60060, @OkRef = RTRIM(@Mov)+' '+LTRIM(Convert(char, @MovID))
    END

    IF @Ok IS NULL
      EXEC spSAUXGenerar @Modulo, @ID, @Accion, @Base, @FechaRegistro, @MovGenerar, @Empresa, @Sucursal, @Usuario, @Conexion, @SincroFinal, @Mov, @MovID, @MovTipo, @Almacen, @FechaEmision, @ModuloDestino, @MovDestino, @Ok OUTPUT, @OkRef OUTPUT
  END

  RETURN
END
GO

--/* DEMO */ spAfectar 'VTAS', 3415, 'AFECTAR', 'Todo', NULL, 'DEMO', @Estacion=2

/**************** spSAUXVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSAUXVerificar') and type = 'P') drop procedure dbo.spSAUXVerificar
GO
CREATE PROCEDURE spSAUXVerificar
    		@ID               	int,
		    @Accion				char(20),
    		@Empresa          	char(5),
		    @Usuario			char(10),
    		@Modulo	      		char(5),
    		@Mov              	char(20),
	        @MovID				varchar(20),
    		@MovTipo	      	char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @Almacen			char(10),
		    @Agente				varchar(10),

    		@Ok               	int          OUTPUT,
    		@OkRef            	varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Servicio			varchar(20), 
    @Cantidad			int,
    @Producto			varchar(20),
    @Indicador			varchar(20),
    @Valor				varchar(255),
    @Contacto			varchar(20)
    
  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END 

    -- Checar el Encabezado
  SELECT @Contacto = NULLIF(RTRIM(Contacto), '')         
    FROM SAUX
   WHERE ID = @ID

  IF @contacto IS NULL SELECT @Ok = 40010

    -- Checar el Detalle
  IF NOT EXISTS (SELECT * FROM SAUXD d WHERE d.ID = @ID) AND @Ok IS NULL
    SELECT @Ok = 60010

  IF @Ok IS NULL
  BEGIN
    DECLARE crVerificarSAUXD CURSOR LOCAL FOR 
     SELECT NULLIF(RTRIM(d.Servicio), ''), ISNULL(d.Cantidad, 0), NULLIF(RTRIM(d.Producto), '')
       FROM SAUXD d
      WHERE d.ID = @ID
    OPEN crVerificarSAUXD
    FETCH NEXT FROM crVerificarSAUXD INTO @Servicio, @Cantidad, @Producto
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Servicio IS NULL OR NOT EXISTS (SELECT * FROM SAUXServicio WHERE Servicio = @Servicio) SELECT @Ok = 75010 ELSE
        IF @Cantidad IS NULL OR @Cantidad = '' SELECT @Ok = 20011 ELSE
        IF @Producto IS NULL OR NOT EXISTS(SELECT * FROM Art WHERE Articulo = @Producto) SELECT @Ok = 75020

--        IF NOT EXISTS (SELECT * FROM SAUXIndicador WHERE Indicador IN (SELECT Indicador FROM SAUXServIndicador WHERE Servicio = @Servicio)) AND @Ok IS NULL
--          SELECT @Ok = 75030

        IF @MovTipo = 'SAUX.S' AND @EstatusNuevo = 'CONCLUIDO' AND @Ok IS NULL
        BEGIN
          DECLARE crVerificarIndicador CURSOR LOCAL FOR 
           SELECT i.Indicador, s.Valor
             FROM SAUXIndicador i
             JOIN SAUXDIndicador s ON s.Indicador = i.Indicador AND s.ID = @ID AND s.Servicio = @Servicio
          OPEN crVerificarIndicador
          FETCH NEXT FROM crVerificarIndicador INTO @Indicador, @valor
          WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
          BEGIN
            IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
              IF dbo.fnValidarIndicadores(@ID, @Indicador, @Valor) = 1
                SELECT @Ok = 75040

            IF @Ok IS NOT NULL AND @OkRef IS NULL SELECT @OkRef = @Servicio
            FETCH NEXT FROM crVerificarIndicador INTO @Indicador, @valor
          END
          CLOSE crVerificarIndicador
          DEALLOCATE crVerificarIndicador
        END

      END
      IF @Ok IS NOT NULL AND @OkRef IS NULL SELECT @OkRef = @Servicio
      FETCH NEXT FROM crVerificarSAUXD INTO @Servicio, @Cantidad, @Producto
    END
    CLOSE crVerificarSAUXD
    DEALLOCATE crVerificarSAUXD
  END

  IF @MovTipo = 'SAUX.S' AND @EstatusNuevo = 'CONCLUIDO' AND @Ok IS NULL
    IF dbo.fnValidarIndicadoresID(@ID) = 1 SELECT @Ok = 75040  


--select @Ok = 1
  RETURN
END
GO


/**************** spSAUXAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSAUXAfectar') and type = 'P') drop procedure dbo.spSAUXAfectar
GO             
CREATE PROCEDURE spSAUXAfectar
    		   @ID                		int,

			   @Accion					char(20),
			   @Base					char(20),
    		   @Empresa	      			char(5),
    		   @Modulo	      			char(5),
    		   @Mov	  	      			char(20),
    		   @MovID             		varchar(20)	OUTPUT,
    		   @MovTipo     			char(20),
		       @MovMoneda				char(10),
		       @MovTipoCambio			float,
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
    		   @FechaConclusion			datetime,

    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      			char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Concepto     			varchar(50),
		       @Referencia				varchar(50),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      			int,
		       @MovUsuario				char(10),

		       @Conexion				bit,
               @SincroFinal				bit,
               @Sucursal				int,
               @SucursalDestino			int,
               @SucursalOrigen			int,

		       @CfgContX				bit,
		       @CfgContXGenerar			char(20),
		       @GenerarPoliza			bit,

		       @Generar					bit,
    		   @GenerarMov				char(20),
	           @GenerarAfectado			bit,
		       @IDGenerar				int	     	OUTPUT,	
    		   @GenerarMovID	  		varchar(20)	OUTPUT,

		       @Almacen					char(10), 
		       @Agente					varchar(10),

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CancelarID			int,
    @FechaCancelacion	datetime,
    @GenerarMovTipo		char(20),
    @GenerarPeriodo		int,
    @GenerarEjercicio	int,
    @ServicioEstatus	char(15),
    @Posicion			varchar(10), 
    @PosicionDestino	varchar(10),
    @AlmacenDetalle		varchar(10),
    
    @Renglon			int,
    @Producto			varchar(20), 
    @SubProducto		varchar(20),     
    @Servicio			varchar(20), 
    @Cantidad			int,
    @CantidadPendeiente	int,
    @CantidadCancelada	int,
    @Estado				varchar(15),
    @ModuloDestino		char(5),     
    @MovDestino			varchar(20),     
    @EstatusGenerar		char(15),
    @MovGenerar			varchar(20),
    @OrigenTipo			char(5),
    @Origen				varchar(20),
    @OrigenID			varchar(20),
    @IDOrigen			int,
    @EtapaDestino		varchar(20)
    
    
  IF @FechaRegistro IS NULL SELECT @FechaRegistro = GETDATE()  
  -- Asignar el Consecutivo al Movimiento
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  -- Generar Mov Nuevo
  IF @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, 'SINAFECTAR', 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT

    IF @Ok IS NULL
    BEGIN
    
      IF @Base = 'PENDIENTE'
        INSERT SAUXD (
               ID,         Renglon, Producto, SubProducto, Servicio, Codigo, Cantidad,			 CantidadPendeiente, CantidadCancelada, CantidadA, FechaRequerida, FechaInicio, FechaFin, FechaEntrega, Estado,       Observaciones, Prioridad)
        SELECT @IDGenerar, Renglon, Producto, SubProducto, Servicio, Codigo, CantidadPendeiente, CantidadPendeiente, CantidadCancelada, CantidadA, FechaRequerida, FechaInicio, FechaFin, FechaEntrega, 'SINAFECTAR', Observaciones, Prioridad 
          FROM SAUXD
         WHERE ID = @ID AND Estado IN ('PENDIENTE')
                 
      ELSE 
        INSERT SAUXD (
               ID,         Renglon, Producto, SubProducto, Servicio, Codigo, Cantidad,	CantidadPendeiente, CantidadCancelada, CantidadA, FechaRequerida, FechaInicio, FechaFin, FechaEntrega, Estado, Observaciones, Prioridad)
        SELECT @IDGenerar, Renglon, Producto, SubProducto, Servicio, Codigo, CantidadA, CantidadPendeiente, CantidadCancelada, 0,		  FechaRequerida, FechaInicio, FechaFin, FechaEntrega, 'SINAFECTAR', Observaciones, Prioridad 
          FROM SAUXD
         WHERE ID = @ID AND Estado IN ('PENDIENTE') AND CantidadA > 0

      IF @Base = 'PENDIENTE'
        UPDATE SAUXD SET CantidadA = 0 WHERE ID = @ID
  
      INSERT INTO SAUXDIndicador (ID, Renglon, Producto, Servicio, Indicador)
      SELECT d.ID, d.Renglon, d.Producto, d.Servicio, isnull(i.Indicador, '')
        FROM SAUXD d
        JOIN SAUXServIndicador s ON d.Servicio = s.Servicio
        JOIN SAUXIndicador i ON s.Indicador = i.Indicador        
        WHERE ID = @IDGenerar      
              
      IF @Ok IS NULL SELECT @Ok = 80030
    END

    RETURN
  END

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT


    -- Cancelar Movimientos Generados en el Mismo Modulo
    IF @Accion = 'CANCELAR'
    BEGIN
      DECLARE crSAUXCancelar CURSOR FOR
       SELECT ID
         FROM SAUX
        WHERE OrigenTipo = @Modulo 
          AND Origen = @Mov 
          AND OrigenID = @MovID 
          AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
          AND Empresa = @Empresa
      OPEN crSAUXCancelar
      FETCH NEXT FROM crSAUXCancelar INTO @CancelarID
      WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
          EXEC spAfectar @Modulo, @CancelarID, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

        FETCH NEXT FROM crSAUXCancelar INTO @CancelarID
      END
      CLOSE crSAUXCancelar
      DEALLOCATE crSAUXCancelar
    END

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			                     @Generar, @GenerarMov, @GenerarMovID, @IDGenerar, @Ok OUTPUT

    IF @Accion IN ('AFECTAR', 'CANCELAR') 
    BEGIN    
      DECLARE crAfectarSAUXD CURSOR LOCAL FOR 
       SELECT Renglon, ISNULL(RTRIM(d.Producto), ''), ISNULL(RTRIM(d.SubProducto), ''), ISNULL(RTRIM(d.Servicio), ''), ISNULL(d.Cantidad, 0) /*CASE WHEN ISNULL(d.CantidadA, 0) <= 0 THEN ISNULL(d.Cantidad, 0) ELSE ISNULL(d.CantidadA, 0) END*/, ISNULL(d.CantidadPendeiente, 0), ISNULL(d.CantidadCancelada, 0), ISNULL(d.Estado, 0), ISNULL(RTRIM(o.ID), ''), ISNULL(RTRIM(o.Mov), ''), ISNULL(RTRIM(o.MovID), '')
         FROM SAUXD d
         JOIN SAUX s ON d.ID = s.ID
         JOIN SAUX o ON s.Origen = o.Mov AND s.OrigenID = o.MovID
        WHERE d.ID = @ID
      OPEN crAfectarSAUXD
      FETCH NEXT FROM crAfectarSAUXD INTO @Renglon, @Producto, @SubProducto, @Servicio, @Cantidad, @CantidadPendeiente, @CantidadCancelada, @Estado, @IDOrigen, @Origen, @OrigenID
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          IF @CantidadPendeiente - @Cantidad < 1 AND @Accion = 'AFECTAR'
            UPDATE SAUXD 
               SET Estado = 'CONCLUIDO' 
             WHERE ID = @ID
               AND Producto =  @Producto 
		       AND ISNULL(SubProducto,'') = @SubProducto 
		       AND Servicio = @Servicio

		  IF @Accion = 'AFECTAR' AND @EstatusNuevo = 'CONCLUIDO'
		  BEGIN
		    UPDATE SAUXD SET CantidadPendeiente = ISNULL(CantidadPendeiente,0) - @Cantidad, CantidadA = 0
		     WHERE ID = @IDOrigen 
		       AND Estado = 'PENDIENTE' 
		       AND Producto =  @Producto 
		       AND ISNULL(SubProducto,'') = @SubProducto 
		       AND Servicio = @Servicio

		    UPDATE SAUXD 
		       SET Estado = 'CONCLUIDO'
		     WHERE ID = @IDOrigen 
		       AND Estado = 'PENDIENTE'
		       AND Producto =  @Producto 
		       AND ISNULL(SubProducto,'') = @SubProducto 
		       AND Servicio = @Servicio
		       AND ISNULL(CantidadPendeiente, 0) = 0		       

		  END       

		  IF @Accion = 'CANCELAR' AND @Estatus = 'CONCLUIDO'
		  BEGIN
            UPDATE SAUXD 
               SET Estado = @EstatusNuevo,
                   CantidadA = 0
             WHERE ID = @ID
		       AND Producto =  @Producto 
		       AND ISNULL(SubProducto,'') = @SubProducto 
		       AND Servicio = @Servicio

		    UPDATE SAUXD 
		       SET Estado = 'PENDIENTE',
		           CantidadPendeiente = ISNULL(CantidadPendeiente,0) + @Cantidad,
                   CantidadA = 0 
		     WHERE ID = @IDOrigen 
		       AND Producto =  @Producto 
		       AND ISNULL(SubProducto,'') = @SubProducto 
		       AND Servicio = @Servicio
		  END       

        IF @Ok IS NOT NULL AND @OkRef IS NULL SELECT @OkRef = @Servicio
        END
        FETCH NEXT FROM crAfectarSAUXD INTO @Renglon, @Producto, @SubProducto, @Servicio, @Cantidad, @CantidadPendeiente, @CantidadCancelada, @Estado, @IDOrigen, @Origen, @OrigenID
      END
      CLOSE crAfectarSAUXD
      DEALLOCATE crAfectarSAUXD
    
      -- Actualizar Movimiento
      IF @Ok IN (NULL, 80030)
      BEGIN
        IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
        IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
        IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
        BEGIN
	  IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
          IF @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
        END  

        EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE SAUX
           SET FechaConclusion  = @FechaConclusion, 
               FechaEntrega     = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
			   Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    IF @MovTipo = 'SAUX.SS' AND @Estatus = 'SINAFECTAR'
    BEGIN
      SELECT @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID FROM SAUX WHERE ID = @ID
      IF @OrigenTipo = 'VTAS'
        SELECT @IDOrigen = ID FROM Venta WHERE Mov = @Origen AND MovID = @OrigenID AND Empresa = @Empresa
      ELSE
      IF @OrigenTipo = 'COMS'
        SELECT @IDOrigen = ID FROM Compra WHERE Mov = @Origen AND MovID = @OrigenID AND Empresa = @Empresa
                   
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @OrigenTipo, @IDOrigen, @Origen, @OrigenID, 'SAUX', @ID, @Mov, @MovID, @Ok OUTPUT     
    END

    IF @MovTipo IN ('SAUX.S') AND @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR' AND @Ok IS NULL
       EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'SAUX', @IDOrigen, @Origen, @OrigenID, 'SAUX', @ID, @Mov, @MovID, @Ok OUTPUT
    
    IF @MovTipo IN ('SAUX.S') AND @Accion = 'AFECTAR' AND @EstatusNuevo = 'CONCLUIDO' AND @Ok IS NULL
    BEGIN
      SELECT @FechaConclusion  = GETDATE()  
      IF (SELECT COUNT(0) FROM SAUXD WHERE ID = @IDOrigen AND Estado <> 'CONCLUIDO') = 0
        UPDATE SAUX 
           SET FechaConclusion  = @FechaConclusion, 
               FechaEntrega     = @FechaConclusion,           
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN GETDATE() ELSE UltimoCambio END,
	           Estatus          = 'CONCLUIDO',--@EstatusNuevo,
               Situacion 	    = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END
       WHERE ID = @IDOrigen
    END

    IF @MovTipo IN ('SAUX.S') AND @Accion = 'CANCELAR' AND @Ok IS NULL
    BEGIN
      SELECT @FechaConclusion  = GETDATE()
	  IF EXISTS (SELECT * FROM SAUXD WHERE ID = @IDOrigen AND Estado = 'PENDIENTE')
	    UPDATE SAUX
		   SET FechaConclusion  = @FechaConclusion,
               FechaEntrega     = @FechaConclusion,		   
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN GETDATE() ELSE UltimoCambio END,
	           Estatus          = 'PENDIENTE',--@EstatusNuevo,
               Situacion 	    = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END
		 WHERE ID = @IDOrigen 
    END

    UPDATE SAUXD 
       SET Estado = @EstatusNuevo
     WHERE ID = @ID

    IF @EstatusNuevo = 'CONCLUIDO'
    BEGIN
      UPDATE SAUXD 
         SET FechaEntrega = @FechaConclusion 
       WHERE ID = @IDOrigen
         AND Estado = @EstatusNuevo
         AND FechaEntrega IS NULL
         
      UPDATE SAUX SET FechaEntrega = @FechaConclusion WHERE ID IN(@ID, @IDOrigen)
      UPDATE SAUXD SET FechaEntrega = @FechaConclusion WHERE ID = @ID
    END

    IF @EstatusNuevo = 'CANCELADO'
    BEGIN
      UPDATE SAUXD 
         SET FechaEntrega = NULL
       WHERE ID = @IDOrigen
         AND Estado <> 'CONCLUIDO'
         AND FechaEntrega IS NOT NULL
         
      UPDATE SAUX SET FechaEntrega = NULL WHERE ID IN(@ID, @IDOrigen)
      UPDATE SAUXD SET FechaEntrega = NULL WHERE ID = @ID                         

      IF (SELECT Estatus FROM  SAUX WHERE ID = @IDOrigen) = 'PENDIENTE'
        UPDATE SAUX SET FechaEntrega = (SELECT TOP 1 FechaEntrega FROM SAUXD WHERE ID = @IDOrigen AND FechaEntrega IS NOT NULL ORDER BY FechaEntrega DESC) WHERE ID = @IDOrigen
      
    END
    
    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT

    IF @Ok IS NULL
      EXEC spSAUXGenerarInv @Modulo, @ID, @Accion, @Empresa, @Sucursal, @Usuario, @Mov, @MovID, @EstatusNuevo, @MovTipo, @Almacen, @FechaEmision, 'INV', @MovDestino, @Ok OUTPUT, @OkRef OUTPUT

    
/*
SELECT * FROM  SAUX WHERE ID = @ID
SELECT * FROM  SAUXD WHERE ID = @ID

SELECT * FROM  SAUX WHERE ID = @IDOrigen
SELECT * FROM  SAUXD WHERE ID = @IDOrigen
*/

--if @Ok is null select @Ok = 1

  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION

  RETURN
END
GO


/**************** spSAUX ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSAUX') and type = 'P') drop procedure dbo.spSAUX
GO
CREATE PROCEDURE spSAUX
           @ID                  int,
    	   @Modulo	      		char(5),
		   @Accion				char(20),
		   @Base				char(20),
		   @FechaRegistro		datetime,		   
		   @GenerarMov			char(20),
		   @Usuario				char(10),
    	   @Conexion			bit,
		   @SincroFinal			bit,
    	   @Mov	      			char(20)	OUTPUT,
    	   @MovID            	varchar(20)	OUTPUT,
		   @IDGenerar			int			OUTPUT,

		   @Ok					int			OUTPUT,
		   @OkRef				varchar(255)OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Generar				bit,
    @GenerarAfectado		bit,
    @Sucursal				int,
    @SucursalDestino		int,
    @SucursalOrigen			int,
    @EnLinea				bit,
    @PuedeEditar			bit,
    @Empresa	      		char(5),
    @MovTipo   				char(20),
    @MovMoneda				char(10),
    @MovTipoCambio			float,
    @FechaEmision     		datetime,
    @FechaAfectacion		datetime,
    @FechaConclusion		datetime,
    @Proyecto	      		varchar(50),
    @MovUsuario	      		char(10),
    @Autorizacion			char(10),
    @DocFuente			 	int,
    @Concepto    			varchar(50),
    @Referencia 			varchar(50),
    @Observaciones		  	varchar(255),
    @Estatus          		char(15),
    @EstatusNuevo			char(15),
    @Ejercicio	      		int,
    @Periodo		     	int,
    @Almacen				char(10),
    @Agente					varchar(10),
    @GenerarMovID			varchar(20),
    @GenerarPoliza			bit,
    @CfgContX				bit,
    @CfgContXGenerar		char(20)

  -- Inicializar Variables
  SELECT @Generar		   = 0,
		 @GenerarAfectado  = 0,
         @CfgContX         = 0,
         @CfgContXGenerar  = 'NO'

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = NULLIF(RTRIM(Proyecto), ''),
         @MovUsuario = Usuario,
         @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @Concepto = Concepto, @Referencia = Referencia
    FROM SAUX
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    IF @SucursalDestino IS NOT NULL AND @SucursalDestino <> @Sucursal AND @Accion = 'AFECTAR'
    BEGIN
      EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
      IF @EnLinea = 1 
      BEGIN
        EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, NULL
        SELECT @Sucursal = @SucursalDestino
      END ELSE
        SELECT @Accion = 'SINCRO'
    END

    IF @Estatus = 'SINCRO' AND @Accion = 'CANCELAR'
    BEGIN
      EXEC spPuedeEditarMovMatrizSucursal @Sucursal, @SucursalOrigen, @ID, @Modulo, @Empresa, @Usuario, @Mov, @Estatus, 1, @PuedeEditar OUTPUT
      IF @PuedeEditar = 0 
        SELECT @Ok = 60300 
      ELSE BEGIN
        SELECT @Estatus = 'SINAFECTAR'
        EXEC spAsignarSucursalEstatus @ID, @Modulo, @Sucursal, @Estatus
      END
    END
  END

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'PENDIENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE'))
  BEGIN
    SELECT @CfgContX = ContX
      FROM EmpresaGral
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @CfgContX = 1 
      SELECT @CfgContXGenerar = ContXGenerar
        FROM EmpresaCfgModulo
       WHERE Empresa = @Empresa
         AND Modulo  = @Modulo
    IF @@ERROR <> 0 SELECT @Ok = 1
  
    IF @Accion = 'CANCELAR' 
      SELECT @EstatusNuevo = 'CANCELADO' 
    ELSE BEGIN
      IF @MovTipo = 'SAUX.S'
        SELECT @EstatusNuevo = 'CONCLUIDO' 
      IF @MovTipo = 'SAUX.SS'
        SELECT @EstatusNuevo = 'PENDIENTE' 
      ELSE
        SELECT @EstatusNuevo = 'CONCLUIDO' 
      
      IF EXISTS(SELECT * FROM SAUX WHERE ID = @ID AND Estatus <> 'SINAFECTAR') AND @Accion = 'AFECTAR' AND @MovTipo = 'SAUX.S'
        SELECT @EstatusNuevo = 'CONCLUIDO'
        
    END

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN    
      EXEC spSAUXVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
          	          @Conexion, @SincroFinal, @Sucursal, 
                          @Almacen, @Agente, 
     		          @Ok OUTPUT, @OkRef OUTPUT
     		          
      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END

    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
      EXEC spSAUXAfectar @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
		        @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                        @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
		        @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                        @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                        @Almacen, @Agente, 
                        @Ok OUTPUT, @OkRef OUTPUT
                        
  END ELSE
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
    IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010
    ELSE SELECT @Ok = 60040, @OkRef = 'Estatus: '+@Estatus
  END

  IF @Accion = 'SINCRO' AND @Ok = 80060 
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
    IF @EnLinea = 1 EXEC spSincroFinalModulo @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END

  -- Si hay Mensaje pero no tiene referencia
  IF @Ok IS NOT NULL AND @OkRef IS NULL 

    -- Si se Genero un Movimiento, Desplegarlo
    IF @Ok = 80030
      SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov)+' '+LTRIM(Convert(Char, @GenerarMovID))

    -- Si hubo un error poner como referencia el Movimiento
    ELSE
      SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL

  RETURN
END
GO

PRINT "******************* SP SAUX ******************"