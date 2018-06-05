
/* Configuracion MS SQL Server */

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF

GO
-- Vista para Copiar el Movimiento
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.cPrevencionLDD') and sysstat & 0xf = 2) 
  DROP VIEW dbo.cPrevencionLDD
GO
CREATE VIEW cPrevencionLDD
AS
SELECT        ID, Renglon, OrigenModulo, OrigenModuloID, Aplica, AplicaId, Importe, ActEconimica, SaldoActual, SaldoAnterior, Variacion, Contacto, ContactoTipo, Sucursal, 
                         SucursalOrigen, Referencia
FROM            PrevencionLDD

GO

-- Vista Para Crear el Movimiento
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.PrevencionLDT') and sysstat & 0xf = 2) 
  DROP VIEW dbo.PrevencionLDT
GO
CREATE VIEW PrevencionLDT
AS
SELECT        a.ID, a.Empresa, a.Mov, a.MovID, a.FechaEmision, a.UltimoCambio, a.Concepto, a.Proyecto, a.UEN, a.Moneda, a.TipoCambio, a.Usuario, a.Autorizacion, 
                         a.Referencia, a.DocFuente, a.Observaciones, a.Estatus, a.Situacion, a.SituacionFecha, a.SituacionUsuario, a.SituacionNota, a.OrigenTipo, a.Origen, 
                         a.OrigenID, a.Ejercicio, a.Periodo, a.FechaRegistro, a.FechaConclusion, a.FechaCancelacion, a.Sucursal, a.SucursalOrigen, a.SucursalDestino, a.ContID, 
                         a.Poliza, a.PolizaID, a.GenerarPoliza, a.Vencimiento, a.Acreedor, a.Condicion, a.Cliente, a.Almacen, a.ActEconomica, b.Renglon, b.OrigenModulo, 
                         b.OrigenModuloID, b.Aplica, b.AplicaId, b.Importe, b.ActEconimica, b.SaldoActual, b.SaldoAnterior, b.Variacion, b.Contacto, b.ContactoTipo,a.FechaPoliza,a.GenerarDinero
FROM            PrevencionLD AS a INNER JOIN
                         PrevencionLDD AS b ON a.ID = b.ID
GO