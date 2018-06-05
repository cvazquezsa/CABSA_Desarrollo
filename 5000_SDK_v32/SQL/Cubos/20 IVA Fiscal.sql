/* cubo de IVA fiscal */
EXEC spInsertarCubo 'IVA','IVA','Cubo de IVA Fiscal','Cubo_IVA',0,1
GO
EXEC spInsertarMedida 'IVA','AplicaImporte','Importe Aplicacion','Aplica Importe','aggSum'
EXEC spInsertarMedida 'IVA','IVAFiscalImporte','IVA Fiscal','IVA Fiscal','aggSum'
GO
EXEC spInsertarDimension 'IVA','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'IVA','Movimiento','MovID','Consecutivo','Consecutivo',1
EXEC spInsertarDimensionNivel  'IVA','Movimiento','Mov','Movimiento','Movimiento',2
GO
EXEC spInsertarDimension 'IVA','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel  'IVA','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'IVA','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'IVA','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'IVA','Empresa','EmpresaNombre','Empresa Nombre','Empresa Nombre',2
EXEC spInsertarDimensionNivel  'IVA','Empresa','EmpresaGrupo','Empresa Grupo','Empresa Grupo',3
GO
EXEC spInsertarDimension 'IVA','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'IVA','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'IVA','Sucursal','SucursalNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel  'IVA','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'IVA','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'IVA','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'IVA','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'IVA','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'IVA','Dia Semana','Normal','Dia Semana',1
EXEC spInsertarDimensionNivel  'IVA','Dia Semana','DiaSemana','Dia Semana','DiaSemana',1
GO
EXEC spInsertarDimension 'IVA','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel  'IVA','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'IVA','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'IVA','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'IVA','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'IVA','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'IVA','Referencia','Normal','Referencia',1
EXEC spInsertarDimensionNivel  'IVA','Referencia','Referencia','Referencia','Referencia',1
GO
EXEC spInsertarDimension 'IVA','Contacto','Normal','Contacto',1
EXEC spInsertarDimensionNivel  'IVA','Contacto','Contacto','Contacto','Contacto',1
GO
EXEC spInsertarDimension 'IVA','Nombre','Normal','Nombre',1
EXEC spInsertarDimensionNivel  'IVA','Nombre','Nombre','Nombre','Nombre',1
GO
EXEC spInsertarDimension 'IVA','Aplica','Normal','Aplica',1
EXEC spInsertarDimensionNivel  'IVA','Aplica','Aplica','Aplica','Aplica',1
GO
EXEC spInsertarDimension 'IVA','AplicaId','Normal','AplicaId',1
EXEC spInsertarDimensionNivel  'IVA','AplicaId','AplicaId','AplicaId','AplicaId',1
GO
EXEC spInsertarDimension 'IVA','Dinero','Normal','Dinero',1
EXEC spInsertarDimensionNivel  'IVA','Dinero','Dinero','Dinero','Dinero',1
GO
EXEC spInsertarDimension 'IVA','Conciliado','Normal','Conciliado',1
EXEC spInsertarDimensionNivel  'IVA','Conciliado','Conciliado','Conciliado','Conciliado',1
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_IVA]'))
DROP VIEW Cubo_IVA
GO
CREATE VIEW Cubo_IVA
--//WITH ENCRYPTION
AS 
SELECT
  IVAFiscal.ID,
  'Sucursal' 		= IVAFiscal.Sucursal,
  'SucursalNombre'	= su.Nombre,
  'SucursalRegion' 	= su.Region, 
  'Empresa' 		= IVAFiscal.Empresa,
  'EmpresaNombre'	= e.Nombre,
  'EmpresaGrupo' 	= e.Grupo,
  IVAFiscal.Mov,
  IVAFiscal.MovID,
  IVAFiscal.Referencia,
  IVAFiscal.Moneda,
  IVAFiscal.Contacto,
  IVAFiscal.Nombre,
  IVAFiscal.RFC,
  IVAFiscal.CURP,
  IVAFiscal.FechaEmision,
  IVAFiscal.Aplica,
  IVAFiscal.AplicaID,
  'AplicaImporte'		= IVAFiscal.AplicaImporte * Factor,
  IVAFiscal.AplicaFecha,
  IVAFiscal.IVAFiscalFactor,
  'IVAFiscalImporte'		= IVAFiscal.IVAFiscalImporte * Factor,
  IVAFiscal.Factor,
  IVAFiscal.Dinero,
  IVAFiscal.DineroID,
  IVAFiscal.DineroCtaDinero,
  IVAFiscal.Conciliado,
  IVAFiscal.FechaConciliacion,
  t.trimestre,
  t.Semana,
  'Mes'			= t.MesNombre,
  'Año'			= t.Anio,
  'DiaSemana'		= t.DiaNombre,
  'Dia'			= CASE WHEN DATEPART(d, IVAFiscal.FechaEmision) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, IVAFiscal.FechaEmision))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, IVAFiscal.FechaEmision))) END ,

  Modulo.Modulo,
  'ModuloNombre'	= Modulo.Nombre

FROM 
  IVAFiscal
	
	LEFT OUTER JOIN Modulo  	ON IVAFiscal.Modulo = Modulo.Modulo
			JOIN Tiempo t	ON IVAFiscal.FechaEmision = t.fecha
	LEFT OUTER JOIN Empresa e 	ON IVAFiscal.Empresa  = e.Empresa 
	LEFT OUTER JOIN Sucursal su 	ON IVAFiscal.Sucursal = su.Sucursal 

GO


