SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ANSI_PADDING OFF
GO
/* SP Procesar Asistecias  */
/**************** spGenerarJornada ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarJornada') and type = 'P') drop procedure dbo.spGenerarJornada
GO
CREATE PROCEDURE spGenerarJornada
		    @Jornada	varchar(20),
		    @FechaD	datetime,
		    @FechaA	datetime	
--//WITH ENCRYPTION 
AS BEGIN
  DECLARE
    @Ok			 int,
    @Domingo 		 bit,
    @Lunes   		 bit,
    @Martes  		 bit,
    @Miercoles		 bit,
    @Jueves		 bit,
    @Viernes		 bit,
    @Sabado		 bit,
    @DescansoRompeRutina bit,
    @DescansaFestivos	 bit,
    @FestivoRompeRutina	 bit,
    @Dia		 int,
    @UltDia		 int,
    @HoraEntrada	 char(5),
    @HoraSalida		 char(5),
    @DiaSemana		 int,
    @NoLabora		 bit,
    @EsFestivoGeneral    bit,
    @EsFestivoJornada    bit,
    @Entrada		 datetime,
    @Salida		 datetime,
    @Fecha		 datetime,
    @BrincaDia		 int,
    @RompeRutina	 int,
    @Nocturna		 bit

  SET DATEFIRST 7
  EXEC spExtraerFecha @FechaD OUTPUT
  EXEC spExtraerFecha @FechaA OUTPUT
  SELECT @FechaA = DATEADD(day, 1, @FechaA)

  IF NOT EXISTS(SELECT * FROM Jornada WHERE Jornada = @Jornada) RETURN

  SELECT @Ok = NULL
  SELECT @Domingo   		= Domingo, 
         @Lunes     		= Lunes, 
         @Martes    		= Martes, 
         @Miercoles 		= Miercoles, 
         @Jueves    		= Jueves, 
         @Viernes   		= Viernes,		 
         @Sabado    		= Sabado,
         @DescansoRompeRutina	= DescansoRompeRutina,
         @DescansaFestivos	= DescansaFestivos,
         @FestivoRompeRutina	= FestivoRompeRutina
    FROM Jornada 
   WHERE Jornada = @Jornada

  BEGIN TRANSACTION
    -- Eliminar tiempos anteriores
    DELETE JornadaTiempo WHERE Jornada = @Jornada AND Entrada >= @FechaD 
    SELECT @Entrada = @FechaD
    WHILE @Entrada < @FechaA
    BEGIN
      DECLARE crRutina CURSOR
         FOR SELECT d.Dia, d.Entrada, d.Salida,j.JornadaNocturna
               FROM JornadaD d
               JOIN Jornada j ON d.Jornada = j.Jornada
              WHERE d.Jornada = @Jornada
              ORDER BY d.Dia, CASE WHEN ISNULL(j.JornadaNocturna,0)=1 THEN d.Salida ELSE d.Entrada END
      OPEN crRutina
      FETCH NEXT FROM crRutina INTO @Dia, @HoraEntrada, @HoraSalida,@Nocturna
      SELECT @UltDia = @Dia, @RompeRutina = 0, @BrincaDia = 0
      WHILE @@FETCH_STATUS <> -1 AND @Entrada < @FechaA AND @RompeRutina = 0 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @BrincaDia = 0 AND @Ok IS NULL
        BEGIN
          SELECT @NoLabora = 0, @EsFestivoGeneral = 0, @EsFestivoJornada = 0, @Fecha = @Entrada
          EXEC spExtraerFecha @Fecha OUTPUT

          SELECT @DiaSemana = DATEPART(weekday, @Fecha)
          IF (@DiaSemana = 1 AND @Domingo   = 1) OR (@DiaSemana = 2 AND @Lunes  = 1) OR (@DiaSemana = 3 AND @Martes  = 1) OR
             (@DiaSemana = 4 AND @Miercoles = 1) OR (@DiaSemana = 5 AND @Jueves = 1) OR (@DiaSemana = 6 AND @Viernes = 1) OR
             (@DiaSemana = 7 AND @Sabado    = 1)  
            SELECT @NoLabora = 1
          IF @NoLabora = 0
          BEGIN 
            IF @Fecha IN (SELECT Fecha FROM DiaFestivo WHERE EsLaborable = 0) 
              SELECT @EsFestivoGeneral = 1
            IF @Fecha IN (SELECT Fecha FROM JornadaDiaFestivo WHERE Jornada = @Jornada AND EsLaborable = 0) 
              SELECT @EsFestivoJornada = 1

            IF @EsFestivoJornada = 1 OR (@EsFestivoGeneral = 1 AND @DescansaFestivos = 1)
            BEGIN
              SELECT @BrincaDia = 1
              IF @FestivoRompeRutina = 1 SELECT @RompeRutina = 1
            END ELSE 
            BEGIN
              SELECT @Entrada = @Fecha
              EXEC spAgregarHora @HoraEntrada, @Entrada OUTPUT
              SELECT @Salida = @Fecha
              EXEC spAgregarHora @HoraSalida, @Salida OUTPUT
              
              IF @Salida < @Entrada AND @Nocturna = 0  SELECT @Salida = DATEADD(day, 1, @Salida)

              INSERT JornadaTiempo (Jornada,  Entrada,  Salida) 
                            VALUES (@Jornada, @Entrada, @Salida)
            END
          END ELSE
          BEGIN
            SELECT @BrincaDia = 1
            IF @DescansoRompeRutina = 1 SELECT @RompeRutina = 1
          END
        END
        FETCH NEXT FROM crRutina INTO @Dia, @HoraEntrada, @HoraSalida,@Nocturna
        IF @Dia = @UltDia SELECT @Entrada = @Fecha 
        IF @Dia <> @UltDia OR @RompeRutina = 1 OR @@FETCH_STATUS = -1 SELECT @Entrada = DATEADD(day, 1, @Fecha), @UltDia = @Dia, @BrincaDia = 0
      END  -- While
      CLOSE crRutina
      DEALLOCATE crRutina
    END -- While
  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT "Se Genero con Exito la Jornada Laboral de Periodo Indicado"
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT "Error al Generar la Jornada Laboral"
  END
  RETURN
END
GO

/**************** spGenerarAsiste ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarAsiste') and type = 'P') drop procedure dbo.spGenerarAsiste
GO
CREATE PROCEDURE spGenerarAsiste
		    @Empresa		char(5),
		    @Personal		char(10),
		    @FechaInicial	datetime,
		    @FechaFinal		datetime,
		    @Ok			int		OUTPUT,
		    @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mov		char(20),
    @MovID		varchar(20),
    @MovTipo		char(20),
    @FechaEmision	datetime,
    @Concepto		varchar(50),
    @Localidad		varchar(50),
    @UltEntrada		datetime,
    @UltSalida		datetime,
    @UltLocalidad	varchar(50),
    @Registro		char(10),   -- Entrada / Salida
    @HoraRegistro	char(5),
    @HoraD		char(5),
    @HoraA		char(5),
    @FechaD		datetime,
    @FechaA		datetime,
    @Entrada		datetime,
    @Salida		datetime,
    @FechaRegistro	datetime,
    @Fecha		datetime,
	@FechaUltEntrada varchar(25),
	@HoraUltEntrada varchar(5),
	@FechaUltSalida varchar(25),
	@HoraUltSalida varchar(5)

  SELECT @UltEntrada = NULL, @UltSalida = NULL, @UltLocalidad = NULL
  SELECT @UltEntrada = MAX(Entrada) 
    FROM PersonalAsiste 
   WHERE Empresa = @Empresa AND Personal = @Personal AND Fecha < @FechaInicial

  IF @UltEntrada IS NOT NULL
    SELECT @UltSalida = Salida, @UltLocalidad = Localidad 
      FROM PersonalAsiste 
     WHERE Empresa = @Empresa AND Personal = @Personal AND Fecha < @FechaInicial AND Entrada = @UltEntrada     

  DECLARE crProcesar CURSOR
     FOR SELECT NULLIF(RTRIM(a.Mov), ''), a.MovID, mt.Clave, a.FechaEmision, NULLIF(RTRIM(d.Concepto), ''), NULLIF(RTRIM(a.Localidad), ''), 
                NULLIF(UPPER(RTRIM(d.Registro)), ''), NULLIF(RTRIM(d.HoraRegistro), ''), NULLIF(RTRIM(d.HoraD), ''), NULLIF(RTRIM(d.HoraA), ''), d.FechaD, d.FechaA
           FROM Asiste a, AsisteD d, MovTipo mt
          WHERE a.Mov = mt.Mov
            AND mt.Modulo = 'ASIS'
            AND mt.Clave IN ('ASIS.A', 'ASIS.R')
            AND a.ID = d.ID
            AND a.Estatus = 'PROCESAR'
            AND a.Empresa = @Empresa
            AND ISNULL(a.FechaAplicacion, a.FechaEmision) >= @FechaInicial 
            AND ISNULL(a.FechaAplicacion, a.FechaEmision) < DATEADD(day, 1, @FechaFinal)
            AND d.Personal = @Personal
          ORDER BY a.FechaEmision, d.HoraRegistro, d.HoraD, d.FechaD

  OPEN crProcesar
  FETCH NEXT FROM crProcesar INTO @Mov, @MovID, @MovTipo, @FechaEmision, @Concepto, @Localidad, @Registro, @HoraRegistro, @HoraD, @HoraA, @FechaD, @FechaA
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC spExtraerFecha @FechaEmision OUTPUT
      IF @MovTipo = 'ASIS.R'
      BEGIN
        SELECT @FechaRegistro = @FechaEmision
        EXEC spAgregarHora @HoraRegistro, @FechaRegistro OUTPUT
	IF @Registro = 'ENTRADA' 
        BEGIN

			/* NES - Se aumenta el siguiente bloque para corregir cuando un personal tiene una Entrada ya procesada en otro corte y para que
					mande el error 55200 Entrada Incorrecta cuando se trata de capturar un Registro de Entrada consecutivamente */
			IF @UltSalida IS NULL
			BEGIN
				SELECT TOP 1 @FechaUltSalida = UPPER(d.Registro), @UltEntrada = a.FechaEmision
					FROM Asiste a
					JOIN AsisteD d ON a.ID = d.ID
					JOIN MovTipo mt ON a.Mov = mt.Mov AND mt.Modulo = 'ASIS'
					WHERE mt.Clave = 'ASIS.R'
					AND a.Empresa = @Empresa
					AND a.Estatus = 'CONCLUIDO'
					AND d.Personal = @Personal
					ORDER BY d.Fecha DESC, d.HoraRegistro DESC
				IF @FechaUltSalida = 'SALIDA'
					SELECT @UltEntrada = NULL, @UltSalida = NULL
				ELSE
					SELECT @UltSalida = NULL
			END


          IF @UltEntrada IS NULL OR (@UltSalida IS NOT NULL AND @UltSalida < @FechaRegistro)
          BEGIN
            INSERT PersonalAsiste (Empresa, Personal, Entrada, Localidad, Fecha) 
                           VALUES (@Empresa, @Personal, @FechaRegistro, @Localidad, @FechaEmision)
            SELECT @UltEntrada = @FechaRegistro, @UltLocalidad = @Localidad
          END ELSE 
            SELECT @Ok = 55200
        END ELSE
	IF @Registro = 'SALIDA' 
        BEGIN

			/* NES - Se aumenta este bloque para que busque si hay una entrada del personal que ya haya sido procesada en otro corte que es la ultima
					entrada antes de este corte, para evitar que salga el error 55210 Salida Incorrecta cuando no es así */
			IF @UltEntrada IS NULL
			BEGIN
				SELECT TOP 1 @FechaUltEntrada = d.Fecha, @HoraUltEntrada = d.HoraRegistro
				FROM Asiste a
				JOIN AsisteD d ON a.ID = d.ID
				JOIN MovTipo mt ON a.Mov = mt.Mov AND mt.Modulo = 'ASIS'
				WHERE mt.Clave = 'ASIS.R'
				AND a.Empresa = @Empresa
				AND a.Estatus IN('CONCLUIDO','PROCESAR')
				AND d.Personal = @Personal
				AND UPPER(d.Registro) = 'ENTRADA'
				ORDER BY d.Fecha DESC, d.HoraRegistro DESC

				SELECT @UltEntrada = CONVERT(datetime, @FechaUltEntrada, 21)
				SELECT @UltEntrada = DATEADD(hour, dbo.fnDividirHora(@HoraUltEntrada, 'H'), @UltEntrada)
				SELECT @UltEntrada = DATEADD(minute, dbo.fnDividirHora(@HoraUltEntrada, 'M'), @UltEntrada)

				IF EXISTS(SELECT HoraRegistro
							FROM Asiste a
							JOIN AsisteD d ON a.ID = d.ID
							JOIN MovTipo mt ON a.Mov = mt.Mov AND mt.Modulo = 'ASIS'
							WHERE mt.Clave = 'ASIS.R'
							AND a.Empresa = @Empresa
							AND a.Estatus = 'CONCLUIDO'
							AND d.Personal = @Personal
							AND UPPER(d.Registro) = 'SALIDA'
							AND a.FechaEmision >= @UltEntrada AND a.FechaEmision < @FechaInicial)
					SELECT @UltEntrada = NULL
				ELSE
					INSERT PersonalAsiste (Empresa, Personal, Entrada, Localidad, Fecha)
					VALUES (@Empresa, @Personal, @UltEntrada, @Localidad, @FechaEmision)
			END

          IF @UltEntrada IS NOT NULL AND @Localidad = @UltLocalidad
          BEGIN
            UPDATE PersonalAsiste SET Salida = @FechaRegistro WHERE Empresa = @Empresa AND Personal = @Personal AND Entrada = @UltEntrada
            SELECT @UltSalida = @FechaRegistro, @UltLocalidad = @Localidad
          END ELSE 
            SELECT @Ok = 55210           
        END
      END ELSE
      IF @MovTipo = 'ASIS.A'
      BEGIN
        SELECT @FechaD = @FechaEmision, @FechaA = @FechaEmision
        EXEC spAgregarHora @HoraD, @FechaD OUTPUT
        EXEC spAgregarHora @HoraA, @FechaA OUTPUT
        IF @FechaA >= @FechaD AND @FechaD IS NOT NULL AND (@FechaD > @UltEntrada OR @UltEntrada IS NULL)
        BEGIN
          IF @FechaA IS NOT NULL AND (@FechaA > @UltSalida OR @UltSalida IS NULL)
          BEGIN
            SELECT @Fecha = @FechaD
            EXEC spExtraerFecha @Fecha OUTPUT
            INSERT PersonalAsiste (Empresa,  Personal,  Entrada, Salida,  Localidad,  Fecha) 
                           VALUES (@Empresa, @Personal, @FechaD, @FechaA, @Localidad, @Fecha)
            SELECT @UltEntrada = @FechaD, @UltSalida = @FechaA, @UltLocalidad = @Localidad
          END ELSE 
            SELECT @Ok = 55210
        END ELSE 
          SELECT @Ok = 55200
      END
      IF @Ok IS NOT NULL AND @OkRef IS NULL
        SELECT @OkRef = 'Persona: '+RTRIM(@Personal)+'<BR>'+'Movimiento: '+RTRIM(@Mov)+' '+@MovID
    END
    FETCH NEXT FROM crProcesar INTO @Mov, @MovID, @MovTipo, @FechaEmision, @Concepto, @Localidad, @Registro, @HoraRegistro, @HoraD, @HoraA, @FechaD, @FechaA
  END  -- While
  CLOSE crProcesar
  DEALLOCATE crProcesar

  RETURN
