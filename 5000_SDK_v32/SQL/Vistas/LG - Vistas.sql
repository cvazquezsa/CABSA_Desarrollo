SET QUOTED_IDENTIFIER OFF
SET ANSI_NULLS OFF             
GO

--REQ12615 WMS
/***************** mis_EmbarqueAnalisisMov *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.mis_EmbarqueAnalisisMov') AND TYPE = 'V') DROP VIEW mis_EmbarqueAnalisisMov
GO
CREATE VIEW mis_EmbarqueAnalisisMov AS
SELECT
  Embarque.ID,
  Embarque.Empresa,
  EmbarqueMov = Embarque.Mov,
  EmbarqueMovID = Embarque.MovID,
  Embarque.FechaEmision,
  Embarque.Usuario,
  EmbarqueMoneda = Embarque.Moneda,
  Embarque.Autorizacion,
  Embarque.Concepto,
  Embarque.Referencia,
  Embarque.Observaciones,
  Embarque.Estatus,
  Embarque.Vehiculo,
  Embarque.Ruta,
  Embarque.Agente,
  Embarque.Peso,
  Embarque.Volumen,
  Embarque.Paquetes,
  Embarque.OrigenTipo,
  Embarque.Origen,
  Embarque.OrigenID,
  Embarque.Ejercicio,
  Embarque.Periodo,
  Embarque.FechaRegistro,
  Embarque.FechaConclusion,
  Embarque.FechaCancelacion,
  Embarque.FechaSalida,
  Embarque.FechaRetorno,
  Embarque.Proveedor,
  Embarque.Importe,
  Embarque.Impuestos,
  Embarque.Gastos,
  Embarque.Sucursal,
  Embarque.UEN,
  0 Orden,
  EmbarqueDEmbarqueMov = EmbarqueD.EmbarqueMov,
  EmbarqueDPaquetes = EmbarqueD.Paquetes,
  EmbarqueDObservaciones = EmbarqueD.Observaciones,
  EmbarqueD.Estado,
  EmbarqueD.FechaHora,
  EmbarqueD.Persona,
  EmbarqueD.PersonaID,
  EmbarqueD.Forma,
  EmbarqueDImporte = EmbarqueD.Importe,
  EmbarqueDReferencia = EmbarqueD.Referencia,
  EmbarqueDSucursal = EmbarqueD.Sucursal,
  EmbarqueD.Causa,
  EmbarqueMov.AsignadoID,
  EmbarqueMov.Accion,
  EmbarqueMov.Zona,
  EmbarqueMovRuta = EmbarqueMov.Ruta,
  EmbarqueMov.ZonaTipo,
  EmbarqueMov.OrdenEmbarque,
  EmbarqueMovEmpresa = EmbarqueMov.Empresa,
  EmbarqueMov.Modulo,
  EmbarqueMov.ModuloID,
  EmbarqueMovMov = EmbarqueMov.Mov,
  EmbarqueMovMovID = EmbarqueMov.MovID,
  EmbarqueMovFechaEmision = EmbarqueMov.FechaEmision,
  EmbarqueMov.MovReferencia,
  EmbarqueMov.MovObservaciones,
  EmbarqueMov.MovEstatus,
  EmbarqueMov.Almacen,
  EmbarqueMov.Cliente,
  EmbarqueMov.ClienteEnviarA,
  EmbarqueMovProveedor = EmbarqueMov.Proveedor,
  EmbarqueMov.AlmacenDestino,
  EmbarqueMovPeso = EmbarqueMov.Peso,
  EmbarqueMovVolumen = EmbarqueMov.Volumen,
  EmbarqueMovPaquetes = EmbarqueMov.Paquetes,
  EmbarqueMovImporte = EmbarqueMov.Importe,
  EmbarqueMovImpuestos = EmbarqueMov.Impuestos,
  EmbarqueMov.Moneda,
  EmbarqueMov.TipoCambio,
  EmbarqueMov.Condicion,
  EmbarqueMov.Vencimiento,
  EmbarqueMov.Nombre,
  EmbarqueMov.NombreEnvio,
  EmbarqueMovSucursal = EmbarqueMov.Sucursal,
  EmbarqueMovGastos = EmbarqueMov.Gastos,
  VehiculoVehiculo = Vehiculo.Vehiculo,
  Vehiculo.Descripcion,
  Vehiculo.Placas,
  VehiculoVolumen = Vehiculo.Volumen,
  VehiculoPeso = Vehiculo.Peso,
  VehiculoRuta = Vehiculo.Ruta,
  VehiculoEstatus = Vehiculo.Estatus,
  AgenteAgente = Agente.Agente,
  AgenteNombre = Agente.Nombre,
  AgenteEstatus = Agente.Estatus,
  Agente.Clase,
  Agente.BeneficiarioNombre,
  AgenteMoneda = Agente.Moneda,
  ProvProveedor = Prov.Proveedor,
  ProvNombre = Prov.Nombre,
  Prov.Tipo,
  ProvEstatus = Prov.Estatus,
  MovTipo.Clave,
  MovTipo.Factor,
  NULL Tarima,
  NULL Articulo,
  NULL Descripcion1,
  NULL Cantidad
FROM
  Embarque
  JOIN EmbarqueD ON Embarque.ID = EmbarqueD.ID
  JOIN EmbarqueMov ON EmbarqueD.EmbarqueMov = EmbarqueMov.ID
  JOIN Cte ON EmbarqueMov.Cliente = Cte.Cliente
  LEFT OUTER JOIN Vehiculo ON Embarque.Vehiculo = Vehiculo.Vehiculo 
  LEFT OUTER JOIN Agente ON Embarque.Agente = Agente.Agente AND Agente.Estatus = 'ALTA'
  LEFT OUTER JOIN Prov ON Embarque.Proveedor = Prov.Proveedor AND Prov.Estatus = 'ALTA'
  JOIN MovTipo ON Embarque.Mov = Movtipo.Mov
WHERE MovTipo.Modulo = 'EMB'
  AND MovTipo.Clave IN ('EMB.E', 'EMB.OC')
UNION ALL
SELECT
  Embarque.ID,
  Embarque.Empresa,
  EmbarqueMov = Embarque.Mov,
  EmbarqueMovID = Embarque.MovID,
  Embarque.FechaEmision,
  Embarque.Usuario,
  EmbarqueMoneda = Embarque.Moneda,
  Embarque.Autorizacion,
  Embarque.Concepto,
  Embarque.Referencia,
  Embarque.Observaciones,
  Embarque.Estatus,
  Embarque.Vehiculo,
  Embarque.Ruta,
  Embarque.Agente,
  Embarque.Peso,
  Embarque.Volumen,
  Embarque.Paquetes,
  Embarque.OrigenTipo,
  Embarque.Origen,
  Embarque.OrigenID,
  Embarque.Ejercicio,
  Embarque.Periodo,
  Embarque.FechaRegistro,
  Embarque.FechaConclusion,
  Embarque.FechaCancelacion,
  Embarque.FechaSalida,
  Embarque.FechaRetorno,
  Embarque.Proveedor,
  Embarque.Importe,
  Embarque.Impuestos,
  Embarque.Gastos,
  Embarque.Sucursal,
  Embarque.UEN,
  EmbarqueD.Orden,
  EmbarqueDEmbarqueMov = EmbarqueD.EmbarqueMov,
  EmbarqueDPaquetes = EmbarqueD.Paquetes,
  EmbarqueDObservaciones = EmbarqueD.Observaciones,
  EmbarqueD.Estado,
  EmbarqueD.FechaHora,
  EmbarqueD.Persona,
  EmbarqueD.PersonaID,
  EmbarqueD.Forma,
  EmbarqueDImporte = EmbarqueD.Importe,
  EmbarqueDReferencia = EmbarqueD.Referencia,
  EmbarqueDSucursal = EmbarqueD.Sucursal,
  EmbarqueD.Causa,
  EmbarqueMov.AsignadoID,
  EmbarqueMov.Accion,
  EmbarqueMov.Zona,
  EmbarqueMovRuta = EmbarqueMov.Ruta,
  EmbarqueMov.ZonaTipo,
  EmbarqueMov.OrdenEmbarque,
  EmbarqueMovEmpresa = EmbarqueMov.Empresa,
  EmbarqueMov.Modulo,
  EmbarqueMov.ModuloID,
  EmbarqueMovMov = EmbarqueMov.Mov,
  EmbarqueMovMovID = EmbarqueMov.MovID,
  EmbarqueMovFechaEmision = EmbarqueMov.FechaEmision,
  EmbarqueMov.MovReferencia,
  EmbarqueMov.MovObservaciones,
  EmbarqueMov.MovEstatus,
  EmbarqueMov.Almacen,
  EmbarqueMov.Cliente,
  EmbarqueMov.ClienteEnviarA,
  EmbarqueMovProveedor = EmbarqueMov.Proveedor,
  EmbarqueMov.AlmacenDestino,
  EmbarqueMovPeso = EmbarqueMov.Peso,
  EmbarqueMovVolumen = EmbarqueMov.Volumen,
  EmbarqueMovPaquetes = EmbarqueMov.Paquetes,
  EmbarqueMovImporte = EmbarqueMov.Importe,
  EmbarqueMovImpuestos = EmbarqueMov.Impuestos,
  EmbarqueMov.Moneda,
  EmbarqueMov.TipoCambio,
  EmbarqueMov.Condicion,
  EmbarqueMov.Vencimiento,
  EmbarqueMov.Nombre,
  EmbarqueMov.NombreEnvio,
  EmbarqueMovSucursal = EmbarqueMov.Sucursal,
  EmbarqueMovGastos = EmbarqueMov.Gastos,
  VehiculoVehiculo = Vehiculo.Vehiculo,
  Vehiculo.Descripcion,
  Vehiculo.Placas,
  VehiculoVolumen = Vehiculo.Volumen,
  VehiculoPeso = Vehiculo.Peso,
  VehiculoRuta = Vehiculo.Ruta,
  VehiculoEstatus = Vehiculo.Estatus,
  AgenteAgente = Agente.Agente,
  AgenteNombre = Agente.Nombre,
  AgenteEstatus = Agente.Estatus,
  Agente.Clase,
  Agente.BeneficiarioNombre,
  AgenteMoneda = Agente.Moneda,
  ProvProveedor = Prov.Proveedor,
  ProvNombre = Prov.Nombre,
  Prov.Tipo,
  ProvEstatus = Prov.Estatus,
  MovTipo.Clave,
  MovTipo.Factor,
  EmbarqueDArt.Tarima,
  Art.Articulo,
  Art.Descripcion1,
  EmbarqueDArt.Cantidad
FROM
  Embarque
  JOIN EmbarqueD ON Embarque.ID = EmbarqueD.ID
  JOIN EmbarqueMov ON EmbarqueD.EmbarqueMov = EmbarqueMov.ID
  JOIN Cte ON EmbarqueMov.Cliente = Cte.Cliente
  LEFT OUTER JOIN Vehiculo ON Embarque.Vehiculo = Vehiculo.Vehiculo 
  LEFT OUTER JOIN Agente ON Embarque.Agente = Agente.Agente AND Agente.Estatus = 'ALTA'
  LEFT OUTER JOIN Prov ON Embarque.Proveedor = Prov.Proveedor AND Prov.Estatus = 'ALTA'
  JOIN MovTipo ON Embarque.Mov = Movtipo.Mov
  JOIN EmbarqueDArt ON Embarque.ID = EmbarqueDArt.ID and EmbarqueD.EmbarqueMov = EmbarqueDArt.EmbarqueMov
  LEFT OUTER JOIN VentaD ON EmbarqueDArt.ModuloID=VentaD.ID AND EmbarqueDArt.Renglon=VentaD.Renglon AND EmbarqueDArt.RenglonSub=VentaD.RenglonSub AND EmbarqueDArt.Modulo = 'VTAS'
  LEFT OUTER JOIN CompraD ON EmbarqueDArt.ModuloID=CompraD.ID AND EmbarqueDArt.Renglon=CompraD.Renglon AND EmbarqueDArt.RenglonSub=CompraD.RenglonSub AND EmbarqueDArt.Modulo = 'COMS'
  JOIN Art ON ISNULL(VentaD.Articulo,CompraD.Articulo)=Art.Articulo
WHERE MovTipo.Modulo = 'EMB'
  AND MovTipo.Clave IN ('EMB.E', 'EMB.OC')
GO

/* mis_CompraTCalc */
if exists (select * from sysobjects where id = object_id('dbo.mis_CompraTCalc') and type = 'V') drop view dbo.mis_CompraTCalc
GO
CREATE VIEW mis_CompraTCalc
--//WITH ENCRYPTION
AS
  SELECT v.ID,
	 v.Sucursal,
	 v.Empresa,
	 v.Mov,
	 v.MovID,
	 m.Clave MovClave,
	 m.Factor,
	 v.Moneda,
	 v.TipoCambio,
	 v.Concepto,
	 v.Referencia,
	 v.Proyecto,
	 v.FechaEmision,
	 v.FechaRequerida,
	 v.Prioridad,
	 v.Estatus,
	 v.Situacion,
	 v.SituacionFecha,
	 v.SituacionUsuario,
	 v.SituacionNota,
	 v.Proveedor,
	 v.Agente,
	 v.FormaEnvio,
	 v.Condicion,
	 v.Vencimiento,
	 v.Usuario,
	 v.Observaciones,
	 v.Ejercicio,
	 v.Periodo,
	 v.Peso,
	 v.Volumen,
	 v.causa,
	 v.ZonaImpuesto,
	 v.FechaEntrega,
	 v.EmbarqueEstado,
	 v.FechaConclusion,
	 v.FechaRegistro,
	 d.Renglon,
	 d.RenglonSub,
	 d.RenglonID,
	 d.RenglonTipo,
	 d.ImportacionProveedor,
	 d.ImportacionReferencia,
	 d.Articulo,
	 d.SubCuenta,
	 d.Unidad,
	 d.Almacen,
	 d.Costo,
	 d.DescuentoTipo,
	 d.Impuesto1,
	 d.Impuesto2,
	 d.Impuesto3,
	 d.Cantidad,
	 d.Factor CompraFactor,
	 d.CantidadInventario,
	 d.CantidadNeta,
	 d.CantidadPendiente,
	 d.CantidadFactor,
	 d.PendienteFactor,
	 d.ImpuestosPorcentaje,
	 d.Importe,
	 d.DescuentoLineal,
	 "SubTotalInv"       = Convert(money, Convert(float, ROUND(d.CostoInv, dbo.fnRedondeoMonetarios()))*d.CantidadNeta),
	 "DescuentosTotales" = convert(money, ROUND((d.Importe*ISNULL(v.DescuentoGlobal, 0.0)/100), 2))+ISNULL(d.DescuentoLineal, 0.0),
	 "SubTotal"          = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100), 2)),
	 "Impuestos" 	     = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100) * (ImpuestosPorcentaje/100), 2)) + ISNULL(ImpuestosImporte, 0.0),
	 "ImporteTotal"      = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100) * (1+(ImpuestosPorcentaje/100)), 2))
    FROM Compra v
    JOIN CompraDCalc d ON v.ID = d.ID
    JOIN MovTipo m ON v.Mov = m.Mov 
   WHERE m.Modulo = 'COMS' 
     AND m.Clave IN ('COMS.F', 'COMS.D') 
GO

/* mis_spCompraComparativo */
if exists (select * from sysobjects where id = object_id('dbo.mis_spCompraComparativo') and type = 'P') drop procedure dbo.mis_spCompraComparativo
GO
CREATE PROCEDURE mis_spCompraComparativo
                 @Ejercicio	Int,
                 @Periodo	Int,
                 @ArticuloD	char(20),
                 @ArticuloA	char(20),
                 @Categoria	varchar(50),
                 @Grupo		varchar(50),
                 @Familia	varchar(50),
                 @Linea		varchar(50),
                 @Fabricante	varchar(50),
                 @Empresa	char(5)
--//WITH ENCRYPTION  
AS BEGIN
  DECLARE
    @EjercicioAnt	int,
    @FechaAnt		datetime,
    @MesAct		int,
    @MesAnt		int

  SELECT @EjercicioAnt = @Ejercicio - 1
  SELECT @MesAct = @Periodo
  SELECT @MesAnt = @Periodo

-- Articulos
  SELECT a.Articulo, a.Familia, a.Grupo,
         a.Categoria, a.Linea, a.Fabricante
    INTO #Artic
    FROM Art a
    JOIN mis_CompraTCalc b ON a.Articulo = b.Articulo
   WHERE b.MovClave IN('COMS.F', 'COMS.D')
     AND ((b.Ejercicio = @EjercicioAnt
     AND b.Periodo <= @Periodo) 
     OR (b.Ejercicio = @Ejercicio
     AND b.Periodo <= @Periodo))
     AND ISNULL(a.Categoria, '')  = CASE @Categoria  WHEN 'NULL' THEN ISNULL(a.Categoria, '')  ELSE @Categoria  END
     AND ISNULL(a.Grupo, '')      = CASE @Grupo      WHEN 'NULL' THEN ISNULL(a.Grupo, '')      ELSE @Grupo      END
     AND ISNULL(a.Familia, '')    = CASE @Familia    WHEN 'NULL' THEN ISNULL(a.Familia, '')    ELSE @Familia    END
     AND ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
   GROUP BY a.Articulo, a.Familia, a.Grupo, a.Categoria, a.Linea, a.Fabricante
   ORDER BY a.Articulo

-- Existencias
  SELECT a.Articulo,
         'Existencia' = Sum(b.Existencia)
    INTO #Exist 
    FROM Art a
    JOIN ArtExistenciaNeta b ON a.Articulo = b.Articulo
   WHERE ISNULL(a.Categoria, '')  = CASE @Categoria  WHEN 'NULL' THEN ISNULL(a.Categoria, '')  ELSE @Categoria  END
     AND ISNULL(a.Grupo, '')      = CASE @Grupo      WHEN 'NULL' THEN ISNULL(a.Grupo, '')      ELSE @Grupo      END
     AND ISNULL(a.Familia, '')    = CASE @Familia    WHEN 'NULL' THEN ISNULL(a.Familia, '')    ELSE @Familia    END
     AND ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Actual
  SELECT a.Articulo,
         'CantAct' = SUM(b.CantidadFactor)
    INTO #Actual
    FROM Art a
    JOIN mis_CompraTCalc b ON a.Articulo = b.Articulo  
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('COMS.F', 'COMS.D')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Categoria, '')  = CASE @Categoria  WHEN 'NULL' THEN ISNULL(a.Categoria, '')  ELSE @Categoria  END
     AND ISNULL(a.Grupo, '')      = CASE @Grupo      WHEN 'NULL' THEN ISNULL(a.Grupo, '')      ELSE @Grupo      END
     AND ISNULL(a.Familia, '')    = CASE @Familia    WHEN 'NULL' THEN ISNULL(a.Familia, '')    ELSE @Familia    END
     AND ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Mes Actual
  SELECT a.Articulo,
         'CantMAct' = SUM(b.CantidadFactor)
    INTO #ActualM
    FROM Art a
    JOIN mis_CompraTCalc b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('COMS.F', 'COMS.D')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Categoria, '')  = CASE @Categoria  WHEN 'NULL' THEN ISNULL(a.Categoria, '')  ELSE @Categoria  END
     AND ISNULL(a.Grupo, '')      = CASE @Grupo      WHEN 'NULL' THEN ISNULL(a.Grupo, '')      ELSE @Grupo      END
     AND ISNULL(a.Familia, '')    = CASE @Familia    WHEN 'NULL' THEN ISNULL(a.Familia, '')    ELSE @Familia    END
     AND ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Anterior
  SELECT a.Articulo,
         'CantAnt' = SUM(b.CantidadFactor)
    INTO #Anterior
    FROM Art a
    JOIN mis_CompraTCalc b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('COMS.F', 'COMS.D')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Categoria, '')  = CASE @Categoria  WHEN 'NULL' THEN ISNULL(a.Categoria, '')  ELSE @Categoria  END
     AND ISNULL(a.Grupo, '')      = CASE @Grupo      WHEN 'NULL' THEN ISNULL(a.Grupo, '')      ELSE @Grupo      END
     AND ISNULL(a.Familia, '')    = CASE @Familia    WHEN 'NULL' THEN ISNULL(a.Familia, '')    ELSE @Familia    END
     AND ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Mes Anterior
  SELECT a.Articulo,
         'CantMAnt' = SUM(b.CantidadFactor)
    INTO #AnteriorM
    FROM Art a
    JOIN mis_CompraTCalc b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('COMS.F', 'COMS.D')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Categoria, '')  = CASE @Categoria  WHEN 'NULL' THEN ISNULL(a.Categoria, '')  ELSE @Categoria  END
     AND ISNULL(a.Grupo, '')      = CASE @Grupo      WHEN 'NULL' THEN ISNULL(a.Grupo, '')      ELSE @Grupo      END
     AND ISNULL(a.Familia, '')    = CASE @Familia    WHEN 'NULL' THEN ISNULL(a.Familia, '')    ELSE @Familia    END
     AND ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Graba en Tabla de Resultados
  SELECT a.Articulo, a.Familia, a.Grupo, a.Categoria, a.Linea, a.Fabricante,
         'CantAct'  = CASE when CantAct  IS NULL THEN 0 ELSE CantAct  end,
         'CantMAct' = CASE when CantMAct IS NULL THEN 0 ELSE CantMAct end,
         'CantAnt'  = CASE when CantAnt  IS NULL THEN 0 ELSE CantAnt  end,
         'CantMAnt' = CASE when CantMAnt IS NULL THEN 0 ELSE CantMAnt end,
         'Existencia' = CASE when Existencia IS NULL THEN 0 ELSE Existencia end
    INTO #COMPARC
    FROM #Artic a
    LEFT OUTER JOIN #Exist b ON a.Articulo = b.Articulo
    LEFT OUTER JOIN #Actual c ON a.Articulo = c.Articulo
    LEFT OUTER JOIN #Anterior d ON a.Articulo = d.Articulo
    LEFT OUTER JOIN #ActualM e ON a.Articulo = e.Articulo
    LEFT OUTER JOIN #AnteriorM f ON a.Articulo = f.Articulo
   ORDER BY a.Articulo

--Despliega Información
    SELECT *  FROM #COMPARC
END
GO

/* mis_spCostosporRuta */
if exists (select * from sysobjects where id = object_id('dbo.mis_spCostosporRuta') and type = 'P') drop procedure dbo.mis_spCostosporRuta
GO
CREATE PROCEDURE mis_spCostosporRuta
		@ArticuloD		Char(20),
        @ArticuloA		Char(20),
		@Categoria		VarChar(50),
		@Grupo			VarChar(50),
		@Familia		VarChar(50),
		@Linea			VarChar(50),
		@Fabricante		VarChar(50),
		@Ruta			Char(20),
		@Moneda			Char(10),
		@CentroD		Char(10),
		@CentroA		Char(10)
--//WITH ENCRYPTION
AS BEGIN
  Declare
        @RutaA		char(20),
        @RutaB		char(20),
        @Articulo	char(20)

  CREATE TABLE #CostospRuta
 (
     Lugar		char(1)		COLLATE Database_Default NULL,
     Ruta		char(20)	COLLATE Database_Default NULL,
     RutaAlt		char(20)	COLLATE Database_Default NULL,
     Articulo		char(20)	COLLATE Database_Default NULL, 
     Material		char(20)	COLLATE Database_Default NULL,
     Cantidad		float(8)	NULL, 
     Unidad		varchar(50)	COLLATE Database_Default NULL, 
     CostoAcumulado	money		NULL, 
     Moneda		char(10)	COLLATE Database_Default NULL, 
     TipoCambio		float(8)	NULL, 
     CostoEstandar	money		NULL, 
     Centro 		char(10)	COLLATE Database_Default NULL, 
     MObra		money		NULL, 
     Indirec		money		NULL
)

  -- Agrega Costos de Materiales
  INSERT #CostospRuta
  SELECT DISTINCT '1', a.ProdRuta, NULL, a.Articulo, d.Material, d.Cantidad, d.Unidad, d.CostoAcumulado,
         b.Moneda, e.TipoCambio,
         CostoEstandar = (SELECT f.CostoEstandar FROM Art f WHERE f.Articulo = d.Material), NULL, NULL, NULL
    FROM Art a
    JOIN ProdRutaD b ON a.ProdRuta = b.Ruta
    JOIN ArtMaterial d ON a.Articulo = d.Articulo  
    JOIN Mon e ON b.Moneda = e.Moneda
   WHERE a.SeProduce = 1
     AND a.Estatus = 'ALTA'
     AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND ISNULL(a.Categoria,' ')  = CASE @Categoria  WHEN 'NULL' THEN ISNULL(a.Categoria,' ')  ELSE @Categoria  END
     AND ISNULL(a.Grupo,' ')      = CASE @Grupo      WHEN 'NULL' THEN ISNULL(a.Grupo,' ')      ELSE @Grupo      END
     AND ISNULL(a.Familia,' ')    = CASE @Familia    WHEN 'NULL' THEN ISNULL(a.Familia,' ')    ELSE @Familia    END
     AND ISNULL(a.Linea,' ')      = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea,' ')      ELSE @Linea      END
     AND ISNULL(a.Fabricante,' ') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante,' ') ELSE @Fabricante END
     AND ISNULL(b.Moneda,' ')     = CASE @Moneda     WHEN 'NULL' THEN ISNULL(b.Moneda,' ')     ELSE @Moneda     END
     AND ISNULL(a.ProdRuta,' ')   = CASE @Ruta       WHEN 'NULL' THEN ISNULL(a.ProdRuta,' ')   ELSE @Ruta       END
     AND b.Centro BETWEEN @CentroD AND @CentroA
   ORDER BY a.Articulo, d.Material, a.ProdRuta

  -- Agrega Costos de Mano de Obra e Indirectos por Centro de Trabajo a la Ruta
  INSERT #CostospRuta
  SELECT '2', a.ProdRuta, NULL, a.Articulo, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b.Centro, 
         MObra = ((((b.TiempoFijo + b.TiempoVariable) * c.CostoManoObra) + b.Costo) * e.TipoCambio),
         Indirec = (((b.TiempoFijo + b.TiempoVariable) * c.CostoIndirectos) * e.TipoCambio)
    FROM Art a
    JOIN ProdRutaD b ON a.ProdRuta = b.Ruta
    JOIN Centro c ON b.Centro = c.Centro
    JOIN Mon e ON b.Moneda = e.Moneda
   WHERE a.SeProduce = 1
     AND a.Estatus = 'ALTA'
     AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND ISNULL(a.Categoria,' ')  = CASE @Categoria  WHEN 'NULL' THEN ISNULL(a.Categoria,' ')  ELSE @Categoria  END
     AND ISNULL(a.Grupo,' ')      = CASE @Grupo      WHEN 'NULL' THEN ISNULL(a.Grupo,' ')      ELSE @Grupo      END
     AND ISNULL(a.Familia,' ')    = CASE @Familia    WHEN 'NULL' THEN ISNULL(a.Familia,' ')    ELSE @Familia    END
     AND ISNULL(a.Linea,' ')      = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea,' ')      ELSE @Linea      END
     AND ISNULL(a.Fabricante,' ') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante,' ') ELSE @Fabricante END
     AND ISNULL(b.Moneda,' ')     = CASE @Moneda     WHEN 'NULL' THEN ISNULL(b.Moneda,' ')     ELSE @Moneda     END
     AND ISNULL(a.ProdRuta,' ')   = CASE @Ruta       WHEN 'NULL' THEN ISNULL(a.ProdRuta,' ')   ELSE @Ruta       END
     AND b.Centro BETWEEN @CentroD AND @CentroA
   ORDER BY a.Articulo, a.ProdRuta, b.Centro

 DECLARE cRuta CURSOR FOR
  SELECT DISTINCT r.Ruta, s.RutaAlterna, c.Articulo
   FROM ProdRutaAlterna s
   JOIN ProdRutaD r ON s.Ruta = r.Ruta 
   JOIN Art c ON s.Ruta = c.ProdRuta
  WHERE c.Articulo BETWEEN @ArticuloD AND @ArticuloA
   OPEN cRuta
   FETCH NEXT FROM cRuta
   INTO @RutaA, @RutaB, @Articulo
   WHILE @@FETCH_STATUS = 0
   BEGIN 
     INSERT #CostospRuta
     SELECT '2', @RutaB, 'Alterna', @Articulo, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b.Centro, 
            MObra = ((((b.TiempoFijo + b.TiempoVariable) * c.CostoManoObra) + b.Costo) * e.TipoCambio),
            Indirec = (((b.TiempoFijo + b.TiempoVariable) * c.CostoIndirectos) * e.TipoCambio)
       FROM ProdRutaD b
       JOIN Centro c ON b.Centro = c.Centro
       JOIN Mon e ON b.Moneda = e.Moneda
      WHERE b.Ruta = @RutaB
        AND b.Centro BETWEEN @CentroD AND @CentroA
     FETCH NEXT FROM cRuta
      INTO @RutaA, @RutaB, @Articulo
   END
   CLOSE cRuta
   DEALLOCATE cRuta

  --Despliega Información
  SELECT * FROM #CostospRuta
  ORDER BY Articulo, Lugar, Ruta, Centro
END
GO

/* mis_spVentaCumplimiento */
if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaCumplimiento') and type = 'P') drop procedure dbo.mis_spVentaCumplimiento
GO
CREATE PROCEDURE mis_spVentaCumplimiento
                 @ClienteD	char(10),
                 @ClienteA	char(10),
                 @FechaD	DateTime,
                 @FechaA	DateTime,
                 @Categoria	varchar(50),
                 @Familia	varchar(50),
                 @Grupo		varchar(50),
                 @Sucursal 	Int,
                 @Empresa	char(5)
--//WITH ENCRYPTION		    
AS BEGIN
--  DECLARE


