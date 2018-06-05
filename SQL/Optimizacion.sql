/* Importante */
/* Este script se debe de ejecutar fuera de operación, se debe revisar el espacio en disco antes de su ejecución debido que la creación de indices incrementa el tamaño de la base de datos de un 10% a un 12% */

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Mon' AND sysindexes.name = 'Clave' AND sysobjects.id = sysindexes.id)
    CREATE INDEX Clave ON Mon(Clave)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovFlujo' AND sysindexes.name = 'Destino' AND sysobjects.id = sysindexes.id)
    CREATE INDEX Destino ON MovFlujo(DID,DModulo,OModulo,OID,Sucursal,Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovFlujo' AND sysindexes.name = 'DestinoSAT' AND sysobjects.id = sysindexes.id)
    CREATE INDEX DestinoSAT ON MovFlujo(DID,DModulo,Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovFlujo' AND sysindexes.name = 'OrigenSAT' AND sysobjects.id = sysindexes.id)
    CREATE INDEX OrigenSAT ON MovFlujo(OID,OModulo,Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovFlujo' AND sysindexes.name = 'Cancelado' AND sysobjects.id = sysindexes.id)
    CREATE INDEX Cancelado ON MovFlujo(OID, Cancelado)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovFlujo' AND sysindexes.name = 'DestinoID' AND sysobjects.id = sysindexes.id)
    CREATE INDEX DestinoID	ON MovFlujo(DID, DModulo)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovFlujo' AND sysindexes.name = 'OrigenCancelado' AND sysobjects.id = sysindexes.id)
    CREATE INDEX OrigenCancelado ON MovFlujo (OID,OModulo,DMov,Cancelado)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Estatus' AND sysobjects.id = sysindexes.id)
    CREATE INDEX Estatus ON Dinero (Estatus)INCLUDE (ID,Importe,Impuestos,Corte,CorteDestino)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovImpuesto' AND sysindexes.name = 'Modulo' AND sysobjects.id = sysindexes.id)
    CREATE INDEX Modulo ON MovImpuesto(Modulo)INCLUDE (ModuloID,Impuesto1,Impuesto2,Impuesto3,Importe1,Importe2,Importe3,SubTotal,LoteFijo,Excento1,Excento2,Retencion1,Retencion2,Retencion3,Excento3,OrigenModulo,OrigenModuloID,OrigenConcepto,OrigenDeducible,OrigenFecha)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'OrigenID' AND sysobjects.id = sysindexes.id)
    CREATE INDEX OrigenID ON Cont(Empresa,OrigenTipo)INCLUDE(ID,Origen,OrigenID)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'OrigenTipo' AND sysobjects.id = sysindexes.id)
    CREATE INDEX OrigenTipo ON Cont (Empresa,OrigenTipo,Origen,OrigenID)INCLUDE (ID)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovFlujo' AND sysindexes.name = 'ContSAT' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ContSAT ON MovFlujo(DID,DMov,Sucursal,Empresa,OModulo,OID,DModulo)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'EstatusCorte' AND sysobjects.id = sysindexes.id)
    CREATE INDEX EstatusCorte ON Dinero(ID,Estatus,Corte,CorteDestino)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'EjercicioPeriodo' AND sysobjects.id = sysindexes.id)
    CREATE INDEX EjercicioPeriodo ON Cont(Periodo,Ejercicio,Estatus,Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContD' AND sysindexes.name = 'CuentaID' AND sysobjects.id = sysindexes.id)
    CREATE INDEX CuentaID ON ContD(ID,Cuenta)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATCFDCBB' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ContID ON ContSATCFDCBB(ContID)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATExtranjero' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ContID ON ContSATExtranjero(ContID)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATCheque' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ContID ON ContSATCheque(ContID)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATCheque' AND sysindexes.name = 'BancoOrigen' AND sysobjects.id = sysindexes.id)
    CREATE INDEX BancoOrigen ON ContSATCheque(BancoOrigen)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATTranferencia' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ContID ON ContSATTranferencia(ContID)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATOtroMetodoPago' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ContID ON ContSATOtroMetodoPago(ContID)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CtaDinero' AND sysindexes.name = 'Institucion' AND sysobjects.id = sysindexes.id)
    CREATE INDEX Institucion ON CtaDinero(Institucion)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CFDEgreso' AND sysindexes.name = 'ContSAT' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ContSAT ON CFDEgreso(Modulo,ModuloID)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Mov' AND sysindexes.name = 'ContSAT' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ContSAT ON Mov(ID,Modulo,Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CONT' AND sysindexes.name = 'ContOrigenTipo' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ContOrigenTipo ON CONT(OrigenID,Origen,OrigenTipo,Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATComprobante' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ModuloID ON  ContSATComprobante(UUID,ModuloID,Modulo)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATComprobante' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ContID ON ContSATComprobante(ContID, ModuloID, Modulo)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATComprobante' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
    CREATE INDEX ModuloID ON ContSATComprobante(ModuloID,Modulo)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Concepto' AND sysindexes.name = 'Excento' AND sysobjects.id = sysindexes.id)
    CREATE INDEX Excento ON Concepto(Concepto)INCLUDE(Impuesto1Excento,Excento2,Excento3)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Empresa' AND sysobjects.id = sysindexes.id)
    CREATE INDEX Empresa ON Cont(Empresa)INCLUDE(ID,Mov,MovID,OrigenTipo,Origen,OrigenID)
GO
IF not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATMovFlujo' AND sysindexes.name = 'SucursalEmpresa' AND sysobjects.id = sysindexes.id)
	CREATE INDEX SucursalEmpresa ON ContSATMovFlujo([Sucursal], [Empresa], [DModulo], [DID], [PagoSueldo])
GO
IF not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATMovFlujo' AND sysindexes.name = 'DModuloPModulo' AND sysobjects.id = sysindexes.id)
	CREATE INDEX DModuloPModulo ON ContSATMovFlujo([DModulo], [PModulo], [PID], [PagoSueldo])
GO	
IF not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATMovFlujo' AND sysindexes.name = 'DModulo' AND sysobjects.id = sysindexes.id)
	CREATE INDEX DModulo ON ContSATMovFlujo([DModulo], [PModulo], [PagoSueldo]) INCLUDE ([PID])	
GO
IF not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATMovFlujo' AND sysindexes.name = 'DModuloDID' AND sysobjects.id = sysindexes.id)
	CREATE INDEX DModuloDID ON ContSATMovFlujo([DModulo], [DID])
GO	
IF not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATMovFlujo' AND sysindexes.name = 'PModuloPID' AND sysobjects.id = sysindexes.id)
	CREATE INDEX PModuloPID ON ContSATMovFlujo([PModulo], [PID])
GO	
IF not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContSATMovFlujo' AND sysindexes.name = 'OModuloOID' AND sysobjects.id = sysindexes.id)
	CREATE INDEX OModuloOID ON ContSATMovFlujo([OModulo], [OID])
GO
