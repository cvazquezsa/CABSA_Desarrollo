/* CuboPROY */
EXEC spLimpiarCubo 'PROY'
EXEC spInsertarStore 'PROY','spCuboProy',1
EXEC spInsertarCubo  'PROY','Proyectos','Cubo de Proyectos','Cubo_TPROY',0,1
GO
EXEC spInsertarMedida 'PROY','Importe','Importe','Importe','aggSum'
EXEC spInsertarMedida 'PROY','ImporteTotal ','Importe Total','Importe Total','aggSum'
EXEC spInsertarMedida 'PROY','Descuentos','Descuentos','Descuentos','aggSum'
EXEC spInsertarMedida 'PROY','Impuestos','Impuestos','Impuestos','aggSum'
EXEC spInsertarMedida 'PROY','Retencion','Retencion','Retencion','aggSum'
EXEC spInsertarMedida 'PROY','Retencion2','Retencion 2','Retencion 2','aggSum'
EXEC spInsertarMedida 'PROY','Cantidad','Cantidad','Cantidad','aggSum'
GO
EXEC spInsertarDimension 'PROY','Proyecto Categoria','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'PROY','Proyecto Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension 'PROY','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'PROY','Proyecto','Proyecto','Proyecto','Proyecto',1
EXEC spInsertarDimensionNivel  'PROY','Proyecto','Descripcion','Descripcion','Descripcion',2
GO
EXEC spInsertarDimension 'PROY','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel  'PROY','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'PROY','Situacion','Normal','Situacion',1
EXEC spInsertarDimensionNivel  'PROY','Situacion','Situacion','Situacion','Situacion',1
GO 
EXEC spInsertarDimension 'PROY','Submodulo','Normal','Submodulo',1
EXEC spInsertarDimensionNivel  'PROY','Submodulo','Submodulo','Submodulo','Submodulo',1
GO
EXEC spInsertarDimension 'PROY','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'PROY','Movimiento','MovID','Consecutivo','Consecutivo',1
EXEC spInsertarDimensionNivel  'PROY','Movimiento','Mov','Movimiento','Movimiento',2
EXEC spInsertarDimensionNivel  'PROY','Movimiento','Modulo','Modulo','Modulo',3
GO
EXEC spInsertarDimension 'PROY','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'PROY','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'PROY','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'PROY','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension 'PROY','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel  'PROY','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'PROY','Fecha Requerida','Tiempo','Fecha Requerida',1
EXEC spInsertarDimensionNivel  'PROY','Fecha Requerida','FechaRequerida','Fecha Requerida','FechaRequerida',1
GO
EXEC spInsertarDimension 'PROY','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'PROY','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'PROY','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'PROY','Semana','Semana','Semana','Semana',1
GO 
EXEC spInsertarDimension 'PROY','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'PROY','Mes','MesNombre','Mes','Mes',1
GO
EXEC spInsertarDimension 'PROY','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'PROY','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'PROY','Empresa','EmpresaNombre','Empresa Nombre','EmpresaNombre',2
EXEC spInsertarDimensionNivel  'PROY','Empresa','EmpresaGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'PROY','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'PROY','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'PROY','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
EXEC spInsertarDimensionNivel  'PROY','Sucursal','SucursalRegion','Región','Región',3
GO
EXEC spInsertarDimension 'PROY','Cliente Estado','Normal','Cliente Estado',1
EXEC spInsertarDimensionNivel  'PROY','Cliente Estado','ClienteEstado','Cliente Estado','Cliente Estado',1
GO
EXEC spInsertarDimension 'PROY','Cliente Situacion','Normal','Cliente Situacion',1
EXEC spInsertarDimensionNivel  'PROY','Cliente Situacion','ClienteSituacion','Cliente Situacion','Cliente Situacion',1
GO
EXEC spInsertarDimension 'PROY','Cliente Categoria','Normal','Cliente Categoria',1
EXEC spInsertarDimensionNivel  'PROY','Cliente Categoria','ClienteCategoria','Cliente Categoría','Cliente Categoría',1
GO
EXEC spInsertarDimension 'PROY','Cliente Familia','Normal','Cliente Familia',1
EXEC spInsertarDimensionNivel  'PROY','Cliente Familia','ClienteFamilia','Cliente Familia','Cliente Familia',1
GO
EXEC spInsertarDimension 'PROY','Cliente Grupo','Normal','Cliente Grupo',1
EXEC spInsertarDimensionNivel  'PROY','Cliente Grupo','ClienteGrupo','Cliente Grupo','Cliente Grupo',1
GO
EXEC spInsertarDimension 'PROY','Cliente Rama','Normal','Cliente Rama',1
EXEC spInsertarDimensionNivel  'PROY','Cliente Rama','ClienteRama','Cliente Rama','Cliente Rama',1
GO
EXEC spInsertarDimension 'PROY','Acreedor','Normal','Acreedor',1
EXEC spInsertarDimensionNivel  'PROY','Acreedor','Acreedor','Acreedor','Acreedor',1
EXEC spInsertarDimensionNivel  'PROY','Acreedor','AcreedorNombre','Acreedor Nombre','Acreedor Nombre',2
GO
EXEC spInsertarDimension 'PROY','Acreedor Estado','Normal','Acreedor Estado',1
EXEC spInsertarDimensionNivel  'PROY','Acreedor Estado','AcreedorEstado','Acreedor Estado','Acreedor Estado',1
GO
EXEC spInsertarDimension 'PROY','Acreedor Situacion','Normal','Acreedor Situacion',1
EXEC spInsertarDimensionNivel  'PROY','Acreedor Situacion','AcreedorSituacion','Acreedor Situacion','Acreedor Situacion',1
GO
EXEC spInsertarDimension 'PROY','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'PROY','Cliente','Cliente','Cliente','Cliente',1
EXEC spInsertarDimensionNivel  'PROY','Cliente','ClienteNombre','Cliente Nombre','Cliente Nombre',2
GO
EXEC spInsertarDimension 'PROY','Forma Envio','Normal','FormaEnvio',1
EXEC spInsertarDimensionNivel  'PROY','Forma Envio','FormaEnvio','FormaEnvio','FormaEnvio',1
GO
EXEC spInsertarDimension 'PROY','Condicion','Normal','Condicion',1
EXEC spInsertarDimensionNivel  'PROY','Condicion','Condicion','Condicion','Condicion',1
GO
EXEC spInsertarDimension 'PROY','Vencimiento','Normal','Vencimiento',1
EXEC spInsertarDimensionNivel  'PROY','Vencimiento','Vencimiento','Vencimiento','Vencimiento',1
GO
EXEC spInsertarDimension 'PROY','Fecha Conclusion','Normal','Fecha Conclusion',1
EXEC spInsertarDimensionNivel  'PROY','Fecha Conclusion','FechaConclusion','FechaConclusion','FechaConclusion',1
GO
EXEC spInsertarDimension 'PROY','Condicion','Normal','Condicion',1
EXEC spInsertarDimensionNivel  'PROY','Condicion','Condicion','Condicion','Condicion',1
GO
EXEC spInsertarDimension 'PROY','Tipo','Normal','Tipo',1
EXEC spInsertarDimensionNivel  'PROY','Tipo','Tipo','Tipo','Tipo',1
GO
EXEC spInsertarDimension 'PROY','Agente','Normal','Agente',1
EXEC spInsertarDimensionNivel  'PROY','Agente','Agente','Agente','Agente',1
EXEC spInsertarDimensionNivel  'PROY','Agente','AgenteNombre','Agente Nombre','Agente Nombre',2
GO
EXEC spInsertarDimension 'PROY','Artículo Categoria','Normal','Artículo',1
EXEC spInsertarDimensionNivel  'PROY','Artículo Categoria','ArtCategoria','Artículo Categoría','Artículo Categoría',1
GO
EXEC spInsertarDimension 'PROY','Artículo Familia','Normal','Artículo',1
EXEC spInsertarDimensionNivel  'PROY','Artículo Familia','ArtFamilia','Artículo Familia','Artículo Familia',1
GO
EXEC spInsertarDimension 'PROY','Artículo Grupo','Normal','Artículo',1
EXEC spInsertarDimensionNivel  'PROY','Artículo Grupo','ArtGrupo','Artículo Grupo','Artículo Grupo',1
GO
EXEC spInsertarDimension 'PROY','Artículo','Normal','Artículo',1
EXEC spInsertarDimensionNivel  'PROY','Artículo','Articulo','Artículo','Artículo',1
EXEC spInsertarDimensionNivel  'PROY','Artículo','ArtNombre','Artículo Nombre','Artículo Nombre',2
GO
EXEC spInsertarDimension 'PROY','Artículo Fabricante','Normal','Artículo',1
EXEC spInsertarDimensionNivel  'PROY','Artículo Fabricante','ArtFabricante','Artículo Fabricante','Artículo Fabricante',1
GO
EXEC spInsertarDimension 'PROY','Artículo Linea','Normal','Artículo',1
EXEC spInsertarDimensionNivel  'PROY','Artículo Linea','ArtLinea','Artículo Linea','Artículo Linea',1
GO
/*	Se le agregaron las dimensiones UEN, Clasificacion, SubClasificacion y Comparativo		Víctor Gutiérrez Méndez */
EXEC spInsertarDimension 'PROY','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'PROY','UEN','UEN','UEN','UEN',1
GO
EXEC spInsertarDimension 'PROY','Clasificacion','Normal','Clasificacion',1
EXEC spInsertarDimensionNivel  'PROY','Clasificacion','Clasificacion','Clasificacion','Clasificacion',1
GO
EXEC spInsertarDimension 'PROY','SubClasificacion','Normal','SubClasificacion',1
EXEC spInsertarDimensionNivel  'PROY','SubClasificacion','SubClasificacion','SubClasificacion','SubClasificacion',1
GO
EXEC spInsertarDimension 'PROY','Comparativo','Normal','Comparativo',1
EXEC spInsertarDimensionNivel  'PROY','Comparativo','Comparativo','Comparativo','Comparativo',1
GO
/* CuboPROY */
--- Crea la tabla donde se guarda las ventas, los gastos y la monia por proyectos
--- 9-jun-2004

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_TPROY]'))
DROP TABLE Cubo_TPROY
GO
CREATE TABLE Cubo_TPROY
(	Sucursal		int		NULL,
	SucursalNombre		varchar(100)	NULL,
	SucursalRegion		varchar(50)	NULL,
	Empresa			char(5)		NULL,
	EmpresaNombre		varchar(100)	NULL,
	EmpresaGrupo		varchar(100)	NULL,
	Categoria		varchar(50)	NULL,
	Proyecto		varchar(50)	NULL,
	Descripcion		varchar(100)	NULL,
	Modulo			varchar(10)	NULL,
	Mov			char(20)	NULL,
	Movid			varchar(20)	NULL,
	FechaEmision		datetime	NULL,
	FechaRequerida		datetime	NULL,
	trimestre		varchar(30)	NULL,
	Semana			varchar(50)	NULL,
	Año			smallint	NULL,
	MesNombre		varchar(30)	NULL,
	Concepto		varchar(50)	NULL,
	Moneda			char(10)	NULL,
	Estatus			char(15)	NULL,
	Situacion		varchar(50)	NULL,
	agente			char(10)	NULL,
	AgenteNombre		varchar(100)	NULL,
	Cliente			char(10)	NULL,
	ClienteNombre		varchar(100)	NULL,
	ClienteFamilia		varchar(50)	NULL,
	ClienteCategoria	varchar(50)	NULL,
	ClienteGrupo		varchar(50)	NULL,
	ClienteRama		char(10)	NULL,
	ClienteEstado		varchar(30)	NULL,
	ClienteSituacion	varchar(50)	NULL,
	Articulo		char(20)	NULL,
	ArtNombre		varchar(100)	NULL,
	ArtFamilia		varchar(50)	NULL,
	ArtCategoria		varchar(50)	NULL,
	ArtGrupo		varchar(50)	NULL,
	ArtLinea		varchar(50)	NULL,
	ArtFabricante		varchar(50)	NULL,
	Cantidad		money		NULL,
	Descuentos		money		NULL,
	Importe			money		NULL,
	Impuestos		money		NULL,
	ImporteTotal		money		NULL,
	Retencion		int		NULL,
	Retencion2		int		NULL,
	Tipo			varchar(8)	NULL,
	SubModulo		varchar(10)	NULL,
	Acreedor		char(10)	NULL,
	AcreedorNombre		varchar(30)	NULL,
	AcreedorSituacion	varchar(50)	NULL,
	AcreedorEstado		varchar(50)	NULL,
	formaEnvio		varchar(50)	NULL,
	Condicion		varchar(50)	NULL,
	FechaConclusion		datetime	NULL,
	Vencimiento		datetime	NULL,
	UEN			int		NULL,
	UENNombre		varchar(100)	NULL,
	Clasificacion		varchar(50)	NULL,
	SubClasificacion	varchar(50)	NULL,
	Comparativo		varchar(50)	NULL
)

GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_PROYGASTO]'))
DROP TABLE Cubo_PROYGASTO
GO
CREATE TABLE Cubo_PROYGASTO
(	Mov			char(20)	NULL,
	Concepto		varchar(50)	NULL,
	Categoria		varchar(50)	NULL,
	Proyecto		varchar(50)	NULL,
	Ejercicio		int		NULL,
	Periodo			int		NULL,
	UEN			int		NULL,
	UENNombre		varchar(100)	NULL,
	Clasificacion		varchar(50)	NULL,
	SubClasificacion	varchar(50)	NULL,
	Importe			money		NULL,
	Fecha			datetime	NULL

)

go

INSERT Cubo_PROYGASTO (Mov, Concepto, Categoria, Proyecto, Ejercicio, Periodo, UEN, Clasificacion, SubClasificacion, Importe, Fecha)
SELECT 	'Historico', gd.concepto, P.Categoria, gd.Proyecto, Ejercicio, Periodo, gd.UEN, g.Clase, g.SubClase, gd.Importe * -1, g.FechaEmision
FROM Gasto g
LEFT OUTER JOIN GastoD gd    	ON g.Id 	 = gd.Id
LEFT OUTER JOIN Proy p    	ON p.proyecto 	 = gd.proyecto
WHERE g.Mov 	= 'Presupuesto'
AND gd.Proyecto NOT IN ('MORSA')
AND p.Categoria IN ('Consultoría Distribuidores','Consultoria Interna Intélisis')
AND p.Estatus 	= 'ALTA'
AND gd.Concepto = 'Honorarios Corporativos'
AND g.Estatus 	= 'CONCLUIDO'
AND gd.Proyecto NOT IN ('GRUPO PARISINA, S.A. DE C.V.')


