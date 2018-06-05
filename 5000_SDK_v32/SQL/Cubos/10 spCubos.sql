/* Borrar registros si ya existen */
IF  (SELECT Version from Version) <= 2099
   BEGIN
	TRUNCATE TABLE Cubo
	TRUNCATE TABLE CuboDimension
	TRUNCATE TABLE CuboDimensionNivel
	TRUNCATE TABLE CuboFormula
	TRUNCATE TABLE CuboMedida
	TRUNCATE TABLE CuboVista
    END
GO

--- BORRAR EL CUBO DE VENTAS COMPRAS E INVENTARIO	8/10/2003
DELETE FROM Cubo 		WHERE Cubo='VTASCOMSINV'
DELETE FROM CuboDimension	WHERE Cubo='VTASCOMSINV'
DELETE FROM CuboDimensionNivel	WHERE Cubo='VTASCOMSINV'
DELETE FROM CuboFormula		WHERE Cubo='VTASCOMSINV'
DELETE FROM CuboMedida		WHERE Cubo='VTASCOMSINV'
DELETE FROM CuboVista		WHERE Cubo='VTASCOMSINV'
GO


--- Crear columna para saber si hay que modificar la vista o es particular del cliente
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('Cubo') AND TYPE='u') 
			AND NAME = 'Modificar')
	EXEC spAlter_Table 'Cubo','Modificar','BIT NULL'
GO

/* tabla para administrar los store a ejecutar */
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[CuboStore]'))
	CREATE TABLE CuboStore(
		Cubo			VARCHAR(20)	NULL,
		StoreProcedure		VARCHAR(50)	NULL,
		Orden			SMALLINT)
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'FieldLabelFont')
	EXEC spAlter_Table 'CuboVista','FieldLabelFont','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'FieldLabelForeColor')
	EXEC spAlter_Table 'CuboVista','FieldLabelForeColor','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'FieldLabelBackColor')
	EXEC spAlter_Table 'CuboVista','FieldLabelBackColor','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'FieldLabelBackColor')
	EXEC spAlter_Table 'CuboVista','FieldLabelBackColor','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'HeaderFont')
	EXEC spAlter_Table 'CuboVista','HeaderFont','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'HeaderForeColor')
	EXEC spAlter_Table 'CuboVista','HeaderForeColor','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'HeaderHAlignment')
	EXEC spAlter_Table 'CuboVista','HeaderHAlignment','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'PropertyCaptionFont')
	EXEC spAlter_Table 'CuboVista','PropertyCaptionFont','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'PropertyCaptionHAlignment')
	EXEC spAlter_Table 'CuboVista','PropertyCaptionHAlignment','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'PropertyValueFont')
	EXEC spAlter_Table 'CuboVista','PropertyValueFont','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'PropertyValueHAlignment')
	EXEC spAlter_Table 'CuboVista','PropertyValueHAlignment','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'TotalBackColor')
	EXEC spAlter_Table 'CuboVista','TotalBackColor','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'TotalFont')
	EXEC spAlter_Table 'CuboVista','TotalFont','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'TotalForeColor')
	EXEC spAlter_Table 'CuboVista','TotalForeColor','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'TotalOrientation')
	EXEC spAlter_Table 'CuboVista','TotalOrientation','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'GraficaTipo')
	EXEC spAlter_Table 'CuboVista','GraficaTipo','VARCHAR(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'GraficaLeyenda')
	EXEC spAlter_Table 'CuboVista','GraficaLeyenda','Integer NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'GraficaOrientacion')
	EXEC spAlter_Table 'CuboVista','GraficaOrientacion','Bit NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('Cubo') AND TYPE='u') 
			AND NAME = 'Activo')
  EXEC spALTER_TABLE 'Cubo', 'Activo', 'BIT NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'GraficaTipo')
   EXEC spALTER_TABLE 'CuboVista','GraficaTipo','varchar(100) NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
			AND NAME = 'GraficaLeyenda')
   EXEC spALTER_TABLE 'CuboVista','GraficaLeyenda','integer NULL'
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboVista') AND TYPE='u') 
		AND NAME = 'GraficaOrientacion')
   EXEC spALTER_TABLE 'CuboVista','GraficaOrientacion','bit NULL'
GO    
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('Cubo') AND TYPE='u') 
			AND NAME = 'Minutos')
  EXEC spALTER_TABLE 'Cubo', 'Minutos', 'INT NULL'
GO    
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboFormula') AND TYPE='u') 
			AND NAME = 'Orden')
  EXEC spALTER_TABLE 'CuboFormula', 'Orden', 'INT NULL'
GO    
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboDimensionNivel') AND TYPE='u') 
			AND NAME = 'Grupo')
  EXEC spALTER_TABLE 'CuboDimensionNivel', 'Grupo', 'VARCHAR(30) NULL'