-- Pedidos
  SELECT MovP = a.Mov, MovIDP = a.MovID, a.Cliente, a.Agente, CantP = Sum(b.Cantidad), FechaP = a.FechaEmision,
         a.FechaRequerida, a.Sucursal
    INTO #CPedido
    FROM Venta a
    JOIN VentaD b ON a.ID = b.ID
    JOIN Cte c ON a.Cliente = c.Cliente
   WHERE a.Estatus IN('Pendiente', 'Concluido')
     AND a.Mov Like 'Pedido%'
     AND a.Cliente BETWEEN @ClienteD AND @ClienteA
     AND a.FechaEmision BETWEEN @FechaD AND @FechaA
     AND ISNULL(c.Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(c.Categoria, '') ELSE @Categoria END
     AND ISNULL(c.Grupo, '')     = CASE @Grupo     WHEN 'NULL' THEN ISNULL(c.Grupo, '')     ELSE @Grupo     END
     AND ISNULL(c.Familia, '')   = CASE @Familia   WHEN 'NULL' THEN ISNULL(c.Familia, '')   ELSE @Familia   END
     AND a.Sucursal = CASE ISNULL(convert(char(10), @Sucursal), ' ') WHEN ' ' THEN a.Sucursal ELSE @Sucursal END
     AND a.Empresa = @Empresa 
   GROUP BY a.Mov, a.MovID, a.Cliente, a.Agente, a.FechaEmision, a.FechaRequerida, a.Sucursal
   ORDER BY a.MovID, a.FechaEmision

-- Facturas
  SELECT OrigF = a.Origen, OrigIDF = a.OrigenID, AplicaF = b.Aplica, AplicaIDF = b.AplicaID, 
         MovF = a.Mov, MovIDF = a.MovID, CantF = Sum(b.Cantidad), FechaF = a.FechaEmision
    INTO #CFactura
    FROM Venta a
    JOIN VentaD b ON a.ID = b.ID
    JOIN #CPedido c ON b.Aplica = MovP AND b.AplicaID = MovIDP
   WHERE a.Mov Like 'Factura%'
     AND a.Estatus IN('Pendiente', 'Concluido')
   GROUP BY a.Origen, a.OrigenID, b.Aplica, b.AplicaID, a.Mov, a.MovID, a.FechaEmision
   ORDER BY a.OrigenID

 -- Embarques
  SELECT MovEm = a.Mov, MovIDE= a.MovID, FechaE = a.FechaEmision,
         OrigE = c.Mov, OrigIDE = c.MovID, Orig2E = d.Mov, Orig2IDE = d.MovID, 
         CantE = b.Paquetes
    INTO #CEmbarque
    FROM Embarque a
    JOIN EmbarqueMov b ON a.ID = b.AsignadoID
    JOIN Venta c ON b.Mov = c.Mov AND b.MovID = c.MovID
    JOIN Venta d ON d.Mov = c.Origen AND d.MovID = c.OrigenID
    JOIN #CFactura f ON b.Mov = MovF AND b.MovID = MovIDF
   WHERE a.Estatus IN ('Pendiente', 'Concluido')
     AND a.Mov like 'Embarque%'
   ORDER BY a.MovID

  CREATE TABLE #Cumplim
 (
     MovP		char(20)	COLLATE Database_Default NULL,
     MovIDP		varchar(20)	COLLATE Database_Default NULL,
     Cliente		char(10)	COLLATE Database_Default NULL,
     Agente		char(10)	COLLATE Database_Default NULL,
     CantP		Float(8)	NULL,
     FechaP		DateTime	NULL,
     FechaRequerida	DateTime	NULL,
     OrigF		char(20)	COLLATE Database_Default NULL,
     OrigIDF		Varchar(20)	COLLATE Database_Default NULL,
     MovF		char(20)	COLLATE Database_Default NULL,
     MovIDF		varchar(20)	COLLATE Database_Default NULL,
     CantF		Float(8)	NULL,
     FechaF		DateTime	NULL,
     MovEm		char(20)	COLLATE Database_Default NULL,
     MovIDE		varchar(20)	COLLATE Database_Default NULL,
     FechaE		DateTime	NULL,
     OrigE		char(20)	COLLATE Database_Default NULL,
     OrigIDE		varchar(20)	COLLATE Database_Default NULL,
     CantE		Float(8)	NULL,
     DiasOper		int		NULL,
     DiasFac		int		NULL,
     Suc		Int		NULL
)

-- Graba en Tabla de Resultados con Embarques
  INSERT #Cumplim
  SELECT MovP,  MovIDP,  a.Cliente, a.Agente, CantP, FechaP, a.FechaRequerida,
         OrigF, OrigIDF, MovF, MovIDF, CantF, FechaF,
         MovEm, MovIDE, FechaE, OrigE, OrigIDE, CantE,
         DiasOper = Convert(int,FechaE - FechaP),
         DiasFac = Convert(int,FechaF - FechaP), a.Sucursal
    FROM #CPedido a
    JOIN #CFactura d ON MovP = OrigF AND MovIDP = OrigIDF 
    LEFT OUTER JOIN #CEmbarque f ON MovF = OrigE AND MovIDF = OrigIDE 
   ORDER BY MovIDP

--Despliega Información
  SELECT *  FROM #Cumplim
  ORDER BY Cliente, Suc, MovIDP, FechaP
END
GO


/* mis_spCompraCumplimiento */
if exists (select * from sysobjects where id = object_id('dbo.mis_spCompraCumplimiento') and type = 'P') drop procedure dbo.mis_spCompraCumplimiento
GO
CREATE PROCEDURE mis_spCompraCumplimiento
                 @ProveedorD	char(10),
                 @ProveedorA	char(10),
                 @FechaD	DateTime,
                 @FechaA	DateTime,
                 @Categoria	varchar(50),
                 @Familia	varchar(50),
                 @Empresa	char(5)
--//WITH ENCRYPTION		    
AS BEGIN
--  DECLARE

  -- Ordenes de Compra
  SELECT MovO = a.Mov, MovIDO = a.MovID, a.Proveedor, c.Nombre, CantO = Sum(b.Cantidad), FechaO = a.FechaEmision,
         a.FechaRequerida
    INTO #COrden
    FROM Compra a
    JOIN CompraD b ON a.ID = b.ID
    JOIN Prov c ON a.Proveedor = c.Proveedor
   WHERE a.Estatus IN('Pendiente', 'Concluido')
     AND a.Mov Like 'Orden Compra%'
     AND a.Proveedor BETWEEN @ProveedorD AND @ProveedorA
     AND a.FechaEmision BETWEEN @FechaD AND @FechaA
     AND ISNULL(c.Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(c.Categoria, '') ELSE @Categoria END
     AND ISNULL(c.Familia, '')   = CASE @Familia   WHEN 'NULL' THEN ISNULL(c.Familia, '')   ELSE @Familia   END
     AND a.Empresa = @Empresa 
   GROUP BY a.Mov, a.MovID, a.Proveedor, c.Nombre, a.FechaEmision, a.FechaRequerida
   ORDER BY a.MovID, a.FechaEmision

  -- Entradas de Compra
  SELECT OrigE = a.Origen, OrigIDE = a.OrigenID, MovEn = a.Mov, MovIDE = a.MovID, 
         CantE = Sum(b.Cantidad), FechaE = a.FechaEmision
    INTO #CEntrada
    FROM Compra a
    JOIN CompraD b ON a.ID = b.ID
    JOIN MovTipo c ON a.Mov = c.Mov
    JOIN MovTipo d ON a.Origen = d.Mov
   WHERE c.Modulo = 'COMS'
     AND c.Clave = 'COMS.F'
     AND d.Modulo = 'COMS'
     AND d.Clave = 'COMS.O'
     AND a.Estatus IN('Pendiente', 'Concluido')
   GROUP BY a.Origen, a.OrigenID, a.Mov, a.MovID, a.FechaEmision
   ORDER BY a.OrigenID

-- Graba en Tabla de Resultados
  SELECT MovO, MovIDO, a.Proveedor, a.Nombre, CantO, FechaO, FechaRequerida,
         OrigE, OrigIDE, MovEn, MovIDE, CantE, FechaE,
         DiasOper = Convert(int,FechaE - FechaO)
    INTO #CumplimC
    FROM #COrden a
    JOIN #CEntrada b ON MovO = OrigE 
     AND MovIDO = OrigIDE
   ORDER BY MovIDO

--Despliega Información
  SELECT * FROM #CumplimC
  ORDER BY Proveedor, MovIDO, FechaO
END
GO

/* mis_spInteresesNoCobrados */
if exists (select * from sysobjects where id = object_id('dbo.mis_spInteresesNoCobrados') and type = 'P') drop procedure dbo.mis_spInteresesNoCobrados
GO
CREATE PROCEDURE mis_spInteresesNoCobrados
		    @FechaD		DateTime,
            @FechaA		DateTime,
            @ClienteD	char(10),
            @ClienteA	char(10),
		    @CteCat		varchar(50),
		    @CteGrupo	varchar(50),
		    @CteFam		varchar(50),
            @Moneda		char(10),
            @Usuario	char(10),
            @Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN

  CREATE TABLE #InteresesNC
 (
     Empresa		char(5)		COLLATE Database_Default NULL,
     CxcMoratoriosTasa	Float(8)	NULL,
     FechaEmision	DateTime	NULL,
     Vencimiento	DateTime	NULL,
     Impor		money		NULL,
     Estatus		char(15)	COLLATE Database_Default NULL,
     Cliente		char(10)	COLLATE Database_Default NULL,
     CliNom		varchar(100)	COLLATE Database_Default NULL, 
     Categoria		varchar(50)	COLLATE Database_Default NULL,
     Grupo		varchar(50)	COLLATE Database_Default NULL,
     Familia		varchar(50)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     Usuariocxc		char(10)	COLLATE Database_Default NULL,
     Mov1		char(20)	COLLATE Database_Default NULL,
     MovID1		varchar(20)	COLLATE Database_Default NULL,
     FechaEmis1		DateTime	NULL,
     Importe		money		NULL,
     Condicion		varchar(50)	COLLATE Database_Default NULL,
     Moneda		char(10)	COLLATE Database_Default NULL,
     DiasIntereses 	int		NULL,
     RecargosSugeridos	money		NULL,
     RecargosReales 	money		NULL,
     Sucursal		int		NULL,
     SucNom		varchar(100)	COLLATE Database_Default NULL  
)

  INSERT #InteresesNC
  SELECT e.Empresa, e.CxcMoratoriosTasa,
	 c.FechaEmision, c.Vencimiento, 'Impor' = c.Importe + c.Impuestos, c.Estatus, 
         Cte = c.Cliente, 'CliNom' = ct.Nombre, ct.Categoria, ct.Grupo, ct.Familia, 
         c.Mov, c.MovID, c1.Usuario, 'Mov1' = c1.Mov, 'MovID1' = c1.MovID, FechaEmis1 = c1.FechaEmision, 
         c1.Importe, c1.Condicion, c.Moneda,
         DiasIntereses = Convert(int,c1.Fechaemision - c.Vencimiento),
         RecargosSugeridos = (c.Importe + c.Impuestos) * (Convert(int,c1.Fechaemision - c.Vencimiento) * (e.CxcMoratoriosTasa /100)),
         RecargosReales = c1.Importe - (c.Importe + c.Impuestos),
         c.ClienteEnviarA, 'SucNom' = s.Nombre
    FROM EmpresaCFG e
    JOIN Cxc c ON e.Empresa = c.Empresa
    JOIN Cxc c1 ON c.Mov = c1.Origen AND c.MovID = c1.OrigenID
    LEFT OUTER JOIN CteEnviarA s ON c.Cliente = s.Cliente AND c.ClienteEnviarA = s.ID
    JOIN Cte ct ON c.Cliente = ct.Cliente
    JOIN MovTipo d ON c.Mov = d.Mov
    JOIN MovTipo f ON c1.Mov = f.Mov
   WHERE e.Empresa = @Empresa
     AND d.Modulo = 'CXC'
     AND d.Clave = 'CXC.F'
     AND f.Modulo = 'CXC'
     AND f.Clave = 'CXC.C'
     AND c.OrigenTipo = 'VTAS'
     AND c1.OrigenTipo = 'CXC'
     AND c.Condicion not in ('CONTADO')
     AND c.Estatus = 'Concluido'
     AND c1.Estatus = 'Concluido'
     AND ct.DescuentoRecargos = 1
     AND c1.Fechaemision - c.Vencimiento > 0
     AND c.Vencimiento BETWEEN @FechaD AND @FechaA
     AND ct.Cliente BETWEEN @ClienteD AND @ClienteA
     AND ISNULL(ct.Categoria,'') = CASE @CteCat    WHEN 'NULL' THEN ISNULL(ct.Categoria,'') ELSE @CteCat   END
     AND ISNULL(ct.Grupo,'')     = CASE @CteGrupo  WHEN 'NULL' THEN ISNULL(ct.Grupo,'')     ELSE @CteGrupo END
     AND ISNULL(ct.Familia,'')   = CASE @CteFam    WHEN 'NULL' THEN ISNULL(ct.Familia,'')   ELSE @CteFam   END
     AND ISNULL(c.Moneda,'')     = CASE @Moneda    WHEN 'NULL' THEN ISNULL(c.Moneda,'')     ELSE @Moneda   END
     AND ISNULL(c1.Usuario,'')     = CASE @Usuario WHEN 'NULL' THEN ISNULL(c1.Usuario,'')   ELSE @Usuario  END
   ORDER BY c1.Usuario, c.Moneda, c.Cliente, c.ClienteEnviarA, c.Vencimiento

  INSERT #InteresesNC
  SELECT e.Empresa, e.CxcMoratoriosTasa,
	 c.FechaEmision, c.Vencimiento, 'Impor' = c.Importe + c.Impuestos, c.Estatus, 
         Cte = c.Cliente, 'CliNom' = ct.Nombre, ct.Categoria, ct.Grupo, ct.Familia, 
         cd.Aplica, cd.AplicaID, c1.Usuario, 'Mov1' = c1.Mov, 'MovID1' = c1.MovID, FechaEmis1 = c1.FechaEmision, 
         cd.Importe, c1.Condicion, c.Moneda,
         DiasIntereses = Convert(int,c1.Fechaemision - c.Vencimiento),
         RecargosSugeridos = (c.Importe + c.Impuestos) * (Convert(int,c1.Fechaemision - c.Vencimiento) * (e.CxcMoratoriosTasa /100)),
         RecargosReales = cd.Importe - (c.Importe + c.Impuestos),
         c.ClienteEnviarA, 'SucNom' = s.Nombre
    FROM EmpresaCFG e
    JOIN Cxc c ON e.Empresa = c.Empresa
    JOIN CxcD cd ON c.Mov = cd.Aplica AND c.MovID = cd.AplicaID
    JOIN Cte ct ON c.Cliente = ct.Cliente
    JOIN Cxc c1 ON cd.ID = c1.ID  
    LEFT OUTER JOIN CteEnviarA s ON c.Cliente = s.Cliente AND c.ClienteEnviarA = s.ID
    JOIN MovTipo d ON c.Mov = d.Mov
    JOIN MovTipo f ON c1.Mov = f.Mov
   WHERE e.Empresa = @Empresa
     AND d.Modulo = 'CXC'
     AND d.Clave = 'CXC.F'
     AND f.Modulo = 'CXC'
     AND f.Clave = 'CXC.C'
     AND ISNULL(c.OrigenTipo, '') = ''
     AND c.Condicion not in ('CONTADO')
     AND c.Estatus = 'Concluido'
     AND c1.Estatus = 'Concluido'
     AND ct.DescuentoRecargos = 1
     AND c1.Fechaemision - c.Vencimiento > 0
     AND c.Vencimiento BETWEEN @FechaD AND @FechaA
     AND ct.Cliente BETWEEN @ClienteD AND @ClienteA
     AND ISNULL(ct.Categoria,'') = CASE @CteCat   WHEN 'NULL' THEN ISNULL(ct.Categoria,'') ELSE @CteCat   END
     AND ISNULL(ct.Grupo,'')     = CASE @CteGrupo WHEN 'NULL' THEN ISNULL(ct.Grupo,'')     ELSE @CteGrupo END
     AND ISNULL(ct.Familia,'')   = CASE @CteFam   WHEN 'NULL' THEN ISNULL(ct.Familia,'')   ELSE @CteFam   END
     AND ISNULL(c.Moneda,'')     = CASE @Moneda   WHEN 'NULL' THEN ISNULL(c.Moneda,'')     ELSE @Moneda   END
     AND ISNULL(c1.Usuario,'')   = CASE @Usuario  WHEN 'NULL' THEN ISNULL(c1.Usuario,'')   ELSE @Usuario  END
   ORDER BY c1.Usuario, c.Moneda, c.Cliente, c.ClienteEnviarA, c.Vencimiento

  --Despliega Información
  SELECT * FROM #InteresesNC
   ORDER BY UsuarioCxc, Moneda, Categoria, Cliente, Sucursal, Vencimiento
END
GO

/* mis_spListaMat */
if exists (select * from sysobjects where id = object_id('dbo.mis_spListaMat') and type = 'P') drop procedure dbo.mis_spListaMat
GO
CREATE PROCEDURE mis_spListaMat
		    @Articulo		char(20),
            @Empresa		char(5)
--//WITH ENCRYPTION
AS BEGIN
  CREATE TABLE #ListaM
 (
  Lugar			char(1)		COLLATE Database_Default NULL,
  ArtMArticulo		char(20)	COLLATE Database_Default NULL,
  OrdenID		int		NULL,
  SiOpcion		varchar(100)	COLLATE Database_Default NULL,
  Material		char(20)	COLLATE Database_Default NULL,
  SubCuenta		varchar(50)	COLLATE Database_Default NULL,
  Cantidad		float		NULL,
  Unidad		varchar(50)	COLLATE Database_Default NULL,
  Merma			float(8)	NULL,
  Desperdicio		float(8)	NULL,
  Almacen		char(10)	NULL,
  CentroTipo		varchar(20)	COLLATE Database_Default NULL,
  CostoAcumulado	money		NULL,
  Orden			int		NULL,
  Porcentaje		float(8)	NULL,
  ArtArticulo		char(20)	COLLATE Database_Default NULL,
  ArtDescripcion1	varchar(100)	COLLATE Database_Default NULL,
  ArtCategoria		varchar(50)	COLLATE Database_Default NULL,
  ArtFamilia		varchar(50)	COLLATE Database_Default NULL,
  ArtFabricante		varchar(50)	COLLATE Database_Default NULL,
  ArtLinea		varchar(50)	COLLATE Database_Default NULL,
  ArtUnidad		varchar(50)	COLLATE Database_Default NULL,
  ArtUnidadCompra	varchar(50)	COLLATE Database_Default NULL,
  ArtTipo		varchar(20)	COLLATE Database_Default NULL,
  ArtTipoOpcion		varchar(20)	COLLATE Database_Default NULL,
  ArtEstatus		char(15)	NULL,
  ArtMensaje		varchar(50)	COLLATE Database_Default NULL,
  ArtCategoriaProd	varchar(50)	COLLATE Database_Default NULL,
  ArtProdPasoTotal	int		NULL,
  ArtMerma		float(8)	NULL,
  ArtDesperdicio	float(8)	NULL,
  ArtSeVende		bit		NULL,
  ArtSeCompra		bit		NULL,
  ArtSeProduce		bit		NULL,
  ArtEsFormula		bit		NULL,
  ArtCostoEstandar	money		NULL,
  ArtCostoCostoPromedio	money		NULL,
  ArtCostoUltimoCosto	money		NULL
)

  INSERT #ListaM
  SELECT '1', ArtMaterial.Articulo, ArtMaterial.OrdenID, ArtMaterial.SiOpcion,
         ArtMaterial.Material, ArtMaterial.SubCuenta, ArtMaterial.Cantidad, ArtMaterial.Unidad,
         ArtMaterial.Merma, ArtMaterial.Desperdicio, ArtMaterial.Almacen, ArtMaterial.CentroTipo,
         ArtMaterial.CostoAcumulado, ArtMaterial.Orden, ArtMaterial.Porcentaje,
         Art.Articulo, Art.Descripcion1, Art.Categoria, Art.Familia, Art.Fabricante, Art.Linea,
         Art.Unidad, Art.UnidadCompra, Art.Tipo, Art.TipoOpcion, Art.Estatus, Art.Mensaje,
         Art.CategoriaProd, Art.ProdPasoTotal, Art.Merma, Art.Desperdicio, Art.SeVende,
         Art.SeCompra, Art.SeProduce, Art.EsFormula, Art.CostoEstandar, ArtCosto.CostoPromedio,
         ArtCosto.UltimoCosto
    FROM ArtMaterial
    JOIN Art ON ArtMaterial.Material=Art.Articulo
    LEFT OUTER JOIN ArtCosto ON ArtMaterial.Material = ArtCosto.Articulo AND ArtCosto.Empresa = @Empresa
   WHERE ArtMaterial.Articulo = @Articulo
   ORDER BY ArtMaterial.Articulo

  INSERT #ListaM
  SELECT '2', ArtMaterial.Articulo, ArtMaterial.OrdenID, ArtMaterial.SiOpcion, ArtMaterial.Material,
         ArtMaterial.SubCuenta, ArtMaterial.Cantidad, ArtMaterial.Unidad, ArtMaterial.Merma, ArtMaterial.Desperdicio,
         ArtMaterial.Almacen, ArtMaterial.CentroTipo, ArtMaterial.CostoAcumulado, ArtMaterial.Orden, 
         ArtMaterial.Porcentaje, Producto.Articulo, Producto.Descripcion1, Producto.Categoria, Producto.Familia, 
         Producto.Fabricante, Producto.Linea, Producto.Unidad, Producto.UnidadCompra, Producto.Tipo, 
         Producto.TipoOpcion, Producto.Estatus, Producto.Mensaje, Producto.CategoriaProd, 
         Producto.ProdPasoTotal, Producto.Merma, Producto.Desperdicio, Producto.SeVende, Producto.SeCompra, 
         Producto.SeProduce, Producto.EsFormula, Producto.CostoEstandar, ArtCosto.CostoPromedio,
         ArtCosto.UltimoCosto
    FROM ArtMaterial
    JOIN Art Producto ON ArtMaterial.Articulo=Producto.Articulo
    LEFT OUTER JOIN ArtCosto ON ArtMaterial.Articulo = ArtCosto.Articulo AND ArtCosto.Empresa = @Empresa
   WHERE ArtMaterial.Material = @Articulo
   ORDER BY ArtMaterial.Articulo

--Despliega Información
  SELECT * FROM #ListaM
   ORDER BY ArtMArticulo, Lugar, Material
END
GO

/* mis_SpRHDispMag */
If exists(select * from sysobjects where id=object_id('dbo.mis_spRHDispMag') and Type ='p') drop procedure dbo.mis_spRHDispMag
GO
CREATE PROCEDURE mis_spRHDispMag (@Mov varchar(20), @FechaD DateTime, @FechaA DateTime) 
--//WITH ENCRYPTION
AS BEGIN
  
  DECLARE @MovRegPatronal VARCHAR(50)
  
  IF @Mov = 'BAJAS'
	SET @MovRegPatronal = 'Baja Reg. Patronal'
  ELSE IF @Mov = 'ALTAS'
	SET @MovRegPatronal = 'Alta Reg. Patronal'
  ELSE
  	SET @MovRegPatronal = ''
    	
  	
  SELECT 
    (SELECT COUNT(personal.personal)
       FROM RH
       JOIN RHD ON RH.ID = RHD.ID  
       JOIN Personal ON RHD.Personal = Personal.Personal
       JOIN PersonalPropValor ON Personal.SucursalTrabajo = PersonalPropvalor.Cuenta 
      WHERE RH.Estatus='Concluido' 
        AND Rama='SUC'   
        AND PersonalPropValor.Propiedad='Registro Patronal'
        AND RH.Mov IN (@Mov, @MovRegPatronal)
        AND RH.Concepto = CASE @Mov WHEN 'Modificaciones' THEN 'Sueldo' ELSE RH.Concepto END
        AND RH.FechaEmision BETWEEN @FechaD AND @FechaA 
    ) Cuantos,
    ISNULL(PersonalPropValor.Valor,'') RegistroPatonal ,
    ISNULL(Personal.Registro3,'') IMSS ,  
    ISNULL(Personal.ApellidoPaterno,'') ApellidoPaterno ,
    ISNULL(Personal.ApellidoMaterno,'') ApellidoMaterno,
    ISNULL(Personal.Nombre,'') Nombre,ISNULL(Personal.Madre,'') Madre,ISNULL(Personal.Padre,'') Padre,
    ISNULL(Personal.SDI,0)*100 SDI ,ISNULL(Personal.SDIAnterior,0)*100 SDIAnterior,
    ISNULL(Personal.SucursalTrabajo,'') SucursalTrabajo,Personal.puesto,
    TipoTrabajador=Case Personal.TipoContrato WHEN 'Trab. Permanente'  THEN '1'
                                              WHEN 'Trab. Ev. Ciudad'  THEN '2'
                                              WHEN 'Trab. Ev. Constrn' THEN '3'
                                              WHEN 'Eventual'          THEN '2'
                                              WHEN 'Construccion'      THEN '3'    
                                              WHEN 'Permanente'        THEN '1'    
                                              ELSE '1'
                   END,
    TipoSueldo=Case Personal.TipoSueldo WHEN 'Fijo'     THEN '0'
                                        WHEN 'Variable' THEN '1'
                                        WHEN 'Mixto'    THEN '2'
                                        ELSE '0'
               END,
    Jornada = Case Personal.Jornada WHEN 'Horario Completo' THEN '0'
                                    WHEN 'Un Dia' THEN           '1'
                                    WHEN 'Dos Dias' THEN         '2'
                                    WHEN 'Tres Dias' THEN        '3'
                                    WHEN 'Cuatro Dias' THEN      '4'
                                    WHEN 'Cinco Dias' THEN       '5'
                                    WHEN 'Jornada Reducida' THEN '6'
                                    ELSE  '0'
              END,
    RIGHT('0'+LTRIM(DATEPART(dd,rh.FechaEmision)),2)+RIGHT('0'+LTRIM(DATEPART(mm,rh.FechaEmision)),2)+LTRIM(DATEPART(yyyy,rh.FechaEmision)) FechaEmision,
    UnidadMedica,
    rh.Mov,
    TipoMovimiento = CASE RH.Mov    WHEN 'Modificaciones'		THEN '07'
                                    WHEN 'Altas'				THEN '08'
                                    WHEN 'Bajas'				THEN '02'
                                    WHEN 'Alta Reg. Patronal'	THEN '08'
									WHEN 'Baja Reg. Patronal'	THEN '02'
                     END,
    Personal.Personal,
    Sexo = CASE Personal.Sexo
                WHEN 'MASCULINO' THEN '1'
                WHEN 'FEMENINO'  THEN '2'
                ELSE  '1'  
                END,
    CausaBaja = CASE RH.Concepto
                       WHEN 'Termino de Contrato' THEN '1'
                       WHEN 'Separ. Voluntaria'   THEN '2'
                       WHEN 'Abandono de Empleo'  THEN '3'
                       WHEN 'Defuncion'           THEN '4'
                       WHEN 'Clausura'            THEN '5'
                       WHEN 'Otras'               THEN '6'
                       ELSE '1'
                END,
    Personal.Registro Curp
   FROM RH
   JOIN RHD ON RH.ID = RHD.ID  
   JOIN Personal ON RHD.Personal = Personal.Personal
   JOIN PersonalPropValor ON Personal.SucursalTrabajo = PersonalPropvalor.Cuenta 
  WHERE RH.Estatus='Concluido' 
    AND Rama='SUC'   
    AND PersonalPropValor.Propiedad='Registro Patronal'
    AND RH.Mov IN (@Mov, @MovRegPatronal)
    AND RH.Concepto = CASE @Mov WHEN 'Modificaciones' THEN 'Sueldo' ELSE RH.Concepto END
    AND RH.FechaEmision BETWEEN @FechaD AND @FechaA 
END
GO


/**************** fnPrecioReal ****************/
if exists (select * from sysobjects where id = object_id('dbo.fnPrecioReal') and type = 'FN') 
  drop function dbo.fnPrecioReal
GO
CREATE FUNCTION dbo.fnPrecioReal (@Precio money, @Imp1 float, @Imp2 float, @Imp3 money, @Imp2Info bit, @Imp3Info bit, @ImpIncluido bit)
RETURNS money
--//WITH ENCRYPTION
AS BEGIN
  --- Bug 23518 Se requiere esta función para el procedimiento mis_spUtilidadArticulos
  --- Bugs 23763, 23764, 23765, 23766 Se requiere esta función para el procedimiento mis_spUtilidadAlmacenes (...Agentes, ...Cllientes, ...Sucursales, ...UEN(?))

  DECLARE @Prec money

  SELECT @Imp1 = ISNULL(@Imp1, 0), @Imp2 = ISNULL(@Imp2, 0), @Imp3 = ISNULL(@Imp3, 0), @Imp2Info = ISNULL(@Imp2Info, 0), @Imp3Info = ISNULL(@Imp3Info, 0)

  SELECT @Prec = @Precio

  IF @ImpIncluido = 1 BEGIN
    IF @Imp3Info = 1 BEGIN
      SELECT @Prec = @Precio / (1+(@Imp1/100))
      IF @Imp2Info = 0
        SELECT @Prec = @PREC / (1+(@Imp2/100))
    END ELSE BEGIN
      SELECT @Prec = (@Precio - @Imp3) / (1+(@Imp1/100))
      IF @Imp2Info = 0
        SELECT @Prec = @Prec / (1+(@Imp2/100))
    END
  END

  RETURN @Prec
END
GO


/* mis_spUtilidadAgentes */
if exists (select * from sysobjects where id = object_id('dbo.mis_spUtilidadAgentes') and type = 'P') drop procedure dbo.mis_spUtilidadAgentes
GO
CREATE PROCEDURE mis_spUtilidadAgentes
		    @Empresa		char(5),
		    @AgenteD		char(10),
		    @AgenteA		char(10),
            @FechaD			DateTime,
            @FechaA			DateTime,
            @Desglosar		Char(2)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@VPrecioImpInc		Bit,
	@PrecioImp		money,
	@PreciosinImp		money,
	--- Bugs 23763, 23764, 23765, 23766 Se agregan las 2 líneas siguientes
	@Imp2Info         bit,
	@Imp3Info         bit

  SELECT @VPrecioImpInc = VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa

  --- Bugs 23763, 23764, 23765, 23766 Se agrega la línea siguiente
  SELECT @Imp2Info = ISNULL(Impuesto2Info, 0), @Imp3Info = ISNULL(Impuesto3Info, 0) FROM Version 


  SELECT VentaUtilD.MovClave,
         VentaUtilD.Agente,
         Agente.Nombre,
         DescuentoGlobal = (VentaUtilD.DescuentoGlobal),
         ---Importe = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         Importe = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         CostoTotal = VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
         CantidadFactor = (VentaUtilD.CantidadFactor),
         FactorV = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                             WHEN 'VTAS.B' THEN -1.0
                                             ELSE 1.0 END ),
         CantidadNeta = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                WHEN 'VTAS.B' THEN -1.0
                                                                                ELSE 1.0  END),
         ---ImporteBruto = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         ImporteBruto = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         ---ImporteNeto = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         ImporteNeto = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                    WHEN 'VTAS.B' THEN -1.0
                                                                                    ELSE 1.0 END)),
         CostoNeto = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                  WHEN 'VTAS.B' THEN -1.0
                                                                                                  ELSE 1.0 END)),
         ComisionNeta = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                                   ELSE 1.0 END)), 
         ---Utilidad = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         Utilidad = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                         WHEN 'VTAS.B' THEN -1.0
                                                                                                         ELSE 1.0 END))  -     
                    ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                         WHEN 'VTAS.B' THEN -1.0
                                                                         ELSE 1.0 END))),
         UtilidadPor = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                           ELSE 
                       ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                       ((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                      WHEN 'VTAS.B' THEN -1.0
                                                                                      ELSE 1.0 END) /
                       ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
    INTO #UtilidadAgeA
    FROM VentaUtilD
    JOIN Art ON VentaUtilD.Articulo=Art.Articulo 
    LEFT OUTER JOIN Agente ON VentaUtilD.Agente = Agente.Agente
   WHERE VentaUtilD.Empresa = @Empresa
     AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
     AND ISNULL(VentaUtilD.Agente, '')  >= CASE @AgenteD  WHEN 'NULL' THEN ISNULL(VentaUtilD.Agente, '')  ELSE @AgenteD  END
     AND ISNULL(VentaUtilD.Agente, '')  <= CASE @AgenteA  WHEN 'NULL' THEN ISNULL(VentaUtilD.Agente, '')  ELSE @AgenteA  END
   ORDER BY VentaUtilD.Agente

  SELECT Agente, Nombre, DescuentoGlobal = AVG(ISNULL(DescuentoGlobal,0)),
         CantidadNeta = SUM(CantidadNeta), ImporteBruto = SUM(ImporteBruto),
         ImporteNeto = SUM(ImporteNeto), CostoNeto = SUM(CostoNeto), ComisionNeta = SUM(ComisionNeta), 
         Utilidad = SUM(Utilidad), UtilidadPor = AVG(UtilidadPor)
    INTO #UtilAgeA
    FROM #UtilidadAgeA
   GROUP BY Agente, Nombre
   ORDER BY Utilidad DESC, Agente

  IF @Desglosar = 'Si'
  BEGIN
    SELECT MovClaveD = VentaUtilD.MovClave,
           AgenteD = VentaUtilD.Agente,
           MovD = VentaUtilD.Mov,
           MovIDD = VentaUtilD.MovID,
           DescuentoGlobalD = (VentaUtilD.DescuentoGlobal),
           ---ImporteD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
           ImporteD = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
           CostoTotalD =  VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
           CantidadFactorD = (VentaUtilD.CantidadFactor),
           NombreD = Agente.Nombre,
           FactorVD = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                WHEN 'VTAS.B' THEN -1.0
                                                ELSE 1.0 END ),
           CantidadNetaD = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                   ELSE 1.0  END),
           ---ImporteBrutoD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
           ImporteBrutoD = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
           ---ImporteNetoD = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           ImporteNetoD = VentaUtilD.TipoCambio * ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                  WHEN 'VTAS.B' THEN -1.0
                                                                                  ELSE 1.0 END)),
           CostoNetoD = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                     ELSE 1.0 END)),
           ComisionNetaD = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                      WHEN 'VTAS.B' THEN -1.0
                                                                                                      ELSE 1.0 END)), 
           ---UtilidadD = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           UtilidadD = VentaUtilD.TipoCambio * (((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                                                            ELSE 1.0 END))  -     
                       ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))),
           UtilidadPorD = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                                ELSE 
                          ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                          (((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                         WHEN 'VTAS.B' THEN -1.0
                                                                                         ELSE 1.0 END) /
                          ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                               WHEN 'VTAS.B' THEN -1.0
                                                                               ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
      INTO #UtilidadAgeB
      FROM VentaUtilD
      JOIN Art ON VentaUtilD.Articulo = Art.Articulo 
      LEFT OUTER JOIN Agente ON VentaUtilD.Agente = Agente.Agente
     WHERE VentaUtilD.Empresa = @Empresa
       AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
       AND ISNULL(VentaUtilD.Agente, '')  >= CASE @AgenteD  WHEN 'NULL' THEN ISNULL(VentaUtilD.Agente, '')  ELSE @AgenteD  END
       AND ISNULL(VentaUtilD.Agente, '')  <= CASE @AgenteA  WHEN 'NULL' THEN ISNULL(VentaUtilD.Agente, '')  ELSE @AgenteA  END
     ORDER BY VentaUtilD.Agente

    SELECT AgenteD, MovD, MovIDD, DescuentoGlobalD = AVG(ISNULL(DescuentoGlobalD,0)),
           NombreD, CantidadNetaD = SUM(CantidadNetaD), ImporteBrutoD = SUM(ImporteBrutoD),
           ImporteNetoD = SUM(ImporteNetoD), CostoNetoD = SUM(CostoNetoD), ComisionNetaD = SUM(ComisionNetaD), 
           UtilidadD = SUM(UtilidadD), UtilidadPorD = AVG(UtilidadPorD)
      INTO #UtilAgeB
      FROM #UtilidadAgeB
     GROUP BY AgenteD, MovD, MovIDD, NombreD
     ORDER BY AgenteD, UtilidadD desc
  END

  CREATE TABLE #UtilidadAgente (
     Agente		char(10)	COLLATE Database_Default NULL,
     Nombre		varchar(100)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  IF @Desglosar = 'Si'
  BEGIN
    INSERT #UtilidadAgente
    SELECT Agente, Nombre, MovD, MovIDD, DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           DescuentoGlobalD, CantidadNetaD, ImporteBrutoD,
           ImporteNetoD, CostoNetoD, ComisionNetaD, UtilidadD, UtilidadPorD
      FROM #UtilAgeA
      JOIN #UtilAgeB ON ISNULL(Agente, '') = ISNULL(AgenteD, '')
     ORDER BY Utilidad desc, UtilidadD desc
  END
  ELSE
  BEGIN 
    INSERT #UtilidadAgente
    SELECT Agente, Nombre, NULL, NULL,DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
      FROM #UtilAgeA
     ORDER BY Utilidad desc
  END

  SELECT * FROM #UtilidadAgente
  ORDER BY Utilidad DESC, Agente, UtilidadD DESC

END
GO

/* mis_spUtilidadAlmacen */
if exists (select * from sysobjects where id = object_id('dbo.mis_spUtilidadAlmacen') and type = 'P') drop procedure dbo.mis_spUtilidadAlmacen
GO
CREATE PROCEDURE mis_spUtilidadAlmacen
					@Empresa		char(5),
                    @FechaD			DateTime,
                    @FechaA			DateTime,
                    @Almacen		char(10),
                    @Desglosar		Char(2)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@VPrecioImpInc		Bit,
	@PrecioImp		money,
	@PreciosinImp		money,
	--- Bugs 23763, 23764, 23765, 23766 Se agregan las 2 líneas siguientes
	@Imp2Info         	bit,
	@Imp3Info         	bit

  SELECT @VPrecioImpInc = VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa

  --- Bugs 23763, 23764, 23765, 23766 Se agrega la línea siguiente
  SELECT @Imp2Info = ISNULL(Impuesto2Info, 0), @Imp3Info = ISNULL(Impuesto3Info, 0) FROM Version


  SELECT VentaUtilD.MovClave,
         VentaUtilD.Almacen,
         DescuentoGlobal = (VentaUtilD.DescuentoGlobal),
         ---Importe = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         Importe = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
         CostoTotal = VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
         CantidadFactor = (VentaUtilD.CantidadFactor),
         FactorV = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                             WHEN 'VTAS.B' THEN -1.0
                                             ELSE 1.0 END ),
         CantidadNeta = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                WHEN 'VTAS.B' THEN -1.0
                                                                                ELSE 1.0  END),
         ---ImporteBruto = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         ImporteBruto = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
         ---ImporteNeto = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         ImporteNeto = VentaUtilD.TipoCambio * ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                    WHEN 'VTAS.B' THEN -1.0
                                                                                    ELSE 1.0 END)),
         CostoNeto = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                  WHEN 'VTAS.B' THEN -1.0
                                                                                                  ELSE 1.0 END)),
         ComisionNeta = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                                   ELSE 1.0 END)), 
         ---Utilidad = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         Utilidad = VentaUtilD.TipoCambio * (((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                  WHEN 'VTAS.B' THEN -1.0
                                                                                  ELSE 1.0 END))  -     
                    ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                         WHEN 'VTAS.B' THEN -1.0
                                                                         ELSE 1.0 END))),
         UtilidadPor = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                             ELSE 
                       ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                       (((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                           WHEN 'VTAS.B' THEN -1.0
                                                                                           ELSE 1.0 END) /
                       ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
    INTO #UtilidadAlmA
    FROM VentaUtilD
    JOIN Art ON VentaUtilD.Articulo = Art.Articulo 
   WHERE VentaUtilD.Empresa = @Empresa
     AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
     AND ISNULL(VentaUtilD.Almacen, '')  = CASE @Almacen   WHEN 'NULL' THEN ISNULL(VentaUtilD.Almacen, '')  ELSE @Almacen   END
   ORDER BY VentaUtilD.Almacen

  SELECT Almacen, DescuentoGlobal = AVG(ISNULL(DescuentoGlobal,0)),
         CantidadNeta = SUM(CantidadNeta), ImporteBruto = SUM(ImporteBruto),
         ImporteNeto = SUM(ImporteNeto), CostoNeto = SUM(CostoNeto), ComisionNeta = SUM(ComisionNeta), 
         Utilidad = SUM(Utilidad), UtilidadPor = AVG(UtilidadPor)
    INTO #UtilAlmA
    FROM #UtilidadAlmA
   GROUP BY Almacen
   ORDER BY Utilidad DESC, Almacen

  IF @Desglosar = 'Si'
  BEGIN
    SELECT MovClaveD = VentaUtilD.MovClave,
           AlmacenD = VentaUtilD.Almacen,
           MovD = VentaUtilD.Mov,
           MovIDD = VentaUtilD.MovID,
           DescuentoGlobalD = (VentaUtilD.DescuentoGlobal),
           ---ImporteD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
           ImporteD = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
           CostoTotalD =  VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
           CantidadFactorD = (VentaUtilD.CantidadFactor),
           FactorVD = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                WHEN 'VTAS.B' THEN -1.0
                                                ELSE 1.0 END ),
           CantidadNetaD = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                   ELSE 1.0  END),
           ---ImporteBrutoD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
           ImporteBrutoD = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
           ---ImporteNetoD = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           ImporteNetoD = VentaUtilD.TipoCambio * ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                       WHEN 'VTAS.B' THEN -1.0
                                                                                       ELSE 1.0 END)),
           CostoNetoD = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                     ELSE 1.0 END)),
           ComisionNetaD = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                      WHEN 'VTAS.B' THEN -1.0
                                                                                                      ELSE 1.0 END)), 
           ---UtilidadD = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           UtilidadD = VentaUtilD.TipoCambio * (((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                     ELSE 1.0 END))  -     
                       ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))),
           UtilidadPorD = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                                ELSE 
                          ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                          (((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                         WHEN 'VTAS.B' THEN -1.0
                                                                                         ELSE 1.0 END) /
                          ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                               WHEN 'VTAS.B' THEN -1.0
                                                                               ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
      INTO #UtilidadAlmB
      FROM VentaUtilD
      JOIN Art ON VentaUtilD.Articulo = Art.Articulo 
     WHERE VentaUtilD.Empresa = @Empresa
       AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
       AND ISNULL(VentaUtilD.Almacen, '')  = CASE @Almacen   WHEN 'NULL' THEN ISNULL(VentaUtilD.Almacen, '')  ELSE @Almacen   END
     ORDER BY VentaUtilD.Almacen

    SELECT AlmacenD, MovD, MovIDD, DescuentoGlobalD = AVG(ISNULL(DescuentoGlobalD,0)),
           CantidadNetaD = SUM(CantidadNetaD), ImporteBrutoD = SUM(ImporteBrutoD),
           ImporteNetoD = SUM(ImporteNetoD), CostoNetoD = SUM(CostoNetoD), ComisionNetaD = SUM(ComisionNetaD), 
           UtilidadD = SUM(UtilidadD), UtilidadPorD = AVG(UtilidadPorD)
      INTO #UtilAlmB
      FROM #UtilidadAlmB
     GROUP BY AlmacenD, MovD, MovIDD
     ORDER BY AlmacenD, UtilidadD DESC

  END

  CREATE TABLE #UtilidadAlm (
     Almacen		char(10)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  IF @Desglosar = 'Si'
  BEGIN
    INSERT #UtilidadAlm
    SELECT Almacen, MovD, MovIDD, DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           DescuentoGlobalD, CantidadNetaD, ImporteBrutoD,
           ImporteNetoD, CostoNetoD, ComisionNetaD, UtilidadD, UtilidadPorD
      FROM #UtilAlmA
      JOIN #UtilAlmB ON Almacen = AlmacenD
     ORDER BY Utilidad DESC, UtilidadD DESC
  END
  ELSE
  BEGIN 
    INSERT #UtilidadAlm
    SELECT Almacen, NULL, NULL,DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
      FROM #UtilAlmA
     ORDER BY Utilidad DESC
  END

  SELECT * FROM #UtilidadAlm
  ORDER BY Utilidad DESC, Almacen, UtilidadD DESC

END
GO


/* mis_spUtilidadArticulos */
if exists (select * from sysobjects where id = object_id('dbo.mis_spUtilidadArticulos') and type = 'P') 
  drop procedure dbo.mis_spUtilidadArticulos
GO
CREATE PROCEDURE mis_spUtilidadArticulos
		    @Empresa		char(5),
		    @ArticuloD		char(20),
		    @ArticuloA		char(20),
            @ArtCat			varchar(50),
            @ArtFam			varchar(50),
            @ArtGrupo		varchar(50),
            @ArtLinea		varchar(50),
            @Fabricante		varchar(50),
            @FechaD			DateTime,
            @FechaA			DateTime,
            @Desglosar		Char(2)
--//WITH ENCRYPTION
AS BEGIN
  --- Bug 23518 Se reemplaza el CASE por una función que regresa el precio real

  DECLARE
    @VPrecioImpInc    bit,
    @PrecioImp        money,
    @PreciosinImp     money,
    --- Bug 23518 Se agregan las 2 líneas siguientes
    @Imp2Info         bit,
    @Imp3Info         bit

  SELECT @VPrecioImpInc = VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa

  --- Bug 23518 Se agrega la línea siguiente
  SELECT @Imp2Info = ISNULL(Impuesto2Info, 0), @Imp3Info = ISNULL(Impuesto3Info, 0) FROM Version 

  SELECT VentaUtilD.MovClave,
         VentaUtilD.Articulo,
         Art.Descripcion1,
         DescuentoGlobal = (VentaUtilD.DescuentoGlobal),
         ---Importe = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END),
         --- Bug 23518 Se reemplaza la línea anterior por la siguiente
         Importe = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
         CostoTotal = VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
         CantidadFactor = (VentaUtilD.CantidadFactor),
         FactorV = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                             WHEN 'VTAS.B' THEN -1.0
                                             ELSE 1.0 END ),
         CantidadNeta = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                WHEN 'VTAS.B' THEN -1.0
                                                                                ELSE 1.0  END),
         ---ImporteBruto = VentaUtilD.TipoCambio *   (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END),
         --- Bug 23518 Se reemplaza la línea anterior por la siguiente
         ImporteBruto = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
         ---ImporteNeto  = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         --- Bug 23518 Se reemplaza la línea anterior por la siguiente
         ImporteNeto = VentaUtilD.TipoCambio * (((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) - ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                       WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                       ELSE 1.0 END)),
         CostoNeto = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                  WHEN 'VTAS.B' THEN -1.0
                                                                                                  ELSE 1.0 END)),
         ComisionNeta = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                                   ELSE 1.0 END)), 
         ---Utilidad = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         --- Bug 23518 Se reemplaza la línea anterior por la siguiente
         Utilidad = VentaUtilD.TipoCambio * ((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) - ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                     ELSE 1.0 END))  -     
                    ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                         WHEN 'VTAS.B' THEN -1.0
                                                                         ELSE 1.0 END))),
         UtilidadPor = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                             ELSE 
                       ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                       --- Bug 23518 Se reemplaza la línea anterior por la siguiente
                       ((((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) - ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                  WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                  ELSE 1.0 END) /
                       ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
    INTO #UtilidadArtA
    FROM VentaUtilD
    JOIN Art ON VentaUtilD.Articulo=Art.Articulo 
   WHERE VentaUtilD.Empresa = @Empresa
     AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
     AND ISNULL(VentaUtilD.Articulo, '')  >= CASE @ArticuloD  WHEN 'NULL' THEN ISNULL(VentaUtilD.Articulo, '')  ELSE @ArticuloD  END
     AND ISNULL(VentaUtilD.Articulo, '')  <= CASE @ArticuloA  WHEN 'NULL' THEN ISNULL(VentaUtilD.Articulo, '')  ELSE @ArticuloA  END
     AND ISNULL(Art.Categoria, '')  = CASE @ArtCat     WHEN 'NULL' THEN ISNULL(Art.Categoria, '')  ELSE @ArtCat     END
     AND ISNULL(Art.Grupo, '')      = CASE @ArtGrupo   WHEN 'NULL' THEN ISNULL(Art.Grupo, '')      ELSE @ArtGrupo   END
     AND ISNULL(Art.Familia, '')    = CASE @ArtFam     WHEN 'NULL' THEN ISNULL(Art.Familia, '')    ELSE @ArtFam     END
     AND ISNULL(Art.Linea, '')      = CASE @ArtLinea   WHEN 'NULL' THEN ISNULL(Art.Linea, '')      ELSE @ArtFam     END
     AND ISNULL(Art.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Art.Fabricante, '') ELSE @Fabricante END
   ORDER BY VentaUtilD.Articulo

  SELECT Articulo, Descripcion1, DescuentoGlobal = AVG(ISNULL(DescuentoGlobal,0)),
         CantidadNeta = SUM(CantidadNeta), ImporteBruto = SUM(ImporteBruto),
         ImporteNeto = SUM(ImporteNeto), CostoNeto = SUM(CostoNeto), ComisionNeta = SUM(ComisionNeta), 
         Utilidad = SUM(Utilidad), UtilidadPor = AVG(UtilidadPor)
    INTO #UtilArtA
    FROM #UtilidadArtA
   GROUP BY Articulo, Descripcion1
   ORDER BY Utilidad desc, Articulo

  IF @Desglosar = 'Si'
  BEGIN
    SELECT MovClaveD = VentaUtilD.MovClave,
           ArticuloD = VentaUtilD.Articulo,
           MovD = VentaUtilD.Mov,
           MovIDD = VentaUtilD.MovID,
           DescuentoGlobalD = (VentaUtilD.DescuentoGlobal),
           ---ImporteD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END),
           --- Bug 23518 Se reemplaza la línea anterior por la siguiente
           ImporteD = VentaUtilD.TipoCambio * (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)),
           CostoTotalD =  VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
           CantidadFactorD = (VentaUtilD.CantidadFactor),
           Descripcion1D = Art.Descripcion1,
           FactorVD = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                WHEN 'VTAS.B' THEN -1.0
                                                ELSE 1.0 END ),
           CantidadNetaD = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                   ELSE 1.0  END),
           ---ImporteBrutoD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END),
           --- Bug 23518 Se reemplaza la línea anterior por la siguiente
           ImporteBrutoD = VentaUtilD.TipoCambio * (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)),
           ---ImporteNetoD = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           --- Bug 23518 Se reemplaza la línea anterior por la siguiente
           ImporteNetoD = VentaUtilD.TipoCambio * (((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) - ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                          WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                          ELSE 1.0 END)),
           CostoNetoD = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                     ELSE 1.0 END)),
           ComisionNetaD = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                      WHEN 'VTAS.B' THEN -1.0
                                                                                                      ELSE 1.0 END)), 
           ---UtilidadD = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           --- Bug 23518 Se reemplaza la línea anterior por la siguiente
           UtilidadD = VentaUtilD.TipoCambio * ((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) - ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                        WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                        ELSE 1.0 END))  -     
                       ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))),
           UtilidadPorD = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                                ELSE 
                          ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (VentaUtilD.Impuesto1 / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                          --- Bug 23518 Se reemplaza la línea anterior por la siguiente
                          ((((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) - ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc)) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                     ELSE 1.0 END) /
                          ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                               WHEN 'VTAS.B' THEN -1.0
                                                                               ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
      INTO #UtilidadArtB
      FROM VentaUtilD
      JOIN Art ON VentaUtilD.Articulo = Art.Articulo 
     WHERE VentaUtilD.Empresa = @Empresa
       AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
       AND ISNULL(VentaUtilD.Articulo, '')  >= CASE @ArticuloD  WHEN 'NULL' THEN ISNULL(VentaUtilD.Articulo, '')  ELSE @ArticuloD  END
       AND ISNULL(VentaUtilD.Articulo, '')  <= CASE @ArticuloA  WHEN 'NULL' THEN ISNULL(VentaUtilD.Articulo, '')  ELSE @ArticuloA  END
       AND ISNULL(Art.Categoria, '')  = CASE @ArtCat     WHEN 'NULL' THEN ISNULL(Art.Categoria, '')  ELSE @ArtCat     END
       AND ISNULL(Art.Grupo, '')      = CASE @ArtGrupo   WHEN 'NULL' THEN ISNULL(Art.Grupo, '')      ELSE @ArtGrupo   END
       AND ISNULL(Art.Familia, '')    = CASE @ArtFam     WHEN 'NULL' THEN ISNULL(Art.Familia, '')    ELSE @ArtFam     END
       AND ISNULL(Art.Linea, '')      = CASE @ArtLinea   WHEN 'NULL' THEN ISNULL(Art.Linea, '')      ELSE @ArtFam     END
       AND ISNULL(Art.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(Art.Fabricante, '') ELSE @Fabricante END
     ORDER BY VentaUtilD.Articulo

    SELECT ArticuloD, MovD, MovIDD, DescuentoGlobalD = AVG(ISNULL(DescuentoGlobalD,0)),
           Descripcion1D, CantidadNetaD = SUM(CantidadNetaD), ImporteBrutoD = SUM(ImporteBrutoD),
           ImporteNetoD = SUM(ImporteNetoD), CostoNetoD = SUM(CostoNetoD), ComisionNetaD = SUM(ComisionNetaD), 
           UtilidadD = SUM(UtilidadD), UtilidadPorD = AVG(UtilidadPorD)
      INTO #UtilArtB
      FROM #UtilidadArtB
     GROUP BY ArticuloD, MovD, MovIDD, Descripcion1D
     ORDER BY ArticuloD, UtilidadD desc

  END

  CREATE TABLE #UtilidadArt (
     Articulo		char(20)	COLLATE Database_Default NULL,
     Descripcion1	varchar(100)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  IF @Desglosar = 'Si'
  BEGIN
    INSERT #UtilidadArt
    SELECT Articulo, Descripcion1, MovD, MovIDD, DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           DescuentoGlobalD, CantidadNetaD, ImporteBrutoD,
           ImporteNetoD, CostoNetoD, ComisionNetaD, UtilidadD, UtilidadPorD
      FROM #UtilArtA
      JOIN #UtilArtB ON Articulo = ArticuloD
     ORDER BY Utilidad desc, UtilidadD desc
  END
  ELSE
  BEGIN 
    INSERT #UtilidadArt
    SELECT Articulo, Descripcion1, NULL, NULL,DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
      FROM #UtilArtA
     ORDER BY Utilidad desc
  END

  SELECT * FROM #UtilidadArt
  ORDER BY Utilidad DESC, Articulo, UtilidadD DESC

END
GO


/* mis_spUtilidadClientes */
if exists (select * from sysobjects where id = object_id('dbo.mis_spUtilidadClientes') and type = 'P') drop procedure dbo.mis_spUtilidadClientes
GO
CREATE PROCEDURE mis_spUtilidadClientes
		    @Empresa		char(5),
		    @ClienteD		char(10),
		    @ClienteA		char(10),
            @CteCat			varchar(50),
            @CteFam			varchar(50),
            @CteGrupo		varchar(50),
            @FechaD			DateTime,
            @FechaA			DateTime,
            @Desglosar		Char(2)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@VPrecioImpInc		Bit,
	@PrecioImp		money,
	@PreciosinImp		money,
	--- Bugs 23763, 23764, 23765, 23766 Se agregan las 2 líneas siguientes
	@Imp2Info         bit,
	@Imp3Info         bit

  SELECT @VPrecioImpInc = VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa

  --- Bugs 23763, 23764, 23765, 23766 Se agrega la línea siguiente
  SELECT @Imp2Info = ISNULL(Impuesto2Info, 0), @Imp3Info = ISNULL(Impuesto3Info, 0) FROM Version 


  SELECT VentaUtilD.MovClave,
         VentaUtilD.Cliente,
         Cte.Nombre,
         DescuentoGlobal = (VentaUtilD.DescuentoGlobal),
         ---Importe = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         Importe = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
         CostoTotal = VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
         CantidadFactor = (VentaUtilD.CantidadFactor),
         FactorV = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                             WHEN 'VTAS.B' THEN -1.0
                                             ELSE 1.0 END ),
         CantidadNeta = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                WHEN 'VTAS.B' THEN -1.0
                                                                                ELSE 1.0  END),
         ---ImporteBruto = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         ImporteBruto = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
         ---ImporteNeto = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         ImporteNeto = VentaUtilD.TipoCambio * ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                       WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                       ELSE 1.0 END)),
         CostoNeto = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                  WHEN 'VTAS.B' THEN -1.0
                                                                                                  ELSE 1.0 END)),
         ComisionNeta = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                                   ELSE 1.0 END)), 
         ---Utilidad = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         Utilidad = VentaUtilD.TipoCambio * (((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                          WHEN 'VTAS.B' THEN -1.0
                                                                                                          ELSE 1.0 END))  -     
                    ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                         WHEN 'VTAS.B' THEN -1.0
                                                                         ELSE 1.0 END))),
         UtilidadPor = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                             ELSE 
                       ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                       (((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                             WHEN 'VTAS.B' THEN -1.0
                                                                                                             ELSE 1.0 END) /
                       ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
    INTO #UtilidadCteA
    FROM VentaUtilD
    JOIN Art ON VentaUtilD.Articulo=Art.Articulo 
    JOIN Cte ON VentaUtilD.Cliente=Cte.Cliente 
   WHERE VentaUtilD.Empresa = @Empresa
     AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
     AND ISNULL(VentaUtilD.Cliente, '')  >= CASE @ClienteD  WHEN 'NULL' THEN ISNULL(VentaUtilD.Cliente, '')  ELSE @ClienteD  END
     AND ISNULL(VentaUtilD.Cliente, '')  <= CASE @ClienteA  WHEN 'NULL' THEN ISNULL(VentaUtilD.Cliente, '')  ELSE @ClienteA  END
     AND ISNULL(Cte.Categoria, '')  = CASE @CteCat   WHEN 'NULL' THEN ISNULL(Cte.Categoria, '')  ELSE @CteCat   END
     AND ISNULL(Cte.Grupo, '')      = CASE @CteGrupo WHEN 'NULL' THEN ISNULL(Cte.Grupo, '')      ELSE @CteGrupo END
     AND ISNULL(Cte.Familia, '')    = CASE @CteFam   WHEN 'NULL' THEN ISNULL(Cte.Familia, '')    ELSE @CteFam   END
   ORDER BY VentaUtilD.Cliente

  SELECT Cliente, Nombre, DescuentoGlobal = AVG(ISNULL(DescuentoGlobal,0)),
         CantidadNeta = SUM(CantidadNeta), ImporteBruto = SUM(ImporteBruto),
         ImporteNeto = SUM(ImporteNeto), CostoNeto = SUM(CostoNeto), ComisionNeta = SUM(ComisionNeta), 
         Utilidad = SUM(Utilidad), UtilidadPor = AVG(UtilidadPor)
    INTO #UtilCteA
    FROM #UtilidadCteA
   GROUP BY Cliente, Nombre
   ORDER BY Utilidad desc, Cliente

  IF @Desglosar = 'Si'
  BEGIN
    SELECT MovClaveD = VentaUtilD.MovClave,
           ClienteD = VentaUtilD.Cliente,
           NombreD = Cte.Nombre,
           MovD = VentaUtilD.Mov,
           MovIDD = VentaUtilD.MovID,
           DescuentoGlobalD = (VentaUtilD.DescuentoGlobal),
           ---ImporteD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
           ImporteD = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
           CostoTotalD =  VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
           CantidadFactorD = (VentaUtilD.CantidadFactor),
           FactorVD = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                WHEN 'VTAS.B' THEN -1.0
                                                ELSE 1.0 END ),
           CantidadNetaD = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                   ELSE 1.0  END),
           ---ImporteBrutoD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
           ImporteBrutoD = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
           ---ImporteNetoD = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           ImporteNetoD = VentaUtilD.TipoCambio * ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                         WHEN 'VTAS.B' THEN -1.0
                                                                                        ELSE 1.0 END)),
           CostoNetoD = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                     ELSE 1.0 END)),
           ComisionNetaD = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                      WHEN 'VTAS.B' THEN -1.0
                                                                                                      ELSE 1.0 END)),
           ---UtilidadD = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           UtilidadD = VentaUtilD.TipoCambio * (((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                             WHEN 'VTAS.B' THEN -1.0
                                                                                                             ELSE 1.0 END))  -
                       ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))),
           UtilidadPorD = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                               ELSE 
                          ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                          (((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                WHEN 'VTAS.B' THEN -1.0
                                                                                                                ELSE 1.0 END) /
                          ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                               WHEN 'VTAS.B' THEN -1.0
                                                                               ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
      INTO #UtilidadCteB
      FROM VentaUtilD
      JOIN Art ON VentaUtilD.Articulo = Art.Articulo 
      JOIN Cte ON VentaUtilD.Cliente=Cte.Cliente 
     WHERE VentaUtilD.Empresa = @Empresa
       AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
       AND ISNULL(VentaUtilD.Cliente, '')  >= CASE @ClienteD  WHEN 'NULL' THEN ISNULL(VentaUtilD.Cliente, '')  ELSE @ClienteD  END
       AND ISNULL(VentaUtilD.Cliente, '')  <= CASE @ClienteA  WHEN 'NULL' THEN ISNULL(VentaUtilD.Cliente, '')  ELSE @ClienteA  END
       AND ISNULL(Cte.Categoria, '')  = CASE @CteCat   WHEN 'NULL' THEN ISNULL(Cte.Categoria, '')  ELSE @CteCat   END
       AND ISNULL(Cte.Grupo, '')      = CASE @CteGrupo WHEN 'NULL' THEN ISNULL(Cte.Grupo, '')      ELSE @CteGrupo END
       AND ISNULL(Cte.Familia, '')    = CASE @CteFam   WHEN 'NULL' THEN ISNULL(Cte.Familia, '')    ELSE @CteFam   END
     ORDER BY VentaUtilD.Cliente

    SELECT ClienteD, MovD, MovIDD, DescuentoGlobalD = AVG(ISNULL(DescuentoGlobalD,0)),
           NombreD, CantidadNetaD = SUM(CantidadNetaD), ImporteBrutoD = SUM(ImporteBrutoD),
           ImporteNetoD = SUM(ImporteNetoD), CostoNetoD = SUM(CostoNetoD), ComisionNetaD = SUM(ComisionNetaD), 
           UtilidadD = SUM(UtilidadD), UtilidadPorD = AVG(UtilidadPorD)
      INTO #UtilCteB
      FROM #UtilidadCteB
     GROUP BY ClienteD, MovD, MovIDD, NombreD
     ORDER BY NombreD, UtilidadD desc
  END

  CREATE TABLE #UtilidadCte (
     Cliente		char(20)	COLLATE Database_Default NULL,
     Nombre		varchar(100)	COLLATE Database_Default NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  IF @Desglosar = 'Si'
  BEGIN
    INSERT #UtilidadCte
    SELECT Cliente, Nombre, MovD, MovIDD, DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           DescuentoGlobalD, CantidadNetaD, ImporteBrutoD,
           ImporteNetoD, CostoNetoD, ComisionNetaD, UtilidadD, UtilidadPorD
      FROM #UtilCteA
      JOIN #UtilCteB ON ISNULL(Cliente, '') = ISNULL(ClienteD, '')
     ORDER BY Utilidad DESC, UtilidadD DESC
  END
  ELSE
  BEGIN 
    INSERT #UtilidadCte
    SELECT Cliente, Nombre, NULL, NULL,DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
      FROM #UtilCteA
     ORDER BY Utilidad DESC
  END

  SELECT * FROM #UtilidadCte
  ORDER BY Utilidad DESC, Cliente, UtilidadD DESC

END
GO

/* mis_spUtilidadSucursal */
if exists (select * from sysobjects where id = object_id('dbo.mis_spUtilidadSucursal') and type = 'P') drop procedure dbo.mis_spUtilidadSucursal
GO
CREATE PROCEDURE mis_spUtilidadSucursal
		    @Empresa		char(5),
            @FechaD			DateTime,
            @FechaA			DateTime,
            @Sucursal		int,
            @Desglosar		Char(2)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@VPrecioImpInc		Bit,
	@PrecioImp		money,
	@PreciosinImp		money,
	--- Bugs 23763, 23764, 23765, 23766 Se agregan las 2 líneas siguientes
	@Imp2Info         bit,
	@Imp3Info         bit

  SELECT @VPrecioImpInc = VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa

  --- Bugs 23763, 23764, 23765, 23766 Se agrega la línea siguiente
  SELECT @Imp2Info = ISNULL(Impuesto2Info, 0), @Imp3Info = ISNULL(Impuesto3Info, 0) FROM Version 


  SELECT VentaUtilD.MovClave,
         VentaUtilD.Sucursal,
         DescuentoGlobal = (VentaUtilD.DescuentoGlobal),
         ---Importe = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         Importe = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
         CostoTotal = VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
         CantidadFactor = (VentaUtilD.CantidadFactor),
         FactorV = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                             WHEN 'VTAS.B' THEN -1.0
                                             ELSE 1.0 END ),
         CantidadNeta = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                WHEN 'VTAS.B' THEN -1.0
                                                                                ELSE 1.0  END),
         ---ImporteBruto = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         ImporteBruto = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
         ---ImporteNeto = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         ImporteNeto = VentaUtilD.TipoCambio * ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                       WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                       ELSE 1.0 END)),
         CostoNeto = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                  WHEN 'VTAS.B' THEN -1.0
                                                                                                  ELSE 1.0 END)),
         ComisionNeta = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                                   ELSE 1.0 END)), 
         ---Utilidad = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         Utilidad = VentaUtilD.TipoCambio * (((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                     ELSE 1.0 END))  -     
                    ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                         WHEN 'VTAS.B' THEN -1.0
                                                                         ELSE 1.0 END))),
         UtilidadPor = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                             ELSE 
                       ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                       (((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                  WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                  ELSE 1.0 END) /
                       ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
    INTO #UtilidadSucA
    FROM VentaUtilD
    JOIN Art ON VentaUtilD.Articulo=Art.Articulo 
   WHERE VentaUtilD.Empresa = @Empresa
     AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
     AND VentaUtilD.Sucursal = CASE ISNULL(convert(char(10), @Sucursal), ' ') WHEN ' ' THEN VentaUtilD.Sucursal ELSE @Sucursal END
   ORDER BY VentaUtilD.Sucursal

  SELECT Sucursal, DescuentoGlobal = AVG(ISNULL(DescuentoGlobal,0)),
         CantidadNeta = SUM(CantidadNeta), ImporteBruto = SUM(ImporteBruto),
         ImporteNeto = SUM(ImporteNeto), CostoNeto = SUM(CostoNeto), ComisionNeta = SUM(ComisionNeta), 
         Utilidad = SUM(Utilidad), UtilidadPor = AVG(UtilidadPor)
    INTO #UtilSucA
    FROM #UtilidadSucA
   GROUP BY Sucursal
   ORDER BY Utilidad DESC, Sucursal

  IF @Desglosar = 'Si'
  BEGIN
    SELECT MovClaveD = VentaUtilD.MovClave,
           SucursalD = VentaUtilD.Sucursal,
           MovD = VentaUtilD.Mov,
           MovIDD = VentaUtilD.MovID,
           DescuentoGlobalD = (VentaUtilD.DescuentoGlobal),
           ---ImporteD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
           ImporteD = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
           CostoTotalD =  VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
           CantidadFactorD = (VentaUtilD.CantidadFactor),
           FactorVD = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                WHEN 'VTAS.B' THEN -1.0
                                                ELSE 1.0 END ),
           CantidadNetaD = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                   ELSE 1.0  END),
           ---ImporteBrutoD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
           ImporteBrutoD = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
           ---ImporteNetoD = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           ImporteNetoD = VentaUtilD.TipoCambio * ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                          WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                          ELSE 1.0 END)),
           CostoNetoD = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                     ELSE 1.0 END)),
           ComisionNetaD = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                      WHEN 'VTAS.B' THEN -1.0
                                                                                                      ELSE 1.0 END)), 
           ---UtilidadD = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           UtilidadD = VentaUtilD.TipoCambio * (((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                        WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                        ELSE 1.0 END))  -     
                       ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))),
           UtilidadPorD = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                                ELSE 
                          ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                          (((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                     ELSE 1.0 END) /
                          ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                               WHEN 'VTAS.B' THEN -1.0
                                                                               ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
      INTO #UtilidadSucB
      FROM VentaUtilD
      JOIN Art ON VentaUtilD.Articulo = Art.Articulo 
     WHERE VentaUtilD.Empresa = @Empresa
       AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
       AND VentaUtilD.Sucursal = CASE ISNULL(convert(char(10), @Sucursal), ' ') WHEN ' ' THEN VentaUtilD.Sucursal ELSE @Sucursal END
     ORDER BY VentaUtilD.Sucursal

    SELECT SucursalD, MovD, MovIDD, DescuentoGlobalD = AVG(ISNULL(DescuentoGlobalD,0)),
           CantidadNetaD = SUM(CantidadNetaD), ImporteBrutoD = SUM(ImporteBrutoD),
           ImporteNetoD = SUM(ImporteNetoD), CostoNetoD = SUM(CostoNetoD), ComisionNetaD = SUM(ComisionNetaD), 
           UtilidadD = SUM(UtilidadD), UtilidadPorD = AVG(UtilidadPorD)
      INTO #UtilSucB
      FROM #UtilidadSucB
     GROUP BY SucursalD, MovD, MovIDD
     ORDER BY SucursalD, UtilidadD DESC
  END

  CREATE TABLE #UtilidadSuc (
     Sucursalx		int		NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  IF @Desglosar = 'Si'
  BEGIN
    INSERT #UtilidadSuc
    SELECT Sucursal, MovD, MovIDD, DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           DescuentoGlobalD, CantidadNetaD, ImporteBrutoD,
           ImporteNetoD, CostoNetoD, ComisionNetaD, UtilidadD, UtilidadPorD
      FROM #UtilSucA
      JOIN #UtilSucB ON Sucursal = SucursalD
     ORDER BY Utilidad DESC, UtilidadD DESC
  END
  ELSE
  BEGIN 
    INSERT #UtilidadSuc
    SELECT Sucursal, NULL, NULL,DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
      FROM #UtilSucA
     ORDER BY Utilidad DESC
  END

  SELECT * FROM #UtilidadSuc
  ORDER BY Utilidad DESC, Sucursalx, UtilidadD DESC

END
GO

/* mis_spUtilidadUEN */
if exists (select * from sysobjects where id = object_id('dbo.mis_spUtilidadUEN') and type = 'P') drop procedure dbo.mis_spUtilidadUEN
GO
CREATE PROCEDURE mis_spUtilidadUEN
		    @Empresa		char(5),
            @FechaD			DateTime,
            @FechaA			DateTime,
            @UEN			int,
            @Desglosar		Char(2)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@VPrecioImpInc		Bit,
	@PrecioImp		money,
	@PreciosinImp		money,
	--- Bugs 23763, 23764, 23765, 23766 Se agregan las 2 líneas siguientes
	@Imp2Info         bit,
	@Imp3Info         bit

  SELECT @VPrecioImpInc = VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa

  --- Bugs 23763, 23764, 23765, 23766 Se agrega la línea siguiente
  SELECT @Imp2Info = ISNULL(Impuesto2Info, 0), @Imp3Info = ISNULL(Impuesto3Info, 0) FROM Version 


  SELECT VentaUtilD.MovClave,
         VentaUtilD.UEN,
         DescuentoGlobal = (VentaUtilD.DescuentoGlobal),
         ---Importe = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         Importe = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
         CostoTotal = VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
         CantidadFactor = (VentaUtilD.CantidadFactor),
         FactorV = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                             WHEN 'VTAS.B' THEN -1.0
                                             ELSE 1.0 END ),
         CantidadNeta = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                WHEN 'VTAS.B' THEN -1.0
                                                                                ELSE 1.0  END),
         ---ImporteBruto = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
         ImporteBruto = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
         ---ImporteNeto = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         ImporteNeto = VentaUtilD.TipoCambio * ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                       WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                       ELSE 1.0 END)),
         CostoNeto = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                  WHEN 'VTAS.B' THEN -1.0
                                                                                                  ELSE 1.0 END)),
         ComisionNeta = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                                   ELSE 1.0 END)), 
         ---Utilidad = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
         Utilidad = VentaUtilD.TipoCambio * (((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                     ELSE 1.0 END))  -     
                    ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                         WHEN 'VTAS.B' THEN -1.0
                                                                         ELSE 1.0 END))),
         UtilidadPor = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                             ELSE 
                       ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                       (((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                  WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                  ELSE 1.0 END) /
                       ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
    INTO #UtilidadUENA
    FROM VentaUtilD
    JOIN Art ON VentaUtilD.Articulo=Art.Articulo 
   WHERE VentaUtilD.Empresa = @Empresa
     AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
     AND VentaUtilD.UEN = CASE ISNULL(convert(char(10), @UEN), ' ') WHEN ' ' THEN VentaUtilD.UEN ELSE @UEN END
   ORDER BY VentaUtilD.UEN

  SELECT UEN, DescuentoGlobal = AVG(ISNULL(DescuentoGlobal,0)),
         CantidadNeta = SUM(CantidadNeta), ImporteBruto = SUM(ImporteBruto),
         ImporteNeto = SUM(ImporteNeto), CostoNeto = SUM(CostoNeto), ComisionNeta = SUM(ComisionNeta), 
         Utilidad = SUM(Utilidad), UtilidadPor = AVG(UtilidadPor)
    INTO #UtilUENA
    FROM #UtilidadUENA
   GROUP BY UEN
   ORDER BY Utilidad DESC, UEN

  IF @Desglosar = 'Si'
  BEGIN
    SELECT MovClaveD = VentaUtilD.MovClave,
           UEND = VentaUtilD.UEN,
           MovD = VentaUtilD.Mov,
           MovIDD = VentaUtilD.MovID,
           DescuentoGlobalD = (VentaUtilD.DescuentoGlobal),
           ---ImporteD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
           ImporteD = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
           CostoTotalD =  VentaUtilD.TipoCambio * (VentaUtilD.CostoTotal),
           CantidadFactorD = (VentaUtilD.CantidadFactor),
           FactorVD = (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                WHEN 'VTAS.B' THEN -1.0
                                                ELSE 1.0 END ),
           CantidadNetaD = (VentaUtilD.CantidadFactor) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                   WHEN 'VTAS.B' THEN -1.0
                                                                                   ELSE 1.0  END),
           ---ImporteBrutoD = VentaUtilD.TipoCambio * (CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END),
           ImporteBrutoD = VentaUtilD.TipoCambio * dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc),
           ---ImporteNetoD = VentaUtilD.TipoCambio * (((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           ImporteNetoD = VentaUtilD.TipoCambio * ((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                          WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                          ELSE 1.0 END)),
           CostoNetoD = VentaUtilD.TipoCambio * ((VentaUtilD.CostoTotal) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                     ELSE 1.0 END)),
           ComisionNetaD = VentaUtilD.TipoCambio * ((VentaUtilD.Comision) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                      WHEN 'VTAS.B' THEN -1.0
                                                                                                      ELSE 1.0 END)), 
           ---UtilidadD = VentaUtilD.TipoCambio * ((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
           UtilidadD = VentaUtilD.TipoCambio * (((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                                        WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                                        ELSE 1.0 END))  -     
                       ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                            WHEN 'VTAS.B' THEN -1.0
                                                                            ELSE 1.0 END))),
           UtilidadPorD = VentaUtilD.TipoCambio * (Case (VentaUtilD.CostoTotal) WHEN 0 THEN 100
                                                                                ELSE 
                          ---((((((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) - ((CASE WHEN @VPrecioImpInc = 1 THEN ((VentaUtilD.Importe)/ (1 + (dbo.fnEvitarDivisionCero(VentaUtilD.Impuesto1) / 100))) ELSE (VentaUtilD.Importe) END) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                          (((((dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) - (dbo.fnPrecioReal(VentaUtilD.Importe, VentaUtilD.Impuesto1, VentaUtilD.Impuesto2, VentaUtilD.Impuesto3, @Imp2Info, @Imp3Info, @VPrecioImpInc) * ISNULL((VentaUtilD.DescuentoGlobal/100),0))) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                                                                                                                     WHEN 'VTAS.B' THEN -1.0
                                                                                                                                                                     ELSE 1.0 END) /
                          ((dbo.fnEvitarDivisionCero(VentaUtilD.CostoTotal)) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0
                                                                               WHEN 'VTAS.B' THEN -1.0
                                                                               ELSE 1.0 END))))-1)  *100) * (Case VentaUtilD.MovClave WHEN 'VTAS.D' THEN -1.0  WHEN 'VTAS.B' THEN -1.0 ELSE 1.0 END ) END)
      INTO #UtilidadUENB
      FROM VentaUtilD
      JOIN Art ON VentaUtilD.Articulo = Art.Articulo 
     WHERE VentaUtilD.Empresa = @Empresa
       AND VentaUtilD.FechaEmision BETWEEN @FechaD AND @FechaA
       AND VentaUtilD.UEN = CASE ISNULL(convert(char(10), @UEN), ' ') WHEN ' ' THEN VentaUtilD.UEN ELSE @UEN END
     ORDER BY VentaUtilD.UEN

    SELECT UEND, MovD, MovIDD, DescuentoGlobalD = AVG(ISNULL(DescuentoGlobalD,0)),
           CantidadNetaD = SUM(CantidadNetaD), ImporteBrutoD = SUM(ImporteBrutoD),
           ImporteNetoD = SUM(ImporteNetoD), CostoNetoD = SUM(CostoNetoD), ComisionNetaD = SUM(ComisionNetaD), 
           UtilidadD = SUM(UtilidadD), UtilidadPorD = AVG(UtilidadPorD)
      INTO #UtilUENB
      FROM #UtilidadUENB
     GROUP BY UEND, MovD, MovIDD
     ORDER BY UEND, UtilidadD DESC
  END

  CREATE TABLE #UtilidadUEN (
     UENx		int		NULL,
     Mov		char(20)	COLLATE Database_Default NULL,
     MovID		varchar(20)	COLLATE Database_Default NULL,
     DescuentoGlobal	float(8)	NULL,
     CantidadNeta 	float(8)	NULL,
     ImporteBruto	money		NULL,
     ImporteNeto	money		NULL,
     CostoNeto		money		NULL,
     ComisionNeta	money		NULL,
     Utilidad		money		NULL,
     UtilidadPor	float(8)	NULL,
     DescuentoGlobalD	float(8)	NULL,
     CantidadNetaD 	float(8)	NULL,
     ImporteBrutoD	money		NULL,
     ImporteNetoD	money		NULL,
     CostoNetoD		money		NULL,
     ComisionNetaD	money		NULL,
     UtilidadD		money		NULL,
     UtilidadPorD	float(8)	NULL
  )

  IF @Desglosar = 'Si'
  BEGIN
    INSERT #UtilidadUEN
    SELECT UEN, MovD, MovIDD, DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           DescuentoGlobalD, CantidadNetaD, ImporteBrutoD,
           ImporteNetoD, CostoNetoD, ComisionNetaD, UtilidadD, UtilidadPorD
      FROM #UtilUENA
      JOIN #UtilUENB ON UEN = UEND
     ORDER BY Utilidad DESC, UtilidadD DESC
  END
  ELSE
  BEGIN 
    INSERT #UtilidadUEN
    SELECT UEN, NULL, NULL,DescuentoGlobal, CantidadNeta, ImporteBruto,
           ImporteNeto, CostoNeto, ComisionNeta, Utilidad, UtilidadPor,
           NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
      FROM #UtilUENA
     ORDER BY Utilidad DESC
  END

  SELECT * FROM #UtilidadUEN
  ORDER BY Utilidad DESC, UENx, UtilidadD DESC

END
GO


/* mis_VentaUtilD */
if exists (select * from sysobjects where id = object_id('dbo.mis_VentaUtilD') and type = 'V') drop view dbo.mis_VentaUtilD
GO
CREATE VIEW mis_VentaUtilD
--//WITH ENCRYPTION
AS 
  SELECT f.ID,
  	 f.Empresa,
	 f.Mov,
	 f.MovID,
	 RTRIM(f.Mov)+' '+RTRIM(Convert(Char,f.MovID)) Movimiento,
	 m.Clave MovClave,
	 m.Factor,
	 f.Ejercicio,
	 f.Periodo,
	 f.FechaEmision,
	 f.Cliente,
	 f.EnviarA,
	 f.Agente,
	 f.Proyecto,
	 f.UEN,
	 f.Moneda,
	 f.TipoCambio,
	 f.DescuentoGlobal,
	 d.Almacen,
	 d.RenglonID,
	 d.Articulo,
	 d.Impuesto1,
	 d.Impuesto2,
	 d.Impuesto3,
	 "Cantidad" = sum(d.Cantidad),
	 "Precio" = Convert(money, sum(CONVERT(money, d.Precio*d.Cantidad))/sum(d.Cantidad)),
	 "DescuentoTipo" = '%',
	 "DescuentoLinea" = CONVERT(money, ROUND(avg(case d.DescuentoTipo when '$' then (d.DescuentoLinea/d.precio)*100 else d.DescuentoLinea end), 2)),
	 "Importe2" = sum(CONVERT(money, d.Cantidad*d.Precio)),
	 "Importe" = CONVERT(money, sum(ROUND(CONVERT(money, d.Cantidad*d.Precio), 2)) * (1-avg(case d.DescuentoTipo when '$' then (ISNULL(d.DescuentoLinea, 0.0)/d.precio)*100 else ISNULL(d.DescuentoLinea,0.0) end)/100)),
	 "CostoTotal" = sum(ROUND(Convert(money, d.Cantidad*ISNULL(d.Costo, 0.0)), 2)),
	 "CantidadFactor" = CONVERT(float, sum(d.Cantidad*m.Factor)),
	 "Comision" = sum(d.Comision)
    FROM Venta f
    JOIN VentaD d ON f.ID = d.ID
    JOIN MovTipo m ON f.Mov = m.Mov  
   WHERE f.Estatus = 'CONCLUIDO'
     AND d.RenglonTipo not in ('E','P')
     AND m.Modulo = 'VTAS'
     AND m.Clave IN ('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
   GROUP BY
	 f.ID,
	 f.Empresa,
	 f.Mov,
	 f.MovID,
	 m.Clave,
	 m.Factor,
	 f.Ejercicio,
	 f.Periodo,
	 f.FechaEmision,
	 f.Cliente,
	 f.EnviarA,
	 f.Agente,
	 f.Proyecto,
	 f.UEN,
	 f.Moneda,
	 f.TipoCambio,
	 f.DescuentoGlobal,
	 d.Almacen,
	 d.RenglonID,
	 d.Articulo,
	 d.Impuesto1,
	 d.Impuesto2,
	 d.Impuesto3
GO

/* mis_spVentaCompCat */
if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaCompCat') and type = 'P') drop procedure dbo.mis_spVentaCompCat
GO
CREATE PROCEDURE mis_spVentaCompCat
                 @Ejercicio	int,
                 @Periodo	int,
                 @ArticuloD	char(20),
                 @ArticuloA	char(20),
                 @Categoria	varchar(50),
                 @Empresa	char(5)
--//WITH ENCRYPTION		    
AS BEGIN
  DECLARE
    @EjercicioAnt	int,
    @DiaAct		int,
    @DiaAnt		int,
    @MesAct		int,
    @MesAnt		int,
    @AnoAct		int,
    @AnoAnt		int

  SELECT @EjercicioAnt = @Ejercicio - 1
  SELECT @MesAct = @Periodo
  SELECT @MesAnt = @Periodo

-- Articulos
  SELECT a.Articulo, a.Categoria
    INTO #Artic
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo
   WHERE b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ((b.Ejercicio = @EjercicioAnt
     AND b.Periodo <= @Periodo) 
     OR (b.Ejercicio = @Ejercicio
     AND b.Periodo <= @Periodo))
     AND ISNULL(a.Categoria, '')  = CASE @Categoria  WHEN 'NULL' THEN ISNULL(a.Categoria, '')  ELSE @Categoria  END
     AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
   GROUP BY a.Articulo, a.Categoria
   ORDER BY a.Articulo

-- Existencias
  SELECT a.Articulo,
         'Existencia' = Sum(b.Existencia)
    INTO #Exist 
    FROM Art a
    JOIN ArtExistenciaNeta b ON a.Articulo = b.Articulo
   WHERE ISNULL(a.Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(a.Categoria, '') ELSE @Categoria END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Actual
  SELECT a.Articulo,
         'CantAct' = SUM(b.CantidadFactor)
    INTO #Actual
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(a.Categoria, '') ELSE @Categoria END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Mes Actual
  SELECT a.Articulo,
         'CantMAct' = SUM(b.CantidadFactor)
    INTO #ActualM
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(a.Categoria, '') ELSE @Categoria END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Anterior
  SELECT a.Articulo,
         'CantAnt' = SUM(b.CantidadFactor)
    INTO #Anterior
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo  
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(a.Categoria, '') ELSE @Categoria END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Mes Anterior
  SELECT a.Articulo,
         'CantMAnt' = SUM(b.CantidadFactor)
    INTO #AnteriorM
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Categoria, '') = CASE @Categoria WHEN 'NULL' THEN ISNULL(a.Categoria, '') ELSE @Categoria END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Graba en Tabla de Resultados
  SELECT a.Articulo, a.Categoria,
         'CantAct'  = CASE when CantAct  IS NULL THEN 0 ELSE CantAct  end,
         'CantMAct' = CASE when CantMAct IS NULL THEN 0 ELSE CantMAct end,
         'CantAnt'  = CASE when CantAnt  IS NULL THEN 0 ELSE CantAnt  end,
         'CantMAnt' = CASE when CantMAnt IS NULL THEN 0 ELSE CantMAnt end,
         'Existencia' = CASE when Existencia IS NULL THEN 0 ELSE Existencia end
    INTO #COMPARRCat
    FROM #Artic a
    LEFT OUTER JOIN #Exist b ON a.Articulo = b.Articulo
    LEFT OUTER JOIN #Actual c ON a.Articulo = c.Articulo
    LEFT OUTER JOIN #Anterior d ON a.Articulo = d.Articulo
    LEFT OUTER JOIN #ActualM e ON a.Articulo = e.Articulo
    LEFT OUTER JOIN #AnteriorM f ON a.Articulo = f.Articulo
   ORDER BY a.Categoria, a.Articulo

--Despliega Información
  SELECT *  FROM #COMPARRCat
   ORDER BY Categoria, Articulo

END
GO

/* mis_spVentaCompFabric */
if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaCompFabric') and type = 'P') drop procedure dbo.mis_spVentaCompFabric
GO
CREATE PROCEDURE mis_spVentaCompFabric
                 @Ejercicio	 int,
                 @Periodo	 int,
                 @ArticuloD	 char(20),
                 @ArticuloA	 char(20),
                 @Fabricante varchar(50),
                 @Empresa	 char(5)
--//WITH ENCRYPTION		    
AS BEGIN
  DECLARE
    @EjercicioAnt	int,
    @MesAct		int,
    @MesAnt		int

  SELECT @EjercicioAnt = @Ejercicio - 1
  SELECT @MesAct = @Periodo
  SELECT @MesAnt = @Periodo

-- Articulos
  SELECT a.Articulo, a.Fabricante
    INTO #Artic
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo
   WHERE b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ((b.Ejercicio = @EjercicioAnt
     AND b.Periodo <= @Periodo) 
     OR (b.Ejercicio = @Ejercicio
     AND b.Periodo <= @Periodo))
     AND ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
   GROUP BY a.Articulo, a.Fabricante
   ORDER BY a.Articulo

-- Existencias
  SELECT a.Articulo,
         'Existencia' = Sum(b.Existencia)
    INTO #Exist 
    FROM Art a
    JOIN ArtExistenciaNeta b ON a.Articulo = b.Articulo
   WHERE ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Actual
  SELECT a.Articulo,
         'CantAct' = SUM(b.CantidadFactor)
    INTO #Actual
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Mes Actual
  SELECT a.Articulo,
         'CantMAct' = SUM(b.CantidadFactor)
    INTO #ActualM
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Anterior
  SELECT a.Articulo,
         'CantAnt' = SUM(b.CantidadFactor)
    INTO #Anterior
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Mes Anterior
  SELECT a.Articulo,
         'CantMAnt' = SUM(b.CantidadFactor)
    INTO #AnteriorM
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Fabricante, '') = CASE @Fabricante WHEN 'NULL' THEN ISNULL(a.Fabricante, '') ELSE @Fabricante END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Graba en Tabla de Resultados
  SELECT a.Articulo, a.Fabricante,
         'CantAct'  = CASE when CantAct  IS NULL THEN 0 ELSE CantAct  end,
         'CantMAct' = CASE when CantMAct IS NULL THEN 0 ELSE CantMAct end,
         'CantAnt'  = CASE when CantAnt  IS NULL THEN 0 ELSE CantAnt  end,
         'CantMAnt' = CASE when CantMAnt IS NULL THEN 0 ELSE CantMAnt end,
         'Existencia' = CASE when Existencia IS NULL THEN 0 ELSE Existencia end
    INTO #COMPARRFabric
    FROM #Artic a
    LEFT OUTER JOIN #Exist b ON a.Articulo = b.Articulo
    LEFT OUTER JOIN #Actual c ON a.Articulo = c.Articulo
    LEFT OUTER JOIN #Anterior d ON a.Articulo = d.Articulo
    LEFT OUTER JOIN #ActualM e ON a.Articulo = e.Articulo
    LEFT OUTER JOIN #AnteriorM f ON a.Articulo = f.Articulo
   ORDER BY a.Fabricante, a.Articulo

--Despliega Información
  SELECT *  FROM #COMPARRFabric
   ORDER BY Fabricante, Articulo

END
GO

/* mis_spVentaCompFam */
if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaCompFam') and type = 'P') drop procedure dbo.mis_spVentaCompFam
GO
CREATE PROCEDURE mis_spVentaCompFam
                 @Ejercicio	int,
                 @Periodo	int,
                 @ArticuloD	char(20),
                 @ArticuloA	char(20),
                 @Familia	varchar(50),
                 @Empresa	char(5)
--//WITH ENCRYPTION		    
AS BEGIN
  DECLARE
    @EjercicioAnt	int,
    @MesAct		int,
    @MesAnt		int

  SELECT @EjercicioAnt = @Ejercicio - 1
  SELECT @MesAct = @Periodo
  SELECT @MesAnt = @Periodo

-- Articulos
  SELECT a.Articulo, a.Familia
    INTO #Artic
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo
   WHERE b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ((b.Ejercicio = @EjercicioAnt
     AND b.Periodo <= @Periodo) 
     OR (b.Ejercicio = @Ejercicio
     AND b.Periodo <= @Periodo))
     AND ISNULL(a.Familia, '')    = CASE @Familia    WHEN 'NULL' THEN ISNULL(a.Familia, '')    ELSE @Familia    END
     AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
   GROUP BY a.Articulo, a.Familia
   ORDER BY a.Articulo

-- Existencias
  SELECT a.Articulo,
         'Existencia' = Sum(b.Existencia)
    INTO #Exist 
    FROM Art a
    JOIN ArtExistenciaNeta b ON a.Articulo = b.Articulo
   WHERE ISNULL(a.Familia, '')   = CASE @Familia   WHEN 'NULL' THEN ISNULL(a.Familia, '')   ELSE @Familia   END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Actual
  SELECT a.Articulo,
         'CantAct' = SUM(b.CantidadFactor)
    INTO #Actual
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Familia, '')   = CASE @Familia   WHEN 'NULL' THEN ISNULL(a.Familia, '')   ELSE @Familia   END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Mes Actual
  SELECT a.Articulo,
         'CantMAct' = SUM(b.CantidadFactor)
    INTO #ActualM
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo  
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Familia, '')   = CASE @Familia   WHEN 'NULL' THEN ISNULL(a.Familia, '')   ELSE @Familia   END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Anterior
  SELECT a.Articulo,
         'CantAnt' = SUM(b.CantidadFactor)
    INTO #Anterior
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo  
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Familia, '')   = CASE @Familia   WHEN 'NULL' THEN ISNULL(a.Familia, '')   ELSE @Familia   END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Mes Anterior
  SELECT a.Articulo,
         'CantMAnt' = SUM(b.CantidadFactor)
    INTO #AnteriorM
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Familia, '')   = CASE @Familia   WHEN 'NULL' THEN ISNULL(a.Familia, '')   ELSE @Familia   END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Graba en Tabla de Resultados
  SELECT a.Articulo, a.Familia,
         'CantAct'  = CASE when CantAct  IS NULL THEN 0 ELSE CantAct  end,
         'CantMAct' = CASE when CantMAct IS NULL THEN 0 ELSE CantMAct end,
         'CantAnt'  = CASE when CantAnt  IS NULL THEN 0 ELSE CantAnt  end,
         'CantMAnt' = CASE when CantMAnt IS NULL THEN 0 ELSE CantMAnt end,
         'Existencia' = CASE when Existencia IS NULL THEN 0 ELSE Existencia end
    INTO #COMPARRFam
    FROM #Artic a
    LEFT OUTER JOIN #Exist b ON a.Articulo = b.Articulo
    LEFT OUTER JOIN #Actual c ON a.Articulo = c.Articulo
    LEFT OUTER JOIN #Anterior d ON a.Articulo = d.Articulo
    LEFT OUTER JOIN #ActualM e ON a.Articulo = e.Articulo
    LEFT OUTER JOIN #AnteriorM f ON a.Articulo = f.Articulo
   ORDER BY a.Familia, a.Articulo

