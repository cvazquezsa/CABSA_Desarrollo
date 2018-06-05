/* GENERALES */

/****** Flujo de Movimientos  ******/
if not exists (select * from SysTabla where SysTabla = 'MovFlujo')  
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovFlujo','MovimientoInfo')
if not exists (select * from sysobjects where id = object_id('dbo.MovFlujo') and type = 'U') 
CREATE TABLE dbo.MovFlujo (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			varchar(5)      NOT NULL,
	OModulo			varchar(5)         NOT NULL,
  OID			int		NOT NULL,

	OMov 		        varchar(20) 	NOT NULL,
	OMovID			varchar(20)   	NOT NULL,
	DModulo			char(5)         NOT NULL,
        DID			int		NOT NULL,
	DMov 		        varchar(20) 	NOT NULL,
	DMovID			varchar(20) 	NOT NULL,
	Cancelado		bit		NULL DEFAULT 0,

	CONSTRAINT priMovFlujo PRIMARY KEY  CLUSTERED (OModulo, OID, DModulo, DID, Sucursal, Empresa)
)
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE MovFlujo ALTER COLUMN OMovID varchar(20)
GO
if (select version from version) BETWEEN 1 and 1095
  ALTER TABLE MovFlujo ALTER COLUMN DMovID varchar(20)
GO
IF NOT exists(select * from SysCampo WHERE Tabla = 'MovFlujo' AND Campo = 'Sucursal')
  ALTER TABLE MovFlujo ADD Sucursal int NOT NULL DEFAULT 0 WITH VALUES
GO
if (select version from version) <= 1108
BEGIN
  EXEC spEliminarPK 'MovFlujo'
  ALTER TABLE MovFlujo ADD CONSTRAINT priMovFlujo PRIMARY KEY CLUSTERED (OModulo, OID, DModulo, DID, Sucursal, Empresa)
END
GO
EXEC spALTER_TABLE 'MovFlujo', 'Cancelado', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovFlujo' AND sysindexes.name = 'Destino' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Destino ON dbo.MovFlujo (DID, DModulo, OModulo, OID, Sucursal, Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovFlujo' AND sysindexes.name = 'Cancelado' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cancelado ON dbo.MovFlujo (OID, Cancelado)
GO
/****** PagadoAux ******/
if not exists(select * from SysTabla where SysTabla = 'PagadoAux')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('PagadoAux', 'MovimientoInfo')
if not exists (select * from sysobjects where id = object_id('dbo.PagadoAux') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PagadoAux (
	Modulo			varchar(5)		NOT NULL,
	ModuloID		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Fecha			datetime	NULL,
	Pagado			float		NULL,

	CONSTRAINT priPagadoAux PRIMARY KEY  CLUSTERED (ModuloID, Modulo, ID)
  )
  EXEC spSincroSemilla 'PagadoAux'
END
GO

/****** MovSituacionD ******/
if not exists (select * from SysTabla where SysTabla = 'MovSituacionD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovSituacionD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovSituacionD') and type = 'U') 
CREATE TABLE dbo.MovSituacionD (
	ID			int		NOT NULL,
	Orden			int		NOT NULL,

	Flujo			varchar(50)	NOT NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priMovSituacionD PRIMARY KEY  CLUSTERED (ID, Orden)
)
GO
EXEC spModificarPK_SucursalSinOrigen 'MovSituacionD', '(ID, Orden)'
GO

/****** MovSituacion ******/
if not exists (select * from SysTabla where SysTabla = 'MovSituacion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovSituacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovSituacion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovSituacion (
	ID			int		NOT NULL IDENTITY(1,1),

	Modulo			varchar(5)		NULL,
	Mov			varchar(20)        NULL,
	Tipo			varchar(50)	NULL,
	Estatus			varchar(15)	NULL,
	Orden			int		NULL,
	Situacion		varchar(50)	NULL,
	Flujo           	varchar(20)	NULL,  			-- Todas, Especial, Final
	Cuesta			bit		NOT NULL DEFAULT 0,
	PermiteAfectacion	bit		NOT NULL DEFAULT 0,
	PermiteRetroceder	bit		NOT NULL DEFAULT 0,
	PermiteBrincar		bit		NOT NULL DEFAULT 0,
	ControlUsuarios		bit		NOT NULL DEFAULT 0,
	Icono			int		NULL 	 DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,
	SMS			varchar(20)	NULL 	 DEFAULT 'No',

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Tiempo			float		NULL,

 	CONSTRAINT priMovSituacion PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'MovSituacion'
END
GO
if exists (select * from sysobjects where id = object_id('dbo.tgMovSituacionBC') and sysstat & 0xf = 8) drop trigger dbo.tgMovSituacionBC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgMovSituacionB') and sysstat & 0xf = 8) drop trigger dbo.tgMovSituacionB
GO
EXEC spModificarPK_SucursalSinOrigen 'MovSituacion', '(ID)'
GO
EXEC spALTER_TABLE 'MovSituacion', 'Tiempo', 'float NULL'
EXEC spALTER_TABLE 'MovSituacion', 'SMS', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
GO

-- 11464
EXEC spALTER_TABLE 'MovSituacion', 'Rama', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovSituacion', 'Condicional', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'MovSituacion', 'CondicionUsuario', 'varchar(max) NULL'
EXEC spALTER_TABLE 'MovSituacion', 'SituacionVerdadero', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovSituacion', 'Operador', 'varchar(10) NULL'
EXEC spALTER_TABLE 'MovSituacion', 'EsPadre', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG18022 Se cambio de lugar la creación del campo calculado para que las vistas lo contengan
-- BUG12896
-- Eliminamos el Campo Calculado
EXEC spDROP_COLUMN 'MovSituacion', 'EsAcumulativa'
GO

/**************** fnMovSituacionBinariaTieneHijos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMovSituacionBinariaTieneHijos') DROP FUNCTION fnMovSituacionBinariaTieneHijos
GO
CREATE FUNCTION fnMovSituacionBinariaTieneHijos(
				@Modulo			varchar(5),
				@Mov			varchar(20),
				@Estatus		varchar(15),
				@Situacion		varchar(50),
				@EsPadre		bit
				)
RETURNS bit
AS
BEGIN
  DECLARE @Resultado	bit
  
  IF ISNULL(@EsPadre, 0) = 1
    SELECT @Resultado = 1
  ELSE
  BEGIN
    IF EXISTS(SELECT Situacion FROM MovSituacion WHERE Modulo = @Modulo AND Mov = @Mov AND Estatus = @Estatus AND Rama = @Situacion)
      SELECT @Resultado = 1
    ELSE
      SELECT @Resultado = 0
  END

  RETURN @Resultado
END
GO

-- BUG12896
-- Agregamos el Campo Calculado
EXEC spALTER_TABLE 'MovSituacion', 'EsAcumulativa', 'AS dbo.fnMovSituacionBinariaTieneHijos(Modulo, Mov, Estatus, Situacion, EsPadre)'
GO

-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgMovSituacionB ON MovSituacion
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  DELETE MovSituacionD WHERE ID IN (SELECT ID FROM Deleted)
END
GO

--BUG15737
/*** MovSituacionAF ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionAF') and type = 'V') drop view dbo.MovSituacionAF
GO
CREATE VIEW MovSituacionAF
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'AF'
GO

--BUG15737
/*** MovSituacionAGENT ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionAGENT') and type = 'V') drop view dbo.MovSituacionAGENT
GO
CREATE VIEW MovSituacionAGENT
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'AGENT'
GO

--BUG15737
/*** MovSituacionASIS ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionASIS') and type = 'V') drop view dbo.MovSituacionASIS
GO
CREATE VIEW MovSituacionASIS
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'ASIS'
GO

--BUG15737
/*** MovSituacionCAM ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCAM') and type = 'V') drop view dbo.MovSituacionCAM
GO
CREATE VIEW MovSituacionCAM
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CAM'
GO

--BUG15737
/*** MovSituacionCAP ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCAP') and type = 'V') drop view dbo.MovSituacionCAP
GO
CREATE VIEW MovSituacionCAP
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CAP'
GO

--BUG15737
/*** MovSituacionCAPT ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCAPT') and type = 'V') drop view dbo.MovSituacionCAPT
GO
CREATE VIEW MovSituacionCAPT
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CAPT'
GO

--BUG15737
/*** MovSituacionCMP ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCMP') and type = 'V') drop view dbo.MovSituacionCMP
GO
CREATE VIEW MovSituacionCMP
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CMP'
GO

--BUG15737
/*** MovSituacionCOMS ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCOMS') and type = 'V') drop view dbo.MovSituacionCOMS
GO
CREATE VIEW MovSituacionCOMS
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'COMS'
GO

--BUG15737
/*** MovSituacionCONC ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCONC') and type = 'V') drop view dbo.MovSituacionCONC
GO
CREATE VIEW MovSituacionCONC
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CONC'
GO

--BUG15737
/*** MovSituacionCONT ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCONT') and type = 'V') drop view dbo.MovSituacionCONT
GO
CREATE VIEW MovSituacionCONT
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CONT'
GO

--BUG15737
/*** MovSituacionCORTE ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCORTE') and type = 'V') drop view dbo.MovSituacionCORTE
GO
CREATE VIEW MovSituacionCORTE
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CORTE'
GO

--BUG15737
/*** MovSituacionCP ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCP') and type = 'V') drop view dbo.MovSituacionCP
GO
CREATE VIEW MovSituacionCP
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CP'
GO

--BUG15737
/*** MovSituacionCR ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCR') and type = 'V') drop view dbo.MovSituacionCR
GO
CREATE VIEW MovSituacionCR
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CR'
GO

--BUG15737
/*** MovSituacionCREDI ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCREDI') and type = 'V') drop view dbo.MovSituacionCREDI
GO
CREATE VIEW MovSituacionCREDI
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CREDI'
GO

--BUG15737
/*** MovSituacionCXC ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCXC') and type = 'V') drop view dbo.MovSituacionCXC
GO
CREATE VIEW MovSituacionCXC
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CXC'
GO

--BUG15737
/*** MovSituacionCXP ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCXP') and type = 'V') drop view dbo.MovSituacionCXP
GO
CREATE VIEW MovSituacionCXP
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CXP'
GO

--BUG15737
/*** MovSituacionDIN ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionDIN') and type = 'V') drop view dbo.MovSituacionDIN
GO
CREATE VIEW MovSituacionDIN
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'DIN'
GO

--BUG15737
/*** MovSituacionEMB ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionEMB') and type = 'V') drop view dbo.MovSituacionEMB
GO
CREATE VIEW MovSituacionEMB
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'EMB'
GO

--BUG15737
/*** MovSituacionFIS ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionFIS') and type = 'V') drop view dbo.MovSituacionFIS
GO
CREATE VIEW MovSituacionFIS
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'FIS'
GO

--REQ25014
/*** MovSituacionCONTM ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionCONTM') and type = 'V') drop view dbo.MovSituacionCONTM
GO
CREATE VIEW MovSituacionCONTM
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'CONTP'
GO

--REQ16092
/*** MovSituacionOPORT ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionOPORT') and type = 'V') drop view dbo.MovSituacionOPORT
GO
CREATE VIEW MovSituacionOPORT
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'OPORT'
GO

--BUG15737
/*** MovSituacionFRM ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionFRM') and type = 'V') drop view dbo.MovSituacionFRM
GO
CREATE VIEW MovSituacionFRM
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'FRM'
GO

--BUG15737
/*** MovSituacionGAS ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionGAS') and type = 'V') drop view dbo.MovSituacionGAS
GO
CREATE VIEW MovSituacionGAS
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'GAS'
GO

--BUG15737
/*** MovSituacionGES ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionGES') and type = 'V') drop view dbo.MovSituacionGES
GO
CREATE VIEW MovSituacionGES
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'GES'
GO

--BUG15737
/*** MovSituacionINC ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionINC') and type = 'V') drop view dbo.MovSituacionINC
GO
CREATE VIEW MovSituacionINC
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'INC'
GO

--BUG15737
/*** MovSituacionINV ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionINV') and type = 'V') drop view dbo.MovSituacionINV
GO
CREATE VIEW MovSituacionINV
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'INV'
GO

--BUG15737
/*** MovSituacionISL ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionISL') and type = 'V') drop view dbo.MovSituacionISL
GO
CREATE VIEW MovSituacionISL
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'ISL'
GO

--BUG15737
/*** MovSituacionMEX01 ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionMEX01') and type = 'V') drop view dbo.MovSituacionMEX01
GO
CREATE VIEW MovSituacionMEX01
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'MEX01'
GO

--BUG15737
/*** MovSituacionNOM ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionNOM') and type = 'V') drop view dbo.MovSituacionNOM
GO
CREATE VIEW MovSituacionNOM
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'NOM'
GO

--BUG15737
/*** MovSituacionOFER ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionOFER') and type = 'V') drop view dbo.MovSituacionOFER
GO
CREATE VIEW MovSituacionOFER
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'OFER'
GO

--BUG15737
/*** MovSituacionORG ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionORG') and type = 'V') drop view dbo.MovSituacionORG
GO
CREATE VIEW MovSituacionORG
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'ORG'
GO

--BUG15737
/*** MovSituacionPACTO ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionPACTO') and type = 'V') drop view dbo.MovSituacionPACTO
GO
CREATE VIEW MovSituacionPACTO
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'PACTO'
GO

--BUG15737
/*** MovSituacionPC ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionPC') and type = 'V') drop view dbo.MovSituacionPC
GO
CREATE VIEW MovSituacionPC
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'PC'
GO

--BUG15737
/*** MovSituacionPCP ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionPCP') and type = 'V') drop view dbo.MovSituacionPCP
GO
CREATE VIEW MovSituacionPCP
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'PCP'
GO

--BUG15737
/*** MovSituacionPPTO ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionPPTO') and type = 'V') drop view dbo.MovSituacionPPTO
GO
CREATE VIEW MovSituacionPPTO
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'PPTO'
GO

--BUG15737
/*** MovSituacionPROD ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionPROD') and type = 'V') drop view dbo.MovSituacionPROD
GO
CREATE VIEW MovSituacionPROD
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'PROD'
GO

--BUG15737
/*** MovSituacionPROY ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionPROY') and type = 'V') drop view dbo.MovSituacionPROY
GO
CREATE VIEW MovSituacionPROY
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'PROY'
GO

--BUG15737
/*** MovSituacionRE ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionRE') and type = 'V') drop view dbo.MovSituacionRE
GO
CREATE VIEW MovSituacionRE
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'RE'
GO

--BUG15737
/*** MovSituacionRH ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionRH') and type = 'V') drop view dbo.MovSituacionRH
GO
CREATE VIEW MovSituacionRH
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'RH'
GO

--BUG15737
/*** MovSituacionRSS ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionRSS') and type = 'V') drop view dbo.MovSituacionRSS
GO
CREATE VIEW MovSituacionRSS
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'RSS'
GO

--BUG15737
/*** MovSituacionSAUX ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionSAUX') and type = 'V') drop view dbo.MovSituacionSAUX
GO
CREATE VIEW MovSituacionSAUX
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'SAUX'
GO

--BUG15737
/*** MovSituacionST ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionST') and type = 'V') drop view dbo.MovSituacionST
GO
CREATE VIEW MovSituacionST
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'ST'
GO

--BUG15737
/*** MovSituacionTMA ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionTMA') and type = 'V') drop view dbo.MovSituacionTMA
GO
CREATE VIEW MovSituacionTMA
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'TMA'
GO

--BUG15737
/*** MovSituacionVALE ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionVALE') and type = 'V') drop view dbo.MovSituacionVALE
GO
CREATE VIEW MovSituacionVALE
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'VALE'
GO

--BUG15737
/*** MovSituacionVTAS ***/
if exists (select * from sysobjects where id = object_id('dbo.MovSituacionVTAS') and type = 'V') drop view dbo.MovSituacionVTAS
GO
CREATE VIEW MovSituacionVTAS
AS
  SELECT * FROM MovSituacion WHERE Modulo = 'VTAS'
GO


/****** Mov Situaciones Lista ******/
if not exists (select * from SysTabla where SysTabla = 'MovSituacionL') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovSituacionL','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovSituacionL') and type = 'U') 
CREATE TABLE dbo.MovSituacionL (
	Modulo			varchar(5)		NOT NULL,
	Mov			varchar(20)        NOT NULL,
	Estatus			varchar(15)	NOT NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priMovSituacionL PRIMARY KEY  CLUSTERED (Mov, Modulo, Estatus)
)
GO

-- 11464
EXEC spALTER_TABLE 'MovSituacionL', 'Flujo', 'varchar(20) NOT NULL DEFAULT "Normal" WITH VALUES'
GO

/****** tgMovSituacionLFlujo ******/
if exists (select * from sysobjects where id = object_id('dbo.tgMovSituacionLFlujo') and sysstat & 0xf = 8) drop trigger dbo.tgMovSituacionLFlujo
GO
CREATE TRIGGER tgMovSituacionLFlujo ON MovSituacionL
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS
BEGIN
  DECLARE @Modulo		varchar(5),
		  @Mov			varchar(20),
		  @Estatus		varchar(15),
		  @Situacion	varchar(50),
		  @Flujo		varchar(50)

  IF UPDATE(Flujo)
  BEGIN
    SELECT @Modulo = Modulo, @Mov = Mov, @Estatus = Inserted.Estatus, @Situacion = RTRIM(@Mov) + ' ' + RTRIM(Nombre), @Flujo = Inserted.Flujo FROM Inserted JOIN Estatus ON Inserted.Estatus = Estatus.Estatus
    
    IF NOT EXISTS(SELECT ID FROM MovSituacion WHERE Modulo = @Modulo AND Mov = @Mov AND Estatus = @Estatus AND ISNULL(EsPadre, 0) = 1) AND @Flujo = 'CONDICIONAL'
    BEGIN
      DELETE MovSituacion WHERE Modulo = @Modulo AND Mov = @Mov AND Estatus = @Estatus

      INSERT INTO MovSituacion(
				Modulo,  Mov,  Estatus,  Situacion,  PermiteAfectacion, PermiteRetroceder, PermiteBrincar, ControlUsuarios, Icono, Rama, Condicional, CondicionUsuario, SituacionVerdadero, Operador, EsPadre)
		 SELECT @Modulo, @Mov, @Estatus, @Situacion, 1,                 1,                 1,              0,               0,     NULL, 0,           NULL,             NULL,               'Todas',  1
    END
  END
  
  RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgMovSituacionLBC') and sysstat & 0xf = 8) drop trigger dbo.tgMovSituacionLBC
GO
-- Aqui va el Matenimiento a la tabla
CREATE TRIGGER tgMovSituacionLBC ON MovSituacionL
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ModuloNuevo	varchar(5),
    @ModuloAnterior 	varchar(5),
    @MovNuevo		varchar(20),
    @MovAnterior	varchar(20),
    @EstatusNuevo	varchar(15),
    @EstatusAnterior	varchar(15),
    --BUG18341
    @Flujo				varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  --BUG18341
  SELECT @ModuloNuevo    = Modulo, @MovNuevo    = Mov, @EstatusNuevo    = Estatus, @Flujo = Flujo FROM Inserted
  SELECT @ModuloAnterior = Modulo, @MovAnterior = Mov, @EstatusAnterior = Estatus FROM Deleted

  IF @ModuloNuevo = @ModuloAnterior AND @MovNuevo = @MovAnterior AND @EstatusNuevo = @EstatusAnterior RETURN

  --BUG18341
  IF @Flujo = 'CONDICIONAL' RETURN

  IF @EstatusNuevo IS NULL
  BEGIN
    DELETE MovSituacionD WHERE ID IN (SELECT ID FROM MovSituacion WHERE Modulo = @ModuloAnterior AND Mov = @MovAnterior AND Estatus = @EstatusAnterior)
    DELETE MovSituacion WHERE Modulo = @ModuloAnterior AND Mov = @MovAnterior AND Estatus = @EstatusAnterior
  END ELSE
  BEGIN
    UPDATE MovSituacion 
       SET Modulo  = @ModuloNuevo, 
	   Mov     = @MovNuevo,
           Estatus = @EstatusNuevo
     WHERE Modulo  = @ModuloAnterior 
       AND Mov     = @MovAnterior
       AND Estatus = @EstatusAnterior
  END
END
GO

/****** MovSituacionUsuario ******/
if not exists (select * from SysTabla where SysTabla = 'MovSituacionUsuario') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovSituacionUsuario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovSituacionUsuario') and type = 'U') 
CREATE TABLE dbo.MovSituacionUsuario (
	ID		int		NOT NULL,
	Usuario		varchar(10)	NOT NULL,

	Sucursal	int		NOT NULL DEFAULT 0,
	CONSTRAINT priMovSituacionUsuario PRIMARY KEY  CLUSTERED (ID, Usuario)
)
GO
EXEC spModificarPK_SucursalSinOrigen 'MovSituacionUsuario', '(ID, Usuario)'
GO

-- 11464
/****** MovSituacionBinariaSiguiente ******/
if not exists (select * from SysTabla where SysTabla = 'MovSituacionBinariaSiguiente') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovSituacionBinariaSiguiente','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovSituacionBinariaSiguiente') and type = 'U') 
CREATE TABLE dbo.MovSituacionBinariaSiguiente (
  RID				int			IDENTITY,
  Estacion			int			NOT NULL,
  Modulo			varchar(5)	NOT NULL,
  ID				int			NOT NULL,
  Mov				varchar(20)	NOT NULL,
  Estatus			varchar(15)	NOT NULL,

  Situacion			varchar(50)	NULL,
  SituacionFecha	datetime	NULL,
  SituacionUsuario	varchar(10)	NULL,
  SituacionNota		varchar(100)NULL,
  CONSTRAINT priMovSituacionBinariaSiguiente PRIMARY KEY CLUSTERED(RID)
  )
GO

EXEC spADD_INDEX 'MovSituacionBinariaSiguiente', 'Estacion', 'Estacion'
GO

/****** MovSituacionBinariaCondicion ******/
if not exists (select * from SysTabla where SysTabla = 'MovSituacionBinariaCondicion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovSituacionBinariaCondicion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovSituacionBinariaCondicion') and type = 'U') 
CREATE TABLE dbo.MovSituacionBinariaCondicion (
	ID			int				NOT NULL,
	RID			int				IDENTITY,
	Expresion1	varchar(255)	NULL,
	Expresion2	varchar(255)	NULL,
	Expresion3	varchar(255)	NULL,
	Operador	varchar(20)		NULL
	CONSTRAINT priMovSituacionBinariaCondicion PRIMARY KEY CLUSTERED(RID)
	)
GO

/****** MovSituacionBinariaTagAyuda ******/
if not exists (select * from SysTabla where SysTabla = 'MovSituacionBinariaTagAyuda') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovSituacionBinariaTagAyuda','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovSituacionBinariaTagAyuda') and type = 'U') 
CREATE TABLE dbo.MovSituacionBinariaTagAyuda (
	Tag					varchar(100) NOT NULL,

	Descripcion			varchar(255) NULL,
			
	CONSTRAINT priMovSituacionBinariaTagAyuda PRIMARY KEY  CLUSTERED (Tag)
)
GO

