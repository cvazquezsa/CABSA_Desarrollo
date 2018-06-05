/******************************* spIntelisisWebService *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWebService') and type = 'P') drop procedure dbo.spIntelisisWebService
GO             
CREATE PROCEDURE spIntelisisWebService
		@Usuario				varchar(10),
		@Contrasena				varchar(32),
		@Solicitud				varchar(max),
		@Procesar				bit = 0,
		@EliminarProcesado		bit = 0


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@Resultado				varchar(max),
	@Ok						int,
	@OkRef					varchar(255),
	@ID						int

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @Procesar, @EliminarProcesado, @ID OUTPUT
  SELECT @Resultado Resultado, @Ok Ok, @OkRef OkRef, @id ID 

END
GO
/*
declare 
@xml				varchar(max),
@Resultado			varchar(max),
@Ok					int,
@OkRef				varchar(255),
@ID					int

set @xml = '<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Cuenta.Alm.Listado" SubReferencia="ALTA" Version="1.0">   
  <Solicitud>               
   <Parametro Campo="Almacen" Valor="0"/>         
  </Solicitud>        
</Intelisis>'

exec spIntelisisWebService 'DEMO', '0633971b5e442cd51b8e0a972d74f054', @XML, 1, 0
--SELECT @Resultado Resultado, @Ok Ok, @OkRef OkRef, @id ID 

--select * from intelisisservice
*/