-- drop table bplan
-- select * from bplan
/****** BPlan ******/
if not exists(select * from SysTabla where SysTabla = 'BPlan')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('BPlan', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.BPlan') and type = 'U') 
BEGIN
  CREATE TABLE dbo.BPlan (
	ID  int  NOT NULL IDENTITY(1,1),
	 
	Modulo   		char(5)  NOT NULL, 
	Empresa  		char(5)  NOT NULL, 
	Ejercicio  		int  NOT NULL, 
	Sucursal  		int  NOT NULL, 
	UEN  			int  NULL,
	Moneda			char(10),
	
	Articulo 		varchar(20) NULL,
	Clase			varchar(50) NULL,
	SubClase		varchar(50) NULL,
	Concepto 		varchar(50) NULL,
	CentroCostos		varchar(20) NULL,
	Plaza			varchar(20) NULL,
	Personal 		varchar(10) NULL,
	Usuario  		varchar(10) NULL,
	UltimoCambio 		datetime NULL,
	
	CantidadBase1 		float  NULL, -- Cantidad Neta Periodo
	CantidadBase2 		float  NULL,
	CantidadBase3 		float  NULL,
	CantidadBase4 		float  NULL,
	CantidadBase5 		float  NULL,
	CantidadBase6 		float  NULL,
	CantidadBase7 		float  NULL,
	CantidadBase8 		float  NULL,
	CantidadBase9 		float  NULL,
	CantidadBase10 		float  NULL,
	CantidadBase11 		float  NULL,
	CantidadBase12 		float  NULL,
	
	PrecioBase1 		money  NULL, -- Importe Neto / Cantidad Neta
	PrecioBase2 		money  NULL,
	PrecioBase3 		money  NULL,
	PrecioBase4 		money  NULL,
	PrecioBase5 		money  NULL,
	PrecioBase6 		money  NULL,
	PrecioBase7 		money  NULL,
	PrecioBase8 		money  NULL,
	PrecioBase9 		money  NULL,
	PrecioBase10 		money  NULL,
	PrecioBase11 		money  NULL,
	PrecioBase12 		money  NULL,
	
	Inc  			float  NULL, -- Moderado
	Inc2  			float  NULL, -- Optimista
	Inc3  			float  NULL, -- Pesimista
	
	Precio  		varchar(20)  NULL, -- Precio Promedio, Ultimo Precio, Precio Especifico
	Inf  			float  NULL, -- Inflacion Anual
	
	Usar  			varchar(20) NULL, -- Moderado / Optimista / Pesimista
	
	Cantidad1 		float  NULL, -- Cantidad Presupuesto (Usar)
	Cantidad2 		float  NULL,
	Cantidad3 		float  NULL,
	Cantidad4 		float  NULL,
	Cantidad5 		float  NULL,
	Cantidad6 		float  NULL,
	Cantidad7 		float  NULL,
	Cantidad8 		float  NULL,
	Cantidad9 		float  NULL,
	Cantidad10 		float  NULL,
	Cantidad11 		float  NULL,
	Cantidad12 		float  NULL,
	
	Precio1  		money  NULL, -- Precio Presupuesto (Considerando Inflacion)
	Precio2  		money  NULL,
	Precio3  		money  NULL,
	Precio4  		money  NULL,
	Precio5  		money  NULL,
	Precio6  		money  NULL,
	Precio7  		money  NULL,
	Precio8  		money  NULL,
	Precio9  		money  NULL,
	Precio10 		money  NULL,
	Precio11 		money  NULL,
	Precio12 		money  NULL,
 
 CONSTRAINT priBPlan PRIMARY KEY CLUSTERED (ID)
  ) 
  EXEC spSincroSemilla 'BPlan'
END
GO

EXEC spALTER_TABLE 'BPlan', 'CentroCostos', 'varchar(20) NULL'
GO

EXEC spADD_INDEX 'BPlan', 'Articulo', 'Articulo, Ejercicio, Sucursal, Empresa, Modulo'
EXEC spADD_INDEX 'BPlan', 'Concepto', 'Concepto, Ejercicio, Sucursal, Empresa, Modulo'
EXEC spADD_INDEX 'BPlan', 'Personal', 'Personal, Ejercicio, Sucursal, Empresa, Modulo'
GO

/**************** VerBPlanListaPrecio ****************/
if exists (select * from sysobjects where id = object_id('dbo.VerBPlanListaPrecio') and type = 'V') drop view dbo.VerBPlanListaPrecio
GO
CREATE VIEW VerBPlanListaPrecio
AS

  SELECT 'Orden' = 1, 'Lista' = 'Promedio Periodo'
  UNION
  SELECT 'Orden' = 2, 'Lista' = 'Del Último Mes'
  UNION
  SELECT 'Orden' = 3, 'Lista' = Lista FROM ListaPrecios

GO

/*
Ejercicio, Grupo, Categoria, Grupo, Familia, Fabricante, Clasificacion, %Inc, Lista de precios, redondeo, %Inflacion, Metodo
*/

if not exists (select * from sysobjects where id = object_id('dbo.BPlanAsisteInv') and type = 'U') 
  CREATE TABLE dbo.BPlanAsisteInv (
	Estacion		int,
	Ejercicio		int,
	Categoria		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Familia			varchar(50)	NULL,
 	Fabricante		varchar(50)	NULL,
	Linea			varchar(50)	NULL,
	Inc  			float  NULL, -- Moderado
	Inc2  			float  NULL, -- Optimista
	Inc3  			float  NULL, -- Pesimista
	Precio  		varchar(20)  NULL, -- Precio Promedio, Ultimo Mes, Precio Especifico
	Redondeo		float  NULL,
	Inf  			float  NULL, -- Inflacion Anual
	Usar 			varchar(20) NULL, -- Moderado / Optimista / Pesimista
 CONSTRAINT priBPlanAsisteInv PRIMARY KEY CLUSTERED (Estacion))

if not exists (select * from sysobjects where id = object_id('dbo.BPlanAsisteGas') and type = 'U') 
  CREATE TABLE dbo.BPlanAsisteGas (
	Estacion		int,
	Ejercicio		int,
	Clasificacion		varchar(50) NULL,
	SubClasificacion	varchar(50) NULL,
	Inc  			float  NULL, -- Moderado
	Inc2  			float  NULL, -- Optimista
	Inc3  			float  NULL, -- Pesimista
	Precio  		varchar(20)  NULL, -- Importe Promedio, Ultimo Mes
	Redondeo		float  NULL,
--	Inf  			float  NULL, -- Inflacion se usa la del concepto o clase
	Usar 			varchar(20) NULL, -- Moderado / Optimista / Pesimista
 CONSTRAINT priBPlanAsisteGas PRIMARY KEY CLUSTERED (Estacion))

if not exists (select * from sysobjects where id = object_id('dbo.BPlanAsisteNom') and type = 'U') 
  CREATE TABLE dbo.BPlanAsisteNom (
	Estacion		int,
	Ejercicio		int,
	Inc  			float  NULL, -- Moderado
	Inc2  			float  NULL, -- Optimista
	Inc3  			float  NULL, -- Pesimista
	Precio  		varchar(20)  NULL, -- Importe Promedio, Ultimo Mes
	Redondeo		float  NULL,
	Inf  			float  NULL, -- Inflacion Anual
	Usar 			varchar(20) NULL, -- Moderado / Optimista / Pesimista
 CONSTRAINT priBPlanAsisteNom PRIMARY KEY CLUSTERED (Estacion))

/**************** spBPlanGenerarBase ****************/
if exists (select * from sysobjects where id = object_id('dbo.spBPlanGenerarBase') and type = 'P') drop procedure dbo.spBPlanGenerarBase
GO
CREATE PROCEDURE spBPlanGenerarBase
		@Empresa		char(5),
		@Usuario		char(10),
		@Modulo			char(10),
		@Ejercicio		int,
		@Moneda			char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Sucursal			int,
	@UEN				int,
	@Ejercicio2			int,
	@Periodo			int,
	@Articulo			char(20),
	@Cantidad			float,
	@Personal			char(10),
	@Plaza				varchar(20),
	@Importe			money,
	@Clase				varchar(50),
	@SubClase			varchar(50),
	@Concepto			varchar(50),
	@CentroCostos			varchar(20),
	@AlmacenSuc			char(10),
	@Inf				money,
	@CantidadBase1			float,
	@CantidadBase2			float,
	@CantidadBase3			float,
	@CantidadBase4			float,
	@CantidadBase5			float,
	@CantidadBase6			float,
	@CantidadBase7			float,
	@CantidadBase8			float,
	@CantidadBase9			float,
	@CantidadBase10			float,
	@CantidadBase11			float,
	@CantidadBase12			float,
	@PrecioBase1			money,
	@PrecioBase2			money,
	@PrecioBase3			money,
	@PrecioBase4			money,
	@PrecioBase5			money,
	@PrecioBase6			money,
	@PrecioBase7			money,
	@PrecioBase8			money,
	@PrecioBase9			money,
	@PrecioBase10			money,
	@PrecioBase11			money,
	@PrecioBase12			money,
	@VentaPreciosImpuestoIncluido	bit

  SELECT @Ejercicio2 = @Ejercicio + 1
  DELETE BPlan WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2

  IF @Modulo = 'VTAS'
  BEGIN
    SELECT @VentaPreciosImpuestoIncluido = VentaPreciosImpuestoIncluido
      FROM EmpresaCfg 
     WHERE Empresa = @Empresa

    DECLARE crBPlanGenerarBase CURSOR LOCAL FOR
    SELECT e.Sucursal, e.UEN, NULLIF(d.ContUso, ''), DATEPART(month, e.FechaEmision), NULLIF(RTRIM(d.Articulo), ''), SUM(d.Cantidad*mt.Factor), 
       SUM((1-(ISNULL(e.DescuentoGlobal,0)/100))*(d.Precio*(ISNULL(d.Cantidad,0)*mt.Factor ))*((1-(case d.DescuentoTipo when '$' then (ISNULL(d.DescuentoLinea, 0.0)/d.Precio)*100 else ISNULL(d.DescuentoLinea,0.0) end)/100))/(1.0+((CASE @VentaPreciosImpuestoIncluido WHEN 1 THEN d.Impuesto1 ELSE 0 END)/100.0)))
      FROM Venta e, VentaD d, MovTipo mt
     WHERE e.ID = d.ID
       AND mt.Modulo = 'VTAS' AND mt.Mov = e.Mov 
       AND mt.Clave IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.D', 'VTAS.DFC', 'VTAS.EST') AND DATEPART(year, e.FechaEmision) = @Ejercicio
       AND e.Empresa = @Empresa AND e.Estatus = 'CONCLUIDO' 
       AND e.Moneda = @Moneda
     GROUP BY e.Sucursal, e.UEN, NULLIF(d.ContUso, ''), DATEPART(month, e.FechaEmision), NULLIF(RTRIM(d.Articulo), '')
     ORDER BY e.Sucursal, e.UEN, NULLIF(d.ContUso, ''), DATEPART(month, e.FechaEmision), NULLIF(RTRIM(d.Articulo), '')

    OPEN crBPlanGenerarBase
    FETCH NEXT FROM crBPlanGenerarBase INTO @Sucursal, @UEN, @CentroCostos, @Periodo, @Articulo, @Cantidad, @Importe
    WHILE @@FETCH_STATUS = 0
    BEGIN

      IF @Periodo = 1  UPDATE BPlan SET CantidadBase1  = ISNULL(CantidadBase1,0)  + @Cantidad, PrecioBase1  = ISNULL(PrecioBase1,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 2  UPDATE BPlan SET CantidadBase2  = ISNULL(CantidadBase2,0)  + @Cantidad, PrecioBase2  = ISNULL(PrecioBase2,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 3  UPDATE BPlan SET CantidadBase3  = ISNULL(CantidadBase3,0)  + @Cantidad, PrecioBase3  = ISNULL(PrecioBase3,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 4  UPDATE BPlan SET CantidadBase4  = ISNULL(CantidadBase4,0)  + @Cantidad, PrecioBase4  = ISNULL(PrecioBase4,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 5  UPDATE BPlan SET CantidadBase5  = ISNULL(CantidadBase5,0)  + @Cantidad, PrecioBase5  = ISNULL(PrecioBase5,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 6  UPDATE BPlan SET CantidadBase6  = ISNULL(CantidadBase6,0)  + @Cantidad, PrecioBase6  = ISNULL(PrecioBase6,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 7  UPDATE BPlan SET CantidadBase7  = ISNULL(CantidadBase7,0)  + @Cantidad, PrecioBase7  = ISNULL(PrecioBase7,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 8  UPDATE BPlan SET CantidadBase8  = ISNULL(CantidadBase8,0)  + @Cantidad, PrecioBase8  = ISNULL(PrecioBase8,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 9  UPDATE BPlan SET CantidadBase9  = ISNULL(CantidadBase9,0)  + @Cantidad, PrecioBase9  = ISNULL(PrecioBase9,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 10 UPDATE BPlan SET CantidadBase10 = ISNULL(CantidadBase10,0) + @Cantidad, PrecioBase10 = ISNULL(PrecioBase10,0) + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 11 UPDATE BPlan SET CantidadBase11 = ISNULL(CantidadBase11,0) + @Cantidad, PrecioBase11 = ISNULL(PrecioBase11,0) + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 12 UPDATE BPlan SET CantidadBase12 = ISNULL(CantidadBase12,0) + @Cantidad, PrecioBase12 = ISNULL(PrecioBase12,0) + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos 

      IF @@ROWCOUNT = 0
      BEGIN
        IF @Periodo = 1  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase1,  PrecioBase1)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 2  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase2,  PrecioBase2)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 3  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase3,  PrecioBase3)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 4  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase4,  PrecioBase4)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 5  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase5,  PrecioBase5)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 6  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase6,  PrecioBase6)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 7  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase7,  PrecioBase7)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 8  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase8,  PrecioBase8)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 9  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase9,  PrecioBase9)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 10 INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase10, PrecioBase10) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 11 INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase11, PrecioBase11) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 12 INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase12, PrecioBase12) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad)
      END

      FETCH NEXT FROM crBPlanGenerarBase INTO @Sucursal, @UEN, @CentroCostos, @Periodo, @Articulo, @Cantidad, @Importe
    END
    
    CLOSE crBPlanGenerarBase
    DEALLOCATE crBPlanGenerarBase

    SELECT 'Base del ' + Convert(varchar(4), @Ejercicio) + ' del Módulo de Ventas Generada.'
  END
  ELSE
  IF @Modulo = 'COMS'
  BEGIN
    DECLARE crBPlanGenerarBase CURSOR LOCAL FOR
    SELECT e.Sucursal, e.UEN, NULLIF(d.ContUso, ''), DATEPART(month, e.FechaEmision), NULLIF(RTRIM(d.Articulo), ''), SUM(d.Cantidad*mt.Factor), 
       SUM((1-(ISNULL(e.DescuentoGlobal,0)/100))*(d.Costo*(ISNULL(d.Cantidad,0)*mt.Factor ))*((1-(case d.DescuentoTipo when '$' then (ISNULL(d.DescuentoLinea, 0.0)/d.Costo)*100 else ISNULL(d.DescuentoLinea,0.0) end)/100)))
      FROM Compra e, CompraD d, MovTipo mt
     WHERE e.ID = d.ID
       AND mt.Modulo = 'COMS' AND mt.Mov = e.Mov 
       AND mt.Clave IN ('COMS.FL', 'COMS.D', 'COMS.F', 'COMS.EG', 'COMS.EI', 'COMS.EST') AND DATEPART(year, e.FechaEmision) = @Ejercicio
       AND e.Empresa = @Empresa AND e.Estatus = 'CONCLUIDO' 
       AND e.Moneda = @Moneda
     GROUP BY e.Sucursal, e.UEN, NULLIF(d.ContUso, ''), DATEPART(month, e.FechaEmision), NULLIF(RTRIM(d.Articulo), '')
     ORDER BY e.Sucursal, e.UEN, NULLIF(d.ContUso, ''), DATEPART(month, e.FechaEmision), NULLIF(RTRIM(d.Articulo), '')

    OPEN crBPlanGenerarBase
    FETCH NEXT FROM crBPlanGenerarBase INTO @Sucursal, @UEN, @CentroCostos, @Periodo, @Articulo, @Cantidad, @Importe
    WHILE @@FETCH_STATUS = 0
    BEGIN

      IF @Periodo = 1  UPDATE BPlan SET CantidadBase1  = ISNULL(CantidadBase1,0)  + @Cantidad, PrecioBase1  = ISNULL(PrecioBase1,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 2  UPDATE BPlan SET CantidadBase2  = ISNULL(CantidadBase2,0)  + @Cantidad, PrecioBase2  = ISNULL(PrecioBase2,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 3  UPDATE BPlan SET CantidadBase3  = ISNULL(CantidadBase3,0)  + @Cantidad, PrecioBase3  = ISNULL(PrecioBase3,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 4  UPDATE BPlan SET CantidadBase4  = ISNULL(CantidadBase4,0)  + @Cantidad, PrecioBase4  = ISNULL(PrecioBase4,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 5  UPDATE BPlan SET CantidadBase5  = ISNULL(CantidadBase5,0)  + @Cantidad, PrecioBase5  = ISNULL(PrecioBase5,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 6  UPDATE BPlan SET CantidadBase6  = ISNULL(CantidadBase6,0)  + @Cantidad, PrecioBase6  = ISNULL(PrecioBase6,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 7  UPDATE BPlan SET CantidadBase7  = ISNULL(CantidadBase7,0)  + @Cantidad, PrecioBase7  = ISNULL(PrecioBase7,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 8  UPDATE BPlan SET CantidadBase8  = ISNULL(CantidadBase8,0)  + @Cantidad, PrecioBase8  = ISNULL(PrecioBase8,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 9  UPDATE BPlan SET CantidadBase9  = ISNULL(CantidadBase9,0)  + @Cantidad, PrecioBase9  = ISNULL(PrecioBase9,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 10 UPDATE BPlan SET CantidadBase10 = ISNULL(CantidadBase10,0) + @Cantidad, PrecioBase10 = ISNULL(PrecioBase10,0) + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 11 UPDATE BPlan SET CantidadBase11 = ISNULL(CantidadBase11,0) + @Cantidad, PrecioBase11 = ISNULL(PrecioBase11,0) + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 12 UPDATE BPlan SET CantidadBase12 = ISNULL(CantidadBase12,0) + @Cantidad, PrecioBase12 = ISNULL(PrecioBase12,0) + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Articulo = @Articulo AND CentroCostos = @CentroCostos 

      IF @@ROWCOUNT = 0
      BEGIN
        IF @Periodo = 1  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase1,  PrecioBase1)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 2  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase2,  PrecioBase2)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 3  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase3,  PrecioBase3)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 4  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase4,  PrecioBase4)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 5  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase5,  PrecioBase5)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 6  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase6,  PrecioBase6)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 7  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase7,  PrecioBase7)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 8  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase8,  PrecioBase8)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 9  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase9,  PrecioBase9)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 10 INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase10, PrecioBase10) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 11 INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase11, PrecioBase11) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad) ELSE
        IF @Periodo = 12 INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Articulo, CentroCostos, Usuario, CantidadBase12, PrecioBase12) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Articulo, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad)
      END

      FETCH NEXT FROM crBPlanGenerarBase INTO @Sucursal, @UEN, @CentroCostos, @Periodo, @Articulo, @Cantidad, @Importe
    END
    
    CLOSE crBPlanGenerarBase
    DEALLOCATE crBPlanGenerarBase

    SELECT 'Base del ' + Convert(varchar(4), @Ejercicio) + ' del Módulo de Compras Generada.'
  END
  ELSE
  IF @Modulo = 'GAS'
  BEGIN
    DECLARE crBPlanGenerarBase CURSOR LOCAL FOR
    SELECT g.Sucursal, g.UEN, DATEPART(month, g.FechaEmision), c.Clase, c.SubClase, d.Concepto, NULLIF(RTRIM(d.ContUso),''), ISNULL(InflacionPresupuesto,0), SUM(d.Cantidad*m.Factor), SUM(d.Importe*m.Factor)
      FROM Gasto g, GastoD d, MovTipo m, Concepto c
     WHERE g.ID = d.ID
       AND d.Concepto = c.Concepto
       AND g.Mov = m.Mov AND m.Modulo = 'GAS' AND m.Clave in ('GAS.C', 'GAS.DC', 'GAS.DG', 'GAS.EST', 'GAS.CI', 'GAS.G', 'GAS.GTC')
    -- Comprobante, Dev. Comprobante, Devolucion Gasto, Estadistica, Gasto, Gasto T/Credito
       AND g.Empresa = @Empresa AND g.Estatus = 'CONCLUIDO'
       AND DATEPART(year, g.FechaEmision) = @Ejercicio
       AND c.Modulo = 'GAS' --AND c.CalcularPresupuesto = 1
       AND ISNULL(d.Importe,0) <> 0
       AND g.Moneda = @Moneda
     GROUP BY g.Sucursal, g.UEN, DATEPART(month, g.FechaEmision), c.Clase, c.SubClase, d.Concepto, NULLIF(RTRIM(d.ContUso),''), ISNULL(InflacionPresupuesto,0)
     ORDER BY g.Sucursal, g.UEN, c.Clase, c.SubClase, d.Concepto, NULLIF(RTRIM(d.ContUso),'')

    OPEN crBPlanGenerarBase
    FETCH NEXT FROM crBPlanGenerarBase INTO @Sucursal, @UEN, @Periodo, @Clase, @SubClase, @Concepto, @CentroCostos, @Inf, @Cantidad, @Importe
    WHILE @@FETCH_STATUS = 0
    BEGIN

      IF @Periodo = 1  UPDATE BPlan SET CantidadBase1  = ISNULL(CantidadBase1,0)  + @Cantidad, PrecioBase1  = ISNULL(PrecioBase1,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 2  UPDATE BPlan SET CantidadBase2  = ISNULL(CantidadBase2,0)  + @Cantidad, PrecioBase2  = ISNULL(PrecioBase2,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 3  UPDATE BPlan SET CantidadBase3  = ISNULL(CantidadBase3,0)  + @Cantidad, PrecioBase3  = ISNULL(PrecioBase3,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 4  UPDATE BPlan SET CantidadBase4  = ISNULL(CantidadBase4,0)  + @Cantidad, PrecioBase4  = ISNULL(PrecioBase4,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 5  UPDATE BPlan SET CantidadBase5  = ISNULL(CantidadBase5,0)  + @Cantidad, PrecioBase5  = ISNULL(PrecioBase5,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 6  UPDATE BPlan SET CantidadBase6  = ISNULL(CantidadBase6,0)  + @Cantidad, PrecioBase6  = ISNULL(PrecioBase6,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 7  UPDATE BPlan SET CantidadBase7  = ISNULL(CantidadBase7,0)  + @Cantidad, PrecioBase7  = ISNULL(PrecioBase7,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 8  UPDATE BPlan SET CantidadBase8  = ISNULL(CantidadBase8,0)  + @Cantidad, PrecioBase8  = ISNULL(PrecioBase8,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 9  UPDATE BPlan SET CantidadBase9  = ISNULL(CantidadBase9,0)  + @Cantidad, PrecioBase9  = ISNULL(PrecioBase9,0)  + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 10 UPDATE BPlan SET CantidadBase10 = ISNULL(CantidadBase10,0) + @Cantidad, PrecioBase10 = ISNULL(PrecioBase10,0) + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 11 UPDATE BPlan SET CantidadBase11 = ISNULL(CantidadBase11,0) + @Cantidad, PrecioBase11 = ISNULL(PrecioBase11,0) + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos ELSE
      IF @Periodo = 12 UPDATE BPlan SET CantidadBase12 = ISNULL(CantidadBase12,0) + @Cantidad, PrecioBase12 = ISNULL(PrecioBase12,0) + @Importe/@Cantidad WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Clase = @Clase AND SubClase = @SubClase AND Concepto = @Concepto AND CentroCostos = @CentroCostos

      IF @@ROWCOUNT = 0
      BEGIN
        IF @Periodo = 1  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase1,  PrecioBase1,  Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf) ELSE
        IF @Periodo = 2  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase2,  PrecioBase2,  Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf) ELSE
        IF @Periodo = 3  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase3,  PrecioBase3,  Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf) ELSE
        IF @Periodo = 4  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase4,  PrecioBase4,  Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf) ELSE
        IF @Periodo = 5  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase5,  PrecioBase5,  Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf) ELSE
        IF @Periodo = 6  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase6,  PrecioBase6,  Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf) ELSE
        IF @Periodo = 7  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase7,  PrecioBase7,  Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf) ELSE
        IF @Periodo = 8  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase8,  PrecioBase8,  Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf) ELSE
        IF @Periodo = 9  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase9,  PrecioBase9,  Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf) ELSE
        IF @Periodo = 10 INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase10, PrecioBase10, Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf) ELSE
        IF @Periodo = 11 INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase11, PrecioBase11, Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf) ELSE
        IF @Periodo = 12 INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Clase, SubClase, Concepto, CentroCostos, Usuario, CantidadBase12, PrecioBase12, Inf) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Clase, @SubClase, @Concepto, @CentroCostos, @Usuario, @Cantidad, @Importe/@Cantidad, @Inf)
      END

      FETCH NEXT FROM crBPlanGenerarBase INTO @Sucursal, @UEN, @Periodo, @Clase, @SubClase, @Concepto, @CentroCostos, @Inf, @Cantidad, @Importe
    END
    
    CLOSE crBPlanGenerarBase
    DEALLOCATE crBPlanGenerarBase

    SELECT 'Base del ' + Convert(varchar(4), @Ejercicio) + ' del Módulo de Gastos Generada.'

  END
  ELSE
  IF @Modulo = 'NOM'
  BEGIN
    DECLARE crBPlanGenerarBase CURSOR LOCAL FOR
    SELECT p.SucursalTrabajo, p.UEN, DATEPART(month, n.FechaEmision), NULLIF(p.Plaza,''), p.Personal, d.Concepto, 'Importe' = SUM(CASE d.Movimiento WHEN 'Deduccion' THEN -d.Importe ELSE d.Importe END)
      FROM Nomina n, NominaD d, MovTipo m, Personal p
     WHERE n.ID = d.ID
       AND n.Mov = m.Mov AND m.Modulo = 'NOM' AND m.Clave = 'NOM.N'
       AND d.Personal = p.Personal
       AND n.Empresa = @Empresa
       AND DATEPART(year, n.FechaEmision) = @Ejercicio
       AND n.Estatus = 'CONCLUIDO'
       AND d.Movimiento in ('Percepcion', 'Deduccion')
       AND n.Moneda = @Moneda
     GROUP BY p.SucursalTrabajo, p.UEN, DATEPART(month, n.FechaEmision), NULLIF(p.Plaza,''), p.Personal, d.Concepto
     ORDER BY p.SucursalTrabajo, NULLIF(p.Plaza,''), p.Personal, d.Concepto

    OPEN crBPlanGenerarBase
    FETCH NEXT FROM crBPlanGenerarBase INTO @Sucursal, @UEN, @Periodo, @Plaza, @Personal, @Concepto, @Importe
    WHILE @@FETCH_STATUS = 0
    BEGIN

      IF @Periodo = 1   UPDATE BPlan SET CantidadBase1  = 1,  PrecioBase1  = ISNULL(PrecioBase1,0)  + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto ELSE
      IF @Periodo = 2   UPDATE BPlan SET CantidadBase2  = 1,  PrecioBase2  = ISNULL(PrecioBase2,0)  + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto ELSE
      IF @Periodo = 3   UPDATE BPlan SET CantidadBase3  = 1,  PrecioBase3  = ISNULL(PrecioBase3,0)  + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto ELSE
      IF @Periodo = 4   UPDATE BPlan SET CantidadBase4  = 1,  PrecioBase4  = ISNULL(PrecioBase4,0)  + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto ELSE
      IF @Periodo = 5   UPDATE BPlan SET CantidadBase5  = 1,  PrecioBase5  = ISNULL(PrecioBase5,0)  + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto ELSE
      IF @Periodo = 6   UPDATE BPlan SET CantidadBase6  = 1,  PrecioBase6  = ISNULL(PrecioBase6,0)  + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto ELSE
      IF @Periodo = 7   UPDATE BPlan SET CantidadBase7  = 1,  PrecioBase7  = ISNULL(PrecioBase7,0)  + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto ELSE
      IF @Periodo = 8   UPDATE BPlan SET CantidadBase8  = 1,  PrecioBase8  = ISNULL(PrecioBase8,0)  + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto ELSE
      IF @Periodo = 9   UPDATE BPlan SET CantidadBase9  = 1,  PrecioBase9  = ISNULL(PrecioBase9,0)  + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto ELSE
      IF @Periodo = 10  UPDATE BPlan SET CantidadBase10 = 1, PrecioBase10 = ISNULL(PrecioBase10,0) + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto ELSE
      IF @Periodo = 11  UPDATE BPlan SET CantidadBase11 = 1, PrecioBase11 = ISNULL(PrecioBase11,0) + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto ELSE
      IF @Periodo = 12  UPDATE BPlan SET CantidadBase12 = 1, PrecioBase12 = ISNULL(PrecioBase12,0) + @Importe WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio2 AND Sucursal = @Sucursal AND UEN = @UEN AND Moneda = @Moneda AND Plaza = @Plaza AND Personal = @Personal AND Concepto = @Concepto

      IF @@ROWCOUNT = 0
      BEGIN
        IF @Periodo = 1   INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase1,  PrecioBase1)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe) ELSE
        IF @Periodo = 2   INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase2,  PrecioBase2)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe) ELSE
        IF @Periodo = 3   INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase3,  PrecioBase3)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe) ELSE
        IF @Periodo = 4   INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase4,  PrecioBase4)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe) ELSE
        IF @Periodo = 5   INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase5,  PrecioBase5)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe) ELSE
        IF @Periodo = 6   INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase6,  PrecioBase6)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe) ELSE
        IF @Periodo = 7   INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase7,  PrecioBase7)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe) ELSE
        IF @Periodo = 8   INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase8,  PrecioBase8)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe) ELSE
        IF @Periodo = 9   INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase9,  PrecioBase9)  VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe) ELSE
        IF @Periodo = 10  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase10, PrecioBase10) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe) ELSE
        IF @Periodo = 11  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase11, PrecioBase11) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe) ELSE
        IF @Periodo = 12  INSERT INTO BPlan(Modulo, Empresa, Ejercicio, Sucursal, UEN, Moneda, Plaza, Personal, Concepto, Usuario, CantidadBase12, PrecioBase12) VALUES(@Modulo, @Empresa, @Ejercicio2, @Sucursal, @UEN, @Moneda, @Plaza, @Personal, @Concepto, @Usuario, 1, @Importe)
      END

      FETCH NEXT FROM crBPlanGenerarBase INTO @Sucursal, @UEN, @Periodo, @Plaza, @Personal, @Concepto, @Importe
    END
    
    CLOSE crBPlanGenerarBase
    DEALLOCATE crBPlanGenerarBase

    SELECT 'Base del ' + Convert(varchar(4), @Ejercicio) + ' del Módulo de Nomina Generada.'

  END


  RETURN
