SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/**************** spProyInfoPresupuesto ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spProyInfoPresupuesto') AND type = 'P') DROP PROCEDURE dbo. spProyInfoPresupuesto
GO            
CREATE PROCEDURE  spProyInfoPresupuesto
	     @Estacion		int,
	     @Empresa		varchar(5),
	     @Proyecto		varchar(50)
WITH ENCRYPTION
AS BEGIN 
  DECLARE @Ejercicio	int,
	  @Periodo	int,	
	  @Concepto	varchar(50),
	  @MovMoneda	varchar(10),		
	  @Presupuesto	float,
	  
	  @GastoPendiente	float,
	  @GastoEjercido	float
	  
 -- DELETE PresupuestoProyecto WHERE Estacion = @Estacion	  

  	CREATE TABLE #PresupuestoProyecto (
	  Estacion	int NULL ,
  	  Empresa	varchar(5) COLLATE Database_Default NULL,
	  Ejercicio	int NULL,
	  Periodo	int NULL,		
	  Proyecto	varchar(50) COLLATE Database_Default NULL,			
	  Concepto	varchar(50) COLLATE Database_Default NULL,
	  MovMoneda	varchar(10) COLLATE Database_Default NULL,		

	  Presupuesto	float NULL,	  
	  GastoPendiente float NULL,
	  GastoEjercido	 float NULL,
	  Disponible	float NULL)
	  
  DECLARE crGasto CURSOR LOCAL FOR
  SELECT g.Ejercicio,
         g.Periodo,
         gd.Concepto,
         g.Moneda,
         Presupuesto = SUM(gd.Importe)
    FROM Gasto g
   INNER JOIN GastoD gd ON g.ID = gd.ID
			AND gd.Proyecto = @Proyecto
   INNER JOIN MovTipo mt ON mt.Modulo = 'GAS'
  		         AND mt.Mov = g.Mov
		         AND mt.Clave = 'GAS.PR'
   WHERE g.Empresa = @Empresa		         
  GROUP BY g.Ejercicio,
  	   g.Periodo,
           gd.Concepto,
           g.Moneda
  OPEN crGasto           
  FETCH NEXT FROM crGasto INTO @Ejercicio, @Periodo, @Concepto, @MovMoneda, @Presupuesto
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      EXEC spGastoEjercidoPresupuesto @Empresa, @Ejercicio, @Periodo, @Concepto, @MovMoneda, @Proyecto,  @GastoEjercido OUTPUT
      EXEC spGastoPendientePresupuesto @Empresa, @Ejercicio, @Periodo, @Concepto, @MovMoneda, @Proyecto, @GastoPendiente OUTPUT
      INSERT #PresupuestoProyecto (Estacion,  Empresa,  Ejercicio,  Periodo,  Proyecto,  Concepto,  MovMoneda,  Presupuesto,  GastoPendiente,  GastoEjercido, Disponible)
                           SELECT @Estacion, @Empresa, @Ejercicio, @Periodo, @Proyecto, @Concepto, @MovMoneda, @Presupuesto, @GastoPendiente, @GastoEjercido, ISNULL(@Presupuesto, 0) - ISNULL(@GastoPendiente, 0) - ISNULL(@GastoEjercido, 0)
                              
    END
    FETCH NEXT FROM crGasto INTO @Ejercicio, @Periodo, @Concepto, @MovMoneda, @Presupuesto
  END
  CLOSE crGasto
  DEALLOCATE crGasto
  
SELECT * 
    FROM #PresupuestoProyecto 
   WHERE Estacion = @Estacion
END           
GO

/**************** spProyGenerarSolicitudInventario ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyGenerarSolicitudInventario') and type = 'P') drop procedure dbo.spProyGenerarSolicitudInventario
Go             
CREATE PROCEDURE spProyGenerarSolicitudInventario
		   @Sucursal		int,
		   @Empresa		char(5),
		   @Accion		char(20),
 		   @Usuario		char(10),
		   @FechaTrabajo	datetime = NULL,
		   @ID			int,
    		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
	@ProyGenerarInvAlAfectar			bit,
	@ProyGenerarInvPorActividad		bit,
	@ProyGenerarInvTiempo			int,
	@ProyGenerarInvTiempoUnidad		varchar(20),

	@DiasHabiles				varchar(10),

	@IDProyecto				int,
	@Actividad				varchar(50),
	@Comienzo				datetime,
	@InvSolicitud				varchar(20),
	@InvSolicitudCancelada			varchar(20),
	@InvSolicitudID				varchar(20),
	@FechaEmision				datetime,
	@Proyecto				varchar(50),
	@Moneda					char(10),
	@TipoCambio				float,
	@Almacen				varchar(10),

	@Generar				bit,
	@GenerarDespuesDe			datetime,
	@DiasRestar				int,
	@FechaActual				datetime,

	@Articulo				varchar(20),
	@SubCuenta				varchar(50),
	@Cantidad				float,
	@CantidadA				float,
	@Unidad					varchar(50),
	@EsFormula				bit,

	@Renglon				float,
	@RenglonID				int,

	@IDSolicitud				int,
	@IDSolicitudCancelada			int,
	@Origen					varchar(20),
	@OrigenID				varchar(20),
	@Factor					float				

  SELECT
    @ProyGenerarInvAlAfectar = ProyGenerarInvAlAfectar,
    @ProyGenerarInvPorActividad = ProyGenerarInvPorActividad,
    @ProyGenerarInvTiempo = ProyGenerarInvTiempo,
    @ProyGenerarInvTiempoUnidad = ProyGenerarInvTiempoUnidad	  		  
    FROM EmpresaCfg 
   WHERE Empresa = @Empresa

  SET @ProyGenerarInvTiempo = 0 - @ProyGenerarInvTiempo

  SELECT
    @DiasHabiles = DiasHabiles
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT
    @InvSolicitud = InvSolicitud,
    @InvSolicitudCancelada = InvSolicitudCancelada
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @FechaTrabajo IS NULL
    SET @FechaActual = GETDATE()
  ELSE
    SET @FechaActual = @FechaTrabajo

  EXEC spExtraerFecha @FechaActual OUTPUT

  IF @Accion = 'AFECTAR'
  BEGIN
    IF @ProyGenerarInvPorActividad = 1
      DECLARE crActividad CURSOR FOR
       SELECT p.Proyecto, p.ID, pd.Actividad, pd.Comienzo, p.Moneda, m.TipoCambio, pdamiaa.Almacen, p.Mov, p.MovID
         FROM ProyectoD pd JOIN Proyecto p
	   ON pd.ID = p.ID JOIN Mon m
	   ON m.Moneda = p.Moneda JOIN ProyectoDArtMaterialIdActAlm pdamiaa
	   ON pdamiaa.ID = p.ID AND pdamiaa.Actividad = pd.Actividad
        WHERE p.ID = @ID
          AND NOT EXISTS(SELECT * FROM ProyectoDSolicitudPendiente WHERE ProyectoID = p.ID AND Actividad = pd.Actividad)
	ORDER BY p.ID, pd.Actividad
    ELSE
      DECLARE crActividad CURSOR FOR
       SELECT p.Proyecto, p.ID, NULL, p.Comienzo, p.Moneda, m.TipoCambio, pdamia.Almacen, p.Mov, p.MovID
         FROM Proyecto p JOIN Mon m
	   ON m.Moneda = p.Moneda JOIN ProyectoDArtMaterialIdAlm pdamia
	   ON pdamia.ID = p.ID
        WHERE p.ID = @ID
	  AND NOT EXISTS(SELECT * FROM ProyectoDSolicitudPendiente WHERE ProyectoID = p.ID AND Actividad IS NULL)

      OPEN crActividad
      FETCH NEXT FROM crActividad INTO @Proyecto, @IDProyecto, @Actividad, @Comienzo, @Moneda, @TipoCambio, @Almacen, @Origen, @OrigenID
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
	  SET @FechaEmision = @FechaActual
	  IF @ProyGenerarInvAlAfectar = 1
          BEGIN
	    SET @Generar = 1
          END ELSE
          BEGIN
	    IF @ProyGenerarInvTiempoUnidad = 'Dia'    SET @GenerarDespuesDe = DATEADD(day,@ProyGenerarInvTiempo,@Comienzo)   ELSE
	    IF @ProyGenerarInvTiempoUnidad = 'Semana' SET @GenerarDespuesDe = DATEADD(week,@ProyGenerarInvTiempo,@Comienzo)  ELSE
	    IF @ProyGenerarInvTiempoUnidad = 'Mes'    SET @GenerarDespuesDe = DATEADD(month,@ProyGenerarInvTiempo,@Comienzo) ELSE
	    IF @ProyGenerarInvTiempoUnidad = 'Año'    SET @GenerarDespuesDe = DATEADD(year,@ProyGenerarInvTiempo,@Comienzo)
	    SET @DiasRestar = 0 - DATEDIFF(day,@GenerarDespuesDe,@Comienzo)
	    EXEC spCalcularDiasHabiles @Comienzo, @DiasRestar, @DiasHabiles,1, @GenerarDespuesDe OUTPUT
	    IF @FechaActual >= @GenerarDespuesDe SET @Generar = 1 ELSE SET @Generar = 0	    	
          END

	  IF NOT EXISTS(SELECT * FROM Alm WHERE Almacen = @Almacen) 
	  BEGIN
	    SET @Ok = 20830
	    SET @OkRef = @Almacen
	  END

	  IF @Generar = 1 AND @Ok IS NULL
          BEGIN
  	    INSERT Inv (Empresa,  Mov,           MovID, FechaEmision,  UltimoCambio,  Proyecto,  Actividad,  Moneda,  TipoCambio,  Usuario,  Estatus,      Almacen)		      
	        VALUES (@Empresa, @InvSolicitud, NULL,  @FechaEmision, @FechaEmision, @Proyecto, @Actividad, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Almacen)
	    IF @@ERROR <> 0 SET @Ok = 1
	    SET @IDSolicitud = SCOPE_IDENTITY()
	    IF @Ok IS NULL
	    BEGIN

	      SET @Renglon = 2048.0
	      SET @RenglonID = 1
              IF @ProyGenerarInvPorActividad = 1
                DECLARE crArtMaterial CURSOR FOR
                 SELECT 
	           pdam.Material, 
		   ISNULL(pdam.SubCuenta,''), 
		   ISNULL(pdam.Cantidad,0.0), 
		   pdam.Unidad, 
	           a.EsFormula
                   FROM ProyectoDArtMaterialExplotado pdam JOIN Art a
	             ON a.Articulo = pdam.Material
	          WHERE pdam.ID = @ID AND pdam.Actividad = @Actividad AND pdam.Almacen = @Almacen
	      ELSE
                DECLARE crArtMaterial CURSOR FOR
                 SELECT 
	           pdam.Material, 
		   ISNULL(pdam.SubCuenta,''), 
		   ISNULL(pdam.Cantidad,0.0), 
		   pdam.Unidad, 
	           a.EsFormula
                   FROM ProyectoDArtMaterialExplotado pdam JOIN Art a 
	             ON a.Articulo = pdam.Material
	          WHERE pdam.ID = @ID AND pdam.Almacen = @Almacen

              OPEN crArtMaterial
              FETCH NEXT FROM crArtMaterial INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @EsFormula
              WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL 
              BEGIN
                IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
                BEGIN
                  EXEC spUnidadFactor @Empresa, @Articulo, @SubCuenta, @Unidad, @Factor OUTPUT

		  INSERT InvD (ID,           Renglon,  RenglonSub,    RenglonID,  Articulo,  SubCuenta,  Cantidad,  CantidadInventario,  Unidad,  FechaRequerida, Almacen)
	               VALUES (@IDSolicitud, @Renglon, 0,             @RenglonID, @Articulo, @SubCuenta, @Cantidad, @Cantidad * @Factor, @Unidad, @Comienzo,      @Almacen)

	          IF @@ERROR <> 0 SET @Ok = 1
	          SET @Renglon = @Renglon + 2048.0
	          SET @RenglonID = @RenglonID + 1
                END
		FETCH NEXT FROM crArtMaterial INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @EsFormula
              END
              CLOSE crArtMaterial
              DEALLOCATE crArtMaterial	   

	      IF @Ok IS NULL
	        EXEC spAfectar 'INV', @IDSolicitud, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion=@@SPID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

              IF @Ok IS NULL
	      BEGIN
		SELECT @InvSolicitudID = MovID FROM Inv WHERE ID = @IDSolicitud
                EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'PROY', @ID, @Origen, @OrigenID, 'INV', @IDSolicitud, @InvSolicitud, @InvSolicitudID, @Ok OUTPUT
	      END

	    END
          END
        END
        FETCH NEXT FROM crActividad INTO @Proyecto, @IDProyecto, @Actividad, @Comienzo, @Moneda, @TipoCambio, @Almacen, @Origen, @OrigenID
      END
      CLOSE crActividad
      DEALLOCATE crActividad
    
  END ELSE
  BEGIN
    IF @Accion IN ('CANCELAR','REESTRUCTURAR')
    BEGIN

      IF @Accion = 'REESTRUCTURAR' SET @Accion = 'CANCELAR'

      IF @ProyGenerarInvPorActividad = 1
        DECLARE crActividad CURSOR FOR
         SELECT
           pdsp.Proyecto,
           pdsp.Actividad,
	   pdsp.SolicitudID	
           FROM ProyectoDSolicitudPendiente pdsp JOIN ProyectoD pd
             ON pd.ID = pdsp.ProyectoID AND pd.Actividad = pdsp.Actividad
          WHERE pdsp.ProyectoID = @ID
            AND pdsp.Empresa = @Empresa   
	    AND pdsp.Estatus = 'PENDIENTE' 
	    --AND pd.Estado IN ('No Comenzada',NULL)
      ELSE   
        DECLARE crActividad CURSOR FOR
         SELECT
           pdsp.Proyecto,
           pdsp.Actividad,
	   pdsp.SolicitudID	
           FROM ProyectoDSolicitudPendiente pdsp JOIN Proyecto p
             ON p.ID = pdsp.ProyectoID
          WHERE pdsp.ProyectoID = @ID
            AND pdsp.Empresa = @Empresa    
	    AND pdsp.Estatus = 'PENDIENTE' 
	    --AND p.Estado IN ('No Comenzada',NULL)

      OPEN crActividad
      FETCH NEXT FROM crActividad INTO @Proyecto, @Actividad, @IDSolicitud
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
	  EXEC spAfectar 'INV', @IDSolicitud, @Accion, 'Todo', NULL, @Usuario, @Estacion=@@SPID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

          IF @Ok IS NULL
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'PROY', @ID, @Origen, @OrigenID, 'INV', @IDSolicitud, @InvSolicitud, @InvSolicitudID, @Ok OUTPUT

	  IF @Ok IS NOT NULL
          BEGIN
	    SET @Ok = NULL
	    SET @OkRef = NULL

	    UPDATE InvD SET CantidadA = CantidadPendiente WHERE ID = @IDSolicitud
	    EXEC @IDSolicitudCancelada = spAfectar 'INV', @IDSolicitud, 'GENERAR', 'Seleccion', @InvSolicitudCancelada, @Usuario, @Estacion=@@SPID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
	    IF @Ok IS NULL
	      EXEC spAfectar 'INV', @IDSolicitudCancelada, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion=@@SPID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
          END
        END
        FETCH NEXT FROM crActividad INTO @Proyecto, @Actividad, @IDSolicitud
      END
      CLOSE crActividad
      DEALLOCATE crActividad
    END
  END	
END
GO

/**************** spProyectoCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoCerrarDia') and type = 'P') drop procedure dbo.spProyectoCerrarDia
Go             
CREATE PROCEDURE spProyectoCerrarDia
		   @Sucursal		int,
		   @Empresa		char(5),
		   @Usuario		char(10),
		   @FechaTrabajo	datetime,
		   @Fecha		datetime,
    		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @ID		int

  DECLARE crProyecto CURSOR FOR
   SELECT p.ID
     FROM Proyecto p
    WHERE p.Estatus = 'PENDIENTE' AND EXISTS(SELECT * FROM ProyectoDArtMaterial pdam WHERE pdam.ID = p.ID)

  OPEN crProyecto
  FETCH NEXT FROM crProyecto INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC spProyGenerarSolicitudInventario @Sucursal, @Empresa, 'AFECTAR', @Usuario, @FechaTrabajo, @ID, @Ok OUTPUT, @OkRef OUTPUT
    END
    FETCH NEXT FROM crProyecto INTO @ID
  END
  CLOSE crProyecto
  DEALLOCATE crProyecto	   

END
GO

/**************** spProyectoProrratearMaterial ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoProrratearMaterial') and type = 'P') drop procedure dbo.spProyectoProrratearMaterial
Go             
CREATE PROCEDURE spProyectoProrratearMaterial
		   @ID			int,
		   @Fase		varchar(50),
		   @Estacion		int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE	@CantidadActividades		int,
		@Actividad			varchar(50),
		@Transaccion			varchar(50),
		@Ok				int,
		@OkRef				varchar(255)

  SET @Transaccion = 'spProyectoProrratearMaterial' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  SELECT @CantidadActividades = COUNT(*) 
    FROM ProyectoD 
   WHERE ID = @ID 
     AND Actividad LIKE RTRIM(@Fase) + '.%'
     AND RTRIM(Actividad) <> @Fase

  SET @Ok = NULL
  SET @OkRef = NULL

  BEGIN TRANSACTION @Transaccion

  DECLARE crProyectoD CURSOR FOR
   SELECT
     Actividad
     FROM ProyectoD p
    WHERE ID = @ID 
      AND Actividad LIKE RTRIM(@Fase) + '.%'
      AND RTRIM(Actividad) <> @Fase

  OPEN crProyectoD
  FETCH NEXT FROM crProyectoD INTO @Actividad
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      DELETE FROM ProyectoDArtMaterial WHERE ID = @ID AND Actividad = @Actividad
      IF @@ERROR <> 0 SET @Ok = 1

      IF @Ok IS NULL
      BEGIN
        INSERT ProyectoDArtMaterial (ID, Actividad, Material, SubCuenta, Cantidad, Unidad, Almacen)
        SELECT 
          ID,
	  @Actividad,
	  Material,
	  SubCuenta,
	  Cantidad/@CantidadActividades,
	  Unidad,
	  Almacen
          FROM ProyectoDArtMaterial 
         WHERE ID = @ID AND RTRIM(Actividad) = RTRIM(@Fase)
        IF @@ERROR <> 0 SET @Ok = 1
      END

    END
    FETCH NEXT FROM crProyectoD INTO @Actividad
  END
  CLOSE crProyectoD
  DEALLOCATE crProyectoD	   

  IF @Ok IS NULL
  BEGIN
    DELETE FROM ProyectoDArtMaterial WHERE ID = @ID AND RTRIM(Actividad) = RTRIM(@Fase)
    IF @@ERROR <> 0 SET @Ok = 1
  END

  IF @Ok IS NULL
    COMMIT TRANSACTION @Transaccion
  ELSE
    ROLLBACK TRANSACTION @Transaccion

  IF @Ok IS NULL
    SELECT 'Se ha prorrateado el material de la fase ' + RTRIM(@Fase) + ' entre ' + RTRIM(CONVERT(varchar,@CantidadActividades)) + ' actividades.' 
  ELSE
    SELECT 'ERROR: ' + RTRIM(LTRIM(CONVERT(varchar,Mensaje))) + ', ' + Descripcion FROM MensajeLista WHERE Mensaje = @Ok
END
GO

/**************** spPlantillaProyectoDVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlantillaProyectoDVerificar') and type = 'P') drop procedure dbo.spPlantillaProyectoDVerificar
GO
CREATE PROCEDURE spPlantillaProyectoDVerificar
				@Plantilla	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mensaje	        varchar(255),
    @Actividad          varchar(50),
    @Predecesora        varchar(50),
    @Rama               varchar(50),
    @Ok                 int,
    @OkRef              varchar(255),
    @EsFase             bit,
    @SubPlantilla       varchar(50),
    @RecursoOmision	varchar(10),
	@DuracionUnidad     varchar(10)   

  SELECT @Actividad = NULL
  SELECT @Actividad = MIN(Actividad) FROM PlantillaProyectoD WHERE Plantilla = @Plantilla AND Actividad = Predecesora

  DECLARE crActValidar CURSOR LOCAL STATIC FOR
    SELECT Actividad, NULLIF(RTRIM(Predecesora), ''), dbo.fnActRama(Actividad), EsFase, NULLIF(RTRIM(SubPlantilla), ''), NULLIF(RTRIM(RecursoOmision), ''), DuracionUnidad
      FROM PlantillaProyectoD
     WHERE Plantilla = @Plantilla
  
  OPEN crActValidar
  FETCH NEXT FROM crActValidar INTO @Actividad, @Predecesora, @Rama, @EsFase, @SubPlantilla, @RecursoOmision, @DuracionUnidad
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      /*IF @RecursoOmision IS NOT NULL
        IF NOT EXISTS(SELECT * FROM PlantillaProyectoDRecurso WHERE Plantilla = @Plantilla AND Actividad = @Actividad AND Recurso = @RecursoOmision)
          INSERT PlantillaProyectoDRecurso (Plantilla, Actividad, Recurso) VALUES (@Plantilla, @Actividad, @RecursoOmision)*/
      -- Valida que la Predecesora no sea papa de la actividad
      IF EXISTS (SELECT * FROM dbo.fnActRamaDesglosar(@Actividad) WHERE Rama = @Predecesora)
        SELECT @Ok = 26150, @OkRef = @Actividad

      -- Validar que la predecesora Exista (cambiar el mensaje de error)
      IF NOT EXISTS (SELECT * FROM PlantillaProyectoD WHERE Plantilla = @Plantilla AND Actividad = @Predecesora) AND @Ok IS NULL AND @Predecesora IS NOT NULL
        SELECT @Ok = 26150, @OkRef = @Actividad

      -- Validar que la fase exista
      IF NOT EXISTS (SELECT * FROM PlantillaProyectoD WHERE Plantilla = @Plantilla AND Actividad = @Rama) AND @Ok IS NULL AND @Rama IS NOT NULL
        SELECT @Ok = 20996, @OkRef = @Actividad

      -- Si es Fase sin subplantilla valida que tenga hijos
      IF @EsFase = 1 AND @SubPlantilla IS NULL AND NOT EXISTS (SELECT * FROM PlantillaProyectoD WHERE Plantilla = @Plantilla AND dbo.fnActRama(Actividad) = @Actividad) AND @Ok IS NULL
        SELECT @Ok = 20997, @OkRef = @Actividad

      -- Si es Fase con subplantilla valida que no tenga hijos
      IF @EsFase = 1 AND @SubPlantilla IS NOT NULL AND EXISTS (SELECT * FROM PlantillaProyectoD WHERE Plantilla = @Plantilla AND dbo.fnActRama(Actividad) = @Actividad) AND @Ok IS NULL
        SELECT @Ok = 72090, @OkRef = @Actividad
	
	  -- Validar que todas las Actividades tengan la misma unidad
	  IF ISNULL(@DuracionUnidad, '') <> '' AND EXISTS (SELECT * FROM PlantillaProyectoD WHERE Plantilla = @Plantilla AND Actividad <> @Actividad AND ISNULL(DuracionUnidad,'') <> @DuracionUnidad AND ISNULL(DuracionUnidad,'') <> '') AND @Ok IS NULL
	    SELECT @Ok = 20186 --, @OkRef = @Actividad

    END
    FETCH NEXT FROM crActValidar INTO @Actividad, @Predecesora, @Rama, @EsFase, @SubPlantilla, @RecursoOmision, @DuracionUnidad
  END
  CLOSE crActValidar
  DEALLOCATE crActValidar 

  IF @Ok IS NOT NULL 
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
  ELSE 
    SELECT @Mensaje = NULL

  SELECT @Mensaje

  RETURN
