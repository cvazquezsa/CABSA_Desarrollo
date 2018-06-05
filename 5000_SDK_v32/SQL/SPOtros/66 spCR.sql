/*********************** spRecibirCRCFD ***********************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spRecibirCRCFD') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spRecibirCRCFD
GO
CREATE PROCEDURE spRecibirCRCFD
    @XML	text
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @iXML						int,
  @ID						int,
  @CFDID					int,
  @CFDSerie					varchar(20),
  @CFDFolio					varchar(20),
  @CFD						varchar(max),
  @XMLMAX					varchar(max),   

  @Empresa					varchar(5),
  @Sucursal					int,
  @FechaTrabajo				datetime,
  @Registro					varchar(max),
  @CadenaOriginal			varchar(max),  
  @ModuloID					int,
  @MovID					varchar(20),
  
  @CFDFecha					datetime,			
  @Ejercicio				int,
  @Periodo					int,
  @CFDAprobacion			varchar(20),		
  @CFDnoCertificado			varchar(20),	
  @CFDSello					varchar(max),
  @CFDImporte				float,			
  @CFDRFC					varchar(15),
  @CFDImpuesto1				float,
  @CFDImpuesto2				float,  
  @CFDCadenaOriginal		varchar(max),
  @RegistroModificado		xml,  
  @iDatos					int,
  @CRAfectarAuto			bit
  
  DECLARE @Documento TABLE
  (
  Empresa			varchar(5) NULL,
  Sucursal			int NULL,
  FechaTrabajo		datetime NULL,
  ID				int NULL,
  CFDID				int NULL,
  CFDSerie			varchar(20) NULL,
  CFDFolio			varchar(20) NULL,
  Registro			varchar(max) NULL,
  CadenaOriginal	varchar(max) NULL,
  ModuloID			int NULL,
  MovID				varchar(20)
  )
  
  SET @XMLMAX = CONVERT(varchar(max),@XML)    
  SET @XMLMAX = REPLACE(@XMLMAX,'encoding="UTF-8"','encoding="WINDOWS-1252"')
  
  EXEC sp_xml_preparedocument @iXML OUTPUT, @XMLMAX

  INSERT @Documento (Empresa, Sucursal, FechaTrabajo, ID, CFDID, CFDSerie, CFDFolio, Registro, CadenaOriginal)  
  SELECT 
   Empresa, 
   Sucursal,
   FechaTrabajo,
   ID,
   CFDID,
   CFDSerie,
   CFDFolio,
   Registro,
   CadenaOriginal
    FROM openxml (@iXML,'/CR/Registro',3)   
    WITH (Empresa varchar(5) '../@Empresa', Sucursal int '../@Sucursal', FechaTrabajo datetime '../@FechaTrabajo', ID int, CFDID int, CFDSerie varchar(20), CFDFolio varchar(20), Registro varchar(max) '.', CadenaOriginal varchar(max))
          
  EXEC sp_xml_removedocument @iXML
    
  DECLARE crDocumento CURSOR FOR
   SELECT Empresa, Sucursal, CFDSerie, CFDFolio, Registro, FechaTrabajo, ID, CFDID, CadenaOriginal
     FROM @Documento

  OPEN crDocumento
  FETCH NEXT FROM crDocumento INTO @Empresa, @Sucursal, @CFDSerie, @CFDFolio, @Registro, @FechaTrabajo, @ID, @CFDID, @CadenaOriginal
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF EXISTS(SELECT * FROM CRCFD WHERE CFDFolio = @CFDFolio AND CFDSerie = @CFDSerie AND Sucursal = @Sucursal AND Empresa = @Empresa)
    BEGIN
      UPDATE CRCFD
         SET 
         FechaTrabajo   = @FechaTrabajo,
         ID             = @ID,
         CFDID          = @CFDID,
         CadenaOriginal = @CadenaOriginal,
         Registro       = @Registro,
         Estatus        = 'PENDIENTE'
       WHERE CFDFolio = @CFDFolio AND CFDSerie = @CFDSerie AND Sucursal = @Sucursal AND Empresa = @Empresa AND Estatus NOT IN ('CONCLUIDO')               
    END ELSE
    BEGIN
      INSERT CRCFD (Empresa,  Sucursal,  CFDSerie,  CFDFolio,  FechaTrabajo,  ID,  CFDID,  Registro,  Estatus,     CadenaOriginal)
            VALUES (@Empresa, @Sucursal, @CFDSerie, @CFDFolio, @FechaTrabajo, @ID, @CFDID, @Registro, 'PENDIENTE', @CadenaOriginal)      
    END
    
    SELECT @CRAfectarAuto = ISNULL(CRAfectarAuto, 0) 
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

    IF @CRAfectarAUTO = 1
      EXEC spCRCFDAfectar @Empresa, @Sucursal, @CFDSerie, @CFDFolio
    
    FETCH NEXT FROM crDocumento INTO @Empresa, @Sucursal, @CFDSerie, @CFDFolio, @Registro, @FechaTrabajo, @ID, @CFDID, @CadenaOriginal
  END
  CLOSE crDocumento
  DEALLOCATE crDocumento
  
  SELECT "Mensaje" = ''
  RETURN  
END
GO

-- spGenerarCROtros 'DEMO', 0
/************** spGenerarCROtros *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCROtros') and type = 'P') drop procedure dbo.spGenerarCROtros
GO
CREATE PROCEDURE spGenerarCROtros
			@Empresa	char(5),
			@Sucursal	int
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'

  SELECT '<crOtros>'
/*    SELECT '<Tabla Nombre="ArtFam" sp="spRecibirArtFam">'
      SELECT '<EliminarObjetos>'
      SELECT 'if exists (select * from sysobjects where id = object_id("dbo.ArtFam") and type = "U") drop table dbo.ArtFam
              if exists (select * from sysobjects where id = object_id("dbo.spRecibirArtFam") and type = "P") drop procedure dbo.spRecibirArtFam'
      SELECT '</EliminarObjetos>'
      SELECT '<CrearTabla>'
      SELECT 'CREATE TABLE dbo.ArtFam (
	Familia 		varchar(50) 	NOT NULL ,
	Icono			int	  	NULL,
	Clave			varchar(20)	NULL,

	CONSTRAINT priArtFam PRIMARY KEY CLUSTERED (Familia))'
      SELECT '</CrearTabla>'
      SELECT '<CrearSP>'
      SELECT 'CREATE PROCEDURE spRecibirArtFam
                       @xml  text
    --//WITH ENCRYPTION
    AS BEGIN
      DECLARE
        @ixml  int
    
      EXEC sp_xml_preparedocument @ixml OUTPUT, @xml
      TRUNCATE TABLE ArtFam
      INSERT ArtFam (Familia, Icono, Clave)
      SELECT             Familia, Icono, Clave
        FROM OPENXML (@ixml, "ArtFam/row")
        WITH (Familia varchar(50), Icono int, Clave varchar(20))
      EXEC sp_xml_removedocument @ixml
      RETURN
    END'
      SELECT '</CrearSP>'
      SELECT '<Datos>'
      SELECT Familia, Icono, Clave
        FROM ArtFam
         FOR XML RAW
      SELECT '</Datos>'
    SELECT '</Tabla>'

    SELECT '<SQL>'
    SELECT '</SQL>'*/
  SELECT '</crOtros>'
  RETURN 
END
GO

/************** spGenerarCRMensajeLista *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRMensajeLista') and type = 'P') drop procedure dbo.spGenerarCRMensajeLista
GO
CREATE PROCEDURE spGenerarCRMensajeLista
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crMensajeLista>'
  SELECT Mensaje, Descripcion, Tipo
    FROM MensajeLista
   WHERE IE = 1
     FOR XML RAW
  SELECT '</crMensajeLista>'
  RETURN 
END
GO

-- spGenerarCRArt 'DEMO', 0, 'Pesos', 1
-- CJ 23/Oct/2013 Se agregaron los campos LDI, LDIServicio y EmidaRecargaTelefonica (Bugs 19210 y 19211)
/************** spGenerarCRArt *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRArt') and type = 'P') drop procedure dbo.spGenerarCRArt
GO
CREATE PROCEDURE spGenerarCRArt
			@Empresa	char(5),
			@Sucursal	int,
			@MovMoneda	char(10),
			@MovTipoCambio	float
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crArt>'
  SELECT "Articulo" = RTRIM(a.Articulo), 
         "Nombre" = a.Descripcion1, 
         "Precio" = dbo.fnPrecioSucursal(@Empresa, @Sucursal, @MovMoneda, @MovTipoCambio, a.Articulo, NULL, NULL), 
         "Estatus" = RTRIM(a.Estatus),
         "Tipo" = RTRIM(a.Tipo), 
         "Rama" = NULLIF(RTRIM(a.Rama), ''),
         "Categoria" = NULLIF(RTRIM(a.Categoria), ''),
         "Grupo" = NULLIF(RTRIM(a.Grupo), ''),
         "Familia" = NULLIF(RTRIM(a.Familia), ''),
         "Linea" = NULLIF(RTRIM(a.Linea), ''),
         "Fabricante" = NULLIF(RTRIM(a.Fabricante), ''),
         "Presentacion" = NULLIF(RTRIM(a.Presentacion), ''),
	 "Impuesto1" = NULLIF(a.Impuesto1, 0.0),
         "Impuesto2" = NULLIF(a.Impuesto2, 0.0),
         "Impuesto3" = NULLIF(a.Impuesto3, 0.0),
         "Costo" = ac.CostoEstandar,
         a.LDI,
         a.LDIServicio,
         a.EmidaRecargaTelefonica
    FROM Art a
    LEFT OUTER JOIN ArtCosto ac ON ac.Sucursal = @Sucursal AND ac.Empresa = @Empresa AND ac.Articulo = a.Articulo
   WHERE a.SeVende = 1
     FOR XML RAW
  SELECT '</crArt>'
  RETURN 
END
GO

-- spGenerarCRArtPromo 'DEMO', 0, 'Pesos', 1
/************** spGenerarCRArtPromo *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRArtPromo') and type = 'P') drop procedure dbo.spGenerarCRArtPromo
GO
CREATE PROCEDURE spGenerarCRArtPromo
			@Empresa	char(5),
			@Sucursal	int,
			@MovMoneda	char(10),
			@MovTipoCambio	float
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<CRArtPromo>'
  SELECT Articulo, 
         VigenciaD,
         VigenciaA,
	 Precio,
         Costo
    FROM CRArtPromo
   WHERE Sucursal = @Sucursal
     FOR XML RAW
  SELECT '</CRArtPromo>'
  RETURN 
END
GO

/************** spGenerarCRPresentacionPrecio *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRPresentacionPrecio') and type = 'P') drop procedure dbo.spGenerarCRPresentacionPrecio
GO
CREATE PROCEDURE spGenerarCRPresentacionPrecio
			@Empresa	char(5),
			@Sucursal	int,
			@MovMoneda	char(10),
			@MovTipoCambio	float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Region	varchar(50)

  SELECT @Region = Region FROM Sucursal WHERE Sucursal = @Sucursal
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crPresentacionPrecio>'
  SELECT Presentacion, 
         CantidadD, 
         CantidadA,
         PrecioNormal,
         PrecioOferta,
         VigenciaD,
         VigenciaA
    FROM PresentacionPrecio
   WHERE Region = @Region OR Sucursal = @Sucursal
     FOR XML RAW
  SELECT '</crPresentacionPrecio>'
  RETURN 
END
GO

/************** spGenerarCRArtCB *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRArtCB') and type = 'P') drop procedure dbo.spGenerarCRArtCB
GO
CREATE PROCEDURE spGenerarCRArtCB
			@Empresa	char(5)	= NULL,
			@Sucursal	int	= NULL
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crArtCB>'
  SELECT "Codigo" = RTRIM(cb.Codigo), 
         "Articulo" = cb.Cuenta,
         "SubCuenta" = cb.SubCuenta,
         "Cantidad" = cb.Cantidad,
         "Unidad" = cb.Unidad
    FROM CB
    JOIN Art a ON a.Articulo = cb.Cuenta AND a.SeVende = 1
   WHERE cb.TipoCuenta = 'Articulos'
     FOR XML RAW
  SELECT '</crArtCB>'
  RETURN 
END
GO

/************** spGenerarCRArtCBJuego *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRArtCBJuego') and type = 'P') drop procedure dbo.spGenerarCRArtCBJuego
GO
CREATE PROCEDURE spGenerarCRArtCBJuego
			@Empresa	char(5)	= NULL,
			@Sucursal	int	= NULL
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crArtCBJuego>'
  SELECT "Codigo" = RTRIM(cb.Codigo), 
         "Articulo" = j.Articulo,
         "SubCuenta" = j.SubCuenta,
         "Cantidad" = j.Cantidad,
         "Unidad" = j.Unidad,
         "Precio" = j.Precio
    FROM CB
    JOIN Art a ON a.Articulo = cb.Cuenta AND a.SeVende = 1
    JOIN ArtCBJuego j ON j.Codigo = cb.Codigo
   WHERE cb.TipoCuenta = 'Articulos'
     FOR XML RAW
  SELECT '</crArtCBJuego>'
  RETURN 
END
GO


/*
Para enviar codigos de barras que tengan existencias

CREATE PROCEDURE spGenerarCRArtCB
			@Empresa	char(5)	= NULL,
			@Sucursal	int	= NULL
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crArtCB>'
  SELECT "Codigo" = RTRIM(cb.Codigo), 
         "Articulo" = cb.Cuenta,
         "SubCuenta" = cb.SubCuenta,
         "Cantidad" = cb.Cantidad,
         "Unidad" = cb.Unidad
    FROM CB
    JOIN Art a ON a.Articulo = cb.Cuenta AND a.SeVende = 1 AND UPPER(a.Tipo) NOT IN ('JUEGO', 'SERVICIO')
    JOIN ArtSubExistenciaInv e ON e.Empresa = @Empresa  AND e.Articulo = a.Articulo AND ISNULL(e.SubCuenta, '') = ISNULL(cb.SubCuenta, '') AND ISNULL(e.Inventario, 0.0) > 0.0
    JOIN Alm ON alm.Almacen = e.Almacen AND alm.Sucursal = @Sucursal
   WHERE cb.TipoCuenta = 'Articulos'
  UNION ALL
  SELECT "Codigo" = RTRIM(cb.Codigo), 
         "Articulo" = cb.Cuenta,
         "SubCuenta" = cb.SubCuenta,
         "Cantidad" = cb.Cantidad,
         "Unidad" = cb.Unidad
    FROM CB
    JOIN Art a ON a.Articulo = cb.Cuenta AND a.SeVende = 1 AND UPPER(a.Tipo) IN ('JUEGO', 'SERVICIO')
   WHERE cb.TipoCuenta = 'Articulos'
     FOR XML RAW
  SELECT '</crArtCB>'
  RETURN 
END*/
GO