END
GO

/**************** spBPlanSugiereInv ****************/
if exists (select * from sysobjects where id = object_id('dbo.spBPlanSugiereInv') and type = 'P') drop procedure dbo.spBPlanSugiereInv
GO
CREATE PROCEDURE spBPlanSugiereInv
		@Estacion		int,
		@Empresa		char(5),
		@Modulo			char(10),
		@Usuario		char(10),
		@Moneda			char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Ejercicio		int,

	@Articulo		char(20),
	@Categoria		char(50),
	@Grupo			char(50),
	@Familia		char(50),
	@Fabricante		char(50),
	@Linea			char(50),

	@ID			int,
	@UltimoCambio		datetime,
	@CantidadBase1		float,
	@CantidadBase2		float,
	@CantidadBase3		float,
	@CantidadBase4		float,
	@CantidadBase5		float,
	@CantidadBase6		float,
	@CantidadBase7		float,
	@CantidadBase8		float,
	@CantidadBase9		float,
	@CantidadBase10		float,
	@CantidadBase11		float,
	@CantidadBase12		float,
	@PrecioBase1		money,
	@PrecioBase2		money,
	@PrecioBase3		money,
	@PrecioBase4		money,
	@PrecioBase5		money,
	@PrecioBase6		money,
	@PrecioBase7		money,
	@PrecioBase8		money,
	@PrecioBase9		money,
	@PrecioBase10		money,
	@PrecioBase11		money,
	@PrecioBase12		money,
	@Inc			float,
	@Inc2			float,
	@Inc3			float,
	@Precio			varchar(20),
	@Inf			float,
	@Usar			varchar(20),
	@Cantidad1		float,
	@Cantidad2		float,
	@Cantidad3		float,
	@Cantidad4		float,
	@Cantidad5		float,
	@Cantidad6		float,
	@Cantidad7		float,
	@Cantidad8		float,
	@Cantidad9		float,
	@Cantidad10		float,
	@Cantidad11		float,
	@Cantidad12		float,
	@Precio1		money,
	@Precio2		money,
	@Precio3		money,
	@Precio4		money,
	@Precio5		money,
	@Precio6		money,
	@Precio7		money,
	@Precio8		money,
	@Precio9		money,
	@Precio10		money,
	@Precio11		money,
	@Precio12		money,

	@PrecioNuevo1		money,
	@PrecioNuevo2		money,
	@PrecioNuevo3		money,
	@PrecioNuevo4		money,
	@PrecioNuevo5		money,
	@PrecioNuevo6		money,
	@PrecioNuevo7		money,
	@PrecioNuevo8		money,
	@PrecioNuevo9		money,
	@PrecioNuevo10		money,
	@PrecioNuevo11		money,
	@PrecioNuevo12		money,
	@Redondeo		money,

        @PrecioNuevo		money,
	@IncNuevo		float

  SELECT @Ejercicio = Ejercicio, @Categoria = RTRIM(Categoria), @Grupo = RTRIM(Grupo), @Familia = RTRIM(Familia), @Fabricante = RTRIM(Fabricante), @Linea = RTRIM(Linea), 
	 @Inc = ISNULL(Inc,0), @Inc2 = ISNULL(Inc2,0), @Inc3 = ISNULL(Inc3,0), @Precio = ISNULL(Precio, 'Promedio Periodo'),
	 @Redondeo = ISNULL(Redondeo,0), @Inf = ISNULL(Inf,0), @Usar = NULLIF(RTRIM(Usar),'')
    FROM BPlanAsisteInv
   WHERE Estacion = @Estacion

  IF @Categoria	 in ('NULL', '', '0', '(Todos)') SELECT @Categoria  = NULL
  IF @Grupo	 in ('NULL', '', '0', '(Todos)') SELECT @Grupo      = NULL
  IF @Familia	 in ('NULL', '', '0', '(Todos)') SELECT @Familia    = NULL
  IF @Fabricante in ('NULL', '', '0', '(Todos)') SELECT @Fabricante = NULL
  IF @Linea	 in ('NULL', '', '0', '(Todos)') SELECT @Linea      = NULL

  IF @Usar is null
  BEGIN
    SELECT 'Se requiere indicar el Método para proyectar el Presupuesto'
    RETURN
  END

  UPDATE BPlan SET Inc = @Inc, Inc2 = @Inc2, Inc3 = @Inc3, Precio = @Precio, Inf = @Inf, Usar = @Usar
    FROM Art a
   WHERE a.Articulo = BPlan.Articulo
     AND BPlan.Modulo = @Modulo AND BPlan.Empresa = @Empresa AND BPlan.Ejercicio = @Ejercicio AND BPlan.Moneda = @Moneda
     AND ISNULL(a.Categoria,'')  = CASE @Categoria  WHEN NULL THEN ISNULL(a.Categoria,'')  ELSE @Categoria  END
     AND ISNULL(a.Grupo,'')      = CASE @Grupo      WHEN NULL THEN ISNULL(a.Grupo,'')      ELSE @Grupo      END
     AND ISNULL(a.Familia,'')    = CASE @Familia    WHEN NULL THEN ISNULL(a.Familia,'')    ELSE @Familia    END
     AND ISNULL(a.Fabricante,'') = CASE @Fabricante WHEN NULL THEN ISNULL(a.Fabricante,'') ELSE @Fabricante END
     AND ISNULL(a.Linea,'')      = CASE @Linea      WHEN NULL THEN ISNULL(a.Linea,'')      ELSE @Linea      END

  IF @Modulo in ('VTAS', 'COMS')
  BEGIN
    DECLARE crBPlanSugiereInv CURSOR LOCAL FOR
    SELECT ID, b.Articulo, CantidadBase1, CantidadBase2, CantidadBase3, CantidadBase4, CantidadBase5, CantidadBase6, 
           CantidadBase7, CantidadBase8, CantidadBase9, CantidadBase10, CantidadBase11, CantidadBase12, 
           PrecioBase1, PrecioBase2, PrecioBase3, PrecioBase4, PrecioBase5, PrecioBase6, 
           PrecioBase7, PrecioBase8, PrecioBase9, PrecioBase10, PrecioBase11, PrecioBase12,
           Inc, Inc2, Inc3, Precio, Inf, Usar
      FROM BPlan b, Art a
     WHERE b.Articulo = a.Articulo
       AND b.Modulo = @Modulo AND b.Empresa = @Empresa AND b.Ejercicio = @Ejercicio AND b.Moneda = @Moneda
       AND ISNULL(a.Categoria,'')  = CASE @Categoria  WHEN NULL THEN ISNULL(a.Categoria,'')  ELSE @Categoria  END
       AND ISNULL(a.Grupo,'')      = CASE @Grupo      WHEN NULL THEN ISNULL(a.Grupo,'')      ELSE @Grupo      END
       AND ISNULL(a.Familia,'')    = CASE @Familia    WHEN NULL THEN ISNULL(a.Familia,'')    ELSE @Familia    END
       AND ISNULL(a.Fabricante,'') = CASE @Fabricante WHEN NULL THEN ISNULL(a.Fabricante,'') ELSE @Fabricante END
       AND ISNULL(a.Linea,'')      = CASE @Linea      WHEN NULL THEN ISNULL(a.Linea,'')      ELSE @Linea      END

    OPEN crBPlanSugiereInv
    FETCH NEXT FROM crBPlanSugiereInv INTO @ID, @Articulo, @CantidadBase1, @CantidadBase2, @CantidadBase3, @CantidadBase4, @CantidadBase5, @CantidadBase6, 
           @CantidadBase7, @CantidadBase8, @CantidadBase9, @CantidadBase10, @CantidadBase11, @CantidadBase12, 
           @PrecioBase1, @PrecioBase2, @PrecioBase3, @PrecioBase4, @PrecioBase5, @PrecioBase6, 
           @PrecioBase7, @PrecioBase8, @PrecioBase9, @PrecioBase10, @PrecioBase11, @PrecioBase12,
           @Inc, @Inc2, @Inc3, @Precio, @Inf, @Usar
    WHILE @@FETCH_STATUS = 0
    BEGIN
      SELECT @PrecioNuevo = NULL

      IF @Precio = 'Del Último Mes' SELECT @PrecioNuevo = @PrecioBase12 ELSE
      IF @Precio <> 'Promedio Periodo' SELECT @PrecioNuevo = Precio FROM ListaPreciosD WHERE Lista = @Precio AND Moneda = @Moneda AND Articulo = @Articulo

      IF @Usar = 'Moderado'  SELECT @IncNuevo = @Inc  ELSE
      IF @Usar = 'Optimista' SELECT @IncNuevo = @Inc2 ELSE
      IF @Usar = 'Pesimista' SELECT @IncNuevo = @Inc3

