SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF

/* SP CONTRATO    */

--PACTO.C = Contrato
--PACTO.R = Renovacion

/**************** spContratoCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContratoCerrarDia') and type = 'P') drop procedure dbo.spContratoCerrarDia
GO
CREATE PROCEDURE spContratoCerrarDia
	@Fecha			datetime,
	@Ok			int		OUTPUT,
	@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
	DECLARE
		@ID		int
	
	DECLARE crContratoCerrarDia CURSOR FOR
		SELECT ID
		FROM Contrato
		WHERE Estatus IN ('PENDIENTE', 'VIGENTE', 'VENCIDO')
	
	OPEN crContratoCerrarDia
	FETCH NEXT FROM crContratoCerrarDia INTO @ID
	WHILE @@FETCH_STATUS <> -1 
	BEGIN
		IF @@FETCH_STATUS <> -2 
		BEGIN
			--SELECT 'Va el ID: ' + CONVERT(varchar(20), ID) + char(13) + 'Movimiento: ' + RTRIM(Mov) + ' ' + LTRIM(MovID) FROM Contrato WHERE ID = @ID
			EXEC spAfectar 'PACTO', @ID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
		END
		FETCH NEXT FROM crContratoCerrarDia INTO @ID
	END  -- While	
	CLOSE crContratoCerrarDia
	DEALLOCATE crContratoCerrarDia
	RETURN
END
GO

IF EXISTS(SELECT * FROM Sysobjects WHERE Id = OBJECT_ID('dbo.xpContratoAfectar') AND Type = 'P') DROP PROC dbo.xpContratoAfectar
GO
CREATE PROCEDURE dbo.xpContratoAfectar 
        @ID                             int,
        @Accion                         char(20),
        @Empresa                        char(5),
        @Modulo                         char(5),
        @Mov                            char(20),
        @MovID                          varchar(20),
        @MovTipo                        varchar(20),
        @FechaEmision                   datetime,
        @FechaAfectacion                datetime,
        @FechaConclusion                datetime,
        @Estatus                        varchar(15),
        @EstatusNuevo                   varchar(15),
        @IDGenerar                      int             OUTPUT,
        @Usuario                        varchar(10),
        @Ok                             int             OUTPUT,
        @OkRef                          varchar(255)    OUTPUT
AS 
BEGIN
    RETURN
END
GO
/*
	@ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @Estatus, @EstatusNuevo, 
	@ContactoTipo, @Prospecto, @Cliente, @Proveedor, @Personal, @Agente, @ContratoRama,
	@Desde, @Hasta, @Prioridad, @Comentarios, @Documento, @Titulo,
	@FechaRegistro, @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT
*/

if exists (select * from sysobjects where id = object_id('dbo.xpContratoVerificar') and type = 'P') drop procedure dbo.xpContratoVerificar
GO
CREATE PROCEDURE xpContratoVerificar
	@ID				int,
	@Accion				char(20),
	@Empresa			char(5),
	@Usuario			char(10),
	@Modulo				char(5),
	@Mov				char(20),
	@MovID				varchar(20),
	@MovTipo			char(20),
	@FechaEmision			datetime,
	@Estatus			char(15),
	@EstatusNuevo			char(15),
	
	@ContactoTipo			varchar(20),
	@Prospecto			varchar(10),
	@Cliente			varchar(10),
	@Proveedor			varchar(10),
	@Personal			varchar(10),
	@Agente				varchar(10),
	@ContratoRama			varchar(50),
	@Desde				datetime,
	@Hasta				datetime,
	@Prioridad			varchar(10),
	-- @Comentarios			text,
	-- @Documento			text,
	@Titulo				varchar(100),
	
	@Contrato			varchar(50),
	
	@IDOrigen			int,
	@RamaID				int,
	@OrigenTipo			varchar(20),
	@Origen				varchar(20),
	@OrigenID			varchar(20),
	
	@FechaRegistro			datetime,
	@Conexion			bit,
	@SincroFinal			bit,
	@Sucursal			int,
	
	@Ok				int		OUTPUT,
	@OkRef				varchar(255)	OUTPUT
AS
BEGIN
  RETURN
