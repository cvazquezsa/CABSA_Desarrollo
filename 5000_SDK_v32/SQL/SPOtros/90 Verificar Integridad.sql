/**** VERIFICAR INTEGRIDAD ******/

/****** VerificarRamas ******/
if exists (select * from sysobjects where id = object_id('dbo.VerificarRamas') and sysstat & 0xf = 3) drop table dbo.VerificarRamas
go
CREATE TABLE dbo.VerificarRamas (
	Empresa		char(5)		NOT NULL,
	Rama		char(5) 	NOT NULL,
	Moneda		char(10)	NOT NULL,
	
	Saldo		money		NULL,
	Acum		money		NULL,
	Auxiliar	money		NULL,
	
	SaldoU		float		NULL,
	AcumU		float		NULL,
	AuxiliarU	float		NULL,

	CONSTRAINT priVerificarRamas PRIMARY KEY CLUSTERED (Empresa, Rama, Moneda)
)
GO

/****** VerificarModulos ******/
if exists (select * from sysobjects where id = object_id('dbo.VerificarModulos') and sysstat & 0xf = 3) drop table dbo.VerificarModulos
go
CREATE TABLE dbo.VerificarModulos (
	Empresa		char(5)		NOT NULL,
	Modulo		char(5) 	NOT NULL,
	Cuenta		char(10)	NOT NULL,
	Moneda		char(10)	NOT NULL,
	
	Saldo		money		NULL,
	Pendiente	money		NULL,
	
	CONSTRAINT priVerificarModulos PRIMARY KEY CLUSTERED (Empresa, Modulo, Cuenta, Moneda)
)
GO


/*** VerVerificarRamas ***/
if exists (select * from sysobjects where id = object_id('dbo.VerVerificarRamas') and sysstat & 0xf = 2) drop view dbo.VerVerificarRamas
GO
CREATE VIEW VerVerificarRamas
--//WITH ENCRYPTION
AS 
SELECT 
  "Estatus" = CASE WHEN isnull(round(Saldo, 0), 0)=isnull(round(Acum, 0), 0) AND isnull(round(Acum, 0), 0)=isnull(round(Auxiliar, 0), 0) AND isnull(round(SaldoU, 0), 0)=isnull(round(AcumU, 0), 0) AND isnull(round(AcumU, 0), 0)=isnull(round(AuxiliarU, 0), 0) THEN 'Ok' ELSE 'ERROR' END,
  Rama,
  Moneda,
  Saldo,
  Acum,
  Auxiliar,
  SaldoU,
  AcumU,
  AuxiliarU,
  Empresa

FROM 
  VerificarRamas
GO

/*** VerVerificarModulos ***/
if exists (select * from sysobjects where id = object_id('dbo.VerVerificarModulos') and sysstat & 0xf = 2) drop view dbo.VerVerificarModulos
GO
CREATE VIEW VerVerificarModulos
--//WITH ENCRYPTION
AS 
SELECT 
  "Estatus" = CASE WHEN round(ISNULL(SUM(Saldo), 0), 0)=round(ISNULL(SUM(Pendiente), 0), 0) THEN 'Ok' ELSE 'ERROR' END,
  Modulo,
  Moneda,
  "Saldo" = SUM(Saldo),
  "Pendiente" = SUM(Pendiente),
  Empresa

FROM 
  VerificarModulos

GROUP BY
  Modulo, Moneda, Empresa
GO

/*** VerVerificarCuentas ***/
if exists (select * from sysobjects where id = object_id('dbo.VerVerificarCuentas') and sysstat & 0xf = 2) drop view dbo.VerVerificarCuentas
GO
CREATE VIEW VerVerificarCuentas
--//WITH ENCRYPTION
AS 
SELECT 
  "Estatus" = CASE WHEN round(ISNULL(Saldo, 0), 0)=round(ISNULL(Pendiente, 0), 0) THEN 'Ok' ELSE 'ERROR' END,
  Modulo,
  Cuenta,
  Moneda,
  Saldo,
  Pendiente,
  Empresa

FROM 
  VerificarModulos
GO


/**************** spVerificarAuxiliar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerificarAuxiliar') and type = 'P') drop procedure dbo.spVerificarAuxiliar
GO             
CREATE PROCEDURE spVerificarAuxiliar
			@Empresa	char(5),
			@Rama 		char(5),
    			@Moneda		char(10)

--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Saldo	money,
    @Acum	money,
    @Auxiliar	money

  SELECT @Saldo = SUM(Saldo)         			
    FROM Saldo 	
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda

  SELECT @Acum = SUM(ISNULL(Cargos, 0.0)-ISNULL(Abonos, 0.0))
    FROM Acum 	
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Periodo <> 0

  SELECT @Auxiliar = SUM(ISNULL(Cargo, 0.0)-ISNULL(Abono, 0.0)) 
    FROM Auxiliar 	
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda

  INSERT VerificarRamas (Empresa, Rama, Moneda, Saldo, Acum, Auxiliar) 
                 VALUES (@Empresa, @Rama, @Moneda, @Saldo, @Acum, @Auxiliar)
END
GO

/**************** spVerificarAuxiliarR ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerificarAuxiliarR') and type = 'P') drop procedure dbo.spVerificarAuxiliarR
GO             
CREATE PROCEDURE spVerificarAuxiliarR
			@Empresa	char(5),
			@Rama 		char(5),
    			@Moneda		char(10)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Saldo	money,
    @Acum	money,
    @Auxiliar	money

  SELECT @Saldo = SUM(Saldo)         			
    FROM SaldoR
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda

  SELECT @Acum = SUM(ISNULL(Cargos, 0.0) - ISNULL(Abonos, 0.0))
    FROM AcumR 
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Periodo <> 0

  SELECT @Auxiliar = SUM(ISNULL(Cargo, 0.0) - ISNULL(Abono, 0.0)) 
    FROM AuxiliarR 	
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda

  INSERT VerificarRamas (Empresa, Rama, Moneda, Saldo, Acum, Auxiliar) 
                 VALUES (@Empresa, @Rama, @Moneda, @Saldo, @Acum, @Auxiliar)
END
GO

/**************** spVerificarAuxiliarU ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerificarAuxiliarU') and type = 'P') drop procedure dbo.spVerificarAuxiliarU
GO             
CREATE PROCEDURE spVerificarAuxiliarU
			@Empresa	char(5),
			@Rama 		char(5),
    			@Moneda		char(10)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Saldo	money,
    @Acum	money,
    @Auxiliar	money,
    @SaldoU	float,
    @AcumU	float,
    @AuxiliarU	float

  SELECT @Saldo    = SUM(Saldo), 
         @SaldoU   = SUM(SaldoU)				
    FROM SaldoU 	
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda

  SELECT @Acum     = SUM(ISNULL(Cargos, 0.0) - ISNULL(Abonos, 0.0)),
         @AcumU	   = SUM(ISNULL(CargosU, 0.0) - ISNULL(AbonosU, 0.0))
    FROM AcumU 	
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Periodo <> 0

  SELECT @Auxiliar  = SUM(ISNULL(Cargo, 0.0) - ISNULL(Abono, 0.0)),
	 @AuxiliarU = SUM(ISNULL(CargoU, 0.0) - ISNULL(AbonoU, 0.0)) 
    FROM AuxiliarU 	
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda

  INSERT VerificarRamas (Empresa, Rama, Moneda, Saldo, Acum, Auxiliar, SaldoU, AcumU, AuxiliarU) 
                 VALUES (@Empresa, @Rama, @Moneda, @Saldo, @Acum, @Auxiliar, @SaldoU, @AcumU, @AuxiliarU)
END
GO

/**************** spVerificarAuxiliarRU ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerificarAuxiliarRU') and type = 'P') drop procedure dbo.spVerificarAuxiliarRU
GO             
CREATE PROCEDURE spVerificarAuxiliarRU
			@Empresa	char(5),
			@Rama 		char(5),
    			@Moneda		char(10)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Saldo	money,
    @Acum	money,
    @Auxiliar	money,
    @SaldoU	float,
    @AcumU	float,
    @AuxiliarU	float

  SELECT @Saldo    = SUM(Saldo), 
         @SaldoU   = SUM(SaldoU)				
    FROM SaldoRU 	
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda

  SELECT @Acum     = SUM(ISNULL(Cargos, 0.0) - ISNULL(Abonos, 0.0)),
         @AcumU	   = SUM(ISNULL(CargosU, 0.0) - ISNULL(AbonosU, 0.0))
    FROM AcumRU 	
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda AND Periodo <> 0

  SELECT @Auxiliar  = SUM(ISNULL(Cargo, 0.0) - ISNULL(Abono, 0.0)),
	 @AuxiliarU = SUM(ISNULL(CargoU, 0.0) - ISNULL(AbonoU, 0.0)) 
    FROM AuxiliarRU
   WHERE Empresa = @Empresa AND Rama = @Rama AND Moneda = @Moneda

  INSERT VerificarRamas (Empresa, Rama, Moneda, Saldo, Acum, Auxiliar, SaldoU, AcumU, AuxiliarU) 
                 VALUES (@Empresa, @Rama, @Moneda, @Saldo, @Acum, @Auxiliar, @SaldoU, @AcumU, @AuxiliarU)
END
GO


/**************** spVerificarRama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerificarRama') and type = 'P') drop procedure dbo.spVerificarRama
GO             
CREATE PROCEDURE spVerificarRama 	
			@Empresa	char(5),
			@Rama 		char(5),
			@Moneda		char(10)

--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @EsMonetario	bit,
    @EsUnidades		bit,
    @EsResultados	bit

  SELECT @EsMonetario = EsMonetario, @EsUnidades = EsUnidades, @EsResultados = EsResultados
    FROM Rama
   WHERE Rama = @Rama

  IF @EsMonetario = 1 AND @EsUnidades  = 0 AND @EsResultados = 0 EXEC spVerificarAuxiliar   @Empresa, @Rama, @Moneda ELSE
  IF @EsMonetario = 1 AND @EsUnidades  = 0 AND @EsResultados = 1 EXEC spVerificarAuxiliarR  @Empresa, @Rama, @Moneda ELSE
  IF @EsMonetario = 1 AND @EsUnidades  = 1 AND @EsResultados = 0 EXEC spVerificarAuxiliarU  @Empresa, @Rama, @Moneda ELSE
  IF @EsMonetario = 1 AND @EsUnidades  = 1 AND @EsResultados = 1 EXEC spVerificarAuxiliarRU @Empresa, @Rama, @Moneda 
END
GO

/**************** spVerificarCxc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerificarCxc') and type = 'P') drop procedure dbo.spVerificarCxc
GO             
CREATE PROCEDURE spVerificarCxc
			@Empresa	char(5),
			@Moneda		char(10)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Cuenta	char(20),
    @Saldo	money,
    @Pendiente	money

  DECLARE crCuenta CURSOR FOR 
   SELECT Cliente
     FROM Cte

  OPEN crCuenta
  FETCH NEXT FROM crCuenta INTO @Cuenta
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Saldo = SUM(Saldo) FROM Saldo WHERE Empresa = @Empresa AND Moneda = @Moneda AND Cuenta = @Cuenta AND Rama IN ('CXC', 'CEFE', 'CVALE','CRND','CNO') 
      SELECT @Pendiente = SUM(Saldo) FROM dbo.fnCxcInfo(@Empresa, @Cuenta, @Cuenta) WHERE Moneda = @Moneda 
      INSERT VerificarModulos (Empresa, Modulo, Cuenta, Moneda, Saldo, Pendiente) VALUES (@Empresa, 'CXC', @Cuenta, @Moneda, @Saldo, @Pendiente)
    END
    FETCH NEXT FROM crCuenta INTO @Cuenta
  END
  CLOSE crCuenta
  DEALLOCATE crCuenta
END
GO

/**************** spVerificarCxp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerificarCxp') and type = 'P') drop procedure dbo.spVerificarCxp
GO             
CREATE PROCEDURE spVerificarCxp
			@Empresa	char(5),
			@Moneda		char(10)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Cuenta	char(20),
    @Saldo	money,
    @Pendiente	money

  DECLARE crCuenta CURSOR FOR 
   SELECT Proveedor
     FROM Prov

  OPEN crCuenta
  FETCH NEXT FROM crCuenta INTO @Cuenta
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Saldo = SUM(Saldo) FROM Saldo WHERE Empresa = @Empresa AND Moneda = @Moneda AND Cuenta = @Cuenta AND Rama IN ('CXP', 'PEFE','PRND') 
      SELECT @Pendiente = SUM(Saldo) FROM dbo.fnCxpInfo(@Empresa, @Cuenta, @Cuenta) WHERE Moneda = @Moneda 
      INSERT VerificarModulos (Empresa, Modulo, Cuenta, Moneda, Saldo, Pendiente) VALUES (@Empresa, 'CXP', @Cuenta, @Moneda, @Saldo, @Pendiente)
    END
    FETCH NEXT FROM crCuenta INTO @Cuenta
  END
  CLOSE crCuenta
  DEALLOCATE crCuenta
END
GO

/**************** spVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerificar') and type = 'P') drop procedure dbo.spVerificar
GO             
CREATE PROCEDURE spVerificar
			@Empresa 	char(5)
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE
    @Rama 	char(5),
    @Moneda	char(10)

  SELECT @Empresa = UPPER(@Empresa)
  DELETE VerificarRamas   WHERE Empresa = @Empresa 
  DELETE VerificarModulos WHERE Empresa = @Empresa

  DECLARE crMoneda CURSOR FOR 
   SELECT Moneda
     FROM Mon

  OPEN crMoneda
  FETCH NEXT FROM crMoneda INTO @Moneda
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      DECLARE crRama CURSOR FOR 
       SELECT Rama 
         FROM Rama 
        WHERE Rama <> 'CONT'

      OPEN crRama
      FETCH NEXT FROM crRama INTO @Rama
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          EXEC spVerificarRama @Empresa, @Rama, @Moneda
        END
        FETCH NEXT FROM crRama INTO @Rama
      END
      CLOSE crRama
      DEALLOCATE crRama

      EXEC spVerificarCxc @Empresa, @Moneda
      EXEC spVerificarCxp @Empresa, @Moneda
    END
    FETCH NEXT FROM crMoneda INTO @Moneda
  END
  CLOSE crMoneda
  DEALLOCATE crMoneda

  PRINT "<Inicio del Reporte>"
  PRINT "Fecha: "+CONVERT(char, GETDATE())
  PRINT "Empresa: "+@Empresa
  PRINT ""
  PRINT "******************* VERIFICACION A NIVEL RAMAS *******************"
  PRINT ""
  SELECT * FROM VerVerificarRamas   WHERE Empresa = @Empresa ORDER BY Rama, Moneda
  PRINT ""

  PRINT "****************** VERIFICACION A NIVEL MODULOS ******************"
  PRINT ""
  SELECT * FROM VerVerificarModulos WHERE Empresa = @Empresa ORDER BY Modulo, Moneda
  PRINT ""

  PRINT "****************** VERIFICACION A NIVEL CUENTAS ******************"
  PRINT ""
  SELECT * FROM VerVerificarCuentas WHERE Empresa = @Empresa ORDER BY Modulo, Cuenta, Moneda

  PRINT "<Fin del Reporte>"
END
GO

GO
PRINT "******************* VERIFICAR INTEGRIDAD ******************"
go

-- spVerificar 'DEMO'
