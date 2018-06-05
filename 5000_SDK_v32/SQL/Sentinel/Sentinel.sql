SET ANSI_DEFAULTS OFF
GO
/* Instalacion Sentinel */

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ANSI_NULLS OFF
GO
USE master
GO
-- select * from IntelisisMK
/****** IntelisisMK ******/
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisMK') and sysstat & 0xf = 3) 
CREATE TABLE dbo.IntelisisMK (
	key_guid		uniqueidentifier	NOT NULL,
	ts			timestamp		NOT NULL,
	dt			datetime		NULL	DEFAULT GETDATE(),
	
	Licencia		varchar(50)		NULL,
	LicenciaXML		text			NULL,
	
	IntelisisSL_WSDL	varchar(255)		NULL,
	
	ETTimeOut		int			NULL	DEFAULT 15,

	CONSTRAINT pk_IntelisisMK PRIMARY KEY CLUSTERED (key_guid)
)
GO
IF NOT EXISTS(SELECT * FROM sysobjects t, syscolumns c WHERE t.id = c.id AND t.type = 'U' and t.name='IntelisisMK' and c.name='dt')
  ALTER TABLE IntelisisMK ADD dt datetime NULL DEFAULT GETDATE() WITH VALUES
GO
IF NOT EXISTS(SELECT * FROM sysobjects t, syscolumns c WHERE t.id = c.id AND t.type = 'U' and t.name='IntelisisMK' and c.name='LicenciaXML')
  ALTER TABLE IntelisisMK ADD LicenciaXML text NULL
GO
IF NOT EXISTS(SELECT * FROM sysobjects t, syscolumns c WHERE t.id = c.id AND t.type = 'U' and t.name='IntelisisMK' and c.name='ETTimeOut')
  ALTER TABLE IntelisisMK ADD ETTimeOut int NULL DEFAULT 15 WITH VALUES
GO
IF NOT EXISTS(SELECT * FROM sysobjects t, syscolumns c WHERE t.id = c.id AND t.type = 'U' and t.name='IntelisisMK' and c.name='EliminarUsuarioDuplicado')
  ALTER TABLE IntelisisMK ADD EliminarUsuarioDuplicado bit NOT NULL DEFAULT 0 WITH VALUES
GO
IF NOT EXISTS(SELECT * FROM sysobjects t, syscolumns c WHERE t.id = c.id AND t.type = 'U' and t.name='IntelisisMK' and c.name='EliminarSesiones')
  ALTER TABLE IntelisisMK ADD EliminarSesiones bit NOT NULL DEFAULT 0 WITH VALUES
IF NOT EXISTS(SELECT * FROM sysobjects t, syscolumns c WHERE t.id = c.id AND t.type = 'U' and t.name='IntelisisMK' and c.name='EliminarSesionesDias')
  ALTER TABLE IntelisisMK ADD EliminarSesionesDias int NOT NULL DEFAULT 2
GO
IF NOT EXISTS(SELECT * FROM sysobjects t, syscolumns c WHERE t.id = c.id AND t.type = 'U' and t.name='IntelisisMK' and c.name='ActualizarSesion')
  ALTER TABLE IntelisisMK ADD ActualizarSesion bit NOT NULL DEFAULT 1 WITH VALUES
GO


IF NOT EXISTS(SELECT * FROM IntelisisMK)
BEGIN
  IF (SELECT SUBSTRING(@@VERSION, 1, 26)) = 'Microsoft SQL Server  2000'
    EXEC("INSERT IntelisisMK (key_guid) SELECT NEWID()")
  ELSE 
  BEGIN
    EXEC ("IF NOT EXISTS(SELECT * FROM sys.symmetric_keys WHERE name LIKE '%DatabaseMasterKey%') CREATE MASTER KEY ENCRYPTION BY PASSWORD = N'INTELISIS/50811212'")
    EXEC("INSERT IntelisisMK (key_guid) SELECT key_guid FROM sys.symmetric_keys WHERE name LIKE '%DatabaseMasterKey%'")
  END
