/* CXC */
EXEC spLimpiarCubo 'CXC'
EXEC spInsertarCubo 'CXC','Cuentas por Cobrar','Cuentas por Cobrar','Cubo_CXC',0,1
GO
EXEC spInsertarMedida 'CXC','Importe','Importe','Importe','aggSum'
EXEC spInsertarMedida 'CXC','ImporteEnPesos','Importe en Pesos','ImporteEnPesos','aggSum'
EXEC spInsertarMedida 'CXC','Impuestos','Impuestos','Impuestos','aggSum'
EXEC spInsertarMedida 'CXC','ImporteTotal','Importe Total','Importe Total','aggSum'
EXEC spInsertarMedida 'CXC','Saldo','Saldo','Saldo','aggSum'
EXEC spInsertarMedida 'CXC','SaldoEnPesos','SaldoEnPesos','SaldoEnPesos','aggSum'
EXEC spInsertarMedida 'CXC','Moratorios','Moratorios','Moratorios','aggSum'
EXEC spInsertarMedida 'CXC','Retencion','Retencion','Retencion','aggSum'
EXEC spInsertarMedida 'CXC','Throughput','Throughput','Throughput','aggSum'
EXEC spInsertarMedida 'CXC','DiasRetraso','Dias Retraso','Dias Retraso','aggSum'
EXEC spInsertarMedida 'CXC','HabitoDiasEmision','Habito Dias Emision','Habito Dias Emision','aggSum'
EXEC spInsertarMedida 'CXC','HabitoDiasRetraso','Habito Dias Retraso','Habito Dias Retraso','aggSum'
EXEC spInsertarMedida 'CXC','DiasVencido','Dias Cartera Vencido','DiasVencido','aggSum'
EXEC spInsertarMedida 'CXC','DiasNormales','Dias Cartera','DiasNormales','aggSum'
GO
/*	Se le agrgo la dimensión MovId		Víctor Gutiérrez Méndez*/
EXEC spInsertarDimension 'CXC','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel 'CXC','Movimiento','MovId','MovId','MovId',1
EXEC spInsertarDimensionNivel 'CXC','Movimiento','Mov','Movimiento','Movimiento',2
EXEC spInsertarDimensionNivel 'CXC','Movimiento','MovGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'CXC','Cliente Sucursal','Normal','Cliente Sucursal',1
EXEC spInsertarDimensionNivel 'CXC','Cliente Sucursal','ClienteSucursal','Cliente Sucursal','ClienteSucursal',1
GO
EXEC spInsertarDimension 'CXC','Antigüedad Saldo','Normal','Antigüedad Saldo',1
EXEC spInsertarDimensionNivel 'CXC','Antigüedad Saldo','AntigüedadSaldo','Antigüedad Saldo','AntigüedadSaldo',1
GO
EXEC spInsertarDimension 'CXC','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel 'CXC','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'CXC','Cobrador','Normal','Cobrador',1
EXEC spInsertarDimensionNivel 'CXC','Cobrador','Cobrador','Cobrador','Cobrador',1
GO
EXEC spInsertarDimension 'CXC','Cobrador Nombre','Normal','CobradorNombre',1
EXEC spInsertarDimensionNivel 'CXC','Cobrador Nombre','CobradorNombre','Cobrador Nombre','CobradorNombre',1
GO
EXEC spInsertarDimension 'CXC','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel 'CXC','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension 'CXC','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel 'CXC','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'CXC','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel 'CXC','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension 'CXC','Situacion','Normal','Situacion',1
EXEC spInsertarDimensionNivel 'CXC','Situacion','Situacion','Situacion','Situacion',1
GO
EXEC spInsertarDimension 'CXC','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel 'CXC','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'CXC','FechaVencimiento','Tiempo','FechaVencimiento',1
EXEC spInsertarDimensionNivel 'CXC','FechaVencimiento','FechaVencimiento','FechaVencimiento','FechaVencimiento',1
GO
/*	Se le agrego la dimensión Vencimiento		Víctor Gutiérrez Méndez */
EXEC spInsertarDimension 'CXC','Vencimiento','Tiempo','Vencimiento',1
EXEC spInsertarDimensionNivel 'CXC','Vencimiento','Vencimiento','Vencimiento','Vencimiento',1
GO
EXEC spInsertarDimension 'CXC','Esta Vencido','Normal','Esta Vencido',1
EXEC spInsertarDimensionNivel 'CXC','Esta Vencido','EstaVencido','EstaVencido','EstaVencido',1
GO
EXEC spInsertarDimension 'CXC','Estatus Saldo','Normal','Estatus Saldo',1
EXEC spInsertarDimensionNivel 'CXC','Estatus Saldo','EstatusSaldo','Estatus Saldo','Estatus Saldo',1
GO
EXEC spInsertarDimension 'CXC','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel 'CXC','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel 'CXC','Empresa','EmpresaNombre','Empresa Nombre','Empresa',2
EXEC spInsertarDimensionNivel 'CXC','Empresa','EmpresaGrupo','Empresa Grupo','GrupoEmpresa',3
GO
EXEC spInsertarDimension 'CXC','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel 'CXC','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel 'CXC','Sucursal','SucursalNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel 'CXC','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'CXC','Cliente Categoria','Normal','Cliente Categoria',1
EXEC spInsertarDimensionNivel 'CXC','Cliente Categoria','ClienteCategoria','Cliente Categoria','Cliente Categoria',1
GO
EXEC spInsertarDimension 'CXC','Cliente Familia','Normal','Cliente Familia',1
EXEC spInsertarDimensionNivel 'CXC','Cliente Familia','ClienteFamilia','Cliente Familia','Cliente Familia',1
GO
EXEC spInsertarDimension 'CXC','Cliente Grupo','Normal','Cliente Grupo',1
EXEC spInsertarDimensionNivel 'CXC','Cliente Grupo','ClienteGrupo','Cliente Grupo','Cliente Grupo',1
GO
EXEC spInsertarDimension 'CXC','Cliente','Normal','Cliente Clave',1
EXEC spInsertarDimensionNivel 'CXC','Cliente','Cliente','Cliente','Cliente',1
GO
EXEC spInsertarDimension 'CXC','Cliente Nombre','Normal','Cliente Nombre',1
EXEC spInsertarDimensionNivel 'CXC','Cliente Nombre','ClienteNombre','Cliente Nombre','Cliente Nombre',1
GO
EXEC spInsertarDimension 'CXC','Agente','Normal','Agente',1
EXEC spInsertarDimensionNivel 'CXC','Agente','Agente','Agente','Agente',1
EXEC spInsertarDimensionNivel 'CXC','Agente','AgenteNombre','Agente Nombre','AgenteNombre',2
EXEC spInsertarDimensionNivel 'CXC','Agente','AgenteGrupo','Agente Grupo','AgenteGrupo',3
GO
EXEC spInsertarDimension 'CXC','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'CXC','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'CXC','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'CXC','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'CXC','Año','Normal','Año',1
EXEC spInsertarDimensionNivel  'CXC','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'CXC','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'CXC','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'CXC','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel  'CXC','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'CXC','Cliente Tipo','Normal','Cliente Tipo',1
EXEC spInsertarDimensionNivel 'CXC','Cliente Tipo','ClienteTipo','Cliente Tipo','Cliente Tipo',1
GO
EXEC spInsertarDimension 'CXC','Tipo Cambio','Normal','Tipo Cambio',1
EXEC spInsertarDimensionNivel  'CXC','Tipo Cambio','TipoCambio','Tipo Cambio','Tipo Cambio',1
GO
EXEC spInsertarDimension 'CXC','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'CXC','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'CXC','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension 'CXC','UENPersonal','Normal','UENPersonal',1
EXEC spInsertarDimensionNivel  'CXC','UENPersonal','UENPersonal','UENPersonal','UENPersonal',1
GO
EXEC spInsertarDimension 'CXC','FormaGeneracion','Normal','FormaGeneracion',1
EXEC spInsertarDimensionNivel  'CXC','FormaGeneracion','FormaGeneracion','FormaGeneracion','FormaGeneracion',1
GO
EXEC spInsertarDimension 'CXC','SemanaVencimiento','Normal','SemanaVencimiento',1
EXEC spInsertarDimensionNivel  'CXC','SemanaVencimiento','SemanaVencimiento','SemanaVencimiento','SemanaVencimiento',1
GO
EXEC spInsertarDimension 'CXC','AñoVencimiento','Normal','AñoVencimiento',1
EXEC spInsertarDimensionNivel  'CXC','AñoVencimiento','AñoVencimiento','AñoVencimiento','AñoVencimiento',1
GO
EXEC spInsertarDimension 'CXC','MesVencimiento','Normal','MesVencimiento',1
EXEC spInsertarDimensionNivel  'CXC','MesVencimiento','MesVencimiento','MesVencimiento','MesVencimiento',1
GO
EXEC spInsertarDimension 'CXC','DiaVencimiento','Normal','DiaVencimiento',1
EXEC spInsertarDimensionNivel  'CXC','DiaVencimiento','DiaVencimiento','DiaVencimiento','DiaVencimiento',1
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CXCCTE]'))
DROP VIEW Cubo_CXCCTE
GO
CREATE VIEW Cubo_CXCCTE
--//WITH ENCRYPTION
AS
SELECT Cliente,
	Moneda,
      'Saldo'		= SUM(Cxc.Saldo)
