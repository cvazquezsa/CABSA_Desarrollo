--- 07-Ene-2004 Ver. 1.0.1 SB.EXE 1.2.0 Para el llenado de tablas necedsarias para ejecuatr ScoreBoard
--- Para la definicion de filtros por cada proceso sbFiltro
-- TRUNCATE TABLE SBFILTRO 
EXEC spSBInsertarFiltro 'Ventas','Sucursal','Sucursal','Sucursal','Nombre','INT',1, 0,NULL,'Sucursal',1
EXEC spSBInsertarFiltro 'Ventas','Proyecto','Proy','Proyecto','Descripcion','CHAR',1, 0,NULL,'Proyecto',3
EXEC spSBInsertarFiltro 'Ventas','UEN','UEN','UEN','Nombre','INT', 1, 0,NULL,'UEN',4
EXEC spSBInsertarFiltro 'Ventas','Usuario','GrupoTrabajo','GrupoTrabajo',NULL,'CHAR', 1, 1,NULL, 'Usuario',5
EXEC spSBInsertarFiltro 'Ventas','Usuario','Usuario','Usuario',NULL,'CHAR',1, 0,NULL,'Usuario',6
EXEC spSBInsertarFiltro 'Ventas','Moneda',     'Mon',   'Moneda',NULL,'CHAR',1,  0, NULL, 'Moneda',7
EXEC spSBInsertarFiltro 'Ventas','Movimiento','MovClave','Grupo',NULL,'CHAR',1,1,'Factura', 'Mov',8,"Modulo='VTAS'"
EXEC spSBInsertarFiltro 'Ventas','Movimiento','Movtipo','Mov',NULL,'CHAR',1,0,'Factura', 'Mov',9,"Modulo='VTAS'"
EXEC spSBInsertarFiltro 'Ventas','Concepto','Concepto','Concepto',NULL,'CHAR',1,0,NULL, 'Concepto',10,"Modulo='VTAS'"
EXEC spSBInsertarFiltro 'Ventas','Almacen','Alm','Almacen','Nombre','CHAR',1,0,NULL, 'Almacen',11
EXEC spSBInsertarFiltro 'Ventas','Fabricante','Art','Fabricante',NULL,'CHAR',1,0,NULL, 'Fabricante',12
EXEC spSBInsertarFiltro 'Ventas','Grupo','Art','Grupo',NULL,'CHAR',1,0,NULL, 'Grupo',13
EXEC spSBInsertarFiltro 'Ventas','Categoria','Art','Categoria',NULL,'CHAR',1,0,NULL, 'Categoria',14
EXEC spSBInsertarFiltro 'Ventas','Linea','Art','Linea',NULL,'CHAR',1,0,NULL, 'Linea',15
EXEC spSBInsertarFiltro 'Ventas','Familia','Art','Familia',NULL,'CHAR',1,0,NULL, 'Familia',16
EXEC spSBInsertarFiltro 'Ventas','Agente','Agente','Agente',NULL,'CHAR',1,0,NULL, 'Agente',17
GO
EXEC spSBInsertarFiltro 'Gastos','Sucursal','Sucursal','Sucursal','Nombre','INT',1, 0,NULL,'Sucursal',1
EXEC spSBInsertarFiltro 'Gastos','Proyecto','Proy','Proyecto','Descripcion','CHAR',1, 0,NULL,'Proyecto',3
EXEC spSBInsertarFiltro 'Gastos','UEN','UEN','UEN','Nombre','INT', 1, 0,NULL,'UEN',4
EXEC spSBInsertarFiltro 'Gastos','Usuario','GrupoTrabajo','GrupoTrabajo',NULL,'CHAR', 1, 1,NULL, 'Usuario',5
EXEC spSBInsertarFiltro 'Gastos','Usuario','Usuario','Usuario',NULL,'CHAR',1, 0,NULL,'Usuario',6
EXEC spSBInsertarFiltro 'Gastos','Moneda',     'Mon',   'Moneda',NULL,'CHAR',1,  0, NULL, 'Moneda',7
EXEC spSBInsertarFiltro 'Gastos','Movimiento','Movtipo','Mov',NULL,'CHAR',1,0,'Gasto', 'Mov',8,"Modulo='GAS'"
EXEC spSBInsertarFiltro 'Gastos','Concepto','Concepto','Concepto',NULL,'CHAR',1,0,NULL, 'Concepto',9,"Modulo='GAS'"
GO
EXEC spSBInsertarFiltro 'CXC','Sucursal','Sucursal','Sucursal','Nombre','INT',1, 0,NULL,'Sucursal',1
EXEC spSBInsertarFiltro 'CXC','Proyecto','Proy','Proyecto','Descripcion','CHAR',1, 0,NULL,'Proyecto',3
EXEC spSBInsertarFiltro 'CXC','UEN','UEN','UEN','Nombre','INT', 1, 0,NULL,'UEN',4
EXEC spSBInsertarFiltro 'CXC','Usuario','GrupoTrabajo','GrupoTrabajo',NULL,'CHAR', 1, 1,NULL, 'Usuario',5
EXEC spSBInsertarFiltro 'CXC','Usuario','Usuario','Usuario',NULL,'CHAR',1, 0,NULL,'Usuario',6
EXEC spSBInsertarFiltro 'CXC','Moneda',     'Mon',   'Moneda',NULL,'CHAR',1,  0, NULL, 'Moneda',7
EXEC spSBInsertarFiltro 'CXC','Movimiento','Movtipo','Mov',NULL,'CHAR',1,0,'Factura', 'Mov',8,"Modulo='CXC'"
EXEC spSBInsertarFiltro 'CXC','Concepto','Concepto','Concepto',NULL,'CHAR',1,0,NULL, 'Concepto',9,"Modulo='CXC'"
EXEC spSBInsertarFiltro 'CXC','Proyecto','Proy','Proyecto','Descripcion','CHAR',1, 0,NULL,'Proyecto',10
GO 
EXEC spSBInsertarFiltro 'CXP','Sucursal','Sucursal','Sucursal','Nombre','INT',1, 0,NULL,'Sucursal',1
EXEC spSBInsertarFiltro 'CXP','Proyecto','Proy','Proyecto','Descripcion','CHAR',1, 0,NULL,'Proyecto',3
EXEC spSBInsertarFiltro 'CXP','UEN','UEN','UEN','Nombre','INT', 1, 0,NULL,'UEN',4
EXEC spSBInsertarFiltro 'CXP','Usuario','GrupoTrabajo','GrupoTrabajo',NULL,'CHAR', 1, 1,NULL, 'Usuario',5
EXEC spSBInsertarFiltro 'CXP','Usuario','Usuario','Usuario',NULL,'CHAR',1, 0,NULL,'Usuario',6
EXEC spSBInsertarFiltro 'CXP','Moneda',     'Mon',   'Moneda',NULL,'CHAR',1,  0, NULL, 'Moneda',7
EXEC spSBInsertarFiltro 'CXP','Movimiento','Movtipo','Mov',NULL,'CHAR',1,0,'Documento', 'Mov',8,"Modulo='CXP'"
EXEC spSBInsertarFiltro 'CXP','Concepto','Concepto','Concepto',NULL,'CHAR',1,0,NULL, 'Concepto',9,"Modulo='CXP'"
EXEC spSBInsertarFiltro 'CXP','Proyecto','Proy','Proyecto','Descripcion','CHAR',1, 0,NULL,'Proyecto',10
EXEC spSBInsertarFiltro 'CXP','Proveedor','Prov','Proveedor','Nombre','CHAR',1, 0,NULL,'Proveedor',11
GO 
EXEC spSBInsertarFiltro 'Nomina','Sucursal','Sucursal','Sucursal','Nombre','INT',1, 0,NULL,'Sucursal',1
EXEC spSBInsertarFiltro 'Nomina','Proyecto','Proy','Proyecto','Descripcion','CHAR',1, 0,NULL,'Proyecto',2
EXEC spSBInsertarFiltro 'Nomina','UEN','UEN','UEN','Nombre','INT', 1, 0,NULL,'UEN',3
EXEC spSBInsertarFiltro 'Nomina','Movimiento','Movtipo','Mov',NULL,'CHAR',1,0,'Nomina', 'Mov',4,"Modulo='NOM'"
EXEC spSBInsertarFiltro 'Nomina','Concepto','Concepto','Concepto',NULL,'CHAR',1,0,NULL, 'Concepto',5,"Modulo='NOM'"
EXEC spSBInsertarFiltro 'Nomina','CentroCostos','CentroCostos','CentroCostos','Descripcion','CHAR', 1, 0,NULL,'CentroCostos',6
EXEC spSBInsertarFiltro 'Nomina','Departamento','Departamento','Departamento',NULL,'CHAR', 1, 0,NULL,'Departamento',7
EXEC spSBInsertarFiltro 'Nomina','Puesto','Puesto','Puesto',NULL,'CHAR', 1, 0,NULL,'Puesto',8
GO 
EXEC spSBInsertarFiltro 'Compras','Sucursal','Sucursal','Sucursal','Nombre','INT',1, 0,NULL,'Sucursal',1
EXEC spSBInsertarFiltro 'Compras','Proyecto','Proy','Proyecto','Descripcion','CHAR',1, 0,NULL,'Proyecto',3
EXEC spSBInsertarFiltro 'Compras','UEN','UEN','UEN','Nombre','INT', 1, 0,NULL,'UEN',4
EXEC spSBInsertarFiltro 'Compras','Usuario','GrupoTrabajo','GrupoTrabajo',NULL,'CHAR', 1, 1,NULL, 'Usuario',5
EXEC spSBInsertarFiltro 'Compras','Usuario','Usuario','Usuario',NULL,'CHAR',1, 0,NULL,'Usuario',6
EXEC spSBInsertarFiltro 'Compras','Moneda',     'Mon',   'Moneda',NULL,'CHAR',1,  0, NULL, 'Moneda',7
EXEC spSBInsertarFiltro 'Compras','Movimiento','MovClave','Grupo',NULL,'CHAR',1,1,'Orden Compra', 'Mov',8,"Modulo='COMS'"
EXEC spSBInsertarFiltro 'Compras','Movimiento','Movtipo','Mov',NULL,'CHAR',1,0,'Orden Compra', 'Mov',9,"Modulo='COMS'"
EXEC spSBInsertarFiltro 'Compras','Concepto','Concepto','Concepto',NULL,'CHAR',1,0,NULL, 'Concepto',10,"Modulo='COMS'"
EXEC spSBInsertarFiltro 'Compras','Almacen','Alm','Almacen','Nombre','CHAR',1,0,NULL, 'Almacen',11
EXEC spSBInsertarFiltro 'Compras','Fabricante','Art','Fabricante',NULL,'CHAR',1,0,NULL, 'Fabricante',12
EXEC spSBInsertarFiltro 'Compras','Grupo','Art','Grupo',NULL,'CHAR',1,0,NULL, 'Grupo',13
EXEC spSBInsertarFiltro 'Compras','Categoria','Art','Categoria',NULL,'CHAR',1,0,NULL, 'Categoria',14
EXEC spSBInsertarFiltro 'Compras','Linea','Art','Linea',NULL,'CHAR',1,0,NULL, 'Linea',15
EXEC spSBInsertarFiltro 'Compras','Familia','Art','Familia',NULL,'CHAR',1,0,NULL, 'Familia',16
GO
EXEC spSBInsertarFiltro 'Soporte','Sucursal','Sucursal','Sucursal','Nombre','INT',1, 0,NULL,'Sucursal',1
EXEC spSBInsertarFiltro 'Soporte','Proyecto','Proy','Proyecto','Descripcion','CHAR',1, 0,NULL,'Proyecto',3
EXEC spSBInsertarFiltro 'Soporte','UEN','UEN','UEN','Nombre','INT', 1, 0,NULL,'UEN',4
EXEC spSBInsertarFiltro 'Soporte','Usuario','GrupoTrabajo','GrupoTrabajo',NULL,'CHAR', 1, 1,NULL, 'Usuario',5
EXEC spSBInsertarFiltro 'Soporte','Usuario','Usuario','Usuario',NULL,'CHAR',1, 0,NULL,'Usuario',6
EXEC spSBInsertarFiltro 'Soporte','Movimiento','MovClave','Grupo',NULL,'CHAR',1,1,'Reporte', 'Mov',8,"Modulo='ST'"
EXEC spSBInsertarFiltro 'Soporte','Movimiento','Movtipo','Mov',NULL,'CHAR',1,0,'Reporte', 'Mov',9,"Modulo='ST'"
EXEC spSBInsertarFiltro 'Soporte','Concepto','Concepto','Concepto',NULL,'CHAR',1,0,NULL, 'Concepto',10,"Modulo='ST'"
EXEC spSBInsertarFiltro 'Soporte','Agente','Agente','Agente','Nombre','CHAR',1,0,NULL, 'Agente',17
EXEC spSBInsertarFiltro 'Soporte','Fuente','Agente','Agente','Nombre','CHAR',1,0,NULL, 'Fuente',18
EXEC spSBInsertarFiltro 'Soporte','Cliente','Cte','Cliente','Nombre','CHAR',1, 0,NULL,'Cliente',1
GO