END
GO

/**************** spProyectoDVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDVerificar') and type = 'P') drop procedure dbo.spProyectoDVerificar
GO
CREATE PROCEDURE spProyectoDVerificar
				@ID		int,
				@EnSilencio	bit		= 0,
				@Ok		int		= NULL OUTPUT,
				@OkRef		varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mensaje	        varchar(255),
    @Actividad          varchar(50),
    @Predecesora        varchar(50),
    @Rama               varchar(50),
    @EsFase             bit,
	@DuracionUnidad     varchar(10)

  SELECT @Actividad = NULL
  SELECT @Actividad = MIN(Actividad) FROM ProyectoD WHERE ID = @ID AND Actividad = Predecesora

  IF @Actividad IS NOT NULL
    SELECT @Ok = 26150, @OkRef = @Actividad 

  -- Validar que si se borran actividades no esten asignadas a un recurso
  IF @Ok IS NULL
  BEGIN
    SELECT @Actividad = NULL
    SELECT @Actividad = MIN(Actividad)
      FROM ProyectoDRecurso
     WHERE ID = @ID
       AND Actividad NOT IN (SELECT Actividad FROM ProyectoD WHERE ID = @ID)

    IF @Actividad IS NOT NULL  
      SELECT @Ok = 14071, @OkRef = @Actividad
  END

  DECLARE crActValidar CURSOR LOCAL STATIC FOR
    SELECT Actividad, NULLIF(RTRIM(Predecesora), ''), dbo.fnActRama(Actividad), EsFase, DuracionUnidad
      FROM ProyectoD
     WHERE ID = @ID
  
  OPEN crActValidar
  FETCH NEXT FROM crActValidar INTO @Actividad, @Predecesora, @Rama, @EsFase, @DuracionUnidad
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      -- Validar que la predecesora no sea papa de la actividad
      IF EXISTS (SELECT * FROM dbo.fnActRamaDesglosar(@Actividad) WHERE Rama = @Predecesora)
        SELECT @Ok = 26150, @OkRef = @Actividad
      -- Validar que la predecesora Exista (cambiar el mensaje de error)
      IF NOT EXISTS (SELECT * FROM ProyectoD WHERE ID = @ID AND Actividad = @Predecesora) AND @Ok IS NULL AND @Predecesora IS NOT NULL
        SELECT @Ok = 26150, @OkRef = @Actividad
      -- Validar que la rama exista
      IF NOT EXISTS (SELECT * FROM ProyectoD WHERE ID = @ID AND Actividad = @Rama) AND @Ok IS NULL AND @Rama IS NOT NULL
        SELECT @Ok = 20996, @OkRef = @Actividad
      -- Si es Fase valida que tenga hijos
      IF @EsFase = 1 AND NOT EXISTS(SELECT * FROM ProyectoD WHERE ID = @ID AND dbo.fnActRama(Actividad) = @Actividad)
        SELECT @Ok = 20997, @OkRef = @Actividad
	  -- Validar que todas las Actividades tengan la misma unidad
	  IF ISNULL(@DuracionUnidad, '') <> '' AND EXISTS (SELECT * FROM ProyectoD WHERE ID = @ID AND Actividad <> @Actividad AND ISNULL(DuracionUnidad,'') <> @DuracionUnidad AND ISNULL(DuracionUnidad,'') <> '') AND @Ok IS NULL
	    SELECT @Ok = 20187 --, @OkRef = @Actividad
    END
    FETCH NEXT FROM crActValidar INTO @Actividad, @Predecesora, @Rama, @EsFase, @DuracionUnidad
  END
  CLOSE crActValidar
  DEALLOCATE crActValidar 

  IF @EnSilencio = 0
  BEGIN
    IF @Ok IS NOT NULL 
      SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
    ELSE 
      SELECT @Mensaje = NULL

    SELECT @Mensaje
  END

  RETURN
END
GO

/****************** spProyectoReestructurarVerificar ******************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoReestructurarVerificar') and type = 'p') drop procedure spProyectoReestructurarVerificar
GO

/****************** spProyectoReestructurar ***********************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoReestructurar') and type = 'p') drop procedure spProyectoReestructurar
GO

/**************** spProyectoInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoInfo') and type = 'P') drop procedure dbo.spProyectoInfo
GO
CREATE PROCEDURE spProyectoInfo
				@ID	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		varchar(5),
    @DiasHabiles	varchar(20),
    @HorasDia		float,
    @FasesInformativas	bit

  SELECT @Empresa = Empresa, @HorasDia = HorasDia, @DiasHabiles = DiasHabiles
    FROM Proyecto
   WHERE ID = @ID

  SELECT @DiasHabiles = ISNULL(@DiasHabiles, UPPER(ISNULL(DiasHabiles, 'LUN-VIE'))), @HorasDia = ISNULL(@HorasDia, ISNULL(HorasDia, 8))         
    FROM EmpresaGral
   WHERE Empresa = @Empresa
  SELECT @FasesInformativas = ISNULL(ProyFasesInformativas, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT 'HorasDia' = @HorasDia, 'DiasHabiles' = @DiasHabiles, 'FasesInformativas' = @FasesInformativas
  RETURN
END
GO

/**************** spProyectoDInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDInfo') and type = 'P') drop procedure dbo.spProyectoDInfo
GO
CREATE PROCEDURE spProyectoDInfo
			@ID	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa			varchar(5),
    @ConsiderarAvanceActual	bit,
    @FasesInformativas		bit

  SELECT @Empresa = Empresa, @ConsiderarAvanceActual = ConsiderarAvanceActual FROM Proyecto WHERE ID = @ID
  SELECT @FasesInformativas = ISNULL(ProyFasesInformativas, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  IF @FasesInformativas = 1
    SELECT Actividad, 
           'Rama' = dbo.fnActRama(Actividad), 
           'Predecesora' = ISNULL(NULLIF(RTRIM(Predecesora), ''), 
           dbo.fnRamaPredecesora(@ID, Actividad)), 
           EsFase, 
           'Duracion' = CASE WHEN @ConsiderarAvanceActual = 1 THEN ROUND(Duracion - ISNULL(dbo.fnR3(100, Duracion, ISNULL(Avance, 0)), 0), 2) ELSE Duracion END,
           DuracionUnidad, 
           Avance,
           CONVERT(float, NULL) AS DuracionDias, 
           CONVERT(datetime, NULL) AS Comienzo, 
           CONVERT(datetime, NULL) AS Fin,
	   ComienzoEsp
      FROM ProyectoD
     WHERE ID = @ID AND EsFase = 0
     ORDER BY Predecesora, Actividad
  ELSE
  IF NOT EXISTS(SELECT * FROM ProyectoD WHERE ID = @ID AND EsFase = 0)
    SELECT Actividad, 
           'Rama' = dbo.fnActRama(Actividad), 
           'Predecesora' = ISNULL(NULLIF(RTRIM(Predecesora), ''), 
           dbo.fnRamaPredecesora(@ID, Actividad)), 
           EsFase, 
           Duracion, 
           DuracionUnidad, 
           Avance,
           CONVERT(float, NULL) AS DuracionDias, 
           CONVERT(datetime, NULL) AS Comienzo, 
           CONVERT(datetime, NULL) AS Fin,
	   ComienzoEsp
      FROM ProyectoD
     WHERE ID = @ID AND Actividad IS NULL     
  ELSE 
    SELECT Actividad, 
           'Rama' = dbo.fnActRama(Actividad), 
           'Predecesora' = ISNULL(NULLIF(RTRIM(Predecesora), ''), 
           dbo.fnRamaPredecesora(@ID, Actividad)), 
           EsFase, 
           'Duracion' = CASE WHEN @ConsiderarAvanceActual = 1 THEN ROUND(Duracion - ISNULL(dbo.fnR3(100, Duracion, ISNULL(Avance, 0)), 0), 2) ELSE Duracion END,
           DuracionUnidad, 
           Avance,
           CONVERT(float, NULL) AS DuracionDias, 
           CONVERT(datetime, NULL) AS Comienzo, 
           CONVERT(datetime, NULL) AS Fin,
	   ComienzoEsp
      FROM ProyectoD
     WHERE ID = @ID
     ORDER BY Orden
  RETURN
END
GO

/**************** spProyectoGantt ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoGantt') and type = 'P') drop procedure dbo.spProyectoGantt
GO
CREATE PROCEDURE spProyectoGantt
    @ID int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @PermiteEdicion bit,
    @MostrarRecursos bit
  SELECT @PermiteEdicion = 0, @MostrarRecursos = 0
 
  SELECT 'Proyecto' = dbo.fnXMLValor2(Proyecto), Comienzo, Fin, 'PermiteEdicion' = @PermiteEdicion, 'MostrarRecursos' = @MostrarRecursos
    FROM Proyecto
   WHERE ID = @ID
 
  RETURN
END
GO

/**************** spProyectoGanttD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoGanttD') and type = 'P') drop procedure dbo.spProyectoGanttD
GO
CREATE PROCEDURE spProyectoGanttD
    @ID int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Color varchar(50)
  SELECT @Color = NULL
  SELECT Actividad, 'Asunto' = dbo.fnXMLValor2(Asunto), EsFase, DuracionDias, Comienzo, Fin, 'Color' = @Color, Avance  --, 'EsFaseAgrupadora' = dbo.fnEsFaseAgrupadora(ID, Actividad, EsFase)
    FROM ProyectoD
   WHERE ID = @ID
   ORDER BY Orden
 
  RETURN
END
GO

-- spProyectoDesarrolloLista 'ALDEN', 'PENDIENTE'
/**************** spProyectoDesarrolloLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDesarrolloLista') and type = 'P') drop procedure dbo.spProyectoDesarrolloLista
GO
CREATE PROCEDURE spProyectoDesarrolloLista
				@Cliente	varchar(10),
				@Estatus	varchar(15)
--//WITH ENCRYPTION
AS BEGIN
  SELECT ID, Proyecto, Comienzo, Fin, Avance
    FROM Proyecto
   WHERE Cliente = @Cliente AND Estatus = @Estatus
  
  RETURN
END
GO

-- spProyectoDesarrolloInfo 104
/**************** spProyectoDesarrolloInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDesarrolloInfo') and type = 'P') drop procedure dbo.spProyectoDesarrolloInfo
GO
CREATE PROCEDURE spProyectoDesarrolloInfo
				@ID		int
--//WITH ENCRYPTION
AS BEGIN
  SELECT p.Proyecto, d.Problema, d.Solucion, p.Comentarios
    FROM Proyecto p
    LEFT OUTER JOIN ProyectoDesarrollo d ON d.ID = p.ID
   WHERE p.ID = @ID
  RETURN
END
GO

-- spProyectoDesarrolloInfo2 104
/**************** spProyectoDesarrolloInfo2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDesarrolloInfo2') and type = 'P') drop procedure dbo.spProyectoDesarrolloInfo2
GO
CREATE PROCEDURE spProyectoDesarrolloInfo2
				@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Proyecto		varchar(50),
    @Comienzo		varchar(50),
    @Fin		varchar(50),
    @Avance		varchar(50),
    @FechaEmision	varchar(50),
    @FechaRequerida	varchar(50),
    @Cliente		varchar(10),
    @Empresa		varchar(5),
    @Version		varchar(50),
    @Tipo		varchar(50),
    @Causa		varchar(100),
    @Clase1		varchar(50),
    @Clase2		varchar(50),
    @Clase3		varchar(50),
    @Clase4		varchar(50),
    @Clase5		varchar(50)

  CREATE TABLE #Info2 (ID int IDENTITY(1,1) NOT NULL PRIMARY KEY, Campo varchar(50) COLLATE Database_Default NULL, Valor varchar(100) COLLATE Database_Default NULL)


  SELECT @Proyecto = p.Proyecto, 
         @Comienzo = dbo.fnDateTimeToDDMMMAA(p.Comienzo), 
         @Fin = dbo.fnDateTimeToDDMMMAA(p.Fin), 
         @Avance = CONVERT(varchar, p.Avance), 
         @FechaEmision = dbo.fnDateTimeToDDMMMAA(p.FechaEmision), 
         @FechaRequerida = dbo.fnDateTimeToDDMMMAA(p.FechaRequerida), 
         @Tipo = d.Tipo, @Causa = d.Causa, @Clase1 = d.Clase1, @Clase2 = d.Clase2, @Clase3 = d.Clase3, @Clase4 = d.Clase4, @Clase5 = d.Clase5, @Version = CONVERT(varchar, d.VersionCliente)
    FROM Proyecto p
    LEFT OUTER JOIN ProyectoDesarrollo d ON d.ID = p.ID
   WHERE p.ID = @ID

  INSERT #Info2 (Campo, Valor) VALUES ('Proyecto', 		@Proyecto)
  INSERT #Info2 (Campo, Valor) VALUES ('Comienzo', 		@Comienzo)
  INSERT #Info2 (Campo, Valor) VALUES ('Fin',      		@Fin)
  INSERT #Info2 (Campo, Valor) VALUES ('Avance',      		@Avance)
  INSERT #Info2 (Campo, Valor) VALUES ('Fecha Emision', 	@FechaEmision)
  INSERT #Info2 (Campo, Valor) VALUES ('Fecha Requerida', 	@FechaRequerida)
  INSERT #Info2 (Campo, Valor) VALUES ('Tipo', 			@Tipo)
  INSERT #Info2 (Campo, Valor) VALUES ('Causa', 		@Causa)
  INSERT #Info2 (Campo, Valor) VALUES ('Clasificacion 1', 	@Clase1)
  INSERT #Info2 (Campo, Valor) VALUES ('Clasificacion 2', 	@Clase2)
  INSERT #Info2 (Campo, Valor) VALUES ('Clasificacion 3', 	@Clase3)
  INSERT #Info2 (Campo, Valor) VALUES ('Clasificacion 4', 	@Clase4)
  INSERT #Info2 (Campo, Valor) VALUES ('Clasificacion 5', 	@Clase5)

  SELECT Campo, Valor 
    FROM #Info2
   ORDER BY ID
  RETURN
END
GO

/**************** spProyectoDesarrolloInfo3 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDesarrolloInfo3') and type = 'P') drop procedure dbo.spProyectoDesarrolloInfo3
GO
CREATE PROCEDURE spProyectoDesarrolloInfo3
				@ID		int
--//WITH ENCRYPTION
AS BEGIN
  SELECT d.Actividad, d.Asunto, d.EsFase, d.Predecesora, d.Tipo, d.Categoria, d.Grupo, d.Familia, 'Duracion' = CONVERT(varchar, d.Duracion)+' '+DuracionUnidad, d.Comienzo, d.Fin, d.Avance, d.Estado
    FROM ProyectoD d
   WHERE d.ID = @ID
  ORDER BY d.ORDEN
  RETURN
END
GO


/**************** spProyectoDiaSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDiaSugerir') and type = 'P') drop procedure dbo.spProyectoDiaSugerir
GO
CREATE PROCEDURE spProyectoDiaSugerir
				@ID		int,
				@FechaD		datetime,
				@FechaA		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasHabiles	varchar(20),
    @Fecha		datetime,
    @DiaSemana		int,
    @ProyectoHorasDia	float,
    @HorasDia		float,
    @Concepto		varchar(50),
    @EsLaborable	bit,
    @Sucursal		int

  SET DATEFIRST 7  

  SELECT @ProyectoHorasDia = HorasDia, @DiasHabiles = DiasHabiles, @Sucursal = Sucursal
    FROM Proyecto
   WHERE ID = @ID

  DELETE ProyectoDia WHERE ID = @ID
  
  SELECT @Fecha = @FechaD
  WHILE @Fecha <= @FechaA
  BEGIN
    SELECT @DiaSemana = DATEPART(weekday, @Fecha)
    SELECT @Concepto = NULL, @EsLaborable = 1
    SELECT @Concepto = Concepto, @EsLaborable = ISNULL(EsLaborable, 0) FROM DiaFestivo WHERE Fecha = @Fecha

    IF (@DiasHabiles = 'LUN-VIE' AND @DiaSemana IN (7,1)) OR 
       (@DiasHabiles = 'LUN-SAB' AND @DiaSemana = 1)
      SELECT @EsLaborable = 0

    IF @EsLaborable = 0 SELECT @HorasDia = 0 ELSE SELECT @HorasDia = @ProyectoHorasDia
    IF @EsLaborable = 0 AND @Concepto IS NULL
      EXEC spDiaSemana @DiaSemana, @Concepto OUTPUT
    INSERT ProyectoDia (ID, Fecha, HorasDia, Concepto, Sucursal) VALUES (@ID, @Fecha, @HorasDia, @Concepto, @Sucursal)
    SELECT @Fecha = DATEADD(day, 1, @Fecha)
  END

  RETURN
END
GO
/*
declare
  @DiasNoHabiles int
  EXEC spProyectoDiasNoHabiles 2, '25/9/2007', '10/10/2007', @DiasNoHabiles OUTPUT
select @DiasNoHabiles

-- select * from proyectodia where id = 2
*/

