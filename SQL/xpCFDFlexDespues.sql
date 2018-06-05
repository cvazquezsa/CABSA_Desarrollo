/*
SOLO SI UTILIZAN CFDFLEX
IMPORTANTE: EL SIGUIENTE STORED PROCEDURE FORMA PARTE DE LA VERSION Y NO SE DEBEN DE CORRER DIRECTAMENTE 
PORQUE PODRÍA CAUSAR RESULTADOS INESPERADOS EN EL SISTEMA. SE DEBEN DE MODIFICAR MANUALMENTE PARA EVITAR PROBLEMAS. 
LAS LINEAS QUE SE CAMBIARON ESTAN MARCADAS CON LA LEYENDA: --Cambio Contabilidad Electrónica 
*/
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO 

/**************** xpCFDFlexDespues ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDFlexDespues') and type = 'P') drop procedure dbo.xpCFDFlexDespues
GO             
CREATE PROCEDURE xpCFDFlexDespues
		@Estacion					int,
		@Empresa					varchar(5),
		@Modulo						varchar(5),
		@ID							int,		
		@Estatus					varchar(15),
		@Ok							int			OUTPUT,
		@OkRef						varchar(255) OUTPUT,
		
		@LlamadaExterna				bit,
		@Mov						varchar(20),
		@MovID						varchar(20),
		@Contacto					varchar(10),
		@CrearArchivo				bit,
		@Debug						bit,
		@XMLFinal					varchar(max) OUTPUT,
		@Encripcion					varchar(20)
					
AS BEGIN
--Cambio Contabilidad Electronica Inicio

    EXEC spActualizaDatosXMLEnCFD @Estacion, @Empresa, @Modulo, @ID, @Estatus, @Ok OUTPUT, @OkRef OUTPUT
    EXEC xpActualizarContSATComprobante @Modulo, @ID
	EXEC spAsociacionRetroactiva @Modulo, @ID, @Empresa

--Cambio Contabilidad Electronica FIN  

--User Story 9085
	IF @Modulo = 'VTAS'
		EXEC xpAsociarFacturaCorte @ID, @Mov, @Modulo, @Estatus, @Empresa
  
  RETURN
END
GO