INSERT Cubo_PROYGASTO (Mov, Concepto, Categoria, Proyecto, Ejercicio, Periodo, UEN, Clasificacion, SubClasificacion, Importe, Fecha)
SELECT 	'Historico', gd.concepto, P.Categoria, gd.Proyecto, Ejercicio, Periodo, gd.UEN, g.Clase, g.SubClase, gd.Importe * -1, g.FechaEmision
FROM Gasto g
LEFT OUTER JOIN GastoD gd    	ON g.Id 	 = gd.Id
LEFT OUTER JOIN Proy p    	ON p.proyecto 	 = gd.proyecto
WHERE g.Mov 	= 'Presupuesto'
AND gd.Proyecto NOT IN ('MORSA')
AND p.Categoria IN ('Consultoría Distribuidores','Consultoria Interna Intélisis')
AND p.Estatus 	= 'ALTA'
AND gd.Concepto = 'Honorarios Consultoria'
AND g.Estatus 	= 'CONCLUIDO'
AND gd.Proyecto IN ('GRUPO PARISINA, S.A. DE C.V.')




GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spCuboProy]'))
DROP PROCEDURE spCuboProy
GO
CREATE PROCEDURE spCuboProy
--//WITH ENCRYPTION
AS
BEGIN

--- Descripción: Almacena en la tabla Cubo_Proy las ventas, los gastos y compras de los proyectos
--- Se ejecuta en la tarea de procesar cubos
--- 9-06-2004


