-- 11326
/**************** fnNotificacionTagAyuda ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionTagAyuda' AND type = 'TF') DROP FUNCTION fnNotificacionTagAyuda
GO
CREATE FUNCTION fnNotificacionTagAyuda (@Notificacion varchar(55))
RETURNS @Resultado 
  TABLE (Notificacion varchar(55), Tag varchar(100), Asunto bit NULL, Mensaje bit NULL, Consulta bit NULL, Condicion bit NULL, Descripcion varchar(100) NULL)
--//WITH ENCRYPTION
AS BEGIN

  INSERT INTO @Resultado(
          Notificacion,  Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion)
   SELECT @Notificacion, Tag, Asunto, Mensaje, Consulta, Condicion, Descripcion
     FROM NotificacionTagAyuda
   UNION ALL
   SELECT Notificacion, '<' + ConsultaNombre + '>', NULL, NULL, NULL, NULL, NULL
     FROM NotificacionConsulta
    WHERE Notificacion = @Notificacion
     
  RETURN
END
GO

/**************** fnNotificacionParamCalcPeriodoFecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionParamCalcPeriodoFecha') DROP FUNCTION fnNotificacionParamCalcPeriodoFecha
GO
CREATE FUNCTION fnNotificacionParamCalcPeriodoFecha 
	(
	@Tipo					varchar(20),
	@Notificacion			varchar(50),
	@Fecha					datetime,
	@ParamNumeroPeriodos	varchar(100),
	@ParamTipoPeriodo		varchar(100)
	)
	
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado				datetime,
    @FechaFinal				datetime,
	@FechaInicial			datetime,
	@NotificacionClave		varchar(50),
	@NumeroPeriodos			int,
	@PeriodoTipo			varchar(255)
	
  SET @FechaFinal = dbo.fnFechaSinHora(DATEADD(DD,-1,@Fecha))
  
  SET @Resultado = NULL
  
  SELECT @NotificacionClave = Clave FROM Notificacion WHERE LTRIM(RTRIM(Notificacion)) = @Notificacion
    
  SELECT @NumeroPeriodos = CONVERT(int,ISNULL(Valor,1)) FROM NotificacionParam WHERE Notificacion = @Notificacion AND Parametro = @ParamNumeroPeriodos
  IF @@ERROR <> 0 SET @NumeroPeriodos = 1
    
  SELECT @PeriodoTipo = ISNULL(NULLIF(Valor,''),'DIA') FROM NotificacionParam WHERE Notificacion = @Notificacion AND Parametro = @ParamTipoPeriodo

  IF @PeriodoTipo NOT IN ('DIA','MES','AÑO') SET @PeriodoTipo = 'DIA'    

  IF @NumeroPeriodos >= 1 SET @NumeroPeriodos = @NumeroPeriodos -1 ELSE
  IF @NumeroPeriodos < 0 SET @NumeroPeriodos = 0       
  
  IF @Tipo = 'FINAL'
  BEGIN
    SET @Resultado = @FechaFinal
  END ELSE
  BEGIN
    IF @Tipo = 'INICIAL'
    BEGIN
      IF @PeriodoTipo = 'DIA' 
      BEGIN
        SET @Resultado = DATEADD(dd,0-@NumeroPeriodos,@FechaFinal)
      END ELSE 
      IF @PeriodoTipo = 'MES' 
      BEGIN
        SET @FechaInicial = DATEADD(dd,0-(DAY(@FechaFinal)-1),@FechaFinal)
        SET @Resultado = DATEADD(mm,0-@NumeroPeriodos,@FechaInicial)
      END ELSE  
      IF @PeriodoTipo = 'AÑO' 
      BEGIN      
        SET @FechaInicial = DATEADD(dd,0-(DAY(@FechaFinal)-1),@FechaFinal)
        SET @FechaInicial = DATEADD(mm,0-(MONTH(@FechaInicial)-1),@FechaInicial)      
        SET @Resultado = DATEADD(yy,0-@NumeroPeriodos,@FechaInicial)
      END  
    END
  END
  RETURN (@Resultado)
END
GO

-- SELECT dbo.fnNotificacionParamCalcPeriodoFecha('FINAL','Ventas Del Periodo',GETDATE(),'NUMERO PERIODOS','TIPO PERIODO')
-- SELECT dbo.fnNotificacionParamCalcPeriodoFecha('INICIAL','Ventas Del Periodo',GETDATE(),'NUMERO PERIODOS','TIPO PERIODO')

/**************** fnNotificacionParamValoresEnTabla ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionParamValoresEnTabla') DROP FUNCTION fnNotificacionParamValoresEnTabla
GO
CREATE FUNCTION fnNotificacionParamValoresEnTabla 
	(
	@Notificacion		varchar(50), 
	@Parametro			varchar(100)
	)
RETURNS @Valores TABLE
        (
		Valor			varchar(255)
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Valor			varchar(max),
  @Longitud			bigint,
  @Contador			bigint,
  @Caracter			char(1),
  @ValorActual		varchar(255),
  @Estado			int,
  @EstadoAnterior	int

  SELECT @Valor = Valor FROM NotificacionParam WHERE Notificacion = @Notificacion AND Parametro = @Parametro
  SELECT @Longitud = LEN(@Valor), @Contador = 1, @Caracter = NULL, @ValorActual = '', @Estado = 0
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @Caracter = SUBSTRING(@Valor,@Contador,1)
    SET @EstadoAnterior = @Estado    
    SET @Estado = CASE 
      WHEN @Estado = 0 AND @Caracter = ';'         THEN 1
      ELSE @Estado
    END

    IF @Estado = 0
    BEGIN
      SET @ValorActual = @ValorActual + @Caracter
    END ELSE
    IF @Estado = 1
    BEGIN
      INSERT @Valores (Valor) VALUES (RTRIM(LTRIM(@ValorActual)))
      SET @ValorActual = ''
      SET @Estado = 0
    END
    
    SET @Contador = @Contador + 1
  END

  IF LEN(@ValorActual) > 0 
  BEGIN
    INSERT @Valores (Valor) VALUES (@ValorActual)
  END
          
  RETURN
END
GO

--select Valor from dbo.fnNotificacionParamValoresEnTabla('Ventas Del Periodo','Movs. de venta que suman')
--select Valor from dbo.fnNotificacionParamValoresEnTabla('Ventas Del Periodo','Movs. de venta que restan')
--select Valor from dbo.fnNotificacionParamValoresEnTabla('Ventas Del Periodo','Movs. de Cxc que suman')
--SELECT Valor from dbo.fnNotificacionParamValoresEnTabla('Ventas Del Periodo','Movs. de Cxc que restan')

--select Valor from dbo.fnNotificacionParamValoresEnTabla('Ventas Del Periodo','Estatus de venta que suman')
--select Valor from dbo.fnNotificacionParamValoresEnTabla('Ventas Del Periodo','Estatus de venta que restan')
--select Valor from dbo.fnNotificacionParamValoresEnTabla('Ventas Del Periodo','Estatus. de Cxc que suman')
--SELECT Valor from dbo.fnNotificacionParamValoresEnTabla('Ventas Del Periodo','Estatus de Cxc que restan')

/******************************* spValidarCadenaAutorizacion *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spValidarCadenaAutorizacion') AND TYPE = 'P')
DROP PROCEDURE spValidarCadenaAutorizacion
GO

CREATE PROCEDURE spValidarCadenaAutorizacion
  (
  @CadenaAutorizacion			varchar(max),
  @Tipo							varchar(50) = NULL OUTPUT,
  @Empresa						varchar(5) = NULL OUTPUT,
  @Sucursal						int = NULL OUTPUT,  
  @Modulo						varchar(5) = NULL OUTPUT,
  @ID							int = NULL OUTPUT,
  @Estatus						varchar(15) = NULL OUTPUT,  
  @Situacion					varchar(50) = NULL OUTPUT,    
  @Usuario						varchar(10) = NULL OUTPUT,      
  @CheckSum						int = NULL OUTPUT,
  @CadenaAutorizacionValida		bit = 0 OUTPUT        
  )
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Largo									int,
	@Contador								int,
	@Caracter								char(1),
	@Modo									int,
	@Campo									varchar(255),
	@CheckSumNuevo							int
				
  SELECT @Largo = LEN(@CadenaAutorizacion), @Contador = 1, @Modo = -1, @Campo = '', @CheckSumNuevo = NULL

  WHILE @Contador <= @Largo
  BEGIN
    SET @Caracter = SUBSTRING(@CadenaAutorizacion,@Contador,1)
    IF @Caracter = CHAR(124)  AND @Modo = -1  SET @Modo = 0   ELSE
    IF @Caracter <> CHAR(124) AND @Modo = 0   SET @Modo = -1  ELSE    
    IF @Caracter = CHAR(124)  AND @Modo = 0   SET @Modo = 1   ELSE        
    IF @Caracter = CHAR(124)  AND @Modo = 1   SET @Modo = 2   ELSE        
    IF @Caracter = CHAR(124)  AND @Modo = 2   SET @Modo = 3   ELSE            
    IF @Caracter = CHAR(124)  AND @Modo = 3   SET @Modo = 4   ELSE                
    IF @Caracter = CHAR(124)  AND @Modo = 4   SET @Modo = 5   ELSE                    
    IF @Caracter = CHAR(124)  AND @Modo = 5   SET @Modo = 6   ELSE                        
    IF @Caracter = CHAR(124)  AND @Modo = 6   SET @Modo = 7   ELSE                            
    IF @Caracter = CHAR(124)  AND @Modo = 7   SET @Modo = 8   ELSE                                
    IF @Caracter = CHAR(124)  AND @Modo = 8   SET @Modo = 9   ELSE                                    
    IF @Caracter = CHAR(124)  AND @Modo = 9   SET @Modo = 10  ELSE
    IF @Caracter = CHAR(124)  AND @Modo = 10   SET @Modo = 11 

    IF @Modo = 1
    BEGIN
      IF @Caracter = CHAR(124) 
        SET @Campo = ''
      ELSE IF @Caracter <> CHAR(124) 
        SET @Campo = @Campo + @Caracter
    END ELSE
    IF @Modo = 2
    BEGIN
      IF @Caracter = CHAR(124)
      BEGIN
        SET @Tipo = @Campo 
        SET @Campo = ''
      END  
      ELSE IF @Caracter <> CHAR(124) 
        SET @Campo = @Campo + @Caracter
    END ELSE
    IF @Modo = 3
    BEGIN
      IF @Caracter = CHAR(124)
      BEGIN
        SET @Empresa = @Campo 
        SET @Campo = ''
      END  
      ELSE IF @Caracter <> CHAR(124) 
        SET @Campo = @Campo + @Caracter
    END ELSE
    IF @Modo = 4
    BEGIN
      IF @Caracter = CHAR(124)
      BEGIN
        SET @Sucursal = CONVERT(int,@Campo) 
        SET @Campo = ''
      END  
      ELSE IF @Caracter <> CHAR(124) 
        SET @Campo = @Campo + @Caracter
    END ELSE
    IF @Modo = 5
    BEGIN
      IF @Caracter = CHAR(124)
      BEGIN
        SET @Modulo = @Campo 
        SET @Campo = ''
      END  
      ELSE IF @Caracter <> CHAR(124) 
        SET @Campo = @Campo + @Caracter
    END ELSE
    IF @Modo = 6
    BEGIN
      IF @Caracter = CHAR(124)
      BEGIN
        SET @ID = CONVERT(int,@Campo) 
        SET @Campo = ''
      END  
      ELSE IF @Caracter <> CHAR(124) 
        SET @Campo = @Campo + @Caracter
    END ELSE
    IF @Modo = 7
    BEGIN
      IF @Caracter = CHAR(124)
      BEGIN
        SET @Estatus = @Campo 
        SET @Campo = ''
      END  
      ELSE IF @Caracter <> CHAR(124) 
        SET @Campo = @Campo + @Caracter
    END ELSE
    IF @Modo = 8
    BEGIN
      IF @Caracter = CHAR(124)
      BEGIN
        SET @Situacion = @Campo 
        SET @Campo = ''
      END  
      ELSE IF @Caracter <> CHAR(124) 
        SET @Campo = @Campo + @Caracter
    END ELSE
    IF @Modo = 9
    BEGIN
      IF @Caracter = CHAR(124)
      BEGIN
        SET @Usuario = @Campo 
        SET @Campo = ''
      END  
      ELSE IF @Caracter <> CHAR(124) 
        SET @Campo = @Campo + @Caracter
    END ELSE
    IF @Modo = 10
    BEGIN
      IF @Caracter = CHAR(124)
      BEGIN
        SET @Checksum = CONVERT(int,@Campo) 
        SET @Campo = ''
      END  
      ELSE IF @Caracter <> CHAR(124) 
        SET @Campo = @Campo + @Caracter
    END
    
    SET @Contador = @Contador + 1	    
  END

  SET @ChecksumNuevo = CHECKSUM(SUBSTRING(@Tipo,1,3) + LTRIM(RTRIM(@@SERVERNAME)) + LTRIM(RTRIM(DB_NAME())) + @Empresa + LTRIM(RTRIM(CONVERT(varchar,@Sucursal))) + @Modulo + LTRIM(RTRIM(CONVERT(varchar,@ID))) + @Estatus + @Situacion + @Usuario)  
  
  IF @CheckSum <> @CheckSumNuevo 
    SELECT @CadenaAutorizacionValida = 0
  ELSE
    SELECT @CadenaAutorizacionValida = 1  
END
GO

/*

DECLARE
  @Tipo							varchar(50),
  @Empresa						varchar(5),
  @Sucursal						int,  
  @Modulo						varchar(5),
  @ID							int,
  @Estatus						varchar(15),  
  @Situacion					varchar(50),    
  @Usuario						varchar(10),
  @CheckSum						int,
  @CadenaAutorizacionValida		bit

SET @CadenaAutorizacionValida = 0
EXEC spValidarCadenaAutorizacion '||AUTORIZACION|DEMO|0|VTAS|1|PENDIENTE|POR AUTORIZAR|DEMO|567807976||fin del mensaje', @Tipo OUTPUT, @Empresa OUTPUT, @Sucursal OUTPUT, @Modulo OUTPUT, @ID OUTPUT, @Estatus OUTPUT, @Situacion OUTPUT, @Usuario OUTPUT, @CheckSum OUTPUT, @CadenaAutorizacionValida OUTPUT
SELECT @Tipo, @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @Situacion, @Usuario, @Checksum, @CadenaAutorizacionValida

*/

