/********* Recluta ***********/

/**************** spAfectarTraficoRecluta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarTraficoRecluta') and type = 'P') drop procedure dbo.spAfectarTraficoRecluta
GO
CREATE PROCEDURE spAfectarTraficoRecluta
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
    @PuedeDevolver	bit,
    @Orden		int,
    @Ok			int,
    @OkRef	     	varchar(255),
    @OkDesc     	varchar(255)

  SELECT @Modulo = 'RE', @Ok = NULL, @OkDesc = NULL, @Accion = UPPER(@Accion), @Orden = 0, @PuedeDevolver = 0,
	 @NuevoUsuario = NULL, @NuevoResponsable = NULL, @NuevoEstatus = NULL, @NuevaPrioridad = NULL

  IF @Accion NOT IN ('TRANSFERIR', 'DEVOLVER', 'PRIORIDAD')
    SELECT @Ok = 60030

  IF @Ok IS NULL
  BEGIN
    SELECT @Empresa = Empresa,
           @Propietario = NULLIF(RTRIM(Usuario), ''), 
           @Prioridad = NULLIF(RTRIM(Prioridad), '')
      FROM Recluta
     WHERE ID = @ID

    IF @Accion IN ('TRANSFERIR', 'DEVOLVER')
    BEGIN
      SELECT @Orden = ISNULL(MAX(Orden), 0) FROM MovUsuario WHERE Modulo = @Modulo AND ID = @ID 
      IF @Accion = 'TRANSFERIR' SELECT @NuevoUsuario = UPPER(@Clave) ELSE
      IF @Accion = 'DEVOLVER' SELECT @NuevoUsuario = Usuario FROM MovUsuario WHERE Modulo = @Modulo AND ID = @ID AND Orden = @Orden AND Eliminado = 0

      IF @NuevoUsuario IS NULL SELECT @Ok = 71010 ELSE
      IF NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @NuevoUsuario) SELECT @Ok = 71020 ELSE
      IF @NuevoUsuario = @Propietario  SELECT @Ok = 71030
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

      UPDATE Recluta SET PuedeDevolver = @PuedeDevolver, Usuario = @NuevoUsuario WHERE ID = @ID      
    END ELSE
    IF @Accion = 'PRIORIDAD' 
    BEGIN
      IF UPPER(@NuevaPrioridad) <> UPPER(@Prioridad)
      BEGIN
        IF UPPER(@NuevaPrioridad) = 'ALTA' SELECT @NuevoEstatus = 'ALTAPRIORIDAD' ELSE
	IF UPPER(@NuevaPrioridad) = 'BAJA' SELECT @NuevoEstatus = 'PRIORIDADBAJA' 
        ELSE SELECT @NuevoEstatus = 'PENDIENTE'

        EXEC spValidarTareas @Empresa, @Modulo, @ID, @NuevoEstatus, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Recluta
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

/**************** spReclutaVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReclutaVerificar') and type = 'P') drop procedure dbo.spReclutaVerificar
GO
CREATE PROCEDURE spReclutaVerificar
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
		    
		    @Personal			varchar(10),
		    @Puesto			varchar(50),
		    
		    @OrigenTipo			varchar(10),
		    @Origen			varchar(20),
		    @OrigenID			varchar(20),
		    @OrigenEstatus		varchar(15),
		    @OrigenMovTipo		varchar(20),
		    @IDOrigen			int,
		    @OrigenPersonal		varchar(10),
		    @OrigenPuesto		varchar(50),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Tipo		varchar(50),
    @Peso		float
        
  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
    IF @MovTipo = 'RE.SCO'
    BEGIN
      IF EXISTS(SELECT * FROM ReclutaPlaza WHERE ID = @ID AND EstaPendiente = 0)
        SELECT @Ok = 40290
    END
  END ELSE
  BEGIN     
    IF @Ok IS NULL
    BEGIN
      IF @MovTipo IN ('RE.SCO') 
        IF (SELECT SUM(Peso) FROM ReclutaCompetenciaTipo WHERE ID = @ID)<>100
          SELECT @Ok = 40330
      IF @MovTipo IN ('RE.SCO', 'RE.AP', 'RE.RCO', 'RE.CO') AND NOT EXISTS(SELECT * FROM ReclutaPlaza WHERE ID = @ID) 
        SELECT @Ok = 40250
      IF @MovTipo IN ('RE.ECO', 'RE.CO', 'RE.SEV', 'RE.EV') AND @Personal IS NULL AND @Ok IS NULL
        SELECT @Ok = 40025
      IF @Puesto IS NULL AND @Ok IS NULL
        SELECT @Ok = 40260              
      IF @MovTipo IN ('RE.ECO', 'RE.CO', 'RE.RCO') AND @Ok IS NULL
      BEGIN
        IF @OrigenMovTipo <> 'RE.SCO' AND @OrigenEstatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA')
          SELECT @Ok = 20380, @OkRef = @Origen+' '+@OrigenID
      END      
      IF @MovTipo IN ('RE.EV') AND @Ok IS NULL
      BEGIN
        IF @OrigenMovTipo NOT IN ('RE.SCO', 'RE.SEV') AND @OrigenEstatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA')
          SELECT @Ok = 20380, @OkRef = @Origen+' '+@OrigenID
      END
      IF @MovTipo IN ('RE.CO', 'RE.AP', 'RE.RCO') AND @Ok IS NULL
      BEGIN
        SELECT @OkRef = NULL
        SELECT @OkRef = MIN(Plaza)
          FROM ReclutaPlaza
         WHERE ID = @ID AND Plaza NOT IN (SELECT Plaza FROM ReclutaPlaza WHERE ID = @IDOrigen AND EstaPendiente = 1)         
        IF @OkRef IS NOT NULL
          SELECT @Ok = 20380

        IF @Ok IS NULL AND @MovTipo NOT IN ('RE.AP', 'RE.RCO')
          IF (SELECT COUNT(*) FROM ReclutaPlaza WHERE ID = @ID)>1 
            SELECT @Ok = 40320
      END
      IF @MovTipo IN ('RE.ECO', 'RE.CO', 'RE.EV', 'RE.AP', 'RE.RCO') AND @Ok IS NULL
      BEGIN
        IF ISNULL(@Puesto, '') <> ISNULL(@OrigenPuesto, '')
          SELECT @Ok = 20380, @OkRef = @Puesto
        IF ISNULL(@Personal, '') <> ISNULL(@OrigenPersonal, '') AND @MovTipo = 'RE.EV'
          SELECT @Ok = 20380, @OkRef = @Personal
      END
      IF @MovTipo = 'RE.SCO' AND @Ok IS NULL
      BEGIN
        SELECT @OkRef = NULL
        SELECT @OkRef = MIN(rp.Plaza)
          FROM ReclutaPlaza rp
          JOIN Plaza p ON p.Plaza = rp.Plaza
         WHERE rp.ID = @ID AND p.Puesto <> @Puesto
        IF @OkRef IS NOT NULL
          SELECT @Ok = 40300
        ELSE
        BEGIN
          SELECT @OkRef = MIN(rp.Plaza)
            FROM ReclutaPlaza rp
            JOIN Recluta r ON r.ID = rp.ID
           WHERE r.Empresa = @Empresa AND r.Estatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA') AND rp.EstaPendiente = 1
             AND rp.Plaza IN (SELECT Plaza FROM ReclutaPlaza WHERE ID = @ID)
          IF @OkRef IS NOT NULL
            SELECT @Ok = 40310
        END
      END
    END
    IF @MovTipo = 'RE.AP' AND @Ok IS NULL
    BEGIN
      SELECT @OkRef = NULL
      IF @Accion = 'AFECTAR'
      BEGIN
        SELECT @OkRef = MIN(rp.Plaza)
          FROM ReclutaPlaza rp
          JOIN Plaza p ON p.Plaza = rp.Plaza
         WHERE rp.ID = @ID AND p.Estatus NOT LIKE 'AUTORIZAR%'
         IF @OkRef IS NOT NULL
           SELECT @Ok = 40270
       END ELSE
      IF @Accion = 'CANCELAR'
      BEGIN
        SELECT @OkRef = MIN(rp.Plaza)
          FROM ReclutaPlaza rp
          JOIN Plaza p ON p.Plaza = rp.Plaza
         WHERE rp.ID = @ID AND p.Estatus <> 'ALTA'
         IF @OkRef IS NOT NULL
           SELECT @Ok = 40280
       END 
    END
    IF @Ok IS NULL
    BEGIN
      SELECT @Tipo = NULL
      SELECT TOP(1) @Tipo = c.Tipo, @Peso = SUM(d.Peso) 
        FROM ReclutaD d
        JOIN Competencia c ON c.Competencia = d.Competencia
       WHERE d.ID = @ID
       GROUP BY c.Tipo
      HAVING SUM(d.Peso) <> 100.0
    
      IF @Tipo IS NOT NULL SELECT @Ok = 40240, @OkRef = @Tipo
    END
    
    -- checar que haya faltado calificar ningun Competencia solicitado antes de afectar
    IF @MovTipo IN ('RE.ECO', 'RE.CO', 'RE.EV') AND @Ok IS NULL
    BEGIN
      SELECT @OkRef = NULL
      SELECT @OkRef = MIN(Competencia)
        FROM ReclutaD
       WHERE ID = @IDOrigen
         AND Competencia NOT IN (SELECT Competencia FROM ReclutaD WHERE ID = @ID)      
      IF @OkRef IS NOT NULL
        SELECT @Ok = 40340

      IF @Ok IS NULL
      BEGIN
        SELECT @OkRef = MIN(o.Competencia)
          FROM ReclutaD o
          JOIN ReclutaD d ON d.ID = @ID AND d.Competencia = o.Competencia
         WHERE o.ID = @IDOrigen
           AND (ISNULL(d.ValorMinimo, 0) <> ISNULL(o.ValorMinimo, 0) OR ISNULL(d.Peso, 0) <> ISNULL(o.Peso, 0))
        IF @OkRef IS NOT NULL
          SELECT @Ok = 40350
      END

      IF @Ok IS NULL
      BEGIN
        SELECT @OkRef = MIN(Competencia)
          FROM ReclutaD
         WHERE ID = @ID
           AND Valor IS NULL
        IF @OkRef IS NOT NULL
          SELECT @Ok = 40360
      END
    END
    
    IF @Ok IS NULL
    BEGIN
      IF NOT EXISTS(SELECT * FROM ReclutaD WHERE ID = @ID) 
        SELECT @Ok = 60010
    END
  END

  RETURN
END
GO

/**************** spReclutaAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReclutaAfectar') and type = 'P') drop procedure dbo.spReclutaAfectar
GO             
CREATE PROCEDURE spReclutaAfectar
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

		   @Personal			varchar(10),
		   @Puesto			varchar(50),
		   
		   @OrigenTipo			varchar(10),
		   @Origen			varchar(20),
		   @OrigenID			varchar(20),
		   @OrigenEstatus		varchar(15),
		   @OrigenMovTipo		varchar(20),
		   @IDOrigen			int,
		   @OrigenPersonal		varchar(10),
		   @OrigenPuesto		varchar(50),

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
    @PlazasPendientes	int
    
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
      IF @GenerarMovTipo IN ('RE.SCO', 'RE.AP', 'RE.RCO', 'RE.CO')
      BEGIN
        IF @GenerarMovTipo IN ('RE.AP')
          INSERT ReclutaPlaza (
                 Sucursal,  ID,         Plaza) 
          SELECT @Sucursal, @IDGenerar, rp.Plaza
            FROM ReclutaPlaza rp
            JOIN Plaza p ON p.Plaza = rp.Plaza AND p.Estatus LIKE 'AUTORIZA%'
           WHERE rp.ID = @ID AND rp.EstaPendiente = 1
        ELSE
        IF @OrigenMovTipo = 'RE.SCO'
          INSERT ReclutaPlaza (
                 Sucursal,  ID,         Plaza) 
          SELECT TOP(1) @Sucursal, @IDGenerar, Plaza
            FROM ReclutaPlaza
           WHERE ID = @IDOrigen AND EstaPendiente = 1
        ELSE
        IF @MovTipo = 'RE.SCO' 
          INSERT ReclutaPlaza (
                 Sucursal,  ID,         Plaza) 
          SELECT @Sucursal, @IDGenerar, Plaza
            FROM ReclutaPlaza
           WHERE ID = @ID AND EstaPendiente = 1
      END
      INSERT ReclutaD (
             Sucursal,  ID,         Renglon, Competencia, Resultado, Valor, ValorMinimo, Peso, Observaciones) 
      SELECT @Sucursal, @IDGenerar, Renglon, Competencia, Resultado, Valor, ValorMinimo, Peso, Observaciones
        FROM ReclutaD
       WHERE ID = @ID       
       
      -- esto es por si se genero basado en un movimiento que tiene origen copie el origen basico
      IF @IDOrigen IS NOT NULL
        UPDATE Recluta 
           SET OrigenTipo = @OrigenTipo,
               Origen = @Origen,
               OrigenID = @OrigenID
         WHERE ID = @IDGenerar

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

    IF @Accion IN ('AFECTAR', 'CANCELAR')
    BEGIN
      -- Afectar Movimiento
      IF @MovTipo = 'RE.SCO'
        UPDATE ReclutaPlaza 
           SET EstaPendiente = CASE WHEN @Accion = 'CANCELAR' THEN 0 ELSE 1 END
         WHERE ID = @ID
              
      IF @MovTipo IN('RE.CO', 'RE.RCO') AND @OrigenMovTipo = 'RE.SCO'
        UPDATE ReclutaPlaza 
           SET EstaPendiente = CASE WHEN @Accion = 'CANCELAR' THEN 1 ELSE 0 END
         WHERE ID = @IDOrigen 
           AND Plaza IN (SELECT Plaza FROM ReclutaPlaza WHERE ID = @ID)
           
      IF @MovTipo IN ('RE.CO', 'RE.EV')
      BEGIN
        IF @Accion = 'AFECTAR'
        BEGIN
          DELETE ReclutaDA
           WHERE ID = @ID
          INSERT ReclutaDA (
                 ID,  Renglon,                                        Competencia, Peso, Resultado, Valor, ValorMinimo, Observaciones)
          SELECT @ID, ROW_NUMBER() OVER(ORDER BY Competencia)*2048.0, Competencia, Peso, Resultado, Valor, ValorMinimo, Observaciones
            FROM PersonalCompetencia
           WHERE Personal = @Personal
         
          DELETE PersonalCompetencia
           WHERE Personal = @Personal
          INSERT PersonalCompetencia (
                 Personal,  Competencia, Peso, Resultado, Valor, ValorMinimo, Observaciones)
          SELECT @Personal, Competencia, Peso, Resultado, Valor, ValorMinimo, Observaciones
            FROM ReclutaD
           WHERE ID = @ID
        END ELSE
        IF @Accion = 'CANCELAR'
        BEGIN
          DELETE PersonalCompetencia
           WHERE Personal = @Personal
          INSERT PersonalCompetencia (
                 Personal,  Competencia, Peso, Resultado, Valor, ValorMinimo, Observaciones)
          SELECT @Personal, Competencia, Peso, Resultado, Valor, ValorMinimo, Observaciones
            FROM ReclutaDA
           WHERE ID = @ID
        END      
      END 

      
      IF @MovTipo = 'RE.AP'
        UPDATE Plaza
           SET Estatus = CASE WHEN @Accion = 'AFECTAR' THEN 'ALTA' ELSE 'AUTORIZARE' END
         WHERE Plaza = (SELECT Plaza FROM ReclutaPlaza WHERE ID = @ID)

     SELECT @PlazasPendientes = NULL
     IF @OrigenMovTipo = 'RE.SCO'
       SELECT @PlazasPendientes = dbo.fnReclutaPlazasPendientes(@IDOrigen)
     
      -- Actualizar Solicitud 
      IF (@OrigenMovTipo = 'RE.SCO' AND @MovTipo IN ('RE.CO', 'RE.RCO')) OR (@OrigenMovTipo = 'RE.SEV' AND @MovTipo = 'RE.EV')
      BEGIN
        UPDATE Recluta 
           SET Estatus = 
                 CASE WHEN @MovTipo IN ('RE.CO', 'RE.RCO', 'RE.EV') AND @Accion = 'AFECTAR'  AND ISNULL(@PlazasPendientes, 0) = 0 THEN 'CONCLUIDO' 
		      WHEN @MovTipo IN ('RE.CO', 'RE.RCO', 'RE.EV') AND @Accion = 'CANCELAR' THEN 'PENDIENTE' 
		      ELSE Estatus
		 END,
               FechaConclusion = 
                 CASE WHEN @MovTipo IN ('RE.CO', 'RE.RCO', 'RE.EV') AND @Accion = 'AFECTAR'  AND ISNULL(@PlazasPendientes, 0) = 0 THEN @FechaRegistro 
		      WHEN @MovTipo IN ('RE.CO', 'RE.RCO', 'RE.EV') AND @Accion = 'CANCELAR' THEN NULL
		      ELSE FechaConclusion
		 END           
         WHERE ID = @IDOrigen
      END

      -- Actualizar Solicitud 
/*      IF @OrigenMovTipo IN ('RE.SCO', 'RE.SEV') 
      BEGIN
        UPDATE Recluta 
           SET Personal = @Personal
         WHERE ID = @IDOrigen
        DELETE ReclutaD
         WHERE ID = @IDOrigen
         
        INSERT ReclutaD (
               ID,        Renglon, Competencia, Peso, Opcion, Valor, Observaciones)
        SELECT @IDOrigen, Renglon, Competencia, Peso, Opcion, Valor, Observaciones
          FROM ReclutaD
         WHERE ID = @ID        
      END*/

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
        UPDATE Recluta
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	       Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza,
               IDOrigen         = @IDOrigen
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END
    
    IF @OrigenMovTipo IS NOT NULL
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @OrigenTipo, @IDOrigen, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT


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