/**************** spProyectoDiasNoHabiles ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDiasNoHabiles') and type = 'P') drop procedure dbo.spProyectoDiasNoHabiles
GO             
CREATE PROCEDURE spProyectoDiasNoHabiles
		    @ID			int,
                    @FechaD		datetime,
                    @FechaA		datetime,
		    @DiasNoHabiles	int	      OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasHabiles	varchar(20),
    @Fecha		datetime,
    @DiaSemana		int,
    @ProyectoHorasDia	float,
    @HorasDia		float,
    @EsLaborable	bit,
    @Sucursal		int

  SET DATEFIRST 7  

  SELECT @DiasNoHabiles = 0, @FechaD = dbo.fnFechaSinHora(@FechaD), @FechaA = dbo.fnFechaSinHora(@FechaA)
  SELECT @ProyectoHorasDia = HorasDia, @DiasHabiles = DiasHabiles, @Sucursal = Sucursal
    FROM Proyecto
   WHERE ID = @ID

  SELECT @Fecha = @FechaD
  WHILE @Fecha <= @FechaA
  BEGIN
    SELECT @EsLaborable = 1
    SELECT @HorasDia = ISNULL(HorasDia, 0) FROM ProyectoDia WHERE ID = @ID AND Fecha = @Fecha
    IF @@ROWCOUNT = 0
    BEGIN
      SELECT @DiaSemana = DATEPART(weekday, @Fecha)
      SELECT @EsLaborable = ISNULL(EsLaborable, 0) FROM DiaFestivo WHERE Fecha = @Fecha

      IF (@DiasHabiles = 'LUN-VIE' AND @DiaSemana IN (7,1)) OR 
         (@DiasHabiles = 'LUN-SAB' AND @DiaSemana = 1)
        SELECT @EsLaborable = 0
    END ELSE
      IF @HorasDia = 0 SELECT @EsLaborable = 0

    IF @EsLaborable = 0 SELECT @DiasNoHabiles = @DiasNoHabiles + 1

    SELECT @Fecha = DATEADD(day, 1, @Fecha)
  END

  RETURN
END
GO

/**************** spProyectoNuevo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoNuevo') and type = 'P') drop procedure dbo.spProyectoNuevo
GO
CREATE PROCEDURE spProyectoNuevo
			@Estacion 	int,
			@ID		int,
			@Plantilla	varchar(50),
			@Sucursal	int,
			@EsSubPlantilla	bit	     = 0,
			@Actividad	varchar(50)  = NULL,
			@Orden		varchar(255) = NULL,
                        @Predecesora    varchar(50)  = NULL,
			@Reemplazar	varchar(20)  = 'SI'
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SubPlantilla	varchar(50)

  IF @EsSubPlantilla = 0 AND UPPER(@Reemplazar) = 'SI'
  BEGIN
    DELETE ProyectoRecurso WHERE ID = @ID
    DELETE ProyectoD WHERE ID = @ID
    DELETE ProyectoDRecurso WHERE ID = @ID
  END

  INSERT ProyectoD (
         ID,  
         Sucursal,
         Actividad,                        
         Orden,                    
         Predecesora,                        
         EsFase, Clave, Asunto, Tipo, Categoria, Grupo, Familia, Duracion, DuracionUnidad, Estado, Prioridad)
  SELECT @ID, @Sucursal,
         CASE WHEN @EsSubPlantilla = 1 THEN @Actividad + '.' + Actividad ELSE Actividad END,
         CASE WHEN @EsSubPlantilla = 1 THEN @Orden + '.' + Orden ELSE Orden END,
         CASE WHEN @EsSubPlantilla = 1 AND NULLIF(RTRIM(Predecesora), '') IS NULL     THEN @Predecesora 
              WHEN @EsSubPlantilla = 1 AND NULLIF(RTRIM(Predecesora), '') IS NOT NULL THEN @Actividad + '.' + Predecesora 
              ELSE Predecesora 
         END,
         EsFase, Clave, Asunto, Tipo, Categoria, Grupo, Familia, Duracion, DuracionUnidad, 'No comenzada', 'Normal'
    FROM PlantillaProyectoD
   WHERE Plantilla = @Plantilla

  INSERT ProyectoDRecurso (ID, Sucursal, Actividad, Recurso)
  SELECT @ID, @Sucursal, CASE WHEN @EsSubPlantilla = 1 THEN @Actividad + '.' + Actividad ELSE Actividad END, Recurso
    FROM PlantillaProyectoDRecurso
   WHERE Plantilla = @Plantilla 

  INSERT ProyectoDRecurso (ID, Sucursal, Actividad, Recurso)
  SELECT @ID, @Sucursal, CASE WHEN @EsSubPlantilla = 1 THEN @Actividad + '.' + Actividad ELSE Actividad END, RecursoOmision
    FROM PlantillaProyectoD
   WHERE Plantilla = @Plantilla AND NULLIF(RTRIM(RecursoOmision), '') IS NOT NULL AND EsFase = 0
     AND RecursoOmision NOT IN (SELECT Recurso FROM ProyectoDRecurso WHERE ID = @ID) 

  INSERT ProyectoRecurso (
         ID,  Sucursal,  Recurso,   Estatus, Rol,   HorasDia,   PrecioHora,   CostoHora)
  SELECT @ID, @Sucursal, r.Recurso, 'ALTA',  r.Rol, r.HorasDia, r.PrecioHora, r.CostoHora
    FROM PlantillaProyectoD p
    JOIN Recurso r ON r.Recurso = p.RecursoOmision
   WHERE p.Plantilla = @Plantilla 
   GROUP BY r.Recurso, r.Rol, r.HorasDia, r.PrecioHora, r.CostoHora

  INSERT ProyectoRecurso (
         ID,  Sucursal,  Recurso,   Estatus, Rol,   HorasDia,   PrecioHora,   CostoHora)
  SELECT @ID, @Sucursal, r.Recurso, 'ALTA',  r.Rol, r.HorasDia, r.PrecioHora, r.CostoHora
    FROM PlantillaProyectoDRecurso p
    JOIN Recurso r ON r.Recurso = p.Recurso
   WHERE p.Plantilla = @Plantilla AND p.Recurso NOT IN (SELECT Recurso FROM ProyectoRecurso WHERE ID = @ID)
   GROUP BY r.Recurso, r.Rol, r.HorasDia, r.PrecioHora, r.CostoHora

  DECLARE crPlantilla CURSOR LOCAL FOR
   SELECT Actividad, Orden, NULLIF(RTRIM(SubPlantilla), ''), NULLIF(RTRIM(Predecesora), '')
     FROM PlantillaProyectoD
    WHERE Plantilla = @Plantilla AND NULLIF(RTRIM(SubPlantilla), '') IS NOT NULL AND EsFase = 1
  OPEN crPlantilla
  FETCH NEXT FROM crPlantilla INTO @Actividad, @Orden, @SubPlantilla, @Predecesora
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spProyectoNuevo @Estacion, @ID, @SubPlantilla, @Sucursal, @EsSubPlantilla = 1, @Actividad = @Actividad, @Orden = @Orden, @Predecesora = @Predecesora

    FETCH NEXT FROM crPlantilla INTO @Actividad, @Orden, @SubPlantilla, @Predecesora
  END
  CLOSE crPlantilla
  DEALLOCATE crPlantilla

  RETURN
END
GO

/************** spProyectoDRecursoActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDRecursoActualizar') and type = 'p') drop procedure spProyectoDRecursoActualizar
GO
CREATE PROCEDURE spProyectoDRecursoActualizar
                @ID             int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Actividad          varchar(50),
    @Recurso            varchar(10),
    @Comienzo           datetime,
    @Fin                datetime

  UPDATE ProyectoDRecurso
     SET Comienzo = ProyectoD.Comienzo, Fin = ProyectoD.Fin
    FROM ProyectoD
   WHERE ProyectoD.ID = ProyectoDRecurso.ID 
     AND ProyectoD.Actividad = ProyectoDRecurso.Actividad
     AND ProyectoDRecurso.ID = @ID

  DECLARE crRecursoActualizar CURSOR LOCAL STATIC FOR
    SELECT Recurso
      FROM ProyectoDRecurso
     WHERE ID = @ID
     GROUP BY Recurso

  OPEN crRecursoActualizar
  FETCH NEXT FROM crRecursoActualizar INTO @Recurso
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spProyectoRecursoActualizar @ID, @Recurso
    END
    FETCH NEXT FROM crRecursoActualizar INTO @Recurso
  END
  CLOSE crRecursoActualizar
  DEALLOCATE crRecursoActualizar

  RETURN
END
GO

/**************** spProyectoRecursoActualizar ***********************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoRecursoActualizar') and type = 'p') drop procedure spProyectoRecursoActualizar
GO
CREATE PROCEDURE spProyectoRecursoActualizar
                @ID             int,
                @Recurso        varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Comienzo           datetime,
    @Fin                datetime,
    @TieneMovimientos   bit,
    @Estatus            varchar(15)

  SELECT @Estatus = Estatus FROM Proyecto WHERE ID = @ID

  SELECT @Comienzo = MIN(Comienzo) FROM ProyectoDRecurso WHERE ID = @ID AND Recurso = @Recurso
  SELECT @Fin = MAX(Fin) FROM ProyectoDRecurso WHERE ID = @ID AND Recurso = @Recurso

  IF NOT EXISTS (SELECT * FROM ProyectoD d JOIN ProyectoDRecurso r ON d.ID = r.ID AND d.Actividad = r.Actividad WHERE d.ID = @ID AND r.Recurso = @Recurso)
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
      SELECT @TieneMovimientos = 0
    ELSE
      SELECT @TieneMovimientos = 1
  ELSE
    SELECT @TieneMovimientos = 1
    
  UPDATE ProyectoRecurso 
     SET Comienzo = @Comienzo, Fin = @Fin, TieneMovimientos = @TieneMovimientos
   WHERE ID = @ID
     AND Recurso = @Recurso

  RETURN
END
GO

/**************** spProyectoDAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDAsignar') and type = 'P') drop procedure dbo.spProyectoDAsignar
GO
CREATE PROCEDURE spProyectoDAsignar
                        @ID     	int,
			@Estacion	int,
			@Recurso	varchar(10),
			@Accion		varchar(20) = NULL,
			@RecursoA	varchar(10) = NULL,
			@DesAsignar	bit	    = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Actividad		varchar(50),
    @EsFase             int,
    @Comienzo           datetime,
    @Fin                datetime,
    @Sucursal		int

  SELECT @Accion = UPPER(@Accion), @Recurso = NULLIF(RTRIM(@Recurso), '')
  SELECT @Sucursal = Sucursal FROM Proyecto WHERE ID = @ID

  IF @DesAsignar = 1
    DELETE ProyectoDRecurso           
     WHERE ID = @ID AND Actividad IN (SELECT Clave FROM ListaSt WHERE Estacion = @Estacion)
	 
  IF ISNULL(@Accion,'') IN ('', 'ASIGNAR')
  BEGIN
    IF NOT EXISTS(SELECT * FROM ProyectoRecurso WHERE ID = @ID AND Recurso = @Recurso) 
      INSERT ProyectoRecurso (
             ID,  Sucursal,  Recurso,  Estatus, Rol, HorasDia, PrecioHora, CostoHora)
      SELECT @ID, @Sucursal, @Recurso, 'ALTA',  Rol, HorasDia, PrecioHora, CostoHora
        FROM Recurso
       WHERE Recurso = @Recurso

    INSERT ProyectoDRecurso ( ID,  Actividad,  Recurso,   Comienzo,  Fin)
    SELECT @ID, ListaSt.Clave, @Recurso, ProyectoD.Comienzo, ProyectoD.Fin
      FROM ListaSt
      JOIN ProyectoD ON ProyectoD.ID = @ID AND ProyectoD.Actividad = ListaSt.Clave AND ProyectoD.EsFase = 0
     WHERE ListaSt.Estacion = @Estacion 
       AND NOT EXISTS (SELECT * FROM ProyectoDRecurso WHERE Actividad = ListaSt.Clave AND Recurso = @Recurso AND ID = @ID)

    EXEC spProyectoRecursoActualizar @ID, @Recurso
  END ELSE
  IF ISNULL(@Accion,'') = 'DESASIGNAR' 
  BEGIN
    IF @Recurso IS NULL
      DELETE ProyectoDRecurso           
       WHERE ID = @ID 
         AND Actividad IN (SELECT Clave FROM ListaSt WHERE Estacion = @Estacion)
    ELSE
      DELETE ProyectoDRecurso           
       WHERE ID = @ID 
         AND Recurso = @Recurso
         AND Actividad IN (SELECT Clave FROM ListaSt WHERE Estacion = @Estacion)
  END

  DELETE ListaSt WHERE Estacion = @Estacion

  RETURN
END
GO

-- REQ PROYECTOS
-- Se incluye para poder asignar/desasignar Recursos para una sola Actividad
/**************** spProyectoDAsignarAct ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDAsignarAct') and type = 'P') drop procedure dbo.spProyectoDAsignarAct
GO
CREATE PROCEDURE spProyectoDAsignarAct
            @ID     	int,
			@Actividad	varchar(50),
			@Recurso	varchar(10),
			@Accion		varchar(20) = NULL,
			@RecursoA	varchar(10) = NULL,
			@DesAsignar	bit	    = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    --@Actividad		varchar(50),
    @EsFase             int,
    @Comienzo           datetime,
    @Fin                datetime,
    @Sucursal		int

  SELECT @Accion = UPPER(@Accion), @Recurso = NULLIF(RTRIM(@Recurso), '')
  SELECT @Sucursal = Sucursal FROM Proyecto WHERE ID = @ID

  IF @DesAsignar = 1
    DELETE ProyectoDRecurso           
     WHERE ID = @ID AND Actividad = @Actividad
	 
  IF ISNULL(@Accion,'') IN ('', 'ASIGNAR')
  BEGIN
    IF NOT EXISTS(SELECT * FROM ProyectoRecurso WHERE ID = @ID AND Recurso = @Recurso) 
      INSERT ProyectoRecurso (
             ID,  Sucursal,  Recurso,  Estatus, Rol, HorasDia, PrecioHora, CostoHora)
      SELECT @ID, @Sucursal, @Recurso, 'ALTA',  Rol, HorasDia, PrecioHora, CostoHora
        FROM Recurso
       WHERE Recurso = @Recurso

    INSERT ProyectoDRecurso ( ID,  Actividad,  Recurso,   Comienzo,  Fin)
    SELECT @ID, ProyectoD.Actividad, @Recurso, ProyectoD.Comienzo, ProyectoD.Fin
      FROM ProyectoD 
	 WHERE ProyectoD.ID = @ID AND ProyectoD.Actividad = @Actividad AND ProyectoD.EsFase = 0
       AND NOT EXISTS (SELECT * FROM ProyectoDRecurso WHERE Actividad = @Actividad AND Recurso = @Recurso AND ID = @ID)

    EXEC spProyectoRecursoActualizar @ID, @Recurso
  END ELSE
  IF ISNULL(@Accion,'') = 'DESASIGNAR' 
  BEGIN
    IF @Recurso IS NULL
      DELETE ProyectoDRecurso           
       WHERE ID = @ID 
         AND Actividad = @Actividad
    ELSE
      DELETE ProyectoDRecurso           
       WHERE ID = @ID 
         AND Recurso = @Recurso
         AND Actividad = @Actividad
  END

  RETURN
END
GO


--REQ PROYECTOS
--Enviar Actividades del Proyecto a Gestion
/**************** spProyectoGestionGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoGestionGenerar') and type = 'P') drop procedure dbo.spProyectoGestionGenerar
GO
CREATE PROC spProyectoGestionGenerar
			@ID					int,
			@Mov				varchar(20),
			@MovID				varchar(20),
			@Empresa			varchar(5),  
			@Sucursal			int,
			@Usuario			varchar(15),
			@Proyecto			varchar(50),
			@UEN				int,
			@Observaciones		varchar(100),

			@Actividad			varchar(50),
			@Asunto             varchar(100),
			@PorcentajeAvance	float,
			@Comentarios		varchar(max),
			@Comienzo   		datetime,
			@Conclusion			datetime,

			@IDGestion			int,
			@Ok					int			 = NULL OUTPUT,
			@OkRef				varchar(255) = NULL OUTPUT  
--//WITH ENCRYPTION  
AS 
BEGIN  
  DECLARE 
	      @Recurso          varchar(10),
		  @NombreRecurso	varchar(100),
		  @Descripcion      varchar(255),
		  @MovGestion		varchar(20),
		  @FechaEmision		datetime,
		  @Concepto			varchar(50),
		  @ProyTareaEstado	varchar(30),
		  @Estatus			varchar(15),
		  @Avance			float,
		  @OkDesc           varchar(255),
		  @OkTipo           varchar(50),
		  @MovGES			varchar(50),
		  @GeneraMov		varchar(20),
		  @GeneraMovID		varchar(20)

  SELECT @FechaEmision = GETDATE()
  SELECT @Recurso = Recurso FROM ProyectoDRecurso WHERE ID = @ID AND Actividad = @Actividad  
  EXEC spExtraerFecha @FechaEmision OUTPUT

  IF ISNULL(@Recurso,'') = '' 
    SELECT @Ok = 55105, @OkRef = 'Actividad: ' + ISNULL(@Actividad,'')
    
  IF @IDGestion IS NOT NULL
    SELECT @Ok = 14083, @OkRef = 'Actividad: ' + ISNULL(@Actividad,'')    
  
  IF YEAR(@Comienzo)  = 1899 SELECT @Comienzo = NULL
  --BUG18507
  IF YEAR(@Conclusion) = 1899 SELECT @Conclusion = NULL  
  
  IF @Ok IS NULL 
  BEGIN
    SELECT @NombreRecurso = Nombre FROM Recurso WHERE Recurso=@Recurso
    
    SELECT @Descripcion = @Actividad + ' ' + @Asunto
    
    SELECT @MovGestion = GESTarea FROM EmpresaCfgMov WHERE Empresa = @Empresa
    
    SELECT @ProyTareaEstado = ProyTareaEstado FROM EmpresaCfg WHERE Empresa = @Empresa

    SELECT @Comentarios = '{\rtf1\ansi\ansicpg1252\deff0{\fonttbl{\f0\fnil Tahoma;}{\f1\fnil\fcharset0 Tahoma;}}  {\colortbl ;\red0\green0\blue0;}  \viewkind4\uc1\pard\cf1\lang2058\f0\fs20  \f1 ' + ISNULL(@Comentarios, '') + '\f0   \par }  '

    INSERT INTO Gestion(
			   Empresa,  Mov,         FechaEmision,  Concepto,  Proyecto,  UEN,  Usuario, Referencia,                         Observaciones,  Estatus,     OrigenTipo,  Origen,  OrigenID,  Sucursal,  Asunto,       Comentarios,   FechaD,    FechaA,       Estado,           Avance,           SucursalOrigen,  SucursalDestino,  PROYID)
	   SELECT @Empresa, @MovGestion, @FechaEmision, @Concepto, @Proyecto, @UEN, @Usuario, RTRIM(@Mov) + ' ' + RTRIM(@MovID), @Observaciones, 'SINAFECTAR', 'PROY',     @Mov,    @MovID,    @Sucursal,  @Descripcion, @Comentarios, @Comienzo, @Conclusion,  @ProyTareaEstado, @PorcentajeAvance, @Sucursal,       @Sucursal,      @ID

    SELECT @IDGestion = SCOPE_IDENTITY()
   
    INSERT INTO MovGrupo (Modulo, ModuloID, Recurso) 
                 VALUES ('GES', @IDGestion, @Recurso)  
   
    EXEC spAfectar 'GES', @IDGestion, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion=@@SPID, @EnSilencio=1, @Conexion = 0, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @Avance = Avance, @Estatus = Estatus, @MovGES = RTRIM(Mov)+' '+RTRIM(MovID), @GeneraMov = Mov, @GeneraMovID = MovID FROM Gestion WHERE ID=@IDGestion     

    EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'PROY', @ID, @Mov, @MovID, 'GES', @IDGestion, @GeneraMov, @GeneraMovID, @Ok OUTPUT
      
    UPDATE ProyectoD
       SET IDGestion=@IDGestion,  
           Avance = @Avance,
           Comienzo = @FechaEmision,
           Usuario = @Usuario,
           MovGestion = @MovGES
     WHERE ID = @ID 
       AND Actividad = @Actividad
     
    IF @@ERROR <> 0 SELECT @Ok = 1
  END

  IF @Ok IS NULL 
    SELECT @OkRef = NULL
  ELSE
    -- Leer el Mensaje
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok  
  
   -- Mostrar el Estatus de la Afectacion
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, @IDGestion

  RETURN  
END  
GO

--REQ PROYECTOS
--Enviar Actividades del Proyecto a Gestion en Lote
/**************** spProyectoGestionGenerarLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoGestionGenerarLote') and type = 'P') drop procedure dbo.spProyectoGestionGenerarLote
GO
CREATE PROC spProyectoGestionGenerarLote
 @Estacion   int,
 @ID         int
WITH ENCRYPTION
AS BEGIN
DECLARE
 @Actividad		varchar(50),

 @Mov				varchar(20),
 @MovID				varchar(20),
 @Empresa			varchar(5),  
 @Sucursal			int,
 @Usuario			varchar(15),
 @Proyecto			varchar(50),
 @UEN				int,
 @Observaciones		varchar(100),
  
 @Asunto            varchar(100),
 @PorcentajeAvance	float,
 @Comentarios		varchar(max),
 @Comienzo   		datetime,
 @Conclusion		datetime,

 @IDGestion			int,
 @Ok				int,	
 @OkRef				varchar(255)

 SELECT @Mov = Mov,  @MovID = MovID, @Empresa = Empresa,  @Sucursal = Sucursal, @Usuario = Usuario, @Proyecto = Proyecto, @UEN = UEN, @Observaciones = Observaciones 
   FROM Proyecto WHERE ID = @ID

 SELECT @Actividad = MIN(ListaSt.Clave) 
   FROM ProyectoD JOIN ListaSt ON ProyectoD.ID = @ID AND ProyectoD.Actividad = ListaSt.Clave WHERE ListaSt.Estacion = @Estacion AND ISNULL(ProyectoD.EsFase,0) = 0
 WHILE @Actividad IS NOT NULL
 BEGIN
  SELECT @Asunto = Asunto, @PorcentajeAvance = Avance, @Comentarios = Comentarios, @Comienzo = Comienzo, @Conclusion = Fin, @IDGestion = IDGestion FROM ProyectoD WHERE ID = @ID AND Actividad = @Actividad

  EXEC spProyectoGestionGenerar @ID, @Mov, @MovID, @Empresa, @Sucursal, @Usuario, @Proyecto, @UEN, @Observaciones, @Actividad, @Asunto, @PorcentajeAvance, @Comentarios, @Comienzo, @Conclusion, @IDGestion

  SELECT @Actividad = MIN(ListaSt.Clave) 
   FROM ProyectoD JOIN ListaSt ON ProyectoD.ID = @ID AND ProyectoD.Actividad = ListaSt.Clave WHERE ListaSt.Estacion = @Estacion AND ISNULL(ProyectoD.EsFase,0) = 0 AND ListaSt.Clave > @Actividad
 END

RETURN
END
GO

/**************** spProyectoDTransferir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDTransferir') and type = 'P') drop procedure dbo.spProyectoDTransferir
GO
CREATE PROCEDURE spProyectoDTransferir
			@ID     	int,
			@RecursoD	varchar(10),
			@RecursoA	varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @Conteo	int,
     @Actividad varchar(50)

  IF EXISTS(SELECT * FROM ProyectoRecurso WHERE ID = @ID AND Recurso = @RecursoA)
  BEGIN
    SELECT @Conteo = 0
    DECLARE crTransferirProyectoD CURSOR LOCAL FOR 
      SELECT d.Actividad
        FROM ProyectoDRecurso r
        JOIN ProyectoD d ON d.Actividad = r.Actividad AND d.ID = r.ID AND UPPER(d.Estado) NOT IN ('COMPLETADA', 'CANCELADA', 'ELIMINADA')
       WHERE r.ID = @ID AND r.Recurso = @RecursoD

    OPEN crTransferirProyectoD 
    FETCH NEXT FROM crTransferirProyectoD INTO @Actividad
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      IF @@FETCH_STATUS <> -2
      BEGIN
        UPDATE ProyectoDRecurso SET Recurso = UPPER(@RecursoA) WHERE CURRENT OF crTransferirProyectoD
        SELECT @Conteo = @Conteo + 1          
      END
      FETCH NEXT FROM crTransferirProyectoD INTO @Actividad
    END
    CLOSE crTransferirProyectoD 
    DEALLOCATE crTransferirProyectoD 

    IF @Conteo > 0
    BEGIN
      EXEC spProyectoRecursoActualizar @ID, @RecursoD		
      EXEC spProyectoRecursoActualizar @ID, @RecursoA
    END

    SELECT CONVERT(varchar, @Conteo) + ' Actividad(es) Transferidas.'
  END ELSE
    SELECT 'Este Recurso No Esta Asignado al Proyecto '+@RecursoA

  RETURN
END
GO

/********* spProyectoRecursoDesasignar **************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoRecursoDesasignar') and type = 'p') drop procedure spProyectoRecursoDesasignar
Go
CREATE PROCEDURE spProyectoRecursoDesasignar
                @ID             int,
                @Recurso        varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DELETE ProyectoDRecurso 
    FROM ProyectoDRecurso r
    JOIN ProyectoD d ON d.ID = r.ID AND d.Actividad = r.Actividad
   WHERE r.ID = @ID 
     AND r.Recurso = @Recurso 
     AND UPPER(d.Estado) NOT IN ('COMPLETADA', 'CANCELADA', 'ELIMINADA')

  EXEC spProyectoRecursoActualizar @ID, @Recurso

  RETURN
END
GO


/********************* dbo.spProyectoDCambiarEstado ***********/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDCambiarEstado') and type = 'p') drop procedure dbo.spProyectoDCambiarEstado
GO
CREATE PROCEDURE spProyectoDCambiarEstado
                		@ID             	int,
                		@Actividad              varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Rama               varchar(50)
  
  SELECT @Rama = dbo.fnActRama(@Actividad)
  
  IF @Rama IS NOT NULL
  BEGIN
    -- Si todas las actividades tienen el mismo estatus es el que pone en la fase
    IF (SELECT COUNT(DISTINCT Estado) FROM ProyectoD WHERE ID = @ID AND dbo.fnActRama(Actividad) = @Rama) = 1
      UPDATE ProyectoD 
         SET Estado = (SELECT DISTINCT Estado FROM ProyectoD WHERE ID = @ID AND dbo.fnActRama(Actividad) = @Rama)
       WHERE ID = @ID AND Actividad = @Rama
    ELSE
    -- Si todas las actividades estan copmpletadas, canceladas o eliminadas completa la fase
    IF NOT EXISTS (SELECT * FROM ProyectoD WHERE ID = @ID AND dbo.fnActRama(Actividad) = @Rama AND Estado NOT IN ('COMPLETADA', 'CANCELADA', 'ELIMINADA'))    
      UPDATE ProyectoD SET Estado = 'Completada' WHERE ID = @ID AND Actividad = @Rama
    ELSE
    -- Si hay alguna actividad distinta de No Comenzada le pone a la fase en curso
    IF EXISTS (SELECT * FROM ProyectoD WHERE ID = @ID AND dbo.fnActRama(Actividad) = @Rama AND Estado NOT IN ('NO COMENZADA'))
      UPDATE ProyectoD SET Estado = 'En Curso' WHERE ID = @ID AND Actividad = @Rama
  END
  
  RETURN
