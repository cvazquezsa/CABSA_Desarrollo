/********* Campana ***********/

-- select * from Campanad
-- select * from ListaFiltro 

-- select * from listaid
-- select * from campanad
/**************** spCampanaAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaAsignar') and type = 'P') drop procedure dbo.spCampanaAsignar
GO
/*CREATE PROCEDURE spCampanaAsignar
			@Estacion	int,
			@ID		int,
			@Recurso	varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  UPDATE CampanaD
     SET Recurso = @Recurso
   WHERE ID = @ID AND RID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
  RETURN
END*/
GO

/**************** spCampanaCancelarContacto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaCancelarContacto') and type = 'P') drop procedure dbo.spCampanaCancelarContacto
GO
/*CREATE PROCEDURE spCampanaCancelarContacto
			@ID		int,
			@RID		int
--//WITH ENCRYPTION
AS BEGIN  
  UPDATE CampanaD
     SET Estatus = 'CANCELADO'
   WHERE ID = @ID AND RID = @RID AND Estatus = 'PENDIENTE'
  UPDATE Tarea 
     SET Situacion = 'Cancelada'
   WHERE Modulo = 'CMP' AND ModuloID = @RID AND Situacion = 'No comenzada'
  RETURN
END*/
GO

/**************** spCampanaVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaVerificar') and type = 'P') drop procedure dbo.spCampanaVerificar
GO
CREATE PROCEDURE spCampanaVerificar
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
				@CampanaTipo		varchar(50),	
				@Conexion			bit,
				@SincroFinal		bit,
				@Sucursal			int,
    		    @Ok               	int          OUTPUT,
    		    @OkRef            	varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
	DECLARE
		@HoraMin  datetime,
		@HoraMax  datetime,
		@HoraCMin datetime,
		@HoraCMax datetime

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 	  
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END ELSE
  BEGIN
    IF @CampanaTipo IS NULL SELECT @Ok = 43010 /*ELSE
    IF NOT EXISTS(SELECT * FROM CampanaD WHERE ID = @ID) SELECT @Ok = 43020*/
  END

 --Cambio Pedidos Móvil INICIO
  IF @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR' AND @MovTipo = 'CMP.A'
  BEGIN
    IF NOT EXISTS(SELECT * FROM CampanaD WHERE ID = @ID) SELECT @Ok = 43020
    IF EXISTS(SELECT * FROM CampanaD WHERE ID = @ID AND (FechaD IS NULL OR FechaA IS NULL)) SELECT @Ok = 43021
    IF EXISTS(SELECT * FROM CampanaMovilCfg WHERE Empresa = @Empresa)
    BEGIN
        
      SELECT @HoraCMin = MIN(FechaD-dbo.fnFechaSinHora(FechaD)), @HoraCMax = MAX(FechaA-dbo.fnFechaSinHora(FechaA)) FROM CampanaD WHERE ID = @ID
      SELECT @HoraMin = MIN(HorarioD-dbo.fnFechaSinHora(HorarioD)), @HoraMax = MAX(HorarioA-dbo.fnFechaSinHora(HorarioA)) FROM CampanaMovilCfg WHERE Empresa = @Empresa
      
      IF @HoraCMin < @HoraMin OR @HoraCMax > @HoraMax
        SELECT @Ok = 43022
    END
  END
  IF @Accion = 'AFECTAR' AND @Estatus = 'PENDIENTE' AND @MovTipo = 'CMP.A'
  BEGIN
    IF EXISTS(SELECT * FROM Campana c JOIN CampanaD d ON(c.ID = d.ID) JOIN CampanaTipoSituacion s ON(c.CampanaTipo = s.CampanaTipo AND d.Situacion = s.Situacion) WHERE c.ID = @ID AND s.Flujo <>'Final')
      SELECT @Ok = 43023

  END
  --Cambio Pedidos Móvil FIN
  RETURN
END
GO

