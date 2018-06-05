/* SP Vale   */

-- VALE.E  Emision Vales
-- VALE.C  Cancelacion Vales
-- VALE.CM Cobro Manual
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO

/**************** spValeVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spValeVerificar') and type = 'P') drop procedure dbo.spValeVerificar
GO
CREATE PROCEDURE spValeVerificar
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

		    @Tipo			varchar(50),
		    @Precio			money,
                    @TipoTieneVigencia		bit,
		    @FechaInicio		datetime,
		    @FechaTermino		datetime,

		    @Cliente			char(10),
		    @Agente			char(10),
		    @Condicion			varchar(50),
		    @Vencimiento		datetime,
		    @Descuento			varchar(50),
		    @CtaDinero			char(10),
		    @FormaPago			varchar(50),

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
		@Serie			varchar(20),
		@OrigenTipo		char(10),
		@ArticuloTarjetas	char(20),
		@CxcFormaCobroTarjetas	varchar(50),
		@ContMoneda		char(10),
		@MonedaVales		char(10),
		@TarjetaDestino			varchar(20) -- MPFP 20012009 Trasnferencia Saldo
		
		

  SELECT @Serie = NULL
  SELECT @ArticuloTarjetas = NULLIF(Articulo,'') FROM Vale WHERE ID = @ID
  SELECT @CxcFormaCobroTarjetas = CxcFormaCobroTarjetas, @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
--  SELECT @MonedaVales = ISNULL(NULLIF(Moneda,''), @ContMoneda) FROM FormaPago WHERE FormaPago = @CxcFormaCobroTarjetas
  SELECT @MonedaVales = NULLIF(Moneda,'') FROM FormaPago WHERE FormaPago = @CxcFormaCobroTarjetas
  IF @MovTipo = 'VALE.TT' SELECT @TarjetaDestino = NULLIF(RTRIM(TarjetaDestino), '') FROM Vale WHERE ID = @ID -- MPFP 20012009 Transferencia Saldo

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070

    IF @MovTipo IN ('VTAS.E', 'VALE.D') AND @Ok IS NULL
    BEGIN
      SELECT @Serie = MIN(d.Serie) FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'DISPONIBLE'
      IF @Serie IS NOT NULL SELECT @Ok = 36030, @OkRef = @Serie
    END ELSE
    IF @MovTipo IN ('VALE.V', 'VALE.EV', 'VALE.EO', 'VALE.O') AND @Ok IS NULL
    BEGIN
      SELECT @Serie = MIN(d.Serie) FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'CIRCULACION'
      IF @Serie IS NOT NULL SELECT @Ok = 36042, @OkRef = @Serie
    END ELSE
    IF @MovTipo = 'VALE.B' AND @Ok IS NULL
    BEGIN
      SELECT @Serie = MIN(d.Serie) FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'BLOQUEADO'
      IF @Serie IS NOT NULL SELECT @Ok = 36060, @OkRef = @Serie
    END ELSE
    IF @MovTipo = 'VALE.DB' AND @Ok IS NULL
    BEGIN
      SELECT @Serie = MIN(d.Serie) FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus NOT IN ('DISPONIBLE', 'CIRCULACION')
      IF @Serie IS NOT NULL SELECT @Ok = 36040, @OkRef = @Serie
    END ELSE
    IF @MovTipo = 'VALE.A' AND @Ok IS NULL
    BEGIN
      SELECT @Serie = MIN(d.Serie) FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'CONCLUIDO'
      IF @Serie IS NOT NULL SELECT @Ok = 36090, @OkRef = @Serie
    END ELSE
    IF @MovTipo = 'VALE.CM' AND @Ok IS NULL
    BEGIN
      SELECT @Serie = MIN(d.Serie) FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'COBRADO'
      IF @Serie IS NOT NULL SELECT @Ok = 36080, @OkRef = @Serie
    END 
    -- Validaciones de Tarjetas
    IF @MovTipo IN ('VALE.ET') AND @Ok IS NULL
    BEGIN
      SELECT @Serie = MIN(d.Serie) FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'DISPONIBLE'
      IF @Serie IS NOT NULL SELECT @Ok = 36011, @OkRef = @Serie
    END ELSE
/*    IF @MovTipo IN ('VALE.OT') AND @Ok IS NULL
    BEGIN
      SELECT @Serie = MIN(d.Serie) FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'CIRCULACION'
      IF @Serie IS NOT NULL SELECT @Ok = 36031, @OkRef = @Serie
    END ELSE*/
    IF @MovTipo = 'VALE.BT' AND @Ok IS NULL
    BEGIN
      SELECT @Serie = MIN(d.Serie) FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'BLOQUEADO'
      IF @Serie IS NOT NULL SELECT @Ok = 36031, @OkRef = @Serie
    END ELSE
    IF @MovTipo = 'VALE.DBT' AND @Ok IS NULL
    BEGIN
      SELECT @Serie = MIN(d.Serie) FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus NOT IN ('DISPONIBLE', 'CIRCULACION')
      IF @Serie IS NOT NULL SELECT @Ok = 36031, @OkRef = @Serie
    END ELSE -- MPFP 20012009 Transferencia Saldo
    IF @MovTipo = 'VALE.TT' AND @Ok IS NULL
    BEGIN
      IF (SELECT dbo.fnVerSaldoVale(@TarjetaDestino))<(SELECT SUM(Importe) FROM ValeD WHERE ID = @ID)
        SELECT @Ok = 30096, @OkRef = 'Tarjeta ' + @TarjetaDestino
    END
  END ELSE 
  BEGIN
    IF NOT EXISTS(SELECT * FROM ValeD WHERE ID = @ID) SELECT @Ok = 60010
    --IF @MovTipo IN ('VALE.E', 'VALE.EV', 'VALE.ET', 'VALE.EO') AND @Precio IS NULL SELECT @Ok = 20305 
    IF @MovTipo IN ('VALE.V', 'VALE.D', 'VALE.EV', 'VALE.EO', 'VALE.O'/*, 'VALE.OT'*/) AND @Cliente IS NULL SELECT @Ok = 40010
	IF @MovTipo IN ('VALE.TT') AND EXISTS (SELECT * FROM ValeD WHERE ID = @ID AND Serie = @TarjetaDestino) -- MPFP 20012009 Transferencia Saldo
		SELECT @Ok = 10060, @OkRef = 'No se puede transferir de la misma tarjeta: ' + @TarjetaDestino -- MPFP 20012009 Transferencia Saldo
	IF @MovTipo IN ('VALE.TT', 'VALE.CS') AND @Ok IS NULL
	BEGIN
	  SELECT @Serie = MIN(Serie) FROM ValeD WHERE ID = @ID AND dbo.fnVerSaldoVale(Serie)< Importe -- MPFP 20012009 Transferencia Saldo
	  IF @Serie IS NOT NULL
	    SELECT @Ok = 10060, @OkRef = 'Tarjeta ' + @Serie + ' excede su saldo: ' -- MPFP 20012009 Transferencia Saldo	
    END

    IF @Ok IS NULL
    BEGIN
      IF @MovTipo IN ('VALE.E', 'VALE.EV', 'VALE.ET', 'VALE.EO')
      BEGIN
        SELECT @Serie = MIN(d.Serie) FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND d.Serie = s.Serie AND Estatus <> 'CANCELADO' -- BUG9622

        IF @Serie IS NOT NULL
	BEGIN 
	  IF @MovTipo = 'VALE.ET'
	    SELECT @Ok = 36011, @OkRef = @Serie
	  ELSE
	    SELECT @Ok = 36010, @OkRef = @Serie
	END ELSE
        IF @MovTipo = 'VALE.ET'
        BEGIN
          IF (SELECT NULLIF(Almacen,'') FROM Vale WHERE ID = @ID) = NULL
            SELECT @Ok = 20830, @OkRef = NULL
          ELSE
          IF @ArticuloTarjetas is not null AND (SELECT Tipo FROM Art WHERE Articulo = @ArticuloTarjetas) <> 'Serie'
            SELECT @Ok = 10060, @OkRef = 'El Artículo indicado en el Movimiento debe ser Tipo Serie'
	  ELSE
          IF @ArticuloTarjetas is null OR NOT Exists(SELECT * FROM Art WHERE Articulo = @ArticuloTarjetas)
            SELECT @Ok = 10530
          ELSE
          BEGIN
            SELECT @Serie = MIN(d.Serie) 
              FROM ValeD d, ValeSerie s
             WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 0
            IF @Serie IS NOT NULL SELECT @Ok = 36101, @OkRef = @Serie
          END
        END
	ELSE
        BEGIN
          SELECT @Serie = MIN(d.Serie) 
            FROM ValeD d, ValeSerie s
           WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 1
          IF @Serie IS NOT NULL SELECT @Ok = 36100, @OkRef = @Serie
        END
      END ELSE
      BEGIN
	SELECT @Serie = MIN(d.Serie) FROM ValeD d WHERE d.ID = @ID AND d.Serie NOT IN (SELECT Serie FROM ValeSerie)
        IF @Serie IS NOT NULL 
	BEGIN 
	  IF @MovTipo in ('VALE.AT', 'VALE.BT', 'VALE.CT', 'VALE.DBT'/*, 'VALE.OT'*/)
	    SELECT @Ok = 36021, @OkRef = @Serie
	  ELSE
	    SELECT @Ok = 36020, @OkRef = @Serie
	END
        IF @MovTipo = 'VALE.AT' AND @Ok IS NULL
        BEGIN
          SELECT @OrigenTipo = NULLIF(OrigenTipo,'') FROM Vale WHERE ID = @ID
          IF @OrigenTipo IS NULL SELECT @Ok = 60070
        END 
      END
      
      

      IF @MovTipo IN ('VALE.V', 'VALE.C', 'VALE.CT', 'VALE.O'/*, 'VALE.OT'*/)
      BEGIN
        SELECT @Serie = MIN(d.Serie) 
          FROM ValeD d, ValeSerie s
         WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'DISPONIBLE'
        IF @Serie IS NOT NULL
	BEGIN 
	  IF @MovTipo in ('VALE.CT'/*, 'VALE.OT'*/) 
	    SELECT @Ok = 36031, @OkRef = @Serie
	  ELSE
	    SELECT @Ok = 36030, @OkRef = @Serie
	END
	IF @MovTipo IN ('VALE.V', 'VALE.C', 'VALE.O')
        BEGIN
          SELECT @Serie = MIN(d.Serie) 
            FROM ValeD d, ValeSerie s
           WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 1
          IF @Serie IS NOT NULL SELECT @Ok = 36101, @OkRef = @Serie
        END
	ELSE
        BEGIN
          SELECT @Serie = MIN(d.Serie) 
            FROM ValeD d, ValeSerie s
           WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 0
          IF @Serie IS NOT NULL SELECT @Ok = 36101, @OkRef = @Serie
        END
      END ELSE
      IF @MovTipo = 'VALE.D'
      BEGIN
        SELECT @Serie = MIN(d.Serie) 
          FROM ValeD d, ValeSerie s
         WHERE d.ID = @ID AND d.Serie = s.Serie AND (s.Estatus <> 'CIRCULACION' OR s.Cliente <> @Cliente)
        IF @Serie IS NOT NULL SELECT @Ok = 36045, @OkRef = @Serie
        ELSE
        BEGIN
          SELECT @Serie = MIN(d.Serie) 
            FROM ValeD d, ValeSerie s
           WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 1
          IF @Serie IS NOT NULL SELECT @Ok = 36100, @OkRef = @Serie
        END
      END ELSE
      IF @MovTipo in ('VALE.B', 'VALE.BT')
      BEGIN
        SELECT @Serie = MIN(d.Serie) 
          FROM ValeD d, ValeSerie s
         WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus NOT IN ('DISPONIBLE', 'CIRCULACION')
        IF @Serie IS NOT NULL
	BEGIN 
	  IF @MovTipo in ('VALE.BT') 
	    SELECT @Ok = 36041, @OkRef = @Serie
	  ELSE
	    SELECT @Ok = 36040, @OkRef = @Serie
	END
	IF @MovTipo = 'VALE.B'
        BEGIN
          SELECT @Serie = MIN(d.Serie) 
            FROM ValeD d, ValeSerie s
           WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 1
          IF @Serie IS NOT NULL SELECT @Ok = 36100, @OkRef = @Serie
        END
	ELSE
        BEGIN
          SELECT @Serie = MIN(d.Serie) 
            FROM ValeD d, ValeSerie s
           WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 0
          IF @Serie IS NOT NULL SELECT @Ok = 36101, @OkRef = @Serie
        END
      END ELSE
      IF @MovTipo in ('VALE.DB', 'VALE.DBT')
      BEGIN
        SELECT @Serie = MIN(d.Serie) 
          FROM ValeD d, ValeSerie s
         WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'BLOQUEADO'
        IF @Serie IS NOT NULL
	BEGIN 
	  IF @MovTipo in ('VALE.DBT') 
	    SELECT @Ok = 36061, @OkRef = @Serie
	  ELSE
	    SELECT @Ok = 36060, @OkRef = @Serie
	END
	IF @MovTipo = 'VALE.DB'
        BEGIN
          SELECT @Serie = MIN(d.Serie) 
            FROM ValeD d, ValeSerie s
           WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 1
          IF @Serie IS NOT NULL SELECT @Ok = 36100, @OkRef = @Serie
        END ELSE
        BEGIN
          SELECT @Serie = MIN(d.Serie) 
            FROM ValeD d, ValeSerie s
           WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 0
          IF @Serie IS NOT NULL SELECT @Ok = 36101, @OkRef = @Serie
        END
      END ELSE
      IF @MovTipo = 'VALE.A'
      BEGIN
        SELECT @Serie = MIN(d.Serie) 
          FROM ValeD d, ValeSerie s
         WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'COBRADO'
        IF @Serie IS NOT NULL SELECT @Ok = 36080, @OkRef = @Serie ELSE
        BEGIN
          SELECT @Serie = MIN(d.Serie) 
            FROM ValeD d, ValeSerie s
           WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 1
          IF @Serie IS NOT NULL SELECT @Ok = 36100, @OkRef = @Serie
        END
        IF @CtaDinero IS NULL SELECT @Ok = 40030
      END ELSE
      IF @MovTipo = 'VALE.AT'
      BEGIN
        SELECT @Serie = MIN(d.Serie) 
          FROM ValeD d, ValeSerie s
         WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'CIRCULACION'
        IF @Serie IS NOT NULL SELECT @Ok = 36043, @OkRef = @Serie ELSE
        IF @CtaDinero IS NULL SELECT @Ok = 40030, @OkRef = NULL ELSE
        IF (SELECT NULLIF(OrigenTipo,'') FROM Vale WHERE ID = @ID) = NULL SELECT @Ok = 25410 ELSE
        BEGIN
          SELECT @Serie = MIN(d.Serie) 
            FROM ValeD d, ValeSerie s
           WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 0
          IF @Serie IS NOT NULL SELECT @Ok = 36101, @OkRef = @Serie
        END
      END ELSE
