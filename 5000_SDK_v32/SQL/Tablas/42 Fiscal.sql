/*******************************************************************************************/
/*                                         FISCAL                               	   */
/*******************************************************************************************/


-- drop table ObligacionFiscalTasa 
/****** ObligacionFiscalTasa  ******/
/*if not exists(select * from SysTabla where SysTabla = 'ObligacionFiscalTasa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ObligacionFiscalTasa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ObligacionFiscalTasa') and type = 'U') 
CREATE TABLE dbo.ObligacionFiscalTasa (
	ObligacionFiscal	varchar(50) 	NOT NULL,
	Tasa			float		NOT NULL,
	Excento			bit		NOT NULL	DEFAULT 0,

	Cuenta			varchar(20)	NULL,
	Cuenta2			varchar(20)	NULL,
	
	CONSTRAINT priObligacionFiscalTasa PRIMARY KEY CLUSTERED (ObligacionFiscal, Tasa, Excento)
)*/
GO

/****** EcuadorTipoOperacionGasto ******/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE Name='EcuadorTipoOperacionGasto' AND type='U')
CREATE TABLE EcuadorTipoOperacionGasto (
      EcuadorTipoOperacionGasto varchar(50) NOT NULL,

      CONSTRAINT priEcuadorTipoOperacionGasto PRIMARY KEY  CLUSTERED (EcuadorTipoOperacionGasto)
  )

GO


/****** TipoComprobante ******/
if not exists(select * from SysTabla where SysTabla = 'TipoComprobante')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoComprobante','Maestro')

if not exists (select * from sysobjects where id = object_id('dbo.TipoComprobante') and type = 'U') 
CREATE TABLE dbo.TipoComprobante (
	TipoComprobante		varchar(20)	NOT NULL,

	Concepto		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,        
	VigenciaD		datetime	NULL,

	CONSTRAINT priTipoComprobante PRIMARY KEY  CLUSTERED (TipoComprobante)
)
GO

EXEC spALTER_TABLE 'TipoComprobante', 'VigenciaD', 'datetime NULL'
GO

if (select version from version) <= 3499
BEGIN
  EXEC("spEliminarPK 'TipoComprobante'")
  EXEC("spDROP_COLUMN 'TipoComprobante', 'ID'")
  EXEC("ALTER TABLE TipoComprobante ADD CONSTRAINT priTipoComprobante PRIMARY KEY  CLUSTERED (TipoComprobante)")
END
GO

/****** TipoComprobanteD ******/
if not exists(select * from SysTabla where SysTabla = 'TipoComprobanteD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoComprobanteD','Maestro')

if not exists (select * from sysobjects where id = object_id('dbo.TipoComprobanteD') and type = 'U') 
CREATE TABLE dbo.TipoComprobanteD (
	TipoComprobante		varchar(20)	NOT NULL,

	Concepto		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,        
	VigenciaD		datetime	NOT NULL,
	TieneMovimientos	bit		NULL,

	CONSTRAINT priTipoComprobanteD PRIMARY KEY  CLUSTERED (TipoComprobante,VigenciaD)
)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgTipoComprobanteAB') and sysstat & 0xf = 8) drop trigger dbo.tgTipoComprobanteAB
GO
CREATE TRIGGER tgTipoComprobanteAB ON TipoComprobante
--//WITH ENCRYPTION
FOR INSERT, DELETE
AS BEGIN
  DECLARE
    @TipoComprobanteN	varchar(10),
    @TipoComprobanteA	varchar(10)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT 
    @TipoComprobanteN = TipoComprobante
    FROM Inserted

  SELECT 
    @TipoComprobanteA = TipoComprobante
    FROM Deleted

  IF @TipoComprobanteA IS NULL AND  @TipoComprobanteN IS NOT NULL
    INSERT TipoComprobanteD (TipoComprobante, Concepto, Referencia,VigenciaD, TieneMovimientos)
                     SELECT  TipoComprobante, Concepto, Referencia,VigenciaD, 0
      FROM Inserted
  ELSE IF @TipoComprobanteA IS NOT NULL AND  @TipoComprobanteN IS NULL
    DELETE TipoComprobanteD WHERE TipoComprobante = @TipoComprobanteA
END
GO

/****** SustentoComprobante ******/
if not exists(select * from SysTabla where SysTabla = 'SustentoComprobante')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SustentoComprobante','Maestro')

