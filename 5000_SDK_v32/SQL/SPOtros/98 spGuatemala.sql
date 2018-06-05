/**************************** Vista 1 ******************************************/
if exists (select * from sysobjects where id = object_id('dbo.CompraDGuatemala') and type = 'V') drop view dbo.CompraDGuatemala
GO
CREATE VIEW CompraDGuatemala
AS 
SELECT 'COMS' Modulo,
	   cd.ID,
	   cd.Renglon,
	   cd.RenglonSub,
	   cd.Articulo,
	   cd.SubCuenta,
	   CASE a.Tipo WHEN 'Servicio' THEN cd.Cantidad ELSE 0.0 END As CantidadServicio,
	   CASE a.Tipo WHEN 'Servicio' THEN cd.Unidad ELSE NULL END As UnidadServicio,
	   CASE a.Tipo WHEN 'Servicio' THEN ((((cd.cantidad * cd.Costo) * (1 - (ISNULL(cd.DescuentoLinea,0.0)/100))))) * c.TipoCambio ELSE 0.0 END As ImporteServicio,
	   CASE a.Tipo WHEN 'Servicio' THEN ((((cd.cantidad * cd.Costo) * (1 - (ISNULL(cd.DescuentoLinea,0.0)/100)))) * (ISNULL(cd.Impuesto1,0.0)/100)) * c.TipoCambio ELSE 0.0 END As ImpuestoServicio,
	   CASE WHEN a.Tipo <> 'Servicio' THEN cd.Cantidad ELSE 0.0 END As CantidadBienes,
	   CASE WHEN a.Tipo <> 'Servicio' THEN cd.Unidad ELSE NULL END As UnidadBienes,
	   CASE WHEN a.Tipo <> 'Servicio' THEN ((((cd.cantidad * cd.Costo) * (1 - (ISNULL(cd.DescuentoLinea,0.0)/100))) /*/ ( 1 + (ISNULL(cd.Impuesto1,0.0)/100))*/)) * c.TipoCambio ELSE 0.0 END As ImporteBienes,
	   CASE WHEN a.Tipo <> 'Servicio' THEN ((((cd.cantidad * cd.Costo) * (1 - (ISNULL(cd.DescuentoLinea,0.0)/100))) /*/ ( 1 + (ISNULL(cd.Impuesto1,0.0)/100))*/) * (ISNULL(cd.Impuesto1,0.0)/100)) * c.TipoCambio ELSE 0.0 END As ImpuestoBienes,
	   (((((cd.cantidad * cd.Costo) * (1 - (ISNULL(cd.DescuentoLinea,0.0)/100)))) * ((ISNULL(cd.Impuesto2,0.0)) / 100.0)) +
           (ISNULL(cd.Impuesto3,0.0) * ISNULL(cd.Cantidad,0.0))) * c.TipoCambio As Excento
  FROM CompraD cd JOIN Art a
    ON cd.Articulo = a.Articulo JOIN Compra c
    ON c.ID = cd.ID
UNION ALL	
SELECT 'GAS' Modulo,
	   gd.ID,
	   gd.Renglon,
	   gd.RenglonSub,
	   gd.Concepto Articulo,
	   CONVERT(varchar(50),NULL) SubCuenta,
	   gd.Cantidad As CantidadServicio,
	   CONVERT(varchar(50),NULL) Unidad,
	   (gd.cantidad * gd.Precio) * g.TipoCambio As ImporteServicio,
	   ((gd.cantidad * gd.Precio) * (ISNULL(gd.Impuesto1,0.0)/100)) * g.TipoCambio As ImpuestoServicio,
	   ISNULL(CONVERT(float,NULL),0.0) As CantidadBienes,
	   ISNULL(CONVERT(varchar(50),NULL),0.0) As UnidadBienes,
	   ISNULL(CONVERT(money,NULL),0.0) * g.TipoCambio As ImporteBienes,
	   ISNULL(CONVERT(money,NULL),0.0) * g.TipoCambio As ImpuestoBienes,
	   (((gd.cantidad * gd.Precio) * ((ISNULL(gd.Impuesto2,0.0)) / 100.0)) 
           + (ISNULL(gd.Cantidad,0.0) * ISNULL(gd.Impuesto3,0.0))) * g.TipoCambio  As Excento
  FROM GastoD gd JOIN Gasto g
    ON g.ID = gd.ID
GO

/**************************** Vista 2 ******************************************/
if exists (select * from sysobjects where id = object_id('dbo.CompraGuatemala') and type = 'V') drop view dbo.CompraGuatemala
GO
CREATE VIEW CompraGuatemala
AS SELECT 
    Modulo AS Modulo,
	ID As ID,
	SUM(CantidadServicio) As TotalCantidadServicio,
	SUM(ImporteServicio) As TotalImporteServicio,
	SUM(ImpuestoServicio) As TotalImpuestoServicio,
	SUM(CantidadBienes) As TotalCantidadBienes,
	SUM(ImporteBienes) As TotalImporteBienes,
	SUM(ImpuestoBienes) As TotalImpuestoBienes,
	SUM(Excento) As TotalExcento
  FROM CompraDGuatemala 
 GROUP BY Modulo, ID  
GO

