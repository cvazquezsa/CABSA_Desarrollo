/* Cubo de contabilidad */ 
--- Agregar la dimension de Ejercicio/Periodo junto para los acumulados 26-11-2003
EXEC spInsertarCubo  'CONT','Contabilidad','Cubo de Contabilidad','Cubo_CONT',0,1
GO
EXEC spInsertarMedida 'CONT','Cargos','Cargos','Cargos','aggSum'
EXEC spInsertarMedida 'CONT','Abonos','Abonos','Abonos','aggSum'
EXEC spInsertarMedida 'CONT','Presupuesto','Presupuesto','Presupuesto','aggSum'
GO
EXEC spInsertarFormula 'CONT','Saldo','Saldo','[Measures].[Cargos]-[Measures].[Abonos]',1
GO
EXEC spInsertarDimension 'CONT','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'CONT','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'CONT','Empresa','EmpresaNombre','Empresa Nombre','EmpresaNombre',2
EXEC spInsertarDimensionNivel  'CONT','Empresa','EmpresaGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'CONT','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'CONT','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'CONT','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
EXEC spInsertarDimensionNivel  'CONT','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'CONT','Ejercicio','Normal','Ejercicio',1
EXEC spInsertarDimensionNivel  'CONT','Ejercicio','Ejercicio','Ejercicio','Ejercicio',1
GO
EXEC spInsertarDimension 'CONT','Periodo','Normal','Periodo',1
EXEC spInsertarDimensionNivel  'CONT','Periodo','Periodo','Periodo','Periodo',1
GO
EXEC spInsertarDimension 'CONT','Estructura','Normal','Estructura',1
EXEC spInsertarDimensionNivel  'CONT','Estructura','Estructura','Estructura','Estructura',1
EXEC spInsertarDimensionNivel  'CONT','Estructura','EstDescripcion','EstDescripcion','EstDescripcion',2
GO
EXEC spInsertarDimension 'CONT','Mayor','Normal','Mayor',1
EXEC spInsertarDimensionNivel  'CONT','Mayor','Mayor','Mayor','Mayor',1
EXEC spInsertarDimensionNivel  'CONT','Mayor','MayorDescripcion','MayorDescripcion','MayorDescripcion',2
GO
EXEC spInsertarDimension 'CONT','SubCuenta','Normal','Subcuenta',1
EXEC spInsertarDimensionNivel  'CONT','SubCuenta','Subcuenta','SubCuenta','Subcuenta',1
EXEC spInsertarDimensionNivel  'CONT','SubCuenta','SubctaDescripcion','SubCtaDescripcion','SubctaDescripcion',2
GO
EXEC spInsertarDimension 'CONT','Clase','Normal','Clase',1
EXEC spInsertarDimensionNivel  'CONT','Clase','Clase','Clase','Clase',1
GO
EXEC spInsertarDimension 'CONT','Auxiliar','Normal','Auxiliar',1
EXEC spInsertarDimensionNivel  'CONT','Auxiliar','Auxiliar','Auxiliar','Auxiliar',1
EXEC spInsertarDimensionNivel  'CONT','Auxiliar','AuxDescripcion','AuxDescripcion','AuxDescripcion',2
GO
EXEC spInsertarDimension 'CONT','Centro Costos','Normal','CentroCostos',1
EXEC spInsertarDimensionNivel  'CONT','Centro Costos','CentroCosto','Centro Costo','Centro Costo',1
EXEC spInsertarDimensionNivel  'CONT','Centro Costos','DescripcionCC','Descripcion','Descripcion',2
EXEC spInsertarDimensionNivel  'CONT','Centro Costos','SubGrupoCC','SubGrupo','SubGrupo',3
EXEC spInsertarDimensionNivel  'CONT','Centro Costos','GrupoCC','Grupo','Grupo',4
GO
--- Dimension para Acumulados de un año a otro
EXEC spInsertarDimension 'CONT','Ejercicio','Normal','Ejercicio',1
EXEC spInsertarDimensionNivel  'CONT','Ejercicio ','Ejercicio','Ejercicio','Ejercicio',2
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CONT_EST]'))
DROP VIEW Cubo_CONT_EST
GO
CREATE VIEW Cubo_CONT_EST
--//WITH ENCRYPTION
AS
 SELECT
	'Estructura'		= Cta.Cuenta,
    'EstDescripcion'	= Cta.Descripcion,
	'EstEsAcumulativa'	= Cta.EsAcumulativa,
	'EstCategoria'		= Cta.Categoria,
	'EstFamilia'		= Cta.Familia,
	'EstGrupo'		= Cta.Grupo,
	'Mayor'		= '  ',
        'MayorDescripcion'	= '  ',
	'MayorEsAcumulativa'	= '  ',
	'MayorCategoria'	= '  ',
	'MayorFamilia'		= '  ',
	'MayorGrupo'		= '  ',
	'SubCuenta'		= '  ',
        'SubCtaDescripcion'	= '  ',
	'SubCtaEsAcumulativa'	= '  ',
	'SubCtaCategoria'	= '  ',
	'SubCtaFamilia'	= '  ',
	'SubCtaGrupo'		= '  ',
	'Auxiliar'		= '  ',
        'AuxDescripcion'		= '  ',
	'AuxEsAcumulativa'	= '  ',
	'AuxCategoria'		= '  ',
	'AuxFamilia'		= '  ',
	'AuxGrupo'		= '  '
   FROM Cta
   WHERE Cta.Tipo='Estructura'
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CONT_MAYOR]'))
DROP VIEW Cubo_CONT_MAYOR
GO
CREATE VIEW Cubo_CONT_MAYOR
--//WITH ENCRYPTION
AS
  SELECT
	'Estructura'		= Cat.Estructura,
        'EstDescripcion'		= Cat.EstDescripcion,
	'EstEsAcumulativa'	= Cat.EstEsAcumulativa,
	'EstCategoria'		= Cat.EstCategoria,
	'EstFamilia'		= Cat.EstFamilia,
	'EstGrupo'		= Cat.EstGrupo,
	'Mayor'		= Cta.Cuenta,
        'MayorDescripcion'	= Cta.Descripcion,
	'MayorEsAcumulativa'	= Cta.EsAcumulativa,
	'MayorCategoria'	= Cta.Categoria,
	'MayorFamilia'		= Cta.Familia,
	'MayorGrupo'		= Cta.Grupo,
	'SubCuenta'		= '  ',
        'SubCtaDescripcion'	= '  ',
	'SubCtaEsAcumulativa'	= '  ',
	'SubCtaCategoria'	= '  ',
	'SubCtaFamilia'	= '  ',
	'SubCtaGrupo'		= '  ',
	'Auxiliar'		= '  ',
        'AuxDescripcion'		= '  ',
	'AuxEsAcumulativa'	= '  ',
	'AuxCategoria'		= '  ',
	'AuxFamilia'		= '  ',
	'AuxGrupo'		= '  '

   FROM Cta, Cubo_CONT_EST Cat
   WHERE Cta.Rama = Cat.Estructura
	AND Cta.Tipo =  'Mayor'
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CONT_SUB]'))
DROP VIEW Cubo_CONT_SUB
GO
CREATE VIEW Cubo_CONT_SUB
--//WITH ENCRYPTION
AS

  SELECT
	'Estructura'		= Cat.Estructura,
        'EstDescripcion'		= Cat.EstDescripcion,
	'EstEsAcumulativa'	= Cat.EstEsAcumulativa,
	'EstCategoria'		= Cat.EstCategoria,
	'EstFamilia'		= Cat.EstFamilia,
	'EstGrupo'		= Cat.EstGrupo,
	'Mayor'		= Cat.Mayor,
        'MayorDescripcion'	= Cat.MayorDescripcion,
	'MayorEsAcumulativa'	= Cat.MayorEsAcumulativa,
	'MayorCategoria'	= Cat.MayorCategoria,
	'MayorFamilia'		= Cat.MayorFamilia,
	'MayorGrupo'		= Cat.MayorGrupo,
	'Subcuenta'		= Cta.Cuenta,
        'SubCtaDescripcion'	= Cta.Descripcion,
	'SubCtaEsAcumulativa'	= Cta.EsAcumulativa,
	'SubCtaCategoria'	= Cta.Categoria,
	'SubCtaFamilia'	= Cta.Familia,
	'SubCtaGrupo'		= Cta.Grupo,
	'Auxiliar'		= '  ',
        'AuxDescripcion'		= '  ',
	'AuxEsAcumulativa'	= '  ',
	'AuxCategoria'		= '  ',
	'AuxFamilia'		= '  ',
	'AuxGrupo'		= '  '

   FROM Cta, Cubo_CONT_MAYOR Cat
   WHERE Cta.Rama = Cat.Mayor
	AND Cta.Tipo='SubCuenta'



GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CONT_AUX]'))
DROP VIEW Cubo_CONT_AUX
GO
CREATE VIEW Cubo_CONT_AUX
--//WITH ENCRYPTION
AS
   SELECT DISTINCT 
	'Estructura'		= Cat.Estructura,
        'EstDescripcion'		= Cat.EstDescripcion,
	'EstEsAcumulativa'	= Cat.EstEsAcumulativa,
	'EstCategoria'		= Cat.EstCategoria,
	'EstFamilia'		= Cat.EstFamilia,
	'EstGrupo'		= Cat.EstGrupo,
	'Mayor'		= Cat.Mayor,
        'MayorDescripcion'	= Cat.MayorDescripcion,
	'MayorEsAcumulativa'	= Cat.MayorEsAcumulativa,
	'MayorCategoria'	= Cat.MayorCategoria,
	'MayorFamilia'		= Cat.MayorFamilia,
	'MayorGrupo'		= Cat.MayorGrupo,
	'Subcuenta'		= Cat.Subcuenta,
        'SubCtaDescripcion'	= Cat.SubctaDescripcion,
	'SubCtaEsAcumulativa'	= Cat.SubCtaEsAcumulativa,
	'SubCtaCategoria'	= CaT.SubCtaCategoria,
	'SubCtaFamilia'	= Cat.SubCtaFamilia,
	'SubCtaGrupo'		= Cat.SubCtaGrupo,
	'Auxiliar'		= Cta.Cuenta,
        'AuxDescripcion'		= Cta.Descripcion,
	'AuxEsAcumulativa'	= Cta.EsAcumulativa,
	'AuxCategoria'		= Cta.Categoria,
	'AuxFamilia'		= Cta.Familia,
	'AuxGrupo'		= Cta.Grupo
   FROM Cta, Cubo_CONT_SUB Cat
   WHERE Cta.Rama = Cat.Subcuenta
	AND Cta.Tipo='Auxiliar'
   UNION
   SELECT DISTINCT 
	'Estructura'		= Cat.Estructura,
        'EstDescripcion'		= Cat.EstDescripcion,
	'EstEsAcumulativa'	= Cat.EstEsAcumulativa,
	'EstCategoria'		= Cat.EstCategoria,
	'EstFamilia'		= Cat.EstFamilia,
	'EstGrupo'		= Cat.EstGrupo,
	'Mayor'		= Cat.Mayor,
        'MayorDescripcion'	= Cat.MayorDescripcion,
	'MayorEsAcumulativa'	= Cat.MayorEsAcumulativa,
	'MayorCategoria'	= Cat.MayorCategoria,
	'MayorFamilia'		= Cat.MayorFamilia,
	'MayorGrupo'		= Cat.MayorGrupo,
	'Subcuenta'		= ' ',
        'SubCtaDescripcion'	= ' ',
	'SubCtaEsAcumulativa'	= ' ',
	'SubCtaCategoria'	= ' ',
	'SubCtaFamilia'	= ' ',
	'SubCtaGrupo'		= ' ',
	'Auxiliar'		= ' ',
        'AuxDescripcion'		= Cta.Descripcion,
	'AuxEsAcumulativa'	= Cta.EsAcumulativa,
	'AuxCategoria'		= Cta.Categoria,
	'AuxFamilia'		= Cta.Familia,
	'AuxGrupo'		= Cta.Grupo
   FROM Cta, Cubo_CONT_MAYOR Cat
   WHERE Cta.Rama = Cat.Mayor
	AND Cta.Tipo='Auxiliar'

GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CONT]'))
DROP VIEW Cubo_CONT
GO
CREATE VIEW Cubo_CONT
--//WITH ENCRYPTION
AS

SELECT 
  'Sucursal' 		= a.Sucursal,
  'SucursalNombre'	= s.Nombre,  
  'SucursalRegion' 	= s.Region, 
  'Empresa'		= a.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  'Clase'		= CASE 	WHEN b.Estructura = ec.CtaIngresos 		THEN 'Ventas'
			       	WHEN b.Estructura = ec.CtaCostoDirecto 		THEN 'Costo de Ventas' 
				WHEN b.Estructura = ec.CtaGastosOperacion 	THEN 'Gastos de Operación'
				WHEN b.Estructura = ec.CtaOtrosGastosProductos 	THEN 'Otros Gastos y productos'
				WHEN b.Estructura = ec.CtaResultados		THEN 'Resultados'
				ELSE 'Resultados' END,
  b.Estructura,
  b.EstDescripcion,
  b.EstEsAcumulativa,
  b.EstCategoria,
  b.EstFamilia,
  b.EstGrupo,
  b.Mayor,
  b.MayorDescripcion,
  b.MayorEsAcumulativa,
  b.MayorCategoria,
  b.MayorFamilia,
  b.MayorGrupo,
  b.Subcuenta,	
  b.SubCtaDescripcion,
  b.SubCtaEsAcumulativa,
  b.SubCtaCategoria,
  b.SubCtaFamilia,
  b.SubCtaGrupo,
  b.Auxiliar,
  b.AuxDescripcion,
  b.AuxEsAcumulativa,
  b.AuxCategoria,
  b.AuxFamilia,
  b.AuxGrupo,
  a.Ejercicio,
  'Periodo'		= CASE WHEN a.Periodo < 10 
				THEN '0' + CONVERT(CHAR(1),a.Periodo)
				ELSE RTRIM(CONVERT(CHAR(2),a.Periodo)) END ,
  a.Moneda,
  a.Grupo,
  a.Cuenta,
  'CentroCosto'		= a.SubCuenta,
  'GrupoCC'		= c.Grupo,
  'SubGrupoCC'		= c.SubGrupo,
  'DescripcionCC'	= c.Descripcion,
  a.Cargos,
  a.Abonos,
  'Presupuesto'		= 0