END
GO

/**************** spGenerarAsisteAusencia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarAsisteAusencia') and type = 'P') drop procedure dbo.spGenerarAsisteAusencia
GO
CREATE PROCEDURE spGenerarAsisteAusencia
		    @Empresa		char(5),
		    @CfgToleraEntrada	int, 
		    @CfgToleraSalida	int, 
		    @Personal		char(10),
		    @Jornada		varchar(20),
		    @FechaAlta		datetime,
		    @FechaInicial	datetime,
		    @FechaFinal		datetime,

		    @Ok			int		OUTPUT,
		    @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @UltID		int,
    @FechaEntrada	datetime,
    @FechaSalida	datetime,
    @Entrada		datetime,
    @Salida		datetime,
    @EntradaReal	datetime,
    @SalidaReal		datetime,
    @Dia		int,
    @Mes		int,
    @Ano		int,
    @Dias		int,
    @Minutos	int,
    @Nocturna   bit
  
  SELECT @Nocturna = JornadaNocturna 
    FROM Jornada 
   WHERE Jornada = @Jornada
   
   SET @Nocturna = ISNULL(@Nocturna,0)
  
  IF NOT EXISTS(SELECT * FROM JornadaTiempo WHERE Jornada = @Jornada AND Entrada > @FechaFinal)
  BEGIN
    SELECT @Ok = 55260
    RETURN
  END

  SELECT @UltID = 0
  DECLARE crJornadaTiempo CURSOR
     FOR SELECT Entrada, Salida
           FROM JornadaTiempo
          WHERE Jornada = @Jornada AND Salida > @FechaInicial AND Entrada < DATEADD(day, 1, @FechaFinal) AND Entrada >= @FechaAlta
  SELECT @EntradaReal = @FechaInicial              
  OPEN crJornadaTiempo
  FETCH NEXT FROM crJornadaTiempo INTO @Entrada, @Salida

  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @FechaEntrada = @Entrada, @FechaSalida = @Salida
      EXEC spExtraerFecha @FechaEntrada OUTPUT
      EXEC spExtraerFecha @FechaSalida  OUTPUT
      IF EXISTS(SELECT * FROM PersonalAsiste WHERE Empresa = @Empresa AND Personal = @Personal/* NES Para corrección de entradas y salidas en diferentes dias AND Fecha = @FechaEntrada*/
					AND DAY(Entrada) = DAY(@FechaEntrada) AND MONTH(Entrada) = MONTH(@FechaEntrada) AND YEAR(Entrada) = YEAR(@FechaEntrada))
      BEGIN
        SELECT @ID = NULL
        SELECT @ID = MIN(ID)
          FROM PersonalAsiste 
         WHERE Empresa = @Empresa AND Personal = @Personal AND Fecha = @FechaEntrada AND ProcesarAusencia = 1 AND ID > @UltID

        IF @ID IS NULL 
        BEGIN
          SELECT @Minutos = DATEDIFF(mi, @Entrada, @Salida)
          
          IF @Nocturna = 1 
          BEGIN
            SET @EntradaReal =  DATEADD(dd,-1,@EntradaReal)
            SELECT @Minutos = DATEDIFF(mi, @Entrada, @EntradaReal)
          END

          IF @Minutos > @CfgToleraEntrada 
            INSERT PersonalAsisteDifMin (Empresa,  Personal,  FechaHoraD, FechaHoraA, Fecha,         Ausencia, Registro) 
                                 VALUES (@Empresa, @Personal, @Entrada,   @Salida,    @FechaEntrada, @Minutos, 'Entrada')
        END ELSE 
        BEGIN
          SELECT @UltID = ID, @EntradaReal = Entrada, @SalidaReal  = Salida 
            FROM PersonalAsiste 
           WHERE ID = @ID

          SELECT @Minutos = DATEDIFF(mi, @Entrada, @EntradaReal)

          IF @Nocturna = 1 
          BEGIN
            SET @EntradaReal =  DATEADD(dd,-1,@EntradaReal)
            SELECT @Minutos = DATEDIFF(mi, @Entrada, @EntradaReal)
          END
          IF @Minutos > @CfgToleraEntrada
            INSERT PersonalAsisteDifMin (Empresa,  Personal,  FechaHoraD, FechaHoraA,   Fecha,         Ausencia, Registro) 
                                 VALUES (@Empresa, @Personal, @Entrada,   @EntradaReal, @FechaEntrada, @Minutos, 'Entrada')

          SELECT @Minutos = DATEDIFF(mi, @SalidaReal, @Salida)
          IF @Nocturna = 1 
          BEGIN
            SET @SalidaReal =  DATEADD(dd,-1,@SalidaReal)
            SELECT @Minutos = DATEDIFF(mi, @Salida, @SalidaReal)
          END
          IF @Minutos > @CfgToleraSalida
            INSERT PersonalAsisteDifMin (Empresa,  Personal,  FechaHoraD,  FechaHoraA, Fecha,        Ausencia, Registro) 
                                 VALUES (@Empresa, @Personal, @SalidaReal, @Salida,    @FechaSalida, @Minutos, 'Salida')
                                
                                                                                   
        END
      END ELSE 
      BEGIN
        IF NOT EXISTS(SELECT * FROM PersonalAsisteDifDia WHERE Empresa = @Empresa AND Personal = @Personal AND Fecha = @FechaEntrada)
          INSERT PersonalAsisteDifDia (Empresa, Personal, Fecha, Ausencia) VALUES (@Empresa, @Personal, @FechaEntrada, 1)
      END
      UPDATE PersonalAsiste SET ProcesarAusencia = 0 WHERE ID = @ID
    END
    FETCH NEXT FROM crJornadaTiempo INTO @Entrada, @Salida
  END  -- While
  CLOSE crJornadaTiempo
  DEALLOCATE crJornadaTiempo
  RETURN