/**************** spCampanaAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaAfectar') and type = 'P') drop procedure dbo.spCampanaAfectar
GO             
CREATE PROCEDURE spCampanaAfectar
    		   @ID                		int,

		   @Accion			char(20),
		   @Base			char(20),
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
		   @UEN				int,
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

		   @CampanaTipo			varchar(50),

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
    @CancelarID		int,
    @FechaCancelacion	datetime,
    @GenerarMovTipo	char(20),
    @GenerarPeriodo	int,
    @GenerarEjercicio	int,
    @IDAplica		int,
    @Aplica		varchar(20),
    @AplicaID		varchar(20),
    @RID		int,
	--Cambio Pedidos Móvil INICIO
	@Clave                  varchar(20)
    --Cambio Pedidos Móvil
    
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
      INSERT CampanaD (ID, Contacto, ContactoTipo, /*Nombre, Organizacion, Observaciones, */Sucursal)
      SELECT @IDGenerar, Contacto, ContactoTipo, /*Nombre, Organizacion, Observaciones, */@Sucursal
        FROM CampanaD
       WHERE ID = @ID
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
      DECLARE crCampanaCancelar CURSOR FOR
       SELECT ID
         FROM Campana
        WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      OPEN crCampanaCancelar
      FETCH NEXT FROM crCampanaCancelar INTO @CancelarID
      WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
          EXEC spAfectar @Modulo, @CancelarID, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

        FETCH NEXT FROM crCampanaCancelar INTO @CancelarID
      END
      CLOSE crCampanaCancelar
      DEALLOCATE crCampanaCancelar
    END

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @Accion IN ('AFECTAR', 'CANCELAR')  
    BEGIN
/*
      DECLARE crCampanaD CURSOR FOR
       SELECT RID
         FROM CampanaD
        WHERE ID = @ID
      OPEN crCampanaD
      FETCH NEXT FROM crCampanaD INTO @RID
      WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
        END
        FETCH NEXT FROM crCampanaD INTO @RID
      END
      CLOSE crCampanaD
      DEALLOCATE crCampanaD

*/
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
        UPDATE Campana
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	       Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END/*,
               GenerarPoliza    = @GenerarPoliza*/
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END
    --Cambio Pedidos Móvil INICIO
	  IF @Accion = 'AFECTAR' AND @MovTipo = 'CMP.A' AND @EstatusNuevo = 'PENDIENTE' AND @Ok IS NULL
	  BEGIN
		DECLARE cremail_cursor CURSOR FOR 
		 SELECT d.RID 
		   FROM Campana c
		   JOIN CampanaD d ON c.ID = d.ID
		   JOIN CampanaTipoSituacion t on c.CampanaTipo = t.CampanaTipo AND d.Situacion = t.Situacion 
		  WHERE c.ID = @ID AND t.AccionMovil IN('Por Sincronizar')
		OPEN cremail_cursor
		FETCH NEXT FROM cremail_cursor INTO @RID

		WHILE @@FETCH_STATUS = 0
		BEGIN

			EXEC dbo.spIntelisisMovilSendMail 
				 @IDVisita = @RID,
				 @Ok       = @Ok OUTPUT,
				 @OkRef    = @OkRef OUTPUT

			FETCH NEXT FROM cremail_cursor INTO @RID
			END

		CLOSE cremail_cursor
		DEALLOCATE cremail_cursor
	  END
	--Cambio Pedidos Móvil FIN	

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

