/************************************ spRepAntSaldoPedidos *****************************************/
IF EXISTS(SELECT * FROM SysObjects WHERE ID = object_id('dbo.spRepAntSaldoPedidos') and type = 'P') 
DROP PROCEDURE spRepAntSaldoPedidos
GO
CREATE PROCEDURE spRepAntSaldoPedidos
             @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  -- De 1 a 15, de 16 a 30, de 31 a 60, de 61 a 90, mas de 90
  DECLARE @ClienteD		varchar(10),
          @ClienteA		varchar(10),
          @Desglosado		char(2),
          @Empresa			char(5)
 
  SELECT @ClienteD = rp.InfoClienteD,
         @ClienteA = rp.InfoClienteA,
         @Desglosado = rp.InfoDesglosar,
         @Empresa = rp.InfoEmpresa
    FROM RepParam rp
   WHERE Estacion = @Estacion

  IF ISNULL(@ClienteD, '') IN ('Todos','(Todos)','') SELECT @ClienteD = MIN(Cliente) FROM Cte
  IF ISNULL(@ClienteA, '') IN ('Todos','(Todos)','') SELECT @ClienteA = MAX(Cliente) FROM Cte
  IF ISNULL(@Desglosado, '') IN ('') SELECT @Desglosado = 'No'

  SELECT v.ID,
         v.Empresa,
         v.Mov,
         v.MovID,
         v.FechaEmision,
         v.Cliente,
         c.Nombre,
         v.Total,
         v.Moneda,
         Saldo = ISNULL(v.Saldo, 0) - ISNULL(v.SaldoImpuestos,0),
         vd.Articulo,
         vd.ArtDescripcion,
         Pendiente = CASE ISNULL(vd.CantidadPendiente, 0)
                          WHEN 0 THEN vd.CantidadReservada
                          ELSE ISNULL(vd.CantidadPendiente, 0)
                     END,
         vd.Precio,
         ImportePendienteDetalle = CASE ISNULL(vd.CantidadPendiente, 0)
                                        WHEN 0 THEN (vd.CantidadReservada * vd.Precio) - (vd.CantidadReservada * vd.Precio * (ISNULL(vd.DescuentoLinea,0) / 100))
                                        ELSE (vd.CantidadPendiente * vd.Precio) - (vd.CantidadPendiente * vd.Precio * (ISNULL(vd.DescuentoLinea,0) / 100))
                                   END,
         vd.DescuentoLinea,
         Dias = DATEDIFF(DAY, v.FechaEmision, GETDATE())
  FROM VentaPendiente v
 INNER JOIN Cte c ON v.Cliente = c.Cliente
 INNER JOIN VentaPendienteD vd On v.ID = vd.ID
 INNER JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave IN ('VTAS.P')
 WHERE v.Empresa = @Empresa						
   AND v.Cliente BETWEEN @ClienteD AND @ClienteA
 ORDER BY v.Moneda, v.Cliente, v.Mov
END
GO

/************************************ spRepHistPersonal *****************************************/
IF EXISTS(SELECT * FROM SysObjects WHERE ID = object_id('dbo.spRepHistPersonal') and type = 'P') 
DROP PROCEDURE spRepHistPersonal
go
CREATE PROCEDURE spRepHistPersonal
             @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	@PersonalD	varchar(10),
		@PersonalA	varchar(10),
		@FechaD		DateTime,
		@FechaA		DateTime,
		@Empresa	char(5)

  SELECT @PersonalD = rp.InfoPersonalD,
         @PersonalA = rp.InfoPersonalA,
         @FechaD = rp.InfoFechaD,
         @FechaA = rp.InfoFechaA,
         @Empresa = rp.InfoEmpresa
    FROM RepParam rp
   WHERE rp.Estacion = @Estacion

  IF ISNULL(@PersonalD, '') IN ('Todos','(Todos)','', NULL) SELECT @PersonalD = MIN(Personal) FROM Personal
  IF ISNULL(@PersonalA, '') IN ('Todos','(Todos)','', NULL) SELECT @PersonalA = MAX(Personal) FROM Personal

  SELECT d.Personal, 
         NombreCompleto = p.Nombre + ' ' + p.ApellidoPaterno + ' ' + ISNULL(p.ApellidoMaterno, ''),
         d.ID, 
         r.Empresa,
         r.Mov,
         r.MovID,
         r.FechaEmision,
         r.Moneda,
         UsuarioEjecuto = r.Usuario
    FROM RH r 
   INNER JOIN RHD d ON r.ID = d.ID
   INNER JOIN Personal p ON d.Personal = p.Personal
   WHERE r.Estatus = 'CONCLUIDO' 
     AND d.Personal BETWEEN @PersonalD AND @PersonalA
     AND r.FechaEmision BETWEEN @FechaD AND @FechaA
     AND r.Empresa = @Empresa
  
END
GO

/************************************ spRepMovActivosFijos *****************************************/
IF EXISTS(SELECT * FROM SysObjects WHERE ID = object_id('dbo.spRepMovActivosFijos') and type = 'P') 
DROP PROCEDURE spRepMovActivosFijos
GO
CREATE PROCEDURE spRepMovActivosFijos
             @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @PeriodoD	int,
          @PeriodoA	int,
          @Ejercicio	int,
          @Empresa	char(5),
          @FechaD	DateTime,
          @FechaA	DateTime

  SELECT @FechaD = rp.InfoFechaD,
	 @FechaA = rp.InfoFechaA,
         @Ejercicio = rp.InfoEjercicio,
         @Empresa = rp.InfoEmpresa
    FROM RepParam rp
   WHERE rp.Estacion = @Estacion

  SELECT Modulo = 'Compras',
         ID = Compra.ID,
         Empresa = Compra.Empresa,
         NombreEmpresa = e.Nombre,
         Mov = Compra.Mov,
         MovID = Compra.MovID,
         FechaEmision = Compra.FechaEmision,
         Moneda = Compra.Moneda,
         Estatus = Compra.Estatus,
         Proveedor = Compra.Proveedor,
         Almacen = Compra.Almacen,
         NombreAlmacen = a.Nombre,
         Importe = Compra.Importe * MovTipo.Factor,
         Impuestos = Compra.Impuestos * MovTipo.Factor,
         DescuentoGlobal = Compra.DescuentoGlobal,
         Sucursal = Compra.Sucursal,
         NombreSucursal = s.Nombre,
         UEN = Compra.UEN,
         SubCuenta = CompraD.Subcuenta,
         Impuesto1 = CompraD.Impuesto1,
         Costo = CompraD.Costo * MovTipo.Factor,
         --BUG13640
         Cantidad = slm.Cantidad * MovTipo.Factor,
         NombreProv = Prov.Nombre,
         Renglon = CompraD.Renglon,
         Articulo = CompraD.Articulo,
         Descripcion = Art.Descripcion1,
         Serie = slm.SerieLote,
         Periodo = Compra.Periodo,
         Ejercicio = Compra.Ejercicio
    FROM Compra
   INNER JOIN CompraD ON Compra.ID = CompraD.ID 
   INNER JOIN SerieLoteMov slm ON slm.ID = Compra.ID AND slm.RenglonID = CompraD.RenglonID
   INNER JOIN ActivoF af ON Compra.Empresa = af.Empresa AND af.Articulo = CompraD.Articulo AND af.Serie = slm.SerieLote						
   INNER JOIN Alm a ON CompraD.Almacen = a.Almacen AND a.Tipo IN ('Activos Fijos')
   INNER JOIN Sucursal s ON Compra.Sucursal = s.Sucursal
   INNER JOIN Empresa e ON Compra.Empresa = e.Empresa
   INNER JOIN Prov ON Compra.Proveedor = Prov.Proveedor 
   INNER JOIN Art ON CompraD.Articulo = Art.Articulo 
   INNER JOIN MovTipo ON Compra.Mov = MovTipo.Mov  AND MovTipo.Modulo = 'COMS' AND MovTipo.Clave IN ('COMS.EG','COMS.F','COMS.FL','COMS.OP', 'COMS.D')
   WHERE Compra.Empresa = @Empresa AND Compra.Estatus = 'CONCLUIDO' AND Compra.FechaEmision BETWEEN @FechaD AND @FechaA
  
  UNION
  SELECT Modulo = 'Inventarios',
         Inv.ID,
         Inv.Empresa,
         NombreEmpresa = e.Nombre,
         InvMov = Inv.Mov,
         InvMovID = Inv.MovID,
         Inv.FechaEmision,
         InvMoneda = Inv.Moneda,
         Inv.Estatus,
         NULL,
         Inv.Almacen,
         NombreAlmacen = a.Nombre,
         Inv.Importe * MovTipo.Factor,
         NULL,
         NULL,
         Inv.Sucursal,
         NombreSucursal = s.Nombre,
         Inv.UEN,
         InvD.Subcuenta,
         NULL,
         InvD.Costo * MovTipo.Factor,
         --BUG13640
         slm.Cantidad * MovTipo.Factor,
         NULL,
         InvD.Renglon,
         InvD.Articulo,
         Art.Descripcion1,
         slm.SerieLote,
         Inv.Periodo,
         Inv.Ejercicio
    FROM Inv
   INNER JOIN InvD ON Inv.ID = InvD.ID 
   INNER JOIN SerieLoteMov slm ON Inv.ID = slm.ID AND InvD.RenglonID = slm.RenglonID
   INNER JOIN Empresa e ON Inv.Empresa = e.Empresa
   INNER JOIN Sucursal s ON Inv.Sucursal = s.Sucursal
   INNER JOIN Alm a ON InvD.Almacen = a.Almacen AND a.Tipo = 'Activos Fijos'
   INNER JOIN Art ON InvD.Articulo = Art.Articulo 
   INNER JOIN ActivoF af ON af.Empresa = Inv.Empresa AND af.Articulo = InvD.Articulo AND af.Serie = slm.SerieLote
   INNER JOIN MovTipo ON Inv.Mov = MovTipo.Mov AND MovTipo.Modulo = 'INV' AND MovTipo.Clave IN('INV.EP','INV.E')
   WHERE Inv.Empresa = @Empresa 
     AND Inv.Estatus = 'CONCLUIDO' 
     AND Inv.FechaEmision BETWEEN @FechaD AND @FechaA
END
GO

