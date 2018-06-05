/********* CP ***********/

/**************** spCPVerificarReduccion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCPVerificarReduccion') and type = 'P') drop procedure dbo.spCPVerificarReduccion
GO
CREATE PROCEDURE spCPVerificarReduccion
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
    		    @FechaRegistro     		datetime,
		    
    	 	    @Proyecto	      		varchar(50),
		    @Ejercicio			int,
		    @Periodo			int,
		    
		    @ClavePresupuestal		varchar(50),
		    @Tipo			varchar(20),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Articulo		varchar(20),
    @Importe		money,
    @ImporteDisponible	money
    
  IF @Ok IS NULL
  BEGIN
    DECLARE spCPVerificarTraspaso CURSOR LOCAL FOR 
     SELECT cpa.Articulo, cpa.Cantidad*cpa.Precio
       FROM CPArt cpa
      WHERE cpa.ID = @ID AND cpa.ClavePresupuestal = @ClavePresupuestal AND cpa.Tipo = @Tipo
    OPEN spCPVerificarTraspaso
    FETCH NEXT FROM spCPVerificarTraspaso INTO @Articulo, @Importe
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND ISNULL(@Importe, 0.0) > 0.0
      BEGIN
      	SELECT @ImporteDisponible = 0.0
      	SELECT @ImporteDisponible = ImporteDisponible
      	  FROM CPArtNetoDisponible
      	 WHERE Empresa = @Empresa AND Proyecto = @Proyecto AND ClavePresupuestal = @ClavePresupuestal AND Articulo = @Articulo
        IF @Importe > @ImporteDisponible	
          SELECT @Ok = 25570, @OkRef = RTRIM(@Mov)+'<BR>'+@ClavePresupuestal+' ('+@Articulo+')<BR>Excedente: '+CONVERT(varchar, @Importe-@ImporteDisponible)
      END
      FETCH NEXT FROM spCPVerificarTraspaso INTO @Articulo, @Importe
    END
    CLOSE spCPVerificarTraspaso
    DEALLOCATE spCPVerificarTraspaso
  END
  RETURN
END
GO

/**************** spCPVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCPVerificar') and type = 'P') drop procedure dbo.spCPVerificar
GO
CREATE PROCEDURE spCPVerificar
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
    		    @FechaRegistro     		datetime,
		    
    	 	    @Proyecto	      		varchar(50),
		    @Ejercicio			int,
		    @Periodo			int,

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @p				int,
    @Articulo			varchar(20),
    @ClavePresupuestal		varchar(50),
    @SumaImporte		money,
    @Importe			money,
    @Tipo			varchar(20),
    @Presupuesto		money,
    @Comprometido		money,
    @Comprometido2		money,
    @Devengado			money,
    @Devengado2			money,
    @Ejercido			money,
    @EjercidoPagado		money,
    @Anticipos			money,
    @RemanenteDisponible	money,
    @Sobrante			money,
    @Disponible			money,
    @SaldoPresupuesto		money,
    @SaldoComprometido		money,
    @SaldoComprometido2		money,
    @SaldoDevengado		money,
    @SaldoDevengado2		money,
    @SaldoEjercido		money,
    @SaldoEjercidoPagado	money,
    @SaldoAnticipos		money,
    @SaldoRemanenteDisponible	money,
    @SaldoSobrante		money,
    @SaldoDisponible		money,
    @FlujoAlPeriodo		money,
    @TotalEjercido		money,
    @Reservado			money,
    @TieneArticulosEsp		bit,
    @PeriodoD			int,
    @TieneDetalle		bit,
    @PCP				bit
    
  SELECT @PCP = PCP FROM EmpresaGral WHERE Empresa = @Empresa    
    
  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END ELSE 
  IF @Accion IN ('AFECTAR', 'VERIFICAR')
  BEGIN  	
    UPDATE CPCal SET EnMov = NULL WHERE ID = @ID AND EnMov IS NOT NULL
    UPDATE CPArt SET EnMov = NULL WHERE ID = @ID AND EnMov IS NOT NULL    
    IF @Proyecto IS NULL SELECT @Ok = 15010

    SELECT @TieneDetalle = 0
    DECLARE crCPVerificar CURSOR LOCAL FOR 
     SELECT d.ClavePresupuestal, cp.TieneArticulosEsp, UPPER(d.Tipo), ISNULL(SUM(d.Importe), 0.0), ISNULL(SUM(d.Presupuesto), 0.0), ISNULL(SUM(d.Comprometido), 0.0), ISNULL(SUM(d.Comprometido2), 0.0), ISNULL(SUM(d.Devengado), 0.0), ISNULL(SUM(d.Devengado2), 0.0), ISNULL(SUM(d.Ejercido), 0.0), ISNULL(SUM(d.EjercidoPagado), 0.0), ISNULL(SUM(d.Anticipos), 0.0), ISNULL(SUM(d.RemanenteDisponible), 0.0), ISNULL(SUM(d.Sobrante), 0.0), ISNULL(SUM(d.Disponible), 0.0)
       FROM CPD d
       JOIN ClavePresupuestal cp ON cp.ClavePresupuestal = d.ClavePresupuestal
      WHERE d.ID = @ID
      GROUP BY d.ClavePresupuestal, cp.TieneArticulosEsp, d.Tipo
      ORDER BY d.ClavePresupuestal, cp.TieneArticulosEsp, d.Tipo
    OPEN crCPVerificar
    FETCH NEXT FROM crCPVerificar INTO @ClavePresupuestal, @TieneArticulosEsp, @Tipo, @Importe, @Presupuesto, @Comprometido, @Comprometido2, @Devengado, @Devengado2, @Ejercido, @EjercidoPagado, @Anticipos, @RemanenteDisponible, @Sobrante, @Disponible
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN      	
        SELECT @TieneDetalle = 1
      	IF NULLIF(RTRIM(@ClavePresupuestal), '') IS NULL SELECT @Ok = 25640
      	UPDATE CPCal SET EnMov = 1 WHERE ID = @ID AND ClavePresupuestal = @ClavePresupuestal AND Tipo = @Tipo
      	UPDATE CPArt SET EnMov = 1 WHERE ID = @ID AND ClavePresupuestal = @ClavePresupuestal AND Tipo = @Tipo

        IF @MovTipo IN ('CP.AS', 'CP.TA', 'CP.TR', 'CP.RF') AND @Ok IS NULL AND @PCP = 1
        BEGIN
          IF dbo.fnPCPValidarReglas(@Proyecto, @FechaEmision, @ClavePresupuestal) = 0 SELECT @Ok = 73840, @OkRef = @ClavePresupuestal      
        END

      	IF @MovTipo IN ('CP.AS', 'CP.TA', 'CP.TR', 'CP.RF') AND @Ok IS NULL
      	BEGIN
          -- checar CPCal
    	  SELECT @SumaImporte = 0.0
      	  SELECT @SumaImporte = ISNULL(SUM(Importe), 0.0) FROM CPCal WHERE ID = @ID AND ClavePresupuestal = @ClavePresupuestal AND Tipo = @Tipo
   	  IF @Importe <> @SumaImporte 
      	  BEGIN
            IF ROUND(@Importe, 2) = ROUND(@SumaImporte, 2)
      	    BEGIN
      	      SELECT @p = MAX(Periodo)
      	        FROM CPCal
      	       WHERE ID = @ID AND ClavePresupuestal = @ClavePresupuestal AND Tipo = @Tipo
      	      	 
      	      UPDATE CPCal
      	         SET Importe = Importe + (@Importe - @SumaImporte)
      	       WHERE ID = @ID AND ClavePresupuestal = @ClavePresupuestal AND Tipo = @Tipo AND Periodo = @p
      	      	 
              SELECT @SumaImporte = ISNULL(SUM(Importe), 0.0) FROM CPCal WHERE ID = @ID AND ClavePresupuestal = @ClavePresupuestal AND Tipo = @Tipo
      	    END
      	    IF @Importe <> @SumaImporte 
      	      SELECT @Ok = 25520
          END                   
     	
          -- checar CPArt
          IF @TieneArticulosEsp = 1 AND @MovTipo NOT IN ('CP.RF')
          BEGIN
            IF NOT EXISTS(SELECT * FROM CPArt WHERE ID = @ID AND ClavePresupuestal = @ClavePresupuestal AND Tipo = @Tipo)
              SELECT @Ok = 25550
      	    SELECT @SumaImporte = 0.0
      	    SELECT @SumaImporte = ISNULL(SUM(Cantidad*Precio), 0.0) FROM CPArt WHERE ID = @ID AND ClavePresupuestal = @ClavePresupuestal AND Tipo = @Tipo
            IF @Importe <> @SumaImporte 
      	      SELECT @Ok = 25525
      	    
      	    IF @Tipo = 'REDUCCION'
              EXEC spCPVerificarReduccion @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, @FechaRegistro,
                                          @Proyecto, @Ejercicio, @Periodo, 
                                          @ClavePresupuestal, @Tipo,
          	                          @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT
          END                    
      	END
      	
      	SELECT @SaldoPresupuesto	 = 0.0,
               @SaldoComprometido	 = 0.0,
               @SaldoComprometido2	 = 0.0,
               @SaldoDevengado		 = 0.0,
               @SaldoDevengado2		 = 0.0,
               @SaldoEjercido		 = 0.0,
               @SaldoEjercidoPagado	 = 0.0,
               @SaldoAnticipos           = 0.0,
               @SaldoRemanenteDisponible = 0.0,
               @SaldoSobrante		 = 0.0,
               @SaldoDisponible		 = 0.0
        SELECT @SaldoPresupuesto	 = Presupuesto,
               @SaldoComprometido	 = Comprometido,
               @SaldoComprometido2	 = Comprometido2,
               @SaldoDevengado		 = Devengado,
               @SaldoDevengado2		 = Devengado2,
               @SaldoEjercido		 = Ejercido,
               @SaldoEjercidoPagado	 = EjercidoPagado,
               @SaldoAnticipos           = Anticipos,
               @SaldoRemanenteDisponible = RemanenteDisponible,
               @SaldoSobrante		 = Sobrante,
               @SaldoDisponible		 = Disponible
          FROM CPNeto
         WHERE Empresa = @Empresa AND Proyecto = @Proyecto AND ClavePresupuestal = @ClavePresupuestal
         
        IF @MovTipo IN ('CP.AS', 'CP.TA', 'CP.TR') AND @Tipo = 'REDUCCION' AND @Importe > @SaldoDisponible AND @Ok IS NULL
          SELECT @Ok = 20902
          

        IF @MovTipo = 'CP.OP' AND @Ok IS NULL
        BEGIN
          IF (ROUND(@SaldoPresupuesto		+ @Presupuesto, 2)   < 0.0) 
          OR (ROUND(@SaldoComprometido		+ @Comprometido, 2)  < 0.0)
          OR (ROUND(@SaldoComprometido2		+ @Comprometido2, 2) < 0.0)
          OR (ROUND(@SaldoDevengado		+ @Devengado + @SaldoAnticipos, 2)     < 0.0)
          OR (ROUND(@SaldoDevengado2		+ @Devengado2, 2)    < 0.0)
          OR (ROUND(@SaldoEjercido		+ @Ejercido, 2)      < 0.0)
          OR (ROUND(@SaldoEjercidoPagado	+ @EjercidoPagado, 2)< 0.0)
          OR (ROUND(@SaldoAnticipos		+ @Anticipos, 2) < 0.0)
          OR (ROUND(@SaldoRemanenteDisponible	+ @RemanenteDisponible, 2) < 0.0)
          OR (ROUND(@SaldoSobrante		+ @Sobrante, 2)      < 0.0)
          OR (ROUND(@SaldoDisponible		+ @Disponible, 2)    < 0.0)
            SELECT @Ok = 20902
        END       

        SELECT @TotalEjercido = @SaldoEjercido + @Ejercido + @SaldoEjercidoPagado + @EjercidoPagado
        	
	-- checar la calendarizacion del flujo
        IF @MovTipo = 'CP.OP' AND @Ejercido > 0.0 AND @Ok IS NULL
        BEGIN
          SELECT @FlujoAlPeriodo = 0.0
          SELECT @FlujoAlPeriodo = ISNULL(SUM(Presupuesto), 0.0)
            FROM CPCalDisponible
           WHERE Empresa = @Empresa AND Proyecto = @Proyecto AND ClavePresupuestal = @ClavePresupuestal AND Ejercicio = @Ejercicio AND Periodo <= @Periodo
          IF ROUND(@TotalEjercido, 0) > ROUND(@FlujoAlPeriodo, 0) 
            SELECT @Ok = 25530, @OkRef = RTRIM(@Mov)+'<BR>'+'Excedente: '+CONVERT(varchar, @TotalEjercido - @FlujoAlPeriodo)+ '<BR>'+@ClavePresupuestal
        END

        IF @MovTipo IN ('CP.RF', 'CP.TA', 'CP.TR') AND @Ok IS NULL
        BEGIN
          DECLARE crCPVerificarRF CURSOR LOCAL FOR 
           SELECT Periodo, Importe * CASE WHEN @Tipo = 'REDUCCION' THEN -1.0 ELSE 1.0 END 
             FROM CPCal
            WHERE ID = @ID AND ClavePresupuestal = @ClavePresupuestal AND Tipo = @Tipo
          OPEN crCPVerificarRF
          FETCH NEXT FROM crCPVerificarRF INTO @PeriodoD, @Reservado
          WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
          BEGIN
            IF @@FETCH_STATUS <> -2 
            BEGIN      	       	
              -- en el caso de traspasos el reservado se comporta alrevez
              IF @MovTipo <> 'CP.RF' SELECT @Reservado = -@Reservado 
              	            
              SELECT @FlujoAlPeriodo = 0.0
              SELECT @FlujoAlPeriodo = ISNULL(SUM(Presupuesto), 0.0)
                FROM CPCalDisponible
               WHERE Empresa = @Empresa AND Proyecto = @Proyecto AND ClavePresupuestal = @ClavePresupuestal AND Ejercicio = @Ejercicio AND Periodo <= @PeriodoD
              IF ROUND(@TotalEjercido, 0) + ROUND(@Reservado, 0) > ROUND(@FlujoAlPeriodo, 0) 
                SELECT @Ok = 25530, @OkRef = RTRIM(@Mov)+'<BR>'+'Excedente: '+CONVERT(varchar, @TotalEjercido + @Reservado - @FlujoAlPeriodo)+ '<BR>'+@ClavePresupuestal+' '+@Tipo
            END
            FETCH NEXT FROM crCPVerificarRF INTO @PeriodoD, @Reservado
          END
          CLOSE crCPVerificarRF
          DEALLOCATE crCPVerificarRF
        END

        IF @Tipo = 'REDUCCION' 
          SELECT @SumaImporte = @SumaImporte - ISNULL(@Importe, 0.0)
        ELSE
          SELECT @SumaImporte = @SumaImporte + ISNULL(@Importe, 0.0)
          
        IF @Ok IS NOT NULL AND @OkRef IS NULL SELECT @OkRef = RTRIM(@Mov)+'<BR>'+@ClavePresupuestal
      END
      FETCH NEXT FROM crCPVerificar INTO @ClavePresupuestal, @TieneArticulosEsp, @Tipo, @Importe, @Presupuesto, @Comprometido, @Comprometido2, @Devengado, @Devengado2, @Ejercido, @EjercidoPagado, @Anticipos, @RemanenteDisponible, @Sobrante, @Disponible
    END
    CLOSE crCPVerificar
    DEALLOCATE crCPVerificar         

    --IF @TieneDetalle = 0 AND @Ok IS NULL SELECT @Ok = 60010

    IF @MovTipo IN ('CP.TA', 'CP.TR') AND @Ok IS NULL 
    BEGIN
      SELECT @SumaImporte = 0.0
      SELECT @SumaImporte = ISNULL(SUM(CASE WHEN UPPER(Tipo) = 'REDUCCION' THEN -Importe ELSE Importe END), 0)
        FROM CPD
       WHERE ID = @ID

      IF @SumaImporte <> 0.0
       SELECT @Ok = 25540    	
    END
    IF @Ok IS NULL
    BEGIN
      DELETE CPCal WHERE ID = @ID AND EnMov IS NULL
      DELETE CPArt WHERE ID = @ID AND EnMov IS NULL
    END
  END
  RETURN
END
GO

/**************** spCPAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCPAfectar') and type = 'P') drop procedure dbo.spCPAfectar
GO             
CREATE PROCEDURE spCPAfectar
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
		   
		   @OrigenTipo			varchar(10),
		   @Origen			varchar(20),
		   @OrigenID			varchar(20),
		   @OrigenMovTipo		varchar(20),

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
    @CxMov		varchar(20),
    @CxMovID		varchar(20),
    @CxImporte		money,
    @ClavePresupuestal	varchar(50)

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
		                  NULL, NULL, @Mov, @MovID, 0, @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    
    --BUG 25878 Para controlar Movflujo
    IF  @Ok IS NULL AND @IDGenerar IS NOT NULL
      EXEC spAfectar @Modulo, @IDGenerar, 'CONSECUTIVO'

    IF  @Ok IS NULL AND @IDGenerar IS NOT NULL AND @GenerarMovID IS NULL
      SELECT @GenerarMovID = MovID FROM CP WHERE ID = @IDGenerar

    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @IDGenerar, @GenerarMov, @GenerarMovID, @Ok = @OK OUTPUT

    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT

    IF @Ok IS NULL
    BEGIN
      INSERT CPD (
             Sucursal,  ID,         Renglon, ClavePresupuestal, Tipo, Importe) 
      SELECT @Sucursal, @IDGenerar, Renglon, ClavePresupuestal, Tipo, Importe
        FROM CPD
       WHERE ID = @ID

      INSERT CPCal (
             Sucursal,  ID,         ClavePresupuestal, Tipo, Ejercicio, Periodo, Importe) 
      SELECT @Sucursal, @IDGenerar, ClavePresupuestal, Tipo, Ejercicio, Periodo, Importe
        FROM CPCal
       WHERE ID = @ID

      INSERT CPArt (
             Sucursal,  ID,         ClavePresupuestal, Tipo, Articulo, Cantidad, Precio, Referencia, Observaciones) 
      SELECT @Sucursal, @IDGenerar, ClavePresupuestal, Tipo, Articulo, Cantidad, Precio, Referencia, Observaciones
        FROM CPArt
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

    IF @Accion IN ('AFECTAR', 'CANCELAR')
    BEGIN
      IF @MovTipo IN ('CP.AS', 'CP.TA')
      BEGIN      	
      	UPDATE CPD 
      	   SET Presupuesto = CASE WHEN UPPER(Tipo) = 'REDUCCION' THEN -Importe ELSE Importe END
      	 WHERE ID = @ID

        IF @OrigenMovTipo = 'CP.AP'
          UPDATE CP 
             SET Estatus         = CASE WHEN @Accion = 'AFECTAR' THEN 'CONCLUIDO'   ELSE 'PENDIENTE' END,
                 FechaConclusion = CASE WHEN @Accion = 'AFECTAR' THEN @FechaEmision ELSE NULL        END
           WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus IN ('CONCLUIDO', 'PENDIENTE')
      END
      IF @MovTipo = 'CP.TR'
      	UPDATE CPD 
      	   SET Presupuesto         = CASE WHEN UPPER(Tipo) = 'AMPLIACION' THEN Importe  ELSE -Importe END,
      	       RemanenteDisponible = CASE WHEN UPPER(Tipo) = 'REDUCCION'  THEN -Importe ELSE NULL END
      	 WHERE ID = @ID
      
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
        UPDATE CP
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	       Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END

      -- checar que no quede el disponible en rojo bajo ningun motivo
      IF @Ok IN (NULL, 80030)
      BEGIN
      	SELECT @ClavePresupuestal = NULL
      	SELECT @ClavePresupuestal = MIN(n.ClavePresupuestal)
      	  FROM CPNeto n
      	 WHERE n.Empresa = @Empresa AND n.Proyecto = @Proyecto 
      	   AND n.ClavePresupuestal IN (SELECT DISTINCT d.ClavePresupuestal FROM CPD d WHERE d.ID = @ID)
    	   AND (ISNULL(n.Presupuesto, 0.0) < 0.0 OR ISNULL(n.Comprometido, 0.0) < 0.0 OR ISNULL(n.Comprometido2, 0.0) < 0.0 OR (ISNULL(n.Devengado, 0.0) + ISNULL(n.Anticipos, 0.0) < 0.0) OR ISNULL(n.Devengado2, 0.0) < 0.0 OR ISNULL(n.Ejercido, 0.0) < 0.0 OR ISNULL(n.EjercidoPagado, 0.0) < 0.0 OR ISNULL(n.RemanenteDisponible, 0.0) < 0.0 OR ISNULL(n.Sobrante, 0.0) < 0.0 OR ISNULL(n.Disponible, 0.0) < 0.0)
      	IF @ClavePresupuestal IS NOT NULL SELECT @Ok = 25580
      	  
        IF @ClavePresupuestal IS NULL
      	BEGIN
          SELECT @ClavePresupuestal = MIN(n.ClavePresupuestal)
      	    FROM CPArtNeto n 
      	   WHERE n.Empresa = @Empresa AND n.Proyecto = @Proyecto 
      	   AND n.ClavePresupuestal IN (SELECT DISTINCT d.ClavePresupuestal FROM CPD d WHERE d.ID = @ID)
    	   AND ISNULL(n.Importe, 0.0) < 0.0
          IF @ClavePresupuestal IS NOT NULL SELECT @Ok = 25590
      	END

        IF @ClavePresupuestal IS NULL
      	BEGIN
          SELECT @ClavePresupuestal = MIN(n.ClavePresupuestal)
      	    FROM CPCalDisponible n 
      	   WHERE n.Empresa = @Empresa AND n.Proyecto = @Proyecto 
      	   AND n.ClavePresupuestal IN (SELECT DISTINCT d.ClavePresupuestal FROM CPD d WHERE d.ID = @ID)
    	   AND ISNULL(n.Presupuesto, 0.0) < 0.0
          IF @ClavePresupuestal IS NOT NULL SELECT @Ok = 25600
          
          IF @MovTipo = 'CP.RF'
          BEGIN
            SELECT @ClavePresupuestal = MIN(n.ClavePresupuestal)
              FROM CPCalReservado n 
      	     WHERE n.Empresa = @Empresa AND n.Proyecto = @Proyecto 
      	     AND n.ClavePresupuestal IN (SELECT DISTINCT d.ClavePresupuestal FROM CPD d WHERE d.ID = @ID)
    	     AND ISNULL(n.Presupuesto, 0.0) < 0.0
            --IF @ClavePresupuestal IS NOT NULL SELECT @Ok = 25601           
          END
      	END

      	IF @ClavePresupuestal IS NOT NULL SELECT @OkRef = RTRIM(@Mov)+'<BR>'+@ClavePresupuestal
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
      BEGIN
        DECLARE @PolizaDescuadrada TABLE (Cuenta varchar(20) NULL, SubCuenta varchar(50) NULL, Concepto varchar(50) NULL, Debe money NULL, Haber money NULL, SucursalContable int NULL)
        IF EXISTS(SELECT * FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID)
        INSERT @PolizaDescuadrada (Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID 
        ROLLBACK TRANSACTION
        DELETE PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID
        INSERT PolizaDescuadrada (Modulo, ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT @Modulo, @ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM @PolizaDescuadrada
      END
    
  RETURN
END
GO

/**************** spCP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCP') and type = 'P') drop procedure dbo.spCP
GO
CREATE PROCEDURE spCP
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
    @CfgContXGenerar	varchar(20),
    @OrigenTipo		varchar(10),
    @Origen		varchar(20),
    @OrigenID		varchar(20),
    @OrigenMovTipo	varchar(20)

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
         @Concepto = Concepto, @Referencia = Referencia, @OrigenTipo = NULLIF(RTRIM(OrigenTipo), ''), @Origen = NULLIF(RTRIM(Origen), ''), @OrigenID = NULLIF(RTRIM(OrigenID), '')
    FROM CP
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
    SELECT @OrigenMovTipo = Clave FROM MovTipo WHERE Modulo = @OrigenTipo AND Mov = @Origen   

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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'PENDIENTE')) OR 
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
  
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR'
    BEGIN
      IF @MovTipo = 'CP.AP' 
        SELECT @EstatusNuevo = 'PENDIENTE'
      ELSE
        SELECT @EstatusNuevo = 'CONCLUIDO'
    END   

    -- Verificar antes de Afectar
    IF /*(@Conexion = 0 OR @Accion = 'CANCELAR') AND */@Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spCPVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, @FechaRegistro,
                         @Proyecto, @Ejercicio, @Periodo, 
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
      EXEC spCPAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
		       @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                       @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
                       @OrigenTipo, @Origen, @OrigenID, @OrigenMovTipo,
		       @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                       @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
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


