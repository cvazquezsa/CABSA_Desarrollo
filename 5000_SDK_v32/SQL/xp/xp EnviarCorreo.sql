-- exec xpEnviarCorreoCxc

/*
Jose Heffes Antar <jheffes@intelisis.com.mx>
Pepe Heffes <jheffes@intelisis.com.mx>
JHA <jheffes@intelisis.com.mx>
*/

/*************** xpMailAuto *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpMailAuto') and type = 'P') drop procedure dbo.xpMailAuto
GO             
CREATE PROCEDURE xpMailAuto
			@Modulo		char(5), 
			@ID		int, 
			@Mov		varchar(20), 
                    	@eMail		varchar(255)	OUTPUT,
		    	@Asunto		varchar(255)	OUTPUT,
		    	@Mensaje	varchar(8000)	OUTPUT,
		    	@Anexos		varchar(8000)	OUTPUT,
		    	@SQL		varchar(8000)	OUTPUT,
		    	@SQLAncho	int		OUTPUT,
			@CancelarEnvio 	bit		OUTPUT	
AS BEGIN
  RETURN
END
GO

/*************** xpEnviarCorreo *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpEnviarCorreo') and type = 'P') drop procedure dbo.xpEnviarCorreo
GO             
CREATE PROCEDURE xpEnviarCorreo
		    @Empresa	varchar(5),
            @Para		varchar(8000) OUTPUT,
		    @Asunto		varchar(8000)  OUTPUT,
		    @Mensaje	varchar(8000) = NULL  OUTPUT,
		    @Anexos		varchar(8000) = NULL  OUTPUT,
		    @SQL		varchar(8000) = NULL OUTPUT,
		    @SQLAncho	int 	      = 250 OUTPUT,
		    @CC			varchar(8000) = NULL OUTPUT,
            @Perfil		varchar(50)	OUTPUT

AS BEGIN
  RETURN
END
GO

/*************** xpEnviarCorreoCxc *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpEnviarCorreoCxc') and type = 'P') drop procedure dbo.xpEnviarCorreoCxc
GO             
CREATE PROCEDURE xpEnviarCorreoCxc
AS BEGIN
  DECLARE
    @Empresa		varchar(5),
    @Fecha		datetime,
    @DiasPorVencer	int,
    @SQL		varchar(8000),
    @SQLBase		varchar(8000),
    @SQLAncho		int,
    @Cliente		char(10),
    @Contacto		varchar(100),
    @eMail		varchar(255),
    @Asunto		varchar(255),
    @Mensaje		varchar(8000),
    @BaseDatos          varchar(100)

  SELECT TOP 1 @BaseDatos = Table_Catalog 
    FROM Information_Schema.Tables 
   WHERE Table_Name = 'CxcInfo'


  SELECT @DiasPorVencer = 3, 
         @SQLAncho = 250,
         @Asunto = 'Pagos Vencidos',
       --@SQLBase = 'SELECT * FROM CxcInfo'
         @SQLBase = 'SELECT * FROM ' + @BaseDatos + '.dbo.CxcInfo'


  SELECT @Fecha = DATEADD(day, -@DiasPorVencer, GETDATE())
  EXEC spExtraerFecha @Fecha OUTPUT

  --EXEC master..xp_startmail
  IF @@Error = 0
  BEGIN
    CREATE TABLE #Contactos (
       Contacto	varchar(100)	COLLATE Database_Default NULL,
       eMail	varchar(255)	COLLATE Database_Default NULL)

    DECLARE crCte CURSOR FOR
     SELECT Empresa, Cliente 
       FROM CxcInfo
      WHERE Vencimiento <= @Fecha
      GROUP BY Empresa, Cliente
      ORDER BY Empresa, Cliente
    OPEN crCte
    FETCH NEXT FROM crCte INTO @Empresa, @Cliente
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@Cliente), '') IS NOT NULL
      BEGIN
        TRUNCATE TABLE #Contactos
        INSERT #Contactos (Contacto, eMail) SELECT Nombre,    eMail  FROM CteCto WHERE Cliente = @Cliente
        INSERT #Contactos (Contacto, eMail) SELECT Contacto1, eMail1 FROM Cte    WHERE Cliente = @Cliente
        INSERT #Contactos (Contacto, eMail) SELECT Contacto2, eMail2 FROM Cte    WHERE Cliente = @Cliente

        DECLARE crContactos CURSOR LOCAL FOR
         SELECT Contacto, eMail
           FROM #Contactos
          WHERE NULLIF(RTRIM(eMail), '') IS NOT NULL
          GROUP BY Contacto, eMail
          ORDER BY Contacto, eMail
        OPEN crContactos
        FETCH NEXT FROM crContactos INTO @Contacto, @eMail
        WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
          --SELECT @SQL = @SQLBase + ' WHERE Cliente="'+@Cliente+'"'
            SELECT @SQL = @SQLBase + ' WHERE Cliente = ' + CHAR(39) + RTRIM(@Cliente) + CHAR(39) + ' ORDER BY Vencimiento ' 
  	    EXEC spEnviarCorreo @Empresa, @eMail, @Asunto, @Mensaje, @SQL = @SQL, @SQLAncho = @SQLAncho
          END
          FETCH NEXT FROM crContactos INTO @Contacto, @eMail
        END
        CLOSE crContactos
        DEALLOCATE crContactos
      END
      FETCH NEXT FROM crCte INTO @Empresa, @Cliente
    END
    CLOSE crCte
    DEALLOCATE crCte

    --EXEC master..xp_stopmail
  END
  RETURN
END
GO

/*************** xpEnviarCorreoCte *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpEnviarCorreoCte') and type = 'P') drop procedure dbo.xpEnviarCorreoCte
GO             
CREATE PROCEDURE xpEnviarCorreoCte
			@ID		int,
			@Estacion	int
AS BEGIN
  DECLARE
    @Cliente		char(10),
    @Contacto		varchar(100),
    @Grupo		varchar(50),
    @eMail		varchar(255),
    @Asunto		varchar(255),
    @Mensaje		varchar(8000),
    @Anexos		varchar(255),
    @Conteo		int,
    @Clientes		int

  SELECT @Conteo = 0, @Clientes = 0
  SELECT @Asunto = Asunto,
         @Mensaje = Mensaje,
         @Anexos = Anexos,
         @Grupo = NULLIF(NULLIF(RTRIM(Grupo), ''), '(Todos)')
    FROM EnviarCorreo
   WHERE ID = @ID
 -- EXEC master..xp_startmail
  IF @@Error = 0
  BEGIN
    CREATE TABLE #Contactos (
       Contacto	varchar(100)	COLLATE Database_Default NULL,
       eMail	varchar(255)	COLLATE Database_Default NULL)

    DECLARE crListaSt CURSOR FOR
     SELECT DISTINCT Clave
       FROM ListaSt
      WHERE Estacion = @Estacion
    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @Cliente
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@Cliente), '') IS NOT NULL
      BEGIN
        SELECT @Clientes = @Clientes + 1
        TRUNCATE TABLE #Contactos
        IF @Grupo IS NULL
        BEGIN
          INSERT #Contactos (Contacto, eMail) SELECT Nombre,    eMail  FROM CteCto WHERE Cliente = @Cliente
          INSERT #Contactos (Contacto, eMail) SELECT Contacto1, eMail1 FROM Cte    WHERE Cliente = @Cliente
          INSERT #Contactos (Contacto, eMail) SELECT Contacto2, eMail2 FROM Cte    WHERE Cliente = @Cliente
        END ELSE
          INSERT #Contactos (Contacto, eMail) SELECT Nombre,    eMail  FROM CteCto WHERE Cliente = @Cliente AND Grupo = @Grupo

        DECLARE crContactos CURSOR LOCAL FOR
         SELECT Contacto, eMail
           FROM #Contactos
          WHERE NULLIF(RTRIM(eMail), '') IS NOT NULL
          GROUP BY Contacto, eMail
          ORDER BY Contacto, eMail
        OPEN crContactos
        FETCH NEXT FROM crContactos INTO @Contacto, @eMail
        WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            SELECT @Conteo = @Conteo + 1
  	    EXEC spEnviarCorreo @eMail, @Asunto, @Mensaje, @Anexos
          END

          FETCH NEXT FROM crContactos INTO @Contacto, @eMail
        END
        CLOSE crContactos
        DEALLOCATE crContactos
      END
      FETCH NEXT FROM crListaSt INTO @Cliente
    END
    CLOSE crListaSt
    DEALLOCATE crListaSt

  --  EXEC master..xp_stopmail
  END
  SELECT CONVERT(varchar, @Conteo)+' Mensajes Enviados a '+CONVERT(varchar, @Clientes)+' Clientes'
  RETURN
END
GO

/*************** xpEnviarCorreoProv *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpEnviarCorreoProv') and type = 'P') drop procedure dbo.xpEnviarCorreoProv
GO             
CREATE PROCEDURE xpEnviarCorreoProv
			@ID		int,
			@Estacion	int
AS BEGIN
  DECLARE
    @Proveedor		char(10),
    @Contacto		varchar(100),
    @eMail		varchar(255),
    @Asunto		varchar(255),
    @Mensaje		varchar(8000),
    @Anexos		varchar(255),
    @Conteo		int,
    @Proveedores	int

  SELECT @Conteo = 0, @Proveedores = 0
  SELECT @Asunto = Asunto,
         @Mensaje = Mensaje,
         @Anexos = Anexos
    FROM EnviarCorreo
   WHERE ID = @ID
 -- EXEC master..xp_startmail
  IF @@Error = 0
  BEGIN
    CREATE TABLE #Contactos (
       Contacto	varchar(100)	COLLATE Database_Default NULL,
       eMail	varchar(255)	COLLATE Database_Default NULL)

    DECLARE crListaSt CURSOR FOR
     SELECT DISTINCT Clave
       FROM ListaSt
      WHERE Estacion = @Estacion
    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @Proveedor
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@Proveedor), '') IS NOT NULL
      BEGIN
        SELECT @Proveedores = @Proveedores + 1
        TRUNCATE TABLE #Contactos
        INSERT #Contactos (Contacto, eMail) SELECT Contacto1, eMail1 FROM Prov    WHERE Proveedor = @Proveedor
        INSERT #Contactos (Contacto, eMail) SELECT Contacto2, eMail2 FROM Prov    WHERE Proveedor = @Proveedor

        DECLARE crContactos CURSOR LOCAL FOR
         SELECT Contacto, eMail
           FROM #Contactos
          WHERE NULLIF(RTRIM(eMail), '') IS NOT NULL
          GROUP BY Contacto, eMail
          ORDER BY Contacto, eMail
        OPEN crContactos
        FETCH NEXT FROM crContactos INTO @Contacto, @eMail
        WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            SELECT @Conteo = @Conteo + 1
  	    EXEC spEnviarCorreo @eMail, @Asunto, @Mensaje, @Anexos
          END

          FETCH NEXT FROM crContactos INTO @Contacto, @eMail
        END
        CLOSE crContactos
        DEALLOCATE crContactos
      END
      FETCH NEXT FROM crListaSt INTO @Proveedor
    END
    CLOSE crListaSt
    DEALLOCATE crListaSt

   -- EXEC master..xp_stopmail
  END
  SELECT CONVERT(varchar, @Conteo)+' Mensajes Enviados a '+CONVERT(varchar, @Proveedores)+' Proveedores'
  RETURN
END
GO


/*************** xpEnviarCorreoAgente *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpEnviarCorreoAgente') and type = 'P') drop procedure dbo.xpEnviarCorreoAgente
GO             
CREATE PROCEDURE xpEnviarCorreoAgente
			@ID		int,
			@Estacion	int
AS BEGIN
  DECLARE
    @Agente		char(10),
    @Contacto		varchar(100),
    @eMail		varchar(255),
    @Asunto		varchar(255),
    @Mensaje		varchar(8000),
    @Anexos		varchar(255),
    @Conteo		int,
    @Agentes	int

  SELECT @Conteo = 0, @Agentes = 0
  SELECT @Asunto = Asunto,
         @Mensaje = Mensaje,
         @Anexos = Anexos
    FROM EnviarCorreo
   WHERE ID = @ID
 -- EXEC master..xp_startmail
  IF @@Error = 0
  BEGIN
    DECLARE crListaSt CURSOR FOR
     SELECT DISTINCT Clave
       FROM ListaSt
      WHERE Estacion = @Estacion
    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @Agente
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@Agente), '') IS NOT NULL
      BEGIN
        SELECT @Agentes = @Agentes + 1
        SELECT @Contacto = Nombre, @eMail = eMail FROM Agente WHERE Agente = @Agente
        IF NULLIF(RTRIM(@eMail), '') IS NOT NULL
        BEGIN
          SELECT @Conteo = @Conteo + 1
	  EXEC spEnviarCorreo @eMail, @Asunto, @Mensaje, @Anexos
        END
      END
      FETCH NEXT FROM crListaSt INTO @Agente
    END
    CLOSE crListaSt
    DEALLOCATE crListaSt

   -- EXEC master..xp_stopmail
  END
  SELECT CONVERT(varchar, @Conteo)+' Mensajes Enviados a '+CONVERT(varchar, @Agentes)+' Agentes'
  RETURN
END
GO

/*************** xpEnviarCorreoPersonal *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpEnviarCorreoPersonal') and type = 'P') drop procedure dbo.xpEnviarCorreoPersonal
GO             
CREATE PROCEDURE xpEnviarCorreoPersonal
			@ID		int,
			@Estacion	int,
			@Empresa  varchar(10)
AS BEGIN
  DECLARE
    @Personal		char(10),
    @Contacto		varchar(100),
    @eMail		varchar(255),
    @Asunto		varchar(255),
    @Mensaje		varchar(8000),
    @Anexos		varchar(255),
    @Conteo		int,
    @Personals	int

  SELECT @Conteo = 0, @Personals = 0
  SELECT @Asunto = Asunto,
         @Mensaje = Mensaje,
         @Anexos = Anexos
    FROM EnviarCorreo
   WHERE ID = @ID
 -- EXEC master..xp_startmail
  IF @@Error = 0
  BEGIN
    DECLARE crListaSt CURSOR FOR
     SELECT DISTINCT Clave
       FROM ListaSt
      WHERE Estacion = @Estacion
    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @Personal
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@Personal), '') IS NOT NULL
      BEGIN
        SELECT @Personals = @Personals + 1
        SELECT @Contacto = Nombre, @eMail = eMail FROM Personal WHERE Personal = @Personal
        IF NULLIF(RTRIM(@eMail), '') IS NOT NULL
        BEGIN
          SELECT @Conteo = @Conteo + 1
	  EXEC spEnviarCorreo @Empresa,@eMail, @Asunto, @Mensaje, @Anexos
        END
      END
      FETCH NEXT FROM crListaSt INTO @Personal
    END
    CLOSE crListaSt
    DEALLOCATE crListaSt

   -- EXEC master..xp_stopmail
  END
  SELECT CONVERT(varchar, @Conteo)+' Mensajes Enviados a '+CONVERT(varchar, @Personals)+' Personals'
  RETURN
END
GO
/*************** xpEnviarCorreoUsuario *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpEnviarCorreoUsuario') and type = 'P') drop procedure dbo.xpEnviarCorreoUsuario
GO             
CREATE PROCEDURE xpEnviarCorreoUsuario
			@ID		int,
			@Estacion	int
AS BEGIN
  DECLARE
    @Usuario		char(10),
    @Contacto		varchar(100),
    @eMail		varchar(255),
    @Asunto		varchar(255),
    @Mensaje		varchar(8000),
    @Anexos		varchar(255),
    @Conteo		int,
    @Usuarios	int

  SELECT @Conteo = 0, @Usuarios = 0
  SELECT @Asunto = Asunto,
         @Mensaje = Mensaje,
         @Anexos = Anexos
    FROM EnviarCorreo
   WHERE ID = @ID
 -- EXEC master..xp_startmail
  IF @@Error = 0
  BEGIN
    DECLARE crListaSt CURSOR FOR
     SELECT DISTINCT Clave
       FROM ListaSt
      WHERE Estacion = @Estacion
    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @Usuario
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@Usuario), '') IS NOT NULL
      BEGIN
        SELECT @Usuarios = @Usuarios + 1
        SELECT @Contacto = Nombre, @eMail = eMail FROM Usuario WHERE Usuario = @Usuario
        IF NULLIF(RTRIM(@eMail), '') IS NOT NULL
        BEGIN
          SELECT @Conteo = @Conteo + 1
	  EXEC spEnviarCorreo @eMail, @Asunto, @Mensaje, @Anexos
        END
      END
      FETCH NEXT FROM crListaSt INTO @Usuario
    END
    CLOSE crListaSt
    DEALLOCATE crListaSt

  --  EXEC master..xp_stopmail
  END
  SELECT CONVERT(varchar, @Conteo)+' Mensajes Enviados a '+CONVERT(varchar, @Usuarios)+' Usuarios'
  RETURN
END
GO

-- select  * from ListaSt WHERE Estacion = 101
-- select  * from LanzarProyecto
-- xpLanzarProyectoLista 13, 101, '(Todos)'
/*************** xpLanzarProyectoLista *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpLanzarProyectoLista') and type = 'P') drop procedure dbo.xpLanzarProyectoLista
GO             
CREATE PROCEDURE xpLanzarProyectoLista
			@ID		int,
			@Estacion	int,
			@Grupo		varchar(50)
AS BEGIN
  DECLARE
    @Cliente		char(10),
    @Contacto		varchar(100),
    @eMail		varchar(255)

  SELECT @Grupo = NULLIF(NULLIF(NULLIF(RTRIM(@Grupo), ''), '0'), '(Todos)')
  CREATE TABLE #Contactos (
     Contacto	varchar(100)	COLLATE Database_Default NULL,
     eMail	varchar(255)	COLLATE Database_Default NULL)

  DECLARE crListaSt CURSOR FOR
   SELECT DISTINCT Clave
     FROM ListaSt
    WHERE Estacion = @Estacion
  OPEN crListaSt
  FETCH NEXT FROM crListaSt INTO @Cliente
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@Cliente), '') IS NOT NULL
    BEGIN
      IF @Grupo IS NULL
      BEGIN
        INSERT #Contactos (Contacto, eMail) SELECT Nombre,    eMail  FROM CteCto WHERE Cliente = @Cliente
        INSERT #Contactos (Contacto, eMail) SELECT Contacto1, eMail1 FROM Cte    WHERE Cliente = @Cliente
        INSERT #Contactos (Contacto, eMail) SELECT Contacto2, eMail2 FROM Cte    WHERE Cliente = @Cliente
      END 
        INSERT #Contactos (Contacto, eMail) SELECT Nombre,    eMail  FROM CteCto WHERE Cliente = @Cliente AND Grupo = @Grupo
    END
    FETCH NEXT FROM crListaSt INTO @Cliente
  END
  CLOSE crListaSt
  DEALLOCATE crListaSt
  DELETE #Contactos WHERE NULLIF(RTRIM(eMail), '') IS NULL
  SELECT 'Lista' = CONVERT(varchar(255), LTRIM(ISNULL(RTRIM(Contacto), '')+' <'+RTRIM(eMail)+'>')) FROM #Contactos
  RETURN
END
GO


/*************** xpLanzarProyecto *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpLanzarProyecto') and type = 'P') drop procedure dbo.xpLanzarProyecto
GO             
CREATE PROCEDURE xpLanzarProyecto
			@ID		int,
			@Estacion	int,
			@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
    			@Fecha		datetime,
    			@Mov		varchar(20),
    			@Proyecto	varchar(50),
			@UEN		int,
    			@Asunto		varchar(255)
AS BEGIN
  DECLARE
    @Cliente		char(10),
    @SoporteID		int,
    @Ok			int,
    @OkRef		varchar(255),
    @Conteo		int

  SELECT @Conteo = 0, @Ok = NULL, @OkRef = NULL  

  SELECT @Mov = NULLIF(NULLIF(RTRIM(@Mov), '0'), ''),
         @Proyecto = NULLIF(NULLIF(RTRIM(@Proyecto), '0'), ''),
         @Asunto = NULLIF(NULLIF(RTRIM(@Asunto), '0'), '')
  BEGIN TRANSACTION

  DECLARE crListaSt CURSOR FOR
   SELECT DISTINCT Clave
     FROM ListaSt
    WHERE Estacion = @Estacion
  OPEN crListaSt
  FETCH NEXT FROM crListaSt INTO @Cliente
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@Cliente), '') IS NOT NULL 
    BEGIN
      INSERT Soporte (
              Empresa,  Sucursal,  Mov,  FechaEmision, Proyecto,  UEN,  Usuario,  UsuarioResponsable, Estatus,      Cliente,  Titulo)
      VALUES (@Empresa, @Sucursal, @Mov, @Fecha,       @Proyecto, @UEN, @Usuario, @Usuario,           'SINAFECTAR', @Cliente, @Asunto)
      SELECT @SoporteID = SCOPE_IDENTITY()
      EXEC spAfectar 'ST', @SoporteID, @Usuario = @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
      SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crListaSt INTO @Cliente
  END
  CLOSE crListaSt
  DEALLOCATE crListaSt

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Se Generaron '+LTRIM(CONVERT(char, @Conteo))+ ' Movimientos ('+@Mov+')'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  END

  RETURN
END
GO

