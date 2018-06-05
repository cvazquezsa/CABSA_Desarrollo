/***************************************************************************/
/***************** TABLAS CONFIGURACION DEL MODULO CENTRAL *****************/ 
/***************************************************************************/

-- drop table mcCampo
EXEC spDROP_TABLE 'mcCfgCampo', 3030
EXEC spDROP_TABLE 'mcMayor', 3035
EXEC spDROP_TABLE 'mcMayorDimension', 3080
EXEC spDROP_TABLE 'mcMayorMedida', 3030
EXEC spDROP_TABLE 'mcModulo', 3030
EXEC spDROP_TABLE 'mcModuloMov', 3030
EXEC spDROP_TABLE 'mcModuloCampo', 3030
EXEC spDROP_TABLE 'mcModuloCampoProp', 3030
EXEC spDROP_TABLE 'mcModuloMovPoliza', 3037
EXEC spDROP_TABLE 'CargaProp', 3030
EXEC spDROP_TABLE 'CargaReg', 3030
EXEC spDROP_TABLE 'mcCargaReg', 3037
EXEC spDROP_TABLE 'mcCache', 3037
EXEC spDROP_TABLE 'mcColaSalida', 3037
EXEC spDROP_TABLE 'mcCarga', 3037
GO
/****************************** mcCampo ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcCampo') AND Type='U') 
  CREATE TABLE mcCampo (
	Tipo		varchar(20)	NOT NULL,	-- Dato / Medida / Propiedad
	Campo		varchar(50)	NOT NULL,

	TipoDatos	varchar(20)	NULL,	-- int, float, varchar(20), etc..
	Orden		int		NULL,

	CONSTRAINT pk_mcCampo PRIMARY KEY CLUSTERED (Campo, Tipo)
)
GO

-- drop table mcBandera
/****************************** mcBandera ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcBandera') AND Type='U') 
  CREATE TABLE mcBandera (
	Campo		varchar(50)	NOT NULL,
	Bandera		tinyint		NOT NULL,
	
	Nombre		varchar(100)	NULL,

	CONSTRAINT pk_mcBandera PRIMARY KEY CLUSTERED (Campo, Bandera)
)
GO

-- drop table mcMayor
/****************************** mcMayor ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcMayor') AND Type='U') 
  CREATE TABLE mcMayor (
	Mayor		varchar(20)	NOT NULL,

	Nombre		varchar(100)	NULL,
        Rama		varchar(20)	NULL,
	EsAcreedora	bit		NULL	DEFAULT 0,	
	EsAcumulativa	bit		NULL	DEFAULT 0,

	CONSTRAINT pk_mcMayor PRIMARY KEY CLUSTERED (Mayor)
)
GO

-- drop table mcMayorDato
/****************************** mcMayorDato ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcMayorDato') AND Type='U') 
  CREATE TABLE mcMayorDato (
	Mayor			varchar(20)		NOT NULL,
	Dato			varchar(50)		NOT NULL,	

	DatoDestino		varchar(50)		NULL,
	DatoRequerido		bit			NULL	DEFAULT 0,
	AceptaCeros		bit			NULL	DEFAULT 0,

	CONSTRAINT pk_mcMayorDato PRIMARY KEY CLUSTERED (Mayor, Dato),
)
GO

-- drop table mcMayorMedida
/****************************** mcMayorMedida ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcMayorMedida') AND Type='U') 
  CREATE TABLE mcMayorMedida (
	Mayor			varchar(20)		NOT NULL,

	Medida			varchar(50)		NOT NULL,	

	CONSTRAINT pk_mcMayorMedida PRIMARY KEY CLUSTERED (Mayor, Medida),
)
GO

-- drop table mcModulo
/****************************** mcModulo ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcModulo') AND Type='U')
  CREATE TABLE mcModulo (
	Modulo		varchar(5)	NOT NULL,

	Ruta		varchar(255)	NULL,

	CONSTRAINT pk_mcModulo PRIMARY KEY CLUSTERED (Modulo)
)
GO

-- drop table mcModuloMov
/****************************** mcModuloMov ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcModuloMov') AND Type='U')
CREATE TABLE mcModuloMov (
	Modulo		varchar(5)		NOT NULL,
	Mov		varchar(20)		NOT NULL,

	CONSTRAINT pk_mcModuloMov PRIMARY KEY CLUSTERED (Modulo, Mov),
)
GO

-- drop table mcModuloCampo
/****************************** mcModuloCampo ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcModuloCampo') AND Type='U')
CREATE TABLE mcModuloCampo (
	Modulo			varchar(5)	NOT NULL,
	Campo			varchar(50)	NOT NULL,

	Nodo			varchar(255)	NULL,
	RegistrarPropiedades	bit		NULL	DEFAULT 0,

	CONSTRAINT pk_mcModuloCampo PRIMARY KEY CLUSTERED (Modulo, Campo),
)
GO
EXEC spRENAME_COLUMN 'mcModuloCampo', 'RegistrarNombres', 'RegistrarPropiedades'
EXEC spRENAME_COLUMN 'mcModuloCampo', 'RegistrarCatalogo', 'RegistrarPropiedades'
GO
EXEC spALTER_TABLE 'mcModuloCampo', 'RegistrarPropiedades', 'bit NULL DEFAULT 0 WITH VALUES'
GO
-- cta
-- drop table mcModuloCampoProp
/****************************** mcModuloCampoProp ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcModuloCampoProp') AND Type='U')
CREATE TABLE mcModuloCampoProp (
	Modulo			varchar(5)	NOT NULL,
	Campo			varchar(50)	NOT NULL,
	Propiedad		varchar(50)	NOT NULL,

	Nodo			varchar(255)	NULL,

	CONSTRAINT pk_mcModuloCampoProp PRIMARY KEY CLUSTERED (Modulo, Campo, Propiedad)
)
GO

-- drop table mcModuloMovPoliza
-- select * from mcModuloMovPoliza for xml auto
/****************************** mcModuloMovPoliza ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcModuloMovPoliza') AND Type='U')
CREATE TABLE mcModuloMovPoliza (
	Modulo			varchar(5)		NOT NULL,
	Mov			varchar(20)		NOT NULL,
	GID			uniqueidentifier	NOT NULL	DEFAULT NEWID(),

	Mayor			varchar(20)		NULL,
	AfectarDestino		bit			NULL		DEFAULT 0,
	Condicion		varchar(max)		NULL,

	Debe			varchar(255)		NULL,
	Haber			varchar(255)		NULL,
	Presupuesto		varchar(255)		NULL,
	PresupuestoNombre	varchar(100)		NULL,
	Existencia		varchar(255)		NULL,
	ExistenciaNombre	varchar(100)		NULL,
	porSurtir		varchar(255)		NULL,
	porSurtirNombre		varchar(100)		NULL,

	CONSTRAINT pk_mcModuloMovPoliza PRIMARY KEY CLUSTERED (Modulo, Mov, GID),
)
GO

EXEC spFK 'mcModuloMovPoliza','Mayor','mcMayor','Mayor'
GO

-- drop table mcCargaProp
/****************************** mcCargaProp ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcCargaProp') AND Type='U')
  CREATE TABLE mcCargaProp (
	Campo			varchar(50)	NOT NULL,
	Valor			varchar(50)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	Descripcion2		varchar(255)	NULL,
	Categoria		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Familia			varchar(50)	NULL,
	Linea			varchar(50)	NULL,
	Marca			varchar(50)	NULL,
	Rama			varchar(50)	NULL,

	Direccion 		varchar(100) 	NULL,
	Delegacion		varchar(100)  	NULL,
	Colonia 		varchar(100)  	NULL,
	Poblacion 		varchar(100)  	NULL,
	Estado 			varchar(30)  	NULL,
	Pais			varchar(30)     NULL,
	Zona			varchar(30)     NULL,
	CodigoPostal 		varchar(15)  	NULL,
	GLN			varchar(50)     NULL,

	Telefonos		varchar(100) 	NULL,
	Fax 			varchar(50)     NULL,
	Contacto 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
        Extencion	        varchar(10)     NULL,
        Extencion2              varchar(10)     NULL,
	eMail			varchar(50) 	NULL,
	eMail2			varchar(50) 	NULL,
	Movil			varchar(50)	NULL,
	Movil2			varchar(50)	NULL,
	
	RFC			varchar(20)	NULL,
	CURP			varchar(20)	NULL,

	Tipo			varchar(20)	NULL,
	Estatus			varchar(15)	NULL,
	Situacion		varchar(50)	NULL,

	CONSTRAINT pk_mcCargaProp PRIMARY KEY CLUSTERED (Valor, Campo)
)
GO

-- drop table mcCarga
/****************************** mcCarga ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcCarga') AND Type='U')
  CREATE TABLE mcCarga (
	GID			uniqueidentifier	NOT NULL	DEFAULT NEWID(),
	RID			int			NOT NULL	IDENTITY(1,1),

	Empresa			varchar(5)		NULL,
	Sucursal		int			NULL,
	Usuario			varchar(10)		NULL,
	Posicion		varchar(20)		NULL,
	FechaEmision		datetime		NULL,
	Observaciones		varchar(100)		NULL,
	Tipo			varchar(20)		NULL,

	Estatus			varchar(15)		NULL,

	CONSTRAINT pk_mcCarga PRIMARY KEY CLUSTERED (GID)
)
GO

-- drop table mcCargaReg
/****************************** mcCargaReg ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcCargaReg') AND Type='U')
  CREATE TABLE mcCargaReg (
	GID			uniqueidentifier	NOT NULL	DEFAULT NEWID(),
	CargaGID		uniqueidentifier	NOT NULL,

	Mayor			varchar(20)		NULL,
	Sucursal		int			NULL,

	Cuenta			varchar(20)		NULL,
	CentroCostos		varchar(20)		NULL,
	UEN		   	int			NULL,
	Proyecto		varchar(50)		NULL,
	Actividad		varchar(20)   		NULL,
	RFC			varchar(20)		NULL,
	CURP			varchar(20)		NULL,

	Cliente			varchar(10)		NULL,
	Proveedor		varchar(10)		NULL,
	Personal		varchar(10)		NULL,
	Almacen			varchar(10)		NULL,

	FechaEmision		datetime		NULL,
	Mov			varchar(20)		NULL,
	MovID			varchar(20)		NULL,

	Articulo		varchar(20)		NULL,
	Opcion			varchar(50)		NULL,
	SerieLote		varchar(50)		NULL,
	CtaDinero		varchar(10)		NULL,
	Concepto		varchar(50)		NULL,
	Referencia		varchar(50)		NULL,
	Clase			varchar(50)		NULL,
	SubClase		varchar(50)		NULL,
	Causa			varchar(50)		NULL,
	FormaEnvio		varchar(50)		NULL,
	FormaPago		varchar(50)		NULL,
	Condicion		varchar(50)		NULL,
	Vencimiento		datetime		NULL,
	Recurso			varchar(10)		NULL,
	Agente			varchar(10)		NULL,
	Cajero			varchar(10)		NULL,
	Espacio			varchar(10)		NULL,
	AFArticulo		varchar(20)		NULL,
	AFSerie			varchar(50)		NULL,

	Cantidad		float			NULL,
	Precio			float			NULL,
	Descuento1		float			NULL,
	Descuento2		float			NULL,
	Costo			float			NULL,
	Gastos			float			NULL,
	Impuesto1		float			NULL,
	Impuesto2		float			NULL,
	Impuesto3		float			NULL,

	Moneda			varchar(10)		NULL,
	TipoCambio		float			NULL	DEFAULT 1,
	TipoCambio2		float			NULL	DEFAULT 1,
	Unidad			varchar(50)		NULL,
	Factor			float			NULL	DEFAULT 1,

	Debe			money			NULL,
	Haber			money			NULL,
	Presupuesto		money			NULL,
	Existencia		float			NULL,
	porSurtir		float			NULL,

	CONSTRAINT pk_mcCargaReg PRIMARY KEY CLUSTERED (GID)
)
GO
EXEC spADD_INDEX 'mcCargaReg', 'CargaGID', 'CargaGID, GID'
GO

-- drop table mcCache
/****************************** mcCache ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcCache') AND Type='U')
CREATE TABLE mcCache (
	RID			int			NOT NULL	IDENTITY(1,1),

	Llave			varchar(900)		NULL,
	UltimoCambio		datetime		NULL,

	Accion			varchar(50)		NULL,
	Datos			nvarchar(max)		NULL,
	Resultado		nvarchar(max)		NULL,

	CONSTRAINT pk_mcCache PRIMARY KEY CLUSTERED (RID)
)
GO
EXEC spADD_INDEX 'mcCache', 'Llave', 'Llave'
GO

-- drop table mcColaSalida
/****************************** mcColaSalida ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcColaSalida') AND Type='U')
CREATE TABLE mcColaSalida (
	RID			int			NOT NULL	IDENTITY(1,1),

	Accion			varchar(50)		NULL,
	Datos			nvarchar(max)		NULL,
	Resultado		nvarchar(max)		NULL,
	Ok			int			NULL,
	OkRef			varchar(255)		NULL,

	Estatus			varchar(15)		NULL,
	EstatusFecha		datetime		NULL,

	CONSTRAINT pk_mcColaSalida PRIMARY KEY CLUSTERED (RID)
)
GO
EXEC spADD_INDEX 'mcColaSalida', 'Estatus', 'Estatus, Accion'
GO

-- drop table mcReplicaSalida
/****************************** mcReplicaSalida ********************************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('mcReplicaSalida') AND Type='U')
CREATE TABLE mcReplicaSalida (
	RID			int			NOT NULL	IDENTITY(1,1),

	Tema			varchar(50)		NULL,
	Llave			varchar(255)		NULL,
	Ok			int			NULL,
	OkRef			varchar(255)		NULL,

	Estatus			varchar(15)		NULL,
	EstatusFecha		datetime		NULL,

	CONSTRAINT pk_mcReplicaSalida PRIMARY KEY CLUSTERED (RID)
)
GO
EXEC spADD_INDEX 'mcReplicaSalida', 'Llave', 'Llave, Tema, Estatus'
GO


/***************************************************************************/
/************************ VISTAS DEL MODULO CENTRAL ************************/ 
/***************************************************************************/

-- select * from mcCargaMayor
/*** mcCargaMayor ***/
if exists (select * from sysobjects where id = object_id('dbo.mcCargaMayor') and type = 'V') drop view dbo.mcCargaMayor
GO
CREATE VIEW mcCargaMayor
--//WITH ENCRYPTION
AS
SELECT CargaGID, Mayor,
       'Debe' = SUM(Debe),
       'Haber' = SUM(Haber),
       'Presupuesto' = SUM(Presupuesto),
       'Existencia' = SUM(Existencia),
       'porSurtir' = SUM(porSurtir)
  FROM mcCargaReg
 GROUP BY CargaGID, Mayor
GO  