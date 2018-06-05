---------------------------------------------
/***** INICIA: Flujo de Efectivo Fondos ****/
---------------------------------------------

--------------------
/**** MovClave ****/
--------------------
IF NOT EXISTS (SELECT * FROM MovClave WHERE Modulo = 'DIN' AND Clave = 'DIN.ABFON')
	INSERT INTO MovClave
		(Modulo,	Clave,				NombreOmision,		Descripcion,																								EstatusContabilizar, SubClaveDe)
	SELECT
		'DIN',		'DIN.ABFON',	'Ingreso Fondos',	'Permite habilitar la funcionalidad de Concepto FE Fondos',	'CONCLUIDO',					'DIN.AB'

IF NOT EXISTS (SELECT * FROM MovClave WHERE Modulo = 'DIN' AND Clave = 'DIN.TFON')
	INSERT INTO MovClave
		(Modulo,	Clave,				NombreOmision,		Descripcion,																								EstatusContabilizar, SubClaveDe)
	SELECT
		'DIN',		'DIN.TFON',	'Transferencia Fondos',	'Permite habilitar la funcionalidad de Concepto FE Fondos',	'CONCLUIDO',					'DIN.T'

IF NOT EXISTS (SELECT * FROM MovClave WHERE Modulo = 'DIN' AND Clave = 'DIN.TFONR')
	INSERT INTO MovClave
		(Modulo,	Clave,				NombreOmision,		Descripcion,																								EstatusContabilizar, SubClaveDe)
	SELECT
		'DIN',		'DIN.TFONR',	'Reclasificación Fondos',	'Permite habilitar la funcionalidad de Concepto FE Fondos, resta en reporte',	'CONCLUIDO',					'DIN.T'

IF NOT EXISTS (SELECT * FROM MovClave WHERE Modulo = 'DIN' AND Clave = 'DIN.TFONOP')
	INSERT INTO MovClave
		(Modulo,	Clave,				NombreOmision,		Descripcion,																								EstatusContabilizar, SubClaveDe)
	SELECT
		'DIN',		'DIN.TFONOP',	'Transf. Operaciones',	
		'Permite habilitar la funcionalidad de Concepto FE Fondos, resta en reporte, se refleja en secciona de aplicaciones',	'CONCLUIDO',					'DIN.T'

IF NOT EXISTS (SELECT * FROM MovClave WHERE Modulo = 'DIN' AND Clave = 'DIN.CBFON')
	INSERT INTO MovClave
		(Modulo,	Clave,				NombreOmision,		Descripcion,																								EstatusContabilizar, SubClaveDe)
	SELECT
		'DIN',		'DIN.CBFON',	'Egreso Fondos',	'Permite habilitar la funcionalidad de Concepto FE Fondos',	'CONCLUIDO',					'DIN.CB'

IF NOT EXISTS (SELECT * FROM MovClave WHERE Modulo = 'DIN' AND Clave = 'DIN.CHEFON')
	INSERT INTO MovClave
		(Modulo,	Clave,				NombreOmision,		Descripcion,																								EstatusContabilizar, SubClaveDe)
	SELECT
		'DIN',		'DIN.CHEFON',	'Cheque Elec Fondos',	'Permite habilitar la funcionalidad de Concepto FE Fondos',	'CONCLUIDO',					'DIN.CHE'

-------------------
/**** MovTipo ****/
-------------------
IF NOT EXISTS (SELECT * FROM MovTipo WHERE Mov = 'Pago Poliza' AND Modulo = 'CXP')
	INSERT MovTipo 
		(Modulo, Mov,						Clave,		ConsecutivoModulo,	ConsecutivoMov,	Factor) 		
	VALUES 
		('CXP',	'Pago Poliza',	'CXP.F',	'CXP',							'Pago Poliza',	1)

IF NOT EXISTS (SELECT * FROM MovTipo WHERE Mov = 'Cheque Fondos' AND Modulo = 'DIN')
	INSERT MovTipo 
		(Modulo, Mov,							Clave,		SubClave,			ConsecutivoModulo,	ConsecutivoMov,	Factor) 		
	VALUES 
		('DIN',	'Cheque Fondos',	'DIN.CHE','DIN.CHEFON',	'DIN',							'Cheque Fondos',	1)

IF NOT EXISTS (SELECT * FROM MovTipo WHERE Mov = 'Ingreso Fondos NI' AND Modulo = 'DIN')
	INSERT MovTipo 
		(Modulo, Mov,							Clave,		SubClave,			ConsecutivoModulo,	ConsecutivoMov,	Factor) 		
	VALUES 
		('DIN',	'Ingreso Fondos NI',	'DIN.AB','DIN.ABFON',	'DIN',							'Ingreso Fondos NI',	1)

IF NOT EXISTS (SELECT * FROM MovTipo WHERE Mov = 'Clasificacion Fondos' AND Modulo = 'DIN')
	INSERT MovTipo 
		(Modulo, Mov,							Clave,		SubClave,			ConsecutivoModulo,	ConsecutivoMov,	Factor) 		
	VALUES 
		('DIN',	'Clasificacion Fondos',	'DIN.T','DIN.TFON',	'DIN',							'Clasificacion Fondos',	1)

IF NOT EXISTS (SELECT * FROM MovTipo WHERE Mov = 'Reclasificacion Fond' AND Modulo = 'DIN')
	INSERT MovTipo 
		(Modulo, Mov,							Clave,		SubClave,			ConsecutivoModulo,	ConsecutivoMov,	Factor) 		
	VALUES 
		('DIN',	'Reclasificacion Fond',	'DIN.T','DIN.TFONR',	'DIN',							'Reclasificacion Fond',	1)

IF NOT EXISTS (SELECT * FROM MovTipo WHERE Mov = 'Trasf. Operacion' AND Modulo = 'DIN')
	INSERT MovTipo 
		(Modulo, Mov,							Clave,		SubClave,			ConsecutivoModulo,	ConsecutivoMov,	Factor) 		
	VALUES 
		('DIN',	'Trasf. Operacion',	'DIN.T','DIN.TFONOP',	'DIN',							'Trasf. Operacion',	1)

IF NOT EXISTS (SELECT * FROM MovTipo WHERE Mov = 'Dev. Aportaciones' AND Modulo = 'DIN')
	INSERT MovTipo 
		(Modulo, Mov,							Clave,		SubClave,			ConsecutivoModulo,	ConsecutivoMov,	Factor) 		
	VALUES 
		('DIN',	'Dev. Aportaciones',	'DIN.CB','DIN.CBFON',	'DIN',							'Dev. Aportaciones',	1)

IF NOT EXISTS (SELECT * FROM MovTipo WHERE Mov = 'Pago Pólizas' AND Modulo = 'DIN')
	INSERT MovTipo 
		(Modulo, Mov,							Clave,		SubClave,			ConsecutivoModulo,	ConsecutivoMov,	Factor) 		
	VALUES 
		('DIN',	'Pago Pólizas',	'DIN.CB','DIN.CBFON',	'DIN',							'Pago Pólizas',	1)

IF NOT EXISTS (SELECT * FROM MovTipo WHERE Mov = 'Retiro Aportacion' AND Modulo = 'DIN')
	INSERT MovTipo 
		(Modulo, Mov,							Clave,		SubClave,			ConsecutivoModulo,	ConsecutivoMov,	Factor) 		
	VALUES 
		('DIN',	'Retiro Aportacion',	'DIN.CB','DIN.CBFON',	'DIN',							'Retiro Aportacion',	1)


GO
----------------------------------------------
/***** TERMINA: Flujo de Efectivo Fondos ****/
----------------------------------------------