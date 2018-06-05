/* SP RH   */

-- RH.C  Candidatos
-- RH.A  Altas
-- RH.M  Modificaciones
-- RH.E  Evaluacion
-- RH.B  Bajas

SET NOCOUNT ON

/**************** spRHVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRHVerificar') and type = 'P') drop procedure dbo.spRHVerificar
GO
CREATE PROCEDURE spRHVerificar
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
		    @Evaluacion			varchar(50),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @CfgControlPlazas		varchar(20),
		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @GenerarPoliza		bit,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Personal		char(10),
    @PersonalEstatus	char(15),
    @PersonalMoneda	char(10),
    @PersonalCategoria	varchar(50),
    @PersonalEmpresa	varchar(5),
    @SueldoDiario	money,
    @SDI		money,
    @SueldoMaximo	money,
    @SueldoMinimo	money,
    @SucursalD		int,

    @Plaza		varchar(20),
    @Puesto		varchar(50),
    @Departamento	varchar(50),
    @CentroCostos	char(20),
    @PlazaPersonal	char(10),
    @PlazaPuesto	varchar(50),
    @PlazaDepartamento	varchar(50),
    @PlazaEmpresa	char(5),
    @PlazaSucursal	int,
    @PlazaEstatus	char(15),
    @PlazaAPartirDe	datetime,
    @PlazaCentroCostos	char(20),
    @FechaAlta		datetime,
    @FechaAntiguedad	datetime,
    @Tipo		varchar(20),
    @VigenciaD		datetime,
    @VigenciaA		datetime,

    @IDOrigen		int,
    @OrigenTipo		char(10),
    @Origen		varchar(20),
    @OrigenID		varchar(20),
    @OrigenMovTipo	varchar(20),
    @CfgValidarAF	varchar(20),
    @SubClae		VARCHAR(10)
    
    
    SELECT @SubClae = SubClave FROM MovTipo
    WHERE Modulo = 'RH' AND Mov = @Mov
    
  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END 
  ELSE BEGIN
    -- Valida que al Afectar un Alta que aplique a una Solitud Alta correspondan las plazas.
/*
    IF @CfgControlPlazas = 'AVANZADO' AND @MovTipo in ('RH.A', 'RH.M')
    BEGIN
      SELECT @Origen = NULLIF(RTRIM(Origen), ''), @OrigenID = NULLIF(RTRIM(OrigenID), '') FROM RH WHERE ID = @ID

      SELECT @IDOrigen = NULL 
      SELECT @IDOrigen = ID FROM RH WHERE Mov = @Origen AND MovID = @OrigenID AND Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      SELECT @OrigenMovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Origen

      
      IF @OrigenMovTipo in ('RH.SA', 'RH.SM')
      BEGIN

        DECLARE crMatarPlaza CURSOR FOR
        SELECT Personal, Plaza
          FROM RHD
         WHERE ID = @IDOrigen

        OPEN crMatarPlaza
        FETCH NEXT FROM crMatarPlaza INTO @Personal, @Plaza
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
          IF NOT EXISTS(SELECT * FROM RHD WHERE ID = @ID AND Personal = @Personal AND Plaza = @Plaza)
            SELECT @Ok = 20180, @OkRef = ' Persona ' + RTRIM(@Personal)

          FETCH NEXT FROM crMatarPlaza INTO @Personal, @Plaza
        END

        CLOSE crMatarPlaza
        DEALLOCATE crMatarPlaza

      END

    END
*/
    SELECT @CfgValidarAF = UPPER(RHValidarAF)
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

    DECLARE crRHVerificar CURSOR
       FOR SELECT NULLIF(RTRIM(d.Personal), ''), p.Empresa, RTRIM(p.Estatus), RTRIM(p.Moneda), NULLIF(RTRIM(d.Categoria), ''), ISNULL(d.SueldoDiario, 0.0), ISNULL(d.SDI, 0.0), ISNULL(c.SueldoMinimo, 0.0), ISNULL(c.SueldoMaximo, 0.0), d.FechaAlta, d.FechaAntiguedad, d.SucursalTrabajo, NULLIF(RTRIM(d.Plaza), ''), NULLIF(RTRIM(d.Puesto), ''), NULLIF(RTRIM(d.Departamento), ''), NULLIF(RTRIM(d.CentroCostos), '')
             FROM RHD d
             JOIN Personal p ON d.Personal = p.Personal
             LEFT OUTER JOIN PersonalCat c ON d.Categoria = c.Categoria
            WHERE ID = @ID 

    OPEN crRHVerificar
    FETCH NEXT FROM crRHVerificar INTO @Personal, @PersonalEmpresa, @PersonalEstatus, @PersonalMoneda, @PersonalCategoria, @SueldoDiario, @SDI, @SueldoMinimo, @SueldoMaximo, @FechaAlta, @FechaAntiguedad, @SucursalD, @Plaza, @Puesto, @Departamento, @CentroCostos
    IF @@ERROR <> 0 SELECT @Ok = 1
    IF @@FETCH_STATUS = -1 SELECT @Ok = 60010

    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @MovTipo <> 'RH.A' AND @Empresa <> @PersonalEmpresa SELECT @Ok = 45050 ELSE
        IF @MovTipo = 'RH.C'  AND @PersonalEstatus NOT IN ('ASPIRANTE', 'BAJA') SELECT @Ok = 55010 ELSE
        IF @MovTipo IN ('RH.SA', 'RH.A') AND @PersonalEstatus NOT IN ('ASPIRANTE', 'CANDIDATO', 'BAJA') SELECT @Ok = 55010 ELSE
        IF @MovTipo IN ('RH.SM', 'RH.M', 'RH.SINC', 'RH.INC') AND @PersonalEstatus <> 'ALTA' SELECT @Ok = 55020 ELSE
        IF @MovTipo IN ('RH.SM', 'RH.M') AND @PersonalMoneda <> @MovMoneda           SELECT @Ok = 55030 ELSE
        IF @MovTipo IN ('RH.SB', 'RH.B') AND @PersonalEstatus <> 'ALTA' /** ='BAJA'**/ SELECT @Ok = 55020 ELSE
        IF @MovTipo IN ('RH.A', 'RH.M') 
        BEGIN
          IF (@SueldoDiario = 0.0 AND @SDI = 0.0) OR (@SueldoDiario < 0.0 OR @SDI < 0.0) SELECT @Ok = 55040 ELSE
          IF @PersonalCategoria IS NOT NULL 
            IF @SueldoDiario < @SueldoMinimo SELECT @Ok = 55310 ELSE
            IF @SueldoDiario > @SueldoMaximo SELECT @Ok = 55320
        END
        IF @MovTipo = 'RH.B' AND @CfgValidarAF = 'BAJA'
          IF EXISTS(SELECT * FROM ActivoF WHERE Empresa = @Empresa AND Responsable = @Personal)
            SELECT @Ok = 44160

        IF @Ok = 55020
          EXEC xpOk_55020 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT

        IF @Ok IS NOT NULL AND @OkRef IS NULL 
          SELECT @OkRef = 'Persona: '+RTRIM(@Personal)

        -- Validaciones si Control Plazas = 'Avanzado'
        IF @CfgControlPlazas = 'AVANZADO' AND @MovTipo in ('RH.A', 'RH.M', 'RH.SA', 'RH.SM', 'RH.C') AND @OK is null
        BEGIN
          SELECT @PlazaEmpresa = Empresa, @PlazaSucursal = Sucursal, @PlazaEstatus = Estatus, @Tipo = ISNULL(Tipo, 'Definitiva'), 
                 @VigenciaD = VigenciaD, @VigenciaA = VigenciaA, @PlazaAPartirDe = APartirDe,
                 @PlazaPersonal = NULLIF(RTRIM(Personal), ''), @PlazaPuesto = NULLIF(RTRIM(Puesto), ''), @PlazaDepartamento = NULLIF(RTRIM(Departamento), ''),
		 @PlazaCentroCostos = NULLIF(RTRIM(CentroCostos), '')
            FROM Plaza WHERE Plaza = @Plaza
		
			IF @SubClae NOT IN ('RH.BRP', 'RH.ARP')
			BEGIN
			  IF @Plaza is null
				SELECT @Ok = 55400
			  ELSE
			  IF @PlazaPersonal is not null AND @PlazaPersonal <> @Personal
				SELECT @Ok = 55410, @OkRef = @Personal
	/*          ELSE
			  IF @MovTipo = 'RH.A' AND @PlazaPersonal IS NOT NULL AND (SELECT Estatus FROM Personal WHERE Personal = @PlazaPersonal) = 'ALTA' 
				SELECT @Ok = 55413, @OkRef = @PlazaPersonal*/
			  ELSE
			  IF @PlazaEmpresa <> @Empresa
				SELECT @Ok = 10060, @OkRef = 'La Empresa de la Plaza no corresponde. Personal ' + RTRIM(@Personal)
			  ELSE
			  IF @PlazaSucursal <> @SucursalD
				SELECT @Ok = 10060, @OkRef = 'La Sucursal de la Plaza no corresponde. Personal ' + RTRIM(@Personal)
			  ELSE
			  IF @PlazaEstatus <> 'ALTA'
				SELECT @Ok = 10060, @OkRef = 'El Estatus de la Plaza ' + RTRIM(@Plaza) + ' es ' + RTRIM(@PlazaEstatus)
			  ELSE
			  IF @Tipo = 'Temporal' AND (@FechaAntiguedad > @VigenciaA OR @FechaAntiguedad < @VigenciaD)
				SELECT @Ok = 10060, @OkRef = 'Las Vigencias de la Plaza ' + RTRIM(@Plaza) + ' no corresponde a la Fecha Alta'
			  ELSE
			  IF /*@MovTipo = 'RH.A' AND */@PlazaAPartirDe is not null AND @FechaAntiguedad < @PlazaAPartirDe
				SELECT @Ok = 10060, @OkRef = 'La Antiguedad indicada es anterior a la fecha de Activación de La Plaza ' + RTRIM(@Plaza)
			  ELSE
			  IF @PlazaPuesto <> @Puesto OR @PlazaDepartamento <> @Departamento
				SELECT @OK = 55420, @OkRef = @Personal
			  ELSE
			  IF @PlazaCentroCostos <> @CentroCostos
				SELECT @Ok = 10060, @OkRef = 'El Centro de Costos de la Plaza no corresponde con el indicado. Plaza ' + RTRIM(@Plaza)
			END
        
		END

      END
      FETCH NEXT FROM crRHVerificar INTO @Personal, @PersonalEmpresa, @PersonalEstatus, @PersonalMoneda, @PersonalCategoria, @SueldoDiario, @SDI, @SueldoMinimo, @SueldoMaximo, @FechaAlta, @FechaAntiguedad, @SucursalD, @Plaza, @Puesto, @Departamento, @CentroCostos
      IF @@ERROR <> 0 SELECT @Ok = 1
    END  -- While
    CLOSE crRHVerificar
    DEALLOCATE crRHVerificar
  END
  IF @Ok IS NULL AND @MovTipo = 'RH.E' AND @Evaluacion IS NULL SELECT @Ok = 55360

  IF @Ok IS NULL
    EXEC xpRHVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                       @FechaEmision, @Estatus, @Evaluacion,
 		       @Conexion, @SincroFinal, @Sucursal, 
		       @CfgControlPlazas, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
		       @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO

/**************** spRHValoresAnteriores ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRHValoresAnteriores') and type = 'P') drop procedure dbo.spRHValoresAnteriores
GO             
CREATE PROCEDURE spRHValoresAnteriores
    		        @ID             	int,
			@Personal		char(10),

			@SueldoDiario			money		OUTPUT,
			@SueldoDiarioComplemento	money		OUTPUT,
    			@SDI 				money		OUTPUT,
    			@TipoContrato			varchar(50)	OUTPUT,
			@VencimientoContrato		datetime	OUTPUT,
    			@PeriodoTipo			varchar(20)	OUTPUT,
    			@Jornada			varchar(50)	OUTPUT,
    			@TipoSueldo			varchar(10)	OUTPUT,
		        @Plaza				varchar(20)	OUTPUT,
    			@Puesto				varchar(50)	OUTPUT,
    			@Departamento			varchar(50)	OUTPUT,
    			@Categoria			varchar(50)	OUTPUT,
    			@Grupo				varchar(50)	OUTPUT,
    			@ReportaA			varchar(10)	OUTPUT,
    			@CentroCostos			varchar(20)	OUTPUT,
			@SucursalTrabajo		int		OUTPUT,
			@FechaAlta			datetime	OUTPUT,
			@FechaAntiguedad		datetime	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @SueldoDiario	  	  = NULL,
         @SueldoDiarioComplemento = NULL,
         @SDI  		  	  = NULL,
    	 @TipoContrato        	  = NULL,
         @VencimientoContrato 	  = NULL,
    	 @PeriodoTipo     	  = NULL,
    	 @Jornada	  	  = NULL,
    	 @TipoSueldo	  	  = NULL,
         @Plaza			  = NULL,
    	 @Puesto	  	  = NULL,
    	 @Departamento    	  = NULL,
    	 @Categoria	  	  = NULL,
    	 @Grupo   	  	  = NULL,
	 @ReportaA		  = NULL,
         @CentroCostos		  = NULL,
         @SucursalTrabajo 	  = 0,
         @FechaAlta	  	  = NULL,
         @FechaAntiguedad 	  = NULL

  DECLARE crRHAnterior CURSOR
      FOR SELECT ISNULL(d.SueldoDiario, 0.0), ISNULL(d.SueldoDiarioComplemento, 0.0), ISNULL(d.SDI, 0.0), 
                 NULLIF(RTRIM(d.TipoContrato), ''), d.VencimientoContrato, NULLIF(RTRIM(d.PeriodoTipo), ''), NULLIF(RTRIM(d.Jornada), ''), NULLIF(RTRIM(d.TipoSueldo), ''), NULLIF(RTRIM(d.Plaza), ''), 
                 NULLIF(RTRIM(d.Puesto), ''), NULLIF(RTRIM(d.Departamento), ''), NULLIF(RTRIM(d.Categoria), ''), NULLIF(RTRIM(d.Grupo), ''),  NULLIF(RTRIM(d.ReportaA), ''),  NULLIF(RTRIM(d.CentroCostos), ''),  d.SucursalTrabajo,
                 d.FechaAlta, d.FechaAntiguedad
           FROM RH, MovTipo, RHD d
          WHERE RH.Mov = MovTipo.Mov
            AND RH.ID = d.ID
            AND RH.ID < @ID
            AND RH.Estatus   = 'CONCLUIDO'
            AND MovTipo.Modulo = 'RH'
            AND MovTipo.Clave IN ('RH.A', 'RH.M')
            AND d.Personal = @Personal
          ORDER BY FechaRegistro DESC

  OPEN crRHAnterior
  FETCH NEXT FROM crRHAnterior INTO @SueldoDiario, @SueldoDiarioComplemento, @SDI, @TipoContrato, @VencimientoContrato, @PeriodoTipo, @Jornada, @TipoSueldo, @Plaza, @Puesto, @Departamento, @Categoria, @Grupo, @ReportaA, @CentroCostos, @SucursalTrabajo, @FechaAlta, @FechaAntiguedad
  CLOSE crRHAnterior
  DEALLOCATE crRHAnterior

  RETURN
END
GO

/**************** spRHControlPlazas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRHControlPlazas') and type = 'P') drop procedure dbo.spRHControlPlazas
GO             
CREATE PROCEDURE spRHControlPlazas
		   @Accion	 	char(20),
                   @CfgControlPlazas	varchar(20),
    		   @Empresa	 	char(5),
		   @SucursalTrabajo	int,
		   @MovTipo	 	char(20),
		   @FechaAlta		datetime,
		   @Personal	 	char(10),
	           @Plaza		varchar(20),
    		   @Puesto	 	varchar(50),
    		   @Departamento 	varchar(50),
    		   @SubClave		varchar(20),

       		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cantidad		  	int,
    @Plazas		  	int,
    @EnUso		  	int,
    @PersonalPuesto	  	varchar(50),
    @PersonalDepartamento 	varchar(50),
    @PersonalSucursalTrabajo	int,
    @PlazaPuesto	  	varchar(50),
    @PlazaDepartamento 		varchar(50),
    @PlazaPersonal		varchar(10),
    @PlazaActual		varchar(20)

  IF @CfgControlPlazas = 'SIMPLE'
  BEGIN
    IF @Accion <> 'CANCELAR' SELECT @Cantidad = 1 ELSE SELECT @Cantidad = -1
    SELECT @PersonalPuesto = NULLIF(RTRIM(Puesto), ''), @PersonalDepartamento = NULLIF(RTRIM(Departamento), ''), @PersonalSucursalTrabajo = SucursalTrabajo
      FROM Personal 
     WHERE Personal = @Personal

    IF @MovTipo <> 'RH.A' AND @PersonalPuesto IS NOT NULL AND @PersonalDepartamento IS NOT NULL
    BEGIN
      UPDATE RHPlaza 
         SET @Plazas = Plazas, @EnUso = EnUso = NULLIF(ISNULL(EnUso, 0) - @Cantidad, 0)
       WHERE Empresa = @Empresa AND Sucursal = @PersonalSucursalTrabajo AND Puesto = @PersonalPuesto AND Departamento = @PersonalDepartamento
      IF @@ROWCOUNT = 0 SELECT @Ok = 55350 ELSE
      IF @Plazas < @EnUso SELECT @Ok = 55340
    END
    IF @MovTipo <> 'RH.B' AND @Puesto IS NOT NULL AND @Departamento IS NOT NULL AND @Ok IS NULL 
    BEGIN
      UPDATE RHPlaza 
         SET @Plazas = Plazas, @EnUso = EnUso = NULLIF(ISNULL(EnUso, 0) + @Cantidad, 0)
       WHERE Empresa = @Empresa AND Sucursal = @SucursalTrabajo AND Puesto = @Puesto AND Departamento = @Departamento
      IF @@ROWCOUNT = 0 SELECT @Ok = 55350 ELSE
      IF @Plazas < @EnUso SELECT @Ok = 55340
    END
  END ELSE
  IF @CfgControlPlazas = 'AVANZADO'
  BEGIN
    IF @MovTipo = 'RH.A' AND @Accion = 'CANCELAR'
      SELECT @Plaza = Plaza FROM Personal WHERE Personal = @Personal
    IF @MovTipo = 'RH.M' AND @Accion = 'CANCELAR'
      SELECT @PlazaActual = Plaza FROM Personal WHERE Personal = @Personal

    IF NULLIF(RTRIM(@Plaza), '') IS NULL 
      SELECT @Ok = 55400
    ELSE BEGIN
      SELECT @PlazaPersonal = NULLIF(RTRIM(Personal), '') FROM Plaza WHERE Plaza = @Plaza
      IF @Accion = 'CANCELAR' 
      BEGIN
        IF @PlazaPersonal is not null AND @PlazaPersonal <> @Personal
          SELECT @Ok = 55410, @OkRef = @PlazaPersonal
        ELSE
        BEGIN
          IF @MovTipo = 'RH.A'
          BEGIN
            UPDATE Plaza SET Personal = NULL WHERE Plaza = @Plaza
	    UPDATE Personal SET Plaza = NULL WHERE Personal = @Personal
          END
          IF @MovTipo = 'RH.M'
          BEGIN
	    UPDATE Plaza SET Personal = @Personal WHERE Plaza = @Plaza
            UPDATE Plaza SET Personal = NULL WHERE Plaza = @PlazaActual
            UPDATE Personal SET Plaza = @Plaza WHERE Personal = @Personal
          END
          IF @MovTipo = 'RH.B' 
          BEGIN
            UPDATE Plaza SET Personal = @Personal WHERE Plaza = @Plaza
            UPDATE Personal SET Plaza = @Plaza WHERE Personal = @Personal
          END

        END
      END ELSE
      BEGIN
/*
        IF @MovTipo in ('RH.A', 'RH.M', 'RH.B')
        BEGIN
          SELECT @PlazaEmpresa = Empresa, @PlazaSucursal = Sucursal, @PlazaEstatus = Estatus, @Tipo = ISNULL(Tipo, 'Definitiva'), @VigenciaD = VigenciaD, @VigenciaA = VigenciaA
            FROM Plaza WHERE Plaza = @Plaza
          IF @PlazaEmpresa <> @Empresa
            SELECT @Ok = 10060, @OkRef = 'La Empresa de la Plaza no corresponde. Personal ' + RTRIM(@Personal)
          ELSE
          IF @PlazaSucursal <> @SucursalTrabajo
            SELECT @Ok = 10060, @OkRef = 'La Sucursal de la Plaza no corresponde. Personal ' + RTRIM(@Personal)
          ELSE
          IF @PlazaEstatus <> 'ALTA'
            SELECT @Ok = 10060, @OkRef = 'El Estatus de la Plaza ' + RTRIM(@Plaza) + ' es ' + RTRIM(@PlazaEstatus)
          ELSE
          IF @Tipo = 'Temporal' AND (@FechaAlta > @VigenciaA OR @FechaAlta < @VigenciaD)
            SELECT @Ok = 10060, @OkRef = 'Las Vigencias de la Plaza ' + RTRIM(@Plaza) + ' no corresponde a la Fecha Alta'
        END
*/
        IF @MovTipo = 'RH.B' AND @SubClave <> 'RH.BRP' --AND @Ok is null
        BEGIN
          UPDATE Plaza SET Personal = NULL WHERE Plaza = @Plaza
          UPDATE Personal SET Plaza = NULL WHERE Personal = @Personal
        END

        IF @PlazaPersonal <> @Personal --AND @ok is null
        BEGIN
