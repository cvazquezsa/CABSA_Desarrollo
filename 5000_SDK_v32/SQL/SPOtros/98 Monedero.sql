SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/************************************* fnMonederoDV **************************************/
if exists(select * from sysobjects where id =OBJECT_ID('dbo.fnMonederoDV') and type = 'FN')
drop function dbo.fnMonederoDV
go

CREATE FUNCTION dbo.fnMonederoDV (@Monedero varchar(20), @Validar bit)
RETURNS bit
AS
BEGIN
	DECLARE @Valido   bit

	SET @Valido = 0

	IF @Validar = 1
	BEGIN
		IF EXISTS(SELECT * FROM TarjetaMonedero WHERE Serie = @Monedero AND Estatus IN ('ALTA', 'ACTIVA'))
			SET @Valido = 1
		ELSE
			SET @Valido = 0
	END    
	ELSE
		SELECT @Valido = 1

	RETURN(@Valido)
END
GO

/************************************** xpSaldoPMon  *************************************/
if exists (select * from sysobjects where id = object_id('dbo.xpSaldoPMon') and type = 'P') 
drop procedure dbo.xpSaldoPMon
GO

CREATE PROCEDURE dbo.xpSaldoPMon
        @Sucursal                int        ,
        @Accion                  varchar(20),
        @Empresa                 varchar( 5),
        @Rama                    varchar( 5),
        @Moneda                  varchar(10),
        @TipoCambio              float      ,
        @Cuenta                  varchar(20),
        @SubCuenta               varchar(50),
        @Grupo                   varchar(10),
        @Modulo                  varchar( 5),
        @ID                      int        ,
        @Mov                     varchar(20),
        @MovID                   varchar(20),
        @Cargo                   money      ,
        @Abono                   money      ,
        @Fecha                   datetime   ,
        @EjercicioAfectacion     int        ,
        @PeriodoAfectacion       int        ,
        @AcumulaSinDetalles      bit        ,
        @AcumulaEnLinea          bit        ,
        @GeneraAuxiliar          bit        ,
        @GeneraSaldo             bit        ,
        @Conciliar               bit        ,
        @Aplica                  varchar(20),
        @AplicaID                varchar(20),
        @EsResultados            bit        ,
        @Ok                      int          OUTPUT,
        @OkRef                   varchar(255) OUTPUT,
        @Renglon                 float        = NULL,
        @RenglonSub              int          = NULL,
        @RenglonID               int          = NULL
AS 
BEGIN
  RETURN
END
GO
/************************************** spCobroAutomaticoMonedero **************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCobroAutomaticoMonedero') and type = 'P') 
drop procedure dbo.spCobroAutomaticoMonedero
GO
                  
CREATE PROCEDURE dbo.spCobroAutomaticoMonedero
        @ID                int,
		@Puntos			   Money    
AS
BEGIN	

DECLARE 
	@Articulo		Varchar(20), 
	@Precio			Money, 
	@Renglon		float, 
	@RenglonID		int
	
  DECLARE crAplicaMonAut CURSOR LOCAL FOR    

	SELECT   Articulo, Precio, Renglon, RenglonID FROM VentaD WHERE ID = @ID                  
  OPEN crAplicaMonAut    
  FETCH NEXT FROM crAplicaMonAut INTO @Articulo, @Precio, @Renglon, @RenglonID   
  WHILE @@FETCH_STATUS <> -1  
	BEGIN    
      IF @@FETCH_STATUS <> -2	
		BEGIN 
			SELECT @Puntos = @Puntos - @Precio
			IF @Puntos < 0 SELECT  @Puntos = @Precio
			UPDATE VentaD SET DescuentoImporte =  @Precio
			WHERE   Articulo =  @Articulo AND  Renglon = @Renglon AND RenglonID = @RenglonID   	    
		END
		FETCH NEXT FROM crAplicaMonAut INTO @Articulo, @Precio, @Renglon, @RenglonID  
	 END
	 CLOSE crAplicaMonAut
	 DEALLOCATE crAplicaMonAut

RETURN
END
GO

/************************************** spSaldoPMon **************************************/
if exists (select * from sysobjects where id = object_id('dbo.spSaldoPMon') and type = 'P') 
drop procedure dbo.spSaldoPMon
GO
                  
CREATE PROCEDURE dbo.spSaldoPMon
        @Sucursal                int        ,
        @Accion                  varchar(20),
        @Empresa                 varchar( 5),
        @Rama                    varchar( 5),
        @Moneda                  varchar(10),
        @TipoCambio              float      ,
        @Cuenta                  varchar(20),
        @SubCuenta               varchar(50),
        @Grupo                   varchar(10),
        @Modulo                  varchar( 5),
        @ID                      int        ,
        @Mov                     varchar(20),
        @MovID                   varchar(20),
        @Cargo                   money      ,
        @Abono                   money      ,
        @Fecha                   datetime   ,
        @EjercicioAfectacion     int        ,
        @PeriodoAfectacion       int        ,
        @AcumulaSinDetalles      bit        ,
        @AcumulaEnLinea          bit        ,
        @GeneraAuxiliar          bit        ,
        @GeneraSaldo             bit        ,
        @Conciliar               bit        ,
        @Aplica                  varchar(20),
        @AplicaID                varchar(20),
        @EsResultados            bit        ,
        @Ok                      int          OUTPUT,
        @OkRef                   varchar(255) OUTPUT,
        @Renglon                 float      = NULL  ,
        @RenglonSub              int        = NULL  ,
        @RenglonID               int        = NULL  ,
        @SubCuenta2              varchar(50)= ''    ,
        @SubCuenta3              varchar(50)= ''    ,
        @Proyecto                varchar(50)= ''    ,
        @UEN                     int        = 0
AS 
BEGIN
  DECLARE
        @FechaSinHora            datetime   ,
        @SubCuentaAcum           varchar(50),
        @SubCuenta2Acum          varchar(50),
        @SubCuenta3Acum          varchar(50),
        @ImporteConciliar        money      ,
        @Temp                    money      ,
        @CargoAux                money      ,
        @AbonoAux                money      ,
        @EsCancelacion           bit
  
  SELECT @Cargo          = ISNULL(@Cargo          , 0.0), 
         @Abono          = ISNULL(@Abono          , 0.0)
  
  SET @Sucursal = 0
  IF @EjercicioAfectacion IS NULL SELECT @EjercicioAfectacion = YEAR(GETDATE())
  IF @PeriodoAfectacion IS NULL SELECT @PeriodoAfectacion = MONTH(GETDATE())

  
  IF @Accion IN ('CANCELAR', 'DESAFECTAR')
  BEGIN
    SELECT @EsCancelacion = 1--, @Temp = @Cargo
  --  SELECT @Cargo = @Abono--, @Abono = -@Temp
  END 
  ELSE 
    SELECT @EsCancelacion = 0
  
  -- Actualizar Saldos
  IF @GeneraSaldo = 1 AND @Ok IS NULL
  BEGIN
    IF @AcumulaSinDetalles = 1 
      SELECT @SubCuentaAcum = '', @SubCuenta2Acum = '', @SubCuenta3Acum = '' 
    ELSE 
      SELECT @SubCuentaAcum = @SubCuenta, @SubCuenta2Acum = @SubCuenta2, @SubCuenta3Acum = @SubCuenta3
      
    IF @Conciliar = 1 
      SELECT @ImporteConciliar = @Cargo - @Abono 
    ELSE SELECT @ImporteConciliar = 0.0
    
    IF @EsResultados = 0 
    BEGIN

      UPDATE SaldoPMon WITH (ROWLOCK) 
         SET Saldo           = ISNULL(Saldo, 0.0) - @Cargo + @Abono,
             PorConciliar    = ISNULL(PorConciliar, 0.0)    + @ImporteConciliar,
             UltimoCambio    = @Fecha
       WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND SubCuenta = @SubCuentaAcum
         AND SubCuenta2 = @SubCuenta2Acum AND SubCuenta3 = @SubCuenta3Acum AND Proyecto = @Proyecto --AND UEN = @UEN

      IF @@ROWCOUNT = 0
        INSERT SaldoPMon --EAS
               ( Sucursal,  Empresa,  Rama,  Moneda,  Grupo,  Cuenta,  SubCuenta,      SubCuenta2,      SubCuenta3,      Proyecto,  UEN,  Saldo         , PorConciliar     ,  UltimoCambio)
        VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuentaAcum, @SubCuenta2Acum, @SubCuenta3Acum, @Proyecto, NULL, (@Cargo+@Abono), @ImporteConciliar, @Fecha)
              
      IF @@ERROR <> 0 
        SELECT @Ok = 1
    END 
  END
  
  -- Generar Auxiliares 
  IF @GeneraAuxiliar = 1 AND @Ok IS NULL 
  BEGIN
    IF @Accion = 'DESAFECTAR'
    BEGIN
      IF (SELECT Sucursal FROM Version) <> 0
        SELECT @Ok = 60290

      IF @EsResultados = 0 
        DELETE AuxiliarPMon WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta 
                           AND SubCuenta = @SubCuenta AND Mov = @Mov AND MovID = @MovID AND Ejercicio = @EjercicioAfectacion AND Periodo = @PeriodoAfectacion
                           
      IF @@ROWCOUNT = 0 SELECT @Ok = 60100, @OkRef = 'Movimiento: '+RTRIM(@Mov) + ' ' +LTRIM(Convert(varchar, @MovID))
    END 
    ELSE
    BEGIN
      SELECT @FechaSinHora       = @Fecha                      ,
             @CargoAux           = NULLIF(@Cargo         , 0.0),
             @AbonoAux           = NULLIF(@Abono         , 0.0)
             
      EXEC spExtraerFecha @FechaSinHora OUTPUT

      IF @EsResultados = 0 
        INSERT AuxiliarPMon (Sucursal, Empresa, Rama, Moneda, TipoCambio, Cuenta, SubCuenta, Ejercicio, Periodo, Fecha, 
                          Grupo, Modulo, ModuloID, Mov, MovID, Cargo, Abono, Aplica, AplicaID, Acumulado, Conciliado, EsCancelacion,
                          Renglon, RenglonSub)
                 VALUES  (@Sucursal, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @EjercicioAfectacion, @PeriodoAfectacion, @FechaSinHora,
                          @Grupo, @Modulo, @ID, @Mov, @MovID,@CargoAux,@AbonoAux,@Aplica, @AplicaID, @AcumulaEnLinea, 0, @EsCancelacion, 
                          @Renglon, @RenglonSub)
      
      IF @@ERROR <> 0 
        SELECT @Ok = 1
    END
  END
   
  -- Actualizar Acumulados
  IF @AcumulaEnLinea = 1 AND @Ok IS NULL
  BEGIN
    IF @AcumulaSinDetalles = 1 SELECT @SubCuentaAcum = '' ELSE SELECT @SubCuentaAcum = @SubCuenta
    
    IF @EsResultados = 0 
    BEGIN
      UPDATE AcumPMon WITH (ROWLOCK) 
         SET Cargos           = ISNULL(Cargos          , 0.0) + @Cargo         ,
             Abonos           = ISNULL(Abonos          , 0.0) + @Abono         ,
             UltimoCambio     = @Fecha
       WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta 
         AND SubCuenta = @SubCuentaAcum AND Periodo = @PeriodoAfectacion AND Ejercicio = @EjercicioAfectacion
         AND SubCuenta2 = @SubCuenta2Acum AND SubCuenta3 = @SubCuenta3Acum AND Proyecto = @Proyecto --AND UEN = @UEN
      
      IF @@ROWCOUNT = 0
        INSERT AcumPMon (Sucursal,  Empresa,  Rama,  Moneda,  Cuenta,  SubCuenta,      SubCuenta2,      SubCuenta3,      Proyecto,  UEN,  Grupo,  Ejercicio,            Periodo,            
                      Cargos,  Abonos, UltimoCambio)
             VALUES  (@Sucursal, @Empresa, @Rama, @Moneda, @Cuenta, @SubCuentaAcum, @SubCuenta2Acum, @SubCuenta3Acum, @Proyecto, @UEN, @Grupo, @EjercicioAfectacion, @PeriodoAfectacion,
                      @Cargo,  @Abono, @Fecha)
      
      IF @@ERROR <> 0 SELECT @Ok = 1
    END
  END
  
  -- xp's
  IF @Ok IS NULL
    EXEC xpSaldoPMon @Sucursal, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo,
		              @Modulo, @ID, @Mov, @MovID, @Cargo, @Abono, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @AcumulaSinDetalles, @AcumulaEnLinea, 
		              @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Aplica, @AplicaID, @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, 
		              @RenglonSub = @RenglonSub, @RenglonID = @RenglonID
	
  RETURN
END
GO


/************************************** spTraspasarSaldosP **************************************/
if exists (select * from sysobjects where id = object_id('dbo.spTraspasarSaldosP') and type = 'P') 
drop procedure dbo.spTraspasarSaldosP
GO
             
CREATE PROCEDURE dbo.spTraspasarSaldosP
          @Empresa            varchar( 5),
          @Ejercicio          int        ,
          @Procesando         bit     = 0

AS
BEGIN  
  DECLARE
          @Ahora              datetime   ,
          @EjercicioAnterior  int        ,
          @Sucursal           int        ,
          @Rama               varchar( 5), 
          @Moneda             varchar(10),
          @Grupo              varchar(10),
          @Cuenta             varchar(20),
          @SubCuenta          varchar(50),
          @Cargos             money      ,
          @Abonos             money      ,
          @CargoInicial       money      ,
          @AbonoInicial       money      ,
          @EjercicioInicio    datetime   ,
          @EjercicioFinal     datetime   ,
          @SeCreoEjercicio    bit        ,
          @SeModificioGral    bit        ,
          @Mensaje            varchar(150)
  
  SELECT @Ahora = GETDATE(), @EjercicioAnterior = @Ejercicio - 1, @SeCreoEjercicio = 0, @SeModificioGral = 0
  
  DECLARE crAcumPMon CURSOR FOR
   SELECT Sucursal, Rama, Moneda, Grupo, Cuenta, SubCuenta, "Cargos"=ISNULL(SUM(Cargos), 0.0), "Abonos"=ISNULL(SUM(Abonos), 0.0)
     FROM AcumF
    WHERE Empresa = @Empresa AND Ejercicio = @EjercicioAnterior
    GROUP BY Sucursal, Rama, Moneda, Grupo, Cuenta, SubCuenta
    ORDER BY Sucursal, Rama, Moneda, Grupo, Cuenta, SubCuenta
             
  OPEN crAcumPMon
  FETCH NEXT FROM crAcumPMon INTO @Sucursal, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, @Cargos, @Abonos
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Cargos > @Abonos 
        SELECT @CargoInicial = @Cargos - @Abonos, @AbonoInicial = 0.0
      ELSE
        SELECT @CargoInicial = 0.0, @AbonoInicial = @Abonos - @Cargos
        
      UPDATE AcumPMon
         SET Cargos 	        = @CargoInicial, 
             Abonos           = @AbonoInicial,
             UltimoCambio     = @Ahora
       WHERE Sucursal         = @Sucursal
         AND Rama 	          = @Rama
         AND Empresa 	        = @Empresa 
         AND Ejercicio        = @Ejercicio
         AND Periodo 	        = 0
         AND Moneda 	        = @Moneda
         AND Grupo 	          = @Grupo
         AND Cuenta 	        = @Cuenta
         AND SubCuenta        = @SubCuenta

       IF @@ROWCOUNT = 0
       BEGIN
         SELECT @SeCreoEjercicio = 1
         INSERT AcumPMon( Sucursal, Empresa, Rama, Ejercicio, Periodo, Moneda, Grupo, Cuenta, SubCuenta, Cargos      , Abonos      , UltimoCambio)
              VALUES (@Sucursal,@Empresa,@Rama,@Ejercicio, 0      ,@Moneda,@Grupo,@Cuenta,@SubCuenta,@CargoInicial,@AbonoInicial, @Ahora      )
       END
    END
    FETCH NEXT FROM crAcumPMon INTO @Sucursal, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, @Cargos, @Abonos
  END -- While
  CLOSE crAcumPMon
  DEALLOCATE crAcumPMon
  
  RETURN
