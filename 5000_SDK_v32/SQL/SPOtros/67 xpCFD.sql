
EXEC spALTER_TABLE 'MovClave', 'SubClaveDe', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'MovTipo', 'SubClave', 'varchar(20) NULL'
GO
/*******************************************************************************************/
/*                             DIRECCIONES FISCALES SAT                                    */
/*******************************************************************************************/
EXEC spALTER_COLUMN 'Sucursal', 'Colonia', 'varchar(100) NULL'
EXEC spALTER_COLUMN 'Empresa', 'Colonia', 'varchar(100) NULL'
GO
EXEC spALTER_TABLE 'Venta', 'Posicion', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'CteCFD', 'NumRegIdTrib', 'varchar(40) NULL'
EXEC spALTER_TABLE 'Condicion', 'DiferirFechaAcumulacion', 'bit NULL default 0'
EXEC spALTER_TABLE 'TipoImpuesto', 'Clave', 'varchar(5)'
GO
EXEC spALTER_TABLE 'SerieLoteProp', 'FracccionArancelaria', 'varchar(20) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'PesoBruto', 'float NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'UnidadAduana', 'varchar(20) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'CantidadAduana', 'float NULL'
GO
EXEC spALTER_TABLE 'SerieLoteProp', 'FracccionArancelaria2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'PesoBruto2', 'float NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'UnidadAduana2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'CantidadAduana2', 'float NULL'
GO
EXEC spALTER_TABLE 'SerieLoteProp', 'Clave', 'varchar(21) NULL'
EXEC spALTER_COLUMN 'SerieLoteProp', 'Clave2', 'varchar(21) NULL'
GO
EXEC spALTER_TABLE 'SerieLoteProp', 'ContribOFP', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ContribEfectivo', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ContribTotal', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'Contraprestacion', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ImporteTotal', 'money NULL'
GO
EXEC spALTER_COLUMN 'SerieLoteProp', 'ContribOFP', 'money NULL'
EXEC spALTER_COLUMN 'SerieLoteProp', 'ContribEfectivo', 'money NULL'
EXEC spALTER_COLUMN 'SerieLoteProp', 'ContribTotal', 'money NULL'
EXEC spALTER_COLUMN 'SerieLoteProp', 'Contraprestacion', 'money NULL'
EXEC spALTER_COLUMN 'SerieLoteProp', 'ImporteTotal', 'money NULL'
GO
EXEC spALTER_TABLE 'CteEnviarA', 'TipoProceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'TipoComite', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'IdContabilidad', 'varchar(6) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'ClaveEntidad', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'Ambito', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'EntidadIdContabilidad', 'varchar(6) NULL'
GO
EXEC spALTER_TABLE 'CteCFD', 'TipoComplemento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteCFD', 'TipoProceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteCFD', 'TipoComite', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteCFD', 'IdContabilidad', 'varchar(6) NULL'
EXEC spALTER_TABLE 'CteCFD', 'ClaveEntidad', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteCFD', 'Ambito', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteCFD', 'EntidadIdContabilidad', 'varchar(6) NULL'
GO
EXEC spALTER_TABLE  'Empresa', 'TipoOperacion',             'varchar(100) NULL'
EXEC spALTER_TABLE  'Empresa', 'ClavePedimento',            'varchar(100) NULL'
EXEC spALTER_TABLE  'Empresa', 'CertificadoOrigen',         'varchar(100) NULL'
EXEC spALTER_TABLE  'Empresa', 'NumCertificadoOrigen',      'varchar(50)  NULL'
EXEC spALTER_TABLE  'Empresa', 'NumeroExportadorConfiable', 'varchar(50)  NULL'
GO

if not exists(select * from MovClave WHERE Clave = 'CFDI.TERCEROSPROV')
  insert MovClave (Modulo, NombreOmision, SubClaveDe, Clave) values ('VTAS', 'Factura CFDI Terceros Proveedor','VTAS.F','CFDI.TERCEROSPROV')
GO

--if not exists(select * from MovTipo WHERE Modulo = 'VTAS' AND Mov = 'Factura Terceros P')
--  insert MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) values ('VTAS', 4050, 'Factura Terceros', 'VTAS.F', 'VTAS.CFDITERCEROS', 'CXC', 'Factura Terceros')
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

