
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO



/*** MotivoRechazo  ***/
if not exists(select * from SysTabla where SysTabla = 'MotivoRechazo ')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MotivoRechazo ','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MotivoRechazo ') and type = 'U') 
CREATE TABLE dbo.MotivoRechazo (
Motivo              varchar(8),
Descripcion         varchar(40)

)
GO




if exists (select * from sysobjects where id = object_id('dbo.tgInforMotivoRechazoABC')           AND sysstat & 0xf = 8) drop trigger dbo.tgInforMotivoRechazoABC
GO
--CREATE TRIGGER tgInforMotivoRechazoABC ON MotivoRechazo
----//WITH ENCRYPTION
--FOR INSERT, UPDATE ,DELETE
--AS BEGIN
--  DECLARE
--   @ProdInterfazINFOR					bit,
--   @Motivo   							varchar (50),
--   @Estatus							    varchar (10),
--   @Datos								varchar(max),
--   @Ok									int,
--   @OkRef								varchar(255),
--   @Id									int,
--   @Cinserted		                	int,
--   @Cdeleted			                int,
--   @Empresa								varchar(20)

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
--  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
--    FROM EmpresaGral WHERE Empresa = @Empresa
--  SELECT @Cinserted =  COUNT(*) FROM inserted
--  SELECT @Cdeleted =  COUNT(*) FROM deleted

--  IF @ProdInterfazINFOR = 1
--  BEGIN
--	IF @Cinserted <> 0           AND @Cdeleted = 0 
--	BEGIN
--      SET @Estatus = 'ALTA' 
--	END
--    IF @Cinserted <> 0           AND @Cdeleted<> 0 
--	 BEGIN
--      SET @Estatus = 'CAMBIO'
--     END
--    IF @Cinserted = 0           AND @Cdeleted <> 0 
--     BEGIN 
--      SET @Estatus = 'BAJA'
--     END
--    IF  @Estatus IN( 'ALTA','CAMBIO')
--      BEGIN
--        DECLARE crActualizar CURSOR FOR
--	    SELECT Motivo
--	      FROM Inserted
--      END
--    ELSE
--    IF @Estatus = 'BAJA'
--      BEGIN
--      DECLARE crActualizar CURSOR local FOR
--	  SELECT Motivo
--	    FROM Deleted     
--      END  
--      IF @Estatus IS NOT NULL
--      BEGIN                 
--        OPEN crActualizar
--        FETCH NEXT FROM crActualizar INTO @Motivo
--        WHILE @@FETCH_STATUS = 0 
--        BEGIN
--          EXEC spInforGenerarSolicitudMotivoRechazo @Motivo,@Estatus,@Datos OUTPUT
--          FETCH NEXT FROM crActualizar INTO @Motivo
--		  END
--        CLOSE crActualizar
--        DEALLOCATE crActualizar
--      END  
      
--  END
--END
GO


/*** InvDCosto  ***/        
if not exists(select * from SysTabla where SysTabla = 'InvDCosto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InvDCosto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.InvDCosto') and type = 'U') 
CREATE TABLE dbo.InvDCosto (
  ID              int,
  Renglon         float,
  RenglonID       int,
  Articulo        varchar(20) ,
  CostoEstandar   float,
  CostoServicio   float,
  CostoManoObra   float,
  CostoIndirecto  float,
  CostoMateriales float,
   
)
GO

EXEC spDROP_COLUMN 'InvDCosto', 'TipoCosto'
EXEC spDROP_COLUMN 'InvDCosto', 'Costo'
EXEC spALTER_TABLE 'InvDCosto', 'CostoEstandar', 'float NULL'
EXEC spALTER_TABLE 'InvDCosto', 'CostoManoObra', 'float NULL'
EXEC spALTER_TABLE 'InvDCosto', 'CostoServicio', 'float NULL'
EXEC spALTER_TABLE 'InvDCosto', 'CostoIndirecto', 'float NULL'
EXEC spALTER_TABLE 'InvDCosto', 'CostoMateriales', 'float NULL'  
	
/****** PlantaProductiva ******/
if not exists(select * from SysTabla where SysTabla = 'PlantaProductiva')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PlantaProductiva','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PlantaProductiva') and type = 'U') 

CREATE TABLE PlantaProductiva

(
    Clave			varchar(8) NOT NULL,	
    Descripcion			varchar(40)NOT  NULL,	
    Sucursal                    int        NULL,
CONSTRAINT priPlantaProductiva PRIMARY KEY CLUSTERED (Clave, Descripcion)
)

