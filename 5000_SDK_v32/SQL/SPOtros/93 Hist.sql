SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
SET NOCOUNT ON
GO
-----     Tábla de Almacenamiento del Código     -----
IF EXISTS(SELECT * FROM sysobjects WHERE ID = object_id('HistResultado') AND SYSSTAT & 0xf = 3) DROP TABLE HistResultado
	CREATE TABLE HistResultado( [ID]			int				NOT NULL IDENTITY(1,1) PRIMARY KEY,
								[SQL]			varchar(8000)	NULL,
								[FechaHora]		datetime		NULL	DEFAULT GETDATE()
								)
EXEC spALTER_TABLE 'HistResultado', 'Ejecutable', 'bit default 0'
/***************************************************     SysTipoDatos     ***********************************************************/
IF EXISTS(SELECT * FROM sysobjects WHERE ID = object_id('dbo.SysTipoDatos') AND TYPE = 'V') DROP VIEW dbo.SysTipoDatos
GO
CREATE VIEW SysTipoDatos
--//WITH ENCRYPTION
AS
	SELECT "Tabla"		= t.Name,
		   "Campo"		= c.Name,
		   "TipoDatos"	= y.Name,
		   "Tamano"		= c.Length,
		   "Nulos"		= c.IsNullable,
		   "Calculado"	= c.iscomputed
	  FROM sysobjects t, 
	       syscolumns c, 
	       systypes y
	 WHERE t.id = c.id 
	   AND t.type = 'U' 
	   AND c.xusertype = y.xusertype
GO

/**************************************************     fnIDModuloID     ************************************************************/
if exists(select * from sysobjects where name = 'fnIDModuloID' and type = 'fn') drop function fnIDModuloID
GO

CREATE FUNCTION fnIDModuloID(
			@Tabla		varchar(255))
RETURNS varchar(255)
AS
BEGIN
  DECLARE @Campo varchar(255)

  IF (SELECT isnull(ltrim(CampoID), '') FROM SysTabla WHERE SysTabla = @Tabla)<>''
    SELECT @Campo = (SELECT Top 1 isnull(ltrim(CampoID), '') FROM SysTabla WHERE SysTabla = @Tabla)
  ELSE
  IF EXISTS(SELECT C.Name 
	          FROM syscolumns C
              JOIN sysobjects T ON C.ID = T.ID
             WHERE T.name = @Tabla
               AND C.Name = 'ModuloID')
    SELECT @Campo = 'ModuloID'
  ELSE
    SELECT @Campo = 'ID'

  RETURN @Campo
END
GO

/************************************************     spHistCamposIndice     ********************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spHistCamposIndice') and type = 'P') drop procedure dbo.spHistCamposIndice
GO

CREATE PROCEDURE spHistCamposIndice
  @Tabla          varchar(256),
  @Campos         varchar(1000),
  @Resultado      varchar(1000) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Caracter  varchar(1),
          @Auxiliar  int,
          @Longitud  int,
          @Campo     varchar(256),
          @ID        int,
          @IDAnt     int,
          @SQL       Nvarchar(1000),
          @ConDatos  bit

  
  DECLARE @tmp       table(
            ID       int IDENTITY,
            Campo    varchar(256)
          ) 

  SELECT @Campos = REPLACE(@Campos, ', ', ' ')
  SELECT @Campos = REPLACE(@Campos, ',', ' ')
  SELECT @Longitud = LEN(@Campos), @Auxiliar = 1, @Resultado = '', @Campo = ''
  WHILE(1=1)
  BEGIN
    SELECT @Caracter = SUBSTRING(@Campos, @Auxiliar, 1)
    IF @Auxiliar > @Longitud BREAK
    SELECT @Auxiliar = @Auxiliar + 1
    IF @Caracter <> ' ' SELECT @Campo = @Campo + @Caracter
    IF (@Caracter = ' ') OR (@Auxiliar - 1 = @Longitud)
    BEGIN
      INSERT INTO @tmp(Campo) SELECT @Campo
      SELECT @Campo = ''
    END
  END
  
  SELECT @Resultado = ''
  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(ID) FROM @tmp WHERE ID > @IDAnt
    IF @ID IS NULL BREAK
    SELECT @IDAnt = @ID
    SELECT @Campo = Campo FROM @tmp WHERE ID = @ID
    IF EXISTS(
        SELECT *
          FROM sysobjects
          JOIN syscolumns ON sysobjects.id = syscolumns.id
         WHERE sysobjects.name = @Tabla
           AND syscolumns.name = @Campo
             )
    BEGIN
      SELECT @SQL = N'IF EXISTS(SELECT * FROM ' + @Tabla + ' WHERE ' + @Campo + ' IS NOT NULL) SELECT @ConDatos = 1 ELSE SELECT @ConDatos = 0' 
      EXEC sp_ExecuteSQL @SQL, N'@ConDatos bit OUTPUT', @ConDatos OUTPUT
      IF @ConDatos = 1
        SELECT @Resultado = @Resultado + @Campo + ', '
    END
  END

  IF(SELECT SUBSTRING(@Resultado, LEN(@Resultado), 1)) = ','
    SELECT @Resultado = SUBSTRING(@Resultado, 1, LEN(@Resultado) - 1)
END
GO

/******************************************************     HistLog     *************************************************************/
if not exists (select * from SysTabla where SysTabla = 'HistLog') 
INSERT INTO SysTabla (SysTabla) VALUES ('HistLog')
if not exists (select * from sysobjects where id = object_id('dbo.HistLog') and type = 'U') 
CREATE TABLE dbo.HistLog (
	ID	    	int		NOT NULL	IDENTITY(1,1),

	Modulo	    	char(5)	    	NULL,
	HastaFecha	datetime    	NULL,
	HastaHora	datetime    	NULL,
	Cantidad    	int	    	NULL,
	Ok	    	int	    	NULL,
	OkRef	    	varchar(255)    NULL,

	CONSTRAINT priHistLog PRIMARY KEY CLUSTERED (ID)
)
GO

EXEC spAlter_Table 'HistLog', 'Horas',      'float NULL'
EXEC spAlter_Table 'HistLog', 'Periodo',    'int NULL'
EXEC spAlter_Table 'HistLog', 'Ejercicio',  'int NULL'
GO

