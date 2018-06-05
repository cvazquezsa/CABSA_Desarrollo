SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO


EXEC spDROP_TABLE 'SincroSSBEnvio'
EXEC spDROP_TABLE 'SincroSSBRecibo'
GO


-- select sucursal from dbo.fnSucursalesLigadas(108)
/**************** fnSucursalesLigadas ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSucursalesLigadas' AND type = 'TF') DROP FUNCTION fnSucursalesLigadas
GO
CREATE FUNCTION fnSucursalesLigadas (@Sucursal int)
RETURNS @Resultado TABLE (Sucursal int)
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado (Sucursal) VALUES (@Sucursal)
  INSERT @Resultado (Sucursal) SELECT Sucursal FROM Sucursal WHERE SucursalPrincipal = @Sucursal AND Sucursal <> @Sucursal
  RETURN
END
GO


-- select dbo.fnIPOk('1.1.1.1')
/**************************** fnIPOk ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnIPOk') and type in ('fn','tf')) drop function dbo.fnIPOk
GO
CREATE FUNCTION fnIPOk (@IP varchar(20))
RETURNS bit
AS BEGIN		
  DECLARE
    @Error	bit,
    @p		int,
    @puntos	int,
    @Resultado	bit

  SELECT @Resultado = 0, @Error = 0
  IF dbo.fnEsNumerico(SUBSTRING(@IP, 1, 1)) = 1 AND dbo.fnEsNumerico(SUBSTRING(@IP, LEN(@IP), 1)) = 1
  BEGIN
    SELECT @p = 1, @puntos = 0
    WHILE @p < LEN(@IP) AND @Error = 0
    BEGIN
      IF SUBSTRING(@IP, @p, 1) = '.' SELECT @puntos = @puntos + 1 ELSE
      IF dbo.fnEsNumerico(SUBSTRING(@IP, @p, 1)) = 0 SELECT @Error = 1
      SELECT @p = @p + 1
    END
    IF @puntos = 3 AND @Error = 0 SELECT @Resultado = 1
  END
  RETURN (@Resultado)
END
GO

/************** spSucursalIP *************/
if exists (select * from sysobjects where id = object_id('dbo.spSucursalIP') and type = 'P') drop procedure dbo.spSucursalIP
GO
CREATE PROCEDURE spSucursalIP
			@Sucursal	int,
			@IP		varchar(20)	OUTPUT,
			@IPPuerto	int		= NULL  OUTPUT,
			@IPDinamica	bit		= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL	nvarchar(max),   
    @IPNueva	varchar(20),
    @HTML	varchar(8000),
    @p		int,
    @URL	varchar(255),
    @Prefijo	varchar(255),
    @Sufijo	varchar(255)

  SELECT @IP = IP, @IPPuerto = IPPuerto, @IPDinamica = ISNULL(IPDinamica, 0) FROM Sucursal WHERE Sucursal = @Sucursal
  IF @IPDinamica = 1
  BEGIN
    SELECT @IPNueva = NULL

    SELECT @IPDinamica = ISNULL(IPDinamica, 0), @URL = ISNULL(IPDinamicaURL, ''), @Prefijo = ISNULL(IPDinamicaPrefijo, ''), @Sufijo = ISNULL(IPDinamicaSufijo, '') FROM Version
    IF @IPDinamica = 1
    BEGIN
      SELECT @SQL = N'EXEC master.dbo.xp_IntelisisURL @URL, @IPNueva OUTPUT'
      EXEC sp_executesql @SQL, N'@URL varchar(255), @IPNueva varchar(20) OUTPUT', @URL, @HTML OUTPUT
      IF NULLIF(RTRIM(@HTML), '') IS NOT NULL 
      BEGIN
        IF @Prefijo <> '' 
        BEGIN
          SELECT @p = CHARINDEX(@Prefijo, @html)
          IF @p > 0 SELECT @HTML = SUBSTRING(@HTML, @p+LEN(@Prefijo), LEN(@HTML))        
        END
        IF @Sufijo <> '' 
        BEGIN
          SELECT @p = CHARINDEX(@Sufijo, @html)
          IF @p > 0 SELECT @HTML = SUBSTRING(@HTML, 1, @p-1)        
        END
        SELECT @IPNueva = @HTML
      END
      IF NULLIF(RTRIM(@IPNueva), '') IS NOT NULL AND @IP <> @IPNueva AND dbo.fnIPOk(@IPNueva) = 1
      BEGIN
        UPDATE Sucursal SET IP = @IPNueva WHERE Sucursal = @Sucursal
        SELECT @IP = @IPNueva
      END
    END
  END
  
  RETURN
END
GO

-- drop table SincroSSBOk
/****** SincroSSBOk ******/
if not exists (select * from SysTabla where SysTabla = 'SincroSSBOk') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroSSBOk')
if not exists (select * from sysobjects where id = object_id('dbo.SincroSSBOk') and type = 'U') 
CREATE TABLE dbo.SincroSSBOk (
	Conversacion		uniqueidentifier	NOT NULL,

	Fecha			datetime		NULL	DEFAULT GETDATE(),
	TipoMensaje		varchar(255)		NULL,
	Datos			xml			NULL,	
	DatosRef		varchar(max)		NULL,

	Ok			int			NULL,
	OkRef			varchar(255)		NULL,

	CONSTRAINT priSincroSSBOk PRIMARY KEY CLUSTERED (Conversacion)
)
GO
EXEC spADD_INDEX 'SincroSSBOk', 'Fecha', 'Fecha'
GO

/*** VerSincroSSBOk ***/
if exists (select * from sysobjects where id = object_id('dbo.VerSincroSSBOk') and type = 'V') drop view dbo.VerSincroSSBOk
GO
CREATE VIEW VerSincroSSBOk
--//WITH ENCRYPTION
AS
SELECT CONVERT(varchar(36), Conversacion) AS Conversacion,
       Fecha,
       TipoMensaje,
       CONVERT(varchar(max), Datos) AS Datos,
       DatosRef,
       Ok,
       OkRef
  FROM SincroSSBOk
GO     


/************** spSincroSSBOk *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBOk') and type = 'P') drop procedure dbo.spSincroSSBOk
GO
CREATE PROCEDURE spSincroSSBOk
			@Conversacion		uniqueidentifier,
			@TipoMensaje		varchar(255),
			@Datos			xml,
			@DatosRef		varchar(max),

			@SQL_ERROR_NUMBER	int,
			@SQL_ERROR_MESSAGE	varchar(255),
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dias	int

  IF @Conversacion IS NULL RETURN

  IF @SQL_ERROR_NUMBER <> 0 
    SELECT @Ok = 1, @OkRef = ISNULL(@SQL_ERROR_MESSAGE, '')+' ['+CONVERT(varchar, @SQL_ERROR_NUMBER)+']'

  IF @Ok IS NOT NULL 
  BEGIN    
    SELECT @Dias = ISNULL(SincroSBBOkConservar, 1)
      FROM Version
    DELETE SincroSSBOk WHERE Fecha < DATEADD(day, -@Dias, GETDATE())

    IF NOT EXISTS(SELECT Conversacion FROM SincroSSBOk WHERE Conversacion = @Conversacion)
      INSERT SincroSSBOk (
              Conversacion,  TipoMensaje,  Datos,  DatosRef,  Ok,  OkRef)
      VALUES (@Conversacion, @TipoMensaje, @Datos, @DatosRef, @Ok, @OkRef)
  END
  RETURN
END
GO

-- drop table SincroSSBBaja
/****** SincroSSBBaja ******/
if not exists (select * from SysTabla where SysTabla = 'SincroSSBBaja') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroSSBBaja')
if not exists (select * from sysobjects where id = object_id('dbo.SincroSSBBaja') and type = 'U') 
CREATE TABLE dbo.SincroSSBBaja (
	Tabla			varchar(100) 		NOT NULL,
	SincroID		timestamp		NOT NULL,

	Llave			xml			NOT NULL,

	CONSTRAINT priSincroSSBBaja PRIMARY KEY CLUSTERED (Tabla, SincroID)
)
GO

/************** spSincroSSBBaja *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBBaja') and type = 'P') drop procedure dbo.spSincroSSBBaja
GO
CREATE PROCEDURE spSincroSSBBaja
			@Tabla			varchar(100),
			@Llave			xml
--//WITH ENCRYPTION
AS BEGIN
  IF @Tabla IS NOT NULL AND @Llave IS NOT NULL
    INSERT SincroSSBBaja (Tabla, Llave) VALUES (@Tabla, @Llave)
  RETURN
END
GO
/*
EXEC spSincroSSBBaja 'Art', '<Llave Articulo="A1"/>'
EXEC spSincroSSBBaja 'Art', '<Llave Articulo="A2"/>'
SELECT Llave FROM SincroSSBBaja WHERE Tabla='Art' FOR XML RAW("Baja"), ROOT("Bajas")
*/

/****** SincroSSBControl ******/
if not exists (select * from SysTabla where SysTabla = 'SincroSSBControl') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroSSBControl')
if not exists (select * from sysobjects where id = object_id('dbo.SincroSSBControl') and type = 'U') 
CREATE TABLE dbo.SincroSSBControl (
	SucursalOrigen		int			NOT NULL,
	SucursalDestino		int			NOT NULL,
	SincroID		timestamp		NOT NULL,

	SincroIDAnterior	binary(8)		NULL,
	Conversacion		uniqueidentifier	NULL,
	FechaEnvio		datetime		NULL,

	CONSTRAINT priSincroSSBControl PRIMARY KEY CLUSTERED (SucursalOrigen, SucursalDestino, SincroID)
)
GO
EXEC spADD_INDEX 'SincroSSBControl', 'SincroID', 'SincroID'
GO

/************** spSincroSSBControl *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBControl') and type = 'P') drop procedure dbo.spSincroSSBControl
GO
CREATE PROCEDURE spSincroSSBControl
			@SucursalOrigen		int,
			@SucursalDestino	int,
			@Conversacion		uniqueidentifier	OUTPUT,
			@FechaEnvio		datetime		OUTPUT,
			@Desde			timestamp		OUTPUT,
			@Hasta			timestamp		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Desde = 0, @FechaEnvio = GETDATE()
  SELECT @Desde = ISNULL(MAX(SincroID), 0) 
    FROM SincroSSBControl
   WHERE SucursalDestino = @SucursalDestino
  INSERT SincroSSBControl (
          SucursalOrigen,  SucursalDestino,  Conversacion,  FechaEnvio,  SincroIDAnterior) 
  VALUES (@SucursalOrigen, @SucursalDestino, @Conversacion, @FechaEnvio, @Desde)
  SELECT @Hasta = @@DBTS
  RETURN
END
GO

/****** SincroSSBLog ******/
if not exists (select * from SysTabla where SysTabla = 'SincroSSBLog') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroSSBLog')
if not exists (select * from sysobjects where id = object_id('dbo.SincroSSBLog') and type = 'U') 
CREATE TABLE dbo.SincroSSBLog (
	RID			int			NOT NULL IDENTITY(1,1),

	Solicitud		uniqueidentifier	NULL,
	Conversacion		uniqueidentifier	NULL,
	Tabla			varchar(100) 		NULL,
	PaqueteCambios		int			NULL,
	PaqueteBajas		int			NULL,
	SucursalOrigen		int			NULL,
	SucursalDestino		int			NULL,
	FechaEnvio		datetime		NULL,
	FechaRecibo		datetime		NULL,

	CONSTRAINT priSincroSSBLog PRIMARY KEY CLUSTERED (RID)
)
GO
EXEC spALTER_TABLE 'SincroSSBLog', 'PaqueteCambios', 'int NULL'
EXEC spALTER_TABLE 'SincroSSBLog', 'PaqueteBajas', 'int	NULL'
GO


/*** VerSincroSSBLog ***/
if exists (select * from sysobjects where id = object_id('dbo.VerSincroSSBLog') and type = 'V') drop view dbo.VerSincroSSBLog
GO
CREATE VIEW VerSincroSSBLog
--//WITH ENCRYPTION
AS
SELECT RID,
       CONVERT(varchar(36), Solicitud) AS Solicitud,
       CONVERT(varchar(36), Conversacion) AS Conversacion,
       'ConversacionTabla' = Tabla,
       PaqueteCambios,
       PaqueteBajas,
       SucursalOrigen,
       SucursalDestino,
       FechaEnvio,
       FechaRecibo
  FROM SincroSSBLog
GO     

