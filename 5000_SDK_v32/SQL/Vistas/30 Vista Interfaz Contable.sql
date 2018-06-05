
/****************************** Visor Contable *******************************/

/*** VentaCont ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaCont') and type = 'V') drop view dbo.VentaCont
GO
CREATE VIEW VentaCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Venta

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** CxcCont ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcCont') and type = 'V') drop view dbo.CxcCont
GO
CREATE VIEW CxcCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Cxc

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** CxpCont ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpCont') and type = 'V') drop view dbo.CxpCont
GO
CREATE VIEW CxpCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Cxp

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** GastoCont ***/
if exists (select * from sysobjects where id = object_id('dbo.GastoCont') and type = 'V') drop view dbo.GastoCont
GO
CREATE VIEW GastoCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Gasto

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** CompraCont ***/
if exists (select * from sysobjects where id = object_id('dbo.CompraCont') and type = 'V') drop view dbo.CompraCont
GO
CREATE VIEW CompraCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Compra

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** InvCont ***/
if exists (select * from sysobjects where id = object_id('dbo.InvCont') and type = 'V') drop view dbo.InvCont
GO
CREATE VIEW InvCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Inv

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** DineroCont ***/
if exists (select * from sysobjects where id = object_id('dbo.DineroCont') and type = 'V') drop view dbo.DineroCont
GO
CREATE VIEW DineroCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Dinero

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** EmbarqueCont ***/
if exists (select * from sysobjects where id = object_id('dbo.EmbarqueCont') and type = 'V') drop view dbo.EmbarqueCont
GO
CREATE VIEW EmbarqueCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Embarque

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** SoporteCont ***/
if exists (select * from sysobjects where id = object_id('dbo.SoporteCont') and type = 'V') drop view dbo.SoporteCont
GO
CREATE VIEW SoporteCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Soporte

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** ActivoFijoCont ***/
if exists (select * from sysobjects where id = object_id('dbo.ActivoFijoCont') and type = 'V') drop view dbo.ActivoFijoCont
GO
CREATE VIEW ActivoFijoCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  ActivoFijo

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** NominaCont ***/
if exists (select * from sysobjects where id = object_id('dbo.NominaCont') and type = 'V') drop view dbo.NominaCont
GO
CREATE VIEW NominaCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Nomina

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** AsisteCont ***/
if exists (select * from sysobjects where id = object_id('dbo.AsisteCont') and type = 'V') drop view dbo.AsisteCont
GO
CREATE VIEW AsisteCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Asiste

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** RHCont ***/
if exists (select * from sysobjects where id = object_id('dbo.RHCont') and type = 'V') drop view dbo.RHCont
GO
CREATE VIEW RHCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  RH

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** AgentCont ***/
if exists (select * from sysobjects where id = object_id('dbo.AgentCont') and type = 'V') drop view dbo.AgentCont
GO
CREATE VIEW AgentCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Agent

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** CambioCont ***/
if exists (select * from sysobjects where id = object_id('dbo.CambioCont') and type = 'V') drop view dbo.CambioCont
GO
CREATE VIEW CambioCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Cambio

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** ConciliacionCont ***/
if exists (select * from sysobjects where id = object_id('dbo.ConciliacionCont') and type = 'V') drop view dbo.ConciliacionCont
GO
CREATE VIEW ConciliacionCont
WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END
FROM 
  Conciliacion
WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO


/*** ProdCont ***/
if exists (select * from sysobjects where id = object_id('dbo.ProdCont') and type = 'V') drop view dbo.ProdCont
GO
CREATE VIEW ProdCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Prod

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** PCCont ***/
if exists (select * from sysobjects where id = object_id('dbo.PCCont') and type = 'V') drop view dbo.PCCont
GO
CREATE VIEW PCCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  PC

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** CRCont ***/
if exists (select * from sysobjects where id = object_id('dbo.CRCont') and type = 'V') drop view dbo.CRCont
GO
CREATE VIEW CRCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  CR

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** ValeCont ***/
if exists (select * from sysobjects where id = object_id('dbo.ValeCont') and type = 'V') drop view dbo.ValeCont
GO
CREATE VIEW ValeCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Vale

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** ReclutaCont ***/
if exists (select * from sysobjects where id = object_id('dbo.ReclutaCont') and type = 'V') drop view dbo.ReclutaCont
GO
CREATE VIEW ReclutaCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Recluta

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** IncidenciaCont ***/
if exists (select * from sysobjects where id = object_id('dbo.IncidenciaCont') and type = 'V') drop view dbo.IncidenciaCont
GO
CREATE VIEW IncidenciaCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  Incidencia

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO

/*** CPCont ***/
if exists (select * from sysobjects where id = object_id('dbo.CPCont') and type = 'V') drop view dbo.CPCont
GO
CREATE VIEW CPCont
--//WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END

FROM 
  CP

WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO


/*** FiscalCont ***/
if exists (select * from sysobjects where id = object_id('dbo.FiscalCont') and type = 'V') drop view dbo.FiscalCont
GO
CREATE VIEW FiscalCont
WITH ENCRYPTION
AS 
SELECT 
  ID,
  Empresa, 
  FechaEmision,
  Mov,
  MovID,
  Poliza,
  PolizaID,
  ContID,
  Sucursal,
  "Estatus" = CASE WHEN Estatus = 'CANCELADO' THEN 'CANCELADO' WHEN GenerarPoliza = 1 THEN 'PENDIENTE' WHEN GenerarPoliza = 0 AND Poliza IS NOT NULL AND PolizaID IS NOT NULL THEN 'CONTABILIZADO' WHEN GenerarPoliza = 0 AND ContID IS NOT NULL THEN 'PROCESAR' ELSE 'N/A' END
FROM 
  Fiscal
WHERE 
  Estatus NOT IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
GO