/*
          IF @MovTipo = 'RH.A'
          BEGIN
            SELECT @PlazaPuesto = NULLIF(RTRIM(Puesto), ''), @PlazaDepartamento = NULLIF(RTRIM(Departamento), '')
              FROM Plaza
	     WHERE Plaza = @Plaza

            IF @PlazaPuesto <> @Puesto OR @PlazaDepartamento <> @Departamento
              SELECT @OK = 55420, @OkRef = @PlazaPersonal
          END

          IF @PlazaPersonal IS NOT NULL AND (SELECT Estatus FROM Personal WHERE Personal = @PlazaPersonal) = 'ALTA' 
            SELECT @Ok = 55410, @OkRef = @PlazaPersonal
          ELSE*/
--          BEGIN
            IF @MovTipo = 'RH.A'
            BEGIN
              UPDATE Plaza SET Personal = @Personal, TieneMovimientos = 1 WHERE Plaza = @Plaza
              UPDATE Personal SET Plaza = @Plaza WHERE Personal = @Personal
            END

            IF @MovTipo = 'RH.M' AND @Plaza <> (SELECT Plaza FROM Personal WHERE Personal = @Personal)
            BEGIN
	      UPDATE Plaza SET Personal = NULL WHERE Personal = @Personal
              UPDATE Plaza SET Personal = @Personal, TieneMovimientos = 1 WHERE Plaza = @Plaza
	      UPDATE Personal SET Plaza = @Plaza WHERE Personal = @Personal
            END
--        END
        END
      END
    END
  END

  IF @Ok IS NOT NULL AND @OkRef IS NULL 
    SELECT @OkRef = 'Persona: '+RTRIM(@Personal)
  RETURN
END
GO

