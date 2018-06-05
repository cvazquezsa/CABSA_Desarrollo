DELETE FROM NotificacionTagAyuda
GO
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Modulo>', 1, 1, 1, 1, 'Módulo del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<ID>', 0, 0, 1, 1, 'ID del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Empresa>', 1, 1, 1, 1, 'Empresa del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<EmpresaNombre>', 1, 1, 1, 1, 'Nombre de la empresa')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Sucursal>', 1, 1, 1, 1, 'Sucursal del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<SucursalNombre>', 1, 1, 1, 1, 'Nombre de la sucursal')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<UEN>', 1, 1, 1, 1, 'UEN del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<UENNombre>', 1, 1, 1, 1, 'Nombre de la UEN')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Usuario>', 1, 1, 1, 1, 'Usuario del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<UsuarioNombre>', 1, 1, 1, 1, 'Nombre del Usuario')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Movimiento>', 1, 1, 1, 1, 'Tipo de movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Notificacion>', 1, 1, 1, 1, 'Nombre de la notificación')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Estatus>', 1, 1, 1, 1, 'Estatus del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Situacion>', 1, 1, 1, 1, 'Situación del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Proyecto>', 1, 1, 1, 1, 'Proyecto del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<ContactoTipo>', 1, 1, 1, 1, 'Tipo de contacto')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Contacto>', 1, 1, 1, 1, 'Contacto del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<ContactoNombre>', 1, 1, 1, 1, 'Nombre del contacto')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Importe>', 1, 1, 1, 1, 'Importe del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Hoy>', 1, 1, 1, 1, 'Fecha del día de hoy')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<Ahora>', 1, 1, 1, 1, 'Fecha y hora del día de hoy')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<FechaEmision>', 1, 1, 1, 1, 'Fecha de emisión del movimiento')
INSERT NotificacionTagAyuda (Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion) VALUES ('<eDoc>', 0, 1, 0, 0, 'Documento electrónico del movimiento')
GO

--select * from notificaciontagayuda

/*********************** GENERICA ***********************/
IF NOT EXISTS(SELECT 1 FROM NotificacionClave WHERE Clave = 'GENERICA')
BEGIN
  INSERT NotificacionClave (Clave,      Descripcion,                                                                 Asunto,                                              Mensaje,                                                    MedioComunicacion, TipoFechaNotificacion, FechaNotificacion, AnticipacionFechaTipo, AnticipacionFecha, Frecuencia, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo, DiaMes, FechaInicio)
                    VALUES ('GENERICA', 'Clave de Notificacion Genérica que se puede utilizar en todos los módulos', 'Notificacion <Notificacion> <Modulo> <Movimiento>', 'El Movimiento <Movimiento> ha pasado a Estatus <Estatus>', 'Email',           '(Emision)',           NULL,              'Aplazar',             0,                 '(Diaria)', 1,     1,      1,         1,      1,       1,      1,       NULL,   NULL)
                    
                                      
  INSERT NotificacionClaveDestinatario (Clave,      TipoDestinatario, SeccionDestinatario, Destinatario, DestinatarioCorreo)
                                VALUES ('GENERICA', '(YO)',           'Para',              NULL,         NULL)  
  INSERT NotificacionClaveDestinatario (Clave,      TipoDestinatario, SeccionDestinatario, Destinatario, DestinatarioCorreo)
                                VALUES ('GENERICA', '(MI JEFE)',      'CC',                NULL,         NULL)  
  INSERT NotificacionClaveDestinatario (Clave,      TipoDestinatario,       SeccionDestinatario,       Destinatario, DestinatarioCorreo)
                                VALUES ('GENERICA', '(EL JEFE DE MI JEFE)', 'CC',                      NULL,         NULL)    
  INSERT NotificacionClaveDestinatario (Clave,      TipoDestinatario, SeccionDestinatario,       Destinatario, DestinatarioCorreo)
                                VALUES ('GENERICA', '(SUBORDINADOS)', 'CC',                      NULL,         NULL)    
                                  
END
GO

