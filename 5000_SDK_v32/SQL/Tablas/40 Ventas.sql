/*******************************************************************************************/
/*                                            VENTAS                                       */
/*******************************************************************************************/

/****** Indicadores Venta ******/
if not exists(select * from SysTabla where SysTabla = 'VentaActivoFIndicador')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('VentaActivoFIndicador', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.VentaActivoFIndicador') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VentaActivoFIndicador (
        ID			int		NOT NULL,
	RID			int		NOT NULL IDENTITY(1,1),
	
	Indicador		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,
	LecturaAnterior		varchar(100)	NULL,
	Lectura			varchar(100)	NULL,
	
	CONSTRAINT priVentaActivoFIndicador PRIMARY KEY  CLUSTERED (ID, RID)
  )
END
GO

/****** VentaDLogPicos (Log Cancelacion) ******/
if not exists(select * from SysTabla where SysTabla = 'VentaDLogPicos')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaDLogPicos','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaDLogPicos') and type = 'U') 
CREATE TABLE dbo.VentaDLogPicos (
	ID 			int       	NOT NULL,
	Renglon			float	  	NOT NULL,
	RenglonSub		int		NOT NULL,

	CantidadCancelada	float		NULL,
	FechaCancelacion	datetime	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priVentaDLogPicos PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO
EXEC spModificarPK_Sucursal 'VentaDLogPicos', '(ID, Renglon, RenglonSub)'
GO

/****** NotaCobro ******/
if not exists(select * from SysTabla where SysTabla = 'NotaCobro')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('NotaCobro','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.NotaCobro') and type = 'U') 
CREATE TABLE dbo.NotaCobro (
	ID 			int         	NOT NULL,

	Importe1		money		NULL,
	Importe2		money		NULL,
	Importe3		money		NULL,
	Importe4		money		NULL,
	Importe5		money		NULL,

	FormaCobro1 		varchar(50)   	NULL,
	FormaCobro2 		varchar(50)   	NULL,
	FormaCobro3 		varchar(50)   	NULL,
	FormaCobro4 		varchar(50)   	NULL,
	FormaCobro5 		varchar(50)   	NULL,

	Referencia1		varchar(50)   	NULL,
	Referencia2		varchar(50)   	NULL,
	Referencia3		varchar(50)   	NULL,
	Referencia4		varchar(50)   	NULL,
	Referencia5		varchar(50)	NULL,

	Observaciones1		varchar(100)   	NULL,
	Observaciones2		varchar(100)   	NULL,
	Observaciones3		varchar(100)   	NULL,
	Observaciones4		varchar(100)   	NULL,
	Observaciones5		varchar(100)	NULL,

	Cambio			money		NULL,
	Redondeo		money		NULL,
	DelEfectivo		money		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	CtaDinero		varchar(10)	NULL,
	Cajero			varchar(10)	NULL,
	Condicion		varchar(50)	NULL,
	Vencimiento		datetime	NULL,
	Actualizado		bit		NULL,

	TotalCobrado 		AS (ISNULL(Importe1, 0.0) + ISNULL(Importe2, 0.0) + ISNULL(Importe3, 0.0) + ISNULL(Importe4, 0.0) + ISNULL(Importe5, 0.0) - ISNULL(Cambio, 0.0)),

	CONSTRAINT priNotaCobro PRIMARY KEY CLUSTERED (ID)
)
GO
EXEC spModificarPK_Sucursal 'NotaCobro', '(ID)'
GO

/****** VentaCobro ******/
if not exists(select * from SysTabla where SysTabla = 'VentaCobro')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaCobro','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaCobro') and type = 'U') 
CREATE TABLE dbo.VentaCobro (
	ID 			int         	NOT NULL,

	Importe1		money		NULL,
	Importe2		money		NULL,
	Importe3		money		NULL,
	Importe4		money		NULL,
	Importe5		money		NULL,

	FormaCobro1 		varchar(50)   	NULL,
	FormaCobro2 		varchar(50)   	NULL,
	FormaCobro3 		varchar(50)   	NULL,
	FormaCobro4 		varchar(50)   	NULL,
	FormaCobro5 		varchar(50)   	NULL,

	Referencia1		varchar(50)   	NULL,
	Referencia2		varchar(50)   	NULL,
	Referencia3		varchar(50)   	NULL,
	Referencia4		varchar(50)   	NULL,
	Referencia5		varchar(50)	NULL,

	Observaciones1		varchar(100)   	NULL,
	Observaciones2		varchar(100)   	NULL,
	Observaciones3		varchar(100)   	NULL,
	Observaciones4		varchar(100)   	NULL,
	Observaciones5		varchar(100)	NULL,

	Cambio				money		NULL,
	FormaCobroCambio	varchar(50)	NULL, --MEJORA5512
	Redondeo			money		NULL,
	DelEfectivo			money		NULL,
	Sucursal			int		NOT NULL DEFAULT 0,
	CtaDinero			varchar(10)	NULL,
	Cajero				varchar(10)	NULL,
	Condicion			varchar(50)	NULL,
	Vencimiento			datetime	NULL,
	Actualizado			bit		NULL,
	POSTipoCambio1                  float           NULL, --REQ 13393
	POSTipoCambio2                  float           NULL, --REQ 13393
	POSTipoCambio3                  float           NULL, --REQ 13393
	POSTipoCambio4                  float           NULL, --REQ 13393
	POSTipoCambio5                  float           NULL, --REQ 13393

	TotalCobrado 		AS (ISNULL(Importe1, 0.0) + ISNULL(Importe2, 0.0) + ISNULL(Importe3, 0.0) + ISNULL(Importe4, 0.0) + ISNULL(Importe5, 0.0) - ISNULL(Cambio, 0.0)),

	CONSTRAINT priVentaCobro PRIMARY KEY CLUSTERED (ID)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgVentaCobroC') and sysstat & 0xf = 8) drop trigger dbo.tgVentaCobroC
GO
-- select * from ventacobro
EXEC spModificarPK_Sucursal 'VentaCobro', '(ID)'
GO
EXEC spALTER_TABLE 'VentaCobro', 'CtaDinero', 'varchar(10) NULL'
EXEC spALTER_TABLE 'VentaCobro', 'Cajero', 'varchar(10) NULL'
EXEC spALTER_TABLE 'VentaCobro', 'Redondeo', 'money NULL'
EXEC spALTER_TABLE 'VentaCobro', 'Condicion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'VentaCobro', 'Vencimiento', 'datetime NULL'
EXEC spALTER_TABLE 'VentaCobro', 'Actualizado', 'bit NULL'
EXEC spALTER_TABLE 'VentaCobro', 'Observaciones1', 'varchar(100) NULL'
EXEC spALTER_TABLE 'VentaCobro', 'Observaciones2', 'varchar(100) NULL'
EXEC spALTER_TABLE 'VentaCobro', 'Observaciones3', 'varchar(100) NULL'
EXEC spALTER_TABLE 'VentaCobro', 'Observaciones4', 'varchar(100) NULL'
EXEC spALTER_TABLE 'VentaCobro', 'Observaciones5', 'varchar(100) NULL'
GO
EXEC spALTER_TABLE 'VentaCobro', 'FormaCobroCambio', 'varchar(50) NULL' --MEJORA5512
GO

EXEC spAlter_Table 'VentaCobro', 'POSTipoCambio1', 'float NULL' --REQ 13393
EXEC spAlter_Table 'VentaCobro', 'POSTipoCambio2', 'float NULL' --REQ 13393
EXEC spAlter_Table 'VentaCobro', 'POSTipoCambio3', 'float NULL' --REQ 13393
EXEC spAlter_Table 'VentaCobro', 'POSTipoCambio4', 'float NULL' --REQ 13393
EXEC spAlter_Table 'VentaCobro', 'POSTipoCambio5', 'float NULL' --REQ 13393
GO

EXEC spALTER_TABLE 'VentaCobro', 'TCProcesado1', 'bit NOT NULL DEFAULT 0 WITH VALUES' -- REQ13163
EXEC spALTER_TABLE 'VentaCobro', 'TCProcesado2', 'bit NOT NULL DEFAULT 0 WITH VALUES' -- REQ13163
EXEC spALTER_TABLE 'VentaCobro', 'TCProcesado3', 'bit NOT NULL DEFAULT 0 WITH VALUES' -- REQ13163
EXEC spALTER_TABLE 'VentaCobro', 'TCProcesado4', 'bit NOT NULL DEFAULT 0 WITH VALUES' -- REQ13163
EXEC spALTER_TABLE 'VentaCobro', 'TCProcesado5', 'bit NOT NULL DEFAULT 0 WITH VALUES' -- REQ13163
EXEC spALTER_TABLE 'VentaCobro', 'TCDelEfectivo', 'money NULL' -- REQ13163
GO
EXEC spALTER_TABLE 'VentaCobro', 'TCCxcIDAplicacion', 'int NULL' -- REQ13163
GO

if not exists(select * from syscampo where tabla = 'VentaCobro' and campo = 'TotalCobrado')
  ALTER TABLE VentaCobro ADD TotalCobrado AS (ISNULL(Importe1, 0.0) + ISNULL(Importe2, 0.0) + ISNULL(Importe3, 0.0) + ISNULL(Importe4, 0.0) + ISNULL(Importe5, 0.0) - ISNULL(Cambio, 0.0))
GO

EXEC spFK 'VentaCobro','CtaDinero','CtaDinero','CtaDinero'
EXEC spFK 'VentaCobro','ID','Venta','ID'
GO

-- VentaCobro
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VentaCobro' AND sysindexes.name = 'CtaDinero' AND sysobjects.id = sysindexes.id)
  CREATE INDEX CtaDinero on VentaCobro (CtaDinero, Cajero)
GO
CREATE TRIGGER tgVentaCobroC ON VentaCobro
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Mensaje		varchar(255),
    @ID			int,
    @Actualizado	bit
  
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Actualizado = ISNULL(Actualizado, 0) FROM Inserted
  IF @Actualizado = 0
  BEGIN
    IF (SELECT Estatus FROM Venta WHERE ID = @ID) IN ('PENDIENTE', 'PROCESAR', 'CONCLUIDO', 'CANCELADO')
    BEGIN
      SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
      RAISERROR (@Mensaje,16,-1) 
    END 
  END
END
GO


if exists (select * from sysobjects where id = object_id('dbo.cVentaCobro') and sysstat & 0xf = 2) drop view dbo.cVentaCobro
GO
CREATE VIEW cVentaCobro
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Importe1,
  Importe2,
  Importe3,
  Importe4,
  Importe5,
  FormaCobro1,
  FormaCobro2,
  FormaCobro3,
  FormaCobro4,
  FormaCobro5,
  Referencia1,
  Referencia2,
  Referencia3,
  Referencia4,
  Referencia5,
  Cambio,
  Redondeo, 
  DelEfectivo,
  Sucursal,
  SucursalOrigen,
  CtaDinero,
  Cajero

FROM
  VentaCobro
GO
-- drop table NotaCobroD
/****** NotaCobroD ******/
if not exists(select * from SysTabla where SysTabla = 'NotaCobroD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('NotaCobroD','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.NotaCobroD') and type = 'U') 
CREATE TABLE dbo.NotaCobroD (
	ID 			int         	NOT NULL,
	RenglonID		int		NOT NULL,	

	Importe			money		NULL,
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,
	FormaCobro 		varchar(50)   	NULL,
	Referencia		varchar(50)   	NULL,

	Sucursal		int		NOT NULL DEFAULT 0,


	CONSTRAINT priNotaCobroD PRIMARY KEY CLUSTERED (ID, RenglonID)
)
GO
EXEC spModificarPK_Sucursal 'NotaCobroD', '(ID, RenglonID)'
GO

/****** VentaCobroD ******/
if not exists(select * from SysTabla where SysTabla = 'VentaCobroD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaCobroD','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaCobroD') and type = 'U') 
CREATE TABLE dbo.VentaCobroD (
	ID 			int         	NOT NULL,
	RenglonID		int		NOT NULL  IDENTITY(1,1),	

	Importe			money		NULL,
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,
	FormaCobro 		varchar(50)   	NULL,
	Referencia		varchar(50)   	NULL,

	Sucursal		int		NOT NULL DEFAULT 0,


	CONSTRAINT priVentaCobroD PRIMARY KEY CLUSTERED (ID, RenglonID)
)
GO
EXEC spModificarPK_Sucursal 'VentaCobroD', '(ID, RenglonID)'
GO

if exists (select * from sysobjects where id = object_id('dbo.cVentaCobroD') and sysstat & 0xf = 2) drop view dbo.cVentaCobroD
GO
CREATE VIEW cVentaCobroD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Importe,
  Moneda,
  TipoCambio,
  FormaCobro,
  Referencia,
  Sucursal,
  SucursalOrigen

FROM
  VentaCobroD
GO

/****** VentaOrigenRedondeo ******/
if not exists(select * from SysTabla where SysTabla = 'VentaOrigenRedondeo')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaOrigenRedondeo','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaOrigenRedondeo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VentaOrigenRedondeo (
	ID 			int         	NOT NULL,
	RenglonID		int		NOT NULL  IDENTITY(1,1),

	OrigenID		int		NOT NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priVentaOrigenRedondeo PRIMARY KEY CLUSTERED (ID, RenglonID)
  )  
END
GO

/****** VentaOrigen ******/
if not exists(select * from SysTabla where SysTabla = 'VentaOrigen')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaOrigen','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaOrigen') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VentaOrigen (
	ID 			int         	NOT NULL,
	RenglonID		int		NOT NULL  IDENTITY(1,1),

	OrigenID		int		NOT NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priVentaOrigen PRIMARY KEY CLUSTERED (ID, RenglonID)
  )
  EXEC spSincroSemilla 'VentaOrigen'
END
GO
if (select version from version) between 1100 and 1107
BEGIN
  EXEC spEliminarPK 'VentaOrigen'
  ALTER TABLE VentaOrigen ADD CONSTRAINT priVentaOrigen PRIMARY KEY CLUSTERED (ID, OrigenID)
END
GO
if not exists(select * from syscampo where tabla = 'VentaOrigen' and campo = 'RenglonID')
BEGIN
  EXEC("ALTER TABLE VentaOrigen ADD RenglonID int NOT NULL IDENTITY(1,1)")
  EXEC("spEliminarPK 'VentaOrigen'")
  EXEC("ALTER TABLE VentaOrigen ADD CONSTRAINT priVentaOrigen PRIMARY KEY CLUSTERED (ID, RenglonID)")
  EXEC("spSincroSemilla 'VentaOrigen'")
END
GO
EXEC spModificarPK_Sucursal 'VentaOrigen', '(ID, RenglonID)'
GO

/****** VentaResumen ******/
if exists(select * from SysTabla where SysTabla = 'VentaResumen') and (select version from version)<=2404
  drop table VentaResumen
go
if not exists(select * from SysTabla where SysTabla = 'VentaResumen')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaResumen','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaResumen') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VentaResumen (
	ID 			int         	NOT NULL,
	RenglonID		int		NOT NULL  IDENTITY(1,1),

	Sucursal		int		NOT NULL DEFAULT 0,
	Mov			varchar(20)	NULL,
	MovID			varchar(20)	NULL,
	FechaEmision		datetime	NULL,
	Cliente			varchar(10)	NULL,
	Agente			varchar(10)	NULL,
	Importe			money		NULL,
	Impuestos		money		NULL,

	CONSTRAINT priVentaResumen PRIMARY KEY CLUSTERED (ID, RenglonID)
  )
  EXEC spSincroSemilla 'VentaResumen'
END
GO
EXEC spModificarPK_Sucursal 'VentaResumen', '(ID, RenglonID)'
GO

EXEC spFK 'VentaResumen','Cliente','Cte','Cliente'
GO

/****** VentaOtros ******/
if not exists(select * from SysTabla where SysTabla = 'VentaOtros')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaOtros','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaOtros') and type = 'U') 
CREATE TABLE dbo.VentaOtros (
	ID 			int         	NOT NULL,
	
	Tapones			bit		NOT NULL DEFAULT 0,
	Tapetes			bit		NOT NULL DEFAULT 0,
	Espejos			bit		NOT NULL DEFAULT 0,
	FarosAlojeno		bit		NOT NULL DEFAULT 0,
	RadioCassette		bit		NOT NULL DEFAULT 0,
	Cenicero		bit		NOT NULL DEFAULT 0,

	LlantaRefaccion		bit		NOT NULL DEFAULT 0,
	Gato			bit		NOT NULL DEFAULT 0,
	Encendedor		bit		NOT NULL DEFAULT 0,
	Antena			bit		NOT NULL DEFAULT 0,
	Herramienta		bit		NOT NULL DEFAULT 0,
	Limpiadores		bit		NOT NULL DEFAULT 0,

	Gasolina		int		NULL,

	RayonesGolpes		varchar(255)	NULL,
	ObjetosUnidad		varchar(255)	NULL,
	Observaciones		varchar(255)	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,

	Coordenadas		varchar(255)	NULL,


	CONSTRAINT priVentaOtros PRIMARY KEY CLUSTERED (ID)
)
GO
EXEC spModificarPK_Sucursal 'VentaOtros', '(ID)'
GO
EXEC spALTER_TABLE 'VentaOtros', 'Coordenadas', 'varchar(255) NULL'
GO

/****** OportunidadEtapa ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadEtapa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OportunidadEtapa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadEtapa') and type = 'U') 
CREATE TABLE dbo.OportunidadEtapa (
	Etapa			varchar(50)	NOT NULL,

	Avance			float		NULL,

	CONSTRAINT priOportunidadEtapa PRIMARY KEY  CLUSTERED (Etapa)
)
GO

/****** VentaOportunidad ******/
if not exists(select * from SysTabla where SysTabla = 'VentaOportunidad')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaOportunidad','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaOportunidad') and type = 'U') 
CREATE TABLE dbo.VentaOportunidad (
	ID 			int         	NOT NULL,

	ImporteEstimado		money		NULL,
	Etapa			varchar(50)	NULL,
	Avance			float		NULL,
	ProbabilidadCierre	float		NULL,
	FechaEstimadaCierre	datetime	NULL,
	PresupuestoAsignado	money		NULL,

	Observaciones		varchar(255)	NULL,

	CONSTRAINT priVentaOportunidad PRIMARY KEY  CLUSTERED (ID)
)
go
EXEC spModificarPK_Sucursal 'VentaOportunidad', '(ID)'
GO

-- drop table VentaCompetidor
/****** VentaCompetidor ******/
if not exists(select * from SysTabla where SysTabla = 'VentaCompetidor')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaCompetidor','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaCompetidor') and type = 'U') 
CREATE TABLE dbo.VentaCompetidor (
	ID 			int         	NOT NULL,
	Competidor		varchar(100)	NOT NULL,

	Producto		varchar(100)	NULL,
	Orden			int		NULL,
	Importe			money		NULL,
	Moneda			varchar(10)	NULL,
	Situacion		varchar(50)	NULL,
	Fecha			datetime	NULL,
	Observaciones		varchar(255)	NULL,

	CONSTRAINT priVentaCompetidor PRIMARY KEY  CLUSTERED (ID, Competidor)
)
go
EXEC spModificarPK_Sucursal 'VentaCompetidor', '(ID)'
GO

/****** VentaEntrega ******/
if not exists(select * from SysTabla where SysTabla = 'VentaEntrega')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaEntrega','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaEntrega') and type = 'U') 
CREATE TABLE dbo.VentaEntrega (
	ID 			int         	NOT NULL,
	
	Embarque		varchar(50)	NULL,
	EmbarqueFecha		datetime	NULL,
	EmbarqueReferencia	varchar(50)	NULL,

	Recibo			varchar(50)	NULL,
	ReciboFecha		datetime	NULL,
	ReciboReferencia	varchar(50)	NULL,
	EntregaMercancia	varchar(20) 	NULL,
	TotalCajas			int NULL,

	CONSTRAINT priVentaEntrega PRIMARY KEY CLUSTERED (ID)
)
GO
EXEC spModificarPK_Sucursal 'VentaEntrega', '(ID)'
GO
EXEC spALTER_TABLE 'VentaEntrega', 'EntregaMercancia', 'varchar(20) NULL'
EXEC spAlter_Table 'VentaEntrega', 'TotalCajas', 'int null'
GO

/****** ServicioTipoOrden  ******/
if not exists(select * from SysTabla where SysTabla = 'ServicioTipoOrden')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioTipoOrden','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioTipoOrden') and type = 'U') 
CREATE TABLE dbo.ServicioTipoOrden (
	TipoOrden		varchar(20) 	NOT NULL,

	Clave			varchar(20)	NULL,
	ListaPreciosEsp		varchar(20)	NULL,

	CONSTRAINT priServicioTipoOrden PRIMARY KEY CLUSTERED (TipoOrden)
)
GO

/****** ServicioTipoOperacion  ******/
if not exists(select * from SysTabla where SysTabla = 'ServicioTipoOperacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioTipoOperacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioTipoOperacion') and type = 'U') 
CREATE TABLE dbo.ServicioTipoOperacion (
	TipoOperacion		varchar(50) 	NOT NULL,

	Clave			varchar(20)	NULL,

	CONSTRAINT priServicioTipoOperacion PRIMARY KEY CLUSTERED (TipoOperacion)
)
GO