--REQ 13386    
      IF @MovTipo IN('VALE.AMLDI','VALE.ACTMLDI')
      BEGIN
        SELECT @OrigenTipo = NULLIF(OrigenTipo,'') FROM Vale WHERE ID = @ID
        IF @OrigenTipo <> 'VTAS'
          SELECT @Ok = 25410
      END ELSE      
      IF @MovTipo = 'VALE.CM'
      BEGIN
        SELECT @Serie = MIN(d.Serie) 
          FROM ValeD d, ValeSerie s
         WHERE d.ID = @ID AND d.Serie = s.Serie AND s.Estatus <> 'CIRCULACION'
        IF @Serie IS NOT NULL SELECT @Ok = 36042, @OkRef = @Serie ELSE
        BEGIN
          SELECT @Serie = MIN(d.Serie) 
            FROM ValeD d, ValeSerie s
           WHERE d.ID = @ID AND d.Serie = s.Serie AND s.TipoTarjeta = 1
          IF @Serie IS NOT NULL SELECT @Ok = 36100, @OkRef = @Serie
        END
      END
    END
  END
  RETURN
END
GO


/**************** spValeAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spValeAfectar') and type = 'P') drop procedure dbo.spValeAfectar
GO             
CREATE PROCEDURE spValeAfectar
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
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @Tipo			varchar(50),
		   @Precio			money,
                   @TipoTieneVigencia		bit,
		   @FechaInicio			datetime,
		   @FechaTermino		datetime,

		   @Cliente			char(10),
		   @Agente			char(10),
		   @Condicion			varchar(50),
		   @Vencimiento			datetime,
		   @Descuento			varchar(50),
		   @Concepto			varchar(50),
		   @Referencia			varchar(50),
		   @CtaDinero			char(10),
		   @FormaPago			varchar(50),

		   @MovNCredito			varchar(20),
		   @MovNCargo			varchar(20),

		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

    		   @GenerarMov			char(20)     OUTPUT,
		   @IDGenerar			int	     OUTPUT,	
    		   @GenerarMovID	  	varchar(20)  OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Vale			char(20),
    @ValeEstatus		char(15),
    @Cantidad			int,
    @Importe			money, 
    @ImporteAplicar		money,
    @DescuentoMov		char(20),
    @DescuentoImporte		money,
    @DescuentoGlobal		float,
    @FechaVenta			datetime,

    @CxModulo			char(5),
    @CxMov			char(20),
    @CxMovID			varchar(20),
    @DineroMov			char(20),
    @DineroMovID		varchar(20),

    @Generar				bit,
    @GenerarAfectado		bit,
    @GenerarModulo			char(5),
    @GenerarMovTipo			char(20),
    @GenerarEstatus			char(15),
    @GenerarPeriodo 		int, 
    @GenerarEjercicio 		int,
    @FechaCancelacion		datetime,
    @GenerarAccion			char(20),	
    @RedondeoMonetarios		int,
    @TipoTarjeta			bit,
    @ArticuloTarjetas		char(20),
    @AlmacenTarjetas		char(10),
    @UEN					int,
    @IDInv					int,
    @MovIDInv				varchar(20),
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @CantidadInventario		float,
    @Unidad					varchar(50),
    @Factor					int, -- MPFP 20012009 Cancelaciones caducidad saldo
    @EsCancelacion			bit, -- MPFP 20012009 Cancelaciones caducidad saldo
    @TarjetaDestino			varchar(20), -- MPFP 20012009 Transferencia Saldo
    @SaldoDestino			money,		 -- MPFP 20012009 Transferencia Saldo
--REQ 13393 POS   
    @POS                                bit ,
    @OrigenTipo                         varchar(20),
    --- Nuevas Variables 
    @Serie                  varchar(20),
    @EstatusPOS				varchar(15),
    @TipoPOS				varchar(50)   
    

  SELECT  @POS = POS 
    FROM EmpresaGral 
   WHERE Empresa = @Empresa
--REQ 13393 POS    
  SELECT @OrigenTipo = OrigenTipo FROM Vale WHERE ID = @ID 

  SELECT @Factor = 1 -- MPFP 20012009 Cancelaciones caducidad saldo
  SELECT @EsCancelacion = 0 -- MPFP 20012009 Cancelaciones caducidad saldo

  SELECT @RedondeoMonetarios = RedondeoMonetarios FROM Version 
  -- Inicializar Variables
  SELECT @Cantidad		= 0,
         @Importe 		= 0.0,
	 @DescuentoGlobal	= NULL,

         @Generar 		= 0,
         @GenerarAfectado	= 0,
         @IDGenerar		= NULL,
         @GenerarModulo		= NULL,
         @GenerarMovID	        = NULL,
         @GenerarMovTipo        = NULL,
         @GenerarEstatus 	= 'SINAFECTAR',
	 @ArticuloTarjetas 	= NULL

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
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, NULL, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT

    IF @@ERROR <> 0 SELECT @Ok = 1
--    IF @Ok IS NULL 
--      EXEC spValeCopiarDetalle @ID, @IDGenerar, @GenerarMovTipo, @Ok OUTPUT
 
    IF @Ok IS NULL SELECT @Ok = 80030
    RETURN
  END

  IF @OK IS NOT NULL RETURN 


  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Actualizar Sucursal Detalle
    IF @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR'
      IF (SELECT Sincro FROM Version) = 1
        EXEC sp_executesql N'UPDATE ValeD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @MovTipo IN ('VALE.V', 'VALE.D', 'VALE.EV') AND @Descuento IS NOT NULL
      SELECT @DescuentoGlobal = Porcentaje
        FROM Descuento
       WHERE Descuento = @Descuento

    SELECT @Cantidad = COUNT(*) 
      FROM ValeD
     WHERE ID = @ID

    IF @MovTipo IN ('VALE.E', 'VALE.EV', 'VALE.ET', 'VALE.EO')
      SELECT @Importe = @Precio * @Cantidad
    ELSE
    IF @MovTipo IN ('VALE.AT', 'VALE.TT', 'VALE.CS','VALE.AMLDI','VALE.ACTMLDI')
      SELECT @Importe = SUM(d.Importe) 
        FROM ValeD d, ValeSerie s 
       WHERE d.ID = @ID AND s.Serie = d.Serie
    ELSE
      SELECT @Importe = SUM(s.Precio) 
        FROM ValeD d, ValeSerie s 
       WHERE d.ID = @ID AND s.Serie = d.Serie

    IF @MovTipo IN ('VALE.E', 'VALE.EV', 'VALE.ET', 'VALE.EO')
    BEGIN
      IF @MovTipo = 'VALE.ET' SELECT @TipoTarjeta = 1 ELSE SELECT @TipoTarjeta = 0
      IF @Accion = 'CANCELAR'
      BEGIN
        UPDATE ValeSerie SET Estatus = 'CANCELADO' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
--REQ 13393 POS 
        IF @POS = 1
        BEGIN
          IF EXISTS(SELECT * FROM POSValeSerie WHERE Serie IN(SELECT Serie FROM ValeD WHERE ID = @ID))
            UPDATE POSValeSerie SET Estatus = 'CANCELADO' FROM POSValeSerie s JOIN ValeD d ON s.Serie = d.Serie WHERE d.ID = @ID      
        END         
        IF @MovTipo = 'VALE.ET' 
        BEGIN
          INSERT INTO AuxiliarValeSerie(Sucursal, Mov, MovID, Modulo, ModuloID, Serie, Ejercicio, Periodo, Fecha, Cargo, Abono, PorConciliar, EsCancelacion)
				SELECT @Sucursal, @Mov, @MovID, @Modulo, @ID, Serie, @Ejercicio, @Periodo, @FechaEmision, -@Precio, NULL, 0, 1
				  FROM ValeD
				 WHERE ID = @ID

          SELECT @IDInv = DID FROM MovFlujo WHERE OModulo = @Modulo AND OID = @ID AND DModulo = 'INV'
          IF @IDInv is not null
            EXEC spAfectar 'INV', @IDInv, @Accion, 'Todo', NULL, @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @EnSilencio = 1, @Conexion = 1
        END
      END
      ELSE
      BEGIN
        IF @MovTipo in ('VALE.E', 'VALE.ET') 
          SELECT @ValeEstatus = 'DISPONIBLE', @FechaVenta = NULL 
        ELSE 
          SELECT @ValeEstatus = 'CIRCULACION', @FechaVenta = @FechaEmision

        --- Si viene de POS, conserva el estatus que trae la tarjeta desde POS.
        IF @MovTipo in ('VALE.E', 'VALE.ET') AND @OrigenTipo IN ('POS') BEGIN
          SELECT @Serie = NULL, @EstatusPOS = NULL

          SELECT @Serie = ISNULL(Serie, '') FROM ValeD WHERE ID = @ID AND Serie NOT IN(SELECT Serie FROM ValeSerie)
          IF NULLIF(@Serie, '') IS NOT NULL          
            SELECT @EstatusPOS = Estatus FROM POSValeSerie WHERE Serie = @Serie and Moneda = @MovMoneda and Tipo = @Tipo
          IF @EstatusPOS = 'CIRCULACION' AND @ValeEstatus = 'DISPONIBLE'
            SELECT @ValeEstatus = @EstatusPOS
        END

        IF @MovTipo = 'VALE.ET'
          SELECT @ArticuloTarjetas = NULLIF(Articulo,'') FROM Vale WHERE ID = @ID
  
        INSERT ValeSerie (Serie, Tipo, IDEmision, FechaEmision, FechaInicio, FechaTermino, Precio, Moneda, Estatus, Cliente, FechaVenta, TipoTarjeta, Articulo, Empresa)
          SELECT Serie, @Tipo, @ID, @FechaEmision, @FechaInicio, @FechaTermino, @Precio, @MovMoneda, @ValeEstatus, @Cliente, @FechaVenta, @TipoTarjeta, @ArticuloTarjetas, @Empresa -- MPFP 20012009 Se adiciona variable @Empresa
            FROM ValeD 
           WHERE ID = @ID
             AND Serie NOT IN(SELECT Serie FROM ValeSerie) -- BUG9622
             
--REQ 13393 POS
        IF NOT EXISTS(SELECT * FROM POSValeSerie WHERE Serie IN(SELECT Serie FROM ValeD WHERE ID = @ID))
        INSERT POSValeSerie(Serie, Sucursal, Estatus,       Moneda,     Tipo,          Cliente)
        SELECT              Serie, Sucursal, @ValeEstatus,  @MovMoneda, @TipoTarjeta,  NULL
          FROM ValeD 
         WHERE ID = @ID  
             

        UPDATE ValeSerie -- BUG9622
           SET Tipo				= @Tipo, 
			   IDEmision		= @ID, 
			   FechaEmision		= @FechaEmision, 
			   FechaInicio		= @FechaInicio, 
			   FechaTermino		= @FechaTermino, 
			   Precio			= @Precio, 
			   Moneda			= @MovMoneda, 
			   Estatus			= @ValeEstatus, 
			   Cliente			= @Cliente, 
			   FechaVenta		= @FechaVenta, 
			   TipoTarjeta		= @TipoTarjeta, 
			   Articulo			= @ArticuloTarjetas, 
			   Empresa			= @Empresa,
			   FechaCancelacion = NULL
          FROM ValeD
         WHERE ValeD.ID = @ID
           AND ValeD.Serie IN(SELECT Serie FROM ValeSerie WHERE Estatus = 'CANCELADO')

        IF @MovTipo = 'VALE.ET'
        BEGIN
          INSERT INTO AuxiliarValeSerie(Sucursal, Mov, MovID, Modulo, ModuloID, Serie, Ejercicio, Periodo, Fecha, Cargo, Abono, PorConciliar, EsCancelacion)
				SELECT @Sucursal, @Mov, @MovID, @Modulo, @ID, Serie, @Ejercicio, @Periodo, @FechaEmision, @Precio, NULL, 0, 0
				  FROM ValeD
				 WHERE ID = @ID

	  SELECT @Unidad = Unidad FROM Art WHERE Articulo = @ArticuloTarjetas
          SELECT @AlmacenTarjetas = Almacen FROM Vale WHERE ID = @ID
	  SELECT @UEN = UEN FROM Vale WHERE ID = @ID

	  INSERT INTO Inv(Empresa, Mov, FechaEmision, 		Proyecto, 	UEN, Moneda, TipoCambio, 	Usuario, Referencia, 				Estatus, Directo, Almacen, OrigenTipo, Origen, OrigenID, Sucursal, SucursalOrigen, SucursalDestino)
		VALUES(@Empresa, 'Entrada Diversa', @FechaEmision, @Proyecto, @UEN, @MovMoneda, @MovTipoCambio, @Usuario, RTRIM(@Mov) + ' ' + RTRIM(@MovID), 'SINAFECTAR', 1, @AlmacenTarjetas, 'VALE', @Mov, @MovID, @Sucursal, @SucursalOrigen, @SucursalDestino)

	  SELECT @IDInv = SCOPE_IDENTITY()

          EXEC xpCantidadInventario @ArticuloTarjetas, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

	  INSERT INTO InvD(ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Cantidad, Almacen, Articulo, Costo, Unidad, Factor, CantidadInventario, Sucursal, SucursalOrigen)
		VALUES(@IDInv, 2048, 0, 1, 'S', @Cantidad, @AlmacenTarjetas, @ArticuloTarjetas, 0.01, @Unidad, 1, @CantidadInventario, @Sucursal, @SucursalOrigen)
  
          INSERT INTO SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SerieLote, Cantidad, Sucursal)
			SELECT @Empresa, 'INV', @IDInv, 1, @ArticuloTarjetas, Serie, 1, @Sucursal
			  FROM ValeD
			 WHERE ID = @ID

          EXEC spAfectar 'INV', @IDInv, @Accion, 'Todo', NULL, @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @EnSilencio = 1, @Conexion = 1

          IF @Ok is null
          BEGIN
            SELECT @MovIDInv = MovID FROM Inv WHERE ID = @IDInv
	    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @IDInv, 'Entrada Diversa', @MovIDInv, @Ok = @OK OUTPUT
          END

        END
      END
    END ELSE
    IF @MovTipo in ('VALE.C', 'VALE.CT')
    BEGIN
      IF @Accion = 'CANCELAR'
        UPDATE ValeSerie SET FechaCancelacion = NULL, Estatus = 'DISPONIBLE' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
      ELSE
        UPDATE ValeSerie SET FechaCancelacion = @FechaEmision, Estatus = 'CANCELADO' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
    END ELSE
    IF @MovTipo IN ('VALE.V', 'VALE.O'/*, 'VALE.OT'*/) 
    BEGIN
      IF @Accion = 'CANCELAR'
        UPDATE ValeSerie SET FechaVenta = NULL, Cliente = NULL, Estatus = 'DISPONIBLE' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
      ELSE
        UPDATE ValeSerie SET FechaVenta = @FechaEmision, Cliente = @Cliente, Estatus = 'CIRCULACION' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
    END ELSE
    IF @MovTipo = 'VALE.D'
    BEGIN
      IF @Accion = 'CANCELAR'
        UPDATE ValeSerie SET FechaVenta = @FechaEmision, Cliente = @Cliente, Estatus = 'CIRCULACION' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
      ELSE
        UPDATE ValeSerie SET FechaVenta = NULL, Cliente = NULL, Estatus = 'DISPONIBLE' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
    END ELSE
    IF @MovTipo in ('VALE.B', 'VALE.BT')
    BEGIN
      IF @Accion = 'CANCELAR' 
        UPDATE ValeSerie SET FechaBloqueo = NULL, Estatus = CASE WHEN Cliente IS NULL THEN 'DISPONIBLE' ELSE 'CIRCULACION' END FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
      ELSE
        UPDATE ValeSerie SET FechaBloqueo = @FechaEmision, Estatus = 'BLOQUEADO' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
    END ELSE
    IF @MovTipo in ('VALE.DB', 'VALE.DBT')
    BEGIN
      IF @Accion = 'CANCELAR'
        UPDATE ValeSerie SET Estatus = 'BLOQUEADO' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
      ELSE
        UPDATE ValeSerie SET FechaBloqueo = NULL, Estatus = CASE WHEN Cliente IS NULL THEN 'DISPONIBLE' ELSE 'CIRCULACION' END FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
    END ELSE
    IF @MovTipo = 'VALE.A'
    BEGIN
      IF @Accion = 'CANCELAR'
        UPDATE ValeSerie SET Estatus = 'COBRADO', FechaAplicacion = NULL FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
      ELSE
        UPDATE ValeSerie SET FechaAplicacion = @FechaEmision, Estatus = 'CONCLUIDO' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
    END ELSE
    IF @MovTipo = 'VALE.CM'
    BEGIN
      IF @Accion = 'CANCELAR'
        UPDATE ValeSerie SET Estatus = 'CIRCULACION' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
      ELSE
        UPDATE ValeSerie SET Estatus = 'COBRADO' FROM ValeD d, ValeSerie s WHERE d.ID = @ID AND s.Serie = d.Serie
    END

    IF @Importe > 0.0 OR @MovTipo = 'VALE.AT'
    BEGIN
      IF @MovTipo IN ('VALE.V', 'VALE.D', 'VALE.EV', 'VALE.O'/*, 'VALE.OT'*/)
        EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                         @FechaAfectacion, NULL, @Proyecto, @Usuario,  NULL, NULL, NULL, NULL,
                         @FechaRegistro, @Ejercicio, @Periodo, 
                         @Condicion, @Vencimiento, @Cliente, NULL, @Agente, NULL, NULL, NULL, 
         	         @Importe, NULL, NULL, NULL, 
                         NULL, NULL, NULL, NULL, NULL, NULL,
                         @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef  OUTPUT

      IF @MovTipo IN ('VALE.V', 'VALE.D', 'VALE.EV') AND @DescuentoGlobal > 0
      BEGIN
        SELECT @DescuentoImporte = ROUND(@Importe * (@DescuentoGlobal / 100), @RedondeoMonetarios)
        IF @MovTipo IN ('VALE.V', 'VALE.EV')
          SELECT @DescuentoMov = @MovNCredito
        ELSE
          SELECT @DescuentoMov = @MovNCargo

        EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                         @FechaAfectacion, NULL, @Proyecto, @Usuario,  NULL, NULL, NULL, NULL,
                         @FechaRegistro, @Ejercicio, @Periodo, 
                         @Condicion, @Vencimiento, @Cliente, NULL, @Agente, NULL, NULL, NULL, 
         	         @DescuentoImporte, NULL, NULL, NULL, 
                         NULL, NULL, NULL, NULL, NULL, @DescuentoMov,
                         @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef  OUTPUT
      END

      IF @MovTipo = 'VALE.A' AND @Ok IS NULL
      BEGIN
        DECLARE crValeCliente CURSOR FOR
         SELECT s.Cliente, SUM(s.Precio)
           FROM ValeD d, ValeSerie s 
          WHERE d.ID = @ID AND s.Serie = d.Serie
          GROUP BY s.Cliente
    
        OPEN crValeCliente
        FETCH NEXT FROM crValeCliente INTO @Cliente, @ImporteAplicar
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN                         
          IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
          BEGIN
            EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                             @FechaAfectacion, NULL, @Proyecto, @Usuario,  NULL, NULL, NULL, NULL,
                             @FechaRegistro, @Ejercicio, @Periodo, 
                             NULL, NULL, @Cliente, NULL, NULL, NULL, NULL, NULL, 
         	             @ImporteAplicar, NULL, NULL, NULL, 
                             NULL, NULL, NULL, NULL, NULL, NULL,
                             @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef  OUTPUT
            IF @Ok = 80030 SELECT @Ok = NULL
          END
          FETCH NEXT FROM crValeCliente INTO @Cliente, @ImporteAplicar
        END
        CLOSE crValeCliente
        DEALLOCATE crValeCliente

        IF @Ok IS NULL
          EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                               @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 0, 0,
                               @FechaRegistro, @Ejercicio, @Periodo, 
                               @FormaPago, NULL, NULL,
                               NULL, @CtaDinero, NULL, @Importe, NULL,
      	                       NULL, NULL, NULL,
		      	       @DineroMov OUTPUT, @DineroMovID OUTPUT,
                               @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok = 80030 SELECT @Ok = NULL
        IF @Ok = NULL
          EXEC xpValeAplicacion  @Sucursal, @Accion, @Modulo, @Empresa, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, 
			         @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @FechaRegistro, @Ejercicio, @Periodo,
                                 @Ok OUTPUT, @OkRef OUTPUT
      END

      IF @MovTipo = 'VALE.AT' AND @Ok IS NULL
      BEGIN
        /*
        DECLARE crValeCliente CURSOR FOR
         SELECT s.Cliente, SUM(d.Importe)
           FROM ValeD d, ValeSerie s 
          WHERE d.ID = @ID AND s.Serie = d.Serie
          GROUP BY s.Cliente
    
        OPEN crValeCliente
        FETCH NEXT FROM crValeCliente INTO @Cliente, @ImporteAplicar
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN                         
          IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
          BEGIN
            EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                             @FechaAfectacion, NULL, @Proyecto, @Usuario,  NULL, NULL, NULL, NULL,
                             @FechaRegistro, @Ejercicio, @Periodo, 
                             NULL, NULL, @Cliente, NULL, NULL, NULL, NULL, NULL, 
         	             @ImporteAplicar, NULL, NULL, NULL, 
                             NULL, NULL, NULL, NULL, NULL, NULL,
                             @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef  OUTPUT
            IF @Ok = 80030 SELECT @Ok = NULL
          END
          FETCH NEXT FROM crValeCliente INTO @Cliente, @ImporteAplicar
        END
        CLOSE crValeCliente
        DEALLOCATE crValeCliente
		*/
        IF @Ok IS NULL 
        BEGIN
          SELECT @Importe = Abs(@Importe)        
          EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                               @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 0, 0,
                               @FechaRegistro, @Ejercicio, @Periodo, 
                               @FormaPago, NULL, NULL,
                               NULL, @CtaDinero, NULL, @Importe, NULL,
      	                       NULL, NULL, NULL,
		      	       @DineroMov OUTPUT, @DineroMovID OUTPUT,
                               @Ok OUTPUT, @OkRef OUTPUT
		END                               
        IF @Ok = 80030 SELECT @Ok = NULL
        IF @Ok = NULL
          EXEC xpValeAplicacion  @Sucursal, @Accion, @Modulo, @Empresa, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, 
			         @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @FechaRegistro, @Ejercicio, @Periodo,
                                 @Ok OUTPUT, @OkRef OUTPUT
      END
      
      IF @MovTipo = 'VALE.CS' AND @Ok IS NULL
      BEGIN
        IF @Accion = 'CANCELAR' SELECT @Factor = -1, @EsCancelacion = 1
        INSERT INTO AuxiliarValeSerie(Sucursal, Mov, MovID, Modulo, ModuloID, Serie, Ejercicio, Periodo, Fecha, Cargo, Abono, PorConciliar, EsCancelacion)
        SELECT @Sucursal, @Mov, @MovID, @Modulo, @ID, Serie, @Ejercicio, @Periodo, @FechaEmision, NULL, Importe * @Factor, 0, @EsCancelacion
          FROM ValeD
         WHERE ID = @ID
      END

