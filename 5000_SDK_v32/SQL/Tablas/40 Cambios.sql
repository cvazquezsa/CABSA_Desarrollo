/*******************************************************************************************/
/*                                           CAMBIO                                        */
/*******************************************************************************************/

/****** Consecutivos ******/
if not exists (select * from SysTabla where SysTabla = 'CambioC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CambioC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CambioC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CambioC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCambioC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CambioC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'CambioC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE CambioC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE CambioC ALTER COLUMN Mov     char(20) NULL")
END
GO

/****** Bitacora ******/
if (select version from version)<=1405 delete systabla where systabla = 'CambioBitacora'
go
if not exists (select * from SysTabla where SysTabla = 'CambioBitacora') 
INSERT INTO SysTabla (SysTabla) VALUES ('CambioBitacora')
if not exists (select * from sysobjects where id = object_id('dbo.CambioBitacora') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CambioBitacora (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	CambioID		int		NULL,
	Usuario			varchar(10)	NULL,
	Fecha			datetime	NULL,
	Accion			varchar(50)	NULL,
	Observaciones		varchar(100)	NULL,
	ValorAnterior		varchar(50)	NULL,
	ValorNuevo		varchar(50)	NULL,

	CONSTRAINT priCambioBitacora PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CambioBitacora'
END
go
EXEC spALTER_TABLE 'CambioBitacora', 'Observaciones', 'varchar(100) NULL'
GO

EXEC spFK 'CambioBitacora','Usuario','Usuario','Usuario'
EXEC spFK 'CambioBitacora','CambioID','Cambio','ID'
GO

/****** Movimientos ******/
if not exists (select * from SysTabla where SysTabla = 'Cambio') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Cambio','Movimiento','CAM')
if not exists (select * from sysobjects where id = object_id('dbo.Cambio') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Cambio (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
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

	Cliente			char(10)	NOT NULL,
	ClienteEnviarA		int		NULL,
	FormaEnvio		varchar(50)	NULL,
	Ruta			varchar(50)	NULL,
	Agente			char(10)	NULL,
	Condicion		varchar(50)	NOT NULL,
	Vencimiento		datetime	NULL,

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

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	CandidatoInsusual	bit		NOT NULL DEFAULT 0,	-- X
	Preocupante		bit		NOT NULL DEFAULT 0,	-- P
	Insusual		bit		NOT NULL DEFAULT 0,	-- I
	Relevante		bit		NOT NULL DEFAULT 0,	-- R
	ParaisoFiscal		bit		NOT NULL DEFAULT 0,	-- F
	CiudadRiesgo		bit		NOT NULL DEFAULT 0,	-- C
	UsuarioNormatividad	char(10)	NULL,
	ObservacionesNormatividad varchar(100)	NULL,

	ImporteVentaUS		money		NULL,
	ImporteCompraUS		money		NULL,

	ImporteMN		money		NULL,
	DeTerceros		float		NULL,

	CONSTRAINT priCambio PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Cambio'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Cambio'
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCambioAC') and sysstat & 0xf = 8) drop trigger dbo.tgCambioAC
go
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Cambio.Consecutivo
  ALTER TABLE Cambio ALTER COLUMN MovID varchar(20)
  ALTER TABLE Cambio ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Cambio ALTER COLUMN PolizaID varchar(20)
END
EXEC spModificarPK_Mov 'Cambio'
GO

-- Cambio
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'Cliente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cliente 	    ON dbo.Cambio (Cliente)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Cambio (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Cambio (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Cambio (Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Cambio (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Cambio (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Cambio (ContID)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cambio.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cambio.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cambio.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cambio.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cambio.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Cambio (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Cambio (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cambio' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Cambio (OrigenID,Origen,Empresa)
go

EXEC spRENAME_COLUMN 'Cambio', 'Logico9', 'CiudadRiesgo'
EXEC spRENAME_COLUMN 'Cambio', 'Logico8', 'ParaisoFiscal'
EXEC spRENAME_COLUMN 'Cambio', 'Logico7', 'Relevante'
EXEC spRENAME_COLUMN 'Cambio', 'Logico6', 'Insusual'
EXEC spRENAME_COLUMN 'Cambio', 'Logico5', 'Preocupante'
EXEC spRENAME_COLUMN 'Cambio', 'Logico4', 'CandidatoInsusual'
EXEC spALTER_TABLE 'Cambio', 'UsuarioNormatividad', 'char(10) NULL'
EXEC spALTER_TABLE 'Cambio', 'ObservacionesNormatividad', 'varchar(100)	NULL'
EXEC spALTER_TABLE 'Cambio', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Cambio', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cambio', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cambio', 'ClienteEnviarA', 'int NULL'
EXEC spALTER_TABLE 'Cambio', 'FormaEnvio', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Cambio', 'ImporteVentaUS', 'money NULL'
EXEC spALTER_TABLE 'Cambio', 'ImporteCompraUS', 'money NULL'
EXEC spALTER_TABLE 'Cambio', 'ImporteMN', 'money NULL'
EXEC spALTER_TABLE 'Cambio', 'DeTerceros', 'float NULL'
GO

EXEC spFK 'Cambio','UEN','UEN','UEN'
GO

/*
CREATE TRIGGER tgCambioAC ON Cambio
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @ID				int,
    @Usuario			char(10),
    @Observaciones		varchar(100),
    @PreocupanteN		bit,	-- P
    @PreocupanteA		bit,	-- P
    @InsusualN			bit,	-- I
    @InsusualA			bit,	-- I
    @RelevanteN			bit,	-- R
    @RelevanteA			bit,	-- R
    @ParaisoFiscalN		bit,	-- F
    @ParaisoFiscalA		bit,	-- F
    @CiudadRiesgoN		bit,	-- C
    @CiudadRiesgoA		bit,	-- C
    @ValorAnterior		varchar(50),
    @ValorNuevo			varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ValorAnterior = '', @ValorNuevo = ''


  IF (SELECT Preocupante   	FROM DELETED) = 1 	SELECT @ValorAnterior = @ValorAnterior + 'P'
  IF (SELECT Insusual 	   	FROM DELETED) = 1 	SELECT @ValorAnterior = @ValorAnterior + 'I'
  IF (SELECT CandidatoInsusual  FROM DELETED) = 1 	SELECT @ValorAnterior = @ValorAnterior + 'X'
  IF (SELECT Relevante 	   	FROM DELETED) = 1 	SELECT @ValorAnterior = @ValorAnterior + 'R'
  IF (SELECT ParaisoFiscal 	FROM DELETED) = 1 	SELECT @ValorAnterior = @ValorAnterior + 'F'
  IF (SELECT CiudadRiesgo  	FROM DELETED) = 1 	SELECT @ValorAnterior = @ValorAnterior + 'C'

  IF (SELECT Preocupante   	FROM INSERTED) = 1 	SELECT @ValorNuevo = @ValorNuevo + 'P'
  IF (SELECT Insusual      	FROM INSERTED) = 1 	SELECT @ValorNuevo = @ValorNuevo + 'I'
  IF (SELECT CandidatoInsusual  FROM INSERTED) = 1 	SELECT @ValorNuevo = @ValorNuevo + 'X'
  IF (SELECT Relevante     	FROM INSERTED) = 1 	SELECT @ValorNuevo = @ValorNuevo + 'R'
  IF (SELECT ParaisoFiscal 	FROM INSERTED) = 1 	SELECT @ValorNuevo = @ValorNuevo + 'F'
  IF (SELECT CiudadRiesgo  	FROM INSERTED) = 1 	SELECT @ValorNuevo = @ValorNuevo + 'C'

  SELECT @ID = ID, @Usuario = UsuarioNormatividad, @Observaciones = ObservacionesNormatividad FROM INSERTED

  IF @ValorAnterior <> @ValorNuevo
    INSERT CambioBitacora (CambioID, Usuario, Fecha, Accion, ValorAnterior, ValorNuevo, Observaciones) VALUES (@ID, @Usuario, GETDATE(), 'Normatividad', @ValorAnterior, @ValorNuevo, @Observaciones)
END*/
GO

/****** Movimientos (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'CambioD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CambioD','Movimiento','CAM')
if not exists (select * from sysobjects where id = object_id('dbo.CambioD') and type = 'U') 
CREATE TABLE dbo.CambioD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,
	RenglonSub		int		NOT NULL   DEFAULT 0,

	Tipo			varchar(20)	NOT NULL,  -- Compra/Venta/Cobro/Pago
	Instrumento	        char(10) 	NOT NULL,
	Monto			money		NULL,
	TipoCambio		float		NULL,
	Cobertura		float		NULL,
	CoberturaAfectacion	float		NULL,
	Beneficiario		int		NULL,
	Observaciones		varchar(60)	NULL,                   

        GeneroModulo		char(5)		NULL,
	GeneroMov		char(20)	NULL,
	GeneroMovID		varchar(20)	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	UsuarioCobertura	char(10)	NULL,
	MontoDolares		money		NULL,
	Folio			int		NULL,
	Relevante		bit		NULL    DEFAULT 0,
	Plazo			int		NULL,
	Tasa			float		NULL,

	CONSTRAINT priCambioD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCambioDAC') and sysstat & 0xf = 8) drop trigger dbo.tgCambioDAC
go
if (select version from version) <= 1095
  ALTER TABLE CambioD ALTER COLUMN GeneroMovID varchar(20)
go
EXEC spModificarPK_Sucursal 'CambioD', '(ID, Renglon, RenglonSub)'
GO
EXEC spALTER_TABLE 'CambioD', 'CoberturaAfectacion', 'float NULL'
EXEC spALTER_TABLE 'CambioD', 'UsuarioCobertura', 'char(10) NULL'
EXEC spALTER_TABLE 'CambioD', 'MontoDolares', 'money NULL'
EXEC spALTER_TABLE 'CambioD', 'Folio', 'int NULL'
EXEC spALTER_TABLE 'CambioD', 'Relevante', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CambioD', 'Plazo', 'int NULL'
EXEC spALTER_TABLE 'CambioD', 'Tasa', 'float NULL'
GO
if (select version from version) <= 3100
  ALTER TABLE CambioD ALTER COLUMN Tipo varchar(20) NOT NULL
go

EXEC spFK 'CambioD','Beneficiario','Beneficiario','Beneficiario'
GO

CREATE TRIGGER tgCambioDAC ON CambioD
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @ID				int,
    @Usuario			char(10),
    @ValorAnterior		varchar(50),
    @ValorNuevo			varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ValorAnterior = CONVERT(char, Cobertura) FROM DELETED
  SELECT @ValorNuevo    = CONVERT(char, Cobertura) FROM INSERTED

  SELECT @ID = ID, @Usuario = UsuarioCobertura FROM INSERTED

  IF @ValorAnterior <> @ValorNuevo
    INSERT CambioBitacora (CambioID, Usuario, Fecha, Accion, ValorAnterior, ValorNuevo) VALUES (@ID, @Usuario, GETDATE(), 'Cobertura', @ValorAnterior, @ValorNuevo)    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.cCambioD') and sysstat & 0xf = 2) drop view dbo.cCambioD
GO
CREATE VIEW cCambioD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  RenglonSub,

  Tipo,
  Instrumento,
  Monto,
  TipoCambio,
  Cobertura,
  Beneficiario,
  Observaciones,
  Plazo,

  GeneroModulo,
  GeneroMov,
  GeneroMovID,

  Sucursal,
  SucursalOrigen

FROM
  CambioD
GO


/****** CambioAcum ******/
if not exists (select * from SysTabla where SysTabla = 'CambioAcum') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CambioAcum','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CambioAcum') and type = 'U') 
CREATE TABLE dbo.CambioAcum (
	Sucursal	int		NOT NULL DEFAULT 0,
   	Empresa		char(5)		NOT NULL,
   	Fecha		datetime	NOT NULL,
   	Moneda		char(10)	NOT NULL,

   	Inicio		money		NULL	DEFAULT 0.0,
	InicioMN	money		NULL,
   	VentaHoy	money		NULL,
   	VentaHoyMN	money		NULL,
   	Venta24		money		NULL,
   	Venta24MN	money		NULL,
   	Venta48		money		NULL,
   	Venta48MN	money		NULL,
   	CompraHoy	money		NULL,
   	CompraHoyMN	money		NULL,
   	Compra24	money		NULL,
   	Compra24MN	money		NULL,
   	Compra48	money		NULL,
   	Compra48MN	money		NULL,

	OtrosIngresos	money		NULL,
	OtrosEgresos	money		NULL,

   	Cerrado 	bit		NOT NULL DEFAULT 0,

	CONSTRAINT priCambioAcum PRIMARY KEY  CLUSTERED (Sucursal, Empresa, Fecha, Moneda)
)
GO
EXEC spModificarPK_AcumSaldo 'CambioAcum', '(Sucursal, Empresa, Fecha, Moneda)'
GO

/*** CambioAcumFinalMN ***/
if exists (select * from sysobjects where id = object_id('dbo.CambioAcumFinalMN') and type = 'V') drop view dbo.CambioAcumFinalMN
GO
CREATE VIEW CambioAcumFinalMN
--//WITH ENCRYPTION
AS
SELECT 	Sucursal,
   	Empresa,
   	Fecha,
   	Moneda,
   	Inicio,
	InicioMN,
   	VentaHoy,
   	VentaHoyMN,
   	Venta24,
   	Venta24MN,
   	Venta48,
   	Venta48MN,
   	CompraHoy,
   	CompraHoyMN,
   	Compra24,
   	Compra24MN,
   	Compra48,
   	Compra48MN,
	OtrosIngresos,
	OtrosEgresos,
   	Cerrado,
        Final   = (ISNULL(Inicio, 0.0) - ISNULL(CompraHoy, 0.0)  - ISNULL(Compra24, 0.0)   - ISNULL(Compra48, 0.0)   + ISNULL(VentaHoy, 0.0)  + ISNULL(Venta24, 0.0) + ISNULL(Venta48, 0.0)),
        FinalMN = (ISNULL(CompraHoyMN, 0.0) + ISNULL(Compra24MN, 0.0) + ISNULL(Compra48MN, 0.0) + ISNULL(VentaHoyMN, 0.0) + ISNULL(Venta24MN, 0.0) + ISNULL(Venta48MN, 0.0)) /
                   NULLIF((ISNULL(CompraHoy, 0.0) + ISNULL(Compra24, 0.0) + ISNULL(Compra48, 0.0)+ ISNULL(VentaHoy, 0.0)   + ISNULL(Venta24, 0.0)   + ISNULL(Venta48, 0.0)), 0.0) *
                  (ISNULL(Inicio, 0.0)      - ISNULL(CompraHoy, 0.0)  - ISNULL(Compra24, 0.0)   - ISNULL(Compra48, 0.0)   + ISNULL(VentaHoy, 0.0)  + ISNULL(Venta24, 0.0) + ISNULL(Venta48, 0.0))
  FROM CambioAcum
GO
/*** CambioAcumFinal ***/
if exists (select * from sysobjects where id = object_id('dbo.CambioAcumFinal') and type = 'V') drop view dbo.CambioAcumFinal
GO
CREATE VIEW CambioAcumFinal
--//WITH ENCRYPTION
AS
SELECT 	Sucursal,
   	Empresa,
   	Fecha,
   	Moneda,
   	Inicio,
	InicioMN,
   	VentaHoy,
   	VentaHoyMN,
   	Venta24,
   	Venta24MN,
   	Venta48,
   	Venta48MN,
   	CompraHoy,
   	CompraHoyMN,
   	Compra24,
   	Compra24MN,
   	Compra48,
   	Compra48MN,
	OtrosIngresos,
	OtrosEgresos,
   	Cerrado,
        Final   = (ISNULL(Inicio, 0.0)      + ISNULL(CompraHoy, 0.0)  + ISNULL(Compra24, 0.0)   + ISNULL(Compra48, 0.0)   - ISNULL(VentaHoy, 0.0)  - ISNULL(Venta24, 0.0) - ISNULL(Venta48, 0.0)),
        FinalMN = (ISNULL(CompraHoyMN, 0.0) + ISNULL(Compra24MN, 0.0) + ISNULL(Compra48MN, 0.0) + ISNULL(VentaHoyMN, 0.0) + ISNULL(Venta24MN, 0.0) + ISNULL(Venta48MN, 0.0)) /
                   NULLIF((ISNULL(CompraHoy, 0.0) + ISNULL(Compra24, 0.0) + ISNULL(Compra48, 0.0)+ ISNULL(VentaHoy, 0.0)   + ISNULL(Venta24, 0.0)   + ISNULL(Venta48, 0.0)), 0.0) *
                  (ISNULL(Inicio, 0.0)      + ISNULL(CompraHoy, 0.0)  + ISNULL(Compra24, 0.0)   + ISNULL(Compra48, 0.0)   - ISNULL(VentaHoy, 0.0)  - ISNULL(Venta24, 0.0) - ISNULL(Venta48, 0.0))
  FROM CambioAcum
GO
-- select * from cambioacumfinal


/****** DolarFix ******/
if not exists (select * from SysTabla where SysTabla = 'DolarFix') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DolarFix','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.DolarFix') and type = 'U') 
  CREATE TABLE dbo.DolarFix (
	Fecha			datetime	NOT NULL,

	TipoCambio		float		NULL,

	CONSTRAINT priDolarFix PRIMARY KEY CLUSTERED (Fecha)
  )
GO

