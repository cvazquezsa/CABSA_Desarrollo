/* SP Asiste  */
-- ASIS.R   Registro
-- ASIS.A   Asistencia
-- ASIS.AU  Ausentes
-- ASIS.C   Corte
-- ASIS.PH  Permiso Horas
-- ASIS.PD  Permiso Dias
-- ASIS.PA  Permiso Acceso

SET NOCOUNT ON 

/**************** spAsisteVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAsisteVerificar') and type = 'P') drop procedure dbo.spAsisteVerificar
GO
CREATE PROCEDURE spAsisteVerificar
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

		    @MovFechaD			datetime,
		    @MovFechaA			datetime,

    		    @OrigenTipo			char(10),
    		    @Origen			char(20),
    		    @OrigenID			varchar(20),
    		    @OrigenMovTipo		char(20),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @GenerarPoliza		bit,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Personal				char(10),
    @JornadaTipo			char(20),
    @PersonalEstatus			char(15),
    @Registro				char(10),   -- 	Entrada / Salida
    @Concepto				varchar(50),
    @HoraRegistro			char(5),
    @HoraD				char(5),
    @HoraA				char(5),
    @Cantidad				float,
    @FechaD				datetime,
    @FechaA				datetime,
    @UltCorte				datetime,
    @ProyectoD				varchar(50),
    @Actividad				varchar(50),
    @ActividadEstado			varchar(30),
    @ActividadAvance			float,
    @CfgCargarTiempoActConcluida	bit,
    @CfgCargarTiempoActCancelada	bit

  SELECT @CfgCargarTiempoActConcluida = AsisteCargarTiempoActConcluida,
         @CfgCargarTiempoActCancelada = AsisteCargarTiempoActCancelada    
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @UltCorte = NULL
  IF @MovTipo = 'ASIS.C' 
    SELECT @UltCorte = MAX(FechaA) FROM Asiste a, MovTipo mt WHERE a.Mov = mt.Mov AND mt.Clave = 'ASIS.C' AND a.Empresa = @Empresa AND a.Estatus = 'CONCLUIDO'

  IF @Accion = 'DESAFECTAR'
  BEGIN
    IF @Estatus = 'PROCESAR'
    BEGIN
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO' AND @GenerarPoliza = 0 SELECT @Ok = 60200
    END ELSE SELECT @Ok = 60040
  END ELSE
  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
    IF @MovTipo = 'ASIS.C' AND @UltCorte <> @MovFechaA SELECT @Ok = 55300   
  END 
  ELSE BEGIN
    IF @MovTipo = 'ASIS.C' 
    BEGIN
      IF @UltCorte IS NOT NULL AND @MovFechaD <> DATEADD(day, 1, @UltCorte) 
      BEGIN
        SELECT @Ok = 55290
        IF (SELECT AsisteJornadasNocturnas FROM EmpresaCfg WHERE Empresa = @Empresa) = 1
          IF @UltCorte IS NOT NULL AND @MovFechaD <> @UltCorte SELECT @Ok = 55290 ELSE SELECT @Ok = NULL
      END
      IF @MovFechaA IS NULL OR @MovFechaD IS NULL SELECT @Ok = 55245
      RETURN
    END

    IF @OrigenMovTipo IS NOT NULL AND @Ok IS NULL
      IF NOT EXISTS(SELECT * FROM Asiste WHERE Empresa = @Empresa AND FechaEmision = @FechaEmision AND Mov = @Origen AND MovID = @OrigenID AND Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')) SELECT @Ok = 55280

    IF @Ok IS NOT NULL RETURN

    DECLARE crAsisteVerificar CURSOR
       FOR SELECT NULLIF(RTRIM(d.Personal), ''), RTRIM(p.Estatus), NULLIF(UPPER(RTRIM(j.Tipo)), ''), NULLIF(RTRIM(d.Registro), ''), NULLIF(RTRIM(d.HoraRegistro), ''), NULLIF(RTRIM(d.HoraD), ''), NULLIF(RTRIM(d.HoraA), ''), d.FechaD, d.FechaA, NULLIF(RTRIM(d.Concepto), ''), ISNULL(d.Cantidad, 0.0), NULLIF(RTRIM(d.Proyecto), ''), NULLIF(RTRIM(d.Actividad), ''), NULLIF(RTRIM(d.ActividadEstado), ''), NULLIF(d.ActividadAvance, 0)
             FROM AsisteD d
             JOIN Personal p ON d.Personal = p.Personal
             LEFT OUTER JOIN Jornada j ON p.Jornada = j.Jornada
            WHERE ID = @ID 

    OPEN crAsisteVerificar
    FETCH NEXT FROM crAsisteVerificar INTO @Personal, @PersonalEstatus, @JornadaTipo, @Registro, @HoraRegistro, @HoraD, @HoraA, @FechaD, @FechaA, @Concepto, @Cantidad, @ProyectoD, @Actividad, @ActividadEstado, @ActividadAvance
    IF @@ERROR <> 0 SELECT @Ok = 1
    IF @@FETCH_STATUS = -1 SELECT @Ok = 60010

    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @MovTipo = 'ASIS.RA' 
        BEGIN
          IF @Cantidad <= 0.0 SELECT @Ok = 20010 ELSE
          IF @CfgCargarTiempoActConcluida = 0 AND @ActividadEstado = 'Completada' SELECT @Ok =14060, @OkRef = @Actividad ELSE
          IF @CfgCargarTiempoActCancelada = 0 AND @ActividadEstado IN ('Cancelada', 'Eliminada') SELECT @Ok =14070, @OkRef = @Actividad
        END
        IF @JornadaTipo NOT IN ('CONTROL ASISTENCIA', 'PERSONAL') AND @MovTipo NOT IN ('ASIS.PA', 'ASIS.RA') SELECT @Ok = 55250 ELSE
        IF @MovTipo IN ('ASIS.R', 'ASIS.PA') AND (@Registro IS NULL OR @HoraRegistro IS NULL) SELECT @Ok = 55220 ELSE
        IF @MovTipo IN ('ASIS.A', 'ASIS.PH') AND (@HoraD IS NULL OR @HoraA IS NULL) SELECT @Ok = 55230 ELSE 
        IF @MovTipo = 'ASIS.PD' AND (@FechaD IS NULL OR @FechaA IS NULL) SELECT @Ok = 55240 ELSE
        IF @MovTipo IN ('ASIS.PH', 'ASIS.PD') AND @Concepto IS NULL SELECT @OK = 20480 ELSE
        IF @MovTipo IN ('ASIS.A', 'ASIS.R')
        BEGIN
          IF @MovTipo = 'ASIS.A' SELECT @HoraRegistro = @HoraD
	  IF EXISTS(SELECT * FROM Asiste a, AsisteD d, MovTipo mt WHERE a.ID = d.ID AND a.Mov = mt.Mov AND mt.Clave = 'ASIS.A' AND a.Empresa = @Empresa AND a.Estatus IN ('PROCESAR', 'CONCLUIDO') AND a.FechaEmision = @FechaEmision AND d.Personal = @Personal AND @HoraRegistro >= d.HoraD AND @HoraRegistro < d.HoraA) SELECT @Ok = 55270 ELSE
	  IF EXISTS(SELECT * FROM Asiste a, AsisteD d, MovTipo mt WHERE a.ID = d.ID AND a.Mov = mt.Mov AND mt.Clave = 'ASIS.R' AND a.Empresa = @Empresa AND a.Estatus IN ('PROCESAR', 'CONCLUIDO') AND a.FechaEmision = @FechaEmision AND d.Personal = @Personal AND @HoraRegistro = d.HoraRegistro) SELECT @Ok = 55270 
	END

        IF @Ok IS NOT NULL AND @OkRef IS NULL 
          SELECT @OkRef = 'Persona: '+RTRIM(@Personal)
      END
      FETCH NEXT FROM crAsisteVerificar INTO @Personal, @PersonalEstatus, @JornadaTipo, @Registro, @HoraRegistro, @HoraD, @HoraA, @FechaD, @FechaA, @Concepto, @Cantidad, @ProyectoD, @Actividad, @ActividadEstado, @ActividadAvance
      IF @@ERROR <> 0 SELECT @Ok = 1
    END  -- While
    CLOSE crAsisteVerificar
    DEALLOCATE crAsisteVerificar
  END

  RETURN
END
GO

/**************** spAsisteGenerarAsistencia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAsisteGenerarAsistencia') and type = 'P') drop procedure dbo.spAsisteGenerarAsistencia
GO             
CREATE PROCEDURE spAsisteGenerarAsistencia
		   @Sucursal			int,
    		   @ID                		int,
		   @FechaEmision		datetime,
		   @Localidad			varchar(50),
    		   @IDGenerar          		int,
		   @GenerarMovTipo		char(20),
       		   @Ok                		int OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon	float,
    @Personal	char(10),
    @Entrada	datetime,
    @Salida	datetime,
    @HoraD	char(5),
    @HoraA	char(5)

  SELECT @Renglon = 0.0

  UPDATE Asiste SET FechaEmision = @FechaEmision WHERE ID = @IDGenerar
  IF @Localidad IS NULL
    DECLARE crTiempos CURSOR
       FOR SELECT p.Personal, jt.Entrada, jt.Salida
             FROM Personal p, Jornada j, JornadaTiempo jt
            WHERE p.Jornada = j.Jornada
              --AND p.Estatus = 'ALTA'
              AND UPPER(j.Tipo) = 'CONTROL ASISTENCIA'
              AND jt.Jornada = p.Jornada AND jt.Salida > @FechaEmision AND jt.Entrada < DATEADD(day, 1, @FechaEmision)
              AND p.Personal NOT IN (SELECT Personal FROM AsisteD WHERE ID = @ID)
            ORDER BY p.Personal, jt.Entrada
  ELSE
    DECLARE crTiempos CURSOR
       FOR SELECT p.Personal, jt.Entrada, jt.Salida
             FROM Personal p, Departamento d, Jornada j, JornadaTiempo jt
            WHERE p.Jornada = j.Jornada
              AND p.Departamento = d.Departamento
              AND d.Localidad = @Localidad
              --AND p.Estatus = 'ALTA'
              AND UPPER(j.Tipo) = 'CONTROL ASISTENCIA'
              AND jt.Jornada = p.Jornada AND jt.Salida > @FechaEmision AND jt.Entrada < DATEADD(day, 1, @FechaEmision)
              AND p.Personal NOT IN (SELECT Personal FROM AsisteD WHERE ID = @ID)
            ORDER BY p.Personal, jt.Entrada

  OPEN crTiempos
  FETCH NEXT FROM crTiempos INTO @Personal, @Entrada, @Salida
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @Renglon = @Renglon + 2048
      EXEC spDateTimeEnHora @Entrada, @HoraD OUTPUT
      EXEC spDateTimeEnHora @Salida, @HoraA OUTPUT
      INSERT AsisteD (Sucursal, ID, Renglon, Personal, HoraD, HoraA) 
              VALUES (@Sucursal, @IDGenerar, @Renglon, @Personal, @HoraD, @HoraA)
    END
    FETCH NEXT FROM crTiempos INTO @Personal, @Entrada, @Salida
  END  -- While
  CLOSE crTiempos
  DEALLOCATE crTiempos

  RETURN
END
GO

/**************** spAsisteSugerirNomina ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAsisteSugerirNomina') and type = 'P') drop procedure dbo.spAsisteSugerirNomina
GO             
CREATE PROCEDURE spAsisteSugerirNomina
			@Empresa	char(5), 
			@Sucursal	int,
			@Usuario	char(10),
			@Modulo		char(5),
			@ID		int, 
			@Mov		char(20),
			@MovID		varchar(20),
			@Accion		char(20),

			@Ok 		int		OUTPUT, 
			@OkRef 		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Moneda		        char(10),
    @TipoCambio		    float,
    @GenerarFaltas	    bit,
    @GenerarRetardos	bit,
    @GenerarHorasExtras	bit,
    @MovFaltas		    char(20),
    @MovRetardos	    char(20),
    @MovHorasExtras	    char(20),
    @NominaID		    int,
    @Minutos		    int,
    @Horas		        char(5),
    @Concepto		    varchar(50),
	@MovTipo            varchar(20),
	@FechaD	            datetime,
    @FechaA	            datetime,	
	-- BUG 4978
    @HerramHorasExtra	bit
	
	SELECT @MovTipo = MT.Clave 
	  FROM Asiste A 
	  JOIN MovTipo MT ON MT.Mov = A.Mov AND MT.Modulo = @Modulo
	 WHERE A.ID = @ID

  IF @Accion = 'CANCELAR'
  BEGIN
    DECLARE crCancelarNomina CURSOR FOR
     SELECT ID FROM Nomina WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID
    OPEN crCancelarNomina
    FETCH NEXT FROM crCancelarNomina INTO @NominaID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
	  BEGIN
		IF @MovTipo = 'ASIS.C'
			IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND OModulo = @Modulo AND OID = @ID AND OModulo <> DModulo)
				IF @Accion = 'CANCELAR' SELECT @Ok = 60060 
		
		IF @Ok IS NULL
			EXEC spAfectar 'NOM', @NominaID, @Accion, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
	  END
      FETCH NEXT FROM crCancelarNomina INTO @NominaID
    END  -- While
    CLOSE crCancelarNomina
    DEALLOCATE crCancelarNomina
  END ELSE
  BEGIN
    SELECT @Moneda	       = ContMoneda,
           @GenerarFaltas      = AsisteGenerarFaltas,
           @GenerarRetardos    = AsisteGenerarRetardos,
           @GenerarHorasExtras = AsisteGenerarHorasExtras,
		   @HerramHorasExtra   = HerramientaHorasExtra
      FROM EmpresaCfg
     WHERE Empresa = @Empresa
    SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
  
    SELECT @MovFaltas      = NomFaltas,
           @MovRetardos    = NomRetardos,
           @MovHorasExtras = NomHorasExtras
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa    

    DECLARE crAsisteConcepto CURSOR LOCAL FOR
     SELECT DISTINCT ISNULL(RTRIM(Concepto), '') FROM AsisteD WHERE ID = @ID
    OPEN crAsisteConcepto
    FETCH NEXT FROM crAsisteConcepto INTO @Concepto
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @GenerarFaltas = 1
        BEGIN           
        IF EXISTS(SELECT @NominaID, MIN(d.Renglon), d.Personal, d.Fecha, 1.0
                    FROM AsisteD d
                    JOIN Personal p ON p.Personal = d.Personal AND p.Estatus <> 'BAJA'
                   WHERE d.ID = @ID AND UPPER(d.Tipo) = 'DIAS AUSENCIA' 
				     AND ISNULL(RTRIM(d.Concepto), '') = @Concepto
					 --- BUG 6235 Las faltas justificadas no deben viajar al módulo de Nómina
                     AND ISNULL(RTRIM(d.Concepto), '') NOT IN (SELECT Concepto FROM Concepto WHERE MODULO = 'ASIS')
                GROUP BY d.Personal, d.Fecha)
        BEGIN   
		
		 SELECT @FechaD = FechaD,
		        @FechaA = FechaA
		   FROM Asiste 
		  WHERE ID = @ID 
		        
          INSERT Nomina (UltimoCambio, Sucursal, SucursalOrigen, SucursalDestino, OrigenTipo, Origen, OrigenID, Empresa, Usuario, Estatus, Mov, FechaEmision, Proyecto, UEN, Moneda, TipoCambio, Concepto)
          SELECT GETDATE(), @Sucursal, @Sucursal, @Sucursal, 'ASIS', @Mov, @MovID, @Empresa, @Usuario, 'CONFIRMAR', @MovFaltas, FechaEmision, Proyecto, UEN, @Moneda, @TipoCambio,@Concepto
            FROM Asiste WHERE ID = @ID 

          SELECT @NominaID = SCOPE_IDENTITY()
    
			  IF @Concepto = ''
			  BEGIN
					INSERT NominaD (ID, Renglon, Personal, FechaD, Cantidad)
							SELECT @NominaID, MIN(d.Renglon), d.Personal, d.Fecha, 1.0
							FROM AsisteD d
							JOIN Personal p ON p.Personal = d.Personal AND p.Estatus <> 'BAJA'
							WHERE d.ID = @ID AND UPPER(d.Tipo) = 'DIAS AUSENCIA' AND ISNULL(RTRIM(d.Concepto), '') = ISNULL(@Concepto,'')
							GROUP BY d.Personal, d.Fecha
			  END
			  IF @Concepto <> ''
			  BEGIN			      
				  INSERT NominaD (ID, Renglon, Personal, FechaD, Cantidad)
				  SELECT @NominaID, MIN(d.Renglon), d.Personal, d.Fecha, 1.0
					FROM AsisteD d
					JOIN Personal p ON p.Personal = d.Personal AND p.Estatus <> 'BAJA'
				   WHERE d.ID = @ID AND UPPER(d.Tipo) = 'DIAS AUSENCIA' AND ISNULL(RTRIM(d.Concepto), '') = ISNULL(@Concepto,'')
					 AND d.Fecha NOT IN ( SELECT D.Fecha
											FROM PersonalAsisteDifDia D
											JOIN PersonalAsisteDif A ON A.Personal = D.Personal AND A.Empresa = D.Empresa
										   WHERE D.Fecha >= @FechaD  AND D.Fecha <= @FechaA
											 --AND A.Concepto  = 'PERMISO AUSENTARSE' 
											 --- BUG 6235 Las faltas justificadas no deben viajar al módulo de Nómina
											 AND A.Concepto IN (SELECT Concepto FROM Concepto WHERE MODULO = 'ASIS')
											 AND A.tipo = 'DIAS AUSENCIA'
											 AND Permiso IS NOT NULL AND PermisoID IS NOT NULL
										 )
					AND d.Personal NOT IN (SELECT D.Personal
											FROM PersonalAsisteDifDia D
											JOIN PersonalAsisteDif A ON A.Personal = D.Personal AND A.Empresa = D.Empresa
										   WHERE D.Fecha >= @FechaD  AND D.Fecha <= @FechaA
											 --AND A.Concepto  = 'PERMISO AUSENTARSE'
											 --- BUG 6235 Las faltas justificadas no deben viajar al módulo de Nómina
											 AND A.Concepto IN (SELECT Concepto FROM Concepto WHERE MODULO = 'ASIS')
											 AND A.tipo = 'DIAS AUSENCIA'
											 AND Permiso IS NOT NULL AND PermisoID IS NOT NULL
										   )
				   GROUP BY d.Personal, d.Fecha			   		  
               END

			   IF NOT EXISTS (SELECT * FROM NominaD WHERE ID = @NominaID)
			   BEGIN
				DELETE Nomina WHERE ID = @NominaID
			   END
        END
        END
        IF @GenerarRetardos = 1
        BEGIN 
            IF EXISTS(SELECT @NominaID, MIN(d.Renglon), d.Personal, d.Fecha, 1.0
                        FROM AsisteD d
                        JOIN Personal p ON p.Personal = d.Personal AND p.Estatus <> 'BAJA'
                       WHERE d.ID = @ID AND UPPER(d.Tipo) = 'MINUTOS AUSENCIA' AND ISNULL(RTRIM(d.Concepto), '') = @Concepto
                    GROUP BY d.Personal, d.Fecha)
         BEGIN

		    SELECT @FechaD = NULL,
				   @FechaA = NULL

		 	SELECT @FechaD = FechaD,
				   @FechaA = FechaA
		      FROM Asiste 
		     WHERE ID = @ID 

          INSERT Nomina (UltimoCambio, Sucursal, SucursalOrigen, SucursalDestino, OrigenTipo, Origen, OrigenID, Empresa, Usuario, Estatus, Mov, FechaEmision, Proyecto, UEN, Moneda, TipoCambio, Concepto)
          SELECT GETDATE(), @Sucursal, @Sucursal, @Sucursal, 'ASIS', @Mov, @MovID, @Empresa, @Usuario, 'CONFIRMAR', @MovRetardos, FechaEmision, Proyecto, UEN, @Moneda, @TipoCambio, @Concepto
            FROM Asiste WHERE ID = @ID 

          SELECT @NominaID = SCOPE_IDENTITY()
      
            IF @Concepto = ''
			BEGIN
					INSERT NominaD (ID, Renglon, Personal, FechaD, Cantidad)
								SELECT @NominaID, MIN(d.Renglon), d.Personal, d.Fecha, 1.0
								FROM AsisteD d
								JOIN Personal p ON p.Personal = d.Personal AND p.Estatus <> 'BAJA'
								WHERE d.ID = @ID AND UPPER(d.Tipo) = 'MINUTOS AUSENCIA' AND ISNULL(RTRIM(d.Concepto), '') = @Concepto
								GROUP BY d.Personal, d.Fecha
			END

			IF @Concepto <> ''
			BEGIN
				INSERT NominaD (ID, Renglon, Personal, FechaD, Cantidad)
				SELECT @NominaID, MIN(d.Renglon), d.Personal, d.Fecha, 1.0
				FROM AsisteD d
				JOIN Personal p ON p.Personal = d.Personal AND p.Estatus <> 'BAJA'
				WHERE d.ID = @ID AND UPPER(d.Tipo) = 'MINUTOS AUSENCIA' AND ISNULL(RTRIM(d.Concepto), '') = @Concepto
				AND d.Fecha NOT IN ( SELECT A.Fecha 
			     					   FROM PersonalAsisteDifMin R
									   JOIN PersonalAsisteDif A ON A.Personal = R.Personal AND A.Empresa = R.Empresa
		 							  WHERE R.Fecha >= @FechaD  AND R.Fecha <=  @FechaA
										AND A.Concepto  = 'PERMISO AUSENTARSE' and A.tipo = 'MINUTOS AUSENCIA'
										AND R.Permiso IS NOT NULL AND R.PermisoID IS NOT NULL
								   )
				AND d.Personal NOT IN ( SELECT A.Personal 
										  FROM PersonalAsisteDifMin R
										  JOIN PersonalAsisteDif A ON A.Personal = R.Personal AND A.Empresa = R.Empresa
		 								 WHERE R.Fecha >= @FechaD  AND R.Fecha <=  @FechaA
										   AND A.Concepto  = 'PERMISO AUSENTARSE' and A.tipo = 'MINUTOS AUSENCIA'
										   AND R.Permiso IS NOT NULL AND R.PermisoID IS NOT NULL
									  )
					GROUP BY d.Personal, d.Fecha
			 END

			 IF NOT EXISTS (SELECT * FROM NominaD WHERE ID = @NominaID)
			 BEGIN
				DELETE Nomina WHERE ID = @NominaID
			 END
        END
        END
        IF @GenerarHorasExtras = 1 AND @HerramHorasExtra <> 1
        BEGIN            
         IF EXISTS(SELECT @NominaID, MIN(d.Renglon), d.Personal, d.Fecha, SUM(d.Cantidad)/60.0
                     FROM AsisteD d
                     JOIN Personal p ON p.Personal = d.Personal AND p.Estatus <> 'BAJA'
                    WHERE d.ID = @ID AND UPPER(d.Tipo) = 'MINUTOS EXTRAS' AND ISNULL(RTRIM(d.Concepto), '') = @Concepto
                 GROUP BY d.Personal, d.Fecha)
         BEGIN
          INSERT Nomina (UltimoCambio, Sucursal, SucursalOrigen, SucursalDestino, OrigenTipo, Origen, OrigenID, Empresa, Usuario, Estatus, Mov, FechaEmision, Proyecto, UEN, Moneda, TipoCambio, Concepto)
          SELECT GETDATE(), @Sucursal, @Sucursal, @Sucursal, 'ASIS', @Mov, @MovID, @Empresa, @Usuario, 'CONFIRMAR', @MovHorasExtras, FechaEmision, Proyecto, UEN, @Moneda, @TipoCambio, @Concepto
            FROM Asiste WHERE ID = @ID 
          SELECT @NominaID = SCOPE_IDENTITY()
    
          INSERT NominaD (ID, Renglon, Personal, FechaD, Cantidad)
          SELECT @NominaID, MIN(d.Renglon), d.Personal, d.Fecha, SUM(d.Cantidad)/60.0
            FROM AsisteD d
            JOIN Personal p ON p.Personal = d.Personal AND p.Estatus <> 'BAJA'
           WHERE d.ID = @ID AND UPPER(d.Tipo) = 'MINUTOS EXTRAS' AND ISNULL(RTRIM(d.Concepto), '') = @Concepto
           GROUP BY d.Personal, d.Fecha

          DECLARE crNominaD CURSOR LOCAL FOR
           SELECT Cantidad*60 FROM NominaD WHERE ID = @NominaID
          OPEN crNominaD
          FETCH NEXT FROM crNominaD INTO @Minutos
          WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
          BEGIN
            IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
            BEGIN
              EXEC spMinutosToHoras @Minutos, @Horas OUTPUT,1
              UPDATE NominaD SET Horas = @Horas WHERE CURRENT OF crNominaD
            END

            FETCH NEXT FROM crNominaD INTO @Minutos
          END  -- While
          CLOSE crNominaD
          DEALLOCATE crNominaD
        END
      END
      END
      FETCH NEXT FROM crAsisteConcepto INTO @Concepto
    END  -- While
    CLOSE crAsisteConcepto
    DEALLOCATE crAsisteConcepto
  END
  RETURN
END
GO

/**************** spAsisteAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAsisteAfectar') and type = 'P') drop procedure dbo.spAsisteAfectar
GO             
CREATE PROCEDURE spAsisteAfectar
				@ID                		int,
				@Accion					char(20),
				@Empresa	      		char(5),
				@Modulo	      			char(5),
				@Mov	  	      		char(20),
				@MovID             		varchar(20)    OUTPUT,
				@MovTipo     			char(20),
				@FechaEmision      		datetime,
				@FechaAfectacion      	datetime,
				@FechaConclusion		datetime,
				@Proyecto	      		varchar(50),
				@Usuario	      		char(10),
				@Autorizacion      		char(10),
				@DocFuente	      		int,
				@Localidad				varchar(50),
				@Observaciones     		varchar(255),
				@Concepto     			varchar(50),
				@Estatus           		char(15),
				@EstatusNuevo	      	char(15),
				@FechaRegistro     		datetime,
				@Ejercicio	      		int,
				@Periodo	      		int,
				@MovFechaD				datetime,
				@MovFechaA				datetime,
				@OrigenTipo				char(10),
				@Origen					char(20),
				@OrigenID				varchar(20),
				@OrigenMovTipo			char(20),
				@Conexion				bit,
				@SincroFinal			bit,
				@Sucursal				int, 
				@SucursalDestino		int, 
				@SucursalOrigen			int, 
				@CfgContX				bit,
				@CfgContXGenerar		char(20),
				@GenerarPoliza			bit,
				@GenerarMov				char(20),
				@IDGenerar				int	     OUTPUT,	
				@GenerarMovID	  		varchar(20)  OUTPUT,
				@Ok                		int          OUTPUT,
				@OkRef             		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
	DECLARE
	@Personal			char(10),
    @Registro			char(10),   -- Entrada / Salida
    @HoraRegistro		char(5),
    @HoraD				char(5),
    @HoraA				char(5),
    @FechaD				datetime,
    @FechaA				datetime,
    @OrigenEstatus		char(15),

    @Generar			bit,
    @GenerarAfectado	bit,
    @GenerarModulo		char(5),
    @GenerarMovTipo		char(20),
    @GenerarEstatus		char(15),
    @GenerarPeriodo 	int, 
    @GenerarEjercicio 	int,
    @FechaCancelacion	datetime,
    @GenerarAccion		char(20),
    @CfgRegistroEstadoAvance	bit,
    @Cantidad			float,
    @ProyectoD			varchar(50),
    @Actividad			varchar(50),
    @MovimientoRef		varchar(50),
    @ActividadEstado	varchar(20),
    @ActividadAvance	float,
    @ProyectoID			int,
    @RefID				int,
    @RefModulo			varchar(5),
	@IDOrigen			int,		--- ID Modulo Origen (Asistencia)
    
--	REGISTRO DE MOVFLIJO
	@cID			int,
	@cMov			varchar(20),
	@cMovID			varchar(20)
    
    
  -- Inicializar Variables
  SELECT @Generar 		= 0,
         @GenerarAfectado	= 0,
         @IDGenerar		= NULL,
         @GenerarModulo		= NULL,
         @GenerarMovID	        = NULL,
         @GenerarMovTipo        = NULL,
         @GenerarEstatus 	= 'SINAFECTAR'

  SELECT @CfgRegistroEstadoAvance = ISNULL(AsisteRegistroEstadoAvance, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa
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
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, @GenerarEstatus, 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT

    IF @@ERROR <> 0 SELECT @Ok = 1
    IF @GenerarMovTipo = 'ASIS.A' AND @Ok IS NULL 
    BEGIN
      BEGIN TRANSACTION
        EXEC spAsisteGenerarAsistencia @Sucursal, @ID, @FechaEmision, @Localidad, @IDGenerar, @GenerarMovTipo, @Ok OUTPUT

      IF @Ok IS NULL 
        COMMIT TRANSACTION
      ELSE
        ROLLBACK TRANSACTION

      IF @Ok IS NULL SELECT @Ok = 80030
    END

    RETURN
  END

  IF @OK IS NOT NULL RETURN 
  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Actualizar Sucursal Detalle
    IF @Accion = 'AFECTAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
    BEGIN
      IF (SELECT Sincro FROM Version) = 1
        EXEC sp_executesql N'UPDATE AsisteD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
      IF @MovTipo = 'ASIS.R'
        UPDATE AsisteD SET Fecha = @FechaEmision WHERE ID = @ID AND Fecha <> @FechaEmision
    END

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, NULL, NULL,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @Accion = 'DESAFECTAR'
      EXEC spMovDesafectar @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo = 'ASIS.RA' AND @CfgRegistroEstadoAvance = 1 AND @Accion <> 'DESAFECTAR' 
    BEGIN
      DECLARE crAsiste CURSOR
         FOR SELECT NULLIF(RTRIM(Personal), ''), FechaD, Cantidad, NULLIF(RTRIM(Proyecto), ''), NULLIF(RTRIM(Actividad), ''), NULLIF(RTRIM(MovimientoRef), ''), NULLIF(RTRIM(ActividadEstado), ''), ActividadAvance
               FROM AsisteD
              WHERE ID = @ID 

      OPEN crAsiste
      FETCH NEXT FROM crAsiste INTO @Personal, @FechaD, @Cantidad, @ProyectoD, @Actividad, @MovimientoRef, @ActividadEstado, @ActividadAvance
      IF @@ERROR <> 0 SELECT @Ok = 1
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL AND @Actividad IS NOT NULL AND @ActividadEstado IS NOT NULL
        BEGIN        
          IF @MovimientoRef IS NOT NULL
          BEGIN
	    SELECT @RefID = NULL
            EXEC spReferenciaEnModuloID @MovimientoRef, 'ST', @RefID
            IF @RefID IS NOT NULL
              UPDATE Soporte 
                 SET Estado = @ActividadEstado, Avance = @ActividadAvance
               WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID = @RefID
            ELSE BEGIN
              EXEC spReferenciaEnModuloID @MovimientoRef, 'VTAS', @RefID
              IF @RefID IS NOT NULL
                UPDATE VentaDAgente
                   SET Estado = @ActividadEstado, Avance = @ActividadAvance
                 WHERE ID = @RefID AND Actividad = @Actividad
              ELSE SELECT @Ok = 14055, @OkRef = @MovimientoRef
            END
          END
          IF @ProyectoD IS NOT NULL 
          BEGIN
            SELECT @ProyectoID = NULL
            SELECT @ProyectoID = MIN(ID) FROM Proyecto WHERE Proyecto = @ProyectoD AND Estatus = 'PENDIENTE'
            IF @ProyectoID IS NOT NULL
              UPDATE ProyectoD 
                 SET Estado = @ActividadEstado, 
                     Avance = @ActividadAvance,
                     FechaInicio = CASE WHEN FechaInicio IS NULL AND ISNULL(@ActividadAvance, 0) > 0 THEN @FechaEmision ELSE FechaInicio END,
                     FechaConclusion = CASE WHEN ISNULL(@ActividadAvance, 0) = 100 THEN @FechaEmision ELSE FechaInicio END
               WHERE ID = @ProyectoID AND Actividad = @Actividad
            IF @@ROWCOUNT = 0 OR @ProyectoID IS NULL BEGIN
              SELECT @Ok = 14050, @OkRef = @Actividad 
			  EXEC xpOk_14050 @Empresa, @Usuario, @Accion, @Modulo, @MovTipo, @Mov, @Estatus, @Actividad, @Ok OUTPUT, @OkRef OUTPUT
            END
          END
          IF @Ok IS NOT NULL AND @OkRef IS NULL
            SELECT @OkRef = 'Persona: '+RTRIM(@Personal)
        END
        FETCH NEXT FROM crAsiste INTO @Personal, @FechaD, @Cantidad, @ProyectoD, @Actividad, @MovimientoRef, @ActividadEstado, @ActividadAvance
        IF @@ERROR <> 0 SELECT @Ok = 1
      END  -- While
      CLOSE crAsiste
      DEALLOCATE crAsiste
    END

/*
    IF @Accion <> 'DESAFECTAR' 
    BEGIN
      DECLARE crAsiste CURSOR
         FOR SELECT NULLIF(RTRIM(Personal), ''), NULLIF(UPPER(RTRIM(Registro)), ''), NULLIF(RTRIM(HoraRegistro), ''), NULLIF(RTRIM(HoraD), ''), NULLIF(RTRIM(HoraA), ''), FechaD, FechaA
               FROM AsisteD
              WHERE ID = @ID     

      OPEN crAsiste
      FETCH NEXT FROM crAsiste INTO @Personal, @Registro, @HoraRegistro, @HoraD, @HoraA, @FechaD, @FechaA
      IF @@ERROR <> 0 SELECT @Ok = 1
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
*/
/*
          IF @MovTipo IN ('ASIS.R', 'ASIS.A')
          BEGIN
            SELECT @UltEntrada = NULL, @UltSalida = NULL, @UltLocalidad = NULL
            SELECT @UltEntrada = MAX(Entrada) FROM PersonalAsiste WHERE Personal = @Personal
            IF @UltEntrada IS NOT NULL
              SELECT @UltSalida = Salida, @UltLocalidad = Localidad FROM PersonalAsiste WHERE Personal = @Personal AND Entrada = @UltEntrada

      	    IF @MovTipo = 'ASIS.R'
            BEGIN
              SELECT @FechaHoraRegistro = @FechaEmision
              EXEC spAgregarHora @HoraRegistro, @FechaHoraRegistro OUTPUT
	      IF @Registro = 'ENTRADA' 
              BEGIN
                IF @UltEntrada IS NULL OR (@UltSalida IS NOT NULL AND @UltSalida < @FechaHoraRegistro)
                  INSERT PersonalAsiste (Personal, Entrada, Localidad) VALUES (@Personal, @FechaHoraRegistro, @Localidad)
                ELSE SELECT @Ok = 55200
              END ELSE
	      IF @Registro = 'SALIDA' 
              BEGIN
                IF @UltEntrada IS NOT NULL AND @UltSalida IS NULL AND @Localidad = @UltLocalidad
                  UPDATE PersonalAsiste SET Salida = @FechaHoraRegistro WHERE Personal = @Personal AND Entrada = @UltEntrada
                ELSE SELECT @Ok = 55210           
              END
            END ELSE
            IF @MovTipo = 'ASIS.A'
            BEGIN
              SELECT @FechaD = @FechaEmision, @FechaA = @FechaEmision
              EXEC spAgregarHora @HoraD, @FechaD OUTPUT
              EXEC spAgregarHora @HoraA, @FechaA OUTPUT
              IF @FechaD < @FechaA AND @FechaD IS NOT NULL AND @FechaD > @UltEntrada
              BEGIN
                IF @FechaA IS NOT NULL AND @FechaA > @UltSalida
                  INSERT PersonalAsiste (Personal, Entrada, Salida, Localidad) VALUES (@Personal, @FechaD, @FechaA, @Localidad)
                ELSE SELECT @Ok = 55210
              END ELSE SELECT @Ok = 55200
            END
          END
*/ 
/*          IF @Ok IS NOT NULL AND @OkRef IS NULL
            SELECT @OkRef = 'Persona: '+RTRIM(@Personal)
        END
        FETCH NEXT FROM crAsiste INTO @Personal, @Registro, @HoraRegistro, @HoraD, @HoraA, @FechaD, @FechaA
        IF @@ERROR <> 0 SELECT @Ok = 1
      END  -- While
      CLOSE crAsiste
      DEALLOCATE crAsiste
    END*/

    IF @MovTipo = 'ASIS.C' AND @Ok IS NULL
    BEGIN
      IF @Accion = 'CANCELAR'
        UPDATE Asiste 
           SET Estatus = 'PROCESAR'
          FROM Asiste a, AsisteD d, MovTipo mt
            WHERE a.Mov = mt.Mov
                AND mt.Modulo = 'ASIS'
                AND mt.Clave IN ('ASIS.A', 'ASIS.R', 'ASIS.PD', 'ASIS.PH')
                AND a.ID = d.ID
                AND a.Empresa = @Empresa
                AND a.Estatus = 'CONCLUIDO'
                AND a.FechaEmision >= @MovFechaD AND a.FechaEmision < DATEADD(day, 1, @MovFechaA)
      ELSE
		BEGIN
			UPDATE Asiste 
			   SET Estatus = 'CONCLUIDO'
			  FROM Asiste a, AsisteD d, MovTipo mt
				WHERE a.Mov = mt.Mov
					AND mt.Modulo = 'ASIS'
					AND mt.Clave IN ('ASIS.A', 'ASIS.R', 'ASIS.PD', 'ASIS.PH')
					AND a.ID = d.ID
					AND a.Empresa = @Empresa
					AND a.Estatus = 'PROCESAR'
					AND a.FechaEmision >= @MovFechaD AND a.FechaEmision < DATEADD(day, 1, @MovFechaA)
		
			DECLARE crRegistro CURSOR FOR
			SELECT DISTINCT A.ID, A.Mov, A.MovID
			  FROM Asiste a, AsisteD d, MovTipo mt
			 WHERE a.Mov = mt.Mov
			   AND mt.Modulo = 'ASIS'
			   AND mt.Clave IN ('ASIS.A', 'ASIS.R', 'ASIS.PD', 'ASIS.PH')
			   AND a.ID = d.ID
			   AND a.Empresa = @Empresa
			   AND a.Estatus = 'CONCLUIDO'
			   AND a.FechaEmision >= @MovFechaD 
			   AND a.FechaEmision < DATEADD(day, 1, @MovFechaA)
			   
			OPEN crRegistro
			FETCH NEXT FROM crRegistro INTO	@cID, @cMov, @cMovID
			
			WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
			BEGIN
				EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'ASIS', @cID, @cMov, @cMovID, @Modulo, @ID, @Mov, @MovID, @OK OUTPUT
									   
				FETCH NEXT FROM crRegistro INTO	@cID, @cMov, @cMovID
			END
			
			CLOSE crRegistro
			DEALLOCATE crRegistro
		
		END
		
		IF @OK IS NULL
			EXEC spAsisteSugerirNomina @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @Accion, @Ok OUTPUT, @OkRef OUTPUT
    END

    -- Actualizar Movimiento
    IF @Ok IS NULL
    BEGIN
      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO' 
      BEGIN
	IF @Estatus IN     ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @EstatusNuevo NOT IN ('PROCESAR', 'CANCELADO') SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
      END  
      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE Asiste
         SET FechaConclusion  = @FechaConclusion, 
             FechaCancelacion = @FechaCancelacion,
             UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
             Estatus          = @EstatusNuevo,
             Situacion 	      = CASE WHEN @Estatus <> @EstatusNuevo THEN NULL ELSE Situacion END,
             GenerarPoliza    = @GenerarPoliza
       WHERE ID = @ID 
      IF @@ERROR <> 0 SELECT @Ok = 1
    END

    IF @MovTipo = 'ASIS.A' AND @EstatusNuevo <> 'CONCLUIDO' AND @OrigenMovTipo IS NOT NULL AND @Ok IS NULL 
    BEGIN
      SELECT @OrigenEstatus = @EstatusNuevo
      IF @OrigenEstatus = 'PROCESAR'  SELECT @OrigenEstatus = 'CONCLUIDO'
      IF @OrigenEstatus = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
      IF @OrigenEstatus = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @OrigenEstatus <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      UPDATE Asiste 
         SET FechaConclusion  = @FechaConclusion, 
             FechaCancelacion = @FechaCancelacion,
             Estatus          = @OrigenEstatus
       WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus <> 'CANCELADO'
    END

  -- Agregar a Estatus Log
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

  -- Cancelar el Flujo
  IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
    EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT 

  
  /***** AGREGA A MOVFLUJO EL MOVIMIENTO DE Asistencia y Ausentes *****/

  IF @OrigenTipo = 'ASIS'
	BEGIN
		SELECT @IDOrigen = ID 
		  FROM Asiste 
		 WHERE Empresa = @Empresa
		   AND Mov = @Origen
		   AND MovID = @OrigenID
		
		EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @OrigenTipo, @IDOrigen, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @OK OUTPUT

	END	

  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
    
  RETURN
END
GO

/**************** spAsiste ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAsiste') and type = 'P') drop procedure dbo.spAsiste
GO
CREATE PROCEDURE spAsiste
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
    @Sucursal			int,
    @SucursalDestino		int,
    @SucursalOrigen		int,
    @EnLinea			bit,
    @PuedeEditar		bit,
    @Empresa	      		char(5),
    @MovTipo   			char(20),
    @FechaEmision     		datetime,
    @FechaAfectacion		datetime,
    @FechaConclusion		datetime,
    @Proyecto	      		varchar(50),
    @MovUsuario	      		char(10),
    @Autorizacion     		char(10),
    @DocFuente	      		int,
    @Localidad			varchar(50),
    @Observaciones    		varchar(255),
    @Concepto    		varchar(50),
    @Estatus          		char(15),
    @EstatusNuevo		char(15),
    @Ejercicio	      		int,
    @Periodo	      		int,
    @GenerarMovID		varchar(20),
    @GenerarPoliza		bit,
    @CfgContX			bit,
    @CfgContXGenerar		char(20),
    @OrigenTipo			char(10),
    @Origen			char(20),
    @OrigenID			varchar(20),
    @OrigenMovTipo		char(20),
    @MovFechaD			datetime,
    @MovFechaA			datetime/*,
    @Verificar			bit*/

  -- Inicializar Variables
  SELECT @CfgContX        = 0,
         @CfgContXGenerar = 'NO',
         @OrigenMovTipo   = NULL/*,
	 @Verificar	  = 1*/

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = Proyecto,
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, @Localidad = NULLIF(RTRIM(Localidad), ''),
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
	 @MovFechaD = FechaD, @MovFechaA = FechaA,
	 @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID,
         @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion,
         @Concepto = NULL
    FROM Asiste
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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'PROCESAR')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('PROCESAR', 'CONCLUIDO'))
  BEGIN
    IF @OrigenTipo = @Modulo AND @Origen IS NOT NULL AND @OrigenID IS NOT NULL
      SELECT @OrigenMovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Origen

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

    IF @Accion = 'DESAFECTAR'
      SELECT @EstatusNuevo = 'SINAFECTAR'
    ELSE
    IF @Accion = 'CANCELAR' 
      SELECT @EstatusNuevo = 'CANCELADO' 
    ELSE BEGIN
      IF @MovTipo IN ('ASIS.AU', 'ASIS.C', 'ASIS.PA', 'ASIS.RA')
        SELECT @EstatusNuevo = 'CONCLUIDO'
      ELSE
        SELECT @EstatusNuevo = 'PROCESAR'
    END

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spAsisteVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @Estatus, 
			     @MovFechaD, @MovFechaA,
       			     @OrigenTipo, @Origen, @OrigenID, @OrigenMovTipo,
			     @Conexion, @SincroFinal, @Sucursal, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
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

    IF @Accion IN ('AFECTAR', 'DESAFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
      EXEC spAsisteAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			   @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Localidad, @Observaciones, @Concepto,
                           @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovFechaD, @MovFechaA,
    			   @OrigenTipo, @Origen, @OrigenID, @OrigenMovTipo,
		           @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
			   @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                           @GenerarMov, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT

  END ELSE 
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
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

/**************** spAsisteRegistro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAsisteRegistro') and type = 'P') drop procedure dbo.spAsisteRegistro
GO
CREATE PROCEDURE spAsisteRegistro
	   		@Empresa 		char(5),
	   		@Sucursal 		int,
	   		@Usuario 		char(10),
	   		@Personal 		char(10),
	   		@EstaPresente 		bit,
	   		@Retardo 		int,
                        @FechaHora              datetime = null 
 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID 			int,
    @CfgRegistroMovSucursal 	bit,
    @CfgHoraCambioJornada	char(5),
    @Hoy   			datetime,
    @FechaAplicacion		datetime,
    @Renglon   			float,
    @Registro   		varchar(20),
    @Hora   			varchar(5)
 
  IF @FechaHora = NULL    
    SELECT @Hoy  = GETDATE()
  ELSE
    SELECT @Hoy  = @FechaHora 
 
  SELECT @Hora = LEFT(CONVERT(varchar, @Hoy, 14),5)
  EXEC spExtraerFecha @Hoy OUTPUT
  SELECT @FechaAplicacion = @Hoy

  SELECT @CfgRegistroMovSucursal = RegistroMovSucursal,
         @CfgHoraCambioJornada = NULLIF(RTRIM(HoraCambioJornada), '')
    FROM EmpresaCfgAcceso 
   WHERE Empresa = @Empresa

  SELECT @EstaPresente = ~@EstaPresente -- aqui cambia el esta presente
  UPDATE Personal SET EstaPresente = @EstaPresente WHERE Personal = @Personal

  IF @EstaPresente = 1  
  BEGIN
    SELECT @Registro = 'Entrada'  
    IF @CfgHoraCambioJornada IS NOT NULL AND @Hora >= @CfgHoraCambioJornada SELECT @FechaAplicacion = DATEADD(day, 1, @FechaAplicacion)
  END ELSE 
    SELECT @Registro = 'Salida'

  SELECT @ID = NULL
  IF @CfgRegistroMovSucursal = 1
    SELECT @ID = MIN(ID) FROM Asiste WHERE Empresa = @Empresa AND Mov = 'Registro' AND Estatus = 'BORRADOR' AND FechaEmision = @Hoy AND FechaAplicacion = @FechaAplicacion AND Sucursal = @Sucursal 
  ELSE
    SELECT @ID = MIN(ID) FROM Asiste WHERE Empresa = @Empresa AND Mov = 'Registro' AND Estatus = 'BORRADOR' AND FechaEmision = @Hoy AND FechaAplicacion = @FechaAplicacion 

  IF @ID IS NULL
  BEGIN
    INSERT Asiste (Empresa,   Mov,       FechaEmision, FechaAplicacion, UltimoCambio, Usuario,  Estatus,     Sucursal) 
           VALUES (@Empresa, 'Registro', @Hoy,         @FechaAplicacion, GETDATE(),    @Usuario, 'BORRADOR', @Sucursal)
    SELECT @ID = SCOPE_IDENTITY()
  END
 
  SELECT @Renglon = 0.0
  SELECT @Renglon = ISNULL(MAX(Renglon), 0.0) + 2048.0 FROM AsisteD WHERE ID = @ID
  INSERT AsisteD (ID,  Renglon,  Personal,  Registro,  HoraRegistro, FechaD, FechaA, Sucursal,  Retardo)
          VALUES (@ID, @Renglon, @Personal, @Registro, @Hora,        @Hoy,   @Hoy,   @Sucursal, @Retardo)
  RETURN
END
GO

/**************** spSacaLosPresentes ****************/
if exists (select * from sysobjects where id  =  object_id('dbo.spSacaLosPresentes') and type  =  'P') drop procedure dbo.spSacaLosPresentes
GO
CREATE PROCEDURE spSacaLosPresentes    
    @Empresa char(20),    
    @Usuario char(10)    
    
--//WITH ENCRYPTION
AS BEGIN    
  DECLARE    
    @Personal char(10),    
    @ID       int,    
    @Renglon  Float,    
    @Ok       int,    
    @OkRef    varchar(255)    
    
  IF DATEPART(hh, GETDATE()) > 21    
  BEGIN    
    DECLARE crPresenteSalida CURSOR FOR    
    SELECT Personal FROM Personal WHERE EstaPresente  =  1 AND ESTATUS  =  'ALTA'    
    
    OPEN crPresenteSalida    
    FETCH NEXT FROM crPresenteSalida INTO @Personal    
    IF @@FETCH_STATUS  =  0    
      INSERT Asiste(Empresa, Mov, FechaEmision, Usuario, Estatus, Observaciones)    
   VALUES(@Empresa, 'Registro', CONVERT(datetime, FLOOR(CONVERT(float, GETDATE()))), @Usuario, 'SINAFECTAR', 'No Marco Salida')    
    
  SELECT @ID = @@IDENTITY, @Renglon = 2048.0    
  WHILE @@FETCH_STATUS  =  0    
  BEGIN    
   INSERT AsisteD(ID, Renglon, Personal, Registro, HoraRegistro, FechaD, FechaA, Observaciones)    
   VALUES(@ID, @Renglon, @Personal, 'Salida', '23:59', CONVERT(datetime, FLOOR(CONVERT(float, GETDATE()))), CONVERT(datetime, GETDATE(), 103), 'No Marco Salida')    
    
   UPDATE Personal SET EstaPresente = 0 WHERE Personal = @Personal    
   SELECT @Renglon  =  @Renglon + 2048.0    
   FETCH NEXT FROM crPresenteSalida INTO @Personal    
    END    
--    EXEC spAfectar 'ASIS', @ID, NULL, NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1    
    
  CLOSE crPresenteSalida    
  DEALLOCATE crPresenteSalida    
    
  UPDATE Personal SET EstaPresente = 0 WHERE EstaPresente = 1    
END    
END    
GO
PRINT "******************* SP Asiste ******************"