GO    
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboDimensionNivel') AND TYPE='u') 
			AND NAME = 'MemberKeyUnique')
  EXEC spALTER_TABLE 'CuboDimensionNivel', 'MemberKeyUnique', 'BIT NULL' 
GO    
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboDimension') AND TYPE='u') 
			AND NAME = 'Changing')
  EXEC spALTER_TABLE 'CuboDimension', 'Changing', 'BIT NULL' 
GO    
/*Agregar a cubomedida el campo para ve que funcion aplicar */
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('CuboMedida') AND TYPE='u') 
			AND NAME = 'Funcion')
  EXEC spALTER_TABLE 'CuboMedida', 'Funcion', 'VARCHAR(25) NULL'
GO
  UPDATE CuboMedida SET Funcion = 'aggSum'  
GO    

/* spActualizarCubo */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spActualizarCubo]'))
DROP PROCEDURE [dbo].[spActualizarCubo]
GO
CREATE PROCEDURE spActualizarCubo
		       	@Cubo 		CHAR(20),
			@Estatus        Tinyint = NULL
--//WITH ENCRYPTION
AS

IF @Estatus IS NULL
 SELECT @Estatus = 1

IF (SELECT COUNT(*) FROM Cubo WHERE Nombre = @Cubo) = 1 
UPDATE Cubo SET Instalado = @Estatus WHERE Nombre = @Cubo
GO
/* spLimpiarCubo */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spLimpiarCubo]'))
DROP PROCEDURE [dbo].[spLimpiarCubo]
GO
CREATE PROCEDURE spLimpiarCubo
		       	@Cubo 		CHAR(20)

--//WITH ENCRYPTION
AS
IF (SELECT COUNT(*) FROM Cubo WHERE Cubo = @Cubo) = 1
  BEGIN
	DELETE FROM Cubo 		WHERE Cubo = @Cubo
	DELETE FROM CuboDimension 	WHERE Cubo = @Cubo
	DELETE FROM CuboDimensionNivel 	WHERE Cubo = @Cubo
	DELETE FROM CuboMedida	 	WHERE Cubo = @Cubo
	DELETE FROM CuboFormula	 	WHERE Cubo = @Cubo
  END 
GO 


/* spInsertarDimension */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spInsertarDimension]'))
DROP PROCEDURE [dbo].[spInsertarDimension]
GO
CREATE PROCEDURE spInsertarDimension
		       	@Cubo 		CHAR(20),
			@Dimension	VARCHAR(50),
			@Tipo		VARCHAR(20),
			@Descripcion 	VARCHAR(255),
			@Activa		BIT,
			@Changing	BIT = NULL

--//WITH ENCRYPTION
AS

IF @Changing IS NULL
	SET @Changing = 0

IF (SELECT COUNT(*) FROM CuboDimension WHERE Cubo = @Cubo AND Dimension = @Dimension) < 1
INSERT INTO CuboDimension (Cubo,Dimension,Tipo,Descripcion,Activa,Changing)
	VALUES (@Cubo,@Dimension,@Tipo,@Descripcion,@Activa,@Changing)
GO 
/* spInsertarFormula */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spInsertarFormula]'))
DROP PROCEDURE [dbo].[spInsertarFormula]
GO
CREATE PROCEDURE spInsertarFormula
		       	@Cubo 			CHAR(20),
			@Nombre 		VARCHAR(100),
			@Descripcion 		VARCHAR(255),
			@Formula 		TEXT,
			@Orden			INT

--//WITH ENCRYPTION
AS
IF (SELECT COUNT(*) FROM CuboFormula WHERE Cubo = @Cubo AND Nombre = @Nombre) < 1
INSERT INTO CuboFormula (Cubo,Nombre,Descripcion,Formula,Orden)
	VALUES (@Cubo,@Nombre,@Descripcion,@Formula,@Orden)
GO
/* spInsertarCubo */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spInsertarCubo]'))
DROP PROCEDURE [dbo].[spInsertarCubo]
GO
CREATE PROCEDURE spInsertarCubo
		       	@Cubo 			CHAR(20),
			@Nombre 		VARCHAR(100),
			@Descripcion 		VARCHAR(255),
			@Vista	 		VARCHAR(100),
			@Instalado		BIT,
			@Activo			BIT

--//WITH ENCRYPTION
AS

DECLARE	@UltimaActualizacion	DATETIME

SELECT @UltimaActualizacion = GETDATE()
IF (SELECT COUNT(*) FROM Cubo WHERE Cubo = @Cubo) < 1
	INSERT INTO Cubo (Cubo,Nombre,Descripcion,Vista,UltimaActualizacion,Instalado,Activo)
		VALUES (@Cubo,@Nombre,@Descripcion,@Vista,@UltimaActualizacion,@Instalado,@Activo)

GO

