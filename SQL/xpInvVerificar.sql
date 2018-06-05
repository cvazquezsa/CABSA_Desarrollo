SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
IF EXISTS(SELECT * FROM SysObjects WHERE Name = 'xpInvVerificar' AND Type = 'P')
	DROP PROCEDURE xpInvVerificar
GO
CREATE PROCEDURE xpInvVerificar
	@ID             int,
	@Accion         char(20),
	@Base           char(20),
	@Empresa        char(5),
	@Usuario        char(10),
	@Modulo         char(5),
	@Mov            char(20),
	@MovID          varchar(20),
	@MovTipo        char(20),
	@MovMoneda      char(10),
	@MovTipoCambio  float,
	@Estatus        char(15),
	@EstatusNuevo   char(15),
	@FechaEmision   datetime,
	@Ok             int           OUTPUT,
	@OkRef          varchar(255)  OUTPUT
AS
BEGIN
  DECLARE
		@Renglon	float,
		@Articulo	varchar(20)
	EXEC spValidarDevolucionFactura @ID, @Empresa, @Ok OUTPUT, @OkRef OUTPUT

	/**** INICIO: Validación Centro de Costo ****/
	IF @Modulo = 'VTAS'
	BEGIN
		SELECT TOP 1 @Renglon = Renglon, @Articulo = Articulo 
			FROM VentaD 
			WHERE ISNULL(ContUso,'') = '' 
				AND @Mov IN (SELECT Valor FROM TablaValorD WHERE TablaValor = 'Lista blanca ContUso')
				AND ID = @ID
		IF ISNULL(@Renglon,0) <> 0
			SELECT @OK = 10130, @OkRef = @Articulo
	END
	IF @Modulo = 'COMS'
	BEGIN
		SELECT TOP 1 @Renglon = Renglon, @Articulo = Articulo 
			FROM CompraD 
			WHERE ISNULL(ContUso,'') = '' 
				AND @Mov IN (SELECT Valor FROM TablaValorD WHERE TablaValor = 'Lista blanca ContUso')
				AND ID = @ID
		IF ISNULL(@Renglon,0) <> 0
			SELECT @OK = 10130, @OkRef = @Articulo
	END
	/**** FIN: Validación Centro de Costo ****/
RETURN
END

