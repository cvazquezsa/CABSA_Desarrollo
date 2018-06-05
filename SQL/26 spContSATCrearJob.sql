/*************************     Contabilidad Electr�nica     ****************************************/
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO    
/******************************* spContSATCrearJob *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spContSATCrearJob') and type = 'P') drop procedure dbo.spContSATCrearJob
GO             
CREATE PROCEDURE spContSATCrearJob
  @Nombre           varchar(100),
  @BaseDatos        varchar(30),
  @Cadena           nvarchar(255) = 'spConSATValidarXML 1'
 
 
--//WITH ENCRYPTION
AS
  DECLARE
  @TrabajoID               binary (16),
  @ReturnCode              int,
  @Activo                  bit,
  @Trabajo                 char(20),
  @Servidor                varchar(30),   
  @FrecuenciaD             tinyint,
  @ValorD                  tinyint,
  @Valor                   tinyint,
  @Dia                     tinyint,
  @Fecha2                  int, 
  @Estatus                 bit,
  @Fecha                   datetime,
  @NombreOriginal          varchar(100),
  @Procesar                varchar(30),
  @RutaComprobante		   varchar(255)
 

    DECLARE @SQLServerAgent TABLE
    (
    Estatus                       varchar(50)
    )
    SELECT @Fecha = GETDATE()
    SELECT @NombreOriginal = ISNULL(@Nombre,'')
    SELECT @Nombre = ISNULL(@Nombre,'') + '.' + @@SERVERNAME + '.' + @BaseDatos
    SELECT @ReturnCode = 0 
    
     SELECT @Valor = Valor 
       FROM ContSATTrabajo

    IF( (SELECT Frecuencia FROM ContSATTrabajo) = 'HORAS')
	BEGIN
		IF(@Valor < 1 OR @Valor > 24) 
		BEGIN
			SELECT ('El Valor seleccionado no correcponde con la Frecuencia Por favor corregir e intentar nuevamente')            
			RETURN
		END
	END

	SELECT @RutaComprobante = RutaComprobante FROM EmpresaCfgContaSAT
	IF(@RutaComprobante = '' OR @RutaComprobante IS NULL)
	BEGIN
		SELECT 'Debe de colocar una ruta desde Configuración General en el campo Ruta Admón. Docs.'
		RETURN
	END

	BEGIN TRANSACTION
    IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = '[Uncategorized (Local)]') < 1
      EXECUTE msdb.dbo.sp_add_category @name = '[Uncategorized (Local)]'
   
    SELECT @TrabajoID = job_id FROM   msdb.dbo.sysjobs WHERE (name = @Nombre)
    IF (@TrabajoID IS NOT NULL)   
    BEGIN 
       IF (EXISTS (SELECT  * FROM    msdb.dbo.sysjobservers WHERE   (job_id = @TrabajoID) AND (server_id <> 0)))
         BEGIN
            RAISERROR ('Unable to import job ''Conta SAT '' since there is already a multi-server job with this name.', 16, 1)
            SELECT @ReturnCode = 1    
         END
       ELSE
         EXECUTE msdb.dbo.sp_delete_job @job_name = @Nombre
      SELECT @TrabajoID = NULL
    END
 
 
  IF (@@ERROR = 0 AND @ReturnCode = 0)-- AND EXISTS(SELECT * FROM NotificacionTrabajo WHERE Trabajo = @NombreOriginal)
  BEGIN
    IF @ReturnCode = 0
      EXECUTE @ReturnCode = msdb.dbo.sp_add_job 
      @job_id = @TrabajoID OUTPUT , 
      @job_name = @Nombre, 
      @owner_login_name = N'sa', 
      @description =  @Nombre, 
      @category_name = '[Uncategorized (Local)]', 
      @enabled = 1, 
      @notify_level_email = 0, 
      @notify_level_page = 0, 
      @notify_level_netsend = 0, 
      @notify_level_eventlog = 2, 
      @delete_level= 0
 
     SELECT @Fecha2 =CONVERT(int, CONVERT(varchar,DATEPART(YEAR,@Fecha)) +  dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(MONTH,@Fecha)),2) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(DAY,@Fecha)),2))
     
     SELECT @Trabajo = Trabajo, 
       @FrecuenciaD= CASE Frecuencia WHEN 'Minutos' THEN 4 WHEN 'Horas' THEN 8 END , 
       @Valor = Valor, 
       @Activo =Activo 
       FROM ContSATTrabajo

	   IF(ISNULL(@Cadena, '') = '') SELECT @Cadena = 'spConSATValidarXML 1'
       SET @Cadena     = N'SET ARITHABORT ON' + char(10) + 'GO' + char(10) + '
EXEC ' + @Cadena

       EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep 
         @job_id = @TrabajoID, 
         @step_id = 1, 
         @step_name = @Trabajo, 
         @command = @Cadena, 
         @database_name = @BaseDatos, 
         @server = '', 
         @database_user_name = '', 
         @subsystem = 'TSQL', 
         @cmdexec_success_code = 0, 
         @flags = 0, 
         @retry_attempts = 0, 
         @retry_interval = 1, 
         @output_file_name = '', 
         @on_success_step_id = 0, 
         @on_success_action = 1, 
         @on_fail_step_id = 0, 
         @on_fail_action = 2

    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_update_job 
         @job_id = @TrabajoID, 
         @start_step_id = 1, 
         @enabled  = @Activo
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule 
         @job_id = @TrabajoID, 
         @name = @Nombre, 
         @enabled = @Activo, 
         @freq_type = 4, 
         @active_start_date = @Fecha2, 
         @active_start_time = 0, 
         @freq_interval = 1, 
         @freq_subday_type = @FrecuenciaD , 
         @freq_subday_interval = @Valor, 
         @freq_relative_interval = 0, 
         @freq_recurrence_factor = 0, 
         @active_end_date = 99991231, 
         @active_end_time = 235959
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @TrabajoID, @server_name = @@SERVERNAME
 
 

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
  
END  
GO