/* spInsertarDimensionNivel */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spInsertarDimensionNivel]'))
DROP PROCEDURE [dbo].[spInsertarDimensionNivel]
GO
CREATE PROCEDURE spInsertarDimensionNivel
		       	@Cubo 		CHAR(20),
			@Dimension	VARCHAR(50),
			@Campo		VARCHAR(100),
			@Nombre 	VARCHAR(100),
			@Descripcion 	VARCHAR(255),
			@Orden 		INT,
			@Grupo		VARCHAR(30) 	= NULL,
			@MemberKeyUnique BIT		= NULL
			

--//WITH ENCRYPTION
AS

IF @Grupo IS NULL
	SET @Grupo = 'GroupingNone'

IF @MemberKeyUnique IS NULL
	SET @MemberKeyUnique = 0

IF (SELECT COUNT(*) FROM CuboDimensionNivel WHERE Cubo = @Cubo AND Dimension = @Dimension AND Campo = @Campo) < 1
INSERT INTO CuboDimensionNivel (Cubo,Dimension,Campo,Nombre,Descripcion,Orden,Grupo,MemberKeyUnique)
	VALUES (@Cubo,@Dimension,@Campo,@Nombre,@Descripcion,@Orden,@Grupo,@MemberKeyUnique)
GO

/* spInsertarMedida */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spInsertarMedida]'))
DROP PROCEDURE [dbo].[spInsertarMedida]
GO
CREATE PROCEDURE spInsertarMedida
		       	@Cubo 		CHAR(20),
			@Campo		VARCHAR(100),
			@Nombre		VARCHAR(100),
			@Descripcion 	VARCHAR(255),
			@Funcion	VARCHAR(25) = NULL

--//WITH ENCRYPTION
AS

IF @Funcion IS NULL
  SELECT @Funcion = 'aggSum'

IF (SELECT COUNT(*) FROM CuboMedida WHERE Cubo = @Cubo AND Campo = @Campo) < 1
INSERT INTO CuboMedida (Cubo,Campo,Nombre,Descripcion,Funcion)
	VALUES (@Cubo,@Campo,@Nombre,@Descripcion,@Funcion)