/**************** spCampana ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampana') and type = 'P') drop procedure dbo.spCampana
GO
CREATE PROCEDURE spCampana
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
    @UEN		int,
    @MovUsuario	      	char(10),
    @Autorizacion     	char(10),
    @DocFuente	      	int,
    @Concepto    	varchar(50),
    @Referencia 	varchar(50),
    @Observaciones    	varchar(255),
    @CampanaTipo	varchar(50),
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

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = NULLIF(RTRIM(Proyecto), ''), @UEN = UEN,
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, 
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @FechaConclusion = FechaConclusion,
         @Concepto = Concepto, @Referencia = Referencia, @CampanaTipo = NULLIF(RTRIM(CampanaTipo), '')
    FROM Campana
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
      IF @Estatus = 'PENDIENTE' 
        SELECT @EstatusNuevo = 'CONCLUIDO' 
      ELSE
        SELECT @EstatusNuevo = 'PENDIENTE' 
    END

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spCampanaVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
                              @CampanaTipo,
            	              @Conexion, @SincroFinal, @Sucursal, 
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
      EXEC spCampanaAfectar @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
  		  	    @Proyecto, @UEN, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                            @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
                            @CampanaTipo,
		            @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                            @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
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
/**************** spRepCampanaD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepCampanaD') and type = 'P') drop procedure dbo.spRepCampanaD
GO
CREATE PROCEDURE spRepCampanaD   
  @Mov    varchar(20),  
  @MovID  varchar(20)  
--//WITH ENCRYPTION
AS BEGIN  
DECLARE  
  @ID    int  

SELECT @ID = ID   
  FROM Campana   
 WHERE Mov=@Mov AND MovID = @MovID  


SELECT CampanaD.ID,           CampanaD.RID,           CampanaD.Sucursal,  CampanaD.SucursalOrigen,  
       CampanaD.Contacto,     CampanaD.ContactoTipo,  CampanaD.Situacion, CampanaD.SituacionFecha,  
       CampanaD.Calificacion, CampanaD.Observaciones, CampanaD.Usuario,   Usuario.Nombre,  
       Agente = (SELECT '(' + cte.Agente + ') ' + a.Nombre from Cte JOIN Agente a ON Cte.Agente = a.Agente WHERE Cte.Cliente=CampanaD.Contacto and CampanaD.ContactoTipo='Cliente'),  
       (dbo.fnContactoNivel(CampanaD.ContactoTipo, CampanaD.Contacto, 'Nombre')) ContactoNombre,  
       (dbo.fnContactoNivel(CampanaD.ContactoTipo, CampanaD.Contacto, 'Sub Tipo')) ContactoSubTipo,  
       (dbo.fnCampanaTipoSituacionIcono (CampanaD.ID, CampanaD.Situacion)) Icono   
  FROM CampanaD LEFT OUTER JOIN Usuario   
    ON CampanaD.Usuario=Usuario.Usuario  
 WHERE CampanaD.ID= @ID  

RETURN
END
GO
/**************** spRepCampana ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepCampana') and type = 'P') drop procedure dbo.spRepCampana
GO
CREATE PROCEDURE spRepCampana   
  @Mov    varchar(20),  
  @MovID  varchar(20)  
--//WITH ENCRYPTION
AS BEGIN  
DECLARE  
  @ID    int 
   
SELECT @ID = ID   
  FROM Campana   
 WHERE Mov=@Mov AND MovID = @MovID  

SELECT Campana.ID,           Campana.Empresa,  Campana.Mov,         Campana.MovID,  
       Campana.FechaEmision, Campana.Concepto, Campana.Proyecto,    Campana.Estatus,  
       Campana.Asunto,       Campana.Agente,   Campana.CampanaTipo, Campana.TieneVigencia,  
       Campana.FechaD,       Campana.FechaA,   ProyDescripcion = Proy.Descripcion,  
       UEN.UEN,              UEN.Nombre,         
       AgenteNombre = Agente.Nombre,        
       CampanaTipo.ParaProspectos,  
       CampanaTipo.ParaClientes,  
       CampanaTipo.ParaProveedores,  
       CampanaTipo.ParaPersonal,  
       CampanaTipo.ParaAgentes,
       e.Nombre as 'NombreEmpresa'  
  FROM Campana LEFT OUTER JOIN UEN   
    ON Campana.UEN=UEN.UEN LEFT OUTER JOIN Proy   
    ON Campana.Proyecto=Proy.Proyecto LEFT OUTER JOIN Agente   
    ON Campana.Agente=Agente.Agente LEFT OUTER JOIN CampanaTipo   
    ON Campana.CampanaTipo=CampanaTipo.CampanaTipo JOIN Empresa e
    ON Campana.Empresa = e.Empresa
 WHERE Campana.ID = @ID ORDER BY Campana.ID DESC   

RETURN
END  
GO
/**************** spRepCampanaLlamadas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepCampanaLlamadas') and type = 'P') drop procedure dbo.spRepCampanaLlamadas
GO
CREATE PROCEDURE spRepCampanaLlamadas   
  @FechaD   datetime,  
  @FechaA   datetime,  
  @Empresa  varchar(10)  
--//WITH ENCRYPTION
AS BEGIN  
SELECT c.ID, c.Mov, c.MovID, c.Asunto, cd.RID, ISNULL(ce.Tipo, 'Otra') as 'Tipo', ce.Observaciones, cd.Usuario, u.Nombre,  
       TotalLlamadas = (SELECT count(ce.Tipo) FROM CampanaEvento ce WHERE ID=cd.ID /*AND ce.Tipo in ('Llamada')*/ AND ce.FechaHora BETWEEN @FechaD AND @FechaA)  
  FROM Campana c 
  JOIN CampanaD cd ON c.ID = cd.ID 
  JOIN CampanaEvento ce ON c.ID = ce.ID AND cd.RID = ce.RID 
  JOIN Usuario u  ON cd.Usuario = u.Usuario  
  JOIN MovTipo m ON c.Mov = m.Mov AND m.Modulo = 'CMP'
 WHERE c.Empresa = @Empresa   
   AND dbo.fnFechaSinHora(ce.FechaHora) BETWEEN dbo.fnFechaSinHora(@FechaD) AND dbo.fnFechaSinHora(@FechaA)  
   AND m.Clave <> 'CMP.A' --BUG2976

