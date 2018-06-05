/*
 SELECT * FROM Modulo
 EXEC spCalcResumenMov 'Pesos', @NivelProyecto = 1
 SELECT * FROM ResumenMov
*/

/**************** spCalcResumenMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcResumenMov') and type = 'P') drop procedure dbo.spCalcResumenMov
GO             
CREATE PROCEDURE spCalcResumenMov
			@FechaRegistro	datetime,
			@DefMoneda	char(10)
--//WITH ENCRYPTION
AS BEGIN
    TRUNCATE TABLE ResumenMov

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'VTAS', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(SubTotal), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM VentaCalc
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)
    SELECT 'PC', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*)
      FROM PC
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)
    SELECT 'VALE', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*)
      FROM Vale
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)

    SELECT 'CR', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*)
      FROM CR
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)
    SELECT 'ST', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, @DefMoneda, COUNT(*)
      FROM Soporte
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos)
    SELECT 'EMB', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, @DefMoneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0)
      FROM Embarque
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'CXC', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Cxc
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'DIN', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Dinero
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe)
    SELECT 'INV', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0)
      FROM Inv
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe)
    SELECT 'PROD', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0)
      FROM Prod
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos)
    SELECT 'AF', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0)
      FROM ActivoFijo
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe)
    SELECT 'NOM', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(ISNULL(Percepciones, 0.0)-ISNULL(Deducciones, 0.0)), 0.0)
      FROM Nomina
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)
    SELECT 'ASIS', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, @DefMoneda, COUNT(*)
      FROM Asiste
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)
    SELECT 'RH', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*)
      FROM RH
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'GAS', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Gasto
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'AGENT', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Agent
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'CXP', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Cxp
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMov (Modulo, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'COMS', Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Compra
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    UPDATE Version SET UltimoResumenMov = @FechaRegistro
END
GO


/**************** spCalcResumenMovProyecto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcResumenMovProyecto') and type = 'P') drop procedure dbo.spCalcResumenMovProyecto
GO             
CREATE PROCEDURE spCalcResumenMovProyecto
			@FechaRegistro	datetime,
			@DefMoneda	char(10)
--//WITH ENCRYPTION
AS BEGIN
    TRUNCATE TABLE ResumenMovProyecto

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'VTAS', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(SubTotal), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM VentaCalc
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)
    SELECT 'PC', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*)
      FROM PC
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)
    SELECT 'VALE', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*)
      FROM Vale
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)
    SELECT 'CR', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*)
      FROM CR
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)
    SELECT 'ST', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, @DefMoneda, COUNT(*)
      FROM Soporte
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos)
    SELECT 'EMB', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, @DefMoneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0)
      FROM Embarque
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'CXC', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Cxc
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'DIN', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Dinero
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe)
    SELECT 'INV', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0)
      FROM Inv
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe)
    SELECT 'PROD', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0)
      FROM Prod
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos)
    SELECT 'AF', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0)
      FROM ActivoFijo
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe)
    SELECT 'NOM', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(ISNULL(Percepciones, 0.0)-ISNULL(Deducciones, 0.0)), 0.0)
      FROM Nomina
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)
    SELECT 'ASIS', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, @DefMoneda, COUNT(*)
      FROM Asiste
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo)
    SELECT 'RH', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*)
      FROM RH
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'GAS', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Gasto
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'AGENT', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Agent
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'CXP', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Cxp
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    INSERT ResumenMovProyecto (Modulo, Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, Conteo, Importe, Impuestos, Saldo)
    SELECT 'COMS', ISNULL(Proyecto, ''), Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda, COUNT(*), NULLIF(SUM(Importe), 0.0), NULLIF(SUM(Impuestos), 0.0), NULLIF(SUM(Saldo), 0.0)
      FROM Compra
     WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')
     GROUP BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda
     ORDER BY Proyecto, Empresa, Sucursal, Ejercicio, Periodo, Mov, Estatus, Moneda

    UPDATE Version SET UltimoResumenMovProyecto = @FechaRegistro
END
GO

/**************** spCalcResumenSaldo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcResumenSaldo') and type = 'P') drop procedure dbo.spCalcResumenSaldo
GO             
CREATE PROCEDURE spCalcResumenSaldo
			@FechaRegistro	datetime
--//WITH ENCRYPTION
AS BEGIN
    TRUNCATE TABLE ResumenSaldo

    INSERT ResumenSaldo (Modulo, Rama, Empresa, Sucursal, Moneda, Saldo)
    SELECT r.Mayor, s.Rama, s.Empresa, s.Sucursal, s.Moneda, NULLIF(SUM(s.Saldo*r.Factor), 0.0)
      FROM Saldo s, Rama r
     WHERE s.Rama = r.Rama AND s.Rama NOT IN ('CONT', 'CC')
     GROUP BY r.Mayor, s.Rama, s.Empresa, s.Sucursal, s.Moneda

    INSERT ResumenSaldo (Modulo, Rama, Empresa, Sucursal, Moneda, Saldo, SaldoU)
    SELECT r.Mayor, s.Rama, s.Empresa, s.Sucursal, s.Moneda, NULLIF(SUM(s.Saldo*r.Factor), 0.0), NULLIF(SUM(s.SaldoU*r.Factor), 0.0)
      FROM SaldoU s, Rama r
     WHERE s.Rama = r.Rama
     GROUP BY r.Mayor, s.Rama, s.Empresa, s.Sucursal, s.Moneda

    UPDATE Version SET UltimoResumenSaldo = @FechaRegistro
END
GO


/**************** spCalcResumen ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcResumen') and type = 'P') drop procedure dbo.spCalcResumen
GO             
CREATE PROCEDURE spCalcResumen
			@DefMoneda	char(10),
			@NivelProyecto	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaRegistro	datetime
  SELECT @FechaRegistro = GETDATE()

  EXEC spCalcResumenSaldo @FechaRegistro

  IF @NivelProyecto = 1
    EXEC spCalcResumenMovProyecto @FechaRegistro, @DefMoneda
  ELSE
    EXEC spCalcResumenMov @FechaRegistro, @DefMoneda
END
GO
