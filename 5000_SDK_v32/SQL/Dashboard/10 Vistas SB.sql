--- 05-Ene-2004 Ver. 1.0.1 SB.EXE 1.2.0 Genera las vistas para cada proceso para ScoreBoard
SET QUOTED_IDENTIFIER OFF
GO

--- Vista de Nomina para el Score Board 12-01-2004
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SB_NOM]'))
	DROP VIEW SB_NOM
GO	
CREATE VIEW SB_NOM
 --//WITH ENCRYPTION 
 AS SELECT 
 n.Id,n.Sucursal,n.Empresa, n.Mov,  n.MovID,  n.FechaEmision, n.Moneda, n.Situacion,  n.Estatus,
 n.SituacionFecha,  n.Ejercicio,  n.Periodo,   n.Condicion,  n.PeriodoTipo, d.Personal,d.Cuenta,  
 d.Cantidad, d.Concepto, d.FormaPago, d.Porcentaje, d.Movimiento, 
 'PersonalNombre' 	= RTRIM(p.Nombre) + ' ' + RTRIM(p.ApellidoPaterno) + ' ' +RTRIM(ApellidoMaterno),
  p.Tipo, p.Sexo, p.CentroCostos, p.Departamento, p.Puesto, p.Categoria, p.Grupo, p.TipoContrato, p.FechaAlta,
  p.UEN, 'EstatusPersonal' = p.Estatus,
  'Importe'= ISNULL(d.Importe,0) * mt.Factor ,  'Saldo'  = ISNULL(d.Saldo,0) * mt.factor
FROM 
  NOMINA n

	LEFT OUTER JOIN NOMINAD d 	ON n.ID		= d.ID
	LEFT OUTER JOIN Personal p 	ON d.Personal 	= p.Personal
	LEFT OUTER JOIN MovTipo	mt 	ON n.Mov  	= mt.Mov  

WHERE n.Estatus = 'CONCLUIDO' AND mt.Modulo = 'NOM'
GO
--- Vista de ventas para el Score Board 5-01-2004
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SB_VTAS]'))
	DROP VIEW SB_VTAS 
GO	
CREATE VIEW SB_VTAS 
 --//WITH ENCRYPTION 
 AS SELECT 
	 v.ID, v.Sucursal,v.Empresa, v.Mov, v.MovID, v.Moneda, v.TipoCambio, v.Concepto, 
	 v.Proyecto, v.usuario, v.FechaEmision, v.Estatus, v.Agente, v.UEN, v.Almacen, vd.Articulo, 
	a.Fabricante,a.Familia,a.Grupo,a.Categoria,a.Linea,
	 'CantidadNeta' 	= VD.CantidadNeta * MT.Factor, 
	 'CostoTotal' 		= VD.CostoTotal * mt.Factor * TipoCambio , 
	 'Importe' 		= Convert(money, ROUND(dbo.fnSubTotal(vd.Importe, v.DescuentoGlobal, v.SobrePrecio), 2)) * MT.Factor * TipoCambio 
 FROM Venta v 
	LEFT OUTER JOIN VentaDCalc vd	ON v.Id	= vd.Id 
	LEFT OUTER JOIN MovTipo	mt 	ON v.Mov  = mt.Mov  
	LEFT OUTER JOIN Art	a 	ON vd.Articulo  = a.Articulo  
 WHERE mt.Modulo = 'VTAS' 
GO

--- Vista de Gastos para el Score Board 5-01-2004
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SB_GAS]'))
DROP VIEW SB_GAS
GO
CREATE VIEW SB_GAS
--//WITH ENCRYPTION
AS
SELECT
	gasto.Id, gasto.Sucursal, gasto.Empresa, gasto.Acreedor, gasto.Mov, gasto.MovID, gasto.FechaEmision,
	gasto.FechaRequerida, gasto.Proyecto,gasto.Moneda, gasto.Tipocambio, gasto.Clase, gasto.SubClase,
	gasto.Estatus, gasto.Situacion, gasto.Condicion, gasto.Vencimiento, gasto.FormaPago, gasto.Usuario,
	gasto.CtaDinero, gasto.Ejercicio, gasto.Periodo, gasto.UEN, d.Concepto, d.Referencia, d.Precio, d.ContUso, 
	'Cantidad'	= ISNULL(d.Cantidad, 0.0),
	'ImporteEnPesos'   	= ISNULL(d.Importe, 0.0) * mt.Factor * Tipocambio,
	'Importe'   		= ISNULL(d.Importe, 0.0) * mt.Factor ,
	'Impuestos'  		= ISNULL(d.Impuestos, 0.0) * mt.Factor ,
	'Retencion'  		= (ISNULL(d.Retencion, 0.0) + ISNULL(d.Retencion2, 0.0)) * mt.Factor ,
	'ImporteTotal'      	= (ISNULL(d.Importe, 0.0) - ISNULL(d.Retencion, 0.0) - ISNULL(d.Retencion2, 0.0) + ISNULL(d.Impuestos, 0.0)) * mt.Factor * TipoCambio
FROM Gasto 	
	LEFT OUTER JOIN GastoD d 	ON gasto.ID 	  = d.ID
	LEFT OUTER JOIN MovTipo mt 	ON gasto.Mov      = mt.Mov  
WHERE mt.Modulo = 'GAS'
GO

