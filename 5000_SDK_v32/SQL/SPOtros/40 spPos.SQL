SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/* SP Posicion  */

/**************** spPosAgregarMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPosAgregarMov') and type = 'P') drop procedure dbo.spPosAgregarMov
GO             
CREATE PROCEDURE spPosAgregarMov
		   @Estacion		int,
		   @Orden		int,
		   @Modulo		char(5),
		   @Cuenta		char(20),
		   @Nombre		char(100),
		   @Mov			char(20),
		   @MovID		varchar(20),
	           @Referencia		char(50),
		   @Observaciones	char(100),
		   @FechaEmision	datetime,
		   @Vencimiento		datetime,
		   @Hoy			datetime,
		   @Intervalo		int,
		   @Saldo		money,

   		   @SumaVigente1	money OUTPUT,
   		   @SumaVigente2	money OUTPUT,
   		   @SumaVigente3	money OUTPUT,
   		   @SumaVigente4	money OUTPUT,
   		   @SumaVigente5	money OUTPUT,
   		   @SumaVencido1	money OUTPUT,
   		   @SumaVencido2	money OUTPUT,
   		   @SumaVencido3	money OUTPUT,
   		   @SumaVencido4	money OUTPUT,
   		   @SumaVencido5	money OUTPUT,

   		   @TotalVigente1	money OUTPUT,
   		   @TotalVigente2	money OUTPUT,
   		   @TotalVigente3	money OUTPUT,
   		   @TotalVigente4	money OUTPUT,
   		   @TotalVigente5	money OUTPUT,
   		   @TotalVencido1	money OUTPUT,
   		   @TotalVencido2	money OUTPUT,
   		   @TotalVencido3	money OUTPUT,
   		   @TotalVencido4	money OUTPUT,
   		   @TotalVencido5	money OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Negativos	bit,
    @Dias	int,
    @Plazo	int,
    @Vigente	money,
    @Vencido	money,
    @Vigente5	money,
    @Vigente4	money,
    @Vigente3	money,
    @Vigente2	money,
    @Vigente1	money,
    @Vencido1	money,
    @Vencido2	money,
    @Vencido3	money,
    @Vencido4	money,
    @Vencido5	money

  EXEC spExtraerFecha @Vencimiento OUTPUT
  SELECT @Dias = ISNULL(datediff(day, @Vencimiento, @Hoy), 0), @Plazo = 0, @Negativos = 0,
         @Vigente5 = NULL, @Vigente4 = NULL, @Vigente3 = NULL, @Vigente2 = NULL, @Vigente1 = NULL, 
         @Vencido5 = NULL, @Vencido4 = NULL, @Vencido3 = NULL, @Vencido2 = NULL, @Vencido1 = NULL

  IF @Dias < 0 SELECT @Dias = -@Dias, @Negativos = 1 

  IF @Dias > 0 
  BEGIN
    IF @Dias BETWEEN 0              AND @Intervalo-1     SELECT @Plazo = 1 ELSE
    IF @Dias BETWEEN @Intervalo     AND (@Intervalo*2)-1 SELECT @Plazo = 2 ELSE
    IF @Dias BETWEEN (@Intervalo*2) AND (@Intervalo*3)-1 SELECT @Plazo = 3 ELSE 
    IF @Dias BETWEEN (@Intervalo*3) AND (@Intervalo*4)-1 SELECT @Plazo = 4 
    ELSE SELECT @Plazo = 5
  END

  IF @Negativos = 1 SELECT @Plazo = -@Plazo

  IF @Plazo <=-5 SELECT @Vigente5 = @Saldo ELSE
  IF @Plazo = -4 SELECT @Vigente4 = @Saldo ELSE
  IF @Plazo = -3 SELECT @Vigente3 = @Saldo ELSE
  IF @Plazo = -2 SELECT @Vigente2 = @Saldo ELSE
  IF @Plazo IN (-1,0) SELECT @Vigente1 = @Saldo ELSE
  IF @Plazo =  1 SELECT @Vencido1 = @Saldo ELSE
  IF @Plazo =  2 SELECT @Vencido2 = @Saldo ELSE
  IF @Plazo =  3 SELECT @Vencido3 = @Saldo ELSE
  IF @Plazo =  4 SELECT @Vencido4 = @Saldo ELSE
  IF @Plazo >= 5 SELECT @Vencido5 = @Saldo 

  SELECT @Vigente = @Vigente1 + @Vigente2 + @Vigente3 + @Vigente4 + @Vigente5,
         @Vencido = @Vencido1 + @Vencido2 + @Vencido3 + @Vencido4 + @Vencido5

  SELECT @SumaVigente5  = @SumaVigente5  + ISNULL(@Vigente5, 0), @SumaVigente4  = @SumaVigente4  + ISNULL(@Vigente4, 0), @SumaVigente3  = @SumaVigente3  + ISNULL(@Vigente3, 0), @SumaVigente2  = @SumaVigente2  + ISNULL(@Vigente2, 0), @SumaVigente1  = @SumaVigente1  + ISNULL(@Vigente1, 0), 
         @TotalVigente5 = @TotalVigente5 + ISNULL(@Vigente5, 0), @TotalVigente4 = @TotalVigente4 + ISNULL(@Vigente4, 0), @TotalVigente3 = @TotalVigente3 + ISNULL(@Vigente3, 0), @TotalVigente2 = @TotalVigente2 + ISNULL(@Vigente2, 0), @TotalVigente1 = @TotalVigente1 + ISNULL(@Vigente1, 0), 
         @SumaVencido5  = @SumaVencido5  + ISNULL(@Vencido5, 0), @SumaVencido4  = @SumaVencido4  + ISNULL(@Vencido4, 0), @SumaVencido3  = @SumaVencido3  + ISNULL(@Vencido3, 0), @SumaVencido2  = @SumaVencido2  + ISNULL(@Vencido2, 0), @SumaVencido1  = @SumaVencido1  + ISNULL(@Vencido1, 0),
         @TotalVencido5 = @TotalVencido5 + ISNULL(@Vencido5, 0), @TotalVencido4 = @TotalVencido4 + ISNULL(@Vencido4, 0), @TotalVencido3 = @TotalVencido3 + ISNULL(@Vencido3, 0), @TotalVencido2 = @TotalVencido2 + ISNULL(@Vencido2, 0), @TotalVencido1 = @TotalVencido1 + ISNULL(@Vencido1, 0)

  INSERT INTO VerPos (Estacion,  Orden,  Modulo,  Cuenta,  Nombre,  Mov,  MovID,  Referencia,  Observaciones,  FechaEmision,  Vencimiento,  Dias,  Vigente,  Vigente5,  Vigente4,  Vigente3,  Vigente2,  Vigente1,  Vencido,  Vencido1,  Vencido2,  Vencido3,  Vencido4,  Vencido5)
                 VALUES (@Estacion, @Orden, @Modulo, @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @Dias, @Vigente, @Vigente5, @Vigente4, @Vigente3, @Vigente2, @Vigente1, @Vencido, @Vencido1, @Vencido2, @Vencido3, @Vencido4, @Vencido5)
  RETURN
END
GO


/**************** spPosAgregarTotal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPosAgregarTotal') and type = 'P') drop procedure dbo.spPosAgregarTotal
GO             
CREATE PROCEDURE spPosAgregarTotal
		   @Estacion	int,
 		   @Orden	int,
		   @Modulo	char(5),

		   @Disponible	money,
   		   @Vigente1	money,
   		   @Vigente2	money,
   		   @Vigente3	money,
   		   @Vigente4	money,
   		   @Vigente5	money,
   		   @Vencido1	money,
   		   @Vencido2	money,
   		   @Vencido3	money,
   		   @Vencido4	money,
   		   @Vencido5	money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Vigente	money,
    @Vencido	money,
    @Cuenta	char(20)

  IF @Modulo = 'zz' SELECT @Cuenta = 'Total' ELSE SELECT @Cuenta = NULL
  SELECT @Vigente = @Vigente1 + @Vigente2 + @Vigente3 + @Vigente4 + @Vigente5,
         @Vencido = @Vencido1 + @Vencido2 + @Vencido3 + @Vencido4 + @Vencido5
  INSERT INTO VerPos (Estacion,  Orden,  Periodo, Modulo,  Cuenta,  Disponible,             Vigente,             Vigente5,             Vigente4,             Vigente3,             Vigente2,             Vigente1,             Vencido,             Vencido1,             Vencido2,             Vencido3,             Vencido4,             Vencido5)
              VALUES (@Estacion, @Orden, 999,     @Modulo, @Cuenta, NULLIF(@Disponible, 0), NULLIF(@Vigente, 0), NULLIF(@Vigente5, 0), NULLIF(@Vigente4, 0), NULLIF(@Vigente3, 0), NULLIF(@Vigente2, 0), NULLIF(@Vigente1, 0), NULLIF(@Vencido, 0), NULLIF(@Vencido1, 0), NULLIF(@Vencido2, 0), NULLIF(@Vencido3, 0), NULLIF(@Vencido4, 0), NULLIF(@Vencido5, 0))
END
GO

-- Ventas Pendientes
-- Compras Pendientes
-- Valor del Inventario
-- Intereses Moratorios Cxc/Cxp  ??

-- Simular Ventas  	          ($xxx,xxx.xx periodicidad)
-- Simular Compras 	          ($xxx,xxx.xx periodicidad)
-- Simular Gastos  	          ($xxx,xxx.xx periodicidad)
-- Aumentar/Disminuir Cobros   	  ($xxx,xxx.xx dd/mm/aaaa)
-- Aumentar/Disminuir Pagos    	  ($xxx,xxx.xx dd/mm/aaaa)
-- Aumentar/Disminuir Dinero   	  ($xxx,xxx.xx dd/mm/aaaa)
-- Aumentar/Disminuir Inventarios ($xxx,xxx.xx dd/mm/aaaa)
 
/**************** spGenerarPos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarPos') and type = 'P') drop procedure dbo.spGenerarPos
GO             
CREATE PROCEDURE spGenerarPos
		    @Empresa		char(5),
		    @Estacion		int,
		    @Moneda		char(10),             -- Por Moneda, Reexpresado en la Moneda
		    @MonedaVer		char(20),
                    @SimularMeses	int,
	            @Intervalo		int	 = 7,
		    @ConDinero		char(2)  = 'SI',
		    @ConInv		char(2)  = 'SI',
		    @ConCxc		char(2)  = 'SI',
		    @ConCxp		char(2)  = 'SI',
		    @ConGastos		char(2)  = 'SI',
		    @ConVentas		char(2)  = 'SI',
		    @ConCompras		char(2)  = 'SI',
                    @Nivel		char(20) = 'MOVIMIENTO'   -- Movimiento, Cuenta, Modulo
--//WITH ENCRYPTION
AS BEGIN
  SET nocount ON
  DECLARE 
    @Ok			int,
    @OkRef		varchar(255),
    @Rama 		char(5),
    @Mov		char(20), 
    @MovID		varchar(20), 
    @MovTipo		char(20),
    @MonedaEspecifica	char(10),
    @Cuenta		char(20),
    @Referencia		char(50),
    @Periodicidad	char(50),	
    @Nombre		char(100),
    @Observaciones	char(100),
    @FechaEmision	datetime,
    @Vencimiento	datetime,
    @SimulaVencimiento  datetime,
    @TipoCambio		float,
    @SumaDisponible	money,
    @SumaVigente5	money,
    @SumaVigente4	money,
    @SumaVigente3	money,
    @SumaVigente2	money,
    @SumaVigente1	money,
    @SumaVencido1	money,
    @SumaVencido2	money,
    @SumaVencido3	money,
    @SumaVencido4	money,
    @SumaVencido5	money,
    @TotalVigente5	money,
    @TotalVigente4	money,
    @TotalVigente3	money,
    @TotalVigente2	money,
    @TotalVigente1	money,
    @TotalVencido1	money,
    @TotalVencido2	money,
    @TotalVencido3	money,
    @TotalVencido4	money,
    @TotalVencido5	money,
    @AcumVigente	money,
    @AcumVigente5	money,
    @AcumVigente4	money,
    @AcumVigente3	money,
    @AcumVigente2	money,
    @AcumVigente1	money,
    @AcumVencido	money,
    @AcumVencido1	money,
    @AcumVencido2	money,
    @AcumVencido3	money,
    @AcumVencido4	money,
    @AcumVencido5	money,
    @Saldo		money,
    @Hoy		datetime

  SELECT @ConDinero = UPPER(@ConDinero), @ConCxc = UPPER(@ConCxc), @ConCxp = UPPER(@ConCxp), @ConGastos = UPPER(@ConGastos), 
         @ConInv = UPPER(@ConInv), @ConVentas = UPPER(@ConVentas), @ConCompras = UPPER(@ConCompras), @Nivel = UPPER(@Nivel),
         @Moneda = NULLIF(RTRIM(@Moneda), ''), @Hoy = GETDATE(), @TipoCambio = 1.0

  SELECT @SumaDisponible = 0.0
  SELECT @TotalVigente5 = 0.0, @TotalVigente4 = 0.0, @TotalVigente3 = 0.0, @TotalVigente2 = 0.0, @TotalVigente1 = 0.0, 
         @TotalVencido5 = 0.0, @TotalVencido4 = 0.0, @TotalVencido3 = 0.0, @TotalVencido2 = 0.0, @TotalVencido1 = 0.0
  IF UPPER(@MonedaVer) = 'MONEDA ESPECIFICA' SELECT @MonedaEspecifica = @Moneda ELSE SELECT @MonedaEspecifica = NULL

  EXEC spExtraerFecha @Hoy OUTPUT
  SELECT @SimulaVencimiento = DATEADD(mm, @SimularMeses, @Hoy)

  DELETE VerPos WHERE Estacion = @Estacion

  IF @MonedaEspecifica IS NULL
    SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda

  IF @ConDinero = 'SI'
  BEGIN
    SELECT @SumaVigente5 = 0.0, @SumaVigente4 = 0.0, @SumaVigente3 = 0.0, @SumaVigente2 = 0.0, @SumaVigente1 = 0.0, 
           @SumaVencido5 = 0.0, @SumaVencido4 = 0.0, @SumaVencido3 = 0.0, @SumaVencido2 = 0.0, @SumaVencido1 = 0.0

    IF @MonedaEspecifica IS NOT NULL
      DECLARE crDineroSaldo CURSOR FOR
       SELECT s.CtaDinero, c.Descripcion, SUM(s.Saldo)
         FROM DineroSaldo s, CtaDinero c
        WHERE s.CtaDinero = c.CtaDinero AND s.Empresa = @Empresa AND s.Moneda = @MonedaEspecifica
        GROUP BY s.CtaDinero, c.Descripcion
        ORDER BY s.CtaDinero, c.Descripcion
    ELSE
      DECLARE crDineroSaldo CURSOR FOR
       SELECT s.CtaDinero, c.Descripcion, CONVERT(money, SUM(s.Saldo*Mon.TipoCambio)/@TipoCambio)
         FROM DineroSaldo s, CtaDinero c, Mon
        WHERE s.CtaDinero = c.CtaDinero AND s.Empresa = @Empresa AND s.Moneda = Mon.Moneda
        GROUP BY s.CtaDinero, c.Descripcion
        ORDER BY s.CtaDinero, c.Descripcion

    OPEN crDineroSaldo
    FETCH NEXT FROM crDineroSaldo INTO @Cuenta, @Nombre, @Saldo
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2
      BEGIN
        INSERT INTO VerPos (Estacion,  Orden, Modulo, Cuenta,  Nombre,  Disponible)
                       VALUES (@Estacion, 1,     'DIN',  @Cuenta, @Nombre, @Saldo)
        SELECT @SumaDisponible = @SumaDisponible + ISNULL(@Saldo, 0)
      END
    FETCH NEXT FROM crDineroSaldo INTO @Cuenta, @Nombre, @Saldo
    END
    CLOSE crDineroSaldo
    DEALLOCATE crDineroSaldo

    IF @MonedaEspecifica IS NOT NULL
      DECLARE crDineroPendientes CURSOR FOR 
       SELECT p.CtaDinero, c.Descripcion, p.Mov, p.MovID, p.Referencia, p.Observaciones, p.FechaEmision, p.FechaProgramada, m.Clave, ISNULL(p.Saldo, 0.0) 
         FROM Dinero p
         LEFT OUTER JOIN CtaDinero c ON p.CtaDinero = c.CtaDinero           
         JOIN MovTipo m ON p.Mov = m.Mov 
        WHERE m.Modulo = 'DIN'
          AND m.Clave IN ('DIN.I', 'DIN.SD', 'DIN.E', 'DIN.SCH')
          AND p.Empresa = @Empresa
          AND p.Estatus = 'PENDIENTE'
          AND p.Moneda = @MonedaEspecifica
    ELSE
      DECLARE crDineroPendientes CURSOR FOR 
       SELECT p.CtaDinero, c.Descripcion, p.Mov, p.MovID, p.Referencia, p.Observaciones, p.FechaEmision, p.FechaProgramada, m.Clave, CONVERT(money, (ISNULL(p.Saldo, 0.0)*Mon.TipoCambio)/@TipoCambio)
         FROM Dinero p
         LEFT OUTER JOIN CtaDinero c ON p.CtaDinero = c.CtaDinero           
         JOIN MovTipo m ON p.Mov = m.Mov 
         JOIN Mon ON p.Moneda = Mon.Moneda
        WHERE m.Modulo = 'DIN'
          AND m.Clave IN ('DIN.I', 'DIN.SD', 'DIN.E', 'DIN.SCH')
          AND p.Empresa = @Empresa
          AND p.Estatus = 'PENDIENTE'

    OPEN crDineroPendientes
    FETCH NEXT FROM crDineroPendientes INTO @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @MovTipo, @Saldo
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @MovTipo IN ('DIN.E', 'DIN.SCH') SELECT @Saldo = -@Saldo
        EXEC spPosAgregarMov @Estacion, 1, 'DIN', @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @Hoy, @Intervalo, @Saldo,
   	                        @SumaVigente1  OUTPUT, @SumaVigente2  OUTPUT, @SumaVigente3  OUTPUT, @SumaVigente4  OUTPUT, @SumaVigente5  OUTPUT,
                                @SumaVencido1  OUTPUT, @SumaVencido2  OUTPUT, @SumaVencido3  OUTPUT, @SumaVencido4  OUTPUT, @SumaVencido5  OUTPUT,
   	                        @TotalVigente1 OUTPUT, @TotalVigente2 OUTPUT, @TotalVigente3 OUTPUT, @TotalVigente4 OUTPUT, @TotalVigente5 OUTPUT,
                                @TotalVencido1 OUTPUT, @TotalVencido2 OUTPUT, @TotalVencido3 OUTPUT, @TotalVencido4 OUTPUT, @TotalVencido5 OUTPUT
      END
      FETCH NEXT FROM crDineroPendientes INTO @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @MovTipo, @Saldo
    END
    CLOSE crDineroPendientes
    DEALLOCATE crDineroPendientes

    EXEC spPosAgregarTotal @Estacion, 1, 'DIN', @SumaDisponible,
 	  	           @SumaVigente1, @SumaVigente2, @SumaVigente3, @SumaVigente4, @SumaVigente5,
   		           @SumaVencido1, @SumaVencido2, @SumaVencido3, @SumaVencido4, @SumaVencido5
  END
  IF @ConInv = 'SI'
  BEGIN
    SELECT @Saldo = 0.0
    IF @MonedaEspecifica IS NOT NULL
      SELECT @Saldo = ISNULL(SUM(Saldo), 0) 
        FROM SaldoU s
       WHERE s.Empresa = @Empresa 
         AND s.Rama = 'INV'
         AND s.Moneda = @MonedaEspecifica
    ELSE
      SELECT @Saldo = SUM(ISNULL(s.Saldo, 0)*Mon.TipoCambio)/@TipoCambio
        FROM SaldoU s, Mon
       WHERE s.Empresa = @Empresa 
         AND s.Rama = 'INV'
         AND s.Moneda = Mon.Moneda

    EXEC spPosAgregarTotal @Estacion, 2, 'INV', @Saldo,
 	  	           NULL, NULL, NULL, NULL, NULL,
   		           NULL, NULL, NULL, NULL, NULL

    SELECT @SumaDisponible = @SumaDisponible + @Saldo
  END

  IF @ConCxc = 'SI'
  BEGIN
    SELECT @SumaVigente5 = 0.0, @SumaVigente4 = 0.0, @SumaVigente3 = 0.0, @SumaVigente2 = 0.0, @SumaVigente1 = 0.0, 
           @SumaVencido5 = 0.0, @SumaVencido4 = 0.0, @SumaVencido3 = 0.0, @SumaVencido2 = 0.0, @SumaVencido1 = 0.0 

    IF @MonedaEspecifica IS NOT NULL
      DECLARE crCxcPendientes CURSOR FOR 
       SELECT p.Cliente, Cte.Nombre, p.Mov, p.MovID, p.Referencia, p.Observaciones, p.FechaEmision, p.Vencimiento, m.Clave, ISNULL(p.Saldo*m.Factor, 0.0)
         FROM Cxc p, Cte, MovTipo m
        WHERE p.Empresa = @Empresa
          AND p.Estatus = 'PENDIENTE'
          AND p.Moneda  = @MonedaEspecifica
          AND p.Cliente = Cte.Cliente
          AND p.Mov     = m.Mov AND m.Modulo = 'CXC'
          AND m.Clave NOT IN('CXC.SD','CXC.SCH')
    ELSE
      DECLARE crCxcPendientes CURSOR FOR 
       SELECT p.Cliente, Cte.Nombre, p.Mov, p.MovID, p.Referencia, p.Observaciones, p.FechaEmision, p.Vencimiento, m.Clave, CONVERT(money, (ISNULL(p.Saldo*m.Factor, 0.0)*Mon.TipoCambio)/@TipoCambio)
         FROM Cxc p, Cte, MovTipo m, Mon
        WHERE p.Empresa = @Empresa
          AND p.Estatus = 'PENDIENTE'
          AND p.Moneda  = Mon.Moneda
          AND p.Cliente = Cte.Cliente
          AND p.Mov     = m.Mov AND m.Modulo = 'CXC'
          AND m.Clave NOT IN('CXC.SD','CXC.SCH')


    OPEN crCxcPendientes
    FETCH NEXT FROM crCxcPendientes INTO @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @MovTipo, @Saldo
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @MovTipo IN ('CXC.NC','CXC.DAC','CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP') SELECT @Saldo = -@Saldo
        EXEC spPosAgregarMov @Estacion, 3, 'CXC', @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @Hoy, @Intervalo, @Saldo,
   	                        @SumaVigente1  OUTPUT, @SumaVigente2  OUTPUT, @SumaVigente3  OUTPUT, @SumaVigente4  OUTPUT, @SumaVigente5  OUTPUT,
                                @SumaVencido1  OUTPUT, @SumaVencido2  OUTPUT, @SumaVencido3  OUTPUT, @SumaVencido4  OUTPUT, @SumaVencido5  OUTPUT,
   	                        @TotalVigente1 OUTPUT, @TotalVigente2 OUTPUT, @TotalVigente3 OUTPUT, @TotalVigente4 OUTPUT, @TotalVigente5 OUTPUT,
                                @TotalVencido1 OUTPUT, @TotalVencido2 OUTPUT, @TotalVencido3 OUTPUT, @TotalVencido4 OUTPUT, @TotalVencido5 OUTPUT
      END
      FETCH NEXT FROM crCxcPendientes INTO @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @MovTipo, @Saldo
    END
    CLOSE crCxcPendientes
    DEALLOCATE crCxcPendientes
    EXEC spPosAgregarTotal @Estacion, 3, 'CXC', NULL,
   	  	              @SumaVigente1, @SumaVigente2, @SumaVigente3, @SumaVigente4, @SumaVigente5,
   		              @SumaVencido1, @SumaVencido2, @SumaVencido3, @SumaVencido4, @SumaVencido5
  END

  IF @ConCxp = 'SI'
  BEGIN
    SELECT @SumaVigente5 = 0.0, @SumaVigente4 = 0.0, @SumaVigente3 = 0.0, @SumaVigente2 = 0.0, @SumaVigente1 = 0.0, 
           @SumaVencido5 = 0.0, @SumaVencido4 = 0.0, @SumaVencido3 = 0.0, @SumaVencido2 = 0.0, @SumaVencido1 = 0.0 

    IF @MonedaEspecifica IS NOT NULL
      DECLARE crCxpPendientes CURSOR FOR 
       SELECT p.Proveedor, Prov.Nombre, p.Mov, p.MovID, p.Referencia, p.Observaciones, p.FechaEmision, p.Vencimiento, m.Clave, ISNULL(-p.Saldo, 0.0)
         FROM Cxp p, Prov, MovTipo m
        WHERE p.Empresa   = @Empresa
          AND p.Estatus   = 'PENDIENTE'
          AND p.Moneda    = @MonedaEspecifica
          AND p.Proveedor = Prov.Proveedor
          AND p.Mov       = m.Mov AND m.Modulo = 'CXP'
          AND m.Clave NOT IN('CXP.SD','CXP.SCH')
    ELSE
      DECLARE crCxpPendientes CURSOR FOR 
       SELECT p.Proveedor, Prov.Nombre, p.Mov, p.MovID, p.Referencia, p.Observaciones, p.FechaEmision, p.Vencimiento, m.Clave, CONVERT(money, (ISNULL(-p.Saldo, 0.0)*Mon.TipoCambio)/@TipoCambio)
         FROM Cxp p, Prov, MovTipo m, Mon
        WHERE p.Empresa   = @Empresa
          AND p.Estatus   = 'PENDIENTE'
          AND p.Moneda    = Mon.Moneda
          AND p.Proveedor = Prov.Proveedor
          AND p.Mov       = m.Mov AND m.Modulo = 'CXP'
          AND m.Clave NOT IN('CXP.SD','CXP.SCH')

    OPEN crCxpPendientes
    FETCH NEXT FROM crCxpPendientes INTO @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @MovTipo, @Saldo
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @MovTipo IN ('CXP.NC','CXP.DAC','CXP.NCD','CXP.NCF','CXP.NCP') SELECT @Saldo = -@Saldo
        EXEC spPosAgregarMov @Estacion, 4, 'CXP', @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @Hoy, @Intervalo, @Saldo,
   	                        @SumaVigente1  OUTPUT, @SumaVigente2  OUTPUT, @SumaVigente3  OUTPUT, @SumaVigente4  OUTPUT, @SumaVigente5  OUTPUT,
                                @SumaVencido1  OUTPUT, @SumaVencido2  OUTPUT, @SumaVencido3  OUTPUT, @SumaVencido4  OUTPUT, @SumaVencido5  OUTPUT,
   	                        @TotalVigente1 OUTPUT, @TotalVigente2 OUTPUT, @TotalVigente3 OUTPUT, @TotalVigente4 OUTPUT, @TotalVigente5 OUTPUT,
                                @TotalVencido1 OUTPUT, @TotalVencido2 OUTPUT, @TotalVencido3 OUTPUT, @TotalVencido4 OUTPUT, @TotalVencido5 OUTPUT
      END
      FETCH NEXT FROM crCxpPendientes INTO @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @MovTipo, @Saldo
    END
    CLOSE crCxpPendientes
    DEALLOCATE crCxpPendientes
    EXEC spPosAgregarTotal @Estacion, 4, 'CXP', NULL,
   	  	              @SumaVigente1, @SumaVigente2, @SumaVigente3, @SumaVigente4, @SumaVigente5,
   		              @SumaVencido1, @SumaVencido2, @SumaVencido3, @SumaVencido4, @SumaVencido5
  END

  IF @ConGastos = 'SI'
  BEGIN
    SELECT @Referencia = NULL
    SELECT @SumaVigente5 = 0.0, @SumaVigente4 = 0.0, @SumaVigente3 = 0.0, @SumaVigente2 = 0.0, @SumaVigente1 = 0.0, 
           @SumaVencido5 = 0.0, @SumaVencido4 = 0.0, @SumaVencido3 = 0.0, @SumaVencido2 = 0.0, @SumaVencido1 = 0.0 

    IF @MonedaEspecifica IS NOT NULL
      DECLARE crGastoRecurrente CURSOR FOR 
       SELECT p.Acreedor, Prov.Nombre, p.Mov, p.MovID, p.Observaciones, p.FechaEmision, p.Vencimiento, NULLIF(RTRIM(p.Periodicidad), ''), (ISNULL(p.Importe, 0.0) - ISNULL(p.Retencion, 0.0) + ISNULL(p.Impuestos, 0.0))
         FROM Gasto p, Prov
        WHERE p.Empresa     = @Empresa
          AND p.Estatus    = 'RECURRENTE'
          AND p.Moneda      = @MonedaEspecifica
          AND p.Vencimiento <= @SimulaVencimiento
          AND p.Acreedor    = Prov.Proveedor
     ELSE
      DECLARE crGastoRecurrente CURSOR FOR 
       SELECT p.Acreedor, Prov.Nombre, p.Mov, p.MovID, p.Observaciones, p.FechaEmision, p.Vencimiento, NULLIF(RTRIM(p.Periodicidad), ''), CONVERT(money, ((ISNULL(p.Importe, 0.0) - ISNULL(p.Retencion, 0.0) + ISNULL(p.Impuestos, 0.0))*Mon.TipoCambio)/@TipoCambio)
         FROM Gasto p, Prov, Mon
        WHERE p.Empresa     = @Empresa
          AND p.Estatus    = 'RECURRENTE'
          AND p.Moneda      = Mon.Moneda
          AND p.Acreedor    = Prov.Proveedor
          AND p.Vencimiento <= @SimulaVencimiento

    OPEN crGastoRecurrente
    FETCH NEXT FROM crGastoRecurrente INTO @Cuenta, @Nombre, @Mov, @MovID, @Observaciones, @FechaEmision, @Vencimiento, @Periodicidad, @Saldo
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Saldo = -@Saldo
        EXEC spExtraerFecha @Vencimiento OUTPUT
        WHILE @Periodicidad IS NOT NULL AND @Vencimiento <= @SimulaVencimiento
        BEGIN
          EXEC spPosAgregarMov @Estacion, 5, 'GAS', @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @Hoy, @Intervalo, @Saldo,
   	                        @SumaVigente1  OUTPUT, @SumaVigente2  OUTPUT, @SumaVigente3  OUTPUT, @SumaVigente4  OUTPUT, @SumaVigente5  OUTPUT,
                                @SumaVencido1  OUTPUT, @SumaVencido2  OUTPUT, @SumaVencido3  OUTPUT, @SumaVencido4  OUTPUT, @SumaVencido5  OUTPUT,
   	                        @TotalVigente1 OUTPUT, @TotalVigente2 OUTPUT, @TotalVigente3 OUTPUT, @TotalVigente4 OUTPUT, @TotalVigente5 OUTPUT,
                                @TotalVencido1 OUTPUT, @TotalVencido2 OUTPUT, @TotalVencido3 OUTPUT, @TotalVencido4 OUTPUT, @TotalVencido5 OUTPUT
          EXEC spCalcularPeriodicidad @Vencimiento, @Periodicidad, @Vencimiento OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        END
      END
      FETCH NEXT FROM crGastoRecurrente INTO @Cuenta, @Nombre, @Mov, @MovID, @Observaciones, @FechaEmision, @Vencimiento, @Periodicidad, @Saldo
    END
    CLOSE crGastoRecurrente
    DEALLOCATE crGastoRecurrente
    EXEC spPosAgregarTotal @Estacion, 5, 'GAS', NULL,
   	  	              @SumaVigente1, @SumaVigente2, @SumaVigente3, @SumaVigente4, @SumaVigente5,
   		              @SumaVencido1, @SumaVencido2, @SumaVencido3, @SumaVencido4, @SumaVencido5
  END

  IF @ConVentas = 'SI'
  BEGIN
    SELECT @SumaVigente5 = 0.0, @SumaVigente4 = 0.0, @SumaVigente3 = 0.0, @SumaVigente2 = 0.0, @SumaVigente1 = 0.0, 
           @SumaVencido5 = 0.0, @SumaVencido4 = 0.0, @SumaVencido3 = 0.0, @SumaVencido2 = 0.0, @SumaVencido1 = 0.0 

    IF @MonedaEspecifica IS NOT NULL
      DECLARE crVentasPendientes CURSOR FOR 
       SELECT p.Cliente, Cte.Nombre, p.Mov, p.MovID, p.Referencia, p.Observaciones, p.FechaEmision, p.Vencimiento, ISNULL(p.Saldo, 0.0) 
        FROM Venta p, Cte
       WHERE p.Estatus = 'PENDIENTE'
         AND p.Empresa = @Empresa
	 AND p.Cliente = Cte.Cliente
         AND p.Moneda = @MonedaEspecifica
     ELSE
      DECLARE crVentasPendientes CURSOR FOR 
       SELECT p.Cliente, Cte.Nombre, p.Mov, p.MovID, p.Referencia, p.Observaciones, p.FechaEmision, p.Vencimiento, Convert(money, ISNULL(p.Saldo, 0.0)*Mon.TipoCambio/@TipoCambio)
        FROM Venta p, Cte, Mon
       WHERE p.Estatus = 'PENDIENTE'
         AND p.Empresa = @Empresa
	 AND p.Cliente = Cte.Cliente
         AND p.Moneda = Mon.Moneda

    OPEN crVentasPendientes
    FETCH NEXT FROM crVentasPendientes INTO @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @Saldo
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spPosAgregarMov @Estacion, 6, 'VTAS', @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @Hoy, @Intervalo, @Saldo,
 	                     @SumaVigente1  OUTPUT, @SumaVigente2  OUTPUT, @SumaVigente3  OUTPUT, @SumaVigente4  OUTPUT, @SumaVigente5  OUTPUT,
                             @SumaVencido1  OUTPUT, @SumaVencido2  OUTPUT, @SumaVencido3  OUTPUT, @SumaVencido4  OUTPUT, @SumaVencido5  OUTPUT,
   	                     @TotalVigente1 OUTPUT, @TotalVigente2 OUTPUT, @TotalVigente3 OUTPUT, @TotalVigente4 OUTPUT, @TotalVigente5 OUTPUT,
                             @TotalVencido1 OUTPUT, @TotalVencido2 OUTPUT, @TotalVencido3 OUTPUT, @TotalVencido4 OUTPUT, @TotalVencido5 OUTPUT
      END
      FETCH NEXT FROM crVentasPendientes INTO @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @Saldo
    END
    CLOSE crVentasPendientes
    DEALLOCATE crVentasPendientes

    EXEC spPosAgregarTotal @Estacion, 6, 'VTAS', NULL,
 	  	           @SumaVigente1, @SumaVigente2, @SumaVigente3, @SumaVigente4, @SumaVigente5,
   		           @SumaVencido1, @SumaVencido2, @SumaVencido3, @SumaVencido4, @SumaVencido5
  END

  IF @ConCompras = 'SI'
  BEGIN
    SELECT @SumaVigente5 = 0.0, @SumaVigente4 = 0.0, @SumaVigente3 = 0.0, @SumaVigente2 = 0.0, @SumaVigente1 = 0.0, 
           @SumaVencido5 = 0.0, @SumaVencido4 = 0.0, @SumaVencido3 = 0.0, @SumaVencido2 = 0.0, @SumaVencido1 = 0.0 

    IF @MonedaEspecifica IS NOT NULL
      DECLARE crComprasPendientes CURSOR FOR 
       SELECT p.Proveedor, prov.Nombre, p.Mov, p.MovID, p.Referencia, p.Observaciones, p.FechaEmision, p.Vencimiento, ISNULL(p.Saldo, 0.0) 
        FROM Compra p, Prov
       WHERE p.Estatus = 'PENDIENTE'
         AND p.Empresa = @Empresa
	 AND p.Proveedor = Prov.Proveedor
         AND p.Moneda = @MonedaEspecifica
     ELSE
      DECLARE crComprasPendientes CURSOR FOR 
       SELECT p.Proveedor, prov.Nombre, p.Mov, p.MovID, p.Referencia, p.Observaciones, p.FechaEmision, p.Vencimiento, Convert(money, ISNULL(p.Saldo, 0.0)*Mon.TipoCambio/@TipoCambio)
        FROM Compra p, Prov, Mon
       WHERE p.Estatus = 'PENDIENTE'
         AND p.Empresa = @Empresa
	 AND p.Proveedor = Prov.Proveedor
         AND p.Moneda = Mon.Moneda

    OPEN crComprasPendientes
    FETCH NEXT FROM crComprasPendientes INTO @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @Saldo
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Saldo = -@Saldo
        EXEC spPosAgregarMov @Estacion, 7, 'COMS', @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @Hoy, @Intervalo, @Saldo,
 	                     @SumaVigente1  OUTPUT, @SumaVigente2  OUTPUT, @SumaVigente3  OUTPUT, @SumaVigente4  OUTPUT, @SumaVigente5  OUTPUT,
                             @SumaVencido1  OUTPUT, @SumaVencido2  OUTPUT, @SumaVencido3  OUTPUT, @SumaVencido4  OUTPUT, @SumaVencido5  OUTPUT,
   	                     @TotalVigente1 OUTPUT, @TotalVigente2 OUTPUT, @TotalVigente3 OUTPUT, @TotalVigente4 OUTPUT, @TotalVigente5 OUTPUT,
                             @TotalVencido1 OUTPUT, @TotalVencido2 OUTPUT, @TotalVencido3 OUTPUT, @TotalVencido4 OUTPUT, @TotalVencido5 OUTPUT
      END
      FETCH NEXT FROM crComprasPendientes INTO @Cuenta, @Nombre, @Mov, @MovID, @Referencia, @Observaciones, @FechaEmision, @Vencimiento, @Saldo
    END
    CLOSE crComprasPendientes 
    DEALLOCATE crComprasPendientes 

    EXEC spPosAgregarTotal @Estacion, 7, 'COMS', NULL,
 	  	           @SumaVigente1, @SumaVigente2, @SumaVigente3, @SumaVigente4, @SumaVigente5,
   		           @SumaVencido1, @SumaVencido2, @SumaVencido3, @SumaVencido4, @SumaVencido5
  END

  -- Totales
  EXEC spPosAgregarTotal @Estacion, 99, 'zz', @SumaDisponible,
 	  	            @TotalVigente1, @TotalVigente2, @TotalVigente3, @TotalVigente4, @TotalVigente5,
   		            @TotalVencido1, @TotalVencido2, @TotalVencido3, @TotalVencido4, @TotalVencido5

  SELECT @AcumVencido5   = @SumaDisponible + @TotalVencido5
  SELECT @AcumVencido4   = @AcumVencido5   + @TotalVencido4
  SELECT @AcumVencido3   = @AcumVencido4   + @TotalVencido3
  SELECT @AcumVencido2   = @AcumVencido3   + @TotalVencido2
  SELECT @AcumVencido1   = @AcumVencido2   + @TotalVencido1
  SELECT @AcumVigente1   = @AcumVencido1   + @TotalVigente1
  SELECT @AcumVigente2   = @AcumVigente1   + @TotalVigente2
  SELECT @AcumVigente3   = @AcumVigente2   + @TotalVigente3
  SELECT @AcumVigente4   = @AcumVigente3   + @TotalVigente4
  SELECT @AcumVigente5   = @AcumVigente4   + @TotalVigente5

  SELECT @AcumVencido = @SumaDisponible + @TotalVencido5 + @TotalVencido4 + @TotalVencido3 + @TotalVencido2 + @TotalVencido1
  SELECT @AcumVigente = @AcumVencido    + @TotalVigente1 + @TotalVigente2 + @TotalVigente3 + @TotalVigente4 + @TotalVigente5 

  -- Acumulados
  INSERT INTO VerPos (Estacion,  Orden, Modulo, Periodo, Cuenta,  Disponible,      Vencido,      Vencido5,      Vencido4,      Vencido3,      Vencido2,      Vencido1,      Vigente,      Vigente1,      Vigente2,      Vigente3,      Vigente4,      Vigente5)
                 VALUES (@Estacion, 100,   'zz',   1000,    'Flujo', @SumaDisponible, @AcumVencido, @AcumVencido5, @AcumVencido4, @AcumVencido3, @AcumVencido2, @AcumVencido1, @AcumVigente, @AcumVigente1, @AcumVigente2, @AcumVigente3, @AcumVigente4, @AcumVigente5)
END
GO



GO
PRINT "******************* SP Posicion ******************"
