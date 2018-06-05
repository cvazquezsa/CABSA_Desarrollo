
--drop table SincroISTrabajo
/* SincroISTrabajo */
if not exists(select * from SysTabla where SysTabla = 'SincroISTrabajo')
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISTrabajo')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISTrabajo') and type = 'U') 
CREATE TABLE dbo.SincroISTrabajo (
    Trabajo        		varchar(30)     	NOT NULL,

	Nombre				varchar(100)	NULL,
	Descripcion			varchar(255)	NULL,
	UltimaActualizacion	datetime		NULL	DEFAULT GETDATE(),
	Activo				bit				NULL	DEFAULT 1,

	Modificar			bit				NULL	DEFAULT 0,


	HoraInicial			varchar(6)		NULL	DEFAULT '00:00',
	HoraFinal			varchar(6)		NULL	DEFAULT '23:59',
	Frecuencia			varchar (20)	NULL	DEFAULT 'Diaria',
	Valor				tinyint			NULL	DEFAULT 1,
	Recurrencia			tinyint			NULL	DEFAULT 1,
	FrecuenciaD			varchar (20)	NULL	DEFAULT 'Minutos',
	ValorD				tinyint			NULL	DEFAULT 30,
	
	Usuario    			varchar(30)		NULL	DEFAULT 'sa',
  	Contrasena  		varchar(30)		NULL	DEFAULT '',
  	
  	Domingo				bit				NULL	DEFAULT 0,
  	Lunes				bit				NULL	DEFAULT 0,
  	Martes				bit				NULL	DEFAULT 0,
  	Miercoles			bit				NULL	DEFAULT 0,
  	Jueves				bit				NULL	DEFAULT 0,
  	Viernes				bit				NULL	DEFAULT 0,
  	Sabado				bit				NULL	DEFAULT 0,
  	
  	Tipo  				varchar(30)		NULL	DEFAULT 'Primer',
  	Dia  				varchar(30)		NULL	DEFAULT 'Lunes',
  	FechaInicial		datetime		NULL    DEFAULT	GETDATE()
  	



    	CONSTRAINT priSincroISTrabajo PRIMARY KEY  CLUSTERED (Trabajo)
)
GO

IF NOT EXISTS (SELECT * FROM SincroISTrabajo WHERE Trabajo = 'SincroIS')
INSERT SincroISTrabajo (Trabajo,	Nombre,   Descripcion)
VALUES				   ('SincroIS', 'Sincro', 'Intelisis Service')


/****** SincroCamposBD1 ******/
if not exists (select * from SysTabla where SysTabla = 'SincroCamposBD1') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroCamposBD1')
if not exists (select * from sysobjects where id = object_id('dbo.SincroCamposBD1') and type = 'U') 
CREATE TABLE dbo.SincroCamposBD1 (

	Estacion			int	NOT NULL,
	Tabla				varchar(128) COLLATE DATABASE_DEFAULT NULL,
	Campo				varchar(128) COLLATE DATABASE_DEFAULT NULL,
	Orden				int NULL,
	TipoDatos			varchar(100) COLLATE DATABASE_DEFAULT NULL,
	Ancho				int NULL,
	[Precision]			int NULL,
	Escala				int NULL,
	AceptaNulos			bit NULL,
	EsIdentity			bit NULL,
	EsCalculado			bit NULL,
	Collation			varchar(100) COLLATE DATABASE_DEFAULT NULL,
	Tipo				varchar(10) COLLATE DATABASE_DEFAULT NULL
		
)
GO


/****** SincroCamposBD2 ******/
if not exists (select * from SysTabla where SysTabla = 'SincroCamposBD2') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroCamposBD2')
if not exists (select * from sysobjects where id = object_id('dbo.SincroCamposBD2') and type = 'U') 
CREATE TABLE dbo.SincroCamposBD2 (

	Estacion			int	NOT NULL,
	Tabla				varchar(128) COLLATE DATABASE_DEFAULT NULL,
	Campo				varchar(128) COLLATE DATABASE_DEFAULT NULL,
	Orden				int NULL,
	TipoDatos			varchar(100) COLLATE DATABASE_DEFAULT NULL,
	Ancho				int NULL,
	[Precision]			int NULL,
	Escala				int NULL,
	AceptaNulos			bit NULL,
	EsIdentity			bit NULL,
	EsCalculado			bit NULL,
	Collation			varchar(100) COLLATE DATABASE_DEFAULT NULL,
	Tipo				varchar(10) COLLATE DATABASE_DEFAULT NULL
		
)
GO


