SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/*    Marco Polo Flores Perea
	  Modulo Examen V 1.0
	  16/Julio/2008 */

/****** Alta de Cursos  ******/
IF NOT EXISTS(SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'heExamenCurso') 
BEGIN
INSERT INTO SysTabla (SysTabla) VALUES ('heExamenCurso')
		CREATE TABLE heExamenCurso(
					Curso		varchar(50) NOT NULL,
					Descripcion	text NULL,
					Estatus		varchar(15) NULL
			CONSTRAINT PK_heExamenCurso PRIMARY KEY (Curso))
END
GO

/****** Alta de Preguntas  ******/
IF NOT EXISTS(SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'heExamen') 
BEGIN
INSERT INTO SysTabla (SysTabla) VALUES ('heExamen')
		CREATE TABLE heExamen(
					Curso		varchar(50) NOT NULL,
					NPregunta	int NOT NULL,
					Pregunta	text NULL,
					Tipo		varchar(10) NULL,
					Nivel		varchar(15) NULL,
					Respuesta1	varchar(255) NULL,
					CRespuesta1	bit NULL,
					Respuesta2	varchar(255) NULL,
					CRespuesta2	bit NULL,
					Respuesta3	varchar(255) NULL,
					CRespuesta3	bit NULL,
					Respuesta4	varchar(255) NULL,
					CRespuesta4	bit NULL,
					Respuesta5	varchar(255) NULL,
					CRespuesta5	bit NULL,
					Ponderacion	float NULL,
					Estatus		varchar(15) NULL,
					Tiempo		int NULL
			CONSTRAINT PK_heExamen PRIMARY KEY (Curso,NPregunta))
END
GO

/****** Examen a Resolver  ******/
IF NOT EXISTS(SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'heExamenPersonal') 
BEGIN
INSERT INTO SysTabla (SysTabla) VALUES ('heExamenPersonal')
		CREATE TABLE heExamenPersonal(
					IDExamen	int NOT NULL,
					Personal	varchar(10) NOT NULL,
					PassWord	varchar(5) NULL,
					Curso		varchar(50) NOT NULL,
					NPregunta	int NOT NULL,
					Fecha		datetime NOT NULL,
					Estatus		varchar(15) NOT NULL,
					R1			bit NULL,
					R1A			text NULL,
					R2			bit NULL,
					R3			bit NULL,
					R4			bit NULL,
					R5			bit NULL
			CONSTRAINT PK_heExamenPersonal PRIMARY KEY (IDExamen,Personal,Curso,NPregunta,Fecha,Estatus))
END
GO

/****** Genera Contrasena ******/
IF EXISTS(SELECT name FROM sysobjects WHERE type = 'p' AND ID = object_id('dbo.spHECreaPassWord')) DROP PROCEDURE spHECreaPassWord
GO
CREATE PROCEDURE spHECreaPassWord
				@PassWord varchar(5) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE @Contador int
	SET @Contador=5
	SET @PassWord=''
	WHILE @Contador>0
	BEGIN
		SELECT @PassWord=@PassWord+CONVERT(varchar(1),FLOOR(RAND()*10))
		SET @Contador=@Contador-1
	END
	SELECT @PassWord
END
GO

/****** Niveles de Examen  ******/
IF NOT EXISTS(SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'heExamenNivel') 
BEGIN
INSERT INTO SysTabla (SysTabla) VALUES ('heExamenNivel')
		CREATE TABLE heExamenNivel(
					Nivel		varchar(50) NOT NULL,
			CONSTRAINT PK_heExamenNivel PRIMARY KEY (Nivel))
END
GO

IF NOT EXISTS(SELECT * FROM heExamenNivel WHERE Nivel = 'TODOS')
  INSERT heExamenNivel VALUES('TODOS')
GO

/****** Cambia Estatus por pregunta ******/
IF EXISTS(SELECT name FROM sysobjects WHERE type = 'p' AND ID = object_id('dbo.spCambiaEstatus')) DROP PROCEDURE spCambiaEstatus
GO

CREATE PROCEDURE spCambiaEstatus
				 @Personal	varchar(10),
				 @Fecha		datetime,
				 @Curso		varchar(50),
				 @IDExamen	int,
				 @NPregunta	int
--//WITH ENCRYPTION
AS
BEGIN

	UPDATE heExamenPersonal SET Estatus='CONCLUIDO' 
	WHERE IDExamen=@IDExamen AND Personal=@Personal AND @Curso=Curso AND Fecha=@Fecha AND NPregunta=@NPregunta

END
GO

/****** Genera Examenes ******/
IF EXISTS(SELECT name FROM sysobjects WHERE type = 'p' AND ID = object_id('dbo.spHESeleccionaPreguntas')) DROP PROCEDURE spHESeleccionaPreguntas
GO

