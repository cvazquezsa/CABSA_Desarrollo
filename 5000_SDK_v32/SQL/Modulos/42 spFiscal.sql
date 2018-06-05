/**************** fnFactorFiscal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFactorFiscal') DROP FUNCTION fnFactorFiscal --MEJORA1015
GO
CREATE FUNCTION fnFactorFiscal 
	(
	@FactorFiscalEsp				bit, 
	@FactorFiscal					int,
	@Factor							int
	)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	int

  SELECT @Resultado = CASE WHEN ISNULL(@FactorFiscalEsp,0) = 0 THEN @Factor ELSE ISNULL(@FactorFiscal,@Factor) END
  
  RETURN (@Resultado)
END
GO

/**************** fnFiscalRegimen ****************/ --MEJORA726
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFiscalRegimen') DROP FUNCTION fnFiscalRegimen
GO
CREATE FUNCTION fnFiscalRegimen 
	(
	@Modulo				varchar(5), 
	@ID					int
	)
RETURNS varchar(30)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FiscalRegimen	varchar(30),
    @ContactoTipo	varchar(20),
    @Contacto		varchar(10)

  IF @Modulo = 'VTAS' SELECT @FiscalRegimen = c.FiscalRegimen  FROM Venta  v  JOIN Cte c  ON c.Cliente = v.Cliente       WHERE  v.ID = @ID ELSE
  IF @Modulo = 'COMS' SELECT @FiscalRegimen = p.FiscalRegimen  FROM Compra c  JOIN Prov p ON p.Proveedor = c.Proveedor   WHERE  c.ID = @ID ELSE
  IF @Modulo = 'GAS'  SELECT @FiscalRegimen = p.FiscalRegimen  FROM Gasto  g  JOIN Prov p ON p.Proveedor = g.Acreedor    WHERE  g.ID = @ID ELSE  
  IF @Modulo = 'CXP'  SELECT @FiscalRegimen = p.FiscalRegimen  FROM Cxp    c  JOIN Prov p ON p.Proveedor = c.Proveedor   WHERE  c.ID = @ID ELSE    
  IF @Modulo = 'CXC'  SELECT @FiscalRegimen = c.FiscalRegimen  FROM Cxc    cx JOIN Cte c  ON c.Cliente   = cx.Cliente    WHERE cx.ID = @ID ELSE      
  IF @Modulo = 'DIN'
  BEGIN
    SELECT @ContactoTipo = ContactoTipo, @Contacto = Contacto FROM Dinero WHERE ID = @ID
    IF @ContactoTipo = 'Proveedor' SELECT @FiscalRegimen = FiscalRegimen FROM Prov WHERE Proveedor = @Contacto ELSE
    IF @ContactoTipo = 'Cliente'   SELECT @FiscalRegimen = FiscalRegimen FROM Cte  WHERE Cliente   = @Contacto ELSE SELECT @FiscalRegimen = '(Todos)'
  END ELSE SELECT @FiscalRegimen = '(Todos)'

    
  RETURN (ISNULL(NULLIF(@FiscalRegimen,''),'(Vacio)'))
END
GO