-- MPFP 20012009 Transferencia Tarjeta
      IF @MovTipo = 'VALE.TT' AND @Ok IS NULL
      BEGIN
        IF @Accion = 'CANCELAR' SELECT @Factor = -1, @EsCancelacion = 1
        INSERT INTO AuxiliarValeSerie(Sucursal, Mov, MovID, Modulo, ModuloID, Serie, Ejercicio, Periodo, Fecha, Cargo, Abono, PorConciliar, EsCancelacion)
        SELECT @Sucursal, @Mov, @MovID, @Modulo, @ID, Serie, @Ejercicio, @Periodo, @FechaEmision, NULL, Importe * @Factor, 0, @EsCancelacion
          FROM ValeD
         WHERE ID = @ID

        SELECT @TarjetaDestino = TarjetaDestino FROM Vale WHERE ID = @ID

        SELECT @SaldoDestino = SUM(Importe) FROM ValeD WHERE ID = @ID

        INSERT INTO AuxiliarValeSerie(Sucursal, Mov, MovID, Modulo, ModuloID, Serie, Ejercicio, Periodo, Fecha, Cargo, Abono, PorConciliar, EsCancelacion)
        VALUES(@Sucursal, @Mov, @MovID, @Modulo, @ID, @TarjetaDestino, @Ejercicio, @Periodo, @FechaEmision, @SaldoDestino * @Factor, NULL, 0, @EsCancelacion)
      END
    END -- @Importe > 0.0

    -- Actualizar Movimiento
    IF @Ok IN (NULL, 80030)
    BEGIN
      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
      BEGIN
	IF @Estatus =  'SINAFECTAR' AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus <> 'SINAFECTAR' AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
      END  

      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE Vale
         SET Cantidad         = @Cantidad,
             Importe	      = @Importe,
             DescuentoGlobal  = @DescuentoGlobal,
	     FechaConclusion  = @FechaConclusion, 
             FechaCancelacion = @FechaCancelacion,
             UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
             Estatus          = @EstatusNuevo,
             Situacion 	      = CASE WHEN @Estatus <> @EstatusNuevo THEN NULL ELSE Situacion END,
             GenerarPoliza    = @GenerarPoliza
       WHERE ID = @ID 
      IF @@ERROR <> 0 SELECT @Ok = 1
    END
  
  -- Agregar a Estatus Log
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

