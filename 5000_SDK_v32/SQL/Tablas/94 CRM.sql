SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/****************** xcrm_del_ventad *************************/
IF NOT EXISTS (select * from SysTabla where SysTabla = 'xcrm_del_ventad') 
	INSERT INTO SysTabla (SysTabla) VALUES ('xcrm_del_ventad')
GO
IF NOT EXISTS (select * from sysobjects where id = object_id('dbo.xcrm_del_ventad') and type = 'U')
BEGIN
	CREATE TABLE dbo.xcrm_del_ventad(
		ID int NOT NULL,
		Renglon float NOT NULL,
		RenglonSub int NOT NULL,
		RenglonID int NULL,
		RenglonTipo char(1) NULL,
		Cantidad float NULL,
		Almacen varchar(10) NULL,
		EnviarA int NULL,
		Codigo varchar(30) NULL,
		Articulo varchar(20) NOT NULL,
		Ultimocambio datetime NOT NULL,
		crmobjectid uniqueidentifier NULL
	) ON [PRIMARY]

	ALTER TABLE dbo.xcrm_del_ventad ADD CONSTRAINT DF_xcrm_del_ventad_Ultimocambio DEFAULT (getdate()) FOR Ultimocambio
	
END
GO

/****************** xcrm_del_venta *************************/
IF NOT EXISTS (select * from SysTabla where SysTabla = 'xcrm_del_venta') 
	INSERT INTO SysTabla (SysTabla) VALUES ('xcrm_del_venta')
GO
IF NOT EXISTS (select * from sysobjects where id = object_id('dbo.xcrm_del_venta') and type = 'U') 
BEGIN
	CREATE TABLE dbo.xcrm_del_venta(
		ID int NOT NULL,
		Empresa varchar(5) NOT NULL,
		Mov varchar(20) NOT NULL,
		FolioCRM varchar(50) NOT NULL,
		Ultimocambio datetime NOT NULL,
		crmobjectid uniqueidentifier NULL
	
	) ON [PRIMARY]

	ALTER TABLE dbo.xcrm_del_venta ADD CONSTRAINT DF_xcrm_del_venta_Ultimocambio DEFAULT (getdate()) FOR Ultimocambio
	
END
GO

/****************** xcrm_pedidoType *************************/
IF NOT EXISTS(SELECT * FROM sys.types  WHERE is_table_type = 1 AND name ='xcrm_pedidoType')
	CREATE TYPE xcrm_pedidoType AS TABLE (
		cliente varchar(10),
		observaciones varchar(100),
		ultimocambio varchar(100),
		referencia varchar(50),
		estatus varchar(15),
		crmobjectid varchar(50),
		movimiento varchar(20),
		empresa varchar(5),
		almacen varchar(10),	
		listaprecios varchar(100),
		usuario varchar(10),
		agente varchar(10),
		moneda varchar(10),
		concepto varchar(50)
	)
GO

/****************** xcrm_VentaDType *************************/
IF NOT EXISTS(SELECT * FROM sys.types  WHERE is_table_type = 1 AND name ='xcrm_VentaDType')
	CREATE TYPE xcrm_VentaDType AS TABLE (
		crmobjectid varchar(MAX),
		producto varchar(MAX),
		productosku varchar(MAX),
		precio varchar(MAX),
		descuento varchar(MAX),
		cantidad varchar(MAX)
	)
GO
	
/****************** xcrm_tablapruebaType *************************/
IF NOT EXISTS(SELECT * FROM sys.types  WHERE is_table_type = 1 AND name ='xcrm_tablapruebaType')
	CREATE TYPE xcrm_tablapruebaType AS TABLE (
		crmobjectid_producto varchar(MAX)
	)
GO

/****************** xcrm_proyectos_adminType *************************/
IF NOT EXISTS(SELECT * FROM sys.types  WHERE is_table_type = 1 AND name ='xcrm_proyectos_adminType')
	CREATE TYPE xcrm_proyectos_adminType AS TABLE (
		cliente varchar(MAX),
		observaciones varchar(MAX),
		ultimocambio varchar(MAX),
		referencia varchar(MAX),
		estatus varchar(MAX),
		crmobjectid varchar(MAX),
		movimiento varchar(MAX),
		empresa varchar(MAX),
		almacen varchar(MAX),	
		usuario varchar(MAX),
		agente varchar(MAX),
		concepto varchar(MAX)
	)
GO

/****************** xcrm_VentaD_proyectosType *************************/
IF NOT EXISTS(SELECT * FROM sys.types  WHERE is_table_type = 1 AND name ='xcrm_VentaD_proyectosType')
	CREATE TYPE xcrm_VentaD_proyectosType AS TABLE (
		crmobjectid varchar(MAX),
		producto varchar(MAX),
		productosku varchar(MAX),
		precio varchar(MAX),
		cantidad varchar(MAX)
	)
GO