if not exists (select * from sysobjects where id = object_id('dbo.SustentoComprobante') and type = 'U') 
CREATE TABLE dbo.SustentoComprobante (
	SustentoComprobante		varchar(20)	NOT NULL,

	Concepto			varchar(50)	NULL,
	Referencia			varchar(50)	NULL,        
	VigenciaD			datetime	NULL,

	CONSTRAINT priSustentoComprobante PRIMARY KEY  CLUSTERED (SustentoComprobante)
)
GO

EXEC spALTER_TABLE 'SustentoComprobante', 'VigenciaD', 'datetime NULL'
GO

if (select version from version) <= 3499
BEGIN
  EXEC("spEliminarPK 'SustentoComprobante'")
  EXEC("spDROP_COLUMN 'SustentoComprobante', 'ID'")
  EXEC("ALTER TABLE SustentoComprobante ADD CONSTRAINT priSustentoComprobante PRIMARY KEY  CLUSTERED (SustentoComprobante)")
END
GO

/****** SustentoComprobanteD ******/
if not exists(select * from SysTabla where SysTabla = 'SustentoComprobanteD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SustentoComprobanteD','Maestro')

if not exists (select * from sysobjects where id = object_id('dbo.SustentoComprobanteD') and type = 'U') 
CREATE TABLE dbo.SustentoComprobanteD (
	SustentoComprobante		varchar(20)	NOT NULL,

	Concepto			varchar(50)	NULL,
	Referencia			varchar(50)	NULL,        
	VigenciaD			datetime	NOT NULL,
	TieneMovimientos		bit		NULL,

	CONSTRAINT priSustentoComprobanteD PRIMARY KEY  CLUSTERED (SustentoComprobante,VigenciaD)
)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgSustentoComprobanteAB') and sysstat & 0xf = 8) drop trigger dbo.tgSustentoComprobanteAB
GO
CREATE TRIGGER tgSustentoComprobanteAB ON SustentoComprobante
--//WITH ENCRYPTION
FOR INSERT, DELETE
AS BEGIN
  DECLARE
    @SustentoComprobanteN	varchar(10),
    @SustentoComprobanteA	varchar(10)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT 
    @SustentoComprobanteN = SustentoComprobante
    FROM Inserted

  SELECT 
    @SustentoComprobanteA = SustentoComprobante
    FROM Deleted

  IF @SustentoComprobanteA IS NULL AND  @SustentoComprobanteN IS NOT NULL
    INSERT SustentoComprobanteD (SustentoComprobante, Concepto, Referencia, VigenciaD, TieneMovimientos)
                         SELECT  SustentoComprobante, Concepto, Referencia, VigenciaD, 0
      FROM Inserted
  ELSE IF @SustentoComprobanteA IS NOT NULL AND  @SustentoComprobanteN IS NULL
    DELETE SustentoComprobanteD WHERE SustentoComprobante = @SustentoComprobanteA
END
GO

/****** SustentoComprobanteTipoComprobante ******/
if not exists(select * from SysTabla where SysTabla = 'SustentoComprobanteTipoComprobante')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SustentoComprobanteTipoComprobante','Maestro')

if not exists (select * from sysobjects where id = object_id('dbo.SustentoComprobanteTipoComprobante') and type = 'U') 
CREATE TABLE  dbo.SustentoComprobanteTipoComprobante (
	SustentoComprobante		varchar(20)	NOT NULL,
	TipoComprobante			varchar(20)	NOT NULL,

	CONSTRAINT priSustentoComprobanteTipoComprobante PRIMARY KEY  CLUSTERED (SustentoComprobante, TIpoComprobante)
)
GO

/****** EcuadorAutorizacion ******/
if not exists(select * from SysTabla where SysTabla = 'EcuadorAutorizacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EcuadorAutorizacion','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.EcuadorAutorizacion') and type = 'U') 
  CREATE TABLE dbo.EcuadorAutorizacion (
	ID		int		NOT NULL 	IDENTITY(1,1),

	Modulo		char(5)		NULL,
	Mov		varchar(20)	NULL,
	Empresa		char(5)		NULL,
	Sucursal	int		NULL,
	Serie		varchar(10)	NULL,

	FolioD		int		NULL,
	FolioA		int		NULL,
	Autorizacion	varchar(20)	NULL,
	PuntoEmision	varchar(20)	NULL,
	Establecimiento	varchar(20)	NULL,
	FechaRegistro	datetime	NULL,
	Vigencia	datetime	NULL,
	Secuencial	varchar(20)	NULL,

	CONSTRAINT priEcuadorAutorizacion PRIMARY KEY CLUSTERED (ID)
)
GO

