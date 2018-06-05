/* mis_spVentaParticProdCat */
if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaParticProdCat') and type = 'P') drop procedure dbo.mis_spVentaParticProdCat
GO
CREATE PROCEDURE mis_spVentaParticProdCat
		 @Fecha		DateTime,
                 @ArticuloD	char(20),
                 @ArticuloA	char(20),
                 @Categoria	varchar(50),
                 @Empresa	char(5)
		    
--//WITH ENCRYPTION
AS BEGIN
  DECLARE

    @Ejercicio		int,
    @EjercicioAnt	int,
    @FechaAnt		datetime,
    @DiaAct		int,
    @DiaAnt		int,
    @MesAct		int,
    @MesAnt		int,
    @AnoAct		int,
    @AnoAnt		int




  SELECT @Ejercicio = YEAR(@Fecha)
  SELECT @FechaAnt = @Fecha - 365 
  SELECT @EjercicioAnt = @Ejercicio - 1
  SELECT @DiaAct = DAY(@Fecha)
  SELECT @DiaAnt = DAY(@FechaAnt)
  SELECT @MesAct = MONTH(@Fecha)
  SELECT @MesAnt = MONTH(@FechaAnt)
  SELECT @AnoAct = YEAR(@Fecha)
  SELECT @AnoAnt = YEAR(@FechaAnt)


  CREATE TABLE #ParticipaCat
 (
     Categoriax		char(50)	COLLATE Database_Default NULL,
     Articulox		varchar(20)	COLLATE Database_Default NULL,
     SubCuentax		char(10)	COLLATE Database_Default NULL,
     Cantid1		float(8)	NULL,
     Import1		money		NULL,
     SumaCan1		float(8)	NULL,
     Cantid2		float(8)	NULL,
     Import2		money		NULL,
     Costo2		money		NULL,
     Util2		money		NULL,
     SumaCan2		float(8)	NULL,
     SumaUtil2		money		NULL,
     Cantid3		float(8)	NULL,
     Import3		money		NULL,
     SumaCan3		float(8)	NULL,
     Cantid4		float(8)	NULL,
     Import4		money		NULL,
     SumaCan4		float(8)	NULL,
     SumaTot1		float(8)	NULL,
     SumaTot2		float(8)  	NULL,
     SumaTot3		float(8)  	NULL,
     SumaTot4           float(8)	NULL
)

  -- Articulos del Ejercicio Actual y Anterior
  SELECT Articulo, SubCuenta,
         Categoria
    INTO #Arti
    FROM mis_VentaUtilX
   WHERE mis_VentaUtilX.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ((mis_VentaUtilX.Ejercicio = @EjercicioAnt
     AND mis_VentaUtilX.FechaEmision <= @FechaAnt) 
     OR (mis_VentaUtilX.Ejercicio = @Ejercicio
     AND mis_VentaUtilX.FechaEmision <= @Fecha))
     AND ISNULL(Categoria, '')  = CASE @Categoria  WHEN 'NULL' THEN ISNULL(Categoria, '')  ELSE @Categoria  END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria, Articulo, Subcuenta
   ORDER BY Categoria, Articulo, Subcuenta
         
  -- Articulos con valores año actual, mes actual
  SELECT Articulo, Subcuenta, Categoria,
	 'Cantid1' = SUM(CantidadFactor),
         'Import1' = SUM(ImporteX)
   INTO #AAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '')  = CASE @Categoria  WHEN 'NULL' THEN ISNULL(Categoria, '')  ELSE @Categoria  END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Articulo, Subcuenta, Categoria
   ORDER BY Articulo, Subcuenta, Categoria

  SELECT Categoria, Articulo, 
         'SumaCan1' = SUM(CantidadFactor)
   INTO #BAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(Categoria, '') ELSE @Categoria END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria, Articulo
   ORDER BY Categoria, Articulo

  SELECT Categoria,
         'SumaTot1' = SUM(CantidadFactor)
   INTO #ZAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(Categoria, '') ELSE @Categoria END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria
   ORDER BY Categoria

  SELECT a.Categoria, a.Articulo, a.Subcuenta, a.Cantid1, a.Import1, b.SumaCan1, c.SumaTot1
    INTO #CAct
    FROM #AAct a
    LEFT OUTER JOIN #BAct b ON a.Articulo = b.Articulo AND ISNULL(a.Categoria, '') = ISNULL(b.Categoria, '')
    LEFT OUTER JOIN #ZAct c ON ISNULL(a.Categoria, '') = ISNULL(c.Categoria, '')

  -- Articulos con valores año actual, mes acumulado
  SELECT Categoria,
         Articulo, Subcuenta,
	 'Cantid2' = SUM(CantidadFactor),
         'Import2' = SUM(ImporteX),
         'Costo2'  = SUM(CostoTotal),
         'Util2'   = SUM(ImporteX - CostoTotal)
    INTO #AActAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(Categoria, '') ELSE @Categoria END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria, Articulo, Subcuenta
   ORDER BY Categoria, Articulo, Subcuenta

  SELECT Categoria, Articulo,
         'SumaCan2'  = SUM(CantidadFactor),
         'SumaUtil2' = SUM(ImporteX - CostoTotal)
   INTO #BActAcum
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(Categoria, '') ELSE @Categoria END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria, Articulo
   ORDER BY Categoria, Articulo

  SELECT Categoria,
         'SumaTot2' = SUM(CantidadFactor)
   INTO #ZActAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(Categoria, '') ELSE @Categoria END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria
   ORDER BY Categoria

  SELECT a.Categoria, a.Articulo, a.Subcuenta, Cantid2, Import2, Costo2, Util2, SumaCan2, SumaUtil2, SumaTot2
    INTO #CActAcum
    FROM #AActAcum a
    LEFT OUTER JOIN #BActAcum b ON a.Articulo = b.Articulo AND ISNULL(a.Categoria, '') = ISNULL(b.Categoria, '')
    LEFT OUTER JOIN #ZActAcum c ON ISNULL(a.Categoria, '') = ISNULL(c.Categoria, '')

  -- Articulos con valores año anterior, mes actual
  SELECT Categoria,
         Articulo, Subcuenta, 
	 'Cantid3' = SUM(CantidadFactor),
         'Import3' = SUM(ImporteX)
    INTO #AAnt
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(Categoria, '') ELSE @Categoria END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria, Articulo, Subcuenta
   ORDER BY Categoria, Articulo, Subcuenta

  SELECT Categoria, Articulo, 
         'SumaCan3' = SUM(CantidadFactor)
    INTO #BAnt
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(Categoria, '') ELSE @Categoria END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria, Articulo
   ORDER BY Categoria, Articulo

  SELECT Categoria,
         'SumaTot3' = SUM(CantidadFactor)
   INTO #ZAnt
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(Categoria, '') ELSE @Categoria END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria
   ORDER BY Categoria

  SELECT a.Categoria, a.Articulo, a.Subcuenta, Cantid3, Import3, SumaCan3, SumaTot3
    INTO #CAnt
    FROM #AAnt a
    LEFT OUTER JOIN #BAnt b ON a.Articulo = b.Articulo AND ISNULL(a.Categoria, '') = ISNULL(b.Categoria, '')
    LEFT OUTER JOIN #ZAnt c ON ISNULL(a.Categoria, '') = ISNULL(c.Categoria, '')

  -- Articulos con valores año anterior, mes acumulado
  SELECT Categoria,
         Articulo, Subcuenta, 
	 'Cantid4' = Sum(CantidadFactor),
         'Import4' = SUM(ImporteX)
    INTO #AAntAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(Categoria, '') ELSE @Categoria END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria, Articulo, Subcuenta
   ORDER BY Categoria, Articulo, Subcuenta

  SELECT Categoria, Articulo, 
         'SumaCan4' = SUM(CantidadFactor)
    INTO #BAntAcum
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(Categoria, '') ELSE @Categoria END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria, Articulo
   ORDER BY Categoria, Articulo

  SELECT Categoria,
         'SumaTot4' = SUM(CantidadFactor)
   INTO #ZAntAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(Categoria, '') ELSE @Categoria END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Categoria
   ORDER BY Categoria

  SELECT a.Categoria, a.Articulo, a.Subcuenta, Cantid4, Import4, SumaCan4, SumaTot4
    INTO #CAntAcum
    FROM #AAntAcum a
    LEFT OUTER JOIN #BAntAcum b ON a.Articulo = b.Articulo AND ISNULL(a.Categoria, '') = ISNULL(b.Categoria, '')
    LEFT OUTER JOIN #ZAntAcum c ON ISNULL(a.Categoria, '') = ISNULL(c.Categoria, '')

  INSERT #ParticipaCat
  SELECT Categoria, Articulo, Subcuenta, NULL, NULL, NULL, 
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
         NULL, NULL, NULL
    FROM #Arti

  UPDATE #ParticipaCat
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaCat x 
    LEFT OUTER JOIN #CAct a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '')  
     AND x.Articulox = a.Articulo   
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaCat
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaCat x
    -- LEFT OUTER JOIN #CAct a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '') Bug 23314
    RIGHT OUTER JOIN #CAct a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '') 
     AND x.Articulox = a.Articulo
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaCat
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaCat x
    LEFT OUTER JOIN #CActAcum a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '') 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaCat
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaCat x
    -- LEFT OUTER JOIN #CActAcum a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '') Bug 23314
    RIGHT OUTER JOIN #CActAcum a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '')
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaCat
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaCat x
    LEFT OUTER JOIN #CAnt a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '') 
     AND x.Articulox = a.Articulo 
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaCat
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaCat x
    -- LEFT OUTER JOIN #CAnt a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '') Bug 23314
    RIGHT OUTER JOIN #CAnt a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '')
     AND x.Articulox = a.Articulo 
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaCat
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaCat x
    LEFT OUTER JOIN #CAntAcum a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '') 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaCat
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaCat x
    -- LEFT OUTER JOIN #CAntAcum a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '') Bug 23314
    RIGHT OUTER JOIN #CAntAcum a ON ISNULL(x.Categoriax, '') = ISNULL(a.Categoria, '') 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

--Despliega Información

    SELECT * FROM #ParticipaCat
    ORDER BY Categoriax, Articulox, SubCuentax

END
GO



/* mis_spVentaParticProdFabric */
if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaParticProdFabric') and type = 'P') drop procedure dbo.mis_spVentaParticProdFabric
GO
CREATE PROCEDURE mis_spVentaParticProdFabric
		 @Fecha		DateTime,
                 @ArticuloD	char(20),
                 @ArticuloA	char(20),
                 @Fabricante	varchar(50),
                 @Empresa	char(5)
		    
--//WITH ENCRYPTION
AS BEGIN
  DECLARE

    @Ejercicio		int,
    @EjercicioAnt	int,
    @FechaAnt		datetime,
    @DiaAct		int,
    @DiaAnt		int,
    @MesAct		int,
    @MesAnt		int,
    @AnoAct		int,
    @AnoAnt		int




  SELECT @Ejercicio = YEAR(@Fecha)
  SELECT @FechaAnt = @Fecha - 365 
  SELECT @EjercicioAnt = @Ejercicio - 1
  SELECT @DiaAct = DAY(@Fecha)
  SELECT @DiaAnt = DAY(@FechaAnt)
  SELECT @MesAct = MONTH(@Fecha)
  SELECT @MesAnt = MONTH(@FechaAnt)
  SELECT @AnoAct = YEAR(@Fecha)
  SELECT @AnoAnt = YEAR(@FechaAnt)

  CREATE TABLE #ParticipaFabric
 (
     Fabricantex	char(50)	COLLATE Database_Default NULL,
     Articulox		varchar(20)	COLLATE Database_Default NULL,
     SubCuentax		char(10)	COLLATE Database_Default NULL,
     Cantid1		float(8)	NULL,
     Import1		money		NULL,
     SumaCan1		float(8)	NULL,
     Cantid2		float(8)	NULL,
     Import2		money		NULL,
     Costo2		money		NULL,
     Util2		money		NULL,
     SumaCan2		float(8)	NULL,
     SumaUtil2		money		NULL,
     Cantid3		float(8)	NULL,
     Import3		money		NULL,
     SumaCan3		float(8)	NULL,
     Cantid4		float(8)	NULL,
     Import4		money		NULL,
     SumaCan4		float(8)	NULL,
     SumaTot1		float(8)	NULL,
     SumaTot2		float(8)  	NULL,
     SumaTot3		float(8)  	NULL,
     SumaTot4           float(8)	NULL
)


  -- Articulos del Ejercicio Actual y Anterior
  SELECT Articulo, SubCuenta,
         Fabricante
    INTO #Arti
    FROM mis_VentaUtilX
   WHERE mis_VentaUtilX.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ((mis_VentaUtilX.Ejercicio = @EjercicioAnt
     AND mis_VentaUtilX.FechaEmision <= @FechaAnt) 
     OR (mis_VentaUtilX.Ejercicio = @Ejercicio
     AND mis_VentaUtilX.FechaEmision <= @Fecha))
     AND ISNULL(Fabricante, '')  = CASE @Fabricante  WHEN 'NULL' THEN ISNULL(Fabricante, '')  ELSE @Fabricante  END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante, Articulo, SubCuenta
   ORDER BY Fabricante, Articulo, SubCuenta
         

  -- Articulos con valores año actual, mes actual
  SELECT Articulo, Fabricante, SubCuenta,
	 'Cantid1' = SUM(CantidadFactor),
         'Import1' = SUM(ImporteX)
   INTO #AAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '')  = CASE @Fabricante  WHEN 'NULL' THEN ISNULL(Fabricante, '')  ELSE @Fabricante  END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Articulo, Fabricante, SubCuenta
   ORDER BY Articulo, Fabricante, SubCuenta


  SELECT Fabricante, Articulo, 
         'SumaCan1' = SUM(CantidadFactor)
   INTO #BAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Fabricante, '') ELSE @Fabricante END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante, Articulo
   ORDER BY Fabricante, Articulo


  SELECT Fabricante,
         'SumaTot1' = SUM(CantidadFactor)
   INTO #ZAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Fabricante, '') ELSE @Fabricante END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante
   ORDER BY Fabricante

  SELECT a.Fabricante, a.Articulo, a.SubCuenta, a.Cantid1, a.Import1, b.SumaCan1, c.SumaTot1
    INTO #CAct
    FROM #AAct a
    LEFT OUTER JOIN #BAct b ON a.Articulo = b.Articulo AND ISNULL(a.Fabricante, '') = ISNULL(b.Fabricante, '')
    LEFT OUTER JOIN #ZAct c ON ISNULL(a.Fabricante, '') = ISNULL(c.Fabricante, '')

  -- Articulos con valores año actual, mes acumulado
  SELECT Fabricante,
         Articulo, SubCuenta,
	 'Cantid2' = SUM(CantidadFactor),
         'Import2' = SUM(ImporteX),
         'Costo2'  = SUM(CostoTotal),
         'Util2'   = SUM(ImporteX - CostoTotal)
    INTO #AActAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Fabricante, '') ELSE @Fabricante END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante, Articulo, SubCuenta
   ORDER BY Fabricante, Articulo, SubCuenta


  SELECT Fabricante, Articulo, 
         'SumaCan2'  = SUM(CantidadFactor),
         'SumaUtil2' = SUM(ImporteX - CostoTotal)
   INTO #BActAcum
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Fabricante, '') ELSE @Fabricante END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante, Articulo
   ORDER BY Fabricante, Articulo


  SELECT Fabricante,
         'SumaTot2' = SUM(CantidadFactor)
   INTO #ZActAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Fabricante, '') ELSE @Fabricante END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante
   ORDER BY Fabricante


  SELECT a.Fabricante, a.Articulo, a.SubCuenta, Cantid2, Import2, Costo2, Util2, SumaCan2, SumaUtil2, SumaTot2
    INTO #CActAcum
    FROM #AActAcum a
    LEFT OUTER JOIN #BActAcum b ON a.Articulo = b.Articulo AND ISNULL(a.Fabricante, '') = ISNULL(b.Fabricante, '')
    LEFT OUTER JOIN #ZActAcum c ON ISNULL(a.Fabricante, '') = ISNULL(c.Fabricante, '')

  -- Articulos con valores año anterior, mes actual
  SELECT Fabricante,
         Articulo, SubCuenta,
	 'Cantid3' = SUM(CantidadFactor),
         'Import3' = SUM(ImporteX)
    INTO #AAnt
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Fabricante, '') ELSE @Fabricante END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante, Articulo, SubCuenta
   ORDER BY Fabricante, Articulo, SubCuenta


  SELECT Fabricante, Articulo,
         'SumaCan3' = SUM(CantidadFactor)
    INTO #BAnt
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Fabricante, '') ELSE @Fabricante END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante, Articulo
   ORDER BY Fabricante, Articulo


  SELECT Fabricante,
         'SumaTot3' = SUM(CantidadFactor)
   INTO #ZAnt
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Fabricante, '') ELSE @Fabricante END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante
   ORDER BY Fabricante


  SELECT a.Fabricante, a.Articulo, a.SubCuenta, Cantid3, Import3, SumaCan3, SumaTot3
    INTO #CAnt
    FROM #AAnt a
    LEFT OUTER JOIN #BAnt b ON a.Articulo = b.Articulo AND ISNULL(a.Fabricante, '') = ISNULL(b.Fabricante, '')
    LEFT OUTER JOIN #ZAnt c ON ISNULL(a.Fabricante, '') = ISNULL(c.Fabricante, '')


  -- Articulos con valores año anterior, mes acumulado
  SELECT Fabricante,
         Articulo, SubCuenta,
	 'Cantid4' = Sum(CantidadFactor),
         'Import4' = SUM(ImporteX)
    INTO #AAntAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Fabricante, '') ELSE @Fabricante END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante, Articulo, SubCuenta
   ORDER BY Fabricante, Articulo, SubCuenta


  SELECT Fabricante, Articulo,
         'SumaCan4' = SUM(CantidadFactor)
    INTO #BAntAcum
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Fabricante, '') ELSE @Fabricante END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante, Articulo
   ORDER BY Fabricante, Articulo


  SELECT Fabricante,
         'SumaTot4' = SUM(CantidadFactor)
   INTO #ZAntAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Fabricante, '') ELSE @Fabricante END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Fabricante
   ORDER BY Fabricante


  SELECT a.Fabricante, a.Articulo, a.SubCuenta, Cantid4, Import4, SumaCan4, SumaTot4
    INTO #CAntAcum
    FROM #AAntAcum a
    LEFT OUTER JOIN #BAntAcum b ON a.Articulo = b.Articulo AND ISNULL(a.Fabricante, '') = ISNULL(b.Fabricante, '')
    LEFT OUTER JOIN #ZAntAcum c ON ISNULL(a.Fabricante, '') = ISNULL(c.Fabricante, '')

  INSERT #ParticipaFabric
  SELECT Fabricante, Articulo, Subcuenta, NULL, NULL, NULL, 
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
         NULL, NULL, NULL
    FROM #Arti

  UPDATE #ParticipaFabric
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CAct a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '') 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFabric
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaFabric x
    -- LEFT OUTER JOIN #CAct a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '') Bug 23316
    RIGHT OUTER JOIN #CAct a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '') 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.SubCuentax,'') = ''

  UPDATE #ParticipaFabric
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CActAcum a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '') 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFabric
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaFabric x
    -- LEFT OUTER JOIN #CActAcum a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '') Bug 23316
    RIGHT OUTER JOIN #CActAcum a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '') 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaFabric
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CAnt a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '')
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFabric
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaFabric x
    -- LEFT OUTER JOIN #CAnt a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '') Bug 23316
    RIGHT OUTER JOIN #CAnt a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '') 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.SubCuentax,'') = ''

  UPDATE #ParticipaFabric
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CAntAcum a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '') 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFabric
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaFabric x
    -- LEFT OUTER JOIN #CAntAcum a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '') Bug 23316
    RIGHT OUTER JOIN #CAntAcum a ON ISNULL(x.Fabricantex, '') = ISNULL(a.Fabricante, '') 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.SubCuentax,'') = ''