/**************** spCPVerificarCalMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCPVerificarCalMov') and type = 'P') drop procedure dbo.spCPVerificarCalMov
GO
CREATE PROCEDURE spCPVerificarCalMov
		   @Modulo		char(5), 
		   @ID			int, 			

		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @ClavePresupuestal	varchar(50),
    @Importe		money,
    @Importe2		money,
    @ImporteTotal	money

  SELECT @ImporteTotal = 0.0
  IF @Modulo = 'COMS'
    DECLARE crCPVerificarCalMov CURSOR LOCAL FOR 
     SELECT ClavePresupuestal, SUM(Importe)
       FROM CPCompra
      WHERE ID = @ID 
      GROUP BY ClavePresupuestal
      ORDER BY ClavePresupuestal
  ELSE
  IF @Modulo = 'GAS'
    DECLARE crCPVerificarCalMov CURSOR LOCAL FOR 
     SELECT ClavePresupuestal, SUM(Importe)
       FROM CPGasto
      WHERE ID = @ID 
      GROUP BY ClavePresupuestal
      ORDER BY ClavePresupuestal
  ELSE
    DECLARE crCPVerificarCalMov CURSOR LOCAL FOR 
     SELECT ClavePresupuestal, SUM(Importe)
       FROM CPMovImpuesto
      WHERE Modulo = @Modulo AND ModuloID = @ID 
      GROUP BY ClavePresupuestal
      ORDER BY ClavePresupuestal

  OPEN crCPVerificarCalMov
  FETCH NEXT FROM crCPVerificarCalMov INTO @ClavePresupuestal, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@ClavePresupuestal), '') IS NOT NULL
    BEGIN    	
      SELECT @Importe2 = 0.0, @ImporteTotal = @ImporteTotal + @Importe
      SELECT @Importe2 = ISNULL(SUM(Importe), 0.0)
        FROM CPCalMov
       WHERE Modulo = @Modulo AND ModuloID = @ID AND ClavePresupuestal = @ClavePresupuestal
      IF ROUND(@Importe, 0) <> ROUND(@Importe2, 0) 
        SELECT @Ok = 25620, @OkRef = @ClavePresupuestal+'<BR>Diferencia '+CONVERT(varchar, @Importe-@Importe2)
    END
    FETCH NEXT FROM crCPVerificarCalMov INTO @ClavePresupuestal, @Importe
  END
  CLOSE crCPVerificarCalMov
  DEALLOCATE crCPVerificarCalMov
  
  IF @Ok IS NULL
  BEGIN
    SELECT @Importe2 = 0.0
    SELECT @Importe2 = ISNULL(SUM(Importe), 0.0) FROM CPCalMov WHERE Modulo = @Modulo AND ModuloID = @ID  
    IF ROUND(@ImporteTotal, 0) <> ROUND(@Importe2, 0) 
      SELECT @Ok = 25630, @OkRef = 'Diferencia '+CONVERT(varchar, @ImporteTotal-@Importe2)
  END	
  RETURN
END
GO


/**************** spGenerarCP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCP') and type = 'P') drop procedure dbo.spGenerarCP
GO
CREATE PROCEDURE spGenerarCP
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Modulo		char(5), 
		   @ID			int, 			
		   @Estatus		char(15), 
                   @EstatusNuevo	char(15),
		   @Usuario		char(10),
		   @FechaEmision	datetime, 	
		   @FechaRegistro	datetime,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @AfectarCP		varchar(20),
		   @EsAjuste		bit,

		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @CPID		int,
    @CPMov		varchar(20),
    @CPMovReservado	varchar(20),
    @CPMovID		varchar(20),
    @OrigenTipo		varchar(10), 
    @Origen		varchar(20), 
    @OrigenID		varchar(20), 
    @Moneda		varchar(10),
    @TipoCambio		float,
    @Proyecto		varchar(50),
    @UEN		int,
    @AplicarCP		varchar(20),
    @IDAplica		int,
    @Aplica		varchar(20),
    @AplicaID		varchar(20),
    @AplicaImporteTotal	money,
    @AplicaFactor	float,
    @CxTipoCambio	float,
    @FactorCP		float,
    @Multiple		bit,
    @SepararImpuestos	bit,
    @CPImpuesto1	varchar(50),
    @CPImpuesto2	varchar(50),
    @CPImpuesto3	varchar(50),
    @CPRetencion1	varchar(50), --BUG15710
    @CPRetencion2	varchar(50), --BUG15710
    @CPRetencion3	varchar(50), --BUG15710        
    @ReservarCP		varchar(20),
    --@AnticiposCP	varchar(20),
    @Tipo		varchar(20),
    @ContMoneda		varchar(10),
    @ContTipoCambio	float

  SELECT @CxTipoCambio = NULL
  SELECT @ContMoneda = m.Moneda, @ContTipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda
  
  SELECT @AplicarCP = NULL, @ReservarCP = NULL--, @AnticiposCP = NULL
  IF @EstatusNuevo = 'CANCELADO'
  BEGIN
    DECLARE crCP CURSOR LOCAL FOR 
     SELECT ID, Mov, MovID
       FROM CP
      WHERE Empresa = @Empresa AND Estatus = 'CONCLUIDO' AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID
      ORDER BY ID
      
    OPEN crCP
    FETCH NEXT FROM crCP INTO @CPID, @CPMov, @CPMovID
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spAfectar 'CP', @CPID, 'CANCELAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        EXEC spMovFlujo @Sucursal, 'CANCELAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'CP', @CPID, @CPMov, @CPMovID, @Ok OUTPUT
      END
      FETCH NEXT FROM crCP INTO @CPID, @CPMov, @CPMovID
    END
    CLOSE crCP
    DEALLOCATE crCP

    RETURN
  END ELSE
  BEGIN    
    SELECT @CPMov = CPOperacion,
           @CPMovReservado = CPReservadoFlujo
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa

    SELECT @ReservarCP = UPPER(ReservarCP)/*,
           @AnticiposCP = UPPER(AnticiposCP)*/
      FROM MovTipo
     WHERE Modulo = @Modulo AND Mov = @Mov
     
    EXEC spMovInfo @ID, @Modulo, @Moneda = @Moneda OUTPUT, @TipoCambio = @TipoCambio OUTPUT, @Proyecto = @Proyecto OUTPUT, @UEN = @UEN OUTPUT,
                   @OrigenTipo = @OrigenTipo OUTPUT, @Origen = @Origen OUTPUT, @OrigenID = @OrigenID OUTPUT

    SELECT @FactorCP = 1.0
    SELECT @FactorCP = ISNULL(FactorCP, 1.0)
      FROM MovTipo
     WHERE Modulo = @Modulo AND Mov = @Mov
     
    DECLARE @CPD TABLE (
      Renglon			int		NOT NULL IDENTITY(2048, 1024) PRIMARY KEY,
      ClavePresupuestal		 varchar(50)	NULL,
      ClavePresupuestalImpuesto1 varchar(50)	NULL,
      ClavePresupuestalRetencion1 varchar(50)	NULL, --BUG15710      
      AfectarCP			varchar(20)	NULL,
      AplicarCP			varchar(20)	NULL,
      Aplica			varchar(20)	NULL,
      AplicaID			varchar(20)	NULL,
      --IDAplica		int		NULL,
      AplicaTipoCambio		float		NULL,
      Importe			money           NULL,
      Impuesto1			money		NULL,
      Impuesto2			money		NULL,
      Impuesto3			money		NULL,      
      Retencion1		money		NULL, --BUG15710
      Retencion2		money		NULL, --BUG15710
      Retencion3		money		NULL, --BUG15710
      ImporteTotal		AS		ISNULL(Importe, 0.0)+ISNULL(Impuesto1, 0.0)+ISNULL(Impuesto2, 0.0)+ISNULL(Impuesto3, 0.0)-ISNULL(Retencion1, 0.0), --BUG15710

      Presupuesto		money		NULL,
      Comprometido		money		NULL,
      Comprometido2		money		NULL,
      Devengado			money		NULL,
      Devengado2		money		NULL,
      Ejercido			money		NULL,
      EjercidoPagado		money		NULL,
      Anticipos			money		NULL,
      RemanenteDisponible	money		NULL,
      Sobrante			money		NULL)


    IF @ReservarCP IN ('SI', 'DESRESERVAR')
    BEGIN
      EXEC spCPVerificarCalMov @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL
      BEGIN
        IF @ReservarCP = 'SI' SELECT @Tipo = 'Ampliacion' ELSE SELECT @Tipo = 'Reduccion'
        INSERT CP (
                Sucursal,  Empresa,  Usuario,  Mov,             Moneda,      TipoCambio,      FechaEmision,  Proyecto,  UEN,  Estatus,      OrigenTipo, Origen, OrigenID)
        VALUES (@Sucursal, @Empresa, @Usuario, @CPMovReservado, @ContMoneda, @ContTipoCambio, @FechaEmision, @Proyecto, @UEN, 'SINAFECTAR', @Modulo,    @Mov,   @MovID)
        SELECT @CPID = SCOPE_IDENTITY()

        INSERT @CPD (ClavePresupuestal, Importe)
        SELECT ClavePresupuestal, SUM(Importe)
          FROM CPCalMov
         WHERE Modulo = @Modulo AND ModuloID = @ID
         GROUP BY ClavePresupuestal       
         
        INSERT CPD (
    	        ID,    Sucursal,  Renglon, Tipo,  ClavePresupuestal, Importe)
         SELECT @CPID, @Sucursal, Renglon, @Tipo, ClavePresupuestal, Importe*@TipoCambio/@ContTipoCambio
           FROM @CPD

        INSERT CPCal(
       	       ID,    Sucursal,  ClavePresupuestal, Tipo, Ejercicio, Periodo, Importe)
        SELECT @CPID, @Sucursal, ClavePresupuestal, Tipo, Ejercicio, Periodo, Importe*@TipoCambio/@ContTipoCambio
          FROM CPCalMov
         WHERE Modulo = @Modulo AND ModuloID = @ID

        EXEC spAfectar 'CP', @CPID, 'AFECTAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
        BEGIN
          SELECT @CPMovID = MovID FROM CP WHERE ID = @CPID
           EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'CP', @CPID, @CPMovReservado, @CPMovID, @Ok OUTPUT
        END
        SELECT @CPID = NULL, @CPMovID = NULL
        DELETE @CPD
      END
    END
         
    IF @EsAjuste = 1 
    BEGIN
      INSERT @CPD (
      	     ClavePresupuestal,   AfectarCP,  Importe)
      SELECT d.ClavePresupuestal, @AfectarCP, CASE @AfectarCP 
						WHEN 'Presupuesto'     THEN d.Presupuesto
						WHEN 'Comprometido'    THEN d.Comprometido
						WHEN 'Comprometido 2'  THEN d.Comprometido2
						WHEN 'Devengado'       THEN d.Devengado
						WHEN 'Devengado 2'     THEN d.Devengado2
						WHEN 'Ejercido'        THEN d.Ejercido
						WHEN 'Ejercido Pagado' THEN d.EjercidoPagado
						WHEN 'Remanente Disp.' THEN d.RemanenteDisponible
						WHEN 'Sobrante'        THEN d.Ejercido
						WHEN 'Anticipos'       THEN d.Anticipos
					      END
        FROM CP e 
        JOIN CPD d ON d.ID = e.ID
       WHERE e.Empresa = @Empresa AND e.Estatus = 'CONCLUIDO' AND e.OrigenTipo = @Modulo AND e.Origen = @Mov AND e.OrigenID = @MovID

      INSERT @CPD (
      	     ClavePresupuestal,   AfectarCP,  Importe)
      SELECT d.ClavePresupuestal, @AfectarCP, CASE @AfectarCP 
						WHEN 'Presupuesto'     THEN d.Presupuesto
						WHEN 'Comprometido'    THEN d.Comprometido
						WHEN 'Comprometido 2'  THEN d.Comprometido2
						WHEN 'Devengado'       THEN d.Devengado
						WHEN 'Devengado 2'     THEN d.Devengado2
						WHEN 'Ejercido'        THEN d.Ejercido
						WHEN 'Ejercido Pagado' THEN d.EjercidoPagado
						WHEN 'Remanente Disp.' THEN d.RemanenteDisponible
						WHEN 'Sobrante'        THEN d.Ejercido
						WHEN 'Anticipos'       THEN d.Anticipos
					      END
        FROM CP e 
        JOIN CPD d ON d.ID = e.ID
       WHERE e.Empresa = @Empresa AND e.Estatus = 'CONCLUIDO' AND d.Aplica = @Mov AND d.AplicaID = @MovID
    END ELSE
    IF @Modulo = 'GAS'
    BEGIN      	    	
      IF @MovTipo IN ('GAS.A', 'GAS.DA', 'GAS.C', 'GAS.CCH', 'GAS.G', 'GAS.GTC', 'GAS.GP', 'GAS.CP', 'GAS.DA', 'GAS.SR', 'GAS.ASC', 'GAS.CI')
      BEGIN
        SELECT @AplicarCP = mt.AfectarCP,
               @Aplica = g.MovAplica,
               @AplicaID = g.MovAplicaID,
               @AplicaImporteTotal = ISNULL(g.Importe, 0.0)+ISNULL(g.Impuestos, 0.0)-ISNULL(g.Retencion, 0.0), --BUG15710               
               @Multiple = ISNULL(g.Multiple, 0)
          FROM Gasto g
          JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = g.MovAplica
         WHERE g.ID = @ID
         IF @Multiple = 1 SELECT @Ok = 25610
       END

      /*INSERT @CPD (
             ClavePresupuestal, Importe,  Impuesto1, Impuesto2, Impuesto3, AfectarCP,  AplicarCP)
      SELECT ClavePresupuestal, SubTotal, Importe1,  Importe2,  Importe3,  @AfectarCP, @AplicarCP
        FROM MovImpuesto
       WHERE Modulo = @Modulo AND ModuloID = @ID*/

      IF @MovTipo IN ('GAS.DA', 'GAS.SR', 'GAS.ASC')
      BEGIN
      	SELECT @IDAplica = MAX(ID) FROM Gasto WHERE Empresa = @Empresa AND Estatus IN ('CONCLUIDO', 'PENDIENTE') AND Mov = @Aplica AND MovID = @AplicaID
      	SELECT @AplicaFactor = @AplicaImporteTotal / NULLIF(ISNULL(Importe, 0.0)+ISNULL(Impuestos, 0.0)-ISNULL(Retencion, 0.0), 0.0) FROM Gasto WHERE ID = @IDAplica --BUG15710
        INSERT @CPD (
               ClavePresupuestal,   ClavePresupuestalImpuesto1,   ClavePresupuestalRetencion1,   Importe,                           Impuesto1,                           AfectarCP,  AplicarCP,  Aplica,  AplicaID) --BUG15710
        SELECT d.ClavePresupuestal, c.ClavePresupuestalImpuesto1, c.ClavePresupuestalRetencion1, SUM(d.ImporteLinea*@AplicaFactor), SUM(d.ImpuestosLinea*@AplicaFactor), @AfectarCP, @AplicarCP, @Aplica, @AplicaID --BUG15710
          FROM GastoT d
          LEFT OUTER JOIN Concepto c ON c.Modulo = @Modulo AND c.Concepto = d.Concepto
         WHERE d.ID = @IDAplica
         GROUP BY d.ClavePresupuestal, c.ClavePresupuestalImpuesto1, c.ClavePresupuestalRetencion1 --BUG15710
         ORDER BY d.ClavePresupuestal, c.ClavePresupuestalImpuesto1, c.ClavePresupuestalRetencion1 --BUG15710
      END ELSE
        INSERT @CPD (
               ClavePresupuestal,   ClavePresupuestalImpuesto1,   Importe,             Impuesto1,             Retencion1,             AfectarCP,  AplicarCP,  Aplica,  AplicaID) --BUG15710
        SELECT d.ClavePresupuestal, c.ClavePresupuestalImpuesto1, SUM(d.ImporteLinea), SUM(d.ImpuestosLinea), SUM(d.Retencion), @AfectarCP, @AplicarCP, @Aplica, @AplicaID --BUG15710
          FROM GastoT d
          LEFT OUTER JOIN Concepto c ON c.Modulo = @Modulo AND c.Concepto = d.Concepto
         WHERE d.ID = @ID      
         GROUP BY d.ClavePresupuestal, c.ClavePresupuestalImpuesto1, c.ClavePresupuestalRetencion1 --BUG15710
         ORDER BY d.ClavePresupuestal, c.ClavePresupuestalImpuesto1, c.ClavePresupuestalRetencion1 --BUG15710
    END ELSE
    IF @Modulo = 'COMS' 
    BEGIN
      INSERT @CPD (
             ClavePresupuestal,   ClavePresupuestalImpuesto1,   AfectarCP,  AplicarCP,    Aplica,   AplicaID,   Importe,          Impuesto1,             Impuesto2,             Impuesto3)
      SELECT d.ClavePresupuestal, a.ClavePresupuestalImpuesto1, @AfectarCP, mt.AfectarCP, d.Aplica, d.AplicaID, SUM(d.SubTotal), SUM(d.Impuesto1Total), SUM(d.Impuesto2Total), SUM(d.Impuesto3Total)
        FROM CompraTCalc d
        LEFT OUTER JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = d.Aplica AND UPPER(NULLIF(RTRIM(mt.AfectarCP), '')) NOT IN (NULL, 'NO')
        LEFT OUTER JOIN Art a ON a.Articulo = d.Articulo
       WHERE d.ID = @ID 
       GROUP BY d.ClavePresupuestal, a.ClavePresupuestalImpuesto1, mt.AfectarCP, d.Aplica, d.AplicaID
       ORDER BY d.ClavePresupuestal, a.ClavePresupuestalImpuesto1, mt.AfectarCP, d.Aplica, d.AplicaID
    END ELSE
    BEGIN
      IF @Modulo = 'CXC' SELECT @CxTipoCambio = ClienteTipoCambio   FROM Cxc WHERE ID = @ID ELSE
      IF @Modulo = 'CXP' SELECT @CxTipoCambio = ProveedorTipoCambio FROM Cxp WHERE ID = @ID 
      
      SELECT @AplicarCP = AplicarCP
        FROM MovTipo
       WHERE Modulo = @Modulo AND Mov = @Mov

      INSERT @CPD (
      	     ClavePresupuestal,    ClavePresupuestalImpuesto1,    AfectarCP,  AplicarCP,  Aplica, AplicaID, Importe,          Impuesto1,        Impuesto2,        Impuesto3)
      SELECT mi.ClavePresupuestal, mi.ClavePresupuestalImpuesto1, @AfectarCP, @AplicarCP, m.Mov,  m.MovID,  SUM(mi.SubTotal), SUM(mi.Importe1), SUM(mi.Importe2), SUM(mi.Importe3)
        FROM MovImpuesto mi
        JOIN Mov m ON m.Empresa = @Empresa AND m.Modulo = mi.OrigenModulo AND m.ID = mi.OrigenModuloID
       WHERE mi.Modulo = @Modulo AND mi.ModuloID = @ID
       GROUP BY mi.ClavePresupuestal, mi.ClavePresupuestalImpuesto1, m.Mov, m.MovID
       ORDER BY mi.ClavePresupuestal, mi.ClavePresupuestalImpuesto1, m.Mov, m.MovID
       
      -- en tesoreria quitar el aplica para que no vuelta a aplicar el tipo de cambio del origen, cuando el movimiento ya esta en pesos
      IF @Modulo = 'DIN' AND @TipoCambio = 1.0
        UPDATE @CPD
           SET Aplica = NULL, AplicaID = NULL 
    END

    IF EXISTS(SELECT * FROM @CPD) AND @Ok IS NULL
    BEGIN     	      	
      SELECT @SepararImpuestos = ISNULL(CPSepararImpuestos, 0),
             @CPImpuesto1 = NULLIF(RTRIM(CPClavePresupuestalImpuesto1), ''),
             @CPImpuesto2 = NULLIF(RTRIM(CPClavePresupuestalImpuesto2), ''),
             @CPImpuesto3 = NULLIF(RTRIM(CPClavePresupuestalImpuesto3), ''),
             @CPRetencion1 = NULLIF(RTRIM(CPClavePresupuestalRetencion1), ''), --BUG15710
             @CPRetencion2 = NULLIF(RTRIM(CPClavePresupuestalRetencion2), ''), --BUG15710
             @CPRetencion3 = NULLIF(RTRIM(CPClavePresupuestalRetencion3), '')  --BUG15710             
        FROM EmpresaCfg
       WHERE Empresa = @Empresa
       
      INSERT CP (
              Sucursal,  Empresa,  Usuario,  Mov,    Moneda,      TipoCambio,      FechaEmision,  Proyecto,  UEN,  Estatus,      OrigenTipo, Origen, OrigenID)
      VALUES (@Sucursal, @Empresa, @Usuario, @CPMov, @ContMoneda, @ContTipoCambio, @FechaEmision, @Proyecto, @UEN, 'SINAFECTAR', @Modulo,    @Mov,   @MovID)
      SELECT @CPID = SCOPE_IDENTITY()

      IF @EsAjuste = 1
      	SELECT @FactorCP = -@FactorCP

      /* si tiene ClavePresupuestalImpuesto1 especifico a nivel articulo o concepto */
      INSERT @CPD (
             ClavePresupuestal,          AfectarCP, AplicarCP, Aplica, AplicaID, Importe)
      SELECT ClavePresupuestalImpuesto1, AfectarCP, AplicarCP, Aplica, AplicaID, Impuesto1
        FROM @CPD
       WHERE NULLIF(Impuesto1, 0.0) IS NOT NULL AND ClavePresupuestalImpuesto1 IS NOT NULL

      UPDATE @CPD
         SET Impuesto1 = NULL
       WHERE NULLIF(Impuesto1, 0.0) IS NOT NULL AND ClavePresupuestalImpuesto1 IS NOT NULL
       
      --BUG15710
      INSERT @CPD (
             ClavePresupuestal,           AfectarCP, AplicarCP, Aplica, AplicaID, Importe)
      SELECT ClavePresupuestalRetencion1, AplicarCP, AfectarCP, Aplica, AplicaID, Impuesto1
        FROM @CPD
       WHERE NULLIF(Impuesto1, 0.0) IS NOT NULL AND NULLIF(ClavePresupuestalRetencion1,'') IS NOT NULL

      --BUG15710
      UPDATE @CPD
         SET Retencion1 = NULL
       WHERE NULLIF(Retencion1, 0.0) IS NOT NULL AND NULLIF(ClavePresupuestalRetencion1,'') IS NOT NULL
       
       /* ClavePresupuestalImpuesto1 */
      IF @SepararImpuestos = 1
      BEGIN
      	IF @CPImpuesto1 IS NOT NULL
      	  INSERT @CPD (
      	         ClavePresupuestal, AfectarCP, AplicarCP, Aplica, AplicaID, Importe)
      	  SELECT @CPImpuesto1,      AfectarCP, AplicarCP, Aplica, AplicaID, Impuesto1
      	    FROM @CPD
      	   WHERE NULLIF(Impuesto1, 0.0) IS NOT NULL AND ClavePresupuestalImpuesto1 IS NULL

      	IF @CPImpuesto2 IS NOT NULL
      	  INSERT @CPD (
      	         ClavePresupuestal, AfectarCP, AplicarCP, Aplica, AplicaID, Importe)
      	  SELECT @CPImpuesto2,      AfectarCP, AplicarCP, Aplica, AplicaID, Impuesto2
      	    FROM @CPD
      	   WHERE NULLIF(Impuesto2, 0.0) IS NOT NULL

      	IF @CPImpuesto3 IS NOT NULL
      	  INSERT @CPD (
      	         ClavePresupuestal, AfectarCP, AplicarCP, Aplica, AplicaID, Importe)
      	  SELECT @CPImpuesto3,      AfectarCP, AplicarCP, Aplica, AplicaID, Impuesto3
      	    FROM @CPD
      	   WHERE NULLIF(Impuesto3, 0.0) IS NOT NULL

		--BUG15710
      	IF @CPRetencion1 IS NOT NULL
      	  INSERT @CPD (
      	         ClavePresupuestal, AfectarCP, AplicarCP, Aplica, AplicaID, Importe)
      	  SELECT @CPRetencion1,     AplicarCP, AfectarCP, Aplica, AplicaID, Retencion1
      	    FROM @CPD
      	   WHERE NULLIF(Retencion1, 0.0) IS NOT NULL AND NULLIF(ClavePresupuestalRetencion1,'') IS NULL --MEJORARETENCIONCP

		--BUG15710
      	IF @CPRetencion2 IS NOT NULL
      	  INSERT @CPD (
      	         ClavePresupuestal, AfectarCP, AplicarCP, Aplica, AplicaID, Importe)
      	  SELECT @CPRetencion2,     AplicarCP, AfectarCP, Aplica, AplicaID, Retencion2
      	    FROM @CPD
      	   WHERE NULLIF(Retencion2, 0.0) IS NOT NULL

		--BUG15710
      	IF @CPRetencion3 IS NOT NULL
      	  INSERT @CPD (
      	         ClavePresupuestal, AfectarCP, AplicarCP, Aplica, AplicaID, Importe)
      	  SELECT @CPRetencion3,     AplicarCP, AfectarCP, Aplica, AplicaID, Retencion3
      	    FROM @CPD
      	   WHERE NULLIF(Retencion3, 0.0) IS NOT NULL

        UPDATE @CPD
           SET Impuesto1 = NULL, Impuesto2 = NULL, Impuesto3 = NULL, Retencion1 = NULL, Retencion2 = NULL, Retencion3 = NULL --BUG15710
      END
      
      UPDATE @CPD
         SET AplicaTipoCambio = m.TipoCambio
        FROM @CPD d
        JOIN Mov m ON m.Empresa = @Empresa AND m.Mov = d.Aplica AND m.MovID = d.AplicaID

      -- Convertir a MN        
      UPDATE @CPD
         SET Importe = Importe * @TipoCambio / @ContTipoCambio,
             Impuesto1 = Impuesto1 * @TipoCambio / @ContTipoCambio,
             Impuesto2 = Impuesto2 * @TipoCambio / @ContTipoCambio,
             Impuesto3 = Impuesto3 * @TipoCambio / @ContTipoCambio