--REQ 13386   
  IF @Ok IS NULL AND @MovTipo = 'VALE.ACTMLDI' AND @Estatus = 'PENDIENTE' AND @EstatusNuevo = 'CONCLUIDO' AND @OrigenTipo NOT IN('POS')
  BEGIN
    EXEC spLDIValeActivarMonedero @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT
  END    
  
  --REQ 13386    
   IF @Ok IS NULL AND (@MovTipo = 'VALE.AMLDI' AND @Estatus = 'PENDIENTE' AND @EstatusNuevo = 'CONCLUIDO' AND @Accion = 'AFECTAR' AND @OrigenTipo NOT IN('POS'))
  OR (@Estatus = 'CONCLUIDO' AND @EstatusNuevo = 'CANCELADO' AND @Accion = 'CANCELAR' AND @OrigenTipo NOT IN('POS'))
  BEGIN
    EXEC spLDIValeGenerarAbonoMonedero @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Ok OUTPUT, @OkRef OUTPUT
   IF @Ok IS NOT NULL SET @Estatus = 'PENDIENTE'
  END 


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


/**************** spVale ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVale') and type = 'P') drop procedure dbo.spVale
GO
CREATE PROCEDURE spVale
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
    @MovUsuario	      	char(10),
    @Autorizacion     	char(10),
    @DocFuente	      	int,
    @Observaciones    	varchar(255),
    @Estatus          	char(15),
    @EstatusNuevo	char(15),
    @Ejercicio	      	int,
    @Periodo	      	int,
    @Concepto		varchar(50),
    @Referencia  	varchar(50),
    @CtaDinero		char(10),
    @FormaPago		varchar(50),

    @Tipo		varchar(50),
    @Precio		money,
    @TipoTieneVigencia	bit,
    @FechaInicio	datetime,
    @FechaTermino	datetime,

    @Cliente		char(10),
    @Agente		char(10),
    @Condicion		varchar(50),
    @Vencimiento	datetime,  
    @Descuento		varchar(50),

    @MovNCredito 	varchar(20),
    @MovNCargo	 	varchar(20),

    @GenerarMovID	varchar(20),
    @GenerarPoliza	bit,
    @CfgContX		bit,
    @CfgContXGenerar	char(20)/*,
    @Verificar		bit*/,
--REQ 13393 POS   
    @OrigenTipo         varchar(20)

  -- Inicializar Variables
  SELECT @Tipo            	= NULL,
         @Precio	  	= NULL,
         @TipoTieneVigencia	= 0,
         @CfgContX        	= 0,
         @CfgContXGenerar 	= 'NO'/*,
	 @Verificar	  	= 1*/

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, 
         @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = Proyecto,
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, 
         @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, 
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @Tipo = NULLIF(RTRIM(Tipo), ''), @Precio = NULLIF(Precio, 0), @FechaInicio = FechaInicio, @FechaTermino = FechaTermino,
         @Cliente = NULLIF(RTRIM(Cliente), ''), @Agente = NULLIF(RTRIM(Agente), ''), @Condicion = NULLIF(RTRIM(Condicion), ''), @Vencimiento = Vencimiento, @Descuento = NULLIF(RTRIM(Descuento), ''),
         @Concepto = Concepto, @Referencia = Referencia, @CtaDinero = NULLIF(RTRIM(CtaDinero), ''), @FormaPago = NULLIF(RTRIM(FormaPago), ''),
         @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion,
--REQ 13393 POS       
         @OrigenTipo = NULLIF(OrigenTipo,'')
    FROM Vale
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  SELECT @MovNCredito = CxcNCredito,
         @MovNCargo   = CxcNCargo
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaInicio OUTPUT
  EXEC spExtraerFecha @FechaTermino OUTPUT

  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, NULL, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT
  
--REQ 13393 POS
  IF @OrigenTipo = 'POS' AND @MovTipo IN('VALE.ET')
  SELECT @Precio =  ISNULL(Precio,0.0) 
    FROM Vale
   WHERE ID = @ID   

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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'PENDIENTE', 'VIGENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO',  'PENDIENTE', 'VIGENTE'))
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
      BEGIN
--REQ 13386     
        IF @MovTipo IN ('VALE.AMLDI','VALE.ACTMLDI')AND @Estatus = 'SINAFECTAR' AND @OrigenTipo NOT IN ('POS')--REQ 13393 POS
        BEGIN
          SELECT @EstatusNuevo = 'PENDIENTE'
        END
        ELSE
          SELECT @EstatusNuevo = 'CONCLUIDO'
      END  

    IF @MovTipo IN ('VALE.E', 'VALE.EV', 'VALE.ET', 'VALE.EO')
      SELECT @TipoTieneVigencia = TieneVigencia
        FROM ValeTipo
       WHERE Tipo = @Tipo

    IF @MovTipo NOT IN ('VALE.V', 'VALE.D', 'VALE.EV', 'VALE.EO', 'VALE.O'/*, 'VALE.OT'*/) 
      SELECT @Cliente = NULL, @Agente = NULL, @Descuento = NULL

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spValeVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                           @FechaEmision, @Estatus, 
                           @Tipo, @Precio, @TipoTieneVigencia, @FechaInicio, @FechaTermino,
			   @Cliente,@Agente, @Condicion, @Vencimiento, @Descuento, @CtaDinero, @FormaPago,
   		           @Conexion, @SincroFinal, @Sucursal, 
		           @CfgContX, @CfgContXGenerar, @GenerarPoliza,
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
      EXEC spValeAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, 
                         @FechaEmision, @FechaAfectacion, @FechaConclusion,
		         @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, 
                         @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
                         @Tipo, @Precio, @TipoTieneVigencia, @FechaInicio, @FechaTermino,
                         @Cliente, @Agente, @Condicion, @Vencimiento, @Descuento, @Concepto, @Referencia, @CtaDinero, @FormaPago,
			 @MovNCredito, @MovNCargo,
		         @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
		         @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                         @GenerarMov OUTPUT, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
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

