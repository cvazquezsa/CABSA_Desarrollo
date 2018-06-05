
/*************** spOutlookNombre *******************/
if exists (select * from sysobjects where id = object_id('dbo.spOutlookNombre') and type = 'P') drop procedure dbo.spOutlookNombre
GO             
CREATE PROCEDURE spOutlookNombre
			@Nombre		varchar(100),
			@Estatus	varchar(15) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Estatus = NULL
  SELECT @Estatus = Estatus FROM OutlookNombre WHERE Nombre = @Nombre
  IF @@ROWCOUNT = 0
  BEGIN
    SELECT @Estatus = 'NUEVO'
    INSERT OutlookNombre (Nombre, Estatus) VALUES (@Nombre, @Estatus)
  END
  RETURN
END
GO

/*************** spOutlookNombreActualizar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spOutlookNombreActualizar') and type = 'P') drop procedure dbo.spOutlookNombreActualizar
GO             
CREATE PROCEDURE spOutlookNombreActualizar
--//WITH ENCRYPTION
AS BEGIN
  INSERT OutlookNombre (Nombre, Estatus)
  SELECT De, 'NUEVO' 
    FROM Outlook
   WHERE De NOT IN (SELECT Nombre FROM OutlookNombre)
  INSERT OutlookNombre (Nombre, Estatus)
  SELECT Para, 'NUEVO'
    FROM OutlookPara
   WHERE Para NOT IN (SELECT Nombre FROM OutlookNombre)
  RETURN
END
GO

/*************** spOutlook *******************/
if exists (select * from sysobjects where id = object_id('dbo.spOutlook') and type = 'P') drop procedure dbo.spOutlook
GO             
CREATE PROCEDURE spOutlook
			@De					varchar(100),
			@Fecha				datetime,
			@Asunto				varchar(255),
			@Mensaje			text,
			@Anexos				varchar(255),
			@OutlookID			varchar(150) 	= NULL,
			@Recibido			bit		= 0,
			@Tipo				varchar(20)	= 'Correo',
			@FechaD				datetime	= NULL,
			@FechaA				datetime	= NULL,
			@DiaCompleto		bit		= 0,
			@Vencimiento		datetime	= NULL,
			@Ubicacion			varchar(255) 	= NULL,
			@Estado				varchar(100) 	= NULL,
			@Completado			float 		= NULL,
			@Prioridad			varchar(20)	= NULL,
			@Eliminar			bit 		= 0,
			@Referencia			varchar(20)	= NULL,
			@Modulo				char(5)	= NULL,
			@ModuloID			int	= NULL,
			@UsuarioAsignado	char(10) = NULL,
			@EnSilencio			bit = 0,
			@ID					int	= NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Estatus				varchar(15),
    @OutlookEstatusNuevo	bit

  SELECT @ID = NULL, @De = NULLIF(RTRIM(@De), '')
  IF @Tipo <> 'Cita'
	BEGIN
	  IF @OutlookID IS NOT NULL
    	SELECT @ID = MIN(ID) FROM Outlook WHERE OutlookID = @OutlookID
	END
  ELSE
	BEGIN
	  IF @Referencia IS NOT NULL
    	SELECT @ID = MIN(ID) FROM Outlook WHERE Referencia = @Referencia
	END

  IF @Eliminar = 1
	BEGIN
		IF @ID IS NULL AND @Tipo <> 'Tarea'
	      SELECT @ID = MIN(ID)
    	    FROM Outlook
	       WHERE De = @De AND Fecha = @Fecha AND Anexos = @Anexos AND Asunto = @Asunto AND Tipo = @Tipo AND FechaD = @FechaD AND FechaA = @FechaA
		ELSE
			IF @ID IS NULL AND @Tipo = 'Tarea'
		      SELECT @ID = MIN(ID)
    		    FROM Outlook
			   WHERE Recibido = @Recibido and Modulo = @Modulo and ModuloID = @ModuloID
			DELETE Outlook WHERE Modulo = @Modulo and ModuloID = @ModuloID	--WHERE ID = @ID
	END
  ELSE
	BEGIN
    	IF @ID IS NULL
		    BEGIN
		      SELECT @OutlookEstatusNuevo = OutlookEstatusNuevo FROM Version
		      EXEC spOutlookNombre @De, @Estatus OUTPUT
		      IF (@Estatus = 'NUEVO' AND @OutlookEstatusNuevo = 1) OR (@Estatus = 'ALTA')
			      BEGIN
				    SELECT @UsuarioAsignado = MIN(Usuario) FROM OutlookNombre WHERE Nombre = @De AND Estatus = 'ALTA'
					IF @Tipo= 'Cita'
						SELECT @Referencia = replace(replace(substring(convert(varchar(30),getdate(),121), 12, 12),':',''),'.','')
			        INSERT Outlook (De,  Fecha,  Asunto,  Mensaje,  Anexos,  OutlookID,  Recibido,  Tipo,  FechaD,  FechaA,  DiaCompleto,  Vencimiento,  Ubicacion,  Estado,  Completado,  Prioridad,  Referencia,  Modulo,  ModuloID, UsuarioAsignado)
					VALUES (@De, @Fecha, @Asunto, @Mensaje, @Anexos, @OutlookID, @Recibido, @Tipo, @FechaD, @FechaA, @DiaCompleto, @Vencimiento, @Ubicacion, @Estado, @Completado, @Prioridad, @Referencia, @Modulo, @ModuloID, @UsuarioAsignado)
			        SELECT @ID = SCOPE_IDENTITY()
			      END
		    END
		ELSE
			IF UPPER(@Tipo) <> 'CORREO'
		      BEGIN
		        DELETE OutlookPara WHERE ID = @ID
		        UPDATE Outlook
				SET De = @De, Fecha = @Fecha, Asunto = @Asunto, Mensaje = @Mensaje, Anexos = @Anexos, FechaD = @FechaD, FechaA = @FechaA, DiaCompleto = @DiaCompleto, Vencimiento = @Vencimiento, Ubicacion = @Ubicacion, 
		            Estado = @Estado, Completado = @Completado, Prioridad = @Prioridad, Referencia = @Referencia, Modulo = @Modulo, ModuloID = @ModuloID, UsuarioAsignado = ISNULL(@UsuarioAsignado, UsuarioAsignado)
        		WHERE ID = @ID
		      END
	END
	IF @EnSilencio = 0
    	SELECT 'ID' = ISNULL(@ID, 0)
	RETURN 