GO
Exec spAlter_Table 'PlantaProductiva', 'Sucursal',' int NULL '


/**************** tgInforPlantaProductivaABC****************/
if exists (select * from sysobjects where id = object_id('dbo.tgInforPlantaProductivaABC') and sysstat & 0xf = 8) drop trigger dbo.tgInforPlantaProductivaABC
GO
--CREATE TRIGGER tgInforPlantaProductivaABC ON PlantaProductiva
----//WITH ENCRYPTION
--FOR UPDATE ,DELETE,INSERT
--AS BEGIN
--  DECLARE
--   @ProdInterfazINFOR					bit,
--   @Clave							varchar (10),
--   @Estatus							    varchar (10),
--   @Datos								varchar (max),
--   @Ok									int,
--   @OkRef								varchar(255),
--   @Id									int,
--   @Cinserted		                	int,
--   @Cdeleted			                int,
--   @ReferenciaIntelisisService			varchar(50)	,
--   @Empresa								varchar(20)

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
--  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
--    FROM EmpresaGral WHERE Empresa = @Empresa

--  SELECT @Cinserted =  COUNT(*) FROM inserted
--  SELECT @Cdeleted =  COUNT(*) FROM deleted
 
--  IF @ProdInterfazINFOR = 1
--  BEGIN
--	IF @Cinserted <> 0 AND @Cdeleted = 0 
--	BEGIN
--      SET @Estatus = 'ALTA' 
--	END
--    IF @Cinserted <> 0 AND @Cdeleted<> 0 
--	 BEGIN
--      SET @Estatus = 'CAMBIO'
--     END
--    IF @Cinserted = 0 AND @Cdeleted <> 0 
--     BEGIN 
--      SET @Estatus = 'BAJA'
--     END
--    IF  @Estatus IN( 'ALTA','CAMBIO')
--      BEGIN
--        DECLARE crActualizar CURSOR FOR
--	    SELECT Clave
--	      FROM Inserted
--      END
--    ELSE
--    IF @Estatus = 'BAJA'
--      BEGIN
--      DECLARE crActualizar CURSOR local FOR
--	  SELECT Clave
--	    FROM Deleted     
--      END  
--      IF @Estatus IS NOT NULL
--      BEGIN                
--        OPEN crActualizar
--        FETCH NEXT FROM crActualizar INTO @Clave
--        WHILE @@FETCH_STATUS = 0 
--        BEGIN
    
--           EXEC spInforGenerarSolicitudPlantaProductiva  @Clave,@Estatus,@Datos OUTPUT
--          FETCH NEXT FROM crActualizar INTO @Clave
--		  END
--        CLOSE crActualizar
--        DEALLOCATE crActualizar
--      END  
      
--  END
--END
GO



