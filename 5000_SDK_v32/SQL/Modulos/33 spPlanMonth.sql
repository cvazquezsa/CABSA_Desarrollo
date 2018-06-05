/* SP PLANEACION Month     */

SET ANSI_NULLS OFF
SET DATEFIRST 7
SET NOCOUNT ON

/*** PlanCentroMonthRuta ***/
if exists (select * from sysobjects where id = object_id('dbo.PlanCentroMonthRuta') and sysstat & 0xf = 2) drop view dbo.PlanCentroMonthRuta
GO
CREATE VIEW PlanCentroMonthRuta
--//WITH ENCRYPTION
AS 
SELECT Empresa, Ruta, "Periodo" = CONVERT(int, CASE WHEN FechaEntrega < GETDATE() THEN -1 ELSE ISNULL(DATEDIFF(Month, GETDATE(), FechaEntrega), 0) END), Estado, "Cantidad" = SUM(Cantidad)
  FROM PlanArtOP
 WHERE Accion = 'Producir' AND LiberacionID IS NULL
 GROUP BY Empresa, Ruta, CONVERT(int, CASE WHEN FechaEntrega < GETDATE() THEN -1 ELSE ISNULL(DATEDIFF(Month, GETDATE(), FechaEntrega), 0) END), Estado
UNION
  SELECT e.Empresa, d.Ruta, "Periodo" = CONVERT(int, CASE WHEN e.FechaEntrega < GETDATE() THEN -1 ELSE ISNULL(DATEDIFF(Month, GETDATE(), e.FechaEntrega), 0) END),
         Estado = CASE WHEN e.Estatus = 'PENDIENTE' THEN 'Ordenado' ELSE 'Liberado' END,
         SUM(CASE WHEN e.Estatus = 'PENDIENTE' THEN d.CantidadPendiente ELSE d.Cantidad END*d.Factor)
    FROM Prod e, ProdD d, MovTipo mt
   WHERE e.ID = d.ID AND e.Estatus IN ('PENDIENTE', 'CONFIRMAR')
     AND mt.Modulo = 'PROD' AND mt.Mov = e.Mov AND mt.Clave = 'PROD.O'
   GROUP BY e.Empresa, d.Ruta, CONVERT(int, CASE WHEN e.FechaEntrega < GETDATE() THEN -1 ELSE ISNULL(DATEDIFF(Month, GETDATE(), e.FechaEntrega), 0) END), e.Estatus
  HAVING SUM(CASE WHEN e.Estatus = 'PENDIENTE' THEN d.CantidadPendiente ELSE d.Cantidad END*d.Factor) > 0
GO


/*** PlanCentroMonthCarga ***/
if exists (select * from sysobjects where id = object_id('dbo.PlanCentroMonthCarga') and sysstat & 0xf = 2) drop view dbo.PlanCentroMonthCarga
GO
CREATE VIEW PlanCentroMonthCarga
--//WITH ENCRYPTION
AS 
SELECT p.Empresa, r.Centro, p.Periodo, p.Estado, "Carga" = ISNULL(SUM(r.TiempoFijo), 0.0) + ISNULL(SUM(r.TiempoVariable*p.Cantidad), 0.0)
  FROM PlanCentroMonthRuta p, ProdRutaD r
 WHERE p.Ruta = r.Ruta
 GROUP BY p.Empresa, r.Centro, p.Periodo, p.Estado
GO

/*** PlanCentroMonthCargaTotal ***/
if exists (select * from sysobjects where id = object_id('dbo.PlanCentroMonthCargaTotal') and sysstat & 0xf = 2) drop view dbo.PlanCentroMonthCargaTotal
GO
CREATE VIEW PlanCentroMonthCargaTotal
--//WITH ENCRYPTION
AS 
SELECT Empresa, Centro, Periodo, "CargaTotal" = SUM(Carga)
  FROM PlanCentroMonthCarga
 GROUP BY Empresa, Centro, Periodo
GO

/*** PlanEstacionCapacidadCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.PlanEstacionCapacidadCalc') and sysstat & 0xf = 2) drop view dbo.PlanEstacionCapacidadCalc
GO
CREATE VIEW PlanEstacionCapacidadCalc
--//WITH ENCRYPTION
AS 
SELECT Estacion, Centro, Estatus, "Capacidad" = DiasSemana*TurnosDiarios*HorasTurno*(Eficiencia/100)*(Utilizacion/100)
  FROM EstacionT
GO


/*** PlanCentroMonthCapacidadCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.PlanCentroMonthCapacidadCalc') and sysstat & 0xf = 2) drop view dbo.PlanCentroMonthCapacidadCalc
GO
CREATE VIEW PlanCentroMonthCapacidadCalc
--//WITH ENCRYPTION
AS 
SELECT Centro, "Capacidad" = SUM(Capacidad)
  FROM PlanEstacionCapacidadCalc
 WHERE UPPER(Estatus) = 'ALTA'
 GROUP BY Centro
GO

/*** PlanCentroMonthCapacidadCalc10**/
if exists (select * from sysobjects where id = object_id('dbo.PlanCentroMonthCapacidadCalc10') and sysstat & 0xf = 2) drop view dbo.PlanCentroMonthCapacidadCalc10
GO
CREATE VIEW PlanCentroMonthCapacidadCalc10
--//WITH ENCRYPTION
AS 
SELECT Centro, Capacidad, Periodo
  FROM PlanCentroMonthCapacidadCalc, Plan10
GO


/*** PlanCentroMonthCapacidadDif **/
if exists (select * from sysobjects where id = object_id('dbo.PlanCentroMonthCapacidadDif') and sysstat & 0xf = 2) drop view dbo.PlanCentroMonthCapacidadDif
GO
CREATE VIEW PlanCentroMonthCapacidadDif
--//WITH ENCRYPTION
AS 
SELECT ct.Empresa, cap.Centro, cap.Periodo, "Diferencia" = ISNULL(SUM(cap.Capacidad), 0.0)-ISNULL(SUM(ct.CargaTotal), 0.0)
  FROM PlanCentroMonthCapacidadCalc10 cap
  LEFT OUTER JOIN PlanCentroMonthCargaTotal ct ON cap.Centro = ct.Centro AND cap.Periodo = ct.Periodo
 GROUP BY ct.Empresa, cap.Centro, cap.Periodo
GO

