/* VISTAS LOCALES  */

/*** AlmVenta ***/
if exists (select * from sysobjects where id = object_id('dbo.AlmVenta') and type = 'V') drop view dbo.AlmVenta
GO
CREATE VIEW AlmVenta
--//WITH ENCRYPTION
AS 
SELECT Almacen, Orden
  FROM Alm
 WHERE NULLIF(UPPER(RTRIM(Exclusivo)), '') IN (NULL, 'VENTA', 'COMPRA/VENTA')
GO

/*** AlmCompra ***/
if exists (select * from sysobjects where id = object_id('dbo.AlmCompra') and type = 'V') drop view dbo.AlmCompra
GO
CREATE VIEW AlmCompra
--//WITH ENCRYPTION
AS 
SELECT Almacen, Orden
  FROM Alm
 WHERE NULLIF(UPPER(RTRIM(Exclusivo)),'') IN (NULL, 'COMPRA', 'COMPRA/VENTA')
GO

/*** AlmProceso ***/
if exists (select * from sysobjects where id = object_id('dbo.AlmProceso') and type = 'V') drop view dbo.AlmProceso
GO
CREATE VIEW AlmProceso
--//WITH ENCRYPTION
AS 
SELECT Almacen, Orden
  FROM Alm
 WHERE UPPER(Tipo) = 'PROCESO'
GO


/*** AlmROP ***/
if exists (select * from sysobjects where id = object_id('dbo.AlmROP') and type = 'V') drop view dbo.AlmROP
GO
CREATE VIEW AlmROP
--//WITH ENCRYPTION
AS 
SELECT Almacen
  FROM Alm
UNION 
  SELECT Almacen = '(Demanda)'
GO

/*** InstruccionCompra ***/
if exists (select * from sysobjects where id = object_id('dbo.InstruccionCompra') and type = 'V') drop view dbo.InstruccionCompra
GO
CREATE VIEW InstruccionCompra
--//WITH ENCRYPTION
AS 
SELECT Instruccion
  FROM Instruccion
 WHERE Modulo ='COMS'
GO

/*** InstruccionVenta ***/
if exists (select * from sysobjects where id = object_id('dbo.InstruccionVenta') and type = 'V') drop view dbo.InstruccionVenta
GO
CREATE VIEW InstruccionVenta
--//WITH ENCRYPTION
AS 
SELECT Instruccion
  FROM Instruccion
 WHERE Modulo ='VTAS'
GO

/*** ConceptoCompraGastoDiverso ***/
if exists (select * from sysobjects where id = object_id('dbo.ConceptoCompraGastoDiverso') and type = 'V') drop view dbo.ConceptoCompraGastoDiverso
GO
CREATE VIEW ConceptoCompraGastoDiverso
--//WITH ENCRYPTION
AS 
SELECT Concepto, Orden, Impuestos, Retencion, Retencion2, Retencion3
  FROM Concepto
 WHERE Modulo = 'COMSG'
GO

