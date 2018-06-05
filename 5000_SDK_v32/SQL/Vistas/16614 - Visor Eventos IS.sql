SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO
/**************** IntelisisFactory ****************/
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'IntelisisFactory')
	DROP VIEW [dbo].[IntelisisFactory]
GO
CREATE VIEW [dbo].[IntelisisFactory]
AS
SELECT	cast(ID as varchar(10)) ID, 
		Sistema,
		Referencia,
		SubReferencia,
		CAST(CASE Estatus WHEN 'PROCESADO' THEN 'COMPLETO' WHEN 'DESCARTADO' THEN 'CANCELADO' WHEN 'SINPROCESAR' THEN 'PROCESADO' ELSE Estatus END AS VARCHAR(50)) Estatus,
		CONVERT(varchar(19), FechaEstatus, 121) FechaEstatus,
		cast(Ok as varchar(10)) Ok,
		OkRef,
		CAST(replace(replace(replace(replace(replace(Solicitud, 
			CHAR(10), '') , CHAR(13), ''), '<', NCHAR(13) + '<')  , CHAR(13) + '<Intelisis', '<Intelisis'), CHAR(13) + '<?xml', '<?xml') AS VARCHAR(MAX))
			AS SolicitudMax,
		ISNULL(CAST(replace(replace(replace(replace(replace(Resultado,
			CHAR(10), '') , CHAR(13), ''), '<', NCHAR(13) + '<')  , CHAR(13) + '<Intelisis', '<Intelisis'), CHAR(13) + '<?xml', '<?xml') AS VARCHAR(MAX)),'')
			AS ResultadoMax,
		CASE Estatus WHEN 'SINPROCESAR' THEN 'SIN PROCESAR' WHEN 'ERROR' THEN ' ERROR' ELSE Estatus END EstatusMostrar,
		convert(varchar(10), FechaEstatus, 103) FechaFiltro
  FROM	IntelisisService
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'spDescartarServicio')
	DROP PROCEDURE [dbo].spDescartarServicio
GO
/**************** spDescartarServicio ****************/
IF EXISTS(SELECT * FROM sysobjects WHERE type = 'p' AND name = 'spDescartarServicio')
	DROP PROCEDURE dbo.spDescartarServicio
GO
CREATE PROCEDURE dbo.spDescartarServicio
	@ID varchar(10)
AS
BEGIN
SET NOCOUNT ON
	UPDATE IntelisisService SET Estatus = 'DESCARTADO' WHERE Estatus = 'ERROR' AND ID = CAST(@ID as Int)
SET NOCOUNT OFF
END
GO