--Despliega Información
  SELECT *  FROM #COMPARRFam
   ORDER BY Familia, Articulo

END
GO

/* mis_spVentaCompGrupo */
if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaCompGrupo') and type = 'P') drop procedure dbo.mis_spVentaCompGrupo
GO
CREATE PROCEDURE mis_spVentaCompGrupo
                 @Ejercicio	int,
                 @Periodo	int,
                 @ArticuloD	char(20),
                 @ArticuloA	char(20),
                 @Grupo		varchar(50),
                 @Empresa	char(5)
--//WITH ENCRYPTION		    
AS BEGIN
  DECLARE
    @EjercicioAnt	int,
    @MesAct		int,
    @MesAnt		int

  SELECT @EjercicioAnt = @Ejercicio - 1
  SELECT @MesAct = @Periodo
  SELECT @MesAnt = @Periodo

-- Articulos
  SELECT a.Articulo, a.Grupo
    INTO #Artic
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo
   WHERE b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ((b.Ejercicio = @EjercicioAnt
     AND b.Periodo <= @Periodo) 
     OR (b.Ejercicio = @Ejercicio
     AND b.Periodo <= @Periodo))
     AND ISNULL(a.Grupo, '')      = CASE @Grupo      WHEN 'NULL' THEN ISNULL(a.Grupo, '')      ELSE @Grupo      END
     AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
   GROUP BY a.Articulo, a.Grupo
   ORDER BY a.Articulo