--Despliega Información

    SELECT * FROM #PARTICIPAFABRIC
    ORDER BY Fabricantex, Articulox, SubCuentax

END
GO



/**************** mis_spVentaParticProdFam ****************/
if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaParticProdFam') and type = 'P') drop procedure dbo.mis_spVentaParticProdFam
GO
CREATE PROCEDURE mis_spVentaParticProdFam
		 @Fecha		DateTime,
                 @ArticuloD	char(20),
                 @ArticuloA	char(20),
                 @Familia	varchar(50),
                 @Empresa	char(5)
		    
--//WITH ENCRYPTION
AS BEGIN
  DECLARE

    @Ejercicio		int,
    @EjercicioAnt	int,
    @FechaAnt		datetime,
    @DiaAct		int,
    @DiaAnt		int,
    @MesAct		int,
    @MesAnt		int,
    @AnoAct		int,
    @AnoAnt		int




  SELECT @Ejercicio = YEAR(@Fecha)
  SELECT @FechaAnt = @Fecha - 365 
  SELECT @EjercicioAnt = @Ejercicio - 1
  SELECT @DiaAct = DAY(@Fecha)
  SELECT @DiaAnt = DAY(@FechaAnt)
  SELECT @MesAct = MONTH(@Fecha)
  SELECT @MesAnt = MONTH(@FechaAnt)
  SELECT @AnoAct = YEAR(@Fecha)
  SELECT @AnoAnt = YEAR(@FechaAnt)


  CREATE TABLE #ParticipaFam
 (
     Familiax		char(50)	COLLATE Database_Default NULL,
     Articulox		varchar(20)	COLLATE Database_Default NULL,
     SubCuentax		char(10)	COLLATE Database_Default NULL,
     Cantid1		float(8)	NULL,
     Import1		money		NULL,
     SumaCan1		float(8)	NULL,
     Cantid2		float(8)	NULL,
     Import2		money		NULL,
     Costo2		money		NULL,
     Util2		money		NULL,
     SumaCan2		float(8)	NULL,
     SumaUtil2		money		NULL,
     Cantid3		float(8)	NULL,
     Import3		money		NULL,
     SumaCan3		float(8)	NULL,
     Cantid4		float(8)	NULL,
     Import4		money		NULL,
     SumaCan4		float(8)	NULL,
     SumaTot1		float(8)	NULL,
     SumaTot2		float(8)  	NULL,
     SumaTot3		float(8)  	NULL,
     SumaTot4           float(8)	NULL
)

  -- Articulos del Ejercicio Actual y Anterior
  SELECT Articulo, SubCuenta,
         Familia
    INTO #Arti
    FROM mis_VentaUtilX
   WHERE mis_VentaUtilX.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ((mis_VentaUtilX.Ejercicio = @EjercicioAnt
     AND mis_VentaUtilX.FechaEmision <= @FechaAnt) 
     OR (mis_VentaUtilX.Ejercicio = @Ejercicio
     AND mis_VentaUtilX.FechaEmision <= @Fecha))
     AND ISNULL(Familia, '')  = CASE @Familia  WHEN 'NULL' THEN ISNULL(Familia, '')  ELSE @Familia  END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia, Articulo, SubCuenta
   ORDER BY Familia, Articulo, SubCuenta
         

  -- Articulos con valores año actual, mes actual
  SELECT Articulo, Familia, SubCuenta, 
	 'Cantid1' = SUM(CantidadFactor),
         'Import1' = SUM(ImporteX)
   INTO #AAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '')  = CASE @Familia  WHEN 'NULL' THEN ISNULL(Familia, '')  ELSE @Familia  END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Articulo, SubCuenta, Familia
   ORDER BY Articulo, SubCuenta, Familia


  SELECT Familia, Articulo, 
         'SumaCan1' = SUM(CantidadFactor)
   INTO #BAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '') = CASE @Familia WHEN 'NULL' THEN ISNULL(Familia, '') ELSE @Familia END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia, Articulo
   ORDER BY Familia, Articulo


  SELECT Familia,
         'SumaTot1' = SUM(CantidadFactor)
   INTO #ZAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '') = CASE @Familia WHEN 'NULL' THEN ISNULL(Familia, '') ELSE @Familia END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia
   ORDER BY Familia


  SELECT a.Familia, a.Articulo, a.SubCuenta, a.Cantid1, a.Import1, b.SumaCan1, c.SumaTot1
    INTO #CAct
    FROM #AAct a
    LEFT OUTER JOIN #BAct b ON a.Articulo = b.Articulo AND ISNULL(a.Familia, '') = ISNULL(b.Familia, '')
    LEFT OUTER JOIN #ZAct c ON ISNULL(a.Familia, '') = ISNULL(c.Familia, '')

  -- Articulos con valores año actual, mes acumulado
  SELECT Familia,
         Articulo, SubCuenta,
	 'Cantid2' = SUM(CantidadFactor),
         'Import2' = SUM(ImporteX),
         'Costo2'  = SUM(CostoTotal),
         'Util2'   = SUM(ImporteX - CostoTotal)
    INTO #AActAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '') = CASE @Familia WHEN 'NULL' THEN ISNULL(Familia, '') ELSE @Familia END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia, Articulo, SubCuenta
   ORDER BY Familia, Articulo, SubCuenta


  SELECT Familia, Articulo,
         'SumaCan2'  = SUM(CantidadFactor),
         'SumaUtil2' = SUM(ImporteX - CostoTotal)
   INTO #BActAcum
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '') = CASE @Familia WHEN 'NULL' THEN ISNULL(Familia, '') ELSE @Familia END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia, Articulo
   ORDER BY Familia, Articulo


  SELECT Familia,
         'SumaTot2' = SUM(CantidadFactor)
   INTO #ZActAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '') = CASE @Familia WHEN 'NULL' THEN ISNULL(Familia, '') ELSE @Familia END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia
   ORDER BY Familia


  SELECT a.Familia, a.Articulo, a.SubCuenta, Cantid2, Import2, Costo2, Util2, SumaCan2, SumaUtil2, SumaTot2
    INTO #CActAcum
    FROM #AActAcum a
    LEFT OUTER JOIN #BActAcum b ON a.Articulo = b.Articulo AND ISNULL(a.Familia, '') = ISNULL(b.Familia, '')
    LEFT OUTER JOIN #ZActAcum c ON ISNULL(a.Familia, '') = ISNULL(c.Familia, '')

  -- Articulos con valores año anterior, mes actual
  SELECT Familia,
         Articulo, SubCuenta,
	 'Cantid3' = SUM(CantidadFactor),
         'Import3' = SUM(ImporteX)
    INTO #AAnt
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '') = CASE @Familia WHEN 'NULL' THEN ISNULL(Familia, '') ELSE @Familia END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia, Articulo, SubCuenta
   ORDER BY Familia, Articulo, SubCuenta


  SELECT Familia, Articulo,
         'SumaCan3' = SUM(CantidadFactor)
    INTO #BAnt
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '') = CASE @Familia WHEN 'NULL' THEN ISNULL(Familia, '') ELSE @Familia END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia, Articulo
   ORDER BY Familia, Articulo


  SELECT Familia,
         'SumaTot3' = SUM(CantidadFactor)
   INTO #ZAnt
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '') = CASE @Familia WHEN 'NULL' THEN ISNULL(Familia, '') ELSE @Familia END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia
   ORDER BY Familia


  SELECT a.Familia, a.Articulo, a.SubCuenta, Cantid3, Import3, SumaCan3, SumaTot3
    INTO #CAnt
    FROM #AAnt a
    LEFT OUTER JOIN #BAnt b ON a.Articulo = b.Articulo AND ISNULL(a.Familia, '') = ISNULL(b.Familia, '')
    LEFT OUTER JOIN #ZAnt c ON ISNULL(a.Familia, '') = ISNULL(c.Familia, '')

  -- Articulos con valores año anterior, mes acumulado
  SELECT Familia,
         Articulo, SubCuenta,
	 'Cantid4' = Sum(CantidadFactor),
         'Import4' = SUM(ImporteX)
    INTO #AAntAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '') = CASE @Familia WHEN 'NULL' THEN ISNULL(Familia, '') ELSE @Familia END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia, Articulo, SubCuenta
   ORDER BY Familia, Articulo, SubCuenta


  SELECT Familia, Articulo,
         'SumaCan4' = SUM(CantidadFactor)
    INTO #BAntAcum
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '') = CASE @Familia WHEN 'NULL' THEN ISNULL(Familia, '') ELSE @Familia END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia, Articulo
   ORDER BY Familia, Articulo


  SELECT Familia,
         'SumaTot4' = SUM(CantidadFactor)
   INTO #ZAntAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Familia, '') = CASE @Familia WHEN 'NULL' THEN ISNULL(Familia, '') ELSE @Familia END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Familia
   ORDER BY Familia


  SELECT a.Familia, a.Articulo, a.SubCuenta, Cantid4, Import4, SumaCan4, SumaTot4
    INTO #CAntAcum
    FROM #AAntAcum a
    LEFT OUTER JOIN #BAntAcum b ON a.Articulo = b.Articulo AND ISNULL(a.Familia, '') = ISNULL(b.Familia, '')
    LEFT OUTER JOIN #ZAntAcum c ON ISNULL(a.Familia, '') = ISNULL(c.Familia, '')

  INSERT #ParticipaFam
  SELECT Familia, Articulo, Subcuenta, NULL, NULL, NULL, 
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
         NULL, NULL, NULL
    FROM #Arti

  UPDATE #ParticipaFam
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAct a ON ISNULL(x.Familiax, '') = ISNULL(a.Familia, '')   
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFam
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAct a ON ISNULL(x.Familiax, '') = ISNULL(a.Familia, '')
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.SubCuentax, '') = ''

  UPDATE #ParticipaFam
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CActAcum a ON ISNULL(x.Familiax, '') = ISNULL(a.Familia, '')   
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta   

  UPDATE #ParticipaFam
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CActAcum a ON ISNULL(x.Familiax, '') = ISNULL(a.Familia, '')   
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaFam
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAnt a ON ISNULL(x.Familiax, '') = ISNULL(a.Familia, '')
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFam
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAnt a ON ISNULL(x.Familiax, '') = ISNULL(a.Familia, '') 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.SubCuentax, '') = ''

  UPDATE #ParticipaFam
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAntAcum a ON ISNULL(x.Familiax, '') = ISNULL(a.Familia, '')   
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFam
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAntAcum a ON ISNULL(x.Familiax, '') = ISNULL(a.Familia, '')   
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.SubCuentax, '') = ''

--Despliega Información

    SELECT * FROM #PARTICIPAFAM
    ORDER BY Familiax, Articulox, SubCuentax

END
GO