/************************************  spRepKardexPersonal *****************************************/
IF EXISTS(SELECT * FROM SysObjects WHERE ID = object_id('dbo.spRepPersonalKardex') and type = 'P') 
DROP PROCEDURE spRepPersonalKardex
go
CREATE PROCEDURE spRepPersonalKardex
             @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Empresa		char(5),
          @PersonalD		varchar(10),
          @PersonalA		varchar(10),
          @FechaD			datetime,
          @FechaA			datetime,
    -- Variables Procedimiento
          @FechaEmision	datetime,
          @Personal		varchar(10),
          @HoraEntrada	char(5),
          @HoraSalida		char(5),
          @EmpresaCursor	char(5)		
    
  SELECT @Empresa = rp.InfoEmpresa, 
         @PersonalD = rp.InfoPersonalD,
         @PersonalA = rp.InfoPersonalA,
         @FechaD = rp.InfoFechaD,
         @FechaA = rp.InfoFechaA
  FROM RepParam rp
  WHERE rp.Estacion = @Estacion

  CREATE TABLE #KardexPersonal (
    Empresa			char(5)			COLLATE Database_Default null,
    FechaEmision	datetime		null,
    Personal		varchar(10)		COLLATE Database_Default null,
    Nombre			varchar(100)	COLLATE Database_Default null,
    Tipo			varchar(20)		COLLATE Database_Default null,
    Departamento	varchar(50)		COLLATE Database_Default null,
    Puesto			varchar(50)		COLLATE Database_Default null,
    SDI				money			null,
    SueldoDiario	money			null,
    Moneda			varchar(10)		COLLATE Database_Default null,
    Jornada			varchar(20)		COLLATE Database_Default null,
    Entrada			char(5)			null,
    Salida			char(5)			null)
  
  IF @PersonalD IN ('','(Todos)','(Todas)','NULL', NULL) SELECT @PersonalD = MIN(Personal) FROM Personal
  IF @PersonalA IN ('','(Todos)','(Todas)','NULL', NULL) SELECT @PersonalA = MAX(Personal) FROM Personal

  INSERT #KardexPersonal
  SELECT a.Empresa,
         a.FechaEmision,
         ad.Personal,
         Nombre = p.Nombre + ' ' + p.ApellidoPaterno + ' ' + p.ApellidoMaterno,
         p.Tipo,
         p.Departamento,
         p.Puesto,
         p.SDI,
         p.SueldoDiario,
         p.Moneda,
         p.Jornada,
         NULL,
         NULL
    FROM Asiste a
   INNER JOIN AsisteD ad ON a.ID = ad.ID
   INNER JOIN Personal p ON ad.Personal = p.Personal
   INNER JOIN MovTipo mt ON a.Mov = mt.Mov
						 AND mt.Modulo = 'ASIS'
						 AND mt.Clave = 'ASIS.R'
   WHERE a.Empresa = @Empresa 
     AND a.FechaEmision BETWEEN @FechaD AND @FechaA 
     AND ad.Personal BETWEEN @PersonalD AND @PersonalA
     AND a.Estatus NOT IN ('CANCELADO', 'SINAFECTAR')
GROUP BY a.Empresa, 
         a.FechaEmision, 
         ad.Personal, 
         p.Nombre, 
         p.ApellidoPaterno, 
         p.ApellidoMaterno, 
         p.Tipo, 
         p.Departamento, 
         p.Puesto, 
         p.SDI, 
         p.SueldoDiario, 
         p.Moneda, 
         p.Jornada

  DECLARE crKardexPersonal CURSOR LOCAL FOR
   SELECT Empresa, 
          FechaEmision, 
          Personal 
     FROM #KardexPersonal
  OPEN crKardexPersonal
  FETCH NEXT FROM crKardexPersonal INTO @EmpresaCursor, @FechaEmision, @Personal
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @HoraEntrada = MIN(ad.HoraRegistro)
        FROM Asiste a
       INNER JOIN AsisteD ad ON a.ID = ad.ID
       WHERE a.Empresa = @EmpresaCursor 
         AND a.FechaEmision = @FechaEmision 
         AND ad.Personal = @Personal 
         AND ad.Registro = 'Entrada'

      SELECT @HoraSalida = MAX(ad.HoraRegistro)
        FROM Asiste a
       INNER JOIN AsisteD ad ON a.ID = ad.ID
       WHERE a.Empresa = @EmpresaCursor 
         AND a.FechaEmision = @FechaEmision 
         AND ad.Personal = @Personal 
         AND ad.Registro = 'Salida'
      
      UPDATE #KardexPersonal SET Entrada = @HoraEntrada 
       WHERE Empresa = @EmpresaCursor 
         AND FechaEmision = @FechaEmision 
         AND Personal = @Personal
       
      UPDATE #KardexPersonal SET Salida = @HoraSalida 
       WHERE Empresa = @EmpresaCursor 
         AND FechaEmision = @FechaEmision 
         AND Personal = @Personal
    END
  FETCH NEXT FROM crKardexPersonal INTO @EmpresaCursor, @FechaEmision, @Personal
  END
  CLOSE crKardexPersonal
  DEALLOCATE crKardexPersonal

  
  SELECT * 
    FROM #KardexPersonal 
ORDER BY Personal, 
         FechaEmision
  
END
GO

/************************************   spRepGASPresupuestoGastado *****************************************/
IF EXISTS(SELECT * FROM SysObjects WHERE ID = object_id('dbo.spRepGASPresupuestoGastado') and type = 'P') 
DROP PROCEDURE spRepGASPresupuestoGastado
GO
CREATE PROCEDURE spRepGASPresupuestoGastado
             @Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Empresa	    varchar(5),
          @FechaD		datetime,
          @FechaA		datetime,
          @Concepto	    varchar(50),
          @Moneda		varchar(15)

  SELECT @Empresa = rp.InfoEmpresa,
         @FechaD = rp.InfoFechaD,
         @FechaA = rp.InfoFechaA,
         @Concepto = rp.InfoConcepto,
         @Moneda = rp.InfoMoneda
   FROM RepParam rp
  WHERE rp.Estacion = @Estacion

  CREATE TABLE #Reporte (
    Concepto			varchar(50)	COLLATE Database_Default null,
    PresupuestoCantidad	float		null,
    PresupuestoPrecio	money		null,
    PresupuestoImporte	money		null,		

    DisminucionCantidad	float		null,
    DisminucionPrecio	money		null,
    DisminucionImporte	money		null,		

    GastadoCantidad		float		null,
    GastadoPrecio		money		null,
    GastadoImporte		money		null,		

    Moneda				varchar(15)	COLLATE Database_Default null)

  CREATE TABLE #Presupuesto (
    Concepto	varchar(50)	COLLATE Database_Default null,
    Cantidad	float		null,
    Precio		money		null,
    Importe		money		null,		
    Moneda		varchar(15)	COLLATE Database_Default null)

  CREATE TABLE #DisminucionPresupuesto (
    Concepto	varchar(50)	COLLATE Database_Default null,
    Cantidad	float		null,
    Precio		money		null,
    Importe		money		null,		
    Moneda		varchar(15)	COLLATE Database_Default null)

  CREATE TABLE #PresupuestoGastado (
  	Concepto	varchar(50)	COLLATE Database_Default null,
    Cantidad	float		null,
    Precio		money		null,
    Importe		money		null,		
    Moneda		varchar(15)	COLLATE Database_Default null)

  IF @Concepto IN ('','(Todos)','(Todas)','NULL') SELECT @Concepto = NULL
  IF @Moneda   IN ('','(Todos)','(Todas)','NULL') SELECT @Moneda = NULL

  INSERT #Presupuesto
  SELECT gd.Concepto,
         SUM(ISNULL(gd.Cantidad, 0)),
         SUM(ISNULL(gd.Precio, 0)),
         SUM(ISNULL(gd.Importe, 0)),
         g.Moneda
    FROM Gasto g
   INNER JOIN GastoD gd ON g.ID = gd.ID 
   INNER JOIN MovTipo mt ON g.Mov = mt.Mov 
                        AND mt.Modulo = 'GAS' 
                        AND mt.Clave = 'GAS.PR'
   WHERE g.Empresa = @Empresa 
     AND g.Estatus = 'CONCLUIDO' 
     AND g.FechaEmision BETWEEN @FechaD AND @FechaA 
     AND ISNULL(gd.Concepto, '') = ISNULL(ISNULL(@Concepto, gd.Concepto), '') 
     AND ISNULL(g.Moneda, '') = ISNULL(ISNULL(@Moneda, g.Moneda), '')
  GROUP BY g.Moneda, 
           gd.Concepto

  INSERT #DisminucionPresupuesto
  SELECT gd.Concepto,
         SUM(ISNULL(gd.Cantidad, 0)),
         SUM(ISNULL(gd.Precio, 0)),
         SUM(ISNULL(gd.Importe, 0)),
         g.Moneda
    FROM Gasto g
   INNER JOIN GastoD gd ON g.ID = gd.ID 
   INNER JOIN MovTipo mt ON g.Mov = mt.Mov 
                        AND mt.Modulo = 'GAS' 
                        AND mt.Clave = 'GAS.DPR'
  WHERE g.Empresa = @Empresa 
    AND g.Estatus = 'CONCLUIDO' 
    AND g.FechaEmision BETWEEN @FechaD AND @FechaA 
    AND ISNULL(gd.Concepto, '') = ISNULL(ISNULL(@Concepto, gd.Concepto), '') 
    AND ISNULL(g.Moneda, '') = ISNULL(ISNULL(@Moneda, g.Moneda), '')
  GROUP BY g.Moneda, 
           gd.Concepto

  INSERT #PresupuestoGastado
  SELECT gd.Concepto,
         SUM(ISNULL(gd.Cantidad, 0)),
         SUM(ISNULL(gd.Precio, 0)),
         SUM(ISNULL(gd.Importe, 0)),
         g.Moneda
    FROM Gasto g
   INNER JOIN GastoD gd ON g.ID = gd.ID 
   INNER JOIN MovTipo mt ON g.Mov = mt.Mov 
                        AND mt.Modulo = 'GAS' 
                        AND mt.Clave = 'GAS.G'
  WHERE g.Empresa = @Empresa 
    AND g.Estatus = 'CONCLUIDO' 
    AND g.FechaEmision BETWEEN @FechaD AND @FechaA 
    AND ISNULL(gd.Concepto, '') = ISNULL(ISNULL(@Concepto, gd.Concepto), '') 
    AND ISNULL(g.Moneda, '') = ISNULL(ISNULL(@Moneda, g.Moneda), '')
  GROUP BY g.Moneda, 
           gd.Concepto

  INSERT #Reporte (Concepto, PresupuestoCantidad, PresupuestoPrecio, PresupuestoImporte, Moneda)
    SELECT * FROM #Presupuesto

  UPDATE #Reporte SET DisminucionCantidad = Cantidad,
                      DisminucionPrecio = Precio,
                      DisminucionImporte = Importe
    FROM #DisminucionPresupuesto
   WHERE #Reporte.Concepto = #DisminucionPresupuesto.Concepto 
     AND #Reporte.Moneda = #DisminucionPresupuesto.Moneda
    
  UPDATE #Reporte SET GastadoCantidad = Cantidad,
                      GastadoPrecio = Precio,
                      GastadoImporte = Importe
    FROM #PresupuestoGastado
   WHERE #Reporte.Concepto = #PresupuestoGastado.Concepto 
     AND #Reporte.Moneda = #PresupuestoGastado.Moneda


  SELECT * 
    FROM #Reporte
END
GO

/*** ExplorarGestion ***/
if exists (select * from sysobjects where id = object_id('dbo.ExplorarGestion') and type = 'V') drop view dbo.ExplorarGestion
GO
CREATE VIEW ExplorarGestion
AS
SELECT
  g.ID,
  g.Empresa,
  g.Mov,
  g.MovID,
  ISNULL(RTRIM(g.Mov),'') + ' ' + ISNULL(RTRIM(g.MovID),'') Movimiento,
  NULLIF(RTRIM(ISNULL(RTRIM(g.Origen),'') + ' ' + ISNULL(RTRIM(g.OrigenID),'')),'') Rama,
  CASE WHEN EXISTS(SELECT 1 FROM Gestion g1 WHERE RTRIM(g1.Origen) = RTRIM(g.Mov) AND RTRIM(g1.OrigenID) = RTRIM(g.MovID) AND g1.Estatus IN ('PENDIENTE','CONCLUIDO')) THEN 1 ELSE 0 END EsAcumulativo,
  g.FechaEmision,
  g.UltimoCambio,
  g.Concepto,
  g.Proyecto,
  g.UEN,
  g.Usuario,
  g.Autorizacion,
  g.Referencia,
  g.DocFuente,
  g.Observaciones,
  g.Estatus,
  g.Situacion,
  g.SituacionFecha,
  g.SituacionUsuario,
  g.SituacionNota,
  g.RamaID,
  g.IDOrigen,
  g.OrigenTipo,
  g.Origen,
  g.OrigenID,
  g.Ejercicio,
  g.Periodo,
  g.FechaRegistro,
  g.FechaAutorizacion,
  g.FechaConclusion,
  g.FechaCancelacion,
  g.Sucursal,
  g.Asunto,
  g.Motivo,
  g.Espacio,
  g.Comentarios,
  g.FechaD,
  g.FechaA,
  g.HoraD,
  g.HoraA,
  g.TodoElDia,
  g.Duracion,
  g.Estado,
  g.EstadoAnterior,
  g.Avance,
  g.AvanceAnterior,
  g.Prioridad,
  g.PuedeDevolver,
  g.Mensaje,
  g.Gastos,
  g.SucursalOrigen,
  g.SucursalDestino