/**************** spRHAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRHAfectar') and type = 'P') drop procedure dbo.spRHAfectar
GO             
CREATE PROCEDURE spRHAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20) OUTPUT,
    		   @MovTipo     		char(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
    		   @FechaConclusion		datetime,

    	 	   @Proyecto	      		varchar(50),
                   @Concepto			varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @CfgControlPlazas		varchar(20),
		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

    		   @GenerarMov			char(20),
		   @IDGenerar			int	     OUTPUT,	
    		   @GenerarMovID	  	varchar(20)  OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Personal			char(10),

    @SueldoDiario		money,
    @SueldoDiarioComplemento	money,
    @SDI			money,
    @TipoContrato		varchar(50),
    @VencimientoContrato	datetime,
    @PeriodoTipo		varchar(20),
    @Jornada			varchar(50),
    @TipoSueldo			varchar(10),
    @Plaza			varchar(20),
    @Puesto			varchar(50),
    @Departamento		varchar(50),
    @Categoria			varchar(50),
    @Grupo			varchar(50),
    @ReportaA			varchar(10),
    @CentroCostos		varchar(20),
    @SucursalTrabajo		int,
    @FechaAlta			datetime,
    @FechaAntiguedad		datetime,

    @Generar			bit,
    @GenerarAfectado		bit,
    @GenerarModulo		char(5),
    @GenerarMovTipo		char(20),
    @GenerarEstatus		char(15),
    @GenerarPeriodo 		int, 
    @GenerarEjercicio 		int,
    @FechaCancelacion		datetime,
    @GenerarAccion		char(20),	
    @RedondeoMonetarios		int,
    @Incremento			float,
    @IDOrigen			int,
    @OrigenTipo			char(10),
    @Origen			varchar(20),
    @OrigenID			varchar(20),
    @OrigenMovTipo		varchar(20),
    @Fecha			DATETIME,
    @SubClave		varchar(20)

  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  -- Inicializar Variables
  SELECT @Generar 		= 0,
         @GenerarAfectado	= 0,
         @IDGenerar		= NULL,
         @GenerarModulo		= NULL,
         @GenerarMovID	        = NULL,
         @GenerarMovTipo        = NULL,
         @GenerarEstatus 	= 'SINAFECTAR'


	--Obtener la subclave del movimiento
	SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = 'RH'
	
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

    IF @MovTipo = 'RH.INC'
    BEGIN
      INSERT RHD (
             ID,         Renglon,   Sucursal,  SucursalOrigen, Personal,   Incremento,   SueldoDiario,   SueldoDiarioComplemento,   SDI,   TipoContrato,   PeriodoTipo,   Jornada,   TipoSueldo,   Categoria,   Departamento,   Puesto,   Grupo,   FechaAlta,   FechaAntiguedad,   SucursalTrabajo,   ReportaA,   CentroCostos,   VencimientoContrato, Plaza)
      SELECT @IDGenerar, d.Renglon, @Sucursal, @Sucursal,      p.Personal, d.Incremento, p.SueldoDiario, p.SueldoDiarioComplemento, p.SDI, p.TipoContrato, p.PeriodoTipo, p.Jornada, p.TipoSueldo, p.Categoria, p.Departamento, p.Puesto, p.Grupo, p.FechaAlta, p.FechaAntiguedad, p.SucursalTrabajo, p.ReportaA, p.CentroCostos, p.VencimientoContrato, d.Plaza
        FROM RHD d, Personal p
       WHERE d.ID = @ID AND p.Personal = d.Personal

      EXEC spRHModificarEnLote @Empresa, @IDGenerar, NULL, NULL, 'NO', @UsarIncremento = 1
    END ELSE
      INSERT RHD (
             ID,         Renglon, Sucursal,  SucursalOrigen, Personal, Incremento, SueldoDiario, SueldoDiarioComplemento, SDI, TipoContrato, PeriodoTipo, Jornada, TipoSueldo, Categoria, Departamento, Puesto, Grupo, FechaAlta, FechaAntiguedad, SucursalTrabajo, ReportaA, CentroCostos, VencimientoContrato, Plaza)
      SELECT @IDGenerar, Renglon, @Sucursal, @Sucursal,      Personal, Incremento, SueldoDiario, SueldoDiarioComplemento, SDI, TipoContrato, PeriodoTipo, Jornada, TipoSueldo, Categoria, Departamento, Puesto, Grupo, FechaAlta, FechaAntiguedad, SucursalTrabajo, ReportaA, CentroCostos, VencimientoContrato, Plaza
        FROM RHD
       WHERE ID = @ID
 
    IF @Ok IS NULL SELECT @Ok = 80030
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Actualizar Sucursal Detalle
    IF @Accion = 'AFECTAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR')
      IF (SELECT Sincro FROM Version) = 1
        EXEC sp_executesql N'UPDATE RHD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
        
    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    DECLARE crRH CURSOR
       FOR SELECT NULLIF(RTRIM(Personal), ''), SueldoDiario, SueldoDiarioComplemento, SDI, 
                  NULLIF(RTRIM(TipoContrato), ''), VencimientoContrato, NULLIF(RTRIM(PeriodoTipo), ''), NULLIF(RTRIM(Jornada), ''), NULLIF(RTRIM(TipoSueldo), ''), NULLIF(RTRIM(Plaza), ''), 
                  NULLIF(RTRIM(Puesto), ''), NULLIF(RTRIM(Departamento), ''), NULLIF(RTRIM(Categoria), ''), NULLIF(RTRIM(Grupo), ''), NULLIF(RTRIM(ReportaA), ''), NULLIF(RTRIM(CentroCostos), ''), SucursalTrabajo,
                  FechaAlta, FechaAntiguedad, Incremento
             FROM RHD
            WHERE ID = @ID     

    OPEN crRH
    FETCH NEXT FROM crRH INTO @Personal, @SueldoDiario, @SueldoDiarioComplemento, @SDI, @TipoContrato, @VencimientoContrato, @PeriodoTipo, @Jornada, @TipoSueldo, @Plaza, @Puesto, @Departamento, @Categoria, @Grupo, @ReportaA, @CentroCostos, @SucursalTrabajo, @FechaAlta, @FechaAntiguedad, @Incremento
    IF @@ERROR <> 0 SELECT @Ok = 1
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @MovTipo = 'RH.INC'
          UPDATE Personal 
             SET Incremento = CASE WHEN @Accion <> 'CANCELAR' THEN @Incremento ELSE NULL END
           WHERE Personal = @Personal

        IF @MovTipo IN ('RH.C', 'RH.A', 'RH.M', 'RH.B')
        BEGIN
          IF @Accion <> 'CANCELAR'
          BEGIN
          	
            IF @CfgControlPlazas <> 'NO' AND @MovTipo IN ('RH.A', 'RH.M', 'RH.B') AND @SubClave NOT IN ('RH.BRP', 'RH.ARP')
              EXEC spRHControlPlazas @Accion, @CfgControlPlazas, @Empresa, @SucursalTrabajo, @MovTipo, @FechaAlta, @Personal, @Plaza, @Puesto, @Departamento, @SubClave, @Ok OUTPUT, @OkRef OUTPUT

            IF @MovTipo = 'RH.C'
              UPDATE Personal
                 SET SueldoDiario = ROUND(NULLIF(@SueldoDiario, 0.0), @RedondeoMonetarios), 
                     SueldoDiarioComplemento = ROUND(NULLIF(@SueldoDiarioComplemento, 0.0), @RedondeoMonetarios), 
                     SDI = ROUND(NULLIF(@SDI, 0.0), 4), 
                     TipoContrato = @TipoContrato, VencimientoContrato = @VencimientoContrato, PeriodoTipo = @PeriodoTipo, Jornada = @Jornada, TipoSueldo = @TipoSueldo, 
                     Plaza = @Plaza, Puesto = @Puesto, Departamento = @Departamento, Categoria = @Categoria, Grupo = @Grupo, ReportaA = @ReportaA, CentroCostos = @CentroCostos, SucursalTrabajo = @SucursalTrabajo,
		     Estatus = 'CANDIDATO', Moneda = @MovMoneda, FechaAlta = @FechaEmision, UltimaModificacion = NULL, FechaBaja = NULL, TieneMovimientos = 1
               WHERE Personal = @Personal
            ELSE
            IF @MovTipo = 'RH.A' 
              UPDATE Personal
                 SET SueldoDiario = ROUND(NULLIF(@SueldoDiario, 0.0), @RedondeoMonetarios), 
                     SueldoDiarioComplemento = ROUND(NULLIF(@SueldoDiarioComplemento, 0.0), @RedondeoMonetarios), 
                     SDI = ROUND(NULLIF(@SDI, 0.0), @RedondeoMonetarios), 
                     TipoContrato = @TipoContrato, VencimientoContrato = @VencimientoContrato, PeriodoTipo = @PeriodoTipo, Jornada = @Jornada, TipoSueldo = @TipoSueldo, 
                     Plaza = @Plaza, Puesto = @Puesto, Departamento = @Departamento, Categoria = @Categoria, Grupo = @Grupo, ReportaA = @ReportaA, CentroCostos = @CentroCostos, SucursalTrabajo = @SucursalTrabajo,
		     Estatus = 'ALTA', Moneda = @MovMoneda, FechaAlta = @FechaAlta, FechaAntiguedad = @FechaAntiguedad, UltimaModificacion = NULL, FechaBaja = NULL, TieneMovimientos = 1, Empresa = @Empresa
               WHERE Personal = @Personal             
            ELSE
            IF @MovTipo = 'RH.M'
              UPDATE Personal
                 SET /*SueldoDiario = ROUND(ISNULL(@SueldoDiario, SueldoDiario), @RedondeoMonetarios), 
                     SueldoDiarioComplemento = ROUND(ISNULL(@SueldoDiarioComplemento, SueldoDiarioComplemento), @RedondeoMonetarios), */
		     SueldoDiario = ROUND(NULLIF(@SueldoDiario, 0.0), @RedondeoMonetarios), 
                     SueldoDiarioComplemento = ROUND(NULLIF(@SueldoDiarioComplemento, 0.0), @RedondeoMonetarios),                      
                     SDI = ROUND(ISNULL(@SDI, SDI), @RedondeoMonetarios), 
                     TipoContrato = @TipoContrato, VencimientoContrato = @VencimientoContrato, PeriodoTipo = @PeriodoTipo, Jornada = @Jornada, TipoSueldo = @TipoSueldo, 
                     Plaza = @Plaza, Puesto = @Puesto, Departamento = @Departamento, Categoria = @Categoria, Grupo = @Grupo, ReportaA = @ReportaA, CentroCostos = @CentroCostos, SucursalTrabajo = @SucursalTrabajo, 
		     UltimaModificacion = @FechaEmision, TieneMovimientos = 1
               WHERE Personal = @Personal             
            ELSE
            IF @MovTipo = 'RH.B'
			BEGIN
				IF @SubClave = 'RH.BRP'
					UPDATE Personal
					SET FechaBaja = @FechaEmision, ConceptoBaja = @Concepto, TieneMovimientos = 1
					WHERE Personal = @Personal
				ELSE
					UPDATE Personal
					SET Estatus = 'BAJA', FechaBaja = @FechaEmision, ConceptoBaja = @Concepto, TieneMovimientos = 1
					WHERE Personal = @Personal
			END	  
				 
          END ELSE

          -- Cancelaciones
          BEGIN
            IF @MovTipo IN ('RH.C', 'RH.A', 'RH.M')
              EXEC spRHValoresAnteriores @ID, @Personal, @SueldoDiario OUTPUT, @SueldoDiarioComplemento OUTPUT, @SDI OUTPUT, @TipoContrato OUTPUT, @VencimientoContrato OUTPUT, @PeriodoTipo OUTPUT, @Jornada OUTPUT, @TipoSueldo OUTPUT, 
	  			         @Plaza OUTPUT, @Puesto OUTPUT, @Departamento OUTPUT, @Categoria OUTPUT, @Grupo OUTPUT, @ReportaA OUTPUT, @CentroCostos OUTPUT, @SucursalTrabajo OUTPUT, @FechaAlta OUTPUT, @FechaAntiguedad OUTPUT

            IF @CfgControlPlazas <> 'NO' AND @MovTipo IN ('RH.A', 'RH.M', 'RH.B') AND @SubClave NOT IN ('RH.BRP', 'RH.ARP')
              EXEC spRHControlPlazas @Accion, @CfgControlPlazas, @Empresa, @SucursalTrabajo, @MovTipo, @FechaAlta, @Personal, @Plaza, @Puesto, @Departamento, @SubClave, @Ok OUTPUT, @OkRef OUTPUT

            IF @MovTipo = 'RH.C'
              UPDATE Personal
                 SET SueldoDiario = ROUND(NULLIF(@SueldoDiario, 0.0), @RedondeoMonetarios), 
                     SueldoDiarioComplemento = ROUND(NULLIF(@SueldoDiarioComplemento, 0.0), @RedondeoMonetarios), 
                     SDI = ROUND(NULLIF(@SDI, 0.0), @RedondeoMonetarios), 
                     TipoContrato = @TipoContrato, VencimientoContrato = @VencimientoContrato, PeriodoTipo = @PeriodoTipo, Jornada = @Jornada, TipoSueldo = @TipoSueldo,
                     /*Plaza = @Plaza, */Puesto = @Puesto, Departamento = @Departamento, Categoria = @Categoria, Grupo = @Grupo, ReportaA = @ReportaA, CentroCostos = @CentroCostos, SucursalTrabajo = @SucursalTrabajo,
  	             Estatus = 'ASPIRANTE', FechaAlta = NULL
               WHERE Personal = @Personal
            ELSE
            IF @MovTipo = 'RH.A'
            BEGIN
              /*IF EXISTS(SELECT * FROM Nomina n JOIN NominaD d ON d.ID = n.ID AND d.Personal = @Personal WHERE n.Empresa = @Empresa AND n.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'VIGENTE'))
                SELECT @Ok = 30151, @OkRef = @Personal*/
              SELECT @Fecha = MAX(FechaEmision) FROM RH r, RHD d
                                             WHERE d.ID = r.ID 
                                               AND d.Personal=@Personal 
                                               AND r.Estatus='CONCLUIDO' 
                                               AND r.ID <> @ID
              UPDATE Personal
                 SET SueldoDiario = ROUND(NULLIF(@SueldoDiario, 0.0), @RedondeoMonetarios),
                     SueldoDiarioComplemento = ROUND(NULLIF(@SueldoDiarioComplemento, 0.0), @RedondeoMonetarios),
                     SDI = ROUND(NULLIF(@SDI, 0.0), @RedondeoMonetarios),
                     TipoContrato = @TipoContrato, VencimientoContrato = @VencimientoContrato, PeriodoTipo = @PeriodoTipo, Jornada = @Jornada, TipoSueldo = @TipoSueldo,
                            /*Plaza = @Plaza, */Puesto = @Puesto, Departamento = @Departamento, Categoria = @Categoria, Grupo = @Grupo, ReportaA = @ReportaA, CentroCostos = @CentroCostos, SucursalTrabajo = @SucursalTrabajo,
                          Estatus = CASE WHEN EXISTS( SELECT * 
                                                        FROM RH r, RHD d, MovTipo m    
                                                       WHERE d.ID           = r.ID 
                                                         AND m.Clave        ='RH.B'  
                                                         AND m.Mov          = r.Mov  
                                                         AND d.Personal     = @Personal 
                                                         AND r.FechaEmision = @Fecha
                                                         AND r.Estatus      = 'CONCLUIDO') 
                                         THEN 'BAJA' 
                                         ELSE 'ASPIRANTE' 
                                    END, 
                        FechaAlta = NULL
               WHERE Personal = @Personal
            END ELSE
            IF @MovTipo = 'RH.M'
              UPDATE Personal
                 SET SueldoDiario = ROUND(NULLIF(@SueldoDiario, 0.0), @RedondeoMonetarios), 
                     SueldoDiarioComplemento = ROUND(NULLIF(@SueldoDiarioComplemento, 0.0), @RedondeoMonetarios), 
                     SDI = ROUND(NULLIF(@SDI, 0.0), @RedondeoMonetarios), 
                     TipoContrato = @TipoContrato, VencimientoContrato = @VencimientoContrato, PeriodoTipo = @PeriodoTipo, Jornada = @Jornada, TipoSueldo = @TipoSueldo, 
                     /*Plaza = @Plaza, */Puesto = @Puesto, Departamento = @Departamento, Categoria = @Categoria, Grupo = @Grupo, ReportaA = @ReportaA, CentroCostos = @CentroCostos, SucursalTrabajo = @SucursalTrabajo,
                     UltimaModificacion = NULL
               WHERE Personal = @Personal
            ELSE 
            IF @MovTipo = 'RH.B'
              UPDATE Personal
                 SET FechaBaja = NULL, ConceptoBaja = NULL, Estatus = 'ALTA' 
               WHERE Personal = @Personal
          END
        END
      END
      FETCH NEXT FROM crRH INTO @Personal, @SueldoDiario, @SueldoDiarioComplemento, @SDI, @TipoContrato, @VencimientoContrato, @PeriodoTipo, @Jornada, @TipoSueldo, @Plaza, @Puesto, @Departamento, @Categoria, @Grupo, @ReportaA, @CentroCostos, @SucursalTrabajo, @FechaAlta, @FechaAntiguedad, @Incremento
      IF @@ERROR <> 0 SELECT @Ok = 1
    END  -- While
    CLOSE crRH
    DEALLOCATE crRH
    
    EXEC xpRHAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                     @FechaEmision, @FechaAfectacion, @FechaConclusion,
                     @Proyecto, @Concepto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, 
                     @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
		     @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
		     @CfgControlPlazas, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                     @GenerarMov, @IDGenerar, @GenerarMovID,
                     @Ok OUTPUT, @OkRef OUTPUT

    -- Actualizar Movimiento
    IF @Ok IS NULL
    BEGIN
      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
      BEGIN
	IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
      END  

      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE RH
         SET FechaConclusion  = @FechaConclusion, 
             FechaCancelacion = @FechaCancelacion,
             UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
             Estatus          = @EstatusNuevo,
             Situacion 	      = CASE WHEN @Estatus <> @EstatusNuevo THEN NULL ELSE Situacion END,
             GenerarPoliza    = @GenerarPoliza
       WHERE ID = @ID 
      IF @@ERROR <> 0 SELECT @Ok = 1
    END

    SELECT @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID
      FROM RH 
     WHERE ID = @ID

    IF @OrigenTipo = @Modulo
    BEGIN  
      SELECT @IDOrigen = NULL 
      SELECT @IDOrigen = ID FROM RH WHERE Mov = @Origen AND MovID = @OrigenID AND Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      SELECT @OrigenMovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Origen

      -- Matar Incremento
      IF @OrigenMovTipo IN ('RH.SA', 'RH.SM', 'RH.SB', 'RH.SINC', 'RH.INC') AND @IDOrigen IS NOT NULL 
        UPDATE RH SET Estatus = CASE WHEN @Accion = 'CANCELAR' THEN 'PENDIENTE' ELSE 'CONCLUIDO' END WHERE ID = @IDOrigen

      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @IDOrigen, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT 
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

