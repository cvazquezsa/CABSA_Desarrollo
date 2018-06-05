


/****************         VISTAS       ************************/


/******************   MÓDULO DE VENTAS   *****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.VentaExportacion') AND TYPE = 'V') 
  DROP VIEW VentaExportacion
GO
CREATE VIEW VentaExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Venta.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Venta.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Venta.*,
  Empresa.GLN GLN
  FROM Venta JOIN Empresa
    ON Venta.Empresa = Empresa.Empresa
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.VentaDExportacion') AND TYPE = 'V') 
  DROP VIEW VentaDExportacion
GO
CREATE VIEW VentaDExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  VentaD.*,
  Art.Descripcion1 Descripcion
  FROM VentaD JOIN Art
    ON VentaD.Articulo = Art.Articulo
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SerieLoteMovVTASExportacion') AND TYPE = 'V') 
  DROP VIEW SerieLoteMovVTASExportacion
GO
CREATE VIEW SerieLoteMovVTASExportacion AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  RTRIM(SerieLoteMov.SerieLote) 
  OrdenExportacion, 
  SerieLoteMov.*
  FROM SerieLoteMov JOIN VentaD
    ON SerieLoteMov.ID = VentaD.ID AND SerieLoteMov.RenglonID = VentaD.RenglonID
  WHERE SerieLoteMov.Modulo = 'VTAS'
GO


/*****************   MÓDULO DE COMPRAS    *******************/

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CompraExportacion') AND TYPE = 'V') 
  DROP VIEW CompraExportacion
GO
CREATE VIEW CompraExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Compra.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Compra.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Compra.*,
  Empresa.GLN GLN
  FROM Compra JOIN Empresa
    ON Compra.Empresa = Empresa.Empresa
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CompraDExportacion') AND TYPE = 'V') 
  DROP VIEW CompraDExportacion
GO
CREATE VIEW CompraDExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,CompraD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,CompraD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,CompraD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  CompraD.*,
  Art.Descripcion1 Descripcion
  FROM CompraD JOIN Art
    ON CompraD.Articulo = Art.Articulo
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SerieLoteMovCOMSExportacion') AND TYPE = 'V') 
  DROP VIEW SerieLoteMovCOMSExportacion
GO
CREATE VIEW SerieLoteMovCOMSExportacion AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CompraD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,CompraD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,CompraD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,CompraD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,CompraD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,CompraD.RenglonSub))) +
  RTRIM(SerieLoteMov.SerieLote) 
  OrdenExportacion, 
  SerieLoteMov.*
  FROM SerieLoteMov JOIN CompraD
    ON SerieLoteMov.ID = CompraD.ID AND SerieLoteMov.RenglonID = CompraD.RenglonID
  WHERE SerieLoteMov.Modulo = 'COMS'
GO


/*   ***************** MÓDULO DE ACTIVOS FIJOS *************************/

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ActivoFijoExportacion') AND TYPE = 'V') 
  DROP VIEW ActivoFijoExportacion
GO
CREATE VIEW ActivoFijoExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ActivoFijo.ID))))) + RTRIM(LTRIM(CONVERT(varchar,ActivoFijo.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  ActivoFijo.*,
  Empresa.GLN GLN
  FROM ActivoFijo JOIN Empresa
    ON ActivoFijo.Empresa = Empresa.Empresa
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ActivoFijoDExportacion') AND TYPE = 'V') 
  DROP VIEW ActivoFijoDExportacion
GO
CREATE VIEW ActivoFijoDExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,ActivoFijoD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,ActivoFijoD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,ActivoFijoD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  ActivoFijoD.*,
  Art.Descripcion1 Descripcion
  FROM ActivoFijoD JOIN Art
    ON ActivoFijoD.Articulo = Art.Articulo
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SerieLoteMovAFExportacion') AND TYPE = 'V') 
  DROP VIEW SerieLoteMovAFExportacion
GO
CREATE VIEW SerieLoteMovAFExportacion AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ActivoFijoD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,ActivoFijoD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,ActivoFijoD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,ActivoFijoD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,ActivoFijoD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,ActivoFijoD.RenglonSub))) +
  RTRIM(SerieLoteMov.SerieLote) 
  OrdenExportacion, 
  SerieLoteMov.*
  FROM SerieLoteMov JOIN ActivoFijoD
    ON SerieLoteMov.ID = ActivoFijoD.ID AND SerieLoteMov.RenglonID = ActivoFijoD.Renglon
  WHERE SerieLoteMov.Modulo = 'AF'
