SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
/*
Ejecutar este script independientemente del instalador, ya que puede tardar mucho tiempo dependiendo del numero de registros que se tengan en la tabla de MovImpuesto
*/
GO
IF NOT EXISTS (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovImpuesto' AND sysindexes.name = 'Module' AND sysobjects.id = sysindexes.id)
CREATE NONCLUSTERED INDEX Module
ON [dbo].[MovImpuesto] ([Modulo])
INCLUDE ([ID],[OrigenModulo],[OrigenModuloID])
GO