/**************** fnFiscalVerificarContacto ****************/ --MEJORA733
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFiscalVerificarContacto') DROP FUNCTION fnFiscalVerificarContacto
GO
CREATE FUNCTION fnFiscalVerificarContacto 
	(
	@Modulo				varchar(5), 
	@ID					int
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FiscalGenerar	bit,
    @ContactoTipo	varchar(20),
    @Contacto		varchar(10)

  IF @Modulo = 'VTAS' SELECT @FiscalGenerar = c.FiscalGenerar  FROM Venta  v  JOIN Cte c  ON c.Cliente = v.Cliente       WHERE  v.ID = @ID ELSE
  IF @Modulo = 'COMS' SELECT @FiscalGenerar = p.FiscalGenerar  FROM Compra c  JOIN Prov p ON p.Proveedor = c.Proveedor   WHERE  c.ID = @ID ELSE
  IF @Modulo = 'GAS'  SELECT @FiscalGenerar = p.FiscalGenerar  FROM Gasto  g  JOIN Prov p ON p.Proveedor = g.Acreedor    WHERE  g.ID = @ID ELSE  
  IF @Modulo = 'CXP'  SELECT @FiscalGenerar = p.FiscalGenerar  FROM Cxp    c  JOIN Prov p ON p.Proveedor = c.Proveedor   WHERE  c.ID = @ID ELSE    
  IF @Modulo = 'CXC'  SELECT @FiscalGenerar = c.FiscalGenerar  FROM Cxc    cx JOIN Cte c  ON c.Cliente   = cx.Cliente    WHERE cx.ID = @ID ELSE      
  IF @Modulo = 'DIN'
  BEGIN
    SELECT @ContactoTipo = ContactoTipo, @Contacto = Contacto FROM Dinero WHERE ID = @ID
    IF @ContactoTipo = 'Proveedor' SELECT @FiscalGenerar = FiscalGenerar FROM Prov WHERE Proveedor = @Contacto ELSE
    IF @ContactoTipo = 'Cliente'   SELECT @FiscalGenerar = FiscalGenerar FROM Cte  WHERE Cliente   = @Contacto ELSE SELECT @FiscalGenerar = 1
  END ELSE SELECT @FiscalGenerar = 1

    
  RETURN (ISNULL(@FiscalGenerar,0))
END
GO

/**************** fnFiscalOrigenMoneda ****************/ --MEJORA743
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFiscalOrigenMoneda') DROP FUNCTION fnFiscalOrigenMoneda
GO
CREATE FUNCTION fnFiscalOrigenMoneda 
	(
	@Modulo				varchar(5), 
	@ID					int
	)
RETURNS varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Moneda			varchar(10)

  SET @Moneda = NULL
  
  IF @Modulo = 'VTAS' SELECT @Moneda = v.Moneda  FROM Venta v  WHERE  v.ID = @ID ELSE
  IF @Modulo = 'COMS' SELECT @Moneda = c.Moneda  FROM Compra c WHERE  c.ID = @ID ELSE  
  IF @Modulo = 'GAS'  SELECT @Moneda = g.Moneda  FROM Gasto g  WHERE  g.ID = @ID ELSE    
  IF @Modulo = 'CXP'  SELECT @Moneda = c.Moneda  FROM Cxp c    WHERE  c.ID = @ID ELSE    
  IF @Modulo = 'CXC'  SELECT @Moneda = c.Moneda  FROM Cxc c    WHERE  c.ID = @ID ELSE      
  IF @Modulo = 'DIN'  SELECT @Moneda = d.Moneda  FROM Dinero d WHERE  d.ID = @ID
    
  RETURN (@Moneda)
END
GO

/**************** fnFiscalOrigenMov ****************/ --MEJORA749
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFiscalOrigenMov') DROP FUNCTION fnFiscalOrigenMov
GO
CREATE FUNCTION fnFiscalOrigenMov 
	(
	@Modulo				varchar(5), 
	@ID					int
	)
RETURNS varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mov			varchar(20)

  SET @Mov = NULL
  
  IF @Modulo = 'VTAS' SELECT @Mov = v.Mov  FROM Venta v  WHERE  v.ID = @ID ELSE
  IF @Modulo = 'COMS' SELECT @Mov = c.Mov  FROM Compra c WHERE  c.ID = @ID ELSE  
  IF @Modulo = 'GAS'  SELECT @Mov = g.Mov  FROM Gasto g  WHERE  g.ID = @ID ELSE    
  IF @Modulo = 'CXP'  SELECT @Mov = c.Mov  FROM Cxp c    WHERE  c.ID = @ID ELSE    
  IF @Modulo = 'CXC'  SELECT @Mov = c.Mov  FROM Cxc c    WHERE  c.ID = @ID ELSE      
  IF @Modulo = 'DIN'  SELECT @Mov = d.Mov  FROM Dinero d WHERE  d.ID = @ID
    
  RETURN (@Mov)
END
GO

/**************** fnFiscalVerificarObligacionFiscal ****************/ --MEJORA749
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFiscalVerificarObligacionFiscal') DROP FUNCTION fnFiscalVerificarObligacionFiscal
GO
CREATE FUNCTION fnFiscalVerificarObligacionFiscal 
	(
	@Modulo				varchar(5),
	@Mov				varchar(20),
	@OrigenModulo		varchar(5),
	@OrigenMov			varchar(20), 
	@ObligacionFiscal	varchar(30)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit,
    @NombreModulo		varchar(50)

  SET @Resultado = 1
    
  SET @NombreModulo = CASE
    WHEN @OrigenModulo = 'VTAS' THEN 'Ventas'
    WHEN @OrigenModulo = 'COMS' THEN 'Compras'    
    WHEN @OrigenModulo = 'GAS'  THEN 'Gastos'        
    WHEN @OrigenModulo = 'CXP'  THEN 'Cxp'           
    WHEN @OrigenModulo = 'CXC'  THEN 'Cxc'               
    WHEN @OrigenModulo = 'DIN'  THEN 'Tesoreria'                   
    WHEN @OrigenModulo = 'CONC'  THEN 'Conciliacion'                       
  END
  
  IF EXISTS(SELECT * FROM MovTipoObligacionFiscalOmitir WHERE Modulo = @Modulo AND Mov = @Mov AND OrigenModulo = @NombreModulo AND OrigenMov = @OrigenMov AND ObligacionFiscal = @ObligacionFiscal) SET @Resultado = 0  

  RETURN (@Resultado)
END
GO

/**************** fnFiscalOrigenTipoCambio ****************/ --MEJORA743
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFiscalOrigenTipoCambio') DROP FUNCTION fnFiscalOrigenTipoCambio
GO
CREATE FUNCTION fnFiscalOrigenTipoCambio 
	(
	@Modulo				varchar(5), 
	@ID					int
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoCambio			float

  SET @TipoCambio = NULL
  
  IF @Modulo = 'VTAS' SELECT @TipoCambio = v.TipoCambio  FROM Venta v  WHERE  v.ID = @ID ELSE
  IF @Modulo = 'COMS' SELECT @TipoCambio = c.TipoCambio  FROM Compra c WHERE  c.ID = @ID ELSE  
  IF @Modulo = 'GAS'  SELECT @TipoCambio = g.TipoCambio  FROM Gasto g  WHERE  g.ID = @ID ELSE    
  IF @Modulo = 'CXP'  SELECT @TipoCambio = c.TipoCambio  FROM Cxp c    WHERE  c.ID = @ID ELSE    
  IF @Modulo = 'CXC'  SELECT @TipoCambio = c.TipoCambio  FROM Cxc c    WHERE  c.ID = @ID ELSE      
  IF @Modulo = 'DIN'  SELECT @TipoCambio = d.TipoCambio  FROM Dinero d WHERE  d.ID = @ID
    
  RETURN (@TipoCambio)
END
GO

/**************** spFiscalBorrarMovTipoObligacionFiscal ****************/ --MEJORA737
if exists (select * from sysobjects where id = object_id('dbo.spFiscalBorrarMovTipoObligacionFiscal') and type = 'P') drop procedure dbo.spFiscalBorrarMovTipoObligacionFiscal
GO             
CREATE PROCEDURE spFiscalBorrarMovTipoObligacionFiscal
		@Modulo		varchar(5),
		@Mov		varchar(20)

--//WITH ENCRYPTION
AS BEGIN  
  DELETE FROM MovTipoObligacionFiscal WHERE Modulo = @Modulo AND Mov = @Mov
END
GO

/**************** spFiscalBorrarMovTipoObligacionFiscalOmitir ****************/ --MEJORA749
if exists (select * from sysobjects where id = object_id('dbo.spFiscalBorrarMovTipoObligacionFiscalOmitir') and type = 'P') drop procedure dbo.spFiscalBorrarMovTipoObligacionFiscalOmitir
GO             
CREATE PROCEDURE spFiscalBorrarMovTipoObligacionFiscalOmitir
		@Modulo		varchar(5),
		@Mov		varchar(20)

--//WITH ENCRYPTION
AS BEGIN  
  DELETE FROM MovTipoObligacionFiscalOmitir WHERE Modulo = @Modulo AND Mov = @Mov
END
GO

/**************** spFiscalCancelarMovs ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFiscalCancelarMovs') and type = 'P') drop procedure dbo.spFiscalCancelarMovs
GO
CREATE PROCEDURE spFiscalCancelarMovs
		@Empresa	char(5),
		@Modulo		char(5),
		@ID			int,
		@OK			int OUTPUT,
		@OKRef		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
IF EXISTS(SELECT DID FROM MovFlujo WHERE Empresa = @Empresa AND OModulo = @Modulo AND OID = @ID AND DModulo = 'FIS')
BEGIN
  SELECT @Ok = NULL, @OkRef = NULL

  DECLARE @IDFiscal int
  SELECT @IDFiscal = DID FROM MovFlujo WHERE Empresa = @Empresa AND OModulo = @Modulo AND OID = @ID AND DModulo = 'FIS'
  EXEC spAfectar 'FIS', @IDFiscal, 'CANCELAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OKRef = @OKRef OUTPUT
END
END
GO

/********** spTipoImpuestoCerrarDia ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spTipoImpuestoCerrarDia' and type = 'P') DROP PROCEDURE spTipoImpuestoCerrarDia
GO
CREATE PROCEDURE spTipoImpuestoCerrarDia
		(
                   @Fecha	 datetime,
                   @Ok		 int	      = NULL OUTPUT,
                   @OkRef	 varchar(255) = NULL OUTPUT
		)

--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE
  @TipoImpuesto		varchar(10),
  @Tasa			float, 
  @Concepto		varchar(50), 
  @Referencia		varchar(50), 
  @CodigoFiscal		varchar(50),   
  @Tipo			varchar(50)

  EXEC spExtraerFecha @Fecha OUTPUT
  IF @@ERROR <> 0 SET @Ok = 1
  
  --Actualiza el encabezado con el detalle

  --Actualiza la tasa en Compras, Ventas y Gastos
  DECLARE crTipoImpuesto CURSOR FOR
   SELECT ti.Tipo, ti.TipoImpuesto, ISNULL(ti.Tasa,0.0), ISNULL(ti.Referencia,''), ISNULL(ti.CodigoFiscal,''), ISNULL(ti.Concepto,'')
     FROM TipoImpuesto ti JOIN TipoImpuestoD tid 
       ON ti.TipoImpuesto = tid.TipoImpuesto
    WHERE tid.FechaD <= @Fecha
      AND tid.TieneMovimientos = 0
      AND tid.FechaD = (SELECT MAX(TipoImpuestoD.FechaD) FROM TipoImpuestoD WHERE TipoImpuesto = ti.TipoImpuesto AND TipoIMpuestoD.FechaD <= @Fecha)


  OPEN crTipoImpuesto
  FETCH NEXT FROM crTipoImpuesto INTO @Tipo, @TipoImpuesto, @Tasa, @Referencia, @CodigoFiscal, @Concepto
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    IF @Tipo = 'Impuesto 1'
    BEGIN
      --COMPRAS
      UPDATE CompraD SET Impuesto1 = @tasa
        FROM CompraD cd LEFT OUTER JOIN Compra c 
          ON cd.ID = c.ID JOIN  MovTipo mt 		
          ON mt.Modulo = 'COMS' AND mt.Mov = c.Mov
       WHERE cd.TipoImpuesto1 = @TipoImpuesto
	 AND c.Estatus = 'PENDIENTE'

      --VENTAS
      UPDATE VentaD SET Impuesto1 = @tasa
        FROM VentaD vd LEFT OUTER JOIN Venta v 
          ON vd.ID = v.ID JOIN  MovTipo mt 		
          ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov
       WHERE vd.TipoImpuesto1 = @TipoImpuesto
	 AND v.Estatus = 'PENDIENTE'

      --GASTOS
      UPDATE GastoD SET Impuesto1 = @tasa
        FROM GastoD gd LEFT OUTER JOIN Gasto g 
          ON gd.ID = g.ID JOIN  MovTipo mt 		
          ON mt.Modulo = 'GAS' AND mt.Mov = g.Mov
       WHERE gd.TipoImpuesto1 = @TipoImpuesto
	 AND g.Estatus = 'PENDIENTE'

    END
    ELSE
    IF @Tipo = 'Impuesto 2'
    BEGIN
      --COMPRAS
      UPDATE CompraD SET Impuesto2 = @tasa
        FROM CompraD cd LEFT OUTER JOIN Compra c 
          ON cd.ID = c.ID JOIN  MovTipo mt 		
          ON mt.Modulo = 'COMS' AND mt.Mov = c.Mov
       WHERE cd.TipoImpuesto2 = @TipoImpuesto
	 AND c.Estatus = 'PENDIENTE'


      --VENTAS
      UPDATE VentaD SET Impuesto2 = @tasa
        FROM VentaD vd LEFT OUTER JOIN Venta v 
          ON vd.ID = v.ID JOIN  MovTipo mt 		
          ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov
       WHERE vd.TipoImpuesto2 = @TipoImpuesto
	 AND v.Estatus = 'PENDIENTE'

      --GASTOS
      UPDATE GastoD SET Impuesto2 = @tasa
        FROM GastoD gd LEFT OUTER JOIN Gasto g 
          ON gd.ID = g.ID JOIN  MovTipo mt 		
          ON mt.Modulo = 'GAS' AND mt.Mov = g.Mov
       WHERE gd.TipoImpuesto2 = @TipoImpuesto
	 AND g.Estatus = 'PENDIENTE'
    END
    ELSE
    IF @Tipo = 'Impuesto 3'
    BEGIN
      --COMPRAS
      UPDATE CompraD SET Impuesto3 = @tasa
        FROM CompraD cd LEFT OUTER JOIN Compra c 
          ON cd.ID = c.ID JOIN  MovTipo mt 		
          ON mt.Modulo = 'COMS' AND mt.Mov = c.Mov
       WHERE cd.TipoImpuesto3 = @TipoImpuesto
	 AND c.Estatus = 'PENDIENTE'


      --VENTAS
      UPDATE VentaD SET Impuesto3 = @tasa
        FROM VentaD vd LEFT OUTER JOIN Venta v 
          ON vd.ID = v.ID JOIN  MovTipo mt 		
          ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov
       WHERE vd.TipoImpuesto3 = @TipoImpuesto
	 AND v.Estatus = 'PENDIENTE'

      --GASTOS
      UPDATE GastoD SET Impuesto3 = @tasa
        FROM GastoD gd LEFT OUTER JOIN Gasto g 
          ON gd.ID = g.ID JOIN  MovTipo mt 		
          ON mt.Modulo = 'GAS' AND mt.Mov = g.Mov
       WHERE gd.TipoImpuesto3 = @TipoImpuesto
	 AND g.Estatus = 'PENDIENTE'
    END
    FETCH NEXT FROM crTipoImpuesto INTO @Tipo, @TipoImpuesto, @Tasa, @Referencia, @CodigoFiscal, @Concepto
  END
  CLOSE crTipoImpuesto
  DEALLOCATE crTipoImpuesto

  IF @Ok IS NULL
  BEGIN
    UPDATE TipoImpuesto SET
           Tasa         = tid.Tasa, 
           Concepto     = tid.Concepto, 
           Referencia   = tid.Referencia, 
           CodigoFiscal = tid.CodigoFiscal
      FROM TipoImpuesto ti JOIN TipoImpuestoD tid 
        ON ti.TipoImpuesto = tid.TipoImpuesto
     WHERE tid.FechaD <= @Fecha
       AND tid.TieneMovimientos = 0
       AND tid.FechaD = (SELECT MAX(TipoImpuestoD.FechaD) FROM TipoImpuestoD WHERE TipoImpuesto = ti.TipoImpuesto AND TipoIMpuestoD.FechaD <= @Fecha)

    IF @@ERROR <> 0 SET @Ok = 1
  END

END
GO

/**************** spFiscalVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFiscalVerificar') and type = 'P') drop procedure dbo.spFiscalVerificar
GO
CREATE PROCEDURE spFiscalVerificar
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

		    @Acreedor			varchar(10),
		    @Condicion			varchar(50),
		    @Vencimiento		datetime,

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN 
  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END 
  RETURN
END
GO

/**************** spFiscalAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFiscalAfectar') and type = 'P') drop procedure dbo.spFiscalAfectar
GO             
CREATE PROCEDURE spFiscalAfectar
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

		   @Acreedor			varchar(10),
		   @Condicion			varchar(50),
		   @Vencimiento			datetime,

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
    @IXPMov		varchar(20),
    @IAFMov		varchar(20),
    @CxMov		varchar(20),
    @CxMovID		varchar(20),
    @CxImporte		money,
    @FiscalGenerarRetenciones bit

  SELECT @IXPMov = CxpImpuestosPorPagar,
         @IAFMov = CxpImpuestosFavor
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
    
  SELECT @FiscalGenerarRetenciones = FiscalGenerarRetenciones
    FROM EmpresaCfg2
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
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, 'SINAFECTAR', 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT

    IF @Ok IS NULL
    BEGIN
      INSERT FiscalD (
             Sucursal,  ID,         Renglon, ObligacionFiscal, Importe, OtrosImpuestos, Tasa, Excento, Deducible,	       OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie/*, DebeFiscal, HaberFiscal*/) 
      SELECT @Sucursal, @IDGenerar, Renglon, ObligacionFiscal, Importe, OtrosImpuestos, Tasa, Excento, ISNULL(Deducible, 100), OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie/*, DebeFiscal, HaberFiscal*/
        FROM FiscalD
       WHERE ID = @ID

      IF @Ok IS NULL SELECT @Ok = 80030
    END
    RETURN
  END
--JGD 23Marzo2011 Ticket 3665
  ELSE
    UPDATE FiscalD
       SET OrigenModulo = @Modulo,
	       OrigenModuloID = @ID
     WHERE ID = @ID AND OrigenModuloID IS NULL AND OrigenModulo IS NULL
--Fin JGD 23Marzo2011 Ticket 3665

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
      IF @MovTipo IN ('FIS.D', 'FIS.C') AND @Ok IS NULL
      BEGIN
        IF NOT(@FiscalGenerarRetenciones = 1 AND (SELECT MAX(O.Tipo) FROM FiscalD d JOIN ObligacionFiscal o ON d.ObligacionFiscal = O.ObligacionFiscal WHERE ID = @ID) IN ('Retencion 1', 'Retencion 2'))
        BEGIN
          SELECT @CxImporte = 0.0, @CxMov = @IXPMov
          SELECT @CxImporte = ISNULL(SUM(Neto), 0.0) FROM FiscalD WHERE ID = @ID 
          IF @CxImporte < 0.0
            SELECT @CxImporte = -@CxImporte, @CxMov = @IAFMov
--spAfectar 'FIS', 244, 'AFECTAR'

          IF @CxImporte <> 0.0
            EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, 'CXP', @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                             @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                             @FechaRegistro, @Ejercicio, @Periodo, 
                             @Condicion, @Vencimiento, @Acreedor, NULL, NULL, NULL, NULL, NULL, 
                             @CxImporte, NULL, NULL, NULL, 
                             NULL, NULL, NULL, NULL, NULL, @CxMov,
                             NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT/*, @MovIDEspecifico = @MovID*/

          IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
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

        EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Fiscal
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

--select * from MovFlujo WHERE OModulo = 'FIS' aND oid = @ID
--select @OK = 1

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

/**************** spFiscal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFiscal') and type = 'P') drop procedure dbo.spFiscal
GO
CREATE PROCEDURE spFiscal
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
    @CfgContXGenerar	char(20),
    @Acreedor		varchar(10),
    @Condicion		varchar(50),
    @Vencimiento	datetime

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
         @Concepto = Concepto, @Referencia = Referencia, 
         @Acreedor = NULLIF(RTRIM(Acreedor), ''), @Condicion = NULLIF(RTRIM(Condicion), ''), @Vencimiento = Vencimiento
    FROM Fiscal
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
      EXEC spFiscalVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
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
      EXEC spFiscalAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			   @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                           @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
                           @Acreedor, @Condicion, @Vencimiento,  
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

/**************** fnFiscalImporte ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFiscalImporte') DROP FUNCTION fnFiscalImporte
GO

CREATE FUNCTION fnFiscalImporte (@TipoImporte varchar(20), @Importe float, @Tasa float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado    float
  IF UPPER(@TipoImporte) IN ('OBLIGACION FISCAL', '- OBLIGACION FISCAL')
    SELECT @Resultado = (@Importe*100.0)/NULLIF(@Tasa, 0.0)
  ELSE
    SELECT @Resultado = @Importe
 
  IF SUBSTRING(@TipoImporte, 1, 1) = '-'
    SELECT @Resultado = -@Resultado
  RETURN (@Resultado)
END
GO


/**************** spGenerarFiscal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarFiscal') and type = 'P') drop procedure dbo.spGenerarFiscal
GO
CREATE PROCEDURE spGenerarFiscal
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
		   @AfectarFiscal	varchar(20),

		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @FiscalID					int,
    @FiscalMov					varchar(20),
    @FiscalMovID				varchar(20),
    @ObligacionFiscal			varchar(50),
    @OrigenModulo				varchar(5), 
    @OrigenModuloID				int,
    @Tipo						varchar(20),
    @ObligacionFechaD			datetime,
    @Importe					money,
    @OtrosImpuestos				money,
    @Tasa						float,  
    @Excento					bit,   
    @Deducible					float,
    @Moneda						varchar(10),
    @TipoCambio					float,
    @Proyecto					varchar(50),
    @UEN						int,
    @Renglon					float,
    @CfgOmitirDepositoAntCxc	bit,
    @CfgOmitirChAntCxp			bit,
    @CfgOmitirCobrosChDevCxc	bit,
    @CfgOmitirPagosChDevCxp		bit,
    @CfgOmitirPagosEndosoCxp	bit,
    @CfgRegAplicaAnticipoCxc	bit,
    @CfgRegAplicaFacturaCxc		bit,
    @CfgRegAplicaAnticipoCxp	bit,
    @CfgRegAplicaFacturaCxp		bit,
    @FiscalRegimen				varchar(30),
    @ObligacionFiscalEspecifica	bit,
    @ObligacionFiscalRegimen	varchar(30)

  IF @EstatusNuevo <> 'CANCELADO'
    IF EXISTS (SELECT DID FROM MovFlujo WHERE DModulo = 'FIS' AND OModulo = @Modulo AND OID = @ID) AND @EstatusNuevo <> 'CANCELADO'
      RETURN
  
  IF @EstatusNuevo <> 'CANCELADO' AND dbo.fnFiscalVerificarContacto(@Modulo, @ID) = 0 --MEJORA733
    RETURN --MEJORA733
  
  SELECT @CfgOmitirDepositoAntCxc = FiscalOmitirDepositoAntCxc,
         @CfgOmitirChAntCxp = FiscalOmitirChAntCxp,
 	 @CfgOmitirCobrosChDevCxc = FiscalOmitirCobrosChDevCxc,
	 @CfgOmitirPagosChDevCxp = FiscalOmitirPagosChDevCxp,
         @CfgOmitirPagosEndosoCxp = FiscalOmitirPagosEndosoCxp,
	 @CfgRegAplicaAnticipoCxc = FiscalRegAplicaAnticipoCxc,
	 @CfgRegAplicaFacturaCxc = FiscalRegAplicaFacturaCxc,
	 @CfgRegAplicaAnticipoCxp = FiscalRegAplicaAnticipoCxp,
	 @CfgRegAplicaFacturaCxp = FiscalRegAplicaFacturaCxp
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

-- Se pasan estas validaciones a Nivel Detalle
/*
  IF @CfgOmitirDepositoAntCxc = 1 AND @MovTipo IN ('DIN.D', 'DIN.DE') 
  BEGIN
    IF EXISTS (SELECT d.ID FROM Dinero d
                 JOIN MovFlujo m ON d.ID = m.DID AND m.DModulo = 'DIN' AND m.OModulo = 'DIN'
                 JOIN MovTipo ts ON m.OMov = ts.Mov AND ts.Clave = 'DIN.SD'
                 JOIN Dinero s ON m.OID = s.ID
                 JOIN MovTipo omt ON omt.Modulo = s.OrigenTipo  AND omt.Mov = s.Origen
                WHERE omt.Clave = 'CXC.A' AND d.ID = @ID)
          OR (SELECT mt.Clave FROM Dinero d JOIN MovTipo mt ON mt.Modulo = d.OrigenTipo AND mt.Mov = d.Origen WHERE ID = @ID) = 'CXC.A'
    RETURN
  END

  IF @CfgOmitirChAntCxp = 1 AND @MovTipo IN ('DIN.CH', 'DIN.CHE') 
  BEGIN
    IF EXISTS (SELECT d.ID FROM Dinero d
                 JOIN MovFlujo m ON d.ID = m.DID AND m.DModulo = 'DIN' AND m.OModulo = 'DIN'
                 JOIN MovTipo ts ON m.OMov = ts.Mov AND ts.Clave = 'DIN.SCH'
                 JOIN Dinero s ON m.OID = s.ID
                 JOIN MovTipo omt ON omt.Modulo = s.OrigenTipo  AND omt.Mov = s.Origen
                WHERE omt.Clave = 'CXP.A' AND d.ID = @ID)
          OR (SELECT mt.Clave FROM Dinero d JOIN MovTipo mt ON mt.Modulo = d.OrigenTipo AND mt.Mov = d.Origen WHERE ID = @ID) = 'CXP.A'
    RETURN
  END
*/  

--JGD03Febrero2011 Solucion Ticket 3547. Se cambio la Tabla pMovImpuesto (que no existe) por MovImpuesto.
  IF @CfgOmitirCobrosChDevCxc = 1 
    IF EXISTS (SELECT * FROM MovImpuesto p 
               JOIN cxc c ON p.OrigenModulo = 'CXC' AND p.OrigenModuloID = c.ID AND c.Estatus = 'CONCLUIDO'
               JOIN MovTipo m ON c.Mov = m.Mov AND m.Modulo = 'CXC' AND m.Clave = 'CXC.CD' 
              WHERE p.Modulo = 'DIN' AND p.ModuloID = @ID)
      RETURN
--JGD 30Marzo2011. Se hace una corrección, ya que la Consulta anteriormente estaba referenciada en el Join a Cxc, se cambia a Cxp
  IF @CfgOmitirPagosChDevCxp = 1 
    IF EXISTS (SELECT * FROM MovImpuesto p 
               JOIN cxp c ON p.OrigenModulo = 'CXP' AND p.OrigenModuloID = c.ID AND c.Estatus = 'CONCLUIDO'
               JOIN MovTipo m ON c.Mov = m.Mov AND m.Modulo = 'CXP' AND m.Clave = 'CXP.CD' 
              WHERE p.Modulo = 'DIN' AND p.ModuloID = @ID)
      RETURN
--JGD 30Marzo2011 Solucion Ticket 4073
  IF @CfgOmitirPagosChDevCxp = 1 
    IF EXISTS (SELECT * FROM MovImpuesto p 
               JOIN cxp c ON p.OrigenModulo = 'CXP' AND p.OrigenModuloID = c.ID AND c.Estatus = 'CONCLUIDO'
               JOIN MovTipo m ON c.Mov = m.Mov AND m.Modulo = 'CXP' AND m.Clave = 'CXP.CD' 
                WHERE p.Modulo = 'CXP' AND p.ModuloID = @ID)
      RETURN
  IF @CfgOmitirCobrosChDevCxc = 1 
    IF EXISTS (SELECT * FROM MovImpuesto p 
               JOIN cxc c ON p.OrigenModulo = 'CXC' AND p.OrigenModuloID = c.ID AND c.Estatus = 'CONCLUIDO'
               JOIN MovTipo m ON c.Mov = m.Mov AND m.Modulo = 'CXC' AND m.Clave = 'CXC.CD' 
                WHERE p.Modulo = 'CXC' AND p.ModuloID = @ID)
      RETURN
--Fin JGD 30Marzo2011 Solucion Ticket 4073

  IF @CfgRegAplicaAnticipoCxc = 1 AND @MovTipo = 'CXC.ANC'
  BEGIN
    IF (SELECT Clave FROM Cxc c JOIN MovTipo m ON c.MovAplica = m.Mov AND m.Modulo = 'CXC'  WHERE c.ID = @ID) <> 'CXC.A'
      RETURN

    IF @CfgRegAplicaFacturaCxc = 1 AND NOT EXISTS (SELECT * 
                     FROM Cxc c 
                     JOIN CXCD d ON c.ID = D.ID 
                     JOIN cxc a ON d.Aplica = a.Mov AND d.aplicaID = a.MovID and c.Empresa = a.Empresa
                     JOIN Movtipo m on m.mov = d.Aplica and m.Modulo = 'CXC'
                    WHERE c.ID = @ID AND m.Clave = 'CXC.F')
        RETURN
  END

  IF @CfgRegAplicaAnticipoCxp = 1 AND @MovTipo = 'CXP.ANC'
  BEGIN
    IF (SELECT Clave FROM Cxc c JOIN MovTipo m ON c.MovAplica = m.Mov AND m.Modulo = 'CXP'  WHERE c.ID = @ID) <> 'CXP.A'
	  RETURN

    IF @CfgRegAplicaFacturaCxp = 1 AND NOT EXISTS (SELECT * 
                     FROM Cxc c 
                     JOIN CXCD d ON c.ID = D.ID 
                     JOIN cxc a ON d.Aplica = a.Mov AND d.aplicaID = a.MovID and c.Empresa = a.Empresa
                     JOIN Movtipo m on m.mov = d.Aplica and m.Modulo = 'CXP'
                    WHERE c.ID = @ID AND m.Clave = 'CXP.F')
        RETURN
  END

  IF @CfgOmitirPagosEndosoCxp = 1 
    IF @MovTipo = 'CXP.P' AND EXISTS (SELECT * FROM Cxp c JOIN MovFlujo m ON m.DModulo = 'CXP' AND m.DID = c.ID AND m.OModulo = 'CXP' JOIN MovTipo t ON t.Modulo = 'CXP' AND t.Mov = m.OMov WHERE c.ID = @ID AND t.Clave = 'CXP.FAC')
     RETURN


  DECLARE
    @FiscalD		TABLE (
	Renglon				float		NULL,
	ObligacionFiscal	varchar(50)	COLLATE Database_Default NULL,
	TipoImpuesto		varchar(10)	COLLATE Database_Default NULL,
    Importe             money           NULL,
	OtrosImpuestos		money           NULL,
	--Base			as		(ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0)),
	Tasa				float		NULL,
	Excento				bit		NULL	DEFAULT 0,
	Deducible			float		NULL 	DEFAULT 100,
	--Neto			as		(CASE WHEN Excento = 1 THEN NULL ELSE (ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0))*(ISNULL(Tasa, 0.0)/100.0)*(ISNULL(Deducible, 0.0)/100.0) END),
	OrigenModulo		varchar(5)	COLLATE Database_Default NULL,
	OrigenModuloID		int		NULL,
	Contacto			varchar(10)	COLLATE Database_Default NULL,
	ContactoTipo		varchar(20)	COLLATE Database_Default NULL,
	AFArticulo			varchar(20)	COLLATE Database_Default NULL,
	AFSerie				varchar(50)	COLLATE Database_Default NULL,  -- BUG12333
	OrigenMoneda		varchar(10)	COLLATE Database_Default NULL,	--MEJORA743
	OrigenTipoCambio	float	NULL,								--MEJORA743
	Tipo				varchar(20) NULL,							--MEJORA996
	Retencion1		float	NULL,									--MEJORA1019
	Retencion2		float	NULL,									--MEJORA1019
	Retencion3		float	NULL,									--MEJORA1019
	AplicaModulo    varchar(20) NULL,
    AplicaID        int NULL)


  IF @MovTipo IN ('DIN.D', 'DIN.CH') AND @EstatusNuevo = 'PENDIENTE'
    RETURN

  IF @EstatusNuevo = 'CANCELADO'
  BEGIN
  /*
    DECLARE crFiscal CURSOR LOCAL FOR 
     SELECT ID, Mov, MovID
       FROM Fiscal
      WHERE Empresa = @Empresa AND Estatus = 'CONCLUIDO' AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID
      */
      DECLARE crFiscal CURSOR LOCAL FOR 
	 SELECT F.ID, F.Mov, F.MovID
       FROM MovFlujo M 
       JOIN Fiscal   F ON M.DID = F.ID
      WHERE M.Empresa = @Empresa AND OModulo = @Modulo AND OID = @ID AND OMov = @Mov AND OMovID = @MovID AND M.DModulo = 'FIS' AND M.Cancelado = 0 
    OPEN crFiscal
    FETCH NEXT FROM crFiscal INTO @FiscalID, @FiscalMov, @FiscalMovID
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spAfectar 'FIS', @FiscalID, 'CANCELAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        EXEC spMovFlujo @Sucursal, 'CANCELAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'FIS', @FiscalID, @FiscalMov, @FiscalMovID, @Ok OUTPUT
      END
      FETCH NEXT FROM crFiscal INTO @FiscalID, @FiscalMov, @FiscalMovID
    END
    CLOSE crFiscal
    DEALLOCATE crFiscal

    RETURN
  END ELSE
  BEGIN
    EXEC spMovInfo @ID, @Modulo, @Moneda = @Moneda OUTPUT, @TipoCambio = @TipoCambio OUTPUT, @Proyecto = @Proyecto OUTPUT, @UEN = @UEN OUTPUT

    SELECT @FiscalRegimen = dbo.fnFiscalRegimen(@Modulo, @ID) --MEJORA726
  
    IF EXISTS(SELECT * FROM MovTipoObligacionFiscal WHERE Modulo = @Modulo AND Mov = @Mov) SELECT @ObligacionFiscalEspecifica = 1 ELSE SELECT @ObligacionFiscalEspecifica = 0  --MEJORA737  
    --MEJORA737

    DECLARE crObligacionFiscal CURSOR LOCAL FOR                                                           
     SELECT o.ObligacionFiscal, o.Tipo, o.FechaD, o.Regimen                                                          
       FROM ObligacionFiscal o LEFT OUTER JOIN MovTipoObligacionFiscal mtof                               
         ON mtof.Modulo = @Modulo AND mtof.Mov = @Mov AND mtof.ObligacionFiscal = o.ObligacionFiscal     
      WHERE o.GenerarEn = ISNULL(CASE WHEN @AfectarFiscal IN ('Emision Acumulable', 'Emision Deducible') THEN 'Emision' WHEN @AfectarFiscal IN ('Endoso Acumulable', 'Endoso Deducible') THEN NULL ELSE 'Flujo' END, o.GenerarEn) --MEJORA737
        AND o.GenerarEn NOT IN (NULL, 'No')
        AND ((ISNULL(NULLIF(o.Regimen,'(Todos)'),@FiscalRegimen) = @FiscalRegimen) OR (o.Regimen = ISNULL(NULLIF(@FiscalRegimen,'(Todos)'),o.Regimen))) --MEJORA726 
        AND (mtof.ObligacionFiscal IS NOT NULL OR @ObligacionFiscalEspecifica = 0)
      ORDER BY Orden
      
    OPEN crObligacionFiscal
    FETCH NEXT FROM crObligacionFiscal INTO @ObligacionFiscal, @Tipo, @ObligacionFechaD, @ObligacionFiscalRegimen
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Tipo = 'Impuesto 1' 
          INSERT @FiscalD (
                 ObligacionFiscal,  Importe,       OtrosImpuestos, TipoImpuesto,  Tasa,      Excento,  OrigenModulo, OrigenModuloID, Deducible,       OrigenMoneda,                                           OrigenTipoCambio,                                           Tipo,  Retencion1, Retencion2, Retencion3, AplicaModulo, AplicaID) --MEJORA743 --MEJORA996 --MEJORA1019
          SELECT @ObligacionFiscal, SUM(SubTotal), SUM(Importe2),  TipoImpuesto1, Impuesto1, Excento1, OrigenModulo, OrigenModuloID, OrigenDeducible, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), @Tipo, 0.0,        Retencion2, 0.0, AplicaModulo, AplicaID --MEJORA743 --MEJORA996 --MEJORA1019
            FROM MovImpuesto
           WHERE Modulo = @Modulo AND ModuloID = @ID AND ISNULL(Excento1,0) = 0
             AND (((ISNULL(NULLIF(@ObligacionFiscalRegimen,'(Todos)'),dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) = dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) OR (@ObligacionFiscalRegimen = ISNULL(NULLIF(dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID),'(Todos)'),@ObligacionFiscalRegimen))) OR @AfectarFiscal NOT IN ('Conciliacion'))--MEJORA726 
             AND (dbo.fnFiscalVerificarContacto(OrigenModulo, OrigenModuloID) = 1  OR @AfectarFiscal NOT IN ('Conciliacion'))  --MEJORA733
             AND dbo.fnFiscalVerificarObligacionFiscal(@Modulo, @Mov, OrigenModulo, dbo.fnFiscalOrigenMov(OrigenModulo,OrigenModuloID),@ObligacionFiscal) = 1 --MEJORA749
           GROUP BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoImpuesto1, Impuesto1, Excento1, OrigenDeducible, Retencion1, Retencion2, Retencion3, AplicaModulo, AplicaID --MEJORA743 --MEJORA1019
           ORDER BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoImpuesto1, Impuesto1, Excento1, OrigenDeducible, Retencion1, Retencion2, Retencion3, AplicaModulo, AplicaID --MEJORA743 --MEJORA1019

        ELSE
        IF @Tipo = 'Impuesto 2' 
          INSERT @FiscalD (
                 ObligacionFiscal, Importe,        TipoImpuesto,  Tasa,      OrigenModulo, OrigenModuloID, Deducible,       OrigenMoneda,                                           OrigenTipoCambio,                                           Tipo,  Retencion1, Retencion2, Retencion3, AplicaModulo, AplicaID) --MEJORA743 --MEJORA996
          SELECT @ObligacionFiscal, SUM(SubTotal), TipoImpuesto2, Impuesto2, OrigenModulo, OrigenModuloID, OrigenDeducible, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), @Tipo, 0.0,        0.0,        0.0, AplicaModulo, AplicaID --MEJORA743 --MEJORA996 --MEJORA1019
            FROM MovImpuesto
           WHERE Modulo = @Modulo AND ModuloID = @ID AND NULLIF(Impuesto2, 0.0) IS NOT NULL
             AND (((ISNULL(NULLIF(@ObligacionFiscalRegimen,'(Todos)'),dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) = dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) OR (@ObligacionFiscalRegimen = ISNULL(NULLIF(dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID),'(Todos)'),@ObligacionFiscalRegimen))) OR @AfectarFiscal NOT IN ('Conciliacion'))--MEJORA726 
             AND (dbo.fnFiscalVerificarContacto(OrigenModulo, OrigenModuloID) = 1  OR @AfectarFiscal NOT IN ('Conciliacion'))  --MEJORA733
             AND dbo.fnFiscalVerificarObligacionFiscal(@Modulo, @Mov, OrigenModulo, dbo.fnFiscalOrigenMov(OrigenModulo,OrigenModuloID),@ObligacionFiscal) = 1 --MEJORA749             
           GROUP BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoImpuesto2, Impuesto2, OrigenDeducible, Retencion1, Retencion2, Retencion3, AplicaModulo, AplicaID --MEJORA743 --MEJORA1019
           ORDER BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoImpuesto2, Impuesto2, OrigenDeducible, Retencion1, Retencion2, Retencion3, AplicaModulo, AplicaID --MEJORA743 --MEJORA1019
        ELSE
        IF @Tipo = 'Impuesto 3' 
          INSERT @FiscalD (
                 ObligacionFiscal,  Importe,       TipoImpuesto,   Tasa,      OrigenModulo, OrigenModuloID, Deducible,       OrigenMoneda,                                           OrigenTipoCambio,                                           Tipo,  Retencion1, Retencion2, Retencion3, AplicaModulo, AplicaID) --MEJORA743 --MEJORA996 --MEJORA1019
          SELECT @ObligacionFiscal, SUM(Importe3), TipoImpuesto3,  100.0,     OrigenModulo, OrigenModuloID, OrigenDeducible, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), @Tipo, Retencion1, Retencion2, Retencion3, AplicaModulo, AplicaID --MEJORA743 --MEJORA996 --MEJORA1019 
            FROM MovImpuesto
           WHERE Modulo = @Modulo AND ModuloID = @ID AND NULLIF(Impuesto3, 0.0) IS NOT NULL
             AND (((ISNULL(NULLIF(@ObligacionFiscalRegimen,'(Todos)'),dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) = dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) OR (@ObligacionFiscalRegimen = ISNULL(NULLIF(dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID),'(Todos)'),@ObligacionFiscalRegimen))) OR @AfectarFiscal NOT IN ('Conciliacion'))--MEJORA726 
             AND (dbo.fnFiscalVerificarContacto(OrigenModulo, OrigenModuloID) = 1  OR @AfectarFiscal NOT IN ('Conciliacion'))  --MEJORA733
             AND dbo.fnFiscalVerificarObligacionFiscal(@Modulo, @Mov, OrigenModulo, dbo.fnFiscalOrigenMov(OrigenModulo,OrigenModuloID),@ObligacionFiscal) = 1 --MEJORA749             
           GROUP BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoImpuesto3, Impuesto3, OrigenDeducible, Retencion1, Retencion2, Retencion3, AplicaModulo, AplicaID --MEJORA743 --MEJORA1019
           ORDER BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoImpuesto3, Impuesto3, OrigenDeducible, Retencion1, Retencion2, Retencion3, AplicaModulo, AplicaID --MEJORA743 --MEJORA1019
        ELSE
        IF @Tipo = 'Retencion 1' 
          INSERT @FiscalD (
                 ObligacionFiscal, Importe,        TipoImpuesto,  Tasa,       OrigenModulo, OrigenModuloID, Deducible,        OrigenMoneda,                                           OrigenTipoCambio,                                           Tipo, AplicaModulo, AplicaID) --MEJORA743 --MEJORA996
          SELECT @ObligacionFiscal, SUM(SubTotal), TipoRetencion1, Retencion1, OrigenModulo, OrigenModuloID, OrigenDeducible, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), @Tipo, AplicaModulo, AplicaID --MEJORA743 --MEJORA996
            FROM MovImpuesto
           WHERE Modulo = @Modulo AND ModuloID = @ID AND NULLIF(Retencion1, 0.0) IS NOT NULL
             AND (((ISNULL(NULLIF(@ObligacionFiscalRegimen,'(Todos)'),dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) = dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) OR (@ObligacionFiscalRegimen = ISNULL(NULLIF(dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID),'(Todos)'),@ObligacionFiscalRegimen))) OR @AfectarFiscal NOT IN ('Conciliacion'))--MEJORA726 
             AND (dbo.fnFiscalVerificarContacto(OrigenModulo, OrigenModuloID) = 1  OR @AfectarFiscal NOT IN ('Conciliacion'))  --MEJORA733
             AND dbo.fnFiscalVerificarObligacionFiscal(@Modulo, @Mov, OrigenModulo, dbo.fnFiscalOrigenMov(OrigenModulo,OrigenModuloID),@ObligacionFiscal) = 1 --MEJORA749             
           GROUP BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoRetencion1, Retencion1, OrigenDeducible, AplicaModulo, AplicaID --MEJORA743
           ORDER BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoRetencion1, Retencion1, OrigenDeducible, AplicaModulo, AplicaID --MEJORA743
        ELSE
        IF @Tipo = 'Retencion 2' 
          INSERT @FiscalD (
                 ObligacionFiscal, Importe,        TipoImpuesto,   Tasa,       OrigenModulo, OrigenModuloID, Deducible,       OrigenMoneda,                                           OrigenTipoCambio,                                           Tipo, AplicaModulo, AplicaID) --MEJORA743 --MEJORA996
          SELECT @ObligacionFiscal, SUM(SubTotal), TipoRetencion2, Retencion2, OrigenModulo, OrigenModuloID, OrigenDeducible, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), @Tipo, AplicaModulo, AplicaID --MEJORA743 --MEJORA996
            FROM MovImpuesto
           WHERE Modulo = @Modulo AND ModuloID = @ID AND NULLIF(Retencion2, 0.0) IS NOT NULL
             AND (((ISNULL(NULLIF(@ObligacionFiscalRegimen,'(Todos)'),dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) = dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) OR (@ObligacionFiscalRegimen = ISNULL(NULLIF(dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID),'(Todos)'),@ObligacionFiscalRegimen))) OR @AfectarFiscal NOT IN ('Conciliacion'))--MEJORA726 
             AND (dbo.fnFiscalVerificarContacto(OrigenModulo, OrigenModuloID) = 1  OR @AfectarFiscal NOT IN ('Conciliacion'))  --MEJORA733
             AND dbo.fnFiscalVerificarObligacionFiscal(@Modulo, @Mov, OrigenModulo, dbo.fnFiscalOrigenMov(OrigenModulo,OrigenModuloID),@ObligacionFiscal) = 1 --MEJORA749             
           GROUP BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoRetencion2, Retencion2, OrigenDeducible, AplicaModulo, AplicaID --MEJORA743
           ORDER BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoRetencion2, Retencion2, OrigenDeducible, AplicaModulo, AplicaID --MEJORA743
        ELSE
        IF @Tipo = 'Retencion 3' 
          INSERT @FiscalD (
                 ObligacionFiscal, Importe,        TipoImpuesto,   Tasa,       OrigenModulo, OrigenModuloID, Deducible,       OrigenMoneda,                                           OrigenTipoCambio,                                           Tipo, AplicaModulo, AplicaID) --MEJORA743 --MEJORA996
          SELECT @ObligacionFiscal, SUM(SubTotal), TipoRetencion3, Retencion3, OrigenModulo, OrigenModuloID, OrigenDeducible, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), @Tipo, AplicaModulo, AplicaID --MEJORA743 --MEJORA996
            FROM MovImpuesto
           WHERE Modulo = @Modulo AND ModuloID = @ID AND NULLIF(Retencion3, 0.0) IS NOT NULL
             AND (((ISNULL(NULLIF(@ObligacionFiscalRegimen,'(Todos)'),dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) = dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) OR (@ObligacionFiscalRegimen = ISNULL(NULLIF(dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID),'(Todos)'),@ObligacionFiscalRegimen))) OR @AfectarFiscal NOT IN ('Conciliacion'))--MEJORA726 
             AND (dbo.fnFiscalVerificarContacto(OrigenModulo, OrigenModuloID) = 1  OR @AfectarFiscal NOT IN ('Conciliacion'))  --MEJORA733
             AND dbo.fnFiscalVerificarObligacionFiscal(@Modulo, @Mov, OrigenModulo, dbo.fnFiscalOrigenMov(OrigenModulo,OrigenModuloID),@ObligacionFiscal) = 1 --MEJORA749             
           GROUP BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoRetencion3, Retencion3, OrigenDeducible, AplicaModulo, AplicaID --MEJORA743
           ORDER BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), TipoRetencion3, Retencion3, OrigenDeducible, AplicaModulo, AplicaID --MEJORA743
        ELSE
        IF @Tipo = 'Base 2' 
          INSERT @FiscalD (
                 ObligacionFiscal, Importe,        Excento,  OrigenModulo, OrigenModuloID, Deducible,       OrigenMoneda,                                           OrigenTipoCambio,                                           Tipo, AplicaModulo, AplicaID) --MEJORA743 --MEJORA996
          SELECT @ObligacionFiscal, SUM(SubTotal), Excento2, OrigenModulo, OrigenModuloID, OrigenDeducible, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), @Tipo, AplicaModulo, AplicaID --MEJORA743 --MEJORA996
            FROM MovImpuesto
           WHERE Modulo = @Modulo AND ModuloID = @ID AND ISNULL(Excento2,0) = 0
             AND (((ISNULL(NULLIF(@ObligacionFiscalRegimen,'(Todos)'),dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) = dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) OR (@ObligacionFiscalRegimen = ISNULL(NULLIF(dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID),'(Todos)'),@ObligacionFiscalRegimen))) OR @AfectarFiscal NOT IN ('Conciliacion'))--MEJORA726 
             AND (dbo.fnFiscalVerificarContacto(OrigenModulo, OrigenModuloID) = 1  OR @AfectarFiscal NOT IN ('Conciliacion'))  --MEJORA733
             AND dbo.fnFiscalVerificarObligacionFiscal(@Modulo, @Mov, OrigenModulo, dbo.fnFiscalOrigenMov(OrigenModulo,OrigenModuloID),@ObligacionFiscal) = 1 --MEJORA749             
           GROUP BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), Excento2, OrigenDeducible, AplicaModulo, AplicaID --MEJORA743
           ORDER BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), Excento2, OrigenDeducible, AplicaModulo, AplicaID --MEJORA743
        ELSE
        IF @Tipo = 'Base 3' 
          INSERT @FiscalD (
                 ObligacionFiscal, Importe,        Excento,  OrigenModulo, OrigenModuloID, Deducible,       OrigenMoneda,                                           OrigenTipoCambio,                                           Tipo, AplicaModulo, AplicaID) --MEJORA743 --MEJORA996
          SELECT @ObligacionFiscal, SUM(SubTotal), Excento3, OrigenModulo, OrigenModuloID, OrigenDeducible, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), @Tipo, AplicaModulo, AplicaID --MEJORA743 --MEJORA996
            FROM MovImpuesto
           WHERE Modulo = @Modulo AND ModuloID = @ID AND ISNULL(Excento3,0) = 0 AND Origenfecha > @ObligacionFechaD
             AND (((ISNULL(NULLIF(@ObligacionFiscalRegimen,'(Todos)'),dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) = dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID)) OR (@ObligacionFiscalRegimen = ISNULL(NULLIF(dbo.fnFiscalRegimen(OrigenModulo,OrigenModuloID),'(Todos)'),@ObligacionFiscalRegimen))) OR @AfectarFiscal NOT IN ('Conciliacion'))--MEJORA726 
             AND (dbo.fnFiscalVerificarContacto(OrigenModulo, OrigenModuloID) = 1  OR @AfectarFiscal NOT IN ('Conciliacion'))  --MEJORA733
             AND dbo.fnFiscalVerificarObligacionFiscal(@Modulo, @Mov, OrigenModulo, dbo.fnFiscalOrigenMov(OrigenModulo,OrigenModuloID),@ObligacionFiscal) = 1 --MEJORA749             
           GROUP BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), Excento3, OrigenDeducible, AplicaModulo, AplicaID --MEJORA743
           ORDER BY OrigenModulo, OrigenModuloID, dbo.fnFiscalOrigenMoneda(OrigenModulo, OrigenModuloID), dbo.fnFiscalOrigenTipoCambio(OrigenModulo, OrigenModuloID), Excento3, OrigenDeducible, AplicaModulo, AplicaID --MEJORA743
      END
      FETCH NEXT FROM crObligacionFiscal INTO @ObligacionFiscal, @Tipo, @ObligacionFechaD, @ObligacionFiscalRegimen
    END
    CLOSE crObligacionFiscal
    DEALLOCATE crObligacionFiscal


    -- Elimina Movimientos menores a un centavo
    DELETE @FiscalD
     WHERE ABS(ROUND(ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0), 10)) < 0.01

    -- Elimina Obligaciones Fiscales que no estan en la vigencia
    DELETE @FiscalD
      FROM @FiscalD d
      LEFT OUTER JOIN ObligacionFiscal o ON o.ObligacionFiscal = d.ObligacionFiscal
      JOIN Mov m ON m.Empresa = @Empresa AND m.Modulo = d.OrigenModulo AND m.ID = d.OrigenModuloID
     WHERE m.FechaEmision NOT BETWEEN ISNULL(o.FechaD, m.FechaEmision) AND ISNULL(o.FechaA, m.FechaEmision)

    -- Elimina Obligaciones Fiscales Emision o Endoso
    DELETE @FiscalD
      FROM @FiscalD d
      LEFT OUTER JOIN ObligacionFiscal o ON o.ObligacionFiscal = d.ObligacionFiscal
      JOIN Mov m ON m.Empresa = @Empresa AND m.Modulo = d.OrigenModulo AND m.ID = d.OrigenModuloID
      JOIN MovTipo mt ON mt.Modulo = m.Modulo AND mt.Mov = m.Mov
     WHERE mt.Clave <> @MovTipo AND mt.AfectarFiscal IN ('Endoso Acumulable', 'Endoso Deducible')

    -- Arrastrar las Obligaciones Fiscales generadas en Modulos Especiales
    IF @Modulo = 'CONC'
    BEGIN
      INSERT @FiscalD (
             OrigenModulo, OrigenModuloID, ObligacionFiscal, Tasa, Importe)
      SELECT @Modulo,      @ID,            ObligacionFiscal, Tasa, dbo.fnFiscalImporte(TipoImporte, ISNULL(SUM(Cargo), 0.0)-ISNULL(SUM(Abono), 0.0), Tasa)
        FROM ConciliacionD
       WHERE ID = @ID AND NULLIF(RTRIM(ObligacionFiscal), '') IS NOT NULL
       GROUP BY ObligacionFiscal, Tasa, TipoImporte
       ORDER BY ObligacionFiscal, Tasa, TipoImporte
       
      INSERT @FiscalD (
             OrigenModulo, OrigenModuloID, ObligacionFiscal,  Tasa, Importe)
      SELECT @Modulo,      @ID,            ObligacionFiscal2, Tasa, dbo.fnFiscalImporte(TipoImporte, ISNULL(SUM(Cargo), 0.0)-ISNULL(SUM(Abono), 0.0), Tasa)
        FROM ConciliacionD
       WHERE ID = @ID AND NULLIF(RTRIM(ObligacionFiscal2), '') IS NOT NULL
       GROUP BY ObligacionFiscal2, Tasa, TipoImporte
       ORDER BY ObligacionFiscal2, Tasa, TipoImporte
    END
    
    IF @CfgOmitirChAntCxp = 1
      DELETE @FiscalD
        FROM @FiscalD d
        JOIN Mov m ON m.Empresa = @Empresa AND m.Modulo = d.OrigenModulo AND m.ID = d.OrigenModuloID
        JOIN MovTipo mt ON mt.Modulo = m.Modulo AND mt.Mov = m.Mov
       WHERE mt.Clave = 'CXP.A'

    IF @CfgOmitirDepositoAntCxc = 1
      DELETE @FiscalD
        FROM @FiscalD d
        JOIN Mov m ON m.Empresa = @Empresa AND m.Modulo = d.OrigenModulo AND m.ID = d.OrigenModuloID
        JOIN MovTipo mt ON mt.Modulo = m.Modulo AND mt.Mov = m.Mov
       WHERE mt.Clave = 'CXC.A'

    IF @Modulo = 'NOM'
      INSERT @FiscalD (
             ObligacionFiscal,   Tasa,    Importe,        OrigenModulo, OrigenModuloID)
      SELECT d.ObligacionFiscal, nc.Tasa, SUM(d.Importe), @Modulo,      @ID
        FROM NominaD d
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
       WHERE d.ID = @ID AND NULLIF(RTRIM(d.ObligacionFiscal), '') IS NOT NULL
       GROUP BY d.ObligacionFiscal, nc.Tasa
       ORDER BY d.ObligacionFiscal, nc.Tasa

    -- Movimientos Directos en Tesoreria
    IF @Modulo = 'DIN'
    BEGIN
      INSERT @FiscalD (
             ObligacionFiscal,    Tasa,                    Importe,                                                                                 OrigenModulo, OrigenModuloID)
      SELECT mt.ObligacionFiscal, mt.ObligacionFiscalTasa, dbo.fnFiscalImporte(mt.ObligacionFiscalTipoImporte, d.Importe, mt.ObligacionFiscalTasa), @Modulo,      @ID
        FROM Dinero d
        JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = d.Mov
       WHERE d.ID = @ID AND UPPER(mt.AfectarFiscal)='(DIRECTO)' AND NULLIF(RTRIM(mt.ObligacionFiscal), '') IS NOT NULL