/****** MovCtoGrupo  ******/
if not exists(select * from SysTabla where SysTabla = 'MovCtoGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovCtoGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovCtoGrupo') and type = 'U') 
CREATE TABLE dbo.MovCtoGrupo (
	Grupo			varchar(50)	NOT NULL,

 	CONSTRAINT priMovCtoGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

-- drop table movcto
/****** Contactos del Movimiento ******/
if not exists(select * from SysTabla where SysTabla = 'MovCto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovCto','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovCto','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.MovCto') and type = 'U') 
CREATE TABLE dbo.MovCto (
	Modulo			varchar(5)	NOT NULL,
	ModuloID		int		NOT NULL,
	ID			int 		NOT NULL IDENTITY(1,1),

	Nombre			varchar(100)	NULL,
	ApellidoPaterno		varchar(30)	NULL,
	ApellidoMaterno		varchar(30)	NULL,
	Atencion		varchar(50)	NULL,
	Tratamiento		varchar(20)	NULL,
	Cargo			varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	FechaNacimiento		datetime	NULL,
	Telefonos		varchar(100)	NULL,
	Extencion		varchar(20)	NULL,
	eMail			varchar(100)	NULL,
	Fax 			varchar(50) 	NULL,
	PedirTono		bit           	NULL DEFAULT 0,
	Tipo			varchar(20)	NULL,
	Sexo			varchar(20)	NULL,
	Usuario			varchar(10)	NULL,

	CONSTRAINT priMovCto PRIMARY KEY  CLUSTERED (Modulo, ModuloID, ID)
)
go

-- color
/****** Situaciones Cuentas ******/
if not exists(select * from SysTabla where SysTabla = 'CtaSituacion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaSituacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaSituacion') and type = 'U') 
CREATE TABLE dbo.CtaSituacion (
	Rama		varchar(5)	NOT NULL,
	Situacion	varchar(50)	NOT NULL,

	Icono		int		NULL,
	Color		varchar(50)	NULL,
	
	CampanaMov	varchar(20)	NULL, 
	CampanaMovID	varchar(20)	NULL, 
	
	CONSTRAINT priCtaSituacion PRIMARY KEY  CLUSTERED (Rama, Situacion)
)
GO
EXEC spALTER_TABLE 'CtaSituacion', 'Icono', 'int NULL'
EXEC spALTER_TABLE 'CtaSituacion', 'Color', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CtaSituacion', 'CampanaMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CtaSituacion', 'CampanaMovID', 'varchar(20) NULL'
GO

/****** CtaSituacionProg ******/
if not exists(select * from SysTabla where SysTabla = 'CtaSituacionProg')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaSituacionProg','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CtaSituacionProg') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CtaSituacionProg (
	ID			int		NOT NULL	IDENTITY(1,1),

        TipoCuenta		varchar(20)	NULL,    -- Cliente, Articulo, Almacen, Agente, etc..
	Cuenta	 		varchar(20) 	NULL,
	Fecha			datetime	NULL,
	Situacion		varchar(50)	NULL,
	Estatus			varchar(15)	NULL,	-- PENDIENTE, CONCLUIDO, CANCELADO

	CONSTRAINT priCtaSituacionProg PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CtaSituacionProg'
END
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CtaSituacionProg' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cuenta ON dbo.CtaSituacionProg (Cuenta)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CtaSituacionProg' AND sysindexes.name = 'TipoCuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX TipoCuenta ON dbo.CtaSituacionProg (Estatus, TipoCuenta)
go

/****** MovOpcion ******/
if not exists(select * from SysTabla where SysTabla = 'MovOpcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovOpcion','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.MovOpcion') and type = 'U') 
CREATE TABLE dbo.MovOpcion (

	Modulo			varchar(10) NOT NULL,
	ModuloID		int 		NOT NULL,
	Renglon			float 		NOT NULL,
	RenglonSub		int 		NOT NULL,

	A				varchar(100) 	NULL,
	B				varchar(100) 	NULL,
	C				varchar(100) 	NULL,
	D				varchar(100) 	NULL,
	E				varchar(100) 	NULL,
	F				varchar(100) 	NULL,
	G				varchar(100) 	NULL,
	H				varchar(100) 	NULL,
	I				varchar(100) 	NULL,
	J				varchar(100) 	NULL,
	K				varchar(100) 	NULL,
	L				varchar(100) 	NULL,
	M				varchar(100) 	NULL,
	N				varchar(100) 	NULL,
	O				varchar(100) 	NULL,
	P				varchar(100) 	NULL,
	Q				varchar(100) 	NULL,
	R				varchar(100) 	NULL,
	S				varchar(100) 	NULL,
	T				varchar(100) 	NULL,
	W				varchar(100) 	NULL,
	X				varchar(100) 	NULL,
	Y				varchar(100) 	NULL,
	Z				varchar(100) 	NULL,

	CONSTRAINT priMovOpcion PRIMARY KEY CLUSTERED (Modulo, ModuloID, Renglon, RenglonSub)
)
GO

/****** Movimientos  ******/
if not exists(select * from SysTabla where SysTabla = 'Mov') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Mov','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.Mov') and type = 'U') 
CREATE TABLE dbo.Mov (
	Empresa			varchar(5)	        NOT NULL,
	Modulo			varchar(5)         NOT NULL,
	ID			int		NOT NULL,

	Mov 		        varchar(20) 	NOT NULL ,
	MovID			varchar(20)    	NOT NULL,

	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,
	FechaRegistro		datetime	NOT NULL,  -- Fecha de Registro en el Servidor
	FechaEmision		datetime	NOT NULL,
	Concepto		varchar(50)     NULL,
	Proyecto		varchar(50)	NULL,
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,
	Usuario			varchar(10)	NULL,
	Autorizacion		varchar(10)	NULL,
	Referencia		varchar(50)     NULL,
	DocFuente		int		NULL,
	Observaciones		varchar(255)	NULL,

	Poliza			varchar(20)        NULL,
	PolizaID		varchar(20)	NULL,
	ContID			int		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	Turno			int		NULL,
	Fuera			bit		NOT NULL DEFAULT 0,
	Integradora		bit		NOT NULL DEFAULT 0,

	CONSTRAINT priMov PRIMARY KEY  CLUSTERED (ID, Modulo, Empresa)
)
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Mov' AND sysindexes.name = 'Movimiento' AND sysobjects.id = sysindexes.id)
    DROP INDEX Mov.Movimiento
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Mov' AND sysindexes.name = 'Proyecto' AND sysobjects.id = sysindexes.id)
    DROP INDEX Mov.Proyecto
END
GO
if (select version from version) <= 2812
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Mov' AND sysindexes.name = 'Fuera' AND sysobjects.id = sysindexes.id)
    DROP INDEX Mov.Fuera
END
GO
if (select version from version) <= 1095
  ALTER TABLE Mov ALTER COLUMN MovID varchar(20)
GO
if (select version from version) <= 1095
  ALTER TABLE Mov ALTER COLUMN PolizaID varchar(20)
GO
EXEC spALTER_TABLE 'Mov', 'Turno', 'int NULL'
EXEC spALTER_TABLE 'Mov', 'Fuera', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Mov', 'Integradora', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO
EXEC spModificarPK_SucursalSinOrigen 'Mov', '(ID, Modulo, Empresa)'
GO

EXEC spFK 'Mov','Proyecto','Proy','Proyecto'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Mov' AND sysindexes.name = 'Movimiento' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Movimiento ON dbo.Mov (MovID, Mov, Modulo, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Mov' AND sysindexes.name = 'Proyecto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Proyecto ON dbo.Mov (Proyecto, Empresa, Modulo, Mov, MovID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Mov' AND sysindexes.name = 'EjercicioPeriodo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX EjercicioPeriodo ON dbo.Mov (Ejercicio, Periodo, Empresa, Fuera)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Mov' AND sysindexes.name = 'MovMover' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovMover ON dbo.Mov (Fuera, Empresa, Sucursal, Modulo, Mov, Ejercicio, Periodo)
GO

/****** AfectacionUsuario  ******/
if not exists (select * from SysTabla where SysTabla = 'AfectacionUsuario') 
INSERT INTO SysTabla (SysTabla, SincroActivo) VALUES ('AfectacionUsuario', 0)
if not exists (select * from sysobjects where id = object_id('dbo.AfectacionUsuario') and type = 'U')
  CREATE TABLE AfectacionUsuario(
    SPID				int			NOT NULL,
    Usuario				varchar(10)	NULL,
    CONSTRAINT priAfectacionUsuario PRIMARY KEY CLUSTERED(SPID)
    )
GO

/****** MovTiempo ******/
if not exists (select * from SysTabla where SysTabla = 'MovTiempo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTiempo','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.MovTiempo') and type = 'U') 
CREATE TABLE dbo.MovTiempo (
	Modulo			varchar(5)         NOT NULL,
	ID			int		NOT NULL,
	IDOrden			int		NOT NULL IDENTITY(1,1),

	FechaComenzo		datetime	NULL,
	FechaTermino		datetime	NULL,
	FechaInicio    		datetime	NULL,
	Estatus			varchar(15)	NULL,
	Situacion		varchar(50)	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	Usuario			varchar(10)	NULL,

	CONSTRAINT priMovTiempo PRIMARY KEY CLUSTERED (ID, Modulo, IDOrden)
)
GO
if not exists(select * from syscampo where tabla = 'MovTiempo' and Campo = 'IDOrden')
BEGIN
  EXEC spALTER_TABLE 'MovTiempo', 'IDOrden', 'int NOT NULL IDENTITY(1,1)'
  EXEC spSincroSemilla 'MovTiempo'
END
GO
if (select version from version) <= 1309
BEGIN
  EXEC spEliminarPK 'MovTiempo'
  ALTER TABLE MovTiempo ADD CONSTRAINT priMovTiempo PRIMARY KEY CLUSTERED (ID, Modulo, IDOrden)
END
GO
EXEC spModificarPK_SucursalSinOrigen 'MovTiempo', '(Modulo, ID, IDOrden)'
if not exists(select * from syscampo where tabla = 'MovTiempo' and Campo = 'Usuario')
BEGIN
  EXEC("ALTER TABLE MovTiempo ADD Usuario varchar(10) NULL")
  EXEC("UPDATE MovTiempo SET Usuario=m.Usuario FROM MovTiempo t, Mov m WHERE t.Modulo = m.Modulo AND t.ID = m.ID")
END
GO

/*************************** MoveDoc **************************/
if not exists (select * from SysTabla where SysTabla = 'MoveDoc') --MEJORA2104
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MoveDoc','Movimiento')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.MoveDoc') and type = 'U') 
CREATE TABLE MoveDoc
    (
	Empresa				varchar(5)		NOT NULL,    
	Modulo				varchar(5)		NOT NULL,	
    ID					int				NOT NULL,
	
	eDoc				varchar(max)	NULL,
	
	CONSTRAINT priMoveDoc PRIMARY KEY  CLUSTERED (ID, Modulo, Empresa)
	)
GO

/****** Posición de Movimientos  ******/
if not exists (select * from SysTabla where SysTabla = 'MovPos')  
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovPos','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovPos') and type = 'U') 
CREATE TABLE dbo.MovPos (
    Estacion		int					NOT NULL,
    Modulo			varchar(5)			NOT NULL,    
	Tipo			varchar(10)			NOT NULL,    
	Sucursal		int					NOT NULL DEFAULT -1,
	Empresa			varchar(5)			NOT NULL,
	OModulo			varchar(5)			NOT NULL,
    OID				int					NOT NULL,
	OMov			varchar(20)			NOT NULL,
	OMovID			varchar(20)			NOT NULL,
	OEstatus		varchar(15)			NOT NULL,
	DModulo			varchar(5)			NOT NULL,
    DID				int					NOT NULL,
	DMov			varchar(20)			NOT NULL,
	DMovID			varchar(20)			NOT NULL,
	DEstatus		varchar(15)			NOT NULL,	
	Cancelado		bit					NULL DEFAULT 0,
	Clave			varchar(50)			NULL,
	Rama			varchar(50)			NULL,
	Movimiento		varchar(100)		NULL,
	EsAcumulativa	bit					NULL,

	CONSTRAINT priMovPos PRIMARY KEY  CLUSTERED (Estacion, Modulo, Tipo, OModulo, OID, DModulo, DID, Sucursal, Empresa)
)
GO

/****** Ramas  ******/
if not exists(select * from SysTabla where SysTabla = 'Rama') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Rama','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Rama') and type = 'U') 
CREATE TABLE dbo.Rama (
	Rama		        varchar(5)  	NOT NULL,

	Descripcion		varchar(50)     NULL,

	Mayor			varchar(5)         NULL,	-- permite agrupar a varias Ramas y aplicarles el factor, ejemplo +Existencias-Reservado
	Factor			float		NOT NULL DEFAULT 1.0,   -- 1 o -1 para las sumas de los grupos

	AcreedorDeudor		char(1)		NULL,
	ClasificacionContable	varchar(10)	NULL,
	Modulo			varchar(5) 	NULL,
	ImportesCantidades	char(1)		NULL,

	AcumuladoxPeriodo	bit		NOT NULL DEFAULT 1,
	AcumuladoxEjercicio   	bit		NOT NULL DEFAULT 1,
	AcumulaEnLinea		bit		NOT NULL DEFAULT 1,
	GeneraAuxiliar		bit		NOT NULL DEFAULT 1,
	GeneraSaldo		bit		NOT NULL DEFAULT 1,
	EnActividad		bit		NOT NULL DEFAULT 1,
	Conciliar		bit		NOT NULL DEFAULT 0,
	EsUnidades		bit 		NOT NULL DEFAULT 0,
	EsMonetario		bit		NOT NULL DEFAULT 1,
	EsResultados		bit		NOT NULL DEFAULT 0,
	InfoSaldosSucursales	bit		NULL	 DEFAULT 1,

	CONSTRAINT priRama PRIMARY KEY  CLUSTERED (Rama)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Rama' AND sysindexes.name = 'Mayor' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Mayor ON dbo.Rama (Mayor)
go
if not exists (SELECT * FROM syscampo WHERE Tabla = 'Rama' and Campo = 'InfoSaldosSucursales')
  ALTER TABlE Rama ADD InfoSaldosSucursales bit NULL DEFAULT 1 WITH VALUES
go


/****** PresupuestoTipo ******/
if not exists(select * from SysTabla where SysTabla = 'PresupuestoTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PresupuestoTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PresupuestoTipo') and type = 'U') 
CREATE TABLE dbo.PresupuestoTipo (
	Tipo			varchar(50)     NOT NULL,

	CONSTRAINT priPresupuestoTipo PRIMARY KEY CLUSTERED (Tipo)
)
GO

/****** Presupuestos ******/
if not exists(select * from SysTabla where SysTabla = 'Presupuesto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Presupuesto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Presupuesto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Presupuesto (
        ID			int		NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)      NOT NULL,
	Rama			varchar(5)      NULL,
	Moneda			varchar(10)	NULL,
	Tipo			varchar(50)     NULL,
	Cuenta			varchar(20)     NULL,
	SubCuenta		varchar(50)	NULL,
	SubCuenta2		varchar(50)	NULL,
	SubCuenta3		varchar(50)	NULL,
	Ejercicio		int		NULL,
	Periodo			int		NULL,

	Presupuesto		money		NULL,
	Reservado		money		NULL,
	Comprometido		money		NULL,
	Devengado		money		NULL,
	Ejercido		money		NULL,

	UltimoCambio		datetime	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	UEN			int		NULL,

	CONSTRAINT priPresupuesto PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Presupuesto'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'Presupuesto', '(ID)'
GO
if (select version from version)<=2794
BEGIN
  EXEC ("spDROP_COLUMN 'Presupuesto', 'AcumuladoDeudor'")
  EXEC ("spDROP_COLUMN 'Presupuesto', 'AcumuladoAcreedor'")
END
GO
EXEC spALTER_TABLE 'Presupuesto', 'Reservado', 'money NULL'
EXEC spALTER_TABLE 'Presupuesto', 'Comprometido', 'money NULL'
EXEC spALTER_TABLE 'Presupuesto', 'Devengado', 'money NULL'
EXEC spALTER_TABLE 'Presupuesto', 'Ejercido', 'money NULL'
EXEC spALTER_TABLE 'Presupuesto', 'UEN', 'int NULL'
EXEC spALTER_COLUMN 'Presupuesto', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Presupuesto', 'SubCuenta2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Presupuesto', 'SubCuenta3', 'varchar(50) NULL'
GO

if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Presupuesto' AND sysindexes.name = 'Principal' AND sysobjects.id = sysindexes.id)
DROP INDEX Presupuesto.Principal 
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Presupuesto' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
CREATE INDEX Cuenta ON dbo.Presupuesto (Cuenta, SubCuenta, Ejercicio, Periodo, UEN, Sucursal, Empresa, Rama)
GO
-- Aqui va el Matenimiento a la tabla

if exists (select * from sysobjects where id = object_id('dbo.tgPresupuestoABC') and sysstat & 0xf = 8) 
drop trigger dbo.tgPresupuestoABC
go
CREATE TRIGGER tgPresupuestoABC ON Presupuesto
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE 
    @SucursalPrincipal	int,
    @Empresa   		varchar(5),
    @Rama	        varchar(5),
    @Tipo      		varchar(50),
    @Cuenta    		varchar(20),
    @CtaRama 		varchar(20),
    @Moneda		varchar(10),
    @SubCuenta 		varchar(50),
    @SubCuenta2		varchar(50),
    @SubCuenta3		varchar(50),
    @UEN		int,
    @Presupuesto	money,
    @Reservado		money,
    @Comprometido	money,
    @Devengado		money,
    @Ejercido		money,

    @Ejercicio 		int,
    @Periodo   		int,
    @Ok			int,
    @OkRef		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF (SELECT Sincronizando FROM Version) = 1 RETURN
  SELECT @SucursalPrincipal = Sucursal FROM Version
  -- Deleted
  SELECT @Rama = NULL, @SubCuenta = NULL, @UEN = NULL
  SELECT @Empresa      = NULLIF(RTRIM(Empresa), ''),
         @Rama         = NULLIF(RTRIM(Rama), ''),
         @Tipo         = NULLIF(RTRIM(Tipo), ''),
         @Cuenta       = NULLIF(RTRIM(Cuenta), ''),
  	 @SubCuenta    = NULLIF(RTRIM(SubCuenta), ''),
  	 @SubCuenta2   = NULLIF(RTRIM(SubCuenta2), ''),
  	 @SubCuenta3   = NULLIF(RTRIM(SubCuenta3), ''),
         @UEN	       = NULLIF(UEN, 0),
         @Moneda       = Moneda,
	 @Ejercicio    = Ejercicio,
	 @Periodo      = Periodo,
         @Presupuesto  = -Presupuesto,
         @Reservado    = -Reservado,
         @Comprometido = -Comprometido,
         @Devengado    = -Devengado,
         @Ejercido     = -Ejercido
    FROM Deleted
   WHERE Presupuesto IS NOT NULL

  IF @Rama = 'CONT'
  BEGIN
    SELECT @CtaRama = NULLIF(RTRIM(Rama), '') FROM Cta WHERE Cuenta = @Cuenta 
    WHILE @CtaRama IS NOT NULL AND @@Error = 0
    BEGIN
      EXEC spPresupuesto @SucursalPrincipal, @Empresa, @Moneda, @Rama, @Tipo, @CtaRama, @SubCuenta, @SubCuenta2, @SubCuenta3, @UEN, @Presupuesto, @Reservado, @Comprometido, @Devengado, @Ejercido, @Ejercicio, @Periodo, 'AFECTAR', @Ok OUTPUT, @OkRef OUTPUT
      SELECT @CtaRama = NULLIF(RTRIM(Rama), '') FROM Cta WHERE Cuenta = @CtaRama
    END
  END ELSE
  IF @Rama = 'CC'
  BEGIN
    SELECT @CtaRama = NULLIF(RTRIM(Rama), '') FROM CentroCostos WHERE CentroCostos = @Cuenta 
    WHILE @CtaRama IS NOT NULL AND @@Error = 0
    BEGIN
      EXEC spPresupuesto @SucursalPrincipal, @Empresa, @Moneda, @Rama, @Tipo, @CtaRama, @SubCuenta, @SubCuenta2, @SubCuenta3, @UEN, @Presupuesto, @Reservado, @Comprometido, @Devengado, @Ejercido, @Ejercicio, @Periodo, 'AFECTAR', @Ok OUTPUT, @OkRef OUTPUT
      SELECT @CtaRama = NULLIF(RTRIM(Rama), '') FROM CentroCostos WHERE CentroCostos = @CtaRama
    END
  END

  -- Inserted
  SELECT @Rama = NULL, @SubCuenta = NULL, @UEN = NULL
  SELECT @Empresa      = NULLIF(RTRIM(Empresa), ''),
         @Rama         = NULLIF(RTRIM(Rama), ''),
         @Tipo         = NULLIF(RTRIM(Tipo), ''),
         @Cuenta       = NULLIF(RTRIM(Cuenta), ''),
  	 @SubCuenta    = NULLIF(RTRIM(SubCuenta), ''),
  	 @SubCuenta2   = NULLIF(RTRIM(SubCuenta2), ''),
  	 @SubCuenta3   = NULLIF(RTRIM(SubCuenta3), ''),
         @UEN	       = NULLIF(UEN, 0),
         @Moneda       = Moneda,
	 @Ejercicio    = Ejercicio,
	 @Periodo      = Periodo,
         @Presupuesto  = Presupuesto,
         @Reservado    = Reservado,
         @Comprometido = Comprometido,
         @Devengado    = Devengado,
         @Ejercido     = Ejercido
    FROM Inserted
   WHERE Presupuesto IS NOT NULL

  IF @Rama = 'CONT'
  BEGIN
    SELECT @CtaRama = NULLIF(RTRIM(Rama), '') FROM Cta WHERE Cuenta = @Cuenta 
    WHILE @CtaRama IS NOT NULL AND @@Error = 0
    BEGIN
      EXEC spPresupuesto @SucursalPrincipal, @Empresa, @Moneda, @Rama, @Tipo, @CtaRama, @SubCuenta, @SubCuenta2, @SubCuenta3, @UEN, @Presupuesto, @Reservado, @Comprometido, @Devengado, @Ejercido, @Ejercicio, @Periodo, 'AFECTAR', @Ok OUTPUT, @OkRef OUTPUT
      SELECT @CtaRama = NULLIF(RTRIM(Rama), '') FROM Cta WHERE Cuenta = @CtaRama
    END
  END ELSE
  IF @Rama = 'CC'
  BEGIN
    SELECT @CtaRama = NULLIF(RTRIM(Rama), '') FROM CentroCostos WHERE CentroCostos = @Cuenta 
    WHILE @CtaRama IS NOT NULL AND @@Error = 0
    BEGIN
      EXEC spPresupuesto @SucursalPrincipal, @Empresa, @Moneda, @Rama, @Tipo, @CtaRama, @SubCuenta, @SubCuenta2, @SubCuenta3, @UEN, @Presupuesto, @Reservado, @Comprometido, @Devengado, @Ejercido, @Ejercicio, @Periodo, 'AFECTAR', @Ok OUTPUT, @OkRef OUTPUT
      SELECT @CtaRama = NULLIF(RTRIM(Rama), '') FROM CentroCostos WHERE CentroCostos = @CtaRama
    END
  END