/*
      UPDATE @CPD
         SET --IDAplica = dbo.fnModuloID(@Empresa, @Modulo, Aplica, AplicaID, NULL, NULL),
             Presupuesto	 = CASE WHEN AfectarCP = 'Presupuesto'     THEN ImporteTotal ELSE 0.0 END + CASE WHEN AplicarCP = 'Presupuesto'     THEN -dbo.fnR3(@TipoCambio, ImporteTotal, ISNULL(AplicaTipoCambio, 1)) ELSE 0.0 END,
             Comprometido	 = CASE WHEN AfectarCP = 'Comprometido'    THEN ImporteTotal ELSE 0.0 END + CASE WHEN AplicarCP = 'Comprometido'    THEN -dbo.fnR3(@TipoCambio, ImporteTotal, ISNULL(AplicaTipoCambio, 1)) ELSE 0.0 END,
             Comprometido2	 = CASE WHEN AfectarCP = 'Comprometido 2'  THEN ImporteTotal ELSE 0.0 END + CASE WHEN AplicarCP = 'Comprometido 2'  THEN -dbo.fnR3(@TipoCambio, ImporteTotal, ISNULL(AplicaTipoCambio, 1)) ELSE 0.0 END,
             Devengado  	 = CASE WHEN AfectarCP = 'Devengado'       THEN ImporteTotal ELSE 0.0 END + CASE WHEN AplicarCP = 'Devengado'       THEN -dbo.fnR3(@TipoCambio, ImporteTotal, ISNULL(AplicaTipoCambio, 1)) ELSE 0.0 END,
             Devengado2	         = CASE WHEN AfectarCP = 'Devengado 2'     THEN ImporteTotal ELSE 0.0 END + CASE WHEN AplicarCP = 'Devengado 2'     THEN -dbo.fnR3(@TipoCambio, ImporteTotal, ISNULL(AplicaTipoCambio, 1)) ELSE 0.0 END,
             Ejercido		 = CASE WHEN AfectarCP = 'Ejercido'        THEN ImporteTotal ELSE 0.0 END + CASE WHEN AplicarCP = 'Ejercido'        THEN -dbo.fnR3(@TipoCambio, ImporteTotal, ISNULL(AplicaTipoCambio, 1)) ELSE 0.0 END,
             EjercidoPagado	 = CASE WHEN AfectarCP = 'Ejercido Pagado' THEN ImporteTotal ELSE 0.0 END + CASE WHEN AplicarCP = 'Ejercido Pagado' THEN -dbo.fnR3(@TipoCambio, ImporteTotal, ISNULL(AplicaTipoCambio, 1)) ELSE 0.0 END,
             RemanenteDisponible = CASE WHEN AfectarCP = 'Remanente Disp.' THEN ImporteTotal ELSE 0.0 END + CASE WHEN AplicarCP = 'Remanente Disp.' THEN -dbo.fnR3(@TipoCambio, ImporteTotal, ISNULL(AplicaTipoCambio, 1)) ELSE 0.0 END,
             Sobrante		 = CASE WHEN AfectarCP = 'Sobrante'        THEN ImporteTotal ELSE 0.0 END + CASE WHEN AplicarCP = 'Sobrante'        THEN -dbo.fnR3(@TipoCambio, ImporteTotal, ISNULL(AplicaTipoCambio, 1)) ELSE 0.0 END,
             Anticipos		 = CASE WHEN AfectarCP = 'Anticipos'       THEN ImporteTotal ELSE 0.0 END + CASE WHEN AplicarCP = 'Anticipos'       THEN -dbo.fnR3(@TipoCambio, ImporteTotal, ISNULL(AplicaTipoCambio, 1)) ELSE 0.0 END 
*/
      UPDATE @CPD
         SET --IDAplica = dbo.fnModuloID(@Empresa, @Modulo, Aplica, AplicaID, NULL, NULL),
             Presupuesto	 = CASE WHEN AfectarCP = 'Presupuesto'     THEN ImporteTotal END,
             Comprometido	 = CASE WHEN AfectarCP = 'Comprometido'    THEN ImporteTotal END,
             Comprometido2	 = CASE WHEN AfectarCP = 'Comprometido 2'  THEN ImporteTotal END,
             Devengado  	 = CASE WHEN AfectarCP = 'Devengado'       THEN ImporteTotal END,
             Devengado2	         = CASE WHEN AfectarCP = 'Devengado 2'     THEN ImporteTotal END,
             Ejercido		 = CASE WHEN AfectarCP = 'Ejercido'        THEN ImporteTotal END,
             EjercidoPagado	 = CASE WHEN AfectarCP = 'Ejercido Pagado' THEN ImporteTotal END,
             RemanenteDisponible = CASE WHEN AfectarCP = 'Remanente Disp.' THEN ImporteTotal END,
             Sobrante		 = CASE WHEN AfectarCP = 'Sobrante'        THEN ImporteTotal END,
             Anticipos		 = CASE WHEN AfectarCP = 'Anticipos'       THEN ImporteTotal END