RETURN
END  
GO
/**************** spRepCampanaSituacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepCampanaSituacion') and type = 'P') drop procedure dbo.spRepCampanaSituacion
GO
CREATE PROCEDURE spRepCampanaSituacion  
  @Empresa  varchar(10),  
  @Mov      varchar(20),  
  @Estatus  varchar(15)   
--//WITH ENCRYPTION
AS BEGIN  
 IF @Mov in (NULL, '', '(Todos)', '(Todas)', 'NULL') SELECT @Mov 
 IF @Estatus in (NULL, '', '(Todos)', '(Todas)', 'NULL') SELECT @Estatus = NULL

SELECT c.ID, c.Mov, c.MovID, c.Asunto, cd.RID, cd.Situacion,  
      TotalContatos = (SELECT Count(cd.RID) FROM CampanaD cd WHERE cd.ID = c.ID)  
  FROM Campana c JOIN CampanaD cd   
    ON c.ID = cd.ID   
 WHERE c.Empresa = ISNULL(@Empresa, c.Empresa)  
   AND c.Mov = ISNULL(@Mov, c.Mov)  
   AND c.Estatus = ISNULL(@Estatus, c.Estatus)  
 ORDER BY c.ID  

RETURN
END  
GO
/**************** fnDiasSemanaEnPeriodo ****************/ 
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDiasSemanaEnPeriodo') DROP FUNCTION fnDiasSemanaEnPeriodo
GO
CREATE FUNCTION dbo.fnDiasSemanaEnPeriodo (@FechaD datetime, @FechaA datetime)
RETURNS INT
--//WITH ENCRYPTION
AS BEGIN
 -- Si la fecha inicial es fin de semana, moverlo a la siguiente
 WHILE datepart(weekday, @FechaD) in (1,7) -- Sabado, Domingo
  BEGIN
   SET @FechaD = dateadd(d,1,@FechaD)
  END
    
 -- Si la fecha final es fin de semana, moverlo hacia atras
 WHILE datepart(weekday, @FechaA) in (1,7) -- Sabado, Domingo
  BEGIN
   SET @FechaA = dateadd(d,-1,@FechaA)
  END
 -- Los dias de la semana son: el total de dias menos los fines de semana
 -- (2 dias por semana)
 RETURN (datediff(d,@FechaD,@FechaA) + 1) - (datediff(ww,@FechaD,@FechaA) * 2)
END
GO
/**************** spRepCampanaSituacionDet ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRepCampanaSituacionDet') and type = 'P') drop procedure dbo.spRepCampanaSituacionDet
GO
CREATE PROCEDURE spRepCampanaSituacionDet 
 @ID   int 
--//WITH ENCRYPTION
AS BEGIN  

SELECT c.ID, c.Mov, c.MovID, c.Asunto, c.Agente, a.Nombre as 'NombreAgente', cd.RID, cd.Situacion,  
       TotalContatos = (SELECT Count(cd.RID) FROM CampanaD cd WHERE cd.ID = c.ID)  
  FROM Campana c JOIN CampanaD cd   
    ON c.ID = cd.ID LEFT JOIN Agente a
    ON c.Agente = a.Agente
 WHERE c.ID = ISNULL(@ID, c.ID) 
 ORDER BY c.ID  

RETURN
END  
GO
PRINT "******************* SP Campana ******************"
GO