GO


/*******************     MÓDULO DE ASISTENCIAS     ***********************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.AsisteExportacion') AND TYPE = 'V') 
  DROP VIEW AsisteExportacion
GO
CREATE VIEW AsisteExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Asiste.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Asiste.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Asiste.*,
  Empresa.GLN GLN
  FROM Asiste JOIN Empresa
    ON Asiste.Empresa = Empresa.Empresa
GO


/*******************     MÓDULO DE COMISIONES Y DESTAJOS   **********************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.AgentExportacion') AND TYPE = 'V') 
  DROP VIEW AgentExportacion
GO
CREATE VIEW AgentExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Agent.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Agent.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Agent.*,
  Empresa.GLN GLN
  FROM Agent JOIN Empresa
    ON Agent.Empresa = Empresa.Empresa
GO


/*******************      MÓDULO DE CAMBIOS   ******************/

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CambioExportacion') AND TYPE = 'V') 
  DROP VIEW CambioExportacion
GO
CREATE VIEW CambioExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Cambio.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Cambio.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Cambio.*,
  Empresa.GLN GLN
  FROM Cambio JOIN Empresa
    ON Cambio.Empresa = Empresa.Empresa
GO


/*******************    MÓDULO DE CAPITAL     **************************/

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CapitalExportacion') AND TYPE = 'V') 
  DROP VIEW CapitalExportacion
GO
CREATE VIEW CapitalExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Capital.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Capital.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Capital.*,
  Empresa.GLN GLN
  FROM Capital JOIN Empresa
    ON Capital.Empresa = Empresa.Empresa
GO


/*******************      MÓDULO DE CAMPAÑAS   ******************/  

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CampanaExportacion') AND TYPE = 'V') 
  DROP VIEW CampanaExportacion
GO
CREATE VIEW CampanaExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Campana.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Campana.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Campana.*,
  Empresa.GLN GLN
  FROM Campana JOIN Empresa
    ON Campana.Empresa = Empresa.Empresa
GO


/*******************   MÓDULO DE CONCILIACIONES ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ConciliacionExportacion') AND TYPE = 'V') 
  DROP VIEW ConciliacionExportacion
GO
CREATE VIEW ConciliacionExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Conciliacion.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Conciliacion.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Conciliacion.*,
  Empresa.GLN GLN
  FROM Conciliacion JOIN Empresa
    ON Conciliacion.Empresa = Empresa.Empresa
GO

/*******************     MÓDULO DE CONTABILIDAD    ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ContExportacion') AND TYPE = 'V') 
  DROP VIEW ContExportacion
GO
CREATE VIEW ContExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Cont.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Cont.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Cont.*,
  Empresa.GLN GLN
  FROM Cont JOIN Empresa
    ON Cont.Empresa = Empresa.Empresa
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ContDExportacion') AND TYPE = 'V') 
  DROP VIEW ContDExportacion
GO
CREATE VIEW ContDExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,ContD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,ContD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,ContD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  ContD.*,
  Art.Descripcion1 Descripcion
  FROM ContD JOIN Art
    ON ContD.Articulo = Art.Articulo
GO


/*******************      MÓDULO DE CUENTAS POR COBRAR     ******************/  

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CxcExportacion') AND TYPE = 'V') 
  DROP VIEW CxcExportacion
GO
CREATE VIEW CxcExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Cxc.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Cxc.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Cxc.*,
  Empresa.GLN GLN
  FROM Cxc JOIN Empresa
    ON Cxc.Empresa = Empresa.Empresa