END
GO

/**************** spProyectoRecalcular ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoRecalcular') and type = 'P') drop procedure dbo.spProyectoRecalcular
GO
CREATE PROCEDURE spProyectoRecalcular
			@ID	        int,
			@xml		text

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Estatus		varchar(15),
    @Avance		float,
    @ixml		int,
    @Comienzo		datetime,
    @Fin		datetime,
    @Empresa		varchar(5),
    @FasesInformativas	bit,
    @Actividad		varchar(50),
    @DiasNoHabiles	int,
    @DuracionDias	float,
    @DuracionTotal	float,
    @AvanceTotal	float

  SELECT @Empresa = Empresa, @Estatus = Estatus FROM Proyecto WHERE ID = @ID
  SELECT @FasesInformativas = ISNULL(ProyFasesInformativas, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  BEGIN TRANSACTION
  IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'PENDIENTE')
  BEGIN   
    EXEC sp_xml_preparedocument @ixml OUTPUT, @xml

    CREATE TABLE #xml   (
      Actividad           varchar(50)   COLLATE Database_Default NOT NULL PRIMARY KEY,  
      EsFase		  bit		NULL,
      Avance		  float		NULL,
      DuracionDias        float		NULL, 
      Comienzo            datetime	NULL, 
      Fin                 datetime	NULL)

    INSERT #xml (
           Actividad, EsFase, Avance, DuracionDias, Comienzo, Fin) 
    SELECT Actividad, EsFase, Avance, DuracionDias, Comienzo, Fin
      FROM OPENXML (@ixml, 'Proyecto/Actividad') 
      WITH (Actividad varchar(50), EsFase bit, Avance float, DuracionDias float, Comienzo datetime, Fin datetime)

    IF @FasesInformativas = 1
    BEGIN
      DELETE #xml WHERE EsFase = 1
      INSERT #xml (
             Actividad, EsFase, Avance, DuracionDias, Comienzo, Fin) 
      SELECT Actividad, EsFase, Avance, DuracionDias, Comienzo, Fin
        FROM ProyectoD
       WHERE ID = @ID AND EsFase = 1

      DECLARE spProyectoRecalcular CURSOR LOCAL FOR
      SELECT Actividad
        FROM #xml
       WHERE EsFase = 1
      OPEN spProyectoRecalcular
      FETCH NEXT FROM spProyectoRecalcular INTO @Actividad
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN    
          SELECT @Comienzo = NULL, @Fin = NULL
          SELECT @Comienzo = MIN(Comienzo), 
                 @Fin = MAX(Fin), 
		 @DuracionTotal = SUM(DuracionDias), 
		 @AvanceTotal = SUM(ISNULL(Avance, 0.0)*ISNULL(DuracionDias, 0.0)) 
            FROM #xml 
           WHERE Actividad LIKE @Actividad+'.%' AND EsFase = 0
          EXEC spProyectoDiasNoHabiles @ID, @Comienzo, @Fin, @DiasNoHabiles OUTPUT
          SELECT @DuracionDias = DATEDIFF(day, @Comienzo, @Fin) + 1 - @DiasNoHabiles,
                 @Avance =  @AvanceTotal / NULLIF(@DuracionTotal, 0)
          UPDATE #xml
             SET Comienzo = @Comienzo, Fin = @Fin, DuracionDias = @DuracionDias, Avance = ISNULL(ROUND(@Avance, 10), 0.0)
           WHERE CURRENT OF spProyectoRecalcular
        END
        FETCH NEXT FROM spProyectoRecalcular INTO @Actividad
      END
      CLOSE spProyectoRecalcular
      DEALLOCATE spProyectoRecalcular
    END

    UPDATE ProyectoD
       SET Duracion = CASE WHEN a.EsFase = 1 THEN ROUND(x.DuracionDias, 3) ELSE a.Duracion END,          
           DuracionUnidad = CASE WHEN a.EsFase = 1 THEN 'dias' ELSE a.DuracionUnidad END,		
           DuracionDias = x.DuracionDias,
           Avance = CASE WHEN a.EsFase = 1 THEN x.Avance ELSE a.Avance END,
           Comienzo = x.Comienzo,
           Fin = x.Fin,
           Estado = CASE WHEN a.EsFase = 1 AND x.Avance = 100.0 THEN 'Completada' WHEN a.EsFase = 1 AND x.Avance = 0.0 THEN 'No Comenzada' WHEN a.EsFase = 1 AND x.Avance > 0.0 AND x.Avance < 100.0 THEN 'En Curso' ELSE a.Estado END
      FROM ProyectoD a
      JOIN #xml x ON x.Actividad = a.Actividad
     WHERE a.ID = @ID

    --SELECT @Avance = Avance FROM OPENXML (@ixml, 'Proyecto') WITH (Avance float)
    EXEC sp_xml_removedocument @ixml

    SELECT @Comienzo = MIN(Comienzo), 
           @Fin = MAX(Fin),
           @DuracionTotal = SUM(DuracionDias), 
	   @AvanceTotal = SUM(ISNULL(Avance, 0.0)*ISNULL(DuracionDias, 0.0)) 
      FROM #xml 
     WHERE EsFase = 0
    SELECT @Avance =  ROUND(@AvanceTotal / NULLIF(@DuracionTotal, 0), 10)
    IF @Estatus = 'PENDIENTE' AND @Avance = 100.0 SELECT @Estatus = 'CONCLUIDO'
    UPDATE Proyecto SET Avance = @Avance, Comienzo = @Comienzo, Fin = @Fin, Estatus = @Estatus WHERE ID = @ID

    EXEC spProyectoDRecursoActualizar @ID
    EXEC spProyectoDLiberar @ID, NULL
  END

  COMMIT TRANSACTION
  RETURN
END
GO

-- spProyResultado 'Desarrollo M31'
-- select * from proyresultado
/********************* dbo.spProyResultado ***********/
if exists (select * from sysobjects where id = object_id('dbo.spProyResultado') and type = 'p') drop procedure dbo.spProyResultado
GO
CREATE PROCEDURE dbo.spProyResultado
                		@Proyecto	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Modulo		varchar(5),
    @Mov		varchar(20),
    @Tipo		varchar(20),
    @Factor		float,
    @ProyectoOriginal	varchar(50)

  DELETE ProyResultado WHERE Proyecto = @Proyecto

  SELECT @ProyectoOriginal = dbo.fnProyectoOriginal(@Proyecto)

  DECLARE crCfgMovProy CURSOR LOCAL FOR 
    SELECT Modulo, Mov, Tipo, Factor
      FROM CfgMovProy
  OPEN crCfgMovProy
  FETCH NEXT FROM crCfgMovProy INTO @Modulo, @Mov, @Tipo, @Factor
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      IF @Modulo = 'VTAS' 
        INSERT ProyResultado (
               Proyecto,  Empresa, Modulo,  ModuloID, Mov,  MovID, FechaEmision, Tipo,  Costo,                         Venta)
        SELECT @Proyecto, Empresa, @Modulo, ID,       @Mov, MovID, FechaEmision, @Tipo, CostoTotal*TipoCambio*@Factor, Importe*TipoCambio*@Factor
          FROM Venta 
         WHERE Mov = @Mov AND Proyecto = @Proyecto AND Proyecto LIKE @ProyectoOriginal+'%' AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      ELSE
      IF @Modulo = 'INV' 
        INSERT ProyResultado (
               Proyecto,  Empresa, Modulo,  ModuloID, Mov,  MovID, FechaEmision, Tipo,  Costo)
        SELECT @Proyecto, Empresa, @Modulo, ID,       @Mov, MovID, FechaEmision, @Tipo, Importe*TipoCambio*@Factor
          FROM Inv
         WHERE Mov = @Mov AND Proyecto = @Proyecto AND Proyecto LIKE @ProyectoOriginal+'%' AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      ELSE
      IF @Modulo = 'COMS' 
        INSERT ProyResultado (
               Proyecto,  Empresa, Modulo,  ModuloID, Mov,  MovID, FechaEmision, Tipo,  Costo)
        SELECT @Proyecto, Empresa, @Modulo, ID,       @Mov, MovID, FechaEmision, @Tipo, Importe*TipoCambio*@Factor
          FROM Compra
         WHERE Mov = @Mov AND Proyecto = @Proyecto AND Proyecto LIKE @ProyectoOriginal+'%' AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      ELSE
      IF @Modulo = 'GAS' 
        INSERT ProyResultado (
               Proyecto,  Empresa,   Modulo,  ModuloID, Mov,  MovID,   FechaEmision,   Tipo,  Gasto)
        SELECT @Proyecto, e.Empresa, @Modulo, e.ID,     @Mov, e.MovID, e.FechaEmision, @Tipo, SUM(d.Importe)*e.TipoCambio*@Factor
          FROM Gasto e 
          JOIN GastoD d ON d.ID = e.ID
         WHERE e.Mov = @Mov AND d.Proyecto = @Proyecto AND d.Proyecto LIKE @ProyectoOriginal+'%' AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO')
         GROUP BY e.ID, e.Mov, e.MovID, e.FechaEmision, e.Empresa, e.TipoCambio
      ELSE
      IF @Modulo = 'ASIS' 
        INSERT ProyResultado (
               Proyecto,  Empresa,   Modulo,  ModuloID, Mov,  MovID,   FechaEmision,   Tipo,  Costo)
        SELECT @Proyecto, e.Empresa, @Modulo, e.ID,     @Mov, e.MovID, e.FechaEmision, @Tipo, SUM(d.Costo*d.Cantidad)/* *e.TipoCambio*/*@Factor
          FROM Asiste e 
          JOIN AsisteD d ON d.ID = e.ID
         WHERE e.Mov = @Mov AND d.Proyecto = @Proyecto AND d.Proyecto LIKE @ProyectoOriginal+'%' AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO')
         GROUP BY e.ID, e.Mov, e.MovID, e.FechaEmision, e.Empresa, e.TipoCambio
      ELSE
      IF @Modulo = 'CXC' 
        INSERT ProyResultado (
               Proyecto,  Empresa, Modulo,  ModuloID, Mov,  MovID, FechaEmision, Tipo,  Ingresos)
        SELECT @Proyecto, Empresa, @Modulo, ID,       @Mov, MovID, FechaEmision, @Tipo, Importe*TipoCambio*@Factor
          FROM Cxc
         WHERE Mov = @Mov AND Proyecto = @Proyecto AND Proyecto LIKE @ProyectoOriginal+'%' AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      ELSE
      IF @Modulo = 'CXP' 
        INSERT ProyResultado (
               Proyecto,  Empresa, Modulo,  ModuloID, Mov,  MovID, FechaEmision, Tipo,  Egresos)
        SELECT @Proyecto, Empresa, @Modulo, ID,       @Mov, MovID, FechaEmision, @Tipo, Importe*TipoCambio*@Factor
          FROM Cxp
         WHERE Mov = @Mov AND Proyecto = @Proyecto AND Proyecto LIKE @ProyectoOriginal+'%' AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
    END
    FETCH NEXT FROM crCfgMovProy INTO @Modulo, @Mov, @Tipo, @Factor
  END
  CLOSE crCfgMovProy
  DEALLOCATE crCfgMovProy

  UPDATE Proy SET FechaProyResultado = GETDATE() WHERE Proyecto = @Proyecto
END
GO

/********************* dbo.spProyGenerarMovInv ***********/
if exists (select * from sysobjects where id = object_id('dbo.spProyGenerarMovInv') and type = 'p') drop procedure dbo.spProyGenerarMovInv
GO
CREATE PROCEDURE dbo.spProyGenerarMovInv
                		@Proyecto	varchar(50),
				@GenerarMov	varchar(20),	-- AF, INV
				@Mov		varchar(20),
				@Almacen	varchar(10),
				@Articulo	varchar(20),
				@SerieLote	varchar(50),
				@Empresa	varchar(5),
				@Sucursal	int,
				@Usuario	varchar(10),
				@FechaEmision	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok		int,
    @OkRef	varchar(255),
    @AlmTipo	varchar(20),
    @ArtTipo	varchar(20),
    @ID		int,
    @Costo	float,
    @Moneda	varchar(10),
    @TipoCambio	float

  SELECT @Costo = ISNULL(SUM(Costo), 0.0)+ISNULL(SUM(Gasto), 0.0) 
    FROM ProyResultado
   WHERE Proyecto = @Proyecto AND Empresa = @Empresa AND Tipo = 'Real'
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @Ok = NULL, @OkRef = NULL, @Articulo = NULLIF(RTRIM(NULLIF(@Articulo, '0')), ''), @SerieLote = NULLIF(RTRIM(NULLIF(@SerieLote, '0')), '')
  SELECT @AlmTipo = UPPER(Tipo) FROM Alm WHERE Almacen = @Almacen
  SELECT @ArtTipo = UPPER(Tipo) FROM Art WHERE Articulo = @Articulo

  IF @Articulo IS NULL SELECT @Ok = 10530 ELSE
  IF @SerieLote IS NULL SELECT @Ok = 20051 ELSE
  IF @GenerarMov = 'AF'  AND @AlmTipo <> 'ACTIVOS FIJOS' SELECT @Ok = 20441, @OkRef = @Almacen ELSE
  IF @GenerarMov = 'INV' AND @AlmTipo <> 'NORMAL'        SELECT @Ok = 20441, @OkRef = @Almacen ELSE
  IF @GenerarMov = 'AF'  AND @ArtTipo <> 'SERIE'         SELECT @Ok = 44010, @OkRef = @Articulo 
  
  IF @Ok IS NULL
  BEGIN
    INSERT Inv (Empresa, Sucursal, Usuario, FechaEmision, Mov, Almacen, Estatus, Moneda, TipoCambio, Proyecto, RenglonID) VALUES (@Empresa, @Sucursal, @Usuario, @FechaEmision, @Mov, @Almacen, 'CONFIRMAR', @Moneda, @TipoCambio, @Proyecto, 1)
    SELECT @ID = SCOPE_IDENTITY()
    INSERT InvD (ID, Sucursal, Renglon, RenglonID, Articulo, Cantidad, Costo, Almacen) VALUES (@ID, @Sucursal, 2048.0, 1, @Articulo, 1, @Costo, @Almacen)
    INSERT SerieLoteMov (Empresa, Sucursal, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad) VALUES (@Empresa, @Sucursal, 'INV', @ID, 1, @Articulo, '', @SerieLote, 1)
  END

  IF @Ok = NULL
    SELECT 'Se Genero '+@Mov+ ' (por Confirmar)'
  ELSE
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  RETURN
END
GO