FROM
  Gestion g
WHERE Estatus IN ('PENDIENTE','CONCLUIDO','SINAFECTAR','BORRADOR')
GO

/**************** spAsisteNoReportoAsistenciaCalc  ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE ID = object_id('spAsisteNoReportoAsistenciaCalc') AND type = 'P') DROP PROCEDURE dbo.spAsisteNoReportoAsistenciaCalc
GO
CREATE PROCEDURE spAsisteNoReportoAsistenciaCalc
	    @Estacion	int,
	    @Empresa	varchar(5),
	    @FechaD	DateTime,
	    @FechaA	DateTime,
	    @ReportaA	varchar(20),
	    @Sucursal	int	= NULL,
	    @EnviarMail	bit	= NULL,
	    @DBMailPerfil	varchar(50) = NULL
--//WITH ENCRYPTION    
AS BEGIN
  DECLARE @FechaDiaria			DateTime,
  	  @FechaEmision			DateTime,
	  @Personal			varchar(10),
	  @Jornada			varchar(20),
	  @Estatus			varchar(20),
	  @DebeChecar			bit,
	  
	  @EmpresaNombre		varchar(100),
	  
	  @MensajePersonal		varchar(10),
	  @MensajeFecha			DateTime,
	  @Email			varchar(50),
	  @MensajePersonalActual	varchar(10),
	  @Mensaje			varchar(MAX),
	  @Titulo			varchar(100)

  CREATE TABLE #PersonalCheca	(
	Fecha		DateTime		NULL,
	Personal	varchar(10) COLLATE Database_Default NULL,
	Estatus		varchar(20) COLLATE Database_Default NULL,
	DebeChecar	bit)
    
  SELECT @EmpresaNombre = Nombre
    FROM Empresa e
   WHERE e.Empresa = @Empresa    

  
  -- Aqui se determina y se mete a una tabla temporal las personas que han tenido movimientos de Recursos Humanos
  SELECT r2.Personal,
	 r.FechaEmision,
	 r.Mov,
	 r.MovID,
	 r2.Jornada,
	 mt.Orden,
	 mt.Clave
    INTO #PersonalHist	 
    FROM RH r
   INNER JOIN RHD r2 ON r.ID = r2.ID
   INNER JOIN MovTipo mt ON r.Mov = mt.Mov
	                 AND mt.Modulo = 'RH'
		         AND mt.Clave IN ('RH.A', 'RH.B', 'RH.M')
   WHERE r.Estatus NOT IN ('CANCELADO', 'SINAFECTAR', 'BORRADOR')
     AND r.Empresa = @Empresa
     
   -- Aqui se hace un barrido de fechas y se determina que personas tienen que checar por cada dia.
   SELECT @FechaDiaria = @FechaD
    
   WHILE @FechaDiaria <= @FechaA
   BEGIN
     
     DECLARE crPersonal CURSOR LOCAL FOR
       SELECT p.Personal 
         FROM Personal p
         
        ORDER BY p.Personal
     OPEN crPersonal
     FETCH NEXT FROM crPersonal INTO @Personal
     WHILE @@FETCH_STATUS <> -1 
       BEGIN
       IF @@FETCH_STATUS <> -2 
         BEGIN
           SELECT @Jornada = NULL, 
                  @Estatus = NULL,
                  @DebeChecar = 0
        
     	   SELECT TOP(1) @Jornada = ph.Jornada,
     		         @Estatus = CASE WHEN ph.Clave IN ('RH.A', 'RH.M') THEN 'ALTA'
     					 ELSE 'BAJA'
     			            END,
     			 @DebeChecar = CASE WHEN ISNULL(jdf.EsLaborable, 1) = 1
     			                    THEN CASE ISNULL(@Estatus, 'BAJA') 
     			                         WHEN 'BAJA' THEN 0
     			                         ELSE CASE DatePart(dw,@FechaDiaria) 
     					              WHEN 1 THEN CASE WHEN j.Domingo = 0 THEN 1
     								       ELSE 0
     							          END
     					              WHEN 2 THEN CASE WHEN j.Lunes = 0 THEN 1
     								       ELSE 0
     						                  END
     					              WHEN 3 THEN CASE WHEN j.Martes = 0 THEN 1
     								       ELSE 0
     					                          END
     					              WHEN 4 THEN CASE WHEN j.Miercoles = 0 THEN 1
     								       ELSE 0	
     							          END
     					              WHEN 5 THEN CASE WHEN j.Jueves = 0 THEN 1
     								       ELSE 0
     						                  END
     					              WHEN 6 THEN CASE WHEN j.Viernes = 0 THEN 1
     								       ELSE 0 
     					                          END
     					              WHEN 7 THEN CASE WHEN j.Sabado = 0 THEN 1
     								       ELSE 0
     							          END
     					              END   
     			                         END
     			                    ELSE 0
     					END
     			 
             FROM #PersonalHist ph
             LEFT OUTER JOIN Jornada j ON ph.Jornada = j.Jornada
             LEFT OUTER JOIN JornadaDiaFestivo jdf ON j.Jornada = jdf.Jornada
						   AND jdf.Fecha = @FechaDiaria
            WHERE ph.FechaEmision <= @FechaDiaria
              AND ph.Personal = @Personal
              
            ORDER BY ph.FechaEmision DESC,
	             ph.Orden DESC
	             
	   IF @Estatus is NULL SELECT @Estatus = 'BAJA'
	   
	   INSERT #PersonalCheca (Fecha,        Personal,  Estatus,  DebeChecar)
	                   SELECT @FechaDiaria, @Personal, @Estatus, @DebeChecar
				
         END
         FETCH NEXT FROM crPersonal INTO @Personal
       END
     CLOSE crPersonal
     DEALLOCATE crPersonal
    	  
     SELECT @FechaDiaria = @FechaDiaria + 1
   END;     
   
    --Una vez que sabemos que personas debieron checar en cada dia, aqui se hace una vista temporal sobre el modulo de asistencias.
    WITH AsistePersonalCorte(FechaEmision, Personal) 
    AS
    (SELECT a.FechaEmision,
	   ad.Personal
      FROM Asiste a 
     INNER JOIN AsisteD ad ON a.ID = ad.ID
			   AND ad.Registro = 'Entrada'
     INNER JOIN Personal p ON ad.Personal = p.Personal
     INNER JOIN MovTipo mt ON mt.Modulo = 'ASIS'
  		           AND mt.Mov = a.Mov
		           AND mt.Clave = 'ASIS.R'
     WHERE a.Estatus NOT IN ('CANCELADO', 'SINAFECTAR', 'BORRADOR')
       AND a.FechaEmision BETWEEN @FechaD AND @FechaA
       AND a.Empresa = @Empresa)
      
      --Aqui se compara quien checó vs quien debía checar y lo mete a una tabla temporal
      SELECT pc.Fecha,
	     pc.Personal,
             Checo = CASE WHEN MAX(apc.Personal) IS NOT NULL THEN 1
			  ELSE 0
                     END
             INTO #PersonalnoChecoCalc
        FROM #PersonalCheca pc
        LEFT OUTER JOIN AsistePersonalCorte apc ON apc.Personal = pc.Personal
             					AND apc.FechaEmision = pc.Fecha
       WHERE pc.DebeChecar = 1 
      GROUP BY pc.Fecha,
	       pc.Personal 
      ORDER BY pc.Personal, 
               pc.Fecha
      
      --Aqui se filtra de la formula anterior para que solamente muestre los que no checaron
      SELECT pnc.Fecha,
	     pnc.Personal,
	     p.Nombre,
	     p.ApellidoPaterno,
	     p.ApellidoMaterno,
	     p.Empresa,
	     p.SucursalTrabajo,
	     Supervisor = p.ReportaA,
	     SupervisorNombre = p2.Nombre + ' ' + p2.ApellidoPaterno + ' ' + p2.ApellidoMaterno,
	     FechaD = @FechaD,
	     FechaA = @FechaA
	INTO #PersonalnoCheco
        FROM #PersonalnoChecoCalc pnc
        INNER JOIN Personal p ON pnc.Personal = p.Personal
        LEFT OUTER JOIN Personal p2 ON p.ReportaA = p2.Personal
       WHERE pnc.Checo = 0
         AND ((p.SucursalTrabajo = @Sucursal) OR (@Sucursal is NULL))
      ORDER BY pnc.Personal,
               pnc.Fecha

	--Aqui da el resultado cuando el reporte se pide en Texto
	IF ISNULL(@EnviarMail,0) = 0
	SELECT * 
	  FROM #PersonalnoCheco pnc
	 WHERE ISNULL(pnc.Supervisor,'') = ISNULL(NULLIF(@ReportaA,''), ISNULL(pnc.Supervisor,''))
	ORDER BY ISNULL(pnc.Supervisor, ''),
		 pnc.Personal
        
        --Aqui manda el E-mail cuando el reporte se pide en E-mail
        IF ISNULL(@EnviarMail,0) = 1
        BEGIN
          DECLARE crMail CURSOR LOCAL FOR
  	    SELECT pnc.Personal,
	           p.eMail,
	           pnc.Fecha
	      FROM #PersonalNoCheco pnc
	     INNER JOIN Personal p ON pnc.personal = p.Personal
	  OPEN crMail
	  FETCH NEXT FROM crMail INTO @MensajePersonal, @Email, @MensajeFecha
	  
	  SELECT @Mensaje = 'Nuestros Registros Muestran que usted no checó asistencia el(los) dia(s)'  		
	  SELECT @Titulo = 'Registro de No Asistencia a ' + @EmpresaNombre
	  
	  WHILE @@FETCH_STATUS <> -1 
          BEGIN
            IF @@FETCH_STATUS <> -2 
            BEGIN
              IF @MensajePersonalActual <> @MensajePersonal
              BEGIN
              	IF @Email LIKE '%@%' -- Se valida que el E-mail tenga una @
              	BEGIN
              	  EXEC msdb.dbo.sp_send_dbmail 
		    @profile_name =@DBMailPerfil,
                    @recipients=@Email,
                    @subject = @Titulo,
                    @body = @Mensaje,
                    @body_format = 'HTML'
                  
              --    INSERT AsisteEmailEnviado (Estacion,  Empresa,  FechaEnvio, Personal,		Email,  Titulo,  Mensaje,  Estatus)
		--		     VALUES (@Estacion, @Empresa, GETDATE(),  @MensajePersonal, @Email, @Titulo, @Mensaje, 'Enviado')				     
              	END
              	ELSE
              	  --INSERT AsisteEmailEnviado (Estacion,  Empresa,  FechaEnvio, Personal,		Email,  Titulo,  Mensaje,  Estatus)
		--		     VALUES (@Estacion, @Empresa, GETDATE(),  @MensajePersonal, @Email, @Titulo, @Mensaje, 'No Enviado')				     
              	
		SELECT @Mensaje = 'Nuestros Registros Muestran que usted no checó asistencia el(los) dia(s)'  		
              END
              SELECT @MensajePersonalActual = @MensajePersonal
	      SELECT @Mensaje = @Mensaje + ', ' + CONVERT(varchar, @MensajeFecha, 102)
	      --SELECT @MensajePersonal, @Email, @Mensaje
            END
            FETCH NEXT FROM crMail INTO @MensajePersonal, @Email, @MensajeFecha
          END
	  CLOSE crMail
	  DEALLOCATE crMail
	END
	   
END
GO

/**************** spAsisteNoReportoAsistencia  ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE ID = object_id('spAsisteNoReportoAsistencia') AND type = 'P') DROP PROCEDURE dbo.spAsisteNoReportoAsistencia
GO
CREATE PROCEDURE spAsisteNoReportoAsistencia
	     @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @InfoEmpresa   	varchar(5),
  	  @InfoSucursal		int,
  	  @InfoReportaA		varchar(10),	
	  @InfoFechaD		DateTime,
	  @InfoFechaA		DateTime


  SELECT @InfoEmpresa = rp.InfoEmpresa,
         @InfoSucursal = rp.InfoSucursal,
         @InfoReportaA = rp.InfoReportaA,
         @InfoFechaD = rp.InfoFechaD,
	 @InfoFechaA = rp.InfoFechaA 
    FROM RepParam rp	
   WHERE rp.Estacion = @Estacion
    
    EXEC spAsisteNoReportoAsistenciaCalc @Estacion, @InfoEmpresa, @InfoFechaD, @InfoFechaA, @InfoReportaA, @InfoSucursal
END	     
GO

/**************** spAsisteNoReportoAsistenciaEnviaEmail  ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE ID = object_id('spAsisteNoReportoAsistenciaEnviaEmail') AND type = 'P') DROP PROCEDURE dbo.spAsisteNoReportoAsistenciaEnviaEmail
GO
CREATE PROCEDURE spAsisteNoReportoAsistenciaEnviaEmail
	     @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @InfoEmpresa   	varchar(5),
  	  @InfoSucursal		int,
	  @InfoFechaD		DateTime,
	  @InfoFechaA		DateTime,
	  
	  @DBMailPerfil		varchar(50)
  

  SELECT @InfoEmpresa = rp.InfoEmpresa,
         @InfoSucursal = rp.InfoSucursal,
         @InfoFechaD = rp.InfoFechaD,
	 @InfoFechaA = rp.InfoFechaA 
    FROM RepParam rp	
   WHERE rp.Estacion = @Estacion
  
  SELECT @DBMailPerfil = eg.DBMailPerfil
    FROM EmpresaGral eg
   WHERE eg.Empresa = @InfoEmpresa
    
    DELETE AsisteEmailEnviado 
 --    WHERE Estacion = @Estacion 
   --    AND Empresa = @InfoEmpresa
          
    EXEC spAsisteNoReportoAsistenciaCalc @Estacion, @InfoEmpresa, @InfoFechaD, @InfoFechaA, @ReportaA = NULL, @Sucursal = @InfoSucursal, @EnviarMail = 1, @DBMailPerfil = @DBMailPerfil
    
    /*SELECT aee.Empresa,
	   aee.FechaEnvio,
	   aee.Personal,
	   aee.Email,
	   aee.Titulo,
	   aee.Mensaje,
	   aee.Estatus 
      FROM AsisteEmailEnviado aee
     WHERE aee.Estacion = @Estacion 
       AND aee.Empresa = @InfoEmpresa */
