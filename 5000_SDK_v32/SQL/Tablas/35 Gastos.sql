/*******************************************************************************************/
/*                                           GASTOS                                        */
/*******************************************************************************************/

/****** Consecutivos (Gastos) ******/
if not exists (select * from SysTabla where SysTabla = 'GastoC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('GastoC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.GastoC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.GastoC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priGastoC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'GastoC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'GastoC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE GastoC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE GastoC ALTER COLUMN Mov     char(20) NULL")
END
GO

/*** Gasto ***/
if not exists (select * from SysTabla where SysTabla = 'Gasto') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Gasto','Movimiento','GAS')
if not exists (select * from sysobjects where id = object_id('dbo.Gasto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Gasto (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	        NOT NULL,
	Mov			varchar(20)        NOT NULL,        
	MovID			varchar(20)    	NULL,	     
	FechaEmision 		datetime    	NULL,	     
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
	Moneda  		varchar(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		varchar(10)   	NULL,
	Autorizacion		varchar(10)	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		varchar(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Periodicidad		varchar(20)	NULL,
	TieneRetencion		bit		NOT NULL	DEFAULT 0,

	Acreedor           	varchar(10)   	NULL,	
     	Clase			varchar(50)	NULL,  
    	Subclase		varchar(50)	NULL,  

	CtaDinero		varchar(10)        NULL,       
	FormaPago		varchar(50)	NULL,
	Condicion  		varchar(50)   	NULL,    -- Condicion de Pago
	Vencimiento		datetime    	NULL,
	Importe   		money       	NULL,  -- suma de Importe (Detalle)
	Retencion   		money       	NULL,  -- suma de Rentecion (Detalle)
	Impuestos		money       	NULL,  -- suma de Impuestos (Detalle)

	Saldo 		        money       	NULL,
	Anticipo	        money       	NULL,

	MovAplica		varchar(20)	NULL,
	MovAplicaID		varchar(20)	NULL,
	Multiple		bit		NOT NULL DEFAULT 0,

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
	FechaRequerida		datetime	NULL,

	CXP			bit		NOT NULL DEFAULT 0,

	GenerarDinero		bit		NOT NULL DEFAULT 0,
	Dinero			varchar(20)	NULL,
	DineroID		varchar(20)	NULL,
	DineroCtaDinero		varchar(10)	NULL,
	DineroConciliado	bit		NULL     DEFAULT 0,
	DineroFechaConciliacion datetime	NULL,

	AnexoModulo		varchar(5)		NULL,
	AnexoID			int		NULL,
	ProdSerieLote 		varchar(50) 	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	Mensaje			int		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Actividad		varchar(100)	NULL,
	IVAFiscal		float		NULL,
	IEPSFiscal		float		NULL,
	EspacioResultado	bit		NULL 	 DEFAULT 0,	
	EstaImpreso		bit		NULL	 DEFAULT 0,

	AF			bit		NULL	 DEFAULT 0,
	AFArticulo		varchar(20)	NULL,
	AFSerie			varchar(50)	NULL,
	Pagado			float		NULL,
	Comentarios		text		NULL,

	ConVigencia		bit		NULL	 DEFAULT 0,
	VigenciaDesde		datetime	NULL,
	VigenciaHasta		datetime	NULL,

	ContratoTipo		varchar(50)	NULL,
	ContratoDescripcion	varchar(100)	NULL,
	ContratoSerie		varchar(20)	NULL,
	ContratoValor		money		NULL,
	ContratoSeguro		varchar(20)	NULL,
	ContratoVencimiento	datetime	NULL,
	ContratoResponsable	varchar(10)	NULL,
	Prioridad		varchar(10)	NULL	DEFAULT 'Normal',
	CostoPisoD		datetime	NULL,
	CostoPisoA		datetime	NULL,
	Nota			varchar(100) 	NULL,
	RetencionAlPago		bit		NULL		DEFAULT 0,
	SubModulo		varchar(5)		NULL	DEFAULT 'GAS',
	ClienteRef		varchar(10)	NULL,
	ArticuloRef		varchar(20)	NULL,
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20)	NULL,
	ContUso3		varchar(20)	NULL,

/*	GestionMov		varchar(20)	NULL,
	GestionMovID		varchar(20)	NULL,
	GestionActividad	varchar(20)	NULL,
	GestionID		int		NULL,
	GestionPlanRID		int		NULL,*/

	ContratoID		int		NULL,
	ContratoMov		varchar(20)	NULL,
	ContratoMovID		varchar(20)	NULL,

	--Ecuador
	TipoComprobante		AS CONVERT(varchar(20),NULL), 
	SustentoComprobante	AS CONVERT(varchar(20),NULL), 
	TipoIdentificacion	AS CONVERT(varchar(20),NULL), 
	DerechoDevolucion	AS CONVERT(bit,NULL),
	Establecimiento		AS CONVERT(varchar(20),NULL), 
	PuntoEmision		AS CONVERT(varchar(50),NULL), 
	SecuencialSRI		AS CONVERT(varchar(50),NULL), 
	AutorizacionSRI		AS CONVERT(varchar(50),NULL), 
	VigenteA		AS CONVERT(datetime,NULL),
	SecuenciaRetencion	AS CONVERT(varchar(50),NULL),
	Comprobante		AS CONVERT(bit,NULL),
	FechaContableMov	AS CONVERT(datetime,NULL),
	PuntoEmisionRetencion	AS CONVERT(varchar(50),NULL),
	SecuencialSRIRetencion  AS CONVERT(varchar(50),NULL),
 	CFDFlexEstatus          varchar(15)     NULL, --REQ 15739 	


	CONSTRAINT priGasto PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Gasto'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Gasto'
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Gasto.Consecutivo
  ALTER TABLE Gasto ALTER COLUMN MovID varchar(20)
  ALTER TABLE Gasto ALTER COLUMN MovAplicaID varchar(20)
  ALTER TABLE Gasto ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Gasto ALTER COLUMN PolizaID varchar(20)
  ALTER TABLE Gasto ALTER COLUMN DineroID varchar(20)
END
go
if exists (select * from sysobjects where id = object_id('dbo.tgGastoA') and sysstat & 0xf = 8) drop trigger dbo.tgGastoA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgGastoC') and sysstat & 0xf = 8) drop trigger dbo.tgGastoC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgGastoB') and sysstat & 0xf = 8) drop trigger dbo.tgGastoB
GO
EXEC spModificarPK_Mov 'Gasto'
GO
EXEC spSincroNivelRegistroCampos 'Gasto'
GO
EXEC spALTER_TABLE 'Gasto', 'Mensaje', 'int NULL'
EXEC spALTER_TABLE 'Gasto', 'Actividad', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Gasto', 'IVAFiscal', 'float NULL'
EXEC spALTER_TABLE 'Gasto', 'IEPSFiscal', 'float NULL'
GO
if not exists(select * from syscampo where tabla = 'Gasto' AND Campo = 'EspacioResultado')
BEGIN
  if exists(select * from syscampo where tabla = 'Gasto' AND Campo = 'AutoResultado')
    EXEC("spRENAME_COLUMN 'Gasto', 'AutoResultado', 'EspacioResultado'")
  ELSE
    EXEC("spALTER_TABLE 'Gasto', 'EspacioResultado', 'bit NULL DEFAULT 0'")
END
GO
EXEC spALTER_TABLE 'Gasto', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Gasto', 'EstaImpreso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Gasto', 'DineroConciliado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Gasto', 'DineroFechaConciliacion', 'datetime NULL'
EXEC spALTER_TABLE 'Gasto', 'AF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Gasto', 'AFArticulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Gasto', 'AFSerie', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Gasto', 'Pagado', 'float NULL'
EXEC spALTER_TABLE 'Gasto', 'Comentarios', 'text NULL'
EXEC spALTER_TABLE 'Gasto', 'ConVigencia', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Gasto', 'VigenciaDesde', 'datetime	NULL'
EXEC spALTER_TABLE 'Gasto', 'VigenciaHasta', 'datetime	NULL'
EXEC spALTER_TABLE 'Gasto', 'ContratoTipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Gasto', 'ContratoDescripcion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Gasto', 'ContratoSerie', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Gasto', 'ContratoValor', 'money NULL'
EXEC spALTER_TABLE 'Gasto', 'ContratoValorMoneda', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Gasto', 'ContratoSeguro', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Gasto', 'ContratoVencimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Gasto', 'ContratoResponsable', 'varchar(10)	NULL'
GO 
if (select version from version) <= 2331
  ALTER TABLE Gasto ALTER COLUMN Actividad varchar(100) NULL
GO
EXEC spALTER_TABLE 'Gasto', 'Prioridad', 'varchar(10) NULL DEFAULT "Normal" WITH VALUES'
EXEC spALTER_TABLE 'Gasto', 'CostoPisoD', 'datetime NULL'
EXEC spALTER_TABLE 'Gasto', 'CostoPisoA', 'datetime NULL'
EXEC spALTER_TABLE 'Gasto', 'Nota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Gasto', 'RetencionAlPago', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Gasto', 'SubModulo', 'char(5) NULL DEFAULT "GAS" WITH VALUES'
EXEC spALTER_TABLE 'Gasto', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Gasto', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_COLUMN 'Gasto', 'AFSerie', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'Gasto', 'ProdSerieLote', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Gasto', 'ClienteRef', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Gasto', 'ArticuloRef', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Gasto', 'ContUso', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Gasto', 'ContUso2', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Gasto', 'ContUso3', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Gasto', 'ContratoID', 'int NULL'
EXEC spALTER_TABLE 'Gasto', 'ContratoMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Gasto', 'ContratoMovID', 'varchar(20) NULL'
GO

--Ecuador
IF NOT EXISTS(SELECT * FROM SysColumns sc JOIN SysObjects so ON sc.ID = so.ID WHERE so.ID = OBJECT_ID('Gasto') AND sc.Name = 'TipoComprobante')
BEGIN
  EXEC spALTER_TABLE 'Gasto', 'TipoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Gasto', 'SustentoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Gasto', 'TipoIdentificacion', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Gasto', 'DerechoDevolucion', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'Gasto', 'Establecimiento', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Gasto', 'PuntoEmision', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Gasto', 'SecuencialSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Gasto', 'AutorizacionSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Gasto', 'VigenteA', 'AS CONVERT(datetime,NULL)'
  EXEC spALTER_TABLE 'Gasto', 'SecuenciaRetencion', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Gasto', 'Comprobante', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'Gasto', 'FechaContableMov', 'AS CONVERT(datetime,NULL)'
  EXEC spALTER_TABLE 'Gasto', 'PuntoEmisionRetencion', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Gasto', 'SecuencialSRIRetencion', 'AS CONVERT(varchar(50),NULL)'
END
GO

IF EXISTS(SELECT * FROM Empresa WHERE EsEcuador = 1) AND NOT EXISTS(SELECT ID FROM Gasto WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL)
BEGIN
  EXEC spDROP_COLUMN 'Gasto', 'TipoComprobante'
  EXEC spDROP_COLUMN 'Gasto', 'SustentoComprobante'
  EXEC spDROP_COLUMN 'Gasto', 'TipoIdentificacion'
  EXEC spDROP_COLUMN 'Gasto', 'DerechoDevolucion'
  EXEC spDROP_COLUMN 'Gasto', 'Establecimiento'
  EXEC spDROP_COLUMN 'Gasto', 'PuntoEmision'
  EXEC spDROP_COLUMN 'Gasto', 'SecuencialSRI'
  EXEC spDROP_COLUMN 'Gasto', 'AutorizacionSRI'
  EXEC spDROP_COLUMN 'Gasto', 'VigenteA'
  EXEC spDROP_COLUMN 'Gasto', 'SecuenciaRetencion'
  EXEC spDROP_COLUMN 'Gasto', 'Comprobante'
  EXEC spDROP_COLUMN 'Gasto', 'FechaContableMov'
  EXEC spDROP_COLUMN 'Gasto', 'PuntoEmisionRetencion'
  EXEC spDROP_COLUMN 'Gasto', 'SecuencialSRIRetencion'

  EXEC spALTER_TABLE 'Gasto', 'TipoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Gasto', 'SustentoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Gasto', 'TipoIdentificacion', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Gasto', 'DerechoDevolucion', 'bit NULL'
  EXEC spALTER_TABLE 'Gasto', 'Establecimiento', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Gasto', 'PuntoEmision', 'varchar(50) NULL' 
  EXEC spALTER_TABLE 'Gasto', 'SecuencialSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Gasto', 'AutorizacionSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Gasto', 'VigenteA', 'datetime NULL'
  EXEC spALTER_TABLE 'Gasto', 'SecuenciaRetencion', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Gasto', 'Comprobante', 'bit NULL'
  EXEC spALTER_TABLE 'Gasto', 'FechaContableMov', 'datetime NULL'
  EXEC spALTER_TABLE 'Gasto', 'PuntoEmisionRetencion', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Gasto', 'SecuencialSRIRetencion', 'varchar(50) NULL'
  EXEC spALTER_COLUMN 'Gasto', 'DerechoDevolucion', 'bit NULL'
  EXEC spALTER_COLUMN 'Gasto', 'Comprobante', 'bit NULL'
END
GO

 --REQ 15739 
Exec spAlter_Table 'Gasto','CFDFlexEstatus','varchar(15) Null'
EXEC spADD_INDEX 'Gasto', 'CFDFlexEstatus', 'Estatus, CFDFlexEstatus'
GO

EXEC spFK 'Gasto','CtaDinero','CtaDinero','CtaDinero'
EXEC spFK 'Gasto','Acreedor','Prov','Proveedor'
EXEC spFK 'Gasto','Mensaje','MensajeLista','Mensaje'
EXEC spFK 'Gasto','UEN','UEN','UEN'
EXEC spFK 'Gasto','AFArticulo','Art','Articulo'
GO

--Integración MES
EXEC spALTER_TABLE 'Gasto', 'MesLanzamiento', 'varchar(100) NULL'
GO

-- Gastos
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Gasto (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Gasto (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2 ON dbo.Gasto (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3   ON dbo.Gasto (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario      ON dbo.Gasto (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Acreedor' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Acreedor     ON dbo.Gasto (Acreedor)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Clase' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Clase 	    ON dbo.Gasto (Clase, Subclase)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	    ON dbo.Gasto (ContID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Dinero2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Dinero2      ON dbo.Gasto (DineroID, Dinero, DineroCtaDinero, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Anexo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Anexo ON dbo.Gasto (AnexoID, AnexoModulo, Empresa)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Gasto.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Gasto.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Gasto.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Gasto.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Dinero' AND sysobjects.id = sysindexes.id)
  DROP INDEX Gasto.Dinero
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Gasto.Abrir
GO

--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Gasto (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Gasto (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Gasto (OrigenID,Origen,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gasto' AND sysindexes.name = 'SubModulo' AND sysobjects.id = sysindexes.id)
   CREATE INDEX SubModulo ON Gasto(SubModulo)


-- Aqui va el Matenimiento a la tabla
GO
CREATE TRIGGER tgGastoC ON Gasto
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 		varchar(5),
    @Mov		varchar(20),
    @Sucursal		int,
    @ID			int,
    @FechaInicio	datetime,
    @Ahora 		datetime,
    @FechaAnterior	datetime,
    @EstatusNuevo 	varchar(15),
    @EstatusAnterior 	varchar(15),
    @SituacionNueva 	varchar(50),
    @SituacionAnterior 	varchar(50), 
    @Usuario		varchar(10),
    @Mensaje		varchar(255),
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(DineroConciliado) OR UPDATE(DineroFechaConciliacion) RETURN

  SELECT @Modulo = 'GAS'
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
    UPDATE Gasto SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL
END
GO

CREATE TRIGGER tgGastoB ON Gasto
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	varchar(15),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'GAS', @ID
END
GO


/****** GastosD ******/
if not exists (select * from SysTabla where SysTabla = 'GastoD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('GastoD','Movimiento','GAS')
if not exists (select * from sysobjects where id = object_id('dbo.GastoD') and type = 'U') 
CREATE TABLE dbo.GastoD (
	ID 			int             NOT NULL,
 	Renglon			float	     	NOT NULL,
	RenglonSub		int		NOT NULL DEFAULT 0,

	Concepto		varchar(50)	NULL,
	Fecha			datetime	NULL,
	Referencia 		varchar(50) 	NULL,
	Cantidad		float		NULL,
	ImporteConImpuesto	money       	NULL,  
	Precio			money		NULL,
       	Importe                 money           NULL,
	Provision		money           NULL,
	Retencion		money		NULL,
	Retencion2		money		NULL,
	Retencion3		money		NULL,
	Impuestos		money           NULL,
	Impuestos2		money           NULL,
	Impuestos3		money           NULL,
	Impuestos5		money           NULL,
	Impuesto1		float		NULL,
	Impuesto2		float		NULL,
	Impuesto3		float		NULL,
	Impuesto5		float		NULL,
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20)	NULL,
	ContUso3		varchar(20)	NULL,	
	Espacio			varchar(10)	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	Actividad		varchar(50)	NULL,
	Proyecto		varchar(50)	NULL,
	UEN			int		NULL,
        VIN                     varchar(20)     NULL,
	DescripcionExtra	varchar(100) 	NULL,
	AcreedorRef		varchar(10)	NULL,
	EndosarA		varchar(10)	NULL,
	AFArticulo		varchar(20)	NULL,
	AFSerie			varchar(20)	NULL,
	Lectura			int		NULL,
	LecturaAnterior		int		NULL,
	PorcentajeDeducible	float	     	NULL	DEFAULT 100,
	Personal		varchar(10)	NULL,
	DepartamentoDetallista	int		NULL,
	PresupuestoEsp		bit		NULL	DEFAULT 0,	
	InvID			int		NULL,
	Recurso			varchar(10)	NULL,
--	Riesgo			varchar(20)	NULL,
	ABC			varchar(50)	NULL,
	ClavePresupuestal	varchar(50)	NULL,

	TipoImpuesto1		varchar(10)	NULL,
	TipoImpuesto2		varchar(10)	NULL,
	TipoImpuesto3		varchar(10)	NULL,
	TipoImpuesto4		varchar(10)	NULL,
	TipoImpuesto5		varchar(10)	NULL,
	TipoRetencion1		varchar(10)	NULL,
	TipoRetencion2		varchar(10)	NULL,
	TipoRetencion3		varchar(10)	NULL,
	CambioImpuesto		bit			NULL	DEFAULT 0,

	--Ecuador
	TipoComprobante		AS CONVERT(varchar(20),NULL), 
	SustentoComprobante	AS CONVERT(varchar(20),NULL), 
	TipoIdentificacion	AS CONVERT(varchar(20),NULL), 
	DerechoDevolucion	AS CONVERT(bit,0),
	Establecimiento		AS CONVERT(varchar(20),NULL), 
	PuntoEmision		AS CONVERT(varchar(50),NULL), 
	SecuencialSRI		AS CONVERT(varchar(50),NULL), 
	AutorizacionSRI		AS CONVERT(varchar(50),NULL), 
	VigenteA		AS CONVERT(datetime,NULL),
	SecuenciaRetencion	AS CONVERT(varchar(50),NULL),
	Comprobante		AS CONVERT(bit,0),
	FechaContableMov	AS CONVERT(datetime,NULL),
	EcuadorTipoOperacionGasto AS CONVERT(varchar(50),NULL),
	
	CONSTRAINT priGastoD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgGastoDC') and sysstat & 0xf = 8) drop trigger dbo.tgGastoDC
GO
EXEC spModificarPK_Sucursal 'GastoD', '(ID, Renglon, RenglonSub)'
EXEC spALTER_TABLE 'GastoD', 'Actividad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'GastoD', 'DescripcionExtra', 'varchar(100) NULL'
GO
EXEC spRENAME_COLUMN 'GastoD', 'Autobus', 'Espacio'
GO
EXEC spALTER_TABLE 'GastoD', 'Espacio', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'GastoD', 'AcreedorRef', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'AFArticulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'GastoD', 'AFSerie', 'varchar(20) NULL'
EXEC spALTER_TABLE 'GastoD', 'VIN', 'varchar(20) NULL'
EXEC spALTER_TABLE 'GastoD', 'Recurso', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'ABC', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'GastoD', 'CambioImpuesto', 'bit NULL DEFAULT 0'
GO

if not exists(select * from syscampo where tabla = 'GastoD' and campo = 'Proyecto')
BEGIN
  EXEC("spALTER_TABLE 'GastoD', 'Proyecto', 'varchar(50) NULL'")
  EXEC("UPDATE GastoD SET Proyecto = g.Proyecto FROM Gasto g, GastoD d WHERE g.ID = d.ID")
END
GO
if not exists(select * from syscampo where tabla = 'GastoD' and campo = 'PorcentajeDeducible')
BEGIN
  EXEC("spALTER_TABLE 'GastoD', 'PorcentajeDeducible', 'float NULL DEFAULT 100'")
  EXEC("UPDATE GastoD SET PorcentajeDeducible = c.PorcentajeDeducible FROM GastoD d, Concepto c WHERE c.Modulo = 'GAS' AND d.Concepto = c.Concepto")
END
GO
EXEC spALTER_TABLE 'GastoD', 'Lectura', 'int NULL'
EXEC spALTER_TABLE 'GastoD', 'LecturaAnterior','int NULL'
EXEC spALTER_TABLE 'GastoD', 'EndosarA', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'Retencion3', 'money NULL'
EXEC spALTER_TABLE 'GastoD', 'Provision', 'money NULL'
EXEC spALTER_TABLE 'GastoD', 'Personal', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'DepartamentoDetallista', 'int NULL'
EXEC spALTER_TABLE 'GastoD', 'PresupuestoEsp', 'bit NULL DEFAULT 0 WITH VALUES'
GO
--EXEC spDROP_COLUMN 'GastoD', 'Recurso'
EXEC spDROP_COLUMN 'GastoD', 'Riesgo'
GO
EXEC spALTER_TABLE 'GastoD', 'InvID', 'int NULL'
GO
EXEC spALTER_TABLE 'GastoD', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'GastoD', 'ContUso3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'GastoD', 'ClavePresupuestal', 'varchar(50) NULL'
GO
EXEC spALTER_COLUMN 'GastoD', 'ClavePresupuestal', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'GastoD', 'Impuesto1', 'float NULL'
EXEC spALTER_TABLE 'GastoD', 'Impuesto2', 'float NULL'
EXEC spALTER_TABLE 'GastoD', 'Impuesto3', 'float NULL'
EXEC spALTER_TABLE 'GastoD', 'Impuesto5', 'float NULL'
EXEC spALTER_TABLE 'GastoD', 'Impuestos2', 'money NULL'
EXEC spALTER_TABLE 'GastoD', 'Impuestos3', 'money NULL'
EXEC spALTER_TABLE 'GastoD', 'Impuestos5', 'money NULL'
EXEC spALTER_TABLE 'GastoD', 'TipoImpuesto1', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'TipoImpuesto2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'TipoImpuesto3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'TipoImpuesto4', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'TipoImpuesto5', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'TipoRetencion1', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'TipoRetencion2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'TipoRetencion3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoD', 'ImporteConImpuesto', 'money NULL'
GO

--Ecuador
IF NOT EXISTS(SELECT * FROM SysColumns sc JOIN SysObjects so ON sc.ID = so.ID WHERE so.ID = OBJECT_ID('GastoD') AND sc.Name = 'TipoComprobante')
BEGIN
  EXEC spALTER_TABLE 'GastoD', 'TipoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'GastoD', 'SustentoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'GastoD', 'TipoIdentificacion', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'GastoD', 'DerechoDevolucion', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'GastoD', 'Establecimiento', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'GastoD', 'PuntoEmision', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'GastoD', 'SecuencialSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'GastoD', 'AutorizacionSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'GastoD', 'VigenteA', 'AS CONVERT(datetime,NULL)'
  EXEC spALTER_TABLE 'GastoD', 'SecuenciaRetencion', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'GastoD', 'Comprobante', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'GastoD', 'FechaContableMov', 'AS CONVERT(datetime,NULL)'
  EXEC spALTER_TABLE 'GastoD', 'EcuadorTipoOperacionGasto', 'AS CONVERT(varchar(50),NULL)' 
END
GO

IF EXISTS(SELECT * FROM Empresa WHERE EsEcuador = 1) AND NOT EXISTS(SELECT ID FROM GastoD WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL)
BEGIN
  EXEC spDROP_COLUMN 'GastoD', 'TipoComprobante'
  EXEC spDROP_COLUMN 'GastoD', 'SustentoComprobante'
  EXEC spDROP_COLUMN 'GastoD', 'TipoIdentificacion'
  EXEC spDROP_COLUMN 'GastoD', 'DerechoDevolucion'
  EXEC spDROP_COLUMN 'GastoD', 'Establecimiento'
  EXEC spDROP_COLUMN 'GastoD', 'PuntoEmision'
  EXEC spDROP_COLUMN 'GastoD', 'SecuencialSRI'
  EXEC spDROP_COLUMN 'GastoD', 'AutorizacionSRI'
  EXEC spDROP_COLUMN 'GastoD', 'VigenteA'
  EXEC spDROP_COLUMN 'GastoD', 'SecuenciaRetencion'
  EXEC spDROP_COLUMN 'GastoD', 'Comprobante'
  EXEC spDROP_COLUMN 'GastoD', 'FechaContableMov'

  EXEC spALTER_TABLE 'GastoD', 'TipoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'GastoD', 'SustentoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'GastoD', 'TipoIdentificacion', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'GastoD', 'DerechoDevolucion', 'bit NULL'
  EXEC spALTER_TABLE 'GastoD', 'Establecimiento', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'GastoD', 'PuntoEmision', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'GastoD', 'SecuencialSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'GastoD', 'AutorizacionSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'GastoD', 'VigenteA', 'datetime NULL'
  EXEC spALTER_TABLE 'GastoD', 'SecuenciaRetencion', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'GastoD', 'Comprobante', 'bit NULL'
  EXEC spALTER_TABLE 'GastoD', 'FechaContableMov', 'datetime NULL'
  EXEC spALTER_TABLE 'GastoD', 'EcuadorTipoOperacionGasto', 'varchar(50) NULL' 
END
GO

EXEC spALTER_COLUMN 'GastoD', 'AFSerie', 'varchar(50) NULL'  --BUG12333
GO

EXEC spFK 'GastoD','ID','Gasto','ID'
EXEC spFK 'GastoD','ContUso','CentroCostos','CentroCostos'
EXEC spFK 'GastoD','UEN','UEN','UEN'
EXEC spFK 'GastoD','AFArticulo','Art','Articulo'
EXEC spFK 'GastoD','VIN','VIN','VIN'
EXEC spFK 'GastoD','Personal','Personal','Personal'
EXEC spFK 'GastoD','DepartamentoDetallista','DepartamentoDetallista','Departamento'
GO

if (select version from version) <= 2331
  ALTER TABLE GastoD ALTER COLUMN Actividad varchar(100) NULL
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'GastoD' AND sysindexes.name = 'Concepto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Concepto ON dbo.GastoD (Concepto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'GastoD' AND sysindexes.name = 'Espacio' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Espacio ON dbo.GastoD (Espacio)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'GastoD' AND sysindexes.name = 'ContUso' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContUso ON dbo.GastoD (ContUso)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'GastoD' AND sysindexes.name = 'Personal' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Personal ON dbo.GastoD (Personal)
GO


GO
CREATE TRIGGER tgGastoDC ON GastoD
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Estatus	varchar(15),
    @ID		int,
    @Renglon	float,
    @RenglonSub	int

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Renglon = Renglon, @RenglonSub = RenglonSub FROM Inserted

  SELECT @Estatus = Estatus FROM Gasto WHERE ID = @ID
  IF @Estatus = 'CONCLUIDO'
    EXEC spMovDReg 'GAS', @ID, @Renglon, @RenglonSub, @UnicamenteActualizar = 1
END
GO


if exists (select * from sysobjects where id = object_id('dbo.cGastoD') and sysstat & 0xf = 2) drop view dbo.cGastoD
GO
CREATE VIEW cGastoD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  RenglonSub,

  Concepto,
  Fecha,
  Referencia,
  Cantidad,
  Precio,
  ImporteConImpuesto,
  Importe,
  Provision,
  Retencion,
  Retencion2,
  Retencion3,
  Impuestos,
  Impuestos2,
  Impuestos3,
  Impuestos5,
  Impuesto1,
  Impuesto2,
  Impuesto3,
  Impuesto5,
  ContUso,
  ContUso2,
  ContUso3,
  ClavePresupuestal,
  Espacio,
  Sucursal,
  SucursalOrigen,
  Actividad,
  Proyecto,
  UEN,
  VIN,
  DescripcionExtra,
  AcreedorRef,
  EndosarA,
  AFArticulo,
  AFSerie,
  Lectura,
  PorcentajeDeducible,
  Personal,
  PresupuestoEsp,
  ABC,
  TipoImpuesto1,
  TipoImpuesto2,
  TipoImpuesto3,
  TipoImpuesto4,
  TipoImpuesto5,
  TipoRetencion1,
  TipoRetencion2,
  TipoRetencion3
  /*,
  InvID,
  Recurso,
  Riesgo*/

FROM
  GastoD
GO

/****** Gastos Aplica ******/
if not exists (select * from SysTabla where SysTabla = 'GastoAplica') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('GastoAplica','Movimiento','GAS')
if not exists (select * from sysobjects where id = object_id('dbo.GastoAplica') and type = 'U') 
CREATE TABLE dbo.GastoAplica (
	ID 			int             NOT NULL,
 	Renglon			float	        NOT NULL,
	RenglonSub		int		NOT NULL DEFAULT 0,

	Aplica   	        varchar(20)        NULL,
        AplicaID	        varchar(20)     NULL,
        Importe                 money           NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priGastoAplica PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)

)
GO
if (select version from version) <= 1095
  ALTER TABLE GastoAplica ALTER COLUMN AplicaID varchar(20)
GO
EXEC spModificarPK_Sucursal 'GastoAplica', '(ID, Renglon, RenglonSub)'
GO

EXEC spFK 'GastoAplica','ID','Gasto','ID'
GO

/****** GastoDProrrateo ******/
if not exists (select * from SysTabla where SysTabla = 'GastoDProrrateo') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('GastoDProrrateo','Movimiento','GAS')
if not exists (select * from sysobjects where id = object_id('dbo.GastoDProrrateo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.GastoDProrrateo (
	ID 			int             NOT NULL,
	Renglon			float		NOT NULL,
	RenglonSub		int		NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	RenglonID		int		IDENTITY(1,1) NOT NULL,

	SucursalProrrateo	int		NULL,
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20)	NULL,
	ContUso3		varchar(20)	NULL,
	Espacio			varchar(10)	NULL,
	Proyecto		varchar(50)	NULL,
	UEN			int		NULL,
        VIN                     varchar(20)	NULL,
	Actividad		varchar(100)	NULL,
	AFArticulo		varchar(20)	NULL,
	AFSerie			varchar(20)	NULL,
	Fecha			datetime	NULL,
	Porcentaje		float		NULL,
	Importe			money		NULL,

	CONSTRAINT priGastoDProrrateo PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub, Concepto, RenglonID)
  )
  EXEC spSincroSemilla 'GastoDProrrateo'
END
GO
EXEC spModificarPK_Sucursal 'GastoDProrrateo', '(ID, Renglon, RenglonSub, Concepto, RenglonID)'
GO
EXEC spALTER_TABLE 'GastoDProrrateo', 'Importe', 'money	NULL'
EXEC spALTER_TABLE 'GastoDProrrateo', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'GastoDProrrateo', 'Proyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'GastoDProrrateo', 'Actividad', 'varchar(100) NULL'
EXEC spALTER_TABLE 'GastoDProrrateo', 'AFArticulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'GastoDProrrateo', 'AFSerie', 'varchar(20) NULL'

GO
EXEC spRENAME_COLUMN 'GastoDProrrateo', 'Autobus', 'Espacio'
GO
EXEC spALTER_TABLE 'GastoDProrrateo', 'Espacio', 'varchar(10) NULL'
EXEC spALTER_TABLE 'GastoDProrrateo', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'GastoDProrrateo', 'VIN', 'varchar(20) NULL'
GO

EXEC spALTER_COLUMN 'GastoDProrrateo', 'AFSerie', 'varchar(50) NULL'  --BUG12333
GO

if not exists(select * from syscampo where tabla = 'GastoDProrrateo' AND Campo = 'Renglon')
BEGIN
  EXEC("spALTER_TABLE 'GastoDProrrateo', 'Renglon', 'float NOT NULL DEFAULT 0 WITH VALUES'")
  EXEC("spALTER_TABLE 'GastoDProrrateo', 'RenglonSub', 'int NOT NULL DEFAULT 0 WITH VALUES'")
  EXEC("spEliminarPK 'GastoDProrrateo'")
  EXEC("ALTER TABLE GastoDProrrateo ADD CONSTRAINT priGastoDProrrateo PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub, Concepto, RenglonID)")
END
GO
if (select version from version) <= 2331
  ALTER TABLE GastoDProrrateo ALTER COLUMN Actividad varchar(100) NULL
GO
EXEC spALTER_TABLE 'GastoDProrrateo', 'Fecha', 'datetime NULL'
EXEC spALTER_TABLE 'GastoDProrrateo', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'GastoDProrrateo', 'ContUso3', 'varchar(20) NULL'
GO

EXEC spFK 'GastoDProrrateo','SucursalProrrateo','Sucursal','Sucursal'
EXEC spFK 'GastoDProrrateo','ContUso','CentroCostos','CentroCostos'
EXEC spFK 'GastoDProrrateo','VIN','VIN','VIN'
GO

/****** GastoDPresupuestoEsp ******/
if not exists (select * from SysTabla where SysTabla = 'GastoDPresupuestoEsp') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('GastoDPresupuestoEsp','Movimiento','GAS')
if not exists (select * from sysobjects where id = object_id('dbo.GastoDPresupuestoEsp') and type = 'U') 
BEGIN
  CREATE TABLE dbo.GastoDPresupuestoEsp (
	ID 			int             NOT NULL,
	Renglon			float		NOT NULL,
	RenglonSub		int		NOT NULL,
	CuentaPresupuesto	varchar(20)	NOT NULL,

	Importe			money		NULL,

	CONSTRAINT priGastoDPresupuestoEsp PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub, CuentaPresupuesto)
  )
  EXEC spSincroSemilla 'GastoDPresupuestoEsp'
END
GO
EXEC spModificarPK_Sucursal 'GastoDPresupuestoEsp', '(ID, Renglon, RenglonSub, CuentaPresupuesto)'
GO

EXEC spFK 'GastoDPresupuestoEsp','CuentaPresupuesto','Cta','Cuenta'
GO