GO

/*******************      MÓDULO DE CUENTAS POR PAGAR     ******************/  

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CxpExportacion') AND TYPE = 'V') 
  DROP VIEW CxpExportacion
GO
CREATE VIEW CxpExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Cxp.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Cxp.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Cxp.*,
  Empresa.GLN GLN
  FROM Cxp JOIN Empresa
    ON Cxp.Empresa = Empresa.Empresa
GO


/*******************    MÓDULO DE TESORERÍA     ******************/  

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.DineroExportacion') AND TYPE = 'V') 
  DROP VIEW DineroExportacion
GO
CREATE VIEW DineroExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Dinero.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Dinero.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Dinero.*,
  Empresa.GLN GLN
  FROM Dinero JOIN Empresa
    ON Dinero.Empresa = Empresa.Empresa
GO


/*******************     MÓDULO DE EMBARQUES  ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.EmbarqueExportacion') AND TYPE = 'V') 
  DROP VIEW EmbarqueExportacion
GO
CREATE VIEW EmbarqueExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Embarque.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Embarque.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Embarque.*,
  Empresa.GLN GLN
  FROM Embarque JOIN Empresa
    ON Embarque.Empresa = Empresa.Empresa
GO


/*******************    MÓDULO FISCAL   ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.FiscalExportacion') AND TYPE = 'V') 
  DROP VIEW FiscalExportacion
GO
CREATE VIEW FiscalExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Fiscal.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Fiscal.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Fiscal.*,
  Empresa.GLN GLN
  FROM Fiscal JOIN Empresa
    ON Fiscal.Empresa = Empresa.Empresa
GO

/*******************      MÓDULO DE FORMAS EXTRAS   ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.FormaExtraExportacion') AND TYPE = 'V') 
  DROP VIEW FormaExtraExportacion
GO
CREATE VIEW FormaExtraExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,FormaExtra.ID))))) + RTRIM(LTRIM(CONVERT(varchar,FormaExtra.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  FormaExtra.*,
  Empresa.GLN GLN
  FROM FormaExtra JOIN Empresa
    ON FormaExtra.Empresa = Empresa.Empresa
GO


/*******************    MÓDULO DE GASTOS   ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.GastoExportacion') AND TYPE = 'V') 
  DROP VIEW GastoExportacion
GO
CREATE VIEW GastoExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Gasto.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Gasto.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Gasto.*,
  Empresa.GLN GLN
  FROM Gasto JOIN Empresa
    ON Gasto.Empresa = Empresa.Empresa
GO

/*******************    MÓDULO DE INCIDENCIAS   ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.IncidenciaExportacion') AND TYPE = 'V') 
  DROP VIEW IncidenciaExportacion
GO
CREATE VIEW IncidenciaExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Incidencia.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Incidencia.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Incidencia.*,
  Empresa.GLN GLN
  FROM Incidencia JOIN Empresa
    ON Incidencia.Empresa = Empresa.Empresa
GO


/*******************    MÓDULO DE INVENTARIOS     ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.InvExportacion') AND TYPE = 'V') 
  DROP VIEW InvExportacion
GO
CREATE VIEW InvExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Inv.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Inv.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Inv.*,
  Empresa.GLN GLN
  FROM Inv JOIN Empresa
    ON Inv.Empresa = Empresa.Empresa
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.InvDExportacion') AND TYPE = 'V') 
  DROP VIEW InvDExportacion
GO
CREATE VIEW InvDExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,InvD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,InvD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,InvD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  InvD.*,
  Art.Descripcion1 Descripcion
  FROM InvD JOIN Art
    ON InvD.Articulo = Art.Articulo
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SerieLoteMovINVExportacion') AND TYPE = 'V') 
  DROP VIEW SerieLoteMovINVExportacion
GO
CREATE VIEW SerieLoteMovINVExportacion AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,InvD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,InvD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,InvD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,InvD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,InvD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,InvD.RenglonSub))) +
  RTRIM(SerieLoteMov.SerieLote) 
  OrdenExportacion, 
  SerieLoteMov.*
  FROM SerieLoteMov JOIN InvD
    ON SerieLoteMov.ID = InvD.ID AND SerieLoteMov.RenglonID = InvD.RenglonID
  WHERE SerieLoteMov.Modulo = 'INV'
GO


/*******************      MÓDULO DE NÓMINA     ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.NominaExportacion') AND TYPE = 'V') 
  DROP VIEW NominaExportacion
GO
CREATE VIEW NominaExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Nomina.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Nomina.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Nomina.*,
  Empresa.GLN GLN
  FROM Nomina JOIN Empresa
    ON Nomina.Empresa = Empresa.Empresa
GO


/*******************      MÓDULO DE OFERTAS   ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.OfertaExportacion') AND TYPE = 'V') 
  DROP VIEW OfertaExportacion
GO
CREATE VIEW OfertaExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Oferta.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Oferta.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Oferta.*,
  Empresa.GLN GLN
  FROM Oferta JOIN Empresa
    ON Oferta.Empresa = Empresa.Empresa
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.OfertaDExportacion') AND TYPE = 'V') 
  DROP VIEW OfertaDExportacion
GO
CREATE VIEW OfertaDExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,OfertaD.ID))) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  OfertaD.*,
  Art.Descripcion1 Descripcion
  FROM OfertaD JOIN Art
    ON OfertaD.Articulo = Art.Articulo
GO

/*******************      MÓDULO DE PRECIOS Y COSTOS     ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.PCExportacion') AND TYPE = 'V') 
  DROP VIEW PCExportacion
GO
CREATE VIEW PCExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,PC.ID))))) + RTRIM(LTRIM(CONVERT(varchar,PC.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  PC.*,
  Empresa.GLN GLN
  FROM PC JOIN Empresa
    ON PC.Empresa = Empresa.Empresa
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.PCDExportacion') AND TYPE = 'V') 
  DROP VIEW PCDExportacion
GO
CREATE VIEW PCDExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,PCD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,PCD.Renglon))) + 
  REPLICATE(' ',50)
  OrdenExportacion, 
  PCD.*,
  Art.Descripcion1 Descripcion
  FROM PCD JOIN Art
    ON PCD.Articulo = Art.Articulo
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SerieLoteMovPCExportacion') AND TYPE = 'V') 
  DROP VIEW SerieLoteMovPCExportacion
GO
CREATE VIEW SerieLoteMovPCExportacion AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,PCD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,PCD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,PCD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,PCD.Renglon))) + 
  RTRIM(SerieLoteMov.SerieLote) 
  OrdenExportacion, 
  SerieLoteMov.*
  FROM SerieLoteMov JOIN PCD
    ON SerieLoteMov.ID = PCD.ID AND SerieLoteMov.RenglonID = PCD.Renglon
  WHERE SerieLoteMov.Modulo = 'PC'
GO


/*******************     MÓDULO DE PRESUPUESTOS    ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.PresupExportacion') AND TYPE = 'V') 
  DROP VIEW PresupExportacion
GO

CREATE VIEW PresupExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Presup.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Presup.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Presup.*,
  Empresa.GLN GLN
  FROM Presup JOIN Empresa
    ON Presup.Empresa = Empresa.Empresa
GO


/*******************     MÓDULO DE PRODUCCIÓN     ******************/  

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ProdExportacion') AND TYPE = 'V') 
  DROP VIEW ProdExportacion