EXEC spALTER_TABLE 'EcuadorAutorizacion', 'Establecimiento', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EcuadorAutorizacion', 'Secuencial', 'varchar(20) NULL'
GO

/****** TipoRegistro ******/
if not exists(select * from SysTabla where SysTabla = 'TipoRegistro')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoRegistro','Maestro')

if not exists (select * from sysobjects where id = object_id('dbo.TipoRegistro') and type = 'U') 
CREATE TABLE dbo.TipoRegistro (
	TipoRegistro		varchar(20)	NOT NULL,

	Concepto		varchar(50)	NULL,      
	Mascara			varchar(50)	NULL,
	TipoContacto		varchar(20)	NULL,
	Referencia		varchar(50)	NULL,        
	VigenciaD		datetime	NULL,
	TipoID			varchar(20)	NULL,

	CONSTRAINT priTipoRegistro PRIMARY KEY  CLUSTERED (TipoRegistro)
)
GO

EXEC spALTER_TABLE 'TipoRegistro', 'VigenciaD', 'datetime NULL'
EXEC spALTER_TABLE 'TipoRegistro', 'TipoID', 'varchar(20)'
GO


if (select version from version) <= 3499
BEGIN
  EXEC("spEliminarPK 'TipoRegistro'")
  EXEC("spDROP_COLUMN 'TipoRegistro', 'ID'")
  EXEC("ALTER TABLE TipoRegistro ADD CONSTRAINT priTipoRegistro PRIMARY KEY  CLUSTERED (TipoRegistro)")
END
GO

/****** TipoRegistroD ******/
if not exists(select * from SysTabla where SysTabla = 'TipoRegistroD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoRegistroD','Maestro')

if not exists (select * from sysobjects where id = object_id('dbo.TipoRegistroD') and type = 'U') 
CREATE TABLE dbo.TipoRegistroD (
	TipoRegistro		varchar(20)	NOT NULL,

	Concepto		varchar(50)	NULL,      
	Mascara			varchar(50)	NULL,
	TipoContacto		varchar(20)	NULL,
	Referencia		varchar(50)	NULL,        
	VigenciaD		datetime	NOT NULL,
	TieneMovimientos	bit		NULL,

	CONSTRAINT priTipoRegistroD PRIMARY KEY  CLUSTERED (TipoRegistro,VigenciaD)
)
GO


if exists (select * from sysobjects where id = object_id('dbo.tgTipoRegistroAB') and sysstat & 0xf = 8) drop trigger dbo.tgTipoRegistroAB
GO
-- Aqui va el Matenimiento a la tabla
CREATE TRIGGER tgTipoRegistroAB ON TipoRegistro
--//WITH ENCRYPTION
FOR INSERT, DELETE
AS BEGIN
  DECLARE
    @TipoRegistroN	varchar(10),
    @TipoRegistroA	varchar(10)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT 
    @TipoRegistroN = TipoRegistro
    FROM Inserted

  SELECT 
    @TipoRegistroA = TipoRegistro
    FROM Deleted

  IF @TipoRegistroA IS NULL AND  @TipoRegistroN IS NOT NULL
    INSERT TipoRegistroD (TipoRegistro, Concepto, Mascara, TipoContacto, Referencia, VigenciaD, TieneMovimientos)
                  SELECT  TipoRegistro, Concepto, Mascara, TipoContacto, Referencia, VigenciaD, 0
      FROM Inserted
  ELSE IF @TipoRegistroA IS NOT NULL AND  @TipoRegistroN IS NULL
    DELETE TipoRegistroD WHERE TipoRegistro = @TipoRegistroA
END
GO

