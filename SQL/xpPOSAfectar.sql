/*
IMPORTANTE: EL SIGUIENTE STORED PROCEDURE FORMA PARTE DE LA VERSION Y NO SE DEBEN DE CORRER DIRECTAMENTE 
PORQUE PODRÍA CAUSAR RESULTADOS INESPERADOS EN EL SISTEMA. SE DEBEN DE MODIFICAR MANUALMENTE PARA EVITAR PROBLEMAS. 
LAS LINEAS QUE SE CAMBIARON ESTAN MARCADAS CON LA LEYENDA: --Cambio Contabilidad Electrónica
*/
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO 
/************** xpPOSAfectar *************/
if exists (select * from sysobjects where id = object_id('dbo.xpPOSAfectar') and type = 'P') drop procedure dbo.xpPOSAfectar
GO

CREATE PROCEDURE xpPOSAfectar  
@Empresa		varchar(5),  
@Modulo			varchar(5),  
@Sucursal		int,  
@Usuario		varchar(10),  
@ID				varchar(36),  
@Host			varchar(20) = NULL,  
@Ok				int  OUTPUT,  
@OkRef			varchar(255) OUTPUT  
AS BEGIN

/*****     Cambio Contabilidad Electronica     *****/
DECLARE @ModuloID		as int

	IF @Modulo = 'VTAS'
	BEGIN
	SELECT @ModuloID = B.ID
	  FROM POSL A
	  JOIN Venta B
		ON A.Mov = B.Mov
	   AND A.MovID = B.MovID
	   AND A.Empresa = B.Empresa
	 WHERE A.ID = @ID
	   AND A.Host = @Host
	   AND A.Empresa = @Empresa
	   AND A.Modulo = @Modulo
	   
		IF ISNULL(@ModuloID,0) <> 0
			BEGIN
				UPDATE CFD SET CFD.Importe = ISNULL(Venta.Importe,0)+ISNULL(Venta.Impuestos,0),
							   CFD.Moneda = dbo.fnBuscaClaveMoneda(Venta.Moneda),
							   CFD.TipoCambio = Venta.TipoCambio
				  FROM CFD
				  JOIN Venta
				    ON CFD.ModuloID = Venta.ID
				 WHERE CFD.Modulo = @Modulo
				   AND CFD.ModuloID = @ModuloID
				   AND CFD.Empresa = @Empresa
				
				EXEC xpActualizarContSATComprobante @Modulo, @ModuloID
			END	   
	END  
/*****     Fin Cambio Contabilidad Electronica     *****/
RETURN  
END
GO