/**************** spGuatemalaLibroCompra ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGuatemalaLibroCompra') and type = 'P') drop procedure dbo.spGuatemalaLibroCompra
GO             
CREATE PROCEDURE spGuatemalaLibroCompra
		(
		@Estacion			int
		)
		

--//WITH ENCRYPTION
AS
BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion				varchar(50),
	@Ok					int,
	@OkRef					varchar(255),
	@DocumentoNo				varchar(20),
	@Dia					varchar(2),
	@Mes					varchar(2),		
	@Ano					varchar(4),
	@TipoDeDocumento			varchar(30),
	@Nombre					varchar(100),
	@TotalFactura				money,
	@TotalCantidadImportacion		int,
	@TotalImporteImportacion		money,
	@TotalImpuestoImportacion		money,
	@TotalCantidadServicio			int,
	@TotalImporteServicio			money,
	@TotalImpuestoServicio			money,
	@ServicioNeto				money,
	@TotalCantidadBienes			int,
	@TotalImporteBienes			money,
	@TotalImpuestoBienes			money,
	@BienesNeto				money,
	@TotalExcento				money,
	@TotalTotalFactura			money,
	@TotalTotalImporteImportacion		money,
	@TotalTotalIVAImportacion		money,
	@TotalTotalServicioNeto			money,
	@TotalTotalServicioIVA			money,
	@TotalTotalBienesNeto			money,
	@TotalTotalBienesIVA			money,
	@TotalTotalExcento			money,
	@Contador				int,
	@LineasPorPagina			int,
	@Ejercicio				int,
	@Periodo				int,
	@Estatus				varchar(15),
	@Empresa				varchar(5)
	
  SET @Transaccion = 'spGuatemalaLibroCompra' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  BEGIN TRANSACTION @Transaccion
  
  SET @Estatus = 'CONCLUIDO'
  
  SELECT 
    @LineasPorPagina = InfoLineasPorPagina,
    @Ejercicio = InfoEjercicio,
    @Periodo = InfoPeriodoD,
    @Empresa = InfoEmpresa
    FROM RepParam
   WHERE Estacion = @Estacion
	
  DECLARE @Tabla	TABLE 
			(
			Tipo						varchar(20),
			DocumentoNo					varchar(20),
			DiaDoc						varchar(2),
			MesDoc						varchar(2),
			AnoDoc						varchar(4),
			TipoDeDocumento					varchar(30),
			Nombre						varchar(100),
			TotalFactura					money,			
			Importacion					money,
			IVAImportacion					money,
			ServiciosNeto					money,
			IVAServicios					money,
			BienesNeto					money,
			IVABienes					money,
			TotalExcento					money
			)
	

  DECLARE @CompraTotalGuatemala		TABLE
  (
      Modulo				varchar(5),  
      ID				int,
      TotalCantidadImportacion		float,
      TotalImporteImportacion		money,
      TotalImpuestoImportacion		money,
      TotalCantidadServicio		float,
      TotalImporteServicio		money,
      TotalImpuestoServicio		money,
      TotalCantidadBienes		float,
      TotalImporteBienes		money,
      TotalImpuestoBienes		money,
      TotalExcento			money
  )

  INSERT @CompraTotalGuatemala (Modulo, ID, TotalCantidadImportacion, TotalImporteImportacion, TotalImpuestoImportacion, TotalCantidadServicio, TotalImporteServicio, TotalImpuestoServicio, TotalCantidadBienes, TotalImporteBienes, TotalImpuestoBienes, TotalExcento)
  SELECT
      cg.Modulo,  
      cg.ID,
      CASE WHEN mt.Clave = 'COMS.EI' OR fr.Extranjero = 1 THEN TotalCantidadServicio + TotalCantidadBienes ELSE 0.0 END TotalCantidadImportacion,
      CASE WHEN mt.Clave = 'COMS.EI' OR fr.Extranjero = 1 THEN TotalImporteServicio + TotalImporteBienes ELSE 0.0 END TotalImporteImportacion,
      CASE WHEN mt.Clave = 'COMS.EI' OR fr.Extranjero = 1 THEN TotalImpuestoServicio + TotalImpuestoBienes ELSE 0.0 END TotalImpuestoImportacion,
      CASE WHEN mt.Clave = 'COMS.EI' OR fr.Extranjero = 1 THEN 0.0 ELSE TotalCantidadServicio END TotalCantidadServicio,
      CASE WHEN mt.Clave = 'COMS.EI' OR fr.Extranjero = 1 THEN 0.0 ELSE TotalImporteServicio END TotalImporteServicio,
      CASE WHEN mt.Clave = 'COMS.EI' OR fr.Extranjero = 1 THEN 0.0 ELSE TotalImpuestoServicio END TotalImpuestoServicio,
      CASE WHEN mt.Clave = 'COMS.EI' OR fr.Extranjero = 1 THEN 0.0 ELSE TotalCantidadBienes END TotalCantidadBienes,
      CASE WHEN mt.Clave = 'COMS.EI' OR fr.Extranjero = 1 THEN 0.0 ELSE TotalImporteBienes END TotalImporteBienes,
      CASE WHEN mt.Clave = 'COMS.EI' OR fr.Extranjero = 1 THEN 0.0 ELSE TotalImpuestoBienes END TotalImpuestoBienes,
      cg.TotalExcento     
    FROM CompraGuatemala cg LEFT OUTER JOIN Compra c
      ON cg.ID = c.ID AND cg.Modulo = 'COMS' LEFT OUTER JOIN MovTipo mt
      ON c.Mov = mt.Mov AND mt.Modulo = 'COMS' LEFT OUTER JOIN Gasto g
      ON cg.ID = g.ID AND cg.Modulo = 'GAS' LEFT OUTER JOIN Prov p
      ON p.Proveedor = g.Acreedor LEFT OUTER JOIN FiscalRegimen fr
      ON p.FiscalRegimen = fr.FiscalRegimen  


  DECLARE @LibroCompraGuatemalaTemp		TABLE
  (
	Empresa				varchar(5),
	Modulo				varchar(5),
	ID				int,
	DocumentoNo			varchar(50),
	Dia				int,
	Mes				int,
	Ano				int,
	TipodeDocumento			varchar(50),
	Nombre				varchar(100),
	TotalFactura			money,
	Estatus				varchar(15),
	Periodo				int,
	Ejercicio			int		
  )

  INSERT @LibroCompraGuatemalaTemp (Empresa, Modulo, ID, DocumentoNo, Dia, Mes, Ano, TipodeDocumento, Nombre, TotalFactura, Estatus, Periodo, Ejercicio)
  SELECT
	c.Empresa,
	'COMS' Modulo,
	c.ID,
	c.Referencia As DocumentoNo,
	ISNULL(RIGHT('0' + CONVERT(varchar,DATEPART(DAY, ISNULL(c.FechaProveedor,C.FechaEmision))),2),'') Dia,
	ISNULL(RIGHT('0' + CONVERT(varchar,DATEPART(MONTH, ISNULL(c.FechaProveedor,c.FechaEmision))),2),'') Mes,
	ISNULL(CONVERT(varchar,DATEPART(YEAR, ISNULL(c.FechaProveedor,c.FechaEmision))),'') Ano,
	CASE
	  WHEN mt.Clave = 'COMS.F'  THEN 'Factura' 
	  WHEN mt.Clave = 'COMS.EG' THEN 'Factura'
	  WHEN mt.Clave = 'COMS.EI' THEN 'Factura'
	  WHEN mt.Clave = 'COMS.F' AND mt.SubClave = 'COMS.CE/GT' THEN 'Factura'
	  WHEN mt.Clave = 'COMS.D'  THEN 'Nota de Cargo'
	END TipodeDocumento,
	p.Nombre,
	(ISNULL(c.Importe,0.0) + ISNULL(c.Impuestos,0.0)) * c.TipoCambio TotalFactura,
	ISNULL(c.Estatus,'') Estatus,
	ISNULL(c.Periodo,0) Periodo,
	ISNULL(c.Ejercicio,0) Ejercicio		
  FROM Compra c JOIN MovTipo mt
    ON mt.Mov = ISNULL(c.Mov,'') AND mt.Modulo = 'COMS' JOIN Prov p
    ON p.Proveedor = c.Proveedor
 WHERE mt.Clave IN ('COMS.F','COMS.EG','COMS.EI','COMS.D') 
UNION ALL
  SELECT
	g.Empresa,
	'GAS' Modulo,
	g.ID,
	g.Nota As DocumentoNo,
	ISNULL(RIGHT('0' + CONVERT(varchar,DATEPART(DAY, ISNULL(g.FechaRequerida,G.FechaEmision))),2),'') Dia,
	ISNULL(RIGHT('0' + CONVERT(varchar,DATEPART(MONTH, ISNULL(g.FechaRequerida,g.FechaEmision))),2),'') Mes,
	ISNULL(CONVERT(varchar,DATEPART(YEAR, ISNULL(g.FechaRequerida,g.FechaEmision))),'') Ano,
	CASE
	  WHEN mt.Clave = 'GAS.A'   THEN 'Factura'									
	  WHEN mt.Clave = 'GAS.G'   THEN 'Factura'
	  WHEN mt.Clave = 'GAS.GTC' THEN 'Factura'
	  WHEN mt.Clave = 'GAS.CP'  THEN 'Factura'
	  WHEN mt.Clave = 'GAS.OI'  THEN 'Factura'
      WHEN mt.Clave = 'GAS.G' AND mt.SubClave = 'GAS.CE/GT' THEN 'Factura'
	  WHEN mt.Clave = 'GAS.DG'  THEN 'Nota de Cargo'
	  WHEN mt.Clave = 'GAS.DC'  THEN 'Nota de Cargo'
	  WHEN mt.Clave = 'GAS.DGP' THEN 'Nota de Cargo'
	  WHEN mt.Clave = 'GAS.CB'  THEN 'Nota de Cargo'
	  WHEN mt.Clave = 'GAS.AB'  THEN 'Nota de Cargo'
	END TipodeDocumento,
	p.Nombre,
	(ISNULL(g.Importe,0.0) + ISNULL(g.Impuestos,0.0)) * g.TipoCambio TotalFactura,
	ISNULL(g.Estatus,'') Estatus,
	ISNULL(g.Periodo,0) Periodo,
	ISNULL(g.Ejercicio,0) Ejercicio		
  FROM Gasto g JOIN MovTipo mt
    ON mt.Mov = ISNULL(g.Mov,'') AND mt.Modulo = 'GAS' JOIN Prov p
    ON p.Proveedor = g.Acreedor
 WHERE mt.Clave IN ('GAS.A','GAS.G','GAS.GTC','GAS.CP','GAS.OI','GAS.G','GAS.DG','GAS.DC','GAS.DGP','GAS.CB','GAS.AB') 

  DECLARE @LibroCompraGuatemala		TABLE
  (
	Empresa				varchar(5),
	DocumentoNo			varchar(50),
	Dia				int,
	Mes				int,
	Ano				int,
	TipodeDocumento			varchar(50),
	Nombre				varchar(100),
	TotalFactura			money,
	TotalCantidadImportacion	float,
	TotalImporteImportacion		money,
	TotalImpuestoImportacion	money,	
	ImportacionNeto			money,	
	TotalCantidadServicio		float,
	TotalImporteServicio		money,
	TotalImpuestoServicio		money,	
	ServicioNeto			money,
	TotalCantidadBienes		float,
	TotalImporteBienes		money,
	TotalImpuestoBienes		money,
	BienesNeto			money,
	TotalExcento			money,
	Estatus				varchar(15),
	Periodo				int,
	Ejercicio			int		
  )

  INSERT @LibroCompraGuatemala (Empresa, DocumentoNo, Dia, Mes, Ano, TipodeDocumento, Nombre, TotalFactura, TotalCantidadImportacion, TotalImporteImportacion, TotalImpuestoImportacion,	 ImportacionNeto, TotalCantidadServicio, TotalImporteServicio, TotalImpuestoServicio, ServicioNeto, TotalCantidadBienes, TotalImporteBienes, TotalImpuestoBienes, BienesNeto, TotalExcento, Estatus, Periodo, Ejercicio)		

  SELECT
	lcgt.Empresa,
	lcgt.DocumentoNo,
	lcgt.Dia,
	lcgt.Mes,
	lcgt.Ano,
	lcgt.TipodeDocumento,
	lcgt.Nombre,
	lcgt.TotalFactura,
	ctg.TotalCantidadImportacion,
	ctg.TotalImporteImportacion,
	ctg.TotalImpuestoImportacion,	
	(ctg.TotalImporteImportacion + ctg.TotalImpuestoImportacion) AS ImportacionNeto,	
	ctg.TotalCantidadServicio,
	ctg.TotalImporteServicio,
	ctg.TotalImpuestoServicio,	
	(ctg.TotalImporteServicio + ctg.TotalImpuestoServicio) AS ServicioNeto,
	ctg.TotalCantidadBienes,
	ctg.TotalImporteBienes,
	ctg.TotalImpuestoBienes,
	(ctg.TotalImporteBienes + ctg.TotalImpuestoBienes) AS BienesNeto,
	ctg.TotalExcento,
	lcgt.Estatus,
	lcgt.Periodo,
	lcgt.Ejercicio		
  FROM @LibroCompraGuatemalaTemp lcgt JOIN @CompraTotalGuatemala ctg
    ON ctg.ID = lcgt.ID AND ctg.Modulo = lcgt.Modulo


  SET @Ok = NULL
  SET @Contador = 1
  SET @TotalTotalFactura = 0.0		
  SET @TotalTotalImporteImportacion = 0.0
  SET @TotalTotalIVAImportacion = 0.0
  SET @TotalTotalServicioNeto = 0.0			
  SET @TotalTotalServicioIVA = 0.0			
  SET @TotalTotalBienesNeto = 0.0			
  SET @TotalTotalBienesIVA = 0.0			
  SET @TotalTotalExcento = 0.0				


  DECLARE crLibroCompraGuatemala CURSOR FOR
   SELECT DocumentoNo, Dia, Mes, Ano, TipoDeDocumento, Nombre, TotalFactura, TotalCantidadImportacion, TotalImporteImportacion, TotalImpuestoImportacion,	TotalCantidadServicio, TotalImporteServicio, TotalImpuestoServicio, ServicioNeto, TotalCantidadBienes, TotalImporteBienes, TotalImpuestoBienes, BienesNeto, TotalExcento
     FROM @LibroCompraGuatemala lcg 
    WHERE lcg.Estatus = @Estatus AND Periodo = @Periodo AND Ejercicio = @Ejercicio AND Empresa = @Empresa
    ORDER BY Ano, Mes, Dia

  OPEN crLibroCompraGuatemala
  FETCH NEXT FROM crLibroCompraGuatemala INTO @DocumentoNo, @Dia, @Mes, @Ano, @TipoDeDocumento, @Nombre, @TotalFactura, @TotalCantidadImportacion, @TotalImporteImportacion, @TotalImpuestoImportacion,	@TotalCantidadServicio, @TotalImporteServicio, @TotalImpuestoServicio, @ServicioNeto, @TotalCantidadBienes, @TotalImporteBienes, @TotalImpuestoBienes, @BienesNeto, @TotalExcento
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    INSERT INTO @Tabla (Tipo,      DocumentoNo,  DiaDoc,  MesDoc,  AnoDoc,  TipoDeDocumento,  Nombre,  TotalFactura,  Importacion,              IVAImportacion,             ServiciosNeto,         IVAServicios,            BienesNeto,           IVABienes,            TotalExcento)		
                VALUES ('Detalle', @DocumentoNo, @Dia,    @Mes,    @Ano, @TipoDeDocumento, @Nombre, @TotalFactura, @TotalImporteImportacion, @TotalImpuestoImportacion,  @TotalImporteServicio, @TotalImpuestoServicio,  @TotalImporteBienes,  @TotalImpuestoBienes, @TotalExcento)
   
    IF @TipoDeDocumento = 'Factura'
    BEGIN            
      SET @TotalTotalFactura = @TotalTotalFactura + @TotalFactura		
      SET @TotalTotalImporteImportacion = @TotalTotalImporteImportacion + @TotalImporteImportacion
      SET @TotalTotalIVAImportacion = @TotalTotalIVAImportacion + @TotalImpuestoImportacion
      SET @TotalTotalServicioNeto = @TotalTotalServicioNeto + @TotalImporteServicio 	
      SET @TotalTotalServicioIVA = @TotalTotalServicioIVA + @TotalImpuestoServicio		
      SET @TotalTotalBienesNeto = @TotalTotalBienesNeto + @TotalImporteBienes	
      SET @TotalTotalBienesIVA = @TotalTotalBienesIVA + @TotalImpuestoBienes		
      SET @TotalTotalExcento =  @TotalTotalExcento + @TotalExcento
    END
    ELSE
    BEGIN
      SET @TotalTotalFactura = @TotalTotalFactura - @TotalFactura		
      SET @TotalTotalImporteImportacion = @TotalTotalImporteImportacion - @TotalImporteImportacion
      SET @TotalTotalIVAImportacion = @TotalTotalIVAImportacion - @TotalImpuestoImportacion
      SET @TotalTotalServicioNeto = @TotalTotalServicioNeto - @TotalImporteServicio 	
      SET @TotalTotalServicioIVA = @TotalTotalServicioIVA - @TotalImpuestoServicio		
      SET @TotalTotalBienesNeto = @TotalTotalBienesNeto - @TotalImporteBienes	
      SET @TotalTotalBienesIVA = @TotalTotalBienesIVA - @TotalImpuestoBienes		
      SET @TotalTotalExcento =  @TotalTotalExcento - @TotalExcento    
    END			   
      
      IF @Contador = @LineasPorPagina
      BEGIN
        INSERT @Tabla (Tipo,          TotalFactura,         Importacion,                   IVAImportacion,             ServiciosNeto,            IVAServicios,            BienesNeto,            IVABienes,            TotalExcento       )
               VALUES ('Total Van',   @TotalTotalFactura,   @TotalTotalImporteImportacion, @TotalTotalIVAImportacion,  @TotalTotalServicioNeto,  @TotalTotalServicioIVA,  @TotalTotalBienesNeto, @TotalTotalBienesIVA, @TotalTotalExcento )
        INSERT @Tabla (Tipo,          TotalFactura,         Importacion,                   IVAImportacion,             ServiciosNeto,            IVAServicios,            BienesNeto,            IVABienes,            TotalExcento       )
               VALUES ('Total Vienen',@TotalTotalFactura,   @TotalTotalImporteImportacion, @TotalTotalIVAImportacion,  @TotalTotalServicioNeto,  @TotalTotalServicioIVA,  @TotalTotalBienesNeto, @TotalTotalBienesIVA, @TotalTotalExcento )
            
        SET @Contador = 0       
      END 
   
    SET @Contador = @Contador + 1	
    FETCH NEXT FROM crLibroCompraGuatemala INTO @DocumentoNo, @Dia, @Mes, @Ano, @TipoDeDocumento, @Nombre, @TotalFactura, @TotalCantidadImportacion, @TotalImporteImportacion, @TotalImpuestoImportacion,	@TotalCantidadServicio, @TotalImporteServicio, @TotalImpuestoServicio, @ServicioNeto, @TotalCantidadBienes, @TotalImporteBienes, @TotalImpuestoBienes, @BienesNeto, @TotalExcento
  END
  CLOSE crLibroCompraGuatemala
  DEALLOCATE crLibroCompraGuatemala
  
  INSERT @Tabla (Tipo,           TotalFactura,         Importacion,                   IVAImportacion,             ServiciosNeto,            IVAServicios,            BienesNeto,            IVABienes,            TotalExcento       )
         VALUES ('Total General',@TotalTotalFactura,   @TotalTotalImporteImportacion, @TotalTotalIVAImportacion,  @TotalTotalServicioNeto,  @TotalTotalServicioIVA,  @TotalTotalBienesNeto, @TotalTotalBienesIVA, @TotalTotalExcento )
   
  SELECT * FROM @Tabla 

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION @Transaccion
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO


/**************************** Vista 1 ******************************************/
if exists (select * from sysobjects where id = object_id('dbo.VentaDGuatemala') and type = 'V') drop view dbo.VentaDGuatemala
GO    
    