--JGD 01Abril2011 Ticket 4260
      IF NOT EXISTS (SELECT * FROM @FiscalD)
      BEGIN
        IF EXISTS(SELECT *
                    FROM Dinero d
                    JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = d.Mov
                   WHERE d.ID = @ID AND UPPER(mt.AfectarFiscal) = @AfectarFiscal AND mt.Clave IN ('DIN.AB','DIN.CB'))
        BEGIN
          IF @MovTipo = 'DIN.AB'
            INSERT @FiscalD (
                   ObligacionFiscal,    Tasa,                    Importe,                                                                                 OrigenModulo, OrigenModuloID)
            SELECT mt.ObligacionFiscal, mt.ObligacionFiscalTasa, dbo.fnFiscalImporte(mt.ObligacionFiscalTipoImporte, d.Importe, mt.ObligacionFiscalTasa), @Modulo,      @ID
              FROM Dinero d
              JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = d.Mov
             WHERE d.ID = @ID AND UPPER(mt.AfectarFiscal) = @AfectarFiscal AND mt.Clave = 'DIN.AB'
          ELSE
            INSERT @FiscalD (
                   ObligacionFiscal,    Tasa,                    Importe,                                                                                 OrigenModulo, OrigenModuloID)
            SELECT mt.ObligacionFiscal, mt.ObligacionFiscalTasa, dbo.fnFiscalImporte(mt.ObligacionFiscalTipoImporte, d.Importe, mt.ObligacionFiscalTasa), @Modulo,      @ID
              FROM Dinero d
              JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = d.Mov
             WHERE d.ID = @ID AND UPPER(mt.AfectarFiscal) = @AfectarFiscal AND mt.Clave = 'DIN.CB'
        END
      END