END
GO

/**************** spGenerarAsisteExtra ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarAsisteExtra') and type = 'P') drop procedure dbo.spGenerarAsisteExtra
GO
CREATE PROCEDURE spGenerarAsisteExtra
		    @Empresa		char(5),
		    @Personal		char(10),
		    @Jornada		varchar(20),
		    @FechaInicial	datetime,
		    @FechaFinal		datetime,

		    @Ok			int		OUTPUT,
		    @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaEntrada	datetime,
    @FechaSalida	datetime,
    @Entrada		datetime,
    @Salida		datetime,
    @EntradaReal	datetime,
    @SalidaReal		datetime,
    @Dias		int,
    @Minutos		int,
    @Nocturna		bit
  
  SELECT @Nocturna = JornadaNocturna 
    FROM Jornada 
   WHERE Jornada = @Jornada
   
   SET @Nocturna = ISNULL(@Nocturna,0)
   
  DECLARE crAsistenciaReal CURSOR
     FOR SELECT Entrada, Salida
           FROM PersonalAsiste
          WHERE Empresa = @Empresa AND Personal = @Personal AND ProcesarExtra = 1 

  SELECT @Entrada = @FechaInicial              
  OPEN crAsistenciaReal
  FETCH NEXT FROM crAsistenciaReal INTO @EntradaReal, @SalidaReal
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @FechaEntrada = @EntradaReal, @FechaSalida = @SalidaReal
      EXEC spExtraerFecha @FechaEntrada OUTPUT
      EXEC spExtraerFecha @FechaSalida OUTPUT
      IF EXISTS(SELECT * FROM JornadaTiempo WHERE Jornada = @Jornada AND Fecha = @FechaEntrada)
      BEGIN
        SELECT @Entrada = MIN(Entrada)
          FROM JornadaTiempo
         WHERE Jornada = @Jornada AND Fecha = @FechaEntrada AND Entrada > @EntradaReal AND Entrada < @SalidaReal

        SELECT @Minutos = DATEDIFF(mi, @EntradaReal, @Entrada)
        IF @Minutos > 0
          INSERT PersonalAsisteDifMin (Empresa,  Personal,  FechaHoraD,   FechaHoraA, Fecha,         Extra,    Registro) 
                               VALUES (@Empresa, @Personal, @EntradaReal, @Entrada,   @FechaEntrada, @Minutos, 'Entrada')
        SELECT @Salida = MIN(Salida)
          FROM JornadaTiempo
         WHERE Jornada = @Jornada AND Fecha = @FechaSalida AND Salida > @EntradaReal AND Salida < @SalidaReal

        SELECT @Minutos = DATEDIFF(mi, @Salida, @SalidaReal)
        IF @Minutos > 0 
          INSERT PersonalAsisteDifMin (Empresa,  Personal,  FechaHoraD, FechaHoraA,  Fecha,  Extra,    Registro) 
                               VALUES (@Empresa, @Personal, @Salida,    @SalidaReal, @FechaSalida, @Minutos, 'Salida')
      END ELSE 
        INSERT PersonalAsisteDifDia (Empresa, Personal, Fecha, Extra, Minutos) VALUES (@Empresa, @Personal, @FechaEntrada, 1, DATEDIFF(mi, @EntradaReal, @SalidaReal))
      UPDATE PersonalAsiste SET ProcesarExtra = 0 WHERE CURRENT OF crAsistenciaReal
    END
    FETCH NEXT FROM crAsistenciaReal INTO @EntradaReal, @SalidaReal
  END  -- While
  CLOSE crAsistenciaReal
  DEALLOCATE crAsistenciaReal

  DECLARE crAsistenciaGral CURSOR
     FOR SELECT Entrada, Salida
           FROM PersonalAsiste
          WHERE Empresa = @Empresa AND Personal = @Personal
  SELECT @Entrada = @FechaInicial              
  OPEN crAsistenciaGral
  FETCH NEXT FROM crAsistenciaGral INTO @EntradaReal, @SalidaReal
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @FechaEntrada = @EntradaReal
      EXEC spExtraerFecha @FechaEntrada OUTPUT
      
      SELECT @Minutos = DATEDIFF(mi, @EntradaReal, @SalidaReal)
      
      IF @Minutos < 0 AND @Nocturna = 1 
      BEGIN
        SET @EntradaReal =  DATEADD(dd,-1,@EntradaReal)
        SELECT @Minutos = DATEDIFF(mi, @EntradaReal, @SalidaReal)
      END

	  /* NES - Se corrige el siguiente bloque para corrección de entradas y salidas en diferentes días */
	  EXEC spExtraerFecha @EntradaReal OUTPUT
	  EXEC spExtraerFecha @SalidaReal OUTPUT
	  
	  IF @Nocturna = 1
		SET @SalidaReal = @EntradaReal
	  
	  IF @Minutos >0 
	  BEGIN
	    IF @SalidaReal IS NULL 
	      INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,         Cantidad, Tipo)
	      SELECT @Empresa, @Personal, @EntradaReal, @Minutos, 'Minutos Asistencia'
	    ELSE
	      INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,         Cantidad, Tipo)
	      SELECT @Empresa, @Personal, @SalidaReal, @Minutos, 'Minutos Asistencia'
	  END

    END
    FETCH NEXT FROM crAsistenciaGral INTO @EntradaReal, @SalidaReal
  END  -- While
  CLOSE crAsistenciaGral
  DEALLOCATE crAsistenciaGral
  RETURN