/* mis_spVentaParticProdGrupo */
if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaParticProdGrupo') and type = 'P') drop procedure dbo.mis_spVentaParticProdGrupo
GO
CREATE PROCEDURE mis_spVentaParticProdGrupo
		 @Fecha		DateTime,
                 @ArticuloD	char(20),
                 @ArticuloA	char(20),
                 @Grupo		varchar(50),
                 @Empresa	char(5)
		    
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ejercicio		int,
    @EjercicioAnt	int,
    @FechaAnt		datetime,
    @DiaAct		int,
    @DiaAnt		int,
    @MesAct		int,
    @MesAnt		int,
    @AnoAct		int,
    @AnoAnt		int

  SELECT @Ejercicio = YEAR(@Fecha)
  SELECT @FechaAnt = @Fecha - 365 
  SELECT @EjercicioAnt = @Ejercicio - 1
  SELECT @DiaAct = DAY(@Fecha)
  SELECT @DiaAnt = DAY(@FechaAnt)
  SELECT @MesAct = MONTH(@Fecha)
  SELECT @MesAnt = MONTH(@FechaAnt)
  SELECT @AnoAct = YEAR(@Fecha)
  SELECT @AnoAnt = YEAR(@FechaAnt)

  CREATE TABLE #ParticipaGrupo
 (
     Grupox		char(50)	COLLATE Database_Default NULL,
     Articulox		varchar(20)	COLLATE Database_Default NULL,
     SubCuentax		char(10)	COLLATE Database_Default NULL,
     Cantid1		float(8)	NULL,
     Import1		money		NULL,
     SumaCan1		float(8)	NULL,
     Cantid2		float(8)	NULL,
     Import2		money		NULL,
     Costo2		money		NULL,
     Util2		money		NULL,
     SumaCan2		float(8)	NULL,
     SumaUtil2		money		NULL,
     Cantid3		float(8)	NULL,
     Import3		money		NULL,
     SumaCan3		float(8)	NULL,
     Cantid4		float(8)	NULL,
     Import4		money		NULL,
     SumaCan4		float(8)	NULL,
     SumaTot1		float(8)	NULL,
     SumaTot2		float(8)  	NULL,
     SumaTot3		float(8)  	NULL,
     SumaTot4           float(8)	NULL
)

  -- Articulos del Ejercicio Actual y Anterior
  SELECT Articulo, SubCuenta, 
         Grupo
    INTO #Arti
    FROM mis_VentaUtilX
   WHERE mis_VentaUtilX.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ((mis_VentaUtilX.Ejercicio = @EjercicioAnt
     AND mis_VentaUtilX.FechaEmision <= @FechaAnt) 
     OR (mis_VentaUtilX.Ejercicio = @Ejercicio
     AND mis_VentaUtilX.FechaEmision <= @Fecha))
     AND ISNULL(Grupo, '')  = CASE @Grupo  WHEN 'NULL' THEN ISNULL(Grupo, '')  ELSE @Grupo  END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo, Articulo, SubCuenta
   ORDER BY Grupo, Articulo, SubCuenta
         

  -- Articulos con valores año actual, mes actual
  SELECT Articulo, SubCuenta, Grupo,
	 'Cantid1' = SUM(CantidadFactor),
         'Import1' = SUM(ImporteX)
   INTO #AAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '')  = CASE @Grupo  WHEN 'NULL' THEN ISNULL(Grupo, '')  ELSE @Grupo  END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Articulo, SubCuenta, Grupo
   ORDER BY Articulo, SubCuenta, Grupo


  SELECT Grupo, Articulo, 
         'SumaCan1' = SUM(CantidadFactor)
   INTO #BAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '') = CASE @Grupo WHEN 'NULL' THEN ISNULL(Grupo, '') ELSE @Grupo END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo, Articulo
   ORDER BY Grupo, Articulo


  SELECT Grupo,
         'SumaTot1' = SUM(CantidadFactor)
   INTO #ZAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '') = CASE @Grupo WHEN 'NULL' THEN ISNULL(Grupo, '') ELSE @Grupo END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo
   ORDER BY Grupo


  SELECT a.Grupo, a.Articulo, a.SubCuenta, a.Cantid1, a.Import1, b.SumaCan1, c.SumaTot1
    INTO #CAct
    FROM #AAct a
    LEFT OUTER JOIN #BAct b ON a.Articulo = b.Articulo AND ISNULL(a.Grupo, '') = ISNULL(b.Grupo, '')
    LEFT OUTER JOIN #ZAct c ON ISNULL(a.Grupo, '') = ISNULL(c.Grupo, '')

  -- Articulos con valores año actual, mes acumulado
  SELECT Grupo,
         Articulo, SubCuenta,
	 'Cantid2' = SUM(CantidadFactor),
         'Import2' = SUM(ImporteX),
         'Costo2'  = SUM(CostoTotal),
         'Util2'   = SUM(ImporteX - CostoTotal)
    INTO #AActAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '') = CASE @Grupo WHEN 'NULL' THEN ISNULL(Grupo, '') ELSE @Grupo END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo, Articulo, SubCuenta
   ORDER BY Grupo, Articulo, SubCuenta


  SELECT Grupo, Articulo,
         'SumaCan2'  = SUM(CantidadFactor),
         'SumaUtil2' = SUM(ImporteX - CostoTotal)
   INTO #BActAcum
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '') = CASE @Grupo WHEN 'NULL' THEN ISNULL(Grupo, '') ELSE @Grupo END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo, Articulo
   ORDER BY Grupo, Articulo


  SELECT Grupo,
         'SumaTot2' = SUM(CantidadFactor)
   INTO #ZActAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '') = CASE @Grupo WHEN 'NULL' THEN ISNULL(Grupo, '') ELSE @Grupo END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo
   ORDER BY Grupo


  SELECT a.Grupo, a.Articulo, a.SubCuenta, Cantid2, Import2, Costo2, Util2, SumaCan2, SumaUtil2, SumaTot2
    INTO #CActAcum
    FROM #AActAcum a
    LEFT OUTER JOIN #BActAcum b ON a.Articulo = b.Articulo AND ISNULL(a.Grupo, '') = ISNULL(b.Grupo, '')
    LEFT OUTER JOIN #ZActAcum c ON ISNULL(a.Grupo, '') = ISNULL(c.Grupo, '')

  -- Articulos con valores año anterior, mes actual
  SELECT Grupo,
         Articulo, SubCuenta,
	 'Cantid3' = SUM(CantidadFactor),
         'Import3' = SUM(ImporteX)
    INTO #AAnt
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '') = CASE @Grupo WHEN 'NULL' THEN ISNULL(Grupo, '') ELSE @Grupo END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo, Articulo, SubCuenta
   ORDER BY Grupo, Articulo, SubCuenta


  SELECT Grupo, Articulo,
         'SumaCan3' = SUM(CantidadFactor)
    INTO #BAnt
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '') = CASE @Grupo WHEN 'NULL' THEN ISNULL(Grupo, '') ELSE @Grupo END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo, Articulo
   ORDER BY Grupo, Articulo


  SELECT Grupo,
         'SumaTot3' = SUM(CantidadFactor)
   INTO #ZAnt
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '') = CASE @Grupo WHEN 'NULL' THEN ISNULL(Grupo, '') ELSE @Grupo END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo
   ORDER BY Grupo


  SELECT a.Grupo, a.Articulo, a.SubCuenta, Cantid3, Import3, SumaCan3, SumaTot3
    INTO #CAnt
    FROM #AAnt a
    LEFT OUTER JOIN #BAnt b ON a.Articulo = b.Articulo AND ISNULL(a.Grupo, '') = ISNULL(b.Grupo, '')
    LEFT OUTER JOIN #ZAnt c ON ISNULL(a.Grupo, '') = ISNULL(c.Grupo, '')

  -- Articulos con valores año anterior, mes acumulado
  SELECT Grupo,
         Articulo, SubCuenta,
	 'Cantid4' = Sum(CantidadFactor),
         'Import4' = SUM(ImporteX)
    INTO #AAntAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '') = CASE @Grupo WHEN 'NULL' THEN ISNULL(Grupo, '') ELSE @Grupo END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo, Articulo, SubCuenta
   ORDER BY Grupo, Articulo, SubCuenta


  SELECT Grupo, Articulo,
         'SumaCan4' = SUM(CantidadFactor)
    INTO #BAntAcum
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '') = CASE @Grupo WHEN 'NULL' THEN ISNULL(Grupo, '') ELSE @Grupo END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo, Articulo
   ORDER BY Grupo, Articulo


  SELECT Grupo,
         'SumaTot4' = SUM(CantidadFactor)
   INTO #ZAntAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Grupo, '') = CASE @Grupo WHEN 'NULL' THEN ISNULL(Grupo, '') ELSE @Grupo END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Grupo
   ORDER BY Grupo


  SELECT a.Grupo, a.Articulo, a.SubCuenta, Cantid4, Import4, SumaCan4, SumaTot4
    INTO #CAntAcum
    FROM #AAntAcum a
    LEFT OUTER JOIN #BAntAcum b ON a.Articulo = b.Articulo AND ISNULL(a.Grupo, '') = ISNULL(b.Grupo, '')
    LEFT OUTER JOIN #ZAntAcum c ON ISNULL(a.Grupo, '') = ISNULL(c.Grupo, '')

  INSERT #ParticipaGrupo
  SELECT Grupo, Articulo, Subcuenta, NULL, NULL, NULL, 
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
         NULL, NULL, NULL
    FROM #Arti

  UPDATE #ParticipaGrupo
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAct a ON ISNULL(x.Grupox, '') = ISNULL(a.Grupo, '')
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaGrupo
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAct a ON ISNULL(x.Grupox, '') = ISNULL(a.Grupo, '')
     AND x.Articulox = a.Articulo 
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaGrupo
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CActAcum a ON ISNULL(x.Grupox, '') = ISNULL(a.Grupo, '')     
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaGrupo
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CActAcum a ON ISNULL(x.Grupox, '') = ISNULL(a.Grupo, '')   
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaGrupo
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAnt a ON ISNULL(x.Grupox, '') = ISNULL(a.Grupo, '')     
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaGrupo
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAnt a ON ISNULL(x.Grupox, '') = ISNULL(a.Grupo, '')
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaGrupo
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAntAcum a ON ISNULL(x.Grupox, '') = ISNULL(a.Grupo, '')
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaGrupo
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAntAcum a ON ISNULL(x.Grupox, '') = ISNULL(a.Grupo, '')
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

--Despliega Información

    SELECT * FROM #PARTICIPAGRUPO
    ORDER BY Grupox, Articulox, SubCuentax

END
GO



/* mis_spVentaParticProdLinea */
if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaParticProdLinea') and type = 'P') drop procedure dbo.mis_spVentaParticProdLinea
GO
CREATE PROCEDURE mis_spVentaParticProdLinea
		 @Fecha		DateTime,
                 @ArticuloD	char(20),
                 @ArticuloA	char(20),
                 @Linea		varchar(50),
                 @Empresa	char(5)
		    
--//WITH ENCRYPTION
AS BEGIN
  DECLARE

    @Ejercicio		int,
    @EjercicioAnt	int,
    @FechaAnt		datetime,
    @DiaAct		int,
    @DiaAnt		int,
    @MesAct		int,
    @MesAnt		int,
    @AnoAct		int,
    @AnoAnt		int


  SELECT @Ejercicio = YEAR(@Fecha)
  SELECT @FechaAnt = @Fecha - 365 
  SELECT @EjercicioAnt = @Ejercicio - 1
  SELECT @DiaAct = DAY(@Fecha)
  SELECT @DiaAnt = DAY(@FechaAnt)
  SELECT @MesAct = MONTH(@Fecha)
  SELECT @MesAnt = MONTH(@FechaAnt)
  SELECT @AnoAct = YEAR(@Fecha)
  SELECT @AnoAnt = YEAR(@FechaAnt)

  CREATE TABLE #ParticipaLinea
 (
     Lineax		char(50)	COLLATE Database_Default NULL,
     Articulox		varchar(20)	COLLATE Database_Default NULL,
     SubCuentax		char(10)	COLLATE Database_Default NULL,
     Cantid1		float(8)	NULL,
     Import1		money		NULL,
     SumaCan1		float(8)	NULL,
     Cantid2		float(8)	NULL,
     Import2		money		NULL,
     Costo2		money		NULL,
     Util2		money		NULL,
     SumaCan2		float(8)	NULL,
     SumaUtil2		money		NULL,
     Cantid3		float(8)	NULL,
     Import3		money		NULL,
     SumaCan3		float(8)	NULL,
     Cantid4		float(8)	NULL,
     Import4		money		NULL,
     SumaCan4		float(8)	NULL,
     SumaTot1		float(8)	NULL,
     SumaTot2		float(8)  	NULL,
     SumaTot3		float(8)  	NULL,
     SumaTot4           float(8)	NULL
)

  -- Articulos del Ejercicio Actual y Anterior
  SELECT Articulo, SubCuenta, 
         Linea
    INTO #Arti
    FROM mis_VentaUtilX
   WHERE mis_VentaUtilX.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ((mis_VentaUtilX.Ejercicio = @EjercicioAnt
     AND mis_VentaUtilX.FechaEmision <= @FechaAnt) 
     OR (mis_VentaUtilX.Ejercicio = @Ejercicio
     AND mis_VentaUtilX.FechaEmision <= @Fecha))
     AND ISNULL(Linea, '')  = CASE @Linea  WHEN 'NULL' THEN ISNULL(Linea, '')  ELSE @Linea  END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea, Articulo, SubCuenta
   ORDER BY Linea, Articulo, SubCuenta
         

  -- Articulos con valores año actual, mes actual
  SELECT Articulo, SubCuenta, Linea,
	 'Cantid1' = SUM(CantidadFactor),
         'Import1' = SUM(ImporteX)
   INTO #AAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '')  = CASE @Linea  WHEN 'NULL' THEN ISNULL(Linea, '')  ELSE @Linea  END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Articulo, SubCuenta, Linea
   ORDER BY Articulo, SubCuenta, Linea


  SELECT Linea, Articulo, 
         'SumaCan1' = SUM(CantidadFactor)
   INTO #BAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '') = CASE @Linea WHEN 'NULL' THEN ISNULL(Linea, '') ELSE @Linea END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea, Articulo
   ORDER BY Linea, Articulo


  SELECT Linea,
         'SumaTot1' = SUM(CantidadFactor)
   INTO #ZAct
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND MONTH(FechaEmision) = @MesAct
     AND DAY(FechaEmision) <= @DiaAct
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '') = CASE @Linea WHEN 'NULL' THEN ISNULL(Linea, '') ELSE @Linea END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea
   ORDER BY Linea


  SELECT a.Linea, a.Articulo, a.SubCuenta, a.Cantid1, a.Import1, b.SumaCan1, c.SumaTot1
    INTO #CAct
    FROM #AAct a
    LEFT OUTER JOIN #BAct b ON a.Articulo = b.Articulo AND ISNULL(a.Linea, '') = ISNULL(b.Linea, '')
    LEFT OUTER JOIN #ZAct c ON ISNULL(a.Linea, '') = ISNULL(c.Linea, '')

  -- Articulos con valores año actual, mes acumulado
  SELECT Linea,
         Articulo, SubCuenta,
	 'Cantid2' = SUM(CantidadFactor),
         'Import2' = SUM(ImporteX),
         'Costo2'  = SUM(CostoTotal),
         'Util2'   = SUM(ImporteX - CostoTotal)
    INTO #AActAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '') = CASE @Linea WHEN 'NULL' THEN ISNULL(Linea, '') ELSE @Linea END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea, Articulo, SubCuenta
   ORDER BY Linea, Articulo, SubCuenta


  SELECT Linea, Articulo,
         'SumaCan2'  = SUM(CantidadFactor),
         'SumaUtil2' = SUM(ImporteX - CostoTotal)
   INTO #BActAcum
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '') = CASE @Linea WHEN 'NULL' THEN ISNULL(Linea, '') ELSE @Linea END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea, Articulo
   ORDER BY Linea, Articulo


  SELECT Linea,
         'SumaTot2' = SUM(CantidadFactor)
   INTO #ZActAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAct
     AND FechaEmision <= @Fecha
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '') = CASE @Linea WHEN 'NULL' THEN ISNULL(Linea, '') ELSE @Linea END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea
   ORDER BY Linea


  SELECT a.Linea, a.Articulo, a.SubCuenta, Cantid2, Import2, Costo2, Util2, SumaCan2, SumaUtil2, SumaTot2
    INTO #CActAcum
    FROM #AActAcum a
    LEFT OUTER JOIN #BActAcum b ON a.Articulo = b.Articulo AND ISNULL(a.Linea, '') = ISNULL(b.Linea, '')
    LEFT OUTER JOIN #ZActAcum c ON ISNULL(a.Linea, '') = ISNULL(c.Linea, '')

  -- Articulos con valores año anterior, mes actual
  SELECT Linea,
         Articulo, SubCuenta,
	 'Cantid3' = SUM(CantidadFactor),
         'Import3' = SUM(ImporteX)
    INTO #AAnt
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '') = CASE @Linea WHEN 'NULL' THEN ISNULL(Linea, '') ELSE @Linea END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea, Articulo, SubCuenta
   ORDER BY Linea, Articulo, SubCuenta


  SELECT Linea, Articulo,
         'SumaCan3' = SUM(CantidadFactor)
    INTO #BAnt
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '') = CASE @Linea WHEN 'NULL' THEN ISNULL(Linea, '') ELSE @Linea END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea, Articulo
   ORDER BY Linea, Articulo


  SELECT Linea,
         'SumaTot3' = SUM(CantidadFactor)
   INTO #ZAnt
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND MONTH(FechaEmision) = @MesAnt
     AND DAY(FechaEmision) <= @DiaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '') = CASE @Linea WHEN 'NULL' THEN ISNULL(Linea, '') ELSE @Linea END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea
   ORDER BY Linea


  SELECT a.Linea, a.Articulo, a.SubCuenta, Cantid3, Import3, SumaCan3, SumaTot3
    INTO #CAnt
    FROM #AAnt a
    LEFT OUTER JOIN #BAnt b ON a.Articulo = b.Articulo AND ISNULL(a.Linea, '') = ISNULL(b.Linea, '')
    LEFT OUTER JOIN #ZAnt c ON ISNULL(a.Linea, '') = ISNULL(c.Linea, '')

  -- Articulos con valores año anterior, mes acumulado
  SELECT Linea,
         Articulo, SubCuenta,
	 'Cantid4' = Sum(CantidadFactor),
         'Import4' = SUM(ImporteX)
    INTO #AAntAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '') = CASE @Linea WHEN 'NULL' THEN ISNULL(Linea, '') ELSE @Linea END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea, Articulo, SubCuenta
   ORDER BY Linea, Articulo, SubCuenta


  SELECT Linea, Articulo,
         'SumaCan4' = SUM(CantidadFactor)
    INTO #BAntAcum
    FROM mis_VentaUtilX 
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '') = CASE @Linea WHEN 'NULL' THEN ISNULL(Linea, '') ELSE @Linea END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea, Articulo
   ORDER BY Linea, Articulo

  SELECT Linea,
         'SumaTot4' = SUM(CantidadFactor)
   INTO #ZAntAcum
    FROM mis_VentaUtilX
   WHERE YEAR(FechaEmision) = @AnoAnt
     AND FechaEmision <= @FechaAnt
     AND MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ISNULL(Linea, '') = CASE @Linea WHEN 'NULL' THEN ISNULL(Linea, '') ELSE @Linea END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND Empresa = @Empresa
   GROUP BY Linea
   ORDER BY Linea

  SELECT a.Linea, a.Articulo, a.SubCuenta, Cantid4, Import4, SumaCan4, SumaTot4
    INTO #CAntAcum
    FROM #AAntAcum a
    LEFT OUTER JOIN #BAntAcum b ON a.Articulo = b.Articulo AND ISNULL(a.Linea, '') = ISNULL(b.Linea, '')
    LEFT OUTER JOIN #ZAntAcum c ON ISNULL(a.Linea, '') = ISNULL(c.Linea, '')

  INSERT #ParticipaLinea
  SELECT Linea, Articulo, Subcuenta, NULL, NULL, NULL, 
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
         NULL, NULL, NULL
    FROM #Arti

  UPDATE #ParticipaLinea
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAct a ON ISNULL(x.Lineax, '') = ISNULL(a.Linea, '') 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaLinea
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAct a ON ISNULL(x.Lineax, '') = ISNULL(a.Linea, '') 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaLinea
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CActAcum a ON ISNULL(x.Lineax, '') = ISNULL(a.Linea, '') 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaLinea
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CActAcum a ON ISNULL(x.Lineax, '') = ISNULL(a.Linea, '') 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaLinea
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAnt a ON ISNULL(x.Lineax, '') = ISNULL(a.Linea, '')
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaLinea
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAnt a ON ISNULL(x.Lineax, '') = ISNULL(a.Linea, '') 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaLinea
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAntAcum a ON ISNULL(x.Lineax, '') = ISNULL(a.Linea, '') 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaLinea
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAntAcum a ON ISNULL(x.Lineax, '') = ISNULL(a.Linea, '') 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

--Despliega Información

    SELECT * FROM #PARTICIPALINEA
    ORDER BY Lineax, Articulox, SubCuentax

END
GO

/****** Indices spIVADeclarado ******/
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'IVADeclarado' AND sysobjects.id = sysindexes.id)
        CREATE INDEX IVADeclarado ON Dinero 
        (
	        MovID,
	        Mov,
	        FechaConciliacion,
	        CtaDinero,
	        Estatus,
	        TipoCambio
        )
        go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'IVADeclarado' AND sysobjects.id = sysindexes.id)
        CREATE INDEX IVADeclarado ON Cxp 
        (
	        Mov,
	        MovID,
	        Estatus,
	        DineroCtaDinero,
	        Dinero,
	        Empresa,
	        DineroID,
	        Proveedor,
	        ID,
	        Origen,
	        OrigenID
        )
        go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CxpD' AND sysindexes.name = 'IVADeclarado' AND sysobjects.id = sysindexes.id)
        CREATE INDEX IVADeclarado ON CxpD 
        (
	        ID,
	        Aplica,
	        AplicaID
        )
        go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'GastoD' AND sysindexes.name = 'IVADeclarado' AND sysobjects.id = sysindexes.id)
        CREATE INDEX IVADeclarado ON GastoD 
        (
	        ID,
	        Concepto,
	        PorcentajeDeducible,
	        Importe,
	        Impuestos
        )
        go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Concepto' AND sysindexes.name = 'IVADeclarado' AND sysobjects.id = sysindexes.id)
        CREATE INDEX IVADeclarado ON Concepto 
        (
	        Modulo,
	        Concepto,
	        Impuesto1Excento
        )
        go