/**************** spProyectoDesarrolloAceptar *********************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDesarrolloAceptar') and type = 'p') drop procedure spProyectoDesarrolloAceptar
GO
CREATE PROCEDURE spProyectoDesarrolloAceptar
                @ID             int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Supervisor         varchar(20),
    @Supervisor1        varchar(20),
    @Supervisor2        varchar(20),
    @Supervisor3        varchar(20),
    @Supervisor4        varchar(20),
    @Supervisor5        varchar(20),
    @Estatus            varchar(15)

  SELECT @Estatus = Estatus FROM Proyecto WHERE ID = @ID

  IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
  BEGIN
    SELECT @Supervisor1 = NULL, @Supervisor2 = NULL, @Supervisor3 = NULL, @Supervisor4 = NULL, @Supervisor5 = NULL

    SELECT @Supervisor1 = c.Supervisor
      FROM ProyectoDesarrollo p
      JOIN ProyectoDesarrolloClase1 c ON c.Clase1 = p.Clase1
     WHERE p.ID = @ID

    SELECT @Supervisor2 = c.Supervisor
      FROM ProyectoDesarrollo p
      JOIN ProyectoDesarrolloClase2 c ON c.Clase1 = p.Clase1 AND c.Clase2 = p.Clase2
     WHERE p.ID = @ID

    SELECT @Supervisor3 = c.Supervisor
      FROM ProyectoDesarrollo p
      JOIN ProyectoDesarrolloClase3 c ON c.Clase1 = p.Clase1 AND c.Clase2 = p.Clase2 AND c.Clase3 = p.Clase3
     WHERE p.ID = @ID

    SELECT @Supervisor4 = c.Supervisor
      FROM ProyectoDesarrollo p
      JOIN ProyectoDesarrolloClase4 c ON c.Clase1 = p.Clase1 AND c.Clase2 = p.Clase2 AND c.Clase3 = p.Clase3 AND c.Clase4 = p.Clase4
     WHERE p.ID = @ID

    SELECT @Supervisor5 = c.Supervisor
      FROM ProyectoDesarrollo p
      JOIN ProyectoDesarrolloClase5 c ON c.Clase1 = p.Clase1 AND c.Clase2 = p.Clase2 AND c.Clase3 = p.Clase3 AND c.Clase4 = p.Clase4 AND c.Clase5 = p.Clase5
     WHERE p.ID = @ID

    SELECT @Supervisor1 = NULLIF(RTRIM(@Supervisor1), ''),
           @Supervisor2 = NULLIF(RTRIM(@Supervisor2), ''),
           @Supervisor3 = NULLIF(RTRIM(@Supervisor2), ''),
           @Supervisor4 = NULLIF(RTRIM(@Supervisor2), ''),
           @Supervisor5 = NULLIF(RTRIM(@Supervisor2), '')

    SELECT @Supervisor = ISNULL(@Supervisor5, ISNULL(@Supervisor4, ISNULL(@Supervisor3, ISNULL(@Supervisor2, @Supervisor1))))

    IF @Supervisor IS NOT NULL
      UPDATE Proyecto SET Supervisor = @Supervisor WHERE ID = @ID
  END

  RETURN
END 
GO

/**************** spProyectoVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoVerificar') and type = 'P') drop procedure dbo.spProyectoVerificar
GO
CREATE PROCEDURE spProyectoVerificar
    		    @ID              		int,
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
                        
                    @OrigenTipo                 varchar(5),
                    @Origen                     varchar(20),
                    @OrigenID                   varchar(20),

		    @Estatus			char(15),
		    @EstatusNuevo		char(15),
		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

   	 	    @Proyecto	      		varchar(50),
		    @ProyectoSugerir		varchar(20),
                    @ProyectoReestructurar      varchar(50),
                    @Reestructurar              bit,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ContactoTipo	varchar(20),
    @Prospecto		varchar(10),
    @Cliente		varchar(10),
    @Proveedor		varchar(10),
    @Personal		varchar(10),
    @Agente		varchar(10),
    @Riesgo             varchar(20),
    @ProyectoRama       varchar(50),
    @Supervisor		varchar(10),
    @Comienzo		datetime,
    @OrigenProyecto     varchar(50)

  SELECT @Prospecto = NULLIF(RTRIM(Prospecto), ''), @Cliente = NULLIF(RTRIM(Cliente), ''), @Proveedor = NULLIF(RTRIM(Proveedor), ''), @Personal = NULLIF(RTRIM(Personal), ''), 
         @Agente = NULLIF(RTRIM(Agente), ''), @Supervisor = NULLIF(RTRIM(Supervisor), ''), @Riesgo = NULLIF(RTRIM(Riesgo), ''), @ProyectoRama = NULLIF(RTRIM(ProyectoRama), ''),
         @Comienzo = Comienzo, @ContactoTipo = NULLIF(RTRIM(ContactoTipo), '')
    FROM Proyecto
   WHERE ID = @ID

  -- Validar Origen
  IF @OrigenTipo IS NOT NULL AND @Origen IS NOT NULL AND @OrigenID IS NOT NULL
  BEGIN
    IF @OrigenTipo = 'PROY' AND NOT EXISTS (SELECT * FROM Proyecto WHERE Mov = @Origen AND MovID = @OrigenID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')) 
      SELECT @Ok = 20380
  END

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070

    -- Verificar que no tenga Movimientos Pendientes en el modulo
    IF EXISTS (SELECT * FROM Proyecto WHERE Origen = @Mov AND OrigenID = @MovID AND OrigenTipo = @Modulo AND Estatus IN ('PENDIENTE', 'CONCLUIDO'))
      SELECT @Ok = 30151
  END ELSE
  BEGIN
    IF @Reestructurar = 0
    BEGIN
      IF @ProyectoSugerir = 'ABIERTO'
        IF EXISTS(SELECT * FROM Proy WHERE Proyecto = @Proyecto) OR EXISTS(SELECT * FROM Proyecto WHERE Proyecto = @Proyecto AND Estatus IN ('PENDIENTE', 'CONCLUIDO')) 
          SELECT @Ok = 26025, @OkRef = @Proyecto
    END ELSE
    BEGIN
      IF @ProyectoReestructurar IS NULL
        SELECT @Ok = 15010, @OkRef = 'Movimiento: ' + RTRIM(@Mov) 
      IF NOT EXISTS (SELECT * FROM Proy WHERE Proyecto = @ProyectoReestructurar) AND NOT EXISTS (SELECT * FROM Proyecto WHERE Proyecto = @ProyectoReestructurar AND Estatus = 'PENDIENTE')
        SELECT @Ok = 15012, @OkRef = @Proyecto ELSE
      IF @Ok IS NOT NULL AND (SELECT Estatus FROM Proyecto WHERE Proyecto = @ProyectoReestructurar) = 'REESTRUCTURADO'  
        SELECT @Ok = 15015, @OkRef = @ProyectoReestructurar ELSE
      IF @Ok IS NOT NULL AND (SELECT Estatus FROM Proyecto WHERE Proyecto = @ProyectoReestructurar) = 'BAJA'  
        SELECT @Ok = 26020, @OkRef = @ProyectoReestructurar ELSE
      IF @Ok IS NOT NULL AND (SELECT Estatus FROM Proyecto WHERE Proyecto = @ProyectoReestructurar) = 'BLOQUEADO'  
        SELECT @Ok = 26010, @OkRef = @ProyectoReestructurar 
    END

    IF @Ok IS NULL
    BEGIN
      IF @ContactoTipo IS NULL SELECT @Ok = 40001 ELSE
      IF @ContactoTipo = 'PROSPECTO'  AND @Prospecto    IS NULL SELECT @Ok = 40005 ELSE
      IF @ContactoTipo = 'CLIENTE'    AND @Cliente      IS NULL SELECT @Ok = 40010 ELSE
      IF @ContactoTipo = 'PROVEEDOR'  AND @Proveedor    IS NULL SELECT @Ok = 40020 ELSE
      IF @ContactoTipo = 'PERSONAL'   AND @Personal     IS NULL SELECT @Ok = 40025 ELSE
      IF @ContactoTipo = 'AGENTE'     AND @Agente       IS NULL SELECT @Ok = 20930 ELSE
      IF @ContactoTipo = 'RIESGO'     AND @Riesgo       IS NULL SELECT @Ok = 15050 ELSE
      IF @ContactoTipo = 'PROYECTO'   AND @ProyectoRama IS NULL SELECT @Ok = 15014 ELSE
      IF @ContactoTipo = 'PROYECTO'   AND (SELECT Tipo FROM Proy WHERE Proyecto = @ProyectoRama) = 'SubProyecto' SELECT @Ok = 15020 ELSE
      IF @Comienzo   IS NULL SELECT @Ok = 41020 ELSE
      IF @Supervisor IS NULL SELECT @Ok = 41010 ELSE
      IF NOT EXISTS(SELECT * FROM ProyectoD WHERE ID = @ID)  SELECT @Ok = 60010
    END

    IF @Ok IS NULL
      EXEC spProyectoDVerificar @ID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END

  RETURN
END
GO

--select * from mensajelista where descripcion like '%Proyecto%'
/**************** spProyectoAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoAfectar') and type = 'P') drop procedure dbo.spProyectoAfectar
GO             
CREATE PROCEDURE spProyectoAfectar
    			@ID                		int,

			@Accion				char(20),
			@Base				char(20),
    			@Empresa	      		char(5),
    			@Modulo	      			char(5),
    			@Mov	  	      		char(20),
    			@MovID             		varchar(20)		OUTPUT,
    			@MovTipo     			char(20),
			@MovMoneda			char(10),
			@MovTipoCambio			float,
    			@FechaEmision      		datetime,
    			@FechaAfectacion      		datetime,
    			@FechaConclusion		datetime,

    	 		@Proyecto	      		varchar(50),
			@ProyectoSugerir		varchar(20),
                        @ProyectoReestructurar          varchar(50),
                        @Reestructurar                  bit,

    			@Usuario	      		char(10),
    			@Autorizacion      		char(10),
    			@DocFuente	      		int,
    			@Observaciones     		varchar(255),
    			@Concepto     			varchar(50),
			@Referencia			varchar(50),
    			@Estatus           		char(15),
 	    		@EstatusNuevo	      		char(15),
    			@FechaRegistro     		datetime,
    			@Ejercicio	      		int,
    			@Periodo	      		int,
			@MovUsuario			char(10),
                        
                        @OrigenTipo                     varchar(5),
                        @Origen                         varchar(20),
                        @OrigenID                       varchar(20),

			@Conexion			bit,
                	@SincroFinal			bit,
                	@Sucursal			int,
                	@SucursalDestino		int,
                	@SucursalOrigen			int,

			@CfgContX			bit,
			@CfgContXGenerar		char(20),
			@GenerarPoliza			bit,

			@Generar			bit,
    			@GenerarMov			char(20),
			@GenerarAfectado		bit,
			@IDGenerar			int	     	OUTPUT,	
    			@GenerarMovID	  		varchar(20)	OUTPUT,

       		    	@Ok                		int             OUTPUT,
    		    	@OkRef             		varchar(255)    OUTPUT,
			@Estacion			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CancelarID			int,
    @FechaCancelacion		datetime,
    @GenerarMovTipo		char(20),
    @GenerarPeriodo		int,
    @GenerarEjercicio		int,
    @Comienzo                   datetime,
    @Fin                        datetime,

    @p                          int,
    @Max                        int,
    @ProyectoMaster             varchar(50),

    @IDOrigen                   int,
    @OrigenEstatus              varchar(15),
    @ProyectoReestructurarID    int,

    @MovIDMaster                varchar(20),
    
    @ContactoTipo               varchar(20),
    @Prospecto		        varchar(10),
    @Cliente		        varchar(10),
    @Proveedor		        varchar(10),
    @Personal		        varchar(10),
    @Agente		        varchar(10),
    @Riesgo                     varchar(20),
    @ProyectoRama               varchar(50),
    @ProyectoTipo               varchar(20),
    @Descripcion		varchar(100),
    @MovOrigen          varchar(20),
    @ClaveOrigen        varchar(20)
    
  SELECT @Comienzo = Comienzo, @Fin = Fin FROM Proyecto WHERE ID = @ID
  SELECT @IDOrigen = ID, @OrigenEstatus = Estatus FROM Proyecto WHERE Mov = @Origen AND MovID = @OrigenID AND Empresa = @Empresa AND Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'CANCELADO')

  SELECT @MovOrigen = Mov 
    FROM Proyecto 
   WHERE ID = @IDOrigen
  
  SELECT @ClaveOrigen = Clave
    FROM MovTipo
   WHERE Modulo = @Modulo
     AND Mov = @MovOrigen

  SELECT @Prospecto = NULLIF(RTRIM(Prospecto), ''), @Cliente = NULLIF(RTRIM(Cliente), ''), @Proveedor = NULLIF(RTRIM(Proveedor), ''), @Personal = NULLIF(RTRIM(Personal), ''), 
         @Agente = NULLIF(RTRIM(Agente), ''), @Riesgo = NULLIF(RTRIM(Riesgo), ''), @ProyectoRama = NULLIF(RTRIM(ProyectoRama), ''), 
         @ContactoTipo = NULLIF(RTRIM(ContactoTipo), ''), @ProyectoTipo = CASE WHEN @ContactoTipo = 'Proyecto' THEN 'SubProyecto' ELSE 'Proyecto' END,
         @Descripcion = Descripcion
    FROM Proyecto
   WHERE ID = @ID
  
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
      SELECT @Ok = 80030, @OkRef = @GenerarMov

    IF @MovTipo = 'PROY.P' AND @GenerarMovTipo = 'PROY.R'
      EXEC spMovCopiarDetalle @Sucursal, @Modulo, @ID, @IDGenerar, @Usuario

    EXEC spMovCopiarDetalle @Sucursal, @Modulo, @ID, @IDGenerar, @Usuario
    EXEC spMovCopiarFormaAnexa @Modulo, @ID, @IDGenerar
    EXEC spMovCopiarProyecto @Empresa, @Sucursal, @ID, @IDGenerar

    -- Obtener MovID del Movimiento a Generar
    IF @Mov = @GenerarMov
    BEGIN
      SELECT @p = CHARINDEX('-', @MovID)
      IF @p > 0 
        SELECT @MovIDMaster = SUBSTRING(@MovID, 1, @p-1) 
      ELSE 
        SELECT @MovIDMaster = @MovID

      SELECT @Max = ISNULL(MAX(CONVERT(int, SUBSTRING(MovID, LEN(@MovIDMaster)+2, 20))), 0) 
        FROM Proyecto
       WHERE MovID LIKE RTRIM(@MovIDMaster)+'-%'
         AND Mov = @GenerarMov 
         AND Empresa = @Empresa
         AND Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CANCELADO')
         
      SELECT @GenerarMovID = RTRIM(@MovIDMaster)+'-'+CONVERT(varchar, @Max+1)
    END ELSE
      SELECT @GenerarMovID = NULL

    IF @MovID IS NOT NULL
      UPDATE Proyecto SET MovID = @GenerarMovID, Proyecto = @Proyecto, Reestructurar = 1, ProyectoReestructurar = @Proyecto WHERE ID = @IDGenerar 

    UPDATE ProyectoD SET EsNuevo = 0 WHERE ID = @IDGenerar

    RETURN
  END

  IF @Reestructurar = 0 AND (@ProyectoSugerir = 'MOVIMIENTO' OR (@ProyectoSugerir = 'ABIERTO' AND @Proyecto IS NULL))
    SELECT @Proyecto = RTRIM(@Mov)+' '+RTRIM(@MovID)            

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Cancelar Movimientos Generados en el Mismo Modulo
    IF @Accion = 'CANCELAR'
    BEGIN
      DECLARE crProyectoCancelar CURSOR LOCAL FOR
       SELECT ID
         FROM Proyecto
        WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
      OPEN crProyectoCancelar
      FETCH NEXT FROM crProyectoCancelar INTO @CancelarID
      WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
          EXEC spAfectar @Modulo, @CancelarID, 'CANCELAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

        FETCH NEXT FROM crProyectoCancelar INTO @CancelarID
      END
      CLOSE crProyectoCancelar
      DEALLOCATE crProyectoCancelar
    END

    IF @Accion <> 'CANCELAR'
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
								 @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
								 @Ok OUTPUT

    IF @Accion IN ('AFECTAR', 'CANCELAR') AND @Ok IS NULL
    BEGIN
      -- Afectacion
      IF @Accion = 'CANCELAR'
      BEGIN
        SELECT @EstatusNuevo = 'CANCELADO'

        -- Dar Proyecto de Baja en el Catalogo        
        UPDATE Proy  SET Estatus = 'BAJA' WHERE ProyectoID = @ID
        UPDATE ProyD SET Estatus = 'BAJA' WHERE ID IN (SELECT ID FROM Proy WHERE ProyectoID = @ID)

        IF @Origen IS NOT NULL AND @OrigenID IS NOT NULL AND @OrigenTipo = 'PROY'
        BEGIN
          SELECT @IDOrigen = ID FROM Proyecto WHERE Mov = @Origen AND MovID = @OrigenID AND Empresa = @Empresa AND Estatus = 'CONCLUIDO'
  
          IF @IDOrigen IS NULL
            SELECT @Ok = 60400, @OkRef = 'Movimiento: ' + RTRIM(@Mov) + ' ' + RTRIM(@MovID)
  
          -- Revivir Proyecto a Reestructurar
          IF @Ok IS NULL
          BEGIN
            UPDATE Proyecto SET Estatus = 'PENDIENTE', FechaConclusion = NULL WHERE ID = @IDOrigen
            UPDATE Proy  SET Estatus = 'ALTA' WHERE Proyecto = @ProyectoReestructurar    
            UPDATE ProyD SET Estatus = 'ALTA' WHERE ID IN (SELECT ID FROM Proy WHERE Proyecto = @ProyectoReestructurar)
            IF @@ERROR <> 0 SELECT @Ok = 1
          END
        
          IF @Ok IS NULL
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'PROY', @IDOrigen, @Origen, @OrigenID, 'PROY', @ID, @Mov, @MovID, @Ok OUTPUT
        END
      END ELSE
      BEGIN

        SELECT @EstatusNuevo = 'PENDIENTE'
        IF NOT EXISTS (SELECT * FROM ProyCat WHERE Categoria = @Mov) INSERT ProyCat (Categoria) VALUES (@Mov)

        IF @Reestructurar = 1
        BEGIN
/* JH 15/05/2008
          SELECT @p = CHARINDEX('-', @ProyectoReestructurar)

          IF @p > 0 
            SELECT @ProyectoMaster = SUBSTRING(@ProyectoReestructurar, 1, @p-1) 
          ELSE 
            SELECT @ProyectoMaster = @ProyectoReestructurar
  
          SELECT @Max = ISNULL(MAX(CONVERT(int, SUBSTRING(Proyecto, LEN(@ProyectoMaster)+2, 20))), 0) 
            FROM Proy 
           WHERE Proyecto LIKE RTRIM(@ProyectoMaster)+'-%'
  
          SELECT @Proyecto = RTRIM(@ProyectoMaster)+'-'+CONVERT(varchar, @Max+1)*/
          SELECT @Proyecto = @ProyectoReestructurar
        END 

        -- Validar Proyecto Nuevo
        IF @Proyecto IS NULL
          SELECT @Ok = 15010, @OkRef = 'Movimiento: ' + RTRIM(@Mov) + ' ' + RTRIM(@MovID)

        IF @Ok IS NULL AND @Reestructurar = 0  -- JH 15/05/2008
        BEGIN
          IF @ProyectoSugerir <> 'CATALOGO' 
            IF EXISTS (SELECT * FROM Proy WHERE Proyecto = @Proyecto) OR EXISTS (SELECT * FROM Proyecto WHERE Proyecto = @Proyecto AND Estatus IN ('PENDIENTE', 'CONCLUIDO'))
              SELECT @Ok = 26025, @OkRef = @Proyecto
          IF @ProyectoSugerir <> 'CATALOGO' 
            IF EXISTS (SELECT * FROM Proyecto WHERE Proyecto = @Proyecto AND Estatus IN ('PENDIENTE', 'CONCLUIDO'))
              SELECT @Ok = 26025, @OkRef = @Proyecto
        END
        
        -- Actualizar Proy
        IF @Ok IS NULL
        BEGIN
          UPDATE Proy 
             SET ProyectoID = @ID, Categoria = @Mov, Estatus = 'ALTA', FechaInicio = @Comienzo, FechaFin = @Fin, ContactoTipo = @ContactoTipo,
                 Cliente = @Cliente, Proveedor = @Proveedor, Prospecto = @Prospecto, Personal = @Personal, Agente = @Agente, ProyectoRama = @ProyectoRama, Riesgo = @Riesgo, 
                 Tipo = @ProyectoTipo
           WHERE Proyecto = @Proyecto

          IF @@ROWCOUNT = 0
            INSERT Proy (Proyecto,  Descripcion,  ProyectoID, Categoria, Estatus, FechaInicio, FechaFin,  ContactoTipo,  Proveedor,  Cliente,  Agente,  Personal,  Prospecto,  Riesgo,  ProyectoRama, Tipo) 
                 VALUES (@Proyecto, @Descripcion, @ID,        @Mov,      'ALTA',  @Comienzo,   @Fin,     @ContactoTipo, @Proveedor, @Cliente, @Agente, @Personal, @Prospecto, @Riesgo, @ProyectoRama, @ProyectoTipo)
          
          DELETE ProyD WHERE Proyecto = @Proyecto

          INSERT ProyD (
                 Proyecto,  Personal,   Cliente,   Proveedor,   Agente,   Nombre,   Estatus,    FechaInicio, FechaFin)
          SELECT @Proyecto, r.Personal, r.Cliente, r.Proveedor, r.Agente, r.Nombre, pr.Estatus, pr.Comienzo, pr.Fin
            FROM ProyectoRecurso pr
            JOIN Recurso r ON r.Recurso = pr.Recurso
           WHERE pr.ID = @ID
        END

        -- Actualizar ProyectoD
        IF @Ok IS NULL
        BEGIN
          UPDATE ProyectoD SET Proyecto = @Proyecto, Orden = dbo.fnEstructuraEnOrden(Actividad, 5) WHERE ID = @ID
          UPDATE ProyectoRecurso SET TieneMovimientos = 1 WHERE ID = @ID
          UPDATE Recurso SET TieneMovimientos = 1 WHERE TieneMovimientos = 0 AND Recurso IN (SELECT DISTINCT Recurso FROM ProyectoDRecurso WHERE ID = @ID) 
          EXEC spProyectoDLiberar @ID, NULL
        END

        -- Datos Riesgo
