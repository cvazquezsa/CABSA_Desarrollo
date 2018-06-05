SET ANSI_DEFAULTS OFF 
GO
EXEC spALTER_TABLE 'MovClave', 'SubClaveDe', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'MovTipo', 'SubClave', 'varchar(20) NULL'
GO

if not exists(select * from MovClave WHERE Clave = 'CFDI.TERCEROSCTE')
  insert MovClave (Modulo, NombreOmision, SubClaveDe, Clave) values ('VTAS', 'Factura CFDI Terceros Cliente','VTAS.F','CFDI.TERCEROSCTE')  
GO

--if not exists(select * from MovTipo WHERE Modulo = 'VTAS' AND Mov = 'Factura Terceros P')
--  insert MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) values ('VTAS', 4050, 'Factura Terceros', 'VTAS.F', 'VTAS.CFDITERCEROS', 'CXC', 'Factura Terceros')
GO

IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaDTercerosImpCte')				 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaDTercerosImpCte')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaDTercerosCte')					 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaDTercerosCte')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaDMovImpTercerosCte')             INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaDMovImpTercerosCte')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDPedimentosSinTercerosCte')            INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDPedimentosSinTercerosCte')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDSerieLoteMovTercerosCte')			 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDSerieLoteMovTercerosCte')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaDMovRetTercerosCte')			 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaDMovRetTercerosCte')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaDTercerosRetCte')				 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaDTercerosRetCte')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDTercerosImpGralCte')					 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDTercerosImpGralCte')

GO