END
GO

/**************** spGenerarAsistePermisos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarAsistePermisos') and type = 'P') drop procedure dbo.spGenerarAsistePermisos
GO
CREATE PROCEDURE spGenerarAsistePermisos
		    @Empresa		char(5),
    		    @FechaInicial	datetime,
		    @FechaFinal		datetime,

		    @Ok			int		OUTPUT,
		    @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mov		char(20),
    @MovID		varchar(20),
    @Concepto		varchar(50),
    @Tipo		char(20),
    @FechaEmision	datetime,
    @Personal		char(10),
    @HoraD		char(5),
    @HoraA		char(5),
    @FechaD		datetime,
    @FechaA		datetime,
    @Minutos		int

  DECLARE crPermisosDias CURSOR
     FOR SELECT NULLIF(RTRIM(a.Mov), ''), a.MovID, NULLIF(UPPER(RTRIM(a.Tipo)), ''), NULLIF(RTRIM(d.Concepto), ''), a.FechaEmision, NULLIF(RTRIM(d.Personal), ''), NULLIF(RTRIM(d.HoraD), ''), NULLIF(RTRIM(d.HoraA), ''), d.FechaD, d.FechaA
           FROM Asiste a, AsisteD d, MovTipo mt
          WHERE a.Mov = mt.Mov
            AND a.ID = d.ID
            AND a.Empresa = @Empresa
            AND a.Estatus IN ('PROCESAR', 'CONCLUIDO')
            AND (d.FechaD BETWEEN @FechaInicial AND @FechaFinal OR d.FechaA BETWEEN @FechaInicial AND @FechaFinal)
            AND mt.Modulo = 'ASIS'
            AND mt.Clave = 'ASIS.PD'

  OPEN crPermisosDias
  FETCH NEXT FROM crPermisosDias INTO @Mov, @MovID, @Tipo, @Concepto, @FechaEmision, @Personal, @HoraD, @HoraA, @FechaD, @FechaA
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN 
      EXEC spExtraerFecha @FechaEmision OUTPUT
      EXEC spExtraerFecha @FechaD OUTPUT
      EXEC spExtraerFecha @FechaA OUTPUT
      WHILE @FechaD <= @FechaA
      BEGIN
        IF @Tipo = 'EXTRAS'
          INSERT PersonalAsisteDifDia (Empresa,  Personal,  Fecha,   Extra, Permiso, PermisoID, PermisoConcepto) 
                               VALUES (@Empresa, @Personal, @FechaD, 1,     @Mov,    @MovID,    @Concepto)
        ELSE
          INSERT PersonalAsisteDifDia (Empresa,  Personal,  Fecha,   Ausencia, Permiso, PermisoID, PermisoConcepto) 
                               VALUES (@Empresa, @Personal, @FechaD, 1,        @Mov,    @MovID,    @Concepto)
        SELECT @FechaD = DATEADD(day, 1, @FechaD)
      END 
    END
    FETCH NEXT FROM crPermisosDias INTO @Mov, @MovID, @Tipo, @Concepto, @FechaEmision, @Personal, @HoraD, @HoraA, @FechaD, @FechaA
  END  -- While
  CLOSE crPermisosDias
  DEALLOCATE crPermisosDias

  DECLARE crPermisosMin CURSOR
     FOR SELECT NULLIF(RTRIM(a.Mov), ''), a.MovID, NULLIF(UPPER(RTRIM(a.Tipo)), ''), NULLIF(RTRIM(d.Concepto), ''), a.FechaEmision, NULLIF(RTRIM(d.Personal), ''), NULLIF(RTRIM(d.HoraD), ''), NULLIF(RTRIM(d.HoraA), ''), d.FechaD, d.FechaA
           FROM Asiste a, AsisteD d, MovTipo mt
          WHERE a.Mov = mt.Mov
            AND a.ID = d.ID
            AND a.Empresa = @Empresa
            AND a.Estatus = 'PROCESAR'
            AND a.FechaEmision >= @FechaInicial AND a.FechaEmision < DATEADD(day, 1, @FechaFinal)
            AND mt.Modulo = 'ASIS'
            AND mt.Clave = 'ASIS.PH'

  OPEN crPermisosMin
  FETCH NEXT FROM crPermisosMin INTO @Mov, @MovID, @Tipo, @Concepto, @FechaEmision, @Personal, @HoraD, @HoraA, @FechaD, @FechaA
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN 
      EXEC spExtraerFecha @FechaEmision OUTPUT
      EXEC spExtraerFecha @FechaD OUTPUT
      EXEC spExtraerFecha @FechaA OUTPUT
      SELECT @FechaD = @FechaEmision, @FechaA = @FechaEmision
      EXEC spAgregarHora @HoraD, @FechaD OUTPUT
      EXEC spAgregarHora @HoraA, @FechaA OUTPUT
      SELECT @Minutos = DATEDIFF(mi, @HoraD, @HoraA)
      IF @Minutos > 0 
        IF @Tipo = 'EXTRAS'
          INSERT PersonalAsisteDifMin (Empresa,  Personal,  FechaHoraD, FechaHoraA, Fecha,         Extra,    Registro,  Permiso, PermisoID, PermisoConcepto)
                               VALUES (@Empresa, @Personal, @FechaD,    @FechaA,    @FechaEmision, @Minutos, 'Permiso', @Mov,    @MovID,    @Concepto)
        ELSE
          INSERT PersonalAsisteDifMin (Empresa,  Personal,  FechaHoraD, FechaHoraA, Fecha,         Ausencia, Registro,  Permiso, PermisoID, PermisoConcepto)
                               VALUES (@Empresa, @Personal, @FechaD,    @FechaA,    @FechaEmision, @Minutos, 'Permiso', @Mov,    @MovID,    @Concepto)
    END
    FETCH NEXT FROM crPermisosMin INTO @Mov, @MovID, @Tipo, @Concepto, @FechaEmision, @Personal, @HoraD, @HoraA, @FechaD, @FechaA
  END  -- While
  CLOSE crPermisosMin
  DEALLOCATE crPermisosMin
  RETURN
END
GO

/**************** spGenerarAsisteJustificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarAsisteJustificar') and type = 'P') drop procedure dbo.spGenerarAsisteJustificar
GO
CREATE PROCEDURE spGenerarAsisteJustificar
		    @Empresa		char(5),
		    @Personal		char(10),
    		    @Fecha		datetime,
    		    @Registro		char(10),
    		    @FechaHoraD		datetime,
    		    @FechaHoraA		datetime,
		    @Ausencia		int,
		    @Extra		int,

		    @Ok			int		OUTPUT,
		    @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Concepto		varchar(50),
    @TotalPermisos	int,
    @Permiso		int

  IF @Ausencia > 0
  BEGIN
    SELECT @TotalPermisos = 0
    DECLARE crPermisos CURSOR FOR
        SELECT PermisoConcepto, SUM(Ausencia)
          FROM PersonalAsisteDifMin 
         WHERE Empresa = @Empresa AND Personal = @Personal AND Fecha = @Fecha AND Ausencia > 0 AND Permiso IS NOT NULL AND PermisoID IS NOT NULL 
           --- Bug 23659
           ---AND FechaHoraD >= @FechaHoraD
           ---AND FechaHoraA <= @FechaHoraA
           AND @FechaHoraD >= FechaHoraD
           AND @FechaHoraA  <= FechaHoraA
         GROUP BY PermisoConcepto, FechaHoraD
         ORDER BY PermisoConcepto, FechaHoraD
    OPEN crPermisos
    FETCH NEXT FROM crPermisos INTO @Concepto, @Permiso
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL AND @Ausencia > @TotalPermisos
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN 
        IF @Permiso + @TotalPermisos > @Ausencia SELECT @Permiso = @Ausencia - @TotalPermisos
        INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Registro,  Concepto,  Cantidad, Tipo) 
                          VALUES (@Empresa, @Personal, @Fecha, @Registro, @Concepto, @Permiso, 'Minutos Ausencia')
        SELECT @TotalPermisos = @TotalPermisos + @Permiso
      END
      FETCH NEXT FROM crPermisos INTO @Concepto, @Permiso
    END  -- While
    CLOSE crPermisos
    DEALLOCATE crPermisos
    IF @Ausencia > @TotalPermisos
      INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Registro,  Cantidad,                     Tipo) 
                        VALUES (@Empresa, @Personal, @Fecha, @Registro, (@Ausencia - @TotalPermisos), 'Minutos Ausencia')
  END

  IF @Extra > 0
  BEGIN
    SELECT @TotalPermisos = 0
    DECLARE crPermisos CURSOR FOR
        SELECT PermisoConcepto, SUM(Extra)
          FROM PersonalAsisteDifMin 
         WHERE Empresa = @Empresa AND Personal = @Personal AND Fecha = @Fecha AND Extra > 0 AND Permiso IS NOT NULL AND PermisoID IS NOT NULL AND FechaHoraD >= @FechaHoraD AND @FechaHoraA BETWEEN FechaHoraD AND FechaHoraA 
         GROUP BY PermisoConcepto, FechaHoraD
         ORDER BY PermisoConcepto, FechaHoraD
    OPEN crPermisos
    FETCH NEXT FROM crPermisos INTO @Concepto, @Permiso
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL AND @Extra > @TotalPermisos
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN 
        IF @Permiso + @TotalPermisos > @Extra SELECT @Permiso = @Extra - @TotalPermisos
        INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Registro,  Concepto,  Cantidad, Tipo) 
                          VALUES (@Empresa, @Personal, @Fecha, @Registro, @Concepto, @Permiso, 'Minutos Extras')
        SELECT @TotalPermisos = @TotalPermisos + @Permiso
      END
      FETCH NEXT FROM crPermisos INTO @Concepto, @Permiso
    END  -- While
    CLOSE crPermisos
    DEALLOCATE crPermisos
  END
  RETURN
END
GO

/**************** spGenerarAsisteCorteMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarAsisteCorteMov') and type = 'P') drop procedure dbo.spGenerarAsisteCorteMov
GO
CREATE PROCEDURE spGenerarAsisteCorteMov
		    @Sucursal		int,
		    @Empresa		char(5),
		    @Usuario		char(10),
    		@FechaInicial	datetime,
		    @FechaFinal		datetime,
		    @Ok			    int		        OUTPUT,
		    @OkRef		    varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			                int,
    @Renglon		            float,
    @CfgMovCorte	            char(20),
    @FechaEmision	            datetime,
    @Personal		            char(10),
    @Registro		            char(10),
    @FechaHoraD		            datetime,
    @FechaHoraA		            datetime,
    @Fecha		                datetime, 
    @Extra		                int,
    @Ausencia		            int, 
    @Minutos		            int,
    @Cantidad		            int,
    @Tipo		                varchar(20),
    @Concepto		            varchar(50),
    @PersonalEstatus            char(15),
    @FechaBaja		            datetime,
    @Lenguaje                   varchar(25),
    @DiaSemanaAsist             int,
    @Jornada                    varchar(20),
    @Domingo                    bit, 
    @Sabado                     bit,
    @Lunes                      bit,    
    @Martes                     bit, 
    @Miercoles                  bit,
    @Jueves                     bit,   
    @Viernes                    bit,
    @AsistDescansolaborado      bit,
    @AsistDiaFestivolaborado    bit,
    @AsistDomingoLaborado       bit
    
    SET @Lenguaje = @@LANGUAGE

    SELECT @AsistDescansolaborado   = ISNULL(AsistDescansolaborado,0),
           @AsistDiaFestivolaborado = ISNULL(AsistDiaFestivolaborado,0), 
           @AsistDomingoLaborado    = ISNULL(AsistDomingoLaborado,0)
      FROM EmpresaCfg
      WHERE Empresa = @Empresa
  -- Dias
  DECLARE crDifDia CURSOR
     FOR SELECT Personal, Fecha, SUM(Ausencia), SUM(Extra), SUM(Minutos)
           FROM PersonalAsisteDifDia
          WHERE Empresa = @Empresa AND Fecha >= @FechaInicial AND Fecha < DATEADD(day, 1, @FechaFinal)-- AND Permiso IS NULL AND PermisoID IS NULL 
          GROUP BY Personal, Fecha
          ORDER BY Personal, Fecha

  OPEN crDifDia 
  FETCH NEXT FROM crDifDia INTO @Personal, @Fecha, @Ausencia, @Extra, @Minutos
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN  
      SELECT @Jornada = Jornada FROM Personal WHERE Personal = @Personal

      SELECT @Domingo   = Domingo   FROM Jornada WHERE Jornada = @Jornada
      SELECT @Sabado    = Sabado    FROM Jornada WHERE Jornada = @Jornada
      SELECT @Lunes     = Lunes     FROM Jornada WHERE Jornada = @Jornada
      SELECT @Martes    = Martes    FROM Jornada WHERE Jornada = @Jornada
      SELECT @Miercoles = Miercoles FROM Jornada WHERE Jornada = @Jornada
      SELECT @Jueves    = Jueves    FROM Jornada WHERE Jornada = @Jornada
      SELECT @Viernes   = Viernes   FROM Jornada WHERE Jornada = @Jornada      

      SELECT @Concepto = NULL
      IF @Ausencia > 0
      BEGIN
        SELECT @Concepto = PermisoConcepto
          FROM PersonalAsisteDifDia 
         WHERE Empresa = @Empresa AND Personal = @Personal AND Fecha = @Fecha AND Permiso IS NOT NULL AND PermisoID IS NOT NULL AND Ausencia > 0

        INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,            Concepto) 
                          VALUES (@Empresa, @Personal, @Fecha, 1,        'Dias Ausencia', @Concepto)
      END ELSE
      IF @Extra > 0 
      BEGIN

        SELECT @DiaSemanaAsist =  DATEPART (DW, @Fecha)  
        SELECT @Concepto = PermisoConcepto
          FROM PersonalAsisteDifDia
         WHERE Empresa = @Empresa AND Personal = @Personal AND Fecha = @Fecha AND Permiso IS NOT NULL AND PermisoID IS NOT NULL AND Extra > 0

        IF @@DATEFIRST = 1
        BEGIN
            IF ((@Fecha IN (SELECT Fecha FROM DiaFestivo)) OR (@Fecha IN (SELECT Fecha FROM JornadaDiaFestivo WHERE Jornada = @Jornada))) AND @AsistDiaFestivolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Día Festivo laborado', @Concepto)
            END
            ELSE IF @DiaSemanaAsist = 7 AND @AsistDomingoLaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Domingo Laborado', @Concepto)
            END
            ELSE IF (@Domingo = 1 AND @DiaSemanaAsist = 7) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, @Minutos, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Sabado = 1 AND @DiaSemanaAsist = 6) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Lunes = 1 AND @DiaSemanaAsist = 1) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Martes = 1 AND @DiaSemanaAsist = 2) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Miercoles = 1 AND @DiaSemanaAsist = 3) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Jueves = 1 AND @DiaSemanaAsist = 4) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Viernes = 1 AND @DiaSemanaAsist = 5) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END          
            ELSE      
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, @Minutos, 'Minutos Extras', @Concepto)
            END
        END

        IF @@DATEFIRST = 7
        BEGIN
            IF ((@Fecha IN (SELECT Fecha FROM DiaFestivo)) OR (@Fecha IN (SELECT Fecha FROM JornadaDiaFestivo WHERE Jornada = @Jornada))) AND @AsistDiaFestivolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Día Festivo laborado', @Concepto)
            END
            ELSE IF @DiaSemanaAsist = 1 AND @AsistDomingoLaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Domingo Laborado', @Concepto)
            END
            ELSE IF (@Domingo = 1 AND @DiaSemanaAsist = 1) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, @Minutos, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Sabado = 1 AND @DiaSemanaAsist = 7) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Lunes = 1 AND @DiaSemanaAsist = 2) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Martes = 1 AND @DiaSemanaAsist = 3) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Miercoles = 1 AND @DiaSemanaAsist = 4) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Jueves = 1 AND @DiaSemanaAsist = 5) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END
            ELSE IF (@Viernes = 1 AND @DiaSemanaAsist = 6) AND @AsistDescansolaborado = 1
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, 1, 'Descanso laborado', @Concepto)
            END          
            ELSE      
            BEGIN
                INSERT PersonalAsisteDif (Empresa,  Personal,  Fecha,  Cantidad, Tipo,             Concepto) 
                                  VALUES (@Empresa, @Personal, @Fecha, @Minutos, 'Minutos Extras', @Concepto)
            END
        END


      END
    END
    FETCH NEXT FROM crDifDia INTO @Personal, @Fecha, @Ausencia, @Extra, @Minutos
  END  -- While
  CLOSE crDifDia
  DEALLOCATE crDifDia

  -- Minutos
  DECLARE crDifMin CURSOR
     FOR SELECT Personal, Fecha, Registro, FechaHoraD, FechaHoraA, Ausencia, Extra
           FROM PersonalAsisteDifMin
          WHERE Empresa = @Empresa AND Fecha >= @FechaInicial AND Fecha < DATEADD(day, 1, @FechaFinal) AND Permiso IS NULL AND PermisoID IS NULL 
  OPEN crDifMin
  FETCH NEXT FROM crDifMin INTO @Personal, @Fecha, @Registro, @FechaHoraD, @FechaHoraA, @Ausencia, @Extra
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC spGenerarAsisteJustificar @Empresa, @Personal, @Fecha, @Registro, @FechaHoraD, @FechaHoraA, @Ausencia, @Extra, @Ok OUTPUT, @OkRef OUTPUT
    END

    FETCH NEXT FROM crDifMin INTO @Personal, @Fecha, @Registro, @FechaHoraD, @FechaHoraA, @Ausencia, @Extra
  END  -- While
  CLOSE crDifMin
  DEALLOCATE crDifMin

  -- Borrar Cortes Anteriores
  DECLARE crBorradores CURSOR
     FOR SELECT ID 
           FROM Asiste 
          WHERE Empresa = @Empresa AND Estatus = 'BORRADOR' AND Mov = @CfgMovCorte
  
  OPEN crBorradores
  FETCH NEXT FROM crBorradores INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      DELETE AsisteD WHERE ID = @ID
      DELETE Asiste  WHERE ID = @ID
    END
    FETCH NEXT FROM crBorradores INTO @ID
  END  -- While
  CLOSE crBorradores
  DEALLOCATE crBorradores

  -- Generar el Corte

  SELECT @FechaEmision = GETDATE(), @Renglon = 0.0
  EXEC spExtraerFecha @FechaEmision OUTPUT
  SELECT @CfgMovCorte = ISNULL(NULLIF(RTRIM(AsisteCorte), ''), 'Corte') FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @ID = NULL
  SELECT @ID = MAX(ID) FROM Asiste WHERE Empresa = @Empresa AND Usuario = @Usuario AND Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')

  IF @ID IS NULL
  BEGIN 
    INSERT Asiste (Sucursal, Empresa,  Mov,          FechaEmision,  Usuario,  Estatus,    FechaD,        FechaA) 
           VALUES (@Sucursal, @Empresa, @CfgMovCorte, @FechaEmision, @Usuario, 'BORRADOR', @FechaInicial, @FechaFinal)
    SELECT @ID = SCOPE_IDENTITY()
  END ELSE
  BEGIN
    DELETE AsisteD WHERE ID = @ID
    UPDATE Asiste 
       SET FechaEmision = @FechaEmision,
	   Estatus = 'BORRADOR',
           FechaD  = @FechaInicial,
           FechaA  = @FechaFinal
     WHERE ID = @ID
  END

  DECLARE crDif CURSOR
     FOR SELECT d.Personal, d.Fecha, d.Registro, d.Cantidad, d.Tipo, d.Concepto, p.Estatus, p.FechaBaja
           FROM PersonalAsisteDif d, Personal p
          WHERE d.Empresa = @Empresa AND d.Fecha >= @FechaInicial AND d.Fecha < DATEADD(day, 1, @FechaFinal) 
            AND d.Personal = p.Personal
          ORDER BY d.Personal, d.Fecha, d.Registro

  OPEN crDif
  FETCH NEXT FROM crDif INTO @Personal, @Fecha, @Registro, @Cantidad, @Tipo, @Concepto, @PersonalEstatus, @FechaBaja
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      IF @PersonalEstatus <> 'BAJA' OR @Fecha<=@FechaBaja
      BEGIN
        SELECT @Renglon = @Renglon + 2048
        INSERT AsisteD (Sucursal, ID,  Renglon,  Personal,  Fecha,  Registro,  Cantidad,  Tipo,  Concepto)
                VALUES (@Sucursal, @ID, @Renglon, @Personal, @Fecha, @Registro, @Cantidad, @Tipo, @Concepto)
      END
    END
    FETCH NEXT FROM crDif INTO @Personal, @Fecha, @Registro, @Cantidad, @Tipo, @Concepto, @PersonalEstatus, @FechaBaja
  END  -- While
  CLOSE crDif
  DEALLOCATE crDif
  RETURN
END
GO

/**************** spAsisteCorteFechas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAsisteCorteFechas') and type = 'P') drop procedure dbo.spAsisteCorteFechas
GO
CREATE PROCEDURE spAsisteCorteFechas
                    @Empresa		char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaD 	datetime,
    @FechaA 	datetime

  SELECT @FechaD = NULL, @FechaA = NULL
  SELECT @FechaD = MAX(FechaA) 
    FROM Asiste a, MovTipo mt 
   WHERE a.Mov = mt.Mov 
     AND mt.Modulo = 'ASIS'
     AND mt.Clave = 'ASIS.C' 
     AND Empresa = @Empresa 
     AND a.Estatus = 'CONCLUIDO'

  IF @FechaD IS NOT NULL 
  BEGIN
    EXEC spExtraerFecha @FechaD OUTPUT
    SELECT @FechaD = DATEADD(day, 1, @FechaD)
  END ELSE
    SELECT @FechaD = DATEADD(day, -DATEPART(day, @FechaA) + 1, @FechaA)

  SELECT @FechaA = DATEADD(day, -1, GETDATE())
  EXEC spExtraerFecha @FechaA OUTPUT

  SELECT "FechaD" = @FechaD, "FechaA" = @FechaA
  RETURN
END
GO

--  spGenerarAsisteCorte 0, 'DEMO', 'DEMO', '9/1/2006 00:00:00', '9/15/2005 00:00:00'      
/**************** spGenerarAsisteCorte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarAsisteCorte') and type = 'P') drop procedure dbo.spGenerarAsisteCorte
GO
CREATE PROCEDURE spGenerarAsisteCorte
		    @Sucursal		int,
                    @Empresa		char(5),
		    @Usuario		char(10),
    		    @FechaInicial	datetime,
		    @FechaFinal		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Personal		char(10),
    @FechaAlta		datetime,
    @Jornada		varchar(20),
    @CfgToleraEntrada 	int,
    @CfgToleraSalida	int,
    @Ok			int,
    @OkRef		varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  EXEC spExtraerFecha @FechaInicial OUTPUT
  EXEC spExtraerFecha @FechaFinal OUTPUT

  SELECT @CfgToleraEntrada = ISNULL(AsisteToleraEntrada, 0),
         @CfgToleraSalida  = ISNULL(AsisteToleraSalida, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  BEGIN TRANSACTION
/*
    DELETE PersonalAsisteDifDia WHERE Empresa = @Empresa AND Fecha >= @FechaInicial AND Fecha < DATEADD(day, 1, @FechaFinal)
    DELETE PersonalAsisteDifMin WHERE Empresa = @Empresa AND Fecha >= @FechaInicial AND Fecha < DATEADD(day, 1, @FechaFinal)
    DELETE PersonalAsisteDif    WHERE Empresa = @Empresa AND Fecha >= @FechaInicial AND Fecha < DATEADD(day, 1, @FechaFinal)
    DELETE PersonalAsiste       WHERE Empresa = @Empresa AND Fecha >= @FechaInicial AND Fecha < DATEADD(day, 1, @FechaFinal)
*/

    TRUNCATE TABLE PersonalAsisteDifDia 
    TRUNCATE TABLE PersonalAsisteDifMin 
    TRUNCATE TABLE PersonalAsisteDif    
    TRUNCATE TABLE PersonalAsiste       

    DECLARE crPersonal CURSOR
       FOR SELECT NULLIF(RTRIM(p.Personal), ''), NULLIF(RTRIM(p.Jornada), ''), p.FechaAlta
             FROM Personal p, Jornada j
            WHERE p.Jornada = j.Jornada
