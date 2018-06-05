SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_WARNINGS ON
SET ANSI_PADDING ON
GO

/* UltimoCambio */
IF (SELECT Version FROM Version)<=1137 UPDATE Cont       SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Venta      SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Prod       SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Compra     SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Inv        SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Cxc        SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Cxp        SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Agent      SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Gasto      SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Dinero     SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Embarque   SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Nomina     SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE RH         SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Asiste     SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE ActivoFijo SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Soporte    SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO
IF (SELECT Version FROM Version)<=1137 UPDATE Cambio     SET UltimoCambio = FechaRegistro WHERE UltimoCambio IS NULL 
GO

/* Cuenta TipoCambio */
IF (SELECT Version FROM Version)<=1149
BEGIN 
  UPDATE Cxc SET ClienteTipoCambio = Mon.TipoCambio FROM Cxc, Mon WHERE Cxc.ClienteMoneda = Mon.Moneda AND Cxc.Estatus = 'SINAFECTAR' AND Cxc.ClienteTipoCambio IS NULL
  UPDATE Cxp SET ProveedorTipoCambio = Mon.TipoCambio FROM Cxp, Mon WHERE Cxp.ProveedorMoneda = Mon.Moneda AND Cxp.Estatus = 'SINAFECTAR' AND Cxp.ProveedorTipoCambio IS NULL
END
GO

-- Codigos Postales
UPDATE CodigoPostal SET Estado = 'DISTRITO FEDERAL' WHERE Estado IS NULL AND CodigoPostal < 17000
UPDATE CodigoPostal SET Estado = 'MEXICO'           WHERE Estado IS NULL AND CodigoPostal BETWEEN 50000 AND 58000
GO

-- PlugInsInt
DELETE PlugInInt

INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piDescargaSAT', 'DescargaSAT', 'DescargaSAT.exe', '1.0', '1024200206720602202410');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piMonitorXML', 'MonitorXML', 'MonitorXML.exe', '1.0', '0122361B1B1B1B362201');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piCalcPrecio', 'CalcPrecio', 'CalcPrecio.exe', '1.0', '2C080F062222060F082C');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piVentanilla', 'Ventanilla', 'Ventanilla.exe', '1.0', '3709021D0F0F1D020937');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piGraficas', 'Graficas', 'Graficas.exe', '1.0', '3413020F0F021334');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piPDT', 'PDT', 'PDT.exe', '1.0', '044404');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piDistribucion', 'Distribucion', 'Distribucion.exe', '1.0', '2A061A17070B0B07171A062A');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piRespaldarDatos', 'RespaldarDatos', 'RespaldarDatos.exe', '1.0', '210A0711251E05051E2511070A21');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piCabinaMando', 'CM', 'CM.exe', '1.0', '2C29');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piGenerarHTML', 'GenerarHTML', 'GenerarHTML.exe', '1.0', '0B283A2D7261722D3A280B');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piPV', 'PV', 'PV.exe', '1.0', '0606');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piPlaneador', 'Planeador', 'Planeador.exe', '1.0', '2203050F650F050322');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piVisorWeb', 'VisorWeb', 'VisorWeb.exe', '1.0', '340C241D1D240C34');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piCEAgenda', 'CEAgenda', 'CEAgenda.exe', '1.0', '22212F02022F2122');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piProcesarCubos', 'ProcesarCubos', 'ProcesarCubos.exe', '1.0', '231D0D162601610126160D1D23');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piGantt', 'Gantt', 'Gantt.exe', '1.0', '33156E1533');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piBrowser', 'Browser', 'Browser.exe', '1.0', '30171C771C1730');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piAgenda', 'Agenda', 'Agenda.exe', '1.0', '20030B0B0320');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piMI', 'IntelisisVista', 'IntelisisVista.exe', '1.0', '49231D150D1D7369252569731D0D');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piCuboExcel', 'Intelisis.xlsx', 'Intelisis.xlsx', '1.0', '250B171D2906111C304708147314');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piGuardarLista', 'GuardarLista', 'GuardarLista.exe', '1.0', '2601121B281313281B120126');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piArtVenta', 'ArtVenta', 'ArtVenta.exe', '1.0', '20061A33331A0620');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piScoreBoard', 'SB', 'SB.exe', '1.0', '3730');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piETLic', 'ETLic', 'ETLic.exe', '1.0', '263D4C3D26');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piInteliMap', 'InteliMap', 'InteliMap.exe', '1.0', '390F390C6C0C390F39');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piCubo2005', 'Cubo2005', 'Cubo2005.exe', '1.0', '7645525D5D524576');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piET', 'ET', 'ET.exe', '1.0', '1111');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piAlmacen', 'Almacen', 'Almacen.exe', '1.0', '2F090E610E092F');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piTablero', 'Tablero', 'Tablero.exe', '1.0', '3B13076C07133B');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piCubo2008', 'Cubo2008', 'Cubo2008.exe', '1.0', '7B45525D5D52457B');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piJuegoArticulo', 'JuegoArticulo', 'JuegoArticulo.exe', '1.0', '25191004063572350604101925');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piECE', 'ECE', 'ECE.exe', '1.0', '454345');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piAgendaEstacion', 'AgendaEstacion', 'AgendaEstacion.exe', '1.0', '2F080C0D0515363615050D0C082F');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piCuboDX', 'CuboDX', 'CuboDX.exe', '1.0', '1B310D0D311B');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piSincroXML', 'SincroXML', 'SincroXML.exe', '1.0', '1F24360C720C36241F');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piMapa', 'Mapa', 'Mapa.exe', '1.0', '2C11112C');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piFirma', 'Firma', 'Firma.exe', '1.0', '2704720427');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piSincro', 'Sincro', 'Sincro.exe', '1.0', '3C1B0D0D1B3C');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piGuardarXML', 'GuardarXML', 'GuardarXML.exe', '1.0', '0B38397205057239380B');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piCubo', 'Cubo', 'Cubo.exe', '1.0', '2C17172C');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piBackSQL', 'BackSQL', 'BackSQL.exe', '1.0', '0E30306B30300E');
INSERT INTO PlugInInt (IdIntelisis, PlugIn, Ejecutable, SubVersion, PlugInKey)
	VALUES('piAcceso', 'Acceso', 'Acceso.exe', '1.0', '2E100606102E');
INSERT INTO PlugInInt (IdIntelisis, PlugIn,Ejecutable,SubVersion,PlugInKey)
    VALUES('piPlanograma','Planograma','Planograma.exe',1,'3101611C08081C610131')

GO
