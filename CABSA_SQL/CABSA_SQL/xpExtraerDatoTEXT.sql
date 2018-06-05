/****** Object:  StoredProcedure [dbo].[xpExtraerDatoTEXT]    Script Date: 15/11/2013 05:14:55 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create PROCEDURE [dbo].[xpExtraerDatoTEXT]
@Texto 	  	varchar(255)	OUTPUT,
@Dato     	varchar(255)	OUTPUT,
@Separador	char(1)
--WITH ENCRYPTION
AS BEGIN
DECLARE
@p 		int
SELECT @Dato = NULL
SELECT @p = CHARINDEX(@Separador, @Texto)
IF @p > 0
BEGIN
SELECT @Dato = NULLIF(LTRIM(RTRIM(SUBSTRING(@Texto, 1, @p-1))), '')
SELECT @Texto = NULLIF(LTRIM(RTRIM(SUBSTRING(@Texto, @p+1, LEN(@Texto)))), '')
END ELSE
SELECT @Dato = NULLIF(LTRIM(RTRIM(@Texto)), ''), @Texto = NULL
RETURN
END