END	     
GO

/************************************  spRepReciboNomina *****************************************/
IF EXISTS(SELECT * FROM SysObjects WHERE ID = object_id('dbo.spRepReciboNomina') and type = 'P') 
DROP PROCEDURE spRepReciboNomina
go
CREATE PROCEDURE spRepReciboNomina
             @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    -- Parametros
	@Empresa			char(5),
	@Mov				varchar(20),
	@MovID				varchar(20),
	@PersonaEspecifica		varchar(10),
	@FormaPago			varchar(50),
	@Departamento			varchar(50),
	@Puesto				varchar(50),
	@Categoria			varchar(50),
	@Grupo				varchar(50),

	@Personal			varchar(10),
	@ID				int,
	@Sueldo				money,
	@OtrasPercepciones		money,
	@ISR				money,
	@IMSS				money,
	@OtrasDeducciones		money,
	@TotalEstadisticos		money,
	@TotalPercepciones		money,
	@TotalDeducciones		money,
	@PrimaVacacional		money,
	@Vales				money,
	@FondoAhorro			money,
	@DiasTrabajados			float

  SELECT @Empresa = rp.InfoEmpresa, 
         @Mov = rp.InfoMov,
         @MovID = rp.InfoMovID,
         @PersonaEspecifica = rp.InfoPersonal,
	 @FormaPago = rp.InfoFormaPago,
         @Departamento = rp.InfoDepartamento,
	 @Puesto = rp.InfoPuesto,
         @Categoria = rp.InfoCatPersonal,
         @Grupo = rp.InfoGrupoPersonal
    FROM RepParam rp
   WHERE rp.Estacion = @Estacion
    
  IF @PersonaEspecifica IN ('','NULL','(Todos)','(Todas)') SELECT @PersonaEspecifica = NULL
  IF @FormaPago IN ('','NULL','(Todos)','(Todas)') SELECT @FormaPago = NULL
  IF @Departamento IN ('','NULL','(Todos)','(Todas)') SELECT @Departamento = NULL
  IF @Puesto IN ('','NULL','(Todos)','(Todas)') SELECT @Puesto = NULL
  IF @Categoria IN ('','NULL','(Todos)','(Todas)') SELECT @Categoria = NULL
  IF @Grupo IN ('','NULL','(Todos)','(Todas)') SELECT @Grupo = NULL

  CREATE TABLE #Nomina(  
	ID				int,
	Personal			varchar(10)  COLLATE Database_Default NULL,
	DiasTrabajados			float,
	Sueldo				money,
	PrimaVacacional			money,
	Vales				money,
	OtrasPercepciones		money,
	TotalPercepciones		money,
	IMSS				money,
	ISR				money,
	FondoAhorro			money,
	OtrasDeducciones		money,
	TotalDeducciones		money,
	NetoPagado			money)

 INSERT INTO #Nomina (ID, Personal)
      SELECT n.ID, 
	      d.Personal
	FROM Nomina n 
	JOIN NominaD d ON n.ID = d.ID
	JOIN MovTipo mt ON mt.Modulo = 'NOM' 
			AND mt.Mov = n.Mov
	JOIN Personal p ON d.Personal = p.Personal
       WHERE n.Estatus = 'CONCLUIDO'
		AND (mt.Clave NOT IN ('NOM.N', 'NOM.NA', 'NOM.NE', 'NOM.NC') OR d.Movimiento IN ('Estadistica','Percepcion', 'Deduccion')) 
		AND n.Empresa = @Empresa
		AND n.Mov = @Mov
		AND n.MovID = @MovID
		AND ISNULL(d.Personal, '') = ISNULL(ISNULL(@PersonaEspecifica, d.Personal),'')
		AND ISNULL(p.Categoria, '') = ISNULL(ISNULL(@Categoria, p.Categoria),'')
		AND ISNULL(p.Grupo, '') = ISNULL(ISNULL(@Grupo, p.Grupo),'')
		AND ISNULL(p.Puesto, '') = ISNULL(ISNULL(@Puesto, p.Puesto),'')
		AND ISNULL(p.Departamento, '') = ISNULL(ISNULL(@Departamento, p.Departamento),'')
       GROUP BY d.Personal, n.ID

  DECLARE crNomina CURSOR LOCAL FOR
    SELECT ID, 
	Personal 
	FROM #Nomina
	GROUP BY Personal, ID
  OPEN crNomina
  FETCH NEXT FROM crNomina INTO @ID, @Personal
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @DiasTrabajados = Cantidad FROM NominaD  WHERE ID = @ID AND Personal = @Personal AND Concepto = 'Sueldo'
      -- Percepciones
      SELECT @Sueldo = SUM(Importe) FROM NominaD  WHERE ID = @ID AND Personal = @Personal AND Concepto = 'Sueldo'
      SELECT @PrimaVacacional = SUM(Importe) FROM NominaD  WHERE ID = @ID AND Personal = @Personal AND Concepto = 'Prima Vacacional'
      SELECT @Vales = SUM(Importe) FROM NominaD  WHERE ID = @ID AND Personal = @Personal AND Concepto = 'Vales Despensa'
      SELECT @OtrasPercepciones = SUM(ISNULL(Importe, 0)) FROM NominaD  WHERE ID = @ID AND Personal = @Personal AND Movimiento = 'Percepcion' AND Concepto NOT IN('Sueldo', 'Prima Vacacional','Vales Despensa')
      SELECT @TotalPercepciones = ISNULL(@Sueldo, 0) + ISNULL(@PrimaVacacional, 0) + ISNULL(@Vales, 0) + ISNULL(@OtrasPercepciones, 0)
      -- Deducciones
      SELECT @ISR = SUM(Importe) FROM NominaD  WHERE ID = @ID AND Personal = @Personal AND Concepto = 'ISR'
      SELECT @IMSS = SUM(Importe) FROM NominaD  WHERE ID = @ID AND Personal = @Personal AND Concepto = 'IMSS'
      SELECT @FondoAhorro = SUM(Importe) FROM NominaD  WHERE ID = @ID AND Personal = @Personal AND Concepto = 'Fondo Ahorro Compañia'
      SELECT @OtrasDeducciones = SUM(ISNULL(Importe, 0)) FROM NominaD  WHERE ID = @ID AND Personal = @Personal AND Movimiento = 'Deduccion' AND Concepto NOT IN ('ISR','IMSS','Fondo Ahorro Compañia')
	  SELECT @TotalDeducciones = ISNULL(@ISR, 0) + ISNULL(@IMSS, 0) + ISNULL(@FondoAhorro, 0) + ISNULL(@OtrasDeducciones, 0)

      UPDATE #Nomina SET DiasTrabajados = @DiasTrabajados,
				Sueldo = ISNULL(@Sueldo, 0),
                PrimaVacacional = ISNULL(@PrimaVacacional, 0),
				Vales = ISNULL(@Vales, 0),
				OtrasPercepciones = ISNULL(@OtrasPercepciones, 0), 

				ISR = ISNULL(@ISR, 0), 
				IMSS = ISNULL(@IMSS, 0),
                FondoAhorro = ISNULL(@FondoAhorro, 0),

				OtrasDeducciones = ISNULL(@OtrasDeducciones, 0), 
				TotalPercepciones = @TotalPercepciones,
				TotalDeducciones = @TotalDeducciones,
				NetoPagado = ISNULL(@TotalPercepciones, 0) - ISNULL(@TotalDeducciones, 0)
	WHERE ID = @ID 
		AND Personal = @Personal
				
    END
  FETCH NEXT FROM crNomina INTO @ID, @Personal
  END
  CLOSE crNomina
  DEALLOCATE crNomina
	  
	SELECT n.ID,
		Movimiento = n.Mov + ' ' + n.MovID,
		nt.Personal,
		Nombre = p.ApellidoPaterno + ' ' + p.ApellidoMaterno + ' ' + p.Nombre,
		nt.DiasTrabajados,
		nt.Sueldo,
        nt.PrimaVacacional,
        nt.Vales,
        nt.OtrasPercepciones,
		nt.TotalPercepciones,
        nt.NetoPagado,
		nt.IMSS,
		nt.ISR,
        nt.FondoAhorro,
		nt.OtrasDeducciones,
		nt.TotalDeducciones,
		NSS = p.Registro3,
		RFC = p.Registro2,
		CURP = p.Registro,
        Departamento = p.Departamento,
        Puesto = p.Puesto,
        NombreEmpresa = e.Nombre,
        PeriodoPago = n.Observaciones
	FROM #Nomina nt
	JOIN Nomina n ON nt.ID = n.ID
	JOIN Personal p ON nt.Personal = p.Personal
    JOIN Empresa e ON n.Empresa = e.Empresa