/*********************** AUTORIZACION ***********************/
IF NOT EXISTS(SELECT 1 FROM NotificacionClave WHERE Clave = 'AUTORIZACION')
BEGIN
  INSERT NotificacionClave (Clave,          Descripcion,                                            Asunto,                                              Mensaje,                                                    MedioComunicacion, TipoFechaNotificacion, FechaNotificacion, AnticipacionFechaTipo, AnticipacionFecha, Frecuencia, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo, DiaMes, FechaInicio)
                    VALUES ('AUTORIZACION', 'Permite Autorizar movimientos por correo electrónico', 
                            'Autorizacion Pendiente <Movimiento>', 
                            'El Movimiento <Movimiento> requiere de su autorización' + CHAR(13) +
                            'Sí desea autorizar el movimiento responda a este mensaje' + CHAR(13) +
                            'con la palabra SI en el cuerpo del mensaje.<BR>' + CHAR(10) + CHAR(13) + CHAR(10) + CHAR(13) +                                                                                                                                                                        
                            'Empresa:    <EmpresaNombre><BR>' + CHAR(10) + CHAR(13) +
                            'Sucursal:   <SucursalNombre><BR>' + CHAR(10) + CHAR(13) +                            
                            'Usuario:    <UsuarioNombre><BR>' + CHAR(10) + CHAR(13) +                                                        
                            'Modulo:     <Modulo><BR>' + CHAR(10) + CHAR(13) +                                                        
                            'Movimiento: <Movimiento><BR>' + CHAR(10) + CHAR(13) +                                                                                    
                            'Estatus:    <Estatus><BR>' + CHAR(13) +
                            'Situacion:  <Situacion><BR>' + CHAR(13) +
                            'Importe:    <Importe><BR>' + CHAR(10) + CHAR(13) + CHAR(10) + CHAR(13) +                                                                                                                                                                        
                            'INTELISIS ERP<BR>'                                                                                                                                            
                            , 'Email',           '(Emision)',           NULL,              'Aplazar',             0,                 '(Diaria)', 1,     1,      1,         1,      1,       1,      1,       NULL,   NULL)
                    
                                      
  INSERT NotificacionClaveDestinatario (Clave,          TipoDestinatario, SeccionDestinatario, Destinatario, DestinatarioCorreo)
                                VALUES ('AUTORIZACION', '(MI JEFE)',      'Para',              NULL,         NULL)  
  INSERT NotificacionClaveDestinatario (Clave,          TipoDestinatario, SeccionDestinatario, Destinatario, DestinatarioCorreo)
                                VALUES ('AUTORIZACION', '(YO)',           'CC',                NULL,         NULL)  
  INSERT NotificacionClaveDestinatario (Clave,          TipoDestinatario,       SeccionDestinatario,       Destinatario, DestinatarioCorreo)
                                VALUES ('AUTORIZACION', '(EL JEFE DE MI JEFE)', 'CC',                      NULL,         NULL)    

  INSERT NotificacionClaveParam (Clave,          Parametro,              Tipo,    ValorOmision,                                                                               Descripcion)
                         VALUES ('AUTORIZACION', 'MENSAJE CONFIRMACION', 'TEXTO', 'El Movimiento <Movimiento> ha sido autorizado exitosamente por el Usuario <Usuario>.<BR>', 'Mensaje para confirmar la autorización del movimiento.')
  INSERT NotificacionClaveParam (Clave,          Parametro,              Tipo,    ValorOmision,                                                                                              Descripcion)
                         VALUES ('AUTORIZACION', 'MENSAJE RECHAZO',      'TEXTO', 'El Movimiento <Movimiento> <font color="red">NO</font> ha sido autorizado por el Usuario <Usuario>.<BR>', 'Mensaje para confirmar la autorización del movimiento.')

  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE CONFIRMACION', '<Empresa>')                         
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE CONFIRMACION', '<Modulo>')     
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE CONFIRMACION', '<Movimiento>')       
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE CONFIRMACION', '<Estatus>')       
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE CONFIRMACION', '<Situacion>')         
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE CONFIRMACION', '<SituacionSiguiente>')           
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE CONFIRMACION', '<Usuario>')             
  
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE RECHAZO', '<Empresa>')                         
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE RECHAZO', '<Modulo>')     
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE RECHAZO', '<Movimiento>')         
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE RECHAZO', '<Estatus>')       
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE RECHAZO', '<Situacion>')         
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE RECHAZO', '<SituacionSiguiente>')           
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('AUTORIZACION', 'MENSAJE RECHAZO', '<Usuario>')             
    
END
GO

/*********************** VENTAS_DEL_PERIODO ***********************/