/************** spSincroSSBLog *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBLog') and type = 'P') drop procedure dbo.spSincroSSBLog
GO
CREATE PROCEDURE spSincroSSBLog
			@Solicitud		uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@Tabla			varchar(100),
			@PaqueteCambios		int,
			@PaqueteBajas		int,
			@SucursalOrigen		int,
			@SucursalDestino	int,
			@FechaEnvio		datetime,
			@FechaRecibo		datetime
--//WITH ENCRYPTION
AS BEGIN
  INSERT SincroSSBLog (
          Solicitud,  Conversacion,  Tabla,  PaqueteCambios,  PaqueteBajas,  SucursalOrigen,  SucursalDestino,  FechaEnvio,  FechaRecibo)
  VALUES (@Solicitud, @Conversacion, @Tabla, @PaqueteCambios, @PaqueteBajas, @SucursalOrigen, @SucursalDestino, @FechaEnvio, @FechaRecibo)
  RETURN
END
GO


--EXEC spDROP_TABLE 'SincroSSBSolicitud'
/****** SincroSSBSolicitud ******/
if not exists (select * from SysTabla where SysTabla = 'SincroSSBSolicitud') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroSSBSolicitud')
if not exists (select * from sysobjects where id = object_id('dbo.SincroSSBSolicitud') and type = 'U') 
CREATE TABLE dbo.SincroSSBSolicitud (
	Solicitud	uniqueidentifier	NOT NULL,

	Tipo		varchar(100)		NULL,
	SucursalOrigen	int			NULL,
	SucursalDestino	int			NULL,
	FechaEnvio	datetime		NULL,
	FechaRecibo	datetime		NULL,	
	FechaConclusion	datetime		NULL,
	Estatus		varchar(15)		NULL,

	CONSTRAINT priSincroSSBSolicitud PRIMARY KEY CLUSTERED (Solicitud)
)
GO
EXEC spDROP_COLUMN 'SincroSSBSolicitud', 'FechaSolicitud'
GO
EXEC spALTER_TABLE 'SincroSSBSolicitud', 'FechaConclusion', 'datetime NULL'
GO
EXEC spADD_INDEX 'SincroSSBSolicitud', 'Estatus', 'SucursalOrigen, SucursalDestino, Tipo, Estatus, Solicitud'
GO

/*** VerSincroSSBSolicitud ***/
if exists (select * from sysobjects where id = object_id('dbo.VerSincroSSBSolicitud') and type = 'V') drop view dbo.VerSincroSSBSolicitud
GO
CREATE VIEW VerSincroSSBSolicitud
--//WITH ENCRYPTION
AS
SELECT CONVERT(varchar(36), Solicitud) AS Solicitud,
       Tipo,
       SucursalOrigen,
       SucursalDestino,
       FechaEnvio,
       FechaRecibo,
       Estatus
  FROM SincroSSBSolicitud
GO     

/************** spSincroSSBSolicitud *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBSolicitud') and type = 'P') drop procedure dbo.spSincroSSBSolicitud
GO
CREATE PROCEDURE spSincroSSBSolicitud
			@Solicitud		uniqueidentifier,
			@Tipo			varchar(100)	= NULL,
			@SucursalOrigen		int		= NULL,
			@SucursalDestino	int		= NULL,
			@FechaEnvio		datetime	= NULL,
			@FechaRecibo		datetime	= NULL,
			@Estatus		varchar(15)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaConclusion	datetime

  IF @Estatus = 'CONCLUIDO' SELECT @FechaConclusion = GETDATE()

  IF @Solicitud IS NOT NULL
  BEGIN
    UPDATE SincroSSBSolicitud
       SET Tipo = ISNULL(@Tipo, Tipo),
    	   SucursalOrigen = ISNULL(@SucursalOrigen, SucursalOrigen),
 	   SucursalDestino = ISNULL(@SucursalDestino, SucursalDestino), 
	   FechaEnvio = ISNULL(@FechaEnvio, FechaEnvio),  
           FechaRecibo = ISNULL(@FechaRecibo, FechaRecibo),
           FechaConclusion = ISNULL(@FechaConclusion, FechaConclusion),
	   Estatus = ISNULL(@Estatus, Estatus)
     WHERE Solicitud = @Solicitud
    IF @@ROWCOUNT = 0
      INSERT SincroSSBSolicitud (
              Solicitud,  Tipo,  SucursalOrigen,  SucursalDestino,  FechaEnvio,  FechaRecibo,  FechaConclusion,  Estatus)
      VALUES (@Solicitud, @Tipo, @SucursalOrigen, @SucursalDestino, @FechaEnvio, @FechaRecibo, @FechaConclusion, @Estatus)
  END
  RETURN
END
GO

/****** SincroSSBModoManual ******/
if not exists (select * from SysTabla where SysTabla = 'SincroSSBModoManual') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroSSBModoManual')
if not exists (select * from sysobjects where id = object_id('dbo.SincroSSBModoManual') and type = 'U') 
CREATE TABLE dbo.SincroSSBModoManual (
	RID			int			NOT NULL IDENTITY(1,1),

	Conversacion		uniqueidentifier	NULL,
	TipoMensaje		nvarchar(256)		NULL,
	Datos			xml			NULL,

	FechaRecibo		datetime		NULL	DEFAULT GETDATE(),

	Ok			int			NULL,
	OkRef			varchar(255)		NULL,

	CONSTRAINT priSincroSSBModoManual PRIMARY KEY CLUSTERED (RID)
)
GO


-- drop table SincroSSBNoRebote
/****** SincroSSBNoRebote ******/
if not exists (select * from SysTabla where SysTabla = 'SincroSSBNoRebote') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroSSBNoRebote')
if not exists (select * from sysobjects where id = object_id('dbo.SincroSSBNoRebote') and type = 'U') 
CREATE TABLE dbo.SincroSSBNoRebote (
	SincroID		binary(8)		NOT NULL,
	Sucursal		int			NOT NULL,

	CONSTRAINT priSincroSSBNoRebote PRIMARY KEY CLUSTERED (SincroID, Sucursal)
)
GO


-- select dbo.fnConcatenarMAX('', '2', ', ')
/**************************** fnConcatenarMAX ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnConcatenarMAX') and type in ('fn','tf')) drop function dbo.fnConcatenarMAX
GO
CREATE FUNCTION fnConcatenarMAX (@Valor varchar(max), @Agregar varchar(max), @Separador varchar(20))
RETURNS varchar(max)
AS BEGIN		
  DECLARE
    @Resultado	varchar(max)

  SELECT @Valor = ISNULL(@Valor, '')
  IF @Valor <> '' SELECT @Valor = @Valor + @Separador
  RETURN (@Valor + @Agregar)
END
GO

/*
declare
  @datos xml,
@Conversacion uniqueidentifier,
@PaqueteCambios int,
@PaqueteBajas int
select @Conversacion = newid()
EXEC spSincroSSBEnviarTabla NULL, @Conversacion, 0, 108, 0, 0, 0, 'Art', 'Cuenta', NULL, @Datos OUTPUT, @PaqueteCambios OUTPUT, @PaqueteBajas OUTPUT
select @datos, @PaqueteCambios, @PaqueteBajas
*/