--- Llenar la tabla de proceso TRUNCATE TABLE SBPROCESO
IF NOT EXISTS (SELECT Proceso FROM SBProceso WHERE Proceso='Ventas')
	INSERT SBProceso (Proceso,InvertirColores,Importe,Cantidad,Margen,UsarPresupuesto)
	VALUES ('Ventas',0,1,1,1,1)
GO
IF NOT EXISTS (SELECT Proceso FROM SBProceso WHERE Proceso='Compras')
	INSERT SBProceso (Proceso,InvertirColores,Importe,Cantidad,Margen,UsarPresupuesto)
	VALUES ('Compras',0,1,1,0,0)
GO
IF NOT EXISTS (SELECT Proceso FROM SBProceso WHERE Proceso='Gastos')
	INSERT SBProceso (Proceso,InvertirColores,Importe,Cantidad,Margen,UsarPresupuesto)
	VALUES ('Gastos',1,1,1,0,1)
GO
IF NOT EXISTS (SELECT Proceso FROM SBProceso WHERE Proceso='CXC')
	INSERT SBProceso (Proceso,InvertirColores,Importe,Cantidad,Margen,UsarPresupuesto,UsarFecha)
	VALUES ('CXC',0,1,0,0,0,1)
GO
IF NOT EXISTS (SELECT Proceso FROM SBProceso WHERE Proceso='CXP')
	INSERT SBProceso (Proceso,InvertirColores,Importe,Cantidad,Margen,UsarPresupuesto,UsarFecha)
	VALUES ('CXP',1,1,0,0,0,1)