--            AND p.Estatus = 'ALTA'
			  AND p.Empresa = @Empresa
              AND UPPER(j.Tipo) = 'CONTROL ASISTENCIA'

    OPEN crPersonal
    FETCH NEXT FROM crPersonal INTO @Personal, @Jornada, @FechaAlta
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        EXEC spGenerarAsiste @Empresa, @Personal, @FechaInicial, @FechaFinal, @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL
          EXEC spGenerarAsisteAusencia @Empresa, @CfgToleraEntrada, @CfgToleraSalida, @Personal, @Jornada, @FechaAlta, @FechaInicial, @FechaFinal, @Ok OUTPUT, @OkRef OUTPUT

        IF @Ok IS NULL
          EXEC spGenerarAsisteExtra @Empresa, @Personal, @Jornada, @FechaInicial, @FechaFinal, @Ok OUTPUT, @OkRef OUTPUT

        IF @Ok IS NOT NULL AND @OkRef IS NULL 
          SELECT @OkRef = 'Persona: '+RTRIM(@Personal)
      END
      FETCH NEXT FROM crPersonal INTO @Personal, @Jornada, @FechaAlta
    END  -- While
    CLOSE crPersonal
    DEALLOCATE crPersonal

    IF @Ok IS NULL
      EXEC spGenerarAsistePermisos @Empresa, @FechaInicial, @FechaFinal, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spGenerarAsisteCorteMov @Sucursal, @Empresa, @Usuario, @FechaInicial, @FechaFinal, @Ok OUTPUT, @OkRef OUTPUT