FROM CXC
   JOIN EmpresaCfg2 Cfg	ON Cxc.Empresa 		= cfg.Empresa 
WHERE Estatus = 'PENDIENTE'
GROUP BY Cliente,Moneda
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CXC]'))
DROP VIEW Cubo_CXC
GO
CREATE VIEW Cubo_CXC 
--//WITH ENCRYPTION
AS
SELECT
Cxc.ID,
'Sucursal' 		= cxc.Sucursal,
'SucursalNombre'	= su.Nombre,
'SucursalRegion' 	= su.Region,
'Empresa' 		= cxc.Empresa,
'EmpresaNombre'		= e.Nombre,
'EmpresaGrupo' 		= e.Grupo,
'MovGrupo' 		= mc.Grupo,
Cxc.Mov,
'MovId'			= CASE WHEN cxc.FechaEmision < DATEADD(YYYY,-1,GETDATE()) and cxc.Estatus='CONCLUIDO' THEN '' ELSE Cxc.MovID END,
Cxc.FechaEmision,
t.trimestre,
t.semana,
'Año'			= t.Anio,
'Mes'			= t.MesNombre,
'DiaSemana'		= t.DiaNombre,
'Dia'			= CASE WHEN DATEPART(d, cxc.FechaEmision) < 10
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, cxc.FechaEmision))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, cxc.FechaEmision))) END ,
'SemanaVencimiento'	= tv.semana,
'AñoVencimiento'	= tv.Anio,
'MesVencimiento'	= tv.MesNombre,
'DiaSemanaVencimiento'	= tv.DiaNombre,
'DiaVencimiento'	= CASE WHEN DATEPART(d, cxc.Vencimiento) < 10
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, cxc.Vencimiento))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, cxc.Vencimiento))) END ,
cxc.UEN,
'uenNombre' 		= uen.Nombre,
'UENPersonal' 		= per.UEN,
--'UENPNombre' 		= uen.Nombre,
Cxc.Proyecto,
'Referencia'		= RTRIM(Cxc.Origen) + ' ' + RTRIM(CXC.OrigenId),
Cxc.Moneda,
Cxc.TipoCambio,
Cxc.Usuario,
'UsuarioNombre' 	= u.Nombre,
'UsuarioGrupoTrabajo' 	= u.GrupoTrabajo,
Cxc.Concepto,
Cxc.Estatus,
Cxc.Situacion,
Cxc.SituacionFecha,
'Cliente' 		= Cxc.Cliente,
'ClienteNombre' 	= cte.Nombre,
'ClienteFamilia' 	= cte.Familia,
'ClienteCategoria' 	= cte.Categoria,
'ClienteGrupo' 		= cte.Grupo,
'ClienteSucursal' 	= Cxc.ClienteEnviarA,
'ClienteSucursalNombre' = cs.Nombre,
'ClienteTipo'		= cte.Tipo,
Cxc.ClienteMoneda,
Cxc.ClienteTipoCambio,
'Cobrador'		= Cte.PersonalCobrador,
'CobradorNombre'	= RTRIM(per.ApellidoPaterno) + ' ' + RTRIM(per.ApellidoMaterno) + ' ' + rtrim(per.Nombre),
'Agente' 		= Cxc.Agente,
'AgenteNombre' 		= ag.Nombre,
'AgenteCategoria' 	= ag.Categoria,
'AgenteGrupo' 		= ag.Grupo,
Cxc.Condicion,
'FechaVencimiento'	= Cxc.Vencimiento,
Cxc.Vencimiento,
Cxc.FormaCobro,
Cxc.CtaDinero,
'Importe' 		= Cxc.Importe	* mt.Factor,
'ImporteEnPesos'	= Cxc.Importe	* mt.Factor * cxc.TipoCambio,
'Impuestos' 		= ISNULL(Cxc.Impuestos,0) * mt.Factor ,
'Saldo' 		= ISNULL(Cxc.Saldo,0)	* mt.Factor  ,
'SaldoEnPesos' 		= ISNULL(Cxc.Saldo,0)	* mt.Factor * cxc.TipoCambio ,
'ImporteTotal' 		= (Cxc.Importe + ISNULL(Cxc.Impuestos, 0.0)) * mt.Factor,
'ImporteTotalEnPesos' 	= (Cxc.Importe + ISNULL(Cxc.Impuestos, 0.0)) * mt.Factor * cxc.tipocambio,
'Moratorios' 		= CASE WHEN Cxc.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxc.Vencimiento, (GETDATE()-1))>0
				THEN Cxc.Saldo * mt.Factor * em.cxcMoratoriosTasa * DATEDIFF(day, Cxc.Vencimiento, (GETDATE()-1))
				ELSE 0 END,