/************** spSincroSSBEnviarTabla *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBEnviarTabla') and type = 'P') drop procedure dbo.spSincroSSBEnviarTabla
GO

CREATE PROCEDURE spSincroSSBEnviarTabla
                  @Desde                  timestamp,
                  @Hasta                  timestamp,
                  @Solicitud        uniqueidentifier,
                  @Conversacion           uniqueidentifier,
                  @SucursalOrigen         int,
                  @SucursalOrigenIP varchar(20),
                  @SucursalOrigenPuerto   int,
                  @SucursalDestino  int,
                  @EsSincroFinal          bit,
                  @EsRespaldo       bit,
                  @EsTRCL                 bit,              
                  @Tabla                  varchar(100),
                  @TablaTipo        varchar(20),
                  @TablaModulo            char(5),
                  @Datos                  xml       OUTPUT,
                  @PaqueteCambios         int       OUTPUT, 
                  @PaqueteBajas           int       OUTPUT

--//WITH ENCRYPTION

AS BEGIN
  DECLARE

    @FechaEnvio         datetime,
    @SQL          nvarchar(max),
    @Cambios            nvarchar(max),
    @Bajas        nvarchar(max),
    @WHERE        nvarchar(max)

  SELECT @Datos = NULL, @PaqueteCambios = 0, @PaqueteBajas = 0
  IF dbo.fnCampoExiste(@Tabla, 'SincroID') = 0 
    EXEC spSincroSSBActivarTabla @Tabla

 

  SELECT @TablaTipo = UPPER(@TablaTipo), @TablaModulo = NULLIF(RTRIM(@TablaModulo), ''), @WHERE = '', @Bajas = ''
  IF @TablaTipo = 'MOVIMIENTO' AND @SucursalDestino > 0 AND dbo.fnCampoExiste(@Tabla, 'Sucursal') = 1
  BEGIN
    SELECT @WHERE = N'(Sucursal IN (SELECT Sucursal FROM dbo.fnSucursalesLigadas(@SucursalDestino))'
    IF @TablaModulo IS NOT NULL AND dbo.fnCampoExiste(@Tabla, 'SucursalOrigen') = 1
      SELECT @WHERE = @WHERE + N' OR SucursalOrigen IN (SELECT Sucursal FROM dbo.fnSucursalesLigadas(@SucursalDestino))'
    SELECT @WHERE = @WHERE + N')'
  END
  IF @EsRespaldo = 0
  BEGIN
    SELECT @SQL = N'SELECT @Bajas = CONVERT(nvarchar(max), (SELECT Llave FROM SincroSSBBaja WHERE Tabla='''+@Tabla+''' AND SincroID BETWEEN @Desde AND @Hasta FOR XML RAW(''Baja''), ROOT(''Bajas'')))'
    EXEC sp_executesql @SQL, N'@Bajas nvarchar(max) OUTPUT, @Desde timestamp, @Hasta timestamp', @Bajas OUTPUT, @Desde = @Desde, @Hasta = @Hasta
  END

  IF @EsRespaldo = 0
  BEGIN
    IF @WHERE <> '' SELECT @WHERE = @WHERE + N' AND '
    SELECT @WHERE = @WHERE + N' (SincroID NOT IN (SELECT SincroID FROM SincroSSBNoRebote WHERE Sucursal=@SucursalDestino)) AND (SincroID BETWEEN @Desde AND @Hasta)'
  END 
 
  IF @WHERE <> '' SELECT @WHERE = N' WHERE '+@WHERE
  SELECT @SQL = N'SELECT @Cambios = CONVERT(nvarchar(max), (SELECT * FROM '+@Tabla+@WHERE+N' FOR XML RAW(''Cambio''), BINARY BASE64, ROOT(''Cambios'')))'
  EXEC sp_executesql @SQL, N'@Cambios nvarchar(max) OUTPUT, @Desde timestamp, @Hasta timestamp, @SucursalDestino int', @Cambios OUTPUT, @Desde = @Desde, @Hasta = @Hasta, @SucursalDestino = @SucursalDestino

  -- para evitar caracteres raros

  SELECT @Cambios = REPLACE(@Cambios,'&#','##')
  SELECT @Cambios = REPLACE(@Cambios,'##x0D','&#x0D')
  SELECT @Cambios = REPLACE(@Cambios,'##x0A','&#x0A')

  SELECT @PaqueteCambios = LEN(@Cambios), @PaqueteBajas = LEN(@Bajas)
  IF @Bajas IS NOT NULL
    SELECT @Cambios = ISNULL(@Cambios, '') + @Bajas

  IF @Cambios IS NOT NULL
    SELECT @Cambios = '<IntelisisSincroSSB'+
                  dbo.fnXML('Tipo', 'Tabla')+
                  dbo.fnXMLGID('Solicitud', @Solicitud)+
                  dbo.fnXMLGID('Conversacion', @Conversacion)+
                  dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
                  dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
                  dbo.fnXML('SucursalOrigenIP', @SucursalOrigenIP)+
                  dbo.fnXMLInt('SucursalOrigenPuerto', @SucursalOrigenPuerto)+
                  dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
                      '>'+
                  '<Tabla'+
                  dbo.fnXML('Tabla', @Tabla)+
                  dbo.fnXMLBit('EsSincroFinal', @EsSincroFinal)+
                  dbo.fnXMLBit('EsRespaldo', @EsRespaldo)+
                  dbo.fnXMLBit('EsTRCL', @EsTRCL)+
                  dbo.fnXMLInt('PaqueteCambios', @PaqueteCambios)+
                  dbo.fnXMLInt('PaqueteBajas', @PaqueteBajas)+
                        '>'+
                  NULLIF(RTRIM(@Cambios), '')+
                  '</Tabla></IntelisisSincroSSB>'
  SELECT @Datos = CONVERT(xml, @Cambios)
  RETURN
END
GO

/************** spSincroSSBIniciarConversacion *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBIniciarConversacion') and type = 'P') drop procedure dbo.spSincroSSBIniciarConversacion
GO
CREATE PROCEDURE spSincroSSBIniciarConversacion	
			@SucursalOrigen		int,
			@SucursalDestino	int,
			@Conversacion		uniqueidentifier	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL			nvarchar(max),
    @ServicioLocal		varchar(100),
    @ServicioRemoto		varchar(100),
    @MismaInstancia		bit,
    @EncriptarOrigen		bit,
    @EncriptarDestino		bit
   
  SELECT @EncriptarOrigen = ComunicacionEncriptada FROM Sucursal WHERE Sucursal = @SucursalOrigen
  SELECT @EncriptarDestino = ComunicacionEncriptada FROM Sucursal WHERE Sucursal = @SucursalDestino
  SELECT @MismaInstancia = ISNULL(SincroSSBMismaInstancia, 0) FROM Version
  SELECT @ServicioLocal = 'ServicioSSB_'+CONVERT(varchar, @SucursalOrigen), @ServicioRemoto = 'ServicioSSB_'+CONVERT(varchar, @SucursalDestino)
  SELECT @SQL = N'BEGIN DIALOG CONVERSATION @Conversacion
                   FROM SERVICE '+@ServicioLocal+'
                     TO SERVICE '''+@ServicioRemoto+'''
                     ON CONTRACT ContratoSSB'
  IF @MismaInstancia = 0 AND (ISNULL(@EncriptarOrigen, 0) = 1 OR ISNULL(@EncriptarDestino, 0) = 1)
    SELECT @SQL = @SQL + N' WITH ENCRYPTION = ON'
  EXEC sp_executesql @SQL, N'@Conversacion uniqueidentifier OUTPUT', @Conversacion OUTPUT
  RETURN
END
GO

-- spSincroSSBEnviar 0
/************** spSincroSSBEnviar *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBEnviar') and type = 'P') drop procedure dbo.spSincroSSBEnviar
GO
CREATE PROCEDURE spSincroSSBEnviar
			@SucursalDestino	int = 0,
			@EsSincroFinal		bit = 0,
			@EsRespaldo		bit = 0,
			@EsTRCL			bit = 0,
			@EsPrueba		bit = 0,
			@Solicitud		uniqueidentifier = NULL,
			@FechaEnvio		datetime	 = NULL OUTPUT,
			@Ok			int		 = NULL OUTPUT,
			@OkRef			varchar(255)	 = NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalOrigen		int,
    @SucursalOrigenIP		varchar(20),
    @SucursalOrigenPuerto	int,
    @Conversacion		uniqueidentifier,
    @Desde			timestamp,
    @Hasta			timestamp,
    @SQL			nvarchar(max),
    @Tabla			varchar(100),
    @TablaTipo			varchar(20),
    @TablaModulo		char(5),
    @EnviarTabla		bit,
    @Datos			xml,
    @PaqueteCambios		int, 
    @PaqueteBajas		int,
    @Conteo			bit,
    @SQL_ERROR_NUMBER		int,
    @SQL_ERROR_MESSAGE		varchar(255)

  SELECT @SQL_ERROR_NUMBER = 0, @SQL_ERROR_MESSAGE = NULL
  SELECT @Conteo = 0
  SELECT @SucursalOrigen = Sucursal FROM Version
  EXEC spSucursalIP @SucursalOrigen, @SucursalOrigenIP OUTPUT, @SucursalOrigenPuerto OUTPUT

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

  BEGIN TRY
    EXEC spSincroSSBIniciarConversacion @SucursalOrigen, @SucursalDestino, @Conversacion OUTPUT
    IF @EsPrueba = 1
    BEGIN
      SELECT @Datos = '<IntelisisSincroSSB'+
  			dbo.fnXML('Tipo', 'Prueba')+
			dbo.fnXMLGID('Solicitud', @Solicitud)+
			dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
			dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
			dbo.fnXML('SucursalOrigenIP', @SucursalOrigenIP)+
			dbo.fnXMLInt('SucursalOrigenPuerto', @SucursalOrigenPuerto)+
			dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
		      '/>'
      SELECT @SQL = N'SEND ON CONVERSATION @Conversacion MESSAGE TYPE [SincroSSB/Prueba] (@Datos)'
      EXEC sp_executesql @SQL, N'@Conversacion uniqueidentifier, @Datos xml', @Conversacion, @Datos
    END ELSE
    BEGIN
      EXEC spSincroSSBControl @SucursalOrigen, @SucursalDestino, @Conversacion, @FechaEnvio OUTPUT, @Desde OUTPUT, @Hasta OUTPUT
      DECLARE crSincroSSBEnviar CURSOR LOCAL FOR 
       SELECT SysTabla, UPPER(Tipo), Modulo
         FROM SysTabla
        WHERE SincroActivo = 1 AND UPPER(NULLIF(RTRIM(Tipo), '')) NOT IN (NULL, 'N/A') AND (@EsRespaldo = 1 OR SincroID BETWEEN @Desde AND @Hasta)
        ORDER BY SincroOrden, SysTabla
      OPEN crSincroSSBEnviar
      FETCH NEXT FROM crSincroSSBEnviar INTO @Tabla, @TablaTipo, @TablaModulo
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL 
      BEGIN
        IF @@FETCH_STATUS <> -2 AND dbo.fnTablaExiste(@Tabla) = 1
        BEGIN
          SELECT @EnviarTabla = 1
          IF @EsTRCL = 1 AND @TablaTipo NOT IN ('MAESTRO', 'CUENTA') SELECT @EnviarTabla = 0 ELSE
          IF @TablaTipo IN ('CUENTASUCURSAL', 'CUENTAREGION', 'SALDOSUCURSAL', 'SALDOREGION') AND @SucursalOrigen > 0 SELECT @EnviarTabla = 0 ELSE
          IF @TablaTipo = 'SUCURSALINFOMATRIZ' AND @SucursalOrigen = 0 SELECT @EnviarTabla = 0 ELSE
          IF @EsRespaldo = 0 AND @TablaTipo = 'MAESTRO' AND @SucursalOrigen > 0 SELECT @EnviarTabla = 0 
          IF @EnviarTabla = 1
          BEGIN
            EXEC spSincroSSBEnviarTabla @Desde, @Hasta, @Solicitud, @Conversacion, @SucursalOrigen, @SucursalOrigenIP, @SucursalOrigenPuerto, @SucursalDestino, @EsSincroFinal, @EsRespaldo, @EsTRCL, @Tabla, @TablaTipo, @TablaModulo, @Datos OUTPUT, @PaqueteCambios OUTPUT, @PaqueteBajas OUTPUT
            IF @Datos IS NOT NULL
            BEGIN
              SELECT @SQL = N'SEND ON CONVERSATION @Conversacion MESSAGE TYPE [SincroSSB/Sincro] (@Datos)'
              EXEC sp_executesql @SQL, N'@Conversacion uniqueidentifier, @Datos xml', @Conversacion, @Datos
              EXEC spSincroSSBLog @Solicitud, @Conversacion, @Tabla, @PaqueteCambios, @PaqueteBajas, @SucursalOrigen, @SucursalDestino, @FechaEnvio, NULL
              SELECT @Conteo = @Conteo + 1
            END
          END
        END
        FETCH NEXT FROM crSincroSSBEnviar INTO @Tabla, @TablaTipo, @TablaModulo
      END
      CLOSE crSincroSSBEnviar
      DEALLOCATE crSincroSSBEnviar

      /* Hay que checar bien esto del conteo porque puede genear un rebote permantent si se quita */
      IF @Conteo > 0 
      BEGIN
        SELECT @Datos = '<IntelisisSincroSSB'+
			  dbo.fnXML('Tipo', 'SincroFinal')+
  			  dbo.fnXMLGID('Solicitud', @Solicitud)+
			  dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
			  dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
			  dbo.fnXML('SucursalOrigenIP', @SucursalOrigenIP)+
			  dbo.fnXMLInt('SucursalOrigenPuerto', @SucursalOrigenPuerto)+
			  dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
			  dbo.fnXMLBit('EsRespaldo', @EsRespaldo)+
			  dbo.fnXMLBit('EsTRCL', @EsTRCL)+
			'/>'
        SELECT @SQL = N'SEND ON CONVERSATION @Conversacion MESSAGE TYPE [SincroSSB/SincroFinal] (@Datos)'
        EXEC sp_executesql @SQL, N'@Conversacion uniqueidentifier, @Datos xml', @Conversacion, @Datos
        IF @EsRespaldo = 0 AND @EsTRCL = 0
          EXEC spSincroSSBSolicitud @Solicitud, 'Sincronizacion', @SucursalOrigen, @SucursalDestino, @FechaEnvio = @FechaEnvio, @Estatus = 'PENDIENTE'
      END
    END

    END CONVERSATION @Conversacion
  END TRY
  BEGIN CATCH
    SELECT @SQL_ERROR_NUMBER = ERROR_NUMBER(), @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
    END CONVERSATION @Conversacion WITH ERROR = @SQL_ERROR_NUMBER DESCRIPTION = @SQL_ERROR_MESSAGE
  END CATCH
  EXEC spSincroSSBOk @Conversacion, 'SincroSSB/Sincro', @Datos, @Tabla, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