END
go

/**************** spEstadoCuenta3 ****************/					
if exists (select * from sysobjects where id = object_id('dbo.spEstadoCuenta3') and type = 'P')
 drop procedure dbo.spEstadoCuenta3
go 
CREATE PROCEDURE dbo.spEstadoCuenta3
	    @Estacion		int	  
--//WITH ENCRYPTION
AS BEGIN
   UPDATE RepParam  SET  RepParam.InfoCliente ='(Todos)',RepParam.InfoSucursal = NULL,RepParam.InfoMoneda='(Todas)',RepParam.InfoEstatusEspecifico = '(Todos)',RepParam.RepTitulo ='Estado de Cuenta por Sucursal' ,InfoClienteEnviarA = NULL
   WHERE Estacion = @Estacion
END
GO

/**************** spGenerarEstadoCuenta3 ****************/					
if exists (select * from sysobjects where id = object_id('dbo.spGenerarEstadoCuenta3') and type = 'P')
 drop procedure dbo.spGenerarEstadoCuenta3
go 
CREATE PROCEDURE dbo.spGenerarEstadoCuenta3
	    @Estacion			int	,
	    @Modulo				char(5) ,  
	    @Empresa			char(5)
--	    @FechaD				datetime,						BUG12844
--		@Cuenta				varchar(10), --Es el Cliente	BUG12844
--		@Sucursal			int,							BUG12844
--		@EstatusEspecifico	varchar(15) ,					BUG12844
--		@ClienteEnviarA		int,							BUG12844
--		@Moneda             varchar(20)						BUG12844
--//WITH ENCRYPTION
AS BEGIN

-- /* BUG12844
-- JGD 11Mayo2011 Ticket 3508. Se comenta ya que no se utiliza la tabla RepParam para la Consulta BUG12844
  DECLARE 
    @FechaA				datetime,
    @Cuenta				varchar(10),
    @Sucursal			int,
    @EstatusEspecifico	varchar(15) ,
	@ClienteEnviarA		int,
	@Moneda             varchar(20),
	@Titulo				varchar(100) -- BUG12844

  SELECT
    @FechaA	= InfoFechaA,
    @Cuenta	= InfoCliente,
    @Sucursal = InfoSucursalEdoCta,
    @EstatusEspecifico = InfoEstatusEspecifico,
	@ClienteEnviarA = InfoClienteEnviarA,
	@Moneda= InfoMoneda,
	@Titulo = RepTitulo
    FROM RepParam
   WHERE Estacion = @Estacion
--*/ BUG12844

  CREATE TABLE #CxcCuentaCorriente(
    Sucursal       int          NULL, 
    Empresa		     char(5)      NULL, 
    Rama           char(5)      NULL, 
    Moneda         char(10)     NULL, 
    Grupo          char(10)     NULL, 
    Cliente        char(20)     NULL, 
    Subcuenta      varchar(50)  NULL, 
    ClienteEnviarA int          NULL, 
    Estatus        varchar(15)  NULL,
    FechaRegistro  datetime     NULL,
    FechaConclusion  datetime		NULL,
    Efectivo       money        NULL, 
    Consumos       money        NULL, 
    Vales          money        NULL, 
    Redondeo       money        NULL
    )
    
  EXEC spExtraerFecha @FechaA OUTPUT
  SET @Cuenta = NULLIF(NULLIF(RTRIM(@Cuenta), ''),'(Todos)')
  SET @Sucursal = NULLIF(@Sucursal,-1)
  IF @EstatusEspecifico = 'Pendientes' SET @EstatusEspecifico = 'PENDIENTE' ELSE
  IF @EstatusEspecifico = 'Concluidos' SET @EstatusEspecifico = 'CONCLUIDO' ELSE
  SET @EstatusEspecifico = NULLIF(NULLIF(RTRIM(@EstatusEspecifico), ''),'(Todos)')
  SET @ClienteEnviarA  = NULLIF(RTRIM(@ClienteEnviarA ), '')
  SET @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''),'(Todas)')
  
  DELETE EstadoCuenta WHERE Estacion = @Estacion AND Modulo = @Modulo

  IF @Modulo = 'CXC' 
  BEGIN
    INSERT INTO #CxcCuentaCorriente(Sucursal, Empresa, Rama, Moneda, Grupo, Cliente, Subcuenta, ClienteEnviarA, Estatus, FechaRegistro, FechaConclusion, Efectivo, Consumos, Vales, Redondeo)
    SELECT
			a.Sucursal, 
			a.Empresa, 
			a.Rama, 
			a.Moneda, 
			a.Grupo, 
			"Cliente" = a.Cuenta, 
			a.Subcuenta,  
			c.ClienteEnviarA,
			c.Estatus,
			c.FechaRegistro,
			c.FechaConclusion,			
			"Efectivo" = SUM(ISNULL(a.Cargo,0))- SUM(ISNULL(a.Abono,0)),
			"Consumos" = CONVERT(money, NULL),
			"Vales" = CONVERT(money, NULL),
			"Redondeo" = CONVERT(money, NULL)

		FROM Auxiliar a
		JOIN Cxc c ON a.Modulo = 'CXC' AND a.ModuloID = c.ID

		WHERE 
			a.Rama = 'CEFE'

		GROUP BY 
			a.Sucursal, a.Empresa, a.Rama, a.Moneda, a.Grupo, a.Cuenta, a.Subcuenta, c.ClienteEnviarA, c.Estatus, c.FechaRegistro, c.FechaConclusion

		UNION
    SELECT
			a.Sucursal, 
			a.Empresa, 
			a.Rama, 
			a.Moneda, 
			a.Grupo, 
			"Cliente" = a.Cuenta, 
			a.Subcuenta,  
			v.EnviarA,
			v.Estatus,
			v.FechaRegistro,
			v.FechaConclusion,			
			"Efectivo" = CONVERT(money, NULL),
			"Consumos" = SUM(ISNULL(a.Cargo,0))- SUM(ISNULL(a.Abono,0)),
			"Vales" = CONVERT(money, NULL),
			"Redondeo" = CONVERT(money, NULL)

		FROM Auxiliar a
		JOIN Venta v ON a.Modulo = 'VTAS' AND a.ModuloID = v.ID

		WHERE 
			a.Rama = 'CNO'

		GROUP BY 
			a.Sucursal, a.Empresa, a.Rama, a.Moneda, a.Grupo, a.Cuenta, a.Subcuenta, v.EnviarA, v.Estatus, v.FechaRegistro, v.FechaConclusion

		--UNION
		--SELECT 
		--	a.Sucursal, 
		--	a.Empresa, 
		--	a.Rama, 
		--	a.Moneda, 
		--	a.Grupo, 
		--	"Cliente" = a.Cuenta, 
		--	a.Subcuenta,  
		--	c.ClienteEnviarA,
		--	c.Estatus,
		--	c.FechaRegistro,
		--	c.FechaConclusion,			
		--	"Efectivo" = CONVERT(money, NULL),
		--	"Consumos" = CONVERT(money, NULL),
		--	"Vales" = SUM(ISNULL(a.Cargo,0))- SUM(ISNULL(a.Abono,0)),
		--	"Redondeo" = CONVERT(money, NULL)

		--FROM Auxiliar a
		--JOIN Cxc c ON a.Modulo = 'CXC' AND a.ModuloID = c.ID

		--WHERE 
		--	a.Rama = 'CVALE'

		--GROUP BY 
		--  a.Sucursal, a.Empresa, a.Rama, a.Moneda, a.Grupo, a.Cuenta, a.Subcuenta, c.ClienteEnviarA, c.Estatus, c.FechaRegistro, c.FechaConclusion

		UNION
		SELECT 
			a.Sucursal, 
			a.Empresa, 
			a.Rama, 
			a.Moneda, 
			a.Grupo, 
			"Cliente" = a.Cuenta, 
			a.Subcuenta,  
			c.ClienteEnviarA,
			c.Estatus,
			c.FechaRegistro,
			c.FechaConclusion,			
			"Efectivo" = CONVERT(money, NULL),
			"Consumos" = CONVERT(money, NULL),
			"Vales" = CONVERT(money, NULL),
			"Redondeo" = SUM(ISNULL(a.Cargo,0))- SUM(ISNULL(a.Abono,0))

		FROM Auxiliar a
		JOIN Cxc c ON a.Modulo = 'CXC' AND a.ModuloID = c.ID

		WHERE 
			a.Rama = 'CRND'

		GROUP BY 
		  a.Sucursal, a.Empresa, a.Rama, a.Moneda, a.Grupo, a.Cuenta, a.Subcuenta, c.ClienteEnviarA, c.Estatus, c.FechaRegistro, c.FechaConclusion

    INSERT EstadoCuenta (Empresa, Estacion, Modulo, Cuenta, Efectivo, Consumos, Vales, Redondeo, Moneda, ClienteEnviarA) 
    SELECT @Empresa, @Estacion, @Modulo, Cliente, SUM(Efectivo), SUM(Consumos), SUM(Vales), SUM(Redondeo), Moneda, ClienteEnviarA
      FROM #CxcCuentaCorriente
     WHERE Empresa = @Empresa 
       AND Cliente = ISNULL(@Cuenta, Cliente)
       AND Moneda = ISNULL(@Moneda, Moneda) 
       AND ISNULL(ClienteEnviarA,'') = ISNULL(@ClienteEnviarA, ISNULL(ClienteEnviarA,''))
       AND Estatus NOT IN ('SINAFECTAR','CANCELADO')
       AND dbo.fnFechaSinHora(FechaRegistro) <= @FechaA
       AND Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN Estatus ELSE @EstatusEspecifico END
     GROUP BY Cliente, Moneda, ClienteEnviarA

    -- BUG12844
    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,   Moneda,   AuxiliarID, ModuloID,   Vencimiento,   Referencia,   ClienteEnviarA) 
                 SELECT  @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID,       a.ModuloID, c.Vencimiento, c.Referencia, c.ClienteEnviarA
                   FROM Auxiliar a JOIN Cxc c
                     ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Cxc ca
                     ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                     ON mt.Mov = ca.Mov JOIN MovTipo mt2
                     ON mt2.Mov = c.Mov 
                  WHERE a.Modulo = 'CXC'
                    AND mt2.Modulo = 'CXC'
                    AND ISNULL(mt2.Interno,0) = 0
                    AND mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.F', 'CXC.FAC', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP','CXC.CD', 'CXC.RM', 'CXC.IM', 'CXC.SD', 'CXC.SCH') 
                    AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                    AND dbo.fnFechaSinHora(c.FechaRegistro) <= @FechaA
                    AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaA))
                    AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                    AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
                    AND ISNULL(c.ClienteEnviarA,'') = ISNULL(@ClienteEnviarA, ISNULL(c.ClienteEnviarA,''))                   
                    AND a.Empresa = @Empresa --BUG13609
                    AND a.Moneda = ISNULL(@Moneda,a.Moneda) 
                  ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID

    -- BUG12844