-- Existencias
  SELECT a.Articulo,
         'Existencia' = Sum(b.Existencia)
    INTO #Exist 
    FROM Art a
    JOIN ArtExistenciaNeta b ON a.Articulo = b.Articulo
   WHERE ISNULL(a.Grupo, '')     = CASE @Grupo     WHEN 'NULL' THEN ISNULL(a.Grupo, '')     ELSE @Grupo     END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Actual
  SELECT a.Articulo,
         'CantAct' = SUM(b.CantidadFactor)
    INTO #Actual
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo  
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Grupo, '')     = CASE @Grupo     WHEN 'NULL' THEN ISNULL(a.Grupo, '')     ELSE @Grupo     END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Mes Actual
  SELECT a.Articulo,
         'CantMAct' = SUM(b.CantidadFactor)
    INTO #ActualM
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo  
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Grupo, '')     = CASE @Grupo     WHEN 'NULL' THEN ISNULL(a.Grupo, '')     ELSE @Grupo     END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Anterior
  SELECT a.Articulo,
         'CantAnt' = SUM(b.CantidadFactor)
    INTO #Anterior
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Grupo, '')     = CASE @Grupo     WHEN 'NULL' THEN ISNULL(a.Grupo, '')     ELSE @Grupo     END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Mes Anterior
  SELECT a.Articulo,
         'CantMAnt' = SUM(b.CantidadFactor)
    INTO #AnteriorM
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Grupo, '')     = CASE @Grupo     WHEN 'NULL' THEN ISNULL(a.Grupo, '')     ELSE @Grupo     END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Graba en Tabla de Resultados
  SELECT a.Articulo, a.Grupo,
         'CantAct'  = CASE when CantAct  IS NULL THEN 0 ELSE CantAct  end,
         'CantMAct' = CASE when CantMAct IS NULL THEN 0 ELSE CantMAct end,
         'CantAnt'  = CASE when CantAnt  IS NULL THEN 0 ELSE CantAnt  end,
         'CantMAnt' = CASE when CantMAnt IS NULL THEN 0 ELSE CantMAnt end,
         'Existencia' = CASE when Existencia IS NULL THEN 0 ELSE Existencia end
    INTO #COMPARRGrupo
    FROM #Artic a
    LEFT OUTER JOIN #Exist b ON a.Articulo = b.Articulo
    LEFT OUTER JOIN #Actual c ON a.Articulo = c.Articulo
    LEFT OUTER JOIN #Anterior d ON a.Articulo = d.Articulo
    LEFT OUTER JOIN #ActualM e ON a.Articulo = e.Articulo
    LEFT OUTER JOIN #AnteriorM f ON a.Articulo = f.Articulo
   ORDER BY a.Grupo, a.Articulo

--Despliega Información
  SELECT *  FROM #COMPARRGrupo
   ORDER BY Grupo, Articulo

END
GO

/* mis_spVentaCompLinea */
if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaCompLinea') and type = 'P') drop procedure dbo.mis_spVentaCompLinea
GO
CREATE PROCEDURE mis_spVentaCompLinea
                 @Ejercicio	int,
                 @Periodo	int,
                 @ArticuloD	char(20),
                 @ArticuloA	char(20),
                 @Linea		varchar(50),
                 @Empresa	char(5)
--//WITH ENCRYPTION		    
AS BEGIN
  DECLARE
    @EjercicioAnt	int,
    @MesAct		int,
    @MesAnt		int

  SELECT @EjercicioAnt = @Ejercicio - 1
  SELECT @MesAct = @Periodo
  SELECT @MesAnt = @Periodo

-- Articulos
  SELECT a.Articulo, a.Linea
    INTO #Artic
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo
   WHERE b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND ((b.Ejercicio = @EjercicioAnt
     AND b.Periodo <= @Periodo) 
     OR (b.Ejercicio = @Ejercicio
     AND b.Periodo <= @Periodo))
     AND ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND a.Articulo BETWEEN @ArticuloD AND @ArticuloA
   GROUP BY a.Articulo, a.Linea
   ORDER BY a.Articulo

-- Existencias
  SELECT a.Articulo,
         'Existencia' = Sum(b.Existencia)
    INTO #Exist 
    FROM Art a
    JOIN ArtExistenciaNeta b ON a.Articulo = b.Articulo
   WHERE ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Actual
  SELECT a.Articulo,
         'CantAct' = SUM(b.CantidadFactor)
    INTO #Actual
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo  
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Mes Actual
  SELECT a.Articulo,
         'CantMAct' = SUM(b.CantidadFactor)
    INTO #ActualM
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo 
   WHERE b.Ejercicio = @Ejercicio
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo

-- Cantidad Anterior
  SELECT a.Articulo,
         'CantAnt' = SUM(b.CantidadFactor)
    INTO #Anterior
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo  
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo <= @Periodo
     AND ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Cantidad Mes Anterior
  SELECT a.Articulo,
         'CantMAnt' = SUM(b.CantidadFactor)
    INTO #AnteriorM
    FROM Art a
    JOIN mis_VentaUtilD b ON a.Articulo = b.Articulo  
   WHERE b.Ejercicio = @EjercicioAnt
     AND b.MovClave IN('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST')
     AND b.Periodo = @Periodo
     AND ISNULL(a.Linea  , '')    = CASE @Linea      WHEN 'NULL' THEN ISNULL(a.Linea  , '')    ELSE @Linea      END
     AND b.Empresa = @Empresa
   GROUP BY a.Articulo
   ORDER BY a.Articulo

-- Graba en Tabla de Resultados
  SELECT a.Articulo, a.Linea, 
         'CantAct'  = CASE when CantAct  IS NULL THEN 0 ELSE CantAct  end,
         'CantMAct' = CASE when CantMAct IS NULL THEN 0 ELSE CantMAct end,
         'CantAnt'  = CASE when CantAnt  IS NULL THEN 0 ELSE CantAnt  end,
         'CantMAnt' = CASE when CantMAnt IS NULL THEN 0 ELSE CantMAnt end,
         'Existencia' = CASE when Existencia IS NULL THEN 0 ELSE Existencia end
    INTO #COMPARRLinea
    FROM #Artic a
    LEFT OUTER JOIN #Exist b ON a.Articulo = b.Articulo
    LEFT OUTER JOIN #Actual c ON a.Articulo = c.Articulo
    LEFT OUTER JOIN #Anterior d ON a.Articulo = d.Articulo
    LEFT OUTER JOIN #ActualM e ON a.Articulo = e.Articulo
    LEFT OUTER JOIN #AnteriorM f ON a.Articulo = f.Articulo
   ORDER BY a.Linea, a.Articulo

--Despliega Información
  SELECT *  FROM #COMPARRLinea
   ORDER BY Linea, Articulo

END
GO

/* mis_VentaUtilD1 */
if exists (select * from sysobjects where id = object_id('dbo.mis_VentaUtilD1') and type = 'V') drop view dbo.mis_VentaUtilD1
GO
CREATE VIEW mis_VentaUtilD1
--//WITH ENCRYPTION
AS 
  SELECT f.ID,
	 f.Empresa,
	 f.Mov,
	 f.MovID,
	 RTRIM(f.Mov)+' '+RTRIM(Convert(Char,f.MovID)) Movimiento,
	 m.Clave MovClave,
	 m.Factor,
	 f.Ejercicio,
	 f.Periodo,
	 f.FechaEmision,
	 f.Cliente,
	 f.EnviarA,
	 f.Agente,
	 f.Proyecto,
	 f.Moneda,
	 f.TipoCambio,
	 f.DescuentoGlobal,
	 d.Almacen,
	 d.RenglonID,
	 d.Articulo,
	 d.Subcuenta,
	 d.Impuesto1,
	 d.Impuesto2,
	 d.Impuesto3,
	 "Cantidad" = sum(d.Cantidad),
	 "Precio" = Convert(money, sum(CONVERT(money, d.Precio*d.Cantidad))/sum(d.Cantidad)),
	 "DescuentoTipo" = '%',
	 "DescuentoLinea" = CONVERT(money, ROUND(avg(case d.DescuentoTipo when '$' then (d.DescuentoLinea/d.precio)*100 else d.DescuentoLinea end), 2)),
	 "Importe2" = sum(CONVERT(money, d.Cantidad*d.Precio)),
	 "Importe" = CONVERT(money, sum(ROUND(CONVERT(money, d.Cantidad*d.Precio), 2)) * (1-avg(case d.DescuentoTipo when '$' then (ISNULL(d.DescuentoLinea, 0.0)/d.precio)*100 else ISNULL(d.DescuentoLinea,0.0) end)/100)),
	 "ImporteX" = CONVERT(money, sum(ROUND(CONVERT(money, (d.Cantidad*m.Factor)*d.Precio), 2)) * (1-avg(case d.DescuentoTipo when '$' then (ISNULL(d.DescuentoLinea, 0.0)/d.precio)*100 else ISNULL(d.DescuentoLinea,0.0) end)/100)),
	 "CostoTotal" = sum(ROUND(Convert(money, d.Cantidad*ISNULL(d.Costo, 0.0)), 2)),
	 "CantidadFactor" = CONVERT(float, sum(d.Cantidad*m.Factor)),
	 "Comision" = sum(d.Comision)
    FROM Venta f
    JOIN VentaD d ON f.ID = d.ID
    JOIN MovTipo m ON f.Mov = m.Mov 
   WHERE f.Estatus = 'CONCLUIDO'
     AND d.RenglonTipo not in ('E','P')
     AND m.Modulo = 'VTAS'
     AND m.Clave IN ('VTAS.F', 'VTAS.FM', 'VTAS.D', 'VTAS.B', 'VTAS.EST') 
   GROUP BY
	 f.ID,
	 f.Empresa,
	 f.Mov,
	 f.MovID,
	 m.Clave,
	 m.Factor,
	 f.Ejercicio,
	 f.Periodo,
	 f.FechaEmision,
	 f.Cliente,
	 f.EnviarA,
	 f.Agente,
	 f.Proyecto,
	 f.Moneda,
	 f.TipoCambio,
	 f.DescuentoGlobal,
	 d.Almacen,
	 d.RenglonID,
	 d.Articulo,
	 d.Subcuenta,
	 d.Impuesto1,
	 d.Impuesto2,
	 d.Impuesto3
GO

/* mis_VentaUtilX */
if exists (select * from sysobjects where id = object_id('dbo.mis_VentaUtilX') and type = 'V') drop view dbo.mis_VentaUtilX
GO
Create View mis_VentaUtilX As
  SELECT mis_VentaUtilD1.ID,
	 mis_VentaUtilD1.Empresa,
	 mis_VentaUtilD1.Mov,
	 mis_VentaUtilD1.MovID,
	 mis_VentaUtilD1.Movimiento,
	 mis_VentaUtilD1.Ejercicio,
	 mis_VentaUtilD1.Periodo,
	 mis_VentaUtilD1.MovClave,
	 mis_VentaUtilD1.FechaEmision,
	 mis_VentaUtilD1.Almacen,
	 mis_VentaUtilD1.DescuentoGlobal,
	 mis_VentaUtilD1.Articulo,
	 mis_VentaUtilD1.SubCuenta,
	 CantidadX = CASE mis_VentaUtilD1.MovClave
                     WHEN 'VTAS.F'   THEN mis_VentaUtilD1.Cantidad 
                     WHEN 'VTAS.FM'  THEN mis_VentaUtilD1.Cantidad 
                     WHEN 'VTAS.EST' THEN mis_VentaUtilD1.Cantidad 
                     WHEN 'VTAS.D'   THEN (-1 * mis_VentaUtilD1.Cantidad) 
                     WHEN 'VTAS.B'   THEN (-1 * mis_VentaUtilD1.Cantidad) 
                     END,
	 mis_VentaUtilD1.Precio,
	 mis_VentaUtilD1.DescuentoTipo,
	 mis_VentaUtilD1.DescuentoLinea,
	 mis_VentaUtilD1.Importe,
	 mis_VentaUtilD1.ImporteX,
	 mis_VentaUtilD1.CostoTotal,
	 mis_VentaUtilD1.CantidadFactor,
	 mis_VentaUtilD1.Comision,
	 mis_VentaUtilD1.Impuesto1,
	 mis_VentaUtilD1.Impuesto2,
	 mis_VentaUtilD1.Impuesto3,
	 'ArtArticulo' = Art.Articulo,
	 Art.Rama,
	 Art.Descripcion1,
	 Art.Grupo,
	 Art.Categoria,
	 Art.Familia,
	 Art.Fabricante,
	 Art.Linea,
	 Art.Tipo,
	 Art.Estatus
    FROM mis_VentaUtilD1
    JOIN Art ON mis_VentaUtilD1.Articulo = Art.Articulo 

GO


/* mis_spVentaParticProdCat */
-- Este SP se elimina por estar definido también en el archivo "LG - Reportes.sql" y al dar mantenimiento aquel se ejecuta primero (B 23314)
-- if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaParticProdCat') and type = 'P') drop procedure dbo.mis_spVentaParticProdCat
GO
/*
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
     SubCuentax		varchar(50)	COLLATE Database_Default NULL,
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
    JOIN #BAct b ON a.Articulo  = b.Articulo AND a.Categoria = b.Categoria
    JOIN #ZAct c ON a.Categoria = c.Categoria

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
    JOIN #BActAcum b ON a.Articulo = b.Articulo AND a.Categoria = b.Categoria
    JOIN #ZActAcum c ON a.Categoria = c.Categoria

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
    JOIN #BAnt b ON a.Articulo = b.Articulo AND a.Categoria = b.Categoria
    JOIN #ZAnt c ON a.Categoria = c.Categoria

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
    JOIN #BAntAcum b ON a.Articulo = b.Articulo AND a.Categoria = b.Categoria
    JOIN #ZAntAcum c ON a.Categoria = c.Categoria

  INSERT #ParticipaCat
  SELECT Categoria, Articulo, Subcuenta, NULL, NULL, NULL, 
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
         NULL, NULL, NULL
    FROM #Arti

  UPDATE #ParticipaCat
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaCat x
    LEFT OUTER JOIN #CAct a ON x.Categoriax = a.Categoria 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaCat
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaCat x
    LEFT OUTER JOIN #CAct a ON x.Categoriax = a.Categoria 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaCat
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaCat x
    LEFT OUTER JOIN #CActAcum a ON x.Categoriax = a.Categoria 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaCat
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaCat x
    LEFT OUTER JOIN #CActAcum a ON x.Categoriax = a.Categoria 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaCat
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaCat x
    LEFT OUTER JOIN #CAnt a ON x.Categoriax = a.Categoria 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaCat
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaCat x
    LEFT OUTER JOIN #CAnt a ON x.Categoriax = a.Categoria 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaCat
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaCat x
    LEFT OUTER JOIN #CAntAcum a ON x.Categoriax = a.Categoria 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaCat
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaCat x
    LEFT OUTER JOIN #CAntAcum a ON x.Categoriax = a.Categoria 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

--Despliega Información

  SELECT * FROM #ParticipaCat
  ORDER BY Categoriax, Articulox, SubCuentax

END
*/
GO