/**************** spRH ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRH') and type = 'P') drop procedure dbo.spRH
GO
CREATE PROCEDURE spRH
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
    @Concepto		varchar(50),
    @MovUsuario	      	char(10),
    @Autorizacion     	char(10),
    @DocFuente	      	int,
    @Observaciones    	varchar(255),
    @Evaluacion		varchar(50),
    @Estatus          	char(15),
    @EstatusNuevo	char(15),
    @Ejercicio	      	int,
    @Periodo	      	int,
    @GenerarMovID	varchar(20),
    @GenerarPoliza	bit,
    @CfgControlPlazas	varchar(20),
    @CfgContX		bit,
    @CfgContXGenerar	char(20)/*,
    @Verificar		bit*/

  -- Inicializar Variables
  SELECT @CfgControlPlazas= 'NO',
         @CfgContX        = 0,
         @CfgContXGenerar = 'NO'/*,
	 @Verificar	  = 1*/

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = Proyecto,
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, @Concepto = NULLIF(RTRIM(Concepto), ''),
         @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, @Evaluacion = NULLIF(RTRIM(Evaluacion), ''),
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion
    FROM RH
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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'PENDIENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE'))
  BEGIN
    SELECT @CfgControlPlazas = UPPER(RHControlPlazas)
      FROM EmpresaCfg
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

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
      IF @MovTipo IN ('RH.SA', 'RH.SM', 'RH.SB', 'RH.SINC', 'RH.INC')
        SELECT @EstatusNuevo = 'PENDIENTE'
      ELSE
        SELECT @EstatusNuevo = 'CONCLUIDO'
    END

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spRHVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                         @FechaEmision, @Estatus, @Evaluacion,
   		         @Conexion, @SincroFinal, @Sucursal, 
		         @CfgControlPlazas, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
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
      EXEC spRHAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, 
                       @FechaEmision, @FechaAfectacion, @FechaConclusion,
		       @Proyecto, @Concepto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, 
                       @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
		       @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
		       @CfgControlPlazas, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                       @GenerarMov, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                       @Ok OUTPUT, @OkRef OUTPUT

  END ELSE 
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
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