FROM acum a
	LEFT OUTER JOIN Empresa 	e  	ON a.Empresa  	= e.Empresa 
	LEFT OUTER JOIN Sucursal 	s 	ON a.Sucursal 	= s.Sucursal
	LEFT OUTER JOIN CentroCostos 	c  	ON a.SubCuenta 	= c.CentroCostos
	LEFT OUTER JOIN EmpresaCfg 	ec  	ON a.Empresa 	= ec.Empresa
	           JOIN Cubo_CONT_AUX	b 	ON a.Cuenta 	= b.Auxiliar

WHERE a.rama='CONT' 
	AND b.AuxEsAcumulativa 	= 0 
	AND a.Periodo 	   	> 0
UNION
SELECT 
  'Sucursal' 		= a.Sucursal,
  'SucursalNombre'	= s.Nombre,  
  'SucursalRegion' 	= s.Region, 
  'Empresa'		= a.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  'Clase'		= CASE 	WHEN b.Estructura = ec.CtaIngresos 		THEN 'Ventas'
			       	WHEN b.Estructura = ec.CtaCostoDirecto 		THEN 'Costo de Ventas' 
				WHEN b.Estructura = ec.CtaGastosOperacion 	THEN 'Gastos de Operación'
				WHEN b.Estructura = ec.CtaOtrosGastosProductos 	THEN 'Otros Gastos y productos'
				WHEN b.Estructura = ec.CtaResultados		THEN 'Resultados'
				ELSE 'Resultados' END,
  b.Estructura,
  b.EstDescripcion,
  b.EstEsAcumulativa,
  b.EstCategoria,
  b.EstFamilia,
  b.EstGrupo,
  b.Mayor,
  b.MayorDescripcion,
  b.MayorEsAcumulativa,
  b.MayorCategoria,
  b.MayorFamilia,
  b.MayorGrupo,
  b.Subcuenta,	
  b.SubCtaDescripcion,
  b.SubCtaEsAcumulativa,
  b.SubCtaCategoria,
  b.SubCtaFamilia,
  b.SubCtaGrupo,
  b.Auxiliar,
  b.AuxDescripcion,
  b.AuxEsAcumulativa,
  b.AuxCategoria,
  b.AuxFamilia,
  b.AuxGrupo,
  a.Ejercicio,
  'Periodo'		= CASE WHEN a.Periodo < 10 
				THEN '0' + CONVERT(CHAR(1),a.Periodo)
				ELSE RTRIM(CONVERT(CHAR(2),a.Periodo)) END ,
  a.Moneda,
  a.Grupo,
  a.Cuenta,
  'CentroCosto'		= a.SubCuenta,
  'GrupoCC'		= c.Grupo,
  'SubGrupoCC'		= c.SubGrupo,
  'DescripcionCC'	= c.Descripcion,
  a.Cargos,
  a.Abonos,
  0