/****** SincroComparacion ******/
if not exists (select * from SysTabla where SysTabla = 'SincroComparacion') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroComparacion')
if not exists (select * from sysobjects where id = object_id('dbo.SincroComparacion') and type = 'U') 
CREATE TABLE dbo.SincroComparacion (

	Estacion			int	NOT NULL,
	TablaNombre			varchar(128) COLLATE DATABASE_DEFAULT NULL,
	Campo				varchar(128) COLLATE DATABASE_DEFAULT NULL,
	BD1Orden			int NULL,
	BD2Orden			int NULL,  
	BD1TipoDatos		varchar(100) COLLATE DATABASE_DEFAULT NULL,
	BD2TipoDatos		varchar(100) COLLATE DATABASE_DEFAULT NULL,  
	BD1Ancho			int NULL,
	BD2Ancho			int NULL,  
	BD1Precision		int NULL,
	BD2Precision		int NULL,  
	BD1Escala			int NULL,
	BD2Escala			int NULL,  
	BD1AceptaNulos		bit NULL,
	BD2AceptaNulos		bit NULL,  
	BD1EsIdentity		bit NULL,
	BD2EsIdentity		bit NULL,  
	BD1EsCalculado		bit NULL,
	BD2EsCalculado		bit NULL,  
	BD1Collation		varchar(100) COLLATE DATABASE_DEFAULT NULL,
	BD2Collation		varchar(100) COLLATE DATABASE_DEFAULT NULL,  
	BD1Tipo				varchar(10) COLLATE DATABASE_DEFAULT NULL,
	BD2Tipo				varchar(10) COLLATE DATABASE_DEFAULT NULL  

)
GO

