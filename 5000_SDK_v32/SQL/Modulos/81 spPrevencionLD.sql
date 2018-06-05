/* Configuracion MS SQL Server */

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO


/**************** spPrevencionLDVerificar ****************/
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE id = object_id('dbo.spPrevencionLDVerificar') AND type = 'P') 
  drop procedure dbo.spPrevencionLDVerificar
GO
CREATE PROCEDURE spPrevencionLDVerificar
  @ID     		 int
  ,@Accion		 char(20)
  ,@Empresa        char(5)
  ,@Usuario		 char(10)
  ,@Modulo	       char(5)
  ,@Mov            char(20)
  ,@MovID	       varchar(20)
  ,@MovTipo	       char(20)
  ,@MovMoneda      char(10)
  ,@MovTipoCambio	 float
  ,@FechaEmision	 datetime
  ,@Estatus		 char(15)
  ,@EstatusNuevo	 char(15)
  ,@Acreedor	 varchar(10)
  ,@Condicion	 varchar(50)
  ,@Vencimiento	 datetime
  ,@Conexion	 bit
  ,@SincroFinal	 bit
  ,@Sucursal	 int
  ,@Ok             int OUTPUT
  ,@OkRef          varchar(255) OUTPUT
  
--//WITH ENCRYPTION
AS BEGIN 
 -- IF @Accion = 'CANCELAR'
 -- BEGIN
 --   -- Checar que se haya capturado el movimiento en este modulo
 --   IF @Conexion = 0 
 --     IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	--SELECT @Ok = 60070
	--SELECT 'Prueba'
 -- END 
  RETURN
END
GO



/**************** spPrevencionLDAfectar ****************/
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE id = object_id('dbo.spPrevencionLDAfectar') AND type = 'P') 
  DROP PROCEDURE dbo.spPrevencionLDAfectar
GO             
CREATE PROCEDURE spPrevencionLDAfectar
  @ID                int
  ,@Accion		   char(20)
  ,@Empresa	         char(5)
  ,@Modulo	         char(5)
  ,@Mov	  	   char(20)
  ,@MovID            varchar(20)	OUTPUT
  ,@MovTipo     	   char(20)
  ,@MovMoneda	   char(10)
  ,@MovTipoCambio	   float
  ,@FechaEmision     datetime
  ,@FechaAfectacion  datetime
  ,@FechaConclusion  datetime
  ,@Proyecto	   varchar(50)
  ,@Usuario	         char(10)
  ,@Autorizacion     char(10)
  ,@DocFuente	   int
  ,@Observaciones    varchar(255)
  ,@Concepto         varchar(50)
  ,@Referencia	   varchar(50)
  ,@Estatus          char(15)
  ,@EstatusNuevo	   char(15)
  ,@FechaRegistro    datetime
  ,@Ejercicio	   int
  ,@Periodo	         int
  ,@MovUsuario       char(10)
  ,@Acreedor	   varchar(10)
  ,@Condicion	   varchar(50)
  ,@Vencimient       datetime
  ,@Conexion	   bit
  ,@SincroFinal	   bit
  ,@Sucursal	   int
  ,@SucursalDestino  int
  ,@SucursalOrigen   int
  ,@CfgContX	   bit
  ,@CfgContXGenerar char(20)
  ,@GenerarPoliza	   bit
  ,@Generar	         bit
  ,@GenerarMov	   char(20)
  ,@GenerarAfectado  bit
  ,@IDGenerar	   int OUTPUT	
  ,@GenerarMovID	   varchar(20) OUTPUT
  ,@Ok               int OUTPUT
  ,@OkRef            varchar(255) OUTPUT
  
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @FechaCancelacion	datetime
    ,@GenerarMovTipo	char(20)
    ,@GenerarPeriodo	int
    ,@GenerarEjercicio	int
    ,@IXPMov		varchar(20)
    ,@IAFMov		varchar(20)
    ,@CxMov		varchar(20)
    ,@CxMovID		varchar(20)
    ,@CxImporte		money
    ,@FiscalGenerarRetenciones bit

  SELECT @IXPMov = CxpImpuestosPorPagar
         ,@IAFMov = CxpImpuestosFavor
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
    
  SELECT @FiscalGenerarRetenciones = FiscalGenerarRetenciones
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa


  -- Asignar el Consecutivo al Movimiento
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, 
                        @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

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
      INSERT PrevencionLDD (
             Sucursal,  ID,         Renglon, Importe, OrigenModulo, OrigenModuloID, Contacto, ContactoTipo) 
      SELECT @Sucursal, @IDGenerar, Renglon, Importe, OrigenModulo, OrigenModuloID, Contacto, ContactoTipo
        FROM PrevencionLDD
       WHERE ID = @ID

      IF @Ok IS NULL SELECT @Ok = 80030
    END
    RETURN
  END

  ELSE
    UPDATE PrevencionLDD
       SET OrigenModulo = @Modulo,
	       OrigenModuloID = @ID
     WHERE ID = @ID 


  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo
                                 , @FechaRegistro, @FechaEmision , NULL, @Proyecto, @MovMoneda, @MovTipoCambio
                       	         , @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones, @Generar, @GenerarMov
                       	         , @GenerarMovID, @IDGenerar, @Ok OUTPUT

    IF @Accion IN ('AFECTAR', 'CANCELAR')
    BEGIN
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
        UPDATE PrevencionLD
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	       Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT, 1



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