FROM acum a
	LEFT OUTER JOIN Empresa 	e  	ON a.Empresa  	= e.Empresa 
	LEFT OUTER JOIN EmpresaCfg 	ec  	ON a.Empresa 	= ec.Empresa
	LEFT OUTER JOIN Sucursal 	s 	ON a.Sucursal 	= s.Sucursal
	LEFT OUTER JOIN CentroCostos 	c  	ON a.SubCuenta 	= c.CentroCostos
                   JOIN Cubo_CONT_SUB	b 	ON a.Cuenta 	= b.SubCuenta
WHERE a.rama='CONT' 
	AND b.SubCtaEsAcumulativa = 0
	AND a.Periodo 	   	  > 0
UNION
SELECT
  'Sucursal' 		= a.Sucursal,
  'SucursalNombre'	= s.Nombre,  
  'SucursalRegion' 	= s.Region, 
  'Empresa'		= a.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  'Clase'		= CASE 	WHEN b.Estructura = ec.CtaIngresos 		THEN 'Ventas'
			       	WHEN b.Estructura = ec.CtaCostoDirecto 		THEN 'Costo de Ventas' 
				WHEN b.Estructura = ec.CtaGastosOperacion 	THEN 'Gastos de Operación'
				WHEN b.Estructura = ec.CtaOtrosGastosProductos 	THEN 'Otros Gastos y productos'
				WHEN b.Estructura = ec.CtaResultados		THEN 'Resultados'
				ELSE 'Resultados' END,
  b.Estructura,
  b.EstDescripcion,
  b.EstEsAcumulativa,
  b.EstCategoria,
  b.EstFamilia,
  b.EstGrupo,
  b.Mayor,
  b.MayorDescripcion,
  b.MayorEsAcumulativa,
  b.MayorCategoria,
  b.MayorFamilia,
  b.MayorGrupo,
  b.Subcuenta,	
  b.SubCtaDescripcion,
  b.SubCtaEsAcumulativa,
  b.SubCtaCategoria,
  b.SubCtaFamilia,
  b.SubCtaGrupo,
  b.Auxiliar,
  b.AuxDescripcion,
  b.AuxEsAcumulativa,
  b.AuxCategoria,
  b.AuxFamilia,
  b.AuxGrupo,
  a.Ejercicio,
  'Periodo'		= CASE WHEN a.Periodo < 10 
				THEN '0' + CONVERT(CHAR(1),a.Periodo)
				ELSE RTRIM(CONVERT(CHAR(2),a.Periodo)) END ,
  a.Moneda,
  NULL,
  a.Cuenta,
  'CentroCosto'		= a.SubCuenta,
  'GrupoCC'		= c.Grupo,
  'SubGrupoCC'		= c.SubGrupo,
  'DescripcionCC'	= c.Descripcion,
  0,
  0,
  a.Presupuesto
