/* VISTAS          */

-- use matriz
/***********************************************************************************************/
/*******************************************   VENTAS   ****************************************/
/***********************************************************************************************/

/*** VentaCte ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaCte') and type = 'V') drop view dbo.VentaCte
GO
CREATE VIEW VentaCte
--//WITH ENCRYPTION
AS
SELECT Empresa, 
       "Cliente" = Grupo,
       Ejercicio,
       Periodo,
       Moneda,
       "ImporteVenta" = SUM(Cargos),
       "ImporteDev"   = SUM(Abonos),
       "ImporteNeto"  = SUM(Cargos-Abonos)
  FROM AcumRU
 WHERE Rama = 'VTAS'
 GROUP BY Empresa, Grupo, Ejercicio, Periodo, Moneda
GO     


/*** VentaArt ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaArt') and type = 'V') drop view dbo.VentaArt
GO
CREATE VIEW VentaArt
--//WITH ENCRYPTION
AS
SELECT Empresa, 
       "Articulo" = Cuenta,
       Ejercicio,
       Periodo,
       Moneda,
       "ImporteVenta"   = SUM(Cargos),
       "ImporteDev"     = SUM(Abonos),
       "ImporteNeto"    = SUM(Cargos-Abonos),
       "CantidadVenta"  = SUM(CargosU),
       "CantidadDev"    = SUM(AbonosU),
       "CantidadNeta"   = SUM(CargosU-AbonosU)
  FROM AcumRU
 WHERE Rama = 'VTAS'
 GROUP BY Empresa, Cuenta, Ejercicio, Periodo, Moneda
GO     

/*** VentaCteArt ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaCteArt') and type = 'V') drop view dbo.VentaCteArt
GO
CREATE VIEW VentaCteArt
--//WITH ENCRYPTION
AS
SELECT Empresa, 
       "Cliente" = Grupo,
       "Articulo" = Cuenta,
       Ejercicio,
       Periodo,
       Moneda,
       "ImporteVenta"   = SUM(Cargos),
       "ImporteDev"     = SUM(Abonos),
       "ImporteNeto"    = SUM(Cargos-Abonos),
       "CantidadVenta"  = SUM(CargosU),
       "CantidadDev"    = SUM(AbonosU),
       "CantidadNeta"   = SUM(CargosU-AbonosU)
  FROM AcumRU
 WHERE Rama = 'VTAS'
 GROUP BY Empresa, Grupo, Cuenta, Ejercicio, Periodo, Moneda
GO     

-- select * from VentaCalc
/*** VentaCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaCalc') and type = 'V') drop view dbo.VentaCalc
GO
CREATE VIEW VentaCalc
--//WITH ENCRYPTION
AS 
SELECT 
  v.*,
  "DescuentosTotales" = (Convert(money, ROUND((v.Importe*ISNULL(v.DescuentoGlobal, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0)))+ISNULL(v.DescuentoLineal, 0.0)),
  "ImporteSobrePrecio"= (Convert(money, ROUND((v.Importe*ISNULL(v.SobrePrecio, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0)))),
  "SubTotal"          = Convert(money, ROUND(dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio), ISNULL(vs.RedondeoMonetarios,0))),
  "ImporteTotal"      = Convert(money, ROUND(dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio) + ISNULL(v.Impuestos, 0.0), ISNULL(vs.RedondeoMonetarios,0))),
  "TotalNeto"         = Convert(money, ROUND(dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio) + ISNULL(v.Impuestos, 0.0) - ISNULL(v.AnticiposFacturados, 0.0) - ISNULL(v.Retencion, 0.0), ISNULL(vs.RedondeoMonetarios,0)))

FROM Venta v
JOIN Version vs ON 1 = 1
GO


-- select * from VentaDpreCalc
-- select * from VentaDpreCalc
/*** VentaDpreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaDpreCalc') and type = 'V') drop view dbo.VentaDpreCalc
GO
CREATE VIEW VentaDpreCalc
--//WITH ENCRYPTION
AS 
SELECT 
  d.*,
  "CantidadNeta" = Cantidad-ISNULL(CantidadCancelada, 0.0),
  "CantidadSinObsequios" = Cantidad-ISNULL(CantidadCancelada, 0.0)-ISNULL(CantidadObsequio, 0.0),
  "CantidadFactor" = (Cantidad-ISNULL(CantidadCancelada, 0.0))*Factor,
  "ReservadaFactor" = CantidadReservada*Factor,
  "OrdenadaFactor" = CantidadOrdenada*Factor,
  "PendienteFactor" = CantidadPendiente*Factor,
  "Impuesto1Base" = Impuesto1,
  "Impuesto2Base" = CASE WHEN v.Impuesto2Info=1 THEN 0.0 ELSE Impuesto2 END,
  "Impuesto3Base" = CASE WHEN v.Impuesto3Info=1 THEN 0.0 ELSE Impuesto3 END,
  "Impuesto2BaseImpuesto1" = CASE WHEN v.Impuesto2Info=1 OR v.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE Impuesto2 END,
  "Retencion2BaseImpuesto1" = CASE WHEN ISNULL(v.Retencion2BaseImpuesto1,0) = 0 THEN 0 ELSE 1 END, --ARCC
  "ImpuestosPorcentaje" = convert(float, round((CASE WHEN v.Impuesto2Info=0 THEN ISNULL(Impuesto2,0.0) ELSE 0.0 END)+(ISNULL(Impuesto1, 0.0)*(1.0+((CASE WHEN v.Impuesto2Info=1 OR v.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE ISNULL(Impuesto2,0.0) END)/100))), 10.0)),
  "ImpuestosImporte"    = convert(float, ROUND((Cantidad-ISNULL(CantidadCancelada, 0.0))*ISNULL(CASE WHEN v.Impuesto3Info=1 THEN 0.0 ELSE Impuesto3 END, 0.0), ISNULL(v.RedondeoMonetarios,0))),
  "CostoTotal"          = convert(float, ROUND((Cantidad-ISNULL(CantidadCancelada, 0.0))*Costo, ISNULL(v.RedondeoMonetarios,0))),
  "CostoActividadTotal" = convert(float, ROUND((Cantidad-ISNULL(CantidadCancelada, 0.0))*CostoActividad, ISNULL(v.RedondeoMonetarios,0))),
  "PrecioTotal"         = convert(float, ROUND((Cantidad-ISNULL(CantidadCancelada, 0.0)-ISNULL(CantidadObsequio, 0.0))*Precio, ISNULL(v.RedondeoMonetarios,0))),
  "preImporte"          = convert(float, ROUND(((Cantidad-ISNULL(CantidadCancelada, 0.0)-ISNULL(CantidadObsequio, 0.0))*Precio)-ISNULL(case when DescuentoTipo='$' then DescuentoLinea else (Cantidad-ISNULL(CantidadCancelada, 0.0)-ISNULL(CantidadObsequio, 0.0))*Precio*(DescuentoLinea/100.0) end, 0.0), ISNULL(v.RedondeoMonetarios,0))),--,
  "preImporteSinDL"     = convert(float, ROUND(((Cantidad-ISNULL(CantidadCancelada, 0.0)-ISNULL(CantidadObsequio, 0.0))*Precio), ISNULL(v.RedondeoMonetarios,0))),--REQ Q3069 CFDGT
  "ImpIncpreImporte"    = convert(float, ROUND(((Cantidad-ISNULL(CantidadCancelada, 0.0)-ISNULL(CantidadObsequio, 0.0))*Precio), ISNULL(v.RedondeoMonetarios,0)))
  --"DescuentoLineal"     = convert(float, ROUND((case when DescuentoTipo='$' then DescuentoLinea else (Cantidad-ISNULL(CantidadCancelada, 0.0)-ISNULL(CantidadObsequio, 0.0))*Precio*(DescuentoLinea/100.0) end), dbo.fnRedondeoMonetarios()))

FROM VentaD d
JOIN Version v ON 1 = 1
GO

-- select * from VentaDpreCalc2 
/*** VentaDpreCalc2 ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaDpreCalc2') and type = 'V') drop view dbo.VentaDpreCalc2
GO
CREATE VIEW VentaDpreCalc2
--//WITH ENCRYPTION
AS 
SELECT 
  d.*,
  "preImporte2" = CASE 
                    WHEN cfg.VentaPrecioMoneda = 1 THEN preImporte*PrecioTipoCambio/v.TipoCambio
                    ELSE preImporte
                  END,
  "ImpIncpreImporte2" = CASE 
                          WHEN cfg.VentaPrecioMoneda = 1 THEN ImpIncpreImporte*PrecioTipoCambio/v.TipoCambio
                          ELSE ImpIncpreImporte
                         END,
  "ImpIncprePrecio" = CASE 
                        WHEN cfg.VentaPrecioMoneda = 1 THEN Precio*PrecioTipoCambio/v.TipoCambio
                        ELSE Precio
                      END,                         
  --REQ Q3069 CFDGT
  "preImporte2SinDL" = CASE 
                         WHEN cfg.VentaPrecioMoneda = 1 THEN preImporteSinDL*PrecioTipoCambio/v.TipoCambio
                         ELSE preImporteSinDL
                       END,
  "prePrecioSinDL" = CASE 
                       WHEN cfg.VentaPrecioMoneda = 1 THEN Precio*PrecioTipoCambio/v.TipoCambio
                       ELSE Precio
                     END,
  --REQ Q3069 CFDGT
  "DescuentoLineal" = CASE
                        WHEN cfg.VentaPrecioMoneda = 1 THEN CantidadSinObsequios*Precio*PrecioTipoCambio/v.TipoCambio*(DescuentoLinea/100.0)
                        ELSE CantidadSinObsequios*Precio*(DescuentoLinea/100.0)
                      END
FROM Venta v 
JOIN VentaDpreCalc d ON v.ID = d.ID
JOIN EmpresaCfg cfg ON v.Empresa = cfg.Empresa
GO

-- select * from VentaDCalc
/*** VentaDCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaDCalc') and type = 'V') drop view dbo.VentaDCalc
GO
CREATE VIEW VentaDCalc
--//WITH ENCRYPTION
AS 
SELECT 
  d.*,
  "Importe" = CASE 
				WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (preImporte2-ISNULL(d.Impuesto3Base,0.0))/ (1.0 + (ISNULL(d.Impuesto2Base, 0.0)/100) + ((ISNULL(d.Impuesto1Base,0.0)/100) * (1+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100))))
                ELSE preImporte2
              END,
  --REQ Q3069 CFDGT
  "ImporteSinDL" = CASE 
				     WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (preImporte2SinDL-ISNULL(d.Impuesto3Base,0.0))/ (1.0 + (ISNULL(d.Impuesto2Base, 0.0)/100) + ((ISNULL(d.Impuesto1Base,0.0)/100) * (1+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100))))
				     ELSE preImporte2SinDL
				     END,
  "PrecioSinDL" = CASE 
				    WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (prePrecioSinDL-ISNULL(d.Impuesto3Base,0.0))/ (1.0 + (ISNULL(d.Impuesto2Base, 0.0)/100) + ((ISNULL(d.Impuesto1Base,0.0)/100) * (1+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100))))
				    ELSE prePrecioSinDL
				  END,
  --REQ Q3069 CFDGT
  "ImpIncImporte" = CASE 
				      WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (ImpIncpreImporte2-ISNULL(d.Impuesto3Base,0.0))/ (1.0 + (ISNULL(d.Impuesto2Base, 0.0)/100) + ((ISNULL(d.Impuesto1Base,0.0)/100) * (1+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100))))
                      ELSE ImpIncpreImporte2
                    END,              
  "ImpIncPrecio" = CASE 
				     WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (ImpIncprePrecio-ISNULL(d.Impuesto3Base,0.0))/ (1.0 + (ISNULL(d.Impuesto2Base, 0.0)/100) + ((ISNULL(d.Impuesto1Base,0.0)/100) * (1+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100))))
                     ELSE ImpIncprePrecio
                   END
FROM Venta v 
JOIN VentaDpreCalc2 d ON v.ID = d.ID
JOIN EmpresaCfg cfg ON v.Empresa = cfg.Empresa
GO

/*** VentaTCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaTCalc') and type = 'V') drop view dbo.VentaTCalc
GO
CREATE VIEW VentaTCalc
--//WITH ENCRYPTION
AS 
SELECT 
  v.ID,
  v.Empresa,
  v.SucursalOrigen,
  v.Sucursal,
  v.SucursalVenta,
  v.Mov,
  v.MovID,
  v.Moneda,
  v.TipoCambio,
  v.Concepto,
  v.Referencia,
  v.Proyecto,
  v.FechaRegistro,
  v.FechaEmision,
  d.FechaRequerida,
  v.HoraRequerida,
  v.FechaOriginal,
  v.Prioridad,
  v.Estatus,
  v.Situacion,
  v.SituacionFecha,
  v.SituacionUsuario,
  v.SituacionNota,
  v.Cliente,
  d.EnviarA,
  v.Agente,
  v.FormaEnvio,
  v.Condicion,
  v.Vencimiento,
  v.Usuario,
  v.Paquetes,
  v.Observaciones,
  v.Causa,
  v.AnticiposFacturados,
  v.Retencion,
  v.Ejercicio,
  v.Periodo,
  v.FechaConclusion,
  v.FechaEntrega,
  v.EmbarqueEstado,
  v.Peso,
  v.Volumen,
  v.ListaPreciosEsp,
  v.ZonaImpuesto,
  v.Extra,
  v.ServicioArticulo,
  v.ServicioSerie,
  v.Clase,
  v.SubClase,
  d.Aplica,
  d.AplicaID,
  d.Renglon,
  d.RenglonSub,
  d.RenglonID,
  d.RenglonTipo,
  d.Almacen,
  d.Codigo,
  d.Articulo,
  d.SubCuenta,
  d.Unidad,
  d.Precio,
  d.DescuentoTipo,
  d.DescuentoLinea,
  d.Impuesto1,
  d.Impuesto2,
  d.Impuesto3,
  d.Cantidad, 
  d.CantidadInventario,
  d.Factor,
  d.CantidadNeta, 
  d.CantidadFactor,
  d.ReservadaFactor,
  d.OrdenadaFactor,
  d.PendienteFactor,
  d.ImpuestosPorcentaje, 
  d.PoliticaPrecios,
  d.Comision,
  d.CantidadPendiente,
  d.CantidadReservada,
  d.CantidadOrdenada,
  d.CantidadEmbarcada,
  d.Costo,
  d.AjusteCosteo,
  d.CostoUEPS,
  d.CostoPEPS,
  d.UltimoCosto,
  d.CostoEstandar,
  d.PrecioLista,
  d.CostoTotal, 
  d.CostoActividad,
  d.CostoActividadTotal, 
  d.PrecioTotal, 
  d.Importe, 
  d.ContUso,
  d.ContUso2,
  d.ContUso3,
  d.Espacio,
  d.UEN,
  d.ExcluirISAN,
  d.Posicion,
  d.PresupuestoEsp,
  d.DescuentoLineal,
  d.TipoImpuesto1,
  d.TipoImpuesto2,
  d.TipoImpuesto3,
  d.Retencion1,
  d.Retencion2,
  d.Retencion3,     
  d.CostoPromedio,
  d.CostoReposicion,
  d.Ordencompra, 
  d.DescripcionExtra,
  d.AnticipoFacturado,  --ANTICIPOFACTURADO
  d.AnticipoMoneda, --ANTICIPOFACTURADO
  d.AnticipoTipoCambio, --ANTICIPOFACTURADO
  d.AnticipoRetencion, --ANTICIPOFACTURADO
  d.ImpIncPrecio,
  d.ImpIncPreImporte,
  d.ImpIncImporte,
  d.Tarima, --REQ12615 WMS
  "ImpIncDescuentoLineal" = ImpIncImporte*(d.DescuentoLinea/100.0),  
  --REQ Q3069 CFDGT
  d.PrecioSinDL,
  d.PreImporteSinDL,
  d.ImporteSinDL,
  "DescuentoLinealSinDL" = ImporteSinDL*(d.DescuentoLinea/100.0),
  --REQ Q3069 CFDGT
  "ImporteDescuentoGlobal" = convert(float, ROUND((d.Importe*(CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "DescuentosTotales"      = convert(float, ROUND((d.Importe*(CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END)/100.0) + ISNULL(d.DescuentoLineal, 0.0), ISNULL(vs.RedondeoMonetarios,0))),
  "ImpIncDescuentosTotales"= convert(float, ROUND(((d.ImpIncImporte*(1.0 - (d.DescuentoLinea/100.0)))*(CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END)/100.0) + (ISNULL(ImpIncImporte,0.0)*(ISNULL(d.DescuentoLinea,0.0)/100.0)), ISNULL(vs.RedondeoMonetarios,0))),
  "DescuentosTotalesSinDL" = convert(float, ROUND((d.ImporteSinDL*ISNULL(v.DescuentoGlobal, 0.0)/100.0) + (ISNULL(ImporteSinDL,0.0)*(ISNULL(d.DescuentoLinea,0.0)/100.0)), ISNULL(vs.RedondeoMonetarios,0))),--REQ Q3069 CFDGT
  "ImporteSobrePrecio"     = convert(float, ROUND((d.Importe*ISNULL(v.SobrePrecio, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "SubTotal"               = Convert(float, ROUND(dbo.fnSubTotal(d.Importe, (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio), ISNULL(vs.RedondeoMonetarios,0))),
  "SubTotalSinDL"  = Convert(float, ROUND(dbo.fnSubTotal(d.ImporteSinDL,  0.0, v.SobrePrecio), ISNULL(vs.RedondeoMonetarios,0))), --REQ Q3069 CFDGT
  "ImpIncSubTotal"         = Convert(float, ROUND(dbo.fnSubTotal(d.ImpIncImporte,  0.0, v.SobrePrecio), ISNULL(vs.RedondeoMonetarios,0))),  
  "Impuesto1Total"         = Convert(float, ROUND(dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) * (1.0+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(Impuesto1Base, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "Impuesto2Total"         = Convert(float, ROUND(dbo.fnSubTotal(d.Importe, (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) * (ISNULL(Impuesto2Base, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "Impuesto3Total"         = ISNULL(ImpuestosImporte, 0.0),--Convert(float, ROUND(dbo.fnSubTotal(d.Importe, v.DescuentoGlobal, v.SobrePrecio) * (1.0+(ISNULL(Impuesto2Base, 0.0)/100.0))*(ISNULL(Impuesto3Base, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "Impuestos" 	           = ISNULL(ImpuestosImporte, 0.0) + Convert(float, ROUND(dbo.fnSubTotal(d.Importe, (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) * (ISNULL(ImpuestosPorcentaje, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "Retencion1Total"        = Convert(float, ROUND(dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) *(ISNULL(d.Retencion1, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))), --ARCC
  "Retencion2Total"        = Convert(float, ROUND((CASE WHEN d.Retencion2BaseImpuesto1 = 0 THEN dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) ELSE Convert(float, ROUND(dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) * (1.0+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(Impuesto1Base, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))) END) *(ISNULL(d.Retencion2, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))), --ARCC 
  "Retencion3Total"        = Convert(float, ROUND(dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) *(ISNULL(d.Retencion3, 0.0)/100.0), dbo.fnRedondeoMonetarios())),
  "ImporteTotal"           = ISNULL(ImpuestosImporte, 0.0) + Convert(float, ROUND(dbo.fnSubTotal(d.Importe, (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) * (1.0+(ISNULL(ImpuestosPorcentaje, 0.0)/100.0)), ISNULL(vs.RedondeoMonetarios,0))),
  "TotalNeto"              = (ISNULL(ImpuestosImporte, 0.0) 
	 + Convert(float, ROUND(dbo.fnSubTotal(d.Importe, (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) * (1.0+(ISNULL(ImpuestosPorcentaje, 0.0)/100.0)), dbo.fnRedondeoMonetarios())-
	 ISNULL(Convert(float, ROUND(dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) *(ISNULL(d.Retencion1, 0.0)/100.0), dbo.fnRedondeoMonetarios())),0.0)
	 -ISNULL(Convert(float, ROUND((CASE WHEN d.Retencion2BaseImpuesto1 = 0 THEN dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) ELSE Convert(float, ROUND(dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) * (1.0+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(Impuesto1Base, 0.0)/100.0), dbo.fnRedondeoMonetarios())) END) *(ISNULL(d.Retencion2, 0.0)/100.0), dbo.fnRedondeoMonetarios())),0.0)))
	 -ISNULL(Convert(float, ROUND(dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) *(ISNULL(d.Retencion3, 0.0)/100.0), dbo.fnRedondeoMonetarios())),0.0)
-- En caso de que al TotalNeto se quiera descontar AnticiposFacturados y Retenciones descoemntar el calculo siguiente
/* "TotalNeto"              = ISNULL(ImpuestosImporte, 0.0) + Convert(float, ROUND(dbo.fnSubTotal(d.Importe, v.DescuentoGlobal, v.SobrePrecio) * (1.0+(ISNULL(ImpuestosPorcentaje, 0.0)/100.0)) 
                             - dbo.fnR3((SELECT SUM(b.importe) FROM VentaDCalc b WHERE b.ID = v.ID),100,d.Importe)*ISNULL(v.AnticiposFacturados, 0.0)
                             - CASE WHEN dbo.fnEsPitex(v.Cliente) = 1 
                                    THEN Convert(float, dbo.fnSubTotal(d.Importe, v.DescuentoGlobal, v.SobrePrecio) * (1.0+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(Impuesto1Base, 0.0)/100.0)) 
                                    ELSE CASE WHEN d.Articulo ='FLETE' 
                                              THEN Convert(float, dbo.fnSubTotal(d.Importe, v.DescuentoGlobal, v.SobrePrecio) * (1.0+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(Impuesto1Base, 0.0)/100.0))  
                                              ELSE 0 END
                                    END, ISNULL(vs.RedondeoMonetarios,0)))*/

