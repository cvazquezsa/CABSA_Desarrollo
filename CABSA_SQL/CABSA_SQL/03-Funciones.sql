SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/**** INICIA: CONCEPTO FLujo de Efectivo Fondos ****/

/********** fnCABSubClaveConcFEFondo **********/
IF EXISTS (SELECT * FROM SysObjects WHERE name = 'fnCABSubClaveConcFEFondo' AND type = 'FN')
	DROP FUNCTION fnCABSubClaveConcFEFondo
GO
CREATE FUNCTION dbo.fnCABSubClaveConcFEFondo (@Modulo varchar(10), @Mov varchar(20))
RETURNS bit
WITH EXECUTE AS CALLER
AS
BEGIN
	DECLARE
		@SubClaveVal	bit,
		@SubClave	varchar(20)
	
	SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo
	
	IF @SubClave IN ('DIN.ABFON', 'DIN.TFON', 'DIN.CBFON', 'DIN.CHEFON', 'DIN.TFONR', 'DIN.TFONOP')
		SELECT @SubClaveVal = 1
	ELSE
		SELECT @SubClaveVal = 0

	RETURN(@SubClaveVal)
END
GO
/**** TERMINA: CONCEPTO FLujo de Efectivo Fondos ****/
--SELECT dbo.fnCABSubClaveConcFEFondo ('DIN', 'Ingreso Fondo NI')

--SELECT * FROM Dinero WHERE Mov = 'DEvolucion Prima'