/*      SELECT @PrecioNuevo1  = ISNULL(@PrecioNuevo, @PrecioBase1)  *(1+((@Inf/100)/12)),
             @PrecioNuevo2  = ISNULL(@PrecioNuevo, @PrecioBase2)  *(1+((@Inf/100)/12)),
             @PrecioNuevo3  = ISNULL(@PrecioNuevo, @PrecioBase3)  *(1+((@Inf/100)/12)),
             @PrecioNuevo4  = ISNULL(@PrecioNuevo, @PrecioBase4)  *(1+((@Inf/100)/12)),
             @PrecioNuevo5  = ISNULL(@PrecioNuevo, @PrecioBase5)  *(1+((@Inf/100)/12)),
             @PrecioNuevo6  = ISNULL(@PrecioNuevo, @PrecioBase6)  *(1+((@Inf/100)/12)),
             @PrecioNuevo7  = ISNULL(@PrecioNuevo, @PrecioBase7)  *(1+((@Inf/100)/12)),
             @PrecioNuevo8  = ISNULL(@PrecioNuevo, @PrecioBase8)  *(1+((@Inf/100)/12)),
             @PrecioNuevo9  = ISNULL(@PrecioNuevo, @PrecioBase9)  *(1+((@Inf/100)/12)),
             @PrecioNuevo10 = ISNULL(@PrecioNuevo, @PrecioBase10) *(1+((@Inf/100)/12)),
             @PrecioNuevo11 = ISNULL(@PrecioNuevo, @PrecioBase11) *(1+((@Inf/100)/12)),
             @PrecioNuevo12 = ISNULL(@PrecioNuevo, @PrecioBase12) *(1+((@Inf/100)/12))
*/

      UPDATE BPlan SET Cantidad1  = @CantidadBase1 *(1+(@IncNuevo/100)), Precio1  = ISNULL(@PrecioNuevo, @PrecioBase1) *(1+((@Inf/100)/12)),
                       Cantidad2  = @CantidadBase2 *(1+(@IncNuevo/100)), Precio2  = ISNULL(@PrecioNuevo, @PrecioBase2) *(1+((@Inf/100)/12)),
                       Cantidad3  = @CantidadBase3 *(1+(@IncNuevo/100)), Precio3  = ISNULL(@PrecioNuevo, @PrecioBase3) *(1+((@Inf/100)/12)),
                       Cantidad4  = @CantidadBase4 *(1+(@IncNuevo/100)), Precio4  = ISNULL(@PrecioNuevo, @PrecioBase4) *(1+((@Inf/100)/12)),
                       Cantidad5  = @CantidadBase5 *(1+(@IncNuevo/100)), Precio5  = ISNULL(@PrecioNuevo, @PrecioBase5) *(1+((@Inf/100)/12)),
                       Cantidad6  = @CantidadBase6 *(1+(@IncNuevo/100)), Precio6  = ISNULL(@PrecioNuevo, @PrecioBase6) *(1+((@Inf/100)/12)),
                       Cantidad7  = @CantidadBase7 *(1+(@IncNuevo/100)), Precio7  = ISNULL(@PrecioNuevo, @PrecioBase7) *(1+((@Inf/100)/12)),
                       Cantidad8  = @CantidadBase8 *(1+(@IncNuevo/100)), Precio8  = ISNULL(@PrecioNuevo, @PrecioBase8) *(1+((@Inf/100)/12)),
                       Cantidad9  = @CantidadBase9 *(1+(@IncNuevo/100)), Precio9  = ISNULL(@PrecioNuevo, @PrecioBase9) *(1+((@Inf/100)/12)),
                       Cantidad10 = @CantidadBase10*(1+(@IncNuevo/100)), Precio10 = ISNULL(@PrecioNuevo, @PrecioBase10)*(1+((@Inf/100)/12)),
                       Cantidad11 = @CantidadBase11*(1+(@IncNuevo/100)), Precio11 = ISNULL(@PrecioNuevo, @PrecioBase11)*(1+((@Inf/100)/12)),
                       Cantidad12 = @CantidadBase12*(1+(@IncNuevo/100)), Precio12 = ISNULL(@PrecioNuevo, @PrecioBase12)*(1+((@Inf/100)/12))
       WHERE CURRENT OF crBPlanSugiereInv

      FETCH NEXT FROM crBPlanSugiereInv INTO @ID, @Articulo, @CantidadBase1, @CantidadBase2, @CantidadBase3, @CantidadBase4, @CantidadBase5, @CantidadBase6, 
             @CantidadBase7, @CantidadBase8, @CantidadBase9, @CantidadBase10, @CantidadBase11, @CantidadBase12, 
             @PrecioBase1, @PrecioBase2, @PrecioBase3, @PrecioBase4, @PrecioBase5, @PrecioBase6, 
             @PrecioBase7, @PrecioBase8, @PrecioBase9, @PrecioBase10, @PrecioBase11, @PrecioBase12,
             @Inc, @Inc2, @Inc3, @Precio, @Inf, @Usar
    END

    CLOSE crBPlanSugiereInv
    DEALLOCATE crBPlanSugiereInv
  END

  SELECT 'Proceso Concluido'
  RETURN