/**************** spValeValidarCobro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spValeValidarCobro') and type = 'P') drop procedure dbo.spValeValidarCobro
GO
CREATE PROCEDURE spValeValidarCobro
			@Empresa		char(5),
			@Modulo			char(5),
			@ID			int,
			@Accion 		char(20),
			@Fecha			datetime,
			@ValesCobrados		money,
			@TarjetasCobradas	money,
			@Moneda			char(10),
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ValePrecio		money, 
    @ValeMoneda		char(10),
    @SumaPrecio		money,
    @Serie		char(20),
    @Estatus		char(15),
    @FechaInicio	datetime,
    @FechaTermino	datetime,
    @Saldo		money,
    @SaldoAplica	money,
    @TipoCambio		float,
    @MovTipo		varchar(10),
    @OrigenTipo         varchar(20)--REQ 13393 POS

  IF @Ok IS NOT NULL RETURN
  
  IF @Modulo = 'VTAS'--REQ 13393 POS
    SELECT @OrigenTipo = OrigenTipo FROM Venta WHERE ID = @ID
    
  IF @Modulo = 'CXC'--REQ 13393 POS
    SELECT @OrigenTipo = OrigenTipo FROM Cxc WHERE ID = @ID    

  SELECT @SumaPrecio = 0.0
  EXEC spMovInfo @ID, @Modulo, @MovTipo = @MovTipo OUTPUT

  DELETE ValeSerieMov FROM ValeSerie s
   WHERE ValeSerieMov.Empresa = @Empresa AND ValeSerieMov.Modulo = @Modulo AND ValeSerieMov.ID = @ID
     AND ValeSerieMov.Serie = s.Serie
     AND s.TipoTarjeta <> 0

  DECLARE crValeMov CURSOR FOR
   SELECT v.Serie
     FROM ValeSerieMov v, ValeSerie s
    WHERE v.Empresa = @Empresa AND v.Modulo = @Modulo AND v.ID = @ID
      AND v.Serie = s.Serie
      AND s.TipoTarjeta = 0
    
  OPEN crValeMov
  FETCH NEXT FROM crValeMov INTO @Serie
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN                         
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @Estatus = NULL, @Serie = NULLIF(UPPER(RTRIM(@Serie)), '')
      SELECT @Estatus      = Estatus,
             @FechaInicio  = FechaInicio,
             @FechaTermino = FechaTermino,
             @ValePrecio   = Precio,
             @ValeMoneda   = Moneda
        FROM ValeSerie 
       WHERE Serie = @Serie

      IF @ValeMoneda <> @Moneda SELECT @Ok = 36160
      IF (@Accion = 'CANCELAR' AND @Estatus = 'COBRADO') OR 
         (@Accion <> 'CANCELAR' AND @Estatus = 'CIRCULACION')
      BEGIN
        IF (@Fecha < @FechaInicio) OR (@FechaTermino IS NOT NULL AND @Fecha > @FechaTermino)
          SELECT @Ok = 36150 
      END ELSE
      BEGIN
        IF @Estatus IS NULL SELECT @Ok = 36020 ELSE
        IF @Estatus = 'CANCELADO' SELECT @Ok = 36050 ELSE
        IF @Estatus = 'COBRADO'   SELECT @Ok = 36110 ELSE
        IF @Estatus = 'BLOQUEADO' SELECT @Ok = 36120 ELSE SELECT @OK = 36130, @OkRef = RTRIM(@Serie)+' ('+RTRIM(@Estatus)+')'
      END
      IF @Ok IS NOT NULL AND @OkRef IS NULL SELECT @OkRef = @Serie
      SELECT @SumaPrecio = ROUND(@SumaPrecio + @ValePrecio,2)
    END
    FETCH NEXT FROM crValeMov INTO @Serie
  END
  CLOSE crValeMov
  DEALLOCATE crValeMov
  IF @Ok IS NULL AND @ValesCobrados <> @SumaPrecio SELECT @Ok = 36170

-- Valida Tarjetas
  IF @OK is null
  BEGIN

  DELETE TarjetaSerieMov FROM ValeSerie s
   WHERE TarjetaSerieMov.Empresa = @Empresa AND TarjetaSerieMov.Modulo = @Modulo AND TarjetaSerieMov.ID = @ID
     AND TarjetaSerieMov.Serie = s.Serie
     AND s.TipoTarjeta <> 1

    SELECT @SumaPrecio = 0.0
    DECLARE crTarjetaMov CURSOR FOR
     SELECT v.Serie, v.Importe
       FROM TarjetaSerieMov v, ValeSerie s
      WHERE v.Empresa = @Empresa AND v.Modulo = @Modulo AND v.ID = @ID
        AND v.Serie = s.Serie
        AND s.TipoTarjeta = 1
    
    OPEN crTarjetaMov
    FETCH NEXT FROM crTarjetaMov INTO @Serie, @SaldoAplica
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        SELECT @Estatus = NULL, @Serie = NULLIF(UPPER(RTRIM(@Serie)), '')
        SELECT @Estatus      = Estatus,
               @FechaInicio  = FechaInicio,
               @FechaTermino = FechaTermino,
               @ValePrecio   = Precio,
               @ValeMoneda   = Moneda
          FROM ValeSerie 
         WHERE Serie = @Serie

        SELECT @Saldo = dbo.fnVerSaldoVale(@Serie)
        --IF @Saldo < @SaldoAplica SELECT @Ok = 30096
        
        IF @Accion <> 'CANCELAR' AND @MovTipo NOT IN ('CXC.DC', 'CXC.DE') AND @Saldo < @SaldoAplica
          SELECT @Ok = 30096
        IF @Accion = 'CANCELAR' AND @Saldo < @SaldoAplica
          SELECT @Ok = 30096
        
        IF @ValeMoneda <> @Moneda AND @OrigenTipo <> 'POS' SELECT @Ok = 36161 --REQ 13393 POS
        IF /*(@Accion = 'CANCELAR' AND @Estatus = 'COBRADO') OR */
           (@Accion <> 'CANCELAR' AND @Estatus = 'CIRCULACION')
        BEGIN
          IF (@Fecha < @FechaInicio) OR (@FechaTermino IS NOT NULL AND @Fecha > @FechaTermino)
            SELECT @Ok = 36151
        END ELSE
        IF @Estatus <> 'CIRCULACION'         	
        BEGIN
          IF @Estatus IS NULL SELECT @Ok = 36020 ELSE
          IF @Estatus = 'CANCELADO' SELECT @Ok = 36051 ELSE
          IF @Estatus = 'DISPONIBLE' SELECT @Ok = 36043 ELSE
          IF @Estatus = 'BLOQUEADO' SELECT @Ok = 36121 ELSE SELECT @OK = 36131, @OkRef = RTRIM(@Serie)+' ('+RTRIM(@Estatus)+')'
        END
        IF @Ok IS NOT NULL AND @OkRef IS NULL SELECT @OkRef = @Serie
        SELECT @SumaPrecio = @SumaPrecio + @SaldoAplica
      END
      FETCH NEXT FROM crTarjetaMov INTO @Serie, @SaldoAplica
    END
    CLOSE crTarjetaMov
    DEALLOCATE crTarjetaMov
    IF @Ok IS NULL AND @TarjetasCobradas <> @SumaPrecio /*AND @SumaPrecio <> 0 */ SELECT @Ok = 36171
-- select 'TarjetasCobradas' = @tarjetascobradas, 'SumaPrecio' = @sumaprecio
  END  
END
GO

