/********* SOPORTE ***********/

/**************** spAfectarTraficoSoporte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarTraficoSoporte') and type = 'P') drop procedure dbo.spAfectarTraficoSoporte
GO
CREATE PROCEDURE spAfectarTraficoSoporte
		    @Sucursal	int,
    		    @ID         int,
		    @Accion	char(20),
		    @Clave	char(20) = NULL,
		    @Transferir	char(20) = 'NO',
		    @EnSilencio	bit	 = 0	

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Modulo		char(5),
    @Empresa		char(5),
    @NuevoUsuario	char(10),
    @NuevoResponsable	char(10),
    @NuevoEstatus	char(15),
    @NuevaPrioridad	char(10),
    @Prioridad		char(10),
    @Propietario	char(10),
    @Responsable	char(10),
    @PuedeDevolver	bit,
    @SubModulo		char(5),
    @Orden		int,
    @Ok			int,
    @OkRef	     	varchar(255),
    @OkDesc     	varchar(255)

  SELECT @Modulo = 'ST', @Ok = NULL, @OkDesc = NULL, @Accion = UPPER(@Accion), @Orden = 0, @PuedeDevolver = 0,
	 @NuevoUsuario = NULL, @NuevoResponsable = NULL, @NuevoEstatus = NULL, @NuevaPrioridad = NULL

  IF @Accion NOT IN ('TRANSFERIR', 'RESPONSABLE', 'DEVOLVER', 'PRIORIDAD')
    SELECT @Ok = 60030

  IF @Ok IS NULL
  BEGIN
    SELECT @Empresa = Empresa,
           @Propietario = NULLIF(RTRIM(Usuario), ''), 
           @Responsable = NULLIF(RTRIM(UsuarioResponsable), ''), 
           @Prioridad = NULLIF(RTRIM(Prioridad), ''),
           @SubModulo = NULLIF(RTRIM(SubModulo), '')
      FROM Soporte
     WHERE ID = @ID

    IF @Accion IN ('TRANSFERIR', 'DEVOLVER')
    BEGIN
      IF @Accion ='DEVOLVER'
      SELECT @Orden = ISNULL(MAX(Orden), 0) FROM MovUsuario WHERE Modulo = @Modulo AND ID = @ID AND Eliminado = 0
      IF @Accion ='TRANSFERIR'
      SELECT @Orden = ISNULL(MAX(Orden), 0) FROM MovUsuario WHERE Modulo = @Modulo AND ID = @ID 
      IF @Accion = 'TRANSFERIR' SELECT @NuevoUsuario = UPPER(@Clave) ELSE
      IF @Accion = 'DEVOLVER' SELECT @NuevoUsuario = Usuario FROM MovUsuario WHERE Modulo = @Modulo AND ID = @ID AND Orden = @Orden AND Eliminado = 0

      IF @NuevoUsuario IS NULL SELECT @Ok = 71010 ELSE
      IF NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @NuevoUsuario) SELECT @Ok = 71020 ELSE
      IF @NuevoUsuario = @Propietario  SELECT @Ok = 71030
    END ELSE
    IF @Accion = 'RESPONSABLE' 
    BEGIN 
      SELECT @NuevoResponsable = UPPER(@Clave) 
      IF @NuevoResponsable IS NULL SELECT @Ok = 71010 ELSE
      IF NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @NuevoResponsable) SELECT @Ok = 71020 ELSE
      IF @NuevoResponsable = @Responsable SELECT @Ok = 71030
    END ELSE
    IF @Accion = 'PRIORIDAD' 
    BEGIN
      SELECT @NuevaPrioridad = @Clave 
      IF UPPER(@NuevaPrioridad) NOT IN ('ALTA', 'NORMAL', 'BAJA') SELECT @Ok = 71040
    END
  END

  IF @Ok IS NULL
  BEGIN
    BEGIN TRANSACTION
    IF @Accion IN ('TRANSFERIR', 'DEVOLVER')
    BEGIN
      IF @Accion = 'TRANSFERIR'
      BEGIN
        SELECT @Orden = @Orden + 1
        IF EXISTS(SELECT * FROM MovUsuario WHERE Modulo = @Modulo AND ID = @ID AND Usuario = @Propietario AND Eliminado = 0)
          UPDATE MovUsuario SET Orden = @Orden WHERE Modulo = @Modulo AND ID = @ID AND Usuario = @Propietario AND Eliminado = 0
        ELSE
          INSERT MovUsuario (Sucursal, Modulo, ID, Orden, Usuario) VALUES (@Sucursal, @Modulo, @ID, @Orden, @Propietario)
        UPDATE MovUsuario SET Eliminado = 1 WHERE Modulo = @Modulo AND ID = @ID AND Usuario = @NuevoUsuario AND Eliminado = 0
      END ELSE
      IF @Accion = 'DEVOLVER'
        UPDATE MovUsuario SET Eliminado = 1 WHERE Modulo = @Modulo AND ID = @ID AND Usuario = @NuevoUsuario AND Eliminado = 0 AND Orden = @Orden

      IF EXISTS(SELECT * FROM MovUsuario WHERE Modulo = @Modulo AND ID = @ID AND Eliminado = 0) SELECT @PuedeDevolver = 1 ELSE SELECT @PuedeDevolver = 0

      SELECT @SubModulo = ISNULL(NULLIF(RTRIM(SubModuloAtencion), ''), @SubModulo) FROM Usuario WHERE Usuario = @NuevoUsuario
      UPDATE Soporte SET PuedeDevolver = @PuedeDevolver, Usuario = @NuevoUsuario, SubModulo = @SubModulo WHERE ID = @ID      
    END ELSE
    IF @Accion = 'RESPONSABLE'
    BEGIN
      IF UPPER(@Transferir) = 'NO'
        UPDATE Soporte SET UsuarioResponsable = @NuevoResponsable WHERE ID = @ID
      ELSE
        UPDATE Soporte SET UsuarioResponsable = @NuevoResponsable, Usuario = @NuevoResponsable WHERE ID = @ID
    END ELSE
    IF @Accion = 'PRIORIDAD' 
    BEGIN
      IF UPPER(@NuevaPrioridad) <> UPPER(@Prioridad)
      BEGIN
        IF UPPER(@NuevaPrioridad) = 'ALTA' SELECT @NuevoEstatus = 'ALTAPRIORIDAD' ELSE
	IF UPPER(@NuevaPrioridad) = 'BAJA' SELECT @NuevoEstatus = 'PRIORIDADBAJA' 
        ELSE SELECT @NuevoEstatus = 'PENDIENTE'

        EXEC spValidarTareas @Empresa, @Modulo, @ID, @NuevoEstatus, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Soporte
           SET Prioridad = @NuevaPrioridad, Estatus = @NuevoEstatus
         WHERE ID = @ID
      END
    END
    COMMIT TRANSACTION
  END
  
  IF @Ok IS NOT NULL
    SELECT @OkDesc = Descripcion + ' '+ ISNULL(@OkRef, '') FROM MensajeLista WHERE Mensaje = @Ok

  IF @EnSilencio = 0
    SELECT "Mensaje" = @OkDesc
END
GO


/**************** spSoporteEstatus ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSoporteEstatus') and type = 'P') drop procedure dbo.spSoporteEstatus
GO
CREATE PROCEDURE spSoporteEstatus
    		    @Empresa         	char(5),
    		    @ID         	int,
		    @Estatus		char(15),
		    @EstatusNuevo	char(15),
 		    @FechaEmision	datetime,
                    @FechaRegistro	datetime,
		    @CfgContX		bit,
		    @CfgContXGenerar	char(20),
		    @GenerarPoliza	bit,
		    @Ok			int		OUTPUT,
		    @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @FechaCancelacion	datetime,
    @FechaConclusion	datetime
    
  IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
  IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaRegistro ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
  IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
  BEGIN
    IF @Estatus =  'SINAFECTAR' AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
    IF @Estatus <> 'SINAFECTAR' AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
  END  

  EXEC spValidarTareas @Empresa, 'ST', @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
  UPDATE Soporte
     SET FechaConclusion  = @FechaConclusion, 
         FechaCancelacion = @FechaCancelacion, 
         UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
         Estatus          = @EstatusNuevo,
         Estado           = CASE WHEN @EstatusNuevo = 'CONCLUIDO' THEN 'Completado' ELSE Estado END,
         Situacion 	  = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
         GenerarPoliza    = @GenerarPoliza
   WHERE ID = @ID 
  RETURN
END
GO

/**************** spSoporteAplicacionRef ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSoporteAplicacionRef') and type = 'P') drop procedure dbo.spSoporteAplicacionRef
GO
CREATE PROCEDURE spSoporteAplicacionRef
    		    @ID               		int,
		    @Accion			char(20),
		    @Sucursal			int,
    		    @Empresa          		char(5),
		    @Mov			char(20),
		    @MovID			char(20),
		    @MovTipo			char(20),
                    @Verificar			bit,
                    @FechaRegistro		datetime,
		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @GenerarPoliza		bit,

		    @AplicaMov			char(20),
		    @AplicaMovID		char(20),

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @IDAplica		int,
    @AplicaEstatus	char(15),
    @AplicaFechaEmision	datetime,
    @EstatusNuevo	char(15)

  IF @AplicaMov IS NULL OR @AplicaMovID IS NULL RETURN 

  SELECT @IDAplica = ID,
         @AplicaEstatus = Estatus,
         @AplicaFechaEmision = FechaEmision
    FROM Soporte
   WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
  IF @Verificar = 1 
  BEGIN       
    IF (@Accion = 'CANCELAR' AND @AplicaEstatus <> 'CONCLUIDO') OR (@Accion <> 'CANCELAR' AND @AplicaEstatus NOT IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA')) OR 
       NOT EXISTS(SELECT * FROM Soporte s, MovTipo mt WHERE mt.Modulo = 'ST' AND mt.Mov = s.Mov AND mt.Clave IN ('ST.P', 'ST.A', 'ST.I') AND s.ID = @IDAplica) 
      SELECT @Ok = 20180, @OkRef = RTRIM(@AplicaMov)+' '+RTRIM(@AplicaMovID)
  END ELSE 
  BEGIN
    IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'PENDIENTE' ELSE SELECT @EstatusNuevo = 'CONCLUIDO'
    EXEC spSoporteEstatus @Empresa, @IDAplica, @AplicaEstatus, @EstatusNuevo, @AplicaFechaEmision, @FechaRegistro, @CfgContX, @CfgContXGenerar, @GenerarPoliza, @Ok OUTPUT, @OkRef OUTPUT
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'ST', @IDAplica, @AplicaMov, @AplicaMovID, 'ST', @ID, @Mov, @MovID, @Ok OUTPUT
  END
  RETURN
END
GO

/**************** spSoporteAplicacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSoporteAplicacion') and type = 'P') drop procedure dbo.spSoporteAplicacion
GO
CREATE PROCEDURE spSoporteAplicacion
    		    @ID               		int,
		    @Accion			char(20),
		    @Sucursal			int,
    		    @Empresa          		char(5),
		    @Mov			char(20),
		    @MovID			char(20),
		    @MovTipo			char(20),
                    @Verificar			bit,
                    @FechaRegistro		datetime,
		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @GenerarPoliza		bit,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @AplicaMov		char(20),
    @AplicaMovID	varchar(20)

  DECLARE crSoporteD CURSOR FOR
    SELECT Aplica, AplicaID FROM SoporteD WHERE ID = @ID 

  OPEN crSoporteD
  FETCH NEXT FROM crSoporteD INTO @AplicaMov, @AplicaMovID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spSoporteAplicacionRef @ID, @Accion, @Sucursal, @Empresa, @Mov, @MovID, @MovTipo, @Verificar, @FechaRegistro, @CfgContX, @CfgContXGenerar, @GenerarPoliza, @AplicaMov, @AplicaMovID, @Ok OUTPUT, @OkRef OUTPUT

    FETCH NEXT FROM crSoporteD INTO @AplicaMov, @AplicaMovID
  END  -- While	
  CLOSE crSoporteD
  DEALLOCATE crSoporteD
  RETURN
END
GO

/**************** spSoporteVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSoporteVerificar') and type = 'P') drop procedure dbo.spSoporteVerificar
GO
CREATE PROCEDURE spSoporteVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),

		    @RefInicial			char(20),
		    @RefInicialID		char(20),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN 

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END 

  IF @MovTipo IN ('ST.P','ST.S', 'ST.A', 'ST.F')
    EXEC spSoporteAplicacion @ID, @Accion, @Sucursal, @Empresa, @Mov, @MovID, @MovTipo, 1, NULL, NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT
  IF @MovTipo = 'ST.F'
    EXEC spSoporteAplicacionRef @ID, @Accion, @Sucursal, @Empresa, @Mov, @MovID, @MovTipo, 1, NULL, NULL, NULL, NULL, @RefInicial, @RefInicialID, @Ok OUTPUT, @OkRef OUTPUT

  IF @MovTipo = 'ST.R' AND @EstatusNuevo = 'CONCLUIDO'
    IF EXISTS(SELECT * FROM MovTarea WHERE Modulo = @Modulo AND ID = @ID AND Estado <> 'Completada')
      SELECT @Ok = 20495

  IF @Ok IS NULL
    EXEC xpSoporteVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @Estatus, @EstatusNuevo, 
                            @RefInicial, @RefInicialID, 
        	            @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO

/**************** spSoporteAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSoporteAfectar') and type = 'P') drop procedure dbo.spSoporteAfectar
GO             
CREATE PROCEDURE spSoporteAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)	OUTPUT,
    		   @MovTipo     		char(20),
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
    		   @FechaConclusion		datetime,

		   @Cliente			char(10),
		   @EnviarA			int,
                   @Agente			char(10),

    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Concepto     		varchar(50),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,
		   @MovUsuario			char(10),

		   @RefInicial			char(20),
		   @RefInicialID		char(20),

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
    @Renglon		float,
    @OrigenID		int,
    @AvanceID		int,
    @Destino		varchar(50)
    
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

/*    IF @MovTipo = 'ST.A'
      INSERT INTO SoporteD (Sucursal, ID,  Renglon, Aplica, AplicaID) 
      SELECT @Sucursal, @IDGenerar, d.Renglon, d.Aplica, d.AplicaID
        FROM SoporteD d, MovTipo mt
       WHERE d.ID = @ID AND mt.Modulo = 'ST' AND mt.Mov = d.Aplica AND mt.Clave = 'ST.I'
*/
    IF @Ok IS NULL
    BEGIN
      /*IF @MovTipo IN ('ST.I', 'ST.A')
      BEGIN
        UPDATE Soporte SET ReferenciaInicial = CASE WHEN @MovTipo = 'ST.I' THEN RTRIM(@Mov)+' '+RTRIM(@MovID) ELSE RTRIM(@RefInicial)+' '+RTRIM(@RefInicialID) END WHERE ID = @IDGenerar
      END*/

      IF @MovTipo <> 'ST.I'
      BEGIN
        SELECT @Renglon = ISNULL(MAX(Renglon), 0) + 2048 FROM SoporteD WHERE ID = @IDGenerar
        INSERT INTO SoporteD (Sucursal, ID,  Renglon, Aplica, AplicaID) VALUES (@Sucursal, @IDGenerar, @Renglon, @Mov, @MovID)
      END
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
                       	         NULL, @Proyecto, NULL, NULL,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    -- Aqui va el detalle de la afectacion
    IF @Proyecto IS NOT NULL 
      UPDATE Soporte 
         SET ProyectoFolio = (SELECT COUNT(*) FROM Soporte WHERE Empresa = @Empresa AND Mov = @Mov AND Proyecto = @Proyecto)
       WHERE ID = @ID

    IF @MovTipo = 'ST.I'
      UPDATE Soporte SET ReferenciaInicial = RTRIM(@Mov)+' '+RTRIM(@MovID) WHERE ID = @ID

    IF @MovTipo IN ('ST.P', 'ST.S', 'ST.A', 'ST.F')
      EXEC spSoporteAplicacion @ID, @Accion, @Sucursal, @Empresa, @Mov, @MovID, @MovTipo, 0, @FechaRegistro, @CfgContX, @CfgContXGenerar, @GenerarPoliza, @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo = 'ST.F'
      EXEC spSoporteAplicacionRef @ID, @Accion, @Sucursal, @Empresa, @Mov, @MovID, @MovTipo, 0, @FechaRegistro, @CfgContX, @CfgContXGenerar, @GenerarPoliza, @RefInicial, @RefInicialID, @Ok OUTPUT, @OkRef OUTPUT

    -- Checar despues de Aplicar
    IF @MovTipo = 'ST.A' AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    BEGIN
      SELECT @AvanceID = NULL
      SELECT @AvanceID = MIN(s.ID) FROM Soporte s, MovTipo mt WHERE s.ID <> @ID AND s.Estatus = 'PENDIENTE' AND s.Empresa = @Empresa AND mt.Modulo = 'ST' AND mt.Mov = s.Mov AND mt.Clave = 'ST.A' AND s.ReferenciaInicial = RTRIM(@RefInicial)+' '+RTRIM(@RefInicialID)
      IF @AvanceID IS NOT NULL
        SELECT @Ok = 26030, @OkRef = RTRIM(Mov)+' '+RTRIM(MovID) FROM Soporte WHERE ID = @AvanceID
    END

    -- Actualizar Movimiento
    IF @Ok IS NULL
      EXEC spSoporteEstatus @Empresa, @ID, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @CfgContX, @CfgContXGenerar, @GenerarPoliza, @Ok OUTPUT, @OkRef OUTPUT
 
    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT 

    IF @Cliente IS NOT NULL
    BEGIN
      IF (SELECT TieneMovimientos FROM Cte WHERE Cliente = @Cliente) = 0
        UPDATE Cte SET TieneMovimientos = 1 WHERE Cliente = @Cliente 
    END
    IF @Cliente IS NOT NULL AND @EnviarA IS NOT NULL
    BEGIN
      IF (SELECT TieneMovimientos FROM CteEnviarA WHERE Cliente = @Cliente AND ID = @EnviarA) = 0
        UPDATE CteEnviarA SET TieneMovimientos = 1 WHERE Cliente = @Cliente AND ID = @EnviarA
    END
    IF @Agente IS NOT NULL	   
    BEGIN
      IF (SELECT TieneMovimientos FROM Agente WHERE Agente = @Agente) = 0
        UPDATE Agente SET TieneMovimientos = 1 WHERE Agente = @Agente 
    END

    IF @MovTipo IN ('ST.A', 'ST.F')
    BEGIN
      SELECT @OrigenID = NULL
      SELECT @OrigenID = MIN(ID) FROM Soporte WHERE ID <> @ID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND Empresa = @Empresa AND Mov = @RefInicial AND MovID = @RefInicialID
      IF @OrigenID IS NOT NULL
      BEGIN
        IF @Accion <> 'CANCELAR' 
          SELECT @Destino = RTRIM(@Mov) + ' ' +RTRIM(@MovID)
        ELSE
          SELECT @Destino = RTRIM(MAX(Mov))+' '+ISNULL(RTRIM(MAX(MovID)), '') 
            FROM Soporte 
           WHERE Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND Empresa = @Empresa AND ReferenciaInicial = RTRIM(@RefInicial) + ' ' + @RefInicialID AND Mov <> @RefInicial AND MovID <> @RefInicialID

        UPDATE Soporte SET Destino = NULLIF(RTRIM(@Destino), '') WHERE ID = @OrigenID
      END
    END
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC xpSoporteAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion, @Ok OUTPUT, @OkRef OUTPUT

  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
    
  RETURN