END
GO
/**************** spContratoVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContratoVerificar') and type = 'P') drop procedure dbo.spContratoVerificar
GO
CREATE PROCEDURE spContratoVerificar
	@ID				int,
	@Accion				char(20),
	@Empresa			char(5),
	@Usuario			char(10),
	@Modulo				char(5),
	@Mov				char(20),
	@MovID				varchar(20),
	@MovTipo			char(20),
	@FechaEmision			datetime,
	@Estatus			char(15),
	@EstatusNuevo			char(15),
	
	@ContactoTipo			varchar(20),
	@Prospecto			varchar(10),
	@Cliente			varchar(10),
	@Proveedor			varchar(10),
	@Personal			varchar(10),
	@Agente				varchar(10),
	@ContratoRama			varchar(50),
	@Desde				datetime,
	@Hasta				datetime,
	@Prioridad			varchar(10),
	-- @Comentarios			text,
	-- @Documento			text,
	@Titulo				varchar(100),
	
	@Contrato			varchar(50),
	
	@IDOrigen			int,
	@RamaID				int,
	@OrigenTipo			varchar(20),
	@Origen				varchar(20),
	@OrigenID			varchar(20),
	
	@FechaRegistro			datetime,
	@Conexion			bit,
	@SincroFinal			bit,
	@Sucursal			int,
	
	@Ok				int		OUTPUT,
	@OkRef				varchar(255)	OUTPUT
	
--//WITH ENCRYPTION
AS BEGIN
	
	DECLARE
--		@Origen			varchar(20),
--		@OrigenID		varchar(20),
--		@OrigenTipo		varchar(20),
		@ODesde			datetime,
		@OHasta			datetime
	
	-- Verificando las fechas de vigencia
	IF @Desde IS NULL SELECT @Ok = 55240, @OkRef = 'Desde'
	
	IF @Ok IS NULL AND @Hasta IS NULL SELECT @Ok = 55240, @OkRef = 'Hasta'
	
	IF @Ok IS NULL AND @Desde > @Hasta SELECT @Ok = 51010, @OkRef = 'Hasta'
	
	IF @Ok IS NULL AND @OrigenTipo = 'PACTO' AND @Origen IS NOT NULL AND @OrigenID IS NOT NULL
	BEGIN
		SELECT @ODesde = Desde, @OHasta = Hasta FROM Contrato WHERE ID = @IDOrigen--Mov = @Origen AND MovID = @OrigenID
		EXEC spExtraerFecha @ODesde OUTPUT
		EXEC spExtraerFecha @OHasta OUTPUT
		EXEC spExtraerFecha @Desde OUTPUT
		EXEC spExtraerFecha @Hasta OUTPUT
		--IF @Desde <= @OHasta SELECT @Ok = 55090, @OkRef = 'Desde' -- Validamos que la fecha sea posterior a la vigencia del contrato anterior
		IF @Desde < @ODesde SELECT @Ok = 55090, @OkRef = 'Desde' -- Cambio solicitado, se permitirá el traslape de fechas
		IF @Hasta < @OHasta SELECT @Ok = 55090, @OkRef = 'Hasta'
	END
	IF @Ok IS NULL AND @Contrato IS NOT NULL AND @Accion IN ('AFECTAR', 'VERIFICAR') AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo IN ('PENDIENTE', 'VIGENTE', 'VENCIDO')
		IF EXISTS(SELECT * FROM Contrato WHERE UPPER(RTRIM(Contrato)) = UPPER(@Contrato) AND Estatus IN ('PENDIENTE', 'VIGENTE', 'VENCIDO'))
			SELECT @Ok = 28030, @OkRef = 'Contrato'
	
	IF @Ok IS NULL AND (SELECT Estatus FROM Contrato WHERE Mov = @Origen AND MovID = @OrigenID) = 'CANCELADO' AND @Accion IN ('AFECTAR', 'GENERAR')
		SELECT @Ok = 60040, @OkRef = 'Origen Cancelado'
	
	IF @Ok IS NULL AND @Accion = 'CANCELAR' AND @Estatus IN ('PENDIENTE', 'VIGENTE', 'VENCIDO') AND @EstatusNuevo = 'CANCELADO' AND @MovTipo = 'PACTO.C'
	BEGIN
		-- verificando si tiene hijos
		IF EXISTS(SELECT * FROM Contrato c WHERE c.Origen = @Mov AND c.OrigenID = @MovID AND c.Estatus IN ('PENDIENTE', 'VIGENTE', 'VENCIDO'))
			SELECT @Ok = 30151
	END
	
	-- Verificando que el flujo sea lineal totalmente
	IF @Ok IS NULL AND @Accion IN ('AFECTAR', 'VERIFICAR') AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')  AND @Origen IS NOT NULL AND @OrigenID IS NOT NULL
		IF EXISTS(SELECT * FROM Contrato c WHERE c.Estatus IN ('PENDIENTE', 'VIGENTE', 'VENCIDO') AND c.Origen = @Origen AND c.OrigenID = @OrigenID )
			SELECT @Ok = 73050
	IF @Ok IS NULL		
		EXEC xpContratoVerificar	@ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @Estatus, @EstatusNuevo, 
							@ContactoTipo, @Prospecto, @Cliente, @Proveedor, @Personal, @Agente, @ContratoRama,
							@Desde, @Hasta, @Prioridad, /* @Comentarios, @Documento, */ @Titulo, @Contrato,
							@IDOrigen, @RamaID, @OrigenTipo, @Origen, @OrigenID,
							@FechaRegistro, @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT
	
	RETURN
