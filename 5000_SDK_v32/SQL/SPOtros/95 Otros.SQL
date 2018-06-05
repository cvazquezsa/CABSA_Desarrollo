/* SP OTROS    */


-- spTextoEnArchivo '<html>hola</html>', 'c:\1.txt'
/*
sp_configure 'Ole Automation Procedures',1
 reconfigure
*/

if exists (select * from sysobjects where id=object_id('dbo.spTextoEnArchivo') and type='P') drop procedure dbo.spTextoEnArchivo
go
CREATE PROCEDURE spTextoEnArchivo
(
      @Texto   Text,
      @Archivo varchar(255)
)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE   @objFileSystem int,
            @objTextStream int,
	        @objErrorObject int,
	        @Handler int,
			@Mensaje varchar(255)
            

  EXECUTE @Handler = sp_OACreate  'Scripting.FileSystemObject' , @objFileSystem OUT


  IF @Handler=0 
    BEGIN
      EXECUTE @Handler = sp_OAMethod   @objFileSystem  , 'CreateTextFile', @objTextStream OUT, @Archivo, true
      IF @Handler=0
          EXECUTE @Handler = sp_OAMethod  @objTextStream, 'WriteLine', null,@Texto
      IF @Handler=0 
          EXECUTE @Handler = sp_OAMethod  @objTextStream, 'Close'
    END
    EXECUTE  sp_OADestroy @objTextStream
  RETURN @Handler
END
go

/* 
DECLARE @ReturnEstatus int
EXEC @ReturnEstatus = spTextoEnArchivo 'Hola','c:\hola.txt'
SELECT @ReturnEstatus
*/


/*

USE master
EXEC xp_startmail
use matriz
*/
-- spEnviarCorreo 'DEMO', 'joseheffes@yahoo.com', 'Hola Norberto', 'Hola Norberto'
-- spEnviarCorreo 'DEMO', 'jheffes@intelisis.com.mx', 'Hola', 'Hola', @SQL = 'SELECT Cliente, Nombre, Telefonos FROM Matriz.dbo.Cte', @SQLAncho = 1000
/*

DECLARE @status int, @msg_id varchar(255)
EXEC @status = master..xp_findnextmsg @msg_id = @msg_id OUTPUT
SELECT @status, @msg_id

*/

/*

DECLARE 
  @status 	int, 
  @msg_id 	varchar(255),
  @subject	varchar(8000),
  @message	varchar(8000),
  @skip_bytes	int,
  @msg_length	int


EXEC @status = master..xp_findnextmsg @msg_id = @msg_id OUTPUT
if @status = 0
  EXEC @status = master..xp_readmail 
       @msg_id = @msg_id,
       @subject = @subject OUTPUT,  
       @message = @message OUTPUT,      
       @skip_bytes = @skip_bytes OUTPUT,
       @msg_length = @msg_length OUTPUT
SELECT 'ID' = @msg_id, 'Asunto' = @subject, 'Mensaje' = @message


*/

-- spEnviarDBMail 'Elias'
/*************** spEnviarDBMail *******************/
if exists (select * from sysobjects where id = object_id('dbo.spEnviarDBMail') and type = 'P') drop procedure dbo.spEnviarDBMail
GO             
CREATE PROCEDURE spEnviarDBMail
                    @Perfil		varchar(50),
		    @Para		varchar(8000) = NULL,
                    @CC			varchar(8000) = NULL,
                    @CCO		varchar(8000) = NULL,
		    @Asunto		varchar(8000) = NULL,
		    @Mensaje		text 	      = NULL,
		    @Formato		varchar(50)   = 'HTML',
		    @Importancia	varchar(20)   = 'Normal',
		    @Sensitividad	varchar(20)   = 'Normal',
		    -- 11326
		    @Adjuntos		varchar(max) = NULL,
		    @SQL		varchar(8000) = NULL,
		    @SQLBase		varchar(50)   = NULL,
		    @SQLAnexar		bit	      = 0,
		    @SQLAnexarNombre	varchar(255)  = NULL,
                    @SQLConEncabezados	bit	      = 1,
		    @SQLAncho		int 	      = NULL,
		    @SQLSeparador	char(1)	      = ' '

--//WITH ENCRYPTION
AS BEGIN
  IF ((SELECT dbo.fnSQL2005()) = 1) OR ((SELECT dbo.fnSQL2008()) = 1) OR ((SELECT dbo.fnSQL2012()) = 1) 
    EXEC msdb.dbo.sp_send_dbmail 
           @profile_name = @Perfil,
           @recipients = @Para,
           @copy_recipients = @CC,
           @blind_copy_recipients = @CCO,
           @subject = @Asunto,
           @body = @Mensaje,
           @body_format = @Formato,
           @importance = @Importancia,
           @sensitivity = @Sensitividad,
           @file_attachments = @Adjuntos,
           @query = @SQL,
           @execute_query_database = @SQLBase,
           @attach_query_result_as_file = @SQLAnexar,
           @query_attachment_filename = @SQLAnexarNombre,
           @query_result_header = @SQLConEncabezados,
           @query_result_width = @SQLAncho,
           @query_result_separator = @SQLSeparador
END
GO

/*************** spEnviarCorreo *******************/
if exists (select * from sysobjects where id = object_id('dbo.spEnviarCorreo') and type = 'P') drop procedure dbo.spEnviarCorreo
GO             
CREATE PROCEDURE spEnviarCorreo
		    @Empresa	varchar(5),
                    @Para	varchar(8000),
		    @Asunto	varchar(8000),
		    @Mensaje	varchar(8000) = NULL,
		    @Anexos	varchar(8000) = NULL,
		    @SQL	varchar(8000) = NULL,
		    @SQLAncho	int 	      = 250,
		    @CC		varchar(8000) = NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Perfil		varchar(50),
    @ID			int,
    @Fecha		datetime,
    @NombreCorreoEnLote	varchar(100)

  SELECT @Perfil = DBMailPerfil FROM EmpresaGral WHERE Empresa = @Empresa

--  EXEC master..xp_startmail
  SELECT @Para    = NULLIF(RTRIM(@Para), ''), 
         @Mensaje = NULLIF(RTRIM(@Mensaje), ''), 
         @Asunto  = NULLIF(RTRIM(@Asunto), ''),
         @Anexos  = NULLIF(RTRIM(@Anexos), ''),
         @SQL     = NULLIF(RTRIM(@SQL), ''),
         @Fecha   = GETDATE()

  IF SUBSTRING(@Anexos,LEN(@Anexos),1) = ';' SELECT @Anexos = STUFF(@Anexos,LEN(@Anexos),1,'')

  IF @Para IS NOT NULL 
  BEGIN
    IF @SQL IS NOT NULL
      EXEC spEnviarDBMail @Perfil, @Para, @CC = @CC, @Asunto = @Asunto, @Mensaje = @Mensaje, @Formato = 'HTML', @Adjuntos = @Anexos, @SQL = @SQL, @SQLAncho = @SQLAncho
--    EXEC master..xp_sendmail @recipients = @Para, @copy_recipients = @CC, @message = @Mensaje, @subject = @Asunto, @attachments = @Anexos, @query = @SQL, @Width = @SQLAncho/*, @attach_results = 'TRUE' */
    ELSE
      EXEC spEnviarDBMail @Perfil, @Para, @CC = @CC, @Asunto = @Asunto, @Mensaje = @Mensaje, @Formato = 'HTML', @Adjuntos = @Anexos
--    EXEC master..xp_sendmail @recipients = @Para, @copy_recipients = @CC, @message = @Mensaje, @subject = @Asunto, @attachments = @Anexos

    SELECT @NombreCorreoEnLote = NombreCorreoEnLote FROM Version
    EXEC spOutlook @NombreCorreoEnLote, @Fecha, @Asunto, @Mensaje, @Anexos, @EnSilencio = 1, @ID = @ID OUTPUT
    EXEC spOutlookPara @ID, @Para
  END
END
GO


-- spBandejaEntrada 101
/*************** spBandejaEntrada *******************/
if exists (select * from sysobjects where id = object_id('dbo.spBandejaEntrada') and type = 'P') drop procedure dbo.spBandejaEntrada
GO             
CREATE PROCEDURE spBandejaEntrada
			@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @ID 	varchar(255),
    @Asunto	varchar(255),
    @Origen	varchar(255),
    @Destino	varchar(255),
    @Fecha 	varchar(255),
    @Mensaje	varchar(8000),
    @salir	    bit,
	@Version    bit

  SELECT @Version = dbo.fnSQL2012()
  IF ISNULL(@Version,0) = 0
  BEGIN
   --EXEC master..xp_startmail
   DELETE BandejaEntrada WHERE Estacion = @Estacion
   SELECT @salir = 0
   WHILE @salir = 0
   BEGIN
     EXEC master..xp_findnextmsg @msg_id = @ID OUTPUT
     IF @ID IS NULL 
       SELECT @salir = 1
     ELSE BEGIN
       EXEC master..xp_readmail @ID, @subject = @Asunto OUTPUT, @message = @Mensaje OUTPUT, @originator = @Origen OUTPUT, @recipients = @Destino OUTPUT, @date_received = @Fecha OUTPUT
       INSERT BandejaEntrada (Estacion, Origen, Destino, Fecha, Asunto, Mensaje) VALUES (@Estacion, @Origen, @Destino, @Fecha, @Asunto, @Mensaje)
     END
   END
   EXEC master..xp_stopmail
  END
END
GO

