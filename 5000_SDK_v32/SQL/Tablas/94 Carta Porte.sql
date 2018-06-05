SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO
/******************************      MovCartaPorte     *********************************/
if not exists (select * from sysobjects where id = object_id('dbo.MovCartaPorte') and type = 'U') 
CREATE TABLE MovCartaPorte (Estacion			int,
							Modulo				varchar(5),
							ModuloID			int,
							Mov					varchar(20),
							MovID				varchar(20),
							Sucursal			int,
							Almacen				varchar(10),
							Cliente				varchar(10),
							Condicion			varchar(50) NULL,
							FormaPago			varchar(50) NULL,
							Moneda				varchar(10),
							NoCertificado		varchar(20),
							NoCertificadoSAT	varchar(20),
							CadenaOriginal		text,
							UUID				varchar(50),
							FechaTimbrado		datetime,
							EmbarqueID			int, 
							Proveedor			varchar(10) NULL,
							Ruta				varchar(255),
							Observaciones		varchar(255) NULL,
							CONSTRAINT priMovCartaPorte PRIMARY KEY CLUSTERED(Estacion, Modulo, ModuloID)
							)
							
/******************************      MovCartaPorteD     *********************************/							
if not exists (select * from sysobjects where id = object_id('dbo.MovCartaPorteD') and type = 'U') 
CREATE TABLE MovCartaPorteD(Estacion			int,
							Modulo				varchar(5),
							ModuloID			int,
							Renglon				int,
							RenglonSub			int,
							Articulo			varchar(20),
							Cantidad			float,
							Unidad				varchar(50),
							Precio				float,
							Importe				float,
							Impuestos			float,
							Retenciones			float,
							CONSTRAINT priMovCartaPorteD PRIMARY KEY CLUSTERED(Estacion, Modulo, ModuloID, Renglon, RenglonSub)
							)
GO