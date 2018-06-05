 SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO

/****** LDIServicio ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'LDIServicio')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('LDIServicio', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.LDIServicio') AND type = 'U') 
  CREATE TABLE dbo.LDIServicio (
	Servicio		varchar(20)	NOT NULL,	
	ServicioInverso		varchar(20)	NULL,	
	DireccionIP		varchar(15)	NULL,
	Puerto			varchar(10)	NULL,
	TrxType			varchar(10)	NULL,
	TrxSubType		varchar(10)	NULL,
	EntryMode		varchar(10)	NULL,
	GeneraVoucher		varchar(10)	NULL,
	AnchoVoucher		int		NULL,
	Tipo			varchar(20)	NULL,	
	POSForma		varchar(50)	NULL,	
	
	CONSTRAINT priLDIServicio PRIMARY KEY CLUSTERED (Servicio))
GO

EXEC spALTER_TABLE 'LDIServicio', 'POSForma', 'varchar(50) NULL'
GO



/****** LDIEstacionTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'LDIEstacionTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('LDIEstacionTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.LDIEstacionTemp') AND type = 'U') 
  CREATE TABLE dbo.LDIEstacionTemp (
	Estacion                int NOT NULL,
	EstacionFija            int NULL,
	
	CONSTRAINT priLDIEstacionTemp PRIMARY KEY CLUSTERED (Estacion))
GO

/****** LDIMovLog ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'LDIMovLog')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('LDIMovLog', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.LDIMovLog') AND type = 'U') 
  CREATE TABLE dbo.LDIMovLog (
  	ID			int   IDENTITY,
  	IDModulo                varchar(36)     NOT NULL,
  	Modulo                  varchar(5)      NOT NULL,
  	Servicio                varchar(50)     NULL,
        Fecha                   varchar(20)     NULL,
        TipoTransaccion         varchar(50)     NULL, 
        TipoSubservicio         varchar(50)     NULL,
        CodigoRespuesta         varchar(50)     NULL, 
        DescripcionRespuesta    varchar(255)    NULL, 
        OrigenRespuesta         varchar(50)     NULL, 
        InfoAdicional           varchar(50)     NULL, 
        IDTransaccion           varchar(50)     NULL,
        CodigoAutorizacion      varchar(50)     NULL,
        Importe                 float           NULL,
        Comprobante             varchar(Max)    NULL,
        Cadena                  varchar(Max)    NULL,
        CadenaRespuesta         varchar(Max)    NULL,
        RIDCobro                int             NULL,        
        TotalRegistros          varchar(100)    NULL,        
        ListaMontos             varchar(Max)    NULL,        
        ListaReferencias        varchar(Max)    NULL,        
        ListaFechas             varchar(Max)    NULL,        
        ListaConceptos          varchar(Max)    NULL,        
        ListaMovimientos        varchar(Max)    NULL,        
  	CONSTRAINT priLDIMovLog PRIMARY KEY CLUSTERED (ID,IDModulo,Modulo)
  	)
GO

--REQ 15448
EXEC spALTER_TABLE 'LDIMovLog', 'TotalRegistros', 'varchar(100) NULL' 
EXEC spALTER_TABLE 'LDIMovLog', 'ListaMontos', 'varchar(max) NULL' 
EXEC spALTER_TABLE 'LDIMovLog', 'ListaReferencias', 'varchar(max) NULL' 
EXEC spALTER_TABLE 'LDIMovLog', 'ListaFechas', 'varchar(max) NULL' 
EXEC spALTER_TABLE 'LDIMovLog', 'ListaConceptos', 'varchar(max) NULL' 
EXEC spALTER_TABLE 'LDIMovLog', 'ListaMovimientos', 'varchar(max) NULL' 

GO