END
GO

/****** IntelisisMKLic ******/
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisMKLic') and sysstat & 0xf = 3) 
CREATE TABLE dbo.IntelisisMKLic (
	Licenciamiento		varchar(50)		NOT NULL,

	LicenciamientoXML	text			NULL,

	CONSTRAINT pk_IntelisisMKLic PRIMARY KEY CLUSTERED (Licenciamiento)
)
GO

/****** Sentinel ******/
if not exists (select * from sysobjects where id = object_id('dbo.Sentinel') and sysstat & 0xf = 3) 
CREATE TABLE dbo.Sentinel (
	Usuario		char(10)	NOT NULL,
	Entrada		varchar(255)	NOT NULL,
	Salida		varchar(255)	NULL,

	CONSTRAINT priSentinel PRIMARY KEY CLUSTERED (Usuario, Entrada)
)
GO


/****** SentinelEntrada ******/
/*if not exists (select * from sysobjects where id = object_id('dbo.SentinelEntrada') and sysstat & 0xf = 3) 
CREATE TABLE dbo.SentinelEntrada (
	ID		int		NOT NULL	IDENTITY(1,1),

	Estacion	int		NULL,
	Usuario		char(10)	NULL,
	Entrada		varchar(255)	NULL,

	CONSTRAINT priSentinelEntrada PRIMARY KEY CLUSTERED (ID)
)*/
GO

/****** SentinelSalida ******/
/*if not exists (select * from sysobjects where id = object_id('dbo.SentinelSalida') and sysstat & 0xf = 3) 
CREATE TABLE dbo.SentinelSalida (
	ID		int		NOT NULL,

	Estacion	int		NULL,
	Salida		varchar(255)	NULL,

	CONSTRAINT priSentinelSalida PRIMARY KEY CLUSTERED (ID)
)*/
GO

/****** SentinelLock ******/
if not exists (select * from sysobjects where id = object_id('dbo.SentinelLock') and sysstat & 0xf = 3) 
BEGIN
  EXEC("CREATE TABLE dbo.SentinelLock (Usuario char(10)	NOT NULL PRIMARY KEY)")
  EXEC("INSERT SentinelLock (Usuario) VALUES ('DEMO')")
END
GO



/****** SentinelMonitor ******/
if not exists (select * from sysobjects where id = object_id('dbo.SentinelMonitor') and sysstat & 0xf = 3) 
CREATE TABLE dbo.SentinelMonitor (
	Usuario		char(10)	NOT NULL,
	ID		int		NOT NULL,

	EstacionTrabajo	int		NULL,
	FechaHora	varchar(20)	NULL,

	CONSTRAINT priSentinelMonitor PRIMARY KEY CLUSTERED (Usuario, ID)
)
GO

if not exists (select * from sysobjects where id = object_id('dbo.xp_SuperPro') and sysstat & 0xf = 4) 
  EXEC sp_addextendedproc xp_SuperPro, 'Sentinel.DLL'
GO

/*if not exists (select * from sysobjects where id = object_id('dbo.xp_md5') and sysstat & 0xf = 4) 
  EXEC sp_addextendedproc xp_md5, 'xp_md5.dll'
*/

if exists (select * from sysobjects where id = object_id('dbo.xp_md5') and sysstat & 0xf = 4) 
  EXEC sp_dropextendedproc xp_md5
GO