GO
CREATE VIEW ProdExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Prod.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Prod.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Prod.*,
  Empresa.GLN GLN
  FROM Prod JOIN Empresa
    ON Prod.Empresa = Empresa.Empresa
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ProdDExportacion') AND TYPE = 'V') 
  DROP VIEW ProdDExportacion
GO
CREATE VIEW ProdDExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,ProdD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,ProdD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,ProdD.RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  ProdD.*,
  Art.Descripcion1 Descripcion
  FROM ProdD JOIN Art
    ON ProdD.Articulo = Art.Articulo
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SerieLoteMovPRODExportacion') AND TYPE = 'V') 
  DROP VIEW SerieLoteMovPRODExportacion
GO
CREATE VIEW SerieLoteMovPRODExportacion AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ProdD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,ProdD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,ProdD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,ProdD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,ProdD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,ProdD.RenglonSub))) +
  RTRIM(SerieLoteMov.SerieLote) 
  OrdenExportacion, 
  SerieLoteMov.*
  FROM SerieLoteMov JOIN ProdD
    ON SerieLoteMov.ID = ProdD.ID AND SerieLoteMov.RenglonID = ProdD.RenglonID
  WHERE SerieLoteMov.Modulo = 'PROD'
GO


/*******************      MÓDULO DE RECURSOS HUMANOS     ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.RHExportacion') AND TYPE = 'V') 
  DROP VIEW RHExportacion
GO
CREATE VIEW RHExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,RH.ID))))) + RTRIM(LTRIM(CONVERT(varchar,RH.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  RH.*,
  Empresa.GLN GLN
  FROM RH JOIN Empresa
    ON RH.Empresa = Empresa.Empresa
GO


/*******************      MÓDULO DE SOPORTE   ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SoporteExportacion') AND TYPE = 'V') 
  DROP VIEW SoporteExportacion
GO
CREATE VIEW SoporteExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Soporte.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Soporte.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Soporte.*,
  Empresa.GLN GLN
  FROM Soporte JOIN Empresa
    ON Soporte.Empresa = Empresa.Empresa
GO


/*******************     MÓDULO DE VALES    ******************/  
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ValeExportacion') AND TYPE = 'V') 
  DROP VIEW ValeExportacion
