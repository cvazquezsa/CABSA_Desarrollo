/* CONSTANTES     */

/**** MensajeListas ****/
DELETE MensajeLista
GO
insert MensajeLista (Mensaje,Descripcion) VALUES (1,    'Error gen�rico del SQL Server')
insert MensajeLista (Mensaje,Descripcion) VALUES (2,    'Error gen�rico del M�dulo Central')
insert MensajeLista (Mensaje,Descripcion) VALUES (3,    'El Usuario indicado no tiene acceso al servicio')
--REQ25014
insert MensajeLista (Mensaje,Descripcion) VALUES (4,    'Error gen�rico de Intelisis Service')
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES(5, 'Error g�nerico de Emida', 'ERROR', 0) -- REQ12336
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES(7, 'Error g�nerico de Tarjeta Bancaria', 'ERROR', 0) -- REQ13163
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES(8, 'Falta procesar el cobro con Tarjeta Bancaria', 'ERROR', 0) -- REQ13163
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES(9, 'No se puede Cancelar un movimiento con cobros con Tarjeta Bancaria', 'ERROR', 0) -- REQ13163
insert MensajeLista (Mensaje,Descripcion) VALUES (10,   'No se puede Afectar fuera de una transacci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (11,   'Este M�dulo no puede operar en modo "Fuera L�nea"')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (12,   'Ya hay l�nea, favor de salir y volver a entrar al Sistema', 'INFO')
insert MensajeLista (Mensaje,Descripcion) VALUES (13,   'No puede operar en modo "Fuera L�nea"')

insert MensajeLista (Mensaje,Descripcion) VALUES (9010,'La licencia no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (9020,'La licencia est� bloqueada')
insert MensajeLista (Mensaje,Descripcion) VALUES (9030,'La Licencia no est� dada de Alta')
insert MensajeLista (Mensaje,Descripcion) VALUES (9040,'La Licencia ya est� dada de Alta')

insert MensajeLista (Mensaje,Descripcion) VALUES (10010,'Campo requerido')
insert MensajeLista (Mensaje,Descripcion) VALUES (10011,'Peso de Tarima Incorrecto') --BUG4572
insert MensajeLista (Mensaje,Descripcion) VALUES (10015,'Estatus incorrecto')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10020,'Falta configurar la P�liza del movimiento', 'CFG')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10025,'Falta configurar el flujo del Movimiento Recurrente (por omisi�n)', 'CFG')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10026,'Falta configurar el flujo del Movimiento Contratos (por omisi�n)', 'CFG')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10030,'Tipo de P�liza incorrecta', 'CFG')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10031,'Falta configurar el Art�culo para el Deducible', 'CFG')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10032,'Falta configurar el Art�culo para el Coaseguro', 'CFG')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10033,'Falta configurar el Mapa Movimientos (eCollaboration)', 'CFG')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10034,'Falta configurar el concepto N�mina', 'CFG')

--REQ12615 WMS
insert MensajeLista (Mensaje,Descripcion) VALUES (10035,'Falta configurar el Art�culo')
insert MensajeLista (Mensaje,Descripcion) VALUES (10036,'Falta configurar control del Art�culo')


insert MensajeLista (Mensaje,Descripcion) VALUES (10037,'No se puede crear el movimiento de orden de entarimado. No puede contener art�culos con opciones')
insert MensajeLista (Mensaje,Descripcion) VALUES (10038,'La posici�n destino no es tipo Domicilio')
insert MensajeLista (Mensaje,Descripcion) VALUES (10039,'La posici�n destino es tipo Domicilio')