END
GO

/************************************** spConsecutivoMonederoUltimo **************************************/
if exists (select * from sysobjects where id = object_id('dbo.spConsecutivoMonederoUltimo') and type = 'P') 
drop procedure dbo.spConsecutivoMonederoUltimo
GO

CREATE PROCEDURE dbo.spConsecutivoMonederoUltimo  
          @Sucursal         int        ,  
          @Empresa          varchar( 5),  
          @Modulo           varchar( 5),  
          @Mov              varchar(20),  
          @Ejercicio        int        ,  
          @Periodo          int        ,  
          @Consecutivo      bigint      OUTPUT,  
          @Ok               int         OUTPUT  
AS   
BEGIN  
  SELECT @Consecutivo = NULL  
    
  SELECT @Consecutivo = MAX(Consecutivo)   
    FROM MonederoC  
   WHERE Sucursal  = @Sucursal   
     AND Empresa   = @Empresa   
     AND Mov       = @Mov   
     AND Ejercicio = @Ejercicio   
     AND Periodo   = @Periodo  
    
  RETURN   
END
GO

/************************************** spMovChecarConsecutivoMonedero **************************************/
if exists (select * from sysobjects where id = object_id('dbo.spMovChecarConsecutivoMonedero') and type = 'P') 
drop procedure dbo.spMovChecarConsecutivoMonedero
GO
                         
CREATE PROCEDURE dbo.spMovChecarConsecutivoMonedero  
          @Empresa       varchar( 5),   
          @Modulo        varchar( 5),   
          @Mov           varchar(20),  
          @MovID         varchar(20),  
          @Ejercicio     int        ,  
          @Periodo       int        ,  
          @Ok            int          OUTPUT,  
          @OkRef         varchar(255) OUTPUT  
AS   
BEGIN  
  DECLARE  
          @YaExiste      int  
      
  SELECT @YaExiste = NULL  
    
  SELECT @YaExiste = COUNT(*)   
    FROM Monedero   
   WHERE Empresa = @Empresa   
     AND Mov     = @Mov   
     AND MovID   = @MovID   
     AND Estatus NOT IN ('SINAFECTAR')  
     
  IF ISNULL(@YaExiste, 0) > 0   
    SELECT @Ok = 30010, @OkRef = RTRIM(@Mov)+' '+RTRIM(@MovID)+' ('+RTRIM(@Modulo)+')'  
    
  RETURN  
END
GO

/************************************** spConsecutivoMonedero **************************************/
if exists (select * from sysobjects where id = object_id('dbo.spConsecutivoMonedero') and type = 'P') 
drop procedure dbo.spConsecutivoMonedero
GO

CREATE PROCEDURE dbo.spConsecutivoMonedero    
          @Sucursal       int        ,    
          @Empresa        varchar( 5),    
          @Modulo         varchar( 5),    
          @ID             int        ,    
          @Mov            varchar(20),    
          @Ejercicio      int          = NULL,    
          @Periodo        int          = NULL,    
          @MovIDst        varchar(20)  OUTPUT,    
          @Ok             int          OUTPUT,    
          @OkRef          varchar(255) OUTPUT    
AS    
BEGIN    
  DECLARE    
          @Consecutivo    bigint     ,    
          @MovID          bigint     ,   
          @Prefijo        char   (10),  
          @ConsecutivoGen varchar(20)     
      
  SELECT @Periodo = NULL, @Ejercicio = NULL, @ConsecutivoGen = NULL, @MovID = CONVERT(bigint, @MovIDSt)    
  SELECT  @Prefijo = Prefijo    
                        FROM    Sucursal WITH ( NOLOCK )    
                        WHERE   Sucursal = @Sucursal   
      
  UPDATE MonederoC  WITH (ROWLOCK) SET Consecutivo = Consecutivo + 1 WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Mov = @Mov AND Ejercicio = @Ejercicio AND Periodo = @Periodo    
      
  IF @@ERROR <> 0 SELECT @Ok = 1    
    EXEC spConsecutivoMonederoUltimo @Sucursal, @Empresa, @Modulo, @Mov, @Ejercicio, @Periodo, @Consecutivo OUTPUT, @Ok OUTPUT    
      
  IF NULLIF(@Consecutivo, 0) = NULL AND @Ok IS NULL    
  BEGIN    
    INSERT MonederoC             
           ( Sucursal, Empresa, Mov, Ejercicio, Periodo,Consecutivo)     
    VALUES (@Sucursal,@Empresa,@Mov,@Ejercicio,@Periodo,1)    
        
    IF @@ERROR <> 0 SELECT @Ok = 1    
      SELECT @Consecutivo = 1    
  END    
      
    
    SELECT @ConsecutivoGen = RTRIM(@Prefijo) + dbo.fnConsecutivoEnMovID(@Sucursal, @Empresa, @Modulo, @Mov, @Ejercicio, @Periodo, NULL, @Consecutivo)    
    
  IF @Ok IS NULL    
    EXEC spMovChecarConsecutivoMonedero @Empresa, @Modulo, @Mov, @ConsecutivoGen, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL    
     SELECT @MovIDst = @ConsecutivoGen    
      
END 
GO