/************** spSincroSSBRecibirSincro *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBRecibirSincro') and type = 'P') drop procedure dbo.spSincroSSBRecibirSincro
GO
CREATE PROCEDURE spSincroSSBRecibirSincro
			@iDatos			int,
			@Solicitud		uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@FechaEnvio		datetime,
			@SucursalLocal		int,
			@SucursalSincro		int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla		varchar(100),
    @FechaRecibo	datetime,
    @EsRespaldo		bit,
    @EsTRCL		bit,
    @PaqueteCambios	int, 
    @PaqueteBajas	int,
    @SQL		nvarchar(max),
    @IDENTITY_ON	nvarchar(max),
    @IDENTITY_OFF	nvarchar(max),
    @SELECT		varchar(max),
    @WITH		varchar(max),
    @JOIN		varchar(max),
    @CampoIdentity	varchar(100)

  SELECT @FechaRecibo = GETDATE()
  DECLARE crSincroSSBRecibirTablas CURSOR LOCAL FOR
  SELECT Tabla, ISNULL(EsRespaldo, 0), ISNULL(EsTRCL, 0), PaqueteCambios, PaqueteBajas
    FROM OPENXML (@iDatos, '/IntelisisSincroSSB/Tabla')
    WITH (Tabla varchar(100), EsRespaldo bit, EsTRCL bit, PaqueteCambios int, PaqueteBajas int)
  OPEN crSincroSSBRecibirTablas
  FETCH NEXT FROM crSincroSSBRecibirTablas INTO @Tabla, @EsRespaldo, @EsTRCL, @PaqueteCambios, @PaqueteBajas
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @EsRespaldo = 1 AND @SucursalLocal = 0
    BEGIN
      IF (SELECT SincroSSBRecibirRespaldoMatriz FROM Version) = 0 SELECT @Ok = 17030
    END
    IF @@FETCH_STATUS <> -2 AND ((@SucursalLocal = 0 AND @SucursalSincro > 0) OR (@SucursalLocal > 0 AND @SucursalSincro = 0)) AND dbo.fnTablaExiste(@Tabla) = 1
    BEGIN
      EXEC spTablaEstructura @Tabla, @SELECT = @SELECT OUTPUT, @WITH = @WITH OUTPUT, @CampoIdentity = @CampoIdentity OUTPUT, @ExcluirTimeStamp = 1, @ExcluirCalculados = 1--, @ExcluirImage = 1
      EXEC spTablaEstructura @Tabla, @JOIN = @JOIN OUTPUT, @JOIN_Tabla1 = @Tabla, @JOIN_Tabla2 = 'x', @PK = 1
      -- si no tiene llave primaria que no haga nada
      IF NULLIF(RTRIM(@JOIN), '') IS NOT NULL
      BEGIN
        EXEC spSincroSSBLog @Solicitud, @Conversacion, @Tabla, @PaqueteCambios, @PaqueteBajas, @SucursalSincro, @SucursalLocal, @FechaEnvio, @FechaRecibo
        EXEC spSincroSSBSolicitud @Solicitud, @FechaRecibo = @FechaRecibo, @Estatus = 'RECIBIENDO'

        SELECT @SQL = N'DISABLE TRIGGER ALL ON '+@Tabla
        EXEC sp_executesql @SQL

        IF @EsRespaldo = 1
        BEGIN
          SELECT @SQL = N'TRUNCATE TABLE '+@Tabla
          EXEC sp_executesql @SQL
        END ELSE
        BEGIN
          SELECT @SQL = N'DELETE '+@Tabla+N' WITH (TABLOCK) '+
  		        N'  FROM OPENXML (@iDatos, ''/IntelisisSincroSSB/Tabla/Bajas/Baja/Llave/Llave'', 1) WITH ('+@WITH+') x '+
                        N'  JOIN '+@Tabla+N' ON '+@JOIN
          EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos

          SELECT @SQL = N'DELETE '+@Tabla+N' WITH (TABLOCK) '+
	  	        N'  FROM OPENXML (@iDatos, ''/IntelisisSincroSSB/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x '+
                        N'  JOIN '+@Tabla+N' ON '+@JOIN
          EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos
        END

        SELECT @IDENTITY_ON = N'', @IDENTITY_OFF = N''
        IF @CampoIdentity IS NOT NULL
        BEGIN
          SELECT @IDENTITY_ON  = N'SET IDENTITY_INSERT '+@Tabla+' ON;',
                 @IDENTITY_OFF = N'SET IDENTITY_INSERT '+@Tabla+' OFF;'
        END 
        SELECT @SQL = @IDENTITY_ON + N'INSERT '+@Tabla

        IF @EsRespaldo = 0 
          SELECT @SQL = @SQL + N' WITH (TABLOCK)'

        SELECT @SQL = @SQL + N' ('+@SELECT+N') '+
                      N'SELECT '+@SELECT+N' FROM OPENXML (@iDatos, ''/IntelisisSincroSSB/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+');'+
                      @IDENTITY_OFF
        EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos

        IF @CampoIdentity IS NOT NULL
          EXEC spSincroActualizarSemillaCampo @Tabla, @CampoIdentity

        SELECT @SQL = N'UPDATE SysTabla WITH (ROWLOCK) SET UltimoCambio = GETDATE() WHERE SysTabla = '''+@Tabla+''''
        EXEC sp_executesql @SQL

        SELECT @SQL = N'ENABLE TRIGGER ALL ON '+@Tabla
        EXEC sp_executesql @SQL

        SELECT @SQL = N'INSERT SincroSSBNoRebote (SincroID, Sucursal) '+
                      N'SELECT '+@Tabla+N'.SincroID, @Sucursal '+
		      N'  FROM OPENXML (@iDatos, ''/IntelisisSincroSSB/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x '+
                      N'  JOIN '+@Tabla+N' ON '+@JOIN
        EXEC sp_executesql @SQL, N'@iDatos int, @Sucursal int', @iDatos = @iDatos, @Sucursal = @SucursalSincro
      END
    END
    FETCH NEXT FROM crSincroSSBRecibirTablas INTO @Tabla, @EsRespaldo, @EsTRCL, @PaqueteCambios, @PaqueteBajas
  END
  CLOSE crSincroSSBRecibirTablas
  DEALLOCATE crSincroSSBRecibirTablas

  RETURN
END
GO

/************** spSincroSSBEnviarRespaldo *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBEnviarRespaldo') and type = 'P') drop procedure dbo.spSincroSSBEnviarRespaldo	
GO

CREATE PROCEDURE spSincroSSBEnviarRespaldo
                  @iDatos                 int,
                  @Solicitud        uniqueidentifier,
                  @Conversacion           uniqueidentifier,
                  @FechaEnvio       datetime,
                  @SucursalLocal          int,
                  @SucursalSincro         int,
                  @Ok               int         OUTPUT,
                  @OkRef                  varchar(255)      OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EsTRCL bit
    
  IF @SucursalLocal <> @SucursalSincro AND @SucursalLocal = 0 AND @SucursalSincro > 0
  BEGIN
    SELECT @EsTRCL = TRCL FROM Version
    EXEC spSincroSSBEnviar @SucursalSincro, @EsRespaldo = 1, @EsTRCL = @EsTRCL, @Solicitud = @Solicitud, @FechaEnvio = @FechaEnvio OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    EXEC spSincroSSBSolicitud @Solicitud, 'Respaldo', @SucursalLocal, @SucursalSincro, @FechaEnvio = @FechaEnvio, @Estatus = 'CONCLUIDO'
  END
  RETURN
END
GO

/************** spSincroSSBEnviarTRCL *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBEnviarTRCL') and type = 'P') drop procedure dbo.spSincroSSBEnviarTRCL
GO
CREATE PROCEDURE spSincroSSBEnviarTRCL
			@iDatos			int,
			@Solicitud		uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@FechaEnvio		datetime,
			@SucursalLocal		int,
			@SucursalSincro		int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @SucursalLocal <> @SucursalSincro AND @SucursalLocal = 0 AND @SucursalSincro > 0
  BEGIN
    EXEC spSincroSSBEnviar @SucursalSincro, @EsTRCL = 1, @Solicitud = @Solicitud, @FechaEnvio = @FechaEnvio OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    EXEC spSincroSSBSolicitud @Solicitud, 'TRCL', @SucursalLocal, @SucursalSincro, @FechaEnvio = @FechaEnvio, @Estatus = 'CONCLUIDO'
  END
  RETURN
END
GO


/************** spSincroSSBEnviarPrueba *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBEnviarPrueba') and type = 'P') drop procedure dbo.spSincroSSBEnviarPrueba
GO
CREATE PROCEDURE spSincroSSBEnviarPrueba
			@iDatos			int,
			@Solicitud		uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@FechaEnvio		datetime,
			@SucursalLocal		int,
			@SucursalSincro		int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @SucursalLocal <> @SucursalSincro AND @SucursalLocal = 0 AND @SucursalSincro > 0
  BEGIN
    EXEC spSincroSSBEnviar @SucursalSincro, @EsPrueba = 1, @Solicitud = @Solicitud, @FechaEnvio = @FechaEnvio OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    EXEC spSincroSSBSolicitud @Solicitud, 'Prueba', @SucursalLocal, @SucursalSincro, @FechaEnvio = @FechaEnvio, @Estatus = 'CONCLUIDO'
  END
  RETURN
END
GO

/************** spSincroSSBRecibirPrueba *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBRecibirPrueba') and type = 'P') drop procedure dbo.spSincroSSBRecibirPrueba
GO
CREATE PROCEDURE spSincroSSBRecibirPrueba
			@iDatos			int,
			@Solicitud		uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@FechaEnvio		datetime,
			@SucursalLocal		int,
			@SucursalSincro		int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaRecibo	datetime

  SELECT @FechaRecibo = GETDATE()
  IF @SucursalLocal <> @SucursalSincro
    EXEC spSincroSSBSolicitud @Solicitud, @FechaRecibo = @FechaRecibo, @Estatus = 'CONCLUIDO'
  RETURN
END
GO



/************** spSincroSSBSincroFinal *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBSincroFinal') and type = 'P') drop procedure dbo.spSincroSSBSincroFinal
GO
CREATE PROCEDURE spSincroSSBSincroFinal
			@iDatos			int,
			@Solicitud		uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@FechaEnvio		datetime,
			@SucursalLocal		int,
			@SucursalSincro		int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaRecibo	datetime,
    @EsRespaldo		bit,
    @EsTRCL		bit

  SELECT @FechaRecibo = GETDATE()
  SELECT @EsRespaldo = ISNULL(EsRespaldo, 0), @EsTRCL = ISNULL(EsTRCL, 0)
    FROM OPENXML (@iDatos, '/IntelisisSincroSSB')
    WITH (EsRespaldo bit, EsTRCL bit)

  IF @SucursalLocal <> @SucursalSincro
  BEGIN
    EXEC spSincroFinal
    EXEC spSincroSSBSolicitud @Solicitud, @FechaRecibo = @FechaRecibo, @Estatus = 'CONCLUIDO'

    IF @EsRespaldo = 0 AND @EsTRCL = 0
    BEGIN
      IF @SucursalLocal = 0
        UPDATE Sucursal SET UltimaSincronizacion = @FechaRecibo WHERE Sucursal = @SucursalLocal

      EXEC spSincroSSBEnviar @SucursalSincro, @EsSincroFinal = 1, @Solicitud = @Solicitud, @FechaEnvio = @FechaEnvio OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      EXEC spSincroSSBSolicitud @Solicitud, 'Sincronizacion', @SucursalLocal, @SucursalSincro, @FechaEnvio = @FechaEnvio, @Estatus = 'CONCLUIDO'
    END
  END
  RETURN
END
GO

/************** spSincroSSBIPDinamica *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBIPDinamica') and type = 'P') drop procedure dbo.spSincroSSBIPDinamica
GO
CREATE PROCEDURE spSincroSSBIPDinamica
			@Sucursal		int,
			@IP			varchar(20),
			@IPPuerto		int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TCP	varchar(255), 
    @SQL	nvarchar(max)

  SELECT @IPPuerto = NULLIF(@IPPuerto, 0)
  IF EXISTS(SELECT * FROM Sucursal WHERE Sucursal = @Sucursal AND (IP <> @IP OR IPPuerto <> @IPPuerto) AND IPDinamica = 1)
  BEGIN
    UPDATE Sucursal 
       SET IP = @IP, IPPuerto = @IPPuerto
     WHERE Sucursal = @Sucursal

    SELECT @TCP = 'TCP'+CHAR(58)+'//'+@IP
    IF @IPPuerto IS NOT NULL SELECT @TCP = @TCP + CHAR(58) + CONVERT(varchar, @IPPuerto)
    SELECT @SQL = N'ALTER ROUTE RutaSSB_'+CONVERT(varchar, @Sucursal)+' WITH SERVICE_NAME = ''ServicioSSB_'+CONVERT(varchar, @Sucursal)+''', ADDRESS = '''+@TCP+''''
    EXEC sp_executesql @SQL 
  END
END
GO

/************** spSincroSSBProcesarMensaje *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBProcesarMensaje') and type = 'P') drop procedure dbo.spSincroSSBProcesarMensaje
GO
CREATE PROCEDURE spSincroSSBProcesarMensaje
			@Conversacion		uniqueidentifier,
			@TipoMensaje		nvarchar(256),
			@iDatos			int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT,
			@Debug			bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Solicitud			uniqueidentifier, 
    @FechaEnvio			datetime, 
    @SucursalSincro		int,
    @SucursalSincroIP		varchar(20),
    @SucursalSincroPuerto	int,
    @SucursalLocal		int,
    @MismaInstancia		bit

  SELECT @SucursalLocal = Sucursal, @MismaInstancia = SincroSSBMismaInstancia FROM Version
  SELECT @SucursalSincro = NULL

  SELECT @Solicitud = Solicitud, @FechaEnvio = FechaEnvio, @SucursalSincro = SucursalOrigen, @SucursalSincroIP = NULLIF(RTRIM(SucursalOrigenIP), ''), @SucursalSincroPuerto = SucursalOrigenPuerto
    FROM OPENXML (@iDatos, '/IntelisisSincroSSB')
    WITH (Solicitud uniqueidentifier, FechaEnvio datetime, SucursalOrigen int, SucursalOrigenIP varchar(20), SucursalOrigenPuerto int, SucursalDestino int)
   WHERE SucursalDestino = @SucursalLocal

  IF @SucursalSincro IS NOT NULL
  BEGIN
    IF @MismaInstancia = 0 AND @SucursalSincroIP IS NOT NULL
      EXEC spSincroSSBIPDinamica @SucursalSincro, @SucursalSincroIP, @SucursalSincroPuerto, @Ok OUTPUT, @OkRef OUTPUT

    IF @TipoMensaje = 'SincroSSB/Sincro'		EXEC spSincroSSBRecibirSincro  @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Ok OUTPUT, @OkRef OUTPUT ELSE
    IF @TipoMensaje = 'SincroSSB/SincroFinal'		EXEC spSincroSSBSincroFinal    @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Ok OUTPUT, @OkRef OUTPUT ELSE
    IF @TipoMensaje = 'SincroSSB/SolicitarTRCL'		EXEC spSincroSSBEnviarTRCL     @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Ok OUTPUT, @OkRef OUTPUT ELSE
    IF @TipoMensaje = 'SincroSSB/SolicitarRespaldo'	EXEC spSincroSSBEnviarRespaldo @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Ok OUTPUT, @OkRef OUTPUT ELSE
    IF @TipoMensaje = 'SincroSSB/SolicitarPrueba'	EXEC spSincroSSBEnviarPrueba   @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Ok OUTPUT, @OkRef OUTPUT ELSE
    IF @TipoMensaje = 'SincroSSB/Prueba'		EXEC spSincroSSBRecibirPrueba  @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Ok OUTPUT, @OkRef OUTPUT 
  END ELSE
    SELECT @Ok = 17040, @OkRef = CONVERT(varchar, @SucursalSincro)
  RETURN
END
GO


-- ALTER QUEUE ColaSSB WITH STATUS = ON
/************** spSincroSSBModoAuto *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBModoAuto') and type = 'P') drop procedure dbo.spSincroSSBModoAuto
GO
CREATE PROCEDURE spSincroSSBModoAuto
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conversacion		uniqueidentifier,
    @TipoMensaje		nvarchar(256),
    @Datos			xml,
    @iDatos			int,
    @SQL_ERROR_NUMBER		int,
    @SQL_ERROR_MESSAGE		varchar(255),
    @Ok				int,
    @OkRef			varchar(255),
    @ModoManual			bit

  SELECT @SQL_ERROR_NUMBER = 0, @SQL_ERROR_MESSAGE = NULL
  SELECT @Ok = NULL, @OkRef = NULL

  SELECT @ModoManual = ISNULL(SincroSSBModoManual, 0) FROM Version

  -- si hay algo en la cola manual procesar primero
  IF @ModoManual = 0
    EXEC spSincroSSBModoManual
/*
   hay que mandar un error si el modo auto y tiene algo en la tabla SincroSSBModoManual
*/
  SELECT @Conversacion = NULL
  WHILE (1=1)
  BEGIN
    BEGIN TRANSACTION 
    WAITFOR 
    (
      RECEIVE TOP(1) 
        @Conversacion = conversation_handle, 
        @TipoMensaje = message_type_name, 
        @Datos = message_body 
      FROM ColaSSB
    ), TIMEOUT 300

    IF @@ROWCOUNT = 0
    BEGIN
      ROLLBACK TRANSACTION 
      BREAK
    END
    SELECT @SQL_ERROR_NUMBER = @@ERROR
    IF (@SQL_ERROR_NUMBER <> 0)
    BEGIN         
      SELECT @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
      ROLLBACK TRANSACTION
      END CONVERSATION @Conversacion WITH ERROR = @SQL_ERROR_NUMBER DESCRIPTION = @SQL_ERROR_MESSAGE
      EXEC spSincroSSBOk @Conversacion, @TipoMensaje, @Datos, NULL, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT
      BREAK
    END

    IF @TipoMensaje LIKE 'SincroSSB/%'
    BEGIN        
      BEGIN TRY
        IF @ModoManual = 1
          INSERT SincroSSBModoManual (Conversacion, TipoMensaje, Datos) VALUES (@Conversacion, @TipoMensaje, @Datos)
        ELSE BEGIN
          EXEC sp_xml_preparedocument @iDatos OUTPUT, @Datos
          EXEC spSincroSSBProcesarMensaje @Conversacion, @TipoMensaje, @iDatos, @Ok OUTPUT, @OkRef OUTPUT
          EXEC sp_xml_removedocument @iDatos
        END
      END TRY
      BEGIN CATCH
        SELECT @SQL_ERROR_NUMBER = ERROR_NUMBER(), @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
        ROLLBACK TRANSACTION
        END CONVERSATION @Conversacion WITH ERROR = @SQL_ERROR_NUMBER DESCRIPTION = @SQL_ERROR_MESSAGE
        EXEC spSincroSSBOk @Conversacion, @TipoMensaje, @Datos, NULL, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT
        BREAK
      END CATCH

      IF NULLIF(@SQL_ERROR_NUMBER, 0) IS NULL AND @Ok IS NULL
      BEGIN
        COMMIT TRANSACTION 
        CONTINUE
      END ELSE BEGIN
        SELECT @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
        ROLLBACK TRANSACTION
        END CONVERSATION @Conversacion WITH ERROR = @SQL_ERROR_NUMBER DESCRIPTION = @SQL_ERROR_MESSAGE
        EXEC spSincroSSBOk @Conversacion, @TipoMensaje, @Datos, NULL, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT
        BREAK
      END      
    END ELSE
    IF @TipoMensaje = 'http'+CHAR(58)+'//schemas.microsoft.com/SQL/ServiceBroker/EndDialog'
    BEGIN
      END CONVERSATION @Conversacion 
      COMMIT TRANSACTION 
      CONTINUE
    END
    ROLLBACK TRANSACTION 
  END
  RETURN
END
GO

--spdrop_index 'art', 'gid'
--spdrop_column 'art', 'gid'
-- select top 10 * from art
 --delete art where articulo = '01'
--drop trigger   tgAnexoCtaSincroSSBAnexoCta
--delete SincroSSBModoManual
-- select * from SincroSSBModoManual
/************** spSincroSSBModoManual *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBModoManual') and type = 'P') drop procedure dbo.spSincroSSBModoManual
GO
CREATE PROCEDURE spSincroSSBModoManual
			@Debug		bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conversacion	uniqueidentifier,
    @TipoMensaje	nvarchar(256),
    @Datos		xml,
    @iDatos		int,
    @Ok			int,
    @OkRef		varchar(255)

  IF NOT EXISTS(SELECT * FROM SincroSSBModoManual) RETURN
  DECLARE crSSBRecibirModoManual CURSOR LOCAL FOR
  SELECT Conversacion, TipoMensaje, Datos
    FROM SincroSSBModoManual
   ORDER BY RID
  OPEN crSSBRecibirModoManual
  FETCH NEXT FROM crSSBRecibirModoManual INTO @Conversacion, @TipoMensaje, @Datos
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      BEGIN TRY
        BEGIN TRANSACTION 
        EXEC sp_xml_preparedocument @iDatos OUTPUT, @Datos   
        EXEC spSincroSSBProcesarMensaje @Conversacion, @TipoMensaje, @iDatos, @Ok OUTPUT, @OkRef OUTPUT, @Debug = @Debug
        EXEC sp_xml_removedocument @iDatos

        DELETE SincroSSBModoManual WHERE CURRENT OF crSSBRecibirModoManual
        IF @Debug = 1
        BEGIN
	  ROLLBACK TRANSACTION
          BREAK
        END ELSE
          COMMIT TRANSACTION 
      END TRY
      BEGIN CATCH
        SELECT @Ok = ERROR_NUMBER(), @OkRef = ERROR_MESSAGE()
        ROLLBACK TRANSACTION
        SELECT 'Error' = @Ok, 'Mensaje' = @OkRef
        BREAK
      END CATCH
    END
    FETCH NEXT FROM crSSBRecibirModoManual INTO @Conversacion, @TipoMensaje, @Datos
  END
  CLOSE crSSBRecibirModoManual
  DEALLOCATE crSSBRecibirModoManual
  RETURN
END
GO

-- spSincroSSBActivarTabla 'Unidad'
/************** spSincroSSBActivarTabla *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBActivarTabla') and type = 'P') drop procedure dbo.spSincroSSBActivarTabla
GO
CREATE PROCEDURE spSincroSSBActivarTabla
			@Tabla		varchar(100),
			@Activar	bit = 1
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL	varchar(max),
    @Trigger	varchar(100),
    @SELECT	varchar(max)

  /* Eliminar Sincro Anterior */
  SELECT @SQL = 'spDROP_TRIGGER ''sincro'+@Tabla+''''
  EXEC (@SQL)
  SELECT @SQL = 'spDROP_TRIGGER ''sincroT'+@Tabla+''''
  EXEC (@SQL)
  SELECT @SQL = 'spDROP_TRIGGER ''sincroR'+@Tabla+''''
  EXEC (@SQL)
  --EXEC spDROP_INDEX @Tabla, 'SincroID'
  --EXEC spDROP_COLUMN @Tabla, 'SincroC'
  EXEC spALTER_TABLE @Tabla, 'SincroID', 'timestamp NULL'
  EXEC spADD_INDEX @Tabla, 'Sincro', 'SincroID'

  SELECT @Trigger = 'dbo.tg'+@Tabla+'SincroSSB'
  SELECT @SQL = 'spDROP_TRIGGER '''+@Trigger+'_AC'''
  EXEC (@SQL)
  SELECT @SQL = 'spDROP_TRIGGER '''+@Trigger+'_B'''
  EXEC (@SQL)
  IF @Activar = 1
  BEGIN
    EXEC spTablaEstructura @Tabla,  @SELECT = @SELECT OUTPUT, @PK = 1
    -- si no tiene llave primaria que no haga nada
    IF NULLIF(RTRIM(@SELECT), '') IS NOT NULL
    BEGIN
      SELECT @SQL = 
      'CREATE TRIGGER '+@Trigger+'_AC ON '+@Tabla+'
      --//WITH ENCRYPTION
      FOR INSERT, UPDATE
      AS BEGIN
        SET ANSI_NULLS OFF

      	DECLARE
      	  @SincroIDMax		binary(8),
      	  @SincroIDTabla	binary(8)
        IF (SELECT SincroSSB FROM Version) = 1 
        BEGIN
          SELECT @SincroIDMax = MAX(SincroID) FROM SincroSSBControl
          SELECT @SincroIDTabla = SincroID FROM SysTabla WHERE SysTabla = '''+@Tabla+'''
          IF @SincroIDTabla < @SincroIDMax
            UPDATE SysTabla WITH (ROWLOCK) SET UltimoCambio = GETDATE() WHERE SysTabla = '''+@Tabla+'''
        END
      END'
      EXEC (@SQL)

      SELECT @SQL = 
      'CREATE TRIGGER '+@Trigger+'_B ON '+@Tabla+'
      --//WITH ENCRYPTION
      FOR DELETE
      AS BEGIN
      	DECLARE
      	  @SincroIDMax		binary(8),
      	  @SincroIDTabla	binary(8)
        IF (SELECT SincroSSB FROM Version) = 1 
        BEGIN
          SELECT @SincroIDMax = MAX(SincroID) FROM SincroSSBControl
          SELECT @SincroIDTabla = SincroID FROM SysTabla WHERE SysTabla = '''+@Tabla+'''
          IF @SincroIDTabla < @SincroIDMax
            UPDATE SysTabla WITH (ROWLOCK) SET UltimoCambio = GETDATE() WHERE SysTabla = '''+@Tabla+'''
            
          DECLARE @Llave xml
          SELECT @Llave = (SELECT '+@SELECT+' FROM DELETED FOR XML RAW(''Llave''))
          EXEC spSincroSSBBaja '''+@Tabla+''', @Llave
        END
      END'
      BEGIN TRY
        EXEC (@SQL)
      END TRY
      BEGIN CATCH
        SELECT @SQL = 'Error al Creare el Trigger '+@Trigger+' en la Tabla '+@Tabla
        RAISERROR (@SQL,16,-1)     
      END CATCH
    END
  END
  RETURN
END
GO