/****** ServicioTipo  ******/
if not exists(select * from SysTabla where SysTabla = 'ServicioTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioTipo') and type = 'U') 
CREATE TABLE dbo.ServicioTipo (
	Tipo			varchar(50) 	NOT NULL,

	CONSTRAINT priServicioTipo PRIMARY KEY CLUSTERED (Tipo)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgServicioTipoBC') and sysstat & 0xf = 8) drop trigger dbo.tgServicioTipoBC
GO

/****** ServicioTipoPlantilla ******/
if not exists(select * from SysTabla where SysTabla = 'ServicioTipoPlantilla')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioTipoPlantilla','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioTipoPlantilla') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ServicioTipoPlantilla (
	Tipo			varchar(50) 	NOT NULL,
	ID			int		NOT NULL 	IDENTITY(1,1),

	Articulo		varchar(20)	NOT NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Orden			int		NULL,
	AlmacenEsp		varchar(21)	NULL,
	ListaPreciosEsp		varchar(20)	NULL,

	CONSTRAINT priServicioTipoPlantilla PRIMARY KEY  CLUSTERED (Tipo, ID)
  )
  EXEC spSincroSemilla 'ServicioTipoPlantilla'
END
GO
EXEC spALTER_TABLE 'ServicioTipoPlantilla', 'ListaPreciosEsp', 'varchar(20) NULL'
GO
EXEC spALTER_COLUMN 'ServicioTipoPlantilla', 'SubCuenta', 'varchar(50) NULL'
GO

EXEC spFK 'ServicioTipoPlantilla','Articulo','Art','Articulo'
GO

CREATE TRIGGER tgServicioTipoBC ON ServicioTipo
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE 
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50),
    @Mensaje 		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = Tipo FROM Inserted
  SELECT @ClaveAnterior = Tipo FROM Deleted

  IF @ClaveNueva=@ClaveAnterior RETURN

  IF @ClaveNueva IS NULL
  BEGIN
    DELETE ServicioTipoPlantilla WHERE Tipo = @ClaveAnterior
  END ELSE
  IF @ClaveNueva <> @ClaveAnterior AND @ClaveAnterior IS NOT NULL
  BEGIN
    UPDATE ServicioTipoPlantilla SET Tipo = @ClaveNueva WHERE Tipo = @ClaveAnterior
  END
END
GO


/****** ContratoTipo  ******/
if not exists(select * from SysTabla where SysTabla = 'ContratoTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ContratoTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ContratoTipo') and type = 'U') 
CREATE TABLE dbo.ContratoTipo (
	Modulo			varchar(5)	NOT NULL,
	Tipo			varchar(50) 	NOT NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priContratoTipo PRIMARY KEY CLUSTERED (Modulo, Tipo)
)

/****** ServicioTarea  ******/
if not exists(select * from SysTabla where SysTabla = 'ServicioTarea')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ServicioTarea','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioTarea') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ServicioTarea (
	ID		int		NOT NULL,
	RenglonID	int		NOT NULL  IDENTITY(1,1),

	Tarea		varchar(50)	NULL,
	Problema	varchar(255)	NULL,
	Solucion	varchar(255)	NULL,
	Estado		varchar(30)	NULL,
	Fecha		datetime	NULL,
	Responsable	varchar(50)	NULL,
	FechaEstimada	datetime	NULL,
	FechaConclusion	datetime	NULL,
	Sucursal	int		NOT NULL DEFAULT 0,
	Tiempo		float		NULL,
	Usuario		varchar(10)	NULL,

	Logico1		bit		NOT NULL DEFAULT 0,
	Logico2		bit		NOT NULL DEFAULT 0,
	Logico3		bit		NOT NULL DEFAULT 0,

	Orden		int		NULL,
	Comentarios	text		NULL,

	CONSTRAINT priServicioTarea PRIMARY KEY CLUSTERED (ID, RenglonID)
  )
  EXEC spSincroSemilla 'ServicioTarea'
END
go
EXEC spModificarPK_Sucursal 'ServicioTarea', '(ID, RenglonID)'
GO
EXEC spALTER_TABLE 'ServicioTarea', 'Responsable', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'ServicioTarea', 'FechaEstimada', 'datetime NULL'
EXEC spALTER_TABLE 'ServicioTarea', 'FechaConclusion', 'datetime NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ServicioTarea' AND sysindexes.name = 'Tarea' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Tarea ON dbo.ServicioTarea (Tarea)
go
EXEC spALTER_TABLE 'ServicioTarea', 'Tiempo', 'float NULL'
EXEC spALTER_TABLE 'ServicioTarea', 'Usuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ServicioTarea', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'ServicioTarea', 'Comentarios', 'text NULL'
GO

EXEC spFK 'ServicioTarea','ID','Venta','ID'
GO

/****** MovTarea  ******/
if not exists(select * from SysTabla where SysTabla = 'MovTarea')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTarea','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.MovTarea') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovTarea (
	Modulo		varchar(5)	NOT NULL,
	ID		int		NOT NULL,
	RenglonID	int		NOT NULL  IDENTITY(1,1),

	Tarea		varchar(50)	NULL,
	Problema	varchar(255)	NULL,
	Solucion	varchar(255)	NULL,
	Estado		varchar(30)	NULL,
	Fecha		datetime	NULL,
	Responsable	varchar(50)	NULL,
	FechaEstimada	datetime	NULL,
	FechaConclusion	datetime	NULL,
	Sucursal	int		NOT NULL DEFAULT 0,
	Usuario		varchar(10)	NULL,
	Tiempo		float		NULL,
	
	Logico1		bit		NOT NULL DEFAULT 0,
	Logico2		bit		NOT NULL DEFAULT 0,
	Logico3		bit		NOT NULL DEFAULT 0,

	Orden		int		NULL,
	Comentarios	text		NULL,

	CONSTRAINT priMovTarea PRIMARY KEY CLUSTERED (Modulo, ID, RenglonID)
  )
  EXEC spSincroSemilla 'MovTarea'
END
go
EXEC spModificarPK_Sucursal 'MovTarea', '(Modulo, ID, RenglonID)'
EXEC spALTER_TABLE 'MovTarea', 'Usuario', 'varchar(10) NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovTarea' AND sysindexes.name = 'Tarea' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Tarea ON dbo.MovTarea (Tarea)
GO
EXEC spALTER_TABLE 'MovTarea', 'Tiempo', 'float NULL'
EXEC spALTER_TABLE 'MovTarea', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'MovTarea', 'Comentarios', 'text NULL'
GO

EXEC spFK 'MovTarea','ID','Soporte','ID'
GO

/****** ServicioAccesorios  ******/
if not exists(select * from SysTabla where SysTabla = 'ServicioAccesorios')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ServicioAccesorios','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioAccesorios') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ServicioAccesorios (
	ID		int		NOT NULL,
	RenglonID	int		NOT NULL  IDENTITY(1,1),

	Articulo	varchar(20)	NULL,
	Serie		varchar(20)	NULL,
	Observaciones	varchar(50)	NULL,
	Sucursal	int		NOT NULL DEFAULT 0,
	
 	CONSTRAINT priServicioAccesorios PRIMARY KEY CLUSTERED (ID, RenglonID)
  )
  EXEC spSincroSemilla 'ServicioAccesorios'
END
GO
EXEC spModificarPK_Sucursal 'ServicioAccesorios', '(ID, RenglonID)'
GO

EXEC spFK 'ServicioAccesorios','Articulo','Art','Articulo'
GO

/****** Ventas ******/
if not exists(select * from SysTabla where SysTabla = 'VentaC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('VentaC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.VentaC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VentaC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)      NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priVentaC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'VentaC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'VentaC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE VentaC ALTER COLUMN Empresa varchar(5)  NULL")
  EXEC("ALTER TABLE VentaC ALTER COLUMN Mov     varchar(20) NULL")
END
GO


/****** Nota ******/
if not exists(select * from SysTabla where SysTabla = 'Nota')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Nota','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.Nota') and type = 'U') 
  CREATE TABLE dbo.Nota (
	ID			int 	    	NOT NULL,

	Empresa			varchar(5)      NULL,
	Mov 			varchar(20)     NULL,
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	Actividad  		varchar(50)   	NULL,
	UEN			int		NULL,
	Moneda  		varchar(10)   	NULL,   -- default del cliente
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

	Directo			bit		NULL	DEFAULT 1,
	Prioridad		varchar(10)	NULL,
	RenglonID		int		NULL,
	FechaOriginal		datetime	NULL,

	Codigo			varchar(30)	NULL,
	Cliente 		varchar(10)   	NULL,
	EnviarA			int	   	NULL,
	Almacen			varchar(10)   	NULL,
	AlmacenDestino		varchar(10)	NULL,
	Agente 			varchar(10)   	NULL,
	AgenteServicio		varchar(10)   	NULL,
	AgenteComision		float		NULL,
	FormaEnvio 		varchar(50)   	NULL,   
	FechaRequerida		datetime    	NULL,
	HoraRequerida		varchar(5)    	NULL,
	FechaProgramadaEnvio	datetime    	NULL,
	FechaOrdenCompra	datetime    	NULL,
	ReferenciaOrdenCompra	varchar(50) 	NULL,
	OrdenCompra		varchar(50) 	NULL,
	Condicion 		varchar(50)   	NULL,
	Vencimiento		datetime    	NULL,

	CtaDinero		varchar(10)	NULL,
	Descuento		varchar(30)   	NULL,
	DescuentoGlobal 	float 	    	NULL,  -- % de descuento global
	Importe  		money	    	NULL,  -- Importe = Suma(Importe) * linea (incluye desc linea)
	Impuestos		money       	NULL,  -- suma de impuestos
	Saldo 		        money       	NULL,
	AnticiposFacturados	money		NULL,
	AnticiposImpuestos	money		NULL,
	Retencion		money		NULL,
        DescuentoLineal		money		NULL,  -- suma del descuento linea (referencia)
	ComisionTotal		money		NULL,
	CostoTotal		money		NULL,
	PrecioTotal		money		NULL,
	Paquetes		int		NULL,

	ServicioTipo		varchar(50)	NULL,
	ServicioArticulo	varchar(20)	NULL,
	ServicioSerie		varchar(50)	NULL,
	ServicioContrato	varchar(20)	NULL,
	ServicioContratoID	varchar(20)	NULL,
	ServicioContratoTipo	varchar(50)	NULL,
	ServicioGarantia	bit		NULL	DEFAULT 0,
	ServicioDescripcion	varchar(100)	NULL,
	ServicioFecha		datetime	NULL,
	ServicioFlotilla	bit		NULL	DEFAULT 0,
	ServicioRampa		bit		NULL	DEFAULT 0,
	ServicioIdentificador	varchar(20)	NULL,
	ServicioPlacas		varchar(20)	NULL,
	ServicioKms		int		NULL,
	ServicioTipoOrden	varchar(20)	NULL,
	ServicioTipoOperacion	varchar(50) 	NULL,
	ServicioSiniestro	varchar(20)	NULL,
	ServicioExpress		bit		NULL	DEFAULT 0,
	ServicioDemerito	bit		NULL	DEFAULT 0,
	ServicioDeducible	bit		NULL	DEFAULT 0,
	ServicioDeducibleImporte money		NULL,
	ServicioNumero		float		NULL,
	ServicioNumeroEconomico	varchar(20)	NULL,
	ServicioAseguradora	varchar(10)	NULL,
	ServicioPuntual		bit		NULL	DEFAULT 0,
	ServicioPoliza		varchar(20)	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		varchar(20)	NULL,
	GenerarPoliza		bit	    	NULL	DEFAULT 0,
	ContID			int		NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	FechaEntrega		datetime    	NULL,
	EmbarqueEstado		varchar(50)	NULL,
	EmbarqueGastos		money		NULL,

	Peso			float		NULL,
	Volumen			float		NULL,

	Causa			varchar(50)	NULL,
	Atencion		varchar(50)	NULL,
	AtencionTelefono	varchar(50)	NULL,
	ListaPreciosEsp		varchar(20)	NULL,
	ZonaImpuesto		varchar(30)  	NULL,
	Extra			bit		NULL	DEFAULT 0,
	CancelacionID		int		NULL,
	Mensaje			int		NULL,
	Departamento		int		NULL,
	Sucursal		int		NULL	DEFAULT 0,
	GenerarOP		bit		NULL	DEFAULT 0,
	DesglosarImpuestos	bit		NULL	DEFAULT 1,
	DesglosarImpuesto2	bit		NULL	DEFAULT 0,
	ExcluirPlaneacion	bit		NULL	DEFAULT 0,
	ConVigencia		bit		NULL	DEFAULT 0,
	VigenciaDesde		datetime	NULL,
	VigenciaHasta		datetime	NULL,
	Enganche		money		NULL,
	Bonificacion		float		NULL,
	IVAFiscal		float		NULL,
	IEPSFiscal		float		NULL,
	EstaImpreso		bit		NULL	DEFAULT 0,
	Periodicidad		varchar(20)	NULL,

	SubModulo		varchar(5)	NULL	DEFAULT 'VTAS',
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20)	NULL, 
	ContUso3		varchar(20)	NULL, 	
	
	Espacio			varchar(10)	NULL,
	AutoCorrida		varchar(20)	NULL,
	AutoCorridaHora		varchar(5)	NULL,
	AutoCorridaServicio	varchar(50)	NULL,
	AutoCorridaRol		varchar(50)	NULL,
	AutoCorridaOrigen	varchar(5)	NULL,
	AutoCorridaDestino	varchar(5)	NULL,
	AutoCorridaKms		int		NULL,
	AutoCorridaLts		int		NULL,
	AutoCorridaRuta		varchar(5)	NULL,
	AutoOperador2		varchar(10)	NULL,

	AutoBoleto		varchar(11)	NULL,
	AutoKms			int		NULL,
	AutoKmsActuales		int		NULL,
	AutoBomba		varchar(10)	NULL,
	AutoBombaContador	int		NULL,

	Logico1			bit		NULL	DEFAULT 0,
	Logico2			bit		NULL	DEFAULT 0,
	Logico3			bit		NULL	DEFAULT 0,
	Logico4			bit		NULL	DEFAULT 0,

	DifCredito		money		NULL,
	EspacioResultado	bit		NULL 	DEFAULT 0,

     	Clase			varchar(50)	NULL,  
    	Subclase		varchar(50)	NULL,  

	GastoAcreedor		varchar(10)	NULL,
	GastoConcepto		varchar(50)	NULL,
	Comentarios		text		NULL,
	Pagado			float		NULL,

	GenerarDinero		bit		NULL 	DEFAULT 0,
	Dinero			varchar(20)	NULL,
	DineroID		varchar(20)	NULL,
	DineroCtaDinero		varchar(10)	NULL,
	DineroConciliado	bit		NULL    DEFAULT 0,
	DineroFechaConciliacion datetime	NULL,

	Extra1			bit		NULL	DEFAULT 0,
	Extra2			bit		NULL	DEFAULT 0,
	Extra3			bit		NULL	DEFAULT 0,

	Reabastecido		bit		NULL	DEFAULT 0,
	SucursalVenta		int		NULL,

	AF			bit		NULL	DEFAULT 0,
	AFArticulo		varchar(20)	NULL,
	AFSerie			varchar(20)	NULL,

	ContratoTipo		varchar(50)	NULL,
	ContratoDescripcion	varchar(100)	NULL,
	ContratoSerie		varchar(20)	NULL,
	ContratoValor		money		NULL,
	ContratoValorMoneda	varchar(10)	NULL,
	ContratoSeguro		varchar(20)	NULL,
	ContratoVencimiento	datetime	NULL,
	ContratoResponsable	varchar(10)	NULL,

	Incentivo		money		NULL,
	IncentivoConcepto	varchar(50)	NULL,
	EndosarA		varchar(10)	NULL,

	InteresTasa		float		NULL,
	InteresIVA		float		NULL,
	AnexoID			int		NULL,
        FordVisitoOASIS         bit             NULL    DEFAULT 0,

	LineaCredito		varchar(20)	NULL,
 	TipoAmortizacion	varchar(20)	NULL,
	TipoTasa		varchar(20)	NULL,
	Comisiones		money		NULL,
	ComisionesIVA		money		NULL,
	CompraID		int		NULL,
	OperacionRelevante	bit		NULL,
	TieneTasaEsp		bit		NULL	DEFAULT 0,
	TasaEsp			float		NULL,
	FormaPagoTipo		varchar(50)	NULL,
	SobrePrecio		float		NULL,

	ContratoID		int		NULL,
	ContratoMov		varchar(20)	NULL,
	ContratoMovID		varchar(20)	NULL,

	CONSTRAINT priNota PRIMARY KEY CLUSTERED (ID)
  )
GO
EXEC spALTER_TABLE 'Nota', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Nota', 'ContUso3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Nota', 'Actividad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Nota', 'ContratoID', 'int NULL'
EXEC spALTER_TABLE 'Nota', 'ContratoMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Nota', 'ContratoMovID', 'varchar(20) NULL'
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nota' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Nota (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nota' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Nota (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nota' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Nota (OrigenID,Origen,Empresa)

EXEC spALTER_COLUMN 'Nota', 'AFSerie', 'varchar(50) NULL'  --BUG12333
GO

/****** VentaFlexibleD ******/
if not exists(select * from SysTabla where SysTabla = 'VentaFlexibleD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaFlexibleD','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaFlexibleD') and type = 'U') 
  CREATE TABLE dbo.VentaFlexibleD
	(
    ID 		  int			NOT NULL,
    Renglon	  float			NOT NULL,

    Articulo	  varchar (20)		NULL,
    Cantidad      float			NULL,
    Precio        float			NULL,
    Importe       money			NULL,
    Cliente       varchar (10)		NULL,

    CONSTRAINT priVentaFlexibleD PRIMARY KEY CLUSTERED (ID, Renglon)
      
	)
GO

EXEC spFK 'VentaFlexibleD','ID','Venta','ID'
GO

/****** Ventas ******/
if not exists(select * from SysTabla where SysTabla = 'Venta')
	INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Venta','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.Venta') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Venta (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)      NOT NULL,
	Mov 			varchar(20)     NOT NULL,
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	Actividad		varchar(50)	NULL,
	UEN			int		NULL,
	Moneda  		varchar(10)   	NOT NULL,   -- default del cliente
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
	Prioridad		varchar(10)	NULL,
	RenglonID		int		NULL,
	FechaOriginal		datetime	NULL,

	Codigo			varchar(30)	NULL,
	Cliente 		varchar(10)   	NOT NULL,
	EnviarA			int	   	NULL,
	Almacen			varchar(10)   	NOT NULL,
	AlmacenDestino		varchar(10)	NULL,
	Agente 			varchar(10)   	NULL,
	AgenteServicio		varchar(10)   	NULL,
	AgenteComision		float		NULL,
	FormaEnvio 		varchar(50)   	NULL,   
	FechaRequerida		datetime    	NULL,
	HoraRequerida		varchar(5)    	NULL,
	FechaProgramadaEnvio	datetime    	NULL,
	FechaOrdenCompra	datetime    	NULL,
	ReferenciaOrdenCompra	varchar(50) 	NULL,
	OrdenCompra		varchar(50) 	NULL,
	Condicion 		varchar(50)   	NULL,
	Vencimiento		datetime    	NULL,

	CtaDinero		varchar(10)	NULL,
	Descuento		varchar(30)   	NULL,
	DescuentoGlobal 	float 	    	NULL,  -- % de descuento global
	Importe  		money	    	NULL,  -- Importe = Suma(Importe) * linea (incluye desc linea)
	Impuestos		money       	NULL,  -- suma de impuestos
	Saldo 		        money       	NULL,
	AnticiposFacturados	money		NULL,
	AnticiposImpuestos	money		NULL,
	Retencion		money		NULL,
        DescuentoLineal		money		NULL,  -- suma del descuento linea (referencia)
	ComisionTotal		money		NULL,
	CostoTotal		money		NULL,
	PrecioTotal		money		NULL,
	Paquetes		int		NULL,

	ServicioTipo		varchar(50)	NULL,
	ServicioArticulo	varchar(20)	NULL,
	ServicioSerie		varchar(50)	NULL,
	ServicioContrato	varchar(20)	NULL,
	ServicioContratoID	varchar(20)	NULL,
	ServicioContratoTipo	varchar(50)	NULL,
	ServicioGarantia	bit		NOT NULL DEFAULT 0,
	ServicioDescripcion	varchar(100)	NULL,
	ServicioFecha		datetime	NULL,
	ServicioFlotilla	bit		NULL	DEFAULT 0,
	ServicioRampa		bit		NULL	DEFAULT 0,
	ServicioIdentificador	varchar(20)	NULL,
	ServicioPlacas		varchar(20)	NULL,
	ServicioKms		int		NULL,
	ServicioTipoOrden	varchar(20)	NULL,
	ServicioTipoOperacion	varchar(50) 	NULL,
	ServicioSiniestro	varchar(20)	NULL,
	ServicioExpress		bit		NOT NULL DEFAULT 0,
	ServicioDemerito	bit		NOT NULL DEFAULT 0,
	ServicioDeducible	bit		NOT NULL DEFAULT 0,
	ServicioDeducibleImporte money		NULL,
	ServicioNumero		float		NULL,
	ServicioNumeroEconomico	varchar(20)	NULL,
	ServicioAseguradora	varchar(10)	NULL,
	ServicioPuntual		bit		NULL     DEFAULT 0,
	ServicioPoliza		varchar(20)	NULL,

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

	FechaEntrega		datetime    	NULL,
	EmbarqueEstado		varchar(50)	NULL,
	EmbarqueGastos		money		NULL,

	Peso			float		NULL,
	Volumen			float		NULL,

	Causa			varchar(50)	NULL,
	Atencion		varchar(50)	NULL,
	AtencionTelefono	varchar(50)	NULL,
	ListaPreciosEsp		varchar(20)	NULL,
	ZonaImpuesto		varchar(30)  	NULL,
	Extra			bit		NOT NULL DEFAULT 0,
	CancelacionID		int		NULL,
	Mensaje			int		NULL,
	Departamento		int		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	GenerarOP		bit		NULL	 DEFAULT 0,
	DesglosarImpuestos	bit		NULL	 DEFAULT 1,
	DesglosarImpuesto2	bit		NULL	 DEFAULT 0,
	ExcluirPlaneacion	bit		NULL	 DEFAULT 0,
	ConVigencia		bit		NULL	 DEFAULT 0,
	VigenciaDesde		datetime	NULL,
	VigenciaHasta		datetime	NULL,
	Enganche		money		NULL,
	Bonificacion		float		NULL,
	IVAFiscal		float		NULL,
	IEPSFiscal		float		NULL,
	EstaImpreso		bit		NULL	 DEFAULT 0,
	Periodicidad		varchar(20)	NULL,

	SubModulo		varchar(5)	NULL	 DEFAULT 'VTAS',
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20)	NULL, 
	ContUso3		varchar(20)	NULL, 	
	Espacio			varchar(10)	NULL,
	AutoCorrida		varchar(20)	NULL,
	AutoCorridaHora		varchar(5)	NULL,
	AutoCorridaServicio	varchar(50)	NULL,
	AutoCorridaRol		varchar(50)	NULL,
	AutoCorridaOrigen	varchar(5)	NULL,
	AutoCorridaDestino	varchar(5)	NULL,
	AutoCorridaKms		int		NULL,
	AutoCorridaLts		int		NULL,
	AutoCorridaRuta		varchar(5)	NULL,
	AutoOperador2		varchar(10)	NULL,

	AutoBoleto		varchar(11)	NULL,
	AutoKms			int		NULL,
	AutoKmsActuales		int		NULL,
	AutoBomba		varchar(10)	NULL,
	AutoBombaContador	int		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,

	DifCredito		money		NULL,
	EspacioResultado	bit		NULL 	 DEFAULT 0,

     	Clase			varchar(50)	NULL,  
    	Subclase		varchar(50)	NULL,  

	GastoAcreedor		varchar(10)	NULL,
	GastoConcepto		varchar(50)	NULL,
	Comentarios		text		NULL,
	Pagado			float		NULL,

	GenerarDinero		bit		NULL 	DEFAULT 0,
	Dinero			varchar(20)	NULL,
	DineroID		varchar(20)	NULL,
	DineroCtaDinero		varchar(10)	NULL,
	DineroConciliado	bit		NULL     DEFAULT 0,
	DineroFechaConciliacion datetime	NULL,

	Extra1			bit		NOT NULL DEFAULT 0,
	Extra2			bit		NOT NULL DEFAULT 0,
	Extra3			bit		NOT NULL DEFAULT 0,

	Reabastecido		bit		NULL	 DEFAULT 0,
	SucursalVenta		int		NULL,

	AF			bit		NULL	 DEFAULT 0,
	AFArticulo		varchar(20)	NULL,
	AFSerie			varchar(20)	NULL,

	ContratoTipo		varchar(50)	NULL,
	ContratoDescripcion	varchar(100)	NULL,
	ContratoSerie		varchar(20)	NULL,
	ContratoValor		money		NULL,
	ContratoValorMoneda	varchar(10)	NULL,
	ContratoSeguro		varchar(20)	NULL,
	ContratoVencimiento	datetime	NULL,
	ContratoResponsable	varchar(10)	NULL,

	Incentivo		money		NULL,
	IncentivoConcepto	varchar(50)	NULL,
	EndosarA		varchar(10)	NULL,

	InteresTasa		float		NULL,
	InteresIVA		float		NULL,
	AnexoID			int		NULL,
	FordVisitoOASIS         bit             NULL        DEFAULT 0,

	LineaCredito		varchar(20)	NULL,
 	TipoAmortizacion	varchar(20)	NULL,
	TipoTasa		varchar(20)	NULL,
	Comisiones		money		NULL,
	ComisionesIVA		money		NULL,
	CompraID		int		NULL,
	OperacionRelevante	bit		NULL,
	TieneTasaEsp		bit		NULL	DEFAULT 0,
	TasaEsp			float		NULL,
	FormaPagoTipo		varchar(50)	NULL,
	SobrePrecio		float		NULL,

	ContratoID		int		NULL,
	ContratoMov		varchar(20)	NULL,
	ContratoMovID		varchar(20)	NULL,
	
	MAFCiclo		int		NULL,

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
	
	CRCFDSerie			varchar(20) NULL, --MEJORA3051
	CRCFDFolio			varchar(20) NULL, --MEJORA3051	

    Retencion1			float NULL,
    Retencion2			float NULL,
    Retencion3			float NULL,
	--REQ12615 WMS
	PosicionWMS			varchar(10) NULL,
	
	--REQ 13389
	CRMID				uniqueidentifier	NULL,
	OpportunityId		varchar(36)			NULL,
 	CFDFlexEstatus          varchar(15)     NULL, --REQ 15739 
 	--REQ 15448   
 	PedidoReferencia        varchar(50)     NULL,
 	POSDescuento            varchar(30)     NULL,
 	PedidoReferenciaID      int             NULL,
 	Refacturado             bit             NULL DEFAULT 0,
 	Monedero                varchar(20)     NULL,
	POSRedondeoVerif		bit             NULL DEFAULT 0,
    
	CONSTRAINT priVenta PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Venta'
END
GO
EXEC spSincroNivelRegistro @Tabla = 'Venta'
go
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Venta.Consecutivo
  ALTER TABLE Venta ALTER COLUMN MovID varchar(20)
  ALTER TABLE Venta ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Venta ALTER COLUMN PolizaID varchar(20)
  ALTER TABLE Venta ALTER COLUMN ServicioContratoID varchar(20)
END
if exists (select * from sysobjects where id = object_id('dbo.tgVentaA') and sysstat & 0xf = 8) drop trigger dbo.tgVentaA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgVentaC') and sysstat & 0xf = 8) drop trigger dbo.tgVentaC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgVentaB') and sysstat & 0xf = 8) drop trigger dbo.tgVentaB
GO
-- Aqui va el Matenimiento a la tabla
EXEC spModificarPK_Mov 'Venta'
GO
EXEC spSincroNivelRegistroCampos 'Venta'
GO
EXEC spALTER_TABLE 'Venta', 'GenerarOP', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'Venta', 'DesglosarImpuestos', 'bit NULL DEFAULT 1 WITH VALUES'
GO
EXEC spALTER_TABLE 'Venta', 'ExcluirPlaneacion', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'Venta', 'HoraRequerida', 'varchar(5) NULL'
GO
EXEC spALTER_TABLE 'Venta', 'ConVigencia','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'VigenciaDesde','datetime NULL'
EXEC spALTER_TABLE 'Venta', 'VigenciaHasta','datetime NULL'
EXEC spALTER_TABLE 'Venta', 'Enganche', 'money NULL'
EXEC spALTER_TABLE 'Venta', 'Bonificacion', 'float NULL'
EXEC spALTER_TABLE 'Venta', 'IVAFiscal', 'float NULL'
EXEC spALTER_TABLE 'Venta', 'IEPSFiscal', 'float NULL'
EXEC spALTER_TABLE 'Venta', 'EstaImpreso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'Periodicidad', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'SubModulo', 'varchar(5) NULL DEFAULT "VTAS" WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'EmbarqueGastos', 'money NULL'
EXEC spALTER_TABLE 'Venta', 'AnticiposImpuestos', 'money NULL'
EXEC spALTER_TABLE 'Venta', 'DifCredito', 'money NULL'
EXEC spALTER_TABLE 'Venta', 'AutoCorrida', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'AutoBoleto', 'varchar(11) NULL'
GO
EXEC spRENAME_COLUMN 'Venta', 'Autobus', 'Espacio'
GO
EXEC spALTER_TABLE 'Venta', 'Espacio', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Venta', 'EspacioResultado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Venta', 'Clase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'Subclase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'AutoKms', 'int NULL'
EXEC spALTER_TABLE 'Venta', 'AutoKmsActuales', 'int NULL'
EXEC spALTER_TABLE 'Venta', 'AutoBomba', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Venta', 'AutoBombaContador', 'int NULL'
GO
EXEC spALTER_TABLE 'Venta', 'CRCFDSerie', 'varchar(20) NULL' --MEJORA3051
EXEC spALTER_TABLE 'Venta', 'CRCFDFolio', 'varchar(20) NULL' --MEJORA3051
GO
if (select version from version)<=2119
  EXEC("ALTER TABLE Venta ALTER COLUMN AutoCorrida varchar(20) NULL")
GO

EXEC spALTER_TABLE 'Venta', 'AutoCorridaHora', 'varchar(5) NULL'
EXEC spALTER_TABLE 'Venta', 'AutoCorridaServicio', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Venta', 'AutoCorridaRol', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'AutoCorridaOrigen', 'varchar(5) NULL'
EXEC spALTER_TABLE 'Venta', 'AutoCorridaDestino', 'varchar(5) NULL'
EXEC spALTER_TABLE 'Venta', 'AutoCorridaKms', 'int NULL'
EXEC spALTER_TABLE 'Venta', 'AutoCorridaLts', 'int NULL'
EXEC spALTER_TABLE 'Venta', 'AutoCorridaRuta', 'varchar(5) NULL'

EXEC spALTER_TABLE 'Venta', 'GastoAcreedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Venta', 'GastoConcepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'Comentarios', 'text NULL'
EXEC spALTER_TABLE 'Venta', 'Pagado', 'float NULL'
GO
EXEC spALTER_TABLE 'Venta', 'GenerarDinero', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'Dinero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'DineroID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'DineroCtaDinero', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Venta', 'DineroConciliado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'DineroFechaConciliacion', 'datetime NULL'
GO
if (select version from version)<=2128 and not exists(select * from syscampo where tabla = 'Venta' and campo = 'Extra1')
BEGIN
  EXEC("sp_rename 'Venta.Logico5', 'Extra1', 'COLUMN'")
  EXEC("sp_rename 'Venta.Logico6', 'Extra2', 'COLUMN'")
  EXEC("sp_rename 'Venta.Logico7', 'Extra3', 'COLUMN'")
END
GO
EXEC spALTER_TABLE 'Venta', 'Reabastecido', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'ServicioPlacas', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'ServicioKms', 'int NULL'
EXEC spALTER_TABLE 'Venta', 'ServicioTipoOrden', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'ServicioTipoOperacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'ServicioSiniestro', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'ServicioExpress', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'ServicioDemerito', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'ServicioDeducible', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'ServicioDeducibleImporte', 'money NULL'
EXEC spALTER_TABLE 'Venta', 'ServicioNumero', 'float NULL'
EXEC spALTER_TABLE 'Venta', 'AgenteServicio', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Venta', 'ServicioNumeroEconomico', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'ServicioAseguradora', 'varchar(10)	NULL'

GO
if not exists(select * from syscampo where tabla = 'Venta' AND Campo = 'SucursalVenta')
begin
  EXEC("spALTER_TABLE 'Venta', 'SucursalVenta', 'int NULL'")
  EXEC("UPDATE Venta SET SucursalVenta = SucursalOrigen")
end
GO

EXEC spALTER_TABLE 'Venta', 'AF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'AFArticulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'AFSerie', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'ContratoTipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'ContratoDescripcion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Venta', 'ContratoSerie', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'ContratoValor', 'money NULL'
EXEC spALTER_TABLE 'Venta', 'ContratoValorMoneda', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Venta', 'ContratoSeguro', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'ContratoVencimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Venta', 'ContratoResponsable', 'varchar(10)	NULL'
GO
if (select version from version)<=2318
  ALTER TABLE Venta ALTER COLUMN ServicioNumeroEconomico varchar(20) NULL
GO
EXEC spALTER_TABLE 'Venta', 'ServicioFlotilla', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'ServicioRampa', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'Incentivo', 'money NULL'
EXEC spALTER_TABLE 'Venta', 'IncentivoConcepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'EndosarA', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Venta', 'DesglosarImpuesto2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'AnexoID', 'int NULL'
EXEC spALTER_TABLE 'Venta', 'FordVisitoOASIS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'LineaCredito', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'TipoAmortizacion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'TipoTasa', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'AutoOperador2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Venta', 'Comisiones', 'money NULL'
EXEC spALTER_TABLE 'Venta', 'ComisionesIVA', 'money NULL'
EXEC spALTER_TABLE 'Venta', 'CompraID', 'int NULL'
GO
if (select version from version)<=2625
  ALTER TABLE Venta ALTER COLUMN ServicioNumero float NULL
GO
EXEC spALTER_TABLE 'Venta', 'ServicioPuntual', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'OperacionRelevante','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'AgenteComision', 'float NULL'
EXEC spALTER_TABLE 'Venta', 'TieneTasaEsp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'TasaEsp', 'float NULL'
EXEC spALTER_TABLE 'Venta', 'ServicioPoliza', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Venta', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Venta', 'ReferenciaOrdenCompra', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'Codigo', 'varchar(30) NULL'
EXEC spALTER_COLUMN 'Venta', 'ServicioSerie', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'FormaPagoTipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'SobrePrecio', 'float NULL'
EXEC spALTER_TABLE 'Venta', 'InteresTasa', 'float NULL'
EXEC spALTER_TABLE 'Venta', 'InteresIVA', 'float NULL'
EXEC spALTER_TABLE 'Venta', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'ContUso3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'Actividad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'ContratoID', 'int NULL'
EXEC spALTER_TABLE 'Venta', 'ContratoMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'ContratoMovID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'MAFCiclo', 'int NULL'
EXEC spAlter_Table 'Venta', 'AnticipoFacturadoTipoServicio','bit NULL DEFAULT 0' --AnticipoFacturado
GO
EXEC spAlter_Table 'Venta', 'Retencion1', 'float NULL' --MEJORA4648
EXEC spAlter_Table 'Venta', 'Retencion2', 'float NULL' --MEJORA4648
EXEC spAlter_Table 'Venta', 'Retencion3', 'float NULL' --MEJORA4648
GO

-- REQ12336
EXEC spALTER_TABLE 'Venta', 'EmidaTelefono', 'varchar(10) NULL'
GO
-- REQ12336
EXEC spALTER_TABLE 'Venta', 'EmidaControlNo', 'varchar(20) NULL'
GO
-- REQ12336
EXEC spALTER_TABLE 'Venta', 'EmidaTransactionId', 'varchar(20) NULL'
GO
-- REQ12336
EXEC spALTER_TABLE 'Venta', 'EmidaResponseMessage', 'varchar(500) NULL'
GO
-- REQ12336
EXEC spALTER_TABLE 'Venta', 'EmidaTransactionDateTime', 'datetime NULL'
GO
-- REQ12336
EXEC spALTER_TABLE 'Venta', 'EmidaResponseCode', 'varchar(2) NULL'
GO
-- REQ13848
EXEC spRENAME_COLUMN 'Venta', 'EmidaTelefono', 'RecargaTelefono'
GO

-- REQ13894
EXEC spALTER_TABLE 'Venta', 'EmidaCarrierControlNo', 'varchar(20) NULL'
GO

--REQ12615 WMS
EXEC spALTER_TABLE 'Venta','PosicionWMS','varchar(10) NULL'
GO
--Ecuador
IF NOT EXISTS(SELECT * FROM SysColumns sc JOIN SysObjects so ON sc.ID = so.ID WHERE so.ID = OBJECT_ID('Venta') AND sc.Name = 'TipoComprobante')
BEGIN
  EXEC spALTER_TABLE 'Venta', 'TipoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Venta', 'SustentoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Venta', 'TipoIdentificacion', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Venta', 'DerechoDevolucion', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'Venta', 'Establecimiento', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'Venta', 'PuntoEmision', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Venta', 'SecuencialSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Venta', 'AutorizacionSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Venta', 'VigenteA', 'AS CONVERT(datetime,NULL)'
  EXEC spALTER_TABLE 'Venta', 'SecuenciaRetencion', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'Venta', 'Comprobante', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'Venta', 'FechaContableMov', 'AS CONVERT(datetime,NULL)'
END
GO

IF EXISTS(SELECT * FROM Empresa WHERE EsEcuador = 1) AND NOT EXISTS(SELECT ID FROM Venta WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL)
BEGIN 
  EXEC spDROP_COLUMN 'Venta', 'TipoComprobante'
  EXEC spDROP_COLUMN 'Venta', 'SustentoComprobante'
  EXEC spDROP_COLUMN 'Venta', 'TipoIdentificacion'
  EXEC spDROP_COLUMN 'Venta', 'DerechoDevolucion'
  EXEC spDROP_COLUMN 'Venta', 'Establecimiento'
  EXEC spDROP_COLUMN 'Venta', 'PuntoEmision'
  EXEC spDROP_COLUMN 'Venta', 'SecuencialSRI'
  EXEC spDROP_COLUMN 'Venta', 'AutorizacionSRI'
  EXEC spDROP_COLUMN 'Venta', 'VigenteA'
  EXEC spDROP_COLUMN 'Venta', 'SecuenciaRetencion'
  EXEC spDROP_COLUMN 'Venta', 'Comprobante'
  EXEC spDROP_COLUMN 'Venta', 'FechaContableMov'
  
  EXEC spALTER_TABLE 'Venta', 'TipoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Venta', 'SustentoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Venta', 'TipoIdentificacion', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Venta', 'DerechoDevolucion', 'bit NULL'
  EXEC spALTER_TABLE 'Venta', 'Establecimiento', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'Venta', 'PuntoEmision', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Venta', 'SecuencialSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Venta', 'AutorizacionSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Venta', 'VigenteA', 'datetime NULL'
  EXEC spALTER_TABLE 'Venta', 'SecuenciaRetencion', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'Venta', 'Comprobante', 'bit NULL'
  EXEC spALTER_TABLE 'Venta', 'FechaContableMov', 'datetime NULL'
END
GO

EXEC spALTER_TABLE 'Venta', 'Ubicacion',    'varchar(1000) NULL'
EXEC spALTER_TABLE 'Venta', 'MapaLatitud',  'float NULL'
EXEC spALTER_TABLE 'Venta', 'MapaLongitud', 'float NULL'
GO

--REQ 13389
EXEC spALTER_TABLE 'Venta', 'CRMID', 'uniqueidentifier NULL'
EXEC spALTER_TABLE 'Venta', 'OpportunityId', 'varchar(36) NULL'
GO

EXEC spALTER_COLUMN 'Venta', 'AFSerie', 'varchar(50) NULL'  --BUG12333
GO

 --REQ 15739 
Exec spAlter_Table 'Venta','CFDFlexEstatus','varchar(15) Null'
--Task 18909
EXEC spALTER_TABLE 'Venta', 'CFDTimbrado', 'bit NULL DEFAULT 0 WITH VALUES'
Go
EXEC spADD_INDEX 'Venta', 'CFDFlexEstatus', 'Estatus, CFDFlexEstatus'
GO

--REQ16092
EXEC spALTER_TABLE 'Venta', 'IDOPORT', 'int NULL'
EXEC spADD_INDEX 'Venta', 'IDOPORT', 'IDOPORT'
GO

EXEC spALTER_TABLE 'Venta', 'IDProyecto', 'int NULL'
GO

--REQ 15448   
  EXEC spALTER_TABLE 'Venta', 'PedidoReferencia'	,'varchar(50)	NULL'
  EXEC spALTER_TABLE 'Venta', 'POSDescuento'	,'varchar(30)	NULL'
  EXEC spALTER_TABLE 'Venta', 'PedidoReferenciaID','int	NULL'  
  EXEC spALTER_TABLE 'Venta', 'Refacturado', 'bit NULL DEFAULT 0 WITH VALUES'
  EXEC spALTER_TABLE 'Venta', 'Monedero','varchar(20)	NULL'
GO  
EXEC spALTER_TABLE 'Venta', 'CrossDocking', 'bit NULL DEFAULT 0 WITH VALUES' --8. Desarrollo de proceso Cross Docking
EXEC spALTER_TABLE 'Venta', 'FacDesgloseIVA', 'bit DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Venta', 'NombreDF','varchar(30) NULL'
EXEC spALTER_TABLE 'Venta', 'ApellidosDF','varchar(60) NULL'
EXEC spALTER_TABLE 'Venta', 'PasaporteDF','varchar(30) NULL'
EXEC spALTER_TABLE 'Venta', 'NacionalidadDF','varchar(30) NULL'
EXEC spALTER_TABLE 'Venta', 'NoVueloDF','varchar(20) NULL'
EXEC spALTER_TABLE 'Venta', 'AerolineaDF','varchar(50) NULL'
EXEC spALTER_TABLE 'Venta', 'OrigenDF','varchar(100) NULL'
EXEC spALTER_TABLE 'Venta', 'DestinoDF','varchar(100) NULL'
EXEC spALTER_TABLE 'Venta', 'POSRedondeoVerif', 'bit DEFAULT 0 WITH VALUES'
GO


EXEC spFK2 'Venta','Cliente','EnviarA','CteEnviarA','Cliente','ID'
EXEC spFK 'Venta','Cliente','Cte','Cliente'
EXEC spFK 'Venta','Almacen','Alm','Almacen'
EXEC spFK 'Venta','Agente','Agente','Agente'
EXEC spFK 'Venta','Descuento','Descuento','Descuento'
EXEC spFK 'Venta','ID','VentaCobro','ID'
EXEC spFK 'Venta','Mensaje','MensajeLista','Mensaje'
EXEC spFK 'Venta','CtaDinero','CtaDinero','CtaDinero'
EXEC spFK 'Venta','Condicion','Condicion','Condicion'
EXEC spFK 'Venta','ContUso','CentroCostos','CentroCostos'
EXEC spFK 'Venta','AutoCorrida','AutoCorrida','Corrida'
EXEC spFK 'Venta','UEN','UEN','UEN'
EXEC spFK 'Venta','Proyecto','Proy','Proyecto'
EXEC spFK 'Venta','LineaCredito','LC','LineaCredito'
EXEC spFK 'Venta','TipoAmortizacion','TipoAmortizacion','TipoAmortizacion'
EXEC spFK 'Venta','TipoTasa','TipoTasa','TipoTasa'
GO

--Integración MES
EXEC spALTER_TABLE 'Venta', 'MesLanzamiento', 'varchar(100) NULL'
GO

--User Story 12321
EXEC spALTER_TABLE 'Venta', 'FolioCRM', 'varchar(50) NULL'
GO

--Integración CRM
EXEC spAlter_Table 'Venta', 'CRMObjectId', 'uniqueidentifier NULL'
GO

--Monedero
EXEC spAlter_Table 'Venta', 'RedimePuntos', 'Bit DEFAULT 0'
GO
-- Venta
-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Venta.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Venta.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Venta.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Venta.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Planeacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Venta.Planeacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Origen' AND sysobjects.id = sysindexes.id)
  DROP INDEX Venta.Origen
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Cliente' AND sysobjects.id = sysindexes.id)
  DROP INDEX Venta.Cliente
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  DROP INDEX Venta.Referencia
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Venta.Abrir
GO

-- Actualizar Indices
if (select version from version)<=2767 and exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id) 
  DROP INDEX Venta.Usuario
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Cliente2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cliente2     ON dbo.Venta (Cliente, EnviarA)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Agente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Agente       ON dbo.Venta (Agente)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Origen2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Origen2      ON dbo.Venta (OrigenID, Origen, OrigenTipo, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Espacio' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Espacio      ON dbo.Venta (Espacio)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Planeacion2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Planeacion2   ON dbo.Venta (ExcluirPlaneacion, Extra, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'ServicioSerie' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ServicioSerie ON dbo.Venta (ServicioSerie)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'ServicioPlacas' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ServicioPlacas ON dbo.Venta (ServicioPlacas)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Referencia2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia2   ON dbo.Venta (Referencia, Empresa)

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Venta (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Venta (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Venta (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Venta (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Venta (Usuario, Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Venta (ContID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Mov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Mov	     ON dbo.Venta (Mov, FechaEmision)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Codigo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Codigo        ON dbo.Venta (Codigo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'Dinero2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Dinero2      ON dbo.Venta (DineroID, Dinero, DineroCtaDinero, Empresa)
GO
/*
CREATE INDEX Sucursal ON dbo.Venta (Sucursal, Mov, FechaEmision, Estatus, Empresa, Moneda)
CREATE INDEX Abrir    ON dbo.Venta (Mov, Estatus, Moneda, Sucursal, Empresa, FechaEmision, GenerarPoliza, FechaCancelacion)
CREATE INDEX Usuario  ON dbo.Venta (Usuario, FechaEmision, Mov, Sucursal, Estatus, Empresa, Moneda)
CREATE INDEX Mov      ON dbo.Venta (Mov, FechaEmision, Sucursal, Estatus, Empresa, Moneda)
*/

--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Venta (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Venta (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Venta' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Venta (OrigenID,Origen,Empresa)
go

CREATE TRIGGER tgVentaC ON Venta
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Ok			int,
    @Modulo		varchar(5),
    @Mov		varchar(20),
    @MovIDN		varchar(20),
    @MovIDA		varchar(20),
    @Empresa		varchar(5),
    @Sucursal		int,
    @ID			int,
    @FechaInicio	datetime,
    @Ahora 		datetime,
    @FechaAnterior	datetime,
    @EstatusNuevo 	varchar(15),
    @EstatusAnterior 	varchar(15),
    @SituacionNueva 	varchar(50),
    @SituacionAnterior 	varchar(50),
    @FechaRequeridaN	datetime,
    @FechaRequeridaA	datetime,
    @Tipo		varchar(50),
    @UsuarioA		varchar(10),
    @UsuarioN		varchar(10),
    @Mensaje		varchar(255),
    @DineroA		varchar(20),
    @DineroN		varchar(20),
    @DineroIDA		varchar(20),
    @DineroIDN		varchar(20),
    @CtaDinero		varchar(10),
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(DineroConciliado) OR UPDATE(DineroFechaConciliacion) RETURN

  SELECT @Modulo = 'VTAS', @Ok = NULL
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), ''), @FechaRequeridaA = FechaRequerida, @DineroA = NULLIF(RTRIM(Dinero), ''), @DineroIDA = NULLIF(RTRIM(DineroID), ''), @UsuarioA = Usuario, @MovIDA = NULLIF(RTRIM(MovID), '') FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @FechaRequeridaN = FechaRequerida, @DineroN = NULLIF(RTRIM(Dinero), ''), @DineroIDN = NULLIF(RTRIM(DineroID), ''), @CtaDinero = DineroCtaDinero, @Empresa = Empresa, @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @MovIDN = NULLIF(RTRIM(MovID), ''), @Tipo = NULLIF(RTRIM(ServicioTipo), ''), @UsuarioN = Usuario FROM Inserted

  IF @DineroA <> @DineroN OR @DineroIDA <> @DineroIDN 
    EXEC spDineroPagado @Empresa, @Modulo, @ID, @DineroA, @DineroN, @DineroIDA, @DineroIDN, @CtaDinero, 100

  IF @MovIDN IS NULL AND @MovIDA IS NOT NULL AND @UsuarioN <> @UsuarioA
    SELECT @Ok = 30015

  IF @EstatusNuevo <> @EstatusAnterior AND 
     ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('CONFIRMAR', 'PROCESAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
      (@EstatusNuevo = 'CONFIRMAR'  AND @EstatusAnterior IN ('PROCESAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO')) OR
      (@EstatusNuevo IN ('PROCESAR', 'PENDIENTE', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
    SELECT @Ok = 60090

  IF @Ok IS NOT NULL 
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    SELECT @Mensaje = RTRIM(@Mensaje) + ' '+RTRIM(@Mov)+' '+RTRIM(@MovIDN)
    RAISERROR (@Mensaje,16,-1) 
  END 
  ELSE BEGIN
    IF @EstatusNuevo NOT IN (NULL, 'AFECTANDO') AND (@EstatusAnterior <> @EstatusNuevo OR @SituacionAnterior <> @SituacionNueva)
    BEGIN
      IF @EstatusAnterior <> @EstatusNuevo AND (@EstatusAnterior <> 'AFECTANDO' OR @SituacionAnterior IS NULL OR @SituacionNueva IS NULL)
      BEGIN
        IF (SELECT ISNULL(VentaServicioSituacionTipo, 0) FROM EmpresaCfg WHERE Empresa = @Empresa) = 0 SELECT @Tipo = NULL
        IF (SELECT Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov) NOT IN ('VTAS.S', 'VTAS.CS') SELECT @Tipo = NULL

        EXEC spMovSituacionNueva @Modulo, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva OUTPUT, @ID = @ID, @Tipo = @Tipo
      END
      SELECT @Ahora = GETDATE(), @FechaInicio = NULL
      SELECT @FechaInicio = MIN(FechaInicio), @FechaAnterior = MAX(FechaComenzo) FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID 
      IF @FechaInicio IS NOT NULL AND @FechaAnterior IS NOT NULL
        UPDATE MovTiempo SET FechaTermino = @Ahora WHERE Modulo = @Modulo AND ID = @ID AND FechaComenzo = @FechaAnterior
      IF @FechaInicio IS NULL SELECT @FechaInicio = @Ahora

      INSERT INTO MovTiempo (Modulo,  Sucursal,  ID,  Usuario,                               FechaInicio,  FechaComenzo, Estatus,       Situacion) 
                     VALUES (@Modulo, @Sucursal, @ID, ISNULL(@AfectacionUsuario, @UsuarioN), @FechaInicio, @Ahora,       @EstatusNuevo, @SituacionNueva)
    END
    IF @EstatusNuevo = 'PENDIENTE' AND @FechaRequeridaA <> @FechaRequeridaN
      UPDATE VentaD SET FechaRequerida = @FechaRequeridaN WHERE ID = @ID AND FechaRequerida = @FechaRequeridaA
  END

  EXEC spMovAlActualizar @Modulo, @ID, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva, @SituacionAnterior

  -- Para que cancele la poliza cuando Maneja SincroContabilidadMatriz
  IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE Venta SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgVentaB ON Venta
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	varchar(15),
    @Mensaje	varchar(255),
    @MovID	varchar(20),
    @Ok		int,
	@TCProcesado1	bit,	--REQ13163	
	@TCProcesado2	bit,	--REQ13163	
	@TCProcesado3	bit,	--REQ13163	
	@TCProcesado4	bit,	--REQ13163	
	@TCProcesado5	bit		--REQ13163

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Ok = NULL
  SELECT @ID = ID, @Estatus = Estatus, @MovID = NULLIF(RTRIM(MovID), '') FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') SELECT @Ok = 60090
  IF @MovID IS NOT NULL SELECT @Ok = 30015

  IF @Ok IS NULL AND EXISTS(SELECT ID FROM VentaCobro WHERE ID = @ID) --REQ13163
  BEGIN
    SELECT @TCProcesado1 = ISNULL(TCProcesado1, 0), @TCProcesado2 = ISNULL(TCProcesado2, 0), @TCProcesado3 = ISNULL(TCProcesado3, 0), @TCProcesado4 = ISNULL(TCProcesado4, 0), @TCProcesado5 = ISNULL(TCProcesado5, 0) FROM VentaCobro WHERE ID = @ID

    IF @TCProcesado1 = 1 OR @TCProcesado2 = 1 OR @TCProcesado3 = 1 OR @TCProcesado4 = 1 OR @TCProcesado5 = 1
      SELECT @Ok = 9
  END
  
  IF @Ok IS NOT NULL
  BEGIN
    IF @Ok IS NOT NULL AND EXISTS(SELECT * FROM Nota WHERE ID = @ID)
      SELECT @Ok = NULL
    ELSE BEGIN     
      SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      RAISERROR (@Mensaje,16,-1) 
    END
  END ELSE 
    EXEC spMovAlEliminar 'VTAS', @ID
END
GO

--REQ 13389
if exists (select * from sysobjects where id = object_id('dbo.tgVentaABC_CRM') and sysstat & 0xf = 8) drop trigger dbo.tgVentaABC_CRM
GO
CREATE TRIGGER tgVentaABC_CRM ON Venta
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @IDI  				int,
    @IDD				int,
    @CRMII				varchar(36),
    @CRMID				varchar(36),
    @Datos				varchar(max),
    @Usuario			varchar(10),
    @Contrasena			varchar(32),
    @Ok					int,
    @OkRef				varchar(255),
    @IDIS				int,
    
    @Accion				varchar(20),
    @OpportunityIdI		varchar(36),
    @OpportunityIdD		varchar(36),
    @EstatusI			varchar(15),
    @EstatusD			varchar(15)
    
  IF dbo.fnEstaSincronizandoCRM() = 1
    RETURN
     
   SELECT
     @Usuario    = Usuario,
     @Contrasena = Contrasena
   FROM CfgCRM
  
  SELECT @IDI = ID, @CRMII = CRMID, @EstatusI = Estatus, @OpportunityIdI = OpportunityId FROM Inserted
  SELECT @IDD = ID, @CRMID = CRMID, @EstatusD = Estatus, @OpportunityIdD = OpportunityId FROM Deleted  
  
  IF (@CRMII IS NULL AND @CRMID IS NULL) OR ((@OpportunityIdI IS NULL) OR (@OpportunityIdI <> '') AND @EstatusI = @EstatusD)
    RETURN

  IF @CRMII IS NOT NULL AND @CRMID IS NULL
    SELECT @Accion = 'INSERT'
  ELSE  
  IF @CRMII IS NOT NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'UPDATE'
  ELSE  
  IF @CRMII IS NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'DELETE'
  ELSE
    RETURN
    
  SELECT @Datos = '<Intelisis Sistema="IntelisisCRM" Contenido="Solicitud" Referencia="IntelisisCRM.CRM" SubReferencia="" Version="1.0">' + '<Solicitud>' + '<' + @Accion + '>'
     
  IF @IDD IS NULL OR @IDD = @IDI
    SELECT @Datos = @Datos + (SELECT CRMID, OpportunityId, Estatus, Observaciones FROM Inserted VentaInv FOR XML AUTO)
  ELSE
    SELECT @Datos = @Datos + (SELECT CRMID, OpportunityId, Estatus, Observaciones FROM Deleted VentaInv FOR XML AUTO)
     
  SELECT @Datos = @Datos + '</' + @Accion + '></Solicitud></Intelisis>'
         
  EXEC spIntelisisService @Usuario, @Contrasena, @Datos, NULL, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IDIS OUTPUT

  SELECT @Datos = '<Intelisis Sistema="IntelisisCRM" Contenido="Solicitud" Referencia="IntelisisCRM.CRM" SubReferencia="" Version="1.0">' + '<Solicitud>' + '<' + @Accion + '>'
     
  IF @IDD IS NULL OR @IDD = @IDI
    SELECT @Datos = @Datos + (SELECT CRMID, OpportunityId, Estatus, Observaciones FROM Inserted VentaOrd FOR XML AUTO)
  ELSE
    SELECT @Datos = @Datos + (SELECT CRMID, OpportunityId, Estatus, Observaciones FROM Deleted VentaOrd FOR XML AUTO)
     
  SELECT @Datos = @Datos + '</' + @Accion + '></Solicitud></Intelisis>'
         
  EXEC spIntelisisService @Usuario, @Contrasena, @Datos, NULL, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IDIS OUTPUT

  SELECT @Datos = '<Intelisis Sistema="IntelisisCRM" Contenido="Solicitud" Referencia="IntelisisCRM.CRM" SubReferencia="" Version="1.0">' + '<Solicitud>' + '<' + @Accion + '>'
          
  IF @IDD IS NULL OR @IDD = @IDI
    SELECT @Datos = @Datos + (SELECT CRMID, OpportunityId, Estatus, Observaciones FROM Inserted VentaOpo FOR XML AUTO)
  ELSE
    SELECT @Datos = @Datos + (SELECT CRMID, OpportunityId, Estatus, Observaciones FROM Deleted VentaOpo FOR XML AUTO)
     
  SELECT @Datos = @Datos + '</' + @Accion + '></Solicitud></Intelisis>'
         
  EXEC spIntelisisService @Usuario, @Contrasena, @Datos, NULL, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IDIS OUTPUT
   
  RETURN
END
GO

--Integración CRM
IF OBJECT_ID ('tr_xcrm_del_venta', 'TR') IS NOT NULL DROP TRIGGER tr_xcrm_del_venta 
GO									
CREATE TRIGGER tr_xcrm_del_venta ON venta 
--//WITH ENCRYPTION	
AFTER DELETE as BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED)
	BEGIN
		--DELETE
		--handle delete data, insert into both the history and the log tables
		
		INSERT INTO xcrm_del_venta
			(ID,Empresa,Mov,FolioCRM,ultimocambio,crmobjectid)
		SELECT ID,Empresa,Mov,ISNULL(FolioCRM,''),GETDATE(),crmobjectid
		FROM DELETED

	END
END
GO

/****** NotaDAgente ******/
if not exists(select * from SysTabla where SysTabla = 'NotaDAgente')
	INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('NotaDAgente','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.NotaDAgente') and type = 'U') 
  CREATE TABLE dbo.NotaDAgente (
	ID 			int         	NOT NULL,
 	Renglon			float	    	NOT NULL,
	RenglonSub		int		NOT NULL,
	RID			int		NOT NULL,

	Agente			varchar(10)	NULL,
	Fecha			datetime	NULL,
	HoraD			varchar(5)	NULL,
	HoraA			varchar(5)	NULL,
	Minutos			int		NULL,
	Actividad		varchar(100)	NULL,
	Estado			varchar(30)	NULL,
	Comentarios		varchar(255)	NULL,
	CantidadEstandar	float		NULL,
	FechaConclusion		datetime	NULL,
	CostoActividad		money		NULL,
	Avance			float		NULL,

	CONSTRAINT priNotaDAgente PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub, RID)
  )
GO
EXEC spModificarPK_Sucursal 'NotaDAgente', '(ID, Renglon, RenglonSub, RID)'
GO

/****** VentaDAgente ******/
if not exists(select * from SysTabla where SysTabla = 'VentaDAgente')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaDAgente','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaDAgente') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VentaDAgente (
	ID 			int         	NOT NULL,
 	Renglon			float	    	NOT NULL,
	RenglonSub		int		NOT NULL,
	RID			int		NOT NULL IDENTITY(1,1),

	Agente			varchar(10)	NULL,
	Fecha			datetime	NULL,
	HoraD			varchar(5)	NULL,
	HoraA			varchar(5)	NULL,
	Minutos			int		NULL,
	Actividad		varchar(100)	NULL,
	Estado			varchar(30)	NULL,
	Comentarios		varchar(255)	NULL,
	CantidadEstandar	float		NULL,
	FechaConclusion		datetime	NULL,
	CostoActividad		money		NULL,
	Avance			float		NULL,

	CONSTRAINT priVentaDAgente PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub, RID)
  )
  EXEC spSincroSemilla 'VentaDAgente'
END
GO
EXEC spModificarPK_Sucursal 'VentaDAgente', '(ID, Renglon, RenglonSub, RID)'
EXEC spALTER_TABLE 'VentaDAgente', 'Fecha', 'datetime NULL'
EXEC spALTER_TABLE 'VentaDAgente', 'Minutos', 'int NULL'
EXEC spALTER_TABLE 'VentaDAgente', 'Actividad', 'varchar(100) NULL'
EXEC spALTER_TABLE 'VentaDAgente', 'Estado', 'varchar(30) NULL'
EXEC spALTER_TABLE 'VentaDAgente', 'Comentarios', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'VentaDAgente', 'CantidadEstandar', 'float NULL'
EXEC spALTER_TABLE 'VentaDAgente', 'FechaConclusion', 'datetime	NULL'
EXEC spALTER_TABLE 'VentaDAgente', 'CostoActividad', 'money NULL'
EXEC spALTER_TABLE 'VentaDAgente', 'Avance', 'float NULL'
GO

EXEC spFK3 'VentaDAgente','ID','Renglon','RenglonSub','VentaD','ID','Renglon','RenglonSub'
EXEC spFK 'VentaDAgente','Agente','Agente','Agente'
EXEC spFK 'VentaDAgente','Actividad','Actividad','Actividad'
GO

/****** Nota (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'NotaD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('NotaD','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.NotaD') and type = 'U') 
CREATE TABLE dbo.NotaD (
	ID 			int         	NOT NULL,
 	Renglon			float	    	NOT NULL,
	RenglonSub		int		NOT NULL DEFAULT 0,

	RenglonID		int		NULL,
	RenglonTipo		char(1)         NULL	DEFAULT 'N',

        Cantidad                float       	NULL,
	Almacen			varchar(10)	NULL,
	EnviarA			int	   	NULL,
	Codigo			varchar(30)	NULL,
	Articulo	        varchar(20)   	NOT NULL,
	SubCuenta		varchar(50)	NULL,
	--nSubCuenta		varchar(20)	NULL	DEFAULT '',
        Precio          	float       	NULL,
        PrecioSugerido         	float       	NULL,
	DescuentoTipo		char(1)    	NULL	DEFAULT '%',
        DescuentoLinea		money		NULL,
        DescuentoImporte	money		NULL,
	Impuesto1		float		NULL,
	Impuesto2		float		NULL,
	Impuesto3		float		NULL,
	DescripcionExtra	varchar(100) 	NULL,
	Costo			money		NULL,
	CostoActividad		money		NULL,
	Paquete			int		NULL,
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20) NULL,	
	ContUso3		varchar(20) NULL,			
	Comision		money		NULL,

	Aplica			varchar(20)	NULL,
	AplicaID		varchar(20)	NULL,

	CantidadPendiente	float	    	NULL,
	CantidadReservada	float	    	NULL,
	CantidadCancelada	float		NULL,
	CantidadOrdenada	float		NULL,
	CantidadEmbarcada	float		NULL,

	CantidadA		float	    	NULL,

	Unidad			varchar(50)	NULL,
	Factor			float	    	NULL	DEFAULT 1.0,
        CantidadInventario      float     	NULL,

	SustitutoArticulo       varchar(20)   	NULL,
	SustitutoSubCuenta	varchar(50)	NULL,
	FechaRequerida		datetime	NULL,
	HoraRequerida		varchar(5)    	NULL,

	Instruccion		varchar(50)	NULL,
	Agente 			varchar(10)   	NULL,
	Departamento		int		NULL,

	UltimoReservadoCantidad	float		NULL,
	UltimoReservadoFecha	datetime	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	PoliticaPrecios		varchar(255)	NULL,

--	SincroID 		timestamp 	NULL,
--	SincroC  		int 		NULL 	 DEFAULT 1,
	SucursalOrigen		int		NULL	 DEFAULT 0,
	AutoLocalidad		varchar(5)	NULL,
	UEN			int		NULL,
	Espacio			varchar(10)	NULL,
	CantidadAlterna		float		NULL,

	PrecioMoneda		varchar(10)	NULL,
	PrecioTipoCambio	float		NULL,
	Estado			varchar(30)	NULL,
	ServicioNumero		float		NULL,
	AgentesAsignados	int		NULL,

	AFArticulo		varchar(20)	NULL,
	AFSerie			varchar(20)	NULL,
	ExcluirPlaneacion	bit		NULL	 DEFAULT 0,
	Anexo			bit		NULL	 DEFAULT 0,

	AjusteCosteo		money		NULL,
	CostoUEPS		money		NULL,
	CostoPEPS		money		NULL,
	UltimoCosto		money		NULL,
	CostoEstandar		money		NULL,  
	PrecioLista		money		NULL,
	DepartamentoDetallista	int		NULL,
	PresupuestoEsp		bit		NULL	DEFAULT 0,	

	Posicion		varchar(10)	NULL,

	Puntos			money		NULL,
	CantidadObsequio	float		NULL,
	OfertaID		int		NULL,
	ProveedorRef		varchar(10)	NULL,
	TransferirA		varchar(10)	NULL,

	ArtEstatus		varchar(15)	NULL,
	ArtSituacion		varchar(50)	NULL,
	Tarima			varchar(20)	NULL,
	ABC			varchar(50)	NULL,
	TipoImpuesto1		varchar(10)	NULL,
	TipoImpuesto2		varchar(10)	NULL,
	TipoImpuesto3		varchar(10)	NULL,

	CONSTRAINT priNotaD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO
EXEC spModificarPK_Sucursal 'NotaD', '(ID, Renglon, RenglonSub)'
GO
EXEC spALTER_TABLE 'NotaD', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NotaD', 'ContUso3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NotaD', 'ABC', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NotaD', 'CostoEstandar', 'money NULL' 
EXEC spALTER_TABLE 'NotaD', 'TipoImpuesto1', 'varchar(10)'
EXEC spALTER_TABLE 'NotaD', 'TipoImpuesto2', 'varchar(10)'
EXEC spALTER_TABLE 'NotaD', 'TipoImpuesto3', 'varchar(10)'
GO

EXEC spALTER_COLUMN 'NotaD', 'AFSerie', 'varchar(50) NULL'  --BUG12333
GO

/****** Ventas (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'VentaD')
	INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaD','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaD') and type = 'U') 
CREATE TABLE dbo.VentaD (
	ID 			int         	NOT NULL,
 	Renglon			float	    	NOT NULL,
	RenglonSub		int		NOT NULL DEFAULT 0,

	RenglonID		int		NULL,
	RenglonTipo		char(1)         NULL DEFAULT 'N',

        Cantidad                float       	NULL,
	Almacen			varchar(10)	NULL,
	EnviarA			int	   	NULL,
	Codigo			varchar(30)	NULL,
	Articulo	        varchar(20)   	NOT NULL,
	SubCuenta		varchar(50)	NULL,
	--nSubCuenta		varchar(20)	NULL	DEFAULT '',
        Precio          	float       	NULL,
        PrecioSugerido         	float       	NULL,
	DescuentoTipo		char(1)    	NULL DEFAULT '%',
        DescuentoLinea		money		NULL,
        DescuentoImporte	money		NULL,
	Impuesto1		float		NULL,
	Impuesto2		float		NULL,
	Impuesto3		float		NULL,
	DescripcionExtra	varchar(100) 	NULL,
	Costo			money		NULL,
	CostoActividad		money		NULL,
	Paquete			int		NULL,
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20)	NULL,
	ContUso3		varchar(20)	NULL,	
	Comision		money		NULL,

	Aplica			varchar(20)	NULL,
	AplicaID		varchar(20)	NULL,

	CantidadPendiente	float	    	NULL,
	CantidadReservada	float	    	NULL,
	CantidadCancelada	float		NULL,
	CantidadOrdenada	float		NULL,
	CantidadEmbarcada	float		NULL,

	CantidadA		float	    	NULL,

	Unidad			varchar(50)	NULL,
	Factor			float	    	NULL DEFAULT 1.0,
        CantidadInventario      float     	NULL,

	SustitutoArticulo       varchar(20)   	NULL,
	SustitutoSubCuenta	varchar(50)	NULL,
	FechaRequerida		datetime	NULL,
	HoraRequerida		varchar(5)    	NULL,

	Instruccion		varchar(50)	NULL,
	Agente 			varchar(10)   	NULL,
	Departamento		int		NULL,

	UltimoReservadoCantidad	float		NULL,
	UltimoReservadoFecha	datetime	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	PoliticaPrecios		varchar(255)	NULL,

--	SincroID 		timestamp 	NULL,
--	SincroC  		int 		NULL 	 DEFAULT 1,
	SucursalOrigen		int		NULL	 DEFAULT 0,
	AutoLocalidad		varchar(5)	NULL,
	UEN			int		NULL,
	Espacio			varchar(10)	NULL,
	CantidadAlterna		float		NULL,

	PrecioMoneda		varchar(10)	NULL,
	PrecioTipoCambio	float		NULL,
	Estado			varchar(30)	NULL,
	ServicioNumero		float		NULL,
	AgentesAsignados	int		NULL,

	AFArticulo		varchar(20)	NULL,
	AFSerie			varchar(20)	NULL,
	ExcluirPlaneacion	bit		NULL	 DEFAULT 0,
	Anexo			bit		NULL	 DEFAULT 0,

	AjusteCosteo		money		NULL,
	CostoUEPS		money		NULL,
	CostoPEPS		money		NULL,
	UltimoCosto		money		NULL,
	CostoEstandar		money		NULL,
	PrecioLista		money		NULL,
	DepartamentoDetallista	int		NULL,
	PresupuestoEsp		bit		NULL	DEFAULT 0,	

	Posicion		varchar(10)	NULL,

	Puntos			money		NULL,
	CantidadObsequio	float		NULL,
	OfertaID		int		NULL,
	ProveedorRef		varchar(10)	NULL,
	TransferirA		varchar(10)	NULL,

	ArtEstatus		varchar(15)	NULL,
	ArtSituacion		varchar(50)	NULL,
	Tarima			varchar(20)	NULL,
	ABC			varchar(50)	NULL,
	
	TipoImpuesto1		varchar(10)	NULL,
	TipoImpuesto2		varchar(10)	NULL,
	TipoImpuesto3		varchar(10)	NULL,

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

	CostoPromedio		money	NULL,
	CostoReposicion		money	NULL,

	TipoRetencion1		varchar(10)	NULL, --MEJORA4648
	TipoRetencion2		varchar(10) NULL, --MEJORA4648
	TipoRetencion3		varchar(10) NULL, --MEJORA4648 
	Retencion1			float		NULL, --MEJORA4648
	Retencion2			float		NULL, --MEJORA4648	
	Retencion3			float		NULL, --MEJORA4648
    POSDesGlobal        float	    NULL, --REQ 13393
    POSDesLinea         float	    NULL, --REQ 13393
    ProcesadoID         int         NULL,  --REQ 15448 
    LDIReferencia       varchar(50)	NULL, --REQ 15448 
    LDICuenta           varchar(50)	NULL, --REQ 15448 
	AplicaRenglon		float	    NULL,	
	
	CONSTRAINT priVentaD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO
if not exists(select * from SysTabla where SysTabla = 'VentaCalcularPropEconomica')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaCalcularPropEconomica','Maestro','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaCalcularPropEconomica') and type = 'U') 
CREATE TABLE dbo.VentaCalcularPropEconomica (
ID				    int,
Renglon			    float,
MaterialServicio    varchar(100) null,
Costo               money null

)
GO
EXEC spALTER_TABLE 'VentaCalcularPropEconomica', 'Descripcion', 'VARCHAR(100) NULL'
GO
EXEC spALTER_TABLE 'VentaCalcularPropEconomica', 'RenglonID',   'float NULL'
GO


if exists (select * from sysobjects where id = object_id('dbo.tgVentaDAC') and sysstat & 0xf = 8) drop trigger dbo.tgVentaDAC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgVentaDB') and sysstat & 0xf = 8) drop trigger dbo.tgVentaDB
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VentaD' AND sysindexes.name = 'Aplica' AND sysobjects.id = sysindexes.id)
    DROP INDEX VentaD.Aplica
  ALTER TABLE VentaD ALTER COLUMN AplicaID varchar(20) NULL
END
GO
EXEC spModificarPK_Sucursal 'VentaD', '(ID, Renglon, RenglonSub)'
EXEC spALTER_TABLE 'VentaD', 'DescuentoImporte', 'money NULL'
EXEC spALTER_TABLE 'VentaD', 'AutoLocalidad', 'varchar(5) NULL'
EXEC spALTER_TABLE 'VentaD', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'VentaD', 'Espacio', 'varchar(10) NULL'
EXEC spALTER_TABLE 'VentaD', 'HoraRequerida', 'varchar(5) NULL'
EXEC spALTER_TABLE 'VentaD', 'CantidadAlterna', 'float NULL'
EXEC spALTER_TABLE 'VentaD', 'CantidadEmbarcada', 'float NULL'
EXEC spALTER_TABLE 'VentaD', 'Estado', 'varchar(30) NULL'
EXEC spALTER_TABLE 'VentaD', 'ServicioNumero', 'float NULL'
EXEC spALTER_TABLE 'VentaD', 'AgentesAsignados', 'int NULL'
EXEC spALTER_TABLE 'VentaD', 'PorcentajeUtilidad', 'float NULL'
GO
EXEC spALTER_COLUMN 'VentaD', 'DescuentoLinea', 'float NULL' --19175
GO
if not exists(select * from syscampo where tabla = 'VentaD' and campo = 'PrecioMoneda')
BEGIN
  EXEC("spALTER_TABLE 'VentaD', 'PrecioMoneda', 'varchar(10) NULL'")
  EXEC("spALTER_TABLE 'VentaD', 'PrecioTipoCambio', 'float NULL'")
  EXEC("UPDATE VentaD SET PrecioMoneda = v.Moneda, PrecioTipoCambio = v.TipoCambio FROM Venta v, VentaD d WHERE v.ID = d.ID")
END
GO
/*if not exists(select * from syscampo where tabla = 'VentaD' and campo = 'nSubCuenta')
BEGIN
  EXEC spALTER_TABLE 'VentaD', 'nSubCuenta', 'varchar(20) NULL DEFAULT "" WITH VALUES'
  EXEC("UPDATE VentaD SET nSubCuenta = ISNULL(SubCuenta, '') FROM VentaD WHERE nSubCuenta <> ISNULL(SubCuenta, '')")
END*/
GO
EXEC spALTER_TABLE 'VentaD', 'AFArticulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'VentaD', 'AFSerie', 'varchar(20) NULL'
EXEC spALTER_TABLE 'VentaD', 'ExcluirPlaneacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VentaD', 'Anexo', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VentaD', 'CostoActividad', 'money NULL'
EXEC spALTER_TABLE 'VentaD', 'Codigo', 'varchar(30) NULL'
EXEC spALTER_TABLE 'VentaD', 'ExcluirISAN', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VentaD', 'PrecioSugerido', 'float NULL'
EXEC spALTER_TABLE 'VentaD', 'CostoUEPS', 'money NULL'
EXEC spALTER_TABLE 'VentaD', 'CostoPEPS', 'money NULL'
EXEC spALTER_TABLE 'VentaD', 'UltimoCosto', 'money NULL'
EXEC spALTER_TABLE 'VentaD', 'PrecioLista', 'money NULL'
EXEC spALTER_TABLE 'VentaD', 'Posicion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'VentaD', 'AjusteCosteo', 'money NULL'
EXEC spALTER_TABLE 'VentaD', 'DepartamentoDetallista', 'int NULL'
EXEC spALTER_TABLE 'VentaD', 'PresupuestoEsp', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spRENAME_COLUMN 'VentaD', 'ImporteTarjetaPuntos', 'Puntos'
GO
EXEC spALTER_TABLE 'VentaD', 'Puntos', 'money NULL'	
EXEC spALTER_TABLE 'VentaD', 'CantidadObsequio', 'float NULL'
EXEC spALTER_TABLE 'VentaD', 'OfertaID', 'int NULL'
EXEC spALTER_TABLE 'VentaD', 'ProveedorRef', 'varchar(10) NULL'
EXEC spALTER_TABLE 'VentaD', 'TransferirA', 'varchar(10) NULL'
EXEC spALTER_TABLE 'VentaD', 'ArtEstatus', 'varchar(15)	NULL'
EXEC spALTER_TABLE 'VentaD', 'ArtSituacion', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'VentaD', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'VentaD', 'ContUso3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'VentaD', 'CostoEstandar', 'money NULL'
GO
EXEC spALTER_COLUMN 'VentaD', 'Impuesto3', 'float NULL'
GO
EXEC spALTER_TABLE 'VentaD', 'Tarima', 'varchar(20) NULL'
GO
EXEC spALTER_COLUMN 'VentaD', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'VentaD', 'SustitutoSubCuenta', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'VentaD', 'OrdenCompra', 'varchar(20) NULL'
GO
if (select version from version) <= 2468
  ALTER TABLE VentaD ALTER COLUMN precio float NULL
GO
if not exists(select * from syscampo where tabla = 'VentaD' and Campo='EnviarA')
BEGIN
  EXEC("ALTER TABLE VentaD ADD EnviarA int NULL")
  EXEC("UPDATE VentaD SET EnviarA = e.EnviarA FROM Venta e, VentaD d WHERE e.ID = d.ID")
END
GO
if (select version from version)<=2625
  ALTER TABLE VentaD ALTER COLUMN ServicioNumero float NULL
GO
EXEC spALTER_TABLE 'VentaD', 'ABC', 'varchar(50)'
EXEC spALTER_TABLE 'VentaD', 'TipoImpuesto1', 'varchar(10)'
EXEC spALTER_TABLE 'VentaD', 'TipoImpuesto2', 'varchar(10)'
EXEC spALTER_TABLE 'VentaD', 'TipoImpuesto3', 'varchar(10)'
GO

EXEC spALTER_TABLE 'VentaD', 'CostoPromedio', 'money NULL'
EXEC spALTER_TABLE 'VentaD', 'CostoReposicion', 'money NULL'
GO
EXEC spAlter_Table 'VentaD', 'TipoRetencion1', 'varchar(10) NULL' --MEJORA4648
EXEC spAlter_Table 'VentaD', 'TipoRetencion2', 'varchar(10) NULL' --MEJORA4648 
EXEC spAlter_Table 'VentaD', 'TipoRetencion3', 'varchar(10) NULL' --MEJORA4648 
EXEC spAlter_Table 'VentaD', 'Retencion1', 'float NULL' --MEJORA4648
EXEC spAlter_Table 'VentaD', 'Retencion2', 'float NULL' --MEJORA4648
EXEC spAlter_Table 'VentaD', 'Retencion3', 'float NULL' --MEJORA4648
EXEC spAlter_Table 'VentaD', 'AnticipoFacturado','bit NULL DEFAULT 0 WITH VALUES' --ANTICIPOFACTURADO
EXEC spAlter_Table 'VentaD', 'AnticipoMoneda','varchar(10) NULL'
EXEC spAlter_Table 'VentaD', 'AnticipoTipoCambio','float NULL'
EXEC spAlter_Table 'VentaD', 'AnticipoRetencion','float NULL'
GO

EXEC spALTER_TABLE 'VentaD', 'AplicaRenglon', 'float NULL'
GO
-- REQ12336
EXEC spALTER_TABLE 'VentaD', 'EmidaTelefono', 'varchar(10) NULL'
GO
-- REQ12336
EXEC spALTER_TABLE 'VentaD', 'EmidaConfirmarTelefono', 'varchar(10) NULL'
GO

-- REQ13848
EXEC spRENAME_COLUMN 'VentaD', 'EmidaTelefono', 'RecargaTelefono'
GO
-- REQ13848
EXEC spRENAME_COLUMN 'VentaD', 'EmidaConfirmarTelefono', 'RecargaConfirmarTelefono'
GO

IF NOT EXISTS(SELECT * FROM SysColumns sc JOIN SysObjects so ON sc.ID = so.ID WHERE so.ID = OBJECT_ID('VentaD') AND sc.Name = 'TipoComprobante')
BEGIN
  EXEC spALTER_TABLE 'VentaD', 'TipoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'VentaD', 'SustentoComprobante', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'VentaD', 'TipoIdentificacion', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'VentaD', 'DerechoDevolucion', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'VentaD', 'Establecimiento', 'AS CONVERT(varchar(20),NULL)'
  EXEC spALTER_TABLE 'VentaD', 'PuntoEmision', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'VentaD', 'SecuencialSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'VentaD', 'AutorizacionSRI', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'VentaD', 'VigenteA', 'AS CONVERT(datetime,NULL)'
  EXEC spALTER_TABLE 'VentaD', 'SecuenciaRetencion', 'AS CONVERT(varchar(50),NULL)'
  EXEC spALTER_TABLE 'VentaD', 'Comprobante', 'AS CONVERT(bit,0)'
  EXEC spALTER_TABLE 'VentaD', 'FechaContableMov', 'AS CONVERT(datetime,NULL)'
END
GO

IF EXISTS(SELECT * FROM Empresa WHERE EsEcuador = 1) AND NOT EXISTS(SELECT ID FROM VentaD WHERE TipoComprobante IS NOT NULL OR SustentoComprobante IS NOT NULL OR TipoIdentificacion IS NOT NULL OR DerechoDevolucion IS NOT NULL OR Establecimiento IS NOT NULL OR PuntoEmision IS NOT NULL OR SecuencialSRI IS NOT NULL OR AutorizacionSRI IS NOT NULL OR VigenteA IS NOT NULL OR SecuenciaRetencion IS NOT NULL OR Comprobante IS NOT NULL OR FechaContableMov IS NOT NULL) 
BEGIN
  EXEC spDROP_COLUMN 'VentaD', 'TipoComprobante'
  EXEC spDROP_COLUMN 'VentaD', 'SustentoComprobante'
  EXEC spDROP_COLUMN 'VentaD', 'TipoIdentificacion'
  EXEC spDROP_COLUMN 'VentaD', 'DerechoDevolucion'
  EXEC spDROP_COLUMN 'VentaD', 'Establecimiento'
  EXEC spDROP_COLUMN 'VentaD', 'PuntoEmision'
  EXEC spDROP_COLUMN 'VentaD', 'SecuencialSRI'
  EXEC spDROP_COLUMN 'VentaD', 'AutorizacionSRI'
  EXEC spDROP_COLUMN 'VentaD', 'VigenteA'
  EXEC spDROP_COLUMN 'VentaD', 'SecuenciaRetencion'
  EXEC spDROP_COLUMN 'VentaD', 'Comprobante'
  EXEC spDROP_COLUMN 'VentaD', 'FechaContableMov'

  EXEC spALTER_TABLE 'VentaD', 'TipoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'VentaD', 'SustentoComprobante', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'VentaD', 'TipoIdentificacion', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'VentaD', 'DerechoDevolucion', 'bit NULL'
  EXEC spALTER_TABLE 'VentaD', 'Establecimiento', 'varchar(20) NULL'
  EXEC spALTER_TABLE 'VentaD', 'PuntoEmision', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'VentaD', 'SecuencialSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'VentaD', 'AutorizacionSRI', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'VentaD', 'VigenteA', 'datetime NULL'
  EXEC spALTER_TABLE 'VentaD', 'SecuenciaRetencion', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'VentaD', 'Comprobante', 'bit NULL'
  EXEC spALTER_TABLE 'VentaD', 'FechaContableMov', 'datetime NULL'
END
GO

  EXEC spALTER_TABLE 'VentaD', 'POSDesGlobal'	,'float	NULL' --REQ 13393 POS  
  EXEC spALTER_TABLE 'VentaD', 'POSDesLinea'	,'float	NULL'--REQ 13393 POS  
  EXEC spALTER_TABLE 'VentaD', 'ProcesadoID'	,'int	NULL' --REQ 15448 
  EXEC spALTER_TABLE 'VentaD', 'LDICuenta', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'VentaD', 'LDIReferencia', 'varchar(50) NULL'
  EXEC spALTER_TABLE 'VentaD', 'OfertaID', 'int NULL'
  EXEC spALTER_TABLE 'VentaD', 'OfertaIDP1', 'int NULL'
  EXEC spALTER_TABLE 'VentaD', 'OfertaIDP2', 'int NULL'
  EXEC spALTER_TABLE 'VentaD', 'OfertaIDP3', 'int NULL'
  EXEC spALTER_TABLE 'VentaD', 'OfertaIDG1', 'int NULL'
  EXEC spALTER_TABLE 'VentaD', 'OfertaIDG2', 'int NULL'
  EXEC spALTER_TABLE 'VentaD', 'OfertaIDG3', 'int NULL'
  EXEC spALTER_TABLE 'VentaD', 'DescuentoP1', 'float NULL'
  EXEC spALTER_TABLE 'VentaD', 'DescuentoP2', 'float NULL'
  EXEC spALTER_TABLE 'VentaD', 'DescuentoP3', 'float NULL'
  EXEC spALTER_TABLE 'VentaD', 'DescuentoG1', 'float NULL'
  EXEC spALTER_TABLE 'VentaD', 'DescuentoG2', 'float NULL'
  EXEC spALTER_TABLE 'VentaD', 'DescuentoG3', 'float NULL'
  EXEC spALTER_TABLE 'VentaD', 'DescuentoLinea', 'float NULL'
GO  

EXEC spFK2 'VentaD','Almacen','Posicion','AlmPos','Almacen','Posicion'
EXEC spFK 'VentaD','Codigo','CB','Codigo'
EXEC spFK 'VentaD','Articulo','Art','Articulo'
EXEC spFK 'VentaD','ContUso','CentroCostos','CentroCostos'
EXEC spFK 'VentaD','UEN','UEN','UEN'
EXEC spFK 'VentaD','ProveedorRef','Prov','Proveedor'
GO

EXEC spALTER_COLUMN 'VentaD', 'AFSerie', 'varchar(50) NULL'  --BUG12333
GO

--Integración MES
EXEC spALTER_TABLE 'VentaD', 'MesLanzamiento', 'varchar(100) NULL'
GO

--Integración CRM
EXEC spAlter_Table 'Ventad', 'CRMObjectId', 'uniqueidentifier NULL'
GO

EXEC spALTER_TABLE 'VentaD', 'RecargaTelefono', 'varchar(10) NULL'
EXEC spALTER_TABLE 'VentaD', 'RecargaConfirmarTelefono', 'varchar(10) NULL'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VentaD' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.VentaD (Articulo, SubCuenta)
/*if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VentaD' AND sysindexes.name = 'nSubCuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX nSubCuenta ON dbo.VentaD (Articulo, nSubCuenta)*/
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VentaD' AND sysindexes.name = 'Aplica' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Aplica   ON dbo.VentaD (Aplica, AplicaID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VentaD' AND sysindexes.name = 'MatarPendiente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MatarPendiente ON dbo.VentaD (ID, Articulo, SubCuenta)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VentaD' AND sysindexes.name = 'Agente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Agente ON dbo.VentaD (Agente)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VentaD' AND sysindexes.name = 'AlmExistencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX AlmExistencia ON VentaD (Almacen,Articulo)INCLUDE (ID,CantidadPendiente)
GO

if exists (select * from sysobjects where id = object_id('dbo.cVentaD') and sysstat & 0xf = 2) drop view dbo.cVentaD
GO
CREATE VIEW cVentaD
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
		EnviarA,
		Codigo,
		Articulo,
		SubCuenta,
		--nSubCuenta,
		Precio,
		PrecioSugerido,
		DescuentoTipo,
		DescuentoLinea,
		DescuentoImporte,
		Impuesto1,
		Impuesto2,
		Impuesto3,
		DescripcionExtra,
		Costo,
		CostoActividad,
		Paquete,
		ContUso,
		ContUso2,
		ContUso3,

		--  Comision,

		Aplica,
		AplicaID,

		CantidadPendiente,
		CantidadReservada,
		CantidadCancelada,
		CantidadOrdenada,
		CantidadObsequio,

		CantidadA,

		Unidad,
		Factor,
		CantidadInventario,

		SustitutoArticulo,
		SustitutoSubCuenta,
		FechaRequerida,
		HoraRequerida,

		Instruccion,

		UltimoReservadoCantidad,
		UltimoReservadoFecha,
  
		Agente,
		Departamento,
		Sucursal,
		SucursalOrigen,
		AutoLocalidad,
		UEN,
		Espacio,
		CantidadAlterna,
		PoliticaPrecios,
		PrecioMoneda,
		PrecioTipoCambio,
		AFArticulo,
		AFSerie,
		ExcluirPlaneacion,
		Anexo, 
		Estado,
		ExcluirISAN,
		Posicion,
		PresupuestoEsp,
		ProveedorRef,
		TransferirA,
		Tarima,
		ABC,
		TipoImpuesto1,
		TipoImpuesto2,
		TipoImpuesto3,
		OrdenCompra,
  
		TipoRetencion1,
		TipoRetencion2,
		TipoRetencion3,
		Retencion1,
		Retencion2,
		Retencion3,
		AnticipoFacturado,
		AnticipoMoneda,
		AnticipoTipoCambio,
		AnticipoRetencion,
  
		RecargaTelefono,			-- REQ12336 REQ13848
		RecargaConfirmarTelefono,	-- REQ12336 REQ13848
		AplicaRenglon,
		MesLanzamiento,
		Puntos						-- Monedero
	FROM
		VentaD
GO

-- Aqui va el Matenimiento a la tabla
if not exists(select * from syscampo where tabla = 'VentaD' and campo = 'PoliticaPrecios')
  ALTER TABLE VentaD ADD PoliticaPrecios varchar(255) NULL
GO

EXEC spALTER_TABLE 'VentaD', 'ArtCambioClave', 'varchar (50) NULL'
EXEC spALTER_TABLE 'VentaD', 'IDCopiaMAVI', 'int NULL'
GO


CREATE TRIGGER tgVentaDAC ON VentaD
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
/*  IF UPDATE(SubCuenta) 
    UPDATE VentaD 
       SET nSubCuenta = ISNULL(i.SubCuenta, '') 
      FROM VentaD d, Inserted i 
     WHERE d.ID = i.ID AND d.Renglon = i.Renglon AND d.RenglonSub = i.RenglonSub AND (d.nSubCuenta IS NULL OR d.nSubCuenta <> ISNULL(i.SubCuenta, ''))
*/
/*  DELETE VentaD
    FROM VentaD d
    JOIN inserted i ON i.ID = d.ID AND i.Renglon = d.Renglon AND i.RenglonSub = d.RenglonSub
     AND NULLIF(RTRIM(d.Articulo), '') IS NULL*/

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF NOT UPDATE(Articulo) RETURN

  DECLARE
    @ID		int,
    @Renglon	float,
    @RenglonSub int

  SELECT @ID = MIN(ID), @Renglon = MIN(Renglon), @RenglonSub = MIN(RenglonSub) FROM Inserted WHERE NULLIF(RTRIM(Articulo), '') IS NULL
  IF @ID IS NOT NULL AND @Renglon IS NOT NULL AND @RenglonSub IS NOT NULL
    DELETE VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

  SELECT @ID = ID FROM Inserted
  IF @ID IS NOT NULL AND NOT EXISTS (SELECT ID FROM Venta WHERE ID = @ID)
  BEGIN
    RAISERROR('El Movimiento Ya Fue Eliminado',16,-1)     
  END
END
GO

CREATE TRIGGER tgVentaDB ON VentaD
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Renglon	float,
    @RenglonSub int,
    @RenglonID int,
    @Articulo varchar(20),
    @Subcuenta varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Renglon = Renglon, @RenglonSub = RenglonSub, @RenglonId = RenglonID, @Articulo = Articulo, @Subcuenta = Subcuenta FROM Deleted
  DELETE VentaDAgente WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
  DELETE SerieLoteMov WHERE Modulo = 'VTAS' AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@Subcuenta,'')

END
GO

--Integración CRM
IF OBJECT_ID ('tr_xcrm_del_ventad', 'TR') IS NOT NULL DROP TRIGGER tr_xcrm_del_ventad 
GO									
CREATE TRIGGER tr_xcrm_del_ventad ON ventad 
--//WITH ENCRYPTION	
AFTER DELETE as BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM DELETED)
	BEGIN
		--DELETE
		--handle delete data, insert into both the history and the log tables
		INSERT INTO xcrm_del_ventad
			(ID,Renglon,renglonid,renglonsub,articulo,ultimocambio,crmobjectid)
		SELECT DELETED.ID,Renglon,DELETED.renglonid,renglonsub,articulo,GETDATE(),DELETED.crmobjectid
		FROM DELETED
			join Venta on (DELETED.ID = Venta.id)
		Where Venta.folioCRM is not null

	END
END
GO

/****** Politicas de Precios y Descuentos ******/
if not exists(select * from SysTabla where SysTabla = 'Precio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Precio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Precio') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Precio (
	ID			int       	NOT NULL IDENTITY(1,1),

	Descripcion		varchar(50)	NULL,
	Estatus			varchar(15)	NULL,
	UltimoCambio		datetime	NULL,

	NivelArticulo		bit		NOT NULL DEFAULT 0,
	Articulo 		varchar(20) 	NULL,
	NivelSubCuenta		bit		NOT NULL DEFAULT 0,
	SubCuenta		varchar(50)	NULL,
	NivelArtGrupo		bit		NOT NULL DEFAULT 0,
	ArtGrupo  		varchar(50) 	NULL,
	NivelArtCat		bit		NOT NULL DEFAULT 0,
	ArtCat  		varchar(50) 	NULL,
	NivelArtFam		bit		NOT NULL DEFAULT 0,
	ArtFam  		varchar(50) 	NULL,
	NivelArtABC		bit		NOT NULL DEFAULT 0,
	ArtABC  		char(1) 	NULL,
	NivelFabricante		bit		NOT NULL DEFAULT 0,
	Fabricante 		varchar(50) 	NULL,
	NivelArtLinea		bit		NULL DEFAULT 0,
	ArtLinea 		varchar(50) 	NULL,
	NivelArtRama		bit		NULL DEFAULT 0,
	ArtRama 		varchar(20) 	NULL,

	NivelCliente		bit		NOT NULL DEFAULT 0,
	Cliente 		varchar(10) 	NULL,
	NivelCteGrupo		bit		NOT NULL DEFAULT 0,
	CteGrupo  		varchar(50) 	NULL,
	NivelCteCat		bit		NOT NULL DEFAULT 0,
	CteCat  		varchar(50) 	NULL,
	NivelCteFam		bit		NOT NULL DEFAULT 0,
	CteFam  		varchar(50) 	NULL,
	NivelCteZona		bit		NOT NULL DEFAULT 0,
	CteZona  		varchar(50) 	NULL,

	NivelMoneda		bit		NOT NULL DEFAULT 0,
	Moneda			varchar(10)  	NULL,
	NivelCondicion		bit		NOT NULL DEFAULT 0,
	Condicion		varchar(50)  	NULL,
	NivelAlmacen		bit		NOT NULL DEFAULT 0,
	Almacen 		varchar(10)  	NULL,
	NivelProyecto		bit		NOT NULL DEFAULT 0,
	Proyecto 		varchar(50) 	NULL,
	NivelAgente		bit		NOT NULL DEFAULT 0,
	Agente			varchar(10)	NULL,
	NivelFormaEnvio		bit		NOT NULL DEFAULT 0,
	FormaEnvio		varchar(50)  	NULL,
	NivelMov		bit		NOT NULL DEFAULT 0,
	Mov			varchar(20)     NULL,
	NivelServicioTipo	bit		NOT NULL DEFAULT 0,
	ServicioTipo		varchar(50)	NULL,
	NivelContratoTipo	bit		NOT NULL DEFAULT 0,
	ContratoTipo		varchar(50)	NULL,

	NivelUnidadVenta	bit		NOT NULL DEFAULT 0,
	UnidadVenta		varchar(50)  	NULL,

	NivelEmpresa		bit		NOT NULL DEFAULT 0,
	Empresa			varchar(5)  	NULL,
	NivelRegion		bit		NULL	 DEFAULT 0,
	Region			varchar(50)	NULL,
	NivelSucursal		bit		NULL	 DEFAULT 0,
	Sucursal		int		NULL,

	Tipo			varchar(23)	NULL,  -- Precio, % Descuento, $ Descuento, Costo + %, Costo + $, Margen
	Nivel			varchar(10)	NULL,  -- Normal, Exclusiva, Siempre
	ListaPrecios		varchar(20)	NULL 	 DEFAULT 'Todas',

	ConVigencia		bit		NOT NULL DEFAULT 0,
        FechaD			datetime  	NULL,
	FechaA			datetime  	NULL,

	ArticuloObsequio	varchar(20)	NULL,
	CantidadObsequio	float		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	wMostrar		bit		NULL DEFAULT 0,

	CONSTRAINT priPrecio PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Precio'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'Precio', '(ID)'
GO
EXEC spALTER_TABLE 'Precio', 'NivelSucursal', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Precio', 'Sucursal', 'int NULL'
EXEC spALTER_TABLE 'Precio', 'NivelArtLinea', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Precio', 'ArtLinea', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Precio', 'NivelArtRama', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Precio', 'ArtRama', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Precio', 'wMostrar', 'bit NULL DEFAULT 0 WITH VALUES'
go
if (select version from version)<=1419
  alter table Precio alter column Sucursal int NULL
EXEC spALTER_TABLE 'Precio', 'NivelRegion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Precio', 'Region', 'varchar(50) NULL'
go
EXEC spALTER_COLUMN 'Precio', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'Precio', 'ListaPrecios', 'varchar(20) NULL'
GO

EXEC spFK 'Precio','Articulo','Art','Articulo'
EXEC spFK 'Precio','Cliente','Cte','Cliente'
EXEC spFK 'Precio','Agente','Agente','Agente'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Precio' AND sysindexes.name = 'Art' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Art ON dbo.Precio (Articulo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Precio' AND sysindexes.name = 'Cliente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cliente ON dbo.Precio (Cliente)
go

/****** Precios y Descuentos ******/
if not exists(select * from SysTabla where SysTabla = 'PrecioD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PrecioD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PrecioD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PrecioD (
	ID			int       	NOT NULL,

	Cantidad		float		NOT NULL DEFAULT 0,
	Monto			money		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	GUID                    varchar(50)     NOT NULL DEFAULT NEWID(),-- REQ13987

	CONSTRAINT priPrecioD PRIMARY KEY CLUSTERED (ID, Cantidad)
  )
  EXEC spSincroSemilla 'Precio'
END
GO

-- REQ13987
Exec spAlter_Table 'PrecioD','GUID','varchar(50) NOT NULL DEFAULT NEWID() WITH VALUES'

EXEC spModificarPK_SucursalSinOrigen 'PrecioD', '(ID, Cantidad)'
GO

EXEC spFK 'PrecioD','ID','Precio','ID'
GO

/****** VentaFacturaAnticipo ******/
if not exists(select * from SysTabla where SysTabla = 'VentaFacturaAnticipo')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaFacturaAnticipo','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaFacturaAnticipo') and type = 'U') 
CREATE TABLE dbo.VentaFacturaAnticipo (
	ID 			int         	NOT NULL,
	CxcID			int		NOT NULL,

	Importe			money		NULL,	

	CONSTRAINT priVentaFacturaAnticipo PRIMARY KEY CLUSTERED (ID, CxcID)
)
GO
EXEC spModificarPK_Sucursal 'VentaFacturaAnticipo', '(ID, CxcID)'
GO



/****** Venta Restringida ******/
if not exists(select * from SysTabla where SysTabla = 'VentaRestringida')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VentaRestringida','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.VentaRestringida') and type = 'U') 
CREATE TABLE dbo.VentaRestringida (
	Empresa			varchar(5)	NOT NULL,
	Agrupador		varchar(20)	NOT NULL,  -- Categoria, Grupo, Familia, Fabricante, Linea
	Nombre			varchar(50) 	NOT NULL,  -- HP

	FechaD			datetime	NULL,
	FechaA			datetime	NULL,

	CONSTRAINT priVentaRestringida PRIMARY KEY CLUSTERED (Empresa, Agrupador, Nombre)
)
GO


/****** VentaCB ******/
if not exists(select * from SysTabla where SysTabla = 'VentaCB')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaCB','Movimiento','VTAS')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.VentaCB') AND Type = 'U')
CREATE TABLE VentaCB(

	ID			int			NOT NULL,
	RenglonID		int			NOT NULL,
	Codigo			varchar(20)		NOT NULL,

	Cantidad		float			NULL,
	Articulo		varchar(20)		NULL,
	SubCuenta		varchar(50)		NULL,

    CONSTRAINT priVentaCB PRIMARY KEY CLUSTERED (ID, RenglonID, Codigo)
)
GO
EXEC spModificarPK_Sucursal 'VentaCB', '(ID, RenglonID, Codigo)'
GO
EXEC spALTER_COLUMN 'VentaCB', 'SubCuenta', 'varchar(50) NULL'
GO
/****** VentaIntelisis ******/
if not exists(select * from SysTabla where SysTabla = 'VentaIntelisis')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaIntelisis','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaIntelisis') and type = 'U') 
CREATE TABLE dbo.VentaIntelisis (
	ID 			int         	NOT NULL,
	
	Descripcion		varchar(255)	NULL,
	Problema		text		NULL,
	SolucionActual		text		NULL,
	SolucionSugerida	text		NULL,
	Layout			text		NULL,
	Ejemplos		text		NULL,
	Filtros			text		NULL,
	Ubicacion		varchar(255)	NULL,
	Respaldo		varchar(255)	NULL,
	Version			int		NULL,
	ContactoSolicitante	varchar(50)	NULL,
	ContactoDudas		varchar(50)	NULL,
	ContactoAutorizacion	varchar(50)	NULL,
	ContactoFacturacion	varchar(50)	NULL,
	FechaSolicitud 		datetime	NULL,
	FechaRequerida		datetime	NULL,
	FechaAutorizacion	datetime	NULL,
	Solucion		text		NULL,
	Requerimientos		text		NULL,
	Instrucciones		text		NULL,
	FechaEntregaPrometida	datetime	NULL,
	FechaEntregaReal	datetime	NULL,
	VersionEntrega		int		NULL,
	AgenteProgramador	varchar(10)	NULL,
	AgenteCalidad		varchar(10)	NULL,

	CONSTRAINT priVentaIntelisis PRIMARY KEY CLUSTERED (ID)
)
GO
EXEC spModificarPK_Sucursal 'VentaIntelisis', '(ID)'
GO
EXEC spALTER_TABLE 'VentaIntelisis', 'AgenteProgramador', 'varchar(10) NULL'
EXEC spALTER_TABLE 'VentaIntelisis', 'AgenteCalidad', 'varchar(10) NULL'
GO

EXEC spFK 'VentaIntelisis','AgenteProgramador','Agente','Agente'
GO

/****** VentaParticipacion ******/
if not exists(select * from SysTabla where SysTabla = 'VentaParticipacion')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaParticipacion','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaParticipacion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VentaParticipacion (
	ID 			int         	NOT NULL,
        RID                     int             NOT NULL IDENTITY(1,1),
	
        Concepto                varchar(50)     NULL,
        Acreedor                varchar(10)     NULL,
        Importe                 money           NULL,
	Automatica		bit		NULL	DEFAULT 0,

	CONSTRAINT priVentaParticipacion PRIMARY KEY CLUSTERED (ID, RID)
  )
  EXEC spSincroSemilla 'VentaParticipacion'
END
GO
EXEC spModificarPK_Sucursal 'VentaParticipacion', '(ID, RID)'
GO
EXEC spALTER_TABLE 'VentaParticipacion', 'Automatica', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spFK 'VentaParticipacion','Acreedor','Prov','Proveedor'
GO

/****** VentaFEA ******/
if not exists(select * from SysTabla where SysTabla = 'VentaFEA')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaFEA','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaFEA') and type = 'U') 
CREATE TABLE dbo.VentaFEA (
	ID			int		NOT NULL, 		-- Venta.ID
	
	Serie			varchar(20)	NULL,
	Folio			int		NULL,
	Aprobacion		int		NULL,
	Procesar		bit		NULL DEFAULT 0,
	Cancelar		bit		NULL DEFAULT 0,
	Cancelada 		bit		NULL DEFAULT 0,

	Error			bit		NULL DEFAULT 0,
	Firmada			bit		NULL DEFAULT 0,
	Sello			varchar(max)	NULL,
	Certificado		varchar(20)	NULL,
	CadenaOriginal		text		NULL,
	Documento		text 		NULL,
	Mensaje			varchar(255)	NULL,

	CONSTRAINT priVentaFEA PRIMARY KEY  CLUSTERED (ID)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VentaFEA' AND sysindexes.name = 'Procesar' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Procesar ON dbo.VentaFEA (Procesar)
GO
EXEC spALTER_TABLE 'VentaFEA', 'Aprobacion', 'int NULL'
EXEC spALTER_TABLE 'VentaFEA', 'Sello', 'varchar(max) NULL'
EXEC spALTER_TABLE 'VentaFEA', 'Certificado', 'varchar(20) NULL'
EXEC spALTER_TABLE 'VentaFEA', 'CadenaOriginal', 'text NULL'
EXEC spALTER_TABLE 'VentaFEA', 'Error', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VentaFEA', 'Cancelar', 'bit NULL DEFAULT 0 WITH VALUES'
GO
--BUG8490
EXEC spALTER_COLUMN 'VentaFEA', 'Sello', 'varchar(max) NULL'
GO
EXEC spModificarPK_Sucursal 'VentaFEA', '(ID)'
GO


/****** VentaAdenda ******/
if not exists(select * from SysTabla where SysTabla = 'VentaAdenda')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaAdenda','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaAdenda') and type = 'U') 
CREATE TABLE dbo.VentaAdenda (
	ID			int		NOT NULL, 		-- Venta.ID
	
	Adenda			text 		NULL,

	CONSTRAINT priVentaAdenda PRIMARY KEY  CLUSTERED (ID)
)
GO
EXEC spModificarPK_Sucursal 'VentaAdenda', '(ID)'
GO


/****** FEAParam ******/
if not exists(select * from SysTabla where SysTabla = 'FEAParam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FEAParam','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.FEAParam') and type = 'U') 
CREATE TABLE dbo.FEAParam (
	Estacion		int		NOT NULL, 

	WebService		varchar(255)	NULL,
	CertificadoServicio	varchar(255)	NULL,
	CertificadoUsuario	varchar(255)	NULL,
	LlaveUsuario		varchar(255)	NULL,
	ID			int		NULL,
	RFC			varchar(20)	NULL,
	Mes			int		NULL,
	Ano			int		NULL,
	DirTemp1		varchar(255)	NULL,
	DirTemp2		varchar(255)	NULL,
	DirTemp3		varchar(255)	NULL,

	CONSTRAINT priFEAParam PRIMARY KEY  CLUSTERED (Estacion)
)
GO

/****** FEAReporteMensual ******/
if not exists(select * from SysTabla where SysTabla = 'FEAReporteMensual')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FEAReporteMensual','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.FEAReporteMensual') and type = 'U') 
CREATE TABLE dbo.FEAReporteMensual (
	Fecha			datetime	NOT NULL, 
	
	ReporteMensual		text 		NULL,

	CONSTRAINT priFEAReporteMensual PRIMARY KEY  CLUSTERED (Fecha)
)
GO


/****** VentaDPresupuestoEsp ******/
if not exists (select * from SysTabla where SysTabla = 'VentaDPresupuestoEsp') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('VentaDPresupuestoEsp','Movimiento','COMS')
if not exists (select * from sysobjects where id = object_id('dbo.VentaDPresupuestoEsp') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VentaDPresupuestoEsp (
	ID 			int             NOT NULL,
	Renglon			float		NOT NULL,
	RenglonSub		int		NOT NULL,
	CuentaPresupuesto	varchar(20)	NOT NULL,

	Importe			money		NULL,

	CONSTRAINT priVentaDPresupuestoEsp PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub, CuentaPresupuesto)
  )
  EXEC spSincroSemilla 'VentaDPresupuestoEsp'
END
GO
EXEC spModificarPK_Sucursal 'VentaDPresupuestoEsp', '(ID, Renglon, RenglonSub, CuentaPresupuesto)'
GO

EXEC spFK 'VentaDPresupuestoEsp','CuentaPresupuesto','Cta','Cuenta'
GO

-- select * from listafiltro
--delete listafiltro
-- drop table VentaTFiltro
/****** VentaTFiltro ******/
if not exists(select * from SysTabla where SysTabla = 'VentaTFiltro')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VentaTFiltro','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.VentaTFiltro') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VentaTFiltro (
	Estacion		int		NOT NULL,
	RID			int		NOT NULL 	IDENTITY(1,1),

	Campo			varchar(50)	NULL,		
	Condicion		varchar(20)	NULL,	--Igual, Diferente, Mayor, Menor
	Valor			varchar(100)	NULL,

	CONSTRAINT priVentaTFiltro PRIMARY KEY CLUSTERED (Estacion, RID)
  )
  EXEC spSincroSemilla 'VentaTFiltro'
END
go

-- drop table ProspectoFiltro
/****** ProspectoFiltro ******/
if not exists(select * from SysTabla where SysTabla = 'ProspectoFiltro')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProspectoFiltro','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.ProspectoFiltro') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ProspectoFiltro (
	Estacion		int		NOT NULL,
	RID			int		NOT NULL 	IDENTITY(1,1),

	Campo			varchar(50)	NULL,		
	Condicion		varchar(20)	NULL,	--Igual, Diferente, Mayor, Menor
	Valor			varchar(100)	NULL,

	CONSTRAINT priProspectoFiltro PRIMARY KEY CLUSTERED (Estacion, RID)
  )
  EXEC spSincroSemilla 'ProspectoFiltro'
END
go

-- select * from GuardarFiltro
/****** GuardarFiltro ******/
if not exists(select * from SysTabla where SysTabla = 'GuardarFiltro')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GuardarFiltro','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.GuardarFiltro') and type = 'U') 
BEGIN
  CREATE TABLE dbo.GuardarFiltro (
	Vista			varchar(100)	NOT NULL,
	Nombre			varchar(100)	NOT NULL,
	RID			int		NOT NULL 	IDENTITY(1,1),

	Campo			varchar(50)	NULL,		
	Condicion		varchar(20)	NULL,	--Igual, Diferente, Mayor, Menor
	Valor			varchar(100)	NULL,

	CONSTRAINT priGuardarFiltro PRIMARY KEY CLUSTERED (Nombre, Vista, RID)
  )
  EXEC spSincroSemilla 'GuardarFiltro'
END
go

if not exists (select * from sysobjects where id = object_id('dbo.VentaLotes') and type = 'U')  -- drop table VentaLotes
  CREATE TABLE dbo.VentaLotes(
	Estacion		varchar(20),
	Articulo		varchar(20)		NOT NULL,
	Mov				varchar(20)		NOT NULL,
	Almacen			varchar(10)		NOT NULL,
	Categoria		varchar(20)		NULL,
	Familia			varchar (50)	NULL,
	Grupo			varchar (50)	NULL,
	Concepto		varchar (50)	NULL,
	CicloEsc		varchar(10)		NULL,--se guardará en el campo FechaOrdenCompra de la Tabla Venta
	Condicion		varchar(50)		NULL,--se hará referencia a Condicion de la Tabla Venta
	FechaEmision	datetime		NOT NULL,
	ContUso			varchar(20)		NULL,
	CopiarEnTiempo	bit Default 1	NULL,
	AplicaDesc		bit Default 1	NULL,
	FechaD			datetime		NULL,
	FechaA			datetime		NULL,
	Unidad			varchar(20)		NULL
	CONSTRAINT priVentaLotes PRIMARY KEY CLUSTERED (Estacion)
  )
GO 
if not exists (select * from sysobjects where id = object_id('dbo.VentaLotesAux') and type = 'U')  -- drop table VentaLotesAux
  CREATE TABLE dbo.VentaLotesAux(
	Estacion		varchar(20),
	Cliente			varchar(10) NULL,
	Sucursal		int,
	NombreSucCte	varchar(100),
	Articulo		varchar(20),
	Mov				varchar(20),
	Almacen			varchar(10),
	Categoria		varchar(20),
	Familia			varchar (50),
	Grupo			varchar (50),
	Concepto		varchar (50) NULL,
	CicloEsc		varchar(10),--se guardará en el campo FechaOrdenCompra de la Tabla Venta
	Condicion		varchar(50),--se hará referencia a Condicion de la Tabla Venta
	FechaEmision	datetime,
	ContUso			varchar(20),
	CopiarEnTiempo	bit Default 1 NULL,
	AplicaDesc		bit Default 1 NULL,
	FechaD			datetime NULL,
	FechaA			datetime NULL,
	Unidad			varchar(20) NULL	
	--CONSTRAINT priVentaLotesAux PRIMARY KEY CLUSTERED (Estacion,Articulo,Mov,Almacen)
  )
GO

if not exists (select * from sysobjects where id = object_id('dbo.AgenteObjetivos') and type = 'U') 
CREATE TABLE AgenteObjetivos(
 Agente   varchar(10),
 ArtCat   varchar(50),
 Moneda   varchar(10),
 Importe  money,
 
 CONSTRAINT priAgenteObjetivos PRIMARY KEY(Agente,ArtCat, Moneda))
GO

/**************** VentaDevolucion ****************/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.VentaDevolucion') and type = 'U') 
CREATE TABLE VentaDevolucion
    (
		RID				int			NOT NULL,
		Renglon			float		NOT NULL,
		RenglonRID		float		NULL,
		RenglonID		int			NULL,
		Articulo		varchar(20)	NULL,
		Cantidad		float		NULL,
		ID				int			NULL,
		CantidadA		float		NULL,
		Estatus			bit			NULL,	
		CONSTRAINT priVentaDevolucion PRIMARY KEY (RID, Renglon)
	)
GO

if exists(select * from SysTabla where SysTabla = 'VentaDevolucion')
BEGIN
	ALTER TABLE VentaDevolucion  DROP CONSTRAINT priVentaDevolucion
END
GO

/**************** spVentaTFiltroGuardar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaTFiltroGuardar') and type = 'P') drop procedure dbo.spVentaTFiltroGuardar
GO
CREATE PROCEDURE spVentaTFiltroGuardar
			@Estacion	int,
			@Vista		varchar(100),
			@Nombre		varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DELETE GuardarFiltro WHERE Vista = @Vista AND Nombre = @Nombre
  INSERT GuardarFiltro (Vista, Nombre, Campo, Condicion, Valor)
  SELECT @Vista, @Nombre, Campo, Condicion, Valor
    FROM VentaTFiltro
   WHERE Estacion = @Estacion
END
GO


/**************** spVentaTFiltroAbrir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaTFiltroAbrir') and type = 'P') drop procedure dbo.spVentaTFiltroAbrir
GO
CREATE PROCEDURE spVentaTFiltroAbrir
			@Estacion	int,
			@Vista		varchar(100),
			@Nombre		varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DELETE VentaTFiltro WHERE Estacion = @Estacion
  INSERT VentaTFiltro (Estacion, Campo, Condicion, Valor)
  SELECT @Estacion, Campo, Condicion, Valor
    FROM GuardarFiltro
   WHERE Vista = @Vista AND Nombre = @Nombre
END
GO

/**************** spProspectoFiltroGuardar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProspectoFiltroGuardar') and type = 'P') drop procedure dbo.spProspectoFiltroGuardar
GO
CREATE PROCEDURE spProspectoFiltroGuardar
			@Estacion	int,
			@Vista		varchar(100),
			@Nombre		varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DELETE GuardarFiltro WHERE Vista = @Vista AND Nombre = @Nombre
  INSERT GuardarFiltro (Vista, Nombre, Campo, Condicion, Valor)
  SELECT @Vista, @Nombre, Campo, Condicion, Valor
    FROM ProspectoFiltro
   WHERE Estacion = @Estacion
END
GO

/**************** spProspectoFiltroAbrir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProspectoFiltroAbrir') and type = 'P') drop procedure dbo.spProspectoFiltroAbrir
GO
CREATE PROCEDURE spProspectoFiltroAbrir
			@Estacion	int,
			@Vista		varchar(100),
			@Nombre		varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DELETE ProspectoFiltro WHERE Estacion = @Estacion
  INSERT ProspectoFiltro (Estacion, Campo, Condicion, Valor)
  SELECT @Estacion, Campo, Condicion, Valor
    FROM GuardarFiltro
   WHERE Vista = @Vista AND Nombre = @Nombre
END
GO

/**************** spMoverNota ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMoverNota') and type = 'P') drop procedure dbo.spMoverNota
GO
CREATE PROCEDURE spMoverNota
			@ID		int,
			@Accion		varchar(20) = 'MOVER'
--//WITH ENCRYPTION
AS BEGIN
  IF @Accion = 'MOVER'
  BEGIN
    IF EXISTS(SELECT * FROM Venta WHERE ID = @ID) AND 
       NOT EXISTS(SELECT * FROM Nota WHERE ID = @ID)
    BEGIN
      INSERT NotaCobroD (
             ID,RenglonID,Importe,Moneda,TipoCambio,FormaCobro,Referencia,Sucursal,SucursalOrigen)
      SELECT ID,RenglonID,Importe,Moneda,TipoCambio,FormaCobro,Referencia,Sucursal,SucursalOrigen
        FROM VentaCobroD
       WHERE ID = @ID

      INSERT NotaCobro (
             ID,Importe1,Importe2,Importe3,Importe4,Importe5,FormaCobro1,FormaCobro2,FormaCobro3,FormaCobro4,FormaCobro5,Referencia1,Referencia2,Referencia3,Referencia4,Referencia5,Observaciones1,Observaciones2,Observaciones3,Observaciones4,Observaciones5,Cambio,Redondeo,DelEfectivo,Sucursal,CtaDinero,Cajero,Condicion,Vencimiento,Actualizado,SucursalOrigen)
      SELECT ID,Importe1,Importe2,Importe3,Importe4,Importe5,FormaCobro1,FormaCobro2,FormaCobro3,FormaCobro4,FormaCobro5,Referencia1,Referencia2,Referencia3,Referencia4,Referencia5,Observaciones1,Observaciones2,Observaciones3,Observaciones4,Observaciones5,Cambio,Redondeo,DelEfectivo,Sucursal,CtaDinero,Cajero,Condicion,Vencimiento,Actualizado,SucursalOrigen
        FROM VentaCobro
       WHERE ID = @ID

      INSERT NotaDAgente (
             ID,Renglon,RenglonSub,RID,Agente,Fecha,HoraD,HoraA,Minutos,Actividad,Estado,Comentarios,CantidadEstandar,FechaConclusion,CostoActividad,Avance,Sucursal,SucursalOrigen)
      SELECT ID,Renglon,RenglonSub,RID,Agente,Fecha,HoraD,HoraA,Minutos,Actividad,Estado,Comentarios,CantidadEstandar,FechaConclusion,CostoActividad,Avance,Sucursal,SucursalOrigen
        FROM VentaDAgente
       WHERE ID = @ID

      INSERT NotaD (
             ID,Renglon,RenglonSub,RenglonID,RenglonTipo,Cantidad,Almacen,EnviarA,Codigo,Articulo,SubCuenta,Precio,PrecioSugerido,DescuentoTipo,DescuentoLinea,DescuentoImporte,Impuesto1,Impuesto2,Impuesto3,DescripcionExtra,Costo,CostoActividad,Paquete,ContUso,Comision,Aplica,AplicaID,CantidadPendiente,CantidadReservada,CantidadCancelada,CantidadOrdenada,CantidadEmbarcada,CantidadA,Unidad,Factor,CantidadInventario,SustitutoArticulo,SustitutoSubCuenta,FechaRequerida,HoraRequerida,Instruccion,Agente,Departamento,UltimoReservadoCantidad,UltimoReservadoFecha,Sucursal,PoliticaPrecios,SucursalOrigen,AutoLocalidad,UEN,Espacio,CantidadAlterna,PrecioMoneda,PrecioTipoCambio,Estado,ServicioNumero,AgentesAsignados,AFArticulo,AFSerie,ExcluirPlaneacion,Anexo,AjusteCosteo,CostoUEPS,CostoPEPS,UltimoCosto,PrecioLista,DepartamentoDetallista,PresupuestoEsp,Posicion,Puntos,CantidadObsequio,OfertaID,ProveedorRef,TransferirA,ArtEstatus,ArtSituacion,Tarima,ContUso2,ContUso3,CostoEstandar,ABC,TipoImpuesto1,TipoImpuesto2,TipoImpuesto3)
      SELECT ID,Renglon,RenglonSub,RenglonID,RenglonTipo,Cantidad,Almacen,EnviarA,Codigo,Articulo,SubCuenta,Precio,PrecioSugerido,DescuentoTipo,DescuentoLinea,DescuentoImporte,Impuesto1,Impuesto2,Impuesto3,DescripcionExtra,Costo,CostoActividad,Paquete,ContUso,Comision,Aplica,AplicaID,CantidadPendiente,CantidadReservada,CantidadCancelada,CantidadOrdenada,CantidadEmbarcada,CantidadA,Unidad,Factor,CantidadInventario,SustitutoArticulo,SustitutoSubCuenta,FechaRequerida,HoraRequerida,Instruccion,Agente,Departamento,UltimoReservadoCantidad,UltimoReservadoFecha,Sucursal,PoliticaPrecios,SucursalOrigen,AutoLocalidad,UEN,Espacio,CantidadAlterna,PrecioMoneda,PrecioTipoCambio,Estado,ServicioNumero,AgentesAsignados,AFArticulo,AFSerie,ExcluirPlaneacion,Anexo,AjusteCosteo,CostoUEPS,CostoPEPS,UltimoCosto,PrecioLista,DepartamentoDetallista,PresupuestoEsp,Posicion,Puntos,CantidadObsequio,OfertaID,ProveedorRef,TransferirA,ArtEstatus,ArtSituacion,Tarima,ContUso2,ContUso3,CostoEstandar,ABC,TipoImpuesto1,TipoImpuesto2,TipoImpuesto3
        FROM VentaD
       WHERE ID = @ID

      INSERT Nota (
	ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,UEN,Moneda,TipoCambio,Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,SituacionFecha,SituacionUsuario,SituacionNota,Directo,Prioridad,RenglonID,FechaOriginal,
	Codigo,Cliente,EnviarA,Almacen,AlmacenDestino,Agente,AgenteServicio,AgenteComision,FormaEnvio,FechaRequerida,HoraRequerida,FechaProgramadaEnvio,
	FechaOrdenCompra,ReferenciaOrdenCompra,OrdenCompra,Condicion,Vencimiento,CtaDinero,Descuento,DescuentoGlobal,Importe,Impuestos,Saldo,AnticiposFacturados,AnticiposImpuestos,Retencion,DescuentoLineal,ComisionTotal,CostoTotal,PrecioTotal,Paquetes,
	ServicioTipo,ServicioArticulo,ServicioSerie,ServicioContrato,ServicioContratoID,ServicioContratoTipo,ServicioGarantia,ServicioDescripcion,ServicioFecha,ServicioFlotilla,ServicioRampa,ServicioIdentificador,ServicioPlacas,ServicioKms,ServicioTipoOrden,
	ServicioTipoOperacion,ServicioSiniestro,ServicioExpress,ServicioDemerito,ServicioDeducible,ServicioDeducibleImporte,ServicioNumero,ServicioNumeroEconomico,ServicioAseguradora,ServicioPuntual,ServicioPoliza,
	OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,ContID,Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion,FechaEntrega,EmbarqueEstado,EmbarqueGastos,Peso,Volumen,Causa,Atencion,AtencionTelefono,ListaPreciosEsp,ZonaImpuesto,
	Extra,CancelacionID,Mensaje,Departamento,Sucursal,GenerarOP,DesglosarImpuestos,DesglosarImpuesto2,ExcluirPlaneacion,ConVigencia,VigenciaDesde,VigenciaHasta,Enganche,Bonificacion,IVAFiscal,IEPSFiscal,EstaImpreso,Periodicidad,SubModulo,ContUso,
	Espacio,AutoCorrida,AutoCorridaHora,AutoCorridaServicio,AutoCorridaRol,AutoCorridaOrigen,AutoCorridaDestino,AutoCorridaKms,AutoCorridaLts,AutoCorridaRuta,AutoOperador2,AutoBoleto,AutoKms,AutoKmsActuales,AutoBomba,AutoBombaContador,
	DifCredito,EspacioResultado,Clase,Subclase,GastoAcreedor,GastoConcepto,Comentarios,Pagado,GenerarDinero,Dinero,DineroID,DineroCtaDinero,DineroConciliado,DineroFechaConciliacion,Extra1,Extra2,Extra3,Reabastecido,SucursalVenta,AF,AFArticulo,AFSerie,
	ContratoTipo,ContratoDescripcion,ContratoSerie,ContratoValor,ContratoValorMoneda,ContratoSeguro,ContratoVencimiento,ContratoResponsable,Incentivo,IncentivoConcepto,EndosarA,InteresTasa,InteresIVA,AnexoID,FordVisitoOASIS,LineaCredito,TipoAmortizacion,TipoTasa,
	Comisiones,ComisionesIVA,CompraID,OperacionRelevante,TieneTasaEsp,TasaEsp,FormaPagoTipo,SobrePrecio,ContUso2,ContUso3,Actividad,ContratoID,ContratoMov,ContratoMovID
	)
      SELECT
	ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,UEN,Moneda,TipoCambio,Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,SituacionFecha,SituacionUsuario,SituacionNota,Directo,Prioridad,RenglonID,FechaOriginal,
	Codigo,Cliente,EnviarA,Almacen,AlmacenDestino,Agente,AgenteServicio,AgenteComision,FormaEnvio,FechaRequerida,HoraRequerida,FechaProgramadaEnvio,
	FechaOrdenCompra,ReferenciaOrdenCompra,OrdenCompra,Condicion,Vencimiento,CtaDinero,Descuento,DescuentoGlobal,Importe,Impuestos,Saldo,AnticiposFacturados,AnticiposImpuestos,Retencion,DescuentoLineal,ComisionTotal,CostoTotal,PrecioTotal,Paquetes,
	ServicioTipo,ServicioArticulo,ServicioSerie,ServicioContrato,ServicioContratoID,ServicioContratoTipo,ServicioGarantia,ServicioDescripcion,ServicioFecha,ServicioFlotilla,ServicioRampa,ServicioIdentificador,ServicioPlacas,ServicioKms,ServicioTipoOrden,
	ServicioTipoOperacion,ServicioSiniestro,ServicioExpress,ServicioDemerito,ServicioDeducible,ServicioDeducibleImporte,ServicioNumero,ServicioNumeroEconomico,ServicioAseguradora,ServicioPuntual,ServicioPoliza,
	OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,ContID,Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion,FechaEntrega,EmbarqueEstado,EmbarqueGastos,Peso,Volumen,Causa,Atencion,AtencionTelefono,ListaPreciosEsp,ZonaImpuesto,
	Extra,CancelacionID,Mensaje,Departamento,Sucursal,GenerarOP,DesglosarImpuestos,DesglosarImpuesto2,ExcluirPlaneacion,ConVigencia,VigenciaDesde,VigenciaHasta,Enganche,Bonificacion,IVAFiscal,IEPSFiscal,EstaImpreso,Periodicidad,SubModulo,ContUso,
	Espacio,AutoCorrida,AutoCorridaHora,AutoCorridaServicio,AutoCorridaRol,AutoCorridaOrigen,AutoCorridaDestino,AutoCorridaKms,AutoCorridaLts,AutoCorridaRuta,AutoOperador2,AutoBoleto,AutoKms,AutoKmsActuales,AutoBomba,AutoBombaContador,
	DifCredito,EspacioResultado,Clase,Subclase,GastoAcreedor,GastoConcepto,Comentarios,Pagado,GenerarDinero,Dinero,DineroID,DineroCtaDinero,DineroConciliado,DineroFechaConciliacion,Extra1,Extra2,Extra3,Reabastecido,SucursalVenta,AF,AFArticulo,AFSerie,
	ContratoTipo,ContratoDescripcion,ContratoSerie,ContratoValor,ContratoValorMoneda,ContratoSeguro,ContratoVencimiento,ContratoResponsable,Incentivo,IncentivoConcepto,EndosarA,InteresTasa,InteresIVA,AnexoID,FordVisitoOASIS,LineaCredito,TipoAmortizacion,TipoTasa,
	Comisiones,ComisionesIVA,CompraID,OperacionRelevante,TieneTasaEsp,TasaEsp,FormaPagoTipo,SobrePrecio,ContUso2,ContUso3,Actividad,ContratoID,ContratoMov,ContratoMovID
       FROM Venta
      WHERE ID = @ID

      DELETE VentaCobroD  WHERE ID = @ID
      DELETE VentaCobro   WHERE ID = @ID
      DELETE VentaDAgente WHERE ID = @ID
      DELETE VentaD	  WHERE ID = @ID
      DELETE Venta        WHERE ID = @ID
    END
  END ELSE
  IF @Accion = 'REGRESAR'
  BEGIN
    IF EXISTS(SELECT * FROM Nota WHERE ID = @ID) AND 
       NOT EXISTS(SELECT * FROM Venta WHERE ID = @ID)
    BEGIN
      SET IDENTITY_INSERT Venta ON;
      INSERT Venta (
	ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,UEN,Moneda,TipoCambio,Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,SituacionFecha,SituacionUsuario,SituacionNota,Directo,Prioridad,RenglonID,FechaOriginal,
	Codigo,Cliente,EnviarA,Almacen,AlmacenDestino,Agente,AgenteServicio,AgenteComision,FormaEnvio,FechaRequerida,HoraRequerida,FechaProgramadaEnvio,
	FechaOrdenCompra,ReferenciaOrdenCompra,OrdenCompra,Condicion,Vencimiento,CtaDinero,Descuento,DescuentoGlobal,Importe,Impuestos,Saldo,AnticiposFacturados,AnticiposImpuestos,Retencion,DescuentoLineal,ComisionTotal,CostoTotal,PrecioTotal,Paquetes,
	ServicioTipo,ServicioArticulo,ServicioSerie,ServicioContrato,ServicioContratoID,ServicioContratoTipo,ServicioGarantia,ServicioDescripcion,ServicioFecha,ServicioFlotilla,ServicioRampa,ServicioIdentificador,ServicioPlacas,ServicioKms,ServicioTipoOrden,
	ServicioTipoOperacion,ServicioSiniestro,ServicioExpress,ServicioDemerito,ServicioDeducible,ServicioDeducibleImporte,ServicioNumero,ServicioNumeroEconomico,ServicioAseguradora,ServicioPuntual,ServicioPoliza,
	OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,ContID,Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion,FechaEntrega,EmbarqueEstado,EmbarqueGastos,Peso,Volumen,Causa,Atencion,AtencionTelefono,ListaPreciosEsp,ZonaImpuesto,
	Extra,CancelacionID,Mensaje,Departamento,Sucursal,GenerarOP,DesglosarImpuestos,DesglosarImpuesto2,ExcluirPlaneacion,ConVigencia,VigenciaDesde,VigenciaHasta,Enganche,Bonificacion,IVAFiscal,IEPSFiscal,EstaImpreso,Periodicidad,SubModulo,ContUso,
	Espacio,AutoCorrida,AutoCorridaHora,AutoCorridaServicio,AutoCorridaRol,AutoCorridaOrigen,AutoCorridaDestino,AutoCorridaKms,AutoCorridaLts,AutoCorridaRuta,AutoOperador2,AutoBoleto,AutoKms,AutoKmsActuales,AutoBomba,AutoBombaContador,
	DifCredito,EspacioResultado,Clase,Subclase,GastoAcreedor,GastoConcepto,Comentarios,Pagado,GenerarDinero,Dinero,DineroID,DineroCtaDinero,DineroConciliado,DineroFechaConciliacion,Extra1,Extra2,Extra3,Reabastecido,SucursalVenta,AF,AFArticulo,AFSerie,
	ContratoTipo,ContratoDescripcion,ContratoSerie,ContratoValor,ContratoValorMoneda,ContratoSeguro,ContratoVencimiento,ContratoResponsable,Incentivo,IncentivoConcepto,EndosarA,InteresTasa,InteresIVA,AnexoID,FordVisitoOASIS,LineaCredito,TipoAmortizacion,TipoTasa,
	Comisiones,ComisionesIVA,CompraID,OperacionRelevante,TieneTasaEsp,TasaEsp,FormaPagoTipo,SobrePrecio,ContUso2,ContUso3,Actividad,ContratoID,ContratoMov,ContratoMovID
	)
      SELECT
	ID,Empresa,Mov,MovID,FechaEmision,UltimoCambio,Concepto,Proyecto,UEN,Moneda,TipoCambio,Usuario,Autorizacion,Referencia,DocFuente,Observaciones,Estatus,Situacion,SituacionFecha,SituacionUsuario,SituacionNota,Directo,Prioridad,RenglonID,FechaOriginal,
	Codigo,Cliente,EnviarA,Almacen,AlmacenDestino,Agente,AgenteServicio,AgenteComision,FormaEnvio,FechaRequerida,HoraRequerida,FechaProgramadaEnvio,
	FechaOrdenCompra,ReferenciaOrdenCompra,OrdenCompra,Condicion,Vencimiento,CtaDinero,Descuento,DescuentoGlobal,Importe,Impuestos,Saldo,AnticiposFacturados,AnticiposImpuestos,Retencion,DescuentoLineal,ComisionTotal,CostoTotal,PrecioTotal,Paquetes,
	ServicioTipo,ServicioArticulo,ServicioSerie,ServicioContrato,ServicioContratoID,ServicioContratoTipo,ServicioGarantia,ServicioDescripcion,ServicioFecha,ServicioFlotilla,ServicioRampa,ServicioIdentificador,ServicioPlacas,ServicioKms,ServicioTipoOrden,
	ServicioTipoOperacion,ServicioSiniestro,ServicioExpress,ServicioDemerito,ServicioDeducible,ServicioDeducibleImporte,ServicioNumero,ServicioNumeroEconomico,ServicioAseguradora,ServicioPuntual,ServicioPoliza,
	OrigenTipo,Origen,OrigenID,Poliza,PolizaID,GenerarPoliza,ContID,Ejercicio,Periodo,FechaRegistro,FechaConclusion,FechaCancelacion,FechaEntrega,EmbarqueEstado,EmbarqueGastos,Peso,Volumen,Causa,Atencion,AtencionTelefono,ListaPreciosEsp,ZonaImpuesto,
	Extra,CancelacionID,Mensaje,Departamento,Sucursal,GenerarOP,DesglosarImpuestos,DesglosarImpuesto2,ExcluirPlaneacion,ConVigencia,VigenciaDesde,VigenciaHasta,Enganche,Bonificacion,IVAFiscal,IEPSFiscal,EstaImpreso,Periodicidad,SubModulo,ContUso,
	Espacio,AutoCorrida,AutoCorridaHora,AutoCorridaServicio,AutoCorridaRol,AutoCorridaOrigen,AutoCorridaDestino,AutoCorridaKms,AutoCorridaLts,AutoCorridaRuta,AutoOperador2,AutoBoleto,AutoKms,AutoKmsActuales,AutoBomba,AutoBombaContador,
	DifCredito,EspacioResultado,Clase,Subclase,GastoAcreedor,GastoConcepto,Comentarios,Pagado,GenerarDinero,Dinero,DineroID,DineroCtaDinero,DineroConciliado,DineroFechaConciliacion,Extra1,Extra2,Extra3,Reabastecido,SucursalVenta,AF,AFArticulo,AFSerie,
	ContratoTipo,ContratoDescripcion,ContratoSerie,ContratoValor,ContratoValorMoneda,ContratoSeguro,ContratoVencimiento,ContratoResponsable,Incentivo,IncentivoConcepto,EndosarA,InteresTasa,InteresIVA,AnexoID,FordVisitoOASIS,LineaCredito,TipoAmortizacion,TipoTasa,
	Comisiones,ComisionesIVA,CompraID,OperacionRelevante,TieneTasaEsp,TasaEsp,FormaPagoTipo,SobrePrecio,ContUso2,ContUso3,Actividad,ContratoID,ContratoMov,ContratoMovID
       FROM Nota
      WHERE ID = @ID
      SET IDENTITY_INSERT Venta OFF;

      INSERT VentaD (
             ID,Renglon,RenglonSub,RenglonID,RenglonTipo,Cantidad,Almacen,EnviarA,Codigo,Articulo,SubCuenta,Precio,PrecioSugerido,DescuentoTipo,DescuentoLinea,DescuentoImporte,Impuesto1,Impuesto2,Impuesto3,DescripcionExtra,Costo,CostoActividad,Paquete,ContUso,Comision,Aplica,AplicaID,CantidadPendiente,CantidadReservada,CantidadCancelada,CantidadOrdenada,CantidadEmbarcada,CantidadA,Unidad,Factor,CantidadInventario,SustitutoArticulo,SustitutoSubCuenta,FechaRequerida,HoraRequerida,Instruccion,Agente,Departamento,UltimoReservadoCantidad,UltimoReservadoFecha,Sucursal,PoliticaPrecios,SucursalOrigen,AutoLocalidad,UEN,Espacio,CantidadAlterna,PrecioMoneda,PrecioTipoCambio,Estado,ServicioNumero,AgentesAsignados,AFArticulo,AFSerie,ExcluirPlaneacion,Anexo,AjusteCosteo,CostoUEPS,CostoPEPS,UltimoCosto,PrecioLista,DepartamentoDetallista,PresupuestoEsp,Posicion,Puntos,CantidadObsequio,OfertaID,ProveedorRef,TransferirA,ArtEstatus,ArtSituacion,Tarima,ContUso2,ContUso3,CostoEstandar,ABC,TipoImpuesto1,TipoImpuesto2,TipoImpuesto3)
      SELECT ID,Renglon,RenglonSub,RenglonID,RenglonTipo,Cantidad,Almacen,EnviarA,Codigo,Articulo,SubCuenta,Precio,PrecioSugerido,DescuentoTipo,DescuentoLinea,DescuentoImporte,Impuesto1,Impuesto2,Impuesto3,DescripcionExtra,Costo,CostoActividad,Paquete,ContUso,Comision,Aplica,AplicaID,CantidadPendiente,CantidadReservada,CantidadCancelada,CantidadOrdenada,CantidadEmbarcada,CantidadA,Unidad,Factor,CantidadInventario,SustitutoArticulo,SustitutoSubCuenta,FechaRequerida,HoraRequerida,Instruccion,Agente,Departamento,UltimoReservadoCantidad,UltimoReservadoFecha,Sucursal,PoliticaPrecios,SucursalOrigen,AutoLocalidad,UEN,Espacio,CantidadAlterna,PrecioMoneda,PrecioTipoCambio,Estado,ServicioNumero,AgentesAsignados,AFArticulo,AFSerie,ExcluirPlaneacion,Anexo,AjusteCosteo,CostoUEPS,CostoPEPS,UltimoCosto,PrecioLista,DepartamentoDetallista,PresupuestoEsp,Posicion,Puntos,CantidadObsequio,OfertaID,ProveedorRef,TransferirA,ArtEstatus,ArtSituacion,Tarima,ContUso2,ContUso3,CostoEstandar,ABC,TipoImpuesto1,TipoImpuesto2,TipoImpuesto3
        FROM NotaD
       WHERE ID = @ID

      SET IDENTITY_INSERT VentaDAgente ON;
      INSERT VentaDAgente (
             ID,Renglon,RenglonSub,RID,Agente,Fecha,HoraD,HoraA,Minutos,Actividad,Estado,Comentarios,CantidadEstandar,FechaConclusion,CostoActividad,Avance,Sucursal,SucursalOrigen)
      SELECT ID,Renglon,RenglonSub,RID,Agente,Fecha,HoraD,HoraA,Minutos,Actividad,Estado,Comentarios,CantidadEstandar,FechaConclusion,CostoActividad,Avance,Sucursal,SucursalOrigen
        FROM NotaDAgente
       WHERE ID = @ID
      SET IDENTITY_INSERT VentaDAgente OFF;

      INSERT VentaCobro (
             ID,Importe1,Importe2,Importe3,Importe4,Importe5,FormaCobro1,FormaCobro2,FormaCobro3,FormaCobro4,FormaCobro5,Referencia1,Referencia2,Referencia3,Referencia4,Referencia5,Observaciones1,Observaciones2,Observaciones3,Observaciones4,Observaciones5,Cambio,Redondeo,DelEfectivo,Sucursal,CtaDinero,Cajero,Condicion,Vencimiento,Actualizado,SucursalOrigen)
      SELECT ID,Importe1,Importe2,Importe3,Importe4,Importe5,FormaCobro1,FormaCobro2,FormaCobro3,FormaCobro4,FormaCobro5,Referencia1,Referencia2,Referencia3,Referencia4,Referencia5,Observaciones1,Observaciones2,Observaciones3,Observaciones4,Observaciones5,Cambio,Redondeo,DelEfectivo,Sucursal,CtaDinero,Cajero,Condicion,Vencimiento,Actualizado,SucursalOrigen
        FROM NotaCobro
       WHERE ID = @ID

      SET IDENTITY_INSERT VentaCobroD ON;
      INSERT VentaCobroD (
             ID,RenglonID,Importe,Moneda,TipoCambio,FormaCobro,Referencia,Sucursal,SucursalOrigen)
      SELECT ID,RenglonID,Importe,Moneda,TipoCambio,FormaCobro,Referencia,Sucursal,SucursalOrigen
        FROM NotaCobroD
       WHERE ID = @ID
      SET IDENTITY_INSERT VentaCobroD OFF;

      DELETE NotaCobroD  WHERE ID = @ID
      DELETE NotaCobro   WHERE ID = @ID
      DELETE NotaDAgente WHERE ID = @ID
      DELETE NotaD	 WHERE ID = @ID
      DELETE Nota        WHERE ID = @ID
    END
  END 
  RETURN
END
GO

/**************** spMoverNotasAnteriores ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMoverNotasAnteriores') and type = 'P') drop procedure dbo.spMoverNotasAnteriores
GO
CREATE PROCEDURE spMoverNotasAnteriores
			@Empresa	varchar(5),
			@Tope		int		= 1000
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int,
    @Conteo	int,
    @Ok		int,
    @OkRef	varchar(255),
    @Mensaje	varchar(255)

  SELECT @Conteo = 0, @Ok = NULL, @OkRef = NULL
  DECLARE crMoverNotas CURSOR LOCAL FOR
   SELECT TOP (@Tope) e.ID
     FROM Venta e
     JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = e.Mov AND mt.Clave IN ('VTAS.N', 'VTAS.NO', 'VTAS.NR')
    WHERE e.Empresa = @Empresa AND e.Estatus IN ('CONCLUIDO', 'CANCELADO')
    ORDER BY e.ID
  OPEN crMoverNotas
  FETCH NEXT FROM crMoverNotas INTO @ID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      BEGIN TRY
        BEGIN TRANSACTION 
        EXEC spMoverNota @ID
        COMMIT TRANSACTION 
        SELECT @Conteo = @Conteo + 1
      END TRY
      BEGIN CATCH
        SELECT @Ok = ERROR_NUMBER(), @OkRef = ERROR_MESSAGE()
        ROLLBACK TRANSACTION
        BREAK
      END CATCH
    END
    FETCH NEXT FROM crMoverNotas INTO @ID
  END
  CLOSE crMoverNotas
  DEALLOCATE crMoverNotas
  SELECT @Mensaje = CONVERT(varchar, @Conteo)+' Notas Movidas, '
  IF @Ok IS NULL 
    SELECT @Mensaje = @Mensaje + 'sin Errores.'
  ELSE
    SELECT @Mensaje = @Mensaje + 'Error '+ISNULL(@OkRef, CONVERT(varchar, @Ok))+'.'
  SELECT 'Mensaje' = @Mensaje
END
GO
/**************** spVentaCondicion ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spVentaCondicion') AND TYPE = 'P') DROP PROCEDURE dbo.spVentaCondicion
GO  
CREATE PROCEDURE spVentaCondicion        
@ID			AS INT
--//WITH ENCRYPTION        
AS        
BEGIN        

SELECT ISNULL(NULLIF(c.TipoCondicion, ''),'Contado') 
  FROM Venta v
  LEFT OUTER JOIN Condicion c ON c.Condicion=v.Condicion
 WHERE v.ID=@ID

END
GO

/**************** spVentaImpuesto ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spVentaImpuesto') AND TYPE = 'P') DROP PROCEDURE dbo.spVentaImpuesto
GO  

CREATE PROCEDURE spVentaImpuesto        
@ID			AS INT,
@RID		AS INT
--//WITH ENCRYPTION   
AS        
BEGIN        
        
SELECT a.Impuesto1 
  FROM Venta v
  JOIN VentaD vd ON vd.ID=v.ID
  JOIN Art a ON a.Articulo=vd.Articulo
WHERE v.ID=@ID AND VD.Renglon=@RID
            
END
GO

/**************** spVentaExento ****************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spVentaExento') AND TYPE = 'P') DROP PROCEDURE dbo.spVentaExento
GO  

CREATE PROCEDURE spVentaExento        
@ID			AS INT,
@RID		AS INT
--//WITH ENCRYPTION       
AS        
BEGIN       
        
SELECT a.Impuesto1Excento
  FROM Venta v
  JOIN VentaD vd ON vd.ID=v.ID
  JOIN Art a ON a.Articulo=vd.Articulo
WHERE v.ID=@ID AND VD.Renglon=@RID
            
END
GO