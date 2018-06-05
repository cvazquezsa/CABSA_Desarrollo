/********** trCVSCentroCostos **********/
/*relaciona un centro de costos a todas las cuentas contables auxiliares no acumulativas cuando se crea un nuevo centro de costos, 
cuando se elimina un centro de costos tambien elimina la relación*/
IF EXISTS (SELECT * FROM SysObjects WHERE name = 'trCVSCentroCostos' AND type = 'TR')
	DROP TRIGGER trCVSCentroCostos
GO
CREATE TRIGGER trCVSCentroCostos ON CentroCostos
FOR INSERT, DELETE
AS
BEGIN
	DECLARE
		@CentroCostos varchar(20)

	IF EXISTS(SELECT * FROM inserted)
	BEGIN--insert
		SELECT @CentroCostos = CentroCostos FROM inserted
		
		INSERT INTO CtaSub
			SELECT Cuenta,@CentroCostos FROM Cta WHERE Tipo = 'Auxiliar' AND EsAcumulativa = 0
	END--insert
	IF EXISTS(SELECT * FROM deleted)
	BEGIN--deleted
		SELECT @CentroCostos = CentroCostos FROM deleted
		DELETE FROM CtaSub WHERE SubCuenta = @CentroCostos
	END--deleted
END
GO

/********** trCVSCentroCostos2 **********/
/*relaciona un centro de costos 2 a todas las cuentas contables auxiliares no acumulativas cuando se crea un nuevo centro de costos 2, 
cuando se elimina un centro de costos 2 tambien elimina la relación*/
IF EXISTS (SELECT * FROM SysObjects WHERE name = 'trCVSCentroCostos2' AND type = 'TR')
	DROP TRIGGER trCVSCentroCostos2
GO
CREATE TRIGGER trCVSCentroCostos2 ON CentroCostos2
FOR INSERT, DELETE
AS
BEGIN
	DECLARE
		@CentroCostos varchar(20)

	IF EXISTS(SELECT * FROM inserted)
	BEGIN--insert
		SELECT @CentroCostos = CentroCostos2 FROM inserted
		
		INSERT INTO CtaSub2
			SELECT Cuenta,@CentroCostos FROM Cta WHERE Tipo = 'Auxiliar' AND EsAcumulativa = 0
	END--insert
	IF EXISTS(SELECT * FROM deleted)
	BEGIN--deleted
		SELECT @CentroCostos = CentroCostos2 FROM deleted
		DELETE FROM CtaSub2 WHERE SubCuenta2 = @CentroCostos
	END--deleted
END
GO

--BEGIN TRANSACTION
--DELETE FROM CentroCostos WHERE CentroCostos = '001 001 0418'
--ROLLBACK
--SELECT * FROM CtaSub WHERE SubCuenta = '001 001 0418'
--SELECT * FROM CtaSub2
--SELECT * FROM CentroCostos
--DELETE FROM CtaSub WHERE SubCuenta = '001 001 0418'