/************** spGenerarCRArtJuego *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRArtJuego') and type = 'P') 
drop procedure dbo.spGenerarCRArtJuego
GO
CREATE PROCEDURE spGenerarCRArtJuego
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crArtJuego>'
  SELECT "Articulo" = RTRIM(e.Articulo), 
         "Juego" = RTRIM(d.Juego),
         "Opcion" = RTRIM(d.Opcion),
         e.Cantidad,
         e.PrecioIndependiente
    FROM ArtJuego e, ArtJuegoD d
   WHERE d.Articulo = e.Articulo
     AND d.Juego = e.Juego
   ORDER BY e.Articulo, d.Juego
     FOR XML RAW
  SELECT '</crArtJuego>'
  RETURN 
END
GO

/************** spGenerarCRAgente *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRAgente') and type = 'P') 
drop procedure dbo.spGenerarCRAgente
GO
CREATE PROCEDURE spGenerarCRAgente
                   @Sucursal  int
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crAgente>'
  SELECT "Sucursal" = SucursalEmpresa, 
         "Tipo" = RTRIM(Tipo), 
         "Nombre" = Nombre, 
         "Estatus" = RTRIM(Estatus),
         "ClaveIntelisis" = RTRIM(Agente) 
    FROM Agente
   WHERE Agente.SucursalEmpresa = @Sucursal 
     AND Agente.Tipo IN ('Cajero', 'Vendedor')
     FOR XML RAW
  SELECT '</crAgente>'
  RETURN 
END
GO


/************** spGenerarCRConcepto *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRConcepto') and type = 'P') drop procedure dbo.spGenerarCRConcepto
GO
CREATE PROCEDURE spGenerarCRConcepto
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crConcepto>'
  SELECT Modulo, Concepto
    FROM Concepto
   WHERE CR = 1
     FOR XML RAW
  SELECT '</crConcepto>'
  RETURN 
END
GO

/************** spGenerarCRConceptoMov *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRConceptoMov') and type = 'P') drop procedure dbo.spGenerarCRConceptoMov
GO
CREATE PROCEDURE spGenerarCRConceptoMov
			@Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crConceptoMov>'
  SELECT Modulo, Mov, Concepto 
    FROM EmpresaConceptoValidar 
   WHERE Empresa = @Empresa AND CR = 1
     FOR XML RAW
  SELECT '</crConceptoMov>'
  RETURN 
END
GO

/************** spGenerarCRCte *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRCte') and type = 'P') drop procedure dbo.spGenerarCRCte
GO
CREATE PROCEDURE spGenerarCRCte
			@Sucursal	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CRTipoCreditoCxc	bit  

  IF (SELECT UPPER(CRTipoCredito) FROM Sucursal WHERE Sucursal = @Sucursal) = 'CUENTAS POR COBRAR' SELECT @CRTipoCreditoCxc = 1 ELSE SELECT @CRTipoCreditoCxc = 0

  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crCte>'
  IF @CRTipoCreditoCxc = 0
    SELECT Sucursal, ID, Nombre, Estatus, Direccion, EntreCalles, Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, Observaciones, Publico, Descuento, Tipo
      FROM CRCte
     WHERE Sucursal = @Sucursal OR Publico = 1
       FOR XML RAW
  SELECT '</crCte>'
  RETURN 
END
GO


-- spGenerarCRCteIntelisis 3
/************** spGenerarCRCteIntelisis *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRCteIntelisis') and type = 'P') drop procedure dbo.spGenerarCRCteIntelisis
GO
CREATE PROCEDURE spGenerarCRCteIntelisis
   @Sucursal int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CRTipoCreditoCxc bit  
  IF (SELECT UPPER(CRTipoCredito) FROM Sucursal WHERE Sucursal = @Sucursal) = 'CUENTAS POR COBRAR' SELECT @CRTipoCreditoCxc = 1 ELSE SELECT @CRTipoCreditoCxc = 0
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crCteIntelisis>'
  IF @CRTipoCreditoCxc = 1
    SELECT "Sucursal" = c.SucursalEmpresa,
           c.Cliente,
           c.Nombre,
           c.Estatus,
           c.Direccion,
           c.EntreCalles,
           c.Delegacion,
           c.Colonia,
           c.Poblacion,
           c.Estado,
           c.Pais,
           c.Zona,
           c.CodigoPostal,
           c.RFC,
           c.CURP,
           c.Telefonos,
           c.Observaciones,
           c.Publico,
           "Descuento" = NULLIF(d.Porcentaje, 0),
           c.Tipo,
           c.ZonaImpuesto
      FROM Cte c
      LEFT OUTER JOIN Descuento d ON c.Descuento = d.Descuento
     WHERE (c.SucursalEmpresa = @Sucursal OR c.Publico = 1)
       FOR XML RAW
  SELECT '</crCteIntelisis>'
  RETURN 
END
GO

-- spGenerarCRCxc 'DEMO', 0
/************** spGenerarCRCxc *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRCxc') and type = 'P') drop procedure dbo.spGenerarCRCxc
GO
CREATE PROCEDURE spGenerarCRCxc
			@Empresa	char(5),
			@Sucursal	int
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crCxc>'
  SELECT Sucursal, ID, Cliente, "Referencia" = CONVERT(varchar(50), RTRIM(Mov) + ' ' + RTRIM(MovID)), Vencimiento, Moneda, Saldo
    FROM Cxc
   WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Estatus = 'PENDIENTE' AND ISNULL(Saldo, 0) > 0.0
     FOR XML RAW
  SELECT '</crCxc>'
  RETURN 
END
GO


-- spGenerarCRMovSoporte 'DEMO'
/************** spGenerarCRMovSoporte *************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarCRMovSoporte') and type = 'P') drop procedure dbo.spGenerarCRMovSoporte
GO
CREATE PROCEDURE spGenerarCRMovSoporte
			@Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crMovSoporte>'
  SELECT "Mov" = STMov1 
    FROM EmpresaCfgPV
   WHERE Empresa = @Empresa
     AND NULLIF(STMov1,'') IS NOT NULL
   UNION
  SELECT "Mov" = STMov2 
    FROM EmpresaCfgPV
   WHERE Empresa = @Empresa
     AND NULLIF(STMov2,'') IS NOT NULL
   UNION
  SELECT "Mov" = STMov3 
    FROM EmpresaCfgPV
   WHERE Empresa = @Empresa
     AND NULLIF(STMov3,'') IS NOT NULL
   UNION
  SELECT "Mov" = STMov4 
    FROM EmpresaCfgPV
   WHERE Empresa = @Empresa
     AND NULLIF(STMov4,'') IS NOT NULL
   UNION
  SELECT "Mov" = STMov5 
    FROM EmpresaCfgPV
   WHERE Empresa = @Empresa
     AND NULLIF(STMov5,'') IS NOT NULL
     FOR XML RAW
  SELECT '</crMovSoporte>'
  RETURN 
END
GO

/************** spIE_ValidacionRemota *************/
if exists (select * from sysobjects where id = object_id('dbo.spIE_ValidacionRemota') and type = 'P') drop procedure dbo.spIE_ValidacionRemota
GO
CREATE PROCEDURE spIE_ValidacionRemota
                	@AccesoID		int		= NULL,
		        @Proceso		varchar(255)	= NULL,
		        @Mov			varchar(20)	= NULL,
			@Referencia		varchar(255)	= NULL,
			@ID			int		= NULL,
			@Renglon		float		= NULL,
			@Campo			varchar(255)	= NULL,
			@Valor			varchar(255)	= NULL,
			@Accion			varchar(255)	= NULL,
               		@AutorizaUsuario 	varchar(20) 	= NULL,
               		@AutorizaContrasena 	varchar(20) 	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok		int,
    @OkRef	varchar(255),
    @Estatus	varchar(15)

  SELECT @Ok = NULL, @OkRef = NULL, @Estatus = NULL

  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<IntelisisExpress>'

  IF @Campo = 'ClienteIntelisis'
  BEGIN
    SELECT @Estatus = Estatus FROM Cte WHERE Cliente=@Valor
    IF @Estatus IS NULL 
      SELECT @Ok = 26060
    ELSE 
      IF @Estatus <> 'ALTA' SELECT @Ok = 10040, @OkRef = @Estatus
  END

  IF @Ok IS NOT NULL 
  BEGIN
    SELECT 'Numero' = @Ok, Descripcion, Tipo, Referencia = @OkRef
      FROM MensajeLista Mensaje
     WHERE Mensaje = @Ok
       FOR XML AUTO
    IF @@ROWCOUNT = 0
      SELECT '<Mensaje'+
          dbo.fnIE_XMLInt('Numero',  	@Ok)+
          dbo.fnIE_XML('Tipo',   	'ERROR')+
          dbo.fnIE_XML('Referencia', @OkRef)+
          '/>'
  END
/*
  SELECT '<ValidacionRemota>'
  SELECT '</ValidacionRemota>'
*/
  SELECT '</IntelisisExpress>'
  RETURN
END
GO

/************** spIntelisisWS *************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisWS') and type = 'P') drop procedure dbo.spIntelisisWS
GO
CREATE PROCEDURE spIntelisisWS
                	@xml			text
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok		int,
    @OkRef	varchar(255),
    @Estatus	varchar(15)

  SELECT @Ok = NULL, @OkRef = NULL, @Estatus = NULL

  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<Intelisis>'

  IF @Ok IS NOT NULL 
  BEGIN
    SELECT 'Numero' = @Ok, Descripcion, Tipo, Referencia = @OkRef
      FROM MensajeLista Mensaje
     WHERE Mensaje = @Ok
       FOR XML AUTO
    IF @@ROWCOUNT = 0
      SELECT '<Mensaje'+
          dbo.fnIE_XMLInt('Numero',  	@Ok)+
          dbo.fnIE_XML('Tipo',   	'ERROR')+
          dbo.fnIE_XML('Referencia', @OkRef)+
          '/>'
  END
  SELECT '</Intelisis>'
  RETURN
END
GO

/************** spRecibirCRMov *************/
if exists (select * from sysobjects where id = object_id('dbo.spRecibirCRMov') and type = 'P') drop procedure dbo.spRecibirCRMov
GO
CREATE PROCEDURE spRecibirCRMov
                   @xml		text,
		   @Sesion	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ixml		 int,
    @Sucursal		 int

  BEGIN TRANSACTION
    EXEC sp_xml_preparedocument @ixml OUTPUT, @xml

    SELECT @Sucursal = Sucursal
      FROM OPENXML (@ixml, 'CR') 
      WITH (Sucursal int)

    SET IDENTITY_INSERT crMovTemp ON
    INSERT crMovTemp (Sesion,  Sucursal, ID, FechaRegistro, Tipo, Cxc, Folio, FechaEmision, Estatus, Caja, CajaRef, Banco, Cajero, ClienteSucursal, Cliente, ClienteIntelisis, Referencia, Corte, FechaD, FechaA, Vencimiento, Concepto, FechaBanco, Enviado, CajeroCancelacion, OrigenID, OrigenTipo, OrigenFolio, Proveedor, ListaPrecios, CFDGenerado, CFDID, CFDSerie, CFDFolio) --MEJORA3051
    SELECT            @Sesion, Sucursal, ID, FechaRegistro, Tipo, Cxc, Folio, FechaEmision, Estatus, Caja, CajaRef, Banco, Cajero, ClienteSucursal, Cliente, ClienteIntelisis, Referencia, Corte, FechaD, FechaA, Vencimiento, Concepto, FechaBanco, Enviado, CajeroCancelacion, OrigenID, OrigenTipo, OrigenFolio, Proveedor, ListaPrecios, CFDGenerado, CFDID, CFDSerie, CFDFolio  --MEJORA3051
      FROM OPENXML (@ixml, 'CR/crMov/row') 
      WITH (Sucursal int, ID int, FechaRegistro datetime, Tipo varchar(20), Cxc bit, Folio int, FechaEmision datetime, Estatus char(15), Caja int, CajaRef int, Banco int, Cajero int, ClienteSucursal int, Cliente int, ClienteIntelisis varchar(10), Referencia varchar(50), Corte int, FechaD datetime, FechaA datetime, Vencimiento datetime, Concepto varchar(50), FechaBanco datetime, Enviado bit, CajeroCancelacion int, OrigenID int, OrigenTipo varchar(20), OrigenFolio int, Proveedor int, ListaPrecios varchar(20), CFDGenerado bit, CFDID int, CFDSerie varchar(20), CFDFolio varchar(20)) --MEJORA3051
      WHERE Sucursal = @Sucursal
    SET IDENTITY_INSERT crMovTemp OFF

    SET IDENTITY_INSERT crMovDTemp ON
    INSERT crMovDTemp (Sesion,  Sucursal, ID, RID, Tipo, Vendedor, FormaPago, Referencia, Articulo, SubCuenta, Departamento, Cantidad, Descuento1, Descuento2, Importe, Moneda, TipoCambio, Concepto, Unidad, Codigo, Ubicacion, Posicion, RenglonTipo, UsuarioAutorizacion, EsJuego, PrecioEspecial, PrecioNormal, Cancelado, Costo)
    SELECT             @Sesion, Sucursal, ID, RID, Tipo, Vendedor, FormaPago, Referencia, Articulo, SubCuenta, Departamento, Cantidad, Descuento1, Descuento2, Importe, Moneda, TipoCambio, Concepto, Unidad, Codigo, Ubicacion, Posicion, RenglonTipo, UsuarioAutorizacion, EsJuego, PrecioEspecial, PrecioNormal, Cancelado, Costo
      FROM OPENXML (@ixml, 'CR/crMovD/row') 
      WITH (Sucursal int, ID int, RID int, Tipo varchar(20), Vendedor int, FormaPago int, Referencia varchar(50), Articulo varchar(20), SubCuenta varchar(50), Departamento int, Cantidad float, Descuento1 float, Descuento2 float, Importe money, Moneda int, TipoCambio float, Concepto varchar(50), Unidad varchar(50), Codigo varchar(30), Ubicacion varchar(10), Posicion varchar(10), RenglonTipo char(1), UsuarioAutorizacion varchar(10), EsJuego bit, PrecioEspecial bit, PrecioNormal float, Cancelado bit, Costo money)
      WHERE Sucursal = @Sucursal
    SET IDENTITY_INSERT crMovDTemp OFF
    EXEC sp_xml_removedocument @ixml
  COMMIT TRANSACTION
END
GO

/************** spInsertarCR *************/
if exists (select * from sysobjects where id = object_id('dbo.spInsertarCR') and type = 'P') drop procedure dbo.spInsertarCR
GO
CREATE PROCEDURE spInsertarCR
			@CRID int OUTPUT, @Sucursal int, @Empresa varchar(5), @CRMov varchar(20), @Moneda varchar(10), @TipoCambio float, @FechaTrabajo datetime, @CtaCaja varchar(10), @CajaFolio int, @CtaCajero varchar(10), @FechaD datetime, @FechaA datetime, @Referencia varchar(50), @CREstatusSinAfectar varchar(15), @DocFuente int, @Usuario varchar(10), @Ok int OUTPUT, @OkRef varchar(255) OUTPUT		
--//WITH ENCRYPTION
AS BEGIN
  INSERT CR (Sucursal,  SucursalOrigen, Empresa,  Mov,    Moneda,  TipoCambio,  FechaEmision,  Caja,     CajaFolio,  Cajero,     FechaD,  FechaA,  Referencia,  Estatus,              DocFuente,  Usuario)
     VALUES (@Sucursal, @Sucursal,      @Empresa, @CRMov, @Moneda, @TipoCambio, @FechaTrabajo, @CtaCaja, @CajaFolio, @CtaCajero, @FechaD, @FechaA, @Referencia, @CREstatusSinAfectar, @DocFuente, @Usuario)
  SELECT @CRID = SCOPE_IDENTITY()
  RETURN