END
GO

--SELECT * FROM mensajelista WHERE mensaje  =55090
--SELECT * FROM mensajelista WHERE descripcion LIKE '%Cancel%'

/**************** spContratoAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContratoAfectar') and type = 'P') drop procedure dbo.spContratoAfectar
GO             
CREATE PROCEDURE dbo.spContratoAfectar
	@ID				int,
	@Accion				char(20),
	@Empresa			char(5),
	@Modulo				char(5),
	@Mov				char(20),
	@MovID				varchar(20)	OUTPUT,
	@MovTipo			char(20),
	@FechaEmision			datetime,
	@FechaAfectacion		datetime,
	@FechaConclusion		datetime,
	
	@Concepto			varchar(50),
	@Proyecto			varchar(50),
	@Usuario			char(10),
	
	@Autorizacion			char(10),
	@DocFuente			int,
	@Observaciones			varchar(255),
	@Estatus			char(15),
	@EstatusNuevo			char(15),
	@FechaRegistro			datetime,
	@Ejercicio			int,
	@Periodo			int,
	@MovUsuario			char(10),
	@Conexion			bit,
	@SincroFinal			bit,
	@Sucursal			int,
	@SucursalDestino		int,
	@SucursalOrigen			int,
	
	@ContactoTipo			varchar(20),
	@Prospecto			varchar(10),
	@Cliente			varchar(10),
	@Proveedor			varchar(10),
	@Personal			varchar(10),
	@Agente				varchar(10),
	@ContratoRama			varchar(50),
	@Desde				datetime,
	@Hasta				datetime,
	@Prioridad			varchar(10), 
--	@Comentarios			text,
--	@Documento			text,
	@Titulo				varchar(100),
	
	@Contrato			varchar(50),
	
	@IDOrigen			int,
	@RamaID				int,
	@OrigenTipo			varchar(20),
	@Origen				varchar(20),
	@OrigenID			varchar(20),

	@Generar			bit,
	@GenerarMov			char(20),
	@GenerarAfectado		bit,
	@IDGenerar			int	     	OUTPUT,	
	@GenerarMovID			varchar(20)	OUTPUT,
	
	@CfgContX			bit,
	@CfgContXGenerar		char(20),
	@GenerarPoliza			bit,
	@Moneda				varchar(10),
	@TipoCambio			float,

	@Ok				int          	OUTPUT,
	@OkRef				varchar(255) 	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  	-- SET nocount ON
	DECLARE
		@FechaCancelacion		datetime,
		@GenerarMovTipo			char(20),
		@GenerarPeriodo			int,
		@GenerarEjercicio		int,
		@Renglon			float,
	--	@Origen				varchar(20),
	--	@OrigenID			varchar(20),
		@AvanceID			int,
		@Destino			varchar(50),

		@DesdeS				datetime,
		@HastaS				datetime,
		@Anos				int,
		@Meses				int,
		@Dias				int,

		@PrimerDiaMes			datetime,
		@UltimoDiaMes			datetime,

		@p					int,
		@MasterMovID		varchar(20),
		@Max				int,
		@MovIDMaster        varchar(20),
		@OrigenMovID		varchar(20)
	
	-- Asignar el Consecutivo al Movimiento
  
	EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, 
												@Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

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
		EXEC spMovGenerar 	@Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, 'SINAFECTAR',
					NULL, NULL, @Mov, @MovID, 0, @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
		
		-- Código para sugerir la fecha de vigencia del contrato
		IF @Ok IS NULL AND @MovTipo = 'PACTO.C'
		BEGIN
			BEGIN TRANSACTION
			BEGIN TRY
				-- Obtenemos la diferencia de Años, Meses y Días
				SELECT @Anos = datediff(yy, @Desde, @Hasta)
				IF DATEADD(yy, @Anos, @Desde) > @Hasta SELECT @Anos = @Anos - 1
				SELECT @DesdeS = DATEADD(yy, @Anos, @Desde)
				SELECT @Meses = DATEDIFF(mm, @DesdeS, @Hasta)
				IF DATEADD(mm, @Meses, @DesdeS) > @Hasta SELECT @Meses = @Meses - 1
				SELECT @DesdeS = DATEADD(mm, @Meses, @DesdeS)
				SELECT @Dias = datediff(dd, @DesdeS, @Hasta)
				SELECT @DesdeS = dateadd(dd, @Dias, @DesdeS)
				-- Obtención del nuevo rango de fechas en base al rango inicial
				SELECT @HastaS = DATEADD(yyyy, @Anos, @Hasta)
				SELECT @HastaS = DATEADD(mm, @Meses, @HastaS)
				SELECT @HastaS = DATEADD(dd, @Dias + 1, @HastaS)
				SELECT @DesdeS = @Hasta + 1

				-- Validando las fechas resultantes
				SELECT @PrimerDiaMes = @Desde, @UltimoDiaMes = dbo.fnUltimoDiaMes(@Hasta)

				EXEC spPrimerDiaMes @PrimerDiaMes OUTPUT

				-- Si se trata de meses enteros
				IF @PrimerDiaMes = @Desde AND @Hasta = @UltimoDiaMes
				BEGIN
					-- Meses bien definidos
					SELECT @PrimerDiaMes = @HastaS, @UltimoDiaMes = dbo.fnUltimoDiaMes(@HastaS)
					EXEC spPrimerDiaMes @PrimerDiaMes OUTPUT

					IF @UltimoDiaMes <> @HastaS
						SELECT @HastaS = @PrimerDiaMes - 1
					IF DATEDIFF(mm, @Desde, @Hasta) <> DATEDIFF(mm, @DesdeS, @HastaS)
						SELECT @HastaS = @UltimoDiaMes
				END --ELSE
				--IF DATEPART(dd, @Desde) = DATEPART(dd, DATEADD(dd, 1, @Hasta)) AND DATEPART(dd, @DesdeS) <> DATEPART(dd, DATEADD(dd, 1, @HastaS))
				--	SELECT @HastaS = DATEADD(dd, DATEPART(dd, @DesdeS) - DATEPART(dd, DATEADD(dd, 1, @HastaS)), @HastaS)


                SELECT @p = CHARINDEX('-', @MovID)
                IF @p > 0 
                  SELECT @MovIDMaster = SUBSTRING(@MovID, 1, @p-1) 
                ELSE 
                  SELECT @MovIDMaster = @MovID

                SELECT @Max = ISNULL(MAX(CONVERT(int, SUBSTRING(MovID, LEN(@MovIDMaster)+2, 20))), 0) 
                  FROM Contrato
                 WHERE MovID LIKE RTRIM(@MovIDMaster)+'-%'
                   AND Mov = @GenerarMov 
                   AND Empresa = @Empresa
                   AND Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CANCELADO', 'VIGENTTE')
        
                SELECT @GenerarMovID = RTRIM(@MovIDMaster)+'-'+CONVERT(varchar, @Max+1)

                IF @MovID IS NOT NULL
		          UPDATE Contrato SET MovID = @GenerarMovID WHERE ID = @IDGenerar


				UPDATE Contrato SET Desde = @DesdeS, Hasta = @HastaS WHERE ID = @IDGenerar

			END TRY
			BEGIN CATCH

				SELECT @Ok = 1

			END CATCH

			IF @Ok IS NULL
				COMMIT TRANSACTION
			ELSE
				ROLLBACK TRANSACTION


		END

		-- Leer MovTipo, Periodo y Ejercicio	
		EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT

		IF @Ok IS NULL 
			SELECT @Ok = 80030
	END


	IF @Conexion = 0 
		BEGIN TRANSACTION

	-- Poner el Estatus del Movimiento en "AFECTANDO"
	EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

	IF @Accion = 'AFECTAR'
	BEGIN
		-- Validamos Contrato y lo asignamos
		IF @Ok IS NULL AND @MovTipo IN ('PACTO.C') AND @Contrato IS NULL AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo IN ('PENDIENTE', 'VIGENTE', 'VENCIDO') 
		BEGIN
			IF EXISTS(SELECT * FROM Contrato WHERE UPPER(RTRIM(Contrato)) = UPPER(RTRIM(LTRIM(@Mov)) + ' ' + RTRIM(LTRIM(@MovID))) AND Estatus IN ('PENDIENTE', 'VIGENTE', 'VENCIDO') AND Empresa = @Empresa)
				SELECT @Ok = 73060, @OkRef = 'Contrato'
			ELSE
				UPDATE Contrato SET Contrato = RTRIM(LTRIM(@Mov)) + ' ' + RTRIM(LTRIM(@MovID)) WHERE ID = @ID
			
		END
			
			-- Verificamos si el movimiento tiene padre para afectar
			IF @IDOrigen IS NOT NULL AND (SELECT Estatus FROM Contrato WHERE ID = @IDOrigen) IN (/*'PENDIENTE',*/ 'VIGENTE', 'VENCIDO')
				EXEC spAfectar 'PACTO', @IDOrigen, @EnSilencio = 1, @Ok = @Ok OUTPUT, @Conexion = 1, @OkRef = @OkRef OUTPUT

	END

	-- Registrar el Movimiento en "Mov"	
	IF @Accion <> 'CANCELAR' 
	EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
		NULL, @Proyecto, @Moneda, @TipoCambio,
		@Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
		@Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
		@Ok OUTPUT

	-- Actualizar Movimiento
	IF @Ok IS NULL
	BEGIN
		
		IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
		IF @EstatusNuevo = 'VENCIDO' SELECT @FechaConclusion  = @FechaRegistro ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
		IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
		BEGIN
			IF @Estatus =  'SINAFECTAR' AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
			IF @Estatus <> 'SINAFECTAR' AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
		END
		
		EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
		UPDATE Contrato
		SET 
			FechaConclusion  = @FechaConclusion, 
			FechaCancelacion = @FechaCancelacion, 
			UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
			Estatus          = @EstatusNuevo,
			Situacion 	 = CASE WHEN @Estatus <> @EstatusNuevo THEN NULL ELSE Situacion END/*,
			GenerarPoliza    = @GenerarPoliza*/
		WHERE ID = @ID    	
	END

	-- Agregar a Estatus Log
	IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
		EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

	IF @Accion = 'AFECTAR'
		EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @OrigenTipo, @IDOrigen, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
		
	-- Cancelar el Flujo
	IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
	EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT 

	/*IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
	  EXEC vic_spContratoAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion, @Estatus, @Usuario, @Ok OUTPUT, @OkRef OUTPUT*/
	
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC xpContratoAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion, @Estatus, @EstatusNuevo, @IDGenerar OUTPUT, @Usuario, @Ok OUTPUT, @OkRef OUTPUT
	
	IF @Conexion = 0
	IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
	  COMMIT TRANSACTION
	ELSE
	  ROLLBACK TRANSACTION

	RETURN