-- exec spPlanCentroMonth 'DEMO'
/**************** spPlanCentroMonth ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanCentroMonth') and type = 'P') drop procedure dbo.spPlanCentroMonth
GO
CREATE PROCEDURE spPlanCentroMonth
			@Empresa 	char(5),
			@Centro		char(10) = NULL
--//WITH ENCRYPTION
AS BEGIN 
  SELECT @Centro = NULLIF(RTRIM(@Centro), '')

  CREATE TABLE #PlanCentroMonth (Centro varchar(10) COLLATE Database_Default NULL , Descripcion varchar(100) COLLATE Database_Default NULL, Tipo varchar(20) COLLATE Database_Default NULL, Periodo int NULL, Cantidad float NULL, Nombre varchar(20) COLLATE Database_Default NULL, Renglon int NULL)
  INSERT #PlanCentroMonth (Centro, Descripcion, Tipo, Periodo, Cantidad, Nombre, Renglon)

  SELECT c.Centro, c.Descripcion, c.Tipo, p.Periodo, "Cantidad" = p.Carga, "Nombre" = p.Estado, Renglon = 1 
    FROM Centro c, PlanCentroMonthCarga p
   WHERE c.Centro = p.Centro AND p.Empresa = @Empresa AND p.Centro = CASE @Centro WHEN NULL THEN p.Centro ELSE @Centro END

  UNION

  SELECT c.Centro, c.Descripcion, c.Tipo, p.Periodo, "Cantidad" = p.CargaTotal, "Nombre" = 'Carga Total', Renglon = 5 
    FROM Centro c, PlanCentroMonthCargaTotal p
   WHERE c.Centro = p.Centro AND p.Empresa = @Empresa AND p.Centro = CASE @Centro WHEN NULL THEN p.Centro ELSE @Centro END

  UNION
  SELECT c.Centro, c.Descripcion, c.Tipo, p.Periodo, "Cantidad" = p.Capacidad, "Nombre" = 'Capacidad Calculada', Renglon = 6 
    FROM Centro c, PlanCentroMonthCapacidadCalc10 p
   WHERE c.Centro = p.Centro AND p.Centro = CASE @Centro WHEN NULL THEN p.Centro ELSE @Centro END

  UNION

  SELECT c.Centro, c.Descripcion, c.Tipo, p.Periodo, "Cantidad" = ABS(p.Diferencia), "Nombre" = CASE WHEN p.Diferencia < 0.0 THEN 'Capacidad Faltante' ELSE 'Capacidad Excedente' END, Renglon = CASE WHEN p.Diferencia < 0.0 THEN 8 ELSE 7 END
    FROM Centro c, PlanCentroMonthCapacidadDif p
   WHERE c.Centro = p.Centro AND p.Empresa = @Empresa AND p.Centro = CASE @Centro WHEN NULL THEN p.Centro ELSE @Centro END

  SELECT * FROM #PlanCentroMonth
  ORDER BY Centro, Descripcion, Tipo, Renglon, Nombre
END
GO

/**************** spPlanArtMonth ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtMonth') and type = 'P') drop procedure dbo.spPlanArtMonth
GO
CREATE PROCEDURE spPlanArtMonth
			@Empresa		char(5),
			@Periodos		int,
    			@Articulo		char(20),
			@Hoy			datetime,
			@CfgPlanSinDemanda	bit,
			@CfgPlanISDemanda	bit,
			@CfgPlanIgnorarDemanda	bit,
			@Categoria	    	varchar(50) = NULL,
			@Grupo		    	varchar(50) = NULL,
			@Familia	    	varchar(50) = NULL,
			@Fabricante	    	varchar(50) = NULL,
			@Linea		    	varchar(50) = NULL,
			@Temporada	    	varchar(50) = NULL,
			@ProveedorEspecifico 	char(10)    = NULL,
			@Referencia		varchar(50) = NULL,
			@ReferenciaModulo	varchar(5)  = NULL,
			@ReferenciaActividad	varchar(50) = NULL

--//WITH ENCRYPTION
AS BEGIN   
  DECLARE
    @Almacen		    		char(10),
    @AlmacenROP		    		char(10),
    @RutaDistribucion	    		varchar(50),
    @RutaDistribucionNivelArticulo	bit,
    @TiempoEntrega	    		int,
    @TiempoEntregaUnidad    		varchar(10),
    @TiempoEntregaSeg	    		int, 
    @TiempoEntregaSegUnidad 		varchar(10),
    @FechaRequerida	    		datetime,
    @CfgExcluirPlaneacionDetalle	bit,
    @CfgPlanPlanearServicios		bit    

  SELECT @CfgExcluirPlaneacionDetalle = VentaExcluirPlaneacionDetalle, 
	 @CfgPlanPlanearServicios = ISNULL(PlanPlanearServicios,0)
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  --BUG15156
  IF @Referencia IS NOT NULL AND @ReferenciaModulo IN('PROY', 'INV', 'VTAS')
    -- Agregar Existencia (E)
    INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo) 
    SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'E', ISNULL(SUM(d.Disponible), 0), -1
      FROM ArtSubDisponible d, Art a, Alm
     WHERE d.Empresa = @Empresa AND NULLIF(d.Almacen, '') IS NOT NULL
       AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
       AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
       AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
       AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
     GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen
   
  IF @Referencia IS NOT NULL AND @ReferenciaModulo = 'PROY'
  BEGIN
    INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
    SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'PV', ISNULL(SUM(d.CantidadPendiente*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
           CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
      FROM Venta e, VentaD d, MovTipo mt, Art a, Alm 
     WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' /*AND e.Extra = 0 */
       AND 0 = CASE WHEN @CfgExcluirPlaneacionDetalle = 1 THEN d.ExcluirPlaneacion ELSE e.ExcluirPlaneacion END
       AND mt.Modulo = 'VTAS' AND mt.Mov = e.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX')
       AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
       --AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
       AND e.Proyecto = @Referencia AND ISNULL(e.Actividad,'') = ISNULL(NULLIF(RTRIM(@ReferenciaActividad),''),ISNULL(e.Actividad,'')) 
       AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
       AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
     GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
    HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

    INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
    SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'SOL', ISNULL(SUM(d.CantidadPendiente*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
           CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
      FROM Inv e, InvD d, MovTipo mt, Art a, Alm
     WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
       AND mt.Modulo = 'INV' AND mt.Mov = e.Mov AND mt.Clave = 'INV.SOL'
       AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
       --AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
       AND e.Proyecto = @Referencia AND ISNULL(e.Actividad,'') = ISNULL(NULLIF(RTRIM(@ReferenciaActividad),''),ISNULL(e.Actividad,'')) 
       AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
       AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
     GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
    HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/


    RETURN
  END


  IF @Referencia IS NOT NULL AND @ReferenciaModulo = 'VTAS'
  BEGIN
    INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
    SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'PV', ISNULL(SUM(d.CantidadPendiente*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
           CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
      FROM Venta e, VentaD d, MovTipo mt, Art a, Alm 
     WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' /*AND e.Extra = 0 */
       AND 0 = CASE WHEN @CfgExcluirPlaneacionDetalle = 1 THEN d.ExcluirPlaneacion ELSE e.ExcluirPlaneacion END
       AND mt.Modulo = 'VTAS' AND mt.Mov = e.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX')
       AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
       --AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
       AND RTRIM(e.Mov)+' '+RTRIM(e.MovID) = @Referencia
       AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
       AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
     GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
    HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

    RETURN
  END
 
  IF @Referencia IS NOT NULL AND @ReferenciaModulo = 'INV'
  BEGIN
    INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
    SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'SOL', ISNULL(SUM(d.CantidadPendiente*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
           CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
      FROM Inv e, InvD d, MovTipo mt, Art a, Alm
     WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
       AND mt.Modulo = 'INV' AND mt.Mov = e.Mov AND mt.Clave = 'INV.SOL'
       AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
       --AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
       AND RTRIM(e.Mov)+' '+RTRIM(e.MovID) = @Referencia
       AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
       AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
     GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
    HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

    RETURN
  END

  SELECT @RutaDistribucion = RutaDistribucion, 
         @RutaDistribucionNivelArticulo = RutaDistribucionNivelArticulo 
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF @CfgPlanSinDemanda = 1 OR @CfgPlanISDemanda = 0
    INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
             SELECT @Empresa, aa.Almacen, aa.Articulo, ISNULL(aa.SubCuenta, ''), 'IS', aa.Minimo, -1
               FROM ArtAlm aa, Art a, Alm
              WHERE aa.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
                AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
                AND ISNULL(aa.Minimo, 0) > 0 
                AND aa.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
                AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)

  IF @CfgPlanISDemanda = 1
  BEGIN
    DECLARE crISDemanda CURSOR FOR 
     SELECT ISNULL(a.TiempoEntrega, 0), a.TiempoEntregaUnidad, ISNULL(a.TiempoEntregaSeg, 0), a.TiempoEntregaSegUnidad, pa.Almacen, a.AlmacenROP, CASE WHEN @RutaDistribucionNivelArticulo = 1 THEN RutaDistribucion ELSE @RutaDistribucion END
       FROM PlanArt pa, Art a
      WHERE pa.Empresa = @Empresa AND pa.Articulo = a.Articulo AND Acronimo = 'IS'

    OPEN crISDemanda
    FETCH NEXT FROM crISDemanda INTO @TiempoEntrega, @TiempoEntregaUnidad, @TiempoEntregaSeg, @TiempoEntregaSegUnidad, @Almacen, @AlmacenROP, @RutaDistribucion
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Almacen <> '(Demanda)' AND @Almacen <> @AlmacenROP AND NULLIF(RTRIM(@RutaDistribucion), '') IS NOT NULL
        BEGIN
          SELECT @TiempoEntrega = 0, @TiempoEntregaSeg = 0
          SELECT @TiempoEntrega       = TiempoEntrega, 
                 @TiempoEntregaUnidad = TiempoEntregaUnidad
            FROM RutaDistribucionD
           WHERE Ruta = @RutaDistribucion AND AlmacenDestino = @Almacen
        END
        EXEC spIncTiempo @Hoy, @TiempoEntrega, @TiempoEntregaUnidad, @FechaRequerida OUTPUT
        IF ISNULL(@TiempoEntregaSeg, 0) <> 0.0
          EXEC spIncTiempo @FechaRequerida, @TiempoEntregaSeg, @TiempoEntregaSegUnidad, @FechaRequerida OUTPUT
  	UPDATE PlanArt SET Periodo = ISNULL(DATEDIFF(Month, @Hoy, @FechaRequerida), 0) WHERE CURRENT OF crISDemanda
      END
      FETCH NEXT FROM crISDemanda INTO @TiempoEntrega, @TiempoEntregaUnidad, @TiempoEntregaSeg, @TiempoEntregaSegUnidad, @Almacen, @AlmacenROP, @RutaDistribucion
    END
    CLOSE crISDemanda
    DEALLOCATE crISDemanda
  END

-- ISNULL(CASE WHEN @PlanProy=1 THEN v.Proyecto ELSE NULL END, '')
  -- Presupuesto (PRV)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
  SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'PRV', SUM(d.Cantidad*d.Factor), ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0)
    FROM Venta v, VentaD d, MovTipo mt, Art a, Alm
   WHERE v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus IN ('CONCLUIDO', 'PENDIENTE')
     AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.PR'
     AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND d.FechaRequerida >= @Hoy 
     AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0)
  HAVING SUM(d.Cantidad*d.Factor) > 0 

  IF @CfgPlanIgnorarDemanda = 0
  BEGIN
     -- Pedidos (PV)
    INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
    SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'PV', ISNULL(SUM(d.CantidadPendiente*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
           CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
      FROM Venta e, VentaD d, MovTipo mt, Art a, Alm 
     WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' AND e.Extra = 0 
       AND 0 = CASE WHEN @CfgExcluirPlaneacionDetalle = 1 THEN d.ExcluirPlaneacion ELSE e.ExcluirPlaneacion END
       AND mt.Modulo = 'VTAS' AND mt.Mov = e.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX')
       AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
       AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
       AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
       AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
     GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
    HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

    -- Pedidos Extraordinarios (PVE)
    INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
    SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'PVE', ISNULL(SUM(d.CantidadPendiente*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
           CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
      FROM Venta e, VentaD d, MovTipo mt, Art a, Alm
     WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' AND e.Extra = 1 
       AND 0 = CASE WHEN @CfgExcluirPlaneacionDetalle = 1 THEN d.ExcluirPlaneacion ELSE e.ExcluirPlaneacion END
       AND mt.Modulo = 'VTAS' AND mt.Mov = e.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX')
       AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
       AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
       AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
       AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
      GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
     HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

    -- Solicitudes (SOL)
    INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
    SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'SOL', ISNULL(SUM(d.CantidadPendiente*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
           CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
      FROM Inv e, InvD d, MovTipo mt, Art a, Alm
     WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
       AND mt.Modulo = 'INV' AND mt.Mov = e.Mov AND mt.Clave = 'INV.SOL'
       AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
       AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
       AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
       AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
     GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
    HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/
  END

  -- Ordenes Transferencia (OT)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo, OrigenPlan)
  SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'OT', ISNULL(SUM(ISNULL(d.CantidadPendiente, 0.0)*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
         CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END,
         CASE WHEN e.OrigenTipo = 'PLAN' THEN 1 ELSE 0 END
    FROM Inv e, InvD d, MovTipo mt, Art a, Alm
   WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
     AND mt.Modulo = 'INV' AND mt.Mov = e.Mov AND mt.Clave = 'INV.OT'
     AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END, CASE WHEN e.OrigenTipo = 'PLAN' THEN 1 ELSE 0 END
  HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

  -- Ordenes Traspaso Salida (OI)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo, OrigenPlan)
  SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'OI', ISNULL(SUM(ISNULL(d.CantidadPendiente, 0.0)*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
         CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END,
         CASE WHEN e.OrigenTipo = 'PLAN' THEN 1 ELSE 0 END
    FROM Inv e, InvD d, MovTipo mt, Art a, Alm
   WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
     AND mt.Modulo = 'INV' AND mt.Mov = e.Mov AND mt.Clave = 'INV.OI'
     AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END, CASE WHEN e.OrigenTipo = 'PLAN' THEN 1 ELSE 0 END
  HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

  -- Recibo Ordenes Compra (OC)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
  SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'OC', SUM(d.CantidadPendiente*d.Factor), 
         CASE WHEN d.FechaEntrega < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaEntrega), 0) END
    FROM Compra e, CompraD d, MovTipo mt, Art a, Alm
   WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE'
     AND mt.Modulo = 'COMS' AND mt.Mov = e.Mov AND mt.Clave IN ('COMS.O', 'COMS.OG','COMS.OI')
     AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaEntrega < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaEntrega), 0) END
  HAVING SUM(d.CantidadPendiente*d.Factor) > 0

  -- Recibo Ordenes Produccion (OP)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
  SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'OP', SUM(d.CantidadPendiente*d.Factor), 
         CASE WHEN e.FechaEntrega < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, e.FechaEntrega), 0) END
    FROM Prod e, ProdD d, MovTipo mt, Art a, Alm
   WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
     AND mt.Modulo = 'PROD' AND mt.Mov = e.Mov AND mt.Clave = 'PROD.O'
     AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN e.FechaEntrega < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, e.FechaEntrega), 0) END
  HAVING SUM(d.CantidadPendiente*d.Factor) > 0

  -- Ordenes Transferencia Entrada (ROT)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
  SELECT @Empresa, e.AlmacenDestino, d.Articulo, ISNULL(d.SubCuenta, ''), 'ROT', ISNULL(SUM(ISNULL(d.CantidadPendiente, 0.0)+ISNULL(d.CantidadReservada, 0.0)*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
         CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
    FROM Inv e, InvD d, MovTipo mt, Art a, Alm
   WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
     AND mt.Modulo = 'INV' AND mt.Mov = e.Mov AND mt.Clave = 'INV.OT'
     AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND e.AlmacenDestino = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), e.AlmacenDestino, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
  HAVING SUM(d.CantidadPendiente*d.Factor) > 0 OR SUM(d.CantidadReservada*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

  -- Ordenes Traspaso Entrada (ROI)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
  SELECT @Empresa, e.AlmacenDestino, d.Articulo, ISNULL(d.SubCuenta, ''), 'ROI', ISNULL(SUM(ISNULL(d.CantidadPendiente, 0.0)+ISNULL(d.CantidadReservada, 0.0)*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
         CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
    FROM Inv e, InvD d, MovTipo mt, Art a, Alm
   WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
     AND mt.Modulo = 'INV' AND mt.Mov = e.Mov AND mt.Clave = 'INV.OI'
     AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND e.AlmacenDestino = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), e.AlmacenDestino, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
  HAVING SUM(d.CantidadPendiente*d.Factor) > 0 OR SUM(d.CantidadReservada*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

  -- En Transito Entrada (RTI)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
  SELECT @Empresa, e.AlmacenDestino, d.Articulo, ISNULL(d.SubCuenta, ''), 'RTI', ISNULL(SUM(d.CantidadPendiente*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
         CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
    FROM Inv e, InvD d, MovTipo mt, Art a, Alm 
   WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus IN ('PENDIENTE', 'SINCRO')
     AND mt.Modulo = 'INV' AND mt.Mov = e.Mov AND mt.Clave IN ('INV.TI', 'INV.T')
     AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND e.AlmacenDestino = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), e.AlmacenDestino, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
  HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

  -- Agregar Existencia (E)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo) 
  SELECT @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'E', ISNULL(SUM(d.Disponible), 0), -1
    FROM ArtSubDisponible d, Art a, Alm
   WHERE d.Empresa = @Empresa AND NULLIF(d.Almacen, '') IS NOT NULL
     AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen

  -- Recibos Programados (RP)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
  SELECT @Empresa, pa.Almacen, pa.Articulo, ISNULL(pa.SubCuenta, ''), 'RP', SUM(pa.Cantidad), pa.Periodo
    FROM PlanArt pa, Art a, Alm
   WHERE pa.Empresa = @Empresa AND pa.Acronimo IN ('OC', 'OP', 'ROT', 'ROI', 'RTI')
     AND pa.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND pa.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY pa.Articulo, ISNULL(pa.SubCuenta, ''), pa.Almacen, pa.Periodo

  -- Recibos Ordenes Programadas en Firme (ROPF)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
  SELECT @Empresa, pa.Almacen, pa.Articulo, ISNULL(pa.SubCuenta, ''), 'ROPF', SUM(pa.Cantidad),
         CASE WHEN pa.FechaEntrega < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, pa.FechaEntrega), 0) END
    FROM PlanArtOP pa, Art a, Alm
   WHERE pa.Empresa = @Empresa AND UPPER(pa.Estado) <> 'PLAN' AND UPPER(pa.Accion) IN ('COMPRAR', 'PRODUCIR') --AND LiberacionID IS NULL
     AND pa.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND pa.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY pa.Articulo, ISNULL(pa.SubCuenta, ''), pa.Almacen, CASE WHEN pa.FechaEntrega < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, pa.FechaEntrega), 0) END
  HAVING SUM(pa.Cantidad) > 0

  -- Recibos Ordenes Distribucion en Firme (RODF)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
  SELECT @Empresa, pa.AlmacenDestino, pa.Articulo, ISNULL(pa.SubCuenta, ''), 'REPF', SUM(pa.Cantidad),
         CASE WHEN pa.FechaEntrega < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, pa.FechaEntrega), 0) END
    FROM PlanArtOP pa, Art a, Alm
   WHERE pa.Empresa = @Empresa AND UPPER(pa.Estado) <> 'PLAN' AND UPPER(pa.Accion) = 'DISTRIBUIR' --AND LiberacionID IS NULL
     AND pa.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND pa.AlmacenDestino = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY pa.Articulo, ISNULL(pa.SubCuenta, ''), pa.AlmacenDestino, CASE WHEN pa.FechaEntrega < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, pa.FechaEntrega), 0) END
  HAVING SUM(pa.Cantidad) > 0

  -- Salida Ordenes Distribucion en Firme (RODF)
  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
  SELECT @Empresa, pa.Almacen, pa.Articulo, ISNULL(pa.SubCuenta, ''), 'SODF', SUM(pa.Cantidad),
         CASE WHEN pa.FechaEntrega < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, pa.FechaEntrega), 0) END
    FROM PlanArtOP pa, Art a, Alm
   WHERE pa.Empresa = @Empresa AND UPPER(pa.Estado) <> 'PLAN' AND UPPER(pa.Accion) = 'DISTRIBUIR' --AND LiberacionID IS NULL
     AND pa.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
     AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
     AND pa.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
     AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
   GROUP BY pa.Articulo, ISNULL(pa.SubCuenta, ''), pa.Almacen, CASE WHEN pa.FechaEntrega < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, pa.FechaEntrega), 0) END
  HAVING SUM(pa.Cantidad) > 0

  RETURN