Cxc.Retencion,
Cxc.MovAplica,
Cxc.MovAplicaID,
Cxc.OrigenTipo,
Cxc.Origen,
Cxc.OrigenID,
Cxc.Dinero,
'FormaGeneracion'	= CASE WHEN cxc.origen = 'FACTURA' THEN 'AUTOMATICA' ELSE 'MANUAL' END,
Cxc.DineroID,
Cxc.DineroCtaDinero,
Cxc.FechaEntrega,
Cxc.EmbarqueEstado,
'DiasVencido'		= CASE WHEN  ccte.Saldo = 0 THEN 0 ELSE cxc.Saldo * (CASE WHEN Cxc.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())>0 THEN DATEDIFF(day, Cxc.Vencimiento, GETDATE()) ELSE 0 END) / ccte.Saldo END,
'DiasNormales'		= CASE WHEN ccte.Saldo = 0 THEN 0 ELSE cxc.Saldo * (DATEDIFF(day, Cxc.FechaEmision, GETDATE())) / ccte.Saldo END,
'ClienteSituacion' 	= Cte.Situacion,
'HabitoDiasEmision' 	= DATEDIFF(day, Cxc.FechaEmision, Cxc.FechaConclusion),
'HabitoDiasRetraso' 	= DATEDIFF(day, Cxc.Vencimiento, Cxc.FechaConclusion),
'EstaVencido' 		= CASE WHEN Cxc.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())>0 THEN 'Si' ELSE 'No' END,
'EstatusSaldo' 		= CASE WHEN Cxc.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())>=cfg.CxcDiasMorosidad THEN 'Moroso' WHEN Cxc.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())>0 THEN 'Vencido' ELSE 'Corriente' END,
'DiasRetraso' 		= CASE WHEN Cxc.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())>0 THEN DATEDIFF(day, Cxc.Vencimiento, GETDATE()) ELSE 0 END,
'Throughput' 		= CASE WHEN Cxc.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())>0 THEN DATEDIFF(day, Cxc.Vencimiento, GETDATE()) ELSE 0 END * Cxc.Saldo,
'AntigüedadSaldo' 	= CASE WHEN Cxc.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())>= 1
				AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())<= 30 THEN ' 1 - 30'  WHEN Cxc.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())>= 31
				AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())<= 60 THEN '31 - 60' WHEN Cxc.Estatus = 'PENDIENTE'                                AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())>= 61
				AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())<= 90 THEN '61 - 90' WHEN Cxc.Estatus = 'PENDIENTE'
				AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())>= 91 THEN '+ 90'    WHEN Cxc.Estatus = 'PENDIENTE'
				AND DATEDIFF(day, Cxc.Vencimiento, GETDATE())<= 0 THEN 'Corriente' END
