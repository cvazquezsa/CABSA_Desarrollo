ALTER VIEW dbo.CFDVtaTotalRetencionV33
AS
		SELECT REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,A.ID))))) + RTRIM(LTRIM(CONVERT(varchar,A.ID))) OrdenExportacion,
			   A.ID,
			   A.VentaDImpuestoTasaV33																Tasa,
			   A.VentaDTipoImpuestoV33																TipoImpuesto,
			   ROUND(SUM(CONVERT(money,A.VentaDRetencionImporteV33)),2)													Importe
		  FROM CFDVentaDMovRetTercerosV33 A
		 WHERE A.VentaDTipoImpuestoV33 = '001'
      GROUP BY A.ID, A.VentaDTipoImpuestoV33, A.VentaDImpuestoTasaV33
	 UNION ALL
		SELECT REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,A.ID))))) + RTRIM(LTRIM(CONVERT(varchar,A.ID))) OrdenExportacion,
			   A.ID,
			   A.VentaDImpuestoTasaV33																Tasa,
			   A.VentaDTipoImpuestoV33																TipoImpuesto,
			  ROUND(SUM(CONVERT(money,A.VentaDRetencionImporteV33)),2)														Importe
		  FROM CFDVentaDMovRetTercerosV33 A
		 WHERE A.VentaDTipoImpuestoV33 = '002'
      GROUP BY A.ID, A.VentaDTipoImpuestoV33, A.VentaDImpuestoTasaV33
	 UNION ALL
		SELECT REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,A.ID))))) + RTRIM(LTRIM(CONVERT(varchar,A.ID))) OrdenExportacion,
			   A.ID,
			   A.VentaDImpuestoTasaV33																Tasa,
			   A.VentaDTipoImpuestoV33																TipoImpuesto,
			   ROUND(SUM(CONVERT(money,A.VentaDRetencionImporteV33)),2)															Importe
		  FROM CFDVentaDMovRetTercerosV33 A
		 WHERE A.VentaDTipoImpuestoV33 = '003'
      GROUP BY A.ID, A.VentaDTipoImpuestoV33, A.VentaDImpuestoTasaV33
GO
SELECT * FROM CFDVtaTotalRetencionV33 WHERE ID = 2548

SELECT * fROM CFDVentaDMovRetTercerosV33 WHERE ID = 2548