/**************** fnNotificacionVentasDelPeriodoIngresos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionVentasDelPeriodoIngresos') DROP FUNCTION fnNotificacionVentasDelPeriodoIngresos
GO
CREATE FUNCTION fnNotificacionVentasDelPeriodoIngresos 
	(
	@Notificacion		varchar(50),
	@Empresa			varchar(5),
	@FechaEmision		datetime
	)
	
RETURNS float

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado		float,
  @ImporteVTAS		float,
  @ImporteCXC		float
  
  SET @FechaEmision = dbo.fnFechaSinHora(@FechaEmision)
  
  SELECT 
    @ImporteVTAS = SUM(ISNULL(Importe,0.0)) 
    FROM Venta 
    WHERE Mov IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Movs. de venta que suman'))        
      AND Estatus IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Estatus de venta que suman'))    
      AND FechaEmision BETWEEN dbo.fnNotificacionParamCalcPeriodoFecha('INICIAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO') AND dbo.fnNotificacionParamCalcPeriodoFecha('FINAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO')
      AND Empresa = @Empresa
      
  SET @Resultado = ISNULL(@ImporteVTAS,0.0)

  SELECT 
    @ImporteVTAS = SUM(ISNULL(Importe,0.0)) 
    FROM Cxc 
    WHERE Mov IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Movs. de Cxc que suman'))        
      AND Estatus IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Estatus de Cxc que suman'))    
      AND FechaEmision BETWEEN dbo.fnNotificacionParamCalcPeriodoFecha('INICIAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO') AND dbo.fnNotificacionParamCalcPeriodoFecha('FINAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO')
      AND Empresa = @Empresa
      
  SET @Resultado = @Resultado + ISNULL(@ImporteVTAS,0.0)

      
  RETURN ISNULL(@Resultado,0.0)
END
GO

--SELECT dbo.fnNotificacionVentasDelPeriodoIngresos('Ventas Del Periodo','DEMO',GETDATE()) 

/**************** fnNotificacionVentasDelPeriodoEgresos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionVentasDelPeriodoEgresos') DROP FUNCTION fnNotificacionVentasDelPeriodoEgresos
GO
CREATE FUNCTION fnNotificacionVentasDelPeriodoEgresos 
	(
	@Notificacion		varchar(50),
	@Empresa			varchar(5),
	@FechaEmision		datetime
	)
	
RETURNS float

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado		float,
  @ImporteVTAS		float,
  @ImporteCXC		float
  
  SET @FechaEmision = dbo.fnFechaSinHora(@FechaEmision)
  
  SELECT 
    @ImporteVTAS = SUM(ISNULL(Importe,0.0)) 
    FROM Venta 
    WHERE Mov IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Movs. de venta que restan'))        
      AND Estatus IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Estatus de venta que restan'))    
      AND FechaEmision BETWEEN dbo.fnNotificacionParamCalcPeriodoFecha('INICIAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO') AND dbo.fnNotificacionParamCalcPeriodoFecha('FINAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO')
      AND Empresa = @Empresa
      
  SET @Resultado = ISNULL(@ImporteVTAS,0.0)

  SELECT 
    @ImporteVTAS = SUM(ISNULL(Importe,0.0)) 
    FROM Cxc 
    WHERE Mov IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Movs. de Cxc que restan'))        
      AND Estatus IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Estatus de Cxc que restan'))    
      AND FechaEmision BETWEEN dbo.fnNotificacionParamCalcPeriodoFecha('INICIAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO') AND dbo.fnNotificacionParamCalcPeriodoFecha('FINAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO')
      AND Empresa = @Empresa
      
  SET @Resultado = @Resultado + ISNULL(@ImporteVTAS,0.0)

      
  RETURN ISNULL(@Resultado,0.0)
END
GO

--SELECT dbo.fnNotificacionVentasDelPeriodoEgresos('Ventas Del Periodo','DEMO',GETDATE()) 

/**************** fnNotificacionVentasDelPeriodoTotal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionVentasDelPeriodoTotal') DROP FUNCTION fnNotificacionVentasDelPeriodoTotal
GO
CREATE FUNCTION fnNotificacionVentasDelPeriodoTotal 
	(
	@Notificacion		varchar(50),
	@Empresa			varchar(5),
	@FechaEmision		datetime
	)
	
RETURNS float

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado		float,
  @ImporteIngresos	float,
  @ImporteEgresos	float
  
  SET @FechaEmision = dbo.fnFechaSinHora(@FechaEmision)
  
  SET @ImporteIngresos = dbo.fnNotificacionVentasDelPeriodoIngresos(@Notificacion,@Empresa,@FechaEmision) 
  
  SET @ImporteEgresos = dbo.fnNotificacionVentasDelPeriodoEgresos(@Notificacion,@Empresa,@FechaEmision) 
      
  SET @Resultado = ISNULL(@ImporteIngresos,0.0) - ISNULL(@ImporteEgresos,0.0)

      
  RETURN ISNULL(@Resultado,0.0)
END
GO

/*
DELETE FROM NotificacionClave WHERE Clave = 'VENTAS_DEL_PERIODO'
DELETE FROM NotificacionClaveModulo WHERE Clave = 'VENTAS_DEL_PERIODO'
DELETE FROM NotificacionClaveModuloEstatus WHERE Clave = 'VENTAS_DEL_PERIODO'
DELETE FROM NotificacionClaveParam WHERE Clave = 'VENTAS_DEL_PERIODO'
DELETE FROM NotificacionClaveParamAyuda WHERE Clave = 'VENTAS_DEL_PERIODO'
DELETE FROM NotificacionClaveConsulta WHERE Clave = 'VENTAS_DEL_PERIODO'
DELETE FROM NotificacionClaveDestinatario WHERE Clave = 'VENTAS_DEL_PERIODO'
DELETE FROM NotificacionClaveFiltro WHERE Clave = 'VENTAS_DEL_PERIODO'
*/