-- SELECT be.Asunto FROM BandejaEntrada be, ListaID l WHERE l.Estacion = 101 AND be.Estacion = 101 AND be.ID = l.ID
-- spBandejaEntradaAceptar 101, 0, 'CXC',  0, 'MEX'
/*************** spBandejaEntradaAceptar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spBandejaEntradaAceptar') and type = 'P') drop procedure dbo.spBandejaEntradaAceptar
GO             
CREATE PROCEDURE spBandejaEntradaAceptar
			@Estacion	int,
			@Sucursal	int,
			@Rama		char(5),
			@ID		int,
			@Cuenta		char(20)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @ID = NULLIF(@ID, 0), @Cuenta = NULLIF(RTRIM(NULLIF(@Cuenta, '0')), '')
  IF @ID IS NOT NULL AND @Cuenta IS NOT NULL
  BEGIN
    DELETE AnexoMovD WHERE Sucursal = @Sucursal AND Rama = @Rama AND ID = @ID AND Cuenta = @Cuenta AND Fecha IN (SELECT be.Fecha FROM BandejaEntrada be, ListaID l WHERE l.Estacion = @Estacion AND be.Estacion = @Estacion AND be.ID = l.ID)
    INSERT AnexoMovD (Sucursal, Rama, ID, Cuenta, Nombre, Tipo, Icono, Orden, Comentario, Origen, Destino, Fecha)
    SELECT @Sucursal, @Rama, @ID, @Cuenta, be.Asunto, 'Mensaje', 60, be.ID, be.Mensaje, be.Origen, be.Destino, be.Fecha FROM BandejaEntrada be, ListaID l WHERE l.Estacion = @Estacion AND be.Estacion = @Estacion AND be.ID = l.ID
  END ELSE
  IF @ID IS NOT NULL AND @Cuenta IS NULL
  BEGIN
    DELETE AnexoMov WHERE Sucursal = @Sucursal AND Rama = @Rama AND ID = @ID AND Fecha IN (SELECT be.Fecha FROM BandejaEntrada be, ListaID l WHERE l.Estacion = @Estacion AND be.Estacion = @Estacion AND be.ID = l.ID)
    INSERT AnexoMov (Sucursal, Rama, ID, Nombre, Tipo, Icono, Orden, Comentario, Origen, Destino, Fecha)
    SELECT @Sucursal, @Rama, @ID, be.Asunto, 'Mensaje', 60, be.ID, be.Mensaje, be.Origen, be.Destino, be.Fecha FROM BandejaEntrada be, ListaID l WHERE l.Estacion = @Estacion AND be.Estacion = @Estacion AND be.ID = l.ID
  END ELSE
  IF @ID IS NULL AND @Cuenta IS NOT NULL
  BEGIN
    DELETE AnexoCta WHERE Rama = @Rama AND Cuenta = @Cuenta AND Fecha IN (SELECT be.Fecha FROM BandejaEntrada be, ListaID l WHERE l.Estacion = @Estacion AND be.Estacion = @Estacion AND be.ID = l.ID)
    INSERT AnexoCta (Rama, Cuenta, Nombre, Tipo, Icono, Orden, Comentario, Origen, Destino, Fecha)
    SELECT @Rama, @Cuenta, be.Asunto, 'Mensaje', 60, be.ID, be.Mensaje, be.Origen, be.Destino, be.Fecha FROM BandejaEntrada be, ListaID l WHERE l.Estacion = @Estacion AND be.Estacion = @Estacion AND be.ID = l.ID
  END
END
GO

/*************** spMailAuto *******************/
if exists (select * from sysobjects where id = object_id('dbo.spMailAuto') and type = 'P') drop procedure dbo.spMailAuto
GO             
CREATE PROCEDURE spMailAuto
			@Modulo	char(5),
			@ID	int,
			@Mov	char(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MovID		varchar(20),
    @FechaEmision	datetime,
    @FechaEmisionSt	varchar(20),
    @AhoraSt		varchar(50),
    @Estatus		char(15),
    @Sucursal		int,
    @SucursalNombre	varchar(100),
    @UEN		int,
    @UENNombre		varchar(100),
    @Empresa		char(5),
    @EmpresaNombre	varchar(100),
    @Usuario		char(10),
    @UsuarioNombre	varchar(100),
    @CtoTipo		varchar(20),
    @Contacto		char(10),
    @EnviarA		int,
    @Situacion		varchar(50),
    @SituacionFecha	datetime,
    @SituacionFechaSt	datetime,
    @SituacionUsuario	varchar(10),
    @SituacionNota	varchar(100),
    @Proyecto		varchar(50),
    @Concepto		varchar(50),
    @Referencia		varchar(50),
    @Asunto		varchar(255),
    @Mensaje		varchar(8000),
    @MensajePrevio	varchar(8000),
    @eMailAuto1		bit, 
    @eMailAuto2		bit, 
    @Nombre1		varchar(100),
    @Nombre2		varchar(100),
    @Contacto1		varchar(100),
    @Contacto2		varchar(100),
    @Contacto3		varchar(100),
    @Contacto4		varchar(100),
    @eMail1		varchar(100),
    @eMail2		varchar(100),
    @eMail3		varchar(100),
    @eMail4		varchar(100),
    @eMailEnviado	bit,
    @CancelarEnvio	bit,
    @Anexos		varchar(8000),
    @SQL		varchar(8000),
    @SQLAncho		int


  SELECT @eMailEnviado = 0, @CancelarEnvio = 0, @Anexos = NULL, @SQL = NULL, @SQLAncho = 250
  IF (SELECT eMailAuto FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov) = 1
  BEGIN
    EXEC spMovInfo @ID, @Modulo, @Mov OUTPUT, @MovID OUTPUT, @Estatus OUTPUT, @Sucursal OUTPUT, @UEN OUTPUT, 
                   @FechaEmision OUTPUT, @Empresa OUTPUT, @CtoTipo OUTPUT, @Contacto OUTPUT, @EnviarA OUTPUT, @Situacion OUTPUT, @SituacionFecha OUTPUT, @Proyecto OUTPUT, @Concepto OUTPUT, @Referencia OUTPUT, @Usuario OUTPUT
    /*SELECT @Mov = Mov, @MovID = MovID, @Estatus = Estatus, @Sucursal = Sucursal, @UEN = UEN,
           @FechaEmision = FechaEmision, @Empresa = Empresa, @CtoTipo = CtoTipo, @Contacto = Contacto, @EnviarA = EnviarA, @Situacion = Situacion, @SituacionFecha = SituacionFecha, @SituacionUsuario = SituacionUsuario, @SituacionNota = SituacionNota, @Proyecto = Proyecto, @Concepto = Concepto, @Referencia = Referencia, @Usuario = Usuario
      FROM dbo.fnMovReg(@Modulo, @ID)*/

    SELECT @eMailAuto1 = 0, @eMailAuto2 = 0
    IF @CtoTipo = 'Cliente'
    BEGIN
      SELECT @eMailAuto1 = ISNULL(eMailAuto, 0), @Nombre1 = Nombre, @Contacto1 = NULLIF(RTRIM(Contacto1), ''), @Contacto2 = NULLIF(RTRIM(Contacto2), ''), @eMail1 = NULLIF(RTRIM(eMail1), ''), @eMail2 = NULLIF(RTRIM(eMail2), '') FROM Cte WHERE Cliente = @Contacto 
      IF NULLIF(@EnviarA, 0) IS NOT NULL
        SELECT @eMailAuto2 = ISNULL(eMailAuto, 0), @Nombre2 = Nombre, @Contacto3 = NULLIF(RTRIM(Contacto1), ''), @Contacto4 = NULLIF(RTRIM(Contacto2), ''), @eMail1 = NULLIF(RTRIM(eMail1), ''), @eMail2 = NULLIF(RTRIM(eMail2), '') FROM CteEnviarA WHERE Cliente = @Contacto AND ID = @EnviarA
    END ELSE
    IF @CtoTipo = 'Proveedor' 
      SELECT @eMailAuto1 = ISNULL(eMailAuto, 0), @Contacto1 = NULLIF(RTRIM(Contacto1), ''), @Contacto2 = NULLIF(RTRIM(Contacto2), ''), @eMail1 = NULLIF(RTRIM(eMail1), ''), @eMail2 = NULLIF(RTRIM(eMail2), '') FROM Prov WHERE Proveedor = @Contacto 
    ELSE
    IF @CtoTipo = 'Personal'
    BEGIN
      SELECT @eMailAuto1 = ISNULL(eMailAuto, 0), @Nombre1 = ISNULL(Nombre, '')+' '+ISNULL(ApellidoPaterno, '')+' '+ISNULL(ApellidoMaterno, ''), @eMail1 = NULLIF(RTRIM(eMail), '') FROM Personal WHERE Personal  = @Contacto 
      SELECT @Contacto1 = @Nombre1
    END ELSE
    IF @CtoTipo = 'Agente'
    BEGIN
      SELECT @eMailAuto1 = ISNULL(eMailAuto, 0), @Nombre1 = NULLIF(RTRIM(Nombre), ''), @eMail1 = NULLIF(RTRIM(eMail), '') FROM Agente   WHERE Agente    = @Contacto 
      SELECT @Contacto1 = @Nombre1
    END

    IF @eMailAuto1 = 1 OR @eMailAuto2 = 1
    BEGIN
      SELECT @Asunto = NULLIF(RTRIM(eMailAutoAsunto), ''), 
             @MensajePrevio = eMailAutoMensaje
        FROM EmpresaGral 
       WHERE Empresa = @Empresa
      SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa
      SELECT @UsuarioNombre = Nombre FROM Usuario WHERE Usuario = @Usuario
      SELECT @SucursalNombre = Nombre FROM Sucursal WHERE Sucursal = @Sucursal
      SELECT @UENNombre = Nombre FROM UEN WHERE UEN = @UEN
      SELECT @FechaEmisionSt = CONVERT(datetime, @FechaEmision, 103),
             @SituacionFechaSt = CONVERT(datetime, @SituacionFecha, 103),
             @AhoraSt = CONVERT(datetime, GETDATE(), 113)

      IF NULLIF(RTRIM(@MensajePrevio), '') IS NOT NULL
      BEGIN
        EXEC spReemplazar '<Mov>',   		@Mov, 			@MensajePrevio OUTPUT
        EXEC spReemplazar '<MovID>', 		@MovID, 		@MensajePrevio OUTPUT
        EXEC spReemplazar '<Fecha Emision>', 	@FechaEmisionSt,	@MensajePrevio OUTPUT
        EXEC spReemplazar '<Estatus>', 		@Estatus,		@MensajePrevio OUTPUT
        EXEC spReemplazar '<Situacion>', 	@Situacion,		@MensajePrevio OUTPUT
        EXEC spReemplazar '<Situacion Fecha>',	@SituacionFechaSt,	@MensajePrevio OUTPUT
        EXEC spReemplazar '<Situacion Usuario>',@SituacionUsuario,	@MensajePrevio OUTPUT
        EXEC spReemplazar '<Situacion Nota>',	@SituacionNota,		@MensajePrevio OUTPUT
        EXEC spReemplazar '<Fecha Seguimiento>',@SituacionFechaSt,	@MensajePrevio OUTPUT
        EXEC spReemplazar '<Usuario Seguimiento>',@SituacionUsuario,	@MensajePrevio OUTPUT
        EXEC spReemplazar '<Empresa>',		@EmpresaNombre,		@MensajePrevio OUTPUT
        EXEC spReemplazar '<Sucursal>',		@SucursalNombre,	@MensajePrevio OUTPUT
        EXEC spReemplazar '<UEN>',		@UENNombre,		@MensajePrevio OUTPUT
        EXEC spReemplazar '<Proyecto>',		@Proyecto,		@MensajePrevio OUTPUT
        EXEC spReemplazar '<Concepto>',		@Concepto,		@MensajePrevio OUTPUT
        EXEC spReemplazar '<Referencia>',	@Referencia,		@MensajePrevio OUTPUT
        EXEC spReemplazar '<Clave>',		@Contacto,		@MensajePrevio OUTPUT
       
        IF @eMailAuto1 = 1 
        BEGIN
          IF @eMail1 IS NOT NULL
          BEGIN
            SELECT @Mensaje = @MensajePrevio
            EXEC spReemplazar '<Nombre>',	@Nombre1,		@Mensaje OUTPUT
            EXEC spReemplazar '<Contacto>',	@Contacto1,		@Mensaje OUTPUT
            EXEC spReemplazar '<eMail>',	@eMail1,		@Mensaje OUTPUT
            EXEC xpMailAuto @Modulo, @ID, @Mov, @eMail1 OUTPUT, @Asunto OUTPUT, @Mensaje OUTPUT, @Anexos OUTPUT, @SQL OUTPUT, @SQLAncho OUTPUT, @CancelarEnvio OUTPUT
            IF @CancelarEnvio = 0
            BEGIN
              EXEC spEnviarCorreo @Empresa, @eMail1, @Asunto, @Mensaje, @Anexos, @SQL, @SQLAncho
  	      SELECT @eMailEnviado = 1
            END
          END        
          IF @eMail2 IS NOT NULL
          BEGIN
            SELECT @Mensaje = @MensajePrevio
            EXEC spReemplazar '<Nombre>',	@Nombre1,		@Mensaje OUTPUT
            EXEC spReemplazar '<Contacto>',	@Contacto2,		@Mensaje OUTPUT
            EXEC spReemplazar '<eMail>',	@eMail2,		@Mensaje OUTPUT
            EXEC xpMailAuto @Modulo, @ID, @Mov, @eMail1 OUTPUT, @Asunto OUTPUT, @Mensaje OUTPUT, @Anexos OUTPUT, @SQL OUTPUT, @SQLAncho OUTPUT, @CancelarEnvio OUTPUT
            IF @CancelarEnvio = 0
            BEGIN
              EXEC spEnviarCorreo @Empresa, @eMail2, @Asunto, @Mensaje, @Anexos, @SQL, @SQLAncho
              INSERT AnexoMov (Destino, Sucursal, Rama, ID, Icono, Tipo, Nombre, Comentario, Origen, Fecha) VALUES (@eMail2, @Sucursal, @Modulo, @ID, 60, 'Mensaje', @Asunto, @Mensaje, @UsuarioNombre, @AhoraSt)
	      SELECT @eMailEnviado = 1
            END
          END        
        END

        IF @eMailAuto1 = 2
        BEGIN
          IF @eMail3 IS NOT NULL
          BEGIN
            SELECT @Mensaje = @MensajePrevio
            EXEC spReemplazar '<Nombre>',	@Nombre2,		@Mensaje OUTPUT
            EXEC spReemplazar '<Contacto>',	@Contacto3,		@Mensaje OUTPUT
            EXEC spReemplazar '<eMail>',	@eMail3,		@Mensaje OUTPUT
            EXEC xpMailAuto @Modulo, @ID, @Mov, @eMail1 OUTPUT, @Asunto OUTPUT, @Mensaje OUTPUT, @Anexos OUTPUT, @SQL OUTPUT, @SQLAncho OUTPUT, @CancelarEnvio OUTPUT
            IF @CancelarEnvio = 0
            BEGIN
              EXEC spEnviarCorreo @Empresa, @eMail3, @Asunto, @Mensaje, @Anexos, @SQL, @SQLAncho
              INSERT AnexoMov (Destino, Sucursal, Rama, ID, Icono, Tipo, Nombre, Comentario, Origen, Fecha) VALUES (@eMail3, @Sucursal, @Modulo, @ID, 60, 'Mensaje', @Asunto, @Mensaje, @UsuarioNombre, @AhoraSt)
	      SELECT @eMailEnviado = 1
            END
          END        
          IF @eMail4 IS NOT NULL
          BEGIN
            SELECT @Mensaje = @MensajePrevio
            EXEC spReemplazar '<Nombre>',	@Nombre2,		@Mensaje OUTPUT
            EXEC spReemplazar '<Contacto>',	@Contacto4,		@Mensaje OUTPUT
            EXEC spReemplazar '<eMail>',	@eMail4,		@Mensaje OUTPUT
            EXEC xpMailAuto @Modulo, @ID, @Mov, @eMail1 OUTPUT, @Asunto OUTPUT, @Mensaje OUTPUT, @Anexos OUTPUT, @SQL OUTPUT, @SQLAncho OUTPUT, @CancelarEnvio OUTPUT
            IF @CancelarEnvio = 0
            BEGIN
              EXEC spEnviarCorreo @Empresa, @eMail4, @Asunto, @Mensaje, @Anexos, @SQL, @SQLAncho
              INSERT AnexoMov (Destino, Sucursal, Rama, ID, Icono, Tipo, Nombre, Comentario, Origen, Fecha) VALUES (@eMail4, @Sucursal, @Modulo, @ID, 60, 'Mensaje', @Asunto, @Mensaje, @UsuarioNombre, @AhoraSt)
	      SELECT @eMailEnviado = 1
            END
          END        
        END
      END     
    END
  END
  RETURN
END
GO

/************** spAfectarLote ***************/
if exists (select * from sysobjects where id = object_id('dbo.spAfectarLote') and type = 'P') drop procedure dbo.spAfectarLote
GO
CREATE PROCEDURE spAfectarLote
		      @Empresa char(5),
		      @Usuario char(10),
                      @Modulo  char(5),
 		      @Mov     char(20) = NULL,
		      @IDD     int	= NULL,
		      @IDA     int	= NULL
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
     @Cuantos 	int,
     @ID 	int

  IF @Mov IS NULL
  BEGIN
    IF @Modulo = 'CONT'  DECLARE crModulo CURSOR FOR SELECT ID FROM Cont         WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'VTAS'  DECLARE crModulo CURSOR FOR SELECT ID FROM Venta        WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'COMS'  DECLARE crModulo CURSOR FOR SELECT ID FROM Compra       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'INV'   DECLARE crModulo CURSOR FOR SELECT ID FROM Inv          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'CXC'   DECLARE crModulo CURSOR FOR SELECT ID FROM Cxc          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'CXP'   DECLARE crModulo CURSOR FOR SELECT ID FROM Cxp          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'GAS'   DECLARE crModulo CURSOR FOR SELECT ID FROM Gasto        WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'DIN'   DECLARE crModulo CURSOR FOR SELECT ID FROM Dinero       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'EMB'   DECLARE crModulo CURSOR FOR SELECT ID FROM Embarque     WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'AF'    DECLARE crModulo CURSOR FOR SELECT ID FROM ActivoFijo   WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'NOM'   DECLARE crModulo CURSOR FOR SELECT ID FROM Nomina       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'RH'    DECLARE crModulo CURSOR FOR SELECT ID FROM RH           WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'ASIS'  DECLARE crModulo CURSOR FOR SELECT ID FROM Asiste       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'CAP'   DECLARE crModulo CURSOR FOR SELECT ID FROM Capital      WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'INC'   DECLARE crModulo CURSOR FOR SELECT ID FROM Incidencia   WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'CONC'  DECLARE crModulo CURSOR FOR SELECT ID FROM Conciliacion WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'PPTO'  DECLARE crModulo CURSOR FOR SELECT ID FROM Presup       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'PC'    DECLARE crModulo CURSOR FOR SELECT ID FROM PC           WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'OFER'  DECLARE crModulo CURSOR FOR SELECT ID FROM Oferta       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'CREDI' DECLARE crModulo CURSOR FOR SELECT ID FROM Credito	 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'TMA'   DECLARE crModulo CURSOR FOR SELECT ID FROM TMA          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'RSS'   DECLARE crModulo CURSOR FOR SELECT ID FROM RSS          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'CMP'   DECLARE crModulo CURSOR FOR SELECT ID FROM Campana      WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'FIS'   DECLARE crModulo CURSOR FOR SELECT ID FROM Fiscal       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    --REQ25014
    IF @Modulo = 'CONTP' DECLARE crModulo CURSOR FOR SELECT ID FROM ContParalela WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    --REQ16092
	IF @Modulo = 'OPORT' DECLARE crModulo CURSOR FOR SELECT ID FROM Oportunidad  WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE    	
    IF @Modulo = 'CORTE' DECLARE crModulo CURSOR FOR SELECT ID FROM Corte        WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE    
    --IF @Modulo = 'ACT'   DECLARE crModulo CURSOR FOR SELECT ID FROM Act           WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    --IF @Modulo = 'MEX01' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra01 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    --IF @Modulo = 'MEX02' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra02 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    --IF @Modulo = 'MEX03' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra03 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    --IF @Modulo = 'MEX04' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra04 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    --IF @Modulo = 'MEX05' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra05 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    --IF @Modulo = 'MEX06' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra06 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    --IF @Modulo = 'MEX07' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra07 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    --IF @Modulo = 'MEX08' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra08 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    --IF @Modulo = 'MEX09' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra09 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'ORG'   DECLARE crModulo CURSOR FOR SELECT ID FROM Organiza     WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'RE'    DECLARE crModulo CURSOR FOR SELECT ID FROM Recluta      WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'ISL'   DECLARE crModulo CURSOR FOR SELECT ID FROM ISL		     WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'FRM'   DECLARE crModulo CURSOR FOR SELECT ID FROM FormaExtra   WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'CAPT'  DECLARE crModulo CURSOR FOR SELECT ID FROM Captura      WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'GES'   DECLARE crModulo CURSOR FOR SELECT ID FROM Gestion      WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'CP'    DECLARE crModulo CURSOR FOR SELECT ID FROM CP           WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'PCP'   DECLARE crModulo CURSOR FOR SELECT ID FROM PCP          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE    
    IF @Modulo = 'CAM'   DECLARE crModulo CURSOR FOR SELECT ID FROM Cambio       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'PACTO' DECLARE crModulo CURSOR FOR SELECT ID FROM Contrato     WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'SAUX'  DECLARE crModulo CURSOR FOR SELECT ID FROM SAUX         WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' ELSE
    IF @Modulo = 'DOC'   DECLARE crModulo CURSOR FOR SELECT ID FROM Doc          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR'
    ELSE BEGIN
      RAISERROR ('El Modulo No Existe',16,-1) 
      RETURN
    END
  END ELSE
  BEGIN
    IF @Modulo = 'CONT'  DECLARE crModulo CURSOR FOR SELECT ID FROM Cont         WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'VTAS'  DECLARE crModulo CURSOR FOR SELECT ID FROM Venta        WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'COMS'  DECLARE crModulo CURSOR FOR SELECT ID FROM Compra       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'INV'   DECLARE crModulo CURSOR FOR SELECT ID FROM Inv          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'CXC'   DECLARE crModulo CURSOR FOR SELECT ID FROM Cxc          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'CXP'   DECLARE crModulo CURSOR FOR SELECT ID FROM Cxp          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'GAS'   DECLARE crModulo CURSOR FOR SELECT ID FROM Gasto        WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'DIN'   DECLARE crModulo CURSOR FOR SELECT ID FROM Dinero       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'EMB'   DECLARE crModulo CURSOR FOR SELECT ID FROM Embarque     WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'AF'    DECLARE crModulo CURSOR FOR SELECT ID FROM ActivoFijo   WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'NOM'   DECLARE crModulo CURSOR FOR SELECT ID FROM Nomina       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'RH'    DECLARE crModulo CURSOR FOR SELECT ID FROM RH           WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'ASIS'  DECLARE crModulo CURSOR FOR SELECT ID FROM Asiste       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'CAP'   DECLARE crModulo CURSOR FOR SELECT ID FROM Capital      WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'INC'   DECLARE crModulo CURSOR FOR SELECT ID FROM Incidencia   WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'CONC'  DECLARE crModulo CURSOR FOR SELECT ID FROM Conciliacion WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'PPTO'  DECLARE crModulo CURSOR FOR SELECT ID FROM Presup       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'PC'    DECLARE crModulo CURSOR FOR SELECT ID FROM PC           WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'OFER'  DECLARE crModulo CURSOR FOR SELECT ID FROM Oferta       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'CREDI' DECLARE crModulo CURSOR FOR SELECT ID FROM Credito	 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'TMA'   DECLARE crModulo CURSOR FOR SELECT ID FROM TMA          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'RSS'   DECLARE crModulo CURSOR FOR SELECT ID FROM RSS          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'CMP'   DECLARE crModulo CURSOR FOR SELECT ID FROM Campana      WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'FIS'   DECLARE crModulo CURSOR FOR SELECT ID FROM Fiscal       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    --REQ25014
    IF @Modulo = 'CONTP' DECLARE crModulo CURSOR FOR SELECT ID FROM ContParalela WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    --REQ16092
	IF @Modulo = 'OPORT' DECLARE crModulo CURSOR FOR SELECT ID FROM Oportunidad  WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE	
    IF @Modulo = 'CORTE' DECLARE crModulo CURSOR FOR SELECT ID FROM Corte        WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE    
    --IF @Modulo = 'ACT'   DECLARE crModulo CURSOR FOR SELECT ID FROM Act           WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    --IF @Modulo = 'MEX01' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra01 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    --IF @Modulo = 'MEX02' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra02 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    --IF @Modulo = 'MEX03' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra03 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    --IF @Modulo = 'MEX04' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra04 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    --IF @Modulo = 'MEX05' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra05 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    --IF @Modulo = 'MEX06' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra06 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    --IF @Modulo = 'MEX07' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra07 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    --IF @Modulo = 'MEX08' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra08 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    --IF @Modulo = 'MEX09' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra09 WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'ORG'   DECLARE crModulo CURSOR FOR SELECT ID FROM Organiza     WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'RE'	 DECLARE crModulo CURSOR FOR SELECT ID FROM Recluta	     WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'ISL'   DECLARE crModulo CURSOR FOR SELECT ID FROM ISL		     WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'FRM'   DECLARE crModulo CURSOR FOR SELECT ID FROM FormaExtra   WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'CAPT'  DECLARE crModulo CURSOR FOR SELECT ID FROM Captura      WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'GES'   DECLARE crModulo CURSOR FOR SELECT ID FROM Gestion      WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'CP'    DECLARE crModulo CURSOR FOR SELECT ID FROM CP           WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'PCP'   DECLARE crModulo CURSOR FOR SELECT ID FROM PCP          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE    
    IF @Modulo = 'CAM'   DECLARE crModulo CURSOR FOR SELECT ID FROM Cambio       WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'PACTO' DECLARE crModulo CURSOR FOR SELECT ID FROM Contrato     WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'SAUX'  DECLARE crModulo CURSOR FOR SELECT ID FROM SAUX         WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov ELSE
    IF @Modulo = 'DOC'   DECLARE crModulo CURSOR FOR SELECT ID FROM Doc          WHERE Empresa = @Empresa AND Estatus = 'SINAFECTAR' AND Mov = @Mov
    ELSE BEGIN
      RAISERROR ('El Modulo No Existe',16,-1) 
      RETURN
    END
  END 
  SELECT @Cuantos = 0
  OPEN crModulo
  FETCH NEXT FROM crModulo INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND (@IDD IS NULL OR @ID >= @IDD) AND (@IDA IS NULL OR @ID <= @IDA)
    BEGIN
      EXEC spAfectar @Modulo, @ID, NULL, NULL, NULL, @Usuario
      SELECT @Cuantos = @Cuantos + 1
    END
    FETCH NEXT FROM crModulo INTO @ID
  END
  CLOSE crModulo
  DEALLOCATE crModulo
  SELECT LTRIM(CONVERT(char, @Cuantos))+' Movimiento(s) Afectado(s).'

  RETURN
END
GO

/************** spCancelarLote ***************/
if exists (select * from sysobjects where id = object_id('dbo.spCancelarLote') and type = 'P') drop procedure dbo.spCancelarLote
GO
CREATE PROCEDURE spCancelarLote
		      @Empresa char(5),
                      @Modulo  char(5),
                      @IDD     int,
                      @IDA     int
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
     @Cuantos 	int,
     @ID 	int

  IF @Modulo = 'CONT'  DECLARE crModulo CURSOR FOR SELECT ID FROM Cont         WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'VTAS'  DECLARE crModulo CURSOR FOR SELECT ID FROM Venta        WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'COMS'  DECLARE crModulo CURSOR FOR SELECT ID FROM Compra       WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'INV'   DECLARE crModulo CURSOR FOR SELECT ID FROM Inv          WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'CXC'   DECLARE crModulo CURSOR FOR SELECT ID FROM Cxc          WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'CXP'   DECLARE crModulo CURSOR FOR SELECT ID FROM Cxp          WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'GAS'   DECLARE crModulo CURSOR FOR SELECT ID FROM Gasto        WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'DIN'   DECLARE crModulo CURSOR FOR SELECT ID FROM Dinero       WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'EMB'   DECLARE crModulo CURSOR FOR SELECT ID FROM Embarque     WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'AF'    DECLARE crModulo CURSOR FOR SELECT ID FROM ActivoFijo   WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'CAP'   DECLARE crModulo CURSOR FOR SELECT ID FROM Capital      WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'INC'   DECLARE crModulo CURSOR FOR SELECT ID FROM Incidencia   WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'CONC'  DECLARE crModulo CURSOR FOR SELECT ID FROM Conciliacion WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'PPTO'  DECLARE crModulo CURSOR FOR SELECT ID FROM Presup       WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'PC'    DECLARE crModulo CURSOR FOR SELECT ID FROM PC           WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'OFER'  DECLARE crModulo CURSOR FOR SELECT ID FROM Oferta       WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'CREDI' DECLARE crModulo CURSOR FOR SELECT ID FROM Credito      WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'TMA'   DECLARE crModulo CURSOR FOR SELECT ID FROM TMA          WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'RSS'   DECLARE crModulo CURSOR FOR SELECT ID FROM RSS          WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'CMP'   DECLARE crModulo CURSOR FOR SELECT ID FROM Campana      WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'FIS'   DECLARE crModulo CURSOR FOR SELECT ID FROM Fiscal       WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  --REQ25014
  IF @Modulo = 'CONTP' DECLARE crModulo CURSOR FOR SELECT ID FROM ContParalela WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  --REQ16092
  IF @Modulo = 'OPORT' DECLARE crModulo CURSOR FOR SELECT ID FROM Oportunidad  WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'CORTE' DECLARE crModulo CURSOR FOR SELECT ID FROM Corte        WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE  
  --IF @Modulo = 'ACT'   DECLARE crModulo CURSOR FOR SELECT ID FROM Act           WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  --IF @Modulo = 'MEX01' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra01 WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  --IF @Modulo = 'MEX02' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra02 WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  --IF @Modulo = 'MEX03' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra03 WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  --IF @Modulo = 'MEX04' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra04 WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  --IF @Modulo = 'MEX05' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra05 WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  --IF @Modulo = 'MEX06' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra06 WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  --IF @Modulo = 'MEX07' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra07 WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  --IF @Modulo = 'MEX08' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra08 WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  --IF @Modulo = 'MEX09' DECLARE crModulo CURSOR FOR SELECT ID FROM ModuloExtra09 WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'ORG'   DECLARE crModulo CURSOR FOR SELECT ID FROM Organiza     WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'RE'    DECLARE crModulo CURSOR FOR SELECT ID FROM Recluta      WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'ISL'   DECLARE crModulo CURSOR FOR SELECT ID FROM ISL	       WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'FRM'   DECLARE crModulo CURSOR FOR SELECT ID FROM FormaExtra   WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'CAPT'  DECLARE crModulo CURSOR FOR SELECT ID FROM Captura      WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'GES'   DECLARE crModulo CURSOR FOR SELECT ID FROM Gestion      WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'CP'    DECLARE crModulo CURSOR FOR SELECT ID FROM CP           WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'PCP'   DECLARE crModulo CURSOR FOR SELECT ID FROM PCP          WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE  
  IF @Modulo = 'CAM'   DECLARE crModulo CURSOR FOR SELECT ID FROM Cambio       WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'PACTO' DECLARE crModulo CURSOR FOR SELECT ID FROM Contrato     WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'SAUX'  DECLARE crModulo CURSOR FOR SELECT ID FROM SAUX         WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA ELSE
  IF @Modulo = 'DOC'   DECLARE crModulo CURSOR FOR SELECT ID FROM Doc          WHERE Empresa = @Empresa AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND ID BETWEEN @IDD AND @IDA
  ELSE BEGIN
    RAISERROR ('El Modulo No Existe',16,-1) 
    RETURN
  END

  SELECT @Cuantos = 0
  OPEN crModulo
  FETCH NEXT FROM crModulo INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spAfectar @Modulo, @ID, 'CANCELAR'
      SELECT @Cuantos = @Cuantos + 1
    END
    FETCH NEXT FROM crModulo INTO @ID
  END
  CLOSE crModulo
  DEALLOCATE crModulo
  SELECT LTRIM(CONVERT(char, @Cuantos))+' Movimiento(s) Cancelado(s).'

  RETURN
END
GO


/************** spDesAfectarLote ***************/
if exists (select * from sysobjects where id = object_id('dbo.spDesAfectarLote') and type = 'P') drop procedure dbo.spDesAfectarLote
GO
CREATE PROCEDURE spDesAfectarLote
		      @Empresa 	char(5),
                      @Modulo  	char(5),
                      @IDD   	int,
                      @IDA	int
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
     @Cuantos 	int,
     @ID 	int

  IF @Modulo = 'CONT' DECLARE crModulo CURSOR FOR SELECT ID FROM Cont WHERE Empresa = @Empresa AND Estatus = 'CONCLUIDO' AND ID BETWEEN @IDD AND @IDA
  ELSE BEGIN
    RAISERROR ('Modulo Incorrecto',16,-1) 
    RETURN
  END

  SELECT @Cuantos = 0
  OPEN crModulo
  FETCH NEXT FROM crModulo INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spAfectar @Modulo, @ID, 'DESAFECTAR'
      SELECT @Cuantos = @Cuantos + 1
    END
    FETCH NEXT FROM crModulo INTO @ID
  END
  CLOSE crModulo
  DEALLOCATE crModulo
  SELECT LTRIM(CONVERT(char, @Cuantos))+' Movimiento(s) DesAfectado(s).'

  RETURN
END
GO

/*************** spCorregirAuxiliar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCorregirAuxiliar') and type = 'P') drop procedure dbo.spCorregirAuxiliar
GO             
CREATE PROCEDURE spCorregirAuxiliar
			@ID		int,
			@CargoNuevo	money,
			@AbonoNuevo	money,
			@Conexion	bit	= 0,
			@Ok		int	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Empresa		char(5),
    @Sucursal		int,
    @Rama		char(5),
    @Ejercicio		int,
    @Periodo		int,
    @Moneda		char(10),
    @Grupo		char(10),
    @Cuenta		char(20),
    @SubCuenta		varchar(50),
    @CargoAnterior	money,
    @AbonoAnterior	money,
    @CargoDif		money,
    @AbonoDif		money,
    @SaldoDif		money

  SELECT @Empresa = NULL
  
  SELECT @Empresa       = Empresa,
         @Sucursal	= Sucursal,
	 @Rama          = Rama,
         @Ejercicio     = Ejercicio,
         @Periodo       = Periodo,
         @Moneda        = Moneda,
         @Grupo         = Grupo,
         @Cuenta        = Cuenta,
         @SubCuenta     = SubCuenta,
         @CargoAnterior = ISNULL(Cargo, 0.0),
         @AbonoAnterior = ISNULL(Abono, 0.0)
    FROM Auxiliar
   WHERE ID = @ID
 
  IF @Empresa IS NULL
  BEGIN
    IF @Conexion = 0  
      RAISERROR ('El "ID" No Existe!',16,-1) 
    ELSE SELECT @Ok = 1

    RETURN
  END

  IF @Conexion = 0 
    BEGIN TRANSACTION

    UPDATE Auxiliar 
       SET Cargo = @CargoNuevo,
           Abono = @AbonoNuevo
     WHERE ID = @ID
    IF @@ROWCOUNT <> 1 SELECT @Ok = 1 
    
    SELECT @CargoNuevo = ISNULL(@CargoNuevo, 0.0),
           @AbonoNuevo = ISNULL(@AbonoNuevo, 0.0)

    SELECT @CargoDif = @CargoNuevo - @CargoAnterior,
           @AbonoDif = @AbonoNuevo - @AbonoAnterior
    SELECT @SaldoDif = @CargoDif - @AbonoDif
     
    UPDATE Acum
       SET Cargos = ISNULL(Cargos, 0.0) + @CargoDif,
           Abonos = ISNULL(Abonos, 0.0) + @AbonoDif
     WHERE Empresa   = @Empresa 
       AND Sucursal  = @Sucursal
       AND Rama      = @Rama
       AND Ejercicio = @Ejercicio
       AND Periodo   = @Periodo
       AND Moneda    = @Moneda
       AND Grupo     = @Grupo
       AND Cuenta    = @Cuenta
       AND SubCuenta = @SubCuenta
    IF @@ROWCOUNT = 0 
      INSERT Acum (Cargos,    Abonos,    Empresa,  Sucursal,  Rama,  Ejercicio,  Periodo,  Moneda,  Grupo,  Cuenta,  SubCuenta)
           VALUES (@CargoDif, @AbonoDif, @Empresa, @Sucursal, @Rama, @Ejercicio, @Periodo, @Moneda, @Grupo, @Cuenta, @SubCuenta)

    UPDATE Saldo
       SET Saldo = ISNULL(Saldo, 0.0) + @SaldoDif
     WHERE Empresa   = @Empresa
       AND Sucursal  = @Sucursal
       AND Rama      = @Rama
       AND Moneda    = @Moneda
       AND Grupo     = @Grupo
       AND Cuenta    = @Cuenta
       AND SubCuenta = @SubCuenta
    IF @@ROWCOUNT = 0 
      INSERT Saldo (Saldo,     Empresa,  Sucursal,  Rama,  Moneda,  Grupo,  Cuenta,  SubCuenta)
            VALUES (@SaldoDif, @Empresa, @Sucursal, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta)

  IF @Conexion = 0
  BEGIN
    IF @OK IS NULL
    BEGIN
      COMMIT TRANSACTION
      SELECT "Cargo Anterior" = @CargoAnterior, "Cargo Nuevo" = @CargoNuevo,
             "Abono Anterior" = @AbonoAnterior, "Abono Nuevo" = @AbonoNuevo,
             "ID" = @ID, "Empresa" = @Empresa
    END ELSE 
    BEGIN
      ROLLBACK TRANSACTION

      IF @Ok = 1 SELECT 'Fallo al Corregir Auxiliar'
      IF @Ok = 2 SELECT 'Fallo al Corregir Acum'
      IF @Ok = 3 SELECT 'Fallo al Corregir Saldo'
    END
  END
  RETURN
END
GO

/* CorregirAuxiliarLista */
if exists (select * from sysobjects where id = object_id('dbo.CorregirAuxiliarLista') and sysstat & 0xf = 3) drop table dbo.CorregirAuxiliarLista
go
CREATE TABLE dbo.CorregirAuxiliarLista (
	ID			int		NOT NULL,

	CargoNuevo		money		NULL,
	AbonoNuevo		money		NULL,

	CONSTRAINT priCorregirAuxiliarLista PRIMARY KEY CLUSTERED (ID)
)
go

/*************** spCorregirAuxiliarLista *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCorregirAuxiliarLista') and type = 'P') drop procedure dbo.spCorregirAuxiliarLista
GO             
CREATE PROCEDURE spCorregirAuxiliarLista
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok		int,
    @ID		int,
    @CargoNuevo	money, 
    @AbonoNuevo money

  SELECT @Ok = NULL

  BEGIN TRANSACTION

  DECLARE crLista CURSOR FOR 
   SELECT ID, CargoNuevo, AbonoNuevo 
     FROM CorregirAuxiliarLista 
  OPEN crLista
  FETCH NEXT FROM crLista INTO @ID, @CargoNuevo, @AbonoNuevo 
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spCorregirAuxiliar @ID, @CargoNuevo, @AbonoNuevo, @Conexion = 1, @Ok = @Ok OUTPUT

    FETCH NEXT FROM crLista INTO @ID, @CargoNuevo, @AbonoNuevo 
  END
  CLOSE crLista
  DEALLOCATE crLista

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT CONVERT(varchar, COUNT(*))+' Auxiliares Corregidos' FROM CorregirAuxiliarLista 
  END ELSE 
  BEGIN
    ROLLBACK TRANSACTION
    IF @Ok = 1 SELECT 'Mensaje' = 'Fallo al Corregir Auxiliar', 'ID' = @ID
    IF @Ok = 2 SELECT 'Mensaje' = 'Fallo al Corregir Acum', 'ID' = @ID
    IF @Ok = 3 SELECT 'Mensaje' = 'Fallo al Corregir Saldo', 'ID' = @ID
  END

  RETURN
END
GO


/*************** spCorregirAuxiliarR *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCorregirAuxiliarR') and type = 'P') drop procedure dbo.spCorregirAuxiliarR
GO             
CREATE PROCEDURE spCorregirAuxiliarR
			@ID		int,
			@CargoNuevo	money,
			@AbonoNuevo	money,
			@Conexion	bit	= 0,
			@Ok		int	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Empresa		char(5),
    @Sucursal		int,
    @Rama		char(5),
    @Ejercicio		int,
    @Periodo		int,
    @Moneda		char(10),
    @Grupo		char(10),
    @Cuenta		char(20),
    @SubCuenta		varchar(50),
    @CargoAnterior	money,
    @AbonoAnterior	money,
    @CargoDif		money,
    @AbonoDif		money,
    @SaldoDif		money

  SELECT @Empresa = NULL
  
  SELECT @Empresa       = Empresa,
         @Sucursal	= Sucursal,
	 @Rama          = Rama,
         @Ejercicio     = Ejercicio,
         @Periodo       = Periodo,
         @Moneda        = Moneda,
         @Grupo         = Grupo,
         @Cuenta        = Cuenta,
         @SubCuenta     = SubCuenta,
         @CargoAnterior = ISNULL(Cargo, 0.0),
         @AbonoAnterior = ISNULL(Abono, 0.0)
    FROM AuxiliarR
   WHERE ID = @ID
 
  IF @Empresa IS NULL
  BEGIN
    IF @Conexion = 0  
      RAISERROR ('El "ID" No Existe!',16,-1) 
    ELSE SELECT @Ok = 1

    RETURN
  END

  IF @Conexion = 0 
    BEGIN TRANSACTION

    UPDATE AuxiliarR 
       SET Cargo = @CargoNuevo,
           Abono = @AbonoNuevo
     WHERE ID = @ID
    IF @@ROWCOUNT <> 1 SELECT @Ok = 1 
    
    SELECT @CargoNuevo = ISNULL(@CargoNuevo, 0.0),
           @AbonoNuevo = ISNULL(@AbonoNuevo, 0.0)

    SELECT @CargoDif = @CargoNuevo - @CargoAnterior,
           @AbonoDif = @AbonoNuevo - @AbonoAnterior
    SELECT @SaldoDif = @CargoDif - @AbonoDif
     
    UPDATE AcumR
       SET Cargos = ISNULL(Cargos, 0.0) + @CargoDif,
           Abonos = ISNULL(Abonos, 0.0) + @AbonoDif
     WHERE Empresa   = @Empresa 
       AND Sucursal  = @Sucursal
       AND Rama      = @Rama
       AND Ejercicio = @Ejercicio
       AND Periodo   = @Periodo
       AND Moneda    = @Moneda
       AND Grupo     = @Grupo
       AND Cuenta    = @Cuenta
       AND SubCuenta = @SubCuenta
    IF @@ROWCOUNT = 0 
      INSERT AcumR (Cargos,    Abonos,    Empresa,  Sucursal,  Rama,  Ejercicio,  Periodo,  Moneda,  Grupo,  Cuenta,  SubCuenta)
            VALUES (@CargoDif, @AbonoDif, @Empresa, @Sucursal, @Rama, @Ejercicio, @Periodo, @Moneda, @Grupo, @Cuenta, @SubCuenta)

    UPDATE SaldoR
       SET Saldo = ISNULL(Saldo, 0.0) + @SaldoDif
     WHERE Empresa   = @Empresa
       AND Sucursal  = @Sucursal
       AND Rama      = @Rama
       AND Moneda    = @Moneda
       AND Grupo     = @Grupo
       AND Cuenta    = @Cuenta
       AND SubCuenta = @SubCuenta
    IF @@ROWCOUNT = 0 
      INSERT SaldoR (Saldo,     Empresa,  Sucursal,  Rama,  Moneda,  Grupo,  Cuenta,  SubCuenta)
             VALUES (@SaldoDif, @Empresa, @Sucursal, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta)
 
  IF @Conexion = 0
  BEGIN
    IF @OK IS NULL
    BEGIN
      COMMIT TRANSACTION
      SELECT "Cargo Anterior" = @CargoAnterior, "Cargo Nuevo" = @CargoNuevo,
             "Abono Anterior" = @AbonoAnterior, "Abono Nuevo" = @AbonoNuevo,
             "ID" = @ID, "Empresa" = @Empresa
    END ELSE 
    BEGIN
      ROLLBACK TRANSACTION

      IF @Ok = 1 SELECT 'Fallo al Corregir AuxiliarR'
      IF @Ok = 2 SELECT 'Fallo al Corregir AcumuladoR'
      IF @Ok = 3 SELECT 'Fallo al Corregir SaldoR'
    END
  END
  RETURN
END
GO

/* CorregirAuxiliarRLista */
if exists (select * from sysobjects where id = object_id('dbo.CorregirAuxiliarRLista') and sysstat & 0xf = 3) drop table dbo.CorregirAuxiliarRLista
go
CREATE TABLE dbo.CorregirAuxiliarRLista (
	ID			int		NOT NULL,

	CargoNuevo		money		NULL,
	AbonoNuevo		money		NULL,

	CONSTRAINT priCorregirAuxiliarRLista PRIMARY KEY CLUSTERED (ID)
)
go

/*************** spCorregirAuxiliarRLista *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCorregirAuxiliarRLista') and type = 'P') drop procedure dbo.spCorregirAuxiliarRLista
GO             
CREATE PROCEDURE spCorregirAuxiliarRLista
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok		int,
    @ID		int,
    @CargoNuevo	money, 
    @AbonoNuevo money

  SELECT @Ok = NULL

  BEGIN TRANSACTION

  DECLARE crLista CURSOR FOR 
   SELECT ID, CargoNuevo, AbonoNuevo 
     FROM CorregirAuxiliarRLista 
  OPEN crLista
  FETCH NEXT FROM crLista INTO @ID, @CargoNuevo, @AbonoNuevo 
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spCorregirAuxiliarR @ID, @CargoNuevo, @AbonoNuevo, @Conexion = 1, @Ok = @Ok OUTPUT

    FETCH NEXT FROM crLista INTO @ID, @CargoNuevo, @AbonoNuevo 
  END
  CLOSE crLista
  DEALLOCATE crLista

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT CONVERT(varchar, COUNT(*))+' Auxiliares Corregidos' FROM CorregirAuxiliarRLista 
  END ELSE 
  BEGIN
    ROLLBACK TRANSACTION
    IF @Ok = 1 SELECT 'Mensaje' = 'Fallo al Corregir AuxiliarR', 'ID' = @ID
    IF @Ok = 2 SELECT 'Mensaje' = 'Fallo al Corregir AcumR', 'ID' = @ID
    IF @Ok = 3 SELECT 'Mensaje' = 'Fallo al Corregir SaldoR', 'ID' = @ID
  END

  RETURN
END
GO

/*************** spCorregirAuxiliarU *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCorregirAuxiliarU') and type = 'P') drop procedure dbo.spCorregirAuxiliarU
GO             
CREATE PROCEDURE spCorregirAuxiliarU
			@ID		int,
			@CargoNuevo	money,
			@AbonoNuevo	money,
			@CargoUNuevo	float,
			@AbonoUNuevo	float,
			@Conexion	bit	= 0,
			@Ok		int	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Empresa		char(5),
    @Sucursal		int,
    @Rama		char(5),
    @Ejercicio		int,
    @Periodo		int,
    @Moneda		char(10),
    @Grupo		char(10),
    @SubGrupo		varchar(20),
    @Cuenta		char(20),
    @SubCuenta		varchar(50),
    @CargoAnterior	money,
    @AbonoAnterior	money,
    @CargoUAnterior	float,
    @AbonoUAnterior	float,
    @CargoDif		money,
    @AbonoDif		money,
    @CargoUDif		float,
    @AbonoUDif		float,
    @SaldoDif		money,
    @SaldoUDif		float,

	@WMSAuxiliar	bit -- TASK1964

  SELECT @WMSAuxiliar = WMSAuxiliar FROM Version -- TASK1964

  SELECT @Empresa = NULL
  
  SELECT @Empresa        = Empresa,
         @Sucursal	     = Sucursal,
	     @Rama           = Rama,
         @Ejercicio      = Ejercicio,
         @Periodo        = Periodo,
         @Moneda         = Moneda,
         @Grupo          = Grupo,
         @SubGrupo       = SubGrupo,
         @Cuenta         = Cuenta,
         @SubCuenta      = SubCuenta,
         @CargoAnterior  = ISNULL(Cargo, 0.0),
         @AbonoAnterior  = ISNULL(Abono, 0.0),
         @CargoUAnterior = ISNULL(CargoU, 0.0),
         @AbonoUAnterior = ISNULL(AbonoU, 0.0)
    FROM AuxiliarU
   WHERE ID = @ID
 
  IF @Empresa IS NULL
  BEGIN
    IF @Conexion = 0  
      RAISERROR ('El "ID" No Existe!',16,-1) 
    ELSE SELECT @Ok = 1

    RETURN
  END

  IF @Conexion = 0 
    BEGIN TRANSACTION
    IF @WMSAuxiliar = 1 -- TASK1964
    BEGIN
      IF @SubGrupo <> '' -- TASK1964
      BEGIN -- TASK1964
        UPDATE AuxiliarUWMS 
           SET Cargo  = @CargoNuevo,
               Abono  = @AbonoNuevo,
	           CargoU = @CargoUNuevo,
               AbonoU = @AbonoUNuevo
         WHERE ID = @ID
      END ELSE BEGIN -- TASK1964
        UPDATE AuxiliarU
           SET Cargo  = @CargoNuevo,
               Abono  = @AbonoNuevo,
	           CargoU = @CargoUNuevo,
               AbonoU = @AbonoUNuevo
         WHERE ID = @ID
      END -- TASK1964
    END ELSE BEGIN -- TASK1964
      EXEC dbo.sp_executesql N' 
        UPDATE AuxiliarU 
           SET Cargo  = @CargoNuevo,
               Abono  = @AbonoNuevo,
	           CargoU = @CargoUNuevo,
               AbonoU = @AbonoUNuevo
         WHERE ID = @ID',
		 N'@CargoNuevo money, @AbonoNuevo money, @CargoUNuevo float, @AbonoUNuevo float, @ID int',
		 @CargoNuevo, @AbonoNuevo, @CargoUNuevo, @AbonoUNuevo, @ID
    END -- TASK1964

    IF @@ROWCOUNT <> 1 SELECT @Ok = 1 
    
    SELECT @CargoNuevo  = ISNULL(@CargoNuevo, 0.0),
           @AbonoNuevo  = ISNULL(@AbonoNuevo, 0.0),
           @CargoUNuevo = ISNULL(@CargoUNuevo, 0.0),
           @AbonoUNuevo = ISNULL(@AbonoUNuevo, 0.0)

    SELECT @CargoDif  = @CargoNuevo  - @CargoAnterior,
           @AbonoDif  = @AbonoNuevo  - @AbonoAnterior,
           @CargoUDif = @CargoUNuevo - @CargoUAnterior,
           @AbonoUDif = @AbonoUNuevo - @AbonoUAnterior

    SELECT @SaldoDif  = @CargoDif  - @AbonoDif,
           @SaldoUDif = @CargoUDif - @AbonoUDif
     
    IF @WMSAuxiliar = 1 -- TASK1964
    BEGIN
      IF @SubGrupo <> '' -- TASK1964
      BEGIN -- TASK1964
        UPDATE AcumUWMS
           SET Cargos = ISNULL(Cargos, 0.0) + @CargoDif,
               Abonos = ISNULL(Abonos, 0.0) + @AbonoDif,
               CargosU = ISNULL(CargosU, 0.0) + @CargoUDif,
               AbonosU = ISNULL(AbonosU, 0.0) + @AbonoUDif
         WHERE Empresa   = @Empresa 
           AND Sucursal  = @Sucursal
           AND Rama      = @Rama
           AND Ejercicio = @Ejercicio
           AND Periodo   = @Periodo
           AND Moneda    = @Moneda
           AND Grupo     = @Grupo
           AND SubGrupo  = @SubGrupo
           AND Cuenta    = @Cuenta
           AND SubCuenta = @SubCuenta
        IF @@ROWCOUNT = 0 
          INSERT AcumUWMS (Cargos,    Abonos,    CargosU,    AbonosU,    Empresa,  Sucursal,  Rama,  Ejercicio,  Periodo,  Moneda,  Grupo,  SubGrupo,  Cuenta,  SubCuenta)
                VALUES (@CargoDif, @AbonoDif, @CargoUDif, @AbonoUDif, @Empresa, @Sucursal, @Rama, @Ejercicio, @Periodo, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta)

        UPDATE SaldoUWMS
           SET Saldo  = ISNULL(Saldo, 0.0)  + @SaldoDif,
               SaldoU = ISNULL(SaldoU, 0.0) + @SaldoUDif 
         WHERE Empresa   = @Empresa
           AND Sucursal  = @Sucursal
           AND Rama      = @Rama
           AND Moneda    = @Moneda
           AND Grupo     = @Grupo
           AND SubGrupo  = @SubGrupo
           AND Cuenta    = @Cuenta
           AND SubCuenta = @SubCuenta
        IF @@ROWCOUNT = 0 
          INSERT SaldoUWMS (Saldo,     SaldoU,     Empresa,  Sucursal,  Rama,  Moneda,  Grupo,  SubGrupo,  Cuenta,  SubCuenta)
                    VALUES (@SaldoDif, @SaldoUDif, @Empresa, @Sucursal, @Rama, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta)
      END ELSE BEGIN -- TASK1964
        UPDATE AcumU
           SET Cargos = ISNULL(Cargos, 0.0) + @CargoDif,
               Abonos = ISNULL(Abonos, 0.0) + @AbonoDif,
               CargosU = ISNULL(CargosU, 0.0) + @CargoUDif,
               AbonosU = ISNULL(AbonosU, 0.0) + @AbonoUDif
         WHERE Empresa   = @Empresa 
           AND Sucursal  = @Sucursal
           AND Rama      = @Rama
           AND Ejercicio = @Ejercicio
           AND Periodo   = @Periodo
           AND Moneda    = @Moneda
           AND Grupo     = @Grupo
           AND SubGrupo  = @SubGrupo
           AND Cuenta    = @Cuenta
           AND SubCuenta = @SubCuenta
        IF @@ROWCOUNT = 0 
          INSERT AcumU (Cargos,    Abonos,    CargosU,    AbonosU,    Empresa,  Sucursal,  Rama,  Ejercicio,  Periodo,  Moneda,  Grupo,  SubGrupo,  Cuenta,  SubCuenta)
                    VALUES (@CargoDif, @AbonoDif, @CargoUDif, @AbonoUDif, @Empresa, @Sucursal, @Rama, @Ejercicio, @Periodo, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta)

        UPDATE SaldoU
           SET Saldo  = ISNULL(Saldo, 0.0)  + @SaldoDif,
               SaldoU = ISNULL(SaldoU, 0.0) + @SaldoUDif 
         WHERE Empresa   = @Empresa
           AND Sucursal  = @Sucursal
           AND Rama      = @Rama
           AND Moneda    = @Moneda
           AND Grupo     = @Grupo
           AND SubGrupo  = @SubGrupo
           AND Cuenta    = @Cuenta
           AND SubCuenta = @SubCuenta
        IF @@ROWCOUNT = 0 
          INSERT SaldoU (Saldo,     SaldoU,     Empresa,  Sucursal,  Rama,  Moneda,  Grupo,  SubGrupo,  Cuenta,  SubCuenta)
                     VALUES (@SaldoDif, @SaldoUDif, @Empresa, @Sucursal, @Rama, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta)
      END -- TASK1964
    END ELSE BEGIN -- TASK1964
      EXEC dbo.sp_executesql N' 
        UPDATE AcumU
           SET Cargos = ISNULL(Cargos, 0.0) + @CargoDif,
               Abonos = ISNULL(Abonos, 0.0) + @AbonoDif,
               CargosU = ISNULL(CargosU, 0.0) + @CargoUDif,
               AbonosU = ISNULL(AbonosU, 0.0) + @AbonoUDif
         WHERE Empresa   = @Empresa 
           AND Sucursal  = @Sucursal
           AND Rama      = @Rama
           AND Ejercicio = @Ejercicio
           AND Periodo   = @Periodo
           AND Moneda    = @Moneda
           AND Grupo     = @Grupo
           AND SubGrupo  = @SubGrupo
           AND Cuenta    = @Cuenta
           AND SubCuenta = @SubCuenta
        IF @@ROWCOUNT = 0 
          INSERT AcumU (Cargos,    Abonos,    CargosU,    AbonosU,    Empresa,  Sucursal,  Rama,  Ejercicio,  Periodo,  Moneda,  Grupo,  SubGrupo,  Cuenta,  SubCuenta)
                VALUES (@CargoDif, @AbonoDif, @CargoUDif, @AbonoUDif, @Empresa, @Sucursal, @Rama, @Ejercicio, @Periodo, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta)
 
        UPDATE SaldoU
           SET Saldo  = ISNULL(Saldo, 0.0)  + @SaldoDif,
               SaldoU = ISNULL(SaldoU, 0.0) + @SaldoUDif 
         WHERE Empresa   = @Empresa
           AND Sucursal  = @Sucursal
           AND Rama      = @Rama
           AND Moneda    = @Moneda
           AND Grupo     = @Grupo
           AND SubGrupo  = @SubGrupo
           AND Cuenta    = @Cuenta
           AND SubCuenta = @SubCuenta
        IF @@ROWCOUNT = 0 
          INSERT SaldoU (Saldo,     SaldoU,     Empresa,  Sucursal,  Rama,  Moneda,  Grupo,  SubGrupo,  Cuenta,  SubCuenta)
                 VALUES (@SaldoDif, @SaldoUDif, @Empresa, @Sucursal, @Rama, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta)',
        N'@CargoDif money, @AbonoDif money, @CargoUDif float, @AbonoUDif float, @Empresa varchar(5), @Sucursal int, @Rama varchar(50), @Ejercicio int, @Periodo int,
		  @Moneda varchar(50), @Grupo varchar(50), @SubGrupo varchar(50), @Cuenta varchar(50), @SubCuenta varchar(50), @SaldoDif money, @SaldoUDif float',
        @CargoDif, @AbonoDif, @CargoUDif, @AbonoUDif, @Empresa, @Sucursal, @Rama, @Ejercicio, @Periodo, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta, @SaldoDif, @SaldoUDif
    END -- TASK1964

  IF @Conexion = 0
  BEGIN
    IF @OK IS NULL
    BEGIN
      COMMIT TRANSACTION
      SELECT "Cargo Anterior"  = @CargoAnterior,  "Cargo Nuevo"  = @CargoNuevo,
             "Abono Anterior"  = @AbonoAnterior,  "Abono Nuevo"  = @AbonoNuevo,
             "ID" = @ID, "Empresa" = @Empresa
      SELECT "CargoU Anterior" = @CargoUAnterior, "CargoU Nuevo" = @CargoUNuevo,
             "AbonoU Anterior" = @AbonoUAnterior, "AbonoU Nuevo" = @AbonoUNuevo
    END ELSE 
    BEGIN
      ROLLBACK TRANSACTION

      IF @Ok = 1 SELECT 'Fallo al Corregir AuxiliarU'
      IF @Ok = 2 SELECT 'Fallo al Corregir AcumU'
      IF @Ok = 3 SELECT 'Fallo al Corregir SaldoU'
    END
  END
  RETURN
END
GO

/* CorregirAuxiliarULista */
if exists (select * from sysobjects where id = object_id('dbo.CorregirAuxiliarULista') and sysstat & 0xf = 3) drop table dbo.CorregirAuxiliarULista
go
CREATE TABLE dbo.CorregirAuxiliarULista (
	ID			int		NOT NULL,

	CargoNuevo		money		NULL,
	AbonoNuevo		money		NULL,
	CargoUNuevo		float		NULL,
	AbonoUNuevo		float		NULL,

	CONSTRAINT priCorregirAuxiliarULista PRIMARY KEY CLUSTERED (ID)
)
go

/*************** spCorregirAuxiliarULista *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCorregirAuxiliarULista') and type = 'P') drop procedure dbo.spCorregirAuxiliarULista
GO             
CREATE PROCEDURE spCorregirAuxiliarULista
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok		 int,
    @ID		 int,
    @CargoNuevo	 money,
    @AbonoNuevo  money,
    @CargoUNuevo float,
    @AbonoUNuevo float

  SELECT @Ok = NULL

  BEGIN TRANSACTION

  DECLARE crLista CURSOR FOR 
   SELECT ID, CargoNuevo, AbonoNuevo, CargoUNuevo, AbonoUNuevo  
     FROM CorregirAuxiliarULista 
  OPEN crLista
  FETCH NEXT FROM crLista INTO @ID, @CargoNuevo, @AbonoNuevo, @CargoUNuevo, @AbonoUNuevo  
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spCorregirAuxiliarU @ID, @CargoNuevo, @AbonoNuevo, @CargoUNuevo, @AbonoUNuevo, @Conexion = 1, @Ok = @Ok OUTPUT

    FETCH NEXT FROM crLista INTO @ID, @CargoNuevo, @AbonoNuevo, @CargoUNuevo, @AbonoUNuevo  
  END
  CLOSE crLista
  DEALLOCATE crLista

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT CONVERT(varchar, COUNT(*))+' Auxiliares Corregidos' FROM CorregirAuxiliarULista 
  END ELSE 
  BEGIN
    ROLLBACK TRANSACTION
    IF @Ok = 1 SELECT 'Mensaje' = 'Fallo al Corregir AuxiliarU', 'ID' = @ID
    IF @Ok = 2 SELECT 'Mensaje' = 'Fallo al Corregir AcumU', 'ID' = @ID
    IF @Ok = 3 SELECT 'Mensaje' = 'Fallo al Corregir SaldoU', 'ID' = @ID
  END

  RETURN
END
GO

/*************** spCorregirAuxiliarRU *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCorregirAuxiliarRU') and type = 'P') drop procedure dbo.spCorregirAuxiliarRU
GO             
CREATE PROCEDURE spCorregirAuxiliarRU
			@ID		int,
			@CargoNuevo	money,
			@AbonoNuevo	money,
			@CargoUNuevo	float,
			@AbonoUNuevo	float,
			@Conexion	bit	= 0,
			@Ok		int	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Empresa		char(5),
    @Sucursal		int,
    @Rama		char(5),
    @Ejercicio		int,
    @Periodo		int,
    @Moneda		char(10),
    @Grupo		char(10),
    @Cuenta		char(20),
    @SubCuenta		varchar(50),
    @CargoAnterior	money,
    @AbonoAnterior	money,
    @CargoUAnterior	float,
    @AbonoUAnterior	float,
    @CargoDif		money,
    @AbonoDif		money,
    @CargoUDif		float,
    @AbonoUDif		float,
    @SaldoDif		money,
    @SaldoUDif		float

  SELECT @Empresa = NULL
  
  SELECT @Empresa       = Empresa,
         @Sucursal	= Sucursal,
	 @Rama          = Rama,
         @Ejercicio     = Ejercicio,
         @Periodo       = Periodo,
         @Moneda        = Moneda,
         @Grupo         = Grupo,
         @Cuenta        = Cuenta,
         @SubCuenta     = SubCuenta,
         @CargoAnterior = ISNULL(Cargo, 0.0),
         @AbonoAnterior = ISNULL(Abono, 0.0),
         @CargoUAnterior = ISNULL(CargoU, 0.0),
         @AbonoUAnterior = ISNULL(AbonoU, 0.0)
    FROM AuxiliarRU
   WHERE ID = @ID
 
  IF @Empresa IS NULL
  BEGIN
    IF @Conexion = 0  
      RAISERROR ('El "ID" No Existe!',16,-1) 
    ELSE SELECT @Ok = 1

    RETURN
  END

  IF @Conexion = 0 
    BEGIN TRANSACTION

    UPDATE AuxiliarRU 
       SET Cargo  = @CargoNuevo,
           Abono  = @AbonoNuevo,
	   CargoU = @CargoUNuevo,
           AbonoU = @AbonoUNuevo
     WHERE ID = @ID
    IF @@ROWCOUNT <> 1 SELECT @Ok = 1 
    
    SELECT @CargoNuevo  = ISNULL(@CargoNuevo, 0.0),
           @AbonoNuevo  = ISNULL(@AbonoNuevo, 0.0),
           @CargoUNuevo = ISNULL(@CargoUNuevo, 0.0),
           @AbonoUNuevo = ISNULL(@AbonoUNuevo, 0.0)

    SELECT @CargoDif  = @CargoNuevo  - @CargoAnterior,
           @AbonoDif  = @AbonoNuevo  - @AbonoAnterior,
           @CargoUDif = @CargoUNuevo - @CargoUAnterior,
           @AbonoUDif = @AbonoUNuevo - @AbonoUAnterior

    SELECT @SaldoDif  = @CargoDif  - @AbonoDif,
           @SaldoUDif = @CargoUDif - @AbonoUDif
     
    UPDATE AcumRU
       SET Cargos = ISNULL(Cargos, 0.0) + @CargoDif,
           Abonos = ISNULL(Abonos, 0.0) + @AbonoDif,
           CargosU = ISNULL(CargosU, 0.0) + @CargoUDif,
           AbonosU = ISNULL(AbonosU, 0.0) + @AbonoUDif
     WHERE Empresa   = @Empresa 
       AND Sucursal  = @Sucursal
       AND Rama      = @Rama
       AND Ejercicio = @Ejercicio
       AND Periodo   = @Periodo
       AND Moneda    = @Moneda
       AND Grupo     = @Grupo
       AND Cuenta    = @Cuenta
       AND SubCuenta = @SubCuenta
    IF @@ROWCOUNT = 0 
      INSERT AcumRU (Cargos,    Abonos,    CargosU,    AbonosU,    Empresa,  Sucursal,  Rama,  Ejercicio,  Periodo,  Moneda,  Grupo,  Cuenta,  SubCuenta)
             VALUES (@CargoDif, @AbonoDif, @CargoUDif, @AbonoUDif, @Empresa, @Sucursal, @Rama, @Ejercicio, @Periodo, @Moneda, @Grupo, @Cuenta, @SubCuenta)
 
    UPDATE SaldoRU
       SET Saldo  = ISNULL(Saldo, 0.0)  + @SaldoDif,
           SaldoU = ISNULL(SaldoU, 0.0) + @SaldoUDif 
     WHERE Empresa   = @Empresa
       AND Sucursal  = @Sucursal
       AND Rama      = @Rama
       AND Moneda    = @Moneda
       AND Grupo     = @Grupo
       AND Cuenta    = @Cuenta
       AND SubCuenta = @SubCuenta
    IF @@ROWCOUNT = 0 
      INSERT SaldoRU (Saldo,     SaldoU,     Empresa,  Sucursal,  Rama,  Moneda,  Grupo,  Cuenta,  SubCuenta)
              VALUES (@SaldoDif, @SaldoUDif, @Empresa, @Sucursal, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta)

  IF @Conexion = 0
  BEGIN
    IF @OK IS NULL
    BEGIN
      COMMIT TRANSACTION
      SELECT "Cargo Anterior"  = @CargoAnterior,  "Cargo Nuevo"  = @CargoNuevo,
             "Abono Anterior"  = @AbonoAnterior,  "Abono Nuevo"  = @AbonoNuevo,
             "ID" = @ID, "Empresa" = @Empresa
      SELECT "CargoU Anterior" = @CargoUAnterior, "CargoU Nuevo" = @CargoUNuevo,
             "AbonoU Anterior" = @AbonoUAnterior, "AbonoU Nuevo" = @AbonoUNuevo
    END ELSE 
    BEGIN
      ROLLBACK TRANSACTION

      IF @Ok = 1 SELECT 'Fallo al Corregir AuxiliarRU'
      IF @Ok = 2 SELECT 'Fallo al Corregir AcumRU'
      IF @Ok = 3 SELECT 'Fallo al Corregir SaldoRU'
    END
  END
  RETURN
END
GO

/* CorregirAuxiliarRULista */
if exists (select * from sysobjects where id = object_id('dbo.CorregirAuxiliarRULista') and sysstat & 0xf = 3) drop table dbo.CorregirAuxiliarRULista
go
CREATE TABLE dbo.CorregirAuxiliarRULista (
	ID			int		NOT NULL,

	CargoNuevo		money		NULL,
	AbonoNuevo		money		NULL,
	CargoUNuevo		float		NULL,
	AbonoUNuevo		float		NULL,

	CONSTRAINT priCorregirAuxiliarRULista PRIMARY KEY CLUSTERED (ID)
)
go

/*************** spCorregirAuxiliarRULista *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCorregirAuxiliarRULista') and type = 'P') drop procedure dbo.spCorregirAuxiliarRULista
GO             
CREATE PROCEDURE spCorregirAuxiliarRULista
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok		 int,
    @ID		 int,
    @CargoNuevo	 money,
    @AbonoNuevo  money,
    @CargoUNuevo float,
    @AbonoUNuevo float

  SELECT @Ok = NULL

  BEGIN TRANSACTION

  DECLARE crLista CURSOR FOR 
   SELECT ID, CargoNuevo, AbonoNuevo, CargoUNuevo, AbonoUNuevo  
     FROM CorregirAuxiliarRULista 
  OPEN crLista
  FETCH NEXT FROM crLista INTO @ID, @CargoNuevo, @AbonoNuevo, @CargoUNuevo, @AbonoUNuevo  
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spCorregirAuxiliarRU @ID, @CargoNuevo, @AbonoNuevo, @CargoUNuevo, @AbonoUNuevo, @Conexion = 1, @Ok = @Ok OUTPUT

    FETCH NEXT FROM crLista INTO @ID, @CargoNuevo, @AbonoNuevo, @CargoUNuevo, @AbonoUNuevo  
  END
  CLOSE crLista
  DEALLOCATE crLista

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT CONVERT(varchar, COUNT(*))+' Auxiliares Corregidos' FROM CorregirAuxiliarRULista 
  END ELSE 
  BEGIN
    ROLLBACK TRANSACTION
    IF @Ok = 1 SELECT 'Mensaje' = 'Fallo al Corregir AuxiliarRU', 'ID' = @ID
    IF @Ok = 2 SELECT 'Mensaje' = 'Fallo al Corregir AcumRU', 'ID' = @ID
    IF @Ok = 3 SELECT 'Mensaje' = 'Fallo al Corregir SaldoRU', 'ID' = @ID
  END

  RETURN
END
GO

/*************** spCorregirRedondeo *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCorregirRedondeo') and type = 'P') drop procedure dbo.spCorregirRedondeo
GO             
CREATE PROCEDURE spCorregirRedondeo
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
   @RedondeoMonetarios		int,
   @WMSAuxiliar	            bit -- TASK1964

  SET NOCOUNT ON
  SELECT @WMSAuxiliar = WMSAuxiliar FROM Version -- TASK1964

  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  update Auxiliar set cargo = round(cargo, @RedondeoMonetarios), abono = round(abono, @RedondeoMonetarios)
  update Acum set cargos = round(cargos, @RedondeoMonetarios), abonos = round(abonos, @RedondeoMonetarios)
  update Saldo set saldo = round(saldo, @RedondeoMonetarios)

  IF @WMSAuxiliar = 1 -- TASK1964
  BEGIN
    update AuxiliarUWMS set cargo = round(cargo, @RedondeoMonetarios), abono = round(abono, @RedondeoMonetarios)
    update AcumUWMS set cargos = round(cargos, @RedondeoMonetarios), abonos = round(abonos, @RedondeoMonetarios)
    update SaldoUWMS set Saldo = round(Saldo, @RedondeoMonetarios)

    update AuxiliarU set cargo = round(cargo, @RedondeoMonetarios), abono = round(abono, @RedondeoMonetarios)
    update AcumU set cargos = round(cargos, @RedondeoMonetarios), abonos = round(abonos, @RedondeoMonetarios)
    update SaldoU set Saldo = round(Saldo, @RedondeoMonetarios)
  END ELSE BEGIN -- TASK1964
	EXEC dbo.sp_executesql N' 
      update AuxiliarU set cargo = round(cargo, @RedondeoMonetarios), abono = round(abono, @RedondeoMonetarios)
      update AcumU set cargos = round(cargos, @RedondeoMonetarios), abonos = round(abonos, @RedondeoMonetarios)
      update SaldoU set Saldo = round(Saldo, @RedondeoMonetarios)',
	  N'@RedondeoMonetarios int', @RedondeoMonetarios
  END -- TASK1964

  update AuxiliarRU set cargo = round(cargo, @RedondeoMonetarios), abono = round(abono, @RedondeoMonetarios)
  update AcumRU set cargos = round(cargos, @RedondeoMonetarios), abonos = round(abonos, @RedondeoMonetarios)
  update SaldoRU set saldo = round(saldo, @RedondeoMonetarios)
  update Cxc set importe = round(importe, @RedondeoMonetarios), impuestos = round(impuestos, @RedondeoMonetarios), saldo = round(saldo, @RedondeoMonetarios)
  update Cxp set importe = round(importe, @RedondeoMonetarios), impuestos = round(impuestos, @RedondeoMonetarios), saldo = round(saldo, @RedondeoMonetarios)
  update Gasto set importe = round(importe, @RedondeoMonetarios), impuestos = round(impuestos, @RedondeoMonetarios), saldo = round(saldo, @RedondeoMonetarios)
  update Venta set importe = round(importe, @RedondeoMonetarios), impuestos = round(impuestos, @RedondeoMonetarios), saldo = round(saldo, @RedondeoMonetarios)
  update Compra set importe = round(importe, @RedondeoMonetarios), impuestos = round(impuestos, @RedondeoMonetarios), saldo = round(saldo, @RedondeoMonetarios)

  RETURN
END
GO


/************** spReAfectarLote ***************/
if exists (select * from sysobjects where id = object_id('dbo.spReAfectarLote') and type = 'P') drop procedure dbo.spReAfectarLote
GO
CREATE PROCEDURE spReAfectarLote
		      @Empresa 	char(5),
                      @Modulo  	char(5),
 		      @Mov     	char(20),
		      @Estatus	char(15),
		      @DelMovID	int,
		      @AlMovID	int
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
     @Usuario		char(10),
     @Ok		int,
     @MovEstatus 	char(15),
     @Cuantos 		int,
     @ID 		int

  CREATE TABLE #ID (
     ID		int 	 NOT NULL,
     Usuario	char(10) COLLATE Database_Default NULL,

     CONSTRAINT priTempID PRIMARY KEY CLUSTERED (ID)
  )
  
  IF @Modulo = 'CONT' DECLARE crModulo CURSOR FOR SELECT ID, Usuario, Estatus  FROM Cont       WHERE Empresa = @Empresa AND Estatus = @Estatus AND Mov = @Mov AND MovID BETWEEN @DelMovID AND @AlMovID ELSE
  IF @Modulo = 'CI'   DECLARE crModulo CURSOR FOR SELECT ID, Usuario, Estatus  FROM CI         WHERE Empresa = @Empresa AND Estatus = @Estatus AND Mov = @Mov AND MovID BETWEEN @DelMovID AND @AlMovID ELSE
  IF @Modulo = 'AF'   DECLARE crModulo CURSOR FOR SELECT ID, Usuario, Estatus  FROM ActivoFijo WHERE Empresa = @Empresa AND Estatus = @Estatus AND Mov = @Mov AND MovID BETWEEN @DelMovID AND @AlMovID 
  ELSE BEGIN
    RAISERROR ('Modulo Incorrecto',16,-1) 
    RETURN
  END 
  SELECT @Cuantos = 0, @Ok = NULL

  OPEN crModulo
  FETCH NEXT FROM crModulo INTO @ID, @Usuario, @MovEstatus
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @MovEstatus = @Estatus
      BEGIN
        EXEC spAfectar @Modulo, @ID, 'CANCELAR', NULL, NULL, @Usuario

	IF @Modulo = 'CONT' SELECT @MovEstatus = Estatus FROM Cont 	 WHERE ID = @ID ELSE
	IF @Modulo = 'CI'   SELECT @MovEstatus = Estatus FROM CI 	 WHERE ID = @ID ELSE
  	IF @Modulo = 'AF'   SELECT @MovEstatus = Estatus FROM ActivoFijo WHERE ID = @ID 
        IF @MovEstatus <> 'CANCELADO' 
          SELECT @Ok = @ID
        ELSE INSERT #ID (ID, Usuario) VALUES (@ID, @Usuario)
      END ELSE SELECT @Ok = @ID
    END
    FETCH NEXT FROM crModulo INTO @ID, @Usuario, @MovEstatus
  END
  CLOSE crModulo
  DEALLOCATE crModulo

  IF @Modulo = 'CONT' UPDATE Cont 	SET Estatus = 'SINAFECTAR' WHERE ID IN (SELECT ID FROM #ID) ELSE
  IF @Modulo = 'CI'   UPDATE CI    	SET Estatus = 'SINAFECTAR' WHERE ID IN (SELECT ID FROM #ID) ELSE
  IF @Modulo = 'AF'   UPDATE ActivoFijo SET Estatus = 'SINAFECTAR' WHERE ID IN (SELECT ID FROM #ID) 

  DECLARE crID CURSOR FOR
   SELECT ID, Usuario FROM #ID
  OPEN crID
  FETCH NEXT FROM crID INTO @ID, @Usuario
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spAfectar @Modulo, @ID, NULL, NULL, NULL, @Usuario
    END
    FETCH NEXT FROM crID INTO @ID, @Usuario
  END
  CLOSE crID
  DEALLOCATE crID

  IF @Ok IS NOT NULL
    SELECT "ID con Error", @Ok
  ELSE
    SELECT "Reprocesamiento con Exito"

  RETURN
END
GO

/*************** spEliminarReservados *******************/
if exists (select * from sysobjects where id = object_id('dbo.spEliminarReservados') and type = 'P') drop procedure dbo.spEliminarReservados
GO             
CREATE PROCEDURE spEliminarReservados
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  UPDATE VentaD 
     SET CantidadPendiente = ISNULL(CantidadPendiente, 0) + ISNULL(CantidadReservada, 0),
         CantidadReservada = NULL
   WHERE ISNULL(CantidadReservada, 0) <> 0.0
  UPDATE InvD 
     SET CantidadPendiente = ISNULL(CantidadPendiente, 0) + ISNULL(CantidadReservada, 0),
         CantidadReservada = NULL
   WHERE ISNULL(CantidadReservada, 0) <> 0.0


  DELETE AuxiliarU WHERE Rama = 'RESV'
  DELETE AcumU WHERE Rama = 'RESV'
  DELETE SaldoU WHERE Rama = 'RESV'
  RETURN
END
GO


/*************** spRespaldarReservados *******************/
if exists (select * from sysobjects where id = object_id('dbo.spRespaldarReservados') and type = 'P') drop procedure dbo.spRespaldarReservados
GO             
CREATE PROCEDURE spRespaldarReservados
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  UPDATE VentaD SET CantidadA = NULL WHERE CantidadA IS NOT NULL
  UPDATE InvD   SET CantidadA = NULL WHERE CantidadA IS NOT NULL

  UPDATE VentaD 
     SET CantidadPendiente = ISNULL(CantidadPendiente, 0) + ISNULL(CantidadReservada, 0),
         CantidadA         = CantidadReservada,
         CantidadReservada = NULL
   WHERE ISNULL(CantidadReservada, 0) <> 0.0
  UPDATE InvD 
     SET CantidadPendiente = ISNULL(CantidadPendiente, 0) + ISNULL(CantidadReservada, 0),
         CantidadA         = CantidadReservada,
         CantidadReservada = NULL
   WHERE ISNULL(CantidadReservada, 0) <> 0.0

  UPDATE AuxiliarU SET Rama = 'RRESV' WHERE Rama = 'RESV'
  UPDATE AcumU     SET Rama = 'RRESV' WHERE Rama = 'RESV'
  UPDATE SaldoU    SET Rama = 'RRESV' WHERE Rama = 'RESV'
  RETURN
END
GO


/*************** spRestaurarReservados *******************/
if exists (select * from sysobjects where id = object_id('dbo.spRestaurarReservados') and type = 'P') drop procedure dbo.spRestaurarReservados
GO             
CREATE PROCEDURE spRestaurarReservados
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  UPDATE VentaD 
     SET CantidadPendiente = ISNULL(CantidadPendiente, 0) - ISNULL(CantidadA, 0),
         CantidadA         = NULL,
         CantidadReservada = CantidadA
   WHERE ISNULL(CantidadA, 0) <> 0.0
  UPDATE InvD 
     SET CantidadPendiente = ISNULL(CantidadPendiente, 0) - ISNULL(CantidadA, 0),
         CantidadA         = NULL,
         CantidadReservada = CantidadA
   WHERE ISNULL(CantidadA, 0) <> 0.0

  UPDATE AuxiliarU SET Rama = 'RESV' WHERE Rama = 'RRESV'
  UPDATE AcumU     SET Rama = 'RESV' WHERE Rama = 'RRESV'
  UPDATE SaldoU    SET Rama = 'RESV' WHERE Rama = 'RRESV'
  RETURN
END
GO

-- spReAfectarLote 'DEMO', 'VTAS', 'Factura', 'CONCLUIDO', 19, 19

-- spFueraLineaC 'DEMO', 6, 'VTAS', 'Nota'

/*************** spFueraLineaC *******************/
if exists (select * from sysobjects where id = object_id('dbo.spFueraLineaC') and type = 'P') drop procedure dbo.spFueraLineaC
GO             
CREATE PROCEDURE spFueraLineaC
		    @Empresa	char(5),
		    @Sucursal	int,
		    @Modulo	char(5),
		    @Mov	char(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Consecutivo	int,
    @Prefijo		varchar(10)

  UPDATE FueraLineaC SET @Consecutivo = Consecutivo = Consecutivo + 1 WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov
  IF @@ROWCOUNT = 0
  BEGIN
    INSERT FueraLineaC (Empresa, Modulo, Mov, Consecutivo) VALUES (@Empresa, @Modulo, @Mov, 1)
    SELECT @Consecutivo = 1
  END
  SELECT @Prefijo = ISNULL(RTRIM(Prefijo), '') FROM Sucursal WHERE Sucursal = @Sucursal

  SELECT "MovID" = @Prefijo + CONVERT(varchar, @Consecutivo)+'FL'
END
GO


/************** spSincroConteoRegistros ***************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroConteoRegistros') and type = 'P') drop procedure dbo.spSincroConteoRegistros
GO
CREATE PROCEDURE spSincroConteoRegistros
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @SysTabla	varchar(100)

  SELECT SysTabla, "Conteo" = CONVERT(int, NULL)
    INTO #Conteo
    FROM SysTabla 
   WHERE Tipo <> 'N/A'

  DECLARE crConteo CURSOR FOR
   SELECT SysTabla FROM #Conteo
  OPEN crConteo
  FETCH NEXT FROM crConteo INTO @SysTabla
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF exists (select * from sysobjects where id = object_id(@SysTabla) and type = 'U') 
        EXEC("UPDATE #Conteo SET Conteo = (SELECT COUNT(*) FROM "+@SysTabla+") WHERE CURRENT OF crConteo")    
    END
    FETCH NEXT FROM crConteo INTO @SysTabla
  END
  CLOSE crConteo
  DEALLOCATE crConteo
  SELECT * FROM #Conteo

  RETURN
END
GO

-- spRecostearMovimientos 'DEMO', '1/1/3', '31/12/3', 'ESTANDAR', 'VTAS', @Mov = 'Factura', @Linea = 'xxx'
/*************** spRecostearMovimientos *******************/
if exists (select * from sysobjects where id = object_id('dbo.spRecostearMovimientos') and type = 'P') drop procedure dbo.spRecostearMovimientos
GO             
CREATE PROCEDURE spRecostearMovimientos
		    @Empresa		char(5),
		    @FechaD		datetime,
		    @FechaA		datetime,
		    @TipoCosteo		varchar(20),	-- Estandar, Reposicion
		    @Modulo		char(5),

		    @Mov		char(20)    = NULL,
		    @Almacen		char(10)    = NULL,
		    @Articulo		char(20)    = NULL,
		    @Categoria    	varchar(50) = NULL,
		    @Grupo	    	varchar(50) = NULL,
		    @Familia	    	varchar(50) = NULL,
		    @Fabricante    	varchar(50) = NULL,
		    @Linea	    	varchar(50) = NULL,
		    @Temporada    	varchar(50) = NULL,
		    @Proveedor		char(10)    = NULL,
		    @Sucursal		int	    = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ModuloID		int,
    @SubCuenta		varchar(50),
    @Cantidad		float, 
    @CostoA		money,
    @CostoN		money,
    @CostoNTotal 	money,
    @Moneda		char(10),
    @AuxiliarID		int,
    @Cargo		money,
    @CargoN		money,
    @Abono		money,
    @AbonoN		money,
    @CargoU		float,
    @AbonoU		float

  SELECT @TipoCosteo = UPPER(@TipoCosteo),
         @Mov = NULLIF(NULLIF(RTRIM(@Mov), '0'), ''), 
         @Almacen = NULLIF(NULLIF(RTRIM(@Almacen), '0'), ''), 
         @Articulo = NULLIF(NULLIF(RTRIM(@Articulo), '0'), ''), 
         @Categoria = NULLIF(NULLIF(RTRIM(@Categoria), '0'), ''), 
         @Grupo = NULLIF(NULLIF(RTRIM(@Grupo), '0'), ''), 
         @Familia = NULLIF(NULLIF(RTRIM(@Familia), '0'), ''), 
         @Linea = NULLIF(NULLIF(RTRIM(@Linea), '0'), ''), 
         @Temporada = NULLIF(NULLIF(RTRIM(@Temporada), '0'), ''), 
         @Proveedor = NULLIF(NULLIF(RTRIM(@Proveedor), '0'), ''), 
         @Sucursal = NULLIF(@Sucursal, 0)

  CREATE TABLE #ID (ID int NOT NULL PRIMARY KEY)
  IF @Modulo = 'VTAS' 
    DECLARE crMovD CURSOR FOR 
     SELECT e.Mov, d.Almacen, d.ID, d.Articulo, NULLIF(RTRIM(d.SubCuenta), ''), ISNULL(d.CantidadInventario, d.Cantidad), d.Costo, a.MonedaCosto
       FROM Venta e, VentaD d, Art a
      WHERE d.ID = e.ID AND e.Empresa = @Empresa AND e.FechaEmision BETWEEN @FechaD AND @FechaA AND d.Articulo = a.Articulo
        AND ISNULL(e.Mov, '') = ISNULL(ISNULL(@Mov, e.Mov) , '') AND ISNULL(d.Almacen, '') = ISNULL(ISNULL(@Almacen, d.Almacen) , '') AND ISNULL(a.Articulo, '') = ISNULL(ISNULL(@Articulo, a.Articulo) , '') AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@Proveedor, a.Proveedor), '') AND e.Sucursal = ISNULL(@Sucursal, e.Sucursal)
  IF @Modulo = 'INV' 
    DECLARE crMovD CURSOR FOR 
     SELECT e.Mov, d.Almacen, d.ID, d.Articulo, NULLIF(RTRIM(d.SubCuenta), ''), ISNULL(d.CantidadInventario, d.Cantidad), d.Costo, a.MonedaCosto
       FROM Inv e, InvD d, Art a
      WHERE d.ID = e.ID AND e.Empresa = @Empresa AND e.FechaEmision BETWEEN @FechaD AND @FechaA AND d.Articulo = a.Articulo
        AND ISNULL(e.Mov, '') = ISNULL(ISNULL(@Mov, e.Mov) , '') AND ISNULL(d.Almacen, '') = ISNULL(ISNULL(@Almacen, d.Almacen) , '') AND ISNULL(a.Articulo, '') = ISNULL(ISNULL(@Articulo, a.Articulo) , '') AND ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@Proveedor, a.Proveedor), '') AND e.Sucursal = ISNULL(@Sucursal, e.Sucursal)

  OPEN crMovD
  FETCH NEXT FROM crMovD INTO @Mov, @Almacen, @ModuloID, @Articulo, @SubCuenta, @Cantidad, @CostoA, @Moneda
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF NOT EXISTS(SELECT * FROM #ID WHERE ID = @ModuloID)
        INSERT #ID (ID) VALUES (@ModuloID)

      SELECT @CostoN = NULL
      IF @SubCuenta IS NOT NULL
        SELECT @CostoN = CASE @TipoCosteo WHEN 'ESTANDAR' THEN CostoEstandar WHEN 'REPOSICION' THEN CostoReposicion END
          FROM ArtSub
         WHERE Articulo = @Articulo
           AND SubCuenta = @SubCuenta
      IF @CostoN IS NULL
        SELECT @CostoN = CASE @TipoCosteo WHEN 'ESTANDAR' THEN CostoEstandar WHEN 'REPOSICION' THEN CostoReposicion END
          FROM Art
         WHERE Articulo = @Articulo

      IF @Modulo = 'VTAS' UPDATE VentaD SET Costo = @CostoN WHERE CURRENT OF crMovD ELSE
      IF @Modulo = 'INV'  UPDATE InvD   SET Costo = @CostoN WHERE CURRENT OF crMovD

      DECLARE crAuxiliarU CURSOR LOCAL FOR 
       SELECT ID, Cargo, Abono, CargoU, AbonoU
         FROM AuxiliarU
        WHERE Empresa = @Empresa AND Rama = 'INV' AND Mov = @Mov AND @Modulo = @Modulo AND ModuloID = @ModuloID AND Moneda = @Moneda
      OPEN crAuxiliarU
      FETCH NEXT FROM crAuxiliarU INTO @AuxiliarID, @Cargo, @Abono, @CargoU, @AbonoU
      WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @CargoN = @Cargo, @AbonoN = @Abono
          SELECT @CostoNTotal = @Cantidad*@CostoN
          IF ISNULL(@CargoU, 0) <> 0 AND @Cargo <> @CostoNTotal SELECT @CargoN = @CostoNTotal
          IF ISNULL(@AbonoU, 0) <> 0 AND @Abono <> @CostoNTotal SELECT @AbonoN = @CostoNTotal
          IF @Cargo <> @CargoN OR @Abono <> @AbonoN
            EXEC spCorregirAuxiliarU @AuxiliarID, @CargoN, @AbonoN, @CargoU, @AbonoU
        END
        FETCH NEXT FROM crAuxiliarU INTO @AuxiliarID, @Cargo, @Abono, @CargoU, @AbonoU
      END
      CLOSE crAuxiliarU
      DEALLOCATE crAuxiliarU
    END
    FETCH NEXT FROM crMovD INTO @Mov, @Almacen, @ModuloID, @Articulo, @SubCuenta, @Cantidad, @CostoA, @Moneda
  END
  CLOSE crMovD
  DEALLOCATE crMovD

  IF @Modulo = 'VTAS' 
    UPDATE Venta 
       SET CostoTotal = (SELECT SUM(d.Costo*d.Cantidad) FROM VentaD d WHERE d.ID = v.ID)
      FROM Venta v
     WHERE v.ID IN (SELECT ID FROM #ID)

  SELECT 'Proceso Concluido'
END
GO

-- EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
/*************** spValidarTareas *******************/
if exists (select * from sysobjects where id = object_id('dbo.spValidarTareas') and type = 'P') drop procedure dbo.spValidarTareas
GO             
CREATE PROCEDURE spValidarTareas
			@Empresa	char(5),
			@Modulo		char(5),
			@ID		int,
			@EstatusNuevo	char(15),
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @EstatusNuevo = 'CONCLUIDO'
  BEGIN
    IF EXISTS(SELECT * FROM Tarea WHERE Modulo = @Modulo AND ModuloID = @ID AND Forzosa = 1 AND UPPER(Estado) NOT IN ('COMPLETADA', 'CANCELADA'))
      SELECT @Ok = 20495
  END ELSE
  IF @EstatusNuevo = 'CANCELADO'
  BEGIN
    IF EXISTS(SELECT * FROM Tarea WHERE Modulo = @Modulo AND ModuloID = @ID AND Forzosa = 1 AND UPPER(Estado) NOT IN ('COMPLETADA','NO COMENZADA', 'CANCELADA'))/*Falta incluir el estado 'COMPLETADO'*/
      SELECT @Ok = 20495
  END 
  IF @Ok = 20495 
    SELECT @OkRef = RTRIM(Mov)+' '+RTRIM(MovID) FROM Mov WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID

  RETURN
END
GO

/*************** spSerieLoteAutorizar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spSerieLoteAutorizar') and type = 'P') drop procedure dbo.spSerieLoteAutorizar
GO             
CREATE PROCEDURE spSerieLoteAutorizar
			@Empresa	char(5),
			@SerieLote	varchar(50),
			@Usuario	char(10)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Usuario = NULLIF(NULLIF(RTRIM(@Usuario), ''), '0')
  UPDATE SerieLoteAutorizacion SET Autorizacion = @Usuario WHERE Empresa = @Empresa AND SerieLote = @SerieLote
  IF @@ROWCOUNT = 0
    INSERT SerieLoteAutorizacion (Empresa, SerieLote, Autorizacion) VALUES (@Empresa, @SerieLote, @Usuario)
  RETURN
END
GO

/*************** spSerieLoteTransferir *******************/
if exists (select * from sysobjects where id = object_id('dbo.spSerieLoteTransferir') and type = 'P') drop procedure dbo.spSerieLoteTransferir
GO             
CREATE PROCEDURE spSerieLoteTransferir
			@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@FechaEmision	datetime,
    			@Articulo	char(20),
			@Almacen	char(10),
			@AlmacenDestino	char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID				int,
    @Mov			char(20),
    @MovID			varchar(20),
    @Moneda			char(10),
    @TipoCambio			float,
    @AlmacenSucursal		int,
    @AlmacenDestinoSucursal	int,
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @Renglon			float,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @SubCuenta			varchar(20),
    @Cantidad			float,
    @CantidadInventario		float,
    @ArtTipo			varchar(20),
    @Unidad			varchar(50),
    @FechaRegistro		datetime,
    @Ok				int,
    @OkRef			varchar(255)

  SELECT @AlmacenSucursal = NULL, @AlmacenDestinoSucursal = NULL, @Ok = NULL, @OkRef = NULL,
         @Articulo = NULLIF(NULLIF(RTRIM(@Articulo), '0'), '')
  SELECT @AlmacenSucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
  SELECT @AlmacenDestinoSucursal = Sucursal FROM Alm WHERE Almacen = @AlmacenDestino
  IF (@Almacen = @AlmacenDestino) OR @AlmacenSucursal IS NULL OR @AlmacenDestinoSucursal IS NULL RETURN
  
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @CfgMultiUnidades      = MultiUnidades,
	 @CfgMultiUnidadesNivel = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  SELECT @Mov = CASE WHEN @AlmacenSucursal = @AlmacenDestinoSucursal THEN InvTransferencia ELSE InvSalidaTraspaso END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
  
  INSERT Inv (Sucursal,         Empresa,  Usuario,  Estatus,      Mov,  FechaEmision,  Moneda,  TipoCambio,  Almacen,  AlmacenDestino)
  SELECT      @AlmacenSucursal, @Empresa, @Usuario, 'SINAFECTAR', @Mov, @FechaEmision, @Moneda, @TipoCambio, @Almacen, @AlmacenDestino
  SELECT @ID = SCOPE_IDENTITY(), @Renglon = 0.0, @RenglonID = 0

  DECLARE crSerieLoteEstatus CURSOR FOR
   SELECT Articulo, SubCuenta, SUM(Existencia)
     FROM SerieLoteEstatus
    WHERE Empresa = @Empresa AND Estatus IN ('APROBADO', 'AUTORIZADO') AND Articulo = ISNULL(@Articulo, Articulo) AND Almacen=@Almacen
    GROUP BY Articulo, SubCuenta
    ORDER BY Articulo, SubCuenta
  OPEN crSerieLoteEstatus
  FETCH NEXT FROM crSerieLoteEstatus INTO @Articulo, @SubCuenta, @Cantidad
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND ISNULL(@Cantidad, 0) > 0
    BEGIN
      SELECT @ArtTipo = Tipo, @Unidad = ISNULL(UnidadTraspaso, Unidad) FROM Art WHERE Articulo = @Articulo
      EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
      EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

      SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
      INSERT InvD (Sucursal,         ID,  Renglon,  RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Almacen,  Cantidad,  Unidad,  CantidadInventario)
           VALUES (@AlmacenSucursal, @ID, @Renglon, @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Almacen, @Cantidad, @Unidad, @CantidadInventario)

      INSERT SerieLoteMov 
             (Empresa, Modulo, ID,  RenglonID,  Articulo,  SubCuenta,              SerieLote, Cantidad,   CantidadAlterna)
      SELECT @Empresa, 'INV',  @ID, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), SerieLote, Existencia, ExistenciaAlterna
        FROM SerieLoteEstatus
       WHERE Empresa = @Empresa AND Estatus IN ('APROBADO', 'AUTORIZADO') AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Almacen=@Almacen
    END
    FETCH NEXT FROM crSerieLoteEstatus INTO @Articulo, @SubCuenta, @Cantidad
  END
  CLOSE crSerieLoteEstatus
  DEALLOCATE crSerieLoteEstatus

  IF EXISTS(SELECT * FROM InvD WHERE ID = @ID)
  BEGIN
    SELECT @FechaRegistro = GETDATE()
    EXEC spInv @ID, 'INV', 'AFECTAR', 'TODO', @FechaRegistro, @Mov, @Usuario, 0, 0, NULL, 
                     @Mov, @MovID OUTPUT, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT, NULL
    IF @Ok IS NULL
        SELECT 'Se Generaro con Exito '+RTRIM(@Mov)+' '+RTRIM(@MovID)
    ELSE
      SELECT RTRIM(Descripcion)+' '+RTRIM(@OkRef) FROM MensajeLista WHERE Mensaje = @Ok  
  END ELSE
  BEGIN
    DELETE Inv WHERE ID = @ID
    SELECT 'No Hay Nada Que Transferir'
  END

  RETURN
END
GO
/*************** spInfoPathRegistrar *******************/
--if exists (select * from sysobjects where id = object_id('dbo.spInfoPathRegistrar') and type = 'P') drop procedure dbo.spInfoPathRegistrar
GO             
/*CREATE PROCEDURE spInfoPathRegistrar
			@Sesion		int,
			@Nombre		varchar(100),
			@Referencia	varchar(255)
--//WITH ENCRYPTION
AS BEGIN

  RETURN
END*/
GO

/*************** spInfoPathDatos *******************/
--if exists (select * from sysobjects where id = object_id('dbo.spInfoPathDatos') and type = 'P') drop procedure dbo.spInfoPathDatos
GO             
/*CREATE PROCEDURE spInfoPathDatos
			@Sesion		int,
			@Referencia	varchar(255)
--//WITH ENCRYPTION
AS BEGIN

  RETURN
END*/
GO


-- use acuarioh
/*************** spMovMover *******************/
if exists (select * from sysobjects where id = object_id('dbo.spMovMover') and type = 'P') drop procedure dbo.spMovMover
GO             
CREATE PROCEDURE spMovMover
		    @Estacion	int,
		    @Empresa	char(5),
		    @Sucursal	int,
		    @Modulo	char(5),
		    @BaseDatos	varchar(255),
                    @Error	int	= 0 OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla		varchar(50),
    @TieneIdentity	bit,
    @IdentityOn		varchar(255),
    @IdentityOff	varchar(255),
    @EstacionSt		varchar(20),
    @Campos		varchar(4000)

  SELECT @EstacionSt = CONVERT(varchar(20), @Estacion)

  BEGIN TRANSACTION 

  DECLARE crTablasModulo CURSOR LOCAL FOR
   SELECT Tabla, Campos, TieneIdentity
     FROM #MovMoverTabla

  OPEN crTablasModulo
  FETCH NEXT FROM crTablasModulo INTO @Tabla, @Campos, @TieneIdentity
  WHILE @@FETCH_STATUS <> -1 AND @Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @TieneIdentity = 1
        SELECT @IdentityOn = 'SET IDENTITY_INSERT '+@Tabla+' ON', @IdentityOff = 'SET IDENTITY_INSERT '+@Tabla+' OFF'
      ELSE
        SELECT @IdentityOn = '', @IdentityOff = ''
      EXEC('BEGIN TRANSACTION '+@IdentityOn+' ALTER TABLE '+@Tabla+' DISABLE TRIGGER ALL INSERT '+@Tabla+' ('+@Campos+') SELECT '+@Campos +' FROM '+@BaseDatos+'.dbo.'+@Tabla+' WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = '+@EstacionSt+') ALTER TABLE '+@Tabla+' ENABLE TRIGGER ALL '+@IdentityOff+' IF @@Error = 0 COMMIT TRANSACTION ELSE ROLLBACK TRANSACTION')
      SELECT @Error = @@Error
    END
    FETCH NEXT FROM crTablasModulo INTO @Tabla, @Campos, @TieneIdentity
  END
  CLOSE crTablasModulo
  DEALLOCATE crTablasModulo

  IF @Error = 0
    UPDATE Mov SET Fuera = 0 WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Modulo = @Modulo AND ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)

  IF @Error = 0
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION
END
GO