END
GO

/****** TablaAnualD ******/
if not exists(select * from SysTabla where SysTabla = 'TablaAnualD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaAnualD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaAnualD') and type = 'U') 
CREATE TABLE dbo.TablaAnualD (
        TablaAnual		varchar(50)	NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,
	Importe			float		NULL,

	CONSTRAINT priTablaAnualD PRIMARY KEY CLUSTERED (TablaAnual, Ejercicio, Periodo)
)
go

/****** TablaAnual ******/
if not exists(select * from SysTabla where SysTabla = 'TablaAnual')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaAnual','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaAnual') and type = 'U') 
CREATE TABLE dbo.TablaAnual (
        TablaAnual		varchar(50)	NOT NULL,
	CONSTRAINT priTablaAnual PRIMARY KEY CLUSTERED (TablaAnual)
)
go

if exists (select * from sysobjects where id = object_id('dbo.tgTablaAnualBC') and sysstat & 0xf = 8) drop trigger dbo.tgTablaAnualBC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgTablaAnualBC ON TablaAnual
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = TablaAnual FROM Inserted
  SELECT @ClaveAnterior = TablaAnual FROM Deleted

  IF @ClaveNueva = @ClaveAnterior RETURN

  IF @ClaveNueva IS NULL
    DELETE TablaAnualD WHERE TablaAnual = @ClaveAnterior
  ELSE
    UPDATE TablaAnualD SET TablaAnual = @ClaveNueva WHERE TablaAnual = @ClaveAnterior
END
GO

/****** TablaStD ******/
if not exists(select * from SysTabla where SysTabla = 'TablaStD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaStD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaStD') and type = 'U') 
CREATE TABLE dbo.TablaStD (
        TablaSt			varchar(50)	NOT NULL,
	Nombre			varchar(50)	NOT NULL,
	Valor			varchar(50)	NULL,

	CONSTRAINT priTablaStD PRIMARY KEY CLUSTERED (TablaSt, Nombre)
)
go

/****** TablaSt ******/
if not exists(select * from SysTabla where SysTabla = 'TablaSt')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaSt','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaSt') and type = 'U') 
CREATE TABLE dbo.TablaSt (
        TablaSt		varchar(50)	NOT NULL,
	CONSTRAINT priTablaSt PRIMARY KEY CLUSTERED (TablaSt)
)
go
if exists (select * from sysobjects where id = object_id('dbo.tgTablaStBC') and sysstat & 0xf = 8) drop trigger dbo.tgTablaStBC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgTablaStBC ON TablaSt
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = TablaSt FROM Inserted
  SELECT @ClaveAnterior = TablaSt FROM Deleted
  IF @ClaveNueva = @ClaveAnterior RETURN

  IF @ClaveNueva IS NULL
    DELETE TablaStD WHERE TablaSt = @ClaveAnterior
  ELSE
    UPDATE TablaStD SET TablaSt = @ClaveNueva WHERE TablaSt = @ClaveAnterior 
END
GO


/****** CatalogoGrupo  ******/
if not exists(select * from SysTabla where SysTabla = 'CatalogoGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CatalogoGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CatalogoGrupo') and type = 'U') 
CREATE TABLE dbo.CatalogoGrupo (
	Grupo			varchar(50)	NOT NULL,

	CONSTRAINT priCatalogoGrupo PRIMARY KEY CLUSTERED (Grupo)
)

/****** Catalogos  ******/
if not exists(select * from SysTabla where SysTabla = 'Catalogo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Catalogo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Catalogo') and type = 'U') 
CREATE TABLE dbo.Catalogo (
	Grupo			varchar(50)	NOT NULL,
	Catalogo		varchar(50)	NOT NULL,

	Columnas		int		NULL,
	Renglones		int		NULL,
	TituloVertical		bit		NOT NULL	DEFAULT 0,
	TituloHorizontal	bit		NOT NULL	DEFAULT 0,
	Icono			int		NULL,

	CONSTRAINT priCatalogo PRIMARY KEY CLUSTERED (Grupo, Catalogo)
)

/****** Catalogos Detalle  ******/
if not exists(select * from SysTabla where SysTabla = 'CatalogoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CatalogoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CatalogoD') and type = 'U') 
CREATE TABLE dbo.CatalogoD (
	Grupo			varchar(50)	NOT NULL,
	Catalogo		varchar(50)	NOT NULL,
	Celda			varchar(6)	NOT NULL,

	Tipo			int		NULL,
	Dato			varchar(50)	NULL,

	CONSTRAINT priCatalogoD PRIMARY KEY CLUSTERED (Grupo, Catalogo, Celda)
)

/****** Bloqueos  ******/
if not exists(select * from SysTabla where SysTabla = 'Bloqueo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Bloqueo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Bloqueo') and type = 'U') 
CREATE TABLE dbo.Bloqueo (
	Bloqueo			varchar(15)	NOT NULL,
	Descripcion		varchar(50)	NULL,
	Estatus			varchar(15)	NULL,

	CONSTRAINT priBloqueo PRIMARY KEY CLUSTERED (Bloqueo)
)
GO


/****** Categorias de Propiedades   ******/
if not exists(select * from SysTabla where SysTabla = 'PropCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PropCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PropCat') and type = 'U') 
CREATE TABLE dbo.PropCat (
	Categoria		varchar(50) NOT NULL,

	CONSTRAINT priPropCat PRIMARY KEY CLUSTERED (Categoria)
)

/****** Tipos de Propiedades   ******/
if not exists(select * from SysTabla where SysTabla = 'PropTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PropTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PropTipo') and type = 'U') 
CREATE TABLE dbo.PropTipo (
	Tipo			varchar(50) NOT NULL,
	Categoria		varchar(50) NOT NULL,

	CONSTRAINT priPropTipo PRIMARY KEY CLUSTERED (Tipo, Categoria)
)
GO

/****** Propiedades ******/
if not exists(select * from SysTabla where SysTabla = 'Prop')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Prop','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Prop') and type = 'U') 
CREATE TABLE dbo.Prop (
	Rama			varchar(5)		NOT NULL,
	Cuenta			varchar(20) 	NOT NULL,
	Tipo			varchar(50) 	NOT NULL,
	Propiedad		varchar(100)	NULL,
	Fecha			datetime	NULL,

	CONSTRAINT priProp PRIMARY KEY CLUSTERED (Cuenta, Rama, Tipo)
)
GO
EXEC spALTER_TABLE 'Prop', 'Fecha', 'datetime NULL'
GO

/****** Notas de Cuentas ******/
if not exists(select * from SysTabla where SysTabla = 'NotaCta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotaCta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotaCta') and type = 'U') 
CREATE TABLE dbo.NotaCta (
	Rama			varchar(5)		NOT NULL,
	Cuenta			varchar(20) 	NOT NULL,

	Comentarios		text		NULL,

	CONSTRAINT priNotaCta PRIMARY KEY CLUSTERED (Rama, Cuenta)
)
GO

/****** Documentacion Cuentas ******/
if not exists(select * from SysTabla where SysTabla = 'DocCta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DocCta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DocCta') and type = 'U') 
CREATE TABLE dbo.DocCta (
	Rama		varchar(5)		NOT NULL,
	Cuenta		varchar(20) 	NOT NULL,
	Documento	varchar(50) 	NOT NULL,

	CONSTRAINT priDocCta PRIMARY KEY CLUSTERED (Rama, Cuenta, Documento)
)
GO

/****** Documentacion Ramas ******/
if not exists(select * from SysTabla where SysTabla = 'DocRama')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DocRama','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DocRama') and type = 'U') 
CREATE TABLE dbo.DocRama (
	Rama		varchar(5)		NOT NULL,
	Documento	varchar(50) 	NOT NULL,
	Grupo		varchar(50)	NULL,

	Orden		int		NULL,
	Requerido	bit		NULL	DEFAULT 0,

	CONSTRAINT priDocRama PRIMARY KEY CLUSTERED (Rama, Documento)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgDocRamaC') and sysstat & 0xf = 8) drop trigger dbo.tgDocRamaC
GO
EXEC spALTER_TABLE 'DocRama', 'Grupo', 'varchar(50) NULL'
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgDocRamaC ON DocRama
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @DocN	varchar(50),
    @DocA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @DocN = Documento FROM Inserted
  SELECT @DocA = Documento FROM Deleted

  IF @DocN <> @DocA
    UPDATE DocCta SET Documento = @DocN WHERE Documento = @DocA
END
GO

/****** Notas de Movimientos ******/
if not exists(select * from SysTabla where SysTabla = 'NotaMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotaMov','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.NotaMov') and type = 'U') 
CREATE TABLE dbo.NotaMov (
	Rama			varchar(5)		NOT NULL,
	ID			int		NOT NULL,

	Comentarios		text		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priNotaMov PRIMARY KEY CLUSTERED (Rama, ID)
)
GO
EXEC spModificarPK_SucursalsinOrigen 'NotaMov', '(Rama, ID)'
GO


/****** Tipos de Referencias ******/
if not exists(select * from SysTabla where SysTabla = 'RefTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RefTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RefTipo') and type = 'U') 
CREATE TABLE dbo.RefTipo (
	Tipo		        varchar(20) 	NOT NULL,

	CONSTRAINT priRefTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

/****** RefCta ******/
if not exists(select * from SysTabla where SysTabla = 'RefCta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RefCta','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.RefCta') and type = 'U') 
BEGIN
  CREATE TABLE dbo.RefCta (
	Rama			varchar(5)		NOT NULL,
	Cuenta			varchar(20) 	NOT NULL,
        ID			int		NOT NULL IDENTITY(1,1),

        Referencia              varchar(50)     NULL,
        Tipo                    varchar(20)     NULL,        -- RefTipo
        Fecha                   datetime        NULL,
        Estado                  varchar(30)     NULL,
	Nombre			varchar(100)	NULL,
	Telefonos		varchar(50)     NULL,
	Observaciones		varchar(100)	NULL,

	CONSTRAINT priRefCta PRIMARY KEY  CLUSTERED (Rama, Cuenta, ID)
  )
  EXEC spSincroSemilla 'RefCta'
END
go

/****** PlantillaOffice ******/
if not exists(select * from SysTabla where SysTabla = 'PlantillaOffice')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PlantillaOffice','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PlantillaOffice') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PlantillaOffice (
	ID			int		NOT NULL	IDENTITY(1,1),

	Forma			varchar(50)	NULL,
	Modulo			varchar(5)		NULL,
	Mov			varchar(20)	NULL,
	Nombre			varchar(50)	NULL,
	Tipo			varchar(20)	NULL,		-- Word / Excel
	Archivo			varchar(255)	NULL,
	Icono			int		NULL,

	CONSTRAINT priPlantillaOffice PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'PlantillaOffice'
END
go
EXEC spALTER_TABLE 'PlantillaOffice', 'Icono', 'int NULL'
EXEC spALTER_TABLE 'PlantillaOffice', 'Modulo', 'varchar(5) NULL'
EXEC spALTER_TABLE 'PlantillaOffice', 'Mov', 'varchar(20) NULL'
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PlantillaOffice' AND sysindexes.name = 'Forma' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Forma ON dbo.PlantillaOffice (Forma)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PlantillaOffice' AND sysindexes.name = 'Mov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Mov ON dbo.PlantillaOffice (Mov, Modulo)
GO

/****** PlantillaOfficeD ******/
if not exists(select * from SysTabla where SysTabla = 'PlantillaOfficeD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PlantillaOfficeD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PlantillaOfficeD') and type = 'U') 
  CREATE TABLE dbo.PlantillaOfficeD (
	ID			int		NOT NULL,
	Renglon			float		NOT NULL,

	Referencia		varchar(50)	NULL,
	Expresion		varchar(255)	NULL,

	CONSTRAINT priPlantillaOfficeD PRIMARY KEY  CLUSTERED (ID, Renglon)
  )
go

/****** AnexoCat ******/
if not exists(select * from SysTabla where SysTabla = 'AnexoCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnexoCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AnexoCat') and type = 'U') 
CREATE TABLE dbo.AnexoCat (
	Categoria	varchar(50) 	NOT NULL,

	CONSTRAINT priAnexoCat PRIMARY KEY  CLUSTERED (Categoria)
)
GO

/****** AnexoGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'AnexoGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnexoGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AnexoGrupo') and type = 'U') 
CREATE TABLE dbo.AnexoGrupo (
	Grupo		varchar(50) 	NOT NULL,

	CONSTRAINT priAnexoGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

/****** AnexoFam ******/
if not exists(select * from SysTabla where SysTabla = 'AnexoFam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnexoFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AnexoFam') and type = 'U') 
CREATE TABLE dbo.AnexoFam (
	Familia		varchar(50) 	NOT NULL,

	CONSTRAINT priAnexoFam PRIMARY KEY  CLUSTERED (Familia)
)
GO

/****** AnexoDocTipo ******/
if not exists(select * from SysTabla where SysTabla = 'AnexoDocTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnexoDocTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AnexoDocTipo') and type = 'U') 
CREATE TABLE dbo.AnexoDocTipo (
	Tipo	varchar(50) 	NOT NULL,

	CONSTRAINT priAnexoDocTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

/****** Situaciones Cuentas ******/
if not exists(select * from SysTabla where SysTabla = 'SituacionCta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SituacionCta','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.SituacionCta') and type = 'U') 
  CREATE TABLE dbo.SituacionCta (
	Rama			varchar(5)	NOT NULL,
	Cuenta			varchar(20) 	NOT NULL,
	Area			varchar(50)	NOT NULL,

	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	CONSTRAINT priSituacionCta PRIMARY KEY CLUSTERED (Cuenta, Rama, Area)
)
GO

/****** Anexos Cuentas ******/
if not exists(select * from SysTabla where SysTabla = 'AnexoCta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnexoCta','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.AnexoCta') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AnexoCta (
	Rama			varchar(5)		NOT NULL,
	Cuenta			varchar(20) 	NOT NULL,
        IDR			int		NOT NULL IDENTITY(1,1),

	Nombre			varchar(255)	NULL,
	Direccion		varchar(255)	NULL,
	Icono			int		NULL,
	Tipo			varchar(10)	NULL,  -- Comentario, Imagen, Archivo, Internet
	Orden			int		NULL,
	Comentario		text		NULL,
	Origen			varchar(255)	NULL,
	Destino			varchar(255)	NULL,
	Fecha			varchar(255)	NULL,
	FechaEmision		datetime	NULL,
	Vencimiento		datetime	NULL,

	TipoDocumento		varchar(50)	NULL,
	Inicio			datetime	NULL,
	Alta			datetime	NULL,
	UltimoCambio		datetime	NULL,
	Usuario			varchar(10)	NULL,
        NivelAcceso		varchar(50)	NULL,
	Categoria		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Familia			varchar(50)	NULL,
		Documento		varchar(50) NULL,

	CONSTRAINT priAnexoCta PRIMARY KEY CLUSTERED (Cuenta, Rama, IDR)
  )
  EXEC spSincroSemilla 'AnexoCta'
END
GO
IF (SELECT Version FROM Version) <= 1202
  UPDATE AnexoCta
     SET Direccion = RTRIM(SUBSTRING(Direccion, CHARINDEX('Anexos\', Direccion), 255))  
   WHERE Direccion LIKE '%Anexos\%' AND Tipo = 'Archivo'
GO
if (select version from version)<=2411
begin
  EXEC ("spEliminarPK 'AnexoCta'")
  EXEC ("spALTER_TABLE 'AnexoCta', 'IDR', 'int NOT NULL IDENTITY(1,1)'")
  EXEC ("ALTER TABLE AnexoCta ALTER COLUMN Nombre varchar(255) NULL")
  EXEC ("ALTER TABLE AnexoCta ALTER COLUMN Direccion varchar(255) NULL")
  EXEC ("ALTER TABLE AnexoCta ADD CONSTRAINT priAnexoCta PRIMARY KEY CLUSTERED (Rama, Cuenta, IDR)")
  EXEC ("spSincroSemilla 'AnexoCta'")
end
GO
EXEC spALTER_TABLE 'AnexoCta', 'Origen', 'varchar(255) NULL'
EXEC spALTER_TABLE 'AnexoCta', 'Destino', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'AnexoCta', 'Fecha', 'varchar(255) NULL'
EXEC spALTER_TABLE 'AnexoCta', 'FechaEmision','datetime	NULL'
EXEC spALTER_TABLE 'AnexoCta', 'Vencimiento','datetime NULL'
EXEC spALTER_TABLE 'AnexoCta', 'TipoDocumento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoCta', 'Inicio', 'datetime NULL'
EXEC spALTER_TABLE 'AnexoCta', 'Alta', 'datetime NULL'
EXEC spALTER_TABLE 'AnexoCta', 'UltimoCambio', 'datetime NULL'
EXEC spALTER_TABLE 'AnexoCta', 'Usuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'AnexoCta', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoCta', 'Categoria', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoCta', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoCta', 'Familia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoCta', 'Documento', 'varchar(50) NULL'
GO


/****** Anexos Cuentas 50 ******/
if not exists(select * from SysTabla where SysTabla = 'AnexoCta50')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnexoCta50','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.AnexoCta50') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AnexoCta50 (
	Rama			varchar(5)		NOT NULL,
	Cuenta			varchar(50) 	NOT NULL,
        IDR			int		NOT NULL IDENTITY(1,1),

	Nombre			varchar(255)	NULL,
	Direccion		varchar(255)	NULL,
	Icono			int		NULL,
	Tipo			varchar(10)	NULL,  -- Comentario, Imagen, Archivo, Internet
	Orden			int		NULL,
	Comentario		text		NULL,
	Origen			varchar(255)	NULL,
	Destino			varchar(255)	NULL,
	Fecha			varchar(255)	NULL,
	FechaEmision		datetime	NULL,
	Vencimiento		datetime	NULL,

	TipoDocumento		varchar(50)	NULL,
	Inicio			datetime	NULL,
	Alta			datetime	NULL,
	UltimoCambio		datetime	NULL,
	Usuario			varchar(10)	NULL,
        NivelAcceso		varchar(50)	NULL,
	Categoria		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Familia			varchar(50)	NULL,
	Direccion2		varchar(255)	NULL,
	Direccion3		varchar(255)	NULL,

	CONSTRAINT priAnexoCta50 PRIMARY KEY CLUSTERED (Cuenta, Rama, IDR)
  )
  EXEC spSincroSemilla 'AnexoCta50'
END
GO

/****** Anexos Cuentas nivel Opción******/
if not exists(select * from SysTabla where SysTabla = 'AnexoCtaSub')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnexoCtaSub','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.AnexoCtaSub') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AnexoCtaSub (
	Rama			varchar(5)		NOT NULL,
	Cuenta			varchar(20) 	NOT NULL,
	SubCuenta		varchar(50) 	NOT NULL,
    IDR				int				NOT NULL IDENTITY(1,1),

	Nombre			varchar(255)	NULL,
	Direccion		varchar(255)	NULL,
	Icono			int				NULL,
	Tipo			varchar(10)		NULL,  -- Comentario, Imagen, Archivo, Internet
	Orden			int				NULL,
	Comentario		text			NULL,
	Origen			varchar(255)	NULL,
	Destino			varchar(255)	NULL,
	Fecha			varchar(255)	NULL,
	FechaEmision	datetime		NULL,
	Vencimiento		datetime		NULL,

	TipoDocumento	varchar(50)		NULL,
	Inicio			datetime		NULL,
	Alta			datetime		NULL,
	UltimoCambio	datetime		NULL,
	Usuario			varchar(10)		NULL,
    NivelAcceso		varchar(50)		NULL,
	Categoria		varchar(50)		NULL,
	Grupo			varchar(50)		NULL,
	Familia			varchar(50)		NULL,

	CONSTRAINT priAnexoCtaSub PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, Rama, IDR)
  )
  EXEC spSincroSemilla 'AnexoCtaSub'
END
GO

/****** Anexos Movimientos ******/
if not exists(select * from SysTabla where SysTabla = 'AnexoMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnexoMov','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AnexoMov') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AnexoMov (
	Rama			varchar(5)	NOT NULL,
	ID			int 		NOT NULL,
        IDR			int		NOT NULL IDENTITY(1,1),

	Nombre			varchar(255)	NOT NULL,
	Direccion		varchar(255)	NULL,
	Icono			int		NULL,
	Tipo			varchar(10)	NULL,  -- Comentario, Imagen, Archivo, Internet
	Orden			int		NULL,
	Comentario		text		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	Origen			varchar(255)	NULL,
	Destino			varchar(255)	NULL,
	Fecha			varchar(255)	NULL,
	FechaEmision		datetime	NULL,
	Vencimiento		datetime	NULL,

	TipoDocumento		varchar(50)	NULL,
	Inicio			datetime	NULL,
	Alta			datetime	NULL,
	UltimoCambio		datetime	NULL,
	Usuario			varchar(10)	NULL,
        NivelAcceso		varchar(50)	NULL,
	Categoria		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Familia			varchar(50)	NULL,
	CFD				bit			NOT NULL Default 0,

	CONSTRAINT priAnexoMov PRIMARY KEY CLUSTERED (ID, Rama, IDR)
  )
  EXEC spSincroSemilla 'AnexoMov'