/************************************** spAfectarMonedero **************************************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarMonedero') and type = 'P') 
drop procedure dbo.spAfectarMonedero
GO
                
CREATE PROCEDURE dbo.spAfectarMonedero    
          @Empresa      varchar( 5),    
          @Sucursal     int        ,    
          @Accion       varchar(20),    
          @ID           int        ,    
          @Usuario      varchar(10),    
          @Modulo       varchar( 5),    
          @Mov          varchar(20),    
          @Estatus      varchar(15)
AS    
BEGIN    
  DECLARE    
          @MovID                   varchar(20),    
          @Serie                   varchar(20),    
          @FechaMov                datetime   ,    
          @EstatusN                varchar(15),    
          @Rama                    varchar( 5),    
          @Moneda                  varchar(10),    
          @TipoCambio              float      ,    
          @Cuenta                  varchar(20),    
          @CuentaDestino           varchar(20),    
          @SubCuenta               varchar(50),    
          @Grupo                   varchar(10),    
          @Cargo                   money      ,    
          @Abono                   money      ,    
          @Fecha                   datetime   ,    
          @EjercicioAfectacion     int        ,    
          @PeriodoAfectacion       int        ,    
          @AcumulaSinDetalles      bit        ,    
          @AcumulaEnLinea          bit        ,    
          @GeneraAuxiliar          bit        ,    
          @GeneraSaldo             bit        ,    
          @Conciliar               bit        ,    
          @Aplica                  varchar(20),    
          @AplicaID                varchar(20),    
          @EsResultados            bit        ,    
          @Renglon                 float      ,    
          @RenglonSub              int        ,    
          @RenglonID               int        ,    
          @SubCuenta2              varchar(50),    
          @SubCuenta3              varchar(50),    
          @Proyecto                varchar(50),    
          @Observaciones           varchar(100),    
          @Referencia              varchar(50),    
          @UEN                     int        ,    
          @ImporteMov              money      ,    
          @Ok                      int        ,    
          @OkRef                   varchar(255)    
                            
  BEGIN TRANSACTION      
      
  SELECT @Moneda = ContMoneda, @TipoCambio = 1.0, @Rama = 'MONEL', @SubCuenta = '', @Grupo = 'ME',     
         @AcumulaSinDetalles = 1, @AcumulaEnLinea = 1, @GeneraAuxiliar = 1, @GeneraSaldo = 1, @Conciliar = 0, @EsResultados = 0    
    FROM EmpresaCfg     
   WHERE Empresa = @Empresa    
                       
  IF @Modulo = 'MONEL'    
  BEGIN    
    IF @Accion = 'AFECTAR'    
    BEGIN    
      IF @Estatus = 'SINAFECTAR'    
      BEGIN    
        SELECT @EstatusN = 'CONCLUIDO', @FechaMov = GETDATE()    
                                
        IF @Mov = 'Activacion Tarjeta' AND @Ok IS NULL    
        BEGIN    
          EXEC spConsecutivoMonedero @Sucursal, @Empresa, @Modulo, @ID, @Mov, NULL, NULL, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
            
          IF @MovID IS NOT NULL AND @OK IS NULL    
          BEGIN    
            UPDATE Monedero SET MovID = @MovID WHERE ID = @ID    
              
            IF EXISTS(SELECT * FROM MonederoD WHERE ID = @ID)    
            BEGIN    
              IF NOT EXISTS(SELECT *     
                              FROM Monedero M    
                              JOIN MonederoD D ON M.ID = D.ID    
                              JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                             WHERE M.ID = @ID    
                               AND T.Estatus IN ('ACTIVA'))    
              BEGIN    
                UPDATE TarjetaMonedero     
                   SET TarjetaMonedero.Estatus           = 'ACTIVA',    
                       TarjetaMonedero.TieneMovimientos  = 1       ,    
                       TarjetaMonedero.UsuarioActivacion = @Usuario,    
                       TarjetaMonedero.FechaActivacion   = M.FechaEmision    
                  FROM Monedero  M    
                  JOIN MonederoD D ON M.ID = D.ID    
                  JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                 WHERE M.ID = @ID                 
                    
                UPDATE Monedero    
                   SET UltimoCambio    = @FechaMov  ,    
                       Estatus         = @EstatusN,    
                       FechaConclusion = @FechaMov  ,    
                       Ejercicio       = YEAR (FechaEmision),    
                       Periodo         = MONTH(FechaEmision)    
                 WHERE ID = @ID    
                    
                SELECT @EjercicioAfectacion = Ejercicio, @PeriodoAfectacion = Periodo, @Fecha = FechaEmision, @Referencia = Referencia, @Observaciones = Observaciones    
                  FROM Monedero    
                 WHERE ID = @ID    
                    
                IF NOT EXISTS(SELECT * FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID AND Estatus = @EstatusN)    
                  INSERT MovTiempo    
                         (Modulo , ID, FechaComenzo, FechaInicio, Estatus ,  Sucursal, Usuario)    
                  VALUES (@Modulo,@ID, @FechaMov   , @FechaMov  ,@EstatusN, @Sucursal,@Usuario)     
                    
                IF @OK IS NULL    
                  EXEC spMovInsertar @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @EjercicioAfectacion, @PeriodoAfectacion, @FechaMov, @Fecha,    
                                     NULL, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, @Observaciones, @Ok OUTPUT       
              END    
              ELSE    
                SELECT @OK = 99001, @OKRef = T.Serie     
                  FROM Monedero        M    
                  JOIN MonederoD       D ON M.ID      = D.ID    
                  JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                 WHERE M.ID = @ID    
                   AND T.Estatus IN ('ACTIVA')    
            END    
            ELSE    
              SELECT @OK = 60010    
          END    
        END    
            
        IF @Mov = 'Baja Tarjeta' AND @Ok IS NULL    
        BEGIN    
          EXEC spConsecutivoMonedero @Sucursal, @Empresa, @Modulo, @ID, @Mov, NULL, NULL, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
            
          IF @MovID IS NOT NULL AND @OK IS NULL    
          BEGIN    
            UPDATE Monedero SET MovID = @MovID WHERE ID = @ID    
                
            IF EXISTS(SELECT * FROM Monedero WHERE ID = @ID)    
            BEGIN    
              IF NOT EXISTS(SELECT *     
                              FROM Monedero  M    
                              JOIN MonederoD D ON M.ID = D.ID    
                              JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                             WHERE M.ID = @ID    
                               AND T.Estatus IN ('ALTA','BAJA'))    
              BEGIN    
                IF ISNULL((SELECT SUM(ISNULL(Saldo,0.0)) FROM SaldoPMon WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta IN (SELECT Serie FROM MonederoD WHERE ID = @ID )),0.0) = 0.0    
                BEGIN    
                  UPDATE TarjetaMonedero     
                     SET TarjetaMonedero.Estatus          = 'BAJA',    
                         TarjetaMonedero.TieneMovimientos = 1     ,    
                         TarjetaMonedero.FechaBaja        = M.FechaEmision    
                    FROM Monedero  M    
                    JOIN MonederoD D ON M.ID = D.ID    
                    JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                   WHERE M.ID = @ID                 
                      
                  UPDATE Monedero    
                     SET UltimoCambio    = @FechaMov  ,    
                         Estatus         = @EstatusN,    
                         FechaConclusion = @FechaMov  ,    
                         Ejercicio       = YEAR (FechaEmision),    
                         Periodo         = MONTH(FechaEmision)    
                   WHERE ID = @ID    
                      
                  SELECT @EjercicioAfectacion = Ejercicio, @PeriodoAfectacion = Periodo, @Fecha = FechaEmision, @Referencia = Referencia, @Observaciones = Observaciones    
                    FROM Monedero    
                   WHERE ID = @ID    
                      
                  IF NOT EXISTS(SELECT * FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID AND Estatus = @EstatusN)    
                    INSERT MovTiempo    
                           (Modulo , ID, FechaComenzo, FechaInicio, Estatus ,  Sucursal, Usuario)    
                    VALUES (@Modulo,@ID, @FechaMov   , @FechaMov  ,@EstatusN, @Sucursal,@Usuario)     
                      
                  IF @OK IS NULL    
                    EXEC spMovInsertar @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @EjercicioAfectacion, @PeriodoAfectacion, @FechaMov, @Fecha,    
                                       NULL, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, @Observaciones, @Ok OUTPUT     
                END    
                ELSE    
                  SELECT @OK = 99004, @OKRef = Cuenta     
                    FROM SaldoPMon     
                   WHERE Empresa = @Empresa     
                     AND Rama = @Rama     
                     AND Moneda = @Moneda     
                     AND Grupo = @Grupo     
                     AND Cuenta IN (SELECT Serie FROM MonederoD WHERE ID = @ID)    
                     AND ISNULL(Saldo,0.0) > 0.0    
              END    
              ELSE    
                SELECT @OK = 99001, @OKRef = T.Serie     
                  FROM Monedero        M    
                  JOIN MonederoD       D ON M.ID      = D.ID    
                  JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                 WHERE M.ID = @ID    
                   AND T.Estatus IN ('ALTA','BAJA')    
            END    
            ELSE    
              SELECT @OK = 60010    
          END    
        END    
            
        IF @Mov = 'Aumento Saldo' AND @Ok IS NULL    
        BEGIN    
          EXEC spConsecutivoMonedero @Sucursal, @Empresa, @Modulo, @ID, @Mov, NULL, NULL, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
            
          IF @MovID IS NOT NULL AND @OK IS NULL    
          BEGIN    
            UPDATE Monedero SET MovID = @MovID WHERE ID = @ID    
                
            IF EXISTS(SELECT * FROM MonederoD WHERE ID = @ID)    
            BEGIN    
              IF NOT EXISTS(SELECT *     
                              FROM Monedero M    
                              JOIN MonederoD D ON M.ID = D.ID    
                              JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                             WHERE M.ID = @ID    
                               AND T.Estatus IN ('ALTA','BAJA'))    
              BEGIN    
                IF NOT EXISTS(SELECT *     
                                FROM Monedero M    
                                JOIN MonederoD D ON M.ID = D.ID    
                               WHERE M.ID = @ID    
                                 AND NULLIF(D.Importe,0.0) IS NULL)    
                BEGIN    
                  SELECT @RenglonID = 0    
                      
                  DECLARE crAumentarSaldoME CURSOR LOCAL FOR    
                   SELECT C.Mov, C.MovID, C.FechaEmision, YEAR(C.FechaEmision), MONTH(C.FechaEmision), C.Mov, C.MovID, ISNULL(C.Uen,''), C.Referencia, C.Observaciones,     
                          D.Renglon, D.RenglonSub, D.Serie, ISNULL(D.Importe,0.0)    
                     FROM Monedero  C    
                     JOIN MonederoD D ON C.ID = D.ID    
                    WHERE C.ID = @ID    
                    ORDER BY C.ID, D.Renglon    
                      
                  OPEN crAumentarSaldoME    
                  FETCH NEXT FROM crAumentarSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                         @Renglon, @RenglonSub, @Cuenta, @Cargo    
                  WHILE @@FETCH_STATUS <> -1 AND @Cuenta IS NOT NULL AND @OK IS NULL    
                  BEGIN    
                    IF @@FETCH_STATUS <> -2    
                    BEGIN    
                      SELECT @RenglonID = @RenglonID + 1, @ImporteMov = ISNULL(@ImporteMov,0.0) + ISNULL(@Cargo,0.0)    
                          
                      EXEC spSaldoPMon 0, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, @Cargo, @Abono, @Fecha,     
                           @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Aplica, @AplicaID,     
                           @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN    
                    END    
                    FETCH NEXT FROM crAumentarSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                           @Renglon, @RenglonSub, @Cuenta, @Cargo    
                  END    
                  CLOSE crAumentarSaldoME    
                  DEALLOCATE crAumentarSaldoME    
                      
                  UPDATE Monedero    
                     SET UltimoCambio    = @FechaMov  ,    
                         Estatus         = @EstatusN  ,    
                         FechaConclusion = @FechaMov  ,    
                         Importe         = @ImporteMov,    
                         Ejercicio       = YEAR (FechaEmision),    
                         Periodo         = MONTH(FechaEmision)    
                   WHERE ID = @ID    
                       
                  IF NOT EXISTS(SELECT * FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID AND Estatus = @EstatusN)    
                    INSERT MovTiempo    
                           (Modulo , ID, FechaComenzo, FechaInicio, Estatus ,  Sucursal, Usuario)    
                    VALUES (@Modulo,@ID, @FechaMov   , @FechaMov  ,@EstatusN, @Sucursal,@Usuario)    
                      
                  IF @OK IS NULL    
                    EXEC spMovInsertar @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @EjercicioAfectacion, @PeriodoAfectacion, @FechaMov, @Fecha,    
                                       NULL, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, @Observaciones, @Ok OUTPUT       
                END    
                ELSE    
                  SELECT @OK = 30100, @OKRef = D.Serie     
                    FROM Monedero M    
                    JOIN MonederoD D ON M.ID = D.ID    
                   WHERE M.ID = @ID    
                     AND NULLIF(D.Importe,0.0) IS NULL    
              END    
              ELSE    
                SELECT @OK = 99001, @OKRef = T.Serie     
                  FROM Monedero        M    
                  JOIN MonederoD       D ON M.ID      = D.ID    
                  JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                 WHERE M.ID = @ID    
                   AND T.Estatus IN ('ALTA','BAJA')    
            END    
            ELSE    
              SELECT @OK = 60010    
          END    
        END    
            
        IF @Mov = 'Disminucion Saldo' AND @Ok IS NULL    
        BEGIN    
          EXEC spConsecutivoMonedero @Sucursal, @Empresa, @Modulo, @ID, @Mov, NULL, NULL, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
            
          IF @MovID IS NOT NULL AND @OK IS NULL    
          BEGIN    
            UPDATE Monedero SET MovID = @MovID WHERE ID = @ID    
                
            IF EXISTS(SELECT * FROM MonederoD WHERE ID = @ID)    
            BEGIN    
              IF NOT EXISTS(SELECT *     
                              FROM Monedero M    
                              JOIN MonederoD D ON M.ID = D.ID    
                              JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                             WHERE M.ID = @ID    
                               AND T.Estatus IN ('ALTA','BAJA'))    
              BEGIN    
                IF NOT EXISTS(SELECT *     
                                FROM Monedero  M    
                                JOIN MonederoD D ON M.ID = D.ID    
                               WHERE M.ID = @ID    
                                 AND NULLIF(D.Importe,0.0) IS NULL)    
                BEGIN    
                  SELECT @RenglonID = 0    
                      
                  DECLARE crDisminuirSaldoME CURSOR LOCAL FOR    
                   SELECT C.Mov, C.MovID, C.FechaEmision, YEAR(C.FechaEmision), MONTH(C.FechaEmision), C.Mov, C.MovID, ISNULL(C.Uen,''), C.Referencia, C.Observaciones,    
                          D.Renglon, D.RenglonSub, D.Serie, ISNULL(D.Importe,0.0)    
                     FROM Monedero  C    
                     JOIN MonederoD D ON C.ID = D.ID    
                    WHERE C.ID = @ID    
                    ORDER BY C.ID, D.Renglon    
                        
                  OPEN crDisminuirSaldoME    
                  FETCH NEXT FROM crDisminuirSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                          @Renglon, @RenglonSub, @Cuenta, @Abono    
                  WHILE @@FETCH_STATUS <> -1 AND @Cuenta IS NOT NULL AND @OK IS NULL    
                  BEGIN    
                    IF @@FETCH_STATUS <> -2    
                    BEGIN    
                      SELECT @RenglonID = @RenglonID + 1, @ImporteMov = ISNULL(@ImporteMov,0.0) + ISNULL(@Abono,0.0)    
                          
                      IF (SELECT SUM(ISNULL(Saldo,0.0)) FROM SaldoPMon WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND UEN = ISNULL(NULLIF(@UEN,''),'0')) >= @Abono    
                        EXEC spSaldoPMon 0, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, @Cargo, @Abono, @Fecha,     
                             @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Aplica, @AplicaID,     
                             @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN    
                      ELSE    
                        SELECT @OK = 99002, @OKRef = @Cuenta    
                    END    
                    FETCH NEXT FROM crDisminuirSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                            @Renglon, @RenglonSub, @Cuenta, @Abono    
                  END    
                  CLOSE crDisminuirSaldoME    
                  DEALLOCATE crDisminuirSaldoME    
                      
                  UPDATE Monedero    
                     SET UltimoCambio    = @FechaMov  ,    
                         Estatus         = @EstatusN  ,    
                         FechaConclusion = @FechaMov  ,    
                         Importe         = @ImporteMov,    
                         Ejercicio       = YEAR (FechaEmision),    
                         Periodo         = MONTH(FechaEmision)    
                   WHERE ID = @ID    
                       
                  IF NOT EXISTS(SELECT * FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID AND Estatus = @EstatusN)    
                    INSERT MovTiempo    
                           (Modulo , ID, FechaComenzo, FechaInicio, Estatus ,  Sucursal, Usuario)    
                    VALUES (@Modulo,@ID, @FechaMov   , @FechaMov  ,@EstatusN, @Sucursal,@Usuario)    
                        
                  IF @OK IS NULL    
                    EXEC spMovInsertar @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @EjercicioAfectacion, @PeriodoAfectacion, @FechaMov, @Fecha,    
                                       NULL, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, @Observaciones, @Ok OUTPUT       
                END    
                ELSE    
                  SELECT @OK = 30100, @OKRef = D.Serie     
                    FROM Monedero M    
                    JOIN MonederoD D ON M.ID = D.ID    
                   WHERE M.ID = @ID    
                     AND NULLIF(D.Importe,0.0) IS NULL    
              END    
              ELSE    
                SELECT @OK = 99001, @OKRef = T.Serie     
                  FROM Monedero        M    
                  JOIN MonederoD       D ON M.ID      = D.ID    
                  JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                 WHERE M.ID = @ID    
                   AND T.Estatus IN ('ALTA','BAJA')    
            END    
            ELSE    
              SELECT @OK = 60010    
          END    
        END    
            
        IF @Mov = 'Traspaso Saldo' AND @Ok IS NULL    
        BEGIN    
          EXEC spConsecutivoMonedero @Sucursal, @Empresa, @Modulo, @ID, @Mov, NULL, NULL, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
            
          IF @MovID IS NOT NULL AND @OK IS NULL    
          BEGIN    
            UPDATE Monedero SET MovID = @MovID WHERE ID = @ID    
                
            IF EXISTS(SELECT * FROM MonederoD WHERE ID = @ID)    
            BEGIN    
              IF NOT EXISTS(SELECT *     
                              FROM Monedero M    
                              JOIN MonederoD D ON M.ID = D.ID    
                              JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                             WHERE M.ID = @ID    
                               AND T.Estatus IN ('ALTA','BAJA'))    
              BEGIN    
                IF NOT EXISTS(SELECT *     
                                FROM Monedero M    
                                JOIN MonederoD D ON M.ID = D.ID    
                                LEFT OUTER JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.SerieDestino = T.Serie    
                               WHERE M.ID = @ID    
                                 AND T.Serie IS NULL)    
                BEGIN    
                  IF NOT EXISTS(SELECT *     
                                  FROM Monedero M    
                                  JOIN MonederoD D ON M.ID = D.ID    
                                  JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.SerieDestino = T.Serie    
                                 WHERE M.ID = @ID    
                                   AND T.Estatus IN ('ALTA','BAJA'))    
                  BEGIN    
                    IF NOT EXISTS(SELECT *     
                                    FROM Monedero M    
                                    JOIN MonederoD D ON M.ID = D.ID    
                                   WHERE M.ID = @ID    
                                     AND NULLIF(D.Importe,0.0) IS NULL)    
                    BEGIN    
                      SELECT @RenglonID = 0    
                          
                      DECLARE crTraspasarSaldoME CURSOR LOCAL FOR    
                       SELECT C.Mov, C.MovID, C.FechaEmision, YEAR(C.FechaEmision), MONTH(C.FechaEmision), C.Mov, C.MovID, ISNULL(C.Uen,''), C.Referencia, C.Observaciones,     
                              D.Renglon, D.RenglonSub, D.Serie, D.SerieDestino, ISNULL(D.Importe,0.0), ISNULL(D.Importe,0.0)    
                         FROM Monedero  C    
                         JOIN MonederoD D ON C.ID = D.ID    
                        WHERE C.ID = @ID    
                        ORDER BY C.ID, D.Renglon    
                            
                      OPEN crTraspasarSaldoME    
                      FETCH NEXT FROM crTraspasarSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                              @Renglon, @RenglonSub, @Cuenta, @CuentaDestino, @Cargo, @Abono    
                      WHILE @@FETCH_STATUS <> -1 AND @Cuenta IS NOT NULL AND @OK IS NULL    
                      BEGIN    
                        IF @@FETCH_STATUS <> -2    
                        BEGIN    
                          SELECT @RenglonID = @RenglonID + 1, @ImporteMov = ISNULL(@ImporteMov,0.0) + ISNULL(@Abono,0.0)    
                              
                          IF (SELECT SUM(ISNULL(Saldo,0.0)) FROM SaldoPMon WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND UEN = ISNULL(NULLIF(@UEN,''),'0')) > @Abono    
                          BEGIN    
                            EXEC spSaldoPMon 0, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, NULL, @Abono, @Fecha,     
                                 @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Aplica, @AplicaID,     
                                 @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN    
                                
                            IF @OK IS NULL    
                              EXEC spSaldoPMon 0, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @CuentaDestino, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, @Cargo, NULL, @Fecha,     
                                   @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Aplica, @AplicaID,     
                                   @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN    
                          END    
                          ELSE    
                            SELECT @OK = 99002, @OKRef = @Cuenta    
                        END    
                        FETCH NEXT FROM crTraspasarSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                                @Renglon, @RenglonSub, @Cuenta, @CuentaDestino, @Cargo, @Abono    
                      END    
                      CLOSE crTraspasarSaldoME    
                      DEALLOCATE crTraspasarSaldoME    
                          
                      UPDATE Monedero    
                         SET UltimoCambio    = @FechaMov  ,    
                             Estatus         = @EstatusN  ,    
                             FechaConclusion = @FechaMov  ,    
                             Importe         = @ImporteMov,    
                             Ejercicio       = YEAR (FechaEmision),    
                             Periodo         = MONTH(FechaEmision)    
                       WHERE ID = @ID    
                           
                      IF NOT EXISTS(SELECT * FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID AND Estatus = @EstatusN)    
                        INSERT MovTiempo    
                               (Modulo , ID, FechaComenzo, FechaInicio, Estatus ,  Sucursal, Usuario)    
                        VALUES (@Modulo,@ID, @FechaMov   , @FechaMov  ,@EstatusN, @Sucursal,@Usuario)    
                          
                      IF @OK IS NULL    
                        EXEC spMovInsertar @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @EjercicioAfectacion, @PeriodoAfectacion, @FechaMov, @Fecha,    
                                           NULL, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, @Observaciones, @Ok OUTPUT    
                    END    
                    ELSE    
                      SELECT @OK = 30100, @OKRef = D.Serie     
                        FROM Monedero M    
                        JOIN MonederoD D ON M.ID = D.ID    
                       WHERE M.ID = @ID    
                         AND NULLIF(D.Importe,0.0) IS NULL    
                  END    
                  ELSE    
                    SELECT @OK = 99001, @OKRef = T.Serie     
                      FROM Monedero        M    
                      JOIN MonederoD       D ON M.ID      = D.ID    
                      JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.SerieDestino = T.Serie    
                     WHERE M.ID = @ID    
                       AND T.Estatus IN ('ALTA','BAJA')    
                END    
                ELSE    
                  SELECT @OK = 99003, @OKRef = D.SerieDestino     
                    FROM Monedero        M    
                    JOIN MonederoD       D ON M.ID      = D.ID    
                    LEFT OUTER JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.SerieDestino = T.Serie    
                   WHERE M.ID = @ID    
                     AND T.Serie IS NULL    
              END    
              ELSE    
                SELECT @OK = 99001, @OKRef = T.Serie     
                  FROM Monedero        M    
                  JOIN MonederoD       D ON M.ID      = D.ID    
                  JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                 WHERE M.ID = @ID    
                   AND T.Estatus IN ('ALTA','BAJA')    
            END    
            ELSE    
              SELECT @OK = 60010    
          END    
        END    
      END          
    END    
        
    IF @Accion = 'CANCELAR'    
    BEGIN    
      IF @Estatus = 'CONCLUIDO'    
      BEGIN    
        SELECT @EstatusN = 'CANCELADO', @FechaMov = GETDATE()    
                                
        IF @Mov = 'Activacion Tarjeta' AND @Ok IS NULL    
        BEGIN            
          IF EXISTS(SELECT * FROM MonederoD WHERE ID = @ID)    
          BEGIN    
            IF EXISTS(SELECT *     
                          FROM Monedero M    
                          JOIN MonederoD D ON M.ID = D.ID    
                          JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                         WHERE M.ID = @ID    
                           AND T.Estatus IN ('ACTIVA'))    
            BEGIN    
              IF ISNULL((SELECT SUM(ISNULL(Saldo,0.0)) FROM SaldoPMon WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta IN (SELECT Serie FROM MonederoD WHERE ID = @ID )),0.0) = 0.0    
              BEGIN    
                UPDATE TarjetaMonedero     
                   SET TarjetaMonedero.Estatus           = 'ALTA',    
                       TarjetaMonedero.TieneMovimientos  = 1       ,    
                       TarjetaMonedero.UsuarioActivacion = NULL,    
                       TarjetaMonedero.FechaActivacion   = NULL    
                  FROM Monedero  M    
                  JOIN MonederoD D ON M.ID = D.ID    
                  JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                 WHERE M.ID = @ID                 
                    
                UPDATE Monedero    
                   SET UltimoCambio     = @FechaMov,    
                       Estatus          = @EstatusN,    
                       FechaCancelacion = @FechaMov      
                 WHERE ID = @ID    
                    
                IF NOT EXISTS(SELECT * FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID AND Estatus = @EstatusN)    
                  INSERT MovTiempo    
                         (Modulo , ID, FechaComenzo, FechaInicio, Estatus ,  Sucursal, Usuario)    
                  VALUES (@Modulo,@ID, @FechaMov   , @FechaMov  ,@EstatusN, @Sucursal,@Usuario)     
              END    
              ELSE    
                SELECT @OK = 99006, @OKRef = Cuenta     
                  FROM SaldoPMon     
                 WHERE Empresa = @Empresa     
                   AND Rama = @Rama     
                   AND Moneda = @Moneda     
                   AND Grupo = @Grupo     
                   AND Cuenta IN (SELECT Serie FROM MonederoD WHERE ID = @ID)    
                   AND ISNULL(Saldo,0.0) > 0.0    
            END    
            ELSE    
              SELECT @OK = 99005, @OKRef = T.Serie     
                FROM Monedero        M    
                JOIN MonederoD       D ON M.ID      = D.ID    
                JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
               WHERE M.ID = @ID    
                 AND T.Estatus NOT IN ('ACTIVA')    
          END    
          ELSE    
            SELECT @OK = 60010    
        END    
            
        IF @Mov = 'Baja Tarjeta' AND @Ok IS NULL    
        BEGIN      
          IF EXISTS(SELECT * FROM MonederoD WHERE ID = @ID)    
          BEGIN    
            IF EXISTS(SELECT *     
                            FROM Monedero M    
                            JOIN MonederoD D ON M.ID = D.ID    
                            JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                           WHERE M.ID = @ID    
                             AND T.Estatus IN ('BAJA'))    
            BEGIN    
              UPDATE TarjetaMonedero     
                 SET TarjetaMonedero.Estatus          = 'ACTIVA',    
                     TarjetaMonedero.TieneMovimientos = 1       ,    
                     TarjetaMonedero.FechaBaja        = NULL    
                FROM Monedero  M    
                JOIN MonederoD D ON M.ID = D.ID    
                JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
               WHERE M.ID = @ID                 
                  
              UPDATE Monedero    
                 SET UltimoCambio     = @FechaMov  ,    
                     Estatus          = @EstatusN,    
                     FechaCancelacion = @FechaMov      
               WHERE ID = @ID    
                  
              IF NOT EXISTS(SELECT * FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID AND Estatus = @EstatusN)    
                INSERT MovTiempo    
                       (Modulo , ID, FechaComenzo, FechaInicio, Estatus ,  Sucursal, Usuario)    
                VALUES (@Modulo,@ID, @FechaMov   , @FechaMov  ,@EstatusN, @Sucursal,@Usuario)     
            END    
            ELSE    
              SELECT @OK = 99007, @OKRef = T.Serie     
                FROM Monedero        M    
                JOIN MonederoD       D ON M.ID      = D.ID    
                JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
               WHERE M.ID = @ID    
                 AND T.Estatus NOT IN ('BAJA')    
          END    
          ELSE    
            SELECT @OK = 60010    
        END    
            
        IF @Mov = 'Aumento Saldo' AND @Ok IS NULL    
        BEGIN    
          IF EXISTS(SELECT * FROM MonederoD WHERE ID = @ID)    
          BEGIN    
            IF NOT EXISTS(SELECT *     
                            FROM Monedero M    
                            JOIN MonederoD D ON M.ID = D.ID    
                            JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                           WHERE M.ID = @ID    
                             AND T.Estatus IN ('ALTA','BAJA'))    
            BEGIN    
              IF NOT EXISTS(SELECT *     
                              FROM Monedero M    
                              JOIN MonederoD D ON M.ID = D.ID    
                             WHERE M.ID = @ID    
                               AND NULLIF(D.Importe,0.0) IS NULL)    
              BEGIN    
                SELECT @RenglonID = 0    
                    
                DECLARE crAumentarSaldoME CURSOR LOCAL FOR    
                 SELECT C.Mov, C.MovID, C.FechaEmision, YEAR(C.FechaEmision), MONTH(C.FechaEmision), C.Mov, C.MovID, ISNULL(C.Uen,''), C.Referencia, C.Observaciones,     
                        D.Renglon, D.RenglonSub, D.Serie, ISNULL(D.Importe,0.0)    
                   FROM Monedero  C    
                   JOIN MonederoD D ON C.ID = D.ID    
                  WHERE C.ID = @ID    
                  ORDER BY C.ID, D.Renglon    
                    
                OPEN crAumentarSaldoME    
                FETCH NEXT FROM crAumentarSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                       @Renglon, @RenglonSub, @Cuenta, @Cargo    
                WHILE @@FETCH_STATUS <> -1 AND @Cuenta IS NOT NULL AND @OK IS NULL    
                BEGIN    
                  IF @@FETCH_STATUS <> -2    
                  BEGIN    
                    SELECT @RenglonID = @RenglonID + 1, @ImporteMov = ISNULL(@ImporteMov,0.0) + ISNULL(@Cargo,0.0)    
                        
                    IF ISNULL((SELECT SUM(ISNULL(Saldo,0.0)) FROM SaldoPMon WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND UEN = ISNULL(NULLIF(@UEN,''),'0')),0.0)  > @Cargo    
                      EXEC spSaldoPMon 0, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, @Abono, @Cargo, @Fecha,     
                           @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Aplica, @AplicaID,     
                           @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN    
                    ELSE    
                      SELECT @OK = 99002, @OKRef = @Cuenta    
                  END    
                  FETCH NEXT FROM crAumentarSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                         @Renglon, @RenglonSub, @Cuenta, @Cargo    
                END    
                CLOSE crAumentarSaldoME    
                DEALLOCATE crAumentarSaldoME    
                    
                IF @OK IS NULL    
                BEGIN    
                  UPDATE Monedero    
                     SET UltimoCambio     = @FechaMov  ,    
                         Estatus          = @EstatusN,    
                         FechaCancelacion = @FechaMov      
                   WHERE ID = @ID    
                       
                  IF NOT EXISTS(SELECT * FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID AND Estatus = @EstatusN)    
                    INSERT MovTiempo    
                           (Modulo , ID, FechaComenzo, FechaInicio, Estatus ,  Sucursal, Usuario)    
                    VALUES (@Modulo,@ID, @FechaMov   , @FechaMov  ,@EstatusN, @Sucursal,@Usuario)    
                END    
              END    
              ELSE    
                SELECT @OK = 30100, @OKRef = D.Serie     
                  FROM Monedero M    
                  JOIN MonederoD D ON M.ID = D.ID    
                 WHERE M.ID = @ID    
                   AND NULLIF(D.Importe,0.0) IS NULL    
            END    
            ELSE    
              SELECT @OK = 99001, @OKRef = T.Serie     
                FROM Monedero        M    
                JOIN MonederoD       D ON M.ID      = D.ID    
                JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
               WHERE M.ID = @ID    
                 AND T.Estatus IN ('ALTA','BAJA')    
          END    
          ELSE    
            SELECT @OK = 60010    
        END    
            
        IF @Mov = 'Disminucion Saldo' AND @Ok IS NULL    
        BEGIN    
          IF EXISTS(SELECT * FROM MonederoD WHERE ID = @ID)    
          BEGIN    
            IF NOT EXISTS(SELECT *     
                            FROM Monedero M    
                            JOIN MonederoD D ON M.ID = D.ID    
                            JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                           WHERE M.ID = @ID    
                             AND T.Estatus IN ('ALTA','BAJA'))    
            BEGIN    
              IF NOT EXISTS(SELECT *     
                              FROM Monedero M    
                              JOIN MonederoD D ON M.ID = D.ID    
                             WHERE M.ID = @ID    
                               AND NULLIF(D.Importe,0.0) IS NULL)    
              BEGIN    
                SELECT @RenglonID = 0    
                    
                DECLARE crDisminuirSaldoME CURSOR LOCAL FOR    
                 SELECT C.Mov, C.MovID, C.FechaEmision, YEAR(C.FechaEmision), MONTH(C.FechaEmision), C.Mov, C.MovID, ISNULL(C.Uen,''), C.Referencia, C.Observaciones,    
                        D.Renglon, D.RenglonSub, D.Serie, ISNULL(D.Importe,0.0)    
                   FROM Monedero  C    
                   JOIN MonederoD D ON C.ID = D.ID    
                  WHERE C.ID = @ID    
                  ORDER BY C.ID, D.Renglon    
                      
                OPEN crDisminuirSaldoME    
                FETCH NEXT FROM crDisminuirSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                        @Renglon, @RenglonSub, @Cuenta, @Abono    
                WHILE @@FETCH_STATUS <> -1 AND @Cuenta IS NOT NULL AND @OK IS NULL    
                BEGIN    
                  IF @@FETCH_STATUS <> -2    
                  BEGIN    
                    SELECT @RenglonID = @RenglonID + 1, @ImporteMov = ISNULL(@ImporteMov,0.0) + ISNULL(@Abono,0.0)    
                        
                    EXEC spSaldoPMon 0, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, @Abono, @Cargo, @Fecha,     
                         @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Aplica, @AplicaID,     
                         @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN    
                  END    
                  FETCH NEXT FROM crDisminuirSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                          @Renglon, @RenglonSub, @Cuenta, @Abono    
                END    
                CLOSE crDisminuirSaldoME    
                DEALLOCATE crDisminuirSaldoME    
                    
                UPDATE Monedero    
                   SET UltimoCambio     = @FechaMov  ,    
                       Estatus          = @EstatusN,    
                       FechaCancelacion = @FechaMov      
                 WHERE ID = @ID    
                     
                IF NOT EXISTS(SELECT * FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID AND Estatus = @EstatusN)    
                  INSERT MovTiempo    
                         (Modulo , ID, FechaComenzo, FechaInicio, Estatus ,  Sucursal, Usuario)    
                  VALUES (@Modulo,@ID, @FechaMov   , @FechaMov  ,@EstatusN, @Sucursal,@Usuario)    
                      
              END    
              ELSE    
                SELECT @OK = 30100, @OKRef = D.Serie     
                  FROM Monedero M    
                  JOIN MonederoD D ON M.ID = D.ID    
                 WHERE M.ID = @ID    
                   AND NULLIF(D.Importe,0.0) IS NULL    
            END    
            ELSE    
              SELECT @OK = 99001, @OKRef = T.Serie     
                FROM Monedero        M    
                JOIN MonederoD       D ON M.ID      = D.ID    
                JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
               WHERE M.ID = @ID    
                 AND T.Estatus IN ('ALTA','BAJA')    
          END    
          ELSE    
            SELECT @OK = 60010    
        END    
            
        IF @Mov = 'Traspaso Saldo' AND @Ok IS NULL    
        BEGIN    
          IF EXISTS(SELECT * FROM MonederoD WHERE ID = @ID)    
          BEGIN    
            IF NOT EXISTS(SELECT *     
                            FROM Monedero M    
                            JOIN MonederoD D ON M.ID = D.ID    
                            JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                           WHERE M.ID = @ID    
                             AND T.Estatus IN ('ALTA','BAJA'))    
            BEGIN    
              IF NOT EXISTS(SELECT *     
                              FROM Monedero M    
                              JOIN MonederoD D ON M.ID = D.ID    
                              LEFT OUTER JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.SerieDestino = T.Serie    
                             WHERE M.ID = @ID    
                               AND T.Serie IS NULL)    
              BEGIN    
                IF NOT EXISTS(SELECT *     
                                FROM Monedero M    
                                JOIN MonederoD D ON M.ID = D.ID    
                                JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.SerieDestino = T.Serie    
                               WHERE M.ID = @ID    
                                 AND T.Estatus IN ('ALTA','BAJA'))    
                BEGIN    
                  IF NOT EXISTS(SELECT *     
                                  FROM Monedero M    
                                  JOIN MonederoD D ON M.ID = D.ID    
                                 WHERE M.ID = @ID    
                                   AND NULLIF(D.Importe,0.0) IS NULL)    
                  BEGIN    
                    SELECT @RenglonID = 0    
                        
                    DECLARE crTraspasarSaldoME CURSOR LOCAL FOR    
                     SELECT C.Mov, C.MovID, C.FechaEmision, YEAR(C.FechaEmision), MONTH(C.FechaEmision), C.Mov, C.MovID, ISNULL(C.Uen,''), C.Referencia, C.Observaciones,     
                            D.Renglon, D.RenglonSub, D.Serie, D.SerieDestino, ISNULL(D.Importe,0.0), ISNULL(D.Importe,0.0)    
                       FROM Monedero  C    
                       JOIN MonederoD D ON C.ID = D.ID    
                      WHERE C.ID = @ID    
                      ORDER BY C.ID, D.Renglon    
                          
                    OPEN crTraspasarSaldoME    
                    FETCH NEXT FROM crTraspasarSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                            @Renglon, @RenglonSub, @Cuenta, @CuentaDestino, @Cargo, @Abono    
                    WHILE @@FETCH_STATUS <> -1 AND @Cuenta IS NOT NULL AND @OK IS NULL    
                    BEGIN    
                      IF @@FETCH_STATUS <> -2    
                      BEGIN    
                        SELECT @RenglonID = @RenglonID + 1, @ImporteMov = ISNULL(@ImporteMov,0.0) + ISNULL(@Abono,0.0)    
                            
                        IF (SELECT SUM(ISNULL(Saldo,0.0)) FROM SaldoPMon WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @CuentaDestino AND UEN = ISNULL(NULLIF(@UEN,''),'0')) >= @Abono    
                        BEGIN    
                          EXEC spSaldoPMon 0, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, @Cargo, NULL, @Fecha,     
                                 @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Aplica, @AplicaID,     
                                 @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN    
                              
                          IF @OK IS NULL    
                            EXEC spSaldoPMon 0, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @CuentaDestino, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, NULL, @Abono, @Fecha,     
                                 @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Aplica, @AplicaID,     
                                 @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN    
                                
                        END    
                        ELSE    
                          SELECT @OK = 99002, @OKRef = @CuentaDestino    
                      END    
                      FETCH NEXT FROM crTraspasarSaldoME INTO @Mov, @MovID, @Fecha, @EjercicioAfectacion, @PeriodoAfectacion, @Aplica, @AplicaID, @UEN, @Referencia, @Observaciones,     
                                                              @Renglon, @RenglonSub, @Cuenta, @CuentaDestino, @Cargo, @Abono    
                    END    
                    CLOSE crTraspasarSaldoME    
                    DEALLOCATE crTraspasarSaldoME    
        
                    IF @OK IS NULL    
                    BEGIN    
                      UPDATE Monedero    
                         SET UltimoCambio     = @FechaMov  ,    
                             Estatus          = @EstatusN,    
                             FechaCancelacion = @FechaMov      
                       WHERE ID = @ID    
                           
                      IF NOT EXISTS(SELECT * FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID AND Estatus = @EstatusN)    
                        INSERT MovTiempo    
                               (Modulo , ID, FechaComenzo, FechaInicio, Estatus ,  Sucursal, Usuario)    
                        VALUES (@Modulo,@ID, @FechaMov   , @FechaMov  ,@EstatusN, @Sucursal,@Usuario)    
                    END    
                  END    
                  ELSE    
                    SELECT @OK = 30100, @OKRef = D.Serie     
                      FROM Monedero M    
                      JOIN MonederoD D ON M.ID = D.ID    
                     WHERE M.ID = @ID    
                       AND NULLIF(D.Importe,0.0) IS NULL    
                END    
                ELSE    
                  SELECT @OK = 99001, @OKRef = T.Serie     
                    FROM Monedero        M    
                    JOIN MonederoD       D ON M.ID      = D.ID    
                    JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.SerieDestino = T.Serie    
                   WHERE M.ID = @ID    
                     AND T.Estatus IN ('ALTA','BAJA')    
              END    
              ELSE    
                SELECT @OK = 99003, @OKRef = D.SerieDestino     
                  FROM Monedero        M    
                  JOIN MonederoD       D ON M.ID      = D.ID    
                  LEFT OUTER JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.SerieDestino = T.Serie    
                 WHERE M.ID = @ID    
                   AND T.Serie IS NULL    
            END    
            ELSE    
              SELECT @OK = 99001, @OKRef = T.Serie     
                FROM Monedero        M    
                JOIN MonederoD       D ON M.ID      = D.ID    
                JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
               WHERE M.ID = @ID    
                 AND T.Estatus IN ('ALTA','BAJA')    
          END    
          ELSE    
            SELECT @OK = 60010    
        END    
      END          
    END    
  END    
      
  IF @OK IS NULL    
  BEGIN    
    COMMIT TRANSACTION   
	SELECT NULL    
  END    
  ELSE    
  BEGIN    
    ROLLBACK TRANSACTION
	SELECT Descripcion + ' <BR><BR>' + ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok    
  END    
      
  RETURN    
END 
GO
 
/************************************* xpVerificarRedime **************************************/
if exists(select * from sysobjects where id = object_id('dbo.xpVerificarRedime') and type = 'P')
drop procedure dbo.xpVerificarRedime
GO
    
