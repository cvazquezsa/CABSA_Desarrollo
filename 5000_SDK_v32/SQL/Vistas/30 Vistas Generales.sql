/* VISTAS          */
SET ANSI_NULLS OFF
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/***************************************** VISTAS INV *****************************************/

/*** SysTablasReplicar ***/
if exists (select * from sysobjects where id = object_id('dbo.SysTablasReplicar') and type = 'V') drop view dbo.SysTablasReplicar
GO
CREATE VIEW SysTablasReplicar
--//WITH ENCRYPTION
AS 
SELECT "Tabla" = SysTabla FROM SysTabla WHERE UPPER(Tipo) IN ('MAESTRO', 'CUENTA')
GO

/*** SysVistasLocales ***/
if exists (select * from sysobjects where id = object_id('dbo.SysVistasLocales') and type = 'V') drop view dbo.SysVistasLocales
GO
CREATE VIEW SysVistasLocales
--//WITH ENCRYPTION
AS 
SELECT "Vista" = SysVista FROM SysVista WHERE TRCL = 1
GO

/*** PersonalA ***/
if exists (select * from sysobjects where id = object_id('dbo.PersonalA') and type = 'V') drop view dbo.PersonalA
GO
CREATE VIEW PersonalA
--//WITH ENCRYPTION
AS 
SELECT 
  Personal,
  ApellidoPaterno,
  ApellidoMaterno,
  Nombre,
  Tipo,
  Departamento,
  Grupo,
  Puesto,
  Categoria,
  FechaAlta,
  FechaAntiguedad,
  FechaBaja,
  ConceptoBaja,
  VencimientoContrato,
  Estatus,
  Situacion,
  SituacionFecha,
  SituacionUsuario,
  SituacionNota,
  EstaPresente,
  TieneMovimientos,
  SucursalTrabajo, 
  NivelAcceso,
  "NombreCompleto" = CONVERT(varchar(100), ISNULL(RTRIM(ApellidoPaterno), '')+' '+ISNULL(RTRIM(ApellidoMaterno), '')+' '+ISNULL(RTRIM(Nombre), '')) ,
  Registro,
  Registro2,
  Registro3,
  Empresa

FROM 
  Personal
GO


/*** ArtEstructuraProducto ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtEstructuraProducto') and type = 'V') drop view dbo.ArtEstructuraProducto
GO
CREATE VIEW ArtEstructuraProducto
--//WITH ENCRYPTION
AS 
SELECT
  ArtMaterial.Articulo,
  ArtMaterial.OrdenID,
  ArtMaterial.SiOpcion,
  ArtMaterial.Material,
  ArtMaterial.SubCuenta,
  ArtMaterial.Cantidad,
  ArtMaterial.Unidad,
  ArtMaterial.Merma,
  ArtMaterial.Desperdicio,
  ArtMaterial.CentroTipo,
  ArtMaterial.Orden,
  Art.Descripcion1,
  Art.Categoria,
  Art.Familia,
  Art.Fabricante,
  Art.ClaveFabricante,
  Art.UnidadCompra,
  Art.Tipo,
  Art.Estatus,
  Art.SeCompra,
  Art.SeVende,
  Art.SeProduce,
  Art.EsFormula

FROM ArtMaterial
JOIN Art ON ArtMaterial.Material=Art.Articulo
GO


/*** dbo.ArtApartadoTarima ***/
IF EXISTS (SELECT * FROM sysobjects WHERE ID = OBJECT_ID('dbo.ArtApartadoTarima') and TYPE = 'V') DROP VIEW dbo.ArtApartadoTarima
GO
CREATE VIEW ArtApartadoTarima
--//WITH ENCRYPTION
AS 
    SELECT t.Empresa, 
           d.Articulo, 
           t.Almacen, 
           CASE WHEN  CHARINDEX('-',d.Tarima,1) > 0 THEN SUBSTRING(d.Tarima,1,CHARINDEX('-',d.Tarima,1)-1) ELSE d.Tarima END Tarima,
           SUM(ISNULL(d.CantidadPendiente,0)) Apartado
      FROM TMA t
      JOIN TMAD d ON t.ID = d.ID
      JOIN MovTipo mt ON t.Mov = mt.Mov AND mt.Modulo = 'TMA'
      WHERE t.Estatus = 'PENDIENTE' 
        AND mt.Clave IN('TMA.OSUR','TMA.TSUR','TMA.SUR','TMA.OPCKTARIMA','TMA.PCKTARIMATRAN','TMA.PCKTARIMA')
      GROUP BY t.Empresa, d.Articulo, t.Almacen, CASE WHEN  CHARINDEX('-',d.Tarima,1) > 0 THEN SUBSTRING(d.Tarima,1,CHARINDEX('-',d.Tarima,1)-1) ELSE d.Tarima END
GO

/*** dbo.ArtApartadoSerieTarima ***/
IF EXISTS (SELECT * FROM sysobjects WHERE ID = OBJECT_ID('dbo.ArtApartadoSerieTarima') and TYPE = 'V') DROP VIEW dbo.ArtApartadoSerieTarima
GO
CREATE VIEW ArtApartadoSerieTarima
--//WITH ENCRYPTION
AS 
    SELECT t.Empresa, 
           d.Articulo, 
           t.Almacen, 
           s.Tarima,
           s.SerieLote,
           SUM(ISNULL(s.Cantidad,0)) Apartado
      FROM TMA t
      JOIN TMAD d ON t.ID = d.ID  
      JOIN SerieLoteMov s ON d.ID = s.ID AND s.Modulo ='TMA' AND d.Renglon = s.RenglonID
      JOIN MovTipo mt ON t.Mov = mt.Mov AND mt.Modulo = 'TMA'
      WHERE t.Estatus = 'PENDIENTE'
        AND mt.Clave IN('TMA.OSUR','TMA.TSUR','TMA.SUR','TMA.OPCKTARIMA','TMA.PCKTARIMATRAN','TMA.PCKTARIMA')
      GROUP BY t.Empresa, d.Articulo, t.Almacen, s.Tarima, s.SerieLote
GO


if exists (select * from sysobjects where id = object_id('dbo.SaldoUWMSDisponible') and type = 'V') drop view dbo.SaldoUWMSDisponible
GO
CREATE VIEW SaldoUWMSDisponible
--//WITH ENCRYPTION
AS 

SELECT
Sucursal,
Empresa,
Cuenta,
Grupo,
'' SubGrupo,
Rama,
Moneda,
SUM(Saldo) Saldo,
SUM(SaldoU) SaldoU
FROM SaldoUWMS 
WHERE Rama='WMS'
GROUP BY Sucursal,
Empresa,
Cuenta,
Grupo,
Rama,
Moneda
GO


if exists (select * from sysobjects where id = object_id('dbo.ArtSaldoUSinTarima') and type = 'V') drop view dbo.ArtSaldoUSinTarima
GO
CREATE VIEW ArtSaldoUSinTarima
--//WITH ENCRYPTION
AS 

SELECT
s.Empresa Empresa,
s.Cuenta Articulo,
s.Grupo Almacen,
s.SubGrupo Tarima,
SaldoU=s.SaldoU-ss.SaldoU
FROM SaldoU s
JOIN SaldoUWMSDisponible ss ON ss.Empresa=s.Empresa AND s.Sucursal=ss.Sucursal AND ss.Cuenta=s.Cuenta AND ss.Grupo=s.Grupo
GO

/*** ArtDisponibleTarima ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtDisponibleTarima') and type = 'V') drop view dbo.ArtDisponibleTarima
GO
CREATE VIEW ArtDisponibleTarima
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.Grupo Almacen,
  s.SubGrupo Tarima,
  Sum(s.SaldoU*r.Factor) Disponible,
  Sum(ISNULL(a.Apartado,0)*r.Factor) Apartado

FROM SaldoUWMS s 
JOIN Rama r ON s.Rama=r.Rama
LEFT JOIN ArtApartadoTarima a ON s.Empresa = a.Empresa AND s.Grupo = a.Almacen AND s.SubGrupo = a.Tarima AND s.Cuenta = a.Articulo
WHERE r.Mayor='WMS'--Task 8036
GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo, s.SubGrupo
UNION ALL -- JLGG 
SELECT Empresa, Articulo, Almacen, Tarima, SaldoU, 0  FROM ArtSaldoUSinTarima WHERE SaldoU>0

GO
-- select * from ArtDisponible
-- select * from saldou
/*** ArtDisponible ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtDisponible') and type = 'V') drop view dbo.ArtDisponible
GO
CREATE VIEW ArtDisponible
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.Grupo Almacen,
  Sum(s.SaldoU*r.Factor) Disponible,
  Sum(adt.Apartado) Apartado,
  Sum(s.SaldoU*r.Factor)-ISNULL(SUM(adt.Apartado),0) DispMenosApartado
FROM SaldoU s
JOIN Rama r ON s.Rama=r.Rama 
LEFT OUTER JOIN ArtDisponibleTarima adt ON s.Cuenta = adt.Articulo AND s.Grupo = adt.Almacen
WHERE r.Mayor='INV'
GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo

GO
IF EXISTS(SELECT * FROM sysobjects WHERE Type='V' AND ID=OBJECT_ID('dbo.WMSEstatusTarima'))
DROP VIEW dbo.WMSEstatusTarima
GO
CREATE VIEW WMSEstatusTarima
AS
	  SELECT 
			adt.Empresa AS Empresa,
			adt.Almacen AS Almacen,
			alm.Nombre AS AlmNombre,
			adt.Tarima AS Tarima,
			CASE WHEN sl.SerieLote IS NOT NULL THEN Existencia ELSE adt.Disponible END AS Disponible,
			t.Estatus AS Estatus,
			t.EstatusControlCalidad AS EstatusControlCalidad,
			ap.Posicion AS Posicion,
			ap.Tipo AS UbicacionTipo,
			ap.Descripcion AS UbicacionDescripcion,
			t.Alta AS TarimaAlta,
			t.Baja AS TarimaBaja,
			t.SubCuenta AS TarimaSubCuenta,
			adt.Articulo AS Articulo,
			a.Descripcion1 AS ArtDescripcion1,
			a.Unidad AS ArtUnidad,
			ap.SubCuenta AS UbicacionSubCuenta,
			t.FechaCaducidad AS FechaCaducidad,
			ap.Zona AS Zona,
			ap.Alto AS Alto,
			ap.Largo AS Largo,
			ap.Ancho AS Ancho,
			ap.Volumen AS Volumen,
			ap.Pasillo AS Pasillo,
			ap.Fila AS Fila,
			ap.Nivel AS Nivel,
			sl.SerieLote
	  FROM ArtDisponibleTarima adt
	  JOIN Alm alm ON adt.Almacen=alm.Almacen
	  JOIN Art a ON adt.Articulo=a.Articulo
	  JOIN Tarima t ON adt.Tarima=t.Tarima AND adt.Almacen=t.Almacen
	  JOIN AlmPos ap ON t.Posicion=ap.Posicion AND t.Almacen=ap.Almacen
 LEFT JOIN SerieLote sl ON sl.Empresa=adt.Empresa AND sl.Articulo=adt.Articulo AND adt.Almacen=sl.Almacen AND adt.Tarima=sl.Tarima
GO


IF EXISTS(SELECT * FROM SYSOBJECTS WHERE TYPE='V' AND ID=OBJECT_ID('dbo.WMSTarimasSurtidoPendientes'))
DROP VIEW dbo.WMSTarimasSurtidoPendientes
GO
CREATE VIEW dbo.WMSTarimasSurtidoPendientes
AS
SELECT 
		'VTAS' AS Modulo,
		Venta.ID, 
		Venta.Empresa, 
		Venta.Sucursal, 
		Venta.Mov, 
		Venta.MovID, 
		Venta.FechaEmision, 
		Venta.Estatus,
		VentaD.Renglon, 
		VentaD.RenglonID, 
		VentaD.RenglonSub, 
		VentaD.RenglonTipo, 
		VentaD.Articulo, 
		VentaD.SubCuenta, 
		VentaD.Cantidad, 
		VentaD.CantidadCancelada, 
		VentaD.CantidadPendiente, 
		VentaD.Tarima
	FROM Venta
	JOIN VentaD ON Venta.ID=VentaD.ID
	JOIN Alm ON VentaD.Almacen=Alm.Almacen
	JOIN Art ON VentaD.Articulo=Art.Articulo
	JOIN Tarima ON VentaD.Tarima=Tarima.Tarima
	JOIN AlmPos ON Tarima.Posicion=AlmPos.Posicion AND AlmPos.Almacen=Alm.Almacen
	WHERE 
	Alm.WMS=1 
	AND Venta.Estatus='PENDIENTE' 
	AND VentaD.Tarima IS NOT NULL
	AND AlmPos.Tipo='Surtido'
UNION ALL
SELECT 
		'INV' AS Modulo,
		Inv.ID, 
		Inv.Empresa, 
		Inv.Sucursal, 
		Inv.Mov, 
		Inv.MovID, 
		Inv.FechaEmision, 
		Inv.Estatus,
		InvD.Renglon, 
		InvD.RenglonID, 
		InvD.RenglonSub, 
		InvD.RenglonTipo, 
		InvD.Articulo, 
		InvD.SubCuenta, 
		InvD.Cantidad, 
		InvD.CantidadCancelada, 
		InvD.CantidadPendiente, 
		InvD.Tarima
	FROM Inv
	JOIN InvD ON Inv.ID=InvD.ID
	JOIN Alm ON InvD.Almacen=Alm.Almacen
	JOIN Art ON InvD.Articulo=Art.Articulo
	JOIN Tarima ON InvD.Tarima=Tarima.Tarima
	JOIN AlmPos ON Tarima.Posicion=AlmPos.Posicion AND AlmPos.Almacen=Alm.Almacen
	WHERE 
	Alm.WMS=1 
	AND Inv.Estatus='PENDIENTE'
	AND InvD.Tarima IS NOT NULL
	AND AlmPos.Tipo='Surtido'

GO

/*** SaldoUOpcion ***/
if exists (select * from sysobjects where id = object_id('dbo.SaldoUOpcion') and type = 'V') drop view dbo.SaldoUOpcion
GO
CREATE VIEW SaldoUOpcion
--//WITH ENCRYPTION
AS 
SELECT u.Sucursal,
	   u.Empresa,
	   u.Rama,
	   u.Moneda,
	   u.Grupo,
	   u.SubGrupo,
	   u.Cuenta,
	   u.SubCuenta,
       SUM(ISNULL(u.Cargo,0.00) - ISNULL(u.Abono,0.00)) Saldo,
       SUM(ISNULL(u.CargoU,0.00) - ISNULL(u.AbonoU,0.00)) SaldoU,
       CASE WHEN ISNULL(u.Conciliado,0) = 1 THEN SUM(ISNULL(u.Cargo,0.00) - ISNULL(u.Abono,0.00)) ELSE 0 END PorConciliar, 
       CASE WHEN ISNULL(u.Conciliado,0) = 1 THEN SUM(ISNULL(u.CargoU,0.00) - ISNULL(u.AbonoU,0.00)) ELSE 0 END PorConciliarU,
       o.A, o.B, o.C, o.D, o.E, o.F, o.G, o.H, o.I, o.J, o.K, o.L, o.M, o.N, o.O, o.P, o.Q, o.R, o.S, o.T, o.W, o.X, o.Y, o.Z
  FROM AuxiliarU u LEFT OUTER JOIN MovOpcion o
    ON u.Modulo = o.Modulo AND u.ModuloID = o.ModuloID AND u.Renglon = o.Renglon AND u.RenglonSub = o.RenglonSub
 GROUP BY u.Sucursal, u.Empresa, u.Rama, u.Moneda, u.Grupo, u.SubGrupo, u.Cuenta, u.SubCuenta, u.Conciliado,
		  o.A, o.B, o.C, o.D, o.E, o.F, o.G, o.H, o.I, o.J, o.K, o.L, o.M, o.N, o.O, o.P, o.Q, o.R, o.S, o.T, o.W, o.X, o.Y, o.Z
 GO

/*** ArtAsignadoCte ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtAsignadoCte') and type = 'V') drop view dbo.ArtAsignadoCte
GO
CREATE VIEW ArtAsignadoCte
--//WITH ENCRYPTION
AS 
SELECT 
  c.Empresa,
  d.Cliente,
  d.Articulo,
  d.Almacen,
  "Asignado" = SUM(d.CantidadPendiente*ISNULL(d.Factor, 1.0))

FROM Compra c
JOIN CompraD d ON c.ID = d.ID
WHERE 
  c.Estatus = 'PENDIENTE'
GROUP BY 
  c.Empresa, d.Cliente, d.Articulo, d.Almacen
GO

/*** ArtSubAsignadoCte ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubAsignadoCte') and type = 'V') drop view dbo.ArtSubAsignadoCte
GO
CREATE VIEW ArtSubAsignadoCte
--//WITH ENCRYPTION
AS 
SELECT 
  c.Empresa,
  d.Cliente,
  d.Articulo,
  d.SubCuenta,
  d.Almacen,
  "Asignado" = SUM(d.CantidadPendiente*ISNULL(d.Factor, 1.0))

FROM Compra c
JOIN CompraD d ON c.ID = d.ID
WHERE 
  c.Estatus = 'PENDIENTE'

GROUP BY 
  c.Empresa, d.Cliente, d.Articulo, d.SubCuenta, d.Almacen
GO


/*** ArtDisponibleDesc ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtDisponibleDesc') and type = 'V') drop view dbo.ArtDisponibleDesc
GO
CREATE VIEW ArtDisponibleDesc
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.Grupo Almacen,
  case 
    when UPPER(a.tipo) in ('JUEGO','SERVICIO') then NULL
    else Sum(s.SaldoU*r.Factor)
  end Disponible,
  a.Descripcion1, a.Descripcion2, a.Unidad, a.Tipo, a.PrecioLista, a.Impuesto1, a.Impuesto2, a.Impuesto3, ac.UltimoCosto, ac.UltimoCostoSinGastos, ac.CostoPromedio, a.CostoEstandar, a.CostoReposicion
  
 
FROM Art a
JOIN ArtCosto ac ON a.Articulo = ac.Articulo
JOIN SaldoU s ON ac.Articulo = s.Cuenta AND ac.Empresa = s.Empresa
JOIN Rama r ON s.Rama = r.Rama AND r.Mayor = 'INV' 
JOIN Alm ON s.Grupo = alm.Almacen
GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo, 
  a.Descripcion1, a.Descripcion2, a.Unidad, a.Tipo, a.PrecioLista, a.Impuesto1, a.Impuesto2, a.Impuesto3, ac.UltimoCosto, ac.UltimoCostoSinGastos, ac.CostoPromedio, a.CostoEstandar, a.CostoReposicion
GO

/*** ArtReservado ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtReservado') and type = 'V') drop view dbo.ArtReservado
GO
CREATE VIEW ArtReservado
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.Grupo Almacen,
  sum(s.SaldoU) Reservado

FROM SaldoU s
JOIN Rama r ON s.Rama=r.Rama
WHERE 
  r.Rama='RESV'
GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo
GO

/*** ArtReservadoTarima ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtReservadoTarima') and type = 'V') drop view dbo.ArtReservadoTarima
GO
CREATE VIEW ArtReservadoTarima
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.Grupo Almacen,
  s.SubGrupo Tarima,
  sum(s.SaldoU) Reservado

FROM SaldoUWMS s
JOIN Rama r ON s.Rama=r.Rama
WHERE 
  r.Rama='RESV'

GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo, s.SubGrupo
GO

/*** ArtDisponibleReservado ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtDisponibleReservado') and type = 'V') drop view dbo.ArtDisponibleReservado
GO
CREATE VIEW ArtDisponibleReservado
--//WITH ENCRYPTION
AS 
SELECT 
  ad.Empresa,
  ad.Articulo,
  ad.Almacen,
  ad.Disponible,
  ar.Reservado
 
FROM ArtDisponible ad
LEFT OUTER JOIN ArtReservado ar ON ar.Empresa = ad.Empresa AND ar.Articulo = ad.Articulo AND ar.Almacen = ad.Almacen
GO

/*** ArtDisponibleCatalogo ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtDisponibleCatalogo') and type = 'V') drop view dbo.ArtDisponibleCatalogo
GO
CREATE VIEW ArtDisponibleCatalogo
--//WITH ENCRYPTION
AS 
SELECT 
  c.Grupo, c.Catalogo, c.Celda, c.Tipo, c.Dato,
  a.Descripcion1, a.Unidad, a.PrecioLista, a.MonedaPrecio,
  d.Disponible, d.Almacen, d.Empresa

FROM 
  CatalogoD c
JOIN Art a ON c.Dato = a.Articulo
LEFT OUTER JOIN ArtDisponible d ON a.Articulo = d.Articulo 

WHERE c.Tipo = 2 
GO

/*** ArtSubDisponible ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubDisponible') and type = 'V') drop view dbo.ArtSubDisponible
GO
CREATE VIEW ArtSubDisponible
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.SubCuenta SubCuenta,
  s.Grupo Almacen,
  Sum(s.SaldoU*r.Factor) Disponible

FROM 
  SaldoU s
  JOIN Rama r ON s.SubCuenta is NOT NULL and s.Rama=r.Rama and r.Mayor = 'INV' 

GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo, s.SubCuenta 
GO

/****************************************   SaldoUGral   *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE ID = OBJECT_ID('dbo.SaldoUGral') and TYPE = 'V') DROP VIEW dbo.SaldoUGral
GO
CREATE VIEW SaldoUGral
--//WITH ENCRYPTION
AS 
  SELECT Sucursal, Empresa, Rama, Moneda, Grupo, 
         Cuenta, SubCuenta, Saldo, SaldoU, PorConciliar, 
         PorConciliarU, UltimoCambio, SubGrupo
    FROM SaldoU
   UNION ALL
  SELECT Sucursal, Empresa, Rama, Moneda, Grupo, 
         Cuenta, SubCuenta, Saldo, SaldoU, PorConciliar, 
         PorConciliarU, UltimoCambio, SubGrupo
    FROM SaldoUWMS
GO

-- select * from ArtSubDisponibleTarima
/*** ArtSubDisponibleTarima ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubDisponibleTarima') and type = 'V') drop view dbo.ArtSubDisponibleTarima
GO
CREATE VIEW ArtSubDisponibleTarima
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.SubCuenta SubCuenta,
  s.Grupo Almacen,
  s.SubGrupo Tarima,
  Sum(s.SaldoU*r.Factor) Disponible

FROM 
  SaldoUGral s
  JOIN Rama r ON s.SubCuenta is NOT NULL and s.Rama=r.Rama and r.Mayor = 'WMS'--Task 8036

GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo, s.SubGrupo, s.SubCuenta 
GO

/*** ArtAlmSubDisponible ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtAlmSubDisponible') and type = 'V') drop view dbo.ArtAlmSubDisponible
GO
CREATE VIEW ArtAlmSubDisponible
--//WITH ENCRYPTION
AS 
SELECT aa.Empresa, aa.Articulo, aa.Almacen, "SubCuenta" = NULLIF(aa.SubCuenta, ''), aa.Minimo, aa.Maximo, aa.PuntoOrden, aa.PuntoOrdenOrdenar, d.Disponible
  FROM ArtAlm aa
  LEFT OUTER JOIN ArtSubDisponible d ON aa.Empresa = d.Empresa AND aa.Almacen = d.Almacen AND aa.Articulo = d.Articulo AND aa.SubCuenta = d.SubCuenta 
 WHERE NULLIF(RTRIM(aa.Almacen), '') IS NOT NULL 
GO

-- select * from ArtAlmSubDisponible

/*** ArtSubDisponibleDesc ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubDisponibleDesc') and type = 'V') drop view dbo.ArtSubDisponibleDesc
GO
CREATE VIEW ArtSubDisponibleDesc
--//WITH ENCRYPTION
AS 
SELECT 
  asd.Empresa,
  asd.Articulo,
  asd.SubCuenta,
  asd.Almacen,
  asd.Disponible,
  a.Descripcion1,
  "Llave" = RTRIM(asd.Articulo)+CHAR(9)+ISNULL(RTRIM(asd.SubCuenta), '')

FROM 
  ArtSubDisponible asd
JOIN Art a ON asd.Articulo = a.Articulo
GO

/*** ArtSubDisponibleTarima ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubDisponibleTarima') and type = 'V') drop view dbo.ArtSubDisponibleTarima
GO
CREATE VIEW ArtSubDisponibleTarima
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.SubCuenta SubCuenta,
  s.Grupo Almacen,
  s.SubGrupo Tarima,
  Sum(s.SaldoU*r.Factor) Disponible

FROM 
  SaldoUGral s
  JOIN Rama r ON s.SubCuenta is NOT NULL and s.Rama=r.Rama and r.Mayor = 'WMS'--Task 8036

GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo, s.SubGrupo, s.SubCuenta 
GO

/*** ArtVtasMostrador ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtVtasMostrador') and type = 'V') drop view dbo.ArtVtasMostrador
GO
CREATE VIEW ArtVtasMostrador
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.Grupo Almacen,
  sum(s.SaldoU) PorProcesar

FROM SaldoU s
JOIN Rama r ON s.Rama=r.Rama
WHERE 
  r.Rama='VMOS'

GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo
GO

/*** ArtPieza ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtPieza') and type = 'V') drop view dbo.ArtPieza
GO
CREATE VIEW ArtPieza
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa,
  Cuenta Articulo,
  Grupo Almacen,
  SaldoU Piezas

FROM 
  SaldoU

WHERE 
  Rama='PZA'
GO

/*** ArtPartida ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtPartida') and type = 'V') drop view dbo.ArtPartida
GO
CREATE VIEW ArtPartida
--//WITH ENCRYPTION
AS 
SELECT
  Empresa,
  Articulo,
  SubCuenta,
  SerieLote,
  Almacen,
  "Existencia" = SUM(Existencia),
  "ExistenciaAlterna" = SUM(ExistenciaAlterna)

FROM 
  SerieLote 

GROUP BY 
  Empresa, 
  Articulo,
  SubCuenta,
  SerieLote,
  Almacen

HAVING 
  SUM(Existencia) <> 0.0 OR SUM(ExistenciaAlterna) <> 0.0
GO

/*** ArtConsignacion ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtConsignacion') and type = 'V') drop view dbo.ArtConsignacion
GO
CREATE VIEW ArtConsignacion
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa Empresa,
  Cuenta Articulo,
  Grupo Almacen,
  sum(SaldoU) Consignacion

FROM 
  SaldoU

WHERE 
  Rama='CSG'

GROUP BY 
  Empresa, Cuenta, Grupo
GO

/*** ArtSubConsignacion ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubConsignacion') and type = 'V') drop view dbo.ArtSubConsignacion
GO
CREATE VIEW ArtSubConsignacion
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa Empresa,
  Cuenta Articulo,
  SubCuenta SubCuenta,
  Grupo Almacen,
  Sum(SaldoU) Consignacion

FROM 
  SaldoU 

WHERE 
  SubCuenta is NOT NULL AND Rama = 'CSG'

GROUP BY 
  Empresa, Cuenta, Grupo, SubCuenta
GO


/*** ArtCostoCapas ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtCostoCapas') and type = 'V') drop view dbo.ArtCostoCapas
GO
CREATE VIEW ArtCostoCapas
--//WITH ENCRYPTION
AS 
SELECT
  Sucursal,
  Empresa,
  Articulo,
  SubCuenta,
  "Existencia" = SUM(Existencia),
  "CostoCapas" = SUM(Existencia*Costo)
FROM
  InvCapa
GROUP BY
  Sucursal, Empresa, Articulo, SubCuenta
GO
/*** ArtExistenciaInv ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtExistenciaInv') and type = 'V') drop view dbo.ArtExistenciaInv
GO
CREATE VIEW ArtExistenciaInv
--//WITH ENCRYPTION
AS 
SELECT 
  Sucursal,
  Empresa,
  Cuenta Articulo,
  Grupo Almacen,
  Sum(SaldoU) Inventario

FROM 
  SaldoU

WHERE 
  Rama = 'INV'

GROUP BY 
  Sucursal, Empresa, Cuenta, Grupo
GO
/*** ArtCostoEmpresa ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtCostoEmpresa') and type = 'V') drop view dbo.ArtCostoEmpresa
GO
CREATE VIEW ArtCostoEmpresa
--//WITH ENCRYPTION
AS 

SELECT 
  ac.Empresa,
  a.Articulo, 
  "CostoPromedio" =	CASE WHEN ISNULL(ai.Inventario,0) = 0
							THEN 0
						 ELSE	
							SUM(ISNULL(ai.Inventario,0)*ISNULL(AC.CostoPromedio,0))/SUM(ISNULL(ai.Inventario,0))
					END,
  "UltimoCosto" = CASE	WHEN ISNULL(ai.Inventario,0) = 0
							THEN 0
						ELSE
							SUM(ISNULL(ai.Inventario,0)*ISNULL(AC.UltimoCosto,0) )/ SUM (ISNULL(ai.Inventario,0))
				  END,  
  "UltimoCostoSinGastos" = CASE WHEN ISNULL(ai.Inventario,0) = 0
									THEN 0
								ELSE
									SUM(ISNULL(ai.Inventario,0)*ISNULL(AC.UltimoCostoSinGastos,0) )/ SUM (ISNULL(ai.Inventario,0))
							END,
  "CostoEstandar"= AVG(ISNULL(a.CostoEstandar,0)),
  "CostoReposicion"= AVG(ISNULL(a.CostoReposicion,0))
FROM  art a 
JOIN ArtCosto ac on a.Articulo =ac.Articulo 
JOIN ArtExistenciaInv  ai on a.Articulo =ai.Articulo
AND ac.Empresa =ai.Empresa 
AND ac.Sucursal =ai.Sucursal 
GROUP BY  a.Articulo,ac.Empresa,ai.Inventario
GO


/*** ArtSubCostoEmpresa ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubCostoEmpresa') and type = 'V') drop view dbo.ArtSubCostoEmpresa
GO
CREATE VIEW ArtSubCostoEmpresa
--//WITH ENCRYPTION
AS 
SELECT 
  c.Empresa,
  c.Articulo,
  c.SubCuenta,
  "CostoPromedio" = CONVERT(money, SUM(s.SaldoU*c.CostoPromedio)/NULLIF(SUM(s.SaldoU), 0)),
  "UltimoCosto" = CONVERT(money, SUM(s.SaldoU*c.UltimoCosto)/NULLIF(SUM(s.SaldoU), 0)), 
  "UltimoCostoSinGastos" = CONVERT(money, SUM(s.SaldoU*c.UltimoCostoSinGastos)/NULLIF(SUM(s.SaldoU), 0)), 
  "CostoEstandar"= AVG(a.CostoEstandar),
  "CostoReposicion"= AVG(a.CostoReposicion)

FROM Art a
JOIN ArtSubCosto c ON a.Articulo = c.Articulo
JOIN SaldoU s ON c.Articulo = s.Cuenta AND c.SubCuenta = s.Subcuenta AND s.Rama = 'INV' AND c.Sucursal = s.Sucursal
GROUP BY
  c.Empresa, c.Articulo, c.SubCuenta
GO

/*** ArtSubCostoEmpresaOpcion ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubCostoEmpresaOpcion') and type = 'V') drop view dbo.ArtSubCostoEmpresaOpcion
GO
CREATE VIEW ArtSubCostoEmpresaOpcion
--//WITH ENCRYPTION
AS 
SELECT 
  c.Sucursal,
  c.Empresa,
  s.Rama,
  s.Moneda,
  c.Articulo,
  c.SubCuenta,
  s.Grupo,
  s.SubGrupo,
  "CostoPromedio" = CONVERT(money, SUM(s.SaldoU*c.CostoPromedio)/NULLIF(SUM(s.SaldoU), 0)),
  "UltimoCosto" = CONVERT(money, SUM(s.SaldoU*c.UltimoCosto)/NULLIF(SUM(s.SaldoU), 0)), 
  "UltimoCostoSinGastos" = CONVERT(money, SUM(s.SaldoU*c.UltimoCostoSinGastos)/NULLIF(SUM(s.SaldoU), 0)), 
  "CostoEstandar"= AVG(a.CostoEstandar),
  "CostoReposicion"= AVG(a.CostoReposicion)

FROM Art a
JOIN ArtSubCosto c ON a.Articulo = c.Articulo
JOIN SaldoU s ON c.Articulo = s.Cuenta AND c.SubCuenta = s.Subcuenta AND s.Rama = 'INV' AND c.Sucursal = s.Sucursal
GROUP BY
  c.Sucursal, c.Empresa, s.Rama, s.Moneda, c.Articulo, c.SubCuenta, s.Grupo, s.SubGrupo
GO

/*** ArtCostoSucursal ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtCostoSucursal') and type = 'V') drop view dbo.ArtCostoSucursal
GO
CREATE VIEW ArtCostoSucursal
--//WITH ENCRYPTION
AS 
SELECT 
  c.Empresa,
  c.Sucursal,
  c.Articulo,
  c.CostoPromedio,
  c.UltimoCosto,
  c.UltimoCostoSinGastos, 
  a.CostoEstandar,
  a.CostoReposicion

FROM Art a
JOIN ArtCosto c ON a.Articulo = c.Articulo
GO

/*** ArtSubCostoSucursal ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubCostoSucursal') and type = 'V') drop view dbo.ArtSubCostoSucursal
GO
CREATE VIEW ArtSubCostoSucursal
--//WITH ENCRYPTION
AS 
SELECT 
  c.Empresa,
  c.Sucursal,
  c.Articulo,
  c.SubCuenta,
  c.CostoPromedio,
  c.UltimoCosto,
  c.UltimoCostoSinGastos, 
  a.CostoEstandar,
  a.CostoReposicion

FROM Art a
JOIN ArtSubCosto c ON a.Articulo = c.Articulo
GO


/*** ArtConCosto ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtConCosto') and type = 'V') drop view dbo.ArtConCosto
GO
CREATE VIEW ArtConCosto
--//WITH ENCRYPTION
AS 
SELECT 
  a.Articulo,
  c.Empresa,
  c.CostoPromedio,
  c.UltimoCosto,
  c.UltimoCostoSinGastos,
  a.CostoEstandar,
  a.CostoReposicion

FROM 
  Art a
  LEFT OUTER JOIN ArtCostoEmpresa c ON a.Articulo = c.Articulo
GO

/*** ArtConDisponible ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtConDisponible') and type = 'V') drop view dbo.ArtConDisponible
GO
CREATE VIEW ArtConDisponible
--//WITH ENCRYPTION
AS 
SELECT 
  a.Articulo,
  a.Descripcion1,
  a.Estatus,
  a.Situacion,
  a.NivelAcceso,
  d.Empresa,
  d.Almacen,
  d.Disponible

FROM 
  Art a
LEFT OUTER JOIN ArtDisponible d ON a.Articulo = d.Articulo
GO

/*** ArtPrecioCostoMoneda ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtPrecioCostoMoneda') and type = 'V') drop view dbo.ArtPrecioCostoMoneda
GO
CREATE VIEW ArtPrecioCostoMoneda
--//WITH ENCRYPTION
AS 
SELECT 
  c.Empresa,
  a.Articulo,
  a.Descripcion1, 
  a.Descripcion2, 
  a.NombreCorto,
  a.Tipo,
  a.TipoOpcion,
  a.Estatus,
  a.MonedaPrecio,
  "TipoCambioPrecio" = mv.TipoCambio,
  a.PrecioLista,
  a.Precio2,
  a.Precio3,
  a.Precio4,
  a.Precio5,
  a.Precio6,
  a.Precio7,
  a.Precio8,
  a.Precio9,
  a.Precio10,
  a.PrecioMinimo,
  a.MargenMinimo,
  a.Margen,
  a.MonedaCosto,
  c.CostoPromedio,
  c.UltimoCosto,
  c.UltimoCostoSinGastos,
  a.CostoEstandar,
  a.CostoReposicion,
  "TipoCambioCosto" = mc.TipoCambio,
  a.Categoria,
  a.Grupo,
  a.Familia,
  a.Fabricante,
  a.Linea

FROM 
  Art a
  LEFT OUTER JOIN ArtCostoEmpresa c ON a.Articulo = c.Articulo
  JOIN Mon mv ON a.MonedaPrecio = mv.Moneda
  JOIN Mon mc ON a.MonedaCosto = mc.Moneda
GO

/*** ActivoFDisponible ***/
if exists (select * from sysobjects where id = object_id('dbo.ActivoFDisponible') and type = 'V') drop view dbo.ActivoFDisponible
GO
CREATE VIEW ActivoFDisponible
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa Empresa,
  Cuenta Articulo,
  Grupo Almacen,
  sum(SaldoU) Disponible

FROM 
  SaldoU

WHERE 
  Rama='AF'

GROUP BY 
  Empresa, Cuenta, Grupo
GO

/*** ActivoFSubDisponible ***/
if exists (select * from sysobjects where id = object_id('dbo.ActivoFSubDisponible') and type = 'V') drop view dbo.ActivoFSubDisponible
GO
CREATE VIEW ActivoFSubDisponible
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa Empresa,
  Cuenta Articulo,
  SubCuenta SubCuenta,
  Grupo Almacen,
  Sum(SaldoU) Disponible

FROM 
  SaldoU 

WHERE 
  SubCuenta is NOT NULL AND Rama = 'AF'

GROUP BY 
  Empresa, Cuenta, Grupo, SubCuenta
GO


-- select * from ArtExistenciaTarima
/*** ArtExistenciaTarima ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtExistenciaTarima') and type = 'V') drop view dbo.ArtExistenciaTarima
GO
CREATE VIEW ArtExistenciaTarima
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.Grupo Almacen,
  s.SubGrupo Tarima,
  Sum(s.SaldoU*r.Factor) Existencia

FROM SaldoUWMS s
JOIN Rama r ON s.Rama=r.Rama

WHERE r.Mayor IN ('WMS','PZA') and r.Rama <> 'RESV' --Task 8036

GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo, s.SubGrupo
GO

/*** ArtExistenciaConsig ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtExistenciaConsig') and type = 'V') drop view dbo.ArtExistenciaConsig
GO
CREATE VIEW ArtExistenciaConsig
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.Grupo Almacen,
  Sum(s.SaldoU*r.Factor) Existencia

FROM SaldoU s
JOIN Rama r ON s.Rama=r.Rama

WHERE r.Mayor IN ('INV','PZA') and r.Rama <> 'RESV'

GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo
GO

/*** ArtSubExistenciaConsig ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubExistenciaConsig') and type = 'V') drop view dbo.ArtSubExistenciaConsig
GO
CREATE VIEW ArtSubExistenciaConsig
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.SubCuenta SubCuenta,
  s.Grupo Almacen,
  Sum(s.SaldoU*r.Factor) Existencia

FROM SaldoU s
JOIN Rama r ON s.Rama=r.Rama and r.Mayor IN ('INV','PZA') and r.Rama <> 'RESV'
GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo, s.SubCuenta
GO

/*** ArtSubExistenciaConsigOpcion ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubExistenciaConsigOpcion') and type = 'V') drop view dbo.ArtSubExistenciaConsigOpcion
GO
CREATE VIEW ArtSubExistenciaConsigOpcion
--//WITH ENCRYPTION
AS 
SELECT 
  s.Sucursal,
  s.Rama,
  s.Moneda,
  s.Empresa,
  s.Cuenta Articulo,
  s.SubCuenta SubCuenta,
  s.Grupo Almacen,
  s.SubGrupo,
  Sum(s.SaldoU*r.Factor) Existencia

FROM SaldoUOpcion s
JOIN Rama r ON s.Rama=r.Rama and r.Mayor IN ('INV','PZA') and r.Rama <> 'RESV'
GROUP BY 
  s.Sucursal, s.Rama, s.Moneda, s.Empresa, s.Cuenta, s.Grupo, s.SubCuenta, s.SubGrupo
GO

/*** ArtSubExistenciaConsigAF ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubExistenciaConsigAF') and type = 'V') drop view dbo.ArtSubExistenciaConsigAF
GO
CREATE VIEW ArtSubExistenciaConsigAF
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.SubCuenta SubCuenta,
  s.Grupo Almacen,
  Sum(s.SaldoU*r.Factor) Existencia

FROM SaldoU s
JOIN Rama r ON s.Rama=r.Rama AND r.Rama IN ('INV', 'CSG', 'GAR', 'VMOS', 'AF')
GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo, s.SubCuenta
GO

/*** ArtSubExistenciaConsigAFTarima ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubExistenciaConsigAFTarima') and type = 'V') drop view dbo.ArtSubExistenciaConsigAFTarima
GO
CREATE VIEW ArtSubExistenciaConsigAFTarima
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.SubCuenta SubCuenta,
  s.Grupo Almacen,
  s.SubGrupo Tarima,
  Sum(s.SaldoU*r.Factor) Existencia

FROM SaldoUWMS s
JOIN Rama r ON s.Rama=r.Rama and r.Rama IN ('WMS', 'CSG', 'GAR', 'VMOS', 'AF')
GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo, s.SubGrupo, s.SubCuenta
GO

/*** ArtSubExistenciaConsigAFTarima2 ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubExistenciaConsigAFTarima2') and type = 'V') drop view dbo.ArtSubExistenciaConsigAFTarima2
GO
CREATE VIEW ArtSubExistenciaConsigAFTarima2
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.SubCuenta SubCuenta,
  s.Grupo Almacen,
  s.SubGrupo Tarima,
  Sum(s.SaldoU*r.Factor) Existencia

FROM SaldoU s
JOIN Rama r ON s.Rama=r.Rama and r.Rama IN ('INV', 'CSG', 'GAR', 'VMOS', 'AF')
GROUP BY 
  s.Empresa, s.Cuenta, s.Grupo, s.SubGrupo, s.SubCuenta
GO



/*** SerieLoteDias ***/
if exists (select * from sysobjects where id = object_id('dbo.SerieLoteDias') and type = 'V') drop view dbo.SerieLoteDias
GO
CREATE VIEW SerieLoteDias
--//WITH ENCRYPTION
AS 
SELECT
  Empresa,
  Articulo,
  SubCuenta,
  SerieLote,
  Almacen,
  Propiedades,
  Existencia,
  ExistenciaAlterna,
  UltimaEntrada,
  UltimaSalida,
  "Dias"=DATEDIFF(day, UltimaEntrada, GETDATE())
FROM
  SerieLote
GO

/*** ArtExistenciaNeta ***/

if exists (select * from sysobjects where id = object_id('dbo.ArtExistenciaNeta') and type = 'V') drop view dbo.ArtExistenciaNeta
GO
CREATE VIEW ArtExistenciaNeta
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa Empresa,
  Cuenta Articulo,
  Grupo Almacen,
  Moneda,
  Sum(s.SaldoU*r.Factor) Existencia

FROM SaldoU s
JOIN Rama r  ON s.Rama = r.Rama AND s.Rama IN ('INV', 'VMOS')
GROUP BY 
  Empresa, Cuenta, Grupo, Moneda
GO



-- select * from ArtSubExistenciaInv
/*** ArtSubExistenciaInv ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubExistenciaInv') and type = 'V') drop view dbo.ArtSubExistenciaInv
GO
CREATE VIEW ArtSubExistenciaInv
--//WITH ENCRYPTION
AS 
SELECT 
  Sucursal,
  Empresa,
  Cuenta Articulo,
  SubCuenta,
  Grupo Almacen,
  "Llave" = RTRIM(Cuenta)+CHAR(9)+ISNULL(RTRIM(SubCuenta), ''),
  Sum(SaldoU) Inventario

FROM 
  SaldoU

WHERE 
  Rama = 'INV'

GROUP BY 
  Sucursal, Empresa, Cuenta, SubCuenta, Grupo
GO

-- select * from ArtSubExistenciaInvTarima
/*** ArtSubExistenciaInvTarima ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubExistenciaInvTarima') and type = 'V') drop view dbo.ArtSubExistenciaInvTarima
GO
CREATE VIEW ArtSubExistenciaInvTarima
--//WITH ENCRYPTION
AS 
SELECT 
  Sucursal,
  Empresa,
  Cuenta Articulo,
  SubCuenta,
  Grupo Almacen,
  SubGrupo Tarima,
  "Llave" = RTRIM(Cuenta)+CHAR(9)+ISNULL(RTRIM(SubCuenta), ''),
  Sum(SaldoU) Inventario

FROM 
  SaldoUWMS

WHERE 
  Rama = 'WMS'

GROUP BY 
  Sucursal, Empresa, Cuenta, SubCuenta, Grupo, SubGrupo
GO



/*** ArtSubExistenciaInvCsg ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubExistenciaInvCsg') and type = 'V') drop view dbo.ArtSubExistenciaInvCsg
GO
CREATE VIEW ArtSubExistenciaInvCsg
--//WITH ENCRYPTION
AS 
SELECT 
  Sucursal,
  Empresa,
  Cuenta Articulo,
  SubCuenta,
  Grupo Almacen,
  "Llave" = RTRIM(Cuenta)+CHAR(9)+ISNULL(RTRIM(SubCuenta), ''),
  Sum(SaldoU) Existencia

FROM 
  SaldoU

WHERE 
  Rama IN ('INV', 'CSG')

GROUP BY 
  Sucursal, Empresa, Cuenta, SubCuenta, Grupo
GO

/*** ArtSubExistenciaInvCsgTarima ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubExistenciaInvCsgTarima') and type = 'V') drop view dbo.ArtSubExistenciaInvCsgTarima
GO
CREATE VIEW ArtSubExistenciaInvCsgTarima
--//WITH ENCRYPTION
AS 
SELECT 
  Sucursal,
  Empresa,
  Cuenta Articulo,
  SubCuenta,
  Grupo Almacen,
  SubGrupo Tarima,
  "Llave" = RTRIM(Cuenta)+CHAR(9)+ISNULL(RTRIM(SubCuenta), ''),
  Sum(SaldoU) Existencia

FROM 
  SaldoUWMS

WHERE 
  Rama IN ('WMS', 'CSG')

GROUP BY 
  Sucursal, Empresa, Cuenta, SubCuenta, Grupo, SubGrupo
GO

/*** ArtRemisionado ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtRemisionado') and type = 'V') drop view dbo.ArtRemisionado
GO
CREATE VIEW ArtRemisionado
--//WITH ENCRYPTION
AS 
SELECT 
  v.Empresa,
  d.Articulo,
  d.Almacen,
  "Remisionado"=Sum(d.CantidadPendiente)

FROM Venta v
JOIN VentaD d ON v.ID = d.ID 
JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS'
WHERE 
  v.Estatus = 'PENDIENTE' AND mt.Clave = 'VTAS.R'
GROUP BY 
  v.Empresa, d.Articulo, d.Almacen
GO

/*** ArtPedidos ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtPedidos') and type = 'V') drop view dbo.ArtPedidos
GO
CREATE VIEW ArtPedidos
--//WITH ENCRYPTION
AS 
SELECT 
  v.Empresa,
  d.Articulo,
  d.Almacen,
  "CantidadPendiente" = Sum(d.CantidadPendiente)

FROM Venta v
JOIN VentaD d ON v.ID = d.ID 
JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS'
WHERE 
  v.Estatus = 'PENDIENTE' 
  AND mt.Clave = 'VTAS.P'
GROUP BY 
  v.Empresa, d.Articulo, d.Almacen
GO

/*** ArtSolicitudes ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSolicitudes') and type = 'V') drop view dbo.ArtSolicitudes
GO
CREATE VIEW ArtSolicitudes
--//WITH ENCRYPTION
AS 
SELECT 
  i.Empresa,
  d.Articulo,
  d.Almacen,
  "CantidadPendiente" = Sum(d.CantidadPendiente)

FROM Inv i
JOIN InvD d ON i.ID = d.ID
JOIN MovTipo mt ON i.Mov = mt.Mov AND mt.Modulo = 'INV'

WHERE 
  i.Estatus = 'PENDIENTE' 
  AND mt.Clave IN ('INV.SOL', 'INV.OT', 'INV.OI', 'INV.SM')
GROUP BY 
  i.Empresa, d.Articulo, d.Almacen
GO


/*** ArtExistenciaReservado ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtExistenciaReservado') and type = 'V') drop view dbo.ArtExistenciaReservado
GO
CREATE VIEW ArtExistenciaReservado
--//WITH ENCRYPTION
AS 
SELECT e.Empresa, 
       e.Articulo,
       e.Almacen,
       "Existencias" = e.Existencia,
       "Reservado" = r.Reservado,
       ar.Remisionado,
       "Disponible" = NULLIF(ISNULL(e.Existencia, 0.0)-ISNULL(r.Reservado, 0.0), 0.0)
  FROM ArtExistenciaConsig e
  LEFT OUTER JOIN ArtReservado r ON e.Empresa = r.Empresa AND e.Articulo = r.Articulo AND e.Almacen = r.Almacen AND NULLIF(RTRIM(e.Almacen), '') IS NOT NULL
  LEFT OUTER JOIN ArtRemisionado ar ON e.Empresa = ar.Empresa AND e.Articulo = ar.Articulo AND e.Almacen = ar.Almacen
GO

/*** ArtSubReservado ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubReservado') and type = 'V') drop view dbo.ArtSubReservado
GO
CREATE VIEW ArtSubReservado
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Articulo,
  s.SubCuenta,
  s.Grupo Almacen,
  sum(s.SaldoU) Reservado

FROM SaldoU s
JOIN Rama r ON s.Rama=r.Rama and r.Rama='RESV'
GROUP BY 
  s.Empresa, s.Cuenta, s.SubCuenta, s.Grupo
GO

/*** ArtSubReservadoOpcion ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubReservadoOpcion') and type = 'V') drop view dbo.ArtSubReservadoOpcion
GO
CREATE VIEW ArtSubReservadoOpcion
--//WITH ENCRYPTION
AS 
SELECT 
  s.Sucursal,
  s.Rama,
  s.Moneda,
  s.Empresa,
  s.Cuenta Articulo,
  s.SubCuenta,
  s.Grupo Almacen,
  s.SubGrupo,
  sum(s.SaldoU) Reservado

FROM SaldoUOpcion s
JOIN Rama r ON s.Rama=r.Rama and r.Rama='RESV'
GROUP BY 
    s.Sucursal, s.Rama, s.Moneda, s.Empresa, s.Cuenta, s.SubCuenta, s.Grupo, s.SubGrupo
GO

/*** ArtSubRemisionado ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubRemisionado') and type = 'V') drop view dbo.ArtSubRemisionado
GO
CREATE VIEW ArtSubRemisionado
--//WITH ENCRYPTION
AS 
SELECT 
  v.Empresa,
  d.Articulo,
  d.SubCuenta,
  d.Almacen,
  "Remisionado"=Sum(d.CantidadPendiente)

FROM Venta v
JOIN VentaD d ON v.ID = d.ID 
JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS'
WHERE 
  v.Estatus = 'PENDIENTE' 
  AND mt.Clave = 'VTAS.R'
GROUP BY 
  v.Empresa, d.Articulo, d.SubCuenta, d.Almacen
GO

/*** ArtSubExistenciaReservado ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubExistenciaReservado') and type = 'V') drop view dbo.ArtSubExistenciaReservado
GO
CREATE VIEW ArtSubExistenciaReservado
--//WITH ENCRYPTION
AS 
SELECT e.Empresa, 
       e.Articulo,
       e.SubCuenta,
       e.Almacen,
       "Existencias" = e.Existencia,
       r.Reservado Reservado,
       ar.Remisionado,
       (ISNULL(e.Existencia, 0.0)-ISNULL(r.Reservado, 0.0)) Disponible
  FROM ArtSubExistenciaConsig e
  LEFT OUTER JOIN ArtSubReservado r ON e.Empresa = r.Empresa AND e.Articulo = r.Articulo AND e.SubCuenta = r.SubCuenta AND e.Almacen = r.Almacen AND NULLIF(RTRIM(e.Almacen), '') IS NOT NULL
  LEFT OUTER JOIN ArtSubRemisionado ar ON e.Empresa = ar.Empresa AND e.Articulo = ar.Articulo AND e.SubCuenta = ar.SubCuenta AND e.Almacen = ar.Almacen
GO

/*** ArtSubExistenciaReservadoOpcion ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubExistenciaReservadoOpcion') and type = 'V') drop view dbo.ArtSubExistenciaReservadoOpcion
GO
CREATE VIEW ArtSubExistenciaReservadoOpcion
--//WITH ENCRYPTION
AS 
SELECT e.Sucursal,
       e.Rama,
       e.Moneda,
       e.Empresa, 
       e.Articulo,
       e.SubCuenta,
       e.Almacen,
       e.SubGrupo,
       "Existencias" = e.Existencia,
       r.Reservado Reservado,
       ar.Remisionado,
       (ISNULL(e.Existencia, 0.0)-ISNULL(r.Reservado, 0.0)) Disponible
  FROM ArtSubExistenciaConsigOpcion e
  LEFT OUTER JOIN ArtSubReservadoOpcion r ON e.Empresa = r.Empresa AND e.Articulo = r.Articulo AND e.SubCuenta = r.SubCuenta AND e.Almacen = r.Almacen AND NULLIF(RTRIM(e.Almacen), '') IS NOT NULL
  LEFT OUTER JOIN ArtSubRemisionado ar ON e.Empresa = ar.Empresa AND e.Articulo = ar.Articulo AND e.SubCuenta = ar.SubCuenta AND e.Almacen = ar.Almacen
GO

/***************************************** VISTAS CXC Y CXP *****************************************/

/*** CxcProntoPago ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcProntoPago') and type = 'V') drop view dbo.CxcProntoPago
GO
/*** CxpProntoPago ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpProntoPago') and type = 'V') drop view dbo.CxpProntoPago
GO

/*** CxcSaldo ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcSaldo') and type = 'V') drop view dbo.CxcSaldo
GO
CREATE VIEW CxcSaldo
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa,
  s.Moneda,
  s.Cuenta Cliente,
  Convert(money, Sum(s.Saldo*r.Factor)) Saldo

FROM Saldo s
JOIN Rama r ON s.Rama=r.Rama AND r.Mayor='CXC' 
GROUP BY 
  s.Empresa, s.Moneda, s.Cuenta
GO

/*** CxcSaldoSucursal ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcSaldoSucursal') and type = 'V') drop view dbo.CxcSaldoSucursal
GO
CREATE VIEW CxcSaldoSucursal
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa,
  s.Sucursal,
  s.Moneda,
  s.Cuenta Cliente,
  Convert(money, Sum(s.Saldo*r.Factor)) Saldo

FROM Saldo s
JOIN Rama r ON s.Rama=r.Rama AND r.Mayor='CXC' 
GROUP BY 
  s.Empresa, s.Sucursal, s.Moneda, s.Cuenta
GO


/*** CxcConSaldo ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcConSaldo') and type = 'V') drop view dbo.CxcConSaldo
GO
CREATE VIEW CxcConSaldo
--//WITH ENCRYPTION
AS
SELECT
  CxcSaldo.Empresa,
  CxcSaldo.Cliente,
  CxcSaldo.Moneda,
  CxcSaldo.Saldo,
  Cte.Nombre,
  Cte.NombreCorto,
  Cte.Numero,
  Cte.Categoria,
  Cte.Familia,
  Cte.Grupo,
  Cte.Estatus

FROM CxcSaldo
JOIN Cte ON CxcSaldo.Cliente=Cte.Cliente
JOIN Version ON 1 = 1
WHERE
   ROUND(CxcSaldo.Saldo, Version.RedondeoMonetarios)<>0
GO

/*** CxpSaldo ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpSaldo') and type = 'V') drop view dbo.CxpSaldo
GO
CREATE VIEW CxpSaldo
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa,
  s.Moneda,
  s.Cuenta Proveedor,
  Convert(money, Sum(s.Saldo*r.Factor)) Saldo

FROM Saldo s
JOIN Rama r ON s.Rama=r.Rama AND r.Mayor='CXP' 
GROUP BY 
  s.Empresa, s.Moneda, s.Cuenta
GO


/*** CxpSaldoSucursal ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpSaldoSucursal') and type = 'V') drop view dbo.CxpSaldoSucursal
GO
CREATE VIEW CxpSaldoSucursal
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa,
  s.Sucursal,
  s.Moneda,
  s.Cuenta Cliente,
  Convert(money, Sum(s.Saldo*r.Factor)) Saldo

FROM Saldo s
JOIN Rama r ON s.Rama=r.Rama AND r.Mayor='CXP' 
GROUP BY 
  s.Empresa, s.Sucursal, s.Moneda, s.Cuenta
GO

/*** CxpConSaldo ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpConSaldo') and type = 'V') drop view dbo.CxpConSaldo
GO
CREATE VIEW CxpConSaldo
--//WITH ENCRYPTION
AS
SELECT
  CxpSaldo.Empresa,
  CxpSaldo.Proveedor,
  CxpSaldo.Moneda,
  CxpSaldo.Saldo,
  Prov.Nombre,
  Prov.NombreCorto,
  Prov.Categoria,
  Prov.Familia,
  Prov.Estatus

FROM CxpSaldo
JOIN Prov ON CxpSaldo.Proveedor=Prov.Proveedor
JOIN Version ON 1 = 1
WHERE
  ROUND(CxpSaldo.Saldo, Version.RedondeoMonetarios)<>0
GO

/*** CxcAplica ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcAplica') and type = 'V') drop view dbo.CxcAplica
GO
CREATE VIEW CxcAplica
--//WITH ENCRYPTION
AS 
SELECT 
  Cxc.ID,
  Cxc.Empresa, 
  Cxc.Mov, 
  Cxc.MovID, 
  Cxc.Cliente,
  Cxc.ClienteEnviarA,
  "Moneda" = Cxc.ClienteMoneda,
  "TipoCambio" = Cxc.ClienteTipoCambio,
  Cxc.FechaEmision, 
  Cxc.Vencimiento, 
  "DiasCredito" = DATEDIFF(day, FechaEmision, Vencimiento),
  Cxc.Importe,
  Cxc.Impuestos,
  "ImporteTotal" = ISNULL(Cxc.Importe, 0.0) + ISNULL(Cxc.Impuestos,0.0) - ISNULL(Cxc.Retencion, 0.0) - ISNULL(Cxc.Retencion2, 0.0) - ISNULL(Cxc.Retencion3, 0.0),
  Cxc.Saldo,
  Cxc.Referencia,
  Cxc.Concepto,
  Cxc.Estatus,
  "DiasMoratorios"  = datediff(day, Cxc.Vencimiento, GETDATE()),
  "FechaProntoPago" = Cxc.FechaProntoPago,
  Cxc.DescuentoProntoPago,
  "ProntoPago" = CASE WHEN Cte.DescuentoRecargos = 1 AND Cfg.CxcDescContado = 1 AND GETDATE()<DATEADD(day, cfg.CxcDescContadoDias, Cxc.FechaEmision) THEN Cxc.Saldo*cfg.CxcDescContadoPorcentaje/100 ELSE CONVERT(money, CASE WHEN GETDATE()<DATEADD(day, 1, Cxc.FechaProntoPago) THEN (ISNULL(Cxc.Importe, 0)+ISNULL(Cxc.Impuestos,0))*(Cxc.DescuentoProntoPago/100) END) END,
  Cxc.IVAFiscal,
  Cxc.IEPSFiscal,
  Cxc.Retencion,
  Cxc.Retencion2,
  Cxc.Retencion3,      
  Cxc.Situacion,
  Cxc.SituacionFecha,
  Cxc.SituacionUsuario,
  Cxc.SituacionNota,
  Cxc.Sucursal,
  Cxc.OrigenTipo,
  Cxc.Origen,
  Cxc.OrigenID,
  Cxc.Proyecto,
  Cxc.UEN,
  Cxc.LineaCredito,
  Cxc.TipoAmortizacion,
  Cxc.TipoTasa,
  Cxc.TasaDiaria,
  Cxc.Amortizaciones,
  Cxc.InteresesOrdinarios,
  Cxc.InteresesFijos,
  Cxc.InteresesMoratorios,
  Cxc.SaldoInteresesOrdinarios,
  Cxc.SaldoInteresesOrdinariosIVA, --MEJORA10041  
  Cxc.SaldoInteresesMoratorios,
  Cxc.SaldoInteresesMoratoriosIVA, --MEJORA10041  
  "SaldoTotal" = ISNULL(Saldo, 0.0)+ISNULL(SaldoInteresesOrdinarios, 0.0)+ISNULL(SaldoInteresesOrdinariosIVA, 0.0)+ISNULL(SaldoInteresesMoratorios, 0.0)+ISNULL(SaldoInteresesMoratoriosIVA, 0.0), --MEJORA10041
  "MovMoneda" = Moneda,
  "MovTipoCambio" = TipoCambio,
  Cxc.RamaID,
  Cxc.PadreMAVI,
  Cxc.PadreIDMAVI,
  Cxc.IDPadreMAVI

FROM Cxc
JOIN Cte ON Cte.Cliente = Cxc.Cliente
JOIN EmpresaCfg Cfg ON Cfg.Empresa = Cxc.Empresa
WHERE  UPPER(Cxc.Estatus) NOT IN ('SINAFECTAR', 'CANCELADO')
GO


/*** CxcDAplica ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcDAplica') and type = 'V') drop view dbo.CxcDAplica
GO
CREATE VIEW CxcDAplica
--//WITH ENCRYPTION
AS 
SELECT 
  d.ID,
  d.Renglon,
  d.RenglonSub,
  d.Importe,
  d.Aplica,
  d.AplicaID,
  e.Cliente,
  e.ClienteEnviarA,
  'AplicaFechaEmision' = a.FechaEmision,
  'AplicaVencimiento'  = a.Vencimiento,
  'AplicaSaldo'        = a.Saldo,
  'AplicaMoneda'       = a.Moneda,
  'AplicaTipoCambio'   = a.TipoCambio

FROM CxcD d
JOIN Cxc e ON e.ID = d.ID
JOIN Cxc a ON a.Empresa = e.Empresa AND a.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND a.Mov = d.Aplica AND a.MovID = d.AplicaID
GO

/*** CxcPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcPendiente') and type = 'V') drop view dbo.CxcPendiente
GO
CREATE VIEW CxcPendiente
--//WITH ENCRYPTION
AS 
SELECT 
  *
FROM 
  CxcAplica
WHERE 
  UPPER(Estatus) = 'PENDIENTE'
GO

/*** CxcPendienteWizard ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcPendienteWizard') and type = 'V') drop view dbo.CxcPendienteWizard
GO
CREATE VIEW CxcPendienteWizard
--//WITH ENCRYPTION
AS 
SELECT cp.*
  FROM CxcPendiente cp
  JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = cp.Mov
 WHERE mt.Clave NOT IN ('CXC.A')
GO

/*** CxpAplica ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpAplica') and type = 'V') drop view dbo.CxpAplica
GO
CREATE VIEW CxpAplica
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  Mov, 
  MovID, 
  Proveedor,
  "Moneda" = ProveedorMoneda,
  "TipoCambio" = ProveedorTipoCambio,
  FechaEmision, 
  Vencimiento, 
  "DiasCredito" = DATEDIFF(day, FechaEmision, Vencimiento),
  "ImporteTotal" = ISNULL(Importe, 0.0) + ISNULL(Impuestos,0.0) - ISNULL(Retencion, 0.0) - ISNULL(Retencion2, 0.0) - ISNULL(Retencion3, 0.0),
  Saldo,
  Referencia,
  Concepto,
  Estatus,
  "DiasMoratorios"  = datediff(day, Vencimiento, GETDATE()),
  "FechaProntoPago" = FechaProntoPago,
  DescuentoProntoPago,
  "ProntoPago"      = CONVERT(money, CASE WHEN GETDATE()<DATEADD(day, 1, FechaProntoPago) THEN (ISNULL(Importe, 0)+ISNULL(Impuestos,0))*(DescuentoProntoPago/100) END),
  IVAFiscal,
  IEPSFiscal,
  Sucursal,
  OrigenTipo,
  Origen,
  OrigenID,
  Proyecto,
  UEN,
  "MovMoneda" = Moneda,
  "MovTipoCambio" = TipoCambio,
  LineaCredito,
  Amortizaciones,
  InteresesOrdinarios,
  InteresesFijos,
  InteresesMoratorios,
  SaldoInteresesOrdinarios,
  SaldoInteresesOrdinariosIVA, --MEJORA10041  
  SaldoInteresesMoratorios,
  SaldoInteresesMoratoriosIVA, --MEJORA10041 
  "SaldoTotal" = ISNULL(Saldo, 0.0)+ISNULL(SaldoInteresesOrdinarios, 0.0)+ISNULL(SaldoInteresesOrdinariosIVA, 0.0)+ISNULL(SaldoInteresesMoratorios, 0.0)+ISNULL(SaldoInteresesMoratoriosIVA, 0.0), --MEJORA10041
  RamaID

FROM 
  Cxp

WHERE 
  UPPER(Estatus) NOT IN ('SINAFECTAR', 'CANCELADO')
GO

/*** CxpPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpPendiente') and type = 'V') drop view dbo.CxpPendiente
GO
CREATE VIEW CxpPendiente
--//WITH ENCRYPTION
AS 
SELECT  *
FROM 
  CxpAplica
WHERE 
  UPPER(Estatus)='PENDIENTE' 
GO

/*** CxpPendienteWizard ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpPendienteWizard') and type = 'V') drop view dbo.CxpPendienteWizard
GO
CREATE VIEW CxpPendienteWizard
--//WITH ENCRYPTION
AS 
SELECT cp.*
  FROM CxpPendiente cp
  JOIN MovTipo mt ON mt.Modulo = 'CXP' AND mt.Mov = cp.Mov
 WHERE mt.Clave NOT IN ('CXP.A')
GO

/*** CxcEfectivo a favor ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcEfectivo') and type = 'V') drop view dbo.CxcEfectivo
GO
CREATE VIEW CxcEfectivo
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa,
  Moneda,
  "Cliente" = Cuenta,
  "Saldo" = ISNULL(SUM(Saldo), 0.0) 

FROM 
  Saldo 

WHERE 
  Rama='CEFE'

GROUP BY 
  Empresa, Moneda, Cuenta
GO

/*** Consumos del Cliente ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcConsumo') and type = 'V') drop view dbo.CxcConsumo
GO
CREATE VIEW CxcConsumo
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa,
  Moneda,
  "Cliente" = Cuenta,
  "Saldo" = ISNULL(SUM(Saldo), 0.0) 

FROM 
  Saldo 

WHERE 
  Rama='CNO'

GROUP BY 
  Empresa, Moneda, Cuenta
GO

/*** CxcVale ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcVale') and type = 'V') drop view dbo.CxcVale
GO
CREATE VIEW CxcVale
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa,
  Moneda,
  "Cliente" = Cuenta ,
  "Saldo" = ISNULL(SUM(Saldo), 0.0) 

FROM 
  Saldo 

WHERE 
  Rama='CVALE'

GROUP BY 
  Empresa, Moneda, Cuenta
GO

/*** CxcRedondeo ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcRedondeo') and type = 'V') drop view dbo.CxcRedondeo
GO
CREATE VIEW CxcRedondeo
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa,
  Moneda,
  "Cliente" = Cuenta ,
  "Saldo" = ISNULL(SUM(Saldo), 0.0) 

FROM 
  Saldo 

WHERE 
  Rama='CRND'

GROUP BY 
  Empresa, Moneda, Cuenta
GO

/*** CxcCuentaCorriente ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcCuentaCorriente') and type = 'V') drop view dbo.CxcCuentaCorriente
GO
CREATE VIEW CxcCuentaCorriente
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa,
  Moneda,
  Cliente,
  "Efectivo" = Saldo,
  "Consumos" = CONVERT(money, NULL),
  "Vales" = CONVERT(money, NULL),
  "Redondeo" = CONVERT(money, NULL)
FROM 
  CxcEfectivo

UNION

SELECT 
  Empresa,
  Moneda,
  Cliente,
  "Efectivo" = CONVERT(money, NULL),
  "Consumos" = Saldo,
  "Vales" = CONVERT(money, NULL),
  "Redondeo" = CONVERT(money, NULL)
FROM 
  CxcConsumo

UNION

SELECT 
  Empresa,
  Moneda,
  Cliente,
  "Efectivo" = CONVERT(money, NULL),
  "Consumos" = CONVERT(money, NULL),
  "Vales" = Saldo,
  "Redondeo" = CONVERT(money, NULL)
FROM 
  CxcVale

UNION

SELECT 
  Empresa,
  Moneda,
  Cliente,
  "Efectivo" = CONVERT(money, NULL),
  "Consumos" = CONVERT(money, NULL),
  "Vales" = CONVERT(money, NULL),
  "Redondeo" = Saldo
FROM 
  CxcRedondeo
GO

/*** CxpRedondeo ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpRedondeo') and type = 'V') drop view dbo.CxpRedondeo
GO
CREATE VIEW CxpRedondeo
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa,
  Moneda,
  "Proveedor" = Cuenta,
  "Saldo" = ISNULL(SUM(Saldo), 0.0) 

FROM 
  Saldo 

WHERE 
  Rama='PRND'

GROUP BY 
  Empresa, Moneda, Cuenta
GO

/*** CxpEfectivo a favor ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpEfectivo') and type = 'V') drop view dbo.CxpEfectivo
GO
CREATE VIEW CxpEfectivo
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa,
  Moneda,
  "Proveedor" = Cuenta,
  "Saldo" = ISNULL(SUM(Saldo), 0.0) 

FROM 
  Saldo 

WHERE 
  Rama='PEFE'
GROUP BY 
  Empresa, Moneda, Cuenta
GO

/*** CxpCuentaCorriente ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpCuentaCorriente') and type = 'V') drop view dbo.CxpCuentaCorriente
GO
CREATE VIEW CxpCuentaCorriente
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa,
  Moneda,
  Proveedor,
  "Efectivo" = Saldo,
  "Vales" = CONVERT(money, NULL),
  "Redondeo" = CONVERT(money, NULL)
FROM 
  CxpEfectivo

UNION

SELECT 
  Empresa,
  Moneda,
  Proveedor,
  "Anticipos" = CONVERT(money, NULL),
  "Vales" = CONVERT(money, NULL),
  "Redondeo" = Saldo
FROM 
  CxpRedondeo
GO



/*** CxcInfo ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcInfo') and type = 'V') drop view dbo.CxcInfo
GO
CREATE VIEW CxcInfo
--//WITH ENCRYPTION
AS 
SELECT p.ID, p.Empresa, p.Moneda, p.Cliente, p.ClienteEnviarA, p.Mov, p.MovID, p.FechaEmision, p.Vencimiento, p.DiasMoratorios, /*p.ProntoPago, p.FechaProntoPago, p.DescuentoProntoPago,*/
      "Saldo" = CASE WHEN mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.DA','CXC.NC','CXC.DAC','CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.SCH') THEN -p.Saldo ELSE p.Saldo END,
       p.Concepto, p.Referencia, p.Estatus, p.Situacion, p.SituacionFecha, p.SituacionUsuario, p.SituacionNota, p.Proyecto, p.UEN
  FROM CxcAplica p
  JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = 'CXC'
  JOIN Version v ON 1 = 1
 WHERE ROUND(p.Saldo, v.RedondeoMonetarios) <> 0.0 AND p.Estatus = 'PENDIENTE'
UNION
SELECT NULL, Empresa, Moneda, Cliente, NULL,
       "Mov" = CASE
         WHEN Round(Saldo, v.RedondeoMonetarios)<=0 THEN "Saldo a Favor" 
         ELSE "Saldo en Contra" END, 
       "MovID"= NULL, "FechaEmision"=NULL, "Vencimiento"=NULL, "DiasMoratorios"=NULL, /*"ProntoPago"=NULL, "FechaProntoPago"=NULL, "DescuentoProntoPago"=NULL, */Saldo, "Concepto"=NULL, "Referencia"=NULL, Estatus='PENDIENTE',
       "Situacion" = NULL, SituacionFecha = NULL, SituacionUsuario = NULL, SituacionNota = NULL, Proyecto = NULL, UEN = NULL
  FROM CxcEfectivo p
  JOIN Version v ON 1 = 1
 WHERE ROUND(Saldo, v.RedondeoMonetarios) <> 0.0
UNION
SELECT NULL, Empresa, Moneda, Cliente, NULL,
       "Mov" = "Consumos por Facturar", "MovID"= NULL, 
       "FechaEmision"=NULL, "Vencimiento"=NULL, "DiasMoratorios"=NULL, /*"ProntoPago"=NULL, "FechaProntoPago"=NULL, "DescuentoProntoPago"=NULL, */Saldo, "Concepto"=NULL, "Referencia"=NULL, Estatus='PENDIENTE', 
       "Situacion" = NULL, SituacionFecha = NULL, SituacionUsuario = NULL, SituacionNota = NULL, Proyecto = NULL, UEN = NULL
  FROM CxcConsumo p
  JOIN Version v ON 1 = 1
 WHERE ROUND(Saldo, v.RedondeoMonetarios) <> 0.0
UNION
SELECT NULL, Empresa, Moneda, Cliente, NULL,
       "Mov" = "Vales en Circulacion", "MovID"= NULL, 
       "FechaEmision"=NULL, "Vencimiento"=NULL, "DiasMoratorios"=NULL, /*"ProntoPago"=NULL, "FechaProntoPago"=NULL, "DescuentoProntoPago"=NULL, */Saldo, "Concepto"=NULL, "Referencia"=NULL, Estatus='PENDIENTE', 
       "Situacion" = NULL, SituacionFecha = NULL, SituacionUsuario = NULL, SituacionNota = NULL, Proyecto = NULL, UEN = NULL
  FROM CxcVale p
  JOIN Version v ON 1 = 1
 WHERE ROUND(Saldo, v.RedondeoMonetarios) <> 0.0
UNION
SELECT NULL, Empresa, Moneda, Cliente, NULL,
       "Mov" = "Redondeo", "MovID"= NULL,  
       "FechaEmision"=NULL, "Vencimiento"=NULL, "DiasMoratorios"=NULL, /*"ProntoPago"=NULL, "FechaProntoPago"=NULL, "DescuentoProntoPago"=NULL, */Saldo, "Concepto"=NULL, "Referencia"=NULL, Estatus='PENDIENTE', 
       "Situacion" = NULL, SituacionFecha = NULL, SituacionUsuario = NULL, SituacionNota = NULL, Proyecto = NULL, UEN = NULL
  FROM CxcRedondeo p
  JOIN Version v ON 1 = 1
 WHERE ROUND(Saldo,     v.RedondeoMonetarios) <> 0.0
GO

-- select * from dbo.fnCxcInfo('DEMO', 'MEX', 'MEX')
/**************** fnCxcInfo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCxcInfo' AND type = 'TF') DROP FUNCTION fnCxcInfo
GO
CREATE FUNCTION fnCxcInfo (@Empresa char(5), @ClienteD char(10), @ClienteA char(10))
RETURNS @Resultado TABLE (ID int NULL, Empresa char(5) NULL, Moneda char(10) NULL, TipoCambio float NULL, Cliente char(10) NULL, ClienteEnviarA int NULL, Mov varchar(20) NULL, MovID varchar(20) NULL, 
                          FechaEmision datetime NULL, Vencimiento datetime NULL, DiasMoratorios int NULL, Saldo money NULL, Concepto varchar(50) NULL, Referencia varchar(50), 
                          Estatus varchar(15) NULL, Situacion varchar(50) NULL, SituacionFecha datetime NULL, SituacionUsuario varchar(10) NULL, SituacionNota varchar(100) NULL, Proyecto varchar(50) NULL, UEN int NULL)
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado(ID, Empresa, Moneda, TipoCambio, Cliente, ClienteEnviarA, Mov, MovID, FechaEmision, Vencimiento, DiasMoratorios, Saldo, Concepto, Referencia, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Proyecto, UEN)
  SELECT p.ID, p.Empresa, p.Moneda, p.TipoCambio, p.Cliente, p.ClienteEnviarA, p.Mov, p.MovID, p.FechaEmision, p.Vencimiento, p.DiasMoratorios, 
        "Saldo" = CASE WHEN mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.DA','CXC.NC','CXC.DAC','CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.SCH') THEN -p.Saldo ELSE p.Saldo END,
         p.Concepto, p.Referencia, p.Estatus, p.Situacion, p.SituacionFecha, p.SituacionUsuario, p.SituacionNota, p.Proyecto, p.UEN
    FROM CxcAplica p
    JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = 'CXC'
    JOIN Version v ON 1 = 1
   WHERE ROUND(p.Saldo, v.RedondeoMonetarios) <> 0.0 AND p.Estatus = 'PENDIENTE'
     AND p.Empresa = @Empresa AND p.Cliente BETWEEN @ClienteD AND @ClienteA

  INSERT @Resultado(Empresa, Moneda, TipoCambio, Cliente, Mov, Saldo, Estatus)
  SELECT p.Empresa, p.Moneda, m.TipoCambio, p.Cliente, CASE WHEN Round(p.Saldo, v.RedondeoMonetarios)<=0 THEN 'Saldo a Favor' ELSE 'Saldo en Contra' END, p.Saldo, 'PENDIENTE'
    FROM CxcEfectivo p
    JOIN Mon m ON m.Moneda = p.Moneda
    JOIN Version v ON 1 = 1
   WHERE ROUND(p.Saldo, v.RedondeoMonetarios) <> 0.0
     AND p.Empresa = @Empresa AND p.Cliente BETWEEN @ClienteD AND @ClienteA

  INSERT @Resultado(Empresa, Moneda, TipoCambio, Cliente, Mov, Saldo, Estatus)
  SELECT p.Empresa, p.Moneda, m.TipoCambio, p.Cliente, 'Consumos por Facturar', p.Saldo, 'PENDIENTE'
    FROM CxcConsumo p
    JOIN Mon m ON m.Moneda = p.Moneda
    JOIN Version v ON 1 = 1
   WHERE ROUND(p.Saldo, v.RedondeoMonetarios) <> 0.0
     AND p.Empresa = @Empresa AND p.Cliente BETWEEN @ClienteD AND @ClienteA

  INSERT @Resultado(Empresa, Moneda, TipoCambio, Cliente, Mov, Saldo, Estatus)
  SELECT p.Empresa, p.Moneda, m.TipoCambio, p.Cliente, 'Vales en Circulacion', p.Saldo, 'PENDIENTE'
    FROM CxcVale p
    JOIN Mon m ON m.Moneda = p.Moneda
    JOIN Version v ON 1 = 1
   WHERE ROUND(p.Saldo, v.RedondeoMonetarios) <> 0.0
     AND p.Empresa = @Empresa AND p.Cliente BETWEEN @ClienteD AND @ClienteA

  INSERT @Resultado(Empresa, Moneda, TipoCambio, Cliente, Mov, Saldo, Estatus)
  SELECT p.Empresa, p.Moneda, m.TipoCambio, p.Cliente, 'Redondeo', p.Saldo, 'PENDIENTE'
    FROM CxcRedondeo p
    JOIN Mon m ON m.Moneda = p.Moneda
    JOIN Version v ON 1 = 1
   WHERE ROUND(p.Saldo, v.RedondeoMonetarios) <> 0.0
     AND p.Empresa = @Empresa AND p.Cliente BETWEEN @ClienteD AND @ClienteA

  RETURN 
END
GO


/*** CxpInfo ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpInfo') and type = 'V') drop view dbo.CxpInfo
GO
CREATE VIEW CxpInfo
--//WITH ENCRYPTION
AS 
SELECT p.ID, p.Empresa, p.Moneda, p.Proveedor, p.Mov, p.MovID, p.FechaEmision, p.Vencimiento, p.DiasMoratorios, /*p.ProntoPago, p.FechaProntoPago, p.DescuentoProntoPago,*/
      "Saldo" = CASE WHEN mt.Clave IN ('CXP.A', 'CXP.DA','CXP.NC','CXP.DAC','CXP.NCD','CXP.NCF','CXP.NCP', 'CXP.SD') THEN -p.Saldo ELSE p.Saldo END,
       p.Referencia, p.Estatus, p.Proyecto, p.UEN
  FROM CxpAplica p
  JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = 'CXP'
  JOIN Version v ON 1 = 1
 WHERE ROUND(p.Saldo, v.RedondeoMonetarios) <> 0.0 AND p.Estatus = 'PENDIENTE'
UNION ALL
SELECT NULL, Empresa, Moneda, Proveedor, 
       "Mov" = CASE
         WHEN Round(Saldo, v.RedondeoMonetarios)<=0 THEN "Saldo a Favor" 
         ELSE "Saldo en Contra" END, 
       "MovID"=NULL, "FechaEmision"=NULL, "Vencimiento"=NULL, "DiasMoratorios"=NULL, /*"ProntoPago"=NULL, "FechaProntoPago"=NULL, "DescuentoProntoPago"=NULL, */Saldo, "Referencia"=NULL, "Estatus"='PENDIENTE', Proyecto = NULL, UEN = NULL
  FROM CxpEfectivo
  JOIN Version v ON 1 = 1
 WHERE ROUND(Saldo, v.RedondeoMonetarios) <> 0.0
UNION ALL
SELECT NULL, Empresa, Moneda, Proveedor, 
       "Mov" = "Redondeo", "MovID"= NULL,  
       "FechaEmision"=NULL, "Vencimiento"=NULL, "DiasMoratorios"=NULL, /*"ProntoPago"=NULL, "FechaProntoPago"=NULL, "DescuentoProntoPago"=NULL, */Saldo, "Referencia"=NULL, Estatus='PENDIENTE', Proyecto = NULL, UEN = NULL
  FROM CxpRedondeo p
  JOIN Version v ON 1 = 1
 WHERE ROUND(Saldo, v.RedondeoMonetarios) <> 0.0
GO

/**************** fnCxpInfo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCxpInfo' AND type = 'TF') DROP FUNCTION fnCxpInfo
GO
CREATE FUNCTION fnCxpInfo (@Empresa char(5), @ProveedorD char(10), @ProveedorA char(10))
RETURNS @Resultado TABLE (ID int NULL, Empresa char(5) NULL, Moneda char(10) NULL, TipoCambio float NULL, Proveedor char(10) NULL, Mov varchar(20) NULL, MovID varchar(20) NULL, 
                          FechaEmision datetime NULL, Vencimiento datetime NULL, DiasMoratorios int NULL, Saldo money NULL, Referencia varchar(50), 
                          Estatus varchar(15) NULL, Proyecto varchar(50) NULL, UEN int NULL)
--//WITH ENCRYPTION
AS BEGIN
INSERT @Resultado(ID, Empresa, Moneda, TipoCambio, Proveedor, Mov, MovID, FechaEmision, Vencimiento, DiasMoratorios, Saldo, Referencia, Estatus, Proyecto, UEN)
SELECT p.ID, p.Empresa, p.Moneda, p.TipoCambio, p.Proveedor, p.Mov, p.MovID, p.FechaEmision, p.Vencimiento, p.DiasMoratorios, 
      "Saldo" = CASE WHEN mt.Clave IN ('CXP.A', 'CXP.DA','CXP.NC','CXP.DAC','CXP.NCD','CXP.NCF','CXP.NCP', 'CXP.SD') THEN -p.Saldo ELSE p.Saldo END,
       p.Referencia, p.Estatus, p.Proyecto, p.UEN
  FROM CxpPendiente p
  JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = 'CXP'
  JOIN Version v ON 1 = 1
 WHERE ROUND(p.Saldo, v.RedondeoMonetarios) <> 0.0
   AND p.Empresa = @Empresa AND p.Proveedor BETWEEN @ProveedorD AND @ProveedorA

INSERT @Resultado(Empresa, Moneda, TipoCambio, Proveedor, Mov, Saldo, Estatus)
SELECT p.Empresa, p.Moneda, m.TipoCambio, p.Proveedor, 
       CASE
         WHEN Round(p.Saldo, v.RedondeoMonetarios)<=0 THEN 'Saldo a Favor' 
         ELSE 'Saldo en Contra' END, 
       p.Saldo, 'PENDIENTE'
  FROM CxpEfectivo p
  JOIN Mon m ON m.Moneda = p.Moneda
  JOIN Version v ON 1 = 1
 WHERE ROUND(p.Saldo, v.RedondeoMonetarios) <> 0.0
   AND p.Empresa = @Empresa AND p.Proveedor BETWEEN @ProveedorD AND @ProveedorA

INSERT @Resultado(Empresa, Moneda, TipoCambio, Proveedor, Mov, Saldo, Estatus)
SELECT p.Empresa, p.Moneda, m.TipoCambio, p.Proveedor, 'Redondeo', p.Saldo, 'PENDIENTE'
  FROM CxpRedondeo p
  JOIN Mon m ON m.Moneda = p.Moneda
  JOIN Version v ON 1 = 1
 WHERE ROUND(p.Saldo, v.RedondeoMonetarios) <> 0.0
   AND p.Empresa = @Empresa AND p.Proveedor BETWEEN @ProveedorD AND @ProveedorA

  RETURN 
END
GO

-- select dbo.fnContactoSaldoMN('DEMO', 'Cliente', 'C1')
-- select sum(saldo) from cxcinfo where cliente = 'c1'
/**************** fnContactoSaldoMN ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnContactoSaldoMN') DROP FUNCTION fnContactoSaldoMN
GO
CREATE FUNCTION fnContactoSaldoMN(@Empresa varchar(5), @Tipo varchar(20), @Contacto varchar(20))
RETURNS money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	money

  SELECT @Resultado = NULL
  IF @Tipo = 'Cliente'   SELECT @Resultado = SUM(Saldo*TipoCambio) FROM dbo.fnCxcInfo(@Empresa, @Contacto, @Contacto) ELSE
  IF @Tipo = 'Proveedor' SELECT @Resultado = SUM(Saldo*TipoCambio) FROM dbo.fnCxpInfo(@Empresa, @Contacto, @Contacto)

  RETURN (@Resultado)
END
GO

/***************************************** VISTAS VENTAS *****************************************/

-- select * from verventa
/*** VerVenta ***/
if exists (select * from sysobjects where id = object_id('dbo.VerVenta') and type = 'V') drop view dbo.VerVenta
GO
CREATE VIEW VerVenta
--//WITH ENCRYPTION
AS 
SELECT 
  v.ID,
  v.Empresa,
  v.Mov,
  v.MovID,
  v.Moneda,
  v.FechaEmision,
  v.FechaRequerida,
  v.Proyecto,
  v.UEN,
  v.Concepto,
  v.Estatus,
  v.Cliente,
  v.EnviarA,
  v.Agente,
  v.Importe,
  v.DescuentoGlobal,
  v.SobrePrecio,
  v.Referencia,
  "SubTotal"= CONVERT(money, dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio)),
  v.Impuestos,
  "Total"= CONVERT(money, dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio)) + v.Impuestos,
  v.Saldo,
  "SaldoImpuestos" = CONVERT(money, dbo.fnR3(dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio)+ v.Impuestos, v.Impuestos, v.Saldo)),
  "MovTipo" = mt.Clave,
  v.Sucursal,
  v.SucursalOrigen,
  v.Espacio,
  v.Almacen,
  v.AlmacenDestino,
  v.ServicioSerie,
  v.ServicioPlacas,
  v.ServicioFecha,
  v.ServicioArticulo,
  v.ServicioNumeroEconomico

FROM Venta v
JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS'
GO

/*** VentaPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaPendiente') and type = 'V') drop view dbo.VentaPendiente
GO
CREATE VIEW VentaPendiente
--//WITH ENCRYPTION
AS 
SELECT * 
  FROM VerVenta
 WHERE UPPER(Estatus) IN ('PENDIENTE', 'CONFIRMAR')
GO

/*** VentaEnFirme ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaEnFirme') and type = 'V') drop view dbo.VentaEnFirme
GO
CREATE VIEW VentaEnFirme
--//WITH ENCRYPTION
AS 
SELECT * 
  FROM VerVenta
 WHERE UPPER(Estatus) IN ('PENDIENTE', 'CONCLUIDO')
GO


/*** VerVentaD ***/
if exists (select * from sysobjects where id = object_id('dbo.VerVentaD') and type = 'V') drop view dbo.VerVentaD
GO
CREATE VIEW VerVentaD
--//WITH ENCRYPTION
AS 
SELECT
  Venta.ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  Venta.Empresa,
  Venta.Mov,
  Venta.MovID,
  Venta.Moneda,
  Venta.FechaEmision,
  "FechaRequerida" = ISNULL(VentaD.FechaRequerida, Venta.FechaRequerida),
  "FechaSalida" = DATEADD(day, VentaD.Cantidad-ISNULL(VentaD.CantidadCancelada, 0.0), ISNULL(VentaD.FechaRequerida, Venta.FechaRequerida)),
  HoraRequerida = VentaD.HoraRequerida,
  Venta.Prioridad,
  Venta.Referencia,
  Venta.Proyecto,
  Venta.Concepto,
  Venta.Estatus,
  Venta.Cliente,
  VentaD.EnviarA,
  Venta.DescuentoGlobal,
  Venta.SobrePrecio,
  Venta.ServicioArticulo,
  Venta.ServicioSerie,
  Venta.ServicioFecha,
  Venta.ServicioNumeroEconomico,
  Venta.Sucursal,
  Venta.SucursalOrigen,
  VentaD.Agente,
  VentaD.Almacen,
  VentaD.Articulo,
  VentaD.SubCuenta,
  VentaD.Espacio,
  "Cantidad" = VentaD.Cantidad-ISNULL(VentaD.CantidadCancelada, 0.0), 
  VentaD.CantidadReservada, 
  VentaD.CantidadOrdenada, 
  VentaD.CantidadPendiente, 
  VentaD.Unidad,
  VentaD.Factor,
  "CantidadFactor"  = (VentaD.Cantidad-ISNULL(VentaD.CantidadCancelada, 0.0))/VentaD.Factor, 
  "ReservadaFactor" = VentaD.CantidadReservada*VentaD.Factor,
  "OrdenadaFactor"  = VentaD.CantidadOrdenada*VentaD.Factor,
  "PendienteFactor" = VentaD.CantidadPendiente*VentaD.Factor,
  VentaD.CantidadInventario,
  VentaD.Precio, 
  VentaD.DescuentoTipo,
  VentaD.DescuentoLinea,
  VentaD.Impuesto1,
  VentaD.Impuesto2,
  VentaD.Impuesto3,
  VentaD.Retencion1,
  VentaD.Retencion2,
  VentaD.Retencion3,
  VentaD.DescripcionExtra,
  VentaD.Instruccion,
  VentaD.PoliticaPrecios,
  VentaD.PrecioMoneda,
  VentaD.PrecioTipoCambio,
  VentaD.Paquete,
  VentaD.UEN,
  Cte.Nombre CteNombre,
  Art.Descripcion1 ArtDescripcion,
  Art.SeProduce ArtSeProduce,
  Art.SeCompra ArtSeCompra,
  Art.Espacios,
  Art.EspaciosNivel,
  "MovTipo" = mt.Clave,
  "Semana" = DATEDIFF(week, GETDATE(), ISNULL(VentaD.FechaRequerida, Venta.FechaRequerida))

FROM Venta
JOIN VentaD ON Venta.ID = VentaD.ID
JOIN Cte ON Venta.Cliente = Cte.Cliente
JOIN Art ON VentaD.Articulo = Art.Articulo
JOIN MovTipo mt ON Venta.Mov = mt.Mov AND mt.Modulo = 'VTAS'
GO


/*** VentaPendienteD ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaPendienteD') and type = 'V') drop view dbo.VentaPendienteD
GO
CREATE VIEW VentaPendienteD
--//WITH ENCRYPTION
AS 
SELECT * 
  FROM VerVentaD
 WHERE UPPER(Estatus) IN ('PENDIENTE', 'CONFIRMAR') AND (CantidadReservada > 0.0 OR CantidadOrdenada > 0.0 OR CantidadPendiente > 0.0)
GO

/*** VentaEnFirmeD ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaEnFirmeD') and type = 'V') drop view dbo.VentaEnFirmeD
GO
CREATE VIEW VentaEnFirmeD
--//WITH ENCRYPTION
AS 
SELECT * 
  FROM VerVentaD
 WHERE UPPER(Estatus) IN ('PENDIENTE', 'CONCLUIDO')
GO


/*** InvSolicitudPendienteD ***/
if exists (select * from sysobjects where id = object_id('dbo.InvSolicitudPendienteD') and type = 'V') drop view dbo.InvSolicitudPendienteD
GO
CREATE VIEW InvSolicitudPendienteD
--//WITH ENCRYPTION
AS 
SELECT 
  Inv.ID,
  InvD.Renglon,
  InvD.RenglonSub,
  Inv.Empresa,
  Inv.Mov,
  Inv.MovID,
  Inv.Moneda,
  Inv.FechaEmision,
  "FechaRequerida" = ISNULL(InvD.FechaRequerida, Inv.FechaRequerida),
  Inv.Referencia,
  Inv.Estatus,
  Inv.AlmacenDestino,
  InvD.Almacen,
  InvD.Articulo,
  InvD.SubCuenta,
  "Cantidad" = InvD.Cantidad-ISNULL(InvD.CantidadCancelada, 0.0), 
  InvD.CantidadReservada,
  InvD.CantidadOrdenada, 
  InvD.CantidadPendiente,
  InvD.Unidad,
  InvD.Factor,
  InvD.CantidadInventario,
  InvD.Paquete,
  "CantidadFactor"  = (InvD.Cantidad-ISNULL(InvD.CantidadCancelada, 0.0))*InvD.Factor, 
  "ReservadaFactor" = InvD.CantidadReservada*InvD.Factor,
  "OrdenadaFactor"  = InvD.CantidadOrdenada*InvD.Factor,
  "PendienteFactor" = InvD.CantidadPendiente*InvD.Factor,
  Art.Descripcion1 ArtDescripcion,
  Art.SeProduce ArtSeProduce,
  Art.SeCompra ArtSeCompra,
  Inv.Proyecto,
  Inv.UEN

FROM Inv
JOIN InvD ON Inv.ID = InvD.ID
JOIN Art ON InvD.Articulo = Art.Articulo
JOIN MovTipo mt ON Inv.Mov = mt.Mov AND mt.Modulo = 'INV'
WHERE 
  Inv.Estatus = 'PENDIENTE' AND (InvD.CantidadReservada > 0.0 OR InvD.CantidadOrdenada > 0.0 OR InvD.CantidadPendiente > 0.0) AND
  mt.Clave IN ('INV.SOL', 'INV.OT', 'INV.OI', 'INV.SM')
GO


/*** ProdPendienteD ***/
if exists (select * from sysobjects where id = object_id('dbo.ProdPendienteD') and type = 'V') drop view dbo.ProdPendienteD
GO
CREATE VIEW ProdPendienteD
--//WITH ENCRYPTION
AS 
SELECT 
  Prod.ID,
  ProdD.Renglon,
  ProdD.RenglonSub,
  Prod.Empresa,
  Prod.Mov,
  Prod.MovID,
  Prod.Moneda,
  Prod.FechaEmision,
  ProdD.FechaRequerida,
  Prod.FechaEntrega,
  Prod.Referencia,
  Prod.Estatus,
  Prod.Proyecto,
  Prod.UEN,
  ProdD.Ruta,
  ProdD.Centro,
  ProdD.Almacen,
  ProdD.Articulo,
  ProdD.SubCuenta,
  "Cantidad" = ProdD.Cantidad-ISNULL(ProdD.CantidadCancelada, 0.0), 
  ProdD.CantidadReservada,
  ProdD.CantidadOrdenada, 
  ProdD.CantidadPendiente,
  ProdD.Unidad,
  ProdD.Factor,
  ProdD.CantidadInventario,
  ProdD.Paquete,
  "CantidadFactor"  = (ProdD.Cantidad-ISNULL(ProdD.CantidadCancelada, 0.0))*ProdD.Factor, 
  "ReservadaFactor" = ProdD.CantidadReservada*ProdD.Factor,
  "OrdenadaFactor"  = ProdD.CantidadOrdenada*ProdD.Factor,
  "PendienteFactor" = ProdD.CantidadPendiente*ProdD.Factor,
  Art.Descripcion1 ArtDescripcion,
  Art.SeProduce ArtSeProduce,
  Art.SeCompra ArtSeCompra,
  "MovTipo" = mt.Clave,
  "Semana" = DATEDIFF(week, GETDATE(), ProdD.FechaEntrega),
  ProdD.DestinoTipo,
  ProdD.Destino,
  ProdD.DestinoID

FROM Prod
JOIN ProdD ON Prod.ID = ProdD.ID
JOIN Art ON ProdD.Articulo = Art.Articulo
JOIN MovTipo mt ON Prod.Mov = mt.Mov
WHERE 
  Prod.Estatus = 'PENDIENTE' AND (ProdD.CantidadReservada > 0.0 OR ProdD.CantidadOrdenada > 0.0 OR ProdD.CantidadPendiente > 0.0) AND
  mt.Modulo = 'PROD'  
GO

/*** Reabastecer ***/
if exists (select * from sysobjects where id = object_id('dbo.Reabastecer') and type = 'V') drop view dbo.Reabastecer
GO
CREATE VIEW Reabastecer
--//WITH ENCRYPTION
AS 
SELECT 
  "Modulo" = CONVERT(char(5), 'VTAS'),
  v.ID,
  v.Empresa, 
  v.Sucursal,
  v.Almacen,
  v.Mov, 
  v.MovID,
  v.Concepto,
  v.Referencia,
  v.Proyecto,
  v.UEN,
  v.Usuario,
  v.FechaEmision,
  v.FechaRegistro,
  "MovTipo" = mt.Clave,
  d.Articulo,
  "SubCuenta" = NULLIF(RTRIM(d.SubCuenta), ''),
  d.Unidad,
  d.Cantidad,
  d.CantidadInventario

FROM Venta v
JOIN VentaD d ON v.ID = d.ID
JOIN Art a ON d.Articulo = a.Articulo
JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' 
WHERE
  a.Tipo NOT IN ('SERVICIO', 'JUEGO') AND v.Estatus IN ('CONCLUIDO', 'PROCESAR') AND v.Reabastecido = 0 AND mt.Clave IN ('VTAS.F','VTAS.FAR', 'VTAS.FB', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.FM', 'VTAS.N', 'VTAS.NO', 'VTAS.NR', 'VTAS.VC', 'VTAS.VCR', 'VTAS.EG', 'VTAS.SG') AND ISNULL(v.OrigenTipo, '') <> 'VMOS'
  
UNION
SELECT 
  "Modulo" = CONVERT(char(5), 'INV'),
  i.ID,
  i.Empresa, 
  i.Sucursal,
  i.Almacen,
  i.Mov, 
  i.MovID,
  i.Concepto,
  i.Referencia,
  i.Proyecto,
  i.UEN,
  i.Usuario,
  i.FechaEmision,
  i.FechaRegistro,
  "MovTipo" = mt.Clave,
  d.Articulo,
  "SubCuenta" = NULLIF(RTRIM(d.SubCuenta), ''),
  d.Unidad,
  d.Cantidad,
  d.CantidadInventario

FROM Inv i 
JOIN InvD d ON i.ID = d.ID 
JOIN Art a ON d.Articulo = a.Articulo
JOIN MovTipo mt ON i.Mov = mt.Mov AND mt.Modulo = 'INV'
WHERE
  a.Tipo NOT IN ('SERVICIO', 'JUEGO') AND i.Estatus = 'CONCLUIDO' AND i.Reabastecido = 0 AND mt.Clave IN ('INV.CM', 'INV.S')
GO


/*** DemandaPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.DemandaPendiente') and type = 'V') drop view dbo.DemandaPendiente
GO
CREATE VIEW DemandaPendiente
--//WITH ENCRYPTION
AS 
SELECT 
  "Modulo" = CONVERT(char(5), 'VTAS'),
  ID,
  Renglon,
  RenglonSub,
  Empresa,
  Mov,
  MovID,
  Moneda,
  FechaEmision,
  FechaRequerida,
  Prioridad,
  Referencia,
  Estatus,
  Almacen,
  Articulo,
  SubCuenta,
  Cantidad
  CantidadReservada,
  CantidadOrdenada, 
  CantidadPendiente,
  Unidad,
  Factor,
  CantidadInventario,
  CantidadFactor, 
  ReservadaFactor,
  OrdenadaFactor,
  PendienteFactor,
  ArtDescripcion,
  ArtSeProduce,
  ArtSeCompra,
  Cliente,
  EnviarA,
  Agente,
  Instruccion,
  Paquete

FROM 
  VentaPendienteD

WHERE 
  MovTipo IN ('VTAS.P', 'VTAS.S', 'VTAS.F', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND ISNULL(CantidadPendiente, 0.0) > 0.0

UNION

SELECT 
  "Modulo" = CONVERT(char(5), 'INV'),
  ID,
  Renglon,
  RenglonSub,
  Empresa,
  Mov,
  MovID,
  Moneda,
  FechaEmision,
  FechaRequerida,
  "Prioridad" = CONVERT(char(10), NULL),
  Referencia,
  Estatus,
  Almacen,
  Articulo,
  SubCuenta,
  Cantidad
  CantidadReservada,
  CantidadOrdenada, 
  CantidadPendiente,
  Unidad,
  Factor,
  CantidadInventario,
  CantidadFactor, 
  ReservadaFactor,
  OrdenadaFactor,
  PendienteFactor,
  ArtDescripcion,
  ArtSeProduce,
  ArtSeCompra,
  "Cliente" = AlmacenDestino,
  "EnviarA" = CONVERT(int, NULL),
  "Agente"  = CONVERT(char(10), NULL),
  "Instruccion" = CONVERT(varchar(50), NULL),
  Paquete

FROM 
  InvSolicitudPendienteD

WHERE 
  ISNULL(CantidadPendiente, 0.0) > 0.0
GO


/*** VentaUtil ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaUtil') and type = 'V') drop view dbo.VentaUtil
GO
CREATE VIEW VentaUtil
--//WITH ENCRYPTION
AS 
SELECT
  f.Empresa,
  f.Sucursal,
  f.FechaEmision,
  'VTAS' Modulo,
  f.ID,
  f.Mov,
  f.MovID,
  RTRIM(f.Mov)+' '+RTRIM(Convert(Char,f.MovID)) Movimiento,
  m.Clave MovClave,
  f.Ejercicio,
  f.Periodo,
  f.Cliente,
  d.EnviarA,
  f.Agente,
  f.Proyecto,
  f.UEN,
  f.Moneda,
  f.TipoCambio,
  f.Almacen,
  f.DescuentoGlobal,
  f.SobrePrecio,
  f.Impuestos,
  "Cantidad" = sum(d.Cantidad),
  "Precio" = Convert(money, sum(CONVERT(money, d.Precio*d.Cantidad))/sum(d.Cantidad)),
  "DescuentoTipo" = '%',
  "DescuentoLinea" = CONVERT(money, ROUND(avg(case d.DescuentoTipo when '$' then (d.DescuentoLinea/d.precio)*100 else d.DescuentoLinea end), v.RedondeoMonetarios)),
  "Importe" = SUM(ROUND(Convert(money, d.Cantidad * d.Precio - ISNULL(case d.DescuentoTipo when '$' then d.DescuentoLinea else d.Cantidad*d.Precio*(d.DescuentoLinea/100) end, 0.0)  ), v.RedondeoMonetarios)),
  "CostoTotal" = CASE WHEN m.Clave = 'VTAS.B' THEN NULL ELSE sum(ROUND(Convert(money, d.Cantidad*ISNULL(d.Costo, 0.0)), v.RedondeoMonetarios)) END,
  "ComisionTotal" = Convert(money, sum(d.Comision)) 

FROM Venta f
JOIN VentaD d ON f.ID = d.ID
JOIN MovTipo m ON f.Mov = m.Mov AND m.Modulo = 'VTAS'
JOIN Version v ON 1 = 1
WHERE
  f.Estatus = 'CONCLUIDO' AND
  d.RenglonTipo not in ('E','P') AND
  m.Clave IN ('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.DF', 'VTAS.B') 
GROUP BY
  f.Empresa,
  f.Sucursal,
  f.FechaEmision,
  f.ID,
  f.Mov,
  f.MovID,
  m.Clave,
  f.Ejercicio,
  f.Periodo,
  f.Cliente,
  d.EnviarA,
  f.Agente,
  f.Proyecto,
  f.UEN,
  f.Moneda,
  f.TipoCambio,
  f.Almacen,
  f.DescuentoGlobal,
  f.SobrePrecio,
  f.Impuestos,
  v.RedondeoMonetarios
/*
UNION
  SELECT 
    f.Empresa, 
    f.Sucursal,
    f.FechaEmision, 
    'CXC' Modulo,
    f.ID, 
    f.Mov, 
    f.MovID, 
    RTRIM(f.Mov)+' '+RTRIM(Convert(Char,f.MovID)) Movimiento,
    m.Clave,
    f.Ejercicio, 
    f.Periodo, 
    f.Cliente, 
    f.ClienteEnviarA,
    "Agente"= NULL,
    f.Proyecto, 
    f.UEN,
    f.Moneda, 
    f.TipoCambio, 
    "Almacen" = NULL, 
    "DescuentoGlobal" = NULL, 
    "SobrePrecio" = NULL,
    "Impuestos" = NULL, 
    "Cantidad" = NULL, 
    "Precio" = NULL, 
    "DescuentoTipo" = NULL, 
    "DescuentoLinea" = NULL,
     Importe,
    "CostoTotal" = NULL,
    "ComisionTotal" = NULL

  FROM CXC f,
       MovTipo m

  WHERE
    m.Mov = f.Mov AND f.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND
    m.Clave IN ('CXC.NC','CXC.DAC','CXC.NCD','CXC.NCF','CXC.DV') AND
    (f.OrigenTipo = NULL OR f.OrigenTipo <> 'VTAS')
*/
GO

/*** VentaUtilD ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaUtilD') and type = 'V') drop view dbo.VentaUtilD
GO
CREATE VIEW VentaUtilD
--//WITH ENCRYPTION
AS 
SELECT
  f.ID,
  f.Empresa,
  f.Sucursal,
  f.Mov,
  f.MovID,
  RTRIM(f.Mov)+' '+RTRIM(Convert(Char,f.MovID)) Movimiento,
  m.Clave MovClave,
  f.Ejercicio,
  f.Periodo,
  f.FechaEmision,
  f.Cliente,
  d.EnviarA,
  f.Agente,
  f.Proyecto,
  f.UEN,
  f.Moneda,
  f.TipoCambio,
  f.DescuentoGlobal,
  f.SobrePrecio,
  d.Almacen,
  d.RenglonID,
  --BUG15767
  d.Renglon,
  d.RenglonSub,
  d.Articulo,
  d.Impuesto1,
  d.Impuesto2,
  d.Impuesto3,
  "Cantidad" = sum(d.Cantidad),
  "Precio" = Convert(money, sum(CONVERT(money, d.Precio*d.Cantidad))/sum(d.Cantidad)),
  "DescuentoTipo" = '%',
  "DescuentoLinea" = CONVERT(money, ROUND(avg(case d.DescuentoTipo when '$' then (d.DescuentoLinea/d.precio)*100 else d.DescuentoLinea end), v.RedondeoMonetarios)),
  "Importe2" = sum(CONVERT(money, d.Cantidad*d.Precio)),
  "Importe" = CONVERT(money, sum(ROUND(CONVERT(money, d.Cantidad*d.Precio), v.RedondeoMonetarios)) * (1-avg(case d.DescuentoTipo when '$' then (ISNULL(d.DescuentoLinea, 0.0)/d.precio)*100 else ISNULL(d.DescuentoLinea,0.0) end)/100)),
--  "CostoTotal" = sum(ROUND(Convert(money, d.Cantidad*ISNULL(d.Costo, 0.0)), v.RedondeoMonetarios)),
  "CostoTotal" =sum(ROUND(Convert(money, (CASE WHEN d.RenglonTipo = 'J' AND ISNULL(d.Costo, 0.0) = 0.00 THEN j.CostoJuego ELSE d.Cantidad*ISNULL(d.Costo, 0.0) END)), v.RedondeoMonetarios)),
  "CantidadFactor" = CONVERT(float, sum(d.Cantidad*d.Factor)),
  "Comision" = sum(d.Comision)

FROM Venta f
JOIN VentaD d ON f.ID = d.ID 
JOIN MovTipo m ON f.Mov = m.Mov AND m.Modulo = 'VTAS'
JOIN Version v on 1 = 1
JOIN (SELECT ID,RenglonID,SUM(Cantidad*ISNULL(Costo,0.0)) As CostoJuego FROM VentaD WHERE RenglonTipo <> 'J' GROUP BY ID,RenglonID)j ON j.ID = d.ID AND j.RenglonID = d.RenglonID
WHERE
  f.Estatus = 'CONCLUIDO' AND
  d.RenglonTipo not in ('E','P') AND
  m.Clave IN ('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.DF', 'VTAS.B') 
GROUP BY
  f.ID,
  f.Empresa,
  f.Sucursal,
  f.Mov,
  f.MovID,
  m.Clave,
  f.Ejercicio,
  f.Periodo,
  f.FechaEmision,
  f.Cliente,
  d.EnviarA,
  f.Agente,
  f.Proyecto,
  f.UEN,
  f.Moneda,
  f.TipoCambio,
  f.DescuentoGlobal,
  f.SobrePrecio,
  d.Almacen,
  d.RenglonID,
  --BUG15767
  d.Renglon,
  d.RenglonSub,  
  d.Articulo,
  d.Impuesto1,
  d.Impuesto2,
  d.Impuesto3,
  v.RedondeoMonetarios
GO


/***************************************** VISTAS COMPRAS *****************************************/


/*** CompraPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.CompraPendiente') and type = 'V') drop view dbo.CompraPendiente
GO
CREATE VIEW CompraPendiente
--//WITH ENCRYPTION
AS 
SELECT 
  c.ID,
  c.Empresa,
  c.Mov,
  c.MovID,
  c.Moneda,
  c.FechaEmision,
  c.FechaRequerida,
  c.Referencia,
  c.Estatus,
  c.Proveedor,
  c.Importe,
  c.DescuentoGlobal,
  c.Almacen,
  "SubTotal"= Convert(money, (c.Importe*(100-ISNULL(c.DescuentoGlobal, 0.0))/100)),
  c.Impuestos,
  "Total"= CONVERT(money, (c.Importe*(100-c.DescuentoGlobal)/100) + c.Impuestos),
  c.Saldo,
  mt.Clave,
  c.Proyecto,
  c.UEN

FROM Compra c
JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'COMS'
WHERE 
  c.Estatus='PENDIENTE' 
GO

/*** CompraPendienteD ***/
if exists (select * from sysobjects where id = object_id('dbo.CompraPendienteD') and type = 'V') drop view dbo.CompraPendienteD
GO
CREATE VIEW CompraPendienteD
--//WITH ENCRYPTION
AS 
SELECT 
  Compra.ID,
  Compra.Empresa,
  Compra.Mov,
  Compra.MovID,
  Compra.Moneda,
  Compra.FechaEmision,
  Compra.Referencia,
  Compra.Estatus,
  Compra.Proveedor,
  Compra.DescuentoGlobal,
  Compra.Proyecto,
  Compra.UEN,
  Compra.Prioridad,
  Compra.Agente,
  Compra.Situacion,
  CompraD.Renglon,
  CompraD.RenglonSub,
  CompraD.Articulo,
  CompraD.SubCuenta,
  "Cantidad" = CompraD.Cantidad-ISNULL(CompraD.CantidadCancelada, 0.0),
  "CantidadPendiente" = ISNULL(CompraD.CantidadPendiente, 0.0),
  CompraD.Costo,
  CompraD.DescuentoTipo,
  CompraD.DescuentoLinea,
  CompraD.Impuesto1,
  CompraD.Impuesto2,
  CompraD.Impuesto3,
  CompraD.Retencion1,
  CompraD.Retencion2,
  CompraD.Retencion3,
  CompraD.FechaRequerida,
  CompraD.FechaEntrega,
  CompraD.DescripcionExtra,
  CompraD.Almacen,
  CompraD.DestinoTipo,
  CompraD.Destino,
  CompraD.DestinoID,
  CompraD.Unidad,
  CompraD.Factor,
  "CantidadFactor"  = (CompraD.Cantidad-ISNULL(CompraD.CantidadCancelada, 0.0))*CompraD.Factor, 
  "PendienteFactor" = ISNULL(CompraD.CantidadPendiente, 0.0)*CompraD.Factor,
  CompraD.CantidadInventario,
  CompraD.Paquete,
  CompraD.Cliente,
  Prov.Nombre ProvNombre,
  Prov.Categoria ProvCat,
  Prov.Familia ProvFam,
  Art.Descripcion1 ArtDescripcion,
  "MovTipo" = mt.Clave,
  "Semana" = DATEDIFF(week, GETDATE(), CompraD.FechaEntrega),
  CompraD.ContUso,
  CompraD.ContUso2,
  CompraD.ContUso3,
  "Modulo" = mt.Modulo

FROM
  Compra
  JOIN CompraD ON Compra.ID = CompraD.ID AND CompraD.CantidadPendiente > 0.0 AND UPPER(Compra.Estatus)='PENDIENTE'
  LEFT OUTER JOIN Prov ON Compra.Proveedor = Prov.Proveedor 
  JOIN Art ON CompraD.Articulo = Art.Articulo
  JOIN MovTipo mt ON Compra.Mov = mt.Mov AND mt.Modulo = 'COMS'
GO


/*** CompraConfirmarD ***/
if exists (select * from sysobjects where id = object_id('dbo.CompraConfirmarD') and type = 'V') drop view dbo.CompraConfirmarD
GO
CREATE VIEW CompraConfirmarD
--//WITH ENCRYPTION
AS 
SELECT 
  Compra.ID,
  Compra.Empresa,
  Compra.Mov,
  Compra.MovID,
  Compra.Moneda,
  Compra.FechaEmision,
  Compra.Referencia,
  Compra.Estatus,
  Compra.Proveedor,
  Compra.DescuentoGlobal,
  Compra.Proyecto,
  Compra.UEN,
  Compra.Prioridad,
  Compra.Agente,
  Compra.situacion,
  CompraD.Renglon,
  CompraD.RenglonSub,
  CompraD.Articulo,
  CompraD.SubCuenta,
  "Cantidad" = CompraD.Cantidad-ISNULL(CompraD.CantidadCancelada, 0.0),
  "CantidadPendiente" = ISNULL(CompraD.CantidadPendiente, 0.0),
  CompraD.Costo,
  CompraD.DescuentoTipo,
  CompraD.DescuentoLinea,
  CompraD.Impuesto1,
  CompraD.Impuesto2,
  CompraD.Impuesto3,
  CompraD.Retencion1,
  CompraD.Retencion2,
  CompraD.Retencion3,
  CompraD.FechaRequerida,
  CompraD.FechaEntrega,
  CompraD.DescripcionExtra,
  CompraD.Almacen,
  CompraD.DestinoTipo,
  CompraD.Destino,
  CompraD.DestinoID,
  CompraD.Unidad,
  CompraD.Factor,
  "CantidadFactor"  = (CompraD.Cantidad-ISNULL(CompraD.CantidadCancelada, 0.0))*CompraD.Factor, 
  "PendienteFactor" = ISNULL(CompraD.CantidadPendiente, 0.0)*CompraD.Factor,
  CompraD.CantidadInventario,
  CompraD.Paquete,
  CompraD.Cliente,
  Prov.Nombre ProvNombre,
  Prov.Categoria ProvCat,
  Prov.Familia ProvFam,
  Art.Descripcion1 ArtDescripcion,
  "MovTipo" = mt.Clave,
  "Semana" = DATEDIFF(week, GETDATE(), CompraD.FechaEntrega),
  CompraD.ContUso,
  CompraD.ContUso2,
  CompraD.ContUso3,
  "Modulo" = mt.Modulo

FROM
  Compra
  JOIN CompraD ON Compra.ID = CompraD.ID /*AND CompraD.CantidadPendiente > 0.0 */AND Compra.Estatus='CONFIRMAR'
  LEFT OUTER JOIN Prov ON Compra.Proveedor = Prov.Proveedor 
  JOIN Art ON CompraD.Articulo = Art.Articulo
  JOIN MovTipo mt ON Compra.Mov = mt.Mov AND mt.Modulo = 'COMS'
GO


/*** OfertaPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.OfertaPendiente') and type = 'V') drop view dbo.OfertaPendiente
GO
CREATE VIEW OfertaPendiente
--//WITH ENCRYPTION
AS 
SELECT 
  "Modulo" = CONVERT(char(5), 'COMS'),
  ID,
  Renglon,
  RenglonSub,
  Empresa,
  Mov,
  MovID,
  Moneda,
  FechaEmision,
  FechaRequerida,
  Prioridad,
  Referencia,
  Estatus,
  Almacen,
  Articulo,
  SubCuenta,
  Cantidad
  CantidadPendiente,
  Unidad,
  Factor,
  CantidadInventario,
  CantidadFactor, 
  PendienteFactor,
  ArtDescripcion,
  Proveedor,
  Agente,
  Paquete

FROM 
  CompraPendienteD

WHERE 
  MovTipo IN ('COMS.R', 'COMS.O', 'COMS.OP', 'COMS.OG', 'COMS.OI') AND ISNULL(CantidadPendiente, 0.0) > 0.0
GO



/***************************************** VISTAS DINERO *****************************************/

/*** DineroSaldo ***/
if exists (select * from sysobjects where id = object_id('dbo.DineroSaldo') and type = 'V') drop view dbo.DineroSaldo
GO
CREATE VIEW DineroSaldo
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa, 
  s.Moneda,
  s.Cuenta CtaDinero,
  Convert(money, Sum(s.Saldo*r.Factor)) Saldo,
  Convert(money, Sum(s.PorConciliar*r.Factor)) PorConciliar,
  Convert(money, Sum(ISNULL(s.Saldo, 0.0)-ISNULL(s.PorConciliar, 0.0)*r.Factor)) SaldoConciliado

FROM Saldo s
JOIN Rama r ON s.Rama=r.Rama and r.Mayor='DIN' 
GROUP BY 
  s.Empresa, s.Moneda, s.Cuenta
go

/*** DineroSaldoSucursal ***/
if exists (select * from sysobjects where id = object_id('dbo.DineroSaldoSucursal') and type = 'V') drop view dbo.DineroSaldoSucursal
GO
CREATE VIEW DineroSaldoSucursal
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa, 
  s.Sucursal,
  s.Moneda,
  s.Cuenta CtaDinero,
  Convert(money, Sum(s.Saldo*r.Factor)) Saldo,
  Convert(money, Sum(s.PorConciliar*r.Factor)) PorConciliar,
  Convert(money, Sum(ISNULL(s.Saldo, 0.0)-ISNULL(s.PorConciliar, 0.0)*r.Factor)) SaldoConciliado

FROM Saldo s
JOIN Rama r ON s.Rama=r.Rama and r.Mayor='DIN' 
GROUP BY 
  s.Empresa, s.Sucursal, s.Moneda, s.Cuenta
go


/*** CtaDineroConSaldo ***/
if exists (select * from sysobjects where id = object_id('dbo.CtaDineroConSaldo') and type = 'V') drop view dbo.CtaDineroConSaldo
GO
CREATE VIEW CtaDineroConSaldo
--//WITH ENCRYPTION
AS 
SELECT 
  c.CtaDinero,
  c.Descripcion,
  "CuentaMoneda" = c.Moneda,
  c.Tipo,
  c.BancoSucursal,
  c.NumeroCta,
  c.CuentaHabiente,
  c.Estatus,
  c.UltimoCambio,
  c.Alta,
  c.Conciliar,
  c.Mensaje,
  c.UltimoCorte,
  c.Beneficiario,
  c.Institucion,
  c.Uso,
  c.TieneMovimientos,
  "SucursalCuenta" = c.Sucursal,
  s.Empresa,
  s.Moneda, 
  s.Saldo, 
  s.PorConciliar,
  s.SaldoConciliado,
  c.Categoria,
  c.Grupo,
  c.Familia,
  c.NivelAcceso

 FROM CtaDinero c
 LEFT OUTER JOIN DineroSaldo s ON c.CtaDinero = s.CtaDinero
go


/*** CtaDineroConSaldoSucursal ***/
if exists (select * from sysobjects where id = object_id('dbo.CtaDineroConSaldoSucursal') and type = 'V') drop view dbo.CtaDineroConSaldoSucursal
GO
CREATE VIEW CtaDineroConSaldoSucursal
--//WITH ENCRYPTION
AS 
SELECT 
  c.CtaDinero,
  c.Descripcion,
  "CuentaMoneda" = c.Moneda,
  c.Tipo,
  c.BancoSucursal,
  c.NumeroCta,
  c.CuentaHabiente,
  c.Estatus,
  c.UltimoCambio,
  c.Alta,
  c.Conciliar,
  c.Mensaje,
  c.UltimoCorte,
  c.Beneficiario,
  c.Institucion,
  c.Uso,
  c.TieneMovimientos,
  s.Empresa,
  s.Sucursal,
  s.Moneda, 
  s.Saldo, 
  s.PorConciliar,
  s.SaldoConciliado,
  c.Categoria,
  c.Grupo,
  c.Familia,
  c.NivelAcceso

 FROM CtaDinero c
 LEFT OUTER JOIN DineroSaldoSucursal s ON c.CtaDinero = s.CtaDinero
go

/*** DineroPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.DineroPendiente') and type = 'V') drop view dbo.DineroPendiente
GO
CREATE VIEW DineroPendiente
--//WITH ENCRYPTION
AS 
SELECT 
  b.ID,
  b.Empresa,
  b.Mov,
  b.MovID,
  b.Moneda,
  b.Referencia,
  b.CtaDinero,
  b.Importe,
  b.Saldo,
  b.FechaEmision,
  b.FechaProgramada,
  b.Estatus,
  b.Sucursal,
  b.FormaPago,
  "Dias"  = datediff(day, b.FechaProgramada, GETDATE()),
  mt.Clave MovTipo

FROM Dinero b
JOIN MovTipo mt ON b.Mov = mt.Mov AND mt.Modulo = 'DIN'
WHERE b.Estatus = 'PENDIENTE' 
GO

/*** DineroPosfechado ***/
if exists (select * from sysobjects where id = object_id('dbo.DineroPosfechado') and type = 'V') drop view dbo.DineroPosfechado
GO
CREATE VIEW DineroPosfechado
--//WITH ENCRYPTION
AS 
SELECT 
  b.ID,
  b.Empresa,
  b.Mov,
  b.MovID,
  b.Moneda,
  b.Referencia,
  b.CtaDinero,
  b.Beneficiario,
  b.BeneficiarioNombre,
  b.Importe,
  b.FechaEmision,
  b.FechaProgramada,
  b.Estatus,
  "Dias"  = datediff(day, GETDATE(), b.FechaProgramada),
  "MovTipo" = mt.Clave,
  "Cargo" = CASE WHEN mt.Clave IN ('DIN.I', 'DIN.SD', 'DIN.D',  'DIN.DE')   THEN b.Importe ELSE CONVERT(money, NULL) END,
  "Abono" = CASE WHEN mt.Clave IN ('DIN.E', 'DIN.SCH', 'DIN.CH', 'DIN.CHE') THEN b.Importe ELSE CONVERT(money, NULL) END

FROM Dinero b
JOIN MovTipo mt ON b.Mov = mt.Mov AND mt.Modulo = 'DIN' 
WHERE 
  b.Estatus = 'POSFECHADO' 
GO


/*** InvFlujo ***/
if exists (select * from sysobjects where id = object_id('dbo.InvFlujo') and type = 'V') drop view dbo.InvFlujo
GO
CREATE VIEW InvFlujo
--//WITH ENCRYPTION
AS 
SELECT p.Articulo, "Modulo" = 'VTAS', p.SubCuenta, "PorRecibir" = NULL, "PorSurtir" = p.CantidadPendiente, "Disponible" = NULL, p.DescripcionExtra, p.ID, p.Empresa, p.Mov, p.MovID, p.Almacen, p.FechaEmision, p.FechaRequerida, "FechaEntrega" = NULL, "Cuenta" = c.Cliente, c.Nombre
  FROM VentaPendienteD p
  JOIN Cte c ON p.Cliente = c.Cliente
 WHERE p.Estatus = 'PENDIENTE'
   AND ISNULL(p.CantidadPendiente, 0) > 0
UNION
SELECT p.Articulo, "Modulo" = 'INV', p.SubCuenta, "PorRecibir" = NULL, "PorSurtir" = p.CantidadPendiente, "Disponible" = NULL, "DescripcionExtra" = NULL, p.ID, p.Empresa, p.Mov, p.MovID, p.Almacen, p.FechaEmision, "FechaRequerida" = NULL, "FechaEntrega" = NULL, "Cuenta" = NULL, "Nombre" = NULL
  FROM InvSolicitudPendienteD p
 WHERE p.Estatus = 'PENDIENTE'
   AND ISNULL(p.CantidadPendiente, 0) > 0
UNION
SELECT p.Articulo, "Modulo" = 'COMS', p.SubCuenta, "PorRecibir" = p.CantidadPendiente, "PorSurtir" = NULL, "Disponible" = NULL, p.DescripcionExtra, p.ID, p.Empresa, p.Mov, p.MovID, p.Almacen, p.FechaEmision, p.FechaRequerida, p.FechaEntrega, "Cuenta"= Prov.Proveedor, Prov.Nombre
  FROM CompraPendienteD p
  JOIN Prov ON p.Proveedor = Prov.Proveedor
 WHERE NULLIF(RTRIM(p.DestinoID), '') IS NULL
   AND ISNULL(p.CantidadPendiente, 0) > 0
UNION
SELECT d.Articulo, "Modulo" = NULL, d.SubCuenta, "PorRecibir" = NULL, "PorSurtir" = NULL, "Disponible" = d.Disponible, "DescripcionExtra" = NULL, "ID" = NULL, d.Empresa, "Mov" = NULL, "MovID" = NULL, d.Almacen, GETDATE(), "FechaRequerida"=NULL, "FechaEntrega" = NULL, "Cuenta"= NULL, "Nombre" = NULL
  FROM ArtSubDisponible d
  JOIN Version v ON 1 = 1
 WHERE d.Almacen IS NOT NULL AND ISNULL(d.Disponible, 0) > 0 
GO

-- select * from InvFlujo

/***************************************** VISTAS CONTABILIDAD *****************************************/

/*** ContDR ***/
if exists (select * from sysobjects where id = object_id('dbo.ContDR') and type = 'V') drop view dbo.ContDR
GO
CREATE VIEW ContDR
--//WITH ENCRYPTION
AS 
SELECT
  ID,
  Cuenta,
  "Debe"  = SUM(Debe),
  "Haber" = SUM(Haber) 

FROM
  ContD
WHERE
  Presupuesto = 0

GROUP BY
  ID, Cuenta
GO


-- select * from ctasaldo
/*** CtaSaldo ***/
if exists (select * from sysobjects where id = object_id('dbo.CtaSaldo') and type = 'V') drop view dbo.CtaSaldo
GO
CREATE VIEW CtaSaldo
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa, 
  Moneda, 
  Cuenta,
  'Saldo' = SUM(Saldo),
  'PorConciliar' = SUM(PorConciliar),
  'SaldoConciliado' = SUM(ISNULL(Saldo, 0.0)-ISNULL(PorConciliar, 0.0))

FROM 
  Saldo 

WHERE 
  Rama = 'CONT'

GROUP BY
  Empresa, Moneda, Cuenta
GO

/*** VerMovTiempo ***/
if exists (select * from sysobjects where id = object_id('dbo.VerMovTiempo') and type = 'V') drop view dbo.VerMovTiempo
GO
CREATE VIEW VerMovTiempo
--//WITH ENCRYPTION
AS 
SELECT 
  Modulo,
  ID,
  FechaInicio,
  FechaComenzo,
  FechaTermino,
  Usuario,
  Estatus,
  Situacion,
  Ahora = GETDATE()

FROM 
  MovTiempo
GO

/*** VerCtaTiempo ***/
if exists (select * from sysobjects where id = object_id('dbo.VerCtaTiempo') and type = 'V') drop view dbo.VerCtaTiempo
GO
CREATE VIEW VerCtaTiempo
--//WITH ENCRYPTION
AS 
SELECT 
  Rama,
  Cuenta,
  FechaInicio,
  FechaComenzo,
  FechaTermino,
  Usuario,
  Estatus,
  Situacion,
  Ahora = GETDATE()

FROM 
  CtaTiempo
GO



/*** GastoPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.GastoPendiente') and type = 'V') drop view dbo.GastoPendiente
GO
CREATE VIEW GastoPendiente
--//WITH ENCRYPTION
AS 
SELECT * FROM Gasto WHERE Estatus = 'PENDIENTE'
GO


-- select Impuesto1Excento from gastot
/*** GastoT ***/
if exists (select * from sysobjects where id = object_id('dbo.GastoT') and type = 'V') drop view dbo.GastoT
GO
CREATE VIEW GastoT
--//WITH ENCRYPTION
AS 
SELECT
  g.ID,
  g.Empresa,
  g.Mov,
  g.MovID,
  g.FechaEmision,
  g.UltimoCambio,
  d.Proyecto,
  d.UEN,
  g.Acreedor,
  g.Moneda,
  g.TipoCambio,
  g.Usuario,
  g.Autorizacion,
  g.DocFuente,
  g.Observaciones,
  g.Clase,
  g.SubClase,
  g.Estatus,
  g.Situacion,
  g.SituacionFecha,
  g.SituacionUsuario,
  g.SituacionNota,
  g.Periodicidad,
  g.TieneRetencion,
  g.Condicion,
  g.Vencimiento,
  g.FormaPago,
  g.CtaDinero,
  g.Importe,
  g.Retencion,
  g.Impuestos,
  g.Saldo,
  g.Anticipo,
  g.MovAplica,
  g.MovAplicaID,
  g.Multiple,
  g.OrigenTipo,
  g.Origen,
  g.OrigenID,
  g.Poliza,
  g.PolizaID,
  g.GenerarPoliza,
  g.ContID,
  g.Ejercicio,
  g.Periodo,
  g.FechaRegistro,
  g.FechaConclusion,
  g.FechaCancelacion,
  g.FechaRequerida,
  g.CXP,
  g.GenerarDinero,
  g.Dinero,
  g.DineroID,
  g.DineroCtaDinero,
  g.DineroConciliado,
  g.DineroFechaConciliacion,
  g.Sucursal,
  g.EstaImpreso,
  g.ConVigencia,
  g.VigenciaDesde,
  g.VigenciaHasta,
  g.Prioridad,

  d.Renglon,
  d.RenglonSub,
  d.Concepto,
  'ConceptoClase' = g.Clase,
  'ConceptoSubClase' = g.SubClase,
  d.Fecha,
  d.Referencia,
  d.Cantidad,
  d.Precio,
  "Retencion1" = d.Retencion,
  "Retencion2" = d.Retencion2,
  "Retencion3" = d.Retencion3,
  d.ContUso,
  d.ContUso2,
  d.ContUso3,
  d.ClavePresupuestal,
  d.Espacio,
  d.VIN,
  d.Actividad,
  d.DescripcionExtra,
  "ImporteLinea"    = CASE WHEN mt.Clave = 'GAS.G' AND mt.SubClave = 'GAS.GE/GT' THEN ISNULL(d.Importe, 0.0)-ISNULL(d.Retencion3, 0.0) ELSE ISNULL(d.Importe, 0.0) END,
  d.Provision,
  "ImpuestosLinea"  = ISNULL(d.Impuestos, 0.0) + CASE WHEN v.Impuesto2Info = 1 THEN 0.0 ELSE ISNULL(d.Impuestos2, 0.0) END + CASE WHEN v.Impuesto3Info = 1 THEN 0.0 ELSE ISNULL(d.Impuestos3, 0.0) END + ISNULL(d.Impuestos5, 0.0),
  "RetencionLinea"  = ISNULL(d.Retencion, 0.0) + ISNULL(d.Retencion2, 0.0),
  "TotalLinea"      = ISNULL(d.Importe, 0.0) - ISNULL(d.Retencion, 0.0) - ISNULL(d.Retencion2, 0.0) - ISNULL(d.Retencion3, 0.0) + ISNULL(d.Impuestos, 0.0) + CASE WHEN v.Impuesto2Info = 1 THEN 0.0 ELSE ISNULL(d.Impuestos2, 0.0) END + CASE WHEN v.Impuesto3Info = 1 THEN 0.0 ELSE ISNULL(d.Impuestos3, 0.0) END + ISNULL(d.Impuestos5, 0.0),
  "EsDeducible"     = c.EsDeducible,
  "PorcentajeDeducible" = d.PorcentajeDeducible,
  "Tipo"            = c.Tipo,
  d.AcreedorRef,
  d.EndosarA,
  "AFArticulo" = ISNULL(d.AFArticulo, g.AFArticulo),
  "AFSerie" = ISNULL(d.AFSerie, g.AFSerie),
  g.ClienteRef,
  g.ArticuloRef,
  d.Lectura,
  d.LecturaAnterior,
  d.Personal,
  d.DepartamentoDetallista,
  d.PresupuestoEsp,
  c.Impuesto1Excento,
  c.Excento2,
  c.Excento3,
  d.TipoImpuesto1,
  d.TipoImpuesto2,
  d.TipoImpuesto3,
  d.TipoImpuesto5,
  d.TipoRetencion1,
  d.TipoRetencion2,
  d.TipoRetencion3,
  d.Impuesto1,
  d.Impuesto2,
  d.Impuesto3,
  d.Impuesto5
  /*,
  d.Recurso, 
  d.Riesgo*/

 FROM Gasto g JOIN MovTipo mt
   ON g.Mov = mt.Mov AND mt.Modulo = 'GAS'
 JOIN Version v ON 1=1
 LEFT OUTER JOIN GastoD d ON g.ID = d.ID
 LEFT OUTER JOIN Concepto c ON c.Modulo = 'GAS' AND c.Concepto = d.Concepto
GO
-- select SUM(ImporteLinea)+SUM(ImpuestosLinea) FROM GastoT

/*** GastoAcum ***/
if exists (select * from sysobjects where id = object_id('dbo.GastoAcum') and type = 'V') drop view dbo.GastoAcum
GO
CREATE VIEW GastoAcum
--//WITH ENCRYPTION
AS 
SELECT
  g.Empresa,
  g.Moneda,
  g.Clase,
  g.SubClase,
  g.Ejercicio,
  g.Periodo,
  d.Concepto,
  "Cantidad"     = SUM(d.Cantidad) * mt.Factor,
  "Retencion1"    = SUM(d.Retencion) * mt.Factor,
  "Retencion2"    = SUM(d.Retencion2) * mt.Factor,
  "Retencion3"    = SUM(d.Retencion3) * mt.Factor,
  "Importe"      = SUM(d.Importe) * mt.Factor,
  "Impuestos"    = SUM(d.Impuestos) * mt.Factor,
  "Retenciones"  = (SUM(ISNULL(d.Retencion, 0.0) + ISNULL(d.Retencion2, 0.0) + ISNULL(d.Retencion3, 0.0))) * mt.Factor,
  "ImporteTotal" = (SUM(ISNULL(d.Importe, 0.0) - ISNULL(d.Retencion, 0.0) - ISNULL(d.Retencion2, 0.0) - ISNULL(d.Retencion3, 0.0) + ISNULL(d.Impuestos, 0.0))) * mt.Factor
 
FROM Gasto g
JOIN GastoD d ON g.ID=d.ID
JOIN MovTipo mt ON g.Mov = mt.Mov AND mt.Modulo = 'GAS'
WHERE
   mt.Clave IN ('GAS.G', 'GAS.GTC', 'GAS.C', 'GAS.CCH', 'GAS.EST', 'GAS.CI', 'GAS.CB'/*, 'GAS.GP'*/) AND g.Estatus='CONCLUIDO'
GROUP BY
  g.Empresa, g.Moneda, d.Concepto, g.Clase, g.SubClase, g.Ejercicio, g.Periodo, mt.Factor
GO
 

/****************************** Agentes *******************************/


/*** AgentSaldo ***/
if exists (select * from sysobjects where id = object_id('dbo.AgentSaldo') and type = 'V') drop view dbo.AgentSaldo
GO
CREATE VIEW AgentSaldo
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa,
  s.Moneda,
  s.Cuenta Agente,
  Sum(s.Saldo) Saldo

FROM 
  Saldo s

WHERE 
  s.Rama='AGENT' 

GROUP BY 
  s.Empresa, s.Moneda, s.Cuenta
GO

/*** AgentPendientes ***/
if exists (select * from sysobjects where id = object_id('dbo.AgentPendiente') and type = 'V') drop view dbo.AgentPendiente
GO
CREATE VIEW AgentPendiente
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  Mov, 
  MovID, 
  Agente,
  Moneda,
  FechaEmision, 
  Importe,
  Saldo,
  Referencia,
  Estatus

FROM 
  Agent

WHERE 
  UPPER(Estatus)='PENDIENTE' 
GO

/*** AgentUnico ***/
if exists (select * from sysobjects where id = object_id('dbo.AgentUnico') and type = 'V') drop view dbo.AgentUnico
GO
CREATE VIEW AgentUnico
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  Mov, 
  MovID, 
  Agente,
  Moneda,
  FechaEmision, 
  Importe,
  Saldo,
  Referencia,
  Observaciones,
  Estatus

FROM 
  Agent

WHERE 
  UPPER(Estatus) NOT IN ('SINAFECTAR' , 'CANCELADO')
GO

/*** SerieLotePropiedades ***/
if exists (select * from sysobjects where id = object_id('dbo.SerieLotePropiedades') and type = 'V') drop view dbo.SerieLotePropiedades
GO
CREATE VIEW SerieLotePropiedades
--//WITH ENCRYPTION
AS 
SELECT 
  Empresa,
  Articulo,
  SubCuenta,
  SerieLote,
  "Propiedades" = MAX(Propiedades)
FROM 
  SerieLote

GROUP BY Empresa, Articulo, SubCuenta, SerieLote
GO


/*** PendienteSurtirD ***/
if exists (select * from sysobjects where id = object_id('dbo.PendienteSurtirD') and type = 'V') drop view dbo.PendienteSurtirD
GO
CREATE VIEW PendienteSurtirD
--//WITH ENCRYPTION
AS 
SELECT 
  mt.Modulo,
  Venta.ID,
  Venta.Empresa,
  Venta.Mov,
  Venta.MovID,
  Venta.Moneda,
  Venta.FechaEmision,
  Venta.Referencia,
  Venta.Estatus,
  VentaD.Almacen,
  VentaD.Articulo,
  VentaD.SubCuenta,
  "CantidadNeta" = (VentaD.Cantidad-ISNULL(VentaD.CantidadCancelada, 0)), 
  VentaD.CantidadReservada,
  VentaD.CantidadOrdenada, 
  VentaD.CantidadPendiente,
  VentaD.Unidad,
  VentaD.Factor,
  VentaD.FechaRequerida

FROM Venta
JOIN VentaD ON Venta.ID = VentaD.ID
JOIN MovTipo mt ON Venta.Mov = mt.Mov AND mt.Modulo = 'VTAS'
WHERE 
   Venta.Estatus = 'PENDIENTE' AND (VentaD.CantidadReservada > 0.0 OR VentaD.CantidadOrdenada > 0.0 OR VentaD.CantidadPendiente > 0.0) AND
   mt.Clave = 'VTAS.P'

UNION

SELECT 
  mt.Modulo,
  Inv.ID,
  Inv.Empresa,
  Inv.Mov,
  Inv.MovID,
  Inv.Moneda,
  Inv.FechaEmision,
  Inv.Referencia,
  Inv.Estatus,
  InvD.Almacen,
  InvD.Articulo,
  InvD.SubCuenta,
  "CantidadNeta" = (InvD.Cantidad-ISNULL(InvD.CantidadCancelada, 0)), 
  InvD.CantidadReservada,
  InvD.CantidadOrdenada, 
  InvD.CantidadPendiente,
  InvD.Unidad,
  InvD.Factor,
  "FechaRequerida" = convert(datetime, NULL)

FROM Inv
JOIN InvD ON Inv.ID = InvD.ID
JOIN MovTipo mt ON Inv.Mov = mt.Mov AND mt.Modulo = 'INV'

WHERE 
  Inv.Estatus = 'PENDIENTE' AND (InvD.CantidadReservada > 0.0 OR InvD.CantidadOrdenada > 0.0 OR InvD.CantidadPendiente > 0.0) AND
  mt.Clave IN ('INV.SOL', 'INV.OT', 'INV.OI', 'INV.SM')
GO

/****************************** Auxiliares *******************************/

/*** DineroAux ***/
if exists (select * from sysobjects where id = object_id('dbo.DineroAux') and type = 'V') drop view dbo.DineroAux
GO
CREATE VIEW DineroAux
--//WITH ENCRYPTION
AS 
SELECT c.CtaDinero, 
       a.* 
  FROM CtaDinero c
  LEFT OUTER JOIN Auxiliar a ON c.CtaDinero = a.Cuenta AND a.Rama = 'DIN' 
GO

/*** CxcAux ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcAux') and type = 'V') drop view dbo.CxcAux
GO
CREATE VIEW CxcAux
--//WITH ENCRYPTION
AS 
SELECT c.Cliente, 
       a.* 
  FROM Cte c
  LEFT OUTER JOIN Auxiliar a ON c.Cliente = a.Cuenta AND a.Rama IN ('CXC', 'CEFE', 'CVALE', 'CNO')
GO

/*** CxpAuxFecha ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpAuxFecha') and type = 'V') drop view dbo.CxpAuxFecha
GO
CREATE VIEW CxpAuxFecha
--//WITH ENCRYPTION
AS 
SELECT a.Empresa, m.Moneda, a.Ejercicio, a.Periodo, a.Fecha, "Cargos" = SUM(a.Cargo), "Abonos" = SUM(a.Abono)
  FROM Auxiliar a
  LEFT OUTER JOIN Mon m ON m.Moneda = a.Moneda
 WHERE a.Rama IN ('CXP', 'PEFE') 
 GROUP BY a.Empresa, m.Moneda, a.Ejercicio, a.Periodo, a.Fecha
GO


/*** CxcAuxFecha ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcAuxFecha') and type = 'V') drop view dbo.CxcAuxFecha
GO
CREATE VIEW CxcAuxFecha
--//WITH ENCRYPTION
AS 
SELECT a.Empresa, m.Moneda, a.Ejercicio, a.Periodo, a.Fecha, "Cargos" = SUM(a.Cargo), "Abonos" = SUM(a.Abono)
  FROM Auxiliar a
  LEFT OUTER JOIN Mon m ON m.Moneda = a.Moneda
 WHERE a.Rama IN ('CXC', 'CEFE', 'CNO', 'CVALE')
 GROUP BY a.Empresa, m.Moneda, a.Ejercicio, a.Periodo, a.Fecha
GO

/*** CxpAux ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpAux') and type = 'V') drop view dbo.CxpAux
GO
CREATE VIEW CxpAux
--//WITH ENCRYPTION
AS 
SELECT c.Proveedor, 
       a.* 
  FROM Prov c
  LEFT OUTER JOIN Auxiliar a ON c.Proveedor = a.Cuenta AND a.Rama IN ('CXP', 'PEFE')
GO

/*** AgentAux ***/
if exists (select * from sysobjects where id = object_id('dbo.AgentAux') and type = 'V') drop view dbo.AgentAux
GO
CREATE VIEW AgentAux
--//WITH ENCRYPTION
AS 
SELECT c.Agente, 
       a.* 
  FROM Agente c
  LEFT OUTER JOIN Auxiliar a ON c.Agente = a.Cuenta AND a.Rama = 'AGENT' 
GO

/*** InvAux ***/
if exists (select * from sysobjects where id = object_id('dbo.InvAux') and type = 'V') drop view dbo.InvAux
GO
CREATE VIEW InvAux
--//WITH ENCRYPTION
AS 
SELECT c.Articulo, 
       a.* 
  FROM Art c
  LEFT OUTER JOIN AuxiliarU a ON c.Articulo = a.Cuenta AND a.Rama = 'INV' AND (Cargo IS NOT NULL OR Abono IS NOT NULL)
GO

/*** InvAuxU ***/
if exists (select * from sysobjects where id = object_id('dbo.InvAuxU') and type = 'V') drop view dbo.InvAuxU
GO
CREATE VIEW InvAuxU
--//WITH ENCRYPTION
AS 
SELECT c.Articulo, 
       a.* 
  FROM Art c
  LEFT OUTER JOIN AuxiliarU a ON c.Articulo = a.Cuenta AND (CargoU IS NOT NULL OR AbonoU IS NOT NULL)
GO

/*** ContAux ***/
if exists (select * from sysobjects where id = object_id('dbo.ContAux') and type = 'V') drop view dbo.ContAux
GO
CREATE VIEW ContAux
--//WITH ENCRYPTION
AS 
SELECT c.Cuenta,
       d.ID,
       d.Renglon,
       d.RenglonSub,
       d.SubCuenta,
       d.Concepto,
       d.Debe,
       d.Haber,
       d.Empresa,
       d.Ejercicio,
       d.Periodo,
       d.FechaContable,
       d.Articulo,
       d.DepartamentoDetallista,
       d.SucursalContable,
       d.Presupuesto,
       "Movimiento" = CONVERT(varchar(41), RTRIM(e.Mov)+' '+RTRIM(e.MovID)),
       e.Referencia,
       e.Estatus,
       e.UEN,
       e.Proyecto,
       e.Contacto,
       e.ContactoTipo,
       e.Mov,
       e.MovID
  FROM Cta c
  LEFT OUTER JOIN ContD d ON d.Cuenta = c.Cuenta
  LEFT JOIN Cont e ON e.ID = d.ID
GO


/*** NominaInfo ***/
if exists (select * from sysobjects where id = object_id('dbo.NominaInfo') and type = 'V') drop view dbo.NominaInfo
GO
CREATE VIEW NominaInfo
--//WITH ENCRYPTION
AS 
SELECT e.ID, e.Empresa, e.Mov, e.MovID, e.FechaEmision, e.Concepto, e.Condicion, e.Estatus, e.Situacion, e.SituacionFecha, e.SituacionUsuario, e.SituacionNota, d.Renglon, d.Personal, d.Cantidad, d.Importe, d.CantidadPendiente, d.Monto, d.Porcentaje, d.FechaD, d.FechaA, d.Saldo, 'ConceptoDetalle'=d.Concepto, d.Referencia
  FROM Nomina e
  JOIN NominaD d ON e.ID=d.ID
 WHERE e.Estatus in ('VIGENTE', 'PROCESAR', 'PENDIENTE') and d.Activo=1
GO

/*** VentaAux ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaAux') and type = 'V') drop view dbo.VentaAux
GO
CREATE VIEW VentaAux
--//WITH ENCRYPTION
AS 
SELECT Art.Articulo,
       Cte.Cliente,      
       a.* 
  FROM Art
  JOIN AuxiliarRU a ON Art.Articulo = a.Cuenta AND a.Rama = 'VTAS'
  JOIN Cte ON a.Grupo = Cte.Cliente
GO

/*** CompraAux ***/
if exists (select * from sysobjects where id = object_id('dbo.CompraAux') and type = 'V') drop view dbo.CompraAux
GO
CREATE VIEW CompraAux
--//WITH ENCRYPTION
AS 
SELECT Art.Articulo,
       Prov.Proveedor,
       a.* 
  FROM Art
  JOIN AuxiliarRU a ON Art.Articulo = a.Cuenta AND a.Rama = 'COMS'
  JOIN Prov ON a.Grupo = Prov.Proveedor
GO


/*** VentaPendienteAsignada ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaPendienteAsignada') and type = 'V') drop view dbo.VentaPendienteAsignada
GO
CREATE VIEW VentaPendienteAsignada
--//WITH ENCRYPTION
AS 
SELECT v.Empresa, v.Cliente, vd.Articulo, 
       "CantidadPendiente" = sum(vd.cantidadPendiente),
       "CantidadAsignada" = (SELECT SUM(od.CantidadPendiente) FROM Compra o JOIN CompraD od ON o.ID = od.ID JOIN MovTipo omt ON o.Mov = omt.Mov AND OMT.Modulo = 'COMS' WHERE omt.Clave IN ('COMS.O', 'COMS.OG', 'COMS.OI') AND o.Estatus = 'PENDIENTE' AND od.Articulo = vd.Articulo AND od.Cliente = v.Cliente)
  FROM Venta v
  JOIN VentaD vd ON v.ID = vd.ID
  JOIN MovTipo mt ON v.Mov = mt.Mov AND MT.Modulo = 'VTAS'
 WHERE mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX') AND v.Estatus = 'PENDIENTE'
 GROUP BY v.Empresa, v.Cliente, vd.Articulo
GO

/*** ProdSerieLotePendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.ProdSerieLotePendiente') and type = 'V') drop view dbo.ProdSerieLotePendiente
GO
CREATE VIEW ProdSerieLotePendiente
--//WITH ENCRYPTION
AS 
SELECT
  e.ID,
  e.Empresa,
  e.Mov,
  e.MovID,
  d.ProdSerieLote,
  d.Articulo,
  d.SubCuenta,
  d.Ruta,
  d.Orden,
  d.Centro,
  d.Unidad,
  "Factor" = AVG(d.Factor),
  "CantidadPendiente" = SUM(d.CantidadPendiente)

FROM Prod e
JOIN ProdD d ON e.ID = d.ID
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'PROD'
WHERE 
  mt.Clave = 'PROD.O' AND e.Estatus = 'PENDIENTE' 
GROUP BY
  e.ID, e.Empresa, e.Mov, e.MovID, d.ProdSerieLote, d.Articulo, d.SubCuenta, d.Ruta, d.Orden, d.Centro, d.Unidad
GO
-- select * from ProdSerieLotePendiente where prodserielote = '789' and empresa = 'sam'


/*** ProdSerieLoteCostoAcum ***/
if exists (select * from sysobjects where id = object_id('dbo.ProdSerieLoteCostoAcum') and type = 'V') drop view dbo.ProdSerieLoteCostoAcum
GO
CREATE VIEW ProdSerieLoteCostoAcum
--//WITH ENCRYPTION
AS 
SELECT
  c.Empresa,
  c.ProdSerieLote,
  c.Articulo,
  c.SubCuenta,
  c.Moneda,
  "Saldo" = SUM(ISNULL(c.Cargo, 0.0)-ISNULL(c.Abono, 0.0)),
  "CantidadPendiente" = (SELECT ISNULL(l.CantidadOrdenada, 0) - ISNULL(CantidadCancelada, 0) - ISNULL(l.CantidadEntrada, 0) - ISNULL(l.CantidadMerma ,0) - ISNULL(l.CantidadDesperdicio, 0) FROM ProdSerieLote l WHERE c.Empresa = l.Empresa AND c.ProdSerieLote = l.ProdSerieLote AND c.Articulo = l.Articulo AND c.SubCuenta = l.SubCuenta),
  "CostoUnitario" = CONVERT(money, SUM(ISNULL(c.Cargo, 0.0)-ISNULL(c.Abono, 0.0)) / NULLIF((SELECT ISNULL(l.CantidadOrdenada, 0) - ISNULL(CantidadCancelada, 0) - ISNULL(l.CantidadEntrada, 0) - ISNULL(l.CantidadMerma ,0) - ISNULL(l.CantidadDesperdicio, 0) FROM ProdSerieLote l WHERE c.Empresa = l.Empresa AND c.ProdSerieLote = l.ProdSerieLote AND c.Articulo = l.Articulo AND c.SubCuenta = l.SubCuenta), 0.0))

FROM 
  ProdSerieLoteCosto c
GROUP BY
  c.Empresa, c.ProdSerieLote, c.Articulo, c.SubCuenta, c.Moneda
GO

/*** ProdSerieLoteCostoAgrupado ***/
--if exists (select * from sysobjects where id = object_id('dbo.ProdSerieLoteCostoAgrupado') and type = 'V') drop view dbo.ProdSerieLoteCostoAgrupado
GO
/*CREATE VIEW ProdSerieLoteCostoAgrupado
--//WITH ENCRYPTION
AS 
SELECT Empresa, ProdSerieLote, Articulo, SubCuenta, Modulo, ModuloID, Moneda, Concepto, "Cargo"= SUM(Cargo), "Abono" = SUM(Abono)
  FROM ProdSerieLoteCosto
 GROUP BY Empresa, ProdSerieLote, Articulo, SubCuenta, Modulo, ModuloID, Moneda, Concepto
HAVING ISNULL(SUM(Cargo), 0.0) <> 0.0 OR ISNULL(SUM(Abono), 0.0) <> 0.0*/
GO

/*** ProdSerieLoteMaterialPendiente ***/
--if exists (select * from sysobjects where id = object_id('dbo.ProdSerieLoteMaterialPendiente') and type = 'V') drop view dbo.ProdSerieLoteMaterialPendiente
GO
/*CREATE VIEW ProdSerieLoteMaterialPendiente
--//WITH ENCRYPTION
AS 
SELECT
  sl.Empresa, sl.ProdSerieLote, pe.Articulo, pe.SubCuenta, "Cantidad" = SUM(pe.Cantidad), pe.Unidad, "Factor" = AVG(pe.Factor)
FROM 
  ProdSerieLotePendiente sl,
  ProdExp pe
WHERE
  pe.Empresa = sl.Empresa AND pe.ProdSerieLote = sl.ProdSerieLote
GROUP BY
  sl.Empresa, sl.ProdSerieLote, pe.Articulo, pe.SubCuenta, pe.Unidad
*/
GO


/*** VentaSurtirColor ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaSurtirColor') and type = 'V') drop view dbo.VentaSurtirColor
GO
CREATE VIEW VentaSurtirColor
--//WITH ENCRYPTION
AS 
SELECT DISTINCT 
  v.Empresa,
  v.ID,
  v.Mov,
  v.MovID,
  d.Almacen, 
  d.Articulo, 
  "Color" = SUBSTRING(d.SubCuenta, 1, CHARINDEX('/', d.SubCuenta)-1), 
  "Talla" = SUBSTRING(d.SubCuenta, CHARINDEX('/', d.SubCuenta)+1, 20), 
  d.FechaRequerida,
  d.Renglon,
  d.RenglonSub,
  v.Cliente,
  d.EnviarA,
  "Cantidad" = SUM(Cantidad)-ISNULL(SUM(CantidadCancelada), 0.0),
  "CantidadOrdenada"  = SUM(CantidadOrdenada),
  "CantidadReservada" = SUM(CantidadReservada),
  "CantidadPendiente" = SUM(CantidadPendiente)
FROM VentaD d
JOIN Venta v ON v.ID = d.ID
JOIN MovTipo mt ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS'
WHERE 
  v.Estatus = 'PENDIENTE' AND mt.Clave IN ('VTAS.P', 'VTAS.S', 'VTAS.F', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX')
GROUP BY
  v.Empresa, v.ID, v.Mov, v.MovID, d.Almacen, d.Articulo, SUBSTRING(d.SubCuenta, 1, CHARINDEX('/', d.SubCuenta)-1), SUBSTRING(d.SubCuenta, CHARINDEX('/', d.SubCuenta)+1, 20), d.FechaRequerida, d.Renglon, d.RenglonSub, v.Cliente, d.EnviarA
GO

/*** ArtVentaPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtVentaPendiente') and type = 'V') drop view dbo.ArtVentaPendiente
GO
CREATE VIEW ArtVentaPendiente
--//WITH ENCRYPTION
AS 
SELECT Empresa, Cliente, EnviarA, Almacen, Articulo, "CantidadOrdenada" = SUM(CantidadOrdenada), "CantidadReservada" = SUM(CantidadReservada), "CantidadPendiente" = SUM(CantidadPendiente)
  FROM VentaPendienteD 
 GROUP BY Empresa, Cliente, EnviarA, Almacen, Articulo
GO


/*** ArtSubVentaPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtSubVentaPendiente') and type = 'V') drop view dbo.ArtSubVentaPendiente
GO
CREATE VIEW ArtSubVentaPendiente
--//WITH ENCRYPTION
AS 
SELECT Empresa, Cliente, EnviarA, Almacen, Articulo, SubCuenta, "CantidadOrdenada" = SUM(CantidadOrdenada), "CantidadReservada" = SUM(CantidadReservada), "CantidadPendiente" = SUM(CantidadPendiente)
  FROM VentaPendienteD 
 GROUP BY Empresa, Cliente, EnviarA, Almacen, Articulo, SubCuenta
GO

/*** ListaPreciosEsp ***/
if exists (select * from sysobjects where id = object_id('dbo.ListaPreciosEsp') and type = 'V') drop view dbo.ListaPreciosEsp
GO
CREATE VIEW ListaPreciosEsp
--//WITH ENCRYPTION
AS 
SELECT Lista, NivelAcceso, Orden FROM ListaPreciosBase WHERE Lista NOT IN (SELECT Lista FROM ListaPrecios)
UNION
SELECT Lista, NivelAcceso, "Orden" = CASE WHEN SUBSTRING(Lista, 1, 1) ='(' THEN 10 ELSE 30 END FROM ListaPrecios
GO

/*** PrecioTodos ***/
if exists (select * from sysobjects where id = object_id('dbo.PrecioTodos') and type = 'V') drop view dbo.PrecioTodos
GO
CREATE VIEW PrecioTodos
--//WITH ENCRYPTION
AS 
-- Enrique Toral 16-Jun-2006 Filtro Precio Minimo para que lo despliegue el UNION
SELECT Lista, NivelAcceso, Orden FROM ListaPreciosEsp WHERE Lista <> "(Precio Minimo)"
UNION
SELECT "(Precio Minimo)", NULL, 20
GO

/*** PrecioModificar ***/
if exists (select * from sysobjects where id = object_id('dbo.PrecioModificar') and type = 'V') drop view dbo.PrecioModificar
GO
CREATE VIEW PrecioModificar
--//WITH ENCRYPTION
AS 
SELECT "Lista" = CONVERT(char(20), "(Precio Lista)"), "Orden" = CONVERT(int, 10)
UNION
SELECT "(Precio 2)", 11
UNION
SELECT "(Precio 3)", 12
UNION
SELECT "(Precio 4)", 13
UNION
SELECT "(Precio 5)", 14
UNION
SELECT "(Precio 6)", 15
UNION
SELECT "(Precio 7)", 16
UNION
SELECT "(Precio 8)", 17
UNION
SELECT "(Precio 9)", 18
UNION
SELECT "(Precio 10)", 19
UNION
SELECT "(Precio Minimo)", 20
GO

-- select * from PrecioBase order by orden
/*** PrecioBase ***/
if exists (select * from sysobjects where id = object_id('dbo.PrecioBase') and type = 'V') drop view dbo.PrecioBase
GO
CREATE VIEW PrecioBase
--//WITH ENCRYPTION
AS 
SELECT 'Lista' = CONVERT(varchar(20), "(n/a)"), 'Orden' = convert(int, 1)
UNION
SELECT "(Ultimo Costo)", 2
UNION
SELECT "(Costo Promedio)", 3
UNION
SELECT "(Costo Estandar)", 4
UNION
SELECT "(Costo Reposicion)", 5
UNION
SELECT "(Costo Proveedor)", 6
UNION
SELECT "(Ultimo Costo Prov)", 7
UNION
SELECT "(Precio Actual)", 8
UNION
SELECT Lista, Orden FROM PrecioModificar
GO

/*** CostoModificar ***/
if exists (select * from sysobjects where id = object_id('dbo.CostoModificar') and type = 'V') drop view dbo.CostoModificar
GO
CREATE VIEW CostoModificar
--//WITH ENCRYPTION
AS 
SELECT "Lista" = CONVERT(varchar(20), "(Costo Estandar)"), "Orden" = CONVERT(int, 1)
UNION
SELECT "(Costo Reposicion)", 4
UNION
SELECT "(Ultimo Costo)", 5
UNION
SELECT "(Costo Proveedor)", 6
UNION
SELECT "(Ultimo Costo Prov)", 7
GO


/*** PrecioCostoTodos ***/
if exists (select * from sysobjects where id = object_id('dbo.PrecioCostoTodos') and type = 'V') drop view dbo.PrecioCostoTodos
GO
CREATE VIEW PrecioCostoTodos
--//WITH ENCRYPTION
AS 
SELECT Lista, Orden FROM PrecioTodos 
UNION
SELECT Lista, Orden FROM CostoModificar 
GO



/*** NomXAcum ***/
if exists (select * from sysobjects where id = object_id('dbo.NomXAcum') and type = 'V') drop view dbo.NomXAcum
GO
CREATE VIEW NomXAcum
--//WITH ENCRYPTION
AS 
SELECT ID, "Acumulador" = '['+Formula+']', Orden, Comentarios
  FROM NomXFormula
 WHERE Tipo = 'Acumulador'
GO

--spListaPreciosEsp 5
-- select * from ListaPreciosEsp order by orden


/*** SucursalPrefijoLista ***/
if exists (select * from sysobjects where id = object_id('dbo.SucursalPrefijoLista') and type = 'V') drop view dbo.SucursalPrefijoLista
GO
CREATE VIEW SucursalPrefijoLista
--//WITH ENCRYPTION
AS 
SELECT "Sucursal" = CASE 
		      WHEN NULLIF(RTRIM(Nombre), '') IS NULL THEN CONVERT(char, Sucursal) 
                      WHEN UPPER(SUBSTRING(Nombre, 1, 9)) = 'SUCURSAL ' THEN RTRIM(CONVERT(char, Sucursal))+' - '+RTRIM(SUBSTRING(Nombre, 10, LEN(Nombre)))
                      ELSE RTRIM(CONVERT(char, Sucursal))+' - '+RTRIM(Nombre) END
  FROM Sucursal
GO

/*** UENPrefijoLista ***/
if exists (select * from sysobjects where id = object_id('dbo.UENPrefijoLista') and type = 'V') drop view dbo.UENPrefijoLista
GO
CREATE VIEW UENPrefijoLista
--//WITH ENCRYPTION
AS 
SELECT "UEN" = CASE 
		      WHEN NULLIF(RTRIM(Nombre), '') IS NULL THEN CONVERT(char, UEN) 
                      WHEN UPPER(SUBSTRING(Nombre, 1, 9)) = 'UEN ' THEN RTRIM(CONVERT(char, UEN))+' - '+RTRIM(SUBSTRING(Nombre, 10, LEN(Nombre)))
                      ELSE RTRIM(CONVERT(char, UEN))+' - '+RTRIM(Nombre) END
  FROM UEN
 WHERE Estatus <> 'BAJA'
GO

/*** VerPC ***/
if exists (select * from sysobjects where id = object_id('dbo.VerPC') and type = 'V') drop view dbo.VerPC
GO
CREATE VIEW VerPC
--//WITH ENCRYPTION
AS 
SELECT e.ID, e.Empresa, e.Mov, e.MovID, e.FechaEmision, e.Moneda, e.Estatus, e.ListaModificar, e.FechaInicio, e.FechaTermino,  d.Renglon, d.Articulo, d.Anterior, d.Nuevo, 
       "Diferencia" = CONVERT(money, d.Nuevo-d.Anterior), 
       "Porcentaje" = CONVERT(float, ((d.Nuevo/d.Anterior)-1)*100), 
       "EstatusPrecio" = CONVERT(char(15), CASE WHEN d.Nuevo > d.Anterior THEN 'SUBIO' WHEN d.Nuevo < d.Anterior THEN 'BAJO' ELSE 'SINCAMBIO' END)
  FROM PC e
  JOIN PCD d ON e.ID = d.ID
GO

/*** ComparativoPrecios ***/
if exists (select * from sysobjects where id = object_id('dbo.ComparativoPrecios') and type = 'V') drop view dbo.ComparativoPrecios
GO
CREATE VIEW ComparativoPrecios
--//WITH ENCRYPTION
AS 
SELECT Orden = convert(int, 20), d.Lista, d.Moneda, d.Articulo, d.Precio, "Zona" = NULLIF(RTRIM(l.Zona), '') 
  FROM ListaPreciosD d, ListaPrecios l 
 WHERE d.Lista = l.Lista AND ISNULL(d.Precio, 0.0) > 0.0 AND l.Lista NOT LIKE '(Precio %'
UNION
SELECT Orden = 1, '(Precio Lista)', MonedaPrecio, Articulo, PrecioLista, "1"  FROM Art WHERE ISNULL(PrecioLista, 0.0) > 0.0
UNION
SELECT Orden = 2, '(Precio 2)',     MonedaPrecio, Articulo, Precio2, "2"      FROM Art WHERE ISNULL(Precio2, 0.0) > 0.0
UNION
SELECT Orden = 3, '(Precio 3)',     MonedaPrecio, Articulo, Precio3, "3"      FROM Art WHERE ISNULL(Precio3, 0.0) > 0.0
UNION
SELECT Orden = 4, '(Precio 4)',     MonedaPrecio, Articulo, Precio4, "4"      FROM Art WHERE ISNULL(Precio4, 0.0) > 0.0
UNION
SELECT Orden = 5, '(Precio 5)',     MonedaPrecio, Articulo, Precio5, "5"      FROM Art WHERE ISNULL(Precio5, 0.0) > 0.0
UNION
SELECT Orden = 6, '(Precio 6)',     MonedaPrecio, Articulo, Precio6, "6"      FROM Art WHERE ISNULL(Precio6, 0.0) > 0.0
UNION
SELECT Orden = 7, '(Precio 7)',     MonedaPrecio, Articulo, Precio7, "7"      FROM Art WHERE ISNULL(Precio7, 0.0) > 0.0
UNION
SELECT Orden = 8, '(Precio 8)',     MonedaPrecio, Articulo, Precio8, "8"      FROM Art WHERE ISNULL(Precio8, 0.0) > 0.0
UNION
SELECT Orden = 9, '(Precio 9)',     MonedaPrecio, Articulo, Precio9, "9"      FROM Art WHERE ISNULL(Precio9, 0.0) > 0.0
UNION
SELECT Orden = 10, '(Precio 10)',    MonedaPrecio, Articulo, Precio10, "10"   FROM Art WHERE ISNULL(Precio10, 0.0) > 0.0
UNION
SELECT Orden = 11, '(Precio Minimo)',MonedaPrecio, Articulo, PrecioMinimo, "0" FROM Art WHERE ISNULL(PrecioMinimo, 0.0) > 0.0
GO

-- SELECT * FROM ComparativoPrecios where articulo = 'a1' ORDER BY Orden

/*** EmbarqueArt ***/
if exists (select * from sysobjects where id = object_id('dbo.EmbarqueArt') and type = 'V') drop view dbo.EmbarqueArt
GO
CREATE VIEW EmbarqueArt
--//WITH ENCRYPTION
AS 
SELECT me.Empresa, e.Sucursal, "EmbarqueID" = e.AsignadoID, e.Zona, e.Modulo, e.ModuloID, e.Mov, e.MovID, me.OrigenTipo, me.Origen, me.OrigenID, m.Articulo, m.SubCuenta, m.Cantidad, m.Unidad, m.Factor, ee.Tipo, "Costo" = CASE WHEN a.Tipo = 'SERVICIO' THEN m.Precio ELSE m.Costo END
  FROM EmbarqueMov e, Embarque em, EmbarqueD d, EmbarqueEstado ee, VentaD m, Venta me, Art a
 WHERE e.Modulo = 'VTAS' AND e.ModuloID = m.ID AND e.ID = d.EmbarqueMov AND ee.Estado = d.Estado AND m.ID = me.ID AND d.ID = em.ID AND em.Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') AND m.Articulo = a.Articulo
UNION
SELECT me.Empresa, e.Sucursal, "EmbarqueID" = e.AsignadoID, e.Zona, e.Modulo, e.ModuloID, e.Mov, e.MovID, me.OrigenTipo, me.Origen, me.OrigenID, m.Articulo, m.SubCuenta, m.Cantidad, m.Unidad, m.Factor, ee.Tipo, m.Costo
  FROM EmbarqueMov e, Embarque em, EmbarqueD d, EmbarqueEstado ee, InvD m, Inv me
 WHERE e.Modulo = 'INV' AND e.ModuloID = m.ID AND e.ID = d.EmbarqueMov AND ee.Estado = d.Estado AND m.ID = me.ID AND d.ID = em.ID AND em.Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
UNION
SELECT me.Empresa, e.Sucursal, "EmbarqueID" = e.AsignadoID, e.Zona, e.Modulo, e.ModuloID, e.Mov, e.MovID, me.OrigenTipo, me.Origen, me.OrigenID, m.Articulo, m.SubCuenta, m.Cantidad, m.Unidad, m.Factor, ee.Tipo, m.Costo
  FROM EmbarqueMov e, Embarque em, EmbarqueD d, EmbarqueEstado ee, CompraD m, Compra me
 WHERE e.Modulo = 'COMS' AND e.ModuloID = m.ID AND e.ID = d.EmbarqueMov AND ee.Estado = d.Estado AND m.ID = me.ID AND d.ID = em.ID AND em.Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
UNION
SELECT me.Empresa, e.Sucursal, "EmbarqueID" = e.AsignadoID, e.Zona, e.Modulo, e.ModuloID, e.Mov, e.MovID, me.OrigenTipo, me.Origen, me.OrigenID, m.Articulo, m.SubCuenta, m.Cantidad, m.Unidad, m.Factor, ee.Tipo, m.Costo
  FROM EmbarqueMov e, Embarque em, EmbarqueD d, EmbarqueEstado ee, ProdD m, Prod me
 WHERE e.Modulo = 'PROD' AND e.ModuloID = m.ID AND e.ID = d.EmbarqueMov AND ee.Estado = d.Estado AND m.ID = me.ID AND d.ID = em.ID AND em.Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO')
GO

/*** EmbarqueSucursalOrigen ***/
if exists (select * from sysobjects where id = object_id('dbo.EmbarqueSucursalOrigen') and type = 'V') drop view dbo.EmbarqueSucursalOrigen
GO
CREATE VIEW EmbarqueSucursalOrigen
--//WITH ENCRYPTION
AS 
SELECT "SucursalOrigen" = 
          CASE OrigenTipo 
            WHEN 'VTAS' THEN (SELECT SucursalOrigen FROM Venta m  WHERE m.Empresa = e.Empresa AND m.Mov = e.Origen AND m.MovID = e.OrigenID AND m.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')) 
            WHEN 'INV'  THEN (SELECT SucursalOrigen FROM Inv m    WHERE m.Empresa = e.Empresa AND m.Mov = e.Origen AND m.MovID = e.OrigenID AND m.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')) 
            WHEN 'COMS' THEN (SELECT SucursalOrigen FROM Compra m WHERE m.Empresa = e.Empresa AND m.Mov = e.Origen AND m.MovID = e.OrigenID AND m.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')) 
            WHEN 'PROD' THEN (SELECT SucursalOrigen FROM Prod m   WHERE m.Empresa = e.Empresa AND m.Mov = e.Origen AND m.MovID = e.OrigenID AND m.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')) 
            ELSE e.Sucursal 
          END,
        e.Empresa, 
        e.Sucursal,
        e.EmbarqueID,
        e.Zona,
        e.Modulo,
        e.ModuloID,
        e.Mov,
        e.MovID,
        e.OrigenTipo,
        e.Origen,
        e.OrigenID,
        e.Articulo,
	e.SubCuenta,
	e.Cantidad,
	e.Unidad,
	e.Factor,
	e.Tipo,
	e.Costo
  FROM EmbarqueArt e
GO

/*** AnticipoPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.AnticipoPendiente') and type = 'V') drop view dbo.AnticipoPendiente
GO
CREATE VIEW AnticipoPendiente
--//WITH ENCRYPTION
AS 
SELECT Empresa, Rama, Moneda, Cuenta, Referencia, "Saldo" = ISNULL(SUM(Cargo), 0)-ISNULL(SUM(Abono), 0), "Fecha" = MAX(Fecha)
  FROM Anticipo
 WHERE Cancelado = 0
 GROUP BY Empresa, Rama, Moneda, Cuenta, Referencia
 HAVING ISNULL(SUM(Cargo), 0)-ISNULL(SUM(Abono), 0) <> 0.0
GO

/*** PlanArtUnique ***/
if exists (select * from sysobjects where id = object_id('dbo.PlanArtUnique') and type = 'V') drop view dbo.PlanArtUnique
GO
CREATE VIEW PlanArtUnique
--//WITH ENCRYPTION
AS 
SELECT DISTINCT Empresa ,Articulo, Subcuenta, Almacen FROM PlanArt
GO

/*** AlmDistribucion ***/
if exists (select * from sysobjects where id = object_id('dbo.AlmDistribucion') and type = 'V') drop view dbo.AlmDistribucion
GO
CREATE VIEW AlmDistribucion
--//WITH ENCRYPTION
AS 
SELECT DISTINCT "Almacen" = AlmacenDestino 
  FROM RutaDistribucion r
  JOIN RutaDistribucionD d ON r.Ruta = d.Ruta
GO


/*** PersonalVacaciones ***/
if exists (select * from sysobjects where id = object_id('dbo.PersonalVacaciones') and type = 'V') drop view dbo.PersonalVacaciones
GO
CREATE VIEW PersonalVacaciones
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa Empresa,
  s.Cuenta Personal,
  Sum(s.SaldoU) Vacaciones

FROM 
  SaldoU s

WHERE 
  s.Rama='VAC'

GROUP BY 
  s.Empresa, s.Cuenta
GO

/*** IVAFiscal ***/
if exists (select * from sysobjects where id = object_id('dbo.IVAFiscal') and type = 'V') drop view dbo.IVAFiscal
GO
CREATE VIEW IVAFiscal
--//WITH ENCRYPTION
AS 
SELECT
  "Modulo" = CONVERT(char(5), 'VTAS'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  e.Referencia,
  "Contacto" = e.Cliente,
  cte.Nombre,
  cte.RFC,
  cte.CURP,
  "AplicaFecha" = e.FechaEmision,
  "Aplica" = e.Mov,
  "AplicaID" = e.MovID,
  "AplicaImporte" = vc.TotalCobrado,
  "FechaEmision" = e.FechaEmision,
  "IVAFiscalFactor" = e.IVAFiscal,
  "IVAFiscalImporte" = vc.TotalCobrado * e.IVAFiscal,
  "Factor" = 1,
  "Dinero" = CONVERT(char(20), NULL),
  "DineroID" = CONVERT(varchar(20), NULL),
  "DineroCtaDinero" = CONVERT(char(10), NULL),
  "Conciliado" = CONVERT(bit, 1),
  "FechaConciliacion" = e.FechaEmision

FROM Venta e
JOIN VentaCobro vc ON e.ID = vc.ID
JOIN Cte ON e.Cliente =cte.Cliente
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'VTAS'
WHERE
  mt.Clave IN ('VTAS.N', 'VTAS.FM', 'VTAS.NO', 'VTAS.NR', 'VTAS.F', 'VTAS.S', 'VTAS.P', 'VTAS.VP', 'VTAS.SD', 'VTAS.B') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
  AND vc.TotalCobrado <> 0

UNION

SELECT
  "Modulo" = CONVERT(char(5), 'CXC'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  e.Referencia,
  "Contacto" = e.Cliente,
  cte.Nombre,
  cte.RFC,
  cte.CURP,
  "AplicaFecha" = e.FechaEmision,
  d.Aplica,
  d.AplicaID,
  "AplicaImporte" = d.Importe,
  "FechaEmision" = a.FechaEmision,
  "IVAFiscalFactor" = a.IVAFiscal,
  "IVAFiscalImporte" = CONVERT(money, d.Importe * a.IVAFiscal),
  "Factor" = CASE mt.Clave WHEN 'CXC.DC' THEN -1 ELSE 1 END,
  e.Dinero,
  e.DineroID,
  e.DineroCtaDinero,
  "Conciliado" = e.DineroConciliado,
  "FechaConciliacion" = DineroFechaConciliacion

FROM Cxc e
JOIN Cte ON e.Cliente = cte.Cliente
JOIN CxcD d ON e.ID = d.ID
JOIN CxcAplica a ON d.Aplica=a.Mov AND d.AplicaID=a.MovID AND e.Empresa=a.Empresa
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'CXC'
WHERE
  mt.Clave IN ('CXC.C', 'CXC.DC', 'CXC.ANC') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') -- BUG 16506

UNION

SELECT
  "Modulo" = CONVERT(char(5), 'CXC'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  e.Referencia,
  "Contacto" = e.Cliente,
  cte.Nombre,
  cte.RFC,
  cte.CURP,
  "AplicaFecha" = e.FechaEmision,
  "Aplica" = e.Mov,
  "AplicaID" = e.MovID,
  "AplicaImporte" = ISNULL(e.Importe, 0)+ISNULL(e.Impuestos, 0),
  "FechaEmision" = e.FechaEmision,
  "IVAFiscalFactor" = e.IVAFiscal,
  "IVAFiscalImporte" = CONVERT(money, (ISNULL(e.Importe, 0)+ISNULL(e.Impuestos, 0)) * e.IVAFiscal),
  "Factor" = 1,
  e.Dinero,
  e.DineroID,
  e.DineroCtaDinero,
  "Conciliado" = e.DineroConciliado,
  "FechaConciliacion" = DineroFechaConciliacion 

FROM Cxc e
JOIN Cte ON e.Cliente = cte.Cliente
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'CXC'
WHERE
  mt.Clave IN ('CXC.A', 'CXC.AA') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

UNION

SELECT
  "Modulo" = CONVERT(char(5), 'CXP'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  e.Referencia,
  "Contacto" = e.Proveedor,
  prov.Nombre,
  prov.RFC,
  prov.CURP,
  "AplicaFecha" = e.FechaEmision,
  d.Aplica,
  d.AplicaID,
  "AplicaImporte" = d.Importe,
  "FechaEmision" = a.FechaEmision,
  "IVAFiscalFactor" = a.IVAFiscal,
  "IVAFiscalImporte" = CONVERT(money, d.Importe * a.IVAFiscal),
  "Factor" = CASE mt.Clave WHEN 'CXP.DC' THEN 1 ELSE -1 END,
  e.Dinero,
  e.DineroID,
  e.DineroCtaDinero,
  "Conciliado" = e.DineroConciliado,
  "FechaConciliacion" = DineroFechaConciliacion

FROM Cxp e
JOIN Prov ON e.Proveedor = Prov.Proveedor
JOIN CxpD d ON e.ID = d.ID 
JOIN CxpAplica a ON d.Aplica=a.Mov AND d.AplicaID=a.MovID AND e.Empresa=a.Empresa
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'CXP'
WHERE
  mt.Clave IN ('CXP.P', 'CXP.DC', 'CXP.ANC') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') -- BUG 16506

UNION

SELECT
  "Modulo" = CONVERT(char(5), 'CXP'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  e.Referencia,
  "Contacto" = e.Proveedor,
  prov.Nombre,
  prov.RFC,
  prov.CURP,
  "AplicaFecha" = e.FechaEmision,
  "Aplica" = e.Mov,
  "AplicaID" = e.MovID,
  "AplicaImporte" = ISNULL(e.Importe, 0)+ISNULL(e.Impuestos, 0),
  "FechaEmision" = e.FechaEmision,
  "IVAFiscalFactor" = e.IVAFiscal,
  "IVAFiscalImporte" = CONVERT(money, (ISNULL(e.Importe, 0)+ISNULL(e.Impuestos, 0)) * e.IVAFiscal),
  "Factor" = -1,
  e.Dinero,
  e.DineroID,
  e.DineroCtaDinero,
  "Conciliado" = e.DineroConciliado,
  "FechaConciliacion" = DineroFechaConciliacion 

FROM Cxp e
JOIN Prov ON e.Proveedor = prov.Proveedor
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'CXP'
WHERE
  mt.Clave IN ('CXP.A', 'CXP.AA') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

UNION

SELECT
  "Modulo" = CONVERT(char(5), 'GAS'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  'Referencia' = CONVERT(varchar(50), NULL),
  "Contacto" = e.Acreedor,
  prov.Nombre,
  prov.RFC,
  prov.CURP,
  "AplicaFecha" = e.FechaEmision,
  "Aplica" = e.Mov,
  "AplicaID" = e.MovID,
  "AplicaImporte" = ISNULL(e.Importe, 0)+ISNULL(e.Impuestos, 0),
  "FechaEmision" = e.FechaEmision,
  "IVAFiscalFactor" = CONVERT(float, NULLIF(Impuestos, 0)) / NULLIF(Importe + Impuestos, 0),
  "IVAFiscalImporte" = e.Impuestos,
  "Factor" = -1,
  e.Dinero,
  e.DineroID,
  e.DineroCtaDinero,
  "Conciliado" = e.DineroConciliado,
  "FechaConciliacion" = DineroFechaConciliacion

FROM Gasto e
JOIN Prov ON e.Acreedor = prov.Proveedor
JOIN MovTipo mt ON e.Mov  = mt.Mov AND mt.Modulo = 'GAS'
WHERE
  mt.Clave IN ('GAS.C', 'GAS.CCH') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

GO

-- select * from IVAFiscal
-- select ivafiscal, * from cxc

/*** IEPSFiscal ***/
if exists (select * from sysobjects where id = object_id('dbo.IEPSFiscal') and type = 'V') drop view dbo.IEPSFiscal
GO
CREATE VIEW IEPSFiscal
--//WITH ENCRYPTION
AS 
SELECT
  "Modulo" = CONVERT(char(5), 'VTAS'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  e.Referencia,
  "Contacto" = e.Cliente,
  cte.Nombre,
  cte.RFC,
  cte.CURP,
  "AplicaFecha" = e.FechaEmision,
  "Aplica" = e.Mov,
  "AplicaID" = e.MovID,
  "AplicaImporte" = vc.TotalCobrado,
  "FechaEmision" = e.FechaEmision,
  "IEPSFiscalFactor" = e.IEPSFiscal,
  "IEPSFiscalImporte" = vc.TotalCobrado * e.IEPSFiscal,
  "Factor" = 1,
  "Dinero" = CONVERT(char(20), NULL),
  "DineroID" = CONVERT(varchar(20), NULL),
  "DineroCtaDinero" = CONVERT(char(10), NULL),
  "Conciliado" = CONVERT(bit, 1),
  "FechaConciliacion" = e.FechaEmision

FROM Venta e
JOIN VentaCobro vc ON e.ID = vc.ID
JOIN Cte ON e.Cliente = cte.Cliente
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'VTAS'
WHERE
  mt.Clave IN ('VTAS.N', 'VTAS.FM', 'VTAS.NO', 'VTAS.NR', 'VTAS.F', 'VTAS.S', 'VTAS.P', 'VTAS.VP', 'VTAS.SD', 'VTAS.B') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
  AND NULLIF(vc.TotalCobrado, 0.0) IS NOT NULL

UNION

SELECT
  "Modulo" = CONVERT(char(5), 'CXC'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  e.Referencia,
  "Contacto" = e.Cliente,
  cte.Nombre,
  cte.RFC,
  cte.CURP,
  "AplicaFecha" = e.FechaEmision,
  d.Aplica,
  d.AplicaID,
  "AplicaImporte" = d.Importe,
  "FechaEmision" = a.FechaEmision,
  "IEPSFiscalFactor" = a.IEPSFiscal,
  "IEPSFiscalImporte" = CONVERT(money, d.Importe * a.IEPSFiscal),
  "Factor" = CASE mt.Clave WHEN 'CXC.DC' THEN -1 ELSE 1 END,
  e.Dinero,
  e.DineroID,
  e.DineroCtaDinero,
  "Conciliado" = e.DineroConciliado,
  "FechaConciliacion" = DineroFechaConciliacion

FROM Cxc e
JOIN Cte ON e.Cliente = cte.Cliente
JOIN CxcD d ON e.ID = d.ID 
JOIN CxcAplica a ON d.Aplica=a.Mov AND d.AplicaID=a.MovID AND e.Empresa=a.Empresa
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'CXC'
WHERE
  mt.Clave IN ('CXC.C', 'CXC.DC') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

UNION

SELECT
  "Modulo" = CONVERT(char(5), 'CXC'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  e.Referencia,
  "Contacto" = e.Cliente,
  cte.Nombre,
  cte.RFC,
  cte.CURP,
  "AplicaFecha" = e.FechaEmision,
  "Aplica" = e.Mov,
  "AplicaID" = e.MovID,
  "AplicaImporte" = ISNULL(e.Importe, 0)+ISNULL(e.Impuestos, 0),
  "FechaEmision" = e.FechaEmision,
  "IEPSFiscalFactor" = e.IEPSFiscal,
  "IEPSFiscalImporte" = CONVERT(money, (ISNULL(e.Importe, 0)+ISNULL(e.Impuestos, 0)) * e.IEPSFiscal),
  "Factor" = 1,
  e.Dinero,
  e.DineroID,
  e.DineroCtaDinero,
  "Conciliado" = e.DineroConciliado,
  "FechaConciliacion" = DineroFechaConciliacion 

FROM Cxc e
JOIN Cte ON e.Cliente = cte.Cliente
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'CXC'
WHERE
  mt.Clave IN ('CXC.A', 'CXC.AA') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

UNION

SELECT
  "Modulo" = CONVERT(char(5), 'CXP'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  e.Referencia,
  "Contacto" = e.Proveedor,
  prov.Nombre,
  prov.RFC,
  prov.CURP,
  "AplicaFecha" = e.FechaEmision,
  d.Aplica,
  d.AplicaID,
  "AplicaImporte" = d.Importe,
  "FechaEmision" = a.FechaEmision,
  "IEPSFiscalFactor" = a.IEPSFiscal,
  "IEPSFiscalImporte" = CONVERT(money, d.Importe * a.IEPSFiscal),
  "Factor" = CASE mt.Clave WHEN 'CXP.DC' THEN 1 ELSE -1 END,
  e.Dinero,
  e.DineroID,
  e.DineroCtaDinero,
  "Conciliado" = e.DineroConciliado,
  "FechaConciliacion" = DineroFechaConciliacion

FROM Cxp e
JOIN CxpD d ON e.ID = d.ID
JOIN CxpAplica a ON d.AplicaID = a.MovID AND d.Aplica=a.Mov AND e.Empresa=a.Empresa 
JOIN Prov ON e.Proveedor = Prov.Proveedor
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'CXP'
WHERE
   mt.Clave IN ('CXP.P', 'CXP.DC') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

UNION

SELECT
  "Modulo" = CONVERT(char(5), 'CXP'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  e.Referencia,
  "Contacto" = e.Proveedor,
  prov.Nombre,
  prov.RFC,
  prov.CURP,
  "AplicaFecha" = e.FechaEmision,
  "Aplica" = e.Mov,
  "AplicaID" = e.MovID,
  "AplicaImporte" = ISNULL(e.Importe, 0)+ISNULL(e.Impuestos, 0),
  "FechaEmision" = e.FechaEmision,
  "IEPSFiscalFactor" = e.IEPSFiscal,
  "IEPSFiscalImporte" = CONVERT(money, (ISNULL(e.Importe, 0)+ISNULL(e.Impuestos, 0)) * e.IEPSFiscal),
  "Factor" = -1,
  e.Dinero,
  e.DineroID,
  e.DineroCtaDinero,
  "Conciliado" = e.DineroConciliado,
  "FechaConciliacion" = DineroFechaConciliacion 

FROM Cxp e
JOIN Prov ON e.Proveedor = prov.Proveedor
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'CXP'
WHERE
  mt.Clave IN ('CXP.A', 'CXP.AA') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

UNION

SELECT
  "Modulo" = CONVERT(char(5), 'GAS'),
  e.ID,
  e.Sucursal,
  e.Empresa,
  e.Mov,
  e.MovID,
  e.Moneda,
  'Referencia' = CONVERT(varchar(50), NULL),
  "Contacto" = e.Acreedor,
  prov.Nombre,
  prov.RFC,
  prov.CURP,
  "AplicaFecha" = e.FechaEmision,
  "Aplica" = e.Mov,
  "AplicaID" = e.MovID,
  "AplicaImporte" = ISNULL(e.Importe, 0)+ISNULL(e.Impuestos, 0),
  "FechaEmision" = e.FechaEmision,
  "IEPSFiscalFactor" = CONVERT(float, NULLIF(Impuestos, 0)) / NULLIF(Importe + Impuestos, 0),
  "IEPSFiscalImporte" = e.Impuestos,
  "Factor" = -1,
  e.Dinero,
  e.DineroID,
  e.DineroCtaDinero,
  "Conciliado" = e.DineroConciliado,
  "FechaConciliacion" = DineroFechaConciliacion

FROM Gasto e
JOIN Prov ON e.Acreedor = prov.Proveedor
JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'GAS'

WHERE
  mt.Clave IN ('GAS.C', 'GAS.CCH') AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

GO

/************** MAFServicioAbierto ***************/
if exists (select * from sysobjects where id = object_id('dbo.MAFServicioAbierto') and type = 'V') drop view dbo.MAFServicioAbierto
GO
CREATE VIEW MAFServicioAbierto
AS
SELECT 
  v.ServicioTipo,
  v.AFArticulo,
  v.AFSerie,
  v.ID,
  v.Mov,
  v.MovID,
  v.Estatus 
  FROM Venta v JOIN MovTipo mt
    ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' JOIN MovFlujo mf
    ON mf.OID = v.ID AND mf.OModulo = 'VTAS' AND mf.DModulo = 'GES' JOIN Gestion g
    ON g.ID = mf.DID JOIN MovTipo mt2
    ON mt2.Mov = g.Mov AND mt2.Modulo = 'GES'
 WHERE mt.SubClave = 'MAF.S' 
   AND ((v.Estatus NOT IN ('CONCLUIDO','CANCELADO')) OR (v.Estatus IN ('CONCLUIDO') AND g.Estatus NOT IN ('CONCLUIDO','CANCELADO'))) 
   AND MT2.SubClave = 'MAF.SI'
GO      
   
/************** MAFServicioUnico ***************/   
if exists (select * from sysobjects where id = object_id('dbo.MAFServicioUnico') and type = 'V') drop view dbo.MAFServicioUnico
GO
CREATE VIEW MAFServicioUnico
AS
SELECT 
  v.ServicioTipo,
  v.AFArticulo,
  v.AFSerie,
  v.ID,
  v.Mov,
  v.MovID,
  v.Estatus 
  FROM Venta v JOIN MovTipo mt
    ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' JOIN ActivoFTipoServicio afts
    ON v.ServicioTipo = afts.Servicio AND afts.Unico = 1
 WHERE mt.SubClave = 'MAF.S' 
   AND v.Estatus NOT IN ('CANCELADO')
GO      

/************** MAFServicioCiclico ***************/   
if exists (select * from sysobjects where id = object_id('dbo.MAFServicioCiclico') and type = 'V') drop view dbo.MAFServicioCiclico
GO
CREATE VIEW MAFServicioCiclico
AS
SELECT 
  v.ServicioTipo,
  v.AFArticulo,
  v.AFSerie,
  v.ID,
  v.Mov,
  v.MovID,
  v.Estatus,
  v.MAFCiclo 
  FROM Venta v JOIN MovTipo mt
    ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' JOIN ActivoFTipoServicio afts
    ON v.ServicioTipo = afts.Servicio
 WHERE mt.SubClave = 'MAF.S' 
   AND v.Estatus NOT IN ('CANCELADO')
GO      

-- select * from IEPSFiscal
-- select IEPSfiscal, * from cxc

--REQ12615 WMS
/***************************************** VISTAS TMA *****************************************/
/****** TMAPendiente ******/
if exists (select * from sysobjects where id = object_id('dbo.TMAPendiente') and sysstat & 0xf = 2) drop view dbo.TMAPendiente
GO
CREATE VIEW TMAPendiente
--//WITH ENCRYPTION
AS
SELECT
  td.Tarima,
  t.Mov,
  t.MovID,
  adt.Articulo,
  td.CantidadPicking,
  td.Almacen,
  td.Renglon,
  0 RenglonID,
  t.Agente,
  t.ID,
  td.Posicion Posicion,
  td.PosicionDestino PosicionDestino,
  ap.Zona Zona

 FROM TMA t
 JOIN TMAD td ON t.ID = td.ID
 JOIN MovTipo mt ON t.Mov = mt.Mov AND 'TMA' = mt.Modulo AND 'TMA.TSUR' = mt.Clave
 JOIN AlmPos ap ON td.Almacen = ap.Almacen AND td.Posicion = ap.Posicion AND ap.Tipo = 'DOMICILIO'
 JOIN ArtDisponibleTarima adt ON td.Almacen = adt.Almacen AND td.Tarima = adt.Tarima
WHERE t.Estatus = 'PENDIENTE' AND ISNULL(td.Procesado,0) = 0 
GO


PRINT "******************* VISTAS ******************"


/*** EmbarqueMovOC ***/
if exists (select * from sysobjects where id = object_id('dbo.EmbarqueMovOC') and type = 'V') drop view dbo.EmbarqueMovOC
GO
CREATE VIEW EmbarqueMovOC
--//WITH ENCRYPTION
AS 
SELECT EmbarqueMov.*, 
       "CxcVencimiento"      = Cxc.Vencimiento,
       "CxcSaldo"            = Cxc.Saldo,
       "CxcPersonalCobrador" = Cxc.PersonalCobrador,
       "CxcSituacion"        = Cxc.Situacion,
       "CxcSituacionFecha"   = Cxc.SituacionFecha,
       "CxcSituacionUsuario" = Cxc.SituacionUsuario,
       "CxcSituacionNota"    = Cxc.SituacionNota
  FROM EmbarqueMov
  JOIN Cxc ON EmbarqueMov.ModuloID = Cxc.ID AND EmbarqueMov.Modulo='CXC'
GO


/*** DemandaPaquetesPromedio ***/
if exists (select * from sysobjects where id = object_id('dbo.DemandaPaquetesPromedio') and type = 'V') drop view dbo.DemandaPaquetesPromedio
GO
CREATE VIEW DemandaPaquetesPromedio
--//WITH ENCRYPTION
AS 
SELECT i.Empresa, d.Almacen, d.Articulo, "SubCuenta" = NULLIF(RTRIM(d.SubCuenta), ''), "Cantidad" = SUM(d.Cantidad), "Paquetes" = SUM(d.Paquete), "Promedio" = CONVERT(float, SUM(d.Cantidad)/NULLIF(SUM(d.Paquete), 0))
  FROM InvD d
  JOIN Inv i ON i.ID = d.ID
  JOIN MovTipo mt ON i.Mov = mt.Mov AND mt.Modulo = 'INV'
 WHERE i.Estatus = 'PENDIENTE' AND mt.Clave = 'INV.SOL'
 GROUP BY i.Empresa, d.Almacen, d.Articulo, NULLIF(RTRIM(d.SubCuenta), '')
GO


/*** ConceptoNominaRecibo ***/
if exists (select * from sysobjects where id = object_id('dbo.ConceptoNominaRecibo') and type = 'V') drop view dbo.ConceptoNominaRecibo
GO
CREATE VIEW ConceptoNominaRecibo
--//WITH ENCRYPTION
AS 
SELECT DISTINCT Concepto FROM NomXPersonal
GO


/*** ContSubSaldo ***/
if exists (select * from sysobjects where id = object_id('dbo.ContSubSaldo') and type = 'V') drop view dbo.ContSubSaldo
GO
CREATE VIEW ContSubSaldo
--//WITH ENCRYPTION
AS 
SELECT 
  s.Empresa,
  s.Moneda,
  s.Cuenta Cuenta,
  s.SubCuenta,
  "CentroCostos" = cc.Descripcion,
  Convert(money, Sum(s.Saldo)) Saldo
FROM Saldo s
LEFT OUTER JOIN CentroCostos cc ON s.SubCuenta = cc.CentroCostos
WHERE 
  s.Rama='CONT' 
GROUP BY 
  s.Empresa, s.Moneda, s.Cuenta, s.SubCuenta, cc.Descripcion
GO

/*** ContSubSaldoCont ***/
--if exists (select * from sysobjects where id = object_id('dbo.ContSubSaldoCont') and type = 'V') drop view dbo.ContSubSaldoCont
GO
/*
CREATE VIEW ContSubSaldoCont
--//WITH ENCRYPTION
AS 
SELECT 
  s.Ejercicio,
  s.Empresa,
  s.Moneda,
  s.Cuenta Cuenta,
  s.SubCuenta,
  "CentroCostos" = cc.Descripcion,
  Convert(money, Sum(s.Saldo)) Saldo
FROM SaldoCont s
LEFT OUTER JOIN CentroCostos cc ON s.SubCuenta = cc.CentroCostos
WHERE 
  s.Rama='CONT' 
GROUP BY 
  s.Ejercicio, s.Empresa, s.Moneda, s.Cuenta, s.SubCuenta, cc.Descripcion*/
GO
EXEC spDROP_VIEW 'ContSubSaldoCont', 3241
GO

/*** ContResumen ***/
if exists (select * from sysobjects where id = object_id('dbo.ContResumen') and type = 'V') drop view dbo.ContResumen
GO
CREATE VIEW ContResumen
--//WITH ENCRYPTION
AS 
SELECT
  e.Empresa,
  e.Controladora,
  d.Ejercicio,
  d.Periodo,
  Cont.Mov,
  d.Cuenta,
  d.SubCuenta,
  sum(d.Debe) Debe,
  sum(d.Haber) Haber,
  Cta.Descripcion

FROM Cont
JOIN ContD d ON Cont.ID = d.ID
JOIN Cta ON d.Cuenta = Cta.Cuenta 
JOIN Empresa e ON Cont.Empresa = e.Empresa
WHERE
  Cont.Estatus = 'CONCLUIDO'

GROUP BY
  e.Empresa, e.Controladora, d.Ejercicio, d.Periodo, Cont.Mov, d.Cuenta, Cta.Descripcion, d.SubCuenta
GO

/*** ProvSocio ***/
if exists (select * from sysobjects where id = object_id('dbo.ProvSocio') and type = 'V') drop view dbo.ProvSocio
GO
CREATE VIEW ProvSocio
--//WITH ENCRYPTION
AS 
SELECT "Socio" = Proveedor, Nombre, Estatus FROM Prov WHERE Tipo = 'Socio'
GO


/*** Propietario ***/
if exists (select * from sysobjects where id = object_id('dbo.Propietario') and type = 'V') drop view dbo.Propietario
GO
CREATE VIEW Propietario
--//WITH ENCRYPTION
AS 
SELECT "Propietario" = Proveedor, Nombre, Estatus FROM Prov WHERE Tipo = 'Propietario'
GO


/*** ServiciosPendientesAgente ***/
if exists (select * from sysobjects where id = object_id('dbo.ServiciosPendientesAgente') and type = 'V') drop view dbo.ServiciosPendientesAgente
GO
CREATE VIEW ServiciosPendientesAgente
--//WITH ENCRYPTION
AS 
SELECT d.Agente, "Cantidad" = SUM(ISNULL(d.CantidadPendiente, 0)+ISNULL(d.CantidadOrdenada, 0)), "Horas" = SUM(ISNULL(d.CantidadPendiente, 0)+ISNULL(d.CantidadOrdenada, 0)*a.Horas) 
  FROM VentaPendienteD d
  JOIN Art a ON d.Articulo = a.Articulo
 WHERE UPPER(a.Tipo)='SERVICIO' AND NULLIF(RTRIM(d.Agente), '') IS NOT NULL
 GROUP BY d.Agente
GO


/*** EvaluacionCalificacion ***/
if exists (select * from sysobjects where id = object_id('dbo.EvaluacionCalificacion') and type = 'V') drop view dbo.EvaluacionCalificacion
GO
CREATE VIEW EvaluacionCalificacion
--//WITH ENCRYPTION
AS 
SELECT ec.Evaluacion,
       ec.Contacto,
       ec.Fecha,
       ec.Modulo,
       ec.ModuloID,
       "Calificacion" = SUM(ec.Calificacion*(ef.Peso/100)),
--       "Calificacion" = dbo.fnR3(SUM(ef.Peso), SUM(ec.Calificacion*(ef.Peso/100)), 100.0),   para que la calificacion sea relativa al peso sin que tenga que ser el 100%
--       "Estatus" = (CASE (SELECT COUNT(*) FROM EvaluacionCto e WHERE e.Evaluacion=ec.Evaluacion AND e.Fecha = ec.Fecha AND e.Contacto = ec.Contacto AND Calificacion IS NULL) WHEN 0 THEN "CONCLUIDO" ELSE "BORRADOR" END)
         "Estatus" = (CASE WHEN (SELECT COUNT(*) FROM EvaluacionCto e WHERE e.Evaluacion=ec.Evaluacion AND e.Fecha = ec.Fecha AND e.Contacto = ec.Contacto AND Calificacion IS NULL) = 0 AND ISNULL(dbo.fnMovEstatus(ec.Modulo, ec.ModuloID), '') <> 'CANCELADO' THEN 'CONCLUIDO'
                           WHEN ISNULL(dbo.fnMovEstatus(ec.Modulo, ec.ModuloID), '') = 'CANCELADO' THEN 'CANCELADO' 
                           ELSE  'BORRADOR' END)
  FROM EvaluacionFormato ef
  JOIN EvaluacionCto ec ON ef.Evaluacion = ec.Evaluacion AND ef.Punto = ec.Punto 
 GROUP BY ec.Evaluacion, ec.Contacto, ec.Fecha, ec.Modulo, ec.ModuloID
GO

-- select * from EvaluacionCalificacion where contacto = 'JLR'
/*** EspacioResultadoT ***/
if exists (select * from sysobjects where id = object_id('dbo.EspacioResultadoT') and type = 'V') drop view dbo.EspacioResultadoT
GO
CREATE VIEW EspacioResultadoT
--//WITH ENCRYPTION
AS 
SELECT e.Empresa,
       e.Parte,
       e.Espacio, 
       p.Propietario,
       "PropietarioNombre" = pp.Nombre,
       s.Socio,
       "SocioNombre" = ps.Nombre,
       e.Concepto,
       c.Clase,
       c.SubClase,
       e.Ejercicio,
       e.Periodo,
       e.Orden,
       "Cantidad" = CONVERT(float, e.Cantidad*(p.Porcentaje/100)*(s.Porcentaje/100)),
       "Ingreso"  = CONVERT(money, e.Ingreso*(p.Porcentaje/100)*(s.Porcentaje/100)),
       "Egreso"   = CONVERT(money, e.Egreso*(p.Porcentaje/100)*(s.Porcentaje/100)),
       "EgresoND" = CONVERT(money, e.EgresoND*(p.Porcentaje/100)*(s.Porcentaje/100)),
       "Importe"  = CONVERT(money, e.Importe*(p.Porcentaje/100)*(s.Porcentaje/100))
  FROM EspacioResultado e
  LEFT OUTER JOIN Concepto c ON c.Modulo = 'GAS' AND c.Concepto = e.Concepto
  LEFT OUTER JOIN EspacioPropietario p ON p.Espacio = e.Espacio
  LEFT OUTER JOIN Prov pp ON pp.Proveedor = p.Propietario
  LEFT OUTER JOIN PropietarioSocio s ON s.Propietario = p.Propietario
  LEFT OUTER JOIN Prov ps ON ps.Proveedor = s.Socio
GO

/*** PropietarioResultado ***/
if exists (select * from sysobjects where id = object_id('dbo.PropietarioResultado') and type = 'V') drop view dbo.PropietarioResultado
GO
CREATE VIEW PropietarioResultado
--//WITH ENCRYPTION
AS 
SELECT Empresa,
       Parte,
       Propietario,
       PropietarioNombre,
       Concepto,
       Clase,
       SubClase,
       Ejercicio,
       Periodo,
       Orden,
       "Cantidad" = SUM(Cantidad),
       "Ingreso"  = SUM(Ingreso),
       "Egreso"   = SUM(Egreso),
       "EgresoND" = SUM(EgresoND),
       "Importe"  = SUM(Importe)
  FROM EspacioResultadoT
 GROUP BY Empresa, Parte, Propietario, PropietarioNombre, Concepto, Clase, SubClase, Ejercicio, Periodo, Orden
GO

/*** SocioResultado ***/
if exists (select * from sysobjects where id = object_id('dbo.SocioResultado') and type = 'V') drop view dbo.SocioResultado
GO
CREATE VIEW SocioResultado
--//WITH ENCRYPTION
AS 
SELECT Empresa,
       Parte,
       Socio,
       SocioNombre,
       Concepto,
       Clase,
       SubClase,
       Ejercicio,
       Periodo,
       Orden,
       "Cantidad" = SUM(Cantidad),
       "Ingreso"  = SUM(Ingreso),
       "Egreso"   = SUM(Egreso),
       "EgresoND" = SUM(EgresoND),
       "Importe"  = SUM(Importe)
  FROM EspacioResultadoT
 GROUP BY Empresa, Parte, Socio, SocioNombre, Concepto, Clase, SubClase, Ejercicio, Periodo, Orden
GO


/*
 SELECT SUM(Importe) FROM EspacioResultado
 SELECT SUM(Importe) FROM EspacioResultadoT
 SELECT SUM(Importe) FROM SocioResultado
 SELECT SUM(Importe) FROM PropietarioResultado
*/

/*** CteMov ***/
if exists (select * from sysobjects where id = object_id('dbo.CteMov') and type = 'V') drop view dbo.CteMov
GO
CREATE VIEW CteMov
--//WITH ENCRYPTION
AS 
SELECT 
  'Modulo' = CONVERT(char(5), 'VTAS'),
  ID,
  Mov,
  MovID,
  Estatus,
  Situacion,
  SituacionFecha,
  SituacionUsuario,
  SituacionNota,
  FechaEmision,
  Empresa,
  Sucursal,
  Cliente,
  Referencia,
  Concepto,
  UEN,
  Proyecto,
  Usuario

FROM 
  Venta

UNION ALL

SELECT 
  'Modulo' = CONVERT(char(5), 'CXC'),
  ID,
  Mov,
  MovID,
  Estatus,
  Situacion,
  SituacionFecha,
  SituacionUsuario,
  SituacionNota,
  FechaEmision,
  Empresa,
  Sucursal,
  Cliente,
  Referencia,
  Concepto,
  UEN,
  Proyecto,
  Usuario

FROM 
  Cxc

UNION ALL

SELECT 
  'Modulo' = CONVERT(char(5), 'ST'),
  ID,
  Mov,
  MovID,
  Estatus,
  Situacion,
  SituacionFecha,
  SituacionUsuario,
  SituacionNota,
  FechaEmision,
  Empresa,
  Sucursal,
  Cliente,
  Referencia,
  Concepto,
  UEN,
  Proyecto,
  Usuario

FROM 
  Soporte

WHERE 
  NULLIF(RTRIM(Cliente), '') IS NOT NULL
GO

-- SELECT * FROM CteMov

/*** CteAnexoMov ***/
if exists (select * from sysobjects where id = object_id('dbo.CteAnexoMov') and type = 'V') drop view dbo.CteAnexoMov
GO
CREATE VIEW CteAnexoMov
--//WITH ENCRYPTION
AS 
SELECT 
  a.Rama, 
  a.ID,
  a.Nombre,
  a.Direccion,
  a.Icono,
  a.Tipo,
  a.Orden,
  a.Comentario,
  m.Mov,
  m.MovID,
  m.Estatus,
  m.Situacion,
  m.SituacionFecha,
  m.SituacionUsuario,
  m.SituacionNota,
  m.FechaEmision,
  m.Empresa,
  m.Sucursal,
  m.Cliente,
  m.Referencia,
  m.Concepto,
  m.UEN,
  m.Proyecto,
  m.Usuario

FROM CteMov m
JOIN AnexoMov a ON m.ID = a.ID AND m.Modulo = a.Rama
GO

-- SELECT * FROM CteAnexoMov WHERE Cliente = 'MEX' 

/*** CteMovBitacora ***/
if exists (select * from sysobjects where id = object_id('dbo.CteMovBitacora') and type = 'V') drop view dbo.CteMovBitacora
GO
CREATE VIEW CteMovBitacora
--//WITH ENCRYPTION
AS 
SELECT 
  b.Modulo, 
  b.ID,
  b.RID,
  b.Fecha,
  b.Evento,
  b.Usuario,
  m.Mov,
  m.MovID,
  m.Estatus,
  m.Situacion,
  m.SituacionFecha,
  m.SituacionUsuario,
  m.SituacionNota,
  m.FechaEmision,
  m.Empresa,
  m.Sucursal,
  m.Cliente,
  m.Referencia,
  m.Concepto,
  m.UEN,
  m.Proyecto

FROM CteMov m
JOIN MovBitacora b ON m.ID = b.ID AND m.Modulo = b.Modulo
GO
-- select * from CteMovbitacora

/*** CteMovTarea ***/
if exists (select * from sysobjects where id = object_id('dbo.CteMovTarea') and type = 'V') drop view dbo.CteMovTarea
GO
CREATE VIEW CteMovTarea
--//WITH ENCRYPTION
AS 
SELECT 
  'Modulo' = CONVERT(char(5), 'VTAS'), 
  t.ID,
  t.Tarea,
  t.Problema,
  t.Solucion,
  t.Fecha,
  t.Estado,
  t.Responsable,
  t.FechaEstimada,
  t.FechaConclusion,
  m.Mov,
  m.MovID,
  m.Estatus,
  m.Situacion,
  m.SituacionFecha,
  m.SituacionUsuario,
  m.SituacionNota,
  m.FechaEmision,
  m.Empresa,
  m.Sucursal,
  m.Cliente,
  m.Referencia,
  m.Concepto,
  m.UEN,
  m.Proyecto

FROM Venta m
JOIN ServicioTarea t ON m.ID = t.ID

UNION ALL
SELECT 
  'Modulo' = CONVERT(char(5), 'ST'), 
  t.ID,
  t.Tarea,
  t.Problema,
  t.Solucion,
  t.Fecha,
  t.Estado,
  t.Responsable,
  t.FechaEstimada,
  t.FechaConclusion,
  m.Mov,
  m.MovID,
  m.Estatus,
  m.Situacion,
  m.SituacionFecha,
  m.SituacionUsuario,
  m.SituacionNota,
  m.FechaEmision,
  m.Empresa,
  m.Sucursal,
  m.Cliente,
  m.Referencia,
  m.Concepto,
  m.UEN,
  m.Proyecto
FROM Soporte m 
JOIN MovTarea t ON m.ID = t.ID 
WHERE
  t.Modulo = 'ST'
GO

-- select * from CteMovTarea


/*** SucursalesDelGrupoConAlm ***/
if exists (select * from sysobjects where id = object_id('dbo.SucursalesDelGrupoConAlm') and type = 'V') drop view dbo.SucursalesDelGrupoConAlm
GO
CREATE VIEW SucursalesDelGrupoConAlm
--//WITH ENCRYPTION
AS 
SELECT Grupo, "Sucursales" = COUNT(*) 
  FROM Sucursal 
  WHERE NULLIF(RTRIM(AlmacenPrincipal), '') IS NOT NULL AND Estatus = 'ALTA'
 GROUP BY Grupo
GO


-- select * from SalidaEntrada

/*** SalidaEntrada ***/
if exists (select * from sysobjects where id = object_id('dbo.SalidaEntrada') and type = 'V') drop view dbo.SalidaEntrada
GO
CREATE VIEW SalidaEntrada
--//WITH ENCRYPTION
AS 
SELECT "Factor" = CONVERT(float, -1)
UNION
SELECT "Factor" = CONVERT(float, 1)
GO


/*** MovRecurrente ***/
if exists (select * from sysobjects where id = object_id('dbo.MovRecurrente') and type = 'V') drop view dbo.MovRecurrente
GO
CREATE VIEW MovRecurrente
--//WITH ENCRYPTION
AS 
SELECT Modulo = CONVERT(char(5), 'VTAS'), m.ID, m.Empresa, m.Mov, m.MovID, m.FechaEmision, m.Vencimiento, m.Proyecto, m.UEN, m.Moneda, m.TipoCambio, m.Usuario, m.Situacion, m.Periodicidad, "Contacto" = m.Cliente, c.Nombre, m.Importe, m.Impuestos, m.ConVigencia, m.VigenciaDesde, m.VigenciaHasta 
  FROM Venta m 
  JOIN Cte c ON m.Cliente = c.Cliente
 WHERE m.Estatus = 'RECURRENTE'
UNION ALL
SELECT Modulo = CONVERT(char(5), 'GAS'),  m.ID, m.Empresa, m.Mov, m.MovID, m.FechaEmision, m.Vencimiento, m.Proyecto, m.UEN, m.Moneda, m.TipoCambio, m.Usuario, m.Situacion, m.Periodicidad, "Contacto" = m.Acreedor, c.Nombre, m.Importe, m.Impuestos, m.ConVigencia, m.VigenciaDesde, m.VigenciaHasta 
  FROM Gasto m
  JOIN Prov c ON  m.Acreedor = c.Proveedor
 WHERE m.Estatus = 'RECURRENTE'
GO


/*** eMailAutoCampo ***/
if exists (select * from sysobjects where id = object_id('dbo.eMailAutoCampo') and type = 'V') drop view dbo.eMailAutoCampo
GO
CREATE VIEW eMailAutoCampo
--//WITH ENCRYPTION
AS 
SELECT Orden = 1, "Campo" = CONVERT(varchar(50), '<Mov>')
UNION
SELECT Orden = 2, "Campo" = '<MovID>'
UNION
SELECT Orden = 3, "Campo" = '<Fecha Emision>'
UNION
SELECT Orden = 4, "Campo" = '<Estatus>'
UNION
SELECT Orden = 5, "Campo" = '<Situacion>'
UNION
SELECT Orden = 6, "Campo" = '<Fecha Seguimiento>'
UNION
SELECT Orden = 7, "Campo" = '<Empresa>'
UNION
SELECT Orden = 8, "Campo" = '<Sucursal>'
UNION
SELECT Orden = 9, "Campo" = '<UEN>'
UNION
SELECT Orden = 10, "Campo" = '<Proyecto>'
UNION
SELECT Orden = 11, "Campo" = '<Concepto>'
UNION
SELECT Orden = 12, "Campo" = '<Referencia>'
UNION
SELECT Orden = 13, "Campo" = '<Clave>'
UNION
SELECT Orden = 14, "Campo" = '<Nombre>'
UNION
SELECT Orden = 15, "Campo" = '<Contacto>'
UNION
SELECT Orden = 16, "Campo" = '<eMail>'
GO
-- select * from emailautocampo

/*** ProvNombre ***/
--if exists (select * from sysobjects where id = object_id('dbo.ProvNombre') and type = 'V') drop view dbo.ProvNombre
GO
/*CREATE VIEW ProvNombre
--//WITH ENCRYPTION
AS 
SELECT DISTINCT Nombre FROM Prov*/
GO

/*** SerieLoteEstatus ***/
if exists (select * from sysobjects where id = object_id('dbo.SerieLoteEstatus') and type = 'V') drop view dbo.SerieLoteEstatus
GO
CREATE VIEW SerieLoteEstatus
--//WITH ENCRYPTION
AS 
SELECT *, "Estatus" = dbo.fnSerieLoteCalidad(Empresa, Articulo, SubCuenta, SerieLote)
  FROM SerieLote
GO

/*** ProvNombre ***/
if exists (select * from sysobjects where id = object_id('dbo.ProvNombre') and type = 'V') drop view dbo.ProvNombre
GO
CREATE VIEW ProvNombre
--//WITH ENCRYPTION
AS 
SELECT DISTINCT Nombre 
  FROM Prov
GO


/*** InvAuxUMov ***/
if exists (select * from sysobjects where id = object_id('dbo.InvAuxUMov') and type = 'V') drop view dbo.InvAuxUMov
GO
CREATE VIEW InvAuxUMov
--//WITH ENCRYPTION
AS 
SELECT DISTINCT Mov from AuxiliarU WHERE Rama = 'INV'
GO

/*** VINCostoExtraEmpresa ***/
if exists (select * from sysobjects where id = object_id('dbo.VINCostoExtraEmpresa') and type = 'V') drop view dbo.VINCostoExtraEmpresa
GO
CREATE VIEW VINCostoExtraEmpresa
--//WITH ENCRYPTION
AS 
SELECT VIN, Empresa, "CostoExtra"=ISNULL(SUM(CostoExtra), 0) 
  FROM VINCostoExtra
 GROUP BY VIN, Empresa
GO

/*** VINCostoExtraEmpresaSinSalida ***/
if exists (select * from sysobjects where id = object_id('dbo.VINCostoExtraEmpresaSinSalida') and type = 'V') drop view dbo.VINCostoExtraEmpresaSinSalida
GO
CREATE VIEW VINCostoExtraEmpresaSinSalida
--//WITH ENCRYPTION
AS 
SELECT VIN, Empresa, "CostoExtra"=ISNULL(SUM(CostoExtra), 0) 
  FROM VINCostoExtra
 WHERE SalidaID IS NULL
 GROUP BY VIN, Empresa
GO


/*** CxcRama ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcRama') and type = 'V') drop view dbo.CxcRama
GO
CREATE VIEW CxcRama
--//WITH ENCRYPTION
AS 
SELECT r.ID, "Saldo" = NULLIF(SUM(c.Saldo), 0.0), "InteresesOrdinarios"= NULLIF(SUM(c.InteresesOrdinarios), 0.0), "InteresesFijos"= NULLIF(SUM(c.InteresesFijos), 0.0), "InteresesMoratorios"= NULLIF(SUM(c.InteresesMoratorios), 0.0)
  FROM Cxc c
  JOIN Cxc r ON r.ID = c.RamaID
 GROUP BY r.ID
GO


/*** CxpRama ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpRama') and type = 'V') drop view dbo.CxpRama
GO
CREATE VIEW CxpRama
--//WITH ENCRYPTION
AS 
SELECT r.ID, "Saldo" = NULLIF(SUM(c.Saldo), 0.0), "InteresesOrdinarios"= NULLIF(SUM(c.InteresesOrdinarios), 0.0), "InteresesFijos"= NULLIF(SUM(c.InteresesFijos), 0.0), "InteresesMoratorios"= NULLIF(SUM(c.InteresesMoratorios), 0.0)
  FROM Cxp c
  JOIN Cxp r ON r.ID = c.RamaID
 GROUP BY r.ID
GO

/*** PosicionExistencia ***/
if exists (select * from sysobjects where id = object_id('dbo.PosicionExistencia') and type = 'V') drop view dbo.PosicionExistencia
GO
CREATE VIEW PosicionExistencia
--//WITH ENCRYPTION
AS 
SELECT al.Empresa, al.Almacen, al.Posicion, al.Articulo, al.SubCuenta,Unidad=ISNULL(u.Unidad,AL.Unidad), Existencia = SUM((ISNULL(al.Entrada, 0.0)-ISNULL(al.Salida, 0.0))) /*SUM((ISNULL(Entrada, 0.0)-ISNULL(Salida, 0.0))/ISNULL(Factor, 1.0))*/, ExistenciaAlterna = SUM((ISNULL(al.Entrada, 0.0)-ISNULL(al.Salida, 0.0)))
  FROM AuxiliarAlterno al
  Join art a ON al.Articulo = a.Articulo
  LEFT OUTER JOIN ArtUnidad u ON u.Articulo = a.Articulo AND u.Factor = 1
 GROUP BY al.Empresa, al.Almacen, al.Posicion, al.Articulo, al.SubCuenta,ISNULL(u.Unidad,AL.Unidad)
GO

/*** ExistenciaAlternaSerieLote ***/
if exists (select * from sysobjects where id = object_id('dbo.ExistenciaAlternaSerieLote') and type = 'V') drop view dbo.ExistenciaAlternaSerieLote
GO
CREATE VIEW ExistenciaAlternaSerieLote
--//WITH ENCRYPTION
AS 
SELECT al.Empresa, al.Almacen, al.SerieLote, al.Articulo, al.SubCuenta, Unidad=ISNULL(u.Unidad,AL.Unidad), Existencia = SUM((ISNULL(al.Entrada, 0.0)-ISNULL(al.Salida, 0.0))) /*SUM((ISNULL(Entrada, 0.0)-ISNULL(Salida, 0.0))/ISNULL(Factor, 1.0))*/, ExistenciaAlterna = SUM((ISNULL(al.Entrada, 0.0)-ISNULL(al.Salida, 0.0)))
  FROM AuxiliarAlterno al 
  Join art a ON al.Articulo = a.Articulo
  LEFT OUTER JOIN ArtUnidad u ON u.Articulo = a.Articulo AND u.Factor = 1
 GROUP BY al.Empresa, al.Almacen, al.SerieLote, al.Articulo, al.SubCuenta,ISNULL(u.Unidad,AL.Unidad)
GO

/*** ExistenciaAlternaPosicionSerieLote ***/
if exists (select * from sysobjects where id = object_id('dbo.ExistenciaAlternaPosicionSerieLote') and type = 'V') drop view dbo.ExistenciaAlternaPosicionSerieLote
GO
CREATE VIEW ExistenciaAlternaPosicionSerieLote
--//WITH ENCRYPTION
AS 
SELECT al.Empresa, al.Almacen, al.SerieLote, al.Articulo, al.SubCuenta, Unidad=ISNULL(u.Unidad,AL.Unidad), Existencia = SUM((ISNULL(al.Entrada, 0.0)-ISNULL(al.Salida, 0.0))) /*SUM((ISNULL(Entrada, 0.0)-ISNULL(Salida, 0.0))/ISNULL(Factor, 1.0))*/, ExistenciaAlterna = SUM((ISNULL(al.Entrada, 0.0)-ISNULL(al.Salida, 0.0))), al.Posicion
  FROM AuxiliarAlterno al 
  Join art a ON al.Articulo = a.Articulo
  LEFT OUTER JOIN ArtUnidad u ON u.Articulo = a.Articulo AND u.Factor = 1
 GROUP BY al.Empresa, al.Almacen, al.SerieLote, al.Articulo, al.SubCuenta, al.Posicion, ISNULL(u.Unidad,AL.Unidad)
GO

--bug 25902
/*** ExistenciaInvPosicionSerieLote ***/
if exists (select * from sysobjects where id = object_id('dbo.ExistenciaInvPosicionSerieLote') and type = 'V') drop view dbo.ExistenciaInvPosicionSerieLote
GO
CREATE VIEW ExistenciaInvPosicionSerieLote
--//WITH ENCRYPTION
AS 
SELECT Empresa, Almacen, SerieLote, Articulo, SubCuenta, Existencia = SUM((ISNULL(Entrada, 0.0)-ISNULL(Salida, 0.0))/ISNULL(Factor, 1.0)), ExistenciaAlterna = SUM((ISNULL(Entrada, 0.0)-ISNULL(Salida, 0.0))), Posicion
  FROM AuxiliarAlterno
 GROUP BY Empresa, Almacen, SerieLote, Articulo, SubCuenta, Posicion
GO


/*** ExistenciaInvPosicion ***/
if exists (select * from sysobjects where id = object_id('dbo.ExistenciaInvPosicion') and type = 'V') drop view dbo.ExistenciaInvPosicion
GO
CREATE VIEW ExistenciaInvPosicion
--//WITH ENCRYPTION
AS 
SELECT e.Empresa, e.Almacen, e.SerieLote, e.Articulo, e.Subcuenta, Existencia = e.ExistenciaAlterna, e.Posicion, TipoPosicion = p.Tipo
FROM ExistenciaInvPosicionSerieLote e
JOIN Alm ON alm.Almacen = e.Almacen  
JOIN AlmPos p ON Alm.Almacen = p.Almacen AND e.Posicion = p.Posicion
WHERE Alm.Ubicaciones = 1 AND Existencia > 0
UNION

SELECT ad.Empresa, ad.Almacen, sl.SerieLote, ad.Articulo, ad.Subcuenta,  Existencia =CASE WHEN a.Tipo  IN ('Serie', 'Lote') THEN sl.Existencia ELSE ad.Disponible END, NULL, NULL
FROM ArtSubDisponible ad
 LEFT OUTER JOIN SerieLote sl ON ad.Empresa = sl.Empresa AND ad.Articulo = sl.Articulo AND ad.Subcuenta = sl.Subcuenta AND ad.Almacen = sl.Almacen
 JOIN Art a ON ad.Articulo = a.Articulo 
 JOIN Alm ON ad.Almacen = alm.Almacen
 WHERE Alm.Ubicaciones = 0 AND CASE WHEN a.Tipo  IN ('Serie', 'Lote') THEN sl.Existencia ELSE ad.Disponible END > 0
 GO

/*** EventoTipoGeneral ***/
if exists (select * from sysobjects where id = object_id('dbo.EventoTipoGeneral') and type = 'V') drop view dbo.EventoTipoGeneral
GO
CREATE VIEW EventoTipoGeneral
--//WITH ENCRYPTION
AS 
SELECT Tipo
  FROM EventoTipo
 WHERE General = 1
GO

-- select * from MovEvento
-- select * from AnexoMov
-- select * from Tarea
-- select * from MovBitacora
-- select * from EvaluacionCalificacion
-- select * from VerMovTiempo
-- select * from movflujo

/*** MovEvento ***/
if exists (select * from sysobjects where id = object_id('dbo.MovEvento') and type = 'V') drop view dbo.MovEvento
GO
CREATE VIEW MovEvento
--//WITH ENCRYPTION
AS 
SELECT Modulo, ModuloID = ID, Tipo, Asunto = Evento, Fecha, Usuario, Estado = NULL
  FROM MovBitacora
UNION ALL
SELECT Modulo, ModuloID, Tipo = 'Tarea', Asunto, Fecha = FechaEmision, Usuario, Estado
  FROM Tarea
UNION ALL
SELECT Modulo = Rama, ModuloID = ID, Tipo = 'Anexo', Asunto = Nombre, Fecha = FechaEmision, Usuario = NULL, Estado = NULL
  FROM AnexoMov
UNION ALL
SELECT Modulo, ModuloID, Tipo = 'Evaluacion', Asunto = Evaluacion, Fecha, Usuario = NULL, Estado = convert(varchar(30), CASE Estatus WHEN 'CONCLUIDO' THEN 'Completada' ELSE 'No Comenzada' END)
  FROM EvaluacionCalificacion
 WHERE Modulo IS NOT NULL AND ModuloID IS NOT NULL
UNION ALL
SELECT t.Modulo, ModuloID = t.ID, Tipo = 'Avance', Asunto = dbo.fnSegundoEntreParentesis(e.Nombre, t.Situacion), Fecha = ISNULL(t.FechaTermino, t.FechaComenzo), t.Usuario, Estado = NULL
  FROM VerMovTiempo t
  JOIN Estatus e ON e.Estatus = t.Estatus
UNION ALL
SELECT Modulo = mf.OModulo, ModuloID = mf.OID, Tipo = 'Posicion', Asunto = RTRIM(m.Mov)+' '+RTRIM(m.MovID)+' ('+modulo.Nombre+')', Fecha = m.FechaEmision, m.Usuario, Estado = NULL
  FROM MovFlujo mf
  JOIN Mov m ON m.Empresa = mf.Empresa AND m.Modulo = mf.DModulo AND m.ID = mf.DID
  JOIN Modulo ON Modulo.Modulo = m.Modulo
 WHERE mf.Cancelado = 0
GO

/*
 select * from MovIn
 select * from MovOut
*/
/*** MovIn ***/
if exists (select * from sysobjects where id = object_id('dbo.MovIn') and type = 'V') drop view dbo.MovIn
GO
CREATE VIEW MovIn
--//WITH ENCRYPTION
AS 
SELECT Empresa, Sucursal, Modulo, Mov, Ejercicio, Periodo, "Conteo" = COUNT(*)
  FROM Mov
 WHERE Fuera = 0 AND Modulo <> 'CONT' AND (SELECT dbo.fnMovEstatus(Modulo, ID)) IN ('CONCLUIDO', 'CANCELADO')
 GROUP BY Empresa, Sucursal, Modulo, Mov, Ejercicio, Periodo
GO

/*** MovOut ***/
if exists (select * from sysobjects where id = object_id('dbo.MovOut') and type = 'V') drop view dbo.MovOut
GO
CREATE VIEW MovOut
--//WITH ENCRYPTION
AS 
SELECT Empresa, Sucursal, Modulo, Mov, Ejercicio, Periodo, "Conteo" = COUNT(*)
  FROM Mov
 WHERE Fuera = 1 --AND (SELECT dbo.fnMovEstatus(Modulo, ID)) IN ('CONCLUIDO', 'CANCELADO') -- no se pone porque ya no estan en la base
 GROUP BY Empresa, Sucursal, Modulo, Mov, Ejercicio, Periodo
GO


/*** prePresupuestoAcum ***/
if exists (select * from sysobjects where id = object_id('dbo.prePresupuestoAcum') and type = 'V') drop view dbo.prePresupuestoAcum
GO
CREATE VIEW prePresupuestoAcum
--//WITH ENCRYPTION
AS 
SELECT
  p.Empresa,
  p.Rama,
  p.Moneda,
  p.Tipo,
  p.Cuenta,
  p.Ejercicio,
  p.Periodo,
  'Presupuesto' = SUM(p.Presupuesto),
  'Reservado'   = SUM(p.Reservado),
  'Comprometido'= SUM(p.Comprometido),
  'Devengado'   = SUM(p.Devengado),
  'Ejercido'    = SUM(p.Ejercido)
--  'Ejercido'    = (SELECT NULLIF(ABS(ISNULL(SUM(a.Cargos), 0)-ISNULL(SUM(a.Abonos), 0)), 0) FROM Acum a WHERE a.Empresa = p.Empresa AND a.Rama = p.Rama AND a.Cuenta = p.Cuenta AND a.Ejercicio = p.Ejercicio AND a.Periodo = p.Periodo)

FROM
  Presupuesto p
  
GROUP BY
  p.Empresa, p.Rama, p.Moneda, p.Tipo, p.Cuenta, p.Ejercicio, p.Periodo
GO

/*** PresupuestoAcum ***/
if exists (select * from sysobjects where id = object_id('dbo.PresupuestoAcum') and type = 'V') drop view dbo.PresupuestoAcum
GO
CREATE VIEW PresupuestoAcum
--//WITH ENCRYPTION
AS 
SELECT
  Empresa,
  Rama,
  Moneda,
  Tipo,
  Cuenta,
  Ejercicio,
  Periodo,
  Presupuesto,
  Reservado,
  Comprometido,
  Devengado,
  Ejercido,
  'Disponible' = ISNULL(Presupuesto, 0.0)-ISNULL(Reservado, 0.0)-ISNULL(Comprometido, 0.0)-ISNULL(Devengado, 0.0)-ISNULL(Ejercido, 0.0)

FROM
  prePresupuestoAcum
GO

-- select * from PresupuestoAcum


/*** PresupuestoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.PresupuestoCalc') and type = 'V') drop view dbo.PresupuestoCalc
GO
CREATE VIEW PresupuestoCalc
--//WITH ENCRYPTION
AS 
SELECT
  *,
  'Disponible' = ISNULL(Presupuesto, 0.0)-ISNULL(Reservado, 0.0)-ISNULL(Comprometido, 0.0)-ISNULL(Devengado, 0.0)-ISNULL(Ejercido, 0.0)

FROM
  Presupuesto
GO

/**************************** fnDetalleTipo ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnDetalleTipo') and type in ('fn','tf')) drop function dbo.fnDetalleTipo
GO
CREATE FUNCTION fnDetalleTipo (
				@DetalleTipo		varchar(50),
				@Rama			varchar(20)
)
RETURNS varchar(50)
AS BEGIN		
  DECLARE
    @Resultado	varchar(50)

  SELECT @Resultado = NULLIF(RTRIM(@DetalleTipo), '')
  WHILE @Resultado IS NULL AND @Rama IS NOT NULL
  BEGIN
    SELECT @Resultado = NULLIF(RTRIM(DetalleTipo), ''), @Rama = NULLIF(RTRIM(Rama), '')
      FROM Cta
     WHERE Cuenta = @Rama
  END

  RETURN (@Resultado)
END
GO


/*** ContDW ***/
if exists (select * from sysobjects where id = object_id('dbo.ContDW') and type = 'V') drop view dbo.ContDW
GO
CREATE VIEW ContDW
--//WITH ENCRYPTION
AS 
SELECT
  'Cuenta' = r.Cuenta,
  'Mayor' = dbo.fnCtaMayor(r.Cuenta),
  'DetalleTipo' = dbo.fnDetalleTipo(Cta.DetalleTipo, Cta.Rama),
  'CentroCostos' = r.SubCuenta,
  'CentroCostos2' = r.SubCuenta2,
  'CentroCostos3' = r.SubCuenta3,
  'Debe' = r.Debe,
  'Haber' = r.Haber,
  'Neto' = ISNULL(r.Debe, 0.0)-ISNULL(r.Haber, 0.0),
  'ContID' = r.ID,
  'ContRID' = r.RID,
  --'ContUEN' = p.UEN,
  --'ContProyecto' = p.Proyecto,
  'ContConcepto' = ISNULL(r.Concepto, p.Concepto),
  'ContReferencia' = p.Referencia,
  'ContMov' = p.Mov,
  'ContMovID' = p.MovID,
  'ContEstatus'= p.Estatus,
  'OrigenEmpresa' = p.OrigenEmpresa,
  'TipoPresupuesto' = CASE WHEN mt.Clave = 'CONT.PR' THEN 'Presupuesto' ELSE 'Real' END,
  p.Intercompania,
  r.Modulo,
  'ID' = r.ModuloID,
  m.Mov,
  m.MovID,
  m.MovTipo,
  'Empresa' =  r.Empresa,
  'Sucursal' = p.Sucursal,
  'FechaEmision' = m.FechaEmision,
  'FechaContable' = p.FechaContable,
  p.Ejercicio,
  p.Periodo,
  'Renglon' = r.ModuloRenglon,
  'RenglonSub' = r.ModuloRenglonSub,
  d.RenglonID,
  d.RenglonTipo,
  'Contacto' = ISNULL(r.ContactoEspecifico, ISNULL(d.Contacto, m.Contacto)),
  'ContactoTipo' = ISNULL(d.CtoTipo, m.CtoTipo),
  'ContactoSubTipo' = dbo.fnContactoNivel(ISNULL(d.CtoTipo, m.CtoTipo), ISNULL(r.ContactoEspecifico, ISNULL(d.Contacto, m.Contacto)), 'SUB TIPO'),
  'ContactoEnviarA' = m.EnviarA,
  m.Estatus,
  m.Situacion,
  /*m.SituacionFecha,
  m.SituacionUsuario,
  m.SituacionNota, */
  'Proyecto' = ISNULL(d.Proyecto, m.Proyecto),
  'Actividad' = d.Actividad, 
  'Concepto' = ISNULL(d.Concepto, m.Concepto),
  'Referencia' = ISNULL(d.Referencia, m.Referencia),
  m.Usuario,
  m.Clase,
  m.SubClase,
  m.Causa,
  m.FormaEnvio,
  m.Condicion,
  m.ZonaImpuesto,
  m.CtaDinero,
  m.Cajero,
  m.Moneda,
  m.TipoCambio,
  m.Deudor,
  m.Acreedor,
  d.UEN,
  'Personal' = ISNULL(d.Personal, m.Personal),
  d.Almacen,
  d.Codigo,
  d.Articulo,
  d.SubCuenta,
  d.Cantidad,
  d.Unidad,
  d.Factor,
  d.CantidadInventario,
  d.Costo,
  d.CostoInv,
  d.CostoActividad,
  d.Precio,
  d.DescuentoTipo,
  d.DescuentoLinea,
  d.DescuentoImporte,
  d.Impuesto1,
  d.Impuesto2,
  d.Impuesto3,
  d.Retencion1,
  d.Retencion2,
  d.Retencion3,
  --d.DescripcionExtra,
  --d.Paquete,
  d.ContUso,
  d.Comision,
/*  d.Aplica,
  d.AplicaID,
  d.DestinoTipo,
  d.Destino,
  d.DestinoID,*/
--  d.Cliente,
  d.FormaPago,
  'Agente' = ISNULL(d.Agente, m.Agente),
  d.Departamento,
  d.Espacio,
  --d.Estado,
  d.AFArticulo,
  d.AFSerie,
  d.ObligacionFiscal,
  d.Tasa
  --d.CostoUEPS,
  --d.CostoPEPS,
  --d.UltimoCosto,
  --d.PrecioLista,
  --d.Posicion,
  --d.DepartamentoDetallista,
  --d.SerieLote,
  --d.Producto,
  --d.SubProducto,
  --d.Merma,
  --d.Desperdicio,
  --d.Tipo,
  --d.Ruta,
  --d.Fecha,
  --d.Importe,
  --d.Porcentaje,
  --d.Impuestos,
  --d.Provision,
  --d.Depreciacion,
  --d.DescuentoRecargos,
  --d.InteresesOrdinarios,
  --d.InteresesMoratorios

FROM ContReg r
JOIN Cont p ON p.ID = r.ID AND p.Estatus = 'CONCLUIDO'
LEFT OUTER JOIN MovTipo mt ON mt.Modulo = 'CONT' AND mt.Mov = p.Mov
LEFT OUTER JOIN Cta ON r.Cuenta = Cta.Cuenta
LEFT OUTER JOIN MovReg m ON m.Modulo = r.Modulo AND m.ID = r.ModuloID
LEFT OUTER JOIN MovDReg d ON d.Modulo = r.Modulo AND d.ID = r.ModuloID AND d.Renglon = r.ModuloRenglon AND ISNULL(d.RenglonSub, 0) = ISNULL(r.ModuloRenglonSub, 0)
GO
-- select top 100 * from contDW
-- ContD

/**************************** fnCtaDetalle ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetalle') and type in ('fn','tf')) drop function dbo.fnCtaDetalle
GO
CREATE FUNCTION fnCtaDetalle (
				@DetalleTipo		varchar(50), 
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@Cliente		varchar(10),
				@Proveedor		varchar(10),
				@Personal		varchar(10),
				@Agente			varchar(10),
				@UEN			int,
				@Almacen		varchar(10),
				@Sucursal		int,
				@Articulo		varchar(20),
				@Opcion			varchar(50),
				@Espacio		varchar(10),
				@Proyecto		varchar(50),
				@Actividad		varchar(20)
)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = NULL
  SELECT @Resultado = 
  CASE @DetalleTipo	
    WHEN 'Contacto'		THEN @Contacto
    WHEN 'Cliente'		THEN @Cliente
    WHEN 'Proveedor'		THEN @Proveedor
    WHEN 'Personal'		THEN @Personal
    WHEN 'Agente'		THEN @Agente
    WHEN 'UEN'			THEN CONVERT(varchar, @UEN)
    WHEN 'Almacen'		THEN @Almacen
    WHEN 'Sucursal'		THEN CONVERT(varchar, @Sucursal)
    WHEN 'Articulo'		THEN @Articulo
    WHEN 'Opcion'		THEN @Opcion
    WHEN 'Espacio'		THEN @Espacio
    WHEN 'Proyecto'		THEN @Proyecto
    WHEN 'Actividad'		THEN @Actividad
  END

  RETURN (@Resultado)
END
GO

/**************************** fnCtaDetalleNombre ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetalleNombre') and type in ('fn','tf')) drop function dbo.fnCtaDetalleNombre
GO
CREATE FUNCTION fnCtaDetalleNombre (
				@DetalleTipo		varchar(50), 
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@ClienteNombre		varchar(100),
				@ProveedorNombre	varchar(100),
				@PersonalNombre		varchar(100),
				@AgenteNombre		varchar(100),
				@UENNombre		varchar(100),
				@AlmacenNombre		varchar(100),
				@SucursalNombre		varchar(100),
				@ArticuloNombre		varchar(100),
				@Opcion			varchar(100),
				@EspacioNombre		varchar(100),
				@Proyecto		varchar(50),
				@Actividad		varchar(20)
)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = NULL, 
         @ClienteNombre     = NULLIF(RTRIM(@ClienteNombre), ''),
         @ProveedorNombre   = NULLIF(RTRIM(@ProveedorNombre), ''),
         @PersonalNombre    = NULLIF(RTRIM(@PersonalNombre), ''),
         @AgenteNombre      = NULLIF(RTRIM(@AgenteNombre), ''),
         @AlmacenNombre     = NULLIF(RTRIM(@AlmacenNombre), ''),
         @SucursalNombre    = NULLIF(RTRIM(@SucursalNombre), ''),
         @UENNombre         = NULLIF(RTRIM(@UENNombre), ''),
         @ArticuloNombre    = NULLIF(RTRIM(@ArticuloNombre), ''),
         @EspacioNombre     = NULLIF(RTRIM(@EspacioNombre), '')

  SELECT @Resultado = 

  CASE @DetalleTipo
    WHEN 'Contacto'		THEN dbo.fnContactoNivel (@ContactoTipo, @Contacto, 'Nombre')
    WHEN 'Cliente'		THEN @ClienteNombre
    WHEN 'Proveedor'		THEN @ProveedorNombre
    WHEN 'Personal'		THEN @PersonalNombre
    WHEN 'Agente'		THEN @AgenteNombre
    WHEN 'UEN'			THEN @UENNombre
    WHEN 'Almacen'		THEN @AlmacenNombre
    WHEN 'Sucursal'		THEN @SucursalNombre
    WHEN 'Articulo'		THEN @ArticuloNombre
    WHEN 'Opcion'		THEN @Opcion
    WHEN 'Espacio'		THEN @EspacioNombre
    WHEN 'Proyecto'		THEN @Proyecto
    WHEN 'Actividad'		THEN @Actividad
  END

  RETURN (@Resultado)
END
GO

/**************************** fnCtaDetalleRFC ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetalleRFC') and type in ('fn','tf')) drop function dbo.fnCtaDetalleRFC
GO
CREATE FUNCTION fnCtaDetalleRFC (
				@DetalleTipo		varchar(50), 
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@ClienteRFC		varchar(100),
				@ProveedorRFC		varchar(100),
				@PersonalRFC		varchar(100),
				@AgenteRFC		varchar(100)
)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = NULL, 
         @ClienteRFC     = NULLIF(RTRIM(@ClienteRFC), ''),
         @ProveedorRFC   = NULLIF(RTRIM(@ProveedorRFC), ''),
         @PersonalRFC    = NULLIF(RTRIM(@PersonalRFC), ''),
         @AgenteRFC      = NULLIF(RTRIM(@AgenteRFC), '')

  SELECT @Resultado = 

  CASE @DetalleTipo
    WHEN 'Contacto'		THEN dbo.fnContactoNivel (@ContactoTipo, @Contacto, 'RFC')
    WHEN 'Cliente'		THEN @ClienteRFC
    WHEN 'Proveedor'		THEN @ProveedorRFC
    WHEN 'Personal'		THEN @PersonalRFC
    WHEN 'Agente'		THEN @AgenteRFC
  END

  RETURN (@Resultado)
END
GO

/**************************** fnCtaDetalleTipo ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetalleTipo') and type in ('fn','tf')) drop function dbo.fnCtaDetalleTipo
GO
CREATE FUNCTION fnCtaDetalleTipo (
				@DetalleTipo		varchar(50), 
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@ClienteTipo		varchar(20),
				@ProveedorTipo		varchar(20),
				@PersonalTipo		varchar(20),
				@AgenteTipo		varchar(20),
				@AlmacenTipo		varchar(20),
				@ArticuloTipo		varchar(20),
				@EspacioTipo		varchar(20)
)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = NULL

  SELECT @Resultado = 

  CASE @DetalleTipo
    WHEN 'Contacto'		THEN dbo.fnContactoNivel (@ContactoTipo, @Contacto, 'Sub Tipo')
    WHEN 'Cliente'		THEN @ClienteTipo
    WHEN 'Proveedor'		THEN @ProveedorTipo
    WHEN 'Personal'		THEN @PersonalTipo
    WHEN 'Agente'		THEN @AgenteTipo
    WHEN 'Almacen'		THEN @AlmacenTipo
    WHEN 'Articulo'		THEN @ArticuloTipo
    WHEN 'Espacio'		THEN @EspacioTipo
  END

  RETURN (@Resultado)
END
GO

/**************************** fnCtaDetalleCategoria ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetalleCategoria') and type in ('fn','tf')) drop function dbo.fnCtaDetalleCategoria
GO
CREATE FUNCTION fnCtaDetalleCategoria (
				@DetalleTipo		varchar(50),
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@ClienteCategoria	varchar(50),
				@ProveedorCategoria	varchar(50),
				@PersonalCategoria	varchar(50),
				@AgenteCategoria	varchar(50),
				@AlmacenCategoria	varchar(50),
				@ArticuloCategoria	varchar(50)
)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = 

  CASE @DetalleTipo
    WHEN 'Contacto'		THEN dbo.fnContactoNivel (@ContactoTipo, @Contacto, 'Categoria')
    WHEN 'Cliente'	THEN @ClienteCategoria
    WHEN 'Proveedor'	THEN @ProveedorCategoria
    WHEN 'Personal'	THEN @PersonalCategoria
    WHEN 'Agente'	THEN @AgenteCategoria
    WHEN 'Almacen'	THEN @AlmacenCategoria
    WHEN 'Articulo'	THEN @ArticuloCategoria
  END

  RETURN (@Resultado)
END
GO

/**************************** fnCtaDetalleGrupo ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetalleGrupo') and type in ('fn','tf')) drop function dbo.fnCtaDetalleGrupo
GO
CREATE FUNCTION fnCtaDetalleGrupo (
				@DetalleTipo		varchar(50), 
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@ClienteGrupo		varchar(50),
				@PersonalGrupo		varchar(50),
				@AgenteGrupo		varchar(50),
				@AlmacenGrupo		varchar(50),
				@ArticuloGrupo		varchar(50)
)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = NULL
  SELECT @Resultado = 

  CASE @DetalleTipo
    WHEN 'Contacto'		THEN dbo.fnContactoNivel (@ContactoTipo, @Contacto, 'Grupo')
    WHEN 'Cliente'		THEN @ClienteGrupo
    WHEN 'Personal'		THEN @PersonalGrupo
    WHEN 'Agente'		THEN @AgenteGrupo
    WHEN 'Almacen'		THEN @AlmacenGrupo
    WHEN 'Articulo'		THEN @ArticuloGrupo
  END

  RETURN (@Resultado)
END
GO

/**************************** fnCtaDetalleFamilia ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetalleFamilia') and type in ('fn','tf')) drop function dbo.fnCtaDetalleFamilia
GO
CREATE FUNCTION fnCtaDetalleFamilia (
				@DetalleTipo		varchar(50), 
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@ClienteFamilia		varchar(50),
				@ProveedorFamilia	varchar(50),
				@ArticuloFamilia	varchar(50)
)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = NULL
  SELECT @Resultado = 

  CASE @DetalleTipo
    WHEN 'Contacto'		THEN dbo.fnContactoNivel (@ContactoTipo, @Contacto, 'Familia')
    WHEN 'Cliente'		THEN @ClienteFamilia
    WHEN 'Proveedor'		THEN @ProveedorFamilia
    WHEN 'Articulo'		THEN @ArticuloFamilia
  END

  RETURN (@Resultado)
END
GO

/**************************** fnCtaDetallePuesto ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetallePuesto') and type in ('fn','tf')) drop function dbo.fnCtaDetallePuesto
GO
CREATE FUNCTION fnCtaDetallePuesto (
				@DetalleTipo		varchar(50), 
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@PersonalPuesto		varchar(50)

)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = NULL

  SELECT @Resultado = 

  CASE @DetalleTipo
    WHEN 'Contacto'		THEN dbo.fnContactoNivel (@ContactoTipo, @Contacto, 'Puesto')
    WHEN 'Personal'		THEN @PersonalPuesto
  END

  RETURN (@Resultado)
END
GO

/**************************** fnCtaDetalleDepartamento ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetalleDepartamento') and type in ('fn','tf')) drop function dbo.fnCtaDetalleDepartamento
GO
CREATE FUNCTION fnCtaDetalleDepartamento (
				@DetalleTipo		varchar(50), 
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@PersonalDepartamento	varchar(50)

)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = NULL

  SELECT @Resultado = 

  CASE @DetalleTipo
    WHEN 'Contacto'		THEN dbo.fnContactoNivel (@ContactoTipo, @Contacto, 'Departamento')
    WHEN 'Personal'	THEN @PersonalDepartamento
  END

  RETURN (@Resultado)
END
GO

/**************************** fnCtaDetalleCategoriaAF ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetalleCategoriaAF') and type in ('fn','tf')) drop function dbo.fnCtaDetalleCategoriaAF
GO
CREATE FUNCTION fnCtaDetalleCategoriaAF (
				@DetalleTipo		varchar(50), 
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@ArticuloCategoriaAF	varchar(50)

)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = NULL

  SELECT @Resultado = 

  CASE @DetalleTipo
    WHEN 'Articulo'	THEN @ArticuloCategoriaAF
  END

  RETURN (@Resultado)
END
GO

/**************************** fnCtaDetalleRegion ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetalleRegion') and type in ('fn','tf')) drop function dbo.fnCtaDetalleRegion
GO
CREATE FUNCTION fnCtaDetalleRegion (
				@DetalleTipo		varchar(50), 
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@SucursalRegion		varchar(50)

)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = NULL

  SELECT @Resultado = 

  CASE @DetalleTipo
    WHEN 'Sucursal'		THEN @SucursalRegion
  END

  RETURN (@Resultado)
END
GO


/**************************** fnCtaDetallePais ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaDetallePais') and type in ('fn','tf')) drop function dbo.fnCtaDetallePais
GO
CREATE FUNCTION fnCtaDetallePais (
				@DetalleTipo		varchar(50), 
				@ContactoTipo		varchar(20),
				@Contacto		varchar(10),

				@SucursalPais		varchar(50)

)
RETURNS varchar(255)
AS BEGIN		
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = NULL

  SELECT @Resultado = 

  CASE @DetalleTipo
    WHEN 'Sucursal'		THEN @SucursalPais
  END

  RETURN (@Resultado)
END
GO

/*** CuboContDW ***/
if exists (select * from sysobjects where id = object_id('dbo.CuboContDW') and type = 'V') drop view dbo.CuboContDW
GO
CREATE VIEW CuboContDW
--//WITH ENCRYPTION
AS 
SELECT
  ContDW.Empresa,
  ContDW.Cuenta,
  ContDW.Mayor,
  ContDW.CentroCostos,
  ContDW.Debe,
  ContDW.Haber,
  ContDW.Neto,
  ContDW.ContConcepto,
  ContDW.ContReferencia,
  ContDW.ContMov,
  ContDW.ContMovID,
  ContDW.OrigenEmpresa,
  ContDW.TipoPresupuesto,
  ContDW.Intercompania,
  ContDW.Modulo,
  ContDW.ID,
  ContDW.Mov,
  ContDW.MovID,
  ContDW.Sucursal,
  ContDW.FechaEmision,
  ContDW.FechaContable,
  ContDW.Ejercicio,
  ContDW.Periodo,
  ContDW.ContactoTipo,
  ContDW.Contacto,
  ContDW.ContactoEnviarA,
  ContDW.Estatus,
  ContDW.Situacion,
  ContDW.Proyecto,
  ContDW.Actividad,
  ContDW.Concepto,
  ContDW.Referencia,
  ContDW.Usuario,
  ContDW.Clase,
  ContDW.SubClase,
  ContDW.Causa,
  ContDW.FormaEnvio,
  ContDW.Condicion,
  ContDW.ZonaImpuesto,
  ContDW.CtaDinero,
  ContDW.Cajero,
  ContDW.Moneda,
  ContDW.TipoCambio,
  ContDW.Deudor,
  ContDW.Acreedor,
  ContDW.UEN,
  ContDW.Personal,
  ContDW.Almacen,
  ContDW.Codigo,
  ContDW.Articulo,
  ContDW.SubCuenta,
  ContDW.Cantidad,
  ContDW.Unidad,
  ContDW.Costo,
  ContDW.Precio,
  ContDW.DescuentoLinea,
  ContDW.Impuesto1,
  ContDW.Impuesto2,
  ContDW.Retencion1,
  ContDW.Retencion2,
  ContDW.ContUso,
  ContDW.Comision,
  ContDW.FormaPago,
  ContDW.Agente,
  ContDW.AFArticulo,
  ContDW.AFSerie,
  ContDW.ObligacionFiscal,
  ContDW.Tasa,

  'Detalle' = dbo.fnCtaDetalle (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Cte.Cliente, Prov.Proveedor, Personal.Personal, Agente.Agente, UEN.UEN, Alm.Almacen, Sucursal.Sucursal, Art.Articulo, ContDW.SubCuenta, Espacio.Espacio, ContDW.Proyecto, ContDW.Actividad),
  'DetalleNombre' = dbo.fnCtaDetalleNombre (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Cte.Nombre, Prov.Nombre, Personal.Nombre, Agente.Nombre, UEN.Nombre, Alm.Nombre, Sucursal.Nombre, Art.Descripcion1, ContDW.SubCuenta, Espacio.Nombre, ContDW.Proyecto, ContDW.Actividad),
  'DetalleRFC' = dbo.fnCtaDetalleRFC (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Cte.RFC, Prov.RFC, Personal.Registro, Agente.RFC),
  'DetalleTipo' = dbo.fnCtaDetalleTipo (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Cte.Tipo, Prov.Tipo, Personal.Tipo, Agente.Tipo, Alm.Tipo, Art.Tipo, Espacio.Tipo),
  'DetalleCategoria' = dbo.fnCtaDetalleCategoria (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Cte.Categoria, Prov.Categoria, Personal.Categoria, Agente.Categoria, Alm.Categoria, Art.Categoria),
  'DetalleCategoriaAF' = dbo.fnCtaDetalleCategoriaAF (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Art.CategoriaActivoFijo),
  'DetalleGrupo' = dbo.fnCtaDetalleGrupo (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Cte.Grupo, Personal.Grupo, Agente.Grupo, Alm.Grupo, Art.Grupo),
  'DetalleFamilia' = dbo.fnCtaDetalleFamilia (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Cte.Familia, Prov.Familia, Art.Familia),
  'DetallePuesto' = dbo.fnCtaDetallePuesto (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Personal.Puesto),
  'DetalleDepartamento' = dbo.fnCtaDetalleDepartamento (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Personal.Departamento),
  'DetalleRegion' = dbo.fnCtaDetalleRegion (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Sucursal.Region),
  'DetallePais' = dbo.fnCtaDetallePais (ContDW.DetalleTipo, ContDW.ContactoTipo, ContDW.Contacto, Sucursal.Pais),

  'ClienteNombre' = Cte.Nombre,
  'ClienteTipo' = Cte.Tipo,
  'ClienteCategoria' = Cte.Categoria,
  'ClienteFamilia' = Cte.Familia,
  'ClienteGrupo' = Cte.Grupo,
  'ProveedorNombre' = Prov.Nombre,
  'ProveedorTipo' = Prov.Tipo,
  'ProveedorCategoria' = Prov.Categoria,
  'ProveedorFamilia' = Prov.Familia,
  'PersonalNombre' = ISNULL(Personal.ApellidoPaterno, '')+ ' ' + ISNULL(Personal.ApellidoMaterno, '')+ ' ' + ISNULL(Personal.Nombre, ''),
  'PersonalTipo' = Personal.Tipo,
  'PersonalDepartamento' = Personal.Departamento,
  'PersonalGrupo' = Personal.Grupo,
  'PersonalPuesto' = Personal.Puesto,
  'PersonalCategoria' = Personal.Categoria,
  'ArticuloDescripcion' = Art.Descripcion1,
  'ArticuloTipo' = Art.Tipo,
  'ArticuloGrupo' = Art.Grupo,
  'ArticuloCategoria' = Art.Categoria,
  'ArticuloCategoriaActivoFijo' = Art.CategoriaActivoFijo,
  'ArticuloFamilia' = Art.Familia,
  'ArticuloFabricante' = Art.Fabricante,
  'ArticuloLinea' = Art.Linea,
--  'CuentaDescripcion' = Cta.Descripcion,
--  'MayorDescripcion' = Mayor.Descripcion,
--  'MayorRama' = Mayor.Rama,
--  'MayorRamaDescripcion' = MayorRama.Descripcion,
  'UENNombre' = UEN.Nombre,
  'AlmacenNombre' = Alm.Nombre,
  'AlmacenCategoria' = Alm.Categoria,
  'AlmacenGrupo' = Alm.Categoria,
  'SucursalNombre' = Sucursal.Sucursal,
  'SucursalRegion' = Sucursal.Region,
  'SucursalPais' = Sucursal.Pais,
  'AgenteNombre' = Agente.Nombre,
  'AgenteTipo' = Agente.Tipo,
  'AgenteCategoria' = Agente.Categoria,
  'AgenteGrupo' = Agente.Grupo,
  'AgenteFamilia' = Agente.Familia,
  'EspacioNombre' = Espacio.Nombre,
  'EspacioTipo' = Espacio.Tipo
 
FROM
  ContDW
  LEFT OUTER JOIN Cte ON ContDW.Deudor=Cte.Cliente
  LEFT OUTER JOIN Prov ON ContDW.Acreedor=Prov.Proveedor
  LEFT OUTER JOIN Personal ON ContDW.Personal=Personal.Personal
  LEFT OUTER JOIN Art ON ContDW.Articulo=Art.Articulo
  LEFT OUTER JOIN Cta ON ContDW.Cuenta=Cta.Cuenta
--  LEFT OUTER JOIN Cta Mayor ON ContDW.Mayor=Mayor.Cuenta
--  LEFT OUTER JOIN Cta MayorRama ON Mayor.Rama=MayorRama.Cuenta
  LEFT OUTER JOIN UEN ON ContDW.UEN=UEN.UEN
  LEFT OUTER JOIN Alm ON ContDW.Almacen=Alm.Almacen
  LEFT OUTER JOIN Sucursal ON ContDW.Sucursal=Sucursal.Sucursal
  LEFT OUTER JOIN Agente ON ContDW.Agente=Agente.Agente
  LEFT OUTER JOIN Espacio ON ContDW.Espacio=Espacio.Espacio
GO

/*** ContDWSaldoModulo ***/
if exists (select * from sysobjects where id = object_id('dbo.ContDWSaldoModulo') and type = 'V') drop view dbo.ContDWSaldoModulo
GO
CREATE VIEW ContDWSaldoModulo
--//WITH ENCRYPTION
AS 
SELECT
  Empresa,
  Cuenta,
  Mayor,
  CentroCostos,
  ContactoTipo,
  Contacto,
  ContactoEnviarA,
  Deudor,
  Acreedor,
  'Debe' = SUM(Debe),
  'Haber' = SUM(Haber),
  'Neto' = SUM(Neto),
  'SaldoModulo' = dbo.fnContactoSaldoMN(Empresa,  ContactoTipo, Contacto)

FROM ContDW
GROUP BY Empresa, Cuenta,  Mayor,  CentroCostos,  ContactoTipo,  Contacto,  ContactoEnviarA,  Deudor,  Acreedor
GO

/* ProyectoDArtMaterialExplotado */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.ProyectoDArtMaterialExplotado'))
DROP VIEW ProyectoDArtMaterialExplotado
GO
CREATE VIEW ProyectoDArtMaterialExplotado
AS
SELECT
  pdam.ID,
  pdam.Actividad, 
  CASE a.EsFormula WHEN 0 THEN pdam.Material ELSE am.Material END Material,
  CASE a.EsFormula WHEN 0 THEN ISNULL(pdam.SubCuenta,'') ELSE ISNULL(am.SubCuenta,'') END SubCuenta, 
  CASE a.EsFormula WHEN 0 THEN ISNULL(pdam.Cantidad,0.0) ELSE ISNULL(pdam.Cantidad,0.0)*ISNULL(am.Cantidad,0.0) END Cantidad, 
  CASE a.EsFormula WHEN 0 THEN pdam.Unidad ELSE am.Unidad END Unidad,
  CASE a.EsFormula WHEN 0 THEN pdam.Almacen ELSE am.Almacen END Almacen, 
  a.EsFormula
  FROM ProyectoDArtMaterial pdam JOIN Art a 
    ON a.Articulo = pdam.Material LEFT OUTER JOIN ArtMaterial am
    ON a.Articulo = am.Articulo
 WHERE PATINDEX('%' + ISNULL(am.SiOpcion,'') + '%',ISNULL(pdam.SubCuenta,'')) > 0
GO

/* ProyectoDArtMaterialIdAlm */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.ProyectoDArtMaterialIdAlm'))
DROP VIEW ProyectoDArtMaterialIdAlm
GO
CREATE VIEW ProyectoDArtMaterialIDAlm
AS
SELECT
  DISTINCT 
  ID,
  Almacen
FROM ProyectoDArtMaterialExplotado
GO

/* ProyectoDArtMaterialIdActAlm */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.ProyectoDArtMaterialIdActAlm'))
DROP VIEW ProyectoDArtMaterialIdActAlm
GO
CREATE VIEW ProyectoDArtMaterialIdActAlm
AS
SELECT
  DISTINCT 
  ID,
  Actividad,
  Almacen
FROM ProyectoDArtMaterialExplotado
GO


/* ProyectoDSolicitudPendiente */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.ProyectoDSolicitudPendiente'))
DROP VIEW ProyectoDSolicitudPendiente
GO
CREATE VIEW ProyectoDSolicitudPendiente
AS
SELECT
  mf.Empresa Empresa,
  mf.OID ProyectoID,
  mf.OMov ProyectoMov,
  mf.OMovID ProyectoMovID,
  i.ID SolicitudID,
  i.Mov SolicitudMov,
  i.MovID SolicitudMovID,
  i.Proyecto Proyecto,
  i.Actividad Actividad,
  i.Estatus Estatus
  FROM MovFlujo mf JOIN Inv i
    ON i.ID = mf.DID JOIN MovTipo mt
    ON mt.Mov = i.Mov AND mt.Modulo = 'INV' JOIN EmpresaCfgMov ecm
    ON ecm.InvSolicitud = mt.Mov AND mf.Empresa = ecm.Empresa
 WHERE mf.DModulo = 'INV' 
   AND mf.OModulo = 'PROY'
   AND i.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND mt.Clave = 'INV.SOL'
GO


-- select * from ProyectoDEnFirme
/*** ProyectoDEnFirme ***/
if exists (select * from sysobjects where id = object_id('dbo.ProyectoDEnFirme') and type = 'V') drop view dbo.ProyectoDEnFirme
GO
CREATE VIEW ProyectoDEnFirme
--//WITH ENCRYPTION
AS 
SELECT
  d.ID,
  d.Actividad,
  d.Predecesora,
  d.Orden,
  d.EsFase,
  d.Asunto,
  d.Tipo,
  d.Categoria,
  d.Grupo,
  d.Familia,
  d.Duracion,
  d.DuracionUnidad,
  d.DuracionDias,
  d.Usuario,
  d.UltimoCambio,
  d.Comienzo,
  d.Fin,
  d.Estado,
  d.Avance,
  d.Prioridad,
  d.Proyecto,
  d.EstaLiberado,
  d.FechaLiberacion,
  d.TieneMovimientos,
  d.Sucursal,
  d.EsNuevo

FROM 
  ProyectoD d
JOIN 
  Proyecto p ON p.ID = d.ID AND p.Estatus IN ('PENDIENTE', 'CONCLUIDO')
GO


/****************** ProyectoCteCto ************/
if exists (select * from sysobjects where id = object_id('dbo.ProyectoCteCto') and type = 'v') drop view ProyectoCteCto
GO
CREATE VIEW ProyectoCteCto
AS
SELECT
  'Contacto' = ISNULL(RTRIM(Nombre), '') + ' ' + ISNULL(RTRIM(ApellidoPaterno), '') + ' ' + ISNULL(RTRIM(ApellidoMaterno), ''),
  Cliente,
  Telefonos,
  eMail
FROM
  CteCto
GO


/*** VerAnexo ***/
if exists (select * from sysobjects where id = object_id('dbo.VerAnexo') and type = 'V') drop view dbo.VerAnexo
GO
CREATE VIEW VerAnexo
--//WITH ENCRYPTION
AS 
SELECT 'AnexoTipo'='Movimiento', 
       'Modulo' = a.Rama, 
       'ModuloID' = a.ID, 
       'Mov' = m.Mov,
       'MovID' = m.MovID,
       'Catalogo'=CONVERT(varchar, NULL), 
       'Cuenta' = CONVERT(varchar, NULL), 
       'CuentaNombre' = CONVERT(varchar, NULL), 
        a.IDR, a.Nombre, a.Direccion, a.Icono, a.Tipo, a.Orden, a.Comentario, a.Origen, a.Destino, a.Fecha, a.FechaEmision, a.Vencimiento, a.TipoDocumento, a.Inicio, a.Alta, a.UltimoCambio, a.Usuario, a.NivelAcceso, a.Categoria, a.Grupo, a.Familia
  FROM AnexoMov a
  JOIN Mov m ON m.Modulo = a.Rama AND m.ID = a.ID
UNION ALL
SELECT 'AnexoTipo'='Cuenta', 
       'Modulo' = CONVERT(varchar, NULL), 
       'ModuloID' = CONVERT(int, NULL), 
       'Mov' = CONVERT(varchar, NULL), 
       'MovID' = CONVERT(varchar, NULL), 
       'Catalogo' = dbo.fnRamaCatalogo(Rama),
       Cuenta, 
       'CuentaNombre' = dbo.fnContactoNivel(dbo.fnRamaCatalogo(Rama),Cuenta, 'Nombre'),
       IDR, Nombre, Direccion, Icono, Tipo, Orden, Comentario, Origen, Destino, Fecha, FechaEmision, Vencimiento, TipoDocumento, Inicio, Alta, UltimoCambio, Usuario, NivelAcceso, Categoria, Grupo, Familia
  FROM AnexoCta
GO

-- select * from VerAnexo
-- select estatus from mov

SET ANSI_NULLS OFF
GO
/**************** fnFlujoTesoreriaSituacion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFlujoTesoreriaSituacion') DROP FUNCTION fnFlujoTesoreriaSituacion
GO
CREATE FUNCTION fnFlujoTesoreriaSituacion (@Modulo varchar(5), @Vencimiento datetime, @Hoy datetime)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(50)

  SELECT @Resultado = ''
  IF @Modulo = 'DIN' SELECT @Resultado = @Resultado + 'en Efectivo' 
  ELSE BEGIN
    IF @Modulo = 'LC' SELECT @Resultado = @Resultado + 'Credito ' 
    IF @Vencimiento < @Hoy SELECT @Resultado = @Resultado + 'Vencido' ELSE SELECT @Resultado = @Resultado + 'Vigente'
    IF @Modulo = 'CXC' SELECT @Resultado = @Resultado + ' por Cobrar' ELSE
    IF @Modulo = 'CXP' SELECT @Resultado = @Resultado + ' por Pagar'
  END
  RETURN (@Resultado)
END
GO


/**************** fnLCDisposiciones ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnLCDisposiciones') DROP FUNCTION fnLCDisposiciones
GO
CREATE FUNCTION fnLCDisposiciones (@LineaCredito varchar(20))
RETURNS money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	money,
    @Uso	varchar(20)

  SELECT @Resultado = NULL
  SELECT @Uso = UPPER(Uso) FROM LC WHERE LineaCredito = @LineaCredito
  IF @Uso = 'FONDEO'     SELECT @Resultado = SUM(Importe) FROM Cxp WHERE LineaCredito=@LineaCredito AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND RamaID IS NOT NULL ELSE
  IF @Uso = 'COLOCACION' SELECT @Resultado = SUM(Importe) FROM Cxc WHERE LineaCredito=@LineaCredito AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND RamaID IS NOT NULL 
  RETURN (ISNULL(@Resultado, 0.0))
END
GO

/****** spVerFlujoTesoreria *****/
if exists (select * from sysobjects where id = object_id('dbo.spVerFlujoTesoreria') and type = 'P') drop procedure dbo.spVerFlujoTesoreria
GO
CREATE PROCEDURE spVerFlujoTesoreria
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Hoy	datetime
  SELECT @Hoy = dbo.fnFechaSinHora(GETDATE())

  CREATE TABLE #FlujoTesoreria
  (
	RID			int		IDENTITY(1,1) NOT NULL PRIMARY KEY,

	Empresa			varchar(5)	NULL,
	Modulo			varchar(5)	NULL,
	ID			int		NULL,
	Mov			varchar(20)	NULL,
	MovID			varchar(20)	NULL,
	CtaDinero		varchar(10)	NULL,
	LineaCredito		varchar(20)	NULL,
	Contacto		varchar(10)	NULL,
	ContactoTipo		varchar(20)	NULL,
	ContactoSubTipo		varchar(20)	NULL,
	ContactoNombre		varchar(100)	NULL,
	ContactoCategoria	varchar(50)	NULL,
	ContactoGrupo		varchar(50)	NULL,
	ContactoFamilia		varchar(50)	NULL,
	FechaEmision		datetime	NULL,
	Vencimiento		datetime	NULL,
	Concepto		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,
	Proyecto		varchar(50)	NULL,
	UEN			int		NULL,
	Cargo			money		NULL,
	Abono			money		NULL,
	Moneda			varchar(10)	NULL,
  )

  -- Saldo en Efectivo
  INSERT #FlujoTesoreria (
         Modulo, Empresa,   CtaDinero,   Cargo,   Moneda,   FechaEmision, Vencimiento)
  SELECT 'DIN',  s.Empresa, s.CtaDinero, s.Saldo, s.Moneda, @Hoy,         @Hoy
    FROM DineroSaldo s 

  -- Creditos Fondeo Pendientes
  INSERT #FlujoTesoreria (
         Modulo, Empresa, LineaCredito, Cargo,                                       Moneda, FechaEmision,  Vencimiento)
  SELECT 'LC',   Empresa, LineaCredito, Importe-dbo.fnLCDisposiciones(LineaCredito), Moneda, VigenciaDesde, VigenciaHasta
    FROM LC
   WHERE Uso = 'Fondeo' AND Estatus = 'ALTA'

  -- Cuentas por Cobrar
  INSERT #FlujoTesoreria (
         Modulo, Empresa,   Mov,   MovID,   FechaEmision,   Vencimiento,   CtaDinero,   Cargo,             Moneda,   Referencia,   Concepto,   Proyecto,   UEN,   Contacto,  ContactoTipo, ContactoSubTipo, ContactoNombre, ContactoCategoria, ContactoGrupo, ContactoFamilia)
  SELECT 'CXC',  c.Empresa, c.Mov, c.MovID, c.FechaEmision, c.Vencimiento, c.CtaDinero, c.Saldo*mt.Factor, c.Moneda, c.Referencia, c.Concepto, c.Proyecto, c.UEN, c.Cliente, 'Cliente',     cte.Tipo,        cte.Nombre,     cte.Categoria,     cte.Grupo,     cte.Familia
    FROM Cxc c
    JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = c.Mov
    JOIN Cte ON cte.Cliente = c.Cliente
   WHERE c.Estatus = 'PENDIENTE' AND NULLIF(c.Saldo, 0.0) IS NOT NULL

  -- Cuentas por Pagar
  INSERT #FlujoTesoreria (
         Modulo, Empresa,   Mov,   MovID,   FechaEmision,   Vencimiento,   CtaDinero,   Abono,             Moneda,   Referencia,   Concepto,   Proyecto,   UEN,   Contacto,    ContactoTipo, ContactoSubTipo, ContactoNombre, ContactoCategoria, ContactoFamilia)
  SELECT 'CXP',  c.Empresa, c.Mov, c.MovID, c.FechaEmision, c.Vencimiento, c.CtaDinero, c.Saldo*mt.Factor, c.Moneda, c.Referencia, c.Concepto, c.Proyecto, c.UEN, c.Proveedor, 'Proveedor',  p.Tipo,          p.Nombre,       p.Categoria,       p.Familia
    FROM Cxp c
    JOIN MovTipo mt ON mt.Modulo = 'CXP' AND mt.Mov = c.Mov
    JOIN Prov p ON p.Proveedor = c.Proveedor
   WHERE c.Estatus = 'PENDIENTE' AND NULLIF(c.Saldo, 0.0) IS NOT NULL

  SELECT f.Empresa,
	 f.Modulo,
         'ModuloNombre' = modulo.Nombre,
	 f.ID,
	 f.Mov,
	 f.MovID,
	 f.CtaDinero,
         f.LineaCredito,
         'LineaCreditoUso' = lc.Uso,
         'LineaCreditoTipoCredito' = lc.TipoCredito,
         'LineaCreditoDescripcion' = lc.Descripcion,
	 'CtaDineroTipo' = cta.Tipo,
         'CtaDineroDescripcion' = cta.Descripcion,
	 f.Contacto,
	 f.ContactoTipo,
	 f.ContactoSubTipo,
	 f.ContactoNombre,
	 f.ContactoCategoria,
	 f.ContactoGrupo,
	 f.ContactoFamilia,
	 f.FechaEmision,
	 f.Vencimiento,
	 f.Concepto,
	 f.Referencia,
	 f.Proyecto,
	 f.UEN,
	 f.Cargo,
	 f.Abono,
	 f.Moneda,
         m.TipoCambio,
         'CargoMN' = f.Cargo*ISNULL(m.TipoCambio, 1.0),
         'AbonoMN' = f.Abono*ISNULL(m.TipoCambio, 1.0),
         'Situacion' = dbo.fnFlujoTesoreriaSituacion(f.Modulo, f.Vencimiento, @Hoy)
    FROM #FlujoTesoreria f
    LEFT OUTER JOIN Modulo on Modulo.Modulo = f.Modulo
    LEFT OUTER JOIN CtaDinero cta ON cta.CtaDinero = f.CtaDinero
    LEFT OUTER JOIN LC ON lc.LineaCredito = f.LineaCredito
    LEFT OUTER JOIN Mon m ON m.Moneda = f.Moneda
  RETURN
END
GO

-- spVerFlujoTesoreria

/***********************************************************************************************/
/**************************************   CONTROL PRESUPUESTAL *********************************/
/***********************************************************************************************/

/* CPArtComprometido */
if exists (select * from sysobjects where id = object_id('dbo.CPArtComprometido') and sysstat & 0xf = 2) drop view dbo.CPArtComprometido
GO
CREATE VIEW CPArtComprometido
--//WITH ENCRYPTION
AS
SELECT t.Empresa,
       t.Proyecto, 
       t.ClavePresupuestal, 
       t.Articulo,
       'CantidadComprometida' = SUM(t.CantidadNeta),
       'ImporteComprometido' = SUM(t.ImporteTotal)
  FROM CompraTCalc t
  JOIN MovTipo mt ON mt.Modulo = 'COMS' AND mt.Mov = t.Mov AND mt.AfectarCP = 'Comprometido'
 WHERE t.Estatus IN ('PENDIENTE', 'CONCLUIDO')
 GROUP BY t.Empresa, t.Proyecto, t.ClavePresupuestal, t.Articulo
GO

/* CPArtNetoDisponible */
if exists (select * from sysobjects where id = object_id('dbo.CPArtNetoDisponible') and sysstat & 0xf = 2) drop view dbo.CPArtNetoDisponible
GO
CREATE VIEW CPArtNetoDisponible
--//WITH ENCRYPTION
AS
SELECT n.Empresa,
       n.Proyecto, 
       n.ClavePresupuestal, 
       n.Articulo,
       n.Cantidad,
       n.Importe,
       c.CantidadComprometida,
       c.ImporteComprometido,
       'CantidadDisponible' = n.Cantidad-ISNULL(c.CantidadComprometida, 0.0),
       'ImporteDisponible' = n.Importe-ISNULL(c.ImporteComprometido, 0.0)
  FROM CPArtNeto n
  LEFT OUTER JOIN CPArtComprometido c ON c.Empresa = n.Empresa AND c.Proyecto = n.Proyecto AND c.ClavePresupuestal = n.ClavePresupuestal AND c.Articulo = n.Articulo
GO


-- select * from CPArtNetoComprometido

-- select * from CPCalMovAyuda where estacion = 1
-- spCPCalMovAyuda 1, 'DIN', 220
/**************** spCPCalMovAyuda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCPCalMovAyuda') and type = 'P') drop procedure dbo.spCPCalMovAyuda
GO
CREATE PROCEDURE spCPCalMovAyuda
		    @Estacion	int,
		    @Modulo	varchar(5),
    		    @ID         int
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @Empresa	varchar(5)
    
  DELETE CPCalMovPreAyuda WHERE Estacion = @Estacion
  
  IF @Modulo = 'COMS'
  BEGIN
     INSERT CPCalMovPreAyuda (
     	    Estacion,  ClavePresupuestal,   Importe)
     SELECT @Estacion, t.ClavePresupuestal, t.ImporteTotal

       FROM CompraTCalc t
       JOIN Art a ON a.Articulo = t.Articulo
      WHERE t.ID = @ID AND NULLIF(t.ClavePresupuestal, '') IS NOT NULL 
        AND NULLIF(RTRIM(a.ClavePresupuestalImpuesto1), '') IS NULL
     INSERT CPCalMovPreAyuda (
     	    Estacion,  ClavePresupuestal,   Importe)
     SELECT @Estacion, t.ClavePresupuestal, t.SubTotal
       FROM CompraTCalc t
       JOIN Art a ON a.Articulo = t.Articulo
      WHERE t.ID = @ID AND NULLIF(t.ClavePresupuestal, '') IS NOT NULL 
        AND NULLIF(RTRIM(a.ClavePresupuestalImpuesto1), '') IS NOT NULL

     INSERT CPCalMovPreAyuda (
     	    Estacion,  ClavePresupuestal,            Importe)
     SELECT @Estacion, a.ClavePresupuestalImpuesto1, t.Impuesto1Total
       FROM CompraTCalc t
       JOIN Art a ON a.Articulo = t.Articulo
      WHERE t.ID = @ID AND NULLIF(t.ClavePresupuestal, '') IS NOT NULL 
        AND NULLIF(RTRIM(a.ClavePresupuestalImpuesto1), '') IS NOT NULL
  END ELSE  	
  IF @Modulo = 'GAS'
  BEGIN

     INSERT CPCalMovPreAyuda (

     	    Estacion,  ClavePresupuestal,   Importe)
     SELECT @Estacion, t.ClavePresupuestal, t.TotalLinea+ISNULL(t.RetencionLinea, 0)
       FROM GastoT t
       JOIN Concepto c ON c.Modulo = @Modulo AND c.Concepto = t.Concepto 
      WHERE t.ID = @ID AND NULLIF(t.ClavePresupuestal, '') IS NOT NULL
        AND NULLIF(RTRIM(c.ClavePresupuestalImpuesto1), '') IS NULL
     INSERT CPCalMovPreAyuda (
     	    Estacion,  ClavePresupuestal,   Importe)
     SELECT @Estacion, t.ClavePresupuestal, t.ImporteLinea
       FROM GastoT t
       JOIN Concepto c ON c.Modulo = @Modulo AND c.Concepto = t.Concepto 
      WHERE t.ID = @ID AND NULLIF(t.ClavePresupuestal, '') IS NOT NULL
        AND NULLIF(RTRIM(c.ClavePresupuestalImpuesto1), '') IS NOT NULL
     INSERT CPCalMovPreAyuda (
     	    Estacion,  ClavePresupuestal,            Importe)
     SELECT @Estacion, c.ClavePresupuestalImpuesto1, t.ImpuestosLinea
       FROM GastoT t
       JOIN Concepto c ON c.Modulo = @Modulo AND c.Concepto = t.Concepto 
      WHERE t.ID = @ID AND NULLIF(t.ClavePresupuestal, '') IS NOT NULL
        AND NULLIF(RTRIM(c.ClavePresupuestalImpuesto1), '') IS NOT NULL
  END ELSE
  IF @Modulo = 'CXP'
  BEGIN
  	/* para sacar el saldo hay que sacar un factor del saldo de cxpa contra el importe */
     SELECT @Empresa = Empresa 
       FROM Cxp 
      WHERE ID = @ID
      
     INSERT CPCalMovPreAyuda (
     	    Estacion,  ClavePresupuestal,    Importe)
     SELECT @Estacion, mi.ClavePresupuestal, ISNULL(mi.SubTotal, 0.0)+ISNULL(mi.Importe1, 0.0)
       FROM CxpD d       
       JOIN Cxp a ON a.Empresa = @Empresa AND a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Estatus IN ('PENDIENTE', 'CONCLUIDO')
       JOIN MovImpuesto mi ON mi.Modulo = @Modulo AND mi.ModuloID = a.ID
      WHERE d.ID = @ID AND NULLIF(mi.ClavePresupuestal, '') IS NOT NULL AND NULLIF(mi.ClavePresupuestalImpuesto1, '') IS NULL

     INSERT CPCalMovPreAyuda (
     	    Estacion,  ClavePresupuestal,    Importe)
     SELECT @Estacion, mi.ClavePresupuestal, ISNULL(mi.SubTotal, 0.0)
       FROM CxpD d       
       JOIN Cxp a ON a.Empresa = @Empresa AND a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Estatus IN ('PENDIENTE', 'CONCLUIDO')
       JOIN MovImpuesto mi ON mi.Modulo = @Modulo AND mi.ModuloID = a.ID
      WHERE d.ID = @ID AND NULLIF(mi.ClavePresupuestal, '') IS NOT NULL AND NULLIF(mi.ClavePresupuestalImpuesto1, '') IS NOT NULL

     INSERT CPCalMovPreAyuda (
     	    Estacion,  ClavePresupuestal,             Importe)
     SELECT @Estacion, mi.ClavePresupuestalImpuesto1, ISNULL(mi.Importe1, 0.0)
       FROM CxpD d       
       JOIN Cxp a ON a.Empresa = @Empresa AND a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Estatus IN ('PENDIENTE', 'CONCLUIDO')
       JOIN MovImpuesto mi ON mi.Modulo = @Modulo AND mi.ModuloID = a.ID
      WHERE d.ID = @ID AND NULLIF(mi.ClavePresupuestalImpuesto1, '') IS NOT NULL
  END
  ELSE
  IF @Modulo = 'DIN'
  BEGIN
     SELECT @Empresa = Empresa 
       FROM Dinero
      WHERE ID = @ID
      
     INSERT CPCalMovPreAyuda (
     	    Estacion,  ClavePresupuestal,    Importe)
     SELECT @Estacion, mi.ClavePresupuestal, ISNULL(mi.SubTotal, 0.0)+ISNULL(mi.Importe1, 0.0)
       FROM DineroD d       
       JOIN Dinero a ON a.Empresa = @Empresa AND a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Estatus IN ('PENDIENTE', 'CONCLUIDO')
       JOIN MovImpuesto mi ON mi.Modulo = @Modulo AND mi.ModuloID = a.ID
      WHERE d.ID = @ID AND NULLIF(mi.ClavePresupuestal, '') IS NOT NULL AND NULLIF(mi.ClavePresupuestalImpuesto1, '') IS NULL
     INSERT CPCalMovPreAyuda (
     	    Estacion,  ClavePresupuestal,    Importe)
     SELECT @Estacion, mi.ClavePresupuestal, ISNULL(mi.SubTotal, 0.0)
       FROM DineroD d       
       JOIN Dinero a ON a.Empresa = @Empresa AND a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Estatus IN ('PENDIENTE', 'CONCLUIDO')
       JOIN MovImpuesto mi ON mi.Modulo = @Modulo AND mi.ModuloID = a.ID
      WHERE d.ID = @ID AND NULLIF(mi.ClavePresupuestal, '') IS NOT NULL AND NULLIF(mi.ClavePresupuestalImpuesto1, '') IS NOT NULL

     INSERT CPCalMovPreAyuda (
     	    Estacion,  ClavePresupuestal,             Importe)
     SELECT @Estacion, mi.ClavePresupuestalImpuesto1, ISNULL(mi.Importe1, 0.0)
       FROM DineroD d       
       JOIN Dinero a ON a.Empresa = @Empresa AND a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Estatus IN ('PENDIENTE', 'CONCLUIDO')
       JOIN MovImpuesto mi ON mi.Modulo = @Modulo AND mi.ModuloID = a.ID
      WHERE d.ID = @ID AND NULLIF(mi.ClavePresupuestalImpuesto1, '') IS NOT NULL
  END

  RETURN
END
GO


/* CPCompra */
if exists (select * from sysobjects where id = object_id('dbo.CPCompra') and sysstat & 0xf = 2) drop view dbo.CPCompra
GO
CREATE VIEW CPCompra
AS
     SELECT d.ID, d.ClavePresupuestal, Importe = SUM(d.SubTotal)
       FROM CompraTCalc d
       JOIN Art a ON a.Articulo = d.Articulo AND NULLIF(RTRIM(a.ClavePresupuestalImpuesto1), '') IS NOT NULL
      GROUP BY d.ID, d.ClavePresupuestal
     UNION ALL
     SELECT d.ID, ClavePresupuestal = a.ClavePresupuestalImpuesto1, Importe = SUM(d.Impuesto1Total)
       FROM CompraTCalc d
       JOIN Art a ON a.Articulo = d.Articulo AND NULLIF(RTRIM(a.ClavePresupuestalImpuesto1), '') IS NOT NULL
      GROUP BY d.ID, a.ClavePresupuestalImpuesto1
     UNION ALL
     SELECT d.ID, d.ClavePresupuestal, Importe = SUM(d.ImporteTotal)
       FROM CompraTCalc d
       JOIN Art a ON a.Articulo = d.Articulo AND NULLIF(RTRIM(a.ClavePresupuestalImpuesto1), '') IS NULL
      GROUP BY d.ID, d.ClavePresupuestal
GO

/* CPGasto */
if exists (select * from sysobjects where id = object_id('dbo.CPGasto') and sysstat & 0xf = 2) drop view dbo.CPGasto
GO
CREATE VIEW CPGasto
AS
     SELECT d.ID, d.ClavePresupuestal, Importe = SUM(d.ImporteLinea)
       FROM GastoT d
       JOIN Concepto c ON c.Modulo = 'GAS' AND c.Concepto = d.Concepto AND NULLIF(RTRIM(c.ClavePresupuestalImpuesto1), '') IS NOT NULL
      GROUP BY d.ID, d.ClavePresupuestal
     UNION ALL
     SELECT d.ID, ClavePresupuestal = c.ClavePresupuestalImpuesto1, Importe = SUM(d.ImpuestosLinea)
       FROM GastoT d
       JOIN Concepto c ON c.Modulo = 'GAS' AND c.Concepto = d.Concepto AND NULLIF(RTRIM(c.ClavePresupuestalImpuesto1), '') IS NOT NULL
      GROUP BY d.ID, c.ClavePresupuestalImpuesto1
     UNION ALL
     SELECT d.ID, d.ClavePresupuestal, Importe = SUM(d.TotalLinea+ISNULL(d.RetencionLinea, 0))
       FROM GastoT d
       JOIN Concepto c ON c.Modulo = 'GAS' AND c.Concepto = d.Concepto AND NULLIF(RTRIM(c.ClavePresupuestalImpuesto1), '') IS NULL
      GROUP BY d.ID, d.ClavePresupuestal
GO

/* CPMovImpuesto */
if exists (select * from sysobjects where id = object_id('dbo.CPMovImpuesto') and sysstat & 0xf = 2) drop view dbo.CPMovImpuesto
GO
CREATE VIEW CPMovImpuesto
AS
     SELECT Modulo, ModuloID, ClavePresupuestal, Importe = SUM(SubTotal)
       FROM MovImpuesto
      WHERE NULLIF(RTRIM(ClavePresupuestalImpuesto1), '') IS NOT NULL
      GROUP BY Modulo, ModuloID, ClavePresupuestal
     UNION ALL
     SELECT Modulo, ModuloID, ClavePresupuestal = ClavePresupuestalImpuesto1, Importe = SUM(Importe1)
       FROM MovImpuesto
      WHERE NULLIF(RTRIM(ClavePresupuestalImpuesto1), '') IS NOT NULL
      GROUP BY Modulo, ModuloID, ClavePresupuestalImpuesto1
     UNION ALL
     SELECT Modulo, ModuloID, ClavePresupuestal, Importe = SUM(ISNULL(SubTotal, 0.0)+ISNULL(Importe1, 0.0))
       FROM MovImpuesto
      WHERE NULLIF(RTRIM(ClavePresupuestalImpuesto1), '') IS NULL
      GROUP BY Modulo, ModuloID, ClavePresupuestal
GO

/**************** ConceptoGastoInventariable ****************/
if exists (select * from sysobjects where id = object_id('dbo.ConceptoGastoInventariable') and sysstat & 0xf = 2) drop view dbo.ConceptoGastoInventariable
GO
CREATE VIEW ConceptoGastoInventariable
AS
SELECT 
  gd.Cantidad * mt.Factor AS Cantidad,
  gd.Concepto,  
  g.Empresa,
  gd.Sucursal,
  gd.Importe  
  FROM dbo.GastoD gd JOIN dbo.Gasto g
    ON g.ID = gd.ID JOIN dbo.MovTipo mt
    ON mt.Mov = g.Mov JOIN Concepto c
    ON gd.Concepto = c.Concepto AND c.Modulo = 'GAS'
 WHERE mt.Modulo = 'GAS' 
   AND mt.Clave = 'GAS.CI'
   AND g.Estatus = 'CONCLUIDO'
GO

/**************** ConceptoGastoInventariable2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.ConceptoGastoInventariable2') and sysstat & 0xf = 2) drop view dbo.ConceptoGastoInventariable2
GO
CREATE VIEW ConceptoGastoInventariable2
AS
SELECT
  Empresa,
  Sucursal,
  Concepto,
  SUM(Cantidad) AS Cantidad,
  SUM(Importe) AS Importe
  FROM ConceptoGastoInventariable
 GROUP BY Empresa, Sucursal, Concepto
GO
   

/**************** ConceptoGastoDisponible ****************/
if exists (select * from sysobjects where id = object_id('dbo.ConceptoGastoDisponible') and sysstat & 0xf = 2) drop view dbo.ConceptoGastoDisponible
GO
CREATE VIEW ConceptoGastoDisponible
AS
SELECT
  Empresa,
  Sucursal,
  Concepto,
  Importe/Cantidad AS CostoPromedio,
  Cantidad AS Disponible
  FROM ConceptoGastoInventariable2
GO

/**************** fnSerieLoteConsignacionMov ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSerieLoteConsignacionMov') DROP FUNCTION fnSerieLoteConsignacionMov
GO
CREATE FUNCTION fnSerieLoteConsignacionMov 
	(
	@Modulo				varchar(5), 
	@ModuloID				int
	)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(20)

  IF @Modulo = 'VTAS'  SELECT @Resultado = Mov FROM Venta WHERE ID = @ModuloID ELSE
  IF @Modulo = 'COMS'  SELECT @Resultado = Mov FROM Compra WHERE ID = @ModuloID ELSE
  IF @Modulo = 'AF'    SELECT @Resultado = Mov FROM ActivoFijo WHERE ID = @ModuloID ELSE
  IF @Modulo = 'VALE'  SELECT @Resultado = Mov FROM Vale WHERE ID = @ModuloID ELSE
  IF @Modulo = 'TMA'   SELECT @Resultado = Mov FROM TMA WHERE ID = @ModuloID ELSE
  IF @Modulo = 'PROD'  SELECT @Resultado = Mov FROM Prod WHERE ID = @ModuloID ELSE
  IF @Modulo = 'INV'   SELECT @Resultado = Mov FROM Inv WHERE ID = @ModuloID ELSE
  IF @Modulo = 'OFER'  SELECT @Resultado = Mov FROM Oferta WHERE ID = @ModuloID ELSE
  IF @Modulo = 'EMB'   SELECT @Resultado = Mov FROM Embarque WHERE ID = @ModuloID 

  RETURN (@Resultado)
END
GO
 
 /**************** fnSerieLoteConsignacionMovID ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSerieLoteConsignacionMovID') DROP FUNCTION fnSerieLoteConsignacionMovID
GO
CREATE FUNCTION fnSerieLoteConsignacionMovID 
	(
	@Modulo				varchar(5), 
	@ModuloID				int
	)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(20)

  IF @Modulo = 'VTAS'  SELECT @Resultado = MovID FROM Venta WHERE ID = @ModuloID ELSE
  IF @Modulo = 'COMS'  SELECT @Resultado = MovID FROM Compra WHERE ID = @ModuloID ELSE
  IF @Modulo = 'AF'    SELECT @Resultado = MovID FROM ActivoFijo WHERE ID = @ModuloID ELSE
  IF @Modulo = 'VALE'  SELECT @Resultado = MovID FROM Vale WHERE ID = @ModuloID ELSE
  IF @Modulo = 'TMA'   SELECT @Resultado = MovID FROM TMA WHERE ID = @ModuloID ELSE
  IF @Modulo = 'PROD'  SELECT @Resultado = MovID FROM Prod WHERE ID = @ModuloID ELSE
  IF @Modulo = 'INV'   SELECT @Resultado = MovID FROM Inv WHERE ID = @ModuloID ELSE
  IF @Modulo = 'OFER'  SELECT @Resultado = MovID FROM Oferta WHERE ID = @ModuloID ELSE
  IF @Modulo = 'EMB'   SELECT @Resultado = MovID FROM Embarque WHERE ID = @ModuloID 

  RETURN (@Resultado)
END
GO

/*** SerieLoteConsignacionAuxV ***/
if exists (select * from sysobjects where id = object_id('dbo.SerieLoteConsignacionAuxV') and type = 'V') drop view dbo.SerieLoteConsignacionAuxV
GO
CREATE VIEW SerieLoteConsignacionAuxV
AS
SELECT
  CorteID,
  Modulo, 
  dbo.fnModuloNombre(Modulo) ModuloNombre,
  ModuloID,
  dbo.fnSerieLoteConsignacionMov(Modulo,ModuloID) Mov, 
  dbo.fnSerieLoteConsignacionMovID(Modulo,ModuloID) MovID,
  Fecha,
  Articulo,
  SubCuenta,
  SerieLote,
  CargoU Cargo,
  AbonoU Abono   
FROM
  SerieLoteConsignacionAux
GO

--select * from SerieLoteConsignacionAuxV

/*** SerieLoteConsignacionAuxTempV ***/
if exists (select * from sysobjects where id = object_id('dbo.SerieLoteConsignacionAuxTempV') and type = 'V') drop view dbo.SerieLoteConsignacionAuxTempV
GO
CREATE VIEW SerieLoteConsignacionAuxTempV
AS
SELECT
  Estacion,
  ModuloID CorteID,
  Modulo, 
  dbo.fnModuloNombre(MModulo) ModuloNombre,
  MModuloID ModuloID,
  dbo.fnSerieLoteConsignacionMov(MModulo,MModuloID) Mov, 
  dbo.fnSerieLoteConsignacionMovID(MModulo,MModuloID) MovID,
  Fecha,
  Articulo,
  SubCuenta,
  SerieLote,
  CargoU Cargo,
  AbonoU Abono   
 FROM SerieLoteConsignacionAuxTemp
WHERE NULLIF(CorteID,0) IS NULL 
GO

/*** EmbarqueDArtMovVCI ***/ --MEJORA5619
if exists (select * from sysobjects where id = object_id('dbo.EmbarqueDArtMovVCI') and type = 'V') drop view dbo.EmbarqueDArtMovVCI
GO
CREATE VIEW EmbarqueDArtMovVCI
AS
SELECT
  eda.ID,
  eda.Modulo,
  eda.ModuloID,
  m.Nombre ModuloNombre,
  ISNULL(v.Mov,c.Mov) + ' ' + CASE WHEN v.Mov IS NOT NULL THEN ISNULL(v.MovID,'') ELSE ISNULL(c.MovID,'') END Mov,
  ISNULL(v.Estatus,c.Estatus) Estatus,  
  ISNULL(vd.Articulo,cd.Articulo) Articulo,  
  ISNULL(vd.SubCuenta,cd.SubCuenta) SubCuenta,    
  a.Descripcion1 Descripcion,
  eda.Cantidad,
  eda.CantidadTotal,
  eda.ImporteTotal,
  (ISNULL(eda.Cantidad,0.0)*ISNULL(eda.ImporteTotal,0.0))/ISNULL(eda.CantidadTotal,0.0) Importe    
  FROM EmbarqueDArt eda JOIN Modulo m
    ON m.Modulo = eda.Modulo LEFT OUTER JOIN Venta v
    ON v.ID = eda.ModuloID AND eda.Modulo = 'VTAS' LEFT OUTER JOIN Compra c
    ON c.ID = eda.ModuloID AND eda.Modulo = 'COMS' LEFT OUTER JOIN VentaD vd
    ON vd.ID = v.ID AND vd.Renglon = eda.Renglon AND vd.RenglonSub = eda.RenglonSub LEFT OUTER JOIN CompraD cd
    ON cd.ID = c.ID AND cd.Renglon = eda.Renglon AND cd.RenglonSub = eda.RenglonSub LEFT OUTER JOIN Art a
    ON a.Articulo = ISNULL(vd.Articulo,cd.Articulo) JOIN EmbarqueD ed
    ON ed.ID = eda.ID AND ed.EmbarqueMov = eda.EmbarqueMov
 WHERE ed.DesembarqueParcial = 0     
UNION ALL        
SELECT
  ed.ID,
  em.Modulo,
  em.ModuloID,
  m.Nombre ModuloNombre,
  i.Mov + ' ' + ISNULL(i.MovID,'') Mov,
  i.Estatus Estatus,
  id.Articulo,
  id.SubCuenta,
  a.Descripcion1 Descripcion,
  id.Cantidad Cantidad,
  id.Cantidad CantidadTotal,
  ISNULL(id.Cantidad,0.0)*ISNULL(id.Costo,0.0) ImporteTotal,
  ISNULL(id.Cantidad,0.0)*ISNULL(id.Costo,0.0) Importe  
  FROM EmbarqueD ed JOIN EmbarqueMov em
    ON em.ID = ed.EmbarqueMov LEFT OUTER JOIN Modulo m
    ON m.Modulo = em.Modulo LEFT OUTER JOIN Inv i
    ON i.ID = em.ModuloID LEFT OUTER JOIN InvD id
    ON id.ID = i.ID LEFT OUTER JOIN Art a
    ON a.Articulo = id.Articulo
 WHERE em.Modulo = 'INV' 
   AND ed.DesembarqueParcial = 0  
GO  
--SELECT * FROM EMBARQUEDArtMovVCI
--select * from embarquedart
--select * from embarqued
--select * from embarquemov
/*** EmbarqueDArtVCI ***/ --MEJORA5619
if exists (select * from sysobjects where id = object_id('dbo.EmbarqueDArtVCI') and type = 'V') drop view dbo.EmbarqueDArtVCI
GO
CREATE VIEW EmbarqueDArtVCI
AS
SELECT
  ID,
  Articulo,
  ISNULL(SubCuenta,'') SubCuenta,
  Descripcion,
  SUM(ISNULL(Cantidad,0.0)) Cantidad,
  SUM(ISNULL(CantidadTotal,0.0)) CantidadTotal,  
  SUM(ISNULL(ImporteTotal,0.0)) ImporteTotal,  
  SUM((ISNULL(Cantidad,0.0)*ISNULL(ImporteTotal,0.0))/ISNULL(CantidadTotal,0.0)) Importe
  FROM EmbarqueDArtMovVCI 
 GROUP BY ID, Articulo, ISNULL(SubCuenta,''), Descripcion  
 GO
  
 --SELECT * FROM EMBARQUEDArtVCI
 
/*** TransitoExistencia ***/
if exists (select * from sysobjects where id = object_id('dbo.TransitoExistencia') and type = 'V') drop view dbo.TransitoExistencia
GO
CREATE VIEW TransitoExistencia
AS
SELECT 
  i.Empresa Empresa,
  id.Articulo Articulo, 
  ISNULL(id.SubCuenta,'') Opcion,  
  i.Almacen AlmacenOrigen,
  i.AlmacenDestino AlmacenDestino,
  LTRIM(RTRIM(ISNULL(i.Almacen,''))) + '-' + LTRIM(RTRIM(ISNULL(i.AlmacenDestino,''))) OrigenDestino,
  SUM(ISNULL(id.Cantidad,0.0)) Cantidad,
  id.Unidad Unidad,  
  ISNULL(id.Costo,0.0)*ISNULL(i.TipoCambio,1) Costo,
  SUM((ISNULL(id.Costo,0.0)*ISNULL(i.TipoCambio,1))*ISNULL(id.Cantidad,0.0)) CostoTotal,
  SUM(ISNULL(id.CantidadInventario,0.0)) CantidadInventario
  FROM InvD id JOIN Inv i
    ON i.ID = id.ID JOIN MovTipo mt
    ON mt.Mov = i.Mov AND mt.Modulo = 'INV'
 WHERE mt.Clave = 'INV.TI'   
   AND i.Estatus = 'PENDIENTE'
 GROUP BY i.Empresa, i.Almacen, i.AlmacenDestino, LTRIM(RTRIM(ISNULL(i.Almacen,''))) + '-' + LTRIM(RTRIM(ISNULL(i.AlmacenDestino,''))), id.Articulo, ISNULL(id.SubCuenta,''),id.Unidad, ISNULL(id.Costo,0.0)*ISNULL(i.TipoCambio,1)
GO

--select * from transitoexistencia
/*** TransitoExistenciaD ***/
if exists (select * from sysobjects where id = object_id('dbo.TransitoExistenciaD') and type = 'V') drop view dbo.TransitoExistenciaD
GO
CREATE VIEW TransitoExistenciaD
AS
SELECT 
  i.Empresa Empresa,
  id.Articulo Articulo, 
  ISNULL(id.SubCuenta,'') Opcion,  
  i.Almacen AlmacenOrigen,
  i.AlmacenDestino AlmacenDestino,  
  i.ID ID,
  ISNULL(i.Mov,'') + ' ' + ISNULL(i.MovID,'') Movimiento,
  i.FechaEmision FechaEmision,
  ISNULL(id.Cantidad,0.0) Cantidad,
  id.Unidad Unidad,  
  (ISNULL(id.Costo,0.0)*ISNULL(i.TipoCambio,1)) Costo,
  (ISNULL(id.Costo,0.0)*ISNULL(i.TipoCambio,1))*ISNULL(id.Cantidad,0.0) CostoTotal,  
  ISNULL(id.CantidadInventario,0.0) CantidadInventario
  FROM InvD id JOIN Inv i
    ON i.ID = id.ID JOIN MovTipo mt
    ON mt.Mov = i.Mov AND mt.Modulo = 'INV'
 WHERE mt.Clave = 'INV.TI'   
   AND i.Estatus = 'PENDIENTE'
GO 

/*** PCPPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.PCPPendiente') and type = 'V') drop view dbo.PCPPendiente
GO
CREATE VIEW PCPPendiente
--//WITH ENCRYPTION
AS 
SELECT 
  p.ID,
  p.Empresa,
  p.Sucursal,
  ISNULL(p.Mov,'') + ' ' + ISNULL(p.MovID,'') Movimiento, 
  p.Mov,
  p.MovID,
  p.FechaEmision,
  p.UEN,
  p.Concepto,
  p.Proyecto,
  p.Usuario,
  p.Estatus,
  p.Moneda,
  p.TipoCambio,
  p.OrigenTipo,
  p.Origen,
  p.OrigenID,
  p.ClavePresupuestalMascara,
  p.Categoria,
  p.Tipo,
  p.Ejercicio,
  p.Periodo,
  mt.Clave MovTipo
  FROM PCP p JOIN MovTipo mt
    ON mt.Mov = p.Mov AND mt.Modulo = 'PCP'
 WHERE p.Estatus IN ('PENDIENTE','VIGENTE')  
GO



--REQ 15739
/*** CFDFlexPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.CFDFlexPendiente') and type = 'V') drop view dbo.CFDFlexPendiente
GO
CREATE VIEW CFDFlexPendiente
--//WITH ENCRYPTION
AS 
SELECT 'VTAS' As Modulo, v.ID , v.Mov, v.MovID, v.FechaEmision, v.Estatus, v.CFDFlexEstatus, v.Importe, v.Impuestos, v.Cliente as Cliente_Proveedor, v.Empresa, v.Sucursal  
  FROM Venta v JOIN MovTipo mt ON v.Mov = mt.Mov
 WHERE mt.CFDFlex = 1
   AND v.Estatus NOT IN ('SINAFECTAR','CANCELADO') 
   AND v.CFDFlexEstatus IN('ERROR','PROCESANDO')   
 UNION ALL      
SELECT 'CXC' As Modulo, c.ID, c.Mov, c.MovID, c.FechaEmision, c.Estatus, c.CFDFlexEstatus, c.Importe, c.Impuestos, c.Cliente, c.Empresa, c.Sucursal  
  FROM Cxc c JOIN MovTipo mt ON c.Mov = mt.Mov
 WHERE mt.CFDFlex = 1
   AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
   AND c.CFDFlexEstatus IN('ERROR','PROCESANDO')    
 UNION ALL     
SELECT 'CXP' As Modulo, c.ID, c.Mov, c.MovID, c.FechaEmision, c.Estatus, c.CFDFlexEstatus, c.Importe, c.Impuestos, c.Proveedor, c.Empresa, c.Sucursal  
  FROM Cxp c JOIN MovTipo mt ON c.Mov = mt.Mov
 WHERE mt.CFDFlex = 1
   AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
   AND c.CFDFlexEstatus IN('ERROR','PROCESANDO')     
 UNION ALL     
SELECT 'COMS' As Modulo, c.ID, c.Mov, c.MovID, c.FechaEmision, c.Estatus, c.CFDFlexEstatus, c.Importe, c.Impuestos, c.Proveedor, c.Empresa, c.Sucursal  
  FROM Compra c JOIN MovTipo mt ON c.Mov = mt.Mov
 WHERE mt.CFDFlex = 1
   AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
   AND c.CFDFlexEstatus IN('ERROR','PROCESANDO')      
 UNION ALL     
SELECT 'CORTE' As Modulo, c.ID, c.Mov, c.MovID, c.FechaEmision, c.Estatus, c.CFDFlexEstatus, c.Importe, 0.0, NULL, c.Empresa, c.Sucursal  
  FROM Corte c JOIN MovTipo mt ON c.Mov = mt.Mov
 WHERE mt.CFDFlex = 1
   AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
   AND c.CFDFlexEstatus IN('ERROR','PROCESANDO') 
GO

--REQ 15448

if exists (select * from sysobjects where id = object_id('dbo.VentaRefacturar') and sysstat & 0xf = 2) drop view dbo.VentaRefacturar
GO
CREATE VIEW VentaRefacturar
--//WITH ENCRYPTION
AS
SELECT v.ID, v.Empresa, v.Mov, v.MovID, v.Cliente, v.Importe, v.Impuestos, c.Nombre, v.Sucursal, v.Almacen, v.FechaEmision, v.Estatus, v.Moneda, v.Usuario
  FROM Venta v JOIN MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'VTAS'
  JOIN Cte c ON v.Cliente = c.Cliente
 WHERE v.Estatus NOT IN ('SINAFECTAR','CANCELADO') 
   AND m.Clave IN ('VTAS.N')
   AND v.Refacturado = 0
   AND v.Importe > 0.0
  
GO 
--REQ 15448
/*** POSCFDFlexPendiente ***/
if exists (select * from sysobjects where id = object_id('dbo.POSCFDFlexPendiente') and type = 'V') drop view dbo.POSCFDFlexPendiente
GO
CREATE VIEW POSCFDFlexPendiente
--//WITH ENCRYPTION
AS 
  SELECT c.Modulo, c.ID, p.Mov, p.MovID, c.FechaEmision, c.Estatus, c.CFDFlexEstatus, c.Importe, c.Impuestos, c.Cliente_Proveedor, c.Empresa, c.Sucursal, p.ID IDPOS, c.Mov MovVenta, c.MovID MovIDVenta
    FROM CFDFlexPendiente c     
    JOIN POSL p ON p.Empresa = c.Empresa AND p.Origen = c.Mov AND p.OrigenID = c.MovID AND c.Modulo = 'VTAS'
   WHERE p.Estatus = 'FACTURADO' 
GO
--REQ1653 Precongf
/******************************* spRSBitacoraEmbarque *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spRSBitacoraEmbarque') and type = 'P') drop procedure dbo.spRSBitacoraEmbarque
GO             
CREATE PROCEDURE spRSBitacoraEmbarque
		
		 @Empresa		varchar(10),
		 @Sucursal	    int,  
		 @ClienteD   	varchar(10),
         --@ClienteA      varchar(10),
		 --@Articulo		varchar(20),
		 @Vehiculo		varchar(10),
		 @FechaD        datetime,
		 @FechaA        datetime

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @EstacionTrabajo		    int

   SELECT  @Empresa     = CASE WHEN @Empresa IN( '(Todas)', '') THEN NULL ELSE @Empresa END ,
           @ClienteD    = CASE WHEN @ClienteD IN( '(Todos)', '') THEN NULL ELSE @ClienteD END,
		   @Vehiculo    = CASE WHEN @Vehiculo IN( '(Todos)', '') THEN NULL ELSE @Vehiculo END  
  
  SELECT @EstacionTrabajo=@@SPID


  SELECT
    e.Agente,
	e.MovId as eMovID,
	RTRIM(ISNULL(e.Mov,''))+' '+ISNULL(e.MovId,'') as eMovMovID,
	e.Referencia,
	e.Observaciones,
	em.MovObservaciones,
	e.Vehiculo,
	ISNULL(Vehiculo.Descripcion,'')+'. Placas:'+ISNULL(Vehiculo.Placas,'')+'. Cap.Peso (Kgs):'+CONVERT(VARCHAR, ISNULL(Vehiculo.Peso,0)) as InfoVehiculo,
	em.MovEstatus,
	em.Ruta,
	ed.Estado,
	ed.FechaHora,
	em.Cliente,
	c.Nombre,
	em.Telefonos,
	em.Paquetes,
	em.Importe,
	em.FechaEmision,
	CASE WHEN em.Modulo='VTAS' THEN RTRIM(ISNULL(em.Mov,''))+' '+ISNULL(em.MovID,'') ELSE '' END as emMovMovID,
	--v.FormaPagoTipo,
	ed.Forma FormaPagoTipo --BUG2450
  FROM Embarque e
  JOIN EmbarqueD ed ON e.ID=ed.ID
  --JOIN EmbarqueMov em ON e.ID=em.ID
  JOIN EmbarqueMov em ON ed.EmbarqueMov=em.ID
  JOIN Cte c ON em.Cliente=c.Cliente
  LEFT OUTER JOIN Venta v ON em.ModuloID=v.ID
  LEFT OUTER JOIN Vehiculo ON e.Vehiculo=Vehiculo.Vehiculo
  WHERE e.Empresa = ISNULL(@Empresa,e.Empresa) AND e.Sucursal=ISNULL(@Sucursal,e.Sucursal)
	  AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
	  AND e.FechaEmision BETWEEN @FechaD AND @FechaA
      AND em.Cliente = ISNULL(@ClienteD,em.Cliente)
	  AND e.Vehiculo =  ISNULL(@Vehiculo,e.Vehiculo)
  ORDER BY e.FechaEmision, e.Agente
	   
END
GO
--REQ1878  Precongf
/******************************* spRSGastosDetallado *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spRSGastosDetallado') and type = 'P') drop procedure dbo.spRSGastosDetallado
GO             
CREATE PROCEDURE spRSGastosDetallado
		
		 @Empresa		varchar(10),
		 @Sucursal	    int, 
		 @Ejercicio     int, 
		 --@PeriodoD   	int,  
		 --@PeriodoA   	int,
		 @Clase         varchar(max),
		 @SubClase      varchar(100)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE @EstacionTrabajo int

  CREATE TABLE #DatosClase(Descripcion varchar(100) COLLATE Database_Default )

  SELECT  @Empresa     = CASE WHEN @Empresa IN( '(Todas)', '') THEN NULL ELSE @Empresa END,
          @Clase       = CASE WHEN @Clase IN( '(Todas)', '') THEN NULL ELSE @Clase END,
	      @SubClase    = CASE WHEN @SubClase IN( '(Todas)', '') THEN NULL ELSE @SubClase END 
  
  IF @Clase IS NULL
  BEGIN
    INSERT #DatosClase
	SELECT Descripcion
    FROM Cta
    WHERE Rama='R'
  END

  IF @Clase IS NOT NULL
   INSERT INTO #DatosClase SELECT ValorTexto FROM dbo.fnParseaCadena(@Clase, ',')
  
  --SELECT * FROM #DatosClase

  SELECT  
   Acum.Empresa AS TEmpresa,            
   Acum.Sucursal AS TSucursal,            
   Acum.Ejercicio AS TEjercicio,      
   Acum.Periodo AS TPeriodo,
   Acum.Rama,             
   C.Rama AS RamaPrincipal,
   TMov = Ctx.Descripcion,            
   TClase = C.Descripcion,            
   TSubClase = Ct.Descripcion,            
   TConcepto = Ctx.Cuenta,   
   TCC = Acum.SubCuenta,   
   Gasto1 = Case  when Acum.Periodo = 1 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end,            
   Gasto2 = Case when  Acum.Periodo = 2 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end,            
   Gasto3 = Case  when  Acum.Periodo = 3 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end,            
   Gasto4 = Case  when  Acum.Periodo = 4 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end,            
   Gasto5 = Case  when  Acum.Periodo = 5 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end,            
   Gasto6 = Case  when  Acum.Periodo = 6 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end,            
   Gasto7 = Case  when  Acum.Periodo = 7 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end,            
   Gasto8 = Case  when  Acum.Periodo = 8 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end,            
   Gasto9 = Case  when  Acum.Periodo = 9 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end,         
   Gasto10 = Case  when  Acum.Periodo = 10 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end,             
   Gasto11 = Case  when  Acum.Periodo = 11 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end,            
   Gasto12 = Case  when  Acum.Periodo = 12 then ISNULL(Acum.Cargos,0) - ISNULL(Acum.Abonos,0) end           
 FROM Cta            
  JOIN Cta C ON C.Rama = Cta.Cuenta            
  JOIN Cta Ct ON Ct.Rama = C.Cuenta            
  JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta            
  JOIN Acum ON Acum.Cuenta = Ctx.Cuenta
  JOIN #DatosClase Dc ON Dc.Descripcion=C.Descripcion         
 WHERE Acum.Empresa=ISNULL(@Empresa, Acum.Empresa)
  AND Acum.Sucursal=ISNULL(@Sucursal, Acum.Sucursal)
  AND Acum.Ejercicio = @Ejercicio
  AND Acum.Rama = 'CONT' AND Moneda='Pesos'
  --AND Acum.Periodo BETWEEN @PeriodoD AND @PeriodoA
  AND C.Rama  = 'R'
  --AND C.Descripcion IN ('Gastos de Operación','Otros Gastos y Productos')
  --AND Ct.Descripcion = 'Gastos de Administración'
  --AND Ct.Descripcion = @SubClase
  AND Ct.Descripcion = ISNULL(@SubClase, Ct.Descripcion)

  --*********** Filtros de la vista en el .rep
  --TEjercicio = {Info.Ejercicio}
  --AND TEmpresa = {Comillas(Empresa)}
  --AND RamaPrincipal = 'R'
  --AND TClase = 'Gastos de Operación'
  --AND TSubClase = 'Gastos de Administración'
  --AND TPeriodo <= {Info.Periodo}

END
GO
--REQ1821 Precong
/**************** spRSVerRotacionInv ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRSVerRotacionInv') and type = 'P') 
	drop procedure dbo.spRSVerRotacionInv
GO
CREATE PROCEDURE spRSVerRotacionInv
@Empresa 		varchar(10),
@ArticuloD		varchar(20),
@ArticuloA		varchar(20),
@FechaD 		datetime,
@FechaA 		datetime,
@Sucursal		int			= NULL
--//WITH ENCRYPTION
AS
BEGIN
DECLARE
@Estacion		        int,
@CfgMoneda				varchar(10),
@CfgMonedaTipoCambio	float,
@UltimoDiaMesD			int,
@PeriodoD				int,
@UltimoDiaMesA			int,
@PeriodoA				int,
@crSucursal				int,
@crNombre				varchar(100),
@crMoneda				char(10),
@crArticulo				varchar(20),
@crDescripcion1			varchar(100),
@crUnidad				varchar(50),
@crSubCuenta			varchar(50),
@crCostoInvInicial		money,
@crCostoInvFinal		money

SELECT @Estacion=@@SPID
DELETE VerRotacionInv WHERE Estacion = @Estacion

--SELECT  @Empresa     = CASE WHEN @Empresa IN( '(Todas)', '') THEN NULL ELSE @Empresa END  

IF @FechaA<@FechaD
BEGIN 
  SELECT 'La Fecha Fin, debe ser mayor a la Fecha Inicial'
  RETURN
END

SELECT @CfgMoneda = ContMoneda
FROM EmpresaCfg
WHERE Empresa = @Empresa

SELECT @CfgMonedaTipoCambio = TipoCambio
FROM Mon
WHERE Moneda = @CfgMoneda

INSERT VerRotacionInv (Estacion, Empresa, Sucursal, Nombre, Articulo, Descripcion1, Unidad, Moneda, SubCuenta, CostoTotalNetoMN)
SELECT
  @Estacion,
  v.Empresa,
  v.Sucursal,
  s.Nombre,
  d.Articulo,
  --a.Descripcion1,
  d.Articulo+' - '+a.Descripcion1, --BUG2455
  a.Unidad,
  a.MonedaCosto,
  ISNULL(d.SubCuenta, ''),
  CONVERT(money, SUM(ISNULL(d.Costo, 0.0) * ((ISNULL(d.Cantidad, 0.0) - ISNULL(d.CantidadCancelada, 0.0)) * 
  (CASE 
	  WHEN v.Mov IN ('VTAS.D', 'VTAS.DF') THEN -1 
	  WHEN v.Mov IN ('VTAS.B') THEN 0 
	  ELSE 1
  END)) * ISNULL(v.TipoCambio, 0.0)))
FROM Venta v
INNER JOIN VentaD d ON v.ID = d.ID
INNER JOIN MovTipo mt ON v.Mov = mt.Mov
INNER JOIN Art a ON d.Articulo = a.Articulo
INNER JOIN Sucursal s ON v.Sucursal = s.Sucursal
WHERE v.Empresa = @Empresa
  AND v.Sucursal = ISNULL(@Sucursal, v.Sucursal)
  AND v.FechaEmision BETWEEN @FechaD AND @FechaA
  AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO')
  AND mt.Modulo = 'VTAS' AND (mt.Clave IN ('VTAS.F', 'VTAS.FAR', 'VTAS.FB', 'VTAS.FM', 'VTAS.D', 'VTAS.DF', 'VTAS.B') OR (mt.Clave IN ('VTAS.EST') AND v.Mov IN ('Gasto Extemporaneo', 'Bonif. Extemporanea')))
  AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
GROUP BY
  v.Empresa,
  v.Sucursal,
  s.Nombre,
  d.Articulo,
  d.SubCuenta,
  a.Descripcion1,
  a.Unidad,
  a.MonedaCosto
ORDER BY
  v.Empresa,
  v.Sucursal,
  s.Nombre,
  d.Articulo,
  d.SubCuenta,
  a.Descripcion1,
  a.Unidad,
  a.MonedaCosto

SELECT @PeriodoD = MONTH(@FechaD) 
SELECT @UltimoDiaMesD = dbo.fnDiasMes(MONTH(@FechaD), YEAR(@FechaD))
IF DAY(@FechaD) = @UltimoDiaMesD
	SELECT @PeriodoD = @PeriodoD + 1

DECLARE crVerRotacionInvInicialAcumU CURSOR LOCAL FOR
SELECT
  au.Sucursal,
  s.Nombre,
  au.Moneda,
  au.Cuenta,
  --a.Descripcion1,
  a.Articulo+' - '+a.Descripcion1, --BUG2455
  a.Unidad,
  au.SubCuenta,
  CONVERT(money, SUM(ISNULL(au.Cargos, 0.0) - ISNULL(au.Abonos, 0.0)))
FROM AcumU au
INNER JOIN Art a ON au.Cuenta = a.Articulo
INNER JOIN Sucursal s ON au.Sucursal = s.Sucursal
WHERE au.Rama = 'INV' 
  AND au.Empresa = @Empresa
  AND au.Sucursal = ISNULL(@Sucursal, au.Sucursal)
  AND au.Ejercicio = YEAR(@FechaD)
  AND au.Periodo < @PeriodoD
  AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
GROUP BY
  au.Sucursal,
  s.Nombre,
  au.Moneda,
  au.Cuenta,
  a.Articulo,  --BUG2455
  a.Descripcion1,
  a.Unidad,
  au.SubCuenta
HAVING CONVERT(money, SUM(ISNULL(au.Cargos, 0.0) - ISNULL(au.Abonos, 0.0))) <> 0.0
ORDER BY
  au.Sucursal,
  s.Nombre,
  au.Moneda,
  au.Cuenta,
  a.Articulo,  --BUG2455
  a.Descripcion1,
  a.Unidad,
  au.SubCuenta

OPEN crVerRotacionInvInicialAcumU
FETCH NEXT FROM crVerRotacionInvInicialAcumU INTO @crSucursal, @crNombre, @crMoneda, @crArticulo, @crDescripcion1, @crUnidad, @crSubCuenta, @crCostoInvInicial
WHILE @@FETCH_STATUS <> -1
BEGIN
	IF @@FETCH_STATUS <> -2
	BEGIN
	    --mejora pgc
		UPDATE VerRotacionInv
		SET CostoInvInicial = @crCostoInvInicial
		WHERE Estacion = @Estacion 
		AND Empresa = @Empresa AND Sucursal = @crSucursal AND Moneda = @crMoneda AND Articulo = @crArticulo AND SubCuenta = @crSubCuenta
		IF @@ROWCOUNT = 0
			INSERT VerRotacionInv (Estacion, Empresa, Sucursal, Nombre, Articulo, Descripcion1, Unidad, Moneda, SubCuenta, CostoInvInicial)
			VALUES (@Estacion, @Empresa, @crSucursal, @crNombre, @crArticulo, @crDescripcion1, @crUnidad, @crMoneda, @crSubCuenta, @crCostoInvInicial)
	END
	FETCH NEXT FROM crVerRotacionInvInicialAcumU INTO @crSucursal, @crNombre, @crMoneda, @crArticulo, @crDescripcion1, @crUnidad, @crSubCuenta, @crCostoInvInicial
END
CLOSE crVerRotacionInvInicialAcumU
DEALLOCATE crVerRotacionInvInicialAcumU

IF DAY(@FechaD) < @UltimoDiaMesD
BEGIN
	DECLARE crVerRotacionInvInicialAuxU CURSOR LOCAL FOR
	SELECT
	  au.Sucursal,
	  s.Nombre,
	  au.Moneda,
	  au.Cuenta,
	  --a.Descripcion1,
      a.Articulo+' '+a.Descripcion1,  --BUG2455
	  a.Unidad,
	  au.SubCuenta,
	  CONVERT(money, SUM(ISNULL(au.Cargo, 0.0) - ISNULL(au.Abono, 0.0)))
	FROM AuxiliarU au
	INNER JOIN Art a ON au.Cuenta = a.Articulo
	INNER JOIN Sucursal s ON au.Sucursal = s.Sucursal
	WHERE au.Rama = 'INV' 
	  AND au.Empresa = ISNULL(@Empresa, au.Empresa)
	  AND au.Sucursal = ISNULL(@Sucursal, au.Sucursal)
	  AND au.Ejercicio = YEAR(@FechaD)
	  AND au.Periodo = MONTH(@FechaD)
	  AND au.Fecha <= @FechaD
	  AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
	GROUP BY
	  au.Sucursal,
	  s.Nombre,
	  au.Moneda,
	  au.Cuenta,
	  a.Articulo,  --BUG2455
	  a.Descripcion1,
	  a.Unidad,
	  au.SubCuenta
	HAVING CONVERT(money, SUM(ISNULL(au.Cargo, 0.0) - ISNULL(au.Abono, 0.0))) <> 0.0
	ORDER BY
	  au.Sucursal,
	  s.Nombre,
	  au.Moneda,
	  au.Cuenta,
	  a.Articulo,  --BUG2455
	  a.Descripcion1,
	  a.Unidad,
	  au.SubCuenta
	OPEN crVerRotacionInvInicialAuxU
	FETCH NEXT FROM crVerRotacionInvInicialAuxU INTO @crSucursal, @crNombre, @crMoneda, @crArticulo, @crDescripcion1, @crUnidad, @crSubCuenta, @crCostoInvInicial
	WHILE @@FETCH_STATUS <> -1
	BEGIN
		IF @@FETCH_STATUS <> -2
		BEGIN
			UPDATE VerRotacionInv
			SET CostoInvInicial = ISNULL(CostoInvInicial, 0.0) + @crCostoInvInicial
			WHERE Estacion = @Estacion 
			AND Empresa = @Empresa AND Sucursal = @crSucursal AND Moneda = @crMoneda AND Articulo = @crArticulo AND SubCuenta = @crSubCuenta
			IF @@ROWCOUNT = 0
				INSERT VerRotacionInv (Estacion, Empresa, Sucursal, Nombre, Articulo, Descripcion1, Unidad, Moneda, SubCuenta, CostoInvInicial)
				VALUES (@Estacion, @Empresa, @crSucursal, @crNombre, @crArticulo, @crDescripcion1, @crUnidad, @crMoneda, @crSubCuenta, @crCostoInvInicial)
		END
		FETCH NEXT FROM crVerRotacionInvInicialAuxU INTO @crSucursal, @crNombre, @crMoneda, @crArticulo, @crDescripcion1, @crUnidad, @crSubCuenta, @crCostoInvInicial
	END
	CLOSE crVerRotacionInvInicialAuxU
	DEALLOCATE crVerRotacionInvInicialAuxU
END

SELECT @PeriodoA = MONTH(@FechaA) 
SELECT @UltimoDiaMesA = dbo.fnDiasMes(MONTH(@FechaA), YEAR(@FechaA))
IF DAY(@FechaA) = @UltimoDiaMesA
	SELECT @PeriodoA = @PeriodoA + 1

DECLARE crVerRotacionInvFinalAcumU CURSOR LOCAL FOR
SELECT
  au.Sucursal,
  s.Nombre,
  au.Moneda,
  au.Cuenta,
  --a.Descripcion1,
  a.Articulo+' '+a.Descripcion1,
  a.Unidad,
  au.SubCuenta,
  CONVERT(money, SUM(ISNULL(au.Cargos, 0.0) - ISNULL(au.Abonos, 0.0)))
FROM AcumU au
INNER JOIN Art a ON au.Cuenta = a.Articulo
INNER JOIN Sucursal s ON au.Sucursal = s.Sucursal
WHERE au.Rama = 'INV' 
  AND au.Empresa = @Empresa
  AND au.Sucursal = ISNULL(@Sucursal, au.Sucursal)
  AND au.Ejercicio = YEAR(@FechaA)
  AND au.Periodo < @PeriodoA
  AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
GROUP BY
  au.Sucursal,
  s.Nombre,
  au.Moneda,
  au.Cuenta,
  a.Articulo,  --BUG2455
  a.Descripcion1,
  a.Unidad,
  au.SubCuenta
HAVING CONVERT(money, SUM(ISNULL(au.Cargos, 0.0) - ISNULL(au.Abonos, 0.0))) <> 0.0
ORDER BY
  au.Sucursal,
  s.Nombre,
  au.Moneda,
  au.Cuenta,
  a.Articulo,  --BUG2455
  a.Descripcion1,
  a.Unidad,
  au.SubCuenta
OPEN crVerRotacionInvFinalAcumU
FETCH NEXT FROM crVerRotacionInvFinalAcumU INTO @crSucursal, @crNombre, @crMoneda, @crArticulo, @crDescripcion1, @crUnidad, @crSubCuenta, @crCostoInvFinal
WHILE @@FETCH_STATUS <> -1
BEGIN
	IF @@FETCH_STATUS <> -2
	BEGIN
		UPDATE VerRotacionInv
		SET CostoInvFinal = @crCostoInvFinal
		WHERE Estacion = @Estacion 
		AND Empresa = @Empresa AND Sucursal = @crSucursal AND Moneda = @crMoneda AND Articulo = @crArticulo AND SubCuenta = @crSubCuenta
		IF @@ROWCOUNT = 0
			INSERT VerRotacionInv (Estacion, Empresa, Sucursal, Nombre, Articulo, Descripcion1, Unidad, Moneda, SubCuenta, CostoInvFinal)
			VALUES (@Estacion, @Empresa, @crSucursal, @crNombre, @crArticulo, @crDescripcion1, @crUnidad, @crMoneda, @crSubCuenta, @crCostoInvFinal)
	END
	FETCH NEXT FROM crVerRotacionInvFinalAcumU INTO @crSucursal, @crNombre, @crMoneda, @crArticulo, @crDescripcion1, @crUnidad, @crSubCuenta, @crCostoInvFinal
END
CLOSE crVerRotacionInvFinalAcumU
DEALLOCATE crVerRotacionInvFinalAcumU

IF DAY(@FechaA) < @UltimoDiaMesA
BEGIN
	DECLARE crVerRotacionInvFinalAuxU CURSOR LOCAL FOR
	SELECT 
	  au.Sucursal,
	  s.Nombre,
	  au.Moneda,
	  au.Cuenta,
	  --a.Descripcion1,
      a.Articulo+' '+a.Descripcion1,
	  a.Unidad,
	  au.SubCuenta,
	  CONVERT(money, SUM(ISNULL(au.Cargo, 0.0) - ISNULL(au.Abono, 0.0)))
	FROM AuxiliarU au
	INNER JOIN Art a ON au.Cuenta = a.Articulo
	INNER JOIN Sucursal s ON au.Sucursal = s.Sucursal
	WHERE au.Rama = 'INV' 
	  AND au.Empresa = @Empresa
	  AND au.Sucursal = ISNULL(@Sucursal, au.Sucursal)
	  AND au.Ejercicio = YEAR(@FechaA)
	  AND au.Periodo = MONTH(@FechaA)
	  AND au.Fecha <= @FechaA
	  AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
	GROUP BY
	  au.Sucursal,
	  s.Nombre,
	  au.Moneda,
	  au.Cuenta,
	  a.Articulo,  --BUG2455
	  a.Descripcion1,
	  a.Unidad,
	  au.SubCuenta
	HAVING CONVERT(money, SUM(ISNULL(au.Cargo, 0.0) - ISNULL(au.Abono, 0.0))) <> 0.0
	ORDER BY
	  au.Sucursal,
	  s.Nombre,
	  au.Moneda,
	  au.Cuenta,
	  a.Articulo,  --BUG2455
	  a.Descripcion1,
	  a.Unidad,
	  au.SubCuenta
	OPEN crVerRotacionInvFinalAuxU
	FETCH NEXT FROM crVerRotacionInvFinalAuxU INTO @crSucursal, @crNombre, @crMoneda, @crArticulo, @crDescripcion1, @crUnidad, @crSubCuenta, @crCostoInvFinal
	WHILE @@FETCH_STATUS <> -1
	BEGIN
		IF @@FETCH_STATUS <> -2
		BEGIN
			UPDATE VerRotacionInv
			SET CostoInvFinal = ISNULL(CostoInvFinal, 0.0) + @crCostoInvFinal
			WHERE Estacion = @Estacion 
			AND Empresa = @Empresa AND Sucursal = @crSucursal AND Moneda = @crMoneda AND Articulo = @crArticulo AND SubCuenta = @crSubCuenta
			IF @@ROWCOUNT = 0
				INSERT VerRotacionInv (Estacion, Empresa, Sucursal, Nombre, Articulo, Descripcion1, Unidad, Moneda, SubCuenta, CostoInvFinal)
				VALUES (@Estacion, @Empresa, @crSucursal, @crNombre, @crArticulo, @crDescripcion1, @crUnidad, @crMoneda, @crSubCuenta, @crCostoInvFinal)
		END
		FETCH NEXT FROM crVerRotacionInvFinalAuxU INTO @crSucursal, @crNombre, @crMoneda, @crArticulo, @crDescripcion1, @crUnidad, @crSubCuenta, @crCostoInvFinal
	END
	CLOSE crVerRotacionInvFinalAuxU
	DEALLOCATE crVerRotacionInvFinalAuxU
END


--MEJORA
DECLARE @NumPeriodos int
--SELECT IIF(MONTH(@FechaD)=MONTH(@FechaA),1,DATEDIFF(MONTH,@FechaD,@FechaA))
--SELECT @NumPeriodos=IIF(MONTH(@FechaD)=MONTH(@FechaA),1,DATEDIFF(MONTH,@FechaD,@FechaA))
SELECT @NumPeriodos=ROUND(DATEDIFF(DAY,@FechaD,@FechaA)/30.4,0)
--SELECT @NumPeriodos

UPDATE VerRotacionInv
--SET CostoInvPromedio = (ISNULL(CostoInvInicial, 0.0) + ISNULL(CostoInvFinal, 0.0)) / 2
--MEJORA
SET CostoInvPromedio = (ISNULL(CostoInvInicial, 0.0) + ISNULL(CostoInvFinal, 0.0)) / @NumPeriodos
WHERE Estacion = @Estacion

UPDATE VerRotacionInv
SET VerRotacionInv.CostoInvPromedioMN = vri.CostoInvPromedio *
CASE WHEN UPPER(vri.Moneda) <> UPPER(@CfgMoneda) THEN ISNULL(m.TipoCambio, 1.0) / NULLIF(@CfgMonedaTipoCambio, 0.0) ELSE @CfgMonedaTipoCambio END
FROM VerRotacionInv vri 
INNER JOIN Mon m ON vri.Moneda = m.Moneda
WHERE Estacion = @Estacion

UPDATE VerRotacionInv
SET Rotacion = CONVERT(float, ISNULL(CostoTotalNetoMN, 0.0) / NULLIF(CostoInvPromedioMN, 0.0))
WHERE Estacion = @Estacion

SELECT *
FROM VerRotacionInv r
WHERE Estacion = @Estacion --BUG2981

END 
GO
--REQ1584 Preconf
/**************** spVerContResultadosEmpresaSucursalAnualRS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContResultadosEmpresaSucursalAnualRS') and type = 'P') drop procedure dbo.spVerContResultadosEmpresaSucursalAnualRS
GO
--BUG2925
CREATE PROCEDURE spVerContResultadosEmpresaSucursalAnualRS
		    @Empresa		varchar(5),
		    @Ejercicio		int,
			@Sucursal		int	    = NULL, 
            @CentroCostos	varchar(20) = NULL,
		    @Moneda			varchar(10) = NULL,
            --@Controladora	varchar(5)  = NULL,
		    @UEN			int		= NULL,
		    @Proyecto		varchar(50)	= NULL,
		    @CentroCostos2	varchar(50)	= NULL,
		    @CentroCostos3	varchar(50)	= NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @CtaResultados	varchar(20),
    @CtaIngresos	varchar(20),
    @CtaCostoDirecto	varchar(20),
    @Saldo               money,
    @SaldoAlEne         money,
    @SaldoAlFeb         money,
    @SaldoAlMar         money,
    @SaldoAlAbr         money,
    @SaldoAlMay         money,
    @SaldoAlJun         money,
    @SaldoAlJul         money,
    @SaldoAlAgo         money,
    @SaldoAlSep         money,
    @SaldoAlOct         money,
    @SaldoAlNov         money,
    @SaldoAlDic         money,
    @Ingresos		money,
    @IngresosAlEne 	money,
    @IngresosAlFeb 	money,
    @IngresosAlMar 	money,
    @IngresosAlAbr 	money,
    @IngresosAlMay 	money,
    @IngresosAlJun 	money,
    @IngresosAlJul 	money,
    @IngresosAlAgo 	money,
    @IngresosAlSep 	money,
    @IngresosAlOct 	money,
    @IngresosAlNov 	money,
    @IngresosAlDic 	money,
    @PorcentajeAlEne    money,
    @PorcentajeAlFeb    money,
    @PorcentajeAlMar    money,
    @PorcentajeAlAbr    money,
    @PorcentajeAlMay    money,
    @PorcentajeAlJun    money,
    @PorcentajeAlJul    money,
    @PorcentajeAlAgo    money,
    @PorcentajeAlSep    money,
    @PorcentajeAlOct    money,
    @PorcentajeAlNov    money,
    @PorcentajeAlDic    money,

	--REQ2301
    @CtaGastosOperacion varchar(20),
 	@CtaOtrosGastosProductos  varchar(20)

 
  SELECT @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')
  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  CREATE TABLE #ResultadoAnual (
     Orden		int		NOT NULL,
     ID			int		IDENTITY(1,1) NOT NULL,

     Clase		varchar(50)	COLLATE Database_Default NULL,
     SubClase		varchar(20)	COLLATE Database_Default NULL,
     Rama		varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc		varchar(100)	COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,
     Cuenta		varchar(20)	COLLATE Database_Default NULL,
     Descripcion	varchar(100)	COLLATE Database_Default NULL,
     EsAcreedora	bit		NOT NULL DEFAULT 0,
     Saldo		money		NULL,
     SaldoAlEne		money		NULL,
     SaldoAlFeb		money		NULL,
     SaldoAlMar		money		NULL,
     SaldoAlAbr		money		NULL,
     SaldoAlMay		money		NULL,
     SaldoAlJun		money		NULL,
     SaldoAlJul		money		NULL,
     SaldoAlAgo		money		NULL,
     SaldoAlSep		money		NULL,
     SaldoAlOct 	money		NULL,
     SaldoAlNov		money		NULL,
     SaldoAlDic		money		NULL,
     Ingresos		money		NULL,
     IngresosAlEne	money		NULL,
     IngresosAlFeb	money		NULL,
     IngresosAlMar	money		NULL,
     IngresosAlAbr	money		NULL,
     IngresosAlMay	money		NULL,
     IngresosAlJun	money		NULL,
     IngresosAlJul	money		NULL,
     IngresosAlAgo	money		NULL,
     IngresosAlSep	money		NULL,
     IngresosAlOct	money		NULL,
     IngresosAlNov	money		NULL,
     IngresosAlDic	money		NULL,
     Porcentaje		float		NULL,
     PorcentajeAlEne	float		NULL,
     PorcentajeAlFeb	float		NULL,
     PorcentajeAlMar	float		NULL,
     PorcentajeAlAbr	float		NULL,
     PorcentajeAlMay	float		NULL,
     PorcentajeAlJun	float		NULL,
     PorcentajeAlJul	float		NULL,
     PorcentajeAlAgo	float		NULL,
     PorcentajeAlSep	float		NULL,
     PorcentajeAlOct	float		NULL,
     PorcentajeAlNov	float		NULL,
     PorcentajeAlDic	float		NULL

     CONSTRAINT priTempResultado PRIMARY KEY CLUSTERED (ID)
  )

   SELECT /*@ConMovs = UPPER(@ConMovs),*/ @CentroCostos = NULLIF(RTRIM(@CentroCostos), '')
   IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)', '(ALL)') SELECT @CentroCostos = NULL
   IF @UEN = 0 SELECT @UEN = NULL
   IF UPPER(@Proyecto)      IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
   IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
   IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

   IF @CentroCostos='Sin CC' SELECT @CentroCostos = '' --BUG2517

   SELECT DISTINCT
          @CtaResultados   = CtaResultados,
    	  @CtaIngresos	   = CtaIngresos,
    	  @CtaCostoDirecto = CtaCostoDirecto,
		  @CtaGastosOperacion = CtaGastosOperacion,
	      @CtaOtrosGastosProductos = CtaOtrosGastosProductos
     FROM EmpresaCfg 
    WHERE Empresa = @Empresa

  -- Ventas
  INSERT #ResultadoAnual
  SELECT 1, "Utilidad Bruta",
	 "Ventas",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
         FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaIngresos OR Rama.Rama = @CtaIngresos)

  -- Costos
  INSERT #ResultadoAnual
  SELECT 2, "Utilidad Bruta",
	 "Costos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaCostoDirecto OR Rama.Rama = @CtaCostoDirecto)

  -- Gastos de Operacion
  INSERT #ResultadoAnual
  SELECT 3, "Utilidad Antes de Impuestos",
	 "Gastos",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
         FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaGastosOperacion OR Rama.Rama = @CtaGastosOperacion)

  -- Otros Gastos y Productos
  INSERT #ResultadoAnual
  SELECT 3, "Utilidad Antes de Impuestos",
	 "Gastos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaOtrosGastosProductos OR Rama.Rama = @CtaOtrosGastosProductos)
     
  -- Otros
  INSERT #ResultadoAnual
  SELECT 5, "Utilidad Después de Impuestos",
	 "Otros",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaResultados OR Rama.Rama = @CtaResultados)
     AND (Cta.Rama <> @CtaIngresos AND Rama.Rama <> @CtaIngresos)
     AND (Cta.Rama <> @CtaCostoDirecto AND Rama.Rama <> @CtaCostoDirecto)
	 AND (Cta.Rama <> @CtaGastosOperacion AND Rama.Rama <> @CtaGastosOperacion)
	 AND (Cta.Rama <> @CtaOtrosGastosProductos AND Rama.Rama <> @CtaOtrosGastosProductos)

  -- Ingresos Acumulados
  IF @CentroCostos IS NULL
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Ejercicio = @Ejercicio 
       AND a.Moneda = @Moneda
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
/*       AND Periodo BETWEEN @PeriodoD AND @PeriodoA*/
   ELSE
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
/*       AND Periodo BETWEEN @PeriodoD AND @PeriodoA*/

  -- Ingresos al Mes 
  IF @CentroCostos IS NULL
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.SubCuenta = @CentroCostos
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       --AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  --SELECT @IngresosAlFeb, @CtaIngresos, @CentroCostos, @Ejercicio, @Moneda, @Empresa, @CentroCostos2, @CentroCostos3, @UEN, @Proyecto

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  -- Saldo Acumulado
  IF @CentroCostos IS NULL
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND a.Moneda = @Moneda
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
		AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.SubCuenta = @CentroCostos
        AND a.Moneda = @Moneda
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
		AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b
  
  OPEN crResultado
  FETCH NEXT FROM crResultado INTO @ID, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      UPDATE #ResultadoAnual
         SET Saldo = @Saldo,
             Ingresos = @Ingresos,
             Porcentaje = (@Saldo/@Ingresos)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultado INTO @ID, @Saldo
  END
  CLOSE crResultado
  DEALLOCATE crResultado

  --SELECT 'XXXX', Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = 'S' AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  -- Saldo al Mes 
  IF @CentroCostos IS NULL
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), ''))
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), ''))
        FROM #ResultadoAnual b
  OPEN crResultadoAl
  FETCH NEXT FROM crResultadoAl INTO @ID, @SaldoAlEne, @SaldoAlFeb, @SaldoAlMar, @SaldoAlAbr, @SaldoAlMay, @SaldoAlJun, @SaldoAlJul, @SaldoAlAgo, @SaldoAlSep, @SaldoAlOct, @SaldoAlNov, @SaldoAlDic/*, @IngresosAlEne, @IngresosAlFeb, @IngresosAlMar, @IngresosAlAbr, @IngresosAlMay, @IngresosAlJun, @IngresosAlJul, @IngresosAlAgo, @IngresosAlSep, @IngresosAlOct, @IngresosAlNov, @IngresosAlDic, @PorcentajeAlEne, @PorcentajeAlFeb, @PorcentajeAlMar, @PorcentajeAlAbr, @PorcentajeAlMay, @PorcentajeAlJun, @PorcentajeAlJul, @PorcentajeAlAgo, @PorcentajeAlSep, @PorcentajeAlOct, @PorcentajeAlNov, @PorcentajeAlDic*/
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      UPDATE #ResultadoAnual 
         SET SaldoAlEne = @SaldoAlEne,
             SaldoAlFeb = @SaldoAlFeb,
             SaldoAlMar = @SaldoAlMar,
             SaldoAlAbr = @SaldoAlAbr,
             SaldoAlMay = @SaldoAlMay,
             SaldoAlJun = @SaldoAlJun,
             SaldoAlJul = @SaldoAlJul,
             SaldoAlAgo = @SaldoAlAgo,
             SaldoAlSep = @SaldoAlSep,
             SaldoAlOct = @SaldoAlOct,
             SaldoAlNov = @SaldoAlNov,
             SaldoAlDic = @SaldoAlDic,
	     IngresosAlEne = @IngresosAlEne,
	     IngresosAlFeb = @IngresosAlFeb,
	     IngresosAlMar = @IngresosAlMar,
	     IngresosAlAbr = @IngresosAlAbr,
	     IngresosAlMay = @IngresosAlMay,
	     IngresosAlJun = @IngresosAlJun,
	     IngresosAlJul = @IngresosAlJul,
	     IngresosAlAgo = @IngresosAlAgo,
	     IngresosAlSep = @IngresosAlSep,
	     IngresosAlOct = @IngresosAlOct,
	     IngresosAlNov = @IngresosAlNov,
	     IngresosAlDic = @IngresosAlDic,
             PorcentajeAlEne = (@SaldoAlEne/@IngresosAlEne)*100,
             PorcentajeAlFeb = (@SaldoAlFeb/@IngresosAlFeb)*100,
             PorcentajeAlMar = (@SaldoAlMar/@IngresosAlMar)*100,
             PorcentajeAlAbr = (@SaldoAlAbr/@IngresosAlAbr)*100,
             PorcentajeAlMay = (@SaldoAlMay/@IngresosAlMay)*100,
             PorcentajeAlJun = (@SaldoAlJun/@IngresosAlJun)*100,
             PorcentajeAlJul = (@SaldoAlJul/@IngresosAlJul)*100,
             PorcentajeAlAgo = (@SaldoAlAgo/@IngresosAlAgo)*100,
             PorcentajeAlSep = (@SaldoAlSep/@IngresosAlSep)*100,
             PorcentajeAlOct = (@SaldoAlOct/@IngresosAlOct)*100,
             PorcentajeAlNov = (@SaldoAlNov/@IngresosAlNov)*100,
             PorcentajeAlDic = (@SaldoAlDic/@IngresosAlDic)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultadoAl INTO @ID, @SaldoAlEne, @SaldoAlFeb, @SaldoAlMar, @SaldoAlAbr, @SaldoAlMay, @SaldoAlJun, @SaldoAlJul, @SaldoAlAgo, @SaldoAlSep, @SaldoAlOct, @SaldoAlNov, @SaldoAlDic/*, @IngresosAlEne, @IngresosAlFeb, @IngresosAlMar, @IngresosAlAbr, @IngresosAlMay, @IngresosAlJun, @IngresosAlJul, @IngresosAlAgo, @IngresosAlSep, @IngresosAlOct, @IngresosAlNov, @IngresosAlDic, @PorcentajeAlEne, @PorcentajeAlFeb, @PorcentajeAlMar, @PorcentajeAlAbr, @PorcentajeAlMay, @PorcentajeAlJun, @PorcentajeAlJul, @PorcentajeAlAgo, @PorcentajeAlSep, @PorcentajeAlOct, @PorcentajeAlNov, @PorcentajeAlDic*/
  END
  CLOSE crResultadoAl
  DEALLOCATE crResultadoAl

/*  IF @ConMovs = 'SI' 
  SELECT * FROM #ResultadoAnual WHERE ISNULL(Saldo, 0.0) <> 0.0 OR ISNULL(SaldoAlEne, 0.0) <> 0.0
  ELSE*/
    SELECT * FROM #ResultadoAnual
END
GO
/**************** spRSContResultadosPresup ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRSContResultadosPresup') and type = 'P') drop procedure dbo.spRSContResultadosPresup
GO
CREATE PROCEDURE spRSContResultadosPresup
    --@Estacion		int,
	@Empresa		char(5),
	@Ejercicio		int,
	--@PeriodoD		int,
	--@PeriodoA		int,
	@ConMovs		char(20)    = 'NO',
	@CentroCostos	varchar(Max) = NULL,
	@Sucursal		int	    = NULL,
	@OrdenCC		char(20)    = 'NO',
	@Moneda			char(10)    = NULL,
	@CCGrupo		varchar(50) = NULL,
    --@Controladora		char(5)     = NULL,
	@UEN			int	    = NULL,
	@Proyecto		varchar(50) = NULL,
	@CentroCostos2		varchar(50) = NULL,
	@CentroCostos3		varchar(50) = NULL
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE 
 		  @CentroCostosAux		varchar(20),
		  @CentroCostosAuxAnt	varchar(20),
		  @Rama                 varchar(20),
		  @Cuenta               varchar(20),
		  @SubCuenta            varchar(20),
		  @Periodo              int, 
		  @Saldo                money

  CREATE TABLE #Temp(
     Orden		int		NULL,
     ID					int			NULL,
     Clase				varchar(50)	COLLATE Database_Default NULL,
     SubClase			varchar(20)	COLLATE Database_Default NULL,
     Rama				varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     RamaEsAcreedora	bit			NOT NULL DEFAULT 0,
     Cuenta				varchar(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
     EsAcreedora		bit			NOT NULL DEFAULT 0,
     Saldo				money		NULL,
     SaldoAlEne			money		NULL,
     SaldoAlFeb			money		NULL,
     SaldoAlMar			money		NULL,
     SaldoAlAbr			money		NULL,
     SaldoAlMay			money		NULL,
     SaldoAlJun			money		NULL,
     SaldoAlJul			money		NULL,
     SaldoAlAgo			money		NULL,
     SaldoAlSep			money		NULL,
     SaldoAlOct 		money		NULL,
     SaldoAlNov			money		NULL,
     SaldoAlDic			money		NULL,
     Ingresos			money		NULL,
     IngresosAlEne		money		NULL,
     IngresosAlFeb		money		NULL,
     IngresosAlMar		money		NULL,
     IngresosAlAbr		money		NULL,
     IngresosAlMay		money		NULL,
     IngresosAlJun		money		NULL,
     IngresosAlJul		money		NULL,
     IngresosAlAgo		money		NULL,
     IngresosAlSep		money		NULL,
     IngresosAlOct		money		NULL,
     IngresosAlNov		money		NULL,
     IngresosAlDic		money		NULL,
     Porcentaje			float		NULL,
     PorcentajeAlEne	float		NULL,
     PorcentajeAlFeb	float		NULL,
     PorcentajeAlMar	float		NULL,
     PorcentajeAlAbr	float		NULL,
     PorcentajeAlMay	float		NULL,
     PorcentajeAlJun	float		NULL,
     PorcentajeAlJul	float		NULL,
     PorcentajeAlAgo	float		NULL,
     PorcentajeAlSep	float		NULL,
     PorcentajeAlOct	float		NULL,
     PorcentajeAlNov	float		NULL,
     PorcentajeAlDic	float		NULL
  )

  CREATE TABLE #Consolidado(
     Orden		int		NULL,
     RID				int			IDENTITY(1,1) NOT NULL,
	 CentroCostos       varchar(20) COLLATE Database_Default NULL,
     Clase				varchar(50)	COLLATE Database_Default NULL,
     SubClase			varchar(20)	COLLATE Database_Default NULL,
     Rama				varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     RamaEsAcreedora	bit NULL DEFAULT 0,
     Cuenta				varchar(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
     EsAcreedora		bit			NULL DEFAULT 0,
     Saldo				money		NULL,
     SaldoAlEne			money		NULL,
     SaldoAlFeb			money		NULL,
     SaldoAlMar			money		NULL,
     SaldoAlAbr			money		NULL,
     SaldoAlMay			money		NULL,
     SaldoAlJun			money		NULL,
     SaldoAlJul			money		NULL,
     SaldoAlAgo			money		NULL,
     SaldoAlSep			money		NULL,
     SaldoAlOct 		money		NULL,
     SaldoAlNov			money		NULL,
     SaldoAlDic			money		NULL,
     Ingresos			money		NULL,
     PresupuestoAlEne	money		NULL,
     PresupuestoAlFeb	money		NULL,
     PresupuestoAlMar	money		NULL,
     PresupuestoAlAbr	money		NULL,
     PresupuestoAlMay	money		NULL,
     PresupuestoAlJun	money		NULL,
     PresupuestoAlJul	money		NULL,
     PresupuestoAlAgo	money		NULL,
     PresupuestoAlSep	money		NULL,
     PresupuestoAlOct	money		NULL,
     PresupuestoAlNov	money		NULL,
     PresupuestoAlDic	money		NULL
  )
  
  SELECT * INTO #ConsolidadopPpto FROM #Consolidado

  SELECT * INTO #Consolidado_S_UAFIRDA FROM #Consolidado --BUG2771
  SELECT * INTO #Consolidado_T_UAFIRDA FROM #Consolidado --BUG2771
  SELECT * INTO #Consolidado_U_UAFIRDA FROM #Consolidado --BUG2771
  SELECT * INTO #Consolidado_U2_UAFIRDA FROM #Consolidado --BUG2771
  SELECT * INTO #Consolidado_U3_UAFIRDA FROM #Consolidado --BUG2771
  
  CREATE TABLE #Presupuesto(
      Rama      varchar(20) COLLATE Database_Default NULL,
      Cuenta     varchar(20) COLLATE Database_Default NULL,
	  SubCuenta	 varchar(20) COLLATE Database_Default NULL,
	  Periodo    int,
	  Saldo		 money       NULL
   )

  IF @Moneda='' SELECT @Moneda = NULL
  IF @UEN='' SELECT @UEN = NULL
  IF @Proyecto='' SELECT @Proyecto = NULL
  IF @CentroCostos2='' SELECT @CentroCostos2 = NULL
  IF @CentroCostos3='' SELECT @CentroCostos3 = NULL
  
  IF @CentroCostos='(Sin Desglose)' AND LEN(@CentroCostos)<=14 SELECT @CentroCostos = NULL --BUG2771
  IF @CentroCostos<>'(Sin Desglose)' AND LEN(@CentroCostos)>14 SELECT @CentroCostos = '(Todos)' --BUG2771
  --SELECT @CentroCostos, LEN(@CentroCostos)

  SELECT @Ejercicio = CONVERT(int, @Ejercicio),
		 @UEN = CONVERT(int, @UEN)

--SELECT Ctx.Cuenta, Cty.Rama, Ctz.Rama, y.Cuenta, y.SubCuenta, x.Periodo, SaldoP = Sum(ISNULL(y.Debe, 0.0)) -- Sum(ISNULL(y.Haber, 0.0))
--	   FROM Cont x
--	   JOIN ContD y ON x.ID = y.ID
--	   JOIN Cta Ctz ON Ctz.Cuenta = y.Cuenta
--	   JOIN Cta Cty ON Cty.Cuenta = Ctz.Rama
--	   JOIN Cta Ctx ON Ctx.Cuenta = Cty.Rama
--	  WHERE x.Mov = 'Presupuesto'
--		AND x.Estatus = 'CONCLUIDO'
--		AND x.Empresa = @Empresa
--		AND x.Moneda = 'Pesos'
--		AND x.Ejercicio = @Ejercicio
--		--AND x.Periodo BETWEEN @PeriodoD AND @PeriodoA
--		--AND ISNULL(y.SubCuenta, '') >= ISNULL(ISNULL(@CentroCostosD, y.SubCuenta), '')
--		--AND ISNULL(y.SubCuenta, '') <= ISNULL(ISNULL(@CentroCostosA, y.SubCuenta), '')
--		AND ISNULL(x.Sucursal, 0)    = ISNULL(ISNULL(@Sucursal, x.Sucursal), 0)
--	  GROUP BY Ctx.Cuenta, Cty.Rama, Ctz.Rama, y.Cuenta, y.SubCuenta, x.Periodo 
--	  --x.OrigenTipo, x.Origen, x.OrigenID                       
--	  --HAVING Sum(ISNULL(y.Debe, 0.0)) - Sum(ISNULL(y.Haber, 0.0)) <> 0.0

  IF ISNULL(@CentroCostos,'') = ''
	  INSERT INTO #Presupuesto(
				 Rama, Cuenta, SubCuenta, Periodo,    Saldo)
	  SELECT Ctx.Cuenta, y.Cuenta, NULL, x.Periodo, SaldoP = Sum(ISNULL(y.Debe, 0.0)) -- Sum(ISNULL(y.Haber, 0.0))
	   FROM Cont x
	   JOIN ContD y ON x.ID = y.ID
	   JOIN Cta Ctz ON Ctz.Cuenta = y.Cuenta
	   JOIN Cta Cty ON Cty.Cuenta = Ctz.Rama
	   JOIN Cta Ctx ON Ctx.Cuenta = Cty.Rama
	  WHERE x.Mov = 'Presupuesto'
		AND x.Estatus = 'CONCLUIDO'
		AND x.Empresa = @Empresa
		AND x.Moneda = 'Pesos'
		AND x.Ejercicio = @Ejercicio
		--AND x.Periodo BETWEEN @PeriodoD AND @PeriodoA
		--AND ISNULL(y.SubCuenta, '') >= ISNULL(ISNULL(@CentroCostosD, y.SubCuenta), '')
		--AND ISNULL(y.SubCuenta, '') <= ISNULL(ISNULL(@CentroCostosA, y.SubCuenta), '')
		AND ISNULL(x.Sucursal, 0)    = ISNULL(ISNULL(@Sucursal, x.Sucursal), 0)
	  GROUP BY Ctx.Cuenta, y.Cuenta, x.Periodo 
	  --x.OrigenTipo, x.Origen, x.OrigenID                       
	  --HAVING Sum(ISNULL(y.Debe, 0.0)) - Sum(ISNULL(y.Haber, 0.0)) <> 0.0
	ELSE
	  INSERT INTO #Presupuesto(
				 Rama, Cuenta, SubCuenta, Periodo,    Saldo)
	  SELECT Ctx.Cuenta, y.Cuenta, y.SubCuenta, x.Periodo, SaldoP = Sum(ISNULL(y.Debe, 0.0)) -- Sum(ISNULL(y.Haber, 0.0))
	   FROM Cont x
	   JOIN ContD y ON x.ID = y.ID
	   JOIN Cta Ctz ON Ctz.Cuenta = y.Cuenta
	   JOIN Cta Cty ON Cty.Cuenta = Ctz.Rama
	   JOIN Cta Ctx ON Ctx.Cuenta = Cty.Rama
	  WHERE x.Mov = 'Presupuesto'
		AND x.Estatus = 'CONCLUIDO'
		AND x.Empresa = @Empresa
		AND x.Moneda = 'Pesos'
		AND x.Ejercicio = @Ejercicio
		--AND x.Periodo BETWEEN @PeriodoD AND @PeriodoA
		--AND ISNULL(y.SubCuenta, '') >= ISNULL(ISNULL(@CentroCostosD, y.SubCuenta), '')
		--AND ISNULL(y.SubCuenta, '') <= ISNULL(ISNULL(@CentroCostosA, y.SubCuenta), '')
		AND ISNULL(x.Sucursal, 0)    = ISNULL(ISNULL(@Sucursal, x.Sucursal), 0)
	  GROUP BY Ctx.Cuenta, y.Cuenta, y.SubCuenta, x.Periodo 
	  --x.OrigenTipo, x.Origen, x.OrigenID                       
	  --HAVING Sum(ISNULL(y.Debe, 0.0)) - Sum(ISNULL(y.Haber, 0.0)) <> 0.0

  CREATE TABLE #CentroCostos(CentroCostos varchar(20) COLLATE Database_Default )

  IF ISNULL(@CentroCostos,'') = ''
  --IF ISNULL(@CentroCostos,'') = 'Global' --REQ2313
  BEGIN
    --EXEC spVerContResultadosEmpresaSucursalAnualRS @Empresa, @Ejercicio, @Sucursal, '', @Moneda, @UEN, @Proyecto, @CentroCostos2, @CentroCostos3
	INSERT INTO #Temp(
         Orden, ID, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic)
	EXEC spVerContResultadosEmpresaSucursalAnualRS @Empresa, @Ejercicio, @Sucursal, '', @Moneda, @UEN, @Proyecto, @CentroCostos2, @CentroCostos3

    IF EXISTS(SELECT * FROM #Temp)
      INSERT INTO #Consolidado(
			   Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic)
            SELECT Orden, '',       Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, ISNULL(Saldo,0), ISNULL(SaldoAlEne,0), ISNULL(SaldoAlFeb,0), ISNULL(SaldoAlMar,0), ISNULL(SaldoAlAbr,0), ISNULL(SaldoAlMay,0), ISNULL(SaldoAlJun,0), ISNULL(SaldoAlJul,0), ISNULL(SaldoAlAgo,0), ISNULL(SaldoAlSep,0), ISNULL(SaldoAlOct,0), ISNULL(SaldoAlNov,0), ISNULL(SaldoAlDic,0)
          FROM #Temp

	  SELECT @CentroCostos = NULL
  END

  IF ISNULL(@CentroCostos,'') LIKE '%(Todos)%'
  BEGIN
	INSERT INTO #CentroCostos SELECT CentroCostos FROM CentroCostos
	INSERT INTO #CentroCostos SELECT 'Sin CC' --BUG2517
	SELECT @CentroCostos = NULL
  END

  IF @CentroCostos IS NOT NULL
  BEGIN
   INSERT INTO #CentroCostos SELECT ValorTexto FROM dbo.fnParseaCadena(@CentroCostos, ',')
   DELETE FROM #CentroCostos WHERE CentroCostos='(Sin Desglose)'  --BUG2771
  END

  SELECT @CentroCostosAuxAnt = ''
  WHILE(1=1)
  BEGIN

	 SELECT @CentroCostosAux = MIN(CentroCostos)
      FROM #CentroCostos
     WHERE CentroCostos > @CentroCostosAuxAnt

    IF @CentroCostosAux IS NULL BREAK

    SELECT @CentroCostosAuxAnt = @CentroCostosAux 
	
    TRUNCATE TABLE #Temp
	
    INSERT INTO #Temp(
            Orden, ID, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic)
	   EXEC spVerContResultadosEmpresaSucursalAnualRS @Empresa, @Ejercicio, @Sucursal, @CentroCostosAux, @Moneda, @UEN,  @Proyecto, @CentroCostos2, @CentroCostos3

    IF EXISTS(SELECT * FROM #Temp)
      INSERT INTO #Consolidado(
		          Orden, CentroCostos,    Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic)
        SELECT Orden, @CentroCostosAux, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, ISNULL(Saldo,0), ISNULL(SaldoAlEne,0), ISNULL(SaldoAlFeb,0), ISNULL(SaldoAlMar,0), ISNULL(SaldoAlAbr,0), ISNULL(SaldoAlMay,0), ISNULL(SaldoAlJun,0), ISNULL(SaldoAlJul,0), ISNULL(SaldoAlAgo,0), ISNULL(SaldoAlSep,0), ISNULL(SaldoAlOct,0), ISNULL(SaldoAlNov,0), ISNULL(SaldoAlDic,0)
          FROM #Temp
  END

  --SELECT * FROM #Consolidado WHERE CentroCostos='4000'

  --select * from #Temp

--  SELECT Rama, Cuenta, SubCuenta, Periodo, SUM(Saldo) as Saldo
--  FROM #Presupuesto
----WHERE Periodo=6 AND SubCuenta IS NULL
----Rama='5200-0000-0000' AND 
--  GROUP BY Rama, Cuenta, SubCuenta, Periodo
----  ORDER BY Periodo, Rama, Cuenta, SubCuenta

  DECLARE #crPresupuesto CURSOR FOR
  SELECT Rama, /*Cuenta,*/ SubCuenta, Periodo, SUM(Saldo) as Saldo
  --SELECT Cuenta, SubCuenta, Periodo, SUM(Saldo) as Saldo
  FROM #Presupuesto
  --WHERE SubCuenta IS NOT NULL
  --WHERE Periodo=6 AND SubCuenta IS NULL
  GROUP BY Rama, /*Cuenta,*/ SubCuenta, Periodo
  --GROUP BY Cuenta, SubCuenta, Periodo
  OPEN #crPresupuesto
  FETCH NEXT FROM #crPresupuesto INTO @Rama, /*@Cuenta,*/ @SubCuenta, @Periodo, @Saldo
  --FETCH NEXT FROM #crPresupuesto INTO @Rama, @SubCuenta, @Periodo, @Saldo
  WHILE @@FETCH_STATUS = 0
    BEGIN
	   IF @Periodo=1 AND @SubCuenta IS NOT NULL
	     UPDATE #Consolidado SET PresupuestoAlEne=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
	   IF @Periodo=1 AND @SubCuenta IS NULL
	     INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlEne)
	       SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	         FROM #Consolidado
		    WHERE Cuenta=@Rama                   
       
	   IF @Periodo=2 AND @SubCuenta IS NOT NULL
	     UPDATE #Consolidado SET PresupuestoAlFeb=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
	   IF @Periodo=2 AND @SubCuenta IS NULL
	     INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlFeb)
	       SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	         FROM #Consolidado
		    WHERE Cuenta=@Rama  

	   IF @Periodo=3 AND @SubCuenta IS NOT NULL
	     UPDATE #Consolidado SET PresupuestoAlMar=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
	   IF @Periodo=3 AND @SubCuenta IS NULL
	     INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlMar)
	       SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	         FROM #Consolidado
		    WHERE Cuenta=@Rama  

	   IF @Periodo=4 AND @SubCuenta IS NOT NULL
	     UPDATE #Consolidado SET PresupuestoAlAbr=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
	   IF @Periodo=4 AND @SubCuenta IS NULL
	     INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlAbr)
	       SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	         FROM #Consolidado
		    WHERE Cuenta=@Rama  

	   IF @Periodo=5 AND @SubCuenta IS NOT NULL
	     UPDATE #Consolidado SET PresupuestoAlMay=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
	   IF @Periodo=5 AND @SubCuenta IS NULL
	     INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlMay)
	       SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	         FROM #Consolidado
		    WHERE Cuenta=@Rama  

	   IF @Periodo=6 AND @SubCuenta IS NOT NULL
         UPDATE #Consolidado SET PresupuestoAlJun=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
       ELSE IF @Periodo=6 AND @SubCuenta IS NULL
             BEGIN
              --SELECT @Rama
	          INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlJun)
	            SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	             FROM #Consolidado
		        WHERE Cuenta=@Rama
             END       

	   IF @Periodo=7 AND @SubCuenta IS NOT NULL
	     UPDATE #Consolidado SET PresupuestoAlJul=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
	   IF @Periodo=7 AND @SubCuenta IS NULL
	     INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlJul)
	       SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	         FROM #Consolidado
		    WHERE Cuenta=@Rama 

	   IF @Periodo=8 AND @SubCuenta IS NOT NULL
	     UPDATE #Consolidado SET PresupuestoAlAgo=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
	   IF @Periodo=8 AND @SubCuenta IS NULL
	     INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlAgo)
	       SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	         FROM #Consolidado
		    WHERE Cuenta=@Rama 

	   IF @Periodo=9 AND @SubCuenta IS NOT NULL
	     UPDATE #Consolidado SET PresupuestoAlSep=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
	   IF @Periodo=9 AND @SubCuenta IS NULL
	     INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlSep)
	       SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	         FROM #Consolidado
		    WHERE Cuenta=@Rama 

	   IF @Periodo=10 AND @SubCuenta IS NOT NULL
	     UPDATE #Consolidado SET PresupuestoAlOct=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
	   IF @Periodo=10 AND @SubCuenta IS NULL
	     INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlOct)
	       SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	         FROM #Consolidado
		    WHERE Cuenta=@Rama 

	   IF @Periodo=11 AND @SubCuenta IS NOT NULL
	     UPDATE #Consolidado SET PresupuestoAlNov=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
	   IF @Periodo=11 AND @SubCuenta IS NULL
	     INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlNov)
	       SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	         FROM #Consolidado
		    WHERE Cuenta=@Rama 

	   IF @Periodo=12 AND @SubCuenta IS NOT NULL
	     UPDATE #Consolidado SET PresupuestoAlDic=@Saldo WHERE Cuenta=@Rama AND CentroCostos=ISNULL(@SubCuenta,CentroCostos)
	   IF @Periodo=12 AND @SubCuenta IS NULL
	     INSERT INTO #ConsolidadopPpto(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlDic)
	       SELECT TOP 1 Orden, CASE WHEN CentroCostos='' THEN '' ELSE 'GENERAL PPTO' END, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, ISNULL(@Saldo,0)
	         FROM #Consolidado
		    WHERE Cuenta=@Rama 
      
      FETCH NEXT FROM #crPresupuesto INTO @Rama, /*@Cuenta,*/ @SubCuenta, @Periodo, @Saldo
      --FETCH NEXT FROM #crPresupuesto INTO @Rama, @SubCuenta, @Periodo, @Saldo
	END
  CLOSE #crPresupuesto
  DEALLOCATE #crPresupuesto

  --select * from #ConsolidadopPpto

  INSERT INTO #Consolidado(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, PresupuestoAlEne, PresupuestoAlFeb, PresupuestoAlMar, PresupuestoAlAbr, PresupuestoAlMay, PresupuestoAlJun, PresupuestoAlJul, PresupuestoAlAgo, PresupuestoAlSep, PresupuestoAlOct, PresupuestoAlNov, PresupuestoAlDic)
  SELECT Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, SUM(ISNULL(PresupuestoAlEne,0)), SUM(ISNULL(PresupuestoAlFeb,0)), SUM(ISNULL(PresupuestoAlMar,0)), SUM(ISNULL(PresupuestoAlAbr,0)), SUM(ISNULL(PresupuestoAlMay,0)), SUM(ISNULL(PresupuestoAlJun,0)), SUM(ISNULL(PresupuestoAlJul,0)), SUM(ISNULL(PresupuestoAlAgo,0)), SUM(ISNULL(PresupuestoAlSep,0)), SUM(ISNULL(PresupuestoAlOct,0)), SUM(ISNULL(PresupuestoAlNov,0)), SUM(ISNULL(PresupuestoAlDic,0))
  FROM #ConsolidadopPpto
  GROUP BY Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion
  
  --BUG2771
  INSERT INTO #Consolidado_S_UAFIRDA
        (CentroCostos, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, PresupuestoAlEne, PresupuestoAlFeb, PresupuestoAlMar, PresupuestoAlAbr, PresupuestoAlMay, PresupuestoAlJun, PresupuestoAlJul, PresupuestoAlAgo, PresupuestoAlSep, PresupuestoAlOct, PresupuestoAlNov, PresupuestoAlDic)
  SELECT '', 4, 'Utilidad Bruta - Ventas', 'UAFIRDA', Rama, 'UAFIRDA', 0, '', '', 0,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN Saldo*-1 ELSE Saldo END) Saldo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlEne*-1 ELSE SaldoAlEne END) SaldoAlEne,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlFeb*-1 ELSE SaldoAlFeb END) SaldoAlFeb,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMar*-1 ELSE SaldoAlMar END) SaldoAlMar,
		 SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAbr*-1 ELSE SaldoAlAbr END) SaldoAlAbr,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMay*-1 ELSE SaldoAlMay END) SaldoAlMay,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJun*-1 ELSE SaldoAlJun END) SaldoAlJun,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJul*-1 ELSE SaldoAlJul END) SaldoAlJul,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAgo*-1 ELSE SaldoAlAgo END) SaldoAlAgo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlSep*-1 ELSE SaldoAlSep END) SaldoAlSep,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlOct*-1 ELSE SaldoAlOct END) SaldoAlOct,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlNov*-1 ELSE SaldoAlNov END) SaldoAlNov,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlDic*-1 ELSE SaldoAlDic END) SaldoAlDic,
         --BUG2925
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlEne,0)*-1 ELSE ISNULL(PresupuestoAlEne,0) END) PresupuestoAlEne,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlFeb,0)*-1 ELSE ISNULL(PresupuestoAlFeb,0) END) PresupuestoAlFeb,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlMar,0)*-1 ELSE ISNULL(PresupuestoAlMar,0) END) PresupuestoAlMar,
		 SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlAbr,0)*-1 ELSE ISNULL(PresupuestoAlAbr,0) END) PresupuestoAlAbr,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlMay,0)*-1 ELSE ISNULL(PresupuestoAlMay,0) END) PresupuestoAlMay,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlJun,0)*-1 ELSE ISNULL(PresupuestoAlJun,0) END) PresupuestoAlJun,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlJul,0)*-1 ELSE ISNULL(PresupuestoAlJul,0) END) PresupuestoAlJul,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlAgo,0)*-1 ELSE ISNULL(PresupuestoAlAgo,0) END) PresupuestoAlAgo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlSep,0)*-1 ELSE ISNULL(PresupuestoAlSep,0) END) PresupuestoAlSep,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlOct,0)*-1 ELSE ISNULL(PresupuestoAlOct,0) END) PresupuestoAlOct,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlNov,0)*-1 ELSE ISNULL(PresupuestoAlNov,0) END) PresupuestoAlNov,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlDic,0)*-1 ELSE ISNULL(PresupuestoAlDic,0) END) PresupuestoAlDic
  FROM #Consolidado 
  WHERE Rama IN ('S')
  GROUP BY Rama --, RamaEsAcreedora

  --BUG2771
  INSERT INTO #Consolidado_T_UAFIRDA
        (CentroCostos, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, PresupuestoAlEne, PresupuestoAlFeb, PresupuestoAlMar, PresupuestoAlAbr, PresupuestoAlMay, PresupuestoAlJun, PresupuestoAlJul, PresupuestoAlAgo, PresupuestoAlSep, PresupuestoAlOct, PresupuestoAlNov, PresupuestoAlDic)
  SELECT '', 4, 'Utilidad Bruta - Costo Ventas', 'UAFIRDA', Rama, 'UAFIRDA', 0, '', '', 0,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN Saldo*-1 ELSE Saldo END) Saldo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlEne*-1 ELSE SaldoAlEne END) SaldoAlEne,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlFeb*-1 ELSE SaldoAlFeb END) SaldoAlFeb,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMar*-1 ELSE SaldoAlMar END) SaldoAlMar,
		 SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAbr*-1 ELSE SaldoAlAbr END) SaldoAlAbr,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMay*-1 ELSE SaldoAlMay END) SaldoAlMay,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJun*-1 ELSE SaldoAlJun END) SaldoAlJun,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJul*-1 ELSE SaldoAlJul END) SaldoAlJul,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAgo*-1 ELSE SaldoAlAgo END) SaldoAlAgo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlSep*-1 ELSE SaldoAlSep END) SaldoAlSep,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlOct*-1 ELSE SaldoAlOct END) SaldoAlOct,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlNov*-1 ELSE SaldoAlNov END) SaldoAlNov,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlDic*-1 ELSE SaldoAlDic END) SaldoAlDic,
         --BUG2925
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlEne,0)*-1 ELSE ISNULL(PresupuestoAlEne,0) END) PresupuestoAlEne,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlFeb,0)*-1 ELSE ISNULL(PresupuestoAlFeb,0) END) PresupuestoAlFeb,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlMar,0)*-1 ELSE ISNULL(PresupuestoAlMar,0) END) PresupuestoAlMar,
		 SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlAbr,0)*-1 ELSE ISNULL(PresupuestoAlAbr,0) END) PresupuestoAlAbr,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlMay,0)*-1 ELSE ISNULL(PresupuestoAlMay,0) END) PresupuestoAlMay,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlJun,0)*-1 ELSE ISNULL(PresupuestoAlJun,0) END) PresupuestoAlJun,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlJul,0)*-1 ELSE ISNULL(PresupuestoAlJul,0) END) PresupuestoAlJul,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlAgo,0)*-1 ELSE ISNULL(PresupuestoAlAgo,0) END) PresupuestoAlAgo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlSep,0)*-1 ELSE ISNULL(PresupuestoAlSep,0) END) PresupuestoAlSep,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlOct,0)*-1 ELSE ISNULL(PresupuestoAlOct,0) END) PresupuestoAlOct,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlNov,0)*-1 ELSE ISNULL(PresupuestoAlNov,0) END) PresupuestoAlNov,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlDic,0)*-1 ELSE ISNULL(PresupuestoAlDic,0) END) PresupuestoAlDic
  FROM #Consolidado 
  WHERE Rama IN ('T')
  GROUP BY Rama --, RamaEsAcreedora
  
  --BUG2771
  INSERT INTO #Consolidado_U_UAFIRDA
        (CentroCostos, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, PresupuestoAlEne, PresupuestoAlFeb, PresupuestoAlMar, PresupuestoAlAbr, PresupuestoAlMay, PresupuestoAlJun, PresupuestoAlJul, PresupuestoAlAgo, PresupuestoAlSep, PresupuestoAlOct, PresupuestoAlNov, PresupuestoAlDic)
  SELECT '', 4, 'Gastos de Operación', 'UAFIRDA', Rama, 'UAFIRDA', 0, '', '', 0,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN Saldo*-1 ELSE Saldo END) Saldo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlEne*-1 ELSE SaldoAlEne END) SaldoAlEne,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlFeb*-1 ELSE SaldoAlFeb END) SaldoAlFeb,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMar*-1 ELSE SaldoAlMar END) SaldoAlMar,
		 SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAbr*-1 ELSE SaldoAlAbr END) SaldoAlAbr,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMay*-1 ELSE SaldoAlMay END) SaldoAlMay,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJun*-1 ELSE SaldoAlJun END) SaldoAlJun,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJul*-1 ELSE SaldoAlJul END) SaldoAlJul,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAgo*-1 ELSE SaldoAlAgo END) SaldoAlAgo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlSep*-1 ELSE SaldoAlSep END) SaldoAlSep,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlOct*-1 ELSE SaldoAlOct END) SaldoAlOct,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlNov*-1 ELSE SaldoAlNov END) SaldoAlNov,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlDic*-1 ELSE SaldoAlDic END) SaldoAlDic,
         --BUG2925
--         SUM(PresupuestoAlEne), SUM(PresupuestoAlFeb), SUM(PresupuestoAlMar), SUM(PresupuestoAlAbr), 
--         SUM(PresupuestoAlMay), SUM(PresupuestoAlJun), SUM(PresupuestoAlJul), SUM(PresupuestoAlAgo), 
--         SUM(PresupuestoAlSep), SUM(PresupuestoAlOct), SUM(PresupuestoAlNov), SUM(PresupuestoAlDic)
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlEne,0)*-1 ELSE ISNULL(PresupuestoAlEne,0) END) PresupuestoAlEne,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlFeb,0)*-1 ELSE ISNULL(PresupuestoAlFeb,0) END) PresupuestoAlFeb,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlMar,0)*-1 ELSE ISNULL(PresupuestoAlMar,0) END) PresupuestoAlMar,
		 SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlAbr,0)*-1 ELSE ISNULL(PresupuestoAlAbr,0) END) PresupuestoAlAbr,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlMay,0)*-1 ELSE ISNULL(PresupuestoAlMay,0) END) PresupuestoAlMay,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlJun,0)*-1 ELSE ISNULL(PresupuestoAlJun,0) END) PresupuestoAlJun,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlJul,0)*-1 ELSE ISNULL(PresupuestoAlJul,0) END) PresupuestoAlJul,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlAgo,0)*-1 ELSE ISNULL(PresupuestoAlAgo,0) END) PresupuestoAlAgo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlSep,0)*-1 ELSE ISNULL(PresupuestoAlSep,0) END) PresupuestoAlSep,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlOct,0)*-1 ELSE ISNULL(PresupuestoAlOct,0) END) PresupuestoAlOct,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlNov,0)*-1 ELSE ISNULL(PresupuestoAlNov,0) END) PresupuestoAlNov,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlDic,0)*-1 ELSE ISNULL(PresupuestoAlDic,0) END) PresupuestoAlDic
  FROM #Consolidado 
  WHERE Rama='U'
  GROUP BY Rama --, RamaEsAcreedora

  --BUG2771
  INSERT INTO #Consolidado_U2_UAFIRDA
        (CentroCostos, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, PresupuestoAlEne, PresupuestoAlFeb, PresupuestoAlMar, PresupuestoAlAbr, PresupuestoAlMay, PresupuestoAlJun, PresupuestoAlJul, PresupuestoAlAgo, PresupuestoAlSep, PresupuestoAlOct, PresupuestoAlNov, PresupuestoAlDic)
  SELECT '', 4, 'Otros Gastos y Productos', 'UAFIRDA', Rama, 'UAFIRDA', 0, '', '', 0,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN Saldo*-1 ELSE Saldo END) Saldo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlEne*-1 ELSE SaldoAlEne END) SaldoAlEne,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlFeb*-1 ELSE SaldoAlFeb END) SaldoAlFeb,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMar*-1 ELSE SaldoAlMar END) SaldoAlMar,
		 SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAbr*-1 ELSE SaldoAlAbr END) SaldoAlAbr,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMay*-1 ELSE SaldoAlMay END) SaldoAlMay,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJun*-1 ELSE SaldoAlJun END) SaldoAlJun,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJul*-1 ELSE SaldoAlJul END) SaldoAlJul,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAgo*-1 ELSE SaldoAlAgo END) SaldoAlAgo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlSep*-1 ELSE SaldoAlSep END) SaldoAlSep,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlOct*-1 ELSE SaldoAlOct END) SaldoAlOct,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlNov*-1 ELSE SaldoAlNov END) SaldoAlNov,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlDic*-1 ELSE SaldoAlDic END) SaldoAlDic,
         --BUG2925
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlEne,0)*-1 ELSE ISNULL(PresupuestoAlEne,0) END) PresupuestoAlEne,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlFeb,0)*-1 ELSE ISNULL(PresupuestoAlFeb,0) END) PresupuestoAlFeb,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlMar,0)*-1 ELSE ISNULL(PresupuestoAlMar,0) END) PresupuestoAlMar,
		 SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlAbr,0)*-1 ELSE ISNULL(PresupuestoAlAbr,0) END) PresupuestoAlAbr,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlMay,0)*-1 ELSE ISNULL(PresupuestoAlMay,0) END) PresupuestoAlMay,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlJun,0)*-1 ELSE ISNULL(PresupuestoAlJun,0) END) PresupuestoAlJun,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlJul,0)*-1 ELSE ISNULL(PresupuestoAlJul,0) END) PresupuestoAlJul,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlAgo,0)*-1 ELSE ISNULL(PresupuestoAlAgo,0) END) PresupuestoAlAgo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlSep,0)*-1 ELSE ISNULL(PresupuestoAlSep,0) END) PresupuestoAlSep,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlOct,0)*-1 ELSE ISNULL(PresupuestoAlOct,0) END) PresupuestoAlOct,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlNov,0)*-1 ELSE ISNULL(PresupuestoAlNov,0) END) PresupuestoAlNov,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlDic,0)*-1 ELSE ISNULL(PresupuestoAlDic,0) END) PresupuestoAlDic
  FROM #Consolidado 
  WHERE Rama='U2'
  GROUP BY Rama --, RamaEsAcreedora

--BUG2771
  INSERT INTO #Consolidado_U3_UAFIRDA
        (CentroCostos, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, PresupuestoAlEne, PresupuestoAlFeb, PresupuestoAlMar, PresupuestoAlAbr, PresupuestoAlMay, PresupuestoAlJun, PresupuestoAlJul, PresupuestoAlAgo, PresupuestoAlSep, PresupuestoAlOct, PresupuestoAlNov, PresupuestoAlDic)
  SELECT '', 4, 'Impuestos', 'UAFIRDA', Rama, 'UAFIRDA', 0, '', '', 0,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN Saldo*-1 ELSE Saldo END) Saldo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlEne*-1 ELSE SaldoAlEne END) SaldoAlEne,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlFeb*-1 ELSE SaldoAlFeb END) SaldoAlFeb,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMar*-1 ELSE SaldoAlMar END) SaldoAlMar,
		 SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAbr*-1 ELSE SaldoAlAbr END) SaldoAlAbr,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMay*-1 ELSE SaldoAlMay END) SaldoAlMay,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJun*-1 ELSE SaldoAlJun END) SaldoAlJun,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJul*-1 ELSE SaldoAlJul END) SaldoAlJul,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAgo*-1 ELSE SaldoAlAgo END) SaldoAlAgo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlSep*-1 ELSE SaldoAlSep END) SaldoAlSep,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlOct*-1 ELSE SaldoAlOct END) SaldoAlOct,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlNov*-1 ELSE SaldoAlNov END) SaldoAlNov,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlDic*-1 ELSE SaldoAlDic END) SaldoAlDic,
         --BUG2925
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlEne,0)*-1 ELSE ISNULL(PresupuestoAlEne,0) END) PresupuestoAlEne,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlFeb,0)*-1 ELSE ISNULL(PresupuestoAlFeb,0) END) PresupuestoAlFeb,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlMar,0)*-1 ELSE ISNULL(PresupuestoAlMar,0) END) PresupuestoAlMar,
		 SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlAbr,0)*-1 ELSE ISNULL(PresupuestoAlAbr,0) END) PresupuestoAlAbr,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlMay,0)*-1 ELSE ISNULL(PresupuestoAlMay,0) END) PresupuestoAlMay,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlJun,0)*-1 ELSE ISNULL(PresupuestoAlJun,0) END) PresupuestoAlJun,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlJul,0)*-1 ELSE ISNULL(PresupuestoAlJul,0) END) PresupuestoAlJul,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlAgo,0)*-1 ELSE ISNULL(PresupuestoAlAgo,0) END) PresupuestoAlAgo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlSep,0)*-1 ELSE ISNULL(PresupuestoAlSep,0) END) PresupuestoAlSep,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlOct,0)*-1 ELSE ISNULL(PresupuestoAlOct,0) END) PresupuestoAlOct,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlNov,0)*-1 ELSE ISNULL(PresupuestoAlNov,0) END) PresupuestoAlNov,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN ISNULL(PresupuestoAlDic,0)*-1 ELSE ISNULL(PresupuestoAlDic,0) END) PresupuestoAlDic
  FROM #Consolidado 
  WHERE Rama='U3'
  GROUP BY Rama --, RamaEsAcreedora

-- SELECT * FROM #Consolidado_S_UAFIRDA
--SELECT * FROM #Consolidado_T_UAFIRDA
--SELECT * FROM #Consolidado_U_UAFIRDA
--SELECT * FROM #Consolidado_U2_UAFIRDA
--SELECT * FROM #Consolidado_U3_UAFIRDA

  --REQ2301 Preconfigurado
  INSERT INTO #Consolidado(
            CentroCostos, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, PresupuestoAlEne, PresupuestoAlFeb, PresupuestoAlMar, PresupuestoAlAbr, PresupuestoAlMay, PresupuestoAlJun, PresupuestoAlJul, PresupuestoAlAgo, PresupuestoAlSep, PresupuestoAlOct, PresupuestoAlNov, PresupuestoAlDic)
  SELECT '', 4, 'Utilidad Bruta – Gastos de Operación', 'UAFIRDA', 'STUU2', 'UAFIRDA', 0, '', '', 0,
     	 ((S.Saldo-T.Saldo)-U.Saldo)-u2.Saldo,
         ((S.SaldoAlEne-T.SaldoAlEne)-U.SaldoAlEne)-U2.SaldoAlEne,
         ((S.SaldoAlFeb-T.SaldoAlFeb)-U.SaldoAlFeb)-U2.SaldoAlFeb,
         ((S.SaldoAlMar-T.SaldoAlMar)-U.SaldoAlMar)-U2.SaldoAlMar,
         ((S.SaldoAlAbr-T.SaldoAlAbr)-U.SaldoAlAbr)-U2.SaldoAlAbr,
         ((S.SaldoAlMay-T.SaldoAlMay)-U.SaldoAlMay)-U2.SaldoAlMay,
         ((S.SaldoAlJun-T.SaldoAlJun)-U.SaldoAlJun)-U2.SaldoAlJun,
         ((S.SaldoAlJul-T.SaldoAlJul)-U.SaldoAlJul)-U2.SaldoAlJul,
         ((S.SaldoAlAgo-T.SaldoAlAgo)-U.SaldoAlAgo)-u2.SaldoAlAgo,
         ((S.SaldoAlSep-T.SaldoAlSep)-U.SaldoAlSep)-U2.SaldoAlSep,
         ((S.saldoAlOct-T.saldoAlOct)-U.saldoAlOct)-U2.saldoAlOct,
         ((S.SaldoAlNov-T.SaldoAlNov)-U.SaldoAlNov)-U2.SaldoAlNov,
         ((S.SaldoAlDic-T.SaldoAlDic)-U.SaldoAlDic)-U2.SaldoAlDic,
          --BUG2925
         ((S.PresupuestoAlEne-T.PresupuestoAlEne)-U.PresupuestoAlEne)-U2.PresupuestoAlEne,
         ((S.PresupuestoAlFeb-T.PresupuestoAlFeb)-U.PresupuestoAlFeb)-U2.PresupuestoAlFeb,
         ((S.PresupuestoAlMar-T.PresupuestoAlMar)-U.PresupuestoAlMar)-U2.PresupuestoAlMar,
         ((S.PresupuestoAlAbr-T.PresupuestoAlAbr)-U.PresupuestoAlAbr)-U2.PresupuestoAlAbr,
         ((S.PresupuestoAlMay-T.PresupuestoAlMay)-U.PresupuestoAlMay)-U2.PresupuestoAlMay,
         --((ISNULL(S.PresupuestoAlJun,0)-ISNULL(T.PresupuestoAlJun,0))-ISNULL(U.PresupuestoAlJun,0))-ISNULL(U2.PresupuestoAlJun,0),
         ((S.PresupuestoAlJun-T.PresupuestoAlJun)-U.PresupuestoAlJun)-U2.PresupuestoAlJun,
         --T.PresupuestoAlJun,
         --((ISNULL(S.PresupuestoAlJul,0)-ISNULL(T.PresupuestoAlJul,0))-ISNULL(U.PresupuestoAlJul,0))-ISNULL(U2.PresupuestoAlJul,0),
         ((S.PresupuestoAlJul-T.PresupuestoAlJul)-U.PresupuestoAlJul)-U2.PresupuestoAlJul,
         --T.PresupuestoAlJul,
         ((S.PresupuestoAlAgo-T.PresupuestoAlAgo)-U.PresupuestoAlAgo)-u2.PresupuestoAlAgo,
         ((S.PresupuestoAlSep-T.PresupuestoAlSep)-U.PresupuestoAlSep)-U2.PresupuestoAlSep,
         ((S.PresupuestoAlOct-T.PresupuestoAlOct)-U.PresupuestoAlOct)-U2.PresupuestoAlOct,
         ((S.PresupuestoAlNov-T.PresupuestoAlNov)-U.PresupuestoAlNov)-U2.PresupuestoAlNov,
         ((S.PresupuestoAlDic-T.PresupuestoAlDic)-U.PresupuestoAlDic)-U2.PresupuestoAlDic
  FROM #Consolidado_S_UAFIRDA S, #Consolidado_T_UAFIRDA T, #Consolidado_U_UAFIRDA U, #Consolidado_U2_UAFIRDA U2
  WHERE S.RamaDesc=T.RamaDesc AND
        U.RamaDesc=T.RamaDesc AND
        U2.RamaDesc=U.RamaDesc
--SELECT  * FROM #Consolidado_S_UAFIRDA

  --REQ2301 Preconfigurado
  INSERT INTO #Consolidado(
            CentroCostos, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, PresupuestoAlEne, PresupuestoAlFeb, PresupuestoAlMar, PresupuestoAlAbr, PresupuestoAlMay, PresupuestoAlJun, PresupuestoAlJul, PresupuestoAlAgo, PresupuestoAlSep, PresupuestoAlOct, PresupuestoAlNov, PresupuestoAlDic)
  SELECT '', 6, 'Utilidad Neta', U3.SubClase, 'STUU2U3', 'Utilidad Neta', 0, '', '', 0,
     	 (((S.Saldo-T.Saldo)-U.Saldo)-U2.Saldo)-ISNULL(U3.Saldo,0),
         (((S.SaldoAlEne-T.SaldoAlEne)-U.SaldoAlEne)-U2.SaldoAlEne)-ISNULL(U3.SaldoAlEne,0),
         (((S.SaldoAlFeb-T.SaldoAlFeb)-U.SaldoAlFeb)-U2.SaldoAlFeb)-ISNULL(U3.SaldoAlFeb,0),
         (((S.SaldoAlMar-T.SaldoAlMar)-U.SaldoAlMar)-U2.SaldoAlMar)-ISNULL(U3.SaldoAlMar,0),
         (((S.SaldoAlAbr-T.SaldoAlAbr)-U.SaldoAlAbr)-U2.SaldoAlAbr)-ISNULL(U3.SaldoAlAbr,0),
         (((S.SaldoAlMay-T.SaldoAlMay)-U.SaldoAlMay)-U2.SaldoAlMay)-ISNULL(U3.SaldoAlMay,0),
         (((S.SaldoAlJun-T.SaldoAlJun)-U.SaldoAlJun)-U2.SaldoAlJun)-ISNULL(U3.SaldoAlJun,0),
         (((S.SaldoAlJul-T.SaldoAlJul)-U.SaldoAlJul)-U2.SaldoAlJul)-ISNULL(U3.SaldoAlJul,0),
         (((S.SaldoAlAgo-T.SaldoAlAgo)-U.SaldoAlAgo)-U2.SaldoAlAgo)-ISNULL(U3.SaldoAlAgo,0),
         (((S.SaldoAlSep-T.SaldoAlSep)-U.SaldoAlSep)-U2.SaldoAlSep)-ISNULL(U3.SaldoAlSep,0),
         (((S.saldoAlOct-T.saldoAlOct)-U.saldoAlOct)-U2.saldoAlOct)-ISNULL(U3.saldoAlOct,0),
         (((S.SaldoAlNov-T.SaldoAlNov)-U.SaldoAlNov)-U2.SaldoAlNov)-ISNULL(U3.SaldoAlNov,0),
         (((S.SaldoAlDic-T.SaldoAlDic)-U.SaldoAlDic)-U2.SaldoAlDic)-ISNULL(U3.SaldoAlDic,0),
          --BUG2925
         (((S.PresupuestoAlEne-T.PresupuestoAlEne)-U.PresupuestoAlEne)-U2.PresupuestoAlEne)-ISNULL(U3.PresupuestoAlEne,0),
         (((S.PresupuestoAlFeb-T.PresupuestoAlFeb)-U.PresupuestoAlFeb)-U2.PresupuestoAlFeb)-ISNULL(U3.PresupuestoAlFeb,0),
         (((S.PresupuestoAlMar-T.PresupuestoAlMar)-U.PresupuestoAlMar)-U2.PresupuestoAlMar)-ISNULL(U3.PresupuestoAlMar,0),
         (((S.PresupuestoAlAbr-T.PresupuestoAlAbr)-U.PresupuestoAlAbr)-U2.PresupuestoAlAbr)-ISNULL(U3.PresupuestoAlAbr,0),
         (((S.PresupuestoAlMay-T.PresupuestoAlMay)-U.PresupuestoAlMay)-U2.PresupuestoAlMay)-ISNULL(U3.PresupuestoAlMay,0),
         (((S.PresupuestoAlJun-T.PresupuestoAlJun)-U.PresupuestoAlJun)-U2.PresupuestoAlJun)-ISNULL(U3.PresupuestoAlJun,0),
         (((S.PresupuestoAlJul-T.PresupuestoAlJul)-U.PresupuestoAlJul)-U2.PresupuestoAlJul)-ISNULL(U3.PresupuestoAlJul,0),
         (((S.PresupuestoAlAgo-T.PresupuestoAlAgo)-U.PresupuestoAlAgo)-U2.PresupuestoAlAgo)-ISNULL(U3.PresupuestoAlAgo,0),
         (((S.PresupuestoAlSep-T.PresupuestoAlSep)-U.PresupuestoAlSep)-U2.PresupuestoAlSep)-ISNULL(U3.PresupuestoAlSep,0),
         (((S.PresupuestoAlOct-T.PresupuestoAlOct)-U.PresupuestoAlOct)-U2.PresupuestoAlOct)-ISNULL(U3.PresupuestoAlOct,0),
         (((S.PresupuestoAlNov-T.PresupuestoAlNov)-U.PresupuestoAlNov)-U2.PresupuestoAlNov)-ISNULL(U3.PresupuestoAlNov,0),
         (((S.PresupuestoAlDic-T.PresupuestoAlDic)-U.PresupuestoAlDic)-U2.PresupuestoAlDic)-ISNULL(U3.PresupuestoAlDic,0)
  FROM #Consolidado_S_UAFIRDA S, #Consolidado_T_UAFIRDA T, 
        #Consolidado_U_UAFIRDA U, #Consolidado_U2_UAFIRDA U2,
        #Consolidado_U3_UAFIRDA U3
  WHERE S.RamaDesc=T.RamaDesc AND
        U.RamaDesc=T.RamaDesc AND
        U2.RamaDesc=U.RamaDesc AND
        U3.SubClase=u2.RamaDesc

  UPDATE #Consolidado SET CentroCostos='Sin Centro Costos' WHERE CentroCostos='Sin CC' --REQ2313
  UPDATE #Consolidado SET CentroCostos='Sin Centro Costos' WHERE CentroCostos='GENERAL PPTO' --REQ2313
  
  SELECT * INTO #ConsolidadoSinCC FROM #Consolidado WHERE CentroCostos='Sin Centro Costos'  
  --SELECT * FROM #ConsolidadoSinCC

  DELETE FROM #Consolidado WHERE CentroCostos='Sin Centro Costos'
    
  INSERT INTO #Consolidado(Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, PresupuestoAlEne, PresupuestoAlFeb, PresupuestoAlMar, PresupuestoAlAbr, PresupuestoAlMay, PresupuestoAlJun, PresupuestoAlJul, PresupuestoAlAgo, PresupuestoAlSep, PresupuestoAlOct, PresupuestoAlNov, PresupuestoAlDic)
  SELECT Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion, 
         SUM(Saldo) Saldo,
		 SUM(SaldoAlEne) SaldoAlEne,
		 SUM(SaldoAlFeb) SaldoAlFeb,
		 SUM(SaldoAlMar) SaldoAlMar,
		 SUM(SaldoAlAbr) SaldoAlAbr,
		 SUM(SaldoAlMay) SaldoAlMay,
		 SUM(SaldoAlJun) SaldoAlJun,
		 SUM(SaldoAlJul) SaldoAlJul,
		 SUM(SaldoAlAgo) SaldoAlAgo,
		 SUM(SaldoAlSep) SaldoAlSep,
		 SUM(SaldoAlOct) SaldoAlOct,
		 SUM(SaldoAlNov) SaldoAlNov,
		 SUM(SaldoAlDic) SaldoAlDic,               
         SUM(ISNULL(PresupuestoAlEne,0)) PresupuestoAlEne, 
         SUM(ISNULL(PresupuestoAlFeb,0)) PresupuestoAlFeb,
         SUM(ISNULL(PresupuestoAlMar,0)) PresupuestoAlMar,
         SUM(ISNULL(PresupuestoAlAbr,0)) PresupuestoAlAbr,
         SUM(ISNULL(PresupuestoAlMay,0)) PresupuestoAlMay, 
         SUM(ISNULL(PresupuestoAlJun,0)) PresupuestoAlJun,
         SUM(ISNULL(PresupuestoAlJul,0)) PresupuestoAlJul,
         SUM(ISNULL(PresupuestoAlAgo,0)) PresupuestoAlAgo,
         SUM(ISNULL(PresupuestoAlSep,0)) PresupuestoAlSep,
         SUM(ISNULL(PresupuestoAlOct,0)) PresupuestoAlOct,
         SUM(ISNULL(PresupuestoAlNov,0)) PresupuestoAlNov,
         SUM(ISNULL(PresupuestoAlDic,0)) PresupuestoAlDic
  FROM #ConsolidadoSinCC
  GROUP BY Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, Cuenta, Descripcion
  ORDER BY Orden, Clase, Rama, CentroCostos, Cuenta

  --SELECT * FROM #Consolidado ORDER BY Orden, Clase, Rama, CentroCostos, Cuenta
  select Orden, RID, CentroCostos, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora,
         ISNULL(Saldo,0) Saldo, ISNULL(SaldoAlEne,0) SaldoAlEne, ISNULL(SaldoAlFeb,0) SaldoAlFeb, 
         ISNULL(SaldoAlMar,0) SaldoAlMar, ISNULL(SaldoAlAbr,0) SaldoAlAbr, ISNULL(SaldoAlMay,0) SaldoAlMay, 
         ISNULL(SaldoAlJun,0) SaldoAlJun, ISNULL(SaldoAlJul,0) SaldoAlJul, ISNULL(SaldoAlAgo,0) SaldoAlAgo, 
         ISNULL(SaldoAlSep,0) SaldoAlSep, ISNULL(SaldoAlOct,0) SaldoAlOct, ISNULL(SaldoAlNov,0) SaldoAlNov, 
         ISNULL(SaldoAlDic,0) SaldoAlDic,
         ISNULL(Ingresos,0) Ingresos,
         ISNULL(PresupuestoAlEne,0) PresupuestoAlEne, ISNULL(PresupuestoAlFeb,0) PresupuestoAlFeb, 
         ISNULL(PresupuestoAlMar,0) PresupuestoAlMar, ISNULL(PresupuestoAlAbr,0) PresupuestoAlAbr, ISNULL(PresupuestoAlMay,0) PresupuestoAlMay, 
         ISNULL(PresupuestoAlJun,0) PresupuestoAlJun, ISNULL(PresupuestoAlJul,0) PresupuestoAlJul, ISNULL(PresupuestoAlAgo,0) PresupuestoAlAgo, 
         ISNULL(PresupuestoAlSep,0) PresupuestoAlSep, ISNULL(PresupuestoAlOct,0) PresupuestoAlOct, ISNULL(PresupuestoAlNov,0) PresupuestoAlNov, 
         ISNULL(PresupuestoAlDic,0) PresupuestoAlDic
  FROM #Consolidado ORDER BY Orden, Clase, Rama, CentroCostos, Cuenta                   

  RETURN
END
GO
--REQ1881 Precongf
/******************************* spRSReporteTrasladoEmbarque *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spRSCartaPorteEmbarque') and type = 'P') drop procedure dbo.spRSCartaPorteEmbarque
GO
--BUG2410
if exists (select * from sysobjects where id = object_id('dbo.spRSReporteTrasladoEmbarque') and type = 'P') drop procedure dbo.spRSReporteTrasladoEmbarque
GO             
CREATE PROCEDURE spRSReporteTrasladoEmbarque
		
		 @Empresa		varchar(10),
		 @Sucursal	    int,  
		 --@ClienteD   	varchar(10),
   --      --@ClienteA      varchar(10),
		 ----@Articulo		varchar(20),
		 --@Vehiculo		varchar(10),
		 --@FechaD        datetime,
		 --@FechaA        datetime,
		 	 @ID            int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @EstacionTrabajo		    int

   SELECT  @Empresa     = CASE WHEN @Empresa IN( '(Todas)', '') THEN NULL ELSE @Empresa END
     --      @ClienteD    = CASE WHEN @ClienteD IN( '(Todos)', '') THEN NULL ELSE @ClienteD END,
		   --@Vehiculo    = CASE WHEN @Vehiculo IN( '(Todos)', '') THEN NULL ELSE @Vehiculo END  
  
  SELECT @EstacionTrabajo=@@SPID

  SELECT
   'VTAS' as Modulo,
	e.ID,
    e.Agente,
	e.MovId as eMovID,
	RTRIM(e.Mov)+' '+e.MovId as eMovMovID,
	e.OrigenTipo,
	RTRIM(e.Origen)+' '+e.OrigenId as eOrigenMovMovID,
	e.FechaSalida,
	e.Referencia,
	e.Observaciones,
	e.Peso,
	em.MovObservaciones,
	--e.Vehiculo+' - '+Vehiculo.Descripcion+'. Placas:'+Vehiculo.Placas+'. Cap.Peso (Kgs):'+CONVERT(VARCHAR, Vehiculo.Peso) as InfoVehiculo,
	ISNULL(e.Vehiculo, '')+' - '+ISNULL(Vehiculo.Descripcion,'')+'. Placas:'+ISNULL(Vehiculo.Placas,'')+'. Cap.Peso (Kgs):'+CONVERT(VARCHAR, ISNULL(Vehiculo.Peso,0)) as InfoVehiculo, --BUG2141
	e.Volumen as DispVolumen,
	em.MovEstatus,
	em.Ruta,
	em.NombreEnvio,
	ed.Persona,
	ed.Estado,
	ed.FechaHora,
	em.Cliente,
	c.Nombre,
	em.Telefonos,
	vd.Articulo+' - '+Art.Descripcion1 as Articulo,
	vd.Unidad,
	vd.Cantidad,
	em.Paquetes,
	em.Importe,
	e.ImporteEmbarque,
	em.FechaEmision,
	RTRIM(em.Mov)+' '+em.MovID as emMovMovID,
	ed.MovPorcentaje
  FROM Embarque e
  JOIN EmbarqueD ed ON e.ID=ed.ID
  --JOIN EmbarqueMov em ON e.ID=em.ID
  JOIN EmbarqueMov em ON ed.EmbarqueMov=em.ID
  JOIN Venta v ON em.ModuloID=v.ID
  JOIN Ventad vD ON vd.ID=v.ID
  LEFT OUTER JOIN Cte c ON em.Cliente=c.Cliente
  LEFT OUTER JOIN Vehiculo ON e.Vehiculo=Vehiculo.Vehiculo
  LEFT OUTER JOIN Art ON Art.Articulo=vd.Articulo
  WHERE e.Empresa = ISNULL(@Empresa,e.Empresa) AND e.Sucursal=ISNULL(@Sucursal,e.Sucursal)
	  AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
	  --AND e.FechaEmision BETWEEN @FechaD AND @FechaA
   --   AND em.Cliente = ISNULL(@ClienteD,em.Cliente)
	  --AND e.Vehiculo =  ISNULL(@Vehiculo,e.Vehiculo)
	  AND e.ID=@ID	  
	  AND em.Modulo='VTAS'
  UNION
  SELECT
    'INV' as Modulo,
	e.ID,
    e.Agente,
	e.MovId as eMovID,
	RTRIM(e.Mov)+' '+e.MovId as eMovMovID,
	e.OrigenTipo,
	RTRIM(e.Origen)+' '+e.OrigenId as eOrigenMovMovID,
	e.FechaSalida,
	e.Referencia,
	e.Observaciones,
	e.Peso,
	em.MovObservaciones,
	e.Vehiculo+' - '+Vehiculo.Descripcion+'. Placas:'+Vehiculo.Placas+'. Cap.Peso (Kgs):'+CONVERT(VARCHAR, Vehiculo.Peso) as InfoVehiculo,
	e.Volumen as DispVolumen,
	em.MovEstatus,
	em.Ruta,
	em.NombreEnvio,
	ed.Persona,
	ed.Estado,
	ed.FechaHora,
	em.Cliente,
	c.Nombre,
	em.Telefonos,
	id.Articulo+' - '+Art.Descripcion1 as Articulo,
	id.Unidad,
	id.Cantidad,
	em.Paquetes,
	em.Importe,
	e.ImporteEmbarque,
	em.FechaEmision,
	RTRIM(em.Mov)+' '+em.MovID as emMovMovID,
	ed.MovPorcentaje
  FROM Embarque e
  JOIN EmbarqueD ed ON e.ID=ed.ID
  --JOIN EmbarqueMov em ON e.ID=em.ID
  JOIN EmbarqueMov em ON ed.EmbarqueMov=em.ID
  JOIN Inv i ON em.ModuloID=i.ID
  JOIN InvD id ON id.ID=i.ID
  LEFT OUTER JOIN Cte c ON em.Cliente=c.Cliente
  LEFT OUTER JOIN Vehiculo ON e.Vehiculo=Vehiculo.Vehiculo
  LEFT OUTER JOIN Art ON Art.Articulo=id.Articulo
  WHERE e.Empresa = ISNULL(@Empresa,e.Empresa) AND e.Sucursal=ISNULL(@Sucursal,e.Sucursal)
	  AND e.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
	  --AND e.FechaEmision BETWEEN @FechaD AND @FechaA
   --   AND em.Cliente = ISNULL(@ClienteD,em.Cliente)
	  --AND e.Vehiculo =  ISNULL(@Vehiculo,e.Vehiculo)
	  AND e.ID=@ID
	  AND em.Modulo='INV'
  ORDER BY 1,e.FechaSalida, e.Agente

	   
END
GO

/****************************************   ArtApartadoTarimaSL   *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE ID = OBJECT_ID('dbo.ArtApartadoTarimaSL') and TYPE = 'V') DROP VIEW dbo.ArtApartadoTarimaSL
GO
CREATE VIEW ArtApartadoTarimaSL
--//WITH ENCRYPTION
AS 
    SELECT t.Empresa, 
           d.Articulo, 
           t.Almacen,
           slm.SerieLote, 
           CASE WHEN  CHARINDEX('-',d.Tarima,1) > 0 THEN SUBSTRING(d.Tarima,1,CHARINDEX('-',d.Tarima,1)-1) ELSE d.Tarima END Tarima,
           SUM(CASE WHEN ISNULL(slm.Cantidad,0) <> 0 THEN slm.Cantidad ELSE ISNULL(d.CantidadPicking,0) END) Apartado
      FROM TMA t
      JOIN TMAD d ON t.ID = d.ID
      JOIN MovTipo mt ON t.Mov = mt.Mov AND mt.Modulo = 'TMA'
 LEFT JOIN SerieLoteMov slm ON mt.Modulo = slm.Modulo AND t.ID = slm.ID AND d.Articulo = slm.Articulo AND d.Renglon = slm.RenglonID
     WHERE t.Estatus = 'PENDIENTE' 
       AND mt.Clave IN('TMA.OSUR','TMA.TSUR','TMA.SUR','TMA.OPCKTARIMA','TMA.PCKTARIMATRAN','TMA.PCKTARIMA')
  GROUP BY t.Empresa, d.Articulo, t.Almacen, slm.SerieLote,
		   CASE WHEN  CHARINDEX('-',d.Tarima,1) > 0 THEN SUBSTRING(d.Tarima,1,CHARINDEX('-',d.Tarima,1)-1) ELSE d.Tarima END
GO

/****************************************   AuxiliarUGral   *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE ID = OBJECT_ID('dbo.AuxiliarUGral') and TYPE = 'V') DROP VIEW dbo.AuxiliarUGral
GO
CREATE VIEW AuxiliarUGral
--//WITH ENCRYPTION
AS 
  SELECT ID, Empresa, Rama, Mov, MovID, Modulo, 
         ModuloID, Moneda, TipoCambio, Grupo, SubGrupo, 
         Cuenta, SubCuenta, Ejercicio, Periodo, Fecha, 
         Cargo, Abono, CargoU, AbonoU, Aplica, 
         AplicaID, Acumulado, Conciliado, EsCancelacion, FechaConciliacion, 
         Sucursal, Renglon, RenglonSub, '' [IDWMS], IDAuxU
    FROM AuxiliarU
   UNION ALL
  SELECT ID, Empresa, Rama, Mov, MovID, 
         Modulo, ModuloID, Moneda, TipoCambio, Grupo, 
         SubGrupo, Cuenta, SubCuenta, Ejercicio, Periodo, 
         Fecha, Cargo, Abono, CargoU, AbonoU, 
         Aplica, AplicaID, Acumulado, Conciliado, EsCancelacion, 
         FechaConciliacion, Sucursal, Renglon, RenglonSub, '' [IDWMS], 
         IDAuxU
    FROM AuxiliarUWMS
GO

/****************************************   AcumUGral   *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE ID = OBJECT_ID('dbo.AcumUGral') and TYPE = 'V') DROP VIEW dbo.AcumUGral
GO
CREATE VIEW AcumUGral
--//WITH ENCRYPTION
AS 
  SELECT Sucursal, Empresa, Rama, Ejercicio, Periodo, 
         Moneda, Grupo, SubGrupo, Cuenta, SubCuenta, 
         Cargos, Abonos, CargosU, AbonosU, UltimoCambio
    FROM AcumU
   UNION ALL
  SELECT Sucursal, Empresa, Rama, Ejercicio, Periodo, 
         Moneda, Grupo, SubGrupo, Cuenta, SubCuenta, 
         Cargos, Abonos, CargosU, AbonosU, UltimoCambio
    FROM AcumUWMS
GO

/*** SerieLoteAsigando ***/
if exists (select * from sysobjects where id = object_id('dbo.SerieLoteAsigando') and type = 'V') drop view dbo.SerieLoteAsigando
GO
CREATE VIEW SerieLoteAsigando
--//WITH ENCRYPTION
AS 
    SELECT s.Empresa, 
           s.Articulo, 
           s.SubCuenta,
           s.Almacen, 
           s.Cliente, 
           SUM(s.Existencia) Existencia, 
           SUM(s.ExistenciaAlterna) ExistenciaAlterna, 
           c.Nombre 
    FROM SerieLote s 
    LEFT OUTER JOIN Cte c ON s.Cliente=c.Cliente      
   GROUP BY s.Empresa, s.Articulo, s.SubCuenta, s.Almacen, s.Cliente, c.Nombre
GO

/**************** IntelisisFactory ****************/
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'VisorEventosIS')
	DROP VIEW [dbo].[VisorEventosIS]
GO
CREATE VIEW [dbo].[VisorEventosIS]
AS
SELECT	cast(ID as varchar(10)) ID, 
		Sistema,
		Referencia,
		SubReferencia,
		CAST(CASE Estatus WHEN 'PROCESADO' THEN 'COMPLETO' WHEN 'DESCARTADO' THEN 'CANCELADO' WHEN 'SINPROCESAR' THEN 'PROCESADO' ELSE Estatus END AS VARCHAR(50)) Estatus,
		CONVERT(varchar(19), FechaEstatus, 121) FechaEstatus,
		cast(Ok as varchar(10)) Ok,
		OkRef,
		CAST(replace(replace(replace(replace(replace(Solicitud, 
			CHAR(10), '') , CHAR(13), ''), '<', NCHAR(13) + '<')  , CHAR(13) + '<Intelisis', '<Intelisis'), CHAR(13) + '<?xml', '<?xml') AS VARCHAR(MAX))
			AS SolicitudMax,
		ISNULL(CAST(replace(replace(replace(replace(replace(Resultado,
			CHAR(10), '') , CHAR(13), ''), '<', NCHAR(13) + '<')  , CHAR(13) + '<Intelisis', '<Intelisis'), CHAR(13) + '<?xml', '<?xml') AS VARCHAR(MAX)),'')
			AS ResultadoMax,
		CASE Estatus WHEN 'SINPROCESAR' THEN 'SIN PROCESAR' WHEN 'ERROR' THEN ' ERROR' ELSE Estatus END EstatusMostrar,
		convert(varchar(10), FechaEstatus, 103) FechaFiltro
  FROM	IntelisisService
GO

/**************** Movil_Cliente ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Movil_Cliente') and type = 'V') DROP VIEW Movil_Cliente
GO   
CREATE VIEW Movil_Cliente AS  
SELECT  
    Cliente,  
    Nombre,  
    RFC,  
    AlmacenDef,  
    '' AS NombreSucursal,  
    Categoria,  
    Grupo,  
    Familia,  
    Tipo,  
    Direccion,  
    DireccionNumero,  
    DireccionNumeroInt,  
    EntreCalles,  
    Observaciones,  
    Delegacion,  
    Colonia,  
    CodigoPostal,  
    Poblacion,  
    Estado,  
    Telefonos,  
    Contacto1,  
    Contacto2,  
    Extencion1,  
    Extencion2,  
    eMail1,  
    eMail2,  
    Descuento,  
    ZonaImpuesto,  
    MapaLatitud,  
    MapaLongitud,  
    MapaPrecision,  
    0 AS Saldo,  
    CreditoLimite  
  FROM Cte  
GO

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ANSI_PADDING OFF
GO
/**************** vwArtAgenteMovil ****************/
IF EXISTS(SELECT id FROM sysobjects WHERE id = object_id('dbo.vwArtAgenteMovil') and type = 'V')
	DROP VIEW dbo.vwArtAgenteMovil
GO
CREATE VIEW dbo.vwArtAgenteMovil
AS
SELECT	ISNULL(Ag.Agente,			' ')	Agente,
		ISNULL(Ag.Nombre,			' ')	NombreAgt,
		ISNULL(Ct.Cliente,			' ')	Cliente,	
		ISNULL(Ct.Rama,				' ')	Rama,	
		ISNULL(Ct.Nombre,			' ')	NombreCte,
		ISNULL(Ct.ListaPrecios,		' ')	ListaPrecios,	
		ISNULL(Ct.ListaPreciosEsp,	' ')	ListaPreciosEsp,	
		ISNULL(Ct.MapaLatitud,		' ')	MapaLatitud,	
		ISNULL(Ct.MapaLongitud,		' ')	MapaLongitud,	
		ISNULL(Ct.MapaPrecision,	' ')	MapaPrecision,	
		ISNULL(Ct.AlmacenDef,		' ')	AlmacenDef,
		ISNULL(LP.Lista,			' ')	Lista,
		ISNULL(LP.Moneda,			' ')	Moneda,
		ISNULL(LP.Articulo,			' ')	Articulo,	
		ISNULL(LP.Precio,			' ')	Precio
  FROM	Agente Ag
  JOIN	Cte Ct ON Ag.Agente = Ct.Agente
  LEFT	JOIN ListaPreciosD LP ON Ct.ListaPreciosEsp = LP.Lista
GO

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ANSI_PADDING OFF
GO
/**************** Movil_ArtAgenteMovil ****************/
IF EXISTS(SELECT id FROM sysobjects WHERE id = object_id('dbo.Movil_ArtAgenteMovil') and type = 'V')
	DROP VIEW dbo.Movil_ArtAgenteMovil
GO
CREATE VIEW dbo.Movil_ArtAgenteMovil
AS
SELECT	
		-- Agente
		ISNULL(Ag.Agente,				' ') AgtAgente,
		ISNULL(Ag.Nombre,				' ') AgtNombre,
		-- Cliente
		ISNULL(Ct.Cliente,				' ') Cte_Cliente,
		ISNULL(Ct.Nombre,				' ') Cte_Nombre,
		ISNULL(Ct.Rama,					' ') Cte_CteRama,
		ISNULL(Ct.Direccion,			' ') Cte_Direccion,
		ISNULL(Ct.DireccionNumero,		' ') Cte_DireccionNumero,
		ISNULL(Ct.DireccionNumeroInt,	' ') Cte_DireccionNumeroInt,
		ISNULL(Ct.Delegacion,			' ') Cte_Delegacion,
		ISNULL(Ct.Colonia,				' ') Cte_Colonia,
		ISNULL(Ct.Poblacion,			' ') Cte_Poblacion,
		ISNULL(Ct.Estado,				' ') Cte_Estado,
		ISNULL(Ct.Pais,					' ') Cte_Pais,
		ISNULL(Ct.CodigoPostal,			' ') Cte_CodigoPostal,
		ISNULL(Ct.RFC,					' ') Cte_RFC,
		ISNULL(Ct.Telefonos,			' ') Cte_Telefonos,
		ISNULL(Ct.Extencion1,		    ' ') Cte_Extencion1,
		ISNULL(Ct.eMail1,				' ') Cte_eMail1,
		ISNULL(Ct.AlmacenDef,			' ') AlmacenDef,
		ISNULL(Ct.ListaPrecios,			' ') Cte_ListaPrecios,
		ISNULL(Ct.ListaPreciosEsp,		' ') Cte_ListaPreciosEsp,
		ISNULL(Ct.Estatus,				' ') Cte_Estatus,
		ISNULL(Ct.Descuento,			' ') Cte_Descuento,
		ISNULL(Ct.ZonaImpuesto,			' ') Cte_ZonaImpuesto,
		ISNULL(Ct.CreditoLimite,		' ') Cte_CreditoLimite,
		ISNULL(Ct.Contacto1,			' ') Cte_Contacto1,
		ISNULL(Ct.Contacto2,			' ') Cte_Contacto2,
		ISNULL(Ct.MapaLatitud,			' ') Cte_MapaLatitud,
		ISNULL(Ct.MapaLongitud,			' ') Cte_MapaLongitud,
		ISNULL(Ct.MapaPrecision,		' ') Cte_MapaPrecision,
		ISNULL(Ct.EntreCalles,			' ') Cte_EntreCalles,
		ISNULL(Ct.Condicion,			' ') Cte_Condicion,
		ISNULL(Ct.Observaciones,		' ') Cte_Observaciones,
		ISNULL(Ct.DefMoneda,			' ') Cte_DefMoneda,
		--Artículos
		ISNULL(Ar.Articulo ,			' ') Art_Articulo, 
  		ISNULL(Ar.Descripcion1,			' ') Art_Descripcion1, 
  		ISNULL(Ar.Descripcion2,			' ') Art_Descripcion2,  
  		ISNULL(Ar.Categoria,			' ') Art_Categoria,
  		ISNULL(Ar.Unidad,				' ') Art_Unidad, 
  		ISNULL(Ar.Tipo,					' ') Art_Tipo,
  		ISNULL(Ar.Grupo,				' ') Art_Almacen,
  		ISNULL(Ar.MonedaPrecio,			' ') Art_MonedaPrecio,
  		ISNULL(SU.SaldoU,				' ') Art_Disponible,
  		ISNULL(Ar.Grupo,				' ') Art_Grupo,
  		ISNULL(Ar.Linea,				' ') Art_Linea,
  		ISNULL(Ar.Familia,				' ') Art_Familia,
  		ISNULL(Ar.PrecioLista,			' ') Art_PrecioLista,
  		ISNULL(Ar.Estatus,				' ') Art_Estatus,
  		ISNULL(SU.Saldo,				' ') Art_Existencia,
		--Lista Precios
		ISNULL(LP.Lista,				' ') Lista,
		ISNULL(LP.Moneda,				' ') Moneda,
		ISNULL(LP.Articulo,				' ') Articulo,	
		ISNULL(LP.Precio,				' ') Precio
  FROM	Agente Ag
  JOIN	Cte Ct ON Ag.Agente = Ct.Agente
  JOIN	ListaPreciosD LP ON Ct.Cliente = LP.CodigoCliente
  JOIN	Art Ar ON LP.Articulo = Ar.Articulo
  JOIN	SaldoU SU ON Ar.Articulo = SU.Cuenta
GO

/**************** Movil_Cobro ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Movil_Cobro') and type = 'V') DROP VIEW Movil_Cobro
GO   
CREATE VIEW Movil_Cobro AS  
SELECT  
    ISNULL((SELECT TOP 1 FormaPago FROM MovilFormaPago WHERE Empresa = m.Empresa),'') AS Cobro_Forma,
    0.00 AS Cobro_Importe,
    ISNULL((SELECT TOP 1 Moneda FROM MovilMoneda WHERE Empresa = m.Empresa),'') AS Cobro_Moneda,
    ISNULL((SELECT TOP 1 Concepto FROM Concepto WHERE Modulo = 'CXC'),'') AS Cobro_Concepto,
    '' AS Cobro_Referencia,
    '' AS Cobro_Observaciones,
    0 AS Cobro_AutoAplicar
  FROM MovilUsuarioCfg m
GO
IF EXISTS(SELECT Mensaje FROM MensajeLista WHERE Mensaje = 43022)
Delete MensajeLista where Mensaje = 43022
IF NOT EXISTS(SELECT Mensaje FROM MensajeLista WHERE Mensaje = 43021)
  insert MensajeLista (Mensaje,Descripcion) VALUES (43021,'Existen Visitas sin fecha y hora')
IF NOT EXISTS(SELECT Mensaje FROM MensajeLista WHERE Mensaje = 43022)
  insert MensajeLista (Mensaje,Descripcion) VALUES (43022,'Existen Visitas fuera del horario permitido')
IF NOT EXISTS(SELECT Mensaje FROM MensajeLista WHERE Mensaje = 43023)
  insert MensajeLista (Mensaje,Descripcion) VALUES (43023,'Existen Visitas en situación sin finalizar')
GO

/**************** AppEmbarqueUbicacion ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.AppEmbarqueUbicacion') and type = 'V') DROP VIEW AppEmbarqueUbicacion
GO   
CREATE VIEW AppEmbarqueUbicacion AS  
SELECT e.ID, 
       e.Empresa, 
       e.Mov   as 'MovEmbarque', 
       e.MovID as 'MoIDEmbarque', 
       e.Moneda, 
       e.TipoCambio, 
       e.FechaEmision, 
       e.Proyecto, 
       e.UEN, 
       e.Usuario, 
       e.Estatus, 
       e.Vehiculo, 
       e.Agente, 
       e.Proveedor, 
       e.Importe, 
       e.Impuestos,
       ed.EmbarqueMov, 
       ed.Orden, 
       ed.Paquetes, 
       ed.Estado, 
       ed.FechaHora, 
       ed.Persona, 
       ed.PersonaID, 
       ed.Forma, 
       ed.Referencia, 
       ed.Observaciones, 
       ed.Causa, 
       ed.MovPorcentaje,
       em.Accion, 
       em.Zona, 
       em.Ruta, 
       em.ZonaTipo, 
       em.OrdenEmbarque, 
       em.Modulo, 
       em.ModuloID, 
       em.Mov, 
       em.MovID, 
       em.MovEstatus, 
       em.Almacen, 
       em.Cliente, 
       c.Nombre, 
       em.Delegacion, 
       em.Colonia,
       em.Poblacion, 
       em.Estado as 'EstadoEmbarque', 
       em.Pais, 
       em.CodigoPostal, 
       em.MapaLatitud, 
       em.MapaLongitud, 
       em.Ubicacion
  FROM Embarque e
  JOIN EmbarqueD ed ON ed.ID = e.ID
  JOIN EmbarqueMov em ON em.ID = ed.EmbarqueMov
  JOIN Cte c ON c.Cliente = em.Cliente
  WHERE e.Estatus = 'PENDIENTE'
GO

/*** ArtCostoEmpresaAlm ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtCostoEmpresaAlm') and type = 'V') drop view dbo.ArtCostoEmpresaAlm
GO
CREATE VIEW ArtCostoEmpresaAlm
--//WITH ENCRYPTION
AS 

SELECT 
  ac.Empresa,
  a.Articulo, 
  "CostoPromedio" =	CASE WHEN ISNULL(ai.Inventario,0) = 0
							THEN 0
						 ELSE	
							SUM(ISNULL(ai.Inventario,0)*ISNULL(AC.CostoPromedio,0))/SUM(ISNULL(ai.Inventario,0))              
					END,
  "UltimoCosto" = CASE	WHEN ISNULL(ai.Inventario,0) = 0
							THEN 0
						ELSE
							SUM(ISNULL(ai.Inventario,0)*ISNULL(AC.UltimoCosto,0) )/ SUM (ISNULL(ai.Inventario,0))
				  END,  
  "UltimoCostoSinGastos" = CASE WHEN ISNULL(ai.Inventario,0) = 0
									THEN 0
								ELSE
									SUM(ISNULL(ai.Inventario,0)*ISNULL(AC.UltimoCostoSinGastos,0) )/ SUM (ISNULL(ai.Inventario,0))
							END,
  "CostoEstandar"= AVG(ISNULL(a.CostoEstandar,0)),
  "CostoReposicion"= AVG(ISNULL(a.CostoReposicion,0)),
  ai.Almacen
FROM  art a 
JOIN ArtCosto ac on a.Articulo =ac.Articulo 
JOIN ArtExistenciaInv  ai on a.Articulo =ai.Articulo
AND ac.Empresa =ai.Empresa 
AND ac.Sucursal =ai.Sucursal 
GROUP BY  a.Articulo,ac.Empresa,ai.Inventario, ai.Almacen
GO

/*** ArtConCostoAlm ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtConCostoAlm') and type = 'V') drop view dbo.ArtConCostoAlm
GO
CREATE VIEW ArtConCostoAlm
--//WITH ENCRYPTION
AS 
SELECT 
  a.Articulo,
  a.Descripcion1,
  a.Grupo,
  a.Categoria,
  a.Familia,
  a.Fabricante,
  a.ClaveFabricante,
  a.MonedaCosto,
  a.Estatus,  
  a.Codigo,
  c.Empresa,
  c.CostoPromedio,
  c.UltimoCosto,
  c.UltimoCostoSinGastos,
  a.CostoEstandar,
  a.CostoReposicion,
  c.Almacen
FROM 
  Art a
  LEFT OUTER JOIN ArtCostoEmpresaAlm c ON a.Articulo = c.Articulo
GO