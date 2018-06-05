/********* ISL ***********/

/**************** spISLEnviar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISLEnviar') and type = 'P') drop procedure dbo.spISLEnviar
GO
CREATE PROCEDURE spISLEnviar
			@ID		int,
			@Empresa	varchar(5),
			@Usuario	varchar(10),
			@Licencia	varchar(50),
			@LicenciaXML	varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Perfil	varchar(50),
    @Para	varchar(255),
    @Asunto	varchar(255)

  SELECT @Perfil = DBMailPerfil FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT @Para = eMail
    FROM IntelisisSL
   WHERE Licencia = @Licencia
  SELECT @Asunto = 'Intelisis - Licencia '+@Licencia

  EXEC spEnviarDBMail @Perfil, @Para, @Asunto, @LicenciaXML
		   
  RETURN
END
GO

/**************** spISLVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISLVerificar') and type = 'P') drop procedure dbo.spISLVerificar
GO
CREATE PROCEDURE spISLVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN 

  IF @Accion = 'CANCELAR'
  BEGIN
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 10100
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END 

  RETURN
END
GO

/**************** spISLAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISLAfectar') and type = 'P') drop procedure dbo.spISLAfectar
GO             
CREATE PROCEDURE spISLAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)	OUTPUT,
    		   @MovTipo     		char(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
    		   @FechaConclusion		datetime,

    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Concepto     		varchar(50),
		   @Referencia			varchar(50),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,
		   @MovUsuario			char(10),

		   @Conexion			bit,
                   @SincroFinal			bit,
                   @Sucursal			int,
                   @SucursalDestino		int,
                   @SucursalOrigen		int,

		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

		   @Generar			bit,
    		   @GenerarMov			char(20),
	           @GenerarAfectado		bit,
		   @IDGenerar			int	     	OUTPUT,	
    		   @GenerarMovID	  	varchar(20)	OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @FechaCancelacion	datetime,
    @GenerarMovTipo	char(20),
    @GenerarPeriodo	int,
    @GenerarEjercicio	int,
    @Licencia		varchar(50), 
    @Vencimiento	datetime,
    @VencimientoA	datetime,
    @Mantenimiento	datetime, 
    @MantenimientoA	datetime, 
    @Licenciamiento	varchar(50), 
    @Cantidad		int,
    @CantidadA		int
    
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
      INSERT ISLD (
             Sucursal,  ID,         Renglon, Licencia, Vencimiento, Mantenimiento, Licenciamiento, Cantidad) 
      SELECT @Sucursal, @IDGenerar, Renglon, Licencia, Vencimiento, Mantenimiento, Licenciamiento, Cantidad
        FROM ISLD
       WHERE ID = @ID

      IF @Ok IS NULL SELECT @Ok = 80030
    END
    RETURN
  END


  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @Accion IN ('AFECTAR')
    BEGIN
      -- Afectar Movimiento
      DECLARE crDetalle CURSOR LOCAL FOR 
       SELECT d.Licencia, d.Vencimiento, d.Mantenimiento, d.Licenciamiento, ISNULL(d.Cantidad, 0)
         FROM ISLD d
        WHERE d.ID = @ID
      OPEN crDetalle
      FETCH NEXT FROM crDetalle INTO @Licencia, @Vencimiento, @Mantenimiento, @Licenciamiento, @Cantidad
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @VencimientoA = NULL, @MantenimientoA = NULL, @CantidadA = NULL
          SELECT @VencimientoA = Vencimiento, @MantenimientoA = Mantenimiento
            FROM IntelisisSL
           WHERE Licencia = @Licencia
          SELECT @CantidadA = NULLIF(Cantidad, 0)
            FROM IntelisisSLD
           WHERE Licencia = @Licencia AND Licenciamiento = @Licenciamiento
           
          /*IF @MovTipo = 'ISL.A' AND (@VencimientoA IS NOT NULL OR @MantenimientoA IS NOT NULL OR @CantidadA IS NOT NULL)
            SELECT @Ok = 9040*/
          IF @Ok IS NULL
          BEGIN
            IF @MovTipo IN ('ISL.A', 'ISL.V') UPDATE IntelisisSL SET Vencimiento   = @Vencimiento   WHERE Licencia = @Licencia
            IF @MovTipo IN ('ISL.A', 'ISL.M') UPDATE IntelisisSL SET Mantenimiento = @Mantenimiento WHERE Licencia = @Licencia
            IF @MovTipo IN ('ISL.A', 'ISL.L')
            BEGIN
              UPDATE IntelisisSLD SET Cantidad = @Cantidad, TieneMovimientos = 1 WHERE Licencia = @Licencia AND Licenciamiento = @Licenciamiento 
              IF @@ROWCOUNT = 0
                INSERT IntelisisSLD (Licencia, Licenciamiento, Cantidad, Estatus, TieneMovimientos) VALUES (@Licencia, @Licenciamiento, @Cantidad, 'ALTA', 1)
            END
            UPDATE ISLD SET VencimientoA = @VencimientoA, MantenimientoA = @MantenimientoA, CantidadA = @CantidadA WHERE CURRENT OF crDetalle
          END
        END
        FETCH NEXT FROM crDetalle INTO @Licencia, @Vencimiento, @Mantenimiento, @Licenciamiento, @Cantidad
      END
      CLOSE crDetalle
      DEALLOCATE crDetalle
    END
    
    IF @Accion IN ('AFECTAR', 'CANCELAR')
    BEGIN
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
        UPDATE ISL
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	       Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT 

  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
    
  RETURN