/**************** spNotificacionCrearJobs ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionCrearJobs') and type = 'P') drop procedure dbo.spNotificacionCrearJobs
GO             
CREATE PROCEDURE spNotificacionCrearJobs
  @Nombre   varchar(100),
  @BaseDatos        varchar(30),
  @UsuarioI         varchar(30)
 
 
--//WITH ENCRYPTION
AS
  DECLARE
  @TrabajoID        binary (16),
  @ReturnCode       int,
  @Usuario                 varchar(30),
  @Contrasena       varchar(30),
  @Activo                  bit,
  @Trabajo                 char(20),
  @Cadena                  varchar(100),
  @Servidor                varchar(30),   
  @HoraInicial             int,
  @HoraFinal        int,
  @Frecuencia       tinyint,
  @Valor                   tinyint,
  @Recurrencia             tinyint, 
  @FrecuenciaD             tinyint,
  @ValorD                  tinyint,
 
  @Domingo                 bit,
  @Lunes                   bit,
  @Martes                  bit,
  @Miercoles        bit,
  @Jueves                  bit,
  @Viernes                 bit,
  @Sabado                  bit,
  @Valor2                  tinyint,
  @Tipo                           tinyint,
  @Dia                     tinyint,
  @Fecha2                  int,
 
  @Estatus                 bit,
 
  @spSucursal       int,
  @spEmpresa        varchar(5),
  @spUsuario        varchar(30),
  @spFecha                 datetime,
  @NombreOriginal   varchar(100),
  @Procesar                varchar(30)
 
  BEGIN TRANSACTION
    DECLARE @SQLServerAgent TABLE
    (
    Estatus                       varchar(50)
    )
 
    SELECT @NombreOriginal = ISNULL(@Nombre,'')
    SELECT @Nombre = ISNULL(@Nombre,'') + '.' + @@SERVERNAME + '.' + @BaseDatos
    SELECT @ReturnCode = 0    
    IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = '[Uncategorized (Local)]') < 1
      EXECUTE msdb.dbo.sp_add_category @name = '[Uncategorized (Local)]'
   
    SELECT @TrabajoID = job_id FROM   msdb.dbo.sysjobs WHERE (name = @Nombre)
    IF (@TrabajoID IS NOT NULL)   
    BEGIN 
       IF (EXISTS (SELECT  * FROM    msdb.dbo.sysjobservers WHERE   (job_id = @TrabajoID) AND (server_id <> 0)))
         BEGIN
            RAISERROR ('Unable to import job ''Notificacion '' since there is already a multi-server job with this name.', 16, 1)
            SELECT @ReturnCode = 1    
         END
       ELSE
         EXECUTE msdb.dbo.sp_delete_job @job_name = @Nombre
      SELECT @TrabajoID = NULL
    END
 
 
  IF (@@ERROR = 0 AND @ReturnCode = 0) AND EXISTS(SELECT * FROM NotificacionTrabajo WHERE Trabajo = @NombreOriginal)
  BEGIN
    IF @ReturnCode = 0
      EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @TrabajoID OUTPUT , @job_name = @Nombre, @owner_login_name = @Usuario, @description =  @Nombre, @category_name = '[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
 
       DECLARE crTrabajo SCROLL CURSOR FOR
       SELECT Trabajo, Usuario, Contrasena, CONVERT(int, SUBSTRING(HoraInicial,1,2) + SUBSTRING(HoraInicial,4,2) + '00'), CONVERT(int, SUBSTRING(HoraFinal,1,2) + SUBSTRING(HoraFinal,4,2) + '00'), CASE Frecuencia WHEN 'Diaria' THEN 4 WHEN 'Semanal' THEN 8 WHEN 'Mensual' THEN 16 WHEN 'Mensual 2' THEN 32 END, Valor, Recurrencia, CASE FrecuenciaD WHEN 'Minutos' THEN 4 WHEN 'Horas' THEN 8 END , ValorD, Activo, Domingo, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, CASE Tipo WHEN 'Primer' THEN 1 WHEN 'Segundo' THEN 2 WHEN 'Tercer' THEN 4 WHEN 'Cuarto' THEN 8 WHEN 'Ultimo' THEN 16 END, CASE Dia WHEN 'Domingo' THEN 1 WHEN 'Lunes' THEN 2 WHEN 'Martes' THEN 3 WHEN 'Miercoles' THEN 4 WHEN 'Jueves' THEN 5 WHEN 'Viernes' THEN 6 WHEN 'Sabado' THEN 7 WHEN 'Día' THEN 8 WHEN 'Día de la semana' THEN 9 WHEN 'Día del fin de semana' THEN 10 END, CONVERT(int, CONVERT(varchar,DATEPART(YEAR,FechaInicial)) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(MONTH,FechaInicial)),2) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(DAY,FechaInicial)),2)), spSucursal, spEmpresa, spUsuario, GETDATE(), ISNULL(Procesar,'')
         FROM NotificacionTrabajo
       WHERE Trabajo = @NombreOriginal
      
       IF ISNULL(@Contrasena,'') = ''
             SELECT @Contrasena = 'NULL'
 
       OPEN crTrabajo
 
       FETCH NEXT FROM crTrabajo INTO @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2, @spSucursal, @spEmpresa, @spUsuario, @spFecha, @Procesar
 
       WHILE @@FETCH_STATUS = 0 AND @ReturnCode = 0
       BEGIN
--select @Frecuencia = 32
         SELECT @Valor2 = 0
      IF @Frecuencia = 8
      BEGIN
        IF @Domingo = 1
          SELECT @Valor2 = @Valor2 + 1
       
        IF @Lunes = 1
          SELECT @Valor2 = @Valor2 + 2
       
        IF @Martes = 1
          SELECT @Valor2 = @Valor2 + 4
       
        IF @Miercoles = 1
          SELECT @Valor2 = @Valor2 + 8
        
        IF @Jueves = 1
          SELECT @Valor2 = @Valor2 + 16
       
        IF @Viernes = 1
          SELECT @Valor2 = @Valor2 + 32
       
        IF @Sabado = 1
          SELECT @Valor2 = @Valor2 + 64
     
        SELECT @Valor = @Valor2
      END
 
      ELSE
      IF @Frecuencia = 32
        SELECT @Valor = @Dia
 
         IF @Procesar = 'Procesar Correos'
           SET @cadena     = 'EXEC spProcesarCorreo ' + '''' + RTRIM(@spUsuario) + ''''
         ELSE  
           SET @cadena     = 'EXEC spNotificacionCerrarDia ' + '''' + RTRIM(@spSucursal) + '''' + ', ' + '''' + RTRIM(@spEmpresa) + '''' + ', ' + '''' + RTRIM(@spUsuario) + '''' + ', ' + '''' + RTRIM(@spFecha) + ''''+ ', NULL, NULL, 0'
 
--       select @Cadena
 
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @TrabajoID, @step_id = 1, @step_name = @Trabajo, @command = @cadena, @database_name = @BaseDatos, @server = '', @database_user_name = '', @subsystem = 'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = '', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
 
         UPDATE NotificacionTrabajo SET UltimaActualizacion = GETDATE() WHERE Trabajo = @Trabajo
        
         FETCH NEXT FROM crTrabajo INTO  @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2, @spSucursal, @spEmpresa, @spUsuario, @spFecha, @Procesar
       END
 
--select @Trabajo Trabajo, @Usuario Usuario, @Contrasena Contrasena, @HoraInicial HoraInicial, @HoraFinal HoraFinal, @Frecuencia Frecuencia, @Valor Valor, @Recurrencia Recurrencia, @FrecuenciaD FrecuenciaD, @ValorD ValorD, @Activo Activo
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @TrabajoID, @start_step_id = 1, @enabled  = @Activo
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @TrabajoID, @name = @Nombre, @enabled = @Activo, @freq_type = @Frecuencia, @active_start_date = @Fecha2, @active_start_time = @HoraInicial, @freq_interval = @Valor, @freq_subday_type = @FrecuenciaD , @freq_subday_interval = @ValorD, @freq_relative_interval = @Tipo, @freq_recurrence_factor = @Recurrencia, @active_end_date = 99991231, @active_end_time = @HoraFinal
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @TrabajoID, @server_name = @@SERVERNAME
 
 
  CLOSE crTrabajo
  DEALLOCATE crTrabajo
--select @ReturnCode = 1
  END 
  INSERT @SQLServerAgent (Estatus)
  EXEC master.dbo.xp_ServiceControl 'QUERYSTATE', 'SQLServerAgent'
 
  IF (SELECT TOP 1 Estatus FROM @SQLServerAgent) = 'Running.' SELECT @Estatus = 1 ELSE SELECT @Estatus = 0
 
  IF @ReturnCode = 0
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    COMMIT TRANSACTION
  END
  ELSE
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    ROLLBACK TRANSACTION
  END
GO
--EXEC spNotificacionCrearJobs 'Notificacion_DEMO_ 0_DEMO', 'informes', 'DEMO'

/*** NotificacionFiltroNormalizada ***/
if exists (select * from sysobjects where id = object_id('dbo.NotificacionFiltroNormalizada') and type = 'V') drop view dbo.NotificacionFiltroNormalizada
GO
CREATE VIEW NotificacionFiltroNormalizada
--//WITH ENCRYPTION
AS 
SELECT 
  nf.Notificacion, 
  nf.RID,
  CONVERT(varchar(5),NULLIF(nf.Empresa,'(TODOS)')) Empresa,
  CONVERT(int,NULLIF(nf.Sucursal,'(TODOS)')) Sucursal,
  CONVERT(int,NULLIF(nf.UEN,'(TODOS)')) UEN,  
  NULLIF(nf.Usuario,'(TODOS)') Usuario,    
  CONVERT(varchar(5),NULLIF(nf.Modulo,'(TODOS)')) Modulo,
  NULLIF(nf.Movimiento,'(TODOS)') Movimiento,            
  e.Estatus Estatus,              
  NULLIF(nf.Situacion,'(TODOS)') Situacion,
  NULLIF(nf.Proyecto,'(TODOS)') Proyecto,
  NULLIF(nf.ContactoTipo,'(TODOS)') ContactoTipo,      
  NULLIF(nf.Contacto,'(TODOS)') Contacto,
  NULLIF(nf.ImporteMin,0.0) ImporteMin,  
  NULLIF(nf.ImporteMax,0.0) ImporteMax,
  ValidarAlEmitir ValidarAlEmitir    
  FROM NotificacionFiltro nf LEFT OUTER JOIN Estatus e
    ON UPPER(RTRIM(e.Nombre)) = UPPER(RTRIM(NULLIF(nf.Estatus,'(TODOS)')))
GO