/*************** spMovFuera *******************/
if exists (select * from sysobjects where id = object_id('dbo.spMovFuera') and type = 'P') drop procedure dbo.spMovFuera
GO             
CREATE PROCEDURE spMovFuera
		    @Estacion	int,
		    @Empresa	char(5),
		    @Sucursal	int,
		    @Modulo	char(5),
                    @Error	int	= 0 OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla		varchar(100),
    @EstacionSt		varchar(20)

  SELECT @EstacionSt = CONVERT(varchar(20), @Estacion)

  BEGIN TRANSACTION 

  DECLARE crTablasModulo CURSOR LOCAL FOR
   SELECT Tabla
     FROM #MovMoverTabla

  OPEN crTablasModulo
  FETCH NEXT FROM crTablasModulo INTO @Tabla
  WHILE @@FETCH_STATUS <> -1 AND @Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC('BEGIN TRANSACTION ALTER TABLE '+@Tabla+' DISABLE TRIGGER ALL DELETE '+@Tabla+' WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = '+@EstacionSt+') ALTER TABLE '+@Tabla+' ENABLE TRIGGER ALL IF @@Error = 0 COMMIT TRANSACTION ELSE ROLLBACK TRANSACTION')
      SELECT @Error = @@Error
    END
    FETCH NEXT FROM crTablasModulo INTO @Tabla
  END
  CLOSE crTablasModulo
  DEALLOCATE crTablasModulo

  IF @Error = 0
    UPDATE Mov SET Fuera = 1 WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Modulo = @Modulo AND ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)

  IF @Error = 0
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION
END
GO

