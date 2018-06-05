/* CAM */

EXEC spInsertarCubo 'CAM','Cambios','Cubo de Cambios','Cubo_CAM',0,0
GO
EXEC spInsertarMedida 'CAM','Monto','Monto','Monto','aggSum'
EXEC spInsertarMedida 'CAM','TipoCambio','Tipo Cambio','TipoCambio','aggSum'
EXEC spInsertarMedida 'CAM','Cobertura','Cobertura','Cobertura','aggSum'
EXEC spInsertarMedida 'CAM','Spread','Spread','Spread','aggSum'
EXEC spInsertarMedida 'CAM','UtilidadSugerida','Utilidad Sugerida','Utilidad Sugerida','aggSum'
EXEC spInsertarMedida 'CAM','ImporteMN','ImporteMN','ImporteMN','aggSum'
EXEC spInsertarMedida 'CAM','Operaciones','Operaciones','Operaciones','aggDistinctCount'
GO
EXEC spInsertarDimension 'CAM','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'CAM','Movimiento','MovID','Consecutivo','Consecutivo',1
EXEC spInsertarDimensionNivel  'CAM','Movimiento','Mov','Movimiento','Movimiento',2
GO
EXEC spInsertarDimension 'CAM','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel  'CAM','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'CAM','Usuario','Normal','Usuario',1
EXEC spInsertarDimensionNivel  'CAM','Usuario','Usuario','Usuario','Usuario',1
GO
EXEC spInsertarDimension 'CAM','Usuario Nombre','Normal','Usuario Nombre',1
EXEC spInsertarDimensionNivel  'CAM','Usuario Nombre','UsuarioNombre','Usuario Nombre','Usuario Nombre',1
GO
EXEC spInsertarDimension 'CAM','Condicion','Normal','Condicion',1
EXEC spInsertarDimensionNivel  'CAM','Condicion','Condicion','Condicion','Condicion',1
GO
EXEC spInsertarDimension 'CAM','Tipo','Normal','Tipo',1
EXEC spInsertarDimensionNivel  'CAM','Tipo','Tipo','Tipo','Tipo',1
GO
EXEC spInsertarDimension 'CAM','Beneficiario Nombre','Normal','Beneficiario Nombre',1
EXEC spInsertarDimensionNivel  'CAM','Beneficiario Nombre','Beneficiario Nombre','Nombre','Nombre',1
GO
EXEC spInsertarDimension 'CAM','Beneficiario Info','Normal','Beneficiario Info',1
EXEC spInsertarDimensionNivel  'CAM','Beneficiario Info','Beneficiario Info','Info','Info',1
GO
EXEC spInsertarDimension 'CAM','Institucion Pais','Normal','Institucion Pais',1
EXEC spInsertarDimensionNivel  'CAM','Institucion Pais','InstitucionEstado','Estado','Estado',1
EXEC spInsertarDimensionNivel  'CAM','Institucion Pais','InstitucionPais','Pais','Pais',2
GO
EXEC spInsertarDimension 'CAM','Preocupante','Normal','Preocupante',1
EXEC spInsertarDimensionNivel  'CAM','Preocupante','Preocupante','Preocupante','Preocupante',1
GO
EXEC spInsertarDimension 'CAM','Inusual','Normal','Inusual',1
EXEC spInsertarDimensionNivel  'CAM','Inusual','Inusual','Inusual','Inusual',1
GO
EXEC spInsertarDimension 'CAM','Relevante','Normal','Relevante',1
EXEC spInsertarDimensionNivel  'CAM','Relevante','Relevante','Relevante','Relevante',1
GO
EXEC spInsertarDimension 'CAM','Paraiso Fiscal','Normal','Paraiso Fiscal',1
EXEC spInsertarDimensionNivel  'CAM','Paraiso Fiscal','ParaisoFiscal','Paraiso Fiscal','Paraiso Fiscal',1
GO
EXEC spInsertarDimension 'CAM','Ciudad Riesgo','Normal','Ciudad Riesgo',1
EXEC spInsertarDimensionNivel  'CAM','Ciudad Riesgo','CiudadRiesgo','Ciudad Riesgo','Ciudad Riesgo',1
GO
EXEC spInsertarDimension 'CAM','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'CAM','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension 'CAM','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'CAM','Estatus','Situacion','Situacion','Situacion',1
EXEC spInsertarDimensionNivel  'CAM','Estatus','Estatus','Estatus','Estatus',2
GO
EXEC spInsertarDimension 'CAM','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel  'CAM','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'CAM','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'CAM','Cliente','Cliente','Cliente','Cliente',1
GO
EXEC spInsertarDimension 'CAM','Cliente Categoria','Normal','Cliente Categoria',1
EXEC spInsertarDimensionNivel  'CAM','Cliente Categoria','Categoria','Cliente Categoria','Cliente Categoria',1
GO
EXEC spInsertarDimension 'CAM','Cliente Grupo','Normal','Cliente Grupo',1
EXEC spInsertarDimensionNivel  'CAM','Cliente Grupo','Grupo','Cliente Grupo','Cliente Grupo',1
GO
EXEC spInsertarDimension 'CAM','Cliente Familia','Normal','Cliente Familia',1
EXEC spInsertarDimensionNivel  'CAM','Cliente Familia','Familia','Cliente Familia','Cliente Familia',1
GO
EXEC spInsertarDimension 'CAM','Cliente Nombre','Normal','Cliente Nombre',1
EXEC spInsertarDimensionNivel  'CAM','Cliente Nombre','Nombre','Cliente Nombre','Cliente Nombre',2
GO
EXEC spInsertarDimension 'CAM','Agente','Normal','Agente',1
EXEC spInsertarDimensionNivel  'CAM','Agente','Agente','Agente','Agente',1
EXEC spInsertarDimensionNivel  'CAM','Agente','AgenteNombre','Agente Nombre','Agente Nombre',2
EXEC spInsertarDimensionNivel  'CAM','Agente','AgenteGrupo','Agente Grupo','Agente Grupo',3
GO
EXEC spInsertarDimension 'CAM','Ejercicio','Normal','Ejercicio',1
EXEC spInsertarDimensionNivel  'CAM','Ejercicio','Ejercicio','Ejercicio','Ejercicio',1
GO
EXEC spInsertarDimension 'CAM','Periodo','Normal','Periodo',1
EXEC spInsertarDimensionNivel  'CAM','Periodo','Periodo','Periodo','Periodo',1
GO
EXEC spInsertarDimension 'CAM','Instrumento Tipo','Normal','Instrumento Tipo',1
EXEC spInsertarDimensionNivel  'CAM','Instrumento Tipo','InstrumentoTipo','Instrumento Tipo','Instrumento Tipo',1
GO
EXEC spInsertarDimension 'CAM','Instrumento','Normal','Instrumento',1
EXEC spInsertarDimensionNivel  'CAM','Instrumento','Instrumento','Instrumento','Instrumento',1
GO
EXEC spInsertarDimension 'CAM','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'CAM','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'CAM','Institucion','Normal','Institucion',1
EXEC spInsertarDimensionNivel  'CAM','Institucion','Institucion','Institucion','Institucion',1
EXEC spInsertarDimensionNivel  'CAM','Institucion','NombreInstitucion','Institucion Nombre','InstitucionNombre',2
GO
EXEC spInsertarDimension 'CAM','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'CAM','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'CAM','Empresa','EmpresaNombre','Empresa Nombre','Empresa Nombre',2
EXEC spInsertarDimensionNivel  'CAM','Empresa','EmpresaGrupo','Empresa Grupo','Empresa Grupo',3
GO
EXEC spInsertarDimension 'CAM','Sucursal','Normal','UEN',1
EXEC spInsertarDimensionNivel  'CAM','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'CAM','Sucursal','SucursalNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel  'CAM','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'CAM','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'CAM','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'CAM','UEN','UENNombre','Nombre','Nombre',2
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CAM]'))
 DROP VIEW Cubo_CAM