/* spCrearJobsSincroISTrabajo */
IF exists (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[spCrearJobsSincroISTrabajo]'))
DROP PROCEDURE [dbo].[spCrearJobsSincroISTrabajo]
GO
CREATE PROCEDURE spCrearJobsSincroISTrabajo
  @Nombre   	varchar(30),
  @BaseDatos   	varchar(30),
  @UsuarioI   	varchar(30)
  

--//WITH ENCRYPTION
 AS
  DECLARE
  @TrabajoID		binary (16),
  @ReturnCode		int,
  @Usuario			varchar(30),
  @Contrasena		varchar(30),
  @Activo			bit,
  @Trabajo 			char(20),
  @Cadena 			varchar(100),
  @Servidor			varchar(30),    
  @HoraInicial		int,
  @HoraFinal		int,
  @Frecuencia		tinyint,
  @Valor			tinyint,
  @Recurrencia		tinyint,  
  @FrecuenciaD		tinyint,
  @ValorD			tinyint,

  @Domingo			bit,
  @Lunes			bit,
  @Martes			bit,
  @Miercoles		bit,
  @Jueves			bit,
  @Viernes			bit,
  @Sabado			bit,
  @Valor2			tinyint,
  @Tipo				tinyint,
  @Dia				tinyint,
  @Fecha2			int,
  
  @Estatus			bit,
  @NombreOriginal	varchar(30)

  BEGIN TRANSACTION
    DECLARE @SQLServerAgent TABLE
    (
    Estatus				varchar(50)
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
            RAISERROR ('Unable to import job ''SincroIS'' since there is already a multi-server job with this name.', 16, 1) 
            SELECT @ReturnCode = 1     
         END 
       ELSE 
         EXECUTE msdb.dbo.sp_delete_job @job_name = @Nombre 
      SELECT @TrabajoID = NULL
    END 


  IF (@@ERROR = 0 AND @ReturnCode = 0) AND EXISTS(SELECT * FROM SincroISTrabajo WHERE Trabajo = @NombreOriginal)
  BEGIN
    IF @ReturnCode = 0 
      EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @TrabajoID OUTPUT , @job_name = @Nombre, @owner_login_name = @Usuario, @description =  @Nombre, @category_name = '[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0

	DECLARE crTrabajo SCROLL CURSOR FOR
	SELECT Trabajo, Usuario, Contrasena, CONVERT(int, SUBSTRING(HoraInicial,1,2) + SUBSTRING(HoraInicial,4,2) + '00'), CONVERT(int, SUBSTRING(HoraFinal,1,2) + SUBSTRING(HoraFinal,4,2) + '00'), CASE Frecuencia WHEN 'Diaria' THEN 4 WHEN 'Semanal' THEN 8 WHEN 'Mensual' THEN 16 WHEN 'Mensual 2' THEN 32 END, Valor, Recurrencia, CASE FrecuenciaD WHEN 'Minutos' THEN 4 WHEN 'Horas' THEN 8 END , ValorD, Activo, Domingo, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, CASE Tipo WHEN 'Primer' THEN 1 WHEN 'Segundo' THEN 2 WHEN 'Tercer' THEN 4 WHEN 'Cuarto' THEN 8 WHEN 'Ultimo' THEN 16 END, CASE Dia WHEN 'Domingo' THEN 1 WHEN 'Lunes' THEN 2 WHEN 'Martes' THEN 3 WHEN 'Miercoles' THEN 4 WHEN 'Jueves' THEN 5 WHEN 'Viernes' THEN 6 WHEN 'Sabado' THEN 7 WHEN 'Día' THEN 8 WHEN 'Día de la semana' THEN 9 WHEN 'Día del fin de semana' THEN 10 END, CONVERT(int, CONVERT(varchar,DATEPART(YEAR,FechaInicial)) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(MONTH,FechaInicial)),2) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(DAY,FechaInicial)),2))
	  FROM SincroISTrabajo
	 WHERE Trabajo = @NombreOriginal
	 
	IF ISNULL(@Contrasena,'') = '' 
  		SELECT @Contrasena = 'NULL'

	OPEN crTrabajo

	FETCH NEXT FROM crTrabajo INTO @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2

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
    

	  SET @cadena 	= 'EXEC spSincroIS_Sincronizar '+ '''' + RTRIM(@UsuarioI) + ''''
--	  select @Cadena

	  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @TrabajoID, @step_id = 1, @step_name = @Trabajo, @command = @cadena, @database_name = @BaseDatos, @server = '', @database_user_name = '', @subsystem = 'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = '', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2

	  UPDATE SincroISTrabajo SET UltimaActualizacion = GETDATE() WHERE Trabajo = @Trabajo
	  
	  FETCH NEXT FROM crTrabajo INTO  @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2
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
--EXEC spCrearJobsSincroISTrabajo 'SincroIS', 'Sucursal', 'DEMO'


