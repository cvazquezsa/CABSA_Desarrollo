SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
IF EXISTS (SELECT * FROM SysObjects WHERE Name = 'spRSFlujoEfectivo' AND Type = 'p')
	DROP PROCEDURE spRSFlujoEfectivo
GO
CREATE PROCEDURE spRSFlujoEfectivo
		
		 @Empresa		varchar(10),
		 @Sucursal	    int,  
		 @CtaDineroD	varchar(10),
     @CtaDineroA    varchar(10),		
		 @Moneda		varchar(10),
		 @FechaD        datetime,
		 @FechaA        datetime,
		 @CategoriaCta	varchar(50)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @EstacionTrabajo		    int,
  @InfoUso					varchar(20),
  @InfoMov					varchar(20),
  @InfoNivel				varchar(20),
  
  @InfoTitulo				varchar(100),
  @InfoUsuario				varchar(10),
  @MonedaInicial			varchar(10),
  @CuentaInicial			varchar(10),
  @MovInicial				varchar(20),    
  @ID						int,

  @Cuenta					varchar(10),
  @Fecha					datetime,
  @Cargos					float,
  @Abonos					float,
  @CargosMC					float,
  @AbonosMC					float,
  @Saldo					float,
  @SaldoMC					float,
  @Mov						varchar(20),
  @MovTotalCargos			float,
  @MovTotalAbonos			float,
  @MovTotalCargosMC			float,
  @MovTotalAbonosMC			float,
  @ContMoneda				varchar(10),
  @InformeGraficarTipo		varchar(30),
  @InformeGraficarCantidad	int,
  @EmpresaNombre			varchar(100),
  @Positivo					integer,
  @VerGraficaDetalle		bit
  
  SELECT @EstacionTrabajo=@@SPID

  SELECT @InfoUso='(Todos)', @InfoMov='(Todos)', @InfoNivel=NULL

  SELECT @InfoUso    = CASE WHEN @InfoUso IN( '(Todos)', '') THEN NULL ELSE @InfoUso END,    
         @InfoMov    = CASE WHEN @InfoMov IN( '(Todos)', '') THEN NULL ELSE @InfoMov END,    
         @InfoNivel  =   ISNULL(@InfoNivel,'Desglosado'),
         @InfoTitulo = NULL,
		 @Moneda     = CASE WHEN @Moneda IN( '(Todas)', '') THEN NULL ELSE @Moneda END,
		 @Empresa     = CASE WHEN @Empresa IN( '(Todas)', '') THEN NULL ELSE @Empresa END
 
  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa
    
  DECLARE @Datos TABLE
  (
   Estacion					int NOT NULL,
   ID						int identity(1,1) NOT NULL,
   CtaDinero				varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   NumeroCta				varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Descripcion				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Tipo						varchar(20) COLLATE DATABASE_DEFAULT NULL,   
   Uso						varchar(20) COLLATE DATABASE_DEFAULT NULL, 
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   TipoCambio				float NULL,
   Beneficiario				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Fecha					datetime NULL,
   Movimiento				varchar(50) COLLATE DATABASE_DEFAULT NULL,
   Cargos					float NULL,
   Abonos					float NULL,
   Saldo					float NULL,
   CargosMC					float NULL,
   AbonosMC					float NULL,   
   SaldoMC					float NULL,      
   EsCancelacion			bit NULL DEFAULT 0,
   Grafica					int NULL DEFAULT 0,
   GraficaArgumento			varchar(20) COLLATE DATABASE_DEFAULT NULL,
   GraficaValor1			float,
   GraficaValor2			float,
   GraficaValor3			float,
   GraficaValor4			float,   
   GraficaPositivo			integer NULL DEFAULT 0,
   Titulo					varchar(50) COLLATE DATABASE_DEFAULT NULL,
   ContMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroEmpresa			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroD			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroA			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroFechaD				datetime NULL,
   FiltroFechaA				datetime NULL,
   FiltroUso				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMov				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroNivel				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarTipo		varchar(30) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarCantidad	int NULL
  )    

  DECLARE @DatosDin TABLE
  (
   Modulo                   varchar(5),
   ModuloNombre             varchar(50),
   CtaDinero				varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   NumeroCta				varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   CtaDineroDescripcion		varchar(100) COLLATE DATABASE_DEFAULT NULL,
   ClienteProveedor         varchar(10) NULL, 
   Nombre                   varchar(100) NULL, 
   Mov      		        varchar (50) NULL, --COLLATE DATABASE_DEFAULT NULL, 
   MovID		            varchar (20) COLLATE DATABASE_DEFAULT NULL,   
   FechaEmision				datetime NULL,
   FechaVencimiento     	datetime NULL,
   Importe					float NULL,
   Cargos					float NULL,
   Abonos					float NULL,
   Saldo					float NULL,
   TotalClienteProveedor    float NULL, --PGC21042015
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   ProveedorCat				varchar(50) NULL, --CABSA,
   ConceptoFE				varchar(50) null --CABSA
  )    


   INSERT @Datos (Estacion, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Fecha, Movimiento, Cargos, Abonos, Saldo, CargosMC, AbonosMC, SaldoMC, EsCancelacion, Grafica, Titulo, ContMoneda, FiltroEmpresa, FiltroCtaDineroD,
 FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
  SELECT
    @EstacionTrabajo,
    RTRIM(c.CtaDinero),
    RTRIM(c.NumeroCta),
    RTRIM(c.Descripcion),
    NULL,
    NULL,
    c.Moneda,
    NULL,
    NULL,
    DATEADD(day,-1,@FechaD),
    dbo.fnIdiomaTraducir(@InfoUsuario,'Saldo Inicial'),
    SUM(ISNULL(a.Cargo,0.0)),    
    SUM(ISNULL(a.Abono,0.0)),        
    NULL,
    SUM(ISNULL(a.Cargo,0.0)*ISNULL(a.TipoCambio,0)),    
    SUM(ISNULL(a.Abono,0.0)*ISNULL(a.TipoCambio,0)),        
    NULL,
    0,
    0,
    @InfoTitulo,
    @ContMoneda,
    @EmpresaNombre,    
    @CtaDineroD,	
    @CtaDineroA,	
    @FechaD,		
    @FechaA,		
    ISNULL(@InfoUso,'(Todos)'),		
    ISNULL(@InfoMov,'(Todos)'),		
    @InfoNivel,		
    ISNULL(@Moneda,'(Todas)'),		    
    ISNULL(@InformeGraficarTipo,'(Todos)'),		        
    @InformeGraficarCantidad
  FROM
    CtaDinero c 
	LEFT OUTER JOIN Auxiliar a ON a.Empresa = ISNULL(@Empresa,a.Empresa) AND a.Sucursal=ISNULL(@Sucursal,a.Sucursal) AND a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta 
	                             AND a.Fecha < @FechaD AND a.Mov = ISNULL(@InfoMov,a.Mov) --BUG2911
								 AND a.Moneda = ISNULL(@Moneda,a.Moneda)
	LEFT OUTER JOIN Dinero d ON d.ID = a.ModuloID AND d.Empresa=a.Empresa AND d.Sucursal=a.Sucursal
 WHERE c.CtaDinero BETWEEN @CtaDineroD AND @CtaDineroA
	 AND ISNULL(c.Categoria,'') = ISNULL(@CategoriaCta,'')
   AND ISNULL(c.Uso,'') = ISNULL(@InfoUso,ISNULL(c.Uso,''))
 GROUP BY RTRIM(c.CtaDinero), RTRIM(c.NumeroCta), RTRIM(c.Descripcion), c.Moneda

  DELETE FROM @Datos WHERE ISNULL(Cargos,0.0) = 0.0 AND ISNULL(Abonos,0.0) = 0.0
	 --SELECT * FROM @Datos
  -- Movimientos Actuales
  INSERT @Datos (Estacion, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Fecha, Movimiento, Cargos, Abonos, Saldo, CargosMC, AbonosMC, SaldoMC, EsCancelacion, Grafica, Titulo, GraficaArgumento, ContMoneda, FiltroEmpresa, 
FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
  SELECT
    @EstacionTrabajo,
    RTRIM(c.CtaDinero),
    RTRIM(c.NumeroCta),    
    RTRIM(c.Descripcion),
    c.Tipo,
    c.Uso,
    a.Moneda,
    a.TipoCambio,
    d.BeneficiarioNombre,
    a.Fecha,
    RTRIM(RTRIM(ISNULL(a.Mov,'')) + ' ' + RTRIM(ISNULL(a.MovID,''))),
    ISNULL(a.Cargo,0.0),    
    ISNULL(a.Abono,0.0),        
    NULL,
    ISNULL(a.Cargo,0.0)*ISNULL(a.TipoCambio,0),    
    ISNULL(a.Abono,0.0)*ISNULL(a.TipoCambio,0),        
    NULL,
    ISNULL(a.EsCancelacion,0),
    0,
    @InfoTitulo,
    RTRIM(ISNULL(a.Mov,'')),
    @ContMoneda,
    @EmpresaNombre,
    @CtaDineroD,	
    @CtaDineroA,	
    @FechaD,		
    @FechaA,		
    ISNULL(@InfoUso,'(Todos)'),		
    ISNULL(@InfoMov,'(Todos)'),		
    @InfoNivel,		
    ISNULL(@Moneda,'(Todas)'),
    ISNULL(@InformeGraficarTipo,'(Todos)'),		        
    @InformeGraficarCantidad    		        
  FROM
    CtaDinero c JOIN Auxiliar a 
    --ON a.Empresa = @Empresa AND a.Sucursal=@Sucursal AND a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta JOIN Dinero d
    ON a.Empresa = ISNULL(@Empresa,a.Empresa) AND a.Sucursal=ISNULL(@Sucursal,a.Sucursal) AND a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta JOIN Dinero d --BUG2935
    ON d.ID = a.ModuloID AND d.Empresa=a.Empresa AND d.Sucursal=a.Sucursal
 WHERE a.Empresa = @Empresa
   AND a.Cuenta BETWEEN @CtaDineroD AND @CtaDineroA
	 AND ISNULL(c.Categoria,'') = ISNULL(@CategoriaCta,'')
   AND a.Fecha BETWEEN @FechaD AND @FechaA --BUG2911
   AND ISNULL(c.Uso,'') = ISNULL(@InfoUso,ISNULL(c.Uso,''))
   --AND a.Mov = ISNULL(@InfoMov,a.Mov) 
   AND a.Moneda = ISNULL(@Moneda,a.Moneda)   

	 --SELECT 1, ID, Moneda, CtaDinero, Fecha, ISNULL(Cargos,0.0), ISNULL(Abonos,0.0), ISNULL(CargosMC,0.0), ISNULL(AbonosMC,0.0)  
  --   FROM @Datos
  --  ORDER BY CtaDinero, Moneda, Fecha

  SELECT @MonedaInicial = '', @CuentaInicial = '', @Saldo = 0.0, @SaldoMC = 0.0
  DECLARE crDineroAux CURSOR FOR
   SELECT ID, Moneda, CtaDinero, Fecha, ISNULL(Cargos,0.0), ISNULL(Abonos,0.0), ISNULL(CargosMC,0.0), ISNULL(AbonosMC,0.0)  
     FROM @Datos
    ORDER BY CtaDinero, Moneda, Fecha

  OPEN crDineroAux
  FETCH NEXT FROM crDineroAux INTO @ID, @Moneda, @Cuenta, @Fecha, @Cargos, @Abonos, @CargosMC, @AbonosMC
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @Moneda <> @MonedaInicial OR @Cuenta <> @CuentaInicial
    BEGIN
      SET @Saldo = 0.0
      SET @SaldoMC = 0.0
      SET @MonedaInicial = @Moneda
      SET @CuentaInicial = @Cuenta
    END     

    UPDATE @Datos 
       SET 
       Saldo = @Saldo + (@Cargos - @Abonos), 
       SaldoMC = @SaldoMC + (@CargosMC - @AbonosMC)
     WHERE ID = @ID

    SET @Saldo = @Saldo + (@Cargos - @Abonos)
    SET @SaldoMC = @SaldoMC + (@CargosMC - @AbonosMC)
        
    FETCH NEXT FROM crDineroAux INTO @ID, @Moneda, @Cuenta, @Fecha, @Cargos, @Abonos, @CargosMC, @AbonosMC
  END
  CLOSE crDineroAux
  DEALLOCATE crDineroAux
   
  -- SELECT 'DIN', 'Cuentas de Dinero', d.CtaDinero, cd.SaldoInicial, d.NumeroCta, d.CtaDinero+' - '+d.Descripcion, NULL, NULL, NULL, NULL, NULL, NULL, NULL, SUM(d.Cargos) AS Cargos, SUM(d.Abonos) AS Abonos, ISNULL(cd.SaldoInicial,0) + SUM(d.Cargos)-SUM(d.Abonos),SUM(d.Saldo)- CASE WHEN cd.Tipo='Caja' THEN ISNULL(cd.FondoFijo,0) ELSE ISNULL(cd.SaldoInicial,0) END AS Saldo, d.Moneda
  --FROM @Datos d, CtaDinero cd
  --WHERE cd.CtaDinero=d.CtaDinero
  --GROUP BY d.CtaDinero, d.NumeroCta, d.Descripcion, d.Moneda, cd.Tipo, cd.FondoFijo, cd.SaldoInicial
  
 INSERT INTO @DatosDin ( Modulo, ModuloNombre, CtaDinero, NumeroCta, CtaDineroDescripcion, ClienteProveedor, Nombre, Mov, MovID, FechaEmision, FechaVencimiento, Importe, Cargos, Abonos, Saldo, TotalClienteProveedor, Moneda, ProveedorCat, ConceptoFE)
 --DINERO
 SELECT 'DIN', 'Cuentas de Dinero', d.CtaDinero, d.NumeroCta, d.CtaDinero+' - '+d.Descripcion, NULL, NULL, NULL, NULL, NULL, NULL, NULL, SUM(d.Cargos) AS Cargos, SUM(d.Abonos) AS Abonos, 
	/*SUM(d.Saldo)- CASE WHEN cd.Tipo='Caja' THEN ISNULL(cd.FondoFijo,0) ELSE ISNULL(cd.SaldoInicial,0) END*/ISNULL(cd.SaldoInicial,0) + SUM(d.Cargos)-SUM(d.Abonos) AS Saldo, NULL, d.Moneda,null,null --BUG2404 Preconfig
  FROM @Datos d, CtaDinero cd
  WHERE cd.CtaDinero=d.CtaDinero
  GROUP BY d.CtaDinero, d.NumeroCta, d.Descripcion, d.Moneda, cd.Tipo, cd.FondoFijo, cd.SaldoInicial
 UNION
 --Cxc
 SELECT 'CXC', 'Cuentas por Cobrar', 'CXC', NULL, 'CXC', Cxc.Cliente, Cxc.Cliente+' - '+Cte.Nombre, Cxc.Mov+' - '+ Cxc.MovID, Cxc.MovID, Cxc.FechaEmision, Cxc.Vencimiento,
        Sum(Cxc.Importe) as Importe, NULL, NULL, SUM(CASE WHEN mt.Clave IN ('CXC.A','CXC.FACX') THEN Cxc.Saldo*-1 ELSE Cxc.Saldo END),
		 SUM(CASE WHEN mt.Clave IN ('CXC.A','CXC.FACX') THEN Cxc.Saldo*-1 ELSE Cxc.Saldo END), Cxc.Moneda,null,ISNULL(Cxc.ConceptoFE,'NVACIO')
  FROM Cxc
	JOIN Cte on Cte.Cliente=Cxc.Cliente
    JOIN MovTipo Mt ON Mt.Modulo='CXC' AND Mt.Mov=Cxc.Mov
 WHERE Cxc.Empresa=ISNULL(@Empresa,Cxc.Empresa) AND Cxc.Sucursal=ISNULL(@Sucursal,Cxc.Sucursal)
   --AND a.Fecha BETWEEN @FechaD AND @FechaA
   AND Cxc.Vencimiento BETWEEN @FechaD AND @FechaA
   --AND Cxc.FechaEmision BETWEEN @FechaD AND @FechaA
   AND Cxc.Estatus='PENDIENTE'
   AND Cxc.Mov = ISNULL(@InfoMov,Cxc.Mov)
   AND Cxc.Moneda = ISNULL(@Moneda,Cxc.Moneda)
   AND mt.Clave IN ('CXC.F', 'CXC.NC', 'CXC.FA', 'CXC.A', 'CXC.FAC', 'CXC.D', 'CXC.CAP', 'CXC.C', 'CXC.NET', 'CXC.SD') --PGC21042015 --BUG2911
 GROUP BY cte.Categoria,Cxc.Cliente, Cte.Nombre, Cxc.ConceptoFE, Cxc.Mov, Cxc.MovID, Cxc.FechaEmision, Cxc.Vencimiento, Cxc.Moneda
 UNION
 --Cxp
 SELECT 'CXP', 'Cuentas por Pagar', 'CXP', NULL, 'CXP', Cxp.Proveedor, Cxp.Proveedor+' - '+Prov.Nombre, Cxp.Mov+' - '+Cxp.MovID, Cxp.MovID, Cxp.FechaEmision, Cxp.Vencimiento,
        Sum(Cxp.Importe) as Importe, NULL, NULL, SUM(Cxp.Saldo), SUM(Cxp.Saldo), Cxp.Moneda, NULL, ISNULL(Cxp.ConceptoFE,'NVACIO')
  FROM Cxp
	JOIN Prov on Prov.Proveedor=Cxp.Proveedor
    JOIN MovTipo Mt ON Mt.Modulo='CXP' AND Mt.Mov=Cxp.Mov
 WHERE Cxp.Empresa=ISNULL(@Empresa, Cxp.Empresa) AND Cxp.Sucursal=ISNULL(@Sucursal, Cxp.Sucursal)
   AND Cxp.Vencimiento BETWEEN @FechaD AND @FechaA
   --AND Cxp.FechaEmision BETWEEN @FechaD AND @FechaA
   AND Cxp.Estatus='PENDIENTE'
   AND Cxp.Mov = ISNULL(@InfoMov,Cxp.Mov)
   AND Cxp.Moneda = ISNULL(@Moneda, Cxp.Moneda)
   AND mt.Clave IN ('CXP.NC', 'CXP.CA', 'CXP.F', 'CXP.FAC', 'CXP.D', 'CXP.P', 'CXP.SCH', 'CXP.CAP')
	 AND NOT Cxp.Mov IN ('Anticipo SI')
 GROUP BY prov.Categoria,Cxp.Proveedor, Prov.Nombre,Cxp.ConceptoFE, Cxp.Mov, Cxp.MovID, Cxp.FechaEmision, Cxp.Vencimiento, Cxp.Moneda
 UNION
 SELECT 'GAS', 'Gastos', 'CXP', NULL, 'CXP', g.Acreedor, g.Acreedor + ' - ' +p.Nombre, g.Mov + ' - ' +g.MovID, g.MovID, g.FechaEmision, g.Vencimiento, SUM(g.Importe) AS Importe, NULL, NULL, SUM(g.Saldo), SUM(g.Saldo), g.moneda, NULL, ISNULL(g.ConceptoFE,'NVACIO')
 FROM Gasto g
	JOIN Prov p ON g.Acreedor=p.proveedor
	JOIN MovTIpo mt ON mt.Modulo='GAS' AND mt.Mov=g.Mov
	WHERE g.Empresa=ISNULL(@Empresa, g.Empresa) AND g.Sucursal=ISNULL(@Sucursal, g.Sucursal)
		AND g.Vencimiento BETWEEN @FechaD AND @FechaA
		AND g.Estatus='PENDIENTE'
		AND g.Mov=ISNULL(@InfoMov,g.Mov)
		AND g.Moneda=ISNULL(@Moneda, g.Moneda)
		AND mt.Clave IN ('GAS.P')
	GROUP BY p.Categoria, g.Acreedor, p.Nombre, g.ConceptoFE, g.Mov, g.MovID, g.FechaEmision, g.Vencimiento, g.Moneda
  UNION
  SELECT 'VTAS', 'Ventas', 'CXC', NULL, 'CXC', v.Cliente, v.Cliente + ' - ' +c.Nombre, v.Mov + ' - ' +v.MovID, v.MovID, v.FechaEmision, v.Vencimiento, SUM(v.Importe) AS Importe, NULL, NULL, SUM(v.Saldo), SUM(v.Saldo), v.moneda, NULL, v.ConceptoFE
  FROM Venta v
	JOIN Cte c ON v.Cliente=c.Cliente
	JOIN MovTIpo mt ON mt.Modulo='VTAS' AND mt.Mov=v.Mov
  WHERE v.Empresa=ISNULL(@Empresa, v.Empresa) AND v.Sucursal=ISNULL(@Sucursal, v.Sucursal)
		AND v.Vencimiento BETWEEN @FechaD AND @FechaA
		AND v.Estatus='CONFIRMAR'
		AND v.Mov=ISNULL(@InfoMov,v.Mov)
		AND v.Moneda=ISNULL(@Moneda, v.Moneda)
		AND mt.Clave IN ('VTAS.OP')
  GROUP BY c.Categoria, v.Cliente, c.Nombre,v.ConceptoFE, v.Mov, v.MovID, v.FechaEmision,v.Vencimiento, v.Moneda

--INSERT INTO @DatosDin ( Modulo, ModuloNombre, CtaDinero, NumeroCta, CtaDineroDescripcion, ClienteProveedor, Nombre, Mov, MovID, 
--	FechaEmision, FechaVencimiento, Importe, Cargos, Abonos, Saldo, TotalClienteProveedor, Moneda, ProveedorCat, ConceptoFE)
 	  
  SELECT * FROM @DatosDin ORDER BY Modulo DESC, ClienteProveedor, FechaEmision ASC
END
GO
--EXEC spRSFlujoEfectivo  'CABSA', 0, '1002023','SCOTIA9982','Pesos','20180501','20180530','Operación'