END
GO

/************** spInsertarCRVenta *************/
if exists (select * from sysobjects where id = object_id('dbo.spInsertarCRVenta') and type = 'P') drop procedure dbo.spInsertarCRVenta
GO
CREATE PROCEDURE spInsertarCRVenta
			@CRID int, @Sucursal int, @Renglon float, @Articulo varchar(20), @SubCuenta varchar(50), @Operaciones int, @Almacen varchar(10), @Posicion varchar(10), @Cliente varchar(10), @Cxc bit, @Mov varchar(20), @MovID varchar(20), @Cantidad float, @DescuentoLinea float, @Importe money, @CFDSerie varchar(20), @CFDFolio varchar(20), @Ok int OUTPUT, @OkRef varchar(255) OUTPUT --MEJORA3051
--//WITH ENCRYPTION
AS BEGIN
  INSERT CRVenta 
         (ID,    Sucursal,  Renglon,  Articulo,  SubCuenta,  Operaciones,  Almacen,  Posicion,  Cliente,  Cxc,  Mov,  MovID,  Cantidad,  DescuentoLinea,  Importe,  CFDSerie,  CFDFolio)   --MEJORA3051
  VALUES (@CRID, @Sucursal, @Renglon, @Articulo, @SubCuenta, @Operaciones, @Almacen, @Posicion, @Cliente, @Cxc, @Mov, @MovID, @Cantidad, @DescuentoLinea, @Importe, @CFDSerie, @CFDFolio)  --MEJORA3051
END
GO

/************** spCRVenta *************/
if exists (select * from sysobjects where id = object_id('dbo.spCRVenta') and type = 'P') drop procedure dbo.spCRVenta
GO
CREATE PROCEDURE spCRVenta
			@CRID			int, 
			@Sucursal		int, 
			@Almacen		varchar(10),
			@CRProcesoDistribuido	bit, 
			@CRServidorOperaciones	varchar(50), 
			@CRBaseDatosOperaciones	varchar(50), 
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT		
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cxc		bit,
    @Renglon		float,
    @Articulo		varchar(20),
    @SubCuenta		varchar(50),
    @Cantidad		float,
    @Precio		float,
    @DescuentoLinea	float,
    @Importe		money,
    @Operaciones	int,
    @Cliente		varchar(10),
    @ClienteEnviarA	int,
    @Posicion		varchar(10),
    @DescripcionExtra	varchar(100),
    @Mov		varchar(20),
    @MovID		varchar(20),
    @CFDSerie   varchar(20), --MEJORA3051
    @CFDFolio	varchar(20), --MEJORA3051
    @SQL		nvarchar(4000),
    @Params		nvarchar(4000)

  SELECT @Renglon = 0.0
  DECLARE crCRVenta CURSOR LOCAL FOR 
   SELECT Articulo, SubCuenta, Operaciones, ISNULL(NULLIF(RTRIM(Almacen), ''), @Almacen), Posicion, Cliente, ISNULL(Cxc, 0), Mov, MovID, Cantidad, DescuentoLinea, Importe, ISNULL(CFDSerie,''), ISNULL(CFDFolio,'') --MEJORA3051
    FROM #CRVenta2
  OPEN crCRVenta
  FETCH NEXT FROM crCRVenta INTO @Articulo, @SubCuenta, @Operaciones, @Almacen, @Posicion, @Cliente, @Cxc, @Mov, @MovID, @Cantidad, @DescuentoLinea, @Importe, @CFDSerie, @CFDFolio --MEJORA3051
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048.0
      SELECT @SQL = N'EXEC '
      IF @CRProcesoDistribuido = 1 SELECT @SQL = @SQL + @CRServidorOperaciones+'.'+@CRBaseDatosOperaciones+'.dbo.'
      SELECT @SQL = @SQL + N'spInsertarCRVenta @CRID, @Sucursal, @Renglon, @Articulo, @SubCuenta, @Operaciones, @Almacen, @Posicion, @Cliente, @Cxc, @Mov, @MovID, @Cantidad, @DescuentoLinea, @Importe, @CFDSerie, @CFDFolio, @Ok OUTPUT, @OkRef OUTPUT' --MEJORA3051
      SELECT @Params = N'@CRID int, @Sucursal int, @Renglon float, @Articulo varchar(20), @SubCuenta varchar(50), @Operaciones int, @Almacen varchar(10), @Posicion varchar(10), @Cliente varchar(10), @Cxc bit, @Mov varchar(20), @MovID varchar(20), @Cantidad float, @DescuentoLinea float, @Importe money, @CFDSerie varchar(20), @CFDFolio varchar(20), @Ok int OUTPUT, @OkRef varchar(255) OUTPUT' --MEJORA3051
      EXEC sp_executesql @SQL, @Params, @CRID, @Sucursal, @Renglon, @Articulo, @SubCuenta, @Operaciones, @Almacen, @Posicion, @Cliente, @Cxc, @Mov, @MovID, @Cantidad, @DescuentoLinea, @Importe, @CFDSerie, @CFDFolio, @Ok OUTPUT, @OkRef OUTPUT
    END
    FETCH NEXT FROM crCRVenta INTO @Articulo, @SubCuenta, @Operaciones, @Almacen, @Posicion, @Cliente, @Cxc, @Mov, @MovID, @Cantidad, @DescuentoLinea, @Importe, @CFDSerie, @CFDFolio --MEJORA3051
  END -- While
  CLOSE crCRVenta
  DEALLOCATE crCRVenta

  RETURN
END
GO

/************** spInsertarCRAgente *************/
if exists (select * from sysobjects where id = object_id('dbo.spInsertarCRAgente') and type = 'P') drop procedure dbo.spInsertarCRAgente
GO
CREATE PROCEDURE spInsertarCRAgente
			@CRID int, @Sucursal int, @Renglon float, @Agente varchar(10), @Operaciones int, @Cantidad float, @Importe money, @Ok int OUTPUT, @OkRef varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  INSERT CRAgente 
         (ID,    Sucursal,  Renglon,  Agente,   Operaciones,  Cantidad, Importe)
  VALUES (@CRID, @Sucursal, @Renglon, @Agente, @Operaciones, @Cantidad, @Importe)
END
GO

/************** spCRAgente *************/
if exists (select * from sysobjects where id = object_id('dbo.spCRAgente') and type = 'P') drop procedure dbo.spCRAgente
GO
CREATE PROCEDURE spCRAgente
			@CRID			int, 
			@Sucursal		int, 
			@CRProcesoDistribuido	bit, 
			@CRServidorOperaciones	varchar(50), 
			@CRBaseDatosOperaciones	varchar(50), 
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT		
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon		float,
    @Agente		varchar(10),
    @Cantidad		float,
    @Importe		money,
    @Operaciones	int,
    @SQL		nvarchar(4000),
    @Params		nvarchar(4000)

  SELECT @Renglon = 0.0
  DECLARE crCRAgente CURSOR LOCAL FOR 
   SELECT Agente, Operaciones, Cantidad, Importe
     FROM #CRAgente
  OPEN crCRAgente
  FETCH NEXT FROM crCRAgente INTO @Agente, @Operaciones, @Cantidad, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048.0
      SELECT @SQL = N'EXEC '
      IF @CRProcesoDistribuido = 1 SELECT @SQL = @SQL + @CRServidorOperaciones+'.'+@CRBaseDatosOperaciones+'.dbo.'
      SELECT @SQL = @SQL + N'spInsertarCRAgente @CRID, @Sucursal, @Renglon, @Agente, @Operaciones, @Cantidad, @Importe, @Ok OUTPUT, @OkRef OUTPUT'
      SELECT @Params = N'@CRID int, @Sucursal int, @Renglon float, @Agente varchar(10), @Operaciones int, @Cantidad float, @Importe money, @Ok int OUTPUT, @OkRef varchar(255) OUTPUT'
      EXEC sp_executesql @SQL, @Params, @CRID, @Sucursal, @Renglon, @Agente, @Operaciones, @Cantidad, @Importe, @Ok OUTPUT, @OkRef OUTPUT
    END
    FETCH NEXT FROM crCRAgente INTO @Agente, @Operaciones, @Cantidad, @Importe
  END -- While
  CLOSE crCRAgente
  DEALLOCATE crCRAgente
  RETURN
END
GO

/************** spInsertarCRCobro *************/
if exists (select * from sysobjects where id = object_id('dbo.spInsertarCRCobro') and type = 'P') drop procedure dbo.spInsertarCRCobro
GO
CREATE PROCEDURE spInsertarCRCobro
			@CRID int, @Sucursal int, @Renglon float, @FormaPago varchar(50), @Referencia varchar(50), @Moneda varchar(10), @TipoCambio float, @Cliente varchar(10), @Cxc bit, @Vencimiento datetime, @Importe money, @CFDSerie varchar(20), @CFDFolio varchar(20), @Ok int OUTPUT, @OkRef varchar(255) OUTPUT --MEJORA3051
--//WITH ENCRYPTION
AS BEGIN
  INSERT CRCobro 
         (ID,    Sucursal,  Renglon,  FormaPago,  Referencia,  Moneda,  TipoCambio,  Cliente,  Cxc,  Vencimiento,  Importe,  CFDSerie,  CFDFolio) --MEJORA3051
  VALUES (@CRID, @Sucursal, @Renglon, @FormaPago, @Referencia, @Moneda, @TipoCambio, @Cliente, @Cxc, @Vencimiento, @Importe, @CFDSerie, @CFDFolio) --MEJORA3051
END
GO

/************** spCRCobro *************/
if exists (select * from sysobjects where id = object_id('dbo.spCRCobro') and type = 'P') drop procedure dbo.spCRCobro
GO
CREATE PROCEDURE spCRCobro
			@CRID			int, 
			@Sucursal		int, 
			@CRProcesoDistribuido	bit, 
			@CRServidorOperaciones	varchar(50), 
			@CRBaseDatosOperaciones	varchar(50), 
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT		
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon		float,
    @Cxc		bit,
    @FormaPago		varchar(50),
    @Referencia		varchar(50),
    @Importe		money,
    @Moneda		varchar(10),
    @TipoCambio		float,
    @Cliente		varchar(10),
    @ClienteEnviarA	int,
    @CFDSerie		varchar(20), --MEJORA3051
    @CFDFolio		varchar(20), --MEJORA3051
    @Vencimiento	datetime,
    @SQL		nvarchar(4000),
    @Params		nvarchar(4000)

  SELECT @Renglon = 0.0
  DECLARE crCRCobro CURSOR LOCAL FOR 
   SELECT FormaPago, Referencia, Moneda, TipoCambio, Cliente, ISNULL(Cxc, 0), Vencimiento, Importe, ISNULL(CFDSerie,''), ISNULL(CFDFolio,'') --MEJORA3051
     FROM #CRCobro
  OPEN crCRCobro
  FETCH NEXT FROM crCRCobro INTO @FormaPago, @Referencia, @Moneda, @TipoCambio, @Cliente, @Cxc, @Vencimiento, @Importe, @CFDSerie, @CFDFolio --MEJORA3051
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048.0
      SELECT @SQL = N'EXEC '
      IF @CRProcesoDistribuido = 1 SELECT @SQL = @SQL + @CRServidorOperaciones+'.'+@CRBaseDatosOperaciones+'.dbo.'
      SELECT @SQL = @SQL + N'spInsertarCRCobro @CRID, @Sucursal, @Renglon, @FormaPago, @Referencia, @Moneda, @TipoCambio, @Cliente, @Cxc, @Vencimiento, @Importe, @CFDSerie, @CFDFolio, @Ok OUTPUT, @OkRef OUTPUT' --MEJORA3051
      SELECT @Params = N'@CRID int, @Sucursal int, @Renglon float, @FormaPago varchar(50), @Referencia varchar(50), @Moneda varchar(10), @TipoCambio float, @Cliente varchar(10), @Cxc bit, @Vencimiento datetime, @Importe money, @CFDSerie varchar(20), @CFDFolio varchar(20), @Ok int OUTPUT, @OkRef varchar(255) OUTPUT' --MEJORA3051
      EXEC sp_executesql @SQL, @Params, @CRID, @Sucursal, @Renglon, @FormaPago, @Referencia, @Moneda, @TipoCambio, @Cliente, @Cxc, @Vencimiento, @Importe, @CFDSerie, @CFDFolio, @Ok OUTPUT, @OkRef OUTPUT --MEJORA3051
    END
    FETCH NEXT FROM crCRCobro INTO @FormaPago, @Referencia, @Moneda, @TipoCambio, @Cliente, @Cxc, @Vencimiento, @Importe, @CFDSerie, @CFDFolio --MEJORA3051
  END -- While
  CLOSE crCRCobro
  DEALLOCATE crCRCobro

  RETURN
END
GO

/************** spInsertarCRCaja *************/
if exists (select * from sysobjects where id = object_id('dbo.spInsertarCRCaja') and type = 'P') drop procedure dbo.spInsertarCRCaja
GO
CREATE PROCEDURE spInsertarCRCaja
			@CRID int, @Sucursal int, @Renglon float, @Movimiento varchar(20), @CtaDinero varchar(10), @FechaBanco datetime, @Concepto varchar(50), @FormaPago varchar(50), @Referencia varchar(50), @Moneda varchar(10), @TipoCambio float, @Importe money, @Ok int OUTPUT, @OkRef varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  INSERT CRCaja 
         (ID,    Sucursal,  Renglon,  Movimiento,  CtaDinero,  FechaEmision, Concepto,  FormaPago,  Referencia,  Moneda,  TipoCambio,  Importe)
  VALUES (@CRID, @Sucursal, @Renglon, @Movimiento, @CtaDinero, @FechaBanco,  @Concepto, @FormaPago, @Referencia, @Moneda, @TipoCambio, @Importe)
END
GO

/************** spCRCaja *************/
if exists (select * from sysobjects where id = object_id('dbo.spCRCaja') and type = 'P') drop procedure dbo.spCRCaja
GO
CREATE PROCEDURE spCRCaja
			@CRID			int, 
			@Sucursal		int, 
			@CRProcesoDistribuido	bit, 
			@CRServidorOperaciones	varchar(50), 
			@CRBaseDatosOperaciones	varchar(50), 
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT		
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon		float,
    @Movimiento		varchar(20),
    @CtaDinero		varchar(10),
    @FormaPago		varchar(50),
    @Referencia		varchar(50),
    @Importe		money,
    @Moneda		varchar(10),
    @TipoCambio		float,
    @FechaEmision	datetime,
    @FechaBanco		datetime,
    @Concepto		varchar(50),
    @SQL		nvarchar(4000),
    @Params		nvarchar(4000)

  SELECT @Renglon = 0.0
  DECLARE crCRCaja CURSOR LOCAL FOR 
   SELECT Movimiento, CtaDinero, FechaBanco, Concepto, FormaPago, Referencia, Moneda, TipoCambio, Importe
     FROM #CRCaja
  OPEN crCRCaja
  FETCH NEXT FROM crCRCaja INTO @Movimiento, @CtaDinero, @FechaBanco, @Concepto, @FormaPago, @Referencia, @Moneda, @TipoCambio, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048.0
      SELECT @SQL = N'EXEC '
      IF @CRProcesoDistribuido = 1 SELECT @SQL = @SQL + @CRServidorOperaciones+'.'+@CRBaseDatosOperaciones+'.dbo.'
      SELECT @SQL = @SQL + N'spInsertarCRCaja @CRID, @Sucursal, @Renglon, @Movimiento, @CtaDinero, @FechaBanco, @Concepto, @FormaPago, @Referencia, @Moneda, @TipoCambio, @Importe, @Ok OUTPUT, @OkRef OUTPUT'
      SELECT @Params = N'@CRID int, @Sucursal int, @Renglon float, @Movimiento varchar(20), @CtaDinero varchar(10), @FechaBanco datetime, @Concepto varchar(50), @FormaPago varchar(50), @Referencia varchar(50), @Moneda varchar(10), @TipoCambio float, @Importe money, @Ok int OUTPUT, @OkRef varchar(255) OUTPUT'
      EXEC sp_executesql @SQL, @Params, @CRID, @Sucursal, @Renglon, @Movimiento, @CtaDinero, @FechaBanco, @Concepto, @FormaPago, @Referencia, @Moneda, @TipoCambio, @Importe, @Ok OUTPUT, @OkRef OUTPUT
    END
    FETCH NEXT FROM crCRCaja INTO @Movimiento, @CtaDinero, @FechaBanco, @Concepto, @FormaPago, @Referencia, @Moneda, @TipoCambio, @Importe
  END -- While
  CLOSE crCRCaja
  DEALLOCATE crCRCaja

  RETURN
