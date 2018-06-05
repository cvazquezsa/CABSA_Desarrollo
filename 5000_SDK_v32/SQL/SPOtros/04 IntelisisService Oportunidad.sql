SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO

/**************** spIntelisisServiceProcesarOportunidad ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesarOportunidad') and type = 'P') drop procedure dbo.spIntelisisServiceProcesarOportunidad
GO
CREATE PROCEDURE spIntelisisServiceProcesarOportunidad
           @Sistema			varchar(100),
    	   @ID				int,
		   @iSolicitud		int,
		   @Solicitud		varchar(max),
		   @Version			float,
		   @Referencia		varchar(100),
		   @SubReferencia	varchar(100),
		   @Resultado		varchar(max)    OUTPUT,
		   @Ok				int				OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,
		   @CambiarEstatus	bit				OUTPUT
--//WITH ENCRYPTION
AS BEGIN

  IF @Referencia = 'Intelisis.Oportunidad' EXEC spISIntelisisOportunidad @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CambiarEstatus OUTPUT

  RETURN
END
GO

/**************** spISIntelisisOportunidad ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisOportunidad') and type = 'P') drop procedure dbo.spISIntelisisOportunidad --MEJORA
GO             
CREATE PROCEDURE spISIntelisisOportunidad
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int			 = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT,
		@CambiarEstado  bit = 1 OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  @Empresa						varchar(5),
  @Fecha						datetime,
  @Para							varchar(max),
  @Asunto						varchar(255),
  @Mensaje						varchar(max),
  @ModuloID						int,
  @Hoy							datetime,
  @Usuario						varchar(10),
  @Referencia					varchar(100),
  @SubReferencia				varchar(100),
  @Anexos						varchar(max),
  @ContactoTipo					varchar(20),
  @Contacto						varchar(10)
    
  SET @Hoy = dbo.fnFechaSinHora(GETDATE())

  SELECT 
    @Referencia = Referencia
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud')
    WITH (Referencia varchar(100))

  SELECT @Empresa = Empresa,
         @Fecha = dbo.fnFechaSinHora(Fecha),    
         @Para = Para,
         @Asunto = Asunto,
         @Mensaje = Mensaje,
         @ModuloID = ModuloID,
         @Anexos		= Anexos,
         @Usuario = Usuario,
         @ContactoTipo = ContactoTipo,
         @Contacto = Contacto
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Oportunidad')
    WITH (Empresa varchar(5), Fecha datetime, Para varchar(max), Asunto varchar(255), Mensaje varchar(max), ModuloID int, Anexos varchar(max), Usuario varchar(10), ContactoTipo varchar(20), Contacto varchar(10))
    
  EXEC spIntelisisServiceEnviarCorreo @Empresa, @Para, '', '', @Asunto, @Mensaje, @Anexos
      
  INSERT OportunidadeMailUsuario (
			Usuario,  IntelisisServiceID, Empresa,  ModuloID,  Fecha,  Asunto,  Mensaje,  Para,  Anexos,   ContactoTipo,  Contacto)
    VALUES (@Usuario, @ID,                @Empresa, @ModuloID, @Fecha, @Asunto, @Mensaje, @Para, @Anexos, @ContactoTipo, @Contacto)    
    
  IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = 'UsuarioCRM'

  IF @Ok IS NULL
    SET @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@Referencia,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Proceso="Enviado"/></Intelisis>'                                 
  ELSE
    SET @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@Referencia,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + ' Proceso="No Enviado"/></Intelisis>'                                     

END
GO