GO
IF NOT EXISTS (SELECT Proceso FROM SBProceso WHERE Proceso='Nomina')
	INSERT SBProceso (Proceso,InvertirColores,Importe,Cantidad,Margen,UsarPresupuesto)
	VALUES ('Nomina',0,1,1,0,0)
GO
IF NOT EXISTS (SELECT Proceso FROM SBProceso WHERE Proceso='Soporte')
	INSERT SBProceso (Proceso,InvertirColores,Importe,Cantidad,Margen,UsarPresupuesto)
	VALUES ('Soporte',1,0,1,0,0)
GO

--- Para Llenar la tabla ProcesoDimension para saber que dimensiones se pueden tomar TRUNCATE table SBProcesoDimension
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Sucursal')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,TituloNegritas,Cubo)
	VALUES ('Ventas','Sucursal',90,100,90,100,'SB_VTAS','Nombre','Sucursal',1,1,'VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Agente')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Ventas','Agente',90,100,90,100,'SB_VTAS','Nombre','Agente',1,'VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Articulo')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Ventas','Articulo',90,100,90,100,'SB_VTAS','Descripcion1','Art',1,'VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Proyecto')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Ventas','Proyecto',90,100,90,100,'SB_VTAS',NULL,NULL,0,'VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Concepto')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Ventas','Concepto',90,100,90,100,'SB_VTAS',NULL,NULL,0,'VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Moneda')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Ventas','Moneda',90,100,90,100,'SB_VTAS',NULL,NULL,0,'VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='UEN')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Ventas','UEN',90,100,90,100,'SB_VTAS','Nombre','UEN',1,'VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Articulo Fabricante')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,LlaveDimension,Cubo)
	VALUES ('Ventas','Articulo Fabricante',90,100,90,100,'SB_VTAS','Fabricante','Art',1,'Articulo','Articulo','VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Articulo Familia')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,LlaveDimension,Cubo)
	VALUES ('Ventas','Articulo Familia',90,100,90,100,'SB_VTAS','Familia','Art',1,'Articulo','Articulo','VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Articulo Linea')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,LlaveDimension,Cubo)
	VALUES ('Ventas','Articulo Linea',90,100,90,100,'SB_VTAS','Linea','Art',1,'Articulo','Articulo','VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Articulo Grupo')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,LlaveDimension,Cubo)
	VALUES ('Ventas','Articulo Grupo',90,100,90,100,'SB_VTAS','Grupo','Art',1,'Articulo','Articulo','VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Articulo Categoria')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,LlaveDimension,Cubo)
	VALUES ('Ventas','Articulo Categoria',90,100,90,100,'SB_VTAS','Categoria','Art',1,'Articulo','Articulo','VTAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Ventas' AND Dimension='Empresa')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,Cubo)
	VALUES ('Ventas','Empresa',90,100,90,100,'SB_VTAS','Empresa','Empresa',1,'Empresa','VTAS')
