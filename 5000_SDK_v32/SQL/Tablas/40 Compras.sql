SET ANSI_DEFAULTS OFF
GO

/*******************************************************************************************/
/*                                           COMPRAS                                       */
/*******************************************************************************************/

/****** Consecutivos (Compra) ******/
if not exists (select * from SysTabla where SysTabla = 'CompraC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CompraC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CompraC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CompraC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)      NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCompraC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CompraC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'CompraC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE CompraC ALTER COLUMN Empresa varchar(5)  NULL")
  EXEC("ALTER TABLE CompraC ALTER COLUMN Mov     varchar(20) NULL")
END
GO

/****** Compras ******/
if not exists (select * from SysTabla where SysTabla = 'Compra') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Compra','Movimiento','COMS')
if not exists (select * from sysobjects where id = object_id('dbo.Compra') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Compra (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	        NOT NULL,
	Mov 			varchar(20)        NOT NULL,
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	Actividad		varchar(100)   	NULL,
	UEN			int		NULL,
	Moneda  		varchar(10)   	NOT NULL,   -- default del Proveedor
	TipoCambio		float		NULL,
	Usuario 		varchar(10)   	NULL,
   	Autorizacion		varchar(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		varchar(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Directo			bit		NOT NULL DEFAULT 1,
	VerDestino		bit		NOT NULL DEFAULT 0,
	Prioridad		varchar(10)	NULL,
	RenglonID		int		NULL,

	Proveedor 		varchar(10)   	NULL,
	FormaEnvio 		varchar(50)   	NULL,  
	FechaRequerida		datetime    	NULL,
	Almacen  		varchar(10)   	NULL,
	Condicion  		varchar(50)   	NULL,    -- Condicion de Pago
	Vencimiento		datetime    	NULL,
	Manejo			money		NULL,  -- ??
	Fletes			money		NULL,
	ActivoFijo		bit		NOT NULL DEFAULT 0,
	Instruccion		varchar(50)	NULL,
	Agente			varchar(10)	NULL,

	Descuento		varchar(30)   	NULL,
	DescuentoGlobal 	float 	    	NULL,  -- % de descuento global
	Importe  		money	    	NULL,  -- Importe = Suma(Importe) * linea (incluye desc linea)
	Impuestos		money       	NULL,  -- suma de impuestos
	Saldo 		        money       	NULL,
        DescuentoLineal		money		NULL,  -- suma del descuento linea (referencia)

    --BUG9637
    Retencion		float		NULL,
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

	Peso			float		NULL,
	Volumen			float		NULL,
	Conciliado		bit		NOT NULL DEFAULT 0,

	Causa			varchar(50)	NULL,
	Atencion		varchar(50)	NULL,

	FechaEntrega		datetime    	NULL,
	EmbarqueEstado		varchar(50)	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	ZonaImpuesto		varchar(30)  	NULL,
	Paquetes		int		NULL,
	Idioma			varchar(50)	NULL,
	IVAFiscal		float		NULL,
	IEPSFiscal		float		NULL,
	ListaPreciosEsp		varchar(20)	NULL,
	EstaImpreso		bit		NULL	 DEFAULT 0,
	Mensaje			int		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	
	Pagado			float		NULL,
	ProrrateoAplicaID	int		NULL,
	FormaEntrega		varchar(50)	NULL,
	CancelarPendiente	bit		NULL	 DEFAULT 0,

	LineaCredito		varchar(20)	NULL,
 	TipoAmortizacion	varchar(20)	NULL,
	TipoTasa		varchar(20)	NULL,
	Comisiones		money		NULL,
	ComisionesIVA		money		NULL,
	OperacionRelevante	bit 		NULL 	DEFAULT 0,
	VIN			varchar(20)	NULL,
	SubModulo		varchar(5)		NULL	DEFAULT 'COMS',
	AutoCargos		float		NULL,
	TieneTasaEsp		bit		NULL	DEFAULT 0,
	TasaEsp			float		NULL,
	Cliente			varchar(10)	NULL,
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20)	NULL,
	ContUso3		varchar(20)	NULL,

	ContratoID		int		NULL,
	ContratoMov		varchar(20)	NULL,
	ContratoMovID		varchar(20)	NULL,

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
	PuntoEmisionRetencion   AS CONVERT(varchar(50),NULL),
	SecuencialSRIRetencion  AS CONVERT(varchar(50),NULL),
	
	FechaProveedor		datetime	NULL,
 --REQ12534 Factory  	
	ReferenciaMES		varchar(50)	NULL,
	MovIntelisisMES		varchar(10)	NULL,
	
	--REQ12615 WMS
	PosicionWMS			varchar(10) NULL,
 	CFDFlexEstatus          varchar(15)     NULL, --REQ 15739 	
	
	CONSTRAINT priCompra PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Compra'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Compra'
GO

if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Compra.Consecutivo
  ALTER TABLE Compra ALTER COLUMN MovID varchar(20)
  ALTER TABLE Compra ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Compra ALTER COLUMN PolizaID varchar(20)
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCompraA') and sysstat & 0xf = 8) drop trigger dbo.tgCompraA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCompraC') and sysstat & 0xf = 8) drop trigger dbo.tgCompraC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCompraB') and sysstat & 0xf = 8) drop trigger dbo.tgCompraB
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCompraD') and sysstat & 0xf = 8) drop trigger dbo.tgCompraD --JGD 12Abril2011 Ticket 4118 
GO
EXEC spModificarPK_Mov 'Compra'
GO
EXEC spSincroNivelRegistroCampos 'Compra'
GO
EXEC spALTER_TABLE 'Compra', 'ZonaImpuesto', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Compra', 'Paquetes', 'int NULL'
EXEC spALTER_TABLE 'Compra', 'Idioma', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Compra', 'IVAFiscal', 'float NULL'
EXEC spALTER_TABLE 'Compra', 'IEPSFiscal', 'float NULL'
EXEC spALTER_TABLE 'Compra', 'ListaPreciosEsp', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Compra', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Compra', 'EstaImpreso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Compra', 'Pagado', 'float NULL'
EXEC spALTER_TABLE 'Compra', 'ProrrateoAplicaID', 'int NULL'
EXEC spALTER_TABLE 'Compra', 'Mensaje', 'int NULL'
EXEC spALTER_TABLE 'Compra', 'FormaEntrega', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Compra', 'CancelarPendiente', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Compra', 'LineaCredito', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Compra', 'TipoAmortizacion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Compra', 'TipoTasa', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Compra', 'Comisiones', 'money NULL'
EXEC spALTER_TABLE 'Compra', 'ComisionesIVA', 'money NULL'
EXEC spALTER_TABLE 'Compra', 'OperacionRelevante','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Compra', 'VIN', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Compra', 'SubModulo', 'varchar(5) NULL	DEFAULT "COMS" WITH VALUES'
EXEC spALTER_TABLE 'Compra', 'AutoCargos', 'float NULL'
EXEC spALTER_TABLE 'Compra', 'TieneTasaEsp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Compra', 'TasaEsp', 'float NULL'
EXEC spALTER_TABLE 'Compra', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Compra', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Compra', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Compra', 'Actividad', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Compra', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Compra', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Compra', 'ContUso3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Compra', 'ContratoID', 'int NULL'
EXEC spALTER_TABLE 'Compra', 'ContratoMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Compra', 'ContratoMovID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Compra', 'Entidad', 'varchar(20) NULL'
GO

--BUG 22716
EXEC spALTER_TABLE 'Compra', 'Posicion', 'varchar(10) NULL'
--GO
--Ecuador
IF NOT EXISTS(SELECT * FROM SysColumns sc JOIN SysObjects so ON sc.ID = so.ID WHERE so.ID = OBJECT_ID('Compra') AND sc.Name = 'TipoComprobante')
BEGIN
  EXEC spALTER_TABLE 'Compra', 'TipoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Compra', 'SustentoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Compra', 'TipoIdentificacion', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Compra', 'DerechoDevolucion', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'Compra', 'Establecimiento', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Compra', 'PuntoEmision', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Compra', 'SecuencialSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Compra', 'AutorizacionSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Compra', 'VigenteA', 'AS CONVERT(datetime,NULL)'
  EXEC spALTER_TABLE 'Compra', 'SecuenciaRetencion', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Compra', 'Comprobante', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'Compra', 'FechaContableMov', 'AS CONVERT(datetime,NULL)'
  EXEC spALTER_TABLE 'Compra', 'PuntoEmisionRetencion', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Compra', 'SecuencialSRIRetencion', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Compra', 'FechaProveedor', 'AS CONVERT(datetime,NULL)'
END
GO
   
IF EXISTS(SELECT * FROM Empresa WHERE EsEcuador = 1) AND NOT EXISTS(SELECT ID FROM Compra WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL)
BEGIN
  EXEC spDROP_COLUMN 'Compra', 'TipoComprobante'
  EXEC spDROP_COLUMN 'Compra', 'SustentoComprobante'
  EXEC spDROP_COLUMN 'Compra', 'TipoIdentificacion'
  EXEC spDROP_COLUMN 'Compra', 'DerechoDevolucion'
  EXEC spDROP_COLUMN 'Compra', 'Establecimiento'
  EXEC spDROP_COLUMN 'Compra', 'PuntoEmision'
  EXEC spDROP_COLUMN 'Compra', 'SecuencialSRI'
  EXEC spDROP_COLUMN 'Compra', 'AutorizacionSRI'
  EXEC spDROP_COLUMN 'Compra', 'VigenteA'
  EXEC spDROP_COLUMN 'Compra', 'SecuenciaRetencion'
  EXEC spDROP_COLUMN 'Compra', 'Comprobante'
  EXEC spDROP_COLUMN 'Compra', 'FechaContableMov'
  EXEC spDROP_COLUMN 'Compra', 'PuntoEmisionRetencion'
  EXEC spDROP_COLUMN 'Compra', 'PuntoEmisionRetencion'
  EXEC spDROP_COLUMN 'Compra', 'SecuencialSRIRetencion'
  EXEC spDROP_COLUMN 'Compra', 'FechaProveedor'  

  EXEC spALTER_TABLE 'Compra', 'TipoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Compra', 'SustentoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Compra', 'TipoIdentificacion', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Compra', 'DerechoDevolucion', 'bit NULL'
  EXEC spALTER_TABLE 'Compra', 'Establecimiento', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Compra', 'PuntoEmision', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Compra', 'SecuencialSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Compra', 'AutorizacionSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Compra', 'VigenteA', 'datetime NULL'
  EXEC spALTER_TABLE 'Compra', 'SecuenciaRetencion', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Compra', 'Comprobante', 'bit NULL'
  EXEC spALTER_TABLE 'Compra', 'FechaContableMov', 'datetime NULL'
  EXEC spALTER_TABLE 'Compra', 'PuntoEmisionRetencion', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Compra', 'SecuencialSRIRetencion', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Compra', 'FechaProveedor', 'datetime NULL'
END
GO

 --REQ12534 Factory  
EXEC spALTER_TABLE 'Compra', 'ReferenciaMES', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Compra', 'MovIntelisisMES','  varchar(10)NULL'
GO

--REQ12615 WMS
EXEC spALTER_TABLE 'Compra', 'PosicionWMS', 'varchar(10) NULL'
GO

 --REQ 15739 
Exec spAlter_Table 'Compra','CFDFlexEstatus','varchar(15) Null'
EXEC spADD_INDEX 'Compra', 'CFDFlexEstatus', 'Estatus, CFDFlexEstatus'
GO

EXEC spFK 'Compra','Proveedor','Prov','Proveedor'
EXEC spFK 'Compra','Descuento','Descuento','Descuento'
EXEC spFK 'Compra','Almacen','Alm','Almacen'
EXEC spFK 'Compra','Agente','Agente','Agente'
EXEC spFK 'Compra','UEN','UEN','UEN'
EXEC spFK 'Compra','Mensaje','MensajeLista','Mensaje'
EXEC spFK 'Compra','LineaCredito','LC','LineaCredito'
EXEC spFK 'Compra','TipoAmortizacion','TipoAmortizacion','TipoAmortizacion'
EXEC spFK 'Compra','TipoTasa','TipoTasa','TipoTasa'
EXEC spFK 'Compra','Proyecto','Proy','Proyecto'
EXEC spFK 'Compra','VIN','VIN','VIN'
EXEC spFK 'Compra','Cliente','Cte','Cliente'
EXEC spFK 'Compra','Condicion','Condicion','Condicion'
GO

--BUG9637
EXEC spALTER_TABLE 'Compra', 'Retencion', 'float NULL'
EXEC spALTER_TABLE 'Compra', 'CrossDocking', 'bit NULL DEFAULT 0 WITH VALUES' -- 8. Desarrollo de proceso Cross Docking
GO

--Integración MES
EXEC spALTER_TABLE 'Compra', 'MesLanzamiento', 'varchar(100) NULL'
GO

-- Compra
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'Proveedor' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Proveedor    ON dbo.Compra (Proveedor)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia   ON dbo.Compra (Referencia)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Compra (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Compra (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Compra (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Compra (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Compra (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Compra (ContID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'VIN' AND sysobjects.id = sysindexes.id)
  CREATE INDEX VIN	     ON dbo.Compra (VIN)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Compra.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Compra.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Compra.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Compra.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Compra.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Compra (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Compra (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Compra' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Compra (OrigenID,Origen,Empresa)

-- Aqui va el Matenimiento a la tabla
GO
CREATE TRIGGER tgCompraC ON Compra
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
  
  SELECT @Modulo = 'COMS'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '')  FROM Deleted
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
    UPDATE Compra SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 

  IF @EstatusNuevo = 'CANCELADO'
    DELETE AgenteAgenda WHERE Modulo = 'COMS' AND ID = @ID
END
GO
CREATE TRIGGER tgCompraB ON Compra
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Mov	varchar(20),
    @MovID	varchar(20),
    @Estatus 	varchar(15),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Mov = Mov, @MovID = MovID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'COMS', @ID
END
GO

/****** Compras (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'CompraD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraD','Movimiento','COMS')
if not exists (select * from sysobjects where id = object_id('dbo.CompraD') and type = 'U') 
CREATE TABLE dbo.CompraD (
	ID 			int         	NOT NULL,
 	Renglon			float	    	NOT NULL,
	RenglonSub		int		NOT NULL   DEFAULT 0,

	RenglonID		int		NULL,
	RenglonTipo		char(1)	        NULL DEFAULT 'N',

        Cantidad                float       	NULL,
	Almacen			varchar(10)   	NULL,
	Codigo			varchar(30)	NULL,
	Articulo	        varchar(20)   	NOT NULL,
	SubCuenta		varchar(50)	NULL,
	FechaRequerida		datetime    	NULL,
	FechaOrdenar		datetime    	NULL,
	FechaEntrega		datetime    	NULL,
	CostoConImpuesto	float       	NULL,
        Costo	          	float       	NULL,
	Impuesto1		float		NULL,
	Impuesto2		float		NULL,
	Impuesto3		float		NULL,
	Impuesto5		float		NULL,
	Retencion1		float		NULL,
	Retencion2		float		NULL,
	Retencion3		float		NULL,
	Descuento		varchar(30)   	NULL,
	DescuentoTipo		char(1)    	NULL DEFAULT '%',
        DescuentoLinea		money		NULL,
	DescuentoImporte	money		NULL,
	DescripcionExtra	varchar(100) 	NULL,
	ReferenciaExtra		varchar(50)	NULL,
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20)	NULL,
	ContUso3		varchar(20)	NULL,
	ClavePresupuestal	varchar(50)	NULL,

	DestinoTipo		varchar(10)	NULL,
	Destino			varchar(20)	NULL,
	DestinoID		varchar(20)	NULL,

	Aplica			varchar(20)	NULL,
	AplicaID		varchar(20)	NULL,

	CantidadPendiente       float	    	NULL,
	CantidadCancelada	float		NULL,
	CantidadA		float	    	NULL,

	CostoInv		float		NULL,

	Unidad			varchar(50)	NULL,
	Factor			float	    	NULL DEFAULT 1.0,
        CantidadInventario      float     	NULL,
	Cliente			varchar(10)	NULL,

	ServicioArticulo	varchar(20)	NULL,
	ServicioSerie		varchar(20)	NULL,
	Paquete			int		NULL,

	Sucursal		int		NOT NULL DEFAULT 0,
	ImportacionProveedor	varchar(10)	NULL,
	ImportacionReferencia	varchar(50)	NULL,
	ProveedorRef		varchar(10)	NULL,
	AgenteRef		varchar(10)	NULL,
	EstadoRef		varchar(50)	NULL,
	FechaCaducidad		datetime	NULL,
	ProveedorArt		varchar(10)	NULL,
	ProveedorArtCosto	float		NULL,

	AjusteCosteo		money		NULL,
	CostoUEPS		money		NULL,
	CostoPEPS		money		NULL,
	UltimoCosto		money		NULL,
	CostoEstandar		money		NULL,
	PrecioLista		money		NULL,
	Posicion		varchar(10)	NULL,
	DepartamentoDetallista	int		NULL,

	Pais			varchar(50)	NULL,
	TratadoComercial	varchar(50)	NULL,
	ProgramaSectorial	varchar(50)	NULL,
	ValorAduana		money		NULL,
	ImportacionImpuesto1	float		NULL,
	ImportacionImpuesto2	float		NULL,
	ID1			char(2)		NULL,
	ID2			char(2)		NULL,
	FormaPago		varchar(50)	NULL,
	EsEstadistica		bit		NULL	DEFAULT 0,
	PresupuestoEsp		bit		NULL	DEFAULT 0,	
	Tarima				varchar(20)	NULL,
	EmpresaRef			varchar(5)	NULL,
	Categoria			varchar(50)	NULL,
	ABC					varchar(50)	NULL,
	Estado				varchar(30) NULL,
	PaqueteCantidad		float		NULL,
	CantidadEmbarcada	float		NULL,

	TipoImpuesto1		varchar(10)	NULL,
	TipoImpuesto2		varchar(10)	NULL,
	TipoImpuesto3		varchar(10)	NULL,
	TipoImpuesto4		varchar(10)	NULL,
	TipoImpuesto5		varchar(10)	NULL,
	TipoRetencion1		varchar(10)	NULL,
	TipoRetencion2		varchar(10)	NULL,
	TipoRetencion3		varchar(10)	NULL,
	CambioImpuesto		bit			NULL		DEFAULT 0,

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

	CostoPromedio		money	NULL,
	CostoReposicion		money	NULL,
	
	EmidaFechaRecarga	datetime NULL,				-- REQ12336
	EmidaURL			varchar(255) NULL,			-- REQ12336
	EmidaProveedorCelular	varchar(255) NULL,		-- REQ12336
	ArticuloMaquila         varchar(20) NULL,
	--TASK25114
	PosicionActual          varchar(10) NULL,
    PosicionReal            varchar(10) NULL,
	AplicaRenglon		float		NULL,

	CONSTRAINT priCompraD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO

/************** tgCompraD *************/
--JGD 12Abril2011 Ticket 4118 
if exists (select * from sysobjects where id = object_id('dbo.tgCompraD') and type = 'TR') drop trigger dbo.tgCompraD
GO
CREATE TRIGGER tgCompraD
ON CompraD
FOR INSERT, UPDATE
AS
BEGIN
  DECLARE
	@ID			int,
    @Cantidad	float,
    @Estatus	varchar(15),
    @Articulo	varchar(20),
    @Mensaje	varchar(255)

  SELECT @ID = ID,@Articulo = Articulo,@Cantidad = Cantidad FROM Inserted 
  SELECT @Estatus = Estatus FROM Compra WHERE ID = @ID
  IF @ID IS NOT NULL AND @Estatus = 'CONFIRMAR' AND NULLIF(@Cantidad,'') IS NULL
  BEGIN
    SELECT @Mensaje = 'No se pueden Guardar Cambios en un Movimiento con Estatus Por Confirmar. Articulo: ' + RTRIM(@Articulo)
    RAISERROR(@Mensaje , 16, -1)
    RETURN
  END

  RETURN
END
GO

if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CompraD' AND sysindexes.name = 'Aplica' AND sysobjects.id = sysindexes.id)
    DROP INDEX CompraD.Aplica
  ALTER TABLE CompraD ALTER COLUMN AplicaID varchar(20)
END
GO
if (select version from version) <= 1198
  ALTER TABLE CompraD ALTER COLUMN DestinoID varchar(20)
GO
EXEC spModificarPK_Sucursal 'CompraD', '(ID, Renglon, RenglonSub)'
EXEC spALTER_TABLE 'CompraD', 'DescuentoImporte', 'money NULL'
EXEC spALTER_TABLE 'CompraD', 'Paquete', 'int NULL'
EXEC spALTER_TABLE 'CompraD', 'ImportacionProveedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'ImportacionReferencia','varchar(50) NULL'
EXEC spALTER_TABLE 'CompraD', 'Retencion1', 'float NULL'
EXEC spALTER_TABLE 'CompraD', 'Retencion2', 'float NULL'
EXEC spALTER_TABLE 'CompraD', 'Retencion3', 'float NULL'
EXEC spALTER_TABLE 'CompraD', 'ProveedorRef', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'AgenteRef', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'CompraD', 'EstadoRef', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraD', 'FechaCaducidad', 'datetime NULL'
EXEC spALTER_TABLE 'CompraD', 'Codigo', 'varchar(30) NULL'
EXEC spALTER_TABLE 'CompraD', 'Descuento', 'varchar(30) NULL'
EXEC spALTER_TABLE 'CompraD', 'ProveedorArt', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'ProveedorArtCosto', 'money NULL'
EXEC spALTER_TABLE 'CompraD', 'CostoUEPS', 'money NULL'
EXEC spALTER_TABLE 'CompraD', 'CostoPEPS', 'money NULL'
EXEC spALTER_TABLE 'CompraD', 'UltimoCosto', 'money NULL'
EXEC spALTER_TABLE 'CompraD', 'PrecioLista', 'money NULL'
EXEC spALTER_TABLE 'CompraD', 'Posicion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'AjusteCosteo', 'money NULL'
EXEC spALTER_TABLE 'CompraD', 'DepartamentoDetallista', 'int NULL'
EXEC spALTER_TABLE 'CompraD', 'Pais', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'CompraD', 'TratadoComercial', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraD', 'ProgramaSectorial', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraD', 'ValorAduana', 'money NULL'
EXEC spALTER_TABLE 'CompraD', 'ImportacionImpuesto1', 'float NULL'
EXEC spALTER_TABLE 'CompraD', 'ImportacionImpuesto2', 'float NULL'
EXEC spALTER_TABLE 'CompraD', 'ID1', 'char(2) NULL'
EXEC spALTER_TABLE 'CompraD', 'ID2', 'char(2) NULL'
EXEC spALTER_TABLE 'CompraD', 'FormaPago', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraD', 'EsEstadistica', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CompraD', 'PresupuestoEsp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CompraD', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CompraD', 'ContUso3', 'varchar(20) NULL'
GO
EXEC spALTER_COLUMN 'CompraD', 'Impuesto3', 'float NULL'
GO
EXEC spALTER_TABLE 'CompraD', 'Tarima', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'CompraD', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraD', 'EmpresaRef', 'varchar(5)	NULL'
EXEC spALTER_TABLE 'CompraD', 'Categoria', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'CompraD' ,'Estado',   'varchar(30) NULL'
EXEC spALTER_TABLE 'CompraD', 'CostoEstandar', 'money	NULL'
GO
IF EXISTS(SELECT * FROM SysCampoExt WHERE Tabla='CompraD' AND Campo = 'Articulo' AND TipoDatos = 'char')
BEGIN
  EXEC spDROP_INDEX 'CompraD', 'Articulo'
  EXEC spDROP_INDEX 'CompraD', 'MatarPendiente'
END
EXEC spALTER_COLUMN 'CompraD', 'Articulo', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'CompraD', 'ABC', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraD', 'PaqueteCantidad', 'float NULL'
EXEC spALTER_TABLE 'CompraD', 'CantidadEmbarcada','float NULL'
EXEC spALTER_TABLE 'CompraD', 'ClavePresupuestal', 'varchar(50)	NULL'
GO
EXEC spALTER_COLUMN 'CompraD', 'ClavePresupuestal', 'varchar(50) NULL'
GO
EXEC spADD_INDEX 'CompraD', 'Articulo', 'Articulo, SubCuenta'
EXEC spADD_INDEX 'CompraD', 'Aplica', 'Aplica, AplicaID'
EXEC spADD_INDEX 'CompraD', 'MatarPendiente', 'ID, Articulo, SubCuenta'
go
EXEC spALTER_TABLE 'CompraD', 'TipoImpuesto1', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoImpuesto2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoImpuesto3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoImpuesto4', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoImpuesto5', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoRetencion1', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoRetencion2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoRetencion3', 'varchar(10) NULL'
GO
EXEC spALTER_COLUMN 'CompraD', 'Costo', 'float NULL'
EXEC spALTER_COLUMN 'CompraD', 'CostoInv', 'float NULL'
EXEC spALTER_COLUMN 'CompraD', 'ProveedorArtCosto', 'float NULL'
EXEC spALTER_TABLE 'CompraD', 'CostoConImpuesto', 'float NULL'
GO

EXEC spALTER_TABLE 'CompraD', 'CostoPromedio', 'money NULL'
EXEC spALTER_TABLE 'CompraD', 'CostoReposicion', 'money NULL'
GO

EXEC spALTER_TABLE 'CompraD', 'Impuesto5', 'float NULL'
GO

EXEC spALTER_TABLE 'CompraD', 'CambioImpuesto', 'bit NULL DEFAULT 0'
GO

IF NOT EXISTS(SELECT * FROM SysColumns sc JOIN SysObjects so ON sc.ID = so.ID WHERE so.ID = OBJECT_ID('CompraD') AND sc.Name = 'TipoComprobante')
BEGIN
  EXEC spALTER_TABLE 'CompraD', 'TipoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'CompraD', 'SustentoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'CompraD', 'TipoIdentificacion', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'CompraD', 'DerechoDevolucion', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'CompraD', 'Establecimiento', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'CompraD', 'PuntoEmision', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'CompraD', 'SecuencialSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'CompraD', 'AutorizacionSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'CompraD', 'VigenteA', 'AS CONVERT(datetime,NULL)'
  EXEC spALTER_TABLE 'CompraD', 'SecuenciaRetencion', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'CompraD', 'Comprobante', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'CompraD', 'FechaContableMov', 'AS CONVERT(datetime,NULL)'
END
GO

IF EXISTS(SELECT * FROM Empresa WHERE EsEcuador = 1) AND NOT EXISTS(SELECT ID FROM CompraD WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL)
BEGIN
  EXEC spDROP_COLUMN 'CompraD', 'TipoComprobante'
  EXEC spDROP_COLUMN 'CompraD', 'SustentoComprobante'
  EXEC spDROP_COLUMN 'CompraD', 'TipoIdentificacion'
  EXEC spDROP_COLUMN 'CompraD', 'DerechoDevolucion'
  EXEC spDROP_COLUMN 'CompraD', 'Establecimiento'
  EXEC spDROP_COLUMN 'CompraD', 'PuntoEmision'
  EXEC spDROP_COLUMN 'CompraD', 'SecuencialSRI'
  EXEC spDROP_COLUMN 'CompraD', 'AutorizacionSRI'
  EXEC spDROP_COLUMN 'CompraD', 'VigenteA'
  EXEC spDROP_COLUMN 'CompraD', 'SecuenciaRetencion'
  EXEC spDROP_COLUMN 'CompraD', 'Comprobante'
  EXEC spDROP_COLUMN 'CompraD', 'FechaContableMov'

  EXEC spALTER_TABLE 'CompraD', 'TipoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'CompraD', 'SustentoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'CompraD', 'TipoIdentificacion', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'CompraD', 'DerechoDevolucion', 'bit NULL'
  EXEC spALTER_TABLE 'CompraD', 'Establecimiento', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'CompraD', 'PuntoEmision', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'CompraD', 'SecuencialSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'CompraD', 'AutorizacionSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'CompraD', 'VigenteA', 'datetime NULL'
  EXEC spALTER_TABLE 'CompraD', 'SecuenciaRetencion', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'CompraD', 'Comprobante', 'bit NULL'
  EXEC spALTER_TABLE 'CompraD', 'FechaContableMov', 'datetime NULL'
END
GO

EXEC spFK2 'CompraD','Almacen','Posicion','AlmPos','Almacen','Posicion'
EXEC spFK 'CompraD','Codigo','CB','Codigo'
EXEC spFK 'CompraD','Articulo','Art','Articulo'
EXEC spFK 'CompraD','Cliente','Cte','Cliente'
EXEC spFK 'CompraD','ContUso','CentroCostos','CentroCostos'
EXEC spFK 'CompraD','Descuento','Descuento','Descuento'
GO

-- REQ12336
EXEC spALTER_TABLE 'CompraD', 'EmidaFechaRecarga', 'datetime NULL'
GO
-- REQ12336
EXEC spALTER_TABLE 'CompraD', 'EmidaURL', 'varchar(255) NULL'
GO
-- REQ12336
EXEC spALTER_TABLE 'CompraD', 'EmidaProveedorCelular', 'varchar(255) NULL'
GO

EXEC spALTER_TABLE 'CompraD', 'ArticuloMaquila', 'varchar(20) NULL '
GO
--TASK25114
GO
EXEC spALTER_TABLE 'CompraD', 'PosicionActual', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'PosicionReal', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'AplicaRenglon', 'float NULL'
EXEC spALTER_TABLE 'CompraD', 'MonedaD',     'VARCHAR (10)  NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoCambioD', 'FLOAT NULL'
GO

--Integración MES
EXEC spALTER_TABLE 'CompraD', 'MesLanzamiento', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CompraD', 'AplicaRenglon', 'float NULL'
GO

EXEC spALTER_TABLE 'CompraD', 'ArticuloMaquila', 'varchar(20) NULL'
GO


/****** Compras Importacion ******/
if not exists (select * from SysTabla where SysTabla = 'CompraImportacion') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraImportacion','Movimiento','COMS')
if not exists(select * from sysobjects where type = 'u' and id = object_id('dbo.CompraImportacion'))
CREATE TABLE CompraImportacion(
	ID				int,
	RenglonID			int			NOT NULL,
	Documento			varchar(50)		NULL,
	FechaDocumento			datetime		NULL,
	GuiaEntrega			varchar(20)		NULL,
	FechaGuia			datetime		NULL,
	Convenio			varchar(50)		NULL,
	PuertoCarga			varchar(50)		NULL,
	FechaCarga			datetime		NULL,
	PuertoDestino		varchar(50)		NULL,
	FechaDestino		datetime		NULL,
	Paquetes			int				NULL
CONSTRAINT priCompraImportacion PRIMARY KEY(ID))

if not exists(select * from sysobjects where type = 'u' and id = object_id('dbo.CompraExtraccionLista'))
CREATE TABLE CompraExtraccionLista(
	Estacion			int,
	ID					int,
	Renglon				float,
	RenglonSub			int,
	RenglonID			int,
	SerieLote			varchar(50),
	CantidadA			float			NULL,
	Observaciones		varchar(100)	NULL
CONSTRAINT priCompraExtraccionLista PRIMARY KEY(ID, Renglon, RenglonSub, RenglonID, SerieLote, Estacion))
GO

EXEC spALTER_TABLE 'CompraExtraccionLista', 'Observaciones', 'varchar(100) NULL'
GO

if exists (select * from sysobjects where id = object_id('dbo.cCompraD') and sysstat & 0xf = 2) drop view dbo.cCompraD
GO
CREATE VIEW cCompraD
--//WITH ENCRYPTION
AS
	SELECT
		ID,
		Renglon,
		RenglonSub,

		RenglonID,
		RenglonTipo,

		Cantidad,
		Almacen,
		Codigo,
		Articulo,
		SubCuenta,
		FechaRequerida,
		FechaOrdenar,
		FechaEntrega,
		CostoConImpuesto,
		Costo,
		Impuesto1,
		Impuesto2,
		Impuesto3,
		Impuesto5,
		Retencion1,
		Retencion2,
		Retencion3,
		Descuento,
		DescuentoTipo,
		DescuentoLinea,
		DescuentoImporte,
		DescripcionExtra,
		ReferenciaExtra,
		ContUso,
		ContUso2,
		ContUso3,
		ClavePresupuestal,

		DestinoTipo,
		Destino,
		DestinoID,

		Aplica,
		AplicaID,

		CantidadPendiente,
		CantidadCancelada,
		CantidadA,

		CostoInv,

		Unidad,
		Factor,
		CantidadInventario,
		Cliente,

		ServicioArticulo,
		ServicioSerie,
		Paquete,

		Sucursal,
		SucursalOrigen,

		ImportacionProveedor,
		ImportacionReferencia,
		ProveedorRef,
		AgenteRef,
		FechaCaducidad,
		Posicion,

		Pais,
		TratadoComercial,
		ProgramaSectorial,
		ValorAduana,
		ImportacionImpuesto1,
		ImportacionImpuesto2,
		ID1,
		ID2,
		FormaPago,
		EsEstadistica,
		PresupuestoEsp,
		Tarima,
		EmpresaRef,
		Categoria,
		ABC,
		TipoImpuesto1,
		TipoImpuesto2,
		TipoImpuesto3,
		TipoImpuesto4,
		TipoImpuesto5,
		TipoRetencion1,
		TipoRetencion2,
		TipoRetencion3,
		ArticuloMaquila,
		AplicaRenglon,
		MonedaD,
		TipoCambioD,
		MesLanzamiento
	FROM
		CompraD
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCompraDAC') and sysstat & 0xf = 8) drop trigger dbo.tgCompraDAC
GO
-- Aqui va el Matenimiento a la tabla
-- este trigger ya no aplica porque con los presupuestos por categoria el articulo es opcional
/*CREATE TRIGGER tgCompraDAC ON CompraD
FOR INSERT, UPDATE
AS BEGIN
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF NOT UPDATE(Articulo) RETURN
  DECLARE
    @ID		int,
    @Renglon	float,
    @RenglonSub int

  SELECT @ID = MIN(ID), @Renglon = MIN(Renglon), @RenglonSub = MIN(RenglonSub) FROM Inserted WHERE NULLIF(RTRIM(Articulo), '') IS NULL
  IF @ID IS NOT NULL AND @Renglon IS NOT NULL AND @RenglonSub IS NOT NULL
    DELETE CompraD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
END*/
GO

/****** CompraCB ******/
if not exists(select * from SysTabla where SysTabla = 'CompraCB')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraCB','Movimiento','COMS')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.CompraCB') AND Type = 'U')
CREATE TABLE CompraCB(

	ID			int			NOT NULL,
	RenglonID		int			NOT NULL,
	Codigo			varchar(20)		NOT NULL,

	Cantidad		float			NULL,
	Articulo		varchar(20)		NULL,
	SubCuenta		varchar(50)		NULL,

    CONSTRAINT priCompraCB PRIMARY KEY CLUSTERED (ID, RenglonID, Codigo)
)
GO
EXEC spModificarPK_Sucursal 'CompraCB', '(ID, RenglonID, Codigo)'
GO
EXEC spALTER_COLUMN 'CompraCB', 'SubCuenta', 'varchar(50) NULL'
GO

/****** CompraGastoDiversoProv ******/
if not exists (select * from SysTabla where SysTabla = 'CompraGastoDiversoProv') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraGastoDiversoProv','Movimiento','COMS')
if not exists (select * from sysobjects where id = object_id('dbo.CompraGastoDiversoProv') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CompraGastoDiversoProv (
	ID			    int 	    NOT NULL,
    Concepto        varchar(50) NOT NULL,
	Proveedor		varchar(10)	NOT NULL,

	CONSTRAINT priCompraGastoDiversoProv PRIMARY KEY CLUSTERED (ID, Concepto, Proveedor)
  )
  EXEC spSincroSemilla 'CompraGastoDiversoProv'
END
GO

/****** CompraGastoDiversoRef ******/
if not exists (select * from SysTabla where SysTabla = 'CompraGastoDiversoRef') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraGastoDiversoRef','Movimiento','COMS')
if not exists (select * from sysobjects where id = object_id('dbo.CompraGastoDiversoRef') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CompraGastoDiversoRef (
	ID			    int 	    NOT NULL,
    Concepto        varchar(50) NOT NULL,
	Referencia		varchar(50)	NOT NULL,

	CONSTRAINT priCompraGastoDiversoRef PRIMARY KEY CLUSTERED (ID, Concepto, Referencia)
  )
  EXEC spSincroSemilla 'CompraGastoDiversoRef'
END
GO

/****** CompraGastoDiversoArt ******/
if not exists (select * from SysTabla where SysTabla = 'CompraGastoDiversoArt') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraGastoDiversoArt','Movimiento','COMS')
if not exists (select * from sysobjects where id = object_id('dbo.CompraGastoDiversoArt') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CompraGastoDiversoArt (
	ID			    int 	    NOT NULL,
    Concepto        varchar(50) NOT NULL,
	Articulo		varchar(20)	NOT NULL,

	CONSTRAINT priCompraGastoDiversoArt PRIMARY KEY CLUSTERED (ID, Concepto, Articulo)
  )
  EXEC spSincroSemilla 'CompraGastoDiversoArt'
END
GO

/****** CompraGastoDiverso ******/
if not exists (select * from SysTabla where SysTabla = 'CompraGastoDiverso') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraGastoDiverso','Movimiento','COMS')
if not exists (select * from sysobjects where id = object_id('dbo.CompraGastoDiverso') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CompraGastoDiverso (
	ID			int 	    	NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	Acreedor		varchar(10)	NOT NULL,
	RenglonID		int		IDENTITY(1,1) NOT NULL,

	Importe			money		NULL,
	PorcentajeImpuestos	float		NULL,
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,
	Prorrateo		varchar(20)	NULL,
	FechaEmision		datetime	NULL,
	Condicion		varchar(50)	NULL,
	Vencimiento		datetime	NULL,
	Referencia		varchar(50)	NULL,
	Retencion		money		NULL,
	Retencion2		money		NULL,
	Retencion3		money		NULL,
	Impuestos		money		NULL,
	Multiple		bit		NULL 	 DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,
	PedimentoEspecifico	varchar(20)	NULL,

	CONSTRAINT priCompraGastoDiverso PRIMARY KEY CLUSTERED (ID, Concepto, Acreedor, RenglonID)
  )
  EXEC spSincroSemilla 'CompraGastoDiverso'
END
if exists (select * from sysobjects where id = object_id('dbo.tgCompraGastoDiversoABC') and sysstat & 0xf = 8) drop trigger dbo.tgCompraGastoDiversoABC
GO
GO
EXEC spModificarPK_Sucursal 'CompraGastoDiverso', '(ID, Concepto, Acreedor)'
GO
EXEC spALTER_TABLE 'CompraGastoDiverso', 'PedimentoEspecifico', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CompraGastoDiverso', 'Retencion', 'money NULL'
EXEC spALTER_TABLE 'CompraGastoDiverso', 'Retencion2', 'money NULL'
EXEC spALTER_TABLE 'CompraGastoDiverso', 'ProrrateoNivel', 'varchar(20) NULL'
GO
if not exists(select * from syscampo where tabla = 'CompraGastoDiverso' AND Campo = 'RenglonID')
BEGIN
  EXEC("spALTER_TABLE 'CompraGastoDiverso', 'RenglonID', 'int IDENTITY(1,1) NOT NULL'")
  EXEC("spEliminarPK 'CompraGastoDiverso'")
  EXEC("ALTER TABLE CompraGastoDiverso ADD CONSTRAINT priCompraGastoDiverso PRIMARY KEY CLUSTERED (ID, Concepto, Acreedor, RenglonID)")
END
GO
EXEC spALTER_TABLE 'CompraGastoDiverso', 'Retencion3', 'money NULL'
GO

EXEC spFK 'CompraGastoDiverso','ID','Compra','ID'
EXEC spFK 'CompraGastoDiverso','Acreedor','Prov','Proveedor'
GO

-- Aqui va el Matenimiento a la tabla


/****** CompraGastoDiversoD ******/
if not exists (select * from SysTabla where SysTabla = 'CompraGastoDiversoD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraGastoDiversoD','Movimiento','COMS')
if not exists (select * from sysobjects where id = object_id('dbo.CompraGastoDiversoD') and type = 'U') 
CREATE TABLE dbo.CompraGastoDiversoD (
	ID			int 	    	NOT NULL,
	RenglonID		int		NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	Acreedor		varchar(10)	NOT NULL,
	ConceptoD		varchar(50)	NOT NULL,

	Importe			money		NULL,
	Retencion		money		NULL,
	Retencion2		money		NULL,
	Retencion3		money		NULL,
	Impuestos		money		NULL,
	Referencia		varchar(50)	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCompraGastoDiversoD PRIMARY KEY CLUSTERED (ID, RenglonID, Concepto, Acreedor, ConceptoD)
)
GO
EXEC spModificarPK_Sucursal 'CompraGastoDiversoD', '(ID, Concepto, Acreedor, ConceptoD)'
EXEC spALTER_TABLE 'CompraGastoDiversoD', 'Retencion', 'money NULL'
EXEC spALTER_TABLE 'CompraGastoDiversoD', 'Retencion2', 'money NULL'
GO
if not exists(select * from syscampo where tabla = 'CompraGastoDiversoD' AND Campo = 'RenglonID')
BEGIN
  EXEC("spALTER_TABLE 'CompraGastoDiversoD', 'RenglonID', 'int NULL'")
  EXEC("UPDATE CompraGastoDiversoD SET RenglonID = g.RenglonID FROM CompraGastoDiverso g, CompraGastoDiversoD d WHERE d.ID = g.ID AND d.Concepto = g.Concepto AND d.Acreedor = g.Acreedor")
  EXEC("DELETE CompraGastoDiversoD WHERE RenglonID IS NULL")
  EXEC("ALTER TABLE CompraGastoDiversoD ALTER COLUMN RenglonID int NOT NULL")
  EXEC("spEliminarPK 'CompraGastoDiversoD'")
  EXEC("ALTER TABLE CompraGastoDiversoD ADD CONSTRAINT priCompraGastoDiversoD PRIMARY KEY CLUSTERED (ID, RenglonID, Concepto, Acreedor, ConceptoD)")
END
GO
EXEC spALTER_TABLE 'CompraGastoDiversoD', 'Retencion3', 'money NULL'
GO

if (select version from version) <= 2226 and exists (select * from sysobjects where id = object_id('dbo.CompraDProrrateo') and type = 'U') 
  drop table CompraDProrrateo
go

/****** CompraDProrrateo ******/
if not exists (select * from SysTabla where SysTabla = 'CompraDProrrateo') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraDProrrateo','Movimiento','COMS')
if not exists (select * from sysobjects where id = object_id('dbo.CompraDProrrateo') and type = 'U') 
  CREATE TABLE dbo.CompraDProrrateo (
	ID			int 	    	NOT NULL,
	IDRenglon		int		IDENTITY(1,1) NOT NULL,
	
	RenglonID		int		NULL,
	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,

	Almacen			varchar(10)	NULL,
	Cantidad		float		NULL,

	CONSTRAINT priCompraDProrrateo PRIMARY KEY CLUSTERED (ID, IDRenglon)
)
GO
EXEC spModificarPK_Sucursal 'CompraDProrrateo', '(ID, IDRenglon)'
GO

EXEC spFK 'CompraDProrrateo','Almacen','Alm','Almacen'
GO


/****** CompraDPresupuestoEsp ******/
if not exists (select * from SysTabla where SysTabla = 'CompraDPresupuestoEsp') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraDPresupuestoEsp','Movimiento','COMS')
if not exists (select * from sysobjects where id = object_id('dbo.CompraDPresupuestoEsp') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CompraDPresupuestoEsp (
	ID 			int             NOT NULL,
	Renglon			float		NOT NULL,
	RenglonSub		int		NOT NULL,
	CuentaPresupuesto	varchar(20)	NOT NULL,

	Importe			money		NULL,

	CONSTRAINT priCompraDPresupuestoEsp PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub, CuentaPresupuesto)
  )
  EXEC spSincroSemilla 'CompraDPresupuestoEsp'
END
GO
EXEC spModificarPK_Sucursal 'CompraDPresupuestoEsp', '(ID, Renglon, RenglonSub, CuentaPresupuesto)'
GO

EXEC spFK 'CompraDPresupuestoEsp','CuentaPresupuesto','Cta','Cuenta'
GO

/****** CompraGastoProrrateo ******/
if not exists (select * from SysTabla where SysTabla = 'CompraGastoProrrateo') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraGastoProrrateo','Movimiento','COMS')
IF NOT EXISTS (select * from sysobjects where id = object_id('dbo.CompraGastoProrrateo') and type = 'U') --DROP TABLE CompraGastoProrrateo
CREATE TABLE CompraGastoProrrateo (
        ID                  int             NOT NULL,
        Renglon             float           NOT NULL,
        RenglonSub          int             NOT NULL,
        Articulo            varchar(20)     NOT NULL,
        IDRenglon           int             NOT NULL,
        Concepto            varchar(50)     NOT NULL,
        ValorAlmacen        money           NULL,
        ValorAduana         money           NULL,
)
GO