/******************************* spNotificacionCambiarEstatus *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionCambiarEstatus') and type = 'P') drop procedure dbo.spNotificacionCambiarEstatus
GO             
CREATE PROCEDURE spNotificacionCambiarEstatus
		@Estacion			int,
		@Estatus			varchar(15)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @RID				int,
    @Ok					int,
    @OkRef				varchar(255)
   

  
  DECLARE crListaID CURSOR FOR
   SELECT ID
     FROM ListaID
    WHERE Estacion = @Estacion
    
  OPEN crListaID
  FETCH NEXT FROM crListaID INTO @RID
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN

    UPDATE UsuarioNotificacion SET Estatus = @Estatus WHERE RID = @RID
    
    FETCH NEXT FROM crListaID INTO @RID
  END
  CLOSE crListaID
  DEALLOCATE crListaID         
  
  DELETE FROM ListaID WHERE Estacion = @Estacion
END
GO

/******************************* spNotificacionBorrar *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionBorrar') and type = 'P') drop procedure dbo.spNotificacionBorrar
GO             
CREATE PROCEDURE spNotificacionBorrar
		@Estacion			int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @RID				int,
    @Ok					int,
    @OkRef				varchar(255)
   

  
  DECLARE crListaID CURSOR FOR
   SELECT ID
     FROM ListaID
    WHERE Estacion = @Estacion
    
  OPEN crListaID
  FETCH NEXT FROM crListaID INTO @RID
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN

    DELETE FROM UsuarioNotificacion WHERE RID = @RID
    
    FETCH NEXT FROM crListaID INTO @RID
  END
  CLOSE crListaID
  DEALLOCATE crListaID         
  
  DELETE FROM ListaID WHERE Estacion = @Estacion
END
GO

/**************** fnNotificacionFecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionFecha') DROP FUNCTION fnNotificacionFecha
GO
CREATE FUNCTION fnNotificacionFecha 
	(
    @TipoFechaNotificacion		varchar(50), --(Emision),(Vencimiento),(Especifica)    
    @FechaNotificacion			datetime,
    @AnticipacionFechaTipo		varchar(20),
    @AnticipacionFecha			int,	
	@FechaEmision				datetime,
	@FechaVencimiento			datetime
	)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado			datetime,
  @Hoy					datetime
  
  SET @Hoy = dbo.fnFechaSinHora(GETDATE())
  SET @TipoFechaNotificacion = UPPER(@TipoFechaNotificacion)

  SET @AnticipacionFechaTipo = RTRIM(UPPER(ISNULL(@AnticipacionFechaTipo,'APLAZAR')))
  
  IF @AnticipacionFechaTipo = 'ADELANTAR' SET @AnticipacionFecha = 0 - ISNULL(@AnticipacionFecha,0) ELSE
  IF @AnticipacionFechaTipo = 'APLAZAR'   SET @AnticipacionFecha = ISNULL(@AnticipacionFecha,0)
        
  IF @TipoFechaNotificacion = '(EMISION)' 
  BEGIN    
    SET @Resultado = DATEADD(day,@AnticipacionFecha,ISNULL(@FechaEmision,@Hoy))
    IF @Resultado < @Hoy SET @Resultado = @Hoy   
  END ELSE 
  IF @TipoFechaNotificacion = '(VENCIMIENTO)'
  BEGIN
    SET @Resultado = DATEADD(day,@AnticipacionFecha,ISNULL(ISNULL(@FechaVencimiento,@FechaEmision),@Hoy))
    IF @Resultado < @Hoy SET @Resultado = @Hoy   
  END ELSE
  IF @TipoFechaNotificacion = '(ESPECIFICA)'
  BEGIN
    SET @Resultado = DATEADD(day,@AnticipacionFecha,ISNULL(ISNULL(@FechaNotificacion,@FechaEmision),@Hoy))
    IF @Resultado < @Hoy SET @Resultado = @Hoy       
  END
  RETURN (dbo.fnFechaSinHora(ISNULL(@Resultado,@Hoy)))
END
GO

--SELECT dbo.fnNotificacionFecha('(Emision)','30/08/2011',5,dbo.fnFechaSinHora(GETDATE()),'30/07/2011') 
--SELECT dbo.fnNotificacionFecha('(Especifica)','30/08/2011',5,dbo.fnFechaSinHora(GETDATE()),'30/07/2011') 
--SELECT dbo.fnNotificacionFecha('(Vencimiento)','30/08/2011',5,dbo.fnFechaSinHora(GETDATE()),'30/07/2011') 
--SELECT dbo.fnNotificacionFecha('(Vencimiento)','30/08/2011',5,dbo.fnFechaSinHora(GETDATE()),'10/07/2011') 
--SELECT dbo.fnNotificacionFecha('(Vencimiento)','30/08/2011',5,dbo.fnFechaSinHora(GETDATE()),NULL) 
--SELECT dbo.fnNotificacionFecha('(Especifica)',NULL,5,NULL,NULL) 
--SELECT dbo.fnNotificacionFecha('(Emision)',NULL,5,NULL,NULL) 
--SELECT dbo.fnNotificacionFecha(NULL,NULL,NULL,NULL,NULL) 


/**************** fnNotificacionVigenciaInvalida ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionVigenciaInvalida') DROP FUNCTION fnNotificacionVigenciaInvalida
GO
CREATE FUNCTION fnNotificacionVigenciaInvalida 
	(
	@Estacion					int,
	@Notificacion				varchar(50)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado			bit,
  @RID					int,
  @FechaD				datetime,
  @FechaA				datetime
  
  SET @Resultado = 0
  
  DECLARE crNotificacionVigencia CURSOR FOR
   SELECT RID, dbo.fnFechaSinHora(FechaD), dbo.fnFechaSinHora(FechaA)
     FROM NotificacionVigenciaTemp
    WHERE Notificacion = @Notificacion 
      AND Estacion = @Estacion
      
  OPEN crNotificacionVigencia
  FETCH NEXT FROM crNotificacionVigencia INTO @RID, @FechaD, @FechaA
  WHILE @@FETCH_STATUS = 0 AND @Resultado = 0
  BEGIN
    IF EXISTS(SELECT 1 FROM NotificacionVigenciaTemp WHERE Notificacion = @Notificacion AND RID <> @RID AND @FechaD BETWEEN dbo.fnFechaSinHora(FechaD) AND dbo.fnFechaSinHora(FechaA) AND Estacion = @Estacion) SET @Resultado = 1    
    IF @Resultado = 0 AND EXISTS(SELECT 1 FROM NotificacionVigenciaTemp WHERE Notificacion = @Notificacion AND RID <> @RID AND @FechaA BETWEEN dbo.fnFechaSinHora(FechaD) AND dbo.fnFechaSinHora(FechaA) AND Estacion = @Estacion) SET @Resultado = 1
    IF @Resultado = 0 AND @FechaA < @FechaD SET @Resultado = 1  
    FETCH NEXT FROM crNotificacionVigencia INTO @RID, @FechaD, @FechaA
  END
  CLOSE crNotificacionVigencia
  DEALLOCATE crNotificacionVigencia

  RETURN (@Resultado)
END
GO

--select dbo.fnNotificacionVigenciaInvalida('Notificacion Generica')

/**************** fnNotificacionVigenciaHoraInvalida ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionVigenciaHoraInvalida') DROP FUNCTION fnNotificacionVigenciaHoraInvalida
GO
CREATE FUNCTION fnNotificacionVigenciaHoraInvalida 
	(
	@Estacion					int,
	@Notificacion				varchar(50)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado			bit,
  @RID					int,
  @HoraD				int,
  @HoraA				int
  
  SET @Resultado = 0
  
  DECLARE crNotificacionVigenciaHora CURSOR FOR
   SELECT RID, dbo.fnHoraEnEntero(HoraD), dbo.fnHoraEnEntero(HoraA)
     FROM NotificacionVigenciaHoraTemp
    WHERE Notificacion = @Notificacion 
      AND Estacion = @Estacion
      
  OPEN crNotificacionVigenciaHora
  FETCH NEXT FROM crNotificacionVigenciaHora INTO @RID, @HoraD, @HoraA
  WHILE @@FETCH_STATUS = 0 AND @Resultado = 0
  BEGIN
    IF EXISTS(SELECT 1 FROM NotificacionVigenciaHoraTemp WHERE Notificacion = @Notificacion AND RID <> @RID AND @HoraD BETWEEN dbo.fnHoraEnEntero(HoraD) AND dbo.fnHoraEnEntero(HoraA) AND Estacion = @Estacion) SET @Resultado = 1    
    IF @Resultado = 0 AND EXISTS(SELECT 1 FROM NotificacionVigenciaHoraTemp WHERE Notificacion = @Notificacion AND RID <> @RID AND @HoraA BETWEEN dbo.fnHoraEnEntero(HoraD) AND dbo.fnHoraEnEntero(HoraA) AND Estacion = @Estacion) SET @Resultado = 1
    IF @Resultado = 0 AND @HoraA < @HoraD SET @Resultado = 1  
    FETCH NEXT FROM crNotificacionVigenciaHora INTO @RID, @HoraD, @HoraA
  END
  CLOSE crNotificacionVigenciaHora
  DEALLOCATE crNotificacionVigenciaHora

  RETURN (@Resultado)
END
GO

/**************** spNotificacionCargarVigencia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionCargarVigencia') and type = 'P') drop procedure dbo.spNotificacionCargarVigencia
GO             
CREATE PROCEDURE spNotificacionCargarVigencia
		@Estacion			int,
		@Notificacion		varchar(50)
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DELETE FROM NotificacionVigenciaTemp WHERE Estacion = @Estacion AND Notificacion = @Notificacion
  
  INSERT NotificacionVigenciaTemp (Estacion,  Notificacion, FechaD, FechaA)
                           SELECT @Estacion, Notificacion, FechaD, FechaA
                             FROM NotificacionVigencia
                            WHERE Notificacion = @Notificacion
                             
END
GO

/**************** spNotificacionCargarVigenciaHora ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionCargarVigenciaHora') and type = 'P') drop procedure dbo.spNotificacionCargarVigenciaHora
GO             
CREATE PROCEDURE spNotificacionCargarVigenciaHora
		@Estacion			int,
		@Notificacion		varchar(50)
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DELETE FROM NotificacionVigenciaHoraTemp WHERE Estacion = @Estacion AND Notificacion = @Notificacion
  
  INSERT NotificacionVigenciaHoraTemp (Estacion,  Notificacion, HoraD, HoraA)
                               SELECT @Estacion, Notificacion,  HoraD, HoraA
                                 FROM NotificacionVigenciaHora
                                WHERE Notificacion = @Notificacion
                             
END
GO

/**************** spNotificacionGuardarVigencia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionGuardarVigencia') and type = 'P') drop procedure dbo.spNotificacionGuardarVigencia
GO             
CREATE PROCEDURE spNotificacionGuardarVigencia
		@Estacion			int,
		@Notificacion		varchar(50)
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DELETE FROM NotificacionVigencia WHERE Notificacion = @Notificacion
  
  INSERT NotificacionVigencia (Notificacion, FechaD, FechaA)
                       SELECT Notificacion, FechaD, FechaA
                         FROM NotificacionVigenciaTemp
                        WHERE Notificacion = @Notificacion
                          AND Estacion = @Estacion
                             
END
GO


/**************** spNotificacionGuardarVigenciaHora ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionGuardarVigenciaHora') and type = 'P') drop procedure dbo.spNotificacionGuardarVigenciaHora
GO             
CREATE PROCEDURE spNotificacionGuardarVigenciaHora
		@Estacion			int,
		@Notificacion		varchar(50)
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DELETE FROM NotificacionVigenciaHora WHERE Notificacion = @Notificacion
  
  INSERT NotificacionVigenciaHora (Notificacion, HoraD, HoraA)
                           SELECT Notificacion,  HoraD, HoraA
                             FROM NotificacionVigenciaHoraTemp
                            WHERE Notificacion = @Notificacion
                              AND Estacion = @Estacion
                             
END
GO

/******************************* spNotificacionEnFrecuencia *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionEnFrecuencia') and type = 'P') drop procedure dbo.spNotificacionEnFrecuencia
GO             
CREATE PROCEDURE spNotificacionEnFrecuencia
		@Notificacion				varchar(50),
		@FechaEmision				datetime,
		@Resultado					bit OUTPUT,
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE
  @RID							int,
  @FechaD						datetime,
  @FechaA						datetime,
  @PrimerDiaSemana				int,
  @Frecuencia					varchar(20),
  @DiaSemanaEmision				int,
  @DiaEmision					int,
  @MesEmision					int,
  @AnoEmision					int,
  @DiasMesEmision				int,
  @Lunes						bit,
  @Martes						bit,
  @Miercoles					bit,
  @Jueves						bit,
  @Viernes						bit,
  @Sabado						bit,
  @Domingo						bit,
  @DiaMes						int,
  @FechaInicio					datetime,
  @Diferencia					int
  
  SET @PrimerDiaSemana = @@DATEFIRST
  SET DATEFIRST 1

  SET @DiaSemanaEmision = DATEPART(dw,@FechaEmision)
  SET @DiaEmision       = DATEPART(d,@FechaEmision)
  SET @MesEmision       = DATEPART(mm,@FechaEmision)        
  SET @AnoEmision       = DATEPART(yy,@FechaEmision)        
  SET @DiasMesEmision = dbo.fnDiasMes(@MesEmision,@AnoEmision)

  SET @Resultado = 0
  
  SELECT 
    @Frecuencia = ISNULL(Frecuencia,'(Diaria)'), 
    @DiaMes = ISNULL(DiaMes,0),
    @FechaInicio = FechaInicio,
    @Lunes = ISNULL(Lunes,0),
    @Martes = ISNULL(Martes,0),
    @Miercoles = ISNULL(Miercoles,0),
    @Jueves = ISNULL(Jueves,0),
    @Viernes = ISNULL(Viernes,0), 
    @Sabado = ISNULL(Sabado,0),
    @Domingo = ISNULL(Domingo,0) 
    FROM Notificacion 
   WHERE RTRIM(Notificacion) = RTRIM(@Notificacion)

  IF @DiasMesEmision < @DiaMes SET @DiaMes = @DiasMesEmision

  SET @Diferencia = DATEDIFF(mm,CONVERT(datetime,@FechaInicio),CONVERT(datetime,@FechaEmision))
  
  IF @Frecuencia IN ('(Mensual)','(Bimestral)','(Trimestral)','(Semestral)','(Anual)') AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) AND @FechaInicio IS NULL SELECT @Ok = 41020, @OkRef = @Notificacion ELSE
  IF @Frecuencia IN ('(Mensual)','(Bimestral)','(Trimestral)','(Semestral)','(Anual)') AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) AND @DiaMes = 0 SELECT @Ok = 10060, @OkRef = @Notificacion
 
  IF @Frecuencia = '(Diaria)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    SET @Resultado = 1
  END ELSE
  IF @Frecuencia = '(Semanal)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN    
    IF @DiaSemanaEmision = 1 SET @Resultado = ISNULL(@Lunes,0) ELSE
    IF @DiaSemanaEmision = 2 SET @Resultado = ISNULL(@Martes,0) ELSE    
    IF @DiaSemanaEmision = 3 SET @Resultado = ISNULL(@Miercoles,0) ELSE        
    IF @DiaSemanaEmision = 4 SET @Resultado = ISNULL(@Jueves,0) ELSE            
    IF @DiaSemanaEmision = 5 SET @Resultado = ISNULL(@Viernes,0) ELSE                
    IF @DiaSemanaEmision = 6 SET @Resultado = ISNULL(@Sabado,0) ELSE                    
    IF @DiaSemanaEmision = 7 SET @Resultado = ISNULL(@Domingo,0)
  END ELSE  
  IF @Frecuencia = '(Mensual)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    IF @FechaEmision >= @FechaInicio
    BEGIN
      IF @DiaEmision = @DiaMes SELECT @Resultado = 1    
    END
  END ELSE
  IF @Frecuencia = '(Bimestral)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    IF (@FechaEmision >= @FechaInicio) AND ( @Diferencia % 2 = 0)
    BEGIN
      IF @DiaEmision = @DiaMes SELECT @Resultado = 1    
    END  
  END ELSE
  IF @Frecuencia = '(Trimestral)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    IF (@FechaEmision >= @FechaInicio) AND ( @Diferencia % 3 = 0)
    BEGIN
      IF @DiaEmision = @DiaMes SELECT @Resultado = 1    
    END  
  END ELSE
  IF @Frecuencia = '(Semestral)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    IF (@FechaEmision >= @FechaInicio) AND ( @Diferencia % 6 = 0)
    BEGIN
      IF @DiaEmision = @DiaMes SELECT @Resultado = 1    
    END    
  END ELSE
  IF @Frecuencia = '(Anual)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    IF (@FechaEmision >= @FechaInicio) AND ( @Diferencia % 12 = 0)
    BEGIN
      IF @DiaEmision = @DiaMes SELECT @Resultado = 1    
    END      
  END
  
  SET DATEFIRST @PrimerDiaSemana
    
END
GO

/**************** fnNotificacionCorreoSubAlterno ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionCorreoSubAlterno') DROP FUNCTION fnNotificacionCorreoSubAlterno
GO
CREATE FUNCTION fnNotificacionCorreoSubAlterno 
	(
	@Usuario					varchar(10)
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @ListaCorreos			varchar(max),
  @Correo				varchar(255),
  @Personal				varchar(10)

  SELECT @Personal = Personal FROM Usuario WHERE Usuario = @Usuario
      
  SET @ListaCorreos = ''

  IF NULLIF(@Personal,'') IS NOT NULL
  BEGIN
    DECLARE crPersonal CURSOR FOR
     SELECT ISNULL(ISNULL(NULLIF(p.Email,''),NULLIF(u.Email,'')),'')
       FROM Personal p LEFT OUTER JOIN Usuario u
         ON u.Personal = p.Personal
      WHERE ReportaA = @Personal
	    AND p.Estatus NOT IN('BAJA')
        
    OPEN crPersonal
    FETCH NEXT FROM crPersonal INTO @Correo
    WHILE @@FETCH_STATUS = 0
    BEGIN
      
      IF NULLIF(@ListaCorreos,'') IS NOT NULL AND NULLIF(@Correo,'') IS NOT NULL SELECT @ListaCorreos = @ListaCorreos + ',' + @Correo ELSE
      IF NULLIF(@ListaCorreos,'') IS NULL AND NULLIF(@Correo,'') IS NOT NULL SELECT @ListaCorreos = @ListaCorreos + @Correo
          
      FETCH NEXT FROM crPersonal INTO @Correo
    END
    CLOSE crPersonal
    DEALLOCATE crPersonal
  END
  
  RETURN (@ListaCorreos)
END
GO

/**************** fnNotificacionCorreosDestinatarios ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionCorreosDestinatarios') DROP FUNCTION fnNotificacionCorreosDestinatarios
GO
CREATE FUNCTION fnNotificacionCorreosDestinatarios 
	(
	@Notificacion				varchar(50),
	@Usuario					varchar(10),
	@Seccion					varchar(20),
	@ContactoTipo				varchar(20),
	@Contacto					varchar(10)
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @ListaCorreos			varchar(max),
  @RID					int,
  @TipoDestinatario		varchar(20),
  @Destinatario			varchar(100),
  @DestinatarioCorreo	varchar(255),
  @Correo				varchar(255),
  @Personal				varchar(10),
  @MiJefe				varchar(10),
  @ElJefeDeMiJefe		varchar(10)
  
  SET @ListaCorreos = ''

  DECLARE crNotificacionDestinatario CURSOR FOR
   SELECT RID, ISNULL(TipoDestinatario,''), ISNULL(Destinatario,''), ISNULL(DestinatarioCorreo,'')
     FROM NotificacionDestinatario
    WHERE Notificacion = @Notificacion 
      AND SeccionDestinatario = @Seccion

  OPEN crNotificacionDestinatario
  FETCH NEXT FROM crNotificacionDestinatario INTO @RID, @TipoDestinatario, @Destinatario, @DestinatarioCorreo
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @TipoDestinatario = '(YO)'
    BEGIN
      SELECT @Correo = ISNULL(eMail,''), @Personal = Personal FROM Usuario WHERE Usuario = @Usuario
      IF NULLIF(@Correo,'') IS NULL SELECT @Correo = ISNULL(eMail,'') FROM Personal WHERE Personal = @Personal
    END ELSE      
    IF @TipoDestinatario = '(MI JEFE)' 
    BEGIN
      SELECT @Personal = Personal FROM Usuario WHERE Usuario = @Usuario
      IF NULLIF(@Personal,'') IS NOT NULL SELECT @MiJefe = NULLIF(ReportaA,'') FROM Personal WHERE Personal = @Personal
      IF @MiJefe IS NOT NULL SELECT @Correo = ISNULL(eMail,'') FROM Personal WHERE Personal = @MiJefe AND Estatus NOT IN('BAJA')
      SET @Correo = ISNULL(@Correo,'')
    END ELSE
    IF @TipoDestinatario = '(EL JEFE DE MI JEFE)' 
    BEGIN
      SELECT @Personal = Personal FROM Usuario WHERE Usuario = @Usuario
      IF NULLIF(@Personal,'') IS NOT NULL SELECT @MiJefe = NULLIF(ReportaA,'') FROM Personal WHERE Personal = @Personal
      IF @MiJefe IS NOT NULL SELECT @ElJefeDeMiJefe = NULLIF(ReportaA,'') FROM Personal WHERE Personal = @MiJefe
      IF @ElJefeDeMiJefe IS NOT NULL SELECT @Correo = ISNULL(eMail,'') FROM Personal WHERE Personal = @ElJefeDeMiJefe AND Estatus NOT IN('BAJA')
      SET @Correo = ISNULL(@Correo,'')
    END ELSE       
    IF @TipoDestinatario = '(ESPECIFICO)' 
    BEGIN
      SET @Correo = ISNULL(@DestinatarioCorreo,'')
    END ELSE       
    IF @TipoDestinatario = '(CONTACTO)' 
    BEGIN
      IF @ContactoTipo = 'Cliente'   SELECT @Correo = ISNULL(ISNULL(NULLIF(Email1,''),NULLIF(Email2,'')),'') FROM Cte    WHERE Cliente   = @Contacto ELSE
      IF @ContactoTipo = 'Proveedor' SELECT @Correo = ISNULL(ISNULL(NULLIF(Email1,''),NULLIF(Email2,'')),'') FROM Prov   WHERE Proveedor = @Contacto ELSE   
      IF @ContactoTipo = 'Agente'    SELECT @Correo = ISNULL(NULLIF(Email,''),'') FROM Agente WHERE Agente = @Contacto ELSE
      SET @Correo = ''    
    END ELSE
    IF @TipoDestinatario = '(SUBORDINADOS)'
    BEGIN
      SET @Correo = dbo.fnNotificacionCorreoSubAlterno(@Usuario)
    END   
    
    IF NULLIF(@ListaCorreos,'') IS NOT NULL AND NULLIF(@Correo,'') IS NOT NULL SELECT @ListaCorreos = @ListaCorreos + ';' + @Correo ELSE
    IF NULLIF(@ListaCorreos,'') IS NULL AND NULLIF(@Correo,'') IS NOT NULL SELECT @ListaCorreos = @ListaCorreos + @Correo
        
    FETCH NEXT FROM crNotificacionDestinatario INTO @RID, @TipoDestinatario, @Destinatario, @DestinatarioCorreo    
  END
  CLOSE crNotificacionDestinatario
  DEALLOCATE crNotificacionDestinatario

  RETURN (@ListaCorreos)
END
GO

--SELECT dbo.fnNotificacionCorreosDestinatarios('Notificacion generica', 'DEMO', 'CCO', 'Cliente', NULL)                   
--SELECT dbo.fnNotificacionCorreosDestinatarios('Notificacion Generica','DEMO') 
--SELECT * FROM NOTIFICACIONDESTINATARIO


--select * from notificaciondestinatario
/**************** spNotificacionNueva ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionNueva') and type = 'P') drop procedure dbo.spNotificacionNueva
GO             
CREATE PROCEDURE spNotificacionNueva
		@Estacion			int,
		@Notificacion		varchar(50),
		@Clave				varchar(50)
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion		varchar(50),
	@Ok			int,
	@OkRef			varchar(255)

  IF EXISTS(SELECT 1 FROM Notificacion WHERE Notificacion = @Notificacion) RETURN

  SELECT @Ok = NULL, @OkRef = NULL
    
  SET @Transaccion = 'spNotificacionNueva' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  BEGIN TRANSACTION @Transaccion

  INSERT Notificacion (Notificacion, Clave, Descripcion, Asunto, Mensaje, Estatus, MedioComunicacion, TipoFechaNotificacion, FechaNotificacion, AnticipacionFechaTipo, AnticipacionFecha, Frecuencia, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo, DiaMes, FechaInicio)
               SELECT
                 @Notificacion,
                 Clave,
                 Descripcion,
                 Asunto,
                 Mensaje,
                 'INACTIVA',
                 MedioComunicacion,
                 TipoFechaNotificacion,
                 FechaNotificacion,
                 AnticipacionFechaTipo,
                 AnticipacionFecha,                 
                 Frecuencia,
                 Lunes,
                 Martes,
                 Miercoles,
                 Jueves,
                 Viernes,
                 Sabado,
                 Domingo,
                 DiaMes,
                 FechaInicio
                 FROM NotificacionClave
                WHERE Clave = @Clave  
  IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'Notificacion'  

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT NotificacionParam (Notificacion, Parametro, Valor)
                      SELECT
                        @Notificacion,
                        Parametro,
                        ValorOmision 
                        FROM NotificacionClaveParam
                       WHERE Clave = @Clave  
                                                
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionParam'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT NotificacionConsulta (Notificacion, ConsultaNombre, Consulta)
                      SELECT
                        @Notificacion,
                        ConsultaNombre,
                        Consulta 
                        FROM NotificacionClaveConsulta
                       WHERE Clave = @Clave  
                                                
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionConsulta'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT NotificacionDestinatario (Notificacion, TipoDestinatario, SeccionDestinatario, Destinatario, DestinatarioCorreo)
                      SELECT
                        @Notificacion,
                        TipoDestinatario,
                        SeccionDestinatario, 
                        Destinatario,
                        DestinatarioCorreo 
                        FROM NotificacionClaveDestinatario
                       WHERE Clave = @Clave  
                                                
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionDestinatario'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)

  BEGIN
    INSERT NotificacionFiltro (Notificacion, Empresa, Sucursal, UEN, Usuario, Modulo, Movimiento, Estatus, Situacion, Proyecto, ContactoTipo, Contacto, ImporteMin, ImporteMax, ValidarAlEmitir)
                       SELECT
                         @Notificacion,
                         Empresa,
                         Sucursal,
                         UEN,
                         Usuario,
                         Modulo,
                         Movimiento,
                         Estatus,
                         Situacion,
                         Proyecto,
                         ContactoTipo,
                         Contacto,
                         ImporteMin,
                         ImporteMax,
                         ValidarAlEmitir 
                         FROM NotificacionClaveFiltro
                        WHERE Clave = @Clave  
                                                
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionFiltro'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    COMMIT TRANSACTION @Transaccion
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + ', ' + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO
--EXEC spNotificacionNueva 1, 'Notificacion Generica 2', 'GENERICA'

/**************** spNotificacionCopiar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionCopiar') and type = 'P') drop procedure dbo.spNotificacionCopiar
GO             
CREATE PROCEDURE spNotificacionCopiar
		@Estacion				int,
		@NotificacionOrigen		varchar(50),		
		@Notificacion			varchar(50)

		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion		varchar(50),
	@Ok			int,
	@OkRef			varchar(255)

  IF EXISTS(SELECT 1 FROM Notificacion WHERE Notificacion = @Notificacion) RETURN

  SELECT @Ok = NULL, @OkRef = NULL
    
  SET @Transaccion = 'spNotificacionCopiar' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  BEGIN TRANSACTION @Transaccion

  INSERT Notificacion (Notificacion, Clave, Descripcion, Asunto, Mensaje, Estatus, MedioComunicacion, TipoFechaNotificacion, FechaNotificacion, AnticipacionFechaTipo, AnticipacionFecha, Frecuencia, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo, DiaMes, FechaInicio, CondicionUsuario)
               SELECT
                 @Notificacion,
                 Clave,
                 Descripcion,
                 Asunto,
                 Mensaje,
                 'INACTIVA',
                 MedioComunicacion,
                 TipoFechaNotificacion,
                 FechaNotificacion,
                 AnticipacionFechaTipo,
                 AnticipacionFecha,                 
                 Frecuencia,
                 Lunes,
                 Martes,
                 Miercoles,
                 Jueves,
                 Viernes,
                 Sabado,
                 Domingo,
                 DiaMes,
                 FechaInicio,
                 CondicionUsuario
                 FROM Notificacion
                WHERE Notificacion = @NotificacionOrigen  
  IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'Notificacion'  

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT NotificacionParam (Notificacion, Parametro, Valor)
                      SELECT
                        @Notificacion,
                        Parametro,
                        Valor 
                        FROM NotificacionParam
                       WHERE Notificacion = @NotificacionOrigen  
                                                
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionParam'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT NotificacionConsulta (Notificacion, ConsultaNombre, Consulta)
                      SELECT
                        @Notificacion,
                        ConsultaNombre,
                        Consulta 
                        FROM NotificacionConsulta
                       WHERE Notificacion = @NotificacionOrigen  
                                                
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionConsulta'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT NotificacionDestinatario (Notificacion, TipoDestinatario, SeccionDestinatario, Destinatario, DestinatarioCorreo)
                      SELECT
                        @Notificacion,
                        TipoDestinatario,
                        SeccionDestinatario, 
                        Destinatario,
                        DestinatarioCorreo 
                        FROM NotificacionDestinatario
                       WHERE Notificacion = @NotificacionOrigen  
                                                
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionDestinatario'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT NotificacionFiltro (Notificacion, Empresa, Sucursal, UEN, Usuario, Modulo, Movimiento, Estatus, Situacion, Proyecto, ContactoTipo, Contacto, ImporteMin, ImporteMax, ValidarAlEmitir)
                       SELECT
                         @Notificacion,
                         Empresa,
                         Sucursal,
                         UEN,
                         Usuario,
                         Modulo,
                         Movimiento,
                         Estatus,
                         Situacion,
                         Proyecto,
                         ContactoTipo,
                         Contacto,
                         ImporteMin,
                         ImporteMax,
                         ValidarAlEmitir 
                         FROM NotificacionFiltro
                        WHERE Notificacion = @NotificacionOrigen  
                                                
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionFiltro'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT NotificacionConsulta (Notificacion, ConsultaNombre, Consulta)
                       SELECT
                         @Notificacion,
                         ConsultaNombre,
                         Consulta
                         FROM NotificacionConsulta
                        WHERE Notificacion = @NotificacionOrigen  
                                                
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionConsulta'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT NotificacionVigencia (Notificacion, FechaD, FechaA)
                       SELECT
                         @Notificacion,
                         FechaD,
                         FechaA
                         FROM NotificacionVigencia
                        WHERE Notificacion = @NotificacionOrigen  
                                                
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionVigencia'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT NotificacionVigenciaHora (Notificacion, HoraD, HoraA)
                       SELECT
                         @Notificacion,
                         HoraD,
                         HoraA
                         FROM NotificacionVigenciaHora
                        WHERE Notificacion = @NotificacionOrigen  
                                                
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionVigenciaHora'  
  END


  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    COMMIT TRANSACTION @Transaccion
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + ', ' + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO

--exec spNotificacionCopiar 1, 'Notificacion Generica', 'Notificacion Generica 2'

/**************** spNotificacionEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionEliminar') and type = 'P') drop procedure dbo.spNotificacionEliminar
GO             
CREATE PROCEDURE spNotificacionEliminar
		@Estacion				int,
		@Notificacion			varchar(50)

		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion		varchar(50),
	@Ok			int,
	@OkRef			varchar(255)

  IF NOT EXISTS(SELECT 1 FROM Notificacion WHERE Notificacion = @Notificacion) RETURN

  SELECT @Ok = NULL, @OkRef = NULL
    
  SET @Transaccion = 'spNotificacionEliminar' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  BEGIN TRANSACTION @Transaccion

  DELETE FROM Notificacion WHERE Notificacion = @Notificacion  
  IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'Notificacion'  

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    DELETE FROM NotificacionParam WHERE Notificacion = @Notificacion  
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionParam'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    DELETE FROM NotificacionConsulta WHERE Notificacion = @Notificacion  
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionConsulta'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    DELETE FROM NotificacionDestinatario WHERE Notificacion = @Notificacion
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionDestinatario'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    DELETE FROM NotificacionFiltro WHERE Notificacion = @Notificacion
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionFiltro'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    DELETE FROM NotificacionVigencia WHERE Notificacion = @Notificacion
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionVigencia'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    DELETE FROM NotificacionVigenciaHora WHERE Notificacion = @Notificacion
    IF NULLIF(@@ERROR,0) IS NOT NULL SELECT @Ok = 1, @OkRef = 'NotificacionVigenciaHora'  
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    COMMIT TRANSACTION @Transaccion
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + ', ' + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO

--exec spNotificacionEliminar 1, 'Notificacion Generica 2'

/**************** spNotificacionCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionCerrarDia') and type = 'P') drop procedure dbo.spNotificacionCerrarDia
GO             
CREATE PROCEDURE spNotificacionCerrarDia
		@Sucursal				int,
		@Empresa				varchar(5),
		@Usuario				varchar(10),
		@Fecha					datetime,
		@Ok						int OUTPUT,
		@OkRef					varchar(255) OUTPUT,
		@Conexion				bit = 1

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID				int,
  @Mov				varchar(20),
  @IDGenerar		int,
  @FechaRegistro	datetime
  
  SET @FechaRegistro = GETDATE()
  
  SELECT @Mov = Notificacion FROM EmpresaCFGMovGES WHERE Empresa = @Empresa
   
  DECLARE crIntelisisService CURSOR FOR
   SELECT ID
     FROM IntelisisService
    WHERE Sistema = 'Intelisis'
      AND Contenido = 'Solicitud'
      AND Referencia = 'Intelisis.Notificacion'
      AND Estatus = 'SINPROCESAR'
      
  OPEN crIntelisisService
  FETCH NEXT FROM crIntelisisService INTO @ID
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    EXEC spIntelisisServiceProcesar @ID
    FETCH NEXT FROM crIntelisisService INTO @ID
  END
  CLOSE crIntelisisService
  DEALLOCATE crIntelisisService

  IF @Ok IS NULL 
  BEGIN
    INSERT Gestion (Empresa,  Mov,  FechaEmision, Sucursal,  Usuario,  Estatus,      FechaRegistro,  Asunto)
            VALUES (@Empresa, @Mov, @Fecha,       @Sucursal, @Usuario, 'SINAFECTAR', @FechaRegistro, @Mov)
    IF @@ERROR <> 0 SElect @Ok = 1, @OkRef = @Mov
    SET @IDGenerar = SCOPE_IDENTITY()
            
    IF @Ok IS NULL
      EXEC spAfectar 'GES', @IDGenerar, 'AFECTAR', 'TODO', NULL, @Usuario, NULL, 1, @Ok OUTPUT, @OKRef OUTPUT, @FechaRegistro, @Conexion, @@SPID 

  END
  
END
GO

/**************** spNotificacionParamAyudaCaptura ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionParamAyudaCaptura') and type = 'P') drop procedure dbo.spNotificacionParamAyudaCaptura
GO             
CREATE PROCEDURE spNotificacionParamAyudaCaptura
		@Notificacion		varchar(50),
		@Parametro			varchar(100)
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Clave					varchar(50),
  @Tipo						varchar(20)
  
  SELECT @Clave = Clave FROM Notificacion WHERE Notificacion = @Notificacion

  SET @Parametro = RTRIM(@Parametro)
  
  SELECT @Tipo = RTRIM(ISNULL(Tipo,'')) FROM NotificacionClaveParam WHERE Clave = @Clave AND Parametro = @Parametro
  
  IF @Tipo = 'TEXTO'
  BEGIN
    SELECT CONVERT(varchar(255),'')  
    UNION ALL
    SELECT RTRIM(ISNULL(Valor,'')) 
      FROM NotificacionClaveParamAyuda 
     WHERE Clave = @Clave 
       AND Parametro = @Parametro        
  END ELSE
  IF @Tipo = 'NUMERO'
  BEGIN
    SELECT CONVERT(varchar(255),'')  
  END ELSE
  IF @Tipo = 'FECHA'
  BEGIN
    SELECT CONVERT(varchar(255),'')    
  END ELSE
  IF @Tipo = 'LOGICO'
  BEGIN
    SELECT CONVERT(varchar(255),'0')
    UNION ALL  
    SELECT CONVERT(varchar(255),'1')    
  END
END
GO

--EXEC spNotificacionParamAyudaCaptura 'AUTORIZACION', 'MENSAJE CONFIRMACION'

/*
DELETE FROM NotificacionClaveParam

INSERT NotificacionClaveParam (Clave,      Parametro, Tipo,    ValorOmision, Descripcion)
                       VALUES ('GENERICA', 'P1',      'TEXTO', 'TEXTO1',     'PARAMETRO 1')
INSERT NotificacionClaveParam (Clave,      Parametro, Tipo,     ValorOmision, Descripcion)
                       VALUES ('GENERICA', 'P2',      'NUMERO', '100.00',     'PARAMETRO 2')
INSERT NotificacionClaveParam (Clave,      Parametro, Tipo,     ValorOmision, Descripcion)
                       VALUES ('GENERICA', 'P3',      'FECHA',  '10/05/2011', 'PARAMETRO 3')
INSERT NotificacionClaveParam (Clave,      Parametro, Tipo,     ValorOmision, Descripcion)
                       VALUES ('GENERICA', 'P4',      'LOGICO', '0',          'PARAMETRO 4')
DELETE FROM NotificacionClaveParamAyuda
INSERT NotificacionClaveParamAyuda (Clave,      Parametro, Valor)
                            VALUES ('GENERICA', 'P1',      'TEXTO1')
INSERT NotificacionClaveParamAyuda (Clave,      Parametro, Valor)
                            VALUES ('GENERICA', 'P1',      'TEXTO2')
INSERT NotificacionClaveParamAyuda (Clave,      Parametro, Valor)
                            VALUES ('GENERICA', 'P1',      'TEXTO3')
DELETE FROM NotificacionParam

INSERT NotificacionParam (Notificacion,            Parametro, Valor)
                  VALUES ('Notificacion Generica', 'P1',      'TEXTO1')
INSERT NotificacionParam (Notificacion,            Parametro, Valor)
                  VALUES ('Notificacion Generica', 'P2',      '100.00')
INSERT NotificacionParam (Notificacion,            Parametro, Valor)
                  VALUES ('Notificacion Generica', 'P3',      '10/05/2011')
INSERT NotificacionParam (Notificacion,            Parametro, Valor)
                  VALUES ('Notificacion Generica', 'P4',      '0')
exec spNotificacionParamAyudaCaptura 'Notificacion Generica', 'P4'

*/                  