/**************** spRHAltaExpress ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRHAltaExpress') and type = 'P') drop procedure dbo.spRHAltaExpress
GO
CREATE PROCEDURE spRHAltaExpress
		   @Empresa	char(5),
		   @Sucursal	int,
		   @Usuario	char(10),
		   @Personal	char(10)
		   
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Mov		char(20),
    @MovID		varchar(20),
    @FechaRegistro	datetime,
    @FechaEmision	datetime,
    @Moneda		char(10),
    @TipoCambio		float,
	@PlazaPersonal varchar(10),
    @Plaza      varchar(20),    
	@Ok			int,
    @OkRef		varchar(255)

  SELECT @FechaRegistro = GETDATE()
  SELECT @FechaEmision = @FechaRegistro
  EXEC spExtraerFecha @FechaEmision OUTPUT

  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio 
    FROM Personal p, Mon m 
   WHERE p.Personal = @Personal AND m.Moneda = p.Moneda

  SELECT @Mov = RHAltas FROM EmpresaCfgMov WHERE Empresa = @Empresa 
  --SELECT * FROM EmpresaCfgMov WHERE Empresa = 'DEMO'
  --SELECT MOV, * FROM MOVTIPO WHERE MODULO='RH'AND  CLAVE='RH.A'

  SELECT @Plaza = ISNULL(Plaza,'') FROM Personal WHERE Personal = @Personal
  
  IF EXISTS(SELECT 1 FROM Personal WHERE Plaza = @Plaza AND Personal <> @Personal) AND ISNULL(@Plaza,'') <> ''
  BEGIN
	SELECT @PlazaPersonal = Personal FROM Personal WHERE Plaza = @Plaza AND Personal <> @Personal
	SELECT @Ok = 55410, @OkRef = @PlazaPersonal
  END

  BEGIN TRANSACTION
    INSERT RH (UltimoCambio, Sucursal, SucursalOrigen, SucursalDestino, Empresa,  Usuario,  Estatus,      Mov,  FechaEmision,  Moneda,  TipoCambio)
        SELECT GETDATE(),  @Sucursal,  @Sucursal,      @Sucursal,       @Empresa, @Usuario, 'SINAFECTAR', @Mov, @FechaEmision, @Moneda, @TipoCambio 
    SELECT @ID = SCOPE_IDENTITY()

    INSERT RHD (ID,  Renglon, Sucursal,  SucursalOrigen, Personal, SueldoDiario, SueldoDiarioComplemento, SDI, TipoContrato, PeriodoTipo, Jornada, TipoSueldo, Categoria, Departamento, Puesto, Grupo, FechaAlta, FechaAntiguedad, SucursalTrabajo, ReportaA, CentroCostos, VencimientoContrato, Plaza)
         SELECT @ID, 2048.0,  @Sucursal, @Sucursal,      Personal, SueldoDiario, SueldoDiarioComplemento, SDI, TipoContrato, PeriodoTipo, Jornada, TipoSueldo, Categoria, Departamento, Puesto, Grupo, FechaAlta, FechaAntiguedad, SucursalTrabajo, ReportaA, CentroCostos, VencimientoContrato, Plaza
           FROM Personal
          WHERE Personal = @Personal

    EXEC spRH @ID, 'RH', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @Mov OUTPUT, @MovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
    IF @Ok IS NULL
    BEGIN
      COMMIT TRANSACTION
      SELECT 'Se Genero '+RTRIM(@Mov)+' '+RTRIM(@MovID)
    END ELSE
    BEGIN
      ROLLBACK TRANSACTION
      SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
    END

  RETURN
END
GO

/**************** spRHRegistroPatronalCrear ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRHRegistroPatronalCrear') and type = 'P') drop procedure dbo.spRHRegistroPatronalCrear
GO
CREATE PROCEDURE spRHRegistroPatronalCrear
        @ID              int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok                 int,
    @OkRef              varchar(255),
    @Personal           varchar(10),
    @Empresa            varchar(5),
    @Sucursal           int,
    @Categoria          varchar(50),
    @Departamento       varchar(50),
    @Puesto             varchar(20),
    @Propiedad          varchar(50),
    @Valor              varchar(255),
    @Renglon            float
    
  SELECT @Propiedad = 'Registro Patronal', @Renglon = 0.0
  
  DECLARE crPersonal CURSOR LOCAL FOR
  SELECT Renglon FROM RHD WHERE ID = @ID
  OPEN crPersonal
  FETCH NEXT FROM crPersonal INTO @Renglon
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
  
    SELECT @Personal      = r.Personal,
           @Empresa       = p.Empresa,
           @Sucursal      = r.SucursalTrabajo,
           @Categoria     = r.Categoria,
           @Departamento  = r.Departamento,
           @Puesto        = r.Puesto
      FROM RHD r
      JOIN Personal p ON r.Personal = p.Personal
     WHERE r.ID = @ID AND r.Renglon = @Renglon
  
    EXEC spPersonalPropValor @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, @Propiedad, @Valor OUTPUT
    
    IF NULLIF(@Valor, '') IS NOT NULL
      IF NOT EXISTS(SELECT * FROM RHRegistroPatronal WHERE ID = @ID AND RegistroPatronal = @Valor)
        INSERT RHRegistroPatronal(ID, RegistroPatronal, Estatus)
                VALUES(@ID, @Valor, 'SINAFECTAR')
    
    FETCH NEXT FROM crPersonal INTO @Renglon
  END
  CLOSE crPersonal
  DEALLOCATE crPersonal

  RETURN
END
GO

/**************** spRHRegistroPatronal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRHRegistroPatronal') and type = 'P') drop procedure dbo.spRHRegistroPatronal
GO
CREATE PROCEDURE spRHRegistroPatronal
        @ID             int, 
        @Registro       varchar(20),
        @Folio          int,
        @Estatus        varchar(15),
        @AnexoEnvío     varchar(255),
        @AnexoRespuesta varchar(255),
        @Secuencia      int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok                 int,
    @OkRef              varchar(255)
    
IF @Secuencia <> 0
  UPDATE RHRegistroPatronal 
     SET Folio              = @Folio,
         Estatus            = @Estatus,
         AnexoEnvio         = @AnexoEnvío,
         AnexoRespuesta     = @AnexoRespuesta,
         SecuencialNotaria  = @Secuencia
   WHERE ID = @ID
     AND SUBSTRING(RegistroPatronal, 1, 10) = @Registro
ELSE
  UPDATE RHRegistroPatronal 
     SET Estatus            = @Estatus,
         AnexoRespuesta     = @AnexoRespuesta
   WHERE ID = @ID
     AND SUBSTRING(RegistroPatronal, 1, 10) = @Registro

  RETURN
END
GO

/**************** spRHIDSE ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRHIDSE') and type = 'P') drop procedure dbo.spRHIDSE
GO
CREATE PROCEDURE spRHIDSE
        @ID             int,
        @Estacion       int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok                 int,
    @OkRef              varchar(255),
    @Confirmado         bit,
    @SeguroSocial       varchar(20),
    @Fecha              datetime,
    @Mensaje            varchar(255),
    @Personal           varchar(20),
    @Clave              varchar(255)
    
  DECLARE crIDSE CURSOR FOR
  SELECT Clave FROM ListaST WHERE Estacion = @Estacion
  
  OPEN crIDSE
  FETCH NEXT FROM crIDSE INTO @Clave
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND NULLIF(@Clave, '') IS NOT NULL
    BEGIN
      SELECT @Confirmado    = CONVERT(int, SUBSTRING(@Clave, 1, 1)),
             @SeguroSocial  = SUBSTRING(@Clave, 2, 11),
--             @Fecha         = CONVERT(smalldatetime, '20' + SUBSTRING(@Clave, 17, 2) + '-' + SUBSTRING(@Clave, 15, 2) + '-' + SUBSTRING(@Clave, 13, 2), 102),
--             @Fecha         = CONVERT(datetime, SUBSTRING(@Clave, 13, 8))
             @Mensaje       = SUBSTRING(@Clave, 21, 234)
      
      SELECT @Personal = Personal FROM Personal WHERE Registro3 = @SeguroSocial
      
      IF NULLIF(@Personal, '') IS NOT NULL 
		IF @Confirmado = 1
           UPDATE RHD SET IDSEConciliado = @Confirmado, IDSEMensaje = 'OPERADO' WHERE ID = @ID AND Personal = @Personal
		ELSE
           UPDATE RHD SET IDSEConciliado = @Confirmado, IDSEMensaje = NULLIF(@Mensaje, '') WHERE ID = @ID AND Personal = @Personal
      
    END
    FETCH NEXT FROM crIDSE INTO @Clave
  END
  CLOSE crIDSE
  DEALLOCATE crIDSE

  RETURN
END
GO

-------------------------------- spNominaIDSE --------------------------------
-- spNominaIDSE genera el archivo para avisos del IDSE, además de que genera 
-- los registros en NominaIDSE (Tabla de lotes) y NominaIDSED (Tabla de deta-
-- lle de lotes).
/****************************************************************************/
GO
IF EXISTS(SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.spRHCreaIDSE') AND type = 'P')  
  DROP PROCEDURE dbo.spRHCreaIDSE 
GO
CREATE PROCEDURE spRHCreaIDSE
                 @ID          AS INT,           --ID del movimiento en RH
                 @RP          AS CHAR(10),      --Registro Patronal
                 @Estacion    AS INT            --Estación
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @RegistroPatronal AS CHAR(11),
          @IMSS             AS CHAR(11),
          @ApellidoPaterno  AS CHAR(27),
          @ApellidoMaterno  AS CHAR(27),
          @Nombre           AS CHAR(27),
          @SDI              AS MONEY,
          @TipoContrato     AS CHAR(1),
          @TipoSueldo       AS CHAR(1),
          @Jornada          AS CHAR(1),
          @FechaEmision     AS DATETIME,
          @UMF              AS INT,
          @TipoMovimiento   AS CHAR(2),
          @TipoMovStr       AS CHAR(25),
          @Personal         AS CHAR(10),
          @CausaBaja        AS CHAR(1),
          @Curp             AS CHAR(18),
          @Cadena           AS VARCHAR(200),
          @NoRegistros      AS INT,
          @CampoFinal       AS VARCHAR(MAX),
          @TotaldeRegs      AS CHAR(6),
          @FechaCreacion    AS DATETIME,
          @SDIStr           AS CHAR(6),
          @IDRH             AS INT,
          @RenglonRH        AS FLOAT,
          @Pad              AS CHAR(2),
          @UMFStr           AS CHAR(3),
          @Guia             AS CHAR(5),
          @Sucursal         AS INT,
          @Renglon          AS VARCHAR(255),
          @RegPatronal      AS CHAR(11),
          @Personal2           varchar(10),
          @Empresa2            varchar(5),
          @Sucursal2           int,
          @Categoria2          varchar(50),
          @Departamento2       varchar(50),
          @Puesto2             varchar(20),
          @Valor              varchar(255)


  DELETE FROM LISTAST WHERE ESTACION=@Estacion
  SELECT @Sucursal        =Cuenta FROM PersonalPropValor WHERE Propiedad='# Guia' AND Rama='SUC'
  SELECT @Guia            =Valor  FROM PersonalPropValor WHERE Propiedad='Registro Patronal'            AND Cuenta=@Sucursal AND Rama='SUC'  

  --Este cursor ya contiene los datos para construir el archivo de lotes para IDSE, el sp está
  --diseñado para manejar un solo archivo para todos los movimientos (altas, bajas y modificaciones)
  DECLARE BarridoMovsIDSE CURSOR FOR 
    SELECT    
      ISNULL(@RP,                       '')           AS REGPATRONAL,
      ISNULL(Personal.Registro3        ,'')           AS IMSS ,            --Número de seguridad social
      ISNULL(Personal.ApellidoPaterno  ,'')           AS ApellidoPaterno , --Ap Paterno 
      ISNULL(Personal.ApellidoMaterno  ,'')           AS ApellidoMaterno,  --Ap Materno
      ISNULL(Personal.Nombre           ,'')           AS Nombre,           --Nombre(s)
      ISNULL(Personal.SDI              ,0)*100        AS SDI ,             --SDI como número entero (se multiplica por 100)
      CASE Personal.TipoContrato 
        WHEN 'Trab. Permanente'  THEN '1'
        WHEN 'Trab. Ev. Ciudad'  THEN '2'
        WHEN 'Trab. Ev. Constrn' THEN '3'
        WHEN 'Eventual'          THEN '2'
        WHEN 'Construccion'      THEN '3'
        WHEN 'Permanente'        THEN '1'
/*      WHEN 'Ev. Campo'         THEN '4'*/
        ELSE '1'
        END                                           AS TipoContrato,     --Tipo de contrato 
      CASE Personal.TipoSueldo 
        WHEN 'Fijo'     THEN '0'
        WHEN 'Variable' THEN '1'
        WHEN 'Mixto'    THEN '2'
        ELSE '0'
        END                                           AS TipoSueldo,       --Tipo de sueldo
      CASE Personal.Jornada 
        WHEN 'Horario Completo' THEN '0'
        WHEN 'Un Dia' THEN           '1'
        WHEN 'Dos Dias' THEN         '2'
        WHEN 'Tres Dias' THEN        '3'
        WHEN 'Cuatro Dias' THEN      '4'
        WHEN 'Cinco Dias' THEN       '5'
        WHEN 'Jornada Reducida' THEN '6'
        ELSE  '0'
        END                                           AS Jornada,          --Tipo de Jornada
        RH.FechaEmision                               AS FechaEmision,     --Fecha del movimiento
        ISNULL(UnidadMedica,0)                        AS UMF,              --Unidad Medica Familiar
      CASE RH.Mov    
        WHEN 'Modificaciones' THEN '07'
        WHEN 'Altas'          THEN '08'
        WHEN 'Bajas'          THEN '02'
        END                                           AS TipoMovimiento,   --Tipo de movimiento
      RH.Mov                                          AS TipoMovStr,       --Tipo de movimiento como cadena (lo guardo así en el registro del detalle del lote)
      ISNULL(Personal.Personal,'')                    AS Personal,         --Clave del trabajador, solo informativa para el IMSS, pero nos sirve para dar seguimiento
      CASE RH.Concepto
        WHEN 'Termino de Contrato'      THEN '1'
        WHEN 'Separ. Voluntaria'        THEN '2'
        WHEN 'Abandono de Empleo'       THEN '3'
        WHEN 'Defuncion'                THEN '4'
        WHEN 'Clausura'                 THEN '5'
        WHEN 'Otras'                    THEN '6'
/*      WHEN 'Ausentismo'               THEN '7'
        WHEN 'Rescision de contrato'    THEN '8'
        WHEN 'Jubilacion'               THEN '9'
        WHEN 'Pension'                  THEN 'A'*/
        ELSE '1'
        END                                           AS CausaBaja,        --Causa de la baja
      Personal.Registro                               AS Curp,             --CURP del trabajador
      RHD.Renglon                                     AS Renglon,          --REnglón para insertarlo en el detalle
      RHD.ID                                          AS IDRH              --El ID del movimiento de RH
    FROM RH
    JOIN RHD ON RH.ID = RHD.ID
    JOIN Personal ON RHD.Personal = Personal.Personal
    --JOIN PersonalPropValor ON CAST(Personal.SucursalTrabajo AS VARCHAR(30)) = CAST(PersonalPropvalor.Cuenta AS VARCHAR(30))  --Esto lo debería de susutituir por una condición en where donde me dijera el RP del trabajador (SP de Angel)
    WHERE RH.Estatus='Concluido'
    AND ( (RH.Concepto = 'Sueldo' AND RH.Mov='Modificaciones') OR (RH.Mov IN ('Altas','Bajas')))
    AND RHD.ID=@ID
    AND (RHD.IDSEConciliado IS NULL OR  RHD.IDSEConciliado=0)
    --AND PersonalPropValor.Propiedad='Registro Patronal'
    --AND 
/*SUBSTRING(PersonalPropValor.Valor, 1, 10)  =@RP*/ --Esto lo debería de susutituir por una condición en where donde me dijera el RP del trabajador (SP de Angel)

  SET @NoRegistros=0  --POngo mi contador en 0
  SET @CampoFinal=''  --Micadena la dejo vacía
  SET @Pad='  '       --Solo para rellenar el registro

  OPEN BarridoMovsIDSE 
  FETCH NEXT FROM BarridoMovsIDSE INTO 
    @RegPatronal,
    @IMSS,
    @ApellidoPaterno,
    @ApellidoMaterno,
    @Nombre,
    @SDI,
    @TipoContrato,
    @TipoSueldo,
    @Jornada,
    @FechaEmision,
    @UMF,
    @TipoMovimiento,
    @TipoMovStr,
    @Personal,
    @CausaBaja,
    @Curp,
    @RenglonRH,
    @IDRH

  SET @FechaCreacion=GETDATE()


  WHILE @@FETCH_STATUS = 0
  BEGIN

    SELECT @Personal2      = r.Personal,
           @Empresa2       = p.Empresa,
           @Sucursal2      = r.SucursalTrabajo,
           @Categoria2     = r.Categoria,
           @Departamento2  = r.Departamento,
           @Puesto2        = r.Puesto
      FROM RHD r
      JOIN Personal p ON r.Personal = p.Personal
     WHERE r.ID = @ID AND r.Renglon = @RenglonRH

    EXEC spPersonalPropValor @Empresa2, @Sucursal2, @Categoria2, @Puesto2, @Personal2, 'Registro Patronal', @Valor OUTPUT


    if SUBSTRING(@Valor,1,10)=@RP
    BEGIN


      SET @NoRegistros=@NoRegistros+1 --Incremento el contador
      SET @SDIStr=CAST(CAST(ROUND(@SDI,0) AS INT) AS CHAR(6))  --Formateo el SDI porque viene como numérico
      SET @SDIStr=REPLICATE('0',6-LEN(@SDIStr))+@SDIStr
      SET @UMFStr=CAST(CAST(ROUND(@UMF,0) AS INT) AS CHAR(3))  --Caso similar al de SDI, formateo porque viene como entero
      SET @UMFStr=REPLICATE('0',3-LEN(@UMFStr))+@UMFStr

      SET @Cadena=
          @RP+                     --Registro patronal con verificador (11 Caracteres, del   1 al  11)
          @IMSS+                   --NSS con verificador               (11 Caracteres, del  12 al  22)
          @ApellidoPaterno+        --Apellido paterno                  (27 Caracteres, del  23 al  49)
          @ApellidoMaterno+        --Apellido materno                  (27 Caracteres, del  50 al  76)
          @Nombre+                 --Nombre(s)                         (27 Caracteres, del  77 al 103)
          CASE @TipoMovimiento
            WHEN '02' THEN REPLICATE('0',6)
            ELSE @SDIStr
            END+                   --SDI (En caso de baja 000000)      ( 6 Caracteres, del 104 al 109)
          CASE @TipoMovimiento 
            WHEN '02' THEN REPLICATE('0',6)
            ELSE SPACE(6)
            END+                   --FILLER (En caso de baja 000000)   ( 6 Caracteres, del 110 al 115)
          CASE @TipoMovimiento
            WHEN '02' THEN '0'
            ELSE @TipoContrato
            END+                   --Tipo de Trabajador (Baja=0)       ( 1 Caracteres, del 116 al 116)
          CASE @TipoMovimiento
            WHEN '02' THEN '0'
            ELSE @TipoSueldo
            END+                   --Tipo de Sueldo     (Baja=0)       ( 1 Caracteres, del 117 al 117)
          CASE @TipoMovimiento
            WHEN '02' THEN '0'
            ELSE @Jornada          --Tipo de Jornada    (Baja=0)       ( 1 Caracteres, del 118 al 118)
            END+
          RIGHT('0'+LTRIM(DATEPART(dd,@FechaEmision)),2)
            +RIGHT('0'+LTRIM(DATEPART(mm,@FechaEmision)),2)
            +LTRIM(DATEPART(yyyy,@FechaEmision))+--Fecha Mov (ddmmaaaa)( 8 Caracteres, del 119 al 126)
          CASE @TipoMovimiento
            WHEN '08' THEN +@UMFStr
            ELSE SPACE(3)
            END+                   --Unidad Medica (solo en alta)      ( 3 Caracteres, del 127 al 129)
          @Pad+                    --FILLER                            ( 2 Caracteres, del 130 al 131)
          @TipoMovimiento+         --Tipo de Movimiento                ( 2 Caracteres, del 132 al 133)
          @Guia+                   --Guía                              ( 5 Caracteres, del 134 al 138)
          @Personal+               --Clave del trabajador(empresa)     (10 Caracteres, del 139 al 148)
          CASE @TipoMovimiento
            WHEN '02' THEN @CausaBaja
            ELSE ' '
	        END+                   --Causa de la baja (solo en baja)   ( 1 Caracteres, del 149 al 149)
          @Curp+                   --CURP                              (18 Caracteres, del 150 al 167)
          '9'--+char(13)+char(10)  --Delimitador                       ( 1 Caracteres, del 168 al 168)
  
      INSERT INTO LISTAST (ESTACION,CLAVE) VALUES (@Estacion,@Cadena)
      SET @CampoFinal=@CampoFinal+@Cadena    
    
    END 
    
    FETCH NEXT FROM BarridoMovsIDSE INTO 
      @RegPatronal,
      @IMSS,
      @ApellidoPaterno,
      @ApellidoMaterno,
      @Nombre,
      @SDI,
      @TipoContrato,
      @TipoSueldo,
      @Jornada,
      @FechaEmision,
      @UMF,
      @TipoMovimiento,
      @TipoMovStr,
      @Personal,
      @CausaBaja,
      @Curp,
      @RenglonRH,
      @IDRH
 
  END
  CLOSE BarridoMovsIDSE
  DEALLOCATE BarridoMovsIDSE
  /*Aquí genero el último renglón del archivo de lote*/
  IF (@NoRegistros>0)
  BEGIN
    SET @TotaldeRegs=CAST(@NoRegistros AS CHAR(6))
    SET @TotaldeRegs=REPLICATE('0',6-LEN(@TotaldeRegs))+@TotaldeRegs
    SET @Cadena=REPLICATE('*', 13)+SPACE(43)+@TotaldeRegs+SPACE(71)+@Guia+SPACE(29)+'9'
    INSERT INTO LISTAST (ESTACION,CLAVE) VALUES (@Estacion,@Cadena)
    SET @CampoFinal=@CampoFinal+@Cadena
  END

  --SELECT CLAVE FROM LISTAST WHERE ESTACION=@Estacion ORDER BY CLAVE DESC

END
GO
--PRINT "******************* SP RH ******************"