GO
/* spObtenerDimension */
IF exists (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[spObtenerDimension]'))
DROP PROCEDURE [dbo].[spObtenerDimension]
GO
CREATE PROCEDURE spObtenerDimension
		       @cubo CHAR(20)
--//WITH ENCRYPTION
AS
  SELECT Dimension,Tipo , Changing
    FROM cuboDimension
    WHERE Cubo = @cubo
     AND Activa = 1
    ORDER BY Dimension
GO
/* spObtenerDimensionNivel */
IF exists (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[spObtenerDimensionNivel]'))
DROP PROCEDURE [dbo].[spObtenerDimensionNivel]
GO
CREATE PROCEDURE spObtenerDimensionNivel
			@Cubo 		CHAR(20),
			@Dimension 	VARCHAR(50)
--//WITH ENCRYPTION
AS
 SELECT  a.Campo ,a.Nombre , 'Grouping' = a.Grupo,a.MemberKeyUnique
  FROM cuboDimensionNivel a,cuboDimension b
  WHERE a.cubo 		= b.cubo 
    AND a.Dimension 	= b.Dimension
    AND a.cubo 		= @cubo
    AND a.dimension 	= @dimension
    AND b.Activa 	= 1
  ORDER BY Orden
GO


/* spObtenerFormula */
IF exists (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[spObtenerFormula]'))
DROP PROCEDURE [dbo].[spObtenerFormula]
GO
CREATE PROCEDURE spObtenerFormula
	@Cubo CHAR(20)
--//WITH ENCRYPTION
AS
 SELECT nombre,Formula
   FROM cuboFormula
  WHERE cubo 		= @cubo
  ORDER BY 		Orden
GO

/* spObtenerMedidas */
IF exists (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[spObtenerMedidas]'))
DROP PROCEDURE [dbo].[spObtenerMedidas]
GO
CREATE PROCEDURE spObtenerMedidas 
	@Cubo   char(20) 
--//WITH ENCRYPTION
AS
 SELECT Campo,Nombre,Funcion
  FROM cuboMedida
  WHERE cubo 		= @cubo
GO
/*Ejecuta Package */
IF exists (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[spEjecutarCubo]'))
DROP PROCEDURE [dbo].[spEjecutarCubo]
GO
CREATE PROCEDURE spEjecutarCubo
  	@Servidor	VARCHAR(20),	
  	@Usuario    	VARCHAR(20),
  	@Password  	VARCHAR(20),
	@cubo 		VARCHAR(20)

--//WITH ENCRYPTION
AS

DECLARE @result 	INT
DECLARE @instruccion 	VARCHAR(80)
DECLARE @tiempo 	DATETIME

IF @Password IS NULL
	SET @Password = ''

SELECT @instruccion = 'DTSRUN ' + '/S' + RTRIM(@Servidor)+ ' /U' + RTRIM(@Usuario) + ' /P' + RTRIM(@Password) + ' /N' + RTRIM(@cubo) + ' /M' 

SELECT @Tiempo = GETDATE()
EXEC @result = MASTER..XP_CMDSHELL @Instruccion 
IF (@result = 0)
  BEGIN
     UPDATE cubo SET UltimaActualizacion = GETDATE() WHERE Cubo = @Cubo
     UPDATE Cubo set Minutos = DATEDIFF(mi,@Tiempo,GETDATE()) WHERE Cubo = @Cubo
  END
GO
/* spCrearJobs */
IF exists (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[spCrearJobs]'))
DROP PROCEDURE [dbo].[spCrearJobs]
GO
CREATE PROCEDURE spCrearJobs
  @EsManual	BIT,
  @Nombre   	VARCHAR(20) 	,
  @Usuario    	VARCHAR(20) 	,
  @Password  	VARCHAR(20) 	,
  @Instruccion  VARCHAR(50) 	,
  @Hora         INT		,
  @BaseDatos   	VARCHAR(20)	,
  @Frecuencia   TINYINT		,
  @Valor	TINYINT		,
  @Recurrencia  BIT		,
  @Servidor	VARCHAR(20)

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

  IF (@@ERROR = 0 AND @ReturnCode = 0)
  BEGIN
	DECLARE @cubo 		CHAR(20)
	DECLARE @cadena 	VARCHAR(100)
	DECLARE @noreg  	INT
	DECLARE @noST	  	INT
	DECLARE @contador  	INT
	DECLARE @StoreProcedure VARCHAR(50)

	SELECT @noreg =  COUNT(*) FROM cubo WHERE Activo = 1

	DECLARE cubo_cursor SCROLL CURSOR FOR
	SELECT Cubo FROM cubo WHERE Activo = 1

	IF @Password = '' 
  		SELECT @Password = 'NULL'

	SET @contador = 1

	OPEN cubo_cursor

	FETCH NEXT FROM cubo_cursor INTO @cubo

	WHILE @@FETCH_STATUS = 0 AND @ReturnCode = 0
	BEGIN
		SET @noST = 0
		SET @StoreProcedure = ''
		SELECT @StoreProcedure = StoreProcedure,@noST = COUNT(*)
			FROM  CuboStore
			WHERE Cubo = @Cubo
			GROUP BY StoreProcedure
		
		IF @noST > 0
    		   BEGIN
			SET @StoreProcedure = 'exec  ' + @StoreProcedure
			EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = @Contador, @step_name = @StoreProcedure, @command = @StoreProcedure, @database_name = @BaseDatos, @server = '', @database_user_name = '', @subsystem = 'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = '', @on_success_step_id = 0, @on_success_action = 3, @on_fail_step_id = 0, @on_fail_action = 3
			SET @contador 	    = @contador + 1	 	
			SET @noreg 	    = @noreg + 1       
		   END		
		 	
		
		SET @cadena 	= 'EXEC spEjecutarCubo  ' + RTRIM(@Servidor)+ ',' + RTRIM(@Usuario) + ',' + RTRIM(@Password) + ',"' + RTRIM(@cubo) + '"'

		IF @contador < @noreg  
		  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = @contador, @step_name = @cubo, @command = @cadena, @database_name = @BaseDatos, @server = '', @database_user_name = '', @subsystem = 'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = '', @on_success_step_id = 0, @on_success_action = 3, @on_fail_step_id = 0, @on_fail_action = 3
		ELSE
		  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = @contador, @step_name = @cubo, @command = @cadena, @database_name = @BaseDatos, @server = '', @database_user_name = '', @subsystem = 'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = '', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
		
		SET @contador 	= @contador + 1	

		FETCH NEXT FROM cubo_cursor INTO @cubo
	END

        IF @ReturnCode = 0
  	  EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 
       
        IF @ReturnCode = 0
  	  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = @Nombre, @enabled = 1, @freq_type = @Frecuencia, @active_start_date = 19900101, @active_start_time = @hora, @freq_interval = @Valor, @freq_subday_type = 1, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = @Recurrencia, @active_end_date = 99991231, @active_end_time = 235959

        IF @ReturnCode = 0
	  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = '(local)' 
  END

  CLOSE cubo_cursor
  DEALLOCATE cubo_cursor
END

IF @ReturnCode = 0
  COMMIT TRANSACTION          
ELSE
  ROLLBACK TRANSACTION 
GO
/* TABLA DE TIEMPO */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('Tiempo')) 
	DROP TABLE Tiempo
GO
CREATE TABLE Tiempo (
	[Fecha] 	[smalldatetime] NOT NULL ,
	[NoDia] 	[SMALLINT] NULL ,
	[Dia] 		[tinyint] NULL ,
	[Mes] 		[tinyint] NULL ,
	[Anio] 		[smallint] NULL ,
	[DiaNombre] 	[VARCHAR] (30)  NULL ,
	[MesNombre] 	[VARCHAR] (30) NULL ,
	[NoSemana] 	[tinyint]   NULL ,
	[Semana] 	[VARCHAR] (50) NULL ,
	[Trimestre] 	[VARCHAR] (30) NULL ,
	[CuaTrimestre] 	[VARCHAR] (30) NULL ,
	[Quincena] 	[VARCHAR] (30) NULL ,
	[Bimestre] 	[VARCHAR] (30) NULL ,
	[Semestre] 	[VARCHAR] (30) NULL 

   CONSTRAINT priTiempo PRIMARY KEY CLUSTERED (Fecha)
) 
GO
/*
DECLARE @fecha 	SMALLDATETIME
DECLARE @fechaAux 	SMALLDATETIME
DECLARE @i 		INT
DECLARE @Dia		TINYINT		
DECLARE @Mes		TINYINT
DECLARE @Anio		SMALLINT
DECLARE @AnioAux	SMALLINT
DECLARE @NoSemana	SMALLINT
DECLARE @NoDia	SMALLINT
DECLARE @DiaNombre	VARCHAR(30)
DECLARE @MesNombre	VARCHAR(30)
DECLARE @Semana	VARCHAR(50)
DECLARE @Trimestre	VARCHAR(30)
DECLARE @CuaTrimestre	VARCHAR(30)
DECLARE @Quincena	VARCHAR(30)
DECLARE @Bimestre	VARCHAR(30)
DECLARE @Semestre	VARCHAR(30)
DECLARE @PrimerDia	INT

SELECT @i 	= 0
SELECT @fecha 	= '1990/01/01'
SELECT @fechaAux = '1990/01/01'
SELECT @AnioAux = 1990
SELECT @NoDia = 0

SELECT @PrimerDia = @@DATEFIRST 
SET DATEFIRST 1

WHILE @i < 5845 ---15 años 1990 - 2005
  BEGIN
    SET @Dia 	= DATEPART(DD,@fecha)
    SET	@Mes 	= DATEPART(M,@fecha)
    SET	@Anio	= DATEPART(YY,@fecha)		
	
--- Se cambio Nodia del AÑo por dia de la semana 8/10/2003
    SET @NoDia    = DATEPART(DW,@fecha)
    SET @DiaNombre = CASE DATEPART(DW,@fecha)
			WHEN 1 THEN '1 Lunes ' 
			WHEN 2 THEN '2 Martes ' 
			WHEN 3 THEN '3 Miercoles ' 
			WHEN 4 THEN '4 Jueves '
			WHEN 5 THEN '5 Viernes ' 
			WHEN 6 THEN '6 Sabado ' 
			WHEN 7 THEN '7 Domingo' 
		      END
    SET @MesNombre = CASE MONTH(@fecha)
			WHEN  1 THEN '01Enero' 
			WHEN  2 THEN '02Febrero'
			WHEN  3 THEN '03Marzo' 
			WHEN  4 THEN '04Abril' 
			WHEN  5 THEN '05Mayo' 
			WHEN  6 THEN '06Junio' 
			WHEN  7 THEN '07Julio' 
			WHEN  8 THEN '08Agosto' 
			WHEN  9 THEN '09Septiembre' 
			WHEN 10 THEN '10Octubre' 
			WHEN 11 THEN '11Noviembre' 
			WHEN 12 THEN '12Diciembre' 
		      END

	SET @Nosemana =  DATEPART(WK,@fecha) 

	IF  DATEPART(DW,@fecha) = 1
		SET @fechaAux = @fecha

	SET @Semana = 'Semana ' + CASE WHEN DATEPART(WK,@fecha) < 10 THEN '0' ELSE '' END 
  				   + CONVERT(CHAR(2),DATEPART(WK,@fecha)) + ' ('
				   + CONVERT(VARCHAR,DAY(@fechaAux))  
				   + CONVERT(VARCHAR,CASE MONTH(@fechaAux)
							WHEN  1 THEN 'ENE' 
							WHEN  2 THEN 'FEB'
							WHEN  3 THEN 'MAR' 
							WHEN  4 THEN 'ABR' 
							WHEN  5 THEN 'MAY' 
							WHEN  6 THEN 'JUN' 
							WHEN  7 THEN 'JUL' 
							WHEN  8 THEN 'AGO' 
							WHEN  9 THEN 'SEP' 
							WHEN 10 THEN 'OCT' 
							WHEN 11 THEN 'NOV' 
							WHEN 12 THEN 'DIC' END) + '-'
 				   + CONVERT(VARCHAR,DAY(dateadd(d,6,@fechaAux))) 
				   + CONVERT(VARCHAR,CASE MONTH(dateadd(d,6,@fechaAux))
							WHEN  1 THEN 'ENE' 
							WHEN  2 THEN 'FEB'
							WHEN  3 THEN 'MAR' 
							WHEN  4 THEN 'ABR' 
							WHEN  5 THEN 'MAY' 
							WHEN  6 THEN 'JUN' 
							WHEN  7 THEN 'JUL' 
							WHEN  8 THEN 'AGO' 
							WHEN  9 THEN 'SEP' 
							WHEN 10 THEN 'OCT' 
							WHEN 11 THEN 'NOV' 
							WHEN 12 THEN 'DIC' END) + ')'

     SET @Quincena = CASE 
			WHEN DAY(@FECHA) <16 THEN 'Quincena 1 '
				            ELSE 'Quincena 2 '    	    
		      END


     SET @Bimestre = CASE 
			WHEN MONTH(@FECHA) in(1,2) 	THEN 'Bimestre 1 '
			WHEN MONTH(@FECHA) in(3,4) 	THEN 'Bimestre 2 ' 
			WHEN MONTH(@FECHA) in(5,6) 	THEN 'Bimestre 3 ' 
			WHEN MONTH(@FECHA) in(7,8) 	THEN 'Bimestre 4 ' 
			WHEN MONTH(@FECHA) in(9,10) 	THEN 'Bimestre 5 ' 
			WHEN MONTH(@FECHA) in(11,12) 	THEN 'Bimestre 6 ' 
		      END

     SET @Trimestre =  CASE 
			WHEN MONTH(@FECHA) in(1,2,3) 	THEN 'Trimestre 1 ' 
			WHEN MONTH(@FECHA) in(4,5,6) 	THEN 'Trimestre 2 ' 
			WHEN MONTH(@FECHA) in(7,8,9) 	THEN 'Trimestre 3 ' 
			WHEN MONTH(@FECHA) in(10,11,12) THEN 'Trimestre 4 ' 
		      END

     SET @semestre = CASE 
			WHEN MONTH(@FECHA) in(1,2,3,4,5,6) 	THEN 'Semestre 1 ' 
			WHEN MONTH(@FECHA)in(7,8,9,10,11,12) 	THEN 'Semestre 2 ' 
		      END

     SET @cuaTrimestre = CASE 
			WHEN MONTH(@FECHA) in(1,2,3,4	) 	THEN 'Cuatrimestre 1 ' 
			WHEN MONTH(@FECHA) in(5,6,7,8	) 	THEN 'Cuatrimestre 2 ' 
			WHEN MONTH(@FECHA) in(9,10,11,12	)	THEN 'Cuatrimestre 3 ' 
		      END

    INSERT INTO Tiempo (Fecha,NoDia,Dia,Mes,Anio,DiaNombre,MesNombre,NoSemana,Semana,Trimestre,CuaTrimestre,Quincena,Bimestre,Semestre)
	VALUES( @fecha, @NoDia, @Dia,@Mes,@Anio,@DiaNombre,@MesNombre,@NoSemana,@Semana,@Trimestre,@CuaTrimestre,@Quincena,@Bimestre,@Semestre)
    SELECT @fecha = dateadd(d,1,@fecha )
    SELECT @i 	  = @i +1
  END

SET DATEFIRST @PrimerDia
*/
GO
/* FUNCION DE OPCIONES */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[fnOpcion]'))
DROP FUNCTION [dbo].[fnOpcion]
GO
CREATE FUNCTION fnOpcion (@SubCuenta VARCHAR(200)) 
RETURNS VARCHAR(200) AS 
BEGIN 
DECLARE @iPuntero	int,
	@iLongitud	int,
	@strToken	VARCHAR(200),
	@strNombre	VARCHAR(200),
	@strTitulo 	VARCHAR(20),
	@strNumero 	VARCHAR(10),
	@strLetra 	VARCHAR(1) 

SET @iLongitud = LEN(RTRIM(@SubCuenta)) 
SET @iPuntero = 1 
SET @strToken = CHAR(32) 
SET @strTitulo = CHAR(32) 
SET @strLetra = CHAR(32) 
SET @strNumero = CHAR(32) 
WHILE @iPuntero <= @iLongitud 
	BEGIN 
		IF dbo.fnEsNumerico(SUBSTRING(@SubCuenta,@iPuntero,1))=0 
			BEGIN 
				IF @iPuntero > 1 
				BEGIN 
					SELECT @strTitulo=RTRIM(Descripcion) 
					FROM Opcion 
					WHERE Opcion = @strLetra 
					
					SELECT @strNombre=Nombre 
					FROM OpcionD 
					WHERE Opcion=@strLetra 
						AND Numero = CONVERT(INT,@strNumero) 
					
					SET @strToken=@strToken+@strTitulo+CHAR(32) +@strNombre+CHAR(32) 
					SET @strNumero = CHAR(32) 
				END 
					
					SET @strLetra=SUBSTRING(@SubCuenta,@iPuntero,1) 
			END 
		ELSE 
			SET @strNumero=@strNumero+SUBSTRING(@SubCuenta,@iPuntero,1) 
		SET @iPuntero=@iPuntero+1 
	END 
	SELECT @strTitulo=RTRIM(Descripcion) 
	FROM Opcion 
	WHERE Opcion=@strLetra 

	SELECT @strNombre=Nombre 
	FROM OpcionD 
	WHERE Opcion=@strLetra 
		AND Numero = CONVERT(INT,@strNumero) 
		
	SET @strToken =	@strToken+@strTitulo+CHAR(32)+@strNombre+CHAR(32) 

	RETURN(LTRIM(@strToken)) 
END
GO

/* spInsertarStoreProcedue */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spInsertarStore]'))
DROP PROCEDURE [dbo].[spInsertarStore]
GO
CREATE PROCEDURE spInsertarStore
		       	@Cubo 			CHAR(20),
			@StoreProcedure		VARCHAR(50),
			@Orden			SMALLINT

--//WITH ENCRYPTION
AS
IF (SELECT COUNT(*) FROM CuboStore WHERE Cubo = @Cubo AND StoreProcedure = @StoreProcedure) < 1
INSERT INTO CuboStore (Cubo,StoreProcedure,Orden)
	VALUES (@Cubo,@StoreProcedure,@Orden)
GO
/* STORE PARA CREAR TABLA DE CLIENTE CIN ID NUMERICO PARA CONTABILIZARLO EN EL CUBO */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spCuboCteId]'))
DROP PROCEDURE [dbo].[spCuboCteId]
GO

CREATE PROCEDURE spCuboCteId 
--//WITH ENCRYPTION
AS
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[CuboCteId]'))
	DROP TABLE [dbo].[CuboCteId]
	
		
	CREATE TABLE CuboCteId(
			Cteid			INTEGER	IDENTITY,
			Cliente			CHAR(10))
	
	INSERT CuboCteId
	SELECT cliente
	FROM   cte
	
GO
EXEC spCuboCteId
GO
/* Store para generar un id numerico para realizar la funcion distinctCount */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('Cubo_ArtID')) 
	DROP TABLE Cubo_ArtID
GO
IF NOT exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('Cubo_ArtID')) 
	CREATE TABLE Cubo_ArtID (
		[Id] 		[INT] IDENTITY NOT NULL ,
		[Articulo] 		[CHAR] (20) NOT NULL 

	CONSTRAINT priCubo_ArtID PRIMARY KEY CLUSTERED (id)
)
GO
IF exists (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[spCuboArt]'))
DROP PROCEDURE [dbo].[spCuboArt]
GO
CREATE PROCEDURE spCuboArt
--//WITH ENCRYPTION
AS
TRUNCATE TABLE Cubo_ArtID
INSERT Cubo_ArtID
SELECT Articulo FROM art
GO
EXEC spCuboArt
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('Cubo_EmbarqueFactura')) 
DROP TABLE Cubo_EmbarqueFactura

CREATE TABLE Cubo_EmbarqueFactura (
	[Id]		[int] NOT NULL,
	[Mov]		[char] (20) NOT NULL,
	[MovID]		[varchar] (20) NOT NULL,
	[Volumen]	[real] NULL
) ON [PRIMARY]
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spCuboEmbarqueFact]'))
DROP PROCEDURE [dbo].[spCuboEmbarqueFact]
GO
CREATE PROCEDURE spCuboEmbarqueFact

