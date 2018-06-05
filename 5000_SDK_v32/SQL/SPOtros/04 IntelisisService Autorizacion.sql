SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO


 /**************** spIntelisisServiceProcesarAutorizacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesarAutorizacion') and type = 'P') drop procedure dbo.spIntelisisServiceProcesarAutorizacion
GO
CREATE PROCEDURE spIntelisisServiceProcesarAutorizacion
                   @Sistema       varchar(100),
    		   @ID		  int,
		   @iSolicitud	  int,
		   @Solicitud     varchar(max),
		   @Version	  float,
		   @Referencia    varchar(100),
		   @SubReferencia varchar(100),
		   @CambiarEstatus bit,
		   @Resultado     varchar(max)    OUTPUT,
		   @Ok		  int		OUTPUT,
		   @OkRef	  varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @Referencia = 'Intelisis.Autorizacion' EXEC spISIntelisisAutorizacion @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT  ELSE --AUTORIZACIONREMOTA
  
  RETURN
END
GO

/**************** fnAutorizacionPositiva ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAutorizacionPositiva') DROP FUNCTION fnAutorizacionPositiva --AUTORIZACIONREMOTA
GO
CREATE FUNCTION fnAutorizacionPositiva 
	(
	@Mensaje				varchar(max)
	)
	
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado								bit,
	@Largo									int,
	@Contador								int,
	@Caracter								char(1),
	@Modo									int,
	@Campo									varchar(255)
				
  SET @Mensaje = REPLACE(@Mensaje,CHAR(10),CHAR(32))				
  SET @Mensaje = REPLACE(@Mensaje,CHAR(13),CHAR(32))				
  SET @Mensaje = LTRIM(@Mensaje)
    
  SELECT @Largo = LEN(@Mensaje), @Contador = 1, @Modo = 0, @Resultado = 0

  WHILE @Contador <= @Largo
  BEGIN
    SET @Caracter = UPPER(SUBSTRING(@Mensaje,@Contador,1))
    IF @Contador = 1
    BEGIN
      IF @Caracter NOT IN ('S','Y','O')  AND @Modo = 0  SET @Modo = -1  ELSE    
      IF @Caracter = 'S'                 AND @Modo = 0  SET @Modo = 1   ELSE
      IF @Caracter = 'O'                 AND @Modo = 0  SET @Modo = 2   ELSE
      IF @Caracter = 'Y'                 AND @Modo = 0  SET @Modo = 3 
    END ELSE
    IF @Contador = 2
    BEGIN
      IF @Caracter <> 'I'                AND @Modo = 1 SET @Modo = -1  ELSE    
      IF @Caracter <> 'K'                AND @Modo = 2 SET @Modo = -1  ELSE          
      IF @Caracter <> 'E'                AND @Modo = 3 SET @Modo = -1  ELSE                
      IF @Caracter = 'I'                 AND @Modo = 1 SET @Modo = 100 ELSE
      IF @Caracter = 'Í'                 AND @Modo = 1 SET @Modo = 100 ELSE      
      IF @Caracter = 'K'                 AND @Modo = 2 SET @Modo = 100 ELSE
      IF @Caracter = 'E'                 AND @Modo = 3 SET @Modo = 4          
    END ELSE
    IF @Contador = 3
    BEGIN
      IF @Caracter <> 'S' AND @Modo = 4  SET @Modo = -1  ELSE    
      IF @Caracter = 'S'  AND @Modo = 4  SET @Modo = 100         
    END        
    
    IF @Modo = 100
    BEGIN
      SET @Resultado = 1
      RETURN @Resultado
    END ELSE
    IF @Modo = -1
    BEGIN
      SET @Resultado = 0
      RETURN @Resultado    
    END    
    
    SET @Contador = @Contador + 1	    
  END

  
  RETURN (@Resultado)
END
GO


/**************** spISIntelisisAutorizacion ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisAutorizacion') and type = 'P') drop procedure dbo.spISIntelisisAutorizacion  --AUTORIZACIONREMOTA
GO             
CREATE PROCEDURE spISIntelisisAutorizacion
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT,
		@CambiarEstado  bit = 1 OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  @Empresa						varchar(5),
  @Modulo						varchar(5),
  @ModuloID						int,
  @Mov							varchar(20),
  @Movimiento					varchar(50),  
  @Estatus						varchar(15),
  @Situacion					varchar(50),
  @SituacionSiguiente			varchar(50),  
  @SituacionFecha				datetime,
  @CadenaAutorizacionValida		bit,
  @De							varchar(255),
  @Asunto						varchar(max),
  @Mensaje						varchar(max),  
  @Usuario						varchar(10),
  @Referencia					varchar(100),
  @SubReferencia				varchar(100),
  @AutorizacionPositiva			bit,
  @Descripcion					varchar(255),
  @UsuarioSituacionActual		varchar(10),
  @CorreoUsuarioSituacionActual	varchar(255),
  @Hoy							datetime,
  @MensajeRespuesta				varchar(max)
    
  SET @Hoy = dbo.fnFechaSinHora(GETDATE())
  
  SET @AutorizacionPositiva = 0
    
  SELECT 
    @Referencia = Referencia,
    @SubReferencia = SubReferencia
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud')
    WITH (Referencia varchar(100), SubReferencia varchar(100))

  SELECT 
    @Empresa = Empresa,
    @Modulo = Modulo,
    @ModuloID = ID,
    @Mov = Mov,
    @Movimiento = Movimiento,
	@Estatus = Estatus,
	@Situacion = Situacion,
	@CadenaAutorizacionValida = ISNULL(CadenaAutorizacionValida,0),
	@De = De,
	@Asunto = Asunto,
	@Mensaje = Mensaje
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Autorizacion')
    WITH (Empresa varchar(5), Modulo varchar(5), ID int, Mov varchar(20), Movimiento varchar(50), Estatus varchar(15), Situacion varchar(50), CadenaAutorizacionValida bit, De varchar(255), Asunto varchar(max), Mensaje varchar(max))

  SELECT @UsuarioSituacionActual = NULLIF(Usuario,'') FROM MovTiempo WHERE IDOrden = (SELECT MAX(IDORDEN) FROM MOVTIEMPO WHERE Modulo = @Modulo AND ID = @ModuloID)

  IF @UsuarioSituacionActual IS NOT NULL SET @CorreoUsuarioSituacionActual = ISNULL(dbo.fnUsuarioACorreo(@UsuarioSituacionActual),'')
  
  SELECT TOP 1 @Usuario = NULLIF(Usuario,'') from dbo.fnCorreosAUsuarios(@De)    
  IF @CadenaAutorizacionValida = 1
  BEGIN
    IF @Usuario IS NOT NULL
    BEGIN
      SET @SituacionSiguiente =  NULLIF(dbo.fnSituacionSiguiente(@Modulo, @Mov, @Estatus, @Situacion),'') 
      IF @SituacionSiguiente IS NOT NULL
      BEGIN
        IF ISNULL(dbo.fnSituacionPermiteAvanzar(@Empresa, @Modulo, @Mov, @Estatus, @SituacionSiguiente, @Usuario),0) = 1
        BEGIN
          SET @AutorizacionPositiva = ISNULL(dbo.fnAutorizacionPositiva(@Mensaje),0)
          IF @AutorizacionPositiva = 1
          BEGIN 
            SET @SituacionFecha = GETDATE()
            EXEC spCambiarSituacion @Modulo, @ModuloID, @SituacionSiguiente, @SituacionFecha, @Usuario      
          END
        END ELSE
        BEGIN
          SELECT @Ok = 53090, @OkRef = ISNULL(@Usuario,'')
        END
      END ELSE
      BEGIN
        SELECT @Ok = 53100, @OkRef = ISNULL(@Situacion,'')    
      END     
    END ELSE
    BEGIN
      SELECT @Ok = 3, @OkRef = ISNULL(@De,'')
    END 
  END ELSE
  BEGIN
    SELECT @Ok = 53105, @OkRef = ISNULL(@De,'')
  END


  IF @AutorizacionPositiva = 1
    SELECT @MensajeRespuesta = dbo.fnNotificacionObtenerParametro('AUTORIZACION', 'MENSAJE CONFIRMACION')
  ELSE  
    SELECT @MensajeRespuesta = dbo.fnNotificacionObtenerParametro('AUTORIZACION', 'MENSAJE RECHAZO')  
  
  SELECT @MensajeRespuesta = dbo.fnISIntelisisAutorizacionParsearMensaje(@MensajeRespuesta, @Empresa, @Modulo, @Movimiento, @Estatus, @Situacion, @SituacionSiguiente, @Usuario) 

   
  IF @Ok IS NOT NULL 
  BEGIN
    SELECT @Descripcion = ISNULL(Descripcion,'') FROM MensajeLista WHERE Mensaje = @Ok
  END
  
  IF @Ok IS NULL
  BEGIN
    IF @AutorizacionPositiva = 1
    BEGIN
      SET @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@Referencia,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkDescripcion=' + CHAR(34) + dbo.fneDocXMLAUTF8(ISNULL(@Descripcion,''),0,1) + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Accion="Autorizado" SituacionAnterior="' + ISNULL(@Situacion,'') + '" SituacionActual="' + ISNULL(@SituacionSiguiente,'') + '" Usuario="' + ISNULL(@Usuario,'') + '"/></Intelisis>'                                       
      SET @MensajeRespuesta = ISNULL(NULLIF(@MensajeRespuesta,''),dbo.fnIdiomaTraducir(@Usuario,'Autorizado'))      
    END ELSE
    BEGIN
      SET @CambiarEstado = 0  
      SET @MensajeRespuesta = ISNULL(NULLIF(@MensajeRespuesta,''),dbo.fnIdiomaTraducir(@Usuario,'No Autorizado'))
    END  
  END    
  ELSE
  BEGIN
    --SET @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@Referencia,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkDescripcion=' + CHAR(34) + ISNULL(@Descripcion,'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Accion="No Autorizado"/></Intelisis>'                                             
    SET @CambiarEstado = 0
    SET @MensajeRespuesta = ISNULL(NULLIF(@MensajeRespuesta,''),dbo.fnIdiomaTraducir(@Usuario,'No Autorizado')) + '. Error.' + LTRIM(RTRIM(ISNULL(CONVERT(varchar,@Ok),''))) + ', Descripcion Error.' + dbo.fnIdiomaTraducir(@Usuario,ISNULL(@Descripcion,'')) + ', Referencia. ' + ISNULL(@OkRef,'')
    SELECT @Ok = NULL, @OkRef = NULL
  END
  
  IF @De IS NOT NULL AND @Usuario IS NOT NULL
  BEGIN
    SET @MensajeRespuesta = ISNULL(@MensajeRespuesta,'') + '. ' + ISNULL(@Mensaje,'')
    SET @Asunto = 'RE. ' + ISNULL(@Asunto,'')
    EXEC spIntelisisServiceEnviarCorreo @Empresa, @De, @CorreoUsuarioSituacionActual, NULL, @Asunto, @MensajeRespuesta, NULL

    INSERT UsuarioNotificacion (Usuario,  IntelisisServiceID, Empresa,  Modulo,  ModuloID,  FechaNotificacion,  Notificacion,   Asunto,  Mensaje,           Para, CC,                            CCO,  Estatus)
                        VALUES (@Usuario, @ID,                @Empresa, @Modulo, @ModuloID, @Hoy,               'AUTORIZACION', @Asunto, @MensajeRespuesta, @De,  @CorreoUsuarioSituacionActual, NULL, 'PENDIENTE')    

    IF @UsuarioSituacionActual IS NOT NULL
    BEGIN    
      INSERT UsuarioNotificacion (Usuario,                 IntelisisServiceID, Empresa,  Modulo,  ModuloID,  FechaNotificacion,  Notificacion,   Asunto,  Mensaje,           Para, CC,                            CCO,  Estatus)
                          VALUES (@UsuarioSituacionActual, @ID,                @Empresa, @Modulo, @ModuloID, @Hoy,               'AUTORIZACION', @Asunto, @MensajeRespuesta, @De,  @CorreoUsuarioSituacionActual, NULL, 'PENDIENTE')                            
    END                        

  END
END
GO