/*    IF (SELECT AsisteJornadasNocturnas FROM EmpresaCfg WHERE Empresa = @Empresa) = 1 AND @Ok IS NULL
      EXEC spGenerarAsisteJornadasNocturnas @Empresa, @FechaFinal, @Ok OUTPUT, @OkRef OUTPUT*/

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT "Se Genero con Exito el Corte de Asistencia"
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT RTRIM(Descripcion)+'<BR>'+RTRIM(@OkRef) FROM MensajeLista WHERE Mensaje = @Ok  
  END
  
  RETURN
END
GO

-- spVerAsisteCorte 'DEMO', 'CJ', NULL, '1/1/1', '1/1/4', 'DIAS AUSENCIA', 0, 0, 1
/**************** spVerAsisteCorte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAsisteCorte') and type = 'P') drop procedure dbo.spVerAsisteCorte
GO
CREATE PROCEDURE spVerAsisteCorte
		    @Empresa		char(5),
    		    @Personal		char(10),
		    @Concepto		varchar(50),
    		    @FechaInicial	datetime,
		    @FechaFinal		datetime,
		    @Comando		char(20),	-- DIAS AUSENCIA, MINUTOS AUSENCIA, MINUTOS EXTRAS, RETARDOS, MINUTOS ASISTENCIA
		    @DiaSemana		int,		-- 0 = Todos, 1=unicamente Domingo, 2=Lunes .. 7=Sabado
	            @ExcluirDia		bit,
		    @ParaNomina		bit		-- 1 = Ignora el Concepto y Se basa en lo que la nomina necesita

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cont		bit,
    @Cantidad		int,
    @Suma		int,
    @Registro		char(10),
    @Fecha		datetime,
    @MovConcepto	varchar(50),
    @EnMinutos		bit,
    @Retardos		bit,
    @DiasSinSueldo	bit,
    @ConSueldo		bit,
    @CfgToleraEntrada	int,
    @CfgToleraSalida	int

  SELECT @Suma = 0.0, @Comando = UPPER(@Comando), @Concepto = NULLIF(RTRIM(@Concepto), ''), 
         @DiaSemana = ISNULL(@DiaSemana, 0), @DiasSinSueldo = 0, @Retardos = 0
  IF @Comando = 'DIAS SIN SUELDO' SELECT @Comando = 'DIAS AUSENCIA',    @DiasSinSueldo = 1
  IF @Comando = 'RETARDOS' 	  SELECT @Comando = 'MINUTOS AUSENCIA', @Retardos = 1

  IF @Comando IN ('MINUTOS AUSENCIA', 'MINUTOS EXTRAS', 'MINUTOS ASISTENCIA') SELECT @EnMinutos = 1 ELSE SELECT @EnMinutos = 0
  IF @EnMinutos = 1 
    SELECT @CfgToleraEntrada = ISNULL(AsisteToleraEntrada, 0),
           @CfgToleraSalida  = ISNULL(AsisteToleraSalida, 0)
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

  DECLARE crAsisteDif CURSOR FOR
   SELECT SUM(d.Cantidad), d.Fecha, NULLIF(RTRIM(d.Concepto), ''), NULLIF(UPPER(RTRIM(d.Registro)), '')
     FROM Asiste a, MovTipo mt, AsisteD d 
    WHERE a.ID = d.ID 
      AND mt.Modulo = 'ASIS'
      AND mt.Clave = 'ASIS.C' 
      AND a.Estatus = 'CONCLUIDO' 
      AND a.Empresa = @Empresa 
      AND d.Personal = @Personal 
      AND d.Fecha >= @FechaInicial 
      AND d.Fecha < DATEADD(day, 1, @FechaFinal) 
      AND UPPER(d.Tipo) = @Comando 
    GROUP BY d.Fecha, d.Concepto, d.Registro
    ORDER BY d.Fecha, d.Concepto, d.Registro

  OPEN crAsisteDif 
  FETCH NEXT FROM crAsisteDif INTO @Cantidad, @Fecha, @MovConcepto, @Registro
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @EnMinutos = 0 OR (@Registro NOT IN ('ENTRADA', 'SALIDA')) OR ((@Registro = 'ENTRADA' AND @Cantidad > @CfgToleraEntrada) OR (@Registro = 'SALIDA' AND @Cantidad > @CfgToleraSalida))
      BEGIN
        IF @DiaSemana = 0 OR (@ExcluirDia = 0 AND DATEPART(dw, @Fecha) = @DiaSemana) OR (@ExcluirDia = 1 AND DATEPART(dw, @Fecha) <> @DiaSemana)
        BEGIN
          SELECT @Cont = 0

          IF @ParaNomina = 1
          BEGIN 
            SELECT @ConSueldo = 0
            SELECT @ConSueldo = ISNULL(ConSueldo, 0) FROM Concepto WHERE Modulo = 'ASIS' AND Concepto = @MovConcepto
            IF @DiasSinSueldo = 1 BEGIN IF @ConSueldo = 0 SELECT @Cont = 1 END ELSE
            IF @Comando = 'DIAS AUSENCIA'      SELECT @Cont = 1
            IF @Comando = 'MINUTOS ASISTENCIA' SELECT @Cont = 1
            IF @Comando = 'MINUTOS AUSENCIA' AND @ConSueldo = 0 SELECT @Cont = 1 ELSE
            IF @Comando = 'MINUTOS EXTRAS'   AND @ConSueldo = 1 SELECT @Cont = 1
          END ELSE
          BEGIN
            IF @MovConcepto = @Concepto SELECT @Cont = 1
	  END          

          IF @Cont = 1 
          BEGIN
            IF @Retardos = 1 
              SELECT @Suma = @Suma + 1 
            ELSE SELECT @Suma = @Suma + @Cantidad
          END
        END
      END
    END
    FETCH NEXT FROM crAsisteDif INTO @Cantidad, @Fecha, @MovConcepto, @Registro
  END  -- While
  CLOSE crAsisteDif 
  DEALLOCATE crAsisteDif 

  SELECT "Cantidad" = @Suma
  RETURN
END

-- spVerAsisteCorte 'DEMO', 'CJ', NULL, '26/11/02', '26/11/02', 'MINUTOS ASISTENCIA', 0, 1, 1

GO
PRINT "******************* SP PROCESAR ASISTE ******************"