CREATE VIEW VentaDGuatemala
AS SELECT 
           'VTAS' AS Modulo,
           vd.ID,
	   vd.Renglon,
	   vd.RenglonSub,
	   vd.Articulo,
	   vd.SubCuenta,
	   CASE a.Tipo WHEN 'Servicio' THEN vd.Cantidad ELSE 0.0 END As CantidadServicio,
	   CASE a.Tipo WHEN 'Servicio' THEN vd.Unidad ELSE NULL END As UnidadServicio,
	   CASE a.Tipo WHEN 'Servicio' THEN ((vd.cantidad * vd.Precio) * (1 - (ISNULL(vd.DescuentoLinea,0.0)/100))) / ( 1 + (ISNULL(vd.Impuesto1,0.0)/100)) * v.TipoCambio ELSE 0.0 END As ImporteServicio,
	   CASE a.Tipo WHEN 'Servicio' THEN ((vd.cantidad * vd.Precio) * (1 - (ISNULL(vd.DescuentoLinea,0.0)/100))) / ( 1 + (ISNULL(vd.Impuesto1,0.0)/100)) * (ISNULL(vd.Impuesto1,0.0)/100) * v.TipoCambio ELSE 0.0 END As ImpuestoServicio,
	   CASE WHEN a.Tipo <> 'Servicio' THEN vd.Cantidad ELSE 0.0 END As CantidadBienes,
	   CASE WHEN a.Tipo <> 'Servicio' THEN vd.Unidad ELSE NULL END As UnidadBienes,
	   CASE WHEN a.Tipo <> 'Servicio' THEN ((vd.cantidad * vd.Precio) * (1 - (ISNULL(vd.DescuentoLinea,0.0)/100))) / ( 1 + (ISNULL(vd.Impuesto1,0.0)/100)) * v.TipoCambio ELSE 0.0 END As ImporteBienes,
	   CASE WHEN a.Tipo <> 'Servicio' THEN ((vd.cantidad * vd.Precio) * (1 - (ISNULL(vd.DescuentoLinea,0.0)/100))) / ( 1 + (ISNULL(vd.Impuesto1,0.0)/100)) * (ISNULL(vd.Impuesto1,0.0)/100) * v.TipoCambio ELSE 0.0 END As ImpuestoBienes,
	   CONVERT(money,NULL) /*ISNULL(vd.Impuesto2,0.0) + ISNULL(vd.Impuesto3,0.0)*/ As Excento
  FROM VentaD vd JOIN Art a 
	ON vd.Articulo = a.Articulo JOIN Venta v
        ON vd.ID = v.ID
