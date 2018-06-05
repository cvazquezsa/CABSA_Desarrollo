/* Configuracion MS SQL Server */
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/*
EXEC spALTER_TABLE 'EmpresaCfgMovCompra', 'PedidoMax',      'varchar(20) NULL'

EXEC spALTER_TABLE 'EmpresaCfgMov', 'CPTerminacionAnticipada',                        'varchar(20)   NULL'

UPDATE EmpresaCfgMov SET CPTerminacionAnticipada='Terminacion Anticip.'
*/



IF NOT EXISTS (SELECT * FROM VersionLista WHERE Nombre = 'ExportarExcelSegundoPlano') 
INSERT INTO VersionLista (Nombre, Valor, Visible) VALUES('ExportarExcelSegundoPlano', 'Si', 1);
GO

IF NOT EXISTS (SELECT * FROM VersionLista WHERE Nombre = 'AyudaUrl') 
INSERT INTO VersionLista (Nombre, Valor, Visible) VALUES('AyudaUrl', 'http://tec.intelisis.com/ayudaurl.aspx', 1);
GO
IF NOT EXISTS (SELECT * FROM VersionLista WHERE Nombre = 'TeamViewerGrupo') 
INSERT INTO VersionLista (Nombre, Valor, Visible) VALUES('TeamViewerGrupo', 'Intelisis', 1);
GO
IF NOT EXISTS (SELECT * FROM VersionLista WHERE Nombre = 'TeamViewerToken') 
INSERT INTO VersionLista (Nombre, Valor, Visible) VALUES('TeamViewerToken', '737D6F737D7B7E6F010C0A290E2E2625052035363B12723D33281C78', 1);
GO
IF EXISTS (SELECT * FROM VersionLista WHERE Nombre = 'TeamViewerToken') 
UPDATE VersionLista SET Valor = '737D6F737D7B7E6F010C0A290E2E2625052035363B12723D33281C78' WHERE Nombre = 'TeamViewerToken'
GO
IF NOT EXISTS (SELECT * FROM VersionLista WHERE Nombre = 'TeamViewerUrl') 
INSERT INTO VersionLista (Nombre, Valor, Visible) VALUES('TeamViewerUrl', 'https://webapi.teamviewer.com/api/v1/sessions', 1);
GO
IF NOT EXISTS (SELECT * FROM VersionLista WHERE Nombre = 'TeamViewerUrl') 
INSERT INTO VersionLista (Nombre, Valor, Visible) VALUES('TeamViewerUrl', 'https://webapi.teamviewer.com/api/v1/sessions', 1);
GO
IF NOT EXISTS (SELECT * FROM VersionLista WHERE Nombre = 'InvArtStockDisponible') 
INSERT INTO VersionLista (Nombre, Valor, Visible) VALUES('InvArtStockDisponible', 'Si', 1);
GO
IF NOT EXISTS (SELECT * FROM VersionLista WHERE Nombre = 'NominaRedundaCorrepondeLote') 
INSERT INTO VersionLista (Nombre, Valor, Visible) VALUES('NominaRedundaCorrepondeLote', '20', 1);
GO