/* mis_spVentaParticProdFabric */
-- Este SP se elimina por estar definido también en el archivo "LG - Reportes.sql" y al dar mantenimiento aquel se ejecuta primero (B 23316)
-- if exists (select * from sysobjects where id = object_id('dbo.mis_spVentaParticProdFabric') and type = 'P') drop procedure dbo.mis_spVentaParticProdFabric
GO
/*
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
     SubCuentax		varchar(50)	COLLATE Database_Default NULL,
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
    JOIN #BAct b ON a.Articulo = b.Articulo AND a.Fabricante = b.Fabricante
    JOIN #ZAct c ON a.Fabricante = c.Fabricante

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
    JOIN #BActAcum b ON a.Articulo = b.Articulo AND a.Fabricante = b.Fabricante
    JOIN #ZActAcum c ON a.Fabricante = c.Fabricante

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
    JOIN #BAnt b ON a.Articulo = b.Articulo AND a.Fabricante = b.Fabricante
    JOIN #ZAnt c ON a.Fabricante = c.Fabricante

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
    JOIN #BAntAcum b ON a.Articulo = b.Articulo AND a.Fabricante = b.Fabricante
    JOIN #ZAntAcum c ON a.Fabricante = c.Fabricante

  INSERT #ParticipaFabric
  SELECT Fabricante, Articulo, Subcuenta, NULL, NULL, NULL, 
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
         NULL, NULL, NULL
    FROM #Arti

  UPDATE #ParticipaFabric
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CAct a ON x.Fabricantex = a.Fabricante 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFabric
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CAct a ON x.Fabricantex = a.Fabricante 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.SubCuentax, '') = ''

  UPDATE #ParticipaFabric
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CActAcum a ON x.Fabricantex = a.Fabricante 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFabric
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CActAcum a ON x.Fabricantex = a.Fabricante 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaFabric
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CAnt a ON x.Fabricantex = a.Fabricante
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFabric
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CAnt a ON x.Fabricantex = a.Fabricante 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.SubCuentax, '') = ''

  UPDATE #ParticipaFabric
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CAntAcum a ON x.Fabricantex = a.Fabricante 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFabric
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaFabric x
    LEFT OUTER JOIN #CAntAcum a ON x.Fabricantex = a.Fabricante 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.SubCuentax, '') = ''

--Despliega Información

  SELECT * FROM #PARTICIPAFABRIC
  ORDER BY Fabricantex, Articulox, SubCuentax

END
*/
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
     SubCuentax		varchar(50)	COLLATE Database_Default NULL,
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
    JOIN #BAct b ON a.Articulo = b.Articulo AND a.Familia = b.Familia
    JOIN #ZAct c ON a.Familia = c.Familia

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
    JOIN #BActAcum b ON a.Articulo = b.Articulo AND a.Familia = b.Familia
    JOIN #ZActAcum c ON a.Familia = c.Familia

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
    JOIN #BAnt b ON a.Articulo = b.Articulo AND a.Familia = b.Familia
    JOIN #ZAnt c ON a.Familia = c.Familia

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
    JOIN #BAntAcum b ON a.Articulo = b.Articulo AND a.Familia = b.Familia
    JOIN #ZAntAcum c ON a.Familia = c.Familia

  INSERT #ParticipaFam
  SELECT Familia, Articulo, Subcuenta, NULL, NULL, NULL, 
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
         NULL, NULL, NULL
    FROM #Arti

  UPDATE #ParticipaFam
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAct a ON x.Familiax = a.Familia   
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFam
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAct a ON x.Familiax = a.Familia   
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.SubCuentax, '') = ''

  UPDATE #ParticipaFam
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CActAcum a ON x.Familiax = a.Familia   
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFam
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CActAcum a ON x.Familiax = a.Familia   
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaFam
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAnt a ON x.Familiax = a.Familia   
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFam
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAnt a ON x.Familiax = a.Familia   
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.SubCuentax, '') = ''

  UPDATE #ParticipaFam
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAntAcum a ON x.Familiax = a.Familia   
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaFam
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaFam x
    LEFT OUTER JOIN #CAntAcum a ON x.Familiax = a.Familia   
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
     SubCuentax		varchar(50)	COLLATE Database_Default NULL,
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
    JOIN #BAct b ON a.Articulo = b.Articulo AND a.Grupo = b.Grupo
    JOIN #ZAct c ON a.Grupo = c.Grupo

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
    JOIN #BActAcum b ON a.Articulo = b.Articulo AND a.Grupo = b.Grupo
    JOIN #ZActAcum c ON a.Grupo = c.Grupo

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
    JOIN #BAnt b ON a.Articulo = b.Articulo AND a.Grupo = b.Grupo
    JOIN #ZAnt c ON a.Grupo = c.Grupo

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
    JOIN #BAntAcum b ON a.Articulo = b.Articulo AND a.Grupo = b.Grupo
    JOIN #ZAntAcum c ON a.Grupo = c.Grupo

  INSERT #ParticipaGrupo
  SELECT Grupo, Articulo, Subcuenta, NULL, NULL, NULL, 
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
         NULL, NULL, NULL
    FROM #Arti

  UPDATE #ParticipaGrupo
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAct a ON x.Grupox = a.Grupo     
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaGrupo
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAct a ON x.Grupox = a.Grupo    
     AND x.Articulox = a.Articulo 
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaGrupo
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CActAcum a ON x.Grupox = a.Grupo     
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaGrupo
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CActAcum a ON x.Grupox = a.Grupo     
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaGrupo
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAnt a ON x.Grupox = a.Grupo     
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaGrupo
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAnt a ON x.Grupox = a.Grupo     
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaGrupo
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAntAcum a ON x.Grupox = a.Grupo     
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaGrupo
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaGrupo x
    LEFT OUTER JOIN #CAntAcum a ON x.Grupox = a.Grupo     
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
     SubCuentax		varchar(50)	COLLATE Database_Default NULL,
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
    JOIN #BAct b ON a.Articulo = b.Articulo AND a.Linea = b.Linea
    JOIN #ZAct c ON a.Linea = c.Linea

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
    JOIN #BActAcum b ON a.Articulo = b.Articulo AND a.Linea = b.Linea
    JOIN #ZActAcum c ON a.Linea = c.Linea

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
    JOIN #BAnt b ON a.Articulo = b.Articulo AND a.Linea = b.Linea
    JOIN #ZAnt c ON a.Linea = c.Linea

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
    JOIN #BAntAcum b ON a.Articulo = b.Articulo AND a.Linea = b.Linea
    JOIN #ZAntAcum c ON a.Linea = c.Linea

  INSERT #ParticipaLinea
  SELECT Linea, Articulo, Subcuenta, NULL, NULL, NULL, 
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
         NULL, NULL, NULL
    FROM #Arti

  UPDATE #ParticipaLinea
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAct a ON x.Lineax = a.Linea 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaLinea
     SET Cantid1 = a.Cantid1 , Import1 = a.Import1, SumaCan1 = a.SumaCan1, SumaTot1 = a.SumaTot1
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAct a ON x.Lineax = a.Linea
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaLinea
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CActAcum a ON x.Lineax = a.Linea     
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaLinea
     SET Cantid2 = a.Cantid2, Import2 = a.Import2, Costo2 = a.Costo2, Util2 = a.Util2, SumaCan2 = a.SumaCan2, SumaTot2 = a.SumaTot2
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CActAcum a ON x.Lineax = a.Linea     
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaLinea
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAnt a ON x.Lineax = a.Linea 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaLinea
     SET Cantid3 = a.Cantid3 , Import3 = a.Import3, SumaCan3 = a.SumaCan3, SumaTot3 = a.SumaTot3
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAnt a ON x.Lineax = a.Linea 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

  UPDATE #ParticipaLinea
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAntAcum a ON x.Lineax = a.Linea 
     AND x.Articulox = a.Articulo  
     AND x.SubCuentax = a.SubCuenta 

  UPDATE #ParticipaLinea
     SET Cantid4 = a.Cantid4 , Import4 = a.Import4, SumaCan4 = a.SumaCan4, SumaTot4 = a.SumaTot4
    FROM #ParticipaLinea x
    LEFT OUTER JOIN #CAntAcum a ON x.Lineax = a.Linea 
     AND x.Articulox = a.Articulo  
     AND ISNULL(x.Subcuentax,'') = ''

--Despliega Información

  SELECT * FROM #PARTICIPALINEA
  ORDER BY Lineax, Articulox, SubCuentax

END
GO

/* mis_VerVentaSemanalMensual */ 
if exists ( select * from sysobjects where id = object_id('dbo.mis_VerVentaSemanalMensual') and sysstat & 0xf = 3 ) drop table dbo.mis_VerVentaSemanalMensual
GO
CREATE TABLE dbo.mis_VerVentaSemanalMensual (
	Estacion		int		NOT NULL,
        Articulo        	char(20)	NOT NULL,
	Moneda			char(10)	NOT NULL,
	VentaImporteSemana	float,
	VentaCantidadSemana	float,
	VentaImporteMes		float,
	VentaCantidadMes	float,
	CostoSemana		float,
	CostoMes		float


CONSTRAINT mis_PriVerVentaSemanalMensual PRIMARY KEY CLUSTERED(Estacion, Articulo, Moneda))
GO

/* mis_spVerVentaSemanalMensual */
if exists (select * from sysobjects where id = object_id('dbo.mis_spVerVentaSemanalMensual') and sysstat & 0xf = 4) drop procedure dbo.mis_spVerVentaSemanalMensual
GO             
CREATE PROCEDURE mis_spVerVentaSemanalMensual
		@Estacion	int,
		@Empresa	char(5),
		@ArticuloD  char(20),
		@ArticuloA  char(20),
        @Moneda     char(10),
		@FechaD		datetime,
        @FechaA		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Articulo	        char(20),
	@VentaImporteSemana	float,
	@VentaCantidadSemana	float,
	@VentaImporteMes	float,
	@VentaCantidadMes	float,
	@CostoSemana		float,
	@CostoMes		float,
        @MovClave		char(10),
	@FechaEmision		datetime,
	@CostoTotal		float,
	@Cantidad		float,
	@ImporteNeto		float,
	@d 			datetime,
        @m 			datetime

  DELETE mis_VerVentaSemanalMensual WHERE Estacion = @Estacion

  SELECT @d = DATEADD(day, -7, @FechaA)--, @m = DATEADD(month, -1, @FechaA)

 DECLARE VentaSemanalMensual CURSOR FOR    
  SELECT MovClave,
         Moneda,
	 FechaEmision,
         Articulo,
         CostoTotal,
         Cantidad,
         "ImporteNeto" = (ISNULL(Importe, 0)-(ISNULL(Importe, 0)*(ISNULL(DescuentoGlobal,0.0))/100))
    FROM VentaUtilD
   WHERE FechaEmision BETWEEN @FechaD AND @FechaA
     AND Empresa = @Empresa
     AND ISNULL(Moneda,'')  = CASE @Moneda  WHEN 'NULL' THEN ISNULL(Moneda,'')  ELSE @Moneda  END
     AND Articulo BETWEEN @ArticuloD AND @ArticuloA
   ORDER BY MovClave,
            Moneda,
            Articulo,
	    CostoTotal,
	    Cantidad,
            ImporteNeto

   OPEN VentaSemanalMensual 
  FETCH NEXT FROM VentaSemanalMensual INTO @MovClave, @Moneda, @FechaEmision, @Articulo, @CostoTotal, @Cantidad, @ImporteNeto
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN  
      SELECT @VentaImporteSemana = 0, @VentaCantidadSemana = 0, @VentaImporteMes = 0, @VentaCantidadMes = 0,
             @CostoSemana = 0, @CostoMes = 0
	  IF @FechaEmision < @d  
            IF @MovClave = 'VTAS.F' 
	      SELECT @VentaImporteMes = @ImporteNeto,
		     @VentaCantidadMes = @Cantidad,
               	     @CostoMes = @CostoTotal
            ELSE
	      SELECT @VentaImporteMes = (@ImporteNeto*(-1)),
		     @VentaCantidadMes = (@Cantidad*(-1)),
		     @CostoMes = (@CostoTotal*(-1))

          IF @FechaEmision >= @d 	
            IF @MovClave = 'VTAS.F' 
	      SELECT @VentaImporteSemana = @ImporteNeto,
		     @VentaCantidadSemana = @Cantidad,
	 	     @VentaImporteMes = @ImporteNeto,
  		     @VentaCantidadMes = @Cantidad,
		     @CostoSemana = @CostoTotal,
		     @CostoMes = @CostoTotal
	    ELSE
	      SELECT @VentaImporteSemana = (@ImporteNeto*(-1)),
		     @VentaCantidadSemana = (@Cantidad*(-1)),
		     @VentaImporteMes = (@ImporteNeto*(-1)),
		     @VentaCantidadMes = (@Cantidad*(-1)),
		     @CostoSemana = (@CostoTotal*(-1)),
		     @CostoMes = (@CostoTotal*(-1))

       UPDATE mis_VerVentaSemanalMensual 
	  SET VentaImporteSemana  = ISNULL(VentaImporteSemana,0.0)  + ISNULL(@VentaImporteSemana,0.0),
	      VentaCantidadSemana = ISNULL(VentaCantidadSemana,0.0) + ISNULL(@VentaCantidadSemana,0.0),	
              VentaImporteMes	  = ISNULL(VentaImporteMes,0.0)     + ISNULL(@VentaImporteMes,0.0),
              VentaCantidadMes    = ISNULL(VentaCantidadMes,0.0)    + ISNULL(@VentaCantidadMes,0.0),
              CostoSemana         = ISNULL(CostoSemana,0.0)         + ISNULL(@CostoSemana,0.0),
              CostoMes            = ISNULL(CostoMes,0.0)            + ISNULL(@CostoMes,0.0)
        WHERE Estacion = @Estacion AND Articulo = @Articulo AND Moneda = @Moneda

      IF @@ROWCOUNT = 0
      INSERT mis_VerVentaSemanalMensual (Estacion,  Articulo, Moneda, VentaImporteSemana, VentaCantidadSemana, VentaImporteMes, VentaCantidadMes, CostoSemana, CostoMes)
                                 VALUES (@Estacion, @Articulo, @Moneda, @VentaImporteSemana, @VentaCantidadSemana, @VentaImporteMes, @VentaCantidadMes, @CostoSemana, @CostoMes)
    END   
    FETCH NEXT FROM VentaSemanalMensual INTO @MovClave, @Moneda, @FechaEmision, @Articulo, @CostoTotal, @Cantidad, @ImporteNeto
  END
  CLOSE VentaSemanalMensual
  DEALLOCATE VentaSemanalMensual
  RETURN
END 
GO

/* mis_spPresupVta */
if exists (select * from sysobjects where id = object_id('dbo.mis_spPresupVta') and type = 'P') drop procedure dbo.mis_spPresupVta
GO
CREATE PROCEDURE mis_spPresupVta
		    @Ejercicio		int,
            @PeriodoD		int,
            @PeriodoA		int,
            @ClienteD		char(10),
            @ClienteA		char(10),
            @Empresa		char(5)
--//WITH ENCRYPTION
AS BEGIN
-- Define los Presupuestos del Rango por Cliente, Articulo
  SELECT PCliente = a.Cliente, PImporte = SUM(a.Importe + a.Impuestos), PPeriodo = a.Periodo, 
         PEjercicio = a.Ejercicio, PArticulo = b.Articulo
    INTO #Presup
    FROM Venta a
    JOIN VentaD b ON a.ID = b.ID
    JOIN MovTipo c ON a.Mov = c.Mov
   WHERE c.Modulo = 'VTAS'
     AND c.Clave = 'VTAS.PR'
     AND a.Estatus = 'Concluido'
     AND a.Cliente BETWEEN @ClienteD AND @ClienteA
     AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA
     AND a.Ejercicio = @Ejercicio
     AND a.Empresa = @Empresa
   GROUP BY a.Cliente, a.Periodo, a.Ejercicio, b.Articulo
   ORDER BY a.Ejercicio, a.Periodo, a.Cliente

-- Sobre los presupuestos, define las Ventas del Rango por Cliente, Articulo
  SELECT PCliente, PImporte, PPeriodo, PEjercicio, PArticulo, VCliente = a.Cliente, 
         VImporte = c.Factor * SUM(a.Importe + a.Impuestos), VPeriodo = a.Periodo, VEjercicio = a.Ejercicio, 
         VArticulo = b.Articulo, C.Clave
    INTO #PVenta
    FROM Venta a
    JOIN VentaD b ON a.ID = b.ID
    JOIN MovTipo c ON a.Mov = c.Mov
    JOIN #Presup d ON a.Cliente = PCliente AND b.Articulo = PArticulo AND a.Periodo = PPeriodo AND a.Ejercicio = PEjercicio
   WHERE c.Modulo = 'VTAS'
     AND c.Clave IN ('VTAS.F', 'VTAS.D')
     AND a.Estatus = 'Concluido'
     AND a.Empresa = @Empresa
   GROUP BY PCliente, PImporte, PPeriodo, PEjercicio, PArticulo, a.Cliente, a.Periodo, a.Ejercicio, b.Articulo, c.Clave, c.Factor
   ORDER BY a.Ejercicio, a.Periodo, a.Cliente

-- Despliega Información
  SELECT PCliente, PImporte, PPeriodo, PEjercicio, PArticulo, VCliente, VImporte = SUM(VImporte), VPeriodo, VEjercicio, VArticulo
    FROM #PVenta
   GROUP BY PCliente, PImporte, PPeriodo, PEjercicio, PArticulo, VCliente, VPeriodo, VEjercicio, VArticulo
   ORDER BY PEjercicio, PPeriodo, PCliente

END
GO

if exists (select * from sysobjects where id = object_id('dbo.spVerContResultadosPresup') and type = 'P') drop procedure dbo.spVerContResultadosPresup
GO
CREATE PROCEDURE spVerContResultadosPresup
	@Estacion		int,
	@Empresa		char(5),
	@Ejercicio		int,
	@PeriodoD		int,
	@PeriodoA		int,
	@ConMovs		char(20)    = 'NO',
	@CentroCostosD		char(20)    = NULL,
	@CentroCostosA		char(20)    = NULL,
	@Sucursal		int	    = NULL,
	@OrdenCC		char(20)    = 'NO',
	@Moneda			char(10)    = NULL,
	@CCGrupo		varchar(50) = NULL,
    @Controladora		char(5)     = NULL,
	@UEN			int	    = NULL,
	@Proyecto		varchar(50) = NULL,
	@CentroCostos2		varchar(50) = NULL,
	@CentroCostos3		varchar(50) = NULL,
    @ReExpresar     char(20) = 'NO', --REQ2162
	@ReExpresarTipoCambio float = NULL --REQ2162	
WITH ENCRYPTION
AS BEGIN

  DECLARE
	@ID				int,
	@CtaResultados			char(20),
	@CtaIngresos			char(20),
	@CtaCostoDirecto		char(20),
	@CtaGastosOperacion		char(20),
	@CtaOtrosGastosProductos	char(20),
	@CtaImpuestos			char(20),
	@Saldo				money,
	@Ingresos			money,
	@IngresosAl			money,
	@SaldoP				money,
	@IngresosPE			money,
	@IngresosAlPE			money,
	@SaldoDif			money,
	@IngresosDif			money,
	@IngresosAlDif			money

  SELECT @Moneda        = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0'),
         @CCGrupo       = NULLIF(NULLIF(RTRIM(@CCGrupo), ''), '0')

  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  IF @CentroCostosD IN ('0', 'NULL', '(TODOS)','') SELECT @CentroCostosD = NULL
  IF @CentroCostosA IN ('0', 'NULL', '(TODOS)','') SELECT @CentroCostosA = NULL
  IF @UEN = 0 SELECT @UEN = NULL
  IF UPPER(@Proyecto)  	 IN ('0', 'NULL', '(TODOS)','') SELECT @Proyecto = NULL
  IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','') SELECT @CentroCostos2 = NULL
  IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','') SELECT @CentroCostos3 = NULL

  -- drop table Resultado1
  IF exists(SELECT * FROM Information_Schema.TABLES WHERE Table_Name = 'Resultado1') DELETE Resultado1 WHERE Estacion = @Estacion
  ELSE
  CREATE TABLE Resultado1 (
	Estacion 	int		NOT NULL,
	Orden		int		NOT NULL,
	ID		int		IDENTITY(1,1) NOT NULL,
	Clase		char(30)	NULL,
	SubClase	char(20)	NULL,
	Rama		char(20)	NULL,
	RamaDesc	varchar(100)	NULL,
	RamaEsAcreedora	bit		NOT NULL DEFAULT 0,
	Cuenta		char(20)	NULL,
	Descripcion	varchar(100)	NULL,
	EsAcreedora	bit		NOT NULL DEFAULT 0,
	SubCta		char(20)	NULL,
	SubDescripcion	varchar(100)	NULL,
	SubEsAcreedora	bit		NULL,
	SubCuenta	varchar(20)	NULL,
	CentroCostos	varchar(100)	NULL,
	Saldo		money		NULL,
	Ingresos	money		NULL,
	Porcentaje	float		NULL,
	SaldoAl		money		NULL,
	IngresosAl	money		NULL,
	PorcentajeAl	float		NULL,
	SaldoPE		money		NULL,
	IngresosPE	money		NULL,
	PorcentajePE	float		NULL,
	SaldoAlPE	money		NULL,
	IngresosAlPE	money		NULL,
	PorcentajeAlPE	float		NULL,
  CONSTRAINT priTempResultado1 PRIMARY KEY CLUSTERED (Estacion, Orden, ID)
)

  IF NOT EXISTS (SELECT * FROM SYSINDEXES WHERE NAME = 'indTempResultado1') 
    CREATE NONCLUSTERED INDEX indTempResultado1 ON Resultado1 (SubCta ASC, SubCuenta ASC)

  IF NOT EXISTS (SELECT * FROM SYSINDEXES WHERE NAME = 'indTempResultado2') 
    CREATE NONCLUSTERED INDEX indTempResultado2 ON Resultado1 ( SubCuenta ASC,SubCta ASC)

  IF NOT EXISTS (SELECT * FROM SYSINDEXES WHERE NAME = 'Cont14') 
    CREATE NONCLUSTERED INDEX Cont14 ON Cont (ID ASC, Moneda ASC, Ejercicio ASC, Periodo ASC, Empresa ASC, Mov ASC, Estatus ASC, Sucursal ASC )

  IF NOT EXISTS (SELECT * FROM SYSINDEXES WHERE NAME = 'DEBEHABER') 
    CREATE NONCLUSTERED INDEX DEBEHABER ON ContD (ID, [Cuenta], [SubCuenta], [Debe], [Haber], [Sucursal])

  SELECT @ConMovs = UPPER(@ConMovs)
      IF @Sucursal<0 SELECT @Sucursal = NULL
  SELECT @CtaResultados   		= CtaResultados,
         @CtaIngresos	   		= CtaIngresos,
         @CtaCostoDirecto 		= CtaCostoDirecto,
         @CtaGastosOperacion		= CtaGastosOperacion,
         @CtaOtrosGastosProductos	= CtaOtrosGastosProductos,
         @CtaImpuestos			= CtaImpuestos
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  INSERT Resultado1
  SELECT @Estacion,
         1, 'Utilidad Bruta',
         'Ventas',
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
         Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         SubCta.Cuenta,
         SubCta.Descripcion,
         SubCta.EsAcreedora,
         SubCuenta = ISNULL(cc.CentroCostos, ''),
         CentroCostos = cc.Descripcion,
         NULL,NULL,NULL,
         NULL,NULL,NULL,
         NULL,NULL,NULL,
         NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama  ON Cta.Rama  = Rama.Cuenta
    LEFT OUTER JOIN Cta SubCta  ON Cta.Cuenta = SubCta.Rama
    LEFT OUTER JOIN CtaSub cs ON Cta.Cuenta = cs.Cuenta 
    LEFT OUTER JOIN CentroCostos cc ON cs.SubCuenta = cc.CentroCostos
   WHERE Cta.Tipo = 'MAYOR'
     AND (Cta.Rama = @CtaIngresos OR Rama.Rama = @CtaIngresos)

  INSERT Resultado1
  SELECT @Estacion,
         2, 'Utilidad Bruta',
         'Costos',
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
         Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         SubCta.Cuenta,
         SubCta.Descripcion,
         SubCta.EsAcreedora,
         SubCuenta = cc.CentroCostos,
         CentroCostos = cc.Descripcion,
         NULL,NULL,NULL,
         NULL,NULL,NULL,
         NULL,NULL,NULL,
         NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama  ON Cta.Rama  = Rama.Cuenta
    LEFT OUTER JOIN Cta SubCta  ON Cta.Cuenta = SubCta.Rama
    LEFT OUTER JOIN CtaSub cs ON Cta.Cuenta = cs.Cuenta 
    LEFT OUTER JOIN CentroCostos cc ON cs.SubCuenta = cc.CentroCostos
   WHERE Cta.Tipo = 'MAYOR'
     AND (Cta.Rama = @CtaCostoDirecto OR Rama.Rama = @CtaCostoDirecto)

  INSERT Resultado1
  SELECT @Estacion,
         3, 'UAFIR',
         'Gastos',
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
         Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         SubCta.Cuenta,
         SubCta.Descripcion,
         SubCta.EsAcreedora,
         SubCuenta = cc.CentroCostos,
         CentroCostos = cc.Descripcion,
         NULL,NULL,NULL,
         NULL,NULL,NULL,
         NULL,NULL,NULL,
         NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama  ON Cta.Rama  = Rama.Cuenta
    LEFT OUTER JOIN Cta SubCta  ON Cta.Cuenta = SubCta.Rama
    LEFT OUTER JOIN CtaSub cs ON Cta.Cuenta = cs.Cuenta 
    LEFT OUTER JOIN CentroCostos cc ON cs.SubCuenta = cc.CentroCostos
   WHERE Cta.Tipo = 'MAYOR'
     AND (Cta.Rama = @CtaGastosOperacion OR Rama.Rama = @CtaGastosOperacion)

  INSERT Resultado1
  SELECT @Estacion,
         4, 'Utilidad Antes de Impuestos',
         'Gastos',
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
         Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         SubCta.Cuenta,
         SubCta.Descripcion,
         SubCta.EsAcreedora,
         SubCuenta = cc.CentroCostos,
         CentroCostos = cc.Descripcion,
         NULL,NULL,NULL,
         NULL,NULL,NULL,
         NULL,NULL,NULL,
         NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama  ON Cta.Rama  = Rama.Cuenta
    LEFT OUTER JOIN Cta SubCta  ON Cta.Cuenta = SubCta.Rama
    LEFT OUTER JOIN CtaSub cs ON Cta.Cuenta = cs.Cuenta 
    LEFT OUTER JOIN CentroCostos cc ON cs.SubCuenta = cc.CentroCostos
   WHERE Cta.Tipo = 'MAYOR'
     AND (Cta.Rama = @CtaOtrosGastosProductos OR Rama.Rama = @CtaOtrosGastosProductos)

  INSERT Resultado1
  SELECT @Estacion,
         5, 'Utilidad Neta',
         'Otros',
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
         Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         SubCta.Cuenta,
         SubCta.Descripcion,
         SubCta.EsAcreedora,
         SubCuenta = cc.CentroCostos,
         CentroCostos = cc.Descripcion,
         NULL,NULL,NULL,
         NULL,NULL,NULL,
         NULL,NULL,NULL,
         NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama  ON Cta.Rama  = Rama.Cuenta
    LEFT OUTER JOIN Cta SubCta  ON Cta.Cuenta = SubCta.Rama
    LEFT OUTER JOIN CtaSub cs ON Cta.Cuenta = cs.Cuenta 
    LEFT OUTER JOIN CentroCostos cc ON cs.SubCuenta = cc.CentroCostos
   WHERE Cta.Tipo = 'MAYOR'
     AND (Cta.Rama = @CtaResultados OR Rama.Rama = @CtaResultados)
     AND (Cta.Rama <> @CtaIngresos AND Rama.Rama <> @CtaIngresos)
     AND (Cta.Rama <> @CtaCostoDirecto AND Rama.Rama <> @CtaCostoDirecto)
     AND (Cta.Rama <> @CtaGastosOperacion AND Rama.Rama <> @CtaGastosOperacion)
     AND (Cta.Rama <> @CtaOtrosGastosProductos AND Rama.Rama <> @CtaOtrosGastosProductos)

  SELECT @Ingresos = Sum(ISNULL(Cargos, 0.0)-ISNULL(Abonos, 0.0))
    FROM Acum
   WHERE Empresa = @Empresa
     AND Rama = 'CONT'
     AND Cuenta = @CtaIngresos
     AND ISNULL(SubCuenta, '') >= ISNULL(ISNULL(@CentroCostosD, SubCuenta), '')
     AND ISNULL(SubCuenta, '') <= ISNULL(ISNULL(@CentroCostosA, SubCuenta), '')
     AND ISNULL(Sucursal, 0) = ISNULL(ISNULL(@Sucursal, Sucursal), 0)
     AND Ejercicio = @Ejercicio
     AND Periodo BETWEEN @PeriodoD AND @PeriodoA
     AND Moneda = @Moneda

  SELECT @IngresosAl = Sum(ISNULL(Cargos, 0.0)-ISNULL(Abonos, 0.0))
    FROM Acum
   WHERE Empresa = @Empresa
     AND Rama = 'CONT'
     AND Cuenta = @CtaIngresos
     AND ISNULL(SubCuenta, '') >= ISNULL(ISNULL(@CentroCostosD, SubCuenta), '')
     AND ISNULL(SubCuenta, '') <= ISNULL(ISNULL(@CentroCostosA, SubCuenta), '')
     AND ISNULL(Sucursal, 0) = ISNULL(ISNULL(@Sucursal, Sucursal), 0)
     AND Moneda = @Moneda
     AND Ejercicio = @Ejercicio
     AND Periodo = @PeriodoA

  UPDATE Resultado1
     SET Saldo = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                    FROM Acum a
	           WHERE a.Cuenta = ISNULL(NULLIF(b.SubCta, ''), b.Cuenta)
                     AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(b.SubCuenta, a.SubCuenta), '')
                     AND a.Empresa = @Empresa
                     AND a.Rama = 'CONT'
                     AND ISNULL(a.SubCuenta, '') >= ISNULL(ISNULL(@CentroCostosD, a.SubCuenta), '')
                     AND ISNULL(a.SubCuenta, '') <= ISNULL(ISNULL(@CentroCostosA, a.SubCuenta), '')   
                     AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
                     AND a.Moneda = @Moneda
                     AND a.Ejercicio = @Ejercicio
                     AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA)
    FROM Resultado1 b WHERE Estacion = @Estacion

  UPDATE Resultado1
     SET Ingresos = @Ingresos,
         Porcentaje = (Saldo/(CASE WHEN @Ingresos = 0 THEN 1 ELSE @Ingresos END))*100 WHERE Estacion = @Estacion

  UPDATE Resultado1
     SET SaldoAl = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                      FROM Acum a
                     WHERE a.Cuenta = ISNULL(NULLIF(b.SubCta, ''), b.Cuenta)
                       AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(b.SubCuenta, a.SubCuenta), '')
		       AND a.Empresa = @Empresa
                       AND a.Rama = 'CONT'
                       AND ISNULL(a.SubCuenta, '') >= ISNULL(ISNULL(@CentroCostosD, a.SubCuenta), '')
                       AND ISNULL(a.SubCuenta, '') <= ISNULL(ISNULL(@CentroCostosA, a.SubCuenta), '')
                       AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
                       AND a.Moneda = @Moneda
                       AND a.Ejercicio = @Ejercicio
                       AND a.Periodo = @PeriodoA)
    FROM Resultado1 b WHERE Estacion = @Estacion

  UPDATE Resultado1
     SET IngresosAl = @IngresosAl,
         PorcentajeAl = (SaldoAl/(CASE WHEN @IngresosAl = 0 THEN 1 ELSE @IngresosAl END))*100 WHERE Estacion = @Estacion

  SELECT @IngresosPE = Sum(ISNULL(y.Debe, 0.0)) - Sum(ISNULL(y.Haber, 0.0))
    FROM Cont x
    JOIN ContD y ON x.ID = y.ID
   WHERE x.Mov = 'Presupuesto'
     AND x.Estatus = 'CONCLUIDO'
     AND x.Empresa = @Empresa
     AND y.Cuenta = @CtaIngresos
     AND ISNULL(y.SubCuenta, '') >= ISNULL(ISNULL(@CentroCostosD, y.SubCuenta), '')
     AND ISNULL(y.SubCuenta, '') <= ISNULL(ISNULL(@CentroCostosA, y.SubCuenta), '')
     AND ISNULL(x.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, x.Sucursal), 0)
     AND x.Moneda = @Moneda
     AND x.Ejercicio = @Ejercicio
     AND x.Periodo BETWEEN @PeriodoD AND @PeriodoA

  SELECT @IngresosAlPE = Sum(ISNULL(y.Debe, 0.0)) - Sum(ISNULL(y.Haber, 0.0))
    FROM Cont x
    JOIN ContD y ON x.ID = y.ID
   WHERE x.Mov = 'Presupuesto'
     AND x.Estatus = 'CONCLUIDO'
     AND x.Empresa = @Empresa
     AND y.Cuenta = @CtaIngresos
     AND ISNULL(y.SubCuenta, '') >= ISNULL(ISNULL(@CentroCostosD, y.SubCuenta), '')
     AND ISNULL(y.SubCuenta, '') <= ISNULL(ISNULL(@CentroCostosA, y.SubCuenta), '')
     AND ISNULL(x.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, x.Sucursal), 0)
     AND x.Moneda = @Moneda
     AND x.Ejercicio = @Ejercicio
     AND x.Periodo = @PeriodoA

  SELECT y.Cuenta, SubCuenta = ISNULL(y.SubCuenta, ''), SaldoP = Sum(ISNULL(y.Debe, 0.0)) - Sum(ISNULL(y.Haber, 0.0))
    INTO #SaldoPEx
    FROM Cont x
    JOIN ContD y ON x.ID = y.ID
   WHERE x.Mov = 'Presupuesto'
     AND x.Estatus = 'CONCLUIDO'
     AND x.Empresa = @Empresa
     AND x.Moneda = @Moneda
     AND x.Ejercicio = @Ejercicio
     AND x.Periodo BETWEEN @PeriodoD AND @PeriodoA
     AND ISNULL(y.SubCuenta, '') >= ISNULL(ISNULL(@CentroCostosD, y.SubCuenta), '')
     AND ISNULL(y.SubCuenta, '') <= ISNULL(ISNULL(@CentroCostosA, y.SubCuenta), '')
     AND ISNULL(x.Sucursal, 0)    = ISNULL(ISNULL(@Sucursal, x.Sucursal), 0)
   GROUP BY y.Cuenta, y.SubCuenta                       
  HAVING Sum(ISNULL(y.Debe, 0.0)) - Sum(ISNULL(y.Haber, 0.0)) <> 0.0

  UPDATE Resultado1
     SET SaldoPE = a.SaldoP
    FROM #SaldoPEx a
    JOIN Resultado1 b ON a.Cuenta  = ISNULL(NULLIF(b.SubCta, ''), b.Cuenta) AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(b.SubCuenta, a.SubCuenta), '')
   WHERE b.Estacion = @Estacion

  UPDATE Resultado1
     SET IngresosPE = @IngresosPE,
         PorcentajePE = (SaldoPE/@IngresosPE)*100 WHERE Estacion = @Estacion

  SELECT y.Cuenta, SubCuenta = ISNULL(y.SubCuenta, ''), SaldoAlP = Sum(ISNULL(y.Debe, 0.0)) - Sum(ISNULL(y.Haber, 0.0))
    INTO #SaldoAlPEx
    FROM Cont x
    JOIN ContD y ON x.ID = y.ID
   WHERE x.Mov = 'Presupuesto'
     AND x.Estatus = 'CONCLUIDO'
     AND x.Empresa = @Empresa
     AND x.Moneda = @Moneda
     AND x.Ejercicio = @Ejercicio
     AND x.Periodo = @PeriodoA
     AND ISNULL(y.SubCuenta, '') >= ISNULL(ISNULL(@CentroCostosD, y.SubCuenta), '')
     AND ISNULL(y.SubCuenta, '') <= ISNULL(ISNULL(@CentroCostosA, y.SubCuenta), '')
     AND ISNULL(x.Sucursal, 0)    = ISNULL(ISNULL(@Sucursal, x.Sucursal), 0)
   GROUP BY y.Cuenta, y.SubCuenta                       
  HAVING Sum(ISNULL(y.Debe, 0.0)) - Sum(ISNULL(y.Haber, 0.0)) <> 0.0

  UPDATE Resultado1
     SET SaldoAlPE = a.SaldoAlP
    FROM #SaldoAlPEx a
    JOIN Resultado1 b ON a.Cuenta  = ISNULL(NULLIF(b.SubCta, ''), b.Cuenta) AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(b.SubCuenta, a.SubCuenta), '')
   WHERE b.Estacion = @Estacion

  UPDATE Resultado1
     SET IngresosAlPE = @IngresosAlPE,
         PorcentajeAlPE = (SaldoAlPE/@IngresosAlPE)*100 WHERE Estacion = @Estacion
  
  --REQ2162
  IF @ReExpresar='Si'
    UPDATE Resultado1
	   SET Ingresos=Ingresos/ISNULL(@ReExpresarTipoCambio,1),
	       SaldoAl=SaldoAl/ISNULL(@ReExpresarTipoCambio,1),
	       IngresosAl=IngresosAl/ISNULL(@ReExpresarTipoCambio,1),
	       SaldoPE=SaldoPE/ISNULL(@ReExpresarTipoCambio,1),
	       IngresosPE=IngresosPE/ISNULL(@ReExpresarTipoCambio,1),
	       SaldoAlPE=SaldoAlPE/ISNULL(@ReExpresarTipoCambio,1),
	       IngresosAlPE=IngresosAlPE/ISNULL(@ReExpresarTipoCambio,1)
	 WHERE Estacion = @Estacion

  IF @OrdenCC = 'NO'
  BEGIN
    IF @ConMovs = 'SI'
    SELECT r.*, "Grupo" = CONVERT(varchar(50), null), "SubGrupo" = CONVERT(varchar(50), null), "SubSubGrupo" = CONVERT(varchar(50), NULL)
      FROM Resultado1 r
     WHERE (ISNULL(r.Saldo, 0.0) <> 0.0 OR ISNULL(r.SaldoAl, 0.0) <> 0.0 OR ISNULL(r.SaldoPE, 0.0) <> 0.0 OR ISNULL(r.SaldoAlPE, 0.0) <> 0.0) AND r.Estacion = @Estacion
     ORDER BY r.Orden, r.SubCta, r.SubCuenta, r.ID
  ELSE
    SELECT r.*, "Grupo" = CONVERT(varchar(50), null), "SubGrupo" = CONVERT(varchar(50), null), "SubSubGrupo" = CONVERT(varchar(50), NULL)
      FROM Resultado1 r
     WHERE r.Estacion = @Estacion
     ORDER BY r.Orden, r.SubCta, r.SubCuenta, r.ID
  END ELSE
  BEGIN
    IF @CCGrupo <> 'NULL'
    BEGIN
      IF @ConMovs = 'SI'
      SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo
        FROM Resultado1 r JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos AND cc.Grupo = ISNULL(@CCGrupo, cc.Grupo)
       WHERE (ISNULL(r.Saldo, 0.0) <> 0.0 OR ISNULL(r.SaldoAl, 0.0) <> 0.0 OR ISNULL(r.SaldoPE, 0.0) <> 0.0 OR ISNULL(r.SaldoAlPE, 0.0) <> 0.0) AND r.Estacion = @Estacion
       ORDER BY r.Orden, r.Rama, r.SubCta, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
      ELSE
      SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo
        FROM Resultado1 r JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos AND cc.Grupo = ISNULL(@CCGrupo, cc.Grupo)
       WHERE r.Estacion = @Estacion
       ORDER BY r.Orden, r.Rama, r.SubCta, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
    END ELSE
    BEGIN
      IF @ConMovs = 'SI'
      SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo
        FROM Resultado1 r LEFT OUTER JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos
       WHERE (ISNULL(r.Saldo, 0.0) <> 0.0 OR ISNULL(r.SaldoAl, 0.0) <> 0.0  OR ISNULL(r.SaldoPE, 0.0) <> 0.0 OR ISNULL(r.SaldoAlPE, 0.0) <> 0.0) AND r.Estacion = @Estacion
       ORDER BY r.Orden, r.Rama, r.SubCta, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
      ELSE
      SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo
        FROM Resultado1 r LEFT OUTER JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos
       WHERE r.Estacion = @Estacion
       ORDER BY r.Orden, r.Rama, r.SubCta, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
    END
  END