insert MensajeLista (Mensaje,Descripcion) VALUES (10040,'Cliente Incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (10045,'Estatus Incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (10050,'Ejercicio Incorrecto')
--REQ25014
insert MensajeLista (Mensaje,Descripcion) VALUES (10051,'Periodo Incorrecto')

insert MensajeLista (Mensaje,Descripcion, IE) VALUES (10060,'Dato Incorrecto', 1)
insert MensajeLista (Mensaje,Descripcion) VALUES (10061,    'Falta configurar movimiento a generar en m�dulo de Proyectos')
insert MensajeLista (Mensaje,Descripcion) VALUES (10062,    'Falta configurar movimiento a generar en m�dulo de Ventas')
insert MensajeLista (Mensaje,Descripcion) VALUES (10065,'No Se Puede Afectar')
insert MensajeLista (Mensaje,Descripcion) VALUES (10066,'No Se Puede Reemplazar')
insert MensajeLista (Mensaje,Descripcion) VALUES (10070,'Falta Indicar la UEN')
insert MensajeLista (Mensaje,Descripcion) VALUES (10080,'Falta Indicar la Clasificaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (10090,'Falta Indicar la Subclasificaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (10095,'Falta Indicar una Vigencia V�lida')
insert MensajeLista (Mensaje,Descripcion) VALUES (10100,'No Puede Cancelar')
insert MensajeLista (Mensaje,Descripcion) VALUES (10110,'Error al Generar el Gasto')
insert MensajeLista (Mensaje,Descripcion) VALUES (10115,'Falta Indicar el Acreedor o Concepto del Gasto')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10116,'Falta Configurar el Acreedor o Concepto del Gasto', 'CFG')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10117,'Falta Configurar el Acreedor del Gasto en CR', 'CFG')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10118,'Falta Configurar el Acreedor del Gasto en el Tipo de Movimiento', 'CFG')
insert MensajeLista (Mensaje,Descripcion) VALUES (10120,'No Corresponde el Autob�s')
insert MensajeLista (Mensaje,Descripcion) VALUES (10125,'Falta Indicar el Autob�s')
insert MensajeLista (Mensaje,Descripcion) VALUES (10130,'Falta Indicar el Centro Costos')
insert MensajeLista (Mensaje,Descripcion) VALUES (10140,'El Bolet�n ya fue Utilizado')
insert MensajeLista (Mensaje,Descripcion) VALUES (10150,'El Archivo del Bolet�n tiene incongruencias, No se puede Utilizar')
insert MensajeLista (Mensaje,Descripcion) VALUES (10160,'No Seleccion� ning�n Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (10170,'Necesita Afectar el Ajuste Pendiente para continuar.')
insert MensajeLista (Mensaje,Descripcion) VALUES (10180,'No se puede Facturar Negativos')
insert MensajeLista (Mensaje,Descripcion) VALUES (10190,'Fecha Previamente Utilizada')
insert MensajeLista (Mensaje,Descripcion) VALUES (10200,'Falta Indicar la Sucursal')
insert MensajeLista (Mensaje,Descripcion) VALUES (10210,'Falta Indicar el Espacio')
insert MensajeLista (Mensaje,Descripcion) VALUES (10220,'No Corresponde el Acreedor con el Concepto')
insert MensajeLista (Mensaje,Descripcion) VALUES (10230,'Falta Indicar el Folio')
insert MensajeLista (Mensaje,Descripcion) VALUES (10240,'Folio Duplicado')
insert MensajeLista (Mensaje,Descripcion) VALUES (10245,'Art�culo Duplicado')
insert MensajeLista (Mensaje,Descripcion) VALUES (10250,'Excede al Pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (10260,'Categor�a Incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (10270,'El Agente Indicado No Est� Disponible en Fecha/Hora Requerida')
insert MensajeLista (Mensaje,Descripcion) VALUES (10280,'No Tiene el Perfil para Netear')
insert MensajeLista (Mensaje,Descripcion) VALUES (10290,'Falta Indicar el Endoso')
insert MensajeLista (Mensaje,Descripcion) VALUES (10295,'Falta Indicar el N�mero de Siniestro')
insert MensajeLista (Mensaje,Descripcion) VALUES (10300,'Endoso Incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (10310,'No Corresponden las Ventas contra los Cobros')
insert MensajeLista (Mensaje,Descripcion) VALUES (10320,'No Corresponden las Ventas contra los Vendedores')
insert MensajeLista (Mensaje,Descripcion) VALUES (10330,'No Corresponden las Operaciones')
insert MensajeLista (Mensaje,Descripcion) VALUES (10340,'No Corresponden las Cantidades')
insert MensajeLista (Mensaje,Descripcion) VALUES (10350,'Error al Anexar')
insert MensajeLista (Mensaje,Descripcion) VALUES (10360,'Falta Configurar la Tasa')
insert MensajeLista (Mensaje,Descripcion) VALUES (10370,'Para Facturar Autos Nuevos Requiere Cargar el ISAN')
insert MensajeLista (Mensaje,Descripcion) VALUES (10380,'Falta Configurar la Tabla')
-- 'CORTE'
insert MensajeLista (Mensaje,Descripcion) VALUES (10385,'Falta configurar n�mero de periodo')
insert MensajeLista (Mensaje,Descripcion) VALUES (10386,'Falta Configurar el Tipo de Totalizador')
insert MensajeLista (Mensaje,Descripcion) VALUES (10387,'No Pueden Mezclarse Distintos Tipos de Totalizador')

insert MensajeLista (Mensaje,Descripcion) VALUES (10390,'Es Necesario Recalcular el Movimiento Antes de Afectar (F8-Totalizar)')
insert MensajeLista (Mensaje,Descripcion) VALUES (10400,'Es Necesario Indicar el Personal Involucrado')
insert MensajeLista (Mensaje,Descripcion) VALUES (10410,'En Movimientos Intercompa��a "Cliente/Proveedor/Empresa" deben tener la Misma Clave')
insert MensajeLista (Mensaje,Descripcion) VALUES (10420,'No Puede ser la misma Empresa (Movimientos Intercompa��a)')
insert MensajeLista (Mensaje,Descripcion) VALUES (10430,'Documentaci�n Incompleta')
insert MensajeLista (Mensaje,Descripcion) VALUES (10440,'C�digo UPC / EAN Incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (10450,'Falta Indicar el Proveedor del Art�culo (Movimientos Intercompa��a)')
insert MensajeLista (Mensaje,Descripcion) VALUES (10460,'Falta Definir la Propiedad de la N�mina')
insert MensajeLista (Mensaje,Descripcion) VALUES (10470,'Falta Definir la Relaci�n Usuario (Intelisis - Outlook)')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (10480,'No Corresponden las Instrucciones al Tipo de Movimiento', 'CFG')
insert MensajeLista (Mensaje,Descripcion) VALUES (10490,'Falta configurar Art�culo tipo servicio de anticipos facturados')  --ANTICIPOFACTURADO
insert MensajeLista (Mensaje,Descripcion) VALUES (10495,'El tipo de cambio del anticipo facturado difiere con el tipo de cambio del movimiento.')  --ANTICIPOFACTURADO

insert MensajeLista (Mensaje,Descripcion) VALUES (10500,'Falta Definir la Clave Intelisis del Departamento')
insert MensajeLista (Mensaje,Descripcion) VALUES (10510,'Falta Definir la Clave Intelisis de la Caja')
insert MensajeLista (Mensaje,Descripcion) VALUES (10515,'Falta Definir la Clave Intelisis del Cajero')
insert MensajeLista (Mensaje,Descripcion) VALUES (10520,'Falta Definir la Clave Intelisis del Banco')
insert MensajeLista (Mensaje,Descripcion) VALUES (10530,'Art�culo Incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (10540,'Cuenta Dinero Incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (10550,'Fecha Trabajo Incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (10551,'Fecha Trabajo Incorrecta. No corresponde con el Servidor')
insert MensajeLista (Mensaje,Descripcion) VALUES (10555,'La fecha del movimiento no corresponde a la fecha actual del sistema. No es posible la afectaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (10560,'Falta definir el Usuario por omisi�n de la Sucursal')
insert MensajeLista (Mensaje,Descripcion) VALUES (10570,'Falta definir el Almac�n por omisi�n de la Sucursal')
insert MensajeLista (Mensaje,Descripcion) VALUES (10575,'Falta definir el Almac�n por omisi�n Cliente o Usuario')
insert MensajeLista (Mensaje,Descripcion) VALUES (10576,'Falta Definir el Almac�n por omisi�n del Usuario')
insert MensajeLista (Mensaje,Descripcion) VALUES (10580,'Falta configurar el Cliente para Ventas Mostrador')
insert MensajeLista (Mensaje,Descripcion) VALUES (10581,'Falta configurar el Cliente de la Sucursal')
insert MensajeLista (Mensaje,Descripcion) VALUES (10590,'No se encontr� el Tipo de Cambio Original en la Bit�cora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10591,'No se encontr� la Tasa Diaria Original en la Bit�cora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10592,'No se encontr� el �ltimo devengado original en la Bit�cora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10600,'Falta configurar el Art�culo para el Redondeo')
insert MensajeLista (Mensaje,Descripcion) VALUES (10610,'T�tulo Incorrecto')

--REQ25014
insert MensajeLista (Mensaje,Descripcion) VALUES (10700,'Falta Configurar la Base de Datos Centralizadora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10701,'Falta Configurar el Web Service de la Base de Datos Centralizadora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10702,'No se pueden Recibir Cuentas en una Base de Datos No Centralizadora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10703,'No se pueden Centralizar Cuentas en una Base de Datos Centralizadora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10704,'Falta Configurar la Empresa Remota en la Base de Datos Centralizadora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10705,'No se puede Afectar este Movimiento en la Base de Datos Centralizadora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10706,'No se pueden Recibir Paquetes en una Base de Datos No Centralizadora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10707,'El Paquete contiene informaci�n de m�s d�as que los permitidos')
insert MensajeLista (Mensaje,Descripcion) VALUES (10708,'No se pueden Transformar P�lizas en una Base de Datos No Centralizadora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10709,'No se pueden hacer P�lizas Directas')
insert MensajeLista (Mensaje,Descripcion) VALUES (10710,'No se puede Cerrar Periodo en una Base de Datos No Centralizadora')
insert MensajeLista (Mensaje,Descripcion) VALUES (10711,'Falta Especificar la Empresa Origen')

insert MensajeLista (Mensaje,Descripcion) VALUES (12010,'No puede generar una Tabla Amortizaci�n con Fecha Anterior')
insert MensajeLista (Mensaje,Descripcion) VALUES (12020,'En Ministraciones Hipotecarias hay que manejar el M�todo 40')
insert MensajeLista (Mensaje,Descripcion) VALUES (12030,'Falta asignar Contrato a la L�nea de Cr�dito')


insert MensajeLista (Mensaje,Descripcion) VALUES (13010,'La Tarima no est� Disponible')
--BUG24312
insert MensajeLista (Mensaje,Descripcion) VALUES (13016,'El Art�culo no dispone de Posici�n de Domicilio')
insert MensajeLista (Mensaje,Descripcion) VALUES (13017,'Falta Configurar la Cantidad por Cama')
insert MensajeLista (Mensaje,Descripcion) VALUES (13018,'Falta Configurar las Camas por Tarima')

insert MensajeLista (Mensaje,Descripcion) VALUES (13020,'La Tarima no est� Pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (13030,'Posici�n Incorrecta')

--REQ12615 WMS
insert MensajeLista (Mensaje,Descripcion) VALUES (13034,'El and�n de surtido de los Movimientos seleccionados debe ser el mismo')
insert MensajeLista (Mensaje,Descripcion) VALUES (13035,'Posici�n destino incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (13036,'Posici�n destino o acomodador incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (13037,'La posici�n no est� en estatus Alta')
insert MensajeLista (Mensaje,Descripcion) VALUES (13038,'La posici�n actual no tiene asignado un Pasillo') --BUG2820
insert MensajeLista (Mensaje,Descripcion) VALUES (13039,'No se puede Modificar el Anden de Recibo.') --BUG5796
insert MensajeLista (Mensaje,Descripcion) VALUES (13040,'La tarima tiene otras �rdenes Pendientes')
insert MensajeLista (Mensaje,Descripcion) VALUES (13050,'Falta indicar la Posici�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (13055,'Falta indicar la Posici�n Destino')
insert MensajeLista (Mensaje,Descripcion) VALUES (13060,'Posici�n Ocupada')
insert MensajeLista (Mensaje,Descripcion) VALUES (13070,'Posici�n ocupada por otro Art�culo')
insert MensajeLista (Mensaje,Descripcion) VALUES (13080,'La tarima pertenece a Otra Empresa')
insert MensajeLista (Mensaje,Descripcion) VALUES (13090,'La tarima pertenece a Otro Almac�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (13100,'El Movimiento difiere con la Existencia')
insert MensajeLista (Mensaje,Descripcion) VALUES (13110,'Tarima Incorrecta')
GO
--Bug 6507
IF EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 13110)
UPDATE MensajeLista 
   SET Descripcion = 'Tarima Duplicada. <BR>No es posible tener el mismo art�culo y la misma tarima'
 WHERE Mensaje = 13110
GO
insert MensajeLista (Mensaje,Descripcion) VALUES (13120,'No hay posiciones disponibles')
insert MensajeLista (Mensaje,Descripcion) VALUES (13125,'No hay ubicaciones disponibles') --BUG4572
insert MensajeLista (Mensaje,Descripcion) VALUES (13130,'Falta indicar la Tarima')
insert MensajeLista (Mensaje,Descripcion) VALUES (13131,'Posici�n Real incorrecta')
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 13135)
  INSERT MensajeLista (Mensaje,Descripcion,Tipo) VALUES (13135, 'No tiene permisos para dar de alta tarimas', 'PRECAUCION')
GO
/* Bugs 4592,4602,4656,4818 */
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 13136)
  INSERT MensajeLista (Mensaje,Descripcion,Tipo) VALUES (13136, 'Acci�n incorrecta selecciono una tarima de la posici�n de surtido', 'PRECAUCION')
GO
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 13137)
  INSERT MensajeLista (Mensaje,Descripcion,Tipo) VALUES (13137, 'La Tarima que selecciono no corresponde a la tarima de domicilio', 'PRECAUCION')
GO
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 13137)
  INSERT MensajeLista (Mensaje,Descripcion,Tipo) VALUES (13137, 'La Tarima indicada debe ser de tipo Surtido', 'ERROR')
GO
insert MensajeLista (Mensaje,Descripcion) VALUES (13140,'No se pueden hacer o cancelar directamente las �rdenes (WMS)')
insert MensajeLista (Mensaje,Descripcion) VALUES (13150,'No cuadran las cantidades')
insert MensajeLista (Mensaje,Descripcion) VALUES (13160,'La tarima ya Est� dada de Alta')
insert MensajeLista (Mensaje,Descripcion) VALUES (13165,'La tarima ya Est� Capturada') --BUG4572
insert MensajeLista (Mensaje,Descripcion) VALUES (13170,'La tarima ya Est� dada de Baja')
insert MensajeLista (Mensaje,Descripcion) VALUES (13180,'Tarima Bloqueada')
insert MensajeLista (Mensaje,Descripcion) VALUES (13190,'No corresponde la posici�n de la Tarima')
insert MensajeLista (Mensaje,Descripcion) VALUES (13200,'Hay una Solicitud/Orden de acomodo pendiente para esa Tarima')
insert MensajeLista (Mensaje,Descripcion) VALUES (13210,'Hay una orden de acomodo diferente para esa Tarima')
insert MensajeLista (Mensaje,Descripcion) VALUES (13220,'Excede a la capacidad de la Posici�n Destino')
insert MensajeLista (Mensaje,Descripcion) VALUES (13230,'Contenido tarima inv�lido para la Posici�n Destino')
insert MensajeLista (Mensaje,Descripcion) VALUES (13240,'El surtido indicado excede a la cantidad pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (13250,'No existen tareas pendientes para el acomodador actual') --BUG16763

insert MensajeLista (Mensaje,Descripcion) VALUES (13510,'Falta especificar el Canal')

insert MensajeLista (Mensaje,Descripcion) VALUES (14010,'N�mero de actividad duplicado')
insert MensajeLista (Mensaje,Descripcion) VALUES (14020,'Tarea no especificada')
insert MensajeLista (Mensaje,Descripcion) VALUES (14030,'Actividad no especificada')
insert MensajeLista (Mensaje,Descripcion) VALUES (14040,'Falta indicar las actividades')
insert MensajeLista (Mensaje,Descripcion) VALUES (14050,'Actividad no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (14055,'Movimiento no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (14060,'Actividad concluida')
insert MensajeLista (Mensaje,Descripcion) VALUES (14070,'Actividad Cancelada o Eliminada')
insert MensajeLista (Mensaje,Descripcion) VALUES (14071,'La Actividad est� asignada a un Recurso')

--REQ16092
insert MensajeLista (Mensaje,Descripcion) VALUES (14080,'Falta especificar la Plantilla')
insert MensajeLista (Mensaje,Descripcion) VALUES (14081,'Falta especificar los Intereses del Contacto')
insert MensajeLista (Mensaje,Descripcion) VALUES (14082,'Falta Especificar la Propuesta')
insert MensajeLista (Mensaje,Descripcion) VALUES (14083,'La Actividad ya se ha enviado a Gesti�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (14084,'Falta especificar la plantilla de correo')
insert MensajeLista (Mensaje,Descripcion) VALUES (14085,'Plantilla de correo incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (14086,'Plantilla de correo inactiva')
insert MensajeLista (Mensaje,Descripcion) VALUES (14087,'Plantilla inactiva')

insert MensajeLista (Mensaje, Descripcion) VALUES (15010, 'Falta especificar el proyecto')
insert MensajeLista (Mensaje, Descripcion) VALUES (15011, 'Falta especificar el proyecto a reestructurar')
insert MensajeLista (Mensaje, Descripcion) VALUES (15012, 'El proyecto a reestructurar no existe')
insert MensajeLista (Mensaje, Descripcion) VALUES (15013, 'Proyecto incorrecto')
insert MensajeLista (Mensaje, Descripcion) VALUES (15014, 'Falta especificar el proyecto maestro')
INSERT MensajeLista (Mensaje, Descripcion) VALUES (15015, 'Proyecto reestructurado')
INSERT MensajeLista (Mensaje, Descripcion) VALUES (15020, 'No se puede asignar un Proyecto a un SubProyecto')
INSERT MensajeLista (Mensaje, Descripcion) VALUES (15050, 'Falta especificar el Riesgo')

-- 16000 AGD
INSERT MensajeLista (Mensaje, Descripcion) VALUES (17010, 'Tiene una solicitud de respaldo pendiente por recibir')
INSERT MensajeLista (Mensaje, Descripcion) VALUES (17020, 'Tiene una solicitud de TRCL pendiente por recibir')
INSERT MensajeLista (Mensaje, Descripcion) VALUES (17030, 'Est� bloqueada la opci�n de Recibir un respaldo en la Matriz')
INSERT MensajeLista (Mensaje, Descripcion) VALUES (17040, 'Conversaci�n incorrecta o Sucursal destino Incorrecta')
INSERT MensajeLista (Mensaje, Descripcion) VALUES (18010, 'Error - M�dulo Central')
INSERT MensajeLista (Mensaje, Descripcion) VALUES (18020, 'Error SQL - M�dulo Central')
INSERT MensajeLista (Mensaje, Descripcion,Tipo) VALUES (18030, 'Informaci�n - M�dulo Central', 'INFO')
INSERT MensajeLista (Mensaje, Descripcion,Tipo) VALUES (18040, 'Configuraci�n - M�dulo Central', 'CFG')
INSERT MensajeLista (Mensaje, Descripcion,Tipo) VALUES (18050, 'Precauci�n - M�dulo Central', 'PRECAUCION')
INSERT MensajeLista (Mensaje, Descripcion) VALUES (18060, 'Para "Actualizar Datos" en Tablas con IDENTITY tiene que eliminarlo usando el SQL Management Studio y deben ser Tablas donde no se inserten registros')

insert MensajeLista (Mensaje,Descripcion, IE) VALUES (20010,'Cantidad Incorrecta', 1)
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20011,'Cantidad Incorrecta (no cubre el m�nimo)', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20012,'No cubre el M�nimo', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20013,'Cantidad Incorrecta (excede el m�ximo)', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20014,'El importe del Movimiento excede al m�ximo autorizado', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (20015,'Falta indicar la cantidad')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20016,'El importe del movimiento excede al m�ximo no deducible autorizado', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20017,'El descuento global del movimiento excede al m�ximo autorizado', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20018,'El descuento lineal del movimiento excede al m�ximo autorizado', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20019,'El descuento total del movimiento excede al m�ximo autorizado', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (20020,'La cantidad indicada excede al disponible')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20021,'Falta indicar la cantidad a prorratea .<BR>Men� Edici�n','ERROR')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20022,'La Cantidad indicada excede al Disponible.<BR>Existe cantidad reservada. Es necesario desreservar para poder realizar esta acci�n','ERROR')
insert MensajeLista (Mensaje,Descripcion) VALUES (20025,'La cantidad indicada excede al Disponible <BR>(Se cancela la afectaci�n)')
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 20027)
	INSERT MensajeLista (Mensaje, Descripcion, Tipo)   
                  SELECT 20027, 'Es Necesario configurar la opci�n Generar Acomodos en Cross Docking en el Almac�n', 'PRECAUCION'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 20028)
	INSERT MensajeLista (Mensaje, Descripcion, Tipo)   
                  SELECT 20028, 'Es Necesario configurar la posici�n Cross Docking en el Almac�n', 'PRECAUCION'
GO

IF EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 20027)
	UPDATE MensajeLista 
	   SET Descripcion = 'Es Necesario configurar en el Almac�n,<BR>en la pesta�a WMS la opci�n: Generar Acomodos en Cross Docking' 
	 WHERE Mensaje     = 20027
GO
IF EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 20028)
	UPDATE MensajeLista 
	   SET Descripcion = 'Es Necesario configurar en el Almac�n,<BR>en la pesta�a WMS la posici�n Cross Docking' 
	 WHERE Mensaje     = 20028
GO
--Bug 7017
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 75531)
	INSERT MensajeLista (Mensaje, Descripcion, Tipo) VALUES (75531, 'Este Movimiento no se puede Cancelar;<BR>ya cuenta con un Acomodo', 'Info')

IF EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 75531) 
	UPDATE MensajeLista SET Descripcion = 'Este Movimiento no se puede Cancelar,<BR>ya cuenta con un Acomodo' WHERE Mensaje = 75531
GO
insert MensajeLista (Mensaje,Descripcion) VALUES (20030,'El n�mero de lote no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (20031,'No se permite asignar m�s de un Lote Fijo por Art�culo con %IVA y/o %IEPS diferentes')
insert MensajeLista (Mensaje,Descripcion) VALUES (20035,'El n�mero de VIN no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (20036,'VIN incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20037,'Situaci�n del VIN incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (20040,'No existe disponible esa opci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20041,'Falta definir el detalle de la opci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20042,'La opci�n indicada no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (20045,'Opci�n incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (20046,'Opci�n incorrecta, falta opci�n requerida')
insert MensajeLista (Mensaje,Descripcion) VALUES (20047,'Opci�n incorrecta, la opci�n indicada no es v�lida para el Art�culo')
insert MensajeLista (Mensaje,Descripcion) VALUES (20048,'Opci�n Incorrecta, n�mero incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20049,'Opci�n incorrecta, orden alfab�tico')
insert MensajeLista (Mensaje,Descripcion) VALUES (20050,'Falta indicar la Serie')
insert MensajeLista (Mensaje,Descripcion) VALUES (20051,'Falta indicar la Serie/Lote')
insert MensajeLista (Mensaje,Descripcion) VALUES (20052,'La Serie/Lote ya fue recibida o devuelta en otro Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (20053,'Opci�n bloqueada')
insert MensajeLista (Mensaje,Descripcion) VALUES (20054,'El N�mero de Serie se encuentra duplicado en este Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (20055,'Falta indicar el VIN')
insert MensajeLista (Mensaje,Descripcion) VALUES (20060,'Falta indicar el Lote')
insert MensajeLista (Mensaje,Descripcion) VALUES (20070,'Falta indicar la Opci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20072,'No debe indicar la l�nea cr�dito')
insert MensajeLista (Mensaje,Descripcion) VALUES (20073,'L�nea cr�dito inv�lida')
insert MensajeLista (Mensaje,Descripcion) VALUES (20074,'L�nea cr�dito fondeo inv�lida')
insert MensajeLista (Mensaje,Descripcion) VALUES (20075,'Falta indicar la l�nea cr�dito')
insert MensajeLista (Mensaje,Descripcion) VALUES (20076,'Este Movimiento requiere Art�culos Serie/Lote y que se produzcan')
insert MensajeLista (Mensaje,Descripcion) VALUES (20080,'El n�mero de Serie/Lote ya existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (20090,'El n�mero de Serie/Lote no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (20092,'El n�mero de Serie/Lote no existe en el Movimiento de aplicaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20093,'El n�mero de Serie/Lote no existe en la orden de producci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20095,'No debe indicar Series/Lotes')
insert MensajeLista (Mensaje,Descripcion) VALUES (20100,'Falta indicar el costo')
insert MensajeLista (Mensaje,Descripcion) VALUES (20101,'Costo incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20105,'No debe indicar el Costo')
insert MensajeLista (Mensaje,Descripcion) VALUES (20110,'Capas de costos incompletas')
insert MensajeLista (Mensaje,Descripcion) VALUES (20115,'No existe la capa de costos')
insert MensajeLista (Mensaje,Descripcion) VALUES (20120,'Almac�n destino incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20130,'Unidad incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (20140,'Las "Piezas" no llevan Costo')
insert MensajeLista (Mensaje,Descripcion) VALUES (20145,'Falta definir la unidad del Art�culo')
insert MensajeLista (Mensaje,Descripcion) VALUES (20150,'Falta indicar la unidad')
insert MensajeLista (Mensaje,Descripcion) VALUES (20160,'La cantidad a afectar excede a la cantidad pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (20165,'La cantidad a afectar excede a la cantidad reservada')
insert MensajeLista (Mensaje,Descripcion) VALUES (20167,'La cantidad a afectar excede a la cantidad ordenada')
insert MensajeLista (Mensaje,Descripcion) VALUES (20168,'La cantidad a afectar excede a la cantidad en proceso')
insert MensajeLista (Mensaje,Descripcion) VALUES (20170,'Falta indicar d�nde se aplica')
insert MensajeLista (Mensaje,Descripcion) VALUES (20175,'Faltan indicar los antecedentes')
insert MensajeLista (Mensaje,Descripcion) VALUES (20176,'No pueden manejar antecedentes m�ltiples con presupuesto (GRP)')
insert MensajeLista (Mensaje,Descripcion) VALUES (20180,'Aplicaci�n incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (20181,'Aplicaci�n incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (20182,'Aplicaci�n incorrecta. No se puede aplicar un anticipo a un gasto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20183,'Aplicaci�n incorrecta. No se pueden aplicar movimientos de diferentes ejercicios')
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES(20184, 'Aplicaci�n incorrecta. No se pueden aplicar m�ltiples anticipos Emida a un Cheque/Dep�sito', 'ERROR', 0) -- REQ12336
insert MensajeLista (Mensaje,Descripcion) VALUES (20185,'Aplicaci�n incorrecta. Diferentes unidades')
-- REQ PROYECTOS
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20186,'Plantilla incorrecta. Diferentes unidades', 'ERROR')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20187,'Proyecto incorrecto. Diferentes unidades', 'ERROR')
insert MensajeLista (Mensaje,Descripcion) VALUES (20190,'Aplicaci�n incorrecta. No corresponde la cuenta')
insert MensajeLista (Mensaje,Descripcion) VALUES (20191,'Aplicaci�n incorrecta. No corresponde el cliente o no est�n relacionados')
insert MensajeLista (Mensaje,Descripcion) VALUES (20192,'Aplicaci�n incorrecta. No corresponde el proveedor o no est�n relacionados')
insert MensajeLista (Mensaje,Descripcion) VALUES (20195,'Aplicaci�n incorrecta. Movimiento similar')
insert MensajeLista (Mensaje,Descripcion) VALUES (20196,'Aplicaci�n incorrecta. No corresponde la moneda')
insert MensajeLista (Mensaje,Descripcion) VALUES (20197,'Aplicaci�n incorrecta. Venta perdida')
insert MensajeLista (Mensaje,Descripcion) VALUES (20198,'Aplicaci�n incorrecta. �nicamente se pueden reasignar anticipos')
insert MensajeLista (Mensaje,Descripcion) VALUES (20199,'Aplicaci�n incorrecta. �nicamente se pueden reasignar cargos')
insert MensajeLista (Mensaje,Descripcion) VALUES (20200,'No existe disponible en esa presentaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20220,'Falta indicar la nueva presentaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20230,'No existe la nueva presentaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20235,'No se pueden hacer cambios de presentaci�n para ese tipo de Art�culo')
insert MensajeLista (Mensaje,Descripcion) VALUES (20236,'No se pueden hacer cambios de presentaci�n entre Art�culos de diferente tipo')
insert MensajeLista (Mensaje,Descripcion) VALUES (20240,'No corresponden las familias')
insert MensajeLista (Mensaje,Descripcion) VALUES (20250,'Nueva presentaci�n incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (20260,'La cantidad a afectar excede a la cantidad reservada')
insert MensajeLista (Mensaje,Descripcion) VALUES (20265,'La cantidad a afectar excede a la cantidad presupuestada')
insert MensajeLista (Mensaje,Descripcion) VALUES (20270,'El cliente no permite las ventas a consignaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20280,'Costo incorrecto de la nueva presentaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20290,'La cantidad a afectar excede a la cantidad pendiente original')
insert MensajeLista (Mensaje,Descripcion) VALUES (20300,'El cliente no permite pedidos parciales')
insert MensajeLista (Mensaje,Descripcion) VALUES (20305,'Precio incorrecto')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20310,'Precio Incorrecto (no cubre el m�nimo)', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (20320,'Falta indicar los n�meros de Serie/Lote')
insert MensajeLista (Mensaje,Descripcion) VALUES (20325,'Falta indicar los n�meros de VIN')
insert MensajeLista (Mensaje,Descripcion) VALUES (20330,'No corresponde la cantidad con los n�meros de Serie/Lote')
insert MensajeLista (Mensaje,Descripcion) VALUES (20332,'No corresponde la cantidad con los n�meros de Serie') --BUG5741
insert MensajeLista (Mensaje,Descripcion) VALUES (20335,'No corresponde el costo del VIN con sus componentes')
insert MensajeLista (Mensaje,Descripcion) VALUES (20340,'Error al transferir Serie/Lote')
insert MensajeLista (Mensaje,Descripcion) VALUES (20350,'No corresponde la cantidad del movimiento con la cantidad del origen')
insert MensajeLista (Mensaje,Descripcion) VALUES (20360,'El importe del movimiento excede al pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (20370,'Falta liquidar el Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (20380,'Origen incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20385,'El origen no est� pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (20390,'Falta indicar el almac�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20395,'Falta definir almac�n origen del almac�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20400,'Falta indicar el Art�culo')
insert MensajeLista (Mensaje,Descripcion) VALUES (20410,'No se puede facturar negativos')
insert MensajeLista (Mensaje,Descripcion) VALUES (20420,'No se puede hacer una salida garant�a con importe')
insert MensajeLista (Mensaje,Descripcion) VALUES (20440,'Almac�n incorrecto � garant�as')
insert MensajeLista (Mensaje,Descripcion) VALUES (20441,'Almac�n incorrecto - Activos Fijos')
insert MensajeLista (Mensaje,Descripcion) VALUES (20442,'Almac�n incorrecto - Normal')
insert MensajeLista (Mensaje,Descripcion) VALUES (20450,'Falta indicar el Art�culo del servicio')
insert MensajeLista (Mensaje,Descripcion) VALUES (20460,'Falta indicar la serie del servicio')
insert MensajeLista (Mensaje,Descripcion) VALUES (20470,'Falta configurar el Art�culo para contratos')
insert MensajeLista (Mensaje,Descripcion) VALUES (20480,'Falta indicar el concepto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20481,'No corresponde el concepto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20485,'El concepto indicado no es v�lido para este movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (20490,'Falta indicar las tareas a realizar')
insert MensajeLista (Mensaje,Descripcion) VALUES (20495,'No se puede concluir, tiene tareas pendientes')
insert MensajeLista (Mensaje,Descripcion) VALUES (20496,'No se puede concluir, tiene actividades pendientes')
insert MensajeLista (Mensaje,Descripcion) VALUES (20500,'Falta configurar')
insert MensajeLista (Mensaje,Descripcion) VALUES (20510,'La cantidad indicada excede a la existencia Serie/Lote')
insert MensajeLista (Mensaje,Descripcion) VALUES (20520,'No puede concluir una factura con pendientes')
insert MensajeLista (Mensaje,Descripcion) VALUES (20530,'No puede cancelar una factura con cantidad ordenada pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (20540,'No est� definida una conversi�n para la unidad indicada')
insert MensajeLista (Mensaje,Descripcion) VALUES (20550,'Cantidad incorrecta (decimales)')
insert MensajeLista (Mensaje,Descripcion) VALUES (20560,'No est� definida la unidad para el Art�culo indicado')
insert MensajeLista (Mensaje,Descripcion) VALUES (20570,'Falta Indicar la Cantidad en Unidad Inventario')
insert MensajeLista (Mensaje,Descripcion) VALUES (20575,'Cantidad en unidad inventario incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (20580,'No puede hacer una salida parcial (partidas)')
insert MensajeLista (Mensaje,Descripcion) VALUES (20600,'El costo indicado es menor al m�nimo aceptable')
insert MensajeLista (Mensaje,Descripcion) VALUES (20610,'El costo indicado es mayor al m�ximo aceptable')
insert MensajeLista (Mensaje,Descripcion) VALUES (20620,'Juego incompleto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20625,'Juego alterado')
insert MensajeLista (Mensaje,Descripcion) VALUES (20630,'Este Movimiento no puede ser Multi-VIN')
insert MensajeLista (Mensaje,Descripcion) VALUES (20640,'No se puede cambiar el almac�n cuando ya est� asignado')
insert MensajeLista (Mensaje,Descripcion) VALUES (20650,'Destino incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20660,'No puede hacer movimientos en el Almac�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20670,'El Art�culo a devolver no tiene antecedentes con el cliente')
insert MensajeLista (Mensaje,Descripcion) VALUES (20680,'No se pueden realizar Movimientos a cuentas tipo estructura')
insert MensajeLista (Mensaje,Descripcion) VALUES (20690,'No corresponde el VIN al Art�culo')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20700,'No est� correctamente definida la condici�n pago','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20701, 'No Esta Correctamente Definido el Almacen', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20702, 'No Esta Correctamente Definida la Forma de Envio', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20703, 'Es Necesario Especificar la Forma de Envio', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20704, 'Es Necesario Especificar el Concepto', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20705, 'Es Necesario Especificar una Condici�n de Pago Valida', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (20710,'El costo del lote es diferente')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20720,'No se pueden realizar "Notas/Facturas Mostrador/Compras a Consignaci�n" con costeo por Lotes/Series','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (20730,'Falta especificar la opci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20740,'El Art�culo especificado no tiene opciones')
insert MensajeLista (Mensaje,Descripcion) VALUES (20750,'No puede hacer movimientos con Art�culos tipo "F�rmula"')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20760,'No tiene acceso a realizar Movimientos de compra a este Art�culo','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20765,'No tiene acceso a realizar Movimientos con este centro de costos','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20766,'No tiene acceso a cancelar este Movimiento','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20770,'Falta indicar el almac�n para remisiones, en el tipo de Movimiento', 'CFG')
insert MensajeLista (Mensaje,Descripcion) VALUES (20780,'El Almac�n no pertenece a la Sucursal del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (20785,'El Almac�n no corresponde a la Sucursal en la que est� firmado')
insert MensajeLista (Mensaje,Descripcion) VALUES (20790,'El Almac�n destino no le pertenece a la Sucursal del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (20800,'El Movimiento no se puede realizar en la misma Sucursal')
insert MensajeLista (Mensaje,Descripcion) VALUES (20810,'No se puede aplicar un gasto diverso (Compras), si el Art�culo no tiene existencias')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20820,'Falta indicar el almac�n recibo orden planeada en el Art�culo', 'CFG')
insert MensajeLista (Mensaje,Descripcion) VALUES (20830,'Almac�n incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20840,'Almac�n destino incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (20850,'No est� definida la relaci�n Almacenes en la ruta de distribuci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20851,'Relaci�n incorrecta entre Almacenes en la ruta de distribuci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (20855,'No est� definido el Almac�n ordenar (Planeaci�n) del Art�culo')
insert MensajeLista (Mensaje,Descripcion) VALUES (20860,'No est� habilitada la venta Multi-Almacenes')
insert MensajeLista (Mensaje,Descripcion) VALUES (20870,'Este movimiento no debe tener impuestos')
insert MensajeLista (Mensaje,Descripcion) VALUES (20871,'Este Movimiento no debe tener ISAN')
insert MensajeLista (Mensaje,Descripcion) VALUES (20880,'Aplicaci�n incorrecta. No corresponde con la condici�n "cobrar pedido"')
insert MensajeLista (Mensaje,Descripcion) VALUES (20890,'Falta indicar la forma env�o')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20900,'El importe indicado excede al disponible', 'AUTORIZACION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20901,'El importe indicado excede al disponible con gastos','AUTORIZACION')
insert MensajeLista (Mensaje,Descripcion) VALUES (20902,'El importe indicado excede al disponible')
insert MensajeLista (Mensaje,Descripcion) VALUES (20905,'El importe indicado excede al m�ximo')
insert MensajeLista (Mensaje,Descripcion) VALUES (20910,'Falta indicar la referencia')
insert MensajeLista (Mensaje,Descripcion, IE) VALUES (20915,'Referencia inv�lida', 1)
insert MensajeLista (Mensaje,Descripcion) VALUES (20916,'Referencia incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (20917,'Esta referencia ya existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (20919,'Falta indicar el montacargas')
insert MensajeLista (Mensaje,Descripcion) VALUES (20920,'Falta indicar la rama')

--REQ12615 WMS
insert MensajeLista (Mensaje,Descripcion) VALUES (20921,'No se puede generar el surtido. Es necesario surtir el Domicilio')
insert MensajeLista (Mensaje,Descripcion) VALUES (20922,'La posici�n origen no es un tipo v�lido (Recibo)')
insert MensajeLista (Mensaje,Descripcion) VALUES (20923,'No se puede afectar hay movimientos pendientes para la posici�n Domicilio')
insert MensajeLista (Mensaje,Descripcion) VALUES (20924,'La posici�n origen no es un tipo v�lido (Domicilio, Ubicaci�n)')
insert MensajeLista (Mensaje,Descripcion) VALUES (20925,'La posici�n destino no es un tipo v�lido (Domicilio, Ubicaci�n)')
insert MensajeLista (Mensaje,Descripcion) VALUES (20926,'No se permiten reacomodos de Domicilio a Domicilio')
insert MensajeLista (Mensaje,Descripcion) VALUES (20927,'La posici�n destino no puede tener un Art�culo asignado')
insert MensajeLista (Mensaje,Descripcion) VALUES (20928,'La zona del Art�culo no corresponde con la zona de la posici�n destino')
insert MensajeLista (Mensaje,Descripcion) VALUES (20929,'La posici�n destino tiene Movimientos pendientes')
insert MensajeLista (Mensaje,Descripcion) VALUES (20930,'Falta Indicar el agente')
insert MensajeLista (Mensaje,Descripcion) VALUES (20931,'Falta indicar el acomodador')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (20932,'El peso de la tarima supera al Montacarga')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (20941,'El peso de la tarima supera la posici�n del Almac�n')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (20942,'El volumen de la tarima supera la posici�n del Almac�n') --BUG3628
INSERT MensajeLista (Mensaje,Descripcion) VALUES (20943,'Se super� el Peso M�ximo de la posici�n destino del Almac�n') --BUG3628
INSERT MensajeLista (Mensaje,Descripcion) VALUES (20944,'Se super� el Volumen M�ximo de la posici�n destino del Almac�n') --BUG3628
INSERT MensajeLista (Mensaje,Descripcion) VALUES (20945,'Flujo Incorrecto para la Zona del Agente') --BUG3693
INSERT MensajeLista (Mensaje,Descripcion) VALUES (20946,'Flujo Incorrecto del Agente') --BUG3724
INSERT MensajeLista (Mensaje,Descripcion) VALUES (20947,'A�n tiene Surtidos Tr�nsitos pendientes por Procesar. Vuelva a Cerrar Tarima') --BUG4572
INSERT MensajeLista (Mensaje,Descripcion) VALUES (20948,'El montacargas no existe') --UserStory4436


INSERT MensajeLista (Mensaje,Descripcion) VALUES (20933,'El acomodador tiene otros Movimientos pendientes')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (20934,'Zona incorrecta para el agente')
insert MensajeLista (Mensaje,Descripcion) VALUES (20935,'Falta especificar el agente del acreedor')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (20936,'El n�mero de serie no puede ser mayor a 1')
insert MensajeLista (Mensaje,Descripcion) VALUES (20937,'El Almac�n no permite WMS')
insert MensajeLista (Mensaje,Descripcion) VALUES (20938,'No se puede reacomodar esta tarima porque �sta ya est� en proceso')
insert MensajeLista (Mensaje,Descripcion) VALUES (20939,'Existen movimientos por procesar. No se puede concluir')

insert MensajeLista (Mensaje,Descripcion) VALUES (20940,'En necesario darlo de alta como Acreedor')
insert MensajeLista (Mensaje,Descripcion) VALUES (20949,'La posici�n destino no es un tipo v�lido (Domicilio)')

insert MensajeLista (Mensaje,Descripcion) VALUES (20950,'En necesario darlo de alta como personal')
insert MensajeLista (Mensaje,Descripcion) VALUES (20960,'En necesario configurar el concepto del Art�culo')
insert MensajeLista (Mensaje,Descripcion) VALUES (20970,'No se pueden manejar transferencias largas con BackOrders')
insert MensajeLista (Mensaje,Descripcion) VALUES (20975,'No se puede hacer movimientos de BackOrders con Art�culos tipo servicio')
insert MensajeLista (Mensaje,Descripcion) VALUES (20980,'No se puede modificar el costo promedio con Art�culos reservados')
insert MensajeLista (Mensaje,Descripcion) VALUES (20990,'Los rangos no coinciden')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20995,'No tiene acceso a cancelar facturas extempor�neas','PRECAUCION')
-- REQ PROYECTOS
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20996, 'Falta indicar la Fase para la Actividad', 'ERROR')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (20997, 'Fase no tiene Actividades', 'ERROR')

insert MensajeLista (Mensaje,Descripcion) VALUES (21010,'El saldo en caja es inferior al l�mite')
insert MensajeLista (Mensaje,Descripcion) VALUES (21020,'El saldo en caja es superior al l�mite')

insert MensajeLista (Mensaje,Descripcion) VALUES (22010,'Error al Cerrar el D�a<BR><BR>Tiene Cajas Abiertas')
insert MensajeLista (Mensaje,Descripcion) VALUES (22020,'Error al Cerrar el D�a<BR><BR>Tiene movimientos pendientes por procesar en la sucursal')

insert MensajeLista (Mensaje,Descripcion) VALUES (25010,'No puede hacer una orden producci�n con Art�culos que no se producen')
insert MensajeLista (Mensaje,Descripcion) VALUES (25020,'Excedi� el m�ximo de niveles o gener� un proceso c�clico')
insert MensajeLista (Mensaje,Descripcion) VALUES (25030,'Faltan datos por configurar en el ensamble')
insert MensajeLista (Mensaje,Descripcion) VALUES (25040,'Falta indicar el centro trabajo')
insert MensajeLista (Mensaje,Descripcion) VALUES (25050,'No puede generar una orden de producci�n con Art�culos que no se producen')
insert MensajeLista (Mensaje,Descripcion) VALUES (25060,'El costo de la entrada producci�n no puede ser diferente al costo en proceso')
insert MensajeLista (Mensaje,Descripcion) VALUES (25070,'Aplicaci�n incorrecta. No corresponde el Art�culo/Sustituto con el proceso pendiente')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (25080,'Primero hay que asignar el proceso','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (25090,'No existe la opci�n de producci�n','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (25120,'Es necesario definir la fecha requerida')
insert MensajeLista (Mensaje,Descripcion) VALUES (25121,'Fecha requerida incorrecta')
insert Mensajelista (Mensaje,Descripcion) Values(25124,'Es necesario especificar la caducidad m�nima del Art�culo (D�as) en su configuraci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (25125,'Es necesario especificar la fecha de caducidad')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (25126,'Fecha de caducidad incorrecta (no cubre el m�nimo)', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (25127,'Es necesario configurar el mapeo de Movimientos M�vil', 'ERROR')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (25130,'Es necesario definir la relaci�n entre el avance y el consumo','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (25140,'Es necesario definir el Almac�n Proceso en el centro de trabajo','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (25150,'El Movimiento relacionado al avance debe ser de tipo consumo','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (25160,'Es necesario definir la aplicaci�n o centro de trabajo en los consumos')
insert MensajeLista (Mensaje,Descripcion) VALUES (25170,'Falta definir el costo est�ndar del Art�culo')
insert MensajeLista (Mensaje,Descripcion) VALUES (25180,'No se pueden hacer avances incompletos')
insert MensajeLista (Mensaje,Descripcion) VALUES (25190,'Centro trabajo incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (25200,'No se puede hacer una asignaci�n al centro de trabajo indicado')
insert MensajeLista (Mensaje,Descripcion) VALUES (25210,'No se pueden hacer Salidas/Devoluciones al centro de trabajo indicado')
insert MensajeLista (Mensaje,Descripcion) VALUES (25220,'Falta indicar el Almac�n de consumo al centro de trabajo')
insert MensajeLista (Mensaje,Descripcion) VALUES (25230,'Falta indicar el n�mero Serie/Lote (producci�n)')
insert MensajeLista (Mensaje,Descripcion) VALUES (25240,'El n�mero de lote (Producci�n) ya existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (25245,'Existe una orden pendiente con ese lote (Producci�n)')
insert MensajeLista (Mensaje,Descripcion) VALUES (25250,'El n�mero de lote (Producci�n) no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (25255,'El n�mero de lote (Producci�n) no existe o no est� pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (25256,'No se puede cancelar el consumo, el n�mero de lote (Producci�n) ya est� concluido')
insert MensajeLista (Mensaje,Descripcion) VALUES (25260,'El n�mero de lote (Producci�n) o el material no corresponde')
insert MensajeLista (Mensaje,Descripcion) VALUES (25270,'No se puede realizar el Avance/Entrada. No aplica')
insert MensajeLista (Mensaje,Descripcion) VALUES (25280,'Los Avances/Entradas producci�n se deben de aplicar a �rdenes trabajo')
insert MensajeLista (Mensaje,Descripcion) VALUES (25290,'No se puede concluir una entrada con avances pendientes')
insert MensajeLista (Mensaje,Descripcion) VALUES (25300,'Falta indicar la ruta producci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (25310,'Falta definir el uso del material')
insert MensajeLista (Mensaje,Descripcion) VALUES (25315,'Falta definir la cantidad a consumir del material')
insert MensajeLista (Mensaje,Descripcion) VALUES (25320,'Falta definir correctamente Ruta/Centro/Almac�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (25330,'Falta indicar el centro trabajo "Destino"')
insert MensajeLista (Mensaje,Descripcion) VALUES (25340,'El centro trabajo "Destino" no corresponde')
insert MensajeLista (Mensaje,Descripcion) VALUES (25350,'El centro trabajo no corresponde')
insert MensajeLista (Mensaje,Descripcion) VALUES (25355,'El centro trabajo no maquila')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (25360,'Los consumos material que no son de tipo salida deben ir en negativo', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (25370,'No se puede cancelar una Serie/Lote de Producci�n que tiene costos asignados','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (25380,'Es necesario configurar la acci�n al ordenar', 'CFG')
insert MensajeLista (Mensaje,Descripcion) VALUES (25390,'Falta indicar el tipo')
insert MensajeLista (Mensaje,Descripcion) VALUES (25400,'La orden Producci�n tiene consumos pendientes')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (25410,'No se puede afectar directamente', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (25415,'No puede facturar directamente', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (25420,'Error al afectar el tr�nsito')
insert MensajeLista (Mensaje,Descripcion) VALUES (25430,'No se puede cancelar. Ya fue sincronizado el tr�nsito')
insert MensajeLista (Mensaje,Descripcion) VALUES (25440,'No puede cancelar completamente la orden porque tiene consumos asignados')
insert MensajeLista (Mensaje,Descripcion) VALUES (25450,'El costo indicado es diferente del costo autorizado')
insert MensajeLista (Mensaje,Descripcion) VALUES (25460,'No puede agregar Art�culos al Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (25470,'Factor incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (25480,'Falta indicar el establecimiento')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (25481,'Falta indicar el punto emisi�n')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (25485,'Falta indicar el sustento comprobante')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (25486,'Falta indicar el tipo comprobante')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (25482,'Falta indicar el secuencial SRI')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (25483,'Falta indicar la autorizaci�n SRI  ')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (25484,'Falta indicar la fecha de vigencia')
insert MensajeLista (Mensaje,Descripcion) VALUES (25490,'Falta indicar la tarjeta cr�dito')
insert MensajeLista (Mensaje,Descripcion) VALUES (25500,'No cuadran los importes')
insert MensajeLista (Mensaje,Descripcion) VALUES (25510,'No cuadran los importes del presupuesto espec�fico')
insert MensajeLista (Mensaje,Descripcion) VALUES (25520,'No cuadran los importes con la calendarizaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (25525,'No cuadran los importes con los Art�culos espec�ficos')
insert MensajeLista (Mensaje,Descripcion) VALUES (25530,'No puede exceder a la calendarizaci�n del flujo (control presupuestal)')
insert MensajeLista (Mensaje,Descripcion) VALUES (25540,'Los Traspasos deben Terminar en Tablas')
-- 8624
UPDATE MensajeLista SET Descripcion = 'El importe del movimiento debe ser cero (Ampliaciones - Reducciones)' WHERE Mensaje = 25540

insert MensajeLista (Mensaje,Descripcion) VALUES (25550,'Falta indicar Art�culos espec�ficos')
insert MensajeLista (Mensaje,Descripcion) VALUES (25560,'La clave presupuestal no corresponde')
insert MensajeLista (Mensaje,Descripcion) VALUES (25570,'El importe indicado excede al disponible')
insert MensajeLista (Mensaje,Descripcion) VALUES (25580,'No puede haber saldo negativo')
insert MensajeLista (Mensaje,Descripcion) VALUES (25590,'No puede haber saldo negativo (Art�culos Espec�ficos)')
insert MensajeLista (Mensaje,Descripcion) VALUES (25600,'No puede haber saldo negativo (Calendarizaci�n)')
insert MensajeLista (Mensaje,Descripcion) VALUES (25601,'No puede haber saldo negativo (Reservado Calendarizaci�n)')
insert MensajeLista (Mensaje,Descripcion) VALUES (25610,'El M�dulo de control presupuestal no soporta Movimientos de gastos con antecedentes m�ltiples')
insert MensajeLista (Mensaje,Descripcion) VALUES (25620,'No corresponde el importe con la clave presupuestal (Reservar Flujo)')
insert MensajeLista (Mensaje,Descripcion) VALUES (25630,'No corresponde el importe total (Reservar Flujo)')
insert MensajeLista (Mensaje,Descripcion) VALUES (25640,'Falta indicar la clave presupuestal')

insert MensajeLista (Mensaje,Descripcion) VALUES (26010,'Proyecto bloqueado')
insert MensajeLista (Mensaje,Descripcion) VALUES (26020,'Proyecto dado de baja')
insert MensajeLista (Mensaje,Descripcion) VALUES (26025,'El Proyecto ya existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (26030,'Ya existe otro avance pendiente de la referencia inicial')
insert MensajeLista (Mensaje,Descripcion) VALUES (26040,'El proveedor indicado no est� asignado al Art�culo/Opci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (26050,'El proveedor no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (26060,'El cliente no existe')
insert MensajeLista (Mensaje,Descripcion, IE) VALUES (26065,'El cliente no est� dado de alta', 1)
insert MensajeLista (Mensaje,Descripcion) VALUES (26070,'La empresa no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (26080,'El tipo de movimiento no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (26090,'El agente no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (26100,'Venta restringida (Fecha/Hora)')
insert MensajeLista (Mensaje,Descripcion) VALUES (26110,'Art�culo bloqueado')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (26120,'Hay otro servicio pendiente con el mismo identificador', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (26130,'Hay otro servicio pendiente con el mismo VIN', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (26140,'El Cliente tiene solicitudes de dep�sito pendientes', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (26150,'Predecesora incorrecta')

insert MensajeLista (Mensaje,Descripcion) VALUES (27010,'N�mero econ�mico duplicado en la Empresa')
insert MensajeLista (Mensaje,Descripcion) VALUES (27020,'No se puede aplicar un concepto indirecto al autob�s')
insert MensajeLista (Mensaje,Descripcion) VALUES (27030,'No se puede aplicar un concepto directo sin autob�s')

insert MensajeLista (Mensaje,Descripcion) VALUES (28010,'Falta indicar el proceso')
insert MensajeLista (Mensaje,Descripcion) VALUES (28020,'Falta indicar el contacto')
insert MensajeLista (Mensaje,Descripcion) VALUES (28030,'Campo / Valor duplicado')
insert MensajeLista (Mensaje,Descripcion) VALUES (28040,'Falta especificar la tabla de volumen')
insert MensajeLista (Mensaje,Descripcion) VALUES (28050,'Rango desde - hasta incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (28055,'Rango contactos desde - hasta incorrecto CFD')

insert MensajeLista (Mensaje,Descripcion) VALUES (30010,'Error al asignar el consecutivo. Probablemente ya existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (30012,'Error al asignar el consecutivo control de consecutivos')
insert MensajeLista (Mensaje,Descripcion) VALUES (30013,'Error al asignar el consecutivo CFD')
insert MensajeLista (Mensaje,Descripcion) VALUES (30015,'No puede eliminar un consecutivo asignado')
insert MensajeLista (Mensaje,Descripcion) VALUES (30019,'Error al asignar el consecutivo. Existe salto folio')
insert MensajeLista (Mensaje,Descripcion) VALUES (30020,'La fecha de vencimiento es incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (30030,'Condici�n incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (30040,'Moneda del Movimiento incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (30045,'No Corresponde la moneda del Movimiento con la forma pago')
insert MensajeLista (Mensaje,Descripcion) VALUES (30046,'No corresponde la moneda del movimiento con la l�nea de cr�dito')
insert MensajeLista (Mensaje,Descripcion) VALUES (30050,'Moneda de la cuenta incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (30060,'Error al aplicar al Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (30070,'El importe a aplicar es mayor al saldo del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (30071,'El inter�s ordinario a aplicar es mayor al del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (30072,'El inter�s moratorio a aplicar es mayor al del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (30075,'No existe informaci�n suficiente para realizar el c�lculo de la inflaci�n.')
insert MensajeLista (Mensaje,Descripcion) VALUES (30080,'La moneda del movimiento debe  ser igual a la moneda de la cuenta')
insert MensajeLista (Mensaje,Descripcion) VALUES (30081,'La moneda de la cuenta debe ser igual a la moneda de la cuenta destino')
insert MensajeLista (Mensaje,Descripcion) VALUES (30090,'El importe indicado excede al saldo a favor')
insert MensajeLista (Mensaje,Descripcion) VALUES (30095,'El importe indicado excede al saldo en redondeo')
insert MensajeLista (Mensaje,Descripcion) VALUES (30096,'El importe indicado excede al saldo de la tarjeta')
insert MensajeLista (Mensaje,Descripcion) VALUES (30097,'Tarjeta inv�lida')
insert MensajeLista (Mensaje,Descripcion) VALUES (30100,'Importe incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (30110,'Error al cancelar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30120,'No se encontr� el Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (30130,'Error al transferir la existencia a consignaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (30140,'Tipo de cambio incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (30150,'Tiene Movimientos. No  se puede eliminar ni renombrar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30151,'Tiene Movimientos. No se puede cancelar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30155,'Clave en uso. No se puede eliminar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30160,'Tiene descendientes. No se puede eliminar ni renombrar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30165,'Tiene descendientes. No se puede eliminar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30167,'Tiene antecedentes. No se puede eliminar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30170,'Falta indicar el Movimiento a aplicar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30180,'El importe del Movimiento es mayor al saldo del Movimiento a aplicar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30190,'El Movimiento a aplicar no existe o no est� pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (30191,'El Art�culo indicado no tiene pendientes')
insert MensajeLista (Mensaje,Descripcion) VALUES (30192,'El Movimiento a aplicar le pertenece a otra cuenta')
insert MensajeLista (Mensaje,Descripcion) VALUES (30193,'No puede recibir de m�s')
insert MensajeLista (Mensaje,Descripcion) VALUES (30195,'El Movimiento a asignar no est� pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (30200,'La moneda del Movimiento debe ser igual a la moneda de la cuenta bancaria')
insert MensajeLista (Mensaje,Descripcion) VALUES (30210,'El Movimiento a aplicar no corresponde')
insert MensajeLista (Mensaje,Descripcion) VALUES (30220,'Las transferencias deben ser en la misma moneda')
insert MensajeLista (Mensaje,Descripcion) VALUES (30230,'No corresponde la aplicaci�n con el importe del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (30240,'No corresponde el cargo por refinanciamiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (30250,'El cambio no puede exceder al importe')
insert MensajeLista (Mensaje,Descripcion) VALUES (30260,'El Movimiento no es v�lido para una cuenta bancaria')
insert MensajeLista (Mensaje,Descripcion) VALUES (30270,'El Movimiento no es v�lido para una caja')
insert MensajeLista (Mensaje,Descripcion) VALUES (30280,'La moneda del Movimiento difiere con la moneda del Movimiento a aplicar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30290,'La partida ya est� asignada')
insert MensajeLista (Mensaje,Descripcion) VALUES (30300,'No se puede aplicar el descuento pronto pago porque no cubre al saldo del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (30305,'No se puede aplicar el descuento pronto pago porque excede al saldo del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (30310,'No se puede aplicar el descuento pronto pago')
insert MensajeLista (Mensaje,Descripcion) VALUES (30320,'No se puede aplicar el descuento pronto pago cuando se tienen otros Movimientos vencidos')
insert MensajeLista (Mensaje,Descripcion) VALUES (30325,'En este Movimiento no se pueden aplicar Descuentos / Recargos')
insert MensajeLista (Mensaje,Descripcion) VALUES (30330,'Tiene Movimientos. No se puede eliminar')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (30340,'Existen partidas pendientes o no captur� el estado del embarque. No se puede concluir','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (30345,'Existen Movimientos gastos pendientes. No se puede concluir','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion)      VALUES (30350,'El importe a aplicar debe ser negativo')
insert MensajeLista (Mensaje,Descripcion)      VALUES (30351,'El importe a aplicar debe ser positivo')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (30360,'Los anticipos para este agente se deben de otorgar desde la N�mina','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (30370,'Existe una factura en borrador que incluye a la nota procesada','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (30380,'Los Movimientos posfechados no se pueden reaplicar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30390,'Los Movimientos posfechados se aplican uno a la vez')
insert MensajeLista (Mensaje,Descripcion) VALUES (30395,'Los Movimientos posfechados no se pueden aplicar parcialmente')
insert MensajeLista (Mensaje,Descripcion) VALUES (30400,'El importe indicado excede al saldo en anticipos facturados')
insert MensajeLista (Mensaje,Descripcion) VALUES (30405,'Los anticipos facturados no corresponden con la selecci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (30410,'No pueden cancelar anticipos facturados que ya fueron aplicados')
insert MensajeLista (Mensaje,Descripcion) VALUES (30411,'El movimiento no se puede cancelar. Ha sido reevaluado')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (30420,'No pueden manejar anticipos cuando gastos afecta a CxP', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (30430,'Cajero actual:')
insert MensajeLista (Mensaje,Descripcion, IE) VALUES (30435,'La Caja est� abierta con otro cajero', 1)
insert MensajeLista (Mensaje,Descripcion) VALUES (30440,'La Caja no est� abierta')
insert MensajeLista (Mensaje,Descripcion) VALUES (30450,'La caja no puede quedar con saldo despu�s del corte')
insert MensajeLista (Mensaje,Descripcion) VALUES (30455,'El importe excede al saldo de la caja')
insert MensajeLista (Mensaje,Descripcion, Tipo, IE) VALUES (30456,'El saldo de la caja excede al m�ximo', 'INFO', 1)
insert MensajeLista (Mensaje,Descripcion) VALUES (30460,'En la apertura la cuenta de destino es la caja a abrir')
insert MensajeLista (Mensaje,Descripcion) VALUES (30470,'No se puede cancelar despu�s del corte')
insert MensajeLista (Mensaje,Descripcion) VALUES (30480,'No se puede cancelar. Tiene Movimientos posteriores a la apertura')
insert MensajeLista (Mensaje,Descripcion) VALUES (30490,'Falta indicar el cajero')
insert MensajeLista (Mensaje,Descripcion) VALUES (30500,'No se puede reasignar a la misma cuenta')
insert MensajeLista (Mensaje,Descripcion) VALUES (30505,'Este Movimiento se debe realizar a otro Proveedor/Acreedor')
insert MensajeLista (Mensaje,Descripcion) VALUES (30506,'Este Movimiento se debe aplicar por el importe original del documento')
insert MensajeLista (Mensaje,Descripcion) VALUES (30510,'Falta indicar la ruta embarque')
insert MensajeLista (Mensaje,Descripcion) VALUES (30520,'Falta definir la tabla prorrateo para el concepto o no totaliza el 100%')
insert MensajeLista (Mensaje,Descripcion) VALUES (30530,'Falta especificar la forma de pago')
insert MensajeLista (Mensaje,Descripcion) VALUES (30540,'La caja no puede quedar con saldo en otras monedas despu�s del Corte.<BR> Necesita hacer cortes parciales')
insert MensajeLista (Mensaje,Descripcion) VALUES (30550,'Este movimiento no debe tener retenciones')
insert MensajeLista (Mensaje,Descripcion) VALUES (30560,'No se pueden realizar pagar�s a este proveedor')
insert MensajeLista (Mensaje,Descripcion) VALUES (30570,'Importe neto a pagar negativo')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (30580,'Forma de pago restringida', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (30590,'La forma de pago indicada no permite cambio')
insert MensajeLista (Mensaje,Descripcion) VALUES (30600,'No se permite la forma de pago indicada')
insert MensajeLista (Mensaje,Descripcion) VALUES (30610,'No puede realizar una compra prorrateada a diferentes Almacenes de la misma Sucursal')
insert MensajeLista (Mensaje,Descripcion) VALUES (30620,'No se encontr� ning�n pr�stamo pendiente en la fecha indicada')
insert MensajeLista (Mensaje,Descripcion) VALUES (30630,'No puede mezclar conceptos (Cuentas por Pagar)')
INSERT MensajeLista (Mensaje,Descripcion) VALUES (30632,'En necesario configurar el concepto de Cuentas por Pagar')
insert MensajeLista (Mensaje,Descripcion) VALUES (30670,'Falta indicar el acreedor del concepto')
insert MensajeLista (Mensaje,Descripcion) VALUES (30680,'La incidencia no tiene saldo o no est� pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (30690,'La incidencia est� cancelada')
insert MensajeLista (Mensaje,Descripcion) VALUES (30700,'Ausentismo duplicado')

insert MensajeLista (Mensaje,Descripcion) VALUES (31010,'Consecutivo inv�lido (Control Consecutivos)')
insert MensajeLista (Mensaje,Descripcion) VALUES (31020,'Consecutivo fuera de vigencia (Control Consecutivos)')
insert MensajeLista (Mensaje,Descripcion) VALUES (31030,'Consecutivo no existe (Control Consecutivos)')

insert MensajeLista (Mensaje,Descripcion) VALUES (35005,'Movimiento incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (35010,'Tipo de Movimiento incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (35020,'Falta indicar el beneficiario del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (35030,'Falta indicar el monto del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (35040,'Falta indicar el tipo cambio del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (35050,'Falta indicar el cobro')
insert MensajeLista (Mensaje,Descripcion) VALUES (35060,'Falta indicar el pago')

--BUG16817
insert MensajeLista (Mensaje,Descripcion) VALUES (35065,'Falta configurar el c�digo internacional de la moneda')

insert MensajeLista (Mensaje,Descripcion) VALUES (35070,'Los Cobros/Pagos deben ser en moneda nacional')
insert MensajeLista (Mensaje,Descripcion) VALUES (35080,'El tipo cambio indicado es menor al m�nimo aceptable')
insert MensajeLista (Mensaje,Descripcion) VALUES (35090,'El tipo cambio indicado es mayor al m�ximo aceptable')
insert MensajeLista (Mensaje,Descripcion) VALUES (35100,'El monto indicado difiere de la unidad m�nima')
insert MensajeLista (Mensaje,Descripcion) VALUES (35110,'El tipo cambio indicado es incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (35120,'No puede realizar Compra/Venta de moneda nacional')
insert MensajeLista (Mensaje,Descripcion) VALUES (35130,'La sustituci�n de cheques debe ser en la misma divisa')
insert MensajeLista (Mensaje,Descripcion) VALUES (35140,'La sustituci�n de cheques debe ser Compra/Venta')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (35150,'D�a Cerrado.<BR>No se puede afectar operaciones','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (35151,'D�a cerrado')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (35155,'D�a Bloqueado.<BR> No se pueden afectar operaciones','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (35160,'No se encontr� ning�n dep�sito anticipado en la cuenta bancaria <BR> por el Importe especificado')
insert MensajeLista (Mensaje,Descripcion) VALUES (35161,'No puede mezclar dep�sitos anticipados con otras formas de pago')
insert MensajeLista (Mensaje,Descripcion) VALUES (35162,'El importe excede al saldo del dep�sito anticipado referenciado')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (35165,'El dep�sito anticipado est� en otra cuenta bancaria','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion) VALUES (35170,'La moneda del beneficiario no corresponde con el Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (35180,'La forma de pago del beneficiario no corresponde con el Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (35190,'El importe excede al saldo del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (35200,'M�ximo 10 partidas por operaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (35210,'No se pueden registrar cobros y pagos en la misma operaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (35220,'No puede cerrar un d�a sin Movimientos')
insert MensajeLista (Mensaje,Descripcion) VALUES (35230,'No puede cerrar el d�a porque el "saldo a 48" horas difiere de la "posici�n 48 horas"')
insert MensajeLista (Mensaje,Descripcion) VALUES (35240,'Falta indicar el "a trav�s de"')
insert MensajeLista (Mensaje,Descripcion) VALUES (35250,'No puede cerrar con pendientes')
insert MensajeLista (Mensaje,Descripcion) VALUES (35260,'No puede cerrar el d�a. Tiene operaciones pendientes por liquidar')
insert MensajeLista (Mensaje,Descripcion) VALUES (35270,'El Movimiento excede al l�mite de remesas del cliente')
insert MensajeLista (Mensaje,Descripcion) VALUES (35280,'Este instrumento no permite este tipo de operaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (35290,'El tipo de operaci�n no corresponde con el uso del instrumento')
insert MensajeLista (Mensaje,Descripcion) VALUES (35300,'Las operaciones de ventanilla deben ser el mismo d�a')
insert MensajeLista (Mensaje,Descripcion) VALUES (35310,'No se pueden hacer Cheques/Dep�sitos directos')
insert MensajeLista (Mensaje,Descripcion) VALUES (35320,'No puede hacer devoluciones de pr�stamo cuando los pr�stamos generan Cxc')
insert MensajeLista (Mensaje,Descripcion) VALUES (35330,'No cuadran los impuestos arrastrados')
insert MensajeLista (Mensaje,Descripcion) VALUES (35340,'El movimiento debe terminar en ceros')
insert MensajeLista (Mensaje,Descripcion) VALUES (35350,'No se puede hacer inversi�n y retiro en la misma operaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (35360,'No puede cancelar el cheque porque tiene un cheque devuelto') --MEJORA6013

insert MensajeLista (Mensaje,Descripcion) VALUES (36010,'El vale ya fue emitido')
insert MensajeLista (Mensaje,Descripcion) VALUES (36011,'La tarjeta ya fue emitida')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36020,'El vale no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (36021,'La tarjeta no existe')		-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36030,'El vale no est� disponible')
insert MensajeLista (Mensaje,Descripcion) VALUES (36031,'La tarjeta no est� disponible')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36040,'El vale no est� disponible o en circulaci�n
')
insert MensajeLista (Mensaje,Descripcion) VALUES (36041,'La tarjeta no est� disponible o en circulaci�n')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36042,'El vale no est� en circulaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (36043,'La tarjeta no est� en circulaci�n')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36045,'El vale no est� en circulaci�n o no le pertenece a este cliente')
insert MensajeLista (Mensaje,Descripcion) VALUES (36050,'El vale est� cancelado')
insert MensajeLista (Mensaje,Descripcion) VALUES (36051,'La tarjeta est� cancelada')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36060,'El vale no est� bloqueado')
insert MensajeLista (Mensaje,Descripcion) VALUES (36061,'La tarjeta no est� bloqueada')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36070,'La moneda del Movimiento difiere con la moneda del tipo vale')
insert MensajeLista (Mensaje,Descripcion) VALUES (36080,'El vale no est� cobrado')
insert MensajeLista (Mensaje,Descripcion) VALUES (36090,'El vale no est� aplicado')
insert MensajeLista (Mensaje,Descripcion) VALUES (36091,'La tarjeta no est� aplicada')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36100,'No se pueden utilizar vales en este tipo de Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (36101,'No se pueden utilizar tarjetas en este tipo de Movimiento')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36110,'El vale ya fue cobrado')
insert MensajeLista (Mensaje,Descripcion) VALUES (36120,'El vale est� bloqueado')
insert MensajeLista (Mensaje,Descripcion) VALUES (36121,'La tarjeta est� bloqueada')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36130,'Este vale no se puede utilizar')
insert MensajeLista (Mensaje,Descripcion) VALUES (36131,'Esta tarjeta no se puede utilizar')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36140,'El vale ya fue aplicado o no corresponde')
insert MensajeLista (Mensaje,Descripcion) VALUES (36150,'El vale no est� vigente')
insert MensajeLista (Mensaje,Descripcion) VALUES (36151,'La tarjeta no est� vigente')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36160,'La moneda del vale no corresponde con la moneda del Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (36161,'La moneda de la tarjeta no corresponde con la moneda del Movimiento')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36170,'No corresponde el importe vales')
insert MensajeLista (Mensaje,Descripcion) VALUES (36171,'No corresponde el importe de las tarjetas')	-- ETO Tarjetas 9-Feb-2007
insert MensajeLista (Mensaje,Descripcion) VALUES (36180,'El vale no corresponde')

insert MensajeLista (Mensaje,Descripcion) VALUES (40001,'Falta indicar el tipo de contacto')
insert MensajeLista (Mensaje,Descripcion) VALUES (40005,'Falta indicar el prospecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (40006,'Falta configurar el aviso de Alta Express para prospectos')
insert MensajeLista (Mensaje,Descripcion) VALUES (40010,'Falta indicar el cliente')
insert MensajeLista (Mensaje,Descripcion) VALUES (40011,'Falta indicar el deudor')

-- BUG 17069
insert MensajeLista (Mensaje,Descripcion) VALUES (40019,'Falta indicar el Proveedor celular para Emida')

insert MensajeLista (Mensaje,Descripcion) VALUES (40020,'Falta indicar el Proveedor')
insert MensajeLista (Mensaje,Descripcion) VALUES (40021,'Falta indicar el Acreedor')
insert MensajeLista (Mensaje,Descripcion) VALUES (40025,'Falta indicar el Personal')
insert MensajeLista (Mensaje,Descripcion) VALUES (40030,'Falta indicar la Cuenta')
insert MensajeLista (Mensaje,Descripcion) VALUES (40035,'Falta indicar la Cuenta Presupuesto')
insert MensajeLista (Mensaje,Descripcion) VALUES (40036,'Cuenta Presupuesto incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (40040,'Falta indicar la cuenta destino')
insert MensajeLista (Mensaje,Descripcion) VALUES (40050,'Cuenta destino incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (40080,'Cuenta incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (40090,'Cuenta incorrecta. Un cheque devuelto no puede aplicarse a una caja')
insert MensajeLista (Mensaje,Descripcion) VALUES (40100,'Falta indicar la llave')
insert MensajeLista (Mensaje,Descripcion) VALUES (40110,'Llave duplicada')
insert MensajeLista (Mensaje,Descripcion) VALUES (40120,'Falta indicar la cuenta de dinero')
insert MensajeLista (Mensaje,Descripcion) VALUES (40130,'Transferencia incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (40140,'Falta indicar el importe')
insert MensajeLista (Mensaje,Descripcion) VALUES (40150,'No existe la cuenta de dinero')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (40160,'Es necesario definir la empresa a la que pertenece la cuenta de dinero','CFG')
insert MensajeLista (Mensaje,Descripcion) VALUES (40170,'La cuenta de dinero pertenece a otra Empresa')
insert MensajeLista (Mensaje,Descripcion) VALUES (40180,'No se puede realizar un cheque a diferentes contactos')
insert MensajeLista (Mensaje,Descripcion) VALUES (40190,'Falta indicar el campo presupuesto')
insert MensajeLista (Mensaje,Descripcion) VALUES (40200,'Falta indicar el tipo de tasa')
insert MensajeLista (Mensaje,Descripcion) VALUES (40210,'Falta indicar el tipo de amortizaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (40220,'Falta indicar la fecha del documento')
insert MensajeLista (Mensaje,Descripcion) VALUES (40230,'Falta indicar el vencimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (40240, 'No cuadra el peso total')
insert MensajeLista (Mensaje,Descripcion) VALUES (40250,'Falta indicar la plaza')
insert MensajeLista (Mensaje,Descripcion) VALUES (40260,'Falta indicar el puesto')
insert MensajeLista (Mensaje,Descripcion) VALUES (40270,'No puede autorizar una plaza con este estatus')
insert MensajeLista (Mensaje,Descripcion) VALUES (40280,'Para cancelar la autorizaci�n la plaza debe estar dada de alta')
insert MensajeLista (Mensaje,Descripcion) VALUES (40290,'Tiene plazas concluidas')
insert MensajeLista (Mensaje,Descripcion) VALUES (40300,'No corresponde el puesto')
insert MensajeLista (Mensaje,Descripcion) VALUES (40310,'La plaza ya est� requerida')
insert MensajeLista (Mensaje,Descripcion) VALUES (40320,'Este Movimiento no puede ser Multiplaza')
insert MensajeLista (Mensaje,Descripcion) VALUES (40330,'El peso indicado no da 100%')
insert MensajeLista (Mensaje,Descripcion) VALUES (40340,'No puede eliminar la competencia del origen')
insert MensajeLista (Mensaje,Descripcion) VALUES (40350,'No puede modificar la competencia del origen')
insert MensajeLista (Mensaje,Descripcion) VALUES (40360,'Falta calificar la competencia')

insert MensajeLista (Mensaje,Descripcion) VALUES (41010,'Falta indicar el supervisor')
insert MensajeLista (Mensaje,Descripcion) VALUES (41020,'Falta indicar la fecha de inicio')

insert MensajeLista (Mensaje,Descripcion) VALUES (42010,'El veh�culo se encuentra en tr�nsito')
insert MensajeLista (Mensaje,Descripcion) VALUES (42020,'El Movimiento ya fue asignado o embarcado')
insert MensajeLista (Mensaje,Descripcion) VALUES (42030,'El Movimiento no se ha embarcado')
insert MensajeLista (Mensaje,Descripcion) VALUES (42040,'No se puede embarcar')
insert MensajeLista (Mensaje,Descripcion, Tipo) VALUES (42050,'No puede cancelar un Movimiento parcialmente desembarcado.<BR> Para cancelar primero tiene que concluir el Movimiento', 'INFORMACION')

insert MensajeLista (Mensaje,Descripcion) VALUES (43010,'Falta indicar la plantilla')
insert MensajeLista (Mensaje,Descripcion) VALUES (43020,'Falta agregar contactos')

insert MensajeLista (Mensaje,Descripcion) VALUES (44010,'Los Activos Fijos deben ser Art�culos tipo serie')
insert MensajeLista (Mensaje,Descripcion) VALUES (44020,'El Activo Fijo ya existe o est� activo')
insert MensajeLista (Mensaje,Descripcion) VALUES (44030,'El Activo Fijo no existe o no est� activo')
insert MensajeLista (Mensaje,Descripcion) VALUES (44040,'El Activo Fijo no existe en el Almac�n indicado')
insert MensajeLista (Mensaje,Descripcion) VALUES (44050,'El Activo Fijo no est� en reparaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (44060,'El Activo Fijo no est� en mantenimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (44070,'Existe una P�liza vigente')
insert MensajeLista (Mensaje,Descripcion) VALUES (44080,'El Activo Fijo no tiene vida �til, no se puede depreciar')
insert MensajeLista (Mensaje,Descripcion) VALUES (44090,'No se puede depreciar ni reevaluar en diferentes monedas')
insert MensajeLista (Mensaje,Descripcion) VALUES (44100,'El Activo Fijo no se puede depreciar en este mes')
insert MensajeLista (Mensaje,Descripcion) VALUES (44110,'Falta indicar la categor�a de Activos Fijos del Art�culo')
insert MensajeLista (Mensaje,Descripcion) VALUES (44115,'Falta indicar la categor�a del Art�culo')
insert MensajeLista (Mensaje,Descripcion) VALUES (44120,'No coincide la fecha de emisi�n con la �ltima reevaluaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (44130,'El Activo Fijo ya est� asignado')
insert MensajeLista (Mensaje,Descripcion) VALUES (44140,'El Activo Fijo no est� asignado')
insert MensajeLista (Mensaje,Descripcion) VALUES (44150,'El Activo Fijo no est� asignado a mismo recurso')
insert MensajeLista (Mensaje,Descripcion) VALUES (44160,'Esta persona tiene Activos Fijos asignados')
insert MensajeLista (Mensaje,Descripcion) VALUES (44170,'Activo Fijo incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (44180,'No puede Comprar/Vender Activos Fijos de terceros')
insert MensajeLista (Mensaje,Descripcion) VALUES (44190,'No puede depreciar Activos Fijos de terceros')
insert MensajeLista (Mensaje,Descripcion) VALUES (44200,'Excedi� a los 50 ciclos. Probablemente tenga mal definida la estructura de la cuenta')

insert MensajeLista (Mensaje,Descripcion) VALUES (45010,'Fecha N�mina no corresponde con la fecha alta')
insert MensajeLista (Mensaje,Descripcion) VALUES (45020,'Fecha N�mina no corresponde con la fecha �ltimo pago')
insert MensajeLista (Mensaje,Descripcion) VALUES (45030,'Incidencia parcialmente procesada. No se puede cancelar')
insert MensajeLista (Mensaje,Descripcion) VALUES (45040,'Este Pa�s no tiene configurada una N�mina')
insert MensajeLista (Mensaje,Descripcion) VALUES (45050,'La persona no corresponde a la Empresa')
insert MensajeLista (Mensaje,Descripcion) VALUES (45060,'La Persona No Corresponde a la Sucursal') --BUG4572

insert MensajeLista (Mensaje,Descripcion) VALUES (46010,'Falta indicar el "Para"')
insert MensajeLista (Mensaje,Descripcion) VALUES (46020,'El Movimiento no tiene origen')
insert MensajeLista (Mensaje,Descripcion) VALUES (46030,'El Movimiento origen no est� pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (46040,'El Movimiento origen est� pendiente')
insert MensajeLista (Mensaje,Descripcion) VALUES (46050,'Falta indicar la lista de asistentes')
insert MensajeLista (Mensaje,Descripcion) VALUES (46060,'�nicamente puede modificar Movimientos pendientes')
insert MensajeLista (Mensaje,Descripcion) VALUES (46070,'Las modificaciones no se pueden cancelar')
insert MensajeLista (Mensaje,Descripcion) VALUES (46080,'Usted no puede responder a esta solicitud')
insert MensajeLista (Mensaje,Descripcion) VALUES (46085,'Usted ya respondi� previamente a esta solicitud')
insert MensajeLista (Mensaje,Descripcion) VALUES (46090,'No puede cancelar. Tiene submovimientos')
insert MensajeLista (Mensaje,Descripcion) VALUES (46100,'Falta especificar fechas')
insert MensajeLista (Mensaje,Descripcion) VALUES (46110,'Falta especificar el motivo')
insert MensajeLista (Mensaje,Descripcion) VALUES (46120,'No puede completar directamente el Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (46130,'Usted no puede autorizar este Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (46140,'Fin/Vencimiento fuera del origen')
insert MensajeLista (Mensaje,Descripcion) VALUES (46150,'El Movimiento no corresponde con la solicitud')
insert MensajeLista (Mensaje,Descripcion) VALUES (46160,'No puede cancelar un avance de un Movimiento con terminaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (46170,'No puede modificar una solicitud ya aceptada')
insert MensajeLista (Mensaje,Descripcion) VALUES (46180,'Solo puede indicar un "Para"')
insert MensajeLista (Mensaje,Descripcion) VALUES (46190,'No puede rechazar una orden')
insert MensajeLista (Mensaje,Descripcion) VALUES (46200,'No existen indicadores configurados para el Activo Fijo')
insert MensajeLista (Mensaje,Descripcion) VALUES (46210,'Falta indicar el campo "Lectura" en los indicadores')
insert MensajeLista (Mensaje,Descripcion) VALUES (46220,'Ya existen solicitudes de inspecci�n pendientes para el Activo Fijo')

insert MensajeLista (Mensaje,Descripcion) VALUES (50010,'La P�liza no cuadra')
insert MensajeLista (Mensaje,Descripcion) VALUES (50015,'La P�liza no cuadra con el registro')
insert MensajeLista (Mensaje,Descripcion) VALUES (50020,'P�liza con errores')
insert MensajeLista (Mensaje,Descripcion) VALUES (50030,'Falta indicar el Centro de Costos')
insert MensajeLista (Mensaje,Descripcion) VALUES (50040,'P�liza con error de IVA')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (50050,'La fecha est� fuera del ejercicio','PRECAUCION')

-- 9319
insert MensajeLista (Mensaje,Descripcion) VALUES (50052, 'La fecha de emisi�n es menor a la fecha del Movimiento al que aplica')
insert MensajeLista (Mensaje,Descripcion) VALUES (50054, 'El periodo y ejercicio de emisi�n son menores al periodo y ejercicio del Movimiento al que aplican')
insert MensajeLista (Mensaje,Descripcion) VALUES (50056, 'El periodo y ejercicio de emisi�n son distintos al periodo y ejercicio del Movimiento al que aplican')

insert MensajeLista (Mensaje,Descripcion) VALUES (50060,'No se pueden afectar Movimientos a cuentas acumulativas')
insert MensajeLista (Mensaje,Descripcion) VALUES (50070,'Probablemente alguna de las cuentas indicadas en la P�liza no existe o se encuentra bloqueada')
insert MensajeLista (Mensaje,Descripcion) VALUES (50080,'El Centro de Costos no corresponde')
insert MensajeLista (Mensaje,Descripcion) VALUES (50090,'El Centro de Costos no existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (50100,'La P�liza ya fue generada')
insert MensajeLista (Mensaje,Descripcion) VALUES (50110,'Necesita dar de alta la Cuenta del tipo contacto')
insert MensajeLista (Mensaje,Descripcion) VALUES (50120,'En este Movimiento �nicamente puede Asignar/Desasignar el presupuesto')
insert MensajeLista (Mensaje,Descripcion) VALUES (50130,'No se pueden manejar presupuestos negativos')
--DSG
insert MensajeLista (Mensaje,Descripcion) VALUES (51135, 'El concepto bancario no puede ser cargo y abono al mismo tiempo')
insert MensajeLista (Mensaje,Descripcion) VALUES (50140,'No se pueden manejar presupuestos reservados negativos')
insert MensajeLista (Mensaje,Descripcion) VALUES (50142,'No se pueden manejar presupuestos comprometidos negativos')
insert MensajeLista (Mensaje,Descripcion) VALUES (50144,'No se pueden manejar presupuestos devengados negativos')
insert MensajeLista (Mensaje,Descripcion) VALUES (50150,'No se pueden manejar presupuestos ejercidos negativos')
insert MensajeLista (Mensaje,Descripcion) VALUES (50160,'No puede exceder al presupuesto asignado')
insert MensajeLista (Mensaje,Descripcion) VALUES (50170,'No se pueden ejercer meses futuros')
insert MensajeLista (Mensaje,Descripcion) VALUES (50180,'La participaci�n total de los socios debe ser igual al 100%')

insert MensajeLista (Mensaje,Descripcion) VALUES (50510,'No corresponde el debe fiscal')
insert MensajeLista (Mensaje,Descripcion) VALUES (50520,'No corresponde el haber fiscal')

insert MensajeLista (Mensaje,Descripcion) VALUES (51010,'Fecha fuera de rango')
insert MensajeLista (Mensaje,Descripcion) VALUES (51020,'La Conciliaci�n no cuadra')
insert MensajeLista (Mensaje,Descripcion) VALUES (51025,'La Conciliaci�n no cuadra despu�s de afectar (Tesorer�a)')
insert MensajeLista (Mensaje,Descripcion) VALUES (51026,'La Conciliaci�n no cuadra despu�s de afectar (Contabilidad)')
insert MensajeLista (Mensaje,Descripcion) VALUES (51030,'Falta especificar el acreedor de la cuenta de dinero')
insert MensajeLista (Mensaje,Descripcion) VALUES (51035,'Falta especificar la cuenta contable de la cuenta de dinero')
insert MensajeLista (Mensaje,Descripcion) VALUES (51040,'Falta especificar el concepto del Gasto')
insert MensajeLista (Mensaje,Descripcion) VALUES (51041,'La suma de las retenciones e impuestos no puede ser mayor al importe')
insert MensajeLista (Mensaje,Descripcion) VALUES (51050,'Falta especificar el tipo Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (51060,'Falta identificar el Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (51070,'Falta identificar la P�liza')
insert MensajeLista (Mensaje,Descripcion) VALUES (51080,'No corresponde el saldo anterior con el saldo conciliado (Tesorer�a)')
insert MensajeLista (Mensaje,Descripcion) VALUES (51085,'No corresponde el saldo anterior con el saldo conciliado (Contabilidad)')
insert MensajeLista (Mensaje,Descripcion) VALUES (51090,'La cuenta ya fue conciliada en ese periodo')
insert MensajeLista (Mensaje,Descripcion) VALUES (51095,'No se puede brincar fechas')
insert MensajeLista (Mensaje,Descripcion) VALUES (51100,'No corresponde el auxiliar con la Conciliaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (51110,'No corresponde la P�liza con la Conciliaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (51120,'No corresponde el importe auxiliar con la Conciliaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (51130,'No corresponde el importe P�liza con la Conciliaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (51140,'Error al generar el auxiliar (Dep�sito Anticipado)')
insert MensajeLista (Mensaje,Descripcion) VALUES (51150,'Falta generar la P�liza (Dep�sito Anticipado). Es necesario configurar Contabilidad Autom�tica')
insert MensajeLista (Mensaje,Descripcion) VALUES (51160,'No corresponde el Gasto IVA')
insert MensajeLista (Mensaje,Descripcion) VALUES (51170,'No se gener� el Movimiento concluido en Tesorer�a. Puede ser por la forma de pago')
insert MensajeLista (Mensaje,Descripcion) VALUES (51180,'No corresponde la compensaci�n manual con el Movimiento')

insert MensajeLista (Mensaje,Descripcion) VALUES (52010,'Falta indicar la lista a modificar')
insert MensajeLista (Mensaje,Descripcion) VALUES (52020,'Falta indicar la lista Precios / Costos')

insert MensajeLista (Mensaje,Descripcion) VALUES (53010,'Falta indicar el tipo de forma')
insert MensajeLista (Mensaje,Descripcion) VALUES (53020,'Falta indicar a donde aplica')
insert MensajeLista (Mensaje,Descripcion) VALUES (53030,'Falta indicar la clave (aplica)')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (53040,'Falta configurar Consecutivos Generales','CFG')
insert MensajeLista (Mensaje,Descripcion) VALUES (53050,'Falta indicar la direcci�n de correo electr�nico')

insert MensajeLista (Mensaje,Descripcion) VALUES (53060,'Falta configurar el perfil de correo electr�nico') --AUTORIZACIONREMOTA
insert MensajeLista (Mensaje,Descripcion) VALUES (53070,'Falta configurar la ruta para almacenar el correo recibido') --AUTORIZACIONREMOTA
insert MensajeLista (Mensaje,Descripcion) VALUES (53080,'Falta configurar la ruta del componente POP3') --AUTORIZACIONREMOTA
insert MensajeLista (Mensaje,Descripcion) VALUES (53090,'Usuario no autorizado para avanzar la situaci�n del movimiento') --AUTORIZACIONREMOTA
insert MensajeLista (Mensaje,Descripcion) VALUES (53100,'La situaci�n actual no se puede avanzar') --AUTORIZACIONREMOTA
insert MensajeLista (Mensaje,Descripcion) VALUES (53105,'Cadena de autorizaci�n inv�lida') --AUTORIZACIONREMOTA

insert MensajeLista (Mensaje,Descripcion) VALUES (53110,'Falta indicar el cat�logo a afectar')
insert MensajeLista (Mensaje,Descripcion) VALUES (53120,'Falta Indicar la clave a afectar')


insert MensajeLista (Mensaje,Descripcion) VALUES (55010,'La persona ya est� dada de Alta')
insert MensajeLista (Mensaje,Descripcion) VALUES (55020,'La persona no est� dada de Alta')
insert MensajeLista (Mensaje,Descripcion) VALUES (55030,'La moneda del Movimiento difiere con la moneda del empleado')
insert MensajeLista (Mensaje,Descripcion) VALUES (55040,'El sueldo indicado no es correcto')
insert MensajeLista (Mensaje,Descripcion) VALUES (55050,'El importe indicado no es correcto')
insert MensajeLista (Mensaje,Descripcion) VALUES (55060,'La cantidad indicada no es correcta')
insert MensajeLista (Mensaje,Descripcion) VALUES (55070,'El porcentaje indicado no es correcto')
insert MensajeLista (Mensaje,Descripcion) VALUES (55080,'El monto indicado no es correcto')
insert MensajeLista (Mensaje,Descripcion) VALUES (55090,'Las fechas indicadas no son correctas')
insert MensajeLista (Mensaje,Descripcion) VALUES (55100,'Falta indicar la persona')
insert MensajeLista (Mensaje,Descripcion) VALUES (55105,'Recurso incorrecto')
insert MensajeLista (Mensaje,Descripcion) VALUES (55110,'Falta indicar el acreedor')
insert MensajeLista (Mensaje,Descripcion) VALUES (55115,'Falta indicar el cliente')
insert MensajeLista (Mensaje,Descripcion) VALUES (55120,'Falta indicar la cuenta de dinero')
insert MensajeLista (Mensaje,Descripcion) VALUES (55130,'Falta indicar el Movimiento')
insert MensajeLista (Mensaje,Descripcion) VALUES (55140,'Falta indicar el tipo de periodo')
insert MensajeLista (Mensaje,Descripcion) VALUES (55150,'El tipo de periodo no corresponde')
insert MensajeLista (Mensaje,Descripcion) VALUES (55160,'El periodo ya fue pagado')
insert MensajeLista (Mensaje,Descripcion) VALUES (55165,'El periodo no corresponde')
insert MensajeLista (Mensaje,Descripcion) VALUES (55200,'Entrada incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (55210,'Salida incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (55220,'Falta indicar el registro')
insert MensajeLista (Mensaje,Descripcion) VALUES (55230,'Falta indicar la hora')
insert MensajeLista (Mensaje,Descripcion) VALUES (55240,'Falta indicar la fecha')
insert MensajeLista (Mensaje,Descripcion) VALUES (55245,'Falta indicar las fechas')
insert MensajeLista (Mensaje,Descripcion) VALUES (55250,'La persona no tiene control de asistencia')
insert MensajeLista (Mensaje,Descripcion) VALUES (55260,'Falta generar la jornada de trabajo')
insert MensajeLista (Mensaje,Descripcion) VALUES (55270,'Registro repetido')
insert MensajeLista (Mensaje,Descripcion) VALUES (55280,'La lista de ausentes ya fue utilizada o no corresponden las fechas')
insert MensajeLista (Mensaje,Descripcion) VALUES (55290,'Fecha de corte incorrecta')
insert MensajeLista (Mensaje,Descripcion) VALUES (55300,'No puede cancelar un corte intermedio')
insert MensajeLista (Mensaje,Descripcion) VALUES (55310,'El sueldo indicado es menor al sueldo m�nimo de la categor�a')
insert MensajeLista (Mensaje,Descripcion) VALUES (55320,'El sueldo indicado excede al sueldo m�ximo de la categor�a')
insert MensajeLista (Mensaje,Descripcion) VALUES (55330,'El registro ya existe')
insert MensajeLista (Mensaje,Descripcion) VALUES (55340,'Excede las plazas disponibles')
insert MensajeLista (Mensaje,Descripcion) VALUES (55350,'No est�n definidas las plazas Departamento/Puesto')
insert MensajeLista (Mensaje,Descripcion) VALUES (55360,'Falta indicar la evaluaci�n')
insert MensajeLista (Mensaje,Descripcion) VALUES (55370,'�nicamente se pueden referenciar Deducciones/Percepciones')
insert MensajeLista (Mensaje,Descripcion) VALUES (55380,'El importe referenciado excede al saldo')
insert MensajeLista (Mensaje,Descripcion) VALUES (55390,'Excede al de m�ximo de cortes de cajas centrales por d�a')
insert MensajeLista (Mensaje,Descripcion) VALUES (55400,'Falta indicar la plaza')
insert MensajeLista (Mensaje,Descripcion) VALUES (55410,'La plaza se encuentra ocupada por otra persona')
insert MensajeLista (Mensaje,Descripcion) VALUES (55420,'No corresponde el Puesto/Departamento indicado con el que indica la plaza')

insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60010,'No hay nada que afectar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60015,'No hay nada que cancelar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60020,'Falta indicar el Movimiento a generar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60030,'Uso incorrecto del par�metro','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60040,'Afectaci�n incorrecta','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60050,'Este Movimiento ya no se puede cancelar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60060,'El Movimiento tiene aplicaciones.<BR>No se puede cancelar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60065,'No se encontr� el Movimiento Posfechado en Tesorer�a','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60070,'El origen del Movimiento es de otro M�dulo.<BR>No se puede cancelar directamente','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60071,'El origen del Movimiento es de otro M�dulo.<BR>No se puede cancelar directamente','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60072,'El origen del Movimiento es de otro Movimiento.<BR>No se puede cancelar directamente','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60075,'El origen del Movimiento es de otro M�dulo. <BR>No se puede desafectar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60080,'Parcialmente pendiente.<BR>No se puede cancelar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60081,'Parcialmente pendiente.<BR>No se puede Cancelar/Desafectar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60090,'El Movimiento ya fue afectado por otro usuario','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60100,'Los auxiliares del Movimiento no existen o no corresponden.<BR>No se puede desafectar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60110,'Periodo cerrado.<BR>No se puede afectar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60120,'Movimiento deshabilitado temporalmente','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60130,'El Movimiento va a sobregirar la cuenta','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60140,'La fecha de emisi�n no corresponde con la fecha de registro','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60150,'Las series de consecutivos no funcionan en este M�dulo','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60160,'El Movimiento no se puede utilizar directamente','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60170,'Fecha incorrecta','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60175,'UEN cerrada','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60180,'El Movimiento no se puede cancelar directamente','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60190,'Necesita cancelar en el orden correcto','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60200,'No se puede desafectar un Movimiento ya contabilizado','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60201,'No se puede desafectar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60202,'No se puede desafectar (Registro)','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60210,'Excede el l�mite de renglones v�lido','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60220,'No se encontr� el ID del Movimiento','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion, IE)  VALUES (60230,'Contrase�a incorrecta', 1)
insert MensajeLista (Mensaje,Descripcion)      VALUES (60231,'Contrase�a incorrecta. Tama�o m�nimo')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60232,'Contrase�a incorrecta. Requiere n�meros')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60233,'Contrase�a incorrecta. Requiere alfanum�ricos')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60240,'Este Movimiento no se puede cancelar parcialmente','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60250,'En proceso.<BR>No se puede cancelar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60260,'Valor incorrecto','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60270,'El Movimiento contiene renglones autogenerados, No se puede afectar','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60280,'Este Movimiento ya fue cancelado en otro mes','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60290,'No se pueden desafectar Movimientos en las Sucursales remotas')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60300,'El seguimiento de este Movimiento no le pertenece a esta Sucursal')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60310,'Los Maestros no se pueden editar en las Sucursales')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60320,'�nicamente en la Matriz se puede asignar este Movimiento a otra Sucursal')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60330,'Este Movimiento no se puede asignar a una Sucursal remota')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60340,'Los traspasos se efect�an entre Sucursales')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60350,'El seguimiento del Movimiento no ser� en esta Sucursal, requiere un Almac�n de la Matriz')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60360,'Para transferir entre Sucursales se efect�an los traspasos')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60370,'Los Movimientos remotos se tienen que asignar a "UENs Remotas"')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60380,'No se puede aplicar el saldo a favor en un cobro remoto')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60390,'Todos los Movimientos a aplicar tienen que ser remotos')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (60400,'No se puede desafectar un Movimiento con avances','PRECAUCION')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60410,'Falta indicar la Sucursal principal')
insert MensajeLista (Mensaje,Descripcion)      VALUES (60420,'�nicamente se pueden generar solicitudes a Tesorer�a desde Cxc o Cxp')
Insert MensajeLista (Mensaje,Descripcion)      VALUES (60440,'Existen Movimientos por confirmar, es necesario afectar primero')
Insert MensajeLista (Mensaje,Descripcion)      VALUES (60450,'Ya existe un Movimiento de declaraci�n para este periodo')

insert MensajeLista (Mensaje,Descripcion)      VALUES (61010,'Error al insertar')
insert MensajeLista (Mensaje,Descripcion)      VALUES (61020,'Error al Eliminar')

insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (65010,'El Movimiento excede al l�mite de cr�dito del Cliente','AUTORIZACION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (65015,'El Movimiento excede al l�mite del Acreedor', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (65020,'La condici�n del Movimiento difiere con la pol�tica de cr�dito del Cliente','AUTORIZACION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (65030,'El Cliente est� bloqueado','AUTORIZACION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (65032,'El Proveedor est� bloqueado','AUTORIZACION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (65035,'La Sucursal est� bloqueada','AUTORIZACION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (65040,'El Cliente est� bloqueado.<BR>Tiene Movimientos vencidos (Moratorios)','AUTORIZACION')
insert MensajeLista (Mensaje,Descripcion)      VALUES (65050,'El Art�culo indicado est� bloqueado para este Cliente')
insert MensajeLista (Mensaje,Descripcion)      VALUES (65060,'El Movimiento excede al l�mite venta a nivel Sucursal')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (65070,'No tiene autorizaci�n para realizar este Movimiento con cantidades negativas','AUTORIZACION')
insert MensajeLista (Mensaje,Descripcion)      VALUES (65090,'No puede aplicar descuentos pronto pago.<BR>Tiene Movimientos vencidos (Moratorios)')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (65100,'El Movimiento excede al l�mite operaci�n del Cliente','AUTORIZACION')

insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70010,'SeriesLotesAutoCampo','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70020,'M�dulo Incorrecto','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70025,'El Movimiento no existe en el M�dulo','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70030,'PresentacionAutoCampo','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70040,'Conexi�n Contable','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70050,'Conexi�n Contable - Impuestos','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70060,'Es necesario configurar las fechas del periodo especial','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70070,'Es necesario configurar "Anticipos Facturados"','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70080,'El tipo de costeo no es v�lido','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70090,'Es necesario configurar "Multi-almacenes" en Inventarios','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70100,'Es necesario configurar "Acreedor Retenciones" en Gastos','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70110,'El prefijo de la Sucursal debe ser alfanum�rico, Ejemplos: A, B, C, MX, PO, AZ, SA, 1-, 2-, 3-','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70120,'Es necesario configurar el tipo de Movimiento (Paralelo) en el M�dulo de Atenci�n','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70130,'El Movimiento a generar no existe','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70140,'No puede generar un Movimiento desde Gastos, que va a regenerar el Gasto','CFG')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (70150,'Falta configurar el tipo Movimiento','CFG')

insert MensajeLista (Mensaje,Descripcion)      VALUES (71010,'No est� definido el Usuario')
insert MensajeLista (Mensaje,Descripcion)      VALUES (71020,'El Usuario indicado no existe')
insert MensajeLista (Mensaje,Descripcion)      VALUES (71025,'El Usuario o el Agente se encuentra en estatus BAJA') --BUG4572
insert MensajeLista (Mensaje,Descripcion)      VALUES (71027,'El Usuario no tiene permiso para modificar La Posici�n Destino') --BUG5797
insert MensajeLista (Mensaje,Descripcion)      VALUES (71030,'Es el mismo Usuario')
insert MensajeLista (Mensaje,Descripcion)      VALUES (71040,'Prioridad inv�lida')
insert MensajeLista (Mensaje,Descripcion)      VALUES (71050,'Falta la rutina spInvMatarDirectamente')
insert MensajeLista (Mensaje,Descripcion)      VALUES (71060,'Archivo inv�lido')
insert MensajeLista (Mensaje,Descripcion)      VALUES (71070,'El archivo indicado ya fue conciliado')

insert MensajeLista (Mensaje,Descripcion)      VALUES (71510,'Error al crear el archivo') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71515,'Error al eliminar el archivo') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71520,'Error al escribir en el archivo') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71525,'El archivo no existe') --MEJORA1792
insert MensajeLista (Mensaje,Descripcion)      VALUES (71530,'Error al leer el archivo') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71540,'Error al cerrar el archivo') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71550,'Error al extraer la fecha del certificado') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71560,'Fecha de expiraci�n de certificado inv�lida') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71570,'Error al generar el sello') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71580,'Error al extraer el certificado') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71590,'Error al extraer el n�mero de certificado') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71600,'Documento XML inv�lido') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71610,'Error al convertir el archivo a UTF-8') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71620,'La secci�n de la plantilla no coincide con la lista de secciones del documento') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71630,'Error de encriptaci�n') --MEJORA1792
insert MensajeLista (Mensaje,Descripcion)      VALUES (71640,'Error al crear el directorio') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71650,'Error al timbrar el CFDI') --MEJORA2104
insert MensajeLista (Mensaje,Descripcion)      VALUES (71660,'Error al crear el PDF (Jasper Reports)')
insert MensajeLista (Mensaje,Descripcion)      VALUES (71661,'Error al crear el PDF (Report Builder)')--Task 17447

-- 9562
insert MensajeLista (Mensaje,Descripcion)      VALUES (71665,'Falta configurar el Directorio DropBox')
insert MensajeLista (Mensaje,Descripcion)      VALUES (71670,'El movimiento no es una parcialidad')
insert MensajeLista (Mensaje,Descripcion)      VALUES (71680,'Est� mal configurado el Folio de CFD') 
insert MensajeLista (Mensaje,Descripcion)      VALUES (71685,'La Empresa no est� configurada para este tipo de plantilla') 

insert MensajeLista (Mensaje,Descripcion)      VALUES (72010,'Plantilla incorrecta')
insert MensajeLista (Mensaje,Descripcion)      VALUES (72020,'No existe la Plantilla')
insert MensajeLista (Mensaje,Descripcion)      VALUES (72030,'Falta indicar el Cliente en la Plantilla')
insert MensajeLista (Mensaje,Descripcion)      VALUES (72040,'El c�digo no existe')
insert MensajeLista (Mensaje,Descripcion)      VALUES (72043,'Falta indicar el C�digo de Barras') --BUG5752
insert MensajeLista (Mensaje,Descripcion)      VALUES (72050,'El Art�culo no existe')
insert MensajeLista (Mensaje,Descripcion, IE)  VALUES (72055,'El Art�culo no est� dado de Alta', 1)
insert MensajeLista (Mensaje,Descripcion)      VALUES (72060,'La Sucursal no existe')
insert MensajeLista (Mensaje,Descripcion)      VALUES (72070,'ID fuera del rango de la Sucursal (validaci�n SincroSemilla)')
insert MensajeLista (Mensaje,Descripcion)      VALUES (72080,'Informaci�n incompleta')
-- REQ PROYECTOS
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (72090, 'Sub Plantilla incorrecta', 'ERROR')

insert MensajeLista (Mensaje,Descripcion)      VALUES (73010,'El boleto ya fue recaudado')
insert MensajeLista (Mensaje,Descripcion)      VALUES (73020,'La cantidad del boleto taquilla difiere con el registro del c�digo de barras')
insert MensajeLista (Mensaje,Descripcion)      VALUES (73030,'Tipo incorrecto')
insert MensajeLista (Mensaje,Descripcion)      VALUES (73040,'Acci�n incorrecta')
insert MensajeLista (Mensaje,Descripcion)      VALUES (73050,'Contrato ya renovado')
insert MensajeLista (Mensaje,Descripcion)      VALUES (73060,'Campo Auto-Completado Ya Existe')
insert MensajeLista (Mensaje,Descripcion)      VALUES (73070, 'Al realizar un Recibo Extracci�n no se permite asignar m�s de una Serie o Lote por Art�culo')


--MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73500,'Falta indicar la m�scara de la Clave Presupuestal') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73510,'Ya existe una Estructura definida para el Proyecto de Presupuesto con la misma categor�a') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73520,'Categor�a especificada incorrecta') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73530,'Falta especificar la Categor�a') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73540,'El tipo de Cat�logo no puede ser igual a su padre') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73550,'N�mero de d�gitos incorrecto') --MEJORA4722
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES(73552, 'N�mero telef�nico incorrecto', 'ERROR', 0) -- REQ12336
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES(73553, 'Confirmaci�n de n�mero telef�nico incorrecta', 'ERROR', 0) -- REQ12336
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES(73554, '�nicamente se permite recargar un n�mero telef�nico por movimiento', 'ERROR', 0) -- REQ12336
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES(73555, 'No se puede cancelar el movimiento ya que tiene una recarga telef�nica concluida.', 'ERROR', 0) -- REQ12336
insert MensajeLista (Mensaje,Descripcion) VALUES (73556,'Art�culo LDI inv�lido') --REQ 13386  
insert MensajeLista (Mensaje,Descripcion) VALUES (73557,'Solo es posible activar un monedero por Movimiento') --REQ 13386  
insert MensajeLista (Mensaje,Descripcion) VALUES (73558,'Servicio LDI inv�lido') --REQ 13386  
insert MensajeLista (Mensaje,Descripcion) VALUES (73559,'La interfaz LDI est� apagada') --REQ 13386  

insert MensajeLista (Mensaje,Descripcion) VALUES (73560,'Falta especificar la validaci�n del tipo de cat�logo') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73561,'No se puede cancelar el movimiento ya que tiene un Pago de servicio concluido')
insert MensajeLista (Mensaje,Descripcion) VALUES (73562,'No es posible realizar cargos de LDI en este Movimiento') --REQ 13386  
insert MensajeLista (Mensaje,Descripcion) VALUES (73563,'No es posible realizar conexi�n a LDI Con Movimientos configurados para CFD') --REQ 13386  
insert MensajeLista (Mensaje,Descripcion) VALUES (73570,'Validaci�n del tipo de cat�logo incorrecta') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73580,'El tipo de cat�logo ya existe') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73590,'No se ha especificado el padre del tipo de cat�logo') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73600,'El tipo de cat�logo tiene cat�logos asignados') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73610,'Falta indicar el detalle') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73620,'Tipo de cat�logo repetido') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73630,'El tipo de cat�logo no existe') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73640,'Cat�logo repetido') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73650,'Falta especificar el tipo de cat�logo') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73660,'El tipo de cat�logo no corresponde a la categor�a especificada') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73670,'El cat�logo no puede ser igual a su padre') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73680,'El cat�logo ya existe') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73690,'El cat�logo no existe') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73700,'La estructura para el tipo de cat�logo especificado no existe') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73710,'El cat�logo tiene subcat�logos asignados') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73720,'El cat�logo especificado no corresponde al tipo de cat�logo especificado') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73730,'Clave presupuestal inv�lida') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73740,'Clave presupuestal repetida') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73750,'La clave presupuestal ya existe') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73760,'La clave presupuestal no existe') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73770,'Descripci�n de regla repetida') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73780,'M�scara de regla incorrecta') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73790,'Tipo de regla incorrecto') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73800,'Las fechas de la regla son incorrectas') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73810,'Regla incorrecta') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73820,'Regla repetida') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73830,'No existe un proyecto de presupuesto pendiente') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73840,'La clave presupuestal no cumple con las reglas de operaci�n') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73850,'No existe un presupuesto vigente') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73860,'No existe un presupuesto vigente o un proyecto de presupuesto pendiente') --MEJORA4722
insert MensajeLista (Mensaje,Descripcion) VALUES (73870,'El proyecto presupuestal tiene movimientos') --MEJORA4722

--SAUX
insert MensajeLista (Mensaje,Descripcion)      VALUES (75010,'Servicio incorrecto')
insert MensajeLista (Mensaje,Descripcion)      VALUES (75020,'Producto incorrecto')
insert MensajeLista (Mensaje,Descripcion)      VALUES (75030,'Indicador incorrecto')
insert MensajeLista (Mensaje,Descripcion)      VALUES (75040,'Falta ingresar los valores de los indicadores')

--MEJORASLC
insert MensajeLista (Mensaje,Descripcion)      VALUES (75500,'El origen del Movimiento no es una Entrada Consignaci�n')
insert MensajeLista (Mensaje,Descripcion)      VALUES (75510,'El Movimiento no es una Entrada Consignaci�n')
insert MensajeLista (Mensaje,Descripcion)      VALUES (75520,'Error al calcular el corte. Recalcule y vuelva a intentarlo')
insert MensajeLista (Mensaje,Descripcion)      VALUES (75530,'El corte que desea cancelar no es el �ltimo')
insert MensajeLista (Mensaje,Descripcion)      VALUES (75540,'El Movimiento Entrada Consignaci�n s�lo puede contener Art�culos tipo Serie/Lote')

-- los MensajeListas del 80000..89999 no son errores, son comentarios de la afectacion
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80000,'Verificaci�n Correcta INFO','INFO')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80010,'Movimiento Concluido', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80020,'Movimiento Afect�ndose','INFO')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80030,'Se gener� autom�ticamente','INFO')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80040,'Verificaci�n Correcta !<BR>La Diferencia ser� Aplicada a la Cuenta de Redondeo','INFO')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80050,'Movimiento Generado con �xito','INFO')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80060,'Consecutivo Asignado','INFO')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80070,'No Hay Nada que Ajustar<BR>Las Existencias Coinciden', 'INFO')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80080,'Movimiento Desafectado','INFO')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80090,'Operaci�n Relevante', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80100,'Informaci�n', 'INFO')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80110,'Precauci�n', 'PRECAUCION')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80200,'Gracias por Participar', 'INFO')
insert MensajeLista (Mensaje,Descripcion,Tipo) VALUES (80206,'Los Movimientos seleccionados Provienen de distintas Ordenes de Compra', 'PRECAUCION') --BUG4572
GO

--REQ12615 WMS
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES (80201, 'Debe capturar la referencia de la recepci�n de compra','ERROR',0)
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES (80202, 'Debe de capturar el and�n de recibo','ERROR',0)
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES (80203, 'Debe capturar el pedimento','ERROR',0)
insert MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES (80204, 'El pedimento ya existe','ERROR',0)
GO

    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 74100 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (74100,'El campo Apellido Paterno es requerido')
    
    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 74105 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (74105,'El campo Nombre es requerido')    
    
    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 74110 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (74110,'El campo Forma Pago es requerido')    
    
    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 74113 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (74113,'El campo Tipo Empleado es requerido')  
    
    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 74115 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (74115,'El campo Sueldo Diario es requerido')  
    
    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 74120 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (74120,'El campo Fecha Alta es requerido')    
    
    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 74125 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (74125,'El Departamento no existe')   
    
    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 74130 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (74130,'El Puesto no existe')      

    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 74135 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (74135,'La �ltima N�mina generada es posterior a esta')      
    
    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 55170 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (55170,'No es posible generar la N�mina directamente')   
    
    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 55175 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (55175,'El concepto no ha sido validado')          
GO


    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 10265 AND Descripcion= 'Familia Incorrecta') --REQ12534 Factory 
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (10265,'Familia Incorrecta')
GO


    IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 10255 AND Descripcion= 'Grupo Incorrecto') --REQ12534 Factory 
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (10255,'Grupo Incorrecto')
GO


--REQ 13393 POS
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30083 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30083,'La moneda de la forma de pago debe ser igual a la moneda de la cuenta')
GO    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30085 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30085,'Es necesario configurar las denominaciones para la moneda')
GO        
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30084 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30084,'Este movimiento no es multimoneda')    
GO
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 20336 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (20336,'El n�mero no existe')    
GO    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 20626 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (20626,'El juego no tiene componentes opcionales')     
GO    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 10531 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (10531,'En art�culos tipo juego no es posible cancelar partidas')        
GO    
  
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30441 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30441,'Caja bloqueada')        
GO    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30442 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30442,'El Movimiento no se ha sincronizado completamente')       
GO    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30445 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30445,'El WebService no est� habilitado')       
GO    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30446 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30446,'El WebService no est� configurado correctamente')       
GO    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30447 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30447,'Importe inv�lido')    
  
 
GO   

  IF NOT EXISTS(select * FROM MensajeLista WHERE Mensaje =20023 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (20023,'La cantidad indicada excede al disponible de la posici�n')
GO	

  IF NOT EXISTS(select * FROM MensajeLista WHERE Mensaje =20024)
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (20024,'Es necesario asignar la posici�n destino')	
	
  IF NOT EXISTS(select * FROM MensajeLista WHERE Mensaje =20026)
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (20026,'Es necesario asignar la posici�n origen')	
 GO
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30425 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30425,'Los anticipos no corresponden con la referencia del pedido')
GO    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30465 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30465,'El movimiento tiene descuentos por forma de pago. No se puede devolver')      
GO    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30466 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30466,'Acceso incorrecto. La Sucursal no corresponde con el HOST')      
GO    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30467)
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30467,'Acceso incorrecto. La caja no corresponde con el HOST')      
GO  
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30468 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30468,'La caja no corresponde a esta Sucursal')          
GO  

 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30469 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30469,'Es necesario abrir la caja concentradora de la Sucursal') 
             
GO  
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30448 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30448,'No es posible cerrar la caja. Existen cajas abiertas')          
GO   

    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30449 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30449,'Es necesario asignar n�mero de tel�fono')      
    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30443 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30443,'El tel�fono debe ser a 10 d�gitos')       
    
 IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 30444 )
    INSERT MensajeLista (Mensaje,Descripcion) VALUES (30444,'No se realiz� la recarga')     
--REQ 13393 POS

--eDocIN
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72200)
INSERT MensajeLista (Mensaje,Descripcion) 
SELECT 72200,'Documento electr�nico incorrecto.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72210)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72210,'Ruta de documento electr�nico incorrecta.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72220)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72220,'Usuario incorrecto.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72230)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72230,'XML de documento electr�nico no definido.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72240)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72240,'XML de documento electr�nico incorrecto.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72250)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72250,'Nombre de consecutivo incorrecto.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72260)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72260,'Consecutivo inicial incorrecto.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72270)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72270,'Incremento de consecutivo incorrecto.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72280)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72280,'Ruta de campo XML incorrecta.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72290)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72290,'Atributo de campo XML incorrecto.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72300)
insert MensajeLista (Mensaje,Descripcion)      
SELECT 72300,'Tabla de documento electr�nico incorrecta.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72310)
insert MensajeLista (Mensaje,Descripcion)      
SELECT 72310,'Error al agregar consecutivos al documento electr�nico.'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72320)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72320,'Error al Insertar en el m�dulo'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72330)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72330,'Es necesario asignar un valor al campo Operando 2'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72340)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72340,'El XML est� vac�o'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72350)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72350,'Es necesario asignar valor al campo Operando 1'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72360)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72360,'El XML no es v�lido'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72362)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72362,'El CFD no es v�lido'
GO
IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72363)
INSERT MensajeLista (Mensaje,Descripcion)      
SELECT 72363,'El documento no cumple con las validaciones'
GO
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 71605 )
  INSERT MensajeLista (Mensaje,Descripcion) VALUES (71605,'Campo del XML vac�o')
