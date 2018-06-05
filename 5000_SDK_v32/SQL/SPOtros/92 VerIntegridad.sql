/****** IntSaldo ******/
if not exists(select * from SysTabla where SysTabla = 'IntSaldo')
INSERT INTO SysTabla (SysTabla) VALUES ('IntSaldo')
if not exists (select * from sysobjects where id = object_id('dbo.IntSaldo') and type = 'U') 
  CREATE TABLE dbo.IntSaldo (
       Estacion		int		NOT NULL,
       ID		int		NOT NULL IDENTITY(1,1),
     
       Tabla		varchar(20)	NULL,
       Empresa		char(5)	 	NULL,
       Rama		char(5)	 	NULL,
       Cuenta		char(10) 	NULL,
       Moneda		char(10) 	NULL,
       Importe  	money   	NULL,
       Cantidad 	float   	NULL,

       CONSTRAINT priIntSaldo PRIMARY KEY  CLUSTERED (Estacion, ID)
  )
go

/**************** spCalcIntSaldo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcIntSaldo') and type = 'P') drop procedure dbo.spCalcIntSaldo
GO             
CREATE PROCEDURE spCalcIntSaldo
			@Estacion	int,
                        @Nivel		char(20)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Nivel = UPPER(@Nivel)
  DELETE IntSaldo WHERE Estacion = @Estacion

  /* Saldo */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe) SELECT @Estacion, 'Saldo', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Saldo), 0.0) FROM Saldo, Rama WHERE Saldo.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe)         SELECT @Estacion, 'Saldo', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Saldo), 0.0) FROM Saldo, Rama WHERE Saldo.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda

  /* Acum */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe) SELECT @Estacion, 'Acum', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Cargos), 0.0)-ISNULL(SUM(Abonos), 0.0) FROM Acum, Rama WHERE Acum.Rama = Rama.Rama AND Periodo <> 0 GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe)         SELECT @Estacion, 'Acum', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Cargos), 0.0)-ISNULL(SUM(Abonos), 0.0) FROM Acum, Rama WHERE Acum.Rama = Rama.Rama AND Periodo <> 0 GROUP BY Empresa, Rama.Mayor, Moneda

  /* Auxiliar */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe) SELECT @Estacion, 'Auxiliar', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Cargo), 0.0)-ISNULL(SUM(Abono), 0.0) FROM Auxiliar, Rama WHERE Auxiliar.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe)         SELECT @Estacion, 'Auxiliar', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Cargo), 0.0)-ISNULL(SUM(Abono), 0.0) FROM Auxiliar, Rama WHERE Auxiliar.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda

  /* SaldoU */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe, Cantidad) SELECT @Estacion, 'SaldoU', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Saldo), 0.0), ISNULL(SUM(SaldoU), 0.0) FROM SaldoU, Rama WHERE SaldoU.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe, Cantidad)         SELECT @Estacion, 'SaldoU', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Saldo), 0.0), ISNULL(SUM(SaldoU), 0.0) FROM SaldoU, Rama WHERE SaldoU.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda

  /* AcumU */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe, Cantidad) SELECT @Estacion, 'AcumU', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Cargos), 0.0)-ISNULL(SUM(Abonos), 0.0), ISNULL(SUM(CargosU), 0.0)-ISNULL(SUM(AbonosU), 0.0) FROM AcumU, Rama WHERE AcumU.Rama = Rama.Rama AND Periodo <> 0 GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe, Cantidad)         SELECT @Estacion, 'AcumU', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Cargos), 0.0)-ISNULL(SUM(Abonos), 0.0), ISNULL(SUM(CargosU), 0.0)-ISNULL(SUM(AbonosU), 0.0) FROM AcumU, Rama WHERE AcumU.Rama = Rama.Rama AND Periodo <> 0 GROUP BY Empresa, Rama.Mayor, Moneda

  /* AuxiliarU */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe, Cantidad) SELECT @Estacion, 'AuxiliarU', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Cargo), 0.0)-ISNULL(SUM(Abono), 0.0), ISNULL(SUM(CargoU), 0.0)-ISNULL(SUM(AbonoU), 0.0) FROM AuxiliarU, Rama WHERE AuxiliarU.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe, Cantidad)         SELECT @Estacion, 'AuxiliarU', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Cargo), 0.0)-ISNULL(SUM(Abono), 0.0), ISNULL(SUM(CargoU), 0.0)-ISNULL(SUM(AbonoU), 0.0) FROM AuxiliarU, Rama WHERE AuxiliarU.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda

  /* SaldoR */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe) SELECT @Estacion, 'SaldoR', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Saldo), 0.0) FROM SaldoR, Rama WHERE SaldoR.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe)         SELECT @Estacion, 'SaldoR', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Saldo), 0.0) FROM SaldoR, Rama WHERE SaldoR.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda

  /* AcumR */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe) SELECT @Estacion, 'AcumR', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Cargos), 0.0)-ISNULL(SUM(Abonos), 0.0) FROM AcumR, Rama WHERE AcumR.Rama = Rama.Rama AND Periodo <> 0 GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe)         SELECT @Estacion, 'AcumR', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Cargos), 0.0)-ISNULL(SUM(Abonos), 0.0) FROM AcumR, Rama WHERE AcumR.Rama = Rama.Rama AND Periodo <> 0 GROUP BY Empresa, Rama.Mayor, Moneda

  /* AuxiliarR */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe) SELECT @Estacion, 'AuxiliarR', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Cargo), 0.0)-ISNULL(SUM(Abono), 0.0) FROM AuxiliarR, Rama WHERE AuxiliarR.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe)         SELECT @Estacion, 'AuxiliarR', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Cargo), 0.0)-ISNULL(SUM(Abono), 0.0) FROM AuxiliarR, Rama WHERE AuxiliarR.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda

  /* SaldoRU */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe, Cantidad) SELECT @Estacion, 'SaldoRU', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Saldo), 0.0), ISNULL(SUM(SaldoU), 0.0) FROM SaldoRU, Rama WHERE SaldoRU.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe, Cantidad)         SELECT @Estacion, 'SaldoRU', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Saldo), 0.0), ISNULL(SUM(SaldoU), 0.0) FROM SaldoRU, Rama WHERE SaldoRU.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda

  /* AcumRU */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe, Cantidad) SELECT @Estacion, 'AcumRU', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Cargos), 0.0)-ISNULL(SUM(Abonos), 0.0), ISNULL(SUM(CargosU), 0.0)-ISNULL(SUM(AbonosU), 0.0) FROM AcumRU, Rama WHERE AcumRU.Rama = Rama.Rama AND Periodo <> 0 GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe, Cantidad)         SELECT @Estacion, 'AcumRU', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Cargos), 0.0)-ISNULL(SUM(Abonos), 0.0), ISNULL(SUM(CargosU), 0.0)-ISNULL(SUM(AbonosU), 0.0) FROM AcumRU, Rama WHERE AcumRU.Rama = Rama.Rama AND Periodo <> 0 GROUP BY Empresa, Rama.Mayor, Moneda

  /* AuxiliarRU */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe, Cantidad) SELECT @Estacion, 'AuxiliarRU', Empresa, Rama.Mayor, Moneda, Cuenta, ISNULL(SUM(Cargo), 0.0)-ISNULL(SUM(Abono), 0.0), ISNULL(SUM(CargoU), 0.0)-ISNULL(SUM(AbonoU), 0.0) FROM AuxiliarRU, Rama WHERE AuxiliarRU.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda, Cuenta
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe, Cantidad)         SELECT @Estacion, 'AuxiliarRU', Empresa, Rama.Mayor, Moneda,         ISNULL(SUM(Cargo), 0.0)-ISNULL(SUM(Abono), 0.0), ISNULL(SUM(CargoU), 0.0)-ISNULL(SUM(AbonoU), 0.0) FROM AuxiliarRU, Rama WHERE AuxiliarRU.Rama = Rama.Rama GROUP BY Empresa, Rama.Mayor, Moneda

  /* Cxc */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe) SELECT @Estacion, 'Cxc', Empresa, 'CXC', Moneda, Cliente, ISNULL(SUM(Saldo), 0.0) FROM CxcInfo WHERE Estatus = 'PENDIENTE' GROUP BY Empresa, Moneda, Cliente
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe)         SELECT @Estacion, 'Cxc', Empresa, 'CXC', Moneda,          ISNULL(SUM(Saldo), 0.0) FROM CxcInfo WHERE Estatus = 'PENDIENTE' GROUP BY Empresa, Moneda

  /* Cxp */
  IF @Nivel = 'CUENTA'  INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Cuenta, Importe) SELECT @Estacion, 'Cxp', Empresa, 'CXP', Moneda, Proveedor, ISNULL(SUM(Saldo), 0.0) FROM CxpInfo WHERE Estatus = 'PENDIENTE' GROUP BY Empresa, Moneda, Proveedor
  IF @Nivel = 'RAMA'    INSERT IntSaldo (Estacion, Tabla, Empresa, Rama, Moneda, Importe)         SELECT @Estacion, 'Cxp', Empresa, 'CXP', Moneda,            ISNULL(SUM(Saldo), 0.0) FROM CxpInfo WHERE Estatus = 'PENDIENTE' GROUP BY Empresa, Moneda

  RETURN