/****** UsuarioPlantaAcceso ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioPlantaAcceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioPlantaAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioPlantaAcceso') and type = 'U') 

CREATE TABLE dbo.UsuarioPlantaAcceso (
	Usuario 		char(10)  	NOT NULL,
	Clave		    varchar(40)	 	NOT NULL,
	CONSTRAINT priUsuarioPlantaAcceso PRIMARY KEY CLUSTERED (Usuario, Clave)


	
)
GO


if exists (select * from sysobjects where id = object_id('dbo.tgInforUsuarioPlantaAccesoABC')           AND sysstat & 0xf = 8) drop trigger dbo.tgInforUsuarioPlantaAccesoABC
GO
--CREATE TRIGGER tgInforUsuarioPlantaAccesoABC ON UsuarioPlantaAcceso
----//WITH ENCRYPTION
--FOR INSERT, UPDATE ,DELETE
--AS BEGIN
--  DECLARE
--   @ProdInterfazINFOR					bit,
--   @Usuario								varchar (10),
--   @Estatus							    varchar (10),
--   @Datos								varchar(max),
--   @Ok									int,
--   @OkRef								varchar(255),
--   @Id									int,
--   @Cinserted		                	int,
--   @Cdeleted			                int,
--   @Empresa								varchar(20),
--   @Planta		varchar(8)
   

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
--  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
--    FROM EmpresaGral WHERE Empresa = @Empresa
--  SELECT @Cinserted =  COUNT(*) FROM inserted
--  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
--  IF @ProdInterfazINFOR = 1
--  BEGIN
--	IF @Cinserted <> 0           AND @Cdeleted = 0 
--	BEGIN
--      SET @Estatus = 'ALTA' 
--	END
--    IF @Cinserted <> 0           AND @Cdeleted<> 0 
--	 BEGIN
--      SET @Estatus = 'CAMBIO'
--     END
--    IF @Cinserted = 0           AND @Cdeleted <> 0 
--     BEGIN 
--      SET @Estatus = 'BAJA'
--     END
--    IF  @Estatus IN( 'ALTA','CAMBIO')
--      BEGIN
--        DECLARE crActualizar CURSOR FOR
--	    SELECT Usuario,Clave	
--	      FROM Inserted
--      END
--    ELSE
--    IF @Estatus = 'BAJA'
--      BEGIN
--      DECLARE crActualizar CURSOR local FOR
--	  SELECT Usuario,Clave	
--	    FROM Deleted     
--      END   
--      IF @Estatus IS NOT NULL
--      BEGIN       
--        OPEN crActualizar
--        FETCH NEXT FROM crActualizar INTO @Usuario,@Planta		
--        WHILE @@FETCH_STATUS = 0 
--        BEGIN
--          EXEC spInforGenerarSolicitudPlantaUsuario  @Usuario,@Planta,@Estatus,@Datos OUTPUT
--          FETCH NEXT FROM crActualizar INTO @Usuario,@Planta	
--          END
--        CLOSE crActualizar
--        DEALLOCATE crActualizar
--      END  
      
--  END
--END
GO



/******MapeoMovimientosIntelisisInfor******/
if not exists(select * from SysTabla where SysTabla = 'MapeoMovimientosIntelisisInfor')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MapeoMovimientosIntelisisInfor','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MapeoMovimientosIntelisisInfor') and type = 'U') 
CREATE TABLE dbo.MapeoMovimientosIntelisisInfor (

	Modulo		 				varchar(5)	NULL,
	Movimiento 					varchar(20)	NULL,
	ReferenciaIntelisisMes  	varchar(20)	NULL
)
GO

/****** MapeoMovimientosInforIntelisis ******/
if not exists(select * from SysTabla where SysTabla = 'MapeoMovimientosInforIntelisis')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MapeoMovimientosInforIntelisis','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MapeoMovimientosInforIntelisis') and type = 'U') 
CREATE TABLE dbo.MapeoMovimientosInforIntelisis (

	Mov 		 				varchar(20)	NULL,
	INFORMov 					varchar(20)	NULL,
)
GO
EXEC spALTER_TABLE 'MapeoMovimientosInforIntelisis', 'Modulo', 'varchar(5) NULL'

/****** MapeoPlantaIntelisisMes ******/
if not exists(select * from SysTabla where SysTabla = 'MapeoPlantaIntelisisMes')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MapeoPlantaIntelisisMes','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MapeoPlantaIntelisisMes') and type = 'U') 
CREATE TABLE dbo.MapeoPlantaIntelisisMes (

	Referencia	 				varchar(50)	NULL,
	Empresa						varchar(5)	NULL,
	Planta						varchar(20)	NULL,
	MapeoPlantaIntelisisMes						varchar(10)	NULL,
	Sucursal				  	int	NULL
)
GO
EXEC spALTER_TABLE 'MapeoPlantaIntelisisMes', 'Planta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MapeoPlantaIntelisisMes', 'AlmacenMatPrima', 'varchar(10) NULL '
/****** PerfilMES ******/
if not exists(select * from SysTabla where SysTabla = 'PerfilMES')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PerfilMES','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PerfilMES') and type = 'U') 
CREATE TABLE dbo.PerfilMES (

	PerfilMES	 				varchar(50)	
)
GO


/**************** tgInforPerfilMESABC ****************/
if exists (select * from sysobjects where id = object_id('dbo.tgInforPerfilMESABC') and sysstat & 0xf = 8) drop trigger dbo.tgInforPerfilMESABC
GO
--CREATE TRIGGER tgInforPerfilMESABC ON PerfilMES
----//WITH ENCRYPTION
--FOR INSERT, UPDATE ,DELETE
--AS BEGIN
--  DECLARE
--   @ProdInterfazINFOR					bit,
--   @PerfilMES							varchar (20),
--   @Estatus							    varchar (10),
--   @Datos								varchar (max),
--   @Ok									int,
--   @OkRef								varchar(255),
--   @Id									int,
--   @Cinserted		                	int,
--   @Cdeleted			                int,
--   @Empresa								varchar(20)

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
--  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
--    FROM EmpresaGral WHERE Empresa = @Empresa

