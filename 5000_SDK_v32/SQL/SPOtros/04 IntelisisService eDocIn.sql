 SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO
 
 /**************** spIntelisisServiceProcesareDocIn ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesareDocIn') and type = 'P') drop procedure dbo.spIntelisisServiceProcesareDocIn
GO
CREATE PROCEDURE spIntelisisServiceProcesareDocIn
                   @Sistema       varchar(100),
    		   @ID		  int,
		   @iSolicitud	  int,
		   @Solicitud     varchar(max),
		   @Version	  float,
		   @Referencia    varchar(100),
		   @SubReferencia varchar(100),
		   @Resultado     varchar(max)    OUTPUT,
		   @Ok		  int		OUTPUT,
		   @OkRef	  varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @Referencia = 'Intelisis.eDocInProcesar' AND @SubReferencia = 'XML.Invalido' EXEC spISeDocINError  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
  IF @Referencia = 'Intelisis.eDocInProcesar' EXEC spISeDocIN  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 
  
  RETURN
END
GO