END
GO

/**************** spBPlanSugiereGas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spBPlanSugiereGas') and type = 'P') drop procedure dbo.spBPlanSugiereGas
GO
CREATE PROCEDURE spBPlanSugiereGas
		@Estacion		int,
		@Empresa		char(5),
		@Modulo			char(10),
		@Usuario		char(10),
		@Moneda			char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Ejercicio		int,
	@Clase			varchar(50),
	@SubClase		varchar(50),
	@Concepto		varchar(50),
	@CentroCostos		varchar(20),

	@ID			int,
	@UltimoCambio		datetime,
	@CantidadBase1		float,
	@CantidadBase2		float,
	@CantidadBase3		float,
	@CantidadBase4		float,
	@CantidadBase5		float,
	@CantidadBase6		float,
	@CantidadBase7		float,
	@CantidadBase8		float,
	@CantidadBase9		float,
	@CantidadBase10		float,
	@CantidadBase11		float,
	@CantidadBase12		float,
	@PrecioBase1		money,
	@PrecioBase2		money,
	@PrecioBase3		money,
	@PrecioBase4		money,
	@PrecioBase5		money,
	@PrecioBase6		money,
	@PrecioBase7		money,
	@PrecioBase8		money,
	@PrecioBase9		money,
	@PrecioBase10		money,
	@PrecioBase11		money,
	@PrecioBase12		money,
	@Inc			float,
	@Inc2			float,
	@Inc3			float,
	@Precio			varchar(20),
	@Inf			float,
	@Usar			varchar(20),
	@Cantidad1		float,
	@Cantidad2		float,
	@Cantidad3		float,
	@Cantidad4		float,
	@Cantidad5		float,
	@Cantidad6		float,
	@Cantidad7		float,
	@Cantidad8		float,
	@Cantidad9		float,
	@Cantidad10		float,
	@Cantidad11		float,
	@Cantidad12		float,
	@Precio1		money,
	@Precio2		money,
	@Precio3		money,
	@Precio4		money,
	@Precio5		money,
	@Precio6		money,
	@Precio7		money,
	@Precio8		money,
	@Precio9		money,
	@Precio10		money,
	@Precio11		money,
	@Precio12		money,

	@PrecioNuevo1		money,
	@PrecioNuevo2		money,
	@PrecioNuevo3		money,
	@PrecioNuevo4		money,
	@PrecioNuevo5		money,
	@PrecioNuevo6		money,
	@PrecioNuevo7		money,
	@PrecioNuevo8		money,
	@PrecioNuevo9		money,
	@PrecioNuevo10		money,
	@PrecioNuevo11		money,
	@PrecioNuevo12		money,
	@Redondeo		money,

        @PrecioNuevo		money,
	@IncNuevo		float

  SELECT @Ejercicio = Ejercicio, @Clase = RTRIM(Clasificacion), @SubClase = RTRIM(SubClasificacion),
	 @Inc = ISNULL(Inc,0), @Inc2 = ISNULL(Inc2,0), @Inc3 = ISNULL(Inc3,0), @Precio = ISNULL(Precio, 'Importe Promedio'),
	 @Redondeo = ISNULL(Redondeo,0), @Usar = NULLIF(RTRIM(Usar),'')
    FROM BPlanAsisteGas
   WHERE Estacion = @Estacion

  IF @Usar is null
  BEGIN
    SELECT 'Se requiere indicar el Método para proyectar el Presupuesto'
    RETURN
  END

  IF @Clase	 in ('NULL', '', '0', '(Todos)') SELECT @Clase  = NULL
  IF @SubClase	 in ('NULL', '', '0', '(Todos)') SELECT @SubClase  = NULL

  UPDATE BPlan SET Inc = @Inc, Inc2 = @Inc2, Inc3 = @Inc3, Precio = @Precio, Usar = @Usar
   WHERE BPlan.Modulo = @Modulo AND BPlan.Empresa = @Empresa AND BPlan.Ejercicio = @Ejercicio AND BPlan.Moneda = @Moneda
     AND ISNULL(Clase,'')     = CASE @Clase     WHEN NULL THEN ISNULL(Clase,'')     ELSE @Clase END
     AND ISNULL(SubClase,'')  = CASE @SubClase  WHEN NULL THEN ISNULL(SubClase,'')  ELSE @SubClase END

  IF @Modulo = 'GAS'
  BEGIN
    DECLARE crBPlanSugiereGas CURSOR LOCAL FOR
    SELECT ID, b.Clase, b.SubClase, b.Concepto, b.CentroCostos, CantidadBase1, CantidadBase2, CantidadBase3, CantidadBase4, CantidadBase5, CantidadBase6, 
           CantidadBase7, CantidadBase8, CantidadBase9, CantidadBase10, CantidadBase11, CantidadBase12, 
           PrecioBase1, PrecioBase2, PrecioBase3, PrecioBase4, PrecioBase5, PrecioBase6, 
           PrecioBase7, PrecioBase8, PrecioBase9, PrecioBase10, PrecioBase11, PrecioBase12,
           Inc, Inc2, Inc3, Precio, Inf, Usar
      FROM BPlan b
     WHERE b.Modulo = @Modulo AND b.Empresa = @Empresa AND b.Ejercicio = @Ejercicio AND b.Moneda = @Moneda
       AND ISNULL(Clase,'')     = CASE @Clase     WHEN NULL THEN ISNULL(Clase,'')     ELSE @Clase END
      AND ISNULL(SubClase,'')  = CASE @SubClase  WHEN NULL THEN ISNULL(SubClase,'')  ELSE @SubClase END

    OPEN crBPlanSugiereGas
    FETCH NEXT FROM crBPlanSugiereGas INTO @ID, @Clase, @SubClase, @Concepto, @CentroCostos, @CantidadBase1, @CantidadBase2, @CantidadBase3, @CantidadBase4, @CantidadBase5, @CantidadBase6, 
           @CantidadBase7, @CantidadBase8, @CantidadBase9, @CantidadBase10, @CantidadBase11, @CantidadBase12, 
           @PrecioBase1, @PrecioBase2, @PrecioBase3, @PrecioBase4, @PrecioBase5, @PrecioBase6, 
           @PrecioBase7, @PrecioBase8, @PrecioBase9, @PrecioBase10, @PrecioBase11, @PrecioBase12,
           @Inc, @Inc2, @Inc3, @Precio, @Inf, @Usar
    WHILE @@FETCH_STATUS = 0
    BEGIN
      SELECT @PrecioNuevo = NULL

      IF @Precio = 'Del Último Mes' SELECT @PrecioNuevo = @PrecioBase12 

      IF @Usar = 'Moderado'  SELECT @IncNuevo = @Inc  ELSE
      IF @Usar = 'Optimista' SELECT @IncNuevo = @Inc2 ELSE
      IF @Usar = 'Pesimista' SELECT @IncNuevo = @Inc3

/*      SELECT @PrecioNuevo1  = ISNULL(@PrecioNuevo, @PrecioBase1)  *(1+((@Inf/100)/12)),
             @PrecioNuevo2  = ISNULL(@PrecioNuevo, @PrecioBase2)  *(1+((@Inf/100)/12)),
             @PrecioNuevo3  = ISNULL(@PrecioNuevo, @PrecioBase3)  *(1+((@Inf/100)/12)),
             @PrecioNuevo4  = ISNULL(@PrecioNuevo, @PrecioBase4)  *(1+((@Inf/100)/12)),
             @PrecioNuevo5  = ISNULL(@PrecioNuevo, @PrecioBase5)  *(1+((@Inf/100)/12)),
             @PrecioNuevo6  = ISNULL(@PrecioNuevo, @PrecioBase6)  *(1+((@Inf/100)/12)),
             @PrecioNuevo7  = ISNULL(@PrecioNuevo, @PrecioBase7)  *(1+((@Inf/100)/12)),
             @PrecioNuevo8  = ISNULL(@PrecioNuevo, @PrecioBase8)  *(1+((@Inf/100)/12)),
             @PrecioNuevo9  = ISNULL(@PrecioNuevo, @PrecioBase9)  *(1+((@Inf/100)/12)),
             @PrecioNuevo10 = ISNULL(@PrecioNuevo, @PrecioBase10) *(1+((@Inf/100)/12)),
             @PrecioNuevo11 = ISNULL(@PrecioNuevo, @PrecioBase11) *(1+((@Inf/100)/12)),
             @PrecioNuevo12 = ISNULL(@PrecioNuevo, @PrecioBase12) *(1+((@Inf/100)/12))
*/

      UPDATE BPlan SET Cantidad1  = @CantidadBase1 *(1+(@IncNuevo/100)), Precio1  = ISNULL(@PrecioNuevo, @PrecioBase1) *(1+(@Inf/100)),
                       Cantidad2  = @CantidadBase2 *(1+(@IncNuevo/100)), Precio2  = ISNULL(@PrecioNuevo, @PrecioBase2) *(1+(@Inf/100)),
                       Cantidad3  = @CantidadBase3 *(1+(@IncNuevo/100)), Precio3  = ISNULL(@PrecioNuevo, @PrecioBase3) *(1+(@Inf/100)),
                       Cantidad4  = @CantidadBase4 *(1+(@IncNuevo/100)), Precio4  = ISNULL(@PrecioNuevo, @PrecioBase4) *(1+(@Inf/100)),
                       Cantidad5  = @CantidadBase5 *(1+(@IncNuevo/100)), Precio5  = ISNULL(@PrecioNuevo, @PrecioBase5) *(1+(@Inf/100)),
                       Cantidad6  = @CantidadBase6 *(1+(@IncNuevo/100)), Precio6  = ISNULL(@PrecioNuevo, @PrecioBase6) *(1+(@Inf/100)),
                       Cantidad7  = @CantidadBase7 *(1+(@IncNuevo/100)), Precio7  = ISNULL(@PrecioNuevo, @PrecioBase7) *(1+(@Inf/100)),
                       Cantidad8  = @CantidadBase8 *(1+(@IncNuevo/100)), Precio8  = ISNULL(@PrecioNuevo, @PrecioBase8) *(1+(@Inf/100)),
                       Cantidad9  = @CantidadBase9 *(1+(@IncNuevo/100)), Precio9  = ISNULL(@PrecioNuevo, @PrecioBase9) *(1+(@Inf/100)),
                       Cantidad10 = @CantidadBase10*(1+(@IncNuevo/100)), Precio10 = ISNULL(@PrecioNuevo, @PrecioBase10)*(1+(@Inf/100)),
                       Cantidad11 = @CantidadBase11*(1+(@IncNuevo/100)), Precio11 = ISNULL(@PrecioNuevo, @PrecioBase11)*(1+(@Inf/100)),
                       Cantidad12 = @CantidadBase12*(1+(@IncNuevo/100)), Precio12 = ISNULL(@PrecioNuevo, @PrecioBase12)*(1+(@Inf/100))
       WHERE CURRENT OF crBPlanSugiereGas

      FETCH NEXT FROM crBPlanSugiereGas INTO @ID, @Clase, @SubClase, @Concepto, @CentroCostos, @CantidadBase1, @CantidadBase2, @CantidadBase3, @CantidadBase4, @CantidadBase5, @CantidadBase6, 
             @CantidadBase7, @CantidadBase8, @CantidadBase9, @CantidadBase10, @CantidadBase11, @CantidadBase12, 
             @PrecioBase1, @PrecioBase2, @PrecioBase3, @PrecioBase4, @PrecioBase5, @PrecioBase6, 
             @PrecioBase7, @PrecioBase8, @PrecioBase9, @PrecioBase10, @PrecioBase11, @PrecioBase12,
             @Inc, @Inc2, @Inc3, @Precio, @Inf, @Usar
    END

    CLOSE crBPlanSugiereGas
    DEALLOCATE crBPlanSugiereGas
  END

  SELECT 'Proceso Concluido'
  RETURN