TRUNCATE TABLE CUBO_TPROY

INSERT CUBO_TPROY
SELECT 
	'Sucursal' 			= v.Sucursal,
	'SucursalNombre'	= s.Nombre,  
	'SucursalRegion' 	= s.Region, 
	'Empresa'			= v.Empresa,
	'EmpresaNombre'		= e.Nombre,  
	'EmpresaGrupo' 		= e.Grupo,
	p.Categoria,
	p.Proyecto,
	p.Descripcion,
	'Modulo'			= 'Ventas',
	v.Mov,
	v.Movid,
	v.FechaEmision,
	v.FechaRequerida,
	t.trimestre,
	t.Semana,
	'Año' 				= t.Anio,
	t.MesNombre,
	v.Concepto,
	v.Moneda,
	v.Estatus,
	v.Situacion,
	v.agente,
	'AgenteNombre'		= ag.nombre,	
  	'Cliente' 			= v.Cliente, 
  	'ClienteNombre' 	= c.Nombre,
  	'ClienteFamilia' 	= c.Familia,
  	'ClienteCategoria' 	= c.Categoria,
  	'ClienteGrupo' 		= c.Grupo,
	'ClienteRama' 		= c.Rama,
	'ClienteEstado'		= c.Estado,
	'ClienteSituacion'	= c.Situacion,
  	'Articulo' 			= v.Articulo, 
  	'ArtNombre' 		= a.Descripcion1,
  	'ArtFamilia'		= a.Familia,
  	'ArtCategoria' 		= a.Categoria,
  	'ArtGrupo' 			= a.Grupo,
  	'ArtLinea' 			= a.Linea,
  	'ArtFabricante' 	= a.Fabricante,
	'Cantidad'			= CONVERT(money, v.Cantidad		* mt.Factor), 
	'Descuentos' 		= CONVERT(money, v.DescuentosTotales	* mt.Factor), 
  	'Importe' 			= CONVERT(money, v.SubTotal		* mt.Factor * v.tipoCambio), 
  	'Impuestos' 		= CONVERT(money, v.Impuestos		* mt.Factor), 
  	'ImporteTotal' 		= CONVERT(money, v.ImporteTotal		* mt.Factor * v.tipoCambio),
  	'Retencion' 		= 0, 
  	'Retencion2' 		= 0, 
	'Tipo'				= 'Ingresos',
	'SubModulo' 		= 'Ventas',
	'Acreedor'			= NULL,
	'AcreedorNombre'	= NULL,
	'AcreedorSituacion'	= NULL,
	'AcreedorEstado'	= NULL,
	v.formaEnvio,
	v.Condicion,
	v.FechaConclusion,
	v.Vencimiento,
	v.UEN,
	UEN.Nombre,
	'Clasificacion'		= NULL,
	'SubClasificacion'	= NULL,
	'Comparativo'		= CASE WHEN v.mov = 'Presupuesto'
								THEN 'Presupuesto'
								ELSE 'Real'
								END           
 