IF NOT EXISTS(SELECT 1 FROM NotificacionClave WHERE Clave = 'VENTAS_DEL_PERIODO')
BEGIN
  INSERT NotificacionClave (Clave,                Descripcion,                                                     Asunto, Mensaje, MedioComunicacion, TipoFechaNotificacion, FechaNotificacion, AnticipacionFechaTipo, AnticipacionFecha, Frecuencia, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo, DiaMes, FechaInicio)
                    VALUES ('VENTAS_DEL_PERIODO', 'Notificación que reporta las ventas de un periodo determinado', 
                            'Ventas <Empresa> - Del <Ventas_Del_Periodo_Fecha_Inicial> al <Ventas_Del_Periodo_Fecha_Final>', 
                            'Ventas <Empresa> - Del <Ventas_Del_Periodo_Fecha_Inicial> al <Ventas_Del_Periodo_Fecha_Final>:<BR><BR>' + CHAR(13) +
                            'Empresa:   <EmpresaNombre><BR><BR>' + CHAR(10) + CHAR(13) +
                            'Ingresos:  <Ventas_Del_Periodo_Ingresos><BR>' + CHAR(10) + CHAR(13) +                            
                            'Egresos:   <Ventas_Del_Periodo_Egresos><BR>' + CHAR(10) + CHAR(13) +                                                        
                            'Total:     <Ventas_Del_Periodo_Total><BR><BR>' + CHAR(10) + CHAR(13) +                                                                                    
                            'INTELISIS ERP<BR>',                                                                                    
                            'Email', '(Emision)', NULL, 'Aplazar', 0, '(Diaria)', 1, 1, 1, 1, 1, 1, 1, NULL, NULL)
  
  INSERT NotificacionClaveModulo (Clave, Modulo) VALUES ('VENTAS_DEL_PERIODO', 'GES')   
  
  INSERT NotificacionClaveModuloEstatus (Clave, Modulo, Estatus) VALUES ('VENTAS_DEL_PERIODO', 'GES', 'CONCLUIDO')
  
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('VENTAS_DEL_PERIODO', 'NUMERO PERIODOS', 'NUMERO', 1, 'NUMERO DE PERIODOS A CONSIDERAR')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('VENTAS_DEL_PERIODO', 'TIPO PERIODO', 'TEXTO', 'DIA', 'TIPO DE PERIODO A CONSIDERAR (DIA, MES, AÑO)')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('VENTAS_DEL_PERIODO', 'Movs. de Venta que suman', 'TEXTO', 'Factura;Factura Flexible;Factura Prorrateada', 'Movimientos de Venta que suman ventas separados por un ;')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('VENTAS_DEL_PERIODO', 'Movs. de Venta que restan', 'TEXTO', 'Cancelacion Factura;Devolucion Venta;Bonificacion Venta', 'Movimientos de Venta que restan ventas separados por un ;')  
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('VENTAS_DEL_PERIODO', 'Movs. de Cxc que suman', 'TEXTO', '', 'Movimientos de Cxc que suman ventas separados por un ;')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('VENTAS_DEL_PERIODO', 'Movs. de Cxc que restan', 'TEXTO', '', 'Movimientos de Cxc que restan ventas separados por un ;')  
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('VENTAS_DEL_PERIODO', 'Estatus de Venta que suman', 'TEXTO', 'CONCLUIDO', 'Estatus de Venta que suman ventas separados por un ;')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('VENTAS_DEL_PERIODO', 'Estatus de Venta que restan', 'TEXTO', 'CONCLUIDO', 'Estatus de Venta que restan ventas separados por un ;')  
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('VENTAS_DEL_PERIODO', 'Estatus de Cxc que suman', 'TEXTO', '', 'Estatus de Cxc que suman ventas separados por un ;')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('VENTAS_DEL_PERIODO', 'Estatus de Cxc que restan', 'TEXTO', '', 'Estatus de Cxc que restan ventas separados por un ;')  

  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('VENTAS_DEL_PERIODO', 'TIPO PERIODO', 'DIA')
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('VENTAS_DEL_PERIODO', 'TIPO PERIODO', 'MES')  
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('VENTAS_DEL_PERIODO', 'TIPO PERIODO', 'AÑO')    
    
  INSERT NotificacionClaveConsulta (Clave, ConsultaNombre, Consulta) VALUES ('VENTAS_DEL_PERIODO', 'Ventas_Del_Periodo_Fecha_Final', '(SELECT RTRIM(LTRIM(CONVERT(varchar,dbo.fnNotificacionParamCalcPeriodoFecha(''FINAL'',<Notificacion>,<FechaEmision>,''NUMERO PERIODOS'',''TIPO PERIODO''),103))))')
  INSERT NotificacionClaveConsulta (Clave, ConsultaNombre, Consulta) VALUES ('VENTAS_DEL_PERIODO', 'Ventas_Del_Periodo_Fecha_Inicial', '(SELECT RTRIM(LTRIM(CONVERT(varchar,dbo.fnNotificacionParamCalcPeriodoFecha(''INICIAL'',<Notificacion>,<FechaEmision>,''NUMERO PERIODOS'',''TIPO PERIODO''),103))))')  
  INSERT NotificacionClaveConsulta (Clave, ConsultaNombre, Consulta) VALUES ('VENTAS_DEL_PERIODO', 'Ventas_Del_Periodo_Ingresos', '(SELECT RTRIM(LTRIM(CONVERT(varchar,dbo.fnNotificacionVentasDelPeriodoIngresos(<Notificacion>,<Empresa>,<FechaEmision>)))))')  
  INSERT NotificacionClaveConsulta (Clave, ConsultaNombre, Consulta) VALUES ('VENTAS_DEL_PERIODO', 'Ventas_Del_Periodo_Egresos', '(SELECT RTRIM(LTRIM(CONVERT(varchar,dbo.fnNotificacionVentasDelPeriodoEgresos(<Notificacion>,<Empresa>,<FechaEmision>)))))')    
  INSERT NotificacionClaveConsulta (Clave, ConsultaNombre, Consulta) VALUES ('VENTAS_DEL_PERIODO', 'Ventas_Del_Periodo_Total', '(SELECT RTRIM(LTRIM(CONVERT(varchar,dbo.fnNotificacionVentasDelPeriodoTotal(<Notificacion>,<Empresa>,<FechaEmision>)))))')      

  INSERT NotificacionClaveFiltro (Clave,                Empresa,   Sucursal,  UEN,       Usuario,   Modulo,    Movimiento,     Estatus,     Situacion, Proyecto,  ContactoTipo, Contacto,  ImporteMin, ImporteMax, ValidarAlEmitir)
                          VALUES ('VENTAS_DEL_PERIODO', '(TODOS)', '(TODOS)', '(TODOS)', '(TODOS)', '(TODOS)', 'Notificacion', 'CONCLUIDO', '(TODOS)', '(TODOS)', '(TODOS)',    '(TODOS)', 0.0,        0.0,        1)                                  