/**************** spSincroISVerificaIDRepetidos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISVerificaIDRepetidos') and type = 'P') drop procedure dbo.spSincroISVerificaIDRepetidos
GO             
CREATE PROCEDURE spSincroISVerificaIDRepetidos
  @Afectar   	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @SysTabla				varchar(50),
  @Ok					int,
  @Campo				varchar(50),
  @SQL					nvarchar(MAX),
  @Parametros			nvarchar(MAX),
  @Resultado			bit,
  @Tabla				varchar(50),
  @SELECT				nvarchar(MAX)
  
  
  DECLARE @TablaResultado	TABLE
  (
   Tabla				varchar(50),
   Campo				varchar(50)
  )
  
  DECLARE crTabla CURSOR FOR
   SELECT SysTabla
     FROM SysTabla
    WHERE SincroActivo = 1

  OPEN crTabla
  FETCH NEXT FROM crTabla INTO @SysTabla
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    DECLARE crCampoExt CURSOR FOR
     SELECT Campo
       FROM SysCampoExt
      WHERE EsIdentity = 1
        AND Tabla = @SysTabla

    OPEN crCampoExt
    FETCH NEXT FROM crCampoExt INTO @Campo
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN 
      SET @Resultado = 0
      SET @SQL = 'IF EXISTS(SELECT ' + RTRIM(@Campo) + ', COUNT(*) FROM ' + RTRIM(@SysTabla) + ' GROUP BY ' + RTRIM(@Campo) + ' HAVING COUNT(*) >= 2) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0'
      SET @Parametros = '@Resultado bit OUTPUT'
      EXEC sp_executesql @SQL, @Parametros, @Resultado = @Resultado OUTPUT
      
      IF @Resultado = 1
      BEGIN
--      SELECT @Resultado
        INSERT @TablaResultado (Tabla, Campo) VALUES (@SysTabla, @Campo)      
        
        EXEC spSincroISTablaEstructura @SysTabla, @SELECT = @SELECT OUTPUT, @ExcluirTimeStamp = 1, @ExcluirCalculados = 1, @ExcluirIdentity = 1
        
        IF @Afectar = 1
        BEGIN
          SET @SQL = 'SELECT * INTO #' + RTRIM(@SysTabla) + ' FROM ' + RTRIM(@SysTabla) + ' ' + CHAR(13) +
                     'DELETE FROM ' + RTRIM(@SysTabla) + ' ' + CHAR(13) +
                     'INSERT ' + RTRIM(@SysTabla) + ' (' + @SELECT + ') ' + CHAR(13) +
                     'SELECT ' + @SELECT + ' ' + CHAR(13) + 
                     'FROM #' + RTRIM(@SysTabla) + ' ' + CHAR(13) + 
                     'DROP TABLE #' + RTRIM(@SysTabla)
          EXEC sp_executesql @SQL
        END
      END
      
      FETCH NEXT FROM crCampoExt INTO @Campo
    END
    CLOSE crCampoExt
    DEALLOCATE crCampoExt

  
    FETCH NEXT FROM crTabla INTO @SysTabla
  END
  CLOSE crTabla
  DEALLOCATE crTabla

  SELECT * FROM @TablaResultado

END
GO

--EXEC spSincroISVerificaIDRepetidos 1

--set IDENTITY_INSERT dbo.ArtMaterial on
--go
--insert into dbo.ArtMaterial(Articulo, OrdenID)
--values( 'a3', 3)
--go

--set identity_insert CtaDineroHist on

--select * from ctadinerohist
/*
use Matriz
SET IDENTITY_INSERT CxpAplicaDif ON
truncate table CxpAplicaDif
INSERT CxpAplicaDif (ID, OrdenID)
SELECT 1, 1
INSERT CxpAplicaDif (ID, OrdenID)
SELECT 2, 1
SET IDENTITY_INSERT CxpAplicaDif OFF
*/



