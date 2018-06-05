SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/********* Gestion ***********/

/**************** spGestionModificarAgenda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGestionModificarAgenda') and type = 'P') drop procedure dbo.spGestionModificarAgenda
GO             
CREATE PROCEDURE spGestionModificarAgenda
    		   @ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ReunionID	int

  BEGIN TRANSACTION 

  DECLARE crModificarAgenda CURSOR FOR
   SELECT g.ID
     FROM Gestion g
     JOIN MovTipo mt ON mt.Modulo = 'GES' AND mt.Mov = g.Mov AND mt.Clave = 'GES.REU'
    WHERE g.IDOrigen = @ID AND g.Estatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA')
  OPEN crModificarAgenda
  FETCH NEXT FROM crModificarAgenda INTO @ReunionID
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      DELETE GestionAgenda WHERE ID = @ReunionID
      INSERT GestionAgenda (
             ID,         Modulo, Mov, MovID, Orden, Sucursal) 
      SELECT @ReunionID, Modulo, Mov, MovID, Orden, Sucursal
        FROM GestionAgenda
       WHERE ID = @ID 
    END
    FETCH NEXT FROM crModificarAgenda INTO @ReunionID
  END
  CLOSE crModificarAgenda
  DEALLOCATE crModificarAgenda

  COMMIT TRANSACTION

  RETURN
END
GO


/**************** spGestionAgendaOtrosModulos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGestionAgendaOtrosModulos') and type = 'P') drop procedure dbo.spGestionAgendaOtrosModulos
GO             
CREATE PROCEDURE spGestionAgendaOtrosModulos
		   @Empresa	varchar(5),
		   @Sucursal	int,
		   @Estacion	int,
    		   @ReunionID	int
--//WITH ENCRYPTION
AS BEGIN
  BEGIN TRANSACTION 
  DECLARE
    @Modulo	varchar(5),
    @ID		int,
    @Mov	varchar(20),
    @MovID	varchar(20),
    @Orden	int

  SELECT @Orden = MAX(Orden) FROM GestionAgenda WHERE ID = @ReunionID
  DECLARE crGestionAgendaOtrosModulos CURSOR FOR
   SELECT l.Modulo, l.ID, m.Mov, m.MovID
     FROM ListaModuloID l
     JOIN Mov m ON m.Empresa = @Empresa AND m.Modulo = l.Modulo AND m.ID = l.ID
    WHERE l.Estacion = @Estacion
  OPEN crGestionAgendaOtrosModulos
  FETCH NEXT FROM crGestionAgendaOtrosModulos INTO @Modulo, @ID, @Mov, @MovID
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF NOT EXISTS(SELECT * FROM GestionAgenda WHERE ID = @ReunionID AND Modulo = @Modulo AND Mov = @Mov AND MovID = @MovID)
      BEGIN
        SELECT @Orden = ISNULL(@Orden, 0) + 1
        INSERT GestionAgenda (
                ID,         Modulo,  Mov,  MovID,  Orden,  Sucursal)
        VALUES (@ReunionID, @Modulo, @Mov, @MovID, @Orden, @Sucursal)
      END
    END
    FETCH NEXT FROM crGestionAgendaOtrosModulos INTO @Modulo, @ID, @Mov, @MovID
  END
  CLOSE crGestionAgendaOtrosModulos
  DEALLOCATE crGestionAgendaOtrosModulos

  COMMIT TRANSACTION

  RETURN
END
GO

/**************** spGestionAgendaAgregarMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGestionAgendaAgregarMov') and type = 'P') drop procedure dbo.spGestionAgendaAgregarMov
GO             
CREATE PROCEDURE spGestionAgendaAgregarMov
			@Empresa	varchar(5),
			@Sucursal	int,
			@Modulo		varchar(5),
    			@ID		int,
			@Reunion	varchar(20),
			@ReunionID	varchar(20),
			@IDReunion	int	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mov	varchar(20),
    @MovID	varchar(20),
    @Orden	int

  IF @IDReunion IS NULL
    SELECT @IDReunion = MIN(g.ID)
  	        FROM Gestion g 
	        JOIN MovTipo mt ON mt.Modulo = 'GES' AND mt.Mov = g.Mov AND mt.Clave = 'GES.REU'
               WHERE g.Empresa = @Empresa AND g.Mov = @Reunion AND g.MovID = @ReunionID AND g.Estatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA')
  IF @IDReunion IS NOT NULL AND @Modulo = 'GES'
  BEGIN
    EXEC spMovInfo @ID, @Modulo, @Mov = @Mov OUTPUT, @MovID = @MovID OUTPUT
    IF @Mov IS NOT NULL AND @MovID IS NOT NULL
      IF NOT EXISTS(SELECT * FROM GestionAgenda WHERE ID = @IDReunion AND Mov = @Mov AND MovID = @MovID)
      BEGIN
        SELECT @Orden = NULL
        SELECT @Orden = MAX(Orden) FROM GestionAgenda WHERE ID = @IDReunion
        SELECT @Orden = ISNULL(@Orden, 0) + 1
        INSERT GestionAgenda (ID, Modulo, Mov, MovID, Orden, Sucursal) VALUES (@IDReunion, @Modulo, @Mov, @MovID, @Orden, @Sucursal)
        EXEC spGestionModificarAgenda @IDReunion
      END
  END
  RETURN
END
GO

/**************** spAfectarTraficoGestion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarTraficoGestion') and type = 'P') drop procedure dbo.spAfectarTraficoGestion
GO
CREATE PROCEDURE spAfectarTraficoGestion
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

  SELECT @Modulo = 'GES', @Ok = NULL, @OkDesc = NULL, @Accion = UPPER(@Accion), @Orden = 0, @PuedeDevolver = 0,
	 @NuevoUsuario = NULL, @NuevoResponsable = NULL, @NuevoEstatus = NULL, @NuevaPrioridad = NULL

  IF @Accion NOT IN ('TRANSFERIR', 'DEVOLVER', 'PRIORIDAD')
    SELECT @Ok = 60030

  IF @Ok IS NULL
  BEGIN
    SELECT @Empresa = Empresa,
           @Propietario = NULLIF(RTRIM(Usuario), ''), 
           @Prioridad = NULLIF(RTRIM(Prioridad), '')
      FROM Gestion
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

      UPDATE Gestion SET PuedeDevolver = @PuedeDevolver, Usuario = @NuevoUsuario WHERE ID = @ID      
    END ELSE
    IF @Accion = 'PRIORIDAD' 
    BEGIN
      IF UPPER(@NuevaPrioridad) <> UPPER(@Prioridad)
      BEGIN
        IF UPPER(@NuevaPrioridad) = 'ALTA' SELECT @NuevoEstatus = 'ALTAPRIORIDAD' ELSE
	IF UPPER(@NuevaPrioridad) = 'BAJA' SELECT @NuevoEstatus = 'PRIORIDADBAJA' 
        ELSE SELECT @NuevoEstatus = 'PENDIENTE'

        EXEC spValidarTareas @Empresa, @Modulo, @ID, @NuevoEstatus, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Gestion
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

/**************** fnTareaEstadoEnEstatus ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTareaEstadoEnEstatus') DROP FUNCTION fnTareaEstadoEnEstatus
GO
CREATE FUNCTION fnTareaEstadoEnEstatus (@Estado varchar(50))
RETURNS varchar(15)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(15)

  IF UPPER(@Estado) = 'COMPLETADA' SELECT @Resultado = 'CONCLUIDO' ELSE
  IF UPPER(@Estado) = 'CANCELADA'  SELECT @Resultado = 'CANCELADO' ELSE
  IF UPPER(@Estado) = 'ELIMINADA'  SELECT @Resultado = 'ELIMINADO' 
  ELSE SELECT @Resultado = 'PENDIENTE' 

  RETURN(@Resultado)
END
GO

/**************** spGestionChecarEstatus ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGestionChecarEstatus') and type = 'P') drop procedure dbo.spGestionChecarEstatus
GO             
CREATE PROCEDURE spGestionChecarEstatus
    		   @ID                		int,
    		   @FechaEmision      		datetime,
    		   @IDDestino			int,
    		   @MovTipoDestino		varchar(20),
    		   @Ok               		int          OUTPUT,
    		   @OkRef            		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MovTipo		varchar(20),
    @Estado		varchar(30),
    @EstatusA		varchar(15),
    @EstatusN		varchar(15),
    @IDOrigen		int,
    @RamaID		int

  IF @ID IS NULL RETURN
  SELECT @RamaID = g.RamaID, @IDOrigen = g.IDOrigen, @EstatusA = g.Estatus, @MovTipo = mt.Clave, @Estado = g.Estado
    FROM Gestion g
    JOIN MovTipo mt ON mt.Modulo = 'GES' AND mt.Mov = g.Mov
   WHERE g.ID = @ID
   
  -- para que no modifique el estatus de la reuion
  IF @MovTipo = 'GES.REU' AND @MovTipoDestino IN ('GES.STAR', 'GES.OTAR', 'GES.SRES') RETURN

  SELECT @EstatusN = 'CONCLUIDO'

  IF @MovTipo IN ('GES.TAR', 'GES.REU') AND @EstatusN = 'CONCLUIDO'
    SELECT @EstatusN = dbo.fnTareaEstadoEnEstatus(@Estado)

  IF @MovTipoDestino <> 'GES.TE'
  BEGIN
    IF EXISTS(SELECT * FROM Gestion WHERE RamaID = @ID AND Estatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA')) 
      SELECT @EstatusN = 'PENDIENTE' 

    IF @EstatusN = 'CONCLUIDO' AND @RamaID IS NULL
      IF NOT EXISTS(SELECT * FROM Gestion WHERE RamaID = @ID AND Estatus = 'CONCLUIDO')
        SELECT @EstatusN = 'PENDIENTE' 
/*
SELECT @IDDestino
SELECT gp.* FROM GestionPara gp 
  LEFT OUTER JOIN Gestion r ON r.ID = gp.RespuestaID 
WHERE gp.ID = @ID AND ((UPPER(gp.Participacion) = 'REQUERIDO' AND gp.RespuestaID IS NULL) OR (r.Estatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA') /*AND gp.RespuestaID<>@IDDestino*/))
  */  
  /*
    IF @EstatusN = 'CONCLUIDO' AND @MovTipo IN ('GES.SRES', 'GES.REU', 'GES.STAR', 'GES.OTAR') 
      IF EXISTS(SELECT gp.Usuario FROM GestionPara gp LEFT OUTER JOIN Gestion r ON r.ID = gp.RespuestaID WHERE gp.ID = @ID AND ((UPPER(gp.Participacion) = 'REQUERIDO' AND gp.RespuestaID IS NULL) OR (r.Estatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA') AND gp.RespuestaID<>@IDDestino)))
        SELECT @EstatusN = 'PENDIENTE'
*/
    -- que hayan respondido todos
    IF @EstatusN = 'CONCLUIDO' AND @MovTipo IN ('GES.SRES', 'GES.REU', 'GES.STAR', 'GES.OTAR') 
      IF EXISTS(SELECT gp.Usuario FROM GestionPara gp LEFT OUTER JOIN Gestion r ON r.ID = gp.RespuestaID WHERE gp.ID = @ID AND ((UPPER(gp.Participacion) = 'REQUERIDO' AND gp.RespuestaID IS NULL)))
        SELECT @EstatusN = 'PENDIENTE'

    -- que tenga hijos pendientes
    IF @EstatusN = 'CONCLUIDO' AND @MovTipo IN ('GES.SRES', 'GES.STAR', 'GES.OTAR') 
      IF EXISTS(SELECT gp.Usuario FROM GestionPara gp LEFT OUTER JOIN Gestion r ON r.ID = gp.RespuestaID WHERE gp.ID = @ID AND r.Estatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA'))
        SELECT @EstatusN = 'PENDIENTE'

  END
/*  
  SELECT @id, @IDDestino, @movtipo, @EstatusN
  SELECT @ok = 1
*/
--arcc
  IF @MovTipoDestino = 'GES.MOD' SET @EstatusN = @EstatusA

  IF @EstatusA <> @EstatusN 
  BEGIN
    UPDATE Gestion 
       SET Estatus = @EstatusN,
           FechaConclusion = CASE WHEN @EstatusN = 'CONCLUIDO' THEN @FechaEmision ELSE NULL END
     WHERE ID = @ID
  END

  IF @IDOrigen IS NOT NULL 
    EXEC spGestionChecarEstatus @IDOrigen, @FechaEmision, @IDDestino, @MovTipo, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO

/**************** spGestionChecarOrigen ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGestionChecarOrigen') and type = 'P') drop procedure dbo.spGestionChecarOrigen
GO             
CREATE PROCEDURE spGestionChecarOrigen
    		   @ID		int,
    		   @FechaA	datetime,
    		   @Ok		int          OUTPUT,
    		   @OkRef	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @IDOrigen		int,
    @OrigenFechaA	datetime,
    @OrigenMov		varchar(20),
    @OrigenMovID	varchar(20),
    @OrigenMovTipo	varchar(20)/*,
    @MovTipo		varchar(20)*/

  IF @ID IS NULL RETURN
  
  --SELECT @MovTipo = mt.Clave FROM Gestion g JOIN MovTipo mt ON g.Mov = mt.Mov AND MT.Modulo = 'GES' WHERE g.ID = @ID
  --IF @MovTipo = 'GES.MOD' AND @OrigenMovTipo NOT IN ('GES.REU') 
  --  SELECT @Ok = 46170, @OkRef = @OrigenMov+' '+@OrigenMovID
  
  SELECT @IDOrigen = g.IDOrigen, @OrigenMov = g.Mov, @OrigenMovID = g.MovID, @OrigenFechaA = g.FechaA, @OrigenMovTipo = mt.Clave
    FROM Gestion g
    JOIN MovTipo mt ON mt.Modulo = 'GES' AND mt.Mov = g.Mov
   WHERE g.ID = @ID

  IF @OrigenMovTipo IN (/*'GES.REU',*/ 'GES.STAR', 'GES.OTAR', 'GES.TAR') AND @OrigenFechaA IS NOT NULL AND @FechaA > @OrigenFechaA
    SELECT @Ok = 46140, @OkRef = @OrigenMov+' '+@OrigenMovID
    
  IF @IDOrigen IS NOT NULL AND @Ok IS NULL
    EXEC spGestionChecarOrigen @IDOrigen, @FechaA, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

/**************** spGestionVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGestionVerificar') and type = 'P') drop procedure dbo.spGestionVerificar
GO
CREATE PROCEDURE spGestionVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		varchar(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		varchar(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
		    @MovUsuario			char(10),

		    @IDOrigen			int,
		    @OrigenTipo			varchar(10),
		    @Origen			varchar(20),
		    @OrigenID			varchar(20),
		    @OrigenMovTipo		varchar(20),
		    @OrigenFechaD		datetime, 
		    @OrigenFechaA		datetime, 
		    @OrigenTodoElDia		bit,
		    @OrigenHoraD		varchar(5),
		    @OrigenHoraA		varchar(5),

		    @Estado			varchar(30),
		    @Avance			float,
		    @FechaD			datetime,
		    @FechaA			datetime,
		    @TodoElDia			bit,
		    @HoraD			varchar(5),
		    @HoraA			varchar(5),
		    @Motivo			varchar(255),

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OrigenEstatus		varchar(15),
    @CfgCompletarEnAvances	bit,
    @SubClave			varchar(20),
    @AFArticulo			varchar(20),
    @AFSerie			varchar(50)

  SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo --ARCC GESTION
    
  SELECT @AfArticulo = ISNULL(AfArticulo,''), @AfSerie = ISNULL(AfSerie,'') FROM Gestion WHERE ID = @ID

  SELECT @CfgCompletarEnAvances = ISNULL(PermiteCompletarEnAvances, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  IF @Accion = 'CANCELAR' 
  BEGIN
    -- Checar que se haya Gestiondo el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo AND OModulo <> 'PROY')
	SELECT @Ok = 60070
    IF @MovTipo = 'GES.MOD' SELECT @Ok = 46070

    IF @MovTipo = 'GES.AV' AND @Ok IS NULL
      IF EXISTS(SELECT * FROM Gestion g JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = g.Mov WHERE g.IDOrigen = @IDOrigen AND g.Estatus = 'CONCLUIDO' AND mt.Clave = 'GES.TE')
        SELECT @Ok = 46160, @OkRef = @Origen + ' ' + @OrigenID
  END ELSE
  BEGIN  	
    IF @MovTipo IN ('GES.SRES') AND @Estatus = 'SINAFECTAR' AND @SubClave IN ('MAF.SI') AND EXISTS(SELECT * FROM Gestion g JOIN MovTipo mt ON g.Mov = mt.Mov WHERE g.Estatus IN ('PENDIENTE') AND mt.Clave IN ('GES.SRES') AND mt.SubClave IN ('MAF.SI') AND AFArticulo = @AfArticulo AND AFSerie = @AFSerie)
      SELECT @Ok = 46220  	
    IF @MovTipo IN ('GES.SRES') AND @Estatus = 'SINAFECTAR' AND @SubClave IN ('MAF.SI') AND NOT EXISTS(SELECT * FROM GestionActivoFIndicador WHERE ID = @ID)
      SELECT @Ok = 46200
    IF @MovTipo IN ('GES.RES') AND @Estatus = 'SINAFECTAR' AND @SubClave IN ('MAF.I') AND EXISTS(SELECT * FROM GestionActivoFIndicador WHERE ID = @ID AND NULLIF(Lectura,'') IS NULL)	
      SELECT @Ok = 46210
    IF @MovTipo IN ('GES.RES') AND @Estatus = 'SINAFECTAR' AND @SubClave IN ('MAF.I') AND @Origen IS NULL	
      SELECT @Ok = 46020
  	
    IF @MovTipo = 'GES.NO' AND @OrigenMovTipo = 'GES.OTAR'
      SELECT @Ok = 46190
    ELSE
    IF @MovTipo IN ('GES.MOD', 'GES.NO', 'GES.AV', 'GES.TE')
    BEGIN
      IF @IDOrigen IS NULL SELECT @Ok = 46020 ELSE
      IF @MovTipo = 'GES.MOD' AND NOT EXISTS(SELECT * FROM Gestion WHERE ID = @IDOrigen AND Estatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA')) SELECT @Ok = 46060 
    END ELSE
    IF @MovTipo IN ('GES.SRES', 'GES.STAR', 'GES.OTAR')
    BEGIN
      IF NOT EXISTS(SELECT * FROM GestionPara WHERE ID = @ID)
        SELECT @Ok = 46010 
    END
    
    IF @MovTipo IN ('GES.STAR', 'GES.OTAR')
    BEGIN        
      IF (SELECT COUNT(*) FROM GestionPara WHERE ID = @ID) > 1
        SELECT @Ok = 46180         
    END
    IF @OrigenMovTipo IN ('GES.SRES', 'GES.REU', 'GES.STAR', 'GES.OTAR') AND @MovTipo <> 'GES.MOD' AND @Ok IS NULL AND (@Usuario <> @MovUsuario OR @MovTipo IN ('GES.RES', 'GES.TAR', 'GES.OK', 'GES.NO'))
    BEGIN
      IF NOT EXISTS(SELECT * FROM GestionPara WHERE ID = @IDOrigen AND Usuario = @Usuario)
        SELECT @Ok = 46080
      ELSE
      IF EXISTS(SELECT * FROM GestionPara WHERE ID = @IDOrigen AND Usuario = @Usuario AND RespuestaID IS NOT NULL)
        SELECT @Ok = 46085
    END
    IF @MovTipo = 'GES.REU' AND @Ok IS NULL
    BEGIN
      IF @FechaD IS NULL OR @FechaA IS NULL SELECT @Ok = 46100
    END
    IF @MovTipo IN ('GES.STAR', 'GES.OTAR') AND @Ok IS NULL
    BEGIN
      IF @FechaA IS NULL SELECT @Ok = 46100
    END    
    IF @MovTipo = 'GES.NO' AND @Motivo IS NULL AND @Ok IS NULL
      SELECT @Ok = 46110
    IF @MovTipo IN ('GES.REU', 'GES.TAR', 'GES.AV') AND @CfgCompletarEnAvances = 0 AND dbo.fnTareaEstadoEnEstatus(@Estado) <> 'PENDIENTE' AND @Ok IS NULL
      SELECT @Ok = 46120, @OkRef = @Origen

    IF @Ok IS NULL
      EXEC spGestionChecarOrigen @ID, @FechaA, @Ok OUTPUT, @OkRef OUTPUT

    IF ((@MovTipo = 'GES.OK') OR (@OrigenMovTipo IN ('GES.STAR', 'GES.OTAR') AND @MovTipo = 'GES.TAR')) AND @Ok IS NULL
	    BEGIN
      IF @FechaD <> @OrigenFechaD OR @FechaA <> @OrigenFechaA OR @TodoElDia <> @OrigenTodoElDia OR @HoraD <> @OrigenHoraD OR @HoraA <> @OrigenHoraA
        SELECT @Ok = 46150, @OkRef = 'Fechas'
    END
    IF (@OrigenMovTipo = 'GES.REU' AND @MovTipo = 'GES.OK') AND @Ok IS NULL
    BEGIN
      IF (SELECT Modulo, Mov, MovID FROM GestionAgenda WHERE ID = @ID FOR XML RAW) <> (SELECT Modulo, Mov, MovID FROM GestionAgenda WHERE ID = @IDOrigen FOR XML RAW)
        SELECT @Ok = 46150, @OkRef = 'Agenda'
    END
    IF @MovTipo = 'GES.MOD' AND @OrigenMovTipo IN ('GES.SRES', 'GES.REU', 'GES.STAR', 'GES.OTAR') AND @Ok IS NULL
      IF EXISTS(SELECT * FROM GestionPara WHERE ID = @IDOrigen AND RespuestaID IS NOT NULL) SELECT @Ok = 46170
  END

  IF (@Accion = 'CANCELAR' OR @MovTipo = 'GES.MOD') AND @Ok IS NULL
    IF EXISTS(SELECT * 
                FROM Gestion g
                JOIN MovTipo mt ON mt.Modulo = 'GES' AND mt.Mov = g.Mov
               WHERE g.IDOrigen = @ID AND g.Estatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA', 'CONCLUIDO') AND mt.Clave <> 'GES.MOD')
      SELECT @Ok = 46090, @OkRef = RTRIM(@Mov)+' '+ISNULL(RTRIM(@MovID), '')

  RETURN
END
GO

--REQ16092
/**************** spGestionOportunidadActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGestionOportunidadActualizar') and type = 'P') drop procedure dbo.spGestionOportunidadActualizar
GO
CREATE PROC spGestionOportunidadActualizar
			@ID				int, 
			@FechaEmision	datetime,
			@IDOrigen		int, 
			@Accion			varchar(20), 
			@Empresa		varchar(5), 
			@Modulo			varchar(5), 
			@Mov			varchar(20), 
			@MovID			varchar(20), 
			@Avance			float,
			@Estado			varchar(30),
			@Usuario		varchar(10),
			@Ok				int				OUTPUT, 
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @OrigenTipo	varchar(20),
		  @Origen		varchar(20),
		  @OrigenID		varchar(20),
		  @IDOPORT		int

  IF @IDOrigen IS NOT NULL
  BEGIN
    SELECT @OrigenTipo = ISNULL(OrigenTipo, ''),
  		   @Origen	   = ISNULL(Origen, ''),
		   @OrigenID   = ISNULL(OrigenID, '')
      FROM Gestion 
     WHERE ID = @IDOrigen

    IF @OrigenTipo = 'OPORT'
    BEGIN
      SELECT @IDOPORT = ID
        FROM Oportunidad
       WHERE Empresa = @Empresa
         AND Mov   = @Origen
         AND MovID = @OrigenID

     IF @Avance <> 100.0 SELECT @FechaEmision = NULL

      UPDATE OportunidadD
         SET PorcentajeAvance = @Avance,
			 Estado	= @Estado,
			 FechaA = @FechaEmision,
			 Usuario = @Usuario,
			 MovGestion = RTRIM(@Mov)+' '+RTRIM(@MovID)
       WHERE ID = @IDOPORT
         AND IDGestion = @IDOrigen
    END
  END
  ELSE
  BEGIN
    IF @Accion = 'CANCELAR'
    BEGIN
      SELECT @OrigenTipo = ISNULL(OrigenTipo, ''),
  		     @Origen	   = ISNULL(Origen, ''),
		     @OrigenID   = ISNULL(OrigenID, '')
        FROM Gestion 
       WHERE ID = @ID

      IF @OrigenTipo = 'OPORT'
      BEGIN
        SELECT @IDOPORT = ID
          FROM Oportunidad
         WHERE Empresa = @Empresa
           AND Mov   = @Origen
           AND MovID = @OrigenID    

        UPDATE OportunidadD
           SET PorcentajeAvance = 0,
               Estado = 'No Comenzada',
               IDGestion = NULL,
               Fecha = NULL,
               FechaA = NULL,
			   Usuario = @Usuario,
			   MovGestion = RTRIM(@Mov)+' '+RTRIM(@MovID)
         WHERE ID = @IDOPORT
           AND IDGestion = @ID
      END
    END    
  END
  RETURN
END
GO


--REQ PROYECTOS
/**************** spGestionProyectoActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGestionProyectoActualizar') and type = 'P') drop procedure dbo.spGestionProyectoActualizar
GO
CREATE PROC spGestionProyectoActualizar
			@ID				int, 
			@FechaEmision	datetime,
			@IDOrigen		int, 
			@Accion			varchar(20), 
			@Empresa		varchar(5), 
			@Modulo			varchar(5), 
			@Mov			varchar(20), 
			@MovID			varchar(20), 
			@Avance			float,
			@Esfuerzo		float,
			@Estado			varchar(30),
			@Usuario		varchar(10),
			@Ok				int				OUTPUT, 
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @OrigenTipo	varchar(20),
		  @Origen		varchar(20),
		  @OrigenID		varchar(20),
		  @IDProyecto   int

  IF @IDOrigen IS NOT NULL
  BEGIN
    SELECT @OrigenTipo = ISNULL(OrigenTipo, ''),
  		   @Origen	   = ISNULL(Origen, ''),
		   @OrigenID   = ISNULL(OrigenID, '')
      FROM Gestion 
     WHERE ID = @IDOrigen


    IF @OrigenTipo = 'PROY'
    BEGIN
      SELECT @IDProyecto = ID
        FROM Proyecto
       WHERE Empresa = @Empresa
         AND Mov   = @Origen
         AND MovID = @OrigenID

     IF @Avance <> 100.0 SELECT @FechaEmision = NULL

      UPDATE ProyectoD
         SET Avance = @Avance,
			 Estado	= @Estado,
			 Esfuerzo = @Esfuerzo,
			 --Fin = @FechaEmision,
			 Usuario = @Usuario,
			 MovGestion = RTRIM(@Mov)+' '+RTRIM(@MovID)
       WHERE ID = @IDProyecto
         AND IDGestion = @IDOrigen
    END
  END
  ELSE
  BEGIN
    IF @Accion = 'CANCELAR'
    BEGIN
      SELECT @OrigenTipo = ISNULL(OrigenTipo, ''),
  		     @Origen	   = ISNULL(Origen, ''),
		     @OrigenID   = ISNULL(OrigenID, '')
        FROM Gestion 
       WHERE ID = @ID

      IF @OrigenTipo = 'PROY'
      BEGIN
        SELECT @IDProyecto = ID
          FROM Proyecto
         WHERE Empresa = @Empresa
           AND Mov   = @Origen
           AND MovID = @OrigenID    

        UPDATE ProyectoD
           SET Avance = 0,
               Estado = 'No Comenzada',
               IDGestion = NULL,
               --Fecha = NULL,
               --FechaA = NULL,
			   Usuario = @Usuario,
			   MovGestion = RTRIM(@Mov)+' '+RTRIM(@MovID)
         WHERE ID = @IDProyecto
           AND IDGestion = @ID
      END
    END    
  END

  RETURN
END
GO


/**************** spGestionAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGestionAfectar') and type = 'P') drop procedure dbo.spGestionAfectar
GO             
CREATE PROCEDURE spGestionAfectar
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
		   @FechaAutorizacion		datetime,
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

		   @IDOrigen			int,
		   @OrigenTipo			varchar(10),
		   @Origen			varchar(20),
		   @OrigenID			varchar(20),
		   @OrigenMovTipo		varchar(20),

		   @Estado			varchar(30),
		   @EstadoAnterior		varchar(30),
		   @Avance				float,
		   @AvanceAnterior		float,
		   @Esfuerzo			float,
		   @EsfuerzoAnterior	float,

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
	           --REQ16092
    		   @OPORT						bit,
			   --REQ PROYECTOS
			   @ProyEnviarTareaGestion      bit,
		   @IDGenerar			int	     	OUTPUT,	
    		   @GenerarMovID	  	varchar(20)	OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CancelarID			int,
    @FechaCancelacion		datetime,
    @GenerarMovTipo		char(20),
    @GenerarPeriodo		int,
    @GenerarEjercicio		int,
    @OrigenEstatus		varchar(15),
    @GastoAnexoTotalPesos	money,
    @RID			int,
    @EstatusD			varchar(15),
    @SubClave			varchar(20),
    @AFArticulo			varchar(20),
    @AFSerie			varchar(50)    
  
  SELECT @GastoAnexoTotalPesos  = NULL

  SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo
  
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

  IF @EstatusNuevo = 'AUTORIZAR' AND @Ok IS NULL
  BEGIN
    EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @EstatusNuevo
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
      IF ((@MovTipo NOT IN ('GES.REU')) OR (@GenerarMovTipo NOT IN ('GES.STAR', 'GES.OTAR'))) BEGIN   	
        INSERT GestionPara (
               ID,         Usuario, Participacion, Sucursal) 
        SELECT @IDGenerar, Usuario, Participacion, @Sucursal
          FROM GestionPara
         WHERE ID = @ID 
      END 
      INSERT GestionAgenda (
             ID,         Modulo, Mov, MovID, Orden, Sucursal) 
      SELECT @IDGenerar, Modulo, Mov, MovID, Orden, @Sucursal
        FROM GestionAgenda
       WHERE ID = @ID 
       
      IF @SubClave IN ('MAF.SI') AND @GenerarMovTipo IN ('GES.RES') --ARCC GESTION
      BEGIN
        INSERT GestionActivoFIndicador (
               ID,         Tipo, Indicador, Referencia, LecturaAnterior, Lectura) 
        SELECT @IDGenerar, Tipo, Indicador, Referencia, LecturaAnterior, Lectura
          FROM GestionActivoFIndicador
         WHERE ID = @ID       	
      END       
       
      IF @Ok IS NULL SELECT @Ok = 80030
    END
    RETURN
  END

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Cancelar Movimientos Generados en el Mismo Modulo
/*    IF @Accion = 'CANCELAR'
    BEGIN
      DECLARE crGestionCancelar CURSOR FOR
       SELECT ID
         FROM Gestion
        WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      OPEN crGestionCancelar
      FETCH NEXT FROM crGestionCancelar INTO @CancelarID
      WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
          EXEC spAfectar @Modulo, @CancelarID, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

        FETCH NEXT FROM crGestionCancelar INTO @CancelarID
      END
      CLOSE crGestionCancelar
      DEALLOCATE crGestionCancelar
    END*/

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    -- Aqui va la Afectacion
    IF @Accion IN ('AFECTAR', 'CANCELAR') 
    BEGIN
      IF @OrigenMovTipo IN ('GES.SRES', 'GES.REU', 'GES.STAR', 'GES.OTAR')  AND @MovTipo NOT IN ('GES.MOD', 'GES.AV', 'GES.TE')
        UPDATE GestionPara 
           SET RespuestaID = CASE WHEN @Accion = 'CANCELAR' THEN NULL ELSE @ID END
         WHERE ID = @IDOrigen AND Usuario = @Usuario
         
      IF @MovTipo = 'GES.MOD'
      BEGIN
        UPDATE Gestion
           SET Proyecto = n.Proyecto, UEN = n.UEN, Prioridad = n.Prioridad, Concepto = n.Concepto, Referencia = n.Referencia, Observaciones = n.Observaciones, Comentarios = n.Comentarios,
               Asunto = n.Asunto, Espacio = n.Espacio, FechaD = n.FechaD, FechaA = n.FechaA, TodoElDia = n.TodoElDia, HoraD = n.HoraD, HoraA = n.HoraA,
               Estado = n.Estado, Avance = n.Avance, Duracion = n.Duracion
          FROM Gestion
          JOIN Gestion n ON n.ID = @ID
         WHERE Gestion.ID = @IDOrigen

        DELETE GestionPara WHERE ID = @IDOrigen
        INSERT GestionPara (
               ID,        Usuario, Participacion, Sucursal)
        SELECT @IDOrigen, Usuario, Participacion, Sucursal
          FROM GestionPara
         WHERE ID = @ID

        DELETE GestionAgenda WHERE ID = @IDOrigen
        INSERT GestionAgenda (
               ID,        Modulo, Mov, MovID, Orden, Sucursal)
        SELECT @IDOrigen, Modulo, Mov, MovID, Orden, Sucursal
          FROM GestionAgenda
         WHERE ID = @ID
      END

      IF @MovTipo NOT IN ('GES.SRES', 'GES.REU', 'GES.STAR', 'GES.OTAR', 'GES.MOD')
        DELETE GestionPara WHERE ID = @ID
      IF @MovTipo NOT IN ('GES.REU', 'GES.MOD', 'GES.AV', 'GES.TE')
        DELETE GestionAgenda WHERE ID = @ID


      IF @OrigenMovTipo = 'GES.REU' AND @MovTipo NOT IN ('GES.MOD', 'GES.AV', 'GES.TE', 'GES.OK', 'GES.NO')
        EXEC spGestionAgendaAgregarMov @Empresa, @Sucursal, @Modulo, @ID, @Origen, @OrigenID, @IDOrigen

      IF @MovTipo IN ('GES.AV', 'GES.TE')
      BEGIN
        IF @Accion = 'CANCELAR'
          UPDATE Gestion SET Estado = @EstadoAnterior, Avance = @AvanceAnterior, Esfuerzo = @EsfuerzoAnterior WHERE ID = @IDOrigen
        ELSE BEGIN
          SELECT @EstadoAnterior = Estado, @AvanceAnterior = Avance, @EsfuerzoAnterior = Esfuerzo FROM Gestion WHERE ID = @IDOrigen
          IF @MovTipo = 'GES.TE' SELECT @Estado = 'Completada', @Avance = 100.0          
				UPDATE Gestion SET Estado = @Estado, Avance = @Avance, Esfuerzo = @Esfuerzo WHERE ID = @IDOrigen          
        END
      END

      --REQ16092
      IF @OPORT = 1
      BEGIN
        IF @Accion = 'CANCELAR'
          EXEC spGestionOportunidadActualizar @ID, @FechaEmision, @IDOrigen, @Accion, @Empresa, @Modulo, @Mov, @MovID, @AvanceAnterior, @EstadoAnterior, @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        ELSE
          EXEC spGestionOportunidadActualizar @ID, @FechaEmision, @IDOrigen, @Accion, @Empresa, @Modulo, @Mov, @MovID, @Avance, @Estado, @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT        
      END
      

      --REQ PROYECTOS
      IF @ProyEnviarTareaGestion = 1
      BEGIN
        IF @Accion = 'CANCELAR'
          EXEC spGestionProyectoActualizar @ID, @FechaEmision, @IDOrigen, @Accion, @Empresa, @Modulo, @Mov, @MovID, @AvanceAnterior, @EsfuerzoAnterior, @EstadoAnterior, @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT          
        ELSE
          EXEC spGestionProyectoActualizar @ID, @FechaEmision, @IDOrigen, @Accion, @Empresa, @Modulo, @Mov, @MovID, @Avance, @Esfuerzo, @Estado, @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT        
      END

      -- Cancelar Modificaciones al Movimiento
      IF @Accion = 'CANCELAR'
        UPDATE Gestion 
           SET Estatus = 'CANCELADO', FechaCancelacion = @FechaRegistro
          FROM Gestion g
          JOIN MovTipo mt ON mt.Modulo = 'GES' AND mt.Mov = g.Mov
         WHERE g.IDOrigen = @ID AND g.Estatus = 'CONCLUIDO' AND mt.Clave = 'GES.MOD'
 
      -- Afectar Gastos Anexos
      IF EXISTS(SELECT * FROM Gasto WHERE AnexoModulo = @Modulo AND AnexoID = @ID) AND @Ok IS NULL
      BEGIN
        EXEC spGastoAnexo @Empresa, @Modulo, @ID, @Accion, @FechaRegistro, @Usuario, @GastoAnexoTotalPesos OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spGastoAnexoEliminar @Empresa, @Modulo, @ID
      END

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
        UPDATE Gestion
           SET Estado           = @Estado,
               EstadoAnterior   = CASE WHEN @MovTipo IN ('GES.AV', 'GES.TE') AND @Accion <> 'CANCELAR' THEN @EstadoAnterior ELSE NULL END,
               Avance		= @Avance,
               AvanceAnterior   = CASE WHEN @MovTipo IN ('GES.AV', 'GES.TE') AND @Accion <> 'CANCELAR' THEN @AvanceAnterior ELSE NULL END,
               Esfuerzo			= @Esfuerzo,
               EsfuerzoAnterior   = CASE WHEN @MovTipo IN ('GES.AV', 'GES.TE') AND @Accion <> 'CANCELAR' THEN @EsfuerzoAnterior ELSE NULL END,
               FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	           Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               Autorizacion     = @Autorizacion,
               FechaAutorizacion= @FechaAutorizacion,
               Gastos           = NULLIF(@GastoAnexoTotalPesos, 0.0)
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END

      IF @Accion = 'AFECTAR' AND @MovTipo = 'GES.RES' AND @EstatusNuevo = 'CONCLUIDO' AND @Ok IS NULL --ARCC GESTION
      BEGIN
        EXEC spMAFActualizarIndicadorAF @ID, @FechaConclusion, @Ok OUTPUT, @OkRef OUTPUT      	

        IF @Ok IS NULL
        BEGIN
          SELECT @AFArticulo = AFarticulo, @AFSerie = AFSerie FROM Gestion WHERE ID = @ID	
          EXEC spMAFGenerarServicios @Empresa, @Sucursal, @Accion, @Usuario, @ID, @AFArticulo, @AFSerie, 0, @Ok OUTPUT, @OkRef OUTPUT		                  
        END                   
      END

      -- Afectar Origen
      IF @Ok IN (NULL, 80030) AND @IDOrigen IS NOT NULL
      BEGIN
        EXEC spGestionChecarEstatus @IDOrigen, @FechaEmision, @ID, @MovTipo, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @OrigenTipo, @IDOrigen, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
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

/**************** spGestionCancelarHijos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGestionCancelarHijos') and type = 'P') drop procedure dbo.spGestionCancelarHijos
GO
CREATE PROCEDURE spGestionCancelarHijos
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
  DECLARE
    @CancelarID	int

  BEGIN TRANSACTION 

  DECLARE crGestionCancelar CURSOR FOR
   SELECT g.ID
     FROM Gestion g
     JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = g.Mov 
    WHERE g.IDOrigen = @ID AND g.Estatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA', 'CONCLUIDO')
  OPEN crGestionCancelar
  FETCH NEXT FROM crGestionCancelar INTO @CancelarID
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spAfectar @Modulo, @CancelarID, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    FETCH NEXT FROM crGestionCancelar INTO @CancelarID
  END
  CLOSE crGestionCancelar
  DEALLOCATE crGestionCancelar

  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  RETURN
END
GO

/**************** spGestion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGestion') and type = 'P') drop procedure dbo.spGestion
GO
CREATE PROCEDURE spGestion
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
    @FechaAutorizacion	datetime,
    @DocFuente	      	int,
    @Concepto    	varchar(50),
    @Referencia 	varchar(50),
    @Observaciones    	varchar(255),
    @Prioridad		varchar(10),
    
    @RamaID		int,
    @IDOrigen		int,
    @OrigenTipo		varchar(10),
    @Origen		varchar(20),
    @OrigenID		varchar(20),
    @OrigenMovTipo	varchar(20),
    @OrigenFechaD	datetime,
    @OrigenFechaA	datetime,
    @OrigenTodoElDia	bit,
    @OrigenHoraD	varchar(5),
    @OrigenHoraA	varchar(5),

    @Estado		varchar(30),
    @EstadoAnterior	varchar(30),
    @Avance		float,
    @AvanceAnterior	float,

    @FechaD		datetime,
    @FechaA		datetime,
    @TodoElDia		bit,
    @HoraD		varchar(5),
    @HoraA		varchar(5),
    @Motivo		varchar(255),

    @Estatus          		char(15),
    @EstatusNuevo		char(15),
    @Ejercicio	      		int,
    @Periodo	      		int,
    @GenerarMovID		varchar(20),
    @GenerarPoliza		bit,
    @CfgContX			bit,
    @CfgContXGenerar		char(20),
    @RequiereAutorizacion	bit,
    
    --REQ16092
    @OPORT				bit,
	--REQ PROYECTOS
	@ProyEnviarTareaGestion bit,
	@Esfuerzo			float,
    @EsfuerzoAnterior	float

  -- Inicializar Variables
  SELECT @Generar	   = 0,
	 @GenerarAfectado  = 0,
         @CfgContX         = 0,
         @CfgContXGenerar  = 'NO'/*,
	 @Verificar        = 1*/

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = NULLIF(RTRIM(Proyecto), ''), @UEN = UEN,
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, @FechaAutorizacion = FechaAutorizacion,
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @FechaConclusion = FechaConclusion,
         @Concepto = Concepto, @Referencia = Referencia,
         @IDOrigen = IDOrigen, @OrigenTipo = NULLIF(RTRIM(OrigenTipo), ''), @Origen = NULLIF(RTRIM(Origen), ''), @OrigenID = NULLIF(RTRIM(OrigenID), ''),
         @FechaD = FechaD, @FechaA = FechaA, @TodoElDia = ISNULL(TodoElDia, 0), @HoraD = ISNULL(RTRIM(HoraD), ''), @HoraA = ISNULL(RTRIM(HoraA), ''),
         @Motivo = NULLIF(RTRIM(Motivo), ''), 
         @Estado = Estado, @EstadoAnterior = EstadoAnterior, @Avance = ISNULL(Avance, 0.0), @AvanceAnterior = ISNULL(AvanceAnterior, 0.0),
         @Esfuerzo = ISNULL(Esfuerzo, 0.0), @EsfuerzoAnterior = ISNULL(EsfuerzoAnterior, 0.0),
         @Prioridad = Prioridad
    FROM Gestion
   WHERE ID = @ID

  IF @Accion = 'AUTORIZAR' AND @Estatus = 'AUTORIZAR'
  BEGIN
    IF EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND Autorizar = 1 AND AutorizarGestion = 1)
      SELECT @Autorizacion = @Usuario, @FechaAutorizacion = @FechaRegistro, @Estatus = 'SINAFECTAR', @Accion = 'AFECTAR'
    ELSE SELECT @Ok = 46130
  END

  IF @IDOrigen IS NULL AND @OrigenTipo = @Modulo AND @Origen IS NOT NULL AND @OrigenID IS NOT NULL 
    SELECT @IDOrigen = MIN(ID) FROM Gestion WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA', 'CONCLUIDO')

  IF @IDOrigen IS NOT NULL 
  BEGIN
    SELECT @RamaID = ISNULL(RamaID, ID),
           @OrigenFechaD = FechaD,
           @OrigenFechaA = FechaA,
           @OrigenTodoElDia = ISNULL(TodoElDia, 0),
           @OrigenHoraD = ISNULL(RTRIM(HoraD), ''),
           @OrigenHoraA = ISNULL(RTRIM(HoraA), '')
      FROM Gestion 
     WHERE ID = @IDOrigen
    UPDATE Gestion 
       SET RamaID = @RamaID,
           IDOrigen = @IDOrigen
     WHERE ID = @ID
  END

  IF @IDOrigen IS NOT NULL
    SELECT @OrigenMovTipo = Clave
      FROM MovTipo
     WHERE Modulo = @Modulo AND Mov = @Origen

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  SELECT @RequiereAutorizacion = ISNULL(RequiereAutorizacion, 0)
    FROM MovTipo
   WHERE Modulo = @Modulo AND Mov = @Mov

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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA'))
  BEGIN
    SELECT @CfgContX = ContX,
		   --REQ16092
		   @OPORT	= ISNULL(OPORT, 0)
      FROM EmpresaGral
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

	-- REQ PROYECTOS
	SELECT @ProyEnviarTareaGestion = ProyEnviarTareaGestion
	  FROM EmpresaCfg
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
      IF @RequiereAutorizacion = 1 AND @Autorizacion IS NULL AND @FechaAutorizacion IS NULL
        SELECT @EstatusNuevo = 'AUTORIZAR' 
      ELSE BEGIN
        SELECT @EstatusNuevo = 'CONCLUIDO' 

        IF @MovTipo IN ('GES.REU', 'GES.TAR') 
          SELECT @EstatusNuevo = dbo.fnTareaEstadoEnEstatus(@Estado)
        ELSE
        IF @MovTipo IN ('GES.SRES', 'GES.REU', 'GES.STAR', 'GES.OTAR')
          IF EXISTS(SELECT * FROM GestionPara WHERE ID = @ID AND UPPER(Participacion) = 'REQUERIDO')
            SELECT @EstatusNuevo = CASE UPPER(@Prioridad) WHEN 'ALTA' THEN 'ALTAPRIORIDAD' WHEN 'BAJA' THEN 'PRIORIDADBAJA' ELSE 'PENDIENTE' END
      END
    END

    IF @MovTipo IN ('GES.SRES', 'GES.REU', 'GES.STAR', 'GES.OTAR') AND @Accion = 'CANCELAR' AND @Estatus = 'PENDIENTE'
      EXEC spGestionCancelarHijos @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, @Mov, @MovID, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spGestionVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
            	              @Conexion, @SincroFinal, @Sucursal, @MovUsuario,
                              @IDOrigen, @OrigenTipo, @Origen, @OrigenID, @OrigenMovTipo, @OrigenFechaD, @OrigenFechaA, @OrigenTodoElDia, @OrigenHoraD, @OrigenHoraA, 
 		  	      @Estado, @Avance, @FechaD, @FechaA, @TodoElDia, @HoraD, @HoraA, @Motivo,
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
      EXEC spGestionAfectar @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
  		  	    @Proyecto, @UEN, @Usuario, @Autorizacion, @FechaAutorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                            @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, 
                            @IDOrigen, @OrigenTipo, @Origen, @OrigenID, @OrigenMovTipo,
			    @Estado, @EstadoAnterior, @Avance, @AvanceAnterior, @Esfuerzo, @EsfuerzoAnterior,
		            @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
		                    --REQ16092
                            @Generar, @GenerarMov, @GenerarAfectado, @OPORT, @ProyEnviarTareaGestion,  @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                            @Ok OUTPUT, @OkRef OUTPUT
  END ELSE 
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'AUTORIZAR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
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

PRINT "******************* SP Gestion ******************"
GO