FROM Venta v
JOIN VentaDCalc d ON v.ID = d.ID
JOIN Version vs ON 1 = 1
GO

-- select dbo.fnEsPitex('1236')
/**************** fnEsPitex ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEsPitex') DROP FUNCTION fnEsPitex
GO
CREATE FUNCTION fnEsPitex (@Cliente varchar(20))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
DECLARE @Espitex bit, @Pitex varchar(20)

  SELECT @EsPitex = 0, @Pitex = NULL
  SELECT @Pitex = NULLIF(RTRIM(Pitex),'') FROM Cte WHERE Cliente = @Cliente

  IF @Pitex IS NOT NULL
    SELECT @EsPitex = 1

  RETURN(@EsPitex)
END
GO

-- select * from ventatcalc

/***********************************************************************************************/
/******************************************   COMPRAS   ****************************************/
/***********************************************************************************************/


/*** CompraProv ***/
if exists (select * from sysobjects where id = object_id('dbo.CompraProv') and type = 'V') drop view dbo.CompraProv
GO
CREATE VIEW CompraProv
--//WITH ENCRYPTION
AS
SELECT Empresa, 
       "Proveedor" = Grupo,
       Ejercicio,
       Periodo,
       Moneda,
       "ImporteCompra"   = SUM(Cargos),
       "ImporteDev"      = SUM(Abonos),
       "ImporteNeto"     = SUM(Cargos-Abonos)
  FROM AcumRU
 WHERE Rama = 'COMS'
 GROUP BY Empresa, Grupo, Ejercicio, Periodo, Moneda
GO     

/*** CompraArt ***/
if exists (select * from sysobjects where id = object_id('dbo.CompraArt') and type = 'V') drop view dbo.CompraArt
GO
CREATE VIEW CompraArt
--//WITH ENCRYPTION
AS
SELECT Empresa, 
       "Articulo" = Cuenta,
       Ejercicio,
       Periodo,
       Moneda,
       "ImporteCompra"   = SUM(Cargos),
       "ImporteDev"      = SUM(Abonos),
       "ImporteNeto"     = SUM(Cargos-Abonos),
       "CantidadCompra"  = SUM(CargosU),
       "CantidadDev"     = SUM(AbonosU),
       "CantidadNeta"    = SUM(CargosU-AbonosU)
  FROM AcumRU
 WHERE Rama = 'COMS'
 GROUP BY Empresa, Cuenta, Ejercicio, Periodo, Moneda
GO     

/*** CompraProvArt ***/
if exists (select * from sysobjects where id = object_id('dbo.CompraProvArt') and type = 'V') drop view dbo.CompraProvArt
GO
CREATE VIEW CompraProvArt
--//WITH ENCRYPTION
AS
SELECT Empresa, 
       "Proveedor" = Grupo,
       "Articulo" = Cuenta,
       Ejercicio,
       Periodo,
       Moneda,
       "ImporteCompra"   = SUM(Cargos),
       "ImporteDev"      = SUM(Abonos),
       "ImporteNeto"     = SUM(Cargos-Abonos),
       "CantidadCompra"  = SUM(CargosU),
       "CantidadDev"     = SUM(AbonosU),
       "CantidadNeta"    = SUM(CargosU-AbonosU)
  FROM AcumRU
 WHERE Rama = 'COMS'
 GROUP BY Empresa, Grupo, Cuenta, Ejercicio, Periodo, Moneda
GO     


/*** CompraCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.CompraCalc') and type = 'V') drop view dbo.CompraCalc
GO
CREATE VIEW CompraCalc
--//WITH ENCRYPTION
AS 
SELECT 
  v.*,
  "DescuentosTotales" = (Convert(money, ROUND((v.Importe*ISNULL(v.DescuentoGlobal, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0)))+ISNULL(v.DescuentoLineal, 0.0)),
  "SubTotal"= Convert(money, ROUND((v.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "ImporteTotal"= Convert(money, ROUND((v.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0) + v.Impuestos, ISNULL(vs.RedondeoMonetarios,0)))

FROM Compra v
JOIN Version vs ON 1 = 1
GO

/*** CompraDCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.CompraDCalc') and type = 'V') drop view dbo.CompraDCalc
GO
CREATE VIEW CompraDCalc
--//WITH ENCRYPTION
AS 
SELECT 
  d.*,
  "CantidadNeta" = (Cantidad-ISNULL(CantidadCancelada, 0.0)),
  "CantidadFactor" = (Cantidad-ISNULL(CantidadCancelada, 0.0))*Factor,
  "PendienteFactor" = CantidadPendiente*Factor,
  "Impuesto1Base" = Impuesto1,
  "Impuesto2Base" = CASE WHEN v.Impuesto2Info=1 THEN 0.0 ELSE Impuesto2 END,
  "Impuesto3Base" = CASE WHEN v.Impuesto3Info=1 THEN 0.0 ELSE Impuesto3 END,
  "Impuesto5Base" = Impuesto5,
  "Impuesto2BaseImpuesto1" = CASE WHEN v.Impuesto2Info=1 OR v.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE Impuesto2 END,
  "ImpuestosPorcentaje" = convert(float, ROUND((100.0+ISNULL(CASE WHEN v.Impuesto2Info=1 OR v.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE Impuesto2 END, 0.0))*(1.0+((ISNULL(Impuesto1, 0.0)/*+ISNULL(Impuesto3, 0.0)*/)/100.0))-100, ISNULL(v.RedondeoMonetarios,0))),
  "ImpuestosImporte"    = convert(money, ROUND((Cantidad-ISNULL(CantidadCancelada, 0.0))*ISNULL(CASE WHEN v.Impuesto3Info=1 THEN 0.0 ELSE Impuesto3 END, 0.0) + ISNULL(Impuesto5,0.0), ISNULL(v.RedondeoMonetarios,0))),
  "Importe" = convert(money, ROUND(((Cantidad-ISNULL(CantidadCancelada, 0.0))*Costo)-ISNULL(case when DescuentoTipo='$' then ISNULL(DescuentoLinea, 0.0) else (Cantidad-ISNULL(CantidadCancelada, 0.0))*Costo*(ISNULL(DescuentoLinea, 0.0)/100.0) end, 0.0), ISNULL(v.RedondeoMonetarios,0))),  
  "DescuentoLineal" = convert(money, ROUND((case when DescuentoTipo='$' then DescuentoLinea else (Cantidad-ISNULL(CantidadCancelada, 0.0))*Costo*(DescuentoLinea/100.0) end), ISNULL(v.RedondeoMonetarios,0)))

FROM CompraD d
JOIN Version v ON 1 = 1
GO