/******************************* spComprararEstructuraDB *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spComprararEstructuraDB') and type = 'P') drop procedure dbo.spComprararEstructuraDB
GO             
CREATE PROCEDURE spComprararEstructuraDB
		@Estacion		int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @SQL			nvarchar(max),
	@Servidor1		varchar(100),
	@BaseDatos1		varchar(100),
	@Servidor2		varchar(100),
	@BaseDatos2		varchar(100)
  
  
  SELECT @Servidor1 = InfoServidor1,
		 @Servidor2 = InfoServidor2,
		 @BaseDatos1 = InfoBaseDatos1,
		 @BaseDatos2 = InfoBaseDatos2
	FROM RepParam
   WHERE Estacion = @Estacion
  
--  update RepParam set InfoServidor1 = 'MUSS', InfoServidor2 = 'MUSS', InfoBaseDatos1 = 'Guatemala1', InfoBaseDatos2 = 'Deconsa' where Estacion = 1
--  SELECT @Servidor1 = 'MUSS', @BaseDatos1 = 'Guatemala1', @Servidor2 = 'MUSS', @BaseDatos2 = 'Deconsa'  
  
  DELETE SincroCamposBD1 WHERE Estacion = @Estacion
  DELETE SincroCamposBD2 WHERE Estacion = @Estacion
  DELETE SincroComparacion WHERE Estacion = @Estacion
  

  SELECT @SQL = N'
  INSERT SincroCamposBD1 (Estacion,    Tabla,   Campo,   Orden,   TipoDatos,   Ancho,   [Precision],   Escala,   AceptaNulos,   EsIdentity,   EsCalculado,   Collation,   Tipo)
                   SELECT @Estacion, c.Tabla, c.Campo, c.Orden, c.TipoDatos, c.Ancho, c.[Precision], c.Escala, c.AceptaNulos, c.EsIdentity, c.EsCalculado, c.Collation, c.Tipo 
                     FROM ' + @Servidor1 + '.' + @BaseDatos1 + '.information_schema.tables t JOIN ' + @Servidor1 + '.' + @BaseDatos1 + '.dbo.SysCampoExt c
                       ON RTRIM(LTRIM(c.Tabla)) = RTRIM(LTRIM(Table_Name)) 
                    WHERE Table_Catalog = ''' + @BaseDatos1 + '''' + ' ORDER BY Tabla'

  EXEC sp_executesql @SQL, N'@Estacion int, @BaseDatos1 varchar(100)', @Estacion = @Estacion, @BaseDatos1 = @BaseDatos1


  SELECT @SQL = N'
  INSERT SincroCamposBD2 (Estacion,    Tabla,   Campo,   Orden,   TipoDatos,   Ancho,   [Precision],   Escala,   AceptaNulos,   EsIdentity,   EsCalculado,   Collation,   Tipo)
                   SELECT @Estacion, c.Tabla, c.Campo, c.Orden, c.TipoDatos, c.Ancho, c.[Precision], c.Escala, c.AceptaNulos, c.EsIdentity, c.EsCalculado, c.Collation, c.Tipo 
                     FROM ' + @Servidor2 + '.' + @BaseDatos2 + '.information_schema.tables t JOIN ' + @Servidor2 + '.' + @BaseDatos2 + '.dbo.SysCampoExt c
                       ON RTRIM(LTRIM(c.Tabla)) = RTRIM(LTRIM(Table_Name)) 
                    WHERE Table_Catalog = ''' + @BaseDatos2 + '''' + ' ORDER BY Tabla'
					
  EXEC sp_executesql @SQL, N'@Estacion int, @BaseDatos2 varchar(100)', @Estacion = @Estacion, @BaseDatos2 = @BaseDatos2


  INSERT SincroComparacion (Estacion, TablaNombre,               Campo,                     BD1Orden, BD2Orden, BD1TipoDatos, BD2TipoDatos, BD1Ancho, BD2Ancho, BD1Precision,   BD2Precision,   BD1Escala, BD2Escala, BD1AceptaNulos, BD2AceptaNulos, BD1EsIdentity, BD2EsIdentity, BD1EsCalculado, BD2EsCalculado, BD1Collation, BD2Collation, BD1Tipo, BD2Tipo)
					SELECT @Estacion, ISNULL(c1.Tabla,c2.Tabla), ISNULL(c1.Campo,c2.Campo), c1.Orden, c2.Orden, c1.TipoDatos, c2.TipoDatos, c1.Ancho, c2.Ancho, c1.[Precision], c2.[Precision], c1.Escala, c2.Escala, c1.AceptaNulos, c2.AceptaNulos, c1.EsIdentity, c2.EsIdentity, c1.EsCalculado, c2.EsCalculado, c1.Collation, c2.Collation, c1.Tipo, c2.Tipo 
                      FROM SincroCamposBD1 c1 LEFT OUTER JOIN SincroCamposBD2 c2
                        ON c2.Tabla = c1.Tabla AND c2.Campo = c1.Campo AND c1.Estacion = @Estacion AND c2.Estacion = @Estacion
                     WHERE c1.TipoDatos <> c2.TipoDatos
                        OR c1.Ancho <> c2.Ancho
                        OR c1.[Precision] <> c2.[Precision] 
                        OR c1.TipoDatos <> c2.TipoDatos
                        OR c1.Escala <> c2.Escala
                        OR c1.AceptaNulos <> c2.AceptaNulos
                        OR c1.EsIdentity <> c2.EsIdentity
                        OR c1.Collation <> c2.Collation
                        OR c1.Tipo <> c2.Tipo    

  INSERT SincroComparacion (Estacion, TablaNombre,               Campo,                     BD1Orden, BD2Orden, BD1TipoDatos, BD2TipoDatos, BD1Ancho, BD2Ancho, BD1Precision,   BD2Precision,   BD1Escala, BD2Escala, BD1AceptaNulos, BD2AceptaNulos, BD1EsIdentity, BD2EsIdentity, BD1EsCalculado, BD2EsCalculado, BD1Collation, BD2Collation, BD1Tipo, BD2Tipo)
					SELECT @Estacion, ISNULL(c1.Tabla,c2.Tabla), ISNULL(c1.Campo,c2.Campo), c1.Orden, c2.Orden, c1.TipoDatos, c2.TipoDatos, c1.Ancho, c2.Ancho, c1.[Precision], c2.[Precision], c1.Escala, c2.Escala, c1.AceptaNulos, c2.AceptaNulos, c1.EsIdentity, c2.EsIdentity, c1.EsCalculado, c2.EsCalculado, c1.Collation, c2.Collation, c1.Tipo, c2.Tipo 
					  FROM SincroCamposBD1 c1 RIGHT OUTER JOIN SincroCamposBD2 c2
						ON c2.Tabla = c1.Tabla AND c2.Campo = c1.Campo AND c1.Estacion = @Estacion AND c2.Estacion = @Estacion
					 WHERE c1.TipoDatos <> c2.TipoDatos
						OR c1.Ancho <> c2.Ancho
						OR c1.[Precision] <> c2.[Precision] 
						OR c1.TipoDatos <> c2.TipoDatos
						OR c1.Escala <> c2.Escala
						OR c1.AceptaNulos <> c2.AceptaNulos
						OR c1.EsIdentity <> c2.EsIdentity
						OR c1.Collation <> c2.Collation
						OR c1.Tipo <> c2.Tipo    

/*
  SELECT Estacion, Tabla, Campo, BD1Orden, BD2Orden, BD1TipoDatos, BD2TipoDatos, BD1Ancho, BD2Ancho, BD1Precision, BD2Precision, BD1Escala, BD2Escala, BD1AceptaNulos, BD2AceptaNulos, BD1EsIdentity, BD2EsIdentity, BD1EsCalculado, BD2EsCalculado, BD1Collation, BD2Collation, BD1Tipo, BD2Tipo 
    FROM SincroComparacion
    WHERE Estacion = @Estacion                   
   GROUP BY Estacion, Tabla, Campo, BD1Orden, BD2Orden, BD1TipoDatos, BD2TipoDatos, BD1Ancho, BD2Ancho, BD1Precision, BD2Precision, BD1Escala, BD2Escala, BD1AceptaNulos, BD2AceptaNulos, BD1EsIdentity, BD2EsIdentity, BD1EsCalculado, BD2EsCalculado, BD1Collation, BD2Collation, BD1Tipo, BD2Tipo  
*/   
END
GO