UNION ALL
SELECT     'CXC' As Modulo,
           vd.ID,
	   0,
	   0,
	   '',
	   '',
	   0.0 As CantidadServicio,
	   0.0 As UnidadServicio,
	   (vd.Importe * vd.TipoCambio) As ImporteServicio,
	   (vd.Impuestos * vd.TipoCambio) As ImpuestoServicio,
	   0.0 As CantidadBienes,
	   0.0 As UnidadBienes,
	   0.0 As ImporteBienes,
	   0.0 As ImpuestoBienes,
	   CONVERT(money,NULL) As Excento
  FROM cxc vd JOIN MovTipo mt
    ON vd.Mov = mt.Mov AND mt.Modulo = 'CXC'
  WHERE mt.Clave IN ('CXC.CA','CXC.NC')
GO

/**************************** Vista 2 ******************************************/
if exists (select * from sysobjects where id = object_id('dbo.VentaGuatemala') and type = 'V') drop view dbo.VentaGuatemala
GO

CREATE VIEW VentaGuatemala
AS SELECT
        Modulo AS Modulo, 
	ID As ID,
	SUM(CantidadServicio) As TotalCantidadServicio,
	SUM(ImporteServicio) As TotalImporteServicio,
	SUM(ImpuestoServicio) As TotalImpuestoServicio,
	SUM(CantidadBienes) As TotalCantidadBienes,
	SUM(ImporteBienes) As TotalImporteBienes,
	SUM(ImpuestoBienes) As TotalImpuestoBienes,
	SUM(Excento) As TotalExcento
  FROM VentaDGuatemala 
 GROUP BY Modulo, ID  
