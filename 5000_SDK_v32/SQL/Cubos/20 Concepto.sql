/* Maestro de conceptos */
EXEC spInsertarCubo  'CPTOGAS','Maestro de Conceptos de Gastos','Cubo de Conceptos','Cubo_CPTOGAS',0,1
GO 
EXEC spInsertarMedida 'CPTOGAS','NoConcepto','No Concepto','NoConcecpto','aggSum'
GO
EXEC spInsertarDimension 'CPTOGAS','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'CPTOGAS','PorcentajeDeducible','Normal','PorcentajeDeducible',1
EXEC spInsertarDimensionNivel  'CPTOGAS','PorcentajeDeducible','PorcentajeDeducible','PorcentajeDeducible','PorcentajeDeducible',1
GO
EXEC spInsertarDimension 'CPTOGAS','Con Sueldo','Normal','ConSueldo',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Con Sueldo','ConSueldo','Con Sueldo','ConSueldo',1
GO
EXEC spInsertarDimension 'CPTOGAS','Cuenta','Normal','Cuenta',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Cuenta','Cuenta','Cuenta','Cuenta',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Cuenta','Descripcion','Descripcion','Descripcion',2
GO
EXEC spInsertarDimension 'CPTOGAS','Impuestos','Normal','Impuestos',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Impuestos','Impuestos','Impuestos','Impuestos',1
GO
EXEC spInsertarDimension 'CPTOGAS','Retencion ISR','Normal','Retencion ISR',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Retencion ISR','Retencion','Retencion ISR','Retencion ISR',1
GO
EXEC spInsertarDimension 'CPTOGAS','Retencion IVA','Normal','Retencion IVA',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Retencion IVA','Retencion2','Retencion IVA','Retencion IVA',1
GO
EXEC spInsertarDimension 'CPTOGAS','Clase','Normal','Clase',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Clase','Clase','Clase','Clase',1
GO
EXEC spInsertarDimension 'CPTOGAS','SubClase','Normal','SubClase',1
EXEC spInsertarDimensionNivel  'CPTOGAS','SubClase','SubClase','SubClase','SubClase',1
GO
EXEC spInsertarDimension 'CPTOGAS','Tipo','Normal','Tipo',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Tipo','Tipo','Tipo','Tipo',1
GO
EXEC spInsertarDimension 'CPTOGAS','Actividad','Normal','Actividad',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Actividad','Actividad','Actividad','Actividad',1
GO
EXEC spInsertarDimension 'CPTOGAS','Tipo Prorrateo','Normal','TipoProrrateo',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Tipo Prorrateo','TipoProrrateo','Tipo Prorrateo','TipoProrrateo',1
GO
EXEC spInsertarDimension 'CPTOGAS','Proveedor','Normal','Proveedor',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Proveedor','Proveedor','Proveedor','Proveedor',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Proveedor','ProvNombre','Prov Nombre','ProvNombre',2
GO
EXEC spInsertarDimension 'CPTOGAS','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension 'CPTOGAS','Presupuesto','Normal','Presupuesto',1
EXEC spInsertarDimensionNivel  'CPTOGAS','Presupuesto','ValidarPresupuesto','Presupuesto','Presupuesto',1
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CPTOGAS]'))
DROP VIEW Cubo_CPTOGAS
GO
CREATE VIEW Cubo_CPTOGAS
--//WITH ENCRYPTION
AS
SELECT 
  Concepto.Modulo,
  Concepto.Concepto,
  Concepto.PorcentajeDeducible,
  Concepto.ConSueldo,
  Concepto.Orden,
  Concepto.Bloqueo,
  Concepto.Cuenta,
  Concepto.Impuestos,
  Concepto.Retencion,
  Concepto.Retencion2,
  Concepto.Clase,
  Concepto.SubClase,
  Concepto.ValidarPresupuesto,
  Concepto.Tipo,
  Concepto.Actividad,
  Concepto.AcreedorDef,
  Concepto.Indirecto,
  Concepto.NivelAcceso,
  Concepto.TipoProrrateo,
  Concepto.EstimuloFiscal,
  Cta.Descripcion,
  Cta.Estatus,
  'Proveedor'		= Prov.Proveedor,
  'ProvNombre'		= Prov.Nombre,
  'NoConcepto'		= 1
FROM 
  Concepto 

LEFT OUTER JOIN Cta  	ON Concepto.Cuenta  	= Cta.Cuenta 
LEFT OUTER JOIN Prov  	ON Concepto.AcreedorDef = Prov.Proveedor

WHERE Modulo = 'GAS'

GO


