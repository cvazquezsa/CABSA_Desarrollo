SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO 




/*** eCommerceArtSubExistenciaInv ***/
if exists (select * from sysobjects where id = object_id('dbo.eCommerceArtSubExistenciaInv') and type = 'V') drop view dbo.eCommerceArtSubExistenciaInv
GO
CREATE VIEW eCommerceArtSubExistenciaInv
--//WITH ENCRYPTION
AS 
  SELECT Articulo , SubCuenta, SUM(Inventario)Inventario
    FROM ArtSubExistenciaInv
    GROUP BY   Articulo , SubCuenta
GO

/*** WebArtExistenciaGlobal ***/
if exists (select * from sysobjects where id = object_id('dbo.WebArtExistenciaGlobal') and type = 'V') drop view dbo.WebArtExistenciaGlobal
GO
CREATE VIEW WebArtExistenciaGlobal
--//WITH ENCRYPTION
AS 
  SELECT a.Articulo,a.SubCuenta,a.Inventario ,ISNULL(w.SKU,'ID#'+CONVERT(varchar,w.ID)) SKU, aa.Situacion
    FROM eCommerceArtSubExistenciaInv a  JOIN WebArt w ON a.Articulo = w.Articulo AND ISNULL(a.SubCuenta,'') = ISNULL(w.SubCuenta,'')
    JOIN Art aa ON a.Articulo = aa.Articulo
  UNION ALL
  SELECT a.Articulo,a.SubCuenta,a.Inventario ,ISNULL(c.SKU,'IDCO#'+CONVERT(varchar,c.ID)), aa.Situacion
    FROM eCommerceArtSubExistenciaInv a  JOIN WebArtVariacionCombinacion c ON a.Articulo = c.Articulo AND ISNULL(a.SubCuenta,'') = ISNULL(c.SubCuenta,'')
    JOIN Art aa ON a.Articulo = aa.Articulo 
GO


/*** eCommerceArtSubExistenciaInvSucursal ***/
if exists (select * from sysobjects where id = object_id('dbo.eCommerceArtSubExistenciaInvSucursal') and type = 'V') drop view dbo.eCommerceArtSubExistenciaInvSucursal
GO
CREATE VIEW eCommerceArtSubExistenciaInvSucursal
--//WITH ENCRYPTION
AS 
  SELECT a.Articulo , a.SubCuenta, SUM(a.Disponible)Inventario, s.Sucursal, a.Almacen
    FROM ArtAlmSubDisponible a
    JOIN Alm s ON a.Almacen = s.Almacen
  GROUP BY   a.Articulo , a.SubCuenta, s.Sucursal, a.Almacen
GO

/*** WebArtExistenciaSucursal***/
if exists (select * from sysobjects where id = object_id('dbo.WebArtExistenciaSucursal') and type = 'V') drop view dbo.WebArtExistenciaSucursal
GO
CREATE VIEW WebArtExistenciaSucursal
--//WITH ENCRYPTION
AS 
  SELECT a.Articulo,a.SubCuenta,a.Inventario ,ISNULL(w.SKU,'ID#'+CONVERT(varchar,w.ID)) SKU, aa.Situacion, a.Sucursal, a.Almacen
    FROM eCommerceArtSubExistenciaInvSucursal a  JOIN WebArt w ON a.Articulo = w.Articulo AND ISNULL(a.SubCuenta,'') = ISNULL(w.SubCuenta,'')
    JOIN Art aa ON a.Articulo = aa.Articulo
  UNION ALL
  SELECT a.Articulo,a.SubCuenta,a.Inventario ,ISNULL(c.SKU,'IDCO#'+CONVERT(varchar,c.ID)), aa.Situacion, a.Sucursal,  a.Almacen
    FROM eCommerceArtSubExistenciaInvSucursal a  JOIN WebArtVariacionCombinacion c ON a.Articulo = c.Articulo AND  ISNULL(a.SubCuenta,'') = ISNULL(c.SubCuenta,'')
    JOIN Art aa ON a.Articulo = aa.Articulo 

GO

/*** WebArtOpciones ***/
if exists (select * from sysobjects where id = object_id('dbo.WebArtOpciones') and type = 'V') drop view dbo.WebArtOpciones
GO
CREATE VIEW WebArtOpciones
--//WITH ENCRYPTION
AS 
SELECT v.ID, v.VariacionID, v.OpcionID, o.Nombre,o.OpcionIntelisis, o.Orden OrdenOpcion, v.Orden, v.NumeroIntelisis,v.Valor
  FROM WebArtOpcion o LEFT JOIN WebArtOpcionValor v ON o.ID = v.OpcionID AND o.VariacionID = v.VariacionID
GO
/*** eCommerceArt ***/
if exists (select * from sysobjects where id = object_id('dbo.eCommerceArt') and type = 'V') drop view dbo.eCommerceArt
GO
CREATE VIEW eCommerceArt
--//WITH ENCRYPTION
AS 
  SELECT Articulo, Rama, Descripcion1, Descripcion2, NombreCorto, Grupo, Categoria, Familia, Linea, Fabricante, ClaveFabricante, Estatus, Tipo     
    FROM Art
   WHERE Articulo NOT IN (SELECT Articulo FROM WebArt)  

GO