END
GO

/**************** spContAuxInt ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContAuxInt') and type = 'P') drop procedure dbo.spContAuxInt
go
CREATE PROC spContAuxInt
 ( @Empresa 		Char(5),
   @Estatus 		Char(10),
   @CuentaD 		Char(20),
   @CuentaA 		Char(20),
   @FechaD 		DateTime,
   @FechaA 		DateTime,
   @MovEspecifico 	char(20) = NULL,
   @CtaCat 		char(20) = NULL,
   @CtaFam 		char(20) = NULL,
   @CtaGrupo 		char(20) = NULL  )
WITH ENCRYPTION
AS
BEGIN
 
 IF UPPER(@MovEspecifico) IN ('0', 'NULL', '(TODOS)','') SELECT @MovEspecifico = NULL
 IF UPPER(@CtaCat)        IN ('0', 'NULL', '(TODOS)','') SELECT @CtaCat = NULL
 IF UPPER(@CtaFam)        IN ('0', 'NULL', '(TODOS)','') SELECT @CtaFam = NULL
 IF UPPER(@CtaGrupo)      IN ('0', 'NULL', '(TODOS)','') SELECT @CtaGrupo = NULL
 
 
 SELECT ContAux.ID,
        ContAux.Empresa,
        ContAux.Cuenta,
        ContAux.SubCuenta,
        ContAux.Ejercicio,
        ContAux.Periodo,
        ContAux.Renglon,
        ContAux.RenglonSub,
        ContAux.Concepto,
        ContAux.Debe,
        ContAux.Haber,
        ContAux.FechaContable,
        ContAux.Movimiento,
        ContMov = ContAux.Mov,
        ContAux.Referencia,
        ContAux.Estatus
   INTO #TempContAux
   FROM ContAux
  WHERE ContAux.Empresa = @Empresa
    AND ContAux.Estatus = @Estatus
    AND ContAux.Cuenta  >=  @CuentaD AND ContAux.Cuenta  <=  @CuentaA 
    AND ContAux.FechaContable  >=  @FechaD AND ContAux.FechaContable  <=  @FechaA 
    AND ContAux.Mov = ISNULL(@MovEspecifico, ContAux.Mov)
  ORDER BY ContAux.Cuenta, ContAux.FechaContable, ContAux.ID 

 SELECT t.ID,
        t.Empresa,
	t.Cuenta,
	t.SubCuenta,
	t.Ejercicio,
	t.Periodo,
	t.Renglon,
	t.RenglonSub,
	t.Concepto,
	t.Debe,
	t.Haber,
	t.FechaContable,
	t.Movimiento,
	t.Referencia,
	t.Estatus,
        Cta.Descripcion,
        Cta.Cuenta AS 'CtaCuenta'
   FROM Cta
   LEFT OUTER JOIN #TempContAux t ON Cta.Cuenta = t.Cuenta
  WHERE Cta.Cuenta BETWEEN @CuentaD AND @CuentaA --AND Cta.Tipo in ('SubCuenta','Auxiliar', 'Mayor')
    AND Cta.TieneMovimientos = 1 AND Cta.EsAcumulativa = 0 
    AND ISNULL(Cta.Categoria, 0) = ISNULL(ISNULL(@CtaCat, Cta.Categoria), 0)
    AND ISNULL(Cta.Familia, 0) = ISNULL(ISNULL(@CtaFam, Cta.Familia), 0)
    AND ISNULL(Cta.Grupo, 0) = ISNULL(ISNULL(@CtaGrupo, Cta.Grupo), 0)
  ORDER BY Cta.Cuenta, t.FechaContable, t.ID  ASC
END
GO


/*************** spAuditoriaSaldo *******************/
if exists (select * from sysobjects where id = object_id('dbo.spAuditoriaSaldo') and type = 'P') drop procedure dbo.spAuditoriaSaldo
GO

