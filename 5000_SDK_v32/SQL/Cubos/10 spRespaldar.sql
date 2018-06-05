/*Respaldar base de Datos */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('Respaldos')) 
DROP TABLE Respaldos
GO
CREATE TABLE Respaldos (
	[Archivo] 	[varchar] (200)  NULL 
) ON [PRIMARY]
GO

IF exists (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[spRespaldarBD]'))
DROP PROCEDURE [dbo].[spRespaldarBD]
GO
CREATE PROCEDURE spRespaldarBD
  	@Basedatos  	VARCHAR(20),
	@Directorio  	VARCHAR(100),
	@NombreArchivo	VARCHAR(30) = NULL

--//WITH ENCRYPTION
AS

DECLARE @cadena 	VARCHAR(50)
DECLARE @Flag	 	BIT
DECLARE @NoMaxArchivos 	INT
DECLARE @NoArchivos 	INT

SET @cadena = CONVERT(VARCHAR(50),GETDATE(),120)
SET @cadena = REPLACE(@cadena,'-','')
SET @cadena = REPLACE(@cadena,':','')
SET @cadena = REPLACE(@cadena,' ','_')

IF @NombreArchivo IS NULL
   BEGIN
	SET @Directorio = @Directorio + '\' + @Basedatos + '_' + @cadena
	SET @Flag = 1
   END
ELSE
   BEGIN
	SET @Directorio = @Directorio + '\' + @NombreArchivo
	SET @Flag = 0
   END

BACKUP DATABASE @BaseDatos TO  DISK = @Directorio WITH  NOINIT ,  NOUNLOAD ,  NAME = @BaseDatos,  NOSKIP ,  STATS = 10,  NOFORMAT 

IF @flag = 1
  BEGIN
	INSERT Respaldos VALUES (@Directorio)
	SELECT @NoMaxArchivos = MaxRespaldos FROM Version 
	SELECT @NoArchivos = COUNT(*) FROM Respaldos 
	IF @NoArchivos > @NoMaxArchivos
	   BEGIN
		SELECT TOP 1 @Directorio = Archivo FROM Respaldos ORDER BY Archivo
		DELETE FROM respaldos WHERE Archivo = @Directorio
		SET @cadena = 'del ' + @Directorio
		EXEC MASTER..XP_CMDSHELL @cadena
	   END 
  END
GO


/* spCrearJobs */
IF exists (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[spJobRespaldar]'))
DROP PROCEDURE [dbo].[spJobRespaldar]
GO
CREATE PROCEDURE spJobRespaldar
  @EsManual	bit,
  @Nombre   	VARCHAR(20) 	,
  @Usuario    	VARCHAR(20) 	,
  @Password  	VARCHAR(20) 	,
  @Hora         INT		,
  @BaseDatos   	VARCHAR(20)	,
  @Frecuencia   TINYINT		,
  @Valor	TINYINT		,
  @Recurrencia  BIT		,
  @Directorio	VARCHAR(200)	


--//WITH ENCRYPTION
 AS

BEGIN TRANSACTION            
  DECLARE @JobID BINARY(16)  
  DECLARE @ReturnCode INT    
  SELECT @ReturnCode = 0     
  IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = '[Uncategorized (Local)]') < 1 
    EXECUTE msdb.dbo.sp_add_category @name = '[Uncategorized (Local)]'

  SELECT @JobID = job_id FROM   msdb.dbo.sysjobs WHERE (name = @Nombre)       
  IF (@JobID IS NOT NULL)    
  BEGIN  
     IF (EXISTS (SELECT  * FROM    msdb.dbo.sysjobservers WHERE   (job_id = @JobID) AND (server_id <> 0))) 
       BEGIN 
          RAISERROR ('Unable to import job ''Cubo '' since there is already a multi-server job with this name.', 16, 1) 
          SELECT @ReturnCode = 1     
       END 
     ELSE 
       EXECUTE msdb.dbo.sp_delete_job @job_name = @Nombre 
    SELECT @JobID = NULL
  END 

IF @EsManual = 0
BEGIN 
  IF @ReturnCode = 0 
    EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT , @job_name = @Nombre, @owner_login_name = @Usuario, @description =  @Nombre, @category_name = '[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0

---- llamar sp spRespaldarBD  	@Basedatos VARCHAR(20),	@Directorio VARCHAR(100),@NombreArchivo	VARCHAR(30) = NULL
  DECLARE @cadena VARCHAR(100)
  
  SET @cadena = 'spRespaldarBD "' + RTRIM(@BaseDatos) + '","' + RTRIM(@Directorio) + '"'

  IF (@@ERROR = 0 AND @ReturnCode = 0)
  BEGIN
        IF @ReturnCode = 0 
          EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = 'Respalda Base de Datos', @command = @cadena, @database_name = @BaseDatos, @server = '', @database_user_name = '', @subsystem = 'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = '', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2

        IF @ReturnCode = 0
  	  EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 
       
        IF @ReturnCode = 0
  	  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = @Nombre, @enabled = 1, @freq_type = @Frecuencia, @active_start_date = 19900101, @active_start_time = @hora, @freq_interval = @Valor, @freq_subday_type = 1, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = @Recurrencia, @active_end_date = 99991231, @active_end_time = 235959

        IF @ReturnCode = 0
	  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = '(local)' 
  END
  
END

IF @ReturnCode = 0
  COMMIT TRANSACTION          
ELSE
  ROLLBACK TRANSACTION 
GO
