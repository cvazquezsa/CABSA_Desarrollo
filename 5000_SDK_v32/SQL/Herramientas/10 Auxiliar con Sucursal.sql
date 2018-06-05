/**************** spReconstruirAuxiliar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReconstruirAuxiliar') and type = 'P') drop procedure dbo.spReconstruirAuxiliar
GO             
CREATE PROCEDURE spReconstruirAuxiliar 
			@Rama 		char(5),
			@GeneraSaldo	bit,
			@Conciliar	bit,
		        @Fecha		datetime

--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Sucursal		int,
    @Empresa		char(5), 
    @Moneda		char(10), 
    @Cuenta		char(20), 
    @SubCuenta		varchar(20), 
    @Grupo		char(10), 
    @Ejercicio		int, 
    @Periodo		int, 
    @Cargo		money, 
    @Abono		money,
    @Conciliado		bit,
    @ImporteConciliar	money

  BEGIN TRANSACTION
  DELETE Saldo WHERE Rama = @Rama
  DELETE Acum WHERE Rama = @Rama

  DECLARE crAuxiliar CURSOR FOR
   SELECT Sucursal, Empresa, Moneda, Cuenta, SubCuenta, Grupo, Ejercicio, Periodo, ISNULL(Cargo, 0.0), ISNULL(Abono, 0.0), Conciliado
     FROM Auxiliar
    WHERE Rama = @Rama

  OPEN crAuxiliar
  FETCH NEXT FROM crAuxiliar INTO @Sucursal, @Empresa, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo, @Abono, @Conciliado
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @GeneraSaldo = 1 
      BEGIN
        IF @Conciliar = 1 AND @Conciliado = 0
          SELECT @ImporteConciliar = @Cargo - @Abono 
        ELSE SELECT @ImporteConciliar = 0.0

        UPDATE Saldo
           SET Saldo        = ISNULL(Saldo, 0.0) + @Cargo - @Abono,
               PorConciliar = ISNULL(PorConciliar, 0.0) + @ImporteConciliar
         WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND SubCuenta = @SubCuenta

        IF @@ROWCOUNT = 0
          INSERT Saldo (Sucursal, Empresa, Rama, Moneda, Grupo, Cuenta, SubCuenta, Saldo, PorConciliar, UltimoCambio)
                VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, (@Cargo-@Abono), @ImporteConciliar, @Fecha)
      END

      UPDATE Acum
         SET Cargos = ISNULL(Cargos, 0.0) + @Cargo,
             Abonos = ISNULL(Abonos, 0.0) + @Abono,
             UltimoCambio = @Fecha
       WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta 
         AND SubCuenta = @SubCuenta AND Periodo = @Periodo AND Ejercicio = @Ejercicio

      IF @@ROWCOUNT = 0
        INSERT Acum (Sucursal, Empresa,  Rama,  Moneda,  Cuenta,  SubCuenta,  Grupo,  Ejercicio,  Periodo,  Cargos,  Abonos, UltimoCambio)
             VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo,  @Abono, @Fecha)
    END
    FETCH NEXT FROM crAuxiliar INTO @Sucursal, @Empresa, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo, @Abono, @Conciliado
  END
  CLOSE crAuxiliar
  DEALLOCATE crAuxiliar

  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spReconstruirAuxiliarR ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReconstruirAuxiliarR') and type = 'P') drop procedure dbo.spReconstruirAuxiliarR
GO             
CREATE PROCEDURE spReconstruirAuxiliarR 
			@Rama 		char(5),
			@GeneraSaldo	bit,
			@Conciliar	bit,
		        @Fecha		datetime

--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Sucursal		int,
    @Empresa		char(5), 
    @Moneda		char(10), 
    @Cuenta		char(20), 
    @SubCuenta		varchar(20), 
    @Grupo		char(10), 
    @Ejercicio		int, 
    @Periodo		int, 
    @Cargo		money, 
    @Abono		money,
    @Conciliado		bit,
    @ImporteConciliar	money

  BEGIN TRANSACTION
  DELETE SaldoR WHERE Rama = @Rama
  DELETE AcumR WHERE Rama = @Rama

  DECLARE crAuxiliarR CURSOR FOR
   SELECT Sucursal, Empresa, Moneda, Cuenta, SubCuenta, Grupo, Ejercicio, Periodo, ISNULL(Cargo, 0.0), ISNULL(Abono, 0.0), Conciliado
     FROM AuxiliarR
    WHERE Rama = @Rama

  OPEN crAuxiliarR
  FETCH NEXT FROM crAuxiliarR INTO @Sucursal, @Empresa, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo, @Abono, @Conciliado
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @GeneraSaldo = 1 
      BEGIN
        IF @Conciliar = 1 AND @Conciliado = 0
          SELECT @ImporteConciliar = @Cargo - @Abono 
        ELSE SELECT @ImporteConciliar = 0.0

        UPDATE SaldoR
           SET Saldo        = ISNULL(Saldo, 0.0) + @Cargo - @Abono,
               PorConciliar = ISNULL(PorConciliar, 0.0) + @ImporteConciliar
         WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND SubCuenta = @SubCuenta

        IF @@ROWCOUNT = 0
          INSERT SaldoR (Sucursal, Empresa, Rama, Moneda, Grupo, Cuenta, SubCuenta, Saldo, PorConciliar, UltimoCambio)
                 VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, (@Cargo-@Abono), @ImporteConciliar, @Fecha)
      END

      UPDATE AcumR
         SET Cargos = ISNULL(Cargos, 0.0) + @Cargo,
             Abonos = ISNULL(Abonos, 0.0) + @Abono,
             UltimoCambio = @Fecha
       WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta 
         AND SubCuenta = @SubCuenta AND Periodo = @Periodo AND Ejercicio = @Ejercicio

      IF @@ROWCOUNT = 0
        INSERT AcumR (Sucursal, Empresa,  Rama,  Moneda,  Cuenta,  SubCuenta,  Grupo,  Ejercicio,  Periodo,  Cargos,  Abonos, UltimoCambio)
              VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo,  @Abono, @Fecha)
    END
    FETCH NEXT FROM crAuxiliarR INTO @Sucursal, @Empresa, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo, @Abono, @Conciliado
  END
  CLOSE crAuxiliarR
  DEALLOCATE crAuxiliarR

  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spReconstruirAuxiliarU ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReconstruirAuxiliarU') and type = 'P') drop procedure dbo.spReconstruirAuxiliarU
GO             
CREATE PROCEDURE spReconstruirAuxiliarU 
			@Rama 		char(5),
			@GeneraSaldo	bit,
			@Conciliar	bit,
		        @Fecha		datetime

--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Sucursal		int,
    @Empresa		char(5), 
    @Moneda		char(10), 
    @Cuenta		char(20), 
    @SubCuenta		varchar(20), 
    @Grupo		char(10), 
    @SubGrupo	varchar(10),  --BUG8803
    @Ejercicio		int, 
    @Periodo		int, 
    @Cargo		money, 
    @Abono		money,
    @CargoU		float, 
    @AbonoU		float,
    @Conciliado		bit,
    @ImporteConciliar	money,
    @CantidadConciliar	float,

	@WMSAuxiliar	bit -- TASK1964

  SELECT @WMSAuxiliar = WMSAuxiliar FROM Version -- TASK1964

  BEGIN TRANSACTION
  DELETE SaldoU WHERE Rama = @Rama
  DELETE AcumU WHERE Rama = @Rama

  DECLARE crAuxiliarU CURSOR FOR
  SELECT Sucursal, Empresa, Moneda, Cuenta, SubCuenta, Grupo, Ejercicio, Periodo, ISNULL(Cargo, 0.0), ISNULL(Abono, 0.0), ISNULL(CargoU, 0.0), ISNULL(AbonoU, 0.0), Conciliado, SubGrupo --BUG8803
     FROM AuxiliarUGral
    WHERE Rama = @Rama

  OPEN crAuxiliarU
  FETCH NEXT FROM crAuxiliarU INTO @Sucursal, @Empresa, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo, @Abono, @CargoU, @AbonoU, @Conciliado, @SubGrupo --BUG8803
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @GeneraSaldo = 1 
      BEGIN
        IF @Conciliar = 1 AND @Conciliado = 0
          SELECT @ImporteConciliar = @Cargo - @Abono, @CantidadConciliar = @CargoU - @AbonoU
        ELSE SELECT @ImporteConciliar = 0.0, @CantidadConciliar = 0.0

        IF @WMSAuxiliar = 1 -- TASK1964
        BEGIN
          IF @SubGrupo <> '' -- TASK1964
          BEGIN
		     UPDATE SaldoUWMS
			    SET Saldo         = ISNULL(Saldo, 0.0) + @Cargo - @Abono,
				    SaldoU        = ISNULL(SaldoU, 0.0) + @CargoU - @AbonoU,
				    PorConciliar  = ISNULL(PorConciliar, 0.0) + @ImporteConciliar,
				    PorConciliarU = ISNULL(PorConciliarU, 0.0) + @CantidadConciliar,
					UltimoCambio  = @Fecha
			  WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND SubCuenta = @SubCuenta AND SubGrupo = @SubGrupo --BUG8803

		    IF @@ROWCOUNT = 0
			  INSERT SaldoUWMS (Sucursal, Empresa, Rama, Moneda, Grupo, Cuenta, SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio, SubGrupo) --BUG8803
			            VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, (@Cargo-@Abono), (@CargoU-@AbonoU), @ImporteConciliar, @CantidadConciliar, @Fecha, @SubGrupo) --BUG8803
		  END ELSE BEGIN -- TASK1964
             UPDATE SaldoU
			    SET Saldo         = ISNULL(Saldo, 0.0) + @Cargo - @Abono,
				    SaldoU        = ISNULL(SaldoU, 0.0) + @CargoU - @AbonoU,
				    PorConciliar  = ISNULL(PorConciliar, 0.0) + @ImporteConciliar,
				    PorConciliarU = ISNULL(PorConciliarU, 0.0) + @CantidadConciliar,
					UltimoCambio  = @Fecha
			  WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND SubCuenta = @SubCuenta AND SubGrupo = @SubGrupo --BUG8803

		    IF @@ROWCOUNT = 0
			  INSERT SaldoU (Sucursal, Empresa, Rama, Moneda, Grupo, Cuenta, SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio, SubGrupo) --BUG8803
			         VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, (@Cargo-@Abono), (@CargoU-@AbonoU), @ImporteConciliar, @CantidadConciliar, @Fecha, @SubGrupo) --BUG8803
		  END
		END ELSE BEGIN -- TASK1964
          EXEC dbo.sp_executesql N' 
            UPDATE SaldoU
			   SET Saldo         = ISNULL(Saldo, 0.0) + @Cargo - @Abono,
                   SaldoU        = ISNULL(SaldoU, 0.0) + @CargoU - @AbonoU,
                   PorConciliar  = ISNULL(PorConciliar, 0.0) + @ImporteConciliar,
                   PorConciliarU = ISNULL(PorConciliarU, 0.0) + @CantidadConciliar,
                   UltimoCambio  = @Fecha
			 WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND SubCuenta = @SubCuenta AND SubGrupo = @SubGrupo

		    IF @@ROWCOUNT = 0
			  INSERT SaldoU (Sucursal, Empresa, Rama, Moneda, Grupo, Cuenta, SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio, SubGrupo) --BUG8803
			         VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, (@Cargo-@Abono), (@CargoU-@AbonoU), @ImporteConciliar, @CantidadConciliar, @Fecha, @SubGrupo)', --BUG8803
            N'@Sucursal int, @Empresa varchar(5), @Rama varchar(50), @Moneda varchar(50), @Grupo varchar(50), @SubGrupo varchar(50), @Cuenta varchar(50), 
			  @SubCuenta varchar(50), @Cargo money, @Abono money, @CargoU float, @AbonoU float, @ImporteConciliar money, @CantidadConciliar float, @Fecha datetime',
		    @Sucursal, @Empresa, @Rama, @Moneda, @Grupo, @SubGrupo, @Cuenta, @SubCuenta, @Cargo, @Abono, @CargoU, @AbonoU, @ImporteConciliar, @CantidadConciliar, @Fecha
		END -- TASK1964
      END

      IF @WMSAuxiliar = 1 -- TASK1964
      BEGIN
        IF @SubGrupo <> '' -- TASK1964
        BEGIN
          UPDATE AcumUWMS
             SET Cargos  = ISNULL(Cargos, 0.0) + @Cargo,
                 Abonos  = ISNULL(Abonos, 0.0) + @Abono,
		         CargosU = ISNULL(CargosU, 0.0) + @CargoU,
                 AbonosU = ISNULL(AbonosU, 0.0) + @AbonoU,
                 UltimoCambio = @Fecha
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta 
             AND SubCuenta = @SubCuenta AND Periodo = @Periodo AND Ejercicio = @Ejercicio AND SubGrupo = @SubGrupo --BUG8803

          IF @@ROWCOUNT = 0
            INSERT AcumUWMS (Sucursal, Empresa,  Rama,  Moneda,  Cuenta,  SubCuenta,  Grupo,  Ejercicio,  Periodo,  Cargos,  Abonos, CargosU,  AbonosU, UltimoCambio, SubGrupo) --BUG8803
                  VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo,  @Abono, @CargoU,  @AbonoU, @Fecha, @SubGrupo) --BUG8803
        END ELSE BEGIN -- TASK1964
          UPDATE AcumU
             SET Cargos  = ISNULL(Cargos, 0.0) + @Cargo,
                 Abonos  = ISNULL(Abonos, 0.0) + @Abono,
		         CargosU = ISNULL(CargosU, 0.0) + @CargoU,
                 AbonosU = ISNULL(AbonosU, 0.0) + @AbonoU,
                 UltimoCambio = @Fecha
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta 
             AND SubCuenta = @SubCuenta AND Periodo = @Periodo AND Ejercicio = @Ejercicio AND SubGrupo = @SubGrupo --BUG8803

          IF @@ROWCOUNT = 0
            INSERT AcumU (Sucursal, Empresa,  Rama,  Moneda,  Cuenta,  SubCuenta,  Grupo,  Ejercicio,  Periodo,  Cargos,  Abonos, CargosU,  AbonosU, UltimoCambio, SubGrupo) --BUG8803
                  VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo,  @Abono, @CargoU,  @AbonoU, @Fecha, @SubGrupo) --BUG8803
        END
      END ELSE BEGIN -- TASK1964
		EXEC dbo.sp_executesql N'
          UPDATE AcumU
             SET Cargos  = ISNULL(Cargos, 0.0) + @Cargo,
                 Abonos  = ISNULL(Abonos, 0.0) + @Abono,
		         CargosU = ISNULL(CargosU, 0.0) + @CargoU,
                 AbonosU = ISNULL(AbonosU, 0.0) + @AbonoU,
                 UltimoCambio = @Fecha
           WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta 
             AND SubCuenta = @SubCuenta AND Periodo = @Periodo AND Ejercicio = @Ejercicio AND SubGrupo = @SubGrupo

          IF @@ROWCOUNT = 0
            INSERT AcumU (Sucursal, Empresa,  Rama,  Moneda,  Cuenta,  SubCuenta,  Grupo,  Ejercicio,  Periodo,  Cargos,  Abonos, CargosU,  AbonosU, UltimoCambio, SubGrupo)
                  VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo,  @Abono, @CargoU,  @AbonoU, @Fecha, @SubGrupo)', --BUG8803
            N'@Sucursal int, @Empresa varchar(5), @Rama varchar(5), @Moneda varchar(20), @Cuenta varchar(20), @SubCuenta varchar(50), @Grupo varchar(10), @Ejercicio int, 
		      @Periodo int, @Cargo money, @Abono money, @CargoU float, @AbonoU float, @Fecha datetime, @SubGrupo varchar(20)',
		  @Sucursal, @Empresa, @Rama, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo, @Abono, @CargoU, @AbonoU, @Fecha, @SubGrupo
      END -- TASK1964
    END
    FETCH NEXT FROM crAuxiliarU INTO @Sucursal, @Empresa, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo, @Abono, @CargoU, @AbonoU, @Conciliado, @SubGrupo --BUG8803
  END
  CLOSE crAuxiliarU
  DEALLOCATE crAuxiliarU

  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spReconstruirAuxiliarRU ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReconstruirAuxiliarRU') and type = 'P') drop procedure dbo.spReconstruirAuxiliarRU
GO             
CREATE PROCEDURE spReconstruirAuxiliarRU 
			@Rama 		char(5),
			@GeneraSaldo	bit,
			@Conciliar	bit,
		        @Fecha		datetime

--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Sucursal		int,
    @Empresa		char(5), 
    @Moneda		char(10), 
    @Cuenta		char(20), 
    @SubCuenta		varchar(20), 
    @Grupo		char(10), 
    @Ejercicio		int, 
    @Periodo		int, 
    @Cargo		money, 
    @Abono		money,
    @CargoU		float, 
    @AbonoU		float,
    @Conciliado		bit,
    @ImporteConciliar	money,
    @CantidadConciliar	float

  BEGIN TRANSACTION
  DELETE SaldoRU WHERE Rama = @Rama
  DELETE AcumRU WHERE Rama = @Rama

  DECLARE crAuxiliarRU CURSOR FOR
   SELECT Sucursal, Empresa, Moneda, Cuenta, SubCuenta, Grupo, Ejercicio, Periodo, ISNULL(Cargo, 0.0), ISNULL(Abono, 0.0), ISNULL(CargoU, 0.0), ISNULL(AbonoU, 0.0), Conciliado
     FROM AuxiliarRU
    WHERE Rama = @Rama

  OPEN crAuxiliarRU
  FETCH NEXT FROM crAuxiliarRU INTO @Sucursal, @Empresa, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo, @Abono, @CargoU, @AbonoU, @Conciliado
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @GeneraSaldo = 1 
      BEGIN
        IF @Conciliar = 1 AND @Conciliado = 0
          SELECT @ImporteConciliar = @Cargo - @Abono, @CantidadConciliar = @CargoU - @AbonoU
        ELSE SELECT @ImporteConciliar = 0.0, @CantidadConciliar = 0.0

        UPDATE SaldoRU
           SET Saldo         = ISNULL(Saldo, 0.0) + @Cargo - @Abono,
               SaldoU        = ISNULL(SaldoU, 0.0) + @CargoU - @AbonoU,
               PorConciliar  = ISNULL(PorConciliar, 0.0) + @ImporteConciliar,
               PorConciliarU = ISNULL(PorConciliarU, 0.0) + @CantidadConciliar
         WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta AND SubCuenta = @SubCuenta

        IF @@ROWCOUNT = 0
          INSERT SaldoRU (Sucursal, Empresa, Rama, Moneda, Grupo, Cuenta, SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio)
                 VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, (@Cargo-@Abono), (@CargoU-@AbonoU), @ImporteConciliar, @CantidadConciliar, @Fecha)
      END

      UPDATE AcumRU
         SET Cargos  = ISNULL(Cargos, 0.0) + @Cargo,
             Abonos  = ISNULL(Abonos, 0.0) + @Abono,
	     CargosU = ISNULL(CargosU, 0.0) + @CargoU,
             AbonosU = ISNULL(AbonosU, 0.0) + @AbonoU,
             UltimoCambio = @Fecha
       WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Grupo = @Grupo AND Cuenta = @Cuenta 
         AND SubCuenta = @SubCuenta AND Periodo = @Periodo AND Ejercicio = @Ejercicio

      IF @@ROWCOUNT = 0
        INSERT AcumRU (Sucursal, Empresa,  Rama,  Moneda,  Cuenta,  SubCuenta,  Grupo,  Ejercicio,  Periodo,  Cargos,  Abonos, CargosU,  AbonosU, UltimoCambio)
              VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo,  @Abono, @CargoU,  @AbonoU, @Fecha)
    END
    FETCH NEXT FROM crAuxiliarRU INTO @Sucursal, @Empresa, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo, @Abono, @CargoU, @AbonoU, @Conciliado
  END
  CLOSE crAuxiliarRU
  DEALLOCATE crAuxiliarRU

  COMMIT TRANSACTION
  RETURN
END
GO



/* spDepurarAuxiliar */
if exists (select * from sysobjects where id = object_id('dbo.spDepurarAuxiliar') and type = 'P') drop procedure dbo.spDepurarAuxiliar
GO
CREATE PROCEDURE spDepurarAuxiliar
			@Fecha	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MesAnterior	int,
    @AnoAnterior	int,
    @FechaAnterior	datetime

  SELECT @FechaAnterior = DATEADD(day, -1, @Fecha)
  SELECT @AnoAnterior = DATEPART(year, @FechaAnterior)
  SELECT @MesAnterior = DATEPART(month, @FechaAnterior)

  BEGIN TRANSACTION
    ALTER TABLE Auxiliar DISABLE TRIGGER ALL

    SELECT Sucursal, Empresa, m.Rama, Moneda, Grupo, Cuenta, SubCuenta, "Cargo" = CONVERT(money, SUM(Cargo)), "Abono" = CONVERT(money, SUM(Abono)) 
      INTO #sAuxiliar
      FROM Auxiliar m, DepurarMov t, Rama r
     WHERE t.Modulo = m.Modulo AND t.ID = m.ModuloID AND r.Rama = m.Rama AND (r.Conciliar = 0 OR m.Conciliado = 1)
     GROUP BY Sucursal, Empresa, m.Rama, Moneda, Grupo, Cuenta, SubCuenta

    DELETE Auxiliar 
     FROM Auxiliar m, DepurarMov t, Rama r
    WHERE t.Modulo = m.Modulo AND t.ID = m.ModuloID AND r.Rama = m.Rama AND (r.Conciliar = 0 OR m.Conciliado = 1)

    INSERT Auxiliar (Sucursal, Empresa, Rama, Mov, MovID, Moneda, TipoCambio, Grupo, Cuenta, SubCuenta, Ejercicio, Periodo, Fecha, Cargo, Abono, Acumulado, Conciliado)
    SELECT Sucursal, Empresa, m.Rama, 'Historico', '', m.Moneda, mon.TipoCambio, Grupo, Cuenta, SubCuenta, @AnoAnterior, @MesAnterior, @FechaAnterior, Cargo, Abono, 1, r.Conciliar
      FROM #sAuxiliar m, Mon, Rama r
     WHERE Mon.Moneda = m.Moneda AND r.Rama = m.Rama 

    ALTER TABLE Auxiliar  ENABLE TRIGGER ALL
  COMMIT TRANSACTION
END
go

/* spDepurarAuxiliarR */
if exists (select * from sysobjects where id = object_id('dbo.spDepurarAuxiliarR') and type = 'P') drop procedure dbo.spDepurarAuxiliarR
GO
CREATE PROCEDURE spDepurarAuxiliarR
			@Fecha	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MesAnterior	int,
    @AnoAnterior	int,
    @FechaAnterior	datetime

  SELECT @FechaAnterior = DATEADD(day, -1, @Fecha)
  SELECT @AnoAnterior = DATEPART(year, @FechaAnterior)
  SELECT @MesAnterior = DATEPART(month, @FechaAnterior)

  BEGIN TRANSACTION
    ALTER TABLE AuxiliarR DISABLE TRIGGER ALL

    SELECT Sucursal, Empresa, m.Rama, Moneda, Grupo, Cuenta, SubCuenta, "Cargo" = CONVERT(money, SUM(Cargo)), "Abono" = CONVERT(money, SUM(Abono)) 
      INTO #sAuxiliarR
      FROM AuxiliarR m, DepurarMov t, Rama r
     WHERE t.Modulo = m.Modulo AND t.ID = m.ModuloID AND r.Rama = m.Rama AND (r.Conciliar = 0 OR m.Conciliado = 1)
     GROUP BY Sucursal, Empresa, m.Rama, Moneda, Grupo, Cuenta, SubCuenta

    DELETE AuxiliarR 
     FROM AuxiliarR m, DepurarMov t, Rama r
    WHERE t.Modulo = m.Modulo AND t.ID = m.ModuloID AND r.Rama = m.Rama AND (r.Conciliar = 0 OR m.Conciliado = 1)

    INSERT AuxiliarR (Sucursal, Empresa, Rama, Mov, MovID, Moneda, TipoCambio, Grupo, Cuenta, SubCuenta, Ejercicio, Periodo, Fecha, Cargo, Abono, Acumulado, Conciliado)
    SELECT Sucursal, Empresa, m.Rama, 'Historico', '', m.Moneda, mon.TipoCambio, Grupo, Cuenta, SubCuenta, @AnoAnterior, @MesAnterior, @FechaAnterior, Cargo, Abono, 1, r.Conciliar
      FROM #sAuxiliarR m, Mon, Rama r
     WHERE Mon.Moneda = m.Moneda AND r.Rama = m.Rama 
  
    ALTER TABLE AuxiliarR  ENABLE TRIGGER ALL
  COMMIT TRANSACTION
END
go

/* spDepurarAuxiliarU */
if exists (select * from sysobjects where id = object_id('dbo.spDepurarAuxiliarU') and type = 'P') drop procedure dbo.spDepurarAuxiliarU
GO
CREATE PROCEDURE spDepurarAuxiliarU
			@Fecha	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MesAnterior	int,
    @AnoAnterior	int,
    @FechaAnterior	datetime,

	@WMSAuxiliar	bit -- TASK1964

  SELECT @WMSAuxiliar = WMSAuxiliar FROM Version -- TASK1964

  SELECT @FechaAnterior = DATEADD(day, -1, @Fecha)
  SELECT @AnoAnterior = DATEPART(year, @FechaAnterior)
  SELECT @MesAnterior = DATEPART(month, @FechaAnterior)

  BEGIN TRANSACTION
    IF @WMSAuxiliar = 1 -- TASK1964
    BEGIN
      ALTER TABLE AuxiliarUWMS  ENABLE TRIGGER ALL
      ALTER TABLE AuxiliarU     ENABLE TRIGGER ALL
	END ELSE
	  ALTER TABLE AuxiliarU DISABLE TRIGGER ALL

    SELECT Sucursal, Empresa, m.Rama, Moneda, Grupo, SubGrupo, Cuenta, SubCuenta, "Cargo" = CONVERT(money, SUM(Cargo)), "Abono" = CONVERT(money, SUM(Abono)), "CargoU" = CONVERT(float, SUM(CargoU)), "AbonoU" = CONVERT(float, SUM(AbonoU))  
      INTO #sAuxiliarU
      FROM AuxiliarUGral m, DepurarMov t, Rama r
     WHERE t.Modulo = m.Modulo AND t.ID = m.ModuloID AND r.Rama = m.Rama AND (r.Conciliar = 0 OR m.Conciliado = 1)
     GROUP BY Sucursal, Empresa, m.Rama, Moneda, Grupo, SubGrupo, Cuenta, SubCuenta

    DELETE AuxiliarU 
     FROM AuxiliarU m, DepurarMov t, Rama r
    WHERE t.Modulo = m.Modulo AND t.ID = m.ModuloID AND r.Rama = m.Rama AND (r.Conciliar = 0 OR m.Conciliado = 1)

    IF @WMSAuxiliar = 1 -- TASK1964
    BEGIN
      INSERT AuxiliarUWMS (Sucursal, Empresa, Rama, Mov, MovID, Moneda, TipoCambio, Grupo, SubGrupo, Cuenta, SubCuenta, Ejercicio, Periodo, Fecha, Cargo, Abono, CargoU, AbonoU, Acumulado, Conciliado)
      SELECT Sucursal, Empresa, m.Rama, 'Historico', '', m.Moneda, mon.TipoCambio, m.Grupo, m.SubGrupo, Cuenta, SubCuenta, @AnoAnterior, @MesAnterior, @FechaAnterior, Cargo, Abono, CargoU, AbonoU, 1, r.Conciliar
        FROM #sAuxiliarU m, Mon, Rama r
       WHERE Mon.Moneda = m.Moneda AND r.Rama = m.Rama AND ISNULL(m.SubGrupo, '') <> ''

      INSERT AuxiliarU (Sucursal, Empresa, Rama, Mov, MovID, Moneda, TipoCambio, Grupo, SubGrupo, Cuenta, SubCuenta, Ejercicio, Periodo, Fecha, Cargo, Abono, CargoU, AbonoU, Acumulado, Conciliado)
      SELECT Sucursal, Empresa, m.Rama, 'Historico', '', m.Moneda, mon.TipoCambio, m.Grupo, SubGrupo, Cuenta, SubCuenta, @AnoAnterior, @MesAnterior, @FechaAnterior, Cargo, Abono, CargoU, AbonoU, 1, r.Conciliar
        FROM #sAuxiliarU m, Mon, Rama r
       WHERE Mon.Moneda = m.Moneda AND r.Rama = m.Rama AND ISNULL(m.SubGrupo, '') = ''

      ALTER TABLE AuxiliarUWMS  ENABLE TRIGGER ALL
      ALTER TABLE AuxiliarU     ENABLE TRIGGER ALL
    END ELSE BEGIN -- TASK1964
      EXEC dbo.sp_executesql N'
        INSERT AuxiliarU (Sucursal, Empresa, Rama, Mov, MovID, Moneda, TipoCambio, Grupo, Cuenta, SubCuenta, Ejercicio, Periodo, Fecha, Cargo, Abono, CargoU, AbonoU, Acumulado, Conciliado)
        SELECT Sucursal, Empresa, m.Rama, ''Historico'', '''', m.Moneda, mon.TipoCambio, Grupo, Cuenta, SubCuenta, @AnoAnterior, @MesAnterior, @FechaAnterior, Cargo, Abono, CargoU, AbonoU, 1, r.Conciliar
          FROM #sAuxiliarU m, Mon, Rama r
         WHERE Mon.Moneda = m.Moneda AND r.Rama = m.Rama

        ALTER TABLE AuxiliarU  ENABLE TRIGGER ALL',
        N'@AnoAnterior int, @MesAnterior int, @FechaAnterior datetime',
		@AnoAnterior, @MesAnterior, @FechaAnterior
    END -- TASK1964

  COMMIT TRANSACTION
END
go

/* spDepurarAuxiliarRU */
if exists (select * from sysobjects where id = object_id('dbo.spDepurarAuxiliarRU') and type = 'P') drop procedure dbo.spDepurarAuxiliarRU
GO
CREATE PROCEDURE spDepurarAuxiliarRU
			@Fecha	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MesAnterior	int,
    @AnoAnterior	int,
    @FechaAnterior	datetime

  SELECT @FechaAnterior = DATEADD(day, -1, @Fecha)
  SELECT @AnoAnterior = DATEPART(year, @FechaAnterior)
  SELECT @MesAnterior = DATEPART(month, @FechaAnterior)

  BEGIN TRANSACTION
    ALTER TABLE AuxiliarRU DISABLE TRIGGER ALL

    SELECT Sucursal, Empresa, m.Rama, Moneda, Grupo, Cuenta, SubCuenta, "Cargo" = CONVERT(money, SUM(Cargo)), "Abono" = CONVERT(money, SUM(Abono)), "CargoU" = CONVERT(float, SUM(CargoU)), "AbonoU" = CONVERT(float, SUM(AbonoU))  
      INTO #sAuxiliarRU
      FROM AuxiliarRU m, DepurarMov t, Rama r
     WHERE t.Modulo = m.Modulo AND t.ID = m.ModuloID AND r.Rama = m.Rama AND (r.Conciliar = 0 OR m.Conciliado = 1)
     GROUP BY Sucursal, Empresa, m.Rama, Moneda, Grupo, Cuenta, SubCuenta

    DELETE AuxiliarRU 
     FROM AuxiliarRU m, DepurarMov t, Rama r
    WHERE t.Modulo = m.Modulo AND t.ID = m.ModuloID AND r.Rama = m.Rama AND (r.Conciliar = 0 OR m.Conciliado = 1)

    INSERT AuxiliarRU (Sucursal, Empresa, Rama, Mov, MovID, Moneda, TipoCambio, Grupo, Cuenta, SubCuenta, Ejercicio, Periodo, Fecha, Cargo, Abono, CargoU, AbonoU, Acumulado, Conciliado)
    SELECT Sucursal, Empresa, m.Rama, 'Historico', '', m.Moneda, mon.TipoCambio, Grupo, Cuenta, SubCuenta, @AnoAnterior, @MesAnterior, @FechaAnterior, Cargo, Abono, CargoU, AbonoU, 1, r.Conciliar
      FROM #sAuxiliarRU m, Mon, Rama r
     WHERE Mon.Moneda = m.Moneda AND r.Rama = m.Rama 
    ALTER TABLE AuxiliarRU  ENABLE TRIGGER ALL
  COMMIT TRANSACTION
END
go