END
GO

/**************** spContrato ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContrato') and type = 'P') drop procedure dbo.spContrato
GO
CREATE PROCEDURE spContrato
	@ID			int,
	@Modulo	      		char(5),
	@Accion			char(20),
	@Base			char(20),
	@FechaRegistro		datetime,
	@GenerarMov		char(20),
	@Usuario		char(10),
	@Conexion		bit,
	@SincroFinal		bit,
	@Mov	      		char(20)		OUTPUT,
	@MovID            	varchar(20)		OUTPUT,
	@IDGenerar		int			OUTPUT,
	@Estacion		int,
	
	@Ok			int			OUTPUT,
	@OkRef			varchar(255)		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
	-- SET nocount ON
	DECLARE
		@Generar		bit,
		@GenerarAfectado	bit,
		@Sucursal		int,
		@SucursalDestino	int,
		@SucursalOrigen		int,
		@EnLinea		bit,
		@PuedeEditar		bit,
		@Empresa	      	char(5),
		@MovTipo   		char(20),
		@FechaEmision     	datetime,
		@FechaAfectacion	datetime,
		@FechaConclusion	datetime,
		@Proyecto	      	varchar(50),
		@MovUsuario	      	char(10),
		@Responsable      	char(10),
		@Autorizacion     	char(10),
		@DocFuente	      	int,
		@Concepto    		varchar(50),
		@Observaciones    	varchar(255),
		@Referencia		varchar(50),
		@Estatus          	char(15),
		@EstatusNuevo		char(15),
		@Ejercicio	      	int,
		@Periodo	      	int,
		@GenerarMovID		varchar(20),
		@GenerarPoliza		bit,
		@ReferenciaInicial	varchar(50),
		@RefInicial		char(20),
		@RefInicialID		char(20),
		@CfgContX		bit,
		@CfgContXGenerar	char(20),
		
		@FechaActual		datetime,
		@IDOrigen		int,
		@RamaID			int,
		@OrigenTipo		varchar(20),
		@Origen			varchar(20),
		@OrigenID		varchar(20),
		
		@ContactoTipo		varchar(20),
		@Cliente		varchar(10),
		@Proveedor		varchar(10),
		@Prospecto		varchar(10),
		@Personal		varchar(10),
		@Agente			varchar(10),
		@ContratoRama		varchar(50),
		@Desde			datetime,
		@Hasta			datetime,
		@Prioridad		varchar(10),
--		@Comentarios		text,
--		@Documento		text,
		@Titulo			varchar(100),
		
		@DDesde			datetime,
		@DHasta			datetime,
		@DEstatus          	char(15),
		
		@Contrato		varchar(50),
		
		@Moneda			varchar(10),
		@TipoCambio		float

	-- Inicializar Variables
	SELECT	@Generar	   = 0,
		@GenerarAfectado  = 0,
		@CfgContX         = 0,
		@CfgContXGenerar  = 'NO'/*,
		@Verificar        = 1*/

	--IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'VENCIDO' 
	
	
	-- Leer Datos Generales del Movimiento
	SELECT 	@Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, 
		@MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Concepto = Concepto, @Proyecto = Proyecto,
		@MovUsuario = Usuario, @Autorizacion = Autorizacion, @Referencia = Referencia, @Moneda = NULLIF(RTRIM(Moneda), ''), @TipoCambio = TipoCambio,
		@DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
		@Prospecto = NULLIF(RTRIM(Prospecto), ''), @Cliente = NULLIF(RTRIM(Cliente), ''), @Proveedor = NULLIF(RTRIM(Proveedor), ''),
		@Personal = NULLIF(RTRIM(Personal), ''), @Agente = NULLIF(RTRIM(Agente), ''), @ContratoRama = NULLIF(RTRIM(ContratoRama), ''),
		@Desde = Desde, @Hasta = Hasta, @Prioridad = NULLIF(RTRIM(Prioridad), ''), /*@Comentarios = NULLIF(RTRIM(Comentarios), ''),
		@Documento = NULLIF(RTRIM(Documento), ''),*/ @Titulo = NULLIF(RTRIM(Titulo), ''), @Contrato = NULLIF(RTRIM(Contrato), ''),
		@IDOrigen = IDOrigen, @RamaID = RamaID, @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID
	FROM Contrato
	WHERE ID = @ID
	
	IF @@ERROR <> 0 SELECT @Ok = 1
	
	IF @IDOrigen IS NULL AND @OrigenTipo = @Modulo AND @Origen IS NOT NULL AND @OrigenID IS NOT NULL 
		SELECT @IDOrigen = MIN(ID) FROM Contrato WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus IN ('PENDIENTE', 'VIGENTE', 'VENCIDO', 'CONCLUIDO')
	
	IF @IDOrigen IS NOT NULL 
	BEGIN
		SELECT	@RamaID = ISNULL(RamaID, ID)/*,
			@OrigenFechaD = FechaD,
			@OrigenFechaA = FechaA,
			@OrigenTodoElDia = ISNULL(TodoElDia, 0),
			@OrigenHoraD = ISNULL(RTRIM(HoraD), ''),
			@OrigenHoraA = ISNULL(RTRIM(HoraA), '')*/
		FROM Contrato
		WHERE ID = @IDOrigen
		UPDATE Contrato 
		SET 
			RamaID = @RamaID,
			IDOrigen = @IDOrigen
		WHERE ID = @ID
	END
	--SELECT @Ok = 1, @OkRef = '@IDOrigen: ' + CONVERT(varchar(20), @IDOrigen) + char(13) + '@RamaID: ' + CONVERT(varchar(20), @RamaID)
	IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
	-- Leer MovTipo, Periodo y Ejercicio	
	-- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
	EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
	EXEC spExtraerFecha @FechaAfectacion OUTPUT
	EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
	EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT
	
	IF @Accion = 'CANCELAR' 
	BEGIN
		SELECT @EstatusNuevo = 'CANCELADO'
	END ELSE 
	IF @Accion IN ('GENERAR', 'AFECTAR', 'VERIFICAR')
	BEGIN
		IF @MovTipo IN ('PACTO.C') AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'PENDIENTE', 'VIGENTE', 'VENCIDO', 'CONCLUIDO')
		BEGIN
			
			SELECT @FechaActual = GETDATE();
			
			EXEC spExtraerFecha @FechaActual OUTPUT
			
			IF @FechaActual < @Desde SELECT @EstatusNuevo = 'PENDIENTE' ELSE 
			IF @FechaActual >= @Desde AND @FechaActual <= @Hasta SELECT @EstatusNuevo = 'VIGENTE' ELSE
			IF @FechaActual > @Hasta SELECT @EstatusNuevo = 'VENCIDO'
			
		END
		IF @MovTipo IN ('PACTO.C') AND @Estatus IN ('PENDIENTE', 'VIGENTE', 'VENCIDO') AND EXISTS(SELECT * FROM Contrato WHERE IDOrigen = @ID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR'))
		BEGIN
			SELECT @DDesde = c.Desde, @DHasta = c.Hasta FROM Contrato c WHERE IDOrigen = @ID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
			IF @EstatusNuevo = 'VIGENTE'
			BEGIN
				IF @FechaActual >= @DDesde AND @FechaActual <= @DHasta SELECT @EstatusNuevo = 'CONCLUIDO' 
			END ELSE
			IF @EstatusNuevo = 'VENCIDO' SELECT @EstatusNuevo = 'CONCLUIDO'
		END
	END
	
	-- SELECT @Estatus, @EstatusNuevo, @MovTipo, @Mov, @Ok, @OkRef
	
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

	IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'PENDIENTE', 'VIGENTE', 'CONFIRMAR', 'BORRADOR', 'VENCIDO', 'CONCLUIDO')) OR 
	(@Accion = 'CANCELAR'  AND @Estatus IN ('VENCIDO', 'PENDIENTE', 'VIGENTE', 'CONFIRMAR', 'BORRADOR'))
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
		
		-- Verificar antes de Afectar
		IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
		BEGIN
			EXEC spContratoVerificar	@ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @Estatus, @EstatusNuevo, 
							@ContactoTipo, @Prospecto, @Cliente, @Proveedor, @Personal, @Agente, @ContratoRama,
							@Desde, @Hasta, @Prioridad, /* @Comentarios, @Documento, */ @Titulo, @Contrato,
							@IDOrigen, @RamaID, @OrigenTipo, @Origen, @OrigenID,
							@FechaRegistro, @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT
		
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
		EXEC spContratoAfectar	@ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
					@Concepto, @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones,
					@Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
					@Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, 
					@ContactoTipo, @Prospecto, @Cliente, @Proveedor, @Personal, @Agente, @ContratoRama,
					@Desde, @Hasta, @Prioridad, /* @Comentarios, @Documento, */ @Titulo, @Contrato,
					@IDOrigen, @RamaID, @OrigenTipo, @Origen, @OrigenID,
					@Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
					@CfgContX, @CfgContXGenerar, @GenerarPoliza, @Moneda, @TipoCambio,
					@Ok OUTPUT, @OkRef OUTPUT
	
	--IF @Estatus = 'SINAFECTAR' AND @Accion = 'AFECTAR' AND @MovUsuario <> @Responsable AND @Ok IS NULL
	--EXEC spAfectarTraficoSoporte @Sucursal, @ID, 'TRANSFERIR', @Responsable, @EnSilencio = 1
	
	END ELSE 
	BEGIN
		IF @Estatus = 'SINAFECTAR' AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
		IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
		IF @Estatus = 'VENCIDO' SELECT @Ok = 80010
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