/*************** spMovMoverLote *******************/
if exists (select * from sysobjects where id = object_id('dbo.spMovMoverLote') and type = 'P') drop procedure dbo.spMovMoverLote
GO             
CREATE PROCEDURE spMovMoverLote
		    @Estacion		int,
		    @Empresa		char(5),
		    @Sucursal		int,
		    @Modulo		char(5),
		    @Mov		varchar(20),
		    @Ejercicio		int,
		    @Periodo		int,
		    @Fuera		bit,
		    @BaseDatos		varchar(255),
		    @BaseDatosHistorico	varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EstacionSt		varchar(20),
    @SucursalSt		varchar(20),
    @EjercicioSt	varchar(20),    
    @PeriodoSt		varchar(20),
    @Tabla		varchar(50),
    @TieneIdentity	bit,
    @Mensaje		varchar(255),
    @Error		int

  SELECT @Error = 0
  SELECT @EstacionSt = CONVERT(varchar(20), @Estacion), @SucursalSt = CONVERT(varchar(20), @Sucursal), @EjercicioSt = CONVERT(varchar(20), @Ejercicio), @PeriodoSt = CONVERT(varchar(20), @Periodo)

  CREATE TABLE #MovMoverTabla (
     Tabla		varchar(50)	COLLATE Database_Default NOT NULL PRIMARY KEY,
     TieneIdentity	bit		NULL,
     Campos		varchar(3990)	COLLATE Database_Default NULL,
     CamposHistorico	varchar(3990)	COLLATE Database_Default NULL)

  DECLARE crSysTabla CURSOR LOCAL FOR
   SELECT RTRIM(SysTabla)
     FROM SysTabla
    WHERE Modulo = @Modulo

  OPEN crSysTabla
  FETCH NEXT FROM crSysTabla INTO @Tabla
  WHILE @@FETCH_STATUS <> -1 AND @Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @TieneIdentity = OBJECTPROPERTY(OBJECT_ID(@Tabla), 'TableHasIdentity')
      INSERT #MovMoverTabla (Tabla, TieneIdentity, Campos)
      SELECT @Tabla, @TieneIdentity, dbo.fnCamposTabla(@Tabla)
      EXEC('UPDATE #MovMoverTabla SET CamposHistorico = '+@BaseDatosHistorico+'.dbo.fnCamposTabla("'+@Tabla+'") WHERE Tabla="'+@Tabla+'"')
      SELECT @Error = @@Error
    END
    FETCH NEXT FROM crSysTabla INTO @Tabla
  END
  CLOSE crSysTabla
  DEALLOCATE crSysTabla

  SELECT @Tabla = NULL
  SELECT @Tabla = MIN(Tabla) FROM #MovMoverTabla WHERE LEN(Campos) <> LEN(CamposHistorico)
  IF @Tabla IS NOT NULL
  BEGIN
    SELECT @Mensaje = 'No Cuadran los Campos de la Tabla '+@Tabla
    RAISERROR (@Mensaje, 16, -1) 
    RETURN
  END

  IF @Error = 1 RETURN

  UPDATE Version SET MovMover = 1
  EXEC('UPDATE '+@BaseDatosHistorico+'.dbo.Version SET MovMover = 1')
  DELETE ListaID WHERE Estacion = @Estacion  
  EXEC('DELETE '+@BaseDatosHistorico+'.dbo.ListaID WHERE Estacion = '+@EstacionSt)

  IF @Fuera = 1
  BEGIN
    INSERT ListaID (Estacion, ID) SELECT @Estacion, ID FROM Mov WITH (INDEX(MovMover)) WHERE Fuera = 0 AND Empresa = @Empresa AND Sucursal = @Sucursal AND Modulo = @Modulo AND Mov = @Mov AND Ejercicio = @Ejercicio AND Periodo = @Periodo AND (SELECT dbo.fnMovEstatus(@Modulo, ID)) IN ('CONCLUIDO', 'CANCELADO')
    EXEC('INSERT '+@BaseDatosHistorico+'.dbo.ListaID (Estacion, ID) SELECT '+@EstacionSt+', ID FROM Mov WHERE Fuera = 0 AND Empresa = "'+@Empresa+'" AND Sucursal = '+@SucursalSt+' AND Modulo = "'+@Modulo+'" AND Mov = "'+@Mov+'" AND Ejercicio = '+@EjercicioSt+' AND Periodo = '+@PeriodoSt+'AND (SELECT dbo.fnMovEstatus("'+@Modulo+'", ID)) IN ("CONCLUIDO", "CANCELADO")')
    EXEC(@BaseDatosHistorico+'.dbo.spMovMover '+@EstacionSt+', "'+@Empresa+'", '+@SucursalSt+', "'+@Modulo+'", "'+@BaseDatos+'"')
    SELECT @Error = @@Error
    IF @Error = 0
      EXEC spMovFuera @Estacion, @Empresa, @Sucursal, @Modulo, @Error OUTPUT
  END ELSE
  BEGIN
    INSERT ListaID (Estacion, ID) SELECT @Estacion, ID FROM Mov WITH (INDEX(MovMover)) WHERE Fuera = 1 AND Empresa = @Empresa AND Sucursal = @Sucursal AND Modulo = @Modulo AND Mov = @Mov AND Ejercicio = @Ejercicio AND Periodo = @Periodo 
    EXEC('INSERT '+@BaseDatosHistorico+'.dbo.ListaID (Estacion, ID) SELECT '+@EstacionSt+', ID FROM Mov WHERE Fuera = 1 AND Empresa = "'+@Empresa+'" AND Sucursal = '+@SucursalSt+' AND Modulo = "'+@Modulo+'" AND Mov = "'+@Mov+'" AND Ejercicio = '+@EjercicioSt+' AND Periodo = '+@PeriodoSt)
    EXEC spMovMover @Estacion, @Empresa, @Sucursal, @Modulo, @BaseDatosHistorico, @Error OUTPUT
    IF @Error = 0
      EXEC(@BaseDatosHistorico+'.dbo.spMovFuera '+@EstacionSt+', "'+@Empresa+'", '+@SucursalSt+', "'+@Modulo+'"')
  END

  UPDATE Version SET MovMover = 0
  EXEC('UPDATE '+@BaseDatosHistorico+'.dbo.Version SET MovMover = 0')