FROM VentaTcalc v  
		JOIN   Proy p		ON p.proyecto 	 = v.proyecto
LEFT OUTER JOIN Empresa e  	ON v.Empresa  	 = e.Empresa 
LEFT OUTER JOIN Sucursal s 	ON v.Sucursal 	 = s.Sucursal 
LEFT OUTER JOIN Cte  c     	ON v.Cliente  	 = c.Cliente
LEFT OUTER JOIN Agente  ag 	ON v.Agente  	 = ag.Agente
LEFT OUTER JOIN Art a 	   	ON v.Articulo 	 = a.Articulo 
LEFT OUTER JOIN PropTipo pt ON v.Articulo 	 = a.Articulo 
LEFT OUTER JOIN MovTipo mt 	ON v.Mov  		 = mt.Mov  
LEFT OUTER JOIN UEN	 		ON v.UEN  		 = UEN.UEN
LEFT OUTER JOIN Tiempo t   	ON v.fechaEmision= t.Fecha	
WHERE mt.Modulo = 'VTAS'  
AND v.proyecto IS NOT NULL
AND v.Estatus	= 'CONCLUIDO'


INSERT CUBO_TPROY
SELECT 
	'Sucursal' 			= g.Sucursal,
	'SucursalNombre'	= s.Nombre,  
	'SucursalRegion' 	= s.Region, 
	'Empresa'			= g.Empresa,
	'EmpresaNombre'		= e.Nombre,  
	'EmpresaGrupo' 		= e.Grupo,
	p.Categoria,
	p.Proyecto,
	p.Descripcion,
	'Modulo'			= 'Gastos',
	g.Mov,
	g.Movid,
	g.FechaEmision,
	g.FechaRequerida,
	t.trimestre,
	t.Semana,
	'Año' 				= t.Anio,
	t.MesNombre,
	gd.concepto,
	g.Moneda,
	g.Estatus,
	g.Situacion,
	NULL,
	'AgenteNombre'		= NULL,
  	'Cliente' 			= NULL, 
  	'ClienteNombre' 	= NULL,
  	'ClienteFamilia' 	= NULL,
  	'ClienteCategoria' 	= NULL,
  	'ClienteGrupo' 		= NULL,
	'ClienteRama' 		= NULL,
	'ClienteEstado'		= NULL,
	'ClienteSituacion'	= NULL,
  	'Articulo' 			= 'CONSULTORIA', 
  	'ArtNombre' 		= 'CONSULTORIA',
  	'ArtFamilia'		= NULL,
  	'ArtCategoria' 		= NULL,
  	'ArtGrupo' 			= NULL,
  	'ArtLinea' 			= NULL,
  	'ArtFabricante' 	= NULL,
	gd.Cantidad,
	'Descuentos' 		= 0, 
  	'Importe' 			= CONVERT(money, gd.Importe * -1 * g.tipoCambio), 
  	'Impuestos' 		= CONVERT(money, gd.Impuestos	* -1), 
  	'ImporteTotal' 		= CONVERT(money, (isnull(gd.Importe,0)+isnull(gd.Impuestos,0)-(ISNULL(gd.Retencion,0)+ISNULL(gd.Retencion2,0)))* -1) * g.TipoCambio,
  	'Retencion' 		= CONVERT(money, gd.Retencion           * -1), 
  	'Retencion2' 		= CONVERT(money, gd.Retencion2          * -1), 
	'Tipo'				= 'Egresos',
	'SubModulo' 		= 'Gastos',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	gd.UEN,
	UEN.Nombre,
	'Clasificacion'		= g.Clase,
	'SubClasificacion'	= g.SubClase,
	'Comparativo'		= CASE WHEN g.mov = 'Presupuesto'
								THEN 'Presupuesto'
								ELSE 'Real'
								END      