END
GO

/*********************** COMPRAS_DEL_PERIODO ***********************/

/**************** fnNotificacionComprasDelPeriodoEgresos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionComprasDelPeriodoEgresos') DROP FUNCTION fnNotificacionComprasDelPeriodoEgresos
GO
CREATE FUNCTION fnNotificacionComprasDelPeriodoEgresos 
	(
	@Notificacion		varchar(50),
	@Empresa			varchar(5),
	@FechaEmision		datetime
	)
	
RETURNS float

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado		float,
  @ImporteCOMS		float,
  @ImporteCXP		float
  
  SET @FechaEmision = dbo.fnFechaSinHora(@FechaEmision)
  
  SELECT 
    @ImporteCOMS = SUM(ISNULL(Importe,0.0)) 
    FROM Compra 
    WHERE Mov IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Movs. de compra que suman'))        
      AND Estatus IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Estatus de compra que suman'))    
      AND FechaEmision BETWEEN dbo.fnNotificacionParamCalcPeriodoFecha('INICIAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO') AND dbo.fnNotificacionParamCalcPeriodoFecha('FINAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO')
      AND Empresa = @Empresa
      
  SET @Resultado = ISNULL(@ImporteCOMS,0.0)

  SELECT 
    @ImporteCOMS = SUM(ISNULL(Importe,0.0)) 
    FROM Cxp 
    WHERE Mov IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Movs. de Cxp que suman'))        
      AND Estatus IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Estatus de Cxp que suman'))    
      AND FechaEmision BETWEEN dbo.fnNotificacionParamCalcPeriodoFecha('INICIAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO') AND dbo.fnNotificacionParamCalcPeriodoFecha('FINAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO')
      AND Empresa = @Empresa
      
  SET @Resultado = @Resultado + ISNULL(@ImporteCOMS,0.0)

      
  RETURN ISNULL(@Resultado,0.0)
END
GO

--SELECT dbo.fnNotificacionComprasDelPeriodoEgresos('Compras Del Periodo','DEMO',GETDATE()) 

/**************** fnNotificacionComprasDelPeriodoIngresos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionComprasDelPeriodoIngresos') DROP FUNCTION fnNotificacionComprasDelPeriodoIngresos
GO
CREATE FUNCTION fnNotificacionComprasDelPeriodoIngresos 
	(
	@Notificacion		varchar(50),
	@Empresa			varchar(5),
	@FechaEmision		datetime
	)
	
RETURNS float

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado		float,
  @ImporteCOMS		float,
  @ImporteCXP		float
  
  SET @FechaEmision = dbo.fnFechaSinHora(@FechaEmision)
  
  SELECT 
    @ImporteCOMS = SUM(ISNULL(Importe,0.0)) 
    FROM Compra 
    WHERE Mov IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Movs. de compra que restan'))        
      AND Estatus IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Estatus de compra que restan'))    
      AND FechaEmision BETWEEN dbo.fnNotificacionParamCalcPeriodoFecha('INICIAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO') AND dbo.fnNotificacionParamCalcPeriodoFecha('FINAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO')
      AND Empresa = @Empresa
      
  SET @Resultado = ISNULL(@ImporteCOMS,0.0)

  SELECT 
    @ImporteCOMS = SUM(ISNULL(Importe,0.0)) 
    FROM Cxp 
    WHERE Mov IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Movs. de Cxp que restan'))        
      AND Estatus IN (SELECT Valor FROM dbo.fnNotificacionParamValoresEnTabla(@Notificacion,'Estatus de Cxp que restan'))    
      AND FechaEmision BETWEEN dbo.fnNotificacionParamCalcPeriodoFecha('INICIAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO') AND dbo.fnNotificacionParamCalcPeriodoFecha('FINAL',@Notificacion,@FechaEmision,'NUMERO PERIODOS','TIPO PERIODO')
      AND Empresa = @Empresa
      
  SET @Resultado = @Resultado + ISNULL(@ImporteCOMS,0.0)

      
  RETURN ISNULL(@Resultado,0.0)
END
GO

--SELECT dbo.fnNotificacionComprasDelPeriodoIngresos('Compras Del Periodo','DEMO',GETDATE()) 

/**************** fnNotificacionComprasDelPeriodoTotal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionComprasDelPeriodoTotal') DROP FUNCTION fnNotificacionComprasDelPeriodoTotal
GO
CREATE FUNCTION fnNotificacionComprasDelPeriodoTotal 
	(
	@Notificacion		varchar(50),
	@Empresa			varchar(5),
	@FechaEmision		datetime
	)
	
RETURNS float

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado		float,
  @ImporteIngresos	float,
  @ImporteEgresos	float
  
  SET @FechaEmision = dbo.fnFechaSinHora(@FechaEmision)
  
  SET @ImporteEgresos = dbo.fnNotificacionComprasDelPeriodoEgresos(@Notificacion,@Empresa,@FechaEmision) 
        
  SET @ImporteIngresos = dbo.fnNotificacionComprasDelPeriodoIngresos(@Notificacion,@Empresa,@FechaEmision) 
  
  SET @Resultado = ISNULL(@ImporteEgresos,0.0) - ISNULL(@ImporteIngresos,0.0)

      
  RETURN ISNULL(@Resultado,0.0)
END
GO

/*
DELETE FROM NotificacionClave WHERE Clave = 'COMPRAS_DEL_PERIODO'
DELETE FROM NotificacionClaveModulo WHERE Clave = 'COMPRAS_DEL_PERIODO'
DELETE FROM NotificacionClaveModuloEstatus WHERE Clave = 'COMPRAS_DEL_PERIODO'
DELETE FROM NotificacionClaveParam WHERE Clave = 'COMPRAS_DEL_PERIODO'
DELETE FROM NotificacionClaveParamAyuda WHERE Clave = 'COMPRAS_DEL_PERIODO'
DELETE FROM NotificacionClaveConsulta WHERE Clave = 'COMPRAS_DEL_PERIODO'
DELETE FROM NotificacionClaveDestinatario WHERE Clave = 'COMPRAS_DEL_PERIODO'
DELETE FROM NotificacionClaveFiltro WHERE Clave = 'COMPRAS_DEL_PERIODO'
*/