CREATE PROCEDURE dbo.xpVerificarRedime     
          @ID           int      
AS      
BEGIN      
  DECLARE      
          @UEN          int        ,          
          @NombreUEN    varchar(100),          
          @CanalNombre  varchar(50),          
          @Renglon      float      ,          
          @Articulo     varchar(20),          
          @Bandera      bit        ,          
          @Puntos       float      ,          
          @Estatus      varchar(15),          
          @MovTipo      varchar(20),          
          @Redime       bit           
                
      
  SELECT @Bandera = 0    
      
  SELECT @UEN = V.UEN, @NombreUEN = U.Nombre, @Estatus = V.Estatus, @Redime = V.RedimePuntos, @MovTipo = M.Clave, @CanalNombre = U.Nombre        
    FROM Venta          V          
    JOIN MovTipo        M ON M.Modulo = 'VTAS' AND V.Mov = M.Mov          
    LEFT OUTER JOIN Uen U ON V.UEN = U.UEN         
   WHERE V.ID = @ID     
    
  IF @Redime = 1  
    SELECT @Bandera = 1  
      
  IF @Redime = 1 AND @Estatus = 'SINAFECTAR' --AND EXISTS(SELECT * FROM TablaRangoST T JOIN TablaRangoSTD D ON T.TablaRangoST = D.TablaRangoST WHERE UPPER(T.TablaRangoST) = 'SIN MONEDERO' AND D.NumeroD = @UEN AND D.Nombre = @CanalNombre)    
    SELECT @Bandera = 0  

  SELECT @Bandera      
           