/************** spSincroSSB_ActivarCola *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSB_ActivarCola') and type = 'P') drop procedure dbo.spSincroSSB_ActivarCola
GO
CREATE PROCEDURE spSincroSSB_ActivarCola
			@Activar	bit = 1
--//WITH ENCRYPTION
AS BEGIN
  IF @Activar = 1
     ALTER QUEUE ColaSSB WITH STATUS = ON
  ELSE
     ALTER QUEUE ColaSSB WITH STATUS = OFF
  RETURN
END
GO

/************** spSincroSSBActualizar *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBActualizar') and type = 'P') drop procedure dbo.spSincroSSBActualizar
GO
CREATE PROCEDURE spSincroSSBActualizar
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla	varchar(100),
    @Activar	bit

  SELECT @Activar = SincroSSB FROM Version
  IF @Activar = 1
    UPDATE SysTabla WITH (ROWLOCK) SET Tipo = 'N/A' WHERE SysTabla IN ('SincroLog','SincroLogAdvertencia','SincroLogError','SincroMovRegistro','SincroPaquete')

  --UPDATE SysTabla SET UltimoCambio = GETDATE()
  DECLARE crSincroSSBActualizar CURSOR LOCAL FOR 
   SELECT SysTabla
     FROM SysTabla
    WHERE UPPER(NULLIF(RTRIM(Tipo), '')) NOT IN (NULL, 'N/A')
  OPEN crSincroSSBActualizar
  FETCH NEXT FROM crSincroSSBActualizar INTO @Tabla
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND dbo.fnTablaExiste(@Tabla) = 1
    BEGIN
      EXEC spSincroSSBActivarTabla @Tabla, @Activar
    END
    FETCH NEXT FROM crSincroSSBActualizar INTO @Tabla
  END
  CLOSE crSincroSSBActualizar
  DEALLOCATE crSincroSSBActualizar

  RETURN
END
GO

/************** spSincroSSBActualizarSucursal *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSBActualizarSucursal') and type = 'P') drop procedure dbo.spSincroSSBActualizarSucursal
GO
CREATE PROCEDURE spSincroSSBActualizarSucursal
			@SucursalLocal		int,
			@SucursalRemoto		int,
			@RutaCertificados	varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL				varchar(max),
    @CertificadoDialogoRemoto		varchar(255),
    @CertificadoDialogoRemotoArchivo	varchar(255),
    @CertificadoEndPointRemoto		varchar(255),
    @CertificadoEndPointRemotoArchivo	varchar(255),
    @RutaRemoto				varchar(255),
    @UsuarioLocal			varchar(255),
    @UsuarioRemoto			varchar(255),
    @UnionLocal				varchar(255),
    @UnionRemoto			varchar(255),
    @BaseLocal				varchar(255),
    @IPRemoto				varchar(255),
    @TCP				varchar(255),
    @IPDinamica				bit,
    @PuertoRemoto			varchar(255),
    @ServicioLocal			varchar(255),
    @ServicioRemoto			varchar(255),
    @AccesoRemoto			varchar(255)

  SELECT @BaseLocal = DB_NAME()
  SELECT @AccesoRemoto = 'AccesoSSB_'+CONVERT(varchar, @SucursalRemoto)
  SELECT @UsuarioLocal = 'UsuarioSSB_'+CONVERT(varchar, @SucursalLocal), @UsuarioRemoto = 'UsuarioSSB_'+CONVERT(varchar, @SucursalRemoto)
  SELECT @CertificadoDialogoRemoto = 'CertificadoDialogoSSB_'+CONVERT(varchar, @SucursalRemoto)
  SELECT @CertificadoDialogoRemotoArchivo = @RutaCertificados+'\'+@CertificadoDialogoRemoto+'.cer'
  SELECT @CertificadoEndPointRemoto = 'CertificadoEndPointSSB_'+CONVERT(varchar, @SucursalRemoto)
  SELECT @CertificadoEndPointRemotoArchivo = @RutaCertificados + '\' + @CertificadoEndPointRemoto + '.cer'
  SELECT @RutaRemoto = 'RutaSSB_'+CONVERT(varchar, @SucursalRemoto)
  SELECT @ServicioLocal = 'ServicioSSB_'+CONVERT(varchar, @SucursalLocal), @ServicioRemoto = 'ServicioSSB_'+CONVERT(varchar, @SucursalRemoto)
  SELECT @IPRemoto = NULLIF(RTRIM(IP), ''), @PuertoRemoto = CONVERT(varchar, NULLIF(IPPuerto, 0)), @IPDinamica = ISNULL(IPDinamica, 0) FROM Sucursal WHERE Sucursal = @SucursalRemoto
  IF @IPRemoto IS NULL AND @IPDinamica = 1 SELECT @IPRemoto = 'IP_DINAMICA'
  SELECT @TCP = 'TCP'+CHAR(58)+'//'+@IPRemoto
  IF @PuertoRemoto IS NOT NULL SELECT @TCP = @TCP + CHAR(58) + CONVERT(varchar, @PuertoRemoto)
  SELECT @UnionLocal = 'UnionSSB_'+CONVERT(varchar, @SucursalLocal), @UnionRemoto = 'UnionSSB_'+CONVERT(varchar, @SucursalRemoto) 

  IF @IPRemoto IS NULL  
  BEGIN
    SELECT @SQL = 'Falta Especificar la Direccion IP de la Sucursal '+CONVERT(varchar, @SucursalRemoto)
    RAISERROR (@SQL,16,-1) 
  END

  INSERT #Resultado (SQL) SELECT CHAR(45)+CHAR(45)+CHAR(45)+' Activacion de la Sucursal '+CONVERT(varchar, @SucursalLocal)+' a la Sucursal '+CONVERT(varchar, @SucursalRemoto)+CHAR(45)+CHAR(45)+CHAR(45)
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'USE master'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS(SELECT * FROM syslogins WHERE name = '''+@AccesoRemoto+''') CREATE LOGIN '+@AccesoRemoto+' WITH PASSWORD=''INTELISIS'''
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS(SELECT * FROM sysusers WHERE name = '''+@UsuarioRemoto+''') CREATE USER '+@UsuarioRemoto+' FOR LOGIN '+@AccesoRemoto
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'IF EXISTS(SELECT * FROM sys.certificates WHERE name = '''+@CertificadoEndPointRemoto+''') DROP CERTIFICATE '+@CertificadoEndPointRemoto
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'CREATE CERTIFICATE '+@CertificadoEndPointRemoto+' AUTHORIZATION '+@UsuarioRemoto+' FROM FILE = N'''+@CertificadoEndPointRemotoArchivo+''' ACTIVE FOR BEGIN_DIALOG = ON'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'GRANT CONNECT ON ENDPOINT::IntelisisSSB TO ['+@AccesoRemoto+']'
  INSERT #Resultado (SQL) SELECT 'GO'

  INSERT #Resultado (SQL) SELECT 'USE '+@BaseLocal
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS(SELECT * FROM sysusers WHERE name = '''+@UsuarioRemoto+''') CREATE USER '+@UsuarioRemoto+' WITHOUT LOGIN'
  INSERT #Resultado (SQL) SELECT 'GRANT SEND ON SERVICE'+CHAR(58)+CHAR(58)+'['+@ServicioLocal+'] TO '+@UsuarioRemoto
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'IF EXISTS(SELECT * FROM sys.certificates WHERE name = '''+@CertificadoDialogoRemoto+''') DROP CERTIFICATE '+@CertificadoDialogoRemoto
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'CREATE CERTIFICATE '+@CertificadoDialogoRemoto+' AUTHORIZATION '+@UsuarioRemoto+' FROM FILE = N'''+@CertificadoDialogoRemotoArchivo+''''
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'IF EXISTS(SELECT * FROM sys.Routes WHERE name = '''+@RutaRemoto+''') DROP ROUTE '+@RutaRemoto
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'CREATE ROUTE '+@RutaRemoto+' WITH SERVICE_NAME = N'''+@ServicioRemoto+''', ADDRESS = N'''+@TCP+''''
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'IF EXISTS (SELECT * FROM sys.remote_service_bindings WHERE Name = '''+@UnionRemoto+''') DROP REMOTE SERVICE BINDING '+@UnionRemoto
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'CREATE REMOTE SERVICE BINDING '+@UnionRemoto+' TO SERVICE N'''+@ServicioRemoto+''' WITH USER = '+@UsuarioRemoto
  INSERT #Resultado (SQL) SELECT 'GO'
END
GO

-- spSincroSSB_ActualizarCertificados
/************** spSincroSSB_ActualizarCertificados *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSB_ActualizarCertificados') and type = 'P') drop procedure dbo.spSincroSSB_ActualizarCertificados
GO
CREATE PROCEDURE spSincroSSB_ActualizarCertificados
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalLocal			int,
    @SucursalRemota			int,
    @RutaCertificados			varchar(100),
    @ServicioLocal			varchar(255),
    @RutaLocal				varchar(255),
    @MismaInstancia			bit,
    @CertificadoEndPointLocal		varchar(255),
    @CertificadoEndPointLocalArchivo	varchar(255),
    @LlavePrivadaEndPointLocal		varchar(255),
    @LlavePrivadaEndPointLocalArchivo	varchar(255),
    @AccesoLocal			varchar(255)

  SELECT @SucursalLocal = Sucursal, @MismaInstancia = SincroSSBMismaInstancia, @RutaCertificados = RutaCertificados FROM Version
  SELECT @AccesoLocal = 'AccesoSSB_'+CONVERT(varchar, @SucursalLocal)
  SELECT @CertificadoEndPointLocal = 'CertificadoEndPointSSB_'+CONVERT(varchar, @SucursalLocal)
  SELECT @CertificadoEndPointLocalArchivo = @RutaCertificados + '\' + @CertificadoEndPointLocal + '.cer'
  SELECT @LlavePrivadaEndPointLocal = 'LlavePrivadaEndPointSSB_'+CONVERT(varchar, @SucursalLocal)
  SELECT @LlavePrivadaEndPointLocalArchivo = @RutaCertificados + '\' + @LlavePrivadaEndPointLocal + '.pvk'

  CREATE TABLE #Resultado (ID int IDENTITY(1,1) NOT NULL PRIMARY KEY, SQL varchar(255) NULL)
  INSERT #Resultado (SQL) SELECT 'SET DATEFIRST 7'
  INSERT #Resultado (SQL) SELECT 'SET ANSI_NULLS OFF'
  INSERT #Resultado (SQL) SELECT 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED'
  INSERT #Resultado (SQL) SELECT 'SET LOCK_TIMEOUT -1'
  INSERT #Resultado (SQL) SELECT 'SET QUOTED_IDENTIFIER OFF'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'USE master'
  INSERT #Resultado (SQL) SELECT 'IF EXISTS(SELECT * FROM sys.endpoints WHERE name = ''IntelisisSSB'') DROP ENDPOINT IntelisisSSB'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'IF EXISTS(SELECT * FROM sys.certificates WHERE name = '''+@CertificadoEndPointLocal+''') DROP CERTIFICATE '+@CertificadoEndPointLocal
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'CREATE CERTIFICATE '+@CertificadoEndPointLocal+' FROM FILE = N'''+@CertificadoEndPointLocalArchivo+''''
  INSERT #Resultado (SQL) SELECT 'WITH PRIVATE KEY (FILE = N'''+@LlavePrivadaEndPointLocalArchivo+''', DECRYPTION BY PASSWORD = ''INTELISIS'') ACTIVE FOR BEGIN_DIALOG = ON'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'CREATE ENDPOINT IntelisisSSB STATE = STARTED AS TCP ( LISTENER_PORT = 4022 ) FOR SERVICE_BROKER (AUTHENTICATION = CERTIFICATE '+@CertificadoEndPointLocal+')'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS(SELECT * FROM syslogins WHERE name = '''+@AccesoLocal+''') CREATE LOGIN '+@AccesoLocal+' WITH PASSWORD=''INTELISIS'''
  INSERT #Resultado (SQL) SELECT 'GO'

  IF @MismaInstancia = 0
  BEGIN
    IF @SucursalLocal > 0
      EXEC spSincroSSBActualizarSucursal @SucursalLocal, 0, @RutaCertificados
    ELSE BEGIN
      DECLARE crSucursal CURSOR LOCAL FOR 
       SELECT Sucursal
         FROM Sucursal
        WHERE Sucursal > 0 AND EnLinea = 0
        ORDER BY Sucursal
      OPEN crSucursal
      FETCH NEXT FROM crSucursal INTO @SucursalRemota
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          EXEC spSincroSSBActualizarSucursal @SucursalLocal, @SucursalRemota, @RutaCertificados
        END
        FETCH NEXT FROM crSucursal INTO @SucursalRemota
      END
      CLOSE crSucursal
      DEALLOCATE crSucursal
    END
  END
  SELECT @RutaLocal = 'RutaSSB_'+CONVERT(varchar, @SucursalLocal) 
  SELECT @ServicioLocal = 'ServicioSSB_'+CONVERT(varchar, @SucursalLocal)

  INSERT #Resultado (SQL) SELECT 'USE msdb'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'IF EXISTS(SELECT * FROM sys.Routes WHERE name = '''+@RutaLocal+''') DROP ROUTE '+@RutaLocal
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'CREATE ROUTE '+@RutaLocal+' WITH SERVICE_NAME = N'''+@ServicioLocal+''', ADDRESS = N''LOCAL'''
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'USE '+DB_NAME()
  INSERT #Resultado (SQL) SELECT 'GO'

  SELECT SQL FROM #Resultado ORDER BY ID
END
GO

-- select DB_NAME()
-- update version set sincrossb = 0
-- spSincroSSB_Activar 0
-- ALTER QUEUE ColaSSB WITH STATUS = ON
-- ALTER QUEUE ColaSSB WITH ACTIVATION (STATUS=OFF)
-- ALTER QUEUE ColaSSB WITH ACTIVATION (STATUS=ON)
-- ALTER QUEUE ColaSSB WITH STATUS=ON, ACTIVATION (PROCEDURE_NAME = spSincroSSBModoAuto, MAX_QUEUE_READERS = 5, EXECUTE AS 'dbo')
-- update version set sincrossb =0
/************** spSincroSSB_Activar *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSB_Activar') and type = 'P') drop procedure dbo.spSincroSSB_Activar
GO
CREATE PROCEDURE spSincroSSB_Activar
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal			int,
    @SincroSSB			bit,
    @MismaInstancia		bit,
    @SQL			varchar(max),
    @CertificadoDialogo		varchar(255),
    @CertificadoDialogoArchivo	varchar(255),
    @PuertoSSB			int,
    @RutaCertificados		varchar(100),
    @BaseLocal			varchar(100),
    @ServicioLocal		varchar(100),
    @UsuarioLocal		varchar(100)

  CREATE TABLE #Resultado (ID int IDENTITY(1,1) NOT NULL PRIMARY KEY, SQL varchar(255) NULL)
  
/*
Dominio\DominioUsuario = usuario que inicia el servicio de SQL en matriz y sucusales, y debe pertenecer al rol de servidor sysadmin, esto se puede consultar viendo las propiedades del login (inicio de sesion), en funciones del servidor. en el modulo central lo creamos con codigo de SQL
*/
  SELECT @BaseLocal = DB_NAME()
  SELECT @SincroSSB = ISNULL(SincroSSB,0), 
         @MismaInstancia = SincroSSBMismaInstancia,
	 @Sucursal = Sucursal, 
	 @PuertoSSB = PuertoSSB, 
	 @RutaCertificados = RutaCertificados 
    FROM Version
  SELECT @CertificadoDialogo = 'CertificadoDialogoSSB_'+CONVERT(varchar, @Sucursal)
  SELECT @CertificadoDialogoArchivo = @RutaCertificados+'\'+@CertificadoDialogo+'.cer'
  SELECT @ServicioLocal = 'ServicioSSB_'+CONVERT(varchar, @Sucursal)
  SELECT @UsuarioLocal = 'UsuarioSSB_'+CONVERT(varchar, @Sucursal)

  INSERT #Resultado (SQL) SELECT CHAR(45)+CHAR(45)+' PARA EJECUTAR ESTE SCRIPT ES NECESARIO ESTAR EN MODO EXCLUSIVO'
  INSERT #Resultado (SQL) SELECT 'SET DATEFIRST 7'
  INSERT #Resultado (SQL) SELECT 'SET ANSI_NULLS OFF'
  INSERT #Resultado (SQL) SELECT 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED'
  INSERT #Resultado (SQL) SELECT 'SET LOCK_TIMEOUT -1'
  INSERT #Resultado (SQL) SELECT 'SET QUOTED_IDENTIFIER OFF'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'USE master'
  INSERT #Resultado (SQL) SELECT 'ALTER DATABASE '+@BaseLocal+' SET TRUSTWORTHY ON';
  INSERT #Resultado (SQL) SELECT 'ALTER DATABASE '+@BaseLocal+' SET NEW_BROKER';
  INSERT #Resultado (SQL) SELECT 'ALTER DATABASE '+@BaseLocal+' SET ENABLE_BROKER';
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'USE '+@BaseLocal
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS(SELECT * FROM sys.symmetric_keys WHERE name LIKE ''%DatabaseMasterKey%'') CREATE MASTER KEY ENCRYPTION BY PASSWORD = N''INTELISIS/508121212'''
  INSERT #Resultado (SQL) SELECT 'GO'
  IF @MismaInstancia = 0
  BEGIN
    INSERT #Resultado (SQL) SELECT 'USE master'
    INSERT #Resultado (SQL) SELECT 'GO'
    INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS(SELECT * FROM sys.symmetric_keys WHERE name LIKE ''%DatabaseMasterKey%'') CREATE MASTER KEY ENCRYPTION BY PASSWORD = N''INTELISIS/50811212'''
    INSERT #Resultado (SQL) SELECT 'GO'
    INSERT #Resultado (SQL) SELECT 'USE '+@BaseLocal
    INSERT #Resultado (SQL) SELECT 'GO'
    INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS(SELECT * FROM sysusers WHERE name = '''+@UsuarioLocal+''') CREATE USER '+@UsuarioLocal+' WITHOUT LOGIN'
    INSERT #Resultado (SQL) SELECT 'GO'
    INSERT #Resultado (SQL) SELECT 'IF EXISTS(SELECT * FROM sys.certificates WHERE name = '''+@CertificadoDialogo+''') DROP CERTIFICATE '+@CertificadoDialogo
    INSERT #Resultado (SQL) SELECT 'GO'
    INSERT #Resultado (SQL) SELECT 'CREATE CERTIFICATE '+@CertificadoDialogo+' AUTHORIZATION '+@UsuarioLocal+' WITH SUBJECT = N''Certificado Dialogo SSB de la Sucursal '+CONVERT(varchar, @Sucursal)+''', EXPIRY_DATE = N''01/01/2099'''
    INSERT #Resultado (SQL) SELECT 'GO'
    INSERT #Resultado (SQL) SELECT CHAR(45)+CHAR(45)+' EXEC xp_cmdshell ''del '+@CertificadoDialogoArchivo+''''
    INSERT #Resultado (SQL) SELECT 'GO'
    INSERT #Resultado (SQL) SELECT 'BACKUP CERTIFICATE '+@CertificadoDialogo+' TO FILE = N'''+@CertificadoDialogoArchivo+''''
    INSERT #Resultado (SQL) SELECT 'GO'
  END
  INSERT #Resultado (SQL) SELECT 'USE '+@BaseLocal
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS (SELECT * FROM sys.service_message_types WHERE name=''SincroSSB/Sincro'') CREATE MESSAGE TYPE [SincroSSB/Sincro] VALIDATION = NONE'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS (SELECT * FROM sys.service_message_types WHERE name=''SincroSSB/SincroFinal'') CREATE MESSAGE TYPE [SincroSSB/SincroFinal] VALIDATION = NONE'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS (SELECT * FROM sys.service_message_types WHERE name=''SincroSSB/SolicitarRespaldo'') CREATE MESSAGE TYPE [SincroSSB/SolicitarRespaldo] VALIDATION = NONE'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS (SELECT * FROM sys.service_message_types WHERE name=''SincroSSB/SolicitarTRCL'') CREATE MESSAGE TYPE [SincroSSB/SolicitarTRCL] VALIDATION = NONE'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS (SELECT * FROM sys.service_message_types WHERE name=''SincroSSB/SolicitarPrueba'') CREATE MESSAGE TYPE [SincroSSB/SolicitarPrueba] VALIDATION = NONE'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS (SELECT * FROM sys.service_message_types WHERE name=''SincroSSB/Prueba'') CREATE MESSAGE TYPE [SincroSSB/Prueba] VALIDATION = NONE'
  INSERT #Resultado (SQL) SELECT 'IF EXISTS (SELECT * FROM sys.service_contracts WHERE name=''ContratoSSB'') DROP CONTRACT ContratoSSB'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'CREATE CONTRACT ContratoSSB ([SincroSSB/Sincro] SENT BY ANY, [SincroSSB/SincroFinal] SENT BY ANY, [SincroSSB/SolicitarRespaldo] SENT BY ANY, [SincroSSB/SolicitarTRCL] SENT BY ANY, [SincroSSB/SolicitarPrueba] SENT BY ANY, [SincroSSB/Prueba] SENT BY ANY)'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS (SELECT * FROM sys.service_queues WHERE name=''ColaSSB'') CREATE QUEUE ColaSSB WITH STATUS=ON, ACTIVATION (PROCEDURE_NAME = spSincroSSBModoAuto, MAX_QUEUE_READERS = 5, EXECUTE AS ''dbo'')'
  INSERT #Resultado (SQL) SELECT 'IF NOT EXISTS (SELECT * FROM sys.services WHERE name='''+@ServicioLocal+''') CREATE SERVICE '+@ServicioLocal+' AUTHORIZATION '+@UsuarioLocal+' ON QUEUE ColaSSB (ContratoSSB)' 
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'UPDATE Version SET Sincro = 0, SincroSSB = 1'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'EXEC spSincroSSBActualizar'
  INSERT #Resultado (SQL) SELECT 'GO'
  SELECT SQL FROM #Resultado ORDER BY ID