/**************** spValeAplicarCobro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spValeAplicarCobro') and type = 'P') drop procedure dbo.spValeAplicarCobro
GO
CREATE PROCEDURE spValeAplicarCobro
			@Empresa	char(5),
			@Modulo		char(5),
			@ID		int,
			@Importe	money,
			@Accion 	char(20),
			@Fecha		datetime,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Serie		char(20),
    @FechaCobro 	datetime,
    @ModuloCobro 	char(5),
    @IDCobro		int,
    @EstatusA		char(15),
    @EstatusN		char(15),
    @Aplica		char(20),
    @AplicaID		char(20),
    @AplicaSucursal	int,
    @MovTipo		char(10),    
    @Factor		int,
    @FactorMov		int,
    @EsCancelacion	bit,
    @ImporteAplicar	money,
    @Cargo		money,
    @Abono		money,
    @Ejercicio		int,
    @Periodo		int

  IF @Ok IS NOT NULL RETURN

  DECLARE crValeMov CURSOR FOR
   SELECT Serie
     FROM ValeSerieMov
    WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID
    
  OPEN crValeMov
  FETCH NEXT FROM crValeMov INTO @Serie
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN                         
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @Serie = NULLIF(UPPER(RTRIM(@Serie)), '')
      IF @Accion = 'CANCELAR' 
        SELECT @EstatusA = 'COBRADO', @EstatusN = 'CIRCULACION', @FechaCobro = NULL,@ModuloCobro = NULL, @IDCobro = NULL
      ELSE
        SELECT @EstatusA = 'CIRCULACION', @EstatusN = 'COBRADO', @FechaCobro = @Fecha, @ModuloCobro = @Modulo, @IDCobro = @ID

      UPDATE ValeSerie 
         SET Estatus = @EstatusN, 
             FechaCobro = @FechaCobro,
             ModuloCobro = @ModuloCobro,
             IDCobro = @IDCobro
       WHERE Serie = @Serie AND Estatus = @EstatusA
      IF @@ROWCOUNT = 0 SELECT @Ok = 36140, @OkRef = @Serie
    END
    FETCH NEXT FROM crValeMov INTO @Serie
  END
  CLOSE crValeMov
  DEALLOCATE crValeMov

-- Aplica Tarjetas
  DECLARE crTarjetaMov CURSOR FOR
   SELECT Serie, Importe
     FROM TarjetaSerieMov
    WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID

  SELECT @Ejercicio = DATEPART(year, @Fecha), @Periodo = DATEPART(month, @Fecha)
  SELECT @AplicaSucursal = Sucursal, @Aplica = Mov, @AplicaID = MovID FROM Mov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID
  IF @Modulo = 'CXC' 
  BEGIN
    SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Aplica
      IF @MovTipo in('CXC.A', 'CXC.AR', 'CXC.AA', 'CXC.C') -- Anticipo, Anticipo Remoto, Anticipo Saldo, Cobro
        SELECT @FactorMov = 1
      ELSE
        SELECT @FactorMov = -1 -- Devolucion 'CXC.DC' y Devolucion Saldo CXC.DE
  END
  ELSE 
    SELECT @FactorMov = ISNULL(Factor,1) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Aplica
  
--select @aplica, @aplicaid, @empresa, @modulo, @id, @factormov, @accion, @importe
  OPEN crTarjetaMov
  FETCH NEXT FROM crTarjetaMov INTO @Serie, @ImporteAplicar
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN                         
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @Serie = NULLIF(UPPER(RTRIM(@Serie)), '')
      IF @Accion = 'CANCELAR'
      BEGIN
        SELECT @Factor = -1, @EsCancelacion = 1
        IF @ImporteAplicar < 0
         SELECT @Factor = 1
      END
      ELSE
      BEGIN
        SELECT @Factor = 1, @EsCancelacion = 0
        IF @ImporteAplicar < 0
         SELECT @Factor = -1
      END
--select @factor, @escancelacion
      IF @FactorMov = -1 OR @ImporteAplicar < 0 
        SELECT @Cargo = @ImporteAplicar*@Factor, @Abono = NULL
      ELSE
        SELECT @Cargo = NULL, @Abono = @ImporteAplicar*@Factor

      INSERT INTO AuxiliarValeSerie(Sucursal, Mov, MovID, Modulo, ModuloID, Serie, Ejercicio, Periodo, Fecha, Cargo, Abono, PorConciliar, EsCancelacion)
	                VALUES(@AplicaSucursal, @Aplica, @AplicaID, @Modulo, @ID, @Serie, @Ejercicio, @Periodo, @Fecha, @Cargo, @Abono, 0, @EsCancelacion)

    END
    FETCH NEXT FROM crTarjetaMov INTO @Serie, @ImporteAplicar
  END
  CLOSE crTarjetaMov
  DEALLOCATE crTarjetaMov

END
GO

/**************** spValeGeneraAplicacionTarjeta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spValeGeneraAplicacionTarjeta') and type = 'P') drop procedure dbo.spValeGeneraAplicacionTarjeta
GO
CREATE PROCEDURE spValeGeneraAplicacionTarjeta
			@Empresa	char(5),
			@Modulo		char(5),
			@ID		int,
			@Mov		char(20),
			@MovID		char(20),
			@Accion 	char(20),
			@Fecha		datetime,
			@Usuario	char(10),
			@Sucursal	int,
			@Importe	money,
			@CtaDinero	char(10),
			@Moneda		char(10),
			@TipoCambio	float,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT,
			@LDI            bit = 0,
			@Referencia		varchar(50) = NULL--BUG15665

--//WITH ENCRYPTION
AS
BEGIN
    DECLARE
    @Serie			char(20),
    @IDAplicaTarjeta		int,
    @MovAplicaTarjeta		char(20),
    @MovIDAplicaTarjeta		varchar(20),
    @FormaCobroTarjetas		varchar(50),
    @MovTipo			varchar(10),
    @FactorMov			int ,
    @TarjetaLDI                 bit ,
    @LDIServicio                varchar(20)

  SELECT @FormaCobroTarjetas = CxcFormaCobroTarjetas FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @MovAplicaTarjeta = NULLIF(RTRIM(CxcAplicacionTarjetas), '') FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @TarjetaLDI = ISNULL(LDI,0), @LDIServicio = NULLIF(LDIServicio,'') FROM FormaPago WHERE FormaPago = @FormaCobroTarjetas
  
  IF @Accion NOT IN ('CANCELAR', 'SINCRO') SELECT @Accion = 'AFECTAR'


  IF @Importe <> 0 AND Exists(SELECT * FROM TarjetaSerieMov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID)
  BEGIN
    IF @Accion = 'CANCELAR'
    BEGIN
  
      SELECT @IDAplicaTarjeta = DID FROM MovFlujo WHERE OID = @ID AND OModulo = @Modulo AND DModulo = 'VALE' AND DMov NOT IN (SELECT Mov FROM MovTipo WHERE Modulo = 'VALE' AND Clave IN ('VALE.AMLDI','VALE.ACTMLDI'))
      EXEC spAfectar 'VALE', @IDAplicaTarjeta, @Accion, 'Todo', NULL, @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @EnSilencio = 1, @Conexion = 1
    END
    ELSE
    BEGIN
      IF @Modulo = 'CXC' -- Etoral
      BEGIN
        SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
          IF @MovTipo in('CXC.A', 'CXC.AR', 'CXC.AA', 'CXC.C') -- Anticipo, Anticipo Remoto, Anticipo Saldo, Cobro
            SELECT @FactorMov = 1
          ELSE
            SELECT @FactorMov = -1 -- Devolucion 'CXC.DC' y Devolucion Saldo CXC.DE
      END
      ELSE    
        SELECT @FactorMov = ISNULL(Factor,1) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov      	 	
    
      SELECT @Importe = @Importe * @FactorMov

      --BUG15665    
      INSERT INTO Vale(Empresa, Mov, 			FechaEmision, Moneda, TipoCambio, Usuario, Estatus, OrigenTipo, Origen, OrigenID, Sucursal, Importe, Cantidad, CtaDinero, FormaPago, Referencia)
	  VALUES(@Empresa, @MovAplicaTarjeta, @Fecha, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Modulo, @Mov, @MovID, @Sucursal, @Importe, 1, @CtaDinero, @FormaCobroTarjetas, @Referencia)

      SELECT @IDAplicaTarjeta = SCOPE_IDENTITY()

      DECLARE crValeAplicaTarjeta CURSOR FOR
       SELECT Serie, Importe
         FROM TarjetaSerieMov
        WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID

      OPEN crValeAplicaTarjeta
      FETCH NEXT FROM crValeAplicaTarjeta INTO @Serie, @Importe
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN                         
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
          BEGIN
            SELECT @Importe = @Importe * @FactorMov           	
            INSERT INTO ValeD(ID, Serie, Sucursal, Importe)
		VALUES(@IDAplicaTarjeta, @Serie, @Sucursal, @Importe)
          END
        FETCH NEXT FROM crValeAplicaTarjeta INTO @Serie, @Importe
      END
    CLOSE crValeAplicaTarjeta
    DEALLOCATE crValeAplicaTarjeta
    EXEC spAfectar 'VALE', @IDAplicaTarjeta, @Accion, 'Todo', NULL, @Usuario, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @EnSilencio = 1, @Conexion = 1

    IF @OK is null
    BEGIN
      SELECT @MovIDAplicaTarjeta = MovID FROM Vale WHERE ID = @IDAplicaTarjeta
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'VALE', @IDAplicaTarjeta, @MovAplicaTarjeta, @MovIDAplicaTarjeta, @Ok = @OK OUTPUT
    END

    END
  END

  IF @LDI = 1 AND @TarjetaLDI = 1 AND @LDIServicio IS NOT NULL
    EXEC spLDIValeGenerarCargoMonedero @Empresa, 'VALE', @IDAplicaTarjeta, @Mov, @MovID, @MovTipo, @Accion, @Usuario, @Sucursal, @Moneda, @TipoCambio, @Ok OUTPUT, @OkRef OUTPUT

RETURN
END
GO

/**************** spValeImporteCobrado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spValeImporteCobrado') and type = 'P') drop procedure dbo.spValeImporteCobrado
GO
CREATE PROCEDURE spValeImporteCobrado
			@Empresa	char(5),
			@Modulo		char(5),
			@ID		int,
			@CxcImpuesto	float = NULL,
			@TipoTarjeta	bit = 0

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ConDesglose	bit,
    @ImporteVales	money,
    @FormaCobroVales	varchar(50),
    @FormaCobroTarjetas varchar(50),

    @Importe		money,
    @Impuestos		money,
    @Importe1		money,
    @Importe2		money,
    @Importe3		money,
    @Importe4		money,
    @Importe5		money,
    @FormaCobro 	varchar(50),
    @FormaCobro1	varchar(50),
    @FormaCobro2	varchar(50),
    @FormaCobro3	varchar(50),
    @FormaCobro4	varchar(50),
    @FormaCobro5	varchar(50),
    @Referencia		varchar(50),
    @Referencia1	varchar(50),
    @Referencia2	varchar(50),
    @Referencia3	varchar(50),
    @Referencia4	varchar(50),
    @Referencia5	varchar(50),
    @MovTipo		char(10)

  SELECT @ImporteVales = NULL, @CxcImpuesto = ISNULL(@CxcImpuesto, 0)
  IF @TipoTarjeta = 0
    SELECT @ImporteVales = SUM(s.Precio) 
      FROM ValeSerieMov m, ValeSerie s
     WHERE m.Empresa = @Empresa AND m.Modulo = @Modulo AND m.ID = @ID AND m.Serie = s.Serie
  ELSE
    SELECT @ImporteVales = SUM(m.Importe) 
      FROM TarjetaSerieMov m, ValeSerie s
     WHERE m.Empresa = @Empresa AND m.Modulo = @Modulo AND m.ID = @ID AND m.Serie = s.Serie

  IF NULLIF(@ImporteVales, 0) IS NULL RETURN

  SELECT @FormaCobroVales = CxcFormaCobroVales, @FormaCobroTarjetas = CxcFormaCobroTarjetas
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  IF @Modulo = 'CXC'
  BEGIN
    SELECT @ConDesglose = ConDesglose,
           @Importe  = ISNULL(Importe, 0),  @FormaCobro  = FormaCobro,  @Referencia  = Referencia,
	   @Importe1 = ISNULL(Importe1, 0), @FormaCobro1 = FormaCobro1, @Referencia1 = Referencia1,
	   @Importe2 = ISNULL(Importe2, 0), @FormaCobro2 = FormaCobro2, @Referencia2 = Referencia2,
	   @Importe3 = ISNULL(Importe3, 0), @FormaCobro3 = FormaCobro3, @Referencia3 = Referencia3,
	   @Importe4 = ISNULL(Importe4, 0), @FormaCobro4 = FormaCobro4, @Referencia4 = Referencia4,
	   @Importe5 = ISNULL(Importe5, 0), @FormaCobro5 = FormaCobro5, @Referencia5 = Referencia5
      FROM Cxc
     WHERE ID = @ID
    IF @ConDesglose = 0 AND @Importe > 0.0
    BEGIN
      SELECT @Importe1 = @Importe, @FormaCobro1 = @FormaCobro, @Referencia1 = @Referencia
    END
  END
  IF @Modulo = 'VTAS'
    SELECT @Importe1 = ISNULL(Importe1, 0), @FormaCobro1 = FormaCobro1, @Referencia1 = Referencia1,
	   @Importe2 = ISNULL(Importe2, 0), @FormaCobro2 = FormaCobro2, @Referencia2 = Referencia2,
	   @Importe3 = ISNULL(Importe3, 0), @FormaCobro3 = FormaCobro3, @Referencia3 = Referencia3,
	   @Importe4 = ISNULL(Importe4, 0), @FormaCobro4 = FormaCobro4, @Referencia4 = Referencia4,
	   @Importe5 = ISNULL(Importe5, 0), @FormaCobro5 = FormaCobro5, @Referencia5 = Referencia5
      FROM VentaCobro
     WHERE ID = @ID

  IF @TipoTarjeta = 0
    BEGIN
      IF @Importe1 = 0.0 OR @FormaCobro1 = @FormaCobroVales SELECT @Importe1 = @ImporteVales, @FormaCobro1 = @FormaCobroVales, @Referencia1 = NULL ELSE
      IF @Importe2 = 0.0 OR @FormaCobro2 = @FormaCobroVales SELECT @Importe2 = @ImporteVales, @FormaCobro2 = @FormaCobroVales, @Referencia2 = NULL ELSE
      IF @Importe3 = 0.0 OR @FormaCobro3 = @FormaCobroVales SELECT @Importe3 = @ImporteVales, @FormaCobro3 = @FormaCobroVales, @Referencia3 = NULL ELSE
      IF @Importe4 = 0.0 OR @FormaCobro4 = @FormaCobroVales SELECT @Importe4 = @ImporteVales, @FormaCobro4 = @FormaCobroVales, @Referencia4 = NULL ELSE
      IF @Importe5 = 0.0 OR @FormaCobro5 = @FormaCobroVales SELECT @Importe5 = @ImporteVales, @FormaCobro5 = @FormaCobroVales, @Referencia5 = NULL 
    END
  ELSE
    BEGIN
      IF @Importe1 = 0.0 OR @FormaCobro1 = @FormaCobroTarjetas SELECT @Importe1 = @ImporteVales, @FormaCobro1 = @FormaCobroTarjetas, @Referencia1 = NULL ELSE
      IF @Importe2 = 0.0 OR @FormaCobro2 = @FormaCobroTarjetas SELECT @Importe2 = @ImporteVales, @FormaCobro2 = @FormaCobroTarjetas, @Referencia2 = NULL ELSE
      IF @Importe3 = 0.0 OR @FormaCobro3 = @FormaCobroTarjetas SELECT @Importe3 = @ImporteVales, @FormaCobro3 = @FormaCobroTarjetas, @Referencia3 = NULL ELSE
      IF @Importe4 = 0.0 OR @FormaCobro4 = @FormaCobroTarjetas SELECT @Importe4 = @ImporteVales, @FormaCobro4 = @FormaCobroTarjetas, @Referencia4 = NULL ELSE
      IF @Importe5 = 0.0 OR @FormaCobro5 = @FormaCobroTarjetas SELECT @Importe5 = @ImporteVales, @FormaCobro5 = @FormaCobroTarjetas, @Referencia5 = NULL 
    END

  IF @Modulo = 'CXC'
  BEGIN
    EXEC spMovInfo @ID, @Modulo, @MovTipo = @MovTipo OUTPUT  	
    SELECT @Importe = @Importe1 + @Importe2 + @Importe3 + @Importe4 + @Importe5
    
    IF @MovTipo <> 'CXC.DC'
    BEGIN  
      SELECT @Impuestos = @Importe * (@CxcImpuesto / 100)
      UPDATE Cxc
         SET ConDesglose = 1, 
             Importe  = @Importe-@Impuestos, Impuestos = @Impuestos, FormaCobro = NULL,          
             Importe1 = NULLIF(@Importe1, 0), FormaCobro1 = @FormaCobro1, Referencia1 = @Referencia1,
             Importe2 = NULLIF(@Importe2, 0), FormaCobro2 = @FormaCobro2, Referencia2 = @Referencia2,
             Importe3 = NULLIF(@Importe3, 0), FormaCobro3 = @FormaCobro3, Referencia3 = @Referencia3,
             Importe4 = NULLIF(@Importe4, 0), FormaCobro4 = @FormaCobro4, Referencia4 = @Referencia4,
             Importe5 = NULLIF(@Importe5, 0), FormaCobro5 = @FormaCobro5, Referencia5 = @Referencia5
       WHERE ID = @ID 
   END 
   ELSE
   BEGIN
      UPDATE Cxc SET ConDesglose = 0, Importe  = @Importe, Impuestos = NULL, FormaCobro = @FormaCobroTarjetas
       WHERE ID = @ID
   END    
  END

  IF @Modulo = 'VTAS' 
    UPDATE VentaCobro
       SET Importe1 = NULLIF(@Importe1, 0), FormaCobro1 = @FormaCobro1, Referencia1 = @Referencia1,
           Importe2 = NULLIF(@Importe2, 0), FormaCobro2 = @FormaCobro2, Referencia2 = @Referencia2,
           Importe3 = NULLIF(@Importe3, 0), FormaCobro3 = @FormaCobro3, Referencia3 = @Referencia3,
           Importe4 = NULLIF(@Importe4, 0), FormaCobro4 = @FormaCobro4, Referencia4 = @Referencia4,
           Importe5 = NULLIF(@Importe5, 0), FormaCobro5 = @FormaCobro5, Referencia5 = @Referencia5
     WHERE ID = @ID 
END
GO

-- spValeImporteCobrado 'DEMO', 'VTAS', 10

/**************** spValeSerieTarjeta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spValeSerieTarjeta') and type = 'P') drop procedure dbo.spValeSerieTarjeta
GO
CREATE PROCEDURE spValeSerieTarjeta
		@Empresa	char(5),
		@ID		int,
		@RenglonID	int,
		@MovTipo	char(20),
		@Accion		char(20),
		@Almacen	char(10),
		@AlmacenTipo	char(15),
		@Articulo	char(20),
		@ArtTipo	char(20),
		@SerieLote	char(20),
		@EsEntrada	bit,
		@EsSalida	bit,
		@FechaEmision	datetime,
		@Ok 		int 		OUTPUT,
		@OkRef 		varchar(255) 	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
	@Estatus			char(15),
	@FechaInicio			datetime,
	@FechaTermino			datetime,
	@FechaVenta			datetime,
	@Cliente			char(10),
        @Precio				money,
        @PrecioTarjeta			money,
	@Impuesto1			float,
	@CxcValidarPrecioTarjetas	bit,
	@VentaPreciosImpuestoIncluido	bit,
	@DescuentoLinea		float,
	@DescuentoGlobal		float
    
  SELECT @CxcValidarPrecioTarjetas     = ISNULL(CxcValidarPrecioTarjetas,0),
         @VentaPreciosImpuestoIncluido = ISNULL(VentaPreciosImpuestoIncluido,0)
    FROM EmpresaCfg WHERE Empresa = @Empresa

  IF NOT Exists(SELECT * FROM ValeSerie WHERE Serie = @SerieLote AND Articulo = @Articulo)
    SELECT @OK = 30097
  ELSE
  BEGIN
    SELECT @Estatus = Estatus, @FechaInicio = FechaInicio, @FechaTermino = FechaTermino, @PrecioTarjeta = ISNULL(Precio,0)
      FROM ValeSerie
     WHERE Serie = @SerieLote

    EXEC spExtraerFecha @FechaEmision OUTPUT
    EXEC spExtraerFecha @FechaInicio OUTPUT
    EXEC spExtraerFecha @FechaTermino OUTPUT

    SELECT @Cliente = Cliente, @DescuentoGlobal = ISNULL(DescuentoGlobal,0) FROM Venta WHERE ID = @ID
    SELECT @Precio = ISNULL(Precio,0), @Impuesto1 = ISNULL(Impuesto1,0), @DescuentoLinea = ISNULL(DescuentoLinea,0)
      FROM VentaD
     WHERE ID = @ID AND RenglonID = @RenglonID

-- Valida Precio de la Tarjeta en la Venta
    IF @EsSalida = 1 AND @CxcValidarPrecioTarjetas = 1
    BEGIN
      IF @VentaPreciosImpuestoIncluido = 0
        SELECT @Precio = ROUND(((@Precio*(1.0+(@Impuesto1/100.0)))*(1-(@DescuentoLinea/100.0))*(1-(@DescuentoGlobal/100) ) ),2)
      ELSE
        SELECT @Precio = ROUND(((@Precio)*(1-(@DescuentoLinea/100.0))*(1-(@DescuentoGlobal/100) ) ),2)

      IF @Precio <> @PrecioTarjeta
        SELECT @OK = 20305, @OkRef = 'El Precio del Movimiento difiere del Precio de la Tarjeta'
    END

-- Valida Estatus con la Accion
    IF @Accion = 'CANCELAR'
    BEGIN
      IF @EsEntrada = 1 AND @Estatus <> 'CIRCULACION'
        SELECT @OK = 36043
    END
    ELSE
    BEGIN
      IF @EsSalida = 1 AND @Estatus <> 'DISPONIBLE'
        SELECT @OK = 36031
      IF @EsEntrada = 1  -- No permite devolucion de tarjeta
        SELECT @OK = 36101  
      ELSE
      IF (@FechaEmision < @FechaInicio) OR (@FechaTermino IS NOT NULL AND @FechaEmision > @FechaTermino)
        SELECT @Ok = 36150 
      /*
      IF @EsEntrada = 1 AND @Estatus <> 'CIRCULACION'
      SELECT @OK = 36043*/
    END

    IF @OK is null --AND @EsSalida = 1
    BEGIN
      IF @Accion = 'CANCELAR'
        UPDATE ValeSerie SET FechaVenta = NULL, Cliente = NULL, Estatus = 'DISPONIBLE' WHERE Serie = @SerieLote
      ELSE
        UPDATE ValeSerie SET FechaVenta = @FechaEmision, Cliente = @Cliente, Estatus = 'CIRCULACION' WHERE Serie = @SerieLote
    END

  END

  RETURN