END      
GO
--exec spAfectar 'VTAS', 2546, 'AFECTAR', 'Todo', NULL, 'INTELISIS', @Estacion=1
/************************************** xpVerificarMovMonedero **************************************/
if exists (select * from sysobjects where id = object_id('dbo.xpVerificarMovMonedero') and type = 'P') 
drop procedure dbo.xpVerificarMovMonedero
GO

CREATE PROCEDURE dbo.xpVerificarMovMonedero           
          @ID           int,
		  @Bandera      INT OUTPUT           
AS          
BEGIN          
  DECLARE          
          @UEN				int        ,          
          @NombreUEN		varchar(100),          
          @CanalNombre		varchar(50),          
          @Renglon			float      ,          
          @Articulo			varchar(20),                   
          @Puntos			float      ,          
          @Estatus			varchar(15),          
          @MovTipo			varchar(20),          
          @Redime			bit		   ,
		  @AplicaMonedero	varchar(20),
		  @AplicaOfertas	bit
  
  -- CON LA BANDERA ACTIVADA ENTRA LA FUNCIONALIDAD DEL MONEDERO    
  SET @Bandera = 0

	SELECT @UEN = V.UEN, @NombreUEN = U.Nombre, @Estatus = V.Estatus, @Redime = V.RedimePuntos, @MovTipo = M.Clave, @AplicaMonedero = Monedero, @AplicaOfertas = AplicarOfertas
	  FROM Venta          V          
	  JOIN MovTipo        M ON M.Modulo = 'VTAS' AND V.Mov = M.Mov          
	  LEFT OUTER JOIN Uen U ON V.UEN = U.UEN                  
	 WHERE V.ID = @ID          
   

	IF EXISTS(SELECT * FROM SerieTarjetaMovM WHERE Modulo = 'VTAS' AND ID = @ID)  
		SET @Bandera  = 1
	--IF @Redime = 1 BEGIN SELECT @Bandera  = 2  END

	IF @Bandera = 0 AND @AplicaOfertas = 1
		SET @Bandera  = 1
             
END   
GO


/************************************** spBorrarMonederoMov **************************************/
if exists (select * from sysobjects where id = object_id('dbo.spBorrarMonederoMov') and type = 'P') 
drop procedure dbo.spBorrarMonederoMov
GO

CREATE PROCEDURE dbo.spBorrarMonederoMov
          @ID           int
AS
BEGIN

 
  DELETE FROM SerieTarjetaMovM WHERE Modulo = 'VTAS' AND ID = @ID
  --UPDATE VentaD SET Puntos = NULL WHERE ID = @ID
  
  SELECT 'Monedero Electrónico Eliminado'
     
  RETURN
END
GO
--spAfectar 'VTAS', 2591, 'AFECTAR', 'Todo', NULL, 'INTELISIS', @Estacion=1
/************************************** xpMovFinalMonedero **************************************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovFinalMonedero') and type = 'P') 
drop procedure dbo.xpMovFinalMonedero
GO

CREATE PROCEDURE dbo.xpMovFinalMonedero  
          @Empresa              char   ( 5),
          @Sucursal             int        ,
          @Modulo               char   ( 5),
          @ID                   int        ,
          @Estatus              char   (15),
          @EstatusNuevo         char   (15),
          @Usuario              char   (10),
          @FechaEmision         datetime   ,
          @FechaRegistro        datetime   ,
          @Mov                  char   (20),
          @MovID                varchar(20),
          @MovTipo              char   (20),
          @Ok                   int          OUTPUT,  
          @OkRef                varchar(255) OUTPUT  
AS 
BEGIN
    DECLARE
          @Accion               varchar(20),
          @Moneda               varchar(10),
          @TipoCambio           float      ,
          @UEN                  int        ,
          @Puntos               money      ,
          @SaldoPMonuntos       money      ,
          @DiferenciaPuntos     money      ,
          @Rama                 varchar( 5),
          @Cuenta               varchar(50),
          @SubCuenta            varchar(50),
          @Grupo                varchar(10),
          @EjercicioAfectacion  int        ,
          @PeriodoAfectacion    int        ,
          @AcumulaSinDetalles   bit        ,
          @AcumulaEnLinea       bit        ,
          @GeneraAuxiliar       bit        ,
          @GeneraSaldo	        bit        ,
          @Conciliar            bit        ,
          @EsResultados         bit        ,
          @Renglon              float      ,
          @RenglonSub           int        ,
          @RenglonID            int        ,
		  @Bandera				int			,
		  @CobroAutomatico		bit



  SELECT @CobroAutomatico = CobroAutomatico FROM MonederoCfg WHERE Empresa = @Empresa

  IF @Modulo = 'VTAS' AND @MovTipo IN ('VTAS.N', 'VTAS.D','VTAS.F')
  BEGIN
    SELECT @Rama = 'MONEL', @SubCuenta = '', @Grupo = 'ME', @AcumulaSinDetalles = 1, @AcumulaEnLinea = 1, @GeneraAuxiliar = 1, @GeneraSaldo = 1, @Conciliar = 0, @EsResultados = 0
    
    IF @MovTipo IN ('VTAS.N','VTAS.F') -- NOTA
    BEGIN
      IF @EstatusNuevo IN ('PROCESAR','CONCLUIDO') 
      BEGIN
        SELECT @Accion =  'AFECTAR'
		EXEC  xpVerificarMovMonedero @ID , @Bandera OUTPUT

		IF @Bandera = 1 -- GENERA PUNTOS
        BEGIN
          SELECT @Moneda = V.Moneda, @TipoCambio = V.TipoCambio, @UEN = V.Uen, @EjercicioAfectacion = V.Ejercicio, @PeriodoAfectacion = V.Periodo, @Cuenta = NULLIF(V.Monedero,''), @Puntos = SUM(ISNULL(D.Puntos,0.0))
            FROM Venta               V
            JOIN VentaD              D ON V.ID = D.ID
           WHERE V.ID = @ID
           GROUP BY V.Moneda, V.TipoCambio, V.Uen, V.Ejercicio, V.Periodo, V.Monedero
		--  IF ISNULL(@Puntos,0.0) < 0.0 SELECT  @Puntos =   @Puntos*-1 ---HAY QUE IDENTIFICAR K BIENE DEL POS

          IF @Cuenta IS NOT NULL AND ISNULL(@Puntos,0.0) > 0.0
          BEGIN           
            IF EXISTS(SELECT * 
                            FROM TarjetaMonedero T
                            WHERE T.Serie = @Cuenta AND T.Estatus IN ('ACTIVA'))
            BEGIN
		
              EXEC spSaldoPMon @Sucursal, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID,NULL,@Puntos, @FechaEmision, 
                            @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Mov, @MovID, 
                            @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN

            END
            ELSE
              SELECT @OK = 99005, @OKRef = @Cuenta
          END
        END
      END
      
      IF @EstatusNuevo = 'CANCELADO'
      BEGIN
        SELECT @Accion =  'CANCELAR'
	     EXEC  xpVerificarMovMonedero @ID , @Bandera OUTPUT   -- GENERA PUNTOS 
		IF @Bandera = 1
        BEGIN
          SELECT @Moneda = V.Moneda, @TipoCambio = V.TipoCambio, @UEN = V.Uen, @EjercicioAfectacion = V.Ejercicio, @PeriodoAfectacion = V.Periodo, @Cuenta = NULLIF(V.Monedero,''), @Puntos = SUM(ISNULL(D.Puntos,0.0))
            FROM Venta               V
            JOIN VentaD              D ON V.ID = D.ID
           WHERE V.ID = @ID
           GROUP BY V.Moneda, V.TipoCambio, V.Uen, V.Ejercicio, V.Periodo, V.Monedero
          
          IF @Cuenta IS NOT NULL AND ISNULL(@Puntos,0.0) > 0.0
          BEGIN           
            IF EXISTS(SELECT * 
                            FROM TarjetaMonedero T
                            WHERE T.Serie = @Cuenta AND T.Estatus IN ('ACTIVA'))
            BEGIN
              -- VALIDAR SI EL SALDO AUN LO CUBRE EL MONEDERO O SI NO RESTAR LO QUE SE PUEDA RESTAR Y GENERAR MOTA DE CARGO
	
              SELECT @SaldoPMonuntos = SUM(ISNULL(Saldo,0.0)) 
                FROM SaldoPMon 
               WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta --AND UEN = ISNULL(NULLIF(@UEN,''),'0')
  
              IF @SaldoPMonuntos >= @Puntos
              BEGIN
                EXEC spSaldoPMon @Sucursal, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, @Puntos, NULL, @FechaEmision, 
                              @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Mov, @MovID, 
                              @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN
                
              END
              ELSE
              BEGIN
                SELECT @DiferenciaPuntos = @Puntos - @SaldoPMonuntos       
                EXEC spSaldoPMon @Sucursal, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID,  @SaldoPMonuntos, NULL, @FechaEmision, 
                              @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Mov, @MovID, 
                              @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN
                 
         
              END
            END
          END
        END
 
      END
    END
    
    IF @MovTipo IN ('VTAS.D') -- DEVOLUCION
    BEGIN
      IF @EstatusNuevo = 'CONCLUIDO' 
      BEGIN
        SELECT @Accion =  'AFECTAR'
  --      SELECT 'DEVOLUCION'
        IF EXISTS(SELECT * FROM SerieTarjetaMovM WHERE Modulo = @Modulo AND ID = @ID)-- REDIMIR PUNTOS
        BEGIN
          SELECT @Moneda = V.Moneda, @TipoCambio = V.TipoCambio, @UEN = V.Uen, @EjercicioAfectacion = V.Ejercicio, @PeriodoAfectacion = V.Periodo, @Cuenta = NULLIF(T.Serie,''),
		   @Puntos = ISNULL(SUM(D.Puntos),0.0)
            FROM Venta               V
            JOIN VentaD              D ON V.ID = D.ID
            JOIN SerieTarjetaMovM T ON V.ID = T.ID
           WHERE V.ID = @ID
		   GROUP BY V.Moneda, V.TipoCambio, V.Uen, V.Ejercicio,  V.Periodo, T.Serie
          
          IF @Cuenta IS NOT NULL AND ISNULL(@Puntos,0.0) > 0.0
          BEGIN           
            IF EXISTS(SELECT * 
                            FROM TarjetaMonedero T
                            WHERE T.Serie = @Cuenta AND T.Estatus IN ('ACTIVA'))
            BEGIN
              EXEC spSaldoPMon @Sucursal, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, @Puntos, NULL, @FechaEmision, 
                            @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Mov, @MovID, 
                            @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN


			  IF @CobroAutomatico = 1
				BEGIN
				 EXEC spCobroAutomaticoMonedero @ID, @Puntos
				END   
            END
          END
        END
      END
      
    END
  END
    
  RETURN  
END
GO

/************************ spMonederoFormaAnexa *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spMonederoFormaAnexa') AND type = 'P') DROP PROCEDURE dbo.spMonederoFormaAnexa
GO             
CREATE PROCEDURE spMonederoFormaAnexa
	@Codigo		varchar(50),
	@ID			Int,
	@Empresa	varchar(5)
	
--//WITH ENCRYPTION	     
AS 
BEGIN	     
	DECLARE 
	@Redime		Bit,
	@Forma		Varchar(50),
	@Ok			Int
	  

	SELECT @Forma = NULL

	--SELECT @Redime = RedimePuntos FROM Venta WHERE ID = @ID
	SET @Redime = 1
	IF @Redime = 1
	  BEGIN
 		SELECT @Forma = Objeto FROM FormaCobroMon  
		WHERE Empresa = @Empresa AND FormaCobro = @Codigo
	  END
		 
    
	SELECT @Forma
END
GO




/************************ spPOSMonederoFormaAnexa *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spPOSMonederoFormaAnexa') AND type = 'P') DROP PROCEDURE dbo.spPOSMonederoFormaAnexa
GO             
CREATE PROCEDURE spPOSMonederoFormaAnexa
	@Codigo		varchar(50),
	@ID			varchar(36),
	@Empresa	varchar(5)
	
--//WITH ENCRYPTION	     
AS 
BEGIN	     
	DECLARE 
	@Redime		Bit,
	@Forma		Varchar(50),
	@Ok			Int,
	@FormaPago	varchar(50)

	  

	SELECT @FormaPago = FormaPago
      FROM CB
	  WHERE CB.Codigo = @Codigo
    
	SELECT @Forma = NULL

	SELECT @Forma = NULLIF(ObjetoPOS,'') 
	  FROM FormaCobroMon  
	 WHERE Empresa = @Empresa 
	   AND FormaCobro = @FormaPago

	SELECT @Forma
END
GO

/************************************** spMonederoCBRefimir **************************************/
if exists (select * from sysobjects where id = object_id('dbo.spMonederoCBRefimir') and type = 'P') 
drop procedure dbo.spMonederoCBRefimir
GO

CREATE PROCEDURE dbo.spMonederoCBRefimir  
          @Empresa              char( 5),
          @Sucursal             int,
          @Modulo               char( 5),
          @ID                   int,
		  @MonederoCBSerie		varchar(20),
		  @MonederoCBImporte	varchar(20),
		  @Posicion				int
 