/**************** spPrevencionLD ****************/
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE id = object_id('dbo.spPrevencionLD') and type = 'P') 
  DROP PROCEDURE dbo.spPrevencionLD
GO
CREATE PROCEDURE spPrevencionLD
  @ID              int
  ,@Modulo	       char(5)
  ,@Accion		 char(20)
  ,@Base		 char(20)
  ,@FechaRegistro	 datetime
  ,@GenerarMov	 char(20)
  ,@Usuario		 char(10)
  ,@Conexion	 bit
  ,@SincroFinal	 bit
  ,@Mov	       char(20)	  OUTPUT
  ,@MovID          varchar(20)  OUTPUT
  ,@IDGenerar	 int	        OUTPUT
  ,@Ok		 int	        OUTPUT
  ,@OkRef	       varchar(255) OUTPUT
	
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Generar		 bit
    ,@GenerarAfectado	 bit
    ,@Sucursal		 int
    ,@SucursalDestino	 int
    ,@SucursalOrigen	 int
    ,@EnLinea		 bit
    ,@PuedeEditar	       bit
    ,@Empresa	       char(5)
    ,@MovTipo   		 char(20)
    ,@MovMoneda		 char(10)
    ,@MovTipoCambio	 float
    ,@FechaEmision       datetime
    ,@FechaAfectacion	 datetime
    ,@FechaConclusion	 datetime
    ,@Proyecto	       varchar(50)
    ,@MovUsuario	       char(10)
    ,@Autorizacion       char(10)
    ,@DocFuente	       int
    ,@Concepto    	 varchar(50)
    ,@Referencia 	       varchar(50)
    ,@Observaciones      varchar(255)
    ,@Estatus            char(15)
    ,@EstatusNuevo	 char(15)
    ,@Ejercicio	       int
    ,@Periodo	       int
    ,@GenerarMovID	 varchar(20)
    ,@GenerarPoliza	 bit
    ,@CfgContX		 bit
    ,@CfgContXGenerar	 char(20)
    ,@Acreedor		 varchar(10)
    ,@Condicion		 varchar(50)
    ,@Vencimiento	       datetime

  -- Inicializar Variables
  SELECT @Generar	          = 0
	   ,@GenerarAfectado  = 0
         ,@CfgContX         = 0
         ,@CfgContXGenerar  = 'NO'
         --, @Verificar       = 1
  SET @EnLinea = 1

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal
         ,@SucursalDestino = SucursalDestino
         ,@SucursalOrigen = SucursalOrigen
         ,@Empresa = Empresa
         ,@MovID = MovID
         ,@Mov = Mov
         ,@FechaEmision = FechaEmision
         ,@Proyecto = NULLIF(RTRIM(Proyecto), '')
         ,@MovUsuario = Usuario
         ,@Autorizacion = Autorizacion
         ,@MovMoneda = Moneda
         ,@MovTipoCambio = TipoCambio
         ,@DocFuente = DocFuente
         ,@Observaciones = Observaciones
         ,@Estatus = UPPER(Estatus)
         ,@GenerarPoliza = GenerarPoliza
         ,@FechaConclusion = FechaConclusion
         ,@Concepto = Concepto
         ,@Referencia = Referencia 
         ,@Acreedor = NULLIF(RTRIM(Acreedor), '')
         ,@Condicion = NULLIF(RTRIM(Condicion), '')
         ,@Vencimiento = Vencimiento
    FROM PrevencionLD 
   WHERE ID = @ID
   
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, 
                             @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT
  SELECT @SucursalDestino = 0
  SELECT @Sucursal = 1

  IF @Ok IS NULL
  BEGIN

    IF @SucursalDestino IS NOT NULL AND @SucursalDestino <> @Sucursal AND @Accion = 'AFECTAR'
    BEGIN
      --EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
      --SET @EnLinea = 1
      IF @EnLinea = 1 
      BEGIN
        --SELECT ISNULL(@Concepto, 'Valor vacio')
        EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, 
                              @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
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
      SELECT @EstatusNuevo = 'CONCLUIDO'
    END   

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spPrevencionLDVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
                             @Acreedor, @Condicion, @Vencimiento,  
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
      EXEC spPrevencionLDAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda
                           ,@MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion, @Proyecto
			                     ,@Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia 
                           ,@Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario
                           ,@Acreedor, @Condicion, @Vencimiento, @Conexion, @SincroFinal, @Sucursal
		                       ,@SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza
		                       ,@Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT
                           ,@Ok OUTPUT, @OkRef OUTPUT

  END ELSE 
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion = 'CANCELAR' 
      EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
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