GO

/**************************** Vista 3 ******************************************/
if exists (select * from sysobjects where id = object_id('dbo.VentaTotalGuatemala') and type = 'V') drop view dbo.VentaTotalGuatemala
GO
CREATE VIEW VentaTotalGuatemala
AS SELECT 
        vg.Modulo,
	vg.ID,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN TotalCantidadServicio + TotalCantidadBienes ELSE 0.0 END TotalCantidadExportacion,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN TotalImporteServicio + TotalImporteBienes ELSE 0.0 END TotalImporteExportacion,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN TotalImpuestoServicio + TotalImpuestoBienes ELSE 0.0 END TotalImpuestoExportacion,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalCantidadServicio END TotalCantidadServicio,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalImporteServicio END TotalImporteServicio,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalImpuestoServicio END TotalImpuestoServicio,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalCantidadBienes END TotalCantidadBienes,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalImporteBienes END TotalImporteBienes,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalImpuestoBienes END TotalImpuestoBienes,
    ISNULL(mt.GuatemalaLibroVentaExento,0) GuatemalaLibroVentaExento,
    vg.TotalExcento     
  FROM VentaGuatemala vg JOIN Venta v
	ON vg.ID = v.ID JOIN MovTipo mt
	ON v.Mov = mt.Mov AND mt.Modulo = 'VTAS' JOIN Cte c
	ON v.Cliente = c.Cliente LEFT OUTER JOIN FiscalRegimen fr 
	ON c.FiscalRegimen = fr.FiscalRegimen