--//WITH ENCRYPTION
AS

BEGIN

 SELECT e.Id,em.Mov,em.MovId,vd.Cantidad,a.Volumen,
   CantidadParcial = (select Cantidad from EmbarqueDArt where EmbarqueDArt.ModuloID=VD.ID AND EmbarqueDArt.Renglon=VD.Renglon AND EmbarqueDArt.RenglonSub=VD.RenglonSub AND
   EmbarqueDArt.ID=E.ID AND EmbarqueDArt.moduloid=Em.MODULOID)
 Into #LIstado
 FROM 
  Embarque e
 LEFT OUTER JOIN EmbarqueD ed 	ON e.Id 	= ed.Id 
 LEFT OUTER JOIN EmbarqueMov em 	ON ed.EmbarqueMov = em.Id 
 LEFT OUTER JOIN Venta v 	ON em.ModuloId 	= v.Id
 LEFT OUTER JOIN ventaD vd 	ON v.ID = Vd.Id 
 LEFT OUTER JOIN Art A 	        ON vd.Articulo = A.Articulo

 WHERE 
  e.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND em.Cliente IS NOT NULL


 SELECT Id, Mov, Movid, Volumen,
  'Cantidad1' = CASE WHEN CantidadParcial  is null
				THEN Cantidad
				ELSE CantidadParcial END
 Into #Listado2 
 FROM #LISTADO
 
  insert Cubo_EmbarqueFactura (Id,Mov, MovID,Volumen)
  SELECT Id, Mov, Movid, sum(Cantidad1 * Volumen)
  FROM #LISTADO2
  Group by Id, Mov, Movid
  order by Id, Mov, Movid