END
GO

-- EXEC spCalcIntSaldo 1, 'CUENTA'

/*

select Tabla, Empresa, Rama, Cuenta, Moneda, Importe, Cantidad from intsaldo 
 where ROUND(ISNULL(importe, 0.0), 0) > 0.0 AND ROUND(ISNULL(cantidad, 0.0), 0) > 0.0 
 order by Empresa, moneda, rama, cuenta, importe, cantidad

 select * from intsaldo where empresa = 'sanyo' and moneda = 'pesos' and rama = 'cxp' and tabla = 'saldo' order by Empresa, moneda, rama, cuenta
 select * from intsaldo where empresa = 'sanyo' and moneda = 'pesos' and rama = 'cxp' and tabla = 'cxp' order by Empresa, moneda, rama, cuenta

 select * from intsaldo where empresa = 'sanyo' and moneda = 'pesos' and rama = 'cxp' and tabla = 'saldo' order by Empresa, moneda, rama, cuenta
 select * from intsaldo where empresa = 'sanyo' and moneda = 'pesos' and rama = 'cxp' and tabla = 'cxp' order by Empresa, moneda, rama, cuenta
*/

/*select * from cxcinfo where empresa = 'bhoga' and cliente = 'buen1' and id = 26458
select importe, saldo, * from cxc where empresa = 'bhoga' and cliente = 'buen1' and id = 26458

select id, importe, saldo from cxc where saldo>importe+impuestos and estatus = 'pendiente'
update cxc set saldo = 0.0, Estatus = 'CONCLUIDO' where id = 26458 

select * from auxiliar where empresa = 'bhoga' and cuenta = 'buen1' and aplica ='credito diverso' and aplicaid = 1
*/