GO
CREATE VIEW ValeExportacion AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,Vale.ID))))) + RTRIM(LTRIM(CONVERT(varchar,Vale.ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion, 
  Vale.*,
  Empresa.GLN GLN
  FROM Vale JOIN Empresa
    ON Vale.Empresa = Empresa.Empresa
GO



/*******************       MÓDULO DE WAREHOUSE MANAGEMENT SYSTEM    ******************/

--IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.WMSExportacion') AND TYPE = 'V') 
--  DROP VIEW WMSExportacion
--GO
--CREATE VIEW WMSExportacion AS
--SELECT
--  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,WMS.ID))))) + RTRIM(LTRIM(CONVERT(varchar,WMS.ID))) +
--  REPLICATE('0',12) + 
--  REPLICATE('0',7) +
--REPLICATE(' ',50)
  --OrdenExportacion, 
  --WMS.*,
  --Empresa.GLN GLN
  --FROM WMS JOIN Empresa
--    ON WMS.Empresa = Empresa.Empresa
--GO

--IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.WMSDExportacion') AND TYPE = 'V') 
--  DROP VIEW WMSDExportacion
--GO
--CREATE VIEW WMSDExportacion AS
--SELECT
--  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,WMSD.ID))) +
--  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,WMSD.Renglon))) + 
--  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,WMSD.RenglonSub))) +
--  REPLICATE(' ',50)
--  OrdenExportacion, 
--  WMSD.*,
--  Art.Descripcion1 Descripcion
--  FROM WMSD JOIN Art
--  ON WMSD.Articulo = Art.Articulo
--   GO


--IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SerieLoteMovWMSExportacion') AND TYPE = 'V') 
--  DROP VIEW SerieLoteMovWMSExportacion
--GO
--CREATE VIEW SerieLoteMovWMSExportacion AS
--SELECT 
--  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,WMSD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,WMSD.ID))) +
--  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,WMSD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,WMSD.Renglon))) + 
--  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,WMSD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,WMSD.RenglonSub))) +
--  RTRIM(SerieLoteMov.SerieLote) 
--  OrdenExportacion, 
--  SerieLoteMov.*
--  FROM SerieLoteMov JOIN WMSD
--    ON SerieLoteMov.ID = WMSD.ID AND SerieLoteMov.RenglonID = wmsD.Renglon
--  WHERE SerieLoteMov.Modulo = 'WMS'
--GO