END
GO

/**************** spIncrementaSaldoTarjeta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncrementaSaldoTarjeta') and type = 'P') drop procedure dbo.spIncrementaSaldoTarjeta
GO
CREATE PROCEDURE spIncrementaSaldoTarjeta
		@Empresa		char(5),
		@ID			int,
		@Mov			char(20),
		@MovID			varchar(20),
		@Modulo			char(10),
		@Ejercicio		int,
		@Periodo		int,
		@Accion			char(20),
		@FechaEmision		datetime,
		@MovMoneda		char(10),
		@MovTipoCambio		float,
		@Ok 			int		OUTPUT, 
		@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
	@Articulo			char(20),
	@CantidadArt			float,
	@CantidadSerie			float,
	@SerieLote			varchar(20),
	@PrecioSI			money,
	@PrecioCI			money,
	@Cargo				money,
	@EsCancelacion			bit,
	@Factor				int,
	@MonedaVale			char(10),
	@Estatus			char(15),
	@FechaTermino			datetime,
	@VentaPreciosImpuestoIncluido 	bit,
        @Sucursal			int

  SELECT @VentaPreciosImpuestoIncluido = ISNULL(VentaPreciosImpuestoIncluido,0)
    FROM EmpresaCfg WHERE Empresa = @Empresa

  IF @Accion = 'CANCELAR'
    SELECT @EsCancelacion = 1, @Factor = -1
  ELSE
     SELECT @EsCancelacion = 0, @Factor = 1

  IF Exists(SELECT * FROM VentaD d, Art a WHERE d.Articulo = a.Articulo AND d.ID = @ID AND a.Tipo <> 'Serie')
    SELECT @Ok = 10060, @OkRef = 'El Movimiento Requiere Artículos tipo Serie'
  ELSE
  IF Exists(SELECT d.RenglonID, d.Articulo, ISNULL(d.Cantidad,0), ISNULL(SUM(s.Cantidad),0)
              FROM Venta v
              JOIN VentaD d ON v.ID = d.ID
              LEFT OUTER JOIN SerieLoteMov s ON d.ID = s.ID AND d.RenglonID = s.RenglonID AND d.Articulo = s.Articulo AND ISNULL(d.SubCuenta,'') = ISNULL(s.SubCuenta,'') 
               AND s.Modulo = @Modulo
             WHERE d.ID = @ID
               AND v.Empresa = @Empresa
             GROUP BY d.RenglonID, d.Articulo, d.Cantidad
            HAVING ISNULL(d.Cantidad,0) <> ISNULL(SUM(s.Cantidad),0))
    SELECT @Ok = 20330
  
  DECLARE crIncrementaSaldoTarjeta CURSOR FOR
  SELECT v.Sucursal, d.Articulo, s.SerieLote, ROUND(((d.Precio)*(1-(ISNULL(d.DescuentoLinea,0)/100.0))*(1-(ISNULL(v.DescuentoGlobal,0)/100) ) ),2), ROUND(((ISNULL(d.Precio,0)*(1.0+(ISNULL(d.Impuesto1,0)/100.0)))*(1-(ISNULL(d.DescuentoLinea,0)/100.0))*(1-(ISNULL(v.DescuentoGlobal,0)/100) ) ),2)
    FROM Venta v, VentaD d, SerieLoteMov s
   WHERE v.ID = d.ID
     AND d.ID = s.ID AND d.RenglonID = s.RenglonID AND d.Articulo = s.Articulo AND ISNULL(d.SubCuenta,'') = ISNULL(s.SubCuenta,'')
     AND v.ID = @ID
     AND s.Empresa = @Empresa AND s.Modulo = @Modulo

  OPEN crIncrementaSaldoTarjeta
  FETCH NEXT FROM crIncrementaSaldoTarjeta INTO @Sucursal, @Articulo, @SerieLote, @PrecioCI, @PrecioSI
  WHILE @@FETCH_STATUS = 0 AND @OK is null
  BEGIN
    SELECT @MonedaVale = Moneda, @FechaTermino = FechaTermino, @Estatus = Estatus FROM ValeSerie WHERE Serie = @SerieLote AND Articulo = @Articulo
    IF @@ROWCOUNT = 0
      SELECT @Ok = 30097, @OkRef = 'Tarjeta ' + RTRIM(@SerieLote) + '. Verifique que Exista la Tarjeta o que corresponde al Artículo.' 
    ELSE
    IF @Estatus <> 'CIRCULACION'
      SELECT @Ok = 36043, @OkRef = 'Tarjeta ' + RTRIM(@SerieLote)
    ELSE
/*    IF @FechaTermino is not NULL AND @FechaTermino < @FechaEmision
      SELECT @Ok = 36151, @OkRef = 'Tarjeta ' + RTRIM(@SerieLote)
    ELSE*/
    IF @MonedaVale <> @MovMoneda
      SELECT @OK = 36161
    ELSE
    BEGIN
      IF @VentaPreciosImpuestoIncluido = 0
        SELECT @Cargo = @PrecioSI*@Factor
      ELSE
        SELECT @Cargo = @PrecioCI*@Factor

      INSERT INTO AuxiliarValeSerie(Sucursal, Mov, MovID, Modulo, ModuloID, Serie, Ejercicio, Periodo, Fecha, Cargo, Abono, PorConciliar, EsCancelacion)
                            VALUES(@Sucursal, @Mov, @MovID, @Modulo, @ID, @SerieLote, @Ejercicio, @Periodo, @FechaEmision, @Cargo, NULL, 0, @EsCancelacion)
    END

    FETCH NEXT FROM crIncrementaSaldoTarjeta INTO @Sucursal, @Articulo, @SerieLote, @PrecioCI, @PrecioSI
  END

  CLOSE crIncrementaSaldoTarjeta
  DEALLOCATE crIncrementaSaldoTarjeta

  RETURN
END
GO