--SELECT * FROM NOTIFICACIONCLAVEPARAM
--SELECT * FROM NOTIFICACIONCLAVEPARAMAYUDA
--SELECT * FROM NOTIFICACIONPARAM

/**************** spNotificacionAyudaCaptura ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionAyudaCaptura') and type = 'P') drop procedure dbo.spNotificacionAyudaCaptura
GO             
CREATE PROCEDURE spNotificacionAyudaCaptura
		@Notificacion		varchar(50),
		@Campo				varchar(50),
		@Modulo				varchar(10)  = NULL,
		@Movimiento			varchar(20)  = NULL,
		@Estatus			varchar(100) = NULL,
		@ContactoTipo		varchar(20)	 = NULL,
		@Cuenta				varchar(20)	 = NULL,
		@Rama				varchar(5)	 = NULL
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Clave			varchar(50),
  @EstatusClave		varchar(15),
  @CtaTipo			varchar(15)

  SET @EstatusClave = NULL  
  
  IF @Modulo = '(TODOS)' SET @Modulo = NULL
  
  IF @Movimiento = '(TODOS)' SET @Movimiento = NULL  
  
  SELECT @EstatusClave = Estatus FROM Estatus WHERE RTRIM(Nombre) = RTRIM(@Estatus)  
  
  SELECT @Clave = Clave FROM Notificacion WHERE Notificacion = @Notificacion

  SET @Campo = UPPER(@Campo)
  
  IF @Campo = 'EMPRESA'
  BEGIN
    SELECT CONVERT(varchar(10),'(TODOS)')
    UNION ALL
    SELECT
      Empresa
      FROM Empresa    
     WHERE Estatus = 'ALTA' 
  END ELSE IF @Campo = 'SUCURSAL'
  BEGIN
    SELECT CONVERT(varchar(10),'(TODOS)')
    UNION ALL
    SELECT
      CONVERT(varchar(10),Sucursal)
      FROM Sucursal  
     WHERE Estatus = 'ALTA'       
  END ELSE IF @Campo = 'UEN'
  BEGIN
    SELECT CONVERT(varchar(10),'(TODOS)')
    UNION ALL
    SELECT
      CONVERT(varchar(10),UEN)
      FROM UEN  
     WHERE Estatus = 'ALTA'       
  END ELSE IF @Campo = 'USUARIO'
  BEGIN
    SELECT CONVERT(varchar(10),'(TODOS)')
    UNION ALL
    SELECT
      Usuario
      FROM Usuario  
     WHERE Estatus = 'ALTA'       
  -- 'CORTE'
  END ELSE IF @Campo = 'MODULO'
  BEGIN
    IF ISNULL(@Movimiento, '') = 'CORTE.CORTECX'
      SELECT CONVERT(varchar(10),'(TODOS)')
      UNION ALL
      SELECT CONVERT(varchar(10), 'CXC')
      UNION ALL
      SELECT CONVERT(varchar(10), 'CXP')
    ELSE
      IF EXISTS(SELECT 1 FROM NotificacionClaveModulo WHERE Clave = @Clave)
      BEGIN
        SELECT CONVERT(varchar(10),'(TODOS)')
        UNION ALL
        SELECT
          Modulo
          FROM NotificacionClaveModulo    
         WHERE Clave = @Clave 
      END ELSE
      BEGIN
        SELECT CONVERT(varchar(10),'(TODOS)')
        UNION ALL
        SELECT
          Modulo
          FROM Modulo
      END  
  -- 'CORTE'   
  END ELSE IF @Campo = 'MOVIMIENTO'
  BEGIN
    IF ISNULL(@Movimiento, '') = 'CORTE.CORTEUNIDADES'
      SELECT CONVERT(varchar(20),'(TODOS)')
      UNION ALL
      SELECT Mov 
        FROM InvAuxUMov
    ELSE
      SELECT CONVERT(varchar(20),'(TODOS)')
      UNION ALL
      SELECT DISTINCT
        Mov
        FROM MovTipo 
       WHERE RTRIM(Modulo) = RTRIM(ISNULL(@Modulo,Modulo))    
  END ELSE IF @Campo = 'ESTATUS'
  BEGIN
    IF EXISTS(SELECT 1 FROM NotificacionClaveModuloEstatus WHERE Clave = @Clave AND RTRIM(Modulo) = RTRIM(ISNULL(@Modulo,Modulo)))
    BEGIN
      SELECT CONVERT(varchar(100),'(TODOS)')
      UNION ALL
      SELECT
        Estatus
        FROM NotificacionClaveModuloEstatus    
       WHERE Clave = @Clave
         AND RTRIM(Modulo) = RTRIM(ISNULL(@Modulo,Modulo)) 
    END ELSE
    BEGIN
      SELECT CONVERT(varchar(10),'(TODOS)')
      UNION ALL
      SELECT DISTINCT
        Nombre
        FROM Estatus
    END     
  END ELSE IF @Campo = 'SITUACION'
  BEGIN
    SELECT CONVERT(varchar(50),'(TODOS)')
    UNION ALL
    SELECT DISTINCT
      Situacion
      FROM MovSituacion
     WHERE RTRIM(Modulo) = RTRIM(ISNULL(@Modulo,Modulo)) 
       AND RTRIM(Mov) = RTRIM(ISNULL(@Movimiento,Mov)) 
       AND RTRIM(Estatus) = RTRIM(ISNULL(@EstatusClave,Estatus))      
  END ELSE IF @Campo = 'PROYECTO'
  BEGIN
    -- 'CORTE'
    SELECT CONVERT(varchar(50),'(TODOS)')
    UNION ALL
    SELECT
      Proyecto
      FROM Proy
     WHERE RTRIM(Estatus) = 'ALTA'
  END ELSE IF @Campo = 'CONTACTOTIPO'
  BEGIN
    IF @Modulo IN ('VTAS','CXC','ST','VALE','CAM') SELECT CONVERT(varchar(50),'Cliente') ELSE
    IF @Modulo IN ('COMS','CXP','GAS','AF') SELECT CONVERT(varchar(50),'Proveedor') ELSE
    IF @Modulo IN ('AGENT','CR') SELECT CONVERT(varchar(50),'Agente') ELSE    
    IF @Modulo IN ('PACTO','DIN') SELECT CONVERT(varchar(50),'(TODOS)') UNION ALL SELECT CONVERT(varchar(50),'Cliente') UNION ALL SELECT CONVERT(varchar(50),'Proveedor') UNION ALL SELECT CONVERT(varchar(50),'Agente') ELSE
    -- 'CORTE'
    IF @Modulo IN ('CONT') SELECT CONVERT(varchar(50),'(TODOS)') UNION ALL SELECT CONVERT(varchar(50),'Cliente') UNION ALL SELECT CONVERT(varchar(50),'Proveedor') ELSE    
    IF @Modulo NOT IN ('VTAS','CXC','ST','VALE','CAM','COMS','CXP','GAS','AF','AGENT','CR','PACTO','DIN') SELECT CONVERT(varchar(50),'(TODOS)')        
  END ELSE IF @Campo = 'CONTACTO'
  BEGIN
    IF @ContactoTipo = 'Cliente'   SELECT CONVERT(varchar(10),'(TODOS)') UNION ALL SELECT Cliente FROM Cte WHERE Estatus = 'ALTA' ELSE
    IF @ContactoTipo = 'Proveedor' SELECT CONVERT(varchar(10),'(TODOS)') UNION ALL SELECT Proveedor FROM Prov WHERE Estatus = 'ALTA' ELSE
    IF @ContactoTipo = 'Agente'    SELECT CONVERT(varchar(10),'(TODOS)') UNION ALL SELECT Agente FROM Agente WHERE Estatus = 'ALTA' ELSE    
    IF @ContactoTipo = '(TODOS)' AND @Modulo IN ('PACTO','DIN') SELECT CONVERT(varchar(50),'(TODOS)') UNION SELECT Cliente FROM Cte WHERE Estatus = 'ALTA' UNION SELECT Proveedor FROM Prov WHERE Estatus = 'ALTA' UNION SELECT Agente FROM Agente WHERE Estatus = 'ALTA' ELSE       
    IF @ContactoTipo = '(TODOS)' AND @Modulo NOT IN ('PACTO','DIN') SELECT CONVERT(varchar(50),'(TODOS)') 
  END 
  -- 'CORTE'  
  ELSE IF @Campo = 'MONEDA'
  BEGIN
    SELECT CONVERT(varchar(10),'(TODOS)')
    UNION ALL
    SELECT
      Moneda
      FROM Mon
  END ELSE IF @Campo = 'TOTALIZADOR'
  BEGIN
    EXEC spCorteTotalizadorAyudaCaptura @Movimiento, @Modulo
  END ELSE IF @Campo = 'CTA'
  BEGIN
    IF ISNULL(@Movimiento, '') = 'CORTE.CORTEUNIDADES'
      SELECT CONVERT(varchar(20),'(TODOS)')
      UNION ALL
      SELECT Articulo
        FROM Art
       WHERE Estatus = 'ALTA'
    ELSE 
      SELECT CONVERT(varchar(20),'(TODOS)')
      UNION ALL
      SELECT Cuenta
        FROM Cta
       WHERE Estatus = 'ALTA'
  END ELSE IF @Campo = 'CTACATEGORIA'
  BEGIN
    IF ISNULL(@Movimiento, '') = 'CORTE.CORTECONTABLE'
      SELECT CONVERT(varchar(50),'(TODOS)')
      UNION ALL
      SELECT Categoria
        FROM CtaCat
    ELSE IF ISNULL(@Movimiento, '') = 'CORTE.CORTECX'
    BEGIN
      IF ISNULL(@Modulo, '') = 'CXP'
        SELECT CONVERT(varchar(50),'(TODOS)')
        UNION ALL
        SELECT Categoria
          FROM ProvCat        
      ELSE IF ISNULL(@Modulo, '') = 'CXC'
        SELECT CONVERT(varchar(50),'(TODOS)')        
        UNION ALL
        SELECT Categoria
          FROM CteCat
      ELSE SELECT CONVERT(varchar(50),'(TODOS)')
    END
    ELSE IF ISNULL(@Movimiento, '') = 'CORTE.CORTEUNIDADES'
      SELECT CONVERT(varchar(50),'(TODOS)')
      UNION ALL
      SELECT Categoria
        FROM ArtCat
    ELSE SELECT CONVERT(varchar(50),'(TODOS)')    
  END ELSE IF @Campo = 'CTATIPO'
  BEGIN
    IF ISNULL(@Movimiento, '') = 'CORTE.CORTECX'
    BEGIN
      IF ISNULL(@Modulo, '') = 'CXP'
        SELECT CONVERT(varchar(50),'(TODOS)')
      ELSE IF ISNULL(@Modulo, '') = 'CXC'
        SELECT CONVERT(varchar(50),'(TODOS)')
        UNION ALL
        SELECT Tipo
          FROM CteTipo
    END
    ELSE SELECT CONVERT(varchar(50),'(TODOS)')
  END ELSE IF @Campo = 'CTAFAMILIA'
  BEGIN
    IF ISNULL(@Movimiento, '') = 'CORTE.CORTECONTABLE'  
      SELECT CONVERT(varchar(50),'(TODOS)')
      UNION ALL
      SELECT Familia
        FROM CtaFam
    ELSE IF ISNULL(@Movimiento, '') = 'CORTE.CORTECX'
    BEGIN
      IF ISNULL(@Modulo, '') = 'CXP'
        SELECT CONVERT(varchar(50),'(TODOS)')
        UNION ALL
        SELECT Familia
          FROM ProvFam        
      ELSE IF ISNULL(@Modulo, '') = 'CXC'
        SELECT CONVERT(varchar(50),'(TODOS)')        
        UNION ALL
        SELECT Familia
          FROM CteFam
      ELSE SELECT CONVERT(varchar(50),'(TODOS)')
    END
    ELSE IF ISNULL(@Movimiento, '') = 'CORTE.CORTEUNIDADES'  
      SELECT CONVERT(varchar(50),'(TODOS)')
      UNION ALL
      SELECT Familia
        FROM ArtFam
    ELSE SELECT CONVERT(varchar(50),'(TODOS)')

  END ELSE IF @Campo = 'RAMA'
  BEGIN
    IF ISNULL(@Movimiento, '') = 'CORTE.CORTEUNIDADES'
      SELECT CONVERT(varchar(50),'(TODOS)')
      UNION ALL
      SELECT Descripcion
        FROM Rama
       WHERE Mayor = 'INV'
    ELSE IF ISNULL(@Movimiento, '') = 'CORTE.CORTECX'
      SELECT CONVERT(varchar(50),'(TODOS)')
      UNION ALL
      SELECT Descripcion
        FROM Rama
       WHERE Mayor = @Modulo    
    ELSE SELECT CONVERT(varchar(50),'(TODOS)')
  END ELSE IF @Campo = 'ALMACEN'
  BEGIN
    SELECT CONVERT(varchar(50),'(TODOS)')
    UNION ALL
    SELECT Almacen
      FROM Alm    
  END ELSE IF @Campo = 'CTAGRUPO'
  BEGIN
    IF ISNULL(@Movimiento, '') = 'CORTE.CORTECONTABLE'    
      SELECT CONVERT(varchar(50),'(TODOS)')
      UNION ALL
      SELECT Grupo
        FROM CtaGrupo
    ELSE IF ISNULL(@Movimiento, '') = 'CORTE.CORTEUNIDADES'    
      SELECT CONVERT(varchar(50),'(TODOS)')
      UNION ALL
      SELECT Grupo
        FROM ArtGrupo        
    ELSE IF ISNULL(@Movimiento, '') = 'CORTE.CORTECX'
    BEGIN
      IF ISNULL(@Modulo, '') = 'CXP'
        SELECT CONVERT(varchar(50),'(TODOS)')
      ELSE IF ISNULL(@Modulo, '') = 'CXC'
        SELECT CONVERT(varchar(50),'(TODOS)')        
        UNION ALL
        SELECT Grupo
          FROM CteGrupo
      ELSE SELECT CONVERT(varchar(50),'(TODOS)')
    END
    ELSE SELECT CONVERT(varchar(50),'(TODOS)')
  END ELSE IF @Campo = 'CTALINEA'
  BEGIN
    SELECT CONVERT(varchar(50),'(TODOS)')
    UNION ALL
    SELECT Linea
      FROM ArtLinea
  END ELSE IF @Campo = 'CTAFABRICANTE'
  BEGIN
    SELECT CONVERT(varchar(50),'(TODOS)')
    UNION ALL
    SELECT Fabricante
      FROM Fabricante
  END ELSE IF @Campo = 'DESGLOSAR'
  BEGIN
    IF ISNULL(@Movimiento, '') = 'CORTE.CORTECX'
      SELECT CONVERT(varchar(50),'No')
      UNION ALL
      SELECT CONVERT(varchar(50),'Contacto')
      UNION ALL
      SELECT CONVERT(varchar(50),'Movimiento')
    ELSE IF ISNULL(@Movimiento, '') = 'CORTE.CORTEIMPORTE'
      SELECT CONVERT(varchar(50),'No')
      UNION ALL
      SELECT CONVERT(varchar(50),'Movimiento')
      UNION ALL      
      SELECT CONVERT(varchar(50),'Periodo')
      UNION ALL      
      SELECT CONVERT(varchar(50),'Ejercicio')
    ELSE IF ISNULL(@Movimiento, '') = 'CORTE.CORTEUNIDADES'
    BEGIN
      SELECT CONVERT(varchar(50),'No')
       UNION ALL    
      SELECT CONVERT(varchar(50),'Articulo')
       UNION ALL
      SELECT CONVERT(varchar(50),'Movimiento')              
    END      
    ELSE IF ISNULL(@Movimiento, '') = 'CORTE.CORTECONTABLE'
    BEGIN
      IF ISNULL(@Cuenta, '') IN('', '(TODOS)')
      BEGIN
        SELECT CONVERT(varchar(50),'No')
        UNION ALL
        SELECT CONVERT(varchar(50),'Mayor')
        UNION ALL
        SELECT CONVERT(varchar(50),'SubCuenta')
        UNION ALL
        SELECT CONVERT(varchar(50),'Auxiliar')
        --UNION ALL
        --SELECT CONVERT(varchar(50),'Movimiento')        
      END
      ELSE
      BEGIN
        SELECT @CtaTipo = Tipo FROM Cta WHERE Cuenta = @Cuenta
        
        IF @CtaTipo = 'ESTRUCTURA'
        BEGIN
          SELECT CONVERT(varchar(50),'No')
          UNION ALL
          SELECT CONVERT(varchar(50),'Mayor')
          UNION ALL
          SELECT CONVERT(varchar(50),'SubCuenta')
          UNION ALL
          SELECT CONVERT(varchar(50),'Auxiliar')
          --UNION ALL
          --SELECT CONVERT(varchar(50),'Movimiento')          
        END
        ELSE IF @CtaTipo = 'MAYOR'
        BEGIN
          SELECT CONVERT(varchar(50),'No')
          UNION ALL
          SELECT CONVERT(varchar(50),'SubCuenta')
          UNION ALL
          SELECT CONVERT(varchar(50),'Auxiliar')
          --UNION ALL
          --SELECT CONVERT(varchar(50),'Movimiento')                    
        END
        ELSE IF @CtaTipo = 'SUBCUENTA'
        BEGIN
          SELECT CONVERT(varchar(50),'No')
          UNION ALL
          SELECT CONVERT(varchar(50),'Auxiliar')
          --UNION ALL
          --SELECT CONVERT(varchar(50),'Movimiento')                    
        END        
        ELSE IF @CtaTipo = 'AUXILIAR'
        BEGIN
          SELECT CONVERT(varchar(50),'No')
          UNION ALL
          SELECT CONVERT(varchar(50),'Auxiliar')
          --UNION ALL
          --SELECT CONVERT(varchar(50),'Movimiento')                    
        END
        ELSE
        BEGIN
          SELECT CONVERT(varchar(50),'No')
          UNION ALL
          SELECT CONVERT(varchar(50),'Mayor')
          UNION ALL
          SELECT CONVERT(varchar(50),'SubCuenta')
          UNION ALL
          SELECT CONVERT(varchar(50),'Auxiliar')
          --UNION ALL
          --SELECT CONVERT(varchar(50),'Movimiento')                    
        END
      END
    END
    ELSE SELECT CONVERT(varchar(50),'No')
  END
  
/*  
VTAS, CXC, ST, VALE, CAM = Cliente
COMS, CXP, GAS, AF = Proveedor
AGENT, CR = Agente
PACTO, DIN = Cliente, Proveedor, Agente
*/  
END
GO