/*        IF @ContactoTipo = 'Riesgo' AND @Riesgo IS NOT NULL
          INSERT RiesgoProyecto ( Riesgo, ProyectoID) VALUES (@Riesgo, @ID)*/

        -- Matar Movmiento
        IF @OrigenTipo = 'PROY' AND @Origen IS NOT NULL AND @OrigenID IS NOT NULL
        BEGIN
          IF @OrigenEstatus = 'REESTRUCTURADO' AND @Estatus = 'PENDIENTE' AND @Origen = 'Proyecto Servicio'
				SET @OrigenEstatus = 'PENDIENTE'
				
          IF @OrigenEstatus <> 'PENDIENTE' OR @OrigenEstatus IS NULL
            SELECT @Ok = 20385, @OkRef = 'Movimiento: ' + RTRIM(@Mov) + ' ' + RTRIM(@MovID)

          IF @Ok IS NULL AND @CLaveOrigen = 'PROY.P'
          BEGIN
	    /* JH 15/05/2008*/
            UPDATE Proyecto SET Estatus = 'REESTRUCTURADO', @FechaConclusion = GETDATE() WHERE ID = @IDOrigen
            /*UPDATE Proy  SET Estatus = 'REESTRUCTURADO' WHERE Proyecto = @ProyectoReestructurar
            UPDATE ProyD SET Estatus = 'BAJA' WHERE Proyecto = @ProyectoReestructurar
            */ 

	    --Cancelar Solicitudes de inventario del origen
            EXEC spProyGenerarSolicitudInventario @Sucursal, @Empresa, 'REESTRUCTURAR', @Usuario, NULL, @IDOrigen, @Ok OUTPUT, @OkRef OUTPUT 

            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'PROY', @IDOrigen, @Origen, @OrigenID, 'PROY', @ID, @Mov, @MovID, @Ok OUTPUT
          END
          
          IF @Ok IS NULL AND @CLaveOrigen = 'PROY.PR'
          BEGIN
            UPDATE Proyecto SET Estatus = 'CONCLUIDO', @FechaConclusion = GETDATE() WHERE ID = @IDOrigen
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'PROY', @IDOrigen, @Origen, @OrigenID, 'PROY', @ID, @Mov, @MovID, @Ok OUTPUT            
          END
          
          IF @Ok IS NULL AND @CLaveOrigen = 'PROY.P' AND @Estatus = 'PENDIENTE' AND @Origen = 'Proyecto Servicio'
			BEGIN
				UPDATE Proyecto SET Estatus = 'CONCLUIDO', @FechaConclusion = GETDATE() WHERE ID = @ID
				SELECT @EstatusNuevo = 'CONCLUIDO'
				EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'PROY', @IDOrigen, @Origen, @OrigenID, 'PROY', @ID, @Mov, @MovID, @Ok OUTPUT
			END	
			
        END
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

        UPDATE Proyecto
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               Proyecto         = @Proyecto,
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
               Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END/*,
               GenerarPoliza    = @GenerarPoliza*/
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    -- Agregar Solicitudes de Inventario
    IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) AND @Accion IN ('AFECTAR','CANCELAR') AND @MovTipo = 'PROY.P'
      EXEC spProyGenerarSolicitudInventario @Sucursal, @Empresa, @Accion, @Usuario, NULL, @ID, @Ok OUTPUT, @OkRef OUTPUT

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

/**************** spProyecto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyecto') and type = 'P') drop procedure dbo.spProyecto
GO
CREATE PROCEDURE spProyecto
			@ID             int,
    			@Modulo	      	char(5),
			@Accion		char(20),
			@Base		char(20),
			@FechaRegistro	datetime,
			@GenerarMov	char(20),
			@Usuario	char(10),
    			@Conexion	bit,
			@SincroFinal	bit,
    			@Mov	      	char(20)	OUTPUT,
    			@MovID          varchar(20)	OUTPUT,
			@IDGenerar	int		OUTPUT,

			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT,
			@Estacion	int	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Generar		        bit,
    @GenerarAfectado	        bit,
    @Sucursal		        int,
    @SucursalDestino	        int,
    @SucursalOrigen	        int,
    @EnLinea		        bit,
    @PuedeEditar	        bit,
    @Empresa	      	        char(5),
    @MovTipo   		        char(20),
    @MovMoneda		        char(10),
    @MovTipoCambio	        float,
    @FechaEmision     	        datetime,
    @FechaAfectacion	        datetime,
    @FechaConclusion	        datetime,
    @Proyecto	      	        varchar(50),
    @ProyectoSugerir		varchar(20),
    @ProyectoReestructurar      varchar(50),
    @Reestructurar              bit,
    @MovUsuario	      	        char(10),
    @Autorizacion     	        char(10),
    @DocFuente	      	        int,
    @Concepto    	        varchar(50),
    @Referencia 	        varchar(50),
    @Observaciones    	        varchar(255),
    @Estatus          	        char(15),
    @EstatusNuevo	        char(15),
    @Ejercicio	      	        int,
    @Periodo	      	        int,
    @GenerarMovID	        varchar(20),
    @GenerarPoliza	        bit,
    @CfgContX		        bit,
    @CfgContXGenerar	        char(20),
                        
    @OrigenTipo                 varchar(5),
    @Origen                     varchar(20),
    @OrigenID                   varchar(20)

  -- Inicializar Variables
  SELECT @Generar	  = 0,
	 @GenerarAfectado  = 0,
         @CfgContX         = 0,
         @CfgContXGenerar  = 'NO'

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, 
         @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = NULLIF(RTRIM(Proyecto), ''),
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, @ProyectoReestructurar = NULLIF(RTRIM(ProyectoReestructurar), ''), 
         @Reestructurar = Reestructurar, @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, 
         @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID,
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @FechaConclusion = FechaConclusion, @Concepto = Concepto, @Referencia = Referencia
    FROM Proyecto
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  -- Determinar El Proyecto
  SELECT @ProyectoSugerir = UPPER(ProyectoSugerir) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  
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
    ELSE 
      SELECT @EstatusNuevo = 'CONCLUIDO' 

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spProyectoVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                               @FechaEmision, @OrigenTipo, @Origen, @OrigenID, @Estatus, @EstatusNuevo, 
                               @Conexion, @SincroFinal, @Sucursal, @Proyecto, @ProyectoSugerir, @ProyectoReestructurar, @Reestructurar, 
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

    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR', 'CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
      EXEC spProyectoAfectar @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
  			     @Proyecto, @ProyectoSugerir, @ProyectoReestructurar, @Reestructurar, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
			     @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @OrigenTipo, @Origen, @OrigenID, 
			     @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
			     @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
			     @Ok OUTPUT, @OkRef OUTPUT, @Estacion

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
      SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov)+' '+LTRIM(Convert(varChar, @GenerarMovID))

    -- Si hubo un error poner como referencia el Movimiento
    ELSE
      SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(varChar, @MovID)), @IDGenerar = NULL

  RETURN
END
GO

/******************* spRiesgoPlantillaNueva *******************/
if exists (select * from sysobjects where id = object_id('dbo.spRiesgoPlantillaNueva') and type = 'p') drop procedure spRiesgoPlantillaNueva
GO
CREATE PROCEDURE spRiesgoPlantillaNueva
                @Riesgo                 varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MaxVersion         float,
    @Plantilla          varchar(50),
    @PlantillaMaster    varchar(50),
    @P                  int,
    @PlantillaNueva     varchar(50),
    @Descripcion        varchar(255)
  
  BEGIN TRANSACTION

  IF NOT EXISTS (SELECT * FROM PlantillaProyecto WHERE Riesgo = @Riesgo)
    SELECT @Plantilla = @Riesgo
  ELSE
    SELECT TOP 1 @Plantilla = Plantilla FROM PlantillaProyecto WHERE Riesgo = @Riesgo ORDER BY Version DESC

  SELECT @p = CHARINDEX('-', @Plantilla)
  IF @p > 0 
    SELECT @PlantillaMaster = SUBSTRING(@Plantilla, 1, @p-1) 
  ELSE 
    SELECT @PlantillaMaster = @Plantilla
  
  SELECT @Descripcion = Descripcion FROM PlantillaProyecto WHERE Plantilla = @Plantilla
  SELECT @MaxVersion = MAX(ISNULL(Version, 0)) FROM PlantillaProyecto WHERE Riesgo = @Riesgo
  SELECT @MaxVersion = ISNULL(@MaxVersion, 0) + 1
  SELECT @PlantillaNueva = RTRIM(@PlantillaMaster)+'-'+CONVERT(varchar, @MaxVersion)

  INSERT PlantillaProyecto (Plantilla, Descripcion, Version, Estatus, TieneMovimientos, Riesgo)
                    VALUES (@PlantillaNueva, @Descripcion, @MaxVersion, 'ALTA', 0, @Riesgo)

  INSERT PlantillaProyectoD ( Plantilla, Actividad, Predecesora, Orden, EsFase, Clave, Asunto, Tipo, Categoria, Grupo, Familia, Duracion, DuracionUnidad, SubPlantilla, Comentarios)
    SELECT @PlantillaNueva, Actividad, Predecesora, Orden, EsFase, Clave, Asunto, Tipo, Categoria, Grupo, Familia, Duracion, DuracionUnidad, SubPlantilla, Comentarios
      FROM PlantillaProyectoD
     WHERE Plantilla = @Plantilla

  COMMIT TRANSACTION

  RETURN
END
GO

/*************** spRiesgoLiberarProyecto *****************/
if exists (select * from sysobjects where id = object_id('dbo.spRiesgoLiberarProyecto') and type = 'p') drop procedure spRiesgoLiberarProyecto
GO
CREATE PROCEDURE spRiesgoLiberarProyecto
                @Estacion       int,
                @Empresa        varchar(5),
                @Sucursal       int,
                @Usuario        varchar(10),

                @Riesgo         varchar(20),
                @Plantilla      varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID                 int,
    @Estatus            varchar(15),
    @FechaEmision       datetime,
    @Moneda             varchar(10),
    @TipoCambio         float,
    @Mov                varchar(20),
    @MovID              varchar(20),

    @Ok                 int,
    @OkRef              varchar(255)

  SELECT @Moneda = DefMoneda FROM Usuario WHERE Usuario = @Usuario

  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
  SELECT @Mov = ProyMitigacion FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @FechaEmision = GETDATE()
  SELECT @Estatus = 'CONFIRMAR'
  
  EXEC spExtraerFecha @FechaEmision OUTPUT
    
  BEGIN TRANSACTION

  EXEC spConsecutivoAuto @Sucursal, @Empresa, 'PROY', @Mov, NULL, NULL, NULL, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, NULL

  IF @Ok IS NULL
  BEGIN
    INSERT Proyecto ( Empresa, Mov, MovID, ContactoTipo, Riesgo, Moneda, TipoCambio, Estatus, FechaEmision, Comienzo, Usuario)
      VALUES        ( @Empresa, @Mov, @MovID, 'Riesgo', @Riesgo, @Moneda, @TipoCambio, @Estatus, @FechaEmision, @FechaEmision, @Usuario)

    SELECT @ID = SCOPE_IDENTITY()
    EXEC spProyectoNuevo @Estacion, @ID, @Plantilla, @Sucursal
   
    COMMIT TRANSACTION
  END ELSE
    ROLLBACK TRANSACTION

  SELECT @ID

  RETURN