UNION ALL
SELECT 
    vg.Modulo,
    vg.ID,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN TotalCantidadServicio + TotalCantidadBienes ELSE 0.0 END TotalCantidadExportacion,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN TotalImporteServicio + TotalImporteBienes ELSE 0.0 END TotalImporteExportacion,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN TotalImpuestoServicio + TotalImpuestoBienes ELSE 0.0 END TotalImpuestoExportacion,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalCantidadServicio END TotalCantidadServicio,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalImporteServicio END TotalImporteServicio,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalImpuestoServicio END TotalImpuestoServicio,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalCantidadBienes END TotalCantidadBienes,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalImporteBienes END TotalImporteBienes,
    CASE WHEN ISNULL(fr.Extranjero,0) = 1 THEN 0.0 ELSE TotalImpuestoBienes END TotalImpuestoBienes,
    ISNULL(mt.GuatemalaLibroVentaExento,0) GuatemalaLibroVentaExento,
    vg.TotalExcento     
  FROM VentaGuatemala vg JOIN CxC v
	ON vg.ID = v.ID JOIN MovTipo mt
	ON v.Mov = mt.Mov AND mt.Modulo = 'CXC' JOIN Cte c
	ON v.Cliente = c.Cliente LEFT OUTER JOIN FiscalRegimen fr 
	ON c.FiscalRegimen = fr.FiscalRegimen

GO	

/**************************** Vista 4 ******************************************/
if exists (select * from sysobjects where id = object_id('dbo.LibroVentaGuatemala') and type = 'V') drop view dbo.LibroVentaGuatemala
GO
CREATE VIEW LibroVentaGuatemala
AS 
SELECT	
	v.Empresa,
	ISNULL(v.MovId,'') As DocumentoNo,
	RIGHT('0' + CONVERT(varchar,DATEPART(DAY, v.FechaEmision)),2) Dia,
	RIGHT('0' + CONVERT(varchar,DATEPART(MONTH, v.FechaEmision)),2) Mes,
	CONVERT(varchar,DATEPART(YEAR, v.FechaEmision)) Ano,
	CASE  
	  WHEN (mt.Clave = 'VTAS.F') THEN 'Factura' 
	  WHEN (mt.Clave = 'VTAS.EST') AND (mt.SubClave = 'VTAS.FA') THEN 'Factura' 
	  WHEN (mt.Clave = 'VTAS.D') THEN 'Devolucion'
	  WHEN (vtg.GuatemalaLibroVentaExento = 1) AND (mt.Clave NOT IN ('VTAS.F','VTAS.D','VTAS.EST'))THEN 'Exento'
	END TipodeDocumento,
	cte.Nombre,
	ISNULL(v.Importe,0.0) + ISNULL(v.Impuestos,0.0) TotalFactura,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalCantidadExportacion ELSE 0.0 END TotalCantidadExportacion,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImporteExportacion ELSE 0.0 END TotalImporteExportacion,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImpuestoExportacion ELSE 0.0 END TotalImpuestoExportacion,	
	CASE WHEN v.Estatus <> 'CANCELADO' THEN (vtg.TotalImporteExportacion + vtg.TotalImpuestoExportacion) ELSE 0.0 END ExpotacionNeto,	
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalCantidadServicio ELSE 0.0 END TotalCantidadServicio,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImporteServicio ELSE 0.0 END TotalImporteServicio,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImpuestoServicio ELSE 0.0 END TotalImpuestoServicio,	
	CASE WHEN v.Estatus <> 'CANCELADO' THEN (vtg.TotalImporteServicio + vtg.TotalImpuestoServicio) ELSE 0.0 END ServicioNeto,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalCantidadBienes ELSE 0.0 END TotalCantidadBienes,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImporteBienes ELSE 0.0 END TotalImporteBienes,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImpuestoBienes ELSE 0.0 END TotalImpuestoBienes,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN (vtg.TotalImporteBienes + vtg.TotalImpuestoBienes) ELSE 0.0 END BienesNeto,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalExcento ELSE 0.0 END TotalExcento,
	vtg.GuatemalaLibroVentaExento,
	v.Estatus,
	v.Periodo,
	v.Ejercicio		
  FROM	Venta v JOIN MovTipo mt
    ON  v.Mov = mt.Mov AND mt.Modulo = 'VTAS' JOIN Cte 
    ON  v.Cliente = Cte.Cliente JOIN VentaTotalGuatemala vtg
    ON  v.ID = vtg.ID AND vtg.Modulo = 'VTAS'   
 WHERE mt.Clave IN ('VTAS.F','VTAS.D','VTAS.B') OR (mt.Clave IN ('VTAS.EST') AND mt.SubClave in ('VTAS.FA'))

UNION ALL