GO  

-- Factory
if not exists(select * from MensajeLista where Mensaje = 10265 AND Descripcion= 'Familia Incorrecta') 
BEGIN
  insert MensajeLista (Mensaje,Descripcion) VALUES (10265,'Familia Incorrecta')
END
GO
if not exists(select * from MensajeLista where Mensaje = 10255 AND Descripcion= 'Grupo Incorrecto') 
BEGIN
     insert MensajeLista (Mensaje,Descripcion) VALUES (10255,'Grupo Incorrecto')
END
GO

if not exists(select * from Acronimo) or (select version from version) <= 2000
begin
  DELETE Acronimo 
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('SL',   'Nivel Servicio')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('IS',   'Inventario Seguridad')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('BP',   'Planeacion Negocio')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('S&OP', 'Planeacion Ventas y Operaciones')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('MPS',  'Programa Maestro Produccion')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('RCCP', 'Planeacion Bruta Capacidad')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('MRP',  'Planeacion Requerimientos Materiales')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('CRP',  'Planeacion Requerimientos Capacidad')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('PAC',  'Control Actividades Produccion')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('DRP',  'Planeacion Requerimientos Distribucion')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('JIT',  'Manufactura Justo a Tiempo ')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('MTS',  'Hacer para Inventario')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('MTO',  'Hacer a la Orden')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('ATO',  'Ensamblar a la Orden')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('OH',   'En Existencia')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('LT',   'Tiempo Entrega')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('CLT',  'Tiempo Entrega Acumulado')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('SS',   'Inventario Seguridad')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('OQ',   'Cantidad Ordenar')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('CR',   'Radio Critico')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('L4L',  'Lote por Lote')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('FOQ',  'Cantidad Fija Ordenar')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('EOQ',  'Cantidad Econ�mica Ordenar')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('POQ',  'Cantidad Orden por Periodo')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('POS',  'Periodos de Suministro')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('LUC',  'Menor Costo Unitario')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('OPS',  'Punto de Reorden')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('LTC',  'Menor Costo Total')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('PPB',  'Balanceo Parte Periodo')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('SPT',  'Menor Tiempo Proceso')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('FCFS', 'Primero en llegar, primero en ser servido')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('TQM',  'Administraci�n Total Calidad')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('TQC',  'Control Total Calidad')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('TPM',  'Mantenimiento Productivo Total')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('BOM',  'Lista Materiales')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('FCS',  'Programacion Capacidad Finita')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('EDI',  'Intercambio Electronico Datos')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('SQL',  'Language Estructurado para Consulta Datos')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('B2B',  'Negocio a Negocio')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('B2C',  'Negocio a Cliente')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('CRM',  'Administrador Relaciones con Clientes')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('ERP',  'Planeacion Recursos Empresa')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('EVA',  'Valor Economico Agregado')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('FOB',  'Libre a Bordo')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('GPS',  'Sistema Posicionamiento Global')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('ECR',  'Respuesta Eficiente Cliente')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('PEPS', 'Primeras Entradas, Primeras Salidas')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('UEPS', 'Ultimas Entradas, Primeras Salidas')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('APICS','American Production and Inventory Control Society')

  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('PRV', 'Presupuesto')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('PV',  'Pedidos')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('PVE', 'Pedidos Extraordinarios')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('SOL', 'Solicitudes')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('OT',  'Ordenes Transferencia')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('OI',  'Ordenes Traspaso')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('DA',  'Demanda en Firme')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('DT',  'Demanda Total')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('RB',  'Requerimientos Brutos')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('RD',  'Requerimientos Distribucion')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('OC',  'Recibos Ordenes Compra')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('OP',  'Recibos Ordenes Produccion')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('ROT', 'Recibos Ordenes Transferencia')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('ROI', 'Recibos Ordenes Traspaso')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('RTI', 'Recibos En Transito')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('RP',  'Recibos Programados')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('EP',  'Existencia Proyectada')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('E',   'Existencia')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('RN',  'Requerimientos Netos')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('ATP', 'Disponible para Prometer')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('ROPF','Recibo Ordenes Planeadas en Firme')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('REPF','Recibo Distribucion en Firme')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('SODF','Salida Distribucion en Firme')