CREATE PROCEDURE spHESeleccionaPreguntas
    @Curso			varchar(50),
    @Nivel			varchar(15),
    @NPreguntas		int,
    @Nivel1			varchar(15)=NULL,
    @NPreguntas1	int=-1,
    @Nivel2			varchar(15)=NULL,
    @NPreguntas2	int=-1,
    @Personal		varchar(10),
    @Aleatorio		char(2)='Si'
--//WITH ENCRYPTION
AS      
BEGIN      
  SET NOCOUNT ON      
  DECLARE @NPregunta int,      
    @Aux  int,      
    @Fecha  datetime,      
    @IDExamen int,      
    @PassWord varchar(5)      
  SELECT @Fecha=CONVERT(datetime,CONVERT(varchar(4),YEAR(GETDATE()))+RIGHT('00'+CONVERT(varchar(2),MONTH(GETDATE())),2)+      
       RIGHT('00'+CONVERT(varchar(2),DAY(GETDATE())),2))      
  SELECT @Aux=COUNT(0) FROM Personal WHERE Personal=@Personal       
  IF @Aux=0      
   BEGIN      
    RAISERROR('El Personal No existe o no esta dado de ALTA',16,1)      
    RETURN -1      
   END      
  SELECT @Aux=COUNT(0) FROM heExamenCurso WHERE Curso=@Curso AND Estatus='ALTA'      
  IF @Aux=0      
   BEGIN      
    RAISERROR('El Curso No existe o no esta dado de ALTA',16,1)      
    RETURN -1      
   END      
  SELECT @Aux=COUNT(0) FROM heExamen WHERE Curso=@Curso AND Nivel=(CASE @Nivel WHEN 'TODOS' THEN Nivel ELSE @Nivel END) AND Estatus='ALTA'      
  IF @NPreguntas=0 SELECT @NPreguntas=COUNT(0) FROM heExamen WHERE Curso=@Curso AND Nivel=(CASE @Nivel WHEN 'TODOS' THEN Nivel ELSE @Nivel END) AND Estatus='ALTA'      
  IF @NPreguntas>@Aux      
   BEGIN      
    RAISERROR('No existen preguntas suficientes este curso en este nivel',16,1)      
    RETURN -1      
   END      
  IF @NPreguntas1>-1      
   BEGIN      
    SELECT @Aux=COUNT(0) FROM heExamen WHERE Curso=@Curso AND Nivel=(CASE @Nivel1 WHEN 'TODOS' THEN Nivel ELSE @Nivel1 END) AND Estatus='ALTA'      
    IF @NPreguntas1=0 SELECT @NPreguntas1=COUNT(0) FROM heExamen WHERE Curso=@Curso AND Nivel=(CASE @Nivel1 WHEN 'TODOS' THEN Nivel ELSE @Nivel1 END) AND Estatus='ALTA'      
    IF @NPreguntas1>@Aux      
     BEGIN      
      RAISERROR('No existen preguntas suficientes este curso en este nivel1',16,1)      
      RETURN -1      
     END      
   END      
  IF @NPreguntas2>-1      
   BEGIN      
    SELECT @Aux=COUNT(0) FROM heExamen WHERE Curso=@Curso AND Nivel=(CASE @Nivel2 WHEN 'TODOS' THEN Nivel ELSE @Nivel2 END) AND Estatus='ALTA'      
    IF @NPreguntas2=0 SELECT @NPreguntas2=COUNT(0) FROM heExamen WHERE Curso=@Curso AND Nivel=(CASE @Nivel2 WHEN 'TODOS' THEN Nivel ELSE @Nivel2 END) AND Estatus='ALTA'      
    IF @NPreguntas2>@Aux      
     BEGIN      
      RAISERROR('No existen preguntas suficientes este curso en este nivel2',16,1)      
      RETURN -1      
     END      
   END      
  SELECT @IDExamen=ISNULL(MAX(IDExamen),0)+1 FROM heExamenPersonal      
  EXEC spHECreaPassWord @PassWord OUTPUT      
  WHILE @NPreguntas>0      
   BEGIN      
    SELECT @NPregunta=NPregunta      
    FROM heExamenCurso c      
    JOIN heExamen e ON e.Curso=C.Curso      
    WHERE c.Estatus='ALTA' AND c.Curso=@Curso AND e.Nivel=(CASE @Nivel WHEN 'TODOS' THEN e.Nivel ELSE @Nivel END) AND      
    NPregunta=CASE WHEN @Aleatorio='Si' THEN (FLOOR(RAND()*200)) ELSE Npregunta END AND e.Estatus='ALTA'      
    AND NPregunta NOT IN(SELECT heExamenPersonal.NPregunta FROM heExamenPersonal      
    JOIN heExamen ON heExamenPersonal.Curso=heExamen.Curso AND heExamenPersonal.Npregunta=heExamen.NPregunta      
    WHERE Personal=@Personal AND heExamenPersonal.Curso=@Curso AND Fecha=@Fecha AND IDExamen=@IDExamen      
    AND heExamen.Nivel=(CASE @Nivel WHEN 'TODOS' THEN e.Nivel ELSE @Nivel END))      
   ORDER BY NPregunta      
   IF @@ROWCOUNT>0      
    BEGIN      
     SELECT @Aux=COUNT(0)      
     FROM heExamenPersonal      
     WHERE Personal=@Personal AND Curso=@Curso AND NPregunta=@NPregunta AND Fecha=@Fecha AND IDExamen=@IDExamen      
     IF @Aux=0      
      BEGIN      
       INSERT heExamenPersonal VALUES(@IDExamen,@Personal,@PassWord,@Curso,@NPregunta,@Fecha,'SIN AFECTAR',0,'',0,0,0,0)      
       SET @NPreguntas=@NPreguntas-1      
      END      
    END      
   END      
  WHILE @NPreguntas1>0      
   BEGIN      
    SELECT @NPregunta=NPregunta      
    FROM heExamenCurso c      
    JOIN heExamen e ON e.Curso=C.Curso      
    WHERE c.Estatus='ALTA' AND c.Curso=@Curso AND e.Nivel=(CASE @Nivel1 WHEN 'TODOS' THEN e.Nivel ELSE @Nivel1 END) AND      
    NPregunta=CASE WHEN @Aleatorio='Si' THEN (FLOOR(RAND()*200)) ELSE Npregunta END AND e.Estatus='ALTA'      
    AND NPregunta NOT IN(SELECT heExamenPersonal.NPregunta FROM heExamenPersonal      
    JOIN heExamen ON heExamenPersonal.Curso=heExamen.Curso AND heExamenPersonal.Npregunta=heExamen.NPregunta      
    WHERE Personal=@Personal AND heExamenPersonal.Curso=@Curso AND Fecha=@Fecha AND IDExamen=@IDExamen      
    AND heExamen.Nivel=(CASE @Nivel1 WHEN 'TODOS' THEN e.Nivel ELSE @Nivel1 END))      
    ORDER BY NPregunta      
   IF @@ROWCOUNT>0      
    BEGIN      
     SELECT @Aux=COUNT(0)      
     FROM heExamenPersonal      
     WHERE Personal=@Personal AND Curso=@Curso AND NPregunta=@NPregunta AND Fecha=@Fecha AND IDExamen=@IDExamen      
     IF @Aux=0      
      BEGIN      
       INSERT heExamenPersonal VALUES(@IDExamen,@Personal,@PassWord,@Curso,@NPregunta,@Fecha,'SIN AFECTAR',0,'',0,0,0,0)      
       SET @NPreguntas1=@NPreguntas1-1      
      END      
    END      
   END      
  WHILE @NPreguntas2>0      
   BEGIN      
    SELECT @NPregunta=NPregunta      
    FROM heExamenCurso c      
    JOIN heExamen e ON e.Curso=C.Curso      
    WHERE c.Estatus='ALTA' AND c.Curso=@Curso AND e.Nivel=(CASE @Nivel2 WHEN 'TODOS' THEN e.Nivel ELSE @Nivel2 END) AND      
    NPregunta=CASE WHEN @Aleatorio='Si' THEN (FLOOR(RAND()*200)) ELSE Npregunta END AND e.Estatus='ALTA'      
    AND NPregunta NOT IN(SELECT heExamenPersonal.NPregunta FROM heExamenPersonal      
    JOIN heExamen ON heExamenPersonal.Curso=heExamen.Curso AND heExamenPersonal.Npregunta=heExamen.NPregunta      
    WHERE Personal=@Personal AND heExamenPersonal.Curso=@Curso AND Fecha=@Fecha AND IDExamen=@IDExamen      
    AND heExamen.Nivel=(CASE @Nivel2 WHEN 'TODOS' THEN e.Nivel ELSE @Nivel2 END))      
    ORDER BY NPregunta      
   IF @@ROWCOUNT>0      
    BEGIN      
     SELECT @Aux=COUNT(0)      
     FROM heExamenPersonal      
     WHERE Personal=@Personal AND Curso=@Curso AND NPregunta=@NPregunta AND Fecha=@Fecha AND IDExamen=@IDExamen      
    IF @Aux=0      
     BEGIN      
      INSERT heExamenPersonal VALUES(@IDExamen,@Personal,@PassWord,@Curso,@NPregunta,@Fecha,'SIN AFECTAR',0,'',0,0,0,0)      
      SET @NPreguntas2=@NPreguntas2-1      
     END      
    END      
   END      
  SELECT COUNT(0) FROM heExamenPersonal WHERE Personal=@Personal AND Curso=@Curso AND Fecha=@Fecha AND IDExamen=@IDExamen      