END
GO

/*************** spSMS *******************/
if exists (select * from sysobjects where id = object_id('dbo.spSMS') and type = 'P') drop procedure dbo.spSMS
GO             
CREATE PROCEDURE spSMS
        		@ReciboFecha       datetime,
        		@ReciboMensaje     varchar(147),
        		@Telefono          varchar(20)
 --//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal		int,
    @ID			int,
    @Mov		varchar(20),
    @Modulo		char(5),
    @ModuloID		int, 
    @Orden		int,
    @OrdenSiguiente	int,
    @Estatus		varchar(15),
    @Usuario		varchar(10),
    @Ahora		datetime,
    @Situacion		varchar(50),
    @SituacionSiguiente	varchar(50)

  IF @ReciboMensaje IS NOT NULL
  BEGIN
    SELECT @ID = NULL
    SELECT @ID = MAX(ID) FROM SMS WHERE Referencia = @ReciboMensaje

    IF @ID IS NOT NULL
    BEGIN
      SELECT @Modulo = Modulo, @ModuloID = ModuloID FROM SMS WHERE ID = @ID
      SELECT @Sucursal = Sucursal, @Mov = Mov, @Estatus = Estatus, @Situacion = Situacion, @Usuario = Usuario
        FROM dbo.fnMovReg(@Modulo, @ModuloID)

      SELECT @Orden = NULL
      SELECT @Orden = Orden 
        FROM MovSituacion
       WHERE Modulo = @Modulo AND Mov = @Mov AND Estatus = @Estatus AND Situacion = @Situacion

      IF @Orden IS NOT NULL
      BEGIN
        SELECT @OrdenSiguiente = NULL
        SELECT @OrdenSiguiente = MIN(Orden) 
          FROM MovSituacion
         WHERE Modulo = @Modulo AND Mov = @Mov AND Estatus = @Estatus AND Orden > @Orden

        SELECT @SituacionSiguiente = NULL
        SELECT @SituacionSiguiente = MIN(Situacion)
          FROM MovSituacion
         WHERE Modulo = @Modulo AND Mov = @Mov AND Estatus = @Estatus AND  Orden = @OrdenSiguiente

        SELECT @Ahora = GETDATE()
        IF @SituacionSiguiente IS NOT NULL
        BEGIN
          EXEC spCambiarSituacion @Modulo, @ModuloID, @SituacionSiguiente, @Ahora, @Usuario
          INSERT MovBitacora (Modulo, ID, Fecha, Evento, Sucursal, Usuario, Tipo) VALUES (@Modulo, @ID, @Ahora, @Telefono, @Sucursal, @Usuario, 'Autorizacion SMS')
        END
      END
      RETURN
    END
  END
END
GO

/*************** spFEA *******************/
if exists (select * from sysobjects where id = object_id('dbo.spFEA') and type = 'P') drop procedure dbo.spFEA
GO
CREATE PROCEDURE spFEA
			@ID   		int,
			@Folio 		int,
        		@Serie 		varchar(50)

--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @Aprobacion 	int,
  @Version 	varchar(15), 
  @Empresa	char(5),
  @IVAFactura	money,
  @IEPSFactura 	money

  SELECT @Empresa = Empresa FROM Venta WHERE Id = @Id
  SELECT @Version = FEAVersion FROM EmpresaGral WHERE Empresa = @Empresa 

  SELECT @IVAFActura = SUM(ISNULL(Impuesto1Total,0.0)), @IEPSFActura = SUM(ISNULL(Impuesto2Total,0.0)) FROM VentaTCalc WHERE Id = @Id

  SELECT vc.ID, vc.FechaEmision, vc.Condicion, vc.MovID, e.Nombre, e.RFC, e.Direccion, e.DireccionNumero, e.Codigopostal, e.Colonia, e.Estado,
         e.Poblacion, e.Pais, c.Nombre, c.RFC, c.Direccion, c.CodigoPostal, c.Colonia, c.Estado, c.Poblacion, c.Delegacion, 
         c.DireccionNumero, c.Pais, vc.Cantidad, a.Descripcion1, vc.Subtotal, vc.Unidad, vc.Precio, "Impuesto1Total" = @IVAFactura, "Impuesto2Total" = @IEPSFactura, --vc.Impuesto1Total, vc.Impuesto2Total,
	 vf.Folio, vf.Serie, vf.Aprobacion, "Version" = @Version
    FROM VentaTCalc Vc, VentaFEA vf, Cte c, Empresa e, Art a
   WHERE vc.ID = vf.ID
     AND vc.Cliente = c.Cliente 
     AND vc.Empresa = e.Empresa
     AND vc.articulo = a.Articulo
     AND vf.ID = @ID

  RETURN
END
GO

/*************** spFEAGenerar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spFEAGenerar') and type = 'P') drop procedure dbo.spFEAGenerar
GO
CREATE PROCEDURE spFEAGenerar
			@ID   		int

--//WITH ENCRYPTION
AS BEGIN
  IF @ID IS NOT NULL
    UPDATE VentaFEA SET Procesar = 1 WHERE Error = 1 AND ID = @ID

  EXEC xpFEAGenerar @ID
  RETURN
END
GO


/*************** spPreValidarFEA *******************/
if exists (select * from sysobjects where id = object_id('dbo.spPreValidarFEA') and type = 'P') drop procedure dbo.spPreValidarFEA
GO
CREATE PROCEDURE spPreValidarFEA
			@ID 			int,
			@Verificar		bit,
			@Ok			int 		OUTPUT,
			@OkRef			varchar(255) 	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @FechaEmision			datetime,
  @Condicion 			varchar(50),
  @Mov 				char(20),
  @MovID 			Varchar(20),
  @EmpresaNombre 		varchar(100),
  @EmpresaRFC 			varchar(20),
  @EmpresaDireccion 		varchar(100),
  @EmpresaDireccionNumero	varchar(20),
  @EmpresaCodigoPostal 		varchar(15),
  @EmpresaColonia 		varchar(30),
  @EmpresaEstado 		varchar(30),
  @EmpresaPoblacion 		varchar(30),
  @EmpresaPais 			varchar(30),
  @CteNombre 			varchar(100),
  @CteRFC 			varchar(15),
  @CteDireccion 		varchar(100),
  @CteCodigoPostal  		varchar(15),
  @CteColonia 			varchar(100),
  @CteEstado 			varchar(30),
  @CtePoblacion 		varchar(100),
  @CteDelegacion 		varchar(100),
  @CteNumero 			varchar(20),
  @CtePais 			varchar(30), 
  @Folio 			int,
  @Serie 			varchar(50),
  @Empresa 			char(5),
  @Aprobacion 			int,
  @Version 			float,
  @OkRegistro			bit

  IF @Verificar = 1
  BEGIN
    SELECT @FechaEmision = vc.FechaEmision, 
           @Condicion = vc.Condicion, 
	   @Empresa = vc.Empresa, 
	   @EmpresaNombre = e.Nombre, 
	   @EmpresaRFC = e.RFC, 
           @EmpresaDireccionNumero = e.DireccionNumero, 
	   @EmpresaDireccion = e.Direccion, 
	   @EmpresaCodigoPostal= e.Codigopostal,
           @EmpresaColonia= e.Colonia, 
	   @EmpresaEstado = e.Estado, 
	   @EmpresaPoblacion = e.Poblacion, 
	   @EmpresaPais = e.Pais, 
           @CteNombre = c.Nombre, 
	   @CteRFC = c.RFC, 
	   @CteDireccion = c.Direccion, 
	   @CteCodigoPostal = c.CodigoPostal, 
	   @CteColonia = c.Colonia,
           @CteEstado = c.Estado, 
	   @CtePoblacion = c.Poblacion, 
	   @CteDelegacion = c.Delegacion, 
	   @CteNumero = c.DireccionNumero, 
           @CtePais = c.Pais
      FROM Venta Vc, Cte c, Empresa e, MovTipo mt
     WHERE vc.Cliente = c.Cliente 
       AND vc.Empresa = e.Empresa
       AND vc.ID = @ID
    SELECT @Version = FEAVersion FROM EmpresaGral WHERE Empresa = @Empresa
  END ELSE
    SELECT @Folio = Folio, @Serie = Serie, @Aprobacion = Aprobacion FROM VentaFEA WHERE ID = @ID

  IF @Verificar = 1
  BEGIN
    IF NULLIF(@Version,'') 	  		IS NULL SELECT @OkRef = 'Version' 		ELSE 
    IF NULLIF(@FechaEmision,'') 	 	IS NULL SELECT @OkRef = 'Fecha Emision' 	ELSE 
    IF NULLIF(@Condicion,'') 	  		IS NULL SELECT @OkRef = 'Condicion' 		ELSE 
    IF NULLIF(@EmpresaNombre,'') 	  	IS NULL SELECT @OkRef = 'Nombre (Empresa)' 	ELSE 
    IF NULLIF(@EmpresaRFC,'') 	  		IS NULL SELECT @OkRef = 'RFC (Empresa)' 	ELSE
    IF NULLIF(@EmpresaDireccion,'') 		IS NULL SELECT @OkRef = 'Direccion (Empresa)' 	ELSE 
    IF NULLIF(@EmpresaCodigoPostal,'') 		IS NULL SELECT @OkRef = 'Codigo Postal (Empresa)' ELSE 
    IF NULLIF(@EmpresaColonia,'') 		IS NULL SELECT @OkRef = 'Colonia (Empresa)' 	ELSE 
    IF NULLIF(@EmpresaEstado,'') 	  	IS NULL SELECT @OkRef = 'Estado (Empresa)' 	ELSE 
    IF NULLIF(@EmpresaPoblacion,'') 		IS NULL SELECT @OkRef = 'Poblacion (empresa)' 	ELSE 
    IF NULLIF(@EmpresaPais,'') 	  		IS NULL SELECT @OkRef = 'Pais (Empresa)' 	ELSE 
    IF NULLIF(@CteNombre,'') 	  		IS NULL SELECT @OkRef = 'Nombre (Cliente)' 	ELSE 
    IF NULLIF(@CteRFC,'')		  	IS NULL SELECT @OkRef = 'RFC (Cliente)' 	ELSE 
    IF NULLIF(@CteDireccion,'') 	  	IS NULL SELECT @OkRef = 'Direccion (Cliente)' 	ELSE 
    IF NULLIF(@CteCodigoPostal,'') 		IS NULL SELECT @OkRef = 'Codigo Postal (Cliente)' ELSE 
    IF NULLIF(@CteColonia,'') 	  		IS NULL SELECT @OkRef = 'Colonia (Cliente)' 	ELSE 
    IF NULLIF(@CteEstado,'') 	  		IS NULL SELECT @OkRef = 'Estado(Cliente)' 	ELSE 
    IF NULLIF(@CtePoblacion,'') 	  	IS NULL SELECT @OkRef = 'Población (Cliente)' 	ELSE 
    IF NULLIF(@CteDelegacion,'') 	  	IS NULL SELECT @OkRef = 'Delegación (Cliente)' 	ELSE 
    IF NULLIF(@CteNumero,'') 	  		IS NULL SELECT @OkRef = 'Numero (Cliente)' 	ELSE 
    IF NULLIF(@CtePais,'') 			IS NULL SELECT @OkRef = 'Pais (Cliente)' 	

    EXEC spRegistroOk 'RFC', @EmpresaRFC, @Empresa, 1, @OkRegistro OUTPUT 
    IF @OkRegistro = 0 SELECT @OkRef = 'RFC (Empresa)' 
    EXEC spRegistroOk 'RFC', @CteRFC, @Empresa, 1, @OkRegistro OUTPUT 
    IF @OkRegistro = 0 SELECT @OkRef = 'RFC (cliente)' 

  END ELSE
  BEGIN
    IF NULLIF(@Folio,'') 	  		IS NULL SELECT @OkRef = 'Folio'  	ELSE
    IF NULLIF(@Serie,'') 	  		IS NULL SELECT @OkRef = 'Serie' 	ELSE 
    IF NULLIF(@Aprobacion,0) 	  		IS NULL SELECT @OkRef = 'Aprobacion'
  END
  IF @OkRef IS NOT NULL SELECT @Ok = 10060, @OkRef = 'FEA - '+@OkRef
END
GO



/*************** spArtCBJuegoImporte *******************/
if exists (select * from sysobjects where id = object_id('dbo.spArtCBJuegoImporte') and type = 'P') drop procedure dbo.spArtCBJuegoImporte
GO
CREATE PROCEDURE spArtCBJuegoImporte
			@Codigo		varchar(30),
			@ImporteTotal	money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @PrecioTotal	money

  SELECT @ImporteTotal = NULLIF(@ImporteTotal, 0.0)
  IF @ImporteTotal IS NULL
    UPDATE ArtCBJuego
       SET Precio = a.PrecioLista
      FROM ArtCBJuego d
      JOIN Art a ON a.Articulo = d.Articulo
     WHERE d.Codigo = @Codigo
  ELSE BEGIN
    SELECT @PrecioTotal = SUM(a.PrecioLista * d.Cantidad)
      FROM ArtCBJuego d
      JOIN Art a ON a.Articulo = d.Articulo
     WHERE d.Codigo = @Codigo

    UPDATE ArtCBJuego
       SET Precio = dbo.fnR3(@PrecioTotal, a.PrecioLista * d.Cantidad, @ImporteTotal) / d.Cantidad
      FROM ArtCBJuego d
      JOIN Art a ON a.Articulo = d.Articulo
     WHERE d.Codigo = @Codigo
  END
