/**************** xpGenerarCx ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarCx') and type = 'P') drop procedure dbo.xpGenerarCx
GO
CREATE PROCEDURE xpGenerarCx
	@Sucursal			int,
	@SucursalOrigen		int,
	@SucursalDestino		int,
	@Accion			char(20),
	@ModuloAfectar		char(5),
	@Empresa	      		char(5),
	@Modulo	      		char(5),
	@ID				int,
	@Mov				char(20),
	@MovID             		varchar(20),
	@MovTipo     		char(20),
	@MovMoneda	      		char(10),
	@MovTipoCambio	 	float,
	@FechaEmision      		datetime,
	@Concepto	      		varchar(50),
	@Proyecto	      		varchar(50),
	@Usuario	      		char(10),
	@Autorizacion      		char(10),
	@Referencia	      		varchar(50),
	@DocFuente	      		int,
	@Observaciones     		varchar(255),
	@FechaRegistro     		datetime,
	@Ejercicio	      		int,
	@Periodo	      		int,
	@Condicion			varchar(50),
	@Vencimiento			datetime,
	@Contacto			char(10),
	@EnviarA			int,
	@Agente			char(10),
	@Tipo			char(20),
	@CtaDinero			char(10),
	@FormaPago			varchar(50),
	@Importe			money,
	@Impuestos			money,
	@Retencion			money,
	@ComisionTotal		money,
	@Beneficiario		int,
	@Aplica			char(20),
	@AplicaMovID			varchar(20),
	@ImporteAplicar		money,
	@VIN				varchar(20),
	@MovEspecifico		char(20),
	@CxModulo			char(5),
	@CxMov			char(20),
	@CxMovID			varchar(20),
	@Ok				int		OUTPUT,
	@OkRef			varchar(255)	OUTPUT,
	@INSTRUCCIONES_ESP		varchar(20) 	= NULL,
	@IVAFiscal			float		= NULL,
	@IEPSFiscal			float		= NULL,
	@CxID			int		= NULL,
	@ContUso			varchar(20)	= NULL
AS BEGIN
	DECLARE
		@ConceptoFE varchar(50)
/**** INICIO: Concepto flujo de efectivo ****/
	IF @Modulo = 'VTAS'
		SELECT @ConceptoFE = ConceptoFE FROM Venta WHERE ID = @ID
	IF @Modulo = 'COMS'
		SELECT @ConceptoFE = ConceptoFE FROM Compra WHERE ID = @ID
	IF @Modulo = 'GAS'
		SELECT @ConceptoFE = ConceptoFE FROM Gasto WHERE ID = @ID
	IF @Modulo = 'DIN'
		SELECT @ConceptoFE = ConceptoFE FROM Dinero WHERE ID = @ID

	IF @CxModulo = 'CXC'
		UPDATE c SET c.ConceptoFE = @ConceptoFE FROM Cxc c WHERE ID = @CxID
	IF @CxModulo = 'CXP'
		UPDATE c SET c.ConceptoFE = @ConceptoFE FROM Cxp c WHERE ID = @CxID
/**** FIN: Concepto flujo de efectivo ****/
	RETURN
END

