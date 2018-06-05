/**************** xpInvVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvVerificar') and sysstat & 0xf = 4) drop procedure dbo.xpInvVerificar
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
		@Articulo	varchar(20),
		@UEN	int,
		@ConceptoFE varchar(50)

	EXEC spValidarDevolucionFactura @ID, @Empresa, @Ok OUTPUT, @OkRef OUTPUT

	/**** INICIO: Validación Centro de Costo ****/
	IF @Modulo = 'VTAS'
	BEGIN
		IF @Mov IN (SELECT Valor FROM TablaValorD WHERE TablaValor = 'Lista blanca ContUso')
		BEGIN
			SELECT @UEN = UEN,@ConceptoFE = ConceptoFE
				FROM Venta v
				WHERE ID = @ID
			IF @UEN IS NULL
				SELECT @Ok = 10070, @OkRef = NULL --Falta Indicar la UEN
			IF ISNULL(@ConceptoFE, '') = '' --Concepto
				SELECT @Ok = 20480, @OkRef = 'Flujo de Efectivo'
		END
		
		--Centro de Costos --
		SELECT TOP 1 @Renglon = Renglon, @Articulo = Articulo 
			FROM VentaD 
			WHERE ISNULL(ContUso,'') = '' 
				AND @Mov IN (SELECT Valor FROM TablaValorD WHERE TablaValor = 'Lista blanca ContUso')
				AND ID = @ID
		IF ISNULL(@Renglon,0) <> 0
			SELECT @OK = 10130, @OkRef = @Articulo
		
		SELECT TOP 1 @Renglon = Renglon, @Articulo = Articulo 
			FROM VentaD 
			WHERE ISNULL(ContUso2,'') = '' 
				AND @Mov IN (SELECT Valor FROM TablaValorD WHERE TablaValor = 'Lista blanca ContUso2')
				AND ID = @ID
		IF ISNULL(@Renglon,0) <> 0
			SELECT @OK = 10130, @OkRef = CONCAT(@Articulo, ' ','Centro de costos 2')	
			
	END
	IF @Modulo = 'COMS'
	BEGIN
		IF @Mov IN (SELECT Valor FROM TablaValorD WHERE TablaValor = 'Lista blanca ContUso')
		BEGIN
			SELECT @UEN = UEN,@ConceptoFE = ConceptoFE
				FROM Compra v
				WHERE ID = @ID
			IF @UEN IS NULL
				SELECT @Ok = 10070 , @OkRef = NULL--Falta Indicar la UEN
			IF ISNULL(@ConceptoFE, '') = '' --Concepto
				SELECT @Ok = 20480, @OkRef = 'Flujo de Efectivo'
		END
		--Centro de Costos
		SELECT TOP 1 @Renglon = Renglon, @Articulo = Articulo 
			FROM CompraD 
			WHERE ISNULL(ContUso,'') = '' 
				AND @Mov IN (SELECT Valor FROM TablaValorD WHERE TablaValor = 'Lista blanca ContUso')
				AND ID = @ID
		IF ISNULL(@Renglon,0) <> 0
			SELECT @OK = 10130, @OkRef = @Articulo
		
		SELECT TOP 1 @Renglon = Renglon, @Articulo = Articulo 
			FROM CompraD 
			WHERE ISNULL(ContUso2,'') = '' 
				AND @Mov IN (SELECT Valor FROM TablaValorD WHERE TablaValor = 'Lista blanca ContUso2')
				AND ID = @ID
		IF ISNULL(@Renglon,0) <> 0
			SELECT @OK = 10130, @OkRef = CONCAT(@Articulo, ' ','Centro de costos 2')	
			
	END
	IF @Modulo = 'INV'
	BEGIN
		IF @Mov IN (SELECT Valor FROM TablaValorD WHERE TablaValor = 'Lista blanca ContUso')
		BEGIN
			SELECT @UEN = UEN
				FROM Inv v
				WHERE ID = @ID
			IF @UEN IS NULL
				SELECT @Ok = 10070, @OkRef = NULL --Falta Indicar la UEN
		END
		--Centro de Costos
		SELECT TOP 1 @Renglon = Renglon, @Articulo = Articulo 
			FROM InvD 
			WHERE ISNULL(ContUso,'') = '' 
				AND @Mov IN (SELECT Valor FROM TablaValorD WHERE TablaValor = 'Lista blanca ContUso')
				AND ID = @ID
		IF ISNULL(@Renglon,0) <> 0
			SELECT @OK = 10130, @OkRef = @Articulo
/*
		SELECT TOP 1 @Renglon = Renglon, @Articulo = Articulo 
			FROM InvD 
			WHERE ISNULL(ContUso2,'') = '' 
				AND @Mov IN (SELECT Valor FROM TablaValorD WHERE TablaValor = 'Lista blanca ContUso2')
				AND ID = @ID
		IF ISNULL(@Renglon,0) <> 0
			SELECT @OK = 10130, @OkRef = CONCAT(@Articulo, ' ','Centro de costos 2')
			*/

		
			
	END
	/**** FIN: Validación Centro de Costo ****/
RETURN
END
GO