GO

---- Gastos
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Gastos' AND Dimension='Sucursal')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Gastos','Sucursal',90,100,90,100,'SB_GAS','Nombre','Sucursal',1,'GAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Gastos' AND Dimension='Moneda')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Gastos','Moneda',90,100,90,100,'SB_GAS',NULL,NULL,0,'GAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Gastos' AND Dimension='UEN')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Gastos','UEN',90,100,90,100,'SB_GAS','Nombre','UEN',1,'GAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Gastos' AND Dimension='Concepto')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Gastos','Concepto',90,100,90,100,'SB_GAS',NULL,NULL,0,'GAS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Gastos' AND Dimension='Empresa')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Gastos','Empresa',90,100,90,100,'SB_GAS',NULL,NULL,0,'GAS')
GO

--- CXP
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='CXP' AND Dimension='Sucursal')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('CXP','Sucursal',90,100,90,100,'SB_CXP','Nombre','Sucursal',1,'CXP')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='CXP' AND Dimension='Moneda')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('CXP','Moneda',90,100,90,100,'SB_CXP',NULL,NULL,0,'CXP')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='CXP' AND Dimension='UEN')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('CXP','UEN',90,100,90,100,'SB_CXP','Nombre','UEN',1,'CXP')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='CXP' AND Dimension='Concepto')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('CXP','Concepto',90,100,90,100,'SB_CXP',NULL,NULL,0,'CXP')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='CXP' AND Dimension='Proveedor')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('CXP','Proveedor',90,100,90,100,'SB_CXP','Nombre','Prov',1,'CXP')
GO