/****** IVADeclaradoInicial ******/
if not exists (select * from SysTabla where SysTabla = 'IVADeclaradoInicial') 
INSERT INTO SysTabla (SysTabla) VALUES ('IVADeclaradoInicial')
if exists (select * from sysobjects where id = object_id('dbo.IVADeclaradoInicial') and type = 'U') 
  DROP TABLE IVADeclaradoInicial
GO
CREATE TABLE dbo.IVADeclaradoInicial (
		Estacion		int		NOT NULL,
		Empresa			char(5)		NOT NULL,
		ID			int		NOT NULL IDENTITY(1, 1),
 		Proveedor		char(10)	NULL,
		RFC			varchar(15)	NULL,
		Nombre			varchar(100)	NULL,
		OrigenMov		char(20)	NULL,
		OrigenMovID		varchar(20)	NULL,
		TipoOperacion		varchar(30)	NULL,
		ModuloMov		char(20)	NULL,
		ModuloMovID		varchar(20)	NULL,
		Mov			char(20)	NULL,
		MovID			varchar(20)	NULL,
		Descripcion		varchar(50)	NULL,
		DestinoMov		char(20)	NULL,
		DestinoMovID		varchar(20)	NULL,
		FechaConciliacion	Datetime	NULL,
		Importe			money		NULL,
		Impuesto		money		NULL,
		Impuesto15		money		NULL,
		Impuesto10		money		NULL,
		ImpuestoValidar		money		NULL,
		IEPS20			money		NULL,
		IEPS25			money		NULL,
		IEPS30			money		NULL,
		IEPS50			money		NULL,
		IEPSCigarros		money		NULL,
		IEPSTabacos		money		NULL,
		RetencionIVA		money		NULL,
		RetencionISR		money		NULL,
		IvaOExento		varchar(15)	NULL,
		PorcentajeDeducible	float		NULL,
 
      CONSTRAINT priIVADEclaradoInicial PRIMARY KEY  CLUSTERED (Estacion, Empresa, ID)
)
GO

-- DROP TABLE IVADeclaradoInicial

/**************** spIVADeclarado ****************/
-- BUG 7890 Mod.18/06/2013
if exists (select * from sysobjects where id = object_id('dbo.spIVADeclarado') and type = 'P') drop procedure dbo.spIVADeclarado
GO             
CREATE PROCEDURE spIVADeclarado
		@Estacion	int,
		@FechaD		Datetime,
		@FechaA		Datetime,
		@Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN

--  DECLARE

  DELETE FROM IVADeclaradoInicial WHERE Estacion = @Estacion

  -- Pago Gasto
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,   RFC,   Nombre,   OrigenMov, OrigenMovID, TipoOperacion,   ModuloMov, ModuloMovID, Mov,   MovID,   Descripcion, DestinoMov, DestinoMovID, FechaConciliacion, 
         Importe,                  Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IvaOExento, RetencionIVA, RetencionISR, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, a.Proveedor, p.RFC, p.Nombre, y.Mov,     y.MovID,     g.TipoOperacion , x.Mov,     x.MovID,     a.Mov, a.MovID, z.Concepto,  e.Mov,      e.MovID,      e.FechaConciliacion, 
         Importe = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> 
                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN

                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                   ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0) * e.TipoCambio ELSE

                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0) * e.TipoCambio END,
				   
--         Importe = ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
--                   ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0),

--                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (g.retencion2/100))) * z.Retencion2), 0) +
--                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (g.retencion/100))) * z.Retencion), 0) * e.TipoCambio,

         Impuestos = (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio,
         Impuesto15 = CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio END, 
         Impuesto10 = CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio END, 
         ImpuestoValidar = CASE WHEN (ROUND(z.Impuestos/z.Importe, 2) <> 0.11) AND (ROUND(z.Impuestos/z.Importe, 2) <> 0.16) THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio END, 
         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN z.Impuestos * e.TipoCambio END) IS NULL) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN z.Impuestos * e.TipoCambio END) IS NULL)) THEN 'IVA 0%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN z.Impuestos * e.TipoCambio END) IS NOT NULL) THEN 'IVA 16%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN z.Impuestos * e.TipoCambio END) IS NOT NULL) THEN 'IVA 11%'
                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END,
         RetencionIVA = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN
                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100)),0) * e.TipoCambio ELSE --BUG 7890

                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100)),0) * e.TipoCambio END,

         RetencionISR = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN
                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100)),0) * e.TipoCambio ELSE

                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100)),0) * e.TipoCambio END,
         z.PorcentajeDeducible
    FROM Cxp a
    JOIN CxpD b ON a.ID = b.ID
    JOIN MovTipo mtx ON mtx.Mov = a.Mov AND mtx.Modulo = 'CXP' AND mtx.Clave = 'CXP.P'
    JOIN CxpAplica h ON b.Aplica = h.Mov AND b.AplicaID = h.MovID AND h.Empresa = @Empresa

    JOIN Dinero e ON e.CtaDinero = a.DineroCtaDinero AND a.Dinero = e.Mov AND a.DineroID = e.MovID
    JOIN MovTipo mt2 ON mt2.Mov = e.Mov AND mt2.Modulo = 'DIN' AND mt2.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.E')
    JOIN Prov p ON a.Proveedor = p.Proveedor

    JOIN Cxp x ON b.Aplica = x.Mov AND b.AplicaID = x.MovID
    JOIN Gasto y ON x.Origen = y.Mov AND x.OrigenID = y.MovID
    JOIN GastoD z ON y.ID = z.ID
    LEFT OUTER JOIN Concepto g ON z.Concepto = g.Concepto AND g.Modulo = 'GAS'
    JOIN MovTipo mt3 ON mt3.Mov = y.Mov AND mt3.Modulo = 'GAS' AND mt3.Clave = 'GAS.G'

	JOIN MovTipo mt4 ON mt4.Mov = b.Aplica AND mt4.Modulo = 'CXP' AND mt4.Clave IN ('CXP.AA','CXP.AF','CXP.D','CXP.DA','CXP.F')

   WHERE 
     --b.Aplica IN('Deposito Arrendamien', 'Anticipo Saldo', 'Anticipo Factura', 'Intereses Devengados', 'Abono Intereses', 'Documento', 'Factura Proveedor', 'Documento Anticipo', 'Compra Activo Fijo',
     --                'Compra Local', 'Compra Software', 'Entrada Compra', 'Entrada con Gastos', 'Gasto', 'Gasto Anticipo', 'Gasto Diverso', 'Gasto Prorrateado') AND
	     e.FechaConciliacion BETWEEN @FechaD AND @FechaA
     AND a.Estatus = 'CONCLUIDO'
     AND e.Estatus IN ('CONCILIADO', 'CONCLUIDO') --BUG 7890
     AND x.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND y.Estatus = 'CONCLUIDO'
     AND a.Empresa = @Empresa
     AND e.Empresa = @Empresa
     AND x.Empresa = @Empresa
     AND y.Empresa = @Empresa

  -- Anticipo/Aplicación Gasto
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,   RFC,   Nombre,   OrigenMov, OrigenMovID, TipoOperacion,   ModuloMov, ModuloMovID, Mov,   MovID,   Descripcion, DestinoMov, DestinoMovID, FechaConciliacion, 
         Importe, Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IvaOExento, RetencionIVA, RetencionISR, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, a.Proveedor, p.RFC, p.Nombre, y.Mov,     y.MovID,     g.TipoOperacion, x.Mov,     x.MovID,     a.Mov, a.MovID, z.Concepto,  e.Mov,      e.MovID,      e.FechaConciliacion, 
         Importe = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> 
                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN

                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                   ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0) * e.TipoCambio ELSE

                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0) * e.TipoCambio END,

--         Importe = ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
--                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (g.retencion2/100))) * z.Retencion2), 0) +
--                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (g.retencion/100))) * z.Retencion), 0) * e.TipoCambio,
         Impuestos = (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * c.Importe ELSE 0 END) * e.TipoCambio,
         Impuesto15 = CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * c.Importe ELSE 0 END) * e.TipoCambio END, 
         Impuesto10 = CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * c.Importe ELSE 0 END) * e.TipoCambio END, 
         ImpuestoValidar = CASE WHEN (ROUND(z.Impuestos/z.Importe, 2) <> 0.11) AND (ROUND(z.Impuestos/z.Importe, 2) <> 0.16) THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio END, 
         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN z.Impuestos * e.TipoCambio END) IS NULL) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN z.Impuestos * e.TipoCambio END) IS NULL)) THEN 'IVA 0%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN z.Impuestos * e.TipoCambio END) IS NOT NULL) THEN 'IVA 16%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN z.Impuestos * e.TipoCambio END) IS NOT NULL) THEN 'IVA 11%'
                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END,
         RetencionIVA = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN
                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100)),0) * e.TipoCambio ELSE

                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100)),0) * e.TipoCambio END,

         RetencionISR = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN
                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100)),0) * e.TipoCambio ELSE

                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100)),0) * e.TipoCambio END,
         z.PorcentajeDeducible
    FROM Cxp c
    JOIN CxpD b ON c.ID = b.ID
    JOIN MovTipo mty ON mty.Mov = c.Mov AND mty.Modulo = 'CXP' AND mty.Clave = 'CXP.ANC'
    JOIN MovFlujo w ON w.DMov = c.Mov AND w.DMovID = c.MovID AND w.OModulo = 'CXP'
    JOIN Cxp a ON w.OMov = a.Mov AND w.OMovID = a.MovID AND w.DModulo = 'CXP'
    
	JOIN MovTipo mtx ON mtx.Mov = a.Mov AND mtx.Modulo = 'CXP' AND mtX.Clave = 'CXP.A'
    JOIN CxpAplica h ON c.Mov = h.Mov AND c.MovID = h.MovID AND h.Empresa = @Empresa

    JOIN Cxp x ON b.Aplica = x.Mov AND b.AplicaID = x.MovID
    JOIN Gasto y ON x.Origen = y.Mov AND x.OrigenID = y.MovID
    JOIN GastoD z ON y.ID = z.ID

    LEFT OUTER JOIN Concepto g ON z.Concepto = g.Concepto AND g.Modulo = 'GAS'
    JOIN MovTipo mt3 ON mt3.Mov = y.Mov AND mt3.Modulo = 'GAS' AND mt3.Clave = 'GAS.G'

    JOIN Dinero e ON e.CtaDinero = a.DineroCtaDinero AND a.Dinero = e.Mov AND a.DineroID = e.MovID
    JOIN MovTipo mt2 ON mt2.Mov = e.Mov AND mt2.Modulo = 'DIN' AND mt2.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.E')
    JOIN Prov p ON a.Proveedor = p.Proveedor

	JOIN MovTipo mt4 ON mt4.Mov = b.Aplica AND mt4.Modulo = 'CXP' AND mt4.Clave IN ('CXP.AA','CXP.AF','CXP.D','CXP.DA','CXP.F')

   WHERE 
     --b.Aplica IN('Deposito Arrendamien', 'Anticipo Saldo', 'Anticipo Factura', 'Intereses Devengados', 'Abono Intereses', 'Documento', 'Factura Proveedor', 'Documento Anticipo', 'Compra Activo Fijo',
     --                'Compra Local', 'Compra Software', 'Entrada Compra', 'Entrada con Gastos', 'Gasto', 'Gasto Anticipo', 'Gasto Diverso', 'Gasto Prorrateado') AND
	     e.FechaConciliacion BETWEEN @FechaD AND @FechaA
     AND a.Estatus = 'CONCLUIDO'
     AND e.Estatus IN ('CONCILIADO', 'CONCLUIDO') --BUG 7890
     AND x.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND y.Estatus = 'CONCLUIDO'
     AND a.Empresa = @Empresa
     AND c.Empresa = @Empresa
     AND x.Empresa = @Empresa
     AND y.Empresa = @Empresa
     AND e.Empresa = @Empresa


  -- Pago Cxp - Gasto
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,   RFC,   Nombre,   OrigenMov, OrigenMovID, TipoOperacion,   ModuloMov, ModuloMovID, Mov,   MovID,   Descripcion, DestinoMov, DestinoMovID, FechaConciliacion, 
         Importe, Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IvaOExento, RetencionIVA, RetencionISR, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, a.Proveedor, p.RFC, p.Nombre, y.Mov,     y.MovID,     g.TipoOperacion, x.Mov,     x.MovID,     a.Mov, a.MovID, z.Concepto,  e.Mov,      e.MovID,      e.FechaConciliacion, 
         Importe = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> 
                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN

                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                   ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0) * e.TipoCambio ELSE

                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0) * e.TipoCambio END,

--         Importe = ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
--                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (g.retencion2/100))) * z.Retencion2), 0) +
--                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (g.retencion/100))) * z.Retencion), 0) * e.TipoCambio,
         Impuestos = (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio,
         Impuesto15 = CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio END, 
         Impuesto10 = CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio END, 
         ImpuestoValidar = CASE WHEN (ROUND(z.Impuestos/z.Importe, 2) <> 0.11) AND (ROUND(z.Impuestos/z.Importe, 2) <> 0.16) THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio END, 
         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN z.Impuestos * e.TipoCambio END) IS NULL) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN z.Impuestos * e.TipoCambio END) IS NULL)) THEN 'IVA 0%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN z.Impuestos * e.TipoCambio END) IS NOT NULL) THEN 'IVA 16%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN z.Impuestos * e.TipoCambio END) IS NOT NULL) THEN 'IVA 11%'
                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END,
         RetencionIVA = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN
                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100)),0) * e.TipoCambio ELSE

                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100)),0) * e.TipoCambio END,

         RetencionISR = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN
                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100)),0) * e.TipoCambio ELSE

                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100)),0) * e.TipoCambio END,
         z.PorcentajeDeducible
    FROM Cxp a
    JOIN CxpD b ON a.ID = b.ID
    JOIN MovTipo mtx ON mtx.Mov = a.Mov AND mtx.Modulo = 'CXP' AND mtX.Clave = 'CXP.P'
    JOIN CxpAplica h ON b.Aplica = h.Mov AND b.AplicaID = h.MovID AND h.Empresa = @Empresa

    JOIN Dinero e ON e.CtaDinero = a.DineroCtaDinero AND a.Dinero = e.Mov AND a.DineroID = e.MovID
    JOIN MovTipo mt2 ON mt2.Mov = e.Mov AND mt2.Modulo = 'DIN' AND mt2.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.E')
    JOIN Prov p ON a.Proveedor = p.Proveedor

    JOIN Cxp x ON b.Aplica = x.Mov AND b.AplicaID = x.MovID
    JOIN CxpD w ON x.ID = w.ID
    JOIN Cxp v ON v.Mov = w.Aplica AND v.MovID = w.AplicaID

    JOIN Gasto y ON v.Origen = y.Mov AND v.OrigenID = y.MovID
    JOIN GastoD z ON y.ID = z.ID
    LEFT OUTER JOIN Concepto g ON z.Concepto = g.Concepto AND g.Modulo = 'GAS'
    JOIN MovTipo mt3 ON mt3.Mov = y.Mov AND mt3.Modulo = 'GAS' AND mt3.Clave = 'GAS.G'

	JOIN MovTipo mt4 ON mt4.Mov = b.Aplica AND mt4.Modulo = 'CXP' AND mt4.Clave IN ('CXP.AA','CXP.AF','CXP.D','CXP.DA','CXP.F')

   WHERE 
     --b.Aplica IN('Deposito Arrendamien', 'Anticipo Saldo', 'Anticipo Factura', 'Intereses Devengados', 'Abono Intereses', 'Documento', 'Factura Proveedor', 'Documento Anticipo', 'Compra Activo Fijo',
     --                'Compra Local', 'Compra Software', 'Entrada Compra', 'Entrada con Gastos', 'Gasto', 'Gasto Anticipo', 'Gasto Diverso', 'Gasto Prorrateado') AND
	     e.FechaConciliacion BETWEEN @FechaD AND @FechaA
     AND a.Estatus = 'CONCLUIDO'
     AND e.Estatus IN ('CONCILIADO', 'CONCLUIDO') --BUG 7890
     AND x.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND y.Estatus = 'CONCLUIDO'
     AND a.Empresa = @Empresa
     AND e.Empresa = @Empresa
     AND x.Empresa = @Empresa
     AND v.Empresa = @Empresa
     AND y.Empresa = @Empresa


  -- Anticipo/Aplicación Cxp - Gasto
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,   RFC,   Nombre,   OrigenMov, OrigenMovID, TipoOperacion,   ModuloMov, ModuloMovID, Mov,   MovID,   Descripcion, DestinoMov, DestinoMovID, FechaConciliacion, 
         Importe, Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IvaOExento, RetencionIVA, RetencionISR, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, a.Proveedor, p.RFC, p.Nombre, y.Mov,     y.MovID,     g.TipoOperacion, x.Mov,      x.MovID,     a.Mov, a.MovID, z.Concepto,  e.Mov,      e.MovID,      e.FechaConciliacion, 
         Importe = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> 
                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN

                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                   ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0) * e.TipoCambio ELSE

                   ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0) * e.TipoCambio END, 