END
GO
-- EXEC spDROP_OBJECT 'SSB_', 'CERTIFICATE'

/************** spDROP_OBJECT *************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_OBJECT') and type = 'P') drop procedure dbo.spDROP_OBJECT
GO
CREATE PROCEDURE spDROP_OBJECT
			@Llave	varchar(20),
			@Type	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @name	varchar(256),
    @SQL	varchar(max)

  IF @Type = 'CERTIFICATE'
    DECLARE crDROP_OBJECT CURSOR LOCAL FOR 
     SELECT name
       FROM sys.certificates 
      WHERE name like '%'+@Llave+'%'
  ELSE IF @Type = 'USER'
    DECLARE crDROP_OBJECT CURSOR LOCAL FOR 
     SELECT name
       FROM sysusers
      WHERE name like '%'+@Llave+'%'
  ELSE IF @Type = 'ENDPOINT'
    DECLARE crDROP_OBJECT CURSOR LOCAL FOR 
     SELECT name
       FROM sys.endpoints
      WHERE name like '%'+@Llave+'%'
  ELSE IF @Type = 'ROUTE'
    DECLARE crDROP_OBJECT CURSOR LOCAL FOR 
     SELECT name
       FROM sys.routes
      WHERE name like '%'+@Llave+'%'
  ELSE IF @Type = 'REMOTE SERVICE BINDING'
    DECLARE crDROP_OBJECT CURSOR LOCAL FOR 
     SELECT name
       FROM sys.remote_service_bindings
      WHERE name like '%'+@Llave+'%'
  ELSE IF @Type = 'SERVICE'
    DECLARE crDROP_OBJECT CURSOR LOCAL FOR 
     SELECT name
       FROM sys.services
      WHERE name like '%'+@Llave+'%'

  OPEN crDROP_OBJECT
  FETCH NEXT FROM crDROP_OBJECT INTO @name
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @SQL = 'DROP '+@Type+' '+@name
      EXEC (@SQL)
    END
    FETCH NEXT FROM crDROP_OBJECT INTO @name
  END
  CLOSE crDROP_OBJECT
  DEALLOCATE crDROP_OBJECT
END
GO

/************** spSincroSSB_DROP_OBJECTS *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSB_DROP_OBJECTS') and type = 'P') drop procedure dbo.spSincroSSB_DROP_OBJECTS
GO
CREATE PROCEDURE spSincroSSB_DROP_OBJECTS
--//WITH ENCRYPTION
AS BEGIN
  EXEC spDROP_OBJECT 'SSB_', 'REMOTE SERVICE BINDING'
  EXEC spDROP_OBJECT 'SSB_', 'ROUTE'
  EXEC spDROP_OBJECT 'SSB_', 'CERTIFICATE'
  EXEC spDROP_OBJECT 'SSB_', 'ENDPOINT'
  EXEC spDROP_OBJECT 'SSB_', 'SERVICE'
  EXEC spDROP_OBJECT 'SSB_', 'USER'
END
GO

/************** spSincroSSB_DesActivar *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSB_DesActivar') and type = 'P') drop procedure dbo.spSincroSSB_DesActivar
GO
CREATE PROCEDURE spSincroSSB_DesActivar
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @BaseLocal			varchar(100)

  CREATE TABLE #Resultado (ID int IDENTITY(1,1) NOT NULL PRIMARY KEY, SQL varchar(255) NULL)
  
/*
Dominio\DominioUsuario = usuario que inicia el servicio de SQL en matriz y sucusales, y debe pertenecer al rol de servidor sysadmin, esto se puede consultar viendo las propiedades del login (inicio de sesion), en funciones del servidor. en el modulo central lo creamos con codigo de SQL
*/
  SELECT @BaseLocal = DB_NAME()
  INSERT #Resultado (SQL) SELECT CHAR(45)+CHAR(45)+' PARA EJECUTAR ESTE SCRIPT ES NECESARIO ESTAR EN MODO EXCLUSIVO'
  INSERT #Resultado (SQL) SELECT 'SET DATEFIRST 7'
  INSERT #Resultado (SQL) SELECT 'SET ANSI_NULLS OFF'
  INSERT #Resultado (SQL) SELECT 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED'
  INSERT #Resultado (SQL) SELECT 'SET LOCK_TIMEOUT -1'
  INSERT #Resultado (SQL) SELECT 'SET QUOTED_IDENTIFIER OFF'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'USE master'
  INSERT #Resultado (SQL) SELECT 'EXEC spSincroSSB_DROP_OBJECTS'
  INSERT #Resultado (SQL) SELECT 'USE msdb'
  INSERT #Resultado (SQL) SELECT 'EXEC spSincroSSB_DROP_OBJECTS'
  INSERT #Resultado (SQL) SELECT 'USE '+@BaseLocal
  INSERT #Resultado (SQL) SELECT 'EXEC spSincroSSB_DROP_OBJECTS'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'UPDATE Version SET SincroSSB = 0'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'EXEC spSincroSSBActualizar'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'DROP MASTER KEY'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'USE master'
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'ALTER DATABASE '+@BaseLocal+' SET DISABLE_BROKER';
  INSERT #Resultado (SQL) SELECT 'ALTER DATABASE '+@BaseLocal+' SET TRUSTWORTHY OFF';
  INSERT #Resultado (SQL) SELECT 'GO'
  INSERT #Resultado (SQL) SELECT 'USE '+@BaseLocal
  INSERT #Resultado (SQL) SELECT 'GO'
  SELECT SQL FROM #Resultado ORDER BY ID
