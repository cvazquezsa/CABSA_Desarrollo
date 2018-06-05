SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/****** MovAPP ******/
if not exists(select * from SysTabla where SysTabla = 'MovAPP')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovAPP','Movimiento')
if exists (select * from sysobjects where id = object_id('dbo.MovAPP') and type = 'U')  DROP TABLE dbo.MovAPP
CREATE TABLE dbo.MovAPP (
	MacAddress	   varchar(50)	      NOT NULL, 
	ID	           int	IDENTITY(1,1) NOT NULL,
	RFCReceptor    varchar(20)	NULL, 
	Modulo         char(5)            NOT NULL, 
	FechaEmision   datetime     NULL, 
	Folio 	       varchar(20)	NULL, 
	Serie 	       varchar(20)	NULL, 
	Moneda         varchar(30)  NULL, 
	TipoCambio     float        NULL, 
	RFC 	       varchar(20)	NULL, 
	Nombre	       varchar(100)	NULL, 
	Direccion	   varchar(100) NULL, 
	DireccionNum   varchar(20)	NULL, 
	Colonia	       varchar(100)	NULL, 
	Poblacion	   varchar(100) NULL, 
	Delegacion	   varchar(100)	NULL, 
	Estado 	       varchar(30)  NULL, 
	Pais	       varchar(30)	NULL, 
	CodigoPostal   varchar(15)	NULL, 
	Concepto	   varchar(50)	NULL, 
	Importe	       money	NULL, 
	Impuesto	   money	NULL, 
	Retencion	   money	NULL, 
	Retencion2	   money	NULL, 
	Retencion3	   money	NULL, 
	IEPS	       money	NULL, 
	UUID 	       varchar(50) 	NULL,
	Documento	   text     	NULL, 
	Impuesto1     float        NULL, 
	ISH            money        NULL, 
	TasaISH        float        NULL, 

  CONSTRAINT priMovAPP PRIMARY KEY CLUSTERED (MacAddress, ID)
)
GO


/****** MacAddressAPP  ******/
if not exists(select * from SysTabla where SysTabla = 'MacAddressAPP')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MacAddressAPP','Maestro')
if exists (select * from sysobjects where id = object_id('dbo.MacAddressAPP') and type = 'U')  DROP TABLE dbo.MacAddressAPP
CREATE TABLE dbo.MacAddressAPP(
MacAddress	   varchar(50)	      NOT NULL, 
Empresa        char(5)            NOT NULL,
Sucursal       int                NOT NULL, 
Usuario        varchar(10)        NOT NULL, 
Proveedor      varchar(10)        NOT NULL, 
CentroCostos   varchar(20)             NULL,
Activa   	   bit		NOT NULL	DEFAULT 1,
AltaAcreedor   bit		NOT NULL	DEFAULT 0,
CONSTRAINT priMacAddressAPP PRIMARY KEY CLUSTERED (MacAddress, Empresa))
GO



/****** ContSATCFDTempAPP ******/
if not exists(select * from SysTabla where SysTabla = 'ContSATCFDTempAPP')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ContSATCFDTempAPP','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.ContSATCFDTempAPP') and type = 'U') 
CREATE TABLE dbo.ContSATCFDTempAPP (
         MacAddress             varchar(50)   NOT NULL,
         Modulo                 varchar(20)   NULL,
         ModuloID               int           NULL,
         Empresa                varchar(5)    NULL,
         Fecha                  datetime      NULL,
         Ejercicio              int           NULL     ,
         Periodo                int           NULL,
         Ruta                   varchar(500)  NULL,
         Documento              varchar(max)  NULL,
         RFCReceptor            varchar(50)   NULL,  
         RFCEmisor              varchar(50)   NULL,
         Importe                float         NULL,
         UUID                   varchar(50)   NULL,
	CONSTRAINT priContSATCFDTempAPP PRIMARY KEY  CLUSTERED (MacAddress)
)
GO 

/****** ConceptoAPP  ******/
if not exists(select * from SysTabla where SysTabla = 'ConceptoAPP')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ConceptoAPP','Maestro')
if exists (select * from sysobjects where id = object_id('dbo.ConceptoAPP') and type = 'U')  DROP TABLE dbo.ConceptoAPP
CREATE TABLE dbo.ConceptoAPP(
	Modulo  	   char(5)	      NOT NULL, 
	Concepto       varchar(50)    NOT NULL,
	ConceptoAPP    varchar(50)    NOT NULL
CONSTRAINT priConceptoAPP PRIMARY KEY CLUSTERED (Modulo, ConceptoAPP))
GO

EXEC spAlter_Table 'MovTipo', 'ContRelacionarComp', 'bit NULL DEFAULT 0'
GO