END
GO

/**************** spPlanDemandaMonth ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanDemandaMonth') and type = 'P') drop procedure dbo.spPlanDemandaMonth
GO
CREATE PROCEDURE spPlanDemandaMonth
			@Estacion		int,
			@Empresa		char(5),
    			@Articulo		char(20),
    			@Almacen		char(10),
			@Hoy			datetime

--//WITH ENCRYPTION
AS BEGIN   
  DECLARE 
     @CfgExcluirPlaneacionDetalle	bit,
     @CfgPlanPlanearServicios		bit

    SELECT @CfgExcluirPlaneacionDetalle = VentaExcluirPlaneacionDetalle,
           @CfgPlanPlanearServicios = ISNULL(PlanPlanearServicios,0) 
      FROM EmpresaCfg2 
     WHERE Empresa = @Empresa

    DELETE PlanDemanda WHERE Estacion = @Estacion

     -- Pedidos (PV)
    INSERT PlanDemanda (Estacion, Modulo, ModuloID, Mov, MovID, Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
    SELECT @Estacion, 'VTAS', e.ID, e.Mov, e.MovID, @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'PV', ISNULL(SUM(d.CantidadPendiente*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
           CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
      FROM Venta e, VentaD d, MovTipo mt, Art a, Alm 
     WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' AND e.Extra = 0 
       AND 0 = CASE WHEN @CfgExcluirPlaneacionDetalle = 1 THEN d.ExcluirPlaneacion ELSE e.ExcluirPlaneacion END
       AND mt.Modulo = 'VTAS' AND mt.Mov = e.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX')
       AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
       AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
       AND Alm.Almacen = ISNULL(@Almacen, Alm.Almacen)
       AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
     GROUP BY e.ID, e.Mov, e.MovID, d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
    HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/


    -- Pedidos Extraordinarios (PVE)
    INSERT PlanDemanda (Estacion, Modulo, ModuloID, Mov, MovID, Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
    SELECT @Estacion, 'VTAS', e.ID, e.Mov, e.MovID, @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'PVE', ISNULL(SUM(d.CantidadPendiente*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
           CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
      FROM Venta e, VentaD d, MovTipo mt, Art a, Alm
     WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' AND e.Extra = 1 
       AND 0 = CASE WHEN @CfgExcluirPlaneacionDetalle = 1 THEN d.ExcluirPlaneacion ELSE e.ExcluirPlaneacion END
       AND mt.Modulo = 'VTAS' AND mt.Mov = e.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX')
       AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
       AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
       AND Alm.Almacen = ISNULL(@Almacen, Alm.Almacen)
       AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
      GROUP BY e.ID, e.Mov, e.MovID, d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
     HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

    -- Solicitudes (SOL)
    INSERT PlanDemanda (Estacion, Modulo, ModuloID, Mov, MovID, Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
    SELECT @Estacion, 'INV', e.ID, e.Mov, e.MovID, @Empresa, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), 'SOL', ISNULL(SUM(d.CantidadPendiente*d.Factor), 0.0) /*+ ISNULL(SUM(d.CantidadOrdenada*d.Factor), 0.0)*/, 
           CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
      FROM Inv e, InvD d, MovTipo mt, Art a, Alm
     WHERE e.ID = d.ID AND e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE' 
       AND mt.Modulo = 'INV' AND mt.Mov = e.Mov AND mt.Clave = 'INV.SOL'
       AND d.Articulo = a.Articulo AND a.Articulo = ISNULL(@Articulo, a.Articulo) AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO') AND UPPER(a.Tipo) NOT IN (/*'SERVICIO',*/'JUEGO') AND NULLIF(RTRIM(a.CategoriaActivoFijo), '') IS NULL
       AND d.Almacen = Alm.Almacen AND Alm.ExcluirPlaneacion = 0
       AND Alm.Almacen = ISNULL(@Almacen, Alm.Almacen)
       AND UPPER(A.Tipo) NOT IN (CASE WHEN @CfgPlanPlanearServicios = 0 THEN 'SERVICIO' END)
     GROUP BY e.ID, e.Mov, e.MovID, d.Articulo, ISNULL(d.SubCuenta, ''), d.Almacen, CASE WHEN d.FechaRequerida < @Hoy THEN -1 ELSE ISNULL(DATEDIFF(Month, @Hoy, d.FechaRequerida), 0) END
    HAVING SUM(d.CantidadPendiente*d.Factor) > 0 /*OR SUM(d.CantidadOrdenada*d.Factor) > 0*/

  RETURN
END
GO

/*
EXEC spPlanDemandaMonth 501, 'DEMO', 'A1', NULL, '3/6/3'
select * from plandemanda 
*/