--         Importe = ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
--                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (g.retencion2/100))) * z.Retencion2), 0) +
--                   ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (g.retencion/100))) * z.Retencion), 0) * e.TipoCambio,
         Impuestos = (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio,
         Impuesto15 = CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio END, 
         Impuesto10 = CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio END, 
         ImpuestoValidar = CASE WHEN (ROUND(z.Impuestos/z.Importe, 2) <> 0.11) AND (ROUND(z.Impuestos/z.Importe, 2) <> 0.16) THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * e.TipoCambio END, 
         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN z.Impuestos * e.TipoCambio END) IS NULL) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN z.Impuestos * e.TipoCambio END) IS NULL)) THEN 'IVA 0%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN z.Impuestos * e.TipoCambio END) IS NOT NULL) THEN 'IVA 16%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN z.Impuestos * e.TipoCambio END) IS NOT NULL) THEN 'IVA 11%'
                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END,
         RetencionIVA = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN
                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100)),0) * e.TipoCambio ELSE

                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100)),0) * e.TipoCambio END,

         RetencionISR = CASE WHEN b.importe - (b.Importe * h.Ivafiscal) <> ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) THEN
                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((z.Importe - ((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))))), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100)),0) * e.TipoCambio ELSE

                       ISNULL(((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) + 
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion2')/100))) * z.Retencion2), 0) +
                       ISNULL((((((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) ) / (y.importe - (y.importe * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100))) * z.Retencion), 0)) * (dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', z.Concepto,'Retencion1')/100)),0) * e.TipoCambio END,
         z.PorcentajeDeducible
    FROM Cxp c
    JOIN CxpD b ON c.ID = b.ID
    JOIN MovTipo mty ON mty.Mov = c.Mov AND mty.Modulo = 'CXP' AND mty.Clave = 'CXP.ANC'
    JOIN MovFlujo w ON w.DMov = c.Mov AND w.DMovID = c.MovID AND w.OModulo = 'CXP'
    JOIN Cxp a ON w.OMov = a.Mov AND w.OMovID = a.MovID AND w.DModulo = 'CXP'
    JOIN MovTipo mtx ON mtx.Mov = a.Mov AND mtx.Modulo = 'CXP' AND mtX.Clave = 'CXP.A'
    JOIN CxpAplica h ON c.Mov = h.Mov AND c.MovID = h.MovID AND h.Empresa = @Empresa

    JOIN Cxp x ON b.Aplica = x.Mov AND b.AplicaID = x.MovID
    JOIN CxpD j ON x.ID = j.ID
    JOIN Cxp k ON k.Mov = j.Aplica AND k.MovID = j.AplicaID

    JOIN Gasto y ON x.Origen = y.Mov AND x.OrigenID = y.MovID
    JOIN GastoD z ON y.ID = z.ID
    LEFT OUTER JOIN Concepto g ON z.Concepto = g.Concepto AND g.Modulo = 'GAS'
    JOIN MovTipo mt3 ON mt3.Mov = y.Mov AND mt3.Modulo = 'GAS' AND mt3.Clave = 'GAS.G'

    JOIN Dinero e ON e.CtaDinero = a.DineroCtaDinero AND a.Dinero = e.Mov AND a.DineroID = e.MovID
    JOIN MovTipo mt2 ON mt2.Mov = e.Mov AND mt2.Modulo = 'DIN' AND mt2.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.E')
    JOIN Prov p ON a.Proveedor = p.Proveedor

	JOIN MovTipo mt4 ON mt4.Mov = b.Aplica AND mt4.Modulo = 'CXP' AND mt4.Clave IN ('CXP.AA','CXP.AF','CXP.D','CXP.DA','CXP.F')

   WHERE 
   
     --  b.Aplica IN('Deposito Arrendamien', 'Anticipo Saldo', 'Anticipo Factura', 'Intereses Devengados', 'Abono Intereses', 'Documento', 'Factura Proveedor', 'Documento Anticipo', 'Compra Activo Fijo',
     --              'Compra Local', 'Compra Software', 'Entrada Compra', 'Entrada con Gastos', 'Gasto', 'Gasto Anticipo', 'Gasto Diverso', 'Gasto Prorrateado') AND
					 
		 e.FechaConciliacion BETWEEN @FechaD AND @FechaA
     AND a.Estatus = 'CONCLUIDO'
     AND e.Estatus IN ('CONCILIADO', 'CONCLUIDO') --BUG 7890
     AND x.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND y.Estatus = 'CONCLUIDO'
     AND a.Empresa = @Empresa
     AND c.Empresa = @Empresa
     AND x.Empresa = @Empresa
     AND k.Empresa = @Empresa
     AND y.Empresa = @Empresa


  -- Pago Compra
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,   RFC,   Nombre,   OrigenMov, OrigenMovID, TipoOperacion, ModuloMov, ModuloMovID, Mov,   MovID,   Descripcion,                       DestinoMov, DestinoMovID, FechaConciliacion, 
         Importe, Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IEPS20, IEPS25, IEPS30, IEPS50, IEPSCigarros, IEPSTabacos, IvaOExento, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, a.Proveedor, p.RFC, p.Nombre, y.Mov,     y.MovID,     'Otros',       x.Mov,     x.MovID,     a.Mov, a.MovID, RTRIM(z.Articulo)+' '+z.SubCuenta, e.Mov,      e.MovID,      e.FechaConciliacion, 
         Importe = ((((b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) -
                   ISNULL(h.IVAFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0) -
                   ISNULL(h.IEPSFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0))) * e.TipoCambio),
         Impuesto = ISNULL((h.IVAFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / y.Importe)), 0) * e.TipoCambio,
         Impuesto15 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto1 = 15.0 THEN ISNULL(m.Importe1, 0) END)) * e.TipoCambio,
         Impuesto10 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto1 = 10.0 THEN ISNULL(m.Importe1, 0) END)) * e.TipoCambio,
         ImpuestoValidar = CASE WHEN (m.Impuesto1 <> 16.0) AND (m.Impuesto1 <> 11.0) THEN (((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * ISNULL(m.Importe1, 0) * e.TipoCambio END, 
         IEPS20 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 20.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPS25 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 25.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPS30 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 30.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPS50 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 50.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPSCigarros = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 100.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPSTabacos  = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 20.9 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 =  0.0) THEN 'IVA 0%'
                           WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 = 16.0) THEN 'IVA 16%'
                           WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 = 11.0) THEN 'IVA 11%'
                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END, 100
    FROM Cxp a
    JOIN CxpD b ON a.ID = b.ID
    JOIN MovTipo mtx ON mtx.Mov = a.Mov AND mtx.Modulo = 'CXP' AND mtX.Clave = 'CXP.P'
    JOIN CxpAplica h ON b.Aplica = h.Mov AND b.AplicaID = h.MovID AND h.Empresa = @Empresa

    JOIN Dinero e ON e.CtaDinero = a.DineroCtaDinero AND a.Dinero = e.Mov AND a.DineroID = e.MovID
    JOIN MovTipo mt2 ON mt2.Mov = e.Mov AND mt2.Modulo = 'DIN' AND mt2.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.E')
    JOIN Prov p ON a.Proveedor = p.Proveedor

    JOIN Cxp x ON b.Aplica = x.Mov AND b.AplicaID = x.MovID
    JOIN Compra y ON x.Origen = y.Mov AND x.OrigenID = y.MovID
    JOIN CompraD z ON y.ID = z.ID
    JOIN Art g ON z.Articulo = g.Articulo
    JOIN MovTipo mt3 ON mt3.Mov = y.Mov AND mt3.Modulo = 'COMS' AND mt3.Clave IN ('COMS.F', 'COMS.FL', 'COMS.EG')
    JOIN MovImpuesto m ON y.ID = m.ModuloID AND m.Modulo = 'COMS' AND ((ROUND(m.SubTotal, 2) = ROUND(y.Importe, 2)) OR (ROUND(m.SubTotal+m.Importe1+m.Importe2, 2) = ROUND(y.Importe, 2)))
   
   
   JOIN MovTipo mt4 ON mt4.Mov = b.Aplica AND mt4.Modulo = 'CXP' AND mt4.Clave IN ('CXP.AA','CXP.AF','CXP.D','CXP.DA','CXP.F')

   WHERE 
   
     --  b.Aplica IN('Deposito Arrendamien', 'Anticipo Saldo', 'Anticipo Factura', 'Intereses Devengados', 'Abono Intereses', 'Documento', 'Factura Proveedor', 'Documento Anticipo', 'Compra Activo Fijo',
     --              'Compra Local', 'Compra Software', 'Entrada Compra', 'Entrada con Gastos', 'Gasto', 'Gasto Anticipo', 'Gasto Diverso', 'Gasto Prorrateado') AND
					 
		 e.FechaConciliacion BETWEEN @FechaD AND @FechaA
     AND a.Estatus = 'CONCLUIDO'
     AND e.Estatus IN ('CONCILIADO', 'CONCLUIDO') --BUG 7890
     AND x.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND y.Estatus = 'CONCLUIDO'
     AND a.Empresa = @Empresa
     AND e.Empresa = @Empresa
     AND x.Empresa = @Empresa
     AND y.Empresa = @Empresa
	 
  -- Anticipo/Aplicación Compra
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,   RFC,   Nombre,   OrigenMov, OrigenMovID, TipoOperacion, ModuloMov, ModuloMovID, Mov,   MovID,   Descripcion,                       DestinoMov, DestinoMovID, FechaConciliacion, 
         Importe, Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IEPS20, IEPS25, IEPS30, IEPS50, IEPSCigarros, IEPSTabacos, IvaOExento, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, a.Proveedor, p.RFC, p.Nombre, y.Mov,     y.MovID,     'Otros',       x.Mov,     x.MovID,     a.Mov, a.MovID, RTRIM(z.Articulo)+' '+z.SubCuenta, e.Mov,      e.MovID,      e.FechaConciliacion, 
         Importe = ((((b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) -
                   ISNULL(h.IVAFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0) -
                   ISNULL(h.IEPSFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0))) * e.TipoCambio),
         Impuestos = ISNULL((h.IVAFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / y.Importe)), 0) * e.TipoCambio,
         Impuesto15 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto1 = 16.0 THEN ISNULL(m.Importe1, 0) END)) * e.TipoCambio,
         Impuesto10 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto1 = 11.0 THEN ISNULL(m.Importe1, 0) END)) * e.TipoCambio,
         ImpuestoValidar = CASE WHEN (m.Impuesto1 <> 11.0) AND (m.Impuesto1 <> 16.0) THEN (((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * ISNULL(m.Importe1, 0) * e.TipoCambio END, 
         IEPS20 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 20.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPS25 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 25.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPS30 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 30.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPS50 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 50.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPSCigarros = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 100.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPSTabacos  = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 20.9 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 =  0.0) THEN 'IVA 0%'
                           WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 = 16.0) THEN 'IVA 16%'
                           WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 = 11.0) THEN 'IVA 11%'
                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END, 100
    FROM Cxp c
    JOIN CxpD b ON c.ID = b.ID
    JOIN MovTipo mty ON mty.Mov = c.Mov AND mty.Modulo = 'CXP' AND mty.Clave = 'CXP.ANC'
    JOIN MovFlujo w ON w.DMov = c.Mov AND w.DMovID = c.MovID AND w.OModulo = 'CXP'
    JOIN Cxp a ON w.OMov = a.Mov AND w.OMovID = a.MovID AND w.DModulo = 'CXP'
    JOIN MovTipo mtx ON mtx.Mov = a.Mov AND mtx.Modulo = 'CXP' AND mtX.Clave = 'CXP.A'
    JOIN CxpAplica h ON c.Mov = h.Mov AND c.MovID = h.MovID AND h.Empresa = @Empresa

    JOIN Cxp x ON b.Aplica = x.Mov AND b.AplicaID = x.MovID
    JOIN Compra y ON x.Origen = y.Mov AND x.OrigenID = y.MovID
    JOIN CompraD z ON y.ID = z.ID
    JOIN Art g ON z.Articulo = g.Articulo
    JOIN MovTipo mt3 ON mt3.Mov = y.Mov AND mt3.Modulo = 'COMS' AND mt3.Clave IN ('COMS.F', 'COMS.FL', 'COMS.EG')

    JOIN Dinero e ON e.CtaDinero = a.DineroCtaDinero AND a.Dinero = e.Mov AND a.DineroID = e.MovID
    JOIN MovTipo mt2 ON mt2.Mov = e.Mov AND mt2.Modulo = 'DIN' AND mt2.Clave IN ('DIN.CH', 'DIN.CHE')
    JOIN Prov p ON a.Proveedor = p.Proveedor
    JOIN MovImpuesto m ON y.ID = m.ModuloID AND m.Modulo = 'COMS' AND ((ROUND(m.SubTotal, 2) = ROUND(y.Importe, 2)) OR (ROUND(m.SubTotal+m.Importe1+m.Importe2, 2) = ROUND(y.Importe, 2)))
  
	JOIN MovTipo mt4 ON mt4.Mov = b.Aplica AND mt4.Modulo = 'CXP' AND mt4.Clave IN ('CXP.AA','CXP.AF','CXP.D','CXP.DA','CXP.F')

   WHERE 
   
     --  b.Aplica IN('Deposito Arrendamien', 'Anticipo Saldo', 'Anticipo Factura', 'Intereses Devengados', 'Abono Intereses', 'Documento', 'Factura Proveedor', 'Documento Anticipo', 'Compra Activo Fijo',
     --              'Compra Local', 'Compra Software', 'Entrada Compra', 'Entrada con Gastos', 'Gasto', 'Gasto Anticipo', 'Gasto Diverso', 'Gasto Prorrateado') AND
					 
		 e.FechaConciliacion BETWEEN @FechaD AND @FechaA
     AND a.Estatus = 'CONCLUIDO'
     AND e.Estatus IN ('CONCILIADO', 'CONCLUIDO') --BUG 7890
     AND x.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND y.Estatus = 'CONCLUIDO'
     AND a.Empresa = @Empresa
     AND c.Empresa = @Empresa
     AND x.Empresa = @Empresa
     AND y.Empresa = @Empresa
     AND e.Empresa = @Empresa


  -- Endosos - Gasto
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,   RFC,   Nombre,   OrigenMov, OrigenMovID, TipoOperacion,   ModuloMov, ModuloMovID, Mov,   MovID,   Descripcion,
         Importe, Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IvaOExento, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, y.Acreedor, p.RFC, p.Nombre, y.Mov,     y.MovID,      g.TipoOperacion, x.Mov,     x.MovID,     a.Mov, a.MovID, z.Concepto, 
         Importe = (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) - (((CONVERT(float, z.Importe)/CONVERT(float, y.Importe)) * b.Importe) * ISNULL(h.IvaFiscal, 0))) * a.TipoCambio,
         Impuestos = (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * a.TipoCambio,
         Impuesto15 = CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * a.TipoCambio END, 
         Impuesto10 = CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * a.TipoCambio END, 
         ImpuestoValidar = CASE WHEN (ROUND(z.Impuestos/z.Importe, 2) <> 0.11) AND (ROUND(z.Impuestos/z.Importe, 2) <> 0.16) THEN (CASE WHEN ISNULL(y.Impuestos, 0) <> 0 THEN (((CONVERT(float, z.Impuestos)/CONVERT(float, y.Impuestos))) * ISNULL(h.IvaFiscal, 0)) * b.Importe ELSE 0 END) * a.TipoCambio END, 
         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN z.Impuestos * a.TipoCambio END) IS NULL) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN z.Impuestos * a.TipoCambio END) IS NULL)) THEN 'IVA 0%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.16 THEN z.Impuestos * a.TipoCambio END) IS NOT NULL) THEN 'IVA 16%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(z.Impuestos/z.Importe, 2) = 0.11 THEN z.Impuestos * a.TipoCambio END) IS NOT NULL) THEN 'IVA 11%'
                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END,
         z.PorcentajeDeducible
    FROM Cxp a
    JOIN CxpD b ON a.ID = b.ID
    JOIN MovTipo mt ON a.Mov = mt.Mov AND mt.Modulo = 'CXP' AND mt.Clave IN ('CXP.FAC', 'CXP.DAC')
    JOIN CxpAplica h ON b.Aplica = h.Mov AND b.AplicaID = h.MovID AND h.Empresa = @Empresa

    JOIN Cxp x ON b.Aplica = x.Mov AND b.AplicaID = x.MovID
    JOIN Gasto y ON x.Origen = y.Mov AND x.OrigenID = y.MovID
    JOIN GastoD z ON y.ID = z.ID
    JOIN Prov p ON y.Acreedor = p.Proveedor
    LEFT OUTER JOIN Concepto g ON z.Concepto = g.Concepto AND g.Modulo = 'GAS'
    JOIN MovTipo mt3 ON mt3.Mov = y.Mov AND mt3.Modulo = 'GAS' AND mt3.Clave = 'GAS.G'
   WHERE a.Estatus = 'CONCLUIDO'
     AND a.FechaEmision BETWEEN @FechaD AND @FechaA
     AND x.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND y.Estatus = 'CONCLUIDO'
     AND a.Empresa = @Empresa
     AND x.Empresa = @Empresa
     AND y.Empresa = @Empresa


  -- Endosos - Compra
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,   RFC,   Nombre,   OrigenMov, OrigenMovID, TipoOperacion,   ModuloMov, ModuloMovID, Mov,   MovID,   Descripcion, 
         Importe, Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IEPS20, IEPS25, IEPS30, IEPS50, IEPSCigarros, IEPSTabacos, IvaOExento, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, a.Proveedor, p.RFC, p.Nombre, y.Mov,     y.MovID,     'Otros',         x.Mov,     x.MovID,     a.Mov, a.MovID, RTRIM(z.Articulo)+' '+z.SubCuenta, 
         Importe = ((((b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) -
                   ISNULL(h.IVAFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0) -
                   ISNULL(h.IEPSFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0))) * a.TipoCambio),
         Impuestos = ISNULL((h.IVAFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / y.Importe)), 0) * a.TipoCambio,
         Impuesto15 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto1 = 16.0 THEN ISNULL(m.Importe1, 0) END)) * a.TipoCambio,
         Impuesto10 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto1 = 11.0 THEN ISNULL(m.Importe1, 0) END)) * a.TipoCambio,
         ImpuestoValidar = CASE WHEN (m.Impuesto1 <> 16.0) AND (m.Impuesto1 <> 11.0) THEN (((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * ISNULL(m.Importe1, 0) * a.TipoCambio END, 
         IEPS20 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 20.0 THEN ISNULL(m.Importe2, 0) END)) * a.TipoCambio,
         IEPS25 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 25.0 THEN ISNULL(m.Importe2, 0) END)) * a.TipoCambio,
         IEPS30 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 30.0 THEN ISNULL(m.Importe2, 0) END)) * a.TipoCambio,
         IEPS50 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 50.0 THEN ISNULL(m.Importe2, 0) END)) * a.TipoCambio,
         IEPSCigarros = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 100.0 THEN ISNULL(m.Importe2, 0) END)) * a.TipoCambio,
         IEPSTabacos  = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 20.9 THEN ISNULL(m.Importe2, 0) END)) * a.TipoCambio,
         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 =  0.0) THEN 'IVA 0%'
                           WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 = 16.0) THEN 'IVA 16%'
                           WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 = 11.0) THEN 'IVA 11%'
                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END, 100
    FROM Cxp a
    JOIN CxpD b ON a.ID = b.ID
    JOIN MovTipo mt ON a.Mov = mt.Mov AND mt.Modulo = 'CXP' AND mt.Clave IN ('CXP.NET')
    JOIN CxpAplica h ON b.Aplica = h.Mov AND b.AplicaID = h.MovID AND h.Empresa = @Empresa
    JOIN Prov p ON a.Proveedor = p.Proveedor

    JOIN Cxp x ON b.Aplica = x.Mov AND b.AplicaID = x.MovID
    JOIN Compra y ON x.Origen = y.Mov AND x.OrigenID = y.MovID
    JOIN CompraD z ON y.ID = z.ID
    JOIN Art g ON z.Articulo = g.Articulo
    JOIN MovTipo mt3 ON mt3.Mov = y.Mov AND mt3.Modulo = 'COMS' AND mt3.Clave = 'COMS.F'
    JOIN MovImpuesto m ON y.ID = m.ModuloID AND m.Modulo = 'COMS' AND ((ROUND(m.SubTotal, 2) = ROUND(y.Importe, 2)) OR (ROUND(m.SubTotal+m.Importe1+m.Importe2, 2) = ROUND(y.Importe, 2)))
   WHERE a.Estatus = 'CONCLUIDO'
     AND a.FechaEmision BETWEEN @FechaD AND @FechaA
     AND x.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND y.Estatus = 'CONCLUIDO'
     AND a.Empresa = @Empresa
     AND x.Empresa = @Empresa
     AND y.Empresa = @Empresa


  -- Gasto - Corte Caja, Comprobante, Cargo Bancario
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,     RFC,   Nombre,   Mov,   MovID,   TipoOperacion,   Descripcion, 
         Importe, Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IvaOExento, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, b.AcreedorRef, p.RFC, p.Nombre, a.Mov, a.MovID, g.TipoOperacion, b.Concepto,
         b.Importe*a.TipoCambio, b.Impuestos * a.TipoCambio,
         Impuesto15 = ISNULL(CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.16 THEN b.Impuestos * a.TipoCambio END, 0), 
         Impuesto10 = ISNULL(CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.11 THEN b.Impuestos * a.TipoCambio END, 0),
         ImpuestoValidar = CASE WHEN (ROUND(b.Impuestos/b.Importe, 2) <> 0.11) AND (ROUND(b.Impuestos/b.Importe, 2) <> 0.16) THEN b.Impuestos * a.TipoCambio END, 
         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.16 THEN b.Impuestos * a.TipoCambio END) IS NULL) AND ((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.11 THEN b.Impuestos * a.TipoCambio END) IS NULL)) THEN 'IVA 0%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.16 THEN b.Impuestos * a.TipoCambio END) IS NOT NULL) THEN 'IVA 16%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.11 THEN b.Impuestos * a.TipoCambio END) IS NOT NULL) THEN 'IVA 11%'
                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END,

         b.PorcentajeDeducible
    FROM Gasto a
    JOIN GastoD b ON a.ID = b.ID
    LEFT OUTER JOIN Concepto g ON b.Concepto = g.Concepto AND g.Modulo = 'GAS'
    JOIN Prov p ON p.Proveedor = b.AcreedorRef
    JOIN MovTipo mt ON mt.Mov = a.Mov AND mt.Modulo = 'GAS' AND mt.Clave IN ('GAS.CCH', 'GAS.C', 'GAS.CB')
   WHERE 
     --    a.Mov IN('Caja Chica', 'Comprobante', 'Cargo Bancario') AND
	     a.Estatus = 'CONCLUIDO'
     AND b.Fecha BETWEEN @FechaD AND @FechaA
     AND a.Empresa = @Empresa


  -- Gasto - Gasto T/Credito
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,     RFC,   Nombre,   Mov,   MovID,   TipoOperacion,   Descripcion,
         Importe, Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IvaOExento, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, b.AcreedorRef, p.RFC, p.Nombre, a.Mov, a.MovID, g.TipoOperacion, b.Concepto,
         b.Importe*a.TipoCambio, b.Impuestos * a.TipoCambio,
         Impuesto15 = ISNULL(CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.16 THEN b.Impuestos * a.TipoCambio END, 0), 
         Impuesto10 = ISNULL(CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.11 THEN b.Impuestos * a.TipoCambio END, 0),
         ImpuestoValidar = CASE WHEN (ROUND(b.Impuestos/b.Importe, 2) <> 0.11) AND (ROUND(b.Impuestos/b.Importe, 2) <> 0.16) THEN b.Impuestos * a.TipoCambio END, 
         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.16 THEN b.Impuestos * a.TipoCambio END) IS NULL) AND ((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.11 THEN b.Impuestos * a.TipoCambio END) IS NULL)) THEN 'IVA 0%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.16 THEN b.Impuestos * a.TipoCambio END) IS NOT NULL) THEN 'IVA 16%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.11 THEN b.Impuestos * a.TipoCambio END) IS NOT NULL) THEN 'IVA 11%'
                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END,
         b.PorcentajeDeducible
    FROM Gasto a
    JOIN GastoD b ON a.ID = b.ID
    LEFT OUTER JOIN Concepto g ON b.Concepto = g.Concepto AND g.Modulo = 'GAS'
    JOIN Prov p ON p.Proveedor = b.AcreedorRef
    JOIN MovTipo mt ON mt.Mov = a.Mov AND mt.Modulo = 'GAS' AND mt.Clave = 'GAS.GTC'
   WHERE 
     --  a.Mov = 'Gasto T/Credito' AND 
	     a.Estatus = 'CONCLUIDO'
     AND b.Fecha BETWEEN @FechaD AND @FechaA
     AND a.Empresa = @Empresa
     AND (SELECT ROUND(AVG(Pagado), 0) FROM PagadoAux WHERE ModuloID = a.ID) = 100.0


  -- Gasto - Ajustes
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,  RFC,   Nombre,   Mov,   MovID,   TipoOperacion,   Descripcion, 
         Importe, Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IvaOExento, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, a.Acreedor, p.RFC, p.Nombre, a.Mov, a.MovID, g.TipoOperacion, b.Concepto,
         b.Importe*a.TipoCambio, b.Impuestos * a.TipoCambio,
         Impuesto15 = ISNULL(CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.16 THEN b.Impuestos * a.TipoCambio END, 0), 
         Impuesto10 = ISNULL(CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.11 THEN b.Impuestos * a.TipoCambio END, 0),
         ImpuestoValidar = CASE WHEN (ROUND(b.Impuestos/b.Importe, 2) <> 0.11) AND (ROUND(b.Impuestos/b.Importe, 2) <> 0.16) THEN b.Impuestos * a.TipoCambio END, 
         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.16 THEN b.Impuestos * a.TipoCambio END) IS NULL) AND ((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.11 THEN b.Impuestos * a.TipoCambio END) IS NULL)) THEN 'IVA 0%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.16 THEN b.Impuestos * a.TipoCambio END) IS NOT NULL) THEN 'IVA 16%'
                           WHEN (g.Impuesto1Excento = 0) AND ((CASE WHEN ROUND(b.Impuestos/b.Importe, 2) = 0.11 THEN b.Impuestos * a.TipoCambio END) IS NOT NULL) THEN 'IVA 11%'
                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END,
         b.PorcentajeDeducible
    FROM Gasto a
    JOIN GastoD b ON a.ID = b.ID
    LEFT OUTER JOIN Concepto g ON b.Concepto = g.Concepto AND g.Modulo = 'GAS'
    JOIN Prov p ON p.Proveedor = a.Acreedor
    --JOIN MovTipo mt ON mt.Mov = a.Mov AND mt.Modulo = 'GAS' AND mt.Clave IN ('GAS.EST', 'GAS.CI') --BUG 18604
   WHERE    
       a.Mov = 'Ajustes Op. Terceros' AND --BUG 18604
	     a.Estatus = 'CONCLUIDO'
     AND a.FechaEmision BETWEEN @FechaD AND @FechaA
     AND a.Empresa = @Empresa


  -- Entrada Importación
  INSERT IVADeclaradoInicial (
         Estacion,  Empresa,   Proveedor,   RFC,   Nombre,   OrigenMov, OrigenMovID, TipoOperacion, ModuloMov, ModuloMovID, Mov,   MovID,   Descripcion,                       DestinoMov, DestinoMovID, FechaConciliacion, 
         Importe, Impuesto, Impuesto15, Impuesto10, ImpuestoValidar, IEPS20, IEPS25, IEPS30, IEPS50, IEPSCigarros, IEPSTabacos, IvaOExento, PorcentajeDeducible)
  SELECT @Estacion, a.Empresa, a.Proveedor, p.RFC, p.Nombre, y.Mov,     y.MovID,     'Otros',       x.Mov,     x.MovID,     a.Mov, a.MovID, RTRIM(z.Articulo)+' '+z.SubCuenta, e.Mov,      e.MovID,      e.FechaConciliacion, 
         Importe = ((((b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) -
                   ISNULL(h.IVAFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0) -
                   ISNULL(h.IEPSFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0))) * e.TipoCambio),
         Impuesto = (((((b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) -
                   ISNULL(h.IVAFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0) -
                   ISNULL(h.IEPSFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0))) * 0.16) * e.TipoCambio),
