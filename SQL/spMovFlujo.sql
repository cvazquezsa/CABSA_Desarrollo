/*
SOLO SI GENERAN P”LIZAS CON EL CHECK CONTABILIZACI”N EN LÕçNEA ENCENDIDO
IMPORTANTE: EL SIGUIENTE STORED PROCEDURE FORMA PARTE DE LA VERSI”N Y NO SE DEBEN DE CORRER DIRECTAMENTE 
PORQUE PODRÕçA CAUSAR RESULTADOS INESPERADOS EN EL SISTEMA. SE DEBEN DE MODIFICAR MANUALMENTE PARA EVITAR PROBLEMAS. 
LAS LINEAS QUE SE CAMBIARON ESTAN MARCADAS CON LA LEYENDA: --Cambio Contabilidad ElectrÛnica 
*/
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO
IF EXISTS(select * from sysobjects where id = object_id('dbo.spMovFlujo') and type = 'P') drop procedure dbo.spMovFlujo
GO
CREATE PROCEDURE spMovFlujo
@Sucursal		int,
@Accion			char(20),
@Empresa     	char(5),
@OModulo		char(5),
@OID			int,
@OMov			char(20),
@OMovID			varchar(20),
@DModulo		char(5),
@DID			int,
@DMov			char(20),
@DMovID			varchar(20),
@Ok				int	OUTPUT
WITH ENCRYPTION
AS BEGIN
	IF @OID IS NULL OR @OMovID IS NULL OR @OMov IS NULL OR @DID IS NULL OR @DMov IS NULL OR @DMovID IS NULL OR @Accion = 'CANCELAR'
	RETURN

	IF NOT EXISTS (SELECT * FROM MovFlujo WHERE Empresa = @Empresa AND OModulo = @OModulo AND OID  = @OID AND DModulo = @DModulo AND DID = @DID)
	BEGIN
		INSERT MovFlujo (Sucursal,  Empresa, OModulo, OID, OMov, OMovID, DModulo, DID, DMov, DMovID)
				 VALUES (@Sucursal, @Empresa, @OModulo, @OID, @OMov, @OMovID, @DModulo, @DID, @DMov, @DMovID)
		EXEC spCamposExtrasMovFlujo @OModulo, @OMov, @OID, @DModulo, @DMov, @DID
	END
	---   CAMBIO CONTABILIDAD ELECTR√ìNICA   ---
	EXEC xpMovFlujo @Sucursal, @Accion, @Empresa, @OModulo, @OID, @OMov, @OMovID, @DModulo, @DID, @DMov, @DMovID, @Ok
	---   CAMBIO CONTABILIDAD ELECTR√ìNICA   ---
	
	IF @@ERROR <> 0 SELECT @Ok = 1
	RETURN
END
GO