--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'Empresa'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'Sucursal'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'UEN'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'USUARIO'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'MODULO'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'MOVIMIENTO', 'GES'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'MOVIMIENTO'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'Estatus'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'Situacion'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'Situacion', '(TODOS)', '(TODOS)'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'Situacion', 'VTAS', '(TODOS)'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'Situacion', 'VTAS', 'Factura'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'Situacion', 'VTAS', 'Factura', 'Sin Afectar'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'Situacion', 'VTAS', 'Factura', 'Pendiente'
--EXEC spNotificacionAyudaCaptura 'Notificacion Generica', 'Situacion', 'VTAS', 'Pedido', 'Pendiente'

                                    
/******************************* spNotificacionProcesarFiltro *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionProcesarFiltro') and type = 'P') drop procedure dbo.spNotificacionProcesarFiltro
GO             
CREATE PROCEDURE spNotificacionProcesarFiltro
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(20),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@GenerarNotificacion		bit = 0 OUTPUT,			    		
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
    
  SET @GenerarNotificacion = 0  

  SET @Importe = ISNULL(@Importe,0.0)

  IF NOT EXISTS(SELECT 1 FROM NotificacionFiltroNormalizada WHERE RTRIM(Notificacion) = RTRIM(@Notificacion)) 
    SELECT @GenerarNotificacion = 1
  ELSE
  BEGIN
    IF EXISTS(SELECT 1
                FROM NotificacionFiltroNormalizada
               WHERE LTRIM(RTRIM(Notificacion)) = LTRIM(RTRIM(@Notificacion))
                 AND LTRIM(RTRIM(ISNULL(Empresa,@Empresa))) = LTRIM(RTRIM(@Empresa))
                 AND ISNULL(Sucursal,@Sucursal) = @Sucursal
                 AND ISNULL(UEN,@UEN) = @UEN  
                 AND LTRIM(RTRIM(ISNULL(Usuario,@Usuario))) = LTRIM(RTRIM(@Usuario))
                 AND LTRIM(RTRIM(ISNULL(Modulo,@Modulo))) = LTRIM(RTRIM(@Modulo))                 
                 AND LTRIM(RTRIM(ISNULL(Movimiento,@Mov))) = LTRIM(RTRIM(@Mov))
                 AND LTRIM(RTRIM(ISNULL(Estatus,@Estatus))) = LTRIM(RTRIM(@Estatus))                 
                 AND LTRIM(RTRIM(ISNULL(Situacion,@Situacion))) = LTRIM(RTRIM(@Situacion))
                 AND LTRIM(RTRIM(ISNULL(Proyecto,@Proyecto))) = LTRIM(RTRIM(@Proyecto))
                 AND LTRIM(RTRIM(ISNULL(ContactoTipo,@ContactoTipo))) = LTRIM(RTRIM(@ContactoTipo))                 
                 AND LTRIM(RTRIM(ISNULL(Contacto,@Contacto))) = LTRIM(RTRIM(@Contacto))
                 AND @Importe BETWEEN ISNULL(ImporteMin,@Importe) AND ISNULL(ImporteMax,@Importe))
      SET @GenerarNotificacion = 1                                                 
  END    
END
GO

/******************************* spNotificacionPPGenerica *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionPPGenerica') and type = 'P') drop procedure dbo.spNotificacionPPGenerica
GO             
CREATE PROCEDURE spNotificacionPPGenerica
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),		
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(20),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@GenerarNotificacion		bit = 0 OUTPUT,			    		
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  SET @GenerarNotificacion = 1
  
  EXEC xpNotificacionPPGenerica @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @GenerarNotificacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  
END
GO

/******************************* spNotificacionPPAutorizacion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionPPAutorizacion') and type = 'P') drop procedure dbo.spNotificacionPPAutorizacion
GO             
CREATE PROCEDURE spNotificacionPPAutorizacion
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),		
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(20),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@GenerarNotificacion		bit = 0 OUTPUT,			    		
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  SET @GenerarNotificacion = 1
  
  EXEC xpNotificacionPPAutorizacion @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @GenerarNotificacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  
END
GO

/******************************* spNotificacionPMGenerica *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionPMGenerica') and type = 'P') drop procedure dbo.spNotificacionPMGenerica
GO             
CREATE PROCEDURE spNotificacionPMGenerica
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),		
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(50),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@EmpresaNombre				varchar(100),
		@SucursalNombre				varchar(100),
		@UENNombre					varchar(100),
		@UsuarioNombre				varchar(100),		
		@ContactoNombre				varchar(100),
		@FechaEmision				datetime,
		@Asunto						varchar(255) OUTPUT,			    		
		@Mensaje					varchar(max) OUTPUT,			    				
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
    
  EXEC xpNotificacionPMGenerica @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, @Asunto OUTPUT, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  
END
GO



/**************** fnNotificacionCadenaAutorizacion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionCadenaAutorizacion') DROP FUNCTION fnNotificacionCadenaAutorizacion
GO
CREATE FUNCTION fnNotificacionCadenaAutorizacion 
	(
    @Empresa					varchar(5),
    @Sucursal					int,
    @Modulo						varchar(5),
    @ID							int,
    @Estatus					varchar(15),
    @Situacion					varchar(50),
    @Usuario					varchar(10)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado			varchar(255),
  @SucursalTexto		varchar(20),
  @IDTexto				varchar(20),  
  @CheckSum				int,
  @CheckSumTexto		varchar(50)
  
  SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
  SET @SucursalTexto = LTRIM(RTRIM(CONVERT(varchar,ISNULL(@Sucursal,-1))))
  SET @Modulo = LTRIM(RTRIM(ISNULL(@Modulo,'')))
  SET @IDTexto = LTRIM(RTRIM(CONVERT(varchar,ISNULL(@ID,0))))
  SET @Estatus  = LTRIM(RTRIM(ISNULL(@Estatus,'')))
  SET @Situacion  = LTRIM(RTRIM(ISNULL(@Situacion,'')))
  SET @Usuario  = LTRIM(RTRIM(ISNULL(@Usuario,'')))
  
  SET @Checksum = CHECKSUM('AUT' + LTRIM(RTRIM(@@SERVERNAME)) + LTRIM(RTRIM(DB_NAME())) + @Empresa + @SucursalTexto + @Modulo + @IDTexto + @Estatus + @Situacion + @Usuario)  
  SET @CheckSumTexto = LTRIM(RTRIM(CONVERT(varchar,ISNULL(@Checksum,0))))
  
  SELECT @Resultado = '||AUTORIZACION|' + @Empresa + '|' + @SucursalTexto + '|' + @Modulo + '|' + @IDTexto + '|' + @Estatus + '|' + @Situacion + '|' + @Usuario + '|' + @ChecksumTexto + '||'
  
  RETURN @Resultado
END
GO

--SELECT dbo.fnNotificacionCadenaAutorizacion('DEMO', 0, 'VTAS', 1, 'PENDIENTE', 'POR AUTORIZAR', 'DEMO') 
--select checksum('DEMO' + '0' + 'VTAS' + '1' + 'POR AUTORIZAR' + 'DEMO')

/******************************* spNotificacionPMAutorizacion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionPMAutorizacion') and type = 'P') drop procedure dbo.spNotificacionPMAutorizacion
GO             
CREATE PROCEDURE spNotificacionPMAutorizacion
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),		
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(50),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@EmpresaNombre				varchar(100),
		@SucursalNombre				varchar(100),
		@UENNombre					varchar(100),
		@UsuarioNombre				varchar(100),		
		@ContactoNombre				varchar(100),
		@FechaEmision				datetime,
		@Asunto						varchar(255) OUTPUT,			    		
		@Mensaje					varchar(max) OUTPUT,			    				
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  SELECT @Mensaje = @Mensaje + CHAR(10) + CHAR(13) + dbo.fnNotificacionCadenaAutorizacion(@Empresa, @Sucursal, @Modulo, @ID, @Estatus, @Situacion, @Usuario)     
  
  EXEC xpNotificacionPMAutorizacion @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, @Asunto OUTPUT, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  
END
GO

/**************** fnNotificacionObtenerParametro ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNotificacionObtenerParametro') DROP FUNCTION fnNotificacionObtenerParametro
GO
CREATE FUNCTION fnNotificacionObtenerParametro 
	(
	@Notificacion				varchar(50), 
	@Parametro					varchar(100)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = ISNULL(Valor,'') FROM NotificacionParam WHERE Notificacion = @Notificacion AND Parametro = @Parametro
  
  RETURN (ISNULL(@Resultado,''))
END
GO

-- select dbo.fnNotificacionObtenerParametro('AUTORIZACION', 'MENSAJE CONFIRMACION')

/******************************* spNotificacionProcesarParametros *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionProcesarParametros') and type = 'P') drop procedure dbo.spNotificacionProcesarParametros
GO             
CREATE PROCEDURE spNotificacionProcesarParametros
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),		
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(20),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@GenerarNotificacion		bit = 0 OUTPUT,			    		
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  IF @NotificacionClave = 'GENERICA'     EXEC spNotificacionPPGenerica @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @GenerarNotificacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @NotificacionClave = 'AUTORIZACION' EXEC spNotificacionPPAutorizacion @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @GenerarNotificacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  
END
GO

/******************************* spNotificacionEvaluarConsulta *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionEvaluarConsulta') and type = 'P') drop procedure dbo.spNotificacionEvaluarConsulta
GO             
CREATE PROCEDURE spNotificacionEvaluarConsulta
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(20),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@EmpresaNombre				varchar(100),
		@SucursalNombre				varchar(100),
		@UENNombre					varchar(100),  
		@UsuarioNombre				varchar(100),		
		@ContactoNombre				varchar(100),
		@FechaEmision				datetime,
		@Consulta					nvarchar(max),			    		
		@Resultado					varchar(255) OUTPUT,
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Ahora				datetime,
  @Hoy					datetime,
  @SQL					nvarchar(max),
  @Parametros			nvarchar(max),
  @Error				int,
  @ErrorRef				varchar(255)
  
  SET @Ahora = GETDATE()
  SET @Hoy = dbo.fnFechaSinHora(@Ahora)
       
  SET @Consulta = REPLACE(@Consulta,'<Modulo>',CHAR(39) + ISNULL(RTRIM(@Modulo),'') + CHAR(39))           
  SET @Consulta = REPLACE(@Consulta,'<ID>',ISNULL(RTRIM(CONVERT(varchar,@ID)),''))
  SET @Consulta = REPLACE(@Consulta,'<Modulo>',CHAR(39) + ISNULL(RTRIM(@Modulo),'') + CHAR(39))  
  SET @Consulta = REPLACE(@Consulta,'<Empresa>',CHAR(39) + ISNULL(RTRIM(@Empresa),'') + CHAR(39))
  SET @Consulta = REPLACE(@Consulta,'<EmpresaNombre>',CHAR(39) + ISNULL(RTRIM(@EmpresaNombre),'') + CHAR(39))  
  SET @Consulta = REPLACE(@Consulta,'<Sucursal>',ISNULL(RTRIM(CONVERT(varchar,@Sucursal)),''))
  SET @Consulta = REPLACE(@Consulta,'<SucursalNombre>',CHAR(39) + ISNULL(RTRIM(@SucursalNombre),'') + CHAR(39))    
  SET @Consulta = REPLACE(@Consulta,'<UEN>',ISNULL(RTRIM(CONVERT(varchar,@UEN)),''))  
  SET @Consulta = REPLACE(@Consulta,'<UENNombre>',CHAR(39) + ISNULL(RTRIM(@UENNombre),'') + CHAR(39))    
  SET @Consulta = REPLACE(@Consulta,'<Usuario>',CHAR(39) + ISNULL(RTRIM(@Usuario),'') + CHAR(39))  
  SET @Consulta = REPLACE(@Consulta,'<UsuarioNombre>',CHAR(39) + ISNULL(RTRIM(@UsuarioNombre),'') + CHAR(39))    
  SET @Consulta = REPLACE(@Consulta,'<Movimiento>',CHAR(39) + ISNULL(RTRIM(@Mov),'') + CHAR(39))    
  SET @Consulta = REPLACE(@Consulta,'<Estatus>',CHAR(39) + ISNULL(RTRIM(@Estatus),'') + CHAR(39))      
  SET @Consulta = REPLACE(@Consulta,'<Situacion>',CHAR(39) + ISNULL(RTRIM(@Situacion),'') + CHAR(39))        
  SET @Consulta = REPLACE(@Consulta,'<Proyecto>',CHAR(39) + ISNULL(RTRIM(@Proyecto),'') + CHAR(39))          
  SET @Consulta = REPLACE(@Consulta,'<ContactoTipo>',CHAR(39) + ISNULL(RTRIM(@ContactoTipo),'') + CHAR(39))            
  SET @Consulta = REPLACE(@Consulta,'<Contacto>',CHAR(39) + ISNULL(RTRIM(@Contacto),'') + CHAR(39))              
  SET @Consulta = REPLACE(@Consulta,'<Importe>',ISNULL(RTRIM(CONVERT(varchar,@Importe)),''))    
  SET @Consulta = REPLACE(@Consulta,'<ContactoNombre>',CHAR(39) + ISNULL(RTRIM(@ContactoNombre),'') + CHAR(39))                
  SET @Consulta = REPLACE(@Consulta,'<Hoy>',CHAR(39) + ISNULL(RTRIM(CONVERT(varchar,@Hoy)),'') + CHAR(39))                
  SET @Consulta = REPLACE(@Consulta,'<Ahora>',CHAR(39) + ISNULL(RTRIM(CONVERT(varchar,@Ahora)),'') + CHAR(39))                  
  SET @Consulta = REPLACE(@Consulta,'<FechaEmision>',CHAR(39) + ISNULL(RTRIM(CONVERT(varchar,@FechaEmision)),'') + CHAR(39))                    
  SET @Consulta = REPLACE(@Consulta,'<Notificacion>',CHAR(39) + ISNULL(RTRIM(@Notificacion),'') + CHAR(39))        
  SET @Consulta = ISNULL(@Consulta,'')

  IF NULLIF(@Consulta,'') IS NOT NULL
  BEGIN
    SET @Parametros = N'@Resultado varchar(255) OUTPUT, @Error int OUTPUT, @ErrorRef varchar(255) OUTPUT'  
    
    SET @SQL = N'BEGIN TRY ' + 
               N'  SET @Resultado = (' + RTRIM(@Consulta) + ') ' + 
               N'END TRY ' + 
               N'BEGIN CATCH ' +
               N'  SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() ' +
               N'  IF XACT_STATE() = -1 ' +
               N'  BEGIN ' +
               N'    ROLLBACK TRAN ' +
               N'    SET @ErrorRef = ' + CHAR(39) + 'Error: ' + CHAR(39) + ' + CONVERT(varchar,@Error) + ' + CHAR(39) + ', ' + CHAR(39) + ' + @ErrorRef ' +
               N'    RAISERROR(@ErrorRef,20,1) WITH LOG ' +
               N'  END ' + 
               N'END CATCH ' 

    EXECUTE sp_executesql @SQL, @Parametros, 
            @Resultado = @Resultado OUTPUT,
            @Error = @Error OUTPUT, 
            @ErrorRef = @ErrorRef OUTPUT
            
    IF @Error IS NOT NULL SELECT @Ok = @Error, @OkRef = @ErrorRef
  END
  RETURN  
END
GO

/*
DECLARE 
@Resultado		varchar(255),
@Ok				int,
@OkRef			varchar(255) 

EXEC spNotificacionEvaluarConsulta 1, 'VTAS', 'Notificacion Generica', 'Generica', 'DEMO', 0, NULL, 'DEMO', 'Factura', 'CONCLUIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SELECT Mov FROM Venta WHERE ID = <ID>', @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
SELECT @Resultado, @Ok, @OkRef
*/


