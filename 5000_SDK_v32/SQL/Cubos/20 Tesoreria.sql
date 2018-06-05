/*DIN*/ 
EXEC spInsertarCubo 'DIN','Tesoreria','Cubo de Tesoreria','Cubo_DIN',0,1
GO
EXEC spInsertarMedida 'DIN','Importe','Importe','Importe','aggSum'
EXEC spInsertarMedida 'DIN','ImporteEnPesos','Importe en Pesos','ImporteEnPesos','aggSum'
EXEC spInsertarMedida 'DIN','Comisiones','Comisiones','Comisiones','aggSum'
EXEC spInsertarMedida 'DIN','Impuestos','Impuestos','Impuestos','aggSum'
EXEC spInsertarMedida 'DIN','Saldo','Saldo','Saldo','aggSum'
GO
EXEC spInsertarDimension 'DIN','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel  'DIN','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'DIN','Forma Pago','Normal','Forma Pago',1
EXEC spInsertarDimensionNivel  'DIN','Forma Pago','FormaPago','Forma Pago','Forma Pago',1
GO
EXEC spInsertarDimension 'DIN','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'DIN','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension 'DIN','Referencia','Normal','Referencia',0
EXEC spInsertarDimensionNivel  'DIN','Referencia','Referencia','Referencia','Referencia',1
GO
EXEC spInsertarDimension 'DIN','Observaciones','Normal','Observaciones',0
EXEC spInsertarDimensionNivel  'DIN','Observaciones','Observaciones','Observaciones','Observaciones',1
GO
EXEC spInsertarDimension 'DIN','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'DIN','Estatus','Estatus','Estatus','Estatus',1
EXEC spInsertarDimensionNivel  'DIN','Estatus','Situacion','Situacion','Situacion',1
GO
EXEC spInsertarDimension 'DIN','Nombre Beneficiario','Normal','Nombre Beneficiario',0
EXEC spInsertarDimensionNivel  'DIN','Nombre Beneficiario','BeneficiarioNombre','Nombre Beneficiario','Nombre Beneficiario',1
GO
EXEC spInsertarDimension 'DIN','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'DIN','Movimiento','MovID','Consecutivo','Consecutivo',1
EXEC spInsertarDimensionNivel  'DIN','Movimiento','Mov','Movimiento','Movimiento',2
EXEC spInsertarDimensionNivel  'DIN','Movimiento','MovGrupo','Grupo','Grupo Movimiento',3
GO
EXEC spInsertarDimension 'DIN','Fecha Emision','Tiempo','FechaEmision',1
EXEC spInsertarDimensionNivel  'DIN','Fecha Emision','FechaEmision','FechaEmision','FechaEmision',1
GO
EXEC spInsertarDimension 'DIN','Fecha','Normal','Fecha',1
EXEC spInsertarDimensionNivel  'DIN','Fecha','FechaEmision','Fecha','Fecha',1
GO
EXEC spInsertarDimension 'DIN','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'DIN','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'DIN','Empresa','Normal','Empresa',1
EXEC spInsertarDimension 'DIN','Sucursal','Normal','Sucursal',1
GO
EXEC spInsertarDimension 'DIN','Cuenta','Normal','Cuenta',1
EXEC spInsertarDimensionNivel  'DIN','Cuenta','Cuenta','Cuenta','Cuenta',1
GO
EXEC spInsertarDimension 'DIN','Conciliado','Normal','Conciliado',0
EXEC spInsertarDimensionNivel  'DIN','Conciliado','Conciliado','Conciliado','Conciliado',1
GO
EXEC spInsertarDimensionNivel  'DIN','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'DIN','Empresa','EmpresaNombre','Empresa Nombre','Empresa Nombre',2
EXEC spInsertarDimensionNivel  'DIN','Empresa','EmpresaGrupo','Empresa Grupo','Empresa Grupo',3
GO
EXEC spInsertarDimensionNivel  'DIN','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'DIN','Sucursal','SucursalNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel  'DIN','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'DIN','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'DIN','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'DIN','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'DIN','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'DIN','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel  'DIN','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'DIN','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'DIN','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'DIN','Año','Normal','Año',1
EXEC spInsertarDimensionNivel  'DIN','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'DIN','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'DIN','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'DIN','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension 'DIN','Tipo Cambio','Normal','Tipo Cambio',1
EXEC spInsertarDimensionNivel  'DIN','Tipo Cambio','TipoCambio','Tipo Cambio','Tipo Cambio',1
GO
EXEC spInsertarDimension 'DIN','Cuenta Nombre','Normal','Cuenta Nombre',1
EXEC spInsertarDimensionNivel  'DIN','Cuenta Nombre','CtaNombre','Cuenta Nombre','Cuenta Nombre',1
GO
EXEC spInsertarDimension 'DIN','Beneficiario','Normal','Beneficiario',1
EXEC spInsertarDimensionNivel  'DIN','Beneficiario','BeneficiarioNombre','Beneficiario','Beneficiario',1
GO
EXEC spInsertarDimension 'DIN','Cliente Categoria','Normal','Cliente Categoria',1
EXEC spInsertarDimension 'DIN','Cliente Familia','Normal','Cliente Familia',1
EXEC spInsertarDimension 'DIN','Cliente Grupo','Normal','Cliente Grupo',1
EXEC spInsertarDimension 'DIN','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'DIN','Cliente Categoria','ClienteCategoria','Cliente Categoria','Cliente Categoria',1
EXEC spInsertarDimensionNivel  'DIN','Cliente Familia','ClienteFamilia','Cliente Familia','Cliente Familia',1
EXEC spInsertarDimensionNivel  'DIN','Cliente Grupo','ClienteGrupo','Cliente Grupo','Cliente Grupo',1
EXEC spInsertarDimensionNivel  'DIN','Cliente','Cliente','Cliente','Cliente',1
GO
EXEC spInsertarDimension 'DIN','Cliente Nombre','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'DIN','Cliente Nombre','ClienteNombre','Cliente Nombre','Cliente Nombre',2
GO
EXEC spInsertarDimension 'DIN','Cliente Tipo','Normal','Cliente Tipo',1
EXEC spInsertarDimensionNivel 'DIN','Cliente Tipo','ClienteTipo','Cliente Tipo','Cliente Tipo',1
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_DIN]'))
DROP VIEW Cubo_DIN
GO
CREATE VIEW Cubo_DIN
--//WITH ENCRYPTION
AS
SELECT
  Dinero.ID,
  'Sucursal' 		= dinero.Sucursal,
  'SucursalNombre'	= su.Nombre,  
  'SucursalRegion' 	= su.Region, 
  'Empresa' 		= Dinero.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  'MovGrupo' 		= mc.Grupo,
  Mov 			= Dinero.Mov,
  MovID 		= Dinero.MovID,
  Dinero.FechaEmision,
  Dinero.Concepto,
  Dinero.Proyecto,
  Dinero.Moneda,
  Dinero.TipoCambio,
  Dinero.Estatus,
  Dinero.FormaPago,
  Dinero.Ejercicio,
  Dinero.Periodo,
  Dinero.Referencia,                                          
  Dinero.Observaciones,                                                                                        
  Dinero.Usuario,    
  Dinero.Autorizacion, 
  Dinero.Situacion,                                          
  Dinero.SituacionFecha,                                         
  Dinero.Directo, 
  Dinero.BeneficiarioNombre,                                                                                   
  Dinero.Beneficiario, 
  Dinero.CtaDinero,  
  Dinero.CtaDineroDestino,                
  Dinero.FechaProgramada,                                        
  Dinero.OrigenTipo,    
  Dinero.FechaRegistro,                                          
  Dinero.FechaConclusion,                                        
  Dinero.FechaCancelacion,                                       
  Dinero.FechaEntrega,                                           
  Dinero.EmbarqueEstado,                                     
  Dinero.InstitucionMensaje, 
  Dinero.InstitucionSucursal, 
  Dinero.InstitucionReferencia1,                             
  Dinero.InstitucionReferencia2,                             
  Dinero.Cajero,
  'Cliente' 		= c.Cliente, 
  'ClienteNombre' 	= c.Nombre,
  'ClienteFamilia' 	= c.Familia,
  'ClienteCategoria' 	= c.Categoria,
  'ClienteGrupo' 	= c.Grupo,
  'ClienteTipo'		= c.Tipo,
  t.trimestre,
  t.Semana,
  'Año'			= t.Anio,
  'Mes'			= t.MesNombre,
  'DiaSemana'		= t.DiaNombre,
  'Dia'			= CASE WHEN DATEPART(d, Dinero.FechaEmision) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, Dinero.FechaEmision))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, Dinero.FechaEmision))) END ,
  Dinero.UEN,
  'uenNombre' 		= uen.Nombre,           
  'Cuenta' 		= Dinero.CtaDinero,
  'CtaNombre'		= CtaDinero.Descripcion,
  'Conciliado'		= CASE WHEN Dinero.Conciliado = 1 THEN 'Si' ELSE 'No' END,
  'ImporteEnPesos'	= Dinero.Importe 	* MovTipo.Factor * Dinero.TipoCambio,
  'Importe' 		= Dinero.Importe 	* MovTipo.Factor ,
  'Comisiones' 		= Dinero.Comisiones 	* MovTipo.Factor ,
  'Impuestos' 		= Dinero.Impuestos 	* MovTipo.Factor ,
  'Saldo' 		= Dinero.Saldo 		* MovTipo.Factor 
FROM
  Dinero

LEFT OUTER JOIN CtaDinero	ON Dinero.CtaDinero 	= CtaDinero.CtaDinero
LEFT OUTER JOIN MovTipo 	ON Dinero.Mov 	    	= Movtipo.Mov
	   JOIN MovClave mc 	ON mc.Modulo 	 	= movtipo.Modulo 
				AND mc.Clave 	 	= movtipo.Clave
LEFT OUTER JOIN sucursal su	ON Dinero.Sucursal  	= su.Sucursal
LEFT OUTER JOIN cxc 		ON Dinero.Origen  	= cxc.Mov
				AND Dinero.Origenid  	= cxc.MovId
				AND Dinero.Empresa	= cxc.Empresa
				AND Dinero.origentipo	= 'cxc'
LEFT OUTER JOIN cte	c	ON cxc.Cliente  	= c.Cliente
LEFT OUTER JOIN empresa e	ON Dinero.Empresa   	= e.empresa
	   JOIN Tiempo t	ON Dinero.FechaEmision 	= t.fecha
LEFT OUTER JOIN UEN uen	   	ON Dinero.uen	 	= uen.uen	

WHERE 
   MovTipo.Modulo = 'DIN'  
GO