END
GO
IF (SELECT Version FROM Version) <= 1202
  UPDATE AnexoMov
     SET Direccion = RTRIM(SUBSTRING(Direccion, CHARINDEX('Anexos\', Direccion), 255))  
   WHERE Direccion LIKE '%Anexos\%' AND Tipo = 'Archivo'
GO
if (select version from version)<=2411
begin
  EXEC ("spEliminarPK 'AnexoMov'")
  EXEC ("spALTER_TABLE 'AnexoMov', 'IDR', 'int NOT NULL IDENTITY(1,1)'")
  EXEC ("ALTER TABLE AnexoMov ALTER COLUMN Nombre varchar(255) NULL")
  EXEC ("ALTER TABLE AnexoMov ALTER COLUMN Direccion varchar(255) NULL")
  EXEC ("ALTER TABLE AnexoMov ADD CONSTRAINT priAnexoMov PRIMARY KEY CLUSTERED (Rama, ID, IDR)")
  EXEC ("spSincroSemilla 'AnexoMov'")
end
GO
EXEC spModificarPK_SucursalSinOrigen 'AnexoMov', '(Rama, ID, IDR)'
GO
EXEC spALTER_TABLE 'AnexoMov', 'Origen', 'varchar(255) NULL'
EXEC spALTER_TABLE 'AnexoMov', 'Destino', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'AnexoMov', 'Fecha', 'varchar(255) NULL'
EXEC spALTER_TABLE 'AnexoMov', 'FechaEmision','datetime	NULL'
EXEC spALTER_TABLE 'AnexoMov', 'Vencimiento','datetime NULL'
EXEC spALTER_TABLE 'AnexoMov', 'TipoDocumento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoMov', 'Inicio', 'datetime NULL'
EXEC spALTER_TABLE 'AnexoMov', 'Alta', 'datetime NULL'
EXEC spALTER_TABLE 'AnexoMov', 'UltimoCambio', 'datetime NULL'
EXEC spALTER_TABLE 'AnexoMov', 'Usuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'AnexoMov', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoMov', 'Categoria', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoMov', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoMov', 'Familia', 'varchar(50) NULL'
EXEC spAlter_Table 'AnexoMov', 'CFD', 'bit NOT NULL Default 0'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AnexoMov' AND sysindexes.name = 'IDRama' AND sysobjects.id = sysindexes.id)--Bug 21604
   CREATE INDEX IDRama ON AnexoMov (ID,Rama)INCLUDE(Nombre,FechaEmision)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AnexoMov' AND sysindexes.name = 'IDRamaOrden' AND sysobjects.id = sysindexes.id)--Bug 21604
   CREATE INDEX IDRamaOrden ON AnexoMov(ID,Rama,Orden)INCLUDE(IDR,Nombre,Direccion,Icono,Tipo,Sucursal,Origen,Destino,Fecha,FechaEmision,Vencimiento,TipoDocumento,Inicio,Alta,UltimoCambio,Usuario,NivelAcceso,Categoria,Grupo,Familia)
GO
/****** Anexos Movimientos (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'AnexoMovD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnexoMovD','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AnexoMovD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AnexoMovD (
	Rama			varchar(5)		NOT NULL,
	ID			int 		NOT NULL,
	Cuenta			varchar(20) 	NOT NULL,
        IDR			int		NOT NULL IDENTITY(1,1),

	Nombre			varchar(255)	NULL,
	Direccion		varchar(255)	NULL,
	Icono			int		NULL,
	Tipo			varchar(10)	NULL,  -- Comentario, Imagen, Archivo, Internet
	Orden			int		NULL,
	Comentario		text		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	Origen			varchar(255)	NULL,
	Destino			varchar(255)	NULL,
	Fecha			varchar(255)	NULL,
	FechaEmision		datetime	NULL,
	Vencimiento		datetime	NULL,

	TipoDocumento		varchar(50)	NULL,
	Inicio			datetime	NULL,
	Alta			datetime	NULL,
	UltimoCambio		datetime	NULL,
	Usuario			varchar(10)	NULL,
        NivelAcceso		varchar(50)	NULL,
	Categoria		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Familia			varchar(50)	NULL,

	CONSTRAINT priAnexoMovD PRIMARY KEY CLUSTERED (ID, Cuenta, Rama, IDR)
  )
  EXEC spSincroSemilla 'AnexoMovD'
END
GO
IF (SELECT Version FROM Version) <= 1202
  UPDATE AnexoMovD
     SET Direccion = RTRIM(SUBSTRING(Direccion, CHARINDEX('Anexos\', Direccion), 255))  
   WHERE Direccion LIKE '%Anexos\%' AND Tipo = 'Archivo'
GO
if (select version from version)<=2411
begin
  EXEC ("spEliminarPK 'AnexoMovD'")
  EXEC ("spALTER_TABLE 'AnexoMovD', 'IDR', 'int NOT NULL IDENTITY(1,1)'")
  EXEC ("ALTER TABLE AnexoMovD ALTER COLUMN Nombre varchar(255) NULL")
  EXEC ("ALTER TABLE AnexoMovD ALTER COLUMN Direccion varchar(255) NULL")
  EXEC ("ALTER TABLE AnexoMovD ADD CONSTRAINT priAnexoMovD PRIMARY KEY CLUSTERED (Rama, ID, Cuenta, IDR)")
  EXEC ("spSincroSemilla 'AnexoMovD'")
end
GO
EXEC spModificarPK_SucursalSinOrigen 'AnexoMovD', '(Rama, ID, Cuenta, Nombre)'
GO
EXEC spALTER_TABLE 'AnexoMovD', 'Origen', 'varchar(255) NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'Destino', 'varchar(255) NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'Fecha', 'varchar(255) NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'FechaEmision','datetime NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'Vencimiento','datetime NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'TipoDocumento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'Inicio', 'datetime NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'Alta', 'datetime NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'UltimoCambio', 'datetime NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'Usuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'Categoria', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AnexoMovD', 'Familia', 'varchar(50) NULL'
GO

/****** TareaEstado  ******/
if not exists(select * from SysTabla where SysTabla = 'TareaEstado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TareaEstado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TareaEstado') and type = 'U') 
CREATE TABLE dbo.TareaEstado (
	Orden		int	 	NOT NULL,
	Estado		varchar(30)	NOT NULL,
	NombrePlural	varchar(50)	NULL,
	
	CONSTRAINT priTareaEstado PRIMARY KEY CLUSTERED (Orden, Estado)
)
GO

/****** CuentaTarea  ******/
if not exists(select * from SysTabla where SysTabla = 'CuentaTarea')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CuentaTarea','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CuentaTarea') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CuentaTarea (
	Rama		varchar(5)		NOT NULL,
	Cuenta 		varchar(50) 	NOT NULL,
	RenglonID	int		NOT NULL IDENTITY(1,1),

	Tarea		varchar(100)	NULL,
	Asunto		varchar(255)	NULL,
	Estado		varchar(30)	NULL,
	Fecha		datetime	NULL,

	Vencimiento	datetime	NULL,
	
	CONSTRAINT priCuentaTarea PRIMARY KEY CLUSTERED (Cuenta, Rama, RenglonID)
  )
  EXEC spSincroSemilla 'CuentaTarea'
END
GO
if (select version from version)<=2239
BEGIN
  EXEC("ALTER TABLE CuentaTarea DROP CONSTRAINT priCuentaTarea")
  EXEC("ALTER TABLE CuentaTarea ALTER COLUMN Cuenta varchar(50) NOT NULL")
  EXEC("ALTER TABLE CuentaTarea ADD CONSTRAINT priCuentaTarea PRIMARY KEY CLUSTERED (Rama, Cuenta, RenglonID)")
END
GO

/****** Paginas ******/
if not exists(select * from SysTabla where SysTabla = 'Pagina')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Pagina','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Pagina') and type = 'U') 
CREATE TABLE dbo.Pagina (
	Pagina			varchar(20)	NOT NULL,

	Titulo			varchar(100)	NULL,
	Vista			varchar(50)	NULL,
	Propiedades		varchar(255)	NULL,
	Variables		varchar(255)	NULL,
	Grupo			varchar(50)	NULL,
	Usuario			varchar(10)	NULL,
	Estatus			varchar(15)	NULL,
	UltimoCambio		datetime	NULL,

	CONSTRAINT priPagina PRIMARY KEY CLUSTERED (Pagina)
)
GO

/****** Paginas (Celdas) ******/
if not exists(select * from SysTabla where SysTabla = 'PaginaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PaginaD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PaginaD') and type = 'U') 
CREATE TABLE dbo.PaginaD (
	Pagina			varchar(20)	NOT NULL,
	Celda			varchar(7)		NOT NULL,

	Datos			varchar(255)	NULL,
	Propiedades		varchar(255)	NULL,

	CONSTRAINT priPaginaD PRIMARY KEY CLUSTERED (Pagina, Celda)
)
GO

/****** Paginas (Dimensiones) ******/
if not exists(select * from SysTabla where SysTabla = 'PaginaDim')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PaginaDim','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PaginaDim') and type = 'U') 
CREATE TABLE dbo.PaginaDim (
	Pagina			varchar(20)	NOT NULL,
	Dimension		int		NOT NULL,
	Posicion		int		NOT NULL,
	Valor			int		NOT NULL,

	CONSTRAINT priPaginaDim PRIMARY KEY CLUSTERED (Pagina, Dimension, Posicion, Valor)
)
GO

/****** Plantillas ******/
if not exists(select * from SysTabla where SysTabla = 'Plantilla')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Plantilla','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Plantilla') and type = 'U') 
CREATE TABLE dbo.Plantilla (
	Forma			varchar(30)	NOT NULL,
	Clase			varchar(30)	NOT NULL,
	Nombre			varchar(100)	NOT NULL,
	Tipo			varchar(30)	NULL,
	Llave			varchar(30)	NULL,
	Referencia		varchar(255)	NULL,

	CONSTRAINT priPlantilla PRIMARY KEY CLUSTERED (Forma, Clase, Nombre)
)
GO

/****** SubGrupos de Listas ******/
if not exists(select * from SysTabla where SysTabla = 'ListaSubGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaSubGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaSubGrupo') and type = 'U') 
CREATE TABLE dbo.ListaSubGrupo (
	Rama		varchar(5)		NOT NULL,
	Grupo		varchar(50)	NOT NULL,
	SubGrupo	varchar(50)	NOT NULL,
	Orden		int		NULL,

	CONSTRAINT priListaSubGrupo PRIMARY KEY CLUSTERED (Rama, Grupo, SubGrupo)
)
go

/****** SubSubGrupos de Listas ******/
if not exists(select * from SysTabla where SysTabla = 'ListaSubSubGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaSubSubGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaSubSubGrupo') and type = 'U') 
CREATE TABLE dbo.ListaSubSubGrupo (
	Rama		varchar(5)		NOT NULL,
	Grupo		varchar(50)	NOT NULL,
	SubGrupo	varchar(50)	NOT NULL,
	SubSubGrupo	varchar(50)	NOT NULL,
	Orden		int		NULL,

	CONSTRAINT priListaSubSubGrupo PRIMARY KEY CLUSTERED (Rama, Grupo, SubGrupo, SubSubGrupo)
)
go

/****** SubSubSubGrupos de Listas ******/
if not exists(select * from SysTabla where SysTabla = 'ListaSubSubSubGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaSubSubSubGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaSubSubSubGrupo') and type = 'U') 
CREATE TABLE dbo.ListaSubSubSubGrupo (
	Rama		varchar(5)		NOT NULL,
	Grupo		varchar(50)	NOT NULL,
	SubGrupo	varchar(50)	NOT NULL,
	SubSubGrupo	varchar(50)	NOT NULL,
	SubSubSubGrupo	varchar(50)	NOT NULL,
	Orden		int		NULL,

	CONSTRAINT priListaSubSubSubGrupo PRIMARY KEY CLUSTERED (Rama, Grupo, SubGrupo, SubSubGrupo, SubSubSubGrupo)
)
go

/****** Grupos de Listas ******/
if not exists(select * from SysTabla where SysTabla = 'ListaGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaGrupo') and type = 'U') 
CREATE TABLE dbo.ListaGrupo (
	Rama		varchar(5)		NOT NULL,
	Grupo		varchar(50)	NOT NULL,
	Orden		int		NULL,

	CONSTRAINT priListaGrupo PRIMARY KEY CLUSTERED (Rama, Grupo)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ListaGrupo' AND sysindexes.name = 'Orden' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Orden ON dbo.ListaGrupo (Rama, Orden)
go

if exists (select * from sysobjects where id = object_id('dbo.tgListaSubSubGrupoBC') and sysstat & 0xf = 8) drop trigger dbo.tgListaSubSubGrupoBC
GO
CREATE TRIGGER tgListaSubSubGrupoBC ON ListaSubSubGrupo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @RamaA    		varchar(5),
    @GrupoN 		varchar(50),
    @SubGrupoN 		varchar(50),
    @SubSubGrupoN 	varchar(50),
    @GrupoA		varchar(50),
    @SubGrupoA		varchar(50),
    @SubSubGrupoA	varchar(50),
    @Mensaje		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @GrupoN = Grupo, @SubGrupoN = SubGrupo, @SubSubGrupoN = SubSubGrupo FROM Inserted
  SELECT @GrupoA = Grupo, @SubGrupoA = SubGrupo, @SubSubGrupoA = SubSubGrupo, @RamaA = Rama FROM Deleted

  IF @SubSubGrupoN = @SubSubGrupoA RETURN

  IF @SubSubGrupoN IS NULL
  BEGIN
    DELETE ListaSubSubSubGrupo WHERE Grupo = @GrupoA AND SubGrupo = @SubGrupoA AND SubSubGrupo = @SubSubGrupoA AND Rama = @RamaA
  END ELSE
  BEGIN
    UPDATE ListaSubSubSubGrupo SET SubGrupo = @SubGrupoN WHERE Grupo = @GrupoA AND SubGrupo = @SubGrupoA AND SubSubGrupo = @SubSubGrupoA AND Rama = @RamaA
  END
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgListaSubGrupoBC') and sysstat & 0xf = 8) drop trigger dbo.tgListaSubGrupoBC
GO
CREATE TRIGGER tgListaSubGrupoBC ON ListaSubGrupo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @RamaA    	varchar(5),
    @GrupoN 	varchar(50),
    @SubGrupoN 	varchar(50),
    @GrupoA	varchar(50),
    @SubGrupoA	varchar(50),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @GrupoN = Grupo, @SubGrupoN = SubGrupo FROM Inserted
  SELECT @GrupoA = Grupo, @SubGrupoA = SubGrupo, @RamaA = Rama FROM Deleted

  IF @SubGrupoN = @SubGrupoA RETURN

  IF @SubGrupoN IS NULL
  BEGIN
    DELETE ListaSubSubGrupo    WHERE Grupo = @GrupoA AND SubGrupo = @SubGrupoA AND Rama = @RamaA
    DELETE ListaSubSubSubGrupo WHERE Grupo = @GrupoA AND SubGrupo = @SubGrupoA AND Rama = @RamaA
  END ELSE
  BEGIN
    UPDATE ListaSubSubGrupo    SET SubGrupo = @SubGrupoN WHERE Grupo = @GrupoA AND SubGrupo = @SubGrupoA AND Rama = @RamaA
    UPDATE ListaSubSubSubGrupo SET SubGrupo = @SubGrupoN WHERE Grupo = @GrupoA AND SubGrupo = @SubGrupoA AND Rama = @RamaA
  END
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgListaGrupoBC') and sysstat & 0xf = 8) drop trigger dbo.tgListaGrupoBC
GO
CREATE TRIGGER tgListaGrupoBC ON ListaGrupo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @RamaA    	varchar(5),
    @GrupoN 	varchar(50),
    @GrupoA	varchar(50),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @GrupoN = Grupo FROM Inserted
  SELECT @GrupoA = Grupo, @RamaA = Rama FROM Deleted

  IF @GrupoN = @GrupoA RETURN

  IF @GrupoN IS NULL
  BEGIN
    DELETE ListaSubSubSubGrupo WHERE Grupo = @GrupoA AND Rama = @RamaA
    DELETE ListaSubSubGrupo    WHERE Grupo = @GrupoA AND Rama = @RamaA
    DELETE ListaSubGrupo       WHERE Grupo = @GrupoA AND Rama = @RamaA
  END ELSE
  BEGIN
    UPDATE ListaSubSubSubGrupo SET Grupo = @GrupoN WHERE Grupo = @GrupoA AND Rama = @RamaA
    UPDATE ListaSubSubGrupo    SET Grupo = @GrupoN WHERE Grupo = @GrupoA AND Rama = @RamaA
    UPDATE ListaSubGrupo       SET Grupo = @GrupoN WHERE Grupo = @GrupoA AND Rama = @RamaA
  END
END
GO


/****** ListaD ******/
if not exists(select * from SysTabla where SysTabla = 'ListaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaD') and type = 'U') 
CREATE TABLE dbo.ListaD (
	Rama			varchar(5)		NOT NULL,
	Lista			varchar(50)	NOT NULL,
	Visible			varchar(10)	NOT NULL,
	Cuenta			varchar(20) 	NOT NULL,
	Grupo			varchar(50)	NULL,
	SubGrupo		varchar(50)	NULL,
	Signo			char(1)		NULL DEFAULT '+',

	CONSTRAINT priListaD PRIMARY KEY CLUSTERED (Cuenta, Lista, Rama, Visible)
)
GO

/****** Listas ******/
if not exists(select * from SysTabla where SysTabla = 'Lista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Lista','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Lista') and type = 'U') 
CREATE TABLE dbo.Lista (
	Rama			varchar(5)		NOT NULL,
	Lista			varchar(50) 	NOT NULL,
	Visible			varchar(10)	NOT NULL,

	CONSTRAINT priLista PRIMARY KEY CLUSTERED (Lista, Rama, Visible)
)
GO

if not exists(select * from SysTabla where SysTabla = 'ArtL')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtL','Maestro')
if not exists(select * from SysTabla where SysTabla = 'ArtLD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtLD','Maestro')

if not exists(select * from SysTabla where SysTabla = 'CtaDineroL')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaDineroL','Maestro')
if not exists(select * from SysTabla where SysTabla = 'CtaDineroLD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaDineroLD','Maestro')

if not exists(select * from SysTabla where SysTabla = 'CtaL')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaL','Maestro')
if not exists(select * from SysTabla where SysTabla = 'CtaLD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaLD','Maestro')

if not exists(select * from SysTabla where SysTabla = 'CteL')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteL','Maestro')
if not exists(select * from SysTabla where SysTabla = 'CteLD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteLD','Maestro')

if not exists(select * from SysTabla where SysTabla = 'PersonalL')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalL','Maestro')
if not exists(select * from SysTabla where SysTabla = 'PersonalLD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalLD','Maestro')

if not exists(select * from SysTabla where SysTabla = 'ProvL')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvL','Maestro')
if not exists(select * from SysTabla where SysTabla = 'ProvLD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvLD','Maestro')
GO

if exists (select * from sysobjects where id = object_id('dbo.tgListaBC') and sysstat & 0xf = 8) drop trigger dbo.tgListaBC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgListaBC ON Lista
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50),
    @VisibleNuevo	varchar(10),
    @VisibleAnterior	varchar(10)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = Lista, @VisibleNuevo    = Visible FROM Inserted
  SELECT @ClaveAnterior = Lista, @VisibleAnterior = Visible FROM Deleted

  IF @ClaveNueva = @ClaveAnterior AND @VisibleNuevo = @VisibleAnterior RETURN

  IF @ClaveNueva IS NULL
    DELETE ListaD WHERE Lista = @ClaveAnterior AND Visible = @VisibleAnterior
  ELSE
    UPDATE ListaD SET Lista = @ClaveNueva, Visible = @VisibleNuevo WHERE Lista = @ClaveAnterior AND Visible = @VisibleAnterior
END
GO

/****** Cerrar Periodo ****/
if not exists(select * from SysTabla where SysTabla = 'CerrarPeriodo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CerrarPeriodo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CerrarPeriodo') and type = 'U') 
CREATE TABLE dbo.CerrarPeriodo (
	Empresa			varchar(5)         NOT NULL,
	Rama			varchar(5)         NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL

	CONSTRAINT priCerrarPeriodo PRIMARY KEY CLUSTERED (Ejercicio, Periodo, Rama, Empresa)
)
GO

/****** FechaTrabajo ****/
if not exists(select * from SysTabla where SysTabla = 'FechaTrabajo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FechaTrabajo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FechaTrabajo') and type = 'U') 
CREATE TABLE dbo.FechaTrabajo (
	Empresa			varchar(5)         NOT NULL,
	Sucursal		int		NOT NULL	DEFAULT 0,

	FechaTrabajo		datetime	NULL,
	DiasNaturales48Horas	int		NULL,

	CONSTRAINT priFechaTrabajo PRIMARY KEY CLUSTERED (Sucursal, Empresa)
)
GO
EXEC spALTER_TABLE 'FechaTrabajo', 'Sucursal', 'int NOT NULL DEFAULT 0 WITH VALUES'
GO
if (select version from version) <= 1311
BEGIN
  EXEC spEliminarPK 'FechaTrabajo'
  ALTER TABLE FechaTrabajo ADD CONSTRAINT priFechaTrabajo PRIMARY KEY CLUSTERED (Empresa, Sucursal)
END
GO

if exists (select * from sysobjects where id = object_id('dbo.EmpresaGral') and type = 'U') 
BEGIN
  EXEC spALTER_TABLE 'EmpresaGral', 'PC', 'bit NULL DEFAULT 0 WITH VALUES'
  EXEC spALTER_TABLE 'EmpresaGral', 'OFER', 'bit NULL DEFAULT 0 WITH VALUES'
END
GO
if exists (select * from sysobjects where id = object_id('dbo.tgFechaTrabajoAB') and sysstat & 0xf = 8) drop trigger dbo.tgFechaTrabajoAB
GO
-- Aqui va el Matenimiento a la tabla
-- select * from fechatrabajo
CREATE TRIGGER tgFechaTrabajoAB ON FechaTrabajo
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @Dif		int,
--    @Hoy		datetime,
    @EmpresaA		varchar(5),
    @EmpresaN		varchar(5),
    @FechaTrabajoN	datetime,
    @FechaTrabajoA	datetime,
    @SucursalN		int,
    @SucursalA		int,
    @Ok			int,
    @OkRef		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @EmpresaN = Empresa, @FechaTrabajoN = FechaTrabajo, @SucursalN = Sucursal FROM Inserted
  SELECT @EmpresaA = Empresa, @FechaTrabajoA = FechaTrabajo, @SucursalA = Sucursal FROM Deleted

  IF @FechaTrabajoN = @FechaTrabajoA RETURN

--  SELECT @Hoy = GETDATE()
/*  EXEC spExtraerFecha @Hoy OUTPUT
  SELECT @Dif = DATEDIFF(day, @Hoy, @FechaTrabajoN)
  IF ABS(@Dif) > 3 
    RAISERROR ('La Fecha de Trabajo Indicada No Corresponde con el Servidor',16,-1) 
  ELSE*/

  /* Cerrar el Dia en Modulo donde unicamente cambia de estatus el movimiento */
  IF (SELECT PC FROM EmpresaGral WHERE Empresa = @EmpresaN) = 1
    EXEC spPCCerrarDia @FechaTrabajoN, @Ok OUTPUT, @OkRef OUTPUT
  IF (SELECT OFER FROM EmpresaGral WHERE Empresa = @EmpresaN) = 1
    EXEC spOfertaCerrarDia @FechaTrabajoN, @Ok OUTPUT, @OkRef OUTPUT

  EXEC spOk_RAISERROR @Ok, @OkRef
END
GO

/**************** fnUltimoCierre ****************/
--IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnUltimoCierre' AND type = 'FN') DROP FUNCTION fnUltimoCierre
GO
/*CREATE FUNCTION fnUltimoCierre (@Empresa varchar(5), @Sucursal int)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	datetime
  IF @Empresa IS NOT NULL AND @Sucursal IS NOT NULL
    SELECT @Resultado = FechaTrabajo 
      FROM FechaTrabajo 
     WHERE Empresa = @Empresa AND Sucursal = @Sucursal
  ELSE
  IF @Empresa IS NOT NULL AND @Sucursal IS NULL
    SELECT @Resultado = MAX(FechaTrabajo)
      FROM FechaTrabajo 
     WHERE Empresa = @Empresa 
  ELSE
    SELECT @Resultado = MAX(FechaTrabajo)
      FROM FechaTrabajo 
  SELECT @Resultado = DATEADD(day, -1, @Resultado)
  RETURN (@Resultado)
END*/
GO