END
GO

/************** spInsertarCRInvFisico *************/
if exists (select * from sysobjects where id = object_id('dbo.spInsertarCRInvFisico') and type = 'P') drop procedure dbo.spInsertarCRInvFisico
GO
CREATE PROCEDURE spInsertarCRInvFisico
			@CRID int, @Sucursal int, @Renglon float, @Articulo varchar(20), @SubCuenta varchar(50), @Cantidad float, @Unidad varchar(50), @Posicion varchar(10), @Ok int OUTPUT, @OkRef varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  INSERT CRInvFisico 
         (ID,    Sucursal,  Renglon,  Articulo,  SubCuenta,  Cantidad,  Unidad,  Posicion)
  VALUES (@CRID, @Sucursal, @Renglon, @Articulo, @SubCuenta, @Cantidad, @Unidad, @Posicion)
END
GO

/************** spCRInvFisico *************/
if exists (select * from sysobjects where id = object_id('dbo.spCRInvFisico') and type = 'P') drop procedure dbo.spCRInvFisico
GO
CREATE PROCEDURE spCRInvFisico
			@CRID			int, 
			@Sucursal		int, 
			@CRProcesoDistribuido	bit, 
			@CRServidorOperaciones	varchar(50), 
			@CRBaseDatosOperaciones	varchar(50), 
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT		
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon	float,
    @Articulo	varchar(20),
    @SubCuenta	varchar(50),
    @Cantidad	float,
    @Unidad	varchar(50),
    @Posicion	varchar(10),
    @SQL	nvarchar(4000),
    @Params	nvarchar(4000)

  SELECT @Renglon = 0.0
  DECLARE crCRInvFisico CURSOR LOCAL FOR 
   SELECT Articulo, SubCuenta, Cantidad, Unidad, Posicion
     FROM #CRInvFisico
  OPEN crCRInvFisico
  FETCH NEXT FROM crCRInvFisico INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @Posicion
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048.0
      SELECT @SQL = N'EXEC '
      IF @CRProcesoDistribuido = 1 SELECT @SQL = @SQL + @CRServidorOperaciones+'.'+@CRBaseDatosOperaciones+'.dbo.'
      SELECT @SQL = @SQL + N'spInsertarCRInvFisico @CRID, @Sucursal, @Renglon, @Articulo, @SubCuenta, @Cantidad, @Unidad, @Posicion, @Ok OUTPUT, @OkRef OUTPUT'
      SELECT @Params = N'@CRID int, @Sucursal int, @Renglon float, @Articulo varchar(20), @SubCuenta varchar(50), @Cantidad float, @Unidad varchar(50), @Posicion varchar(10), @Ok int OUTPUT, @OkRef varchar(255) OUTPUT'
      EXEC sp_executesql @SQL, @Params, @CRID, @Sucursal, @Renglon, @Articulo, @SubCuenta, @Cantidad, @Unidad, @Posicion, @Ok OUTPUT, @OkRef OUTPUT
    END
    FETCH NEXT FROM crCRInvFisico INTO @Articulo, @SubCuenta, @Cantidad, @Unidad, @Posicion
  END -- While
  CLOSE crCRInvFisico
  DEALLOCATE crCRInvFisico

  RETURN
END
GO

/************** spInsertarCRSoporte *************/
if exists (select * from sysobjects where id = object_id('dbo.spInsertarCRSoporte') and type = 'P') drop procedure dbo.spInsertarCRSoporte
GO
CREATE PROCEDURE spInsertarCRSoporte
			@CRID int, @Sucursal int, @Renglon float, @Mov varchar(20), @Cliente varchar(10), @Contacto varchar(50), @Telefono varchar(30), @Titulo varchar(100), @Problema varchar(8000), @Ok int OUTPUT, @OkRef varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  INSERT CRSoporte 
         (ID,    Sucursal,  Renglon,  Mov,  Cliente,  Contacto,  Telefono,  Titulo,  Problema)
  VALUES (@CRID, @Sucursal, @Renglon, @Mov, @Cliente, @Contacto, @Telefono, @Titulo, @Problema)
END
GO

/************** spCRSoporte *************/
if exists (select * from sysobjects where id = object_id('dbo.spCRSoporte') and type = 'P') drop procedure dbo.spCRSoporte
GO
CREATE PROCEDURE spCRSoporte
			@CRID			int, 
			@Sucursal		int, 
			@CRProcesoDistribuido	bit, 
			@CRServidorOperaciones	varchar(50), 
			@CRBaseDatosOperaciones	varchar(50), 
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT		
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon	float,
    @Mov	varchar(20),
    @Cliente	varchar(10),
    @Contacto	varchar(50),
    @Telefono	varchar(30),
    @Titulo	varchar(100),
    @Problema	varchar(8000),
    @SQL	nvarchar(4000),
    @Params	nvarchar(4000)

  SELECT @Renglon = 0.0
  DECLARE crCRSoporte CURSOR LOCAL FOR 
   SELECT Mov, Cliente, Contacto, Telefono, Titulo, CONVERT(varchar(8000), Problema)
     FROM #CRSoporte
  OPEN crCRSoporte
  FETCH NEXT FROM crCRSoporte INTO @Mov, @Cliente, @Contacto, @Telefono, @Titulo, @Problema
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048.0
      SELECT @SQL = N'EXEC '
      IF @CRProcesoDistribuido = 1 SELECT @SQL = @SQL + @CRServidorOperaciones+'.'+@CRBaseDatosOperaciones+'.dbo.'
      SELECT @SQL = @SQL + N'spInsertarCRSoporte @CRID, @Sucursal, @Renglon, @Mov, @Cliente, @Contacto, @Telefono, @Titulo, @Problema, @Ok OUTPUT, @OkRef OUTPUT'
      SELECT @Params = N'@CRID int, @Sucursal int, @Renglon float, @Mov varchar(20), @Cliente varchar(10), @Contacto varchar(50), @Telefono varchar(30), @Titulo varchar(100), @Problema varchar(8000), @Ok int OUTPUT, @OkRef varchar(255) OUTPUT'
      EXEC sp_executesql @SQL, @Params, @CRID, @Sucursal, @Renglon, @Mov, @Cliente, @Contacto, @Telefono, @Titulo, @Problema, @Ok OUTPUT, @OkRef OUTPUT
    END
    FETCH NEXT FROM crCRSoporte INTO @Mov, @Cliente, @Contacto, @Telefono, @Titulo, @Problema
  END -- While
  CLOSE crCRSoporte
  DEALLOCATE crCRSoporte
  RETURN
END
GO


/************** spRecibirCR *************/
if exists (select * from sysobjects where id = object_id('dbo.spRecibirCR') and type = 'P') drop procedure dbo.spRecibirCR
GO
CREATE PROCEDURE spRecibirCR
                   @xml		text,
		   @NoAfectar 	bit = 0,
                   @Sesion	varchar(50) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ixml		 int,
    @Empresa		 char(5),
    @Sucursal		 int,
    @Prefijo		 varchar(5),
    @CajaCentral	 int,
    @Usuario		 char(10),
    @Almacen		 char(10),
    @Moneda		 char(10),
    @TipoCambio		 float,
    @FechaTrabajo	 datetime,
    @FechaRegistro	 datetime,
    @Ok			 int,
    @OkRef		 varchar(255),
    @CorteCajaMov	 char(20),
    @CorteCajaCentralMov char(20),
    @CRMov		 char(20),
    @CRMovID		 varchar(20),
    @CRID		 int,
    @Articulo		 char(20),
    @SubCuenta		 varchar(20),
    @Departamento	 int,
    @Cantidad		 float,
    @Importe		 money,
    @Renglon		 float,
    @RenglonID		 int,
    @ID			 int,
    @Caja		 int,
    @CajaRef		 int,
    @Cajero		 int,
    @FechaD		 datetime,
    @FechaA		 datetime,
    @DocFuente		 int,
    @CajaFolio		 int,
    @Banco		 int,
    @CtaRef		 char(10),
    @CtaDinero		 char(10),
    @CtaCaja		 char(10),
    @CtaCajero		 char(10),
    @CtaCajaCentral	 char(10),
    @DepositoMov 	 char(20),
    @ChequeMov   	 char(20),
    @IngresoMov  	 char(20),
    @EgresoMov   	 char(20),
    @DineroMov		 char(20),
    @DineroMovID	 varchar(20),
    @DineroID		 int,
    @Referencia		 varchar(50),
    @Mensaje		 varchar(255),
    @SQL			nvarchar(4000),
    @Params			nvarchar(4000),
    @CRProcesoDistribuido	bit,
    @CRServidorOperaciones	varchar(50),
    @CRBaseDatosOperaciones	varchar(50),
    @CRAfectarAuto		bit,
    @CREstatusSinAfectar	varchar(15),
    @CRCerrarDiaAuto		bit/*,
    @CRTipoCredito	varchar(20), 
    @CRTipoCreditoCxc	bit,
    @ArtRedondeo	varchar(20)*/

  SELECT @Ok = NULL, @OkRef = NULL, @SubCuenta = NULL, @Renglon = 0.0, @RenglonID = 0, /*@CRTipoCreditoCxc = 0, */@FechaRegistro = GETDATE()

  BEGIN TRANSACTION
    EXEC sp_xml_preparedocument @ixml OUTPUT, @xml
    SELECT @Empresa = Empresa, @Sucursal = Sucursal, @CajaCentral = CajaCentral, @FechaTrabajo = FechaTrabajo
      FROM OPENXML (@ixml, 'CR') 
      WITH (Empresa char(5), Sucursal int, CajaCentral int, FechaTrabajo datetime)

    SELECT @Usuario = Usuario,
           @Prefijo = Prefijo,
           @Almacen = AlmacenPrincipal/*,
           @CRTipoCredito = UPPER(CRTipoCredito)*/
      FROM Sucursal 
     WHERE Sucursal = @Sucursal
