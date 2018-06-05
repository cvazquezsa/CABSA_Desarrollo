SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

--IF NOT EXISTS(SELECT * FROM EmpresaCfgModulo WHERE Empresa = 'DEMO' AND Modulo = 'COMS')
--  INSERT EmpresaCfgModulo(Empresa, Modulo, EditarConsec, Situaciones, Tiempos, ContXGenerar, ValidarFechas, PeriodosEspeciales, FechaEmision, FlujoAbierto, TipoCambio)
--            VALUES('DEMO', 'COMS', 'No', 'No', 'No', 'No', 'No', 'No', 'Cliente', 'Si', 'General')

--IF EXISTS(SELECT * FROM EmpresaCfgModulo WHERE Empresa = 'DEMO' AND Modulo = 'COMS' AND FlujoAbierto = 'No')
--  UPDATE EmpresaCfgModulo SET FlujoAbierto = 'Si' WHERE Empresa = 'DEMO' AND Modulo = 'COMS' AND FlujoAbierto = 'No'

IF NOT EXISTS(SELECT * FROM MovClave WHERE Modulo = 'COMS' and Clave = 'COMS.EIMPO')
  INSERT MovClave (Modulo, Clave, NombreOmision, SubClaveDe) VALUES ('COMS', 'COMS.EIMPO', 'Recibo Importacion', 'COMS.O')

IF NOT EXISTS(SELECT * FROM MovClave WHERE Modulo = 'COMS' and Clave = 'COMS.OIMPO')
  INSERT MovClave (Modulo, Clave, NombreOmision, SubClaveDe) VALUES ('COMS', 'COMS.OIMPO', 'Recibo Importacion', 'COMS.O')


IF NOT EXISTS(SELECT * FROM MovTipo WHERE modulo = 'COMS' and Mov = 'Confirma Proveedor')
  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('COMS', 300, 'Confirma Proveedor', 'COMS.O', 'COMS.OIMPO', 'COMS', 'Confirma Proveedor')

IF NOT EXISTS(SELECT * FROM MovTipo WHERE modulo = 'COMS' and Mov = 'Factura Proveedor')
  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('COMS', 300, 'Factura Proveedor', 'COMS.O', 'COMS.OIMPO', 'COMS', 'Factura Proveedor')

IF NOT EXISTS(SELECT * FROM MovTipo WHERE modulo = 'COMS' and Mov = 'Puerto de Salida')
  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('COMS', 300, 'Puerto de Salida', 'COMS.O', 'COMS.OIMPO', 'COMS', 'Puerto de Salida')

IF NOT EXISTS(SELECT * FROM MovTipo WHERE modulo = 'COMS' and Mov = 'Transito Int')
  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('COMS', 300, 'Transito Int', 'COMS.O', 'COMS.OIMPO', 'COMS', 'Transito Int')

IF NOT EXISTS(SELECT * FROM MovTipo WHERE modulo = 'COMS' and Mov = 'Aduana')
  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('COMS', 300, 'Aduana', 'COMS.O', 'COMS.OIMPO', 'COMS', 'Aduana')

IF NOT EXISTS(SELECT * FROM MovTipo WHERE modulo = 'COMS' and Mov = 'Transito Nal')
  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('COMS', 300, 'Transito Nal', 'COMS.O', 'COMS.OIMPO', 'COMS', 'Transito Nal')

IF NOT EXISTS(SELECT * FROM MovTipo WHERE modulo = 'COMS' and Mov = 'Recibo Importacion')
  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('COMS', 300, 'Recibo Importacion', 'COMS.O', 'COMS.EIMPO', 'COMS', 'Recibo Importacion')
GO

IF NOT EXISTS(SELECT * FROM CfgMovFlujo WHERE Modulo = 'COMS' AND OMov = 'Orden Compra' AND DMov = 'Confirma Proveedor')
  INSERT CfgMovFlujo(Modulo,  OMov, DMov, Orden, Nombre)
        VALUES(      'COMS', 'Orden Compra', 'Confirma Proveedor', 1, 'Confirma Proveedor')

IF NOT EXISTS(SELECT * FROM CfgMovFlujo WHERE Modulo = 'COMS' AND OMov = 'Orden Compra' AND DMov = 'Entrada Compra')
  INSERT CfgMovFlujo(Modulo,  OMov, DMov, Orden, Nombre)
        VALUES(      'COMS', 'Orden Compra', 'Entrada Compra', 2, 'Entrada Compra')

IF NOT EXISTS(SELECT * FROM CfgMovFlujo WHERE Modulo = 'COMS' AND OMov = 'Orden Compra' AND DMov = 'Compra Perdida')
  INSERT CfgMovFlujo(Modulo,  OMov, DMov, Orden, Nombre)
        VALUES(      'COMS', 'Orden Compra', 'Compra Perdida', 3, 'Compra Perdida')

IF NOT EXISTS(SELECT * FROM CfgMovFlujo WHERE Modulo = 'COMS' AND OMov = 'Confirma Proveedor' AND DMov = 'Factura Proveedor')
  INSERT CfgMovFlujo(Modulo,  OMov, DMov, Orden, Nombre)
        VALUES(      'COMS', 'Confirma Proveedor', 'Factura Proveedor', 1, 'Factura Proveedor')

IF NOT EXISTS(SELECT * FROM CfgMovFlujo WHERE Modulo = 'COMS' AND OMov = 'Factura Proveedor' AND DMov = 'Puerto de Salida')
  INSERT CfgMovFlujo(Modulo,  OMov, DMov, Orden, Nombre)
        VALUES(      'COMS', 'Factura Proveedor', 'Puerto de Salida', 1, 'Puerto de Salida')

IF NOT EXISTS(SELECT * FROM CfgMovFlujo WHERE Modulo = 'COMS' AND OMov = 'Puerto de Salida' AND DMov = 'Transito Int')
  INSERT CfgMovFlujo(Modulo,  OMov, DMov, Orden, Nombre)
        VALUES(      'COMS', 'Puerto de Salida', 'Transito Int', 1, 'Transito Int')

IF NOT EXISTS(SELECT * FROM CfgMovFlujo WHERE Modulo = 'COMS' AND OMov = 'Puerto de Salida' AND DMov = 'Recibo Importacion')
  INSERT CfgMovFlujo(Modulo,  OMov, DMov, Orden, Nombre)
        VALUES(      'COMS', 'Puerto de Salida', 'Recibo Importacion', 2, 'Recibo Importacion')

IF NOT EXISTS(SELECT * FROM CfgMovFlujo WHERE Modulo = 'COMS' AND OMov = 'Transito Int' AND DMov = 'Aduana')
  INSERT CfgMovFlujo(Modulo,  OMov, DMov, Orden, Nombre)
        VALUES(      'COMS', 'Transito Int', 'Aduana', 1, 'Aduana')

IF NOT EXISTS(SELECT * FROM CfgMovFlujo WHERE Modulo = 'COMS' AND OMov = 'Aduana' AND DMov = 'Transito Nal')
  INSERT CfgMovFlujo(Modulo,  OMov, DMov, Orden, Nombre)
        VALUES(      'COMS', 'Aduana', 'Transito Nal', 1, 'Transito Nal')

IF NOT EXISTS(SELECT * FROM CfgMovFlujo WHERE Modulo = 'COMS' AND OMov = 'Transito Nal' AND DMov = 'Recibo Importacion')
  INSERT CfgMovFlujo(Modulo,  OMov, DMov, Orden, Nombre)
        VALUES(      'COMS', 'Transito Nal', 'Recibo Importacion', 1, 'Recibo Importacion')
GO