--Fin JGD 01Abril2011 Ticket 4260
    END


    -- Eliminar Origen Duplicados y Copiar % Deducibilidad
/*    DECLARE crTempOrigen CURSOR LOCAL FOR 
     SELECT DISTINCT OrigenModuloID, OrigenModulo, ObligacionFiscal
       FROM @FiscalD
      WHERE OrigenModuloID IS NOT NULL AND OrigenModulo IS NOT NULL AND ObligacionFiscal IS NOT NULL
    OPEN crTempOrigen
    FETCH NEXT FROM crTempOrigen INTO @OrigenModuloID, @OrigenModulo, @ObligacionFiscal
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF EXISTS(SELECT * 
                    FROM FiscalD d
                    JOIN Fiscal e ON e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus IN ('CONCLUIDO', 'PENDIENTE')
                   WHERE d.OrigenModuloID = @OrigenModuloID AND d.OrigenModulo = @OrigenModulo AND d.ObligacionFiscal = @ObligacionFiscal)
         DELETE @FiscalD
          WHERE OrigenModuloID = @OrigenModuloID AND OrigenModulo = @OrigenModulo AND ObligacionFiscal = @ObligacionFiscal
      END
      FETCH NEXT FROM crTempOrigen INTO @OrigenModuloID, @OrigenModulo, @ObligacionFiscal
    END
    CLOSE crTempOrigen
    DEALLOCATE crTempOrigen*/

    -- Ajusta al Factor del Movimiento (para considerar las notas de credito) y la naturaleza del modulo
    UPDATE @FiscalD --JGD 01Abril2011 Ticket 4260. Se Puso el ISNULL a la Funcion
       SET Importe = ABS(Importe)*ISNULL(dbo.fnFactorFiscal(mt.FactorFiscalEsp,mt.FactorFiscal,mt.Factor),1)*CASE WHEN @AfectarFiscal = 'Conciliacion' AND d.OrigenModulo IN ('COMS', 'GAS', 'CXP', 'NOM')  THEN -1.0 ELSE 1.0 END, --MEJORA1015
           OtrosImpuestos = OtrosImpuestos*dbo.fnFactorFiscal(mt.FactorFiscalEsp,mt.FactorFiscal,mt.Factor)*CASE WHEN @AfectarFiscal = 'Conciliacion' AND d.OrigenModulo IN ('COMS', 'GAS', 'CXP', 'NOM') THEN -1.0 ELSE 1.0 END --MEJORA1015
      FROM @FiscalD d
      JOIN Mov m ON m.Empresa = @Empresa AND m.Modulo = d.OrigenModulo AND m.ID = d.OrigenModuloID
      JOIN MovTipo mt ON mt.Modulo = m.Modulo AND mt.Mov  = m.Mov  


    UPDATE @FiscalD 
       SET Importe = Importe*CASE WHEN (@AfectarFiscal = 'Conciliacion' AND mt.Clave = 'CXC.CAP' AND amt.Clave = 'DIN.CH') OR (@AfectarFiscal = 'Conciliacion' AND mt.Clave = 'CXP.CAP' AND amt.Clave = 'DIN.D') THEN -1.0 ELSE 1.0 END,
           OtrosImpuestos = OtrosImpuestos*CASE WHEN (@AfectarFiscal = 'Conciliacion' AND mt.Clave = 'CXC.CAP' AND amt.Clave = 'DIN.CH') THEN -1.0 ELSE 1.0 END
      FROM @FiscalD d
      JOIN Mov m ON m.Empresa = @Empresa AND m.Modulo = d.OrigenModulo AND m.ID = d.OrigenModuloID
      JOIN MovTipo mt ON mt.Modulo = m.Modulo AND mt.Mov  = m.Mov  
      JOIN Mov ma ON ma.Empresa = @Empresa AND ma.Modulo = d.AplicaModulo AND ma.ID = d.AplicaID
      JOIN MovTipo amt ON amt.Modulo = ma.Modulo AND amt.Mov  = ma.Mov  

    IF NOT EXISTS(SELECT * FROM @FiscalD)
      DELETE Fiscal WHERE ID = @FiscalID
    ELSE BEGIN
      SELECT @Renglon = 0.0
      UPDATE @FiscalD SET @Renglon = Renglon = ISNULL(Renglon, 0.0) + @Renglon + 2048.0

      SELECT @FiscalMov = CASE @AfectarFiscal 
  			    WHEN 'Emision Acumulable' THEN FiscalEmisionAcumulable
  			    WHEN 'Endoso Acumulable'  THEN FiscalEndosoAcumulable
			    WHEN 'Flujo Acumulable'   THEN CASE @MovTipo WHEN 'DIN.AB' THEN FiscalFlujoAcumulable ELSE FiscalFlujoAcumulable END --JGD 01Abril2011 Ticket 4260
			    --WHEN 'Flujo Acumulable'   THEN FiscalFlujoAcumulable
			    WHEN 'Emision Deducible'  THEN FiscalEmisionDeducible
			    WHEN 'Endoso Deducible'   THEN FiscalEndosoDeducible
                WHEN 'Flujo Deducible'    THEN CASE @MovTipo WHEN 'DIN.CB' THEN FiscalFlujoDeducible ELSE FiscalFlujoDeducible END --JGD 01Abril2011 Ticket 4260
			    --WHEN 'Flujo Deducible'    THEN FiscalFlujoDeducible
			    WHEN 'Conciliacion'       THEN FiscalFlujoAcumulable
				WHEN '(Directo)'          THEN FiscalFlujoDeducible
			  END
        FROM EmpresaCfgMov
       WHERE Empresa = @Empresa

      INSERT Fiscal (
              Sucursal,  Empresa,  Usuario,  Mov,        Moneda,  TipoCambio,  FechaEmision,  Proyecto,  UEN,  Estatus,      OrigenTipo, Origen, OrigenID)
      VALUES (@Sucursal, @Empresa, @Usuario, @FiscalMov, @Moneda, @TipoCambio, @FechaEmision, @Proyecto, @UEN, 'SINAFECTAR', @Modulo,    @Mov,   @MovID)
      SELECT @FiscalID = SCOPE_IDENTITY()

      IF @AfectarFiscal = 'Conciliacion'
        INSERT FiscalD (
               ID,        Sucursal,  Renglon, ObligacionFiscal, Importe, OtrosImpuestos, Tasa, Excento, Deducible,	            OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie/*, DebeFiscal, HaberFiscal*/, Tipo, Retencion1,             Retencion2,             Retencion3, TipoImpuesto)  --MEJORA996 --MEJORA1019
        SELECT @FiscalID, @Sucursal, Renglon, ObligacionFiscal, Importe, OtrosImpuestos, Tasa, Excento, ISNULL(Deducible, 100), OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie/*, DebeFiscal, HaberFiscal*/, Tipo, ISNULL(Retencion1,0.0), ISNULL(Retencion2,0.0), ISNULL(Retencion3,0.0), TipoImpuesto   --MEJORA996 --MEJORA1019
          FROM @FiscalD
         WHERE ISNULL(Importe, 0.0) > 0.0
      ELSE
        INSERT FiscalD (
               ID,        Sucursal,  Renglon, ObligacionFiscal, Importe, OtrosImpuestos, Tasa, Excento, Deducible,		        OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie/*, DebeFiscal, HaberFiscal*/, Tipo, Retencion1,             Retencion2,             Retencion3, TipoImpuesto)  --MEJORA996 --MEJORA1019
        SELECT @FiscalID, @Sucursal, Renglon, ObligacionFiscal, Importe, OtrosImpuestos, Tasa, Excento, ISNULL(Deducible, 100), OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie/*, DebeFiscal, HaberFiscal*/, Tipo, ISNULL(Retencion1,0.0), ISNULL(Retencion2,0.0), ISNULL(Retencion3,0.0), TipoImpuesto   --MEJORA996 --MEJORA1019
          FROM @FiscalD
         WHERE NULLIF(Importe, 0.0) IS NOT NULL

      IF NOT EXISTS(SELECT * FROM FiscalD WHERE ID = @FiscalID)
        DELETE Fiscal WHERE ID = @FiscalID
      ELSE BEGIN
        EXEC spAfectar 'FIS', @FiscalID, 'AFECTAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
        BEGIN
          SELECT @FiscalMovID = MovID FROM Fiscal WHERE ID = @FiscalID
           EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'FIS', @FiscalID, @FiscalMov, @FiscalMovID, @Ok OUTPUT
        END
      END

      IF @AfectarFiscal = 'Conciliacion'
      BEGIN
        SELECT @FiscalMov = FiscalFlujoDeducible FROM EmpresaCfgMov WHERE Empresa = @Empresa

        INSERT Fiscal (
                Sucursal,  Empresa,  Usuario,  Mov,        Moneda,  TipoCambio,  FechaEmision,  Proyecto,  UEN,  Estatus,      OrigenTipo, Origen, OrigenID)
        VALUES (@Sucursal, @Empresa, @Usuario, @FiscalMov, @Moneda, @TipoCambio, @FechaEmision, @Proyecto, @UEN, 'SINAFECTAR', @Modulo,    @Mov,   @MovID)
        SELECT @FiscalID = SCOPE_IDENTITY()

        INSERT FiscalD (
               ID,        Sucursal,  Renglon, ObligacionFiscal, Importe,  OtrosImpuestos, Tasa, Excento, Deducible,	             OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie/*, DebeFiscal, HaberFiscal*/, Tipo, Retencion1,             Retencion2,             Retencion3, TipoImpuesto)  --MEJORA996  --MEJORA1019
        SELECT @FiscalID, @Sucursal, Renglon, ObligacionFiscal, -Importe, OtrosImpuestos, Tasa, Excento, ISNULL(Deducible, 100), OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie/*, DebeFiscal, HaberFiscal*/, Tipo, ISNULL(Retencion1,0.0), ISNULL(Retencion2,0.0), ISNULL(Retencion3,0.0), TipoImpuesto   --MEJORA996 --MEJORA1019
          FROM @FiscalD
         WHERE ISNULL(Importe, 0.0) < 0.0

        IF NOT EXISTS(SELECT * FROM FiscalD WHERE ID = @FiscalID)
          DELETE Fiscal WHERE ID = @FiscalID
        ELSE BEGIN
          EXEC spAfectar 'FIS', @FiscalID, 'AFECTAR', @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
          IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
          BEGIN
            SELECT @FiscalMovID = MovID FROM Fiscal WHERE ID = @FiscalID
             EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'FIS', @FiscalID, @FiscalMov, @FiscalMovID, @Ok OUTPUT
          END
        END
      END
    END
  END

  RETURN