/**************** xpVentaMonederoContinuar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVentaMonederoContinuar') and type = 'P') drop procedure dbo.xpVentaMonederoContinuar
GO
CREATE PROCEDURE xpVentaMonederoContinuar
		@Empresa		char(5),
		@Modulo			char(10),
		@ID			int,
		@Mov			char(20),
		@MovID			varchar(20),
		@MovTipo		char(20),
		@Accion			char(20),
		@FechaEmision		datetime,
		@Ejercicio		int,
		@Periodo		int,
		@Usuario		char(10),
		@Sucursal		int,
		@MovMoneda		char(10),
		@MovTipoCambio		float,
		@Continuar		bit		OUTPUT,
		@Ok 			int 		OUTPUT,
		@OkRef 			varchar(255)	OUTPUT

AS
BEGIN

  RETURN
END
GO

/**************** spVentaMonedero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaMonedero') and type = 'P') drop procedure dbo.spVentaMonedero
GO
CREATE PROCEDURE spVentaMonedero
		@Empresa		char(5),
		@Modulo			char(10),
		@ID			int,
		@Mov			char(20),
		@MovID			varchar(20),
		@MovTipo		char(20),
		@Accion			char(20),
		@FechaEmision		datetime,
		@Ejercicio		int,
		@Periodo		int,
		@Usuario		char(10),
		@Sucursal		int,
		@MovMoneda		char(10),
		@MovTipoCambio		float,
		@Ok 			int 		OUTPUT,
		@OkRef 			varchar(255)	OUTPUT,
		@LDI                    bit = 0
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE 
        @OFER				bit,
        @CfgVentaPuntosArtCat		bit,
	@Renglon			float,
	@Articulo			varchar(20),
	@Categoria			varchar(50),
	@Precio				money,
	@Impuesto1			float,
	@DescuentoGlobal		float,
	@DescuentoLinea			float,
	@Porcentaje			float,
	@Continuar			bit,
	@VentaPreciosImpuestoIncluido 	bit,
	@Factor				int,
	@Cargo				money,
	@EsCancelacion			bit,
	@TarjetaMoneda			char(10),
	@TarjetaTipoCambio		float,
	@Tarjeta			char(20),
--	@FactorMoneda			float,
	@Total				money,
	@Cantidad			float, -- BUG9483,
--REQ 13386  
        @Importe                        float ,
	    @TotalCargo			money  ,
        @OrigenTipo          varchar(10)   --REQ 13393 POS  

--REQ 13393 POS
  IF @Modulo = 'VTAS'
    SELECT @OrigenTipo = NULLIF(OrigenTipo,'') FROM Venta WHERE ID = @ID

  SELECT @Total = 0, @Cargo = 0, @Porcentaje = 0

  SELECT @OFER = OFER 
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @CfgVentaPuntosArtCat = ISNULL(VentaPuntosArtCat, 0) 	
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT Top 1 @Tarjeta = Serie
    FROM TarjetaSerieMov
   WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID

  IF NOT Exists(SELECT * FROM ValeSerie WHERE Serie = @Tarjeta AND TipoTarjeta = 1)
    SELECT @OK = 30097, @Continuar = 0
  ELSE
    SELECT @Continuar = 1

  IF @Accion = 'CANCELAR'
    SELECT @EsCancelacion = 1, @Factor = -1
  ELSE
     SELECT @EsCancelacion = 0, @Factor = 1

  SELECT @VentaPreciosImpuestoIncluido = ISNULL(VentaPreciosImpuestoIncluido,0)
    FROM EmpresaCfg WHERE Empresa = @Empresa

  SELECT @TarjetaMoneda = Moneda FROM ValeSerie WHERE Serie = @Tarjeta AND TipoTarjeta = 1
  IF @TarjetaMoneda <> @MovMoneda AND @OrigenTipo NOT IN ('POS') --REQ 13393 POS
  BEGIN
    SELECT @Ok = 36161
--    SELECT @TarjetaTipoCambio = TipoCambio FROM Mon WHERE Moneda = @TarjetaMoneda
--    SELECT @FactorMoneda = @MovTipoCambio/@TarjetaTipoCambio
  END
--  ELSE
--    SELECT @FactorMoneda = 1

  IF @Continuar = 1 AND @Accion IN('AFECTAR', 'RESERVAR', 'RESERVARPARCIAL') AND @CfgVentaPuntosArtCat = 1 AND @OFER = 0 -- BUG9483
  BEGIN
    EXEC xpVentaMonederoContinuar @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, 
				  @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, 
				  @Continuar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    IF @Continuar = 1
    BEGIN
      DECLARE ctCteFrecuente CURSOR FOR
      SELECT d.Renglon, d.Articulo, d.Precio, ISNULL(d.Impuesto1,0), ISNULL(v.DescuentoGlobal,0), ISNULL(d.DescuentoLinea,0), NULLIF(RTRIM(a.Categoria), ''), ISNULL(f.Porcentaje,0), d.Cantidad -- BUG9483
        FROM Venta v, VentaD d, Art a, ArtCatTarjetaPuntos f
       WHERE v.ID = d.ID
         AND d.Articulo = a.Articulo
         AND a.Categoria = f.Categoria
         AND @FechaEmision BETWEEN f.FechaD AND f.FechaA
         AND v.ID = @ID
         AND ISNULL(f.Porcentaje,0) > 0

      OPEN ctCteFrecuente
      FETCH NEXT FROM ctCteFrecuente INTO @Renglon, @Articulo, @Precio, @Impuesto1, @DescuentoGlobal, @DescuentoLinea, @Categoria, @Porcentaje, @Cantidad -- BUG9483
      WHILE @@FETCH_STATUS = 0
      BEGIN
        IF @VentaPreciosImpuestoIncluido = 0
          SELECT @Cargo = ROUND(((@Precio*(1.0+(@Impuesto1/100.0)))*(1-(@DescuentoLinea/100.0))*(1-(@DescuentoGlobal/100) ) ),2)
        ELSE 
          SELECT @Cargo = ROUND(((@Precio)*(1-(@DescuentoLinea/100.0))*(1-(@DescuentoGlobal/100) ) ),2)

        SELECT @Cargo = @Cantidad * (ISNULL(@Cargo,0)*(@Porcentaje/100)) -- BUG9483
--REQ 13393 POS
          IF @Cargo > 0
          BEGIN
            UPDATE VentaD SET Puntos = dbo.fnImporteMonTarjeta(@Cargo, @MovMoneda, @MovTipoCambio, @TarjetaMoneda,NULL, @Sucursal)   WHERE ID = @ID AND Renglon = @Renglon
          END  
          ELSE
--SE CONVIERTEN LOS PUNTOS A LA MONEDA DE LA TARJETA
            UPDATE VentaD SET Puntos = dbo.fnImporteMonTarjeta(Puntos, @MovMoneda, @MovTipoCambio, @TarjetaMoneda,NULL, @Sucursal)   WHERE ID = @ID AND Renglon = @Renglon

        FETCH NEXT FROM ctCteFrecuente INTO @Renglon, @Articulo, @Precio, @Impuesto1, @DescuentoGlobal, @DescuentoLinea, @Categoria, @Porcentaje, @Cantidad -- BUG9483
      END

      CLOSE ctCteFrecuente
      DEALLOCATE ctCteFrecuente
    END
  END

  IF @Continuar = 1 OR @Accion = 'CANCELAR'
  BEGIN
  
--REQ 13393 POS
   
    SELECT @Total = SUM(Puntos) FROM VentaD  WHERE ID = @ID AND  Puntos > 0
    SELECT @TotalCargo = SUM(Puntos)*-1 FROM VentaD  WHERE ID = @ID AND  Puntos < 0
    SELECT @Importe = (@Total*@Factor)

    IF ISNULL(@Total, 0) > 0 AND @Ok IS NULL
      INSERT INTO AuxiliarValeSerie (Sucursal,  Mov,  MovID,  Modulo,  ModuloID, Serie,    Ejercicio,  Periodo,  Fecha,          Cargo,                             Abono, PorConciliar, EsCancelacion)
          VALUES (                   @Sucursal, @Mov, @MovID, @Modulo, @ID,      @Tarjeta, @Ejercicio, @Periodo, @FechaEmision, (@Total*@Factor)/**@FactorMoneda*/, NULL,  0,            @EsCancelacion)
--REQ 13393 POS
    IF ISNULL(@TotalCargo, 0) >0
    BEGIN
--valida que tenga saldo    
      IF dbo.fnVerSaldoVale(@Tarjeta)< @TotalCargo
      SELECT @Ok = 30096, @OkRef = 'Tarjeta ' + @Tarjeta 
      
      IF @Ok IS NULL
      INSERT INTO AuxiliarValeSerie (
                  Sucursal, Mov, MovID, Modulo, ModuloID, Serie, Ejercicio, Periodo, Fecha, Cargo, Abono, PorConciliar, EsCancelacion)
          VALUES (@Sucursal, @Mov, @MovID, @Modulo, @ID, @Tarjeta, @Ejercicio, @Periodo, @FechaEmision,NULL ,/**@FactorMoneda*/ (@TotalCargo*@Factor), 0, @EsCancelacion)
    END



--REQ 13386  
    IF @LDI = 1 AND ISNULL(@Total, 0) > 0 AND @Ok IS NULL AND @OrigenTipo NOT IN ('POS')
      EXEC spLDIVentaGenerarAbonoVale @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @FechaEmision, @Ejercicio, @Periodo, @Usuario, @Sucursal, @MovMoneda, @MovTipoCambio, @Importe, @Ok OUTPUT, @OkRef OUTPUT          
    



  END

  RETURN
END
GO

/**************** fnVerSaldoVale ****************/
if exists (select * from sysobjects where id = object_id('dbo.fnVerSaldoVale') and type = 'fn') drop function dbo.fnVerSaldoVale
GO
CREATE FUNCTION dbo.fnVerSaldoVale (@Serie varchar(20))
RETURNS money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Saldo		money
  SELECT @Saldo = SUM(ISNULL(Cargo,0)-ISNULL(Abono,0))
    FROM AuxiliarValeSerie
   WHERE Serie = @Serie

  RETURN (ISNULL(@Saldo,0))
END
GO

/**************** spVentaPuntosEnVales ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaPuntosEnVales') and type = 'P') drop procedure dbo.spVentaPuntosEnVales
GO
CREATE PROCEDURE spVentaPuntosEnVales
		@Empresa		char(5),
		@Modulo			char(10),
		@ID			int,
		@Mov			char(20),
		@MovID			varchar(20),
		@MovTipo		char(20),
		@Accion			char(20),
		@FechaEmision		datetime,
		@Usuario		char(10),
		@Sucursal		int,
		@MovMoneda		char(10),
		@MovTipoCambio		float,
		@Ok 			int 		OUTPUT,
		@OkRef 			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @ValeID		int,
    @ValeMov		varchar(20),
    @ValeMovID		varchar(20),
    @Consecutivo	varchar(50),
    @Serie		varchar(50),
    @Puntos		money

  IF @Accion <> 'CANCELAR' 
    SELECT @Accion = 'AFECTAR'

  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @ValeID = MIN(ID), @ValeMov = MIN(Mov), @ValeMovID = MIN(MovID) FROM Vale WHERE Empresa = @Empresa AND Origen = @Mov AND OrigenID = @MovID AND Estatus = 'CONCLUIDO'
  END ELSE 
  BEGIN
    SELECT @Puntos = SUM(Puntos) FROM VentaD WHERE ID = @ID
    IF ISNULL(@Puntos, 0.0) = 0.0 RETURN

    SELECT @Consecutivo = Consecutivo FROM EmpresaCfgPuntosEnVales WHERE Empresa = @Empresa
    INSERT Vale (
           Empresa,   Estatus,      Mov,          FechaEmision,   Proyecto, UEN, Moneda,       TipoCambio,   Usuario,   Referencia,   Concepto, OrigenTipo, Origen, OrigenID, Sucursal, Cliente,     Tipo,          Precio, FechaInicio, FechaTermino)
    SELECT v.Empresa, 'SINAFECTAR', cfg.ValesMov, v.FechaEmision, v.Proyecto, v.UEN, v.Moneda, v.TipoCambio, v.Usuario, v.Referencia, v.Concepto, 'VTAS',   v.Mov,  v.MovID,  v.Sucursal, v.Cliente, cfg.ValeTipo, @Puntos, FechaEmision, dbo.fnDuracion(FechaEmision, cfg.Duracion, cfg.DuracionUnidad)
      FROM Venta v
      JOIN EmpresaCfgPuntosEnVales cfg ON cfg.Empresa = v.Empresa
     WHERE v.ID = @ID

    SELECT @ValeID = SCOPE_IDENTITY()
    EXEC spConsecutivo @Consecutivo, @Sucursal, @Serie OUTPUT
    INSERT ValeD (ID, Serie, Sucursal)
    SELECT @ValeID, @Serie, @Sucursal
  END

  IF @ValeID IS NOT NULL
  BEGIN
    EXEC spAfectar 'VALE', @ValeID, @Accion, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    SELECT @ValeMov = Mov, @ValeMovID = MovID FROM Vale WHERE ID = @ValeID
  END ELSE SELECT @Ok = 30120

  EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'VALE', @ValeID, @ValeMov, @ValeMovID, @Ok = @OK OUTPUT
  RETURN
END
GO

		
PRINT "******************* SP Vale ******************"