EXEC spDROP_TABLE 'ObligacionFiscal', 3089
GO
/****** ObligacionFiscal  ******/
if not exists(select * from SysTabla where SysTabla = 'ObligacionFiscal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ObligacionFiscal','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ObligacionFiscal') and type = 'U') 
CREATE TABLE dbo.ObligacionFiscal (
	ObligacionFiscal	varchar(50) 	NOT NULL,
	
	Tipo			varchar(20)	NULL,		--Impuesto 1, Impuesto 2, Impuesto 3, Retencion 1, Retencion 2, Retencion 3, Base 2, Base 3
	Orden			int		NULL,

	Acreedor		varchar(10)	NULL,
	Condicion		varchar(50)	NULL,

	GenerarEn		varchar(20)	NULL,		-- No, Emision, Flujo

	FechaD			datetime	NULL,
	FechaA			datetime	NULL,

/*	Cuenta			varchar(20)	NULL,
	Cuenta2			varchar(20)	NULL,
*/	

	Regimen			varchar(30)	NOT NULL DEFAULT '(Todos)'
	CONSTRAINT priObligacionFiscal PRIMARY KEY CLUSTERED (ObligacionFiscal)
)
GO
EXEC spDROP_COLUMN 'ObligacionFiscal', 'Deudor'
GO
EXEC spALTER_TABLE 'ObligacionFiscal', 'FechaD', 'datetime NULL'
EXEC spALTER_TABLE 'ObligacionFiscal', 'FechaA', 'datetime NULL'
EXEC spALTER_TABLE 'ObligacionFiscal', 'Regimen', 'varchar(30) NOT NULL DEFAULT "(Todos)" WITH VALUES'
GO

/*EXEC spALTER_TABLE 'ObligacionFiscal', 'Cuenta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ObligacionFiscal', 'Cuenta2', 'varchar(20) NULL'*/
GO
--if exists (select * from sysobjects where id = object_id('dbo.tgObligacionFiscalBC') and sysstat & 0xf = 8) drop trigger dbo.tgObligacionFiscalBC
GO
/*CREATE TRIGGER tgObligacionFiscalBC ON ObligacionFiscal
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ObligacionFiscalN  varchar(50),
    @ObligacionFiscalA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ObligacionFiscalN = ObligacionFiscal FROM Inserted
  SELECT @ObligacionFiscalA = ObligacionFiscal FROM Deleted
  IF @ObligacionFiscalN = @ObligacionFiscalA RETURN

  IF @ObligacionFiscalN IS NULL 
    DELETE ObligacionFiscalTasa WHERE ObligacionFiscal = @ObligacionFiscalA
  ELSE BEGIN
    UPDATE ObligacionFiscalTasa SET ObligacionFiscal = @ObligacionFiscalN WHERE ObligacionFiscal = @ObligacionFiscalA
  END
END*/
GO