--    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,   Moneda,   AuxiliarID, ModuloID,   Vencimiento,   Referencia) 
--                 SELECT  @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID,       a.ModuloID, c.Vencimiento, c.Referencia
--                   FROM Auxiliar a JOIN Dinero c
--                     ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Dinero ca
--                     ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
--                     ON mt.Mov = ca.Mov JOIN MovTipo mt2
--                     ON mt2.Mov = c.Mov 
--                  WHERE a.Modulo = 'DIN'
--                    AND mt2.Modulo = 'DIN'
--                    AND ISNULL(mt2.Interno,0) = 0
--                    AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH') 
--                    AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
--                    AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaA))
--                    AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
--                    AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
----                    AND a.Sucursal = ISNULL(@Sucursal, a.Sucursal)                    
--                    AND a.Moneda = ISNULL(@Moneda,a.Moneda) 
--                    AND a.Empresa = @Empresa --BUG13609
--                  ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID                  

    -- BUG12844
    --INSERT EstadoCuenta (Empresa, Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID,ClienteEnviarA)  -- BUG12844
    --SELECT  @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID,ISNULL(c.ClienteEnviarA,'') -- BUG12844
    --  FROM Auxiliar a, Cxc c, Cxc ca, MovTipo mt, Cte
    -- WHERE a.Empresa  = @Empresa AND a.Rama = @Modulo
    --   AND a.Aplica   = ca.Mov
    --   AND a.AplicaID = ca.MovID
    --   AND a.ModuloID = c.ID AND a.Rama = 'CXC'
    --   AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
    --   AND c.Empresa  = a.Empresa
    --   AND c.Cliente = ISNULL(@Cuenta, c.Cliente)
    --   AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
    --   AND c.Cliente = cte.Cliente
    --   AND ISNULL(cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, cte.SucursalEmpresa), -1)
    --   AND ca.Empresa = c.Empresa
    --   AND ca.Mov = mt.Mov AND mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.F', 'CXC.FAC', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP','CXC.CD', 'CXC.RM', 'CXC.IM',  'CXC.SCH') 
    --   AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaA))
    --   AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
	   --AND ISNULL(c.ClienteEnviarA,'') = ISNULL(@ClienteEnviarA, ISNULL(c.ClienteEnviarA,''))
	   --AND a.Moneda = ISNULL(@Moneda,a.Moneda) 
    -- ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID, ca.ClienteEnviarA

  END ELSE
  IF @Modulo = 'CXP'
  BEGIN
    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Efectivo, Vales, Redondeo, Moneda) 
    SELECT @Estacion, @Modulo, Proveedor, SUM(Efectivo), SUM(Vales), SUM(Redondeo), Moneda
      FROM CxpCuentaCorriente
     WHERE Empresa = @Empresa AND Proveedor = CASE WHEN @Cuenta IS NULL THEN Proveedor ELSE @Cuenta END
     GROUP BY Proveedor, Moneda

    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,   Moneda,   AuxiliarID, ModuloID,   Vencimiento,   Referencia) 
                 SELECT  @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID,       a.ModuloID, c.Vencimiento, c.Referencia    
                   FROM Auxiliar a JOIN Cxp c
                     ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Cxp ca
                     ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                     ON mt.Mov = ca.Mov JOIN MovTipo mt2
                     ON mt2.Mov = c.Mov 
                  WHERE a.Modulo = 'CXP'
                    AND mt2.Modulo = 'CXP'
                    AND ISNULL(mt2.Interno,0) = 0
                    AND mt.Clave IN ('CXP.A', 'CXP.F', 'CXP.D', 'CXP.DM', 'CXP.PAG', 'CXP.DA', 'CXP.DP', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP', 'CXP.CA', 'CXP.CAD', 'CXP.CAP','CXP.CD', 'CXP.FAC', 'CXP.SD', 'CXP.SCH')          
                    AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                    AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaA))
                    AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                    AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
--                    AND a.Sucursal = ISNULL(@Sucursal, a.Sucursal)                    
                    AND a.Moneda = ISNULL(@Moneda,a.Moneda) 
                    AND a.Empresa = @Empresa --BUG13609
                  ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID

    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,   Moneda,   AuxiliarID, ModuloID,   Vencimiento,   Referencia) 
                 SELECT  @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID,       a.ModuloID, c.Vencimiento, c.Referencia
                   FROM Auxiliar a JOIN Dinero c
                     ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Dinero ca
                     ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                     ON mt.Mov = ca.Mov JOIN MovTipo mt2
                     ON mt2.Mov = c.Mov 
                  WHERE a.Modulo = 'DIN'
                    AND mt2.Modulo = 'DIN'
                    AND ISNULL(mt2.Interno,0) = 0
                    AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH') 
                    AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                    AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaA))
                    AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                    AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
--                    AND a.Sucursal = ISNULL(@Sucursal, a.Sucursal)                    
                    AND a.Moneda = ISNULL(@Moneda,a.Moneda) 
                    AND a.Empresa = @Empresa --BUG13609
                  ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID                    
                  
    --INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    --SELECT @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
    --  FROM Auxiliar a, Cxp c, Cxp ca, MovTipo mt
    -- WHERE a.Empresa  = @Empresa AND Rama = @Modulo
    --   AND a.Aplica   = ca.Mov
    --   AND a.AplicaID = ca.MovID
    --   AND a.ModuloID = c.ID AND a.Modulo = 'CXP'
    --   AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
    --   AND c.Empresa  = a.Empresa
    --   AND ca.Empresa = c.Empresa
    --   AND ca.Proveedor = CASE WHEN @Cuenta IS NULL THEN ca.Proveedor ELSE @Cuenta END
    --   AND ca.Mov = mt.Mov AND mt.Clave IN ('CXP.A', 'CXP.F', 'CXP.D', 'CXP.DM', 'CXP.PAG', 'CXP.DA', 'CXP.DP', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP', 'CXP.CA', 'CXP.CAD', 'CXP.CAP','CXP.CD', 'CXP.FAC', 'CXP.SD', 'CXP.SCH') 
    --   AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaA))
    --   AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
    -- ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID
   END
END
GO

/**************** NominaDImporte ****************/
if exists (select * from sysobjects where id = object_id('dbo.NominaDImporte') and type = 'V') drop view dbo.NominaDImporte
GO
CREATE VIEW NominaDImporte
AS
SELECT
    nd.ID,
    cd.NumeroCta,
	cd.BancoSucursal,
    cd.CtaDinero,
	
    SUM(CASE nd.Movimiento WHEN 'Percepcion' THEN nd.Importe ELSE 0.0 END) - SUM(CASE nd.Movimiento WHEN 'Deduccion' THEN nd.Importe ELSE 0.0 END) AS Importe
  FROM NominaD nd JOIN Personal p
    ON p.Personal = nd.Personal
  JOIN CtaDinero cd
    ON p.CtaDinero=cd.CtaDinero
 WHERE nd.Personal IS NOT NULL
 GROUP BY nd.ID, p.CtaDinero,cd.NumeroCta,cd.BancoSucursal,cd.CtaDinero
GO


/**************** NumeroRegistro ****************/
if exists (select * from sysobjects where id = object_id('dbo.NumeroRegistro') and type = 'V') drop view dbo.NumeroRegistro
GO
CREATE VIEW NumeroRegistro
AS
SELECT
    nd.ID,
    COUNT(DISTINCT(nd.Personal)) NumReg,
    p.CtaDinero,
    cd.NumeroCta,
    cd.BancoSucursal	
  FROM NominaD nd JOIN Personal p
    ON p.Personal = nd.Personal JOIN CtaDinero cd
    ON p.CtaDinero = cd.CtaDinero
 WHERE nd.Personal IS NOT NULL
 GROUP BY nd.ID, p.CtaDinero, cd.NumeroCta, cd.BancoSucursal
GO

/**************** NominaDImportePersonal ****************/
if exists (select * from sysobjects where id = object_id('dbo.NominaDImportePersonal') and type = 'V') drop view dbo.NominaDImportePersonal
GO
CREATE VIEW NominaDImportePersonal
AS
SELECT
    nd.ID,
    nd.Personal,
    cd.NumeroCta,
	cd.BancoSucursal,
    p.PersonalCuenta,
	p.Nombre,
	p.ApellidoPaterno,
	p.ApellidoMaterno,
	cd.CtaDinero ,
    SUM(CASE nd.Movimiento WHEN 'Percepcion' THEN nd.Importe ELSE 0.0 END) - SUM(CASE nd.Movimiento WHEN 'Deduccion' THEN nd.Importe ELSE 0.0 END) AS Importe
  FROM NominaD nd JOIN Personal p
    ON p.Personal = nd.Personal
  JOIN CtaDinero cd
    ON p.CtaDinero=cd.CtaDinero
 WHERE nd.Personal IS NOT NULL
 GROUP BY nd.ID, p.CtaDinero,cd.NumeroCta,cd.BancoSucursal,cd.CtaDinero,nd.Personal,p.PersonalCuenta,p.Nombre,
	p.ApellidoPaterno,	p.ApellidoMaterno
GO