CREATE PROCEDURE spAuditoriaSaldo
	@Empresa	char(5),
	@Sucursal	int,
	@ContactoTipo	varchar(20),
	@ClienteD	char(10),
	@ClienteA	char(10),
	@ProvD		char(10),
	@ProvA		char(10)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
	@CtaActivo		char(20),
	@CtaPasivo		char(20)

  IF UPPER(@ClienteD) IN ('0', 'NULL', '(TODOS)') SELECT @ClienteD = NULL, @ClienteA = NULL
  IF UPPER(@ProvD)    IN ('0', 'NULL', '(TODOS)') SELECT @ProvD = NULL, @ProvA = NULL

  SELECT @CtaActivo	  = CtaActivo,
         @CtaPasivo	  = CtaPasivo
    FROM EmpresaCfg a
   WHERE Empresa = @Empresa

  CREATE TABLE #Contacto (
	Contacto	char(10)	COLLATE Database_Default NULL,
	Nombre		varchar(100)	COLLATE Database_Default NULL)

  CREATE TABLE #CtaEstruc(
	Cuenta			char(20)	COLLATE Database_Default NULL,
	Descripcion		varchar(100)	COLLATE Database_Default NULL)

  -- Lelna tabla con cuentas a considerar
  IF @ContactoTipo = 'Cliente'
  BEGIN
    INSERT #CtaEstruc(Cuenta, Descripcion)
    SELECT Cta.Cuenta,
           Cta.Descripcion
      FROM Cta
      JOIN Cta E2 ON Cta.Rama = E2.Cuenta
      JOIN Cta E1 ON E2.Rama = E1.Cuenta
     WHERE UPPER(Cta.Tipo) = 'MAYOR'
       AND (Cta.Rama = @CtaActivo OR E1.Rama = @CtaActivo OR E2.Rama = @CtaActivo)
  END
  ELSE
  BEGIN
    INSERT #CtaEstruc(Cuenta, Descripcion)
    SELECT Cta.Cuenta,
           Cta.Descripcion
      FROM Cta
      JOIN Cta E2 ON Cta.Rama = E2.Cuenta
      JOIN Cta E1 ON E2.Rama = E1.Cuenta
     WHERE UPPER(Cta.Tipo) = 'MAYOR'
       AND (Cta.Rama = @CtaPasivo OR E1.Rama = @CtaPasivo OR E2.Rama = @CtaPasivo)
  END

  IF @ContactoTipo = 'Cliente' AND @ClienteD = NULL AND @ClienteA = NULL
  BEGIN
    SELECT @ClienteD = MIN(Cliente) FROM Cte
    SELECT @ClienteA = MAX(Cliente) FROM Cte
  END

  IF @ContactoTipo = 'Proveedor' AND @ProvD = NULL AND @ProvA = NULL
  BEGIN
    SELECT @ProvD = MIN(Proveedor) FROM Prov
    SELECT @ProvA = MAX(Proveedor) FROM Prov
  END

  -- Define Contactos
  IF @ContactoTipo = 'Cliente'
  BEGIN
    INSERT #Contacto(Contacto, Nombre) 
    SELECT Cliente, Nombre
      FROM Cte
     WHERE Estatus = 'ALTA'
  END
  ELSE
  BEGIN
    INSERT #Contacto(Contacto, Nombre)     
    SELECT Proveedor, Nombre
      FROM Prov
     WHERE Estatus = 'ALTA'
  END

  -- Identifica los Contactos (Cliente, Proveedor) por el tipo y suma importes
  SELECT a.Contacto, Importe = ISNULL(SUM(b.Debe * a.TipoCambio), 0) - ISNULL(SUM(b.Haber * a.TipoCambio), 0)
    INTO #ContaSaldo
    FROM Cont a
    JOIN ContD b ON a.ID = b.ID
    JOIN MovTipo mt ON a.Mov = mt.Mov  
    JOIN Cta ON b.Cuenta = Cta.Cuenta
   WHERE mt.Modulo = 'CONT'
     AND mt.Clave = 'CONT.P'
     AND a.Empresa = @Empresa
     AND a.Estatus = 'CONCLUIDO'
     AND ISNULL(a.Contacto, '') <> ''
     AND a.ContactoTipo = @ContactoTipo --REQ 13147
     AND Cta.Descripcion Like @ContactoTipo+'%'
     AND ((Cta.Rama IN (SELECT Cuenta FROM #CtaEstruc)) OR (Cta.Cuenta IN (SELECT Cuenta FROM #CtaEstruc)))
     AND a.Sucursal = ISNULL(@Sucursal, a.Sucursal)
     AND a.Contacto >= CASE WHEN @ClienteD IS NULL THEN @ProvD ELSE @ClienteD END
     AND a.Contacto <= CASE WHEN @ClienteD IS NULL THEN @ProvA ELSE @ClienteA END
   GROUP BY a.Contacto, a.ContactoTipo
   ORDER BY a.ContactoTipo, a.Contacto
  
  -- Obtiene Saldo de los Contactos
  SELECT s.Cuenta, Saldo = ISNULL(SUM(s.Saldo*m.TipoCambio), 0)
    INTO #SaldoC
    FROM Saldo s
    JOIN Mon m ON s.Moneda = m.Moneda
   WHERE s.Empresa = @Empresa
     AND s.Rama = CASE WHEN @ContactoTipo = 'Cliente' THEN 'CXC' ELSE 'CXP' END
     AND s.Saldo <> 0
     AND s.Sucursal = ISNULL(@Sucursal, Sucursal)
     AND s.Cuenta >= CASE WHEN @ClienteD IS NULL THEN @ProvD ELSE @ClienteD END
     AND s.Cuenta <= CASE WHEN @ClienteD IS NULL THEN @ProvA ELSE @ClienteA END
   GROUP BY s.Cuenta, s.Rama
   ORDER BY s.Cuenta

  -- Compara importes
  SELECT a.Contacto, a.Nombre, b.Importe, c.Saldo
    FROM #Contacto a
    LEFT OUTER JOIN #ContaSaldo b ON a.Contacto = b.Contacto
    LEFT OUTER JOIN #SaldoC c ON a.Contacto = c.Cuenta
   WHERE (ISNULL(b.Importe, 0) <> 0 OR ISNULL(c.Saldo, 0) <> 0)
   ORDER BY a.Contacto

END
GO

/*
spAuditoriaSaldo '100',	103, 'Pesos', 'Cliente', '20410', '20410', NULL, NULL
*/

if not exists(select * from SysTabla where SysTabla = 'InvValPepsUeps')
INSERT INTO SysTabla (SysTabla) VALUES ('InvValPepsUeps')
if exists (select * from sysobjects where id = object_id('dbo.InvValPepsUeps') and type = 'U')
DROP TABLE dbo.InvValPepsUeps
CREATE TABLE dbo.InvValPepsUeps (
	Articulo		char(20)	NULL,
	SubCuenta		varchar(20)	NULL,
	Descripcion		varchar(100)	NULL,
	Mov			char(20)	NULL,
	MovID			varchar(20)	NULL,
	Moneda			char(10)	NULL,
	Fecha			Datetime	NULL,
	Almacen			char(10)	NULL,
	Existencia		float		NULL,
	Costo			money		NULL)
GO

EXEC spAlter_Table 'InvValPepsUeps', 'Estacion', 'int NULL'
EXEC spAlter_Table 'InvValPepsUeps', 'Activo', 'int NULL'
EXEC spAlter_Table 'InvValPepsUeps', 'ID', 'int NULL'
EXEC spAlter_Table 'InvValPepsUeps', 'ExistD', 'float NULL'
GO

/****** InvValPU ******/
if not exists(select * from SysTabla where SysTabla = 'InvValPU')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InvValPU','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.InvValPU') and type = 'U') 
  CREATE TABLE InvValPU (
	Estacion		int		NULL,
	Articulo		char(20)	NULL,
	SubCuenta		varchar(20)	NULL,
	Descripcion		varchar(100)	NULL,
	Mov			char(20)	NULL,
	MovID			varchar(20)	NULL,
	Moneda			char(10)	NULL,
	Fecha			Datetime	NULL,
	Existencia		float		NULL,
	Costo			money		NULL,
        Activo			int		NULL,
	ID			int		NULL,
	ExistD			float		NULL,
	CostoT			money		NULL)
GO
EXEC spAlter_Table 'InvValPU', 'Estacion', 'int NULL'
EXEC spAlter_Table 'InvValPU', 'CostoT', 'Money NULL'
GO


/**************** spInvValPepsUeps ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvValPepsUeps') and type = 'P') drop procedure dbo.spInvValPepsUeps
GO             
CREATE PROCEDURE spInvValPepsUeps
		@Estacion	int,
		@ArticuloD	char(20),
		@ArticuloA	char(20),
		@Almacen	char(10),
		@InvVal		varchar(20),
		@FechaA		Datetime,
		@Empresa	char(5)

--//WITH ENCRYPTION
AS BEGIN

  DECLARE
	@Articulo1	char(20),
	@SubCuenta	varchar(20),
	@Descripcion	varchar(100),
	@Inventario	float,
	@Articulox	char(20),
	@ArtAnterior1	char(20),
	@ArtAnterior	char(20),
	@SubCuentax	varchar(50),
	@Descripcionx	varchar(100),
	@Movx		char(20),
	@MovIDx		varchar(20),
	@Monedax	char(10),
	@Fechax		Datetime,
	@Existenciax	float,
	@Costox		money,
	@Activox	bit,
	@IDx		int,
	@Art1		char(20),
	@Subc1		varchar(50),
	@Exist1		float,
	@Mov1		char(20),
	@MovID1		varchar(20),
	@ID1		int,
	@Artz		char(20),
	@Subcz		varchar(50),
	@Existz		float,
	@Movz		char(20),
	@MovIDz		varchar(20),
	@IDz		int,
	@ExistP		float,
	@Inicio		float,
	@ArticuloE	char(20),
	@SubCuentaE	varchar(50),
	@DescripcionE	varchar(100),
	@InventarioE	float,
	@Cantidad	float,
	@Acum		float,
	@Acum1		float,
	@Fuera		int,
	@SumaSal	float,
	@DifEnt		float,
	@ResEnt		float,
	@Articuloz	char(20),
	@SubCuentaz	varchar(50),
	@Descripcionz	varchar(100)

  IF @Almacen IN ('NULL', '(TODOS)', '') SELECT @Almacen = NULL
  DELETE InvValPU       WHERE Estacion = @Estacion
  DELETE InvValPepsUeps WHERE Estacion = @Estacion

  CREATE TABLE #ExistenciaInv (
	Articulo		char(20)	COLLATE Database_Default NULL,
	SubCuenta		varchar(50)	COLLATE Database_Default NULL,
	Descripcion1		varchar(100)	COLLATE Database_Default NULL,
	Almacen			char(20)	COLLATE Database_Default NULL,
	Disponible		float		NULL)

  INSERT #ExistenciaInv
        (Articulo,   SubCuenta,   Descripcion1,   Disponible)
  SELECT a.Articulo, a.SubCuenta, b.Descripcion1, SUM(a.Disponible)
    FROM ArtSubDisponible a
    JOIN Art b ON a.Articulo = b.Articulo
   WHERE a.Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND ISNULL(a.Almacen, '') = ISNULL(ISNULL(@Almacen, a.Almacen), '')
     AND a.Empresa = @Empresa
   GROUP BY a.Articulo, a.SubCuenta, b.Descripcion1

 DECLARE CrExist CURSOR FOR 
  SELECT Articulo, SubCuenta, Descripcion1, Disponible
    FROM #ExistenciaInv
    OPEN CrExist
   FETCH NEXT FROM CrExist INTO @ArticuloE, @SubCuentaE, @DescripcionE, @InventarioE
   WHILE @@FETCH_STATUS <> -1
   BEGIN
     IF @@FETCH_STATUS <> -2 
     BEGIN
       SELECT @Cantidad = SUM(ISNULL(a.CargoU, 0) - ISNULL(a.AbonoU, 0)) * -1
         FROM InvAuxU a
        WHERE a.Articulo = @ArticuloE
          AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@SubCuentaE, a.SubCuenta), '')
          AND ISNULL(a.Grupo, '')     = ISNULL(ISNULL(@Almacen, a.Grupo), '')
          AND a.Rama = 'INV'
          AND a.Empresa = @Empresa
          AND a.Fecha BETWEEN @FechaA+1 AND GETDATE()
       UPDATE #ExistenciaInv SET Disponible = Disponible + @Cantidad WHERE Articulo = @ArticuloE AND SubCuenta = @SubCuentaE

     END
     FETCH NEXT FROM CrExist INTO @ArticuloE, @SubCuentaE, @DescripcionE, @InventarioE
   END
   CLOSE CrExist
   DEALLOCATE CrExist

  -- Define Costos 
 DECLARE CrValCost CURSOR FOR 
  SELECT Articulo, SubCuenta, Descripcion1, Disponible
    FROM #ExistenciaInv
    OPEN CrValCost
   FETCH NEXT FROM CrValCost INTO @Articulo1, @SubCuenta, @Descripcion, @Inventario
   WHILE @@FETCH_STATUS <> -1
   BEGIN
     IF @@FETCH_STATUS <> -2 
     BEGIN
       INSERT InvValPepsUeps 
             (Estacion,  Articulo,   SubCuenta,  Descripcion,  Mov,   MovID,   Moneda,   Fecha,   Existencia, ID, ExistD, Costo)
       SELECT @Estacion, @Articulo1, @SubCuenta, @Descripcion, a.Mov, a.MovID, a.Moneda, a.Fecha, Cantidad = ISNULL(a.CargoU, 0) - ISNULL(a.AbonoU, 0), a.ID, @Inventario,
              Costo = CASE a.Modulo WHEN 'INV'  THEN (SELECT TOP 1 (ISNULL(y.CostoInv, y.Costo) * x.TipoCambio) FROM Inv x, InvD y WHERE x.ID = y.ID AND x.Mov = a.Mov AND x.MovID = a.MovID AND y.Articulo = a.Articulo)
                                    WHEN 'COMS' THEN (SELECT TOP 1 (ISNULL(y.CostoInv, y.Costo) * x.TipoCambio) FROM Compra x, CompraD y WHERE x.ID = y.ID AND x.Mov = a.Mov AND x.MovID = a.MovID AND y.Articulo = a.Articulo)
                                    WHEN 'VTAS' THEN (SELECT TOP 1 (y.Costo * x.TipoCambio) FROM Venta x, VentaD y WHERE x.ID = y.ID AND x.Mov = a.Mov AND x.MovID = a.MovID AND y.Articulo = a.Articulo)
                                    WHEN 'PROD' THEN (SELECT TOP 1 (y.Costo * x.TipoCambio) FROM Prod x, ProdD y WHERE x.ID = y.ID AND x.Mov = a.Mov AND x.MovID = a.MovID AND y.Articulo = a.Articulo) END
         FROM InvAuxU a
        WHERE a.Articulo = @Articulo1
          AND a.Rama = 'INV'
          AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@SubCuenta, a.SubCuenta), '')
          AND ISNULL(a.Grupo, '')     = ISNULL(ISNULL(@Almacen, a.Grupo), '')
          AND a.Fecha <= @FechaA
          AND a.Empresa = @Empresa
        ORDER BY a.Fecha
     END
     FETCH NEXT FROM CrValCost INTO @Articulo1, @SubCuenta, @Descripcion, @Inventario
   END
   CLOSE CrValCost
   DEALLOCATE CrValCost

   UPDATE InvValPepsUeps SET Activo = CASE WHEN Existencia > 0 THEN 1 ELSE 0 END WHERE Estacion = @Estacion

  IF RTRIM(@InvVal) = 'PEPS'
  BEGIN
    INSERT InvValPU 
          (Estacion,  Articulo, SubCuenta, Descripcion, Mov, MovID, Moneda, Fecha, Existencia, Costo, Activo, ID, ExistD)
    SELECT @Estacion, Articulo, SubCuenta, Descripcion, Mov, MovID, Moneda, Fecha, Existencia, Costo, Activo, ID, ExistD
      FROM InvValPepsUeps
     WHERE Activo = 1
       AND Estacion = @Estacion
     ORDER BY Moneda, Articulo, SubCuenta, Fecha 
  END
  ELSE
  BEGIN
    INSERT InvValPU 
          (Estacion,  Articulo, SubCuenta, Descripcion, Mov, MovID, Moneda, Fecha, Existencia, Costo, Activo, ID, ExistD)
    SELECT @Estacion, Articulo, SubCuenta, Descripcion, Mov, MovID, Moneda, Fecha, Existencia, Costo, Activo, ID, ExistD
      FROM InvValPepsUeps
     WHERE Activo = 1
       AND Estacion = @Estacion
     ORDER BY Moneda, Articulo, SubCuenta, Fecha DESC
  END

  SELECT @Inicio = 0.0, @ExistP = 0.0, @ArtAnterior1 = ''

 DECLARE CrInvValT CURSOR FOR 
  SELECT Articulo, SubCuenta, Descripcion1
    FROM #ExistenciaInv
    OPEN CrInvValT
   FETCH NEXT FROM CrInvValT INTO @Articuloz, @SubCuentaz, @Descripcionz
   WHILE @@FETCH_STATUS <> -1
   BEGIN
     IF @@FETCH_STATUS <> -2 
     BEGIN
       IF EXISTS(SELECT ABS(SUM(Existencia)) FROM InvValPepsUeps WHERE Activo = 0 AND Articulo = @Articuloz AND ISNULL(SubCuenta, '') = ISNULL(ISNULL(@SubCuentaz, SubCuenta), '') AND Estacion = @Estacion)
         SELECT @SumaSal = ABS(SUM(Existencia)) FROM InvValPepsUeps WHERE Activo = 0 AND Articulo = @Articuloz AND ISNULL(SubCuenta, '') = ISNULL(ISNULL(@SubCuentaz, SubCuenta), '') AND Estacion = @Estacion
       ELSE 
         SELECT @SumaSal = 0
       SELECT @Acum = 0, @Acum1 = 0, @Fuera = 0

       IF RTRIM(@InvVal) = 'PEPS'
       BEGIN
         DECLARE CrInvValPU CURSOR LOCAL FOR 
          SELECT Articulo, SubCuenta, Descripcion, Mov, MovID, Moneda, Fecha, Existencia, Costo, Activo, ID
            FROM InvValPU
           WHERE Articulo = @Articuloz
             AND ISNULL(SubCuenta, '') = ISNULL(ISNULL(@SubCuentaz, SubCuenta), '')
             AND Estacion = @Estacion
           ORDER BY Moneda, Articulo, SubCuenta, Fecha
            OPEN CrInvValPU
           FETCH NEXT FROM CrInvValPU INTO @Articulox, @SubCuentax, @Descripcionx, @Movx, @MovIDx, @Monedax, @Fechax, @Existenciax, @Costox, @Activox, @IDx
       END
       ELSE
       BEGIN
         DECLARE CrInvValPU CURSOR LOCAL FOR 
          SELECT Articulo, SubCuenta, Descripcion, Mov, MovID, Moneda, Fecha, Existencia, Costo, Activo, ID
            FROM InvValPU
           WHERE Articulo = @Articuloz
             AND ISNULL(SubCuenta, '') = ISNULL(ISNULL(@SubCuentaz, SubCuenta), '')
             AND Estacion = @Estacion
           ORDER BY Moneda, Articulo, SubCuenta, Fecha DESC
            OPEN CrInvValPU
           FETCH NEXT FROM CrInvValPU INTO @Articulox, @SubCuentax, @Descripcionx, @Movx, @MovIDx, @Monedax, @Fechax, @Existenciax, @Costox, @Activox, @IDx
       END
       WHILE @@FETCH_STATUS <> -1
       BEGIN
         IF @@FETCH_STATUS <> -2 
         BEGIN
           SELECT @Acum = @Acum + @Existenciax
           SELECT @Acum1 = @Acum1 + @Existenciax
           IF @Acum1 > ISNULL(@SumaSal, 0) AND @Fuera = 0
           BEGIN
             SELECT @Acum = @Acum - @Existenciax
             SELECT @DifEnt = ISNULL(@SumaSal, 0) - @Acum
             SELECT @ResEnt = @Existenciax - @DifEnt
             UPDATE InvValPU SET Existencia = @ResEnt WHERE Articulo = @Articulox AND ISNULL(SubCuenta, '') = ISNULL(ISNULL(@SubCuentax, SubCuenta), '') AND Mov = @Movx AND MovID = @MovIDx AND ID = @IDx AND Estacion = @Estacion
             SELECT @Fuera = 1
           END
           ELSE
           BEGIN
             IF @Fuera = 0
             UPDATE InvValPU SET Activo = 2 WHERE Articulo = @Articulox AND ISNULL(SubCuenta, '') = ISNULL(ISNULL(@SubCuentax, SubCuenta), '') AND Mov = @Movx AND MovID = @MovIDx AND ID = @IDx AND Estacion = @Estacion
           END
         END
         FETCH NEXT FROM CrInvValPU INTO @Articulox, @SubCuentax, @Descripcionx, @Movx, @MovIDx, @Monedax, @Fechax, @Existenciax, @Costox, @Activox, @IDx
       END
       CLOSE CrInvValPU
       DEALLOCATE CrInvValPU
     END
     FETCH NEXT FROM CrInvValT INTO @Articuloz, @SubCuentaz, @Descripcionz
   END
   CLOSE CrInvValT
   DEALLOCATE CrInvValT

  SELECT Articulo, SubCuenta, CostoTPU = SUM(Costo * Existencia)
    INTO #CostoPU
    FROM InvValPU
   WHERE Activo = 1
     AND Estacion = @Estacion
   GROUP BY Articulo, SubCuenta

  UPDATE InvValPU SET CostoT = a.CostoTPU FROM #CostoPU a, InvValPU b WHERE b.Articulo = a.Articulo AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(b.SubCuenta, a.SubCuenta), '') AND b.Estacion = @Estacion

  IF RTRIM(@InvVal) = 'UEPS'
  SELECT * FROM InvValPU WHERE Activo = 1 AND Estacion = @Estacion ORDER BY Moneda, Articulo, SubCuenta, Fecha DESC
  ELSE
  IF RTRIM(@InvVal) = 'PEPS'
  SELECT * FROM InvValPU WHERE Activo = 1 AND Estacion = @Estacion ORDER BY Moneda, Articulo, SubCuenta, Fecha
  ELSE 
  SELECT * FROM InvValPU WHERE Activo = 1 AND Estacion = @Estacion ORDER BY Moneda, Articulo, SubCuenta, Fecha


END
GO

/**************** spSistemaDetallista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSistemaDetallista') and type = 'P') drop procedure dbo.spSistemaDetallista
GO             
CREATE PROCEDURE spSistemaDetallista
		@DeptoD		int,
		@DeptoA		int,
		@FechaA		Datetime,
		@Sucursal	int,
		@Estacion	int,
		@Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
	@Concepto		varchar(50),
	@CuentaCosto		money,
	@CuentaPrecio		money,
	@Orden			int,
	@Departamento		int	

  DELETE ReporteSistemaDetallista WHERE Estacion = @Estacion

  -- Calcula el Costo de las Cuentas específicas
  SELECT a.Cuenta, CostoD = SUM(ISNULL(a.Debe, 0) - ISNULL(a.Haber, 0)), a.DepartamentoDetallista, b.Concepto
    INTO #CostoD
    FROM ContAux a
    JOIN cfgSistemaDetallista b ON a.Cuenta = b.CuentaCosto
   WHERE a.DepartamentoDetallista BETWEEN @DeptoD AND @DeptoA
     AND a.FechaContable <= @FechaA
     AND a.Estatus = 'CONCLUIDO'
     AND a.Empresa = @Empresa
     AND ISNULL(a.SucursalContable, '') = ISNULL(ISNULL(@Sucursal, a.SucursalContable), '')
   GROUP BY a.Cuenta, a.DepartamentoDetallista, b.Concepto

  -- Calcula el Precio de las Cuentas específicas
  SELECT a.Cuenta, PrecioD = SUM(ISNULL(a.Debe, 0) - ISNULL(a.Haber, 0)), a.DepartamentoDetallista, b.Concepto
    INTO #PrecioD
    FROM ContAux a
    JOIN cfgSistemaDetallista b ON a.Cuenta = b.CuentaPrecio
   WHERE a.DepartamentoDetallista BETWEEN @DeptoD AND @DeptoA
     AND a.FechaContable <= @FechaA
     AND a.Estatus = 'CONCLUIDO'
     AND a.Empresa = @Empresa
     AND ISNULL(a.SucursalContable, '') = ISNULL(ISNULL(@Sucursal, a.SucursalContable), '')
   GROUP BY a.Cuenta, a.DepartamentoDetallista, b.Concepto

  -- Identifica los departamentos y los conceptos
  SELECT a.Concepto, a.Orden, a.CuentaCosto, a.CuentaPrecio, b.Departamento, b.Nombre
    INTO #DepDet
    FROM cfgSistemaDetallista a, DepartamentoDetallista b
   WHERE b.Departamento BETWEEN @DeptoD AND @DeptoA
   ORDER BY b.Departamento, a.Orden

  INSERT ReporteSistemaDetallista
         (Estacion, Concepto,   Orden,   DepartamentoDetallista,   Costo,             Precio, Factor, Grupo )
  SELECT @Estacion, a.Concepto, a.Orden, a.Departamento,           ISNULL(CostoD, 0), ISNULL(PrecioD, 0), CASE WHEN ISNULL(PrecioD, 0) = 0 THEN 0 ELSE ISNULL(CostoD, 0) / PrecioD END,
         CASE WHEN Orden <= 100 THEN 10 ELSE 20 END
    FROM #DepDet a
    LEFT OUTER JOIN #CostoD b ON a.Concepto = b.Concepto AND a.Departamento = b.DepartamentoDetallista AND a.CuentaCosto = b.Cuenta
    LEFT OUTER JOIN #PrecioD c ON a.Concepto = c.Concepto AND a.Departamento = c.DepartamentoDetallista AND a.CuentaPrecio = c.Cuenta

  -- Compras Netas
  DECLARE CrSistE CURSOR FOR 
  SELECT DepartamentoDetallista, Costo = SUM(Costo), Precio = SUM(Precio)
    FROM ReporteSistemaDetallista
   WHERE Orden BETWEEN 20 AND 50
     AND Estacion = @Estacion
   GROUP BY DepartamentoDetallista
   ORDER BY DepartamentoDetallista
    OPEN CrSistE
   FETCH NEXT FROM CrSistE INTO @Departamento, @CuentaCosto, @CuentaPrecio
   WHILE @@FETCH_STATUS <> -1
   BEGIN
     IF @@FETCH_STATUS <> -2 
     BEGIN
       INSERT ReporteSistemaDetallista (Estacion,  Grupo,  DepartamentoDetallista,     Orden,  Concepto,        Costo,        Precio,        Factor)
                                VALUES (@Estacion, 10,     @Departamento,              55,     'Compras Netas', @CuentaCosto, @CuentaPrecio, CASE WHEN @CuentaPrecio = 0 THEN 0 ELSE @CuentaCosto/@CuentaPrecio END)
     END
     FETCH NEXT FROM CrSistE INTO @Departamento, @CuentaCosto, @CuentaPrecio
   END
   CLOSE CrSistE
   DEALLOCATE CrSistE

  -- Mercancia Disponible
  DECLARE CrSistD CURSOR FOR 
  SELECT DepartamentoDetallista, Costo = SUM(Costo), Precio = SUM(Precio)
    FROM ReporteSistemaDetallista
   WHERE Orden IN (10, 55, 60, 70)
     AND Estacion = @Estacion
   GROUP BY DepartamentoDetallista
   ORDER BY DepartamentoDetallista
    OPEN CrSistD
   FETCH NEXT FROM CrSistD INTO @Departamento, @CuentaCosto, @CuentaPrecio
   WHILE @@FETCH_STATUS <> -1
   BEGIN
     IF @@FETCH_STATUS <> -2 
     BEGIN
       INSERT ReporteSistemaDetallista (Estacion,  Grupo,  DepartamentoDetallista,     Orden,  Concepto,               Costo,        Precio,        Factor)
                                VALUES (@Estacion, 10,     @Departamento,              100,    'Mercancia Disponible', @CuentaCosto, @CuentaPrecio, CASE WHEN @CuentaPrecio = 0 THEN 0 ELSE @CuentaCosto/@CuentaPrecio END)
     END
     FETCH NEXT FROM CrSistD INTO @Departamento, @CuentaCosto, @CuentaPrecio
   END
   CLOSE CrSistD
   DEALLOCATE CrSistD

  -- Total Deducciones
  DECLARE CrSistF CURSOR FOR 
  SELECT DepartamentoDetallista, Costo = 0, Precio = SUM(Precio)
    FROM ReporteSistemaDetallista
   WHERE Orden >= 120
     AND Estacion = @Estacion
   GROUP BY DepartamentoDetallista
   ORDER BY DepartamentoDetallista
    OPEN CrSistF
   FETCH NEXT FROM CrSistF INTO @Departamento, @CuentaCosto, @CuentaPrecio
   WHILE @@FETCH_STATUS <> -1
   BEGIN
     IF @@FETCH_STATUS <> -2 
     BEGIN
       INSERT ReporteSistemaDetallista (Estacion,  Grupo,  DepartamentoDetallista,     Orden,  Concepto,            Costo,        Precio,        Factor)
                                VALUES (@Estacion, 20,     @Departamento,              250,    'Total Deducciones', @CuentaCosto, @CuentaPrecio, 0)
     END
     FETCH NEXT FROM CrSistF INTO @Departamento, @CuentaCosto, @CuentaPrecio
   END
   CLOSE CrSistF
   DEALLOCATE CrSistF
  SELECT * FROM ReporteSistemaDetallista WHERE Estacion = @Estacion ORDER BY DepartamentoDetallista, Orden
END
GO

/*
spSistemaDetallista 1, 1, '02/10/2005', 100
*/
/* spDecCte ***/
if exists (select * from sysobjects where id = object_id('dbo.spDecCte') and type = 'P') drop procedure dbo.spDecCte
GO
CREATE PROCEDURE spDecCte
                    @Ejercicio		int,
                    @Empresa		char(5)

		    
--//WITH ENCRYPTION
AS BEGIN

  SELECT a.Empresa, eRFC = e.RFC, eNombre = e.Nombre, TipoDec = 0, Comp = NULL, Anex = NULL, a.Cliente, a.Ejercicio, 
         SUM(a.ImporteNeto * m.TipoCambio) Importe,
         cNombre = c.Nombre, c.Direccion, c.Delegacion, c.Colonia, c.CodigoPostal, c.Poblacion,
         c.Estado, c.Telefonos, cRFC = c.RFC, c.CURP, c.Pais
    INTO #DecCte
    FROM VentaCte a
    JOIN Cte c ON a.Cliente = c.Cliente
    JOIN Mon m ON a.Moneda = m.Moneda
    JOIN Empresa e ON a.Empresa = e.Empresa
   WHERE a.Empresa = @Empresa
     AND a.Ejercicio = @Ejercicio
     AND a.ImporteNeto > 0
   GROUP BY a.Empresa, e.RFC, e.Nombre, a.Cliente, a.Ejercicio, 
         c.Nombre, c.Direccion, c.Delegacion, c.Colonia,
         c.CodigoPostal, c.Poblacion, c.Estado, c.Telefonos, c.RFC, c.CURP, c.Pais

  SELECT Ejercicio, NoCte5 = Count(Cliente)
    INTO #NoCte5
    FROM #DecCte
   WHERE Importe > 50000
   GROUP BY Ejercicio

  SELECT Ejercicio, TotImp5 = Sum(Importe)
    INTO #TotImp5
    FROM #DecCte
   WHERE Importe > 50000
   GROUP BY Ejercicio

  SELECT Ejercicio, TotImp = Sum(Importe)
    INTO #TotImp
    FROM #DecCte
   GROUP BY Ejercicio

  SELECT a.Empresa, eRFC, eNombre, TipoDec, Comp, Anex, a.Cliente, a.Ejercicio, a.Importe,
         cNombre, a.Direccion, a.Delegacion, a.Colonia, a.CodigoPostal, a.Poblacion,
         a.Estado, a.Telefonos, cRFC, a.CURP, a.Pais, NoCte5, TotImp5, TotImp
    INTO #DCte
    FROM #DecCte a
    LEFT OUTER JOIN #NoCte5 b ON a.Ejercicio = b.Ejercicio
    LEFT OUTER JOIN #TotImp5 c ON a.Ejercicio = c.Ejercicio
    LEFT OUTER JOIN #TotImp d ON a.Ejercicio = d.Ejercicio

  SELECT * 
-- GROUP BY Empresa, eRFC, eNombre, TipoDec, Comp, Anex, Cliente, Ejercicio, Importe,
--       cNombre, Direccion, Delegacion, Colonia, CodigoPostal, Poblacion,
--       Estado, Telefonos, cRFC, CURP, Pais, NoCte5, TotImp5, TotImp
--HAVING Importe > 50000
    FROM #DCte
   ORDER BY Ejercicio, Importe Desc

END
GO

/*
spDecCte  2004, 'INTEL'
*/


/* spDecProv ***/
if exists (select * from sysobjects where id = object_id('dbo.spDecProv') and type = 'P') drop procedure dbo.spDecProv
GO
CREATE PROCEDURE spDecProv
                    @Ejercicio		int,
                    @Empresa		char(5)

		    
--//WITH ENCRYPTION
AS BEGIN

  SELECT e.Empresa, eRFC = e.RFC, eNombre = e.Nombre, p.Proveedor, pNombre = p.Nombre, p.Direccion, p.Delegacion, p.Colonia, p.CodigoPostal, p.Poblacion,
         p.Estado, p.Telefonos, pRFC = p.RFC, p.CURP, p.Pais
    INTO #Prove
    FROM Prov p, Empresa e
   WHERE e.Empresa = @Empresa

  SELECT a.Proveedor, ImporteCxp = Sum((ISNULL(a.Importe, 0) * a.TipoCambio) * d.Factor) 
    INTO #ProvCxp
    FROM Cxp a
    JOIN Mon m ON a.Moneda = m.Moneda
    JOIN Empresa e ON a.Empresa = e.Empresa
    JOIN MovTipo d ON a.Mov = d.Mov
   WHERE d.Modulo = 'CXP'
     AND d.Clave IN ('CXP.F', 'CXP.NC')
     AND a.Ejercicio = @Ejercicio
     AND a.Estatus NOT IN ('CANCELADO', 'SINAFECTAR')
     AND a.Importe > 0
     AND a.Empresa = @Empresa
   GROUP BY a.Proveedor

  SELECT a.Empresa, eRFC, eNombre, TipoDec = 0, Comp = NULL, Anex = NULL, a.Proveedor, Ejercicio = @Ejercicio, 
         Importe = ISNULL(ImporteCxp, 0),
         pNombre, a.Direccion, a.Delegacion, a.Colonia, a.CodigoPostal, a.Poblacion,
         a.Estado, a.Telefonos, pRFC, a.CURP, a.Pais
    INTO #DecProv1
    FROM #Prove a
    LEFT OUTER JOIN #ProvCxp d ON a.Proveedor = d.Proveedor

  SELECT Empresa, eRFC, eNombre, TipoDec, Comp, Anex, Proveedor, Ejercicio, 
         Importe, pNombre, Direccion, Delegacion, Colonia, CodigoPostal, 
         Poblacion, Estado, Telefonos, pRFC, CURP, Pais
    INTO #DecProv
    FROM #DecProv1
   WHERE Importe <> 0

  SELECT Ejercicio, NoProv5 = Count(Proveedor)
    INTO #NoProv5
    FROM #DecProv
   WHERE Importe > 50000
   GROUP BY Ejercicio

  SELECT Ejercicio, TotImp5 = Sum(Importe)
    INTO #TotImp5
    FROM #DecProv
   WHERE Importe > 50000
   GROUP BY Ejercicio

  SELECT Ejercicio, TotImp = Sum(Importe)
    INTO #TotImp
    FROM #DecProv
   GROUP BY Ejercicio

  SELECT a.Empresa, eRFC, eNombre, TipoDec, Comp, Anex, a.Proveedor, a.Ejercicio, a.Importe,
         pNombre, a.Direccion, a.Delegacion, a.Colonia, a.CodigoPostal, a.Poblacion,
         a.Estado, a.Telefonos, pRFC, a.CURP, a.Pais, NoProv5, TotImp5, TotImp
    INTO #DProv
    FROM #DecProv a
    LEFT OUTER JOIN #NoProv5 b ON a.Ejercicio = b.Ejercicio
    LEFT OUTER JOIN #TotImp5 c ON a.Ejercicio = c.Ejercicio
    LEFT OUTER JOIN #TotImp d ON a.Ejercicio = d.Ejercicio

  SELECT *
    FROM #DProv
-- GROUP BY Empresa, eRFC, eNombre, TipoDec, Comp, Anex, Proveedor, Ejercicio, Importe,
--       pNombre, Direccion, Delegacion, Colonia, CodigoPostal, Poblacion,
--       Estado, Telefonos, pRFC, CURP, Pais, NoProv5, TotImp5, TotImp
--HAVING Importe > 50000
   ORDER BY Ejercicio, Importe Desc

END
GO

/*
spDecProv 2004, 'INTEL'
*/

/**************** spInvVal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spInvVal') and type = 'P') drop procedure dbo.spInvVal
GO             
CREATE PROCEDURE spInvVal
		@ArticuloD	char(20),
		@ArticuloA	char(20),
                @Almacen	char(10),
		@InvVal		varchar(20),
		@FechaA		Datetime,
		@Empresa	char(5)

--//WITH ENCRYPTION
AS BEGIN

  DECLARE
	@ArticuloE	char(20),
	@AlmacenE	char(10),
	@InventarioE	float,
	@Cantidad	float,
	@Alm		char(10)

  IF @Almacen IN ('NULL', '(TODOS)', '') SELECT @Almacen = NULL

  CREATE TABLE #ExistenciaVal (
        ID			int		IDENTITY(1,1) NOT NULL PRIMARY KEY,

	Articulo		char(20)	COLLATE Database_Default NULL,
	Descripcion		varchar(100)	COLLATE Database_Default NULL,
	PrecioLista		money		NULL,
	Precio2			money		NULL,
	Precio3			money		NULL,
	Precio4			money		NULL,
	Precio5			money		NULL,
	Precio6			money		NULL,
	Precio7			money		NULL,
	Precio8			money		NULL,
	Precio9			money		NULL,
	Precio10		money		NULL,
	CostoEstandar		money		NULL,
	CostoReposicion		money		NULL,
	CostoPromedio		money		NULL,
	UltimoCosto		money		NULL,
	Moneda			char(10)	COLLATE Database_Default NULL,
	Almacen			char(10)	COLLATE Database_Default NULL,
	Nombre			varchar(100)	COLLATE Database_Default NULL,
	Existencias		float		NULL)

  CREATE INDEX Articulo ON #ExistenciaVal (Articulo, Almacen)

  INSERT #ExistenciaVal
  SELECT Art.Articulo,
         Art.Descripcion1,
         Art.PrecioLista,
         Art.Precio2,
         Art.Precio3,
         Art.Precio4,
         Art.Precio5,
         Art.Precio6,
         Art.Precio7,
         Art.Precio8,
         Art.Precio9,
         Art.Precio10,
         Art.CostoEstandar,
         Art.CostoReposicion,
         CostoPromedio = (SELECT TOP 1 a.CostoPromedio FROM ArtCostoHist a WHERE a.Empresa = @Empresa AND a.Sucursal = ac.Sucursal AND a.Articulo = Art.Articulo GROUP BY a.CostoPromedio, a.Fecha, a.Empresa, a.Sucursal, a.Articulo HAVING a.Fecha = (SELECT MAX(b.Fecha) FROM ArtCostoHist b WHERE b.Empresa = a.Empresa AND b.Sucursal = a.Sucursal AND b.Articulo = a.Articulo AND b.Fecha < @FechaA)),
         UltimoCosto = (SELECT TOP 1 a.UltimoCostoActual FROM ArtCostoHist a WHERE a.Empresa = @Empresa AND a.Sucursal = ac.Sucursal AND a.Articulo = Art.Articulo GROUP BY a.UltimoCostoActual, a.Fecha, a.Empresa, a.Sucursal, a.Articulo HAVING a.Fecha = (SELECT MAX(b.Fecha) FROM ArtCostoHist b WHERE b.Empresa = a.Empresa AND b.Sucursal = a.Sucursal AND b.Articulo = a.Articulo AND b.Fecha < @FechaA)),
         e.Moneda,
         e.Almacen,
         Alm.Nombre,
         SUM(e.Existencia)
    FROM Art
    JOIN ArtCostoSucursal ac ON Art.Articulo = ac.Articulo  
    JOIN ArtExistenciaNeta e ON Art.Articulo = e.Articulo  
    JOIN Alm ON e.Almacen = Alm.Almacen AND Alm.Sucursal = ac.Sucursal
   WHERE ac.Empresa = @Empresa
     AND e.Empresa = @Empresa
     AND Art.Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND ISNULL(e.Almacen, '') = ISNULL(ISNULL(@Almacen, e.Almacen), '')
   GROUP BY e.Moneda, Art.Articulo, Art.Descripcion1, 
         Art.PrecioLista, Art.Precio2, Art.Precio3, Art.Precio4, Art.Precio5, Art.Precio6, Art.Precio7, Art.Precio8, Art.Precio9, Art.Precio10,
         Art.CostoEstandar, Art.CostoReposicion, ac.CostoPromedio, ac.UltimoCosto, 
         e.Almacen, Alm.Nombre, ac.Sucursal

 DECLARE CrExist CURSOR LOCAL FOR 
  SELECT Articulo, Almacen, Existencias
    FROM #ExistenciaVal
    OPEN CrExist
   FETCH NEXT FROM CrExist INTO @ArticuloE, @AlmacenE, @InventarioE
   WHILE @@FETCH_STATUS <> -1
   BEGIN
     IF @@FETCH_STATUS <> -2 
     BEGIN
       SELECT @Cantidad = NULL, @Alm = NULL
       SELECT @Cantidad = SUM(ISNULL(a.CargoU, 0) - ISNULL(a.AbonoU, 0)) * -1, @Alm = a.Grupo
         FROM InvAuxU a
        WHERE a.Articulo = @ArticuloE
          AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@AlmacenE, a.Grupo), '')
          AND a.Rama = 'INV'
          AND a.Empresa = @Empresa
          AND a.Fecha BETWEEN @FechaA+1 AND GETDATE()
        GROUP BY a.Grupo
       UPDATE #ExistenciaVal SET Existencias = Existencias + ISNULL(@Cantidad, 0) WHERE Articulo = @ArticuloE AND Almacen = @AlmacenE
     END
     FETCH NEXT FROM CrExist INTO @ArticuloE, @AlmacenE, @InventarioE
   END
   CLOSE CrExist
   DEALLOCATE CrExist

  SELECT * FROM #ExistenciaVal WHERE Existencias > 0 ORDER BY Moneda, Articulo, Almacen

END
GO

/*

spInvVal '0071', '0074', 'NULL', 'Costo Promedio', '05/31/2005', 'BLER'

*/

-- spVerContResultados 'DEMO', 2002, 1, 12, 'SI', NULL, NULL, 'SI', 'Dolar', 'Dos'
/**************** spVerContResultadosAnuales ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContResultadosAnuales') and type = 'P') drop procedure dbo.spVerContResultadosAnuales
GO
CREATE PROCEDURE spVerContResultadosAnuales
		    @Empresa		char(5)	    = NULL,
		    @EjercicioD		int,
		    @EjercicioA		int,
		    @PeriodoA		int,
		    @Anual		char(20),
		    @ConMovs		char(20)    = 'NO',
                    @CentroCostos	char(20)    = NULL,
		    @Sucursal		int	    = NULL,
		    @OrdenCC		char(20)    = 'NO',
		    @Moneda		char(10)    = NULL,
		    @CCGrupo		varchar(50) = NULL,
		    @UEN		int	    = NULL,
		    @Proyecto		varchar(50) = NULL,
		    @CentroCostos2	varchar(50) = NULL,
		    @CentroCostos3	varchar(50) = NULL,
	        @ReExpresar     char(20) = 'NO', --REQ2162
	        @ReExpresarTipoCambio float = NULL --REQ2162

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID				int,
    @CtaResultados		char(20),
    @CtaIngresos		char(20),
    @CtaCostoDirecto		char(20),
    @CtaGastosOperacion		char(20),
    @CtaOtrosGastosProductos	char(20),
    @CtaImpuestos		char(20),
    @Saldo			money,
    @Ingresos1			money,
    @Ingresos2			money,
    @Ingresos3			money,
    @Ingresos4			money,
    @Ingresos5			money,
    @Numero			int,
    @PeriodoX			int,
    @AnioInicial		int,
    @AnioFinal			int,
    @EjercicioX			int,
    @Cuantos			int

  SELECT @Moneda        = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0'),
         @CCGrupo       = NULLIF(NULLIF(RTRIM(@CCGrupo), ''), '0')

  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  CREATE TABLE #ResultadoA (
     Orden		int		NOT NULL,
     ID			int		IDENTITY(1,1) NOT NULL,

     Clase		char(30)	COLLATE Database_Default NULL,
     SubClase		char(20)	COLLATE Database_Default NULL,

     Rama		char(20)	COLLATE Database_Default NULL, 
     RamaDesc		varchar(100)	COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,

     Cuenta		char(20)	COLLATE Database_Default NULL,
     Descripcion	varchar(100)	COLLATE Database_Default NULL,
     EsAcreedora	bit		NOT NULL DEFAULT 0,

     SubCuenta		varchar(50)	COLLATE Database_Default NULL,
     CentroCostos	varchar(100)	COLLATE Database_Default NULL,

     Ejercicio1		int		NULL,
     Saldo1		money		NULL,
     Ingresos1		money		NULL,
     Porcentaje1	float		NULL,

     Ejercicio2		int		NULL,
     Saldo2		money		NULL,
     Ingresos2		money		NULL,
     Porcentaje2	float		NULL,

     Ejercicio3		int		NULL,
     Saldo3		money		NULL,
     Ingresos3		money		NULL,
     Porcentaje3	float		NULL,

     Ejercicio4		int		NULL,
     Saldo4		money		NULL,
     Ingresos4		money		NULL,
     Porcentaje4	float		NULL,

     Ejercicio5		int		NULL,
     Saldo5		money		NULL,
     Ingresos5		money		NULL,
     Porcentaje5	float		NULL,

     CONSTRAINT priTempResultado PRIMARY KEY CLUSTERED (Orden, ID)
  )

   SELECT @ConMovs = UPPER(@ConMovs), @CentroCostos = NULLIF(RTRIM(@CentroCostos), '')
   IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)') SELECT @CentroCostos = NULL
   IF @Sucursal<0 SELECT @Sucursal = NULL
   IF @UEN = 0 SELECT @UEN = NULL
   IF UPPER(@Proyecto)      IN ('0', 'NULL', '(TODOS)','') SELECT @Proyecto = NULL
   IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','') SELECT @CentroCostos2 = NULL
   IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','') SELECT @CentroCostos3 = NULL

   SELECT DISTINCT
          @CtaResultados   		= CtaResultados,
    	  @CtaIngresos	   		= CtaIngresos,
    	  @CtaCostoDirecto 		= CtaCostoDirecto,
    	  @CtaGastosOperacion		= CtaGastosOperacion,
    	  @CtaOtrosGastosProductos	= CtaOtrosGastosProductos,
    	  @CtaImpuestos			= CtaImpuestos
     FROM EmpresaCfg
    WHERE Empresa = @Empresa

  -- Ventas
  INSERT #ResultadoA
  SELECT DISTINCT 1, "Utilidad Bruta",
	 "Ventas",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         cc.SubCuenta,
   	 cc.CentroCostos,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama ON Cta.Rama = Rama.Cuenta
    JOIN ContSubSaldo cc ON Cta.cuenta = cc.Cuenta 
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaIngresos OR Rama.Rama = @CtaIngresos)
     AND cc.Moneda = @Moneda
     AND cc.Empresa = @Empresa

  -- Costos
  INSERT #ResultadoA
  SELECT DISTINCT 2, "Utilidad Bruta",
	 "Costos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         cc.SubCuenta,
   	 cc.CentroCostos,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama ON Cta.Rama = Rama.Cuenta
    JOIN ContSubSaldo cc ON Cta.Cuenta = cc.Cuenta 
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaCostoDirecto OR Rama.Rama = @CtaCostoDirecto)
     AND cc.Moneda = @Moneda 
     AND cc.Empresa = @Empresa

  -- Gastos Operacion
  INSERT #ResultadoA
  SELECT DISTINCT 3, "UAFIR",
	 "Gastos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         cc.SubCuenta,
   	 cc.CentroCostos,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama ON Cta.Rama = Rama.Cuenta
    JOIN ContSubSaldo cc ON Cta.cuenta = cc.Cuenta 
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaGastosOperacion OR Rama.Rama = @CtaGastosOperacion)
     AND cc.Moneda = @Moneda 
     AND cc.Empresa = @Empresa

  -- Otros Gastos y Productos
  INSERT #ResultadoA
  SELECT DISTINCT 4, "Utilidad Antes de Impuestos",
	 "Gastos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         cc.SubCuenta,
   	 cc.CentroCostos,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama ON Cta.Rama = Rama.Cuenta
    JOIN ContSubSaldo cc ON Cta.cuenta = cc.Cuenta 
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaOtrosGastosProductos OR Rama.Rama = @CtaOtrosGastosProductos)
     AND cc.Moneda = @Moneda 
     AND cc.Empresa = @Empresa 

  -- Otros
  INSERT #ResultadoA
  SELECT DISTINCT 5, "Utilidad Neta",
	 "Otros",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         cc.SubCuenta,
   	 cc.CentroCostos,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama ON Cta.Rama = Rama.Cuenta
    JOIN ContSubSaldo cc ON Cta.cuenta = cc.Cuenta 
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaResultados OR Rama.Rama = @CtaResultados)
     AND (Cta.Rama <> @CtaIngresos AND Rama.Rama <> @CtaIngresos)
     AND (Cta.Rama <> @CtaCostoDirecto AND Rama.Rama <> @CtaCostoDirecto)
     AND (Cta.Rama <> @CtaGastosOperacion AND Rama.Rama <> @CtaGastosOperacion)
     AND (Cta.Rama <> @CtaOtrosGastosProductos AND Rama.Rama <> @CtaOtrosGastosProductos)
     AND cc.Moneda = @Moneda 
     AND cc.Empresa = @Empresa

  -- drop table #Ejercicios
    CREATE TABLE #Ejercicios
   (
    Numero		int		NULL,
    Ejercicio		int		NULL)

  SELECT @Numero = 1, @PeriodoX = MONTH(GETDATE())

  -- Llena tabla con Años
 DECLARE cr_Anio CURSOR FOR 
  SELECT @EjercicioD, @EjercicioA
    OPEN cr_Anio
   FETCH NEXT FROM cr_Anio INTO @AnioInicial, @AnioFinal
   WHILE @@FETCH_STATUS <> -1
   BEGIN
     IF @@FETCH_STATUS <> -2 
     BEGIN
       WHILE @AnioInicial <= @AnioFinal
       BEGIN
         INSERT #Ejercicios (Numero, Ejercicio)
                     VALUES (@Numero, @AnioInicial)
         SELECT @AnioInicial = @AnioInicial + 1, @Numero = @Numero + 1
       END
     END
     FETCH NEXT FROM cr_Anio INTO @AnioInicial, @AnioFinal
   END
   CLOSE cr_Anio
   DEALLOCATE cr_Anio

  SELECT @Cuantos = COUNT(Ejercicio) FROM #Ejercicios

  -- Actualiza tabla con Años
  UPDATE #ResultadoA SET Ejercicio1  = (SELECT Ejercicio FROM #Ejercicios WHERE Numero = 1),  Ejercicio2  = (SELECT Ejercicio FROM #Ejercicios WHERE Numero = 2),
                         Ejercicio3  = (SELECT Ejercicio FROM #Ejercicios WHERE Numero = 3),  Ejercicio4  = (SELECT Ejercicio FROM #Ejercicios WHERE Numero = 4),
                         Ejercicio5  = (SELECT Ejercicio FROM #Ejercicios WHERE Numero = 5)


  IF @Anual = 'Del Ejercicio'
  BEGIN
    DECLARE Cursor_Ingresos CURSOR FOR 
     SELECT Ejercicio
       FROM #Ejercicios
       OPEN Cursor_Ingresos
      FETCH NEXT FROM Cursor_Ingresos INTO @EjercicioX
      WHILE @@FETCH_STATUS <> -1
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN       	
          UPDATE #ResultadoA SET Ingresos1  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio1 AND a.Periodo <= @PeriodoX AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio1 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos2  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio2 AND a.Periodo <= @PeriodoX AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio2 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos3  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio3 AND a.Periodo <= @PeriodoX AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio3 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos4  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio4 AND a.Periodo <= @PeriodoX AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio4 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos5  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio5 AND a.Periodo <= @PeriodoX AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio5 = @EjercicioX

          UPDATE #ResultadoA SET Saldo1 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio1 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo <= @PeriodoX AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio1 = @EjercicioX
          UPDATE #ResultadoA SET Saldo2 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio2 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo <= @PeriodoX AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio2 = @EjercicioX
          UPDATE #ResultadoA SET Saldo3 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio3 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo <= @PeriodoX AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio3 = @EjercicioX
          UPDATE #ResultadoA SET Saldo4 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio4 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo <= @PeriodoX AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio4 = @EjercicioX
          UPDATE #ResultadoA SET Saldo5 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio5 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo <= @PeriodoX AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio5 = @EjercicioX

          UPDATE #ResultadoA SET Porcentaje1 = (Saldo1/dbo.fnEvitarDivisionCero(Ingresos1))*100 WHERE Ejercicio1 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje2 = (Saldo2/dbo.fnEvitarDivisionCero(Ingresos2))*100 WHERE Ejercicio2 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje3 = (Saldo3/dbo.fnEvitarDivisionCero(Ingresos3))*100 WHERE Ejercicio3 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje4 = (Saldo4/dbo.fnEvitarDivisionCero(Ingresos4))*100 WHERE Ejercicio4 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje5 = (Saldo5/dbo.fnEvitarDivisionCero(Ingresos5))*100 WHERE Ejercicio5 = @EjercicioX

        END
        FETCH NEXT FROM Cursor_Ingresos INTO @EjercicioX
      END
      CLOSE Cursor_Ingresos
      DEALLOCATE Cursor_Ingresos
  END

  IF @Anual = 'Acumulado a'
  BEGIN
    DECLARE Cursor_Ingresos CURSOR FOR 
     SELECT Ejercicio
       FROM #Ejercicios
       OPEN Cursor_Ingresos
      FETCH NEXT FROM Cursor_Ingresos INTO @EjercicioX
      WHILE @@FETCH_STATUS <> -1
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          UPDATE #ResultadoA SET Ingresos1  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio1 AND a.Periodo <= @PeriodoA AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio1 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos2  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio2 AND a.Periodo <= @PeriodoA AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio2 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos3  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio3 AND a.Periodo <= @PeriodoA AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio3 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos4  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio4 AND a.Periodo <= @PeriodoA AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio4 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos5  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio5 AND a.Periodo <= @PeriodoA AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio5 = @EjercicioX

          UPDATE #ResultadoA SET Saldo1 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio1 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo <= @PeriodoA AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio1 = @EjercicioX
          UPDATE #ResultadoA SET Saldo2 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio2 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo <= @PeriodoA AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio2 = @EjercicioX 
          UPDATE #ResultadoA SET Saldo3 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio3 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo <= @PeriodoA AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio3 = @EjercicioX
          UPDATE #ResultadoA SET Saldo4 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio4 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo <= @PeriodoA AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio4 = @EjercicioX
          UPDATE #ResultadoA SET Saldo5 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio5 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo <= @PeriodoA AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio5 = @EjercicioX

          UPDATE #ResultadoA SET Porcentaje1 = (Saldo1/dbo.fnEvitarDivisionCero(Ingresos1))*100 WHERE Ejercicio1 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje2 = (Saldo2/dbo.fnEvitarDivisionCero(Ingresos2))*100 WHERE Ejercicio2 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje3 = (Saldo3/dbo.fnEvitarDivisionCero(Ingresos3))*100 WHERE Ejercicio3 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje4 = (Saldo4/dbo.fnEvitarDivisionCero(Ingresos4))*100 WHERE Ejercicio4 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje5 = (Saldo5/dbo.fnEvitarDivisionCero(Ingresos5))*100 WHERE Ejercicio5 = @EjercicioX

        END
        FETCH NEXT FROM Cursor_Ingresos INTO @EjercicioX
      END
      CLOSE Cursor_Ingresos
      DEALLOCATE Cursor_Ingresos
  END

  IF @Anual = 'Del Mes'
  BEGIN
    DECLARE Cursor_Ingresos CURSOR FOR 
     SELECT Ejercicio
       FROM #Ejercicios
       OPEN Cursor_Ingresos
      FETCH NEXT FROM Cursor_Ingresos INTO @EjercicioX
      WHILE @@FETCH_STATUS <> -1
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          UPDATE #ResultadoA SET Ingresos1  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio1 AND a.Periodo = @PeriodoA AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio1 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos2  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio2 AND a.Periodo = @PeriodoA AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio2 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos3  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio3 AND a.Periodo = @PeriodoA AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio3 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos4  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio4 AND a.Periodo = @PeriodoA AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio4 = @EjercicioX
          UPDATE #ResultadoA SET Ingresos5  = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = @CtaIngresos AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Ejercicio = b.Ejercicio5 AND a.Periodo = @PeriodoA AND a.Moneda = @Moneda AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio5 = @EjercicioX

          UPDATE #ResultadoA SET Saldo1 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio1 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo = @PeriodoA AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio1 = @EjercicioX
          UPDATE #ResultadoA SET Saldo2 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio2 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo = @PeriodoA AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio2 = @EjercicioX
          UPDATE #ResultadoA SET Saldo3 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio3 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo = @PeriodoA AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio3 = @EjercicioX
          UPDATE #ResultadoA SET Saldo4 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio4 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo = @PeriodoA AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio4 = @EjercicioX
          UPDATE #ResultadoA SET Saldo5 = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = b.Ejercicio5 AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '') AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '') AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '') AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '') AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '') AND a.Moneda = @Moneda AND a.Periodo = @PeriodoA AND a.Empresa = @Empresa) FROM #ResultadoA b WHERE b.Ejercicio5 = @EjercicioX

          UPDATE #ResultadoA SET Porcentaje1 = (Saldo1/dbo.fnEvitarDivisionCero(Ingresos1))*100 WHERE Ejercicio1 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje2 = (Saldo2/dbo.fnEvitarDivisionCero(Ingresos2))*100 WHERE Ejercicio2 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje3 = (Saldo3/dbo.fnEvitarDivisionCero(Ingresos3))*100 WHERE Ejercicio3 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje4 = (Saldo4/dbo.fnEvitarDivisionCero(Ingresos4))*100 WHERE Ejercicio4 = @EjercicioX
          UPDATE #ResultadoA SET Porcentaje5 = (Saldo5/dbo.fnEvitarDivisionCero(Ingresos5))*100 WHERE Ejercicio5 = @EjercicioX

        END
        FETCH NEXT FROM Cursor_Ingresos INTO @EjercicioX
      END
      CLOSE Cursor_Ingresos
      DEALLOCATE Cursor_Ingresos
  END

  --REQ2162
  IF @ReExpresar='Si'
    UPDATE #ResultadoA
	   SET Saldo1=Saldo1/ISNULL(@ReExpresarTipoCambio,1),
	       Ingresos1=Ingresos1/ISNULL(@ReExpresarTipoCambio,1),
		   Saldo2=Saldo2/ISNULL(@ReExpresarTipoCambio,1),
	       Ingresos2=Ingresos2/ISNULL(@ReExpresarTipoCambio,1),
		   Saldo3=Saldo3/ISNULL(@ReExpresarTipoCambio,1),
	       Ingresos3=Ingresos3/ISNULL(@ReExpresarTipoCambio,1),
		   Saldo4=Saldo4/ISNULL(@ReExpresarTipoCambio,1),
	       Ingresos4=Ingresos4/ISNULL(@ReExpresarTipoCambio,1),
		   Saldo5=Saldo5/ISNULL(@ReExpresarTipoCambio,1),
	       Ingresos5=Ingresos5/ISNULL(@ReExpresarTipoCambio,1)
		    

  IF @OrdenCC = 'NO' 
  BEGIN
    IF @ConMovs = 'SI' 
      SELECT r.*, "Grupo" = CONVERT(varchar(50), null), "SubGrupo" = CONVERT(varchar(50), null), "SubSubGrupo" = CONVERT(varchar(50), null) 
        FROM #ResultadoA r 
       WHERE ISNULL(r.Saldo1, 0.0) <> 0.0 OR ISNULL(r.Saldo2, 0.0) <> 0.0 OR ISNULL(r.Saldo3, 0.0) <> 0.0 OR ISNULL(r.Saldo4, 0.0) <> 0.0 OR ISNULL(r.Saldo5, 0.0) <> 0.0 ORDER BY r.Orden, r.ID
    ELSE
      SELECT r.*, "Grupo" = CONVERT(varchar(50), null), "SubGrupo" = CONVERT(varchar(50), null), "SubSubGrupo" = CONVERT(varchar(50), null) 
        FROM #ResultadoA r 
       ORDER BY r.Orden, r.ID
  END ELSE
  BEGIN
    IF @CCGrupo <> 'NULL'
    BEGIN
      IF @ConMovs = 'SI' 
        SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo 
          FROM #ResultadoA r JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos AND cc.Grupo = ISNULL(@CCGrupo, cc.Grupo) 
         WHERE ISNULL(r.Saldo1, 0.0) <> 0.0 OR ISNULL(r.Saldo2, 0.0) <> 0.0 OR ISNULL(r.Saldo3, 0.0) <> 0.0 OR ISNULL(r.Saldo4, 0.0) <> 0.0 OR ISNULL(r.Saldo5, 0.0) <> 0.0           
         ORDER BY r.Orden, r.Rama, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
      ELSE
        SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo 
          FROM #ResultadoA r JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos AND cc.Grupo = ISNULL(@CCGrupo, cc.Grupo) 
         ORDER BY r.Orden, r.Rama, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
    END ELSE
    BEGIN
      IF @ConMovs = 'SI' 
        SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo 
          FROM #ResultadoA r LEFT OUTER JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos 
         WHERE ISNULL(r.Saldo1, 0.0) <> 0.0 OR ISNULL(r.Saldo2, 0.0) <> 0.0 OR ISNULL(r.Saldo3, 0.0) <> 0.0 OR ISNULL(r.Saldo4, 0.0) <> 0.0 OR ISNULL(r.Saldo5, 0.0) <> 0.0
         ORDER BY r.Orden, r.Rama, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
      ELSE
        SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo 
          FROM #ResultadoA r LEFT OUTER JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos 
         ORDER BY r.Orden, r.Rama, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
    END
  END
END
GO

/*
exec spVerContResultadosAnuales  '100', 2003, 2005, 4, 'Acumulado a', 'Si', NULL, -1, 'NO', 'Pesos', 'NULL'
*/

/**************** spVerContBalanceAnuales ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContBalanceAnuales') and type = 'P') drop procedure dbo.spVerContBalanceAnuales
GO             
CREATE PROCEDURE spVerContBalanceAnuales
		    @Empresa		char(5),
		    @EjercicioD		int,
		    @EjercicioA		int,
		    @PeriodoA		int,
		    @Anual		char(20),
		    @ConMovs		char(20) = 'NO',
                    @CentroCostos	char(20) = NULL,
		    @Sucursal		int	 = NULL,
		    @Moneda		char(10) = NULL,
		    @UEN		int	    = NULL,
		    @Proyecto		varchar(50) = NULL,
		    @CentroCostos2	varchar(50) = NULL,
		    @CentroCostos3	varchar(50) = NULL,
			@ReExpresar     char(20) = 'NO', --REQ2162
			@ReExpresarTipoCambio float = NULL --REQ2162
--//WITH ENCRYPTION
AS BEGIN
  SET nocount ON
  DECLARE 
    @ID			int,
    @Lado		int,
    @UltLado		int,
    @Renglon		int,
    @UltRenglon		int,
    @UltRama		char(20),
    @UltRama1		char(20),
    @UltRama2		char(20),
    @LadoDesc		varchar(100), 
    @UltLadoDesc	varchar(100), 
    @Rama		char(20), 
    @RamaDesc		varchar(100), 
    @Cuenta		char(20), 
    @Descripcion	varchar(100), 
    @EsAcreedora	bit, 
    @EsTitulo		bit,
    @EsFinRama		bit,
    @EsFinLado		bit,
    @Saldo1    		money,
    @Saldo2    		money,
    @Saldo3    		money,
    @Saldo4    		money,
    @Saldo5    		money,
    @Ejercicio1		int,
    @Ejercicio2		int,
    @Ejercicio3		int,
    @Ejercicio4		int,
    @Ejercicio5		int,
    @Saldo11   		money,
    @Saldo12   		money,
    @Saldo13   		money,
    @Saldo14   		money,
    @Saldo15   		money,
    @CtaActivo		char(20),
    @CtaPasivo		char(20),
    @CtaCapital		char(20),
    @CtaResultados	char(20),
    @ContMoneda		char(10),
    @Numero		int,
    @PeriodoX		int,
    @AnioInicial	int,
    @AnioFinal		int,
    @EjercicioX		int,
    @Cuantos		int

  CREATE TABLE #BalanceA(
     ID			int		IDENTITY(1,1) NOT NULL,

     Renglon 		int		NULL,

     EsTitulo		bit		NOT NULL DEFAULT 0,
     EsFinRama		bit		NOT NULL DEFAULT 0,
     EsFinLado		bit		NOT NULL DEFAULT 0,
     Lado		int		NULL,
     LadoDesc		char(20)	COLLATE Database_Default NULL,
     Rama		char(20)	COLLATE Database_Default NULL, 
     RamaDesc		varchar(100)	COLLATE Database_Default NULL,
     Cuenta		char(20)	COLLATE Database_Default NULL,
     Descripcion	varchar(100)	COLLATE Database_Default NULL,
     EsAcreedora	bit		NOT NULL DEFAULT 0,
     Ejercicio1		int		NULL,
     Saldo1		money		NULL,
     Ejercicio2		int		NULL,
     Saldo2		money		NULL,
     Ejercicio3		int		NULL,
     Saldo3		money		NULL,
     Ejercicio4		int		NULL,
     Saldo4		money		NULL,
     Ejercicio5		int		NULL,
     Saldo5		money		NULL,

     CONSTRAINT priTempBalanceA PRIMARY KEY CLUSTERED (ID)
  )

  CREATE TABLE #VerBalanceA(
     Renglon 		int		NULL,
     Lado		int		NULL,

     EsTitulo1		bit		NOT NULL DEFAULT 0,
     EsFinRama1		bit		NOT NULL DEFAULT 0,
     EsFinLado1		bit		NOT NULL DEFAULT 0,
     LadoDesc1		char(20)	COLLATE Database_Default NULL,
     Rama1		char(20)	COLLATE Database_Default NULL, 
     RamaDesc1		varchar(100)	COLLATE Database_Default NULL,
     Cuenta1		char(20)	COLLATE Database_Default NULL,
     Descripcion1	varchar(100)	COLLATE Database_Default NULL,
     EsAcreedora1	bit		NOT NULL DEFAULT 0,
     Saldo11		money		NULL,
     Ejercicio11	int		NULL,
     Saldo12		money		NULL,
     Ejercicio12	int		NULL,
     Saldo13		money		NULL,
     Ejercicio13	int		NULL,
     Saldo14		money		NULL,
     Ejercicio14	int		NULL,
     Saldo15		money		NULL,
     Ejercicio15	int		NULL,

     EsTitulo2		bit		NOT NULL DEFAULT 0,
     EsFinRama2		bit		NOT NULL DEFAULT 0,
     EsFinLado2		bit		NOT NULL DEFAULT 0,
     LadoDesc2		char(20)	COLLATE Database_Default NULL,
     Rama2		char(20)	COLLATE Database_Default NULL, 
     RamaDesc2		varchar(100)	COLLATE Database_Default NULL,
     Cuenta2		char(20)	COLLATE Database_Default NULL,
     Descripcion2	varchar(100)	COLLATE Database_Default NULL,
     EsAcreedora2	bit		NOT NULL DEFAULT 0,
     Saldo21		money		NULL,
     Ejercicio21	int		NULL,
     Saldo22		money		NULL,
     Ejercicio22	int		NULL,
     Saldo23		money		NULL,
     Ejercicio23	int		NULL
  )

   SELECT @ConMovs = UPPER(@ConMovs), @CentroCostos = NULLIF(RTRIM(@CentroCostos), ''), @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')
   IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)') SELECT @CentroCostos = NULL
   IF @Sucursal <0 SELECT @Sucursal = NULL
   IF @UEN = 0 SELECT @UEN = NULL
   IF UPPER(@Proyecto)      IN ('0', 'NULL', '(TODOS)','') SELECT @Proyecto = NULL
   IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','') SELECT @CentroCostos2 = NULL
   IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','') SELECT @CentroCostos3 = NULL

   SELECT @CtaActivo	  = CtaActivo,
     	  @CtaPasivo	  = CtaPasivo,
    	  @CtaCapital	  = CtaCapital,
          @CtaResultados  = CtaResultados,
          @ContMoneda	  = ContMoneda
     FROM EmpresaCfg 
    WHERE Empresa = @Empresa

   IF @Moneda IS NULL SELECT @Moneda = @ContMoneda
 
  -- Activo
  INSERT #BalanceA
  SELECT 0,0,0,0,1,
         'Activo',
         E2.Cuenta,
         E2.Descripcion,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL
    FROM Cta
    JOIN Cta E2 ON Cta.Rama = E2.Cuenta
    JOIN Cta E1 ON E2.Rama = E1.Cuenta
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaActivo OR E1.Rama = @CtaActivo OR E2.Rama = @CtaActivo)
   ORDER BY Cta.Cuenta

  -- Pasivo
  INSERT #BalanceA
  SELECT 0,0,0,0,1,
         'Pasivo',
         E2.Cuenta,
         E2.Descripcion,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL
    FROM Cta
    JOIN Cta E2 ON Cta.Rama = E2.Cuenta
    JOIN Cta E1 ON E2.Rama = E1.Cuenta
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaPasivo OR E1.Rama = @CtaPasivo OR E2.Rama = @CtaPasivo)
   ORDER BY Cta.Cuenta

  -- Capital
  INSERT #BalanceA
  SELECT 0,0,0,0,1,
         'Capital',
         E2.Cuenta,
         E2.Descripcion,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL
    FROM Cta
    JOIN Cta E2 ON Cta.Rama = E2.Cuenta
    JOIN Cta E1 ON E2.Rama = E1.Cuenta
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaCapital OR E1.Rama = @CtaCapital OR E2.Rama = @CtaCapital)
   ORDER BY Cta.Cuenta

  -- Resultados
  INSERT #BalanceA
  SELECT 0,0,0,0,1,
         'Capital',
         E2.Cuenta,
         E2.Descripcion,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL,
         NULL, NULL
    FROM Cta, Cta E2
   WHERE E2.Cuenta = @CtaCapital
     AND Cta.Cuenta = @CtaResultados
   ORDER BY Cta.Cuenta

  -- drop table #Ejercicios
    CREATE TABLE #Ejercicios
   (
    Numero		int		NULL,
    Ejercicio		int		NULL)

  SELECT @Numero = 1, @PeriodoX = MONTH(GETDATE())

  -- Llena tabla con Años
 DECLARE cr_Anio CURSOR FOR 
  SELECT @EjercicioD, @EjercicioA
    OPEN cr_Anio
   FETCH NEXT FROM cr_Anio INTO @AnioInicial, @AnioFinal
   WHILE @@FETCH_STATUS <> -1
   BEGIN
     IF @@FETCH_STATUS <> -2 
     BEGIN
       WHILE @AnioInicial <= @AnioFinal
       BEGIN
         INSERT #Ejercicios (Numero, Ejercicio)
                     VALUES (@Numero, @AnioInicial)
         SELECT @AnioInicial = @AnioInicial + 1, @Numero = @Numero + 1
       END
     END
     FETCH NEXT FROM cr_Anio INTO @AnioInicial, @AnioFinal
   END
   CLOSE cr_Anio
   DEALLOCATE cr_Anio

  SELECT @Cuantos = COUNT(Ejercicio) FROM #Ejercicios

  SELECT @UltLado = NULL, @UltRama = NULL, @UltLadoDesc = NULL, @Renglon = 0

  -- Actualiza tabla con Años
  UPDATE #BalanceA SET Ejercicio1  = (SELECT Ejercicio FROM #Ejercicios WHERE Numero = 1), Ejercicio2  = (SELECT Ejercicio FROM #Ejercicios WHERE Numero = 2),
                       Ejercicio3  = (SELECT Ejercicio FROM #Ejercicios WHERE Numero = 3), Ejercicio4  = (SELECT Ejercicio FROM #Ejercicios WHERE Numero = 4),
                       Ejercicio5  = (SELECT Ejercicio FROM #Ejercicios WHERE Numero = 5)


  IF @Anual = 'Del Ejercicio'
  BEGIN
    DECLARE crBalance CURSOR FOR
     SELECT ID, Lado, LadoDesc, Rama, RamaDesc, EsTitulo,
            'Saldo1' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio1
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo <= @PeriodoX),
            'Saldo2' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio2
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo <= @PeriodoX),
            'Saldo3' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio3
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo <= @PeriodoX),
            'Saldo4' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio4
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo <= @PeriodoX),
            'Saldo5' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio5
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo <= @PeriodoX)
       FROM #BalanceA b
    OPEN crBalance
    FETCH NEXT FROM crBalance INTO @ID, @Lado, @LadoDesc, @Rama, @RamaDesc, @EsTitulo, @Saldo1, @Saldo2, @Saldo3, @Saldo4, @Saldo5
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @EsTitulo = 0
      BEGIN
        IF ISNULL(@Saldo1, 0.0) = 0.0 AND ISNULL(@Saldo2, 0.0) = 0.0 AND ISNULL(@Saldo3, 0.0) = 0.0 AND @ConMovs = 'SI'
          DELETE FROM #BalanceA WHERE ID = @ID
        ELSE 
        BEGIN
          IF @Rama <> @UltRama 
          BEGIN
            SELECT @Renglon = @Renglon + 1 
            INSERT #BalanceA (EsTitulo, EsFinRama, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
          END
          IF @UltLadoDesc<>@LadoDesc
          BEGIN
            SELECT @Renglon = @Renglon + 1 
            INSERT #BalanceA (EsTitulo, EsFinLado, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
          END
          IF @Lado <> @UltLado SELECT @Renglon = 1 ELSE SELECT @Renglon = @Renglon + 1
          IF @Rama <> @UltRama 
          BEGIN
            INSERT #BalanceA (EsTitulo, Renglon, Lado, Descripcion) VALUES (1, @Renglon, @Lado, @RamaDesc)
            SELECT @Renglon = @Renglon + 1 
          END
          UPDATE #BalanceA 
             SET Renglon = @Renglon,
                 Saldo1 = @Saldo1, Saldo2 = @Saldo2, Saldo3 = @Saldo3
           WHERE ID = @ID
          SELECT @UltLado = @Lado, @UltLadoDesc = @LadoDesc, @UltRama = @Rama
        END
      END
      FETCH NEXT FROM crBalance INTO @ID, @Lado, @LadoDesc, @Rama, @RamaDesc, @EsTitulo, @Saldo1, @Saldo2, @Saldo3, @Saldo4, @Saldo5
    END
    SELECT @Renglon = @Renglon + 1 
    INSERT #BalanceA (EsTitulo, EsFinRama, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
    SELECT @Renglon = @Renglon + 1 
    INSERT #BalanceA (EsTitulo, EsFinLado, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
    CLOSE crBalance
    DEALLOCATE crBalance
  END

  IF @Anual = 'Acumulado a'
  BEGIN
    DECLARE crBalance CURSOR FOR
     SELECT ID, Lado, LadoDesc, Rama, RamaDesc, EsTitulo,
            'Saldo1' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio1
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo BETWEEN 0 AND @PeriodoA),
            'Saldo2' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio2
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo BETWEEN 0 AND @PeriodoA),
            'Saldo3' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio3
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo BETWEEN 0 AND @PeriodoA),
            'Saldo4' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio4
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo BETWEEN 0 AND @PeriodoA),
            'Saldo5' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio5
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo BETWEEN 0 AND @PeriodoA)
       FROM #BalanceA b
    OPEN crBalance
    FETCH NEXT FROM crBalance INTO @ID, @Lado, @LadoDesc, @Rama, @RamaDesc, @EsTitulo, @Saldo1, @Saldo2, @Saldo3, @Saldo4, @Saldo5
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @EsTitulo = 0
      BEGIN
        IF ISNULL(@Saldo1, 0.0) = 0.0 AND ISNULL(@Saldo2, 0.0) = 0.0 AND ISNULL(@Saldo3, 0.0) = 0.0 AND ISNULL(@Saldo4, 0.0) = 0.0 AND ISNULL(@Saldo5, 0.0) = 0.0 AND @ConMovs = 'SI'
          DELETE FROM #BalanceA WHERE ID = @ID
        ELSE 
        BEGIN
          IF @Rama <> @UltRama 
          BEGIN
            SELECT @Renglon = @Renglon + 1 
            INSERT #BalanceA (EsTitulo, EsFinRama, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
          END
          IF @UltLadoDesc<>@LadoDesc
          BEGIN
            SELECT @Renglon = @Renglon + 1 
            INSERT #BalanceA (EsTitulo, EsFinLado, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
          END
          IF @Lado <> @UltLado SELECT @Renglon = 1 ELSE SELECT @Renglon = @Renglon + 1
          IF @Rama <> @UltRama 
          BEGIN
            INSERT #BalanceA (EsTitulo, Renglon, Lado, Descripcion) VALUES (1, @Renglon, @Lado, @RamaDesc)
            SELECT @Renglon = @Renglon + 1 
          END
          UPDATE #BalanceA 
             SET Renglon = @Renglon,
                 Saldo1 = @Saldo1, Saldo2 = @Saldo2, Saldo3 = @Saldo3, Saldo4 = @Saldo4, Saldo5 = @Saldo5
           WHERE ID = @ID
          SELECT @UltLado = @Lado, @UltLadoDesc = @LadoDesc, @UltRama = @Rama
        END
      END
      FETCH NEXT FROM crBalance INTO @ID, @Lado, @LadoDesc, @Rama, @RamaDesc, @EsTitulo, @Saldo1, @Saldo2, @Saldo3, @Saldo4, @Saldo5
    END
    SELECT @Renglon = @Renglon + 1 
    INSERT #BalanceA (EsTitulo, EsFinRama, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
    SELECT @Renglon = @Renglon + 1 
    INSERT #BalanceA (EsTitulo, EsFinLado, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
    CLOSE crBalance
    DEALLOCATE crBalance
  END

  IF @Anual = 'Del Mes'
  BEGIN
    DECLARE crBalance CURSOR FOR
     SELECT ID, Lado, LadoDesc, Rama, RamaDesc, EsTitulo,
            'Saldo1' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio1
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo = @PeriodoA),
            'Saldo2' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio2
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo = @PeriodoA),
            'Saldo3' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio3
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo = @PeriodoA),
            'Saldo4' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio4
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo = @PeriodoA),
            'Saldo5' = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
                          FROM Acum a
                         WHERE a.Empresa = @Empresa
                           AND a.Rama = 'CONT'
                           AND a.Cuenta = b.Cuenta
                           AND a.Ejercicio = b.Ejercicio5
                           AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
                           AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
			   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
			   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
			   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
			   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')
                           AND a.Moneda = @Moneda
                           AND a.Periodo = @PeriodoA)
       FROM #BalanceA b
    OPEN crBalance
    FETCH NEXT FROM crBalance INTO @ID, @Lado, @LadoDesc, @Rama, @RamaDesc, @EsTitulo, @Saldo1, @Saldo2, @Saldo3, @Saldo4, @Saldo5
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @EsTitulo = 0
      BEGIN
        IF ISNULL(@Saldo1, 0.0) = 0.0 AND ISNULL(@Saldo2, 0.0) = 0.0 AND ISNULL(@Saldo3, 0.0) = 0.0 AND ISNULL(@Saldo4, 0.0) = 0.0 AND ISNULL(@Saldo5, 0.0) = 0.0 AND @ConMovs = 'SI'
          DELETE FROM #BalanceA WHERE ID = @ID
        ELSE 
        BEGIN
          IF @Rama <> @UltRama 
          BEGIN
            SELECT @Renglon = @Renglon + 1 
            INSERT #BalanceA (EsTitulo, EsFinRama, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
          END
          IF @UltLadoDesc<>@LadoDesc
          BEGIN
            SELECT @Renglon = @Renglon + 1 
            INSERT #BalanceA (EsTitulo, EsFinLado, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
          END
          IF @Lado <> @UltLado SELECT @Renglon = 1 ELSE SELECT @Renglon = @Renglon + 1
          IF @Rama <> @UltRama 
          BEGIN
            INSERT #BalanceA (EsTitulo, Renglon, Lado, Descripcion) VALUES (1, @Renglon, @Lado, @RamaDesc)
            SELECT @Renglon = @Renglon + 1 
          END
          UPDATE #BalanceA 
             SET Renglon = @Renglon,
                 Saldo1 = @Saldo1, Saldo2 = @Saldo2, Saldo3 = @Saldo3, Saldo4 = @Saldo4, Saldo5 = @Saldo5
           WHERE ID = @ID
          SELECT @UltLado = @Lado, @UltLadoDesc = @LadoDesc, @UltRama = @Rama
        END
      END
      FETCH NEXT FROM crBalance INTO @ID, @Lado, @LadoDesc, @Rama, @RamaDesc, @EsTitulo, @Saldo1, @Saldo2, @Saldo3, @Saldo4, @Saldo5
    END
    SELECT @Renglon = @Renglon + 1 
    INSERT #BalanceA (EsTitulo, EsFinRama, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
    SELECT @Renglon = @Renglon + 1 
    INSERT #BalanceA (EsTitulo, EsFinLado, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
    CLOSE crBalance
    DEALLOCATE crBalance
  END

  SELECT @UltRenglon = NULL, @UltRama1 = NULL, @UltRama2 = NULL
  DECLARE crVerBalance CURSOR FOR
  SELECT EsTitulo, EsFinRama, EsFinLado, Renglon, Lado, LadoDesc, Rama, RamaDesc, Cuenta, Descripcion, EsAcreedora, Saldo1, Saldo2, Saldo3, Saldo4, Saldo5, Ejercicio1, Ejercicio2, Ejercicio3, Ejercicio4, Ejercicio5
    FROM #BalanceA ORDER BY Renglon, Lado, Rama
  OPEN crVerBalance
  FETCH NEXT FROM crVerBalance INTO @EsTitulo, @EsFinRama, @EsFinLado, @Renglon, @Lado, @LadoDesc, @Rama, @RamaDesc, @Cuenta, @Descripcion, @EsAcreedora, @Saldo1, @Saldo2, @Saldo3, @Saldo4, @Saldo5, @Ejercicio1, @Ejercicio2, @Ejercicio3, @Ejercicio4, @Ejercicio5
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      IF @Lado = 1
      BEGIN
        IF @UltRenglon <> @Renglon
          INSERT #VerBalanceA (Renglon,  Lado,  EsTitulo1, EsFinRama1, EsFinLado1, LadoDesc1, Rama1, RamaDesc1, Cuenta1, Descripcion1, EsAcreedora1, Saldo11, Ejercicio11, Saldo12, Ejercicio12, Saldo13, Ejercicio13, Saldo14, Ejercicio14, Saldo15, Ejercicio15)
                      VALUES ( @Renglon, @Lado, @EsTitulo, @EsFinRama, @EsFinLado, @LadoDesc, @Rama, @RamaDesc, @Cuenta, @Descripcion, @EsAcreedora, @Saldo1, @Ejercicio1, @Saldo2, @Ejercicio2, @Saldo3, @Ejercicio3, @Saldo4, @Ejercicio4, @Saldo5, @Ejercicio5)
        ELSE
          UPDATE #VerBalanceA  
             SET EsTitulo1 = @EsTitulo, EsFinRama1 = @EsFinRama, EsFinLado1 = @EsFinLado, LadoDesc1 = @LadoDesc, Rama1 = @Rama, RamaDesc1 = @RamaDesc, Cuenta1 = @Cuenta, Descripcion1 = @Descripcion, EsAcreedora1 = @EsAcreedora, Saldo11 = @Saldo1, Ejercicio11 = @Ejercicio1, Saldo12 = @Saldo2, Ejercicio12 = @Ejercicio2, Saldo13 = @Saldo3, Ejercicio13 = @Ejercicio3, Saldo14 = @Saldo4, Ejercicio14 = @Ejercicio4, Saldo15 = @Saldo5, Ejercicio15 = @Ejercicio5
           WHERE Renglon = @Renglon       
      END ELSE BEGIN
        IF @UltRenglon <> @Renglon
          INSERT #VerBalanceA (Renglon,  Lado,  EsTitulo2, EsFinRama2, EsFinLado2, LadoDesc2, Rama2, RamaDesc2, Cuenta2, Descripcion2, EsAcreedora2, Saldo21, Ejercicio21, Saldo22, Ejercicio22, Saldo23, Ejercicio23)
                       VALUES (@Renglon, @Lado, @EsTitulo, @EsFinRama, @EsFinLado, @LadoDesc, @Rama, @RamaDesc, @Cuenta, @Descripcion, @EsAcreedora, @Saldo1, @Ejercicio1, @Saldo2, @Ejercicio2, @Saldo3, @Ejercicio3)
        ELSE
          UPDATE #VerBalanceA  
             SET EsTitulo2 = @EsTitulo, EsFinRama2 = @EsFinRama, EsFinLado2 = @EsFinLado, LadoDesc2 = @LadoDesc, Rama2 = @Rama, RamaDesc2 = @RamaDesc, Cuenta2 = @Cuenta, Descripcion2 = @Descripcion, EsAcreedora2 = @EsAcreedora, Saldo21 = @Saldo1, Ejercicio21 = @Ejercicio1, Saldo22 = @Saldo2, Ejercicio22 = @Ejercicio2, Saldo23 = @Saldo3, Ejercicio23 = @Ejercicio3
           WHERE Renglon = @Renglon
      END
      SELECT @UltRenglon = @Renglon
    END
    FETCH NEXT FROM crVerBalance INTO @EsTitulo, @EsFinRama, @EsFinLado, @Renglon, @Lado, @LadoDesc, @Rama, @RamaDesc, @Cuenta, @Descripcion, @EsAcreedora, @Saldo1, @Saldo2, @Saldo3, @Saldo4, @Saldo5, @Ejercicio1, @Ejercicio2, @Ejercicio3, @Ejercicio4, @Ejercicio5
  END
  CLOSE crVerBalance
  DEALLOCATE crVerBalance

  --REQ2162
  IF @ReExpresar='Si'
    UPDATE #VerBalanceA
	SET Saldo11=Saldo11/ISNULL(@ReExpresarTipoCambio,1), Saldo12=Saldo12/ISNULL(@ReExpresarTipoCambio,1), Saldo13=Saldo13/ISNULL(@ReExpresarTipoCambio,1),
        Saldo21=Saldo21/ISNULL(@ReExpresarTipoCambio,1), Saldo22=Saldo22/ISNULL(@ReExpresarTipoCambio,1), Saldo23=Saldo23/ISNULL(@ReExpresarTipoCambio,1)

  SELECT * FROM #VerBalanceA WHERE EsTitulo1 = 0

END
GO

/*

exec spVerContBalanceAnuales  '100', 2004, 2005, 4, 'Acumulado a', 'Si', NULL, -1, 'Pesos'

*/


/**************** spContAuxIntSucursal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContAuxIntSucursal') and type = 'P') drop procedure dbo.spContAuxIntSucursal
go
CREATE PROC spContAuxIntSucursal
 ( @Empresa 		Char(5),
   @Estatus 		Char(10),
   @CuentaD 		Char(20),
   @CuentaA 		Char(20),
   @FechaD 		DateTime,
   @FechaA 		DateTime,
   @MovEspecifico 	char(20) = NULL,
   @CtaCat 		char(50) = NULL,   --BUG7187 PRODRIGUEZ
   @CtaGrupo 	char(50) = NULL ,
   @CtaFam 		char(50) = NULL,
   @Sucursal            int = NULL,
   @IncluirPresupuestos	varchar(2) = 'No' -- BUG6900
   )
WITH ENCRYPTION
AS
BEGIN
 IF UPPER(@MovEspecifico) IN ('0', 'NULL', '(TODOS)','') SELECT @MovEspecifico = NULL
 IF UPPER(@CtaCat)        IN ('0', 'NULL', '(TODOS)','') SELECT @CtaCat = NULL
 IF UPPER(@CtaFam)        IN ('0', 'NULL', '(TODOS)','') SELECT @CtaFam = NULL
 IF UPPER(@CtaGrupo)      IN ('0', 'NULL', '(TODOS)','') SELECT @CtaGrupo = NULL
 --IF @Sucursal             IN ('',  'NULL', '(TODOS)','') SELECT @Sucursal = NULL

 SELECT ContAux.ID,
        ContAux.Empresa,
        ContAux.Cuenta,
        ContAux.SubCuenta,
        ContAux.Ejercicio,
        ContAux.Periodo,
        ContAux.Renglon,
        ContAux.RenglonSub,
        ContAux.Concepto,
        ContAux.Debe,
        ContAux.Haber,
        ContAux.FechaContable,
        ContAux.Movimiento,
        ContMov = ContAux.Mov,
        ContAux.Referencia,
        ContAux.Estatus,
        ContAux.SucursalContable,
        ContAux.Presupuesto -- BUG6900
   INTO #TempContAux
   FROM ContAux
  WHERE ContAux.Empresa = @Empresa
    AND ContAux.Estatus = @Estatus
    AND ContAux.Cuenta  >=  @CuentaD AND ContAux.Cuenta  <=  @CuentaA 
    AND ContAux.FechaContable  >=  @FechaD AND ContAux.FechaContable  <=  @FechaA 
    AND ContAux.Mov = ISNULL(@MovEspecifico, ContAux.Mov)
    AND ContAux.SucursalContable = ISNULL(@Sucursal, ContAux.SucursalContable)
  ORDER BY ContAux.Cuenta, ContAux.FechaContable, ContAux.ID 

  IF @IncluirPresupuestos = 'No' -- BUG6900
  BEGIN
    SELECT t.ID,
           t.Empresa,
       	   t.Cuenta,
	       t.SubCuenta,
	       t.Ejercicio,
	       t.Periodo,
	       t.Renglon,
	       t.RenglonSub,
	       t.Concepto,
	       t.Debe,
	       t.Haber,
	       t.FechaContable,
	       t.Movimiento,
	       t.Referencia,
	       t.Estatus,
           t.SucursalContable,
           Cta.Descripcion,
           Cta.Cuenta AS 'CtaCuenta'
      FROM Cta
      LEFT OUTER JOIN #TempContAux t ON Cta.Cuenta = t.Cuenta
     WHERE Cta.Cuenta BETWEEN @CuentaD AND @CuentaA --AND Cta.Tipo in ('SubCuenta','Auxiliar', 'Mayor')
       AND Cta.TieneMovimientos = 1 AND Cta.EsAcumulativa = 0 
       AND ISNULL(Cta.Categoria, 0) = ISNULL(ISNULL(@CtaCat, Cta.Categoria), 0)
       AND ISNULL(Cta.Familia, 0) = ISNULL(ISNULL(@CtaFam, Cta.Familia), 0)
       AND ISNULL(Cta.Grupo, 0) = ISNULL(ISNULL(@CtaGrupo, Cta.Grupo), 0)
       AND ISNULL(t.Presupuesto, 0) = 0 -- BUG6900
     ORDER BY Cta.Cuenta, t.FechaContable, t.ID  ASC
  END     
  ELSE IF @IncluirPresupuestos = 'Si' -- BUG6900
  BEGIN
    SELECT t.ID,
           t.Empresa,
       	   t.Cuenta,
	       t.SubCuenta,
	       t.Ejercicio,
	       t.Periodo,
	       t.Renglon,
	       t.RenglonSub,
	       t.Concepto,
	       t.Debe,
	       t.Haber,
	       t.FechaContable,
	       t.Movimiento,
	       t.Referencia,
	       t.Estatus,
           t.SucursalContable,
           Cta.Descripcion,
           Cta.Cuenta AS 'CtaCuenta'
      FROM Cta
      LEFT OUTER JOIN #TempContAux t ON Cta.Cuenta = t.Cuenta
     WHERE Cta.Cuenta BETWEEN @CuentaD AND @CuentaA --AND Cta.Tipo in ('SubCuenta','Auxiliar', 'Mayor')
       AND Cta.TieneMovimientos = 1 AND Cta.EsAcumulativa = 0 
       AND ISNULL(Cta.Categoria, 0) = ISNULL(ISNULL(@CtaCat, Cta.Categoria), 0)
       AND ISNULL(Cta.Familia, 0) = ISNULL(ISNULL(@CtaFam, Cta.Familia), 0)
       AND ISNULL(Cta.Grupo, 0) = ISNULL(ISNULL(@CtaGrupo, Cta.Grupo), 0)
       AND ISNULL(t.Presupuesto, 0) = 0 -- BUG6900       
    UNION ALL -- BUG6900
    SELECT t.ID,
           t.Empresa,
       	   t.Cuenta,
	       t.SubCuenta,
	       t.Ejercicio,
	       t.Periodo,
	       t.Renglon,
	       t.RenglonSub,
	       t.Concepto,
	       t.Debe,
	       t.Haber,
	       t.FechaContable,
	       t.Movimiento,
	       t.Referencia,
	       t.Estatus,
           t.SucursalContable,
           Cta.Descripcion,
           Cta.Cuenta AS 'CtaCuenta'
      FROM Cta
      LEFT OUTER JOIN #TempContAux t ON Cta.Cuenta = t.Cuenta
     WHERE Cta.Cuenta BETWEEN @CuentaD AND @CuentaA --AND Cta.Tipo in ('SubCuenta','Auxiliar', 'Mayor')
       AND Cta.EsAcumulativa = 0 
       AND ISNULL(Cta.Categoria, 0) = ISNULL(ISNULL(@CtaCat, Cta.Categoria), 0)
       AND ISNULL(Cta.Familia, 0) = ISNULL(ISNULL(@CtaFam, Cta.Familia), 0)
       AND ISNULL(Cta.Grupo, 0) = ISNULL(ISNULL(@CtaGrupo, Cta.Grupo), 0)
       AND ISNULL(t.Presupuesto, 0) = 1 -- BUG6900       
     ORDER BY Cta.Cuenta, t.FechaContable, t.ID  ASC      
  END
END
GO