/*** PoliticaPrecios ***/
if exists (select * from sysobjects where id = object_id('dbo.PoliticaPrecios') and type = 'V') drop view dbo.PoliticaPrecios
GO
CREATE VIEW PoliticaPrecios
--//WITH ENCRYPTION
AS 
SELECT
  "Articulo"     = CASE WHEN NivelArticulo     = 1 THEN RTRIM(Articulo)     END,
  "SubCuenta"    = CASE WHEN NivelSubCuenta    = 1 THEN RTRIM(SubCuenta)    END,
  "ArtGrupo"     = CASE WHEN NivelArtGrupo     = 1 THEN RTRIM(ArtGrupo)     END,
  "ArtCat"       = CASE WHEN NivelArtCat       = 1 THEN RTRIM(ArtCat)       END,
  "ArtFam"       = CASE WHEN NivelArtFam       = 1 THEN RTRIM(ArtFam)       END,
  "ArtABC"       = CASE WHEN NivelArtABC       = 1 THEN RTRIM(ArtABC)       END,
  "Fabricante"   = CASE WHEN NivelFabricante   = 1 THEN RTRIM(Fabricante)   END,
  "ArtLinea"     = CASE WHEN NivelArtLinea     = 1 THEN RTRIM(ArtLinea)     END,
  "ArtRama"      = CASE WHEN NivelArtRama      = 1 THEN RTRIM(ArtRama)      END,
  "Cliente"      = CASE WHEN NivelCliente      = 1 THEN RTRIM(Cliente)      END,
  "CteGrupo"     = CASE WHEN NivelCteGrupo     = 1 THEN RTRIM(CteGrupo)     END,
  "CteCat"       = CASE WHEN NivelCteCat       = 1 THEN RTRIM(CteCat)       END,
  "CteFam"       = CASE WHEN NivelCteFam       = 1 THEN RTRIM(CteFam)       END,
  "CteZona"      = CASE WHEN NivelCteZona      = 1 THEN RTRIM(CteZona)      END,
  "Moneda"       = CASE WHEN NivelMoneda       = 1 THEN RTRIM(Moneda)       END,
  "Condicion"    = CASE WHEN NivelCondicion    = 1 THEN RTRIM(Condicion)    END,
  "Almacen"      = CASE WHEN NivelAlmacen      = 1 THEN RTRIM(Almacen)      END,
  "Proyecto"     = CASE WHEN NivelProyecto     = 1 THEN RTRIM(Proyecto)     END,
  "Agente"       = CASE WHEN NivelAgente       = 1 THEN RTRIM(Agente)       END,
  "FormaEnvio"   = CASE WHEN NivelFormaEnvio   = 1 THEN RTRIM(FormaEnvio)   END,
  "Mov"          = CASE WHEN NivelMov          = 1 THEN RTRIM(Mov)          END,
  "ServicioTipo" = CASE WHEN NivelServicioTipo = 1 THEN RTRIM(ServicioTipo) END,
  "ContratoTipo" = CASE WHEN NivelContratoTipo = 1 THEN RTRIM(ContratoTipo) END,
  "UnidadVenta"  = CASE WHEN NivelUnidadVenta  = 1 THEN RTRIM(UnidadVenta)  END,
  "Sucursal"     = CASE WHEN NivelSucursal     = 1 THEN Sucursal            END,
  "Region"       = CASE WHEN NivelRegion       = 1 THEN RTRIM(Region)       END,
  "Empresa"      = CASE WHEN NivelEmpresa      = 1 THEN RTRIM(Empresa)      END,
  ID, Tipo, Nivel, Descripcion, ArticuloObsequio, CantidadObsequio, ListaPrecios

FROM 
  Precio

WHERE 
  Estatus = 'ACTIVA' AND (ConVigencia = 0 OR (GETDATE() BETWEEN FechaD AND FechaA))
GO

/*** PoliticaPreciosD ***/
if exists (select * from sysobjects where id = object_id('dbo.PoliticaPreciosD') and type = 'V') drop view dbo.PoliticaPreciosD
GO
CREATE VIEW PoliticaPreciosD
--//WITH ENCRYPTION
AS 
SELECT
  PrecioD.ID, PrecioD.Cantidad, PrecioD.Monto

FROM 
  Precio, PrecioD

WHERE 
  PrecioD.ID = Precio.ID AND
  Precio.Estatus = 'ACTIVA' AND (Precio.ConVigencia = 0 OR (GETDATE() BETWEEN Precio.FechaD AND Precio.FechaA))

GROUP BY
  PrecioD.ID, PrecioD.Cantidad, PrecioD.Monto
GO


/*** CtaEstructura ***/
if exists (select * from sysobjects where id = object_id('dbo.CtaEstructura') and type = 'V') drop view dbo.CtaEstructura
GO
CREATE VIEW CtaEstructura
--//WITH ENCRYPTION
AS 
SELECT 
  Cuenta, Descripcion 
FROM 
  Cta
WHERE
  UPPER(Tipo) = 'Estructura'
GO

/*** ServicioContratoTipo ***/
if exists (select * from sysobjects where id = object_id('dbo.ServicioContratoTipo') and type = 'V') drop view dbo.ServicioContratoTipo
GO
CREATE VIEW ServicioContratoTipo
--//WITH ENCRYPTION
AS 
SELECT DISTINCT Tipo FROM ContratoTipo WHERE Modulo = 'SERV'
GO