END
GO

/**************** spFiscalSugerirCorteHasta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFiscalSugerirCorteHasta') and type = 'P') drop procedure dbo.spFiscalSugerirCorteHasta
GO
CREATE PROCEDURE spFiscalSugerirCorteHasta
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Usuario		char(10),
		   @Desde		datetime,
		   @Hasta		datetime,
		   @Mov			varchar(20),
		   @Conteo		int		OUTPUT,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @ObligacionFiscal	varchar(50),
    @Acreedor		varchar(10),
    @Condicion		varchar(50),
    @Vencimiento	datetime,
    @TotalMN		money,
    @Moneda		varchar(10),
    @TipoCambio		float,
    @FiscalID		int

  DECLARE
    @CorteFiscal        TABLE (ObligacionFiscal varchar(50) NULL, Importe money, OtrosImpuestos money, Tasa float NULL, Excento bit NULL, Deducible float NULL, OrigenModulo varchar(5), OrigenModuloID	int, Contacto varchar(10), ContactoTipo	varchar(20), AFArticulo	varchar(20), AFSerie varchar(20), Acreedor varchar(10) NULL, Condicion varchar(50) NULL)

  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda


  INSERT @CorteFiscal (
         ObligacionFiscal,   Importe,                               OtrosImpuestos,                               Tasa,   Excento,   Deducible,   OrigenModulo,   OrigenModuloID,   Contacto,   ContactoTipo,   AFArticulo,   AFSerie,   Acreedor,                                   Condicion)
  SELECT d.ObligacionFiscal, SUM(d.Importe*e.TipoCambio*dbo.fnFactorFiscal(mt.FactorFiscalEsp,mt.FactorFiscal,mt.Factor)), SUM(d.OtrosImpuestos*e.TipoCambio*dbo.fnFactorFiscal(mt.FactorFiscalEsp,mt.FactorFiscal,mt.Factor)), d.Tasa, d.Excento, d.Deducible, d.OrigenModulo, d.OrigenModuloID, d.Contacto, d.ContactoTipo, d.AFArticulo, d.AFSerie, 'Acreedor' = NULLIF(RTRIM(o.Acreedor), ''), 'Condicion' = NULLIF(RTRIM(o.Condicion), '') --MEJORA1015
    FROM FiscalD d	
    JOIN Fiscal e ON e.ID = d.ID
    JOIN MovTipo mt ON mt.Modulo = 'FIS' AND mt.Mov = e.Mov
    LEFT OUTER JOIN ObligacionFiscal o ON o.ObligacionFiscal = d.ObligacionFiscal
   WHERE e.Empresa = @Empresa AND e.Estatus = 'CONCLUIDO' AND e.FechaEmision BETWEEN @Desde AND @Hasta
   GROUP BY d.ObligacionFiscal, d.Tasa, d.Excento, d.Deducible, d.OrigenModulo, d.OrigenModuloID, d.Contacto, d.ContactoTipo, d.AFArticulo, d.AFSerie, NULLIF(RTRIM(o.Acreedor), ''), NULLIF(RTRIM(o.Condicion), '')
  HAVING ISNULL(ROUND(SUM(d.Neto*e.TipoCambio*dbo.fnFactorFiscal(mt.FactorFiscalEsp,mt.FactorFiscal,mt.Factor)), 4), 0.0) <> 0.0 --MEJORA1015

  UPDATE @CorteFiscal 
     SET Importe = -Importe, OtrosImpuestos = -OtrosImpuestos 
    FROM @CorteFiscal c JOIN ObligacionFiscal p ON c.ObligacionFiscal = p.ObligacionFiscal
   WHERE p.Tipo IN ('Retencion 1', 'Retencion 2', 'Retencion 2')

  DECLARE crAcreedorFiscal CURSOR LOCAL FOR 
   SELECT Acreedor, Condicion, ObligacionFiscal
     FROM @CorteFiscal
    GROUP BY Acreedor, Condicion, ObligacionFiscal
  OPEN crAcreedorFiscal
  FETCH NEXT FROM crAcreedorFiscal INTO @Acreedor, @Condicion, @ObligacionFiscal
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spCalcularVencimiento 'CXP', @Empresa, @Acreedor, @Condicion, @Hasta, @Vencimiento OUTPUT, NULL, @Ok OUTPUT
      INSERT Fiscal (
              Sucursal,  Empresa,  Usuario,  Mov,  Moneda,  TipoCambio,  FechaEmision, Concepto,          Acreedor,  Condicion,  Vencimiento,  Estatus,      OrigenTipo)
      VALUES (@Sucursal, @Empresa, @Usuario, @Mov, @Moneda, @TipoCambio, @Hasta,       @ObligacionFiscal, @Acreedor, @Condicion, @Vencimiento, 'CONFIRMAR', 'FIS/CORTE')
      SELECT @FiscalID = SCOPE_IDENTITY()

      INSERT FiscalD (
             ID,        ObligacionFiscal,  Importe,      OtrosImpuestos,      Tasa, Excento, Deducible,		       OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie, Renglon) 
      SELECT @FiscalID, @ObligacionFiscal, SUM(Importe), SUM(OtrosImpuestos), Tasa, Excento, ISNULL(Deducible, 100.0), OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie, ROW_NUMBER() OVER(ORDER BY ContactoTipo, Contacto, OrigenModulo, OrigenModuloID)
        FROM @CorteFiscal
       WHERE Acreedor = @Acreedor AND ObligacionFiscal = @ObligacionFiscal/*AND ISNULL(TotalMN, 0.0) < 0.0*/
       GROUP BY Tasa, Excento, ISNULL(Deducible, 100.0), OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie
       ORDER BY Tasa, Excento, ISNULL(Deducible, 100.0), OrigenModulo, OrigenModuloID, Contacto, ContactoTipo, AFArticulo, AFSerie
      IF @@ROWCOUNT = 0
        DELETE Fiscal WHERE ID = @FiscalID
      ELSE
        SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crAcreedorFiscal INTO @Acreedor, @Condicion, @ObligacionFiscal
  END
  CLOSE crAcreedorFiscal
  DEALLOCATE crAcreedorFiscal

  RETURN