/****** CFDVentaDCte ******/
if not exists(select * from SysTabla where SysTabla = 'CFDVentaDCte')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CFDVentaDCte','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.CFDVentaDCte') and type = 'U') 
CREATE TABLE dbo.CFDVentaDCte (
	ID 			int       	NOT NULL,
	Renglon			float	  	NOT NULL,
	RenglonSub		int		NOT NULL,
	Articulo			varchar(20) NULL,
	Cliente			varchar(20) NULL,

	CONSTRAINT priCFDVentaDCte PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO


if exists (select * from sysobjects where id = object_id('dbo.tgCFDVentaDCte') and sysstat & 0xf = 8) drop trigger dbo.tgCFDVentaDCte
GO
CREATE TRIGGER tgCFDVentaDCte ON VentaD
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN  
  DECLARE
    @ID		int,
    @Renglon	float,
    @RenglonSub int,
    @RenglonID int,
    @Articulo varchar(20),
    @Subcuenta varchar(20),
    @IDN		int,
    @RenglonN	float,
    @RenglonSubN int,
    @RenglonIDN int,
    @ArticuloN varchar(20),
    @SubcuentaN varchar(20)

  IF NOT UPDATE(Articulo) RETURN
   SELECT @ID = ID, @Renglon = Renglon, @RenglonSub = RenglonSub, @RenglonId = RenglonID, @Articulo = Articulo, @Subcuenta = Subcuenta FROM Deleted
   SELECT @IDN = ID, @RenglonN = Renglon, @RenglonSubN = RenglonSub, @RenglonIdN = RenglonID, @ArticuloN = Articulo, @SubcuentaN = Subcuenta FROM inserted
   
   IF @Articulo <> @ArticuloN
     UPDATE   CFDVentaDCte SET Articulo = @ArticuloN, Cliente  = NULL WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCFDVentaDCteBorrar') and sysstat & 0xf = 8) drop trigger dbo.tgCFDVentaDCteBorrar
GO
CREATE TRIGGER tgCFDVentaDCteBorrar ON VentaD
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Renglon	float,
    @RenglonSub int,
    @RenglonID int,
    @Articulo varchar(20),
    @Subcuenta varchar(20)
  
  SELECT @ID = ID, @Renglon = Renglon, @RenglonSub = RenglonSub, @RenglonId = RenglonID, @Articulo = Articulo, @Subcuenta = Subcuenta FROM Deleted
  DELETE CFDVentaDCte WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Articulo = @Articulo 

END
GO

/**************** xpCFDVentaDCopiarCliente ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDVentaDCopiarCliente') and type = 'P') drop procedure dbo.xpCFDVentaDCopiarCliente
GO             
CREATE PROCEDURE xpCFDVentaDCopiarCliente
			@ID						int

AS BEGIN

  IF NOT EXISTS (SELECT ID FROM CFDVentaDCte WHERE ID = @ID)
    INSERT INTO CFDVentaDCte (ID, Renglon, RenglonSub, Articulo) 
    SELECT  ID, REnglon, RenglonSub, Articulo FROM VentaD WHERE ID = @ID
  ELSE
    INSERT INTO CFDVentaDCte (ID, Renglon, RenglonSub, Articulo) 
    SELECT  d.ID, d.REnglon, d.RenglonSub, d.Articulo 
	  FROM VentaD d
      LEFT OUTER JOIN CFDVentaDCte p ON d.ID = p.ID AND d.Renglon = p.Renglon AND d.RenglonSub = p.RenglonSub AND d.Articulo = p.Articulo
	  WHERE d.ID = @ID AND p.ID IS NULL

RETURN
END
go

/***************** CFDVentaDTercerosCte *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDTercerosCte') AND TYPE = 'V') 
  DROP VIEW CFDVentaDTercerosCte
GO
CREATE VIEW dbo.CFDVentaDTercerosCte AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDCte.Cliente ))))) + RTRIM(CFDVentaDCte.Cliente) 
  OrdenExportacion, 
  CFDVentaDCte.Cliente ,
  VentaD.ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  VentaD.Articulo,
  Cte.RFC,
  Cte.Nombre,
  Cte.Direccion,
  Cte.DireccionNumero,
  Cte.DireccionNumeroInt,
  Cte.Colonia,
  Cte.Poblacion,
  Cte.EntreCalles,
  Cte.Delegacion,
  Cte.Estado,
  Cte.Pais,
  Cte.CodigoPostal,
  Cte.Telefonos
FROM VentaD 
  JOIN CFDVentaDCte ON CFDVentaDCte.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDCte.Renglon AND CFDVentaDCte.RenglonSub = VentaD.RenglonSub AND CFDVentaDCte.Articulo = VentaD.Articulo
  JOIN Cte ON CFDVentaDCte.Cliente  = Cte.Cliente  
GO

/***************** CFDTercerosImpGralCte *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDTercerosImpGralCte') AND TYPE = 'V') 
  DROP VIEW CFDTercerosImpGralCte
GO
CREATE VIEW dbo.CFDTercerosImpGralCte AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDCte.Cliente ))))) + RTRIM(CFDVentaDCte.Cliente ) + 
    RTRIM('zzimpuesto')
  OrdenExportacion, 
  VentaD.ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  VentaD.Articulo,
  Cte.RFC,
  Cte.Nombre,
  Cte.Direccion,
  Cte.DireccionNumero,
  Cte.DireccionNumeroInt,
  Cte.Colonia,
  Cte.Poblacion,
  Cte.EntreCalles,
  Cte.Delegacion,
  Cte.Estado,
  Cte.Pais,
  Cte.CodigoPostal,
  Cte.Telefonos
FROM VentaD 
  JOIN CFDVentaDCte ON CFDVentaDCte.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDCte.Renglon AND CFDVentaDCte.RenglonSub = VentaD.RenglonSub AND CFDVentaDCte.Articulo = VentaD.Articulo
  JOIN Cte ON CFDVentaDCte.Cliente  = Cte.Cliente  
GO

/***************** CFDVentaDTercerosImpCte *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDTercerosImpCte') AND TYPE = 'V') 
  DROP VIEW CFDVentaDTercerosImpCte
GO
CREATE VIEW dbo.CFDVentaDTercerosImpCte AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDCte.Cliente ))))) + RTRIM(CFDVentaDCte.Cliente ) + 
  + RTRIM('zzimpuesto')+  RTRIM('yyyy')
  OrdenExportacion, 
  VentaD.ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  VentaD.Articulo,
  Cte.RFC,
  Cte.Nombre,
  Cte.Direccion,
  Cte.DireccionNumero,
  Cte.DireccionNumeroInt,
  Cte.Colonia,
  Cte.Poblacion,
  Cte.EntreCalles,
  Cte.Delegacion,
  Cte.Estado,
  Cte.Pais,
  Cte.CodigoPostal,
  Cte.Telefonos
FROM VentaD 
  JOIN CFDVentaDCte ON CFDVentaDCte.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDCte.Renglon AND CFDVentaDCte.RenglonSub = VentaD.RenglonSub AND CFDVentaDCte.Articulo = VentaD.Articulo
  JOIN Cte ON CFDVentaDCte.Cliente  = Cte.Cliente  
GO

/***************** CFDVentaDMovImpTercerosCte *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDMovImpTercerosCte') AND TYPE = 'V') 
  DROP VIEW CFDVentaDMovImpTercerosCte
GO
CREATE VIEW dbo.CFDVentaDMovImpTercerosCte AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDCte.Cliente ))))) + RTRIM(CFDVentaDCte.Cliente ) + 
   + RTRIM('zzimpuesto')+   RTRIM('yyyy') +
  'IMPUESTO1' + REPLICATE(' ',50 - LEN('IMPUESTO1'))
  OrdenExportacion,
  VentaD.ID, 
  'VAT' VentaDImpuestoClave,
  'IVA' VentaDImpuesto,
  ISNULL(VentaD.Impuesto1,0.0) VentaDImpuestoTasa,
  CASE WHEN ISNULL(VentaD.Impuesto1,0.0) > 0.0 THEN (VentaD.Precio*(ISNULL(VentaD.Impuesto1,0.0)/100.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) ELSE 0.0 END VentaDImpuestoImporte,
  'TRANSFERIDO' VentaDCategoriaImpuesto
  FROM VentaD
JOIN Venta ON VentaD.ID = Venta.ID
JOIN CFDVentaDCte ON CFDVentaDCte.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDCte.Renglon AND CFDVentaDCte.RenglonSub = VentaD.RenglonSub AND CFDVentaDCte.Articulo = VentaD.Articulo
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
WHERE NULLIF(CFDVentaDCte.Cliente,'') IS NOT NULL
UNION ALL  
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDCte.Cliente ))))) + RTRIM(CFDVentaDCte.Cliente ) + 
  + RTRIM('zzimpuesto')+      RTRIM('yyyy') +
  'IMPUESTO2' + REPLICATE(' ',50 - LEN('IMPUESTO2'))
  OrdenExportacion,
  VentaD.ID, 
  'GST' VentaDImpuestoClave,
  'IEPS' VentaDImpuesto,
  ISNULL(VentaD.Impuesto2,0.0) VentaDImpuestoTasa,
  CASE WHEN ISNULL(VentaD.Impuesto2,0.0) > 0.0 THEN (VentaD.Precio/(ISNULL(VentaD.Impuesto2,0.0)/100.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) ELSE 0.0 END VentaDImpuestoImporte,
  'TRANSFERIDO' VentaDCategoriaImpuesto  
  FROM VentaD  
JOIN Venta ON VentaD.ID = Venta.ID
JOIN CFDVentaDCte ON CFDVentaDCte.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDCte.Renglon AND CFDVentaDCte.RenglonSub = VentaD.RenglonSub AND CFDVentaDCte.Articulo = VentaD.Articulo
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
WHERE NULLIF(CFDVentaDCte.Cliente,'') IS NOT NULL

GO

/***************** CFDPedimentosSinTercerosCte *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('CFDPedimentosSinTercerosCte') AND TYPE = 'V') 
  DROP VIEW CFDPedimentosSinTercerosCte
GO
CREATE VIEW dbo.CFDPedimentosSinTercerosCte AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  RTRIM(SerieLoteMov.SerieLote) + REPLICATE (' ', 50 - LEN(RTRIM(SerieLoteMov.SerieLote)))
  OrdenExportacion, 
  SerieLoteMov.ID ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  SerieLoteMov.SerieLote,
  SerieLoteMov.Cantidad,
  SerieLoteMov.Propiedades,
  SerieLoteMov.Ubicacion,
  SerieLoteMov.Localizacion,
  SerieLoteMov.ArtCostoInv,
  SerieLoteprop.Fecha1,
  SerieLoteprop.Fecha2,
  SerieLoteprop.Fecha3,
  SerieLoteprop.PedimentoClave,
  SerieLoteprop.PedimentoRegimen,
  SerieLoteprop.AgenteAduanal,
  SerieLoteprop.Aduana,
  SerieLoteprop.PedimentoTipo,
  Aduana.GLN AduanaGLN
  FROM SerieLoteMov JOIN VentaD
    ON SerieLoteMov.ID = VentaD.ID AND SerieLoteMov.RenglonID = VentaD.RenglonID
    JOIN SerieLoteProp ON SerieLoteMov.Propiedades = SerieLoteProp.Propiedades
    LEFT OUTER JOIN Aduana ON SerieLoteProp.Aduana = Aduana.Aduana
    LEFT OUTER JOIN CFDVentaDCte ON CFDVentaDCte.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDCte.Renglon AND CFDVentaDCte.RenglonSub = VentaD.RenglonSub AND CFDVentaDCte.Articulo = VentaD.Articulo

  WHERE SerieLoteMov.Modulo = 'VTAS' and CFDVentaDCte.Cliente  is null

GO


/***************** CFDSerieLoteMovTercerosCte *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDSerieLoteMovTercerosCte') AND TYPE = 'V') 
  DROP VIEW CFDSerieLoteMovTercerosCte
GO
CREATE VIEW CFDSerieLoteMovTercerosCte AS   
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDCte.Cliente ))))) +RTRIM(CFDVentaDCte.Cliente ) + 
  RTRIM(SerieLoteMov.SerieLote) + REPLICATE (' ', 50 - LEN(RTRIM(SerieLoteMov.SerieLote)))
  OrdenExportacion, 
  SerieLoteMov.ID ID,
  SerieLoteMov.SerieLote,
  SerieLoteMov.Cantidad,
  SerieLoteMov.Propiedades,
  SerieLoteMov.Ubicacion,
  SerieLoteMov.Localizacion,
  SerieLoteMov.ArtCostoInv,
  SerieLoteprop.Fecha1,
  SerieLoteprop.Fecha2,
  SerieLoteprop.Fecha3,
  SerieLoteprop.PedimentoClave,
  SerieLoteprop.PedimentoRegimen,
  SerieLoteprop.AgenteAduanal,
  SerieLoteprop.Aduana,
  SerieLoteprop.PedimentoTipo,
  Aduana.GLN AduanaGLN
  FROM SerieLoteMov JOIN VentaD
    ON SerieLoteMov.ID = VentaD.ID AND SerieLoteMov.RenglonID = VentaD.RenglonID
    LEFT OUTER JOIN SerieLoteProp ON SerieLoteMov.Propiedades = SerieLoteProp.Propiedades
    LEFT OUTER JOIN Aduana ON SerieLoteProp.Aduana = Aduana.Aduana
    JOIN CFDVentaDCte ON CFDVentaDCte.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDCte.Renglon AND CFDVentaDCte.RenglonSub = VentaD.RenglonSub AND CFDVentaDCte.Articulo = VentaD.Articulo
    JOIN Cte ON CFDVentaDCte.Cliente  = Cte.Cliente  
  WHERE SerieLoteMov.Modulo = 'VTAS'
GO



/***************** CFDVentaDTercerosRetCte*******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDTercerosRetCte') AND TYPE = 'V') 
  DROP VIEW CFDVentaDTercerosRetCte
GO
CREATE VIEW dbo.CFDVentaDTercerosRetCte AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDCte.Cliente ))))) + RTRIM(CFDVentaDCte.Cliente ) + 
  + RTRIM('zzimpuesto')+    RTRIM('xy')
  OrdenExportacion, 
  VentaD.ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  VentaD.Articulo,
  Cte.RFC,
  Cte.Nombre,
  Cte.Direccion,
  Cte.DireccionNumero,
  Cte.DireccionNumeroInt,
  Cte.Colonia,
  Cte.Poblacion,
  Cte.EntreCalles,
  Cte.Delegacion,
  Cte.Estado,
  Cte.Pais,
  Cte.CodigoPostal,
  Cte.Telefonos
FROM VentaD 
  JOIN CFDVentaDCte ON CFDVentaDCte.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDCte.Renglon AND CFDVentaDCte.RenglonSub = VentaD.RenglonSub AND CFDVentaDCte.Articulo = VentaD.Articulo
  JOIN Cte ON CFDVentaDCte.Cliente  = Cte.Cliente  
WHERE ISNULL(VentaD.Retencion2,0.0) > 0.0 OR ISNULL(VentaD.Retencion1,0.0) > 0.0
GO

/***************** CFDVentaDMovRetTercerosCte *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDMovRetTercerosCte') AND TYPE = 'V') 
  DROP VIEW CFDVentaDMovRetTercerosCte
GO
CREATE VIEW dbo.CFDVentaDMovRetTercerosCte AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDCte.Cliente ))))) + RTRIM(CFDVentaDCte.Cliente ) + 
   + RTRIM('zzimpuesto')+   RTRIM('xy') +
  'RETENCION2' + REPLICATE(' ',50 - LEN('RETENCION2'))
  OrdenExportacion,
  VentaD.ID, 
  CFDVentaDCte.Cliente ,
  'VAT' VentaDRetencionClave,
  'IVA' VentaDRetencion,
  ISNULL(VentaD.Retencion2,0.0) VentaDImpuestoTasa,
  CASE WHEN ISNULL(VentaD.Retencion2,0.0) > 0.0 THEN (VentaD.Precio*(ISNULL(VentaD.Retencion2,0.0)/100.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) ELSE 0.0 END VentaDRetencionImporte,
  'RETENIDO' VentaDCategoriaRetencion
  FROM VentaD
JOIN Venta ON VentaD.ID = Venta.ID
JOIN CFDVentaDCte ON CFDVentaDCte.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDCte.Renglon AND CFDVentaDCte.RenglonSub = VentaD.RenglonSub AND CFDVentaDCte.Articulo = VentaD.Articulo
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
WHERE NULLIF(CFDVentaDCte.Cliente,'') IS NOT NULL
AND ISNULL(VentaD.Retencion2,0.0) > 0.0
UNION ALL  
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDCte.Cliente ))))) + RTRIM(CFDVentaDCte.Cliente ) + 
  + RTRIM('zzimpuesto')+      RTRIM('xy') +
  'RETENCION1' + REPLICATE(' ',50 - LEN('RETENCION1'))
  OrdenExportacion,
  VentaD.ID, 
  CFDVentaDCte.Cliente ,
  'ISR' VentaDRetencionClave,
  'ISR' VentaDRetencion,
  ISNULL(VentaD.Retencion1,0.0) VentaDRetencionTasa,
  CASE WHEN ISNULL(VentaD.Retencion1,0.0) > 0.0 THEN (VentaD.Precio*(ISNULL(VentaD.Retencion1,0.0)/100.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) ELSE 0.0 END VentaDRetencionImporte,
  'RETENIDO' VentaDCategoriaRetencion
  FROM VentaD  
JOIN Venta ON VentaD.ID = Venta.ID
JOIN CFDVentaDCte ON CFDVentaDCte.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDCte.Renglon AND CFDVentaDCte.RenglonSub = VentaD.RenglonSub AND CFDVentaDCte.Articulo = VentaD.Articulo
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
WHERE NULLIF(CFDVentaDCte.Cliente,'') IS NOT NULL
AND ISNULL(VentaD.Retencion1,0.0) > 0.0
GO



/****TERCEROS_PROVEEDOR*/
if not exists(select * from MovClave WHERE Clave = 'CFDI.TERCEROSPROV')
  insert MovClave (Modulo, NombreOmision, SubClaveDe, Clave) values ('VTAS', 'Factura CFDI Terceros Proveedor','VTAS.F','CFDI.TERCEROSPROV')
GO

--if not exists(select * from MovTipo WHERE Modulo = 'VTAS' AND Mov = 'Factura Terceros P')
--  insert MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) values ('VTAS', 4050, 'Factura Terceros', 'VTAS.F', 'VTAS.CFDITERCEROS', 'CXC', 'Factura Terceros')
GO

IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaDTercerosImp')				 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaDTercerosImp')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaDTerceros')					 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaDTerceros')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaDMovImpTerceros')             INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaDMovImpTerceros')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDPedimentosSinTerceros')            INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDPedimentosSinTerceros')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDSerieLoteMovTerceros')			 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDSerieLoteMovTerceros')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaDMovRetTerceros')			 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaDMovRetTerceros')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaDTercerosRet')				 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaDTercerosRet')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDTercerosImpGral')					 INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDTercerosImpGral')

GO


/****** CFDVentaDProv ******/
if not exists(select * from SysTabla where SysTabla = 'CFDVentaDProv')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CFDVentaDProv','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.CFDVentaDProv') and type = 'U') 
CREATE TABLE dbo.CFDVentaDProv (
	ID 			int       	NOT NULL,
	Renglon			float	  	NOT NULL,
	RenglonSub		int		NOT NULL,
	Articulo			varchar(20) NULL,
	Proveedor			varchar(20) NULL,

	CONSTRAINT priCFDVentaDProv PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO
/************** tgCFDVentaDProveedor ***********/
if exists (select * from sysobjects where id = object_id('dbo.tgCFDVentaDProveedor') and sysstat & 0xf = 8) drop trigger dbo.tgCFDVentaDProveedor
GO
CREATE TRIGGER tgCFDVentaDProveedor ON CFDVentaDProv
--//WITH ENCRYPTION
FOR INSERT,Update
AS BEGIN
  

  DECLARE
    @Proveedor		varchar(20)
  SELECT @Proveedor = Proveedor FROM Inserted
  IF @Proveedor is not null and  NOT EXISTS (SELECT Proveedor FROM Prov WHERE Proveedor = @Proveedor)
  BEGIN
    RAISERROR('El Proveedor no existe',16,-1)     
  END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCFDVentaDProv') and sysstat & 0xf = 8) drop trigger dbo.tgCFDVentaDProv
GO
CREATE TRIGGER tgCFDVentaDProv ON VentaD
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN  
  DECLARE
    @ID		int,
    @Renglon	float,
    @RenglonSub int,
    @RenglonID int,
    @Articulo varchar(20),
    @Subcuenta varchar(20),
    @IDN		int,
    @RenglonN	float,
    @RenglonSubN int,
    @RenglonIDN int,
    @ArticuloN varchar(20),
    @SubcuentaN varchar(20)

  IF NOT UPDATE(Articulo) RETURN
   SELECT @ID = ID, @Renglon = Renglon, @RenglonSub = RenglonSub, @RenglonId = RenglonID, @Articulo = Articulo, @Subcuenta = Subcuenta FROM Deleted
   SELECT @IDN = ID, @RenglonN = Renglon, @RenglonSubN = RenglonSub, @RenglonIdN = RenglonID, @ArticuloN = Articulo, @SubcuentaN = Subcuenta FROM inserted
   
   IF @Articulo <> @ArticuloN
     UPDATE   CFDVentaDProv SET Articulo = @ArticuloN, Proveedor = NULL WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCFDVentaDprovBorrar') and sysstat & 0xf = 8) drop trigger dbo.tgCFDVentaDprovBorrar
GO
CREATE TRIGGER tgCFDVentaDprovBorrar ON VentaD
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Renglon	float,
    @RenglonSub int,
    @RenglonID int,
    @Articulo varchar(20),
    @Subcuenta varchar(20)
  
  SELECT @ID = ID, @Renglon = Renglon, @RenglonSub = RenglonSub, @RenglonId = RenglonID, @Articulo = Articulo, @Subcuenta = Subcuenta FROM Deleted
  DELETE CFDVentaDProv WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Articulo = @Articulo 

END
GO


/**************** xpCFDVentaDCopiarProvedor ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDVentaDCopiarProvedor') and type = 'P') drop procedure dbo.xpCFDVentaDCopiarProvedor
GO             
CREATE PROCEDURE xpCFDVentaDCopiarProvedor
			@ID						int

AS BEGIN

  IF NOT EXISTS (SELECT ID FROM CFDVentaDProv WHERE ID = @ID)
    INSERT INTO CFDVentaDProv (ID, Renglon, RenglonSub, Articulo) 
    SELECT  ID, REnglon, RenglonSub, Articulo FROM VentaD WHERE ID = @ID
  ELSE
    INSERT INTO CFDVentaDProv (ID, Renglon, RenglonSub, Articulo) 
    SELECT  d.ID, d.REnglon, d.RenglonSub, d.Articulo 
	  FROM VentaD d
      LEFT OUTER JOIN CFDVentaDProv p ON d.ID = p.ID AND d.Renglon = p.Renglon AND d.RenglonSub = p.RenglonSub AND d.Articulo = p.Articulo
	  WHERE d.ID = @ID AND p.ID IS NULL

RETURN
END
go




/***************** CFDVentaDTerceros *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDTerceros') AND TYPE = 'V') 
  DROP VIEW CFDVentaDTerceros
GO
CREATE VIEW dbo.CFDVentaDTerceros AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDProv.Proveedor))))) + RTRIM(CFDVentaDProv.Proveedor) 
  OrdenExportacion, 
  CFDVentaDProv.Proveedor,
  VentaD.ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  VentaD.Articulo,
  Prov.RFC,
  Prov.Nombre,
  Prov.Direccion,
  Prov.DireccionNumero,
  Prov.DireccionNumeroInt,
  Prov.Colonia,
  Prov.Poblacion,
  Prov.EntreCalles,
  Prov.Delegacion,
  Prov.Estado,
  Prov.Pais,
  Prov.CodigoPostal,
  Prov.Telefonos
FROM VentaD 
  JOIN CFDVentaDProv ON CFDVentaDProv.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDProv.Renglon AND CFDVentaDProv.RenglonSub = VentaD.RenglonSub AND CFDVentaDProv.Articulo = VentaD.Articulo
  JOIN prov ON CFDVentaDprov.Proveedor = Prov.Proveedor 
GO


/***************** CFDTercerosImpGral *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDTercerosImpGral') AND TYPE = 'V') 
  DROP VIEW CFDTercerosImpGral
GO
CREATE VIEW dbo.CFDTercerosImpGral AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDProv.Proveedor))))) + RTRIM(CFDVentaDProv.Proveedor) + 
    RTRIM('zzimpuesto')
  OrdenExportacion, 
  VentaD.ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  VentaD.Articulo,
  Prov.RFC,
  Prov.Nombre,
  Prov.Direccion,
  Prov.DireccionNumero,
  Prov.DireccionNumeroInt,
  Prov.Colonia,
  Prov.Poblacion,
  Prov.EntreCalles,
  Prov.Delegacion,
  Prov.Estado,
  Prov.Pais,
  Prov.CodigoPostal,
  Prov.Telefonos
FROM VentaD 
  JOIN CFDVentaDProv ON CFDVentaDProv.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDProv.Renglon AND CFDVentaDProv.RenglonSub = VentaD.RenglonSub AND CFDVentaDProv.Articulo = VentaD.Articulo
  JOIN prov ON CFDVentaDprov.Proveedor = Prov.Proveedor 
GO



/***************** CFDVentaDTercerosImp *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDTercerosImp') AND TYPE = 'V') 
  DROP VIEW CFDVentaDTercerosImp
GO
CREATE VIEW dbo.CFDVentaDTercerosImp AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDProv.Proveedor))))) + RTRIM(CFDVentaDProv.Proveedor) + 
  + RTRIM('zzimpuesto')+  RTRIM('yyyy')
  OrdenExportacion, 
  VentaD.ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  VentaD.Articulo,
  Prov.RFC,
  Prov.Nombre,
  Prov.Direccion,
  Prov.DireccionNumero,
  Prov.DireccionNumeroInt,
  Prov.Colonia,
  Prov.Poblacion,
  Prov.EntreCalles,
  Prov.Delegacion,
  Prov.Estado,
  Prov.Pais,
  Prov.CodigoPostal,
  Prov.Telefonos
FROM VentaD 
  JOIN CFDVentaDProv ON CFDVentaDProv.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDProv.Renglon AND CFDVentaDProv.RenglonSub = VentaD.RenglonSub AND CFDVentaDProv.Articulo = VentaD.Articulo
  JOIN prov ON CFDVentaDprov.Proveedor = Prov.Proveedor 
GO



/***************** CFDVentaDMovImpTerceros *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDMovImpTerceros') AND TYPE = 'V') 
  DROP VIEW CFDVentaDMovImpTerceros
GO
CREATE VIEW dbo.CFDVentaDMovImpTerceros AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDProv.Proveedor))))) + RTRIM(CFDVentaDProv.Proveedor) + 
   + RTRIM('zzimpuesto')+   RTRIM('yyyy') +
  'IMPUESTO1' + REPLICATE(' ',50 - LEN('IMPUESTO1'))
  OrdenExportacion,
  VentaD.ID, 
  'VAT' VentaDImpuestoClave,
  'IVA' VentaDImpuesto,
  ISNULL(VentaD.Impuesto1,0.0) VentaDImpuestoTasa,
  CASE WHEN ISNULL(VentaD.Impuesto1,0.0) > 0.0 THEN (VentaD.Precio*(ISNULL(VentaD.Impuesto1,0.0)/100.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) ELSE 0.0 END VentaDImpuestoImporte,
  'TRANSFERIDO' VentaDCategoriaImpuesto
  FROM VentaD
JOIN Venta ON VentaD.ID = Venta.ID
JOIN CFDVentaDProv ON CFDVentaDProv.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDProv.Renglon AND CFDVentaDProv.RenglonSub = VentaD.RenglonSub AND CFDVentaDProv.Articulo = VentaD.Articulo
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
WHERE NULLIF(CFDVentaDProv.Proveedor,'') IS NOT NULL
UNION ALL  
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDProv.Proveedor))))) + RTRIM(CFDVentaDProv.Proveedor) + 
  + RTRIM('zzimpuesto')+      RTRIM('yyyy') +
  'IMPUESTO2' + REPLICATE(' ',50 - LEN('IMPUESTO2'))
  OrdenExportacion,
  VentaD.ID, 
  'GST' VentaDImpuestoClave,
  'IEPS' VentaDImpuesto,
  ISNULL(VentaD.Impuesto2,0.0) VentaDImpuestoTasa,
  CASE WHEN ISNULL(VentaD.Impuesto2,0.0) > 0.0 THEN (VentaD.Precio/(ISNULL(VentaD.Impuesto2,0.0)/100.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) ELSE 0.0 END VentaDImpuestoImporte,
  'TRANSFERIDO' VentaDCategoriaImpuesto  
  FROM VentaD  
JOIN Venta ON VentaD.ID = Venta.ID
JOIN CFDVentaDProv ON CFDVentaDProv.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDProv.Renglon AND CFDVentaDProv.RenglonSub = VentaD.RenglonSub AND CFDVentaDProv.Articulo = VentaD.Articulo
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
WHERE NULLIF(CFDVentaDProv.Proveedor,'') IS NOT NULL

GO

/***************** CFDPedimentosSinTerceros *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('CFDPedimentosSinTerceros') AND TYPE = 'V') 
  DROP VIEW CFDPedimentosSinTerceros
GO
CREATE VIEW dbo.CFDPedimentosSinTerceros AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  RTRIM(SerieLoteMov.SerieLote) + REPLICATE (' ', 50 - LEN(RTRIM(SerieLoteMov.SerieLote)))
  OrdenExportacion, 
  SerieLoteMov.ID ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  SerieLoteMov.SerieLote,
  SerieLoteMov.Cantidad,
  SerieLoteMov.Propiedades,
  SerieLoteMov.Ubicacion,
  SerieLoteMov.Localizacion,
  SerieLoteMov.ArtCostoInv,
  SerieLoteprop.Fecha1,
  SerieLoteprop.Fecha2,
  SerieLoteprop.Fecha3,
  SerieLoteprop.PedimentoClave,
  SerieLoteprop.PedimentoRegimen,
  SerieLoteprop.AgenteAduanal,
  SerieLoteprop.Aduana,
  SerieLoteprop.PedimentoTipo,
  Aduana.GLN AduanaGLN
  FROM SerieLoteMov JOIN VentaD
    ON SerieLoteMov.ID = VentaD.ID AND SerieLoteMov.RenglonID = VentaD.RenglonID
    JOIN SerieLoteProp ON SerieLoteMov.Propiedades = SerieLoteProp.Propiedades
    LEFT OUTER JOIN Aduana ON SerieLoteProp.Aduana = Aduana.Aduana
    LEFT OUTER JOIN CFDVentaDProv ON CFDVentaDProv.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDProv.Renglon AND CFDVentaDProv.RenglonSub = VentaD.RenglonSub AND CFDVentaDProv.Articulo = VentaD.Articulo

  WHERE SerieLoteMov.Modulo = 'VTAS' and CFDVentaDProv.Proveedor is null

GO

/***************** CFDSerieLoteMovTerceros *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDSerieLoteMovTerceros') AND TYPE = 'V') 
  DROP VIEW CFDSerieLoteMovTerceros
GO
CREATE VIEW CFDSerieLoteMovTerceros AS   
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDProv.Proveedor))))) +RTRIM(CFDVentaDProv.Proveedor) + 
  RTRIM(SerieLoteMov.SerieLote) + REPLICATE (' ', 50 - LEN(RTRIM(SerieLoteMov.SerieLote)))
  OrdenExportacion, 
  SerieLoteMov.ID ID,
  SerieLoteMov.SerieLote,
  SerieLoteMov.Cantidad,
  SerieLoteMov.Propiedades,
  SerieLoteMov.Ubicacion,
  SerieLoteMov.Localizacion,
  SerieLoteMov.ArtCostoInv,
  SerieLoteprop.Fecha1,
  SerieLoteprop.Fecha2,
  SerieLoteprop.Fecha3,
  SerieLoteprop.PedimentoClave,
  SerieLoteprop.PedimentoRegimen,
  SerieLoteprop.AgenteAduanal,
  SerieLoteprop.Aduana,
  SerieLoteprop.PedimentoTipo,
  Aduana.GLN AduanaGLN
  FROM SerieLoteMov JOIN VentaD
    ON SerieLoteMov.ID = VentaD.ID AND SerieLoteMov.RenglonID = VentaD.RenglonID
    JOIN SerieLoteProp ON SerieLoteMov.Propiedades = SerieLoteProp.Propiedades
    LEFT OUTER JOIN Aduana ON SerieLoteProp.Aduana = Aduana.Aduana
    JOIN CFDVentaDProv ON CFDVentaDProv.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDProv.Renglon AND CFDVentaDProv.RenglonSub = VentaD.RenglonSub AND CFDVentaDProv.Articulo = VentaD.Articulo
    JOIN prov ON CFDVentaDprov.Proveedor = Prov.Proveedor 
  WHERE SerieLoteMov.Modulo = 'VTAS'
GO



/***************** CFDVentaDTercerosRet*******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDTercerosRet') AND TYPE = 'V') 
  DROP VIEW CFDVentaDTercerosRet
GO
CREATE VIEW dbo.CFDVentaDTercerosRet AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDProv.Proveedor))))) + RTRIM(CFDVentaDProv.Proveedor) + 
  + RTRIM('zzimpuesto')+    RTRIM('xy')
  OrdenExportacion, 
  VentaD.ID,
  VentaD.Renglon,
  VentaD.RenglonSub,
  VentaD.Articulo,
  Prov.RFC,
  Prov.Nombre,
  Prov.Direccion,
  Prov.DireccionNumero,
  Prov.DireccionNumeroInt,
  Prov.Colonia,
  Prov.Poblacion,
  Prov.EntreCalles,
  Prov.Delegacion,
  Prov.Estado,
  Prov.Pais,
  Prov.CodigoPostal,
  Prov.Telefonos
FROM VentaD 
  JOIN CFDVentaDProv ON CFDVentaDProv.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDProv.Renglon AND CFDVentaDProv.RenglonSub = VentaD.RenglonSub AND CFDVentaDProv.Articulo = VentaD.Articulo
  JOIN prov ON CFDVentaDprov.Proveedor = Prov.Proveedor 
WHERE ISNULL(VentaD.Retencion2,0.0) > 0.0 OR ISNULL(VentaD.Retencion1,0.0) > 0.0
GO

/***************** CFDVentaDMovRetTerceros *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDVentaDMovRetTerceros') AND TYPE = 'V') 
  DROP VIEW CFDVentaDMovRetTerceros
GO
CREATE VIEW dbo.CFDVentaDMovRetTerceros AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDProv.Proveedor))))) + RTRIM(CFDVentaDProv.Proveedor) + 
   + RTRIM('zzimpuesto')+   RTRIM('xy') +
  'RETENCION2' + REPLICATE(' ',50 - LEN('RETENCION2'))
  OrdenExportacion,
  VentaD.ID, 
  CFDVentaDProv.Proveedor,
  'VAT' VentaDRetencionClave,
  'IVA' VentaDRetencion,
  ISNULL(VentaD.Retencion2,0.0) VentaDImpuestoTasa,
  CASE WHEN ISNULL(VentaD.Retencion2,0.0) > 0.0 THEN (VentaD.Precio*(ISNULL(VentaD.Retencion2,0.0)/100.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) ELSE 0.0 END VentaDRetencionImporte,
  'RETENIDO' VentaDCategoriaRetencion
  FROM VentaD
JOIN Venta ON VentaD.ID = Venta.ID
JOIN CFDVentaDProv ON CFDVentaDProv.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDProv.Renglon AND CFDVentaDProv.RenglonSub = VentaD.RenglonSub AND CFDVentaDProv.Articulo = VentaD.Articulo
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
WHERE NULLIF(CFDVentaDProv.Proveedor,'') IS NOT NULL
AND ISNULL(VentaD.Retencion2,0.0) > 0.0
UNION ALL  
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,VentaD.RenglonSub))) +
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,CFDVentaDProv.Proveedor))))) + RTRIM(CFDVentaDProv.Proveedor) + 
  + RTRIM('zzimpuesto')+      RTRIM('xy') +
  'RETENCION1' + REPLICATE(' ',50 - LEN('RETENCION1'))
  OrdenExportacion,
  VentaD.ID, 
  CFDVentaDProv.Proveedor,
  'ISR' VentaDRetencionClave,
  'ISR' VentaDRetencion,
  ISNULL(VentaD.Retencion1,0.0) VentaDRetencionTasa,
  CASE WHEN ISNULL(VentaD.Retencion1,0.0) > 0.0 THEN (VentaD.Precio*(ISNULL(VentaD.Retencion1,0.0)/100.0))*dbo.fnCFDTipoCambioMN(Venta.TipoCambio, ISNULL(mt.SAT_MN, EmpresaCFD.SAT_MN)) ELSE 0.0 END VentaDRetencionImporte,
  'RETENIDO' VentaDCategoriaRetencion
  FROM VentaD  
JOIN Venta ON VentaD.ID = Venta.ID
JOIN CFDVentaDProv ON CFDVentaDProv.ID = VentaD.ID AND VentaD.Renglon = CFDVentaDProv.Renglon AND CFDVentaDProv.RenglonSub = VentaD.RenglonSub AND CFDVentaDProv.Articulo = VentaD.Articulo
JOIN EmpresaCFD ON Venta.Empresa = EmpresaCFD.Empresa
JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = Venta.Mov
WHERE NULLIF(CFDVentaDProv.Proveedor,'') IS NOT NULL
AND ISNULL(VentaD.Retencion1,0.0) > 0.0
GO



