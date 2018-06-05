SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO
CREATE PROCEDURE [dbo].[sppConciliacionOtros]
@Institucion	varchar(20),
@NumeroCta	varchar(100),
@Estacion	Int
--WITH ENCRYPTION
AS
BEGIN
DECLARE	@RegClave	varchar(255),
@TipoMov	varchar(2),
@Fecha		varchar(8),--datetime,
@Concepto	varchar(50),
@Referencia 	varchar(50),
@Cargo		varchar(20),--money,
@Abono		varchar(20),--money,
@Observaciones	varchar(100),
@TAB		varchar(1),
@Cargos		Money,
@Abonos		Money

SET @TAB = '|'

DECLARE crListaSt CURSOR FOR
SELECT RTRIM(LTRIM(Clave)) FROM ListaSt WHERE Estacion = @Estacion AND Clave not like 'fec%'
OPEN crListaSt
FETCH NEXT FROM crListaSt INTO @RegClave
WHILE @@FETCH_STATUS = 0
BEGIN
			EXEC xpExtraerDatoTEXT  @RegClave OUTPUT, @Fecha OUTPUT, @TAB
 			EXEC xpExtraerDatoTEXT  @RegClave OUTPUT, @Concepto OUTPUT, @TAB
			EXEC xpExtraerDatoTEXT  @RegClave OUTPUT, @Referencia OUTPUT, @TAB
 			EXEC xpExtraerDatoTEXT  @RegClave OUTPUT, @Cargo OUTPUT, @TAB
			EXEC xpExtraerDatoTEXT  @RegClave OUTPUT, @Abono OUTPUT, @TAB


select @cargo=ISNULL(NULLIF(ltrim(rtrim(replace(@cargo,'	',''))),''),0), @abono=ISNULL(NULLIF(ltrim(rtrim(replace(@abono,'	',''))),''),0)

INSERT INTO #ConciliacionBanco Values(@Fecha, @Concepto, @Referencia, @Cargo,  @Abono ,NULL)

FETCH NEXT FROM crListaSt INTO @RegClave
END
CLOSE crListaSt
DEALLOCATE crListaSt
END
GO