END
GO

/**************** spSoporte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSoporte') and type = 'P') drop procedure dbo.spSoporte
GO
CREATE PROCEDURE spSoporte
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
    @FechaEmision     	datetime,
    @FechaAfectacion	datetime,
    @FechaConclusion	datetime,
    @Proyecto	      	varchar(50),
    @MovUsuario	      	char(10),
    @Responsable      	char(10),
    @Autorizacion     	char(10),
    @Cliente		char(10),
    @EnviarA		int,
    @Agente		char(10),
    @DocFuente	      	int,
    @Concepto    	varchar(50),
    @Observaciones    	varchar(255),
    @Estatus          	char(15),
    @EstatusNuevo	char(15),
    @Prioridad		char(10),
    @Ejercicio	      	int,
    @Periodo	      	int,
    @GenerarMovID	varchar(20),
    @GenerarPoliza	bit,
    @ReferenciaInicial	varchar(50),
    @RefInicial		char(20),
    @RefInicialID	char(20),
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
         @MovUsuario = Usuario, @Responsable = UsuarioResponsable, @Autorizacion = Autorizacion, 
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @GenerarPoliza = GenerarPoliza, @Prioridad = Prioridad, @FechaConclusion = FechaConclusion,
         @Cliente = Cliente, @EnviarA = EnviarA, @Agente = Agente, @ReferenciaInicial = NULLIF(RTRIM(ReferenciaInicial), ''),
         @Concepto = Concepto
    FROM Soporte
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  IF @ReferenciaInicial IS NOT NULL
    SELECT @RefInicial = MIN(Mov), @RefInicialID = MIN(MovID) FROM Soporte WHERE Empresa = @Empresa AND RTRIM(Mov)+' '+RTRIM(MovID) = @ReferenciaInicial 

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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA'))
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
  
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR'
    BEGIN
      IF @MovTipo IN ('ST.S', 'ST.F') SELECT @EstatusNuevo = 'CONCLUIDO' ELSE
      IF @Prioridad = 'ALTA' SELECT @EstatusNuevo = 'ALTAPRIORIDAD' ELSE
      IF @Prioridad = 'BAJA' SELECT @EstatusNuevo = 'PRIORIDADBAJA'
      ELSE SELECT @EstatusNuevo = 'PENDIENTE' 
    END   

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spSoporteVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @Estatus, @EstatusNuevo, 
                              @RefInicial, @RefInicialID, 
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
      EXEC spSoporteAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
                            @Cliente, @EnviarA, @Agente,
			    @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto,
                            @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
                            @RefInicial, @RefInicialID,
		            @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                            @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                            @Ok OUTPUT, @OkRef OUTPUT

    IF @Estatus = 'SINAFECTAR' AND @Accion = 'AFECTAR' AND @MovUsuario <> @Responsable AND @Ok IS NULL
      EXEC spAfectarTraficoSoporte @Sucursal, @ID, 'TRANSFERIR', @Responsable, @EnSilencio = 1

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

PRINT "******************* SP Soporte ******************"
