IF EXISTS(SELECT * FROM sysobjects where name ='Venta' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVVentaEP')
CREATE INDEX tnMFAVVentaEP ON Venta(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='Agent' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVAgentEP')
CREATE INDEX tnMFAVAgentEP ON Agent(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='Cxc' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVCxcEP')
CREATE INDEX tnMFAVCxcEP ON Agent(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='Cxp' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVCxpEP')
CREATE INDEX tnMFAVCxpEP ON Agent(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='Compra' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVCompraEP')
CREATE INDEX tnMFAVCompraEP ON Agent(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='Gasto' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVGastoEP')
CREATE INDEX tnMFAVGastoEP ON Agent(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='aplicaciones' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnaplicaciones1')
CREATE INDEX tnaplicaciones1 ON aplicaciones(Periodo,Ejercicio,Empresa)
GO