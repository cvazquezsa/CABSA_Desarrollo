SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/******************** xcrm_listapreciosd ***********************/
IF OBJECT_ID ('xcrm_listapreciosd', 'VIEW') IS NOT NULL DROP VIEW xcrm_listapreciosd 
GO
CREATE VIEW dbo.xcrm_listapreciosd 
--//WITH ENCRYPTION	
AS
	select LD.Lista,LD.moneda,LD.Articulo,isnull(LD.Precio,0) Precio,ld.CRMObjectId,ld.CRMLastUpdate,Art.unidad 
	FROM listapreciosd LD
	JOIN Art ON LD.Articulo = Art.Articulo
	where Art.unidad<>'MODULO' and Art.estatus='ALTA' and precio=0 and (tipo='Servicio' or tipo='Normal')
GO

/******************** xcrm_listapreciosd_art ***********************/
IF OBJECT_ID ('xcrm_listapreciosd_art', 'VIEW') IS NOT NULL DROP VIEW xcrm_listapreciosd_art 
GO
CREATE VIEW dbo.xcrm_listapreciosd_art 
--//WITH ENCRYPTION	
AS
	select '(Precio Lista)' Lista,art.MonedaPrecio Moneda,ARt.Articulo,isnull(Art.PrecioLista,0) Precio,ld.CRMObjectId,art.ultimocambio CRMLastUpdate,Art.unidad 
	FROM art LD
	JOIN Art ON LD.Articulo = Art.Articulo
	union 
	select '(Precio 2)' Lista,art.MonedaPrecio Moneda,ARt.Articulo,isnull(Art.PrecioLista,0) Precio,ld.CRMObjectId,art.ultimocambio CRMLastUpdate,Art.unidad 
	FROM art LD
	JOIN Art ON LD.Articulo = Art.Articulo
GO

/******************** xcrm_artgrupo ***********************/
IF OBJECT_ID ('xcrm_artgrupo', 'VIEW') IS NOT NULL DROP VIEW xcrm_artgrupo 
GO
CREATE VIEW dbo.xcrm_artgrupo 
--//WITH ENCRYPTION	
AS
	select distinct rtrim(Replace(a.grupo,char(13)+char(10),'')) grupo,min(a.UltimoCambio) crmlastupdate,NULL crmobjectid from art a
	left join artgrupo c on( rtrim(Replace(a.grupo,char(13)+char(10),''))=rtrim(Replace(c.grupo,char(13)+char(10),'')))
	where a.grupo is not null and c.grupo is null and a.grupo<>''
	group by a.grupo
	union 
	select distinct rtrim(Replace(grupo,char(13)+char(10),'')),crmlastupdate ,crmobjectid from artgrupo where grupo<>''
GO
		
/********************** xcrm_artfam *********************/
IF OBJECT_ID ('xcrm_artfam', 'VIEW') IS NOT NULL DROP VIEW xcrm_artfam 
GO
CREATE VIEW dbo.xcrm_artfam 
--//WITH ENCRYPTION	
AS
	select rtrim(Replace(a.familia,char(13)+char(10),'')) familia,min(a.UltimoCambio) crmlastupdate,NULL crmobjectid from art a
	left join artfam c on( rtrim(Replace(a.familia,char(13)+char(10),''))=rtrim(Replace(c.familia,char(13)+char(10),'')))
	where a.familia is not null and a.familia<>'' and c.familia is null
	group by a.familia
	union 
	select distinct rtrim(Replace(familia,char(13)+char(10),'')) familia,crmlastupdate ,crmobjectid from artfam where familia<>''
GO

/******************* xcrm_artcat ************************/
IF OBJECT_ID ('xcrm_artcat', 'VIEW') IS NOT NULL DROP VIEW xcrm_artcat 
GO
CREATE  VIEW dbo.xcrm_artcat 
--//WITH ENCRYPTION	
AS
	select distinct rtrim(Replace(a.categoria,char(13)+char(10),'')) categoria,min(a.UltimoCambio) crmlastupdate,NULL crmobjectid from art a
	left join artcat c on( rtrim(Replace(a.categoria,char(13)+char(10),''))=rtrim(Replace(c.categoria,char(13)+char(10),'')))
	where a.categoria is not null and c.categoria is null and a.categoria<>''
	group by a.categoria
	union 
	select distinct rtrim(Replace(categoria,char(13)+char(10),'')) ,crmlastupdate ,crmobjectid from artcat where categoria<>''
GO

/********************* xcrm_artlinea **********************/
IF OBJECT_ID ('xcrm_artlinea', 'VIEW') IS NOT NULL DROP VIEW xcrm_artlinea
GO
CREATE VIEW dbo.xcrm_artlinea 
--//WITH ENCRYPTION	
AS
	select distinct rtrim(Replace(a.linea,char(13)+char(10),'')) linea,min(a.UltimoCambio) crmlastupdate,NULL crmobjectid from art a
	left join artLinea c on( rtrim(Replace(a.linea,char(13)+char(10),''))=rtrim(Replace(c.linea,char(13)+char(10),'')))
	where a.linea  is not null and c.linea is null and a.linea<>''
	group by a.linea
	union 
	select distinct rtrim(Replace(linea,char(13)+char(10),'')) linea,crmlastupdate ,crmobjectid from artlinea where linea<>''