END
GO

-- spFiscalSugerirCorte 'DEMO', 0, 'DEMO', '1/2/2008', '29/2/2008'
/**************** spFiscalSugerirCorte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFiscalSugerirCorte') and type = 'P') drop procedure dbo.spFiscalSugerirCorte
GO
CREATE PROCEDURE spFiscalSugerirCorte
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Usuario		char(10),
		   @FechaD		datetime,
		   @FechaA		datetime
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @DeclaracionMov	varchar(20),
    @ComplementariaMov	varchar(20),
    @Ok			int,
    @OkRef		varchar(255),
    @Conteo		int,
    @Desde		datetime,
    @Hasta		datetime

  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0

  BEGIN TRANSACTION

  SELECT @DeclaracionMov = FiscalDeclaracion,
         @ComplementariaMov = FiscalComplementaria
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
  
  IF EXISTS (SELECT * FROM Fiscal WHERE Mov IN (@DeclaracionMov, @ComplementariaMov) AND Estatus = 'CONFIRMAR')
    SELECT @OK = 60440


  IF EXISTS (SELECT * FROM Fiscal WHERE Mov = @DeclaracionMov AND Estatus = 'CONCLUIDO' AND FechaEmision BETWEEN @FechaD AND @FechaA )
    SELECT @Ok = 60450

  IF @OK IS NULL
  BEGIN
    -- Complementarias
    SELECT @Desde = 0, @Hasta = DATEADD(day, -1, @FechaD)
    EXEC spFiscalSugerirCorteHasta @Empresa, @Sucursal, @Usuario, @Desde, @Hasta, @ComplementariaMov, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    -- Declaracion
    SELECT @Desde = @FechaD, @Hasta = @FechaA
    EXEC spFiscalSugerirCorteHasta @Empresa, @Sucursal, @Usuario, @Desde, @Hasta, @DeclaracionMov, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END


  IF @Ok IN (NULL, 80300)
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+ ' Movimientos (por Confirmar)'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  END

  RETURN
END
GO

-- spFiscalIncentivoInv2007 'DEMO'
/**************** spFiscalIncentivoInv2007 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFiscalIncentivoInv2007') and type = 'P') drop procedure dbo.spFiscalIncentivoInv2007
GO
CREATE PROCEDURE spFiscalIncentivoInv2007
		    @Empresa		char(5)
--//WITH ENCRYPTION
AS BEGIN
  CREATE TABLE #Reporte (
	ID		int		NOT NULL IDENTITY(1,1) PRIMARY KEY,

	Modulo		varchar(5)	NULL,
	ModuloID	int		NULL,
	Mov		varchar(20)	NULL,
	MovID		varchar(20)	NULL,
	FechaEmision	datetime	NULL,
	Proveedor	varchar(10)	NULL,
	Cliente		varchar(10)	NULL,
	Articulo	varchar(20)	NULL,
	Cantidad	float		NULL,
	Unidad		varchar(50)	NULL,

	CompraMN	money		NULL,
	VentaMN		money		NULL,
	CxpMN		money		NULL)

  -- Compras
  INSERT #Reporte (
         Modulo, ModuloID, Mov,   MovID,   FechaEmision,   Proveedor,   Articulo,   Cantidad,   Unidad,   CompraMN)
  SELECT 'COMS', c.ID,     c.Mov, c.MovID, c.FechaEmision, c.Proveedor, c.Articulo, c.Cantidad, c.Unidad, SUM(c.SubTotal*c.TipoCambio)
    FROM CompraTCalc c
    JOIN MovTipo mt ON mt.Modulo = 'COMS' AND mt.Mov = c.Mov AND mt.Clave IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI')
   WHERE c.Empresa = @Empresa AND c.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND YEAR(c.FechaEmision) = 2007 AND MONTH(c.FechaEmision) BETWEEN 11 AND 12
   GROUP BY c.FechaEmision, c.ID, c.Mov, c.MovID, c.Proveedor, c.Articulo, c.Cantidad, c.Unidad
   ORDER BY c.FechaEmision, c.ID, c.Mov, c.MovID, c.Proveedor, c.Articulo, c.Cantidad, c.Unidad

  -- Ventas
  INSERT #Reporte (
         Modulo, ModuloID, Mov,   MovID,   FechaEmision,   Cliente,   Articulo,   Cantidad,   Unidad,   VentaMN)
  SELECT 'VTAS', c.ID,     c.Mov, c.MovID, c.FechaEmision, c.Cliente, c.Articulo, c.Cantidad, c.Unidad, SUM(c.SubTotal*dbo.fnFactorFiscal(mt.FactorFiscalEsp,mt.FactorFiscal,mt.Factor)*c.TipoCambio) --MEJORA1015
    FROM VentaTCalc c
    JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = c.Mov AND mt.Clave IN ('VTAS.F','VTAS.FAR', 'VTAS.D', 'VTAS.DF', 'VTAS.B')
    JOIN #Reporte r ON r.Articulo = c.Articulo AND r.Modulo = 'COMS'
   WHERE c.Empresa = @Empresa AND c.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND YEAR(c.FechaEmision) = 2007 AND MONTH(c.FechaEmision) BETWEEN 11 AND 12
   GROUP BY c.FechaEmision, c.ID, c.Mov, c.MovID, c.Cliente, c.Articulo, c.Cantidad, c.Unidad
   ORDER BY c.FechaEmision, c.ID, c.Mov, c.MovID, c.Cliente, c.Articulo, c.Cantidad, c.Unidad

  -- Cxp
  UPDATE #Reporte
     SET CxpMN = dbo.fnR3(c.Importe+ISNULL(c.Impuestos, 0.0)-ISNULL(c.Retencion, 0.0), c.Saldo, c.Importe)*c.TipoCambio
    FROM #Reporte r
    JOIN Cxp c ON c.Empresa = @Empresa AND c.Estatus IN ('PENDIENTE', 'CONCLUIDO') 
   WHERE r.Mov = c.Mov AND r.MovID = c.MovID AND r.Modulo = 'COMS'

/*  INSERT #Reporte (
         Modulo, ModuloID, Mov,   MovID,   FechaEmision,   Proveedor,  CxpMN)
  SELECT 'CXP', c.ID,      c.Mov, c.MovID, c.FechaEmision, c.Proveedor, SUM(c.Saldo*c.TipoCambio)
    FROM Cxp c
    JOIN #Reporte r ON r.Mov = c.Mov AND r.MovID = c.MovID AND r.Modulo = 'COMS'
   WHERE c.Empresa = @Empresa AND c.Estatus IN ('PENDIENTE', 'CONCLUIDO') 
   GROUP BY c.FechaEmision, c.ID, c.Mov, c.MovID, c.Proveedor
   ORDER BY c.FechaEmision, c.ID, c.Mov, c.MovID, c.Proveedor
*/

  SELECT r.ID, r.Modulo, r.Mov, r.MovID, r.FechaEmision, r.Proveedor, 'ProveedorNombre' = p.Nombre, 'ProveedorRFC' = p.RFC, r.Cliente, 'ClienteNombre' = c.Nombre, 'ClienteRFC' = c.RFC, r.Articulo, 'ArticuloDescripcion' = a.Descripcion1, r.Cantidad, r.Unidad, r.CompraMN, r.VentaMN, r.CxpMN
    FROM #Reporte r
    LEFT OUTER JOIN Cte c ON c.Cliente = r.Cliente
    LEFT OUTER JOIN Prov p ON p.Proveedor = r.Proveedor
    LEFT OUTER JOIN Art a ON a.Articulo = r.Articulo
   ORDER BY r.ID

  RETURN
END
GO

PRINT "******************* SP Fiscal ******************"
