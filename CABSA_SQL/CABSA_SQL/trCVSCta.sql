IF EXISTS (SELECT * FROM SysObjects WHERE name = 'trCVSCta' AND type = 'TR')
	DROP TRIGGER trCVSCta
GO
CREATE TRIGGER trCVSCta ON Cta
FOR INSERT, DELETE
AS
BEGIN
	DECLARE 
		@Cta varchar(20)
	IF EXISTS (SELECT * FROM inserted WHERE Tipo = 'Auxiliar' AND EsAcumulativa = 0)
	BEGIN
		SELECT @Cta = Cuenta FROM inserted WHERE Tipo = 'Auxiliar' AND EsAcumulativa = 0
		
		INSERT INTO CtaSub
			SELECT @Cta,CentroCostos FROM CentroCostos WHERE EsAcumulativo = 0
		
		INSERT INTO CtaSub2
			SELECT @Cta,CentroCostos2 FROM CentroCostos2 WHERE EsAcumulativo = 0
	END
	IF EXISTS (SELECT * FROM deleted)
	BEGIN
		SELECT @Cta = Cuenta FROM deleted
		DELETE FROM CtaSub WHERE Cuenta = @Cta
		DELETE FROM CtaSub2 WHERE Cuenta = @Cta
	END
END
GO