--- CXC
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='CXC' AND Dimension='Sucursal')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('CXC','Sucursal',90,100,90,100,'SB_CXC','Nombre','Sucursal',1,'CXC')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='CXC' AND Dimension='Moneda')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('CXC','Moneda',90,100,90,100,'SB_CXC',NULL,NULL,0,'CXC')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='CXC' AND Dimension='UEN')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('CXC','UEN',90,100,90,100,'SB_CXC','Nombre','UEN',1,'CXC')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='CXC' AND Dimension='Concepto')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('CXC','Concepto',90,100,90,100,'SB_CXC',NULL,NULL,0,'CXC')
GO

--- NOM
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Nomina' AND Dimension='Sucursal')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Nomina','Sucursal',90,100,90,100,'SB_NOM','Nombre','Sucursal',1,'NOM')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Nomina' AND Dimension='Empresa')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Nomina','Empresa',90,100,90,100,'SB_NOM',NULL,NULL,0,'NOM')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Nomina' AND Dimension='Concepto')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Nomina','Concepto',90,100,90,100,'SB_NOM',NULL,NULL,0,'NOM')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Nomina' AND Dimension='Departamento')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Nomina','Departamento',90,100,90,100,'SB_NOM',NULL,NULL,0,'NOM')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Nomina' AND Dimension='Puesto')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Nomina','Puesto',90,100,90,100,'SB_NOM',NULL,NULL,0,'NOM')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Nomina' AND Dimension='Personal')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Nomina','Personal',90,100,90,100,'SB_NOM','NombreCompleto','PersonalNombre',1,'NOM')
GO