IF NOT EXISTS(SELECT 1 FROM NotificacionClave WHERE Clave = 'COMPRAS_DEL_PERIODO')
BEGIN
  INSERT NotificacionClave (Clave,                 Descripcion,                                                     Asunto, Mensaje, MedioComunicacion, TipoFechaNotificacion, FechaNotificacion, AnticipacionFechaTipo, AnticipacionFecha, Frecuencia, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo, DiaMes, FechaInicio)
                    VALUES ('COMPRAS_DEL_PERIODO', 'Notificación que reporta las compras de un periodo determinado', 
                            'Compras <Empresa> - Del <Compras_Del_Periodo_Fecha_Inicial> al <Compras_Del_Periodo_Fecha_Final>', 
                            'Compras <Empresa> - Del <Compras_Del_Periodo_Fecha_Inicial> al <Compras_Del_Periodo_Fecha_Final>:<BR><BR>' + CHAR(13) +
                            'Empresa:   <EmpresaNombre><BR><BR>' + CHAR(10) + CHAR(13) +
                            'Egresos:   <Compras_Del_Periodo_Egresos><BR>' + CHAR(10) + CHAR(13) +                                                                                    
                            'Ingresos:  <Compras_Del_Periodo_Ingresos><BR>' + CHAR(10) + CHAR(13) +                            
                            'Total:     <Compras_Del_Periodo_Total><BR><BR>' + CHAR(10) + CHAR(13) +                                                                                    
                            'INTELISIS ERP<BR>',                                                                                    
                            'Email', '(Emision)', NULL, 'Aplazar', 0, '(Diaria)', 1, 1, 1, 1, 1, 1, 1, NULL, NULL)
  
  INSERT NotificacionClaveModulo (Clave, Modulo) VALUES ('COMPRAS_DEL_PERIODO', 'GES')   
  
  INSERT NotificacionClaveModuloEstatus (Clave, Modulo, Estatus) VALUES ('COMPRAS_DEL_PERIODO', 'GES', 'CONCLUIDO')
  
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('COMPRAS_DEL_PERIODO', 'NUMERO PERIODOS', 'NUMERO', 1, 'NUMERO DE PERIODOS A CONSIDERAR')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('COMPRAS_DEL_PERIODO', 'TIPO PERIODO', 'TEXTO', 'DIA', 'TIPO DE PERIODO A CONSIDERAR (DIA, MES, AÑO)')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('COMPRAS_DEL_PERIODO', 'Movs. de Compra que suman', 'TEXTO', 'Entrada Compra;Entrada Consignacion;Entrada con Gastos;Entrada Importacion;Gasto Diverso;Gasto Extemporaneo', 'Movimientos de Compra que suman compras separados por un ;')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('COMPRAS_DEL_PERIODO', 'Movs. de Compra que restan', 'TEXTO', 'Devolucion Compra;Dev. Compra Consig.;Devolucion Garantia', 'Movimientos de Compra que restan compras separados por un ;')  
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('COMPRAS_DEL_PERIODO', 'Movs. de Cxp que suman', 'TEXTO', '', 'Movimientos de Cxp que suman compras separados por un ;')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('COMPRAS_DEL_PERIODO', 'Movs. de Cxp que restan', 'TEXTO', '', 'Movimientos de Cxp que restan compras separados por un ;')  
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('COMPRAS_DEL_PERIODO', 'Estatus de Compra que suman', 'TEXTO', 'CONCLUIDO', 'Estatus de Compra que suman compras separados por un ;')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('COMPRAS_DEL_PERIODO', 'Estatus de Compra que restan', 'TEXTO', 'CONCLUIDO', 'Estatus de Compra que restan compras separados por un ;')  
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('COMPRAS_DEL_PERIODO', 'Estatus de Cxp que suman', 'TEXTO', '', 'Estatus de Cxp que suman compras separados por un ;')
  INSERT NotificacionClaveParam (Clave, Parametro, Tipo, ValorOmision, Descripcion) VALUES ('COMPRAS_DEL_PERIODO', 'Estatus de Cxp que restan', 'TEXTO', '', 'Estatus de Cxp que restan compras separados por un ;')  

  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('COMPRAS_DEL_PERIODO', 'TIPO PERIODO', 'DIA')
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('COMPRAS_DEL_PERIODO', 'TIPO PERIODO', 'MES')  
  INSERT NotificacionClaveParamAyuda (Clave, Parametro, Valor) VALUES ('COMPRAS_DEL_PERIODO', 'TIPO PERIODO', 'AÑO')    
    
  INSERT NotificacionClaveConsulta (Clave, ConsultaNombre, Consulta) VALUES ('COMPRAS_DEL_PERIODO', 'Compras_Del_Periodo_Fecha_Final', '(SELECT RTRIM(LTRIM(CONVERT(varchar,dbo.fnNotificacionParamCalcPeriodoFecha(''FINAL'',<Notificacion>,<FechaEmision>,''NUMERO PERIODOS'',''TIPO PERIODO''),103))))')
  INSERT NotificacionClaveConsulta (Clave, ConsultaNombre, Consulta) VALUES ('COMPRAS_DEL_PERIODO', 'Compras_Del_Periodo_Fecha_Inicial', '(SELECT RTRIM(LTRIM(CONVERT(varchar,dbo.fnNotificacionParamCalcPeriodoFecha(''INICIAL'',<Notificacion>,<FechaEmision>,''NUMERO PERIODOS'',''TIPO PERIODO''),103))))')  
  INSERT NotificacionClaveConsulta (Clave, ConsultaNombre, Consulta) VALUES ('COMPRAS_DEL_PERIODO', 'Compras_Del_Periodo_Ingresos', '(SELECT RTRIM(LTRIM(CONVERT(varchar,dbo.fnNotificacionComprasDelPeriodoIngresos(<Notificacion>,<Empresa>,<FechaEmision>)))))')  
  INSERT NotificacionClaveConsulta (Clave, ConsultaNombre, Consulta) VALUES ('COMPRAS_DEL_PERIODO', 'Compras_Del_Periodo_Egresos', '(SELECT RTRIM(LTRIM(CONVERT(varchar,dbo.fnNotificacionComprasDelPeriodoEgresos(<Notificacion>,<Empresa>,<FechaEmision>)))))')    
  INSERT NotificacionClaveConsulta (Clave, ConsultaNombre, Consulta) VALUES ('COMPRAS_DEL_PERIODO', 'Compras_Del_Periodo_Total', '(SELECT RTRIM(LTRIM(CONVERT(varchar,dbo.fnNotificacionComprasDelPeriodoTotal(<Notificacion>,<Empresa>,<FechaEmision>)))))')      

  INSERT NotificacionClaveFiltro (Clave,                 Empresa,   Sucursal,  UEN,       Usuario,   Modulo,    Movimiento,     Estatus,     Situacion, Proyecto,  ContactoTipo, Contacto,  ImporteMin, ImporteMax, ValidarAlEmitir)
                          VALUES ('COMPRAS_DEL_PERIODO', '(TODOS)', '(TODOS)', '(TODOS)', '(TODOS)', '(TODOS)', 'Notificacion', 'CONCLUIDO', '(TODOS)', '(TODOS)', '(TODOS)',    '(TODOS)', 0.0,        0.0,        1)                                  
END
GO

/*
truncate table notificacionclave
truncate table notificacionclavedestinatario
truncate table notificacionclaveparam
truncate table notificacionclaveparamayuda
*/