--         Impuesto = ISNULL((h.IVAFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / y.Importe)), 0) * e.TipoCambio,
         Impuesto15 = (((((b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) -
                   ISNULL(h.IVAFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0) -
                   ISNULL(h.IEPSFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0))) * 0.16) * e.TipoCambio),
--         Impuesto15 = ((b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * 0.16 ) * e.TipoCambio,
--         Impuesto15 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto1 = 15.0 THEN ISNULL(m.Importe1, 0) END)) * e.TipoCambio,
--         Impuesto10 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto1 = 10.0 THEN ISNULL(m.Importe1, 0) END)) * e.TipoCambio,
         Impuesto10 = (((((b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) -
                   ISNULL(h.IVAFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0) -
                   ISNULL(h.IEPSFiscal * (b.Importe * ((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)), 0))) * m.Impuesto1) * e.TipoCambio),
         ImpuestoValidar = CASE WHEN (m.Impuesto1 <> 16.0) AND (m.Impuesto1 <> 11.0) THEN (((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * ISNULL(m.Importe1, 0) * e.TipoCambio END, 
         IEPS20 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 20.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPS25 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 25.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPS30 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 30.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPS50 = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 50.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPSCigarros = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 100.0 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IEPSTabacos  = ((((z.Cantidad * z.Costo) - ISNULL(z.DescuentoImporte, 0)) / (y.Importe)) * (CASE WHEN m.Impuesto2 = 20.9 THEN ISNULL(m.Importe2, 0) END)) * e.TipoCambio,
         IvaOExento = 'IVA 16%', 100
--         IvaOExento = CASE WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 =  0.0) THEN 'IVA 0%'
--                           WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 = 16.0) THEN 'IVA 16%'
--                           WHEN (g.Impuesto1Excento = 0) AND (m.Impuesto1 = 11.0) THEN 'IVA 11%'
--                           WHEN (g.Impuesto1Excento = 1) THEN 'Exento' ELSE 'No Aplica' END, 100
    FROM Cxp a
    JOIN CxpD b ON a.ID = b.ID
    JOIN MovTipo mtx ON mtx.Mov = a.Mov AND mtx.Modulo = 'CXP' AND mtX.Clave = 'CXP.P'
    JOIN CxpAplica h ON b.Aplica = h.Mov AND b.AplicaID = h.MovID AND h.Empresa = @Empresa

    JOIN Dinero e ON e.CtaDinero = a.DineroCtaDinero AND a.Dinero = e.Mov AND a.DineroID = e.MovID
    JOIN MovTipo mt2 ON mt2.Mov = e.Mov AND mt2.Modulo = 'DIN' AND mt2.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.E')
    JOIN Prov p ON a.Proveedor = p.Proveedor

    JOIN Cxp x ON b.Aplica = x.Mov AND b.AplicaID = x.MovID
    JOIN Compra y ON x.Origen = y.Mov AND x.OrigenID = y.MovID
    JOIN CompraD z ON y.ID = z.ID
    JOIN Art g ON z.Articulo = g.Articulo
    JOIN MovTipo mt3 ON mt3.Mov = y.Mov AND mt3.Modulo = 'COMS' AND mt3.Clave IN ('COMS.EI')
    JOIN MovImpuesto m ON y.ID = m.ModuloID AND m.Modulo = 'COMS' AND ((ROUND(m.SubTotal, 2) = ROUND(y.Importe, 2)) OR (ROUND(m.SubTotal+m.Importe1+m.Importe2, 2) = ROUND(y.Importe, 2)))
   WHERE e.FechaConciliacion BETWEEN @FechaD AND @FechaA
     AND a.Estatus = 'CONCLUIDO'
     AND e.Estatus IN ('CONCILIADO', 'CONCLUIDO') --BUG 7890
     AND x.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND y.Estatus = 'CONCLUIDO'
     AND a.Empresa = @Empresa
     AND e.Empresa = @Empresa
     AND x.Empresa = @Empresa
     AND y.Empresa = @Empresa

  SELECT * FROM IVADeclaradoInicial WHERE Estacion = @Estacion ORDER BY Proveedor, Mov, MovID

END
GO



/**************** spCPReporte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCPReporte') and type = 'P') drop procedure dbo.spCPReporte
GO             
CREATE PROCEDURE spCPReporte
		@ID		    int,
		@Proy		varchar(50) = NULL,
		@Emp		char(5) = NULL,
		@ClaveDes	varchar(50) = NULL,
		@ClaveHas	varchar(50) = NULL,
		@FechaDes	datetime = NULL,
		@FechaHas	datetime = NULL,
		@Est	varchar(15) = NULL

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Movimiento							varchar(100),
    @Estatus							varchar(15),
    @Proyecto							varchar(50),
    @Moneda								varchar(50),
    @FechaEmision						varchar(10),
    @Empresa							varchar(5),
    @Usuario							varchar(10),
    @MovTipo							varchar(20),
    @EmpresaNombre						varchar(100),
    @Origen								varchar(100),
    @Concepto							varchar(100),
    @Referencia							varchar(100),
    @Observaciones						varchar(100),
    @Agente								varchar(100),
    @UEN								varchar(100),
	@Columna1							varchar(100),
	@Columna2							varchar(100),
	@Columna3							varchar(100),
	@Columna4							varchar(100),
	@Columna5							varchar(100),
	@Columna6							varchar(100),
	@Columna7							varchar(100),
	@Columna8							varchar(100),
	@Columna9							varchar(100),
	@Columna10							varchar(100),
	@Columna11							varchar(100),
	@Columna12							varchar(100),
	@Contador							int,
	@IDTabla							int,
	@ClaveD								varchar(50),
	@ClaveA								varchar(50)

    
  DECLARE @Tabla TABLE
  (
  ID				int IDENTITY,
  Tipo				varchar(20),
  Columna1			varchar(100),
  Columna2			varchar(100),
  Columna3			varchar(100),
  Columna4			varchar(100),
  Columna5			varchar(100),
  Columna6			varchar(100),
  Columna7			varchar(100),
  Columna8			varchar(100),
  Columna9			varchar(100),
  Columna10			varchar(100),
  Columna11			varchar(100),
  Columna12			varchar(100),
  Movimiento		varchar(100),
  Estatus			varchar(15),
  Proyecto			varchar(50),
  Moneda			varchar(50),
  FechaEmision		varchar(20),
  Usuario			varchar(10),
  MovTipo			varchar(20),
  EmpresaNombre		varchar(100),
  Origen			varchar(100),
  Concepto			varchar(100),
  Referencia		varchar(100),
  Observaciones		varchar(100),
  Agente			varchar(100),
  UEN				varchar(100),
  Empresa			varchar(100)
  )


  SELECT
    @Contador = 1,
    @Movimiento = ISNULL(c.Mov,'') + ' ' + ISNULL(c.MovID,''),
    @Estatus = CASE
                 WHEN c.Estatus = 'SINAFECTAR' THEN 'SIN AFECTAR' 
                 WHEN c.Estatus = 'PROCESAR'   THEN 'POR PROCESAR' 
                 WHEN c.Estatus IN ('BORRADOR','PENDIENTE','VIGENTE','CONCLUIDO','CANCELADO')   THEN c.Estatus                     
               END,
    @Proyecto = c.Proyecto,
    @Moneda = c.Moneda + CASE WHEN c.TipoCambio <> 1 AND c.TipoCambio IS NOT NULL THEN ': ' + CONVERT(varchar,ROUND(TipoCambio,2)) END,    
    @FechaEmision = CONVERT(varchar,c.FechaEmision,101),
    @Usuario = c.Usuario,
    @MovTipo = CASE WHEN @ID IS NULL THEN 'CP.OP' ELSE mt.Clave END,
    @EmpresaNombre = e.Nombre,
    @Origen = dbo.fnModuloNombre(c.origenTipo) + ' - ' + ISNULL(c.Origen,'') + ' ' + ISNULL(c.OrigenID,''),
    @Concepto = ISNULL(c.Concepto, ''),
    @Referencia = ISNULL(c.Referencia, ''),
    @Observaciones = ISNULL(c.Observaciones, ''),
    @Agente = ISNULL(a.Nombre, ''),
    @UEN = ISNULL(u.Nombre, '')
    FROM CP c JOIN MovTipo mt
      ON c.Mov = mt.Mov AND mt.Modulo = 'CP' JOIN Empresa e
      ON e.Empresa = c.Empresa LEFT OUTER JOIN Agente a
      ON c.Agente = a.Agente LEFT OUTER JOIN UEN u
      ON c.UEN = u.UEN
   WHERE c.ID = ISNULL(@ID, c.ID)

  IF @ClaveD = NULL
    SELECT @ClaveD = (SELECT MIN(ClavePresupuestal) FROM ClavePresupuestal)

  IF @ClaveA = NULL
    SELECT @ClaveA = (SELECT MAX(ClavePresupuestal) FROM ClavePresupuestal)

  INSERT @Tabla (Tipo, Columna1,               Columna2)
         VALUES ('A1', 'Control Presupuestal', @EmpresaNombre)

  INSERT @Tabla (Tipo, Columna1,    Columna2, Columna3,  Columna4, Columna5)
         VALUES ('A2', @Movimiento, @Estatus, @Proyecto, @Moneda,  @FechaEmision)

  IF NULLIF(@Origen,'') IS NOT NULL
    INSERT @Tabla (Tipo, Columna1,  Columna2)
           VALUES ('A3', 'Origen:',  @Origen)
         
  IF NULLIF(@Concepto,'') IS NOT NULL         
    INSERT @Tabla (Tipo, Columna1,   Columna2)
           VALUES ('A3', 'Concepto:', @Concepto)
  
  IF NULLIF(@Referencia,'') IS NOT NULL
    INSERT @Tabla (Tipo, Columna1,     Columna2)
           VALUES ('A3', 'Referencia:', @Referencia)

  IF NULLIF(@Observaciones,'') IS NOT NULL
    INSERT @Tabla (Tipo, Columna1,     Columna2)
           VALUES ('A3', 'Observaciones:', @Observaciones)

  IF NULLIF(@Agente,'') IS NOT NULL
    INSERT @Tabla (Tipo, Columna1, Columna2)
           VALUES ('A3', 'Agente:', @Agente)

  IF NULLIF(@UEN,'') IS NOT NULL
    INSERT @Tabla (Tipo, Columna1,  Columna2)
           VALUES ('A3', 'UEN:',		@UEN)

  
  IF @MovTipo IN ('CP.OP')
  BEGIN
    
    INSERT @Tabla (Tipo, Columna1, Columna2, Columna3, Columna4, Columna5, Columna6, Columna7, Columna8, Columna9, Columna10, Columna11, Columna12, Movimiento, Estatus, Proyecto, Moneda, FechaEmision, Usuario, MovTipo, EmpresaNombre, Origen, Concepto, Referencia, Observaciones, Agente, UEN, Empresa)
    SELECT
      'A4', 'Clave Presupuestal',
      CASE --Columna2
        WHEN (SELECT COUNT(ISNULL(Presupuesto, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Presupuesto, 0) <> 0) <> 0 THEN 'Presupuesto'
        WHEN (SELECT COUNT(ISNULL(Comprometido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Comprometido, 0) <> 0) <> 0 THEN 'Comprometido'
        WHEN (SELECT COUNT(ISNULL(Comprometido2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Comprometido2, 0) <> 0) <> 0 THEN 'Comprometido 2'
        WHEN (SELECT COUNT(ISNULL(Devengado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado, 0) <> 0) <> 0 THEN 'Devengado'
        WHEN (SELECT COUNT(ISNULL(Devengado2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado2, 0) <> 0) <> 0 THEN 'Devengado 2'
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN 'Ejercido'
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN 'Pagado'
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN 'Anticipos'
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN 'RemanenteDisp.'
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN 'Sobrante'
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN 'Disponible'        
      ELSE
        NULL
      END,
      CASE --Columna3
        WHEN (SELECT COUNT(ISNULL(Comprometido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Comprometido, 0) <> 0) <> 0 THEN 'Comprometido'
        WHEN (SELECT COUNT(ISNULL(Comprometido2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Comprometido2, 0) <> 0) <> 0 THEN 'Comprometido 2'
        WHEN (SELECT COUNT(ISNULL(Devengado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado, 0) <> 0) <> 0 THEN 'Devengado'
        WHEN (SELECT COUNT(ISNULL(Devengado2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado2, 0) <> 0) <> 0 THEN 'Devengado 2'
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN 'Ejercido'
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN 'Pagado'
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN 'Anticipos'
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN 'RemanenteDisp.'
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN 'Sobrante'
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN 'Disponible'
      ELSE
        NULL
      END,
      CASE --Columna4
        WHEN (SELECT COUNT(ISNULL(Comprometido2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Comprometido2, 0) <> 0) <> 0 THEN 'Comprometido 2'
        WHEN (SELECT COUNT(ISNULL(Devengado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado, 0) <> 0) <> 0 THEN 'Devengado'
        WHEN (SELECT COUNT(ISNULL(Devengado2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado2, 0) <> 0) <> 0 THEN 'Devengado 2'
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN 'Ejercido'
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN 'Pagado'
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN 'Anticipos'
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN 'RemanenteDisp.'
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN 'Sobrante'
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN 'Disponible'  
      ELSE
        NULL
      END,
      CASE --Columna5
        WHEN (SELECT COUNT(ISNULL(Devengado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado, 0) <> 0) <> 0 THEN 'Devengado'
        WHEN (SELECT COUNT(ISNULL(Devengado2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado2, 0) <> 0) <> 0 THEN 'Devengado 2'
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN 'Ejercido'
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN 'Pagado'        
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN 'Anticipos'
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN 'RemanenteDisp.'
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN 'Sobrante'
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN 'Disponible'  
      ELSE
        NULL
      END,
      CASE --Columna6
        WHEN (SELECT COUNT(ISNULL(Devengado2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado2, 0) <> 0) <> 0 THEN 'Devengado 2'
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN 'Ejercido'
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN 'Pagado'        
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN 'Anticipos'
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN 'RemanenteDisp.'
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN 'Sobrante'
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN 'Disponible'  
      ELSE
        NULL
      END,
      CASE --Columna7
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN 'Ejercido'
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN 'Pagado'        
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN 'Anticipos'
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN 'RemanenteDisp.'
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN 'Sobrante'
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN 'Disponible'  
      ELSE
        NULL
      END,
      CASE --Columna8
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN 'Pagado'        
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN 'Anticipos'
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN 'RemanenteDisp.'
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN 'Sobrante'
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN 'Disponible'  
      ELSE
        NULL
      END,
      CASE --Columna9
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN 'Anticipos'
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN 'RemanenteDisp.'
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN 'Sobrante'
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN 'Disponible'  
      ELSE
        NULL
      END,
      CASE --Columna10
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN 'RemanenteDisp.'
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN 'Sobrante'
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN 'Disponible'  
      ELSE
        NULL
      END,
      CASE --Columna11
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN 'Sobrante'
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN 'Disponible'  
      ELSE
        NULL
      END,
      CASE --Columna12
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN 'Disponible'  
      ELSE
        NULL
      END,
      'Movimiento', 'Estatus', 'Proyecto', 'Moneda', 'Fecha de Emision', 'Usuario', 'MovTipo', 'EmpresaNombre', 'Origen', 'Concepto', 'Referencia', 'Observaciones', 'Agente', 'UEN', 'Empresa'

    INSERT @Tabla (Tipo, Columna1, Columna2, Columna3, Columna4, Columna5, Columna6, Columna7, Columna8, Columna9, Columna10, Columna11, Columna12, Movimiento, Estatus, Proyecto, Moneda, FechaEmision, Usuario, MovTipo, EmpresaNombre, Origen, Concepto, Referencia, Observaciones, Agente, UEN, Empresa)
    SELECT
      'B1', d.ClavePresupuestal,
      CASE --Columna2
        WHEN (SELECT COUNT(ISNULL(Presupuesto, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Presupuesto, 0) <> 0) <> 0 THEN CASE WHEN ISNULL(d.Tipo, 'Ampliacion') = 'Ampliacion' THEN d.Presupuesto ELSE -d.Presupuesto END
        WHEN (SELECT COUNT(ISNULL(Comprometido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Comprometido, 0) <> 0) <> 0 THEN d.Comprometido
        WHEN (SELECT COUNT(ISNULL(Comprometido2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Comprometido2, 0) <> 0) <> 0 THEN d.Comprometido2
        WHEN (SELECT COUNT(ISNULL(Devengado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado, 0) <> 0) <> 0 THEN d.Devengado
        WHEN (SELECT COUNT(ISNULL(Devengado2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado2, 0) <> 0) <> 0 THEN d.Devengado2
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN d.Ejercido
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN d.EjercidoPagado
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN d.Anticipos
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN d.RemanenteDisponible
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN d.Sobrante
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN d.Disponible
      ELSE
        NULL
      END,
      CASE --Columna3
        WHEN (SELECT COUNT(ISNULL(Comprometido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Comprometido, 0) <> 0) <> 0 THEN d.Comprometido
        WHEN (SELECT COUNT(ISNULL(Comprometido2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Comprometido2, 0) <> 0) <> 0 THEN d.Comprometido2
        WHEN (SELECT COUNT(ISNULL(Devengado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado, 0) <> 0) <> 0 THEN d.Devengado
        WHEN (SELECT COUNT(ISNULL(Devengado2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado2, 0) <> 0) <> 0 THEN d.Devengado2
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN d.Ejercido
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN d.EjercidoPagado
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN d.Anticipos
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN d.RemanenteDisponible
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN d.Sobrante
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN d.Disponible  
      ELSE
        NULL
      END,
      CASE --Columna4
        WHEN (SELECT COUNT(ISNULL(Comprometido2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Comprometido2, 0) <> 0) <> 0 THEN d.Comprometido2
        WHEN (SELECT COUNT(ISNULL(Devengado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado, 0) <> 0) <> 0 THEN d.Devengado
        WHEN (SELECT COUNT(ISNULL(Devengado2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado2, 0) <> 0) <> 0 THEN d.Devengado2
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN d.Ejercido
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN d.EjercidoPagado
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN d.Anticipos
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN d.RemanenteDisponible
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN d.Sobrante
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN d.Disponible  
      ELSE
        NULL
      END,
      CASE --Columna5
        WHEN (SELECT COUNT(ISNULL(Devengado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado, 0) <> 0) <> 0 THEN d.Devengado
        WHEN (SELECT COUNT(ISNULL(Devengado2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado2, 0) <> 0) <> 0 THEN d.Devengado2
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN d.Ejercido
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN d.EjercidoPagado
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN d.Anticipos
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN d.RemanenteDisponible
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN d.Sobrante
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN d.Disponible  
      ELSE
        NULL
      END,
      CASE --Columna6
        WHEN (SELECT COUNT(ISNULL(Devengado2, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Devengado2, 0) <> 0) <> 0 THEN d.Devengado2
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN d.Ejercido
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN d.EjercidoPagado
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN d.Anticipos
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN d.RemanenteDisponible
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN d.Sobrante
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN d.Disponible  
      ELSE
        NULL
      END,
      CASE --Columna7
        WHEN (SELECT COUNT(ISNULL(Ejercido, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Ejercido, 0) <> 0) <> 0 THEN d.Ejercido
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN d.EjercidoPagado
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN d.Anticipos
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN d.RemanenteDisponible
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN d.Sobrante
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN d.Disponible  
      ELSE
        NULL
      END,
      CASE --Columna8
        WHEN (SELECT COUNT(ISNULL(EjercidoPagado, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(EjercidoPagado, 0) <> 0) <> 0 THEN d.EjercidoPagado
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN d.Anticipos
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN d.RemanenteDisponible
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN d.Sobrante
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN d.Disponible  
      ELSE
        NULL
      END,
      CASE --Columna9
        WHEN (SELECT COUNT(ISNULL(Anticipos, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Anticipos, 0) <> 0) <> 0 THEN d.Anticipos
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN d.RemanenteDisponible
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN d.Sobrante
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN d.Disponible  
      ELSE
        NULL
      END,
      CASE --Columna10
        WHEN (SELECT COUNT(ISNULL(RemanenteDisponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(RemanenteDisponible, 0) <> 0) <> 0 THEN d.RemanenteDisponible
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN d.Sobrante
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN d.Disponible  
      ELSE
        NULL
      END,
      CASE --Columna11
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN d.Sobrante
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN d.Disponible  
      ELSE
        NULL
      END,
      CASE --Columna12
        WHEN (SELECT COUNT(ISNULL(Sobrante, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Sobrante, 0) <> 0) <> 0 THEN d.Sobrante
        WHEN (SELECT COUNT(ISNULL(Disponible, 0)) FROM CPD WHERE ID = ISNULL(@ID, ID) AND ISNULL(Disponible, 0) <> 0) <> 0 THEN d.Disponible  
      ELSE
        NULL
      END,
      ISNULL(c.Mov,'') + ' ' + ISNULL(c.MovID,''), CASE WHEN c.Estatus = 'SINAFECTAR' THEN 'SIN AFECTAR' WHEN c.Estatus = 'PROCESAR'   THEN 'POR PROCESAR' WHEN c.Estatus IN ('BORRADOR','PENDIENTE','VIGENTE','CONCLUIDO','CANCELADO') THEN c.Estatus END, c.Proyecto, c.Moneda + CASE WHEN c.TipoCambio <> 1 AND c.TipoCambio IS NOT NULL THEN ': ' + CONVERT(varchar,ROUND(TipoCambio,2)) END, CONVERT(varchar,c.FechaEmision,101), c.Usuario, mt.Clave, e.Nombre, dbo.fnModuloNombre(c.origenTipo) + ' - ' + ISNULL(c.Origen,'') + ' ' + ISNULL(c.OrigenID,''), ISNULL(c.Concepto, ''), ISNULL(c.Referencia, ''), ISNULL(c.Observaciones, ''), ISNULL(a.Nombre, ''), ISNULL(u.Nombre, ''), c.Empresa
      FROM CPD d JOIN CP c
        ON c.ID = d.ID JOIN MovTipo mt
        ON c.Mov = mt.Mov AND mt.Modulo = 'CP' JOIN Empresa e
        ON e.Empresa = c.Empresa LEFT OUTER JOIN Agente a
        ON c.Agente = a.Agente LEFT OUTER JOIN UEN u
        ON c.UEN = u.UEN
     WHERE c.ID = ISNULL(@ID, c.ID)
       AND mt.Clave IN('CP.OP', 'CP.AS')
       AND ISNULL(c.Proyecto,'') = ISNULL(@Proy, ISNULL(c.Proyecto,''))
       AND ISNULL(c.Empresa,'') = ISNULL(@Emp, ISNULL(c.Empresa,''))
       AND d.ClavePresupuestal BETWEEN ISNULL(@ClaveDes, d.ClavePresupuestal) AND ISNULL(@ClaveHas, d.ClavePresupuestal)
       AND c.FechaEmision BETWEEN ISNULL(@FechaDes, c.FechaEmision) AND ISNULL(@FechaHas, c.FechaEmision)
       AND c.Estatus = ISNULL(@Est, c.Estatus)
     ORDER BY d.Renglon

    
    UPDATE @Tabla SET Tipo = 'B2' WHERE Tipo = 'B1'

    INSERT @Tabla(Columna1, Tipo, Columna2,                     Columna3,                     Columna4,                     Columna5,                     Columna6,                     Columna7,                     Columna8,                     Columna9,                     Columna10,                     Columna11,                     Columna12,                     Proyecto)
    SELECT        Columna1, 'B1', SUM(CONVERT(float,Columna2)), SUM(CONVERT(float,Columna3)), SUM(CONVERT(float,Columna4)), SUM(CONVERT(float,Columna5)), SUM(CONVERT(float,Columna6)), SUM(CONVERT(float,Columna7)), SUM(CONVERT(float,Columna8)), SUM(CONVERT(float,Columna9)), SUM(CONVERT(float,Columna10)), SUM(CONVERT(float,Columna11)), SUM(CONVERT(float,Columna12)), Proyecto
      FROM @Tabla
     WHERE Tipo = 'B2'
     GROUP BY Proyecto, Columna1
    
    DELETE @Tabla WHERE Tipo = 'B2'

    WHILE @Contador < 11
    BEGIN
      DECLARE crTabla CURSOR FOR
       SELECT Columna1, Columna2, Columna3, Columna4, Columna5, Columna6, Columna7, Columna8, Columna9, Columna10, Columna11, Columna12
         FROM @Tabla
        WHERE Tipo = 'A4'

      OPEN crTabla
      FETCH NEXT FROM crTabla INTO @Columna1, @Columna2, @Columna3, @Columna4, @Columna5, @Columna6, @Columna7, @Columna8, @Columna9, @Columna10, @Columna11, @Columna12
      WHILE @@FETCH_STATUS = 0
      BEGIN
  
        IF @Columna1 = @Columna2
          UPDATE @Tabla SET Columna1 = Columna2, Columna2 = Columna3, Columna3 = Columna4, Columna4 = Columna5, Columna5 = Columna6, Columna6 = Columna7, Columna7 = Columna8, Columna8 = Columna9, Columna9 = Columna10, Columna10 = Columna11, Columna11 = Columna12, Columna12 = NULL WHERE TIPO IN ('A4', 'B1')
        ELSE
        IF @Columna2 = @Columna3
          UPDATE @Tabla SET Columna2 = Columna3, Columna3 = Columna4, Columna4 = Columna5, Columna5 = Columna6, Columna6 = Columna7, Columna7 = Columna8, Columna8 = Columna9, Columna9 = Columna10, Columna10 = Columna11, Columna11 = Columna12, Columna12 = NULL WHERE TIPO IN ('A4', 'B1')
        ELSE
        IF @Columna3 = @Columna4
          UPDATE @Tabla SET Columna3 = Columna4, Columna4 = Columna5, Columna5 = Columna6, Columna6 = Columna7, Columna7 = Columna8, Columna8 = Columna9, Columna9 = Columna10, Columna10 = Columna11, Columna11 = Columna12, Columna12 = NULL WHERE TIPO IN ('A4', 'B1')
        ELSE
        IF @Columna4 = @Columna5
          UPDATE @Tabla SET Columna4 = Columna5, Columna5 = Columna6, Columna6 = Columna7, Columna7 = Columna8, Columna8 = Columna9, Columna9 = Columna10, Columna10 = Columna11, Columna11 = Columna12, Columna12 = NULL WHERE TIPO IN ('A4', 'B1')
        ELSE
        IF @Columna5 = @Columna6
          UPDATE @Tabla SET Columna5 = Columna6, Columna6 = Columna7, Columna7 = Columna8, Columna8 = Columna9, Columna9 = Columna10, Columna10 = Columna11, Columna11 = Columna12, Columna12 = NULL WHERE TIPO IN ('A4', 'B1')
        ELSE
        IF @Columna6 = @Columna7
          UPDATE @Tabla SET Columna6 = Columna7, Columna7 = Columna8, Columna8 = Columna9, Columna9 = Columna10, Columna10 = Columna11, Columna11 = Columna12, Columna12 = NULL WHERE TIPO IN ('A4', 'B1')
        ELSE
        IF @Columna7 = @Columna8
          UPDATE @Tabla SET Columna7 = Columna8, Columna8 = Columna9, Columna9 = Columna10, Columna10 = Columna11, Columna11 = Columna12, Columna12 = NULL WHERE TIPO IN ('A4', 'B1')
        ELSE
        IF @Columna8 = @Columna9
          UPDATE @Tabla SET Columna8 = Columna9, Columna9 = Columna10, Columna10 = Columna11, Columna11 = Columna12, Columna12 = NULL WHERE TIPO IN ('A4', 'B1')
        ELSE
        IF @Columna9 = @Columna10
          UPDATE @Tabla SET Columna9 = Columna10, Columna10 = Columna11, Columna11 = Columna12, Columna12 = NULL WHERE TIPO IN ('A4', 'B1')
        ELSE
        IF @Columna10 = @Columna11
          UPDATE @Tabla SET Columna10 = Columna11, Columna11 = Columna12, Columna12 = NULL WHERE TIPO IN ('A4', 'B1')
        ELSE
        IF @Columna11 = @Columna12
          UPDATE @Tabla SET Columna11 = Columna12, Columna12 = NULL WHERE TIPO IN ('A4', 'B1')
          
        SELECT @Contador = @Contador + 1
  
        FETCH NEXT FROM crTabla INTO @Columna1, @Columna2, @Columna3, @Columna4, @Columna5, @Columna6, @Columna7, @Columna8, @Columna9, @Columna10, @Columna11, @Columna12
      END
      CLOSE crTabla
      DEALLOCATE crTabla      
    END
    
    INSERT @Tabla (Tipo, Columna1, Columna2,																										Columna3,																										 Columna4,																										  Columna5,																										   Columna6,																										Columna7,																										 Columna8,																										  Columna9,																										   Columna10,																										  Columna11,                                                                                                         Columna12)
    SELECT         'C1', 'Total',  CASE WHEN ISNULL(SUM(CONVERT(money,Columna2)),0) <> 0 THEN ISNULL(SUM(CONVERT(money,Columna2)),0) ELSE NULL END, CASE WHEN ISNULL(SUM(CONVERT(money,Columna3)),0) <> 0 THEN ISNULL(SUM(CONVERT(money,Columna3)),0) ELSE NULL END, CASE WHEN ISNULL(SUM(CONVERT(money,Columna4)),0) <> 0 THEN ISNULL(SUM(CONVERT(money,Columna4)),0) ELSE NULL END, CASE WHEN ISNULL(SUM(CONVERT(money,Columna5)),0) <> 0 THEN ISNULL(SUM(CONVERT(money,Columna5)),0) ELSE NULL END, CASE WHEN ISNULL(SUM(CONVERT(money,Columna6)),0) <> 0 THEN ISNULL(SUM(CONVERT(money,Columna6)),0) ELSE NULL END, CASE WHEN ISNULL(SUM(CONVERT(money,Columna7)),0) <> 0 THEN ISNULL(SUM(CONVERT(money,Columna7)),0) ELSE NULL END, CASE WHEN ISNULL(SUM(CONVERT(money,Columna8)),0) <> 0 THEN ISNULL(SUM(CONVERT(money,Columna8)),0) ELSE NULL END, CASE WHEN ISNULL(SUM(CONVERT(money,Columna9)),0) <> 0 THEN ISNULL(SUM(CONVERT(money,Columna9)),0) ELSE NULL END, CASE WHEN ISNULL(SUM(CONVERT(money,Columna10)),0) <> 0 THEN ISNULL(SUM(CONVERT(money,Columna10)),0) ELSE NULL END, CASE WHEN ISNULL(SUM(CONVERT(money,Columna11)),0) <> 0 THEN ISNULL(SUM(CONVERT(money,Columna11)),0) ELSE NULL END, CASE WHEN ISNULL(SUM(CONVERT(money,Columna12)),0) <> 0 THEN ISNULL(SUM(CONVERT(money,Columna12)),0) ELSE NULL END
      FROM @Tabla
     WHERE Tipo = 'B1'

  END
  ELSE
  BEGIN
    INSERT @Tabla (Tipo, Columna1,             Columna3,     Columna4,    Columna5)
    SELECT         'A4', 'Clave Presupuestal', 'Ampliación', 'Reducción', 'Saldo'

    INSERT @Tabla (Tipo, Columna1,            Columna3,                                                     Columna4,                                                    Columna5)
    SELECT         'B1', d.ClavePresupuestal, CASE WHEN d.Tipo = 'Ampliación' THEN d.Importe ELSE 0.00 END, CASE WHEN d.Tipo = 'Reducción' THEN d.Importe ELSE 0.00 END, CASE WHEN d.Tipo = 'Ampliación' THEN d.Importe ELSE 0.00 END - CASE WHEN d.Tipo = 'Reducción' THEN d.Importe ELSE 0.00 END
      FROM CPD d JOIN CP c
        ON c.ID = d.ID
     WHERE c.ID = ISNULL(@ID, c.ID)
     ORDER BY d.Renglon

    INSERT @Tabla (Tipo, Columna1, Columna3,                               Columna4,                               Columna5)
    SELECT         'C1', 'Total',  ISNULL(SUM(CONVERT(money,Columna3)),0), ISNULL(SUM(CONVERT(money,Columna4)),0), ISNULL(SUM(CONVERT(money,Columna5)),0)
      FROM @Tabla
     WHERE Tipo = 'B1'
  
  END

  DECLARE crCampos CURSOR FOR
   SELECT ID, Columna2, Columna3, Columna4, Columna5, Columna6, Columna7, Columna8, Columna9, Columna10, Columna11, Columna12
     FROM @Tabla
    WHERE Tipo IN ('B1', 'C1')

  OPEN crCampos
  FETCH NEXT FROM crCampos INTO @IDTabla, @Columna2, @Columna3, @Columna4, @Columna5, @Columna6, @Columna7, @Columna8, @Columna9, @Columna10, @Columna11, @Columna12
  WHILE @@FETCH_STATUS = 0
  BEGIN

      UPDATE @Tabla 
         SET Columna2  = CASE WHEN @Columna2  IS NOT NULL AND @MovTipo = 'CP.OP' THEN (SELECT CONVERT(varchar, ISNULL(CONVERT(money,Columna2 ),0), 1) FROM @Tabla WHERE ID = @IDTabla) ELSE Columna2 END,
             Columna3  = CASE WHEN @Columna3  IS NOT NULL THEN (SELECT CONVERT(varchar, ISNULL(CONVERT(money,Columna3 ),0), 1) FROM @Tabla WHERE ID = @IDTabla) ELSE NULL END,
             Columna4  = CASE WHEN @Columna4  IS NOT NULL THEN (SELECT CONVERT(varchar, ISNULL(CONVERT(money,Columna4 ),0), 1) FROM @Tabla WHERE ID = @IDTabla) ELSE NULL END,
             Columna5  = CASE WHEN @Columna5  IS NOT NULL THEN (SELECT CONVERT(varchar, ISNULL(CONVERT(money,Columna5 ),0), 1) FROM @Tabla WHERE ID = @IDTabla) ELSE NULL END,
             Columna6  = CASE WHEN @Columna6  IS NOT NULL THEN (SELECT CONVERT(varchar, ISNULL(CONVERT(money,Columna6 ),0), 1) FROM @Tabla WHERE ID = @IDTabla) ELSE NULL END,
             Columna7  = CASE WHEN @Columna7  IS NOT NULL THEN (SELECT CONVERT(varchar, ISNULL(CONVERT(money,Columna7 ),0), 1) FROM @Tabla WHERE ID = @IDTabla) ELSE NULL END,
             Columna8  = CASE WHEN @Columna8  IS NOT NULL THEN (SELECT CONVERT(varchar, ISNULL(CONVERT(money,Columna8 ),0), 1) FROM @Tabla WHERE ID = @IDTabla) ELSE NULL END,
             Columna9  = CASE WHEN @Columna9  IS NOT NULL THEN (SELECT CONVERT(varchar, ISNULL(CONVERT(money,Columna9 ),0), 1) FROM @Tabla WHERE ID = @IDTabla) ELSE NULL END,
             Columna10 = CASE WHEN @Columna10 IS NOT NULL THEN (SELECT CONVERT(varchar, ISNULL(CONVERT(money,Columna10),0), 1) FROM @Tabla WHERE ID = @IDTabla) ELSE NULL END,
             Columna11 = CASE WHEN @Columna11 IS NOT NULL THEN (SELECT CONVERT(varchar, ISNULL(CONVERT(money,Columna11),0), 1) FROM @Tabla WHERE ID = @IDTabla) ELSE NULL END,
             Columna12 = CASE WHEN @Columna12 IS NOT NULL THEN (SELECT CONVERT(varchar, ISNULL(CONVERT(money,Columna12),0), 1) FROM @Tabla WHERE ID = @IDTabla) ELSE NULL END
       WHERE ID = @IDTabla

    FETCH NEXT FROM crCampos INTO @IDTabla, @Columna2, @Columna3, @Columna4, @Columna5, @Columna6, @Columna7, @Columna8, @Columna9, @Columna10, @Columna11, @Columna12
  END
  CLOSE crCampos
  DEALLOCATE crCampos      

      
  SELECT * FROM @Tabla ORDER BY Tipo         
END
GO

/**************** spRepSAUXDescargaInv  ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE ID = object_id('spRepSAUXDescargaInv') AND type = 'P') DROP PROCEDURE dbo.spRepSAUXDescargaInv
GO
CREATE PROCEDURE spRepSAUXDescargaInv
	     @Estaciontrabajo			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaD			datetime,
    @FechaA			datetime,
    @Estatus		varchar(15),
    @Empresa		char(5),
    @Servicio		varchar(50)

  SELECT
    @FechaD   = InfoFechaD,
    @FechaA   = InfoFechaA,
    @Estatus  = NULLIF(NULLIF(InfoEstatusEspecifico,'(Todos)'),''),
    @Empresa  = InfoEmpresa,
    @Servicio = NULLIF(NULLIF(InfoServicio,'(Todos)'),'')
    FROM RepParam
    WHERE Estacion = @Estaciontrabajo
  
  SELECT
    s.ID,
    s.Mov + ' ' + s.MovID MovOrigen,
    s.Estatus EstatusOrigen,
    s.FechaEmision FechaEmisionOrigen,
    i.Mov + ' ' + i.MovID Mov,
    i.FechaEmision,
    d.Servicio,
    d.Producto + ' ' + ISNULL(Art.Descripcion1,'') Producto,
    di.Articulo,
    m.Descripcion1,
    di.Cantidad,
    i.Estatus
    FROM SAUX s
    JOIN MovTipo mt ON s.Mov = mt.Mov AND mt.Modulo = 'SAUX'
    JOIN Inv i ON s.Mov = i.Origen AND s.MovID = i.OrigenID AND i.OrigenTipo = 'SAUX'
    JOIN MovTipo mti ON i.Mov = mti.Mov AND mti.Modulo = 'INV'
    JOIN InvD di ON i.ID = di.ID
    JOIN SAUXD d ON s.ID = d.ID
    JOIN SAUXServicio ss ON d.Servicio = ss.Servicio
    JOIN Art ON d.Producto = Art.Articulo
    JOIN Art m ON di.Articulo = m.Articulo
   WHERE mt.Clave IN('SAUX.SS', 'SAUX.S')
     AND s.Estatus in('PENDIENTE', 'CONCLUIDO')
     AND mti.Clave in('INV.SM', 'INV.CM')
     AND i.Estatus in('PENDIENTE', 'CONCLUIDO')
     AND s.FechaEmision BETWEEN @FechaD AND @FechaA
     AND s.Estatus = ISNULL(@Estatus, s.Estatus)
     AND s.Empresa = @Empresa
     AND d.Servicio = ISNULL(@Servicio, d.Servicio)
  
  RETURN 
END
GO

/**************** spRepSAUXIndicador  ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE ID = object_id('spRepSAUXIndicador') AND type = 'P') DROP PROCEDURE dbo.spRepSAUXIndicador
GO
CREATE PROCEDURE spRepSAUXIndicador
	     @Estaciontrabajo			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaD			datetime,
    @FechaA			datetime,
    @FechaReqD		datetime,
    @FechaReqA		datetime,
    @Estatus		varchar(15),
    @Empresa		char(5),
    @Servicio		varchar(50)

  SELECT
    @FechaD      =  InfoFechaD,
    @FechaA      =  InfoFechaA,
    @FechaReqD   = InfoFechaRequeridaD,
    @FechaReqA   = InfoFechaRequeridaA,    
    @Estatus     = NULLIF(NULLIF(InfoEstatusEspecifico,'(Todos)'),''),
    @Empresa     = InfoEmpresa,
    @Servicio    = NULLIF(NULLIF(InfoServicio,'(Todos)'),'')
    FROM RepParam
    WHERE Estacion = @Estaciontrabajo
  
  SELECT
    s.ID,
    s.Mov + ' ' + s.MovID Mov,
    s.Estatus,
    s.FechaEmision,
    s.TipoContacto,
    s.Contacto + ' ' + CASE s.TipoContacto
                       WHEN 'Cliente' THEN (SELECT Nombre FROM Cte WHERE Cliente = s.Contacto)
                       WHEN 'Proveedor' THEN (SELECT Nombre FROM Prov WHERE Proveedor = s.Contacto)
                       END Contacto,
    s.Observaciones,
    d.Producto + ' ' + a.Descripcion1 Producto,
    d.Servicio + ' ' + ss.Descripcion Servicio,
    d.FechaRequerida,
    sdi.Indicador,
    si.Descripcion,
    sdi.Valor,
    si.ParametroValido
    FROM SAUX s
    JOIN MovTipo mt ON s.Mov = mt.Mov AND mt.Modulo = 'SAUX'
    JOIN SAUXD d ON s.ID = d.ID
    JOIN Art a ON d.Producto = a.Articulo
    JOIN SAUXServicio ss ON d.Servicio = ss.Servicio
    JOIN SAUXDIndicador sdi ON d.ID = sdi.ID AND d.Renglon = sdi.Renglon AND d.Producto = sdi.Producto AND d.Servicio = sdi.Servicio
    JOIN SAUXIndicador si ON sdi.Indicador = si.Indicador
   WHERE mt.Clave IN('SAUX.S')
     AND s.Estatus in('CONCLUIDO', 'CANCELADO')
     AND s.FechaEmision BETWEEN @FechaD AND @FechaA
     AND d.FechaRequerida BETWEEN @FechaReqD AND @FechaReqA
     AND s.Estatus = ISNULL(@Estatus, s.Estatus)
     AND s.Empresa = @Empresa
     AND d.Servicio = ISNULL(@Servicio, d.Servicio)
  
  RETURN 
END
GO