SELECT	
	v.Empresa,
	ISNULL(v.MovId,'') As DocumentoNo,
	RIGHT('0' + CONVERT(varchar,DATEPART(DAY, v.FechaEmision)),2) Dia,
	RIGHT('0' + CONVERT(varchar,DATEPART(MONTH, v.FechaEmision)),2) Mes,
	CONVERT(varchar,DATEPART(YEAR, v.FechaEmision)) Ano,
	CASE  
	  WHEN (mt.Clave = 'CXC.CA') THEN 'Nota De Debito' 
	  WHEN (mt.Clave = 'CXC.NC') THEN 'Nota Credito' 
	END TipodeDocumento,
	cte.Nombre,
	ISNULL(v.Importe,0.0) + ISNULL(v.Impuestos,0.0) TotalFactura,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalCantidadExportacion ELSE 0.0 END TotalCantidadExportacion,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImporteExportacion ELSE 0.0 END TotalImporteExportacion,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImpuestoExportacion ELSE 0.0 END TotalImpuestoExportacion,	
	CASE WHEN v.Estatus <> 'CANCELADO' THEN (vtg.TotalImporteExportacion + vtg.TotalImpuestoExportacion) ELSE 0.0 END ExpotacionNeto,	
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalCantidadServicio ELSE 0.0 END TotalCantidadServicio,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImporteServicio ELSE 0.0 END TotalImporteServicio,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImpuestoServicio ELSE 0.0 END TotalImpuestoServicio,	
	CASE WHEN v.Estatus <> 'CANCELADO' THEN (vtg.TotalImporteServicio + vtg.TotalImpuestoServicio) ELSE 0.0 END ServicioNeto,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalCantidadBienes ELSE 0.0 END TotalCantidadBienes,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImporteBienes ELSE 0.0 END TotalImporteBienes,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalImpuestoBienes ELSE 0.0 END TotalImpuestoBienes,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN (vtg.TotalImporteBienes + vtg.TotalImpuestoBienes) ELSE 0.0 END BienesNeto,
	CASE WHEN v.Estatus <> 'CANCELADO' THEN vtg.TotalExcento ELSE 0.0 END TotalExcento,
	vtg.GuatemalaLibroVentaExento,
	v.Estatus,
	v.Periodo,
	v.Ejercicio		
  FROM	Cxc v JOIN MovTipo mt
    ON  v.Mov = mt.Mov AND mt.Modulo = 'CXC' JOIN Cte 
    ON  v.Cliente = Cte.Cliente JOIN VentaTotalGuatemala vtg
    ON  v.ID = vtg.ID AND vtg.Modulo = 'CXC'   
 WHERE mt.Clave IN ('CXC.CA','CXC.NC') 

GO    