--  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('LOPF','Liberacion Ordenes Planeadas Firme')
--  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('LEPF','Liberacion Ordenes Distribucion Firme')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('ROP', 'Recibo Ordenes Planeadas')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('REP', 'Recibo Distribucion Planeada')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('LOP', 'Liberacion Ordenes Planeadas')
  INSERT INTO Acronimo (Acronimo, Termino) VALUES ('LEP', 'Liberacion Distribucion Planeada')
END
GO

if not exists(select * from PlanEstructura) or (select version from version) <= 2000
begin
  DELETE PlanEstructura
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'PRV',   10, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'IS',    15, 0)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'PV',    20, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'PVE',   30, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'SOL',   40, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'OT',    50, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'OI',    60, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'RB',    70, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'RD',    80, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'DA',    90 ,0)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'DT',   100, 0)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'OC',   110, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'OP',   120, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'ROT',  130, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'ROI',  140, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'RTI',  150, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'RP',   160, 0)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'EP',   170, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'RN',   180, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'ATP',  190, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'SODF', 200, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'REPF', 210, 1)
--  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'LEPF', 220, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'ROPF', 230, 1)
--  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'LOPF', 240, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'REP',  250, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'LEP',  260, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'ROP',  270, 1)
  INSERT INTO PlanEstructura (TipoPlan, Acronimo, Orden, Visible) VALUES ('ART', 'LOP',  280, 1)