/*************** sp_Sentinel *******************/
if exists (select * from sysobjects where id = object_id('dbo.sp_Sentinel') and sysstat & 0xf = 4) drop procedure dbo.sp_Sentinel
GO             
--exec(decrypt(0x4CAFD1771AB283A69C1A88839C439A5182D4765C9BDD2E6316B9DFBDAF51326A4753693C4ED7DEE78F405B79B73A1D5E94E4DDF2509ADDA929B8808F4CEB9CFD762937806C0E634246228D003EEAF83EB3E17654E0EE2D006BA20E19F5171C0C80EB841118FA4D158B4809C15F50E093272AD0B6900816ACAC7AFA620EDBBA29A5D9797DA99E526FD2055C8E4F17539CED0233BF093A55A56875708DE50E36CF9A2138041F423DC83D39BB4E8DEA1E470E14CECB7E3850587AC2C8191D27DC94483463A6B026AF07A251B722D6B2D4351C8928954BB6FF9E3E49CABB5D9E2F1505802EF5AE0AE1C184E0C78E73BF74CFF90CC478B83C54CFDCCF6061627C4A94E0B7CAB0D077CC7935453150E4E8B352049B2FDB3D8689C77A69FC72FAEEC63CDEC1C86A2796FE4BA022E44C6678E5EE40E62065959C921173D25F1632151EFC496C14799B3C049AAD3E0384A85D644CDEB83EF630F6E6A7F6EFA8C00404203D80D8C1052D91A201D45B312957DC5D5115F8B5DC96AB9C364002DF9ABFF5BC7BDE15E886C65E90D67D09ABA67AEAFCCEE56C2C6FA369A783A899C27AD94606ACDFBB972507B1BA477F06054E89343FF067EA90E66409D44AE5CBBAE809822177422ADD2989FC8559520A9311A841ED98AC490FBD8E84997600DDF712220C9F1ACE9359EBF7660F6EAEC7074243AB9F791F3C5AA0B39E4580C24DEDE6E124F99594F041FF72FE0A63FEE8EC74002B72F2A7D3B2D57376DC96AAB1BD18C2528E7D9D7A64A9435CDD9D8BC732F53F6A99B2226C5415FDD9959702AE5ABE9C1DC4B91D10068DF6B2C833B2300DC6EA3A65F0542E578C0C3AE759471A495FAF8B77AB97C55F9F1B8540612A70C6F8DA4271FE427401D21C467D01990559C5608D3A647D6B83821E402CA48AFF84EC3F13BAEAC18F8FED8F61C5A2CB6948F52FC1EBC39CDE87D17F4F7B96F8FFE576DC4655C51F4A12273A08C7DB99C8CE78FAACBFCB656D731D914186307564B3CF6FBBDAB8E9EFA12B6FF1D057F7C2464C6A847E9D49AC15DE9EF26C732C472DFB77B08F8E6DD1FC22D5A8CDE9BC79ADFB50004DCFEC6842B14A6C55F8EFBC9FB96AAE8B697F9198D5F60C1A89F544A83590DA6E1595B4E7D47501B7AB968BEE30D5E0ED39234DABCB2972E54A0AF7FE64A696C8DF8BF157CB848FCD0033B40F54B8E569E2A6D08813F77AD3F2BFE495D5D3B07D1C60E0AD1F8477EE9B6DF9A51D36207B73964BD851F1FD149D86B7107D0C0E2A93553AF2CE054996E5DAC43F6AD84915D337C2B5DAE3D5BC744116FEFCA45FB59E42B515980F5A22374FE96C9B5A11C042D3164A51D2260B05C6FAAB39B0FA69A2E0774EA835C8B2D8F2E5F53282EE))
CREATE PROCEDURE sp_Sentinel 
			@Usuario varchar(20),
			@Entrada varchar(255)
--//WITH ENCRYPTION
AS 
BEGIN
  EXEC xp_SuperPro @Usuario, @Entrada OUTPUT
  SELECT "Salida" = @Entrada
END
GO
GRANT EXECUTE ON sp_Sentinel TO public
GO
-- select substring(@@version, 1, 25)
-- Agregar Usuario Intelisis
if not substring(@@version, 1, 25) in ('Microsoft SQL Server 2005', 'Microsoft SQL Server 2008', 'Microsoft SQL Server 2012', 'Microsoft SQL Server 2014', 'Microsoft SQL Server 2016')
BEGIN
  if not exists(select * from syslogins where name = 'intelisis')
    EXEC sp_addlogin 'intelisis'
END
GO

