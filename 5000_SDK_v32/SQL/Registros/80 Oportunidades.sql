--REQ16092
IF NOT EXISTS(SELECT * FROM MovSituacionL WHERE Modulo = 'VTAS' AND Mov = 'Prop. Oportunidad' AND Estatus = 'CONFIRMAR')
  INSERT INTO MovSituacionL(Modulo, Mov, Estatus, Logico1, Logico2, Logico3, Flujo) VALUES('VTAS', 'Prop. Oportunidad', 'CONFIRMAR', 0, 0, 0, 'Normal')
GO

IF NOT EXISTS(SELECT * FROM MovSituacion WHERE Modulo = 'VTAS' AND Mov = 'Prop. Oportunidad' AND Estatus = 'CONFIRMAR' AND Situacion = 'Oportunidad En Proceso')
  INSERT INTO MovSituacion(Modulo, Mov, Estatus, Orden, Situacion, Flujo, PermiteAfectacion, PermiteBrincar, PermiteRetroceder, CondicionUsuario) VALUES('VTAS', 'Prop. Oportunidad', 'CONFIRMAR', 1, 'Oportunidad En Proceso', 'Inicial Todas', 0, 0, 0, 0)
GO

--REQ16092
DELETE FROM OportunidadTagAyuda
GO
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Modulo>', 1, 1, 1, 1, 'Módulo del movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<ID>', 0, 0, 1, 1, 'ID del movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Empresa>', 1, 1, 1, 1, 'Empresa del movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<EmpresaNombre>', 1, 1, 1, 1, 'Nombre de la empresa')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Sucursal>', 1, 1, 1, 1, 'Sucursal del movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<SucursalNombre>', 1, 1, 1, 1, 'Nombre de la sucursal')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<UEN>', 1, 1, 1, 1, 'UEN del movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<UENNombre>', 1, 1, 1, 1, 'Nombre de la UEN')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Usuario>', 1, 1, 1, 1, 'Usuario del movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<UsuarioNombre>', 1, 1, 1, 1, 'Nombre del Usuario')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Movimiento>', 1, 1, 1, 1, 'Tipo de movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Estatus>', 1, 1, 1, 1, 'Estatus del movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Situacion>', 1, 1, 1, 1, 'Situación del movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Proyecto>', 1, 1, 1, 1, 'Proyecto del movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<ContactoTipo>', 1, 1, 1, 1, 'Tipo de contacto')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Contacto>', 1, 1, 1, 1, 'Contacto del movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<ContactoNombre>', 1, 1, 1, 1, 'Nombre del contacto')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Importe>', 1, 1, 1, 1, 'Importe del movimiento')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Hoy>', 1, 1, 1, 1, 'Fecha del día de hoy')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Ahora>', 1, 1, 1, 1, 'Fecha y hora del día de hoy')
INSERT OportunidadTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<FechaEmision>', 1, 1, 1, 1, 'Fecha de emisión del movimiento')
GO

IF NOT EXISTS(SELECT * FROM OportunidadPlantillaeMail WHERE Plantilla = 'GENERICA')
BEGIN
  DECLARE @FechaEmision		datetime,
		  @ID				int

  SELECT @FechaEmision = GETDATE()
  
  EXEC spExtraerFecha @FechaEmision OUTPUT
  
  INSERT INTO OportunidadPlantillaeMail(Plantilla, FechaEmision, Usuario, Estatus, Comentarios, Asunto) SELECT 'GENERICA', @FechaEmision, 'DEMO', 'Activa', '', '<Movimiento> <Contacto>'
  
  SELECT @ID =  @@IDENTITY
  
  INSERT INTO OportunidadPlantillaeMailMensaje(ID, Mensaje) SELECT @ID, 'Correo enviado desde el <Movimiento>' + CHAR(13) + CHAR(10) +  CHAR(13) + CHAR(10) + 'INTELISIS ERP'
END