/**************************************************     fnHastaFecha     ************************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnHastaFecha') DROP FUNCTION fnHastaFecha
GO
CREATE FUNCTION fnHastaFecha (@Fecha datetime, @CantidadSt varchar(20), @Unidad varchar(20))
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	datetime,
    @Cantidad	float,
    @Hoy		datetime,
    @Dia		int,
    @DiaSemana	int,
    @Mes		int,
    @Hora		int,
    @Minuto		int,
    @Segundo	int,
    @ms			int

  SELECT @CantidadSt = NULLIF(RTRIM(UPPER(@CantidadSt)), ''), @Unidad = UPPER(@Unidad)

  IF @Unidad = 'AÑO' SELECT @Unidad = 'ANO'
  IF @Unidad IN ('ANO', 'MES', 'SEMANA', 'DIA')
    SELECT @Hoy = dbo.fnFechaSinHora(@Fecha)
  ELSE
    SELECT @Hoy = @Fecha

  SELECT @Dia = DAY(@Hoy), @DiaSemana = DATEPART(weekday, @Hoy), @Mes = MONTH(@Hoy),
         @Hora = DATEPART(hour, @Hoy), @Minuto = DATEPART(minute, @Hoy), @Segundo = DATEPART(second, @Hoy), @ms = DATEPART(millisecond, @hoy)
  SELECT @Resultado = @Hoy
  IF dbo.fnEsNumerico(@CantidadSt) = 1 
  BEGIN
    SELECT @Cantidad = CONVERT(float, @CantidadSt)
    IF @Unidad = 'ANO'     SELECT @Resultado = DATEADD(year,   -@Cantidad, @Resultado) ELSE
    IF @Unidad = 'MES'     SELECT @Resultado = DATEADD(month,  -@Cantidad, @Resultado) ELSE
    IF @Unidad = 'SEMANA'  SELECT @Resultado = DATEADD(week,   -@Cantidad, @Resultado) ELSE
    IF @Unidad = 'DIA'     SELECT @Resultado = DATEADD(day,    -@Cantidad, @Resultado) ELSE
    IF @Unidad = 'HORA'    SELECT @Resultado = DATEADD(hour,   -@Cantidad, @Resultado) ELSE
    IF @Unidad = 'MINUTO'  SELECT @Resultado = DATEADD(minute,  -@Cantidad, @Resultado) ELSE
    IF @Unidad = 'SEGUNDO' SELECT @Resultado = DATEADD(second,  -@Cantidad, @Resultado)
  END ELSE 
  IF @CantidadSt IN ('ESTE', 'ESTA')
  BEGIN
    IF @Unidad IN ('MES', 'ANO') SELECT @Resultado = DATEADD(day, -@Dia+1, @Resultado)
    IF @Unidad = 'ANO'    SELECT @Resultado = DATEADD(month, -@Mes+1, @Resultado)
    IF @Unidad = 'SEMANA' SELECT @Resultado = DATEADD(weekday, -@DiaSemana+1, @Resultado)
    IF @Unidad = 'HORA' SELECT @Resultado = DATEADD(minute, -@Minuto, @Resultado)
    IF @Unidad IN ('HORA', 'MINUTO') SELECT @Resultado = DATEADD(second, -@Segundo, @Resultado)
    IF @Unidad IN ('HORA', 'MINUTO', 'SEGUNDO') SELECT @Resultado = DATEADD(millisecond, -@ms, @Resultado)
  END
  RETURN (@Resultado)
END
GO 

/***********************************************     spReducirBasedatos     *********************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spReducirBasedatos') and type = 'P') drop procedure dbo.spReducirBasedatos
GO
CREATE PROCEDURE spReducirBasedatos
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Database	varchar(100)

  SELECT @Database = '['+RTRIM(DB_NAME())+']'
  EXEC ('DBCC SHRINKDATABASE (' + @Database + ', 10)')
END
GO

/****************************************************     HistTrabajo     ***********************************************************/
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.HistTrabajo') AND type = 'U') 
  CREATE TABLE dbo.HistTrabajo (
        Trabajo         varchar(255) NOT NULL,
        Frecuencia      varchar(50)  NULL,
        Valor           int          NULL,
        Activo          bit          NOT NULL DEFAULT 0,
        Tipo			varchar(20)  NULL
  CONSTRAINT priHistTrabajo PRIMARY KEY CLUSTERED (Trabajo)
  )
GO
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'HistTrabajo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('HistTrabajo', 'N/A')