--EXEC spComprararEstructuraDB 1
--select * from syscolumns  


/******************************* spLinkedServers *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spLinkedServers') and type = 'P') drop procedure dbo.spLinkedServers
GO             
CREATE PROCEDURE spLinkedServers

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE @Tabla TABLE (
			            Servidor		varchar(100),
						Proveedor		varchar(100),
						Producto		varchar(100),
						DataSource		varchar(100),
						ProvString		varchar(100),
						Locaton			varchar(100),
						Cat				varchar(100)
					   )
    
  INSERT INTO @Tabla
  EXEC sp_linkedservers  
  
  SELECT Servidor FROM @Tabla
END
GO
--exec spLinkedServers


/******************************* spServersDatabase *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spServersDatabase') and type = 'P') drop procedure dbo.spServersDatabase
GO             
CREATE PROCEDURE spServersDatabase
		@Servidor		varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE @SQL		nvarchar(255)
  

  DECLARE @Tabla TABLE (
			            Base			varchar(100),
						Tamano			varchar(100),
						Propietario		varchar(100),
						BaseID			int,
						Creada			datetime,
						Estatus			varchar(255),
						Compabilidad	int
					   )
    
  SELECT @SQL = N' EXEC ' + @Servidor + '.Master.dbo.sp_helpdb'
  
  INSERT INTO @Tabla
  EXEC sp_executesql @SQL, N'@Servidor varchar(100)', @Servidor = @Servidor
  
--  EXEC MUSS.MASTER.DBO.sp_helpdb  
  
  SELECT Base FROM @Tabla
END
GO
--exec spServersDatabase 'MUSS'