end
GO



/*** Modulos ****/
-- select * from modulo

SELECT Modulo 
INTO #TempHistoricos
FROM Modulo
WHERE Hist = 1

DELETE modulo
go
insert Modulo (Modulo, Nombre) VALUES ('DIN',  'Tesoreria')
insert Modulo (Modulo, Nombre) VALUES ('COMS', 'Compras')
insert Modulo (Modulo, Nombre) VALUES ('CONT', 'Contabilidad')
insert Modulo (Modulo, Nombre) VALUES ('CXC',  'Cuentas por Cobrar')
insert Modulo (Modulo, Nombre) VALUES ('CXP',  'Cuentas por Pagar')
insert Modulo (Modulo, Nombre) VALUES ('INV',  'Inventarios')
insert Modulo (Modulo, Nombre) VALUES ('VTAS', 'Ventas')
insert Modulo (Modulo, Nombre) VALUES ('GAS',  'Gastos')
insert Modulo (Modulo, Nombre) VALUES ('EMB',  'Embarques')
insert Modulo (Modulo, Nombre) VALUES ('AF',   'Activos Fijos')
insert Modulo (Modulo, Nombre) VALUES ('NOM',  'Nomina')
insert Modulo (Modulo, Nombre) VALUES ('RH',   'Recursos Humanos')
insert Modulo (Modulo, Nombre) VALUES ('PC',   'Precios y Costos')
insert Modulo (Modulo, Nombre) VALUES ('OFER', 'Ofertas')
insert Modulo (Modulo, Nombre) VALUES ('VALE', 'Vales')
insert Modulo (Modulo, Nombre) VALUES ('CR',   'Cajas Registradoras')
insert Modulo (Modulo, Nombre) VALUES ('ASIS', 'Asistencias')
insert Modulo (Modulo, Nombre) VALUES ('AGENT','Comisiones')
insert Modulo (Modulo, Nombre) VALUES ('CAM',  'Cambios')
insert Modulo (Modulo, Nombre) VALUES ('CAP',  'Capital')
insert Modulo (Modulo, Nombre) VALUES ('INC',  'Incidencias')
insert Modulo (Modulo, Nombre) VALUES ('CONC', 'Conciliaciones')
insert Modulo (Modulo, Nombre) VALUES ('PPTO', 'Presupuestos')
insert Modulo (Modulo, Nombre) VALUES ('CREDI','Credito')
insert Modulo (Modulo, Nombre) VALUES ('TMA',  'WMS')
insert Modulo (Modulo, Nombre) VALUES ('RSS',  'Fuentes RSS')
insert Modulo (Modulo, Nombre) VALUES ('ST',   'Soporte')
insert Modulo (Modulo, Nombre) VALUES ('PROD', 'Produccion')
insert Modulo (Modulo, Nombre) VALUES ('PROY', 'Proyectos')
insert Modulo (Modulo, Nombre) VALUES ('CMP',  'Campa�as')
insert Modulo (Modulo, Nombre) VALUES ('FRM',  'Formas Extras')
insert Modulo (Modulo, Nombre) VALUES ('CAPT', 'Capturas')
insert Modulo (Modulo, Nombre, ConsecutivoUnico) VALUES ('GES',  'Gestion', 1)
insert Modulo (Modulo, Nombre) VALUES ('FIS',  'Fiscal')
insert Modulo (Modulo, Nombre) VALUES ('CRM',  'CRM')