/*** CompraTCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.CompraTCalc') and type = 'V') drop view dbo.CompraTCalc
GO
CREATE VIEW CompraTCalc
--//WITH ENCRYPTION
AS 
SELECT 
  v.ID,
  v.Sucursal,
  v.Empresa,
  v.Mov,
  v.MovID,
  v.Moneda,
  v.TipoCambio,
  v.Concepto,
  v.Referencia,
  v.Proyecto,
  v.FechaEmision,
  d.FechaRequerida,
  v.Prioridad,
  v.Estatus,
  v.Situacion,
  v.SituacionFecha,
  v.SituacionUsuario,
  v.SituacionNota,
  v.Proveedor,
  v.Agente,
  v.FormaEnvio,
  v.Condicion,
  v.Vencimiento,
  v.Usuario,
  v.Observaciones,
  v.Ejercicio,
  v.Periodo,
  v.Peso,
  v.Volumen,
  v.causa,
  v.ZonaImpuesto,
  v.FechaEntrega,
  v.EmbarqueEstado,
  v.FechaConclusion,
  v.FechaRegistro,
  v.UEN,
  --BUG9637
  v.Retencion,
  d.Renglon,
  d.RenglonSub,
  d.RenglonID,
  d.RenglonTipo,
  d.ImportacionProveedor,
  d.ImportacionReferencia,
  d.Articulo,
  d.SubCuenta,
  d.Unidad,
  d.Almacen,
  d.Costo,
  d.AjusteCosteo,
  d.CostoUEPS,
  d.CostoPEPS,
  d.UltimoCosto,
  d.CostoEstandar,
  d.PrecioLista,
  d.DescuentoTipo,
  d.Impuesto1,
  d.Impuesto2,
  d.Impuesto3,
  d.Impuesto5,
  d.Retencion1,
  d.Retencion2,
  d.Retencion3,
  d.Cantidad, 
  d.Factor,
  d.CantidadInventario,
  d.CantidadNeta, 
  d.CantidadPendiente,
  d.CantidadEmbarcada,
  d.CantidadFactor,
  d.PendienteFactor,
  d.ImpuestosPorcentaje, 
  d.Importe, 
  d.DescuentoLineal,
  d.ContUso,
  d.ContUso2,
  d.ContUso3,
  d.Categoria,
  d.Aplica,
  d.AplicaID,
  d.PresupuestoEsp,
  d.ClavePresupuestal,
  d.TipoImpuesto1,
  d.TipoImpuesto2,
  d.TipoImpuesto3,
  d.TipoImpuesto5,
  d.TipoRetencion1,
  d.TipoRetencion2,
  d.TipoRetencion3,
  d.CostoPromedio,
  d.CostoReposicion,
  d.MonedaD,
  d.TipocambioD,
  d.Tarima, --REQ12615 WMS
  "SubTotalInv"       = Convert(money, ROUND(d.CostoInv*d.CantidadNeta, ISNULL(vs.RedondeoMonetarios,0))),
  "DescuentosTotales" = convert(money, ROUND((d.Importe*ISNULL(v.DescuentoGlobal, 0.0)/100.0)+ISNULL(d.DescuentoLineal, 0.0), ISNULL(vs.RedondeoMonetarios,0))),
  "SubTotal"          = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*CASE WHEN mt.SubClave = 'COMS.CE/GT' THEN (1-(ISNULL(Retencion3, 0.0)/100.0)) ELSE 1 END, ISNULL(vs.RedondeoMonetarios,0))),
  "Impuesto1Total"    = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*CASE WHEN mt.SubClave = 'COMS.CE/GT' THEN (1-(ISNULL(Retencion3, 0.0)/100.0)) ELSE 1 END*(1.0+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(Impuesto1Base, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "Impuesto2Total"    = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*CASE WHEN mt.SubClave = 'COMS.CE/GT' THEN (1-(ISNULL(Retencion3, 0.0)/100.0)) ELSE 1 END*(ISNULL(Impuesto2Base, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "Impuesto3Total"    = ISNULL(ImpuestosImporte, 0.0) - ISNULL(Impuesto5Base,0.0),--Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(1.0+(ISNULL(Impuesto2Base, 0.0)/100.0))*(ISNULL(Impuesto3Base, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "Impuesto5Total"    = ISNULL(Impuesto5Base,0.0),--Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(1.0+(ISNULL(Impuesto2Base, 0.0)/100.0))*(ISNULL(Impuesto3Base, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "Impuestos" 	      = ISNULL(ImpuestosImporte, 0.0) + Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0) * (ISNULL(ImpuestosPorcentaje, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "ImporteTotal"      = ISNULL(ImpuestosImporte, 0.0) + Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0) * (1.0+(ISNULL(ImpuestosPorcentaje, 0.0)/100.0)), ISNULL(vs.RedondeoMonetarios,0))),
  "Retencion1Total"   = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(1-(ISNULL(Retencion3, 0.0)/100.0))*(ISNULL(Retencion1, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "Retencion2Total"   = CASE 
                        WHEN vs.Retencion2BaseImpuesto1 = 1 THEN 
                          Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(1-(ISNULL(Retencion3, 0.0)/100.0))*(1.0+(ISNULL(Impuesto2Base, 0.0)/100.0))*(ISNULL(Impuesto1Base, 0.0)/100.0)*(ISNULL(Retencion2, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0)))
                        ELSE 
                          Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(1-(ISNULL(Retencion3, 0.0)/100.0))*(ISNULL(Retencion2, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))) END,
  "Retencion3Total"   = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(ISNULL(Retencion3, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0)))

FROM Compra v
JOIN CompraDCalc d ON v.ID = d.ID
JOIN MovTipo mt ON mt.Mov = v.Mov AND mt.Modulo = 'COMS'
JOIN Version vs ON 1 = 1
GO

if exists (select * from sysobjects where id = object_id('dbo.CompraExtraccion') and type = 'V') drop view dbo.CompraExtraccion
GO
CREATE VIEW CompraExtraccion
AS
SELECT cel.Estacion,
       cel.ID,
       cel.Renglon,
       cel.RenglonSub,
       cel.RenglonID,
       cel.SerieLote,
       cel.CantidadA,
       cel.Observaciones,
       cd.RenglonTipo, 
       cd.Articulo, 
       cd.SubCuenta, 
       cd.Unidad, 
       cd.Factor,
       cd.CantidadInventario,
       cd.Paquete,
       cd.PaqueteCantidad,
       cd.ReferenciaExtra,
       cd.DescripcionExtra,
       cd.ImportacionReferencia,
       slm.Cantidad,
       sl.Existencia,
       --BUG 26685
       --'Saldo' = sl.Existencia/ISNULL(cd.PaqueteCantidad, 1),
       'Saldo' = sl.Existencia/NULLIF(ISNULL(cd.PaqueteCantidad, 1),0),
       sl.Propiedades
  FROM CompraExtraccionLista cel
  JOIN Compra c ON cel.ID = c.ID
  JOIN CompraD cd ON cel.ID = cd.ID AND cel.Renglon = cd.Renglon AND cel.RenglonSub = cd.RenglonSub
  JOIN SerieLoteMov slm ON c.Empresa = slm.Empresa AND slm.Modulo = 'COMS' AND cd.ID = slm.ID AND cd.RenglonID = slm.RenglonID AND cd.Articulo = slm.Articulo AND ISNULL(cd.SubCuenta, '') = ISNULL(slm.SubCuenta, '') AND cel.SerieLote = slm.SerieLote
  JOIN SerieLote sl ON c.Empresa = sl.Empresa AND cd.Articulo = sl.Articulo AND ISNULL(cd.SubCuenta, '') = ISNULL(sl.SubCuenta, '') AND cel.SerieLote = sl.SerieLote AND cd.Almacen = sl.Almacen
 WHERE ISNULL(sl.Existencia, 0) > 0
GO

if exists (select * from sysobjects where id = object_id('dbo.VerCompraImportacionSerieLote') and type = 'V') drop view dbo.VerCompraImportacionSerieLote
GO
CREATE VIEW VerCompraImportacionSerieLote
AS
SELECT c.ID,
       c.Empresa,
       c.Mov,
       c.MovID,
       c.FechaEmision, 
       c.Concepto, 
       c.Proyecto,
       c.Actividad, 
       c.UEN, 
       c.Moneda, 
       c.TipoCambio, 
       c.Usuario, 
       c.Referencia,
       c.Observaciones, 
       c.Proveedor,
       c.Origen,
       c.OrigenID,
       c.DescuentosTotales,
       c.SubTotal, 
       c.ImporteTotal,
       cd.Renglon,
       cd.RenglonSub,
       cd.RenglonID,
       cd.RenglonTipo, 
       cd.Articulo, 
       cd.SubCuenta, 
       cd.Unidad, 
       cd.Factor,
       cd.CantidadInventario,
       cd.Paquete,
       cd.PaqueteCantidad,
       cd.ImportacionProveedor,
       cd.ImportacionReferencia,
       sl.SerieLote,
       slm.Cantidad,
       sl.Almacen,
       sl.Existencia,
       --BUG 26685
       --'Saldo' = sl.Existencia/ISNULL(cd.PaqueteCantidad, 1),
       'Saldo' = sl.Existencia/NULLIF(ISNULL(cd.PaqueteCantidad, 1),0),
       sl.Propiedades
  FROM CompraCalc c
  JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'COMS' AND mt.Clave IN ('COMS.CC', 'COMS.FL', 'COMS.F', 'COMS.EG', 'COMS.EI')
  JOIN CompraD cd ON c.ID = cd.ID
  JOIN SerieLoteMov slm ON c.Empresa = slm.Empresa AND slm.Modulo = 'COMS' AND cd.ID = slm.ID AND cd.RenglonID = slm.RenglonID AND cd.Articulo = slm.Articulo AND ISNULL(cd.SubCuenta, '') = ISNULL(slm.SubCuenta, '')
  JOIN SerieLote sl ON c.Empresa = sl.Empresa AND cd.Articulo = sl.Articulo AND ISNULL(cd.SubCuenta, '') = ISNULL(sl.SubCuenta, '') AND cd.Almacen = sl.Almacen AND slm.SerieLote = sl.SerieLote
 WHERE ISNULL(sl.Existencia, 0) > 0
   AND c.Estatus = 'CONCLUIDO'
GO

/*** AcumMayor ***/
if exists (select * from sysobjects where id = object_id('dbo.AcumMayor') and type = 'V') drop view dbo.AcumMayor
GO
CREATE VIEW AcumMayor
--//WITH ENCRYPTION
AS 
SELECT 
  a.Empresa,
  r.Mayor,
  a.Cuenta,
  a.SubCuenta,
  a.Grupo,
  a.Ejercicio,
  a.Periodo,
  a.Moneda,
  "Cargos" = CONVERT(money, SUM(a.Cargos*r.Factor)),
  "Abonos" = CONVERT(money, SUM(a.Abonos*r.Factor))

FROM Acum a
JOIN Rama r ON a.Rama = r.Rama
GROUP BY a.Empresa, r.Mayor, a.Cuenta, a.SubCuenta, a.Grupo, a.Ejercicio, a.Periodo, a.Moneda
GO

/*** AcumMayorSucursal ***/
if exists (select * from sysobjects where id = object_id('dbo.AcumMayorSucursal') and type = 'V') drop view dbo.AcumMayorSucursal
GO
CREATE VIEW AcumMayorSucursal
--//WITH ENCRYPTION
AS 
SELECT 
  a.Empresa,
  a.Sucursal,
  r.Mayor,
  a.Cuenta,
  a.SubCuenta,
  a.Grupo,
  a.Ejercicio,
  a.Periodo,
  a.Moneda,
  "Cargos" = CONVERT(money, SUM(a.Cargos*r.Factor)),
  "Abonos" = CONVERT(money, SUM(a.Abonos*r.Factor))

FROM Acum a
JOIN Rama r ON a.Rama = r.Rama 
GROUP BY a.Empresa, a.Sucursal, r.Mayor, a.Cuenta, a.SubCuenta, a.Grupo, a.Ejercicio, a.Periodo, a.Moneda
GO

/*** AcumRama ***/
/*if exists (select * from sysobjects where id = object_id('dbo.AcumRama') and type = 'V') drop view dbo.AcumRama
*/
GO
/*CREATE VIEW AcumRama
--//WITH ENCRYPTION
AS 
SELECT 
  a.Empresa,
  a.Rama,
  a.Cuenta,
  a.SubCuenta,
  a.Grupo,
  a.Ejercicio,
  a.Periodo,
  a.Moneda,
  a.Cargos,
  a.Abonos,
  "InicialEjercicio" = ISNULL(CONVERT(money, (SELECT ISNULL(i.Cargos, 0.0)-ISNULL(i.Abonos, 0.0) FROM Acum i WHERE i.Empresa = a.Empresa AND i.Rama = a.Rama AND i.Cuenta = a.Cuenta AND i.SubCuenta = a.SubCuenta AND i.Grupo = a.Grupo AND i.Ejercicio = a.Ejercicio AND i.Periodo = 0)), 0.0)

FROM 
  Acum a

WHERE 
 Periodo > 0  
*/
GO


/*** AcumUMayor ***/
/*
if exists (select * from sysobjects where id = object_id('dbo.AcumUMayor') and type = 'V') drop view dbo.AcumUMayor
*/
GO
/*
CREATE VIEW AcumUMayor
--//WITH ENCRYPTION
AS 
SELECT 
  a.Empresa,
  r.Mayor,
  a.Cuenta,
  a.SubCuenta,
  a.Grupo,
  a.Ejercicio,
  a.Periodo,
  a.Moneda,
  "Cargos"  = CONVERT(money, SUM(a.Cargos*r.Factor)),
  "Abonos"  = CONVERT(money, SUM(a.Abonos*r.Factor)),
  "CargosU" = SUM(a.CargosU*r.Factor),
  "AbonosU" = SUM(a.AbonosU*r.Factor),
  "InicialEjercicio"  = CONVERT(money, (SELECT SUM(ISNULL(i.Cargos, 0.0)-ISNULL(i.Abonos, 0.0)*ri.Factor) FROM AcumU i, Rama ri WHERE i.Empresa = a.Empresa AND i.Rama = ri.Rama AND ri.Mayor = r.Mayor AND i.Cuenta = a.Cuenta AND i.SubCuenta = a.SubCuenta AND i.Grupo = a.Grupo AND i.Ejercicio = a.Ejercicio AND i.Periodo = 0)),
  "InicialEjercicioU" = ISNULL((SELECT SUM(ISNULL(i.CargosU, 0.0)-ISNULL(i.AbonosU, 0.0)*ri.Factor) FROM AcumU i, Rama ri WHERE i.Empresa = a.Empresa AND i.Rama = ri.Rama AND ri.Mayor = r.Mayor AND i.Cuenta = a.Cuenta AND i.SubCuenta = a.SubCuenta AND i.Grupo = a.Grupo AND i.Ejercicio = a.Ejercicio AND i.Periodo = 0), 0.0) 

FROM 
  AcumU a, Rama r

WHERE 
  a.Rama = r.Rama AND Periodo > 0

GROUP BY a.Empresa, r.Mayor, a.Cuenta, a.SubCuenta, a.Grupo, a.Ejercicio, a.Periodo, a.Moneda
*/
GO

/*** AcumURama ***/
/*if exists (select * from sysobjects where id = object_id('dbo.AcumURama') and type = 'V') drop view dbo.AcumURama
*/
GO
/*CREATE VIEW AcumURama
--//WITH ENCRYPTION
AS 
SELECT 
  a.Empresa,
  a.Rama,
  a.Cuenta,
  a.SubCuenta,
  a.Grupo,
  a.Ejercicio,
  a.Periodo,
  a.Moneda,
  a.Cargos,
  a.Abonos,
  a.CargosU,
  a.AbonosU,
  "InicialEjercicio"  = CONVERT(money, (SELECT ISNULL(i.Cargos, 0.0)-ISNULL(i.Abonos, 0.0) FROM AcumU i WHERE i.Empresa = a.Empresa AND i.Rama = a.Rama AND i.Cuenta = a.Cuenta AND i.SubCuenta = a.SubCuenta AND i.Grupo = a.Grupo AND i.Ejercicio = a.Ejercicio AND i.Periodo = 0)),
  "InicialEjercicioU" = ISNULL((SELECT ISNULL(i.CargosU, 0.0)-ISNULL(i.AbonosU, 0.0) FROM AcumU i WHERE i.Empresa = a.Empresa AND i.Rama = a.Rama AND i.Cuenta = a.Cuenta AND i.SubCuenta = a.SubCuenta AND i.Grupo = a.Grupo AND i.Ejercicio = a.Ejercicio AND i.Periodo = 0), 0.0)
FROM 
  AcumU a
WHERE 
  Periodo > 0*/
GO


/*** AcumRURama ***/
/*if exists (select * from sysobjects where id = object_id('dbo.AcumRURama') and type = 'V') drop view dbo.AcumRURama
*/
GO
/*CREATE VIEW AcumRURama
--//WITH ENCRYPTION
AS 
SELECT 
  a.Empresa,
  a.Rama,
  a.Cuenta,
  a.SubCuenta,
  a.Grupo,
  a.Ejercicio,
  a.Periodo,
  a.Moneda,
  a.Cargos,
  a.Abonos,
  a.CargosU,
  a.AbonosU,
  "InicialEjercicio"  = CONVERT(money, (SELECT ISNULL(i.Cargos, 0.0)-ISNULL(i.Abonos, 0.0) FROM AcumU i WHERE i.Empresa = a.Empresa AND i.Rama = a.Rama AND i.Cuenta = a.Cuenta AND i.SubCuenta = a.SubCuenta AND i.Grupo = a.Grupo AND i.Ejercicio = a.Ejercicio AND i.Periodo = 0)),
  "InicialEjercicioU" = ISNULL((SELECT ISNULL(i.CargosU, 0.0)-ISNULL(i.AbonosU, 0.0) FROM AcumU i WHERE i.Empresa = a.Empresa AND i.Rama = a.Rama AND i.Cuenta = a.Cuenta AND i.SubCuenta = a.SubCuenta AND i.Grupo = a.Grupo AND i.Ejercicio = a.Ejercicio AND i.Periodo = 0), 0.0)
FROM 
  AcumRU a
WHERE 
  Periodo > 0*/
GO