--select * from @cpd
      IF @CxTipoCambio IS NOT NULL
      BEGIN
        UPDATE @CPD
           SET Presupuesto	 = ISNULL(Presupuesto, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Presupuesto'     THEN ImporteTotal/@CxTipoCambio*ISNULL(AplicaTipoCambio, 1) END, 0.0),
               Comprometido	 = ISNULL(Comprometido, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Comprometido'    THEN ImporteTotal/@CxTipoCambio*ISNULL(AplicaTipoCambio, 1) END, 0.0),
               Comprometido2	 = ISNULL(Comprometido2, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Comprometido 2'  THEN ImporteTotal/@CxTipoCambio*ISNULL(AplicaTipoCambio, 1) END, 0.0),
               Devengado  	 = ISNULL(Devengado, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Devengado'       THEN ImporteTotal/@CxTipoCambio*ISNULL(AplicaTipoCambio, 1) END, 0.0),
               Devengado2        = ISNULL(Devengado2, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Devengado 2'     THEN ImporteTotal/@CxTipoCambio*ISNULL(AplicaTipoCambio, 1) END, 0.0),
               Ejercido		 = ISNULL(Ejercido, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Ejercido'        THEN ImporteTotal/@CxTipoCambio*ISNULL(AplicaTipoCambio, 1) END, 0.0),
               EjercidoPagado	 = ISNULL(EjercidoPagado, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Ejercido Pagado' THEN ImporteTotal/@CxTipoCambio*ISNULL(AplicaTipoCambio, 1) END, 0.0),
               RemanenteDisponible = ISNULL(RemanenteDisponible, 0.0)	- ISNULL(CASE WHEN AplicarCP = 'Remanente Disp.' THEN ImporteTotal/@CxTipoCambio*ISNULL(AplicaTipoCambio, 1) END, 0.0),
               Sobrante		 = ISNULL(Sobrante, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Sobrante'        THEN ImporteTotal/@CxTipoCambio*ISNULL(AplicaTipoCambio, 1) END, 0.0),
               Anticipos	 = ISNULL(Anticipos, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Anticipos'       THEN ImporteTotal/@CxTipoCambio*ISNULL(AplicaTipoCambio, 1) END, 0.0) 
      END ELSE
      BEGIN
        UPDATE @CPD
           SET Presupuesto	 = ISNULL(Presupuesto, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Presupuesto'     THEN ImporteTotal*ISNULL(AplicaTipoCambio, 1)/@TipoCambio END, 0.0),
               Comprometido	 = ISNULL(Comprometido, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Comprometido'    THEN ImporteTotal*ISNULL(AplicaTipoCambio, 1)/@TipoCambio END, 0.0),
               Comprometido2	 = ISNULL(Comprometido2, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Comprometido 2'  THEN ImporteTotal*ISNULL(AplicaTipoCambio, 1)/@TipoCambio END, 0.0),
               Devengado  	 = ISNULL(Devengado, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Devengado'       THEN ImporteTotal*ISNULL(AplicaTipoCambio, 1)/@TipoCambio END, 0.0),
               Devengado2        = ISNULL(Devengado2, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Devengado 2'     THEN ImporteTotal*ISNULL(AplicaTipoCambio, 1)/@TipoCambio END, 0.0),
               Ejercido		 = ISNULL(Ejercido, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Ejercido'        THEN ImporteTotal*ISNULL(AplicaTipoCambio, 1)/@TipoCambio END, 0.0),
               EjercidoPagado	 = ISNULL(EjercidoPagado, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Ejercido Pagado' THEN ImporteTotal*ISNULL(AplicaTipoCambio, 1)/@TipoCambio END, 0.0),
               RemanenteDisponible = ISNULL(RemanenteDisponible, 0.0)	- ISNULL(CASE WHEN AplicarCP = 'Remanente Disp.' THEN ImporteTotal*ISNULL(AplicaTipoCambio, 1)/@TipoCambio END, 0.0),
               Sobrante		 = ISNULL(Sobrante, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Sobrante'        THEN ImporteTotal*ISNULL(AplicaTipoCambio, 1)/@TipoCambio END, 0.0),
               Anticipos	 = ISNULL(Anticipos, 0.0)		- ISNULL(CASE WHEN AplicarCP = 'Anticipos'       THEN ImporteTotal*ISNULL(AplicaTipoCambio, 1)/@TipoCambio END, 0.0) 
      END
--select * from @cpd
--select @ok = 1
      /*IF @AnticiposCP = 'SI' 
        UPDATE @CPD SET Anticipos = ImporteTotal
      IF @AnticiposCP = 'DESANTICIPAR' 
        UPDATE @CPD SET Anticipos = -ImporteTotal*/
      INSERT CPD (
    	      ID,   Sucursal,   Renglon,      ClavePresupuestal, Aplica, AplicaID, Presupuesto,                             Comprometido,                             Comprometido2,                             Devengado,                             Devengado2,                             Ejercido,                             EjercidoPagado,                             Anticipos,                             RemanenteDisponible,                             Sobrante)
       SELECT @CPID, @Sucursal, MIN(Renglon), ClavePresupuestal, Aplica, AplicaID, NULLIF(SUM(Presupuesto)*@FactorCP, 0.0), NULLIF(SUM(Comprometido)*@FactorCP, 0.0), NULLIF(SUM(Comprometido2)*@FactorCP, 0.0), NULLIF(SUM(Devengado)*@FactorCP, 0.0), NULLIF(SUM(Devengado2)*@FactorCP, 0.0), NULLIF(SUM(Ejercido)*@FactorCP, 0.0), NULLIF(SUM(EjercidoPagado)*@FactorCP, 0.0), NULLIF(SUM(Anticipos)*@FactorCP, 0.0), NULLIF(SUM(RemanenteDisponible)*@FactorCP, 0.0), NULLIF(SUM(Sobrante)*@FactorCP, 0.0)
         FROM @CPD        
        WHERE NULLIF(RTRIM(ClavePresupuestal), '') IS NOT NULL
        GROUP BY ClavePresupuestal, Aplica, AplicaID
       HAVING (NULLIF(SUM(Presupuesto)*@FactorCP, 0.0) IS NOT NULL) OR (NULLIF(SUM(Comprometido)*@FactorCP, 0.0) IS NOT NULL) OR (NULLIF(SUM(Comprometido2)*@FactorCP, 0.0) IS NOT NULL) OR (NULLIF(SUM(Devengado)*@FactorCP, 0.0) IS NOT NULL) OR (NULLIF(SUM(Devengado2)*@FactorCP, 0.0) IS NOT NULL) OR (NULLIF(SUM(Ejercido)*@FactorCP, 0.0) IS NOT NULL) OR (NULLIF(SUM(EjercidoPagado)*@FactorCP, 0.0) IS NOT NULL) OR (NULLIF(SUM(Anticipos)*@FactorCP, 0.0) IS NOT NULL) OR (NULLIF(SUM(RemanenteDisponible)*@FactorCP, 0.0) IS NOT NULL) OR (NULLIF(SUM(Sobrante)*@FactorCP, 0.0) IS NOT NULL)

      IF @@ERROR <> 0
        SELECT @Ok = 1
        
      IF @Ok IS NULL
        EXEC spAfectar 'CP', @CPID, 'AFECTAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      BEGIN
        SELECT @CPMovID = MovID FROM CP WHERE ID = @CPID
         EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'CP', @CPID, @CPMov, @CPMovID, @Ok OUTPUT
      END
    END
  END


  RETURN
END
GO