AS 
BEGIN
    DECLARE
          @Accion               varchar(20),
          @Moneda               varchar(10),
          @TipoCambio           float,
          @UEN                  int,
          @Puntos               money,
          @SaldoPMonuntos       money,
          @DiferenciaPuntos     money,
          @Rama                 varchar( 5),
          @Cuenta               varchar(50),
          @SubCuenta            varchar(50),
          @Grupo                varchar(10),
          @EjercicioAfectacion  int,
          @PeriodoAfectacion    int,
          @AcumulaSinDetalles   bit,
          @AcumulaEnLinea       bit,
          @GeneraAuxiliar       bit,
          @GeneraSaldo	        bit,
          @Conciliar            bit,
          @EsResultados         bit,
          @Renglon              float,
          @RenglonSub           int,
          @RenglonID            int,
		  @Bandera				int,
		  @Estatus              varchar(15),
		  @MovTipo              varchar(20),
          @EstatusNuevo         varchar(15),
          @Usuario              varchar(10),
          @FechaEmision         datetime,
          @FechaRegistro        datetime,
          @Mov                  varchar(20),
          @MovID                varchar(20),
          @Ok                   int,
          @OkRef                varchar(255),
		  @Mensaje				varchar(max)

  
	SELECT @Rama = 'MONEL', 
		   @SubCuenta = '', 
		   @Grupo = 'ME', 
		   @AcumulaSinDetalles = 1, 
		   @AcumulaEnLinea = 1,
		   @GeneraAuxiliar = 1,
		   @GeneraSaldo = 1,
		   @Conciliar = 0, 
		   @EsResultados = 0


  BEGIN TRAN 
  IF @Modulo = 'VTAS'
  BEGIN
    INSERT INTO SerieTarjetaMovM (Empresa,	Modulo,	 ID,  Serie,			Importe,			Sucursal,	Posicion)
	VALUES						 (@Empresa, @Modulo, @ID, @MonederoCBSerie, @MonederoCBImporte, @Sucursal, @Posicion)

	SELECT @Moneda				= V.Moneda, 
		   @TipoCambio			= V.TipoCambio, 
		   @UEN					= V.Uen,
		   @EjercicioAfectacion = V.Ejercicio,
		   @PeriodoAfectacion	= V.Periodo,
		   @Estatus				= V.Estatus,
		   @MovTipo				= MT.Clave,
		   @Usuario				= V.Usuario,
		   @FechaEmision		= V.FechaEmision,
		   @FechaRegistro		= ISNULL(V.FechaRegistro,GETDATE()),
		   @Mov					= v.Mov,
		   @MovID				= v.MovID
	  FROM Venta               V
	  JOIN MovTipo MT ON V.Mov = MT.Mov 
	   AND MT. Modulo = 'VTAS'
	 WHERE V.ID = @ID
  
	IF @Estatus = 'SINAFECTAR' AND @MovTipo = 'VTAS.N'	
		SET @EstatusNuevo = 'PROCESAR' 

	IF @Estatus = 'SINAFECTAR' AND @MovTipo = 'VTAS.F'	
	SET @EstatusNuevo = 'CONCLUIDO'     
    
    IF @MovTipo IN ('VTAS.N', 'VTAS.F') 
    BEGIN
      IF @EstatusNuevo IN ('PROCESAR', 'CONCLUIDO')
      BEGIN
        SELECT @Accion =  'AFECTAR'
        
		EXEC  xpVerificarMovMonedero @ID , @Bandera OUTPUT

        IF EXISTS(SELECT * FROM SerieTarjetaMovM WHERE Modulo = @Modulo AND ID = @ID) --REDIMIR PUNTOS
        BEGIN
		-- SELECT  'REDIME'
		   SELECT @Cuenta = NULLIF(Serie,''), 
				  @Puntos = ISNULL(Importe,0.0) 
			 FROM SerieTarjetaMovM 
			WHERE Modulo = @Modulo 
			  AND ID = @ID
			  AND Posicion = @Posicion

          IF @Cuenta IS NOT NULL AND ISNULL(@Puntos,0.0) > 0.0
          BEGIN   
            IF EXISTS(SELECT * 
                            FROM TarjetaMonedero T
                            WHERE T.Serie = @Cuenta AND T.Estatus IN ('ACTIVA'))
            BEGIn
              SELECT @SaldoPMonuntos = SUM(ISNULL(Saldo,0.0)) 
                FROM SaldoPMon 
               WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta --AND UEN = ISNULL(NULLIF(@UEN,''),'0')
   

              --IF @SaldoPMonuntos >= @Puntos
              --BEGIN
			    
                EXEC spSaldoPMon @Sucursal, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, @Puntos, NULL, @FechaEmision, 
                              @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Mov, @MovID, 
                              @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN
                
              --END
              --ELSE
              --BEGIN
              --  EXEC spSaldoPMon @Sucursal, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, NULL, @SaldoPMonuntos, @FechaEmision, 
              --                @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Mov, @MovID, 
              --                @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN
              --  
              --END
			  IF @OK IS NULL
			  BEGIN
				IF @Posicion = 1	UPDATE VentaCobro SET Importe1 = @Puntos, TCProcesado1 = 1, Referencia1 = 'APROBADA' WHERE ID = @ID
				IF @Posicion = 2	UPDATE VentaCobro SET Importe2 = @Puntos, TCProcesado2 = 1, Referencia2 = 'APROBADA' WHERE ID = @ID
				IF @Posicion = 3	UPDATE VentaCobro SET Importe3 = @Puntos, TCProcesado3 = 1, Referencia3 = 'APROBADA' WHERE ID = @ID
				IF @Posicion = 4	UPDATE VentaCobro SET Importe4 = @Puntos, TCProcesado4 = 1, Referencia4 = 'APROBADA' WHERE ID = @ID
				IF @Posicion = 5	UPDATE VentaCobro SET Importe5 = @Puntos, TCProcesado5 = 1, Referencia5 = 'APROBADA' WHERE ID = @ID
				
			  END 
            END
            ELSE
              SELECT @OK = 99005, @OKRef = 'La Cuenta ' + @Cuenta + 'no Existe o no está Activa'
          END
        END
      END
    END
  END
  --SELECT @OK
  IF @OK IS NULL
	COMMIT TRAN 
  ELSE
  BEGIN
	ROLLBACK TRAN
	SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok 
	SELECT @Mensaje = @Mensaje + @OkRef
  END
  SELECT @Mensaje 
 
END
GO


/************************ spRepSaldoMonederoCB *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spRepSaldoMonederoCB') AND type = 'P') DROP PROCEDURE dbo.spRepSaldoMonederoCB
GO             
CREATE PROCEDURE spRepSaldoMonederoCB
	@MonederoCB	varchar(20),
	@Empresa	varchar(5)
	
--//WITH ENCRYPTION	     
AS 
BEGIN	     


	SELECT 'MONEDEROCB'	= Cuenta,
		   'SALDOMCB'	= ISNULL(Saldo,0), 
		   'MONEDAMCB'	= Moneda 
	  FROM SaldoPMon 
	 WHERE Empresa = @Empresa 
	   AND Rama = 'MONEL' 
	   AND Grupo = 'ME'
	   AND Cuenta = @MonederoCB
END
GO

/************** xpEstadoMonedero *************/
if exists (select * from sysobjects where id = object_id('dbo.xpEstadoMonedero') and type = 'P') drop procedure dbo.xpEstadoMonedero
GO
CREATE PROCEDURE xpEstadoMonedero
					@Cuenta		Varchar(20),
					@Empresa	Varchar(5)
AS BEGIN
	

	SELECT Mov, MovID, Modulo, Moneda, Empresa, Sucursal, Ejercicio, Periodo, Cargo, Abono, Cuenta, Fecha   FROM AuxiliarPMon
	WHERE Cuenta = @Cuenta AND Empresa = @Empresa 

RETURN 
END
GO

/************** xpEstadoMonederoPos *************/
if exists (select * from sysobjects where id = object_id('dbo.xpEstadoMonederoPos') and type = 'P') drop procedure dbo.xpEstadoMonederoPos
GO
CREATE PROCEDURE xpEstadoMonederoPos
					@Cuenta		Varchar(20),
					@Empresa	Varchar(5)
					
AS BEGIN

	SELECT Mov, MovID, Modulo, Moneda, Empresa, Sucursal, Ejercicio, Periodo, Cargo, Abono,Cuenta, Fecha  FROM PosAuxiliarPMon
	WHERE Cuenta = @Cuenta AND Empresa = @Empresa 
RETURN 
END
GO

/************** xpSaldoPos*************/
if exists (select * from sysobjects where id = object_id('dbo.xpSaldoPos') and type = 'P') drop procedure dbo.xpSaldoPos
GO
CREATE PROCEDURE xpSaldoPos
					@Cuenta		Varchar(20),
					@Empresa	Varchar(5)
					
AS BEGIN

	SELECT Cuenta, Moneda,Saldo FROM PosSaldoPMon
	WHERE Cuenta = @Cuenta AND Empresa = @Empresa 
RETURN 
END
GO