/************ ServerImpresion ************/
if not exists(select * from SysTabla where SysTabla = 'ServerImpresion')
INSERT INTO SysTabla (SysTabla) VALUES ('ServerImpresion')
if not exists (select * from sysobjects where id = object_id('dbo.ServerImpresion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ServerImpresion (
        ID			int		NOT NULL IDENTITY (1,1),

	EstacionTrabajo		int		NOT NULL,
	Empresa			varchar(5)         NOT NULL,
	Modulo			varchar(5)		NOT NULL,
	Mov 		        varchar(20) 	NOT NULL,
	MovEstatus		varchar(15)	NULL,
	Serie			varchar(20)	NULL,
	Reporte			varchar(50)	NULL,
	Impresora		varchar(100)	NULL,
	FormatoASCII		bit		NOT NULL DEFAULT 0,
	Puerto			varchar(10)	NULL,
	Archivo			varchar(100)	NULL,
	Copias			int		NULL,
	Tiempo			int		NULL  	 DEFAULT 60,
	ImprimirCancelados	bit		NOT NULL DEFAULT 1,
	Consecutivo 		int		NOT NULL DEFAULT 0,
	Activo			bit		NOT NULL DEFAULT 1,
	Prefijo			varchar(5)	NULL,
	FiltroUsuario		bit		NULL DEFAULT 0,

	CONSTRAINT priServerImpresion PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ServerImpresion'
END
GO
if not exists(select * from syscampo where tabla = 'ServerImpresion' and Campo = 'Prefijo')
  ALTER TABLE ServerImpresion ADD Prefijo varchar(5) NULL
GO
EXEC spALTER_TABLE 'ServerImpresion', 'FiltroUsuario', 'bit NULL DEFAULT 0 WITH VALUES'
GO

/****** MovEstatusLog ******/
if not exists(select * from SysTabla where SysTabla = 'MovEstatusLog')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovEstatusLog','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.MovEstatusLog') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovEstatusLog (
	Modulo			varchar(5)		NOT NULL,
	ModuloID 		int       	NOT NULL,
        ID			int		NOT NULL IDENTITY (1,1),

	Usuario			varchar(10)	NOT NULL,
	Estatus			varchar(15)	NOT NULL,
	Fecha			datetime	NOT NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priMovEstatusLog PRIMARY KEY CLUSTERED (ModuloID, Modulo, ID)
  )
  EXEC spSincroSemilla 'MovEstatusLog'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'MovEstatusLog', '(ModuloID, Modulo, ID)'
GO
EXEC spADD_INDEX 'MovEstatusLog', 'ID', 'ID, Modulo, ModuloID'
GO


/****** MovUsuario ******/
if not exists(select * from SysTabla where SysTabla = 'MovUsuario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovUsuario','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.MovUsuario') and type = 'U') 
CREATE TABLE dbo.MovUsuario (
	Modulo			varchar(5)		NOT NULL,
	ID 			int       	NOT NULL,
 	Orden			int	  	NOT NULL,

	Usuario			varchar(10)	NOT NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	Eliminado		bit		NOT NULL DEFAULT 0,
	Observaciones		varchar(100)	NULL,
	Prioridad		varchar(10)	NULL,

	CONSTRAINT priMovUsuario PRIMARY KEY CLUSTERED (ID, Modulo, Orden)
)
GO
EXEC spModificarPK_SucursalSinOrigen 'MovUsuario', '(ID, Modulo, Orden)'
GO
EXEC spALTER_TABLE 'MovUsuario', 'Eliminado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovUsuario', 'Observaciones', 'varchar(100)	NULL'
EXEC spALTER_TABLE 'MovUsuario', 'Prioridad', 'varchar(10) NULL'
GO
EXEC spADD_INDEX 'MovUsuario', 'ID', 'ID, Modulo, Orden, Usuario, Sucursal'
GO

/****** MovBitacora ******/
if not exists(select * from SysTabla where SysTabla = 'MovBitacora')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovBitacora','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.MovBitacora') and type = 'U') 
CREATE TABLE dbo.MovBitacora (
	Modulo			varchar(5)		NOT NULL,
	ID 			int       	NOT NULL,
	RID			int       	NOT NULL	IDENTITY (1,1),

	Fecha			datetime	NOT NULL,
	Evento			varchar(255)	NULL,
	Tipo			varchar(20)	NULL	 DEFAULT 'Comentario',
	Sucursal		int		NOT NULL DEFAULT 0,
	Usuario			varchar(10)	NULL,

	MovEstatus		varchar(15)	NULL,
	MovSituacion		varchar(50)	NULL,
	MovSituacionFecha	datetime	NULL,
	MovSituacionUsuario	varchar(10)	NULL,
	MovSituacionNota	varchar(100)	NULL,

	Duracion		float		NULL,
	DuracionUnidad		varchar(10)	NULL,

	CONSTRAINT priMovBitacora PRIMARY KEY CLUSTERED (ID, Modulo, RID)
)
GO
if not exists(select * FROM SysCampo WHERE Tabla = 'MovBitacora' AND Campo = 'RID')
BEGIN
  EXEC ("spALTER_TABLE 'MovBitacora', 'RID', 'int NOT NULL IDENTITY (1,1)'")
  EXEC ("spEliminarPK 'MovBitacora'")
  EXEC("ALTER TABLE MovBitacora ADD CONSTRAINT priMovBitacora PRIMARY KEY CLUSTERED (Modulo, ID, RID)")
END
GO
EXEC spModificarPK_SucursalSinOrigen 'MovBitacora', '(Modulo, ID, RID)'
EXEC spALTER_TABLE 'MovBitacora', 'Usuario', 'varchar(10) NULL'
go
EXEC spALTER_TABLE 'MovBitacora', 'Tipo', 'varchar(20) NULL DEFAULT "Comentario" WITH VALUES'
EXEC spALTER_TABLE 'MovBitacora', 'MovEstatus', 'varchar(15) NULL'
EXEC spALTER_TABLE 'MovBitacora', 'MovSituacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovBitacora', 'MovSituacionFecha', 'datetime NULL'
EXEC spALTER_TABLE 'MovBitacora', 'MovSituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'MovBitacora', 'MovSituacionNota', 'varchar(100) NULL'
GO
EXEC spADD_INDEX 'MovBitacora', 'ID', 'ID, Modulo, Fecha, Evento, Sucursal, Usuario'
GO
EXEC spALTER_TABLE 'MovBitacora', 'Duracion', 'float NULL'
EXEC spALTER_TABLE 'MovBitacora', 'DuracionUnidad', 'varchar(10) NULL'
GO

EXEC spFK 'MovBitacora','Tipo','EventoTipo','Tipo'
GO

/****** CtaBitacora ******/
if not exists(select * from SysTabla where SysTabla = 'CtaBitacora')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaBitacora','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaBitacora') and type = 'U') 
CREATE TABLE dbo.CtaBitacora (
	Modulo			varchar(5)		NOT NULL,
	Cuenta			varchar(20)      	NOT NULL,
	Fecha			datetime	NOT NULL,

	Evento			varchar(255)	NULL,
	Usuario			varchar(10)	NULL,

	CONSTRAINT priCtaBitacora PRIMARY KEY CLUSTERED (Cuenta, Modulo, Fecha)
)
GO
EXEC spALTER_TABLE 'CtaBitacora', 'Usuario', 'varchar(10) NULL'
GO


/****** PeriodoEspecial ******/
if not exists(select * from SysTabla where SysTabla = 'PeriodoEspecial')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PeriodoEspecial','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PeriodoEspecial') and type = 'U') 
CREATE TABLE dbo.PeriodoEspecial (
	Empresa		varchar(5)		NOT NULL,
	Modulo		varchar(5)		NOT NULL,
	Periodo		int		NOT NULL,
	Nombre		varchar(50)	NULL,

	CONSTRAINT priPeriodoEspecial PRIMARY KEY CLUSTERED (Modulo, Periodo, Empresa)
)
GO

/****** EjercicioEspecial ******/
if not exists(select * from SysTabla where SysTabla = 'EjercicioEspecial')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EjercicioEspecial','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EjercicioEspecial') and type = 'U') 
CREATE TABLE dbo.EjercicioEspecial (
	Empresa		varchar(5)		NOT NULL,
	Modulo		varchar(5)		NOT NULL,
	FechaD		datetime	NOT NULL,
	FechaA		datetime	NOT NULL,
	Periodo		int		NOT NULL,
	Ejercicio	int		NOT NULL,

	CONSTRAINT priEjercicioEspecial PRIMARY KEY CLUSTERED (Modulo, FechaD, FechaA, Empresa)
)
GO

/****** BackOrderLog ******/
if not exists(select * from SysTabla where SysTabla = 'BackOrderLog')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('BackOrderLog', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla) VALUES ('BackOrderLog')
if not exists (select * from sysobjects where id = object_id('dbo.BackOrderLog') and type = 'U') 
BEGIN
  CREATE TABLE dbo.BackOrderLog (
	ID		int		NOT NULL IDENTITY(1, 1), 

	Empresa		varchar(5)		NULL, 
	OModulo		varchar(5)		NULL,  
	OID		int		NULL,  
	OMov		varchar(20)	NULL,  
	OMovID		varchar(20)	NULL,  
	DModulo		varchar(5)		NULL,  
	DID		int		NULL, 
	DMov		varchar(20)	NULL, 
	DMovID		varchar(20)	NULL, 
	Articulo	varchar(20)	NULL,  
	SubCuenta	varchar(50)	NULL,  
	Cantidad	float		NULL,  
	Unidad		varchar(50)	NULL, 

	CONSTRAINT priBackOrderLog PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'BackOrderLog'
END
GO

/****** ImpresoraModo ******/
if not exists(select * from SysTabla where SysTabla = 'ImpresoraModo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ImpresoraModo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ImpresoraModo') and type = 'U') 
CREATE TABLE dbo.ImpresoraModo (
	Modo			varchar(50)  	NOT NULL,
	Secuencia		varchar(100)  	NULL,

	CONSTRAINT priImpresoraModo PRIMARY KEY CLUSTERED (Modo)
)
GO


/****** PersonalPropCat ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalPropCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalPropCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalPropCat') and type = 'U') 
CREATE TABLE dbo.PersonalPropCat (
	Categoria	varchar(50) 	NOT NULL,

	CONSTRAINT priPersonalPropCat PRIMARY KEY  CLUSTERED (Categoria)
)
GO

/****** PersonalPropValor ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalPropValor')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalPropValor','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalPropValor') and type = 'U') 
CREATE TABLE dbo.PersonalPropValor (
	Rama		varchar(5)		NOT NULL,
	Cuenta		varchar(50)	NOT NULL,
	Propiedad	varchar(50) 	NOT NULL,

	Valor		varchar(50)	NULL,

	CONSTRAINT priPersonalPropValor PRIMARY KEY  CLUSTERED (Cuenta, Propiedad, Rama)
)
GO

EXEC spFK 'PersonalPropValor','Propiedad','PersonalProp','Propiedad'
GO

if (select version from version) <= 2791 and exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PersonalPropValor' AND sysindexes.name = 'Propiedad' AND sysobjects.id = sysindexes.id)
 DROP INDEX PersonalPropValor.Propiedad
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PersonalPropValor' AND sysindexes.name = 'Propiedad' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Propiedad ON dbo.PersonalPropValor (Propiedad, Rama)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PersonalPropValor' AND sysindexes.name = 'Consulta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consulta ON dbo.PersonalPropValor (Cuenta, Rama)
GO
if (select version from version) <= 2791
BEGIN
  EXEC spEliminarPK 'PersonalPropValor'
  EXEC("ALTER TABLE PersonalPropValor ADD CONSTRAINT priPersonalPropValor PRIMARY KEY CLUSTERED (Cuenta, Propiedad, Rama)")
END
GO


/****** PersonalPropPais ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalPropPais')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalPropPais','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalPropPais') and type = 'U') 
CREATE TABLE dbo.PersonalPropPais (
	Propiedad	varchar(50) 	NOT NULL,
	Pais		varchar(50)	NOT NULL,

	CONSTRAINT priPersonalPropPais PRIMARY KEY  CLUSTERED (Propiedad, Pais)
)
GO

/****** PersonalProp ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalProp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalProp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalProp') and type = 'U') 
CREATE TABLE dbo.PersonalProp (
	Propiedad	varchar(50) 	NOT NULL,

	Orden		int		NULL,
	Categoria	varchar(50) 	NULL,
	NivelEmpresa	bit		NOT NULL DEFAULT 0,
	NivelSucursal	bit		NOT NULL DEFAULT 0,
	NivelCategoria	bit		NOT NULL DEFAULT 0,
	NivelPuesto	bit		NOT NULL DEFAULT 0,
	NivelPersonal	bit		NOT NULL DEFAULT 0,

	porOmision	varchar(50)	NULL,
	Mascara		varchar(50)	NULL,
	LongitudMaxima	int		NULL	DEFAULT 50,
	TipoDatos	varchar(20)	NULL	DEFAULT 'Texto',

	Nombre		varchar(100)	NULL,
	Descripcion	varchar(255)	NULL,

	CONSTRAINT priPersonalProp PRIMARY KEY  CLUSTERED (Propiedad)
)
GO
EXEC spALTER_TABLE 'PersonalProp', 'NivelSucursal', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'PersonalProp', 'NivelPuesto', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'PersonalProp', 'Mascara', 'varchar(50) NULL'
EXEC spALTER_TABLE 'PersonalProp', 'LongitudMaxima', 'int NULL DEFAULT 50 WITH VALUES'
EXEC spALTER_TABLE 'PersonalProp', 'TipoDatos', 'varchar(20) NULL DEFAULT "Texto" WITH VALUES'
EXEC spALTER_TABLE 'PersonalProp', 'Nombre', 'varchar(100) NULL'
EXEC spALTER_TABLE 'PersonalProp', 'Descripcion', 'varchar(255)	NULL'
GO
if exists (select * from sysobjects where id = object_id('dbo.Personal') and type = 'U') 
  EXEC spALTER_TABLE 'Personal', 'Empresa', 'varchar(5) NULL'		-- Para que pase el Trigger
GO
if (select version from version) <= 2797
  UPDATE PersonalProp SET Nombre = Propiedad
GO
-- el trigger tgPersonalPropABC esta em Cuentas despues de dbo.Personal
-- Aqui va el Matenimiento a la tabla

/****** AnuncioD ******/
if not exists(select * from SysTabla where SysTabla = 'AnuncioD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnuncioD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AnuncioD') and type = 'U') 
CREATE TABLE dbo.AnuncioD (
	Anuncio 	varchar(50)	NOT NULL,
	Horario 	varchar(50)	NOT NULL,

	CONSTRAINT priAnuncioD PRIMARY KEY CLUSTERED (Anuncio, Horario)
)
GO

/****** AnuncioArt ******/
if not exists(select * from SysTabla where SysTabla = 'AnuncioArt')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnuncioArt','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AnuncioArt') and type = 'U') 
CREATE TABLE dbo.AnuncioArt (
	Anuncio 	varchar(50)	NOT NULL,
	Articulo	varchar(20)	NOT NULL,

	CONSTRAINT priAnuncioArt PRIMARY KEY CLUSTERED (Anuncio, Articulo)
)
GO

EXEC spFK 'AnuncioArt','Articulo','Art','Articulo'
GO

/****** Anuncio ******/
if not exists(select * from SysTabla where SysTabla = 'Anuncio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Anuncio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Anuncio') and type = 'U') 
CREATE TABLE dbo.Anuncio (
	Anuncio 	varchar(50) 	NOT NULL,
        Archivo 	varchar(100) 	NULL,
        Proveedor 	varchar(10) 	NULL,
        FechaD 		datetime 	NULL,
        FechaA 		datetime 	NULL
	CONSTRAINT priAnuncio PRIMARY KEY CLUSTERED (Anuncio)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgAnuncioC') and sysstat & 0xf = 8) drop trigger dbo.tgAnuncioC
GO

-- Aqui va el Matenimiento a la tabla

EXEC spFK 'Anuncio','Proveedor','Prov','Proveedor'
GO


CREATE TRIGGER tgAnuncioC ON Anuncio
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @AnuncioN	varchar(50),
    @AnuncioA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @AnuncioN = Anuncio FROM Inserted
  SELECT @AnuncioA = Anuncio FROM Deleted

  IF @AnuncioN = @AnuncioA RETURN

  IF @AnuncioN IS NULL
  BEGIN
    DELETE AnuncioD   WHERE Anuncio = @AnuncioA
    DELETE AnuncioArt WHERE Anuncio = @AnuncioA
  END ELSE 
  BEGIN
    UPDATE AnuncioD   SET Anuncio =  @AnuncioN WHERE Anuncio = @AnuncioA
    UPDATE AnuncioArt SET Anuncio =  @AnuncioN WHERE Anuncio = @AnuncioA
  END
END
GO

/****** AnuncioHorario ******/
if not exists(select * from SysTabla where SysTabla = 'AnuncioHorario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnuncioHorario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AnuncioHorario') and type = 'U') 
CREATE TABLE dbo.AnuncioHorario (
	Horario 	varchar(50)	NOT NULL,

	HoraD		varchar(5)		NOT NULL,  -- 0000
	HoraA		varchar(5)		NOT NULL,

	CONSTRAINT priAnuncioHorario PRIMARY KEY CLUSTERED (Horario)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgAnuncioHorarioC') and sysstat & 0xf = 8) drop trigger dbo.tgAnuncioHorarioC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgAnuncioHorarioC ON AnuncioHorario
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @HorarioN	varchar(50),
    @HorarioA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @HorarioN = Horario FROM Inserted
  SELECT @HorarioA = Horario FROM Deleted

  IF @HorarioN = @HorarioA RETURN

  IF @HorarioN IS NULL
    DELETE AnuncioD WHERE Horario = @HorarioA
  ELSE
    UPDATE AnuncioD SET Horario =  @HorarioN WHERE Horario = @HorarioA
END
GO

/****** Consecutivo ******/
if not exists(select * from SysTabla where SysTabla = 'Consecutivo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Consecutivo','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Consecutivo') and type = 'U') 
  CREATE TABLE dbo.Consecutivo (
	Tipo	 	varchar(20)	NOT NULL,	-- Lote/Codigo Barras
	Nivel		varchar(20)	NULL,		-- Global/Sucursal
	TieneControl	bit		NULL 	DEFAULT 0,

	Prefijo		varchar(5)	NULL,
	Consecutivo	int		NULL,
	Concurrencia	varchar(20)	NULL,		-- Alta/Normal/Baja
	FueraLinea		bit		NULL	DEFAULT 0,

	CONSTRAINT priConsecutivo PRIMARY KEY CLUSTERED (Tipo)
  )
GO
EXEC spALTER_TABLE 'Consecutivo', 'TieneControl', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Consecutivo', 'Concurrencia', 'varchar(20) DEFAULT "Normal" WITH VALUES'
GO
EXEC spALTER_TABLE 'Consecutivo', 'FueraLinea', 'bit NULL DEFAULT 0 WITH VALUES' 
GO
EXEC spALTER_TABLE 'Consecutivo', 'DividirSeries', 'bit DEFAULT 0 WITH VALUES'
GO

UPDATE SysTabla SET FueraLinea = 1 WHERE SysTabla = 'Consecutivo'
GO


/****** ConsecutivoSucursal ******/
if not exists(select * from SysTabla where SysTabla = 'ConsecutivoSucursal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ConsecutivoSucursal','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ConsecutivoSucursal') and type = 'U') 
  CREATE TABLE dbo.ConsecutivoSucursal (
	Tipo	 	varchar(20)	NOT NULL,
	Sucursal	int		NOT NULL	DEFAULT 0,

	Consecutivo	int		NULL,
	FueraLinea		bit		NULL	DEFAULT 0,

	CONSTRAINT priConsecutivoSucursal PRIMARY KEY CLUSTERED (Tipo, Sucursal)
  )
GO
EXEC spALTER_TABLE 'ConsecutivoSucursal', 'FueraLinea', 'bit NULL DEFAULT 0 WITH VALUES' 
UPDATE SysTabla SET FueraLinea = 1 WHERE SysTabla = 'ConsecutivoSucursal'
GO

EXEC spFK 'ConsecutivoSucursal','Sucursal','Sucursal','Sucursal'
GO

/****** ConsecutivoControl ******/
if not exists (select * from SysTabla where SysTabla = 'ConsecutivoControl') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ConsecutivoControl', 'Cuenta')
ELSE 
IF exists (select * from SysTabla where SysTabla = 'ConsecutivoControl' AND Tipo = 'Maestro')
  UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'ConsecutivoControl'