END
GO

/**************** spBPlanSugiereNom ****************/
if exists (select * from sysobjects where id = object_id('dbo.spBPlanSugiereNom') and type = 'P') drop procedure dbo.spBPlanSugiereNom
GO
CREATE PROCEDURE spBPlanSugiereNom
		@Estacion		int,
		@Empresa		char(5),
		@Modulo			char(10),
		@Usuario		char(10),
		@Moneda			char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Ejercicio		int,

	@Plaza			varchar(20),
	@Personal		char(10),

	@ID			int,
	@UltimoCambio		datetime,
	@PrecioBase1		money,
	@PrecioBase2		money,
	@PrecioBase3		money,
	@PrecioBase4		money,
	@PrecioBase5		money,
	@PrecioBase6		money,
	@PrecioBase7		money,
	@PrecioBase8		money,
	@PrecioBase9		money,
	@PrecioBase10		money,
	@PrecioBase11		money,
	@PrecioBase12		money,
	@Inc			float,
	@Inc2			float,
	@Inc3			float,
--	@Precio			varchar(20),
--	@Inf			float,
	@Usar			varchar(20),
	@Precio1		money,
	@Precio2		money,
	@Precio3		money,
	@Precio4		money,
	@Precio5		money,
	@Precio6		money,
	@Precio7		money,
	@Precio8		money,
	@Precio9		money,
	@Precio10		money,
	@Precio11		money,
	@Precio12		money,

	@Redondeo		money,

        @PrecioNuevo		money,
	@IncNuevo		float

  SELECT @Ejercicio = Ejercicio, 
	 @Inc = ISNULL(Inc,0), @Inc2 = ISNULL(Inc2,0), @Inc3 = ISNULL(Inc3,0), --@Precio = ISNULL(Precio, 'Promedio Periodo'),
	 @Redondeo = ISNULL(Redondeo,0), /*@Inf = ISNULL(Inf,0), */@Usar = NULLIF(RTRIM(Usar),'')
    FROM BPlanAsisteNom
   WHERE Estacion = @Estacion

  IF @Usar is null
  BEGIN
    SELECT 'Se requiere indicar el Método para proyectar el Presupuesto'
    RETURN
  END

  UPDATE BPlan SET Inc = @Inc, Inc2 = @Inc2, Inc3 = @Inc3, /*Precio = @Precio, Inf = @Inf, */Usar = @Usar
   WHERE BPlan.Modulo = @Modulo AND BPlan.Empresa = @Empresa AND BPlan.Ejercicio = @Ejercicio AND BPlan.Moneda = @Moneda

  DECLARE crBPlanSugiereNom CURSOR LOCAL FOR
  SELECT ID, b.Plaza, b.Personal, 
         PrecioBase1, PrecioBase2, PrecioBase3, PrecioBase4, PrecioBase5, PrecioBase6, 
         PrecioBase7, PrecioBase8, PrecioBase9, PrecioBase10, PrecioBase11, PrecioBase12,
         Inc, Inc2, Inc3, Usar
    FROM BPlan b
   WHERE b.Modulo = @Modulo AND b.Empresa = @Empresa AND b.Ejercicio = @Ejercicio AND b.Moneda = @Moneda

  OPEN crBPlanSugiereNom
  FETCH NEXT FROM crBPlanSugiereNom INTO @ID, @Plaza, @Personal,
         @PrecioBase1, @PrecioBase2, @PrecioBase3, @PrecioBase4, @PrecioBase5, @PrecioBase6,
         @PrecioBase7, @PrecioBase8, @PrecioBase9, @PrecioBase10, @PrecioBase11, @PrecioBase12,
         @Inc, @Inc2, @Inc3, @Usar
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @Usar = 'Moderado'  SELECT @IncNuevo = @Inc  ELSE
    IF @Usar = 'Optimista' SELECT @IncNuevo = @Inc2 ELSE
    IF @Usar = 'Pesimista' SELECT @IncNuevo = @Inc3