--- Vista de CXC para el Score Board 7-01-2004
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SB_CXC]'))
DROP VIEW SB_CXC
GO
CREATE VIEW SB_CXC
--//WITH ENCRYPTION
AS
SELECT
  Cxc.ID,  cxc.Sucursal, cxc.Empresa,  Cxc.Mov, Cxc.FechaEmision,  cxc.UEN,  Cxc.Proyecto,
  Cxc.Moneda,  Cxc.TipoCambio,  Cxc.Usuario,  Cxc.Concepto,  Cxc.Estatus, 
  Cxc.Agente,   Cxc.Condicion,
  'SaldoEnPesos' 	= ISNULL(Cxc.Saldo,0)	* mt.Factor * cxc.TipoCambio 
FROM
  Cxc
LEFT OUTER JOIN MovTipo mt 	ON Cxc.Mov 		= mt.Mov 
LEFT OUTER JOIN MovClave mc 	ON mc.Modulo 		= mt.Modulo 
				AND mc.Clave 		= mt.Clave
WHERE
  Cxc.Estatus IN ('PENDIENTE')  AND mt.Modulo = 'CXC' 
GO

--- Vista de Compras para el Score Board 7-01-2004
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SB_COMS]'))
DROP VIEW SB_COMS
GO
CREATE VIEW SB_COMS
--//WITH ENCRYPTION
AS
SELECT   
  co.id,co.Sucursal,co.Empresa, co.Mov,  co.MovID,
  co.Moneda, co.TipoCambio, co.Concepto, co.Referencia, co.Proyecto, 
  co.FechaRegistro,  co.Estatus,  co.Situacion,co.Proveedor, 
  co.FormaEnvio, co.Condicion,	  co.Vencimiento,
  co.Almacen, cod.Articulo, 
  'Cantidad' 	= CONVERT(float, cod.CantidadNeta	* mt.Factor), 
  'Impuestos' 	= Convert(money, ROUND((cod.Importe*(100-ISNULL(co.DescuentoGlobal, 0.0))/100) * (ImpuestosPorcentaje/100), 2)) + ISNULL(ImpuestosImporte, 0.0),
  'ImporteTotal' = Convert(money, ROUND((cod.Importe*(100-ISNULL(co.DescuentoGlobal, 0.0))/100) * (1+(ImpuestosPorcentaje/100)), 2)),
  co.FechaRequerida,  co.FechaConclusion,  co.FechaEntrega,  co.EmbarqueEstado,  co.FechaEmision,
  co.Peso,  co.Volumen,  co.ZonaImpuesto,  co.Prioridad,  co.SituacionFecha,
  a.Fabricante,a.Familia,a.Grupo,a.Categoria,a.Linea,
  co.Usuario,	  co.Causa, co.UEN,co.agente

FROM 
  Compra co 
	LEFT OUTER JOIN CompraDCalc cod	ON co.Id	= cod.Id 		
	LEFT OUTER JOIN MovTipo mt 	ON co.Mov 	= mt.Mov 
	LEFT OUTER JOIN Art	a 	ON cod.Articulo  = a.Articulo
WHERE  mt.Modulo = 'COMS'
GO

--- Vista de Cxp para el Score Board 7-01-2004
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SB_CXP]'))
DROP VIEW SB_CXP
GO
CREATE VIEW SB_CXP 
--//WITH ENCRYPTION
AS
SELECT
  Cxp.ID, cxP.Sucursal,cxP.Empresa, CxP.Mov, Cxp.MovID, Cxp.FechaEmision, Cxp.Concepto, Cxp.Referencia, Cxp.Observaciones,
  Cxp.Proyecto, Cxp.Moneda, Cxp.TipoCambio, Cxp.Usuario, Cxp.Estatus, Cxp.Situacion,  Cxp.SituacionFecha, cxp.Proveedor,
  Cxp.Condicion,  Cxp.Vencimiento,  Cxp.FormaPago,  Cxp.CtaDinero, cxp.UEN,
  'Importe'	= cxp.importe * mt.Factor * Cxp.TipoCambio
FROM
  Cxp
	LEFT OUTER JOIN MovTipo mt 	ON mt.Mov 	 = Cxp.Mov

WHERE
  Cxp.Estatus IN ('PENDIENTE', 'CONCLUIDO') 
 AND mt.Modulo = 'CXP'
GO

--- Vista de Atencion a Clientes para el Score Board 7-01-2004
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SB_STCTE]'))
DROP VIEW SB_STCTE
GO
CREATE VIEW SB_STCTE
--//WITH ENCRYPTION
AS
SELECT 
  s.ID, S.Sucursal, s.Empresa,  s.Mov,  s.MovID,  s.UltimoCambio,  s.Concepto,  s.Proyecto, s.UsuarioResponsable,
  s.Autorizacion,  s.Referencia,  s.Observaciones,  s.Cliente,  s.EnviarA,  s.Agente,  s.Estado,  s.Contacto,
  s.Vencimiento,  s.TieneContrato,  s.PuedeDevolver,  s.Prioridad,  s.Clase,  s.Subclase,
  s.situacion,  s.SituacionFecha,  'Problema'= CONVERT(VARCHAR(100),s.Problema),  
  'Solucion'= CONVERT(VARCHAR(100),s.Solucion), 'Comentarios'= CONVERT(VARCHAR(100),s.Comentarios),
  s.TiempoUnidad,  s.Importe,  s.CondicionPago,  s.CondicionEntrega,  s.OrigenTipo,  s.Origen,  s.OrigenID,
  s.Poliza,  s.PolizaID,  s.GenerarPoliza,  s.ContID,  s.Ejercicio,  s.Periodo,  s.FechaRegistro,  s.FechaEmision,
  s.FechaCancelacion,  s.Version,  s.Proveedor,  s.Personal,  s.UEN,  s.SubModulo,  s.fuente,  s.Medio,  s.Elemento,
  s.Titulo,  s.Estatus,  'Cantidad'		= 1

FROM 
  Soporte s 
GO