/*** CxcDifCambioBase ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcDifCambioBase') and type = 'V') drop view dbo.CxcDifCambioBase
GO
CREATE VIEW CxcDifCambioBase
--//WITH ENCRYPTION
AS
SELECT c.Empresa, c.Mov, c.MovID, c.FechaEmision, c.Ejercicio, c.Periodo, c.Estatus, c.Cliente,
        c.Moneda, c.TipoCambio, c.ClienteMoneda, c.ClienteTipoCambio, "Importe" = ABS(d.Importe), 
       "Aplica" = a.Mov, "AplicaID" = a.MovID, "AplicaMoneda" = a.Moneda, "AplicaTipoCambio" = a.TipoCambio, "AplicaImporteTotal" = (a.Importe+a.Impuestos), "AplicaFecha" = a.FechaEmision,
       "Porcentaje" = ABS(convert(money, round(((d.Importe*c.TipoCambio/c.ClienteTipoCambio)*100)/(a.Importe+a.Impuestos), ISNULL(vs.RedondeoMonetarios,0))))
  FROM Cxc c
  JOIN CxcD d ON c.ID = d.ID
  JOIN Cxc a ON d.AplicaID = a.MovID AND d.Aplica = a.Mov AND c.Empresa = a.Empresa AND c.Sucursal = a.Sucursal
  JOIN Version vs ON 1 = 1
 WHERE c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND c.ClienteTipoCambio <> 1.0 AND a.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
GO

/*** CxcDifCambio ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcDifCambio') and type = 'V') drop view dbo.CxcDifCambio
GO
CREATE VIEW CxcDifCambio
--//WITH ENCRYPTION
AS 
SELECT Empresa, Mov, MovID, FechaEmision, Ejercicio, Periodo, Estatus, Cliente,
       Moneda, TipoCambio, ClienteMoneda, ClienteTipoCambio, Importe, 
       Aplica, AplicaID, AplicaMoneda, AplicaTipoCambio, AplicaImporteTotal,AplicaFecha,
       Porcentaje,
       "DiferenciaMN" = -(CASE TipoCambio
			WHEN 1.0 THEN Convert(money, ((AplicaImporteTotal*Porcentaje/100.0)*AplicaTipoCambio) - Importe)
                        ELSE Convert(money, ((AplicaImporteTotal*Porcentaje/100.0)*AplicaTipoCambio) - (Importe*ClienteTipoCambio))
                      END)
  FROM CxcDifCambioBase
GO


/*** CxpDifCambioBase ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpDifCambioBase') and type = 'V') drop view dbo.CxpDifCambioBase
GO
CREATE VIEW CxpDifCambioBase
--//WITH ENCRYPTION
AS
SELECT c.Empresa, c.Mov, c.MovID, c.FechaEmision, c.Ejercicio, c.Periodo, c.Estatus, c.Proveedor,
        c.Moneda, c.TipoCambio, c.ProveedorMoneda, c.ProveedorTipoCambio, "Importe" = ABS(d.Importe), 
       "Aplica" = a.Mov, "AplicaID" = a.MovID, "AplicaMoneda" = a.Moneda, "AplicaTipoCambio" = a.TipoCambio, "AplicaImporteTotal" = (a.Importe+a.Impuestos),
       "Porcentaje" = ABS(convert(money, round(((d.Importe*c.TipoCambio/c.ProveedorTipoCambio)*100)/(a.Importe+a.Impuestos), ISNULL(vs.RedondeoMonetarios,0))))
  FROM Cxp c
  JOIN CxpD d ON c.ID=d.ID
  JOIN Cxp a ON d.AplicaID = a.MovID AND d.Aplica = a.Mov AND c.Empresa = a.Empresa AND c.Sucursal = a.Sucursal
  JOIN Version vs ON 1 = 1
 WHERE c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND c.ProveedorTipoCambio <> 1.0 AND a.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') 
go

/*** CxpDifCambio ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpDifCambio') and type = 'V') drop view dbo.CxpDifCambio
GO
CREATE VIEW CxpDifCambio
--//WITH ENCRYPTION
AS
SELECT Empresa, Mov, MovID, FechaEmision, Ejercicio, Periodo, Estatus, Proveedor,
       Moneda, TipoCambio, ProveedorMoneda, ProveedorTipoCambio, Importe, 
       Aplica, AplicaID, AplicaMoneda, AplicaTipoCambio, AplicaImporteTotal,
       Porcentaje,
       "DiferenciaMN" = CASE TipoCambio
			WHEN 1.0 THEN Convert(money, ((AplicaImporteTotal*Porcentaje/100.0)*AplicaTipoCambio) - Importe)
                        ELSE Convert(money, ((AplicaImporteTotal*Porcentaje/100.0)*AplicaTipoCambio) - (Importe*ProveedorTipoCambio))
                      END
  FROM CxpDifCambioBase
go

/*** VentaCteDevolucion ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaCteDevolucion') and type = 'V') drop view dbo.VentaCteDevolucion
GO
CREATE VIEW VentaCteDevolucion
--//WITH ENCRYPTION
AS 
	SELECT RID, Renglon, SUM(CantidadA) CantidadA
	FROM VentaDevolucion
	GROUP BY RID, Renglon
GO

/*** VentaCteD ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaCteD') and type = 'V') drop view dbo.VentaCteD
GO
CREATE VIEW VentaCteD
--//WITH ENCRYPTION
AS 
SELECT  
  l.Estacion,
  l.ID,
  l.Renglon,
  l.RenglonSub,
  l.CantidadA,
  v.Empresa,
  v.Mov,
  v.MovID,
  v.FechaEmision,
  v.Concepto,
  v.Proyecto,
  v.Moneda,
  v.TipoCambio,
  v.Usuario,
  v.Referencia,
  v.Observaciones,
  v.Estatus,
  v.Situacion,
  v.SituacionFecha,
  v.SituacionUsuario,
  v.SituacionNota,
  v.Cliente,
  d.EnviarA,
  d.Almacen,
  v.Agente,
  v.Descuento,
  v.Condicion,
  v.Vencimiento,
  v.DescuentoGlobal,
  v.SobrePrecio,
  v.Saldo,
  v.Importe,
  v.Impuestos,
  v.ComisionTotal,
  v.DescuentoLineal,
  d.RenglonTipo,
  d.Cantidad - ISNULL(VD.CantidadA, 0.0) Cantidad,
  d.CantidadInventario,
  d.Codigo,
  d.Articulo,
  d.SubCuenta,
  d.Precio,
  d.DescuentoTipo,
  d.DescuentoLinea,
  d.Impuesto1,
  d.Impuesto2,
  d.Impuesto3,
  d.DescripcionExtra,
  d.Costo,
  d.CantidadCancelada,
  a.Descripcion1
FROM Venta v
JOIN VentaD d ON v.ID = d.ID
JOIN VentaCteDLista l ON d.ID = l.ID AND d.Renglon = l.Renglon AND d.RenglonSub = l.RenglonSub
JOIN Art a ON d.Articulo = a.Articulo
LEFT JOIN VentaCteDevolucion vd ON v.ID = vd.RID AND d.Renglon = vd.Renglon
WHERE d.Cantidad - ISNULL(VD.CantidadA, 0.0) <= d.Cantidad
  AND d.Cantidad - ISNULL(VD.CantidadA, 0.0) > 0
GO

/*** CxcRef ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcRef') and type = 'V') drop view dbo.CxcRef
GO
CREATE VIEW CxcRef
--//WITH ENCRYPTION
AS 
SELECT a.Empresa, "Cliente" = a.Cuenta, "ClienteSucursal" = r.EnviarA, a.Moneda, "Mov" = a.Aplica, "MovID" = a.AplicaID, r.Referencia, r.FechaEmision, r.Vencimiento, 
       "Saldo" = ISNULL(SUM(a.Cargo), 0)-ISNULL(SUM(a.Abono), 0)/*,
       "Dias" = DATEDIFF(day, r.Vencimiento, GETDATE()), "Semanas" = DATEDIFF(week, r.Vencimiento, GETDATE())*/
  FROM Auxiliar a
 RIGHT OUTER JOIN MovRef r ON r.Empresa = a.Empresa AND r.Modulo = 'CXC' AND r.Contacto = a.Cuenta AND r.Mov = a.Aplica AND r.MovID = a.AplicaID
 WHERE a.Rama IN ('CXC', 'CEFE', 'CNO', 'CRND') 
 GROUP BY a.Empresa, a.Cuenta, a.Moneda, a.Aplica, a.AplicaID, r.Referencia, r.FechaEmision, r.Vencimiento, r.EnviarA
HAVING ISNULL(SUM(a.Cargo), 0)-ISNULL(SUM(a.Abono), 0) <> 0
GO

-- select getdate(), Vencimiento, dias, semanas from cxcpendienteref

--SET DATEFIRST 7
/*** CxcRef ***/
--if exists (select * from sysobjects where id = object_id('dbo.CxcRef') and type = 'V') drop view dbo.CxcRef
GO
/*CREATE VIEW CxcRef
--//WITH ENCRYPTION
AS 
SELECT Empresa, Cliente, ClienteSucursal, Moneda, Mov, MovID, Referencia, FechaEmision, Vencimiento, Saldo, Dias, Semanas,
"Pronostico" = 
  CONVERT(char(20), CASE WHEN Semanas = 0 AND Dias<=0 THEN 
         CASE DATEPART(weekday, Vencimiento) 
           WHEN 1 THEN 'Domingo' 
           WHEN 2 THEN 'Lunes'
           WHEN 3 THEN 'Martes'
           WHEN 4 THEN 'Miercoles'
           WHEN 5 THEN 'Jueves'
           WHEN 6 THEN 'Viernes'
           WHEN 7 THEN 'Sabado'
         END
       WHEN -Dias BETWEEN  1 AND  7 THEN '1 - 7 dias' 
       WHEN -Dias BETWEEN  8 AND 14 THEN '8 - 14 dias' 
       WHEN -Dias BETWEEN 15 AND 30 THEN '15 - 30 dias' 
       WHEN -Dias BETWEEN 31 AND 60 THEN '31 - 60 dias' 
       WHEN -Dias BETWEEN 61 AND 90 THEN '61 - 90 dias' 
       WHEN -Dias > 90              THEN 'mas 90 dias' 
       ELSE 'Vencido'
  END),
"Antiguedad" = 
  CONVERT(char(20), CASE 
    WHEN Dias BETWEEN  1 AND  7 THEN '1 - 7 dias' 
    WHEN Dias BETWEEN  8 AND 14 THEN '8 - 14 dias' 
       WHEN Dias BETWEEN 15 AND 30 THEN '15 - 30 dias' 
       WHEN Dias BETWEEN 31 AND 60 THEN '31 - 60 dias' 
       WHEN Dias BETWEEN 61 AND 90 THEN '61 - 90 dias' 
       WHEN Dias > 90              THEN 'mas 90 dias' 
       ELSE 'Al Corriente'
  END)

  FROM CxcPendienteRef*/
GO

-- select * from cxcref