END
GO



/*************** spArtOpcionWizardSugerir *******************/
if exists (select * from sysobjects where id = object_id('dbo.spArtOpcionWizardSugerir') and type = 'P') drop procedure dbo.spArtOpcionWizardSugerir
GO
CREATE PROCEDURE spArtOpcionWizardSugerir
			@Estacion	int,
			@Articulo	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DELETE ArtOpcionWizard WHERE Estacion = @Estacion
  INSERT ArtOpcionWizard (Estacion, Opcion, Generar)  
  SELECT @Estacion, Opcion, 0
    FROM ArtOpcion
   WHERE Articulo = @Articulo
   ORDER BY Orden

  RETURN
END
GO

/*************** spArtOpcionPreliminarAdd *******************/
if exists (select * from sysobjects where id = object_id('dbo.spArtOpcionPreliminarAdd') and type = 'P') drop procedure dbo.spArtOpcionPreliminarAdd
GO
CREATE PROCEDURE spArtOpcionPreliminarAdd
			@Opcion		char(1),
    			@TieneDetalle	bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SubCuenta	varchar(50)

  TRUNCATE Table #OpcionP1
  INSERT #OpcionP1 (SubCuenta) SELECT SubCuenta FROM #OpcionP2 ORDER BY ID
  IF @@ROWCOUNT = 0
  BEGIN
    IF @TieneDetalle = 0
      INSERT #OpcionP2 (SubCuenta) SELECT @Opcion
    ELSE
      INSERT #OpcionP2 (SubCuenta) 
      SELECT Opcion+CONVERT(varchar, Numero)
        FROM #OpcionD
       WHERE Opcion = @Opcion
       ORDER BY Numero
  END ELSE
  BEGIN
    TRUNCATE Table #OpcionP2
    DECLARE crOpcionP1 CURSOR LOCAL FOR 
     SELECT SubCuenta
       FROM #OpcionP1
    OPEN crOpcionP1
    FETCH NEXT FROM crOpcionP1 INTO @SubCuenta
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        DELETE #OpcionP1 WHERE CURRENT OF crOpcionP1
        IF @TieneDetalle = 0
          INSERT #OpcionP2 (SubCuenta) SELECT @SubCuenta+@Opcion
        ELSE
          INSERT #OpcionP2 (SubCuenta) 
          SELECT @SubCuenta+Opcion+CONVERT(varchar, Numero)
            FROM #OpcionD
           WHERE Opcion = @Opcion
           ORDER BY Numero
      END
      FETCH NEXT FROM crOpcionP1 INTO @SubCuenta
    END
    CLOSE crOpcionP1
    DEALLOCATE crOpcionP1
  END

  RETURN
END
GO

/*************** spArtOpcionPreliminar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spArtOpcionPreliminar') and type = 'P') drop procedure dbo.spArtOpcionPreliminar
GO
CREATE PROCEDURE spArtOpcionPreliminar
			@Estacion	int,
			@Articulo	varchar(20),
			@CBSugerir	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Opcion		char(1),
    @TieneDetalle	bit,
    @Codigo		varchar(30),
    @SubCuenta		varchar(50)

  DELETE ArtOpcionPreliminar WHERE Estacion = @Estacion
  IF (SELECT UPPER(TipoOpcion) FROM Art WHERE Articulo = @Articulo) <> 'SI'
  BEGIN
    IF @CBSugerir = 'Código Compuesto'
      SELECT @Codigo = @Articulo
    ELSE 
    IF @CBSugerir = 'Código Consecutivo'
      EXEC spConsecutivo 'Codigo Barras', 0, @Codigo OUTPUT

    INSERT ArtOpcionPreliminar (Estacion, Codigo) VALUES (@Estacion, @Codigo)
  END ELSE
  BEGIN
    CREATE TABLE #OpcionD (Opcion	char(1) COLLATE Database_Default NOT NULL, Numero int NULL, Nombre varchar(100) COLLATE Database_Default NULL, InformacionAdicional varchar(100) COLLATE Database_Default NULL, Imagen varchar(255) COLLATE Database_Default NULL)
    CREATE TABLE #OpcionP1 (ID int NOT NULL IDENTITY(1,1) PRIMARY KEY, SubCuenta varchar(50) COLLATE Database_Default NULL)
    CREATE TABLE #OpcionP2 (ID int NOT NULL IDENTITY(1,1) PRIMARY KEY, SubCuenta varchar(50) COLLATE Database_Default NULL)
    EXEC spVerOpcionD @Articulo, @Generar = 1, @Estacion = @Estacion

    DECLARE crArtOpcionWizard CURSOR LOCAL FOR 
     SELECT w.Opcion, o.TieneDetalle
       FROM ArtOpcionWizard w
       JOIN Opcion o ON o.Opcion = w.Opcion 
      WHERE w.Estacion = @Estacion AND w.Generar = 1   
      ORDER BY w.Opcion
    OPEN crArtOpcionWizard
    FETCH NEXT FROM crArtOpcionWizard INTO @Opcion, @TieneDetalle
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
        EXEC spArtOpcionPreliminarAdd @Opcion, @TieneDetalle
      FETCH NEXT FROM crArtOpcionWizard INTO @Opcion, @TieneDetalle
    END
    CLOSE crArtOpcionWizard
    DEALLOCATE crArtOpcionWizard

    IF @CBSugerir = 'Código Compuesto'
      INSERT ArtOpcionPreliminar (Estacion, Codigo, SubCuenta)
      SELECT @Estacion, @Articulo+'/'+SubCuenta, SubCuenta
        FROM #OpcionP2
       ORDER BY ID
    ELSE
    IF @CBSugerir = 'Código Consecutivo'
    BEGIN
      DECLARE crOpcionP2 CURSOR LOCAL FOR 
       SELECT SubCuenta
         FROM #OpcionP2
        ORDER BY ID
      OPEN crOpcionP2
      FETCH NEXT FROM crOpcionP2 INTO @SubCuenta
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          EXEC spConsecutivo 'Codigo Barras', 0, @Codigo OUTPUT
          INSERT ArtOpcionPreliminar (Estacion, Codigo, SubCuenta) VALUES (@Estacion, @Codigo, @SubCuenta)
        END
        FETCH NEXT FROM crOpcionP2 INTO @SubCuenta
      END
      CLOSE crOpcionP2
      DEALLOCATE crOpcionP2
    END
  END
  RETURN
END
GO

-- select * from ArtOpcionWizard
-- spArtOpcionPreliminar 100, 'C920'
-- select * from artopcionpreliminar


/*************** spArtOpcionPreliminarAceptar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spArtOpcionPreliminarAceptar') and type = 'P') drop procedure dbo.spArtOpcionPreliminarAceptar
GO
CREATE PROCEDURE spArtOpcionPreliminarAceptar
			@Estacion	int,
			@Articulo	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo	int,
    @Codigo	varchar(30),
    @SubCuenta	varchar(50),
    @Unidad	varchar(50)

  SELECT @Conteo = 0
  SELECT @Unidad = Unidad FROM Art WHERE Articulo = @Articulo
  DECLARE crArtOpcionPreliminar CURSOR LOCAL FOR 
   SELECT p.Codigo, p.SubCuenta
     FROM ArtOpcionPreliminar p
    WHERE p.Estacion = @Estacion
  OPEN crArtOpcionPreliminar
  FETCH NEXT FROM crArtOpcionPreliminar INTO @Codigo, @SubCuenta
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      UPDATE CB 
         SET Codigo = @Codigo,
             TipoCuenta = 'Articulos',
             Cuenta = @Articulo,
             SubCuenta = @SubCuenta,
             Cantidad = 1
       WHERE Codigo = @Codigo
      IF @@ROWCOUNT = 0
        INSERT CB (Codigo, TipoCuenta, Cuenta, SubCuenta, Cantidad, Unidad) VALUES (@Codigo, 'Articulos', @Articulo, @SubCuenta, 1.0, @Unidad)
      SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crArtOpcionPreliminar INTO @Codigo, @SubCuenta
  END
  CLOSE crArtOpcionPreliminar
  DEALLOCATE crArtOpcionPreliminar
  
  SELECT 'Se Generaron '+CONVERT(varchar, @Conteo)+' Codigos Barras'

  RETURN
END
GO

/**************** fnProcesarSignatureTag ****************/
--IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnProcesarSignatureTag') DROP FUNCTION fnProcesarSignatureTag
GO
/*CREATE FUNCTION fnProcesarSignatureTag (@Tag varchar(255), @name varchar(255), @doc text)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255),
    @s1		varchar(255),
    @s2		varchar(255),
    @p1 	int, 
    @p2 	int

  SELECT @Resultado = NULL
  SELECT @s1 = '<'+@Tag+' name="'+@name+'">', @s2 = '</'+@Tag+'>'
  SELECT @p1 = CHARINDEX(@s1, @doc, 1)
  IF @p1 > 0
  BEGIN
    SELECT @p2 = CHARINDEX(@s2, @doc, @p1)
    IF @p2 > 0
      SELECT @Resultado = SUBSTRING(@doc, @p1+LEN(@s1), @p2-(@p1+LEN(@s1)))
  END
  RETURN (@Resultado)
END*/
GO


/*************** spProcesarSignature *******************/
if exists (select * from sysobjects where id = object_id('dbo.spProcesarSignature') and type = 'P') 
  drop procedure dbo.spProcesarSignature
GO             
CREATE PROCEDURE spProcesarSignature
			@Ruta		  varchar(255),
    	@Doc		  text

--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @idoc       int,
    @Archivo    varchar(100),
    @Sucursal	int,
    @Modulo	varchar(5), 
    @ModuloID	int,
    @Nombre	varchar(100)

  SELECT @Nombre = 'Comprobante Fiscal Digital'
  EXEC sp_xml_preparedocument @idoc OUTPUT, @Doc

  IF SUBSTRING(@Ruta, LEN(@Ruta), 1) <> '\' SELECT @Ruta = @Ruta + '\'

  SELECT @Sucursal = IntelisisSucursal,
         @Modulo = IntelisisModulo,
         @ModuloID  = IntelisisModuloID
    FROM OPENXML (@idoc, 'Comprobante/Addenda/ECFD/Personalizados', 2) 
            WITH (IntelisisSucursal int        'campoNumero[@name="IntelisisSucursal"]',
                  IntelisisModulo   varchar(5) 'campoString[@name="IntelisisModulo"]',
                  IntelisisModuloID int        'campoNumero[@name="IntelisisModuloID"]')

  SELECT @Archivo = @Modulo+CONVERT(varchar(20), @ModuloID)+'.xml'

  DELETE AnexoMov 
   WHERE Sucursal = @Sucursal AND Rama = @Modulo AND ID = @ModuloID AND Nombre = @Nombre

  INSERT AnexoMov (Sucursal, Rama, ID, Nombre, Direccion, Icono, Tipo, Orden)
  SELECT @Sucursal, @Modulo, @ModuloID, @Nombre, @Ruta+@Archivo, 570, 'Archivo', 1

  SELECT "Archivo" = @Archivo
  RETURN
END
GO

/*************** spTareaEliminar *******************/
--if exists (select * from sysobjects where id = object_id('dbo.spTareaEliminar') and type = 'P') drop procedure dbo.spTareaEliminar
GO
/*CREATE PROCEDURE spTareaEliminar
			@ID	int	    = NULL,
			@GID	varchar(50) = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF NULLIF(NULLIF(RTRIM(@GID), ''), '0') IS NOT NULL
  BEGIN
    DELETE TareaD WHERE GID = @GID
    DELETE Tarea  WHERE GID = @GID
  END ELSE
    DELETE Tarea  WHERE ID = @ID
  RETURN
END*/
GO

/**************** spVerBloqueo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerBloqueo') and type = 'P') drop procedure dbo.spVerBloqueo
GO             
CREATE PROCEDURE spVerBloqueo

--//WITH ENCRYPTION
AS
BEGIN

DECLARE
	@Spid 		int,
	@Bloqueado	int,
	@UsuarioNT	varchar(100),
	@Comando	varchar(20),
	@Fecha		datetime

	CREATE TABLE #Bloqueo(
	Spid		int,
	UsuarioNT	varchar(100) 	COLLATE Database_Default,
	Comando		varchar(20)	COLLATE Database_Default,
	Fecha		datetime)
	
	CREATE TABLE #Evento(
	ID		int IDENTITY,
	Tipo	 	char (15)	COLLATE Database_Default,
	Estatus 	int ,
	Info 		varchar (255)	COLLATE Database_Default)

	CREATE TABLE #VerBloqueo (
	ID 		int IDENTITY,
	Spid 		int ,
	UsuarioNT	varchar(100)	COLLATE Database_Default,
	Comando		varchar(20)	COLLATE Database_Default,
	Fecha		datetime) 

	INSERT INTO #Bloqueo
	SELECT Spid, Nt_UserName, Cmd, Last_Batch
	  FROM master.dbo.Sysprocesses
	 WHERE Blocked = 0 AND Spid in (SELECT DISTINCT Blocked FROM master.dbo.Sysprocesses)

	DECLARE crBloqueo CURSOR FOR
	SELECT DISTINCT t2.Spid,
	       t2.UsuarioNT,
	       t2.Comando,
	       t2.Fecha
	  FROM #Bloqueo t2 
	Order by t2.Fecha

	Open crBloqueo
	FETCH NEXT FROM crBloqueo INTO @Spid, @UsuarioNT, @Comando, @Fecha
	WHILE @@FETCH_STATUS = 0
	BEGIN

		INSERT INTO #Evento (Tipo, Estatus, Info)
		EXEC sp_executesql N'DBCC INPUTBUFFER( @i )', N'@i int',@i=@Spid			

		INSERT INTO #VerBloqueo (Spid, UsuarioNT, Comando, Fecha) 
			VALUES(@Spid, @UsuarioNT, @Comando, @Fecha)
	
		FETCH NEXT FROM crBloqueo INTO @Spid, @UsuarioNT, @Comando, @Fecha
	END

	CLOSE crBloqueo
	DEALLOCATE crBloqueo

	SELECT DISTINCT
	a.Spid,
	a.Comando,
	a.UsuarioNT, 
	a.Fecha,
	'Info' = REPLACE(b.Info, ASCII(13), '')
	  FROM #VerBloqueo a,#Evento b
	 WHERE a.ID = b.ID

	IF exists(SELECT * FROM #VerBloqueo a,#Evento b WHERE a.ID = b.ID)
	INSERT INTO VerBloqueo(Spid, UsuarioNT, Comando, Fecha, Info, Actual)
	SELECT a.Spid, a.UsuarioNT, a.Comando, a.Fecha, b.Info, (SELECT GETDATE())
	  FROM #VerBloqueo a,#Evento b
	 WHERE a.ID = b.ID

RETURN
END
GO		

/**************** spVerBloqueoD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerBloqueoD') and type = 'P') drop procedure dbo.spVerBloqueoD
GO             
CREATE PROCEDURE spVerBloqueoD
--//WITH ENCRYPTION
AS
BEGIN
DECLARE
	@Spid 		int,
	@Bloqueado	int,
	@UsuarioNT	varchar(100),
	@Comando	varchar(20),
	@Fecha		datetime

	CREATE TABLE #EventoD(
	ID		int IDENTITY,
	Tipo	 	char (15)	COLLATE Database_Default,
	Estatus 	int ,
	Info 		varchar (255)	COLLATE Database_Default)

	CREATE TABLE #VerBloqueoD (
	ID 		int IDENTITY,
	Spid 		int ,
	Bloqueado	int,
	UsuarioNT	varchar(100)	COLLATE Database_Default,
	Comando		varchar(20)	COLLATE Database_Default,
	Fecha		datetime) 

	DECLARE crBloqueoD CURSOR FOR
	SELECT DISTINCT
		Spid,
		Nt_username,
		Blocked,
		CMD,
		LAST_BATCH
	  FROM master.dbo.Sysprocesses WHERE Blocked <> 0
	ORDER BY Last_Batch

	Open crBloqueoD
	FETCH NEXT FROM crBloqueoD INTO @Spid, @UsuarioNT, @Bloqueado, @Comando, @Fecha
	WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT INTO #EventoD (Tipo, Estatus, Info)
			EXEC sp_executesql N'DBCC INPUTBUFFER( @i )', N'@i int',@i=@spid

			INSERT INTO #VerBloqueoD (Spid, Bloqueado, UsuarioNT, Comando, Fecha)
			VALUES(@Spid, @Bloqueado, @UsuarioNT, @Comando, @Fecha)

			FETCH NEXT FROM crBloqueoD INTO @Spid, @UsuarioNT, @Bloqueado, @Comando, @Fecha
		END
	CLOSE crBloqueoD
	DEALLOCATE crBloqueoD

	SELECT DISTINCT
	a.Spid,
	a.Bloqueado,
	a.Comando,
	a.UsuarioNT, 
	a.Fecha,
	'Info' = REPLACE(b.Info, ASCII(13), '')
	  FROM #VerBloqueoD a,#EventoD b
	 WHERE a.ID = b.ID

RETURN
END
GO



/*************** spHaspAutorizar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spHaspAutorizar') and type = 'P') drop procedure dbo.spHaspAutorizar
GO
CREATE PROCEDURE spHaspAutorizar
			@ID		int,
			@Usuario	char(10),
			@Datos		text
--//WITH ENCRYPTION
AS BEGIN
  UPDATE Hasp
     SET Cliente 	= ISNULL(NULLIF(RTRIM(ClienteN), ''), Cliente),
	 Fabricacion	= ISNULL(FabricacionN, Fabricacion),
	 Vencimiento	= ISNULL(VencimientoN, Vencimiento),
	 Mantenimiento	= ISNULL(MantenimientoN, Mantenimiento),
	 Licencias1	= ISNULL(Licencias1N, Licencias1),
	 Licencias2	= ISNULL(Licencias2N, Licencias2),
	 Estatus	= ISNULL(NULLIF(RTRIM(EstatusN), ''), Estatus),
	 Observaciones	= ISNULL(NULLIF(RTRIM(ObservacionesN), ''), Observaciones),
	 Datos		= @Datos,
         UsuarioAutorizacion = @Usuario,
         FechaAutorizacion = GETDATE()
   WHERE ID = @ID

  UPDATE Hasp
     SET ClienteN 	= NULL,
	 FabricacionN	= NULL,
	 VencimientoN	= NULL,
	 MantenimientoN	= NULL,
	 Licencias1N	= NULL,
	 Licencias2N	= NULL,
	 EstatusN	= NULL,
	 ObservacionesN	= NULL
   WHERE ID = @ID
  RETURN
END
GO

-- spVer_dboption 'Matriz', 'recursive triggers'
-- sp_dboption 'Matriz', 'recursive triggers', 'true'

/************** spVer_dboption *************/
if exists (select * from sysobjects where id = object_id('dbo.spVer_dboption') and type = 'P') drop procedure dbo.spVer_dboption
GO
CREATE PROCEDURE spVer_dboption
			@BaseDatos	varchar(50),
			@Opcion		varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  CREATE TABLE #dooption (OptionName varchar(50) COLLATE Database_Default NULL, CurrentSetting varchar(20) COLLATE Database_Default NULL)
  INSERT INTO #dooption (OptionName, currentSetting)
  EXEC sp_dboption @BaseDatos, @Opcion
  SELECT CurrentSetting FROM #dooption
  RETURN 
END
GO

