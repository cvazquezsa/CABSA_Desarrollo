/**************** xpGenerarDinero ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarDinero') and type = 'P') drop procedure dbo.xpGenerarDinero
GO
CREATE PROCEDURE xpGenerarDinero
	@Sucursal			int,
	@SucursalOrigen		int, 
	@SucursalDestino		int, 
	@Accion			char(20),
  @Empresa	      		char(5),
  @Modulo	      		char(5),
  @ID				int,
 	@Mov				char(20),
  @MovID             		varchar(20),
  @MovTipo     		char(20),
  @MovMoneda	      		char(10),
  @MovTipoCambio	 	float,
  @FechaAfectacion    		datetime,
  @Concepto	      		varchar(50),
  @Proyecto	      		varchar(50),
  @Usuario	      		char(10),
  @Autorizacion      		char(10),
  @Referencia	      		varchar(50),
  @DocFuente	      		int,
  @Observaciones     		varchar(255),
	@ConDesglose			bit,
	@GenerarSolicitud		bit,
  @FechaRegistro     		datetime,
  @Ejercicio	      		int,
  @Periodo	      		int,
	@FormaPago			varchar(50),
	@Tipo			char(20),
  @Beneficiario		int,
	@Cuenta			char(10), 
	@CtaDinero			char(10),
	@Cajero			char(10),
	@Importe			money,
  @Impuestos			money,
	@MovEspecifico		char(20),
	@BeneficiarioEspecifico	varchar(100),
	@Vencimiento			datetime,
  @DineroMov			char(20),
  @DineroMovID			varchar(20),
	@Ok				int		OUTPUT,
	@OkRef			varchar(255)	OUTPUT,
  @DineroID			int		= NULL
AS 
BEGIN
	DECLARE
		@ConceptoFE	varchar(50)
/**** INICIO: Concepto flujo de efectivo ****/
	IF @Modulo = 'Cxc'
		SELECT @ConceptoFE = ConceptoFE FROM Cxc WHERE ID = @ID
	IF @Modulo = 'CXP'
		SELECT @ConceptoFE = ConceptoFE FROM Cxp WHERE ID = @ID
	IF @Modulo = 'GAS'
		SELECT @ConceptoFE = ConceptoFE FROM Gasto WHERE ID = @ID

	IF ISNULL(@ConceptoFE, '') <> ''
		UPDATE Dinero SET ConceptoFE = @ConceptoFE WHERE ID = @DineroID
/**** FIN: Concepto flujo de efectivo ****/
	RETURN
END
GO