/**************** xpCFDSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDSerieLote') and type = 'P') drop procedure dbo.xpCFDSerieLote
GO             
CREATE PROCEDURE xpCFDSerieLote
			@Empresa			char(5),
			@Modulo				char(5),
			@ID				int,
			@Renglon			float,
			@RenglonSub			int,
			@RenglonID			int,
			@RenglonTipo			char(1),
			@Articulo			varchar(20),
			@SubCuenta			varchar(50),
			@TipoAddenda 			varchar(50), 
			@LayOut 			varchar(50), 
			@SerieLote			varchar(50),
			@Pedimento			varchar(20) 	OUTPUT, 
			@PedimentoFecha			datetime 	OUTPUT, 
			@Aduana				varchar(50) 	OUTPUT
			
AS BEGIN
  DECLARE @ProveedorTercero varchar(20),
		  @Mov				varchar(20),
		  @MovTipoSubClave  varchar(20),
		  @ClienteTercero varchar(20)
  
   EXEC spMovInfo @ID, @Modulo, @Mov OUTPUT
	SELECT  @MovTipoSubClave = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
	IF @Modulo = 'VTAS'  AND @MovTipoSubClave = 'CFDI.TERCEROSPROV' 
	BEGIN
	  SELECT @ProveedorTercero = Proveedor FROM CFDVentaDProv WHERE ID = @ID AND REnglon = @Renglon AND RenglonSub = @RenglonSub AND Articulo = @Articulo
	  IF NULLIF(@ProveedorTercero,'') IS NOT NULL  SELECT @Pedimento = NULL	 	
	END 
	ELSE IF @Modulo = 'VTAS'  AND @MovTipoSubClave = 'CFDI.TERCEROSCTE' 
	BEGIN 
      SELECT @ClienteTercero = Cliente FROM CFDVentaDCte WHERE ID = @ID AND REnglon = @Renglon AND RenglonSub = @RenglonSub AND Articulo = @Articulo
      IF NULLIF(@ClienteTercero,'') IS NOT NULL  SELECT @Pedimento = NULL
	END 
  RETURN
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



SET NOCOUNT ON
SET ANSI_NULLS OFF
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



SET NOCOUNT ON
SET ANSI_NULLS OFF
GO


/**************** xpConceptoComplemento ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpConceptoComplemento') and type = 'P') drop procedure dbo.xpConceptoComplemento
GO             
CREATE PROCEDURE xpConceptoComplemento
			@Estacion				int,
			@Modulo					char(5),
			@ID						int,
			@Layout					varchar(20),
			@Validar				bit,
			@Version				varchar(10), 
			@Renglon				float, 
			@RenglonSub				int, 
			@Codigo 				varchar(30), 
			@Unidad 				varchar(50), 
			@UnidadClave 			varchar(50), 
			@UnidadFactor 			float, 
			@Articulo 				varchar(20), 
			@SubCuenta 				varchar(50), 
			@ArtDescripcion1 		varchar(255), 
			@ArtDescripcion2 		varchar(255), 
			@ArtTipoEmpaque 		varchar(50), 
			@TipoEmpaqueClave 		varchar(20), 
			@TipoEmpaqueTipo 		varchar(20),
			@Paquetes 				int, 
    		@CantidadEmpaque		float,
			@EAN13 					varchar(20), 
			@DUN14 					varchar(20), 
			@SKUCliente				varchar(20), 
			@SKUEmpresa				varchar(20), 
			@noIdentificacion 		varchar(50),
            @AgruparDetalle			bit,
            @Cliente				varchar(20),
            @OrdenCompra			varchar(50),
			@TipoAddenda			varchar(50), 
			@Cantidad				float, 
			@Precio					float, 
			@DescuentoLinea			float,
			@DescuentoGlobalLinea	float, 
			@Impuesto1Linea			float, 
			@Impuesto2Linea			float, 
			@SubTotalLinea			float, 
			@TotalLinea				float, 
			@ImporteLinea			float, 
			@Ok						int			 OUTPUT,
			@OkRef					varchar(255) OUTPUT
AS BEGIN
DECLARE 
	@Mov						varchar(20),
	@MovTipoSubClave			varchar(20),
    @TerceroProv				varchar(20),
    @TerceroCte					varchar(20),
    @TerceroRFC					varchar(20),
    @TerceroNombre				varchar(100),
    @TerceroDireccion			varchar(100),
    @TerceroDireccionNumero		varchar(20),
    @TerceroDireccionNumeroInt	varchar(20),
    @TerceroColonia				varchar(100),
    @TerceroPoblacion			varchar(100),
    @TerceroObservaciones		varchar(100),
    @TerceroDelegacion			varchar(100),
    @TerceroEstado				varchar(30),
    @TerceroPais				varchar(30),
    @TerceroCodigoPostal		varchar(15),
    @TerceroGLN					varchar(50),
    @TerceroTelefonos			varchar(100),

	@Empresa					varchar(10),
	@MovTipo					varchar(20),
	@Contacto					varchar(20),
	@ClienteRFC					varchar(20),
    @p					char(1),
    @RetencionTotal		float,
    @RetencionFlete		float,
    @RetencionPitex		float,
	@CfgDecimales		int, 
    @TasaImpuesto1 float,
    @ImporteImpuesto1 float,
    @TasaImpuesto2 float,
    @ImporteImpuesto2 float,
	@RenglonId		int,
	@Pedimento varchar(20),
	@Aduana varchar(20),
	@PedimentoFEcha datetime,
	@Retencion1 float,
	@Retencion2 float,
	@SerieLote	varchar(20)


  EXEC spMovInfo @ID, @Modulo, @Mov OUTPUT, @Contacto = @Contacto OUTPUT, @Empresa = @Empresa OUTPUT

  SELECT @CfgDecimales = ISNULL(Decimales,2) FROM EmpresaCFD WHERE Empresa = @Empresa
  SELECT @MovTipo = Clave, @MovTipoSubClave = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  
  IF @Modulo = 'VTAS' AND @Validar = 0 AND (@MovTipoSubClave = 'CFDI.TERCEROSPROV' OR @MovTipoSubClave ='CFDI.TERCEROSCTE')
  BEGIN

  SELECT @RenglonID = RenglonID FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND REnglonSub = @RenglonSub AND Articulo = @Articulo
  SELECT @ClienteRFC = RFC FROM Cte WHERE Cliente = @Contacto
  EXEC spMovInfo @ID, @Modulo, @Mov OUTPUT
  SELECT  @MovTipoSubClave = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  IF @Modulo = 'VTAS'  AND @MovTipoSubClave = 'CFDI.TERCEROSPROV' 
  BEGIN
    SELECT @TerceroProv = Proveedor FROM CFDVentaDProv WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Articulo = @Articulo

    IF NULLIF(@TerceroProv,'') IS NULL 
	  RETURN

    SELECT @TerceroRFC = RFC, @TerceroNombre = Nombre, @TerceroDireccion = Direccion, @TerceroDireccionNumero = DireccionNumero, @TerceroDireccionNumeroInt = DireccionNumeroInt,
           @TerceroColonia = Colonia, @TerceroPoblacion = Poblacion, @TerceroObservaciones = NULLIF(RTRIM(EntreCalles/*Observaciones*/),''), @TerceroDelegacion = Delegacion, @TerceroEstado = Estado, 
           @TerceroPais = Pais, @TerceroCodigoPostal = CodigoPostal, @TerceroTelefonos = Telefonos
      FROM Prov
     WHERE Proveedor = @TerceroProv 
  END
  ELSE IF @Modulo = 'VTAS'  AND @MovTipoSubClave = 'CFDI.TERCEROSCTE' 
  BEGIN 
   SELECT @TerceroCte = Cliente FROM CFDVentaDCte WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Articulo = @Articulo
   IF NULLIF(@TerceroCte,'') IS NULL 
   RETURN

    SELECT @TerceroRFC = RFC, @TerceroNombre = Nombre, @TerceroDireccion = Direccion, @TerceroDireccionNumero = DireccionNumero, @TerceroDireccionNumeroInt = DireccionNumeroInt,
           @TerceroColonia = Colonia, @TerceroPoblacion = Poblacion, @TerceroObservaciones = NULLIF(RTRIM(EntreCalles/*Observaciones*/),''), @TerceroDelegacion = Delegacion, @TerceroEstado = Estado, 
           @TerceroPais = Pais, @TerceroCodigoPostal = CodigoPostal, @TerceroTelefonos = Telefonos
      FROM Cte
     WHERE Cliente  = @TerceroCte 
  END
  
 
    SELECT '<cfdi:ComplementoConcepto>
            <terceros:PorCuentadeTerceros xsi:schemaLocation='+char(34)+'http://www.sat.gob.mx/terceros http://www.sat.gob.mx/sitio_internet/cfd/terceros/terceros11.xsd'+char(34)+
            dbo.fnXML('version', '1.1')+
            dbo.fnXML('nombre', @TerceroNombre)+
            dbo.fnXML('rfc', @TerceroRFC)+'>'

    SELECT '<terceros:InformacionFiscalTercero '+
	       dbo.fnXML('calle', @TerceroDireccion)+
  		   dbo.fnXML('noExterior', @TerceroDireccionNumero)+
		   dbo.fnXML('noInterior', @TerceroDireccionNumeroInt)+
		   dbo.fnXML('colonia', @TerceroColonia)+
	       dbo.fnXML('localidad', @TerceroPoblacion)+
		   dbo.fnXML('municipio', @TerceroDelegacion)+
		   dbo.fnXML('estado', @TerceroEstado)+
		   dbo.fnXML('pais', @TerceroPais)+
		   dbo.fnXML('codigoPostal', @TerceroCodigoPostal)+'/>'


         DECLARE crSerieLoteMov CURSOR LOCAL FOR 
             SELECT Top 1 s.SerieLote, dbo.fnLimpiarRFC(s.Propiedades), p.Fecha1, p.Aduana  
               FROM SerieLoteMov s
               JOIN SerieLoteProp p ON p.Propiedades = s.Propiedades
              WHERE s.Empresa = @Empresa AND s.Modulo = @Modulo AND s.ID = @ID AND s.RenglonID = @RenglonID AND s.Articulo = @Articulo AND ISNULL(s.SubCuenta, '') = ISNULL(@SubCuenta, '')
              GROUP BY s.SerieLote, s.Propiedades, p.Fecha1, p.Aduana
              ORDER BY s.SerieLote, s.Propiedades, p.Fecha1, p.Aduana
          OPEN crSerieLoteMov
          FETCH NEXT FROM crSerieLoteMov INTO @SerieLote, @Pedimento, @PedimentoFecha, @Aduana
          WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
          BEGIN
            IF @@FETCH_STATUS <> -2 
            BEGIN
                SELECT  '<terceros:InformacionAduanera'+
                        dbo.fnXML('numero', @Pedimento)+
                        dbo.fnXMLDatetimeFmt('fecha', @PedimentoFecha, 'AAAA-MM-DD')+
                        dbo.fnXML('aduana', @Aduana)+
                       '/>'
            END
            FETCH NEXT FROM crSerieLoteMov INTO @SerieLote, @Pedimento, @PedimentoFecha, @Aduana
          END
          CLOSE crSerieLoteMov
          DEALLOCATE crSerieLoteMov



    SELECT '<terceros:Impuestos>'

    IF @MovTipo IN ('VTAS.F', 'VTAS.D', 'VTAS.DF', 'VTAS.B')
    BEGIN
  -- Si el Articulo Facturado es un Flete o la clave indicada para fletes
  -- Si tiene RFC y el RFC Tiene un tamaño minimo de 9 caracteres
      IF @ClienteRFC IS NOT NULL AND LEN(@ClienteRFC) >= 9
      BEGIN
        -- Para Conocer si el RFC es de una Persona Moral (Empresa) en la cuarta posicion no debe ser una letra
        SELECT @p = SUBSTRING(@ClienteRFC, 4, 1)
        IF UPPER(@p) NOT IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')
        BEGIN
          -- Entonces Calcula el Importe de la Retencion = 4% del Importe del Flete
	      IF @Articulo = 'FLETE'
             SELECT @RetencionFlete = @SubTotalLinea * 0.04
        END
      END

      IF EXISTS(SELECT * FROM Cte WHERE Cliente = @Cliente AND NULLIF(RTRIM(PITEX), '') IS NOT NULL)
        SELECT @RetencionPitex = @Impuesto1Linea 
    END

    IF @RetencionFlete IS NOT NULL OR @RetencionPitex IS NOT NULL
    BEGIN
      SELECT  '<terceros:Retenciones>'
      SELECT  '<terceros:Retencion'+
               dbo.fnXML('impuesto', 'IVA')+
               dbo.fnXMLDecimal('importe', ISNULL(@RetencionFlete,0.0)+ISNULL(@RetencionPitex,0.0), @CfgDecimales)+
               '/>'
      SELECT  '</terceros:Retenciones>'   
    END
	ELSE 
	BEGIN
      SELECT @Retencion1 = Retencion1, @Retencion2 = Retencion2 from Ventatcalc WHERE ID = @ID AND Renglon = @Renglon AND REnglonSub = @RenglonSub AND Articulo = @Articulo	  
      IF @Retencion1 > 0 OR @Retencion2 > 0
      BEGIN
        SELECT  '<terceros:Retenciones>'
	    IF @Retencion1 > 0
          SELECT  '<terceros:Retencion'+
                 dbo.fnXML('impuesto', 'ISR')+
                 dbo.fnXMLDecimal('importe', @SubTotalLinea*@Retencion1/100, @CfgDecimales)+
                 '/>'
	    IF @Retencion2 > 0
          SELECT  '<terceros:Retencion'+
                 dbo.fnXML('impuesto', 'IVA')+
                 dbo.fnXMLDecimal('importe', @SubTotalLinea*@Retencion2/100, @CfgDecimales)+
                 '/>'
        SELECT  '</terceros:Retenciones>'   

      END
    END



    IF @Modulo = 'VTAS' 
    AND (Exists (SELECT * FROM VentaTCalc V JOIN Art a ON v.articulo = a.Articulo WHERE v.ID = @ID AND a.Impuesto1Excento = 0 AND Impuesto1Total IS NOT NULL) 
    OR Exists (SELECT * FROM VentaTCalc V JOIN Art a ON v.articulo = a.Articulo WHERE v.ID = @ID AND a.Excento2 = 0 AND NULLIF(Impuesto2Total,0.0) IS NOT NULL))
    BEGIN
      SELECT  '<terceros:Traslados>' 

      SELECT @TasaImpuesto1 = v.Impuesto1, @ImporteImpuesto1 = v.Impuesto1Total 
        FROM VentaTCalc V
        JOIN Art a ON v.articulo = a.Articulo 
       WHERE v.ID = @ID AND v.Renglon = @Renglon AND v.RenglonSub = @RenglonSub AND v.Articulo = @Articulo
		 AND a.Impuesto1Excento = 0  
 
       -- IVA    
	  SELECT  '<terceros:Traslado'+
              dbo.fnXML('impuesto', 'IVA')+
              dbo.fnXMLFloat2('tasa', @TasaImpuesto1)+
              dbo.fnXMLDecimal('importe', @ImporteImpuesto1, @CfgDecimales)+
              '/>'

      SELECT @TasaImpuesto2 = v.Impuesto2, @ImporteImpuesto2 = v.Impuesto2Total
         FROM VentaTCalc v
         JOIN Art a ON v.Articulo = a.Articulo
        WHERE v.ID = @ID AND v.Renglon = @Renglon AND v.RenglonSub = @RenglonSub AND v.Articulo = @Articulo
		  AND a.Excento2 = 0  

	IF @ImporteImpuesto2 IS NOT NULL AND NOT( @ImporteImpuesto2 = 0 AND @TasaImpuesto2=0)
      SELECT  '<terceros:Traslado'+
               dbo.fnXML('impuesto', 'IEPS')+
               dbo.fnXMLFloat2('tasa', @TasaImpuesto2)+
                dbo.fnXMLDecimal('importe', @ImporteImpuesto2, @CfgDecimales)+
               '/>'

      SELECT  '</terceros:Traslados>'
    END        
    SELECT  '</terceros:Impuestos>'+
            '</terceros:PorCuentadeTerceros>'+
            '</cfdi:ComplementoConcepto>'
  END

  RETURN
