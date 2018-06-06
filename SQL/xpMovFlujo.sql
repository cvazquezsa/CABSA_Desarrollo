/*
SOLO SI GENERAN P�LIZAS CON EL CHECK CONTABILIZACI�N EN L͍NEA ENCENDIDO
IMPORTANTE: EL SIGUIENTE STORED PROCEDURE FORMA PARTE DE LA VERSION Y NO SE DEBEN DE CORRER DIRECTAMENTE 
PORQUE PODR�A CAUSAR RESULTADOS INESPERADOS EN EL SISTEMA. SE DEBEN DE MODIFICAR MANUALMENTE PARA EVITAR PROBLEMAS. 
*/
/**************     xpMovFlujo     *************/
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO
IF EXISTS(SELECT * FROM sysobjects where id = object_id('dbo.xpMovFlujo') and type = 'P') DROP PROCEDURE dbo.xpMovFlujo
GO
CREATE PROCEDURE xpMovFlujo
	@Sucursal	int,
	@Accion		char(20),
	@Empresa	char(5),
	@OModulo	char(5),
	@OID		int,
	@OMov		char(20),
	@OMovID		varchar(20),
	@DModulo	char(5),
	@DID		int,
	@DMov		char(20),
	@DMovID		varchar(20),
	@Ok			int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
	IF @DModulo = 'DIN'
		BEGIN
			IF EXISTS(SELECT * FROM ContX WHERE Modulo = @DModulo AND EnLinea = 1)
			BEGIN
				IF EXISTS(SELECT * FROM MovTipo WHERE Modulo = @DModulo AND Mov = @DMov AND ContArrastrarCompOrigen = 1)
				EXEC xpActualizarContSATComprobante @DModulo, @DID
			END
		END
  RETURN 
END
GO