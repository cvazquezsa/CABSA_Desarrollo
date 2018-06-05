/* SP AUXILIARES     */

/**************** spVerAuxCont ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAuxCont') and type = 'P') drop procedure dbo.spVerAuxCont
GO             
CREATE PROCEDURE spVerAuxCont
		    @Empresa		char(5),
		    @Estacion		int,
		    @Cuenta		char(20),
     		    @DelEjercicio	int,
     		    @AlEjercicio	int,
     		    @DelPeriodo		int,
     		    @AlPeriodo		int,
		    @FechaD		datetime,
		    @FechaA		datetime,
                    @Nivel		char(20),
		    @Moneda		char(10) = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Nivel = 'DIA'
    INSERT VerAux (Estacion, Ejercicio, Periodo, Fecha, Cargo, Abono)
    SELECT @Estacion, d.Ejercicio, d.Periodo, d.FechaContable, Sum(d.Debe/CASE WHEN @Moneda=f.Moneda2 THEN f.TipoCambio2 ELSE f.TipoCambio END), Sum(d.Haber/CASE WHEN @Moneda=f.Moneda2 THEN f.TipoCambio2 ELSE f.TipoCambio END)
      FROM Cont f, ContD d
     WHERE f.ID = d.ID 
       AND f.Estatus = 'CONCLUIDO'
       AND d.Empresa = @Empresa 
       AND d.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND d.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND d.FechaContable BETWEEN @FechaD AND @FechaA
       AND d.Cuenta = @Cuenta
       AND d.Presupuesto = 0
     GROUP BY d.Ejercicio, d.Periodo, d.FechaContable
     ORDER BY d.Ejercicio, d.Periodo, d.FechaContable      
  ELSE 
    INSERT VerAux (Estacion, Modulo, Orden, SubCuenta, Ejercicio, Periodo, Fecha, ModuloID, Mov, MovID, Aplica, AplicaID, Concepto, Referencia,  Cargo, Abono)
    SELECT @Estacion, 'CONT', d.ID, d.SubCuenta, d.Ejercicio, d.Periodo, d.FechaContable, d.ID, f.Mov, f.MovID, f.Mov, f.MovID, f.Concepto, f.Referencia, d.Debe/CASE WHEN @Moneda=f.Moneda2 THEN f.TipoCambio2 ELSE f.TipoCambio END, d.Haber/CASE WHEN @Moneda=f.Moneda2 THEN f.TipoCambio2 ELSE f.TipoCambio END
      FROM Cont f, ContD d
     WHERE f.ID = d.ID 
       AND f.Estatus = 'CONCLUIDO'
       AND d.Empresa = @Empresa 
       AND d.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND d.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND d.FechaContable BETWEEN @FechaD AND @FechaA
       AND d.Cuenta = @Cuenta
       AND d.Presupuesto = 0
END
GO

/**************** spVerAuxCC ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAuxCC') and type = 'P') drop procedure dbo.spVerAuxCC
GO             
CREATE PROCEDURE spVerAuxCC
		    @Empresa		char(5),
		    @Estacion		int,
		    @Cuenta		char(20),
     		    @DelEjercicio	int,
     		    @AlEjercicio	int,
     		    @DelPeriodo		int,
     		    @AlPeriodo		int,
		    @FechaD		datetime,
		    @FechaA		datetime,
                    @Nivel		char(20)
--//WITH ENCRYPTION
AS BEGIN
  IF @Nivel = 'DIA'
    INSERT VerAux (Estacion, Ejercicio, Periodo, Fecha, Cargo, Abono)
    SELECT @Estacion, d.Ejercicio, d.Periodo, d.FechaContable, Sum(d.Debe), Sum(d.Haber)
      FROM Cont f, ContD d
     WHERE f.ID = d.ID 
       AND f.Estatus = 'CONCLUIDO'
       AND d.Empresa = @Empresa 
       AND d.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND d.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND d.FechaContable BETWEEN @FechaD AND @FechaA
       AND d.SubCuenta = @Cuenta
       AND d.Presupuesto = 0
     GROUP BY d.Ejercicio, d.Periodo, d.FechaContable
     ORDER BY d.Ejercicio, d.Periodo, d.FechaContable
  ELSE 
    INSERT VerAux (Estacion, Modulo, Orden, SubCuenta, Ejercicio, Periodo, Fecha, ModuloID, Mov, MovID, Aplica, AplicaID, Concepto, Referencia,  Cargo, Abono)
    SELECT @Estacion, 'CONT', d.ID, d.SubCuenta, d.Ejercicio, d.Periodo, d.FechaContable, d.ID, f.Mov, f.MovID, f.Mov, f.MovID, f.Concepto, f.Referencia, d.Debe, d.Haber
      FROM Cont f, ContD d
     WHERE f.ID = d.ID 
       AND f.Estatus = 'CONCLUIDO'
       AND d.Empresa = @Empresa 
       AND d.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND d.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND d.FechaContable BETWEEN @FechaD AND @FechaA
       AND d.SubCuenta = @Cuenta
       AND d.Presupuesto = 0
END
GO

/**************** spVerAuxCC2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAuxCC2') and type = 'P') drop procedure dbo.spVerAuxCC2
GO             
CREATE PROCEDURE spVerAuxCC2
		    @Empresa		char(5),
		    @Estacion		int,
		    @Cuenta		char(20),
     		    @DelEjercicio	int,
     		    @AlEjercicio	int,
     		    @DelPeriodo		int,
     		    @AlPeriodo		int,
		    @FechaD		datetime,
		    @FechaA		datetime,
                    @Nivel		char(20)
--//WITH ENCRYPTION
AS BEGIN
  IF @Nivel = 'DIA'
    INSERT VerAux (Estacion, Ejercicio, Periodo, Fecha, Cargo, Abono)
    SELECT @Estacion, d.Ejercicio, d.Periodo, d.FechaContable, Sum(d.Debe), Sum(d.Haber)
      FROM Cont f, ContD d
     WHERE f.ID = d.ID 
       AND f.Estatus = 'CONCLUIDO'
       AND d.Empresa = @Empresa 
       AND d.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND d.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND d.FechaContable BETWEEN @FechaD AND @FechaA
       AND d.SubCuenta2 = @Cuenta
       AND d.Presupuesto = 0
     GROUP BY d.Ejercicio, d.Periodo, d.FechaContable
     ORDER BY d.Ejercicio, d.Periodo, d.FechaContable
  ELSE 
    INSERT VerAux (Estacion, Modulo, Orden, SubCuenta, Ejercicio, Periodo, Fecha, ModuloID, Mov, MovID, Aplica, AplicaID, Concepto, Referencia,  Cargo, Abono)
    SELECT @Estacion, 'CONT', d.ID, d.SubCuenta2, d.Ejercicio, d.Periodo, d.FechaContable, d.ID, f.Mov, f.MovID, f.Mov, f.MovID, f.Concepto, f.Referencia, d.Debe, d.Haber
      FROM Cont f, ContD d
     WHERE f.ID = d.ID 
       AND f.Estatus = 'CONCLUIDO'
       AND d.Empresa = @Empresa 
       AND d.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND d.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND d.FechaContable BETWEEN @FechaD AND @FechaA
       AND d.SubCuenta2 = @Cuenta
       AND d.Presupuesto = 0
END
GO

/**************** spVerAuxCC3 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAuxCC3') and type = 'P') drop procedure dbo.spVerAuxCC3
GO             
CREATE PROCEDURE spVerAuxCC3
		    @Empresa		char(5),
		    @Estacion		int,
		    @Cuenta		char(20),
     		    @DelEjercicio	int,
     		    @AlEjercicio	int,
     		    @DelPeriodo		int,
     		    @AlPeriodo		int,
		    @FechaD		datetime,
		    @FechaA		datetime,
                    @Nivel		char(20)
--//WITH ENCRYPTION
AS BEGIN
  IF @Nivel = 'DIA'
    INSERT VerAux (Estacion, Ejercicio, Periodo, Fecha, Cargo, Abono)
    SELECT @Estacion, d.Ejercicio, d.Periodo, d.FechaContable, Sum(d.Debe), Sum(d.Haber)
      FROM Cont f, ContD d
     WHERE f.ID = d.ID 
       AND f.Estatus = 'CONCLUIDO'
       AND d.Empresa = @Empresa 
       AND d.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND d.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND d.FechaContable BETWEEN @FechaD AND @FechaA
       AND d.SubCuenta3 = @Cuenta
       AND d.Presupuesto = 0
     GROUP BY d.Ejercicio, d.Periodo, d.FechaContable
     ORDER BY d.Ejercicio, d.Periodo, d.FechaContable
  ELSE 
    INSERT VerAux (Estacion, Modulo, Orden, SubCuenta, Ejercicio, Periodo, Fecha, ModuloID, Mov, MovID, Aplica, AplicaID, Concepto, Referencia,  Cargo, Abono)
    SELECT @Estacion, 'CONT', d.ID, d.SubCuenta3, d.Ejercicio, d.Periodo, d.FechaContable, d.ID, f.Mov, f.MovID, f.Mov, f.MovID, f.Concepto, f.Referencia, d.Debe, d.Haber
      FROM Cont f, ContD d
     WHERE f.ID = d.ID 
       AND f.Estatus = 'CONCLUIDO'
       AND d.Empresa = @Empresa 
       AND d.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND d.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND d.FechaContable BETWEEN @FechaD AND @FechaA
       AND d.SubCuenta3 = @Cuenta
       AND d.Presupuesto = 0
END
GO

/**************** spVerAux ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAux') and type = 'P') drop procedure dbo.spVerAux
GO             
CREATE PROCEDURE spVerAux
		    @Empresa		char(5),
		    @Estacion		int,
                    @Rama		char(5),
                    @Moneda		char(10),
                    @Grupo		char(10),
		    @Cuenta		char(20),
     		    @DelEjercicio	int,
     		    @AlEjercicio	int,
     		    @DelPeriodo		int,
     		    @AlPeriodo		int,
		    @FechaD		datetime,
		    @FechaA		datetime,
                    @Nivel		char(20)
--//WITH ENCRYPTION
AS BEGIN
  IF @Rama IN ('CEFE','PEFE','CVALE','CRND','PRND','CNO')
    IF @Nivel = 'DIA'
      INSERT VerAux (Estacion, Ejercicio, Periodo, Fecha, Cargo, Abono)
      SELECT @Estacion, Ejercicio, Periodo, Fecha, Sum(Cargo), Sum(Abono)
        FROM Auxiliar
       WHERE Rama = @Rama
         AND Empresa = @Empresa 
         AND Moneda = @Moneda
         AND Grupo  = CASE @Grupo WHEN NULL THEN Grupo ELSE @Grupo END
         AND Cuenta = @Cuenta 
    	 AND Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
         AND Periodo BETWEEN @DelPeriodo AND @AlPeriodo
         AND Fecha BETWEEN @FechaD AND @FechaA
       GROUP BY Empresa, Ejercicio, Periodo, Fecha
      HAVING Sum(Cargo) <> 0 OR Sum(Abono) <> 0
       ORDER BY Empresa, Ejercicio, Periodo, Fecha
    ELSE
      INSERT VerAux (Estacion, Modulo, Orden, Ejercicio, Periodo, Fecha, ModuloID, Mov, MovID, Aplica, AplicaID, Concepto, Referencia,  Cargo, Abono)
      SELECT @Estacion, a.Modulo, a.ModuloID, a.Ejercicio, a.Periodo, a.Fecha, a.ModuloID, a.Mov, a.MovID, a.Aplica, a.AplicaID, m.Concepto, m.Referencia, Sum(a.Cargo), Sum(a.Abono)
        FROM Auxiliar a, Mov m
       WHERE Rama = @Rama
         AND a.Empresa = @Empresa 
         AND a.Moneda = @Moneda
         AND a.Grupo  = CASE @Grupo WHEN NULL THEN Grupo  ELSE @Grupo END
         AND a.Cuenta = @Cuenta 
  	 AND a.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
         AND a.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
         AND a.Fecha BETWEEN @FechaD AND @FechaA
	 AND m.Empresa = @Empresa 
         AND m.Modulo = a.Modulo
         AND m.ID = a.ModuloID
       GROUP BY a.Empresa, a.Ejercicio, a.Periodo, a.Fecha, a.Modulo, a.ModuloID, a.Mov, a.MovID, a.Aplica, a.AplicaID, m.Concepto, m.Referencia
      HAVING Sum(Cargo) <> 0 OR Sum(Abono) <> 0
       ORDER BY a.Empresa, a.Ejercicio, a.Periodo, a.Fecha, a.Modulo, a.ModuloID, a.Mov, a.MovID, a.Aplica, a.AplicaID, m.Concepto, m.Referencia

    -- Si no es una rama de mayor
    ELSE
    IF @Nivel = 'DIA'
      INSERT VerAux (Estacion, Ejercicio, Periodo, Fecha, Cargo, Abono)
      SELECT @Estacion, Ejercicio, Periodo, Fecha, Sum(Cargo), Sum(Abono)
        FROM Auxiliar, Rama
       WHERE Auxiliar.Rama = Rama.Rama 
         AND Rama.Mayor = @Rama
         AND Empresa = @Empresa 
         AND Moneda = @Moneda
         AND Grupo  = CASE @Grupo  WHEN NULL THEN Grupo  ELSE @Grupo  END
         AND Cuenta = @Cuenta 
         AND Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
         AND Periodo BETWEEN @DelPeriodo AND @AlPeriodo
         AND Fecha BETWEEN @FechaD AND @FechaA
       GROUP BY Ejercicio, Periodo, Fecha
      HAVING Sum(Cargo) <> 0 OR Sum(Abono) <> 0
       ORDER BY Ejercicio, Periodo, Fecha
    ELSE
    IF @Nivel = 'MOVIMIENTO'
      INSERT VerAux (Estacion, Modulo, Orden, Ejercicio, Periodo, Fecha, ModuloID, Mov, MovID, Aplica, AplicaID, Concepto, Referencia,  Cargo, Abono)
      SELECT @Estacion, a.Modulo, MIN(a.ModuloID), a.Ejercicio, a.Periodo, a.Fecha, MIN(a.ModuloID), a.Mov, a.MovID, MIN(a.Aplica), MIN(a.AplicaID), MIN(m.Concepto), MIN(m.Referencia), Sum(a.Cargo), Sum(a.Abono)
        FROM Auxiliar a, Rama r, Mov m
       WHERE a.Rama = r.Rama 
         AND r.Mayor = @Rama
         AND a.Empresa = @Empresa 
         AND a.Moneda = @Moneda
         AND a.Grupo  = CASE @Grupo WHEN NULL THEN Grupo  ELSE @Grupo END
         AND a.Cuenta = @Cuenta 
  	 AND a.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
         AND a.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
         AND a.Fecha BETWEEN @FechaD AND @FechaA
	 AND m.Empresa = @Empresa 
         AND m.Modulo = a.Modulo
         AND m.ID = a.ModuloID
       GROUP BY a.Empresa, a.Ejercicio, a.Periodo, a.Fecha, a.Modulo, a.Mov, a.MovID,a.ModuloID
      HAVING Sum(Cargo) <> 0 OR Sum(Abono) <> 0
       ORDER BY a.Empresa, a.Ejercicio, a.Periodo, a.Fecha, a.Modulo, a.Mov, a.MovID,a.ModuloID
    ELSE
    IF @Nivel = 'APLICACION'
      INSERT VerAux (Estacion, Modulo, Ejercicio, Periodo, Fecha, ModuloID, Mov, MovID, Aplica, AplicaID, Concepto, Referencia,  Cargo, Abono, Saldo)
      SELECT @Estacion, a.Modulo, a.Ejercicio, a.Periodo, a.Fecha, MIN(a.ModuloID), a.Mov, a.MovID, a.Aplica, a.AplicaID, MIN(m.Concepto), MIN(m.Referencia), Sum(a.Cargo), Sum(a.Abono), Sum(ISNULL(a.Cargo,0.0))-Sum(ISNULL(a.Abono,0.0))
        FROM Auxiliar a, Rama r, Mov m
       WHERE a.Rama = r.Rama 
         AND r.Mayor = @Rama
         AND a.Empresa = @Empresa 
         AND a.Moneda = @Moneda
         AND a.Grupo  = CASE @Grupo WHEN NULL THEN Grupo  ELSE @Grupo END
         AND a.Cuenta = @Cuenta 
  	 AND a.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
         AND a.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
         AND a.Fecha BETWEEN @FechaD AND @FechaA
	 AND m.Empresa = @Empresa 
         AND m.Modulo = a.Modulo
         AND m.ID = a.ModuloID
       GROUP BY a.Empresa, a.Modulo, a.Aplica, a.AplicaID, a.Ejercicio, a.Periodo, a.Fecha, a.Mov, a.MovID
      HAVING Sum(Cargo) <> 0 OR Sum(Abono) <> 0
       ORDER BY a.Empresa, a.Modulo, a.Aplica, a.AplicaID, a.Ejercicio, a.Periodo, a.Fecha, a.Mov, a.MovID
END
GO


/**************** spVerAuxR ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAuxR') and type = 'P') drop procedure dbo.spVerAuxR
GO             
CREATE PROCEDURE spVerAuxR
		    @Empresa		char(5),
		    @Estacion		int,
                    @Rama		char(5),
                    @Moneda		char(10),
                    @Grupo		char(10),
		    @Cuenta		char(20),
     		    @DelEjercicio	int,
     		    @AlEjercicio	int,
     		    @DelPeriodo		int,
     		    @AlPeriodo		int,
		    @FechaD		datetime,
		    @FechaA		datetime,
                    @Nivel		char(20)
--//WITH ENCRYPTION
AS BEGIN
  IF @Nivel = 'DIA'
    INSERT VerAux (Estacion, Ejercicio, Periodo, Fecha, Cargo, Abono)
    SELECT @Estacion, Ejercicio, Periodo, Fecha, Sum(Cargo), Sum(Abono)
      FROM Auxiliar
     WHERE Rama = @Rama
       AND Empresa = @Empresa 
       AND Moneda = @Moneda
       AND Grupo  = CASE @Grupo  WHEN NULL THEN Grupo  ELSE @Grupo  END
       AND Cuenta = @Cuenta 
       AND Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND Fecha BETWEEN @FechaD AND @FechaA
     GROUP BY Ejercicio, Periodo, Fecha
    HAVING Sum(Cargo) <> 0 OR Sum(Abono) <> 0
     ORDER BY Ejercicio, Periodo, Fecha
  ELSE
    INSERT VerAux (Estacion, Modulo, Orden, Ejercicio, Periodo, Fecha, ModuloID, Mov, MovID, Aplica, AplicaID, Concepto, Referencia,  Cargo, Abono)
    SELECT @Estacion, a.Modulo, a.ModuloID, a.Ejercicio, a.Periodo, a.Fecha, a.ModuloID, a.Mov, a.MovID, a.Aplica, a.AplicaID, m.Concepto, m.Referencia, Sum(a.Cargo), Sum(a.Abono)
      FROM AuxiliarR a, Mov m
     WHERE a.Rama = @Rama
       AND a.Empresa = @Empresa 
       AND a.Moneda = @Moneda
       AND a.Grupo  = CASE @Grupo WHEN NULL THEN Grupo  ELSE @Grupo END
       AND a.Cuenta = @Cuenta 
       AND a.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND a.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND a.Fecha BETWEEN @FechaD AND @FechaA
       AND m.Empresa = @Empresa 
       AND m.Modulo = a.Modulo
       AND m.ID = a.ModuloID
     GROUP BY a.Empresa, a.Ejercicio, a.Periodo, a.Fecha, a.Modulo, a.ModuloID, a.Mov, a.MovID, a.Aplica, a.AplicaID, m.Concepto, m.Referencia
    HAVING Sum(Cargo) <> 0 OR Sum(Abono) <> 0
     ORDER BY a.Empresa, a.Ejercicio, a.Periodo, a.Fecha, a.Modulo, a.ModuloID, a.Mov, a.MovID, a.Aplica, a.AplicaID, m.Concepto, m.Referencia
END
GO

/**************** spVerAuxU ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAuxU') and type = 'P') drop procedure dbo.spVerAuxU
GO             
CREATE PROCEDURE spVerAuxU
		    @Empresa		char(5),
		    @Estacion		int,
                    @Rama		char(5),
                    @Moneda		char(10),
                    @Grupo		char(10),
		    @Cuenta		char(20),
     		    @DelEjercicio	int,
     		    @AlEjercicio	int,
     		    @DelPeriodo		int,
     		    @AlPeriodo		int,
		    @FechaD		datetime,
		    @FechaA		datetime,
                    @Nivel		char(20)
--//WITH ENCRYPTION
AS BEGIN
  IF @Nivel = 'DIA'
    INSERT VerAux (Estacion, Ejercicio, Periodo, Fecha, Cargo, Abono, CargoU, AbonoU)
    SELECT @Estacion, Ejercicio, Periodo, Fecha, Sum(Cargo), Sum(Abono), Sum(CargoU), Sum(AbonoU)
      FROM AuxiliarU
     WHERE Rama = @Rama
       AND Empresa = @Empresa 
       AND Moneda = @Moneda
       AND Grupo  = CASE @Grupo  WHEN NULL THEN Grupo  ELSE @Grupo  END
       AND Cuenta = CASE @Cuenta WHEN NULL THEN Cuenta ELSE @Cuenta END
       AND Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND Fecha BETWEEN @FechaD AND @FechaA
     GROUP BY Ejercicio, Periodo, Fecha
    HAVING Sum(Cargo) <> 0 OR Sum(Abono) <> 0 OR Sum(CargoU) <> 0 OR Sum(AbonoU) <> 0
     ORDER BY Ejercicio, Periodo, Fecha
  ELSE
    INSERT VerAux (Estacion, Modulo, Orden, Ejercicio, Periodo, Fecha, ModuloID, Mov, MovID, Concepto, Referencia, Cargo, Abono, CargoU, AbonoU)
    SELECT @Estacion, a.Modulo, a.ModuloID, a.Ejercicio, a.Periodo, a.Fecha, a.ModuloID, a.Mov, a.MovID, m.Concepto, m.Referencia, Sum(a.Cargo), Sum(a.Abono), Sum(a.CargoU), Sum(a.AbonoU)
      FROM AuxiliarU a, Mov m
     WHERE a.Rama = @Rama
       AND a.Empresa = @Empresa 
       AND a.Moneda = @Moneda
       AND a.Grupo  = CASE @Grupo WHEN NULL THEN Grupo  ELSE @Grupo END
       AND a.Cuenta = CASE @Cuenta WHEN NULL THEN Cuenta ELSE @Cuenta END
       AND a.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND a.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND a.Fecha BETWEEN @FechaD AND @FechaA
       AND m.Empresa = @Empresa 
       AND m.Modulo = a.Modulo
       AND m.ID = a.ModuloID
     GROUP BY a.Empresa, a.Ejercicio, a.Periodo, a.Fecha, a.Modulo, a.ModuloID, a.Mov, a.MovID, m.Concepto, m.Referencia
    HAVING Sum(Cargo) <> 0 OR Sum(Abono) <> 0 OR Sum(CargoU) <> 0 OR Sum(AbonoU) <> 0
     ORDER BY a.Empresa, a.Ejercicio, a.Periodo, a.Fecha, a.Modulo, a.ModuloID, a.Mov, a.MovID, m.Concepto, m.Referencia
END
GO

/**************** spVerAuxRU ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAuxRU') and type = 'P') drop procedure dbo.spVerAuxRU
GO             
CREATE PROCEDURE spVerAuxRU
		    @Empresa		char(5),
		    @Estacion		int,
                    @Rama		char(5),
                    @Moneda		char(10),
                    @Grupo		char(10),
		    @Cuenta		char(20),
     		    @DelEjercicio	int,
     		    @AlEjercicio	int,
     		    @DelPeriodo		int,
     		    @AlPeriodo		int,
		    @FechaD		datetime,
		    @FechaA		datetime,
                    @Nivel		char(20)
--//WITH ENCRYPTION
AS BEGIN
  IF @Nivel = 'DIA'
    INSERT VerAux (Estacion, Ejercicio, Periodo, Fecha, Cargo, Abono, CargoU, AbonoU)
    SELECT @Estacion, Ejercicio, Periodo, Fecha, Sum(Cargo), Sum(Abono), Sum(CargoU), Sum(AbonoU)
      FROM AuxiliarRU
     WHERE Rama = @Rama
       AND Empresa = @Empresa 
       AND Moneda = @Moneda
       AND Grupo  = CASE @Grupo  WHEN NULL THEN Grupo  ELSE @Grupo  END
       AND Cuenta = CASE @Cuenta WHEN NULL THEN Cuenta ELSE @Cuenta END
       AND Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND Fecha BETWEEN @FechaD AND @FechaA
     GROUP BY Ejercicio, Periodo, Fecha 
    HAVING Sum(Cargo) <> 0 OR Sum(Abono) <> 0 OR Sum(CargoU) <> 0 OR Sum(AbonoU) <> 0
     ORDER BY Ejercicio, Periodo, Fecha 
  ELSE
    INSERT VerAux (Estacion, Modulo, Orden, Ejercicio, Periodo, Fecha, ModuloID, Mov, MovID, Aplica, AplicaID, Concepto, Referencia, Cargo, Abono, CargoU, AbonoU)
    SELECT @Estacion, a.Modulo, a.ModuloID, a.Ejercicio, a.Periodo, a.Fecha, a.ModuloID, a.Mov, a.MovID, a.Aplica, a.AplicaID, m.Concepto, m.Referencia, Sum(a.Cargo), Sum(a.Abono), Sum(a.CargoU), Sum(a.AbonoU)
      FROM AuxiliarRU a, Mov m
     WHERE a.Rama = @Rama
       AND a.Empresa = @Empresa 
       AND a.Moneda = @Moneda
       AND a.Grupo  = CASE @Grupo WHEN NULL THEN Grupo  ELSE @Grupo END
       AND a.Cuenta = CASE @Cuenta WHEN NULL THEN Cuenta ELSE @Cuenta END
       AND a.Ejercicio BETWEEN @DelEjercicio AND @AlEjercicio
       AND a.Periodo BETWEEN @DelPeriodo AND @AlPeriodo
       AND a.Fecha BETWEEN @FechaD AND @FechaA
       AND m.Empresa = @Empresa 
       AND m.Modulo = a.Modulo
       AND m.ID = a.ModuloID
     GROUP BY a.Empresa, a.Ejercicio, a.Periodo, a.Fecha, a.Modulo, a.ModuloID, a.Mov, a.MovID, a.Aplica, a.AplicaID, m.Concepto, m.Referencia
    HAVING Sum(Cargo) <> 0 OR Sum(Abono) <> 0 OR Sum(CargoU) <> 0 OR Sum(AbonoU) <> 0
     ORDER BY a.Empresa, a.Ejercicio, a.Periodo, a.Fecha, a.Modulo, a.ModuloID, a.Mov, a.MovID, a.Aplica, a.AplicaID, m.Concepto, m.Referencia
END
GO

/**************** spVerAuxiliar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAuxiliar') and type = 'P') drop procedure dbo.spVerAuxiliar
GO             
CREATE PROCEDURE spVerAuxiliar
		    @Empresa		char(5),
		    @Estacion		int,
		    @Rama		char(5),
                    @Moneda		char(10),
		    @GrupoBase		char(10)  = NULL,
		    @CuentaBase		char(20)  = NULL,
		    @FechaD		datetime  = NULL,
		    @FechaA		datetime  = NULL,
                    @Nivel		char(20)  = 'DIA',      -- Movimiento, Dia, DiaSemana, Semana, Aplicacion
                    @Vista		char(20)  = 'NORMAL',   -- Normal, Detalles
        	    @VerGrupo		bit	  = 0,		-- Grupo, Cuenta
        	    @Totalizar		bit	  = 0
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
     @EsMonetario	bit,
     @EsUnidades	bit,
     @EsResultados	bit,
     @DelEjercicio 	int,
     @AlEjercicio 	int,
     @DelPeriodo   	int, 
     @AlPeriodo   	int,
     @CargoInicial 	money,
     @Cargos		money,
     @AbonoInicial 	money, 
     @Abonos		money,
     @Saldo		money,
     @Total		money,
     @CargoInicialU 	float, 
     @CargosU		float,
     @AbonoInicialU	float,
     @AbonosU		float,
     @TotalU		float,

     @Ok		int

  -- Inicializar Parametros
  SELECT @Nivel = UPPER(@Nivel), @Vista = UPPER(@Vista), @VerGrupo = ISNULL(@VerGrupo, 0),
         @CuentaBase = NULLIF(RTRIM(@CuentaBase), ''), @GrupoBase = NULLIF(RTRIM(@GrupoBase), ''), 
         @FechaA = DATEADD(millisecond, -2, DATEADD(day, 1, @FechaA))

  SELECT @EsMonetario  = EsMonetario,
	 @EsUnidades   = EsUnidades,
	 @EsResultados = EsResultados
    FROM Rama 
   WHERE Rama = @Rama


  DELETE VerAux WHERE Estacion = @Estacion
  SELECT @CargoInicial  = 0, @AbonoInicial  = 0.0,
         @CargoInicialU = 0, @AbonoInicialU = 0

  EXEC spPeriodoEjercicio @Empresa, @Rama, @FechaD, @DelPeriodo OUTPUT, @DelEjercicio OUTPUT, @Ok OUTPUT
  EXEC spPeriodoEjercicio @Empresa, @Rama, @FechaA, @AlPeriodo  OUTPUT, @AlEjercicio  OUTPUT, @Ok OUTPUT

  IF @DelEjercicio <> @AlEjercicio SELECT @DelPeriodo = 0, @AlPeriodo = 9999

  EXEC spSaldoInicial  @Empresa, @Rama, @Moneda, @GrupoBase, @CuentaBase, NULL, @FechaD, @EsMonetario, @EsUnidades, @EsResultados, 
                       @CargoInicial OUTPUT, @AbonoInicial OUTPUT, @CargoInicialU OUTPUT, @AbonoInicialU OUTPUT, @Ok OUTPUT

  IF @CargoInicial <> 0 OR @AbonoInicial <> 0 --OR @CargoInicialU<>0
    INSERT VerAux (Estacion, Fecha, Mov, Cargo, Abono, Saldo, CargoU, AbonoU) 
           VALUES (@Estacion, DATEADD(day, -1, @FechaD), 'Saldo Inicial', @CargoInicial, @AbonoInicial, (@CargoInicial-@AbonoInicial), @CargoInicialU, @AbonoInicialU)

  IF @Rama = 'CONT'
    EXEC spVerAuxCont @Empresa, @Estacion, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel, @Moneda

  ELSE
  IF @Rama = 'CC'
    EXEC spVerAuxCC @Empresa, @Estacion, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel

  IF @Rama = 'CC2'
    EXEC spVerAuxCC2 @Empresa, @Estacion, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel

  IF @Rama = 'CC3'
    EXEC spVerAuxCC3 @Empresa, @Estacion, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel
 
  IF @EsUnidades = 0 AND @EsResultados = 0
    EXEC spVerAux @Empresa, @Estacion, @Rama, @Moneda, @GrupoBase, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel
 
  ELSE
  IF @EsUnidades = 0 AND @EsResultados = 1 
    EXEC spVerAuxR @Empresa, @Estacion, @Rama, @Moneda, @GrupoBase, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel

  ELSE
  IF @EsUnidades = 1 AND @EsResultados = 0
    EXEC spVerAuxU @Empresa, @Estacion, @Rama, @Moneda, @GrupoBase, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel

  ELSE
  IF @EsUnidades = 1 AND @EsResultados = 1
    EXEC spVerAuxRU @Empresa, @Estacion, @Rama, @Moneda, @GrupoBase, @CuentaBase, @DelEjercicio, @AlEjercicio, @DelPeriodo, @AlPeriodo, @FechaD, @FechaA, @Nivel

  IF @Nivel = 'APLICACION'
  BEGIN
    IF @Rama IN ('CXC','CXP') 
    BEGIN
      IF @Rama = 'CXC' 
        UPDATE VerAux 
           SET VerAux.Saldo = CASE 
                                WHEN VerAux.Abono IS NOT NULL THEN -Cxc.Saldo 
                                ELSE Cxc.Saldo
                              END
          FROM VerAux, Cxc 
         WHERE Cxc.ID = VerAux.ModuloID 
           AND Cxc.Estatus = 'PENDIENTE' 
           AND VerAux.Mov = VerAux.Aplica 
           AND VerAux.MovID = VerAux.AplicaID 
      ELSE
      IF @Rama = 'CXP' 
        UPDATE VerAux 
           SET VerAux.Saldo = CASE 
                                WHEN VerAux.Abono IS NOT NULL THEN -Cxp.Saldo 
                                ELSE Cxp.Saldo
                              END
          FROM VerAux, Cxp
         WHERE Cxp.ID = VerAux.ModuloID 
           AND Cxp.Estatus = 'PENDIENTE' 
           AND VerAux.Mov = VerAux.Aplica 
           AND VerAux.MovID = VerAux.AplicaID 

      SELECT @Cargos  = SUM(Cargo),
             @Abonos  = SUM(Abono),
             @Saldo   = SUM(Saldo),
             @CargosU = SUM(CargoU),
             @AbonosU = SUM(AbonoU)
        FROM VerAux
       WHERE Estacion = @Estacion 
    END
    SELECT ID,
   	   Fecha,
   	   Orden,
   	   Estacion,
   	   Grupo,
   	   SubCuenta,
	   Ejercicio,
	   Periodo,
	   Modulo,
	   ModuloID,
	   Mov,
	   MovID,
	   Aplica,
	   AplicaID,
	   Concepto,
	   Referencia,
	   Cargo,
	   Abono,
	   Saldo,
	   Total,
	   CargoU,
	   AbonoU,
	   TotalU
      FROM VerAux WHERE Estacion = @Estacion
    UNION
    SELECT "ID"		= NULL,
   	   "Fecha"	= @FechaA,
           "Orden"      = 2147483647,
   	   "Estacion"	= @Estacion,
   	   "Grupo"	= NULL,
   	   "SubCuenta"	= NULL,
   	   "Ejercicio"	= NULL,
   	   "Periodo"	= 999,
           "Modulo"	= NULL,
   	   "ModuloID"	= NULL,
   	   "Mov"	= NULL,
   	   "MovID"	= NULL,
   	   "Aplica"	= 'zz',
   	   "AplicaID"	= NULL,
   	   "Concepto"	= NULL,
   	   "Referencia"	= NULL,
   	   "Cargo"	= ISNULL(@Cargos, 0.0),
   	   "Abono"	= ISNULL(@Abonos, 0.0),
   	   "Saldo"	= ISNULL(@Cargos, 0.0) - ISNULL(@Abonos, 0.0),
   	   "Total"	= NULL,
   	   "CargoU"	= NULL,
   	   "AbonoU"	= NULL,
   	   "TotalU"	= NULL
     ORDER BY Estacion, Aplica, AplicaID, Fecha, ModuloID
  END ELSE 
  BEGIN
    SELECT @Total  = 0.0, @Cargos  = 0.0, @Abonos  = 0.0,
           @TotalU = 0,   @CargosU = 0.0, @AbonosU = 0.0

    UPDATE VerAux
       SET @Cargos  = @Cargos  + ISNULL(Cargo, 0.0),
           @Abonos  = @Abonos  + ISNULL(Abono, 0.0),
           @Total   = Total    = @Total  + ISNULL(Cargo, 0.0) - ISNULL(Abono, 0.0), 
	   @CargosU = @CargosU + ISNULL(CargoU, 0.0),
           @AbonosU = @AbonosU + ISNULL(AbonoU, 0.0),
           @TotalU  = TotalU   = @TotalU + ISNULL(CargoU, 0.0) - ISNULL(AbonoU, 0.0) 
     WHERE Estacion = @Estacion

    INSERT VerAux (Estacion, Orden, Periodo, Fecha, Cargo, Abono, Total, CargoU, AbonoU, TotalU) VALUES (@Estacion, 2147483647, 999, @FechaA, @Cargos, @Abonos, @Total, @CargosU, @AbonosU, @TotalU)

    SELECT * FROM VerAux WHERE Estacion = @Estacion ORDER BY Estacion, Fecha, Orden, ID 
  END
  RETURN
END
GO
-- spVerAuxiliar 'DEMO', 10,'CONT', 'Pesos','', '120-00-000', '09/01/2001','09/30/2001','Movimiento', 'Normal', 0, 1
