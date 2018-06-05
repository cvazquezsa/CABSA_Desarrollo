SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
SET ANSI_WARNINGS OFF
GO 


/****** TablaValor ******/
if not exists(select * from SysTabla where SysTabla = 'TablaValor')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaValor','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaValor') and type = 'U') 
CREATE TABLE dbo.TablaValor (
        TablaValor		varchar(50)	NOT NULL,
	CONSTRAINT priTablaValor PRIMARY KEY CLUSTERED (TablaValor)
)
go



/****** TablaValorD ******/
if not exists(select * from SysTabla where SysTabla = 'TablaValorD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaValorD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaValorD') and type = 'U') 
CREATE TABLE dbo.TablaValorD (
        TablaValor       	varchar(50)	NOT NULL,
	Valor			varchar(50)	NOT NULL,
	CONSTRAINT priTablaValorD PRIMARY KEY CLUSTERED (TablaValor, Valor)
)
go


/*************************** eDocInDirDetalle **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInDirDetalle') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInDirDetalle','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInDirDetalle') and type = 'U')
CREATE TABLE eDocInDirDetalle
        (
          RowNum           int IDENTITY(1,1),
          Nombre           varchar(128) , 
          Path             varchar(128) , 
          Tipo             varchar(100),
          Estacion         int,
		
	CONSTRAINT prieDocInDirDetalle PRIMARY KEY CLUSTERED (RowNum,Estacion)
	)
GO

-- 9562
EXEC spALTER_TABLE 'eDocInDirDetalle', 'FechaCreacion', 'datetime NULL'
GO

/*************************** eDocInNSPrefijo **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInNSPrefijo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInNSPrefijo','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInNSPrefijo') and type = 'U')
CREATE TABLE eDocInNSPrefijo
        ( ID               int IDENTITY(1,1),
          Prefijo	   varchar(max) COLLATE DATABASE_DEFAULT NULL,
          Nombre	   varchar(max) COLLATE DATABASE_DEFAULT NULL,
          Estacion         int,
		
	CONSTRAINT prieDocInNSPrefijo PRIMARY KEY CLUSTERED (Estacion,ID)
	)
GO


/*************************** eDocInRutaTemp **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInRutaTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInRutaTemp','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInRutaTemp') and type = 'U')
CREATE TABLE eDocInRutaTemp
        (
          eDocIn   varchar(50),
          Ruta     varchar(50),
          Modulo   varchar(5),
          ID       int,
          Mov      varchar(50),
          Estatus  varchar(20),
          Estacion int,
          Origen   varchar(255),
		
	CONSTRAINT prieDocInRutaTemp PRIMARY KEY CLUSTERED (eDocIn,Ruta,Estacion,Modulo,ID)
	)
GO


/*************************** eDocInISDetalleTemp **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInISDetalleTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInISDetalleTemp','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInISDetalleTemp') and type = 'U')
CREATE TABLE eDocInISDetalleTemp
        (
          RID       int         NOT NULL,
          eDocIn   varchar(50)  NOT NULL,
          Ruta     varchar(50)  NOT NULL,
          Modulo   varchar(5)   NOT NULL,
          ID       int          NOT NULL,
          Mov      varchar(50)  NULL,
          Estatus  varchar(20)  NULL,
          Origen   varchar(20)  NULL,
          Estacion int          NOT NULL,
		
	CONSTRAINT prieDocInISDetalleTemp PRIMARY KEY CLUSTERED (RID,Estacion,Modulo,ID)
	)
GO

Exec spAlter_Column 'eDocInISDetalleTemp','Origen','varchar(255) Null'


/*************************** eDocInArchivoTemp **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInArchivoTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInArchivoTemp','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInArchivoTemp') and type = 'U')
CREATE TABLE eDocInArchivoTemp
        (
          RID         int         NOT NULL,
          Documento   varchar(MAX)  NOT NULL,
          Estacion    int          NOT NULL,
		
	CONSTRAINT prieDocInArchivoTemp PRIMARY KEY CLUSTERED (RID,Estacion)
	)
GO


/*************************** eDocIn **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocIn') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocIn','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocIn') and type = 'U')
CREATE TABLE eDocIn
        (
        eDocIn					varchar(50)  NOT NULL,
        Descripcion				varchar(100) NULL,
        Tipo					varchar(50)  NULL,
        Documento				varchar(max) NULL,
		
	CONSTRAINT prieDocIn PRIMARY KEY CLUSTERED (eDocIn)
	)
GO


if exists (select * from sysobjects where id = object_id('dbo.tgeDocInBC') and sysstat & 0xf = 8) drop trigger dbo.tgeDocInBC
GO
CREATE TRIGGER tgeDocInBC ON eDocIn
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = eDocIn  FROM Inserted
  SELECT @ClaveAnterior = eDocIn  FROM Deleted

  IF @ClaveNueva=@ClaveAnterior  RETURN

  IF @ClaveNueva IS NULL
  BEGIN
    DELETE eDocInRuta    WHERE eDocIn = @ClaveAnterior
    DELETE eDocInRutaD    WHERE eDocIn = @ClaveAnterior
    DELETE eDocInRutaDCondicion    WHERE eDocIn = @ClaveAnterior
    DELETE eDocInRutaExpresion 	WHERE eDocIn = @ClaveAnterior
    DELETE eDocInRutaTabla	WHERE eDocIn = @ClaveAnterior
    DELETE eDocInRutaTablaD	WHERE eDocIn = @ClaveAnterior
    

  END 
  IF @ClaveNueva <> @ClaveAnterior
  BEGIN
    UPDATE eDocInRuta     SET eDocIn = @ClaveNueva WHERE eDocIn = @ClaveAnterior
    UPDATE eDocInRutaD     SET eDocIn = @ClaveNueva WHERE eDocIn = @ClaveAnterior
    UPDATE eDocInRutaDCondicion     SET eDocIn = @ClaveNueva WHERE eDocIn = @ClaveAnterior
    UPDATE eDocInRutaExpresion SET eDocIn = @ClaveNueva WHERE eDocIn = @ClaveAnterior
    UPDATE eDocInRutaTabla	 SET eDocIn = @ClaveNueva WHERE eDocIn = @ClaveAnterior
    UPDATE eDocInRutaTablaD SET eDocIn = @ClaveNueva WHERE eDocIn = @ClaveAnterior

  END
END
GO


/*************************** eDocInRuta **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInRuta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInRuta','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInRuta') and type = 'U')
CREATE TABLE eDocInRuta
        (
        eDocIn					varchar(50)	NOT NULL,
        Ruta					varchar(50) NOT NULL,
        Descripcion				varchar(100) NULL,
        XSD					varchar(50) NULL,
        Modulo					varchar(5) NULL,
        Mov					varchar(20) NULL,
        Afectar					bit NULL DEFAULT 1,
        VigenciaDe				datetime NULL,
        VigenciaA				datetime NULL,
        AntesAfectar                            varchar(50)NULL,
		
	CONSTRAINT prieDocInRuta PRIMARY KEY CLUSTERED (eDocIn, Ruta)
	)
GO

EXEC spALTER_TABLE 'eDocInRuta', 'AntesAfectar', 'varchar(50) NULL'


if exists (select * from sysobjects where id = object_id('dbo.tgeDocInRutaBC') and sysstat & 0xf = 8) drop trigger dbo.tgeDocInRutaBC
GO
CREATE TRIGGER tgeDocInRutaBC ON eDocInRuta
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50),
    @eDocInNueva  	varchar(50),
    @eDocInAnterior	varchar(50),    
    @ModuloNuevo     	varchar(20),   
    @ModuloAnterior	varchar(20)    

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = Ruta, @eDocInNueva = eDocIn, @ModuloNuevo = Modulo FROM Inserted
  SELECT @ClaveAnterior = Ruta , @eDocInAnterior = eDocIn, @ModuloAnterior = Modulo FROM Deleted

  IF @ClaveNueva=@ClaveAnterior  RETURN

  IF @ClaveNueva IS NULL
  BEGIN

    DELETE eDocInRutaD    WHERE Ruta = @ClaveAnterior AND eDocIn = @eDocInAnterior
    DELETE eDocInRutaDCondicion    WHERE Ruta = @ClaveAnterior AND eDocIn = @eDocInAnterior
    DELETE eDocInRutaExpresion 	WHERE Ruta = @ClaveAnterior AND eDocIn = @eDocInAnterior
    DELETE eDocInRutaTabla	WHERE Ruta = @ClaveAnterior AND eDocIn = @eDocInAnterior
    DELETE eDocInRutaTablaD	WHERE Ruta = @ClaveAnterior AND eDocIn = @eDocInAnterior

  END 
  IF @ClaveNueva <> @ClaveAnterior
  BEGIN


    UPDATE eDocInRutaD     SET Ruta = @ClaveNueva WHERE Ruta = @ClaveAnterior AND eDocIn = @eDocInAnterior
    UPDATE eDocInRutaDCondicion     SET Ruta = @ClaveNueva WHERE Ruta = @ClaveAnterior AND eDocIn = @eDocInAnterior
    UPDATE eDocInRutaExpresion SET Ruta = @ClaveNueva WHERE Ruta = @ClaveAnterior AND  eDocIn = @eDocInAnterior
    UPDATE eDocInRutaTabla	 SET Ruta = @ClaveNueva WHERE Ruta = @ClaveAnterior AND  eDocIn = @eDocInAnterior
    UPDATE eDocInRutaTablaD SET Ruta = @ClaveNueva WHERE Ruta = @ClaveAnterior AND eDocIn = @eDocInAnterior

  END

  
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgeDocInRutaC') and sysstat & 0xf = 8) drop trigger dbo.tgeDocInRutaC
GO
CREATE TRIGGER tgeDocInRutaC ON eDocInRuta
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50),
    @eDocInNueva  	varchar(50),
    @eDocInAnterior	varchar(50),    
    @ModuloNuevo     	varchar(20),   
    @ModuloAnterior	varchar(20)    

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = Ruta, @eDocInNueva = eDocIn, @ModuloNuevo = Modulo FROM Inserted
  SELECT @ClaveAnterior = Ruta , @eDocInAnterior = eDocIn, @ModuloAnterior = Modulo FROM Deleted
  
  IF @ModuloNuevo=@ModuloAnterior  RETURN
  IF @ModuloNuevo <> @ModuloAnterior
  BEGIN
    DELETE eDocInRutaTabla	WHERE Ruta = @ClaveAnterior AND eDocIn = @eDocInAnterior
    DELETE eDocInRutaTablaD	WHERE Ruta = @ClaveAnterior AND eDocIn = @eDocInAnterior
    --EXEC speDocInInsertarRutaTabla @eDocInNueva, @ClaveNueva, @ModuloNuevo
  END  
  
  
END
GO




/*************************** eDocInRutaD  **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInRutaD ') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInRutaD ','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInRutaD ') and type = 'U')
CREATE TABLE eDocInRutaD
        (
        eDocIn					varchar(50)NOT NULL,
        Ruta					varchar(50)NOT NULL,
        Tipo					varchar(50)NOT NULL,
        GUID                                    varchar(36)NOT NULL DEFAULT NEWID(),
       	OperadorLogico				varchar(1) NOT NULL ,
	CONSTRAINT prieDocInRutaD PRIMARY KEY CLUSTERED (eDocIn, Ruta, GUID)
	)
GO

/*************************** eDocInRutaExpresion **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInRutaExpresion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInRutaExpresion','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInRutaExpresion') and type = 'U')
CREATE TABLE eDocInRutaExpresion
        (
        eDocIn					varchar(50)	NOT NULL,
        Ruta					varchar(50) NOT NULL,
        SP                                      varchar(100) NULL,
        Param1                                  bit DEFAULT 0,
        Param2                                  bit DEFAULT 0,
		
	CONSTRAINT prieDocInRutaExpresion PRIMARY KEY CLUSTERED (eDocIn, Ruta)
	)
GO





/*************************** eDocInRutaDCondicion  **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInRutaDCondicion ') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInRutaDCondicion ','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInRutaDCondicion ') and type = 'U')
CREATE TABLE eDocInRutaDCondicion
        (
        eDocIn					varchar(50)	NOT NULL,
        Ruta					varchar(50) NOT NULL,
        RID					int identity(1,1) NOT NULL,
        GUID                                    varchar(36)  NOT NULL,
        Operando1				varchar(8000) NULL,
	Operador				varchar(50)  NULL,
	Operando2				varchar(8000) NULL,
	
	CONSTRAINT prieeDocInRutaDCondicion PRIMARY KEY CLUSTERED (eDocIn, Ruta, RID,GUID)
	)
GO


/*************************** eDocInRutaTabla **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInRutaTabla') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInRutaTabla','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInRutaTabla') and type = 'U')
CREATE TABLE eDocInRutaTabla
        (
        eDocIn					varchar(50)	NOT NULL,
        Ruta					varchar(50) NOT NULL,
        Tablas					varchar(50) NOT NULL,
        DetalleDe				varchar(50) NULL,                        
        Nodo					varchar(8000) NULL,
        NodoNombre				varchar(8000) NULL,        
				
	CONSTRAINT prieDocInRutaTabla PRIMARY KEY CLUSTERED (eDocIn, Ruta, Tablas)
	)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeDocInRutaTablaBC') and sysstat & 0xf = 8) drop trigger dbo.tgeDocInRutaTablaBC
GO
CREATE TRIGGER tgeDocInRutaTablaBC ON eDocInRutaTabla
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50),
    @RutaNueva  	varchar(50),
    @RutaAnterior	varchar(50),    
    @eDocInNueva  	varchar(50),
    @eDocInAnterior	varchar(50)    

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = Tablas, @eDocInNueva = eDocIn, @RutaNueva = Ruta  FROM Inserted
  SELECT @ClaveAnterior = Tablas , @eDocInAnterior = eDocIn, @RutaAnterior = Ruta FROM Deleted

  IF @ClaveNueva=@ClaveAnterior  RETURN

  IF @ClaveNueva IS NULL
  BEGIN

    DELETE eDocInRutaTablaD	WHERE Tablas = @ClaveAnterior AND eDocIn = @eDocInAnterior AND Ruta = @RutaAnterior

  END 
  IF @ClaveNueva <> @ClaveAnterior
  BEGIN
    UPDATE eDocInRutaTablaD SET Tablas = @ClaveNueva WHERE Tablas = @ClaveAnterior AND eDocIn = @eDocInAnterior AND Ruta = @RutaAnterior

  END
END
GO

/*************************** eDocInRutaTablaD **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInRutaTablaD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInRutaTablaD','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInRutaTablaD') and type = 'U')
CREATE TABLE eDocInRutaTablaD
        (
        eDocIn				varchar(50)	NOT NULL,
        Ruta				varchar(50) NOT NULL,
        Tablas				varchar(50) NOT NULL,
        RID				int identity(1,1) NOT NULL,
        CampoXML			varchar(8000) NULL,
	ExpresionXML			varchar(8000) NULL,
	CampoTabla			varchar(8000) NULL,
	CampoXMLTipo			varchar(50) NULL,
	CampoXMLRuta			varchar(8000) NULL,
	CampoXMLAtributo		varchar(255) NULL,
        CampoXMLTipoXML			varchar(50) NULL,
        EsIndependiente			bit NULL DEFAULT 0,        	
	EsConsecutivo			bit NULL DEFAULT 0,
	ConsecutivoNombre		varchar(100) NULL,
	ConsecutivoInicial		int NULL DEFAULT 0,
	ConsecutivoIncremento	        int NULL DEFAULT 1,
        Traducir			bit NULL DEFAULT 0,		
        TablaSt				varchar(50) NULL,
						
	CONSTRAINT prieDocInRutaTablaD PRIMARY KEY CLUSTERED (eDocIn, Ruta, Tablas, RID)
	)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeDocInRutaTablaDC') and sysstat & 0xf = 8) drop trigger dbo.tgeDocInRutaTablaDC
GO
CREATE TRIGGER tgeDocInRutaTablaDC ON eDocInRutaTablaD
--//WITH ENCRYPTION
AFTER UPDATE, INSERT
AS BEGIN
  DECLARE
    @RID                int,
    @IDNodo             int,
    @CampoXMLAnterior   varchar(8000),
    @CampoXMLNuevo      varchar(8000),
    @eDocIn             varchar(50),
    @Ruta               varchar(50),
    @Tablas             varchar(50),
    @Nodo               varchar(8000)

  IF dbo.fnEstaSincronizando() = 1 RETURN

  DECLARE crTablaD CURSOR LOCAL FOR
   SELECT i.RID, i.CampoXML, d.CampoXML, i.eDocIn, i.Ruta, i.Tablas
     FROM Inserted i LEFT JOIN Deleted d ON i.RID = d.RID
    WHERE i.CampoXML <> ISNULL(d.CampoXML,'') AND (NULLIF(i.CampoXML,'') IS NOT NULL OR NULLIF(d.CampoXML,'') IS  NULL)
  
  OPEN crTablaD
  FETCH NEXT FROM crTablaD INTO @RID, @CampoXMLNuevo, @CampoXMLAnterior, @eDocIn, @Ruta, @Tablas 
  WHILE @@FETCH_STATUS = 0 
  BEGIN

    SELECT @Nodo = ISNULL(NULLIF(Nodo,''),'/') 
      FROM eDocInRutaTabla WHERE eDocIn = @eDocIn AND Ruta = @Ruta AND Tablas= @Tablas
      
    --EXEC speDocInListarNodosAtributos @@SPID, @eDocIn, @Nodo  
    SELECT @IDNodo = ID FROM eDocInNodoAtributoTemp WHERE Estacion = @@SPID AND NodoNombre = @CampoXMLNuevo
    UPDATE eDocInRutaTablaD SET ExpresionXML = n.NodoNombre, CampoXMLRuta = n.Ruta, CampoXMLAtributo = n.Atributo, CampoXMLTipoXML = n.CampoTipoxml
      FROM eDocInNodoAtributoTemp n
     WHERE n.Estacion = @@SPID
       AND n.ID = @IDNodo 
       AND RID = @RID
    FETCH NEXT FROM crTablaD INTO @RID, @CampoXMLNuevo, @CampoXMLAnterior, @eDocIn, @Ruta, @Tablas 
  END
  CLOSE crTablaD
  DEALLOCATE crTablaD  
END
GO

/*************************** eDocInModuloOmision **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInModuloOmision') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInModuloOmision','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInModuloOmision') and type = 'U')
CREATE TABLE eDocInModuloOmision
        (
          Modulo          varchar(5) NOT NULL,
          Tablas          varchar(50)NOT NULL,
          Orden           int        NOT NULL,
          DetalleDe       varchar(50)NULL
		
	CONSTRAINT prieDocInModuloOmision PRIMARY KEY CLUSTERED (Modulo,Tablas)
	)
GO

  IF NOT EXISTS(SELECT * FROM eDocInModuloOmision)
  BEGIN
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)    SELECT  'AF',   'ActivoFijo', 10, NULL

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)    SELECT 'AF',   'ActivoFijoD', 20, 'ActivoFijo'

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)    SELECT 'AGENT', 'Agent', 30, NULL

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT   'AGENT', 'AgentD', 40, 'Agent'

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT   'COMS', 'Compra', 50, NULL

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'COMS', 'CompraD', 60, 'Compra'

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)    SELECT  'COMS', 'SerieLoteMov', 70, 'CompraD'
  
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CXC', 'Cxc', 80, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'CXC', 'CxcD', 90, 'Cxc'
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)   SELECT 'CXP', 'Cxp', 100, NULL

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'CXP', 'CxpD', 110, 'Cxp'

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)   SELECT 'DIN', 'Dinero', 120, NULL

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'DIN', 'DineroD', 130, 'Dinero'

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)   SELECT 'GAS', 'Gasto', 140, NULL

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'GAS', 'GastoD', 150, 'Gasto'
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)   SELECT 'INV', 'Inv', 160, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'INV', 'InvD', 170, 'Inv'
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'INV', 'SerieLoteMov', 180, 'InvD'

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'VTAS', 'Venta', 190, NULL

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT 'VTAS', 'VentaD', 200, 'Venta'

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'VTAS', 'SerieLoteMov', 210, 'VentaD'

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'PROD', 'Prod', 220, NULL

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'PROD', 'ProdD', 230, 'Prod'

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'PROD', 'SerieLoteMov', 240, 'ProdD'

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)   SELECT 'ST', 'Soporte', 250, NULL

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'ST', 'SoporteD', 260, 'Soporte'
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)   SELECT 'EMB', 'Embarque', 270, NULL

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'EMB', 'EmbarqueD', 280 , 'Embarque'   

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'SAUX', 'SAUX', 290, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'SAUX', 'SAUXD', 300  , 'SAUX'
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'NOM', 'Nomina', 310, NULL
      
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'NOM', 'NominaD', 320  , 'Nomina' 
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'ASIS', 'Asiste', 330, NULL
      
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'ASIS', 'AsisteD', 340  , 'Asiste'     
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'CAP', 'Capital', 350, NULL
      
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'CAP', 'CapitalD', 360, 'Capital'         

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'CAM', 'Cambio', 370, NULL
      
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'CAM', 'CambioD', 380 , 'Cambio'   
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'PROY', 'Proyecto', 390, NULL
      
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'PROY', 'ProyectoD', 400  , 'Proyecto'
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe)  SELECT 'INC', 'Incidencia', 410 , NULL

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT 'INC', 'IncidenciaD', 420 , 'Incidencia' 

    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CONC' , 'Conciliacion',430, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CONC' , 'ConciliacionD',440 , 'Conciliacion'   
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'PPTO' , 'Presup', 450, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'PPTO' , 'PresupD', 460  , 'Presup'  
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CREDI' , 'Credito', 470, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CMP' , 'Campana', 480, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CMP', 'CampanaD', 490  , 'Campana'   
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'FIS', 'Fiscal', 500, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'FIS', 'FiscalD', 510, 'Fiscal'
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'ORG', 'Organiza', 520, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'ORG', 'OrganizaD', 530 , 'Organiza'   
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'RE', 'Recluta', 540, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'RE', 'ReclutaD', 550 , 'Recluta'   
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'FRM', 'FormaExtra', 560, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'FRM', 'FormaExtraD', 570, 'FormaExtra'    
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CAPT', 'Captura', 580, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CAPT', 'CapturaD', 590, 'Captura'   
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'GES' , 'Gestion', 600, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'OFER', 'Oferta', 610, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'OFER', 'OfertaD', 620 , 'Oferta'   
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'PACTO' , 'Contrato', 630, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'TMA', 'TMA', 640    , NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'TMA', 'TMAD', 650, 'TMA'
    	
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'ISL', 'ISL', 660, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'ISL', 'ISLD', 670, 'ISL'
        
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CONT', 'CONT', 680, NULL	
   
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CONT', 'CONTD', 690  , 'CONT'  
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CP', 'CP', 700	, NULL 
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CP', 'CPD', 710, 'CP'	  
       
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'PCP', 'PCP', 720, NULL	
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'PCP', 'PCPD', 730  , 'PCP'  
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'PC', 'PC', 740 , NULL 
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'PC', 'PCD', 750, 'PC'
           
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'RH', 'RH', 760, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'RH', 'RHD', 770 , 'RH' 
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'VALE', 'VALE', 780  , NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'VALE', 'VALED', 790, 'VALE'
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'RSS', 'RSS', 800, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CR', 'CR',  810, NULL
    
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CR', 'CRD', 820 , 'CR'   
    
    --REQ25014
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CONTP', 'ContParalela',  840 , NULL
    INSERT eDocInModuloOmision(Modulo, Tablas, Orden, DetalleDe) SELECT  'CONTP', 'ContParalelaD', 845 , 'ContParalela'

  END
GO


/*************************** eDocInNodoTemp **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInNodoTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInNodoTemp','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInNodoTemp') and type = 'U')
CREATE TABLE eDocInNodoTemp
        (
    Estacion					int		     NOT NULL,
    Nodo					varchar(255) NOT NULL,
    NodoNombre					varchar(255) NULL,

	CONSTRAINT prieDocInNodoTemp PRIMARY KEY CLUSTERED (Estacion, Nodo)
	)
GO



/*************************** eDocInAtributoTemp **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInAtributoTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInAtributoTemp','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInAtributoTemp') and type = 'U')
CREATE TABLE eDocInAtributoTemp
        (
    Estacion					int		     NOT NULL,
    AtributoRuta				varchar(255) NOT NULL,
    AtributoNombre				varchar(255) NOT NULL,
    Campo					varchar(255) NOT NULL,
    Nodo					varchar(255)  NULL,

	CONSTRAINT prieDocInAtributoTemp PRIMARY KEY CLUSTERED (Estacion, AtributoRuta, AtributoNombre)
	)
GO

/*************************** eDocInVariableTemp **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInVariableTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInVariableTemp','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInVariableTemp') and type = 'U')
CREATE TABLE eDocInVariableTemp
        (
    Estacion					int		     NOT NULL,
    Variable					varchar(255) NOT NULL,
    Valor					varchar(max) NULL,
    Tipo					varchar(50)  NULL, --TEXTO, NUMERICO, FECHA, LOGICO

	CONSTRAINT prieDocInVariableTemp PRIMARY KEY CLUSTERED (Estacion, Variable)
	)
GO

/*************************** eDocInNodoAtributoTemp **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInNodoAtributoTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInNodoAtributoTemp','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInNodoAtributoTemp') and type = 'U')
CREATE TABLE eDocInNodoAtributoTemp
        (
    Estacion					int	     NOT NULL,
    ID                                          int IDENTITY(1,1) NOT NULL,
    Nodo					varchar(255) NOT NULL,
    NodoNombre					varchar(255) NULL,
    Ruta                                        varchar(255) NOT NULL,
    CampoTipoxml                                varchar(50)  NULL,
    Atributo                                    varchar(255) NULL,

	CONSTRAINT prieeDocInNodoAtributoTemp PRIMARY KEY CLUSTERED (Estacion, ID)
	)
GO

/*************************** eDocInNodoAtributoTemp2 **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInNodoAtributoTemp2') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInNodoAtributoTemp2','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInNodoAtributoTemp2') and type = 'U')
CREATE TABLE eDocInNodoAtributoTemp2
        (
    Estacion					int	     NOT NULL,
    ID                                          int IDENTITY(1,1) NOT NULL,
    Nodo					varchar(255) NOT NULL,
    NodoNombre					varchar(255) NULL,
    Ruta                                        varchar(255) NOT NULL,
    CampoTipoxml                                varchar(50)  NULL,
    Atributo                                    varchar(255) NULL,

	CONSTRAINT prieeDocInNodoAtributoTemp2 PRIMARY KEY CLUSTERED (Estacion, ID)
	)
GO


/*************************** eDocInHerrTablaST **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInHerrTablaST') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInHerrTablaST','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInHerrTablaST') and type = 'U')
CREATE TABLE eDocInHerrTablaST
        ( 
          Estacion         int NOT NULL,
          TablaSt          varchar(50) NOT NULL,
          Tablas           varchar(50) NOT NULL,
          CampoNombre      varchar(50) NOT NULL,
          CampoValor       varchar(50) NOT NULL,

		
	CONSTRAINT prieDocInHerrTablaST PRIMARY KEY CLUSTERED (Estacion,TablaSt)
	)
GO


/*************************** eDocInHerrTablaSTD **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInHerrTablaSTD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInHerrTablaSTD','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInHerrTablaSTD') and type = 'U')
CREATE TABLE eDocInHerrTablaSTD
        ( 
          Estacion         int NOT NULL,
          ID               int IDENTITY(1,1) NOT NULL,
          Operando1        varchar(8000) NOT NULL,
          Operador         varchar(50) NOT NULL,
          Operando2        varchar(8000) NOT NULL,

		
	CONSTRAINT prieDocInHerrTablaSTD PRIMARY KEY CLUSTERED (ID)
	)
GO




/*** eDocInRutaDVista2 ***/
if exists (select * from sysobjects where id = object_id('dbo.eDocInRutaDVista2') and type = 'V') drop view dbo.eDocInRutaDVista2
GO
CREATE VIEW eDocInRutaDVista2
--//WITH ENCRYPTION
AS 
  SELECT d.OperadorLogico+' ('+CONVERT(varchar,row_number() over(partition by d.eDocIn, d.Ruta,d.OperadorLogico ORDER BY d.GUID ASC))+')'as OperadorNumero,
  d.eDocIn, d.Ruta, d.GUID,d.OperadorLogico,d.Tipo  
  FROM eDocInRutaD d 
  GROUP BY d.eDocIn, d.Ruta, d.GUID,d.OperadorLogico,d.Tipo