--    IF @CRTipoCredito = 'CUENTAS POR COBRAR' SELECT @CRTipoCreditoCxc = 1

    SELECT @CRProcesoDistribuido = ISNULL(CRProcesoDistribuido, 0),
           @CRServidorOperaciones = CRServidorOperaciones,
           @CRBaseDatosOperaciones = CRBaseDatosOperaciones,
           @CRAfectarAuto = ISNULL(CRAfectarAuto, 0),
           @CREstatusSinAfectar = CREstatusSinAfectar,
           @CRCerrarDiaAuto = CRCerrarDiaAuto/*,
           @ArtRedondeo	= ArtRedondeo*/
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

    IF @NoAfectar = 1 SELECT @CRAfectarAuto = 0

    IF @Usuario IS NULL
      SELECT @Ok = 10560, @OkRef = CONVERT(varchar, @Sucursal)

    IF @Almacen IS NULL
      SELECT @Ok = 10570, @OkRef = CONVERT(varchar, @Sucursal)

    IF EXISTS(SELECT * FROM crMov WHERE Sucursal = @Sucursal AND FechaEmision = @FechaTrabajo)
      SELECT @Ok = 10550

    /*IF NOT EXISTS(SELECT * FROM Art WHERE Articulo = @ArtRedondeo)
      SELECT @Ok = 10600*/

    IF @Ok IS NULL
    BEGIN
      DELETE crCta WHERE Sucursal = @Sucursal
      INSERT crCta (Sucursal, Tipo, Numero, Nombre, Estatus, ClaveIntelisis, CajeroContrasena, CajeroEditarNota, CajeroPermiteDesc, CajeroCancelarNotas, CajeroReasignarCliente, CajeroCteExpress, CajeroCteExpressDesc, CajeroVerSaldo, CajeroRealizarCorte, CajeroAnticipo, CajeroDevAnticipo, CajeroGasto, CajeroDevolucionGasto, CajeroPrestamo, CajeroDevPrestamo, CajeroVentaCredito, CajeroDevolucionCredito, CajeroCobroCredito, CajeroMovsOtrosCajeros, CajeroMovsOtrasCajas, VendedorDeptoOmision, CajaLimiteInferior, CajaLimiteSuperior, CajaFondoFijo, CajaPausaValidar, VendedorPresupuesto, MonedaTipoCambio, BancoNumeroCuenta, FormaPagoReferenciaOmision, VendedorPrimerFolio, VendedorUltimoFolio, CajaSaltosRenglon, CajaPausaImprimir, CajaAbrirCajon, CajaCortarTicket, CajaValidarNota, CajaImpresionNegritas, CajaImpresionComprimido, CajaImpresionNormal, CajaCortarPapel, CajaSiguienteDia, MonedaTipoCambioCompra, MonedaTipoCambioVenta, CajaVentasPorHora, CajaPuertoLocal, CajeroBorrarCapturaAlm, CajeroBotonArticulos, CajeroBotonBancos, CajeroBotonCajas, CajeroBotonCajeros, CajeroBotonCerrarSucursal, CajeroBotonClientes, CajeroBotonConceptos, CajeroBotonConfigurar, CajeroBotonDepartamentos, CajeroBotonEliminar, CajeroBotonesPermitidos, CajeroBotonFormasPago, CajeroBotonMonedas, CajeroBotonSaldoCajas, CajeroBotonVendedores, CajeroCancelarMovsCaja, CajeroCancelarVentaActual, CajeroCapacidades, CajeroCapacidadesEspeciales, CajeroConfigurarAdmin, CajeroEditarTipoCambio, CajeroModificarRango, CajeroMovCorteCaja, CajeroMovFondoInicial, CajeroMovRecoleccion, CajeroMovsAlmacen, CajeroMovsPermitidos, CajeroPassword, CajeroReimprimirNota, CajeroUsarAdmin, FormaPagoAceptarCambio, FormaPagoDesglosar, FormaPagoMonedaEspecifica, FormaPagoRecolectar, CajeroMovAjusteSaldo, CajeroVencimContrasena)
      SELECT        Sucursal, Tipo, Numero, Nombre, Estatus, ClaveIntelisis, CajeroContrasena, CajeroEditarNota, CajeroPermiteDesc, CajeroCancelarNotas, CajeroReasignarCliente, CajeroCteExpress, CajeroCteExpressDesc, CajeroVerSaldo, CajeroRealizarCorte, CajeroAnticipo, CajeroDevAnticipo, CajeroGasto, CajeroDevolucionGasto, CajeroPrestamo, CajeroDevPrestamo, CajeroVentaCredito, CajeroDevolucionCredito, CajeroCobroCredito, CajeroMovsOtrosCajeros, CajeroMovsOtrasCajas, VendedorDeptoOmision, CajaLimiteInferior, CajaLimiteSuperior, CajaFondoFijo, CajaPausaValidar, VendedorPresupuesto, MonedaTipoCambio, BancoNumeroCuenta, FormaPagoReferenciaOmision, VendedorPrimerFolio, VendedorUltimoFolio, CajaSaltosRenglon, CajaPausaImprimir, CajaAbrirCajon, CajaCortarTicket, CajaValidarNota, CajaImpresionNegritas, CajaImpresionComprimido, CajaImpresionNormal, CajaCortarPapel, CajaSiguienteDia, MonedaTipoCambioCompra, MonedaTipoCambioVenta, CajaVentasPorHora, CajaPuertoLocal, CajeroBorrarCapturaAlm, CajeroBotonArticulos, CajeroBotonBancos, CajeroBotonCajas, CajeroBotonCajeros, CajeroBotonCerrarSucursal, CajeroBotonClientes, CajeroBotonConceptos, CajeroBotonConfigurar, CajeroBotonDepartamentos, CajeroBotonEliminar, CajeroBotonesPermitidos, CajeroBotonFormasPago, CajeroBotonMonedas, CajeroBotonSaldoCajas, CajeroBotonVendedores, CajeroCancelarMovsCaja, CajeroCancelarVentaActual, CajeroCapacidades, CajeroCapacidadesEspeciales, CajeroConfigurarAdmin, CajeroEditarTipoCambio, CajeroModificarRango, CajeroMovCorteCaja, CajeroMovFondoInicial, CajeroMovRecoleccion, CajeroMovsAlmacen, CajeroMovsPermitidos, CajeroPassword, CajeroReimprimirNota, CajeroUsarAdmin, FormaPagoAceptarCambio, FormaPagoDesglosar, FormaPagoMonedaEspecifica, FormaPagoRecolectar, CajeroMovAjusteSaldo, CajeroVencimContrasena
        FROM OPENXML (@ixml, 'CR/crCta/row') 
        WITH (Sucursal int, ID int, Tipo varchar(20), Numero int, Nombre varchar(100), Estatus char(15), ClaveIntelisis varchar(50), CajeroContrasena varchar(20), CajeroEditarNota bit, CajeroPermiteDesc bit, CajeroCancelarNotas bit, CajeroReasignarCliente bit, CajeroCteExpress bit, CajeroCteExpressDesc bit, CajeroVerSaldo bit, VendedorDeptoOmision int, CajaLimiteInferior money, CajaLimiteSuperior money, CajaFondoFijo money, CajaPausaValidar bit, VendedorPresupuesto float, MonedaTipoCambio float, BancoNumeroCuenta varchar(100), CajeroRealizarCorte bit, CajeroAnticipo bit, CajeroDevAnticipo bit, CajeroGasto bit, CajeroDevolucionGasto bit, CajeroPrestamo bit, CajeroDevPrestamo bit, CajeroVentaCredito bit, CajeroDevolucionCredito bit, CajeroCobroCredito bit, CajeroMovsOtrosCajeros bit, CajeroMovsOtrasCajas bit, FormaPagoReferenciaOmision varchar(50), VendedorPrimerFolio varchar(10), VendedorUltimoFolio varchar(10), CajaSaltosRenglon int, CajaPausaImprimir int, CajaAbrirCajon varchar(100), CajaCortarTicket varchar(100), CajaValidarNota varchar(100), CajaImpresionNegritas varchar(100), CajaImpresionComprimido varchar(100), CajaImpresionNormal varchar(100), CajaCortarPapel bit, CajaSiguienteDia bit, MonedaTipoCambioCompra float, MonedaTipoCambioVenta float, CajaVentasPorHora float,
              CajaPuertoLocal char(10), CajeroBorrarCapturaAlm bit, CajeroBotonArticulos bit, CajeroBotonBancos bit, CajeroBotonCajas bit, CajeroBotonCajeros bit, CajeroBotonCerrarSucursal bit, CajeroBotonClientes bit, CajeroBotonConceptos bit, CajeroBotonConfigurar bit, CajeroBotonDepartamentos bit, CajeroBotonEliminar bit, CajeroBotonesPermitidos bit, CajeroBotonFormasPago bit, CajeroBotonMonedas bit, CajeroBotonSaldoCajas bit, CajeroBotonVendedores bit, CajeroCancelarMovsCaja bit, CajeroCancelarVentaActual bit, CajeroCapacidades bit, CajeroCapacidadesEspeciales bit, CajeroConfigurarAdmin bit, CajeroEditarTipoCambio bit, CajeroModificarRango bit, CajeroMovCorteCaja bit, CajeroMovFondoInicial bit, CajeroMovRecoleccion bit, CajeroMovsAlmacen bit, CajeroMovsPermitidos bit, CajeroPassword bit, CajeroReimprimirNota bit, CajeroUsarAdmin bit, FormaPagoAceptarCambio bit, FormaPagoDesglosar bit, FormaPagoMonedaEspecifica varchar(100), FormaPagoRecolectar bit, CajeroMovAjusteSaldo bit, CajeroVencimContrasena datetime)
        WHERE Sucursal = @Sucursal
      IF @@ERROR <> 0 SELECT @Ok = 1

/*Procesar*/ --  DELETE crMov WHERE Sucursal = @Sucursal AND ID IN (SELECT DISTINCT ID FROM OPENXML (@ixml, 'CR/crMov/row') WITH (Sucursal int, ID int) WHERE Sucursal = @Sucursal)
      SET IDENTITY_INSERT crMov ON
      IF @Sesion IS NULL
      BEGIN
        INSERT crMov (Sucursal, ID, FechaRegistro, Tipo, Cxc, Folio, FechaEmision, Estatus, Caja, CajaRef, Banco, Cajero, ClienteSucursal, Cliente, ClienteIntelisis, Referencia, Corte, FechaD, FechaA, Vencimiento, Concepto, FechaBanco, Enviado, CajeroCancelacion, OrigenID, OrigenTipo, OrigenFolio, Proveedor, ListaPrecios, CFDGenerado, CFDID, CFDSerie, CFDFolio) --MEJORA3051
        SELECT        Sucursal, ID, FechaRegistro, Tipo, Cxc, Folio, FechaEmision, Estatus, Caja, CajaRef, Banco, Cajero, ClienteSucursal, Cliente, ClienteIntelisis, Referencia, Corte, FechaD, FechaA, Vencimiento, Concepto, FechaBanco, Enviado, CajeroCancelacion, OrigenID, OrigenTipo, OrigenFolio, Proveedor, ListaPrecios, CFDGenerado, CFDID, CFDSerie, CFDFolio  --MEJORA3051
          FROM OPENXML (@ixml, 'CR/crMov/row') 
          WITH (Sucursal int, ID int, FechaRegistro datetime, Tipo varchar(20), Cxc bit, Folio int, FechaEmision datetime, Estatus char(15), Caja int, CajaRef int, Banco int, Cajero int, ClienteSucursal int, Cliente int, ClienteIntelisis varchar(10), Referencia varchar(50), Corte int, FechaD datetime, FechaA datetime, Vencimiento datetime, Concepto varchar(50), FechaBanco datetime, Enviado bit, CajeroCancelacion int, OrigenID int, OrigenTipo varchar(20), OrigenFolio int, Proveedor int, ListaPrecios varchar(20), CFDGenerado bit, CFDID int, CFDSerie varchar(20), CFDFolio varchar(20))
         WHERE Sucursal = @Sucursal
        IF @@ERROR <> 0 SELECT @Ok = 1
      END ELSE
      BEGIN
        INSERT crMov (Sucursal, ID, FechaRegistro, Tipo, Cxc, Folio, FechaEmision, Estatus, Caja, CajaRef, Banco, Cajero, ClienteSucursal, Cliente, ClienteIntelisis, Referencia, Corte, FechaD, FechaA, Vencimiento, Concepto, FechaBanco, Enviado, CajeroCancelacion, OrigenID, OrigenTipo, OrigenFolio, Proveedor, ListaPrecios, CFDGenerado, CFDID, CFDSerie, CFDFolio) --MEJORA3051
        SELECT        Sucursal, ID, FechaRegistro, Tipo, Cxc, Folio, FechaEmision, Estatus, Caja, CajaRef, Banco, Cajero, ClienteSucursal, Cliente, ClienteIntelisis, Referencia, Corte, FechaD, FechaA, Vencimiento, Concepto, FechaBanco, Enviado, CajeroCancelacion, OrigenID, OrigenTipo, OrigenFolio, Proveedor, ListaPrecios, CFDGenerado, CFDID, CFDSerie, CFDFolio  --MEJORA3051
          FROM crMovTemp
         WHERE Sesion = @Sesion
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
      SET IDENTITY_INSERT crMov OFF

/*Procesar*/ --  DELETE crMovD WHERE Sucursal = @Sucursal AND ID IN (SELECT DISTINCT ID FROM OPENXML (@ixml, 'CR/crMovD/row') WITH (Sucursal int, ID int) WHERE Sucursal = @Sucursal)
      SET IDENTITY_INSERT crMovD ON
      IF @Sesion IS NULL
      BEGIN
        INSERT crMovD (Sucursal, ID, RID, Tipo, Vendedor, FormaPago, Referencia, Articulo, SubCuenta, Departamento, Cantidad, Descuento1, Descuento2, Importe, Moneda, TipoCambio, Concepto, Unidad, Codigo, Ubicacion, Posicion, RenglonTipo, UsuarioAutorizacion, EsJuego, PrecioEspecial, PrecioNormal, Cancelado, Costo, TarjetaBanco, TarjetaTipo)
        SELECT         Sucursal, ID, RID, Tipo, Vendedor, FormaPago, Referencia, Articulo, SubCuenta, Departamento, Cantidad, Descuento1, Descuento2, Importe, Moneda, TipoCambio, Concepto, Unidad, Codigo, Ubicacion, Posicion, RenglonTipo, UsuarioAutorizacion, EsJuego, PrecioEspecial, PrecioNormal, Cancelado, Costo, TarjetaBanco, TarjetaTipo
          FROM OPENXML (@ixml, 'CR/crMovD/row') 
          WITH (Sucursal int, ID int, RID int, Tipo varchar(20), Vendedor int, FormaPago int, Referencia varchar(50), Articulo varchar(20), SubCuenta varchar(50), Departamento int, Cantidad float, Descuento1 float, Descuento2 float, Importe money, Moneda int, TipoCambio float, Concepto varchar(50), Unidad varchar(50), Codigo varchar(30), Ubicacion varchar(10), Posicion varchar(10), RenglonTipo char(1), UsuarioAutorizacion varchar(10), EsJuego bit, PrecioEspecial bit, PrecioNormal float, Cancelado bit, Costo money, TarjetaBanco varchar(20), TarjetaTipo varchar(20))
         WHERE Sucursal = @Sucursal
        IF @@ERROR <> 0 SELECT @Ok = 1
      END ELSE
      BEGIN
        INSERT crMovD (Sucursal, ID, RID, Tipo, Vendedor, FormaPago, Referencia, Articulo, SubCuenta, Departamento, Cantidad, Descuento1, Descuento2, Importe, Moneda, TipoCambio, Concepto, Unidad, Codigo, Ubicacion, Posicion, RenglonTipo, UsuarioAutorizacion, EsJuego, PrecioEspecial, PrecioNormal, Cancelado, Costo)
        SELECT         Sucursal, ID, RID, Tipo, Vendedor, FormaPago, Referencia, Articulo, SubCuenta, Departamento, Cantidad, Descuento1, Descuento2, Importe, Moneda, TipoCambio, Concepto, Unidad, Codigo, Ubicacion, Posicion, RenglonTipo, UsuarioAutorizacion, EsJuego, PrecioEspecial, PrecioNormal, Cancelado, Costo
          FROM crMovDTemp
         WHERE Sesion = @Sesion
        IF @@ERROR <> 0 SELECT @Ok = 1 
      END
      SET IDENTITY_INSERT crMovD OFF

      /*IF @CRTipoCreditoCxc = 0
      BEGIN*/
        DELETE crCte WHERE Sucursal = @Sucursal AND ID IN (SELECT ID FROM OPENXML (@ixml, 'CR/crCte/row') WITH (Sucursal int, ID int) WHERE Sucursal = @Sucursal)
        SET IDENTITY_INSERT crCte ON
        INSERT crCte (Sucursal, ID, Nombre, Estatus, Direccion, EntreCalles, Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, Observaciones, Publico, Descuento, Tipo)
        SELECT        Sucursal, ID, Nombre, Estatus, Direccion, EntreCalles, Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, Observaciones, Publico, Descuento, Tipo
          FROM OPENXML (@ixml, 'CR/crCte/row') 
          WITH (Sucursal int, ID int, Nombre varchar(100), Estatus char(15), Direccion varchar(100), EntreCalles varchar(100), Delegacion varchar(30), Colonia varchar(30), Poblacion varchar(30), Estado varchar(30), Pais varchar(30), Zona varchar(30), CodigoPostal varchar(15), RFC varchar(15), CURP varchar(30), Telefonos varchar(100), Observaciones varchar(100), Publico bit, Descuento float, Tipo varchar(15))
          WHERE Sucursal = @Sucursal
        IF @@ERROR <> 0 SELECT @Ok = 1
        SET IDENTITY_INSERT crCte OFF
      /*END ELSE
      BEGIN*/
/*Procesar*/ --  DELETE crMovSoporte WHERE Sucursal = @Sucursal AND ID IN (SELECT DISTINCT ID FROM OPENXML (@ixml, 'CR/crMovSoporte/row') WITH (Sucursal int, ID int) WHERE Sucursal = @Sucursal)
        SET IDENTITY_INSERT crMovSoporte ON
        INSERT crMovSoporte (Sucursal, ID, FechaRegistro, Corte, Mov, FechaEmision, Estatus, Caja, Cajero, ClienteIntelisis, Contacto, Telefono, Titulo, Problema, Enviado)
        SELECT               Sucursal, ID, FechaRegistro, Corte, Mov, FechaEmision, Estatus, Caja, Cajero, ClienteIntelisis, Contacto, Telefono, Titulo, Problema, Enviado
          FROM OPENXML (@ixml, 'CR/crMovSoporte/row') 
          WITH (Sucursal int, ID int, FechaRegistro datetime, Corte int, Mov varchar(20), FechaEmision datetime, Estatus char(15), Caja int, Cajero int, ClienteIntelisis varchar(10), Contacto varchar(50), Telefono varchar(30), Titulo varchar(100), Problema text, Enviado bit)
          WHERE Sucursal = @Sucursal
        IF @@ERROR <> 0 SELECT @Ok = 1
        SET IDENTITY_INSERT crMovSoporte OFF
      /*END*/