--  SELECT @Cinserted =  COUNT(*) FROM inserted
--  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
--  IF @ProdInterfazINFOR = 1
--  BEGIN
--	IF @Cinserted <> 0 AND @Cdeleted = 0 
--	BEGIN
--      SET @Estatus = 'ALTA' 
--	END
--    IF @Cinserted <> 0 AND @Cdeleted<> 0 
--	 BEGIN
--      SET @Estatus = 'CAMBIO'
--     END
--    IF @Cinserted = 0 AND @Cdeleted <> 0 
--     BEGIN 
--      SET @Estatus = 'BAJA'
--     END
--    IF  @Estatus IN( 'ALTA','CAMBIO')
--      BEGIN
--        DECLARE crActualizar CURSOR FOR
--	    SELECT PerfilMES
--	      FROM Inserted
--      END
--    ELSE
--    IF @Estatus = 'BAJA'
--      BEGIN
--      DECLARE crActualizar CURSOR local FOR
--	  SELECT PerfilMES
--	    FROM Deleted     
--      END   
--      IF @Estatus IS NOT NULL
--      BEGIN              
--        OPEN crActualizar
--        FETCH NEXT FROM crActualizar INTO @PerfilMES
--        WHILE @@FETCH_STATUS = 0 
--        BEGIN
--          EXEC spInforGenerarSolicitudPerfilMES @PerfilMES,@Estatus,@Datos OUTPUT
--          FETCH NEXT FROM crActualizar INTO @PerfilMES
--		  END
--        CLOSE crActualizar
--        DEALLOCATE crActualizar
--      END   
      
--  END
--END
GO


/*** ArtExistenciaIntMES ***/
if not exists(select * from SysTabla where SysTabla = 'ArtExistenciaIntMES')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtExistenciaIntMES','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtExistenciaIntMES') and type = 'U') 
CREATE TABLE dbo.ArtExistenciaIntMES (
  Articulo      varchar(20) NOT NULL,
  SubCuenta     varchar(50)NULL,
  SerieLote     varchar(20)NULL,
  Almacen       varchar(10) NULL,
  ExistenciaInte  float NULL,
  ExistenciaMES  float NULL ,
  CostoMes       float NULL 

)
GO
Exec spAlter_Table 'ArtExistenciaIntMES', 'CostoMES',' float NULL '


/****************ArtIntelisisService  ****************/
if exists (select * from sysobjects where id = object_id('dbo.ArtIntelisisService') and sysstat & 0xf = 2) drop view dbo.ArtIntelisisService
GO
CREATE VIEW ArtIntelisisService 
AS
SELECT ArtCosto.Sucursal, ArtCosto.Empresa,  ArtCosto.UltimoCosto, ArtCosto.CostoPromedio, ArtCosto.UltimoCostoSinGastos, Art.*
  FROM Art Art LEFT OUTER JOIN ArtCosto ArtCosto
    ON Art.Articulo = ArtCosto.Articulo
GO

-- Tabla para Procesar IntelisisServices de los registros que se insertaron por medio de los triguers de los catalogos, 
-- Relacionado con el spProcesarIntelisisServices que es un procedimiento que se ejecuta por medio de un Job o servicio de windows
if not exists (select * from sysobjects where id = object_id('dbo.ProcesarIntelisisService') and type = 'U') 
BEGIN
CREATE Table dbo.ProcesarIntelisisService
(ID int NOT NULL,
Solicitud varchar(50),
Procesando bit NULL DEFAULT 0,
Procesado bit NULL DEFAULT 0
)
END

GO

/******************** IntelisisResultadoAux ***********************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('IntelisisResultadoAux') AND type = 'U') 
	DROP TABLE dbo.IntelisisResultadoAux
GO
CREATE TABLE dbo.IntelisisResultadoAux(
		ID			int IDENTITY,
		IDRef		int,
		Sistema		varchar(10),
		Fecha		datetime,
		Almacen		char(100),
		Articulo	char(20),
		SerieLote	varchar(50),
		Cantidad	float)
GO
EXEC spALTER_TABLE 'IntelisisResultadoAux', 'ModuloID',		'int NULL'
EXEC spALTER_TABLE 'IntelisisResultadoAux', 'Mov',			'char(20)'
EXEC spALTER_TABLE 'IntelisisResultadoAux', 'MovID_numota', 'varchar(20)'

GO