--REQ16092
insert Modulo (Modulo, Nombre) VALUES ('OPORT',  'Oportunidades')

insert Modulo (Modulo, Nombre) VALUES ('CORTE',  'Cortes de Informaci�n')

--REQ25014
--insert Modulo (Modulo, Nombre) VALUES ('CONTP',  'Contabilidad Paralela')

--insert Modulo (Modulo, Nombre) VALUES ('MEX01',  'Modulo Extra 01')
--insert Modulo (Modulo, Nombre) VALUES ('MEX02',  'Modulo Extra 02')
--insert Modulo (Modulo, Nombre) VALUES ('MEX03',  'Modulo Extra 03')
--insert Modulo (Modulo, Nombre) VALUES ('MEX04',  'Modulo Extra 04')
--insert Modulo (Modulo, Nombre) VALUES ('MEX05',  'Modulo Extra 05')
--insert Modulo (Modulo, Nombre) VALUES ('MEX06',  'Modulo Extra 06')
--insert Modulo (Modulo, Nombre) VALUES ('MEX07',  'Modulo Extra 07')
--insert Modulo (Modulo, Nombre) VALUES ('MEX08',  'Modulo Extra 08')
--insert Modulo (Modulo, Nombre) VALUES ('MEX09',  'Modulo Extra 09')
insert Modulo (Modulo, Nombre) VALUES ('ORG',  'Organizacion')
insert Modulo (Modulo, Nombre) VALUES ('RE',   'Reclutamiento, Seleccion y Evaluaci�n')
insert Modulo (Modulo, Nombre) VALUES ('ISL',  'Servidor Licencias')
insert Modulo (Modulo, Nombre, ConsecutivoUnico) VALUES ('PACTO','Contratos', 1)
insert Modulo (Modulo, Nombre) VALUES ('CP', 'Control Presupuestal')
insert Modulo (Modulo, Nombre) VALUES ('PCP', 'Planeaci�n Presupuestal')
insert Modulo (Modulo, Nombre) VALUES ('SAUX',  'Servicios Auxiliares')
insert Modulo (Modulo, Nombre) VALUES ('POS',  'Punto de Venta')
insert Modulo (Modulo, Nombre) VALUES ('PREV',  'Prevencion')