/*Procesar*/ --  DELETE crBitacora WHERE Sucursal = @Sucursal AND ID IN (SELECT DISTINCT ID FROM OPENXML (@ixml, 'CR/crBitacora/row') WITH (Sucursal int, ID int) WHERE Sucursal = @Sucursal)
      SET IDENTITY_INSERT crBitacora ON
      INSERT crBitacora (Sucursal, ID, FechaRegistro, FechaEmision, Mensaje)
      SELECT             Sucursal, ID, FechaRegistro, FechaEmision, Mensaje
        FROM OPENXML (@ixml, 'CR/crBitacora/row') 
        WITH (Sucursal int, ID int, FechaRegistro datetime, FechaEmision datetime, Mensaje varchar(255))
        WHERE Sucursal = @Sucursal
      IF @@ERROR <> 0 SELECT @Ok = 1
      SET IDENTITY_INSERT crBitacora OFF
    END
    EXEC sp_xml_removedocument @ixml

    IF /*@Procesar = 1 AND */@Ok IS NULL
    BEGIN     
      SELECT @Moneda 	 = m.Moneda, 
             @TipoCambio = m.TipoCambio 
        FROM EmpresaCfg cfg, Mon m 
       WHERE Empresa = @Empresa AND Moneda = cfg.ContMoneda

      SELECT @CorteCajaMov        = CRCorteCaja,
             @CorteCajaCentralMov = CRCorteCajaCentral
        FROM EmpresaCfgMov
       WHERE Empresa = @Empresa

      CREATE TABLE #CRVenta (
	Articulo	char(20)	COLLATE Database_Default NULL,
	SubCuenta	varchar(50)	COLLATE Database_Default NULL,
	Operaciones	int		NULL,
	Cantidad	float		NULL,
	DescuentoLinea	float		NULL,
	Importe		money		NULL,
	Almacen		varchar(10)	COLLATE Database_Default NULL,
	Posicion	varchar(10)	COLLATE Database_Default NULL,
	Cliente		varchar(10)	COLLATE Database_Default NULL,
        Cxc		bit		NULL,
	Mov		varchar(20)	COLLATE Database_Default NULL,
	MovID		varchar(20)	COLLATE Database_Default NULL,
	CFDSerie	varchar(20)	COLLATE Database_Default NULL, --MEJORA3051
    CFDFolio	varchar(20) COLLATE Database_Default NULL) --MEJORA3051


      CREATE TABLE #CRVenta2 (
	Renglon		float		NULL,
	Articulo	char(20)	COLLATE Database_Default NULL,
	SubCuenta	varchar(50)	COLLATE Database_Default NULL,
	Operaciones	int		NULL,
	Cantidad	float		NULL,
	DescuentoLinea	float		NULL,
	Importe		money		NULL,
	Almacen		varchar(10)	COLLATE Database_Default NULL,
	Posicion	varchar(10)	COLLATE Database_Default NULL,
	Cliente		varchar(10)	COLLATE Database_Default NULL,
        Cxc		bit		NULL,
	Mov		varchar(20)	COLLATE Database_Default NULL,
	MovID		varchar(20)	COLLATE Database_Default NULL,
	CFDSerie	varchar(20)	COLLATE Database_Default NULL, --MEJORA3051
    CFDFolio	varchar(20) COLLATE Database_Default NULL) --MEJORA3051

      CREATE TABLE #CRAgente (
	Renglon		float		NULL,
	Agente		char(10)	COLLATE Database_Default NULL,
	Operaciones	int		NULL,
	Cantidad	float		NULL,
	Importe		money		NULL)

      CREATE TABLE #CRCobro (
	Renglon		float		NULL,
	FormaPago	varchar(50)	COLLATE Database_Default NULL,
	Referencia	varchar(50)	COLLATE Database_Default NULL,
	Importe		money		NULL,
	Moneda		char(10)	COLLATE Database_Default NULL,
	TipoCambio	float		NULL,
	Cliente		varchar(10)	COLLATE Database_Default NULL,
	Cxc		bit		NULL,
	Vencimiento	datetime	NULL,
	CFDSerie	varchar(20)	COLLATE Database_Default NULL, --MEJORA3051
    CFDFolio	varchar(20) COLLATE Database_Default NULL) --MEJORA3051

      CREATE TABLE #CRCaja (
	Renglon		float		NULL,
        CtaDinero	char(10)	COLLATE Database_Default NULL,
	Movimiento	varchar(20)	COLLATE Database_Default NULL,
	Concepto	varchar(50)	COLLATE Database_Default NULL,
	FormaPago	varchar(50)	COLLATE Database_Default NULL,
	Referencia	varchar(50)	COLLATE Database_Default NULL,
	Importe		money		NULL,
	Moneda		char(10)	COLLATE Database_Default NULL,
	TipoCambio	float		NULL,
        FechaBanco	datetime	NULL)

      CREATE TABLE #CRInvFisico (
	Renglon		float		NULL,
	Articulo	char(20)	COLLATE Database_Default NULL,
	SubCuenta	varchar(50)	COLLATE Database_Default NULL,
	Cantidad	float		NULL,
	Unidad		varchar(50)	COLLATE Database_Default NULL,
	Posicion	varchar(10)	COLLATE Database_Default NULL)

      CREATE TABLE #CRSoporte (
	Renglon		float		NULL,
	Mov		varchar(20)	COLLATE Database_Default NULL,
	Cliente		varchar(10)	COLLATE Database_Default NULL,
	Contacto	varchar(50)	COLLATE Database_Default NULL,
	Telefono	varchar(30)	COLLATE Database_Default NULL,
	Titulo		varchar(100)	COLLATE Database_Default NULL,
	Problema	text		NULL)

      SELECT @CtaCajaCentral = NULLIF(RTRIM(ClaveIntelisis), '') FROM crCta WHERE Sucursal = @Sucursal AND Tipo = 'Caja' AND Numero = @CajaCentral
      IF @CtaCajaCentral IS NULL SELECT @Ok = 10510, @OkRef = CONVERT(varchar, @CajaCentral)

      DECLARE crCRMov CURSOR LOCAL FOR 
       SELECT ID, Caja, CajaRef, Folio, Banco, Cajero, Referencia, FechaD, FechaA
         FROM crMov
        WHERE Sucursal = @Sucursal AND FechaEmision = @FechaTrabajo AND Estatus = 'CONCLUIDO' AND ((Tipo = 'Corte' AND Caja <> @CajaCentral) OR (Tipo = 'Cierre' AND Caja = @CajaCentral))

      OPEN crCRMov
      FETCH NEXT FROM crCRMov INTO @ID, @Caja, @CajaRef, @CajaFolio, @Banco, @Cajero, @Referencia, @FechaD, @FechaA
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          IF @Caja = @CajaCentral SELECT @CRMov = @CorteCajaCentralMov ELSE SELECT @CRMov = @CorteCajaMov
          SELECT @CtaCaja = NULLIF(RTRIM(ClaveIntelisis), '') FROM crCta WHERE Sucursal = @Sucursal AND Tipo = 'Caja' AND Numero = @Caja
          IF @CtaCaja IS NULL SELECT @Ok = 10510, @OkRef = CONVERT(varchar, @Caja)

          SELECT @CtaCajero = NULLIF(RTRIM(ClaveIntelisis), '') FROM crCta WHERE Sucursal = @Sucursal AND Tipo = 'Cajero' AND Numero = @Cajero
          IF @CtaCajero IS NULL SELECT @Ok = 10515, @OkRef = CONVERT(varchar, @Cajero)        
          IF @Ok IS NULL
          BEGIN
            SELECT @DocFuente = NULLIF(COUNT(DISTINCT d.Referencia + '-' + Convert(varchar, d.Vendedor)), 0)
              FROM crMov m, crMovD d
             WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
               AND m.Sucursal = @Sucursal AND m.Corte = @ID
               AND m.Tipo <> 'Redondeo'
               AND m.Caja = @Caja
               AND d.Tipo = 'Venta'
               AND m.Estatus <> 'CANCELADO'

            SELECT @SQL = N'EXEC '
            IF @CRProcesoDistribuido = 1 SELECT @SQL = @SQL + @CRServidorOperaciones+'.'+@CRBaseDatosOperaciones+'.dbo.'
            SELECT @SQL = @SQL + N'spInsertarCR @CRID OUTPUT, @Sucursal, @Empresa, @CRMov, @Moneda, @TipoCambio, @FechaTrabajo, @CtaCaja, @CajaFolio, @CtaCajero, @FechaD, @FechaA, @Referencia, @CREstatusSinAfectar, @DocFuente, @Usuario, @Ok OUTPUT, @OkRef OUTPUT'
            SELECT @Params = N'@CRID int OUTPUT, @Sucursal int, @Empresa varchar(5), @CRMov varchar(20), @Moneda varchar(10),@TipoCambio float,  @FechaTrabajo datetime,  @CtaCaja varchar(10),  @CajaFolio int,  @CtaCajero varchar(10), @FechaD datetime,  @FechaA datetime,  @Referencia varchar(50),  @CREstatusSinAfectar varchar(15),  @DocFuente int,  @Usuario varchar(10), @Ok int OUTPUT, @OkRef varchar(255) OUTPUT'
            EXEC sp_executesql @SQL, @Params, @CRID OUTPUT, @Sucursal, @Empresa, @CRMov, @Moneda, @TipoCambio, @FechaTrabajo, @CtaCaja, @CajaFolio, @CtaCajero, @FechaD, @FechaA, @Referencia, @CREstatusSinAfectar, @DocFuente, @Usuario, @Ok OUTPUT, @OkRef OUTPUT