/*    SELECT @PrecioNuevo = NULL
    IF @Precio = 'Del Último Mes' SELECT @PrecioNuevo = @PrecioBase12 ELSE
    IF @Precio <> 'Promedio Periodo' SELECT @PrecioNuevo = Precio FROM ListaPreciosD WHERE Lista = @Precio AND Moneda = @Moneda AND Articulo = @Articulo

    SELECT @PrecioNuevo1  = ISNULL(@PrecioNuevo, @PrecioBase1)  *(1+((@Inf/100)/12)),
           @PrecioNuevo2  = ISNULL(@PrecioNuevo, @PrecioBase2)  *(1+((@Inf/100)/12)),
           @PrecioNuevo3  = ISNULL(@PrecioNuevo, @PrecioBase3)  *(1+((@Inf/100)/12)),
           @PrecioNuevo4  = ISNULL(@PrecioNuevo, @PrecioBase4)  *(1+((@Inf/100)/12)),
           @PrecioNuevo5  = ISNULL(@PrecioNuevo, @PrecioBase5)  *(1+((@Inf/100)/12)),
           @PrecioNuevo6  = ISNULL(@PrecioNuevo, @PrecioBase6)  *(1+((@Inf/100)/12)),
           @PrecioNuevo7  = ISNULL(@PrecioNuevo, @PrecioBase7)  *(1+((@Inf/100)/12)),
           @PrecioNuevo8  = ISNULL(@PrecioNuevo, @PrecioBase8)  *(1+((@Inf/100)/12)),
           @PrecioNuevo9  = ISNULL(@PrecioNuevo, @PrecioBase9)  *(1+((@Inf/100)/12)),
           @PrecioNuevo10 = ISNULL(@PrecioNuevo, @PrecioBase10) *(1+((@Inf/100)/12)),
           @PrecioNuevo11 = ISNULL(@PrecioNuevo, @PrecioBase11) *(1+((@Inf/100)/12)),
           @PrecioNuevo12 = ISNULL(@PrecioNuevo, @PrecioBase12) *(1+((@Inf/100)/12))
*/

    UPDATE BPlan SET Cantidad1  = 1, Precio1  = ISNULL(@PrecioBase1,0)  *(1+((@IncNuevo/100))),
                     Cantidad2  = 1, Precio2  = ISNULL(@PrecioBase2,0)  *(1+((@IncNuevo/100))),
                     Cantidad3  = 1, Precio3  = ISNULL(@PrecioBase3,0)  *(1+((@IncNuevo/100))),
                     Cantidad4  = 1, Precio4  = ISNULL(@PrecioBase4,0)  *(1+((@IncNuevo/100))),
                     Cantidad5  = 1, Precio5  = ISNULL(@PrecioBase5,0)  *(1+((@IncNuevo/100))),
                     Cantidad6  = 1, Precio6  = ISNULL(@PrecioBase6,0)  *(1+((@IncNuevo/100))),
                     Cantidad7  = 1, Precio7  = ISNULL(@PrecioBase7,0)  *(1+((@IncNuevo/100))),
                     Cantidad8  = 1, Precio8  = ISNULL(@PrecioBase8,0)  *(1+((@IncNuevo/100))),
                     Cantidad9  = 1, Precio9  = ISNULL(@PrecioBase9,0)  *(1+((@IncNuevo/100))),
                     Cantidad10 = 1, Precio10 = ISNULL(@PrecioBase10,0) *(1+((@IncNuevo/100))),
                     Cantidad11 = 1, Precio11 = ISNULL(@PrecioBase11,0) *(1+((@IncNuevo/100))),
                     Cantidad12 = 1, Precio12 = ISNULL(@PrecioBase12,0) *(1+((@IncNuevo/100)))
     WHERE CURRENT OF crBPlanSugiereNom

    FETCH NEXT FROM crBPlanSugiereNom INTO @ID, @Plaza, @Personal, 
           @PrecioBase1, @PrecioBase2, @PrecioBase3, @PrecioBase4, @PrecioBase5, @PrecioBase6, 
           @PrecioBase7, @PrecioBase8, @PrecioBase9, @PrecioBase10, @PrecioBase11, @PrecioBase12,
           @Inc, @Inc2, @Inc3, @Usar
  END

  CLOSE crBPlanSugiereNom
  DEALLOCATE crBPlanSugiereNom

  SELECT 'Proceso Concluido'
  RETURN
END
GO

/**************** spBPlanGenerarPresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spBPlanGenerarPresupuesto') and type = 'P') drop procedure dbo.spBPlanGenerarPresupuesto
GO
CREATE PROCEDURE spBPlanGenerarPresupuesto
		@Empresa		char(5),
		@Modulo			char(10),
		@Ejercicio		int,
		@Usuario		char(10),
		@Moneda			char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Mov				varchar(20),
	@Sucursal			int,
	@UEN				int,
	@TipoCambio			float,
	@Periodo			int,
	@ID				int,
	@FechaEmision			datetime,
	@Fecha				varchar(11),
	@Almacen			char(10),
	@Clase				varchar(50),
	@SubClase			varchar(50),
	@VentaPreciosImpuestoIncluido	bit

  SET DATEFORMAT dmy
  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda

  IF @Modulo = 'VTAS'
  BEGIN
    IF Exists(SELECT * FROM Sucursal WHERE Estatus = 'ALTA' AND NULLIF(RTRIM(AlmacenPrincipal),'') is null)
    BEGIN
      SELECT 'Existen Sucursales que no tienen asignado Almacén por Omisión'
      RETURN
    END

    IF NOT EXISTS(SELECT * FROM Cte WHERE Cliente = 'PRESUP')
      INSERT INTO Cte(Cliente, Nombre, Estatus)
                VALUES('PRESUP', 'Presupuesto', 'ALTA')

    SELECT @Mov = VentaPresupuesto
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa

    DECLARE crBPlanGenerarPresupuesto CURSOR LOCAL FOR
    SELECT DISTINCT Sucursal, UEN
      FROM BPlan
     WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio AND Moneda = @Moneda
     ORDER BY Sucursal, UEN

    OPEN crBPlanGenerarPresupuesto
    FETCH NEXT FROM crBPlanGenerarPresupuesto INTO @Sucursal, @UEN
    WHILE @@FETCH_STATUS = 0
    BEGIN
      SELECT @Almacen = AlmacenPrincipal FROM Sucursal WHERE Sucursal = @Sucursal
      SELECT @Periodo = 1
      WHILE @Periodo <= 12
      BEGIN
        SELECT @Fecha = '1' + '/' + RTRIM(Convert(char(2),@Periodo)) + '/' + Convert(char(4), @Ejercicio)
        SELECT @FechaEmision = Convert(datetime, @Fecha, 103)
        INSERT INTO Venta(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Directo, Cliente, Almacen, Sucursal, UEN)
                    VALUES(@Empresa, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'CONFIRMAR', 1, 'PRESUP', @Almacen, @Sucursal, @UEN)
        SELECT @ID = SCOPE_IDENTITY()

        EXEC spBPlanGenerarPresupuestoD @Empresa, @Modulo, @Ejercicio, @Moneda, @ID, @Periodo, @Sucursal, @UEN

        SELECT @Periodo = @Periodo + 1

        IF NOT Exists(SELECT * FROM VentaD WHERE ID = @ID)
          DELETE Venta WHERE ID = @ID

      END
      FETCH NEXT FROM crBPlanGenerarPresupuesto INTO @Sucursal, @UEN
    END
 
    CLOSE crBPlanGenerarPresupuesto
    DEALLOCATE crBPlanGenerarPresupuesto

  END
  ELSE
  IF @Modulo = 'COMS'
  BEGIN
    IF Exists(SELECT * FROM Sucursal WHERE Estatus = 'ALTA' AND NULLIF(RTRIM(AlmacenPrincipal),'') is null)
    BEGIN
      SELECT 'Existen Sucursales que no tienen asignado Almacén por Omisión'
      RETURN
    END

    IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = 'PRESUP')
      INSERT INTO Prov(Proveedor, Nombre, Estatus)
                VALUES('PRESUP', 'Presupuesto', 'ALTA')

    SELECT @Mov = 'Presupuesto'
--      FROM EmpresaCfgMov
--     WHERE Empresa = @Empresa

    DECLARE crBPlanGenerarPresupuesto CURSOR LOCAL FOR
    SELECT DISTINCT Sucursal, UEN
      FROM BPlan
     WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio AND Moneda = @Moneda
     ORDER BY Sucursal, UEN

    OPEN crBPlanGenerarPresupuesto
    FETCH NEXT FROM crBPlanGenerarPresupuesto INTO @Sucursal, @UEN
    WHILE @@FETCH_STATUS = 0
    BEGIN
      SELECT @Almacen = AlmacenPrincipal FROM Sucursal WHERE Sucursal = @Sucursal
      SELECT @Periodo = 1
      WHILE @Periodo <= 12
      BEGIN
        SELECT @Fecha = '1' + '/' + RTRIM(Convert(char(2),@Periodo)) + '/' + Convert(char(4), @Ejercicio)
        SELECT @FechaEmision = Convert(datetime, @Fecha, 103)
        INSERT INTO Compra(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Directo, Proveedor, Almacen, Sucursal, UEN)
                    VALUES(@Empresa, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'CONFIRMAR', 1, 'PRESUP', @Almacen, @Sucursal, @UEN)
        SELECT @ID = SCOPE_IDENTITY()

        EXEC spBPlanGenerarPresupuestoD @Empresa, @Modulo, @Ejercicio, @Moneda, @ID, @Periodo, @Sucursal, @UEN

        SELECT @Periodo = @Periodo + 1

        IF NOT Exists(SELECT * FROM CompraD WHERE ID = @ID)
          DELETE Compra WHERE ID = @ID

      END
      FETCH NEXT FROM crBPlanGenerarPresupuesto INTO @Sucursal, @UEN
    END
 
    CLOSE crBPlanGenerarPresupuesto
    DEALLOCATE crBPlanGenerarPresupuesto

  END
  ELSE
  IF @Modulo = 'GAS'
  BEGIN
    IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = 'PRESUP')
      INSERT INTO Prov(Proveedor, Nombre, Estatus)
                VALUES('PRESUP', 'Presupuesto', 'ALTA')

    SELECT @Mov = GastoPresupuesto
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa

    DECLARE crBPlanGenerarPresupuesto CURSOR LOCAL FOR
    SELECT DISTINCT Sucursal, UEN, Clase, SubClase
      FROM BPlan
     WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio AND Moneda = @Moneda
     ORDER BY Sucursal, UEN, Clase, SubClase

    OPEN crBPlanGenerarPresupuesto
    FETCH NEXT FROM crBPlanGenerarPresupuesto INTO @Sucursal, @UEN, @Clase, @SubClase
    WHILE @@FETCH_STATUS = 0
    BEGIN
      SELECT @Periodo = 1
      WHILE @Periodo <= 12
      BEGIN
        SELECT @Fecha = '1' + '/' + RTRIM(Convert(char(2),@Periodo)) + '/' + Convert(char(4), @Ejercicio)
        SELECT @FechaEmision = Convert(datetime, @Fecha, 103)

	INSERT INTO Gasto(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Acreedor, Clase, SubClase, Sucursal, UEN)
		VALUES(@Empresa, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'CONFIRMAR', 'PRESUP', @Clase, @SubClase, @Sucursal, @UEN)

        SELECT @ID = SCOPE_IDENTITY()

        EXEC spBPlanGenerarPresupuestoD @Empresa, @Modulo, @Ejercicio, @Moneda, @ID, @Periodo, @Sucursal, @UEN

        SELECT @Periodo = @Periodo + 1

        IF NOT Exists(SELECT * FROM GastoD WHERE ID = @ID)
          DELETE Gasto WHERE ID = @ID

      END
      FETCH NEXT FROM crBPlanGenerarPresupuesto INTO @Sucursal, @UEN, @Clase, @SubClase
    END
 
    CLOSE crBPlanGenerarPresupuesto
    DEALLOCATE crBPlanGenerarPresupuesto

  END
  ELSE
  IF @Modulo = 'NOM'
  BEGIN

    IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'NOM' AND Mov = 'Presupuesto')
      INSERT INTO MovTipo(Modulo, Mov, Clave, ConsecutivoModulo, ConsecutivoMov, Factor)
		VALUES('NOM', 'Presupuesto', 'NOM.PR', 'NOM', 'Presupuesto', 1)

    SELECT @Mov = 'Presupuesto'
--      FROM EmpresaCfgMov
--     WHERE Empresa = @Empresa

    DECLARE crBPlanGenerarPresupuesto CURSOR LOCAL FOR
    SELECT DISTINCT Sucursal, UEN
      FROM BPlan
     WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio AND Moneda = @Moneda
     ORDER BY Sucursal, UEN

    OPEN crBPlanGenerarPresupuesto
    FETCH NEXT FROM crBPlanGenerarPresupuesto INTO @Sucursal, @UEN
    WHILE @@FETCH_STATUS = 0
    BEGIN
      SELECT @Periodo = 1
      WHILE @Periodo <= 12
      BEGIN
        SELECT @Fecha = '1' + '/' + RTRIM(Convert(char(2),@Periodo)) + '/' + Convert(char(4), @Ejercicio)
        SELECT @FechaEmision = Convert(datetime, @Fecha, 103)
        INSERT INTO Nomina(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Sucursal, UEN)
                    VALUES(@Empresa, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'CONFIRMAR', @Sucursal, @UEN)
        SELECT @ID = SCOPE_IDENTITY()

        EXEC spBPlanGenerarPresupuestoD @Empresa, @Modulo, @Ejercicio, @Moneda, @ID, @Periodo, @Sucursal, @UEN

        SELECT @Periodo = @Periodo + 1

        IF NOT Exists(SELECT * FROM NominaD WHERE ID = @ID)
          DELETE Nomina WHERE ID = @ID

      END
      FETCH NEXT FROM crBPlanGenerarPresupuesto INTO @Sucursal, @UEN
    END
 
    CLOSE crBPlanGenerarPresupuesto
    DEALLOCATE crBPlanGenerarPresupuesto

  END

  SELECT 'Proceso Concluido'

  RETURN
END
GO

/**************** spBPlanGenerarPresupuestoD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spBPlanGenerarPresupuestoD') and type = 'P') drop procedure dbo.spBPlanGenerarPresupuestoD
GO
CREATE PROCEDURE spBPlanGenerarPresupuestoD
		@Empresa		char(5),
		@Modulo			char(10),
		@Ejercicio		int,
		@Moneda			char(10),
		@ID			int,
		@Periodo		int,
		@Sucursal		int,
		@UEN			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Renglon		float,
	@Articulo		char(20),
	@Almacen		char(10),
	@Clase			varchar(50),
	@SubClase		varchar(50),
	@Plaza			varchar(20),
	@Personal		char(10),
	@Concepto		varchar(50),
	@CentroCostos		varchar(20),
	@Unidad			char(50),
	@Impuesto1		float,
	@Cantidad		float,
	@CantidadInventario	float,
	@Precio			money,
	@Cantidad1		float,
	@Cantidad2		float,
	@Cantidad3		float,
	@Cantidad4		float,
	@Cantidad5		float,
	@Cantidad6		float,
	@Cantidad7		float,
	@Cantidad8		float,
	@Cantidad9		float,
	@Cantidad10		float,
	@Cantidad11		float,
	@Cantidad12		float,
	@Precio1		money,
	@Precio2		money,
	@Precio3		money,
	@Precio4		money,
	@Precio5		money,
	@Precio6		money,
	@Precio7		money,
	@Precio8		money,
	@Precio9		money,
	@Precio10		money,
	@Precio11		money,
	@Precio12		money,

	@CfgMultiUnidades	bit,
	@CfgMultiUnidadesNivel	char(20)

  SELECT @CfgMultiUnidades = MultiUnidades, @CfgMultiUnidadesNivel = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2 WHERE Empresa = @Empresa

  SELECT @Renglon = 2048

  IF @Modulo in ('VTAS', 'COMS')
  BEGIN
    DECLARE crBPlanGenerarPresupuestoD CURSOR LOCAL FOR
    SELECT Articulo, Cantidad1, Cantidad2, Cantidad3, Cantidad4, Cantidad5, Cantidad6, Cantidad7, Cantidad8, Cantidad9, Cantidad10, Cantidad11, Cantidad12, 
           Precio1, Precio2, Precio3, Precio4, Precio5, Precio6, Precio7, Precio8, Precio9, Precio10, Precio11, Precio12
      FROM BPlan
     WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio AND Moneda = @Moneda
       AND Sucursal = @Sucursal AND UEN = @UEN

    OPEN crBPlanGenerarPresupuestoD
    FETCH NEXT FROM crBPlanGenerarPresupuestoD INTO @Articulo, @Cantidad1, @Cantidad2, @Cantidad3, @Cantidad4, @Cantidad5, @Cantidad6, @Cantidad7, @Cantidad8, @Cantidad9, @Cantidad10, @Cantidad11, @Cantidad12, 
           @Precio1, @Precio2, @Precio3, @Precio4, @Precio5, @Precio6, @Precio7, @Precio8, @Precio9, @Precio10, @Precio11, @Precio12
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @Periodo = 1  SELECT @Cantidad = @Cantidad1,  @Precio = @Precio1  ELSE
        IF @Periodo = 2  SELECT @Cantidad = @Cantidad2,  @Precio = @Precio2  ELSE
        IF @Periodo = 3  SELECT @Cantidad = @Cantidad3,  @Precio = @Precio3  ELSE
        IF @Periodo = 4  SELECT @Cantidad = @Cantidad4,  @Precio = @Precio4  ELSE
        IF @Periodo = 5  SELECT @Cantidad = @Cantidad5,  @Precio = @Precio5  ELSE
        IF @Periodo = 6  SELECT @Cantidad = @Cantidad6,  @Precio = @Precio6  ELSE
        IF @Periodo = 7  SELECT @Cantidad = @Cantidad7,  @Precio = @Precio7  ELSE
        IF @Periodo = 8  SELECT @Cantidad = @Cantidad8,  @Precio = @Precio8  ELSE
        IF @Periodo = 9  SELECT @Cantidad = @Cantidad9,  @Precio = @Precio9  ELSE
        IF @Periodo = 10 SELECT @Cantidad = @Cantidad10, @Precio = @Precio10 ELSE
        IF @Periodo = 11 SELECT @Cantidad = @Cantidad11, @Precio = @Precio11 ELSE
        IF @Periodo = 12 SELECT @Cantidad = @Cantidad12, @Precio = @Precio12

        IF @Modulo = 'VTAS' SELECT @Unidad = Unidad, @Impuesto1 = Impuesto1 FROM Art WHERE Articulo = @Articulo ELSE
        IF @Modulo = 'COMS' SELECT @Unidad = UnidadCompra, @Impuesto1 = Impuesto1 FROM Art WHERE Articulo = @Articulo
        
        EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

        SELECT @Almacen = Almacen FROM Venta WHERE ID = @ID

        IF ISNULL(@Cantidad,0) <> 0
        BEGIN
          IF @Modulo = 'VTAS'
          INSERT INTO VentaD(ID, Renglon, RenglonSub, RenglonTipo, Cantidad, CantidadInventario, Almacen, Articulo, Unidad, Factor, Impuesto1, Precio)
  		    VALUES(@ID, @Renglon, 0, 'N', @Cantidad, @CantidadInventario, @Almacen, @Articulo, @Unidad, 1, @Impuesto1, @Precio)
          ELSE
          IF @Modulo = 'COMS'
          INSERT INTO CompraD(ID, Renglon, RenglonSub, RenglonTipo, Cantidad, CantidadInventario, Almacen, Articulo, Unidad, Factor, Impuesto1, Costo)
  		    VALUES(@ID, @Renglon, 0, 'N', @Cantidad, @CantidadInventario, @Almacen, @Articulo, @Unidad, 1, @Impuesto1, @Precio)

        END

        SELECT @Renglon = @Renglon + 2048

        FETCH NEXT FROM crBPlanGenerarPresupuestoD INTO @Articulo, @Cantidad1, @Cantidad2, @Cantidad3, @Cantidad4, @Cantidad5, @Cantidad6, @Cantidad7, @Cantidad8, @Cantidad9, @Cantidad10, @Cantidad11, @Cantidad12, 
           @Precio1, @Precio2, @Precio3, @Precio4, @Precio5, @Precio6, @Precio7, @Precio8, @Precio9, @Precio10, @Precio11, @Precio12
    END

    CLOSE crBPlanGenerarPresupuestoD
    DEALLOCATE crBPlanGenerarPresupuestoD

  END
  ELSE
  IF @Modulo = 'GAS'
  BEGIN
    SELECT @Clase = Clase, @SubClase = SubClase FROM Gasto WHERE ID = @ID

    DECLARE crBPlanGenerarPresupuestoD CURSOR LOCAL FOR
    SELECT Concepto, CentroCostos, Cantidad1, Cantidad2, Cantidad3, Cantidad4, Cantidad5, Cantidad6, Cantidad7, Cantidad8, Cantidad9, Cantidad10, Cantidad11, Cantidad12, 
           Precio1, Precio2, Precio3, Precio4, Precio5, Precio6, Precio7, Precio8, Precio9, Precio10, Precio11, Precio12
      FROM BPlan
     WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio AND Moneda = @Moneda
       AND Sucursal = @Sucursal AND UEN = @UEN
       AND Clase = @Clase AND SubClase = @SubClase

    OPEN crBPlanGenerarPresupuestoD
    FETCH NEXT FROM crBPlanGenerarPresupuestoD INTO @Concepto, @CentroCostos, @Cantidad1, @Cantidad2, @Cantidad3, @Cantidad4, @Cantidad5, @Cantidad6, @Cantidad7, @Cantidad8, @Cantidad9, @Cantidad10, @Cantidad11, @Cantidad12, 
           @Precio1, @Precio2, @Precio3, @Precio4, @Precio5, @Precio6, @Precio7, @Precio8, @Precio9, @Precio10, @Precio11, @Precio12
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @Periodo = 1  SELECT @Cantidad = @Cantidad1,  @Precio = @Precio1  ELSE
        IF @Periodo = 2  SELECT @Cantidad = @Cantidad2,  @Precio = @Precio2  ELSE
        IF @Periodo = 3  SELECT @Cantidad = @Cantidad3,  @Precio = @Precio3  ELSE
        IF @Periodo = 4  SELECT @Cantidad = @Cantidad4,  @Precio = @Precio4  ELSE
        IF @Periodo = 5  SELECT @Cantidad = @Cantidad5,  @Precio = @Precio5  ELSE
        IF @Periodo = 6  SELECT @Cantidad = @Cantidad6,  @Precio = @Precio6  ELSE
        IF @Periodo = 7  SELECT @Cantidad = @Cantidad7,  @Precio = @Precio7  ELSE
        IF @Periodo = 8  SELECT @Cantidad = @Cantidad8,  @Precio = @Precio8  ELSE
        IF @Periodo = 9  SELECT @Cantidad = @Cantidad9,  @Precio = @Precio9  ELSE
        IF @Periodo = 10 SELECT @Cantidad = @Cantidad10, @Precio = @Precio10 ELSE
        IF @Periodo = 11 SELECT @Cantidad = @Cantidad11, @Precio = @Precio11 ELSE
        IF @Periodo = 12 SELECT @Cantidad = @Cantidad12, @Precio = @Precio12

        SELECT @Impuesto1 = Impuestos FROM Concepto WHERE Concepto = @Concepto

        IF ISNULL(@Cantidad,0) <> 0
          INSERT INTO GastoD(ID, Renglon, Concepto, ContUso, Cantidad, Precio, Importe, Impuestos)
                      VALUES(@ID, @Renglon, @Concepto, @CentroCostos, @Cantidad, @Precio, @Precio*@Cantidad, (@Precio*@Cantidad)*(@Impuesto1/100))

        SELECT @Renglon = @Renglon + 2048

        FETCH NEXT FROM crBPlanGenerarPresupuestoD INTO @Concepto, @CentroCostos, @Cantidad1, @Cantidad2, @Cantidad3, @Cantidad4, @Cantidad5, @Cantidad6, @Cantidad7, @Cantidad8, @Cantidad9, @Cantidad10, @Cantidad11, @Cantidad12, 
           @Precio1, @Precio2, @Precio3, @Precio4, @Precio5, @Precio6, @Precio7, @Precio8, @Precio9, @Precio10, @Precio11, @Precio12
    END

    CLOSE crBPlanGenerarPresupuestoD
    DEALLOCATE crBPlanGenerarPresupuestoD
  END
  ELSE
  IF @Modulo = 'NOM'
  BEGIN
    DECLARE crBPlanGenerarPresupuestoD CURSOR LOCAL FOR
    SELECT Plaza, Personal, Concepto, 
           Precio1, Precio2, Precio3, Precio4, Precio5, Precio6, Precio7, Precio8, Precio9, Precio10, Precio11, Precio12
      FROM BPlan
     WHERE Modulo = @Modulo AND Empresa = @Empresa AND Ejercicio = @Ejercicio AND Moneda = @Moneda
       AND Sucursal = @Sucursal AND UEN = @UEN

    OPEN crBPlanGenerarPresupuestoD
    FETCH NEXT FROM crBPlanGenerarPresupuestoD INTO @Plaza, @Personal, @Concepto, @Precio1, @Precio2, @Precio3, @Precio4, @Precio5, @Precio6, @Precio7, @Precio8, @Precio9, @Precio10, @Precio11, @Precio12
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @Periodo = 1  SELECT @Precio = @Precio1  ELSE
        IF @Periodo = 2  SELECT @Precio = @Precio2  ELSE
        IF @Periodo = 3  SELECT @Precio = @Precio3  ELSE
        IF @Periodo = 4  SELECT @Precio = @Precio4  ELSE
        IF @Periodo = 5  SELECT @Precio = @Precio5  ELSE
        IF @Periodo = 6  SELECT @Precio = @Precio6  ELSE
        IF @Periodo = 7  SELECT @Precio = @Precio7  ELSE
        IF @Periodo = 8  SELECT @Precio = @Precio8  ELSE
        IF @Periodo = 9  SELECT @Precio = @Precio9  ELSE
        IF @Periodo = 10 SELECT @Precio = @Precio10 ELSE
        IF @Periodo = 11 SELECT @Precio = @Precio11 ELSE
        IF @Periodo = 12 SELECT @Precio = @Precio12

        IF ISNULL(@Precio,0) <> 0
        BEGIN
          INSERT INTO NominaD(ID, Renglon, Plaza, Personal, Concepto, Importe)
  		    VALUES(@ID, @Renglon, @Plaza, @Personal, @Concepto, @Precio)

        END

        SELECT @Renglon = @Renglon + 2048

        FETCH NEXT FROM crBPlanGenerarPresupuestoD INTO @Plaza, @Personal, @Concepto, @Precio1, @Precio2, @Precio3, @Precio4, @Precio5, @Precio6, @Precio7, @Precio8, @Precio9, @Precio10, @Precio11, @Precio12
    END

    CLOSE crBPlanGenerarPresupuestoD
    DEALLOCATE crBPlanGenerarPresupuestoD

  END

  RETURN
END
GO

/********************* ExplorarBPlanGasto ***************/
if exists (select * from sysobjects where id = object_id('dbo.ExplorarBPlanGasto') and type = 'v') drop view dbo.ExplorarBPlanGasto
GO
CREATE VIEW dbo.ExplorarBPlanGasto
AS
SELECT 
  'Rama' = 'Clasificacion',
  'Concepto' = Clase,
  'PrecioBase1' = ISNULL((SELECT SUM(PrecioBase2) FROM BPlan WHERE Concepto.Clase = BPlan.Clase AND BPlan.Modulo = 'GAS' AND Concepto.Clase IS NOT NULL), 0)
FROM
  Concepto
GROUP BY Clase
UNION ALL
SELECT 
  'Rama' = Clase,
  'Concepto' = SubClase,
  'PrecioBase1' = ISNULL((SELECT SUM(PrecioBase2) FROM BPlan WHERE Concepto.SubClase = BPlan.SubClase AND BPlan.Modulo = 'GAS' AND Concepto.SubClase IS NOT NULL), 0)
FROM
  Concepto
UNION ALL
SELECT 
  'Rama' = BPlan.Clase,
  'Concepto' = BPlan.Concepto,
  'PrecioBase1' = BPlan.PrecioBase2
FROM
  BPlan
WHERE 
  Modulo = 'GAS'
GO

-- SELECT * FROM ExplorarBPlanGasto