/****** Consecutivos ******/
if not exists (select * from SysTabla where SysTabla = 'FiscalC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('FiscalC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.FiscalC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.FiscalC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priFiscalC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'FiscalC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'FiscalC', '(ID)'
GO


-- drop table Fiscal
/****** Fiscal (Ficha) ******/
if not exists (select * from SysTabla where SysTabla = 'Fiscal') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Fiscal','Movimiento','FIS')
if not exists (select * from sysobjects where id = object_id('dbo.Fiscal') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Fiscal (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov  			char(20)        NOT NULL,
	MovID			varchar(20)    	NULL,	 
	FechaEmision 		datetime    	NULL,	 
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	UEN			int		NULL,
	Moneda 			char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		varchar(20)	NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,
	ContID			int		NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	Acreedor		varchar(10)	NULL,
	Condicion		varchar(50)	NULL,
	Vencimiento		datetime	NULL,

	CONSTRAINT priFiscal PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Fiscal'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Fiscal'
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Fiscal.Consecutivo
  ALTER TABLE Fiscal ALTER COLUMN MovID varchar(20)
  ALTER TABLE Fiscal ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Fiscal ALTER COLUMN PolizaID varchar(20)
END
GO
EXEC spModificarPK_Mov 'Fiscal'
GO
EXEC spALTER_TABLE 'Fiscal', 'Acreedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Fiscal', 'Condicion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Fiscal', 'Vencimiento', 'datetime NULL'
GO
EXEC spDROP_COLUMN 'Fiscal', 'Deudor'
GO

EXEC spFK 'Fiscal','Moneda','Mon','Moneda'
EXEC spFK 'Fiscal','UEN','UEN','UEN'
GO

-- Fiscal
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia   ON dbo.Fiscal (Referencia)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Fiscal (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Fiscal (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Fiscal (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Fiscal (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Fiscal (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Fiscal (ContID)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Fiscal.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Fiscal.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Fiscal.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Fiscal.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Fiscal.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Fiscal (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Fiscal (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Fiscal' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Fiscal (OrigenID,Origen,Empresa)
go
if exists (select * from sysobjects where id = object_id('dbo.tgFiscalA') and sysstat & 0xf = 8) drop trigger dbo.tgFiscalA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgFiscalC') and sysstat & 0xf = 8) drop trigger dbo.tgFiscalC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgFiscalB') and sysstat & 0xf = 8) drop trigger dbo.tgFiscalB
GO
EXEC spSincroNivelRegistroCampos 'Fiscal'
GO

-- Aqui va el Matenimiento a la tabla

EXEC spALTER_TABLE 'Fiscal', 'UEN', 'int NULL'
GO
CREATE TRIGGER tgFiscalC ON Fiscal
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 		char(5),
    @Mov		char(20),
    @Sucursal		int,
    @ID			int,
    @FechaInicio	datetime,
    @Ahora 		datetime,
    @FechaAnterior	datetime,
    @EstatusNuevo 	char(15),
    @EstatusAnterior 	char(15),
    @SituacionNueva 	varchar(50),
    @SituacionAnterior 	varchar(50),
    @Usuario		char(10),
    @Mensaje		char(255),
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Modulo = 'FIS'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '') FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @Usuario = Usuario FROM Inserted
  IF @EstatusNuevo <> @EstatusAnterior AND 
     ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('CONFIRMAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
      (@EstatusNuevo = 'CONFIRMAR'  AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO', 'CANCELADO')) OR
      (@EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END 
  ELSE BEGIN
    IF @EstatusNuevo NOT IN (NULL, 'AFECTANDO') AND (@EstatusAnterior <> @EstatusNuevo OR @SituacionAnterior <> @SituacionNueva)
    BEGIN
      IF @EstatusAnterior <> @EstatusNuevo AND (@EstatusAnterior <> 'AFECTANDO' OR @SituacionAnterior IS NULL OR @SituacionNueva IS NULL)
      BEGIN
        EXEC spMovSituacionNueva @Modulo, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva OUTPUT, @ID = @ID
      END
      SELECT @Ahora = GETDATE(), @FechaInicio = NULL
      SELECT @FechaInicio = MIN(FechaInicio), @FechaAnterior = MAX(FechaComenzo) FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID
      IF @FechaInicio IS NOT NULL AND @FechaAnterior IS NOT NULL
        UPDATE MovTiempo SET FechaTermino = @Ahora WHERE Modulo = @Modulo AND ID = @ID AND FechaComenzo = @FechaAnterior
      IF @FechaInicio IS NULL SELECT @FechaInicio = @Ahora

      INSERT INTO MovTiempo (Modulo,  Sucursal,  ID,  Usuario,                              FechaInicio,  FechaComenzo, Estatus,       Situacion) 
                     VALUES (@Modulo, @Sucursal, @ID, ISNULL(@AfectacionUsuario, @Usuario), @FechaInicio, @Ahora,       @EstatusNuevo, @SituacionNueva)
    END
  END

  EXEC spMovAlActualizar @Modulo, @ID, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva, @SituacionAnterior

  -- Para que cancele la poliza cuando Maneja SincroContabilidadMatriz
  IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE Fiscal SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgFiscalB ON Fiscal
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	char(15),
    @Mensaje	char(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'Fiscal', @ID
END
GO

-- MovImpuesto
-- DROP TABLE FiscalD
EXEC spDROP_TABLE 'FiscalD', 3089
GO
/****** Fiscal (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'FiscalD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('FiscalD','Movimiento','FIS')
if not exists (select * from sysobjects where id = object_id('dbo.FiscalD') and type = 'U') 
CREATE TABLE dbo.FiscalD (
	ID					int				NOT NULL,
 	Renglon				float			NOT NULL,

	ObligacionFiscal	varchar(50)		NULL,
	TipoImpuesto		varchar(10)		NULL,
	Importe				money			NULL,
	OtrosImpuestos		money			NULL,
	Base				as		(CASE WHEN RTRIM(ISNULL(Tipo,'')) NOT IN ('Impuesto 3') THEN (ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0)) ELSE NULL END), --MEJORA996
	Tasa				float			NULL,
	Excento				bit				NULL	DEFAULT 0,
	Deducible			float			NULL 	DEFAULT 100,

	Neto				as		(CASE WHEN Excento = 1 THEN NULL ELSE ((ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0))*(ISNULL(Tasa, 0.0)/100.0)*(ISNULL(Deducible, 0.0)/100.0))-((ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0))*(ISNULL(Retencion1, 0.0)/100.0)*(ISNULL(Deducible, 0.0)/100.0))-((ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0))*(ISNULL(Retencion2, 0.0)/100.0)*(ISNULL(Deducible, 0.0)/100.0))-((ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0))*(ISNULL(Retencion3, 0.0)/100.0)*(ISNULL(Deducible, 0.0)/100.0)) END), --MEJORA1019
	
	OrigenModulo		varchar(5)		NULL,
	OrigenModuloID		int				NULL,
	Contacto			varchar(10)		NULL,
	ContactoTipo		varchar(20)		NULL,
	AFArticulo			varchar(20)		NULL,
	AFSerie				varchar(20)		NULL,
	
	OrigenMoneda		varchar(10)		NULL,
	OrigenTipoCambio	float			NULL,
	Tipo				varchar(20)		NULL, --MEJORA996
	
	Retencion1			float			NULL, --MEJORA1019
	Retencion2			float			NULL, --MEJORA1019
	Retencion3			float			NULL, --MEJORA1019
	

	CONSTRAINT priFiscalD PRIMARY KEY CLUSTERED (ID, Renglon)

)
GO
EXEC spModificarPK_Sucursal 'FiscalD', '(ID, Renglon)'
GO
EXEC spALTER_TABLE 'FiscalD', 'TipoImpuesto', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'FiscalD', 'OrigenMoneda', 'varchar(10) NULL'
EXEC spALTER_TABLE 'FiscalD', 'OrigenTipoCambio', 'float NULL'
EXEC spALTER_TABLE 'FiscalD', 'Tipo', 'varchar(20) NULL' --MEJORA996
GO
EXEC spALTER_TABLE 'FiscalD', 'Retencion1', 'float NULL' --MEJORA1019
EXEC spALTER_TABLE 'FiscalD', 'Retencion2', 'float NULL' --MEJORA1019
EXEC spALTER_TABLE 'FiscalD', 'Retencion3', 'float NULL' --MEJORA1019
GO

EXEC spDROP_COLUMN 'FiscalD', 'Base' --MEJORA996
GO
EXEC spALTER_TABLE 'FiscalD', 'Base', 'as		(CASE WHEN RTRIM(ISNULL(Tipo,"")) NOT IN ("Impuesto 3") THEN (ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0)) ELSE NULL END)' --MEJORA996
GO
--EXEC spAlter_Table 'FiscalD', 'Neto', 'as (CASE WHEN Excento = 1 THEN NULL ELSE ((ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0))*(ISNULL(Tasa, 0.0)/100.0)*(ISNULL(Deducible, 0.0)/100.0))-((ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0))*(ISNULL(Retencion1, 0.0)/100.0)*(ISNULL(Deducible, 0.0)/100.0))-((ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0))*(ISNULL(Retencion2, 0.0)/100.0)*(ISNULL(Deducible, 0.0)/100.0))-((ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0))*(ISNULL(Retencion3, 0.0)/100.0)*(ISNULL(Deducible, 0.0)/100.0)) END)' --MEJORA1019
--GO
EXEC spDROP_COLUMN 'FiscalD', 'Neto'
GO
EXEC spAlter_Table 'FiscalD', 'Neto', 'as (CASE WHEN Excento = 1 THEN NULL ELSE ((ISNULL(Importe, 0.0)+ISNULL(OtrosImpuestos, 0.0))*(ISNULL(Tasa, 0.0)/100.0)*(ISNULL(Deducible, 0.0)/100.0)) END)'
GO
EXEC spADD_INDEX 'FiscalD', 'Origen', 'OrigenModuloID, OrigenModulo, ObligacionFiscal'
GO

EXEC spALTER_COLUMN 'FiscalD', 'AFSerie', 'varchar(50) NULL'  --BUG12333
GO

if exists (select * from sysobjects where id = object_id('dbo.cFiscalD') and sysstat & 0xf = 2) drop view dbo.cFiscalD
GO
CREATE VIEW cFiscalD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  ObligacionFiscal,
  TipoImpuesto,
  Importe,
  OtrosImpuestos,
  Tasa,
  Excento,
  Deducible,
  OrigenModulo,
  OrigenModuloID,
  AFArticulo,
  AFSerie,
  Contacto,
  ContactoTipo,

/*  DebeFiscal,
  HaberFiscal,
*/
  Sucursal,
  SucursalOrigen

FROM
  FiscalD
GO