FROM Gasto g
LEFT OUTER JOIN GastoD gd   ON g.Id 	 = gd.Id
LEFT OUTER JOIN Proy p    	ON p.proyecto 	 = gd.proyecto
LEFT OUTER JOIN Empresa e  	ON g.Empresa  	 = e.Empresa 
LEFT OUTER JOIN Sucursal s 	ON g.Sucursal 	 = s.Sucursal 
LEFT OUTER JOIN Tiempo t   	ON g.fechaEmision= t.Fecha	
LEFT OUTER JOIN UEN	 		ON gd.UEN  	 = UEN.UEN
WHERE g.proyecto IS NOT NULL
AND g.Estatus	= 'CONCLUIDO'


INSERT CUBO_TPROY(Categoria,Proyecto,Modulo, Mov, Año, Concepto, Articulo, ArtNombre, Importe, Tipo, SubModulo, UEN, Clasificacion, SubClasificacion, Comparativo, FechaEmision)
SELECT 
	g.Categoria,
	g.Proyecto,
	'Modulo'		= 'Gastos',
	g.Mov,
	'Año' 			= g.Ejercicio,
	g.concepto,
  	'Articulo' 		= 'CONSULTORIA', 
  	'ArtNombre' 		= 'CONSULTORIA',
  	'Importe' 		= CONVERT(money, g.Importe), 
	'Tipo'			= 'Egresos',
	'SubModulo' 	= 'Gastos',
	g.UEN,
	g.Clasificacion,
	g.SubClasificacion,
	'Comparativo'	= 'Real',
	g.Fecha
FROM Cubo_PROYGASTO g


END
GO