/*** CxcRefAux ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcRefAux') and type = 'V') drop view dbo.CxcRefAux
GO
CREATE VIEW CxcRefAux
--//WITH ENCRYPTION
AS 
SELECT a.Empresa, "Cliente" = a.Cuenta, "ClienteSucursal" = r.EnviarA, a.Moneda, a.Mov, a.MovID, "Referencia" = ISNULL(NULLIF(RTRIM(r.Referencia), ''), a.Mov+' '+a.MovID), r.FechaEmision, r.Vencimiento, "Cargo" = SUM(a.Cargo), "Abono" = SUM(a.Abono)
  FROM Auxiliar a
 RIGHT OUTER JOIN MovRef r ON r.Empresa = a.Empresa AND r.Modulo = 'CXC' AND r.Contacto = a.Cuenta AND r.Mov = a.Mov AND r.MovID = a.MovID
 WHERE a.Rama IN ('CXC', 'CEFE', 'CNO', 'CRND') 
 GROUP BY a.Empresa, a.Cuenta, a.Moneda, a.Mov, a.MovID, r.Referencia, r.FechaEmision, r.Vencimiento, r.EnviarA
HAVING ISNULL(SUM(a.Cargo), 0) <> ISNULL(SUM(a.Abono), 0)
GO

-- select * from CxcRefAux order by referencia

/*** CxcVentaNeta ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcVentaNeta') and type = 'V') drop view dbo.CxcVentaNeta
GO
CREATE VIEW CxcVentaNeta
--//WITH ENCRYPTION
AS 
SELECT
  Cxc.Empresa,
  Cxc.FechaEmision,
  Cxc.Cliente,
  'EnviarA' = Cxc.ClienteEnviarA,
  Cxc.Proyecto,
  Cxc.UEN,
  Cxc.Agente,
  Cxc.Mov,
  Cxc.Sucursal,
  Cxc.Condicion,
  'MovTipo' = MovTipo.Clave,
  'Moneda' = Cxc.ClienteMoneda,
  'Importe'= CASE WHEN MovTipo.Clave IN ('CXC.NC','CXC.DAC','CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.DFA') THEN -Cxc.Importe ELSE Cxc.Importe END,
  'Impuestos'= CASE WHEN MovTipo.Clave IN ('CXC.NC','CXC.DAC','CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.DFA') THEN -Cxc.Impuestos ELSE Cxc.Impuestos END
      
FROM Cxc
JOIN MovTipo ON Cxc.Mov = MovTipo.Mov AND MovTipo.Modulo = 'CXC'
WHERE 
  MovTipo.Clave IN ('CXC.F', 'CXC.FA', 'CXC.DFA', 'CXC.AF', 'CXC.CA', 'CXC.CAD', 'CXC.CAP', 'CXC.VV', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP') AND
  Cxc.Estatus IN ('PENDIENTE','CONCLUIDO') 

UNION ALL

SELECT
  v.Empresa,
  v.FechaEmision,
  v.Cliente,
  v.EnviarA,
  v.Proyecto,
  v.UEN,
  v.Agente,
  v.Mov,
  v.Sucursal,
  v.Condicion,
  'MovTipo' = MovTipo.Clave,
  'Moneda' = v.Moneda,
  'Importe'= dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio),
  'Impuestos' = v.Impuestos
      
FROM Venta v
JOIN MovTipo ON v.Mov = MovTipo.Mov AND MovTipo.Modulo = 'VTAS'
WHERE 
  (MovTipo.Clave = 'VTAS.FM' OR (MovTipo.Clave IN ('VTAS.F', 'VTAS.FB') AND v.OrigenTipo = 'VMOS')) AND v.Estatus = 'CONCLUIDO'

UNION ALL

SELECT
  v.Empresa,
  v.FechaEmision,
  v.Cliente,
  v.EnviarA,
  v.Proyecto,
  v.UEN,
  v.Agente,
  v.Mov,
  v.Sucursal,
  v.Condicion,
  'MovTipo' = MovTipo.Clave,
  'Moneda' = v.Moneda,
  'Importe'   = CASE WHEN MovTipo.Clave IN ('VTAS.D', 'VTAS.DF') THEN -dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio) ELSE dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio) END,
  'Impuestos' = CASE WHEN MovTipo.Clave IN ('VTAS.D', 'VTAS.DF') THEN -v.Impuestos ELSE v.Impuestos END
      
FROM Venta v
JOIN VentaCobro vc ON v.ID = vc.ID 
JOIN MovTipo ON v.Mov = MovTipo.Mov AND MovTipo.Modulo = 'VTAS'
WHERE 
  MovTipo.Clave IN ('VTAS.F', 'VTAS.D', 'VTAS.DF')
  AND NULLIF(vc.TotalCobrado, 0) IS NOT NULL AND 
  v.Estatus = 'CONCLUIDO' 
GO


/*** CxpCompraNeta ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpCompraNeta') and type = 'V') drop view dbo.CxpCompraNeta
GO
CREATE VIEW CxpCompraNeta
--//WITH ENCRYPTION
AS 
SELECT
  Cxp.Empresa,
  Cxp.FechaEmision,
  Cxp.Proveedor,
  Cxp.Proyecto,
  Cxp.UEN,
  Cxp.Mov,
  Cxp.Sucursal,
  Cxp.Condicion,
  'MovTipo'  = MovTipo.Clave,
  'Moneda'   = Cxp.ProveedorMoneda,
  'Importe'  = CASE WHEN MovTipo.Clave IN ('CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP') THEN -Cxp.Importe   ELSE Cxp.Importe   END,
  'Impuestos'= CASE WHEN MovTipo.Clave IN ('CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP') THEN -Cxp.Impuestos ELSE Cxp.Impuestos END
      
FROM Cxp
JOIN MovTipo ON Cxp.Mov = MovTipo.Mov AND MovTipo.Modulo = 'CXP'
WHERE 
  MovTipo.Clave IN ('CXP.F', 'CXP.ESF', 'CXP.CA', 'CXP.CAD', 'CXP.AF', 'CXP.CAP', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP') AND
  Cxp.Estatus IN ('PENDIENTE','CONCLUIDO') 
GO

/********************* Reporte CotizacionVtas **************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.spCotizacionVtas') AND TYPE = 'P' ) DROP PROC spCotizacionVtas
GO
CREATE PROC  dbo.spCotizacionVtas  
	@ID   INT
--//WITH ENCRYPTION
AS 
BEGIN
	
	CREATE TABLE  #COTIZACIONPRE( 
		INDICE				INT IDENTITY(1,1),
		ID					INT,
		RENGLON				FLOAT,
		ORDENREPORTE		FLOAT NULL,
		EMPRESANOMBRE		VARCHAR(100) NULL,
		EMPRESADIRECCION	VARCHAR(250) NULL,
		CLIENTE				VARCHAR(10) NULL,
		CTENOMBRE			VARCHAR(100) NULL,
		CTEDIRECCION		VARCHAR(250) NULL,
		CTEENVNOMBRE		VARCHAR(100) NULL,
		CTEENVDIRECCION		VARCHAR(250) NULL,
		ARTICULO			VARCHAR(20) NULL,
		DESCRIPCION1		VARCHAR(100) NULL,
		DESCRIPCION2		VARCHAR(255) NULL,
		CANTIDAD			FLOAT  NULL,
		PRECIO				MONEY NULL,
		PCFDIAS				INT NULL,
		IMPORTE				MONEY NULL,
		IMPORTEVTA			MONEY NULL,
		IMPUESTOVTA			MONEY NULL,
		TIPO				VARCHAR(100) NULL,
		COLOR				INT NULL,
		MOV					VARCHAR(70)NULL,
		FECHAEMISION		DATETIME NULL,
		ATENCION			VARCHAR (100) NULL,
		VTASOBSER			VARCHAR(100) NULL,
		ENVIAR				INT NULL,
		CONCEPTO			VARCHAR (100) NULL,
		descuento			MONEY  NULL,
		nameagent			VARCHAR(100) NULL,
		TIPONOMBRE			VARCHAR(100) NULL
	)


	DECLARE @DIASENCABEZADO INT,
		@DIASTEXTO	VARCHAR(40),
		@DESCUENTO  MONEY,
		@fechad		DATETIME,
		@fechaa		DATETIME,
		@dias		INT,
		@meses		INT,
		@diasletra  VARCHAR(5),
		@mesesletra VARCHAR(5)

	SELECT @fechad = VigenciaDesde, @fechaa = VigenciaHasta FROM Venta WHERE id = @id
	SELECT @meses = FLOOR((DATEDIFF(DAY, @fechad, @fechaa) + 1) / 30)
	SELECT @dias = DATEDIFF(DAY, @fechad, @fechaa) + 1
	SELECT @diasletra = CONVERT (VARCHAR(5), @dias)
	SELECT @mesesletra = CONVERT (VARCHAR(5), @meses)
	SELECT @DESCUENTO = SUM(ISNULL(DESCUENTOSTOTALES, 0)) FROM VENTATCALC WHERE ID = @ID
	SELECT @DIASENCABEZADO = 0 --MAX( PCFDIAS ) FROM VENTAD WHERE ID=@ID
	SELECT @DIASTEXTO = @diasletra + CASE WHEN @dias = 1 THEN ' DIA ' ELSE ' DIAS ' END + CASE WHEN @meses = 0 THEN '' ELSE ' EN ' + @mesesletra + CASE WHEN @meses = 1 THEN 'MES' ELSE ' MESES ' END END 
	--select  @meses=datediff(month,@fechad,@fechaa) + 1
	--CONVERT (VARCHAR(12),@DIASENCABEZADO)+ case when @DIASENCABEZADO=1 then ' DIA ' else   ' DIAS ' end
	--select * from ventatcalc where id=460
	
	INSERT INTO #COTIZACIONPRE (ID, RENGLON, ORDENREPORTE, EMPRESANOMBRE, EMPRESADIRECCION, CLIENTE, CTENOMBRE, CTEDIRECCION, CTEENVNOMBRE, CTEENVDIRECCION, ARTICULO, DESCRIPCION1, DESCRIPCION2, CANTIDAD, PRECIO,
		IMPORTE, IMPORTEVTA, IMPUESTOVTA, TIPO, COLOR, MOV, FECHAEMISION, ATENCION, VTASOBSER, ENVIAR, CONCEPTO, descuento, nameagent, TIPONOMBRE)
	SELECT V.ID, D.RENGLON, 1.1, E.NOMBRE, ISNULL(E.DIRECCION, '') + '  ' + ISNULL(E.DireccionNumero, '') + '  ' + ISNULL(E.DIRECCIONNUMEROINT, '') + ISNULL(E.Colonia, '') + ' ' + ISNULL(E.CodigoPostal, ''),
		C.CLIENTE, C.nombre, ISNULL(c.DIRECCION, '') + '  ' + ISNULL(c.DireccionNumero, '') + '  ' + ISNULL(c.DIRECCIONNUMEROINT, '') + ISNULL(c.Colonia, '') + ' ' + ISNULL(c.CodigoPostal, ''),
		ISNULL(T.nombre, ''), ISNULL(T.DIRECCION, '') + '  ' + ISNULL(T.DireccionNumero, '') + '  ' + ISNULL(T.DIRECCIONNUMEROINT, '') + ISNULL(T.Colonia, '') + ' ' + ISNULL(T.CodigoPostal, ''),
		a.articulo, CASE WHEN a.Categoria = 'NO EXISTE' THEN ISNULL(D.DescripcionExtra, 'ESCRIBE EN EL CAMPO OBSERVACIONES') ELSE A.DESCRIPCION1 END, SPACE(25) + SUBSTRING(A.Descripcion2, 1, 120), D.CANTIDAD, D.PRECIO, 
		D.CANTIDAD * D.PRECIO * 0,V.IMPORTE, V.Impuestos, '', 0, V.MOV + ' ' + V.MOVID, V.FECHAEMISION, V.ATENCION, V.OBSERVACIONES, V.EnviarA, V.Concepto, @DESCUENTO, gn.Nombre, ''
	FROM Venta V 
		LEFT OUTER JOIN VentaD D		ON	V.ID = D.ID
		LEFT OUTER JOIN Cte C			ON	V.Cliente =C.Cliente
		LEFT OUTER JOIN CteEnviarA T	ON	V.Cliente = T.Cliente AND V.EnviarA = T.ID
		LEFT OUTER JOIN Empresa E       ON	V.Empresa = E.Empresa
		LEFT OUTER JOIN Art a			ON	D.Articulo = A.Articulo
		LEFT OUTER JOIN Agente gn       ON	v.Agente = gn.Agente
	WHERE V.ID = @ID

	CREATE TABLE #OBSERVA1(
		INDICE	INT IDENTITY(2,2),
		ASUNTO  VARCHAR(250) NULL,	
		TIPO	VARCHAR(100) NULL
	)

	CREATE TABLE #OBSERVA2 (
		INDICE			INT IDENTITY(1,1),
		IDVTAS			INT,
		ASUNTO			VARCHAR(255) NULL,	
		TIPO			VARCHAR(100) NULL,
		TIPOANTERIOR	VARCHAR(100) NULL,
		COLOR			INT NULL
	)

--  INSERT INTO #OBSERVA1
	DECLARE @ASUNTO	VARCHAR(255),
		@TIPO			VARCHAR(100),
		@TIPOANTERIOR	VARCHAR(100),
		@GRIS			INT,
		@BLANCO			INT,
		@COLORANTERIOR	INT
		
	SELECT @GRIS = 1, @BLANCO = 0, @COLORANTERIOR = 0
	
	DECLARE GRIS_BLANCO 
	CURSOR FOR
		SELECT ASUNTO, TIPO 
		FROM TAREA 
		WHERE MODULOID = @ID AND MODULO = 'VTAS' AND estado = 'Completada'  
		ORDER BY Tipo
			
	OPEN GRIS_BLANCO
	FETCH NEXT FROM GRIS_BLANCO
	INTO @ASUNTO, @TIPO
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT  @COLORANTERIOR = @GRIS - @COLORANTERIOR
		INSERT INTO #OBSERVA2 (IDVTAS, ASUNTO, TIPO, TIPOANTERIOR, COLOR)
		VALUES (@ID, @ASUNTO, @TIPO, ISNULL(@TIPOANTERIOR, @TIPO), @COLORANTERIOR)
		SELECT  @TIPOANTERIOR = @TIPO
		--SELECT  @COLORANTERIOR=@GRIS
		
		FETCH NEXT FROM GRIS_BLANCO
		INTO @ASUNTO,@TIPO
	END
	CLOSE GRIS_BLANCO
	DEALLOCATE GRIS_BLANCO

	INSERT INTO #COTIZACIONPRE
	SELECT V.ID, 204800, 10.1, E.NOMBRE, ISNULL(E.DIRECCION, '') + '  ' + ISNULL(E.DireccionNumero, '') + '  ' + ISNULL(E.DIRECCIONNUMEROINT, '') + ISNULL(E.Colonia, '') + ' ' + ISNULL(E.CodigoPostal, ''),
		c.cliente,C.nombre, ISNULL(c.DIRECCION, '') + '  ' + ISNULL(c.DireccionNumero, '') + '  ' + ISNULL(c.DIRECCIONNUMEROINT, '') + ISNULL(c.Colonia, '') + ' ' + ISNULL(c.CodigoPostal, ''),
		ISNULL(T.nombre, ''), ISNULL(T.DIRECCION, '') + '  ' + ISNULL(T.DireccionNumero, '') + '  ' + ISNULL(T.DIRECCIONNUMEROINT, '') + ISNULL(T.Colonia, '') + ' ' + ISNULL(T.CodigoPostal, ''),
		'', '', SER.ASUNTO, 0, 0, 0, 0, V.IMPORTE, V.Impuestos, SER.TIPO, SER.COLOR, V.MOV + ' ' + V.MOVID, V.FECHAEMISION, V.ATENCION, V.OBSERVACIONES, V.EnviarA, CONCEPTO, @DESCUENTO, gn.nombre,
		SER.TIPO
	FROM Venta V		
		LEFT OUTER JOIN Cte C			ON	V.Cliente = C.Cliente
		LEFT OUTER JOIN CteEnviarA T	ON	V.Cliente = T.Cliente AND V.EnviarA = T.ID
		LEFT OUTER JOIN Empresa E       ON  V.Empresa = E.Empresa
		LEFT OUTER JOIN Agente gn		ON	v.Agente = gn.agente
		LEFT OUTER JOIN #OBSERVA2 SER	ON  V.ID = SER.IDVTAS 
		--LEFT OUTER JOIN VENTAD  D		ON	V.ID=D.ID
		--LEFT OUTER JOIN ART A			ON	D.ARTICULO=A.ARTICULO
	WHERE V.ID = @ID
	ORDER BY SER.INDICE
	
	SELECT  *, DIASTEXTO = @DIASTEXTO, diasletra = @diasletra, mesesletra = @mesesletra  
	FROM #COTIZACIONPRE

END
GO

/********************* Reporte FacturaVta **************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.spFacturaVta') AND TYPE = 'P' ) DROP PROC spFacturaVta
GO
CREATE PROCEDURE dbo.spFacturaVta
	@ID INT
--//WITH ENCRYPTION
AS BEGIN
	SELECT	V.ID,
			V.Mov,
			V.MovID,
			V.FechaEmision,
			V.UEN,
			V.Moneda,
			CONVERT(FLOAT, V.TipoCambio) TipoCambioMov,
			V.Cliente,
			C.Nombre,
			C.RFC,
			C.Direccion,
			C.DireccionNumero,
			C.DireccionNumeroInt,
			C.EntreCalles,
			C.Observaciones,
			C.Delegacion,
			C.Colonia,
			C.CodigoPostal,
			C.Estado,
			C.Pais,
			C.Telefonos,
			C.TelefonosLada,
			C.Fax,
			C.eMail1,
			CA.Nombre AS CteSucNombre,
			CA.Direccion AS CteSucDireccion,
			CA.DireccionNumero AS CteSucDireccionNum,
			CA.DireccionNumeroInt AS CteSucDirNumInt,
			CA.EntreCalles AS CteSucEntreCalles,
			CA.Observaciones AS CteSucObservaciones,
			CA.Delegacion AS CteSucDelegacion,
			CA.Colonia AS CteSucColonia,
			CA.CodigoPostal AS CteSucCodigoPostal,
			CA.Estado AS CteSucEstado,
			CA.Pais AS CteSucPais,
			CA.Telefonos As CteSucTelefonos,
			CA.Fax AS CteSucFax,
			CA.eMail1 AS CteSuceMail1,
			V.Renglon,
			CONVERT(INT, V.RenglonID) AS RENGLONID,
			V.Articulo,
			V.Cantidad,
			A.Descripcion1 + ' ' + ISNULL(NULLIF(V.DescripcionExtra, ''), '') AS DESCRIPCIONART,
			DATALENGTH(A.Descripcion1 + ' ' + ISNULL(NULLIF(V.DescripcionExtra, ''), '')) AS LARGODESCART,
			VD.Precio PrecioME,
			VD.PrecioTipoCambio,
			VD.Precio * VD.PrecioTipoCambio PrecioMN,
			VD.Precio * VD.Cantidad AS IMPORTETOTALME,
			VD.Precio * VD.Cantidad * VD.PrecioTipoCambio AS ImporteTotalMN,
			VD.DescuentoLinea,
			VD.PrecioMoneda,
			V.SUBTOTAL SubTotalMov,
			V.Impuestos ImpuestosMov,
			V.DescuentosTotales DescTotalesMov,
			V.TotalNeto TotalNetoMov,
			'DESCRIPCION' AS RENGLONREPTIPO,
			1.0 AS ORDENREP,
			V.Empresa,
			E.Nombre AS EmpresaNombre,
			AC.Direccion AS LOGORUTA,
			V.Agente,
			AG.Nombre AS AGENTENOMBRE,
			VE.EnviarA,
			E.RFC EmpresaRFC,
			E.Direccion EmpresaDir,
			E.DireccionNumero EmpresaDirNum,
			E.DireccionNumeroInt EmpresaDirNumInt,
			E.Colonia EmpresaColonia,
			E.CodigoPostal EmpresaCP,
			E.Poblacion EmpresaPoblacion,
			E.Delegacion EmpresaDelegacion,
			E.Estado EmpresaEDO,
			E.Pais EmpresaPais,
			E.Telefonos EmpresaTel,
			E.Fax EmpresaFax,
			V.Sucursal VentaSucursal,
			S.Nombre SucursalNombre,
			S.Direccion SucursalDir,
			S.DireccionNumero SucursalDirNum,
			S.DireccionNumeroInt SucursalDirNumInt,
			S.Colonia SucursalColonia,
			S.CodigoPostal SucursalCP,
			S.Delegacion SucursalDelegacion,
			S.Estado SucursalEDO,
			S.Poblacion SucursalPoblacion,
			S.Pais SucursalPais,
			S.Telefonos SucursalTel,
			S.Fax SucursalFax,
			i.Fecha FechaCFD,
			i.FechaTimbrado,
			i.noCertificado,
			i.noCertificadoSAT,
			CONVERT(VARCHAR(100), i.UUID) UUID,
			i.Sello,
			i.SelloSAT,
			i.TFDCadenaOriginal,
			CONVERT(VARCHAR(50), NULL) AS SERIELOTE,
			CONVERT(VARCHAR(100), NULL) AS ADUANA,
			CONVERT(DATE, NULL) AS FECHAADUANA,
			CONVERT(VARCHAR(50), NULL) AS PEDIMENTO,
			(SELECT Direccion FROM AnexoCta WHERE RAMA = 'EMP' AND CUENTA = V.Empresa AND TIPO = 'Imagen' AND Nombre = 'LOGO') AS CODIGO,
			(SELECT NOMBRE FROM FISCALREGIMEN WHERE FiscalRegimen = E.FiscalRegimen) AS REGIMENFISCAL,
			ISNULL(VC.FormaCobro1, (SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)) AS FormaCobro1,
			VC.FormaCobro2,
			VC.FormaCobro3,
			VC.FormaCobro4,
			VC.FormaCobro5,
			ISNULL(VC.Referencia1, (SELECT CuentaPago FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)) AS Referencia1,
			VC.Referencia2,
			VC.Referencia3,
			VC.Referencia4,
			VC.Referencia5,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.Referencia1, ''), (SELECT CUENTAPAGO FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)), '')
				IS NOT NULL OR NULLIF(VC.Referencia2, '') IS NOT NULL OR NULLIF(VC.Referencia3, '') IS NOT NULL OR NULLIF(VC.Referencia4, '') IS NOT NULL OR NULLIF(VC.Referencia5, '') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSREFCOBRO,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.FormaCobro1, ''),(SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)), '') 
				IS NOT NULL OR NULLIF(VC.FormaCobro2,'') IS NOT NULL OR NULLIF(VC.FormaCobro3,'') IS NOT NULL OR NULLIF(VC.FormaCobro4,'') IS NOT NULL OR NULLIF(VC.FormaCobro5,'') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSFORMAPAGO,
			V.Unidad UNIDADVTA,
			CAD.Nombre AS CteEnviarNombre,
			CAD.Direccion AS CteEnviarDireccion,
			CAD.DireccionNumero AS CteEnviarDireccionNum,
			CAD.DireccionNumeroInt AS CteEnviarDirNumInt,
			CAD.EntreCalles AS CteEnviarEntreCalles,
			CAD.Observaciones AS CteEnviarObservaciones,
			CAD.Delegacion AS CteEnviarDelegacion,
			CAD.Colonia AS CteEnviarColonia,
			CAD.CodigoPostal AS CteEnviarCodigoPostal,
			CAD.Estado AS CteEnviarEstado,
			CAD.Pais AS CteEnviarPais,
			CAD.Telefonos As CteEnviarTelefonos,
			CAD.Fax AS CteEnviarFax,
			CAD.eMail1 AS CteEnviareMail1,
			NULLIF(VE.EnviarA, '') CteEnviarA
	INTO #REPPRESUPUESTO
	FROM VENTATCALC V
		JOIN VENTA VE ON V.ID = VE.ID
		JOIN Cte C ON V.CLIENTE = C.Cliente
		LEFT OUTER JOIN CteEnviarA CA ON V.Cliente = CA.Cliente AND VE.EnviarA = CA.ID
		JOIN ART A ON V.ARTICULO = A.ARTICULO
		JOIN VENTAD VD ON V.ID = VD.ID AND V.Renglon = VD.Renglon AND V.RenglonID = VD.RenglonID 
		JOIN EMPRESA E ON V.Empresa = E.Empresa
		LEFT OUTER JOIN AnexoCta AC ON V.Empresa = AC.Cuenta AND CONVERT(VARCHAR(10), V.ContUso) + 'F' = AC.Nombre AND AC.Rama = 'EMP' AND AC.Tipo = 'Imagen'
		LEFT OUTER JOIN Agente AG ON V.Agente = AG.Agente
		JOIN Sucursal S ON V.Sucursal = S.Sucursal
		LEFT OUTER JOIN CFD i ON V.ID = i.ModuloID AND i.Modulo = 'VTAS' 
		LEFT OUTER JOIN VentaCobro VC ON V.ID = VC.ID
		LEFT OUTER JOIN CteEnviarA CAD ON CAD.Cliente = V.Cliente AND VD.EnviarA = CAD.ID
	WHERE V.ID = @ID AND VD.RENGLONTIPO IN ('N','J','L','S')

	--SERIESLOTES

	INSERT INTO #REPPRESUPUESTO
	SELECT	V.ID,
			V.Mov,
			V.MovID,
			V.FechaEmision,
			V.UEN,
			V.Moneda,
			V.TipoCambio,
			V.Cliente,
			C.Nombre,
			C.RFC,
			C.Direccion,
			C.DireccionNumero,
			C.DireccionNumeroInt,
			C.EntreCalles,
			C.Observaciones,
			C.Delegacion,
			C.Colonia,
			C.CodigoPostal,
			C.Estado,
			C.Pais,
			C.Telefonos,
			C.TelefonosLada,
			C.Fax,
			C.eMail1,
			CA.Nombre AS CteSucNombre,
			CA.Direccion AS CteSucDireccion,
			CA.DireccionNumero AS CteSucDireccionNum,
			CA.DireccionNumeroInt AS CteSucDirNumInt,
			CA.EntreCalles AS CteSucEntreCalles,
			CA.Observaciones AS CteSucObservaciones,
			CA.Delegacion AS CteSucDelegacion,
			CA.Colonia AS CteSucColonia,
			CA.CodigoPostal AS CteSucCodigoPostal,
			CA.Estado AS CteSucEstado,
			CA.Pais AS CteSucPais,
			CA.Telefonos As CteSucTelefonos,
			CA.Fax AS CteSucFax,
			CA.eMail1 AS CteSuceMail1,
			V.Renglon,
			V.RenglonID,
			V.Articulo,
			0 AS Cantidad,
			A.Descripcion1 + ' ' + ISNULL(NULLIF(V.DescripcionExtra, ''), '') AS DESCRIPCIONART,
			DATALENGTH(A.Descripcion1 + ' ' + ISNULL(NULLIF(V.DescripcionExtra, ''), '')) AS LARGODESCART,
			0 AS PrecioME,
			0 AS PrecioTipoCambio,
			0 AS PrecioMN,
			0 AS IMPORTETOTALME,
			0 AS ImporteTotalMN,
			0 AS DescuentoLinea,
			VD.PrecioMoneda,
			0 AS SubTotalMov,
			0 AS ImpuestosMov,
			0 AS DescTotalesMov,
			0 AS TotalNetoMov,
			'SERIELOTE' AS RENGLONREPTIPO,
			2.0 AS ORDENREP,
			V.Empresa,
			E.Nombre AS EmpresaNombre,
			AC.Direccion AS LOGORUTA,
			V.Agente,
			AG.Nombre AS AGENTENOMBRE,
			VE.EnviarA,
			E.RFC EmpresaRFC,
			E.Direccion EmpresaDir,
			E.DireccionNumero EmpresaDirNum,
			E.DireccionNumeroInt EmpresaDirNumInt,
			E.Colonia EmpresaColonia,
			E.CodigoPostal EmpresaCP,
			E.Poblacion EmpresaPoblacion,
			E.Delegacion EmpresaDelegacion,
			E.Estado EmpresaEDO,
			E.Pais EmpresaPais,
			E.Telefonos EmpresaTel,
			E.Fax EmpresaFax,
			V.Sucursal VentaSucursal,
			S.Nombre SucursalNombre,
			S.Direccion SucursalDir,
			S.DireccionNumero SucursalDirNum,
			S.DireccionNumeroInt SucursalDirNumInt,
			S.Colonia SucursalColonia,
			S.CodigoPostal SucursalCP,
			S.Delegacion SucursalDelegacion,
			S.Estado SucursalEDO,
			S.Poblacion SucursalPoblacion,
			S.Pais SucursalPais,
			S.Telefonos SucursalTel,
			S.Fax SucursalFax,
			i.Fecha FechaCFD,
			i.FechaTimbrado,
			i.noCertificado,
			i.noCertificadoSAT,
			i.UUID,
			i.Sello,
			i.SelloSAT,
			i.TFDCadenaOriginal,
			SLM.SerieLote AS SERIELOTE,
			SLP.Aduana AS ADUANA,
			SLP.Fecha1 AS FECHAADUANA,
			SLM.Propiedades AS PEDIMENTO,
			(SELECT Direccion FROM AnexoCta WHERE RAMA = 'EMP' AND CUENTA = V.Empresa AND TIPO = 'Imagen' AND Nombre = 'LOGO') AS CODIGO,
			(SELECT NOMBRE FROM FISCALREGIMEN WHERE FiscalRegimen = E.FiscalRegimen) AS REGIMENFISCAL,
			ISNULL(VC.FormaCobro1, (SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)) AS FormaCobro1,
			VC.FormaCobro2,
			VC.FormaCobro3,
			VC.FormaCobro4,
			VC.FormaCobro5,
			ISNULL(VC.Referencia1, (SELECT CuentaPago FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)) AS Referencia1,
			VC.Referencia2,
			VC.Referencia3,
			VC.Referencia4,
			VC.Referencia5,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.Referencia1, ''), (SELECT CUENTAPAGO FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)), '')
				IS NOT NULL OR NULLIF(VC.Referencia2, '') IS NOT NULL OR NULLIF(VC.Referencia3, '') IS NOT NULL OR NULLIF(VC.Referencia4, '') IS NOT NULL OR NULLIF(VC.Referencia5, '') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSREFCOBRO,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.FormaCobro1, ''), (SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)), '') 
				IS NOT NULL OR NULLIF(VC.FormaCobro2, '') IS NOT NULL OR NULLIF(VC.FormaCobro3, '') IS NOT NULL OR NULLIF(VC.FormaCobro4, '') IS NOT NULL OR NULLIF(VC.FormaCobro5, '') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSFORMAPAGO,
			V.Unidad UNIDADVTA,
			CAD.Nombre AS CteEnviarNombre,
			CAD.Direccion AS CteEnviarDireccion,
			CAD.DireccionNumero AS CteEnviarDireccionNum,
			CAD.DireccionNumeroInt AS CteEnviarDirNumInt,
			CAD.EntreCalles AS CteEnviarEntreCalles,
			CAD.Observaciones AS CteEnviarObservaciones,
			CAD.Delegacion AS CteEnviarDelegacion,
			CAD.Colonia AS CteEnviarColonia,
			CAD.CodigoPostal AS CteEnviarCodigoPostal,
			CAD.Estado AS CteEnviarEstado,
			CAD.Pais AS CteEnviarPais,
			CAD.Telefonos As CteEnviarTelefonos,
			CAD.Fax AS CteEnviarFax,
			CAD.eMail1 AS CteEnviareMail1,
			NULLIF(VE.EnviarA, '') CteEnviarA
	FROM VENTATCALC V
		JOIN VENTA VE ON V.ID = VE.ID
		JOIN Cte C ON V.CLIENTE = C.Cliente
		LEFT OUTER JOIN CteEnviarA CA ON V.Cliente = CA.Cliente AND VE.EnviarA = CA.ID
		JOIN ART A ON V.ARTICULO = A.ARTICULO
		JOIN VENTAD VD ON V.ID = VD.ID AND V.Renglon = VD.Renglon AND V.RenglonID = VD.RenglonID
		JOIN EMPRESA E ON V.Empresa = E.Empresa
		LEFT OUTER JOIN AnexoCta AC ON V.Empresa = AC.Cuenta AND CONVERT(VARCHAR(10), V.ContUso) + 'F' = AC.Nombre AND AC.Rama = 'EMP' AND AC.Tipo = 'Imagen'
		LEFT OUTER JOIN Agente AG ON V.Agente = AG.Agente
		JOIN Sucursal S ON V.Sucursal = S.Sucursal
		LEFT OUTER JOIN CFD i ON V.ID = i.ModuloID AND i.Modulo = 'VTAS' 
		JOIN SerieLoteMov SLM ON V.ID = SLM.ID AND SLM.Modulo = 'VTAS' AND V.Articulo = SLM.Articulo AND V.RenglonID = SLM.RenglonID
		LEFT OUTER JOIN SerieLoteProp SLP ON SLM.Propiedades = SLP.Propiedades
		LEFT OUTER JOIN VentaCobro VC ON V.ID = VC.ID
		LEFT OUTER JOIN CteEnviarA CAD ON CAD.Cliente = V.Cliente AND VD.EnviarA = CAD.ID
	WHERE V.ID = @ID 

	--ANTICIPOSAPLICADOS

	INSERT INTO #REPPRESUPUESTO
	SELECT	V.ID,
			V.Mov,
			V.MovID,
			V.FechaEmision,
			V.UEN,
			V.Moneda,
			V.TipoCambio,
			V.Cliente,
			C.Nombre,
			C.RFC,
			C.Direccion,
			C.DireccionNumero,
			C.DireccionNumeroInt,
			C.EntreCalles,
			C.Observaciones,
			C.Delegacion,
			C.Colonia,
			C.CodigoPostal,
			C.Estado,
			C.Pais,
			C.Telefonos,
			C.TelefonosLada,
			C.Fax,
			C.eMail1,
			CA.Nombre AS CteSucNombre,
			CA.Direccion AS CteSucDireccion,
			CA.DireccionNumero AS CteSucDireccionNum,
			CA.DireccionNumeroInt AS CteSucDirNumInt,
			CA.EntreCalles AS CteSucEntreCalles,
			CA.Observaciones AS CteSucObservaciones,
			CA.Delegacion AS CteSucDelegacion,
			CA.Colonia AS CteSucColonia,
			CA.CodigoPostal AS CteSucCodigoPostal,
			CA.Estado AS CteSucEstado,
			CA.Pais AS CteSucPais,
			CA.Telefonos As CteSucTelefonos,
			CA.Fax AS CteSucFax,
			CA.eMail1 AS CteSuceMail1,
			(SELECT MAX(Renglon) + 1 FROM VENTAD WHERE ID = V.ID) AS Renglon,
			(SELECT MAX(RenglonID) + 1 FROM VENTAD WHERE ID = V.ID) AS RenglonID,
			'ANTICIPO' AS Articulo,
			1 AS Cantidad,
			'ANTICIPO FACTURADO' AS DESCRIPCIONART,
			DATALENGTH('ANTICIPO FACTURADO') AS LARGODESCART,
			0 AS PrecioME,
			0 AS PrecioTipoCambio,
			(V.ANTICIPOSFACTURADOS - V.ANTICIPOSIMPUESTOS) * -1 AS PrecioMN,
			0 AS IMPORTETOTALME,
			(V.ANTICIPOSFACTURADOS - V.ANTICIPOSIMPUESTOS) * -1 AS ImporteTotalMN,
			NULL AS DescuentoLinea,
			'' AS PRECIOMONEDA,
			(V.ANTICIPOSFACTURADOS - V.ANTICIPOSIMPUESTOS) * -1 AS SubTotalMov,
			V.ANTICIPOSIMPUESTOS * -1 AS ImpuestosMov,
			0 AS DescTotalesMov,
			V.ANTICIPOSFACTURADOS * -1 AS TotalNetoMov,
			'ANTICIPOS' AS RENGLONREPTIPO,
			1.0 AS ORDENREP,
			V.Empresa,
			E.Nombre AS EmpresaNombre,
			AC.Direccion AS LOGORUTA,
			V.Agente,
			AG.Nombre AS AGENTENOMBRE,
			V.EnviarA,
			E.RFC EmpresaRFC,
			E.Direccion EmpresaDir,
			E.DireccionNumero EmpresaDirNum,
			E.DireccionNumeroInt EmpresaDirNumInt,
			E.Colonia EmpresaColonia,
			E.CodigoPostal EmpresaCP,
			E.Poblacion EmpresaPoblacion,
			E.Delegacion EmpresaDelegacion,
			E.Estado EmpresaEDO,
			E.Pais EmpresaPais,
			E.Telefonos EmpresaTel,
			E.Fax EmpresaFax,
			V.Sucursal VentaSucursal,
			S.Nombre SucursalNombre,
			S.Direccion SucursalDir,
			S.DireccionNumero SucursalDirNum,
			S.DireccionNumeroInt SucursalDirNumInt,
			S.Colonia SucursalColonia,
			S.CodigoPostal SucursalCP,
			S.Delegacion SucursalDelegacion,
			S.Estado SucursalEDO,
			S.Poblacion SucursalPoblacion,
			S.Pais SucursalPais,
			S.Telefonos SucursalTel,
			S.Fax SucursalFax,
			i.Fecha FechaCFD,
			i.FechaTimbrado,
			i.noCertificado,
			i.noCertificadoSAT,
			i.UUID,
			i.Sello,
			i.SelloSAT,
			i.TFDCadenaOriginal,
			NULL AS SERIELOTE,
			NULL AS ADUANA,
			NULL AS FECHAADUANA,
			NULL AS PEDIMENTO,
			(SELECT Direccion FROM AnexoCta WHERE RAMA = 'EMP' AND CUENTA = V.Empresa AND TIPO = 'Imagen' AND Nombre = 'LOGO') AS CODIGO,
			(SELECT NOMBRE FROM FISCALREGIMEN WHERE FiscalRegimen = E.FiscalRegimen) AS REGIMENFISCAL,
			ISNULL(VC.FormaCobro1, (SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)) AS FormaCobro1,
			VC.FormaCobro2,
			VC.FormaCobro3,
			VC.FormaCobro4,
			VC.FormaCobro5,
			ISNULL(VC.Referencia1, (SELECT CuentaPago FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)) AS Referencia1,
			VC.Referencia2,
			VC.Referencia3,
			VC.Referencia4,
			VC.Referencia5,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.Referencia1, ''), (SELECT CUENTAPAGO FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)), '')
				IS NOT NULL OR NULLIF(VC.Referencia2, '') IS NOT NULL OR NULLIF(VC.Referencia3, '') IS NOT NULL OR NULLIF(VC.Referencia4, '') IS NOT NULL OR NULLIF(VC.Referencia5, '') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSREFCOBRO,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.FormaCobro1, ''),(SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)), '') 
				IS NOT NULL OR NULLIF(VC.FormaCobro2, '') IS NOT NULL OR NULLIF(VC.FormaCobro3, '') IS NOT NULL OR NULLIF(VC.FormaCobro4, '') IS NOT NULL OR NULLIF(VC.FormaCobro5, '') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSFORMAPAGO,
			'NO APLICA' UNIDADVTA,
			'' AS CteEnviarNombre,
			'' AS CteEnviarDireccion,
			'' AS CteEnviarDireccionNum,
			'' AS CteEnviarDirNumInt,
			'' AS CteEnviarEntreCalles,
			'' AS CteEnviarObservaciones,
			'' AS CteEnviarDelegacion,
			'' AS CteEnviarColonia,
			'' AS CteEnviarCodigoPostal,
			'' AS CteEnviarEstado,
			'' AS CteEnviarPais,
			'' As CteEnviarTelefonos,
			'' AS CteEnviarFax,
			'' AS CteEnviareMail1,
			NULLIF(V.EnviarA, '') CteEnviarA
	FROM Venta V
		JOIN Cte C ON V.CLIENTE = C.Cliente
		LEFT OUTER JOIN CteEnviarA CA ON V.Cliente = CA.Cliente AND V.EnviarA = CA.ID
		JOIN EMPRESA E ON V.Empresa = E.Empresa
		LEFT OUTER JOIN AnexoCta AC ON V.Empresa = AC.Cuenta AND CONVERT(VARCHAR(10), V.ContUso) + 'F' = AC.Nombre AND AC.Rama = 'EMP' AND AC.Tipo = 'Imagen'
		LEFT OUTER JOIN Agente AG ON V.Agente = AG.Agente
		JOIN Sucursal S ON V.Sucursal = S.Sucursal
		LEFT OUTER JOIN CFD i ON V.ID = i.ModuloID AND i.Modulo = 'VTAS' 
		LEFT OUTER JOIN VentaCobro VC ON V.ID = VC.ID
	WHERE V.ID = @ID AND NULLIF(V.AnticiposFacturados, '') IS NOT NULL


	SELECT * FROM #REPPRESUPUESTO 
	ORDER BY ID, Renglon, RenglonID, ORDENREP
END
GO

/********************* Reporte NotaCreditoVta **************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.spNotaCreditoVta') AND TYPE = 'P' ) DROP PROC spNotaCreditoVta
GO
CREATE PROCEDURE dbo.spNotaCreditoVta
	@ID INT
--//WITH ENCRYPTION
AS BEGIN
	SELECT	V.ID,
			V.Mov,
			V.MovID,
			V.FechaEmision,
			V.UEN,
			V.Moneda,
			CONVERT(FLOAT, V.TipoCambio) TipoCambioMov,
			V.Cliente,
			C.Nombre,
			C.RFC,
			C.Direccion,
			C.DireccionNumero,
			C.DireccionNumeroInt,
			C.EntreCalles,
			C.Observaciones,
			C.Delegacion,
			C.Colonia,
			C.CodigoPostal,
			C.Estado,
			C.Pais,
			C.Telefonos,
			C.TelefonosLada,
			C.Fax,
			C.eMail1,
			CA.Nombre AS CteSucNombre,
			CA.Direccion AS CteSucDireccion,
			CA.DireccionNumero AS CteSucDireccionNum,
			CA.DireccionNumeroInt AS CteSucDirNumInt,
			CA.EntreCalles AS CteSucEntreCalles,
			CA.Observaciones AS CteSucObservaciones,
			CA.Delegacion AS CteSucDelegacion,
			CA.Colonia AS CteSucColonia,
			CA.CodigoPostal AS CteSucCodigoPostal,
			CA.Estado AS CteSucEstado,
			CA.Pais AS CteSucPais,
			CA.Telefonos As CteSucTelefonos,
			CA.Fax AS CteSucFax,
			CA.eMail1 AS CteSuceMail1,
			V.Renglon,
			CONVERT(INT, V.RenglonID) AS RENGLONID,
			V.Articulo,
			V.Cantidad,
			A.Descripcion1 + ' ' + ISNULL(NULLIF(V.DescripcionExtra, ''), '') AS DESCRIPCIONART,
			DATALENGTH(A.Descripcion1 + ' ' + ISNULL(NULLIF(V.DescripcionExtra, ''), '')) AS LARGODESCART,
			VD.Precio PrecioME,
			VD.PrecioTipoCambio,
			VD.Precio * VD.PrecioTipoCambio PrecioMN,
			VD.Precio * VD.Cantidad AS IMPORTETOTALME,
			VD.Precio * VD.Cantidad * VD.PrecioTipoCambio AS ImporteTotalMN,
			VD.DescuentoLinea,
			VD.PrecioMoneda,
			V.SUBTOTAL SubTotalMov,
			V.Impuestos ImpuestosMov,
			V.DescuentosTotales DescTotalesMov,
			V.TotalNeto TotalNetoMov,
			'DESCRIPCION' AS RENGLONREPTIPO,
			1.0 AS ORDENREP,
			V.Empresa,
			E.Nombre AS EmpresaNombre,
			AC.Direccion AS LOGORUTA,
			V.Agente,
			AG.Nombre AS AGENTENOMBRE,
			VE.EnviarA,
			E.RFC EmpresaRFC,
			E.Direccion EmpresaDir,
			E.DireccionNumero EmpresaDirNum,
			E.DireccionNumeroInt EmpresaDirNumInt,
			E.Colonia EmpresaColonia,
			E.CodigoPostal EmpresaCP,
			E.Poblacion EmpresaPoblacion,
			E.Delegacion EmpresaDelegacion,
			E.Estado EmpresaEDO,
			E.Pais EmpresaPais,
			E.Telefonos EmpresaTel,
			E.Fax EmpresaFax,
			V.Sucursal VentaSucursal,
			S.Nombre SucursalNombre,
			S.Direccion SucursalDir,
			S.DireccionNumero SucursalDirNum,
			S.DireccionNumeroInt SucursalDirNumInt,
			S.Colonia SucursalColonia,
			S.CodigoPostal SucursalCP,
			S.Delegacion SucursalDelegacion,
			S.Estado SucursalEDO,
			S.Poblacion SucursalPoblacion,
			S.Pais SucursalPais,
			S.Telefonos SucursalTel,
			S.Fax SucursalFax,
			i.Fecha FechaCFD,
			i.FechaTimbrado,
			i.noCertificado,
			i.noCertificadoSAT,
			CONVERT(VARCHAR(100), i.UUID) UUID,
			i.Sello,
			i.SelloSAT,
			i.TFDCadenaOriginal,
			CONVERT(VARCHAR(50), NULL) AS SERIELOTE,
			CONVERT(VARCHAR(100), NULL) AS ADUANA,
			CONVERT(DATE, NULL) AS FECHAADUANA,
			CONVERT(VARCHAR(50), NULL) AS PEDIMENTO,
			(SELECT Direccion FROM AnexoCta WHERE RAMA = 'EMP' AND CUENTA = V.Empresa AND TIPO = 'Imagen' AND Nombre = 'LOGO') AS CODIGO,
			(SELECT NOMBRE FROM FISCALREGIMEN WHERE FiscalRegimen = E.FiscalRegimen) AS REGIMENFISCAL,
			ISNULL(VC.FormaCobro1, (SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)) AS FormaCobro1,
			VC.FormaCobro2,
			VC.FormaCobro3,
			VC.FormaCobro4,
			VC.FormaCobro5,
			ISNULL(VC.Referencia1, (SELECT CuentaPago FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)) AS Referencia1,
			VC.Referencia2,
			VC.Referencia3,
			VC.Referencia4,
			VC.Referencia5,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.Referencia1, ''), (SELECT CUENTAPAGO FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)), '')
				IS NOT NULL OR NULLIF(VC.Referencia2, '') IS NOT NULL OR NULLIF(VC.Referencia3, '') IS NOT NULL OR NULLIF(VC.Referencia4, '') IS NOT NULL OR NULLIF(VC.Referencia5, '') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSREFCOBRO,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.FormaCobro1, ''), (SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)), '') 
				IS NOT NULL OR NULLIF(VC.FormaCobro2, '') IS NOT NULL OR NULLIF(VC.FormaCobro3, '') IS NOT NULL OR NULLIF(VC.FormaCobro4, '') IS NOT NULL OR NULLIF(VC.FormaCobro5, '') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSFORMAPAGO,
			V.Unidad UNIDADVTA,
			CAD.Nombre AS CteEnviarNombre,
			CAD.Direccion AS CteEnviarDireccion,
			CAD.DireccionNumero AS CteEnviarDireccionNum,
			CAD.DireccionNumeroInt AS CteEnviarDirNumInt,
			CAD.EntreCalles AS CteEnviarEntreCalles,
			CAD.Observaciones AS CteEnviarObservaciones,
			CAD.Delegacion AS CteEnviarDelegacion,
			CAD.Colonia AS CteEnviarColonia,
			CAD.CodigoPostal AS CteEnviarCodigoPostal,
			CAD.Estado AS CteEnviarEstado,
			CAD.Pais AS CteEnviarPais,
			CAD.Telefonos As CteEnviarTelefonos,
			CAD.Fax AS CteEnviarFax,
			CAD.eMail1 AS CteEnviareMail1,
			NULLIF(VE.EnviarA, '') CteEnviarA
	INTO #REPPRESUPUESTO
	FROM VENTATCALC V
		JOIN VENTA VE ON V.ID = VE.ID
		JOIN Cte C ON V.CLIENTE = C.Cliente
		LEFT OUTER JOIN CteEnviarA CA ON V.Cliente = CA.Cliente AND VE.EnviarA = CA.ID
		JOIN ART A ON V.ARTICULO = A.ARTICULO
		JOIN VENTAD VD ON V.ID = VD.ID AND V.Renglon = VD.Renglon AND V.RenglonID = VD.RenglonID 
		JOIN EMPRESA E ON V.Empresa = E.Empresa
		LEFT OUTER JOIN AnexoCta AC ON V.Empresa = AC.Cuenta AND CONVERT(VARCHAR(10), V.ContUso) + 'F' = AC.Nombre AND AC.Rama = 'EMP' AND AC.Tipo = 'Imagen'
		LEFT OUTER JOIN Agente AG ON V.Agente = AG.Agente
		JOIN Sucursal S ON V.Sucursal = S.Sucursal
		LEFT OUTER JOIN CFD i ON V.ID = i.ModuloID AND i.Modulo = 'VTAS' 
		LEFT OUTER JOIN VentaCobro VC ON V.ID = VC.ID
		LEFT OUTER JOIN CteEnviarA CAD ON CAD.Cliente = V.Cliente AND VD.EnviarA = CAD.ID
	WHERE V.ID = @ID AND VD.RENGLONTIPO IN ('N','J','L','S')

	--SERIESLOTES

	INSERT INTO #REPPRESUPUESTO
	SELECT	V.ID,
			V.Mov,
			V.MovID,
			V.FechaEmision,
			V.UEN,
			V.Moneda,
			V.TipoCambio,
			V.Cliente,
			C.Nombre,
			C.RFC,
			C.Direccion,
			C.DireccionNumero,
			C.DireccionNumeroInt,
			C.EntreCalles,
			C.Observaciones,
			C.Delegacion,
			C.Colonia,
			C.CodigoPostal,
			C.Estado,
			C.Pais,
			C.Telefonos,
			C.TelefonosLada,
			C.Fax,
			C.eMail1,
			CA.Nombre AS CteSucNombre,
			CA.Direccion AS CteSucDireccion,
			CA.DireccionNumero AS CteSucDireccionNum,
			CA.DireccionNumeroInt AS CteSucDirNumInt,
			CA.EntreCalles AS CteSucEntreCalles,
			CA.Observaciones AS CteSucObservaciones,
			CA.Delegacion AS CteSucDelegacion,
			CA.Colonia AS CteSucColonia,
			CA.CodigoPostal AS CteSucCodigoPostal,
			CA.Estado AS CteSucEstado,
			CA.Pais AS CteSucPais,
			CA.Telefonos As CteSucTelefonos,
			CA.Fax AS CteSucFax,
			CA.eMail1 AS CteSuceMail1,
			V.Renglon,
			V.RenglonID,
			V.Articulo,
			0 AS Cantidad,
			A.Descripcion1 + ' ' + ISNULL(NULLIF(V.DescripcionExtra, ''), '') AS DESCRIPCIONART,
			DATALENGTH(A.Descripcion1 + ' ' + ISNULL(NULLIF(V.DescripcionExtra, ''), '')) AS LARGODESCART,
			0 AS PrecioME,
			0 AS PrecioTipoCambio,
			0 AS PrecioMN,
			0 AS IMPORTETOTALME,
			0 AS ImporteTotalMN,
			0 AS DescuentoLinea,
			VD.PrecioMoneda,
			0 AS SubTotalMov,
			0 AS ImpuestosMov,
			0 AS DescTotalesMov,
			0 AS TotalNetoMov,
			'SERIELOTE' AS RENGLONREPTIPO,
			2.0 AS ORDENREP,
			V.Empresa,
			E.Nombre AS EmpresaNombre,
			AC.Direccion AS LOGORUTA,
			V.Agente,
			AG.Nombre AS AGENTENOMBRE,
			VE.EnviarA,
			E.RFC EmpresaRFC,
			E.Direccion EmpresaDir,
			E.DireccionNumero EmpresaDirNum,
			E.DireccionNumeroInt EmpresaDirNumInt,
			E.Colonia EmpresaColonia,
			E.CodigoPostal EmpresaCP,
			E.Poblacion EmpresaPoblacion,
			E.Delegacion EmpresaDelegacion,
			E.Estado EmpresaEDO,
			E.Pais EmpresaPais,
			E.Telefonos EmpresaTel,
			E.Fax EmpresaFax,
			V.Sucursal VentaSucursal,
			S.Nombre SucursalNombre,
			S.Direccion SucursalDir,
			S.DireccionNumero SucursalDirNum,
			S.DireccionNumeroInt SucursalDirNumInt,
			S.Colonia SucursalColonia,
			S.CodigoPostal SucursalCP,
			S.Delegacion SucursalDelegacion,
			S.Estado SucursalEDO,
			S.Poblacion SucursalPoblacion,
			S.Pais SucursalPais,
			S.Telefonos SucursalTel,
			S.Fax SucursalFax,
			i.Fecha FechaCFD,
			i.FechaTimbrado,
			i.noCertificado,
			i.noCertificadoSAT,
			i.UUID,
			i.Sello,
			i.SelloSAT,
			i.TFDCadenaOriginal,
			SLM.SerieLote AS SERIELOTE,
			SLP.Aduana AS ADUANA,
			SLP.Fecha1 AS FECHAADUANA,
			SLM.Propiedades AS PEDIMENTO,
			(SELECT Direccion FROM AnexoCta WHERE RAMA = 'EMP' AND CUENTA = V.Empresa AND TIPO = 'Imagen' AND Nombre = 'LOGO') AS CODIGO,
			(SELECT NOMBRE FROM FISCALREGIMEN WHERE FiscalRegimen = E.FiscalRegimen) AS REGIMENFISCAL,
			ISNULL(VC.FormaCobro1, (SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)) AS FormaCobro1,
			VC.FormaCobro2,
			VC.FormaCobro3,
			VC.FormaCobro4,
			VC.FormaCobro5,
			ISNULL(VC.Referencia1, (SELECT CuentaPago FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)) AS Referencia1,
			VC.Referencia2,
			VC.Referencia3,
			VC.Referencia4,
			VC.Referencia5,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.Referencia1, ''),(SELECT CUENTAPAGO FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)), '')
				IS NOT NULL OR NULLIF(VC.Referencia2, '') IS NOT NULL OR NULLIF(VC.Referencia3, '') IS NOT NULL OR NULLIF(VC.Referencia4, '') IS NOT NULL OR NULLIF(VC.Referencia5, '') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSREFCOBRO,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.FormaCobro1, ''),(SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)), '') 
				IS NOT NULL OR NULLIF(VC.FormaCobro2, '') IS NOT NULL OR NULLIF(VC.FormaCobro3, '') IS NOT NULL OR NULLIF(VC.FormaCobro4, '') IS NOT NULL OR NULLIF(VC.FormaCobro5, '') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSFORMAPAGO,
			V.Unidad UNIDADVTA,
			CAD.Nombre AS CteEnviarNombre,
			CAD.Direccion AS CteEnviarDireccion,
			CAD.DireccionNumero AS CteEnviarDireccionNum,
			CAD.DireccionNumeroInt AS CteEnviarDirNumInt,
			CAD.EntreCalles AS CteEnviarEntreCalles,
			CAD.Observaciones AS CteEnviarObservaciones,
			CAD.Delegacion AS CteEnviarDelegacion,
			CAD.Colonia AS CteEnviarColonia,
			CAD.CodigoPostal AS CteEnviarCodigoPostal,
			CAD.Estado AS CteEnviarEstado,
			CAD.Pais AS CteEnviarPais,
			CAD.Telefonos As CteEnviarTelefonos,
			CAD.Fax AS CteEnviarFax,
			CAD.eMail1 AS CteEnviareMail1,
			NULLIF(VE.EnviarA, '') CteEnviarA
	FROM VENTATCALC V
		JOIN VENTA VE ON V.ID = VE.ID
		JOIN Cte C ON V.CLIENTE = C.Cliente
		LEFT OUTER JOIN CteEnviarA CA ON V.Cliente = CA.Cliente AND VE.EnviarA = CA.ID
		JOIN ART A ON V.ARTICULO = A.ARTICULO
		JOIN VENTAD VD ON V.ID = VD.ID AND V.Renglon = VD.Renglon AND V.RenglonID = VD.RenglonID
		JOIN EMPRESA E ON V.Empresa = E.Empresa
		LEFT OUTER JOIN AnexoCta AC ON V.Empresa = AC.Cuenta AND CONVERT(VARCHAR(10), V.ContUso) + 'F' = AC.Nombre AND AC.Rama = 'EMP' AND AC.Tipo = 'Imagen'
		LEFT OUTER JOIN Agente AG ON V.Agente = AG.Agente
		JOIN Sucursal S ON V.Sucursal = S.Sucursal
		LEFT OUTER JOIN CFD i ON V.ID = i.ModuloID AND i.Modulo = 'VTAS' 
		JOIN SerieLoteMov SLM ON V.ID = SLM.ID AND SLM.Modulo = 'VTAS' AND V.Articulo = SLM.Articulo AND V.RenglonID = SLM.RenglonID
		LEFT OUTER JOIN SerieLoteProp SLP ON SLM.Propiedades = SLP.Propiedades
		LEFT OUTER JOIN VentaCobro VC ON V.ID = VC.ID
		LEFT OUTER JOIN CteEnviarA CAD ON CAD.Cliente = V.Cliente AND VD.EnviarA = CAD.ID
	WHERE V.ID=@ID 

	--ANTICIPOSAPLICADOS

	INSERT INTO #REPPRESUPUESTO
	SELECT	V.ID,
			V.Mov,
			V.MovID,
			V.FechaEmision,
			V.UEN,
			V.Moneda,
			V.TipoCambio,
			V.Cliente,
			C.Nombre,
			C.RFC,
			C.Direccion,
			C.DireccionNumero,
			C.DireccionNumeroInt,
			C.EntreCalles,
			C.Observaciones,
			C.Delegacion,
			C.Colonia,
			C.CodigoPostal,
			C.Estado,
			C.Pais,
			C.Telefonos,
			C.TelefonosLada,
			C.Fax,
			C.eMail1,
			CA.Nombre AS CteSucNombre,
			CA.Direccion AS CteSucDireccion,
			CA.DireccionNumero AS CteSucDireccionNum,
			CA.DireccionNumeroInt AS CteSucDirNumInt,
			CA.EntreCalles AS CteSucEntreCalles,
			CA.Observaciones AS CteSucObservaciones,
			CA.Delegacion AS CteSucDelegacion,
			CA.Colonia AS CteSucColonia,
			CA.CodigoPostal AS CteSucCodigoPostal,
			CA.Estado AS CteSucEstado,
			CA.Pais AS CteSucPais,
			CA.Telefonos As CteSucTelefonos,
			CA.Fax AS CteSucFax,
			CA.eMail1 AS CteSuceMail1,
			(SELECT MAX(Renglon) + 1 FROM VENTAD WHERE ID = V.ID) AS Renglon,
			(SELECT MAX(RenglonID) + 1 FROM VENTAD WHERE ID = V.ID) AS RenglonID,
			'ANTICIPO' AS Articulo,
			1 AS Cantidad,
			'ANTICIPO FACTURADO' AS DESCRIPCIONART,
			DATALENGTH('ANTICIPO FACTURADO') AS LARGODESCART,
			0 AS PrecioME,
			0 AS PrecioTipoCambio,
			(V.ANTICIPOSFACTURADOS - V.ANTICIPOSIMPUESTOS) * -1 AS PrecioMN,
			0 AS IMPORTETOTALME,
			(V.ANTICIPOSFACTURADOS - V.ANTICIPOSIMPUESTOS) * -1 AS ImporteTotalMN,
			NULL AS DescuentoLinea,
			'' AS PRECIOMONEDA,
			(V.ANTICIPOSFACTURADOS - V.ANTICIPOSIMPUESTOS) * -1 AS SubTotalMov,
			V.ANTICIPOSIMPUESTOS * -1 AS ImpuestosMov,
			0 AS DescTotalesMov,
			V.ANTICIPOSFACTURADOS * -1 AS TotalNetoMov,
			'ANTICIPOS' AS RENGLONREPTIPO,
			1.0 AS ORDENREP,
			V.Empresa,
			E.Nombre AS EmpresaNombre,
			AC.Direccion AS LOGORUTA,
			V.Agente,
			AG.Nombre AS AGENTENOMBRE,
			V.EnviarA,
			E.RFC EmpresaRFC,
			E.Direccion EmpresaDir,
			E.DireccionNumero EmpresaDirNum,
			E.DireccionNumeroInt EmpresaDirNumInt,
			E.Colonia EmpresaColonia,
			E.CodigoPostal EmpresaCP,
			E.Poblacion EmpresaPoblacion,
			E.Delegacion EmpresaDelegacion,
			E.Estado EmpresaEDO,
			E.Pais EmpresaPais,
			E.Telefonos EmpresaTel,
			E.Fax EmpresaFax,
			V.Sucursal VentaSucursal,
			S.Nombre SucursalNombre,
			S.Direccion SucursalDir,
			S.DireccionNumero SucursalDirNum,
			S.DireccionNumeroInt SucursalDirNumInt,
			S.Colonia SucursalColonia,
			S.CodigoPostal SucursalCP,
			S.Delegacion SucursalDelegacion,
			S.Estado SucursalEDO,
			S.Poblacion SucursalPoblacion,
			S.Pais SucursalPais,
			S.Telefonos SucursalTel,
			S.Fax SucursalFax,
			i.Fecha FechaCFD,
			i.FechaTimbrado,
			i.noCertificado,
			i.noCertificadoSAT,
			i.UUID,
			i.Sello,
			i.SelloSAT,
			i.TFDCadenaOriginal,
			NULL AS SERIELOTE,
			NULL AS ADUANA,
			NULL AS FECHAADUANA,
			NULL AS PEDIMENTO,
			(SELECT Direccion FROM AnexoCta WHERE RAMA = 'EMP' AND CUENTA = V.Empresa AND TIPO = 'Imagen' AND Nombre = 'LOGO') AS CODIGO,
			(SELECT NOMBRE FROM FISCALREGIMEN WHERE FiscalRegimen = E.FiscalRegimen) AS REGIMENFISCAL,
			ISNULL(VC.FormaCobro1, (SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)) AS FormaCobro1,
			VC.FormaCobro2,
			VC.FormaCobro3,
			VC.FormaCobro4,
			VC.FormaCobro5,
			ISNULL(VC.Referencia1, (SELECT CuentaPago FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)) AS Referencia1,
			VC.Referencia2,
			VC.Referencia3,
			VC.Referencia4,
			VC.Referencia5,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.Referencia1, ''),(SELECT CUENTAPAGO FROM CteCFDInfoPagoD P JOIN CteCFD CC ON P.Cliente = CC.Cliente AND CC.InfoPago = P.InfoPago AND P.FormaPago = CC.InfoFormaPago WHERE P.Cliente = V.Cliente)), '')
				IS NOT NULL OR NULLIF(VC.Referencia2, '') IS NOT NULL OR NULLIF(VC.Referencia3, '') IS NOT NULL OR NULLIF(VC.Referencia4, '') IS NOT NULL OR NULLIF(VC.Referencia5, '') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSREFCOBRO,
			(CASE WHEN NULLIF(ISNULL(NULLIF(VC.FormaCobro1, ''),(SELECT InfoFormaPago FROM CteCFD WHERE Cliente = V.Cliente)), '') 
				IS NOT NULL OR NULLIF(VC.FormaCobro2, '') IS NOT NULL OR NULLIF(VC.FormaCobro3, '') IS NOT NULL OR NULLIF(VC.FormaCobro4, '') IS NOT NULL OR NULLIF(VC.FormaCobro5, '') IS NOT NULL
				THEN 'SI' ELSE NULL END) AS CONDATOSFORMAPAGO,
			'NO APLICA' UNIDADVTA,
			'' AS CteEnviarNombre,
			'' AS CteEnviarDireccion,
			'' AS CteEnviarDireccionNum,
			'' AS CteEnviarDirNumInt,
			'' AS CteEnviarEntreCalles,
			'' AS CteEnviarObservaciones,
			'' AS CteEnviarDelegacion,
			'' AS CteEnviarColonia,
			'' AS CteEnviarCodigoPostal,
			'' AS CteEnviarEstado,
			'' AS CteEnviarPais,
			'' As CteEnviarTelefonos,
			'' AS CteEnviarFax,
			'' AS CteEnviareMail1,
			NULLIF(V.EnviarA, '') CteEnviarA
	FROM Venta V
		JOIN Cte C ON V.CLIENTE = C.Cliente
		LEFT OUTER JOIN CteEnviarA CA ON V.Cliente = CA.Cliente AND V.EnviarA = CA.ID
		JOIN EMPRESA E ON V.Empresa = E.Empresa
		LEFT OUTER JOIN AnexoCta AC ON V.Empresa = AC.Cuenta AND CONVERT(VARCHAR(10), V.ContUso) + 'F' = AC.Nombre AND AC.Rama = 'EMP' AND AC.Tipo = 'Imagen'
		LEFT OUTER JOIN Agente AG ON V.Agente = AG.Agente
		JOIN Sucursal S ON V.Sucursal = S.Sucursal
		LEFT OUTER JOIN CFD i ON V.ID = i.ModuloID AND i.Modulo = 'VTAS' 
		LEFT OUTER JOIN VentaCobro VC ON V.ID = VC.ID
	WHERE V.ID = @ID AND NULLIF(V.AnticiposFacturados, '') IS NOT NULL
	
	SELECT * FROM #REPPRESUPUESTO 
	ORDER BY ID, Renglon, RenglonID, ORDENREP
END
GO

/********************* Reporte NotaCreditoVta **************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.spFacturaAnticipoCXC') AND TYPE = 'P' ) DROP PROC spFacturaAnticipoCXC
GO
CREATE PROCEDURE dbo.spFacturaAnticipoCXC
	@ID INT
--//WITH ENCRYPTION
AS BEGIN
	SELECT	CX.ID,
			CX.Mov,
			CX.MovID,
			CX.FechaEmision,
			CX.UEN,
			CX.Moneda,
			CONVERT(FLOAT, CX.TipoCambio) AS TipoCambioMov,
			CX.Cliente,
			C.Nombre,
			C.RFC,
			C.Direccion,
			C.DireccionNumero,
			C.DireccionNumeroInt,
			C.EntreCalles,
			C.Observaciones,
			C.Delegacion,
			C.Colonia,
			C.CodigoPostal,
			C.Estado,
			C.Pais,
			C.Telefonos,
			C.TelefonosLada,
			C.Fax,
			C.eMail1,
			CA.Nombre AS CteSucNombre,
			CA.Direccion AS CteSucDireccion,
			CA.DireccionNumero AS CteSucDireccionNum,
			CA.DireccionNumeroInt AS CteSucDirNumInt,
			CA.EntreCalles AS CteSucEntreCalles,
			CA.Observaciones AS CteSucObservaciones,
			CA.Delegacion AS CteSucDelegacion,
			CA.Colonia AS CteSucColonia,
			CA.CodigoPostal AS CteSucCodigoPostal,
			CA.Estado AS CteSucEstado,
			CA.Pais AS CteSucPais,
			CA.Telefonos As CteSucTelefonos,
			CA.Fax AS CteSucFax,
			CA.eMail1 AS CteSuceMail1,
			CONVERT(INT, V.Renglon) AS RENGLON,
			CONVERT(INT, V.RenglonID) AS RENGLONID,
			ISNULL(NULLIF(V.Articulo, ''), CX.Concepto) AS ARTICULO,
			ISNULL(V.Cantidad, 1) AS CANTIDAD,
			ISNULL(NULLIF(CX.OBSERVACIONES, ''), A.Descripcion1) AS DESCRIPCIONART,
			DATALENGTH(ISNULL(NULLIF(CX.OBSERVACIONES, ''), A.Descripcion1)) AS LARGODESCART,
			VD.Precio PrecioME,
			VD.PrecioTipoCambio,
			ISNULL(VD.Precio * VD.PrecioTipoCambio, CX.Importe) PrecioMN,
			(VD.Precio * VD.Cantidad) AS IMPORTETOTALME,
			ISNULL(VD.Precio * VD.Cantidad * VD.PrecioTipoCambio, CX.Importe) AS ImporteTotalMN,
			VD.DescuentoLinea,
			V.SubTotal * V.TipoCambio SubTotalMov,
			V.Impuestos * V.TipoCambio ImpuestosMov,
			V.DescuentosTotales * V.TipoCambio DescTotalesMov,
			V.TotalNeto * V.TipoCambio TotalNetoMov,
			'DESCRIPCION' AS RENGLONREPTIPO,
			1.0 AS ORDENREP,
			V.Empresa,
			E.Nombre AS EmpresaNombre,
			AC.Direccion AS LOGORUTA,
			V.Agente,
			AG.Nombre AS AGENTENOMBRE,
			VE.EnviarA,
			E.RFC EmpresaRFC,
			E.Direccion EmpresaDir,
			E.DireccionNumero EmpresaDirNum,
			E.DireccionNumeroInt EmpresaDirNumInt,
			E.Colonia EmpresaColonia,
			E.CodigoPostal EmpresaCP,
			E.Poblacion EmpresaPoblacion,
			E.Delegacion EmpresaDelegacion,
			E.Estado EmpresaEDO,
			E.Pais EmpresaPais,
			E.Telefonos EmpresaTel,
			E.Fax EmpresaFax,
			V.Sucursal VentaSucursal,
			S.Nombre SucursalNombre,
			S.Direccion SucursalDir,
			S.DireccionNumero SucursalDirNum,
			S.DireccionNumeroInt SucursalDirNumInt,
			S.Colonia SucursalColonia,
			S.CodigoPostal SucursalCP,
			S.Delegacion SucursalDelegacion,
			S.Estado SucursalEDO,
			S.Poblacion SucursalPoblacion,
			S.Pais SucursalPais,
			S.Telefonos SucursalTel,
			S.Fax SucursalFax,
			i.Fecha FechaCFD,
			i.FechaTimbrado,
			i.noCertificado,
			i.noCertificadoSAT,
			CONVERT(VARCHAR(100), i.UUID) UUID,
			i.Sello,
			i.SelloSAT,
			i.TFDCadenaOriginal,
			CONVERT(VARCHAR(50), NULL) AS SERIELOTE,
			CONVERT(VARCHAR(100), NULL) AS ADUANA,
			CONVERT(DATE, NULL) AS FECHAADUANA,
			CONVERT(VARCHAR(50), NULL) AS PEDIMENTO,
			(SELECT Direccion FROM AnexoCta WHERE RAMA = 'EMP' AND CUENTA = V.Empresa AND TIPO = 'Imagen' AND Nombre = CONVERT(VARCHAR(10), V.UEN) + 'F') AS CODIGO,
			(SELECT NOMBRE FROM FISCALREGIMEN WHERE FiscalRegimen = E.FiscalRegimen) AS REGIMENFISCAL,
			CX.FormaCobro1,
			CX.FormaCobro2,
			CX.FormaCobro3,
			CX.FormaCobro4,
			CX.FormaCobro5,
			CX.Referencia1,
			CX.Referencia2,
			CX.Referencia3,
			CX.Referencia4,
			CX.Referencia5,
			(CASE WHEN NULLIF(CX.Referencia1, '') IS NOT NULL OR NULLIF(CX.Referencia2, '') IS NOT NULL OR NULLIF(CX.Referencia3, '') IS NOT NULL OR NULLIF(CX.Referencia4, '') IS NOT NULL OR NULLIF(CX.Referencia5, '') IS NOT NULL
			 THEN 'SI' ELSE NULL END) AS CONDATOSREFCOBRO,
			(CASE WHEN NULLIF(CX.FormaCobro1, '') IS NOT NULL OR NULLIF(CX.FormaCobro2, '') IS NOT NULL OR NULLIF(CX.FormaCobro3, '') IS NOT NULL OR NULLIF(CX.FormaCobro4, '') IS NOT NULL OR NULLIF(CX.FormaCobro5, '') IS NOT NULL
			 THEN 'SI' ELSE NULL END) AS CONDATOSFORMAPAGO,
			 ISNULL(V.Unidad, 'NO APLICA') UNIDADVTA,
			 V.ID AS IDVTA,
			 CX.Importe AS IMPORTECXC,
			 CX.Impuestos AS IMPUESTOSCXC,
			 CX.Importe + CX.Impuestos AS TOTALCXC,
			 CONVERT(FLOAT, CONVERT(FLOAT, CX.Importe) / CONVERT(FLOAT, VE.Importe * VE.TIPOCAMBIO)) AS FACTORIMPORTE
	INTO #REPPRESUPUESTO
	FROM CXC CX
		LEFT OUTER JOIN VENTATCALC V ON CX.Referencia = V.Mov + ' ' + V.MovID
		LEFT OUTER JOIN VENTA VE ON V.ID = VE.ID
		JOIN Cte C ON CX.CLIENTE = C.Cliente
		LEFT OUTER JOIN CteEnviarA CA ON CX.Cliente = CA.Cliente AND CX.ClienteEnviarA = CA.ID
		LEFT OUTER JOIN ART A ON V.ARTICULO = A.ARTICULO
		LEFT OUTER JOIN VENTAD VD ON V.ID = VD.ID AND V.Renglon = VD.Renglon AND V.RenglonID = VD.RenglonID
		JOIN EMPRESA E ON CX.Empresa = E.Empresa
		LEFT OUTER JOIN AnexoCta AC ON CX.Empresa = AC.Cuenta AND CONVERT(VARCHAR(10), CX.ContUso) + 'F' = AC.Nombre AND AC.Rama = 'EMP' AND AC.Tipo = 'Imagen'
		LEFT OUTER JOIN Agente AG ON CX.Agente = AG.Agente
		JOIN Sucursal S ON CX.Sucursal = S.Sucursal
		LEFT OUTER JOIN CFD i ON CX.ID = i.ModuloID AND i.Modulo = 'CXC' 
		LEFT OUTER JOIN VentaCobro VC ON V.ID = VC.ID
	WHERE CX.ID = @ID	

	SELECT * FROM #REPPRESUPUESTO 
	ORDER BY ID, Renglon, RenglonID, ORDENREP
END
GO