/*, 
            INSERT CR (Sucursal,  SucursalOrigen, Empresa,  Mov,    Moneda,  TipoCambio,  FechaEmision,  Caja,     CajaFolio,  Cajero,     FechaD,  FechaA,  Referencia,  Estatus,              DocFuente,  Usuario)
               VALUES (@Sucursal, @Sucursal,      @Empresa, @CRMov, @Moneda, @TipoCambio, @FechaTrabajo, @CtaCaja, @CajaFolio, @CtaCajero, @FechaD, @FechaA, @Referencia, @CREstatusSinAfectar, @DocFuente, @Usuario)
            SELECT @CRID = SCOPE_IDENTITY()
*/
            TRUNCATE TABLE #CRVenta
            TRUNCATE TABLE #CRVenta2

	    /* VENTAS Y DEVOLUCIONES POR DEPARTAMENTO */

            -- Ventas
            INSERT #CRVenta (
                   Articulo,         SubCuenta,   Almacen,    Posicion, Cliente,             Cxc,   
                   Operaciones, 
                   Cantidad,        
                   DescuentoLinea, 
                   Importe,
                   CFDSerie, --MEJORA3051
                   CFDFolio) --MEJORA3051
            SELECT c.ClaveIntelisis, d.SubCuenta, d.Ubicacion, d.Posicion, m.ClienteIntelisis, m.Cxc, 
                   Count(d.ID), 
                   SUM(d.Cantidad), 
                   100.0-((SUM(CONVERT(float, d.Importe)*(1-(ISNULL(d.Descuento1, 0.0)/100.0))*(1-(ISNULL(d.Descuento2, 0.0)/100.0)))/NULLIF(SUM(CONVERT(float, d.Importe)), 0.0))*100.0), 
                   SUM(d.Importe*(1-(ISNULL(d.Descuento1, 0.0)/100.0))*(1-(ISNULL(d.Descuento2, 0.0)/100.0))),
                   ISNULL(m.CFDSerie,''), --MEJORA3051
                   ISNULL(m.CFDFolio,'')  --MEJORA3051
              FROM crMovD d, crMov m, crCta c
             WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
               AND m.Sucursal = @Sucursal AND m.Corte = @ID
               AND d.Tipo = 'Venta'
               AND c.Sucursal = @Sucursal AND c.Numero = d.Departamento AND c.Tipo = 'Departamento'
             GROUP BY m.ClienteIntelisis, m.Cxc, c.Nombre, c.ClaveIntelisis, d.Ubicacion, d.Posicion, d.SubCuenta, d.Descuento1, d.Descuento2, ISNULL(m.CFDSerie,''), ISNULL(m.CFDFolio,'') --MEJORA3051  
             ORDER BY m.ClienteIntelisis, m.Cxc, c.Nombre, c.ClaveIntelisis, d.Ubicacion, d.Posicion, d.SubCuenta, d.Descuento1, d.Descuento2, ISNULL(m.CFDSerie,''), ISNULL(m.CFDFolio,'') --MEJORA3051   

            -- Devoluciones
            INSERT #CRVenta (
                   Articulo,         SubCuenta,   Almacen,    Posicion, Cliente,             Cxc,   
                   Operaciones, 
                   Cantidad,        
                   DescuentoLinea, 
                   Importe,
                   CFDSerie, --MEJORA3051
                   CFDFolio) --MEJORA3051
            SELECT c.ClaveIntelisis, d.SubCuenta, d.Ubicacion, d.Posicion, m.ClienteIntelisis, m.Cxc, 
                   Count(d.ID), 
                   -SUM(d.Cantidad), 
                   100.0-((SUM(CONVERT(float, d.Importe)*(1-(ISNULL(d.Descuento1, 0.0)/100.0))*(1-(ISNULL(d.Descuento2, 0.0)/100.0)))/NULLIF(SUM(CONVERT(float, d.Importe)), 0.0))*100.0), 
                   -SUM(d.Importe*(1-(ISNULL(d.Descuento1, 0.0)/100.0))*(1-(ISNULL(d.Descuento2, 0.0)/100.0))),
                   ISNULL(m.CFDSerie,''), --MEJORA3051
                   ISNULL(m.CFDFolio,'')  --MEJORA3051
              FROM crMovD d, crMov m, crCta c
             WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
               AND m.Sucursal = @Sucursal AND m.Corte = @ID
               AND d.Tipo = 'Devolucion'
               AND c.Sucursal = @Sucursal AND c.Numero = d.Departamento AND c.Tipo = 'Departamento'
             GROUP BY m.ClienteIntelisis, m.Cxc, c.Nombre, c.ClaveIntelisis, d.Ubicacion, d.Posicion, d.SubCuenta, d.Descuento1, d.Descuento2, ISNULL(m.CFDSerie,''), ISNULL(m.CFDFolio,'') --MEJORA3051   
             ORDER BY m.ClienteIntelisis, m.Cxc, c.Nombre, c.ClaveIntelisis, d.Ubicacion, d.Posicion, d.SubCuenta, d.Descuento1, d.Descuento2, ISNULL(m.CFDSerie,''), ISNULL(m.CFDFolio,'') --MEJORA3051   

	    /* VENTAS POR ARTICULO */         

            INSERT #CRVenta (
                   Articulo,   SubCuenta,   Almacen,     Posicion, Cliente,            Cxc,   
                   Mov, MovID,
                   Operaciones, 
                   Cantidad,        
                   DescuentoLinea,                                                                                                         
                   Importe,
                   CFDSerie, --MEJORA3051
                   CFDFolio) --MEJORA3051
            SELECT d.Articulo, d.SubCuenta, d.Ubicacion, d.Posicion, m.ClienteIntelisis, m.Cxc, 
                   d.Tipo, @Prefijo+CONVERT(varchar(20), m.Folio),
                   Count(d.ID), 
                   SUM(d.Cantidad), 
                   100.0-((SUM(CONVERT(float, d.Importe)*(1-(ISNULL(d.Descuento1, 0.0)/100.0))*(1-(ISNULL(d.Descuento2, 0.0)/100.0)))/NULLIF(SUM(CONVERT(float, d.Importe)), 0.0))*100.0), 
                   SUM(d.Importe*(1-(ISNULL(d.Descuento1, 0.0)/100.0))*(1-(ISNULL(d.Descuento2, 0.0)/100.0))),
                   ISNULL(m.CFDSerie,''), --MEJORA3051
                   ISNULL(m.CFDFolio,'')  --MEJORA3051
              FROM crMovD d, crMov m
             WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
               AND m.Sucursal = @Sucursal AND m.Corte = @ID
               AND d.Tipo IN ('Venta', 'Servicio', 'Factura')
               AND NULLIF(RTRIM(d.Articulo), '') IS NOT NULL
             GROUP BY d.Tipo, m.Folio, m.ClienteIntelisis, m.Cxc, d.Articulo, d.Ubicacion, d.Posicion, d.SubCuenta, d.Descuento1, d.Descuento2, ISNULL(m.CFDSerie,''), ISNULL(m.CFDFolio,'') --MEJORA3051   
             ORDER BY d.Tipo, m.Folio, m.ClienteIntelisis, m.Cxc, d.Articulo, d.Ubicacion, d.Posicion, d.SubCuenta, d.Descuento1, d.Descuento2, ISNULL(m.CFDSerie,''), ISNULL(m.CFDFolio,'') --MEJORA3051   

            INSERT #CRVenta (
                   Articulo,   SubCuenta,   Almacen,     Posicion, Cliente,            Cxc,   
                   Mov, MovID,
                   Operaciones, 
                   Cantidad,        
                   DescuentoLinea,                                                                                                         
                   Importe,
                   CFDSerie, --MEJORA3051
                   CFDFolio) --MEJORA3051
            SELECT d.Articulo, d.SubCuenta, d.Ubicacion, d.Posicion, m.ClienteIntelisis, m.Cxc, 
                   d.Tipo, @Prefijo+CONVERT(varchar(20), m.Folio),
                   Count(d.ID), 
                   -SUM(d.Cantidad), 
                   100.0-((SUM(CONVERT(float, d.Importe)*(1-(ISNULL(d.Descuento1, 0.0)/100.0))*(1-(ISNULL(d.Descuento2, 0.0)/100.0)))/SUM(CONVERT(float, d.Importe)))*100.0), 
                   -SUM(d.Importe*(1-(ISNULL(d.Descuento1, 0.0)/100.0))*(1-(ISNULL(d.Descuento2, 0.0)/100.0))),
                   ISNULL(m.CFDSerie,''), --MEJORA3051
                   ISNULL(m.CFDFolio,'')  --MEJORA3051
              FROM crMovD d, crMov m
             WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
               AND m.Sucursal = @Sucursal AND m.Corte = @ID
               AND d.Tipo IN ('Devolucion', 'Bonificacion')
               AND NULLIF(RTRIM(d.Articulo), '') IS NOT NULL
             GROUP BY d.Tipo, m.Folio, m.ClienteIntelisis, m.Cxc, d.Articulo, d.Ubicacion, d.Posicion, d.SubCuenta, d.Descuento1, d.Descuento2, ISNULL(m.CFDSerie,''), ISNULL(m.CFDFolio,'') --MEJORA3051   
             ORDER BY d.Tipo, m.Folio, m.ClienteIntelisis, m.Cxc, d.Articulo, d.Ubicacion, d.Posicion, d.SubCuenta, d.Descuento1, d.Descuento2, ISNULL(m.CFDSerie,''), ISNULL(m.CFDFolio,'') --MEJORA3051   

            -- Redondeos
            /*INSERT #CRVenta (Articulo, Operaciones, Cantidad, Importe)
            SELECT @ArtRedondeo, Count(d.ID), 1, SUM(-d.Importe)
              FROM crMovD d, crMov m
             WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
               AND m.Sucursal = @Sucursal AND m.Corte = @ID
               AND m.Tipo = 'Redondeo'*/

            UPDATE #CRVenta SET Mov = 'Nota Importe',  MovID = NULL WHERE Mov = 'Bonificacion' AND NULLIF(CFDFolio,'') IS NULL AND NULLIF(CFDSerie,'') IS NULL --MEJORA3051
            UPDATE #CRVenta SET Mov = 'Nota',          MovID = NULL WHERE Mov IN ('Venta', 'Devolucion') AND NULLIF(CFDFolio,'') IS NULL AND NULLIF(CFDSerie,'') IS NULL --MEJORA3051
            UPDATE #CRVenta SET Mov = 'Nota Servicio', MovID = NULL WHERE Mov = 'Servicio' AND NULLIF(CFDFolio,'') IS NULL AND NULLIF(CFDSerie,'') IS NULL --MEJORA3051
            UPDATE #CRVenta SET Mov = 'Factura Mostrador' WHERE Mov = 'Factura' AND Cxc = 0 AND NULLIF(CFDFolio,'') IS NULL AND NULLIF(CFDSerie,'') IS NULL --MEJORA3051
            UPDATE #CRVenta SET Mov = 'Factura Mostrador' WHERE Mov IN ('Venta','Devolucion') AND Cxc = 0 AND NULLIF(CFDFolio,'') IS NOT NULL AND NULLIF(CFDSerie,'') IS NOT NULL --MEJORA3051

                        
            INSERT #CRVenta2 (Articulo, SubCuenta, Almacen, Posicion, Cliente, Cxc, Mov, MovID, Operaciones, Cantidad, DescuentoLinea, Importe,     CFDSerie, CFDFolio) --MEJORA3051
            SELECT Articulo, SubCuenta, Almacen, Posicion, Cliente, Cxc, Mov, MovID, SUM(Operaciones), SUM(Cantidad), DescuentoLinea, SUM(Importe), CFDSerie, CFDFolio  --MEJORA3051
              FROM #CRVenta
             GROUP BY Articulo, SubCuenta, DescuentoLinea, Almacen, Posicion, Cliente, Cxc, Mov, MovID, CFDSerie, CFDFolio --MEJORA3051
             ORDER BY Articulo, SubCuenta, DescuentoLinea, Almacen, Posicion, Cliente, Cxc, Mov, MovID, CFDSerie, CFDFolio --MEJORA3051

            EXEC spCRVenta @CRID, @Sucursal, @Almacen, @CRProcesoDistribuido, @CRServidorOperaciones, @CRBaseDatosOperaciones, @Ok OUTPUT, @OkRef OUTPUT

            -- Vendedores
            TRUNCATE TABLE #CRAgente
            INSERT #CRAgente (Agente, Operaciones, Cantidad, Importe)
            SELECT c.ClaveIntelisis, 
                   Count(d.ID), 
                   SUM(d.Cantidad), 
                   SUM(d.Importe*(1-(ISNULL(d.Descuento1, 0.0)/100.0))*(1-(ISNULL(d.Descuento2, 0.0)/100.0)))
              FROM crMovD d, crMov m, crCta c
             WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
               AND m.Sucursal = @Sucursal AND m.Corte = @ID
               AND d.Tipo = 'Venta'
               AND c.Sucursal = @Sucursal AND c.Numero = d.Vendedor AND c.Tipo = 'Vendedor'
             GROUP BY c.Nombre, c.ClaveIntelisis
             ORDER BY c.Nombre

            INSERT #CRAgente (Agente, Operaciones, Cantidad, Importe)
            SELECT c.ClaveIntelisis, 
                   Count(d.ID), 
                   -SUM(d.Cantidad), 
                   -SUM(d.Importe*(1-(ISNULL(d.Descuento1, 0.0)/100.0))*(1-(ISNULL(d.Descuento2, 0.0)/100.0)))
              FROM crMovD d, crMov m, crCta c
             WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
               AND m.Sucursal = @Sucursal AND m.Corte = @ID
               AND d.Tipo = 'Devolucion'
               AND c.Sucursal = @Sucursal AND c.Numero = d.Vendedor AND c.Tipo = 'Vendedor'
             GROUP BY c.Nombre, c.ClaveIntelisis
             ORDER BY c.Nombre

            EXEC spCRAgente @CRID, @Sucursal, @CRProcesoDistribuido, @CRServidorOperaciones, @CRBaseDatosOperaciones, @Ok OUTPUT, @OkRef OUTPUT

            -- Cobros
            TRUNCATE TABLE #CRCobro
            INSERT #CRCobro (FormaPago,        Referencia,   Moneda,             TipoCambio,   Cliente,            Cxc,   Vencimiento,   Importe,                                                        CFDSerie,            CFDFolio) --MEJORA3051
            SELECT           c.ClaveIntelisis, d.Referencia, mon.ClaveIntelisis, d.TipoCambio, m.ClienteIntelisis, m.Cxc, m.Vencimiento, SUM(CASE WHEN d.Tipo = 'Cobro' THEN Importe ELSE -Importe END), ISNULL(CFDSerie,''), ISNULL(CFDFolio,'') --MEJORA3051
              FROM crMovD d, crMov m, crCta c, crCta mon
             WHERE d.Sucursal = @Sucursal AND d.ID = m.ID 
               AND m.Sucursal = @Sucursal AND m.Corte = @ID
               AND m.Tipo IN ('Venta', 'Servicio', 'Factura', 'Devolucion', 'Bonificacion') 
               AND d.Tipo IN ('Cobro', 'Pago') 
               AND c.Sucursal = @Sucursal AND c.Numero = d.FormaPago AND c.Tipo = 'Forma Pago' 
               AND mon.Sucursal = @Sucursal AND mon.Numero = d.Moneda AND mon.Tipo = 'Moneda' 
             GROUP BY m.ClienteIntelisis, m.Cxc, m.Vencimiento, c.ClaveIntelisis, d.Referencia, mon.ClaveIntelisis, d.TipoCambio, ISNULL(m.CFDSerie,''), ISNULL(m.CFDFolio,'') --MEJORA3051
             ORDER BY m.ClienteIntelisis, m.Cxc, m.Vencimiento, c.ClaveIntelisis, d.Referencia, mon.ClaveIntelisis, d.TipoCambio, ISNULL(m.CFDSerie,''), ISNULL(m.CFDFolio,'') --MEJORA3051

            EXEC spCRCobro @CRID, @Sucursal, @CRProcesoDistribuido, @CRServidorOperaciones, @CRBaseDatosOperaciones, @Ok OUTPUT, @OkRef OUTPUT

            -- Caja
            TRUNCATE TABLE #CRCaja

            IF @Caja = @CajaCentral
            BEGIN
              INSERT #CRCaja (Movimiento, CtaDinero,        Concepto,   FormaPago,         Referencia,   Moneda,             FechaBanco,  TipoCambio,   Importe)
              SELECT           m.Tipo,    c.ClaveIntelisis, d.Concepto, fp.ClaveIntelisis, d.Referencia, mon.ClaveIntelisis, m.FechaBanco, d.TipoCambio, /*SUM(*/d.Importe/*)*/
                FROM crMov m, crMovD d, crCta fp, crCta c, crCta mon
               WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
                 AND m.Sucursal = @Sucursal AND m.Corte = @ID
                 AND m.Tipo IN ('Deposito', 'Retiro') 
                 AND c.Sucursal = @Sucursal AND c.Numero = m.Banco AND c.Tipo = 'Banco'
                 AND fp.Sucursal = @Sucursal AND fp.Numero = d.FormaPago AND fp.Tipo = 'Forma Pago' 
                 AND mon.Sucursal = @Sucursal AND mon.Numero = d.Moneda AND mon.Tipo = 'Moneda' 
                 AND NULLIF(d.Importe, 0) IS NOT NULL
               --GROUP BY m.Tipo, c.ClaveIntelisis, fp.ClaveIntelisis, d.Concepto, d.Referencia, mon.ClaveIntelisis, d.TipoCambio
               --ORDER BY m.Tipo, c.ClaveIntelisis, fp.ClaveIntelisis, d.Concepto, d.Referencia, mon.ClaveIntelisis, d.TipoCambio

              INSERT #CRCaja (Movimiento, Concepto,   FormaPago,         Referencia,   Moneda,             TipoCambio,   Importe)
              SELECT           m.Tipo,    d.Concepto, fp.ClaveIntelisis, d.Referencia, mon.ClaveIntelisis, d.TipoCambio, SUM(d.Importe)
                FROM crMov m, crMovD d, crCta fp, crCta mon
               WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
                 AND m.Sucursal = @Sucursal AND m.Corte = @ID
                 AND m.Tipo IN ('Sobrante', 'Faltante') 
                 AND fp.Sucursal = @Sucursal AND fp.Numero = d.FormaPago AND fp.Tipo = 'Forma Pago' 
                 AND mon.Sucursal = @Sucursal AND mon.Numero = d.Moneda AND mon.Tipo = 'Moneda' 
               GROUP BY m.Tipo, fp.ClaveIntelisis, d.Concepto, d.Referencia, mon.ClaveIntelisis, d.TipoCambio
               ORDER BY m.Tipo, fp.ClaveIntelisis, d.Concepto, d.Referencia, mon.ClaveIntelisis, d.TipoCambio
            END ELSE 
            BEGIN
	      -- Movimientos de Caja que Pueden Tener Multiples Formas de Pago
              INSERT #CRCaja (Movimiento, Concepto, CtaDinero, FormaPago, Referencia, Moneda, TipoCambio, Importe)
              SELECT m.Tipo, d.Concepto, c.ClaveIntelisis, fp.ClaveIntelisis,  m.Referencia, mon.ClaveIntelisis, d.TipoCambio, SUM(CASE d.Tipo WHEN 'Pago' THEN -d.Importe ELSE d.Importe END)
                FROM crMov m, crMovD d, crCta fp, crCta c, crCta mon
               WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
                 AND m.Sucursal = @Sucursal AND m.Corte = @ID
                 AND m.Tipo IN ('Cobro Credito', 'Dev. Anticipo Gasto', 'Devolucion Prestamo') 
                 AND c.Sucursal = @Sucursal AND c.Numero = m.CajaRef AND c.Tipo = 'Caja'
                 AND fp.Sucursal = @Sucursal AND fp.Numero = d.FormaPago AND fp.Tipo = 'Forma Pago' 
                 AND mon.Sucursal = @Sucursal AND mon.Numero = d.Moneda AND mon.Tipo = 'Moneda' 
               GROUP BY m.Tipo, d.Concepto, c.ClaveIntelisis, fp.ClaveIntelisis, m.Referencia, mon.ClaveIntelisis, d.TipoCambio
               ORDER BY m.Tipo, d.Concepto, c.ClaveIntelisis, fp.ClaveIntelisis, m.Referencia, mon.ClaveIntelisis, d.TipoCambio

	      -- Movimientos de Caja de una Sola Forma de Pago
              INSERT #CRCaja (Movimiento, Concepto, CtaDinero, FormaPago, Referencia, Moneda, TipoCambio, Importe)
              SELECT CASE WHEN m.Tipo = 'Corte' THEN 'Recoleccion' ELSE m.Tipo END, d.Concepto, c.ClaveIntelisis, fp.ClaveIntelisis,  m.Referencia, mon.ClaveIntelisis, d.TipoCambio, SUM(d.Importe)
                FROM crMov m, crMovD d, crCta fp, crCta c, crCta mon
               WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
                 AND m.Sucursal = @Sucursal AND m.Corte = @ID
                 AND m.Tipo IN ('Fondo Inicial', 'Recoleccion', 'Corte', 'Sobrante', 'Faltante', 'Venta Credito', 'Anticipo Gasto', 'Prestamo', 'Aplicacion Credito') 
                 AND c.Sucursal = @Sucursal AND c.Numero = m.CajaRef AND c.Tipo = 'Caja'
                 AND fp.Sucursal = @Sucursal AND fp.Numero = d.FormaPago AND fp.Tipo = 'Forma Pago' 
                 AND mon.Sucursal = @Sucursal AND mon.Numero = d.Moneda AND mon.Tipo = 'Moneda' 
               GROUP BY m.Tipo, d.Concepto, c.ClaveIntelisis, fp.ClaveIntelisis, m.Referencia, mon.ClaveIntelisis, d.TipoCambio
               ORDER BY m.Tipo, d.Concepto, c.ClaveIntelisis, fp.ClaveIntelisis, m.Referencia, mon.ClaveIntelisis, d.TipoCambio

              INSERT #CRCaja (Movimiento, Concepto,   FormaPago,         Referencia,   Moneda,             TipoCambio,   Importe)
              SELECT          m.Tipo,     m.Concepto, fp.ClaveIntelisis, m.Referencia, mon.ClaveIntelisis, d.TipoCambio, SUM(d.Importe)
                FROM crMov m, crMovD d, crCta fp, crCta mon
               WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
                 AND m.Sucursal = @Sucursal AND m.Corte = @ID
                 AND m.Tipo IN ('Gasto', 'Devolucion Gasto')
                 AND fp.Sucursal = @Sucursal AND fp.Numero = d.FormaPago AND fp.Tipo = 'Forma Pago' 
                 AND mon.Sucursal = @Sucursal AND mon.Numero = d.Moneda AND mon.Tipo = 'Moneda' 
               GROUP BY m.Tipo, m.Concepto, fp.ClaveIntelisis, m.Referencia, mon.ClaveIntelisis, d.TipoCambio
               ORDER BY m.Tipo, m.Concepto, fp.ClaveIntelisis, m.Referencia, mon.ClaveIntelisis, d.TipoCambio

	      -- Redondeo
              INSERT #CRCaja (Movimiento, Concepto,   Moneda,             TipoCambio,   Importe)
              SELECT          m.Tipo,     m.Concepto, mon.ClaveIntelisis, d.TipoCambio, SUM(d.Importe)
                FROM crMov m, crMovD d, crCta mon
               WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
                 AND m.Sucursal = @Sucursal AND m.Corte = @ID
                 AND m.Tipo = 'Redondeo'
                 AND mon.Sucursal = @Sucursal AND mon.Numero = d.Moneda AND mon.Tipo = 'Moneda' 
               GROUP BY m.Tipo, m.Concepto, mon.ClaveIntelisis, d.TipoCambio
               ORDER BY m.Tipo, m.Concepto, mon.ClaveIntelisis, d.TipoCambio
            END

            EXEC spCRCaja @CRID, @Sucursal, @CRProcesoDistribuido, @CRServidorOperaciones, @CRBaseDatosOperaciones, @Ok OUTPUT, @OkRef OUTPUT

            -- Inventario Fisico
            TRUNCATE TABLE #CRInvFisico
            INSERT #CRInvFisico (Articulo, SubCuenta, Cantidad, Unidad, Posicion)
            SELECT d.Articulo, d.SubCuenta, SUM(d.Cantidad), d.Unidad, d.Posicion
              FROM crMovD d, crMov m
             WHERE d.Sucursal = @Sucursal AND d.ID = m.ID
               AND m.Sucursal = @Sucursal AND m.Corte = @ID
               AND d.Tipo = 'Inventario Fisico'
               AND NULLIF(RTRIM(d.Articulo), '') IS NOT NULL
             GROUP BY d.Articulo, d.SubCuenta, d.Unidad, d.Posicion
             ORDER BY d.Articulo, d.SubCuenta, d.Unidad, d.Posicion

            EXEC spCRInvFisico @CRID, @Sucursal, @CRProcesoDistribuido, @CRServidorOperaciones, @CRBaseDatosOperaciones, @Ok OUTPUT, @OkRef OUTPUT

            -- Soporte
            TRUNCATE TABLE #CRSoporte
            INSERT #CRSoporte (Mov, Cliente, Contacto, Telefono, Titulo, Problema)
            SELECT m.Mov, m.ClienteIntelisis, m.Contacto, m.Telefono, m.Titulo, m.Problema
              FROM crMovSoporte m
             WHERE m.Sucursal = @Sucursal AND m.Corte = @ID

            EXEC spCRSoporte @CRID, @Sucursal, @CRProcesoDistribuido, @CRServidorOperaciones, @CRBaseDatosOperaciones, @Ok OUTPUT, @OkRef OUTPUT

            /*IF NOT EXISTS(SELECT * FROM CRD WHERE ID = @CRID)
              DELETE CR WHERE ID = @CRID
            ELSE BEGIN*/
              IF @CRAfectarAuto = 1 AND @Ok IS NULL
                EXEC spCR @CRID, 'CR', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                          @CRMov, @CRMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
            /*END*/
          END
        END
        FETCH NEXT FROM crCRMov INTO @ID, @Caja, @CajaRef, @CajaFolio, @Banco, @Cajero, @Referencia, @FechaD, @FechaA
      END -- While
      CLOSE crCRMov
      DEALLOCATE crCRMov
    END
    IF /*@Procesar = 1 AND */@CRAfectarAuto = 1 AND @CRCerrarDiaAuto = 1 AND @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spCerrarDia @Empresa, @Sucursal, @FechaTrabajo, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT

--if @ok is null select @ok = 1  --breakpoint
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = NULL
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = RTRIM(Descripcion)+' '+ISNULL(@OkRef, '') FROM MensajeLista WHERE Mensaje = @Ok
  END

  IF @Sesion IS NOT NULL
  BEGIN
    DELETE crMovTemp WHERE Sesion = @Sesion
    DELETE crMovDTemp WHERE Sesion = @Sesion
  END

  SELECT @Mensaje
  RETURN 
END
GO

/************** spPresentacionPrecioOferta *************/
if exists (select * from sysobjects where id = object_id('dbo.spPresentacionPrecioOferta') and type = 'P') drop procedure dbo.spPresentacionPrecioOferta
GO
CREATE PROCEDURE spPresentacionPrecioOferta
			@Empresa	char(5),
			@Grupo		varchar(50),
			@Region		varchar(50),
			@Sucursal	int,
			@FechaD		datetime,
			@FechaA		datetime,
			@Base		varchar(20),
			@Desc		float,
			@DescTipo	varchar(20),
			@Redondeo	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo		int,
    @Presentacion	varchar(50),
    @UltPresentacion	varchar(50),
    @CantidadD		float,
    @PrecioBase		float,
    @PrecioNormal	float,
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255)

  SELECT @Conteo = 0, 
         @Region = NULLIF(NULLIF(RTRIM(@Region), ''), '0'), 
         @Sucursal = NULLIF(@Sucursal, 0), 
         @Redondeo = ISNULL(@Redondeo, 0)

  IF @Region IS NULL
  BEGIN
    IF @Sucursal IS NULL
      DECLARE crPresentacionPrecio CURSOR LOCAL FOR 
       SELECT p.Presentacion, pp.PrecioNormal, pp.CantidadD
         FROM PresentacionPrecio pp
         JOIN Presentacion p ON p.Presentacion = pp.Presentacion AND p.Grupo = @Grupo
        ORDER BY p.Presentacion, pp.Region, pp.Sucursal, pp.CantidadD
    ELSE
      DECLARE crPresentacionPrecio CURSOR LOCAL FOR 
       SELECT p.Presentacion, pp.PrecioNormal, pp.CantidadD
         FROM PresentacionPrecio pp
         JOIN Presentacion p ON p.Presentacion = pp.Presentacion AND p.Grupo = @Grupo
        WHERE pp.Sucursal = @Sucursal
        ORDER BY p.Presentacion, pp.Region, pp.Sucursal, pp.CantidadD
  END ELSE
  BEGIN
    IF @Sucursal IS NULL
      DECLARE crPresentacionPrecio CURSOR LOCAL FOR 
       SELECT p.Presentacion, pp.PrecioNormal, pp.CantidadD
         FROM PresentacionPrecio pp
         JOIN Presentacion p ON p.Presentacion = pp.Presentacion AND p.Grupo = @Grupo
        WHERE pp.Region = @Region
        ORDER BY p.Presentacion, pp.Region, pp.Sucursal, pp.CantidadD
    ELSE
      DECLARE crPresentacionPrecio CURSOR LOCAL FOR 
       SELECT p.Presentacion, pp.PrecioNormal, pp.CantidadD
         FROM PresentacionPrecio pp
         JOIN Presentacion p ON p.Presentacion = pp.Presentacion AND p.Grupo = @Grupo
        WHERE pp.Region = @Region AND pp.Sucursal = @Sucursal
        ORDER BY p.Presentacion, pp.Region, pp.Sucursal, pp.CantidadD
  END  
  OPEN crPresentacionPrecio
  FETCH NEXT FROM crPresentacionPrecio INTO @Presentacion, @PrecioNormal, @CantidadD
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
   BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN   
      IF @Presentacion <> @UltPresentacion SELECT @PrecioBase = NULL
      IF @Base = 'Precio Presentacion' OR (@Base = 'Precio Unitario' AND @CantidadD = 1.0) 
        SELECT @PrecioBase = @PrecioNormal

      UPDATE PresentacionPrecio
         SET PrecioOferta = ROUND(CASE @DescTipo WHEN '%' THEN @PrecioBase * (1.0-(@Desc/100.0)) WHEN '$' THEN @PrecioBase - @Desc END, @Redondeo),
             VigenciaD = @FechaD,
             VigenciaA = @FechaA
       WHERE CURRENT OF crPresentacionPrecio     
      SELECT @Conteo = @Conteo + 1, @UltPresentacion = @Presentacion
    END
    FETCH NEXT FROM crPresentacionPrecio INTO @Presentacion, @PrecioNormal, @CantidadD
  END -- While
  CLOSE crPresentacionPrecio
  DEALLOCATE crPresentacionPrecio

  IF @Ok IS NULL 
    SELECT @Mensaje = CONVERT(varchar(10), @Conteo)+' Registros Modificados.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje

  RETURN 
END
GO

-- spPresentacionPrecioOferta 'DEMO', 'Licores', NULL, NULL, '1/1/5', '1/1/6', 'Precio Unitario', 10, '%', 2


/************** Esqueletos de SP's que solicita la CR a la Matriz (para que no mande error al recibir en la sucursal) *************/
/************** INICIO *************/

/************** spGenerarCRDescuentoConcepto *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRDescuentoConcepto') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRDescuentoConcepto
GO
CREATE PROCEDURE spGenerarCRDescuentoConcepto
	@Empresa	varchar(5),
	@Sucursal	int
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crDescuentoConcepto>'
  SELECT '</crDescuentoConcepto>'
  RETURN
END
GO

/************** spGenerarCRDescuentoObservacion *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRDescuentoObservacion') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRDescuentoObservacion
GO
CREATE PROCEDURE spGenerarCRDescuentoObservacion
	@Empresa	varchar(5),
	@Sucursal	int
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crDescuentoObservacion>'
  SELECT '</crDescuentoObservacion>'
  RETURN
END
GO

/************** spGenerarCRPrecioConcepto *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRPrecioConcepto') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRPrecioConcepto
GO
CREATE PROCEDURE spGenerarCRPrecioConcepto
	@Empresa	varchar(5),
	@Sucursal	int
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crPrecioConcepto>'
  SELECT '</crPrecioConcepto>'
  RETURN
END
GO

/************** spGenerarCRArtEmida *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRArtEmida') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRArtEmida
GO
CREATE PROCEDURE spGenerarCRArtEmida
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crArtEmida>'
  SELECT '</crArtEmida>'
  RETURN
END
GO

/*************** spGenerarCRListaPrecios *******************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRListaPrecios') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRListaPrecios
GO
CREATE PROCEDURE spGenerarCRListaPrecios
	@Empresa	char(5) = NULL,
	@Sucursal	int = NULL
--//WITH ENCRYPTION
AS
BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crListaPrecios>'
  SELECT '</crListaPrecios>'
  RETURN
END
GO
/************** spGenerarCROpcionDescripcion *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCROpcionDescripcion') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCROpcionDescripcion
GO
CREATE PROCEDURE spGenerarCROpcionDescripcion
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crOpcionDescripcion>'
  SELECT '</crOpcionDescripcion>'
  RETURN
END
GO

/************** spGenerarCRArtT *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRArtT') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRArtT
GO
CREATE PROCEDURE spGenerarCRArtT
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crArtT>'
  SELECT '</crArtT>'
  RETURN
END
GO

/************** spGenerarCRPoliticaPrecios *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRPoliticaPrecios') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRPoliticaPrecios
GO
CREATE PROCEDURE spGenerarCRPoliticaPrecios
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crPoliticaPrecios>'
  SELECT '</crPoliticaPrecios>'
  RETURN
END
GO

/************** spGenerarCRPoliticaPreciosD *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRPoliticaPreciosD') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRPoliticaPreciosD
GO
CREATE PROCEDURE spGenerarCRPoliticaPreciosD
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crPoliticaPreciosD>'
  SELECT '</crPoliticaPreciosD>'
  RETURN
END
GO

/************** spGenerarCRNormaUnidad *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRNormaUnidad') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRNormaUnidad
GO
CREATE PROCEDURE spGenerarCRNormaUnidad
			@Empresa	varchar(5),
			@Sucursal	int
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crNormaUnidad>'
  SELECT '</crNormaUnidad>'
  RETURN
END
GO

/************** spGenerarCRArtAlm *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRArtAlm') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRArtAlm
GO
CREATE PROCEDURE spGenerarCRArtAlm
			@Empresa	varchar(5),
			@Sucursal	int,
      @Moneda   varchar(10)
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crArtAlm>'
  SELECT '</crArtAlm>'
  RETURN
END
GO

/************** spGenerarCRArtCombo *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRArtCombo') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRArtCombo
GO
CREATE PROCEDURE spGenerarCRArtCombo
			@Empresa	varchar(5),
			@Sucursal	int
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crArtCombo>'
  SELECT '</crArtCombo>'
  RETURN
END
GO

/************** spGenerarCRAlmacen *************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = Object_id('dbo.spGenerarCRAlmacen') AND TYPE = 'P')  
  DROP PROCEDURE dbo.spGenerarCRAlmacen
GO
CREATE PROCEDURE spGenerarCRAlmacen
			@Empresa	varchar(5),
			@Sucursal	int
WITH ENCRYPTION
AS BEGIN
  SELECT '<?xml version="1.0" encoding="UTF-8" ?>'
  SELECT '<crAlmacen>'
  SELECT '</crAlmacen>'
  RETURN
END
GO
/************** FIN *************/
/************** Esqueletos de SP's que solicita la CR a la Matriz (para que no mande error al recibir en la sucursal) *************/