GO

/******************* xcrm_fabricante ************************/
IF OBJECT_ID ('xcrm_fabricante', 'VIEW') IS NOT NULL DROP VIEW xcrm_fabricante 
GO
CREATE VIEW dbo.xcrm_fabricante 
--//WITH ENCRYPTION	
AS
	select distinct rtrim(Replace(a.fabricante,char(13)+char(10),'')) fabricante,min(a.UltimoCambio) crmlastupdate,NULL crmobjectid  from art a
	left join fabricante c on( rtrim(Replace(a.fabricante,char(13)+char(10),''))=rtrim(Replace(c.fabricante,char(13)+char(10),'')))
	where a.fabricante  is not null and c.fabricante is null and a.fabricante<>''
	group by a.fabricante
	union 
	select distinct rtrim(Replace(fabricante,char(13)+char(10),'')) fabricante,crmlastupdate ,crmobjectid from fabricante where fabricante<>''
GO

/******************** xcrm_ctegrupo ***********************/
IF OBJECT_ID ('xcrm_ctegrupo', 'VIEW') IS NOT NULL DROP VIEW xcrm_ctegrupo
GO
CREATE VIEW dbo.xcrm_ctegrupo 
--//WITH ENCRYPTION	
AS
	select distinct rtrim(Replace(a.grupo,char(13)+char(10),'')) grupo,min(a.UltimoCambio) crmlastupdate,NULL crmobjectid from cte a
	left join ctegrupo c on( rtrim(Replace(a.grupo,char(13)+char(10),''))=rtrim(Replace(c.grupo,char(13)+char(10),'')))
	where a.grupo is not null and c.grupo is null and a.grupo<>''
	group by a.grupo
	union 
	select distinct rtrim(Replace(grupo,char(13)+char(10),'')),crmlastupdate ,crmobjectid from ctegrupo where grupo<>''
GO

/***************** xcrm_ctefam **************************/
IF OBJECT_ID ('xcrm_ctefam', 'VIEW') IS NOT NULL DROP VIEW xcrm_ctefam
GO
CREATE  VIEW dbo.xcrm_ctefam 
--//WITH ENCRYPTION	
AS
	select rtrim(Replace(a.familia,char(13)+char(10),'')) familia,min(a.UltimoCambio) crmlastupdate,NULL crmobjectid from cte a
	left join ctefam c on( rtrim(Replace(a.familia,char(13)+char(10),''))=rtrim(Replace(c.familia,char(13)+char(10),'')))
	where a.familia is not null and a.familia<>'' and c.familia is null
	group by a.familia
	union 
	select distinct rtrim(Replace(familia,char(13)+char(10),'')) familia,crmlastupdate ,crmobjectid from ctefam where familia<>''
GO

/******************** xcrm_ctecat ***********************/
IF OBJECT_ID ('xcrm_ctecat', 'VIEW') IS NOT NULL DROP VIEW xcrm_ctecat 
GO
CREATE  VIEW dbo.xcrm_ctecat 
--//WITH ENCRYPTION	
AS
	select distinct rtrim(Replace(a.categoria,char(13)+char(10),'')) categoria,min(a.UltimoCambio) crmlastupdate,NULL crmobjectid from cte a
	left join ctecat c on( rtrim(Replace(a.categoria,char(13)+char(10),''))=rtrim(Replace(c.categoria,char(13)+char(10),'')))
	where a.categoria is not null and c.categoria is null and a.categoria<>''
	group by a.categoria
	union 
	select distinct rtrim(Replace(categoria,char(13)+char(10),'')) ,crmlastupdate ,crmobjectid from ctecat where categoria<>''
GO

/******************** xcrm_ventad ***********************/
IF OBJECT_ID ('xcrm_ventad', 'VIEW') IS NOT NULL DROP VIEW xcrm_ventad 
GO
CREATE VIEW dbo.xcrm_ventad 
--//WITH ENCRYPTION	
AS
	select ventad.*,venta.ultimocambio,venta.mov,venta.referencia from ventad
	join venta on(venta.id=ventad.id) and Mov='Pedido' and venta.folioCRM is not null

GO

/******************** xcrm_invoice ***********************/
IF OBJECT_ID ('xcrm_invoice', 'VIEW') IS NOT NULL DROP VIEW xcrm_invoice
GO
CREATE VIEW dbo.xcrm_invoice 
--//WITH ENCRYPTION	
AS
	select cliente,listapreciosesp,moneda,origenid,estatus,movid,id,origen, isnull(importe ,0) importe , isnull(impuestos,0) impuestos, isnull(preciototal,0) preciototal 
	,ultimocambio,mov
	from venta
	--ventad.*,venta.ultimocambio,venta.mov from ventad
	--join venta on(venta.id=ventad.id)  
	where venta.mov in ('Factura','Devolucion Venta') and (origen in ('Pedido') or origen is null) and foliocrm is not null
GO