/******************************************************     spHist     **************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spHist') and type = 'P') drop procedure dbo.spHist
GO
CREATE PROCEDURE spHist
			@Horas	float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MovTabla	    varchar(50),
    @Modulo	    char(5),
    @HistMin	    varchar(20),
    @HistMinUnidad  varchar(20),
    @HistMax	    varchar(20),
    @HistMaxUnidad  varchar(20),
    @HastaFecha	    datetime,
    @HastaFechaMin  datetime,
    @HastaFechaMax  datetime,
    @HastaHora	    datetime,
    @Ok		    int,
    @OkRef	    varchar(255),
    @SQL	    nvarchar(4000),

    @FileGroup      varchar(256)

  SET DATEFIRST 7
  SET NOCOUNT ON

  SELECT @Ok = NULL, @OkRef = NULL, @HastaHora = DATEADD(minute, ISNULL(@Horas, 0)*60.0, GETDATE())

  DECLARE crModulo CURSOR LOCAL FOR
   SELECT Modulo, HistMin, HistMinUnidad, HistMax, HistMaxUnidad
     FROM Modulo
    WHERE Hist = 1
    ORDER BY Modulo

  OPEN crModulo
  FETCH NEXT FROM crModulo INTO @Modulo, @HistMin, @HistMinUnidad, @HistMax, @HistMaxUnidad
  WHILE @@FETCH_STATUS <> -1 AND GETDATE() < @HastaHora AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN

      SELECT @MovTabla = RTRIM(dbo.fnMovTabla(@Modulo))
      SELECT @HastaFechaMin = dbo.fnHastaFecha(GETDATE(), @HistMin, @HistMinUnidad),
             @HastaFechaMax = dbo.fnHastaFecha(GETDATE(), @HistMax, @HistMaxUnidad)
      IF @HastaFechaMin < @HastaFechaMax SELECT @HastaFecha = @HastaFechaMin ELSE SELECT @HastaFecha = @HastaFechaMax
      SELECT @SQL = N'EXEC spHist'+@MovTabla+' @Horas, @HastaFecha, @HastaHora, @Ok OUTPUT, @OkRef OUTPUT'
      EXEC sp_ExecuteSQL @SQL, 
                         N'@Horas float, @HastaFecha datetime, @HastaHora datetime, @Ok int OUTPUT, @OkRef varchar(255) OUTPUT', 
                         @Horas, @HastaFecha, @HastaHora, @Ok OUTPUT, @OkRef OUTPUT
    END
    FETCH NEXT FROM crModulo INTO @Modulo, @HistMin, @HistMinUnidad, @HistMax, @HistMaxUnidad
  END
  CLOSE crModulo
  DEALLOCATE crModulo

  RETURN
END
GO

/********************************************     spHistSugerirEstructura     *******************************************************/
IF EXISTS(SELECT * FROM sysobjects WHERE ID = object_id('dbo.spHistSugerirEstructura') AND TYPE = 'P') DROP PROCEDURE dbo.spHistSugerirEstructura
GO
CREATE PROCEDURE spHistSugerirEstructura
	@Tabla 				varchar(100), 
	@ConTipoDatos 		bit = 0, 
	@ConNulos 			bit = 0, 
	@ConvertirVarchar 	bit = 0, 
	@AsCalcSinDatos 	bit = 0,
	@EnSilencio			bit = 0,
	@HistCampo			bit = 0,
	@Resultado			varchar(max) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
	DECLARE
		@Campo				varchar(100),
		@TipoDatos			varchar(100),
		@TipoDatosTamano	varchar(100), 
		@Tamano				int,
		@Nulos				bit,
		@Calculado			bit,
		@Estructura			varchar(255),
		@ID					int,
		@EsPK				bit,
		@ChecarTieneDatos	bit,
		@ConDatos			bit,
		@SQL				nvarchar(4000)
		
	DECLARE crSysTipoDatos CURSOR FOR
	 SELECT Campo, TipoDatos, Tamano, Nulos, Calculado
	   FROM SysTipoDatos
	  WHERE Tabla = @Tabla
	
	OPEN crSysTipoDatos
	FETCH NEXT FROM crSysTipoDatos INTO @Campo, @TipoDatos, @Tamano, @Nulos, @Calculado
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @Campo IN (NULL, 'SincroID', 'SincroC')
				FETCH NEXT FROM crSysTipoDatos INTO @Campo, @TipoDatos, @Tamano, @Nulos, @Calculado
		
			IF @Campo NOT IN (NULL, 'SincroID', 'SincroC')
			BEGIN
				SELECT @Estructura = ''
				-------------------------------------------------------------
				IF @Calculado = 0
					SELECT @Resultado  = ISNULL(@Resultado,'') + @Campo + ', '
				-------------------------------------------------------------
				SELECT @Estructura = ISNULL(@Estructura,'') + @Campo
				-------------------------------------------------------------
				IF @ConvertirVarchar = 1							
				BEGIN
					IF @TipoDatos = 'char'  AND @Tamano > 5 SELECT @TipoDatos = 'varchar'
					IF @TipoDatos = 'nchar' AND @Tamano > 5 SELECT @TipoDatos = 'nvarchar'
				END
				IF @TipoDatos IN ('char', 'nchar', 'varchar', 'nvarchar') 
					SELECT @TipoDatosTamano = @TipoDatos + '('+CASE WHEN CAST(@Tamano as varchar(10)) = '-1' THEN 'max' ELSE CAST(@Tamano as varchar(10)) END+')'
				ELSE
					SELECT @TipoDatosTamano = @TipoDatos
				-------------------------------------------------------------
				IF @ConTipoDatos = 1
					SELECT @Estructura = ISNULL(@Estructura,'') +' '+ @TipoDatosTamano
				-------------------------------------------------------------
				IF @ConNulos = 1
					SELECT @Estructura = ISNULL(@Estructura,'') +' '+CASE WHEN @Nulos = 1 THEN 'NULL' ELSE 'NOT NULL' END
				-------------------------------------------------------------
				
				IF EXISTS(SELECT * FROM dbo.fnTablaPK(@Tabla) WHERE Campo = @Campo) SELECT @EsPK = 1 
				
				IF @AsCalcSinDatos = 1 AND @EsPK = 0
				BEGIN
					SELECT @ChecarTieneDatos = 1
					IF @EnSilencio = 1 
						BEGIN
							IF EXISTS(SELECT * FROM HistCampo WHERE Tabla = @Tabla AND Campo = @Campo)
								SELECT @ChecarTieneDatos = 0, @ConDatos = ConDatos FROM HistCampo WHERE Tabla = @Tabla AND Campo = @Campo
						END
					IF @ChecarTieneDatos = 1
						BEGIN
							IF @TipoDatos = 'bit'
								BEGIN
									SELECT @SQL = N'IF EXISTS(SELECT * FROM '+@Tabla+' WHERE '+@Campo+' <> 0) SELECT @ConDatos = 1 ELSE SELECT @ConDatos = 0' 
									EXEC sp_ExecuteSQL @SQL, N'@ConDatos bit OUTPUT', @ConDatos OUTPUT
								END 
							ELSE 
								BEGIN
									SELECT @SQL = N'IF EXISTS(SELECT * FROM '+@Tabla+' WHERE '+@Campo+' IS NOT NULL) SELECT @ConDatos = 1 ELSE SELECT @ConDatos = 0' 
									EXEC sp_ExecuteSQL @SQL, N'@ConDatos bit OUTPUT', @ConDatos OUTPUT
									SELECT @ConDatos ConDatos
								END
						END
				END
				
				IF @HistCampo = 1
				INSERT HistCampo (Tabla, Campo, ConDatos) VALUES (@Tabla, @Campo, @ConDatos)

				-------------------------------------------------------------
				SELECT @Estructura = @Estructura + ','
				IF @EnSilencio <> 1
					BEGIN
						INSERT HistResultado ([SQL], Ejecutable) VALUES (@Estructura, 1)
						SELECT @ID = SCOPE_IDENTITY()
					END
				-------------------------------------------------------------	
				FETCH NEXT FROM crSysTipoDatos INTO @Campo, @TipoDatos, @Tamano, @Nulos, @Calculado
			END
		END
	
	CLOSE crSysTipoDatos
	DEALLOCATE crSysTipoDatos
	
	IF @EnSilencio <> 1
	BEGIN
		UPDATE HistResultado SET [SQL] = REPLACE([SQL],',','')
		 WHERE ID = @ID
	END
	
	IF(SELECT SUBSTRING(@Resultado, LEN(@Resultado), 1)) = ','
		SELECT @Resultado = SUBSTRING(@Resultado, 1, LEN(@Resultado) - 1)

  RETURN
END
GO