/*Restaurar base de Datos */
IF exists (SELECT * FROM dbo.sysobjects where id = object_id('[dbo].[spRestaurarBD]'))
DROP PROCEDURE [dbo].[spRestaurarBD]
GO
CREATE PROCEDURE spRestaurarBD
	@Basedatos	VARCHAR(30),
	@NombreArchivo	VARCHAR(200)


--//WITH ENCRYPTION
AS

RESTORE DATABASE @Basedatos
   FROM DISK = @NombreArchivo

SELECT  @@ERROR 
GO


/*************** sp_SentinelEliminarUsuariosDuplicados *******************/
if exists (select * from sysobjects where id = object_id('dbo.sp_SentinelEliminarUsuariosDuplicados') and type = 'P') drop procedure dbo.sp_SentinelEliminarUsuariosDuplicados
GO
CREATE PROCEDURE sp_SentinelEliminarUsuariosDuplicados
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Usuario	varchar(20),
    @Boleto	int,
    @EliminarSt	varchar(50)

  CREATE TABLE #Monitor (
       Boleto 		int 		NULL, 
       Usuario 		varchar(20) 	COLLATE Database_Default NULL, 
       EstacionTrabajo 	int 		NULL, 
       FechaHora 	varchar(50) 	COLLATE Database_Default NULL)

  INSERT #Monitor (Boleto, Usuario, EstacionTrabajo, FechaHora) Exec master.dbo.xp_superpro 'MONITOR'
  
  DECLARE crSentinelMonitor CURSOR LOCAL FOR 
   SELECT Usuario
     FROM #Monitor
    GROUP BY Usuario 
   HAVING COUNT(*) > 1
  OPEN crSentinelMonitor
  FETCH NEXT FROM crSentinelMonitor INTO @Usuario
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      DECLARE crSentinelBoleto CURSOR LOCAL FOR 
       SELECT Boleto
         FROM #Monitor
        WHERE Usuario = @Usuario
        ORDER BY FechaHora
      OPEN crSentinelBoleto
      FETCH NEXT FROM crSentinelBoleto INTO @Boleto
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @EliminarSt = 'Eliminar'+CHAR(9)+CONVERT(varchar, @Boleto)
          EXEC master.dbo.xp_superpro @EliminarSt
        END
        FETCH NEXT FROM crSentinelBoleto INTO @Boleto
      END
      CLOSE crSentinelBoleto
      DEALLOCATE crSentinelBoleto
    END
    FETCH NEXT FROM crSentinelMonitor INTO @Usuario
  END
  CLOSE crSentinelMonitor
  DEALLOCATE crSentinelMonitor

  RETURN
END
GO

-- drop table IntelisisET
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisET') and sysstat & 0xf = 3) 
CREATE TABLE dbo.IntelisisET (
	Estacion		int			NOT NULL,		
	EstacionFirma		varchar(32)		NOT NULL,
	
	UltimaActualizacion	datetime		NOT NULL,

	Empresa			varchar(5)		NULL,
	Sucursal		int			NULL,
	Usuario			varchar(10)		NULL,

	CONSTRAINT pk_IntelisisET PRIMARY KEY CLUSTERED (Estacion, EstacionFirma)
)
GO
IF NOT EXISTS(SELECT * FROM sysobjects t, syscolumns c WHERE t.id = c.id AND t.type = 'U' and t.name='IntelisisET' and c.name='Empresa')
  ALTER TABLE IntelisisET ADD Empresa varchar(5) NULL
IF NOT EXISTS(SELECT * FROM sysobjects t, syscolumns c WHERE t.id = c.id AND t.type = 'U' and t.name='IntelisisET' and c.name='Sucursal')
  ALTER TABLE IntelisisET ADD Sucursal int NULL
IF NOT EXISTS(SELECT * FROM sysobjects t, syscolumns c WHERE t.id = c.id AND t.type = 'U' and t.name='IntelisisET' and c.name='Usuario')
  ALTER TABLE IntelisisET ADD Usuario varchar(10) NULL