END
GO


/**************** xpCFDXSL ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDXSL') and type = 'P') drop procedure dbo.xpCFDXSL
GO             
CREATE PROCEDURE xpCFDXSL
			@Empresa		char(5),
			@Modulo 		varchar(20),
			@Id 			int,
			@Cliente		varchar(20),
			@TipoAddenda	varchar(20), 
			@XSL			varchar(255) OUTPUT

AS BEGIN
DECLARE 
@Mov varchar(20),
@MovTipo varchar(20),
@MovTipoSubClave varchar(20),
@RutaXSL varchar(255)

  EXEC spMovInfo @ID, @Modulo, @Mov OUTPUT
  SELECT @MovTipo = Clave, @MovTipoSubClave = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  
  IF @Modulo = 'VTAS' AND ( @MovTipoSubClave = 'CFDI.TERCEROSPROV' OR @MovTipoSubClave = 'CFDI.TERCEROSCTE')
  BEGIN  
    --SELECT @ArchivoXSL = RIGHT(@ruta, CHARINDEX('\', REVERSE(@ruta)) - 1)
    SELECT @RutaXSL =  LEFT(@XSL, LEN(@XSL) - CHARINDEX('\', REVERSE(@XSL)))
    SELECT @XSL = @RutaXSL+'\CadenaOriginalv32terceros.xslt'
  END

  RETURN
END
GO

/**************** xpNameSpace ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpNameSpace') and type = 'P') drop procedure dbo.xpNameSpace
GO             
CREATE PROCEDURE xpNameSpace
			@Estacion		int,
			@Modulo			char(5),
			@ID				int,
			@Layout			varchar(50),
			@Version		varchar(10), 
			@TipoAddenda	varchar(50),
			@NameSpace		varchar(8000) OUTPUT
AS BEGIN
DECLARE 
@Mov varchar(20),
@MovTipo varchar(20),
@MovTipoSubClave varchar(20),
@Complemento     varchar(50)

  EXEC spMovInfo @ID, @Modulo, @Mov OUTPUT

  SELECT @MovTipo = Clave, @MovTipoSubClave = SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  
  IF @Modulo = 'VTAS'
   SELECT @Complemento = c.TipoComplemento FROM Venta v JOIN CteCFD c ON v.Cliente = c.Cliente WHERE v.ID = @ID

  IF @Modulo = 'VTAS' AND (@MovTipoSubClave = 'CFDI.TERCEROSPROV' OR @MovTipoSubClave = 'CFDI.TERCEROSCTE')
    SELECT @NameSpace = ' xmlns:xsi='+char(34)+'http://www.w3.org/2001/XMLSchema-instance'+char(34)+' xmlns:cfdi='+char(34)+'http://www.sat.gob.mx/cfd/3'+char(34)+' xmlns:terceros='+char(34)+'http://www.sat.gob.mx/terceros'+char(34)+' xsi:schemaLocation='+char(34)+'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd http://www.sat.gob.mx/terceros http://www.sat.gob.mx/sitio_internet/cfd/terceros/terceros11.xsd'+char(34)+' '

  IF @Modulo = 'VTAS' AND (@MovTipoSubClave = 'CFDI.COMERCIOEXT' OR (ISNULL(@Complemento,'') = 'Comercio Exterior'))
    SELECT @NameSpace = ' xmlns:cfdi="http://www.sat.gob.mx/cfd/3" xmlns:xsi='+char(34)+'http://www.w3.org/2001/XMLSchema-instance'+char(34)+' xmlns:cce='+char(34)+'http://www.sat.gob.mx/ComercioExterior'+char(34)+' xsi:schemaLocation='+char(34)+'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd http://www.sat.gob.mx/ComercioExterior http://www.sat.gob.mx/sitio_internet/cfd/ComercioExterior/ComercioExterior10.xsd'+char(34)+' '

  IF @Modulo = 'VTAS' AND (@MovTipoSubClave = 'CFDI.INE' OR (ISNULL(@Complemento,'') = 'INE'))
    SELECT @NameSpace = ' xmlns:cfdi="http://www.sat.gob.mx/cfd/3" xmlns:xsi='+char(34)+'http://www.w3.org/2001/XMLSchema-instance'+char(34)+' xmlns:ine='+char(34)+'http://www.sat.gob.mx/ine'+char(34)+' xsi:schemaLocation='+char(34)+'http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd http://www.sat.gob.mx/ine http://www.sat.gob.mx/sitio_internet/cfd/ine/ine10.xsd'+char(34)+' '

RETURN
END
GO

/************** xpCFDValidarFolio *************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDValidarFolio') and type = 'P') drop procedure dbo.xpCFDValidarFolio
GO
CREATE PROCEDURE xpCFDValidarFolio
		   @Sucursal			int,
           @Empresa     		char(5),
           @Modulo				char(5),
           @Mov      			char(20),
           @MovID				varchar(20),
           @ModuloAfectacion	varchar(5),
           @ID					int,
		   @VersionCFD			varchar(10),
		   @Ok					int				OUTPUT,
		   @OkRef				varchar(255)	OUTPUT
AS 
BEGIN
  RETURN
END
GO

/**************** xpGenerarCFDEncabezado ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarCFDEncabezado') and type = 'P') drop procedure dbo.xpGenerarCFDEncabezado
GO           
CREATE PROCEDURE xpGenerarCFDEncabezado
			@Estacion		int,
			@Modulo			char(5),
			@ID			int,
			@Layout			varchar(50),
			@Validar		bit		= 0,
			@Empresa		char(5),
			@Sucursal		int,
			@Cliente		varchar(10),
			@EnviarA		int,
			@EmpresaGLN		varchar(50),
			@Version		varchar(10),
			@Mov			varchar(20),
			@MovID			varchar(20),
			@Estatus			varchar(15),
			@ConsecutivoModulo	char(5),
			@ConsecutivoMov		varchar(20),
			@Fecha			datetime,
			@Serie 			varchar(20),
			@Folio			bigint,
			@MovTipo		varchar(20),
			@tipoDeComprobante	varchar(20),
			@TipoAddenda 		varchar(50), 
			@AddendaVersion 	varchar(10),
			@Moneda			char(10),	
			@TipoCambio		float,
			@Liverpool		bit,
			@Gigante		bit,
			@ComercialMexicana	bit,
			@Elektra		bit,
			@EHB			bit,
			@Origen			varchar(20),
			@OrigenID		varchar(20),

			@SucursalGLN		varchar(50) 	OUTPUT,
			@ClienteGLN		varchar(50) 	OUTPUT,
			@EnviarAGLN		varchar(50) 	OUTPUT,
			@Referencia		varchar(50) 	OUTPUT,
			@ReferenciaFecha	datetime 	OUTPUT,
			@FormaEnvio		varchar(50) 	OUTPUT,
			@Condicion		varchar(50) 	OUTPUT,
			@Vencimiento		datetime 	OUTPUT,
			@formaDePago		varchar(100) 	OUTPUT,
			@metodoDePago		varchar(100) 	OUTPUT,
			@EmisorID 		varchar(20) 	OUTPUT,
			@ReceptorID 		varchar(20) 	OUTPUT, 
			@ProveedorID 		varchar(20) 	OUTPUT, 
			@OrdenCompra 		varchar(50) 	OUTPUT, 
			@FechaOrdenCompra	datetime 	OUTPUT,
			@DepartamentoClave	varchar(20) 	OUTPUT,
			@DepartamentoNombre	varchar(100) 	OUTPUT,
			@DepartamentoContacto   varchar(100) 	OUTPUT,
			@Observaciones		varchar(100) 	OUTPUT,
			@EnviarAClave		varchar(20) 	OUTPUT,
			@Embarque 		varchar(50) 	OUTPUT, 
			@EmbarqueFecha 		datetime 	OUTPUT, 
			@Recibo 		varchar(50) 	OUTPUT, 
			@ReciboFecha 		datetime 	OUTPUT,
			@MonedaClave		char(3) 	OUTPUT,
			@FechaRequerida		datetime 	OUTPUT,
			@TipoCondicion		varchar(20) 	OUTPUT,
			@DescuentoClave		varchar(20) 	OUTPUT,
			@Antecedente		varchar(50) 	OUTPUT,
			@AntecedenteFecha	datetime 	OUTPUT,
			@ReferenciaEnvio	varchar(14) 	OUTPUT,
			@Ok					int		= NULL OUTPUT,
			@OkRef				varchar(255)	= NULL OUTPUT,
            @AgruparDetalle		bit = 0 OUTPUT,
            @ClienteDireccion	varchar(100)= NULL  OUTPUT,         
            @EnviarADireccion   varchar(100) =  NULL  OUTPUT,
			@Descuento          varchar(50) =  NULL  OUTPUT,
			@RegimenFiscal      varchar(100) =  NULL  OUTPUT,       
            @NumeroCuentaPago   varchar(255) =  NULL  OUTPUT,
            @CuentaPredial      varchar(100) =  NULL  OUTPUT,
            @LugarExpedicion    varchar(255) =  NULL  OUTPUT                      


AS BEGIN
  RETURN
END
GO

/**************** xpGenerarCFDDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarCFDDetalle') and type = 'P') drop procedure dbo.xpGenerarCFDDetalle
GO             
CREATE PROCEDURE xpGenerarCFDDetalle
			@Estacion				int,
			@Modulo					char(5),
			@ID						int,
			@Layout					varchar(20),
			@Version				varchar(10), 
			@Renglon				float, 
			@RenglonSub				int, 
			@Cantidad 				float			OUTPUT, 
			@Codigo 				varchar(30)		OUTPUT, 
			@Unidad 				varchar(50)		OUTPUT, 
			@UnidadClave 			varchar(50)		OUTPUT, 
			@UnidadFactor 			float			OUTPUT, 
			@Articulo 				varchar(20)		OUTPUT, 
			@SubCuenta 				varchar(50)		OUTPUT, 
			@ArtDescripcion1 		varchar(255)	OUTPUT, 
			@ArtDescripcion2 		varchar(255)	OUTPUT, 
			@ArtTipoEmpaque 		varchar(50)		OUTPUT, 
			@TipoEmpaqueClave 		varchar(20)		OUTPUT, 
			@TipoEmpaqueTipo 		varchar(20)		OUTPUT,
			@Paquetes 				int				OUTPUT, 
    		@CantidadEmpaque		float			OUTPUT,
			@EAN13 					varchar(20)		OUTPUT, 
			@DUN14 					varchar(20)		OUTPUT, 
			@SKUCliente				varchar(20)		OUTPUT, 
			@SKUEmpresa				varchar(20)		OUTPUT, 
			@noIdentificacion 		varchar(50)		OUTPUT,
            @AgruparDetalle			bit			= 0,
            @Cliente				varchar(20) = NULL,          
            @OrdenCompra			varchar(50) = NULL OUTPUT,
            @CuentaPredial			varchar(100) = NULL OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpCFDSerieLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDSerieLote') and type = 'P') drop procedure dbo.xpCFDSerieLote
GO             
CREATE PROCEDURE xpCFDSerieLote
			@Empresa			char(5),
			@Modulo				char(5),
			@ID				int,
			@Renglon			float,
			@RenglonSub			int,
			@RenglonID			int,
			@RenglonTipo			char(1),
			@Articulo			varchar(20),
			@SubCuenta			varchar(50),
			@TipoAddenda 			varchar(50), 
			@LayOut 			varchar(50), 
			@SerieLote			varchar(50),
			@Pedimento			varchar(20) 	OUTPUT, 
			@PedimentoFecha			datetime 	OUTPUT, 
			@Aduana				varchar(50) 	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpCFDVentaImpuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDVentaImpuesto') and type = 'P') drop procedure dbo.xpCFDVentaImpuesto
GO             
CREATE PROCEDURE xpCFDVentaImpuesto
			@Estacion		int,
			@Modulo			char(5),
			@ID				int,
			@Layout			varchar(50),
			@Validar		bit		= 0,
			@Empresa		char(5),
			@Sucursal		int,
			@Cliente		varchar(10),
			@Tipo			varchar(20), 
			@Impuesto		float OUTPUT,
			@Importe		float OUTPUT
AS BEGIN

RETURN
END
GO

/**************** xpTipoAddenda ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpTipoAddenda') and type = 'P') drop procedure dbo.xpTipoAddenda
GO             
CREATE PROCEDURE xpTipoAddenda
			@Modulo			char(5),
			@ID				int,
            @TipoAddenda	varchar(50) OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpCFDValidar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDValidar') and type = 'P') drop procedure dbo.xpCFDValidar
GO             
CREATE PROCEDURE xpCFDValidar
			@Modulo		char(5),
			@ID		int,
			@Usuario	varchar(10),
			@Adicional	bit,
			@Schema		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpCFDXSL ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDXSL') and type = 'P') drop procedure dbo.xpCFDXSL
GO             
CREATE PROCEDURE xpCFDXSL
			@Empresa		char(5),
			@Modulo 		varchar(20),
			@Id 			int,
			@Cliente		varchar(20),
			@TipoAddenda	varchar(20), 
			@XSL			varchar(255) OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpCFDAlmacenar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDAlmacenar') and type = 'P') drop procedure dbo.xpCFDAlmacenar
GO             
CREATE PROCEDURE xpCFDAlmacenar
			@Modulo		char(5),
			@ID		int,
			@Usuario	varchar(10),
			@Adicional	bit,
			@XML		bit		OUTPUT,
			@PDF		bit		OUTPUT,
			@NomArch	varchar(255)	OUTPUT,
			@Reporte	varchar(100)	OUTPUT,
			@Ruta		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpCFDEnviar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDEnviar') and type = 'P') drop procedure dbo.xpCFDEnviar
GO             
CREATE PROCEDURE xpCFDEnviar
			@Modulo			char(5),
			@ID			int,
			@Usuario		varchar(10),
			@Adicional		bit,
			@XML			bit		OUTPUT,
			@PDF			bit		OUTPUT,
			@ArchivoXML		varchar(255)	OUTPUT,
			@ArchivoPDF		varchar(255)	OUTPUT,
			@Medio			varchar(20)	OUTPUT,
			@Direccion		varchar(255)	OUTPUT,
			@Ruta			varchar(255) 	OUTPUT,
			@EnviarUsuario		varchar(100)	OUTPUT,
			@EnviarContrasena	varchar(100) 	OUTPUT,
			@De			varchar(255)	OUTPUT,
			@Para			varchar(255)	OUTPUT,
			@CC			varchar(255)	OUTPUT,
			@CCO			varchar(255)	OUTPUT,
			@Asunto			varchar(255)	OUTPUT,
			@Mensaje		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO
