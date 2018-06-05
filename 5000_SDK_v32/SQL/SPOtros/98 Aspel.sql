
SET ANSI_NULLS ON
SET ANSI_WARNINGS ON
GO

/****** Aspel_Paso ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Aspel_Paso]') AND type in (N'U'))
DROP TABLE [dbo].[Aspel_Paso]
GO

CREATE TABLE [dbo].[Aspel_Paso](
	[IntegracionVisor] [bit] NOT NULL,
	[Ventas] [bit] NULL,
	[DescripcionVentas] [varchar](250) COLLATE Database_Default NULL,
	[RegistrosVentas] [int] NULL,
	[TotalVentas] [money] NULL,
	[Compras] [bit] NULL,
	[DescripcionCompras] [varchar](250) COLLATE Database_Default NULL,
	[RegistrosCompras] [int] NULL,
	[TotalCompras] [money] NULL,
	[CuentasPorCobrar] [bit] NULL,
	[DescripcionCxC] [varchar](250) COLLATE Database_Default NULL,
	[RegistrosCxC] [int] NULL,
	[TotalCxC] [money] NULL,
	[CuentasPorPagar] [bit] NULL,
	[DescripcionCxP] [varchar](250) COLLATE Database_Default NULL,
	[RegistrosCxP] [int] NULL,
	[TotalCxP] [money] NULL,
	[Inventarios] [bit] NULL,
	[DescripcionInventarios] [varchar](250) COLLATE Database_Default NULL,
	[RegistrosInventarios] [int] NULL,
	[Polizas] [bit] NULL,
	[DescripcionPolizas] [varchar](250) COLLATE Database_Default NULL,
	[RegistrosPolizas] [int] NULL,
	[PolizaAjuste] [bit] NULL,
	[DescripcionPolAjuste] [varchar](250) COLLATE Database_Default NULL,
	[RegistrosPolAjuste] [int] NULL
) ON [PRIMARY]

GO

INSERT INTO Aspel_Paso(IntegracionVisor, Ventas, DescripcionVentas, RegistrosVentas, TotalVentas, Compras, DescripcionCompras, 
RegistrosCompras, TotalCompras, CuentasPorCobrar, DescripcionCxC, RegistrosCxC, TotalCxC, CuentasPorPagar, DescripcionCxP,
RegistrosCxP, TotalCxP, Inventarios, DescripcionInventarios, RegistrosInventarios, Polizas, DescripcionPolizas, RegistrosPolizas, 
PolizaAjuste, DescripcionPolAjuste) VALUES(0, 0, '', 0, 0, 0, '',
0, 0, 0, '', 0, 0, 0, '',
0, 0, 0, '', 0, 0, '', 0, 
0, '')

/*********** dbo.AspelCfgOpcion ************/
IF EXISTS(SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.AspelCfgOpcion') AND TYPE = 'U')
  DROP TABLE AspelCfgOpcion
GO

CREATE TABLE dbo.AspelCfgOpcion
(
   Valor varchar(250) NULL,
   Descripcion varchar(50),
   Seccion	   varchar(50)
)
GO
DELETE FROM AspelCfgOpcion
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Microsoft.Jet.OLEDB.4.0', 'ODBC','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Paradox', 'Tipo Base De Datos SAE','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES (NULL, 'Servidor SAE','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES (NULL, 'Base De Datos SAE','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('C:\Archivos de programa\Common Files\Aspel\Sistemas Aspel\SAE4.00\Ejemplos', 'Ruta SAE','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('1', 'Empresa SAE','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Si', 'Importar COI','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Paradox', 'Tipo Base De Datos COI','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES (NULL, 'Servidor COI','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES (NULL, 'Base De Datos COI','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('C:\Archivos de programa\Common Files\Aspel\Sistemas Aspel\COI5.50\Ejemplos', 'Ruta COI','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('1', 'Empresa COI','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES (NULL, 'Base De Datos De Paso','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('ABRAHAM1', 'Servidor Intelisis','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES (NULL, 'Base De Datos Intelisis','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Si', 'Ajuste Automatico Existencias Series','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('9999-999-999;2', 'Formato Cuentas Contables','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Impuesto 4 SAE', 'IVA Articulo','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Impuesto 1 SAE', 'IEPS Articulo','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Impuesto 3 SAE', 'Impuesto 3 Articulo','Inicial')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('No', 'Generar Poliza De Ajuste','Poliza Ajuste')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Ventas', 'Rubro Ventas','Poliza Ajuste')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Costo de Ventas', 'Rubro Compras','Poliza Ajuste')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Cuentas por Cobrar', 'Rubro Clientes','Poliza Ajuste')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Proveedores', 'Rubro Proveedores','Poliza Ajuste')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('Inventarios', 'Rubro Inventarios','Poliza Ajuste')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('4200-003-000', 'Cuenta Ventas','Poliza Ajuste')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('5500-000-000', 'Cuenta Compras','Poliza Ajuste')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('1150-002-001', 'Cuenta Clientes','Poliza Ajuste')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('2110-001-010', 'Cuenta Proveedores','Poliza Ajuste')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('1160-003-000', 'Cuenta Inventarios','Poliza Ajuste')
INSERT INTO AspelCfgOpcion (Valor, Descripcion, Seccion) VALUES ('9000-001-001', 'Cuenta Ajuste','Poliza Ajuste')
GO

/* Se actualizan valores de la tabla aspelcfgopcion para que no aparezcan*/
UPDATE aspelcfgopcion
SET  Seccion = 'NOUSAR' WHERE Descripcion = 'Ruta SAE'

UPDATE aspelcfgopcion
SET  Seccion = 'NOUSAR' WHERE Descripcion = 'Ruta COI'

UPDATE aspelcfgopcion
SET  Seccion = 'NOUSAR' WHERE Descripcion = 'Ajuste Automatico Existencias Series'

/*********** AspelCfgModuloMayor ************/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('AspelCfgModuloMayor') AND Type='U')  
  DROP TABLE AspelCfgModuloMayor
GO

CREATE TABLE AspelCfgModuloMayor
(
     Mayor				varchar (20),
	 Descripcion		varchar (100),
	 Rama				varchar (20) NULL,
	 EsAcreedora		bit NULL,
	 EsAcumulativa		bit NULL,
	 Modulo				varchar(15),
	 Agrupador			varchar(15) NULL,
	 MovDebeContable	varchar(20) NULL,
	 MovHaberContable	varchar(20) NULL,
	 MovDebeNoContable	varchar(20) NULL,
	 MovHaberNoContable	varchar(20) NULL,
	 FactorDebeNoContable	int NULL,
	 FactorHaberNoContable	int NULL,
	 ClaveDebeNoContable	varchar(20) NULL,
	 ClaveHaberNoContable	varchar(20) NULL,
	 EstatusContable	varchar(15),
	 EstatusNoContable	varchar(15),
	 AfectaContabilidad	bit,
)
GO

DELETE FROM AspelCfgModuloMayor
INSERT INTO AspelCfgModuloMayor (Mayor, Descripcion, Modulo, Agrupador, MovDebeContable, MovHaberContable, MovDebeNoContable, MovHaberNoContable, AfectaContabilidad, EstatusContable, EstatusNoContable, FactorDebeNoContable, FactorHaberNoContable, ClaveDebeNoContable, ClaveHaberNoContable)
                             VALUES ('103-00-000', 'Clientes', 'CXC', NULL, 'Factura', 'Cobro', 'SAE Factura', 'SAE Cobro', 1, 'SINAFECTAR', 'SINAFECTAR', 1, -1, 'CXC.EST','CXC.EST') 
INSERT INTO AspelCfgModuloMayor (Mayor, Descripcion, Modulo, Agrupador, MovDebeContable, MovHaberContable, MovDebeNoContable, MovHaberNoContable, AfectaContabilidad, EstatusContable, EstatusNoContable, FactorDebeNoContable, FactorHaberNoContable, ClaveDebeNoContable, ClaveHaberNoContable)
                             VALUES ('104-00-000', 'Inventarios', 'INV', NULL, 'Ajuste', NULL, 'SAE Inv. Fisico', NULL, 1, 'SINAFECTAR', 'SINAFECTAR', 1, NULL, 'INV.EST', NULL) 
INSERT INTO AspelCfgModuloMayor (Mayor, Descripcion, Modulo, Agrupador, MovDebeContable, MovHaberContable, MovDebeNoContable, MovHaberNoContable, AfectaContabilidad, EstatusContable, EstatusNoContable, FactorDebeNoContable, FactorHaberNoContable, ClaveDebeNoContable, ClaveHaberNoContable)
                             VALUES ('201-00-000', 'Proveedores', 'CXP', NULL, 'Entrada Compra', 'Nota Cargo', 'SAE Entrada Compra', 'SAE Pago', 1, 'SINAFECTAR', 'SINAFECTAR', 1, -1, 'CXP.EST','CXP.EST') 
INSERT INTO AspelCfgModuloMayor (Mayor, Descripcion, Modulo, Agrupador, MovDebeContable, MovHaberContable, MovDebeNoContable, MovHaberNoContable, AfectaContabilidad, EstatusContable, EstatusNoContable, FactorDebeNoContable, FactorHaberNoContable, ClaveDebeNoContable, ClaveHaberNoContable)
                             VALUES ('400-00-000', 'Ventas', 'VTAS', 'Movimiento', 'Devolucion Venta', 'Factura','Aspel Dev. Venta', 'Aspel Factura', 0, 'SINAFECTAR', 'SINAFECTAR', -1, 1, 'VTAS.EST','VTAS.EST') 
INSERT INTO AspelCfgModuloMayor (Mayor, Descripcion, Modulo, Agrupador, MovDebeContable, MovHaberContable, MovDebeNoContable, MovHaberNoContable, AfectaContabilidad, EstatusContable, EstatusNoContable, FactorDebeNoContable, FactorHaberNoContable, ClaveDebeNoContable, ClaveHaberNoContable)
                             VALUES ('800-00-000', 'Compras', 'COMS', 'Movimiento', 'Entrada Compra', 'Devolucion Compra','Aspel Entrada Compra', 'Aspel Dev. Compra', 0, 'SINAFECTAR', 'SINAFECTAR', 1, -1, 'COMS.EST','COMS.EST') 
INSERT INTO AspelCfgModuloMayor (Mayor, Descripcion, Modulo, Agrupador, MovDebeContable, MovHaberContable, MovDebeNoContable, MovHaberNoContable, AfectaContabilidad, EstatusContable, EstatusNoContable, FactorDebeNoContable, FactorHaberNoContable, ClaveDebeNoContable, ClaveHaberNoContable)
                             VALUES ('800-00-001', 'Contabilidad', 'CONT', 'Movimiento', NULL, NULL,NULL, NULL, 0, 'SINAFECTAR', 'SINAFECTAR', 1, -1, 'CONT.P','CONT.P') 
GO

/* Asigna valores por omisión para las opciones de migración */


Declare

-- Valores aspelcfgmodulomayor
	@Saldofavorcxc	varchar (20),
	@Saldofavorcxp	varchar (20),
	@Factorsaldofavorcxc int,
	@Factorsaldofavorcxp int,

	@Saldocxc	varchar (20),
	@Saldocxp	varchar (20),
	@Factorsaldocxc int,
	@Factorsaldocxp int,

	@Saldoinv	varchar (20),
	@Factura	varchar(20),
	@Compra		varchar(20),
	@Devolventa	varchar(20),
	@Devolcompra varchar(20)

-- Valores aspelcfgmodulomayor
	set @Saldocxc	= 'SAE Cargo'
	set @Saldocxp	= 'SAE Cargo'
	set @Factorsaldocxc = 1
	set @Factorsaldocxp = 1

	set @Saldofavorcxp	= 'SAE Saldo a favor'
	set @Saldofavorcxc	= 'SAE Saldo a favor'
	set @Factorsaldofavorcxc = -1
	set @Factorsaldofavorcxp = -1

	set @Saldoinv	= 'SAE Inventario'

	set @Factura	= 'SAE Factura'
	set @Compra		= 'SAE Compra'
	set @Devolventa	= 'SAE Devolución'
	set @Devolcompra = 'SAE Devolución'

Update Aspelcfgopcion
set Valor =  'SQL' Where Descripcion = 'SQL'

Update Aspelcfgopcion
set Valor =  'SQL' Where Descripcion = 'Tipo Base De Datos COI'

Update Aspelcfgopcion
set Valor =  'SQL' Where Descripcion ='Tipo Base De Datos SAE'

Update Aspelcfgopcion
set Valor =  'Paso1' Where Descripcion = 'Base De Datos De Paso'

Update Aspelcfgopcion
set Valor =  '' Where Descripcion = 'Servidor Intelisis'


Update Aspelcfgopcion
set Valor =  'No' Where Descripcion = 'Ajuste Automatico Existencias Series'

Update Aspelcfgopcion
set Valor =  'IMPU4' Where Descripcion = 'IVA Articulo'
Update Aspelcfgopcion
set Valor =  'IMPU1' Where Descripcion = 'IEPS Articulo'
Update Aspelcfgopcion
set Valor =  'IMPU2+IMPU3' Where Descripcion = 'Impuesto 3 Articulo'

--	Abonos CXC CXP --
Update aspelcfgmodulomayor
Set MovHabercontable = @Saldofavorcxc where Descripcion = 'Clientes'
Update aspelcfgmodulomayor
Set FactorHaberNocontable = @Factorsaldofavorcxc where Descripcion = 'Clientes'

Update aspelcfgmodulomayor
Set MovHabercontable = @Saldofavorcxp where Descripcion = 'Proveedores'
Update aspelcfgmodulomayor
Set FactorHaberNocontable =@Factorsaldofavorcxp where Descripcion = 'Proveedores'

-- Cargos CXC CXP --
Update aspelcfgmodulomayor
Set MovDebecontable = @Saldocxc where Descripcion = 'Clientes'
Update aspelcfgmodulomayor
Set FactorDebeNocontable = @Factorsaldocxc where Descripcion = 'Clientes'

Update aspelcfgmodulomayor
Set MovDebecontable = @Saldocxp where Descripcion = 'Proveedores'
Update aspelcfgmodulomayor
Set FactorDebeNocontable =@Factorsaldocxp where Descripcion = 'Proveedores'

-- Inventario --
Update aspelcfgmodulomayor
Set MovDebecontable = @Saldoinv where Descripcion = 'Inventarios'

-- VENTAS --
Update aspelcfgmodulomayor
Set MovDebeNocontable = @Devolventa where Descripcion = 'Ventas'
Update aspelcfgmodulomayor
Set MovHaberNocontable = @Factura where Descripcion = 'Ventas'

-- COMPRAS --
Update aspelcfgmodulomayor
Set MovDebeNocontable = @Compra where Descripcion = 'Compras'
Update aspelcfgmodulomayor
Set MovHaberNocontable = @DevolCompra where Descripcion = 'Compras'

/*********** dbo.AspelCargaReg ************/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.AspelCargaReg') AND Type='U') 
  DROP TABLE AspelCargaReg
GO

CREATE TABLE AspelCargaReg 
(
	RID				int 			NOT NULL	IDENTITY(1,1),
	GID				uniqueidentifier DEFAULT NewID(),
	CargaGID			uniqueidentifier,
	Mayor				varchar(50)	NULL,
	Empresa				varchar(5)		NULL,
	Sucursal			int				NULL,
	CentroCostos			varchar(20)		NULL,
	UEN		   		int				NULL,
	Proyecto		varchar(50)		NULL,
	Actividad		varchar(20)   	NULL,
	RFC				varchar(20)		NULL,
	CURP			varchar(20)		NULL,
	Cliente			varchar(10)		NULL,
	Proveedor		varchar(10)		NULL,
	Personal		varchar(10)		NULL,
	Almacen			varchar(10)		NULL,
	FechaEmision	datetime		NULL,
	Mov				varchar(20)		NULL,
	MovID			varchar(20)		NULL,
	Articulo		varchar(20)		NULL,
	SubCuenta		varchar(50)		NULL,
	SerieLote		varchar(50)		NULL,
	CtaDinero		varchar(10)		NULL,
	Concepto		varchar(250)		NULL,
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
	Cantidad		float(15)		NULL,
	Precio			float(15)		NULL,
	Descuento1		float(15)		NULL,
	Descuento2		float(15)		NULL,
	Costo			float(15)		NULL,
	Gastos			float(15)		NULL,
	Impuesto1		float(15)		NULL,
	Impuesto2		float(15)		NULL,
	Impuesto3		float(15)		NULL,
	Moneda			varchar(10)		NULL,
	TipoCambio		float(15)		NULL	DEFAULT 1,
	Unidad			varchar(50)		NULL,
	Factor			float(15)		NULL	DEFAULT 1,
	Debe			money			NULL,
	Haber			money			NULL,
	Entrada			float(15)		NULL,
	Salida			float(15)		NULL,
	Estatus			varchar(15)		NULL,
	Situacion		varchar(10)		NULL,
	Modulo			varchar(15)		NULL
	CONSTRAINT priAspelCargaReg PRIMARY KEY CLUSTERED (RID)
)
GO

/******* dbo.AspelCargaProp ********/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('AspelCargaProp') AND Type='U')
  DROP TABLE AspelCargaProp
GO

CREATE TABLE AspelCargaProp 
(

    GID				uniqueidentifier DEFAULT NewID(),
	CargaGID		uniqueidentifier,
	Campo			varchar(50)		NOT NULL,
	Valor			varchar(50)		NOT NULL,
	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	Descripcion2	varchar(255)	NULL,
	Categoria		varchar(50)		NULL,
	Grupo			varchar(50)		NULL,
	Familia			varchar(50)		NULL,
	Linea			varchar(50)		NULL,
	Marca			varchar(50)		NULL,
	Direccion 		varchar(100) 	NULL,
	Delegacion		varchar(100)  	NULL,
	Colonia 		varchar(100)  	NULL,
	Poblacion 		varchar(100)  	NULL,
	Estado 			varchar(30)  	NULL,
	Pais			varchar(30)     NULL,
	Zona			varchar(30)     NULL,
	CodigoPostal 	varchar(15)  	NULL,
	GLN				varchar(50)     NULL,
	Telefonos		varchar(100) 	NULL,
	Fax 			varchar(50)     NULL,
	Contacto 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
    Extencion	    varchar(10)     NULL,
    Extencion2      varchar(10)     NULL,
	eMail			varchar(50) 	NULL,
	eMail2			varchar(50) 	NULL,
	Movil			varchar(50)		NULL,
	Movil2			varchar(50)		NULL,
	RFC				varchar(20)		NULL,
	CURP			varchar(20)		NULL,
	Unidad			varchar(20)		NULL,
    Impuesto1		float(15)		NULL,
    Impuesto2		float(15)		NULL,
    Impuesto3		float(15)		NULL,
	PrecioLista		money			NULL,
	Precio2			money			NULL,
	Precio3			money			NULL,
	Precio4			money			NULL,
	Precio5			money			NULL,
	TiempoEntrega	int				NULL,
	TiempoEntregaU  varchar(10)		NULL,
	Peso			float(15)		NULL,
	Volumen			float(15)		NULL,
	Proveedor		varchar(10)		NULL,
	TipoCosteo		varchar(20)		NULL,
	Tipo			varchar(20)		NULL,
    TipoComision	varchar(20)		NULL,
	Porcentaje		float(15)		NULL,
    Orden			int				NULL,
	TipoCambio		float(15)		NULL,
	Clave			char(3)			NULL,
	Estatus			varchar(15)		NULL,
	UltimaEntrada	datetime		NULL,
	UltimaSalida	datetime		NULL,
	Costo			float(15)		NULL,
	Articulo		varchar(20)		NULL,
	Almacen			varchar(20)		NULL,
	ValorNumero		int				NULL,
	Rama			varchar(50)		NULL,
	Factor			float(15)		NULL,
    TipoPoliza		varchar(20)		NULL
	CONSTRAINT priAspelCargaProp PRIMARY KEY CLUSTERED (Valor, Campo, GID)
)
GO


/*********** dbo.TblAspelCfg ************/
IF EXISTS(SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.TblAspelCfg') AND TYPE = 'U')
  DROP TABLE TblAspelCfg
GO
CREATE TABLE dbo.TblAspelCfg
(
   tabla varchar(100) NULL,
   Sistema varchar(100) NULL	
)
GO
DELETE FROM TblAspelCfg
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CLIE01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('FACT01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('FA0TY1', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('PROV01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('COMP01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('COM0Y1', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('MINV01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CONM01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CUEN01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CONC01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('PAGA01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CONP01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('VEND01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('MULT01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('INVE01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('NUMSER01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('IMPU01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('MONED01', 'SAE')
INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CTARUB01', 'COI')
GO

/******** dbo.AspelLog *********/
IF EXISTS(SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.AspelLog')AND TYPE = 'U')
  DROP TABLE AspelLog
CREATE TABLE AspelLog
(
ID int identity(1,1),
Sistema varchar(30) NULL,
Tabla	varchar(30) NULL,
Fecha	datetime NULL
)
GO

/******** dbo.AspelCatCuentas *********/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.AspelCatCuentas')AND TYPE = 'U')
CREATE TABLE AspelCatCuentas 
(
NumCuenta	varchar(40), 
Descripcion	varchar(100), 
Status		varchar(30), 
Tipo		varchar(30), 
Rama		varchar(40)
)
GO

/*********** spAspelPresentaDatos ***********/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelPresentaDatos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelPresentaDatos]
GO


CREATE PROCEDURE  [dbo].[spAspelPresentaDatos]
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @SrvOrigenSAE			varchar(50), 
  @BDOrigenSAE			varchar(30), 
  @OrigenSAE				varchar(100), 
  @RutaSAE				varchar(250),
  @EmpresaSAE			int,
  @ImportaCOI			bit, 
  @SrvOrigenCOI			varchar(50), 
  @BDOrigenCOI			varchar(30), 
  @OrigenCOI				varchar(100), 
  @RutaCOI				varchar(250),
  @EmpresaCOI			int,
  @BaseDatosPaso		varchar(30),
  @SrvIntelisis			varchar(50),
  @BaseDatosIntelisis	varchar(30),
  @sql					nvarchar(1000),
  @Cuenta				int


  SET ANSI_NULLS ON
  SET ANSI_WARNINGS ON

  EXEC spAspelBorraPropReg

  SELECT @SrvOrigenSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Servidor SAE'
  
  select @Cuenta = count(*) from master.dbo.sysservers where srvname = @SrvOrigenSAE
  
  if @Cuenta = 0
	exec sp_addlinkedserver @SrvOrigenSAE
	
  SELECT @BDOrigenSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Base De Datos SAE'
  SELECT @OrigenSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Tipo Base De Datos SAE'
  SELECT @RutaSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Ruta SAE'
  SELECT @EmpresaSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Empresa SAE'
  SELECT @ImportaCOI = CASE WHEN Valor = 'Si' THEN 1 ELSE 0 END FROM AspelCfgOpcion WHERE Descripcion = 'Importar COI'
  SELECT @SrvOrigenCOI = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Servidor COI'
  SELECT @BDOrigenCOI = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Base De Datos COI'
  SELECT @OrigenCOI = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Tipo Base De Datos COI'
  SELECT @RutaCOI = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Ruta COI'
  SELECT @EmpresaCOI = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Empresa COI'
  SELECT @SrvIntelisis = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Servidor Intelisis'
  SELECT @BaseDatosIntelisis = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Base De Datos Intelisis'

  UPDATE Aspel_paso SET
  IntegracionVisor = 0
  
  EXEC spAspelImportarTablas @SrvOrigenSAE, @BDOrigenSAE, @OrigenSAE, 'SAE', @RutaSAE, @BaseDatosPaso OUTPUT, @EmpresaSAE

  IF @ImportaCOI = 1
	EXEC spAspelImportarTablas @SrvOrigenCOI, @BDOrigenCOI, @OrigenCOI, 'COI', @RutaCOI, @BaseDatosPaso, @EmpresaCOI
	EXEC spAspelImportarTablasCargaPropReg @SrvIntelisis,@SrvIntelisis,@BaseDatosPaso,@BaseDatosIntelisis,@ImportaCOI

  UPDATE Aspel_paso SET
  IntegracionVisor = 1
  
  SET ANSI_NULLS OFF
  SET ANSI_WARNINGS OFF

END
GO

/****** AspelCfgConceptos ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspelCfgConceptos]') AND type in (N'U'))
DROP TABLE [dbo].[AspelCfgConceptos]
GO

CREATE TABLE [dbo].[AspelCfgConceptos](
	[Modulo] [varchar](3)  NOT NULL,
	[Tipo] [varchar](1)  NOT NULL,
	[NumConcepto] [varchar](20)  NOT NULL,
	[MovimientoIntelisisCxC] [varchar](20)  NULL,
	[MovimientoIntelisisCxP] [varchar](20)  NULL,
 CONSTRAINT [PK_AspelCfgConceptos] PRIMARY KEY CLUSTERED 
(
	[Modulo] ASC,
	[Tipo] ASC,
	[NumConcepto] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Si los nombres de los movimientos dse van a integrar de origen es necesario que coincidan
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXC' AND TIPO = 'A' AND NumConcepto = '9')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxC) Values ('CXC','A', '9', 'SAE Anticipo')
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXC' AND TIPO = 'A' AND NumConcepto = '8')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxC) Values ('CXC','A', '8', 'SAE Nota Credito')
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXC' AND TIPO = 'A' AND NumConcepto = 'Cualquier otro')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxC) Values ('CXC','A', 'Cualquier otro', 'SAE Saldo a favor')
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXC' AND TIPO = 'C' AND NumConcepto = '1')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxC) Values ('CXC','C', '1', 'SAE Factura')
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXC' AND TIPO = 'C' AND NumConcepto = '2')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxC) Values ('CXC','C', '2', 'SAE Nota Cargo')
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXC' AND TIPO = 'C' AND NumConcepto = 'Cualquier otro')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxC) Values ('CXC','C', 'Cualquier otro', 'SAE Cargo')
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXP' AND TIPO = 'A' AND NumConcepto = '9')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxP) Values ('CXP','A', '9', 'SAE Anticipo')
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXP' AND TIPO = 'A' AND NumConcepto = '8')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxP) Values ('CXP','A', '8', 'SAE Nota Credito')
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXP' AND TIPO = 'A' AND NumConcepto = 'Cualquier otro')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxP) Values ('CXP','A', 'Cualquier otro', 'SAE Saldo a favor')
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXP' AND TIPO = 'C' AND NumConcepto = '1')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxP) Values ('CXP','C', '1', 'SAE Compra')
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXP' AND TIPO = 'C' AND NumConcepto = '2')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxP) Values ('CXP','C', '2', 'SAE Nota Cargo')
IF NOT EXISTS(SELECT * FROM AspelCfgConceptos WHERE Modulo = 'CXP' AND TIPO = 'C' AND NumConcepto = 'Cualquier otro')
INSERT INTO AspelCfgConceptos (Modulo, Tipo, NumConcepto, MovimientoIntelisisCxP) Values ('CXP','C', 'Cualquier otro', 'SAE Cargo')

GO

/***********AspelArticulosTotal***********/
IF EXISTS(SELECT * FROM sysobjects WHERE id=OBJECT_ID('AspelArticulosTotal') AND XType = 'V') 
DROP VIEW AspelArticulosTotal
GO

CREATE VIEW AspelArticulosTotal AS 
SELECT Articulo, 
SUM(ISNULL(Cantidad,0)) Cantidad 
FROM AspelCargaReg
WHERE Modulo = 'INV'
GROUP BY Articulo
GO

/***********AspelCuentasTotal***********/
IF EXISTS(SELECT * FROM sysobjects WHERE id=OBJECT_ID('AspelCuentasTotal') AND XType = 'V') 
DROP VIEW AspelCuentasTotal
GO

CREATE VIEW AspelCuentasTotal AS 
SELECT LEFT(Mayor,20) Mayor, 
SUM(ISNULL(DEBE,0)) DEBE, 
SUM(ISNULL(HABER,0)) HABER, 
SUM(ISNULL(DEBE,0)) - SUM(ISNULL(HABER,0)) SALDO
FROM AspelCargaReg 
WHERE Modulo = 'CONT' 
GROUP BY Mayor 
GO

/****** spAspelImportarTablas ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelImportarTablas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelImportarTablas]
GO


CREATE PROCEDURE [dbo].[spAspelImportarTablas] 
(@SrvOrigen	varchar(50),
@BDOrigen		varchar(30),
@Origen		varchar(100),
@Sistema		varchar(30),
@Ruta			varchar(200),
@BaseDatos	varchar(30) OUTPUT,
@Empresa		int)
--//WITH ENCRYPTION
AS
DECLARE @Tabla			varchar(50),
@TablaAnt		varchar(50),
@Ruta2			varchar(200),
@TablaCursor	nvarchar(50),
@TablaCursor2	nvarchar(50),
@Cs				varchar(200),
@Sql			nvarchar(max),
@Sql1			nvarchar(max),
@RutaCoi		varchar(200),
@RutaCoiCC		varchar(200),
@MaxPer			varchar(30),
@MinPer			varchar(30),
@TablaCat		varchar(30),
@TablaCatD		varchar(30),
@BDatos			varchar(30),
@ValidaEmp		varchar(2),
@Emp			varchar(3),
@TablaEmp		varchar(40),
@TablaEmp2		varchar(40),
@PrimerTabla	bit,
@SqlPolizas		nvarchar(max),
@ODBC			varchar(50),
@Cuenta			int,
@sqlmes			nvarchar(max)

BEGIN
	SET ANSI_NULLS ON
	SET ANSI_WARNINGS ON

	SELECT @ODBC = RTRIM(Valor) FROM AspelCfgOpcion WHERE Descripcion = 'ODBC'
	IF @BaseDatos IS NULL
	BEGIN
		SET @BDatos = 'Paso' + CONVERT(varchar(30),@Empresa)			-- Aquí está la tabla de paso
		SET @BaseDatos = @Bdatos
	END
	ELSE
		SET @Bdatos = @BaseDatos
	
	SET @Sql = 'IF NOT EXISTS(SELECT * FROM sys.databases WHERE NAME = ' + char(39) + @BDatos + char(39) + ') '
	+ ' CREATE DATABASE '+@Bdatos
			
	EXEC sp_ExecuteSQL @Sql
		
	IF @Sistema = 'SAE'
	BEGIN
		SET @Sql = 'IF EXISTS(SELECT * FROM sys.databases WHERE NAME = ' + char(39) + @BDatos +Char(39) + ') DROP DATABASE ' + @BDatos
		+ ' CREATE DATABASE ' + @BDatos
			
		EXEC sp_executesql @Sql

		DELETE FROM TblAspelCfg
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CLIE' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('OCLI' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('FACT' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('PROV' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('OPRV' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('COMP' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('MINV' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CONM' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CUEN' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CONC' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('PAGA' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CONP' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('VEND' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('MULT' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('INVE' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('OINV' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('IMPU' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('NUMSER' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('MONED' + right('00' + convert(varchar, @Empresa),2), 'SAE')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CTARUB' + right('00' + convert(varchar, @Empresa),2), 'COI')
		
		IF @Empresa BETWEEN 1 AND 9
		BEGIN
			INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('FA0TY' + ltrim(rtrim(convert(varchar, @Empresa))), 'SAE')
			INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('COM0Y' + ltrim(rtrim(convert(varchar, @Empresa))), 'SAE')
		END
		ELSE
		BEGIN
			INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('FAYT' +   ltrim(rtrim(convert(varchar, @Empresa))), 'SAE')
			INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('COMY' +   ltrim(rtrim(convert(varchar, @Empresa))), 'SAE')		
		END
		
		IF @Origen = 'Paradox'
		BEGIN
			SET @Ruta2 = 'dir /b "' + @Ruta + '\*.DB"'
			SET @CS = CHAR(39)+@ODBC+CHAR(39)+', '+CHAR(39)+'paradox 5.x;database='+@Ruta+CHAR(39)
		END

		IF @Origen = 'Access'
		BEGIN
			SET @Ruta2 = @Ruta + '\AspelNew.mdb; UID=Admin; PWD='+CHAR(39)+', '+CHAR(39)+'SELECT * FROM '
			SET @CS = CHAR(39)+@ODBC+CHAR(39)+', '+CHAR(39)+'MS Access;Database='+@Ruta2+char(39)
		END

		DECLARE SAE CURSOR FOR
		SELECT Tabla
		FROM TblAspelCfg
		WHERE Sistema = 'SAE'

		OPEN SAE
		FETCH next FROM SAE INTO @TablaCursor

		WHILE @@FETCH_STATUS <> -1
		BEGIN
			IF ISNUMERIC(RIGHT(@TablaCursor, 2)) = 1		
					SET @TablaEmp = left(@TablaCursor, len(@TablaCursor) - 2) + '01'

-- Caso de empresa > 9
			IF @Tablaemp = 'FAYT01' 
				BEGIN
					SET @Tablaemp = 'FA0TY1'
				END	

--
			IF @Tablaemp = 'COMY01' 
				BEGIN
					SET @Tablaemp = 'COM0Y1'
				END	


			 
			ELSE
            
				SET @TablaEmp = left(@TablaCursor, len(@TablaCursor) - 1) + '1'
			 
				
			IF (@Origen = 'Paradox' or @Origen = 'Access') AND (@TablaCursor IS NOT NULL)
			BEGIN
				SET @sql = 'SELECT * INTO '+@Bdatos+'..'+@TablaEmp+' FROM OPENROWSET('+@CS+','+@TablaCursor+') '
				

			END

			IF @Origen = 'Sql' AND @TablaCursor IS NOT NULL
			BEGIN
				SET @Sql = 'SELECT * INTO '+@Bdatos+'..'+upper(@TablaEmp)+' FROM '+@SrvOrigen+'.'+@BDOrigen+'.dbo.'+@TablaCursor
			END
	
			EXEC SP_EXECUTESQL @sql
		

			
			INSERT INTO AspelLog VALUES ('SAE',@TablaCursor, GetDate())
			FETCH next FROM SAE INTO @TablaCursor
		END
		CLOSE SAE
		DEALLOCATE SAE
	END

	IF @sistema = 'COI'
	BEGIN
		DELETE FROM TblAspelCfg
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('CTARUB'  + right('00' + convert(varchar, @Empresa),2), 'COI')
		INSERT INTO TblAspelCfg (Tabla, Sistema) VALUES ('RANC' + right('00' + convert(varchar, @Empresa),2), 'COI')

		IF @Origen = 'Paradox'
		BEGIN
			SET @Ruta2 = 'dir /b "' + @Ruta + '\*.DB"'
			SET @CS = CHAR(39)+@ODBC+CHAR(39)+', '+CHAR(39)+'paradox 5.x;database='+@Ruta+CHAR(39)
		END

		IF @Origen = 'Access'
		BEGIN
			SET @Ruta2 = @Ruta + '\AspelNew.mdb; UID=Admin; PWD='+CHAR(39)+', '+CHAR(39)+'SELECT * FROM '
			SET @CS = CHAR(39)+@ODBC+CHAR(39)+', '+CHAR(39)+'MS Access;Database='+@Ruta2
		END

		DECLARE COI CURSOR FOR
		SELECT Tabla
		FROM TblAspelCfg
		WHERE Sistema = 'COI'

		OPEN COI
		FETCH next FROM COI INTO @TablaCursor

		WHILE @@FETCH_STATUS <> -1
		BEGIN
			IF ISNUMERIC(RIGHT(@TablaCursor, 2)) = 1
				SET @TablaEmp = left(@TablaCursor, len(@TablaCursor) - 2) + '01'
			ELSE
				SET @TablaEmp = left(@TablaCursor, len(@TablaCursor) - 1) + '1'
			
			IF (@Origen = 'Paradox' or @Origen = 'Access') AND (@TablaCursor IS NOT NULL)
			BEGIN
				SET @sql = 'SELECT * INTO '+@Bdatos+'..'+@TablaEmp+' FROM OPENROWSET('+@CS+','+@TablaCursor+') '
			END
				
			IF @Origen = 'Sql'
			BEGIN
				SET @Sql = 'SELECT * INTO '+@Bdatos+'..'+@TablaEmp+' FROM '+@SrvOrigen+'.'+@BDOrigen+'.dbo.'+@TablaCursor
			END
			
			EXEC SP_EXECUTESQL @sql
			
			INSERT INTO AspelLog VALUES ('COI',@TablaCursor, GetDate())
			FETCH next FROM COI INTO @TablaCursor
		END
		
		CLOSE COI
		DEALLOCATE COI

		SET @RutaCoi = 'dir /b "' + @Ruta + '\MO*.DB"'
				
		DELETE FROM TblAspelCfg WHERE Sistema = 'COI'
		set @Sql = 'INSERT Into TblAspelCfg (Tabla) '
		+ 'select name from ' + @SrvOrigen + '.' + @BDOrigen + '.sys.objects '
		+ 'WHERE type in (N' + char(39) + 'U' + char(39) + ') and name like ' + char(39) + 'MO%' + char(39)
		
		EXEC SP_EXECUTESQL @sql
		
		DELETE FROM TblAspelCfg WHERE Sistema = 'COI'
		set @Sql = 'INSERT Into TblAspelCfg (Tabla) '
		+ 'select name from ' + @SrvOrigen + '.' + @BDOrigen + '.sys.objects '
		+ 'WHERE type in (N' + char(39) + 'U' + char(39) + ') and name like ' + char(39) + 'PO%' + char(39)
		
		EXEC SP_EXECUTESQL @sql
		
		UPDATE TblAspelCfg SET Sistema = @Sistema
		
		DELETE FROM TblAspelCfg
		WHERE (Sistema = 'COI' AND SUBSTRING(Tabla, 1, 2) <> 'MO')
		OR (SUBSTRING(Tabla, 3, 1) = 'N')

		IF @Origen = 'Paradox'
		BEGIN
			SET @RutaCoi = 'dir /b "' + @Ruta + '\*.DB"'
			SET @CS = CHAR(39)+@ODBC+CHAR(39)+', '+CHAR(39)+'paradox 5.x;database='+@Ruta+CHAR(39)
		END

		IF @Origen = 'Access'
		BEGIN
			SET @RutaCoi = @Ruta + '\AspelNew.mdb; UID=Admin; PWD='+CHAR(39)+', '+CHAR(39)+'SELECT * FROM '
			SET @CS = CHAR(39)+@ODBC+CHAR(39)+', '+CHAR(39)+'MS Access;Database='+@RutaCoi+''
		END

		DECLARE COI CURSOR FOR
		SELECT Tabla
		FROM TblAspelCfg
		WHERE Sistema = 'COI' AND Tabla IS NOT NULL

		SET @PrimerTabla = 1
		
		OPEN COI
		FETCH NEXT FROM COI INTO @TablaCursor

		WHILE @@FETCH_STATUS <> -1
		BEGIN
			IF ISNUMERIC(RIGHT(@TablaCursor, 2)) = 1
				SET @TablaEmp = left(@TablaCursor, len(@TablaCursor) - 2) + '01'
			ELSE
				SET @TablaEmp = left(@TablaCursor, len(@TablaCursor) - 1) + '1'
			
			SET @TablaEmp2 = replace(@TablaEmp, 'MO', 'PO')
			SET @TablaCursor2 = replace(@TablaEmp, 'MO', 'PO')
			
			IF (@Origen = 'Paradox' or @Origen = 'Access') AND (@TablaCursor IS NOT NULL)
			BEGIN
				SET @sql = 'SELECT * INTO '+@Bdatos+'.dbo.'+@TablaEmp+' FROM OPENROWSET('+@CS+','+@TablaCursor+') '
			END

			IF @Origen = 'SQL' AND @TablaCursor IS NOT NULL
			BEGIN
				SET @Sql = 'SELECT * INTO '+@Bdatos+'..'+@TablaEmp+' FROM '+@SrvOrigen+'.'+@BDOrigen+'.dbo.'+ @TablaCursor
				SET @Sql1 = 'SELECT * INTO '+@Bdatos+'..'+@TablaEmp2+' FROM '+@SrvOrigen+'.'+@BDOrigen+'.dbo.'+ @TablaCursor2
			END
			
			EXEC SP_EXECUTESQL @sql
			EXEC SP_EXECUTESQL @sql1
			
			set @sqlmes = 'Update ' + @BDatos + '.dbo.' + @TablaEmp + ' '
			+ 'set REFERENCIA = ' + char(39) +  @TablaEmp + char(39)
			EXEC SP_EXECUTESQL @Sqlmes
			
			IF @PrimerTabla = 1
			BEGIN


				SET @SqlPolizas = 'SELECT MO.NUM_REG, MO.TIPO_POLI, MO.NUM_POLIZ, MO.FECHA_POL, MO.NUM_CTA, ' +
				'MO.CONCEP_PO, MO.DEBE_HABER, MO.MONTOMOV, MO.NUMDEPTO, MO.TIPCAMBIO, MO.REFERENCIA, ' +
				'MO.NUM_PART, MO.CONTRAPAR, PO.CONCEP_PO AS CONCEP_CA ' +
				'INTO ' + @Bdatos + 
				'.dbo.POLIZAS FROM ' + @BDatos + '.dbo.' + @TablaEmp + ' MO, ' +
				@BDatos + '.dbo.' + @TablaEmp2 + ' PO ' + 
				'WHERE MO.NUM_POLIZ = PO.NUM_POLIZ AND MO.TIPO_POLI = PO.TIPO_POLI '
				
				SET @PrimerTabla = 0
			END 
			ELSE
			BEGIN

				SET @SqlPolizas = @SqlPolizas + 'UNION SELECT MO.NUM_REG, MO.TIPO_POLI, MO.NUM_POLIZ, MO.FECHA_POL, MO.NUM_CTA, ' +
				'MO.CONCEP_PO, MO.DEBE_HABER, MO.MONTOMOV, MO.NUMDEPTO, MO.TIPCAMBIO, MO.REFERENCIA, ' +
				'MO.NUM_PART, MO.CONTRAPAR, PO.CONCEP_PO AS CONCEP_CA FROM ' + @BDatos + '.dbo.' + @TablaEmp + ' MO, ' +
				@BDatos + '.dbo.' + @TablaEmp2 + ' PO ' + 
				'WHERE MO.NUM_POLIZ = PO.NUM_POLIZ AND MO.TIPO_POLI = PO.TIPO_POLI '
			END

			INSERT INTO AspelLog VALUES ('COI',@TablaCursor, GetDate())
			FETCH next FROM COI INTO @TablaCursor
		END

		EXEC SP_EXECUTESQL @SqlPolizas
		
		CLOSE COI
		DEALLOCATE COI

		delete from TblAspelCfg where Sistema = 'COI'

		SET @RutaCoiCC = 'dir /b "' + @Ruta + '\CC*.DB"'

		set @Sql = 'INSERT Into TblAspelCfg (Tabla) '
		+ 'select name from ' + @SrvOrigen + '.' + @BDOrigen + '.sys.objects '
		+ 'WHERE type in (N' + char(39) + 'U' + char(39) + ') and name like ' + char(39) + 'CC%' + char(39)
				
		EXEC SP_EXECUTESQL @sql

		UPDATE TblAspelCfg SET Sistema = 'COI'

		DELETE
		FROM TblAspelCfg
		WHERE tabla IS NULL
		OR tabla like '%.DB'

		UPDATE TblAspelCfg
		SET Sistema = 'COI'
		WHERE Sistema IS NULL

		SELECT Tabla, SUBSTRING(Tabla,5,2) + MAX(SUBSTRING(Tabla,3,2)) PeriodoEjercicio
		INTO #MaxCat
		FROM TblAspelCfg
		WHERE SUBSTRING(Tabla,1,2) = 'CC'
		AND SUBSTRING(Tabla,1,4) <> 'CC99'
		GROUP BY Tabla

		SELECT @MaxPer = MAX(PeriodoEjercicio)
		FROM #MaxCat
		
		SELECT @TablaCat = Tabla
		FROM #MaxCat
		WHERE PeriodoEjercicio = @MaxPer

		DECLARE COI CURSOR FOR
		SELECT Tabla
		FROM TblAspelCfg
		WHERE Sistema = 'COI' AND Tabla IS NOT NULL

		OPEN COI
		FETCH NEXT FROM COI INTO @TablaCursor

		WHILE @@FETCH_STATUS <> -1
		BEGIN
			IF ISNUMERIC(RIGHT(@TablaCursor, 2)) = 1
				SET @TablaEmp = left(@TablaCursor, len(@TablaCursor) - 2) + '01'
			ELSE
				SET @TablaEmp = left(@TablaCursor, len(@TablaCursor) - 1) + '1'
			
			IF (@Origen = 'Paradox' or @Origen = 'Access') AND (@TablaCursor IS NOT NULL)
			BEGIN
				SET @sql = 'SELECT * INTO '+@Bdatos+'.dbo.'+@TablaEmp+' FROM OPENROWSET('+@CS+','+@TablaCursor+') '
			END

			IF @Origen = 'SQL' AND @TablaCursor IS NOT NULL
			BEGIN
				SET @Sql = 'SELECT * INTO '+@Bdatos+'..'+@TablaEmp+' FROM '+@SrvOrigen+'.'+@BDOrigen+'.dbo.'+@TablaCursor
			END
			
			EXEC SP_EXECUTESQL @sql
			
			INSERT INTO AspelLog VALUES ('COI',@TablaCursor, GetDate())
			FETCH next FROM COI INTO @TablaCursor
		END
		
		CLOSE COI
		DEALLOCATE COI
		

		SET @Sql = ' SELECT num_cta, Nombre, Status, Tipo, LTRIM(cta_Papa) Rama,' 
		+ 'CASE WHEN DEPTSINO =' + CHAR(39) + 'S' + CHAR(39) + 'THEN ' + CHAR(39) + '1' + char(39) + ' ELSE ' + CHAR(39) + '0' + CHAR(39) 
		+ ' END AS DEPTSINO,'
		+ ' CASE WHEN ltrim(rtrim(NATURALEZA)) =' + CHAR(39) + '0' + CHAR(39) + 'THEN ' + CHAR(39) + '0' + char(39) + ' ELSE ' + CHAR(39) + '1' + CHAR(39) 		
		+ ' END AS NATURALEZA '
		+ ' INTO '+@BDatos+'.dbo.CUENTAS '
		+ ' FROM ' + @BDatos + '.dbo.' + @TablaCat +' '
--		+ ' FROM OPENROWSET('+@CS+','+@TablaCat+') '
		EXEC Sp_executeSql @Sql
		INSERT INTO AspelLog VALUES ('COI',@TablaCat, GetDate())
		
		-- Saldo iniciales --
		-- Creamos vista para poder insertar Poliza de Saldos inciales		
		SELECT @Cuenta = COUNT(*) FROM TblAspelCfg
		WHERE Sistema = 'COI'

		SET @Sql =  ''

		IF @Cuenta = 1
		BEGIN
			SELECT @TablaCat = Tabla FROM TblAspelCfg
			WHERE Sistema = 'COI'

			SET @Sql = 'Select DISTINCT NUM_CTA, INICONTAB, ' + CHAR(39) + @TablaCat + CHAR(39) + ' Tabla '
			+ 'FROM ' + @SrvOrigen + '.' + @BDOrigen + '.dbo.' + @TablaCat + ' '
			--+ 'Order By NUM_CTA, Tabla'
		END
						
		IF @Cuenta > 1
		BEGIN
			DECLARE cur_Tablas CURSOR FOR
			SELECT Tabla FROM TblAspelCfg
			WHERE Sistema = 'COI'

			OPEN cur_Tablas
			FETCH NEXT FROM cur_Tablas INTO @TablaCat

			WHILE @@FETCH_STATUS <> -1
			BEGIN
				SET @Sql = @Sql + 'Select DISTINCT NUM_CTA, INICONTAB, ' + CHAR(39) + @TablaCat + CHAR(39) + ' Tabla '
				+ 'FROM ' + @SrvOrigen + '.' + @BDOrigen + '.dbo.' + @TablaCat + ' '
				+ 'UNION ALL '

				FETCH NEXT FROM cur_Tablas INTO @TablaCat
			END
		
			SET @Sql = SUBSTRING(@Sql, 1, LEN(@Sql) - 10)
			SET @Sql = @Sql + ' Order By NUM_CTA, Tabla '

			CLOSE cur_Tablas
			DEALLOCATE cur_Tablas
		END
		
		SELECT Tabla, SUBSTRING(Tabla,5,2) + MIN(SUBSTRING(Tabla,3,2)) PeriodoEjercicio
		INTO #MinCat
		FROM TblAspelCfg
		WHERE SUBSTRING(Tabla,1,2) = 'CC'
		GROUP BY Tabla

		SELECT @MinPer = MIN(PeriodoEjercicio)
		FROM #MinCat

		SELECT @TablaCat = Tabla
		FROM #MinCat
		WHERE PeriodoEjercicio = @MinPer
		
		SET @Sql = 'INSERT INTO PASO_CTAS(Cuenta, Nombre, SaldoIni, Naturaleza, Periodo, DEPTSINO) '
		+ 'SELECT NUM_CTA, NOMBRE, INICONTAB, NATURALEZA, ' + char(39) + @MinPer  + char(39) + ', DEPTSINO FROM ' + @SrvOrigen + '.' + @BDOrigen + '.dbo.' + @TablaCat + ' '
		+ 'WHERE INICONTAB <> 0 AND STATUS = ' + CHAR(39) + 'A' + CHAR(39) + ' AND TIPO = ' + CHAR(39) + 'D' + CHAR(39)
			
		EXEC Sp_executeSql @Sql	

		SET @TablaCatD = 'CD' + substring(@TablaCat, 3, 6)
		
		SET @Sql = 'INSERT INTO PASO_CTASD(Cuenta, Nombre, SaldoIni, Naturaleza, DEPTO) '
		+ 'SELECT O.NUM_CTA, O.NOMBRE, D.SLDINIMC, O.NATURALEZA, D.NUMDEPTO ' 
		+ 'FROM ' + @SrvOrigen + '.' + @BDOrigen + '.dbo.' + @TablaCat + ' AS O INNER JOIN '
		+ @SrvOrigen + '.' + @BDOrigen + '.dbo.' + @TablaCatD + ' AS D ON O.NUM_CTA = D.DEPCTA '
		+ 'WHERE O.INICONTAB <> 0 AND O.STATUS = ' + CHAR(39) + 'A' + CHAR(39) + ' AND O.TIPO = ' + CHAR(39) + 'D' + CHAR(39)
		+' AND O.DEPTSINO = ' + CHAR(39) + 'S' + CHAR(39)
		
		EXEC Sp_executeSql @Sql	


	END
	
SET ANSI_NULLS OFF
SET ANSI_WARNINGS OFF
END
GO

/***********fnAspelSaldoTotalCuentas***********/
IF EXISTS (SELECT * FROM SysObjects WHERE Id=OBJECT_ID('fnAspelSaldoTotalCuentas') AND Type='FN') 
DROP FUNCTION fnAspelSaldoTotalCuentas
GO
CREATE FUNCTION  fnAspelSaldoTotalCuentas
				  (
                   @Cuenta		varchar(20)
                  ) 
RETURNS money
AS 
BEGIN
DECLARE	@Salida				money,
		@Formato			varchar(30),
		@SubCuenta			varchar(20)

  
  SET @Salida = 0.0
    
  SELECT @Formato = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Formato Cuentas Contables'

  DECLARE crSubCuentas CURSOR FOR
  	SELECT dbo.fnAspelFormateaCuentas(Valor,@Formato)
  	  FROM AspelCargaProp  
	 WHERE dbo.fnAspelFormateaCuentas(Rama,@Formato) = @Cuenta

  OPEN crSubCuentas
  FETCH NEXT FROM crSubCuentas INTO @SubCuenta
  WHILE (@@FETCH_STATUS <> -1) AND (@@FETCH_STATUS <> -2)
    BEGIN 
      SET @Salida = @Salida + dbo.fnAspelSaldoTotalCuentas(@SubCuenta)
	  FETCH NEXT FROM crSubCuentas INTO @SubCuenta
    END
  CLOSE crSubCuentas
  DEALLOCATE crSubCuentas

  SELECT @Salida = @Salida + ISNULL(Saldo,0.0) FROM AspelCuentasTotal WHERE dbo.fnAspelFormateaCuentas(Mayor,@Formato) = @Cuenta

  RETURN @Salida
END
GO

/***********fnAspelObtieneSaldoAspelRubro***********/
IF EXISTS (SELECT * FROM SysObjects WHERE Id=OBJECT_ID('fnAspelObtieneSaldoAspelRubro') AND Type='FN') 
DROP FUNCTION fnAspelObtieneSaldoAspelRubro
GO

CREATE FUNCTION fnAspelObtieneSaldoAspelRubro
					(
					 @Rubro		varchar(50)
					)
RETURNS money
AS 
BEGIN
  DECLARE	@Formato	varchar(30),
			@Cuenta		varchar(20),
			@Salida		money

  SET @Salida = 0.0
  SELECT @Formato = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Formato Cuentas Contables'


  DECLARE crCuentasRubro CURSOR FOR
   SELECT dbo.fnAspelFormateaCuentas(A.Valor,@Formato) FROM AspelCargaProp A JOIN AspelCargaProp B 
       ON A.ValorNumero = B.ValorNumero 
    WHERE A.Campo = 'RubroCuentaB' AND B.Campo = 'Rubro' AND B.Valor = @Rubro

  OPEN crCuentasRubro
  FETCH NEXT FROM crCuentasRubro INTO @Cuenta
  WHILE (@@FETCH_STATUS <> -1) AND (@@FETCH_STATUS <> -2)
    BEGIN 
      SET @Salida = @Salida + dbo.fnAspelSaldoTotalCuentas(@Cuenta)
	  FETCH NEXT FROM crCuentasRubro INTO @Cuenta
    END
  CLOSE crCuentasRubro
  DEALLOCATE crCuentasRubro

  RETURN @Salida
END
GO

/***********AspelSeriesTotal***********/
IF EXISTS(SELECT * FROM sysobjects WHERE id=OBJECT_ID('AspelSeriesTotal') AND XType = 'V') 
DROP VIEW AspelSeriesTotal
GO

CREATE VIEW AspelSeriesTotal AS 
SELECT Articulo, 
ISNULL(COUNT(Articulo),0) Series 
FROM AspelCargaProp
WHERE Campo = 'Serie'
GROUP BY Articulo
GO

/***********spAspelBorraPropReg***********/
IF EXISTS(SELECT * FROM SysObjects WHERE Id=OBJECT_ID('spAspelBorraPropReg') AND Type='P') 
DROP PROC spAspelBorraPropReg
GO

CREATE PROCEDURE  spAspelBorraPropReg
--//WITH ENCRYPTION
AS 
BEGIN
   TRUNCATE TABLE AspelCargaProp
   TRUNCATE TABLE AspelCargaReg

   UPDATE Aspel_Paso SET
   IntegracionVisor = 0
END
GO

/*************** Migracion SAE ****************/
/*********** FnStatus ************/
IF EXISTS(SELECT * FROM sysobjects WHERE ID = OBJECT_ID('dbo.fnAspelStatus')AND TYPE = 'FN')
DROP FUNCTION dbo.fnAspelStatus 
GO
CREATE FUNCTION dbo.fnAspelStatus(@Entrada varchar(5))
RETURNS char(20)
AS 
BEGIN
DECLARE
@Salida varchar(30)
SELECT  @Salida = CASE @ENTRADA WHEN 'A' THEN 'Activo' END 

RETURN @Salida
END
GO


/*************** Migracion SAE ****************/
/*********** FnAspelConversion ************/
IF EXISTS (SELECT * FROM sysobjects WHERE ID = OBJECT_ID('dbo.fnAspelConversion')AND TYPE = 'FN')
DROP FUNCTION dbo.fnAspelConversion 
GO
CREATE FUNCTION dbo.fnAspelConversion
				(
                 @Tabla		varchar(30),
                 @Campo		varchar(30),
				 @Valor		varchar(30)
                )

RETURNS varchar(30)
AS 
BEGIN
DECLARE
		@Salida			varchar(30),
		@Cadena			varchar(100)

SET @Cadena = RTRIM(@Tabla) + RTRIM(@Campo) + RTRIM(@Valor)
 
SET @Salida = NULL
SELECT  @Salida = 
CASE WHEN @Cadena = 'INVE01STATUSA'			THEN 'ALTA' 
     WHEN @Cadena = 'INVE01STATUSA'			THEN 'BAJA' 
     WHEN @Cadena = 'INVE01UNI_MEDpz'		THEN 'Piezas'
     WHEN @Cadena = 'INVE01NUM_SERIEN'		THEN 'Normal'
     WHEN @Cadena = 'INVE01NUM_SERIES'		THEN 'Serie'
     WHEN @Cadena = 'INVE01TIP_COSTEOP'		THEN 'Promedio'
     WHEN @Cadena = 'INVE01TIP_COSTEOI'		THEN 'Reposicion'
     WHEN @Cadena = 'INVE01TIP_COSTEOE'		THEN 'PEPS'
     WHEN @Cadena = 'INVE01TIP_COSTEOS'		THEN 'Estandar'
     WHEN @Cadena = 'INVE01TIP_COSTEOU'		THEN 'UEPS'
     WHEN @Cadena = 'VEND01STATUSA'			THEN 'ALTA'
     WHEN @Cadena = 'VEND01STATUSB'			THEN 'BAJA'
     WHEN @Cadena = 'CLIE01STATUSA'			THEN 'ALTA'
     WHEN @Cadena = 'CLIE01STATUSS'			THEN 'BAJA'
     WHEN @Cadena = 'PROV01STATUSA'			THEN 'ALTA'
     WHEN @Cadena = 'PROV01STATUSS'			THEN 'BLOQUEADO'
     WHEN @Cadena = 'MULT01STATUSA'			THEN 'ALTA'
	 WHEN @Cadena = 'CUENTASStatusA'		THEN 'ALTA'
	 WHEN @Cadena = 'POLIZASTIPO_POLIDr'	THEN 'Diario'
	 WHEN @Cadena = 'POLIZASTIPO_POLIIg'	THEN 'Ingresos'
	 WHEN @Cadena = 'POLIZASTIPO_POLIEg'	THEN 'Egresos'
END

RETURN @Salida
END 
GO

/*********** fnAspelSetRama ************/
IF EXISTS (SELECT * FROM sysobjects WHERE ID = OBJECT_ID('dbo.fnAspelSetRama')AND TYPE = 'FN')
DROP FUNCTION dbo.fnAspelSetRama 
GO
CREATE FUNCTION dbo.fnAspelSetRama
				(
                 @Numero	int
                )

RETURNS varchar(30)
AS 
BEGIN
DECLARE
		@Salida			varchar(30)
 
SET @Salida = NULL
SELECT  @Salida = 
CASE WHEN @Numero = 1  THEN 'C' 
     WHEN @Numero = 2  THEN 'D' 
     WHEN @Numero = 3  THEN 'I' 
     WHEN @Numero = 4  THEN 'J' 
     WHEN @Numero = 5  THEN 'Q' 
     WHEN @Numero = 6  THEN 'S' 
     WHEN @Numero = 7  THEN 'T' 
     WHEN @Numero = 8  THEN 'U' 
     WHEN @Numero = 9  THEN 'U2' 
     WHEN @Numero = 10 THEN 'U3' 

END 


RETURN @Salida
END
GO

/*********** dbo.AspelCfg ************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.AspelCfg') AND TYPE = 'U')
CREATE TABLE dbo.AspelCfg
(
   Valor varchar(30),
   Descripcion varchar(50)
)
GO
DELETE FROM AspelCfg
INSERT INTO AspelCfg (Valor, Descripcion) VALUES ('0', 'Sucursal')
INSERT INTO AspelCfg (Valor, Descripcion) VALUES ('DEMO', 'Empresa')
INSERT INTO AspelCfg (Valor, Descripcion) VALUES ('Saldos/Estadisticas', 'Tipo')
INSERT INTO AspelCfg (Valor, Descripcion) VALUES ('Aspel', 'Observaciones')
INSERT INTO AspelCfg (Valor, Descripcion) VALUES ('Pesos', 'Moneda')
INSERT INTO AspelCfg (Valor, Descripcion) VALUES ('DEMO', 'Usuario')
GO

/*********** dbo.AspelCfgCatalogo ************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.AspelCfgCatalogo') AND TYPE = 'U')
CREATE TABLE dbo.AspelCfgCatalogo
(
   Catalogo varchar(30)		NULL,
   Insertar bit				NULL,
)
GO
DELETE FROM AspelCfgCatalogo
INSERT INTO AspelCfgCatalogo (Catalogo, Insertar) VALUES ('Agente', 1)
INSERT INTO AspelCfgCatalogo (Catalogo, Insertar) VALUES ('Articulo', 1)
INSERT INTO AspelCfgCatalogo (Catalogo, Insertar) VALUES ('Cliente', 1)
INSERT INTO AspelCfgCatalogo (Catalogo, Insertar) VALUES ('Moneda', 1)
INSERT INTO AspelCfgCatalogo (Catalogo, Insertar) VALUES ('Proveedor', 1)
INSERT INTO AspelCfgCatalogo (Catalogo, Insertar) VALUES ('Almacen', 1)
INSERT INTO AspelCfgCatalogo (Catalogo, Insertar) VALUES ('Serie', 1)
INSERT INTO AspelCfgCatalogo (Catalogo, Insertar) VALUES ('Cuenta', 1)
INSERT INTO AspelCfgCatalogo (Catalogo, Insertar) VALUES ('Unidad', 1)
GO

/*********** dbo.AspelCfgMovimiento ************/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.AspelCfgMovimiento') AND TYPE = 'U')
CREATE TABLE dbo.AspelCfgMovimiento
(
   Movimiento varchar(30)	NULL,
   Insertar bit				NULL,
)
GO

DELETE FROM AspelCfgMovimiento
INSERT INTO AspelCfgMovimiento (Movimiento, Insertar) VALUES ('Venta', 1)
INSERT INTO AspelCfgMovimiento (Movimiento, Insertar) VALUES ('Compra', 1)
INSERT INTO AspelCfgMovimiento (Movimiento, Insertar) VALUES ('Cxc', 1)
INSERT INTO AspelCfgMovimiento (Movimiento, Insertar) VALUES ('Cxp', 1)
INSERT INTO AspelCfgMovimiento (Movimiento, Insertar) VALUES ('Inventario', 1)
INSERT INTO AspelCfgMovimiento (Movimiento, Insertar) VALUES ('Poliza', 1)
GO

/*********** dbo.AspelMcCarga ************/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.AspelMcCarga') AND Type='U') 
  DROP TABLE AspelMcCarga
GO
CREATE TABLE AspelMcCarga 
(
    GID				uniqueidentifier,
	RID				int 			NOT NULL	IDENTITY(1,1),
	Empresa			varchar(5)		NULL,
	Sucursal		int				NULL,
	Usuario			varchar(10)		NULL,
	Posicion		varchar(20)		NULL,
	FechaEmision	datetime		NULL,
	Observaciones	varchar(100)	NULL,
	Tipo			varchar(20)		NULL,
	Estatus			varchar(20)		NULL,
	CONSTRAINT pk_AspelMcCarga PRIMARY KEY CLUSTERED (GID)
)
GO

/******* SpAspelActualizaCostoSerie ********/
IF EXISTS (SELECT * FROM SysObjects WHERE Id=OBJECT_ID('SpAspelActualizaCostoSerie') AND Type='P') 
DROP PROC SpAspelActualizaCostoSerie
GO

CREATE PROCEDURE  SpAspelActualizaCostoSerie
				 (
				  @Articulo				varchar(50),
				  @Almacen				varchar(20),
				  @Costo				float(15)
				 )
--//WITH ENCRYPTION
AS BEGIN
  UPDATE AspelCargaProp SET Costo = @Costo
   WHERE Articulo = @Articulo AND Almacen = @Almacen AND Campo = 'Serie' AND ISNULL(Costo,0) = 0 
END
GO


/******* SpAspelInsertaSerie ********/
IF EXISTS (SELECT * FROM SysObjects WHERE Id=OBJECT_ID('SpAspelInsertaSerie') AND Type='P') 
DROP PROC SpAspelInsertaSerie
GO

CREATE PROCEDURE  SpAspelInsertaSerie
				 (
				  @Articulo				varchar(50)
				 )
--//WITH ENCRYPTION
AS BEGIN
  DECLARE	@CargaGID uniqueidentifier

  SELECT @CargaGID = CargaGID FROM AspelCargaProp WHERE Campo = 'Articulo' AND Valor = @ARTICULO
  IF @CargaGID IS NOT NULL
    INSERT AspelCargaProp (CargaGID, Articulo, Campo, Valor)
           VALUES (@CargaGID, @Articulo, 'Serie', '(vacio)')
END
GO


/***********spGeneraAspelPolizaAjuste***********/
IF EXISTS(SELECT * FROM SysObjects WHERE Id=OBJECT_ID('spGeneraAspelPolizaAjuste') AND Type='P') 
DROP PROC spGeneraAspelPolizaAjuste
GO

CREATE PROCEDURE  spGeneraAspelPolizaAjuste
--//WITH ENCRYPTION
AS BEGIN
DECLARE	@SaldoVentas			money,
		@SaldoCompras			money,
		@SaldoClientes			money,
		@SaldoProveedores		money,
		@SaldoInventarios		money,
		@AuxiliarVentas			money,
		@AuxiliarCompras		money,
		@AuxiliarClientes		money,
		@AuxiliarProveedores	money,
		@AuxiliarInventarios	money,
		@Rubro					varchar(50),
		@SaldoAjuste			money,
		@CuentaVentas			varchar(20),
		@CuentaCompras			varchar(20),
		@CuentaClientes			varchar(20),
		@CuentaProveedores		varchar(20),
		@CuentaInventarios		varchar(20),
		@CuentaAjuste			varchar(20),
		@ConfS					int,
		@ConfE					varchar(30),
		@ConfU					varchar(30),
		@Obsrv					varchar(30),
		@Moneda					varchar(30),
		@FechaEmision			datetime

  IF EXISTS(SELECT Valor FROM AspelCfgOpcion WHERE Descripcion = 'Generar Poliza De Ajuste' AND Valor = 'No') RETURN 

  DELETE FROM AspelCargaReg WHERE Modulo = 'AJUST'

  SET @FechaEmision = CONVERT(DATETIME,CONVERT(varchar(10),GETDATE(),126),126)

  SELECT @Rubro = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Rubro Ventas'
  SET @SaldoVentas      = dbo.fnAspelObtieneSaldoRubro(@Rubro)
  SELECT @Rubro = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Rubro Compras'
  SET @SaldoCompras     = dbo.fnAspelObtieneSaldoRubro(@Rubro)
  SELECT @Rubro = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Rubro Clientes'
  SET @SaldoClientes    = dbo.fnAspelObtieneSaldoRubro(@Rubro)
  SELECT @Rubro = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Rubro Proveedores'
  SET @SaldoProveedores = dbo.fnAspelObtieneSaldoRubro(@Rubro)
  SELECT @Rubro = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Rubro Inventarios'
  SET @SaldoInventarios = dbo.fnAspelObtieneSaldoRubro(@Rubro)

  SET @SaldoAjuste = @SaldoVentas + @SaldoCompras + @SaldoClientes + @SaldoProveedores + @SaldoInventarios

  --Trae el importe de los auxiliares de ventas
  SELECT @AuxiliarVentas = SUM(CASE WHEN ISNULL(DEBE,0) <> 0 THEN 0-ISNULL(DEBE,0)+ISNULL(HABER,0) ELSE ISNULL(DEBE,0)+ISNULL(HABER,0) END 
         * (1+(AspelVentas.Impuesto1/100)) * (1+(AspelVentas.Impuesto2/100)) * (1+(AspelVentas.Impuesto3/100)))
    FROM AspelCargaReg AspelVentas LEFT OUTER JOIN AspelCargaProp AspelClientes ON AspelVentas.Cliente=AspelClientes.Valor
   WHERE AspelClientes.Campo = 'Cliente'

  --Trae el importe de los auxiliares de compras
  SELECT @AuxiliarCompras = SUM((ISNULL(DEBE,0)-ISNULL(HABER,0)) * (1+(ISNULL(Impuesto1,0)/100))
         * (1+(ISNULL(Impuesto2,0)/100)) * (1+(ISNULL(Impuesto3,0)/100))) 
    FROM AspelCargaReg
   WHERE Modulo = 'COMS'

  --Trae el importe de los auxiliares de Cuentas por Cobrar
  SELECT @AuxiliarClientes = SUM(ISNULL(Debe,0)-ISNULL(Haber,0))
    FROM AspelCargaReg 
   WHERE Modulo = 'CXC'

  --Trae el importe de los auxiliares de proveedores
  SELECT @AuxiliarProveedores = SUM(ISNULL(Debe,0)+ISNULL(Haber,0))
    FROM AspelCargaReg 
   WHERE Modulo = 'CXP'

  --Trae el importe de los auxiliares de inventarios
  SELECT @AuxiliarInventarios = SUM(ISNULL(Cantidad,0)*ISNULL(Costo,0))
    FROM AspelCargaReg 
   WHERE Modulo = 'INV'

  SELECT @CuentaVentas      = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Cuenta Ventas'
  SELECT @CuentaCompras     = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Cuenta Compras'
  SELECT @CuentaClientes    = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Cuenta Clientes'
  SELECT @CuentaProveedores = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Cuenta Proveedores'
  SELECT @CuentaInventarios = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Cuenta Inventarios'
  SELECT @CuentaAjuste      = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Cuenta Ajuste'

  SELECT @ConfS   = Valor FROM AspelCfg WHERE Descripcion = 'Sucursal'
  SELECT @ConfE   = Valor FROM AspelCfg WHERE Descripcion = 'Empresa' 
  SELECT @ConfU   = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'
  SELECT @Obsrv   = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'
  SELECT @Moneda  = Valor FROM AspelCfg WHERE Descripcion = 'Moneda'

  --Ventas
  INSERT AspelCargaReg(GID, CargaGID, Modulo,Empresa,Sucursal, Mayor, Mov, MovID, TipoCambio, FechaEmision, Debe, Haber, Concepto, Estatus) 
  VALUES (NewID(), NewID(), 'AJUST', @ConfE, @ConfS, @CuentaVentas, 'Diario', '1', 1, @FechaEmision, 
          CASE WHEN @AuxiliarVentas - @SaldoVentas < 0 THEN ABS(@AuxiliarVentas - @SaldoVentas) ELSE 0 END,
          CASE WHEN @AuxiliarVentas - @SaldoVentas >= 0 THEN ABS(@AuxiliarVentas - @SaldoVentas) ELSE 0 END,          
		  @Obsrv, 'SINAFECTAR')	
  INSERT AspelCargaReg(GID, CargaGID, Modulo,Empresa,Sucursal, Mayor, Mov, MovID, TipoCambio, FechaEmision, Debe, Haber, Concepto, Estatus) 
  VALUES (NewID(), NewID(), 'AJUST', @ConfE, @ConfS, @CuentaAjuste, 'Diario', '1', 1, @FechaEmision, 
          CASE WHEN @AuxiliarVentas - @SaldoVentas < 0 THEN 0 ELSE ABS(@AuxiliarVentas - @SaldoVentas) END,
          CASE WHEN @AuxiliarVentas - @SaldoVentas >= 0 THEN 0 ELSE ABS(@AuxiliarVentas - @SaldoVentas) END,          
		  @Obsrv, 'SINAFECTAR')	

  --Compras
  INSERT AspelCargaReg(GID, CargaGID, Modulo,Empresa,Sucursal, Mayor, Mov, MovID, TipoCambio, FechaEmision, Debe, Haber, Concepto, Estatus) 
  VALUES (NewID(), NewID(), 'AJUST', @ConfE, @ConfS, @CuentaCompras, 'Diario', '1', 1, @FechaEmision, 
          CASE WHEN @AuxiliarCompras - @SaldoCompras < 0 THEN ABS(@AuxiliarCompras - @SaldoCompras) ELSE 0 END,
          CASE WHEN @AuxiliarCompras - @SaldoCompras >= 0 THEN ABS(@AuxiliarCompras - @SaldoCompras) ELSE 0 END,          
		  @Obsrv, 'SINAFECTAR')	
  INSERT AspelCargaReg(GID, CargaGID, Modulo,Empresa,Sucursal, Mayor, Mov, MovID, TipoCambio, FechaEmision, Debe, Haber, Concepto, Estatus) 
  VALUES (NewID(), NewID(), 'AJUST', @ConfE, @ConfS, @CuentaAjuste, 'Diario', '1', 1, @FechaEmision, 
          CASE WHEN @AuxiliarCompras - @SaldoCompras < 0 THEN 0 ELSE ABS(@AuxiliarCompras - @SaldoCompras) END,
          CASE WHEN @AuxiliarCompras - @SaldoCompras >= 0 THEN 0 ELSE ABS(@AuxiliarCompras - @SaldoCompras) END,          
		  @Obsrv, 'SINAFECTAR')	

  --Clientes
  INSERT AspelCargaReg(GID, CargaGID, Modulo,Empresa,Sucursal, Mayor, Mov, MovID, TipoCambio, FechaEmision, Debe, Haber, Concepto, Estatus) 
  VALUES (NewID(), NewID(), 'AJUST', @ConfE, @ConfS, @CuentaClientes, 'Diario', '1', 1, @FechaEmision, 
          CASE WHEN @AuxiliarClientes - @SaldoClientes < 0 THEN ABS(@AuxiliarClientes - @SaldoClientes) ELSE 0 END,
          CASE WHEN @AuxiliarClientes - @SaldoClientes >= 0 THEN ABS(@AuxiliarClientes - @SaldoClientes) ELSE 0 END,          
		  @Obsrv, 'SINAFECTAR')	
  INSERT AspelCargaReg(GID, CargaGID, Modulo,Empresa,Sucursal, Mayor, Mov, MovID, TipoCambio, FechaEmision, Debe, Haber, Concepto, Estatus) 
  VALUES (NewID(), NewID(), 'AJUST', @ConfE, @ConfS, @CuentaAjuste, 'Diario', '1', 1, @FechaEmision, 
          CASE WHEN @AuxiliarClientes - @SaldoClientes < 0 THEN 0 ELSE ABS(@AuxiliarClientes - @SaldoClientes) END,
          CASE WHEN @AuxiliarClientes - @SaldoClientes >= 0 THEN 0 ELSE ABS(@AuxiliarClientes - @SaldoClientes) END,          
		  @Obsrv, 'SINAFECTAR')	

  --Proveedores
  INSERT AspelCargaReg(GID, CargaGID, Modulo,Empresa,Sucursal, Mayor, Mov, MovID, TipoCambio, FechaEmision, Debe, Haber, Concepto, Estatus) 
  VALUES (NewID(), NewID(), 'AJUST', @ConfE, @ConfS, @CuentaProveedores, 'Diario', '1', 1, @FechaEmision, 
          CASE WHEN @AuxiliarProveedores - @SaldoProveedores < 0 THEN ABS(@AuxiliarProveedores - @SaldoProveedores) ELSE 0 END,
          CASE WHEN @AuxiliarProveedores - @SaldoProveedores >= 0 THEN ABS(@AuxiliarProveedores - @SaldoProveedores) ELSE 0 END,          
		  @Obsrv, 'SINAFECTAR')	
  INSERT AspelCargaReg(GID, CargaGID, Modulo,Empresa,Sucursal, Mayor, Mov, MovID, TipoCambio, FechaEmision, Debe, Haber, Concepto, Estatus) 
  VALUES (NewID(), NewID(), 'AJUST', @ConfE, @ConfS, @CuentaAjuste, 'Diario', '1', 1, @FechaEmision, 
          CASE WHEN @AuxiliarProveedores - @SaldoProveedores < 0 THEN 0 ELSE ABS(@AuxiliarProveedores - @SaldoProveedores) END,
          CASE WHEN @AuxiliarProveedores - @SaldoProveedores >= 0 THEN 0 ELSE ABS(@AuxiliarProveedores - @SaldoProveedores) END,          
		  @Obsrv, 'SINAFECTAR')	

  --Inventarios
  INSERT AspelCargaReg(GID, CargaGID, Modulo,Empresa,Sucursal, Mayor, Mov, MovID, TipoCambio, FechaEmision, Debe, Haber, Concepto, Estatus) 
  VALUES (NewID(), NewID(), 'AJUST', @ConfE, @ConfS, @CuentaInventarios, 'Diario', '1', 1, @FechaEmision, 
          CASE WHEN @AuxiliarInventarios - @SaldoInventarios < 0 THEN ABS(@AuxiliarInventarios - @SaldoInventarios) ELSE 0 END,
          CASE WHEN @AuxiliarInventarios - @SaldoInventarios >= 0 THEN ABS(@AuxiliarInventarios - @SaldoInventarios) ELSE 0 END,          
		  @Obsrv, 'SINAFECTAR')	
  INSERT AspelCargaReg(GID, CargaGID, Modulo,Empresa,Sucursal, Mayor, Mov, MovID, TipoCambio, FechaEmision, Debe, Haber, Concepto, Estatus) 
  VALUES (NewID(), NewID(), 'AJUST', @ConfE, @ConfS, @CuentaAjuste, 'Diario', '1', 1, @FechaEmision, 
          CASE WHEN @AuxiliarInventarios - @SaldoInventarios < 0 THEN 0 ELSE ABS(@AuxiliarInventarios - @SaldoInventarios) END,
          CASE WHEN @AuxiliarInventarios - @SaldoInventarios >= 0 THEN 0 ELSE ABS(@AuxiliarInventarios - @SaldoInventarios) END,          
		  @Obsrv, 'SINAFECTAR')	

END
GO

--/********* Indice INDEX DUP_PROP **********/
--IF NOT EXISTS (SELECT * FROM SYSINDEXES WHERE NAME = 'DUP_PROP')
--		CREATE UNIQUE INDEX DUP_PROP ON AspelCargaProp (Campo,Valor,Nombre,Descripcion,RFC) WITH IGNORE_DUP_KEY

GO

/****** spAspelImportarTablasCargaPropReg ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelImportarTablasCargaPropReg]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelImportarTablasCargaPropReg]
GO
CREATE PROCEDURE  [dbo].[spAspelImportarTablasCargaPropReg]
				 (
				  @ServidorOrigen		varchar(20),
				  @ServidorDestino		varchar(20),
				  @BaseDatosOrigen		varchar(20),
				  @BaseDatosDestino		varchar(20),
				  @ImportarCOI			bit
				 )
--//WITH ENCRYPTION
AS BEGIN
SET LOCK_TIMEOUT -1
DECLARE @Link				nvarchar(50),
		@Sql				nvarchar(max),
		@Cuenta				varchar(50),
		@Modulo				varchar(15),
		@Agrupador			varchar(15),
		@CuentaParam		varchar(50),
		@Saldo				money,
		@Parametros			nvarchar(max),
		@CuentaParametro	varchar(50),
		@ConfS				int,
		@ConfE				varchar(30),
		@ConfU				varchar(30),
		@CuentaV			varchar(30),
		@CuentaD			varchar(30),
		@Cte				varchar(30),
		@Prov				varchar(30),
		@Refer				varchar(30),
		@Importe			varchar(30),
		@alm				varchar(30),
		@art				varchar(30),
		@cant				float(30),
		@cost				float(30),
		@Obsrv				varchar(30),
		@Tipo				varchar(30),
		@Estatus			varchar(15),
		@Moneda				varchar(30),
		@GID				uniqueidentifier,
		--ARC
		@Factura			varchar(10),
		@Mon				varchar(20),
		@Descr				varchar(50),
		@TipoCambio			varchar(10),
		@FechaAplicacion	datetime,
		@FechaVencimiento	datetime,
		@TipoMov			varchar(5),
		@Documento			varchar(30),
		@ImporteCargo		float(15),
		@ImporteAbono		float(15),
		@SaldoCx			float(15),
        @Debe				money,
		@Haber				money,
		@CadenaAgrupacion	varchar(255),
		@MovDebe			varchar(20),
		@MovHaber			varchar(20),
		@ImporteCxc			money,
        @CampoImpuesto1		varchar(30),
        @CampoImpuesto2		varchar(30),
        @CampoImpuesto3		varchar(30),
		@Costo				float(15),
	@NumConcep		smallint
		--FIN ARC

  --ARC Para que el primer dia de la semana sea el domingo
  SET DATEFIRST 7

  SET @Sql = ''
  SET @Link = ''

  --SET @ConfS	= ''
  SET @ConfE	= ''
  SET @ConfU	= ''
  SET @Parametros = ''

  --Define un parametro de salida
  SET @Parametros = '@ConfS int OUTPUT'
  --Define una instruccion SQL
  --Toma un valor de la base de datos de la tabla AspelCfg de la base del modulo central donde la descripcion sea sucursal
  --Sirve para decirle al sistema con que sucursal va a crear los documentos.
  SET @Sql = 'SELECT @ConfS = Valor FROM '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfg WHERE Descripcion = ' + CHAR(39) + 'Sucursal' + CHAR(39) 
  EXEC sp_executesql @Sql, @Parametros, @ConfS = @ConfS OUTPUT

  --Sirve para saber con que empresa va a crear los documentos
  SET @Parametros = '@ConfE varchar(30) OUTPUT'
  SET @Sql = 'SELECT @ConfE = Valor FROM '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfg WHERE Descripcion = ' + CHAR(39) + 'Empresa' + CHAR(39)
  EXEC sp_executesql @Sql, @Parametros, @ConfE = @ConfE OUTPUT

  --Sirve para saber con que usuario creara los movimientos
  SET @Parametros = '@ConfU varchar(30) OUTPUT'
  SET @Sql = 'SELECT @ConfU = Valor FROM '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfg WHERE Descripcion = ' + CHAR(39) + 'Usuario' + CHAR(39)
  EXEC sp_executesql @Sql, @Parametros, @ConfU = @ConfU OUTPUT

  --Sirve para saber que texto pondrá en el campo de Observaciones
  SET @Parametros = '@Obsrv varchar(30) OUTPUT'
  SET @Sql = 'SELECT @Obsrv = Valor FROM '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfg WHERE Descripcion = ' + CHAR(39) + 'Observaciones' + CHAR(39) 
  EXEC sp_executesql @Sql, @Parametros, @Obsrv = @Obsrv OUTPUT

  --Sirve para saber el tipo de movimiento que se va a crear, en este caso son saldos y estadisticas
  SET @Parametros = '@Tipo varchar(30) OUTPUT'
  SET @Sql = 'SELECT @Tipo = Valor FROM '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfg WHERE Descripcion = ' + CHAR(39) + 'Tipo' + CHAR(39)
  EXEC sp_executesql @Sql, @Parametros, @Tipo = @Tipo OUTPUT

  --Sirve para saber con que estatus se crearan los movimientos, al parecer todos quedaran en estatus 'SIN AFECTAR'
  SET @Parametros = '@Estatus varchar(30) OUTPUT'
  SET @Sql = 'SELECT @Estatus = Valor FROM ' + @ServidorDestino + '.' + @BaseDatosDestino + 
  '.dbo.AspelCfg WHERE Descripcion = ' + CHAR(39) + 'Estatus' + CHAR(39)
  EXEC sp_executesql @Sql, @Parametros, @Estatus = @Estatus OUTPUT

  --Sirve para saber en que moneda se crearan los movimientos, en este caso es en pesos
  SET @Parametros = '@Moneda varchar(30) OUTPUT'
  SET @Sql = 'SELECT @Moneda = Valor FROM ' + @ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfg WHERE Descripcion = ' + CHAR(39) + 'Moneda' + CHAR(39) 
  EXEC sp_executesql @Sql, @Parametros, @Moneda = @Moneda OUTPUT

  --Genera un ID unico para el registro
  SET @Parametros = '@GID uniqueidentifier OUTPUT'
  SELECT @Sql = 'Select @GID = NEWID()'
  EXEC sp_executesql @Sql, @Parametros, @GID = @GID OUTPUT
  
    --Inserta un registro en la tabla AspelMcCarga con la informacion obtenida de la tabla AspelCfg
    --en esta tabla entra un registro que va a identificar a toda la carga de datos
	SET @Sql = '' 
		+ 'INSERT '+ @ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelMcCarga (GID, Empresa, Sucursal, Usuario, FechaEmision, Observaciones, Tipo, Estatus) ' 
		+ 'VALUES (@GID, @ConfE, @ConfS, @ConfU, Getdate(), @Obsrv, @Tipo, @Estatus)'
    EXEC sp_executeSql @Sql, 
					   N'@GID uniqueidentifier, @ConfE varchar(30), @ConfS varchar(30), @ConfU varchar(30), @Obsrv varchar(30), @Tipo varchar(30), @Estatus varchar(30)',
					   @GID = @GID, 
					   @ConfE = @ConfE,
					   @ConfS = @ConfS, 
					   @ConfU = @ConfU, 
					   @Obsrv = @Obsrv, 
					   @Tipo = @Tipo, 
					   @Estatus = @Estatus

  --Se ubica en la base de datos destino
  SET @Sql = 'USE ' + @BaseDatosDestino
  EXEC sp_executesql @Sql 

  --Verifica si existe el servidor origen y si no lo da de alta como un servidor vinculado.
  IF NOT EXISTS (SELECT NAME FROM sys.servers WHERE NAME = @ServidorOrigen) 
    BEGIN
		SET @Link = 'sp_addlinkedserver ' + char(39) + @ServidorOrigen + char(39) + ', N' + char(39) + 'SQL Server' + char(39)
		EXEC sp_ExecuteSql @Link
	END


	/*********** Carga de Ventas y Devoluciones de Venta ***********/
        --Obtiene la cuenta contable a la cual se van a cargar todas las ventas y devoluciones de venta de aspel
		SET @Cuenta = ''
		SET @Modulo = ''
		SET @Agrupador = ''
		SET @MovDebe = ''
		SET @MovHaber = ''
		SET @Estatus = ''
		SET @Sql = ''
		SET @Parametros = ''
		SET @Parametros = '@Cuenta varchar(30) OUTPUT, @Modulo varchar(15) OUTPUT, @Agrupador varchar(15) OUTPUT, @MovDebe varchar(20) OUTPUT, @MovHaber varchar(20) OUTPUT, @Estatus varchar(15) OUTPUT'
		SET @Sql =  'SELECT '
        + '@Cuenta = MAYOR '
        + ', @Modulo = Modulo '
        + ', @Agrupador = Agrupador '
        + ', @MovDebe = CASE AfectaContabilidad WHEN 1 THEN MovDebeContable ELSE MovDebeNoContable END'
        + ', @MovHaber = CASE AfectaContabilidad WHEN 1 THEN MovHaberContable ELSE MovHaberNoContable END'
        + ', @Estatus = CASE AfectaContabilidad WHEN 1 THEN EstatusContable ELSE EstatusNoContable END '
        + 'FROM '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfgModuloMayor WHERE DESCRIPCION = ' + CHAR(39) + 'Ventas' + CHAR(39) + ''
		EXEC sp_executesql @Sql, @Parametros, 
                           @Cuenta = @Cuenta OUTPUT, 
                           @Modulo = @Modulo OUTPUT, 
                           @Agrupador = @Agrupador OUTPUT, 
                           @MovDebe = @MovDebe OUTPUT,
						   @MovHaber = @MovHaber OUTPUT,
						   @Estatus = @Estatus OUTPUT



---Creo Tabla Temporal
CREATE TABLE #VTAS 
( 	 Mayor		varchar(30)	NULL, 
	 Empresa	varchar(10)	NULL, 
	 Sucursal	int			NULL, 
	 Moneda		varchar(10) NULL, 
	 TipoCambio float(15)	NULL, 
	 Cliente	varchar (6)	NULL, 
	 Almacen	varchar(30)	NULL, 
	 Fecha		datetime	NULL, 
	 Articulo	varchar(20)	NULL, 
	 Cantidad	float(15)	NULL, 
	 Precio		float(15)	NULL, 
	 Impuesto1	float(15)	NULL, 
	 Impuesto2	float(15)	NULL, 
	 Impuesto3	float(15)	NULL, 
	 Descuento1	float(15)	NULL, 
	 DEBE		float(15)	NULL, 
	 HABER		float(15)	NULL,
	 Mov		varchar(20)	NULL,
	 MovID		varchar(20)	NULL,
	 Agente		varchar(10) NULL,
	 DescGlobal	float(15)	NULL,
	 Costo float(15) NULL,
	 Estatus varchar(15) NULL,
	 CLIENTEORIG VARCHAR(5) NULL,
	 AGENTEORIG VARCHAR(5)  NULL
) 

    SELECT @CadenaAgrupacion = CASE @Agrupador
	  WHEN 'Movimiento' THEN 'FACT.FECHA_DOC, FACT.CVE_DOC, '
      WHEN 'Dia'		THEN 'FACT.FECHA_DOC, '
	  WHEN 'Semana'		THEN 'DATEADD(DD, - DATEPART(DW,FACT.FECHA_DOC),DATEADD(WW,1,FACT.FECHA_DOC)), '
      WHEN 'Mes'		THEN 'DATEADD(DD, - DAY(FACT.FECHA_DOC),DATEADD(MM,1,FACT.FECHA_DOC)), '	
      WHEN 'Año'		THEN 'DATEADD(DD, - DATEPART(DY,FACT.FECHA_DOC),DATEADD(YY,1,FACT.FECHA_DOC)), '
      ELSE 'FACT.FECHA_DOC, '
    END

-- El nombre de los campos en SAE es IMPU1, IMPU2, IMPU3 e IMPU4

    SELECT @CampoImpuesto1 = LTRIM(RTRIM(Valor)) FROM AspelCfgOpcion WHERE Descripcion = 'IVA Articulo'
    SELECT @CampoImpuesto2 = LTRIM(RTRIM(Valor)) FROM AspelCfgOpcion WHERE Descripcion = 'IEPS Articulo'
    SELECT @CampoImpuesto3 = LTRIM(RTRIM(Valor)) FROM AspelCfgOpcion WHERE Descripcion = 'Impuesto 3 Articulo'

	SET @CampoImpuesto3 = CASE @CampoImpuesto3
		WHEN 'IMPU2+IMPU3' THEN 'PART.TOTIMP2+PART.TOTIMP3' 
		WHEN 'IMPU1+IMPU2' THEN 'PART.TOTIMP1+PART.TOTIMP2'   		
		WHEN 'IMPU3+IMPU4' THEN 'PART.TOTIMP3+PART.TOTIMP4' 
  		WHEN 'IMPU3+IMPU2' THEN 'PART.TOTIMP3+PART.TOTIMP2' 
	END


	SET @Sql = '' 
	+ CASE 
        WHEN @Agrupador = 'Movimiento' THEN 'INSERT #VTAS (MovID, TipoCambio,Cliente,Agente,Almacen,Fecha,Articulo,Cantidad,Precio,Impuesto1,Impuesto2,Impuesto3,Descuento1,DEBE,HABER, Mov, Moneda, DescGlobal, Costo, Estatus, clienteorig, agenteorig) '
        ELSE 'INSERT #VTAS  (TipoCambio,Cliente,Agente,Almacen,Fecha,Articulo,Cantidad,Precio,Impuesto1,Impuesto2,Impuesto3,Descuento1,DEBE,HABER, Mov, Moneda, DescGlobal, Costo) ' END
	+ 'SELECT  '
    + CASE WHEN @Agrupador = 'Movimiento' THEN 'MovID = dbo.fnAspelJustificadocto(LTRIM(RTRIM(FACT.CVE_DOC))), ' ELSE '' END
	+ 'TipoCambio	=	ROUND(FACT.TIPCAMB,5), '
	+ 'Cliente		=	dbo.fnAspelJustificaClave(LTRIM(RTRIM(FACT.CVE_CLPV))),  '
	+ 'Agente		=	dbo.fnAspelJustificaClave(LTRIM(RTRIM(FACT.CVE_VEND))),  '
	+ 'Almacen		=	FACT.NUM_ALMA, '
	+ 'Fecha		= ' + CASE WHEN @Agrupador = 'Movimiento' THEN 'FACT.FECHA_DOC, ' ELSE @CadenaAgrupacion END	
	+ 'Articulo		=   PART.CVE_ART, '
    + 'Cantidad		=	SUM(CANT), '
	+ 'Precio		=	PREC / PART.TIP_CAM, '
	+ 'Impuesto1	= ' + @CampoImpuesto1 + ', '
	+ 'Impuesto2	= ' + @CampoImpuesto2 + ', '
	+ 'Impuesto3	= ' + @CampoImpuesto3 + ', '	--PART.TOTIMP3, ' --  + @CampoImpuesto3 + ', ' El impuesto 3 debe pasar en valor
	+ 'Descuento1	= dbo.fn_AspelDescuentoEnCascada(PART.DESC1, PART.DESC2, PART.DESC3), '
	+ 'DEBE			=	CASE WHEN FACT.TIP_DOC = ' + CHAR(39) + 'D' + CHAR(39) + ' THEN (SUM((PART.PREC-(PART.PREC*(PART.DESC1/100)))*PART.CANT)) / PART.TIP_CAM ELSE 0 END, ' 
	+ 'HABER		=	CASE WHEN FACT.TIP_DOC = ' + CHAR(39) + 'F' + CHAR(39) + ' THEN (SUM((PART.PREC-(PART.PREC*(PART.DESC1/100)))*PART.CANT)) / PART.TIP_CAM ELSE 0 END, '
    + 'Mov			=	CASE WHEN FACT.TIP_DOC = ' + CHAR(39) + 'D' + CHAR(39) + ' THEN ' + CHAR(39) + @MovDebe + CHAR(39) + ' ELSE ' + CHAR(39) + @MovHaber + CHAR(39) + ' END, '
	+ 'Moneda		=	LEFT(MONED.DESCR,10), ' 
	+ 'DescGlobal = CASE WHEN FACT.DES_FIN <> 0 THEN (FACT.DES_FIN * 100 / FACT.CAN_TOT) ELSE 0 END,  '	-- EN PORCENTAJE DESCUENTO FINANCIERO SAE 0 DESC. GLOBAL INTELISIS
	+ 'Costo		=	PART.COST, ' 
	+ 'Estatus		= FACT.STATUS, '
	+ 'CLIENTEORIG  = LTRIM(RTRIM(FACT.CVE_CLPV)), '
	+ 'AGENTEORIG   = LTRIM(RTRIM(FACT.CVE_VEND)) '        
	+ 'FROM '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.FACT01 FACT  ' --FACTURA
    + 'LEFT JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.CLIE01 CLIE ON CLIE.CCLIE = FACT.CVE_CLPV ' --CLIENTES	
    + 'INNER JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.FA0TY1 PART ON FACT.CVE_DOC = PART.CVE_DOC AND FACT.TIP_DOC = PART.TIP_DOC AND PART.TIPO_PROD <> ' + char(39) + 'K' + char(39) + ' ' --PARTIDAS
	+ 'INNER JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.MONED01 MONED ON FACT.NUM_MONED = MONED.NUM_MONED ' --Monedas

	+ 'WHERE FACT.TIP_DOC IN (' + CHAR(39) + 'F' + CHAR(39) + ',' + CHAR(39) + 'D' + CHAR(39) + ') ' --SOLO TRAE FACTURAS Y DEVOLUCIONES
	+ 'AND PART.TIPO_PRODT IN (' + CHAR(39) + 'I' + CHAR(39) + ',' + CHAR(39) + ' ' + CHAR(39) + ')'--SOLO PASAN LOS PRODUCTOS NORMALES ES DECIR QUE NO TIENEN COMPONENTES. El espacio en blanco es para versiones anteriores de SAE
	--+ 'AND FACT.STATUS <> ' + CHAR(39) + 'C' + CHAR(39) + ' ' --NO PASAN LAS FACTURAS CANCELADAS
	+ 'GROUP BY FACT.CVE_CLPV, FACT.NUM_ALMA, ' + @CadenaAgrupacion + ' PART.CVE_ART, PREC, DESC1, DESC2, DESC3, ' + @CampoImpuesto1 + ',' + @CampoImpuesto2 + ',' + @CampoImpuesto3 + ', TIPCAMB, PART.TIP_CAM, FACT.NUM_MONED, FACT.TIP_DOC, FACT.CVE_VEND, MONED.DESCR, FACT.DES_FIN, FACT.CAN_TOT, FACT.STATUS,TOTIMP3,PART.COST,FACT.STATUS ' --AGRUPA TODOS LOS MOVIMIENTOS SIMILARES PARA TRAERLOS CONCENTRADOS
	
    EXEC Sp_ExecuteSql @Sql
    
    IF @@ERROR <> 0
      RAISERROR('Falla al insertar en la tabla temporal de ventas',16,1)



	-- Si la factura tiene fletes, los anexa 

	SET @Sql = '' 
	+ CASE 
        WHEN @Agrupador = 'Movimiento' THEN 'INSERT #VTAS (MovID, TipoCambio,Cliente,Agente,Almacen,Fecha,Articulo,Cantidad,Precio,Impuesto1,Impuesto3,Descuento1,DEBE,HABER, Mov, Moneda, DescGlobal, Costo, Estatus, clienteorig, agenteorig) '
        ELSE 'INSERT #VTAS (TipoCambio,Cliente,Agente,Almacen,Fecha,Articulo,Cantidad,Precio,Impuesto1,Impuesto3,Descuento1,DEBE,HABER, Mov, Moneda, DescGlobal) ' END
	+ 'SELECT  '
    + CASE WHEN @Agrupador = 'Movimiento' THEN 'MovID = dbo.fnAspelJustificadocto(LTRIM(RTRIM(FACT.CVE_DOC))), ' ELSE '' END
	+ 'TipoCambio	=	ROUND(FACT.TIPCAMB,5), '
	+ 'Cliente		=	dbo.fnAspelJustificaClave(LTRIM(RTRIM(FACT.CVE_CLPV))),  '
	+ 'Agente		=	dbo.fnAspelJustificaClave(LTRIM(RTRIM(FACT.CVE_VEND))),  '
	+ 'Almacen		=	FACT.NUM_ALMA, '
	+ 'Fecha		= ' + CASE WHEN @Agrupador = 'Movimiento' THEN 'FACT.FECHA_DOC, ' ELSE @CadenaAgrupacion END	
	+ 'Articulo		= ' + char(39) + 'FLETE' + char(39) + ', '
    + 'Cantidad		=	1, '
	+ 'Precio		=	FACT.COSTOFLET / FACT.TIPCAMB, '
	--+ 'Precio		= ((FACT.COSTOFLET-(FACT.COSTOFLET*(FACT.RETENFLET/100))+(FACT.COSTOFLET*(FACT.IMPUEFLET/100)))/(1+(FACT.IMPUEFLET/100))) / FACT.TIPCAMB, '
	+ 'Impuesto1	=	FACT.IMPUEFLET, '
	+ 'Impuesto3	=	-(FACT.COSTOFLET*(FACT.RETENFLET/100)), '
	+ 'Descuento1	=	0, '
	--+ 'DEBE			=	CASE WHEN FACT.TIP_DOC = ' + CHAR(39) + 'D' + CHAR(39) + ' THEN (SUM((FACT.COSTOFLET-(FACT.COSTOFLET*(FACT.RETENFLET/100))+(FACT.COSTOFLET*(FACT.IMPUEFLET/100)))/(1+(FACT.IMPUEFLET/100)) * 1)) / FACT.TIPCAMB ELSE 0 END, '
	--+ 'HABER		=	CASE WHEN FACT.TIP_DOC = ' + CHAR(39) + 'F' + CHAR(39) + ' THEN (SUM((FACT.COSTOFLET-(FACT.COSTOFLET*(FACT.RETENFLET/100))+(FACT.COSTOFLET*(FACT.IMPUEFLET/100)))/(1+(FACT.IMPUEFLET/100)) * 1)) / FACT.TIPCAMB ELSE 0 END, '
	+ 'DEBE		=	CASE WHEN FACT.TIP_DOC = ' + CHAR(39) + 'D' + CHAR(39) + ' THEN SUM(FACT.COSTOFLET*1) ELSE 0 END, '
	+ 'HABER		=	CASE WHEN FACT.TIP_DOC = ' + CHAR(39) + 'F' + CHAR(39) + ' THEN SUM(FACT.COSTOFLET*1) ELSE 0 END, '
    + 'Mov			=	CASE WHEN FACT.TIP_DOC = ' + CHAR(39) + 'D' + CHAR(39) + ' THEN ' + CHAR(39) + @MovDebe + CHAR(39) + ' ELSE ' + CHAR(39) + @MovHaber + CHAR(39) + ' END, '
	+ 'Moneda		=	LEFT(MONED.DESCR,10), ' 
	+ 'DescGlobal = CASE WHEN FACT.DES_FIN <> 0 THEN (FACT.DES_FIN * 100 / FACT.CAN_TOT) ELSE 0 END,  '
	+ 'Costo		=	0, ' 	
	+ 'Estatus		= FACT.STATUS, '
	+ 'CLIENTEORIG  = LTRIM(RTRIM(FACT.CVE_CLPV)), '
	+ 'AGENTEORIG   = LTRIM(RTRIM(FACT.CVE_VEND)) '	    
	+ 'FROM '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.FACT01 FACT  ' --FACTURA
    + 'LEFT JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.CLIE01 CLIE ON CLIE.CCLIE = FACT.CVE_CLPV ' --CLIENTES	
    + 'INNER JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.MONED01 MONED ON FACT.NUM_MONED = MONED.NUM_MONED ' --Monedas
    + 'WHERE FACT.TIP_DOC IN (' + CHAR(39) + 'F' + CHAR(39) + ',' + CHAR(39) + 'D' + CHAR(39) + ') AND FACT.COSTOFLET <> 0 ' 
	--+ 'AND FACT.STATUS <> ' + CHAR(39) + 'C' + CHAR(39) + ' ' --NO PASAN LAS FACTURAS CANCELADAS
	+ 'GROUP BY FACT.CVE_CLPV, FACT.NUM_ALMA, ' + @CadenaAgrupacion + ' FACT.COSTOFLET, FACT.IMPUEFLET, FACT.RETENFLET, FACT.TIPCAMB, FACT.NUM_MONED, FACT.TIP_DOC, FACT.CVE_VEND, MONED.DESCR, FACT.DES_FIN, FACT.CAN_TOT, FACT.STATUS' 
	
	

EXEC Sp_ExecuteSql @Sql
    

    
    IF @@ERROR <> 0
      RAISERROR('Falla al insertar en la tabla temporal de ventas (FLETES)',16,1)

--inserto a la tabla
  --Pasa los movimientos de la tabla temporal ya concentrados a la tabla de movimientos de carga del modulo central e incluye el encabezado que
  --creo al principio.
  SET @Sql =  '' 
      + ' INSERT '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCargaReg(GID, CargaGID, Modulo, Mayor,Empresa,Sucursal,Moneda, Mov, Estatus, TipoCambio, Cliente, Agente, Almacen, FechaEmision, Articulo, Cantidad, Precio, Impuesto1, Impuesto2, Impuesto3, Descuento1, Debe, Haber,MovID, Gastos, costo, proveedor, personal) ' 
      + ' SELECT ' 
	  + '  GID			=	NewId() '
      + ' ,CargaGID		=	@GID '
      + ' ,Modulo		=	@Modulo '
      + ' ,Mayor		=	@Cuenta '
      +	' ,Empresa		=	@ConfE '
      +	' ,Sucursal 	=	@ConfS '
      + ' ,Moneda		=	Moneda ' 
      + ' ,Mov			=	Mov '
      + ' ,Estatus		=	CASE WHEN Estatus = ' + CHAR(39) +'C' + CHAR(39) + 'THEN ' + CHAR(39) + 'CANCELADO' + CHAR(39) + ' ELSE '+ CHAR(39) + @Estatus + char(39) + ' END  '	
      + ' ,TipoCambio	=	TipoCambio ' 
      + ' ,Cliente		=	Cliente ' 
	  + ' ,Agente		=	Agente ' 
      + ' ,Almacen		=	Almacen ' 
      + ' ,Fecha		=	Fecha ' 
      + ' ,Articulo		=	Articulo ' 
      + ' ,Cantidad		=	Cantidad ' 
      + ' ,Precio		=	Precio ' 
      + ' ,Impuesto1	=	Impuesto1 ' 
      + ' ,Impuesto2	=	Impuesto2 ' 
      + ' ,Impuesto3	=	Impuesto3 ' 
      + ' ,Descuento1	=	Descuento1 ' 
      + ' ,Debe			=	sum(Debe) ' 
      + ' ,Haber		=	sum(Haber) '
      + ' ,MovID		=	MovID '
      + ' ,DescGlobal '
	  + ' ,Costo '
	  + ' ,Clienteorig '		
	  + ' ,Agenteorig  '
      + ' FROM #VTAS '
      + ' GROUP BY Mayor, Empresa, Sucursal, Moneda, Mov, MovID, TipoCambio, Cliente, Almacen, Fecha, Articulo, Cantidad, Precio, Impuesto1, Impuesto2, Impuesto3, Descuento1, Agente, DescGlobal, Costo, Estatus, Clienteorig, Agenteorig '
  EXEC sp_ExecuteSql @Sql, 
					 N'@GID uniqueidentifier, @Modulo varchar(15), @Cuenta varchar(30), @ConfE varchar(30), @ConfS int, @Moneda varchar(30), @Estatus varchar(15)', 
					 @GID = @GID,
					 @Modulo = @Modulo,	
					 @Cuenta = @Cuenta,
					 @ConfE = @ConfE,
					 @ConfS = @ConfS,
					 @Moneda = @Moneda,
					 @Estatus = @Estatus
  IF @@ERROR <> 0
    RAISERROR('Falla al insertar en la tabla  permanente de ventas',16,1)


-- Para diferenciar los que comienzan con minúscula
	 Update ASPELCARGAREG
 	 SET MOVID = ltrim(rtrim(MOVID)) + 'min'
	 WHERE MODULO = 'VTAS' AND  ascii(left(RTRIM(LTRIM(MOVID)),1)) between 97 and 122


--Carga Compras

        --Obtiene la cuenta contable a la cual se van a cargar todas las ventas y devoluciones de venta de aspel
		SET @Cuenta = ''
		SET @Modulo = ''
		SET @Agrupador = ''
		SET @MovDebe = ''
		SET @MovHaber = ''
		SET @Estatus = ''
		SET @Sql = ''
		SET @Parametros = ''
		SET @Parametros = '@Cuenta varchar(30) OUTPUT, @Modulo varchar(15) OUTPUT, @Agrupador varchar(15) OUTPUT, @MovDebe varchar(20) OUTPUT, @MovHaber varchar(20) OUTPUT, @Estatus varchar(15) OUTPUT'
		SET @Sql =  'SELECT '
        + '@Cuenta = MAYOR '
        + ', @Modulo = Modulo '
        + ', @Agrupador = Agrupador '
        + ', @MovDebe = CASE AfectaContabilidad WHEN 1 THEN MovDebeContable ELSE MovDebeNoContable END'
        + ', @MovHaber = CASE AfectaContabilidad WHEN 1 THEN MovHaberContable ELSE MovHaberNoContable END'
        + ', @Estatus = CASE AfectaContabilidad WHEN 1 THEN EstatusContable ELSE EstatusNoContable END '
        + 'FROM '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfgModuloMayor WHERE DESCRIPCION = ' + CHAR(39) + 'Compras' + CHAR(39) + ''
		EXEC sp_executesql @Sql, @Parametros, 
                           @Cuenta = @Cuenta OUTPUT, 
                           @Modulo = @Modulo OUTPUT, 
                           @Agrupador = @Agrupador OUTPUT, 
                           @MovDebe = @MovDebe OUTPUT,
						   @MovHaber = @MovHaber OUTPUT,
						   @Estatus = @Estatus OUTPUT

--Crea la tabla temporal
CREATE TABLE #Coms
(
	Mayor		varchar(30) NULL, 
	Empresa		varchar(30) NULL,
	Sucursal	int			NULL, 
	Moneda		varchar(30) NULL,
	TipoCambio	float(15)	NULL,
	Proveedor	varchar(30) NULL,
	Almacen		varchar(30)	NULL,
	Fecha		datetime	NULL,
	Articulo	varchar(30)	NULL,
	Cantidad	float(15)	NULL,
	Precio		float(15)	NULL,
	Impuesto1	float(15)	NULL,
	Impuesto2	float(15)	NULL,
	Impuesto3	float(15)	NULL,
	Descuento1  float(15)	NULL,
	DEBE		float(15)	NULL,
	HABER		float(15)	NULL,
	Mov			varchar(20) NULL,
	MovID		varchar(20)	NULL,
	Factura		varchar(30)	NULL,
	DescGlobal	float(15)	NULL,	
	Provorig	varchar(30)	NULL
)

    SELECT @CadenaAgrupacion = CASE @Agrupador
	  WHEN 'Movimiento' THEN 'COM.FECHA_DOC, COM.CVE_DOC, '
      WHEN 'Dia'		THEN 'COM.FECHA_DOC, '
	  WHEN 'Semana'		THEN 'DATEADD(DD, - DATEPART(DW,COM.FECHA_DOC),DATEADD(WW,1,COM.FECHA_DOC)), '
      WHEN 'Mes'		THEN 'DATEADD(DD, - DAY(COM.FECHA_DOC),DATEADD(MM,1,COM.FECHA_DOC)), '	
      WHEN 'Año'		THEN 'DATEADD(DD, - DATEPART(DY,COM.FECHA_DOC),DATEADD(YY,1,COM.FECHA_DOC)), '
      ELSE 'COM.FECHA_DOC, '
    END

    SELECT @CampoImpuesto1 = ltrim(rtrim(Valor)) FROM AspelCfgOpcion WHERE Descripcion = 'IVA Articulo'
    SELECT @CampoImpuesto2 = ltrim(rtrim(Valor)) FROM AspelCfgOpcion WHERE Descripcion = 'IEPS Articulo'
    SELECT @CampoImpuesto3 = ltrim(rtrim(Valor)) FROM AspelCfgOpcion WHERE Descripcion = 'Impuesto 3 Articulo'


	SET @CampoImpuesto3 = CASE @CampoImpuesto3
		WHEN 'IMPU2+IMPU3' THEN 'PART.TOTIMP2+PART.TOTIMP3' 
		WHEN 'IMPU1+IMPU2' THEN 'PART.TOTIMP1+PART.TOTIMP2'   		
		WHEN 'IMPU3+IMPU4' THEN 'PART.TOTIMP3+PART.TOTIMP4'   		
	END


  SET @Sql = '' 
    + CASE
        WHEN @Agrupador = 'Movimiento' THEN '	INSERT #Coms (MovID, TipoCambio, Proveedor, Almacen, Fecha, Articulo, Cantidad, Precio, Impuesto1, Impuesto2, Impuesto3, Descuento1, DEBE, HABER, Mov, Moneda, Factura,DescGlobal,Provorig) '
        ELSE '	INSERT #Coms (TipoCambio, Proveedor, Almacen, Fecha, Articulo, Cantidad, Precio, Impuesto1, Impuesto2, Impuesto3, Descuento1, DEBE, HABER, Mov, Moneda, Factura) ' END
    + '	SELECT '
	+ CASE WHEN @Agrupador = 'Movimiento' THEN 'MovID = dbo.fnAspelJustificadocto(LTRIM(RTRIM(COM.CVE_DOC))), ' ELSE '' END
    + '	  TipoCambio	=	ROUND(COM.TIPCAMB,5), '
    + '	  Proveedor	=	dbo.fnAspelJustificaClave(LTRIM(RTRIM(COM.CVE_CLPV))), '
    + '	  Almacen		=	COM.NUM_ALMA, '
    + '	  Fecha		= ' + CASE WHEN @Agrupador = 'Movimiento' THEN 'COM.FECHA_DOC, ' ELSE @CadenaAgrupacion END	
    + '	  Articulo	=   PART.CVE_ART, '
    + '	  Cantidad	=	SUM(CANT), '
    + '	  Precio	=	COST/COM.TIPCAMB , '  
    + '	  Impuesto1	= ' + @CampoImpuesto1 +', '
    + '	  Impuesto2	= ' + @CampoImpuesto2 +', '
    + '	  Impuesto3	= ' + @CampoImpuesto3 +', '
    + '	  Descuento1  =	DESCU, '
    + '	  DEBE		=	CASE WHEN COM.TIP_DOC = ' + CHAR(39) + 'C' + CHAR(39) + ' THEN SUM((PART.COST * PART.CANT)-((PART.COST * PART.CANT)*(PART.DESCU/100))) ELSE 0 END, ' --Cuando es compra llena el Debe
    + '	  HABER		=	CASE WHEN COM.TIP_DOC = ' + CHAR(39) + 'd' + CHAR(39) + ' THEN SUM((PART.COST * PART.CANT)-((PART.COST * PART.CANT)*(PART.DESCU/100))) ELSE 0 END, '  --Cuando es devolucion llena el haber
    + '   Mov		=	CASE WHEN COM.TIP_DOC = ' + CHAR(39) + 'C' + CHAR(39) + ' THEN ' + CHAR(39) + @MovDebe + CHAR(39) + ' ELSE ' + CHAR(39) + @MovHaber + CHAR(39) + ' END, '
    + '	  Moneda		=	LEFT(MONED.DESCR,10), '
    + '   Factura      = COM.SU_REFER, '
	+ '   DescGlobal = CASE WHEN COM.DES_FIN <> 0 THEN (COM.DES_FIN * 100 / COM.CAN_TOT) ELSE 0 END,  ' 
	+ '	  PROVORIG  = LTRIM(RTRIM(COM.CVE_CLPV)) '
    + '   FROM '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.COMP01 COM '   
	+ '	  LEFT JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.PROV01 PROV ON COM.CVE_CLPV = PROV.CPROV '
    + '	  INNER JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.COM0Y1 PART ON COM.CVE_DOC = PART.CVE_DOC AND COM.TIP_DOC = PART.TIP_DOC '
	+ '   INNER JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.MONED01 MONED ON COM.NUM_MONED = MONED.NUM_MONED ' --Monedas
    + '	 WHERE COM.TIP_DOC IN (' + CHAR(39) + 'C' + CHAR(39) + ',' + CHAR(39) + 'd' + CHAR(39) + ') AND PART.TIPO_PRODT IN (' + CHAR(39) + 'I' + CHAR(39) + ',' + CHAR(39) + ' ' + CHAR(39) + ')' 
    + '  AND COM.STATUS <> ' + CHAR(39) + 'C' + CHAR(39) + ' ' 
	+ '	 GROUP BY COM.CVE_CLPV, COM.NUM_ALMA, ' + @CadenaAgrupacion + ' PART.CVE_ART, CANT, COST, ' + @CampoImpuesto1 + ',' + @CampoImpuesto2 + ',' + @CampoImpuesto3 + ', DESCU, TIPCAMB, COM.NUM_MONED,COM.TIP_DOC, MONED.DESCR, COM.SU_REFER,COM.DES_FIN,COM.CAN_TOT,TOTIMP3' -- 011208 SE AGREGO DESFIN Y CANTOT
	
  EXEC sp_executeSql @Sql
  IF @@ERROR <> 0
    RAISERROR('Falla al insertar en la tabla temporal de compras',16,1)

  SET @Sql = '' 
    + CASE
        WHEN @Agrupador = 'Movimiento' THEN '	INSERT #Coms (MovID, TipoCambio, Proveedor, Almacen, Fecha, Articulo, Cantidad, Precio, Impuesto1, Impuesto3, Descuento1, DEBE, HABER, Mov, Moneda, Factura,DescGlobal,Provorig) '
        ELSE '	INSERT #Coms (TipoCambio, Proveedor, Almacen, Fecha, Articulo, Cantidad, Precio, Impuesto1, Impuesto3, Descuento1, DEBE, HABER, Mov, Moneda, Factura) ' END
    + '	SELECT '
	+ CASE WHEN @Agrupador = 'Movimiento' THEN 'MovID = dbo.fnAspelJustificadocto(LTRIM(RTRIM(COM.CVE_DOC))), ' ELSE '' END
    + '	  TipoCambio	=	COM.TIPCAMB, '
    + '	  Proveedor	=	dbo.fnAspelJustificaClave(LTRIM(RTRIM(COM.CVE_CLPV))), '
    + '	  Almacen		=	COM.NUM_ALMA, '
    + '	  Fecha		= ' + CASE WHEN @Agrupador = 'Movimiento' THEN 'COM.FECHA_DOC, ' ELSE @CadenaAgrupacion END	
    + '	  Articulo	= ' + char(39) + 'FLETE' + char(39) + ', '
    + '	  Cantidad	=	1, '
    + '	  Precio		=	COM.COSTOFLET/COM.TIPCAMB , '
    --+ '	  Precio	=	(COM.COSTOFLET-(COM.COSTOFLET*(COM.RETENFLET/100))+(COM.COSTOFLET*(COM.IMPUEFLET/100)))/(1+(COM.IMPUEFLET/100)), '
    + '	  Impuesto1	=   COM.IMPUEFLET, '
    + '   Impuesto3	=	-(COM.COSTOFLET*(COM.RETENFLET/100)), '
    + '	  Descuento1  =	0, '
    + '   DEBE		=	CASE WHEN COM.TIP_DOC = ' + CHAR(39) + 'C' + CHAR(39) + ' THEN SUM(COM.COSTOFLET*1) ELSE 0 END, '
	+ '   HABER		=	CASE WHEN COM.TIP_DOC = ' + CHAR(39) + 'd' + CHAR(39) + ' THEN SUM(COM.COSTOFLET*1) ELSE 0 END, '
    + '   Mov		=	CASE WHEN COM.TIP_DOC = ' + CHAR(39) + 'C' + CHAR(39) + ' THEN ' + CHAR(39) + @MovDebe + CHAR(39) + ' ELSE ' + CHAR(39) + @MovHaber + CHAR(39) + ' END, '
	+ '	  Moneda		=	LEFT(MONED.DESCR,10), '
    + '   Factura      = COM.SU_REFER, '
	+ '   DescGlobal = CASE WHEN COM.DES_FIN <> 0 THEN (COM.DES_FIN * 100 / COM.CAN_TOT) ELSE 0 END,  ' 
	+ '	  PROVORIG  = LTRIM(RTRIM(COM.CVE_CLPV)) '
	+ '  FROM '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.COMP01 COM '
    + '	 LEFT JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.PROV01 PROV ON  COM.CVE_CLPV = PROV.CPROV'
	+ '  INNER JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.MONED01 MONED ON COM.NUM_MONED = MONED.NUM_MONED ' --Monedas
    + '	 WHERE COM.TIP_DOC IN (' + CHAR(39) + 'C' + CHAR(39) + ',' + CHAR(39) + 'd' + CHAR(39) + ') AND COM.COSTOFLET <> 0 ' --AND PART.TIPO_PRODT = ' + CHAR(39) + 'I' + CHAR(39) + ' '
	+ 'AND COM.STATUS <> ' + CHAR(39) + 'C' + CHAR(39) + ' ' --NO PASAN LAS COMPRAS CANCELADAS
    + '	 GROUP BY COM.CVE_CLPV, COM.NUM_ALMA, ' + @CadenaAgrupacion + ' COM.COSTOFLET, COM.IMPUEFLET, COM.RETENFLET, TIPCAMB, COM.NUM_MONED, COM.TIP_DOC, MONED.DESCR, COM.SU_REFER,COM.DES_FIN,COM.CAN_TOT '

  
    EXEC Sp_ExecuteSql @Sql
    IF @@ERROR <> 0
      RAISERROR('Falla al insertar en la tabla temporal de compras (FLETES)',16,1)


    SET @Sql = '' 
        + CASE
            WHEN @Agrupador = 'Movimiento' THEN 'INSERT #Coms (MovID, TipoCambio, Proveedor, Almacen, Fecha, Articulo, Cantidad, Precio, Impuesto1, Descuento1, DEBE, HABER, Mov, Moneda, Factura,DescGlobal,Provorig) '
            ELSE '	INSERT #Coms (TipoCambio, Proveedor, Almacen, Fecha, Articulo, Cantidad, Precio, Impuesto1, Descuento1, DEBE, HABER, Mov, Moneda, Factura) ' END
        + '	SELECT '
    	+ CASE WHEN @Agrupador = 'Movimiento' THEN 'MovID = dbo.fnAspelJustificadocto(LTRIM(RTRIM(COM.CVE_DOC))), ' ELSE '' END
        + '	  TipoCambio	=	COM.TIPCAMB, '
        + '	  Proveedor	=	dbo.fnAspelJustificaClave(LTRIM(RTRIM(COM.CVE_CLPV))), '
        + '	  Almacen		=	COM.NUM_ALMA, '
        + '	  Fecha		= ' + CASE WHEN @Agrupador = 'Movimiento' THEN 'COM.FECHA_DOC, ' ELSE @CadenaAgrupacion END	
        + '	  Articulo	= ' + char(39) + 'INDIRECTOS' + char(39) + ', '
        + '	  Cantidad	=	1, '
        + '	  Precio	=	COM.TOT_IND, '
        + '	  Impuesto1	=   0, '
        + '	  Descuento1  =	0, '
        + '	  DEBE		=	CASE WHEN COM.TIP_DOC = ' + CHAR(39) + 'C' + CHAR(39) + ' THEN SUM((COM.COSTOFLET-(COM.COSTOFLET*(COM.RETENFLET/100))+(COM.COSTOFLET*(COM.IMPUEFLET/100)))/(1+(COM.IMPUEFLET/100)) * 1) ELSE 0 END, '
    	+ '	  HABER		=	CASE WHEN COM.TIP_DOC = ' + CHAR(39) + 'd' + CHAR(39) + ' THEN SUM((COM.COSTOFLET-(COM.COSTOFLET*(COM.RETENFLET/100))+(COM.COSTOFLET*(COM.IMPUEFLET/100)))/(1+(COM.IMPUEFLET/100)) * 1) ELSE 0 END, '
        + '   Mov		=	CASE WHEN COM.TIP_DOC = ' + CHAR(39) + 'C' + CHAR(39) + ' THEN ' + CHAR(39) + @MovDebe + CHAR(39) + ' ELSE ' + CHAR(39) + @MovHaber + CHAR(39) + ' END, '
    	+ '	  Moneda		=	LEFT(MONED.DESCR,10), '
    	+ '   Factura      = COM.SU_REFER, '
		+ '   DescGlobal = CASE WHEN COM.DES_FIN <> 0 THEN (COM.DES_FIN * 100 / COM.CAN_TOT) ELSE 0 END,  ' 
		+ '	  PROVORIG  = LTRIM(RTRIM(COM.CVE_CLPV)) '
        + '  FROM '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.COMP01 COM '
		+ '	 LEFT JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.PROV01 PROV ON  COM.CVE_CLPV = PROV.CPROV'
		+ '  INNER JOIN '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.MONED01 MONED ON COM.NUM_MONED = MONED.NUM_MONED ' --Monedas
        + '	 WHERE COM.TIP_DOC IN (' + CHAR(39) + 'C' + CHAR(39) + ',' + CHAR(39) + 'd' + CHAR(39) + ') AND COM.TOT_IND <> 0 ' --AND PART.TIPO_PRODT = ' + CHAR(39) + 'I' + CHAR(39) + ' '
        + '	 GROUP BY COM.CVE_CLPV, COM.NUM_ALMA, ' + @CadenaAgrupacion + ' COM.TOT_IND, TIPCAMB, COM.NUM_MONED, COM.TIP_DOC, MONED.DESCR, COM.SU_REFER,COM.DES_FIN,COM.CAN_TOT '
    	
    	EXEC Sp_ExecuteSql @Sql
        IF @@ERROR <> 0
      RAISERROR('Falla al insertar en la tabla temporal de compras (INDIRECTOS)',16,1)
    
  SET @Sql =  ''
    + ' INSERT '+ @ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCargaReg(gid,cargagid,Modulo, Mayor,Empresa,Sucursal,
    Moneda, Mov, Estatus, TipoCambio,Proveedor,Almacen,FechaEmision,Articulo,Cantidad,Costo,Impuesto1,Impuesto2,Impuesto3,
    Descuento1,Debe,Haber,MovID, Referencia,Gastos,Cliente) '
    + ' SELECT '
	+ '    GID			=	NewId() '
    + '   ,CargaGID		=	@GID '
    + '   ,Modulo		=	@Modulo '
    + '   ,Mayor		=	@Cuenta '
    + '   ,Empresa		=	@ConfE '
    + '   ,Sucursal 	=	@ConfS '
    + '   ,Moneda		=	Moneda  ' 
    + ' ,Mov			=	Mov '
    + ' ,Estatus		=	@Estatus '
    + '   ,TipoCambio	=	TipoCambio ' 
    + '   ,Proveredor	=	Proveedor ' 
    + '   ,Almacen		=	Almacen ' 
    + '   ,Fecha		=	Fecha ' 
    + '   ,Articulo		=	Articulo ' 
    + '   ,Cantidad		=	sum(Cantidad) '
    + '   ,Costo		=	Precio ' 
    + '   ,Impuesto1	=	Impuesto1 ' 
    + '   ,Impuesto2	=	Impuesto2 ' 
    + '   ,Impuesto3	=	Impuesto3 ' 
    + '   ,Descuento1	=	Descuento1 ' 
    + '   ,Debe			=	sum(Debe) ' 
    + '   ,Haber		=	sum(Haber) '
    + '   ,MovID		=	MovID '
    + '   ,Referencia             = Factura '
	+ ' ,DescGlobal '	
	+ ' ,Provorig '	
    + '  FROM #COMS '
    + ' GROUP BY Mayor, Empresa, Sucursal, Moneda, Mov, MovID, TipoCambio, Proveedor, Almacen, Fecha, Articulo, Cantidad, Precio, Impuesto1, Impuesto2, Impuesto3, Descuento1, Factura,DescGlobal,Provorig ' 
  EXEC sp_ExecuteSql @Sql,
					 N'@GID uniqueidentifier, @Modulo varchar(15), @Cuenta varchar(30), @ConfE varchar(30), @ConfS varchar(30), @Moneda varchar(30), @Estatus varchar(15)',
					 @GID = @GID,
					 @Modulo = @Modulo,
					 @Cuenta = @Cuenta,
					 @ConfE = @ConfE,
					 @ConfS = @ConfS,
					 @Moneda = @Moneda,
					 @Estatus = @Estatus

  IF @@ERROR <> 0
    RAISERROR('Falla al insertar en la tabla permanente de compras',16,1)

-- Para diferenciar los que comienzan con minúscula
	 Update ASPELCARGAREG
 	 SET MOVID = ltrim(rtrim(MOVID)) + 'min'
	 WHERE MODULO = 'COMS' AND  ascii(left(RTRIM(LTRIM(MOVID)),1)) between 97 and 122



    --Obtiene la cuenta contable a la cual se van a cargar todas las ventas y devoluciones de venta de aspel
    SET @Cuenta = ''
	SET @Modulo = ''
	SET @Agrupador = ''
	SET @MovDebe = ''
	SET @MovHaber = ''
	SET @Estatus = ''
	SET @Sql = ''
	SET @Parametros = ''
	SET @Parametros = '@Cuenta varchar(30) OUTPUT, @Modulo varchar(15) OUTPUT, @Agrupador varchar(15) OUTPUT, @MovDebe varchar(20) OUTPUT, @MovHaber varchar(20) OUTPUT, @Estatus varchar(15) OUTPUT'
	SET @Sql =  'SELECT '
    + '@Cuenta = MAYOR '
    + ', @Modulo = Modulo '
    + ', @Agrupador = Agrupador '
    + ', @MovDebe = CASE AfectaContabilidad WHEN 1 THEN MovDebeContable ELSE MovDebeNoContable END'
    + ', @MovHaber = CASE AfectaContabilidad WHEN 1 THEN MovHaberContable ELSE MovHaberNoContable END'
    + ', @Estatus = CASE AfectaContabilidad WHEN 1 THEN EstatusContable ELSE EstatusNoContable END '
    + 'FROM '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfgModuloMayor WHERE DESCRIPCION = ' + CHAR(39) + 'Inventarios' + CHAR(39) + ''
	EXEC sp_executesql @Sql, @Parametros, 
                       @Cuenta = @Cuenta OUTPUT, 
                       @Modulo = @Modulo OUTPUT, 
                       @Agrupador = @Agrupador OUTPUT, 
                       @MovDebe = @MovDebe OUTPUT,
					   @MovHaber = @MovHaber OUTPUT,
					   @Estatus = @Estatus OUTPUT


CREATE TABLE #Inv
(	Almacen		varchar(30),
	CveArt		varchar(30),
	Cantidad	float(15),
   	Costo		float(15),
	CostoTotal	float(15),
	Tipo		varchar(1)
)

--si el tipo de costeo es promedio, es suficiente con un solo movimiento, es decir, se toma la existencia como la real
--si es UEPS o PEPS se puede hacer una entrada por cada capa "viva", y la suma es la existencia total
--Primero buscamos los productos cuyo costeo sea de tipo promedio
	SET @Sql = ''
	+ 'INSERT INTO #Inv (Almacen, CveArt, Cantidad, Costo, Costototal, Tipo) '
	+ 'SELECT DISTINCT COST.ALMACEN, INV.CLV_ART, COST.EXIST, INV.COSTO_PROM, (COST.EXIST * INV.COSTO_PROM), INV.TIP_COSTEO ' 
	+ 'FROM ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.INVE01 AS INV '
	+ 'INNER JOIN '+ @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.MULT01 AS COST ON INV.CLV_ART = COST.CLV_ART '
	+ 'WHERE INV.TIP_COSTEO = ' + CHAR(39) + 'P' + CHAR(39) + ' AND COST.EXIST > 0 ' 
	+ 'ORDER BY INV.CLV_ART '

	EXEC sp_executeSql @Sql
	
	IF @@ERROR <> 0
    		RAISERROR('Falla al insertar en la tabla temporal de entradas de inventario1',16,1)
    
--Ahora buscamos los productos cuyo costeo sea de tipo distinto a promedio (peps o ueps)
	SET @Sql = ''
	+ 'INSERT INTO #Inv (Almacen, CveArt, Cantidad, Costo, Costototal, Tipo) '
	+ 'SELECT TOP (100) PERCENT COST.ALMACEN, INV.CLV_ART, COST.CANT_COST, COST.COSTO, COST.CANT_COST * COST.COSTO, ' 
	+ 'INV.TIP_COSTEO '
	+ 'FROM ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.INVE01 AS INV '
	+ 'INNER JOIN ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.MINV01 AS COST ON INV.CLV_ART = COST.CLV_ART '
	+ 'WHERE INV.TIP_COSTEO <> ' + CHAR(39) + 'P' + CHAR(39)
	--+ ' GROUP BY COST.ALMACEN, INV.CLV_ART, COST.COSTO, INV.TIP_COSTEO, COST.CANT_COST ' 
	--+ 'HAVING COST.CANT_COST > 0 '
	+ 'AND COST.CANT_COST > 0 '	
	+ 'ORDER BY INV.CLV_ART '

	EXEC sp_executeSql @Sql

	IF @@ERROR <> 0
    		RAISERROR('Falla al insertar en la tabla temporal de entradas de inventario1',16,1)
    		

  --Inserta los movimientos de inventario en la tabla de carga
  SET @Sql = ''
    + 'INSERT '+ @ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCargaReg (GID, CargaGID, Modulo, Mayor, Empresa, Sucursal, Almacen, Moneda, Mov, Estatus, Articulo, Cantidad, Debe, Costo) '
    + 'SELECT '
	+ 'GID			=	NewId() '
    + ',CargaGID	=	@GID '
    + ',Modulo		=	@Modulo '
    + ',Mayor		=	@Cuenta '
    + ',Empresa		=	@ConfE '
    + ',Sucursal	=	@ConfS '
    + ',Almacen		=	Almacen '
    + ',Moneda		=	@Moneda '
    + ',Mov 		=	@MovDebe '
    + ',Estatus		=	@Estatus '
    + ',Articulo	=	CveArt'
    + ',Cantidad	=	Cantidad '
    + ',Debe		=	CostoTotal '
    + ',Costo		=	Costo '
    --ARC: Ya no se utiliza el campo HABER
    --+ ',Haber		=	Haber '
    + 'FROM		#Inv '

  EXECUTE sp_executesql @Sql,
						N'@GID uniqueidentifier, @Modulo varchar(15), @Cuenta varchar(30), @ConfE varchar(30), @ConfS int, @Moneda varchar(30), @MovDebe varchar(20), @Estatus varchar(15)',
						@GID = @GID,
						@Modulo = @Modulo,
						@Cuenta = @Cuenta,
						@ConfE = @ConfE,
						@ConfS = @ConfS,
						@Moneda = @Moneda,
						@MovDebe = @MovDebe,
						@Estatus = @Estatus

  IF @@ERROR <> 0
    RAISERROR('Falla al insertar en la tabla permanente de inventario',16,1)


    -- CXC
    --Obtiene la cuenta contable a la cual se van a cargar todas las ventas y devoluciones de venta de aspel
    SET @Cuenta = ''
	SET @Modulo = ''
	SET @Agrupador = ''
	SET @MovDebe = ''
	SET @MovHaber = ''
	SET @Estatus = ''
	SET @Sql = ''
	SET @Parametros = ''
	SET @Parametros = '@Cuenta varchar(30) OUTPUT, @Modulo varchar(15) OUTPUT, @Agrupador varchar(15) OUTPUT, @MovDebe varchar(20) OUTPUT, @MovHaber varchar(20) OUTPUT, @Estatus varchar(15) OUTPUT'
	SET @Sql =  'SELECT '
    + '@Cuenta = MAYOR '
    + ', @Modulo = Modulo '
    + ', @Agrupador = Agrupador '
    + ', @MovDebe = CASE AfectaContabilidad WHEN 1 THEN MovDebeContable ELSE MovDebeNoContable END'
    + ', @MovHaber = CASE AfectaContabilidad WHEN 1 THEN MovHaberContable ELSE MovHaberNoContable END'
    + ', @Estatus = CASE AfectaContabilidad WHEN 1 THEN EstatusContable ELSE EstatusNoContable END '
    + 'FROM '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfgModuloMayor WHERE DESCRIPCION = ' + CHAR(39) + 'Clientes' + CHAR(39) + ''
	EXEC sp_executesql @Sql, @Parametros, 
                       @Cuenta = @Cuenta OUTPUT, 
                       @Modulo = @Modulo OUTPUT, 
                       @Agrupador = @Agrupador OUTPUT, 
                       @MovDebe = @MovDebe OUTPUT,
					   @MovHaber = @MovHaber OUTPUT,
					   @Estatus = @Estatus OUTPUT


CREATE TABLE #CXC
(
	CCLIE		varchar(5)	NOT NULL,
	REFER		VARCHAR(9)	NOT NULL,
	TIPO		VARCHAR(1)	NOT NULL,
	IMPORTEMN	FLOAT		NOT NULL,
	IMPORTEME	FLOAT		NOT NULL,
	FECHA_APLI	DATETIME	NULL,
	FECHA_VENC	DATETIME	NULL,
	DESCR	VARCHAR (30)	NULL,
	TIPO_MOV VARCHAR(2)		NULL,	
	NUM_MONED VARCHAR(2)	NULL,
	DESCRMON VARCHAR(20)	NULL,
	MONTONATIVO FLOAT		NULL,
	NO_FACTURA VARCHAR(7)	NULL,
	DOCTO VARCHAR (9)		NULL,
	MOV VARCHAR(20)			NULL,
	TCAMBIO float(15)	NULL,
	CCONREFER VARCHAR(1) NULL,
	IVAFISCAL FLOAT NULL,
	IEPSFISCAL FLOAT NULL,
	IMPUESTOS FLOAT	NULL
)

SET @Sql = '' 
+ 'INSERT #CXC '
+ 'SELECT ltrim(rtrim(A.CCLIE)),ltrim(rtrim(A.REFER)), TIPO, CASE WHEN B.TIPO = ' + char(39) + 'C' + char(39)+ ' THEN SUM(IMPORTE) '
+ 'ELSE -SUM(IMPORTE) END AS IMPORTEMN,CASE WHEN B.TIPO = ' + char(39)+ 'C' + char(39)+ ' THEN SUM(IMPMON_EXT) '
+ 'ELSE -SUM(IMPMON_EXT) END AS IMPORTEME,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL '
+ ' FROM ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.CUEN01 A '
+ 'INNER JOIN ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.CONC01 B ON A.TIPO_MOV = B.NUM_CPTO '
+ 'GROUP BY CCLIE,REFER,TIPO '
+ 'HAVING ABS((SUM(IMPORTE)) + ABS(SUM(IMPMON_EXT))) >0 '
EXEC sp_executesql @Sql

SELECT '#CXCSALDOS', * FROM #CXC

 CREATE TABLE #CXCFECHAS
(
	NUM_REG		int NOT NULL,
	CCLIE		VARCHAR(5) NULL,
	FECHA_APLI	DATETIME  NULL,
	FECHA_VENC	DATETIME  NULL,
	DESCR	VARCHAR (30) NULL,
	REFER		VARCHAR(9) NOT NULL,
	TIPO_MOV VARCHAR(2) NULL,
	NUM_MONED VARCHAR(2) NULL,
	NO_FACTURA VARCHAR(7) NULL,
	DOCTO VARCHAR (9) NULL,
	TCAMBIO float(15)	NULL,
	CCONREFER VARCHAR(19) NULL
)

SET @Sql = ''
+ 'INSERT #CXCFECHAS '
+ 'SELECT  DISTINCT A.NUM_REG, ltrim(rtrim(CCLIE)),FECHA_APLI,FECHA_VENC,DESCR, ltrim(rtrim(REFER)),TIPO_MOV,NUM_MONED,NO_FACTURA, DOCTO,TCAMBIO, CCONREFER ' -- igr se agregó CCONREFER 220109
+ ' FROM ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.CUEN01 A '
+ 'INNER JOIN ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.CONC01 B ON A.TIPO_MOV = B.NUM_CPTO '
+ 'WHERE A.CCONREFER = ' + CHAR(39) + 'N' + CHAR(39) 
+ ' ORDER BY A.NUM_REG ASC '
EXEC sp_executesql @Sql

UPDATE #CXC  SET TIPO_MOV = #CXCFECHAS.TIPO_MOV FROM #CXCFECHAS 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS.CCLIE))

UPDATE #CXC  SET FECHA_APLI = #CXCFECHAS.FECHA_APLI FROM #CXCFECHAS 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS.CCLIE))

UPDATE #CXC  SET FECHA_VENC = #CXCFECHAS.FECHA_VENC FROM #CXCFECHAS 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS.CCLIE))

UPDATE #CXC  SET DESCR = #CXCFECHAS.DESCR FROM #CXCFECHAS 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS.CCLIE))

UPDATE #CXC  SET NUM_MONED = #CXCFECHAS.NUM_MONED FROM #CXCFECHAS 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS.CCLIE))

UPDATE #CXC  SET NO_FACTURA = #CXCFECHAS.NO_FACTURA FROM #CXCFECHAS 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS.CCLIE))

UPDATE #CXC  SET DOCTO = #CXCFECHAS.DOCTO FROM #CXCFECHAS 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS.CCLIE))

UPDATE #CXC  SET TCAMBIO = #CXCFECHAS.TCAMBIO FROM #CXCFECHAS 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS.CCLIE))

UPDATE #CXC  SET CCONREFER = #CXCFECHAS.CCONREFER FROM #CXCFECHAS 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS.CCLIE))

--  MOVIMIENTOS 'HUERFANOS'

 CREATE TABLE #CXCFECHAS2
(
	NUM_REG		int NOT NULL,
	CCLIE		VARCHAR(5) NULL,
	FECHA_APLI	DATETIME  NULL,
	FECHA_VENC	DATETIME  NULL,
	DESCR	VARCHAR (30) NULL,
	REFER		VARCHAR(9) NOT NULL,
	TIPO_MOV VARCHAR(2) NULL,
	NUM_MONED VARCHAR(2) NULL,
	NO_FACTURA VARCHAR(7) NULL,
	DOCTO VARCHAR (9) NULL,
	TCAMBIO float(15)	NULL,
	CCONREFER VARCHAR(19) NULL
)


SET @Sql = ''
+ 'INSERT #CXCFECHAS2 '
+ 'SELECT  DISTINCT A.NUM_REG, ltrim(rtrim(CCLIE)),FECHA_APLI,FECHA_VENC,DESCR, ltrim(rtrim(REFER)),TIPO_MOV,NUM_MONED,NO_FACTURA, DOCTO,TCAMBIO, CCONREFER ' -- igr se agregó CCONREFER 220109
+ ' FROM ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.CUEN01 A '
+ 'INNER JOIN ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.CONC01 B ON A.TIPO_MOV = B.NUM_CPTO '
+ 'WHERE A.CCONREFER = ' + CHAR(39) + 'S' + CHAR(39) 
+ ' ORDER BY A.NUM_REG ASC '
EXEC sp_executesql @Sql


UPDATE #CXC  SET TIPO_MOV = #CXCFECHAS2.TIPO_MOV FROM #CXCFECHAS2 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS2.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS2.CCLIE)) AND #CXC.FECHA_APLI IS NULL
UPDATE #CXC  SET FECHA_VENC = #CXCFECHAS2.FECHA_VENC FROM #CXCFECHAS2 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS2.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS2.CCLIE)) AND #CXC.FECHA_APLI IS NULL
UPDATE #CXC  SET DESCR = #CXCFECHAS2.DESCR FROM #CXCFECHAS2 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS2.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS2.CCLIE)) AND #CXC.FECHA_APLI IS NULL
UPDATE #CXC  SET NUM_MONED = #CXCFECHAS2.NUM_MONED FROM #CXCFECHAS2 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS2.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS2.CCLIE)) AND #CXC.FECHA_APLI IS NULL
UPDATE #CXC  SET NO_FACTURA = #CXCFECHAS2.NO_FACTURA FROM #CXCFECHAS2 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS2.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS2.CCLIE)) AND #CXC.FECHA_APLI IS NULL
UPDATE #CXC  SET DOCTO = #CXCFECHAS2.DOCTO FROM #CXCFECHAS2 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS2.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS2.CCLIE)) AND #CXC.FECHA_APLI IS NULL
UPDATE #CXC  SET TCAMBIO = #CXCFECHAS2.TCAMBIO FROM #CXCFECHAS2 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS2.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS2.CCLIE)) AND #CXC.FECHA_APLI IS NULL
UPDATE #CXC  SET CCONREFER = #CXCFECHAS2.CCONREFER FROM #CXCFECHAS2 
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS2.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS2.CCLIE)) AND #CXC.FECHA_APLI IS NULL
UPDATE #CXC  SET FECHA_APLI = #CXCFECHAS2.FECHA_APLI FROM #CXCFECHAS2
WHERE ltrim(rtrim(#CXC.REFER)) = ltrim(rtrim(#CXCFECHAS2.REFER)) AND ltrim(rtrim(#CXC.CCLIE)) = ltrim(rtrim(#CXCFECHAS2.CCLIE)) AND #CXC.FECHA_APLI IS NULL

--
SET @Sql = ''
+ 'UPDATE #CXC  SET DESCRMON  = A.DESCR FROM '  + @ServidorOrigen + '.' + @BaseDatosOrigen +'.' + 'dbo.MONED01  A '
+ 'WHERE CONVERT(BINARY(2),#CXC.NUM_MONED) = CONVERT(BINARY(2),A.NUM_MONED)'
EXEC sp_executesql @Sql

UPDATE #CXC  SET MONTONATIVO  = CASE WHEN  NUM_MONED = '1' THEN IMPORTEMN ELSE IMPORTEME END

-- Actualiza datos de impuestos 1 y 2

 CREATE TABLE #FACIMPUESTOS
(
	CVE_DOC			VARCHAR(7) NOT NULL,
	TIP_DOC			VARCHAR(5) NULL,
	IMPUESTO1		FLOAT  NULL,
	IMPUESTO2		FLOAT,
	TOTALIMPUESTOS	FLOAT		
)

SET @Sql = ''
+ 'INSERT #FACIMPUESTOS ' 
+ ' SELECT CVE_DOC, TIP_DOC, (IMP_TOT1)/(CAN_TOT-DES_TOT-DES_FIN+IMP_TOT1+IMP_TOT4+(COSTOFLET*ISNULL(IMPUEFLET,0)/100)-(COSTOFLET*ISNULL(RETENFLET,0)/100)+COSTOFLET), '
+ ' ((IMP_TOT4)+(COSTOFLET*ISNULL(IMPUEFLET,0)/100)-(COSTOFLET*ISNULL(RETENFLET,0)/100))/(CAN_TOT-DES_TOT-DES_FIN+IMP_TOT1+IMP_TOT4+(COSTOFLET*ISNULL(IMPUEFLET,0)/100)-(COSTOFLET*ISNULL(RETENFLET,0)/100)+COSTOFLET), (IMP_TOT4+IMP_TOT1+(COSTOFLET*ISNULL(IMPUEFLET,0)/100)-(COSTOFLET*ISNULL(RETENFLET,0)/100))/TIPCAMB '
+ ' FROM ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.FACT01 '
+ ' WHERE TIP_DOC =  ' + CHAR(39) + 'F' + CHAR(39) + ' AND STATUS <> ' + CHAR(39) + 'C' + CHAR(39) 
+ 'ORDER BY NUM_REG ASC '

EXEC sp_executesql @Sql

UPDATE #CXC  SET IEPSFISCAL = IMPUESTO1 FROM #FACIMPUESTOS				-- IEPS
WHERE ltrim(rtrim(#CXC.DOCTO)) = ltrim(rtrim(#FACIMPUESTOS.CVE_DOC))

UPDATE #CXC  SET IVAFISCAL = IMPUESTO2 FROM #FACIMPUESTOS				--IVA
WHERE ltrim(rtrim(#CXC.DOCTO)) = ltrim(rtrim(#FACIMPUESTOS.CVE_DOC))

UPDATE #CXC  SET IMPUESTOS = TOTALIMPUESTOS FROM #FACIMPUESTOS			--TOTAL IMPUESTOS
WHERE ltrim(rtrim(#CXC.DOCTO)) = ltrim(rtrim(#FACIMPUESTOS.CVE_DOC))

-- cASO 

UPDATE #CXC  SET IVAFISCAL = 0.1304347826,IEPSFISCAL = 0, IMPUESTOS = NULL --ABS(MONTONATIVO * 0.1304347826)									--IVA
WHERE IVAFISCAL IS NULL

-----

--Llena la tabla de carga
    SET @Sql = ''
   + ' INSERT '+ @ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCargaReg (GID, CargaGID, Modulo, Mayor, Empresa, Cliente, Moneda, Mov, Estatus, TipoCambio, FechaEmision, Concepto, Referencia, MovID, Vencimiento, cantidad, Debe, Haber, Subcuenta, Serielote, Proveedor, Impuesto1,Impuesto2,Gastos)'
   + ' SELECT '
   + '  GID				=	NewId() '
   + ' ,CargaGID		=	@GID '
   + ' ,Modulo			=	@Modulo '
   + ' ,Mayor			=	@Cuenta '
   + ' ,Empresa			=	@ConfE '
   + ' ,Cliente			=	dbo.fnAspelJustificaClave(RTRIM(LTRIM(CCLIE)))'
   + ' ,Moneda			=	DESCRMON '
   + ' ,Mov				=	CASE  WHEN sum(MONTONATIVO) >0' + ' THEN ' + char(39) + @Movdebe + char(39) + ' ELSE ' + char(39) + @Movhaber + char(39) + ' END '  
   + ' ,Estatus			=	@Estatus '
   + ' ,TipoCambio		=	ROUND(TCAMBIO,5) '
   + ' ,FechaEmision	=	FECHA_APLI '
   --+ ' ,Concepto		=	CASE  WHEN CCONREFER = ' + char(39) + 'S' + char(39) + ' THEN  ' + char(39) + 'POR ACLARAR' + char(39) + ' ELSE ' + char(39) + '' + char(39) + ' END '  
   + ' ,Concepto		=	NO_FACTURA'
   + ' ,Referencia		=	LTRIM(RTRIM(DESCR)) + ' + CHAR(39) + ' ' + CHAR(39) + ' + LTRIM(RTRIM(DOCTO)) +' + CHAR(39) + ' ' + CHAR(39) +' + CASE  WHEN CCONREFER = ' + char(39) + 'S' + char(39) + ' THEN  ' + char(39) + 'POR ACLARAR' + char(39) + ' ELSE ' + char(39) + '' + char(39) + ' END '  
   + ' ,MovId			=	LTRIM(RTRIM(CCLIE)) + ' + CHAR(39) + '-' + CHAR(39) + ' + LTRIM(RTRIM(REFER))' --+' + CHAR(39) + '-' + CHAR(39) + '+ LEFT(NewId(),2)'
   + ' ,Vencimiento		=	FECHA_VENC '
   + ' ,Cantidad		=	1 '
   + ' ,DEBE 			=  CASE  WHEN sum(MONTONATIVO) >0' + ' THEN ABS(sum(MONTONATIVO)) ELSE 0 END '  
   + ' ,HABER 			=   CASE  WHEN sum(MONTONATIVO) <0' + ' THEN ABS(sum(MONTONATIVO)) ELSE 0 END '
   + ' ,Subcuenta		= TIPO_MOV '   
   + ' , SerieLote		= CASE  WHEN sum(MONTONATIVO) >0' + ' THEN ' + char(39) + 'C'+CHAR(39) + ' ELSE ' + CHAR(39) + 'A' + CHAR(39) + ' END '
   + ' ,Proveedor		= RTRIM(LTRIM(CCLIE)) ' 
   + ' ,Impuesto1		=  IVAFISCAL '	-- % de impuesto IVA
   + ' ,Impuesto2		=  IEPSFISCAL '	-- % de impuesto IVA
   + ' ,Gastos			=  IMPUESTOS '	-- Total de impuestos   
   + ' FROM #CXC GROUP BY CCLIE,REFER,FECHA_APLI,FECHA_VENC,DESCR,TIPO_MOV,NUM_MONED,DESCRMON,NO_FACTURA,DOCTO,TCAMBIO, CCONREFER,IVAFISCAL,IEPSFISCAL,IMPUESTOS'
   + ' HAVING ABS(SUM(MONTONATIVO)) > 0.01 '

EXEC sp_executeSQL @Sql,
					 N'@GID uniqueidentifier, @Modulo varchar(15), @Cuenta varchar(30), @ConfE varchar(30), @Moneda varchar(30), @Estatus varchar(30)',
					 @GID     = @GID,
					 @Modulo  = @Modulo,
					 @Cuenta  = @Cuenta,
					 @ConfE	  = @ConfE,
					 @Moneda  = @Moneda,
					 @Estatus = @Estatus
DECLARE @Descrip varchar(30)

  IF @@ERROR <> 0
	BEGIN
		RAISERROR('Falla al insertar en la tabla permanente de CXC',16,1)
	END

 ELSE
	BEGIN

		SELECT @Descrip = MovimientoIntelisisCxC
		FROM AspelCfgConceptos
		WHERE Tipo = 'C' And NumConcepto = 'Cualquier otro' And Modulo = 'CxC'
		
		UPDATE AspelCargaReg SET
		Mov = @Descrip
		WHERE Mov = @MovDebe And Modulo = 'CxC'
		
		SELECT @Descrip = MovimientoIntelisisCxC
		FROM AspelCfgConceptos
		WHERE Tipo = 'A' And NumConcepto = 'Cualquier otro' And Modulo = 'CxC'
		
		UPDATE AspelCargaReg SET
		Mov = @Descrip
		WHERE Mov = @MovHaber And Modulo = 'CxC'
		
		UPDATE AspelCargaReg SET
		Mov = C.MovimientoIntelisisCxC
		FROM AspelCargaReg A, AspelCfgConceptos C
		WHERE A.Subcuenta = C.NumConcepto And C.Modulo = 'CxC' AND A.MODULO = 'CXC' AND A.SerieLote = C.TIPO
	END


-- 
    -- CXP
    --Obtiene la cuenta que afectaran las cuentas por pagar
    SET @Cuenta = ''
	SET @Modulo = ''
	SET @Agrupador = ''
	SET @MovDebe = ''
	SET @MovHaber = ''
	SET @Estatus = ''
	SET @Sql = ''
	SET @Parametros = ''
	SET @Parametros = '@Cuenta varchar(30) OUTPUT, @Modulo varchar(15) OUTPUT, @Agrupador varchar(15) OUTPUT, @MovDebe varchar(20) OUTPUT, @MovHaber varchar(20) OUTPUT, @Estatus varchar(15) OUTPUT'
	SET @Sql =  'SELECT '
    + '@Cuenta = MAYOR '
    + ', @Modulo = Modulo '
    + ', @Agrupador = Agrupador '
    + ', @MovDebe = CASE AfectaContabilidad WHEN 1 THEN MovDebeContable ELSE MovDebeNoContable END'
    + ', @MovHaber = CASE AfectaContabilidad WHEN 1 THEN MovHaberContable ELSE MovHaberNoContable END'
    + ', @Estatus = CASE AfectaContabilidad WHEN 1 THEN EstatusContable ELSE EstatusNoContable END '
    + 'FROM '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfgModuloMayor WHERE DESCRIPCION = ' + CHAR(39) + 'Proveedores' + CHAR(39) + ''
	EXEC sp_executesql @Sql, @Parametros, 
                       @Cuenta = @Cuenta OUTPUT, 
                       @Modulo = @Modulo OUTPUT, 
                       @Agrupador = @Agrupador OUTPUT, 
                       @MovDebe = @MovDebe OUTPUT,
					   @MovHaber = @MovHaber OUTPUT,
					   @Estatus = @Estatus OUTPUT

CREATE TABLE #CXP
(
	CPROV		varchar(5)	NOT NULL,
	REFER		VARCHAR(9)	NOT NULL,
	TIPO		VARCHAR(1)	NOT NULL,
	IMPORTEMN	FLOAT		NOT NULL,
	IMPORTEME	FLOAT		NOT NULL,
	FECHA_APLI	DATETIME	NULL,
	FECHA_VENC	DATETIME	NULL,
	DESCR	VARCHAR (30)	NULL,
	TIPO_MOV VARCHAR(2)		NULL,	
	NUM_MONED VARCHAR(2)	NULL,
	DESCRMON VARCHAR(20)	NULL,
	MONTONATIVO FLOAT		NULL,
	NO_FACTURA VARCHAR(7)	NULL,
	DOCTO VARCHAR (9)		NULL,
	MOV VARCHAR(20)			NULL,
	TCAMBIO float(15)	NULL,
	CCONREFER VARCHAR(1) NULL,
	IVAFISCAL FLOAT NULL,
	IEPSFISCAL FLOAT NULL,
	IMPUESTOS FLOAT	NULL
)

SET @Sql = '' 
+ 'INSERT #CXP '
+ 'SELECT ltrim(rtrim(A.CPROV)),ltrim(rtrim(A.REFER)), TIPO, CASE WHEN B.TIPO = ' + char(39) + 'C' + char(39)+ ' THEN SUM(IMPORTE) '
+ 'ELSE -SUM(IMPORTE) END AS IMPORTEMN,CASE WHEN B.TIPO = ' + char(39)+ 'C' + char(39)+ ' THEN SUM(IMPMON_EXT) '
+ 'ELSE -SUM(IMPMON_EXT) END AS IMPORTEME,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL '
+ ' FROM ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.PAGA01 A '
+ 'INNER JOIN ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.CONP01 B ON A.TIPO_MOV = B.NUM_CPTO '
+ 'GROUP BY CPROV,REFER,TIPO '
+ 'HAVING ABS((SUM(IMPORTE)) + ABS(SUM(IMPMON_EXT))) >0 '
EXEC sp_executesql @Sql


 CREATE TABLE #CXPFECHAS
(
	NUM_REG		int NOT NULL,
	CPROV		VARCHAR(5) NULL,
	FECHA_APLI	DATETIME  NULL,
	FECHA_VENC	DATETIME  NULL,
	DESCR	VARCHAR (30) NULL,
	REFER		VARCHAR(9) NOT NULL,
	TIPO_MOV VARCHAR(2) NULL,
	NUM_MONED VARCHAR(2) NULL,
	NO_FACTURA VARCHAR(7) NULL,
	DOCTO VARCHAR (9) NULL,
	TCAMBIO float(15)	NULL,
	CCONREFER VARCHAR(1) NULL
)

SET @Sql = ''
+ 'INSERT #CXPFECHAS '
+ 'SELECT  DISTINCT A.NUM_REG, ltrim(rtrim(CPROV)),FECHA_APLI,FECHA_VENC,DESCR, ltrim(rtrim(REFER)),TIPO_MOV,NUM_MONED,NO_FACTURA, DOCTO,TCAMBIO, CCONREFER ' -- igr se agregó CCONREFER 220109
+ ' FROM ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.PAGA01 A '
+ 'INNER JOIN ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.CONP01 B ON A.TIPO_MOV = B.NUM_CPTO '
+ 'WHERE A.CCONREFER = ' + CHAR(39) + 'N' + CHAR(39) 
+ ' ORDER BY A.NUM_REG DESC '
EXEC sp_executesql @Sql



UPDATE #CXP  SET TIPO_MOV = #CXPFECHAS.TIPO_MOV FROM #CXPFECHAS 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS.CPROV))


UPDATE #CXP  SET FECHA_APLI = #CXPFECHAS.FECHA_APLI FROM #CXPFECHAS 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS.CPROV))

UPDATE #CXP  SET FECHA_VENC = #CXPFECHAS.FECHA_VENC FROM #CXPFECHAS 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS.CPROV))

UPDATE #CXP  SET DESCR = #CXPFECHAS.DESCR FROM #CXPFECHAS 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS.CPROV))

UPDATE #CXP  SET NUM_MONED = #CXPFECHAS.NUM_MONED FROM #CXPFECHAS 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS.CPROV))

UPDATE #CXP  SET NO_FACTURA = #CXPFECHAS.NO_FACTURA FROM #CXPFECHAS 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS.CPROV))

UPDATE #CXP  SET DOCTO = #CXPFECHAS.DOCTO FROM #CXPFECHAS 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS.CPROV))

UPDATE #CXP  SET TCAMBIO = #CXPFECHAS.TCAMBIO FROM #CXPFECHAS 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS.CPROV))

UPDATE #CXP  SET CCONREFER = #CXPFECHAS.CCONREFER FROM #CXPFECHAS 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS.CPROV))

--  MOVIMIENTOS 'HUERFANOS'

 CREATE TABLE #CXPFECHAS2
(
	NUM_REG		int NOT NULL,
	CPROV		VARCHAR(5) NULL,
	FECHA_APLI	DATETIME  NULL,
	FECHA_VENC	DATETIME  NULL,
	DESCR	VARCHAR (30) NULL,
	REFER		VARCHAR(9) NOT NULL,
	TIPO_MOV VARCHAR(2) NULL,
	NUM_MONED VARCHAR(2) NULL,
	NO_FACTURA VARCHAR(7) NULL,
	DOCTO VARCHAR (9) NULL,
	TCAMBIO float(15)	NULL,
	CCONREFER VARCHAR(19) NULL
)

SET @Sql = ''
+ 'INSERT #CXPFECHAS2 '
+ 'SELECT  DISTINCT A.NUM_REG, ltrim(rtrim(CPROV)),FECHA_APLI,FECHA_VENC,DESCR, ltrim(rtrim(REFER)),TIPO_MOV,NUM_MONED,NO_FACTURA, DOCTO,TCAMBIO, CCONREFER ' -- igr se agregó CCONREFER 220109
+ ' FROM ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.PAGA01 A '
+ 'INNER JOIN ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.CONP01 B ON A.TIPO_MOV = B.NUM_CPTO '
+ 'WHERE A.CCONREFER = ' + CHAR(39) + 'S' + CHAR(39) 
+ ' ORDER BY A.NUM_REG ASC '
EXEC sp_executesql @Sql

UPDATE #CXP  SET TIPO_MOV = #CXPFECHAS2.TIPO_MOV FROM #CXPFECHAS2 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS2.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS2.CPROV)) AND #CXP.FECHA_APLI IS NULL
UPDATE #CXP  SET FECHA_VENC = #CXPFECHAS2.FECHA_VENC FROM #CXPFECHAS2 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS2.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS2.CPROV)) AND #CXP.FECHA_APLI IS NULL
UPDATE #CXP  SET DESCR = #CXPFECHAS2.DESCR FROM #CXPFECHAS2 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS2.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS2.CPROV)) AND #CXP.FECHA_APLI IS NULL
UPDATE #CXP  SET NUM_MONED = #CXPFECHAS2.NUM_MONED FROM #CXPFECHAS2 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS2.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS2.CPROV)) AND #CXP.FECHA_APLI IS NULL
UPDATE #CXP  SET NO_FACTURA = #CXPFECHAS2.NO_FACTURA FROM #CXPFECHAS2 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS2.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS2.CPROV)) AND #CXP.FECHA_APLI IS NULL
UPDATE #CXP  SET DOCTO = #CXPFECHAS2.DOCTO FROM #CXPFECHAS2 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS2.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS2.CPROV)) AND #CXP.FECHA_APLI IS NULL
UPDATE #CXP  SET TCAMBIO = #CXPFECHAS2.TCAMBIO FROM #CXPFECHAS2 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS2.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS2.CPROV)) AND #CXP.FECHA_APLI IS NULL
UPDATE #CXP  SET CCONREFER = #CXPFECHAS2.CCONREFER FROM #CXPFECHAS2 
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS2.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS2.CPROV)) AND #CXP.FECHA_APLI IS NULL
UPDATE #CXP  SET FECHA_APLI = #CXPFECHAS2.FECHA_APLI FROM #CXPFECHAS2
WHERE ltrim(rtrim(#CXP.REFER)) = ltrim(rtrim(#CXPFECHAS2.REFER)) AND ltrim(rtrim(#CXP.CPROV)) = ltrim(rtrim(#CXPFECHAS2.CPROV)) AND #CXP.FECHA_APLI IS NULL

--

SET @Sql = ''
+ 'UPDATE #CXP  SET DESCRMON  = A.DESCR FROM '  + @ServidorOrigen + '.' + @BaseDatosOrigen +'.' + 'dbo.MONED01  A '
+ 'WHERE CONVERT(BINARY(2),#CXP.NUM_MONED) = CONVERT(BINARY(2),A.NUM_MONED)'
EXEC sp_executesql @Sql

UPDATE #CXP  SET MONTONATIVO  = CASE WHEN  NUM_MONED = '1' THEN IMPORTEMN ELSE IMPORTEME END

-- Actualiza datos de impuestos 1 y 2


 CREATE TABLE #COMIMPUESTOS
(
	CVE_DOC			VARCHAR(7) NOT NULL,
	TIP_DOC			VARCHAR(5) NULL,
	IMPUESTO1		FLOAT  NULL,
	IMPUESTO2		FLOAT,
	TOTALIMPUESTOS	FLOAT		
)

SET @Sql = ''
+ 'INSERT #COMIMPUESTOS ' 
+ ' SELECT CVE_DOC, TIP_DOC,(IMP_TOT1)/(CAN_TOT-DES_TOT-DES_FIN+IMP_TOT1+IMP_TOT4+(COSTOFLET*ISNULL(IMPUEFLET,0)/100)-(COSTOFLET*ISNULL(RETENFLET,0)/100)+COSTOFLET) , '
+ ' ((IMP_TOT4)+(COSTOFLET*ISNULL(IMPUEFLET,0)/100)-(COSTOFLET*ISNULL(RETENFLET,0))/100)/(CAN_TOT-DES_TOT-DES_FIN+IMP_TOT1+IMP_TOT4+(COSTOFLET*ISNULL(IMPUEFLET,0)/100)-(COSTOFLET*ISNULL(RETENFLET,0)/100)+COSTOFLET), (IMP_TOT4+IMP_TOT1+(COSTOFLET*ISNULL(IMPUEFLET,0)/100)-(COSTOFLET*ISNULL(RETENFLET,0)/100))/TIPCAMB '
+ ' FROM ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.COMP01 '
+ ' WHERE TIP_DOC =  ' + CHAR(39) + 'C' + CHAR(39) + ' AND STATUS <> ' + CHAR(39) + 'C' + CHAR(39) 
+ 'ORDER BY NUM_REG ASC '
EXEC sp_executesql @Sql



UPDATE #CXP  SET IEPSFISCAL = IMPUESTO1 FROM #COMIMPUESTOS				-- IEPS
WHERE ltrim(rtrim(#CXP.DOCTO)) = ltrim(rtrim(#COMIMPUESTOS.CVE_DOC))

UPDATE #CXP  SET IVAFISCAL = IMPUESTO2 FROM #COMIMPUESTOS				--IVA
WHERE ltrim(rtrim(#CXP.DOCTO)) = ltrim(rtrim(#COMIMPUESTOS.CVE_DOC))

UPDATE #CXP  SET IMPUESTOS = TOTALIMPUESTOS FROM #COMIMPUESTOS			--TOTAL IMPUESTOS
WHERE ltrim(rtrim(#CXP.DOCTO)) = ltrim(rtrim(#COMIMPUESTOS.CVE_DOC))


-- cASO 

UPDATE #CXP  SET IVAFISCAL = 0.1304347826,IEPSFISCAL = 0, IMPUESTOS = NULL --ABS(MONTONATIVO * 0.1304347826)									--IVA
WHERE IVAFISCAL IS NULL

-----
/*

select 'DESPUES DE ACTUALIZAR IMPUESTOS CXP', * from #CXP
*/


--Llena la tabla de carga
    SET @Sql = ''
   + ' INSERT '+ @ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCargaReg (GID, CargaGID, Modulo, Mayor, Empresa, Proveedor, Moneda, Mov, Estatus, TipoCambio, FechaEmision, Concepto, Referencia, MovID, Vencimiento, cantidad, Debe, Haber, Subcuenta, Serielote,cliente, Impuesto1, Impuesto2, Gastos)'
   + ' SELECT '
   + '  GID				=	NewId() '
   + ' ,CargaGID		=	@GID '
   + ' ,Modulo			=	@Modulo '
   + ' ,Mayor			=	@Cuenta '
   + ' ,Empresa			=	@ConfE '
   + ' ,Proveedor			=	dbo.fnAspelJustificaClave(LTRIM(CPROV))'
   + ' ,Moneda			=	DESCRMON '
   + ' ,Mov				=	CASE  WHEN sum(MONTONATIVO) >0' + ' THEN ' + char(39) + @Movdebe + char(39) + ' ELSE ' + char(39) + @Movhaber + char(39) + ' END '  
   + ' ,Estatus			=	@Estatus '
   + ' ,TipoCambio		=	ROUND(TCAMBIO,5) '
   + ' ,FechaEmision	=	FECHA_APLI '
   + ' ,Concepto		=	' + CHAR(39) + 'Proveedor' + CHAR(39) + ' '
   + ' ,Referencia		=	LTRIM(RTRIM(DESCR)) + ' + CHAR(39) + ' ' + CHAR(39) + ' + LTRIM(RTRIM(NO_FACTURA)) ' +' + CASE  WHEN CCONREFER = ' + char(39) + 'S' + char(39) + ' THEN  ' + char(39) + 'POR ACLARAR' + char(39) + ' ELSE ' + char(39) + '' + char(39) + ' END '  
   + ' ,MovId			=	LTRIM(RTRIM(CPROV)) + ' + CHAR(39) + '-' + CHAR(39) + ' + LTRIM(RTRIM(REFER))' --+' + CHAR(39) + '-' + CHAR(39) + '+ LEFT(NewId(),2)' 
   + ' ,Vencimiento		=	FECHA_VENC '
   + ' ,Cantidad		=	1 '
   + ' ,DEBE 			=  CASE  WHEN sum(MONTONATIVO) >0' + ' THEN ABS(sum(MONTONATIVO)) ELSE 0 END '  
   + ' ,HABER 			=   CASE  WHEN sum(MONTONATIVO) <0' + ' THEN ABS(sum(MONTONATIVO)) ELSE 0 END '
   + ' ,Subcuenta		= TIPO_MOV '   
   + ' , SerieLote		= CASE  WHEN sum(MONTONATIVO) >0' + ' THEN ' + char(39) + 'C'+CHAR(39) + ' ELSE ' + CHAR(39) + 'A' + CHAR(39) + ' END '
   + ',Cliente			= RTRIM(LTRIM(CPROV)) ' 
   + ' ,Impuesto1		=  IVAFISCAL '	-- % de impuesto IVA
   + ' ,Impuesto2		=  IEPSFISCAL '	-- % de impuesto IVA
   + ' ,Gastos			=  IMPUESTOS '	-- Total de impuestos   
   + ' FROM #CXP GROUP BY CPROV,REFER,FECHA_APLI,FECHA_VENC,DESCR,TIPO_MOV,NUM_MONED,DESCRMON,NO_FACTURA,DOCTO,TCAMBIO,CCONREFER,IVAFISCAL,IEPSFISCAL,IMPUESTOS'
   + ' HAVING ABS(SUM(MONTONATIVO)) > 0.01 '

EXEC sp_executeSQL @Sql,
					 N'@GID uniqueidentifier, @Modulo varchar(15), @Cuenta varchar(30), @ConfE varchar(30), @Moneda varchar(30), @Estatus varchar(30)',
					 @GID     = @GID,
					 @Modulo  = @Modulo,
					 @Cuenta  = @Cuenta,
					 @ConfE	  = @ConfE,
					 @Moneda  = @Moneda,
					 @Estatus = @Estatus

  IF @@ERROR <> 0
	BEGIN
		RAISERROR('Falla al insertar en la tabla permanente de CXP',16,1)
	END

 ELSE
	BEGIN

		SELECT @Descrip = MovimientoIntelisisCxP
		FROM AspelCfgConceptos
		WHERE Tipo = 'C' And NumConcepto = 'Cualquier otro' And Modulo = 'CxP'
		
		UPDATE AspelCargaReg SET
		Mov = @Descrip
		WHERE Mov = @MovDebe And Modulo = 'CxP'
		
		SELECT @Descrip = MovimientoIntelisisCxP
		FROM AspelCfgConceptos
		WHERE Tipo = 'A' And NumConcepto = 'Cualquier otro' And Modulo = 'CxP'
		
		UPDATE AspelCargaReg SET
		Mov = @Descrip
		WHERE Mov = @MovHaber And Modulo = 'CxP'
		
		UPDATE AspelCargaReg SET
		Mov = C.MovimientoIntelisisCxP
		FROM AspelCargaReg A, AspelCfgConceptos C
		WHERE A.Subcuenta = C.NumConcepto And C.Modulo = 'CxP' AND A.MODULO = 'CxP' AND A.SerieLote = C.TIPO
	END

IF @ImportarCOI = 1
BEGIN

	/*********** Carga de Polizas Contables ***********/
    --Obtiene los datos por omision (La cuenta contable ya no se utiliza)
	SET @Cuenta = ''
	SET @Modulo = ''
	SET @Agrupador = ''
	SET @MovDebe = ''
	SET @MovHaber = ''
	SET @Estatus = ''
	SET @Sql = ''
	SET @Parametros = ''
	SET @Parametros = '@Cuenta varchar(30) OUTPUT, @Modulo varchar(15) OUTPUT, @Agrupador varchar(15) OUTPUT, @MovDebe varchar(20) OUTPUT, @MovHaber varchar(20) OUTPUT, @Estatus varchar(15) OUTPUT'
	SET @Sql =  'SELECT '
    + '@Cuenta = MAYOR '
    + ', @Modulo = Modulo '
    + ', @Agrupador = Agrupador '
    + ', @MovDebe = CASE AfectaContabilidad WHEN 1 THEN MovDebeContable ELSE MovDebeNoContable END'
    + ', @MovHaber = CASE AfectaContabilidad WHEN 1 THEN MovHaberContable ELSE MovHaberNoContable END'
    + ', @Estatus = CASE AfectaContabilidad WHEN 1 THEN EstatusContable ELSE EstatusNoContable END '
    + 'FROM '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCfgModuloMayor WHERE DESCRIPCION = ' + CHAR(39) + 'Contabilidad' + CHAR(39) + ''
	EXEC sp_executesql @Sql, @Parametros, 
                       @Cuenta = @Cuenta OUTPUT, 
                       @Modulo = @Modulo OUTPUT, 
                       @Agrupador = @Agrupador OUTPUT, 
                       @MovDebe = @MovDebe OUTPUT,
					   @MovHaber = @MovHaber OUTPUT,
					   @Estatus = @Estatus OUTPUT


	---Creo Tabla Temporal
	CREATE TABLE #POL 
	( 	 Empresa	varchar(10)	NULL, 
		 Sucursal	int			NULL,
		 Cuenta		varchar(50)	NULL, 
		 Concepto	varchar(250)	NULL,
		 Moneda		varchar(10) NULL, 
		 TipoCambio float(15)	NULL, 
		 Fecha		datetime	NULL, 
		 DEBE		decimal(15,7)	NULL,	
		 HABER		decimal(15,7)	NULL, 		 
		 Mov		varchar(20)	NULL,
		 Tipo		varchar(20) NULL,
		 Numero		varchar(20)	NULL,
		 Subcuenta	varchar(50) NULL,
		 Serielote	varchar(4) NULL,
		 ConceptoC	varchar(250)	NULL
	) 

    SELECT @CadenaAgrupacion = CASE @Agrupador
	  WHEN 'Movimiento' THEN 'FECHA_POL, NUM_POLIZ, CONCEP_PO, '
      WHEN 'Dia'		THEN 'FECHA_POL, '
	  WHEN 'Semana'		THEN 'DATEADD(DD, - DATEPART(DW,FECHA_POL),DATEADD(WW,1,FECHA_POL)), '
      WHEN 'Mes'		THEN 'DATEADD(DD, - DAY(FECHA_POL),DATEADD(MM,1,FECHA_POL)), '	
      WHEN 'Año'		THEN 'DATEADD(DD, - DATEPART(DY,FECHA_POL),DATEADD(YY,1,FECHA_POL)), '
      ELSE 'FECHA_POL, '
    END

	SET @Sql = '' 
	+ CASE 
        WHEN @Agrupador = 'Movimiento' THEN 'INSERT #POL (Numero, Concepto, Cuenta, TipoCambio, Fecha, DEBE, HABER, Mov,Subcuenta, Tipo, SerieLote, ConceptoC) '
        ELSE 'INSERT #POL (Cuenta, TipoCambio, Fecha, DEBE, HABER, Mov, Tipo, ConceptoC) ' END
	+ 'SELECT  '
	+ CASE WHEN @Agrupador = 'Movimiento' THEN 'Numero = NUM_POLIZ, ' ELSE '' END
	+ CASE WHEN @Agrupador = 'Movimiento' THEN 'Concepto = CONCEP_PO, ' ELSE '' END
	+ 'Cuenta		=	LEFT(NUM_CTA,20), '
	+ 'TipoCambio	=	TIPCAMBIO,  '
	+ 'Fecha		= ' + CASE WHEN @Agrupador = 'Movimiento' THEN 'FECHA_POL, ' ELSE @CadenaAgrupacion END	
	+ 'DEBE			=	CASE WHEN DEBE_HABER = ' + CHAR(39) + 'D' + CHAR(39) + ' THEN SUM(ISNULL(MONTOMOV,0)) ELSE 0 END, '
	+ 'HABER		=	CASE WHEN DEBE_HABER = ' + CHAR(39) + 'H' + CHAR(39) + ' THEN SUM(ISNULL(MONTOMOV,0)) ELSE 0 END, '
    + 'Mov			=   dbo.fnAspelConversion(' + char(39) + 'POLIZAS' + char(39) + ',' + char(39) + 'TIPO_POLI' + char(39) + ',TIPO_POLI), '
    + 'Subcuenta	=   CASE WHEN NUMDEPTO = ' + CHAR(39) + '0' + CHAR(39) + ' THEN NULL ELSE NUMDEPTO END, '  
    + 'Tipo			=	TIPO_POLI, '
    + 'SerieLote	=	SUBSTRING(REFERENCIA,3,4), '
    + 'ConceptoC	=	Concep_ca '
    + 'FROM '+@ServidorOrigen+'.'+@BaseDatosOrigen+'.dbo.POLIZAS ' --POLIZAS
	+ 'GROUP BY ' + @CadenaAgrupacion + ' LEFT(NUM_CTA,20), TIPCAMBIO, DEBE_HABER, TIPO_POLI,NUMDEPTO, Referencia, Concep_ca '     
	

	EXEC Sp_ExecuteSql @Sql

    IF @@ERROR <> 0
      RAISERROR('Falla al insertar en la tabla temporal de Polizas',16,1)

	SET @Sql =  '' 
	+ ' INSERT '+@ServidorDestino + '.' + @BaseDatosDestino + '.dbo.AspelCargaReg(GID, CargaGID, Modulo,Empresa,Sucursal, Mayor, Mov, MovID, TipoCambio, FechaEmision, Debe, Haber, Concepto, Estatus,Centrocostos, Referencia, Clase, Subclase) '
	+ ' SELECT ' 
	+ '  GID			=	NewId() '
	+ ' ,CargaGID		=	@GID '
	+ ' ,Modulo		    =	@Modulo '
	+ ' ,Empresa		=	@ConfE '
	+ ' ,Sucursal 	    =	@ConfS '
	+ ' ,Mayor			=	Cuenta '
	+ ' ,Mov			=	CASE WHEN left(Serielote,2) = ' + CHAR(39) + '13' + CHAR(39) + 'THEN ' + CHAR(39) + 'Cierre' + CHAR(39) + ' ELSE Mov END'
	+ ' ,MovID			=	CASE WHEN left(Serielote,2) = ' + CHAR(39) + '13' + CHAR(39) + 'THEN  Mov +' + CHAR(39) + '-' + CHAR(39) + '+ Numero ELSE Numero END'
	--+ ' ,MovID			=	Numero '
	+ ' ,TipoCambio		=	TipoCambio ' 
	+ ' ,FechaEmision	=	Fecha ' 
	+ ' ,Debe			=	Debe ' 
	+ ' ,Haber			=	Haber '
	+ ' ,Concepto		=	Concepto '
	+ ' ,Estatus		=	@Estatus '
	+ ' ,Subcuenta		=	Subcuenta '
	+ ' ,Referencia		=	Tipo '
	+ ' ,Clase			=	left(ConceptoC,50) '
	+ ' ,SubClase		=	substring(ConceptoC,51,50) '
	+ ' FROM #POL '

	EXEC sp_ExecuteSql @Sql, 
	    			   N'@GID uniqueidentifier, @Modulo varchar(15), @Cuenta varchar(30), @ConfE varchar(30), @ConfS int, @Estatus varchar(30)', 
					   @GID = @GID,
					   @Modulo = @Modulo,	
					   @Cuenta = @Cuenta,
					   @ConfE = @ConfE,
					   @ConfS = @ConfS,
					   @Estatus = @Estatus
					   
	IF @@ERROR <> 0
	  RAISERROR('Falla al insertar en la tabla  permanente de Contabilidad',16,1)

END


--Carga de Propiedades
  --Carga vendedores
	--AGENTES
	SET @Sql = ''
	SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo,Valor,Nombre, Estatus, TipoComision,'
	+'Porcentaje, eMail, Tipo, Familia, Proveedor)' --  Proveedor
		SET @Sql = @Sql + ' SELECT  NewID() '
        + ', @GID '
        + ', ' + char(39)+'Agente'+ char(39) + ' '
        + ', dbo.fnAspelJustificaClave(LTRIM(RTRIM(CLV_VEND))) '
        + ',NOMBRE '
        + ',dbo.fnAspelConversion(' + char(39) + 'VEND01' + char(39) + ',' + char(39) + 'STATUS' + char(39) + ',STATUS) '
        + ','+ char(39) + 'por Factura' + char(39) + ' '
        + ',COMI '
        + ',CORREOE '
        + ','+ char(39) + 'Vendedor' + char(39) + ', CLASIFIC ' + ', LTRIM(RTRIM(CLV_VEND)) ' --  Proveedor
		SET @Sql = @Sql + ' FROM '+	@ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.VEND01' 
		EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID



  --Carga Almacenes
		SET @Sql = ''
		SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo,Valor,Nombre, Estatus) '
		SET @Sql = @Sql + ' SELECT  NewID() '
        + ', @GID '
        + ', ' + char(39)+'Almacen'+ char(39) + ' '
        + ',LTRIM(ALMACEN) '
        + ',' + char(39) + 'Almacen Aspel Sae ' + char(39) + ' + LTRIM(ALMACEN) ' 
        + ',dbo.fnAspelConversion(' + char(39) + 'MULT01' + char(39) + ',' + char(39) + 'STATUS' + char(39) + ',STATUS) '
		+ ' FROM '+	@ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.MULT01 WHERE STATUS = '  + CHAR(39) + 'A' + CHAR(39)
		+ ' GROUP BY ALMACEN, STATUS' 
		EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID


--ARTICULOS
--Carga articulos

        SELECT @CampoImpuesto1 = Valor FROM AspelCfgOpcion WHERE Descripcion = 'IVA Articulo'
        SELECT @CampoImpuesto2 = Valor FROM AspelCfgOpcion WHERE Descripcion = 'IEPS Articulo'
        SELECT @CampoImpuesto3 = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Impuesto 3 Articulo'
        
        SET @CampoImpuesto1 = CASE @CampoImpuesto1
        WHEN 'IMPU4' THEN ',B.IMPUESTO4 ' 
        WHEN 'IMPU1' THEN ',B.IMPUESTO1 '         
        ELSE ',0 '
        END

        SET @CampoImpuesto2 = CASE @CampoImpuesto2
        WHEN 'IMPU4' THEN ',B.IMPUESTO4 ' 
        WHEN 'IMPU1' THEN ',B.IMPUESTO1 '         
        ELSE ',0 '
        END

        SET @CampoImpuesto3 = CASE @CampoImpuesto3
        WHEN 'IMPU2+IMPU3' THEN ',B.IMPUESTO2 + B.IMPUESTO3  '               
        ELSE ',0 '
        END

	SET @Sql = ''
	SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' + @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo,Valor,Nombre, Unidad, Estatus, Tipo, Linea, Impuesto1, Impuesto2, Impuesto3,'
	+ 'Proveedor, TiempoEntrega, TiempoEntregaU, PrecioLista, Precio2,'
	+ 'Precio3, Precio4, Precio5, Peso, Volumen, TipoCosteo, Costo, Descripcion, Descripcion2, Categoria, Rama, CURP)'
	SET @Sql = @Sql + ' SELECT NewID() '
        + ', @GID '
        + ', ' + char(39)+'Articulo'+ char(39) + ' ' 
        + ',LTRIM(A.CLV_ART) '
        + ',A.DESCR '
        + ',A.UNI_MED '
        + ',dbo.fnAspelConversion(' + char(39) + 'INVE01' + char(39) + ',' + char(39) + 'STATUS' + char(39) + ',A.STATUS) '
        + ',CASE WHEN TIPO_ELE = ' + CHAR(39) + 'K' + CHAR(39) + ' THEN ' + CHAR(39) + 'Juego' + CHAR(39) + ' '
        + 'WHEN TIPO_ELE = ' + CHAR(39) + 'S' + CHAR(39) + ' THEN ' + CHAR(39) + 'Servicio' + CHAR(39) + ' '
        + 'ELSE dbo.fnAspelConversion(' + char(39) + 'INVE01' + char(39) + ',' + char(39) + 'NUM_SERIE' + char(39) + ',A.NUM_SERIE) END '
        + ',A.LIN_PROD '
        + @CampoImpuesto1
        + @CampoImpuesto2
        + @CampoImpuesto3
        + ',RTRIM(LTRIM(A.PROVEEDOR1)) '
        + ',A.TIEM_SURT '
        + ',' + char(39) + 'Dias' + Char(39) + ' '
        + ',A.PRECIO1 '
        + ',A.PRECIO2 '
        + ',A.PRECIO3 '
        + ',A.PRECIO4 '
        + ',A.PRECIO5 '
        + ',A.PESO '
        + ',A.VOLUMEN '
        + ',dbo.fnAspelConversion(' + char(39) + 'INVE01' + char(39) + ',' + char(39) + 'TIP_COSTEO' + char(39) + ',A.TIP_COSTEO) '
        + ',A.ULT_COSTO, REPLACE(A.CLV_ALTER,' + CHAR(39) + ' ' + CHAR(39) + ', ' + CHAR(39) + '' + CHAR(39) + ') '
        + ', SUBSTRING(ISNULL(OI.X_OBSER, ' + CHAR(39) + '' + CHAR(39) + '),1,100) '
        + ',CASE WHEN TIPO_ELE <> ' + CHAR(39) + 'T' + CHAR(39) + ' THEN ' + CHAR(39) + 'No' + CHAR(39) + ' ELSE ' + CHAR(39) + 'Si' + CHAR(39) + ' END '
        + ', MO.DESCR '
		+ ',A.UNI_ALT '
		+ ' FROM '+ @ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.INVE01 A '
		+ 'LEFT OUTER JOIN ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.IMPU01 B ON A.CVEESQIMP = B.CVEESQIMPU '
        + 'LEFT OUTER JOIN ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.OINV01 OI ON A.NUM_REG = OI.NUM_REG '
        + 'LEFT OUTER JOIN ' + @ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.MONED01 MO ON LTRIM(RTRIM(A.NUM_MON)) = LTRIM(RTRIM(MO.NUM_MONED)) '
	
	EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID

		-- Posible error en esquemas de impuestos vacíos

			UPDATE ASPELCARGAPROP SET IMPUESTO1 = 15 WHERE CAMPO = 'Articulo' and Impuesto1 is null


CREATE TABLE #Artnoencontrados
	( 	  
		 Articulo	varchar(20)	NULL,
		 
	) 

INSERT #Artnoencontrados 
SELECT DISTINCT(ARTICULO) FROM  ASPELCARGAreg  where
ARTICULO NOT IN (SELECT VALOR FROM ASPELCARGAPROP WHERE CAMPO = 'Articulo')
AND ARTICULO NOT IN ('FLETE','INDIRECTOS') AND ARTICULO IS NOT NULL 
AND (SELECT COUNT(*) FROM ASPELCARGAREG WHERE MODULO IN ('VTAS', 'COMS')) > 0


SET @Sql = ''
	SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' + @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp 
(GID, CargaGID, Campo,Valor,Nombre, Unidad, Estatus, Tipo,  Impuesto1, Impuesto2, Impuesto3,'
	+ ' PrecioLista, Precio2,'
	+ 'Precio3, Precio4, Precio5,  TipoCosteo, Costo, Categoria, Rama)'
	SET @Sql = @Sql + ' SELECT NewID() '
        + ', @GID '
		+ ', ' + char(39)+'Articulo'+ char(39) + ' ' 
        + ',Articulo '
        + ', '+ char(39) + 'Artículo dado de baja ASPEL-SAE' + CHAR(39)
        + ', '+ char(39) + 'pza' + CHAR(39)
        + ', '+ char(39) + 'ALTA' + CHAR(39)
		+ ', '+ char(39) + 'Normal' + CHAR(39)                		
        + ',0 '
        + ',0 '
        + ',0 '        
        + ',0 '
        + ',0 '
        + ',0 '
        + ',0 '
        + ',0 '        
        + ', '+ char(39) + 'Promedio' + CHAR(39)
        + ',0 '    
		+ ', '+ char(39) + 'No' + CHAR(39)
		+ ', '+ char(39) + 'Pesos' + CHAR(39)  
  
	+ ' FROM #Artnoencontrados '
	
		EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID

--Carga unidades de medida

	---Creo Tabla Temporal
	CREATE TABLE #Unidad
	( 	 Unidad		varchar(2)	NULL, 
		 Articulo	varchar(20)	NULL,
		 Factor		float(15) 	NULL,
		 Peso		float(15)	NULL,
		 Volumen	float(15)	NULL,
		 UniAlt		Varchar(2)	NULL
	) 
		SET @Sql = ''
		SET @Sql = @Sql + ' INSERT #Unidad (Unidad, Articulo, Factor, Peso, Volumen, UniAlt)'
		SET @Sql = @Sql + ' SELECT LTRIM(UNI_MED)'
        + ',LTRIM(RTRIM(CLV_ART)) '
        + ',FAC_CONV '
        + ',FAC_CONV * PESO '
        + ',FAC_CONV * VOLUMEN '
        + ', UNI_ALT '
		+ ' FROM ' +	@ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.INVE01 '
        + 'UNION SELECT LTRIM(UNI_ALT) ' 
        + ',LTRIM(RTRIM(CLV_ART)) ' 
        + ', 1 '
        + ',PESO '
        + ',VOLUMEN '
        + ', ' + CHAR(39) + CHAR(39) + ' '
        + ' FROM ' +	@ServidorOrigen + '.' + @BaseDatosOrigen + '.dbo.INVE01 '
		EXEC sp_executeSQL @Sql

		SET @Sql = ''
		SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' + @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo, Valor, Articulo, Factor, Peso, Volumen, Unidad )'
		SET @Sql = @Sql + ' SELECT DISTINCT NewID() '
        + ', @GID '
        + ', ' + char(39)+'Unidad'+ char(39) + ' ' 
        + ', Unidad '
        + ', Articulo '
        + ', Factor '
        + ', Peso '
        + ', Volumen '
        + ', UniAlt '
		+ ' FROM #Unidad '
		EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID


--Carga las monedas 
		SET @Sql = ''
		SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo,Valor,Nombre, Orden, TipoCambio, Clave)'
		SET @Sql = @Sql + ' SELECT NewID() '
        + ', @GID '
        + ', ' + char(39)+'Moneda'+ char(39) + ' '
        + ',DESCR '
        + ',DESCR '
        + ',NUM_MONED '
        + ',TCAMBIO '
		+ ',LEFT(SIMBOLO,3) '
		SET @Sql = @Sql + ' FROM '+	@ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.MONED01' 
		EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID



--Carga los proveedores
--Usamos el campo Rama para poner los días de crédito
--Usamos el campo Descripcion2 para poner las observaciones
	SET @Sql = ''
	SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, 
	Campo, Valor, Nombre, Descripcion, Direccion, Colonia, Poblacion, Zona, CodigoPostal, Telefonos, Fax, Email, 
	RFC, CURP, Estatus, Familia, Rama, Descripcion2, Factor,Tipo) '
	SET @Sql = @Sql + ' SELECT NewID(), @GID, ' + char(39)+'Proveedor'+ char(39) + ', dbo.fnAspelJustificaClave(LTRIM(RTRIM(P.CPROV))), '
	+ 'P.NOMBRE, P.NOMBRE, P.DIR, P.COLONIA, P.POB, P.CVE_ZONA, P.CODIGO, P.TELEFONO, P.FAX, SUBSTRING(P.EMAIL, 1,50), '
	+ 'P.RFC, P.CURP, dbo.fnAspelConversion(' + char(39) + 'PROV01' + char(39) + ',' + char(39) + 'STATUS' + char(39) + ',P.STATUS), P.CLASIFIC, CASE WHEN P.DIAS_CRE > 0 THEN CONVERT(VARCHAR, P.DIAS_CRE) + ' + CHAR(39) + ' DIAS' + CHAR(39) + ' ELSE NULL END '
	+ ', SUBSTRING(ISNULL(OP.X_OBSER, ' + CHAR(39) + '' + CHAR(39) + '),1,100), DESCUENTO,LTRIM(RTRIM(P.CPROV)) '
	SET @Sql = @Sql + ' FROM '+	@ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.PROV01 P ' 
	+ 'LEFT OUTER JOIN ' + @ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.OPRV01 OP ON P.NUM_REG = OP.NUM_REG '
	EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID

	Update aspelcargaprop
	SET RFC = REPLACE(RFC,'-','') WHERE CAMPO = 'proveedor'



CREATE TABLE #Pronoencontrados
	( 	  
		 Proveedor	varchar(5)	NULL,
		 
	) 

INSERT #Pronoencontrados 
SELECT DISTINCT(PROVEEDOR) FROM  ASPELCARGAreg  where
MODULO IN ('COMS','CXP') AND Proveedor NOT IN (SELECT VALOR FROM ASPELCARGAPROP WHERE CAMPO = 'Proveedor')

	SET @Sql = ''
	SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, 
	Campo, Valor, Nombre, Estatus) '
	SET @Sql = @Sql + ' SELECT NewID(), @GID, ' + char(39)+'Proveedor'+ char(39)
	+ ',Proveedor '
	+ ',' +  char(39) + 'Proveedor dado de baja en ASPEL-SAE' + char(39)
	+ ','+ CHAR(39) + 'ALTA' + CHAR(39) 	
	+ ' FROM #Pronoencontrados '
	
	EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID

--Carga los clientes
--Usamos el campo Rama para poner los días de crédito
--Usamos Impuesto1 para guardar límte de credito

	SET @Sql = ''
	SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo, 
	Valor, Nombre, Descripcion, Direccion, Colonia, Poblacion, CodigoPostal, Telefonos, Fax, Contacto, Email,  RFC,CURP, 
	Estatus, Grupo, Rama, Descripcion2, Impuesto1, Proveedor, Factor, Tipo) ' -- Temporal 030309 Tipo
	
	SET @Sql = @Sql + ' SELECT NewID(), @GID, ' + char(39)+'Cliente'+ char(39) 
	+ ',dbo.fnAspelJustificaClave(LTRIM(RTRIM(C.CCLIE))), C.NOMBRE, C.NOMBRE, C.DIR, C.COLONIA, C.POB, C.CODIGO, C.TELEFONO, C.FAX, C.ATENCION, SUBSTRING(C.EMAIL, 1,50), C.RFC, C.CURP, '
	+ 'dbo.fnAspelConversion(' + char(39) + 'CLIE01' + char(39) + ',' + char(39) + 'STATUS' + char(39) + ',C.STATUS), C.CLASIFIC, CASE WHEN C.DIAS_CRE > 0 THEN CONVERT(VARCHAR, C.DIAS_CRE) + ' + CHAR(39) + ' DIAS' + CHAR(39) + ' ELSE NULL END '
	+ ', SUBSTRING(ISNULL(OC.X_OBSER, ' + CHAR(39) + '' + CHAR(39) + '),1,100), C.LIM_CRED, '
	+ 'dbo.fnAspelJustificaClave(LTRIM(C.VEND)), C.DESCUENTO,LTRIM(RTRIM(C.CCLIE))  ' -- tEMPORAL 030309
	SET @Sql = @Sql + ' FROM '+ @ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.CLIE01 C ' 
	+ 'LEFT OUTER JOIN ' + @ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.OCLI01 OC ON C.NUM_REG = OC.NUM_REG '
	EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID


	Update aspelcargaprop
	SET RFC = REPLACE(RFC,'-','') WHERE CAMPO = 'cliente'

CREATE TABLE #Clinoencontrados
	( 	  
		 Cliente	varchar(5)	NULL,
		 
	) 

INSERT #Clinoencontrados 
SELECT DISTINCT(Cliente) FROM  ASPELCARGAreg  where
Modulo in ('VTAS','CXC') and Cliente NOT IN (SELECT VALOR FROM ASPELCARGAPROP WHERE CAMPO = 'Cliente')

	SET @Sql = ''
	SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo, 
	Valor, Nombre, 	Estatus) '
	SET @Sql = @Sql + ' SELECT NewID(), @GID, ' + char(39)+'Cliente'+ char(39) 	
	+ ',Cliente '
	+ ',' + char(39) + 'Cliente dado de baja en ASPEL-SAE' + CHAR(39)	
	+ ',' + char(39) + 'ALTA' + CHAR(39)
	SET @Sql = @Sql + ' FROM #Clinoencontrados '

	EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID


--Carga series de articulos
		SET @Sql = ''
		SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' + @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo,Valor, Articulo, Almacen,'
        + 'UltimaEntrada, UltimaSalida, Costo)'
		SET @Sql = @Sql + ' SELECT NewID() '
        + ', @GID '
        + ', ' + char(39)+'Serie'+ char(39) + ' ' 
        + ',LTRIM(A.NUM_SER) '
        + ',A.CVE_ART '
        + ',A.ALMACEN '
        + ',A.FECHA_ENT '
        + ',A.FECHA_SAL '
        --+ ',ISNULL(B.COSTO,0) ' 
        + ',0 ' 

		SET @Sql = @Sql + ' FROM '+	@ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.NUMSER01 A ' 
        --+ 'LEFT OUTER JOIN ' + @ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.MINV01 B '
        --+ 'ON RTRIM(LTRIM(A.DOCTO_ENT)) = RTRIM(LTRIM(B.REFER)) AND A.ALMACEN = B.ALMACEN AND A.CVE_ART = B.CLV_ART AND B.TIPO_MOV <= 50 '
        + 'WHERE A.STATUS = ' + char(39) + 'D' + char(39)

		EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID

        IF @ImportarCOI = 1
        BEGIN
		  --Rubros
		  SET @Sql = ''
		  SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo, Valor, ValorNumero, Rama)'
		  SET @Sql = @Sql + ' SELECT NewID(), @GID, ' + char(39)+'Rubro'+ char(39) + ',DESCRIP, NUM_REG, dbo.fnAspelSetRama(NUM_REG) '
		  SET @Sql = @Sql + ' FROM '+	@ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.RANC01' 
		  EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID

		  --Rubros-Cuentas
		  SET @Sql = ''
		  SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo, Valor, ValorNumero)'
		  SET @Sql = @Sql + ' SELECT NewID(), @GID, ' + char(39)+'RubroCuenta'+ char(39) + ',CUENTA, MIN(Rubro) '
		  SET @Sql = @Sql + 'FROM '+	@ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.CTARUB01 '
		  SET @Sql = @Sql + 'GROUP BY CUENTA '
		  EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID

		  --Rubros-Cuentas-B (Para Poliza de ajuste)
		  SET @Sql = ''
		  SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo, Valor, ValorNumero)'
		  SET @Sql = @Sql + ' SELECT NewID(), @GID, ' + char(39)+'RubroCuentaB'+ char(39) + ',CUENTA, Rubro '
		  SET @Sql = @Sql + 'FROM '+	@ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.CTARUB01 '
		  EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID

		  --Cuentas
		  SET @Sql = ''
		  SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo, Valor, Nombre, Estatus, Tipo, Rama,Valornumero,Descripcion)'
		  SET @Sql = @Sql + ' SELECT NewID(), @GID, ' + char(39)+'Cuenta'+ char(39) 
          + ',num_cta '
          + ', Nombre '
          + ',dbo.fnAspelConversion(' + char(39) + 'CUENTAS' + char(39) + ',' + char(39) + 'Status' + char(39) + ',Status) '
          + ',Tipo ' 
          + ',Rama '
		  + ',Deptsino'	
		  + ',Naturaleza'	
		  SET @Sql = @Sql + ' FROM '+	@ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.CUENTAS' 
		  			
			EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID

		  --Carga Los Tipos de polizas utilizados en COI
       	  ---Creo Tabla Temporal
	      CREATE TABLE #TipoPoliza
	      ( 	 TIPO_POLI	varchar(20)	NULL, 
		         TipoPoliza	varchar(20)	NULL,
	      ) 

		  SET @Sql = ''
		  SET @Sql = @Sql + ' INSERT #TipoPoliza (TIPO_POLI, TipoPoliza)'
		  SET @Sql = @Sql + ' SELECT DISTINCT '
		  + ' LTRIM(TIPO_POLI) '
          + ', dbo.fnAspelConversion(' + char(39) + 'POLIZAS' + char(39) + ',' + char(39) + 'TIPO_POLI' + char(39) + ',TIPO_POLI) '
		  SET @Sql = @Sql + ' FROM '+	@ServidoroRigen + '.' + @BaseDatosOrigen + '.dbo.POLIZAS ' 
		  EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID

		  SET @Sql = ''
		  SET @Sql = @Sql + ' INSERT '+ @ServidorDestino + '.' +  @BaseDatosDestino+ '.' + 'dbo.AspelCargaProp (GID, CargaGID, Campo, Valor, TipoPoliza)'
		  SET @Sql = @Sql + ' SELECT NewID() '
          + ', @GID '
          + ', ' + char(39) + 'TipoPoliza' + char(39) 
          + ', TIPO_POLI '
          + ', TipoPoliza '
		  SET @Sql = @Sql + ' FROM #TipoPoliza '
		  EXEC sp_executeSQL @Sql,N'@GID uniqueidentifier', @GID = @GID
        END

END
GO

--***  AQUI TERMINA /****** spAspelImportarTablasCargaPropReg ******/

/***********fnAspelTipoCuentas***********/
IF EXISTS (SELECT * FROM SysObjects WHERE Id=OBJECT_ID('fnAspelTipoCuentas') AND Type='FN') 
DROP FUNCTION fnAspelTipoCuentas
GO
CREATE FUNCTION  fnAspelTipoCuentas
				  (
                   @Nivel		varchar(1),
				   @MinNivel	varchar(1),
				   @MaxNivel	varchar(1)
                  ) 
RETURNS varchar(30)
AS 
BEGIN
DECLARE	@Salida		varchar(30)

SET @Salida = 
CASE 
  WHEN (@Nivel = @MaxNivel) AND (@Nivel > @MinNivel) THEN 'Auxiliar'
  WHEN (@Nivel < @MaxNivel) AND (@Nivel = @MinNivel) THEN 'Mayor'
  WHEN (@Nivel < @MaxNivel) AND (@Nivel > @MinNivel) THEN 'SubCuenta'
  WHEN (@Nivel = @MaxNivel) AND (@Nivel = @MinNivel) THEN 'Auxiliar'
END
RETURN @Salida
END
GO

/***********fnAspelFormateaCuentas***********/
IF EXISTS(SELECT * FROM SysObjects WHERE Id=OBJECT_ID('dbo.fnAspelFormateaCuentas') AND Type='FN') 
DROP FUNCTION fnAspelFormateaCuentas
GO
CREATE FUNCTION  fnAspelFormateaCuentas
				  (
                   @Cuenta		varchar(20),
				   @Formato		varchar(20)
                  ) 
RETURNS varchar(20)
AS 
BEGIN
DECLARE	@Salida			varchar(20),
        @Cadena			varchar(20),
        @Largo			int,
        @Posicion		int,
		@LargoCuenta	int

SET @LargoCuenta = LEN(REPLACE(REPLACE(RTRIM(LTRIM(@Formato)),'-',''),';2',''))
SET @Cuenta = LEFT(@Cuenta,@LargoCuenta)
SET @Cadena = @Formato
SET @Largo = 0

SET @Salida = @Cuenta
SET @Posicion = CHARINDEX('-',@Cadena)
WHILE (@Posicion <> 0) AND (@Posicion IS NOT NULL)
BEGIN
  SET @Largo = @Largo + @Posicion
  SET @Salida = CASE WHEN @Largo<=Len(@Salida) THEN STUFF(@Salida,@Largo,0,'-') ELSE @Salida END
  SET @Cadena = SUBSTRING(@Cadena,@Posicion+1,20)
  SET @Posicion = CHARINDEX('-',@Cadena)
END
RETURN @Salida
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PASO_CTAS]') AND type in (N'U'))
DROP TABLE [dbo].[PASO_CTAS]

CREATE TABLE PASO_CTAS ( 
Cuenta		varchar(30)	COLLATE Database_Default NOT NULL,
Nombre		varchar(50)	COLLATE Database_Default NOT NULL,
SaldoIni	decimal(15,7) NOT NULL,
Naturaleza	varchar(1)	COLLATE Database_Default NOT NULL,
Periodo		varchar(20)	COLLATE Database_Default NOT NULL,
DEPTSINO	varchar(1)	COLLATE Database_Default NOT NULL,
DEPTO		int
)

GO

/****** Borramos y Creamos tabla temporal de detalle de cuentas ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PASO_CTASD]') AND type in (N'U'))
DROP TABLE [dbo].[PASO_CTASD]

CREATE TABLE PASO_CTASD ( 
Cuenta		varchar(30)	COLLATE Database_Default NOT NULL,
Nombre		varchar(50)	COLLATE Database_Default NOT NULL,
SaldoIni	decimal(15,7) NOT NULL,
Naturaleza	varchar(1)	COLLATE Database_Default NOT NULL,
DEPTO		int
)

GO

/***********spCreaArchivo***********/
IF EXISTS(SELECT * FROM SysObjects WHERE Id=OBJECT_ID('dbo.spCreaArchivo') AND Type='P') 
DROP PROC dbo.spCreaArchivo

GO


CREATE PROCEDURE spCreaArchivo
(@Archivo			varchar(255),
@ManejadorObjeto	Int   OUTPUT,
@IDArchivo			Int   OUTPUT)
--//WITH ENCRYPTION
AS BEGIN
	DECLARE	@ResultadoOLE                int

	--Contacta al objeto que nos ayudará a crear el archivo
	EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT

	IF @ResultadoOLE <> 0 RAISERROR('No es posible abrir el objeto OLE: %s.',10,1,'Scripting.FileSystemObject')
	
	--Crea un archivo de texto
	EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'CreateTextFile', @IDArchivo OUT, @Archivo, 8, 0

	IF @ResultadoOLE <> 0 IF @ResultadoOLE <> 0 RAISERROR('No es posible crear el archivo: %s.',10,1,@Archivo)
END

GO

/***********spInsertaEnArchivo***********/
IF EXISTS(SELECT * FROM SysObjects WHERE Id=OBJECT_ID('dbo.spInsertaEnArchivo') AND Type='P') 
DROP PROC dbo.spInsertaEnArchivo

GO

CREATE PROCEDURE spInsertaEnArchivo
(@IDArchivo	int,
@Cadena		varchar(255))
--//WITH ENCRYPTION
AS BEGIN
	DECLARE	@ResultadoOLE	int         

	--Inserta una Linea al archivo
	EXECUTE @ResultadoOLE = sp_OAMethod @IDArchivo, 'WriteLine', NULL, @Cadena
END

GO

/***********spCierraArchivo***********/
IF EXISTS(SELECT * FROM SysObjects WHERE Id=OBJECT_ID('dbo.spCierraArchivo') AND Type='P') 
DROP PROC dbo.spCierraArchivo

GO

CREATE PROCEDURE spCierraArchivo
(@ManejadorObjeto	Int,
@IDArchivo			Int)
--//WITH ENCRYPTION
AS BEGIN
	DECLARE	@ResultadoOLE	int

	--Destruye el archivo y tambien el objeto
	EXECUTE @ResultadoOLE = sp_OADestroy @IDArchivo
	EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto    
END

GO

/****** AspelProcesos ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspelProcesos]') AND type in (N'U'))
DROP TABLE [dbo].[AspelProcesos]
GO

CREATE TABLE [dbo].[AspelProcesos](
	[Proceso] [varchar](20) COLLATE Database_Default NULL,
	[Estatus] [smallint] NULL
) ON [PRIMARY]

GO

insert into AspelProcesos([Proceso],[Estatus]) values ('Clientes',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('Proveedores',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('Artículos',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('Almacenes',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('Vendedores',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('Monedas',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('Unidades',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('Cuentas',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('Facturas',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('Compras',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('CxC',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('CxP',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('Polizas',0);
insert into AspelProcesos([Proceso],[Estatus]) values ('Inventarios',0);


/***********spAspelInsertaVentas***********/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaVentas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaVentas]
GO

CREATE PROCEDURE  [dbo].[spAspelInsertaVentas]
(
@Estacion	int
)
--//WITH ENCRYPTION
AS BEGIN
DECLARE	
@Modulo				varchar(5),
@FechaEmision		datetime,
@Cliente			varchar(30),
@Mov				varchar(20),
@Empresa			varchar(5), 
@Moneda				varchar(30), 
@TipoCambio			float(15),
@Usuario			varchar(10),
@Estatus			varchar(15),
@Almacen			varchar(30),
@Importe			money,
@Impuesto			money,
@Sucursal			int,
@ID					int,
@Renglon			int,
@RenglonID			int,
@Cantidad			float(15),
@Articulo			varchar(20),
@Precio				money,
@Impuesto1			float(15),
@Impuesto2			float(15),
@Impuesto3			float(15),
@Descuento1			float(15),
@Descuento2			float(15),
@Costo				money,
@Observaciones		varchar(30),
@MovId				varchar(20),
@MovIdOri			varchar(20),
@FlagError			bit,
@ManObj				int,
@ManArch			int,
@Cadena				varchar(500),
@Conta				int,
@Rid				int,
@Agente				varchar(10),
@Tipo				varchar(20),
@SerieLote			varchar(20),
@HayLote			int,
@DescGlobal			float(15),
@Ok	int,
@OkRef	varchar(255),

@cuenta int

	UPDATE AspelProcesos SET
	Estatus = 1
	WHERE Proceso = 'Facturas'
				
	SELECT @Usuario = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'
	SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'

	create table #Pasito
	(
	Id	int, Descripcion	varchar(500)
	)

	SET @FlagError = 0
	SET @Conta = 0

--  EXEC spHabilitarProcedimientosOle
	EXEC spCreaArchivo 'C:\Log_Ventas.txt', @ManObj OUT, @ManArch OUT

	SET @Ok = NULL
	BEGIN TRANSACTION ASPEL
	UPDATE Aspel_Paso SET
	Ventas = 0, DescripcionVentas = ''
	
	INSERT VENTA (Empresa,Mov,FechaEmision,UltimoCambio,Moneda,TipoCambio,Usuario,Estatus,Directo,Prioridad,RenglonID,Cliente,Almacen,FechaRequerida,
	Vencimiento,Importe,ServicioGarantia,ServicioFlotilla,ServicioRampa,ServicioExpress,ServicioDemerito,ServicioDeducible,ServicioPuntual, GenerarPoliza,Extra,Sucursal,GenerarOP,DesglosarImpuestos,
	DesglosarImpuesto2,ExcluirPlaneacion,ConVigencia,EstaImpreso,SubModulo,Logico1,Logico2,Logico3,Logico4,EspacioResultado,Comentarios,GenerarDinero,DineroConciliado,Extra1,Extra2,
	Extra3,Reabastecido,SucursalVenta,AF,FordVisitoOASIS,TieneTasaEsp,SucursalOrigen,Observaciones, Agente, Referencia, DescuentoGlobal,MOVID)
	SELECT Empresa, Mov, FechaEmision, FechaEmision, Moneda, TipoCambio, @Usuario, Estatus, 1, 'Normal', 4, Cliente, Almacen, FechaEmision,
	FechaEmision, (SUM(ISNULL(Debe,0))+SUM(ISNULL(Haber,0))), 0, 0, 0, 0, 0, 0, 0, 0, 0,Sucursal, 0, 0,
	0, 0, 0, 0, 'VTAS', 0, 0, 0, 0, 0, ' ', 0, 0, 0, 0,
    0, 0, Sucursal, 0, 0, 0, Sucursal, @Observaciones + ' ' + LTRIM(ISNULL(MovID,'')), Agente, @Observaciones + ' ' + LTRIM(ISNULL(MovID,'')), Gastos,MovID

	FROM AspelCargaReg 
	WHERE Modulo = 'VTAS'
	GROUP BY Empresa, Sucursal, Modulo, FechaEmision, Cliente, Mov, MovID, Moneda, TipoCambio, Estatus, Almacen, Agente, Gastos
	
	CREATE TABLE #VENTAD
	(
	Consecut		int			IDENTITY(1,1)	NOT NULL,
	ID 				int 		NULL,	Renglon			float(15)	NULL,	RenglonID		int			NULL,
	Cantidad		float(15)	NULL,	Almacen			varchar(30)	NULL,	Articulo		varchar(20)	NULL,
	Precio			float(15)	NULL,	PrecioSugerido	float(15)	NULL,	Impuesto1		float(15)	NULL,
	Impuesto2		float(15)	NULL,	Impuesto3		float(15)	NULL,	DescuentoLinea	money		NULL,
	Costo			money		NULL,	FechaRequerida	datetime	NULL,	PrecioMoneda	varchar(10)	NULL,
	PrecioTipoCambio float(15)	NULL,	MovId			varchar(20)	NULL, Mov varchar(20) NULL,Subcuenta varchar(50) null
	)
	
	INSERT #VENTAD (Cantidad, Almacen, Articulo, Precio, PrecioSugerido, Impuesto1, Impuesto2, Impuesto3, DescuentoLinea, 
	Costo, FechaRequerida, PrecioMoneda, PrecioTipoCambio, MovId, Mov, Subcuenta)
	SELECT Cantidad, Almacen, Articulo, Precio, Precio, Impuesto1, Impuesto2, Impuesto3, Descuento1, 
	Costo, FechaEmision, Moneda, TipoCambio, MovID, Mov, subcuenta
	FROM AspelCargaReg 
	WHERE Modulo = 'VTAS'
	ORDER BY MovID
                       
	UPDATE #VENTAD SET
	ID = C.ID,FechaRequerida = C.FechaEmision
	FROM #VENTAD D, VENTA C
	WHERE D.MovId = C.MovId AND D.Mov = C.Mov

	SET @Renglon = 0
	SET @RenglonID = 0
	set @cuenta = 0

	DECLARE crVentas CURSOR  FOR
	SELECT Consecut, MovId
	FROM #VENTAD

	FOR UPDATE OF Renglon, RenglonID

	OPEN crVentas 
	FETCH NEXT FROM crVentas INTO @ID, @MovId
		
	SET @MovIdOri = 0
	WHILE @@FETCH_STATUS <> -1
	BEGIN
		IF @MovIdOri <> @MovId
		BEGIN
			SET @MovIdOri = @MovId
			SET @Renglon = 2048
			SET @RenglonID = 1
		END
		ELSE
		BEGIN
			SET @Renglon = @Renglon + 2048
			SET @RenglonID = @RenglonID + 1
		END

		UPDATE #VENTAD SET
		Renglon = @Renglon, RenglonID = @RenglonID
		WHERE CURRENT OF crVentas
		
		FETCH NEXT FROM crVentas INTO @ID, @MovId
	END

	CLOSE crVentas
	DEALLOCATE crVentas
	
	INSERT VENTAD (ID, Renglon, RenglonID, Cantidad, Almacen, Articulo, Precio, PrecioSugerido, Impuesto1, Impuesto2, Impuesto3, 
	DescuentoLinea, Costo, FechaRequerida, PrecioMoneda, PrecioTipoCambio)
	SELECT ID, Renglon, RenglonID, Cantidad, Almacen, Articulo, Precio, PrecioSugerido, Impuesto1, Impuesto2, Impuesto3, 
	DescuentoLinea, Costo, FechaRequerida, PrecioMoneda, PrecioTipoCambio
	FROM #VENTAD
	ORDER BY Consecut
	
	set @cuenta =0

	DECLARE crCabecera CURSOR  FOR
	SELECT 'VTAS', ID, Usuario
	FROM VENTA WHERE MOV in ('Sae Factura','Sae Devolución')

	ORDER BY ID

	OPEN crCabecera 
	FETCH NEXT FROM crCabecera INTO @Modulo, @ID, @Usuario
	
	WHILE @@FETCH_STATUS <> -1
	BEGIN
		EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'Todo', NULL, @Usuario, 0, 1, @Ok, @OkRef, NULL, 1, @Estacion
			
		IF @Ok IS NOT NULL AND @Ok<80000 
		BEGIN
			SET @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID)
			SET @Conta = @Conta + 1
			SET @Cadena = 'Modulo ' + @Modulo + ', Mov ' + @Mov + ', MovID ' + isnull(@MovID, 'Sin MovID') + ', Fecha ' + isnull(convert(varchar,@FechaEmision, 103),'')

			Insert Into #Pasito(Id, Descripcion) Values (@Conta, @Cadena)
			SET @FlagError = 1
          --BREAK 
		END

		FETCH NEXT FROM crCabecera INTO @Modulo, @ID, @Usuario
	END
	
	CLOSE crCabecera
	DEALLOCATE crCabecera

	UPDATE AspelProcesos SET
	Estatus = 0
	WHERE Proceso = 'Facturas'
			  
	IF @FlagError = 1
	BEGIN
		DECLARE crLineas CURSOR FOR
		SELECT Descripcion FROM #PASITO
		ORDER BY Id

		OPEN crLineas
		FETCH NEXT FROM crLineas INTO @Cadena

		WHILE @@FETCH_STATUS = 0 
		BEGIN
			EXEC spInsertaEnArchivo @ManArch, @Cadena 

			FETCH NEXT FROM crLineas INTO @Cadena
		END

		CLOSE crLineas
		DEALLOCATE crLineas

		SELECT @Ok = 30230, @OkRef = 'Errores en el Módulo Ventas, verificar el Archivo C:\Log_Ventas'

		--ROLLBACK TRANSACTION ASPEL
		COMMIT TRANSACTION ASPEL	

		UPDATE Aspel_Paso SET
		DescripcionvENTAS = 'Migración con Errores, Revise Archivo C:\Log_Ventas.txt'
	END
	ELSE
	BEGIN
		SELECT @Conta = COUNT(*) FROM VENTA

		UPDATE Aspel_Paso SET
		Ventas = 1, DescripcionVentas = 'Importación Correcta', RegistrosVentas = @Conta

		COMMIT TRANSACTION ASPEL
	END
			
	EXEC spCierraArchivo @ManObj, @ManArch	

	IF @FlagError = 1
		SELECT 'Migración con Errores, Revise Archivo C:\Log_CXC.txt'
	ELSE
		SELECT 'Importación Correcta'

END
GO

/****** spAspelInsertaCompras ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaCompras]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaCompras]
GO


CREATE PROCEDURE  [dbo].[spAspelInsertaCompras]
(
@Estacion	int
)
--//WITH ENCRYPTION
AS BEGIN
DECLARE	
@Modulo				varchar(5),
@FechaEmision		datetime,
@Proveedor			varchar(30),
@Mov				varchar(20),
@Empresa			varchar(5), 
@Moneda				varchar(30), 
@TipoCambio			float(15),
@Usuario			varchar(10),
@Estatus			varchar(15),
@Almacen			varchar(30),
@Importe			money,
@Impuesto			money,
@Sucursal			int,
@ID					int,
@Renglon			int,
@RenglonID			int,
@Cantidad			float(15),
@Articulo			varchar(20),
@Costo				money,
@Descuento1			float(15),
@Impuesto1			float(15),
@Impuesto2			float(15),
@Impuesto3			float(15),
@Observaciones		varchar(30),
@MovID				varchar(20),
@FlagError			bit,
@ManObj				int,
@ManArch			int,
@Cadena				varchar(500),
@Conta				int,
@Rid				int,
@Tipo				varchar(20),
@SerieLote			varchar(20),
@HayLote			int,
@Referencia			varchar(20),
@DescGlobal			float(15),
@Ok					int,
@OkRef				varchar(255),
@MovIdOri			varchar(20),
@Cuenta				int

	set @cuenta = 0

	UPDATE AspelProcesos SET
	Estatus = 1
	WHERE Proceso = 'Compras'

	SELECT @Usuario = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'
	SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'

	create table #Pasito
	(
	Id	int, Descripcion	varchar(500)
	)

	SET @FlagError = 0
	SET @Conta = 0
--  EXEC spHabilitarProcedimientosOle
	EXEC spCreaArchivo 'C:\Log_Compras.txt', @ManObj OUT, @ManArch OUT

	SET @Ok = NULL
	BEGIN TRANSACTION ASPEL  
	UPDATE Aspel_Paso SET
	Compras = 0, DescripcionCompras = ''

	INSERT COMPRA (Empresa, Mov, FechaEmision, UltimoCambio, Moneda, TipoCambio, Usuario, Estatus, Prioridad,
	RenglonID, Proveedor, FechaRequerida, Almacen, Vencimiento, Importe, OrigenTipo, Origen, 
	FechaEntrega, Sucursal,	Observaciones,SucursalOrigen, Referencia, 
	DescuentoGlobal, MOVID)  
	SELECT Empresa, Mov, FechaEmision, FechaEmision, Moneda, TipoCambio, @Usuario, Estatus, 'Normal',
	5, Proveedor, FechaEmision, Almacen, FechaEmision, (SUM(ISNULL(Debe,0))+SUM(ISNULL(Haber,0))), 'Usuario', @Usuario,
	FechaEmision, Sucursal, @Observaciones+' '+LTRIM(ISNULL(MovID,'')), Sucursal, LTRIM(ISNULL(Referencia,'')),
	Gastos, MovID
	FROM AspelCargaReg 
	WHERE Modulo = 'COMS'
	GROUP BY Empresa, Sucursal, Modulo, FechaEmision, Mov, MovID, Proveedor, Moneda, TipoCambio, Estatus,  
	Almacen,Referencia,Gastos
	ORDER BY MovID
	
	CREATE TABLE #COMPRAD
	(
	Consecut		int	IDENTITY(1,1) NOT NULL,
	ID				int			NULL,
	Renglon			float(15)	NULL,
	RenglonID		int			NUll,
	Cantidad		float(15)	NUll,
	Almacen			varchar(30)	NUll,
	Articulo		varchar(20)	NUll,
	FechaRequerida	datetime	NUll,
	FechaEntrega	datetime	NUll,
	Costo			money		NUll,
	DescuentoLinea	money		NUll,
	Impuesto1		float(15)	NUll,
	Impuesto2		float(15)	NUll, 
	Impuesto3		float(15)	NUll, 
	Sucursal		int			NUll,
	SucursalOrigen	int			NUll,
	MovId			varchar(20)	NULL,
	Mov				varchar(20) NULL
	)
	
	INSERT #COMPRAD (Cantidad, Almacen, Articulo, Costo, DescuentoLinea, Impuesto1, 
	Impuesto2, Impuesto3, MovId, Mov)
	SELECT Cantidad, Almacen, Articulo, Costo, Descuento1, Impuesto1, Impuesto2, Impuesto3, MovId, Mov
	FROM AspelCargaReg 
	WHERE Modulo = 'COMS'
	ORDER BY MovID
	
	UPDATE #COMPRAD SET
	ID = C.ID, FechaRequerida = C.FechaEmision, FechaEntrega = C.FechaEmision, Sucursal = C.Sucursal, SucursalOrigen = C.Sucursal
	FROM #COMPRAD, COMPRA C
	WHERE #COMPRAD.MovId = C.MovId and #COMPRAD.Mov = C.Mov	 
	
	SET @Renglon = 0
	SET @RenglonID = 0
	
	DECLARE crCompras CURSOR FOR
	SELECT Consecut, MovId
	FROM #COMPRAD
	FOR UPDATE OF Renglon, RenglonID
	
	OPEN crCompras 
	FETCH NEXT FROM crCompras INTO @ID, @MovId
	
	SET @MovIdOri = 0
	WHILE @@FETCH_STATUS <> -1
	BEGIN
		IF @MovIdOri <> @MovId
		BEGIN
			SET @MovIdOri = @MovId
			SET @Renglon = 2048
			SET @RenglonID = 1
		END
		ELSE
		BEGIN
			SET @Renglon = @Renglon + 2048
			SET @RenglonID = @RenglonID + 1
		END
		
		UPDATE #COMPRAD SET
		Renglon = @Renglon, RenglonID = @RenglonID
		WHERE CURRENT OF crCompras
				
		FETCH NEXT FROM crCompras INTO @ID, @MovId
	END
	
	CLOSE crCompras
	DEALLOCATE crCompras
			
	SET @Renglon = @Renglon + 2048
	SET @RenglonID = @RenglonID + 1
				
	INSERT COMPRAD (ID,Renglon,RenglonID,Cantidad,Almacen,Articulo,FechaRequerida,FechaEntrega,Costo,DescuentoLinea,Impuesto1, 
	Impuesto2, Impuesto3, Sucursal, SucursalOrigen)
	SELECT  ID,Renglon,RenglonID,Cantidad,Almacen,Articulo,FechaRequerida,FechaEntrega,Costo,DescuentoLinea,Impuesto1, 
	Impuesto2, Impuesto3, Sucursal, SucursalOrigen from #COMPRAD
	ORDER BY Consecut
	
	DECLARE crCabecera CURSOR FOR
	SELECT 'COMS', ID, Usuario, MovID, Mov
	FROM COMPRA WHERE MOV = (select MovDebenocontable from aspelcfgmodulomayor where Modulo = 'COMS' )
	or MOV = (select MovHabernocontable from aspelcfgmodulomayor where Modulo = 'COMS' )
	ORDER BY ID

	OPEN crCabecera 
	FETCH NEXT FROM crCabecera INTO @Modulo, @ID, @Usuario, @MovID, @Mov
	
	WHILE @@FETCH_STATUS <> -1
	BEGIN
		EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'Todo', NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1, @Estacion
		
		IF @Ok IS NOT NULL --AND @Ok<80000 
		BEGIN
			SELECT @Ok, @Modulo, @Mov, @MovID
		
			SELECT @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID) + @Mov +', ' + MovID FROM Compra WHERE ID = @ID
			
			SET @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID)
			SET @Conta = @Conta + 1
			SET @Cadena = 'Modulo ' + @Modulo + ', Mov ' + @Mov + ', MovID ' + isnull(@MovID, 'Sin MovID') --+ ', Fecha ' + isnull(convert(varchar,@FechaEmision, 103) , '')
			
			Insert Into #Pasito(Id, Descripcion) Values (@Conta, @Cadena)
			SET @FlagError = 1
--          BREAK 
		END
	
		FETCH NEXT FROM crCabecera INTO  @Modulo, @ID, @Usuario, @MovID, @Mov
	END
	CLOSE crCabecera
	DEALLOCATE crCabecera
	
	UPDATE AspelProcesos SET
	Estatus = 1
	WHERE Proceso = 'Compras'
  
	IF @FlagError = 1
	BEGIN
		DECLARE crLineas CURSOR FOR
		SELECT Descripcion FROM #PASITO
		ORDER BY Id
		
		OPEN crLineas
		FETCH NEXT FROM crLineas INTO @Cadena

		WHILE @@FETCH_STATUS = 0 
		BEGIN
			EXEC spInsertaEnArchivo @ManArch, @Cadena 
			FETCH NEXT FROM crLineas INTO @Cadena
		END

		CLOSE crLineas
		DEALLOCATE crLineas

		SELECT @Ok = 30230, @OkRef = 'Errores en el Módulo Compras, verificar el Archivo C:\Log_Compras'
		COMMIT TRANSACTION ASPEL		
	--	ROLLBACK TRANSACTION ASPEL	
		
		UPDATE Aspel_Paso SET
		DescripcionCompras = 'Migración con Errores, Revise Archivo C:\Log_Compras.txt'
	END
	ELSE
	BEGIN
		SELECT @Conta = COUNT(*) FROM COMPRA

		UPDATE Aspel_Paso SET
		Compras = 1, DescripcionCompras = 'Importación Correcta', RegistrosCompras = @Conta

		COMMIT TRANSACTION ASPEL
	END
	
	EXEC spCierraArchivo @ManObj, @ManArch
	
	Exec spAspelActualizaProcesos 0

	IF @FlagError = 1
		SELECT 'Migración con Errores, Revise Archivo C:\Log_Compras.txt'
	ELSE
		SELECT 'Importación Correcta'

END
GO


/****** spAspelInsertaCxc ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaCxc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaCxc]
GO


CREATE PROCEDURE  [dbo].[spAspelInsertaCxc]
(
@Estacion	int
)
--//WITH ENCRYPTION
AS BEGIN
DECLARE	
@Modulo				varchar(5),
@FechaEmision		datetime,
@Vencimiento		datetime,
@Cliente			varchar(30),
@Mov				varchar(20),
@Empresa			varchar(5), 
@Moneda				varchar(30), 
@TipoCambio			float(15),
@Usuario			varchar(10),
@Estatus			varchar(15),
@Importe			money,
@Impuesto			money,
@Sucursal			int,
@ID					int,
@Observaciones		varchar(30),
@FlagError			bit,
@ManObj				int,
@ManArch			int,
@Cadena				varchar(500),
@Conta				int,
@Referencia			varchar(50),
@Ok					int,
@OkRef				varchar(255),
@IVADESGLOSA		FLOAT,
@Ivafiscal	float,
@iepsfiscal float




	UPDATE AspelProcesos SET
	Estatus = 1
	WHERE Proceso = 'CxC'

  SELECT @Usuario = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'
  
  SET @IVADESGLOSA = 1.15

declare 
@MovID	varchar(20),
@Rid	int

create table #Pasito
(
Id	int, Descripcion	varchar(500)
)

SET @FlagError = 0
SET @Conta = 0
--  EXEC spHabilitarProcedimientosOle
  EXEC spCreaArchivo 'C:\Log_CxC.txt', @ManObj OUT, @ManArch OUT

  SET @Ok = NULL
  BEGIN TRANSACTION ASPEL
  UPDATE Aspel_Paso SET
  CuentasPorCobrar = 0, DescripcionCxC = ''
  
  DECLARE crCabecera CURSOR FOR
		SELECT Empresa, Sucursal, Modulo, FechaEmision, Cliente, Mov, Moneda, TipoCambio, Estatus, (SUM(ISNULL(Debe,0))+SUM(ISNULL(Haber,0))) Importe, 
		MovId, Referencia, Vencimiento, concepto, Impuesto1, Impuesto2
		  FROM AspelCargaReg 
         WHERE Modulo = 'CXC'
      GROUP BY Empresa, Sucursal, Modulo, FechaEmision, Cliente, Mov, Moneda, TipoCambio, Estatus,  MovId, Referencia, Vencimiento, concepto,Impuesto1, Impuesto2

    OPEN crCabecera 
    FETCH NEXT FROM crCabecera INTO @Empresa, @Sucursal, @Modulo, @FechaEmision, @Cliente, @Mov, @Moneda, @TipoCambio, @Estatus, @Importe,  @MovID, @Referencia, @Vencimiento, @Observaciones, @ivafiscal,@iepsfiscal
	WHILE @@FETCH_STATUS <> -1
	  BEGIN 

		INSERT CXC (Empresa,Mov,FechaEmision,UltimoCambio,Moneda,TipoCambio,Usuario,Estatus,Cliente,ClienteMoneda,ClienteTipoCambio,Condicion,Vencimiento,FormaCobro,Importe,Impuestos,Concepto,Observaciones, Referencia, MOVID, Ivafiscal, Iepsfiscal)
            VALUES (@Empresa,@Mov,@FechaEmision,@FechaEmision,@Moneda,@TipoCambio,@Usuario,@Estatus,@Cliente,@Moneda,@TipoCambio,'(Fecha)',@Vencimiento,'Cheque',@Importe-(@Importe*@Ivafiscal)-(@Importe*@Iepsfiscal),(@Importe*@Ivafiscal)+(@Importe*@Iepsfiscal),'Aspel',@Observaciones, @Referencia, @MOVID,@Ivafiscal,@iepsfiscal)			

		SET @ID = SCOPE_IDENTITY()

        EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'Todo', NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1, @Estacion

		IF @Ok IS NOT NULL AND @Ok<80000 BEGIN
          SET @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID)
		  SET @Conta = @Conta + 1
		  SET @Cadena = 'Modulo ' + @Modulo + ', Mov ' + @Mov + ', MovID ' + @MovID + ', Fecha ' + convert(varchar,@FechaEmision, 103) + ', Cliente ' + @Cliente
		  
		  Insert Into #Pasito(Id, Descripcion) Values (@Conta, @Cadena)
			SET @FlagError = 1
--          BREAK 
        END

		FETCH NEXT FROM crCabecera INTO @Empresa, @Sucursal, @Modulo, @FechaEmision, @Cliente, @Mov, @Moneda, @TipoCambio, @Estatus, @Importe,  @MovID, @Referencia, @Vencimiento, @Observaciones, @ivafiscal,@iepsfiscal
	  END

	CLOSE crCabecera
	DEALLOCATE crCabecera
	
	IF @FlagError = 1
	BEGIN
		DECLARE crLineas CURSOR FOR
		SELECT Descripcion FROM #PASITO
		ORDER BY Id
		
		OPEN crLineas
		FETCH NEXT FROM crLineas INTO @Cadena

		WHILE @@FETCH_STATUS = 0 
		BEGIN
			EXEC spInsertaEnArchivo @ManArch, @Cadena  

			FETCH NEXT FROM crLineas INTO @Cadena
		END

		CLOSE crLineas
		DEALLOCATE crLineas

		SELECT @Ok = 30230, @OkRef = 'Errores en el Módulo CxC, verificar el Archivo C:\Log_CxC'
	END
	EXEC spCierraArchivo @ManObj, @ManArch
	
	IF @FlagError = 1
	BEGIN
		UPDATE Aspel_Paso SET
		DescripcionCxC = 'Migración con Errores, Revise Archivo C:\Log_CxC.txt'

		--ROLLBACK TRANSACTION ASPEL
		COMMIT TRANSACTION ASPEL	
	END
	ELSE
	BEGIN
		SELECT @Conta = COUNT(*) FROM CXC
		    		
		UPDATE Aspel_Paso SET
		CuentasPorCobrar = 1, DescripcionCxC = 'Importación Correcta', RegistrosCxC = @Conta
		COMMIT TRANSACTION ASPEL
	END

	Exec spAspelActualizaProcesos 0
	
	IF @FlagError = 1
		SELECT 'Migración con Errores, Revise Archivo C:\Log_CXC.txt'
	ELSE
		SELECT 'Importación Correcta'
		
END
GO

/****** spAspelInsertaCxp ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaCxp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaCxp]
GO


CREATE PROCEDURE  [dbo].[spAspelInsertaCxp]
(
@Estacion	int
)
--//WITH ENCRYPTION
AS BEGIN
DECLARE	
@Modulo				varchar(5),
@FechaEmision		datetime,
@Vencimiento		datetime,
@Proveedor			varchar(30),
@Mov				varchar(20),
@Empresa			varchar(5), 
@Moneda				varchar(30), 
@TipoCambio			float(15),
@Usuario			varchar(10),
@Estatus			varchar(15),
@Importe			money,
@Impuesto			money,
@Sucursal			int,
@ID					int,
@Observaciones		varchar(30),
@FlagError			bit,
@ManObj				int,
@ManArch			int,
@Cadena				varchar(500),
@Conta				int,
@MovID				varchar(20),
@Rid				int,
@Referencia			varchar(50),
@Factura			varchar(10),
@Ok	int,
@OkRef	varchar(255),
@IVADESGLOSA FLOAT,
@Ivafiscal	float,
@iepsfiscal float


	UPDATE AspelProcesos SET
	Estatus = 1
	WHERE Proceso = 'CxP'

  SELECT @Usuario = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'
  SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'
  SET @IVADESGLOSA = 1.15

create table #Pasito
(
Id	int, Descripcion	varchar(500)
)

SET @FlagError = 0
SET @Conta = 0
--  EXEC spHabilitarProcedimientosOle
  EXEC spCreaArchivo 'C:\Log_CxP.txt', @ManObj OUT, @ManArch OUT

  SET @Ok = NULL
  BEGIN TRANSACTION ASPEL
  UPDATE Aspel_Paso SET
  CuentasPorPagar = 0, DescripcionCxP = ''
  
  DECLARE crCabecera CURSOR FOR
		SELECT Empresa, Sucursal, Modulo, FechaEmision, Proveedor, Mov, Moneda, TipoCambio, Estatus, 
		ABS((SUM(ISNULL(Debe,0))+SUM(ISNULL(Haber,0)))) Importe, MovId, Referencia, MovId, Vencimiento, Impuesto1,Impuesto2
		FROM AspelCargaReg 
      
	  WHERE Modulo = 'CXP'
      GROUP BY Empresa, Sucursal, Modulo, FechaEmision, Proveedor, Mov, Moneda, TipoCambio, Estatus, MovId, Referencia, MovId, Vencimiento,Impuesto1, Impuesto2

    OPEN crCabecera 
    FETCH NEXT FROM crCabecera INTO @Empresa, @Sucursal, @Modulo, @FechaEmision, @Proveedor, @Mov, @Moneda, @TipoCambio, @Estatus, @Importe, @MovID, @Referencia, @Factura, @Vencimiento, @Ivafiscal, @Iepsfiscal
	WHILE @@FETCH_STATUS <> -1
	  BEGIN

        INSERT CXP (Empresa,Mov,FechaEmision,UltimoCambio,Moneda,TipoCambio,Usuario,Estatus,Proveedor,ProveedorMoneda,
        ProveedorTipoCambio,Condicion,Vencimiento,FormaPago,Importe,Impuestos,FechaRegistro,Concepto,Observaciones, Referencia,MOVID,IvaFiscal, Iepsfiscal)
            VALUES (@Empresa,@Mov,@FechaEmision,@FechaEmision,@Moneda,@TipoCambio,@Usuario,@Estatus,@Proveedor,@Moneda,
            @TipoCambio,'(Fecha)',@Vencimiento,'Cheque',@Importe-(@Importe*@Ivafiscal)-(@Importe*@Iepsfiscal),(@Importe*@Ivafiscal)+(@Importe*@Iepsfiscal),@FechaEmision,@Observaciones,@Factura, @Referencia,@MOVID,@ivafiscal,@iepsfiscal)
			


		SET @ID = SCOPE_IDENTITY()

        EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'Todo', NULL, @Usuario, 0, 1,@Ok OUTPUT, @OkRef OUTPUT, NULL, 1, @Estacion
        IF @Ok IS NOT NULL AND @Ok<80000 BEGIN
          SET @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID)
		  SET @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID)
		  SET @Conta = @Conta + 1
		  SET @Cadena = 'Modulo ' + @Modulo + ', Mov ' + @Mov + ', MovID ' + @MovID + ', Fecha ' + convert(varchar,@FechaEmision, 103) + ', Proveedor ' + @Proveedor
		  
		  
		  Insert Into #Pasito(Id, Descripcion) Values (@Conta, @Cadena)
		  SET @FlagError = 1
--          BREAK 
        END

		FETCH NEXT FROM crCabecera INTO @Empresa, @Sucursal, @Modulo, @FechaEmision, @Proveedor, @Mov, @Moneda, @TipoCambio, @Estatus, @Importe, @MovID, @Referencia, @Factura, @Vencimiento, @Ivafiscal, @Iepsfiscal
	  END
	CLOSE crCabecera
	DEALLOCATE crCabecera

	IF @FlagError = 1
	BEGIN
		DECLARE crLineas CURSOR FOR
		SELECT Descripcion FROM #PASITO
		ORDER BY Id
		
		OPEN crLineas
		FETCH NEXT FROM crLineas INTO @Cadena
			
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			EXEC spInsertaEnArchivo @ManArch, @Cadena  

			FETCH NEXT FROM crLineas INTO @Cadena
		END

		CLOSE crLineas
		DEALLOCATE crLineas

		SELECT @Ok = 30230, @OkRef = 'Errores en el Módulo CxP, verificar el Archivo C:\Log_CxP'
	END
  	EXEC spCierraArchivo @ManObj, @ManArch
  	
  	IF @FlagError = 1
	BEGIN
		UPDATE Aspel_Paso SET
		DescripcionCxP = 'Migración con Errores, Revise Archivo C:\Log_CxP.txt'

		--ROLLBACK TRANSACTION ASPEL
		COMMIT TRANSACTION ASPEL	
	END
	ELSE
	BEGIN
		SELECT @Conta = COUNT(*) FROM CXP
				    		
		UPDATE Aspel_Paso SET
		CuentasPorPagar = 1, DescripcionCxP = 'Importación Correcta', RegistrosCxP = @Conta

		COMMIT TRANSACTION ASPEL
	END

	Exec spAspelActualizaProcesos 0

	IF @FlagError = 1
		SELECT 'Migración con Errores, Revise Archivo C:\Log_CXp.txt'
	ELSE
		SELECT 'Importación Correcta'
		
END

GO


/****** spAspelInsertaInventarios ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaInventarios]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaInventarios]
GO
CREATE PROCEDURE  [dbo].[spAspelInsertaInventarios]
(
	@Estacion	int
)
--//WITH ENCRYPTION
AS BEGIN
DECLARE	
@Modulo				varchar(5),
@Mov				varchar(20),
@Empresa			varchar(5), 
@Moneda				varchar(30), 
@TipoCambio			float(15),
@Usuario			varchar(10),
@Estatus			varchar(15),
@Almacen			varchar(30),
@Importe			money,
@Impuesto			money,
@ID					int,
@Renglon			int,
@RenglonID			int,
@Cantidad			float(15),
@Articulo			varchar(20),
@Costo				decimal(15,5), 
@Observaciones		varchar(30),
@IDAjuste			int,
@Tipo				varchar(20),
@Serie				varchar(50),
@Sucursal			varchar(30),
@CantidadSerie		float(15),
@AjusteSeries		varchar(2),
@FlagError			bit,
@ManObj				int,
@ManArch			int,
@Cadena				varchar(500),
@Conta				int,
@MovID				varchar(20),
@Rid				int,
@Ok	int,
@OkRef	varchar(255)

	UPDATE AspelProcesos SET
	Estatus = 1
	WHERE Proceso = 'Inventarios'

  SELECT @Usuario = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'
  SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'
  SELECT @Sucursal = Valor FROM AspelCfg WHERE Descripcion = 'Sucursal'
  SELECT @AjusteSeries = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Ajuste Automatico Existencias Series'

create table #Pasito
(
Id	int, Descripcion	varchar(500)
)

SET @FlagError = 0
SET @Conta = 0
--  EXEC spHabilitarProcedimientosOle
  EXEC spCreaArchivo 'C:\Log_Inventarios.txt', @ManObj OUT, @ManArch OUT

  SET @Ok = NULL
  BEGIN TRANSACTION ASPEL
  UPDATE Aspel_Paso SET
  Inventarios = 0, DescripcionInventarios = ''
  
  DECLARE crCabecera CURSOR FOR
	SELECT Empresa, Modulo, Mov, Moneda, TipoCambio, Estatus, Almacen,MovId --/*, (SUM(ISNULL(Debe,0))+SUM(ISNULL(Haber,0)))/(1+(Impuesto1/100)) Importe,(SUM(ISNULL(Debe,0))+SUM(ISNULL(Haber,0)))*(ISNULL(Impuesto1,0)/100) Impuestos */
	FROM AspelCargaReg 
	WHERE Modulo = 'INV' 
	GROUP BY Empresa, Modulo, Mov, Moneda, TipoCambio, Estatus, Almacen,MovId --, Impuesto1
	
    OPEN crCabecera 
    FETCH NEXT FROM crCabecera INTO @Empresa, @Modulo, @Mov, @Moneda, @TipoCambio, @Estatus, @Almacen, @MovID --/*, @Importe, @Impuesto*/
    
    	INSERT INTO SerieLote (Sucursal, Empresa, Articulo, Subcuenta, SerieLote, Almacen,
	Existencia, ExistenciaAlterna, UltimaEntrada, UltimaSalida)
	SELECT @Sucursal, @Empresa, Articulo, '', valor, @Almacen,  1, 0, NULL, NULL
	FROM AspelCargaProp
	WHERE Campo = 'Serie'
		
	WHILE (@@FETCH_STATUS <> -1) AND (@@FETCH_STATUS <> -2)
	  BEGIN 

        INSERT INV (Empresa, Mov, FechaEmision, UltimoCambio, Moneda, TipoCambio, Usuario, Estatus, RenglonID, Almacen, AlmacenTransito, FechaRequerida, Vencimiento, Observaciones, Concepto)
            VALUES (@Empresa,@Mov, getdate(), getdate(), @Moneda, @TipoCambio, @Usuario, @Estatus, 4, @Almacen, '(TRANSITO)',getdate(), getdate(),@Observaciones, @Observaciones)
		SET @ID = SCOPE_IDENTITY()
					
		DECLARE crDetalle CURSOR FOR
		SELECT A.Cantidad, A.Almacen, A.Articulo, A.Costo, B.Tipo
		FROM AspelCargaReg A JOIN AspelCargaProp B 
		ON A.Articulo = B.Valor
		WHERE A.Empresa = @Empresa AND A.Modulo = @Modulo AND A.Mov = @Mov AND A.Moneda = @Moneda AND 
		A.TipoCambio = @TipoCambio AND A.Estatus = @Estatus AND A.Almacen = @Almacen AND ISNULL(A.Cantidad,0) <> 0
		AND B.Campo = 'Articulo'	

        SET @Renglon = 0
		SET @RenglonID = 0
		OPEN crDetalle 
		FETCH NEXT FROM crDetalle INTO @Cantidad, @Almacen, @Articulo, @Costo, @Tipo
		WHILE (@@FETCH_STATUS <> -1) AND (@@FETCH_STATUS <> -2)
		BEGIN 
			SET @Renglon = @Renglon + 2048
			SET @RenglonID = @RenglonID + 1

			IF @Tipo = 'Serie'
			BEGIN
				SET @CantidadSerie = 0
				DECLARE crSerieDetalle CURSOR FOR
				SELECT Valor
				FROM AspelCargaProp  
				WHERE Articulo = @Articulo AND Almacen = @Almacen AND Costo = @Costo AND Campo = 'Serie'

				OPEN crSerieDetalle 
				FETCH NEXT FROM crSerieDetalle INTO @Serie
				WHILE (@@FETCH_STATUS <> -1) AND (@@FETCH_STATUS <> -2)
				BEGIN
					INSERT SerieLoteMov (Sucursal, Empresa, Modulo, ID, RenglonID, Articulo, SerieLote, Cantidad)
					VALUES (@Sucursal, @Empresa, @Modulo, @ID, @RenglonID, @Articulo, @Serie, 1) 

                        		SET @Cantidadserie = @CantidadSerie + 1
					FETCH NEXT FROM crSerieDetalle INTO @Serie
				END
				CLOSE crSerieDetalle
				DEALLOCATE crSerieDetalle
				
				--If @AjusteSeries = 'Si' SET @Cantidad = @CantidadSerie
			END

                	INSERT INVD (ID, Renglon, RenglonID, Cantidad, Almacen, Articulo, FechaRequerida, Costo)
				     VALUES (@ID, @Renglon, @RenglonID, @Cantidad, @Almacen, @Articulo, getdate(), @Costo) 

			FETCH NEXT FROM crDetalle INTO @Cantidad, @Almacen, @Articulo, @Costo, @Tipo
		END
		CLOSE crDetalle
		DEALLOCATE crDetalle

						EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'Todo', NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1, @@SPID
	
            IF @Ok IS NOT NULL AND @Ok<80000 BEGIN
              SET @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID)

			  SET @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID)
			  SET @Conta = @Conta + 1
			  SET @Cadena = 'Modulo ' + @Modulo + ', Mov ' + @Mov + ', MovID ' + @MovID + ', Fecha ' + convert(varchar,getdate(), 103)
			  
			  Insert Into #Pasito(Id, Descripcion) Values (@Conta, @Cadena)
				SET @FlagError = 1

--              BREAK 
            END


        FETCH NEXT FROM crCabecera INTO @Empresa, @Modulo, @Mov, @Moneda, @TipoCambio, @Estatus, @Almacen, @MovID --/*, @Importe, @Impuesto*/
	  END
	CLOSE crCabecera
	DEALLOCATE crCabecera
  
	IF @FlagError = 1
	BEGIN
		DECLARE crLineas CURSOR FOR
		SELECT Descripcion FROM #PASITO
		ORDER BY Id
		
		OPEN crLineas
		FETCH NEXT FROM crLineas INTO @Cadena

		WHILE @@FETCH_STATUS = 0 
		BEGIN
			EXEC spInsertaEnArchivo @ManArch, @Cadena  

			FETCH NEXT FROM crLineas INTO @Cadena
		END

		CLOSE crLineas
		DEALLOCATE crLineas

		SELECT @Ok = 30230, @OkRef = 'Errores en el Módulo Inventarios, verificar el Archivo C:\Log_Inventarios'
	END
	EXEC spCierraArchivo @ManObj, @ManArch
	
	IF @FlagError = 1
	BEGIN
		UPDATE Aspel_Paso SET
		DescripcionInventarios = 'Migración con Errores, Revise Archivo C:\Log_Inventarios.txt'

		--ROLLBACK TRANSACTION ASPEL
		COMMIT TRANSACTION ASPEL	
	END
	ELSE
	BEGIN
		SELECT @Conta = COUNT(*) FROM INV
						    		
		UPDATE Aspel_Paso SET
		Inventarios = 1, DescripcionInventarios = 'Importación Correcta', RegistrosInventarios = @Conta


		UPDATE Aspel_Paso SET
		Inventarios = 1, DescripcionInventarios = 'Importación Correcta', RegistrosInventarios = @Conta

		COMMIT TRANSACTION ASPEL
	END

	Exec spAspelActualizaProcesos 0

	IF @FlagError = 1  
		SELECT 'Migración con Errores, Revise Archivo C:\Log_INV.txt'
	ELSE
		SELECT 'Importación Correcta'
		
END
GO

/****** spPolizasIniciales ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spPolizasIniciales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spPolizasIniciales]
GO
CREATE PROCEDURE [dbo].[spPolizasIniciales]
--//WITH ENCRYPTION
AS  
DECLARE
@Sql 		nvarchar(max),
@Tabla		varchar(50),
@Cta		varchar(50),
@CtaOri		varchar(50),
@Saldo		decimal(15,7),  
@Modulo		varchar(5),
@Mov		varchar(20),
@Empresa	varchar(5), 
@Moneda		varchar(30), 
@TipoCambio	float(15),
@Usuario	varchar(10),
@Estatus	varchar(15),
@Sucursal	int,
@Renglon	int,
@ID		int,
@Cuenta		int,
@TablaCat	varchar(20),
@TablaCatD	varchar(30),
@Nombre		varchar(50),
@Naturaleza	varchar(1),
@DEBE		decimal(20,7)	,	 
@HABER		decimal(20,7), 		 
@Periodo	int,
@Digitos	int,
@Formato	varchar(24),
@Depto		int,
@RemglonSub	int
		

BEGIN
	SELECT @Usuario = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'
	SELECT @Moneda = Valor FROM AspelCfg WHERE Descripcion = 'Moneda'

	SELECT TOP 1 @Empresa = Empresa, @Mov = Mov, @Estatus = Estatus
	FROM AspelCargaReg 
	WHERE Modulo = 'CONT'

	SELECT TOP 1 @Periodo = Periodo FROM PASO_CTAS
	ORDER BY Cuenta
	
	SELECT @Formato = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Formato Cuentas Contables'
	SET @Digitos = LEN(REPLACE(REPLACE(RTRIM(LTRIM(@Formato)),'-',''),';2',''))  
  	SET @Digitos = CASE WHEN @Digitos = 0 THEN 20 ELSE @Digitos END
  
	/* Insertamos la Póliza de Saldos Iniciales */
	INSERT CONT (Empresa,Mov, MovId, FechaEmision,FechaContable,UltimoCambio,Moneda,TipoCambio,Usuario,Estatus, 
	Observaciones, Concepto, Periodo)
	VALUES (@Empresa,'Diario', 0, Getdate(), Getdate(), Getdate(), @Moneda, 1, @Usuario, 'SINAFECTAR', 
	'Saldo Inicial', 'Saldo Inicial', @Periodo)

	SET @ID = SCOPE_IDENTITY()

	DECLARE cur_Cuentas CURSOR FOR
	SELECT dbo.fnAspelFormateaCuentas(LEFT(Cuenta,@Digitos),@Formato), Nombre, SaldoIni, Naturaleza 
	FROM PASO_CTAS
	WHERE DEPTSINO = 'N'
	ORDER BY Cuenta

	OPEN cur_Cuentas
	FETCH NEXT FROM cur_Cuentas INTO @Cta, @Nombre, @Saldo, @Naturaleza

	SET @CtaOri = ''
	SET @Renglon = 0

	WHILE @@FETCH_STATUS <> -1
	BEGIN
		IF @CtaOri <> @Cta
		BEGIN
			SET @Renglon = @Renglon + 2048
			SET @CtaOri = @Cta
			SELECT @Debe = 0, @Haber = 0
			
			IF @Naturaleza = '0'  	SET @Debe = @Saldo 
		
			IF @Naturaleza = '1' 	SET @Haber = @Saldo
			
			/*Insertamos el detalle de la póliza */
			SET @Renglon = @Renglon + 2048
			INSERT CONTD (ID, Renglon, Cuenta, Concepto, Debe, Haber) 
			VALUES (@ID, @Renglon, @Cta, @Nombre, @Debe, @Haber)

		END

		FETCH NEXT FROM cur_Cuentas INTO @Cta, @Nombre, @Saldo, @Naturaleza
	END

	CLOSE cur_Cuentas
	DEALLOCATE cur_Cuentas
	
	DECLARE cur_Cuentas CURSOR FOR
	SELECT dbo.fnAspelFormateaCuentas(LEFT(Cuenta,@Digitos),@Formato), Nombre, SaldoIni, Naturaleza, DEPTO
	FROM PASO_CTASD
	ORDER BY Cuenta
	
	OPEN cur_Cuentas
	FETCH NEXT FROM cur_Cuentas INTO @Cta, @Nombre, @Saldo, @Naturaleza, @Depto

	SET @CtaOri = ''
	SET @Renglon = 0

	WHILE @@FETCH_STATUS <> -1
	BEGIN
		SELECT @Debe = 0, @Haber = 0
		
		IF @Naturaleza = '0'  	SET @Debe = @Saldo  
		IF @Naturaleza = '1' 	SET @Haber = @Saldo
			
		IF @CtaOri <> @Cta
		BEGIN
			SET @Renglon = @Renglon + 2048
			SET @CtaOri = @Cta
			SET @RemglonSub = 1	
		END
		ELSE
		BEGIN
			SET @RemglonSub = @RemglonSub +1
		END	
		
		/*Insertamos el detalle de la póliza */
		SET @Renglon = @Renglon + 2048
		INSERT CONTD (ID, Renglon, RenglonSub, Cuenta, Subcuenta, Concepto, Debe, Haber) 
		VALUES (@ID, @Renglon, @RemglonSub, @Cta, @Depto, @Nombre, @Debe, @Haber)
		

		FETCH NEXT FROM cur_Cuentas INTO  @Cta, @Nombre, @Saldo, @Naturaleza, @Depto
	END

	CLOSE cur_Cuentas
	DEALLOCATE cur_Cuentas
	
	SELECT @Debe = SUM(Debe)
	FROM CONTD
	
	UPDATE CONT SET
	Importe = @Debe
END
GO

/*********** spAspelInsertaPolizas ***********/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaPolizas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaPolizas]
GO


CREATE PROCEDURE  [dbo].[spAspelInsertaPolizas]
(
@Estacion	int
)
--//WITH ENCRYPTION
AS BEGIN
DECLARE	
@Modulo				varchar(5),
@FechaEmision		datetime,
@Mov				varchar(20),
@MovID			varchar(20),
@Empresa			varchar(5), 
@Moneda				varchar(30), 
@TipoCambio			float(15),
@Usuario			varchar(10),
@Estatus			varchar(15),
@Sucursal			int,
@ID					int,
@Renglon			int,
@Cuenta				varchar(20),
@Debe				money,
@Haber				money,
@Digitos			int,
@Formato			varchar(24),
@Observaciones		varchar(100),
@FlagError			bit,
@ManObj				int,
@ManArch			int,
@Cadena				varchar(500),
@Conta				int,
@Rid				int,
@ConceptoC			varchar(50),
@Concepto			varchar(50),
@Subcuenta			varchar(50),
@ImportaCOI			bit,
@Ok					int,
@OkRef				varchar(255)

	UPDATE AspelProcesos SET
	Estatus = 1
	WHERE Proceso = 'Polizas'

	UPDATE AspelCargaReg
	SET Mov = C.TipoPoliza
	FROM AspelCargaReg A, AspelCargaProp C
	WHERE A.Referencia = C.Valor
	AND A.Mov IS NULL
	
  SELECT @Usuario = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'
  SELECT @Moneda = Valor FROM AspelCfg WHERE Descripcion = 'Moneda'
  SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'

  SELECT @Formato = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Formato Cuentas Contables'
  SET @Digitos = LEN(REPLACE(REPLACE(RTRIM(LTRIM(@Formato)),'-',''),';2',''))  
  SET @Digitos = CASE WHEN @Digitos = 0 THEN 20 ELSE @Digitos END

  SELECT @ImportaCOI = CASE WHEN Valor = 'Si' THEN 1 ELSE 0 END FROM AspelCfgOpcion WHERE Descripcion = 'Importar COI'

create table #Pasito
(
Id	int, Descripcion	varchar(500)
)

SET @FlagError = 0
SET @Conta = 0
--  EXEC spHabilitarProcedimientosOle
  EXEC spCreaArchivo 'C:\Log_Polizas.txt', @ManObj OUT, @ManArch OUT
	SET @Ok = NULL
  BEGIN TRANSACTION ASPEL
  UPDATE Aspel_Paso SET
  Polizas = 0, DescripcionPolizas = ''
 
  IF @ImportaCOI = 1
  Begin

	EXEC spPolizasIniciales
  End
 	
  DECLARE crCabecera CURSOR FOR
	SELECT Empresa, Sucursal, Modulo, Mov, MovID, /*TipoCambio,*/FechaEmision, Estatus, Clase + Subclase
	FROM AspelCargaReg 
        WHERE Modulo = 'CONT'
      	GROUP BY Empresa, Sucursal, Modulo, Mov, MovID, /*TipoCambio,*/ FechaEmision, Estatus, Clase+Subclase

    OPEN crCabecera 
    FETCH NEXT FROM crCabecera INTO @Empresa, @Sucursal, @Modulo, @Mov, @MovID, /*@TipoCambio,*/ @FechaEmision, @Estatus, @ConceptoC
	WHILE @@FETCH_STATUS <> -1
	BEGIN 
        SELECT @Mov = TipoPoliza FROM AspelCargaProp WHERE Campo = 'TipoPoliza' AND Valor = @Mov
        
        
        INSERT CONT (Empresa,Mov,FechaEmision,FechaContable,UltimoCambio,Moneda,TipoCambio,Usuario,Estatus, 
        Observaciones, Referencia, MOVID) 
	VALUES (@Empresa,@Mov,@FechaEmision,@FechaEmision,@FechaEmision,@Moneda,1/*@TipoCambio*/,@Usuario,@Estatus, 
	@ConceptoC,  LTRIM(RTRIM(@Observaciones)) + ' ' + LTRIM(RTRIM(@MovID)) + ' ' + LTRIM(RTRIM(@Mov)), ltrim(rtrim(@MOVID)) )
		SET @ID = SCOPE_IDENTITY()

		DECLARE crDetalle CURSOR FOR
		SELECT dbo.fnAspelFormateaCuentas(LEFT(Mayor,@Digitos),@Formato), ISNULL(Debe,0), ISNULL(Haber,0),Centrocostos, concepto
		FROM AspelCargaReg 
		WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Modulo = @Modulo AND Mov = @Mov AND FechaEmision = @FechaEmision /*AND TipoCambio = @TipoCambio*/ AND 
		Estatus = @Estatus AND MovID = @MovID

		SET @Renglon = 0
		OPEN crDetalle 
		FETCH NEXT FROM crDetalle INTO @Cuenta, @Debe, @Haber, @Subcuenta , @Concepto
		WHILE @@FETCH_STATUS <> -1
		BEGIN 
			SET @Renglon = @Renglon + 2048
                	INSERT CONTD (ID, Renglon, Cuenta, Debe, Haber,Subcuenta, Concepto)
			VALUES (@ID, @Renglon, @Cuenta, @Debe, @Haber,@Subcuenta, @concepto)
				
			FETCH NEXT FROM crDetalle INTO @Cuenta, @Debe, @Haber, @Subcuenta , @Concepto
		END
		CLOSE crDetalle
		DEALLOCATE crDetalle


          EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'Todo', NULL, @Usuario, 0, 1,@Ok OUTPUT,@OkRef OUTPUT, NULL, 1, @Estacion
		--	EXEC spAfectar @Modulo, @ID, 'AFECTAR', 'Todo', NULL, @Usuario

            IF @Ok IS NOT NULL AND @Ok<80000 BEGIN
              SET @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID)
              
			  SET @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID)
			  SET @Conta = @Conta + 1
			  SET @Cadena = 'Modulo ' + @Modulo + ', Mov ' + @Mov + ', MovID ' + @MovID + ', Fecha ' + convert(varchar,@FechaEmision, 103) 
			  
			  Insert Into #Pasito(Id, Descripcion) Values (@Conta, @Cadena)
			  SET @FlagError = 1
--              BREAK 
          END

        FETCH NEXT FROM crCabecera INTO @Empresa, @Sucursal, @Modulo, @Mov, @MovID, /*@TipoCambio,*/ @FechaEmision, @Estatus, @ConceptoC
	  END
	CLOSE crCabecera
	DEALLOCATE crCabecera

	IF @FlagError = 1
	BEGIN
		DECLARE crLineas CURSOR FOR
		SELECT Descripcion FROM #PASITO
		ORDER BY Id
		
		OPEN crLineas
		FETCH NEXT FROM crLineas INTO @Cadena

		WHILE @@FETCH_STATUS = 0 
		BEGIN
			EXEC spInsertaEnArchivo @ManArch, @Cadena  

			FETCH NEXT FROM crLineas INTO @Cadena
		END

		CLOSE crLineas
		DEALLOCATE crLineas

		SELECT @Ok = 30230, @OkRef = 'Errores en el Módulo Polizas, verificar el Archivo C:\Log_Polizas'
	END
  	EXEC spCierraArchivo @ManObj, @ManArch
  	
  	IF @FlagError = 1
	BEGIN
		UPDATE Aspel_Paso SET
		DescripcionPolizas = 'Migración con Errores, Revise Archivo C:\Log_Polizas.txt'
		COMMIT TRANSACTION ASPEL
		-- ROLLBACK TRANSACTION ASPEL
	END
	ELSE
	BEGIN      	
		SELECT @Conta = COUNT(*)
		FROM AspelCargaReg 
		WHERE Modulo = 'CONT'
      		GROUP BY Empresa, Sucursal, Modulo, Mov, MovID, FechaEmision, Estatus
      	
		UPDATE Aspel_Paso SET
		Polizas = 1, DescripcionPolizas = 'Importación Correcta', RegistrosPolizas = @Conta

		COMMIT TRANSACTION ASPEL
	END

	Exec spAspelActualizaProcesos 0

	IF @FlagError = 1
		SELECT 'Migración con Errores, Revise Archivo C:\Log_Polizas.txt'
	ELSE
		SELECT 'Importación Correcta'
END
GO

/*********** spAspelInsertaPolizaAjuste ***********/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaPolizaAjuste]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaPolizaAjuste]
GO


CREATE PROCEDURE  [dbo].[spAspelInsertaPolizaAjuste]
(
@Estacion	int
)
--//WITH ENCRYPTION
AS BEGIN
DECLARE	
@Modulo				varchar(5),
@FechaEmision		datetime,
@Mov				varchar(20),
@MovID				varchar(20),
@Empresa			varchar(5), 
@Moneda				varchar(30), 
@TipoCambio			float(15),
@Usuario			varchar(10),
@Estatus			varchar(15),
@Sucursal			int,
@ID					int,
@Renglon			int,
@Cuenta				varchar(20),
@Debe				money,
@Haber				money,
@Observaciones		varchar(100),
@FlagError			bit,
@ManObj				int,
@ManArch			int,
@Cadena				varchar(500),
@Conta				int,
@Rid				int,
@Ok	int,
@OkRef	varchar(255)

  IF EXISTS(SELECT Valor FROM AspelCfgOpcion WHERE Descripcion = 'Generar Poliza De Ajuste' AND Valor = 'No') RETURN 

  SELECT @Usuario = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'
  SELECT @Moneda = Valor FROM AspelCfg WHERE Descripcion = 'Moneda'
  SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'

create table #Pasito
(
Id	int, Descripcion	varchar(500)
)

SET @FlagError = 0
SET @Conta = 0
--  EXEC spHabilitarProcedimientosOle
  EXEC spCreaArchivo 'C:\Log_Ajuste.txt', @ManObj OUT, @ManArch OUT

  SET @Ok = NULL
  BEGIN TRANSACTION ASPEL
  UPDATE Aspel_Paso SET
  PolizaAjuste = 0, DescripcionPolAjuste = ''
  
  DECLARE crCabecera CURSOR FOR
		SELECT Empresa, Sucursal, Modulo, Mov, MovID, FechaEmision, Estatus, RID
		  FROM AspelCargaReg 
         WHERE Modulo = 'AJUST'
      GROUP BY Empresa, Sucursal, Modulo, Mov, MovID, FechaEmision, Estatus, RID

    OPEN crCabecera 
    FETCH NEXT FROM crCabecera INTO @Empresa, @Sucursal, @Modulo, @Mov, @MovID, @FechaEmision, @Estatus
	WHILE @@FETCH_STATUS <> -1
	  BEGIN 
        SELECT @Mov = TipoPoliza FROM AspelCargaProp WHERE Campo = 'TipoPoliza' AND Valor = @Mov
        INSERT CONT (Empresa,Mov,FechaEmision,FechaContable,UltimoCambio,Moneda,TipoCambio,Usuario,Estatus, Observaciones, Concepto)
             VALUES (@Empresa,@Mov,@FechaEmision,@FechaEmision,@FechaEmision,@Moneda,1,@Usuario,@Estatus, @Observaciones, @Observaciones)
		SET @ID = SCOPE_IDENTITY()

		DECLARE crDetalle CURSOR FOR
				SELECT Mayor, ISNULL(Debe,0), ISNULL(Haber,0)
				  FROM AspelCargaReg 
				 WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Modulo = @Modulo AND Mov = @Mov AND FechaEmision = @FechaEmision AND 
                       Estatus = @Estatus


            SET @Renglon = 0
			OPEN crDetalle 
			FETCH NEXT FROM crDetalle INTO @Cuenta, @Debe, @Haber
			WHILE @@FETCH_STATUS <> -1
			  BEGIN 
				SET @Renglon = @Renglon + 2048
                INSERT CONTD (ID, Renglon, Cuenta, Debe, Haber)
					   VALUES (@ID, @Renglon, @Cuenta, @Debe, @Haber)

			    FETCH NEXT FROM crDetalle INTO @Cuenta, @Debe, @Haber
			  END
			CLOSE crDetalle
			DEALLOCATE crDetalle

            EXEC spAfectar 'CONT', @ID, 'AFECTAR', 'Todo', NULL, @Usuario, 0, 1,@Ok OUTPUT,@OkRef OUTPUT, NULL, 1, @Estacion
            IF @Ok IS NOT NULL AND @Ok<80000 BEGIN
              SET @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID)
			  SET @OkRef = @OkRef + ', ' + @Modulo + ':' + CONVERT(varchar,@ID)
			  SET @Conta = @Conta + 1
			  SET @Cadena = 'Modulo ' + @Modulo + ', Mov ' + @Mov + ', MovID ' + @MovID + ', Fecha ' + convert(varchar,@FechaEmision, 103)
			  
			  Insert Into #Pasito(Id, Descripcion) Values (@Conta, @Cadena)
			SET @FlagError = 1
--              BREAK 
            END
	
        FETCH NEXT FROM crCabecera INTO @Empresa, @Sucursal, @Modulo, @Mov, @MovID, @FechaEmision, @Estatus
	  END
	CLOSE crCabecera
	DEALLOCATE crCabecera
  
	IF @FlagError = 1
	BEGIN
		DECLARE crLineas CURSOR FOR
		SELECT Descripcion FROM #PASITO
		ORDER BY Id
		
		OPEN crLineas
		FETCH NEXT FROM crLineas INTO @Cadena

		WHILE @@FETCH_STATUS = 0 
		BEGIN
			EXEC spInsertaEnArchivo @ManArch, @Cadena  

			FETCH NEXT FROM crLineas INTO @Cadena
		END

		CLOSE crLineas
		DEALLOCATE crLineas

		SELECT @Ok = 30230, @OkRef = 'Errores en el Módulo Polizas Ajuste, verificar el Archivo C:\Log_Ajuste'
	END
	EXEC spCierraArchivo @ManObj, @ManArch
	
	IF @FlagError = 1
	BEGIN
		UPDATE Aspel_Paso SET
		DescripcionPolAjuste = 'Migración con Errores, Revise Archivo C:\Log_Ajuste.txt'

		ROLLBACK TRANSACTION ASPEL
	END
	ELSE
	BEGIN
		SELECT @Conta = COUNT(*)
		FROM AspelCargaReg 
		WHERE Modulo = 'AJUST'
      		GROUP BY Empresa, Sucursal, Modulo, Mov, MovID, FechaEmision, Estatus
      		
		UPDATE Aspel_Paso SET
		PolizaAjuste = 1, DescripcionPolAjuste = 'Importación Correcta', RegistrosPolAjuste = @Conta

		COMMIT TRANSACTION ASPEL
	END
END
GO

/*********** spAspelInsertaMovimientos ***********/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaMovimientos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaMovimientos]
GO


CREATE PROCEDURE  [dbo].[spAspelInsertaMovimientos]
                  (
				   @Estacion	int
                  )
--//WITH ENCRYPTION
AS BEGIN
				
  IF (SELECT Insertar FROM AspelCfgMovimiento WHERE Movimiento = 'Venta') = 1 
    EXEC spAspelInsertaVentas @Estacion
  IF (SELECT Insertar FROM AspelCfgMovimiento WHERE Movimiento = 'Compra') = 1 --AND (@OK IS NULL OR @Ok < 80000)
    EXEC spAspelInsertaCompras @Estacion
  IF (SELECT Insertar FROM AspelCfgMovimiento WHERE Movimiento = 'Cxc') = 1 --AND (@OK IS NULL OR @Ok >= 80000)
    EXEC spAspelInsertaCxc @Estacion
  IF (SELECT Insertar FROM AspelCfgMovimiento WHERE Movimiento = 'Cxp') = 1 --AND (@OK IS NULL OR @Ok >= 80000)
    EXEC spAspelInsertaCxp @Estacion
  IF (SELECT Insertar FROM AspelCfgMovimiento WHERE Movimiento = 'Inventario') = 1 --AND (@OK IS NULL OR @Ok >= 80000)
    EXEC spAspelInsertaInventarios @Estacion
  IF (SELECT Insertar FROM AspelCfgMovimiento WHERE Movimiento = 'Poliza') = 1 --AND (@OK IS NULL OR @Ok >= 80000)
    EXEC spAspelInsertaPolizas @Estacion
  --IF  @OK IS NULL
    --EXEC spAspelInsertaPolizaAjuste @Estacion

END
GO

/*********** spAspelInsertaAgentes ***********/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaAgentes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaAgentes]
GO
CREATE PROCEDURE  [dbo].[spAspelInsertaAgentes]
--//WITH ENCRYPTION
AS BEGIN
DECLARE	@Observaciones			varchar(30),
		@Sucursal				varchar(30)

SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'
IF NOT EXISTS(SELECT Categoria FROM AgenteCat WHERE Categoria = @Observaciones)
  INSERT INTO AgenteCat (Categoria) VALUES (@Observaciones)  

SELECT @Sucursal = Valor FROM AspelCfg WHERE Descripcion = 'Sucursal'

INSERT INTO Agente (Agente, Nombre, Tipo, Estatus, TipoComision, Porcentaje, eMail, UltimoCambio, Categoria, SucursalEmpresa, Familia)
     SELECT Valor, Nombre, Tipo, Estatus, TipoComision, Porcentaje*100, eMail, getdate(), @Observaciones, @Sucursal, Familia
     FROM AspelCargaProp
    WHERE Campo = 'Agente' and Valor not in (select Agente from agente)

END
GO

/****** spAspelInsertaAlmacenes ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaAlmacenes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaAlmacenes]
GO
CREATE PROCEDURE [dbo].[spAspelInsertaAlmacenes]
--//WITH ENCRYPTION
AS BEGIN
DECLARE	@Observaciones	varchar(30),
	@Sucursal	varchar(30),
	@Cuenta		int

SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'
IF NOT EXISTS(SELECT Grupo FROM AlmGrupo WHERE Grupo = @Observaciones)
  INSERT INTO AlmGrupo (Grupo) VALUES (@Observaciones)  

SELECT @Sucursal = Valor FROM AspelCfg WHERE Descripcion = 'Sucursal'

INSERT INTO Alm (Almacen,Nombre,Estatus,UltimoCambio,Alta,Grupo, Sucursal, Observaciones)
SELECT Valor, Nombre, ISNULL(Estatus, 'ALTA'), getdate(), getdate(), @Observaciones, @Sucursal, @Observaciones 
FROM AspelCargaProp
WHERE Campo = 'Almacen' 

END
GO


/*********** spAspelInsertaArticulos ***********/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaArticulos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaArticulos]
GO

CREATE PROCEDURE  [dbo].[spAspelInsertaArticulos]
--//WITH ENCRYPTION
AS BEGIN
DECLARE	@Observaciones			varchar(30),
		@Sucursal		varchar(30),
		@Moneda			varchar(30),
		@Usuario		varchar(30),
		@Conta			int

SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'
SELECT @Sucursal = Valor FROM AspelCfg WHERE Descripcion = 'Sucursal'
SELECT @Moneda = Valor FROM AspelCfg WHERE Descripcion = 'Moneda'
SELECT @Usuario = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'

INSERT ArtLinea (Linea,Clave)
SELECT DISTINCT A.Linea, A.Linea from AspelCargaProp A 
 WHERE Campo = 'Articulo' AND A.Linea <> '' 
 and a.linea not in (select LINEA from artlinea)


IF NOT EXISTS(SELECT Categoria FROM ArtCat WHERE Categoria = @Observaciones)
  INSERT INTO ArtCat (Categoria) VALUES (@Observaciones)  

INSERT INTO Art (Articulo, Descripcion1, Impuesto1, Impuesto2, Impuesto3, Unidad, UnidadCompra, UnidadCantidad, TipoCosteo, Tipo, TipoOpcion, Accesorios, 
            Refacciones, Servicios, Consumibles, MonedaCosto, MonedaPrecio, PrecioLista, FactorAlterno, Estatus, EstatusPrecio, UltimoCambio, 
            Sustitutos, Alta, Refrigeracion, TieneCaducidad, wMostrar, Usuario, SeVende, SeCompra, SeProduce, EsFormula, 
            MultiplosOrdenar, RevisionUsuario, TieneMovimientos, EstatusCosto, SolicitarPrecios, Espacios, EspaciosEspecificos, 
            EspaciosNivel, EspaciosBloquearAnteriores, EspaciosMinutos, BasculaPesar, SerieLoteInfo, FactorCompra, ISAN, ExcluirDescFormaPago, 
            EsDeducible, TipoCatalogo, AnexosAlFacturar, Actividades, ValidarPresupuestoCompra, SeriesLotesAutoOrden, LotesFijos, LotesAuto, 
            TieneDireccion, PrecioLiberado, ValidarCodigo, CostoIdentificado, Impuesto1Excento, Linea, Proveedor,
            TiempoEntrega, TiempoEntregaUnidad, Precio2, Precio3, Precio4, Precio5, Peso, Volumen, Categoria, Descripcion2, CostoEstandar, CodigoAlterno, AlmacenROP)
     SELECT substring(Valor, 1, 20), Nombre, Impuesto1, Impuesto2, Impuesto3,CURP, Unidad, 1.0, substring(TipoCosteo, 1, 10), Tipo, Categoria, 0, 
            0, 0, 0, @Moneda, Rama, PrecioLista, 1.0, Estatus, 'NUEVO', GETDATE(), 
            0, GETDATE(), 0, 0, 1, substring(@Usuario, 1, 10), 1, 1, 0, 0, 
            1.0, substring(@Usuario, 1, 10), 0, 'SINCAMBIO', 0, 0, 0, 
            'Dia', 1, 60, 0, 0, 1.0, 0, 0, 
            0, 'Resurtible', 0, 0, 'No', '(Empresa)', 0, 0,
            0, 0, 0, 0, 0, Linea, dbo.fnAspelJustificaClave(LTRIM(RTRIM(Proveedor))),
            TiempoEntrega, TiempoEntregaU, Precio2, Precio3, Precio4, Precio5, ROUND(Peso, dbo.fnAspelDecimales(CONVERT(VARCHAR, PESO))), Volumen, @Observaciones, 
            substring(@Observaciones + ': ' + Descripcion2, 1, 100), Costo, substring(Descripcion, 1, 50), '(Demanda)' 
       FROM AspelCargaProp 
      WHERE Campo = 'Articulo' and VALOR not in (select articulo from art)


SELECT @Conta = COUNT(*) FROM Art
WHERE Articulo = 'FLETE'

IF @Conta = 0
	INSERT INTO Art (Articulo, Descripcion1, Impuesto1, Unidad, UnidadCompra, UnidadCantidad, TipoCosteo, Tipo, TipoOpcion, Accesorios, 
            Refacciones, Servicios, Consumibles, MonedaCosto, MonedaPrecio, PrecioLista, FactorAlterno, Estatus, EstatusPrecio, UltimoCambio, 
            Sustitutos, Alta, Refrigeracion, TieneCaducidad, wMostrar, Usuario, SeVende, SeCompra, SeProduce, EsFormula, 
            MultiplosOrdenar, RevisionUsuario, TieneMovimientos, EstatusCosto, SolicitarPrecios, Espacios, EspaciosEspecificos, 
            EspaciosNivel, EspaciosBloquearAnteriores, EspaciosMinutos, BasculaPesar, SerieLoteInfo, FactorCompra, ISAN, ExcluirDescFormaPago, 
            EsDeducible, TipoCatalogo, AnexosAlFacturar, Actividades, ValidarPresupuestoCompra, SeriesLotesAutoOrden, LotesFijos, LotesAuto, 
            TieneDireccion, PrecioLiberado, ValidarCodigo, CostoIdentificado, Impuesto1Excento, Linea, Proveedor,
            TiempoEntrega, TiempoEntregaUnidad, Precio2, Precio3, Precio4, Precio5, Peso, Volumen, Categoria, Observaciones, CostoEstandar, CodigoAlterno)
     	VALUES('FLETE', 'Fletes Aspel', 15, 'pz', 'pz', 1.0, 'Promedio', 'Normal', 'No', 0, 
            0, 0, 0, @Moneda, @Moneda, 0.0, 1.0, 'ALTA', 'NUEVO', GETDATE(), 
            0, GETDATE(), 0, 0, 1, @Usuario, 1, 1, 0, 0, 
            1.0, @Usuario, 0, 'SINCAMBIO', 0, 0, 0, 
            'Dia', 1, 60, 0, 0, 1.0, 0, 0, 
            0, 'Resurtible', 0, 0, 'No', '(Empresa)', 0, 0,
            0, 0, 0, 0, 0, '', '',
            0, 'Dias', 0.0, 0.0, 0.0, 0.0, 0, 0, @Observaciones, @Observaciones, 0.0, '')


SELECT @Conta = COUNT(*) FROM Art
WHERE Articulo = 'INDIRECTOS' 

IF @Conta = 0
	INSERT INTO Art (Articulo, Descripcion1, Impuesto1, Unidad, UnidadCompra, UnidadCantidad, TipoCosteo, Tipo, TipoOpcion, Accesorios, 
            Refacciones, Servicios, Consumibles, MonedaCosto, MonedaPrecio, PrecioLista, FactorAlterno, Estatus, EstatusPrecio, UltimoCambio, 
            Sustitutos, Alta, Refrigeracion, TieneCaducidad, wMostrar, Usuario, SeVende, SeCompra, SeProduce, EsFormula, 
            MultiplosOrdenar, RevisionUsuario, TieneMovimientos, EstatusCosto, SolicitarPrecios, Espacios, EspaciosEspecificos, 
            EspaciosNivel, EspaciosBloquearAnteriores, EspaciosMinutos, BasculaPesar, SerieLoteInfo, FactorCompra, ISAN, ExcluirDescFormaPago, 
            EsDeducible, TipoCatalogo, AnexosAlFacturar, Actividades, ValidarPresupuestoCompra, SeriesLotesAutoOrden, LotesFijos, LotesAuto, 
            TieneDireccion, PrecioLiberado, ValidarCodigo, CostoIdentificado, Impuesto1Excento, Linea, Proveedor,
            TiempoEntrega, TiempoEntregaUnidad, Precio2, Precio3, Precio4, Precio5, Peso, Volumen, Categoria, Observaciones, CostoEstandar, CodigoAlterno)
     	VALUES('INDIRECTOS', 'Gastos Indirectos Aspel', 15, 'pz', 'pz', 1.0, 'Promedio', 'Normal', 'No', 0, 
            0, 0, 0, @Moneda, @Moneda, 0.0, 1.0, 'ALTA', 'NUEVO', GETDATE(), 
            0, GETDATE(), 0, 0, 1, @Usuario, 1, 1, 0, 0, 
            1.0, @Usuario, 0, 'SINCAMBIO', 0, 0, 0, 
            'Dia', 1, 60, 0, 0, 1.0, 0, 0, 
            0, 'Resurtible', 0, 0, 'No', '(Empresa)', 0, 0,
            0, 0, 0, 0, 0, '', '',
            0, 'Dias', 0.0, 0.0, 0.0, 0.0, 0, 0, @Observaciones, @Observaciones, 0.0, '')

END
GO

/****** AspelClasCte ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspelClasCte]') AND type in (N'U'))
DROP TABLE [dbo].[AspelClasCte]
GO

CREATE TABLE [dbo].[AspelClasCte](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CampoSae] [varchar](5) COLLATE Database_Default NOT NULL,
	[Inicio] [tinyint] NULL,
	[Longitud] [tinyint] NULL,
	[Descripcion] [varchar](50) COLLATE Database_Default NULL,
	[CampoIntelisis] [varchar](20) COLLATE Database_Default NULL,
 CONSTRAINT [PK_AspelClasCte] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

/*********** spAspelInsertaClientes ***********/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaClientes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaClientes]
GO


CREATE PROCEDURE  [dbo].[spAspelInsertaClientes]
--//WITH ENCRYPTION
AS BEGIN
DECLARE	
@Observaciones	varchar(30),
@Sucursal	varchar(30),
@Moneda		varchar(30),
@Usuario	varchar(30),
@Condicion	varchar(50),
@Orden		int,
@Cuenta		int,
@Descuento	varchar(30),
@Camposae	varchar(5),
@Inicio		tinyint,
@Longitud	tinyint,
@Descrip	varchar(100),
@Cliente	varchar(20),
@Cuentadescuento int


SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'
IF NOT EXISTS(SELECT Categoria FROM CteCat WHERE Categoria = @Observaciones)
  INSERT INTO CteCat (Categoria) VALUES (@Observaciones)  

INSERT CteGrupo (Grupo)
SELECT DISTINCT A.Grupo FROM AspelCargaProp A FULL JOIN CteGrupo B
    ON A.Grupo = B.Grupo WHERE Campo = 'Cliente' AND A.Grupo <> '' AND B.Grupo = NULL

SELECT @Sucursal = Valor FROM AspelCfg WHERE Descripcion = 'Sucursal'
SELECT @Moneda = Valor FROM AspelCfg WHERE Descripcion = 'Moneda'
SELECT @Usuario = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'

INSERT INTO Cte (Cliente, Nombre, Direccion, Colonia, Poblacion, CodigoPostal, Telefonos, Fax, Contacto1, Email1, RFC, CURP, Estatus, Tipo, UltimoCambio, Alta, Categoria,  
	PedirTono, VtasConsignacion, Conciliar, wVerDisponible, wVerArtListaPreciosEsp, CreditoEspecial, CreditoConLimite, CreditoConDias, CreditoConCondiciones,
	TieneMovimientos, DescuentoRecargos, FormasPagoRestringidas, PreciosInferioresMinimo, PersonalSMS, Fuma, EsProveedor, EsPersonal, EsAgente, EsAlmacen,
	EsEspacio, EsCentroCostos, EsProyecto, EsCentroTrabajo, EsEstacionTrabajo, PedidoDef, eMailAuto, Intercompania, Publico, Extranjero, DocumentacionCompleta,
	CreditoMoneda, DeducibleMoneda, DefMoneda,
	ChecarCredito, BloquearMorosos, ModificarVencimiento, RecorrerVencimiento,
	BonificacionTipo, Usuario, PedidosParciales, Observaciones, Grupo, Condicion, CreditoLimite, Agente, Descuento, nombrecorto)

-- Si hay clientes por ejemplo C55 y c55 sólo se da de alta uno
SELECT  Valor, Nombre, Direccion, Colonia, Poblacion, CodigoPostal, Telefonos, Fax, Contacto, Email, RFC, CURP, Estatus, 'Cliente', getdate(), getdate(), @Observaciones,
	0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	@Moneda, @Moneda, @Moneda, 
	'(Empresa)', '(Empresa)', '(Empresa)', '(Empresa)',
	'No', @Usuario, 1,  descripcion2, Grupo, Rama, Impuesto1, Proveedor, 
	CASE WHEN CONVERT(real, Factor) = 0 THEN NULL ELSE Factor END, Tipo
	FROM AspelCargaProp
	WHERE Campo = 'Cliente'  and Valor not in (select Cliente from cte)
	
UPDATE Cte
SET CreditoEspecial = 1, CreditoConLimite = 1
WHERE CreditoLimite > 0

SELECT @Orden = MAX(Orden)  FROM Condicion

DECLARE Cur_Condicion CURSOR FOR
SELECT DISTINCT Condicion FROM Cte
WHERE Condicion IS NOT NULL

OPEN Cur_Condicion
FETCH NEXT FROM Cur_Condicion Into @Condicion

WHILE @@FETCH_STATUS <> -1
BEGIN
	SELECT @Orden = @Orden + 1
		SELECT @Cuenta = COUNT(*) FROM Condicion
		WHERE Condicion = @Condicion
	
		IF @Cuenta = 0
		BEGIN
			INSERT INTO Condicion(Condicion, DiasVencimiento, TipoDias, DiasHabiles, TipoDiasprontoPago, DiasHabilesProntoPago,
			ProntoPago, PorMeses, orden, RecorrerVencimiento, DA, DAImpPrimerDoc, ControlAnticipos, Anticipado, Corte, 
			FechaProntoPago, TipoCondicion, InteresMoratorioBaseTabla, AutoFin, Neteo, Interesesdevengados, DATipoInteres, 
			FacturaCobroIntegradoParcial, PorSemanas) --, CFD_FormaDePago, CFD_MetodoDePago)
			VALUES (@Condicion, CONVERT(Int, SUBSTRING(@Condicion, 1, 2)), 'Naturales ', 'Lun-Vie', 'Habiles', 'Lun-Vie',
			0, 0, @Orden, 0, 0, 0, 'No', 0, 0,
			'Emision', 'Credito', 0, 0, 0, 0, 'Global',
			0, 0) --, 'Pago en una sola Exhibición', 'Depósito en cuenta.'
		END
	
	FETCH NEXT FROM Cur_Condicion Into @Condicion
END

CLOSE Cur_Condicion
DEALLOCATE Cur_Condicion

set @cuentadescuento = 0


DECLARE Cur_Descuento CURSOR FOR
SELECT DISTINCT Descuento,Cliente FROM Cte
WHERE Descuento IS NOT NULL

OPEN Cur_Descuento
FETCH NEXT FROM Cur_Descuento Into @Descuento, @Cliente

WHILE @@FETCH_STATUS <> -1
BEGIN
	SELECT @Cuenta = COUNT(*) FROM Descuento
	WHERE Descuento = @Descuento

	IF @Cuenta = 0
	BEGIN
		INSERT INTO Precio(Descripcion,Estatus,Ultimocambio,Nivelarticulo,Nivelsubcuenta,Nivelartgrupo,
	Nivelartcat,Nivelartfam,Nivelartabc,Nivelfabricante,Nivelartlinea,Nivelartrama,Nivelcliente,
cliente,Nivelctegrupo,nivelctecat,nivelctefam,nivelctezona,nivelmoneda,nivelcondicion,nivelalmacen,
nivelproyecto,nivelagente,nivelformaenvio,nivelmov,nivelserviciotipo,nivelcontratotipo,nivelunidadventa,
nivelempresa,nivelregion,nivelsucursal,tipo,nivel,Listaprecios,convigencia,Logico1,Logico2,wMostrar)
	
		VALUES ('Cliente '  + @Cliente + ' ' + @Descuento + '%' , 'ACTIVA', GETDATE(),0,0,0,
0,0,0,0,0,0,1,@cliente,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'% Descuento','Normal','Todas',0,0,0,0)			-- Cambio 090209

	set @cuentadescuento = @cuentadescuento +1

	INSERT INTO PRECIOD(ID, Cantidad,Monto, Sucursal)

		VALUES(@Cuentadescuento, 1,@Descuento,0)


	END
	
FETCH NEXT FROM Cur_Descuento Into @Descuento, @Cliente

END

CLOSE Cur_Descuento
DEALLOCATE Cur_Descuento


--Si hay datos en la tabla de clasificación de clientes para la migración entonces los insertamos.
	SELECT @Cuenta = COUNT(*)
	FROM AspelClasCte

	IF @Cuenta > 0
	BEGIN
		INSERT INTO CteCat (Categoria)
		SELECT Descripcion FROM AspelClasCte
		WHERE CampoIntelisis  = 'CATEGORIA'
		
		INSERT INTO CteGrupo (Grupo)
		SELECT Descripcion FROM AspelClasCte
		WHERE CampoIntelisis  = 'GRUPO'
		
		INSERT INTO CteFam (Familia)
		SELECT Descripcion FROM AspelClasCte
		WHERE CampoIntelisis  = 'FAMILIA'
		
		DECLARE Cur_Agrupadores CURSOR FOR
		SELECT CampoSae, Inicio, Longitud, Descripcion
		FROM AspelClasCte
		WHERE CampoIntelisis  = 'CATEGORIA'
		
		OPEN Cur_Agrupadores
		FETCH NEXT FROM Cur_Agrupadores Into @CampoSae, @Inicio, @Longitud, @Descrip

		WHILE @@FETCH_STATUS <> -1
		BEGIN
			UPDATE Cte SET
			Categoria = A.Descripcion
			FROM Cte C, AspelClasCte A
			WHERE SUBSTRING(C.Grupo, @Inicio, @Longitud) = A.CampoSae
			
			FETCH NEXT FROM Cur_Agrupadores Into @CampoSae, @Inicio, @Longitud, @Descrip
		END
		
		CLOSE Cur_Agrupadores
		DEALLOCATE Cur_Agrupadores
		
		DECLARE Cur_Agrupadores CURSOR FOR
		SELECT CampoSae, Inicio, Longitud, Descripcion
		FROM AspelClasCte
		WHERE CampoIntelisis  = 'FAMILIA'

		OPEN Cur_Agrupadores
		FETCH NEXT FROM Cur_Agrupadores Into @CampoSae, @Inicio, @Longitud, @Descrip

		WHILE @@FETCH_STATUS <> -1
		BEGIN
			UPDATE Cte SET
			Familia = A.Descripcion
			FROM Cte C, AspelClasCte A
			WHERE SUBSTRING(C.Grupo, @Inicio, @Longitud) = A.CampoSae

			FETCH NEXT FROM Cur_Agrupadores Into @CampoSae, @Inicio, @Longitud, @Descrip
		END

		CLOSE Cur_Agrupadores
		DEALLOCATE Cur_Agrupadores
		
		DECLARE Cur_Agrupadores CURSOR FOR
		SELECT CampoSae, Inicio, Longitud, Descripcion
		FROM AspelClasCte
		WHERE CampoIntelisis  = 'GRUPO'

		OPEN Cur_Agrupadores
		FETCH NEXT FROM Cur_Agrupadores Into @CampoSae, @Inicio, @Longitud, @Descrip

		WHILE @@FETCH_STATUS <> -1
		BEGIN
			UPDATE Cte SET
			Grupo = A.Descripcion
			FROM Cte C, AspelClasCte A
			WHERE SUBSTRING(C.Grupo, @Inicio, @Longitud) = A.CampoSae

			FETCH NEXT FROM Cur_Agrupadores Into @CampoSae, @Inicio, @Longitud, @Descrip
		END

		CLOSE Cur_Agrupadores
		DEALLOCATE Cur_Agrupadores
	END


END
GO

/************ spinsertagrupos ************/
IF EXISTS(SELECT * FROM sysobjects WHERE Id=OBJECT_ID('dbo.spinsertagrupos') AND Type='P') 
DROP PROC dbo.spinsertagrupos

GO

CREATE PROCEDURE spinsertagrupos
--//WITH ENCRYPTION
AS 			
DECLARE 

			@BDatos			varchar(30),		-- Tabla temporal
			@BDOrigenSAE			varchar(30), 
			@SrvOrigenSAE			varchar(50),
			@OrigenSAE				varchar(100), 
			@RutaSAE				varchar(250),
			@Empresa			varchar(2),
			@ImportaCOI			bit, 
			@SrvOrigenCOI			varchar(50), 
			@BDOrigenCOI			varchar(30), 
			@OrigenCOI				varchar(100), 
			@RutaCOI				varchar(250),
			@EmpresaCOI			int,
			@BaseDatosPaso		varchar(30),
			@SrvIntelisis			varchar(50),
			@BaseDatosIntelisis	varchar(30),
			@sql					nvarchar(1000),
			@Cuenta				int,
			@Tabla				varchar(25)

	SET ANSI_NULLS ON
	SET ANSI_WARNINGS ON

	SELECT @SrvOrigenCOI = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Servidor COI'
	
	select @Cuenta = count(*) from master.dbo.sysservers where srvname = @SrvOrigenCOI
  
	if @Cuenta = 0
		exec sp_addlinkedserver @SrvOrigenCOI
	
	SELECT @BDOrigenCOI = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Base De Datos COI'
	SELECT @SrvOrigenCOI = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Servidor COI'
	SELECT @EmpresaCOI = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Empresa COI'

	SET @Empresa = RIGHT('00' + convert(varchar, @EmpresaCOI),2)
	SET @Tabla = 'DEPTO' + @Empresa

BEGIN

SET @SQL = '' 

+ 'INSERT CENTROCOSTOS (CentroCostos,Descripcion,Esacumulativo,Tienemovimientos,Estatus)'
+ 'Select convert(varchar,NUM_REG), DESCRIP,' + char(39) + '0' +char(39) +',' + char(39) +'0'+char(39)+','+ char(39) + 'ALTA'+ char(39)
+ ' from '+ @SrvOrigenCOI +'.'+@BDOrigenCOI +'.dbo.'+ @Tabla
EXEC sp_executesql @SQL

END
GO

/****** spAspelInsertaCuentas ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaCuentas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaCuentas]
GO


CREATE PROCEDURE [dbo].[spAspelInsertaCuentas]
--//WITH ENCRYPTION
AS BEGIN
DECLARE	@Cuenta			varchar(50),
@Rubro			int,
@Usuario		varchar(20),
@Rama			varchar(50),
@NivelMax		varchar(1),
@NivelMin		varchar(1),
@Empresa		varchar(5),
@Formato		varchar(30),
@Digitos		int,
@Observaciones	varchar(30)

EXEC spinsertagrupos			-- Departamentos COI como centros de costos

SELECT @Usuario = Valor FROM AspelCfg WHERE Descripcion = 'Usuario'
SELECT @Empresa = Valor FROM AspelCfg WHERE Descripcion = 'Empresa'
SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'
IF NOT EXISTS(SELECT Grupo FROM CtaGrupo WHERE Grupo = @Observaciones)
INSERT INTO CtaGrupo (Grupo) VALUES (@Observaciones)
SELECT @Formato = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Formato Cuentas Contables'
UPDATE EmpresaCfg SET CtaFormato = LEFT(@Formato,20) WHERE Empresa = @Empresa
SET @Digitos = LEN(REPLACE(REPLACE(RTRIM(LTRIM(@Formato)),'-',''),';2',''))
SET @Digitos = CASE WHEN @Digitos = 0 THEN 20 ELSE @Digitos END

SELECT ValorNumero, Valor, Rama INTO #Rubro FROM AspelCargaProp WHERE Campo = 'Rubro' ORDER BY ValorNumero
SELECT ValorNumero, Valor INTO #RubroCuenta FROM AspelCargaProp WHERE Campo = 'RubroCuenta' ORDER BY ValorNumero
SELECT Valor, Nombre, Estatus, Tipo, Rama,Valornumero,Descripcion INTO #Cuenta FROM AspelCargaProp WHERE Campo = 'Cuenta' 

DECLARE crRubroCuenta CURSOR FOR
SELECT A.ValorNumero, A.Valor, B.Rama
FROM #RubroCuenta A JOIN #Rubro B
ON A.ValorNumero = B.ValorNumero
ORDER BY B.ValorNumero
OPEN crRubroCuenta
FETCH NEXT FROM crRubroCuenta INTO @Rubro, @Cuenta, @Rama
WHILE @@FETCH_STATUS <> -1
BEGIN
UPDATE #Cuenta SET Rama = CASE WHEN @Rama IS NOT NULL THEN @Rama ELSE Rama END
WHERE Valor = @Cuenta
FETCH NEXT FROM crRubroCuenta INTO @Rubro, @Cuenta, @Rama
END
CLOSE crRubroCuenta
DEALLOCATE crRubroCuenta
SELECT @NivelMax = MAX(RIGHT(Valor,1)) from #Cuenta
SELECT @NivelMin = MIN(RIGHT(Valor,1)) from #Cuenta


INSERT CTA (Cuenta, Rama, Descripcion, Tipo, EsAcumulativa, Estatus, UltimoCambio, Alta,Grupo,Centroscostos,Centrocostosrequerido,EsAcreedora) 				
SELECT
dbo.fnAspelFormateaCuentas(LEFT(Valor,@Digitos),@Formato),
dbo.fnAspelFormateaCuentas(LEFT(Rama,@Digitos),@Formato),
LEFT(Nombre,100),
dbo.fnAspelTipoCuentas(RIGHT(Valor,1),@NivelMin,@NivelMax),
CASE WHEN Tipo = 'A' THEN 1 ELSE 0 END,
Estatus,
getdate(),
getdate(),
@Observaciones,
Valornumero,				
Valornumero,					
Descripcion
FROM #Cuenta
where dbo.fnAspelFormateaCuentas(LEFT(Valor,@Digitos),@Formato) not in (select cuenta from cta)	--- Cambio


END
GO

/*********** spAspelInsertaMonedas ***********/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaMonedas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaMonedas]
GO
CREATE PROCEDURE  [dbo].[spAspelInsertaMonedas]
--//WITH ENCRYPTION
AS BEGIN
	DECLARE @Observaciones varchar(30)
	DELETE FROM Mon
	SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'
	INSERT INTO Mon (Moneda, Orden, Nombre, TipoCambio, UltimoCambio, Clave)
	SELECT LEFT(Valor,10), Orden, Nombre + ' ' + RTRIM(LTRIM(@Observaciones)) , TipoCambio, getdate(), Clave
	FROM AspelCargaProp
	WHERE Campo = 'Moneda'

END
GO


/*********** spAspelInsertaProveedores ***********/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaProveedores]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaProveedores]
GO


CREATE PROCEDURE  [dbo].[spAspelInsertaProveedores]
--//WITH ENCRYPTION
AS BEGIN
DECLARE	
@Observaciones	varchar(30),
@Sucursal	varchar(30),
@Moneda		varchar(30),
@Usuario	varchar(30),
@Condicion	varchar(50),
@Orden		int,
@Cuenta		int,
@Descuento	varchar(30)

SELECT @Observaciones = Valor FROM AspelCfg WHERE Descripcion = 'Observaciones'
IF NOT EXISTS(SELECT Categoria FROM ProvCat WHERE Categoria = @Observaciones)
  INSERT INTO ProvCat (Categoria) VALUES (@Observaciones)  

INSERT ProvFam (Familia)
SELECT DISTINCT A.Familia FROM AspelCargaProp A FULL JOIN ProvFam B
    ON A.Familia = B.Familia WHERE Campo = 'Proveedor' AND A.Familia <> '' AND B.Familia = NULL

SELECT @Moneda = Valor FROM AspelCfg WHERE Descripcion = 'Moneda'

INSERT INTO Prov (Proveedor, Nombre, Direccion, Colonia, Poblacion, Zona, CodigoPostal, Telefonos, Fax, Email1, RFC, CURP, Categoria,
	PedirTono,  Estatus, UltimoCambio, Alta, Conciliar, Tipo, ProntoPago, DefMoneda, Logico1, Logico2, Logico3, TieneMovimientos, DescuentoRecargos,
	CompraAutoCargosTipo, Pagares, wGastoSolicitud, ConLimiteAnticipos, ChecarLimite, eMailAuto, Intercompania, GarantiaCostos,Observaciones, 
	Familia, Condicion, Descuento)
SELECT distinct Valor, Nombre, Direccion, Colonia, Poblacion, Zona, CodigoPostal, Telefonos, Fax, Email, substring(RFC, 1, 15), CURP, @Observaciones,
	0, Estatus, getdate(), getdate(), 0, 'Proveedor', 0, substring(@Moneda, 1, 10), 0, 0, 0, 0, 0,
	'No', 0, 0, 0, 'Anticipo', 0, 0, 0, Descripcion2, Familia, Rama,
	CASE WHEN CONVERT(real, Factor) = 0 THEN NULL ELSE Factor END
	FROM AspelCargaProp
	WHERE Campo = 'Proveedor' and Valor not in (select Proveedor  from prov)



SELECT @Orden = MAX(Orden)  FROM Condicion

DECLARE Cur_Condicion CURSOR FOR
SELECT DISTINCT Condicion FROM Prov
WHERE Condicion IS NOT NULL

OPEN Cur_Condicion
FETCH NEXT FROM Cur_Condicion Into @Condicion

WHILE @@FETCH_STATUS <> -1
BEGIN
	SELECT @Orden = @Orden + 1
	SELECT @Cuenta = COUNT(*) FROM Condicion
	WHERE Condicion = @Condicion

	IF @Cuenta = 0
	BEGIN
		INSERT INTO Condicion(Condicion, DiasVencimiento, TipoDias, DiasHabiles, TipoDiasprontoPago, DiasHabilesProntoPago,
		ProntoPago, PorMeses, orden, RecorrerVencimiento, DA, DAImpPrimerDoc, ControlAnticipos, Anticipado, Corte, 
		FechaProntoPago, TipoCondicion, InteresMoratorioBaseTabla, AutoFin, Neteo, Interesesdevengados, DATipoInteres, 
		FacturaCobroIntegradoParcial, PorSemanas) --, CFD_FormaDePago, CFD_MetodoDePago)
		VALUES (@Condicion, CONVERT(Int, SUBSTRING(@Condicion, 1, 2)), 'Naturales ', 'Lun-Vie', 'Habiles', 'Lun-Vie',
		0, 0, @Orden, 0, 0, 0, 'No', 0, 0,
		'Emision', 'Credito', 0, 0, 0, 0, 'Global',
		0, 0) --, 'Pago en una sola Exhibición', 'Depósito en cuenta.'
	END

	FETCH NEXT FROM Cur_Condicion Into @Condicion
END

CLOSE Cur_Condicion
DEALLOCATE Cur_Condicion


DECLARE Cur_Descuento CURSOR FOR
SELECT DISTINCT Descuento FROM Prov
WHERE Descuento IS NOT NULL

OPEN Cur_Descuento
FETCH NEXT FROM Cur_Descuento Into @Descuento

WHILE @@FETCH_STATUS <> -1
BEGIN
	SELECT @Cuenta = COUNT(*) FROM Descuento
	WHERE Descuento = @Descuento

	IF @Cuenta = 0
	BEGIN
		INSERT INTO Descuento(Descuento, Porcentaje, Descuento1)
		VALUES (convert(varchar,@Descuento) + '%', @Descuento, @Descuento)			-- cambio 090209
	END
	
	FETCH NEXT FROM Cur_Descuento Into @Descuento
END

CLOSE Cur_Descuento
DEALLOCATE Cur_Descuento


END
GO

/****** spAspelInsertaUnidades ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelInsertaUnidades]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelInsertaUnidades]
GO

CREATE PROCEDURE  [dbo].[spAspelInsertaUnidades]
--//WITH ENCRYPTION
AS BEGIN
	--DELETE FROM ArtUnidad
	
	INSERT INTO ArtUnidad (Articulo, Unidad, Factor, Peso, Volumen)
	SELECT DISTINCT Articulo, Valor, Factor, Peso, Volumen
	FROM AspelCargaProp where ARticulo not in (SELECT articulo from Artunidad)
	AND Campo = 'Unidad'
	
	INSERT INTO Unidad (Unidad, Factor, Decimales)
	SELECT DISTINCT Valor, Factor, 5
	FROM AspelCargaProp WHERE UPPER(Valor) not in (select UPPER(Unidad) from Unidad)
	AND Campo = 'Unidad'
	
	INSERT INTO UnidadConversion(Unidad, Conversion)
	SELECT DISTINCT Valor, Unidad
	FROM AspelCargaProp where Unidad not in (select Unidad from Unidadconversion)
	AND Campo = 'Unidad' AND Unidad <> ''
END
GO

/***********spAspelInsertaCatalogos***********/
IF EXISTS (SELECT * FROM SysObjects WHERE Id=OBJECT_ID('spAspelInsertaCatalogos') AND Type='P') 
DROP PROC spAspelInsertaCatalogos
GO

CREATE PROCEDURE  spAspelInsertaCatalogos
--//WITH ENCRYPTION
AS BEGIN
  IF (SELECT Insertar FROM AspelCfgCatalogo WHERE Catalogo = 'Moneda') = 1
    EXEC spAspelInsertaMonedas
  IF (SELECT Insertar FROM AspelCfgCatalogo WHERE Catalogo = 'Moneda') = 1
    EXEC spAspelInsertaUnidades
  IF (SELECT Insertar FROM AspelCfgCatalogo WHERE Catalogo = 'Almacen') = 1
    EXEC spAspelInsertaAlmacenes
  IF (SELECT Insertar FROM AspelCfgCatalogo WHERE Catalogo = 'Proveedor') = 1
    EXEC spAspelInsertaProveedores
  IF (SELECT Insertar FROM AspelCfgCatalogo WHERE Catalogo = 'Cliente') = 1
    EXEC spAspelInsertaClientes
  IF (SELECT Insertar FROM AspelCfgCatalogo WHERE Catalogo = 'Agente') = 1
    EXEC spAspelInsertaAgentes
  IF (SELECT Insertar FROM AspelCfgCatalogo WHERE Catalogo = 'Articulo') = 1
    EXEC spAspelInsertaArticulos
  IF (SELECT Insertar FROM AspelCfgCatalogo WHERE Catalogo = 'Cuenta') = 1
    EXEC spAspelInsertaCuentas
END
GO


/***********spAspelInsertaTodo***********/
IF EXISTS (SELECT * FROM SysObjects WHERE Id=OBJECT_ID('spAspelInsertaTodo') AND Type='P') 
DROP PROC spAspelInsertaTodo
GO

CREATE PROCEDURE  spAspelInsertaTodo
					(
					@Estacion		int
					)
--//WITH ENCRYPTION
AS BEGIN
DECLARE		
@Ok		int,
@OkRef		varchar(255)

  SET @Ok = NULL
  
  UPDATE Aspel_paso SET
  Ventas = 0, DescripcionVentas = '', RegistrosVentas = 0, TotalVentas = 0,
  Compras = 0, DescripcionCompras = '', RegistrosCompras = 0, TotalCompras = 0,
  CuentasPorCobrar = 0, DescripcionCxC = '', RegistrosCxC = 0, TotalCxC = 0,
  CuentasPorPagar = 0, DescripcionCxP = '', RegistrosCxP = 0, TotalCxP = 0,
  Inventarios = 0, DescripcionInventarios = '', RegistrosInventarios = 0,
  Polizas = 0, DescripcionPolizas = '', RegistrosPolizas = '',
  PolizaAjuste = 0, DescripcionPolAjuste = ''

  Exec spAspelActualizaProcesos 0
  
  --BEGIN TRANSACTION ASPEL
  EXEC spAspelInsertaCatalogos	
  EXEC spAspelInsertaMovimientos @Estacion --@Ok OUTPUT, @OkRef OUTPUT, 
/*  
  IF @Ok IS NOT NULL AND @Ok < 80000
    ROLLBACK TRANSACTION ASPEL
  ELSE
    COMMIT TRANSACTION ASPEL

  IF @Ok IS NOT NULL AND @Ok < 80000
--    SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + ', ' + Descripcion + ', ' + ISNULL(@OkRef,'') FROM MensajeLista WHERE Mensaje = @Ok
	SELECT 'Migración con Errores, Revise los Archivos LOG'
  ELSE
*/

	Exec spAspelActualizaProcesos 1

/*
	Exec spAspelkits
	Exec spAspelultimocosto
	Exec spAspelcontactos
*/

END
GO

SET ANSI_NULLS OFF
SET ANSI_WARNINGS OFF
GO

/****** spAspelcontactos ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelcontactos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelcontactos]
GO


CREATE PROCEDURE [dbo].[spAspelcontactos]
--//WITH ENCRYPTION
AS DECLARE 
@SrvOrigenSAE		varchar(50), 
@BDOrigenSAE		varchar(30), 
@OrigenSAE			varchar(100), 
@RutaSAE			varchar(250),
@EmpresaSAE			int,
@SrvIntelisis		varchar(50),
@BaseDatosIntelisis	varchar(30),
@sql				nvarchar(1000),
@Cuenta				int,
@Empresa			varchar(2),
@Tabla				varchar(15),
@contac				varchar(20),
@Juego				smallint,
@Descrip			varchar(20),
@Id					int,
@direccion			varchar(100),
@telefono			varchar(50),	
@email				varchar(100),
@tipocontac			varchar(20),
@nombre				varchar(50),
@telefonos			varchar(50),
@tipo				varchar(20),
@usuario			varchar(10)

BEGIN
	SET ANSI_NULLS ON
	SET ANSI_WARNINGS ON

	SELECT @SrvOrigenSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Servidor SAE'
	
	select @Cuenta = count(*) from master.dbo.sysservers where srvname = @SrvOrigenSAE
  
	if @Cuenta = 0
		exec sp_addlinkedserver @SrvOrigenSAE

	SELECT @BDOrigenSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Base De Datos SAE'
	SELECT @SrvOrigenSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Servidor SAE'
	SELECT @EmpresaSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Empresa SAE'

	SET @Empresa = RIGHT('00' + convert(varchar, @EmpresaSAE),2)
	SET @Tabla = 'CONTAC' + @Empresa

	exec master..sp_serveroption @SrvOrigenSAE, 'use remote collation', 'false'

	--
	DECLARE
	@IDCTECTODIR int

	SET @sql = 'DECLARE curcontac CURSOR FOR ' +
	'SELECT ltrim(rtrim(CCLIE)), NOMBRE, DIRECCION, TELEFONO,EMAIL,TIPOCONTAC ' +
	'FROM '+ @SrvOrigenSAE + '.' + @BDOrigenSAE + '.dbo.' + @Tabla 
	
	EXEC sp_executesql @Sql
	
	OPEN curcontac
	FETCH NEXT FROM curcontac INTO @contac,@nombre,@direccion,@telefono,@email,@tipocontac
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO ctecto (Cliente, Nombre,Telefonos,email,pedirtono,tipo,usuario,cfd_enviar, Atencion)
		VALUES (dbo.fnAspelJustificaClave(@contac), @Nombre,@Telefono,@email,0,@tipo, @Usuario,0,@contac) 

		SET @IDCTECTODIR = SCOPE_IDENTITY()

		INSERT INTO ctectodireccion (Cliente, ID, Tipo, Direccion)
		VALUES (dbo.fnAspelJustificaClave(@contac), @IDCTECTODIR, 'Trabajo', @direccion)
	
		FETCH NEXT FROM curcontac INTO @contac,@nombre,@direccion,@telefono,@email,@tipocontac
	END
	
	CLOSE curcontac
	DEALLOCATE curcontac
	SET ANSI_NULLS OFF
	SET ANSI_WARNINGS OFF
END
GO

/****** spAspelCifrasControl ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelCifrasControl]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelCifrasControl]
GO


CREATE PROCEDURE [dbo].[spAspelCifrasControl]
--//WITH ENCRYPTION
AS DECLARE
@Origen		decimal(17,5),
@Destino	decimal(17,5)

BEGIN
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspelCifrasControl]') AND type in (N'U'))
	DROP TABLE [dbo].[AspelCifrasControl]

	CREATE TABLE AspelCifrasControl
	(
	Descripcion	varchar(50),
	Origen		decimal(17,5),
	Destino		decimal(17,5)
	)
	
	SELECT @Origen = count(*) FROM AspelCargaProp
	WHERE Campo = 'Cliente'

	SELECT @Destino = count(*) FROM Cte

	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Clientes', @Origen, @Destino)
	
	SELECT @Origen = count(*) FROM AspelCargaProp
	WHERE Campo = 'Proveedor'
	
	SELECT @Destino = count(*) FROM Prov
	WHERE Observaciones like 'Aspel:%'

	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Proveedores', @Origen, @Destino)
	
	SELECT @Origen = count(*) FROM AspelCargaProp
	WHERE Campo = 'Articulo'
	
	SELECT @Destino = count(*) FROM Art

	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Articulos', @Origen, @Destino)
	
	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Proveedores', @Origen, @Destino)
	
	SELECT @Origen = count(*) FROM AspelCargaProp
	WHERE Campo = 'Almacen'
	
	SELECT @Destino = count(*) FROM Alm

	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Almacenes', @Origen, @Destino)
	
	SELECT @Origen = count(*) FROM AspelCargaProp
	WHERE Campo = 'Agente'
	
	SELECT @Destino = count(*) FROM Agente

	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Agentes', @Origen, @Destino)
	
	SELECT @Origen = count(*) FROM AspelCargaProp
	WHERE Campo = 'Moneda'
	
	SELECT @Destino = count(*) FROM Mon

	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Monedas', @Origen, @Destino)
	
	SELECT @Origen = count(*) FROM AspelCargaProp
	WHERE Campo = 'Unidad'
	
	SELECT @Destino = count(*) FROM ArtUnidad

	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Unidades', @Origen, @Destino)
	
	SELECT @Origen = count(*) FROM CTA
	
	SELECT @Destino = count(*) FROM CTA

	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Cuentas', @Origen, @Destino)
	
	SELECT @Origen = convert(decimal(15,2),SUM((Precio * Cantidad) - (Precio * Cantidad * Descuento1 / 100)))
	FROM AspelCargaReg
	WHERE Modulo = 'VTAS' AND Mov = 'Facasp'
	
	SELECT @Destino = convert(decimal(15,2), sum(Importe))
	FROM Venta
	WHERE Mov = 'Facasp'
	
	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Facturas', @Origen, @Destino)
	
	SELECT @Origen = convert(decimal(15,2),SUM((Precio * Cantidad) - (Precio * Cantidad * Descuento1 / 100)))
	FROM AspelCargaReg
	WHERE Modulo = 'VTAS' AND Mov = 'Devasp'
	
	SELECT @Destino = convert(decimal(15,2), sum(Importe))
	FROM Venta
	WHERE Mov = 'Devasp'
	
	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Dev. Facturas', @Origen, @Destino)
	
	SELECT @Origen = convert(decimal(15,2),SUM(debe))
	FROM AspelCargaReg
	WHERE Modulo = 'COMS' AND Mov = 'Compasp'
	
	SELECT @Destino = convert(decimal(15,2), sum(Importe))
	FROM Compra
	WHERE Mov = 'Compasp'
	
	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Compras', @Origen, @Destino)
	
	SELECT @Origen = convert(decimal(15,2),SUM(Haber))
	FROM AspelCargaReg
	WHERE Modulo = 'COMS' AND Mov = 'Devasp'
	
	SELECT @Destino = convert(decimal(15,2), sum(Importe))
	FROM Compra
	WHERE Mov = 'Devasp'
	
	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Dev. Compras', @Origen, @Destino)
	
	SELECT @Origen = convert(decimal(15,2),SUM(Debe + Haber))
	FROM AspelCargaReg
	WHERE Modulo = 'CxC'
	
	SELECT @Destino = convert(decimal(15,2), sum(Importe))
	FROM CxC
	
	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('CxC', @Origen, @Destino)
	
	SELECT @Origen = convert(decimal(15,2),SUM(Debe + Haber))
	FROM AspelCargaReg
	WHERE Modulo = 'CxP'
	
	SELECT @Destino = convert(decimal(15,2), sum(Importe))
	FROM CxP
	
	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('CxP', @Origen, @Destino)
	
	SELECT @Origen = convert(decimal(15,2),SUM(Debe))
	FROM AspelCargaReg
	WHERE Modulo = 'INV'
	
	SELECT @Destino = convert(decimal(15,2), sum(Importe))
	FROM Inv
	
	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Movimientos Inventario', @Origen, @Destino)
	
	SELECT @Origen = convert(decimal(15,2),SUM(Debe + haber))
	FROM AspelCargaReg
	WHERE Modulo = 'CONT'
	
	SELECT @Destino = convert(decimal(15,2), isnull(sum(Importe),0))
	FROM Cont
	WHERE Estatus = 'CONCLUIDO'
	
	INSERT INTO AspelCifrasControl(Descripcion, Origen, Destino)
	VALUES ('Polizas', @Origen, @Destino)
	
	SELECT * FROM AspelCifrasControl
END
GO

/****** spAspelCambiaproveedores ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelCambiaproveedores]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelCambiaproveedores]
GO
CREATE PROCEDURE  [dbo].[spAspelCambiaproveedores]
--//WITH ENCRYPTION
AS BEGIN
UPDATE AspelCargaprop SET
Valor =  C.Nueva
FROM AspelCargaprop A, AspelCambiaclaves C
WHERE ltrim(rtrim(A.Tipo)) = ltrim(rtrim(C.Anterior)) And A.CAMPO = 'Proveedor' 

UPDATE AspelCargareg SET
Proveedor =  C.Nueva
FROM AspelCargaReg A, AspelCambiaclaves C
WHERE ltrim(rtrim(A.Proveedor)) = dbo.fnAspelJustificaClave(ltrim(rtrim(C.Anterior))) And A.Modulo in ('COMS','CXP')

END
GO

/****** spAspelCambiacuentas ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelCambiacuentas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelCambiacuentas]
GO
CREATE PROCEDURE  [dbo].[spAspelCambiacuentas]
--//WITH ENCRYPTION
AS BEGIN

UPDATE AspelCargaprop SET
Valor =  LEFT(REPLACE(LTRIM(RTRIM(c.nueva)),'-','')+'00000000000000000000',20) + c.nivel
FROM AspelCargaprop A, AspelCambiaclaves C
WHERE LEFT(ltrim(rtrim(a.valor)),20) = LEFT(REPLACE(LTRIM(RTRIM(c.anterior)),'-','')+'00000000000000000000',20) And A.campo = 'cuenta'


UPDATE AspelCargaprop SET
Rama =  LEFT(REPLACE(LTRIM(RTRIM(c.nueva)),'-','')+'00000000000000000000',20) + c.nivel
FROM AspelCargaprop A, AspelCambiaclaves C
WHERE LEFT(ltrim(rtrim(a.rama)),20) = LEFT(REPLACE(LTRIM(RTRIM(c.anterior)),'-','')+'00000000000000000000',20) And A.campo = 'cuenta'


UPDATE AspelCargareg SET
Mayor =  LEFT(REPLACE(LTRIM(RTRIM(c.nueva)),'-',''),20)
FROM AspelCargareg A, AspelCambiaclaves C
WHERE LEFT(ltrim(rtrim(a.Mayor)),20) = LEFT(REPLACE(LTRIM(RTRIM(c.anterior)),'-','')+'00000000000000000000',20) And A.MODULO = 'CONT'

END
GO

/****** spAspelCambiaclientes ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelCambiaclientes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelCambiaclientes]
GO
CREATE PROCEDURE  [dbo].[spAspelCambiaclientes]
--//WITH ENCRYPTION
AS BEGIN

UPDATE AspelCargaprop SET
Valor =  C.Nueva
FROM AspelCargaprop A, AspelCambiaclaves C
WHERE ltrim(rtrim(A.Tipo)) = ltrim(rtrim(C.Anterior)) And A.CAMPO = 'Cliente' 

UPDATE AspelCargareg SET
Cliente =  C.Nueva
FROM AspelCargaReg A, AspelCambiaclaves C
WHERE ltrim(rtrim(A.Proveedor)) = ltrim(rtrim(C.Anterior)) And A.Modulo in ('VTAS','CXC')

END
GO

/****** spAspelCambiacentrocostos ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelCambiacentrocostos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelCambiacentrocostos]
GO
CREATE PROCEDURE  [dbo].[spAspelCambiacentrocostos]
--//WITH ENCRYPTION
AS BEGIN

UPDATE AspelCargareg SET
Subcuenta =  C.Nueva
FROM AspelCargaReg A, AspelCambiaclaves C
WHERE ltrim(rtrim(A.Subcuenta)) = C.Anterior And A.Modulo in ('CONT')

END
GO

/****** spAspelCambiaarticulos ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelCambiaarticulos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelCambiaarticulos]
GO

CREATE PROCEDURE  [dbo].[spAspelCambiaarticulos]
--//WITH ENCRYPTION
AS BEGIN

UPDATE AspelCargaprop SET
Valor =  C.Nueva
FROM AspelCargaprop A, AspelCambiaclaves C
WHERE ltrim(rtrim(A.Valor)) = ltrim(rtrim(C.Anterior)) And A.CAMPO = 'Articulo' 

UPDATE AspelCargareg SET
Articulo =  C.Nueva
FROM AspelCargaReg A, AspelCambiaclaves C
WHERE ltrim(rtrim(A.Articulo)) = ltrim(rtrim(C.Anterior)) And A.Modulo in ('VTAS','COMS','INV')

END
GO

/****** spAspelCambiaalmacen ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelCambiaalmacen]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelCambiaalmacen]
GO
CREATE PROCEDURE  [dbo].[spAspelCambiaalmacen]
--//WITH ENCRYPTION
AS BEGIN

UPDATE AspelCargaprop SET
Valor =  C.Nueva
FROM AspelCargaprop A, AspelCambiaclaves C
WHERE ltrim(rtrim(A.Valor)) = ltrim(rtrim(C.Anterior)) And A.CAMPO = 'Almacen' 


UPDATE AspelCargareg SET
Almacen =  C.Nueva
FROM AspelCargaReg A, AspelCambiaclaves C
WHERE ltrim(rtrim(A.almacen)) = ltrim(rtrim(C.Anterior)) And A.modulo IN ('VTAS','COMS','INV')

END
GO

/****** spAspelCambiaagentes ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelCambiaagentes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelCambiaagentes]
GO
CREATE PROCEDURE  [dbo].[spAspelCambiaagentes]
--//WITH ENCRYPTION
AS BEGIN

UPDATE AspelCargaprop SET
Valor =  C.Nueva
FROM AspelCargaprop A, AspelCambiaclaves C
WHERE ltrim(rtrim(A.Valor)) = dbo.fnAspelJustificaClave(ltrim(rtrim(C.Anterior))) And A.CAMPO = 'Agente' 

UPDATE AspelCargareg SET
agente =  C.Nueva
FROM AspelCargaReg A, AspelCambiaclaves C
WHERE ltrim(rtrim(A.agente)) = dbo.fnAspelJustificaClave(ltrim(rtrim(C.Anterior))) And A.MODULO = 'VTAS' 

END

GO

/****** spAspelActualizaProcesos ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelActualizaProcesos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelActualizaProcesos]
GO
CREATE PROCEDURE [dbo].[spAspelActualizaProcesos]
(
	@Valor	int
)	
--//WITH ENCRYPTION
AS BEGIN
	UPDATE ASPELPROCESOS SET ESTATUS = @Valor
END
GO

/****** AspelFlujo ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspelFlujo]') AND type in (N'U'))
DROP TABLE [dbo].[AspelFlujo]
GO


CREATE TABLE [dbo].[AspelFlujo](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Proceso] [varchar](50) COLLATE Database_Default NOT NULL,
	[Estatus] [smallint] NULL,
 CONSTRAINT [PK_AspelFlujo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO


insert into AspelFlujo([Proceso],[Estatus]) values ('Configuración Inicial',0);
insert into AspelFlujo([Proceso],[Estatus]) values ('Diagnostico Previo',0);
insert into AspelFlujo([Proceso],[Estatus]) values ('Tablas Temporales',0);
insert into AspelFlujo([Proceso],[Estatus]) values ('Configuración Final',0);

/****** spAspelDiagnosticoCOI ******/
IF EXISTS(SELECT * FROM sysobjects WHERE Id=OBJECT_ID('errorcoi') AND Type='U') 
			DROP TABLE errorcoi
GO
IF EXISTS(SELECT * FROM sysobjects WHERE Id=OBJECT_ID('listaerrorcoi') AND Type='U') 
			DROP TABLE listaerrorcoi
GO

Create TABLE errorcoi
		( 
		Consecutivo int identity,
		Valor INT,
		Descr varchar(100)	

		 constraint PkErrorcoi Primary key (Consecutivo)
		)
GO

-- Este diagnóstico debe ejecutarse depues de llenar el visor
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelDiagnosticoCOI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelDiagnosticoCOI]
GO

CREATE PROCEDURE [dbo].[spAspelDiagnosticoCOI]
--//WITH ENCRYPTION
AS
DECLARE
@Cuenta		varchar(30),
@SaldoC		money,
@SaldoD		money,
@Temporal	money,
@Periodo	varchar(10),
@flag		bit,
@Registros	int,
@Digitos	int,
@Formato	varchar(24),
@Errorcoi6				varchar(100)

--set @Errorcoi6 = 'Existen cuentas cuyo saldo inicial departamental no es igual al saldo inicial de la cuenta'

BEGIN

	Create TABLE listaerrorcoi
		( 
		Consecutivo int identity,
		Error INT,
		Registro varchar(100)		
	
		constraint PkListaerrorcoi Primary key  (Consecutivo)

		)
	
	CREATE TABLE #Diferencias
	(
	Cuenta	varchar(30),
	Periodo	varchar(10),
	SaldoC	decimal(20,7),
	SaldoD	decimal(20,7)
	)
	
	SELECT @Formato = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Formato Cuentas Contables'
	SET @Digitos = LEN(REPLACE(REPLACE(RTRIM(LTRIM(@Formato)),'-',''),';2',''))  
  	SET @Digitos = CASE WHEN @Digitos = 0 THEN 20 ELSE @Digitos END
  	
	DECLARE cur_Cuentas CURSOR FOR
	SELECT dbo.fnAspelFormateaCuentas(LEFT(PASO_CTAS.Cuenta,@Digitos),@Formato), PASO_CTAS.periodo, PASO_CTAS.SaldoIni AS Cabecero, 
	SUM(PASO_CTASD.SaldoIni) AS Detalle
	FROM PASO_CTAS INNER JOIN
	PASO_CTASD ON PASO_CTAS.Cuenta = PASO_CTASD.Cuenta 
	WHERE PASO_CTAS.DEPTSINO = 'S'
	GROUP BY PASO_CTAS.Cuenta, PASO_CTAS.periodo, PASO_CTAS.SaldoIni

		
	OPEN cur_Cuentas
	FETCH NEXT FROM cur_Cuentas INTO @Cuenta, @Periodo, @SaldoC, @SaldoD
	
	WHILE @@FETCH_STATUS <> -1
	BEGIN
--Aunque vienen de origen con 7 decimales, se redondea ya que se guardan en tipo MONEY en la tabla de CONTD
		
		IF @SaldoC <> @SaldoD
			INSERT INTO #Diferencias(Cuenta, Periodo, SaldoC, SaldoD)
			VALUES(@Cuenta, @Periodo, @SaldoC, @SaldoD)
			FETCH NEXT FROM cur_Cuentas INTO @Cuenta, @Periodo, @SaldoC, @SaldoD
		END
	
	

	CLOSE cur_Cuentas
	DEALLOCATE cur_Cuentas
	
	SELECT @Registros = COUNT(*) FROM #Diferencias

	
		 INSERT INTO listaerrorcoi		
		 SELECT 6, cuenta+ '|' + Periodo + '|' +Convert(varchar(25),SaldoC) + '|' +Convert(Varchar(25),SaldoD)
		 FROM #Diferencias	
		 
--			IF @@ROWCOUNT > 0
--					Insert errorcoi(Valor,Descr) values (6, @Errorcoi6 )

			UPDATE AspelFlujo
			SET	Estatus = 1
			WHERE Proceso = 'Diagnostico Previo'

			end
	
GO

/****** spAspelActualizaFlujo ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelActualizaFlujo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelActualizaFlujo]
GO
CREATE PROCEDURE [dbo].[spAspelActualizaFlujo]
@Estatus	smallint,
@Flujo		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
	UPDATE AspelFlujo
	SET	Estatus = @Estatus
	WHERE Proceso = @Flujo
	
END
GO

-- REQ13868
/*********** spAbreArchivo ***********/
IF EXISTS(SELECT * FROM SysObjects WHERE Id=OBJECT_ID('dbo.spAbreArchivo') AND Type='P') 
DROP PROC dbo.spAbreArchivo
GO
CREATE PROCEDURE spAbreArchivo
	(    
	@Archivo			varchar(255),    
	@ManejadorObjeto	int				OUTPUT,    
	@IDArchivo			int				OUTPUT,
 	@Ok					int				= NULL OUTPUT,
	@OkRef				varchar(255)	= NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS BEGIN
	DECLARE	@ResultadoOLE                int
	
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Archivo

  --Abre un archivo de texto
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'OpenTextFile', @IDArchivo OUT, @Archivo, 8
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Archivo
END
GO

/****** fnAspelJustificadocto ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnAspelJustificadocto]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnAspelJustificadocto]
GO
CREATE FUNCTION [dbo].[fnAspelJustificadocto] (@Docto VARCHAR(20)) 
RETURNS VARCHAR(8) AS 
BEGIN
DECLARE
@Nuevodocto	varchar(8)
 
	IF ISNUMERIC(@Docto) = 1 AND LEFT(@Docto,1) <> '0'
	BEGIN
		SET @Nuevodocto = RIGHT('0000000' + @Docto, 7)
	END 
	ELSE
			IF ISNUMERIC(@Docto) = 1 AND len(@Docto) = 7 AND LEFT(@Docto,1) = '0' -- En SAE puede existir el DOCTO 1 y el 00001
			
				SET @Nuevodocto= '0' +  @Docto

		ELSE

		SET @Nuevodocto =  @Docto

	RETURN(@Nuevodocto)
END
GO

/****** fnAspelJustificaClave ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnAspelJustificaClave]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnAspelJustificaClave]
GO
CREATE FUNCTION [dbo].[fnAspelJustificaClave] (@Clave VARCHAR(20)) 
RETURNS VARCHAR(6) AS 
BEGIN
DECLARE
@Nueva	varchar(6)
 -- Por ejemplo eN sae, los clientes 1, 01 y 001 son diferentes
	IF ISNUMERIC(@Clave) = 1 AND LEFT(@CLAVE,1) <> '0'
	BEGIN
		SET @Nueva = RIGHT('00000' + @Clave, 5)
	END 
	ELSE
		IF ISNUMERIC(@Clave) = 1 AND len(@CLAVE) = 5 AND LEFT(@CLAVE,1) = '0' -- En SAE puede existir el cliente 1 y el 00001			
			SET @Nueva = '0' + @Clave	-- Se le agrega otro cero si ya está justificado con ceros
		ELSE
			SET @Nueva = @Clave
	RETURN(@Nueva)
END
GO

/****** fnAspelDecimales ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnAspelDecimales]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnAspelDecimales]
GO



CREATE function [dbo].[fnAspelDecimales](@Numero varchar(20))
RETURNS Int
AS
BEGIN
DECLARE	
@Posi		int,
@Cadena		varchar(200),
@Decimales	int

	SET @Cadena = @Numero
	SET @Posi = CHARINDEX('.', @Cadena)

	IF @Posi = 0 
		SET @Decimales = 0
	ELSE
	BEGIN
		SET @Decimales = LEN( @Cadena) - @Posi
	END

	RETURN @Decimales
END
GO

/****** fn_AspelDescuentoEnCascada ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_AspelDescuentoEnCascada]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_AspelDescuentoEnCascada]
GO
CREATE function [dbo].[fn_AspelDescuentoEnCascada](
@Desc1	float(15),
@Desc2	float(15),
@Desc3	float(15)
)
RETURNS FLOAT(15)
AS

BEGIN
DECLARE
@Descuento	float(15),
@Resul1		float(15),
@Resul2		float(15),
@Resul3		float(15)

	SET @Resul1 = 100 - (100 * @Desc1/100.0)
	SET @Resul2 = @Resul1 - (@Resul1 * @Desc2/100.0)
	SET @Resul3 = @Resul2 - (@Resul2 * @Desc3/100.0)
	SET @Descuento = 100 - @Resul3
	
	RETURN (@Descuento)
END
GO

/****** spAspelKits ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelKits]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelKits]
GO


CREATE PROCEDURE [dbo].[spAspelKits]
--//WITH ENCRYPTION
AS
DECLARE 
@SrvOrigenSAE		varchar(50), 
@BDOrigenSAE		varchar(30), 
@OrigenSAE			varchar(100), 
@RutaSAE			varchar(250),
@EmpresaSAE			int,
@SrvIntelisis		varchar(50),
@BaseDatosIntelisis	varchar(30),
@sql				nvarchar(1000),
@Cuenta				int,
@Empresa			varchar(2),
@Tabla				varchar(15),
@Kit				varchar(20),
@Art				varchar(20),
@Juego				smallint,
@Descrip			varchar(20),
@Cant				float

BEGIN
	SET ANSI_NULLS ON
	SET ANSI_WARNINGS ON

	SELECT @SrvOrigenSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Servidor SAE'
	
	select @Cuenta = count(*) from master.dbo.sysservers where srvname = @SrvOrigenSAE
  
	if @Cuenta = 0
		exec sp_addlinkedserver @SrvOrigenSAE
		
	SELECT @BDOrigenSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Base De Datos SAE'
	SELECT @SrvOrigenSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Servidor SAE'
	SELECT @EmpresaSAE = Valor FROM AspelCfgOpcion WHERE Descripcion = 'Empresa SAE'

	SET @Empresa = RIGHT('00' + convert(varchar, @EmpresaSAE),2)
	SET @Tabla = 'KITS' + @Empresa

	exec master..sp_serveroption @SrvOrigenSAE, 'use remote collation', 'false'

	SET @sql = 'DECLARE curKit CURSOR FOR ' +
	'SELECT DISTINCT CVE_KIT ' +
	'FROM '+ @SrvOrigenSAE + '.' + @BDOrigenSAE + '.dbo.' + @Tabla 
	
	EXEC sp_executesql @Sql
	
	OPEN curKit
	FETCH NEXT FROM curKit INTO @Kit
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Juego = 64
		SET @Cuenta = 0
	
		SET @sql = 'DECLARE curArtD CURSOR FOR ' +
		'SELECT CVE_ART, CANTIDAD ' +
		'FROM '+ @SrvOrigenSAE + '.' + @BDOrigenSAE + '.dbo.' + @Tabla + ' ' +
		'WHERE CVE_KIT = ' + CHAR(39) + @Kit + CHAR(39) 
		
		EXEC sp_executesql @Sql
		
		OPEN curArtD
		FETCH NEXT FROM curArtD INTO @Art, @Cant
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @Juego = @Juego + 1
			SET @Cuenta = @Cuenta + 1
			SET @Descrip = 'Componente ' + CONVERT(varchar, @Cuenta)
			
			INSERT INTO ArtJuego (Articulo, Juego, Descripcion, Cantidad)
			VALUES (@Kit, char(@Juego), @Descrip, @Cant)
			
			INSERT INTO ArtJuegoD (Articulo, Juego, Renglon,Opcion, SubCuenta)
			VALUES (@Kit, char(@Juego), 2048, @Art, NULL)
			
			FETCH NEXT FROM curArtD INTO @Art, @cant
		END
		
		CLOSE curArtD
		DEALLOCATE curArtD
	
		FETCH NEXT FROM curKit INTO @Kit
	END
	
	CLOSE curKit
	DEALLOCATE curKit
	SET ANSI_NULLS OFF
	SET ANSI_WARNINGS OFF
END
GO

/****** spAspelRevisaTablas ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelRevisaTablas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelRevisaTablas]
GO

CREATE PROCEDURE  [dbo].[spAspelRevisaTablas]
--//WITH ENCRYPTION
AS BEGIN

DECLARE 
@Cuenta		varchar(50)

	/****** AspelWarnings ******/
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspelWarnings]') AND type in (N'U'))
	DROP TABLE [dbo].[AspelWarnings]

	CREATE TABLE [dbo].[AspelWarnings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) COLLATE Database_Default NULL,
	CONSTRAINT [PK_AspelWarnings] PRIMARY KEY CLUSTERED 
	(
	[Id] ASC
	)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]

	SELECT @Cuenta = COUNT(*) FROM AgenteCat	
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Categorías de Agentes')
		
	SELECT @Cuenta = COUNT(*) FROM Agente
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Agentes')	
	
	SELECT @Cuenta = COUNT(*) FROM AlmGrupo
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Grupos de Almacenes')	
	
	SELECT @Cuenta = COUNT(*) FROM Alm
	IF @Cuenta > 1
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta-1) + ' Registros en el Catálogo de Almacenes')	
	
	SELECT @Cuenta = COUNT(*) FROM ArtCat
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Categorías de Artículos')	
	
	SELECT @Cuenta = COUNT(*) FROM ArtLinea
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Categorías de Líneas de Artículos')	
	
	SELECT @Cuenta = COUNT(*) FROM Art
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Artículos')	
	
	SELECT @Cuenta = COUNT(*) FROM CteCat
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Categorías de Clientes')	
	
	SELECT @Cuenta = COUNT(*) FROM CteGrupo
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Grupos de Clientes')
	
	SELECT @Cuenta = COUNT(*) FROM Cte
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Clientes')
	
	SELECT @Cuenta = COUNT(*) FROM Condicion
	IF @Cuenta > 1
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta-1) + ' Registros en el Catálogo de Condiciones')

	SELECT @Cuenta = COUNT(*) FROM Descuento
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Descuentos')
	
	SELECT @Cuenta = COUNT(*) FROM CteFam
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Familias de Clientes')
	
	SELECT @Cuenta = COUNT(*) FROM COMPRA
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en Compras')
	
	SELECT @Cuenta = COUNT(*) FROM COMPRAD
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen ' + CONVERT(varchar, @Cuenta) + ' Registros en Detalle de Compras')
	
	SELECT @Cuenta = COUNT(*) FROM CTA
	IF @Cuenta > 17
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta-17) + ' Registros en el Catálogo de Cuentas')
	
	SELECT @Cuenta = COUNT(*) FROM CXC
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen ' + CONVERT(varchar, @Cuenta) + ' Registros en Cuentas por Cobrar')
	
	SELECT @Cuenta = COUNT(*) FROM CXP
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en Cuentas por Pagar')
	
	SELECT @Cuenta = COUNT(*) FROM SerieLote
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en Series Lote')
	
	SELECT @Cuenta = COUNT(*) FROM INV
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en Movimientos de Inventarios')
	
	SELECT @Cuenta = COUNT(*) FROM SerieLoteMov
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en Movimientos de Serie Lote')
	
	SELECT @Cuenta = COUNT(*) FROM INVD
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen ' + CONVERT(varchar, @Cuenta) + ' Registros en Detalle de Movimientos de Inventarios')
	
	SELECT @Cuenta = COUNT(*) FROM Mon
	IF @Cuenta > 1
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen ' + CONVERT(varchar, @Cuenta-1) + ' Registros en Catálogos de Monedas')
	
	SELECT @Cuenta = COUNT(*) FROM CONT
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en Pólizas')
	
	SELECT @Cuenta = COUNT(*) FROM CONTD
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en Detalles de Pólizas')
	
	SELECT @Cuenta = COUNT(*) FROM ProvCat
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Categorías de Proveedores')
	
	SELECT @Cuenta = COUNT(*) FROM ProvFam
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Familias de Proveedores')
	
	SELECT @Cuenta = COUNT(*) FROM Prov
	IF @Cuenta > 6
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta-6) + ' Registros en el Catálogo de Proveedores')
	
	SELECT @Cuenta = COUNT(*) FROM ArtUnidad
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en el Catálogo de Unidades de Artículos')
	
	SELECT @Cuenta = COUNT(*) FROM VENTA
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en Ventas')
	
	SELECT @Cuenta = COUNT(*) FROM VENTAD
	IF @Cuenta > 0
		INSERT INTO AspelWarnings (Descripcion) Values ('Existen  ' + CONVERT(varchar, @Cuenta) + ' Registros en Detalles de Ventas')
	
	SELECT * FROM aspelwarnings
END
GO

/****** spAspelUltimocosto ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAspelUltimocosto]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAspelUltimocosto]
GO

CREATE PROCEDURE [dbo].[spAspelUltimocosto]
--//WITH ENCRYPTION
AS

Update artcosto
set Ultimocosto = ASPELCARGAPROP.costo
from ASPELCARGAPROP WHERE CAMPO = 'Articulo' and artcosto.articulo = aspelcargaprop.valor

GO

/***********spHabilitarProcedimientosOle***********/
IF EXISTS(SELECT * FROM SysObjects WHERE Id=OBJECT_ID('dbo.spHabilitarProcedimientosOle') AND Type='P') 
DROP PROC dbo.spHabilitarProcedimientosOle
GO
CREATE PROCEDURE spHabilitarProcedimientosOle
--//WITH ENCRYPTION
AS BEGIN
  EXEC sp_configure 'show advanced option', '1'
	
  EXEC sp_configure 'Ole Automation Procedures', '1'

	RECONFIGURE
END
GO