/*** VentaContratoTipo ***/
if exists (select * from sysobjects where id = object_id('dbo.VentaContratoTipo') and type = 'V') drop view dbo.VentaContratoTipo
GO
CREATE VIEW VentaContratoTipo
--//WITH ENCRYPTION
AS 
SELECT DISTINCT Tipo FROM ContratoTipo WHERE Modulo = 'VTAS'
GO

/*** GastoContratoTipo ***/
if exists (select * from sysobjects where id = object_id('dbo.GastoContratoTipo') and type = 'V') drop view dbo.GastoContratoTipo
GO
CREATE VIEW GastoContratoTipo
--//WITH ENCRYPTION
AS 
SELECT DISTINCT Tipo FROM ContratoTipo WHERE Modulo = 'GAS'
GO


/****************************** NOMINA **********************************/

/*** VerJornadaTiempo ***/
if exists (select * from sysobjects where id = object_id('dbo.VerJornadaTiempo') and type = 'V') drop view dbo.VerJornadaTiempo
GO
CREATE VIEW VerJornadaTiempo
--//WITH ENCRYPTION
AS 
SELECT Jornada, Entrada, Salida, "Ano"= DATEPART(year, Entrada), "Mes" = DATEPART(month, Entrada), "Dia" = DATEPART(day, Entrada), "Semana" = DATEPART(week, Entrada)
  FROM JornadaTiempo
GO

/*** PersonalNombre ***/
if exists (select * from sysobjects where id = object_id('dbo.PersonalNombre') and type = 'V') drop view dbo.PersonalNombre
GO
CREATE VIEW PersonalNombre
--//WITH ENCRYPTION
AS 
SELECT Personal, "NombreCompleto" = Convert(char(100), RTRIM(Personal)+' - '+RTRIM(ApellidoPaterno)+' '+RTRIM(ApellidoMaterno)+' '+RTRIM(Nombre))
  FROM Personal
GO


/*** NominaContratoTipo ***/
if exists (select * from sysobjects where id = object_id('dbo.NominaContratoTipo') and type = 'V') drop view dbo.NominaContratoTipo
GO
CREATE VIEW NominaContratoTipo
--//WITH ENCRYPTION
AS 
SELECT DISTINCT Tipo FROM ContratoTipo WHERE Modulo = 'NOM'
GO

/*** SoporteDMov ***/
if exists (select * from sysobjects where id = object_id('dbo.SoporteDMov') and type = 'V') drop view dbo.SoporteDMov
GO
CREATE VIEW SoporteDMov
--//WITH ENCRYPTION
AS 
SELECT Mov 
  FROM MovTipo 
 WHERE Clave = 'ST.P'
GO


/*** CxcDMov ***/
if exists (select * from sysobjects where id = object_id('dbo.CxcDMov') and type = 'V') drop view dbo.CxcDMov
GO
CREATE VIEW CxcDMov
--//WITH ENCRYPTION
AS 
SELECT Mov 
  FROM MovTipo 
 WHERE Clave IN ('CXC.F', 'CXC.FA', 'CXC.FAC', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP', 'CXC.VV', 'CXC.CD', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.RM', 'CXC.IM', 'CXC.A', 'CXC.AR')
GO

