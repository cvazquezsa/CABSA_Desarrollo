/**************** spDescartarServicio ****************/
IF EXISTS(SELECT * FROM sysobjects WHERE type = 'p' AND name = 'spDescartarServicio')
	DROP PROCEDURE dbo.spDescartarServicio
GO
CREATE PROCEDURE dbo.spDescartarServicio
	@ID varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
SET NOCOUNT ON
	UPDATE IntelisisService SET Estatus = 'DESCARTADO' WHERE Estatus = 'ERROR' AND ID = CAST(@ID as Int)
SET NOCOUNT OFF
END
GO
