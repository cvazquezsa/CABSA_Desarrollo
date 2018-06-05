ALTER VIEW dbo.CFDVtaTotalImpRetV33
AS
SELECT MAX(OrdenExportacion) OrdenExportacion, ID, SUM(ISNULL(Impuestos,0.00)) Impuestos, SUM(NULLIF(Retenciones,0.00)) Retenciones
	  FROM (
			SELECT A.OrdenExportacion, A.ID, SUM(CONVERT(decimal(18,6),CONVERT(decimal(18,6),ROUND(A.Importe,2)))) Retenciones, NULL Impuestos
			  FROM CFDVtaTotalRetencionV33 A
		  GROUP BY A.OrdenExportacion, A.ID, A.TipoImpuesto, A.Tasa
			 UNION
			SELECT A.OrdenExportacion, A.ID, NULL Retenciones, SUM(CONVERT(decimal(18,2),CONVERT(decimal(18,6),ROUND(A.Importe,2)))) Impuestos
			  FROM CFDVtaTotalImpuestoV33 A
		  GROUP BY A.OrdenExportacion, A.ID, A.TipoImpuesto, A.TasaOCuota
				 ) MovImpuestoGral
			GROUP BY ID

GO
SELECT * FROM CFDVtaTotalImpRetV33 WHERE ID = 2528