IF NOT EXISTS(SELECT * FROM sysobjects t, syscolumns c WHERE t.id = c.id AND t.type = 'U' and t.name='IntelisisET' and c.name='Licenciamiento')
  ALTER TABLE IntelisisET ADD Licenciamiento varchar(50) NULL
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'IntelisisET' AND sysindexes.name = 'EstacionFirma' AND sysobjects.id = sysindexes.id)
  CREATE INDEX EstacionFirma ON dbo.IntelisisET (EstacionFirma)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'IntelisisET' AND sysindexes.name = 'UltimaActualizacion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX UltimaActualizacion ON dbo.IntelisisET (UltimaActualizacion, Estacion)
GO

--drop procedure sp_IntelisisET
SET ANSI_NULLS OFF
GO
/*************** sp_IntelisisET *******************/
DECLARE
    @SQL		varchar(max),
    @Accion varchar(20)

  SELECT @SQL = NULL, @Accion = NULL
  if exists (select * from sysobjects where id = object_id('dbo.sp_IntelisisET') and sysstat & 0xf = 4)
  SELECT @Accion = 'ALTER' 
  ELSE SELECT @Accion = 'CREATE' 

  SELECT @SQL = @Accion + ' PROCEDURE sp_IntelisisET 
			@Accion			varchar(20),
			@Estacion		int,
			@EstacionFirma	varchar(32),
			@Desde			int		= NULL,
			@Hasta			int		= NULL,
			@AccesoID		int		= NULL,
			@Empresa		varchar(5)	= NULL,
			@Sucursal		int		= NULL,
			@Usuario		varchar(10)	= NULL,
			@Licenciamiento	varchar(50)	= NULL