--- COMPRAS
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Sucursal')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,TituloNegritas,Cubo)
	VALUES ('Compras','Sucursal',90,100,90,100,'SB_COMS','Nombre','Sucursal',1,1,'COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Agente')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Compras','Agente',90,100,90,100,'SB_COMS','Nombre','Agente',1,'COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Almacen')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Compras','Almacen',90,100,90,100,'SB_COMS','Nombre','Alm',1,'COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Articulo')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Compras','Articulo',90,100,90,100,'SB_COMS','Descripcion1','Art',1,'COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Proyecto')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Compras','Proyecto',90,100,90,100,'SB_COMS',NULL,NULL,0,'COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Concepto')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Compras','Concepto',90,100,90,100,'SB_COMS',NULL,NULL,0,'COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Moneda')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Compras','Moneda',90,100,90,100,'SB_COMS',NULL,NULL,0,'COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='UEN')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Compras','UEN',90,100,90,100,'SB_COMS','Nombre','UEN',1,'COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Articulo Fabricante')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,LlaveDimension,Cubo)
	VALUES ('Compras','Articulo Fabricante',90,100,90,100,'SB_COMS','Fabricante','Art',1,'Articulo','Articulo','COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Articulo Familia')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,LlaveDimension,Cubo)
	VALUES ('Compras','Articulo Familia',90,100,90,100,'SB_COMS','Familia','Art',1,'Articulo','Articulo','COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Articulo Linea')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,LlaveDimension,Cubo)
	VALUES ('Compras','Articulo Linea',90,100,90,100,'SB_COMS','Linea','Art',1,'Articulo','Articulo','COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Articulo Grupo')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,LlaveDimension,Cubo)
	VALUES ('Compras','Articulo Grupo',90,100,90,100,'SB_COMS','Grupo','Art',1,'Articulo','Articulo','COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Articulo Categoria')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,LlaveDimension,Cubo)
	VALUES ('Compras','Articulo Categoria',90,100,90,100,'SB_COMS','Categoria','Art',1,'Articulo','Articulo','COMS')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Compras' AND Dimension='Empresa')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,Cubo)
	VALUES ('Compras','Empresa',90,100,90,100,'SB_COMS','Empresa','Empresa',1,'Empresa','COMS')
GO

--- Soporte
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Soporte' AND Dimension='Sucursal')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,TituloNegritas,Cubo)
	VALUES ('Soporte','Sucursal',90,100,90,100,'SB_STCTE','Nombre','Sucursal',1,1,'ST_CTE')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Soporte' AND Dimension='Agente')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Soporte','Agente',90,100,90,100,'SB_STCTE','Nombre','Agente',1,'ST_CTE')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Soporte' AND Dimension='Fuente')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,LlaveDimension,Cubo)
	VALUES ('Soporte','Fuente',90,100,90,100,'SB_STCTE','Nombre','Agente',1,'Agente','Fuente','ST_CTE')
GO 
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Soporte' AND Dimension='Proyecto')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Soporte','Proyecto',90,100,90,100,'SB_STCTE',NULL,NULL,0,'ST_CTE')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Soporte' AND Dimension='Concepto')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Soporte','Concepto',90,100,90,100,'SB_STCTE',NULL,NULL,0,'ST_CTE')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Soporte' AND Dimension='UEN')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,Cubo)
	VALUES ('Soporte','UEN',90,100,90,100,'SB_STCTE','Nombre','UEN',1,'ST_CTE')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Soporte' AND Dimension='Empresa')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,Cubo)
	VALUES ('Soporte','Empresa',90,100,90,100,'SB_STCTE','Empresa','Empresa',1,'Empresa','ST_CTE')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Soporte' AND Dimension='Cliente')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveCatalogo,Cubo)
	VALUES ('Soporte','Cliente',90,100,90,100,'SB_STCTE','Nombre','Cte',0,'Cliente','ST_CTE')
GO
IF NOT EXISTS (SELECT Proceso,Dimension FROM SBProcesoDimension WHERE Proceso='Soporte' AND Dimension='Mov')
	INSERT SBProcesoDimension (Proceso,Dimension,AnteriorPrimerPorc,AnteriorSegundoPorc,PresupuestoPrimerPorc,PresupuestoSegundoPorc,Tabla,NombreCampo,Catalogo,UsarDescripcion,LlaveDimension,Cubo)
	VALUES ('Soporte','Mov',90,100,90,100,'SB_STCTE','Mov',NULL,0,'Mov','ST_CTE')
GO