END
GO
---EXEC spCuboEmbarqueFact
---GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('Cubo_EmbarqueREP')) 
DROP TABLE Cubo_EmbarqueREP

CREATE TABLE Cubo_EmbarqueREP (
	[Id]		[int] NOT NULL,
	[Mov]		[char] (20) NOT NULL,
	[MovID]		[varchar] (20) NOT NULL,
	[Cliente]	[char] (10) NULL,
	[ClienteEnviarA][int] NULL,
	[RepartosEMB] 	[INT] NULL,
	[RepartosMOV] 	[INT] NULL
) ON [PRIMARY]
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spCuboEmbarque]'))
DROP PROCEDURE [dbo].[spCuboEmbarque]
GO
CREATE PROCEDURE spCuboEmbarque

--//WITH ENCRYPTION
AS

DECLARE @RepartosEMB 	INT
DECLARE @RepartosMOV 	INT
DECLARE @Id		int
DECLARE	@Mov		char (20)
DECLARE	@MovID		varchar (20)
DECLARE	@Cliente	char (10) 
DECLARE	@ClienteEnviarA int
DECLARE @IdAux		int
DECLARE	@MovAux		char (20)
DECLARE	@ClienteAux	char (10) 
DECLARE	@ClienteEnviarAAux int
DECLARE @IdAuxE		int
DECLARE	@ClienteAuxE	char (10) 
DECLARE	@ClienteEnviarAAuxE int