END
GO
/*************** spOutlookParaEliminar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spOutlookParaEliminar') and type = 'P') drop procedure dbo.spOutlookParaEliminar
GO             
CREATE PROCEDURE spOutlookParaEliminar
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DELETE OutlookPara WHERE ID = @ID
  RETURN 
END
GO

/*************** spOutlookProcesarEliminar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spOutlookProcesarEliminar') and type = 'P') drop procedure dbo.spOutlookProcesarEliminar
GO             
CREATE PROCEDURE spOutlookProcesarEliminar
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DELETE OutlookProcesar     WHERE ID = @ID
  DELETE OutlookProcesarPara WHERE ID = @ID
  RETURN 
END
GO


/*************** spOutlookPara *******************/
if exists (select * from sysobjects where id = object_id('dbo.spOutlookPara') and type = 'P') drop procedure dbo.spOutlookPara
GO             
CREATE PROCEDURE spOutlookPara
			@ID		int,
			@Para		varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Estatus			varchar(15),
    @OutlookEstatusNuevo	bit

  SELECT @Para = NULLIF(RTRIM(@Para), ''), @ID = NULLIF(@ID, 0)
  IF @ID IS NOT NULL AND @Para IS NOT NULL
    IF NOT EXISTS(SELECT * FROM OutlookPara WHERE ID = @ID AND Para = @Para)
    BEGIN
      SELECT @OutlookEstatusNuevo = OutlookEstatusNuevo FROM Version
      EXEC spOutlookNombre @Para, @Estatus OUTPUT
      IF (@Estatus = 'NUEVO' AND @OutlookEstatusNuevo = 1) OR (@Estatus = 'ALTA')
        INSERT OutlookPara (ID, Para) VALUES (@ID, @Para)
    END
  RETURN
END
GO




/*************** spAgendaModificar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spAgendaModificar') and type = 'P') 
drop procedure dbo.spAgendaModificar
GO             
CREATE PROCEDURE spAgendaModificar
	@Id					int,
	@Asunto				varchar(255),
	@Mensaje			text,
	@FechaD				datetime	= NULL,
	@FechaA				datetime	= NULL,
	@Ubicacion			varchar(255) 	= NULL,
	@Estado				varchar(100) 	= NULL,
	@DiaCompleto		bit		= 0,
	@ColorEtiqueta		int

--//WITH ENCRYPTION
AS 
BEGIN
	BEGIN TRANSACTION
	UPDATE Outlook
	SET	Asunto = @Asunto,
		Mensaje = @Mensaje,
		FechaD	= @FechaD,
		FechaA = @FechaA,
		Ubicacion = @Ubicacion,
		Estado = @Estado,
		DiaCompleto = @DiaCompleto,
		ColorEtiqueta = @ColorEtiqueta 
	WHERE ID = @Id

	INSERT OutlookProcesar (Tipo,  De, Fecha, Asunto, Ubicacion, Mensaje, FechaD, FechaA, Vencimiento, DiaCompleto, Recibido, Estado, Accion, Referencia)
	SELECT                 'Cita', De, Fecha, Asunto, Ubicacion, Mensaje, FechaD, FechaA, Vencimiento, DiaCompleto, Recibido, Estado, 'Modificar', Referencia
	FROM Outlook
	WHERE ID = @Id	

	IF @@ERROR = 0 and @@ROWCOUNT > 0
	  BEGIN
		COMMIT TRANSACTION
		SELECT 1
	  END
	ELSE
	  BEGIN
		ROLLBACK TRANSACTION		
		SELECT -1
	  END
END
GO

--spAgendaModificar 2500, 'Lectorito Viana', 'Que onda', '2006-03-01', '2006-03-01', 'uno', Null, 0, 1


/************** spOutlookListaUsuarios *************/
if exists (select * from sysobjects where id = object_id('dbo.spAgendaListaUsuarios') and type = 'P') 
drop procedure dbo.spAgendaListaUsuarios
GO
CREATE PROCEDURE spAgendaListaUsuarios
			@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10)