/**************** spLayoutNominaBanamexD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutNominaBanamexD') and type = 'P') drop procedure dbo.spLayoutNominaBanamexD
GO             
CREATE PROCEDURE spLayoutNominaBanamexD
		@Estacion			int,
	    @Empresa			varchar(5),
		@Mov				varchar(20),
		@MovID				varchar(20),
		@NumeroCliente		varchar(10),
		@Consecutivo			int,
		@Descripcion		varchar(20),
		@Cuenta  			varchar(10),
		@Sucursal			varchar(50),
		@Ok					int					OUTPUT,
		@OkRef				varchar(255)		OUTPUT
		

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@ID					int
	

  SELECT @ID= ID FROM Nomina WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID



  SELECT
    '1' +
    dbo.fnRellenarCerosIzquierda(@NumeroCliente		,12)+
	dbo.fnFormatearFecha(n.FechaEmision,'DDMMAA') +
    dbo.fnRellenarCerosIzquierda(@Consecutivo,4) +
    dbo.fnRellenarEspaciosDerecha(SUBSTRING(e.Nombre,1,36),36) +
    dbo.fnRellenarEspaciosDerecha(@Descripcion,20) +
    '15' +
	'D' +
	'01' AS COLUMN1
    FROM Nomina n JOIN Empresa e
	  ON n.Empresa = e.Empresa
   WHERE RTRIM(n.Empresa) = RTRIM(@Empresa)
	 AND n.ID = @ID 
  UNION ALL
  SELECT 
	'2' +
	'1' +
	'001' +
	dbo.fnFormatearNumero( ndi.Importe,16,2) +
	'01' +
	dbo.fnRellenarCerosIzquierda(ndi.BancoSucursal,3) +
	dbo.fnRellenarCerosIzquierda(ndi.CtaDinero ,17) +
	dbo.fnRellenarCerosIzquierda(nr.NumReg,6) AS COLUMN1	
    FROM Nomina n JOIN NominaDImporte ndi   
      ON n.ID = ndi.ID JOIN NumeroRegistro nr
	  ON nr.ID = ndi.ID
   WHERE ndi.CtaDinero = @Cuenta AND ndi.BancoSucursal = @Sucursal
	 AND nr.CtaDinero = @Cuenta AND nr.BancoSucursal = @Sucursal
	 AND  n.ID = @ID 
  UNION ALL
  SELECT
	'3' +
	'0' +
	'001' +
	'01' +
	'001' +
	dbo.fnFormatearNumero(ndip.Importe,16,2) +
	'03' +
	dbo.fnRellenarCerosIzquierda(ndip.PersonalCuenta,20) +
	dbo.fnRellenarEspaciosDerecha('Pago Banamex',16) +
	dbo.fnRellenarEspaciosDerecha (RTRIM(ISNULL(ndip.Nombre,'')) + ',' + RTRIM(ISNULL(ndip.ApellidoPaterno,'')) + '/' + RTRIM(ISNULL(ndip.ApellidoMaterno,'')),55) +
	dbo.fnRellenarEspaciosDerecha (' ',35) +
	dbo.fnRellenarEspaciosDerecha (' ',35) +
	dbo.fnRellenarEspaciosDerecha (' ',35) +
	dbo.fnRellenarEspaciosDerecha (' ',35) +
	'0000' +
	'00' +
	dbo.fnRellenarEspaciosDerecha (' ',14) +
	dbo.fnRellenarEspaciosDerecha (' ',8) AS COLUMN1
	 FROM Nomina n JOIN NominaDImportePersonal ndip   
      ON n.ID = ndip.ID 
    WHERE ndip.CtaDinero = @Cuenta AND ndip.BancoSucursal = @Sucursal
	AND  n.ID = @ID 
UNION ALL
SELECT 
	'4' +
	'001' +
	dbo.fnRellenarCerosIzquierda(nr.NumReg,6) +
	dbo.fnFormatearNumero( ndi.Importe,16,2) +
    dbo.fnRellenarCerosIzquierda('1',6) +
	dbo.fnFormatearNumero( ndi.Importe,16,2) AS COLUMN1
	FROM Nomina n JOIN NominaDImporte ndi   
      ON n.ID = ndi.ID JOIN NumeroRegistro nr
	  ON nr.ID = ndi.ID
   WHERE ndi.CtaDinero = @Cuenta AND ndi.BancoSucursal = @Sucursal
	 AND nr.CtaDinero = @Cuenta AND nr.BancoSucursal = @Sucursal
	 AND n.ID = @ID 
   
  IF @@ERROR <> 0 SET @Ok = 1
END
GO




/**************** spLayoutNominaBancomer ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutNominaBancomer') and type = 'P') drop procedure dbo.spLayoutNominaBancomer
GO             
CREATE PROCEDURE spLayoutNominaBancomer
		@Estacion			int,
	    @Empresa			varchar(5),
		@Mov				varchar(20),
		@MovID				varchar(20),
		@NumeroCliente		varchar(10),
		@Consecutivo        varchar(50),
		@Cuenta  			varchar(10),
		@Sucursal			varchar(50),
		@Descripcion		varchar(50),
		@Ok					int					OUTPUT,
		@OkRef				varchar(255)		OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

	@ID					int,
	@Numero				int,
	@Texto				varchar(MAX)
  DECLARE	@Resultado	table 
		(
		Texto	varchar(4000)
		)
	

  
  SELECT @ID= ID FROM Nomina WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID


  DECLARE crContador CURSOR FOR
  SELECT
    dbo.fnRellenarCerosIzquierda (@Empresa,5) + 
	dbo.fnRellenarEspaciosDerecha (e.RFC,16) +
	dbo.fnRellenarCerosIzquierda ( @Consecutivo,9) +
	'99' +
	dbo.fnRellenarCerosIzquierda ( ndi.CtaDinero,12) +
	dbo.fnRellenarCerosIzquierda ('',12) +
	dbo.fnFormatearNumero( ndi.Importe,13,2) +
	dbo.fnFormatearFecha(n.FechaEmision,'AAAAMMDD') +
	dbo.fnRellenarCerosIzquierda ('',8) +
	'01' +
	dbo.fnRellenarEspaciosDerecha ('',40) +	
	'{INC0001}' +
	dbo.fnRellenarCerosIzquierda (ndi.BancoSucursal,6) +
	dbo.fnRellenarCerosIzquierda ('99',3) +
	dbo.fnRellenarCerosIzquierda ('03',3) +
	dbo.fnRellenarCerosIzquierda('',16) +
	dbo.fnRellenarEspaciosDerecha ('',12) +
	dbo.fnRellenarEspaciosDerecha ('.',1) 
	

    FROM Nomina n JOIN Empresa e
	  ON n.Empresa = e.Empresa JOIN NominaDImporte ndi   
      ON n.ID = ndi.ID 

   WHERE RTRIM(n.Empresa) = RTRIM(@Empresa)
	 AND n.ID = @ID 
  UNION ALL

  SELECT 
	dbo.fnRellenarCerosIzquierda (@Empresa,5) +   
    dbo.fnRellenarEspaciosDerecha (p.Registro2,16) +
	dbo.fnRellenarEspaciosDerecha(' ',9) +
	'99' +
	dbo.fnRellenarCerosIzquierda ( ndip.CtaDinero,12) +
	dbo.fnRellenarCerosIzquierda (ndip.PersonalCuenta,12) +
    dbo.fnFormatearNumero(ndip.Importe ,13,2) +
	dbo.fnFormatearFecha(n.FechaEmision,'AAAAMMDD') +
	dbo.fnRellenarCerosIzquierda ('',8) +
	dbo.fnRellenarCerosIzquierda ('01',2) +
	dbo.fnRellenarEspaciosDerecha (RTRIM(ISNULL(ndip.Nombre,'')) + ',' + RTRIM(ISNULL(ndip.ApellidoPaterno,'')) + '/' + RTRIM(ISNULL(ndip.ApellidoMaterno,'')),40) +
    '{INC0001}' +
	dbo.fnRellenarCerosIzquierda (ndip.BancoSucursal,6) +
	dbo.fnRellenarCerosIzquierda ('99',3) +
	dbo.fnRellenarCerosIzquierda ('03',3) +
	dbo.fnRellenarCerosIzquierda (ndip.PersonalCuenta,16) +
	dbo.fnRellenarEspaciosDerecha (' ',12) +
	dbo.fnRellenarEspaciosDerecha ('.',1)
  FROM NominaDImportePersonal	ndip JOIN Personal p
	ON p.Personal = ndip.Personal
  JOIN Nomina n
    ON n.ID = ndip.ID
  WHERE ndip.CtaDinero = @Cuenta AND ndip.BancoSucursal = @Sucursal
   
 UNION ALL
 SELECT
    dbo.fnRellenarCerosIzquierda (@Empresa,5) + 
	dbo.fnRellenarEspaciosDerecha ('T',16) +
	dbo.fnRellenarCerosIzquierda ( @Consecutivo,9) +
	'99' +
	dbo.fnRellenarCerosIzquierda ( ndi.CtaDinero,12) +
	dbo.fnRellenarCerosIzquierda ('',12) +
	dbo.fnFormatearNumero( ndi.Importe,13,2) +
	dbo.fnFormatearFecha(n.FechaEmision,'AAAAMMDD') +
	dbo.fnRellenarCerosIzquierda ('',8) +
	'01' +
	dbo.fnRellenarEspaciosDerecha (' ',40) +	
	'{INC0001}' +
	dbo.fnRellenarCerosIzquierda (ndi.BancoSucursal,6) +
	dbo.fnRellenarCerosIzquierda ('99',3) +
	dbo.fnRellenarCerosIzquierda ('03',3) +
	dbo.fnRellenarCerosIzquierda('',16) +
	dbo.fnRellenarEspaciosDerecha (' ',12) +
	dbo.fnRellenarEspaciosDerecha ('.',1)	
    FROM Nomina n JOIN Empresa e
	  ON n.Empresa = e.Empresa JOIN NominaDImporte ndi   
      ON n.ID = ndi.ID JOIN NumeroRegistro nr
	  ON nr.ID = ndi.ID

  SET @Numero = 1
  OPEN crContador
  FETCH NEXT FROM  crContador INTO @Texto
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    INSERT  INTO @Resultado VALUES (REPLACE(@Texto,'{INC0001}',CONVERT(varchar,dbo.fnRellenarCerosIzquierda(@Numero,5))))
    IF @@ERROR <> 0 SET @Ok = 1

    SET @Numero = @Numero + 1
    FETCH NEXT FROM crContador INTO @Texto
  END
  CLOSE crContador
  DEALLOCATE crContador
  
  IF @Ok IS NULL
  BEGIN
    SELECT Texto AS COLUMN1 FROM @Resultado 
    IF @@ERROR <> 0 SET @Ok = 1
  END

END
GO




/**************** spLayoutNominaSantander ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutNominaSantander ') and type = 'P') drop procedure spLayoutNominaSantander 
GO             
CREATE PROCEDURE dbo.spLayoutNominaSantander

		@Estacion			int,
	    @Empresa			varchar(10),
		@Mov				varchar(20),
		@MovID				varchar(20),
		@NumeroCliente		varchar(10),
		@Consecutivo		int,
		@Descripcion		varchar(20),
		@Cuenta  			varchar(10),
		@Sucursal			varchar(50),
		@FechaAplicacion    datetime ,
		@Ok					int					OUTPUT,
		@OkRef				varchar(255)		OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	
	@ID					int,
	@Numero				int,
	@Texto				varchar(MAX)

	DECLARE	@Resultado	table 
		(
		Texto	varchar(4000)
		)
	
  SELECT @ID= ID FROM Nomina WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID

  DECLARE crContador CURSOR FOR
  SELECT 
    '1' +
   '{INC0001}' +
	'E' +
	dbo.fnFormatearFecha(n.FechaEmision,'MMDDAAAA') +
	dbo.fnRellenarCerosIzquierda(ndi.CtaDinero,16) +
	dbo.fnFormatearFecha(@FechaAplicacion,'MMDDAAAA') 
    FROM Nomina n JOIN NominaDImporte ndi  
      ON n.ID = ndi.ID JOIN NumeroRegistro nr
	  ON nr.ID = ndi.ID
   WHERE ndi.CtaDinero = @Cuenta AND ndi.BancoSucursal = @Sucursal
	 AND nr.CtaDinero = @Cuenta AND nr.BancoSucursal = @Sucursal 
	 AND @ID = n.ID  
  UNION ALL
  SELECT
	'2' +
	'{INC0001}' +
	dbo.fnRellenarEspaciosIzquierda (ndip.Personal,7) +
	dbo.fnRellenarEspaciosDerecha (RTRIM(ISNULL(ndip.ApellidoPaterno,'')),30) +
	dbo.fnRellenarEspaciosDerecha (RTRIM(ISNULL(ndip.ApellidoMaterno,'')),20) +
	dbo.fnRellenarEspaciosDerecha (RTRIM(ISNULL(ndip.Nombre,'')),30) +
	dbo.fnRellenarEspaciosDerecha (ndip.PersonalCuenta,16) +
	dbo.fnFormatearNumero(ndip.Importe,16,2)  
   FROM Nomina n JOIN NominaDImportePersonal ndip   
      ON n.ID = ndip.ID JOIN NumeroRegistro nr
	  ON nr.ID = ndip.ID
   WHERE ndip.CtaDinero = @Cuenta AND ndip.BancoSucursal = @Sucursal
	 AND nr.CtaDinero = @Cuenta AND nr.BancoSucursal = @Sucursal
	 AND @ID = n.ID	
  UNION ALL
  SELECT
	'3' +
	'{INC0001}' +
	dbo.fnFormatearNumero( ndi.Importe,16,2)
    FROM Nomina n JOIN NominaDImporte ndi  
      ON n.ID = ndi.ID JOIN NumeroRegistro nr
	  ON nr.ID = ndi.ID  
   WHERE ndi.CtaDinero = @Cuenta AND ndi.BancoSucursal = @Sucursal
	 AND nr.CtaDinero = @Cuenta AND nr.BancoSucursal = @Sucursal 
	 AND @ID = n.ID
 
  SET @Numero = 1
  OPEN crContador
  FETCH NEXT FROM  crContador INTO @Texto
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    INSERT  INTO @Resultado VALUES (REPLACE(@Texto,'{INC0001}',CONVERT(varchar,dbo.fnRellenarCerosIzquierda(@Numero,5))))
    SET @Numero = @Numero + 1
    FETCH NEXT FROM crContador INTO @Texto
  END
  CLOSE crContador
  DEALLOCATE crContador

  SELECT Texto AS COLUMN1 FROM @Resultado
    IF @@ERROR <> 0 SET @Ok = 1
  END

GO


/**************** spLayoutNominaInbursa ****************/
if exists (select * from sysobjects where id = object_id('spLayoutNominaInbursa') and type = 'P') drop procedure spLayoutNominaInbursa
GO             
CREATE PROCEDURE spLayoutNominaInbursa
        @Estacion			int,
	    @Empresa			varchar(5),
		@Mov				varchar(20),
		@MovID				varchar(20),
		@NumeroCliente		varchar(10),
		@Cuenta  			varchar(10),
		@Sucursal			varchar(50),
		@Consecutivo		int		,
		@Ok					int					OUTPUT,
		@OkRef				varchar(255)		OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

    @ID					int,
	@Numero				int,
	@Texto				varchar(Max)

	DECLARE	@Resultado	table 
		(
		Texto	varchar(4000)
		)


  SELECT @ID= ID FROM Nomina WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID

  DECLARE crContador CURSOR FOR
  SELECT
   
	'{INC0001}' +
	',' +
	ndip.Personal +
	',' +
	RTRIM(ISNULL(ndip.Nombre,'')) + ' ' + RTRIM(ISNULL(ndip.ApellidoPaterno,'')) + ' ' + RTRIM(ISNULL(ndip.ApellidoMaterno,'')) +
	',' +
	ndip.PersonalCuenta +
	',' +
	dbo.fnRellenarCerosIzquierda(dbo.fnFormatearNumero2(ndip.Importe,2),15)  

  FROM Nomina n JOIN NominaDImportePersonal ndip   
    ON n.ID = ndip.ID   AND @ID = n.ID	

  SET @Numero = 1
  OPEN crContador
  FETCH NEXT FROM  crContador INTO @Texto
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    INSERT  INTO @Resultado VALUES (REPLACE(@Texto,'{INC0001}',CONVERT(varchar,dbo.fnRellenarCerosIzquierda(@Numero,5))))
    SET @Numero = @Numero + 1
    FETCH NEXT FROM crContador INTO @Texto
  END
  CLOSE crContador
  DEALLOCATE crContador
    SELECT Texto AS COLUMN1 FROM @Resultado 
    IF @@ERROR <> 0 SET @Ok = 1
  END