END      
GO

/****** Califica Examenes ******/
IF EXISTS(SELECT name FROM sysobjects WHERE type = 'p' AND ID = object_id('dbo.spRptCalifica')) DROP PROCEDURE spRptCalifica
GO

CREATE PROCEDURE spRptCalifica
				 @Personal	varchar(10),
--				 @Fecha		datetime,
				 @Curso		varchar(50),
				 @IDExamen	int
--//WITH ENCRYPTION
AS
BEGIN

CREATE TABLE #Calificacion (
				NPregunta			int,
				CorrectaIncorrecta	varchar(15),
				Personal			varchar(10),
				Curso				varchar(50))

DECLARE @NPregunta			int,
		@Respuesta1			varchar(2),
		@Respuesta2			varchar(2),
		@Respuesta3			varchar(2),
		@Respuesta4			varchar(2),
		@Respuesta5			varchar(2),
		@CorrectaIncorrecta	varchar(15)

		SELECT CASE WHEN ep.R1=e.CresPuesta1 THEN 'OK' ELSE CONVERT(varchar(2),ep.R1) END Respuesta1,
			   CASE WHEN ep.R2=e.CresPuesta2 THEN 'OK' ELSE CONVERT(varchar(2),ep.R2) END Respuesta2,
			   CASE WHEN ep.R3=e.CresPuesta3 THEN 'OK' ELSE CONVERT(varchar(2),ep.R3) END Respuesta3,
			   CASE WHEN ep.R4=e.CresPuesta4 THEN 'OK' ELSE CONVERT(varchar(2),ep.R4) END Respuesta4,
			   CASE WHEN ep.R5=e.CresPuesta5 THEN 'OK' ELSE CONVERT(varchar(2),ep.R5) END Respuesta5,
			   ep.Npregunta
		INTO #ParaCursor
		FROM heExamenPersonal ep
		JOIN heExamen e ON e.NPregunta=ep.NPregunta AND e.Curso=ep.Curso
		WHERE ep.Personal=@Personal AND e.Tipo='CERRADA' AND ep.Curso=@Curso /*AND ep.Fecha=@Fecha*/ AND ep.IDExamen=@IDExamen

		DECLARE heCalifica CURSOR
		FOR SELECT Respuesta1,Respuesta2,Respuesta3,Respuesta4,Respuesta5,NPregunta
		FROM #ParaCursor
		OPEN heCalifica

			FETCH NEXT FROM heCalifica INTO @Respuesta1,@Respuesta2,@Respuesta3,@Respuesta4,@Respuesta5,@NPregunta
			WHILE @@FETCH_STATUS=0
			BEGIN
				IF (@Respuesta1='OK' AND @Respuesta2='OK') AND (@Respuesta3='OK' AND @Respuesta4='OK') AND @Respuesta5='OK' SET @CorrectaIncorrecta='CORRECTA'
				ELSE SET @CorrectaIncorrecta='INCORRECTA'
				
				INSERT #Calificacion VALUES (@NPregunta,@CorrectaIncorrecta,@Personal,@Curso)

			FETCH NEXT FROM heCalifica INTO @Respuesta1,@Respuesta2,@Respuesta3,@Respuesta4,@Respuesta5,@NPregunta
			END
			CLOSE heCalifica
			DEALLOCATE heCalifica

			INSERT #Calificacion
			SELECT ep.NPregunta,CASE WHEN ep.R1=1 THEN 'CORRECTA' ELSE 'INCORRECTA' END,@Personal,@Curso
			FROM heExamenPersonal ep
			JOIN heExamen e ON e.NPregunta=ep.NPregunta AND e.Curso=ep.Curso
			WHERE ep.Personal=@Personal AND e.Tipo='ABIERTA' AND ep.Curso=@Curso /*AND ep.Fecha=@Fecha*/ AND ep.IDExamen=@IDExamen


			SELECT @Personal Personal,@Curso Curso,#Calificacion.NPregunta,p.ApellidoPaterno,p.ApellidoMaterno,p.Nombre,#Calificacion.CorrectaIncorrecta,
				   CASE WHEN #Calificacion.CorrectaIncorrecta='CORRECTA' THEN ISNULL(m.Ponderacion,1) ELSE 0 END Calificacion
			FROM #Calificacion
			JOIN heExamen m ON m.Curso=#Calificacion.Curso AND m.Npregunta=#Calificacion.NPregunta
			JOIN Personal p ON p.Personal=#Calificacion.Personal
			ORDER BY #Calificacion.NPregunta


			DROP TABLE #ParaCursor
			DROP TABLE #Calificacion 

END
GO