GO
 

/*** eDocInRutaDVista ***/
if exists (select * from sysobjects where id = object_id('dbo.eDocInRutaDVista') and type = 'V') drop view dbo.eDocInRutaDVista
GO
CREATE VIEW eDocInRutaDVista
--//WITH ENCRYPTION
AS 
SELECT d.eDocIn, d.Ruta, d.GUID,d.OperadorLogico, c.Operador, ISNULL(c.Operando1,'')+' '+c.Operador+' '+ISNULL(c.Operando2,'') AS Condicion ,d.Tipo, d.OperadorNumero
  FROM eDocInRutaDVista2 d LEFT JOIN eDocInRutaDCondicion c ON  d.eDocIn = c.eDocIn AND d.Ruta = c.Ruta AND d.GUID = c.GUID

GO

/*** eDocInIntelisisService2 ***/
if exists (select * from sysobjects where id = object_id('dbo.eDocInIntelisisService2') and type = 'V') drop view dbo.eDocInIntelisisService2
GO
CREATE VIEW eDocInIntelisisService2
--//WITH ENCRYPTION
AS 
SELECT ID, Sistema, Contenido, Referencia, SubReferencia, Version, Usuario, Solicitud, Resultado,
  CASE WHEN Estatus = 'SINPROCESAR' THEN 'PENDIENTE' WHEN Estatus = 'PROCESADO' THEN 'CONCLUIDO' ELSE Estatus END Estatus,
  CASE WHEN Estatus = 'SINPROCESAR' THEN 1 WHEN Estatus = 'PROCESADO' THEN 10 ELSE 3 END Icono,
 FechaEstatus, Ok, OkRef, eDocInArchivo
  FROM IntelisisService