GO
CREATE VIEW Cubo_CAM 
--//WITH ENCRYPTION
AS
SELECT 
  'Operaciones'		= Cambio.Id,
  'Sucursal' 		= CAMBIO.Sucursal,
  'SucursalNombre'	= s.Nombre,  
  'SucursalRegion' 	= s.Region, 
  'Empresa' 		= CAMBIO.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  Cambio.Mov,
  Cambio.MovID,
  Cambio.FechaEmision,
  Cambio.UltimoCambio,
  Cambio.Concepto,
  Cambio.Proyecto,
  Cambio.Usuario,
  Cambio.Autorizacion,
  Cambio.Referencia,
  Cambio.DocFuente,
  Cambio.Observaciones,
  Cambio.Estatus,
  Cambio.Situacion,
  Cambio.SituacionFecha,
  Cambio.Cliente,
  'Nombre'	 	= cte.Nombre,
  cte.Categoria,
  cte.Grupo,
  cte.Familia,
  Cambio.Ruta,
  'Agente' 				= Cambio.Agente,
  'AgenteNombre' 		= ag.Nombre,
  'AgenteGrupo'			= ag.Grupo,
  Cambio.Condicion,
  Cambio.Vencimiento,
  Cambio.OrigenTipo,
  Cambio.Ejercicio,
  Cambio.Periodo,
  Cambio.FechaRegistro,
  Cambio.FechaConclusion,
  Cambio.FechaCancelacion,
  'Preocupante' 	= CASE WHEN Cambio.Preocupante 	= 1 THEN 'Si' ELSE 'No' END ,
  'Inusual' 		= CASE WHEN Cambio.Insusual 	= 1 THEN 'Si' ELSE 'No' END ,
  'Relevante' 		= CASE WHEN Cambio.Relevante	= 1 THEN 'Si' ELSE 'No' END ,
  'ParaisoFiscal' 	= CASE WHEN Cambio.ParaisoFiscal= 1 THEN 'Si' ELSE 'No' END ,
  'CiudadRiesgo' 	= CASE WHEN Cambio.CiudadRiesgo	= 1 THEN 'Si' ELSE 'No' END ,
  CambioD.Renglon,
  CambioD.RenglonSub,
  CambioD.Tipo,
  CambioD.Instrumento,
  Instrumento.Moneda,
  CambioD.Monto,
 'ImporteMN'		= CambioD.Monto * cambioD.TipoCambio,
  CambioD.CoberturaAfectacion,
  CambioD.Beneficiario,
  Cambio.UEN,
  'UENNombre'		= u.Nombre,
  'Beneficiario Nombre' = b.Nombre,
  'Beneficiario Info' 	= b.Info2,
  CambioD.TipoCambio,
  'Cobertura' 		= ISNULL(CambioD.Cobertura,0),
  'Spread' 		= CASE WHEN cambiod.tipo = 'Compra' THEN (ISNULL(CambioD.Cobertura,0) - cambioD.TipoCambio) When  cambiod.tipo = 'Venta' Then (Cambiod.TipoCambio - ISNULL(CambioD.Cobertura,0)) ELSE 0 END ,
  'UtilidadSugerida' 	= CASE WHEN cambiod.tipo = 'Compra' THEN ((ISNULL(CambioD.Cobertura,0) - cambioD.TipoCambio) * CambioD.Monto) When  cambiod.tipo = 'Venta' Then ((Cambiod.TipoCambio - ISNULL(CambioD.Cobertura,0))*CambioD.Monto) ELSE 0 END ,
  Instrumento.Descripcion,
  'InstrumentoTipo'	=Instrumento.Tipo,
  b.Institucion,
  'NombreInstitucion'	= (SELECT Nombre FROM InstitucionFin ii WHERE b.Institucion = ii.Institucion),
  'InstitucionPais' 	= (SELECT Pais 	 FROM InstitucionFin ii WHERE b.Institucion = ii.Institucion), 
  'InstitucionEstado' 	= (SELECT Estado FROM InstitucionFin ii WHERE b.Institucion = ii.Institucion),
  'UsuarioNombre'	= usu.Nombre

FROM 
  Cambio

LEFT OUTER JOIN  CambioD 	ON Cambio.ID  		= CambioD.ID  
LEFT OUTER JOIN  Cte	 	ON Cambio.Cliente 	= cte.Cliente  
LEFT OUTER JOIN  Sucursal s	ON Cambio.Sucursal 	= s.Sucursal  
LEFT OUTER JOIN  Empresa e	ON Cambio.Empresa 	= e.Empresa
LEFT OUTER JOIN  Agente ag  	ON cambio.Agente  	= ag.Agente
LEFT OUTER JOIN  Beneficiario b	ON CambioD.Beneficiario = b.Beneficiario 
	   JOIN  Instrumento 	ON CambioD.Instrumento 	= Instrumento.Instrumento 
LEFT OUTER JOIN  UEN u		ON Cambio.UEN	 	= u.UEN
LEFT OUTER JOIN  Usuario usu	ON Cambio.Usuario	= usu.Usuario
GO