/************************ spTarjetaMonederoVerificar *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spTarjetaMonederoVerificar') AND type = 'P') DROP PROCEDURE dbo.spTarjetaMonederoVerificar
GO             
CREATE PROCEDURE spTarjetaMonederoVerificar
					@MonederoCB	varchar(20),
					@Empresa	varchar(5)			  
AS BEGIN
	DECLARE @Existe		bit
	SET @Existe = 0

	IF EXISTS (SELECT * FROM TarjetaMonedero WHERE Empresa = @Empresa AND Serie = @MonederoCB)
		SET @Existe = 1

	SELECT @Existe

END
GO


/************************ spPOSMonederoSaldoEdoCta *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spPOSMonederoSaldoEdoCta') AND type = 'P') DROP PROCEDURE dbo.spPOSMonederoSaldoEdoCta
GO             
CREATE PROCEDURE spPOSMonederoSaldoEdoCta
				@Empresa		varchar(5),
				@Monedero		varchar(20),
				@Usuario		varchar(10),
				@Estacion		int,
				@Sucursal		int,
				@QueEs			varchar(20)
AS BEGIN
	DECLARE	@Ok			int,
			@OkRef		varchar(255),
			@Mensaje	varchar(255)

	SET @Ok = NULL
	SET @OkRef = NULL
	SET @Mensaje = NULL

	EXEC spPOSWSSolTarjetaMonedero @Empresa, @Monedero ,@Usuario, @Estacion, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

	IF @Ok IS NULL
	BEGIN
		IF NOT EXISTS (SELECT * FROM POSTarjetaMonedero WHERE Empresa = @Empresa AND Serie = @Monedero)
			SELECT @Ok = 1, @OkRef = 'LA TARJETA NO EXISTE'
	END

	IF @Ok IS NULL AND @QueEs = 'SALDO'
	BEGIN
		EXEC spPOSWSSolicitudMonederoInfo @Empresa, @Monedero ,@Usuario, @Estacion, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT
		
		IF @Ok  IS NULL 
			IF NOT EXISTS (SELECT * FROM POSSaldoPMon WHERE Empresa = @Empresa AND Cuenta = @Monedero)
				SELECT @Ok = 1, @OkRef = 'LA TARJETA NO TIENE SALDO'
	END
	IF @Ok IS NULL AND @QueEs = 'EDOCTA'
	BEGIN
		EXEC spPOSWSSolAuxiliarPMon @Empresa, @Monedero ,@Usuario, @Estacion, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT


		IF @Ok  IS NULL 
		BEGIN
			--WAITFOR DELAY '00:03'
			IF NOT EXISTS (SELECT * FROM POSAuxiliarPMon WHERE Empresa = @Empresa AND Cuenta = @Monedero)
				SELECT @Ok = 1, @OkRef = 'LA TARJETA NO TIENE ESTADO DE CUENTA'
		END
	END

	IF @Ok IS NOT NULL
		SET @Mensaje = UPPER(NULLIF(@OkRef,''))

	SELECT @Mensaje

END
GO

--EXEC spPOSMonederoSaldoEdoCta 'SHMEX', 'ABC123','TDELACRUZ', 2, 1, 'SALDO'


/************************ spPOSMonederoAsociar2 *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spPOSMonederoAsociar2') AND type = 'P') DROP PROCEDURE dbo.spPOSMonederoAsociar2
GO             
CREATE PROCEDURE spPOSMonederoAsociar2
           @ID                 varchar(36),
           @Monedero           varchar(20),
           @Usuario            varchar(10),
           @Estacion           int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	@Cliente				varchar(10),
			@Proyecto				varchar(50),
			@Almacen				varchar(10),
			@Agente					varchar(10),
			@Cajero					varchar(10),
			@FormaEnvio				varchar(50),
			@Condicion				varchar(50),
			@Vencimiento			varchar(50),
			@Descuento				varchar(50),
			@DescuentoGlobal		varchar(50),
			@ListaPreciosEsp		varchar(20),
			@ZonaImpuesto			varchar(50),
			@ZonaImpuestoSucursal	varchar(50),
			@ImagenNombreAnexo		varchar(255),
			@Sucursal				int,	  
			@Nombre					varchar(100),
			@Direccion				varchar(100),
			@DireccionNumero		varchar(20),
			@DireccionNumeroInt		varchar(20),
			@EntreCalles			varchar(100),
			@Delegacion				varchar(100),
			@Colonia				varchar(100),
			@Poblacion				varchar(100),
			@Estado					varchar(50),
			@Pais					varchar(50),
			@Zona					varchar(50),
			@CodigoPostal			varchar(15),
			@RFC					varchar(15),
			@CURP					varchar(50),	
			@ListaPreciosSucursal	varchar(20),		
			@ListaPreciosUsuario	varchar(20),
			@Puntos					float,
			@Importe				float,
			@Empresa				varchar(5),
			@Ok						int,
			@OkRef					varchar(255),
			@FechaNacimiento		datetime,
			@EstadoCivil			varchar(20),
			@Conyuge				varchar(100),	
			@Sexo					varchar(20),	
			@Fuma					bit,
			@Profesion				varchar(100),	
			@Puesto					varchar(100),
			@NumeroHijos			int,
			@Religion				varchar(50)	  
   

   --IF EXISTS(SELECT * FROM POSValeSerie WHERE Serie = @Monedero)
   --  SELECT @Cliente = Cliente FROM POSValeSerie WHERE Serie = @Monedero
   
   SELECT @Empresa = Empresa, @Sucursal = Sucursal FROM POSL WHERE ID = @ID
   
   SELECT @ListaPreciosSucursal = ListaPreciosEsp, @ZonaImpuestoSucursal = ZonaImpuesto
     FROM Sucursal
    WHERE Sucursal = @Sucursal   
   
   --SELECT @MonederoLDI = ISNULL(MonederoLDI,0) FROM POSCfg WHERE Empresa = @Empresa
   IF @Cliente IS NOT NULL
   BEGIN
     SELECT  @Proyecto				= ct.Proyecto,
             @Agente				= ct.Agente,
             @FormaEnvio			= ct.FormaEnvio,
             @Condicion				= ct.Condicion,
             @Descuento				= ct.Descuento,
             @DescuentoGlobal		= d.Porcentaje,
             @ListaPreciosEsp		= ISNULL(ISNULL(ISNULL(NULLIF(u.DefListaPreciosEsp,''), NULLIF(ct.ListaPreciosEsp,'')), NULLIF(@ListaPreciosSucursal,'')),'(Precio Lista)'),
             @ZonaImpuesto			= ISNULL(ISNULL(NULLIF(u.DefZonaImpuesto,''),NULLIF(ct.ZonaImpuesto,'')),NULLIF(@ZonaImpuestoSucursal,'')),
			 @Nombre				= ct.Nombre,
			 @Direccion				= ct.Direccion,
			 @DireccionNumero		= ct.DireccionNumero,
			 @DireccionNumeroInt	= ct.DireccionNumeroInt,
			 @EntreCalles			= ct.EntreCalles,
			 @Delegacion			= ct.Delegacion,
			 @Colonia				= ct.Colonia,
			 @Poblacion				= ct.Poblacion,
			 @Estado				= ct.Estado,
			 @Pais					= ct.Pais,
			 @Zona					= ct.Zona,
			 @CodigoPostal			= ct.CodigoPostal,
			 @RFC					= ct.RFC,
			 @CURP					= ct.CURP,
			 @FechaNacimiento		= ct.FechaNacimiento,
			 @EstadoCivil			= ct.EstadoCivil,
			 @Conyuge				= ct.Conyuge,
			 @Sexo					= ct.Sexo ,
			 @Fuma					= ct.Fuma, 
			 @Profesion				= ct.Profesion,
			 @Puesto				= ct.Puesto,
			 @NumeroHijos			= ct.NumeroHijos,
			 @Religion				= ct.Religion	     
        FROM Cte ct 
        LEFT OUTER JOIN Descuento d ON ct.Descuento = d.Descuento  
        JOIN Usuario u ON 1=1   
       WHERE ct.Cliente = @Cliente
         AND u.Usuario = @Usuario
        

       IF @Cliente IS NOT NULL  
       UPDATE POSL SET	Cliente = @Cliente, 
						Proyecto = @Proyecto,
						FormaEnvio = @FormaEnvio,
						Condicion = ISNULL(NULLIF(@Condicion,''),Condicion),
						Descuento = ISNULL(NULLIF(@Descuento,''),Descuento),
						DescuentoGlobal = ISNULL(NULLIF(@DescuentoGlobal,''),DescuentoGlobal),
						ListaPreciosEsp = @ListaPreciosEsp,
						ZonaImpuesto = ISNULL(NULLIF(@ZonaImpuesto,''),ZonaImpuesto),
						Nombre	  = @Nombre,
						Direccion	  = @Direccion,
						DireccionNumero	= @DireccionNumero,
						DireccionNumeroInt	= @DireccionNumeroInt,
						EntreCalles	= @EntreCalles,
						Delegacion		= @Delegacion,
						Colonia		= @Colonia,
						Poblacion		= @Poblacion,
						Estado		= @Estado,
						Pais		= @Pais,
						Zona		= @Zona,
						CodigoPostal	= @CodigoPostal,
						RFC		= @RFC,
						CURP		= @CURP,
						Monedero           = @Monedero,
						FechaNacimiento = @FechaNacimiento,
						EstadoCivil	= @EstadoCivil,
						Conyuge	= @Conyuge,
						Sexo = @Sexo,
						Fuma	= @Fuma,
						Profesion = @Profesion, 
						Puesto = @Puesto,
						NumeroHijos	= @NumeroHijos,
						Religion = @Religion		     	       
       WHERE ID = @ID         
         
   END 
   ELSE        
	UPDATE POSL SET Monedero = @Monedero WHERE ID = @ID
     
   EXEC spPOSOfertaAplicar	@ID
   EXEC spPOSOfertaPuntosInsertarTemp @ID, NULL, 1, @Estacion     
   IF NULLIF(@Cliente,'') IS NULL     
	SELECT @Cliente = Cliente FROM POSL WHERE ID = @ID
	SELECT @Puntos = ISNULL(SUM(Puntos),0.0) FROM POSLVenta WHERE ID = @ID
   
   --IF @Puntos >0.0 SET @Puntos = 0.0    
   
  --SELECT @OkRef
  RETURN
END
GO


/************************ spPOSMonederoAsociar *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spPOSMonederoAsociar') AND type = 'P') DROP PROCEDURE dbo.spPOSMonederoAsociar
GO             
CREATE PROCEDURE spPOSMonederoAsociar
				@Empresa		varchar(5),
				@Monedero		varchar(20),
				@Usuario		varchar(10),
				@Estacion		int,
				@Sucursal		int,
				@ID				varchar(36)
AS BEGIN
	DECLARE	@Ok			int,
			@OkRef		varchar(255),
			@Mensaje	varchar(255)

	SET @Ok = NULL
	SET @OkRef = NULL
	SET @Mensaje = NULL

	EXEC spPOSWSSolTarjetaMonedero @Empresa, @Monedero ,@Usuario, @Estacion, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

	IF @Ok IS NULL
	BEGIN
		IF NOT EXISTS (SELECT * FROM POSTarjetaMonedero WHERE Empresa = @Empresa AND Serie = @Monedero)
			SELECT @Ok = 1, @OkRef = 'LA TARJETA NO EXISTE'
	END

	IF @Ok IS NULL
		EXEC spPOSMonederoAsociar2  @ID, @Monedero, @Usuario, @Estacion

	IF @Ok IS NOT NULL
		SET @Mensaje = UPPER(NULLIF(@OkRef,''))

	SELECT @Mensaje

END
GO

/************************************** spAfectarMonederoWS **************************************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarMonederoWS') and type = 'P') 
drop procedure dbo.spAfectarMonederoWS
GO
                
CREATE PROCEDURE spAfectarMonederoWS    
          @Empresa      varchar( 5),    
          @Sucursal     int        ,    
          @Accion       varchar(20),    
          @ID           int        ,    
          @Usuario      varchar(10),    
          @Modulo       varchar( 5),    
          @Mov          varchar(20),    
          @Estatus      varchar(15),
		  @Ok			int				OUTPUT,    
          @OkRef		varchar(255)	OUTPUT
		  
AS    
BEGIN    
  DECLARE    
          @MovID                   varchar(20),    
          @Serie                   varchar(20),    
          @FechaMov                datetime   ,    
          @EstatusN                varchar(15),    
          @Rama                    varchar( 5),    
          @Moneda                  varchar(10),    
          @TipoCambio              float      ,    
          @Cuenta                  varchar(20),    
          @CuentaDestino           varchar(20),    
          @SubCuenta               varchar(50),    
          @Grupo                   varchar(10),    
          @Cargo                   money      ,    
          @Abono                   money      ,    
          @Fecha                   datetime   ,    
          @EjercicioAfectacion     int        ,    
          @PeriodoAfectacion       int        ,    
          @AcumulaSinDetalles      bit        ,    
          @AcumulaEnLinea          bit        ,    
          @GeneraAuxiliar          bit        ,    
          @GeneraSaldo             bit        ,    
          @Conciliar               bit        ,    
          @Aplica                  varchar(20),    
          @AplicaID                varchar(20),    
          @EsResultados            bit        ,    
          @Renglon                 float      ,    
          @RenglonSub              int        ,    
          @RenglonID               int        ,    
          @SubCuenta2              varchar(50),    
          @SubCuenta3              varchar(50),    
          @Proyecto                varchar(50),    
          @Observaciones           varchar(100),    
          @Referencia              varchar(50),    
          @UEN                     int        ,    
          @ImporteMov              money          
                            
  BEGIN TRANSACTION      
      
  SELECT @Moneda = ContMoneda, @TipoCambio = 1.0, @Rama = 'MONEL', @SubCuenta = '', @Grupo = 'ME',     
         @AcumulaSinDetalles = 1, @AcumulaEnLinea = 1, @GeneraAuxiliar = 1, @GeneraSaldo = 1, @Conciliar = 0, @EsResultados = 0    
    FROM EmpresaCfg     
   WHERE Empresa = @Empresa    
                       
  IF @Modulo = 'MONEL'    
  BEGIn    
    IF @Accion = 'AFECTAR'    
    BEGIn    
      IF @Estatus = 'SINAFECTAR'    
      BEGIN    
        SELECT @EstatusN = 'CONCLUIDO', @FechaMov = GETDATE()    
                                
        IF @Mov = 'Activacion Tarjeta' AND @Ok IS NULL    
        BEGIN    
          EXEC spConsecutivoMonedero @Sucursal, @Empresa, @Modulo, @ID, @Mov, NULL, NULL, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
            
          IF @MovID IS NOT NULL AND @OK IS NULL    
          BEGIN    
            UPDATE Monedero SET MovID = @MovID WHERE ID = @ID    
              
            IF EXISTS(SELECT * FROM MonederoD WHERE ID = @ID)    
            BEGIN    
              IF NOT EXISTS(SELECT *     
                              FROM Monedero M    
                              JOIN MonederoD D ON M.ID = D.ID    
                              JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                             WHERE M.ID = @ID    
                               AND T.Estatus IN ('ACTIVA'))    
              BEGIN    
                UPDATE TarjetaMonedero     
                   SET TarjetaMonedero.Estatus           = 'ACTIVA',    
                       TarjetaMonedero.TieneMovimientos  = 1       ,    
                       TarjetaMonedero.UsuarioActivacion = @Usuario,    
                       TarjetaMonedero.FechaActivacion   = M.FechaEmision    
                  FROM Monedero  M    
                  JOIN MonederoD D ON M.ID = D.ID    
                  JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                 WHERE M.ID = @ID                 
                    
                UPDATE Monedero    
                   SET UltimoCambio    = @FechaMov  ,    
                       Estatus         = @EstatusN,    
                       FechaConclusion = @FechaMov  ,    
                       Ejercicio       = YEAR (FechaEmision),    
                       Periodo         = MONTH(FechaEmision)    
                 WHERE ID = @ID    
                    
                SELECT @EjercicioAfectacion = Ejercicio, @PeriodoAfectacion = Periodo, @Fecha = FechaEmision, @Referencia = Referencia, @Observaciones = Observaciones    
                  FROM Monedero    
                 WHERE ID = @ID    
                    
                IF NOT EXISTS(SELECT * FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID AND Estatus = @EstatusN)    
                  INSERT MovTiempo    
                         (Modulo , ID, FechaComenzo, FechaInicio, Estatus ,  Sucursal, Usuario)    
                  VALUES (@Modulo,@ID, @FechaMov   , @FechaMov  ,@EstatusN, @Sucursal,@Usuario)     
                    
                IF @OK IS NULL    
                  EXEC spMovInsertar @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @EjercicioAfectacion, @PeriodoAfectacion, @FechaMov, @Fecha,    
                                     NULL, NULL, @Moneda, @TipoCambio, @Usuario, NULL, @Referencia, NULL, @Observaciones, @Ok OUTPUT       
              END    
              ELSE    
                SELECT @OK = 99001, @OKRef = T.Serie     
                  FROM Monedero        M    
                  JOIN MonederoD       D ON M.ID      = D.ID    
                  JOIN TarjetaMonedero T ON M.Empresa = T.Empresa AND D.Serie = T.Serie    
                 WHERE M.ID = @ID    
                   AND T.Estatus IN ('ACTIVA')    
            END    
            ELSE    
              SELECT @OK = 60010    
          END    
        END        
      END          
    END        
  END    
      
  IF @OK IS NULL    
  BEGIN    
    COMMIT TRANSACTION  
  END    
  ELSE    
  BEGIN    
    ROLLBACK TRANSACTION
  END    
      
  RETURN    
END 
GO

/************************ spMonederoActivar *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spMonederoActivar') AND type = 'P') DROP PROCEDURE dbo.spMonederoActivar
GO             
CREATE PROCEDURE spMonederoActivar
				 @Empresa	varchar(5),
				 @Serie		varchar(20),
				 @Usuario	varchar(10),
				 @Sucursal	int,
				 @Ok		int				OUTPUT,
				 @OkRef		varchar(255)	OUTPUT

AS BEGIN
	DECLARE @FechaAlta			datetime,
			@FechaActivacion	datetime,
			@IDMonedero			int

	SET @FechaActivacion = GETDATE()
	SET @FechaAlta = dbo.fnFechaSinHora(@FechaActivacion) 
	SET @Serie = UPPER(@Serie)
	
	IF NOT EXISTS (SELECT * FROM TarjetaMonedero WHERE Empresa = @Empresa AND Serie = @Serie)
		INSERT INTO TarjetaMonedero (Empresa,	Serie,	Estatus,	TieneMovimientos,	Usuario,	FechaAlta,	UsuarioActivacion,	FechaActivacion,	FechaBaja)
		VALUES						(@Empresa, @Serie,	'ALTA',		0,					@Usuario,	@FechaAlta, NULL,				NULL,				NULL)

	IF @@ERROR <> 0	SET @Ok = 1

	IF @Ok IS NULL
	BEGIN
		INSERT INTO Monedero (Empresa,	Mov,					MovID,	FechaEmision,	UltimoCambio,		UEN,	Usuario,	Observaciones,	Referencia, Estatus,		
							Ejercicio,	Periodo,	FechaRegistro,	FechaConclusion,	FechaCancelacion,	Importe,	Sucursal,	SucursalOrigen, SucursalDestino)
		VALUES				 (@Empresa, 'Activacion Tarjeta',	NULL,	@FechaAlta,		@FechaActivacion,	NULL,	@Usuario,	'Alta POS',		NULL,		'SINAFECTAR',	
							NULL,		NULL,		NULL,			NULL,				NULL,				NULL,		@Sucursal,	@Sucursal,		NULL)
		SELECT @IDMonedero = SCOPE_IDENTITY()

		IF @@ERROR <> 0	SET	@Ok = 1
		
		IF @Ok IS NULL
		BEGIN
			INSERT INTO MonederoD (ID,			Renglon,	RenglonSub, Serie,	SerieDestino,	Importe,	Sucursal,	SucursalOrigen) 
			VALUES				  (@IDMonedero, 2048.0,		0,			@Serie, NULL,			NULL,		@Sucursal,	@Sucursal)
			IF @@ERROR <> 0	SET	@Ok = 1
		END

		IF @Ok IS NULL
			EXEC spAfectarMonederoWS @Empresa, @Sucursal, 'AFECTAR', @IDMonedero, @Usuario, 'MONEL', 'Activacion Tarjeta', 'SINAFECTAR', @Ok OUTPUT, @OkRef OUTPUT
	END
END
GO


/************************ spPOSMonederoActivar *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spPOSMonederoActivar') AND type = 'P') DROP PROCEDURE dbo.spPOSMonederoActivar
GO             
CREATE PROCEDURE spPOSMonederoActivar
				@Empresa		varchar(5),
				@Monedero		varchar(20),
				@Usuario		varchar(10),
				@Estacion		int,
				@Sucursal		int,
				@ID				varchar(36)
AS BEGIN
	DECLARE	@Ok			int,
			@OkRef		varchar(255),
			@Mensaje	varchar(255)

	SET @Ok = NULL
	SET @OkRef = NULL
	SET @Mensaje = NULL

	EXEC spPOSWSSolTarjetaMonedero @Empresa, @Monedero ,@Usuario, @Estacion, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

	IF @Ok IS NULL
	BEGIN
		IF NOT EXISTS (SELECT * FROM POSTarjetaMonedero WHERE Empresa = @Empresa AND Serie = @Monedero)
			SELECT @Ok = 1, @OkRef = 'LA TARJETA NO EXISTE'
	END

	IF @OkRef = 'LA TARJETA NO EXISTE'
	BEGIN
		SELECT @Ok = NULL, @OkRef = NULL
		EXEC spPOSWSSolTarjetaMonederoActivar @Empresa, @Monedero ,@Usuario, @Estacion, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT
		IF @Ok IS NULL
		BEGIN
			IF NOT EXISTS (SELECT * FROM POSTarjetaMonedero WHERE Empresa = @Empresa AND Serie = @Monedero)
				SELECT @Ok = 1, @OkRef = 'LA TARJETA NO EXISTE'
		END
	END

	IF @Ok IS NULL
		EXEC spPOSMonederoAsociar2  @ID, @Monedero, @Usuario, @Estacion

	IF @Ok IS NOT NULL
		SET @Mensaje = UPPER(NULLIF(@OkRef,''))

	SELECT @Mensaje

END
GO

/************************ spBorrarMonedero *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spBorrarMonedero') AND type = 'P') DROP PROCEDURE dbo.spBorrarMonedero
GO             
CREATE PROCEDURE spBorrarMonedero
AS
BEGIN
  DELETE FROM AuxiliarPMon
  DELETE FROM SaldoPMon
  DELETE FROM AcumPMon
  DELETE FROM MonederoD
  DELETE FROM Monedero
  DELETE FROM TarjetaMonedero
  DELETE FROM SerieTarjetaMovM
  DELETE FROM POSSaldoPMon
  DELETE FROM POSAuxiliarPMon
  DELETE FROM POSTarjetaMonedero
  DELETE FROM POSSerieTarjetaMovMTemp
  DELETE FROM POSSerieTarjetaMovM


  UPDATE MonederoC SET Consecutivo = 0

END
GO

/************************ spPOSConsecutivoAutoAsignaAntes *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spPOSConsecutivoAutoAsignaAntes') AND type = 'P') DROP PROCEDURE dbo.spPOSConsecutivoAutoAsignaAntes
GO             
CREATE PROCEDURE spPOSConsecutivoAutoAsignaAntes
				 @ID		varchar(36)

AS BEGIN 
	DECLARE	@Empresa			varchar(5), 
			@Sucursal			int, 
			@Mov				varchar(20),
			@MovID				varchar(20),
			@Prefijo			varchar(5),
			@Consecutivo		int,
			@noAprobacion		int,
			@FechaAprobacion	datetime,
			@Ok					int,
			@OkRef				int
			

	SELECT @Empresa				= Empresa,
		   @Sucursal			= Sucursal,		
		   @Mov					= Mov,
		   @MovID				= NULLIF(MovID,'')
	  FROM POSL
	 WHERE ID = @ID
	
	IF @MovID IS NULL
	BEGIN
		EXEC spPOSConsecutivoAuto @Empresa, @Sucursal, @Mov, @MovID OUTPUT, @Prefijo OUTPUT, @Consecutivo OUTPUT, @noAprobacion OUTPUT, @FechaAprobacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
	
		UPDATE POSL SET MovID = @MovID WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Mov = @Mov AND ID = @ID
	END

RETURN
END
GO
--POSCobroMonedero
--EXEC spPOSConsecutivoAutoAsignaAntes '802E1F51-87AD-4902-972C-EE968BD1F483'

/************************************** spPOSMonederoCBRefimir   **************************************/
if exists (select * from sysobjects where id = object_id('dbo.spPOSMonederoCBRefimir  ') and type = 'P') 
drop procedure dbo.spPOSMonederoCBRefimir
GO
CREATE PROCEDURE dbo.spPOSMonederoCBRefimir  
          @Empresa              char( 5),
          @Sucursal             int,
		  @IDPOS				varchar(36),
		  @MonederoCBSerie		varchar(20),
		  @MonederoCBImporte	money,
		  @Posicion				int,
		  @Moneda				varchar(10),
		  @TipoCambio			float,
		  @Usuario				varchar(10),
		  @Mov					varchar(20),
		  @MovID				varchar(20),
		  @Ok					int				OUTPUT,
		  @OkRef				varchar(255)	OUTPUT
 
