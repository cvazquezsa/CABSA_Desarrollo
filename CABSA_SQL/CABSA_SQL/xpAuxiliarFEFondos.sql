/**************** xpAuxiliarFEFondos ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAuxiliarFEFondos') and sysstat & 0xf = 4) drop procedure dbo.xpAuxiliarFEFondos
GO
CREATE PROCEDURE xpAuxiliarFEFondos
	@ID               		int,
	@Accion			char(20),
	@Empresa          		char(5),
	@Usuario			char(10),
	@Modulo	      		char(5),
	@Mov              		char(20),
	@MovID			varchar(20),
	@MovTipo	      		char(20),
	@MovMoneda			char(10),
	@MovTipoCambio		float,
	@Estatus			char(15),
 	@EstatusNuevo	      	char(15),
	@CtaDinero			char(10),
	@CtaDineroTipo		char(20),         
	@CtaDineroDestino		char(10),
	@CtaDineroFactor		float,
	@CtaDineroTipoCambio	float,
	@CtaDineroMoneda		char(10),
	@Cajero			char(10),
	@Importe			money,
	@Impuestos			money,
	@Saldo			money,
	@Directo	                bit,
	@CfgContX			bit,
	@CfgContXGenerar		char(20),
	@Conexion			bit,
	@SincroFinal		bit,
	@Sucursal			int,
	@Ok               		int          OUTPUT,
	@OkRef            		varchar(255) OUTPUT
AS 
BEGIN
	DECLARE
		@Clasificacion	varchar(100),
		@ImporteIns	money,
		@FechaEmision	datetime,
		@Cancelado	bit,
		@SubClave	varchar(20),
		@Factor	int

	SELECT @SubClave = mt.SubClave
		FROM Dinero d
			JOIN MovTipo mt ON d.Mov = mt.Mov AND mt.Modulo = 'DIN'
		WHERe ID = @ID

	IF @SubClave IN ('DIN.TFON', 'DIN.CBFON', 'DIN.CHEFON', 'DIN.TFONR','DIN.TFONOP')
	BEGIN--Es Fondos
		IF @Accion = 'AFECTAR' AND @EstatusNuevo = 'CONCLUIDO'
		BEGIN--AFECTAR
			
			IF @SubClave IN ('DIN.TFON', 'DIN.TFONR')
				SELECT @Clasificacion = 'ORIGEN DE DEPOSITOS Y CARGOS'
			
			IF @SubClave IN ('DIN.CBFON','DIN.CHEFON','DIN.TFONOP')
				SELECT @Clasificacion = 'APLICACION DE CHEQUES Y ABONOS'
			
			IF @SubClave = 'DIN.TFONR'
				SELECT @Factor = -1
			ELSE
				SELECT @Factor = 1

			SELECT @ImporteIns = (d.Importe + d.Impuestos) * @Factor, @FechaEmision = FechaEmision, @Cancelado = 0 FROM Dinero d WHERE d.ID = @ID
			
			INSERT INTO CABAuxiliarFEFondos(
				Empresa,	Modulo,		ModuloID,	Mov,	MovId,	Clasificacion,	Importe,			FechaEmision,		Cancelado)
			SELECT
				@Empresa,	@Modulo,	@ID,			@Mov,	@MovID,	@Clasificacion, @ImporteIns,	@FechaEmision,	@Cancelado

		END--AFECTAR
		IF @Accion = 'CANCELAR'
		BEGIN--CANCELAR
			SELECT @Cancelado = 1
			UPDATE CABAuxiliarFEFondos SET Cancelado = @Cancelado WHERE ModuloID = @ID AND Modulo = @Modulo AND Empresa = @Empresa
		END--CANCELAR
	END--Es Fondos
	
	/*
	CREATE TABLE CABAuxiliarFEFondos(
		ID	int	IDENTITY(1,1),
		Empresa	varchar(5),
		Modulo	varchar(5),
		ModuloID	int,
		Mov	varchar(20),
		MovId	varchar(50),
		Clasificacion	varchar(100),
		Importe	money,
		FechaEmision	datetime,
		Cancelado	bit
		*/
  RETURN
END
GO
--SELECT * fROM CABAuxiliarFEFondos