GO

/* eDocInTrabajo */
if not exists(select * from SysTabla where SysTabla = 'eDocInTrabajo')
INSERT INTO SysTabla (SysTabla) VALUES ('eDocInTrabajo')
if not exists (select * from sysobjects where id = object_id('dbo.eDocInTrabajo') and type = 'U') 
CREATE TABLE dbo.eDocInTrabajo (
        Trabajo        		        varchar(100)    NOT NULL,
	spSucursal			int		NOT NULL,
	spEmpresa			varchar(5)	NOT NULL,
	spUsuario			varchar(30)     NOT NULL,
	spOrigen                        varchar(255)    NOT NULL,
	spDestino                       varchar(255)    NOT NULL,
	Nombre				varchar(100)	NULL,
	Descripcion			varchar(255)	NULL,
	UltimaActualizacion	        datetime		NULL	DEFAULT GETDATE(),
	Activo				bit				NULL	DEFAULT 0,
	Modificar			bit				NULL	DEFAULT 0,
        HoraInicial			varchar(6)		NULL	DEFAULT '00:00',
	HoraFinal			varchar(6)		NULL	DEFAULT '23:59',
	Frecuencia			varchar (20)	NULL	DEFAULT 'Diaria',
	Valor				tinyint			NULL	DEFAULT 1,
	Recurrencia			tinyint			NULL	DEFAULT 1,
	FrecuenciaD			varchar (20)	NULL	DEFAULT 'Minutos',
	ValorD				tinyint			NULL	DEFAULT 30,
	Usuario    			varchar(30)		NULL	DEFAULT 'sa',
  	Contrasena  		        varchar(30)		NULL	DEFAULT '',
  	Domingo				bit				NULL	DEFAULT 0,
  	Lunes				bit				NULL	DEFAULT 0,
  	Martes				bit				NULL	DEFAULT 0,
  	Miercoles			bit				NULL	DEFAULT 0,
  	Jueves				bit				NULL	DEFAULT 0,
  	Viernes				bit				NULL	DEFAULT 0,
  	Sabado				bit				NULL	DEFAULT 0,
  	Tipo  				varchar(30)		NULL	DEFAULT 'Primer',
  	Dia  				varchar(30)		NULL	DEFAULT 'Lunes',
  	FechaInicial		        datetime		NULL    DEFAULT	GETDATE(),

  	
    	CONSTRAINT prieDocInTrabajo PRIMARY KEY  CLUSTERED (Trabajo)
)
GO


  /*************************** eDocInRutaTablaDOmision **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocInRutaTablaDOmision') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocInRutaTablaDOmision','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocInRutaTablaDOmision') and type = 'U')
CREATE TABLE eDocInRutaTablaDOmision
        (
         Modulo					varchar(5)  NOT NULL,
         Tablas					varchar(50) NOT NULL,
         Campo					varchar(50) NOT NULL,
         TipoDatos				varchar(50) NULL,
         Expresion				varchar(50) NULL,

						
	CONSTRAINT prieDocInRutaTablaDOmision PRIMARY KEY CLUSTERED (Modulo, Tablas, Campo)
	)
GO


 
IF NOT EXISTS(SELECT * FROM  eDocInRutaTablaDOmision WHERE Modulo = 'CXP' AND Tablas = 'Cxp' AND Campo = 'ProveedorMoneda')
  INSERT   eDocInRutaTablaDOmision( Modulo, Tablas, Campo,            TipoDatos, Expresion)
  SELECT                            'CXP',  'Cxp', 'ProveedorMoneda', 'TEXTO',   '{Moneda}'
  

IF NOT EXISTS(SELECT * FROM  eDocInRutaTablaDOmision WHERE Modulo = 'CXP' AND Tablas = 'Cxp' AND Campo = 'proveedortipocambio')
  INSERT   eDocInRutaTablaDOmision( Modulo, Tablas, Campo,            TipoDatos, Expresion)
  SELECT                            'CXP',  'Cxp', 'proveedortipocambio', 'NUMERICO'  , '{TipoCambio}'

IF NOT EXISTS(SELECT * FROM  eDocInRutaTablaDOmision WHERE Modulo = 'CXC' AND Tablas = 'Cxc' AND Campo = 'ClienteMoneda')
  INSERT   eDocInRutaTablaDOmision( Modulo, Tablas, Campo,            TipoDatos, Expresion)
  SELECT                            'CXC',  'Cxc', 'ClienteMoneda', 'TEXTO',   '{Moneda}'
  

IF NOT EXISTS(SELECT * FROM  eDocInRutaTablaDOmision WHERE Modulo = 'CXC' AND Tablas = 'Cxc' AND Campo = 'ClienteTipoCambio')
  INSERT   eDocInRutaTablaDOmision( Modulo, Tablas, Campo,            TipoDatos, Expresion)
  SELECT                            'CXC',  'Cxc', 'ClienteTipoCambio', 'NUMERICO'  , '{TipoCambio}'