/**************** spGuatemalaLibroVenta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGuatemalaLibroVenta') and type = 'P') drop procedure dbo.spGuatemalaLibroVenta
GO             
CREATE PROCEDURE spGuatemalaLibroVenta
		(
		@Estacion			int
		)
		

--//WITH ENCRYPTION
AS
BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion				varchar(50),
	@Ok					int,
	@OkRef					varchar(255),
	@DocumentoNo				varchar(20),
	@Dia					varchar(2),
	@Mes					varchar(2),		
	@Ano					varchar(4),
	@TipoDeDocumento			varchar(30),
	@Nombre					varchar(100),
	@TotalFactura				money,
	@TotalCantidadExportacion		int,
	@TotalImporteExportacion		money,
	@TotalImpuestoExportacion		money,
	@TotalCantidadServicio			int,
	@TotalImporteServicio			money,
	@TotalImpuestoServicio			money,
	@ServicioNeto				money,
	@TotalCantidadBienes			int,
	@TotalImporteBienes			money,
	@TotalImpuestoBienes			money,
	@BienesNeto				money,
	@TotalExcento				money,
	@TotalTotalFactura			money,
	@TotalTotalImporteExportacion		money,
	@TotalTotalIVAExportacion		money,
	@TotalTotalServicioNeto			money,
	@TotalTotalServicioIVA			money,
	@TotalTotalBienesNeto			money,
	@TotalTotalBienesIVA			money,
	@TotalTotalExcento			money,
	@Contador				int,
	@LineasPorPagina			int,
	@Ejercicio				int,
	@Periodo				int,
	@Estatus				varchar(15),
	@Empresa				varchar(5)
	
  SET @Transaccion = 'spGuatemalaLibroVenta' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  BEGIN TRANSACTION @Transaccion
  
  SET @Estatus = 'CONCLUIDO'
  
  SELECT 
    @LineasPorPagina = InfoLineasPorPagina,
    @Ejercicio = InfoEjercicio,
    @Periodo = InfoPeriodoD,
    @Empresa = InfoEmpresa
    FROM RepParam
   WHERE Estacion = @Estacion
		
		
  DECLARE @Tabla	TABLE (
			Tipo						varchar(20),
			DocumentoNo					varchar(20),
			DiaDoc						varchar(2),
			MesDoc						varchar(2),
			AnoDoc						varchar(4),
			TipoDeDocumento				varchar(30),
			Nombre						varchar(100),
			TotalFactura				money,			
			Exportacion					money,
			IVAExportacion				money,
			ServiciosNeto				money,
			IVAServicios				money,
			BienesNeto					money,
			IVABienes					money,
			TotalExcento				money)
	
	
  SET @Ok = NULL
  SET @Contador = 1
  SET @TotalTotalFactura = 0.0		
  SET @TotalTotalImporteExportacion = 0.0
  SET @TotalTotalIVAExportacion = 0.0
  SET @TotalTotalServicioNeto = 0.0			
  SET @TotalTotalServicioIVA = 0.0			
  SET @TotalTotalBienesNeto = 0.0			
  SET @TotalTotalBienesIVA = 0.0			
  SET @TotalTotalExcento = 0.0				


  DECLARE crLibroVentaGuatemala CURSOR FOR
   SELECT DocumentoNo, Dia, Mes, Ano, TipoDeDocumento, Nombre, TotalFactura, TotalCantidadExportacion, TotalImporteExportacion, TotalImpuestoExportacion,	TotalCantidadServicio, TotalImporteServicio, TotalImpuestoServicio, ServicioNeto, TotalCantidadBienes, TotalImporteBienes, TotalImpuestoBienes, BienesNeto, TotalExcento
     FROM LibroVentaGuatemala lvg 
    WHERE Estatus IN ('CONCLUIDO','CANCELADO') AND Periodo = @Periodo AND Ejercicio = @Ejercicio AND Empresa = @Empresa
    ORDER BY DocumentoNo
     
  OPEN crLibroVentaGuatemala
  FETCH NEXT FROM crLibroVentaGuatemala INTO @DocumentoNo, @Dia, @Mes, @Ano, @TipoDeDocumento, @Nombre, @TotalFactura, @TotalCantidadExportacion, @TotalImporteExportacion, @TotalImpuestoExportacion,	@TotalCantidadServicio, @TotalImporteServicio, @TotalImpuestoServicio, @ServicioNeto, @TotalCantidadBienes, @TotalImporteBienes, @TotalImpuestoBienes, @BienesNeto, @TotalExcento
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    INSERT INTO @Tabla (Tipo,      DocumentoNo,  DiaDoc,  MesDoc,  AnoDoc,  TipoDeDocumento,  Nombre,  TotalFactura,  Exportacion,              IVAExportacion,             ServiciosNeto,         IVAServicios,            BienesNeto,           IVABienes,            TotalExcento)		
                VALUES ('Detalle', @DocumentoNo, @Dia,    @Mes,    @Ano,    @TipoDeDocumento, @Nombre, @TotalFactura, @TotalImporteExportacion, @TotalImpuestoExportacion,  @TotalImporteServicio, @TotalImpuestoServicio,  @TotalImporteBienes,  @TotalImpuestoBienes, @TotalExcento)
    
    IF @TipoDeDocumento = 'Factura'
    BEGIN            
      SET @TotalTotalFactura = @TotalTotalFactura + @TotalFactura		
      SET @TotalTotalImporteExportacion = @TotalTotalImporteExportacion + @TotalImporteExportacion
      SET @TotalTotalIVAExportacion = @TotalTotalIVAExportacion + @TotalImpuestoExportacion
      SET @TotalTotalServicioNeto = @TotalTotalServicioNeto + @TotalImporteServicio 	
      SET @TotalTotalServicioIVA = @TotalTotalServicioIVA + @TotalImpuestoServicio		
      SET @TotalTotalBienesNeto = @TotalTotalBienesNeto + @TotalImporteBienes	
      SET @TotalTotalBienesIVA = @TotalTotalBienesIVA + @TotalImpuestoBienes		
      SET @TotalTotalExcento =  @TotalTotalExcento + @TotalExcento
    END
    ELSE
    BEGIN
      SET @TotalTotalFactura = @TotalTotalFactura - @TotalFactura		
      SET @TotalTotalImporteExportacion = @TotalTotalImporteExportacion - @TotalImporteExportacion
      SET @TotalTotalIVAExportacion = @TotalTotalIVAExportacion - @TotalImpuestoExportacion
      SET @TotalTotalServicioNeto = @TotalTotalServicioNeto - @TotalImporteServicio 	
      SET @TotalTotalServicioIVA = @TotalTotalServicioIVA - @TotalImpuestoServicio		
      SET @TotalTotalBienesNeto = @TotalTotalBienesNeto - @TotalImporteBienes	
      SET @TotalTotalBienesIVA = @TotalTotalBienesIVA - @TotalImpuestoBienes		
      SET @TotalTotalExcento =  @TotalTotalExcento - @TotalExcento    
    END
      
      IF @Contador = @LineasPorPagina
      BEGIN
        INSERT @Tabla (Tipo,          TotalFactura,         Exportacion,                   IVAExportacion,             ServiciosNeto,            IVAServicios,            BienesNeto,            IVABienes,            TotalExcento       )
               VALUES ('Total Van',   @TotalTotalFactura,   @TotalTotalImporteExportacion, @TotalTotalIVAExportacion,  @TotalTotalServicioNeto,  @TotalTotalServicioIVA,  @TotalTotalBienesNeto, @TotalTotalBienesIVA, @TotalTotalExcento )
        INSERT @Tabla (Tipo,          TotalFactura,         Exportacion,                   IVAExportacion,             ServiciosNeto,            IVAServicios,            BienesNeto,            IVABienes,            TotalExcento       )
               VALUES ('Total Vienen',@TotalTotalFactura,   @TotalTotalImporteExportacion, @TotalTotalIVAExportacion,  @TotalTotalServicioNeto,  @TotalTotalServicioIVA,  @TotalTotalBienesNeto, @TotalTotalBienesIVA, @TotalTotalExcento )
            
        SET @Contador = 0       
      END 
   
    SET @Contador = @Contador + 1	
    FETCH NEXT FROM crLibroVentaGuatemala INTO @DocumentoNo, @Dia, @Mes, @Ano, @TipoDeDocumento, @Nombre, @TotalFactura, @TotalCantidadExportacion, @TotalImporteExportacion, @TotalImpuestoExportacion,	@TotalCantidadServicio, @TotalImporteServicio, @TotalImpuestoServicio, @ServicioNeto, @TotalCantidadBienes, @TotalImporteBienes, @TotalImpuestoBienes, @BienesNeto, @TotalExcento
  END
  CLOSE crLibroVentaGuatemala
  DEALLOCATE crLibroVentaGuatemala
  
  INSERT @Tabla (Tipo,           TotalFactura,         Exportacion,                   IVAExportacion,             ServiciosNeto,            IVAServicios,            BienesNeto,            IVABienes,            TotalExcento       )
         VALUES ('Total General',@TotalTotalFactura,   @TotalTotalImporteExportacion, @TotalTotalIVAExportacion,  @TotalTotalServicioNeto,  @TotalTotalServicioIVA,  @TotalTotalBienesNeto, @TotalTotalBienesIVA, @TotalTotalExcento )
   

  SELECT * FROM @Tabla 

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION @Transaccion
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO
