-----------------------------------
/********** T A B L A S **********/
-----------------------------------
IF NOT EXISTS(SELECT * FROM Sys.Objects WHERE Name='CitCfgConsecutivo' AND Type='U')
	CREATE TABLE CitCfgConsecutivo(
		TipoCliente varchar(20) NOT NULL PRIMARY KEY,
		Prefijo varchar(10) NOT NULL,
		LargoSubfijo int NOT NULL
		)
GO
--INSERT INTO CitCfgConsecutivo SELECT 'Cliente','CTA-',6

/********** xpCitSugerirConsecutivo **********/
IF EXISTS(SELECT * FROM Sys.objects WHERE Name='xpCitSugerirConsecutivo' aND Type='P')
	DROP PROCEDURE xpCitSugerirConsecutivo
GO
CREATE PROCEDURE xpCitSugerirConsecutivo
	@TipoCliente varchar(20)=''
AS
BEGIN

	DECLARE 
		@Prefijo varchar(10),
		@LargoSubfijo int,
		@PLargo int,
		@OkSQL int,
		@OkRefSQL varchar(255),
		@Subfijo int,
		@SubFijoTex varchar(20),
		@Consecutivo varchar(20)
	IF NOT EXISTS (SELECT * FROM CitCfgConsecutivo WHERE TipoCliente=@TipoCliente) SELECT @OkSQL=1
	
	IF ISNULL(@OkSQL,0)=0
	BEGIN
		----
		SELECT @Prefijo=Prefijo,@LargoSubFijo=LargoSubfijo FROM CitCfgConsecutivo WHERE TipoCliente=@TipoCliente
		----
	
		SELECT @PLargo=LEN(@Prefijo)

		BEGIN TRY
			SELECT @SubFijo=CONVERT(int,MAX(
											REPLACE(
													SUBSTRING(Cliente,@PLargo+1,Len(Cliente)-@PLargo)
											,'-','_')
											)
									) 
				FROM Cte 
				WHERE LEFT(cliente,@PLargo)=@Prefijo 
		END TRY
		BEGIN CATCH
			SELECT   
				@OkSQL=ERROR_NUMBER(),
				@OkRefSQL=ERROR_MESSAGE()
		END CATCH
		END
	IF ISNULL(@OkSQL,0)=0
	BEGIN
		SELECT @Subfijo=ISNULL(@SubFijo,0)+1
		--SELECT @Subfijo
		SELECT @SubFijoTex=CONVERT(varchar(20),@SubFijo)
		WHILE LEN(@SubFijoTex)<@LargoSubfijo
		BEGIN
			SELECT @SubFijoTex=CONCAT('0',@SubFijoTex)
		END
		SELECT @Consecutivo=CONCAT(@Prefijo,@SubFijoTex)
		--SELECT @Consecutivo
	END
	ELSE
		SELECT @Consecutivo=''
	
	SELECT @Consecutivo
END
GO



--EXEC xpCitSugerirConsecutivo 'DEUDOR'