/******************************* spNotificacionCondicionUsuario *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionCondicionUsuario') and type = 'P') drop procedure dbo.spNotificacionCondicionUsuario
GO             
CREATE PROCEDURE spNotificacionCondicionUsuario
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(20),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@EmpresaNombre				varchar(100),
		@SucursalNombre				varchar(100),
		@UENNombre					varchar(100),  
		@UsuarioNombre				varchar(100),		
		@ContactoNombre				varchar(100),
		@FechaEmision				datetime,
		@CondicionUsuario			varchar(max),			    		
		@Resultado					bit OUTPUT,
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Ahora				datetime,
  @Hoy					datetime,
  @SQL					nvarchar(max),
  @Parametros			nvarchar(max),
  @Error				int,
  @ErrorRef				varchar(255),
  @nCondicionUsuario	nvarchar(max)
    
  SET @Ahora = GETDATE()
  SET @Hoy = dbo.fnFechaSinHora(@Ahora)
       
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Modulo>',CHAR(39) + ISNULL(RTRIM(@Modulo),'') + CHAR(39))           
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<ID>',ISNULL(RTRIM(CONVERT(varchar,@ID)),''))
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Modulo>',CHAR(39) + ISNULL(RTRIM(@Modulo),'') + CHAR(39))  
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Empresa>',CHAR(39) + ISNULL(RTRIM(@Empresa),'') + CHAR(39))
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<EmpresaNombre>',CHAR(39) + ISNULL(RTRIM(@EmpresaNombre),'') + CHAR(39))  
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Sucursal>',ISNULL(RTRIM(CONVERT(varchar,@Sucursal)),''))
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<SucursalNombre>',CHAR(39) + ISNULL(RTRIM(@SucursalNombre),'') + CHAR(39))    
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<UEN>',ISNULL(RTRIM(CONVERT(varchar,@UEN)),''))  
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<UENNombre>',CHAR(39) + ISNULL(RTRIM(@UENNombre),'') + CHAR(39))    
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Usuario>',CHAR(39) + ISNULL(RTRIM(@Usuario),'') + CHAR(39))  
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<UsuarioNombre>',CHAR(39) + ISNULL(RTRIM(@UsuarioNombre),'') + CHAR(39))    
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Movimiento>',CHAR(39) + ISNULL(RTRIM(@Mov),'') + CHAR(39))    
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Estatus>',CHAR(39) + ISNULL(RTRIM(@Estatus),'') + CHAR(39))      
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Situacion>',CHAR(39) + ISNULL(RTRIM(@Situacion),'') + CHAR(39))        
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Proyecto>',CHAR(39) + ISNULL(RTRIM(@Proyecto),'') + CHAR(39))          
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<ContactoTipo>',CHAR(39) + ISNULL(RTRIM(@ContactoTipo),'') + CHAR(39))            
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Contacto>',CHAR(39) + ISNULL(RTRIM(@Contacto),'') + CHAR(39))              
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Importe>',ISNULL(RTRIM(CONVERT(varchar,@Importe)),''))    
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<ContactoNombre>',CHAR(39) + ISNULL(RTRIM(@ContactoNombre),'') + CHAR(39))                
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Hoy>',CHAR(39) + ISNULL(RTRIM(CONVERT(varchar,@Hoy)),'') + CHAR(39))                
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<Ahora>',CHAR(39) + ISNULL(RTRIM(CONVERT(varchar,@Ahora)),'') + CHAR(39))                  
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,'<FechaEmision>',CHAR(39) + ISNULL(RTRIM(CONVERT(varchar,@FechaEmision)),'') + CHAR(39))                    

  SET @CondicionUsuario = REPLACE(@CondicionUsuario,CHAR(10),'')  
  SET @CondicionUsuario = REPLACE(@CondicionUsuario,CHAR(13),'')  
  SET @CondicionUsuario = ISNULL(RTRIM(@CondicionUsuario),'')

  IF NULLIF(RTRIM(@CondicionUsuario),'') IS NOT NULL
  BEGIN
   
    SET @nCondicionUsuario = @CondicionUsuario
    
    SET @Parametros = N'@Resultado bit OUTPUT, @Error int OUTPUT, @ErrorRef varchar(255) OUTPUT'  
    
    SET @SQL = N'BEGIN TRY ' + 
               N'  IF (' + RTRIM(@CondicionUsuario) + ') SET @Resultado = 1 ELSE SET @Resultado = 0 ' + 
               N'END TRY ' + 
               N'BEGIN CATCH ' +
               N'  SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() ' +
               N'  IF XACT_STATE() = -1 ' +
               N'  BEGIN ' +
               N'    ROLLBACK TRAN ' +
               N'    SET @ErrorRef = ' + CHAR(39) + 'Error: ' + CHAR(39) + ' + CONVERT(varchar,@Error) + ' + CHAR(39) + ', ' + CHAR(39) + ' + @ErrorRef ' +
               N'    RAISERROR(@ErrorRef,20,1) WITH LOG ' +
               N'  END ' + 
               N'END CATCH ' 

    EXECUTE sp_executesql @SQL, @Parametros, 
            @Resultado = @Resultado OUTPUT,
            @Error = @Error OUTPUT, 
            @ErrorRef = @ErrorRef OUTPUT
               
    IF @Error IS NOT NULL SELECT @Ok = @Error, @OkRef = @ErrorRef
  END
  
  SET @Resultado = ISNULL(@Resultado,0)  
  
  RETURN  
END
GO

/*
DECLARE 
@Resultado		varchar(255),
@Ok				int,
@OkRef			varchar(255) 

EXEC spNotificacionEvaluarConsulta 1, 'VTAS', 'Notificacion Generica', 'Generica', 'DEMO', 0, NULL, 'DEMO', 'Factura', 'CONCLUIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SELECT Mov FROM Venta WHERE ID = <ID>', @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
SELECT @Resultado, @Ok, @OkRef
*/

/******************************* spNotificacionEvaluarConsultas *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionEvaluarConsultas') and type = 'P') drop procedure dbo.spNotificacionEvaluarConsultas
GO             
CREATE PROCEDURE spNotificacionEvaluarConsultas
		@Estacion					int,
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(20),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,								
		@EmpresaNombre				varchar(100),
		@SucursalNombre				varchar(100),
		@UENNombre					varchar(100),  
		@UsuarioNombre				varchar(100),		
		@ContactoNombre				varchar(100),
		@FechaEmision				datetime,
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ConsultaNombre			varchar(50),
  @Consulta					varchar(max),
  @Resultado				varchar(255)

  DELETE FROM NotificacionConsultaTemp WHERE Estacion = @Estacion AND Notificacion = @Notificacion

  DECLARE crNotificacionConsulta CURSOR FOR
   SELECT ConsultaNombre, Consulta
     FROM NotificacionConsulta
    WHERE Notificacion = @Notificacion 

  OPEN crNotificacionConsulta
  FETCH NEXT FROM crNotificacionConsulta INTO @ConsultaNombre, @Consulta
  WHILE @@FETCH_STATUS = 0 AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN

    EXEC spNotificacionEvaluarConsulta @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, @Consulta, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
    BEGIN  
      IF NOT EXISTS(SELECT 1 FROM NotificacionConsultaTemp WHERE Estacion = @Estacion AND Notificacion = @Notificacion AND ConsultaNombre = @ConsultaNombre)  
      BEGIN
        INSERT NotificacionConsultaTemp (Estacion,  Notificacion,  ConsultaNombre,  Valor)
                                 VALUES (@Estacion, @Notificacion, @ConsultaNombre, ISNULL(@Resultado,''))  
        IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = @Notificacion                          
      END ELSE
      BEGIN
        UPDATE NotificacionConsultaTemp SET Valor = ISNULL(@Resultado,'') WHERE Estacion = @Estacion AND Notificacion = @Notificacion AND ConsultaNombre = @ConsultaNombre
        IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = @Notificacion                                
      END
    END
    FETCH NEXT FROM crNotificacionConsulta INTO @ConsultaNombre, @Consulta
  END
  CLOSE crNotificacionConsulta
  DEALLOCATE crNotificacionConsulta

  RETURN  
END
GO



/*
DECLARE 
@Ok				int,
@OkRef			varchar(255) 

DELETE FROM NotificacionConsulta WHERE Notificacion = 'Notificacion Generica'
INSERT NotificacionConsulta (Notificacion, ConsultaNombre, Consulta) VALUES ('Notificacion Generica', 'MiMov', 'SELECT Mov FROM Venta WHERE ID = <ID>')
INSERT NotificacionConsulta (Notificacion, ConsultaNombre, Consulta) VALUES ('Notificacion Generica', 'MiCte', 'SELECT Cliente FROM Venta WHERE ID = <ID>')


EXEC spNotificacionEvaluarConsultas @@SPID,  1, 'VTAS', 'Notificacion Generica', 'Generica', 'DEMO', 0, NULL, 'DEMO', 'Factura', 'CONCLUIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT
SELECT @Ok, @OkRef
SELECT * FROM NotificacionConsultaTemp
*/

