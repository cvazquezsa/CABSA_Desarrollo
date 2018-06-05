/******** Cambiar de Version ************/

/*IF (SELECT Version FROM Version) BETWEEN 400 AND 12
  EXEC fixAplicaDifEfectivo
*/

DECLARE
    @EsDemo             bit

    SELECT @EsDemo = EsDemo
      FROM Version

IF @EsDemo <> 1
BEGIN
if (select version from version) <=1255
  EXEC fixInvProdNominaImporte
END
GO

if (select version from version) <=1263
  UPDATE EmpresaCfg SET CompraDescImporte = 0, VentaDescImporte  = 0
GO


if (select version from version) <= 1268
  UPDATE MovTipo SET Factor = -1 WHERE Clave IN ('VTAS.D', 'VTAS.DF', 'VTAS.B', 'VTAS.DC', 'VTAS.DR', 'VTAS.SD', 'VTAS.VP', 'VTAS.DCR')
GO

if (select version from version) BETWEEN 1200 AND 1273
  EXEC fixAgentPagoDev
GO

if (select version from version) <= 1277
  EXEC fixArtAlm
GO

if (select version from version) BETWEEN 400 AND 1217
  EXEC fixCompraDescuentoLineal
GO

if (select version from version) BETWEEN 400 AND 1217
  EXEC fixVentaDescuentoLineal
GO

if (select version from version) <= 1284
  UPDATE Art SET AlmacenROP = NULL WHERE UPPER(AlmacenROP) = '(DEMANDA)'
GO

if (select version from version) <= 1286
  EXEC fixAgentAnticipo
GO

if (select version from version) <= 1353
  EXEC fixBonificacionVentas
GO

if (select version from version) <= 1414
  update cxc set IVAFiscal = ISNULL(CONVERT(float, NULLIF(Impuestos, 0))  / NULLIF(Importe + Impuestos, 0), 0.13043478260869565) WHERE IVAFiscal IS NULL AND Estatus IN ('CONCLUIDO', 'PENDIENTE')
go
if (select version from version) <= 1414
  update cxp set IVAFiscal = ISNULL(CONVERT(float, NULLIF(Impuestos, 0))  / NULLIF(Importe + Impuestos, 0), 0.13043478260869565) WHERE IVAFiscal IS NULL AND Estatus IN ('CONCLUIDO', 'PENDIENTE')
go
if (select version from version) <= 1413
  update VentaCalc set IVAFiscal = ISNULL(CONVERT(float, NULLIF(Impuestos, 0))  / NULLIF(ImporteTotal, 0), 0.13043478260869565) WHERE IVAFiscal IS NULL AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
go

if (select version from version) <= 2080
  EXEC fixRHPlaza
go

if (select version from version) <= 2081
  EXEC fixCantidadPendiente
GO

if (select version from version) <= 2081
  EXEC fixAuxiliarConciliado
GO

if (select version from version) <= 2477
  TRUNCATE TABLE Acceso
GO

if (select version from version) <= 2508
  UPDATE VINAccesorio SET VIN = VIN
GO

if (select version from version) <= 2700
  EXEC fixContContacto
GO

if (select version from version) <= 2700
  EXEC fixInvCapaUP
GO

/**************** xpFinalMantenimiento ****************/
if not exists (select * from sysobjects where id = object_id('dbo.xpFinalMantenimiento') and type = 'P') 
BEGIN
  Declare @SQL varchar(255)
  SELECT @SQL= N'CREATE PROCEDURE xpFinalMantenimiento as BEGIN RETURN END'
  EXEC(@SQL)
END
GO

EXEC xpFinalMantenimiento
GO

/* Version */
DECLARE
  @Version int,
  @ID	   int,
  @Fecha   datetime,
  @SubVersion varchar(20)

SELECT @Version = 5000,
       @Fecha = CONVERT(datetime, '10/04/17', 1),  -- Mes / Dia / Año
       @ID = 571837,
       @SubVersion = '5000.v3'

UPDATE Version 
   SET Version = @Version, 
       Fecha = @Fecha, 
       ID = @ID,
       MantenimientoFin = GETDATE(),
       SubVersion = @SubVersion
IF @@ROWCOUNT = 0
  INSERT INTO Version (Version, Fecha, ID, Sucursal, SubVersion) VALUES (@Version, @Fecha, @ID, 0, @SubVersion)  
  
GO