AS 
BEGIN
    DECLARE
          @Accion               varchar(20),
          @UEN                  int,
          @Puntos               money,
          @SaldoPMonuntos       money,
          @DiferenciaPuntos     money,
          @Rama                 varchar( 5),
          @Cuenta               varchar(50),
          @SubCuenta            varchar(50),
          @Grupo                varchar(10),
          @EjercicioAfectacion  int,
          @PeriodoAfectacion    int,
          @AcumulaSinDetalles   bit,
          @AcumulaEnLinea       bit,
          @GeneraAuxiliar       bit,
          @GeneraSaldo	        bit,
          @Conciliar            bit,
          @EsResultados         bit,
          @Renglon              float,
          @RenglonSub           int,
          @RenglonID            int,
		  @Bandera				int,
		  @Estatus              varchar(15),
		  @MovTipo              varchar(20),
          @EstatusNuevo         varchar(15),
          @FechaRegistro        datetime,
		  @Mensaje				varchar(max),
		  @ID                   int,
		  @MovDev				varchar(20),
		  @Modulo               varchar( 5),
		  @FechaEmision			datetime

  
	SELECT @Rama					= 'MONEL', 
		   @SubCuenta				= '', 
		   @Grupo					= 'ME', 
		   @AcumulaSinDetalles		= 1, 
		   @AcumulaEnLinea			= 1,
		   @GeneraAuxiliar			= 1,
		   @GeneraSaldo				= 1,
		   @Conciliar				= 0, 
		   @EsResultados			= 0,
		   @FechaRegistro			= GETDATE(),
		   @FechaEmision			= dbo.fnFechaSinHora(@FechaRegistro),
		   @EjercicioAfectacion		= CONVERT(int,DATEPART(YEAR,@FechaEmision)),
		   @PeriodoAfectacion		= CONVERT(int,DATEPART(MONTH,@FechaEmision)),
		   @Estatus					= 'SINAFECTAR',
		   @Modulo					= 'VTAS',
		   @ID						= NULL

	SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
	SELECT @MovDev = POSDefMovDev FROM POSCfg WHERE Empresa = @Empresa



  BEGIN TRAN 
  IF @Modulo = 'VTAS'
  BEGIN
    INSERT INTO POSSerieTarjetaMovM (Empresa,	Modulo,		ID,		Serie,				Importe,			Sucursal,  Posicion,	
									Mov,	MovID,	Moneda,		TipoCambio,		FechaEmision,	Usuario)
	VALUES						 (@Empresa, @Modulo,	@IDPOS, @MonederoCBSerie,	@MonederoCBImporte, @Sucursal, @Posicion,	
									@Mov,	@MovID, @Moneda,	@TipoCambio,	@FechaEmision,	@Usuario)

  
	IF @Estatus = 'SINAFECTAR' AND @MovTipo = 'VTAS.N'	
		SET @EstatusNuevo = 'PROCESAR' 

	IF @Estatus = 'SINAFECTAR' AND @MovTipo = 'VTAS.F'	
	SET @EstatusNuevo = 'CONCLUIDO'     
    
    IF @MovTipo IN ('VTAS.N', 'VTAS.F') 
    BEGIN
      IF @EstatusNuevo IN ('PROCESAR', 'CONCLUIDO')
      BEGIN
        SELECT @Accion =  'AFECTAR'

        IF EXISTS(SELECT * FROM POSSerieTarjetaMovM WHERE Modulo = @Modulo AND ID = @IDPOS) --REDIMIR PUNTOS
        BEGIN
		   SELECT @Cuenta = NULLIF(Serie,''), 
				  @Puntos = ABS(ISNULL(Importe,0.0) )
			 FROM POSSerieTarjetaMovM 
			WHERE Modulo = @Modulo 
			  AND ID = @IDPOS
			  AND Posicion = @Posicion

          IF @Cuenta IS NOT NULL AND ISNULL(@Puntos,0.0) > 0.0
          BEGIN   
            IF EXISTS(SELECT * 
                            FROM TarjetaMonedero T
                            WHERE T.Serie = @Cuenta AND T.Estatus IN ('ACTIVA'))
            BEGIN
              SELECT @SaldoPMonuntos = SUM(ISNULL(Saldo,0.0)) 
                FROM SaldoPMon 
               WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta --AND UEN = ISNULL(NULLIF(@UEN,''),'0')

			    IF @Mov <> @MovDev
					EXEC spSaldoPMon @Sucursal, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, @Puntos, NULL, @FechaEmision, 
								  @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Mov, @MovID, 
								  @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN
			    ELSE
					EXEC spSaldoPMon @Sucursal, @Accion, @Empresa, @Rama, @Moneda, @TipoCambio, @Cuenta, @SubCuenta, @Grupo, @Modulo, @ID, @Mov, @MovID, NULL, @Puntos, @FechaEmision, 
								  @EjercicioAfectacion, @PeriodoAfectacion,@AcumulaSinDetalles, @AcumulaEnLinea, @GeneraAuxiliar, @GeneraSaldo, @Conciliar, @Mov, @MovID, 
								  @EsResultados, @Ok OUTPUT, @OkRef OUTPUT, @Renglon = @Renglon, @RenglonSub = @RenglonSub, @RenglonID = @RenglonID, @UEN = @UEN


			  IF @OK IS NULL
			  BEGIN
				UPDATE POSSerieTarjetaMovM 
				   SET Referencia = 'APROBADA' 
				 WHERE Mov = @Mov 
				   AND MovID = @MovID 
				   AND Posicion = @Posicion 
				   AND Empresa = @Empresa
				   AND Serie = @MonederoCBSerie
				   AND Sucursal = @Sucursal
				
			  END 
            END
            ELSE
              SELECT @OK = 99005, @OKRef = 'La Cuenta ' + @Cuenta + 'no Existe o no está Activa'
          END
        END
      END
    END
  END
 
  IF @OK IS NULL
	COMMIT TRAN 
  ELSE
  BEGIN
	ROLLBACK TRAN
	IF @OkRef IS NULL
		SELECT @OkRef = 'DENEGADA'
  END
 
END
GO
--EXEC spPOSMonederoCBRefimir 'SHMEX', 1, '1952083A-425A-488E-BF9B-3AC0A93E01E7', 'ABC123', 10.00, 1, 'Pesos', 1, 'TDELACRUZ', 'Nota', 'H3S1-3', NULL, NULL

/************************ spPOSMonederoRedimir *****************************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spPOSMonederoRedimir') AND type = 'P') DROP PROCEDURE dbo.spPOSMonederoRedimir
GO             
CREATE PROCEDURE spPOSMonederoRedimir
				@Empresa		varchar(5),
				@Monedero		varchar(20),
				@Importe		money,
				@Usuario		varchar(10),
				@Estacion		int,
				@Sucursal		int,
				@ID				varchar(36)
AS BEGIN
	DECLARE	@Ok				int,
			@OkRef			varchar(255),
			@Mensaje		varchar(255),
			@Moneda			varchar(10),
			@TipoCambio		float,
			@Saldo			money,
			@Referencia		varchar(20)

	SET @Ok			= NULL
	SET @OkRef		= NULL
	SET @Mensaje	= NULL
	SET @Referencia = NULL
	SET @Saldo		= 0.00
	SELECT @Moneda		= Moneda, 
		   @TipoCambio	= TipoCambio 
	  FROM POSL 
	 WHERE ID = @ID

	DELETE FROM POSSerieTarjetaMovMTemp WHERE Estacion = @Estacion
	DELETE FROM POSTarjetaMonedero WHERE Estacion = @Estacion
	DELETE FROM POSSaldoPMon WHERE Estacion = @Estacion

	EXEC spPOSWSSolTarjetaMonedero @Empresa, @Monedero ,@Usuario, @Estacion, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

	IF @Ok IS NULL
	BEGIN
		IF NOT EXISTS (SELECT * FROM POSTarjetaMonedero WHERE Empresa = @Empresa AND Serie = @Monedero)
			SELECT @Ok = 1, @OkRef = 'LA TARJETA NO EXISTE'
	END

	IF @Ok IS NULL
	BEGIN
		EXEC spPOSWSSolicitudMonederoInfo @Empresa, @Monedero ,@Usuario, @Estacion, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

		SELECT @Saldo = ISNULL(Saldo,0.00) FROM POSSaldoPMon WHERE Empresa = @Empresa AND Cuenta = @Monedero AND Moneda = @Moneda
	
		IF ISNULL(@Saldo,0.00) >= @Importe 
			EXEC spPOSWSSolMonederoRedimir @Empresa, @Monedero, @Importe, @Usuario, @Estacion, @Sucursal, @ID, @Ok OUTPUT, @OkRef OUTPUT
		ELSE
			SELECT @Ok = 1, @OkRef = 'SALDO INSUFICIENTE'
	END

	IF @Ok IS NULL
	BEGIN
		SELECT @Referencia = NULLIF(Referencia,'')
		  FROM POSSerieTarjetaMovMTemp 
		 WHERE Estacion = @Estacion
		
		IF @Referencia <> 'APROBADA'
			SELECT @Ok = 1, @OkRef = 'LA OPERACION FUE RECHAZADA'
	END


	IF @Ok IS NOT NULL
		SET @Mensaje = UPPER(NULLIF(@OkRef,''))

	SELECT @Mensaje

END
GO

/************************************** spMonVerificar **************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spMonVerificar') AND type = 'P')  DROP PROCEDURE dbo.spMonVerificar
GO
  
CREATE PROCEDURE spMonVerificar
    			@ID                		int,
				@Accion					varchar(20),
				@Base					varchar(20),
    			@Empresa	      		varchar(5),
				@Usuario				varchar(10),
    			@Modulo	      			varchar(5),
    			@Mov	  	      		varchar(20),
    			@MovID             		varchar(20),
    			@MovTipo     			varchar(20),
    			@MovMoneda	      		varchar(10),
    			@MovTipoCambio	 		float,
     	    	@Estatus	 	      	varchar(15),
     	    	@EstatusNuevo	      	varchar(15),
				@FechaEmision			datetime,

				@Ok						int				OUTPUT,
				@OkRef					varchar(255)	OUTPUT
AS 
BEGIN    
  DECLARE  
          @Sucursal         int,
		  @FechaRegistro	datetime,
		  @Bandera			int,
		  @Serie			VARCHAR(20),
		  @Redime			int
     
  
  
     SELECT @Sucursal = Sucursal, @FechaRegistro = FechaRegistro, @Serie = NULLIF(Monedero,'') ,@Redime = RedimePuntos
      FROM Venta WITH(NOLOCK)
     WHERE ID = @ID
  
  IF @Modulo = 'VTAS' AND @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR' AND @EstatusNuevo IN ('PROCESAR','CONCLUIDO')/* AND @MovTipo = 'VTAS.N' */AND @Serie IS NOT NULL 
	BEGIN

	  IF NOT EXISTS (SELECT * FROM TarjetaMonedero WHERE  Serie =  @Serie) AND @Redime = 0
		BEGIN
	      SELECT @OK =2122, @OKREF='La Serie no Existe'
		END
		ELSE
		BEGIN

		  IF NOT EXISTS(SELECT * FROM SerieTarjetaMovM WHERE Modulo = 'VTAS' AND ID = @ID) 
			BEGIN
			  INSERT SerieTarjetaMovM  
				(Empresa , Modulo, ID , Serie , Importe  , Sucursal)  
			  SELECT Empresa , 'VTAS', ID , Monedero , Importe  , Sucursal  
				FROM Venta
			  WHERE  ID = @ID  
			END
		END
	 
	END
  RETURN      
END      
GO


/************** spMonederoFinal *************/
if exists (select * from sysobjects where id = object_id('dbo.spMonederoFinal') and type = 'P') drop procedure dbo.spMonederoFinal
GO
CREATE PROCEDURE spMonederoFinal
				@Empresa				varchar(5),
				@Sucursal				int,
				@Modulo					varchar(5), 
				@ID						int, 			
				@Estatus				varchar(15), 
				@EstatusNuevo			varchar(15),
				@Usuario				varchar(10),
				@FechaEmision			datetime, 	
				@FechaRegistro			datetime,
				@Mov					varchar(20),
				@MovID					varchar(20),
				@MovTipo				varchar(20),
				@IDGenerar				int,
				@Ok						int				OUTPUT,
				@OkRef					varchar(255)	OUTPUT

AS BEGIN
	DECLARE @VentaMon	bit,
			@OrigenTipo	varchar(10)

	SELECT @VentaMon = ISNULL(VentaMonederoA,0)  FROM EmpresaCFG2   WHERE Empresa = @Empresa


	IF @Modulo = 'VTAS' AND @MovTipo IN ('VTAS.N','VTAS.F','VTAS.D') AND @EstatusNuevo IN ('PROCESAR','CONCLUIDO','CANCELADO') 
	   AND @VentaMon = 1
	  BEGIN
	    SELECT @OrigenTipo = NULLIF(OrigenTipo,'') FROM Venta WHERE ID = @ID
		EXEC xpMovFinalMonedero @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID,
			@MovTipo,@Ok OUTPUT, @OkRef	OUTPUT
		IF EXISTS (SELECT * FROM AuxiliarPMon WHERE Modulo = 'VTAS' AND Rama = 'MONEL' AND Empresa = @Empresa AND ModuloID = @ID AND NULLIF(MovID,'') IS NULL) AND @OrigenTipo <> 'POS'
			UPDATE AuxiliarPMon SET MovID = @MovID WHERE Modulo = 'VTAS' AND Rama = 'MONEL' AND Empresa = @Empresa AND ModuloID = @ID AND NULLIF(MovID,'') IS NULL

		IF EXISTS (SELECT * FROM AuxiliarPMon WHERE Modulo = 'VTAS' AND Rama = 'MONEL' AND Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND NULLIF(ModuloID,'') IS NULL) AND @OrigenTipo = 'POS'
			UPDATE AuxiliarPMon SET ModuloID = @ID WHERE Modulo = 'VTAS' AND Rama = 'MONEL' AND Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND NULLIF(ModuloID,'') IS NULL
	  END
  RETURN
END
GO