--//WITH ENCRYPTION
AS 
BEGIN
	SELECT Nombre
	FROM OutlookNombre 
	WHERE ESTATUS = 'ALTA' and ( (ISNULL(Usuario, '') <> '') OR (ISNULL(Personal, '') <> '') )
	RETURN 
END
GO


-- spOutlookListaUsuarios '',1,''
/*************** spOutlook *******************/
if exists (select * from sysobjects where id = object_id('dbo.spAgendaAgregar') and type = 'P') 
drop procedure dbo.spAgendaAgregar
GO             
CREATE PROCEDURE spAgendaAgregar
	@De				varchar(100),
	@Fecha			datetime		= NULL,
	@Asunto			varchar(255)	= NULL,
	@Ubicacion		varchar(255) 	= NULL,
	@Mensaje		text			= NULL,
	@FechaD			datetime		= NULL,
	@FechaA			datetime		= NULL,
	@Vencimiento	datetime		= NULL,
	@DiaCompleto	bit				= 0,
	@Estado			varchar(100)	= NULL,
	@ColorEtiqueta	int				= NULL,
	@EnSilencio		bit 			= 0,
	@ID				int				= NULL OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Referencia	varchar(50)
  BEGIN TRANSACTION
	  SELECT @Referencia = replace(replace(substring(convert(varchar(30),getdate(),121), 12, 12),':',''),'.','')
	  INSERT OutlookProcesar (Tipo,   De,   Fecha,   Asunto, Ubicacion, Mensaje, FechaD, FechaA, Vencimiento, DiaCompleto, Recibido, Estado, Accion, Referencia)
	  VALUES         ('Cita', @De, @Fecha, @Asunto, @Ubicacion, @Mensaje, @FechaD, @FechaA, @Vencimiento, @DiaCompleto, 0, @Estado,  'Agregar', @Referencia)

	  INSERT Outlook (Tipo, De,  Fecha,  Asunto, Ubicacion,  Mensaje,  FechaD,    FechaA,  Vencimiento, DiaCompleto,   Recibido, Estado, ColorEtiqueta, Referencia)
	  VALUES         ('Cita', @De, @Fecha, @Asunto, @Ubicacion, @Mensaje, @FechaD, @FechaA, @Vencimiento , @DiaCompleto, 0, @Estado, @ColorEtiqueta, @Referencia)
	  
	  IF @@ERROR = 0 and @@ROWCOUNT > 0
		BEGIN		
		  SELECT @ID = SCOPE_IDENTITY()
		  COMMIT TRANSACTION
		  IF @EnSilencio = 0
		   	SELECT 'ID' = ISNULL(@ID, 0)
		END
	  ELSE
		BEGIN
			ROLLBACK TRANSACTION
	        IF @EnSilencio = 0
		   	  SELECT 'ID' = -1
		END
END
GO

--spAgendaAgregar 'seis', '2006-03-02', 'asuntoII', 'Ubi'
/************** spOutlookEliminar *************/
if exists (select * from sysobjects where id = object_id('dbo.spAgendaEliminar') and type = 'P')
  drop procedure dbo.spAgendaEliminar
GO
CREATE PROCEDURE spAgendaEliminar
                    @ID               int
--//WITH ENCRYPTION
AS BEGIN
  BEGIN TRANSACTION
	INSERT OutlookProcesar (Tipo,  De, Fecha, Asunto, Ubicacion, Mensaje, FechaD, FechaA, Vencimiento, DiaCompleto, Recibido, Estado, Accion, Referencia)
	SELECT                 'Cita', De, Fecha, Asunto, Ubicacion, Mensaje, FechaD, FechaA, Vencimiento, DiaCompleto, Recibido, Estado, 'Eliminar', Referencia
	FROM Outlook
	WHERE ID = @Id	
  	DELETE Outlook WHERE ID = @ID

	IF @@ERROR = 0 and @@ROWCOUNT > 0
		COMMIT TRANSACTION
	ELSE
		ROLLBACK TRANSACTION		
	RETURN
END
GO
