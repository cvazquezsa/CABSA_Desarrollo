/**************** xpDineroAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDineroAfectar') and sysstat & 0xf = 4) drop procedure dbo.xpDineroAfectar
GO
CREATE PROCEDURE xpDineroAfectar
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
/********** INICIA: Flujo de efectivo Fondos **********/
	EXEC xpAuxiliarFEFondos	
		@ID,@Accion,@Empresa,@Usuario,@Modulo,@Mov,@MovID,@MovTipo,@MovMoneda,@MovTipoCambio,@Estatus,@EstatusNuevo,@CtaDinero,@CtaDineroTipo,
		@CtaDineroDestino,@CtaDineroFactor,@CtaDineroTipoCambio,@CtaDineroMoneda,@Cajero,@Importe,@Impuestos,@Saldo,@Directo,@CfgContX,
		@CfgContXGenerar,@Conexion,@SincroFinal,@Sucursal,@Ok OUTPUT,@OkRef OUTPUT
/********** TERMINA: Flujo de efectivo Fondos **********/
	RETURN
END
GO