GO




/**************** spLayoutNominaBanorte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutNominaBanorte ') and type = 'P') drop procedure dbo.spLayoutNominaBanorte 
GO             
CREATE PROCEDURE spLayoutNominaBanorte 
		@Estacion			int,
	    @Empresa			varchar(5),
		@Mov				varchar(20),
		@MovID				varchar(20),
		@NumeroCliente		varchar(10),
		@Consecutivo		int,
		@Descripcion		varchar(50),
		@Cuenta  			varchar(10),
		@Sucursal			varchar(50),
		@Ok					int					OUTPUT,
		@OkRef				varchar(255)		OUTPUT
		

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE

    @ID					int


  SELECT @ID= ID FROM Nomina WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID

  SELECT
	'H' +
	'NE' +
    dbo.fnRellenarCerosIzquierda (ndi.BancoSucursal,8) +
	dbo.fnFormatearFecha(n.FechaEmision,'AAAAMMDD') +
    dbo.fnRellenarCerosIzquierda(@Consecutivo,2) +
    dbo.fnRellenarCerosIzquierda(nr.NumReg,6) +
	dbo.fnFormatearNumero( ndi.Importe,13,2) +
	dbo.fnRellenarCerosIzquierda('',6)+
	dbo.fnRellenarCerosIzquierda('',15) +
	dbo.fnRellenarCerosIzquierda('',6) +
	dbo.fnRellenarCerosIzquierda('',15) +
	dbo.fnRellenarCerosIzquierda('',6) +
	'1' +
	dbo.fnRellenarEspaciosDerecha (' ',77)  AS COLUMN1

    FROM Nomina n JOIN NominaDImporte ndi  
      ON n.ID = ndi.ID JOIN NumeroRegistro nr
	  ON nr.ID = ndi.ID
   WHERE ndi.CtaDinero = @Cuenta AND ndi.BancoSucursal = @Sucursal
	 AND nr.CtaDinero = @Cuenta AND nr.BancoSucursal = @Sucursal 
	 AND @ID = n.ID 

UNION ALL
SELECT
	'D' +
    dbo.fnFormatearFecha(n.FechaEmision,'AAAAMMDD') +
	dbo.fnRellenarCerosIzquierda(ndip.Personal,10) +
	dbo.fnRellenarEspaciosDerecha (' ',40) +
	dbo.fnRellenarEspaciosDerecha (' ',40) +
	dbo.fnFormatearNumero( ndip.Importe,13,2) +
	'072' +
	'01' +
	dbo.fnRellenarCerosIzquierda(ndip.PersonalCuenta ,18) +
	'0' +
	' ' +
	dbo.fnRellenarCerosIzquierda('',8) +
	dbo.fnRellenarEspaciosDerecha (' ',18)  AS COLUMN1
    FROM Nomina n JOIN NominaDImportePersonal ndip   
      ON n.ID = ndip.ID JOIN NumeroRegistro nr
	  ON nr.ID = ndip.ID JOIN Personal p
	  ON p.Personal = ndip.Personal
   WHERE ndip.CtaDinero = @Cuenta AND ndip.BancoSucursal = @Sucursal
	 AND nr.CtaDinero = @Cuenta AND nr.BancoSucursal = @Sucursal
   IF @@ERROR <> 0 SET @Ok = 1 

END
GO



/**************** spLayoutNomina ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLayoutNomina') and type = 'P') drop procedure dbo.spLayoutNomina
GO             
CREATE PROCEDURE spLayoutNomina
		@Estacion			int,
		@Ok				    int					OUTPUT,
	    @OkRef			    varchar(255)		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion	    varchar(50),
	@LayoutNomina       varchar(100),
	@Empresa			varchar(5),
	@Mov				varchar(20),
	@MovID				varchar(20),
	@NumeroCliente		varchar(10),
	@Consecutivo			int,
	@Descripcion		varchar(20),
	@Cuenta  			varchar(10),
	@Sucursal			varchar(50),
	@FechaAplicacion    datetime
	
	   
	
  SET @Ok = NULL
  SET @OkRef = NULL

  SET @Transaccion = 'spLayoutNomina' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  BEGIN TRANSACTION @Transaccion

  SELECT
	@LayoutNomina = InfoLayoutNomina,
	@Empresa = InfoEmpresa,
	@Mov = InfoMov,
	@MovID = InfoMovID,
	@NumeroCliente = InfoNumeroCliente,
	@Consecutivo = InfoConsecutivo,
	@Descripcion = InfoDescripcion,
	@Cuenta = InfoCtaDinero,
	@Sucursal = InfoSucursal,
	@FechaAplicacion = InfoFechaD
    FROM RepParam
   WHERE Estacion = @Estacion

  IF @LayoutNomina = 'Banamex'
	EXEC spLayoutNominaBanamexD @Estacion  , @Empresa , @Mov , @MovID , @NumeroCliente , @Consecutivo , @Descripcion , @Cuenta , @Sucursal , @Ok OUTPUT , @OkRef OUTPUT
  ELSE
  IF @LayoutNomina = 'Santander'
	EXEC spLayoutNominaSantander @Estacion , @Empresa , @Mov , @MovID , @NumeroCliente , @Consecutivo , @Descripcion	, @Cuenta , @Sucursal , @FechaAplicacion , @Ok 	OUTPUT , @OkRef OUTPUT
  ELSE
  IF @LayoutNomina = 'Bancomer'
	EXEC spLayoutNominaBancomer  @Estacion  , @Empresa , @Mov , @MovID , @NumeroCliente , @Consecutivo , @Cuenta , @Sucursal , @Descripcion , @Ok OUTPUT , @OkRef OUTPUT
  ELSE
  IF @LayoutNomina = 'Inbursa'
    EXEC spLayoutNominaInbursa @Estacion  , @Empresa , @Mov , @MovID , @Cuenta , @Sucursal , @NumeroCliente , @Consecutivo , @Ok OUTPUT, @OkRef OUTPUT	
  ELSE
  IF @LayoutNomina = 'Banorte'
    EXEC spLayoutNominaBanorte 	@Estacion , @Empresa , @Mov , @MovID , @NumeroCliente , @Consecutivo , @Descripcion	, @Cuenta , @Sucursal , @Ok OUTPUT , @OkRef 		OUTPUT
		


  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION @Transaccion
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO

/**************** spGastoInventariable ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoInventariable') and type = 'P') drop procedure dbo.spGastoInventariable
GO             
CREATE PROCEDURE spGastoInventariable
		@Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
	@Empresa		varchar(5),
	@Sucursal		int,
	@Fecha			datetime,
	@Concepto		varchar(20),
	@Cantidad		float,
	@Importe		money,
	@Disponible		float,
	@CostoPromedio		float

  DECLARE @Tabla    table(
          Empresa        varchar(5),
          Sucursal       int,
          Concepto       varchar(20),
          Descripcion    varchar(50),
          Disponible     float,
          CostoPromedio  float,
          InvSeguridad   float,
          CantidadMinima float,
          CantidadMaxima float
                             )

  SELECT  @Empresa = InfoEmpresa,
          @Sucursal = InfoSucursal,
          @Fecha = InfoFechaA,
          @Concepto = InfoConcepto
    FROM  RepParam 
   WHERE Estacion = @Estacion

  INSERT INTO @Tabla  
  SELECT g.Empresa , g.Sucursal, gd.Concepto, c.Descripcion, SUM(gd.Cantidad * mt.Factor) AS Disponible, (SUM(gd.Importe)/SUM(gd.Cantidad * mt.Factor)) AS CostoPromedio, c.InvSeguridad , c.CantidadMinima, c.CantidadMaxima
    FROM GastoD gd JOIN Gasto G ON gd.ID = g.ID
    JOIN Concepto c ON gd.Concepto = c.Concepto
    JOIN dbo.MovTipo mt ON mt.Mov = g.Mov
   WHERE g.Empresa = @Empresa 
--     AND g.Sucursal = @Sucursal  -- (el reporte no filtra por concepto)
     AND gd.Concepto = ISNULL(NULLIF(@Concepto,''),gd.Concepto)
     AND gd.Fecha <= @Fecha
	 AND c.EsInventariable = 1
     AND mt.Modulo = 'GAS' 
     AND g.Estatus = 'CONCLUIDO'
     AND mt.Clave = 'GAS.CI'
  GROUP BY g.Empresa, g.Sucursal, gd.Concepto, c.Descripcion, c.InvSeguridad , c.CantidadMinima, c.CantidadMaxima		
  SELECT * FROM @Tabla
END
GO