/**************** spRecluta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRecluta') and type = 'P') drop procedure dbo.spRecluta
GO
CREATE PROCEDURE spRecluta
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
    @Personal		varchar(10),
    @Puesto		varchar(50),
    @OrigenTipo		varchar(10),
    @Origen		varchar(20),
    @OrigenID		varchar(20),
    @OrigenMovTipo	varchar(20),
    @IDOrigen		int,
    @OrigenPersonal	varchar(10),
    @OrigenPuesto	varchar(50),
    @OrigenEstatus	varchar(15),
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
         @Concepto = Concepto, @Referencia = Referencia,
         @Personal = NULLIF(RTRIM(Personal), ''), @Puesto = NULLIF(RTRIM(Puesto), ''),
         @OrigenTipo = NULLIF(RTRIM(OrigenTipo), ''), @Origen = NULLIF(RTRIM(Origen), ''), @OrigenID = NULLIF(RTRIM(OrigenID), '')
    FROM Recluta
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT
  IF @OrigenTipo IS NOT NULL AND @Origen IS NOT NULL
  BEGIN
    SELECT @OrigenMovTipo = Clave FROM MovTipo WHERE Modulo = @OrigenTipo AND Mov = @Origen   
    EXEC spMovInfo @IDOrigen OUTPUT, @OrigenTIpo, @Origen, @OrigenID, @OrigenEstatus OUTPUT
    IF @IDOrigen IS NOT NULL AND @OrigenTipo = @Modulo
      SELECT @OrigenPersonal = Personal, @OrigenPuesto = Puesto
        FROM Recluta
       WHERE ID = @IDOrigen    
  END
    
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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA')) OR
     (@Accion = 'GENERAR' AND @Estatus = 'CONCLUIDO')
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
      IF @MovTipo IN ('RE.SCO', 'RE.SEV') 
        SELECT @EstatusNuevo = 'PENDIENTE'
      ELSE
        SELECT @EstatusNuevo = 'CONCLUIDO'
    END   

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spReclutaVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
          	              @Personal, @Puesto, 
          	              @OrigenTipo, @Origen, @OrigenID, @OrigenEstatus, @OrigenMovTipo, @IDOrigen, @OrigenPersonal, @OrigenPuesto,
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
      EXEC spReclutaAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			     @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                             @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
          	             @Personal, @Puesto, 
          	             @OrigenTipo, @Origen, @OrigenID, @OrigenEstatus, @OrigenMovTipo, @IDOrigen, @OrigenPersonal, @OrigenPuesto,
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

PRINT "******************* SP Recluta ******************"