FROM
Cxc
LEFT OUTER JOIN Empresa e 	ON Cxc.Empresa 		= e.Empresa
LEFT OUTER JOIN Sucursal su 	ON Cxc.Sucursal 	= su.Sucursal
LEFT OUTER JOIN Cte cte 	ON Cxc.Cliente 		= cte.Cliente
LEFT OUTER JOIN Personal per 	ON cte.PersonalCobrador	= per.Personal
LEFT OUTER JOIN CteEnviarA cs 	ON cte.Cliente 		= cs.Cliente AND cxc.ClienteEnviarA = cs.id
LEFT OUTER JOIN Agente ag 	ON Cxc.Agente 		= ag.Agente
LEFT OUTER JOIN Usuario u 	ON Cxc.Usuario 		= u.Usuario
LEFT OUTER JOIN MovTipo mt 	ON Cxc.Mov 		= mt.Mov
LEFT OUTER JOIN MovClave mc 	ON mc.Modulo 		= mt.Modulo AND mc.Clave = mt.Clave
LEFT OUTER JOIN EmpresaCfg2 Cfg	ON Cxc.Empresa 		= cfg.Empresa
LEFT OUTER JOIN EmpresaCfg  Em	ON Cxc.Empresa 		= em.Empresa
LEFT OUTER JOIN Tiempo t	ON cxc.FechaEmision 	= t.Fecha
LEFT OUTER JOIN Tiempo tv	ON cxc.Vencimiento 	= tv.Fecha
LEFT OUTER JOIN UEN uen	   	ON cxc.uen		= uen.uen 
LEFT OUTER JOIN Cubo_CXCCTE ccte ON cxc.Cliente		= ccte.Cliente AND cxc.Moneda = ccte.Moneda
WHERE
Cxc.Estatus IN ('PENDIENTE','CONCLUIDO')
AND mt.Modulo = 'CXC'
UNION
SELECT
'ID'			= NULL,
'Sucursal' 		= sa.Sucursal,
'SucursalNombre'	= su.Nombre,
'SucursalRegion' 	= su.Region,
'Empresa' 		= sa.Empresa,
'EmpresaNombre'		= e.Nombre,
'EmpresaGrupo' 		= e.Grupo,
'MovGrupo' 		= NULL,
'Mov'			= CASE WHEN sa.saldo > 0 then 'Saldo en Contra' ELSE  'Saldo a Favor' END,
'MovId'			= NULL,
'FechaEmision'		= NULL,
'trimestre'		= NULL,
'Año'			= NULL,
'semana'		= NULL,
'Mes'			= NULL,
'DiaSemana'		= NULL,
'Dia'			= NULL,
'SemanaVenc'		= NULL,
'AñoVenc'		= NULL,
'MesVenc'		= NULL,
'DiaSemanaVenc'		= NULL,
'DiaVenc'		= NULL ,
'UEN'			= NULL,
'uenNombre' 		= NULL,
'UENPersonal' 		= NULL,
'Proyecto'		= NULL,
'Referencia'		= NULL,
'Moneda'		= sa.moneda,
'TipoCambio'		= 1,
'Usuario'		= NULL,
'UsuarioNombre' 	= NULL,
'UsuarioGrupoTrabajo' 	= NULL,
'Concepto'		= NULL,
'Estatus'		= NULL,
'Situacion'		= NULL,
'SituacionFecha'	= NULL,
'Cliente' 		= sa.Cuenta,
'ClienteNombre' 	= cte.Nombre,
'ClienteFamilia' 	= cte.Familia,
'ClienteCategoria' 	= cte.Categoria,
'ClienteGrupo' 		= cte.Grupo,
'ClienteSucursal' 	= NULL,
'ClienteSucursalNombre' = NULL,
'ClienteTipo'		= cte.Tipo,
'ClienteMoneda'		= NULL,
'ClienteTipoCambio'	= NULL,
'Cobrador'		= NULL,
'CobradorNombre'	= NULL,
'Agente' 		= NULL,
'AgenteNombre' 		= NULL,
'AgenteCategoria' 	= NULL,
'AgenteGrupo' 		= NULL,
'Condicion'		= NULL,
'FechaVencimiento'	= NULL,
'Vencimiento'		= NULL,
'FormaCobro'		= NULL,
'CtaDinero'		= NULL,
'Importe' 		= 0,
'ImporteEnPesos'	= 0,
'Impuestos' 		= 0 ,
'Saldo' 		= ISNULL(sa.Saldo,0)  ,
'SaldoEnPesos' 		= 0 ,
'ImporteTotal' 		= 0,
'ImporteTotalEnPesos'	= 0,
'Moratorios' 		= 0,
'Retencion'		= NULL,
'MovAplica'		= NULL,
'MovAplicaID'		= NULL,
'OrigenTipo'		= NULL,
'Origen'		= NULL,
'OrigenID'		= NULL,
'Dinero'		= NULL,
'FormaGeneracion'	= NULL,
'DineroID'		= NULL,
'DineroCtaDinero'	= NULL,
'FechaEntrega'		= NULL,
'EmbarqueEstado'	= NULL,
'DiasVencido'		= NULL,
'DiasNormales'		= NULL,
'ClienteSituacion' 	= NULL,
'HabitoDiasEmision' 	= NULL,
'HabitoDiasRetraso' 	= NULL,
'EstaVencido' 		= NULL,
'EstatusSaldo' 		= NULL,
'DiasRetraso' 		= NULL,
'Throughput' 		= NULL,
'AntigüedadSaldo' 	= NULL
FROM
Saldo sa
LEFT OUTER JOIN Empresa e 	ON sa.Empresa 	= e.Empresa
LEFT OUTER JOIN Sucursal su 	ON sa.Sucursal 	= su.Sucursal
LEFT OUTER JOIN Cte cte 	ON sa.Cuenta 	= cte.Cliente
WHERE sa.Rama = 'CEFE'
GO