SET @IdAux = NULL
SET @MovAux = NULL
SET @ClienteAux = NULL
SET @ClienteEnviarAAux = NULL
SET @IdAuxE = NULL
SET @ClienteAuxE = NULL
SET @ClienteEnviarAAuxE = NULL

DECLARE cubo_cursor SCROLL CURSOR FOR

SELECT e.Id,em.Mov,em.MovId,em.Cliente,ISNULL(em.ClienteEnviarA,'')
FROM 
  Embarque e
LEFT OUTER JOIN EmbarqueD ed 	ON e.Id 	= ed.Id 
LEFT OUTER JOIN EmbarqueMov em 	ON ed.EmbarqueMov = em.Id 
WHERE 
 e.Estatus IN ('PENDIENTE', 'CONCLUIDO') 
AND em.Cliente IS NOT NULL

ORDER BY e.Id,em.Cliente,ISNULL(em.ClienteEnviarA,''),em.Mov

OPEN cubo_cursor

FETCH NEXT FROM cubo_cursor INTO @Id,@Mov,@MovID,@Cliente,@ClienteEnviarA

WHILE @@FETCH_STATUS = 0 
BEGIN
	IF @Id = @IdAux 
		IF @Cliente = @ClienteAux 
			IF @ClienteEnviarA = @ClienteEnviarAAux 
				IF @Mov = @MovAux 
				  SET @RepartosMOV = 0
				ELSE
			  	BEGIN
			      	  SET @RepartosMOV = 1
				  SET @MovAux = @Mov        
			        END
			ELSE
		  	  BEGIN
		    	    SET @RepartosMOV = 1
			    SET @ClienteEnviarAAux = @ClienteEnviarA
			    SET @MovAux = @Mov
		  	  END
		ELSE
		  BEGIN
		  	SET @RepartosMOV = 1
			SET @ClienteEnviarAAux = @ClienteEnviarA
			SET @ClienteAux = @Cliente
			SET @MovAux = @Mov 
		  END
	ELSE
	  BEGIN
	    SET @RepartosMOV = 1
	    SET @ClienteEnviarAAux = @ClienteEnviarA
	    SET @ClienteAux = @Cliente
	    SET @MovAux = @Mov 
	    SET @IdAux = @Id
  	  END
		
	IF @Id = @IdAuxE 
		IF @Cliente = @ClienteAuxE 
			IF @ClienteEnviarA = @ClienteEnviarAAuxE 
			  SET @RepartosEMB = 0
			ELSE
			  BEGIN
			      SET @RepartosEMB = 1
			      SET @ClienteEnviarAAuxE = @ClienteEnviarA 	
			  END
		ELSE
		  BEGIN
		    SET @RepartosEMB = 1
		    SET @ClienteEnviarAAuxE = @ClienteEnviarA
		    SET @ClienteAuxE = @Cliente
		  END
	ELSE
	  BEGIN
	    SET @RepartosEMB = 1
	    SET @ClienteEnviarAAuxE = @ClienteEnviarA
	    SET @ClienteAuxE = @Cliente
	    SET @IdAuxE = @Id
  	  END
		
	INSERT Cubo_EmbarqueREP 
	VALUES (@Id,@Mov,@MovID,@Cliente,@ClienteEnviarA,@RepartosEMB,@RepartosMOV)

	FETCH NEXT FROM cubo_cursor INTO @Id,@Mov,@MovID,@Cliente,@ClienteEnviarA

 END

  CLOSE cubo_cursor
  DEALLOCATE cubo_cursor

GO