END
GO
/********************* dbo.spProyGenerarPresup ***********/
if exists (select * from sysobjects where id = object_id('dbo.spProyGenerarPresup') and type = 'p') drop procedure dbo.spProyGenerarPresup
GO
CREATE PROCEDURE dbo.spProyGenerarPresup
                @IDProyecto int,
                @Modulo     varchar(20),
				@Mov        varchar(20),
				@Empresa	varchar(5),
				@Sucursal	int,
				@Usuario	varchar(10),
                @SubTipo    varchar(50),
                @Proyecto   varchar(50),
                @Proveedor  varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MovID          varchar(20),
    @MovTipo        varchar(20),
    @Origen         varchar(20),
    @OrigenID       varchar(20),
	@FechaEmision   datetime,
    @Almacen        varchar(10),
    @Articulo	    varchar(20),
	@SerieLote	    varchar(50),
    @Ok		        int,
    @OkRef	        varchar(255),
    @AlmTipo	    varchar(20),
    @ArtTipo	    varchar(20),
    @ID		        int,
    @Costo	        float,
    @Moneda	        varchar(10),
    @TipoCambio	    float,
    @UEN			int,
    @ConceptoRH		varchar(255),
    @ConceptoStaff	varchar(255),
    @ImporteRH		float,
    @Renglon		float,
    @Acreedor		varchar(50),
    @ArticuloMP		varchar(255),
    @AlmacenMP		varchar(255),
    @CantidadMP		int,
    @UnidadMP		varchar(50),
    @SubCuentaMP	varchar(255),
    @Impuesto1MP	float,
    @Impuesto2MP	float,
    @Impuesto3MP	float,
    @FactorMP		float,
    @DuracionDias	float,
    @CostoHora		float,
    @HorasDia		float,
    @UltimoCostoArt	float,
    @CfgCostoSugerido	varchar(50),
    @ProveedorArt	varchar(50)

    SET @Ok = null
    SET @OkRef = null

    SELECT @Moneda = Moneda, 
           @TipoCambio = TipoCambio,
           @Origen = Mov,
           @OrigenID = MovID           
      FROM Proyecto 
     WHERE ID = @IDProyecto
     
     SELECT @MovTipo = Clave
       FROM MovTipo 
      WHERE Modulo = @Modulo
        AND Mov = @Mov
     
     SELECT @CfgCostoSugerido = CompraCostoSugerido FROM EmpresaCfg WHERE Empresa = @Empresa
     SELECT @UEN = UEN FROM UEN WHERE NOMBRE = @Moneda 
  
    IF @Modulo NOT IN ('COMS','GAS')
        SELECT @Ok = 1, @OkRef = 'Error: Solo es posible generar movimientos de Compras o Gastos'

    --Inserta un movimiento "Presupuesto MP". en el módulo de COMPRAS
    IF @Ok IS NULL AND @Modulo = 'COMS' AND @MovTipo = 'COMS.PR'
    BEGIN		
		--SE VERIFICA SI YA EXISTE ALGUN PRESUPUESTO YA CONCLUIDO
		SELECT @Ok = NULL, @OkRef = NULL
		IF EXISTS (SELECT * FROM Compra WHERE OrigenTipo = 'PROY' AND Origen = @Origen AND OrigenID = @OrigenID AND ESTATUS = 'CONCLUIDO')
			BEGIN
				SELECT @Ok = 80001, @OkRef = 'Error: ya existe un Presupuesto de Materias Primas. Si desea agregar un nuevo movimiento necesita cancelar el existente.'
			END
		ELSE
		    BEGIN
				SELECT TOP 1 @AlmacenMP = Almacen FROM ProyectoDArtMaterial WHERE ID = @IDProyecto
				INSERT Compra (Empresa,     Mov,    FechaEmision,   UltimoCambio,   Proyecto,   Moneda,      Estatus,       Usuario,  Sucursal,	 TipoCambio,  UEN,	Proveedor,	Almacen, OrigenTipo, Origen, OrigenID) 
				VALUES        (@Empresa,    @Mov,   GETDATE(),      GETDATE(),      @Proyecto,  @Moneda,    'SINAFECTAR',   @Usuario, @Sucursal, @TipoCambio, @UEN,	@Proveedor, @AlmacenMP, 'PROY', @Origen, @OrigenID)
		    
				SELECT @ID = SCOPE_IDENTITY()
				SET @Renglon = 2048.0
				
				DECLARE crMateriaPrima CURSOR LOCAL FOR
					SELECT Material, Cantidad, Unidad, SubCuenta, Almacen FROM ProyectoDArtMaterial WHERE ID = @IDProyecto
				OPEN crMateriaPrima           
				FETCH NEXT FROM crMateriaPrima INTO @ArticuloMP, @CantidadMP, @UnidadMP, @SubCuentaMP, @AlmacenMP
				WHILE @@FETCH_STATUS <> -1
				BEGIN
					IF @@FETCH_STATUS <> -2
						BEGIN								
							SET @UltimoCostoArt = 0.0
							SELECT @Impuesto1MP = Impuesto1, @Impuesto2MP = Impuesto2, @Impuesto3MP = Impuesto3 FROM ART WHERE ARTICULO = @ArticuloMP
							SELECT @ProveedorArt = Proveedor FROM ArtProv WHERE Articulo = @ArticuloMP				    
							EXEC spVerCosto @Sucursal, @Empresa, @ProveedorArt, @ArticuloMP, @SubCuentaMP, @UnidadMP, @CfgCostoSugerido, @Moneda, @TipoCambio, @UltimoCostoArt OUTPUT, 0

							SELECT @FactorMP = dbo.fnArtUnidadFactor(@Empresa, @ArticuloMP, @UnidadMP)
							INSERT CompraD(ID,	RENGLON,	RENGLONSUB, FECHAREQUERIDA,	FECHAENTREGA,	ARTICULO,		CANTIDAD,		CANTIDADINVENTARIO,	COSTO,			ALMACEN,	IMPUESTO1,		IMPUESTO2,		IMPUESTO3,		UNIDAD,		FACTOR,		SUCURSAL,	SUCURSALORIGEN,	PAQUETE,	CambioImpuesto)
							VALUES		  (@ID,	@Renglon,	0,			GETDATE(),		GETDATE(),		@ArticuloMP,	@CantidadMP,	@CantidadMP,		@UltimoCostoArt,@AlmacenMP,	@Impuesto1MP,	@Impuesto2MP,	@Impuesto3MP,	@UnidadMP,	@FactorMP,	@Sucursal,	@Sucursal,		0,			0)
						END
					FETCH NEXT FROM crMateriaPrima INTO @ArticuloMP, @CantidadMP, @UnidadMP, @SubCuentaMP, @AlmacenMP
					SET @Renglon += 2048.0
				END
				CLOSE crMateriaPrima
				DEALLOCATE crMateriaPrima

				EXEC spAfectar @Modulo, @ID, 'CONSECUTIVO'

				SELECT @MovID = MovID
				  FROM Compra
				 WHERE ID = @ID

				EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'PROY', @IDProyecto, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
			END --FIN ELSE
    END
    --Inserta un movimiento "Presupuesto RH", en el módulo de GASTOS
    ELSE IF @Ok IS NULL AND @Modulo = 'GAS' AND @MovTipo = 'GAS.PR' AND @SubTipo = 'Recurso Humano'
    BEGIN
		--SE VERIFICA SI YA EXISTE ALGUN PRESUPUESTO YA CONCLUIDO
		SELECT @Ok = NULL, @OkRef = NULL
		IF EXISTS (SELECT * FROM Gasto WHERE MOV = @Mov AND OrigenTipo = 'PROY' AND Origen = @Origen AND OrigenID = @OrigenID AND ESTATUS = 'CONCLUIDO')
			BEGIN
				SELECT @Ok = 80002, @OkRef = 'Error: ya existe un Presupuesto de Gastos por RH. Si desea agregar un nuevo movimiento necesita cancelar el existente.'
			END
       	ELSE
       		BEGIN			
				INSERT Gasto (Empresa,  Mov,    FechaEmision,   UltimoCambio,   Proyecto,   Moneda,  Usuario,  Estatus,      Prioridad,  Sucursal,	TipoCambio,  UEN,	Acreedor, OrigenTipo, Origen, OrigenID)
				VALUES       (@Empresa, @Mov,   GETDATE(),      GETDATE (),     @Proyecto,  @Moneda, @Usuario, 'SINAFECTAR', 'Normal',   @Sucursal, @TipoCambio, @UEN,	@Proveedor, 'PROY', @Origen, @OrigenID)
				SELECT @ID = SCOPE_IDENTITY()
				SET @Renglon = 2048.0
				--************************** GENERANDO DETALLE COSTO RH ************************************************
				SELECT @ConceptoRH = ConceptoRH, @ConceptoStaff = ConceptoStaff FROM ConceptosRH
							
				IF @ConceptoRH IS NOT NULL
						BEGIN
							SET @ImporteRH = 0.0
							DECLARE crCostoRH CURSOR LOCAL FOR
								SELECT A.DuracionDias, B.CostoHora, B.HorasDia FROM ProyectoD as A, ProyectoRecurso as B, Recurso as C
							WHERE A.ID = B.ID AND A.RecursosAsignados = C.Nombre AND B.Recurso = C.Recurso AND B.ID = @IDProyecto AND A.ID = @IDProyecto
							OPEN crCostoRH
							FETCH NEXT FROM crCostoRH INTO @DuracionDias, @CostoHora, @HorasDia
							WHILE @@FETCH_STATUS <> -1
								BEGIN
									IF @@FETCH_STATUS <> -2
										SET @ImporteRH+= ((@DuracionDias * @HorasDia) * @CostoHora)
									FETCH NEXT FROM crCostoRH INTO @DuracionDias, @CostoHora, @HorasDia
								END
							CLOSE crCostoRH
							DEALLOCATE crCostoRH
									
							--INSERTAMOS TOTAL DEL COSTO DE RECURSO HUMANO		
							INSERT GastoD (ID,	RENGLON,	RENGLONSUB, FECHA,		CONCEPTO,	CANTIDAD,	PRECIO,		IMPORTE,	IMPUESTOS,	IMPUESTOS2,	IMPUESTOS3,	SUCURSAL,	SUCURSALORIGEN,	PorcentajeDeducible,	CambioImpuesto)
							VALUES		  (@ID,	@Renglon,	0,			GETDATE(),	@ConceptoRH,	1,			@ImporteRH,	@ImporteRH,	0.0,		0.0,		0.0,		@Sucursal,	@Sucursal,		100.00,					0)		
							SET @Renglon += 2048.0
						END	
				IF @ConceptoStaff IS NOT NULL
						BEGIN
							SET @ImporteRH = 0.0
							--INSERTAMOS TOTAL DEL COSTO DE STAFF		
							INSERT GastoD (ID,	RENGLON,	RENGLONSUB, FECHA,		CONCEPTO,	CANTIDAD,	PRECIO,		IMPORTE,	IMPUESTOS,	IMPUESTOS2,	IMPUESTOS3,	SUCURSAL,	SUCURSALORIGEN,	PorcentajeDeducible,	CambioImpuesto)
							VALUES		  (@ID,	@Renglon,	0,			GETDATE(),	@ConceptoStaff,	1,			@ImporteRH,	@ImporteRH,	0.0,		0.0,		0.0,		@Sucursal,	@Sucursal,		100.00,					0)		
							SET @Renglon += 2048.0
						END
				
				EXEC spAfectar @Modulo, @ID, 'CONSECUTIVO'

				SELECT @MovID = MovID
				  FROM Gasto
				 WHERE ID = @ID
				
				EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'PROY', @IDProyecto, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
			END --FIN ELSE
    END
    --Inserta un movimiento "Presupuesto SRV, en el módulo de GASTOS
    ELSE IF @Ok IS NULL AND @Modulo = 'GAS' AND @MovTipo = 'GAS.PR' AND @SubTipo = 'Servicio'
    BEGIN
		--SE VERIFICA SI YA EXISTE ALGUN PRESUPUESTO YA CONCLUIDO
		SELECT @Ok = NULL, @OkRef = NULL
		IF EXISTS (SELECT * FROM Gasto WHERE Mov = @Mov AND OrigenTipo = 'PROY' AND Origen = @Origen AND OrigenID = @OrigenID AND ESTATUS = 'CONCLUIDO')
			BEGIN
				SELECT @Ok = 80003, @OkRef = 'Error: ya existe un Presupuesto de Gastos por Servicios. Si desea agregar un nuevo movimiento necesita cancelar el existente.'
			END
		ELSE
			BEGIN    
				INSERT Gasto (Empresa,   Mov, FechaEmision,  UltimoCambio,   Proyecto,   Moneda,  Usuario,  Estatus,         Prioridad, Sucursal,	TipoCambio,  UEN,	Acreedor, OrigenTipo, Origen, OrigenID)
				VALUES       (@Empresa, @Mov, GETDATE(),     GETDATE(),      @Proyecto,  @Moneda, @Usuario, 'SINAFECTAR',    'Normal',  @Sucursal, @TipoCambio, @UEN,	@Proveedor, 'PROY', @Origen, @OrigenID)
		        
				SELECT @ID = SCOPE_IDENTITY()
		        
				EXEC spAfectar @Modulo, @ID, 'CONSECUTIVO'

				SELECT @MovID = MovID
				  FROM Gasto
				 WHERE ID = @ID
		         
				EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'PROY', @IDProyecto, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
			END
    END
    --ELSE
    --BEGIN
		  -- EXEC spProyGenerarMov @IDProyecto, @Modulo, @Mov, @Empresa, @Sucursal, @Usuario, @Proyecto, @Proveedor
    --END

    IF @Ok IS NOT NULL AND @OkRef IS NOT NULL
    BEGIN
        SELECT @OkRef = Descripcion+' '+ISNULL(RTRIM(@OkRef), '') 
          FROM MensajeLista 
         WHERE Mensaje = @Ok  
    END
  
    IF @Ok = NULL
        SELECT 'Se Genero '+@Mov+ ' (por Confirmar)'
    ELSE
        SELECT @OkRef
  RETURN
END
GO

/********************* dbo.spProyCancelaPresup ***********/
if exists (select * from sysobjects where id = object_id('dbo.spProyCancelaPresup') and type = 'p') drop procedure dbo.spProyCancelaPresup
GO
CREATE PROCEDURE dbo.spProyCancelaPresup
                @IDProyecto int,
                @Empresa	varchar(20),
                @Sucursal	int,
				@Mov        varchar(100),
				@MovID      varchar(20),
				@Usuario	varchar(50),
				@EstacionSp	int
--//WITH ENCRYPTION
AS BEGIN	
	DECLARE @DModuloCancela		varchar(20),
			@DIDCancela			int

	IF EXISTS(SELECT * FROM MovFlujo WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND OModulo = 'PROY' AND OID = @IDProyecto 
		AND OMov = @Mov AND OMovID = @MovID AND DMov Like 'Presupuesto%' AND Cancelado = 0)
		BEGIN
			DECLARE crCancelaPresupuestos CURSOR LOCAL FOR
				SELECT DModulo, DID FROM MovFlujo WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND OModulo = 'PROY' AND OID = @IDProyecto 
				AND OMov = @Mov AND OMovID = @MovID AND DMov Like 'Presupuesto%' AND Cancelado = 0 
			OPEN crCancelaPresupuestos           
			FETCH NEXT FROM crCancelaPresupuestos INTO @DModuloCancela, @DIDCancela
				WHILE @@FETCH_STATUS <> -1
					BEGIN
						IF @@FETCH_STATUS <> -2
							EXEC spAfectar @DModuloCancela, @DIDCancela, 'CANCELAR', 'Todo', NULL, @Usuario, @Estacion=@EstacionSp

						FETCH NEXT FROM crCancelaPresupuestos INTO @DModuloCancela, @DIDCancela
					END
			CLOSE crCancelaPresupuestos
			DEALLOCATE crCancelaPresupuestos
		END
END
GO

/********************* dbo.spProyGenerarMov ***********/
if exists (select * from sysobjects where id = object_id('dbo.spProyGenerarMov') and type = 'p') drop procedure dbo.spProyGenerarMov
GO
CREATE PROCEDURE dbo.spProyGenerarMov
                @IDProyecto int,
                @Modulo     varchar(20),
				@Mov        varchar(20),
				@Empresa	varchar(5),
				@Sucursal	int,
				@Usuario	varchar(10),
                @Proyecto   varchar(50),
                @Proveedor  varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MovID          varchar(20),
    @MovTipo        varchar(20),
    @Origen         varchar(20),
    @OrigenID       varchar(20),
	@FechaEmision   datetime,
    @Almacen        varchar(10),
    @Articulo	    varchar(20),
	@SerieLote	    varchar(50),
    @Ok		        int,
    @OkRef	        varchar(255),
    @AlmTipo	    varchar(20),
    @ArtTipo	    varchar(20),
    @ID		        int,
    @Costo	        float,
    @Moneda	        varchar(10),
    @TipoCambio	    float,
    @UEN			int,
    @ConceptoRH		varchar(255),
    @ConceptoStaff	varchar(255),
    @ImporteRH		float,
    @Renglon		float,
    @Acreedor		varchar(50),
    @ArticuloMP		varchar(255),
    @AlmacenMP		varchar(255),
    @CantidadMP		int,
    @UnidadMP		varchar(50),
    @SubCuentaMP	varchar(255),
    @Impuesto1MP	float,
    @Impuesto2MP	float,
    @Impuesto3MP	float,
    @FactorMP		float,
    @DuracionDias	float,
    @CostoHora		float,
    @HorasDia		float,
    @UltimoCostoArt	float,
    @CfgCostoSugerido	varchar(50),
    @ClienteProy	varchar(50)

    SET @Ok = null
    SET @OkRef = null

    SELECT @Moneda = Moneda, 
           @TipoCambio = TipoCambio,
           @Origen = Mov,
           @OrigenID = MovID,
           @ClienteProy = Cliente        
      FROM Proyecto 
     WHERE ID = @IDProyecto          
     
     SELECT @CfgCostoSugerido = CompraCostoSugerido FROM EmpresaCfg WHERE Empresa = @Empresa
     SELECT @UEN = UEN FROM UEN WHERE NOMBRE = @Moneda 
  
    IF @Modulo NOT IN ('VTAS','COMS','GAS','CXP','CXC')
        SELECT @Ok = 1, @OkRef = 'Error: Solo es posible generar movimientos de Ventas, Compras, Gastos, Cuentas por Pagar o Cuentas por Cobrar'

	--Inserta un movimiento en el módulo de VENTAS
    IF @Ok IS NULL AND @Modulo = 'VTAS'
    BEGIN		
		SELECT @Ok = NULL, @OkRef = NULL
		IF EXISTS (SELECT * FROM Venta WHERE Mov = @Mov AND OrigenTipo = 'PROY' AND Origen = @Origen AND OrigenID = @OrigenID AND ESTATUS = 'CONCLUIDO')
			BEGIN
				SELECT @Ok = 80001, @OkRef = 'Error: ya existe un movimiento '+@Mov+' de Ventas. Si desea agregar un nuevo movimiento necesita cancelar el existente.'
			END
		ELSE
		    BEGIN
				SELECT TOP 1 @AlmacenMP = Almacen FROM PROYECTODArtMaterial WHERE ID = @IDProyecto
		    
				INSERT Venta (Empresa,     Mov,    FechaEmision,   UltimoCambio,	Cliente,		Almacen,		Proyecto,   Moneda,		Estatus,		Usuario,  Sucursal,	 TipoCambio,  UEN,	OrigenTipo, Origen,	OrigenID) 
				VALUES       (@Empresa,    @Mov,   GETDATE(),      GETDATE(),		@ClienteProy,	@AlmacenMP,		@Proyecto,  @Moneda,	'SINAFECTAR',   @Usuario, @Sucursal, @TipoCambio, @UEN,	'PROY',		@Origen,@OrigenID)
				SELECT @ID = SCOPE_IDENTITY()
						    				
				EXEC spAfectar @Modulo, @ID, 'CONSECUTIVO'
				SELECT @MovID = MovID FROM Venta WHERE ID = @ID
				
				EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'PROY', @IDProyecto, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
			END --FIN ELSE
    END

    --Inserta un movimiento en el módulo de COMPRAS
    IF @Ok IS NULL AND @Modulo = 'COMS'
    BEGIN		
		SELECT @Ok = NULL, @OkRef = NULL
		IF EXISTS (SELECT * FROM Compra WHERE Mov = @Mov AND Proveedor = @Proveedor AND OrigenTipo = 'PROY' AND Origen = @Origen AND OrigenID = @OrigenID AND ESTATUS = 'CONCLUIDO')
			BEGIN
				SELECT @Ok = 80001, @OkRef = 'Error: ya existe un movimiento '+@Mov+' en el modulo de Compras con el proveedor '+@Proveedor+'.<BR>Si desea agregar un nuevo movimiento necesita cancelar el existente.'
			END
		ELSE
		    BEGIN
				INSERT Compra (Empresa,     Mov,    FechaEmision,   UltimoCambio,   Proyecto,   Moneda,      Estatus,       Usuario,  Sucursal,	 TipoCambio,  UEN,	Proveedor,	OrigenTipo, Origen, OrigenID) 
				VALUES        (@Empresa,    @Mov,   GETDATE(),      GETDATE(),      @Proyecto,  @Moneda,    'SINAFECTAR',   @Usuario, @Sucursal, @TipoCambio, @UEN,	@Proveedor, 'PROY', @Origen, @OrigenID)
		    	SELECT @ID = SCOPE_IDENTITY()
		    				
				EXEC spAfectar @Modulo, @ID, 'CONSECUTIVO'
				SELECT @MovID = MovID FROM Compra WHERE ID = @ID
				
				EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'PROY', @IDProyecto, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
			END --FIN ELSE
    END

	--Inserta un movimiento en el módulo de GASTOS
    IF @Ok IS NULL AND @Modulo = 'GAS'
    BEGIN		
		SELECT @Ok = NULL, @OkRef = NULL
		IF EXISTS (SELECT * FROM Gasto WHERE Mov = @Mov AND Acreedor = @Proveedor AND OrigenTipo = 'PROY' AND Origen = @Origen AND OrigenID = @OrigenID AND ESTATUS = 'CONCLUIDO')
			BEGIN
				SELECT @Ok = 80001, @OkRef = 'Error: ya existe un movimiento '+@Mov+' en el modulo de Gastos con el acreedor '+@Proveedor+'.<BR>Si desea agregar un nuevo movimiento con este mismo proveedor, necesita cancelar el existente.'
			END
		ELSE
		    BEGIN
				INSERT Gasto (Empresa,     Mov,    FechaEmision,   UltimoCambio,   Proyecto,   Moneda,      Estatus,       Usuario,  Sucursal,	 TipoCambio,  UEN,	Acreedor,	OrigenTipo, Origen, OrigenID) 
				VALUES       (@Empresa,    @Mov,   GETDATE(),      GETDATE(),      @Proyecto,  @Moneda,    'SINAFECTAR',   @Usuario, @Sucursal, @TipoCambio, @UEN,	@Proveedor, 'PROY',		@Origen, @OrigenID)
		    	SELECT @ID = SCOPE_IDENTITY()
		    				
				EXEC spAfectar @Modulo, @ID, 'CONSECUTIVO'
				SELECT @MovID = MovID FROM Gasto WHERE ID = @ID
				
				EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'PROY', @IDProyecto, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
			END --FIN ELSE
    END
    
    --Inserta un movimiento en el módulo de CUENTAS POR PAGAR
    IF @Ok IS NULL AND @Modulo = 'CXP'
    BEGIN
		SELECT @Ok = NULL, @OkRef = NULL
		IF EXISTS (SELECT * FROM Cxp WHERE Mov = @Mov AND Proveedor = @Proveedor AND OrigenTipo = 'PROY' AND Origen = @Origen AND OrigenID = @OrigenID AND ESTATUS = 'CONCLUIDO')
			BEGIN
				SELECT @Ok = 80001, @OkRef = 'Error: ya existe un movimiento '+@Mov+' en el modulo de Cuentas por Pagar con el proveedor '+@Proveedor+'.<BR>Si desea agregar un nuevo movimiento con este mismo proveedor, necesita cancelar el existente.'
			END
		ELSE
		    BEGIN		    				
		    	INSERT Cxp (Empresa,     Mov,    FechaEmision,   UltimoCambio,	Proyecto,   Moneda,		TipoCambio,		Usuario,	Estatus,		Proveedor,	ProveedorMoneda,ProveedorTipoCambio,	Importe,	OrigenTipo,	Origen,		OrigenID,	Sucursal,	SucursalOrigen,	UEN,	LineaCredito) 
				VALUES     (@Empresa,    @Mov,   GETDATE(),      GETDATE(),		@Proyecto,  @Moneda,	@TipoCambio,	@Usuario,	'SINAFECTAR',	@Proveedor,	@Moneda,		@TipoCambio,			0.0,		'PROY',		@Origen,	@OrigenID,	@Sucursal,	@Sucursal,		@UEN,	0)
				SELECT @ID = SCOPE_IDENTITY()
				
				EXEC spAfectar @Modulo, @ID, 'CONSECUTIVO'
				SELECT @MovID = MovID FROM Cxp WHERE ID = @ID
				
				EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'PROY', @IDProyecto, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
			END --FIN ELSE
    END
    
    --Inserta un movimiento en el módulo de CUENTAS POR COBRAR
    IF @Ok IS NULL AND @Modulo = 'CXC'
    BEGIN		
		SELECT @Ok = NULL, @OkRef = NULL
		IF EXISTS (SELECT * FROM Cxc WHERE Mov = @Mov AND OrigenTipo = 'PROY' AND Origen = @Origen AND OrigenID = @OrigenID AND ESTATUS = 'CONCLUIDO')
			BEGIN
				SELECT @Ok = 80001, @OkRef = 'Error: ya existe un movimiento '+@Mov+' en el modulo de Cuentas por Cobrar.<BR>Si desea agregar un nuevo movimiento necesita cancelar el existente.'
			END
		ELSE
		    BEGIN		    	
		    	INSERT Cxc (Empresa,     Mov,    FechaEmision,   UltimoCambio,	Proyecto,	Moneda,		TipoCambio,		Usuario,	Estatus,		Cliente,		ClienteMoneda,	ClienteTipoCambio,	Importe,	OrigenTipo, Origen,		OrigenID,	Sucursal,	SucursalOrigen,	UEN)
				VALUES     (@Empresa,    @Mov,   GETDATE(),      GETDATE(),		@Proyecto,	@Moneda,	@TipoCambio,	@Usuario,	'SINAFECTAR',	@ClienteProy,	@Moneda,		@TipoCambio,		0.0,		'PROY',		@Origen,	@OrigenID,	@Sucursal,	@Sucursal,		@UEN)
		    	SELECT @ID = SCOPE_IDENTITY()
		    	
				EXEC spAfectar @Modulo, @ID, 'CONSECUTIVO'
				SELECT @MovID = MovID FROM Cxc WHERE ID = @ID
				
				EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'PROY', @IDProyecto, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
			END --FIN ELSE
    END
    

    IF @Ok IS NOT NULL AND @OkRef IS NOT NULL
    BEGIN
        SELECT @OkRef = Descripcion+' '+ISNULL(RTRIM(@OkRef), '') 
          FROM MensajeLista 
         WHERE Mensaje = @Ok  
    END
  
    IF @Ok = NULL
        SELECT 'Se Genero '+@Mov+ ' (por Confirmar)'
    ELSE
        SELECT @OkRef
  RETURN
