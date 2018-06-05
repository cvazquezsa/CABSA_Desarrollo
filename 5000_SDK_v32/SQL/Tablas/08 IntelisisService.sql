-- drop table IntelisisServicelog
/****** IntelisisServiceLog ******/
if not exists (select * from SysTabla where SysTabla = 'IntelisisServiceLog') 
INSERT INTO SysTabla (SysTabla) VALUES ('IntelisisServiceLog')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisServiceLog') and type = 'U') 
  CREATE TABLE dbo.IntelisisServiceLog (
	ID			int		NOT NULL,

	Estatus			varchar(15)	NOT NULL,	
	FechaEstatus		datetime	NULL,

	CONSTRAINT priIntelisisServiceLog PRIMARY KEY  CLUSTERED (ID, Estatus)
  )
GO

-- drop table IntelisisService
/****** IntelisisService ******/
if not exists (select * from SysTabla where SysTabla = 'IntelisisService') 
INSERT INTO SysTabla (SysTabla) VALUES ('IntelisisService')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisService') and type = 'U') 
BEGIN
  CREATE TABLE dbo.IntelisisService (
	ID			int		NOT NULL 	IDENTITY(1,1),

	Sistema			varchar(100)	NULL,	
	Contenido		varchar(100)	NULL,
	Referencia		varchar(100)	NULL,
	SubReferencia		varchar(100)	NULL,
	Version			float		NULL,

	Usuario			varchar(10)	NULL,
	Solicitud		varchar(max)    NULL,
	Resultado		varchar(max)    NULL,
	Estatus			varchar(15)	NULL		DEFAULT 'SINPROCESAR',		-- SINPROCESAR, PROCESADO, ERROR, CONCLUIDO
	FechaEstatus		datetime	NULL		DEFAULT GETDATE(),
	Ok			int		NULL,
	OkRef			varchar(255)	NULL,	
	Conversacion	uniqueidentifier	NULL,
	SincroGUID		uniqueidentifier	NULL,
	SucursalOrigen	int NULL,
	SucursalDestino	int NULL,	
	eDocInArchivo	varchar(255)	NULL,	

	CONSTRAINT priIntelisisService PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'IntelisisService'
END
GO
EXEC spALTER_TABLE 'IntelisisService', 'Usuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'IntelisisService', 'SubReferencia', 'varchar(100) NULL'
EXEC spALTER_TABLE 'IntelisisService', 'Conversacion', 'uniqueidentifier NULL'
EXEC spALTER_TABLE 'IntelisisService', 'SincroGUID', 'uniqueidentifier NULL'
EXEC spALTER_TABLE 'IntelisisService', 'SucursalOrigen', 'int NULL'
EXEC spALTER_TABLE 'IntelisisService', 'SucursalDestino', 'int NULL'
EXEC spALTER_TABLE 'IntelisisService', 'eDocInArchivo ', 'varchar(255) NULL'
GO

EXEC spADD_INDEX 'IntelisisService', 'Estatus', 'Estatus, Sistema'
EXEC spADD_INDEX 'IntelisisService', 'Fecha', 'Estatus, FechaEstatus'
EXEC spADD_INDEX 'IntelisisService', 'Referencia', 'Referencia, SubReferencia, Estatus'
EXEC spADD_INDEX 'IntelisisService', 'Sistema', 'Referencia, Contenido, Sistema, Estatus'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgIntelisisServiceAC') and sysstat & 0xf = 8) drop trigger dbo.tgIntelisisServiceAC
GO
CREATE TRIGGER tgIntelisisServiceAC ON IntelisisService
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @ID			int,
    @EstatusN  		varchar(15),
    @EstatusA  		varchar(15),
    @FechaEstatusN	datetime,
    @FechaEstatusA	datetime

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @EstatusN = Estatus, @FechaEstatusN = FechaEstatus, @ID = ID FROM Inserted
  SELECT @EstatusA = Estatus, @FechaEstatusA = FechaEstatus FROM Deleted

  IF @EstatusN <> @EstatusA
    IF NOT EXISTS(SELECT * FROM IntelisisServiceLog WHERE ID = @ID AND Estatus = @EstatusN)
      INSERT IntelisisServiceLog (ID, Estatus, FechaEstatus) VALUES (@ID, @EstatusN, @FechaEstatusN)
    ELSE
      UPDATE IntelisisServiceLog SET FechaEstatus = @FechaEstatusN WHERE ID = @ID AND Estatus = @EstatusN
END
GO

/****** IntelisisServiceFactory ******/
if not exists (select * from SysTabla where SysTabla = 'IntelisisServiceFactory') 
INSERT INTO SysTabla (SysTabla) VALUES ('IntelisisServiceFactory')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisServiceFactory') and type = 'U') 
BEGIN
  CREATE TABLE dbo.IntelisisServiceFactory (
	ID			int		NOT NULL 	IDENTITY(1,1),
	Sistema			varchar(100)	NULL,	
	Contenido		varchar(100)	NULL,
	Referencia		varchar(100)	NULL,
	SubReferencia		varchar(100)	NULL,
	Version			float		NULL,
	Usuario			varchar(10)	NULL,
	Solicitud		varchar(max)    NULL,	
	Estatus			varchar(15)	NULL		DEFAULT 'SINPROCESAR',	
	FechaEstatus		datetime	NULL		DEFAULT GETDATE(),
	Ok			int		NULL,
	OkRef			varchar(255)	NULL,		
        RID                     int             NULL,	
	CONSTRAINT priIntelisisServiceFactory PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'IntelisisServiceFactory'
END
GO

EXEC spALTER_TABLE 'IntelisisServiceFactory', 'Modulo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'IntelisisServiceFactory', 'ModuloID', 'int NULL'
GO
EXEC spALTER_COLUMN 'IntelisisServiceFactory', 'ModuloID', 'int NULL'