/************** spWSRecibirCompraAutoEndoso *************/
if exists (select * from sysobjects where id = object_id('dbo.spWSRecibirCompraAutoEndoso') and type = 'P') drop procedure dbo.spWSRecibirCompraAutoEndoso
GO
CREATE PROCEDURE spWSRecibirCompraAutoEndoso
			@ixml		int,
    			@Version	float, 
    			@Accion		varchar(20), 
			@Ok 		int		OUTPUT, 
			@OkRef 		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @FechaRegistro		datetime,
    @Mov			varchar(20),
    @MovID			varchar(20),
    @IDGenerar			int,
    @EndosoID			int,
    @Origen			varchar(20),
    @OrigenID			varchar(20),
    @Empresa			varchar(10),
    @Sucursal			int, 
    @Usuario			varchar(10),    
    @Proveedor			varchar(10), 
    @Cliente			varchar(10), 
    @Referencia 		varchar(50),
    @ProvNombre 		varchar(100), 
    @ProvNombreCorto 		varchar(20), 
    @ProvDireccion 		varchar(100),
    @ProvEntreCalles 		varchar(100),
    @ProvPlano 			varchar(15),
    @ProvObservaciones 		varchar(100),
    @ProvDelegacion 		varchar(100),
    @ProvColonia 		varchar(100),
    @ProvPoblacion 		varchar(100),
    @ProvEstado 		varchar(30),
    @ProvZona 			varchar(30),
    @ProvPais 			varchar(30),
    @ProvCodigoPostal 		varchar(15),
    @ProvTelefonos 		varchar(100),
    @ProvFax			varchar(50),
    @ProvContacto1 		varchar(50),
    @ProvContacto2 		varchar(50),
    @ProvExtencion1 		varchar(10),
    @ProvExtencion2 		varchar(10),
    @ProveMail1 		varchar(50),
    @ProveMail2 		varchar(50),
    @ProvRFC 			varchar(15),
    @ProvCURP 			varchar(30),
    @ProvBeneficiarioNombre 	varchar(100),
    @ProvLeyendaCheque		varchar(100),
    @ProvOrigen			varchar(20),
    @ProvOrigenID		varchar(20)

  SELECT @FechaRegistro = GETDATE()
  SELECT @Empresa = Endoso, @Proveedor = Proveedor, @Cliente = Empresa, @Origen = Mov, @OrigenID = MovID
    FROM OPENXML (@ixml, 'Intelisis/Movimiento') 
    WITH (Empresa varchar(10), Endoso varchar(10), Proveedor varchar(10), Mov varchar(20), MovID varchar(20))

  SELECT @Sucursal = 0, @Mov = @Origen
  SELECT @Mov = ISNULL(MovDestino, @Mov) FROM CteMapeoMov WHERE Cliente = @Cliente AND MovOrigen = @Mov
  SELECT @ProvOrigen = @Cliente, @ProvOrigenID = @Proveedor

  IF NOT EXISTS(SELECT * FROM Empresa WHERE Empresa = @Empresa AND Estatus = 'ALTA')
    SELECT @Ok = 26070, @OkRef = @Empresa

  IF @Ok IS NULL 
  BEGIN
    SELECT @Usuario = DefUsuario FROM EmpresaGral WHERE Empresa = @Empresa
    IF NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @Usuario AND Estatus = 'ALTA')
      SELECT @Ok = 71020, @OkRef = @Usuario
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @ProvNombre = Nombre, @ProvNombreCorto = NombreCorto, @ProvDireccion = Direccion, @ProvEntreCalles = EntreCalles, @ProvPlano = Plano, @ProvObservaciones = Observaciones, @ProvDelegacion = Delegacion, @ProvColonia = Colonia, @ProvPoblacion = Poblacion, 
           @ProvEstado = Estado, @ProvZona = Zona, @ProvPais = Pais, @ProvCodigoPostal = CodigoPostal, @ProvTelefonos = Telefonos, @ProvFax = Fax,
           @ProvContacto1 = Contacto1, @ProvContacto2 = Contacto2, @ProvExtencion1 = Extencion1, @ProvExtencion2 = Extencion2, @ProveMail1 = eMail1, @ProveMail2 = eMail2, @ProvRFC = RFC, @ProvCURP = CURP, @ProvBeneficiarioNombre = BeneficiarioNombre, @ProvLeyendaCheque = LeyendaCheque
     FROM OPENXML (@ixml, 'Intelisis/Movimiento/Proveedor')
     WITH (Nombre varchar(100), NombreCorto varchar(20), Direccion varchar(100), EntreCalles varchar(100), Plano varchar(15), Observaciones varchar(100), Delegacion varchar(100),
           Colonia varchar(100), Poblacion varchar(100), Estado varchar(30), Zona varchar(30), Pais varchar(30), CodigoPostal varchar(15), Telefonos varchar(100), Fax varchar(50),
           Contacto1 varchar(50), Contacto2 varchar(50), Extencion1 varchar(10), Extencion2 varchar(10), eMail1 varchar(50), eMail2 varchar(50), RFC varchar(15), CURP varchar(30),
           BeneficiarioNombre varchar(100), LeyendaCheque varchar(100))

    SELECT @Proveedor = NULL
    SELECT @Proveedor = MIN(Proveedor)
      FROM Prov
     WHERE Origen = @ProvOrigen AND OrigenID = @ProvOrigenID
    IF @Proveedor IS NULL
    BEGIN
      EXEC spConsecutivo @Cliente, 0, @Proveedor OUTPUT
      IF @Proveedor IS NULL
        SELECT @Ok = 53040, @OkRef = @Cliente
      ELSE
        INSERT Prov (
                Proveedor,  Nombre,      NombreCorto,      Direccion,      EntreCalles,      Plano,      Observaciones,      Delegacion,      Colonia,      Poblacion,      Estado,      Zona,      Pais,      CodigoPostal,      Telefonos,      Fax,      Contacto1,      Contacto2,      Extencion1,      Extencion2,      eMail1,      eMail2,      RFC,      CURP,      BeneficiarioNombre,      LeyendaCheque,      Estatus, Origen,      OrigenID)
        VALUES (@Proveedor, @ProvNombre, @ProvNombreCorto, @ProvDireccion, @ProvEntreCalles, @ProvPlano, @ProvObservaciones, @ProvDelegacion, @ProvColonia, @ProvPoblacion, @ProvEstado, @ProvZona, @ProvPais, @ProvCodigoPostal, @ProvTelefonos, @ProvFax, @ProvContacto1, @ProvContacto2, @ProvExtencion1, @ProvExtencion2, @ProveMail1, @ProveMail2, @ProvRFC, @ProvCURP, @ProvBeneficiarioNombre, @ProvLeyendaCheque, 'ALTA',  @ProvOrigen, @ProvOrigenID)
    END ELSE
      UPDATE Prov 
         SET Nombre = @ProvNombre,
             NombreCorto = @ProvNombreCorto,
             Direccion = @ProvDireccion,
             EntreCalles = @ProvEntreCalles,
             Plano = @ProvPlano,
             Observaciones = @ProvObservaciones,
             Delegacion = @ProvDelegacion,
             Colonia = @ProvColonia,
             Poblacion = @ProvPoblacion,
             Estado = @ProvEstado,
             Zona = @ProvZona,
             Pais = @ProvPais,
             CodigoPostal = @ProvCodigoPostal,
             Telefonos = @ProvTelefonos,
             Fax = @ProvFax,
             Contacto1 = @ProvContacto1,
             Contacto2 = @ProvContacto2,
             Extencion1 = @ProvExtencion1,
             Extencion2 = @ProvExtencion2,
             eMail1 = @ProveMail1,
             eMail2 = @ProveMail2,
             RFC = @ProvRFC,
             CURP = @ProvCURP,
             BeneficiarioNombre = @ProvBeneficiarioNombre,
             LeyendaCheque = @ProvLeyendaCheque
       WHERE Proveedor = @Proveedor
  END

  IF @Ok IS NULL AND @Accion = 'AFECTAR'
  BEGIN
    IF EXISTS(SELECT * FROM Cxp WHERE Empresa = @Empresa AND Proveedor = @Proveedor AND OrigenTipo = 'ENDOSO' AND Origen = @Origen AND OrigenID = @OrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO'))
      SELECT @Ok = 20917, @OkRef = @Origen + ' ' + @OrigenID + ' (Cuentas por Pagar)'
    ELSE
    IF EXISTS(SELECT * FROM Cxc WHERE Empresa = @Empresa AND Cliente = @Cliente AND OrigenTipo = 'ENDOSO' AND Origen = @Origen AND OrigenID = @OrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO'))
      SELECT @Ok = 20917, @OkRef = @Origen + ' ' + @OrigenID + ' (Cuentas por Cobrar)'
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @EndosoID = NULL
    IF @Accion = 'CANCELAR'
      SELECT @EndosoID = MIN(ID) FROM Cxp WHERE Empresa = @Empresa AND Proveedor = @Proveedor AND OrigenTipo = 'ENDOSO' AND Origen = @Origen AND OrigenID = @OrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
    ELSE BEGIN
      INSERT INTO Cxp 
             (Sucursal, Empresa, Mov, FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Observaciones, Estatus, UltimoCambio,
              Proveedor, ProveedorMoneda, ProveedorTipoCambio, Condicion, Vencimiento, Importe, Impuestos, Retencion, Retencion2, Retencion3, 
              OrigenTipo, Origen, OrigenID, IVAFiscal, IEPSFiscal)
       SELECT @Sucursal, @Empresa, @Mov, FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, @Usuario, Referencia, Observaciones, 'SINAFECTAR', @FechaRegistro,
              @Proveedor, Moneda, TipoCambio, '(Fecha)', Vencimiento, Importe, Impuestos, Retencion, Retencion2, Retencion3, 
              'ENDOSO', @Origen, @OrigenID, IVAFiscal, IEPSFiscal
         FROM OPENXML (@ixml, 'Intelisis/Movimiento') 
         WITH (FechaEmision datetime, Concepto varchar(50), Referencia varchar(50), Proyecto varchar(50), Moneda varchar(10), TipoCambio float, Vencimiento datetime, Importe money, Impuestos money, Retencion money, Retencion2 money, Retencion3 money, IVAFiscal float, IEPSFiscal float, Observaciones varchar(100))
      SELECT @EndosoID = SCOPE_IDENTITY()
    END
    IF @EndosoID IS NOT NULL
      EXEC spCx @EndosoID, 'CXP', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  END
  IF @Ok IS NULL
  BEGIN
    SELECT @EndosoID = NULL
    IF @Accion = 'CANCELAR'
      SELECT @EndosoID = MIN(ID) FROM Cxc WHERE Empresa = @Empresa AND Cliente = @Cliente AND OrigenTipo = 'ENDOSO' AND Origen = @Origen AND OrigenID = @OrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
    ELSE BEGIN
      INSERT INTO Cxc 
             (Sucursal, Empresa, Mov, MovID, FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Referencia, Observaciones, Estatus, UltimoCambio,
              Cliente, ClienteMoneda, ClienteTipoCambio, Condicion, Vencimiento, Importe, Impuestos, Retencion, 
              OrigenTipo, Origen, OrigenID, IVAFiscal, IEPSFiscal)
       SELECT @Sucursal, @Empresa, @Mov, @MovID, FechaEmision, Concepto, Proyecto, Moneda, TipoCambio, @Usuario, Referencia, Observaciones, 'SINAFECTAR', @FechaRegistro,
              @Cliente, Moneda, TipoCambio, '(Fecha)', Vencimiento, Importe, Impuestos, Retencion, 
              'ENDOSO', @Origen, @OrigenID, IVAFiscal, IEPSFiscal
         FROM OPENXML (@ixml, 'Intelisis/Movimiento') 
         WITH (FechaEmision datetime, Concepto varchar(50), Referencia varchar(50), Proyecto varchar(50), Moneda varchar(10), TipoCambio float, Vencimiento datetime, Importe money, Impuestos money, Retencion money, Retencion2 money, Retencion3 money, IVAFiscal float, IEPSFiscal float, Observaciones varchar(100))
      SELECT @EndosoID = SCOPE_IDENTITY()
    END
    IF @EndosoID IS NOT NULL
      EXEC spCx @EndosoID, 'CXC', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END
  RETURN 
END
GO

/************** spWSRecibirProspectoWeb *************/
if exists (select * from sysobjects where id = object_id('dbo.spWSRecibirProspectoWeb') and type = 'P') drop procedure dbo.spWSRecibirProspectoWeb
GO
CREATE PROCEDURE spWSRecibirProspectoWeb
			@ixml		int,
    			@Version	float, 
    			@Accion		varchar(20), 
			@Ok 		int		OUTPUT, 
			@OkRef 		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @eMail	varchar(100)

  SELECT @eMail = NULLIF(RTRIM(eMail), '')
    FROM OPENXML (@ixml, 'Intelisis/Movimiento/Prospecto') 
    WITH (eMail varchar(100))
  IF @eMail IS NULL SELECT @Ok = 53050

  RETURN 
END
GO

/************** spWSRecibir *************/
if exists (select * from sysobjects where id = object_id('dbo.spWSRecibir') and type = 'P') drop procedure dbo.spWSRecibir
GO
CREATE PROCEDURE spWSRecibir
			@xml		text
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ixml	int,
    @Mensaje	varchar(255),
    @Tipo	varchar(50),
    @Version	float,
    @Accion	varchar(20),
    @Ok		int,
    @OkRef	varchar(255)

  SELECT @Mensaje = NULL, @Ok = NULL, @OkRef = NULL
  BEGIN TRANSACTION

  EXEC sp_xml_preparedocument @ixml OUTPUT, @xml

  SELECT @Tipo = Tipo, @Version = Version, @Accion = Accion
    FROM OPENXML (@ixml, 'Intelisis/Movimiento') 
    WITH (Tipo varchar(50), Version float, Accion varchar(20))

  IF @Tipo = 'CompraAutoEndoso'
    EXEC spWSRecibirCompraAutoEndoso @ixml, @Version, @Accion, @Ok OUTPUT, @OkRef OUTPUT
  ELSE
  IF @Tipo = 'Prospecto/Web'
    EXEC spWSRecibirProspectoWeb @ixml, @Version, @Accion, @Ok OUTPUT, @OkRef OUTPUT
  ELSE SELECT @Ok = 73030, @OkRef = @Tipo

  EXEC sp_xml_removedocument @ixml

  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = NULL
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = RTRIM(Descripcion)+' '+ISNULL(@OkRef, '') FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT 'Mensaje' = @Mensaje
  RETURN 
END
GO

/************** spExchangeRecibir *************/
if exists (select * from sysobjects where id = object_id('dbo.spExchangeRecibir') and type = 'P') drop procedure dbo.spExchangeRecibir
GO
CREATE PROCEDURE spExchangeRecibir
			@xml		text
--//WITH ENCRYPTION
AS BEGIN
  RETURN 
END
GO


/**************** spUsuarioMenuOpcionBorrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spUsuarioMenuOpcionBorrar') and type = 'P') 
  drop procedure dbo.spUsuarioMenuOpcionBorrar
GO
CREATE PROCEDURE spUsuarioMenuOpcionBorrar
		    @Usuario	varchar(10),
		    @Menu	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DELETE UsuarioMenuOpcion WHERE Usuario = @Usuario AND Menu = @Menu 
END
GO


/**************** spMenuCfg ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMenuCfg') and type = 'P') 
  drop procedure dbo.spMenuCfg
GO
CREATE PROCEDURE spMenuCfg
		    @Empresa		char(5),
		    @Sucursal		int,
		    @Usuario		char(10),
		    @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @TabApariencia bit

  SELECT @TabApariencia = 1

  SELECT 'ColorEntrada' = 'Blue',
         'MinutosAutoRefrescar' = MensajeAutoRefrescar,
         'MostrarTabApariencia' = @TabApariencia,
	 Mensaje1, Mensaje2, Mensaje3, Mensaje4,
         URL1, URL2, URL3, URL4
    FROM EmpresaGral
   WHERE Empresa = @Empresa
END
GO

-- EXEC spMenuCfg @Empresa = 'DEMO', @Sucursal = 0, @Usuario = 'DEMO', @Estacion = 59

-- spMenu 'DEMO', 0, 'DEMO', 100
/**************** spMenu ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMenu') and type = 'P') 
  drop procedure dbo.spMenu
GO
CREATE PROCEDURE spMenu
		    @Empresa		char(5),
		    @Sucursal		int,
		    @Usuario		char(10),
		    @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Menu		varchar(50),
    @MenuAccesoTotal	bit

  SELECT @Menu = Menu FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT @Menu = ISNULL(NULLIF(RTRIM(Menu), ''), @Menu), @MenuAccesoTotal = ISNULL(MenuAccesoTotal, 0) FROM Usuario WHERE Usuario = @Usuario

  IF @MenuAccesoTotal = 1
    SELECT o.Opcion, 'Rama' = dbo.fnEstructuraRama(o.Opcion), o.Tipo, o.Nombre, a.Descripcion, 'Visible' = ISNULL(a.Visible, 1),
           a.VisibleCondicion, 'Activo' = ISNULL(a.Activo, 1), a.ActivoCondicion, a.Expresion,
           o.EspacioPrevio, o.TeclaRapida , o.BotonGrande, o.Imagen
      FROM MenuOpcion o
      LEFT OUTER JOIN MenuAccion a ON a.Accion = o.Accion AND a.Estatus = 'ALTA'
     WHERE o.Menu = @Menu
     ORDER BY o.OpcionOrden
  ELSE
    SELECT o.Opcion, 'Rama' = dbo.fnEstructuraRama(o.Opcion), o.Tipo, o.Nombre, a.Descripcion, 'Visible' = ISNULL(a.Visible, 1),
           a.VisibleCondicion, 'Activo' = ISNULL(a.Activo, 1), a.ActivoCondicion, a.Expresion,
           o.EspacioPrevio, o.TeclaRapida , o.BotonGrande, o.Imagen
      FROM MenuOpcion o
      JOIN UsuarioMenuOpcion u ON u.Usuario = @Usuario AND u.Menu = o.Menu AND u.Opcion = o.Opcion AND u.Estatus = 'ALTA'
      LEFT OUTER JOIN MenuAccion a ON a.Accion = o.Accion AND a.Estatus = 'ALTA'
     WHERE o.Menu = @Menu
     ORDER BY o.OpcionOrden
END
GO

-- spMenuTicker 'DEMO', 0, 'DEMO', 100
/**************** spMenuTicker ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMenuTicker') and type = 'P') 
  drop procedure dbo.spMenuTicker
GO
CREATE PROCEDURE spMenuTicker
		    @Empresa		char(5),
		    @Sucursal		int,
		    @Usuario		char(10),
		    @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int

  SELECT @ID = MIN(ID) FROM MenuTicker
  SELECT Mensaje1, Tipo1, Mensaje2, Tipo2 FROM MenuTicker WHERE ID = @ID
END
GO

/**************** spSesion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSesion') and type = 'P') 
  drop procedure dbo.spSesion
GO
CREATE PROCEDURE spSesion
			@Accion			varchar(20),		-- LOGIN, LOGOUT, BLOQUEAR
			@Sesion			int		OUTPUT,
			@Empresa		char(5),
			@Sucursal		int,
			@Usuario		varchar(10),
			@FechaTrabajo		datetime,
			@EstacionTrabajo	int		= NULL,
			@IP			varchar(20)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Accion = 'LOGIN'
  BEGIN
    INSERT Sesion (
            Empresa,  Sucursal,  Usuario,  FechaTrabajo,  EstacionTrabajo,  IP,  Estatus)
    VALUES (@Empresa, @Sucursal, @Usuario, @FechaTrabajo, @EstacionTrabajo, @IP, 'ALTA')
    SELECT @Sesion = SCOPE_IDENTITY()
  END ELSE
  IF @Accion = 'LOGOUT'
    UPDATE Sesion SET Estatus = 'BAJA' WHERE Sesion = @Sesion
  ELSE
  IF @Accion = 'BLOQUEAR'
    UPDATE Sesion SET Estatus = 'BLOQUEADO' WHERE Sesion = @Sesion
END
GO



/**************** spVarSet ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVarSet') and type = 'P') 
  drop procedure dbo.spVarSet
GO
CREATE PROCEDURE spVarSet
		    @Sesion		int,
		    @Variable		varchar(100),
		    @Valor		varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
  UPDATE SesionVar SET Valor = @Valor WHERE Sesion = @Sesion AND Variable = @Variable
  IF @@ROWCOUNT = 0
    INSERT SesionVar (Sesion, Variable, Valor) VALUES (@Sesion, @Variable, @Valor)
END
GO


/**************** spVarGet ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVarGet') and type = 'P') 
  drop procedure dbo.spVarGet
GO
CREATE PROCEDURE spVarGet
		    @Sesion		int,
		    @Variable		varchar(100),
		    @Valor		varchar(8000)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Valor = NULL
  SELECT @Valor = Valor FROM SesionVar WHERE Sesion = @Sesion AND Variable = @Variable
END
GO

/**************** fnVarGet ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnVarGet') DROP FUNCTION fnVarGet
GO
CREATE FUNCTION fnVarGet (@Sesion int, @Variable varchar(100))
RETURNS varchar(8000)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Valor varchar(8000)

  SELECT @Valor = NULL
  SELECT @Valor = Valor FROM SesionVar WHERE Sesion = @Sesion AND Variable = @Variable

  RETURN(@Valor)
END
GO


/**************** spFormaExtraCarpetaVista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaExtraCarpetaVista') and type = 'P') 
  drop procedure dbo.spFormaExtraCarpetaVista
GO
CREATE PROCEDURE spFormaExtraCarpetaVista
			@Accion		varchar(20),		-- AGREGAR, ELIMINAR
			@FormaExtra	varchar(100),
			@Carpeta	varchar(100),
			@Vista		varchar(100),
			@Datos		text
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Accion = UPPER(@Accion)
  IF @Accion = 'AGREGAR'
  BEGIN
    UPDATE FormaExtraCarpetaVista
       SET Datos = @Datos
     WHERE FormaExtra = @FormaExtra AND Carpeta = @Carpeta AND Vista = @Vista
    IF @@ROWCOUNT = 0
      INSERT FormaExtraCarpetaVista (FormaExtra, Carpeta, Vista, Datos) VALUES (@FormaExtra, @Carpeta, @Vista, @Datos)
  END ELSE
  IF @Accion = 'ELIMINAR'
    DELETE FormaExtraCarpetaVista
     WHERE FormaExtra = @FormaExtra AND Carpeta = @Carpeta AND Vista = @Vista

  RETURN
END
GO

/**************** spCompraDPresupuestoEsp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraDPresupuestoEsp') and type = 'P') drop procedure dbo.spCompraDPresupuestoEsp
GO
CREATE PROCEDURE spCompraDPresupuestoEsp
			@ID		int,
			@Renglon	float,
			@RenglonSub	int,
			@Articulo	varchar(20),
			@Importe	money
--//WITH ENCRYPTION
AS BEGIN
  IF NOT EXISTS(SELECT * FROM CompraDPresupuestoEsp WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub)
    INSERT CompraDPresupuestoEsp (
           ID, Renglon, RenglonSub, CuentaPresupuesto, Importe, Sucursal, SucursalOrigen)
    SELECT @ID, @Renglon, @RenglonSub, a.CuentaPresupuesto, @Importe, e.Sucursal, e.SucursalOrigen
      FROM Art a 
      JOIN Compra e ON e.ID = @ID
     WHERE a.Articulo = @Articulo AND NULLIF(RTRIM(a.CuentaPresupuesto), '') IS NOT NULL
  RETURN
END
GO


/**************** spVentaDPresupuestoEsp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaDPresupuestoEsp') and type = 'P') drop procedure dbo.spVentaDPresupuestoEsp
GO
CREATE PROCEDURE spVentaDPresupuestoEsp
			@ID		int,
			@Renglon	float,
			@RenglonSub	int,
			@Articulo	varchar(20),
			@Importe	money
--//WITH ENCRYPTION
AS BEGIN
  IF NOT EXISTS(SELECT * FROM VentaDPresupuestoEsp WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub)
    INSERT VentaDPresupuestoEsp (
           ID, Renglon, RenglonSub, CuentaPresupuesto, Importe, Sucursal, SucursalOrigen)
    SELECT @ID, @Renglon, @RenglonSub, a.CuentaPresupuesto, @Importe, e.Sucursal, e.SucursalOrigen
      FROM Art a 
      JOIN Venta e ON e.ID = @ID
     WHERE a.Articulo = @Articulo AND NULLIF(RTRIM(a.CuentaPresupuesto), '') IS NOT NULL
  RETURN
END
GO


/**************** spGastoDPresupuestoEsp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoDPresupuestoEsp') and type = 'P') drop procedure dbo.spGastoDPresupuestoEsp
GO
CREATE PROCEDURE spGastoDPresupuestoEsp
			@ID		int,
			@Renglon	float,
			@RenglonSub	int,
			@Concepto	varchar(50),
			@Importe	money
--//WITH ENCRYPTION
AS BEGIN
  IF NOT EXISTS(SELECT * FROM GastoDPresupuestoEsp WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub)
    INSERT GastoDPresupuestoEsp (
           ID, Renglon, RenglonSub, CuentaPresupuesto, Importe, Sucursal, SucursalOrigen)
    SELECT @ID, @Renglon, @RenglonSub, c.CuentaPresupuesto, @Importe, e.Sucursal, e.SucursalOrigen
      FROM Concepto c 
      JOIN Gasto e ON e.ID = @ID
     WHERE c.Modulo = 'GAS' AND c.Concepto = @Concepto AND NULLIF(RTRIM(c.CuentaPresupuesto), '') IS NOT NULL
  RETURN
END
GO


/*
SELECT @Modulo, @ID, a.CuentaPresupuesto, SUM(d.ImporteTotal) FROM CompraTCalc d, Art a WHERE d.ID = @ID AND d.Articulo = a.Articulo GROUP BY a.CuentaPresupuesto
SELECT @Modulo, @ID, a.CuentaPresupuesto, SUM(d.ImporteTotal) FROM VentaTCalc d, Art a WHERE d.ID = @ID AND d.Articulo = a.Articulo GROUP BY a.CuentaPresupuesto

*/


/**************** spModuloAgregarMovPresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spModuloAgregarMovPresupuesto') and type = 'P') drop procedure dbo.spModuloAgregarMovPresupuesto
GO
CREATE PROCEDURE spModuloAgregarMovPresupuesto
			@Modulo		char(5),
			@ID		int,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon		float,
    @RenglonSub		int,
    @Articulo		varchar(20),
    @Concepto		varchar(50),
    @PresupuestoEsp	bit,
    @CuentaPresupuesto	varchar(20),
    @Importe		money,
    @ImporteEsp		money,
    @NoCuadra		bit

  CREATE TABLE #ModuloPresupuesto (
    CuentaPresupuesto		varchar(20)     COLLATE Database_Default NULL, 
    Importe			money		NULL)

  IF @Modulo = 'VTAS'
    DECLARE crModuloPresupuesto CURSOR FOR 
     SELECT Renglon, RenglonSub, Articulo, CONVERT(varchar(50), NULL), PresupuestoEsp, ImporteTotal
       FROM VentaTCalc
      WHERE ID = @ID
  ELSE
  IF @Modulo = 'COMS'
    DECLARE crModuloPresupuesto CURSOR FOR 
     SELECT Renglon, RenglonSub, Articulo, CONVERT(varchar(50), NULL), PresupuestoEsp, ImporteTotal
       FROM CompraTCalc
      WHERE ID = @ID
  ELSE
  IF @Modulo = 'GAS'
    DECLARE crModuloPresupuesto CURSOR FOR 
     SELECT Renglon, RenglonSub, CONVERT(varchar(20), NULL), Concepto, PresupuestoEsp, TotalLinea
       FROM GastoT
      WHERE ID = @ID

  OPEN crModuloPresupuesto
  FETCH NEXT FROM crModuloPresupuesto INTO @Renglon, @RenglonSub, @Articulo, @Concepto, @PresupuestoEsp, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @CuentaPresupuesto = NULL
      IF @Articulo IS NOT NULL SELECT @CuentaPresupuesto = CuentaPresupuesto FROM Art WHERE Articulo = @Articulo ELSE
      IF @Concepto IS NOT NULL SELECT @CuentaPresupuesto = CuentaPresupuesto FROM Concepto WHERE Modulo = @Modulo AND Concepto = @Concepto

      IF @PresupuestoEsp = 0
      BEGIN
        INSERT #ModuloPresupuesto (CuentaPresupuesto, Importe) VALUES (@CuentaPresupuesto, @Importe)
        IF @Modulo = 'VTAS' DELETE VentaDPresupuestoEsp  WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
        IF @Modulo = 'COMS' DELETE CompraDPresupuestoEsp WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
        IF @Modulo = 'GAS'  DELETE GastoDPresupuestoEsp  WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END ELSE BEGIN
        SELECT @ImporteEsp = 0.0
        IF @Modulo = 'VTAS' SELECT @ImporteEsp = SUM(Importe) FROM VentaDPresupuestoEsp  WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
        IF @Modulo = 'COMS' SELECT @ImporteEsp = SUM(Importe) FROM CompraDPresupuestoEsp WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
        IF @Modulo = 'GAS'  SELECT @ImporteEsp = SUM(Importe) FROM GastoDPresupuestoEsp  WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 

        IF @Importe <> @ImporteEsp
          SELECT @Ok = 25510, @OkRef = ISNULL(@Articulo, '')+ISNULL(@Concepto, '')+', Diferencia: '+CONVERT(varchar, @Importe-@ImporteEsp)
        ELSE BEGIN
          IF @Modulo = 'VTAS' INSERT #ModuloPresupuesto (CuentaPresupuesto, Importe) SELECT CuentaPresupuesto, Importe FROM VentaDPresupuestoEsp   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
          IF @Modulo = 'COMS' INSERT #ModuloPresupuesto (CuentaPresupuesto, Importe) SELECT CuentaPresupuesto, Importe FROM CompraDPresupuestoEsp  WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
          IF @Modulo = 'GAS'  INSERT #ModuloPresupuesto (CuentaPresupuesto, Importe) SELECT CuentaPresupuesto, Importe FROM GastoDPresupuestoEsp   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        END
      END
    END
    FETCH NEXT FROM crModuloPresupuesto INTO @Renglon, @RenglonSub, @Articulo, @Concepto, @PresupuestoEsp, @Importe
  END
  CLOSE crModuloPresupuesto
  DEALLOCATE crModuloPresupuesto

  DELETE MovPresupuesto WHERE Modulo = @Modulo AND ModuloID = @ID
  INSERT MovPresupuesto (
         Modulo, ModuloID, CuentaPresupuesto, Importe) 
  SELECT @Modulo, @ID, CuentaPresupuesto, SUM(Importe) 
    FROM #ModuloPresupuesto
   GROUP BY CuentaPresupuesto

  DROP TABLE #ModuloPresupuesto
  RETURN
END
GO


-- spIntelisisJob
/**************** spIntelisisJob ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisJob') and sysstat & 0xf = 4) drop procedure dbo.spIntelisisJob
GO             
CREATE PROCEDURE spIntelisisJob
--//WITH ENCRYPTION
AS
BEGIN
/*  DECLARE
	@Fecha		datetime,
        @Hora		varchar(10)

  SELECT @Fecha = GETDATE()
  SELECT @Hora = Convert(varchar(10), @Fecha, 108)

  IF @Hora BETWEEN '02:00:00' AND '02:29:59'
    EXEC spHist 3
*/
  RETURN
END
GO

/*
Enrique Toral 27/Oct/2008
Rutina para calcular el precio en el punto de venta del juego o del componente
*/
--exec spVerPVPrecioJuego 'DEMO', 0, '(Precio lista)', 'J1', 'e', 'AA8', 'Pesos', 1
--exec spVerPVPrecioJuego @Empresa = 'DEMO', @Sucursal = 0, @ListaPrecios = '(Precio lista)', @Articulo = 'J1', @Juego = 'E', @Componente = 'AA8', @MovMoneda = 'Pesos', @MovTipoCambio= 1
/**************** spVerPVPrecioJuego ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerPVPrecioJuego') and type = 'P') 
  drop procedure dbo.spVerPVPrecioJuego
GO             
CREATE PROCEDURE spVerPVPrecioJuego
      @Empresa          char(5),
      @Sucursal         int,
      @ListaPrecios     char(20),

      @Articulo         char(20),
      @Juego            char(10),
      @Componente       char(20),

      @MovMoneda        char(10),
      @MovTipoCambio    float
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @PrecioIndependiente    bit,
    @ListaPreciosEsp        char(20),
    @Precio                 money,
    @Tipo		    varchar(20)

  SELECT @Componente = NULLIF(RTRIM(@Componente), ''), @Tipo = NULL

-- Calcula Precio del juego
  IF @Componente IS NULL BEGIN
    EXEC spPCGet @Sucursal, @Empresa, @Articulo, NULL, NULL, @MovMoneda, @MovTipoCambio,
                 @ListaPreciosEsp, @Precio OUTPUT, 0
  END ELSE BEGIN
-- Calcula Precio del componente
    SELECT @Tipo = Tipo 
      FROM Art a
     WHERE a.Articulo = @Componente

    SELECT @PrecioIndependiente = ISNULL(aj.PrecioIndependiente, 0),
           @ListaPreciosEsp = NULLIF(RTRIM(aj.ListaPreciosEsp), '')
      FROM Art a
      JOIN ArtJuego aj ON a.Articulo = aj.Articulo
      JOIN ArtJuegoD ajd ON aj.Articulo = ajd.Articulo AND aj.Juego = ajd.Juego
     WHERE a.Articulo = @Articulo
       AND aj.Juego = @Juego
       AND ajd.Opcion = @Componente

    IF @PrecioIndependiente = 1 BEGIN
      IF @ListaPreciosEsp IS NULL
        SELECT @ListaPreciosEsp = @ListaPrecios
      EXEC spPCGet @Sucursal, @Empresa, @Componente, NULL, NULL, @MovMoneda, @MovTipoCambio,
                   @ListaPreciosEsp, @Precio OUTPUT, 0
    END ELSE
      SELECT @Precio = 0
  END

  SELECT "Precio" = @Precio, "Tipo" = @Tipo
  RETURN
END
GO


-- spVFA
/**************** spVFA ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVFA') and sysstat & 0xf = 4) drop procedure dbo.spVFA
GO             
CREATE PROCEDURE spVFA
		@Empresa        varchar(5),
		@Usuario	varchar(10),
		@Sucursal       int,
		@Modulo		varchar(5),
		@ID		varchar(50),
		@Renglon	float,
		@Referencia	varchar(50),
		@Accion		varchar(20),
		@Importe	money,
		@AutorizacionID	varchar(50),
		@Respuesta	varchar(max)
--//WITH ENCRYPTION
AS
BEGIN
--REQ 13393 POS
  IF @Modulo = 'POS' AND NULLIF(@Respuesta,'') IS NOT NULL
  BEGIN
    INSERT POSVFALog(IDModulo, Modulo,     Accion,  CodigoAutorizacion, EstatusTransaccion, FechaTransaccion, IDTransaccion, Monto, Moneda, NumeroTarjeta, Tarjetahabiente, Error, Mensaje, TransaccionOriginal, Referencia)
    SELECT           @ID,      @Modulo,    @Accion,*
      FROM(SELECT Parametro,Valor FROM dbo.fnPOSSepararCadenaVFA (@Respuesta)) tabla
     PIVOT( MAX(Valor)
       FOR [Parametro] IN ([[CODIGO_AUT], [ESTATUS_TRANSACCION_L], [FECHA_TRANSACCION], [ID_TRANSACCION], [MONTO], [MONEDA], [NUMERO_TARJETA],  [TARJETAHABIENTE], [ERROR],  [MENSAJES], [TRANS_ORIGINAL], [REFERENCIA])) p
  
  END

  RETURN
END
GO

/**************** spVentaAF ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaAF') and type = 'P') drop procedure dbo.spVentaAF
GO  

CREATE PROCEDURE spVentaAF        
@ID			AS INT,               
@RID		AS INT       
--//WITH ENCRYPTION      
AS        
BEGIN        
        
SELECT af.AdquisicionValor 
  FROM SerieLoteMov sl 
  JOIN ActivoF af ON af.Articulo=sl.Articulo AND af.Serie=sl.SerieLote 
 WHERE sl.Modulo='VTAS' AND sl.ID=@ID AND sl.RenglonID=@RID     
          
END
GO

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET QUOTED_IDENTIFIER OFF
SET NOCOUNT ON
SET IMPLICIT_TRANSACTIONS OFF
GO

IF EXISTS(SELECT * FROM SysObjects WHERE type='fn' and name='fn_CanalesCte')
DROP FUNCTION fn_CanalesCte
GO
CREATE FUNCTION fn_CanalesCte(@Cadena VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
	 DECLARE @resultado	VARCHAR(50)
	 
	 SET @resultado=(SELECT Valor 
	                 FROM TablaSTD ts	
	                 WHERE ts.TablaSt='CategoriasArts'
	                 AND ts.Nombre=@Cadena)
	 
	 RETURN @resultado
END
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCalcPrepEjercido' AND type = 'FN') DROP FUNCTION fnCalcPrepEjercido
GO
CREATE FUNCTION fnCalcPrepEjercido (@Empresa char(5),@Concepto varchar(50),@FechaD datetime,@FechaA Datetime,@Cual VarChar(10))
RETURNS Money
--WITH ENCRYPTION
AS BEGIN
	DECLARE
			@Importe		Money
	IF @Cual='Ejercido'
     begin
	SELECT @Importe=SUM((d.Importe-ISNULL(d.Provision, 0.0))*e.TipoCambio*CASE WHEN mt.Clave='GAS.DG' THEN -1 ELSE 1 END) 
      FROM Gasto e, GastoD d, MovTipo mt 
     WHERE Empresa = @Empresa AND e.ID = d.ID AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO') 
       AND e.Fechaemision between @Fechad and @FechaA
       AND d.Concepto = @Concepto /*AND e.Moneda = @MovMoneda*/ 
       --AND ISNULL(d.ContUso, '') = ISNULL(ISNULL(@ContUso, d.ContUso), '')
      AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.G', 'GAS.P', 'GAS.GTC', 'GAS.C', 'GAS.DG', 'GAS.DPR', 'GAS.EST', 'GAS.CI')
   end 
	IF @Cual='Pendiente' 
	begin       
   SELECT @Importe=(SUM(d.Importe*mt.Factor*e.TipoCambio))
      FROM Gasto e, GastoD d, MovTipo mt 
     WHERE Empresa = @Empresa AND e.ID = d.ID AND e.Estatus = 'PENDIENTE' 
      AND e.Fechaemision between @Fechad and @FechaA
      AND d.Concepto = @Concepto 
      --AND ISNULL(d.ContUso, '') = ISNULL(ISNULL(@ContUso, d.ContUso), '')
      AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.S', 'GAS.A')
  end
	RETURN(@Importe)
END 
GO

IF EXISTS(SELECT * FROM SysObjects WHERE type='fn' and name='fnCanalesCte')
DROP FUNCTION fnCanalesCte
GO
CREATE FUNCTION fnCanalesCte(@Cadena VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @CadenaR	VARCHAR(50)
	
	IF @Cadena IN (SELECT DISTINCT Categoria 
							   FROM Cte 
							  WHERE Categoria IS NOT NULL 
								AND Categoria NOT LIKE '' 
							AND Categoria NOT IN ('E-TAIL','RETAIL','Installers'))
    SET @CadenaR='IT'

	ELSE
	  BEGIN
		IF @Cadena='Installers'
			SET @CadenaR='INSTALLERS'
		ELSE
			BEGIN
				IF @Cadena IN (SELECT DISTINCT Categoria 
							   FROM Cte 
							  WHERE Categoria IS NOT NULL 
								AND Categoria NOT LIKE '' 
							AND Categoria IN ('E-TAIL','RETAIL'))
				SET @CadenaR=REPLACE(@Cadena,'-','')
				ELSE
					BEGIN
						IF @Cadena NOT IN (SELECT DISTINCT Categoria
										   FROM Cte 
										  WHERE Categoria IN ('ETAIL','RETAIL','Installers'))
						SET @CadenaR='IT'
						ELSE
							BEGIN
								IF @Cadena='Installers'
									SET @CadenaR='INSTALLERS'
								ELSE
									BEGIN
										IF @Cadena IN (SELECT DISTINCT Categoria 
														   FROM Cte 
														  WHERE Categoria IN ('ETAIL','RETAIL'))
										SET @CadenaR=@Cadena
									END 
							END
					END
			END
	  END

    RETURN @CadenaR
END
GO

IF EXISTS(SELECT * FROM sysobjects s WHERE s.[type]='p' AND s.name='spPresupuestoComsGral')
DROP PROCEDURE spPresupuestoComsGral
GO
CREATE PROCEDURE spPresupuestoComsGral
@Ejercicio	INT
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @compras TABLE (
	Articulo	VARCHAR(30),
	Grupo		VARCHAR(30),
	Importe		MONEY,
	Periodo		INT		
)

DECLARE @OrdenCompra_tbl TABLE(
	MovID		INT,
	Grupo		VARCHAR(30),
	Articulo	VARCHAR(30),
	Importe		MONEY,
	Periodo		INT
)

DECLARE @CompraPerdida_tbl TABLE(
	MovID		INT,
	Articulo	VARCHAR(30),
	Importe		MONEY
)

DECLARE @presupuesto TABLE (
	Grupo		VARCHAR(30),
	Importe		MONEY,
	Periodo		INT	
)


INSERT INTO @OrdenCompra_tbl
SELECT c.MovID 
	  ,a.Grupo
	  ,cd.Articulo
	  ,cd.Cantidad*(cd.costo*c.TipoCambio) AS 'Importe' 
	  ,c.Periodo
FROM Compra c
JOIN CompraD cd ON cd.ID=c.ID
RIGHT JOIN Art a ON a.Articulo=cd.Articulo
JOIN MovTipo mt ON mt.Mov=c.Mov
WHERE mt.Modulo='COMS'
AND mt.Orden=25
AND c.Estatus IN ('CONCLUIDO','PENDIENTE')
AND c.Ejercicio=@Ejercicio
order by c.MovID,c.periodo,a.Grupo

INSERT INTO @CompraPerdida_tbl
SELECT c.OrigenID
	   ,cd.Articulo
	   ,(cd.Cantidad*(cd.Costo*c.TipoCambio)) as 'Importe'
FROM Compra c
JOIN CompraD cd ON cd.ID=C.ID
JOIN Art a ON a.Articulo=cd.Articulo
JOIN MovTipo mt ON c.Mov=mt.Mov
WHERE mt.Modulo='COMS'
AND mt.Clave='COMS.CP'
AND c.Origen='Orden Compra'
AND c.Estatus='CONCLUIDO'
and c.Ejercicio=@Ejercicio


INSERT INTO @compras
SELECT oc.Articulo
	  ,oc.Grupo
	  ,ISNULL(oc.Importe,0)-ISNULL(cp.Importe,0) as 'TotalNeto'
	  ,oc.Periodo
FROM @OrdenCompra_tbl oc
LEFT JOIN @CompraPerdida_tbl cp ON oc.MovID=cp.MovID AND oc.Articulo=cp.Articulo


INSERT INTO @presupuesto
SELECT a.Grupo
	  ,SUM(cd.cantidad*cd.costo) AS 'Importe'
	  ,c.Periodo
FROM Compra c
JOIN CompraD AS cd ON cd.ID=c.ID
JOIN Art a ON a.Articulo=cd.Articulo
JOIN MovTipo mt ON mt.Mov=c.Mov
WHERE mt.Modulo='COMS'
AND mt.Clave='COMS.PR'
AND c.Estatus='CONCLUIDO'
AND c.Ejercicio=@Ejercicio
GROUP BY a.Grupo,c.Periodo
order by a.Grupo,c.Periodo


SELECT ISNULL(p.Grupo,c.Grupo) AS 'Grupo'
	  ,ISNULL(p.Importe,0) AS 'ImportePresupuesto'
	  ,ISNULL(SUM(c.Importe),0) AS 'ImporteCompras'
	  ,ISNULL(p.Periodo,c.Periodo) AS 'Periodo'
FROM @presupuesto p
FULL JOIN @compras c ON c.Grupo = p.Grupo AND c.Periodo = p.Periodo
GROUP BY P.Grupo,p.Importe,p.Periodo,c.Grupo,c.Importe,c.Periodo
ORDER BY p.Periodo
END
GO

IF EXISTS(SELECT * FROM sysobjects s WHERE s.[type]='p' AND s.name='spPresupuestoVentaCanal')
DROP PROCEDURE spPresupuestoVentaCanal
GO
CREATE PROCEDURE spPresupuestoVentaCanal
@Ejercicio	INT
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @ventas TABLE (
	CanalCte	VARCHAR(30),
	Importe		MONEY,
	Periodo		INT		
)

DECLARE @presupuesto TABLE (
	CanalCte	VARCHAR(30),
	Importe		MONEY,
	Periodo		INT	
)

INSERT INTO @ventas
SELECT dbo.fn_CanalesCte(c.Categoria) AS 'CanalCte'
	   ,SUM(CASE WHEN mt.clave = 'VTAS.D' THEN (vt.SubTotal*-1)*vt.TipoCambio ELSE (vt.SubTotal*vt.TipoCambio) END ) AS 'Importe'
	   ,vt.Periodo
FROM VentaTCalc AS vt
JOIN MovTipo AS mt ON mt.Mov = vt.Mov
JOIN Art AS a ON a.Articulo = vt.Articulo
JOIN Cte c ON c.Cliente=vt.Cliente
WHERE mt.Modulo='VTAS'
AND mt.Clave IN ('VTAS.F','VTAS.D')
AND vt.Estatus='CONCLUIDO'
AND vt.Ejercicio=@Ejercicio
GROUP BY dbo.fn_CanalesCte(c.Categoria),vt.Periodo


INSERT INTO @presupuesto
SELECT DISTINCT dbo.fn_CanalesCte(c.Categoria) AS 'CanalCte'
	  ,v.Importe as 'Importe'
	  ,v.Periodo
FROM Venta v
JOIN VentaD vd ON vd.ID=v.ID
JOIN Cte c ON c.Cliente=v.Cliente
JOIN MovTipo mt ON mt.Mov=v.Mov
WHERE mt.Modulo='VTAS'
AND mt.Clave='VTAS.PR'
AND v.Estatus='CONCLUIDO'
AND v.Ejercicio=@Ejercicio
--GROUP BY dbo.fnCanalesCte(c.Nombre),v.Periodo
order by v.Periodo,CanalCte



SELECT DISTINCT ISNULL(p.CanalCte,v.CanalCte) as 'CanalCte'
			   ,ISNULL(P.Importe,0) as 'ImportePresupuesto'
			   ,ISNULL(v.Importe,0) as 'ImporteVtas'
			   ,ISNULL(v.Periodo,p.Periodo) as 'Periodo'
FROM @presupuesto P
FULL JOIN @ventas v ON v.CanalCte=p.CanalCte AND v.Periodo=p.Periodo
ORDER BY Periodo

END
GO

IF EXISTS(SELECT * FROM sysobjects s WHERE s.[type]='p' AND s.name='spPresupuestoVentaCanales')
DROP PROCEDURE spPresupuestoVentaCanales
GO
CREATE PROCEDURE spPresupuestoVentaCanales
@Ejercicio	INT
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @ventas TABLE (
	Grupo		VARCHAR(50),
	CanalCte	VARCHAR(30),
	Importe		MONEY,
	Periodo		INT
)

DECLARE @presupuesto TABLE (
	Grupo		VARCHAR(50),
	CanalCte	VARCHAR(30),
	Importe		MONEY,
	Periodo		INT
)

DECLARE @presupuesto_tbl TABLE (
	Grupo		VARCHAR(50),
	CanalCte	VARCHAR(30),
	Importe		MONEY,
	Periodo		INT
)

INSERT INTO @ventas
SELECT a.grupo
	   ,dbo.fn_CanalesCte(c.Categoria) AS 'CanalCte'
	   ,SUM(CASE WHEN mt.clave='VTAS.D' THEN (vt.SubTotal*-1)*vt.TipoCambio ELSE (vt.SubTotal*vt.TipoCambio) END ) AS 'Importe'
	   ,vt.Periodo
FROM VentaTCalc AS vt
JOIN MovTipo AS mt ON mt.Mov = vt.Mov
JOIN Art AS a ON a.Articulo = vt.Articulo
JOIN Cte c ON c.Cliente=vt.Cliente
WHERE mt.Modulo='VTAS'
AND mt.Clave IN ('VTAS.F','VTAS.D')
AND vt.Estatus='CONCLUIDO'
AND vt.Ejercicio=@Ejercicio
GROUP BY a.grupo,dbo.fn_CanalesCte(c.Categoria),vt.Periodo



INSERT INTO @presupuesto
SELECT a.grupo
      ,dbo.fn_CanalesCte(c.Categoria) AS 'CanalCte'
	  ,vd.cantidad*vd.Precio as 'Importe'
	  ,v.Periodo
FROM Venta AS v 
JOIN VentaD vd ON v.ID = vd.ID
LEFT JOIN Art AS a ON a.Articulo = vd.Articulo 
JOIN Cte c ON c.Cliente=v.Cliente
JOIN MovTipo mt ON mt.Mov=v.Mov
WHERE mt.Modulo='VTAS'
AND mt.Clave='VTAS.PR'
AND v.Estatus='CONCLUIDO'
AND v.Ejercicio=@Ejercicio
--GROUP BY a.Grupo,v.Cliente,v.Periodo
order by v.Periodo,CanalCte;


WITH presup_tbl
AS
(
	SELECT distinct a.grupo
		  ,dbo.fn_CanalesCte(c.Categoria) AS 'CanalCte'
		  ,v.Periodo
		FROM Venta AS v 
		JOIN VentaD vd ON v.ID = vd.ID
		LEFT JOIN Art AS a ON a.Articulo = vd.Articulo 
		JOIN Cte c ON c.Cliente=v.Cliente
		JOIN MovTipo mt ON mt.Mov=v.Mov
		WHERE mt.Modulo='VTAS'
		AND mt.Clave='VTAS.PR'
		AND v.Estatus='CONCLUIDO'
		AND v.Ejercicio=@Ejercicio
)
INSERT INTO @presupuesto_tbl
SELECT DISTINCT pt.grupo
				,ISNULL(p.CanalCte,pt.CanalCte)
				,ISNULL(p.Importe,0)
				,ISNULL(p.Periodo,pt.Periodo)
FROM presup_tbl AS pt
LEFT JOIN @presupuesto AS p ON p.grupo = pt.grupo


SELECT DISTINCT ISNULL(pt.Grupo,v.grupo) as 'Grupo'
		,ISNULL(pt.CanalCte,v.CanalCte) as 'CanalCte'
        ,ISNULL(v.Importe,0) AS 'ImporteVentas'
		,ISNULL(pt.Importe,0) AS 'ImportePresupuesto'
		,ISNULL(pt.Periodo,v.Periodo) as 'Periodo'
FROM @presupuesto_tbl AS pt
FULL JOIN @ventas V ON pt.Periodo = V.Periodo AND pt.Grupo = V.Grupo AND pt.CanalCte = V.CanalCte
ORDER BY CanalCte,Periodo


END
GO

IF EXISTS(SELECT * FROM sysobjects s WHERE s.[type]='p' AND s.name='spPresupuestoVentaGral')
DROP PROCEDURE spPresupuestoVentaGral
GO
CREATE PROCEDURE spPresupuestoVentaGral
@Ejercicio	INT
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @ventas TABLE (
	Grupo		VARCHAR(30),
	CanalCte	VARCHAR(30),
	Importe		MONEY,
	Periodo		INT		
)

DECLARE @presupuesto TABLE (
	Grupo		VARCHAR(30),
	CanalCte	VARCHAR(30),
	Importe		MONEY,
	Periodo		INT	
)

INSERT INTO @ventas
SELECT a.grupo
	   ,dbo.fn_CanalesCte(c.Categoria) AS 'CanalCte'
	  ,SUM(v.Importe*v.TipoCambio) as 'Importe'
	  ,v.Periodo
FROM Venta v
JOIN VentaD vd ON vd.ID=v.ID
JOIN Cte c ON c.Cliente=v.Cliente
RIGHT JOIN Art a ON a.Articulo=vd.Articulo
JOIN MovTipo mt ON mt.Mov=v.Mov
WHERE mt.Modulo='VTAS'
AND mt.Clave IN ('VTAS.F','VTAS.D')
AND v.Estatus='CONCLUIDO'
AND a.Grupo <> 'Servicios'
AND v.Ejercicio=@Ejercicio
GROUP BY a.Grupo,dbo.fn_CanalesCte(c.Categoria),v.Periodo
order by v.Periodo,a.Grupo,CanalCte


INSERT INTO @presupuesto
SELECT DISTINCT a.grupo,
	   dbo.fn_CanalesCte(c.Nombre) AS 'CanalCte'
	  ,v.Importe as 'Importe'
	  ,v.Periodo
FROM Venta v
JOIN VentaD vd ON vd.ID=v.ID
JOIN Cte c ON c.Cliente=v.Cliente
JOIN Art a ON a.Articulo=vd.Articulo
JOIN MovTipo mt ON mt.Mov=v.Mov
WHERE mt.Modulo='VTAS'
AND mt.Clave='VTAS.PR'
AND v.Estatus='CONCLUIDO'
AND v.Ejercicio=2016--@Ejercicio
--GROUP BY a.Grupo,v.Cliente,v.Periodo
order by v.Periodo,a.Grupo,CanalCte



SELECT ISNULL(v.Grupo,p.Grupo) as 'Grupo'
      ,ISNULL(v.CanalCte,p.CanalCte) as 'Grupo'
	  ,ISNULL(p.Importe,0) AS 'ImportePresupuesto'
	  ,ISNULL(v.Importe,0) AS 'ImporteVentas'
	  ,ISNULL(v.Periodo,p.Periodo) as 'Periodo'
FROM @presupuesto p 
FULL JOIN @ventas  v ON v.Grupo = p.Grupo AND v.Periodo = p.Periodo AND v.CanalCte=p.CanalCte
ORDER BY p.Periodo

END
GO

IF EXISTS(SELECT * FROM sysobjects s WHERE s.[type]='p' AND s.name='spPresupuestoVentaMarca')
DROP PROCEDURE spPresupuestoVentaMarca
GO
CREATE PROCEDURE spPresupuestoVentaMarca
@Ejercicio	INT
--//WITH ENCRYPTION
AS
BEGIN

DECLARE @ventas TABLE (
	Grupo		VARCHAR(30),
	Importe		MONEY,
	Periodo		INT		
)

DECLARE @presupuesto TABLE (
	Grupo		VARCHAR(30),
	Importe		MONEY,
	Periodo		INT	
)

INSERT INTO @ventas
SELECT a.grupo
	   ,SUM(CASE WHEN mt.clave = 'VTAS.D' THEN (vt.SubTotal*-1)*vt.TipoCambio ELSE (vt.SubTotal*vt.TipoCambio) END ) AS 'Importe'
	   ,vt.Periodo
FROM VentaTCalc AS vt
JOIN MovTipo AS mt ON mt.Mov = vt.Mov
JOIN Art AS a ON a.Articulo = vt.Articulo
WHERE mt.Modulo='VTAS'
AND mt.Clave IN ('VTAS.F','VTAS.D')
AND vt.Estatus='CONCLUIDO'
AND vt.Ejercicio=@Ejercicio
GROUP BY a.Grupo,vt.Periodo



INSERT INTO @presupuesto
SELECT a.grupo
	  ,SUM(vd.cantidad*vd.precio) as 'Importe'
	  ,v.Periodo
FROM Venta v
JOIN VentaD vd ON vd.ID=v.ID
JOIN Art a ON a.Articulo=vd.Articulo
JOIN MovTipo mt ON mt.Mov=v.Mov
WHERE mt.Modulo='VTAS'
AND mt.Clave='VTAS.PR'
AND v.Estatus='CONCLUIDO'
AND v.Ejercicio=@Ejercicio
GROUP BY a.grupo,v.Periodo
order by v.Periodo,a.Grupo


SELECT DISTINCT ISNULL(v.Grupo,p.Grupo) AS 'Grupo'
			   ,ISNULL(v.Importe,0) AS 'ImporteVtas'
			   ,ISNULL(p.Importe,0) AS 'ImportePresupuesto'
			   ,ISNULL(v.Periodo,p.Periodo) AS 'Periodo'
FROM @ventas v
FULL JOIN @presupuesto p ON p.Grupo = v.Grupo AND p.Periodo = v.Periodo


END
GO

IF EXISTS(SELECT * FROM sysobjects s WHERE s.[type]='p' AND s.name='spReportePresupuesto')
DROP PROCEDURE spReportePresupuesto
GO
CREATE PROCEDURE dbo.spReportePresupuesto  
@periodo	INT,
@ejercicio	INT 
--@contuso char(20)  
--//WITH ENCRYPTION
AS BEGIN   
  
  DECLARE @Gastos_tbl TABLE (
	Concepto	VARCHAR(100),
	Importe		MONEY,
	Ejercido1	MONEY,
	Pendiente	MONEY,
	Periodo		INT,
	Indicador	VARCHAR(20)
  )
  
  DECLARE @fechaa DATETIME =(SELECT MAX(Fecha) FROM Tiempo WHERE Mes=@periodo AND Anio=@Ejercicio),
		  @fechad DATETIME=(SELECT MIN(Fecha) FROM Tiempo  WHERE Mes=@periodo AND Anio=@Ejercicio);

INSERT INTO @Gastos_tbl
Select DISTINCT b.Concepto  
,CASE 
     WHEN mt.Clave IN ('GAS.PR') THEN SUM(b.Importe*a.tipocambio)
	 WHEN mt.Clave IN ('GAS.DG') THEN SUM(b.Importe*a.tipocambio)
     WHEN mt.Clave IN ('GAS.G') THEN 0
 END AS 'Importe'
, ISNULL(dbo.fnCalcPrepEjercido(a.Empresa,b.concepto,@Fechad,@Fechaa,'Ejercido'),0) as 'Ejercido1'
, ISNULL(dbo.fnCalcPrepEjercido(a.Empresa,b.concepto,@Fechad,@Fechaa,'Pendiente'),0) as 'Pendiente'
,a.Periodo
,mt.Clave  
From Gasto a 
JOIN  gastod b  ON a.id=b.id
JOIN MovTipo mt ON mt.Mov=a.Mov
Where  mt.Modulo='GAS'
AND mt.Clave IN ('GAS.PR','GAS.G','GAS.DG')   
AND a.estatus='CONCLUIDO'   
--and isnull(contuso,'')=isnull(isnull(@contuso,contuso),'')   
AND a.Ejercicio=@ejercicio
AND a.Periodo=@periodo  
Group by b.concepto,a.Empresa,a.periodo,mt.Clave;

WITH contabilidad_tbl
AS
(
	SELECT c.Concepto,SUM(c.Haber) AS 'Haber'
	FROM ContAux c
	WHERE c.Ejercicio=@ejercicio
	AND c.Periodo=@periodo
	AND c.Concepto IS NOT NULL
	AND c.Referencia LIKE 'Gasto%'
	GROUP BY c.Concepto
)
SELECT DISTINCT gt.Concepto,SUM(gt.Importe) AS 'Importe',ISNULL(gt.Ejercido1,0) AS 'Ejercido1',gt.Pendiente,gt.Periodo--,isnull(ct.Haber,0)
FROM @Gastos_tbl AS gt
LEFT JOIN contabilidad_tbl AS ct ON ct.Concepto = gt.Concepto 
GROUP BY gt.Concepto,gt.Pendiente,gt.Periodo,gt.Ejercido1,ct.Haber
	
END   
GO