UPDATE Modulo
SET Hist = 1
WHERE Modulo IN (SELECT * FROM #TempHistoricos)

DROP TABLE #TempHistoricos

go

if not exists(select * from SubModulo) or (select version from version)<=2214
begin
  DELETE SubModulo
  insert SubModulo (Modulo, SubModulo, Orden, Nombre) VALUES ('VTAS', 'VTAS',  1, 'Ventas')
  insert SubModulo (Modulo, SubModulo, Orden, Nombre) VALUES ('VTAS', 'SERV',  2, 'Servicios')
  insert SubModulo (Modulo, SubModulo, Orden, Nombre) VALUES ('VTAS', 'DVTAS', 3, 'Devoluciones')
  insert SubModulo (Modulo, SubModulo, Orden, Nombre) VALUES ('VTAS', 'AUTO',  4, 'Autotransportes')
  insert SubModulo (Modulo, SubModulo, Orden, Nombre) VALUES ('VTAS', 'TALL',  5, 'Taller')

  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('ST', 'ST',    1, 1, 'Atenci�n Clientes')
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('ST', 'STPRO', 2, 1, 'Atenci�n Proveedores')
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('ST', 'STPER', 3, 1, 'Atenci�n Personal')
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('ST', 'PROY',  4, 1, 'Proyectos')
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('ST', 'SI',    5, 1, 'Servicios Internos')

  insert SubModulo (Modulo, SubModulo, Orden, Nombre) VALUES ('COMS', 'COMS',  1, 'Compras')
  insert SubModulo (Modulo, SubModulo, Orden, Nombre) VALUES ('COMS', 'IMP',   2, 'Importaciones')
  insert SubModulo (Modulo, SubModulo, Orden, Nombre) VALUES ('COMS', 'CC',    3, 'Control Calidad')

  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('INV','INV',   1, 1, 'Inventarios')
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('INV','MERMA', 2, 1, 'Mermas')

  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('GAS','GAS',   1, 1, 'Gastos')
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('GAS','MANT',  2, 1, 'Mantenimiento')
end 
go
if not exists(select * from submodulo where modulo = 'COMS' AND subModulo = 'CC') and (select version from version)<=2350
  insert SubModulo (Modulo, SubModulo, Orden, Nombre) VALUES ('COMS', 'CC',    3, 'Control Calidad')
GO
if (select version from version)<=2700
  delete SubModulo where modulo = 'VTAS' AND subModulo = 'MANT'
GO
if not exists(select * from submodulo where modulo = 'VTAS' AND subModulo = 'TALL') and (select version from version)<=2700
  insert SubModulo (Modulo, SubModulo, Orden, Nombre) VALUES ('VTAS', 'TALL',  5, 'Taller')
go

if not exists(select * from submodulo where modulo = 'INV') and (select version from version)<=2764
BEGIN
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('INV','INV',   1, 1, 'Inventarios')
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('INV','MERMA', 2, 1, 'Mermas')
END
GO
if not exists(select * from submodulo where modulo = 'GAS') and (select version from version)<=2764
BEGIN
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('GAS','GAS',   1, 1, 'Gastos')
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('GAS','MANT',  2, 1, 'Mantenimiento')
END
GO
-- para activarlo en la forma hay que activar "Usar el titulo Actual como nombre del modulo"
if not exists(select * from submodulo where modulo = 'CXC') and (select version from version)<=3200
BEGIN
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('CXC','CXC',   1, 1, 'Cuentas por cobrar')
  insert SubModulo (Modulo, SubModulo, Orden, Filtrar, Nombre) VALUES ('CXC','NOM',   2, 1, 'Prestamos al Personal')
END
GO

/**** Ramas ****/
DELETE Rama
go
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('AF','Activos Fijos',1,'AF',NULL,0,1,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('AGENT','Comisiones',1,'AGENT',NULL,1,0,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CAM','Cambios',1,'CAM',NULL,1,0,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CANT','Anticipos Facturados',1,'CANT',NULL,1,0,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CC','Centros de Costos',1,'CC',NULL,1,0,0,0,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CEFE','Saldo a Favor',1,'CXC',NULL,1,0,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CNO','Consumos',1,'CXC',NULL,1,0,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('COMS','Compras',1,'COMS',NULL,1,1,1,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CONT','Contabilidad',1,'CONT',NULL,1,0,0,0,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CRND','Redondeo',1,'CXC',NULL,1,0,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CSG','a Consignacion',1,'INV',NULL,0,1,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CVALE','Vales en Circulacion',1,'CXC',NULL,1,0,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CXC','Cuentas por Cobrar',1,'CXC',NULL,1,0,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CXP','Cuentas por Pagar',1,'CXP',NULL,1,0,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('DIN','Tesoreria',1,'DIN',NULL,1,0,0,1,1)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('GAR','Garantia',1,'INV',NULL,0,1,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('INV','Inventarios',1,'INV',NULL,1,1,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('PEFE','Saldo a Favor',1,'CXP',NULL,1,0,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('PRND','Redondeo',1,'CXP',NULL,1,0,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('PZA','Piezas',1,'PZA',NULL,0,1,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('RESV','Reservados',-1,'INV',NULL,0,1,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('VAC','Dias Vacaciones',1,'VAC',NULL,0,1,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('VMOS','Ventas Mostrador',-1,'INV',NULL,0,1,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('VTAS','Ventas',1,'VTAS',NULL,1,1,1,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CC2','Centros de Costos 2',1,'CC2',NULL,1,0,0,0,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CC3','Centros de Costos 3',1,'CC3',NULL,1,0,0,0,0)
--INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('TMA','Tarimas',1,'INV',NULL,0,1,0,1,0)
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CIO','Interes Ordinario',1,'CXC',NULL,1,0,0,1,0) --MEJORA10015
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('CIM','Interes Moratorio',1,'CXC',NULL,1,0,0,1,0) --MEJORA10015
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('PIO','Interes Ordinario',1,'CXP',NULL,1,0,0,1,0) --MEJORA10015
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('PIM','Interes Moratorio',1,'CXP',NULL,1,0,0,1,0) --MEJORA10015
INSERT INTO Rama (Rama,Descripcion,Factor,Mayor,Modulo,EsMonetario,EsUnidades,EsResultados,GeneraAuxiliar,Conciliar) VALUES ('WMS','Tarima',1,'WMS',NULL,1,1,0,1,0)--Task 8036
GO

/****** Direcciones ******/
DELETE direccion
go
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural, EsUnidades) values ('Inventarios',         		'INV',  'Articulo',  'Articulos',   'Almacen',   'Almacenes',   1)
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural, EsUnidades) values ('Ventas',              		'VTAS', 'Articulo',  'Articulos',   'Cliente',   'Clientes',    1)
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural, EsUnidades) values ('Compras',             		'COMS', 'Articulo',  'Articulos',   'Proveedor', 'Proveedores', 1)
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Cuentas por cobrar',  		'CXC',  'Cliente',   'Clientes',    NULL,        NULL            )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Redondeo Clientes',  			'CRND', 'Cliente',   'Clientes',    NULL,        NULL		 )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Saldo a Favor Clientes',   		'CEFE', 'Cliente',   'Clientes',    NULL,        NULL		 )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Consumos Clientes',   		'CNO',  'Cliente',   'Clientes',    NULL,        NULL		 )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Vales en Circulacion',   		'CVALE','Cliente',   'Clientes',    NULL,        NULL		 )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Cuentas por pagar',   		'CXP',  'Proveedor', 'Proveedores', NULL,        NULL            )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Redondeo Proveedores',		'PRND', 'Proveedor', 'Proveedores', NULL,        NULL            )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Saldo a Favor Proveedores',		'PEFE', 'Proveedor', 'Proveedores', NULL,        NULL		 )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Dinero', 	        		'DIN',  'Cuenta',    'Cuentas',     NULL,        NULL            )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Comisiones', 	        		'COMI', 'Agente',    'Agentes',     NULL,        NULL            )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural, EsContable) values ('Contabilidad',        		'CONT', 'Cuenta',    'Cuentas',     NULL,        NULL,          1)
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Centros de Costos', 	       		'CC',   'Centro Costos','Centros Costos', NULL,  NULL            )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Centros de Costos 2',	       		'CC2',  'Centro Costos 2','Centros Costos 2', NULL,  NULL            )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Centros de Costos 3', 	       		'CC3',   'Centro Costos 3','Centros Costos 3', NULL,  NULL            )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Cambios', 				'CAM',  'Cliente',   'Clientes',    NULL,        NULL            )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural) 		 values ('Anticipos Facturados',   		'CANT', 'Cliente',   'Clientes',    NULL,        NULL		 )
insert Direccion (Direccion, Rama, CuentaSingular, CuentaPlural, GrupoSingular, GrupoPlural, EsMonetario, EsUnidades) values ('Dias Vacaciones',   	'VAC',  'Personal',  'Personal',    NULL,        NULL,		0, 	1)
go

