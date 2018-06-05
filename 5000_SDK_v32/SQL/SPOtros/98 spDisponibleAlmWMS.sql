SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

if not exists (select * from sysobjects where id = object_id('dbo.FiltrosExitenciaWMS') and type = 'U') 
BEGIN
  CREATE TABLE dbo.FiltrosExitenciaWMS (
	Estacion        int,
	Modulo          varchar(10),
	ID              int,
	Mov             varchar(20)
	
  )
END
GO


/**************** spDisponibleAlmWMS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDisponibleAlmWMS') and type = 'P') drop procedure dbo.spDisponibleAlmWMS
GO
CREATE PROC spDisponibleAlmWMS 
    @Empresa    VARCHAR(20),
	@Estacion   INT
--//WITH ENCRYPTION	
AS
BEGIN
DECLARE
	@Modulo    VARCHAR(20),
	@Mov       VARCHAR(20),
	@ID        VARCHAR(20)

SELECT @Modulo=Modulo, @Mov=Mov, @ID=ID FROM FiltrosExitenciaWMS WHERE Estacion=@Estacion
CREATE TABLE #RepExitenciaWMS 
(
Referencia          VARCHAR(255) NULL,
Articulo			VARCHAR(20)  NULL,
Descripcion         VARCHAR(255) NULL, 
Almacen             VARCHAR(20)  NULL,
Existencia			FLOAT NULL,
Reservado			FLOAT NULL,
Comprometido		FLOAT NULL,
CantidadSolicitada	FLOAT NULL,
TarimaBaja          FLOAT NULL,
Disponible			AS (ISNULL(Existencia,0)-ISNULL(Reservado,0)-ISNULL(Comprometido,0)-ISNULL(CantidadSolicitada,0)-ISNULL(TarimaBaja,0))
)


-- Venta
SELECT b.Articulo, SUM(ISNULL(b.CantidadPendiente,0)) CantidadComprometida
  INTO #VentaComprometido
  FROM Venta a
       LEFT OUTER JOIN VentaD b ON b.ID=a.ID
	   JOIN Alm c ON c.Almacen=a.Almacen
 WHERE a.Estatus IN ('PENDIENTE') 
       AND WMS=1
	   AND a.Mov IN (SELECT Movimiento FROM WMSModuloMovimiento WHERE Modulo='VTAS')
 GROUP BY b.Articulo

 -- Inv
 SELECT b.Articulo, SUM(ISNULL(b.CantidadPendiente,0)) CantidadComprometida
  INTO #InvComprometido
  FROM Inv a
       LEFT OUTER JOIN InvD b ON b.ID=a.ID
	   JOIN Alm c ON c.Almacen=a.Almacen
 WHERE a.Estatus IN ('PENDIENTE') 
       AND WMS=1
	   AND a.Mov IN (SELECT Movimiento FROM WMSModuloMovimiento WHERE Modulo='INV')
 GROUP BY b.Articulo
 
 -- Compra
 SELECT b.Articulo, SUM(ISNULL(b.CantidadPendiente,0)) CantidadComprometida
  INTO #CompraComprometido
  FROM Compra a
       LEFT OUTER JOIN CompraD b ON b.ID=a.ID
	   JOIN Alm c ON c.Almacen=a.Almacen
 WHERE a.Estatus IN ('PENDIENTE') 
       AND WMS=1
	   AND a.Mov IN (SELECT Movimiento FROM WMSModuloMovimiento WHERE Modulo='COMS')
 GROUP BY b.Articulo

 SELECT * INTO #TotalComprometidoPre FROM #InvComprometido
 UNION ALL
 SELECT * FROM #VentaComprometido
 UNION ALL
 SELECT * FROM #CompraComprometido

  SELECT Articulo, SUM(ISNULL(CantidadComprometida,0)) CantidadComprometida 
    INTO #TotalComprometido 
    FROM #TotalComprometidoPre 
GROUP BY Articulo
 
IF @Modulo='INV'
BEGIN
INSERT INTO #RepExitenciaWMS 
            (Referencia,   Articulo,   Descripcion,    Almacen,   Existencia,              Reservado,             Comprometido,         CantidadSolicitada, TarimaBaja)
	 SELECT  a.Referencia, b.Articulo, d.Descripcion1, a.Almacen, ISNULL(c.Existencias,0), ISNULL(c.Reservado,0), CantidadComprometida, b.Cantidad,
	        (
				SELECT ISNULL(SUM(Disponible),0)
				  FROM ArtDisponibleTarima z
					   JOIN Tarima x ON x.Tarima=z.Tarima AND z.Almacen=x.Almacen AND z.Almacen=a.Almacen
				 WHERE z.Articulo=b.Articulo
				       AND x.Estatus='BAJA'
              )
	   FROM Inv a
	 	    LEFT OUTER JOIN InvD b ON b.ID=a.ID
		    JOIN ArtExistenciaReservado c ON c.Articulo=b.Articulo AND c.Almacen=a.Almacen
		    JOIN Art d ON d.Articulo=b.Articulo
			JOIN #TotalComprometido e ON e.Articulo=b.Articulo
	  WHERE a.ID=@ID
END

IF @Modulo='COMS'
BEGIN
INSERT INTO #RepExitenciaWMS 
            (Referencia,   Articulo,   Descripcion,    Almacen,   Existencia,              Reservado,             Comprometido,         CantidadSolicitada, TarimaBaja)
	 SELECT  a.Referencia, b.Articulo, d.Descripcion1, a.Almacen, ISNULL(c.Existencias,0), ISNULL(c.Reservado,0), CantidadComprometida, b.Cantidad,         
	         (
				SELECT ISNULL(SUM(Disponible),0)
				  FROM ArtDisponibleTarima z
					   JOIN Tarima x ON x.Tarima=z.Tarima AND z.Almacen=x.Almacen AND z.Almacen=a.Almacen
				 WHERE z.Articulo=b.Articulo
				       AND x.Estatus='BAJA'
              )
	   FROM Compra a
	 	    LEFT OUTER JOIN CompraD b ON b.ID=a.ID
		    JOIN ArtExistenciaReservado c ON c.Articulo=b.Articulo AND c.Almacen=a.Almacen
		    JOIN Art d ON d.Articulo=b.Articulo
			JOIN #TotalComprometido e ON e.Articulo=b.Articulo
	  WHERE a.ID=@ID
END

IF @Modulo='VTAS'
BEGIN
INSERT INTO #RepExitenciaWMS 
            (Referencia,   Articulo,   Descripcion,    Almacen,   Existencia,              Reservado,             Comprometido,         CantidadSolicitada, TarimaBaja)
	 SELECT  a.Referencia, b.Articulo, d.Descripcion1, a.Almacen, ISNULL(c.Existencias,0), ISNULL(c.Reservado,0), CantidadComprometida, b.Cantidad,
	        (
				SELECT ISNULL(SUM(Disponible),0)
				  FROM ArtDisponibleTarima z
					   JOIN Tarima x ON x.Tarima=z.Tarima AND z.Almacen=x.Almacen AND z.Almacen=a.Almacen
				 WHERE z.Articulo=b.Articulo
				       AND x.Estatus='BAJA'
              )
	   FROM Venta a
	 	    LEFT OUTER JOIN VentaD b ON b.ID=a.ID
		    JOIN ArtExistenciaReservado c ON c.Articulo=b.Articulo AND c.Almacen=a.Almacen
		    JOIN Art d ON d.Articulo=b.Articulo
			JOIN #TotalComprometido e ON e.Articulo=b.Articulo
	  WHERE a.ID=@ID
END
 
  SELECT * 
    FROM #RepExitenciaWMS
ORDER BY Disponible ASC

--DELETE  FiltrosExitenciaWMS WHERE Estacion=@Estacion
RETURN
END
GO
--EXEC spDisponibleAlmWMS 'DEMO', 1


/**************** spDisponibleAlmWMSFiltro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDisponibleAlmWMSFiltro') and type = 'P') drop procedure dbo.spDisponibleAlmWMSFiltro
GO
CREATE PROC spDisponibleAlmWMSFiltro 
	@Modulo     VARCHAR(20)
--//WITH ENCRYPTION
AS
BEGIN
CREATE TABLE #MovWMS (
ID     INT,
Mov    VARCHAR(20))

IF @Modulo='VTAS'
BEGIN
    INSERT INTO #MovWMS (ID, Mov)
	SELECT ID, Mov 
	  FROM Venta a
	       JOIN Alm b ON b.Almacen=a.Almacen 
	 WHERE Mov IN (SELECT Movimiento FROM WMSModuloMovimiento WHERE Modulo='VTAS')
	       AND a.Estatus='SINAFECTAR' 
		   AND b.WMS=1
END

IF @Modulo='INV'
BEGIN
    INSERT INTO #MovWMS (ID, Mov)
	SELECT ID, Mov 
	  FROM Inv a
	       JOIN Alm b ON b.Almacen=a.Almacen 
	 WHERE Mov IN (SELECT Movimiento FROM WMSModuloMovimiento WHERE Modulo='INV')
	       AND a.Estatus='SINAFECTAR' 
		   AND b.WMS=1
END

IF @Modulo='COMS'
BEGIN
    INSERT INTO #MovWMS (ID, Mov)
	SELECT ID, Mov 
	  FROM Compra a
	       JOIN Alm b ON b.Almacen=a.Almacen 
	 WHERE Mov IN (SELECT Movimiento FROM WMSModuloMovimiento WHERE Modulo='COMS')
	       AND a.Estatus='SINAFECTAR' 
		   AND b.WMS=1
END

     SELECT * FROM #MovWMS
RETURN
END
GO
 -- EXEC spDisponibleAlmWMSFiltro 'VTAS'