AS BEGIN
  DECLARE
    @TimeOut			int,
    @Ahora			datetime,
    @Vencido			datetime,
    @UltimaActualizacion	datetime,
    @ultEstacion		int,
    @crEstacion			int,
    @Ok				int,
    @OkRef			varchar(255),
	@EliminarUsuarioDuplicado bit,
	@EliminarSesiones bit,
	@EliminarSesionesDias int,
	@ActualizarSesion bit

  SELECT @TimeOut = ISNULL(ETTimeOut, 15), @EliminarUsuarioDuplicado = EliminarUsuarioDuplicado, @EliminarSesiones = EliminarSesiones, @EliminarSesionesDias = EliminarSesionesDias, @ActualizarSesion = ActualizarSesion FROM IntelisisMK
  SELECT @Ahora = GETDATE()
  SELECT @Vencido = DATEADD(minute, -@TimeOut, @Ahora)


  SELECT @Ok = NULL, @OkRef = NULL

  IF @Accion = '+"'"+'INSERT'+"'"+'
  BEGIN
    IF @EliminarUsuarioDuplicado = 1
      IF EXISTS (SELECT * FROM IntelisisET WHERE Usuario = @Usuario AND Estacion BETWEEN @Desde AND @Hasta)
		DELETE IntelisisET WHERE Usuario = @Usuario AND Estacion BETWEEN @Desde AND @Hasta

    IF @EliminarSesiones = 1
      DELETE IntelisisET WHERE UltimaActualizacion < = DATEADD(day,-@EliminarSesionesDias,@Ahora)

    SELECT @Estacion = NULL
    SELECT @Estacion = (SELECT MAX(Estacion) FROM IntelisisET WHERE Estacion BETWEEN @Desde AND @Hasta)
    IF @Estacion IS NULL 
      SELECT @Estacion = @Desde
    ELSE

    IF @ActualizarSesion = 1 OR @ActualizarSesion IS NULL 
    BEGIN
      IF @Estacion = @Hasta
      BEGIN
        SELECT @Estacion = NULL, @crEstacion = NULL, @ultEstacion = @Desde - 1
        DECLARE crIntelisisET CURSOR LOCAL FOR 
         SELECT Estacion, UltimaActualizacion
           FROM IntelisisET
          WHERE Estacion BETWEEN @Desde AND @Hasta
          ORDER BY Estacion
        OPEN crIntelisisET
        FETCH NEXT FROM crIntelisisET INTO @crEstacion, @UltimaActualizacion
        WHILE @@FETCH_STATUS <> -1 AND @Estacion IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            IF @crEstacion > @ultEstacion + 1
              SELECT @Estacion = @ultEstacion + 1
            ELSE 
            IF @TimeOut > 0 AND @UltimaActualizacion < @Vencido
            BEGIN
              DELETE IntelisisET WHERE Estacion = @crEstacion
              SELECT @Estacion = @crEstacion
            END
            SELECT @ultEstacion = @crEstacion
          END
          FETCH NEXT FROM crIntelisisET INTO @crEstacion, @UltimaActualizacion
        END
        CLOSE crIntelisisET
        DEALLOCATE crIntelisisET  
      END ELSE
      IF @Estacion < @Hasta
        SELECT @Estacion = @Estacion + 1
    END ELSE
      SELECT @Estacion = @Estacion + 1


    IF @Estacion IS NOT NULL
    BEGIN
      IF NOT EXISTS(SELECT * FROM IntelisisET WHERE EstacionFirma = @EstacionFirma)
	  BEGIN
        INSERT IntelisisET (
                Estacion,  EstacionFirma,  Empresa,  Sucursal,  Usuario,  UltimaActualizacion, Licenciamiento) 
        VALUES (@Estacion, @EstacionFirma, @Empresa, @Sucursal, @Usuario, @Ahora, @Licenciamiento)  
      END
      ELSE 
        SELECT @Estacion = NULL, @Ok = 151
    END ELSE
      SELECT @Ok = 152
  END ELSE
  BEGIN
    SELECT @EstacionFirma = EstacionFirma FROM IntelisisET WHERE Estacion = @Estacion 

    IF @Accion = '+"'"+'UPDATE'+"'"+'
    BEGIN
      IF @ActualizarSesion = 1
	  BEGIN
        UPDATE IntelisisET WITH (ROWLOCK) SET UltimaActualizacion = @Ahora WHERE Estacion = @Estacion 
        IF @@ROWCOUNT = 0 SELECT @Ok = 153
	  END
    END ELSE
    IF @Accion = '+"'"+'DELETE'+"'"+'
    BEGIN
      DELETE IntelisisET WHERE Estacion = @Estacion AND EstacionFirma = @EstacionFirma 
      IF @@ROWCOUNT = 0 SELECT @Ok = 154
    END
  END

  SELECT '+"'"+'Estacion'+"'"+' = @Estacion, '+"'"+'EstacionFirma'+"'"+' = @EstacionFirma, '+"'"+'Ok'+"'"+' = @Ok, '+"'"+'OkRef'+"'"+' = @OkRef 
END'
  EXEC (@SQL)

GO

/*
select * from master.dbo.IntelisisET order by estacion
EXEC master.dbo.sp_IntelisisET 'INSERT', NULL, 'FIRMA2', 1, 10, 1

EXEC master.dbo.sp_IntelisisET 'UPDATE', 5
EXEC master.dbo.sp_IntelisisET 'DELETE', 7


en Delphi usar
  EstacionAccesoID
  SQLAsignarAcceso
  SQLDesAsignarAcceso
*/

/*************** sp_IntelisisET *******************/
DECLARE
    @SQL		nvarchar(max),
    @Accion varchar(20)

  SELECT @SQL = NULL, @Accion = NULL
  if exists (select * from sysobjects where id = object_id('dbo.spEliminarRegistroIntelisisET') and sysstat & 0xf = 4) 
    SELECT @Accion = 'ALTER' 
  ELSE SELECT @Accion = 'CREATE' 
  
  SELECT @SQL = @Accion + N' PROCEDURE spEliminarRegistroIntelisisET
			@Estacion int
  AS 
  BEGIN
    	DELETE FROM IntelisisET WHERE Estacion = @Estacion
	  RETURN
  END'
  
  EXEC sp_executesql @SQL
GO


PRINT "******************* INSTALACION COMPLETA ******************"
GO
