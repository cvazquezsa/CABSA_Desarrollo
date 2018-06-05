/* Configuracion MS SQL Server */

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF

GO

--                             MODULO PREVECNION DE LAVADO DE DINERO
--Operacion Relevante
IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'PREV' and Clave='PREV.OR')
  INSERT MovTipo (Modulo, Orden, Mov,             Clave,     ConsecutivoModulo, ConsecutivoMov) 
          VALUES ('PREV', 1,	'Ope. Relevante', 'PREV.OR', 'PREV',           'Ope. Relevante')
GO
if NOT EXISTS(select * from MovClave WHERE Clave = 'PREV.OR')
  INSERT MovClave (Modulo, NombreOmision, Clave) 
           VALUES ('PREV', 'Ope. Relevante',	'PREV.OR')
GO

--Operacion Inusual
IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'PREV' and Clave='PREV.OI')
  INSERT MovTipo (Modulo, Orden, Mov,             Clave,     ConsecutivoModulo, ConsecutivoMov) 
          values ('PREV', 1,	'Ope. Inusual', 'PREV.OI', 'PREV',           'Ope. Inusual')
GO
if NOT EXISTS(select * from MovClave WHERE Clave = 'PREV.OI')
  INSERT MovClave (Modulo, NombreOmision, Clave) 
           VALUES ('PREV', 'Ope. Inusual',	'PREV.OI')
GO

--Operacion Preocupante
IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'PREV' and Clave='PREV.OP')
  INSERT MovTipo (Modulo, Orden, Mov,             Clave,     ConsecutivoModulo, ConsecutivoMov) 
          values ('PREV', 1,	'Ope. Preocupante', 'PREV.OP', 'PREV',           'Ope. Preocupante')
GO
if NOT EXISTS(select * from MovClave WHERE Clave = 'PREV.OP')
  INSERT MovClave (Modulo, NombreOmision, Clave) 
           VALUES ('PREV', 'Ope. Preocupante',	'PREV.OP')
GO

--Lista Negra
IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'PREV' and Clave='PREV.LN')
  INSERT MovTipo (Modulo, Orden, Mov,             Clave,     ConsecutivoModulo, ConsecutivoMov) 
          values ('PREV', 1,	'Lista Negra', 'PREV.LN', 'PREV',           'Lista Negra')
GO
if NOT EXISTS(select * from MovClave WHERE Clave = 'PREV.LN')
  INSERT MovClave (Modulo, NombreOmision, Clave) 
           VALUES ('PREV', 'Lista Negra',	'PREV.LN')
GO


--Lista Pep
IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'PREV' and Clave='PREV.LP')
  INSERT MovTipo (Modulo, Orden, Mov,             Clave,     ConsecutivoModulo, ConsecutivoMov) 
          values ('PREV', 1,	'Lista PEP', 'PREV.LP', 'PREV',           'Lista PEP')
GO
if NOT EXISTS(select * from MovClave WHERE Clave = 'PREV.LP')
  INSERT MovClave (Modulo, NombreOmision, Clave) 
           VALUES ('PREV', 'Lista PEP',	'PREV.LP')
GO

--                             MODULO PREVECNION DE LAVADO DE DINERO


PRINT "******************* REGISTROS DEFAULT ******************"
GO

