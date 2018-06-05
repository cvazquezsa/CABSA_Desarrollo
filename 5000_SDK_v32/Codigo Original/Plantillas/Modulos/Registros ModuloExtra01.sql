SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

-- Modulos
insert Modulo (Modulo, Nombre) VALUES ('MEX01',  'ModuloExtra01')

-- MovClave
if not exists(select * from MovClave WHERE Clave = 'MEX01.SOP')
  insert MovClave (Modulo, NombreOmision, Clave) values ('MEX01',	'Solicitud',		 	 'MEX01.SOP')
if not exists(select * from MovClave WHERE Clave = 'MEX01.OP')
  insert MovClave (Modulo, NombreOmision, Clave) values ('MEX01',	'Operacion',		 	 'MEX01.OP')
GO

-- MovTipo
if not exists(select * from MovTipo where Modulo = 'MEX01')
begin
  insert MovTipo (Modulo, Orden, Mov, Clave, ConsecutivoModulo, ConsecutivoMov) values ('MEX01',	10,	'Solicitud',	'MEX01.SOP',    'MEX01',  'Solicitud')
  insert MovTipo (Modulo, Orden, Mov, Clave, ConsecutivoModulo, ConsecutivoMov) values ('MEX01',	20,	'Operacion',	'MEX01.OP',     'MEX01',  'Operacion')
end
go