/************************************************     spHistSugerir     *************************************************************/
IF EXISTS(SELECT * FROM sysobjects WHERE ID = object_id('dbo.spHistSugerir') AND TYPE = 'P') DROP PROCEDURE dbo.spHistSugerir
GO
CREATE PROCEDURE spHistSugerir
	@Modulo	     		varchar(5)   = NULL,
	@Database    		varchar(255) = NULL,
	@Filegroup   		varchar(255) = NULL,
	@FileName    		varchar(255) = NULL,
	@Especial			varchar(20)  = NULL,
	@EnSilencio			bit = 0
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE
		@ModuloIsNotNull 	bit,
		@MovTabla	    	varchar(50),
		@Tabla	    		varchar(100),
		@hTabla	    		varchar(100),
		@gTabla	    		varchar(100),
		@Campo				varchar(255),
		@Top				int,
		@ErrorInsertar  	int,
		@ErrorEliminar  	int,
		@RutaArchivoBD		varchar(255),
		@Resultado	    	varchar(max)
	
	SELECT @ErrorInsertar = 61010, 
		   @ErrorEliminar = 61020,
		   @Top			  = 1000000
		   
	SELECT @Modulo = NULLIF(RTRIM(UPPER(@Modulo)), '')
	IF @Modulo IS NOT NULL SELECT @ModuloIsNotNull = 1 ELSE SELECT @ModuloIsNotNull = 0	
	
	-----     Tábla de Almacenamiento del Código     -----
	IF EXISTS(SELECT * FROM sysobjects WHERE ID = object_id('HistResultado') AND SYSSTAT & 0xf = 3) DROP TABLE HistResultado
		CREATE TABLE HistResultado( [ID]			int				NOT NULL IDENTITY(1,1) PRIMARY KEY,
									[SQL]			varchar(8000)	NULL,
									[FechaHora]		datetime		NULL	DEFAULT GETDATE()
									)
	EXEC spALTER_TABLE 'HistResultado', 'Ejecutable', 'bit default 0'
	------------------------------------------------------
	IF EXISTS(SELECT * FROM sysobjects where id = object_id('HistCampo') and sysstat & 0xf = 3) DROP TABLE HistCampo
		CREATE TABLE HistCampo (Tabla		varchar(100)	NOT NULL,
								Campo		varchar(100)	NOT NULL,
								ConDatos	bit		NULL	DEFAULT 0,
								CONSTRAINT priHistCampo PRIMARY KEY CLUSTERED (Tabla, Campo)
								)	
	------------------------------------------------------
	IF @FileName IS NULL
		BEGIN
			SELECT @RutaArchivoBD = physical_name FROM sys.database_files WHERE type_desc = 'ROWS' ORDER BY data_space_id ASC
			SELECT @RutaArchivoBD = REVERSE(@RutaArchivoBD)
			SELECT @RutaArchivoBD = SUBSTRING(@RutaArchivoBD,CHARINDEX('\',@RutaArchivoBD,1),LEN(@RutaArchivoBD))
			SELECT @RutaArchivoBD = RTRIM(LTRIM(REVERSE(@RutaArchivoBD)))
		END
	------------------------------------------------------
	IF @Database IS NULL SELECT @Database = RTRIM(DB_NAME())--'['+RTRIM(DB_NAME())+']'
	IF @Filegroup IS NULL SELECT @Filegroup = 'Hist'
	IF @FileName IS NULL SELECT @FileName = @RutaArchivoBD+@Database+'_'+@Filegroup+'.ndf'
	------------------------------------------------------
	IF EXISTS(SELECT * FROM sysobjects where id = object_id('HistMov') and sysstat & 0xf = 3) DROP TABLE HistMov
		CREATE TABLE HistMov (Tabla varchar(100) NOT NULL  PRIMARY KEY)
			  INSERT HistMov (Tabla) VALUES('Mov')
			  INSERT HistMov (Tabla) VALUES('MovTiempo')
			  INSERT HistMov (Tabla) VALUES('MovEstatusLog')
			  INSERT HistMov (Tabla) VALUES('MovUsuario')
			  INSERT HistMov (Tabla) VALUES('MovBitacora')
			  INSERT HistMov (Tabla) VALUES('MovImpuesto')
			  INSERT HistMov (Tabla) VALUES('MovRecibo')
			  INSERT HistMov (Tabla) VALUES('MovPresupuesto')
			  INSERT HistMov (Tabla) VALUES('MovPersonal')
			  INSERT HistMov (Tabla) VALUES('MovGastoIndirecto')
			  INSERT HistMov (Tabla) VALUES('MovArtEstatus')
			  INSERT HistMov (Tabla) VALUES('MovTarea')
			  INSERT HistMov (Tabla) VALUES('MovReg')
			  INSERT HistMov (Tabla) VALUES('MovDReg')
	------------------------------------------------------
	
	-----     Creación del FileGroup     ------
	IF @Modulo IS NULL
		BEGIN
			-------------------------------------------------------------------
			INSERT HistResultado (SQL) 
			SELECT '/*** CREACION DEL FILEGROUP HISTORICO ***/'
			INSERT HistResultado([SQL], Ejecutable)
			SELECT 'SET ANSI_NULLS OFF', 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT CHAR(71)+CHAR(79), 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT '',0
			-------------------------------------------------------------------
			INSERT HistResultado ([SQL], Ejecutable) 
			SELECT 'ALTER DATABASE '+@Database+' ADD FILEGROUP '+@Filegroup, 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT CHAR(71)+CHAR(79), 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT '',0
			-------------------------------------------------------------------
			INSERT HistResultado ([SQL], Ejecutable) 
			SELECT 'ALTER DATABASE '+@Database+' '+
				   'ADD FILE(NAME = '+@Database+'_'+@Filegroup+', FILENAME = '''+@FileName+''', '+
				   'SIZE = 5MB, MAXSIZE = UNLIMITED, FILEGROWTH = 5MB) TO FILEGROUP '+@Filegroup, 1
			UNION				   
			SELECT CHAR(71)+CHAR(79), 1
	-------------------------------------------
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT 'USE '+@Database, 1
	-------------------------------------------				
			DECLARE crTabla CURSOR LOCAL FOR 
			 SELECT RTRIM(SysTabla)
			   FROM SysTabla
			  WHERE SysTabla IN (SELECT Tabla FROM HistMov)
		   ORDER BY SysTabla		
			
			OPEN crTabla
			FETCH NEXT FROM crTabla INTO @Tabla
			WHILE @@FETCH_STATUS = 0
				BEGIN
					IF @Especial IS NULL
						BEGIN
							SELECT @hTabla = 'h'+@Tabla
							------------------------------------------------------
							INSERT HistResultado (SQL) 
							SELECT '/** '+@hTabla+' **/'
							
							INSERT HistResultado (SQL, Ejecutable)
							SELECT 'CREATE TABLE '+@hTabla+'(', 1
							
							EXEC spHistSugerirEstructura @Tabla, 
														 @ConTipoDatos = 1, 
														 @ConNulos = 1, 
														 @ConvertirVarchar = 1, 
														 @AsCalcSinDatos = @ModuloIsNotNull,
														 @HistCampo = 1
							
							IF ISNULL(dbo.fnTablaPKSt(@Tabla),'') <> ''			
								INSERT HistResultado (SQL, Ejecutable) 
								SELECT '  CONSTRAINT pk_'+@hTabla+' PRIMARY KEY CLUSTERED ('+dbo.fnTablaPKSt(@Tabla)+')', 1
							
							INSERT HistResultado (SQL, Ejecutable) 
							SELECT ') ON '+@Filegroup, 1
							INSERT HistResultado (SQL, Ejecutable)
							SELECT CHAR(71)+CHAR(79), 1
							------------------------------------------------------
						END
					IF @Especial IN (NULL, 'VISTAS')
						BEGIN
							SELECT @gTabla = 'g'+@Tabla
							------------------------------------------------------
							INSERT HistResultado (SQL) 
							SELECT '/** '+@gTabla+' **/'

							INSERT HistResultado (SQL, Ejecutable) 
							SELECT 'CREATE VIEW '+@gTabla, 1
							
							INSERT HistResultado (SQL, Ejecutable) 
							SELECT ' WITH ENCRYPTION AS', 1

							INSERT HistResultado (SQL, Ejecutable) 
							SELECT 'SELECT ', 1

							EXEC spHistSugerirEstructura @Tabla
							
							INSERT HistResultado (SQL, Ejecutable) 
							SELECT ' FROM '+ @Tabla, 1

							INSERT HistResultado (SQL, Ejecutable) 
							SELECT 'UNION ALL ', 1

							INSERT HistResultado (SQL, Ejecutable) 
							SELECT 'SELECT ', 1

							EXEC spHistSugerirEstructura @Tabla
							
							INSERT HistResultado (SQL, Ejecutable) 
							SELECT ' FROM '+ @hTabla, 1

							INSERT HistResultado (SQL, Ejecutable) 
							SELECT CHAR(71)+CHAR(79), 1
						END
					FETCH NEXT FROM crTabla INTO @Tabla					
				END
			CLOSE crTabla
			DEALLOCATE crTabla

			-------------------------------------------------------------------
			
			SELECT @MovTabla = 'Mov'
			INSERT HistResultado (SQL, Ejecutable)
			SELECT 'IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = object_id(''dbo.spHist'+@MovTabla+'Mover'') AND TYPE = ''P'') DROP PROCEDURE dbo.spHist'+@MovTabla+'Mover', 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT CHAR(71)+CHAR(79), 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT 'CREATE PROCEDURE spHist'+@MovTabla+'Mover', 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT '                  @ID     int,', 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT '                  @Modulo varchar(5),',1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT '                  @Ok     int          OUTPUT,', 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT '                  @OkRef  varchar(255) OUTPUT', 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT 'WITH ENCRYPTION', 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT 'AS BEGIN', 1
			-------------------------------------------------------------------
			DECLARE crTabla CURSOR LOCAL FOR 
			 SELECT RTRIM(SysTabla)
			   FROM SysTabla
			  WHERE SysTabla IN (SELECT Tabla FROM HistMov)
		   ORDER BY SysTabla
			
			OPEN crTabla
			FETCH NEXT FROM crTabla INTO @Tabla
			WHILE @@FETCH_STATUS = 0
				BEGIN
					SELECT @Resultado = ''
					
					INSERT HistResultado (SQL) 
					SELECT '/** '+@Tabla+' **/'
					-------------------------------------------------------------------
					INSERT HistResultado (SQL, Ejecutable)
					SELECT '  INSERT h'+@Tabla, 1 
					
					EXEC spHistSugerirEstructura @Tabla, @EnSilencio = 1, @Resultado = @Resultado OUTPUT
					
					INSERT HistResultado (SQL, Ejecutable) 
					SELECT '        ('+@Resultado+')',1
					
					INSERT HistResultado (SQL, Ejecutable) 
					SELECT '  SELECT '+@Resultado,1

					INSERT HistResultado (SQL, Ejecutable) 
					SELECT '    FROM ' + @Tabla, 1
					-------------------------------------------------------------------
					
					SELECT @Campo = dbo.fnIDModuloID(@Tabla)
       
					IF @Modulo IS NOT NULL 
						INSERT HistResultado (SQL, Ejecutable) 
						SELECT '   WHERE '+@Campo+' = @ID', 1
					ELSE
						INSERT HistResultado (SQL, Ejecutable) 
						SELECT '   WHERE '+@Campo+' = @ID AND Modulo = @Modulo', 1
					-------------------------------------------------------------------

					INSERT HistResultado (SQL, Ejecutable)
					SELECT '  IF @@ERROR <> 0 SELECT @Ok = '+CONVERT(varchar, @ErrorInsertar)+', @OkRef = ''h'+@Tabla+'''', 1

					IF @Modulo IS NOT NULL 
						INSERT HistResultado (SQL, Ejecutable) 
						SELECT '  DELETE ' + @Tabla + ' WHERE '+@Campo+' = @ID', 1
					ELSE
						INSERT HistResultado (SQL, Ejecutable) 
						SELECT '  DELETE ' + @Tabla + ' WHERE '+@Campo+' = @ID AND Modulo = @Modulo', 1
					-------------------------------------------------------------------
					
					INSERT HistResultado (SQL, Ejecutable)			
					SELECT '  IF @@ERROR <> 0 SELECT @Ok = '+CONVERT(varchar, @ErrorEliminar)+', @OkRef = '''+@Tabla+'''', 1
					
					FETCH NEXT FROM crTabla INTO @Tabla
				END
			CLOSE crTabla
			DEALLOCATE crTabla
			
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  RETURN', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT 'END', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT CHAR(71)+CHAR(79), 1
			
		END
	-------------------------------------------
	
	IF @Modulo IS NOT NULL
		BEGIN
			SELECT @MovTabla = RTRIM(dbo.fnMovTabla(@Modulo))
			
			INSERT HistResultado (SQL) 
			SELECT '/*** CREACION TABLAS HISTORICAS DEL MODULO '+UPPER(@Modulo)+' ***/'
		
			DECLARE crTabla CURSOR LOCAL FOR 
			 SELECT RTRIM(SysTabla)
			   FROM SysTabla
			  WHERE Modulo = @Modulo
			    AND SysTabla NOT IN ('DimPasoPipe')
		   ORDER BY Orden
			
			OPEN crTabla
			FETCH NEXT FROM crTabla INTO @Tabla
			
			WHILE @@FETCH_STATUS = 0
				BEGIN
					IF @Especial IS NULL
						BEGIN
							SELECT @hTabla = 'h'+@Tabla
							------------------------------------------------------
							INSERT HistResultado (SQL) 
							SELECT '/** '+@hTabla+' **/'
							
							INSERT HistResultado (SQL, Ejecutable)
							SELECT 'CREATE TABLE '+@hTabla+'(', 1
							
							EXEC spHistSugerirEstructura @Tabla, 
														 @ConTipoDatos = 1, 
														 @ConNulos = 1, 
														 @ConvertirVarchar = 1, 
														 @AsCalcSinDatos = @ModuloIsNotNull,
														 @HistCampo = 1
							
							IF ISNULL(dbo.fnTablaPKSt(@Tabla),'') <> ''			
								INSERT HistResultado (SQL, Ejecutable) 
								SELECT '  CONSTRAINT pk_'+@hTabla+' PRIMARY KEY CLUSTERED ('+dbo.fnTablaPKSt(@Tabla)+')', 1
							
							INSERT HistResultado (SQL, Ejecutable) 
							SELECT ') ON '+@Filegroup, 1
							INSERT HistResultado (SQL, Ejecutable)
							SELECT CHAR(71)+CHAR(79), 1
					------------------------------------------------------
					IF @Especial IN (NULL, 'VISTAS')
						BEGIN
							SELECT @gTabla = 'g'+@Tabla
							------------------------------------------------------
							INSERT HistResultado (SQL) 
							SELECT '/** '+@gTabla+' **/'

							INSERT HistResultado (SQL, Ejecutable) 
							SELECT 'CREATE VIEW '+@gTabla, 1
							
							INSERT HistResultado (SQL, Ejecutable) 
							SELECT ' WITH ENCRYPTION AS', 1

							INSERT HistResultado (SQL, Ejecutable) 
							SELECT 'SELECT ', 1
							
							EXEC spHistSugerirEstructura @Tabla
							
							INSERT HistResultado (SQL, Ejecutable) 
							SELECT ' FROM '+ @Tabla, 1

							INSERT HistResultado (SQL, Ejecutable) 
							SELECT 'UNION ALL ', 1

							INSERT HistResultado (SQL, Ejecutable) 
							SELECT 'SELECT ', 1

							EXEC spHistSugerirEstructura @Tabla
							
							INSERT HistResultado (SQL, Ejecutable) 
							SELECT ' FROM '+ @hTabla, 1

							INSERT HistResultado (SQL, Ejecutable) 
							SELECT CHAR(71)+CHAR(79), 1
						END							
					FETCH NEXT FROM crTabla INTO @Tabla
					END
				END
				
			CLOSE crTabla
			DEALLOCATE crTabla
			
		-- Creación de Indice en la tabla Principal del Módulo
		-------------------------------------------
		IF RTRIM(@MovTabla) <> 'Mov'
			BEGIN
				INSERT HistResultado (SQL) 
				SELECT 'EXEC spADD_INDEX '''+ @MovTabla + ''', ''Hist'', ''FechaEmision, ID, Estatus'''
				INSERT HistResultado (SQL) 
				SELECT CHAR(71)+CHAR(79)	
			END
		-------------------------------------------
			
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT 'IF EXISTS(SELECT * FROM sysobjects WHERE ID = object_id('+CHAR(39)+'dbo.'+'spHist'+@MovTabla+'Mover'+CHAR(39)+') AND TYPE = '+CHAR(39)+'P'+CHAR(39)+')',1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT 'DROP PROCEDURE dbo.'+'spHist'+@MovTabla+'Mover',1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT CHAR(71)+CHAR(79),1

		-------------------------------------------
			
			INSERT HistResultado (SQL, Ejecutable)
			SELECT 'CREATE PROCEDURE spHist'+@MovTabla+'Mover', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '                  @ID     int,', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '                  @Ok     int          OUTPUT,', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '                  @OkRef  varchar(255) OUTPUT', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT 'WITH ENCRYPTION', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT 'AS BEGIN', 1
			
			-------------------------------------------			
			DECLARE crTabla CURSOR LOCAL FOR 
			 SELECT RTRIM(SysTabla)
			   FROM SysTabla
			  WHERE Modulo = @Modulo
			    AND SysTabla NOT IN ('DimPasoPipe')
		   ORDER BY Orden
		   
			OPEN crTabla
			FETCH NEXT FROM crTabla INTO @Tabla
		   
			WHILE @@FETCH_STATUS = 0
				BEGIN
					SELECT @Resultado = ''
				
					INSERT HistResultado (SQL) 
					SELECT '/** '+@Tabla+' **/' 
					
					INSERT HistResultado (SQL, Ejecutable) 
					SELECT '  INSERT h'+@Tabla, 1 
					
					EXEC spHistSugerirEstructura @Tabla, @EnSilencio = 1, @Resultado = @Resultado OUTPUT
					
					INSERT HistResultado (SQL, Ejecutable) 
					SELECT '        ('+@Resultado+')',1 
					-------------------------------------------			
					
					INSERT HistResultado (SQL, Ejecutable) 
					SELECT '  SELECT '+@Resultado, 1 
					
					INSERT HistResultado (SQL, Ejecutable) 
					SELECT '    FROM ' + @Tabla, 1 
					
					-------------------------------------------
					SELECT @Campo = dbo.fnIDModuloID(@Tabla)
       
					IF @Modulo IS NOT NULL 
						INSERT HistResultado (SQL, Ejecutable)
						SELECT '   WHERE '+@Campo+' = @ID', 1
					ELSE
						INSERT HistResultado (SQL, Ejecutable)
						SELECT '   WHERE '+@Campo+' = @ID AND Modulo = @Modulo', 1

					INSERT HistResultado (SQL, Ejecutable)
					SELECT '  IF @@ERROR <> 0 SELECT @Ok = '+CONVERT(varchar, @ErrorInsertar)+', @OkRef = ''h'+@Tabla+'''', 1

					IF @Modulo IS NOT NULL 
						INSERT HistResultado (SQL, Ejecutable) 
						SELECT '  DELETE ' + @Tabla + ' WHERE '+@Campo+' = @ID', 1
					ELSE
						INSERT HistResultado (SQL, Ejecutable)
						SELECT '  DELETE ' + @Tabla + ' WHERE '+@Campo+' = @ID AND Modulo = @Modulo', 1

					INSERT HistResultado (SQL, Ejecutable) 
					SELECT '  IF @@ERROR <> 0 SELECT @Ok = '+CONVERT(varchar, @ErrorEliminar)+', @OkRef = '''+@Tabla+'''', 1
					
					FETCH NEXT FROM crTabla INTO @Tabla
				END
			
			CLOSE crTabla
			DEALLOCATE crTabla
			-------------------------------------------			
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  RETURN', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT 'END', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT CHAR(71)+CHAR(79), 1
			-------------------------------------------
		END
	
	IF @Modulo IS NOT NULL AND @Especial IS NULL
		BEGIN
			INSERT HistResultado (SQL) 
			SELECT '/************** spHist'+@MovTabla+' *************/'
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT 'IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_id(''dbo.spHist'+@MovTabla+''') AND TYPE = ''P'') DROP PROCEDURE dbo.spHist'+@MovTabla, 1
			INSERT HistResultado (SQL, Ejecutable) VALUES (CHAR(71)+CHAR(79), 1)
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT 'CREATE PROCEDURE spHist'+@MovTabla, 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '                  @Horas      float,', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '                  @HastaFecha datetime,', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '                  @HastaHora  datetime,', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '                  @Ok         int          OUTPUT,', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '                  @OkRef      varchar(255) OUTPUT', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT 'WITH ENCRYPTION', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT 'AS BEGIN', 1

			INSERT HistResultado (SQL, Ejecutable)
			SELECT 'DECLARE', 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT '  @ID        int,', 1
			INSERT HistResultado (SQL, Ejecutable)
			SELECT '  @Cantidad  int', 1
			INSERT HistResultado (SQL) 
			SELECT ''     

			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  BEGIN TRANSACTION', 1
			INSERT HistResultado (SQL) 
			SELECT ''     

			-- *********** EWQ 08/JUNIO/2007
			-- Se deshabilitan los triggers de la tabla Origen para permitir mover los movimientos.
			INSERT HistResultado (SQL) 
			SELECT ''     
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  ALTER TABLE ' + @MovTabla + ' DISABLE TRIGGER ALL ', 1
			INSERT HistResultado (SQL) 
			SELECT ''     
			-- Fin
			-- *********** EWQ 08/JUNIO/2007

			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  SELECT @Cantidad = 0', 1
			INSERT HistResultado (SQL, Ejecutable) 

			-- *********** EWQ 08/JUNIO/2007
			-- Se agregó el tipo FORWARD_ONLY LOCAL STATIC al cursor
			SELECT '  DECLARE crHist'+@MovTabla+' CURSOR FORWARD_ONLY LOCAL STATIC FOR ', 1
			IF @Top IS NULL
				INSERT HistResultado (SQL, Ejecutable) 
				SELECT '   SELECT ID', 1
			ELSE
				INSERT HistResultado (SQL, Ejecutable) 
				SELECT '   SELECT TOP '+CONVERT(varchar, @Top)+' ID', 1
			
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '     FROM '+@MovTabla, 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '    WHERE FechaEmision < @HastaFecha AND Estatus IN (''CONCLUIDO'', ''CONCILIADO'', ''CANCELADO'')', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '    ORDER BY FechaEmision', 1
			INSERT HistResultado (SQL) 
			SELECT ''     

			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  OPEN crHist'+@MovTabla, 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  FETCH NEXT FROM crHist'+@MovTabla+' INTO @ID', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '    BEGIN', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '      EXEC spHist'+@MovTabla+'Mover @ID, @Ok OUTPUT, @OkRef OUTPUT', 1
			
			IF @Modulo IS NOT NULL
				BEGIN
					INSERT HistResultado (SQL, Ejecutable) 
					SELECT '      IF @Ok IS NULL', 1
					INSERT HistResultado (SQL, Ejecutable) 
					SELECT '        EXEC spHistMovMover @ID, '''+@Modulo+''', @Ok OUTPUT, @OkRef OUTPUT', 1
				END
			
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '      IF @Ok IS NULL SELECT @Cantidad = @Cantidad + 1', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '    FETCH NEXT FROM crHist'+@MovTabla+' INTO @ID', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  END', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  CLOSE crHist'+@MovTabla, 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  DEALLOCATE crHist'+@MovTabla, 1
			INSERT HistResultado (SQL) 
			SELECT ''     

			-- Se habilitan los triggers de la tabla Origen
			INSERT HistResultado (SQL) 
			SELECT ''     
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  ALTER TABLE ' + @MovTabla + ' ENABLE TRIGGER ALL ', 1
			INSERT HistResultado (SQL) 
			SELECT ''     

			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  IF @Ok IS NULL COMMIT TRANSACTION ELSE ROLLBACK TRANSACTION', 1
			INSERT HistResultado (SQL) 
			SELECT ''     
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  INSERT HistLog (Modulo, HastaFecha, HastaHora, Cantidad, Ok, OkRef, Horas, Periodo, Ejercicio) VALUES ('''+@Modulo+''', @HastaFecha, @HastaHora, @Cantidad, @Ok, @OkRef, @Horas, MONTH(@HastaFecha), YEAR(@HastaFecha))', 1

			INSERT HistResultado (SQL, Ejecutable) 
			SELECT '  RETURN', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT 'END', 1
			INSERT HistResultado (SQL, Ejecutable) 
			SELECT CHAR(71)+CHAR(79), 1
	END
	
	IF @EnSilencio = 0
		SELECT [SQL] FROM HistResultado
			
END
GO
/***************************************************     spHistAuto     *************************************************************/
IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.spHistAuto') AND TYPE = 'P') DROP PROCEDURE dbo.spHistAuto
GO
CREATE PROC spHistAuto
			@Modulo			varchar(5),
			@Ejecutar		bit
--//WITH ENCRYPTION
AS BEGIN
	DECLARE
	@Linea		varchar(max),
	@SQL		varchar(max)
	
	IF @Ejecutar = 0
	BEGIN
		IF @Modulo IS NULL
			EXEC spHistSugerir @EnSilencio = 1
		
		IF @Modulo IS NOT NULL
			EXEC spHistSugerir @Modulo = @Modulo, @EnSilencio = 1
		
		DECLARE cCodigo CURSOR FOR
			SELECT [SQL] FROM HistResultado WHERE Ejecutable = 1 ORDER BY ID ASC
		
		OPEN cCodigo
		FETCH NEXT FROM cCodigo INTO @Linea
		
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			SELECT @SQL = ISNULL(@SQL,'')+CHAR(13)+CHAR(10)+CASE WHEN RTRIM(LTRIM(@Linea)) = CHAR(71)+CHAR(79) THEN ';' ELSE RTRIM(LTRIM(@Linea)) END
			
			IF RTRIM(LTRIM(@Linea)) = CHAR(71)+CHAR(79)
				BEGIN
					BEGIN TRY
						EXEC (@SQL)
						SELECT @SQL = ''
					END TRY
					BEGIN CATCH
						SELECT @SQL = ''
					END CATCH
				END
			FETCH NEXT FROM cCodigo INTO @Linea
		END
		
		CLOSE cCodigo
		DEALLOCATE cCodigo
	END
END
GO
/***************************************************     Ejecución     **************************************************************/

EXEC spHistAuto  NULL,  0
GO
EXEC spHistAuto 'VTAS', 0
GO
EXEC spHistAuto 'COMS', 0
GO
EXEC spHistAuto 'CXC',  0
GO
EXEC spHistAuto 'CXP',  0
GO
EXEC spHistAuto 'NOM',  0
GO
EXEC spHistAuto 'DIN',  0
GO
EXEC spHistAuto 'EMB',  0
GO
EXEC spHistAuto 'AF',   0
GO
EXEC spHistAuto 'CONC',   0
GO
EXEC spHistAuto 'ASIS',   0
GO

/***********************************************     spAgregaCampoHist     **********************************************************/
IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.spAgregaCampoHist') AND TYPE = 'P') DROP PROCEDURE dbo.spAgregaCampoHist
GO
CREATE PROCEDURE spAgregaCampoHist
	@Modulo		varchar(5)
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE
		@Tabla				varchar(100),
		@hTabla				varchar(100),
		@Campo				varchar(100),
		@TipoDatos			varchar(100),
		@Tamano				int,
		@Nulos				bit,
		@Calculado			bit,
		@TipoDatosTamano	varchar(100),
		@Estructura			varchar(255),
		@ID					int,
		@EsPK				bit,
		@ChecarTieneDatos	bit,
		@ConDatos			bit,
		@SQL				nvarchar(4000)


	SELECT @SQL = 'TRUNCATE TABLE HistResultado'
	EXEC(@SQL)
	SELECT @SQL = ''
	-----------------------------------------------------------------------------------------------
	DECLARE crTabla CURSOR FOR
	 SELECT RTRIM(LTRIM(SysTabla))
	   FROM SysTabla
	  WHERE Modulo = @Modulo

	OPEN crTabla
	FETCH NEXT FROM crTabla INTO @Tabla
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
	-----------------------------------------------------------------------------------------------
			SELECT @hTabla = 'h'+@Tabla
			
			DECLARE crSysTipoDatos CURSOR FOR
			 SELECT Campo, TipoDatos, Tamano, Nulos, Calculado
			   FROM SysTipoDatos
			  WHERE Tabla = @Tabla
				AND Campo NOT IN (NULL, 'SincroID', 'SincroC')
			-----------------------------------------------------------------------------------------------			
			OPEN crSysTipoDatos
			FETCH NEXT FROM crSysTipoDatos INTO @Campo, @TipoDatos, @Tamano, @Nulos, @Calculado
			
			WHILE @@FETCH_STATUS = 0
				BEGIN
					IF NOT EXISTS(SELECT * FROM SysTipoDatos WHERE Tabla = @hTabla AND Campo = @Campo) AND @Calculado = 0
						BEGIN
							SELECT @SQL = 'EXEC spAlter_Table '+CHAR(39)+@hTabla+CHAR(39)+','+CHAR(39)+@Campo+CHAR(39)+','
							SELECT @SQL = @SQL+CHAR(39)+@TipoDatos
									
							IF @TipoDatos IN('char', 'nchar', 'varchar', 'nvarchar')
								SELECT @SQL = @SQL+' ('+CAST(@Tamano as varchar(10))+')'
							
							IF @Nulos = 1
								SELECT @SQL = @SQL+' NULL'
							ELSE
								BEGIN
									IF @TipoDatos IN('char', 'nchar', 'varchar', 'nvarchar')
										SELECT @SQL = @SQL+' NOT NULL DEFAULT '+CHAR(39)+CHAR(39)+' WITH VALUES'
									
									IF @TipoDatos IN('int', 'float', 'money', 'numeric')
										SELECT @SQL = @SQL+' NOT NULL DEFAULT '+'0'+' WITH VALUES'
								END
							SELECT @SQL= @SQL+CHAR(39)
							BEGIN TRAN
								BEGIN TRY
									EXEC(@SQL)
									COMMIT TRAN
								END TRY
								BEGIN CATCH
									ROLLBACK TRAN
								END CATCH
							
						END
					FETCH NEXT FROM crSysTipoDatos INTO @Campo, @TipoDatos, @Tamano, @Nulos, @Calculado
				END

			-----------------------------------------------------------------------------------------------

			CLOSE crSysTipoDatos
			DEALLOCATE crSysTipoDatos

	-----------------------------------------------------------------------------------------------
			FETCH NEXT FROM crTabla INTO @Tabla
		END
	
	CLOSE crTabla
	DEALLOCATE crTabla
	
	SELECT @SQL = 'EXEC spHistAuto '+CHAR(39)+LTRIM(RTRIM(@Modulo))+CHAR(39)+', 0'
	EXEC(@SQL)
	
END
GO
/***************************************************     Ejecución     **************************************************************/
EXEC spAgregaCampoHist 'VTAS'
GO
EXEC spAgregaCampoHist 'COMS'
GO
EXEC spAgregaCampoHist 'CXC'
GO
EXEC spAgregaCampoHist 'CXP'
GO
EXEC spAgregaCampoHist 'NOM'
GO
EXEC spAgregaCampoHist 'DIN'
GO
EXEC spAgregaCampoHist 'EMB'
GO
EXEC spAgregaCampoHist 'AF'
GO
EXEC spAgregaCampoHist 'CONC'
GO
EXEC spAgregaCampoHist 'ASIS'
GO

/**********************************************     spEjecutaHistoricos     *********************************************************/
IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.spEjecutaHistoricos') AND TYPE = 'P') DROP PROCEDURE dbo.spEjecutaHistoricos
GO
CREATE PROCEDURE spEjecutaHistoricos
--//WITH ENCRYPTION
AS BEGIN
	DECLARE
		@Modulo			 varchar(5),
		@Hist			   bit,
		@Frecuencia	 int,
		@Periodo		 int,
		@Dias		 	   int,
		@HastaFecha	 datetime

	DECLARE crModulo CURSOR FOR
		SELECT Modulo, Hist, Cast(HistMin as Int), Cast(HistMinUnidad as Int)
		  FROM Modulo 
		 WHERE Hist = 1
	
	OPEN crModulo
	
	FETCH NEXT FROM crModulo INTO @Modulo, @Hist, @Frecuencia, @Periodo
	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @Hist = 1
				BEGIN
					IF @Periodo = 1
						SELECT @Dias = @Frecuencia
					IF @Periodo = 2
						SELECT @Dias = @Frecuencia * 30
					IF @Periodo = 3
						SELECT @Dias = @Frecuencia * 365
					
					SELECT @HastaFecha = GETDATE()-@Dias
					
					IF @Modulo = 'VTAS'
						BEGIN
							EXEC spAgregaCampoHist 'VTAS'
							EXEC spHistVenta NULL, @HastaFecha, NULL, NULL, NULL
						END
					IF @Modulo = 'COMS'
						BEGIN
							EXEC spAgregaCampoHist 'COMS'
							EXEC spHistCompra NULL, @HastaFecha, NULL, NULL, NULL
						END
					IF @Modulo = 'CXC'
						BEGIN
							EXEC spAgregaCampoHist 'CXC'
							EXEC spHistCxc NULL, @HastaFecha, NULL, NULL, NULL
						END
					IF @Modulo = 'CXP'
						BEGIN
							EXEC spAgregaCampoHist 'CXP'
							EXEC spHistCXP NULL, @HastaFecha, NULL, NULL, NULL
						END											
					IF @Modulo = 'NOM'
						BEGIN
							EXEC spAgregaCampoHist 'NOM'
							EXEC spHistNomina NULL, @HastaFecha, NULL, NULL, NULL
						END
					IF @Modulo = 'DIN'
						BEGIN
							EXEC spAgregaCampoHist 'DIN'
							EXEC spHistDinero NULL, @HastaFecha, NULL, NULL, NULL
						END  
					IF @Modulo = 'EMB'
						BEGIN
							EXEC spAgregaCampoHist 'EMB'
							EXEC spHistEmbarque NULL, @HastaFecha, NULL, NULL, NULL
						END  
					IF @Modulo = 'AF'
						BEGIN
							EXEC spAgregaCampoHist 'AF'
							EXEC spHistActivoFijo NULL, @HastaFecha, NULL, NULL, NULL
						END  
					IF @Modulo = 'CONC'
						BEGIN
							EXEC spAgregaCampoHist 'CONC'
							EXEC spHistConciliacion NULL, @HastaFecha, NULL, NULL, NULL
						END  
					IF @Modulo = 'ASIS'
						BEGIN
							EXEC spAgregaCampoHist 'ASIS'
							EXEC spHistAsiste NULL, @HastaFecha, NULL, NULL, NULL
						END  

				END
			FETCH NEXT FROM crModulo INTO @Modulo, @Hist, @Frecuencia, @Periodo
		END
	
	CLOSE crModulo
	DEALLOCATE crModulo
END
GO


/************************************************     spHistCrearJob     ************************************************************/
IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.spHistCrearJob') AND TYPE = 'P') DROP PROCEDURE dbo.spHistCrearJob
GO             
CREATE PROCEDURE spHistCrearJob
  @Nombre           varchar(100),
  @BaseDatos        varchar(30),
  @Cadena           nvarchar(100) = 'spEjecutaHistoricos'
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
  @Procesar                varchar(30)
 
  BEGIN TRANSACTION
    DECLARE @SQLServerAgent TABLE
    (
    Estatus                       varchar(50)
    )
    SELECT @Fecha = GETDATE()
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
            RAISERROR ('Unable to import job ''Históricos '' since there is already a multi-server job with this name.', 16, 1)
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
       FROM HistTrabajo


	   IF(ISNULL(@Cadena, '') = '') SELECT @Cadena = 'spEjecutaHistoricos'
       SET @Cadena     = N''+@Cadena



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
