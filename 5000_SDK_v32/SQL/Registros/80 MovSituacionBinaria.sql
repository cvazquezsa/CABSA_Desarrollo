-- 11464
DELETE MovSituacionBinariaTagAyuda
GO
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<ID>', 'ID del Movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Cajero>', 'Cajero del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Causa>', 'Causa del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Clase>', 'Clase del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Concepto>', 'Concepto del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Condicion>', 'Condicion del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Contacto>', 'Contacto del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<CtaDinero>', 'Cuenta de Dinero del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Ejercicio>', 'Ejercicio del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Empresa>', 'Empresa del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<EnviarA>', 'Sucursal del cliente del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<FechaCancelacion>', 'Fecha de Cancelación del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<FechaEmision>', 'Fecha de Emisión  del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<FechaRegistro>', 'Fecha de Registro del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<FormaEnvio>', 'Forma de Envio'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Importe>', 'Importe del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Impuestos>', 'Impuestos del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Moneda>', 'Moneda del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<MovID>', 'Folio del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Observaciones>', 'Observaciones del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Origen>', 'Movimiento Origen del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<OrigenID>', 'Folio del Origen del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<OrigenTipo>', 'Módulo de Origen del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Periodo>', 'Periodo del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Proyecto>', 'Proyecto del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<RamaID>', 'ID Rama del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Referencia>', 'Referencia del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Retenciones>', 'Retenciones del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<SubClase>', 'Sub Clase del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Sucursal>', 'Sucursal del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<TipoCambio>', 'Tipo de Cam del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Total>', 'Total del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<UEN>', 'UEN del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Usuario>', 'Usuario del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<Vencimiento>', 'Vencimiento del movimiento'
INSERT INTO MovSituacionBinariaTagAyuda(Tag, Descripcion) SELECT '<ZonaImpuesto>', 'Zona de Impuestos del movimiento'
GO

--BUG15738
DELETE MovSituacionBinariaTagAyuda WHERE Tag = '<FechaCancelacion>'
GO

--BUG15856
DELETE MovSituacionBinariaTagAyuda WHERE Tag = '<FechaRegistro>'
GO