END
GO

/**************** spISL ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISL') and type = 'P') drop procedure dbo.spISL
GO
CREATE PROCEDURE spISL
                   @ID                  	int,
    		   @Modulo	      		char(5),
		   @Accion			char(20),
		   @Base			char(20),
		   @FechaRegistro		datetime,
		   @GenerarMov			char(20),
		   @Usuario			char(10),
    		   @Conexion			bit,
		   @SincroFinal			bit,
    		   @Mov	      			char(20)	OUTPUT,
    		   @MovID            		varchar(20)	OUTPUT,
		   @IDGenerar			int		OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Generar		bit,
    @GenerarAfectado	bit,
    @Sucursal		int,
    @SucursalDestino	int,
    @SucursalOrigen	int,
    @EnLinea		bit,
    @PuedeEditar	bit,
    @Empresa	      	char(5),
    @MovTipo   		char(20),
    @MovMoneda		char(10),
    @MovTipoCambio	float,
    @FechaEmision     	datetime,
    @FechaAfectacion	datetime,
    @FechaConclusion	datetime,
    @Proyecto	      	varchar(50),
    @MovUsuario	      	char(10),
    @Autorizacion     	char(10),
    @Cliente		char(10),
    @EnviarA		int,
    @DocFuente	      	int,
    @Concepto    	varchar(50),
    @Referencia 	varchar(50),
    @Observaciones    	varchar(255),
    @Estatus          	char(15),
    @EstatusNuevo	char(15),
    @Ejercicio	      	int,
    @Periodo	      	int,
    @GenerarMovID	varchar(20),
    @GenerarPoliza	bit,
    @CfgContX		bit,
    @CfgContXGenerar	char(20)/*,
    @Verificar		bit*/

  -- Inicializar Variables
  SELECT @Generar	   = 0,
	 @GenerarAfectado  = 0,
         @CfgContX         = 0,
         @CfgContXGenerar  = 'NO'/*,
	 @Verificar        = 1*/

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = NULLIF(RTRIM(Proyecto), ''),
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, 
         @MovMoneda = Moneda, @MovTipoCambio = TipoCambio,
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion,
         @Concepto = Concepto, @Referencia = Referencia
    FROM ISL
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
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
        SELECT @Estatus = 'SINAFECTAR'/*, @Verificar = 0*/
        EXEC spAsignarSucursalEstatus @ID, @Modulo, @Sucursal, @Estatus
      END
    END
  END

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'PENDIENTE')) OR 
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
  
    IF @Estatus = 'SINAFECTAR' AND @Accion <> 'CANCELAR'
    BEGIN
      SELECT @EstatusNuevo = 'CONCLUIDO'
    END   

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spISLVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
          	               @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

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
      EXEC spISLAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			     @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                             @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
		             @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                             @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                             @Ok OUTPUT, @OkRef OUTPUT

  END ELSE 
  BEGIN
    IF @Estatus = 'SINAFECTAR' AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
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

PRINT "******************* SP ISL ******************"