/*** CxpDMov ***/
if exists (select * from sysobjects where id = object_id('dbo.CxpDMov') and type = 'V') drop view dbo.CxpDMov
GO
CREATE VIEW CxpDMov
--//WITH ENCRYPTION
AS 
SELECT Mov 
  FROM MovTipo 
 WHERE Clave IN ('CXP.F', 'CXP.FAC', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF','CXP.NCP', 'CXP.CA', 'CXP.CAD', 'CXP.CAP', 'CXP.CD', 'CXP.D', 'CXP.DM', 'CXP.PAG', 'CXP.DA', 'CXP.DP', 'CXP.A')
GO


/*** ArtRama ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtRama') and type = 'V') drop view dbo.ArtRama
GO
CREATE VIEW ArtRama
--//WITH ENCRYPTION
AS
SELECT 
  "Cuenta" = Articulo, Rama, "Nombre" = Descripcion1
FROM
  Art
WHERE
  Tipo = 'Estructura'
GO

/*** CteRama ***/
if exists (select * from sysobjects where id = object_id('dbo.CteRama') and type = 'V') drop view dbo.CteRama
GO
CREATE VIEW CteRama
--//WITH ENCRYPTION
AS
SELECT 
  "Cuenta" = Cliente, Rama, Nombre
FROM
  Cte
WHERE
  Tipo = 'Estructura'
GO

/*** ProvRama ***/
if exists (select * from sysobjects where id = object_id('dbo.ProvRama') and type = 'V') drop view dbo.ProvRama
GO
CREATE VIEW ProvRama
--//WITH ENCRYPTION
AS
SELECT 
  "Cuenta" = Proveedor, Rama, Nombre
FROM
  Prov
WHERE
  Tipo = 'Estructura'
GO

/*** ProyRama ***/
if exists (select * from sysobjects where id = object_id('dbo.ProyRama') and type = 'V') drop view dbo.ProyRama
GO
CREATE VIEW ProyRama
--//WITH ENCRYPTION
AS
SELECT 
  "Cuenta" = Proyecto, Rama, "Nombre" = Proyecto
FROM
  Proy
WHERE
  Tipo = 'Estructura'
GO

/*** CtaDineroRama ***/
if exists (select * from sysobjects where id = object_id('dbo.CtaDineroRama') and type = 'V') drop view dbo.CtaDineroRama
GO
CREATE VIEW CtaDineroRama
--//WITH ENCRYPTION
AS
SELECT 
  "Cuenta" = CtaDinero, Rama, "Nombre" = Descripcion
FROM
  CtaDinero
WHERE
  Tipo = 'Estructura'
GO

-- select * from NivelAcceso order by orden
/*** NivelAcceso ***/
if exists (select * from sysobjects where id = object_id('dbo.NivelAcceso') and type = 'V') drop view dbo.NivelAcceso
GO
CREATE VIEW NivelAcceso
--//WITH ENCRYPTION
AS
SELECT "Nivel" = '(Todos)', "Orden" = 1
UNION
SELECT "Nivel" = '('+RTRIM(Empresa)+')', "Orden" = 2 FROM Empresa
UNION
SELECT "Nivel" = '('+RTRIM(GrupoTrabajo)+')', "Orden" = 3 FROM GrupoTrabajo
UNION
SELECT "Nivel" = Usuario, "Orden" = 3 FROM Usuario WHERE Estatus = 'ALTA'
GO

/*** NivelAccesoEsp ***/
if exists (select * from sysobjects where id = object_id('dbo.NivelAccesoEsp') and type = 'V') drop view dbo.NivelAccesoEsp
GO
CREATE VIEW NivelAccesoEsp
--//WITH ENCRYPTION
AS
SELECT Nivel, Orden FROM NivelAcceso
UNION
SELECT "Nivel" = '(Especifico)', "Orden" = 1
GO

/*** MovTipoPoliza ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipoPoliza') and type = 'V') drop view dbo.MovTipoPoliza
GO
CREATE VIEW MovTipoPoliza
--//WITH ENCRYPTION
AS 
SELECT "Mov" = 'No', "Orden" = 0
UNION
SELECT Mov, Orden
  FROM MovTipo 
 WHERE Clave = 'CONT.P'
GO

/*** MovTipoCxcCredito ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipoCxcCredito') and type = 'V') drop view dbo.MovTipoCxcCredito
GO
CREATE VIEW MovTipoCxcCredito
--//WITH ENCRYPTION
AS 
SELECT Mov FROM MovTipo WHERE Modulo = 'CXC' AND Clave IN ('CXC.A', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF')
GO

/*** MovTipoCxcNC ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipoCxcNC') and type = 'V') drop view dbo.MovTipoCxcNC
GO
CREATE VIEW MovTipoCxcNC
--//WITH ENCRYPTION
AS 
SELECT Mov FROM MovTipo WHERE Modulo = 'CXC' AND Clave = 'CXC.NC'
GO


/*** MovTipoCxpCargo ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipoCxpCargo') and type = 'V') drop view dbo.MovTipoCxpCargo
GO
CREATE VIEW MovTipoCxpCargo
--//WITH ENCRYPTION
AS 
SELECT Mov FROM MovTipo WHERE Modulo = 'CXP' AND Clave IN ('CXP.A', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF')
GO

/*** MovTipoCxpNC ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipoCxpNC') and type = 'V') drop view dbo.MovTipoCxpNC
GO
CREATE VIEW MovTipoCxpNC
--//WITH ENCRYPTION
AS 
SELECT Mov FROM MovTipo WHERE Modulo = 'CXP' AND Clave = 'CXP.NC'
GO




/*** VerAfectarBitacora ***/
if exists (select * from sysobjects where id = object_id('dbo.VerAfectarBitacora') and type = 'V') drop view dbo.VerAfectarBitacora
GO
CREATE VIEW VerAfectarBitacora
--//WITH ENCRYPTION
AS 
SELECT
  AfectarBitacora.ID,
  AfectarBitacora.Modulo,
  AfectarBitacora.ModuloID,
  AfectarBitacora.Accion,
  AfectarBitacora.Base,
  AfectarBitacora.GenerarMov,
  AfectarBitacora.Usuario,
  AfectarBitacora.FechaRegistro,
  AfectarBitacora.Ok,
  AfectarBitacora.OkRef,
  Mov.Empresa,
  Mov.Mov,
  Mov.MovID,
  MensajeLista.Descripcion,
  MensajeLista.Tipo,
  "Movimiento" = RTRIM(Mov.Mov)+ ' '+ RTRIM(Mov.MovID)

FROM AfectarBitacora
LEFT OUTER JOIN Mov ON AfectarBitacora.Modulo = Mov.Modulo AND AfectarBitacora.ModuloID = Mov.ID
LEFT OUTER JOIN MensajeLista ON AfectarBitacora.Ok = MensajeLista.Mensaje
GO

/*** ArtJuegoOmision ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtJuegoOmision') and type = 'V') drop view dbo.ArtJuegoOmision
GO
CREATE VIEW ArtJuegoOmision
--//WITH ENCRYPTION
AS 
SELECT j.Articulo, j.Cantidad, j.Juego, "PrecioIndependiente" = CONVERT(int, j.PrecioIndependiente), j.ListaPreciosEsp,
 "Opcion" = (SELECT Opcion FROM ArtJuegoD o WHERE o.Articulo = j.Articulo AND o.Juego = j.Juego AND o.Renglon = MIN(d.Renglon)),
  "SubCuenta" = (SELECT SubCuenta FROM ArtJuegoD o WHERE o.Articulo = j.Articulo AND o.Juego = j.Juego AND o.Renglon = MIN(d.Renglon))
  FROM ArtJuego j, ArtJuegoD d
 WHERE j.Articulo = d.Articulo AND j.Juego = d.Juego
 GROUP BY j.Articulo, j.Cantidad, j.Juego, CONVERT(int, j.PrecioIndependiente), j.ListaPreciosEsp
GO

/*** MovTipo_COMS_O ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipo_COMS_O') and type = 'V') drop view dbo.MovTipo_COMS_O
GO
CREATE VIEW MovTipo_COMS_O
--//WITH ENCRYPTION
AS 
SELECT Mov FROM MovTipo WHERE Modulo = 'COMS' AND Clave = 'COMS.O'
GO

/*** MovTipo_PROD_O ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipo_PROD_O') and type = 'V') drop view dbo.MovTipo_PROD_O
GO
CREATE VIEW MovTipo_PROD_O
--//WITH ENCRYPTION
AS 
SELECT Mov FROM MovTipo WHERE Modulo = 'PROD' AND Clave = 'PROD.O'
GO


/*** MovTipo_INV_OT ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipo_INV_OT') and type = 'V') drop view dbo.MovTipo_INV_OT
GO
CREATE VIEW MovTipo_INV_OT
--//WITH ENCRYPTION
AS 
SELECT Mov FROM MovTipo WHERE Modulo = 'INV' AND Clave = 'INV.OT'
GO

/*** MovTipo_INV_OI ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipo_INV_OI') and type = 'V') drop view dbo.MovTipo_INV_OI
GO
CREATE VIEW MovTipo_INV_OI
--//WITH ENCRYPTION
AS 
SELECT Mov FROM MovTipo WHERE Modulo = 'INV' AND Clave = 'INV.OI'
GO


/*** MovTipo_NOM_NNE ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipo_NOM_NNE') and type = 'V') drop view dbo.MovTipo_NOM_NNE
GO
CREATE VIEW MovTipo_NOM_NNE
--//WITH ENCRYPTION
AS 
SELECT Mov, 'Orden' = CASE WHEN Clave = 'NOM.N' THEN 1 ELSE 2 END
  FROM MovTipo WHERE Modulo = 'NOM' AND Clave IN ('NOM.N', 'NOM.NE')
GO


/*** Actividad_GAS ***/
if exists (select * from sysobjects where id = object_id('dbo.Actividad_GAS') and type = 'V') drop view dbo.Actividad_GAS
GO
CREATE VIEW Actividad_GAS
--//WITH ENCRYPTION
AS 
SELECT Orden, Actividad
  FROM Actividad WHERE ModuloEsp IN (NULL, '', 'GAS')
GO

/*** Actividad_VTAS ***/
if exists (select * from sysobjects where id = object_id('dbo.Actividad_VTAS') and type = 'V') drop view dbo.Actividad_VTAS
GO
CREATE VIEW Actividad_VTAS
--//WITH ENCRYPTION
AS 
SELECT Orden, Actividad
  FROM Actividad WHERE ModuloEsp IN (NULL, '', 'VTAS')
GO

/*** Actividad_ASIS ***/
if exists (select * from sysobjects where id = object_id('dbo.Actividad_ASIS') and type = 'V') drop view dbo.Actividad_ASIS
GO
CREATE VIEW Actividad_ASIS
--//WITH ENCRYPTION
AS 
SELECT Orden, Actividad
  FROM Actividad WHERE ModuloEsp IN (NULL, '', 'ASIS')
GO

/*** MovTipo_VTAS_P ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipo_VTAS_P') and type = 'V') drop view dbo.MovTipo_VTAS_P
GO
CREATE VIEW MovTipo_VTAS_P
--//WITH ENCRYPTION
AS 
SELECT Mov FROM MovTipo WHERE Modulo = 'VTAS' AND Clave = 'VTAS.P'
GO

/*** PaisEstadoMexico ***/
if exists (select * from sysobjects where id = object_id('dbo.PaisEstadoMexico') and type = 'V') drop view dbo.PaisEstadoMexico
GO
CREATE VIEW PaisEstadoMexico
--//WITH ENCRYPTION
AS 
SELECT Estado
  FROM PaisEstado
 WHERE Pais = 'Mexico'
GO

/*** FormaPagoImportacion ***/
if exists (select * from sysobjects where id = object_id('dbo.FormaPagoImportacion') and type = 'V') drop view dbo.FormaPagoImportacion
GO
CREATE VIEW FormaPagoImportacion
--//WITH ENCRYPTION
AS 
SELECT FormaPago
  FROM FormaPago
 WHERE Importacion = 1
GO

/*** MovTipo_ACT_Avance ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipo_ACT_Avance') and type = 'V') drop view dbo.MovTipo_ACT_Avance
GO
/*CREATE VIEW MovTipo_ACT_Avance
--//WITH ENCRYPTION
AS 
SELECT Mov FROM MovTipo WHERE Modulo = 'ACT' AND Clave IN ('ACT.AV', 'ACT.CON')*/
GO

/*** MovTipo_ACT_Atraso ***/
if exists (select * from sysobjects where id = object_id('dbo.MovTipo_ACT_Atraso') and type = 'V') drop view dbo.MovTipo_ACT_Atraso
GO
/*CREATE VIEW MovTipo_ACT_Atraso
--//WITH ENCRYPTION
AS 
SELECT Mov FROM MovTipo WHERE Modulo = 'ACT' AND Clave = 'ACT.DEM'*/
GO


/*** AgenteNombre ***/
if exists (select * from sysobjects where id = object_id('dbo.AgenteNombre') and type = 'V') drop view dbo.AgenteNombre
GO
CREATE VIEW AgenteNombre
--//WITH ENCRYPTION
AS 
SELECT Nombre
  FROM Agente
 WHERE Estatus = 'ALTA'
GO

/*** ContMoneda ***/
if exists (select * from sysobjects where id = object_id('dbo.ContMoneda') and type = 'V') drop view dbo.ContMoneda
GO
CREATE VIEW ContMoneda
--//WITH ENCRYPTION
AS 
SELECT 
  ec.Empresa,
  ec.ContMoneda,
  m.TipoCambio,
  m.TipoCambio TipoCambioInv
  FROM EmpresaCfg ec JOIN Mon m
    ON m.Moneda = ec.ContMoneda
GO