END
GO

/**************** spProyectoGestionMasiva ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoGestionMasiva') and type = 'P') drop procedure dbo.spProyectoGestionMasiva
GO
CREATE PROC spProyectoGestionMasiva
 @Estacion   int,
 @ID         int
WITH ENCRYPTION
AS BEGIN
DECLARE
 @Actividad		varchar(50),

 @Mov				varchar(20),
 @MovID				varchar(20),
 @Empresa			varchar(5),  
 @Sucursal			int,
 @Usuario			varchar(15),
 @Proyecto			varchar(50),
 @UEN				int,
 @Observaciones		varchar(100),  
 @Asunto            varchar(100),
 @PorcentajeAvance	float,
 @Comentarios		varchar(max),
 @Comienzo   		datetime,
 @Conclusion		datetime,
 @IDGestion			int,
 
 @Ok				int,	
 @OkRef				varchar(255)

	SELECT @Mov = Mov,  @MovID = MovID, @Empresa = Empresa,  @Sucursal = Sucursal, @Usuario = Usuario, @Proyecto = Proyecto, @UEN = UEN, @Observaciones = Observaciones 
	FROM Proyecto WHERE ID = @ID

	DECLARE crGestionMasiva CURSOR LOCAL FOR
		SELECT Actividad, Asunto, Avance, Comentarios, Comienzo, Fin, IDGestion FROM ProyectoD 
		WHERE ID = @ID AND ISNULL(RecursosAsignados,'') <> '' AND EsFase = 0 AND Estado = 'No Comenzada'
	OPEN crGestionMasiva
		FETCH NEXT FROM crGestionMasiva INTO @Actividad, @Asunto, @PorcentajeAvance, @Comentarios, @Comienzo, @Conclusion, @IDGestion
			WHILE @@FETCH_STATUS <> -1
				BEGIN
					IF @@FETCH_STATUS <> -2
						BEGIN
							IF @IDGestion IS NULL
								EXEC spProyectoGestionGenerar @ID, @Mov, @MovID, @Empresa, @Sucursal, @Usuario, @Proyecto, @UEN, @Observaciones, @Actividad, @Asunto, @PorcentajeAvance, @Comentarios, @Comienzo, @Conclusion, @IDGestion, @Ok OUTPUT, @OkRef OUTPUT
						END
					FETCH NEXT FROM crGestionMasiva INTO @Actividad, @Asunto, @PorcentajeAvance, @Comentarios, @Comienzo, @Conclusion, @IDGestion
				END
	CLOSE crGestionMasiva
	DEALLOCATE crGestionMasiva
	
	RETURN
END
GO

/********************* dbo.spProyArrastraServicios ***********/
if exists (select * from sysobjects where id = object_id('dbo.spProyArrastraServicios') and type = 'p') drop procedure dbo.spProyArrastraServicios
GO
CREATE PROCEDURE dbo.spProyArrastraServicios
                @IDProyecto		int,
                @Empresa		varchar(20),
                @Sucursal		int,	
				@NuevoIDProy	int,
				@Usuario		varchar(50),
				@EstacionSp		int
--//WITH ENCRYPTION
AS BEGIN
		DECLARE @Mov				varchar(100),
				@MovID				varchar(20),
				@NuevoMov			varchar(100),
				@NuevoMovID			varchar(20),
				@DModuloArrastra	varchar(20),
				@DIDArrastra		int,
				@MovArrastra		varchar(100),
				@MovIDArrastra		varchar(20),
				@OIDCambia			int,
				@ExisteMov			bit
				
	
	--OBTENIENDO MOV Y MOVID
	SELECT @Mov = Mov, @MovID = MovID FROM Proyecto WHERE ID = @IDProyecto
	SELECT @NuevoMov = Mov, @NuevoMovID = MovID FROM Proyecto WHERE ID = @NuevoIDProy

	IF EXISTS(SELECT * FROM MovFlujo WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND OModulo = 'PROY' AND OID = @IDProyecto 
		AND OMov = @Mov AND OMovID = @MovID AND DMov NOT LIKE 'Presupuesto%' AND Cancelado = 0)
		BEGIN	
			DECLARE crArrastraServicios CURSOR LOCAL FOR	
				SELECT OID, DModulo, DID, DMov, DMovID
				FROM MovFlujo WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND OModulo = 'PROY' AND OID = @IDProyecto 
				AND OMov = @Mov AND OMovID = @MovID AND DMov NOT LIKE 'Presupuesto%' AND Cancelado = 0
			OPEN crArrastraServicios           
			FETCH NEXT FROM crArrastraServicios INTO @OIDCambia, @DModuloArrastra, @DIDArrastra, @MovArrastra, @MovIDArrastra
				WHILE @@FETCH_STATUS <> -1
					BEGIN
						IF @@FETCH_STATUS <> -2
							BEGIN
								SET @ExisteMov = 0 --INICIAMOS BANDERA
								
								IF RTRIM(LTRIM(@DModuloArrastra)) = 'COMS' --Modificando movimientos en el módulo de COMPRAS
									IF EXISTS(SELECT * FROM Compra WHERE ID = @DIDArrastra AND Estatus <> 'CANCELADO' AND Origen IS NOT NULL AND OrigenTipo IS NOT NULL AND OrigenID IS NOT NULL AND ORIGENTIPO = 'PROY')
										BEGIN											
											UPDATE Compra SET Origen = @NuevoMov, OrigenTipo = 'PROY', OrigenID = @NuevoMovID, Proyecto = RTRIM(LTRIM(@NuevoMov))+' '+RTRIM(LTRIM(@NuevoMovID))
											WHERE ID = @DIDArrastra AND Estatus = 'CONCLUIDO'
											SET @ExisteMov = 1
										END
								IF RTRIM(LTRIM(@DModuloArrastra)) = 'VTAS' --Modificando movimientos en el módulo de VENTAS
									IF EXISTS(SELECT * FROM Venta WHERE ID = @DIDArrastra AND Estatus <> 'CANCELADO' AND Origen IS NOT NULL AND OrigenTipo IS NOT NULL AND OrigenID IS NOT NULL AND OrigenTipo = 'PROY')
										BEGIN											
											UPDATE Venta SET Origen = @NuevoMov, OrigenTipo = 'PROY', OrigenID = @NuevoMovID, Proyecto = RTRIM(LTRIM(@NuevoMov))+' '+RTRIM(LTRIM(@NuevoMovID))
											WHERE ID = @DIDArrastra AND Estatus <> 'CANCELADO'
											--Estatus = 'CONCLUIDO'											
											SET @ExisteMov = 1
										END
								IF RTRIM(LTRIM(@DModuloArrastra)) = 'GAS' --Modificando movimientos en el módulo de GASTOS
									IF EXISTS(SELECT * FROM Gasto WHERE ID = @DIDArrastra AND Estatus <> 'CANCELADO' AND Origen IS NOT NULL AND OrigenTipo IS NOT NULL AND OrigenID IS NOT NULL AND OrigenTipo = 'PROY')
										BEGIN											
											UPDATE Gasto SET Origen = @NuevoMov, OrigenTipo = 'PROY', OrigenID = @NuevoMovID, Proyecto = RTRIM(LTRIM(@NuevoMov))+' '+RTRIM(LTRIM(@NuevoMovID))
											WHERE ID = @DIDArrastra AND Estatus = 'CONCLUIDO'											
											SET @ExisteMov = 1
										END
								IF RTRIM(LTRIM(@DModuloArrastra)) = 'CXP' --Modificando movimientos en el módulo de CUENTAS POR PAGAR
									IF EXISTS(SELECT * FROM Cxp WHERE ID = @DIDArrastra AND Estatus <> 'CANCELADO' AND Origen IS NOT NULL AND OrigenTipo IS NOT NULL AND OrigenID IS NOT NULL AND OrigenTipo = 'PROY')
										BEGIN											
											UPDATE Cxp SET Origen = @NuevoMov, OrigenTipo = 'PROY', OrigenID = @NuevoMovID, Proyecto = RTRIM(LTRIM(@NuevoMov))+' '+RTRIM(LTRIM(@NuevoMovID))
											WHERE ID = @DIDArrastra AND Estatus = 'CONCLUIDO'											
											SET @ExisteMov = 1
										END			
								IF RTRIM(LTRIM(@DModuloArrastra)) = 'CXC' --Modificando movimientos en el módulo de CUENTAS POR COBRAR
									IF EXISTS(SELECT * FROM Cxc WHERE ID = @DIDArrastra AND Estatus <> 'CANCELADO' AND Origen IS NOT NULL AND OrigenTipo IS NOT NULL AND OrigenID IS NOT NULL AND OrigenTipo = 'PROY')
										BEGIN											
											UPDATE Cxc SET Origen = @NuevoMov, OrigenTipo = 'PROY', OrigenID = @NuevoMovID, Proyecto = RTRIM(LTRIM(@NuevoMov))+' '+RTRIM(LTRIM(@NuevoMovID))
											WHERE ID = @DIDArrastra AND Estatus = 'CONCLUIDO'											
											SET @ExisteMov = 1
										END	
															
								IF @ExisteMov = 1 --REGISTRA CAMBIOS EN MOVFLUJO Y ARRASTRE PROY
									BEGIN
										INSERT ArrastreProy SELECT @Sucursal, @Empresa, 'PROY', @NuevoIDProy, @NuevoMov, @NuevoMovID, @DModuloArrastra, @DIDArrastra, @MovArrastra, @MovIDArrastra, @OIDCambia, @Mov, @MovID, GETDATE()
									
										UPDATE MovFlujo SET OID = @NuevoIDProy, OMov = @NuevoMov, OMovID = @NuevoMovID
										WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND DModulo = @DModuloArrastra AND DID = @DIDArrastra 
										AND DMov = @MovArrastra AND DMovID = @MovIDArrastra AND Cancelado = 0
										
										SET @ExisteMov = 0
									END
							END
							
						FETCH NEXT FROM crArrastraServicios INTO @OIDCambia, @DModuloArrastra, @DIDArrastra, @MovArrastra, @MovIDArrastra
					END
			CLOSE crArrastraServicios
			DEALLOCATE crArrastraServicios
		END	
END
GO

/********************* dbo.spEstableceLineaBase ***********/
if exists (select * from sysobjects where id = object_id('dbo.spEstableceLineaBase') and type = 'p') drop procedure dbo.spEstableceLineaBase
GO
CREATE PROCEDURE dbo.spEstableceLineaBase
                @IDProyecto	int,
                @Accion varchar(20)
--//WITH ENCRYPTION
AS BEGIN		
		--Verificamos si existe una Linea Base Anterior
		IF EXISTS(SELECT * FROM LineaBase WHERE ID = @IDProyecto)
			DELETE FROM LineaBase WHERE ID = @IDProyecto
		
		IF EXISTS(SELECT * FROM LineaBaseD WHERE ID = @IDProyecto)
			DELETE FROM LineaBaseD WHERE ID = @IDProyecto					
		
		IF @Accion = 'ESTABLECE'
			BEGIN
				--Obtenemos Informacion del Proyecto Actual para Guardarlo como Linea Base
				INSERT LineaBase SELECT ID,GETDATE(),Empresa,Mov,MovID,ISNULL(FechaEmision,''),ISNULL(UltimoCambio,''),Proyecto,ProyectoReestructurar,Reestructurar,ISNULL(FechaRevision,''),ContactoTipo,Prospecto,Cliente,Proveedor,Personal,Agente,Riesgo,ProyectoRama,UEN,Concepto,Usuario,Autorizacion,DocFuente,Observaciones,Referencia,Estatus,Situacion,ISNULL(SituacionFecha,''),SituacionUsuario,SituacionNota,Moneda,TipoCambio,OrigenTipo,Origen,OrigenID,Ejercicio,Periodo,ISNULL(FechaRegistro,''),ISNULL(FechaConclusion,''),ISNULL(FechaCancelacion,''),ISNULL(Comienzo,''),ISNULL(Fin,''),ConsiderarAvanceActual,CalculoInverso,Sucursal,Prioridad,Supervisor,DiasHabiles,HorasDia,	MontoEstimado,ISNULL(FechaEstimada,''),Probabilidad,Avance,Comentarios,ISNULL(FechaRequerida,''),Descripcion,SucursalOrigen,SucursalDestino FROM Proyecto WHERE ID = @IDProyecto			
				
				--Obtenemos Detalle de las Actividades
				INSERT LineaBaseD SELECT ID,Actividad,Predecesora,Orden,EsFase,Clave,Asunto,Tipo,Categoria,Grupo,Familia,Duracion,DuracionUnidad,DuracionDias,
				Comentarios,Usuario,UltimoCambio,Comienzo,Fin,Estado,Avance,Prioridad,ComienzoEsp,Sincronizando,Proyecto,EstaLiberado,FechaLiberacion,
				TieneMovimientos,EsNuevo,FechaInicio,FechaConclusion,Sucursal,SucursalOrigen,SucursalDestino,IDGestion,MovGestion,RecursosAsignados,
				Indicador,Esfuerzo FROM ProyectoD WHERE ID = @IDProyecto				
			END
END
GO

/********************* dbo.spConcluyeProyecto ***********/
if exists (select * from sysobjects where id = object_id('dbo.spConcluyeProyecto') and type = 'p') drop procedure dbo.spConcluyeProyecto
GO
CREATE PROCEDURE dbo.spConcluyeProyecto
		@Empresa	varchar(255),
		@OModulo	varchar(20),
		@Oid		int,
		@OMov		varchar(20),
		@OMovid		varchar(20)
WITH ENCRYPTION
AS BEGIN
	DECLARE @Ok		int,
			@OkRef	varchar(255)
		
	SET @Ok = null
    SET @OkRef = null
			
	--Se verifica si ya existe tabla temporal
	IF OBJECT_ID('tempdb..#RastreoMovFlujo') IS NOT NULL  
		DROP TABLE #RastreoMovFlujo 
	ELSE  
	   CREATE TABLE #RastreoMovFlujo (
			IdFlujo		int				NOT NULL,
			Empresa		varchar(255)	NOT NULL,
			Modulo		varchar(20)		NOT NULL,
			Mov			varchar(20)		NOT NULL,
			MovID		varchar(20)		NOT NULL,
			Estatus		varchar(20)		NOT NULL)  


	--Ejecutamos Busqueda de Movimientos Pendientes
	EXEC spBuscaEstatusMovFlujo @Empresa, @OModulo, @Oid, @OMov, @OMovid
	
	IF EXISTS(SELECT * FROM #RastreoMovFlujo WHERE Estatus = 'PENDIENTE')
		SELECT TOP 1 @OkRef = 'Error: Movimiento Pendiente en Modulo '+Modulo+' Mov: '+Mov+' '+MovID, @Ok = 1 FROM #RastreoMovFlujo WHERE Estatus = 'PENDIENTE'
	
	IF @Ok IS NULL AND @OkRef IS NULL
		IF EXISTS(SELECT * FROM PROYECTOD WHERE ID = @Oid AND Estado IN ('No comenzada','En Curso') AND EsFase = 0)
			SELECT @Ok = 1, @OkRef = 'Error: Existen Actividades Sin Completar'			

	IF @Ok IS NOT NULL
		SELECT @OkRef
	ELSE
		SELECT 'Todos los Movimientos estan Concluidos'
	
	RETURN
END
GO

/********************* dbo.spBuscaEstatusMovFlujo ***********/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spBuscaEstatusMovFlujo') AND type = 'P') DROP PROCEDURE dbo.spBuscaEstatusMovFlujo
GO            
CREATE PROCEDURE spBuscaEstatusMovFlujo
		@Empresa	varchar(255),
		@OModulo	varchar(20),
		@Oid		int,
		@OMov		varchar(20),
		@OMovid		varchar(20)
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE @Estatus			varchar(20),
			@DModulo			varchar(20),
			@Did				int,
			@DMov				varchar(20),
			@DMovid				varchar(20)		

	--VERIFICAMOS SI EXISTEN MOVIMIENTOS
	IF EXISTS(SELECT * FROM MovFlujo WHERE Empresa = @Empresa AND OModulo = @OModulo AND OID = @Oid AND OMov = @OMov AND OMovid = @OMovid)
		BEGIN		
			DECLARE crMovPendientes CURSOR LOCAL FOR
				SELECT DModulo, DID, DMov, DMovID FROM MovFlujo 
				WHERE Empresa = @Empresa AND OModulo = @OModulo AND OID = @Oid AND OMov = @OMov AND OMovid = @OMovid
			OPEN crMovPendientes
			FETCH NEXT FROM crMovPendientes INTO @DModulo, @Did, @DMov, @DMovid
			WHILE @@FETCH_STATUS <> -1
				BEGIN
					IF @@FETCH_STATUS <> -2
						BEGIN							
							IF @DModulo = 'AF'
									IF EXISTS(SELECT * FROM ActivoFijo WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM ActivoFijo WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE  CONTINUE
							ELSE IF @DModulo = 'COMS'
									IF EXISTS(SELECT * FROM Compra WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Compra WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE
							ELSE IF @DModulo = 'CONC'
									IF EXISTS(SELECT * FROM Conciliacion WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Conciliacion WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE
							ELSE IF @DModulo = 'CXC'
									IF EXISTS(SELECT * FROM Cxc WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Cxc WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE
							ELSE IF @DModulo = 'CXP'
									IF EXISTS(SELECT * FROM Cxp WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Cxp WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE
							ELSE IF @DModulo = 'DIN'
									IF EXISTS(SELECT * FROM Dinero WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Dinero WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE
							ELSE IF @DModulo = 'EMB'
									IF EXISTS(SELECT * FROM Embarque WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Embarque WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE
							ELSE IF @DModulo = 'GAS'
									IF EXISTS(SELECT * FROM Gasto WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Gasto WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE
							ELSE IF @DModulo = 'GES'
									IF EXISTS(SELECT * FROM Gestion WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Gestion WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE
							ELSE IF @DModulo = 'INV'
									IF EXISTS(SELECT * FROM Inv WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Inv WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE
							ELSE IF @DModulo = 'NOM'
									IF EXISTS(SELECT * FROM Nomina WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Nomina WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE
							ELSE IF @DModulo = 'PROY'
									IF EXISTS(SELECT * FROM Proyecto WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Proyecto WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE
							ELSE IF @DModulo = 'VTAS'
									IF EXISTS(SELECT * FROM Venta WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid) 
										BEGIN
											INSERT INTO #RastreoMovFlujo SELECT ID,Empresa,@DModulo,Mov,MovID,Estatus FROM Venta WHERE ID = @Did AND Empresa = @Empresa AND Mov = @DMov AND MovID = @DMovid
											EXEC spBuscaEstatusMovFlujo @Empresa, @DModulo, @Did, @DMov, @DMovid
										END
									ELSE CONTINUE						
						END
					FETCH NEXT FROM crMovPendientes INTO @DModulo, @Did, @DMov, @DMovid
				END
			CLOSE crMovPendientes
			DEALLOCATE crMovPendientes
		END
END
GO


/**************** spFormaCampoHTML ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spFormaCampoHTML') AND type = 'P') DROP PROCEDURE dbo.spFormaCampoHTML
GO             
CREATE PROCEDURE spFormaCampoHTML
    @FormaTipo		varchar(20)
WITH ENCRYPTION 
AS BEGIN
    SELECT fc.Campo, fc.Etiqueta, fc.Grupo, fc.TipoDato, fc.EsContrasena, fc.EsMayusculas, fc.LongitudMaxima, fc.AyudaTipo
    FROM FormaCampo fc
    JOIN FormaGrupo fg ON fg.FormaTipo = fc.FormaTipo and fg.Grupo = fc.Grupo
    WHERE fc.FormaTipo = @FormaTipo
    ORDER BY fg.Orden, fc.Orden
END
GO


PRINT '******************* SP Proyecto ******************'
GO