DELETE EmpresaCfgPVCampo
go
-- Relacionados con la Empresa
insert EmpresaCfgPVCampo (Campo) values ('<Empresa.Clave>')
insert EmpresaCfgPVCampo (Campo) values ('<Empresa.Nombre>')
insert EmpresaCfgPVCampo (Campo) values ('<Empresa.CodigoPostal>')
insert EmpresaCfgPVCampo (Campo) values ('<Empresa.Colonia>')
insert EmpresaCfgPVCampo (Campo) values ('<Empresa.Direccion>')
insert EmpresaCfgPVCampo (Campo) values ('<Empresa.Estado>')
insert EmpresaCfgPVCampo (Campo) values ('<Empresa.RFC>')
insert EmpresaCfgPVCampo (Campo) values ('<Empresa.Telefonos>')

-- Relacionados con el Cliente
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.Clave>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.Nombre>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.Categoria>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.Descuento>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.Familia>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.Grupo>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.CodigoPostal>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.Colonia>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.CURP>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.Direccion>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.Estado>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.FormaEnvio>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.RFC>')
insert EmpresaCfgPVCampo (Campo) values ('<Cliente.Telefonos>')

-- Relacionados con el Art�culo
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.Clave>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.Descripcion>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.Cantidad>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.Descuento>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.Precio>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.Importe>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.Unidad>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.Categoria>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.Familia>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.Grupo>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.Fabricante>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.TipoArticulo>')
insert EmpresaCfgPVCampo (Campo) values ('<Detalle.DescuentoNetoPrecioLista>')

-- Generales de la Nota
insert EmpresaCfgPVCampo (Campo) values ('<Nota.Fecha>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.Hora>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.Folio>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.AgenteClave>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.AgenteNombre>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.AlamcenClave>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.AlamcenNombre>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.Caja>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.CajeroClave>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.CajeroNombre>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.Descuento>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.DescGlobal>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.Cambio>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.Cobrado>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.Impuestos>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.SubTotal>')
insert EmpresaCfgPVCampo (Campo) values ('<Nota.ImporteTotal>')
insert EmpresaCfgPVCampo (Campo) values ('<ModoImpresion(xxx)>')
GO

insert EmpresaCfgPVCampo (Campo) values ('<Sucursal.Numero>')
insert EmpresaCfgPVCampo (Campo) values ('<Sucursal.Prefijo>')
insert EmpresaCfgPVCampo (Campo) values ('<Sucursal.Nombre>')
insert EmpresaCfgPVCampo (Campo) values ('<Sucursal.CodigoPostal>')
insert EmpresaCfgPVCampo (Campo) values ('<Sucursal.Colonia>')
insert EmpresaCfgPVCampo (Campo) values ('<Sucursal.Direccion>')
insert EmpresaCfgPVCampo (Campo) values ('<Sucursal.Estado>')
insert EmpresaCfgPVCampo (Campo) values ('<Sucursal.RFC>')
insert EmpresaCfgPVCampo (Campo) values ('<Sucursal.Telefonos>')
insert EmpresaCfgPVCampo (Campo) values ('<Sucursal.Region>')
GO


DELETE EventoTipo
GO
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (1, 'Comentario', 	1, 510)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (2, 'Correo', 		0, 264)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (3, 'Llamada', 		1, 708)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (4, 'Cita', 		0, 729)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (5, 'Tarea', 		0, 62)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (6, 'Nota', 		1, 552)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (7, 'Anexo',		0, 164)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (8, 'Avance',		0, 48)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (9, 'Evaluacion',	0, 166)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (10,'Gasto',		0, 86)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (11,'Embarque',		0, 556)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (12,'Posicion',		0, 155)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (13,'Informe SMS',	0, 306)
INSERT EventoTipo (Orden, Tipo, General, Icono) VALUES (14,'Autorizacion SMS',	0, 319)
GO

DELETE Estatus
GO
INSERT Estatus (Estatus, Nombre) VALUES ('ALTA', 		'Alta')
INSERT Estatus (Estatus, Nombre) VALUES ('BLOQUEADO', 		'Bloqueado')
INSERT Estatus (Estatus, Nombre) VALUES ('BAJA', 		'Baja')
INSERT Estatus (Estatus, Nombre) VALUES ('NORMAL', 		'Normal')
INSERT Estatus (Estatus, Nombre) VALUES ('DESCONTINUADO', 	'Descontinuado')
INSERT Estatus (Estatus, Nombre) VALUES ('BAJO', 		'Bajo de Precio')
INSERT Estatus (Estatus, Nombre) VALUES ('SUBIO', 		'Subio de Precio')
INSERT Estatus (Estatus, Nombre) VALUES ('SINCAMBIO', 		'Sin Cambio')
INSERT Estatus (Estatus, Nombre) VALUES ('NUEVO', 		'Nuevo')
INSERT Estatus (Estatus, Nombre) VALUES ('ENUSO', 		'En Uso')
INSERT Estatus (Estatus, Nombre) VALUES ('PENDIENTE', 		'Pendiente')
INSERT Estatus (Estatus, Nombre) VALUES ('SINCRO', 		'Sincronizaci�n')
INSERT Estatus (Estatus, Nombre) VALUES ('POSFECHADO', 		'Posfechado')
INSERT Estatus (Estatus, Nombre) VALUES ('ALTAPRIORIDAD',	'Alta Prioridad')
INSERT Estatus (Estatus, Nombre) VALUES ('PRIORIDADBAJA',	'Baja Prioridad')
INSERT Estatus (Estatus, Nombre) VALUES ('VIGENTE',		'Vigente')
INSERT Estatus (Estatus, Nombre) VALUES ('VENCIDO',		'Vencido')
INSERT Estatus (Estatus, Nombre) VALUES ('PROCESAR',		'por Procesar')
INSERT Estatus (Estatus, Nombre) VALUES ('RECURRENTE',		'Recurrente')
INSERT Estatus (Estatus, Nombre) VALUES ('CANCELADO',		'Cancelado')
INSERT Estatus (Estatus, Nombre) VALUES ('BLOQ_AVISO',		'Bloqueado (Aviso)')
INSERT Estatus (Estatus, Nombre) VALUES ('CONCLUIDO',		'Concluido')
INSERT Estatus (Estatus, Nombre) VALUES ('SINAFECTAR',		'Sin Afectar')
INSERT Estatus (Estatus, Nombre) VALUES ('BORRADOR',		'Borrador')
INSERT Estatus (Estatus, Nombre) VALUES ('CONFIRMAR',		'por Confirmar')
INSERT Estatus (Estatus, Nombre) VALUES ('AUTORIZAR',		'por Autorizar')
INSERT Estatus (Estatus, Nombre) VALUES ('AUTORIZARE',		'por Autorizar')
INSERT Estatus (Estatus, Nombre) VALUES ('ACTIVA',		'Activa')
INSERT Estatus (Estatus, Nombre) VALUES ('ACTIVO',		'Activo')
INSERT Estatus (Estatus, Nombre) VALUES ('AUTORIZADO',		'Autorizado')
INSERT Estatus (Estatus, Nombre) VALUES ('INACTIVA',		'Inactiva')
INSERT Estatus (Estatus, Nombre) VALUES ('INACTIVO',		'Inactivo')
INSERT Estatus (Estatus, Nombre) VALUES ('MANTENIMIENTO',	'En Mantenimiento')
INSERT Estatus (Estatus, Nombre) VALUES ('REPARACION',		'En Reparaci�n')
INSERT Estatus (Estatus, Nombre) VALUES ('PLANTILLA',		'Plantilla')
INSERT Estatus (Estatus, Nombre) VALUES ('DISPONIBLE',		'Disponible')
INSERT Estatus (Estatus, Nombre) VALUES ('CIRCULACION',		'En Circulaci�n')
INSERT Estatus (Estatus, Nombre) VALUES ('COBRADO',		'Cobrado')
INSERT Estatus (Estatus, Nombre) VALUES ('ENTRANSITO',		'En Transito')
INSERT Estatus (Estatus, Nombre) VALUES ('ASPIRANTE',		'Aspirante')
INSERT Estatus (Estatus, Nombre) VALUES ('CANDIDATO',		'Candidato')
INSERT Estatus (Estatus, Nombre) VALUES ('FINIQUITADO',		'Finiquitado')
INSERT Estatus (Estatus, Nombre) VALUES ('+',			'Positivo')
INSERT Estatus (Estatus, Nombre) VALUES ('-',			'Negativos')
INSERT Estatus (Estatus, Nombre) VALUES ('CONTABILIZADO',	'Contabilizado')
INSERT Estatus (Estatus, Nombre) VALUES ('N/A',			'No Aplica')
INSERT Estatus (Estatus, Nombre) VALUES ('PROTOTIPO',		'Prototipo')
INSERT Estatus (Estatus, Nombre) VALUES ('OK',			'Ok')
INSERT Estatus (Estatus, Nombre) VALUES ('ERROR',		'Error')
INSERT Estatus (Estatus, Nombre) VALUES ('FUERALINEA',		'Fuera de L�nea')
INSERT Estatus (Estatus, Nombre) VALUES ('ENLINEA',		'En L�nea')
INSERT Estatus (Estatus, Nombre) VALUES ('CONFIRMADO',		'Confirmado')
INSERT Estatus (Estatus, Nombre) VALUES ('RECHAZADO',		'Rechazado')
INSERT Estatus (Estatus, Nombre) VALUES ('APROBADO',		'Aprobado')
INSERT Estatus (Estatus, Nombre) VALUES ('REVISION',		'Revisi�n')
INSERT Estatus (Estatus, Nombre) VALUES ('RETENIDO',		'Retenido')
INSERT Estatus (Estatus, Nombre) VALUES ('PAGADO',		'Pagado')
INSERT Estatus (Estatus, Nombre) VALUES ('PROCESADO',		'Procesado')
INSERT Estatus (Estatus, Nombre) VALUES ('APROBAR',		'por Aprobar')
INSERT Estatus (Estatus, Nombre) VALUES ('ORDENADO',		'Ordenado')
INSERT Estatus (Estatus, Nombre) VALUES ('RESERVADO',		'Reservado')
INSERT Estatus (Estatus, Nombre) VALUES ('ENFIRME',		'En Firme')
INSERT Estatus (Estatus, Nombre) VALUES ('FACTURADO',		'Facturado')
INSERT Estatus (Estatus, Nombre) VALUES ('SERVICIO',		'Servicio')
GO


/*************** MSGS VALIDACIONES POS **********************************/
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 20706)
INSERT MensajeLista (Mensaje,Descripcion,Tipo) VALUES (20706,'Ya fue procesada una devoluci�n con el C�digo seleccionado','PRECAUCION')
GO
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 20707)
INSERT MensajeLista (Mensaje,Descripcion,Tipo) VALUES (20707,'La Devoluci�n Excede el N�mero de D�as Programado, Favor de Realizarla desde el M�dulo','PRECAUCION')
GO
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 20708) 
INSERT INTO MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES (20708, 'La Prioridad no corresponde al Tipo de Oferta Indicado, Favor de Seleccionar Prioridad 3', 'PRECAUCION', 0)
GO 
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 20709) 
INSERT INTO MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES (20709, 'Ya fueron realizadas Devoluciomnes Parciales', 'PRECAUCION', 0)
GO
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 50000) 
INSERT INTO MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES (50000, 'El Art�culo no se encuentra en la Venta Original o es parte de un Juego', 'PRECAUCION', 0)
GO
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 50001)
INSERT MensajeLista (Mensaje,Descripcion,Tipo) VALUES (50001,'Ya existen Devoluciones Parciales en la Venta Original','PRECAUCION')
GO
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 50002)
INSERT MensajeLista (Mensaje,Descripcion,Tipo) VALUES (50002,'La Cantidad que se Pretende Devolver es Mayor a la Cantidad Saldo de la Venta Original','PRECAUCION')
GO
IF NOT EXISTS (SELECT * FROM MensajeLista WHERE Mensaje = 50003) 
INSERT INTO MensajeLista (Mensaje, Descripcion, Tipo, IE) VALUES (50003, 'La Venta Original ya tuvo una Devoluci�n Total', 'PRECAUCION', 0)
GO

