/**************** xpMovCopiarEncabezado ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovCopiarEncabezado') and type = 'P') drop procedure dbo.xpMovCopiarEncabezado
GO             
CREATE PROCEDURE xpMovCopiarEncabezado
	@Sucursal		int,
	@Modulo			char(5), 
	@ID				int,
	@Empresa		char(5), 
	@Mov			char(20),
	@MovID 			varchar(20),
	@Usuario		char(10), 
	@FechaEmision	datetime, 
	@Estatus		char(15),
	@Moneda			char(10),
	@TipoCambio		float,
	@Almacen		char(10),
	@AlmacenDestino char(10),
	@GenerarDirecto	bit,
	@GenerarMov		char(20),
	@GenerarMovID 	varchar(20), 
	@GenerarID		int,
	@Ok				int	OUTPUT,
	@CopiarBitacora	bit
AS 
BEGIN
	DECLARE
		@ConceptoFE	varchar(20)
/**** INICIO: Concepto flujo de efectivo ****/	
	IF @Modulo = 'VTAS'
	BEGIN
		SELECT @ConceptoFE = ConceptoFE FROM Venta WHERE ID = @ID
		UPDATE Venta SET ConceptoFE = @ConceptoFE WHERE ID = @GenerarID
	END
	IF @Modulo = 'COMS'
	BEGIN
		SELECT @ConceptoFE = ConceptoFE FROM Compra WHERE ID = @ID
		UPDATE Compra SET ConceptoFE = @ConceptoFE WHERE ID = @GenerarID
	END
	IF @Modulo = 'GAS'
	BEGIN
		SELECT @ConceptoFE = ConceptoFE FROM Gasto WHERE ID = @ID
		UPDATE Gasto SET ConceptoFE = @ConceptoFE WHERE ID = @GenerarID
	END
	IF @Modulo = 'CXC'
	BEGIN
		SELECT @ConceptoFE = ConceptoFE FROM Cxc WHERE ID = @ID
		UPDATE Cxc SET ConceptoFE = @ConceptoFE WHERE ID = @GenerarID
	END
	IF @Modulo = 'CXP'
	BEGIN
		SELECT @ConceptoFE = ConceptoFE FROM Cxp WHERE ID = @ID
		UPDATE Cxp SET ConceptoFE = @ConceptoFE WHERE ID = @GenerarID
	END
	IF @Modulo = 'DIN'
	BEGIN
		SELECT @ConceptoFE = ConceptoFE FROM Dinero WHERE ID = @ID
		UPDATE Dinero SET ConceptoFE = @ConceptoFE WHERE ID = @GenerarID
	END
/**** FIN: Concepto flujo de efectivo ****/
  RETURN
END
GO