/******************************* spNotificacionParsearMensaje *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionParsearMensaje') and type = 'P') drop procedure dbo.spNotificacionParsearMensaje
GO             
CREATE PROCEDURE spNotificacionParsearMensaje
		@Estacion					int,
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(50),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@EmpresaNombre				varchar(100),
		@SucursalNombre				varchar(100),
		@UENNombre					varchar(100),  
		@UsuarioNombre				varchar(100),		
		@ContactoNombre				varchar(100),
		@FechaEmision				datetime,
		@Asunto						varchar(255) OUTPUT,
		@Mensaje					varchar(max) OUTPUT,			    		
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT,
		-- 11326
		@RutaAnexo					varchar(255) = NULL OUTPUT,
		@NombreAnexo				varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @eDoc					varchar(max),
  @Ahora				datetime,
  @Hoy					datetime,
  @ConsultaNombre		varchar(50),
  @Valor				varchar(255)


  IF @NotificacionClave = 'GENERICA'     EXEC spNotificacionPMGenerica @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, @Asunto OUTPUT, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
  IF @NotificacionClave = 'AUTORIZACION' EXEC spNotificacionPMAutorizacion @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, @Asunto OUTPUT, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  
  SET @Ahora = GETDATE()
  SET @Hoy = dbo.fnFechaSinHora(@Ahora)
       
  SELECT @eDoc = ISNULL(eDoc,'') FROM MoveDoc WHERE Modulo = @Modulo AND ID = @ID

  SET @Asunto = REPLACE(@Asunto,'<Empresa>',ISNULL(RTRIM(@Empresa),''))
  SET @Asunto = REPLACE(@Asunto,'<EmpresaNombre>',ISNULL(RTRIM(@EmpresaNombre),''))  
  SET @Asunto = REPLACE(@Asunto,'<Sucursal>',ISNULL(RTRIM(CONVERT(varchar,@Sucursal)),''))
  SET @Asunto = REPLACE(@Asunto,'<SucursalNombre>',ISNULL(RTRIM(@SucursalNombre),''))    
  SET @Asunto = REPLACE(@Asunto,'<UEN>',ISNULL(RTRIM(CONVERT(varchar,@UEN)),''))  
  SET @Asunto = REPLACE(@Asunto,'<UENNombre>',ISNULL(RTRIM(@UENNombre),''))    
  SET @Asunto = REPLACE(@Asunto,'<Usuario>',ISNULL(RTRIM(@Usuario),''))  
  SET @Asunto = REPLACE(@Asunto,'<UsuarioNombre>',ISNULL(RTRIM(@UsuarioNombre),''))    
  SET @Asunto = REPLACE(@Asunto,'<Notificacion>',ISNULL(RTRIM(@Notificacion),''))        
  SET @Asunto = REPLACE(@Asunto,'<Modulo>',ISNULL(RTRIM(@Modulo),''))      
  SET @Asunto = REPLACE(@Asunto,'<Movimiento>',ISNULL(RTRIM(@Mov),''))    
  SET @Asunto = REPLACE(@Asunto,'<Estatus>',ISNULL(RTRIM(@Estatus),''))      
  SET @Asunto = REPLACE(@Asunto,'<Situacion>',ISNULL(RTRIM(@Situacion),''))        
  SET @Asunto = REPLACE(@Asunto,'<Proyecto>',ISNULL(RTRIM(@Proyecto),''))          
  SET @Asunto = REPLACE(@Asunto,'<ContactoTipo>',ISNULL(RTRIM(@ContactoTipo),''))            
  SET @Asunto = REPLACE(@Asunto,'<Contacto>',ISNULL(RTRIM(@Contacto),''))              
  SET @Asunto = REPLACE(@Asunto,'<Importe>',ISNULL(RTRIM(CONVERT(varchar,@Importe)),''))  
  SET @Asunto = REPLACE(@Asunto,'<ContactoNombre>',ISNULL(RTRIM(@ContactoNombre),''))                
  SET @Asunto = REPLACE(@Asunto,'<Hoy>',ISNULL(RTRIM(CONVERT(varchar,@Hoy)),''))                
  SET @Asunto = REPLACE(@Asunto,'<Ahora>',ISNULL(RTRIM(CONVERT(varchar,@Ahora)),''))                  
  SET @Asunto = REPLACE(@Asunto,'<FechaEmision>',ISNULL(RTRIM(CONVERT(varchar,@FechaEmision)),''))                    
  
  SET @Mensaje = REPLACE(@Mensaje,'<Empresa>',ISNULL(RTRIM(@Empresa),''))
  SET @Mensaje = REPLACE(@Mensaje,'<EmpresaNombre>',ISNULL(RTRIM(@EmpresaNombre),''))  
  SET @Mensaje = REPLACE(@Mensaje,'<Sucursal>',ISNULL(RTRIM(CONVERT(varchar,@Sucursal)),''))
  SET @Mensaje = REPLACE(@Mensaje,'<SucursalNombre>',ISNULL(RTRIM(@SucursalNombre),''))    
  SET @Mensaje = REPLACE(@Mensaje,'<UEN>',ISNULL(RTRIM(CONVERT(varchar,@UEN)),''))  
  SET @Mensaje = REPLACE(@Mensaje,'<UENNombre>',ISNULL(RTRIM(@UENNombre),''))    
  SET @Mensaje = REPLACE(@Mensaje,'<Usuario>',ISNULL(RTRIM(@Usuario),''))  
  SET @Mensaje = REPLACE(@Mensaje,'<UsuarioNombre>',ISNULL(RTRIM(@UsuarioNombre),''))    
  SET @Mensaje = REPLACE(@Mensaje,'<Notificacion>',ISNULL(RTRIM(@Notificacion),''))        
  SET @Mensaje = REPLACE(@Mensaje,'<Modulo>',ISNULL(RTRIM(@Modulo),''))      
  SET @Mensaje = REPLACE(@Mensaje,'<Movimiento>',ISNULL(RTRIM(@Mov),''))    
  SET @Mensaje = REPLACE(@Mensaje,'<Estatus>',ISNULL(RTRIM(@Estatus),''))      
  SET @Mensaje = REPLACE(@Mensaje,'<Situacion>',ISNULL(RTRIM(@Situacion),''))        
  SET @Mensaje = REPLACE(@Mensaje,'<Proyecto>',ISNULL(RTRIM(@Proyecto),''))          
  SET @Mensaje = REPLACE(@Mensaje,'<ContactoTipo>',ISNULL(RTRIM(@ContactoTipo),''))            
  SET @Mensaje = REPLACE(@Mensaje,'<Contacto>',ISNULL(RTRIM(@Contacto),''))              
  SET @Mensaje = REPLACE(@Mensaje,'<Importe>',ISNULL(RTRIM(CONVERT(varchar,@Importe)),''))    
  SET @Mensaje = REPLACE(@Mensaje,'<ContactoNombre>',ISNULL(RTRIM(@ContactoNombre),''))              
  SET @Mensaje = REPLACE(@Mensaje,'<eDoc>',ISNULL(RTRIM(@eDoc),''))              
  SET @Mensaje = REPLACE(@Mensaje,'<Hoy>',ISNULL(RTRIM(CONVERT(varchar,@Hoy)),''))                  
  SET @Mensaje = REPLACE(@Mensaje,'<Ahora>',ISNULL(RTRIM(CONVERT(varchar,@Ahora)),''))                    
  SET @Mensaje = REPLACE(@Mensaje,'<FechaEmision>',ISNULL(RTRIM(CONVERT(varchar,@FechaEmision)),''))                    

  -- 11326
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Empresa>',ISNULL(RTRIM(@Empresa),''))
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<EmpresaNombre>',ISNULL(RTRIM(@EmpresaNombre),''))  
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Sucursal>',ISNULL(RTRIM(CONVERT(varchar,@Sucursal)),''))
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<SucursalNombre>',ISNULL(RTRIM(@SucursalNombre),''))    
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<UEN>',ISNULL(RTRIM(CONVERT(varchar,@UEN)),''))  
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<UENNombre>',ISNULL(RTRIM(@UENNombre),''))    
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Usuario>',ISNULL(RTRIM(@Usuario),''))  
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<UsuarioNombre>',ISNULL(RTRIM(@UsuarioNombre),''))    
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Notificacion>',ISNULL(RTRIM(@Notificacion),''))        
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Modulo>',ISNULL(RTRIM(@Modulo),''))      
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Movimiento>',ISNULL(RTRIM(@Mov),''))    
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Estatus>',ISNULL(RTRIM(@Estatus),''))      
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Situacion>',ISNULL(RTRIM(@Situacion),''))        
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Proyecto>',ISNULL(RTRIM(@Proyecto),''))          
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<ContactoTipo>',ISNULL(RTRIM(@ContactoTipo),''))            
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Contacto>',ISNULL(RTRIM(@Contacto),''))              
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Importe>',ISNULL(RTRIM(CONVERT(varchar,@Importe)),''))    
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<ContactoNombre>',ISNULL(RTRIM(@ContactoNombre),''))              
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<eDoc>',ISNULL(RTRIM(@eDoc),''))              
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Hoy>',ISNULL(RTRIM(CONVERT(varchar,@Hoy)),''))                  
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<Ahora>',ISNULL(RTRIM(CONVERT(varchar,@Ahora)),''))                    
  SET @RutaAnexo = REPLACE(@RutaAnexo,'<FechaEmision>',ISNULL(RTRIM(CONVERT(varchar,@FechaEmision)),''))   

  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Empresa>',ISNULL(RTRIM(@Empresa),''))
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<EmpresaNombre>',ISNULL(RTRIM(@EmpresaNombre),''))  
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Sucursal>',ISNULL(RTRIM(CONVERT(varchar,@Sucursal)),''))
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<SucursalNombre>',ISNULL(RTRIM(@SucursalNombre),''))    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<UEN>',ISNULL(RTRIM(CONVERT(varchar,@UEN)),''))  
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<UENNombre>',ISNULL(RTRIM(@UENNombre),''))    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Usuario>',ISNULL(RTRIM(@Usuario),''))  
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<UsuarioNombre>',ISNULL(RTRIM(@UsuarioNombre),''))    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Notificacion>',ISNULL(RTRIM(@Notificacion),''))        
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Modulo>',ISNULL(RTRIM(@Modulo),''))      
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Movimiento>',ISNULL(RTRIM(@Mov),''))    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Estatus>',ISNULL(RTRIM(@Estatus),''))      
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Situacion>',ISNULL(RTRIM(@Situacion),''))        
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Proyecto>',ISNULL(RTRIM(@Proyecto),''))          
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<ContactoTipo>',ISNULL(RTRIM(@ContactoTipo),''))            
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Contacto>',ISNULL(RTRIM(@Contacto),''))              
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Importe>',ISNULL(RTRIM(CONVERT(varchar,@Importe)),''))    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<ContactoNombre>',ISNULL(RTRIM(@ContactoNombre),''))              
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<eDoc>',ISNULL(RTRIM(@eDoc),''))              
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Hoy>',ISNULL(RTRIM(CONVERT(varchar,@Hoy)),''))                  
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<Ahora>',ISNULL(RTRIM(CONVERT(varchar,@Ahora)),''))                    
  SET @NombreAnexo = REPLACE(@NombreAnexo,'<FechaEmision>',ISNULL(RTRIM(CONVERT(varchar,@FechaEmision)),''))                    
  
  DECLARE crNotificacionConsultaTemp CURSOR FOR
   SELECT '<' + RTRIM(ISNULL(ConsultaNombre,'')) + '>', RTRIM(ISNULL(Valor,''))
     FROM NotificacionConsultaTemp
    WHERE Notificacion = @Notificacion
      AND Estacion = @Estacion

  OPEN crNotificacionConsultaTemp
  FETCH NEXT FROM crNotificacionConsultaTemp INTO @ConsultaNombre, @Valor
  WHILE @@FETCH_STATUS = 0 AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    SET @Asunto = REPLACE(@Asunto,@ConsultaNombre,@Valor)                        
    SET @Mensaje = REPLACE(@Mensaje,@ConsultaNombre,@Valor)                        
    
    -- 11326
    SET @RutaAnexo = REPLACE(@RutaAnexo,@ConsultaNombre,@Valor)                        
    SET @NombreAnexo = REPLACE(@NombreAnexo,@ConsultaNombre,@Valor)                        
        
    FETCH NEXT FROM crNotificacionConsultaTemp INTO @ConsultaNombre, @Valor
  END
  CLOSE crNotificacionConsultaTemp
  DEALLOCATE crNotificacionConsultaTemp
  
  SELECT @Mensaje = REPLACE(@Mensaje,'<','&#060;')  
  SELECT @Mensaje = REPLACE(@Mensaje,'>','&#062;')  
END
GO

/******************************* spNotificacionVerificarVigencia *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionVerificarVigencia') and type = 'P') drop procedure dbo.spNotificacionVerificarVigencia
GO             
CREATE PROCEDURE spNotificacionVerificarVigencia
		@Notificacion				varchar(50),
		@FechaEmision				datetime,
		@GenerarNotificacion		bit OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  IF EXISTS(SELECT 1 FROM NotificacionVigencia WHERE Notificacion = @Notificacion)
  BEGIN
    IF NOT EXISTS(SELECT 1 FROM NotificacionVigencia WHERE Notificacion = @Notificacion AND @FechaEmision BETWEEN dbo.fnFechaSinHora(FechaD) AND dbo.fnFechaSinHora(FechaA)) SET @GenerarNotificacion = 0 
  END  
  RETURN  
END
GO

/**************** fnHoraEnEntero ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnHoraEnEntero') DROP FUNCTION fnHoraEnEntero
GO
CREATE FUNCTION fnHoraEnEntero 
	(
	@Hora				varchar(5) 
	)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado		int,
  @HoraEntero		int,
  @MinutoEntero		int

  SET @HoraEntero = ISNULL(CONVERT(int,SUBSTRING(@Hora,1,2)),0)
  SET @MinutoEntero = ISNULL(CONVERT(int,SUBSTRING(@Hora,4,2)),0)  

  SET @Resultado = (@HoraEntero * 60) + @MinutoEntero
  RETURN (@Resultado)
END
GO

--SELECT dbo.fnHoraEnEntero('17:25')
/******************************* spNotificacionVerificarVigenciaHora *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionVerificarVigenciaHora') and type = 'P') drop procedure dbo.spNotificacionVerificarVigenciaHora
GO             
CREATE PROCEDURE spNotificacionVerificarVigenciaHora
		@Notificacion				varchar(50),
		@FechaRegistro				datetime,
		@GenerarNotificacion		bit OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @FechaActual			datetime,
  @Hora					varchar(2),
  @Minuto				varchar(2),  
  @HoraActual			varchar(5),
  @HoraActualEntero		int

  SET @FechaActual = @FechaRegistro
  
  SET @Hora = RTRIM(LTRIM(CONVERT(varchar,DATEPART(hh,@FechaActual))))
  SET @Hora = CASE WHEN LEN(@Hora) = 1 THEN '0' + @Hora ELSE @Hora END
  
  SET @Minuto = RTRIM(LTRIM(CONVERT(varchar,DATEPART(mi,@FechaActual))))
  SET @Minuto = CASE WHEN LEN(@Minuto) = 1 THEN '0' + @Minuto ELSE @Minuto END
  
  SET @HoraActual = @Hora + CHAR(58) + @Minuto

  SET @HoraActualEntero = dbo.fnHoraEnEntero(@HoraActual)
  IF EXISTS(SELECT 1 FROM NotificacionVigenciaHora WHERE Notificacion = @Notificacion)
  BEGIN
    IF NOT EXISTS(SELECT 1 FROM NotificacionVigenciaHora WHERE Notificacion = @Notificacion AND @HoraActualEntero BETWEEN dbo.fnHoraEnEntero(HoraD) AND dbo.fnHoraEnEntero(HoraA)) SET @GenerarNotificacion = 0 
  END  
  RETURN  
END
GO

/*
--DELETE FROM NotificacionVigencia
--INSERT NotificacionVigencia (Notificacion, FechaD, FechaA) VALUES ('Notificacion Generica', CONVERT(datetime,'01/05/2011'), CONVERT(datetime,'31/05/2011'))
--INSERT NotificacionVigencia (Notificacion, FechaD, FechaA) VALUES ('Notificacion Generica', CONVERT(datetime,'15/06/2011'), CONVERT(datetime,'01/07/2011'))

DECLARE @GenerarNotificacion		bit
SET @GenerarNotificacion = 1
exec spNotificacionVerificarVigencia 'Notificacion Generica', '15/05/2011', @GenerarNotificacion OUTPUT
SELECT @GenerarNotificacion
*/

-- 11326
/****************************** spAnexoMovAdjuntarLista ******************************/
if exists (select * from sysobjects where id = object_id('dbo.spAnexoMovAdjuntarLista') and type in ('p')) drop proc dbo.spAnexoMovAdjuntarLista
GO
CREATE PROC spAnexoMovAdjuntarLista
			@Modulo			varchar(5), 
			@ID				int,
			@Nombre			varchar(255),
			@Archivo		varchar(max)		OUTPUT,
			@Ok				int			 = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Direccion	varchar(255),
		  @Existe		bit
  
  SELECT @Nombre = '%' + REPLACE(@Nombre, '*', '%')
    
  DECLARE @IDR		int,
		  @IDRAnt	int

  SELECT @IDRAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @IDR = MIN(IDR)
      FROM AnexoMov
     WHERE Rama = @Modulo
       AND ID = @ID
       AND Direccion LIKE @Nombre
       AND IDR > @IDRAnt

    IF @IDR IS NULL BREAK
    
    SELECT @IDRAnt = @IDR
    
    SELECT @Direccion = Direccion FROM AnexoMov WHERE Rama = @Modulo AND ID = @ID AND IDR = @IDR
    
    EXEC spVerificarArchivo @Direccion, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  
    
    IF @Existe = 1
      SELECT @Archivo = ISNULL(@Archivo, '') + @Direccion + ';'    
  END

  IF RIGHT(@Archivo, 1) = ';'
    SELECT @Archivo = SUBSTRING(@Archivo, 1, LEN(@Archivo) - 1)      
END
GO