END
GO

/*
select * from sys.service_queues 
select * from sys.dm_broker_queue_monitors
select * from sys.dm_broker_activated_tasks
select * from sys.transmission_queue
select * from sys.conversation_endpoints
*/


/************** spSincroSSB_SolicitarRespaldo *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSB_SolicitarRespaldo') and type = 'P') drop procedure dbo.spSincroSSB_SolicitarRespaldo
GO
CREATE PROCEDURE spSincroSSB_SolicitarRespaldo
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalOrigen		int,
    @SucursalOrigenIP		varchar(20),
    @SucursalOrigenPuerto	int,
    @SucursalDestino		int,
    @Solicitud			uniqueidentifier,
    @FechaEnvio			datetime,
    @SQL			nvarchar(max),
    @Datos			xml,
    @SQL_ERROR_NUMBER		int,
    @SQL_ERROR_MESSAGE		varchar(255),
    @Ok				int,
    @OkRef			varchar(255)

  SELECT @SQL_ERROR_NUMBER = 0, @SQL_ERROR_MESSAGE = NULL
  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @SucursalOrigen = Sucursal FROM Version
  EXEC spSucursalIP @SucursalOrigen, @SucursalOrigenIP OUTPUT, @SucursalOrigenPuerto OUTPUT
  SELECT @SucursalDestino = 0, @FechaEnvio = GETDATE()

  IF EXISTS (SELECT * FROM SincroSSBSolicitud WHERE Tipo = 'Respaldo' AND SucursalOrigen = @SucursalOrigen AND SucursalDestino = @SucursalDestino AND Estatus IN ('PENDIENTE', 'RECIBIENDO'))
   SELECT @Ok = 17010

  IF @SucursalOrigen > 0 AND @Ok IS NULL
  BEGIN
    BEGIN TRY
      BEGIN TRANSACTION 
      EXEC spSincroSSBIniciarConversacion @SucursalOrigen, @SucursalDestino, @Solicitud OUTPUT
      SELECT @Datos = '<IntelisisSincroSSB'+
			dbo.fnXML('Tipo', 'SolicitarRespaldo')+
			dbo.fnXMLGID('Solicitud', @Solicitud)+
			dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
			dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
			dbo.fnXML('SucursalOrigenIP', @SucursalOrigenIP)+
			dbo.fnXMLInt('SucursalOrigenPuerto', @SucursalOrigenPuerto)+
			dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
                      '/>'

      SELECT @SQL = N'SEND ON CONVERSATION @Solicitud MESSAGE TYPE [SincroSSB/SolicitarRespaldo] (@Datos)'
      EXEC sp_executesql @SQL, N'@Solicitud uniqueidentifier, @Datos xml', @Solicitud, @Datos
      END CONVERSATION @Solicitud
      EXEC spSincroSSBSolicitud @Solicitud, 'Respaldo', @SucursalOrigen, @SucursalDestino, @FechaEnvio = @FechaEnvio, @Estatus = 'PENDIENTE'
      COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
      SELECT @SQL_ERROR_NUMBER = ERROR_NUMBER(), @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
      ROLLBACK TRANSACTION 
      END CONVERSATION @Solicitud WITH ERROR = @SQL_ERROR_NUMBER DESCRIPTION = @SQL_ERROR_MESSAGE
    END CATCH
  END
  EXEC spSincroSSBOk @Solicitud, 'SincroSSB/SolicitarRespaldo', @Datos, NULL, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    SELECT 'Solicitud Enviada con Exito'
  ELSE
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  RETURN
END
GO

/************** spSincroSSB_SolicitarTRCL *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSB_SolicitarTRCL') and type = 'P') drop procedure dbo.spSincroSSB_SolicitarTRCL
GO
CREATE PROCEDURE spSincroSSB_SolicitarTRCL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalOrigen		int,
    @SucursalOrigenIP		varchar(20),
    @SucursalOrigenPuerto	int,
    @SucursalDestino		int,
    @Solicitud			uniqueidentifier,
    @FechaEnvio			datetime,
    @SQL			nvarchar(max),
    @Datos			xml,
    @SQL_ERROR_NUMBER		int,
    @SQL_ERROR_MESSAGE		varchar(255),
    @Ok				int,
    @OkRef			varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL, @SQL_ERROR_NUMBER = 0, @SQL_ERROR_MESSAGE = NULL
  SELECT @SucursalOrigen = Sucursal FROM Version
  EXEC spSucursalIP @SucursalOrigen, @SucursalOrigenIP OUTPUT, @SucursalOrigenPuerto OUTPUT
  SELECT @SucursalDestino = 0, @FechaEnvio = GETDATE()

  IF EXISTS (SELECT * FROM SincroSSBSolicitud WHERE Tipo = 'TRCL' AND SucursalOrigen = @SucursalOrigen AND SucursalDestino = @SucursalDestino AND Estatus = 'PENDIENTE')
   SELECT @Ok = 17020

  IF @SucursalOrigen > 0 AND @Ok IS NULL
  BEGIN
    BEGIN TRY
      BEGIN TRANSACTION 
      EXEC spSincroSSBIniciarConversacion @SucursalOrigen, @SucursalDestino, @Solicitud OUTPUT
      SELECT @Datos = '<IntelisisSincroSSB'+
			dbo.fnXML('Tipo', 'SolicitarTRCL')+
			dbo.fnXMLGID('Solicitud', @Solicitud)+
			dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
			dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
			dbo.fnXML('SucursalOrigenIP', @SucursalOrigenIP)+
			dbo.fnXMLInt('SucursalOrigenPuerto', @SucursalOrigenPuerto)+
			dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
                      '/>'

      SELECT @SQL = N'SEND ON CONVERSATION @Solicitud MESSAGE TYPE [SincroSSB/SolicitarTRCL] (@Datos)'
      EXEC sp_executesql @SQL, N'@Solicitud uniqueidentifier, @Datos xml', @Solicitud, @Datos
      END CONVERSATION @Solicitud
      EXEC spSincroSSBSolicitud @Solicitud, 'TRCL', @SucursalOrigen, @SucursalDestino, @FechaEnvio = @FechaEnvio, @Estatus = 'PENDIENTE'
      COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
      SELECT @SQL_ERROR_NUMBER = ERROR_NUMBER(), @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
      ROLLBACK TRANSACTION 
      END CONVERSATION @Solicitud WITH ERROR = @SQL_ERROR_NUMBER DESCRIPTION = @SQL_ERROR_MESSAGE
    END CATCH
  END
  EXEC spSincroSSBOk @Solicitud, 'SincroSSB/SolicitarTRCL', @Datos, NULL, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    SELECT 'Solicitud Enviada con Exito'
  ELSE
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  RETURN
END
GO

/************** spSincroSSB_Sincronizar *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSB_Sincronizar') and type = 'P') drop procedure dbo.spSincroSSB_Sincronizar
GO
CREATE PROCEDURE spSincroSSB_Sincronizar
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalOrigen	int,
    @Solicitud		uniqueidentifier,
    @FechaEnvio		datetime,
    @Ok			int,
    @OkRef		varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @Solicitud = NEWID(), @FechaEnvio = GETDATE()
  SELECT @SucursalOrigen = Sucursal FROM Version
  IF @SucursalOrigen > 0 
  BEGIN
    BEGIN TRANSACTION 

    UPDATE Sucursal SET UltimaSincronizacion = @FechaEnvio WHERE Sucursal = @SucursalOrigen
    EXEC spSincroSSBEnviar @Solicitud = @Solicitud, @FechaEnvio = @FechaEnvio OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @Ok IS NULL
      COMMIT TRANSACTION 
    ELSE
      ROLLBACK TRANSACTION 
  END
  EXEC spSincroSSBOk @Solicitud, 'SincroSSB/Sincro', NULL, NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO


/************** spSincroSSB_SolicitarPrueba *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSB_SolicitarPrueba') and type = 'P') drop procedure dbo.spSincroSSB_SolicitarPrueba
GO
CREATE PROCEDURE spSincroSSB_SolicitarPrueba
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalOrigen		int,
    @SucursalOrigenIP		varchar(20),
    @SucursalOrigenPuerto	int,
    @SucursalDestino		int,
    @Solicitud			uniqueidentifier,
    @FechaEnvio			datetime,
    @SQL			nvarchar(max),
    @Datos			xml,
    @SQL_ERROR_NUMBER		int,
    @SQL_ERROR_MESSAGE		varchar(255),
    @Ok				int,
    @OkRef			varchar(255)

  SELECT @SQL_ERROR_NUMBER = 0, @SQL_ERROR_MESSAGE = NULL
  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @SucursalOrigen = Sucursal FROM Version
  EXEC spSucursalIP @SucursalOrigen, @SucursalOrigenIP OUTPUT, @SucursalOrigenPuerto OUTPUT
  SELECT @SucursalDestino = 0, @FechaEnvio = GETDATE()

  IF @SucursalOrigen > 0 AND @Ok IS NULL
  BEGIN
    BEGIN TRY
      BEGIN TRANSACTION 
      EXEC spSincroSSBIniciarConversacion @SucursalOrigen, @SucursalDestino, @Solicitud OUTPUT
      SELECT @Datos = '<IntelisisSincroSSB'+
			dbo.fnXML('Tipo', 'SolicitarPrueba')+
			dbo.fnXMLGID('Solicitud', @Solicitud)+
			dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
			dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
			dbo.fnXML('SucursalOrigenIP', @SucursalOrigenIP)+
			dbo.fnXMLInt('SucursalOrigenPuerto', @SucursalOrigenPuerto)+
			dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
                      '/>'
      SELECT @SQL = N'SEND ON CONVERSATION @Solicitud MESSAGE TYPE [SincroSSB/SolicitarPrueba] (@Datos)'
      EXEC sp_executesql @SQL, N'@Solicitud uniqueidentifier, @Datos xml', @Solicitud, @Datos
      END CONVERSATION @Solicitud
      EXEC spSincroSSBSolicitud @Solicitud, 'Prueba', @SucursalOrigen, @SucursalDestino, @FechaEnvio, @Estatus = 'PENDIENTE'
      COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
      SELECT @SQL_ERROR_NUMBER = ERROR_NUMBER(), @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
      ROLLBACK TRANSACTION 
      END CONVERSATION @Solicitud WITH ERROR = @SQL_ERROR_NUMBER DESCRIPTION = @SQL_ERROR_MESSAGE
    END CATCH
  END
  EXEC spSincroSSBOk @Solicitud, 'Prueba', @Datos, NULL, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    SELECT 'Solicitud Enviada con Exito'
  ELSE
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  RETURN
END
GO
-- select * from sincrossbsolicitud
-- delete sincrossbsolicitud
-- select * from sincrossblog
-- delete sincrossbsolicitud
-- update version set sincrossbmodomanual = 0
-- select * from sincrossbmodomanual 
-- delete sincrossblog
-- update sucursal set ip = 'cmendozaz' where sucursal = 108

/************** spSincroSSB_EliminarConversaciones *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSSB_EliminarConversaciones') and type = 'P') drop procedure dbo.spSincroSSB_EliminarConversaciones
GO
CREATE PROCEDURE spSincroSSB_EliminarConversaciones
--//WITH ENCRYPTION
AS BEGIN
  -- este sp no debe usar salvo en ambientes de pruebas
  DECLARE 
     @SQL     varchar(max),
     @Dialogo uniqueidentifier

  DECLARE crConversacion CURSOR LOCAL FORWARD_ONLY FOR
   SELECT conversation_handle
     FROM sys.conversation_endpoints 
  OPEN crConversacion
  FETCH NEXT FROM crConversacion INTO @Dialogo
  WHILE @@FETCH_STATUS=0
  BEGIN
    SELECT @SQL = 'END CONVERSATION '+char(39)+CONVERT(varchar(255), @Dialogo) + char(39) + ' WITH CLEANUP;'
    EXEC (@SQL)
    PRINT @SQL
    FETCH NEXT FROM crConversacion INTO @Dialogo
  END
  CLOSE crConversacion
  DEALLOCATE crConversacion
END
go

