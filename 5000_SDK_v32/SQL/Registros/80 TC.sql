--REQ13163
IF NOT EXISTS(SELECT * FROM TCCfg)
  INSERT INTO TCCfg(Empresa) SELECT Empresa FROM Empresa
GO

--REQ13163
IF NOT EXISTS(SELECT * FROM TCProcesadorTrans)
BEGIN
  INSERT INTO TCProcesadorTrans(ProcesadorTrans, TerminalEquiv) VALUES('BANORTE', 1)
END
GO

--REQ13163 BUG19155
IF NOT EXISTS(SELECT * FROM TCPinPad WHERE PinPad = '001')
  INSERT INTO TCPinPad(Pinpad, Modelo, Fabricante, Velocidad, BitsDatos, Paridad, BitsParada, CtrlFlujo, Estatus) VALUES('001', 'NURIT 293', 'VERIFONE', 19200, 8, 'N', 1, 0, 'ALTA')
GO

--REQ13163
IF NOT EXISTS(SELECT Fabricante FROM Fabricante WHERE Fabricante = 'VERIFONE')
  INSERT INTO Fabricante(Fabricante) VALUES('VERIFONE')
GO

IF NOT EXISTS(SELECT Categoria FROM ProvCat WHERE Categoria = 'NACIONAL')
  INSERT INTO ProvCat(Categoria) VALUES('NACIONAL')
GO

--REQ13163
IF NOT EXISTS(SELECT * FROM TCHashTableDefinicion WHERE ProcesadorTrans = 'BANORTE')
BEGIN
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'ARQC', 'ARQC'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'AuthCode', 'Codigo Autorizacion'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'CardType', 'Tipo Tarjeta'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'CcErrCode', 'Codigo Error'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'CcReturnMsg', 'Mensaje Error'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'E1', 'E1'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'E2', 'E2'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'E3', 'E3'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'IssuingBank', 'Banco Emisor'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'MaxSev', 'Severidad Error'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'OperType', 'Tipo Operacion'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'OrderId', 'ID Orden'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'ProcReturnCode', 'Codigo Procesador'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'ProcReturnMsg', 'Mensaje Procesador'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'Status', 'Estatus'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'Text', 'Texto'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'TimeIn', 'Fecha Inicio'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'TimeOut', 'Fecha Fin'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'Total', 'Total'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'TransType', 'Tipo Transaccion'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'Track2', 'Track2'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'CardHolder', 'Tarjetahabiente'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'CardNumber', 'Numero Tarjeta'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'ExpirationDate', 'Fecha Expiracion'
  INSERT INTO TCHashTableDefinicion(ProcesadorTrans, Columna, Campo) SELECT 'BANORTE', 'Track1', 'Track1'
END
GO