-- 11326
/**************** spNotificacionAnexo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'spNotificacionAnexo') DROP PROC spNotificacionAnexo
GO
CREATE PROC spNotificacionAnexo
		@Estacion					int,
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(50),
		@MovID						varchar(50),
		@Movimiento					varchar(50),		
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@EmpresaNombre				varchar(100),
		@SucursalNombre				varchar(100),
		@UENNombre					varchar(100),  
		@UsuarioNombre				varchar(100),		
		@ContactoNombre				varchar(100),
		@FechaEmision				datetime,
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT,
		@Anexos						varchar(max) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @RID					int,
		  @RIDAnt				int,
		  @Tipo					varchar(50),
		  @Ruta					varchar(255),
		  @Nombre				varchar(255),
		  @Existe				bit,
		  @Archivo				varchar(500),
		  @eDoc					varchar(max),
          @ManejadorObjeto		int, 
		  @IDArchivo			int,
		  @IDR					int,
		  @IDRAnt				int

  SELECT @Anexos = ''
  
  SELECT @RIDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @RID = MIN(RID)
      FROM NotificacionAnexo
     WHERE Notificacion = @Notificacion
       AND RID > @RIDAnt

    --BUG15887
    SELECT @Ok = NULL

    IF @RID IS NULL BREAK
    
    SELECT @RIDAnt = @RID 
    
    SELECT @Tipo = Tipo, @Ruta = dbo.fnDirectorioEliminarDiagonalFinal(Ruta), @Nombre = Nombre FROM NotificacionAnexo WHERE Notificacion = @Notificacion AND RID = @RID

    EXEC spNotificacionParsearMensaje @@SPID, @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Movimiento, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT, @Ruta OUTPUT, @Nombre OUTPUT
    
    IF @Tipo = 'Especifico'
    BEGIN
      SELECT @Archivo = ISNULL(@Ruta, '') + '\' + ISNULL(@Nombre, '')    
      
      EXEC spVerificarArchivo @Archivo, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  
      
      IF @Existe = 0 SELECT @Ok = 1
    END
    ELSE IF @Tipo = 'Documento Electronico'
    BEGIN
      SELECT @Archivo = ISNULL(@Ruta, '') + '\' + ISNULL(@Nombre, '')    
      
      SELECT @eDoc = eDoc FROM MoveDoc WHERE Modulo = @Modulo AND ID = @ID
      
      IF ISNULL(@eDoc, '') <> ''
      BEGIN
        EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT  
      
        IF @Ok IS NULL
          EXEC spCrearArchivo @Archivo, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF @Ok IS NULL
          EXEC spInsertaTextoEnArchivo @IDArchivo, @eDoc, @Ok OUTPUT, @OkRef OUTPUT  
    
        IF @Ok IS NULL
          EXEC spCerrarArchivo @IDArchivo, @ManejadorObjeto, @Ok OUTPUT, @OkRef OUTPUT  

        IF @Ok IS NULL AND NOT EXISTS(SELECT IDR FROM AnexoMov WHERE Rama = @Modulo AND ID = @ID AND Tipo = 'Archivo' AND Nombre = @Nombre)
          INSERT INTO AnexoMov(Rama, ID, Nombre, Direccion, Icono, Tipo, Usuario, CFD) SELECT @Modulo, @ID, @Nombre, @Ruta, 66, 'Archivo', @Usuario, 1 --BUG13668
      END
    END
    ELSE IF @Tipo = 'Anexo'
    BEGIN
      SELECT @Archivo = ''
      
      EXEC spAnexoMovAdjuntarLista @Modulo, @ID, @Nombre, @Archivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    END

    IF @Ok IS NULL AND RTRIM(ISNULL(@Archivo, '')) <> '' -- BUG13650
      SELECT @Anexos = @Anexos + @Archivo + ';'    
  END

  IF RIGHT(@Anexos, 1) = ';'
    SELECT @Anexos = SUBSTRING(@Anexos, 1, LEN(@Anexos) - 1)    
END
GO

/******************************* spNotificacionInsertarIS *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacionInsertarIS') and type = 'P') drop procedure dbo.spNotificacionInsertarIS
GO             
CREATE PROCEDURE spNotificacionInsertarIS
		@Empresa					varchar(5),
		@Usuario					varchar(10),
		@Notificacion				varchar(50),
		@Modulo						varchar(5),
		@ModuloID					int,
		@MedioComunicacion			varchar(15),
		@FechaNotificacion			datetime,		
		@TipoFechaNotificacion		varchar(50),
		@AnticipacionFechaTipo		varchar(20),
		@AnticipacionFecha			int,
		@Vencimiento				datetime,		
		@Para						varchar(max),
		@CC							varchar(max),
		@CCO						varchar(max),
		@Asunto						varchar(255),
		@Mensaje					varchar(max),
		-- 11326
		@Anexos						varchar(max),
		@Ok							int			 OUTPUT,
		@OkRef						varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Solicitud				varchar(max),
  @FechaXML					varchar(50),
  @ModuloIDXML				varchar(20),
  @Hoy						datetime,
  @Contrasena				varchar(32),
  @Resultado				varchar(max),
  @IntelisisServiceID		int,
  @NotificacionXML			varchar(50),
  @ModuloXML				varchar(5),
  @ParaXML					varchar(max),
  @CCXML					varchar(max),
  @CCOXML					varchar(max),
  @AsuntoXML				varchar(255),
  @MensajeXML				varchar(max),  
  @TipoFechaNotificacionXML	varchar(50),
  @AnticipacionFechaTipoXML	varchar(20),
  @AnticipacionFechaXML		varchar(20),
  @VencimientoXML			varchar(50),		  
  @Filtros					varchar(max),
  
  -- 11326
  @AnexosXML				varchar(max)

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario

  SET @Filtros = 
  (SELECT
     NULLIF(dbo.fneDocXMLAUTF8(Empresa,0,1),'') Empresa,
     Sucursal Sucursal,
     UEN UEN,     
     NULLIF(dbo.fneDocXMLAUTF8(Usuario,0,1),'') Usuario,          
     NULLIF(dbo.fneDocXMLAUTF8(Modulo,0,1),'') Modulo,               
     NULLIF(dbo.fneDocXMLAUTF8(Movimiento,0,1),'') Movimiento,                    
     NULLIF(dbo.fneDocXMLAUTF8(Estatus,0,1),'') Estatus,                         
     NULLIF(dbo.fneDocXMLAUTF8(Situacion,0,1),'') Situacion,                              
     NULLIF(dbo.fneDocXMLAUTF8(Proyecto,0,1),'') Proyecto,                                   
     NULLIF(dbo.fneDocXMLAUTF8(ContactoTipo,0,1),'') ContactoTipo,                                        
     NULLIF(dbo.fneDocXMLAUTF8(Contacto,0,1),'') Contacto,                                             
     NULLIF(ImporteMax,0) ImporteMax,
     NULLIF(ImporteMin,0) ImporteMin                                                  
     FROM NotificacionFiltroNormalizada
    WHERE RTRIM(Notificacion) = RTRIM(@Notificacion)
      AND ValidarAlEmitir = 1  
      FOR XML RAW('Filtro'))
  
  IF NULLIF(@Filtros,'') IS NOT NULL SET @Filtros = '<Filtros>' + @Filtros + '</Filtros>'

  SET @Hoy = dbo.fnFechaSinHora(GETDATE())
  SET @MedioComunicacion = UPPER(@MedioComunicacion)
  
  SET @NotificacionXML = dbo.fneDocXMLAUTF8(ISNULL(@Notificacion,''),0,1)    
  SET @ModuloXML = dbo.fneDocXMLAUTF8(ISNULL(@Modulo,''),0,1)  
  SET @ModuloIDXML = LTRIM(RTRIM(CONVERT(varchar,ISNULL(@ModuloID,0))))
  SET @FechaXML = RTRIM(CONVERT(varchar,ISNULL(@FechaNotificacion,@Hoy),126))  
  SET @TipoFechaNotificacionXML = RTRIM(dbo.fneDocXMLAUTF8(ISNULL(@TipoFechaNotificacion,''),0,1))
  SET @AnticipacionFechaTipoXML = RTRIM(dbo.fneDocXMLAUTF8(ISNULL(@AnticipacionFechaTipo,''),0,1))
  SET @AnticipacionFechaXML = RTRIM(CONVERT(varchar,ISNULL(@AnticipacionFecha,0)))  
  SET @VencimientoXML = RTRIM(CONVERT(varchar,ISNULL(@Vencimiento,@Hoy),126))  
  SET @ParaXML = dbo.fneDocXMLAUTF8(ISNULL(@Para,''),0,1)
  SET @CCXML = dbo.fneDocXMLAUTF8(ISNULL(@CC,''),0,1)  
  SET @CCOXML = dbo.fneDocXMLAUTF8(ISNULL(@CCO,''),0,1)    
  SET @AsuntoXML = dbo.fneDocXMLAUTF8(ISNULL(@Asunto,''),0,1)      
  SET @MensajeXML = dbo.fneDocXMLAUTF8(ISNULL(@Mensaje,''),0,1)
  -- 11326
  SET @AnexosXML = dbo.fneDocXMLAUTF8(ISNULL(@Anexos,''),0,1)
  
  SET @Solicitud = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Notificacion" SubReferencia="' + @MedioComunicacion + '" Version="1.0">' +
                   '  <Solicitud>' +                    
                   '    <Notificacion Empresa = "' + @Empresa + '" Fecha="' + @FechaXML  + '" TipoFechaNotificacion="' + @TipoFechaNotificacionXML  + '" AnticipacionFechaTipo="' + @AnticipacionFechaTipoXML  + '" AnticipacionFecha="' + @AnticipacionFechaXML + '" Vencimiento="' + @VencimientoXML + '" Para="' + @ParaXML + '" CC="' + @CCXML + '" CCO="' + @CCOXML + '" Asunto="' + @AsuntoXML + '" Mensaje="' + @MensajeXML + '" Modulo="' + @ModuloXML + '" ModuloID="' + @ModuloIDXML + '" NotificacionNombre="' + @NotificacionXML + '" Anexos="' + @AnexosXML +'" />' +
                   @Filtros +                    
                   '  </Solicitud>' +
                   '</Intelisis>'
  
  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IntelisisServiceID OUTPUT                           
      
  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    INSERT NotificacionHist (Fecha,     IntelisisServiceID,  Empresa,  Modulo,  ModuloID,  FechaNotificacion,  Notificacion,  Asunto,  Mensaje,  Para,  CC,  CCO,  Anexos)
                     VALUES (GETDATE(), @IntelisisServiceID, @Empresa, @Modulo, @ModuloID, @FechaNotificacion, @Notificacion, @Asunto, @Mensaje, @Para, @CC, @CCO, @Anexos) 	
    IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = 'NotificacionHist' 				   			   	
  END                            
END
GO

/******************************* spNotificacion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spNotificacion') and type = 'P') drop procedure dbo.spNotificacion
GO             
CREATE PROCEDURE spNotificacion
		@ID							int,
		@Modulo						varchar(5),
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Notificacion				varchar(50),
  @NotificacionClave		varchar(50),
  @Empresa					varchar(5),
  @Sucursal					int,
  @UEN						int,
  @Usuario					varchar(10),
  @Mov						varchar(20),
  @MovID					varchar(20),  
  @Estatus					varchar(15),
  @Situacion				varchar(50),
  @Proyecto					varchar(50),  
  @ContactoTipo				varchar(20),    
  @Contacto					varchar(10),      
  @Importe					float,
  @FechaEmision				datetime,
  @GenerarNotificacion		bit,
  @Asunto					varchar(255),
  @Mensaje					varchar(max),
  @Para						varchar(max),
  @CC						varchar(max),
  @CCO						varchar(max),
  @EmpresaNombre			varchar(100),
  @SucursalNombre			varchar(100),
  @UENNombre				varchar(100),  
  @UsuarioNombre			varchar(100),
  @ContactoNombre			varchar(100),
  @Vencimiento				datetime,
  @TipoFechaNotificacion	varchar(50),
  @FechaNotificacion		datetime,
  @AnticipacionFechaTipo	varchar(20),  
  @AnticipacionFecha		int,
  @MedioComunicacion		varchar(15),
  @CondicionUsuario			varchar(max),
  @FechaRegistro			datetime,
  @Movimiento				varchar(50),
  
  -- 11326
  @Anexos					varchar(8000)
  
  EXEC spMovInfo @ID, @Modulo, @Empresa = @Empresa OUTPUT, @Sucursal = @Sucursal OUTPUT, @UEN = @UEN OUTPUT, @Usuario = @Usuario OUTPUT, @Mov = @Mov OUTPUT, @MovID = @MovID OUTPUT, @Estatus = @Estatus OUTPUT, @Situacion = @Situacion OUTPUT, @Proyecto = @Proyecto OUTPUT, @CtoTipo = @ContactoTipo OUTPUT, @Contacto = @Contacto OUTPUT, @Importe = @Importe OUTPUT, @FechaEmision = @FechaEmision OUTPUT, @Vencimiento = @Vencimiento OUTPUT, @FechaRegistro = @FechaRegistro OUTPUT

  SET @Empresa      = ISNULL(@Empresa,'')
  SET @Sucursal     = ISNULL(@Sucursal,-1)
  SET @UEN          = ISNULL(@UEN,-1)
  SET @Usuario      = ISNULL(@Usuario,'')
  SET @Modulo       = ISNULL(@Modulo,'')  
  SET @Mov          = LTRIM(RTRIM(ISNULL(@Mov,'')))
  SET @MovID        = LTRIM(RTRIM(ISNULL(@MovID,'')))  
  SET @Estatus      = ISNULL(@Estatus,'')
  SET @Situacion    = ISNULL(@Situacion,'')
  SET @Proyecto     = ISNULL(@Proyecto,'')  
  SET @ContactoTipo = ISNULL(@ContactoTipo,'')    
  SET @Contacto     = ISNULL(@Contacto,'')      
  SET @Importe      = ISNULL(@Importe,0.0)
  SET @Vencimiento  = ISNULL(@Vencimiento,@FechaEmision)

  --BUG15884
  IF @FechaRegistro IS NULL
    SELECT @FechaRegistro = GETDATE()
  
  SET @Movimiento = @Mov + ' ' + @MovID  
  
  SELECT @EmpresaNombre  = ISNULL(Nombre,'') FROM Empresa WHERE Empresa = @Empresa     
  SELECT @SucursalNombre = ISNULL(Nombre,'') FROM Sucursal WHERE Sucursal = @Sucursal  
  SELECT @UENNombre      = ISNULL(Nombre,'') FROM UEN WHERE UEN = @UEN  
  SELECT @UsuarioNombre  = ISNULL(Nombre,'') FROM Usuario WHERE Usuario = @Usuario    
  
  IF @ContactoTipo = 'Cliente'   SELECT @ContactoNombre = ISNULL(Nombre,'') FROM Cte    WHERE Cliente   = @Contacto ELSE
  IF @ContactoTipo = 'Proveedor' SELECT @ContactoNombre = ISNULL(Nombre,'') FROM Prov   WHERE Proveedor = @Contacto ELSE   
  IF @ContactoTipo = 'Agente'    SELECT @ContactoNombre = ISNULL(Nombre,'') FROM Agente WHERE Agente    = @Contacto ELSE
  SET @ContactoNombre = ''    

  DECLARE crNotificacion CURSOR FOR
   SELECT Notificacion, Clave, Asunto, Mensaje, RTRIM(ISNULL(TipoFechaNotificacion,'(Emision)')), FechaNotificacion, ISNULL(AnticipacionFechaTipo,'APLAZAR'), ISNULL(AnticipacionFecha,0.0), ISNULL(MedioComunicacion,'EMAIL'), RTRIM(ISNULL(CondicionUsuario,''))  
     FROM Notificacion
    WHERE Estatus = 'ACTIVA' 

  OPEN crNotificacion
  FETCH NEXT FROM crNotificacion INTO @Notificacion, @NotificacionClave, @Asunto, @Mensaje, @TipoFechaNotificacion, @FechaNotificacion, @AnticipacionFechaTipo, @AnticipacionFecha, @MedioComunicacion, @CondicionUsuario  
  WHILE @@FETCH_STATUS = 0 AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    SET @GenerarNotificacion = 0
    EXEC spNotificacionProcesarFiltro @ID, @Modulo, @Notificacion, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @GenerarNotificacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    IF @GenerarNotificacion = 1
    BEGIN    
      EXEC spNotificacionProcesarParametros @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @GenerarNotificacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 
      IF @GenerarNotificacion = 1
      BEGIN
        EXEC spNotificacionVerificarVigencia @Notificacion, @FechaEmision, @GenerarNotificacion OUTPUT
        
        IF @GenerarNotificacion = 1
        BEGIN 

          EXEC spNotificacionVerificarVigenciaHora @Notificacion, @FechaRegistro, @GenerarNotificacion OUTPUT
          IF @GenerarNotificacion = 1
          BEGIN
            EXEC spNotificacionEnFrecuencia @Notificacion, @FechaEmision, @GenerarNotificacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
            IF @GenerarNotificacion = 1
            BEGIN                    
              EXEC spNotificacionCondicionUsuario @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, @CondicionUsuario, @GenerarNotificacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT            		
              IF @GenerarNotificacion = 1
              BEGIN
                EXEC spNotificacionEvaluarConsultas @@SPID, @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, @Ok OUTPUT, @OkRef OUTPUT
				         
				IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)      
                  EXEC spNotificacionParsearMensaje @@SPID, @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Movimiento, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, @Asunto OUTPUT, @Mensaje OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 
                  
                IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
                BEGIN
                  SELECT @FechaNotificacion = dbo.fnNotificacionFecha(@TipoFechaNotificacion,@FechaNotificacion,@AnticipacionFechaTipo, @AnticipacionFecha,@FechaEmision,@Vencimiento) 

                  SELECT @Para = dbo.fnNotificacionCorreosDestinatarios(@Notificacion, @Usuario, 'Para', @ContactoTipo, @Contacto) 
                  SELECT @CC = dbo.fnNotificacionCorreosDestinatarios(@Notificacion, @Usuario, 'CC', @ContactoTipo, @Contacto)               
                  SELECT @CCO = dbo.fnNotificacionCorreosDestinatarios(@Notificacion, @Usuario, 'CCO', @ContactoTipo, @Contacto)
                  
                  -- 11326                  
                  EXEC spNotificacionAnexo @@SPID, @ID, @Modulo, @Notificacion, @NotificacionClave, @Empresa, @Sucursal, @UEN, @Usuario, @Mov, @MovID, @Movimiento, @Estatus, @Situacion, @Proyecto, @ContactoTipo, @Contacto, @Importe, @EmpresaNombre, @SucursalNombre, @UENNombre, @UsuarioNombre, @ContactoNombre, @FechaEmision, @Ok OUTPUT, @OkRef OUTPUT, @Anexos OUTPUT
                  
                  IF @Ok IS NULL 
                    EXEC spNotificacionInsertarIS @Empresa, @Usuario, @Notificacion, @Modulo, @ID, @MedioComunicacion, @FechaNotificacion, @TipoFechaNotificacion, @AnticipacionFechaTipo, @AnticipacionFecha, @Vencimiento, @Para, @CC, @CCO, @Asunto, @Mensaje, @Anexos, @Ok OUTPUT, @OkRef OUTPUT
                END  
              END            
            END
          END
        END  
      END
          
    END  
    FETCH NEXT FROM crNotificacion INTO @Notificacion, @NotificacionClave, @Asunto, @Mensaje, @TipoFechaNotificacion, @FechaNotificacion, @AnticipacionFechaTipo, @AnticipacionFecha, @MedioComunicacion, @CondicionUsuario          
  END
  CLOSE crNotificacion
  DEALLOCATE crNotificacion
  
END
GO

--select convert(xml,solicitud),* from intelisisservice
/*
select * from notificacionfiltronormalizada
DELETE FROM NOTIFICACIONFILTRO
insert notificacionfiltro (Notificacion,            Empresa,   Sucursal,  UEN,       Usuario,   Modulo, Movimiento, Estatus,   Situacion, Proyecto,  ContactoTipo, Contacto,  ImporteMin, ImporteMax)
                   VALUES ('Notificacion Generica', '(TODOS)', '(TODOS)', '(TODOS)', '(TODOS)', 'VTAS', 'Factura',  '(TODOS)', '(TODOS)', '(TODOS)', '(TODOS)',    '(TODOS)', NULL,       NULL)
*/                   


--EXEC spNotificacion 1, 'VTAS'

--SELECT * FROM NOTIFICACION
--UPDATE NOTIFICACION SET ESTATUS = 'ACTIVA'
--select importe,* from venta


--select convert(xml,solicitud),* from intelisisservice
--select * from notificacionhist
--DELETE FROM INTELISISSERVICE
--select * from usuarionotificacion
--DELETE FROM USUARIONOTIFICACION