if not exists (select * from sysobjects where id = object_id('dbo.ConsecutivoControl') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ConsecutivoControl (
	Tipo	 	varchar(20)	NOT NULL,
	ID		int		NOT NULL 	IDENTITY(1,1),
	
	ConsecutivoD	int		NULL,
	ConsecutivoA	int		NULL,
	Estatus		varchar(15)	NULL,
	Referencia	varchar(50)	NULL,

	CONSTRAINT priConsecutivoControl PRIMARY KEY  CLUSTERED (Tipo, ID)
  )
  EXEC spSincroSemilla 'ConsecutivoControl'
END
GO

/* Cubo */
if not exists(select * from SysTabla where SysTabla = 'Cubo')
INSERT INTO SysTabla (SysTabla) VALUES ('Cubo')
if not exists (select * from sysobjects where id = object_id('dbo.Cubo') and type = 'U') 
CREATE TABLE dbo.Cubo (
    	Cubo        		varchar(20)     	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	Vista			varchar(100)	NULL,
	UltimaActualizacion	datetime	NULL,
	Minutos			int		NULL,
	Instalado		bit		NULL	DEFAULT 0,
	Activo			bit		NULL	DEFAULT 1,

	EsCuboRemoto		bit		NULL	DEFAULT 0,
	ServidorRemoto		varchar(100)	NULL,
	BaseDatosRemoto		varchar(100)	NULL,
	CuboRemoto		varchar(100)	NULL,
	
	EnviarPDF		bit		NULL	DEFAULT 0,
	EnviarXLS		bit		NULL	DEFAULT 0,
	EnviarRTF		bit		NULL	DEFAULT 0,
	
	PermiteCrearVistas	bit		NULL	DEFAULT 0,
	PermiteEliminarVistas	bit		NULL	DEFAULT 0,

    	CONSTRAINT priCubo PRIMARY KEY  CLUSTERED (Cubo)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCuboBC') and sysstat & 0xf = 8) drop trigger dbo.tgCuboBC
GO
EXEC spALTER_TABLE 'Cubo', 'Activo', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Cubo', 'Minutos', 'int NULL'
EXEC spALTER_TABLE 'Cubo', 'EsCuboRemoto', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cubo', 'ServidorRemoto', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cubo', 'BaseDatosRemoto', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cubo', 'CuboRemoto', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cubo', 'EnviarPDF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cubo', 'EnviarXLS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cubo', 'EnviarRTF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cubo', 'PermiteCrearVistas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cubo', 'PermiteEliminarVistas', 'bit NULL DEFAULT 0 WITH VALUES'
GO


/* CuboCampo */
if not exists(select * from SysTabla where SysTabla = 'CuboCampo')
INSERT INTO SysTabla (SysTabla) VALUES ('CuboCampo')
if not exists (select * from sysobjects where id = object_id('dbo.CuboCampo') and type = 'U') 
CREATE TABLE dbo.CuboCampo (
    	Cubo        		varchar(20)    	NOT NULL,
	Campo			varchar(255)	NOT NULL,

	Etiqueta		varchar(255)	NULL,
	Tipo			varchar(20)	NULL,
	Formato			varchar(50)	NULL,

    	CONSTRAINT priCuboCampo PRIMARY KEY  CLUSTERED (Cubo, Campo)
)
GO

/* CuboMedida */
if not exists(select * from SysTabla where SysTabla = 'CuboMedida')
INSERT INTO SysTabla (SysTabla) VALUES ('CuboMedida')
if not exists (select * from sysobjects where id = object_id('dbo.CuboMedida') and type = 'U') 
CREATE TABLE dbo.CuboMedida (
    	Cubo        		varchar(20)     	NOT NULL,
	Campo			varchar(100)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,

    	CONSTRAINT priCuboMedida PRIMARY KEY  CLUSTERED (Cubo, Campo)
)
GO


/* CuboDimension */
if not exists(select * from SysTabla where SysTabla = 'CuboDimension')
INSERT INTO SysTabla (SysTabla) VALUES ('CuboDimension')
if not exists (select * from sysobjects where id = object_id('dbo.CuboDimension') and type = 'U') 
CREATE TABLE dbo.CuboDimension (
    	Cubo        		varchar(20)     	NOT NULL,
	Dimension		varchar(50)	NOT NULL,

	Tipo			varchar(20)	NULL 	DEFAULT 'Normal',
	Descripcion		varchar(255)	NULL,
	Activa			bit		NULL 	DEFAULT 1,

    	CONSTRAINT priCuboDimension PRIMARY KEY  CLUSTERED (Cubo, Dimension)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCuboDimensionBC') and sysstat & 0xf = 8) drop trigger dbo.tgCuboDimensionBC
GO
EXEC spALTER_TABLE 'CuboDimension', 'Activa', 'bit NULL DEFAULT 1 WITH VALUES'
GO

/* CuboDimensionNivel */
if not exists(select * from SysTabla where SysTabla = 'CuboDimensionNivel')
INSERT INTO SysTabla (SysTabla) VALUES ('CuboDimensionNivel')
if not exists (select * from sysobjects where id = object_id('dbo.CuboDimensionNivel') and type = 'U') 
CREATE TABLE dbo.CuboDimensionNivel (
    	Cubo        		varchar(20)     	NOT NULL,
	Dimension		varchar(50)	NOT NULL,
	Campo			varchar(100)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	Orden			int		NULL,

    	CONSTRAINT priCuboDimensionNivel PRIMARY KEY  CLUSTERED (Cubo, Dimension, Campo)
)
GO

/* CuboFormula */
if not exists(select * from SysTabla where SysTabla = 'CuboFormula')
INSERT INTO SysTabla (SysTabla) VALUES ('CuboFormula')
if not exists (select * from sysobjects where id = object_id('dbo.CuboFormula') and type = 'U') 
CREATE TABLE dbo.CuboFormula (
    	Cubo        		varchar(20)     	NOT NULL,
	Nombre			varchar(100)	NOT NULL,

	Descripcion		varchar(255)	NULL,
	Formula			text		NULL,
	Orden			int		NULL,

    	CONSTRAINT priCuboFormula PRIMARY KEY  CLUSTERED (Cubo, Nombre)
)
GO
EXEC spALTER_TABLE 'CuboFormula', 'Orden', 'int NULL'
GO

/* CuboVista */
if (select version from version)<=2086 and exists (select * from sysobjects where id = object_id('dbo.CuboVista') and type = 'U') 
  drop table CuboVista
Go
if not exists(select * from SysTabla where SysTabla = 'CuboVista')
INSERT INTO SysTabla (SysTabla) VALUES ('CuboVista')
if not exists (select * from sysobjects where id = object_id('dbo.CuboVista') and type = 'U') 
CREATE TABLE dbo.CuboVista (
    	Cubo        		varchar(20)     NOT NULL,
	Vista			varchar(100)	NOT NULL,

	Datos    		text		NULL, 
	GraficaTipo		varchar(100)	NULL,
        NivelAcceso		varchar(50)	NULL,
	Usuario			varchar(10)	NULL,
	dx			bit		NULL	DEFAULT 0,

    CONSTRAINT priCuboVista PRIMARY KEY  CLUSTERED (Cubo, Vista)
)
GO
EXEC spALTER_TABLE 'CuboVista','FieldLabelFont','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','FieldLabelForeColor','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','FieldLabelBackColor','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','HeaderBackColor','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','HeaderFont','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','HeaderForeColor','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','HeaderHAlignment','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','PropertyCaptionFont','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','PropertyCaptionHAlignment','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','PropertyValueFont','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','PropertyValueHAlignment','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','TotalBackColor','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','TotalFont','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','TotalForeColor','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','TotalOrientation','VARCHAR(100) NULL'
EXEC spALTER_TABLE 'CuboVista','GraficaTipo', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CuboVista','GraficaLeyenda', 'BIT NULL'
EXEC spALTER_TABLE 'CuboVista','GraficaOrientacion', 'varchar(1) NULL'
EXEC spALTER_TABLE 'CuboVista','Usuario','varchar(10) NULL'
EXEC spALTER_TABLE 'CuboVista','dx', 'bit NULL DEFAULT 0 WITH VALUES'
GO

CREATE TRIGGER tgCuboBC ON Cubo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CuboN	varchar(20),
    @CuboA	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CuboN = Cubo FROM Inserted
  SELECT @CuboA = Cubo FROM Deleted

  IF @CuboN = @CuboA RETURN

  IF @CuboN IS NULL
  BEGIN
    DELETE CuboMedida	 	WHERE Cubo = @CuboA
    DELETE CuboDimension 	WHERE Cubo = @CuboA
    DELETE CuboDimensionNivel 	WHERE Cubo = @CuboA
    DELETE CuboFormula	 	WHERE Cubo = @CuboA
    DELETE CuboCampo	 	WHERE Cubo = @CuboA
    --DELETE CuboVista	 	WHERE Cubo = @CuboA
  END ELSE
  BEGIN
    UPDATE CuboMedida	 	SET Cubo =  @CuboN WHERE Cubo = @CuboA
    UPDATE CuboDimension 	SET Cubo =  @CuboN WHERE Cubo = @CuboA
    UPDATE CuboDimensionNivel 	SET Cubo =  @CuboN WHERE Cubo = @CuboA
    UPDATE CuboFormula	 	SET Cubo =  @CuboN WHERE Cubo = @CuboA
    UPDATE CuboCampo	 	SET Cubo =  @CuboN WHERE Cubo = @CuboA
    UPDATE CuboVista	 	SET Cubo =  @CuboN WHERE Cubo = @CuboA
  END
END
GO

CREATE TRIGGER tgCuboDimensionBC ON CuboDimension
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CuboN	varchar(20),
    @CuboA	varchar(20),
    @DimensionN	varchar(50),
    @DimensionA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CuboN = Cubo, @DimensionN = Dimension FROM Inserted
  SELECT @CuboA = Cubo, @DimensionA = Dimension FROM Deleted

  IF @DimensionN = @DimensionA RETURN

  IF @DimensionN IS NULL
  BEGIN
    DELETE CuboDimensionNivel 	WHERE Cubo = @CuboA AND Dimension = @DimensionA
  END ELSE
  BEGIN
    UPDATE CuboDimensionNivel 	SET Dimension =  @DimensionN WHERE Cubo = @CuboA AND Dimension = @DimensionA
  END
END
GO


/****** CorteCosto ******/
if not exists (select * from SysTabla where SysTabla = 'CorteCosto') 
INSERT INTO SysTabla (SysTabla) VALUES ('CorteCosto')
if not exists (select * from sysobjects where id = object_id('dbo.CorteCosto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CorteCosto (
	ID			int		NOT NULL IDENTITY(1,1),

	Fecha			datetime	NULL,
	Empresa			varchar(5)	NULL, 
	Articulo		varchar(20)	NULL, 
	SubCuenta		varchar(50)	NULL, 
	Sucursal		int		NULL, 
	CostoPromedio		money		NULL, 
	UltimoCosto		money		NULL, 
	UltimoCostoSinGastos	money		NULL, 
	CostoEstandar		money		NULL, 
	CostoReposicion		money		NULL, 

 	CONSTRAINT priCorteCosto PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CorteCosto'
END
GO
EXEC spALTER_COLUMN 'CorteCosto', 'SubCuenta', 'varchar(50) NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CorteCosto' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Fecha ON dbo.CorteCosto (Fecha)
GO

/****** CorteExistencia ******/
if not exists (select * from SysTabla where SysTabla = 'CorteExistencia') 
INSERT INTO SysTabla (SysTabla) VALUES ('CorteExistencia')
if not exists (select * from sysobjects where id = object_id('dbo.CorteExistencia') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CorteExistencia (
	ID			int		NOT NULL IDENTITY(1,1),

	Fecha			datetime	NULL,
	Empresa			varchar(5)	NULL, 
	Articulo		varchar(20)	NULL, 
	SubCuenta		varchar(50)	NULL, 
	Sucursal		int		NULL,
	Almacen			varchar(10)	NULL,
	Existencia		float		NULL, 

 	CONSTRAINT priCorteExistencia PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CorteExistencia'
END
GO
EXEC spALTER_COLUMN 'CorteExistencia', 'SubCuenta', 'varchar(50) NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CorteExistencia' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Fecha ON dbo.CorteExistencia (Fecha)
GO

/****** MovImpuesto ******/
if not exists(select * from SysTabla where SysTabla = 'MovImpuesto')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovImpuesto', 'MovimientoInfo')
go
if exists (select * from sysobjects where id = object_id('dbo.MovImpuesto') and type = 'U') and (select version from version)<=2457
begin
  select * into tmp_MovImpuesto from MovImpuesto 
  drop table MovImpuesto
end
go

if not exists (select * from sysobjects where id = object_id('dbo.MovImpuesto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovImpuesto (
	Modulo			varchar(5)	NOT NULL,
	ModuloID		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),
	
	Impuesto1		float		NULL,	 	
	Impuesto2		float		NULL, 
	Impuesto3		float		NULL, 
	Impuesto5		float		NULL, 

	Importe1		money		NULL, 
	Importe2		money		NULL, 
	Importe3		money		NULL,
	Importe5		money		NULL,

	SubTotal		money		NULL,
	LoteFijo		varchar(20)	NULL,

	Retencion1		float		NULL, 
	Retencion2		float		NULL, 
	Retencion3		float		NULL, 

	Excento1		bit		NULL	DEFAULT 0,
	Excento2		bit		NULL	DEFAULT 0,	
	Excento3		bit		NULL	DEFAULT 0,	
	
	TipoImpuesto1		varchar(10)	NULL, 
	TipoImpuesto2		varchar(10)	NULL, 
	TipoImpuesto3		varchar(10)	NULL, 
	TipoImpuesto5		varchar(10)	NULL, 
	TipoRetencion1		varchar(10)	NULL, 
	TipoRetencion2		varchar(10)	NULL, 
	TipoRetencion3		varchar(10)	NULL, 

	OrigenModulo		varchar(5)	NULL,
	OrigenModuloID		int		NULL,
	OrigenConcepto		varchar(50)	NULL,
	OrigenDeducible		float		NULL	DEFAULT 100,
	OrigenFecha		datetime	NULL,

	SubFolio		varchar(20)	NULL,
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20)	NULL,
	ContUso3		varchar(20)	NULL,
	ClavePresupuestal		varchar(50)	NULL,
	ClavePresupuestalImpuesto1	varchar(50)	NULL,
	
	DescuentoGlobal		float		NULL,
	ImporteBruto		money		NULL,
	CONSTRAINT priMovImpuesto PRIMARY KEY  CLUSTERED (ModuloID, Modulo, ID)
  )
  EXEC spSincroSemilla 'MovImpuesto'
END
GO
EXEC spALTER_TABLE 'MovImpuesto', 'LoteFijo', 'varchar(20)'
GO
if exists(select * from sysobjects where id = object_id('dbo.tmp_MovImpuesto') and type = 'U')
begin
  insert MovImpuesto (Modulo, ModuloID, Impuesto1, Impuesto2, Impuesto3, Importe1, Importe2, Importe3, SubTotal)
              SELECT Modulo, ModuloID, Impuesto1, Impuesto2, Impuesto3, Importe1, Importe2, Importe3, SubTotal
                FROM tmp_MovImpuesto
  drop table tmp_MovImpuesto
end  
GO
if (select version from version) <= 2793
BEGIN
  EXEC spEliminarPK 'MovImpuesto'
  ALTER TABLE MovImpuesto ADD CONSTRAINT priMovImpuesto PRIMARY KEY  CLUSTERED (ModuloID, Modulo, ID)
END
GO
EXEC spALTER_TABLE 'MovImpuesto', 'Retencion1', 'float'
EXEC spALTER_TABLE 'MovImpuesto', 'Retencion2', 'float'
EXEC spALTER_TABLE 'MovImpuesto', 'Retencion3', 'float'
EXEC spALTER_TABLE 'MovImpuesto', 'Excento1', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovImpuesto', 'Excento2', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovImpuesto', 'Excento3', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovImpuesto', 'OrigenModulo', 'varchar(5)'
EXEC spALTER_TABLE 'MovImpuesto', 'OrigenModuloID', 'int'
EXEC spALTER_TABLE 'MovImpuesto', 'OrigenConcepto', 'varchar(50)'
EXEC spALTER_TABLE 'MovImpuesto', 'OrigenDeducible', 'float NULL DEFAULT 100 WITH VALUES'
EXEC spALTER_TABLE 'MovImpuesto', 'OrigenFecha', 'datetime NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'SubFolio', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'ContUso3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'ClavePresupuestal', 'varchar(50) NULL'
GO
EXEC spALTER_COLUMN 'MovImpuesto', 'ClavePresupuestal', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'MovImpuesto', 'ClavePresupuestalImpuesto1', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'DescuentoGlobal', 'float NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'ImporteBruto', 'money NULL'
GO
if (select version from version) <= 3080
  ALTER TABLE MovImpuesto ALTER COLUMN OrigenModuloID int NULL
GO
EXEC spALTER_TABLE 'MovImpuesto', 'TipoImpuesto1', 'varchar(10) NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'TipoImpuesto2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'TipoImpuesto3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'TipoRetencion1', 'varchar(10) NULL' 
EXEC spALTER_TABLE 'MovImpuesto', 'TipoRetencion2', 'varchar(10) NULL' 
EXEC spALTER_TABLE 'MovImpuesto', 'TipoRetencion3', 'varchar(10) NULL' 
GO

EXEC spALTER_TABLE 'MovImpuesto', 'Impuesto5', 'float NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'Importe5', 'money NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'TipoImpuesto5', 'varchar(10) NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'AplicaModulo', 'varchar(20)'
EXEC spALTER_TABLE 'MovImpuesto', 'AplicaID', 'int'
GO

/****** MovRecibo ******/
if not exists(select * from SysTabla where SysTabla = 'MovRecibo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovRecibo', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovRecibo', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.MovRecibo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovRecibo (
	Modulo			varchar(5)	NOT NULL,
	ModuloID		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	CB			varchar(20)	NULL,
	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	Costo			money		NULL,
	Lote			varchar(20)	NULL,
	Caducidad		datetime	NULL,

	CONSTRAINT priMovRecibo PRIMARY KEY  CLUSTERED (ModuloID, Modulo, ID)
  )
  EXEC spSincroSemilla 'MovRecibo'
END
GO
if (select version from version) <= 2793
BEGIN
  EXEC spEliminarPK 'MovRecibo'
  ALTER TABLE MovRecibo ADD CONSTRAINT priMovRecibo PRIMARY KEY  CLUSTERED (ModuloID, Modulo, ID)
END
GO
EXEC spALTER_COLUMN 'MovRecibo', 'SubCuenta', 'varchar(50) NULL'
GO

EXEC spFK 'MovRecibo','Articulo','Art','Articulo'
GO

/****** MovPresupuesto ******/
if not exists(select * from SysTabla where SysTabla = 'MovPresupuesto')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovPresupuesto', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovPresupuesto', 'Cuenta')
go
if not exists (select * from sysobjects where id = object_id('dbo.MovPresupuesto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovPresupuesto (
	Modulo			varchar(5)	NOT NULL,
	ModuloID		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	CuentaPresupuesto	varchar(20)	NOT NULL,
	Importe			money		NULL, 

	CONSTRAINT priMovPresupuesto PRIMARY KEY  CLUSTERED (ModuloID, Modulo, ID)
  )
  EXEC spSincroSemilla 'MovPresupuesto'
END
GO


/****** MovPersonal ******/
if not exists(select * from SysTabla where SysTabla = 'MovPersonal')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovPersonal', 'Movimiento')
--INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovPersonal', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.MovPersonal') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovPersonal (
	Modulo			varchar(5)	NOT NULL,
	ModuloID		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Personal		varchar(10)	NULL,
	Fecha			datetime	NULL,
	Horas			varchar(5)		NULL,
	Cantidad		float		NULL,

	CONSTRAINT priMovPersonal PRIMARY KEY  CLUSTERED (Modulo, ModuloID, ID)
  )
  EXEC spSincroSemilla 'MovPersonal'
END
GO

EXEC spFK 'MovPersonal','Personal','Personal','Personal'
GO

/******  Indirectos del Movimiento ******/
if not exists(select * from SysTabla where SysTabla = 'MovGastoIndirecto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovGastoIndirecto','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovGastoIndirecto','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.MovGastoIndirecto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovGastoIndirecto (
	Modulo			varchar(5)  	NOT NULL,
	ModuloID		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Concepto		varchar(50)	NULL,
	Porcentaje		float		NULL,

	CONSTRAINT priMovGastoIndirecto PRIMARY KEY  CLUSTERED (ModuloID, Modulo, ID)
  )
  EXEC spSincroSemilla 'MovGastoIndirecto'
END
GO


/******  InfoPathMov ******/
/*if not exists(select * from SysTabla where SysTabla = 'InfoPathMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InfoPathMov','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.InfoPathMov') and type = 'U') 
  CREATE TABLE dbo.InfoPathMov (
	Modulo			varchar(5)  	NOT NULL,
	ID			int		NOT NULL,
	Plantilla		varchar(100)	NOT NULL,

	Datos			text		NULL,
	Usuario			varchar(10)	NULL,
	UltimoCambio		datetime	NULL,

	CONSTRAINT priInfoPathMov PRIMARY KEY  CLUSTERED (ID, Modulo, Plantilla)
)*/
GO
/*if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'InfoPathMov' AND sysindexes.name = 'Plantilla' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Plantilla ON dbo.InfoPathMov (Plantilla)*/
GO

-- drop table MovFormaAnexo
/******  MovFormaAnexo ******/
if not exists(select * from SysTabla where SysTabla = 'MovFormaAnexo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovFormaAnexo','Movimiento')
--INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovFormaAnexo','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovFormaAnexo') and type = 'U') 
  CREATE TABLE dbo.MovFormaAnexo (
	Modulo			varchar(5)  	NOT NULL,
	ID			int		NOT NULL,
	Nombre			varchar(100)	NOT NULL,

	Tipo			varchar(20)	NULL,
	Clave			varchar(100)	NULL,
	Datos			text		NULL,
	Usuario			varchar(10)	NULL,
	UltimoCambio		datetime	NULL,

	CONSTRAINT priMovFormaAnexo PRIMARY KEY  CLUSTERED (ID, Modulo, Nombre)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovFormaAnexo' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre ON dbo.MovFormaAnexo (Nombre)
GO

if exists (select * from sysobjects where id = object_id('dbo.InfoPathMov') and type = 'U') 
BEGIN
  EXEC('INSERT MovFormaAnexo (Modulo, ID, Nombre, Clave, Tipo, Datos, Usuario, UltimoCambio) SELECT Modulo, ID, Plantilla, Plantilla, "InfoPath", Datos, Usuario, UltimoCambio FROM InfoPathMov')
  EXEC spDROP_TABLE 'InfoPathMov'
  EXEC ('DELETE SysTabla WHERE SysTabla = "InfoPathMov"')
END
GO

/****** Registro ******/
/*if not exists(select * from SysTabla where SysTabla = 'Registro')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('Registro', 'Cuenta')*/
/*if not exists (select * from sysobjects where id = object_id('dbo.Registro') and type = 'U') 
BEGIN
CREATE TABLE dbo.Registro (
	ID 			int 		NOT NULL	IDENTITY (1, 1) ,

	Modulo			varchar(5)	NULL,
	ModuloID		int		NULL,
	Mov			varchar(20)	NULL,
	MovID 			varchar(20)	NULL,
	MovTipo 		varchar(20) 	NULL,
	Estatus			varchar(15)	NULL,
	Prioridad		varchar(10)	NULL,
	FechaEmision		datetime 	NULL,

	Empresa 		varchar(5) 	NULL,
	Sucursal 		int		NULL,
	Usuario 		varchar(10) 	NULL,
	Almacen 		varchar(10) 	NULL,
	AlmacenDestino		varchar(10) 	NULL,
	UEN 			int	 	NULL,
	CentroCostos 		varchar(50) 	NULL,
	Proyecto 		varchar(50) 	NULL,
	CtaDinero 		varchar(10) 	NULL,
	CtaDineroDestino	varchar(10) 	NULL,
	Agente			varchar(10) 	NULL,
	Concepto 		varchar(50) 	NULL,
	Referencia 		varchar(50) 	NULL,
	FormaPago 		varchar(50) 	NULL,
	FormaEntrega 		varchar(50) 	NULL,
	Condicion		varchar(50) 	NULL,
	Vencimiento		datetime 	NULL,
	FechaRequerida		datetime 	NULL,
	FechaEntrega		datetime 	NULL,

	Cuenta 			varchar(10) 	NULL,	
	CuentaNombre	 	varchar(100) 	NULL,
	CuentaTipo		varchar(20)	NULL,
	CuentaSubTipo		varchar(20)	NULL,
	CuentaCategoria		varchar(50)	NULL,
	CuentaGrupo		varchar(50)	NULL,
	CuentaFamilia		varchar(50)	NULL,
	CuentaDireccion 	varchar(100) 	NULL,
	CuentaEntreCalles	varchar(100) 	NULL,
	CuentaPlano		varchar(15)     NULL,
	CuentaColonia 		varchar(30) 	NULL,
	CuentaDelegacion	varchar(30) 	NULL,
	CuentaPoblacion 	varchar(30) 	NULL,
	CuentaEstado 		varchar(30) 	NULL,
	CuentaCodigoPostal 	varchar(15) 	NULL,
	CuentaPais 		varchar(30)     NULL,
	CuentaZona 		varchar(30) 	NULL,
	CuentaRuta		varchar(50) 	NULL,

	EnviarA			int		NULL,
	EnviarANombre	 	varchar(100) 	NULL,
	EnviarADireccion 	varchar(100) 	NULL,
	EnviarAEntreCalles	varchar(100) 	NULL,
	EnviarAPlano		varchar(15)     NULL,
	EnviarAColonia 		varchar(30) 	NULL,
	EnviarADelegacion	varchar(30) 	NULL,
	EnviarAPoblacion 	varchar(30) 	NULL,
	EnviarAEstado 		varchar(30) 	NULL,
	EnviarACodigoPostal 	varchar(15) 	NULL,
	EnviarAPais 		varchar(30)     NULL,
	EnviarAZona 		varchar(30) 	NULL,
	EnviarARuta		varchar(50) 	NULL,

	Clase			varchar(50)	NULL,
	SubClase		varchar(50)	NULL,
	Concepto		varchar(50)	NULL,

	Articulo 		varchar(20) 	NULL,
	ArticuloDescripcion	varchar(100) 	NULL,
	ArticuloCategoria	varchar(50)	NULL,
	ArticuloGrupo		varchar(50)	NULL,
	ArticuloFamilia		varchar(50)	NULL,
	ArticuloLinea		varchar(50)	NULL,
	ArticuloFabricante	varchar(50)	NULL,
	SubCuenta 		varchar(50) 	NULL,

	Paquetes		int		NULL,
	Cantidad		float		NULL,
	Unidad 			varchar(50) 	NULL,
	Factor 			float 		NULL,

	Costo			money		NULL,
	Importe			money 		NULL,
	Descuento1		money		NULL,
	Descuento2		money		NULL,
	Impuesto1		money		NULL,
	Impuesto2		money		NULL,
	Impuesto3		money		NULL,
	Retencion1		money		NULL,
	Retencion2		money		NULL,
	Moneda			varchar(10)	NULL,
	TipoCambio 		float 		NULL,

  ) 
  EXEC spSincroSemilla 'Registro'
END*/
GO

/****** Registro ******/
/*if not exists(select * from SysTabla where SysTabla = 'Registro')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('Registro', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Registro') and type = 'U') 
BEGIN
CREATE TABLE dbo.Registro (
	ID 			int 		NOT NULL	IDENTITY(1, 1),

	Sistema			int		NULL,		-- 100 = Contabilidad, 200 = Inventarios, 
	Cuenta			varchar(20)	NULL,
	Empresa 		varchar(5) 	NULL,
	Sucursal 		int		NULL,
	UEN 			int	 	NULL,
	CentroCostos 		varchar(50) 	NULL,
	Proyecto 		varchar(50) 	NULL,
	Usuario 		varchar(10) 	NULL,

	Modulo			varchar(5)	NULL,
	ModuloID		int		NULL,
	Mov			varchar(20)	NULL,
	MovID 			varchar(20)	NULL,
	MovTipo 		varchar(20) 	NULL,
	EsCancelacion		bit		NULL		DEFAULT 0,

	Contacto		varchar(10) 	NULL,
	ContactoTipo		varchar(20) 	NULL,
	EnviarA			int		NULL,

	CtaDinero 		varchar(10) 	NULL,
	Agente			varchar(10) 	NULL,
	Almacen 		varchar(10) 	NULL,

	Clase			varchar(50)	NULL,
	SubClase		varchar(50)	NULL,
	Concepto 		varchar(50) 	NULL,
	Referencia 		varchar(50) 	NULL,
	FormaPago 		varchar(50) 	NULL,
	FormaEntrega 		varchar(50) 	NULL,
	Condicion		varchar(50) 	NULL,

	Vencimiento		datetime 	NULL,
	FechaEmision		datetime 	NULL,
	FechaRequerida		datetime 	NULL,
	FechaEntrega		datetime 	NULL,

	Articulo 		varchar(20) 	NULL,
	SubCuenta 		varchar(50) 	NULL,

	TipoCambio 		float 		NULL,
	Moneda			varchar(10)	NULL,
	Cargo			money		NULL,		-- MN
	Abono			money		NULL,		-- MN

	Factor 			float 		NULL,		-- Factor = 1
	Unidad 			varchar(50) 	NULL,
	Entrada			float		NULL,
	Salida			float		NULL,		-- Factor = 1

	CONSTRAINT priRegistro PRIMARY KEY  CLUSTERED (ID)

  ) 
  EXEC spSincroSemilla 'Registro'
END*/
GO
/*EXEC spALTER_TABLE 'Registro', 'EsCancelacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Registro', 'ContactoTipo', 'varchar(20) NULL'*/
GO
-- Hay que replicar en #Registro

/*if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Registro' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ModuloID ON dbo.Registro (ModuloID, Modulo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Registro' AND sysindexes.name = 'MovID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovID ON dbo.Registro (MovID, Mov, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Registro' AND sysindexes.name = 'Contacto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Contacto ON dbo.Registro (Contacto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Registro' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.Registro (Articulo)*/
GO


/****** MovReg ******/
if not exists(select * from SysTabla where SysTabla = 'MovReg')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovReg', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovReg', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovReg') and type = 'U') 
CREATE TABLE dbo.MovReg (
	Modulo 			varchar(5) 	NOT NULL, 
	ID 			int		NOT NULL, 

	Mov 			varchar(20)	NULL, 
	MovID 			varchar(20)	NULL, 
	Estatus 		varchar(15)	NULL, 
	Sucursal 		int		NULL, 
	UEN 			int		NULL, 
	FechaEmision 		datetime	NULL, 
	Empresa 		varchar(5)	NULL, 
	CtoTipo 		varchar(20)	NULL, 
	Contacto 		varchar(10)	NULL, 
	EnviarA 		int		NULL, 
        Situacion 		varchar(50)	NULL, 
	SituacionFecha 		datetime	NULL, 
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Proyecto 		varchar(50)	NULL, 
	Concepto 		varchar(50)	NULL, 
	Referencia 		varchar(50)	NULL, 
	Usuario 		varchar(10)	NULL, 
	MovTipo 		varchar(20)	NULL, 
	Ejercicio 		int		NULL, 
	Periodo 		int		NULL, 
        FechaCancelacion 	datetime	NULL, 
	Clase 			varchar(50)	NULL, 
	SubClase 		varchar(50)	NULL, 
	Causa 			varchar(50)	NULL, 
	FormaEnvio 		varchar(50)	NULL, 
	Condicion 		varchar(50)	NULL, 
	ZonaImpuesto 		varchar(30)	NULL, 
	CtaDinero 		varchar(10)	NULL, 
        Cajero 			varchar(10)	NULL, 
	Moneda 			varchar(10)	NULL, 
	TipoCambio 		float		NULL, 
	Deudor 			varchar(10)	NULL, 
	Acreedor 		varchar(10)	NULL, 
	Personal 		varchar(10)	NULL, 
	Agente 			varchar(10)	NULL,

	CONSTRAINT priMovReg PRIMARY KEY CLUSTERED (ID, Modulo)
) 
GO
EXEC spALTER_TABLE 'MovReg', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'MovReg', 'SituacionNota', 'varchar(100) NULL'
GO

/****** MovDReg ******/
if not exists(select * from SysTabla where SysTabla = 'MovDReg')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovDReg', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovDReg', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovDReg') and type = 'U') 
CREATE TABLE dbo.MovDReg (
	Modulo 			varchar(5)	NOT NULL, 
	ID 			int		NOT NULL, 
	Renglon 		float		NOT NULL, 
	RenglonSub 		int		NOT NULL, 

	RenglonID 		int		NULL,
	RenglonTipo 		char(1)		NULL, 
	UEN 			int		NULL, 
	Concepto 		varchar(50)	NULL, 
	Personal 		varchar(10)	NULL,
        Almacen 		varchar(10)	NULL, 
	Codigo 			varchar(30)	NULL, 
	Articulo 		varchar(20)	NULL, 
	SubCuenta 		varchar(50)	NULL, 
        Cantidad 		float		NULL, 
	Unidad 			varchar(50)	NULL, 
	Factor 			float		NULL, 
	CantidadInventario 	float		NULL, 
	Costo 			float		NULL, 
	CostoInv 		float		NULL, 
	CostoActividad	 	float		NULL,
        Precio 			float		NULL, 
	DescuentoTipo 		char(1)		NULL, 
	DescuentoLinea 		float		NULL, 
	DescuentoImporte 	money		NULL, 
	Impuesto1 		float		NULL, 
	Impuesto2 		float		NULL, 
	Impuesto3 		float		NULL, 
	Retencion1 		float		NULL, 
	Retencion2 		float		NULL, 
	Retencion3 		float		NULL,
        DescripcionExtra 	varchar(100)	NULL, 
	Paquete 		int		NULL, 
	ContUso 		varchar(20)	NULL, 
	Comision 		money		NULL, 
        Aplica 			varchar(20)	NULL, 
	AplicaID 		varchar(20)	NULL, 
	DestinoTipo 		varchar(10)	NULL, 
	Destino 		varchar(20)	NULL, 
	DestinoID 		varchar(20)	NULL, 
	Cliente 		varchar(10)	NULL, 
	Agente 			varchar(10)	NULL,
        Departamento 		int		NULL, 
	Espacio 		varchar(10)	NULL, 
	Estado 			varchar(30)	NULL, 
	AFArticulo 		varchar(20)	NULL, 
	AFSerie 		varchar(20)	NULL,
        CostoUEPS 		money		NULL, 
	CostoPEPS 		money		NULL, 
	UltimoCosto 		money		NULL, 
	PrecioLista 		money		NULL, 
	Posicion 		varchar(10)	NULL, 
	DepartamentoDetallista 	int		NULL,
        SerieLote 		varchar(50)	NULL, 
	Producto 		varchar(20)	NULL, 
	SubProducto 		varchar(50)	NULL, 
	Merma 			float		NULL, 
	Desperdicio 		float		NULL, 
	Tipo 			varchar(20)	NULL, 
	Ruta 			varchar(20)	NULL, 
        Fecha 			datetime	NULL, 
	Importe 		money		NULL, 
	Porcentaje 		float		NULL, 
	Impuestos 		money		NULL, 
	Provision 		money		NULL, 
	Depreciacion 		money		NULL, 
	DescuentoRecargos 	money		NULL, 
	InteresesOrdinarios 	money		NULL, 
	InteresesMoratorios 	money		NULL, 
        FormaPago 		varchar(50)	NULL, 
	Referencia 		varchar(50)	NULL, 
	Proyecto 		varchar(50)	NULL, 
	Actividad 		varchar(50)	NULL, 
	Cuenta 			varchar(20)	NULL,
	CtoTipo			varchar(20)	NULL, 
	Contacto		varchar(10)	NULL, 
	ObligacionFiscal	varchar(50)	NULL, 
	Tasa			float		NULL, 
	ABC			varchar(50)	NULL, 

	CONSTRAINT priMovDReg PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub, Modulo)
) 
GO
EXEC spALTER_COLUMN 'MovDReg', 'AFSerie', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'MovDReg', 'SerieLote', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'MovDReg', 'CtoTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovDReg', 'Contacto', 'varchar(10) NULL' 
EXEC spALTER_TABLE 'MovDReg', 'ObligacionFiscal', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovDReg', 'Tasa', 'float NULL'
EXEC spALTER_TABLE 'MovDReg', 'ABC', 'varchar(50) NULL'
GO

/****** EventoTipo ******/
if not exists (select * from SysTabla where SysTabla = 'EventoTipo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EventoTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EventoTipo') and type = 'U') 
CREATE TABLE dbo.EventoTipo (
	Tipo			varchar(20)	NOT NULL,

	Icono			int		NULL,
	Orden			int		NULL,
	General			bit		NULL	DEFAULT 0,

	CONSTRAINT priEventoTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO
EXEC spALTER_TABLE 'EventoTipo', 'General', 'bit NULL DEFAULT 0 WITH VALUES'
GO

/****** Estatus ******/
if not exists (select * from SysTabla where SysTabla = 'Estatus') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Estatus','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Estatus') and type = 'U') 
CREATE TABLE dbo.Estatus (
	Estatus			varchar(15)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Icono			int		NULL,

	CONSTRAINT priEstatus PRIMARY KEY  CLUSTERED (Estatus)
)
GO

/****** eDoc ******/
/*if not exists (select * from SysTabla where SysTabla = 'eDoc') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDoc','N/A')*/
/*if not exists (select * from sysobjects where id = object_id('dbo.eDoc') and type = 'U') 
CREATE TABLE dbo.eDoc (
	ID 		int 		NOT NULL	IDENTITY (1,1),

	Fecha		datetime	NULL,
	Serie		varchar(20)	NULL,
	Folio		int		NULL,
	EmisorRFC	varchar(20)	NULL,
	ReceptorRFC	varchar(20)	NULL,
	Empresa		varchar(5)	NULL,
	Modulo		varchar(5)	NULL,
	ModuloID	int		NULL,
	Mov		varchar(20)	NULL,
	MovID		varchar(20)	NULL,

	Documento	text		NULL,

	CONSTRAINT prieDoc PRIMARY KEY  CLUSTERED (ID)
)*/
GO

-- drop table bplan
-- select * from bplan
/****** BPlan ******/
/*if not exists(select * from SysTabla where SysTabla = 'BPlan')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('BPlan', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.BPlan') and type = 'U') 
BEGIN
  CREATE TABLE dbo.BPlan (
	ID		int		NOT NULL IDENTITY(1,1),

	Modulo 		char(5) 	NOT NULL, 
	Empresa		char(5) 	NOT NULL, 
	Ejercicio 	int		NOT NULL, 
	Sucursal 	int		NOT NULL, 
	UEN		int		NULL,

	Articulo	varchar(20)	NULL,
	Concepto	varchar(50)	NULL,
	Personal	varchar(10)	NULL,
	Usuario		varchar(10)	NULL,
	UltimoCambio	datetime	NULL,

	CantidadBase1	float		NULL,	-- Cantidad Neta Periodo
	CantidadBase2	float		NULL,
	CantidadBase3	float		NULL,
	CantidadBase4	float		NULL,
	CantidadBase5	float		NULL,
	CantidadBase6	float		NULL,
	CantidadBase7	float		NULL,
	CantidadBase8	float		NULL,
	CantidadBase9	float		NULL,
	CantidadBase10	float		NULL,
	CantidadBase11	float		NULL,
	CantidadBase12	float		NULL,

	PrecioBase1	money		NULL,	-- Importe Neto / Cantidad Neta
	PrecioBase2	money		NULL,
	PrecioBase3	money		NULL,
	PrecioBase4	money		NULL,
	PrecioBase5	money		NULL,
	PrecioBase6	money		NULL,
	PrecioBase7	money		NULL,
	PrecioBase8	money		NULL,
	PrecioBase9	money		NULL,
	PrecioBase10	money		NULL,
	PrecioBase11	money		NULL,
	PrecioBase12	money		NULL,

	Inc		float		NULL,	-- Moderado
	Inc2		float		NULL,	-- Optimista
	Inc3		float		NULL,	-- Pesimista

	Precio		money		NULL,	-- Precio Promedio Ejercicio, Ultimo Precio, Precio Especifico
	Inf		float		NULL,	-- Inflacion Anual

	Usar		varchar(20)	NULL,	-- Moderado / Optimista / Pesimista

	Cantidad1	float		NULL,	-- Cantidad Presupuesto (Usar)
	Cantidad2	float		NULL,
	Cantidad3	float		NULL,
	Cantidad4	float		NULL,
	Cantidad5	float		NULL,
	Cantidad6	float		NULL,
	Cantidad7	float		NULL,
	Cantidad8	float		NULL,
	Cantidad9	float		NULL,
	Cantidad0	float		NULL,
	Cantidad11	float		NULL,
	Cantidad12	float		NULL,

	Precio1		money		NULL,	-- Precio Presupuesto (Considerando Inflacion)
	Precio2		money		NULL,
	Precio3		money		NULL,
	Precio4		money		NULL,
	Precio5		money		NULL,
	Precio6		money		NULL,
	Precio7		money		NULL,
	Precio8		money		NULL,
	Precio9		money		NULL,
	Precio10	money		NULL,
	Precio11	money		NULL,
	Precio12	money		NULL,

	CONSTRAINT priBPlan PRIMARY KEY CLUSTERED (ID)
  ) 
  EXEC spSincroSemilla 'BPlan'
END*/
GO
/*
EXEC spADD_INDEX 'BPlan', 'Articulo', 'Articulo, Ejercicio, Sucursal, Empresa, Modulo'
EXEC spADD_INDEX 'BPlan', 'Concepto', 'Concepto, Ejercicio, Sucursal, Empresa, Modulo'
EXEC spADD_INDEX 'BPlan', 'Personal', 'Personal, Ejercicio, Sucursal, Empresa, Modulo'*/
GO

/****** ABC ******/
if not exists(select * from SysTabla where SysTabla = 'ABC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ABC', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ABC') and type = 'U') 
  CREATE TABLE dbo.ABC (
	ABC			varchar(50)	NOT NULL,

	CONSTRAINT priABC PRIMARY KEY  CLUSTERED (ABC)
  )
GO

/****** POA ******/
if not exists(select * from SysTabla where SysTabla = 'POA')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POA', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.POA') and type = 'U') 
  CREATE TABLE dbo.POA (
	POA			varchar(50)	NOT NULL,

	CONSTRAINT priPOA PRIMARY KEY  CLUSTERED (POA)
  )
GO


/****** MovGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'MovGrupo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovGrupo', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovGrupo', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.MovGrupo') and type = 'U') 
  CREATE TABLE dbo.MovGrupo (
	Modulo			varchar(5)	NOT NULL,
	ModuloID		int		NOT NULL,

	ABC			varchar(50)	NULL,
	POA			varchar(50)	NULL,
	CentroCostos		varchar(20)	NULL,
	Espacio			varchar(10)	NULL,
	Recurso			varchar(10)	NULL,

	CONSTRAINT priMovGrupo PRIMARY KEY  CLUSTERED (Modulo, ModuloID)
  )
GO

-- drop table TipoImpuesto
/****** TipoImpuesto  ******/
if not exists(select * from SysTabla where SysTabla = 'TipoImpuesto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoImpuesto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoImpuesto') and type = 'U') 
  CREATE TABLE dbo.TipoImpuesto (
	TipoImpuesto		varchar(10)	NOT NULL,

	Tasa			float		NULL,
	Concepto		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,
	CodigoFiscal		varchar(50)	NULL,
	Tipo			varchar(20)	NULL,	-- Impuesto, Retencion
	
	TieneMovimientos	bit		NULL	DEFAULT 0,
	CuentaDeudora		varchar(20)	NULL,
	CuentaAcreedora		varchar(20)	NULL,

	CONSTRAINT priTipoImpuesto PRIMARY KEY  CLUSTERED (TipoImpuesto)
  )
GO
EXEC spRENAME_COLUMN 'TipoImpuesto', 'Porcentaje', 'Tasa'
GO
EXEC spALTER_TABLE 'TipoImpuesto', 'CodigoFiscal', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'TipoImpuesto', 'Tipo', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'TipoImpuesto', 'CuentaDeudora', 'varchar(20) NULL'
EXEC spALTER_TABLE 'TipoImpuesto', 'CuentaAcreedora', 'varchar(20) NULL'
GO

/*** TipoImpuesto1 ***/
if exists (select * from sysobjects where id = object_id('dbo.TipoImpuesto1') and type = 'V') drop view dbo.TipoImpuesto1
GO
CREATE VIEW TipoImpuesto1
--//WITH ENCRYPTION
AS 
SELECT TipoImpuesto, Tasa, Tipo
  FROM TipoImpuesto
 WHERE Tipo='Impuesto 1'
GO

/*** TipoImpuesto2 ***/
if exists (select * from sysobjects where id = object_id('dbo.TipoImpuesto2') and type = 'V') drop view dbo.TipoImpuesto2
GO
CREATE VIEW TipoImpuesto2
--//WITH ENCRYPTION
AS 
SELECT TipoImpuesto, Tasa, Tipo
  FROM TipoImpuesto
 WHERE Tipo='Impuesto 2'
GO

/*** TipoImpuesto3 ***/
if exists (select * from sysobjects where id = object_id('dbo.TipoImpuesto3') and type = 'V') drop view dbo.TipoImpuesto3
GO
CREATE VIEW TipoImpuesto3
--//WITH ENCRYPTION
AS 
SELECT TipoImpuesto, Tasa, Tipo
  FROM TipoImpuesto
 WHERE Tipo='Impuesto 3'
GO
/*** TipoImpuesto4 ***/
if exists (select * from sysobjects where id = object_id('dbo.TipoImpuesto4') and type = 'V') drop view dbo.TipoImpuesto4
GO
CREATE VIEW TipoImpuesto4
--//WITH ENCRYPTION
AS 
SELECT TipoImpuesto, Tasa, Tipo
  FROM TipoImpuesto
 WHERE Tipo='Impuesto 4'
GO
/*** TipoImpuesto5 ***/
if exists (select * from sysobjects where id = object_id('dbo.TipoImpuesto5') and type = 'V') drop view dbo.TipoImpuesto5
GO
CREATE VIEW TipoImpuesto5
--//WITH ENCRYPTION
AS 
SELECT TipoImpuesto, Tasa, Tipo
  FROM TipoImpuesto
 WHERE Tipo='Impuesto 5'
GO
/*** TipoRetencion1 ***/
if exists (select * from sysobjects where id = object_id('dbo.TipoRetencion1') and type = 'V') drop view dbo.TipoRetencion1
GO
CREATE VIEW TipoRetencion1
--//WITH ENCRYPTION
AS 
SELECT TipoImpuesto AS TipoRetencion, Tasa, Tipo
  FROM TipoImpuesto
 WHERE Tipo='Retencion 1'
GO

/*** TipoRetencion2 ***/
if exists (select * from sysobjects where id = object_id('dbo.TipoRetencion2') and type = 'V') drop view dbo.TipoRetencion2
GO
CREATE VIEW TipoRetencion2
--//WITH ENCRYPTION
AS 
SELECT TipoImpuesto AS TipoRetencion, Tasa, Tipo
  FROM TipoImpuesto
 WHERE Tipo='Retencion 2'
GO

/*** TipoRetencion3 ***/
if exists (select * from sysobjects where id = object_id('dbo.TipoRetencion3') and type = 'V') drop view dbo.TipoRetencion3
GO
CREATE VIEW TipoRetencion3
--//WITH ENCRYPTION
AS 
SELECT TipoImpuesto AS TipoRetencion, Tasa, Tipo
  FROM TipoImpuesto
 WHERE Tipo='Retencion 3'
GO

-- al cerrar el dia actualizar TipoImpuesto si entra en vigor un cambio
/****** TipoImpuestoD  ******/
if not exists(select * from SysTabla where SysTabla = 'TipoImpuestoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoImpuestoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoImpuestoD') and type = 'U') 
  CREATE TABLE dbo.TipoImpuestoD (
	TipoImpuesto		varchar(10)	NOT NULL,
	FechaD			datetime	NOT NULL,

	FechaA			datetime	NULL,
	Tasa			float		NULL,
	Concepto		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,
	TieneMovimientos	bit		NULL	Default 0,
	
	CONSTRAINT priTipoImpuestoD PRIMARY KEY  CLUSTERED (TipoImpuesto, FechaD)
  )
GO
EXEC spRENAME_COLUMN 'TipoImpuestoD', 'Porcentaje', 'Tasa'
GO
EXEC spALTER_TABLE 'TipoImpuestoD', 'CodigoFiscal', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'TipoImpuestoD', 'TieneMovimientos', 'bit NULL Default 0'
GO


if exists (select * from sysobjects where id = object_id('dbo.tgTipoImpuestoAB') and sysstat & 0xf = 8) drop trigger dbo.tgTipoImpuestoAB
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgTipoImpuestoAB ON TipoImpuesto
--//WITH ENCRYPTION
FOR INSERT, DELETE
AS BEGIN
  DECLARE
    @TipoImpuestoN	varchar(10),
    @TipoImpuestoA	varchar(10),
    @FechaHoy		datetime

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @FechaHoy = GETDATE()
  EXEC spExtraerFecha @FechaHoy OUTPUT

  SELECT 
    @TipoImpuestoN = TipoImpuesto
    FROM Inserted

  SELECT 
    @TipoImpuestoA = TipoImpuesto
    FROM Deleted

  IF @TipoImpuestoA IS NULL AND  @TipoImpuestoN IS NOT NULL
    INSERT TipoImpuestoD (TipoImpuesto,FechaD,FechaA,Tasa,Concepto,Referencia,CodigoFiscal,TieneMovimientos)
    SELECT TipoImpuesto,@FechaHoy,NULL,Tasa,Concepto,Referencia,CodigoFiscal,1
      FROM Inserted
  ELSE IF @TipoImpuestoA IS NOT NULL AND  @TipoImpuestoN IS NULL
    DELETE TipoImpuestoD WHERE TipoImpuesto = @TipoImpuestoA
END
GO

/****** FiscalZona  ******/ --MEJORA4769
if not exists(select * from SysTabla where SysTabla = 'FiscalZona')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FiscalZona','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FiscalZona') and type = 'U') 
  CREATE TABLE dbo.FiscalZona (
	FiscalZona		varchar(30)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	
	CONSTRAINT priFiscalZona PRIMARY KEY  CLUSTERED (FiscalZona)
)
GO

/****** FiscalRegimen  ******/
if not exists(select * from SysTabla where SysTabla = 'FiscalRegimen')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FiscalRegimen','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FiscalRegimen') and type = 'U') 
  CREATE TABLE dbo.FiscalRegimen (
	FiscalRegimen		varchar(30)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	Extranjero		bit		NULL	DEFAULT 0,
	
	CONSTRAINT priFiscalRegimen PRIMARY KEY  CLUSTERED (FiscalRegimen)
)
GO

EXEC spALTER_TABLE 'FiscalRegimen', 'Extranjero', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'FiscalRegimen', 'TipoPersonaFisica', 'varchar(2) NULL'
EXEC spALTER_TABLE 'FiscalRegimen', 'TipoPersonaMoral',  'varchar(2) NULL'
GO

--Integración CRM
EXEC spAlter_Table 'FiscalRegimen', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'FiscalRegimen', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_FiscalRegimen', 'TR') IS NOT NULL DROP TRIGGER tr_FiscalRegimen
GO									
/*CREATE TRIGGER tr_FiscalRegimen ON FiscalRegimen 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update FiscalRegimen  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.FiscalRegimen= FiscalRegimen.FiscalRegimen
	END
END
GO*/

-- drop table FiscalRegimenRegla
/****** FiscalRegimenRegla  ******/
if not exists(select * from SysTabla where SysTabla = 'FiscalRegimenRegla')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FiscalRegimenRegla','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FiscalRegimenRegla') and type = 'U') 
BEGIN
  CREATE TABLE dbo.FiscalRegimenRegla (
	ID			int		IDENTITY(1,1) NOT NULL,
	
	Nombre					varchar(100)	NULL,
	Descripcion				varchar(255)	NULL,
	
	VigenciaD				datetime	NULL,
	VigenciaA				datetime	NULL,
	Estatus					varchar(15)	NULL,		-- ALTA, BLOQUEADO, BAJA

	Modulo					varchar(5)	NULL,
	Mov						varchar(20)	NULL,
	FiscalRegimenEmpresa	varchar(30)	NULL,
	FiscalRegimenCliente	varchar(30)	NULL,
	FiscalRegimenProveedor	varchar(30)	NULL,
	
	TipoImpuesto			varchar(20)	NULL,
	TipoImpuestoNuevo		varchar(20)	NULL,

	FiscalZonaEmpresa		varchar(30)	NULL, --MEJORA4769
	FiscalZonaCliente		varchar(30)	NULL, --MEJORA4769
	FiscalZonaProveedor		varchar(30)	NULL, --MEJORA4769
	
	CONSTRAINT priFiscalRegimenRegla PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'FiscalRegimenRegla'
END
GO
EXEC spADD_INDEX 'FiscalRegimenRegla', 'TipoImpuesto', 'TipoImpuesto, Estatus, VigenciaD, VigenciaA'
GO
EXEC spALTER_TABLE 'FiscalRegimenRegla', 'Modulo', 'varchar(5) NULL'
EXEC spALTER_TABLE 'FiscalRegimenRegla', 'Mov', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'FiscalRegimenRegla', 'TipoImpuesto', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'FiscalRegimenRegla', 'TipoImpuestoNuevo', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'FiscalRegimenRegla', 'FiscalZonaEmpresa', 'varchar(30) NULL' --MEJORA4769
EXEC spALTER_TABLE 'FiscalRegimenRegla', 'FiscalZonaCliente', 'varchar(30) NULL' --MEJORA4769
EXEC spALTER_TABLE 'FiscalRegimenRegla', 'FiscalZonaProveedor', 'varchar(30) NULL' --MEJORA4769
GO

/****** NominaConceptoEx ******/
--DSG
if not exists(select * from SysTabla where SysTabla = 'NominaConceptoEx')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NominaConceptoEx','Maestro')

if (SELECT SubVersion FROM Version) < '5000.v0.25'
  if exists (select * from sysobjects where id = object_id('dbo.NominaConceptoEx') and type = 'U') 
    DROP TABLE NominaConceptoEx 
GO
if not exists (select * from sysobjects where id = object_id('dbo.NominaConceptoEx') and type = 'U') --drop table NominaConceptoEx 
  CREATE TABLE NominaConceptoEx (
                              Clave             VARCHAR(100),
                              Objeto            VARCHAR(100),
                              IDNomX            INT,
					                    Concepto          VARCHAR(100)  NULL,
                              Tipo              VARCHAR(30),                              
                              Orden             INT           NULL,
                              Ocultar           VARCHAR(10)   NULL,
                              TipoDato          VARCHAR(20)   NULL,
                              Concepto2         VARCHAR(255)  NULL,
                              EnCero            VARCHAR(10)   NULL,
                              Grupo             VARCHAR(100)  NULL,
                              Vinculo           VARCHAR(100)  NULL,
                              ClaveFiscal       VARCHAR(20)   NULL,
                              Cuenta            VARCHAR(20)   NULL,
                              Cuenta2           VARCHAR(20)   NULL,
                              TipoNominaG4      VARCHAR(50)   NULL,
                              AcumuladoClave    VARCHAR(100)  NULL,
                              AcumuladoObjeto   VARCHAR(100)  NULL,
                              AplicaCalendario  VARCHAR(50)   NULL,
                              AcreedorPropiedad VARCHAR(50)   NULL,
                              TipoCuenta        VARCHAR(50)   NULL,
                              CuentaEspecifica  VARCHAR(50)   NULL,
                              TipoAgrupador     VARCHAR(50)   NULL,
  CONSTRAINT priNominaConceptoEx PRIMARY KEY CLUSTERED (Clave, Objeto, IDNomX)
                         )
GO


EXEC spALTER_TABLE 'NominaConceptoEx', 'TipoNominaG4',      'varchar(50)  NULL'
EXEC spALTER_TABLE 'NominaConceptoEx', 'AcumuladoClave',    'varchar(100) NULL'
EXEC spALTER_TABLE 'NominaConceptoEx', 'AcumuladoObjeto',   'varchar(100) NULL'
EXEC spALTER_TABLE 'NominaConceptoEx', 'AplicaCalendario',  'varchar(50)  NULL'
EXEC spALTER_TABLE 'NominaConceptoEx', 'AcreedorPropiedad', 'varchar(50)  NULL'
GO
EXEC spALTER_TABLE 'NominaConceptoEx', 'TipoCuenta',        'varchar(50)  NULL'
EXEC spALTER_TABLE 'NominaConceptoEx', 'CuentaEspecifica',  'varchar(50)  NULL'
EXEC spALTER_TABLE 'NominaConceptoEx', 'TipoAgrupador',     'varchar(50)  NULL'
EXEC spALTER_TABLE 'NominaConceptoEx', 'Obligatorio',       'bit NULL DEFAULT 0 WITH VALUES'
EXEC spADD_INDEX 'NominaConceptoEx', 'Compuesto', 'Objeto, Ocultar, Clave) INCLUDE(Concepto, CuentaEspecifica'
GO

if (SELECT SubVersion FROM Version) < '5000.v0.25'
  if exists (select * from sysobjects where id = object_id('dbo.NominaG4TablaCuentas') and type = 'U') 
    drop table NominaG4TablaCuentas 
GO
if not exists (select * from sysobjects where id = object_id('dbo.NominaG4TablaCuentas') and type = 'U') --drop table NominaG4TablaCuentas 
  CREATE TABLE NominaG4TablaCuentas (
                              Clave           VARCHAR(100),
                              Objeto          VARCHAR(100),
                              IDNomX          INT,
                              TipoAgrupador   VARCHAR(50),
                              Valor           VARCHAR(100),
                              Cuenta          VARCHAR(50),  

  CONSTRAINT priNominaG4TablaCuentas PRIMARY KEY CLUSTERED (Clave, Objeto, IDNomX, TipoAgrupador, Valor)
                         )
GO

if not exists (select * from sysobjects where id = object_id('dbo.NominaConceptosG4') and type = 'U') --drop table NominaConceptosG4 
  CREATE TABLE NominaConceptosG4 (
    ID        INT IDENTITY,
    Estacion  INT,
    Clave     VARCHAR(100),
    Tipo      VARCHAR(30),
    Objeto    VARCHAR(100),
    Orden     INT           NULL,
    Ocultar   VARCHAR(10)   NULL,
    TipoDato  VARCHAR(20)   NULL,
    Concepto2 VARCHAR(255)  NULL,
    EnCero    VARCHAR(10)   NULL,
    Grupo     VARCHAR(100)  NULL,
    CONSTRAINT priNominaConceptosG4 PRIMARY KEY CLUSTERED (ID)
    )
GO


if (SELECT SubVersion FROM Version) < '5000.v0.26'
  if exists (select * from sysobjects where id = object_id('dbo.NominaEmpresaPropiedadG4') and type = 'U') 
    drop table NominaEmpresaPropiedadG4 
GO
if not exists (select * from sysobjects where id = object_id('dbo.NominaEmpresaPropiedadG4') and type = 'U') --drop table NominaEmpresaPropiedadG4 
  CREATE TABLE NominaEmpresaPropiedadG4 (
    Estacion  INT,
    element1  varchar(50),
    element2  varchar(50),
    value     varchar(50),
    CONSTRAINT priNominaEmpresaPropiedadG4 PRIMARY KEY CLUSTERED (Estacion, element1, element2)
    )
GO

if (SELECT SubVersion FROM Version) < '5000.v0.26'
  if exists (select * from sysobjects where id = object_id('dbo.NominaPersonalPropiedadG4') and type = 'U') 
    drop table NominaPersonalPropiedadG4 
GO
if not exists (select * from sysobjects where id = object_id('dbo.NominaPersonalPropiedadG4') and type = 'U') --drop table NominaPersonalPropiedadG4 
  CREATE TABLE NominaPersonalPropiedadG4 (
    Estacion  INT,
    element1  varchar(50),
    element2  varchar(50),
    value     varchar(50),
    CONSTRAINT priNominaPersonalPropiedadG4 PRIMARY KEY CLUSTERED (Estacion, element1, element2)
    )
GO

if (SELECT SubVersion FROM Version) < '5000.v0.26'
  if exists (select * from sysobjects where id = object_id('dbo.NominaIncidenciaG4') and type = 'U') 
    drop table NominaIncidenciaG4 
GO
if not exists (select * from sysobjects where id = object_id('dbo.NominaIncidenciaG4') and type = 'U') --drop table NominaIncidenciaG4 
  CREATE TABLE NominaIncidenciaG4 (
    Estacion  INT,
    element1  varchar(50),
    element2  varchar(50),
    value     varchar(50),
    CONSTRAINT priNominaIncidenciaG4 PRIMARY KEY CLUSTERED (Estacion, element1, element2)
    )
GO

if not exists (select * from sysobjects where id = object_id('dbo.NominaAcumuladoInicial') and type = 'U') --drop table NominaAcumuladoInicial 
  CREATE TABLE NominaAcumuladoInicial (
    Estacion  INT,
    _id       VARCHAR(10),
    Acumulado VARCHAR(100),
    Importe   VARCHAR(50) NULL,  
    CONSTRAINT priNominaAcumuladoInicial PRIMARY KEY CLUSTERED (Estacion, _id, Acumulado)
    )

GO

if not exists (select * from sysobjects where id = object_id('dbo.PersonalIncidenciaG4') and type = 'U') --drop table PersonalIncidenciaG4 
  CREATE TABLE PersonalIncidenciaG4 (
    Estacion                        INT,
    _id                             VARCHAR(10), 
   CONSTRAINT priPersonalIncidenciaG4 PRIMARY KEY CLUSTERED (Estacion, _id)
    )
GO

if (SELECT SubVersion FROM Version) < '5000.v0.29'
  if exists (select * from sysobjects where id = object_id('dbo.NominaG4CFG') and type = 'U') 
    drop table NominaG4CFG 
if not exists (select * from sysobjects where id = object_id('dbo.NominaG4CFG') and type = 'U') --drop table NominaG4CFG 
  CREATE TABLE NominaG4CFG (
    ID                      INT IDENTITY,    
    Modulo                  VARCHAR(100) NULL,
    NombreCSV               VARCHAR(200) NULL,
    Qry                     VARCHAR(MAX) NULL,
    Params                  VARCHAR(MAX) NULL,
    Estatus                 bit          DEFAULT 0,    
   CONSTRAINT priNominaG4CFG PRIMARY KEY CLUSTERED (ID)
    )
GO

if not exists (select * from sysobjects where id = object_id('dbo.ServiciosG3') and type = 'U') --drop table ServiciosG3 
  CREATE TABLE ServiciosG3 (
    ID                      INT IDENTITY,
    Servicio                VARCHAR(100),
    Empresa                 VARCHAR(5),
    Modulo                  VARCHAR(100) NULL,
    Estatus                 BIT          DEFAULT 0,    
   CONSTRAINT priServiciosG3 PRIMARY KEY CLUSTERED (ID)
    )
GO
EXEC spALTER_TABLE 'ServiciosG3', 'URL',                          'varchar(255) NULL'
EXEC spALTER_TABLE 'ServiciosG3', 'API',                          'varchar(100) NULL'
EXEC spALTER_TABLE 'ServiciosG3', 'DirectorioObjetosEspeciales',  'varchar(255) NULL'
EXEC spALTER_TABLE 'ServiciosG3', 'DirectorioArchivosZip',        'varchar(255) NULL'
EXEC spALTER_TABLE 'ServiciosG3', 'Debug',                        'bit NULL DEFAULT 0 WITH VALUES'
GO

if not exists (select * from sysobjects where id = object_id('dbo.ServiciosG3Detalle') and type = 'U') --drop table ServiciosG3Detalle 
  CREATE TABLE ServiciosG3Detalle (
    ID                      INT,
    IdArchivosCSV           INT,
    Estatus                 BIT          DEFAULT 0,    
   CONSTRAINT priServiciosG3Detalle PRIMARY KEY CLUSTERED (ID, IdArchivosCSV)
    )
GO


if not exists (select * from sysobjects where id = object_id('dbo.OutputNominaG4') and type = 'U') --drop table OutputNominaG4 
  CREATE TABLE OutputNominaG4(
    ID          INT IDENTITY,
    Estacion    INT          NULL,    
    Personal    VARCHAR(100), 
    Cuenta      VARCHAR(100) NULL,
    Importe     VARCHAR(100) NULL,
    Cantidad    VARCHAR(100) NULL,
    Concepto    VARCHAR(100),
    Movimiento  VARCHAR(100) NULL,
    Fecha       VARCHAR(100) NULL,
    Grupo       VARCHAR(50)  NULL,
    Objeto      VARCHAR(100) NULL,
    CONSTRAINT priOutputNominaG4 PRIMARY KEY CLUSTERED (ID)
    )
GO
EXEC spALTER_TABLE 'OutputNominaG4', 'Objeto',  'varchar(100) NULL'
EXEC spALTER_TABLE 'OutputNominaG4', 'OK',      'INT NULL'
EXEC spALTER_TABLE 'OutputNominaG4', 'Renglon', 'INT NULL'
EXEC spADD_INDEX 'OutputNominaG4', 'OutputNominaG4', 'Estacion, Personal, Objeto) INCLUDE(Importe, Cantidad, Concepto, Fecha, Grupo, Renglon'

GO

if not exists (select * from sysobjects where id = object_id('dbo.NominaG4Calendario') and type = 'U') --drop table NominaG4Calendario 
  CREATE TABLE NominaG4Calendario (
    ID                  INT IDENTITY, 
    TipoPeriodo         VARCHAR(50), 
    Tiempo              DATETIME, 
    Primera             VARCHAR(2)  NULL, 
    Ultima              VARCHAR(2)  NULL, 
    Clave               VARCHAR(50) NULL, 
    Ejercicio           INT         NULL, 
    Periodo             INT         NULL, 
    Bimestre            INT         NULL, 
    Quincena            INT         NULL, 
    Inicio              DATETIME    NULL, 
    Fin                 DATETIME    NULL, 
    Dias                INT         NULL, 
    PrimerDia           INT         NULL, 
    UltimoDia           INT         NULL, 
    SigInicio           DATETIME    NULL, 
    SigFin              DATETIME    NULL, 
    FinBimestre         VARCHAR(2)  NULL, 
    FinAno              VARCHAR(2)  NULL, 
    FechaInicioBimestre DATETIME    NULL, 
    FechaFinBimestre    DATETIME    NULL
    CONSTRAINT priNominaG4Calendario PRIMARY KEY CLUSTERED (ID)
    )

GO
EXEC spADD_INDEX 'PersonalPropValor', 'RamaPropiedad', 'Rama, Propiedad) INCLUDE(Cuenta, Valor'
GO

if not exists (select * from sysobjects where id = object_id('dbo.NominaG4CargaPersonal') and type = 'U') --drop table NominaG4CargaPersonal 
  CREATE TABLE NominaG4CargaPersonal(    
    Estacion      INT,    
    Personal      VARCHAR(10) NULL,      
    Tipo          VARCHAR(20) NULL,
    SucursalT     INT NULL,
    Categoria     VARCHAR(50) NULL,
    Grupo         VARCHAR(50) NULL,
    Departamento  VARCHAR(50) NULL,
    Area          VARCHAR(50) NULL,
    CentroCostos  VARCHAR(20) NULL,
    Moneda        VARCHAR(10) NULL,
    CONSTRAINT priNominaG4CargaPersonal PRIMARY KEY CLUSTERED (Estacion)
    )
GO

if not exists (select * from sysobjects where id = object_id('dbo.NominaG4ErroresCFG') and type = 'U') --drop table NominaG4ErroresCFG 
  CREATE TABLE NominaG4ErroresCFG(    
    Estacion      INT,        
    Rama          VARCHAR(5)   NULL,
    Cuenta        varchar(50)  NULL,
    Propiedad     VARCHAR(50)  NULL,    
    Valor         VARCHAR(50)  NULL,    
    Descripcion   VARCHAR(255) NULL,          
    )
GO

if not exists (select * from sysobjects where id = object_id('dbo.NominaPersonalG4') and type = 'U') --drop table NominaPersonalG4 
  CREATE TABLE NominaPersonalG4 (    
    Estacion        INT,
    Personal        VARCHAR(10),
    Sindicato       VARCHAR(50) NULL,
    FechaAntiguedad VARCHAR(10) NULL,
    FechaAlta       VARCHAR(10) NULL,
    PeriodoTipo     VARCHAR(50) NULL,
    UltimoPago      VARCHAR(10) NULL,
    FechaBaja       VARCHAR(10) NULL,
    SueldoMensual   MONEY       NULL,
    Empresa         VARCHAR(5)  NULL,
    CONSTRAINT priNominaPersonalG4 PRIMARY KEY CLUSTERED (Estacion, Personal)
    )
GO

if not exists (select * from sysobjects where id = object_id('dbo.ServicioJSON') and type = 'U') --drop table ServicioJSON 
  CREATE TABLE ServicioJSON (    
    Estacion  INT,
    Dato      VARCHAR(4000),
    CONSTRAINT priServicioJSON PRIMARY KEY CLUSTERED (Estacion)
    )
GO

if not exists (select * from sysobjects where id = object_id('dbo.NominaG4Vacaciones') and type = 'U') --drop table NominaG4Vacaciones 
  CREATE TABLE NominaG4Vacaciones (        
    TipoSindicato VARCHAR(25),
    Descripcion   VARCHAR(100) NULL,
    CONSTRAINT priNominaG4Vacaciones PRIMARY KEY CLUSTERED (TipoSindicato)
    )
GO

if not exists (select * from sysobjects where id = object_id('dbo.NominaG4VacacionesD') and type = 'U') --drop table NominaG4VacacionesD 
  CREATE TABLE NominaG4VacacionesD (        
    TipoSindicato   VARCHAR(25),
    Antiguedad      FLOAT,
    Vacaciones      FLOAT NULL,
    PrimaVacacional FLOAT NULL,
    Aguinaldo       FLOAT NULL,
    CONSTRAINT priNominaG4VacacionesD PRIMARY KEY CLUSTERED (TipoSindicato, Antiguedad)
    )
GO

if exists (select * from sysobjects where id = object_id('dbo.PlugInInt') and type = 'U') 
  drop table PlugInInt
GO

if not exists (select * from sysobjects where id = object_id('dbo.PlugInInt') and type = 'U')
  CREATE TABLE PlugInInt (        
    IdIntelisis     VARCHAR(100), 
    PlugIn          VARCHAR(100),
	Ejecutable      VARCHAR(100),
    SubVersion      VARCHAR(100),
	PlugInKey       VARCHAR(255),
    CONSTRAINT priPlugInInt PRIMARY KEY CLUSTERED (IdIntelisis, PlugIn)
    )
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.VersionLista') AND TYPE = 'U')
CREATE TABLE VersionLista (
	Nombre varchar(50) NOT NULL,
	Valor varchar(255),
	Visible bit,
	CONSTRAINT priVersionLista PRIMARY KEY (Nombre)
)
GO

--DSG

/****** Comprobante Nómina ******/
if not exists(select * from SysTabla where SysTabla = 'AnexoMovComprobante')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AnexoMovComprobante','Movimiento')

if not exists (select * from sysobjects where id = object_id('dbo.AnexoMovComprobante') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AnexoMovComprobante (
	Rama			varchar(5)	NOT NULL,
	ID				int 		NOT NULL,
    MovId			int			NOT NULL,
	Estatus			bit			NOT NULL,
	FechaDescarga	datetime    NOT NULL

	CONSTRAINT priAnexoMovComprobante PRIMARY KEY CLUSTERED (ID, Rama, MovId)
  )
  ALTER TABLE AnexoMovComprobante ADD CONSTRAINT DF_AnexoMovComprobante DEFAULT GETDATE() FOR FechaDescarga
END
GO

PRINT "******************* Generales ******************"
GO