FROM Presupuesto a
	LEFT OUTER JOIN Empresa 	e  	ON a.Empresa  	= e.Empresa 
	LEFT OUTER JOIN EmpresaCfg 	ec  	ON a.Empresa 	= ec.Empresa
	LEFT OUTER JOIN Sucursal 	s 	ON a.Sucursal 	= s.Sucursal
	LEFT OUTER JOIN CentroCostos 	c  	ON a.SubCuenta 	= c.CentroCostos
                   JOIN Cubo_CONT_SUB	b 	ON a.Cuenta 	= b.SubCuenta
WHERE a.rama='CONT' 
	AND b.SubCtaEsAcumulativa = 0
	AND a.Periodo 	   	  > 0
UNION
SELECT 
  'Sucursal' 		= a.Sucursal,
  'SucursalNombre'	= s.Nombre,  
  'SucursalRegion' 	= s.Region, 
  'Empresa'		= a.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  'Clase'		= CASE 	WHEN b.Estructura = ec.CtaIngresos 		THEN 'Ventas'
			       	WHEN b.Estructura = ec.CtaCostoDirecto 		THEN 'Costo de Ventas' 
				WHEN b.Estructura = ec.CtaGastosOperacion 	THEN 'Gastos de Operación'
				WHEN b.Estructura = ec.CtaOtrosGastosProductos 	THEN 'Otros Gastos y productos'
				WHEN b.Estructura = ec.CtaResultados		THEN 'Resultados'
				ELSE 'Resultados' END,
  b.Estructura,
  b.EstDescripcion,
  b.EstEsAcumulativa,
  b.EstCategoria,
  b.EstFamilia,
  b.EstGrupo,
  b.Mayor,
  b.MayorDescripcion,
  b.MayorEsAcumulativa,
  b.MayorCategoria,
  b.MayorFamilia,
  b.MayorGrupo,
  b.Subcuenta,	
  b.SubCtaDescripcion,
  b.SubCtaEsAcumulativa,
  b.SubCtaCategoria,
  b.SubCtaFamilia,
  b.SubCtaGrupo,
  b.Auxiliar,
  b.AuxDescripcion,
  b.AuxEsAcumulativa,
  b.AuxCategoria,
  b.AuxFamilia,
  b.AuxGrupo,
  a.Ejercicio,
  'Periodo'		= CASE WHEN a.Periodo < 10 
				THEN '0' + CONVERT(CHAR(1),a.Periodo)
				ELSE RTRIM(CONVERT(CHAR(2),a.Periodo)) END ,
  a.Moneda,
  a.Grupo,
  a.Cuenta,
  'CentroCosto'		= a.SubCuenta,
  'GrupoCC'		= c.Grupo,
  'SubGrupoCC'		= c.SubGrupo,
  'DescripcionCC'	= c.Descripcion,
  a.Cargos,
  a.Abonos,
  'Presupuesto'		= 0
FROM acum a
	LEFT OUTER JOIN Empresa 	e  	ON a.Empresa  	= e.Empresa 
	LEFT OUTER JOIN Sucursal 	s 	ON a.Sucursal 	= s.Sucursal
	LEFT OUTER JOIN CentroCostos 	c  	ON a.SubCuenta 	= c.CentroCostos
	LEFT OUTER JOIN EmpresaCfg 	ec  	ON a.Empresa 	= ec.Empresa
	           JOIN Cubo_CONT_MAYOR	b 	ON a.Cuenta 	= b.Mayor

WHERE a.rama='CONT' 
	AND b.MayorEsAcumulativa 	= 0 
	AND a.Periodo 	   	> 0

GO
