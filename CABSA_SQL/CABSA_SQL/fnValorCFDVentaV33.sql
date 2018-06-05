ALTER FUNCTION [dbo].[fnValorCFDVentaV33] (@ID int, @Valor int, @Renglon float)
RETURNS FLOAT
AS
BEGIN
	DECLARE
		@Resultado			float,
		@ImpIncluido		bit,
		@Empresa			varchar(5),
		@Subtotal			float,
		@Descuento			float,
		@Impuesto			float,
		@Retencion			float
	SELECT @Empresa = Venta.Empresa, @ImpIncluido = ISNULL(EmpresaCfg.VentaPreciosImpuestoIncluido,0)
	  FROM Venta
	  JOIN EmpresaCfg ON EmpresaCfg.Empresa = Venta.Empresa
	 WHERE Venta.ID = @ID
	IF @Valor = 1
		BEGIN
			SELECT @Resultado = CONVERT(decimal(18,2),CONVERT(decimal(18,6),SUM(CASE WHEN vtc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(vtc.ID,vtc.RenglonID,'SubTotalSinDL'),0.00) ELSE SubTotalSinDL END)) + CONVERT(decimal(18,6),SUM(ISNULL(cfd.VentaDImporte,0.00))))
			  FROM VentaTCalc vtc
		 LEFT JOIN CFDVentaDObsequioV33 cfd
				ON cfd.ID = vtc.ID
			   AND cfd.Renglon = vtc.Renglon
			 WHERE vtc.ID = @ID
			   AND vtc.Renglon = ISNULL(@Renglon,vtc.Renglon)
			   AND vtc.RenglonTipo <> 'C'
		END
	IF @Valor = 2
		BEGIN
			SELECT @Resultado = CONVERT(decimal(18,2),CASE @ImpIncluido WHEN 1 THEN CONVERT(decimal(18,6),SUM(CASE WHEN vtc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(vtc.ID,vtc.RenglonID,'ImpIncDescuentosTotales'),0.00) ELSE ImpIncDescuentosTotales END)) ELSE CONVERT(decimal(18,6),SUM(CASE WHEN vtc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(vtc.ID,vtc.RenglonID,'DescuentosTotales'),0.00) ELSE DescuentosTotales END)) END + CONVERT(decimal(18,6),SUM(ISNULL(cfd.VentaDDescuentoImporte,0.00))))
			  FROM VentaTCalc vtc
		 LEFT JOIN CFDVentaDObsequioV33 cfd
				ON cfd.ID = vtc.ID
			   AND cfd.Renglon = vtc.Renglon
			 WHERE vtc.ID = @ID
			   AND vtc.Renglon = ISNULL(@Renglon,vtc.Renglon)
			   AND vtc.RenglonTipo <> 'C'
		END
	IF @Valor = 3
		BEGIN
			SELECT @Subtotal = CONVERT(decimal(18,2),CONVERT(decimal(18,6),SUM(CASE WHEN VentaTCalc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(VentaTCalc.ID,VentaTCalc.RenglonID,'SubTotalSinDL'),0.00) ELSE SubTotalSinDL END)))
			  FROM VentaTCalc
			 WHERE VentaTCalc.ID = @ID
			   AND Renglon = ISNULL(@Renglon,Renglon)
			   AND RenglonTipo <> 'C'
			SELECT @Descuento = CASE @ImpIncluido WHEN 1 THEN CONVERT(decimal(18,2),CONVERT(decimal(18,6),SUM(CASE WHEN VentaTCalc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(VentaTCalc.ID,VentaTCalc.RenglonID,'ImpIncDescuentosTotales'),0.00) ELSE ImpIncDescuentosTotales END))) ELSE CONVERT(decimal(18,2),CONVERT(decimal(18,6),SUM(CASE WHEN VentaTCalc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(VentaTCalc.ID,VentaTCalc.RenglonID,'DescuentosTotales'),0.00) ELSE DescuentosTotales END))) END
			  FROM VentaTCalc
			 WHERE VentaTCalc.ID = @ID
			   AND Renglon = ISNULL(@Renglon,Renglon)
			   AND RenglonTipo <> 'C'
			SELECT @Impuesto = ROUND(CONVERT(decimal(18,6),SUM(CASE WHEN VentaTCalc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(VentaTCalc.ID,VentaTCalc.RenglonID,'Impuesto1Total'),0.00) ELSE Impuesto1Total END)),2) + ROUND(CONVERT(decimal(18,6),SUM(CASE WHEN
 VentaTCalc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(VentaTCalc.ID,VentaTCalc.RenglonID,'Impuesto2Total'),0.00) ELSE Impuesto2Total END)),2) + ROUND(CONVERT(decimal(18,6),SUM(CASE WHEN VentaTCalc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(VentaTCalc.ID,VentaTCalc.RenglonID,'Impuesto3Total'),0.00) ELSE Impuesto3Total END)),2)
			  FROM VentaTCalc
			 WHERE VentaTCalc.ID = @ID
			   AND Renglon = ISNULL(@Renglon,Renglon)
			   AND RenglonTipo <> 'C'
			SELECT @Retencion = ROUND(ROUND(CONVERT(decimal(18,6),SUM(CASE WHEN VentaTCalc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(VentaTCalc.ID,VentaTCalc.RenglonID,'Retencion1Total'),0.00) ELSE CONVERT(money,Retencion1Total) END)),2) + ROUND(CONVERT(decimal(18,6),SUM(CASE WHEN VentaTCalc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(VentaTCalc.ID,VentaTCalc.RenglonID,'Retencion2Total'),0.00) ELSE CONVERT(money,Retencion2Total) END)),2) + ROUND(CONVERT(decimal(18,6),SUM(CASE WHEN VentaTCalc.RenglonTipo = 'J' THEN ISNULL(dbo.fnImporteJuego(VentaTCalc.ID,VentaTCalc.RenglonID,'Retencion3Total'),0.00) ELSE CONVERT(money,Retencion3Total) END)),2),2)
			  FROM VentaTCalc
			 WHERE VentaTCalc.ID = @ID
			   AND Renglon = ISNULL(@Renglon,Renglon)
			   AND RenglonTipo <> 'C'
			SELECT @Resultado = (@Subtotal-ISNULL(@Descuento,0)+ISNULL(@Impuesto,0)-ISNULL(@Retencion,0))
		END
	RETURN(ISNULL(@Resultado,0))
END
GO
--sp_HelpText fnValorCFDVentaV33
SELECT dbo.fnValorCFDVentaV33 (2548, 3, null)
--SELECT * FROM CFDVentaV33 WHERE Id = 2540
--SELECT ROUND(Retencion1Total,2),Retencion2Total,* FROM VentaTCalc WHERe Id = 2540