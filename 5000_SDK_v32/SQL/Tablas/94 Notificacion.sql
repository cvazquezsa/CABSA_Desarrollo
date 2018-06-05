-- 11326
/* NotificacionAnexo */
if not exists(select * from SysTabla where SysTabla = 'NotificacionAnexo')
INSERT INTO SysTabla (SysTabla) VALUES ('NotificacionAnexo')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionAnexo') and type = 'U') 
CREATE TABLE dbo.NotificacionAnexo (
  Notificacion		varchar(50)		NOT NULL,
  RID				int				IDENTITY,
  Tipo				varchar(50)		NOT NULL DEFAULT 'Especifico',
  Ruta				varchar(255)	NULL,
  Nombre			varchar(255)	NULL,
  CONSTRAINT priNotificacionAnexo PRIMARY KEY CLUSTERED(Notificacion, RID)
  )
GO

--drop table NotificacionTrabajo
/* NotificacionTrabajo */
if not exists(select * from SysTabla where SysTabla = 'NotificacionTrabajo')
INSERT INTO SysTabla (SysTabla) VALUES ('NotificacionTrabajo')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionTrabajo') and type = 'U') 
CREATE TABLE dbo.NotificacionTrabajo (
    Trabajo        		varchar(100)NOT NULL,

	spSucursal			int			NOT NULL,
	spEmpresa			varchar(5)	NOT NULL,
	spUsuario			varchar(30) NOT NULL,
	Nombre				varchar(100)	NULL,
	Descripcion			varchar(255)	NULL,
	UltimaActualizacion	datetime		NULL	DEFAULT GETDATE(),
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
  	Contrasena  		varchar(30)		NULL	DEFAULT '',
  	
  	Domingo				bit				NULL	DEFAULT 0,
  	Lunes				bit				NULL	DEFAULT 0,
  	Martes				bit				NULL	DEFAULT 0,
  	Miercoles			bit				NULL	DEFAULT 0,
  	Jueves				bit				NULL	DEFAULT 0,
  	Viernes				bit				NULL	DEFAULT 0,
  	Sabado				bit				NULL	DEFAULT 0,
  	
  	Tipo  				varchar(30)		NULL	DEFAULT 'Primer',
  	Dia  				varchar(30)		NULL	DEFAULT 'Lunes',
  	FechaInicial		datetime		NULL    DEFAULT	GETDATE(),

	Procesar    		varchar(30)		NULL	DEFAULT 'Procesar Notificaciones',
  	
    	CONSTRAINT priNotificacionTrabajo PRIMARY KEY  CLUSTERED (Trabajo)
)
GO

EXEC spALTER_TABLE 'NotificacionTrabajo', 'Procesar', 'varchar(30) NULL DEFAULT "Procesar Notificaciones"'
GO

IF NOT EXISTS (SELECT * FROM NotificacionTrabajo WHERE Trabajo = 'Notificacion_DEMO_ 0_DEMO_Procesar Notificaciones')
INSERT NotificacionTrabajo (Trabajo,	Nombre,   Descripcion, spSucursal, spEmpresa, spUsuario)
VALUES				   ('Notificacion_DEMO_ 0_DEMO_Procesar Notificaciones', 'Notificacion_DEMO_ 0_DEMO_Procesar Notificaciones', 'Intelisis Service', 0, 'DEMO', 'DEMO')


/****** NotificacionClave ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionClave') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionClave','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionClave') and type = 'U') 
CREATE TABLE dbo.NotificacionClave (
    Clave					varchar(50) NOT NULL,
    
    Descripcion				varchar(100) NULL,
    Asunto					varchar(255) NULL,
    Mensaje					varchar(max) NULL,
    MedioComunicacion		varchar(15) NULL,
    TipoFechaNotificacion	varchar(50) NULL, --(Emision),(Vencimiento),(Especifica)
    FechaNotificacion		datetime NULL DEFAULT 'Aplazar',
    AnticipacionFechaTipo	varchar(20) NULL, -- Aplazar, Adelantar
    AnticipacionFecha		int NOT NULL DEFAULT 0,
    
    Frecuencia				varchar(20) NOT NULL DEFAULT '(Diaria)', --(Diaria),(Semanal),(Mensual),(Bimestral),(Trimestral),(Semestral),(Anual)
    Lunes					bit NOT NULL DEFAULT 1,
    Martes					bit NOT NULL DEFAULT 1,    
    Miercoles				bit NOT NULL DEFAULT 1,
    Jueves					bit NOT NULL DEFAULT 1,
    Viernes					bit NOT NULL DEFAULT 1,
    Sabado					bit NOT NULL DEFAULT 1,
    Domingo					bit NOT NULL DEFAULT 1,
    DiaMes					int NULL,
	FechaInicio				datetime NULL,		    
    
	CONSTRAINT priNotificacionClave PRIMARY KEY  CLUSTERED (Clave)
)
GO

EXEC spALTER_TABLE 'NotificacionClave', 'TipoFechaNotificacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NotificacionClave', 'FechaNotificacion', 'datetime NULL'
EXEC spALTER_TABLE 'NotificacionClave', 'AnticipacionFecha', 'int NOT NULL DEFAULT 0'
EXEC spALTER_TABLE 'NotificacionClave', 'Frecuencia', 'varchar(20) NOT NULL DEFAULT "(Diaria)"'
EXEC spALTER_TABLE 'NotificacionClave', 'Lunes', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'NotificacionClave', 'Martes', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'NotificacionClave', 'Miercoles', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'NotificacionClave', 'Jueves', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'NotificacionClave', 'Viernes', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'NotificacionClave', 'Sabado', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'NotificacionClave', 'Domingo', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'NotificacionClave', 'DiaMes', 'bit NULL'
EXEC spALTER_TABLE 'NotificacionClave', 'FechaInicio', 'datetime NULL'
EXEC spALTER_TABLE 'NotificacionClave', 'AnticipacionFechaTipo', 'varchar(20) NULL DEFAULT "Aplazar"'
GO

/****** NotificacionClaveModulo ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionClaveModulo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionClaveModulo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionClaveModulo') and type = 'U') 
CREATE TABLE dbo.NotificacionClaveModulo (
    Clave					varchar(50) NOT NULL,
    Modulo					varchar(5) NOT NULL,
    

	CONSTRAINT priNotificacionClaveModulo PRIMARY KEY  CLUSTERED (Clave, Modulo)
)
GO

/****** NotificacionClaveConsulta ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionClaveConsulta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionClaveConsulta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionClaveConsulta') and type = 'U') 
CREATE TABLE dbo.NotificacionClaveConsulta (
    Clave					varchar(50) NOT NULL,
    ConsultaNombre			varchar(50) NOT NULL,
    
    Consulta				varchar(max) NULL,

	CONSTRAINT priNotificacionClaveConsulta PRIMARY KEY  CLUSTERED (Clave, ConsultaNombre)
)
GO

/****** NotificacionClaveModuloEstatus ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionClaveModuloEstatus') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionClaveModuloEstatus','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionClaveModuloEstatus') and type = 'U') 
CREATE TABLE dbo.NotificacionClaveModuloEstatus (
    Clave					varchar(50) NOT NULL,
    Modulo					varchar(10) NOT NULL,
    Estatus					varchar(100) NOT NULL,

	CONSTRAINT priNotificacionClaveModuloEstatus PRIMARY KEY  CLUSTERED (Clave, Modulo, Estatus)
)
GO

/****** NotificacionClaveParam ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionClaveParam') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionClaveParam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionClaveParam') and type = 'U') 
CREATE TABLE dbo.NotificacionClaveParam (
    Clave					varchar(50) NOT NULL,
	Parametro				varchar(100) NOT NULL,
	
	Tipo					varchar(20) NULL,
	ValorOmision			varchar(255) NULL,
	Descripcion				varchar(255) NULL, 
	
	CONSTRAINT priNotificacionClaveParam PRIMARY KEY  CLUSTERED (Clave, Parametro)
)
GO

/****** NotificacionClaveParamAyuda ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionClaveParamAyuda') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionClaveParamAyuda','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionClaveParamAyuda') and type = 'U') 
CREATE TABLE dbo.NotificacionClaveParamAyuda (
    Clave					varchar(50) NOT NULL,
	Parametro				varchar(100) NOT NULL,
	Valor					varchar(255) NOT NULL,

	CONSTRAINT priNotificacionClaveParamAyuda PRIMARY KEY  CLUSTERED (Clave, Parametro, Valor)
)
GO

/****** NotificacionClaveDestinatario ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionClaveDestinatario') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionClaveDestinatario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionClaveDestinatario') and type = 'U') 
CREATE TABLE dbo.NotificacionClaveDestinatario (
    Clave					varchar(50) NOT NULL,
    RID						int identity(1,1) NOT NULL,
    
	TipoDestinatario		varchar(20) NULL,
	SeccionDestinatario		varchar(20)	NULL,
	Destinatario			varchar(100) NULL,
	DestinatarioCorreo		varchar(255) NULL,
	
	CONSTRAINT priNotificacionClaveDestinatario PRIMARY KEY  CLUSTERED (Clave, RID)
)
GO

EXEC spALTER_TABLE 'NotificacionClaveDestinatario', 'SeccionDestinatario', 'varchar(20) NULL'
GO

/****** NotificacionClaveFiltro ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionClaveFiltro') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionClaveFiltro','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionClaveFiltro') and type = 'U') 
CREATE TABLE dbo.NotificacionClaveFiltro (
    Clave					varchar(50) NOT NULL,
    RID						int identity(1,1) NOT NULL,
	
	Empresa					varchar(10) NULL,
	Sucursal				varchar(10) NULL,
	UEN						varchar(10) NULL,
	Usuario					varchar(10) NULL,
	Modulo					varchar(10) NULL,
	Movimiento				varchar(20) NULL,
	Estatus					varchar(15) NULL,
	Situacion				varchar(50) NULL,
	Proyecto				varchar(50) NULL,
	ContactoTipo			varchar(20) NULL,	
	Contacto				varchar(10) NULL,		
	ImporteMin				float NULL,			
	ImporteMax				float NULL,				
	ValidarAlEmitir			bit NULL DEFAULT 1,
	
	CONSTRAINT priNotificacionClaveFiltro PRIMARY KEY  CLUSTERED (Clave, RID)
)
GO

EXEC spALTER_TABLE 'NotificacionClaveFiltro', 'Proyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NotificacionClaveFiltro', 'ContactoTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NotificacionClaveFiltro', 'Contacto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'NotificacionClaveFiltro', 'ImporteMin', 'float NULL'
EXEC spALTER_TABLE 'NotificacionClaveFiltro', 'ImporteMax', 'float NULL'
EXEC spALTER_TABLE 'NotificacionClaveFiltro', 'ValidarAlEmitir', 'bit NULL DEFAULT 1'
GO

/****** Notificacion ******/
if not exists (select * from SysTabla where SysTabla = 'Notificacion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Notificacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Notificacion') and type = 'U') 
CREATE TABLE dbo.Notificacion (
    Notificacion			varchar(50) NOT NULL,
    
    Clave					varchar(50) NULL,    
    Descripcion				varchar(100) NULL,
    Asunto					varchar(255) NULL,
    Mensaje					varchar(max) NULL,
    Estatus					varchar(15) NULL,
    MedioComunicacion		varchar(15) NULL,
    TipoFechaNotificacion	varchar(50) NULL, --(Emision),(Vencimiento),(Especifica)    
    FechaNotificacion		datetime NULL,
	AnticipacionFechaTipo   varchar(20) NULL DEFAULT 'Aplazar', --Adelantar, Aplazar 
    AnticipacionFecha		int NOT NULL DEFAULT 0,

    Frecuencia				varchar(20) NOT NULL DEFAULT '(Diaria)', --(Diaria),(Semanal),(Mensual),(Bimestral),(Trimestral),(Semestral),(Anual)
    Lunes					bit NOT NULL DEFAULT 1,
    Martes					bit NOT NULL DEFAULT 1,    
    Miercoles				bit NOT NULL DEFAULT 1,
    Jueves					bit NOT NULL DEFAULT 1,
    Viernes					bit NOT NULL DEFAULT 1,
    Sabado					bit NOT NULL DEFAULT 1,
    Domingo					bit NOT NULL DEFAULT 1,
    DiaMes					int NULL,
	FechaInicio				datetime NULL,		    
	CondicionUsuario		varchar(max) NULL,
    
	CONSTRAINT priNotificacion PRIMARY KEY  CLUSTERED (Notificacion)
)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgNotificacionBC') and sysstat & 0xf = 8) drop trigger dbo.tgNotificacionBC
GO

EXEC spALTER_TABLE 'Notificacion', 'TipoFechaNotificacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Notificacion', 'FechaNotificacion', 'datetime NULL'
EXEC spALTER_TABLE 'Notificacion', 'AnticipacionFecha', 'int NOT NULL DEFAULT 0'
EXEC spALTER_TABLE 'Notificacion', 'Frecuencia', 'varchar(20) NOT NULL DEFAULT "(Diaria)"'
EXEC spALTER_TABLE 'Notificacion', 'Lunes', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Notificacion', 'Martes', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Notificacion', 'Miercoles', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Notificacion', 'Jueves', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Notificacion', 'Viernes', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Notificacion', 'Sabado', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Notificacion', 'Domingo', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Notificacion', 'DiaMes', 'bit NULL'
EXEC spALTER_TABLE 'Notificacion', 'FechaInicio', 'datetime NULL'
EXEC spALTER_TABLE 'Notificacion', 'AnticipacionFechaTipo', 'varchar(20) NULL DEFAULT "Aplazar"'
EXEC spALTER_TABLE 'Notificacion', 'CondicionUsuario', 'varchar(max) NULL'
GO

CREATE TRIGGER tgNotificacionBC ON Notificacion
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE   
    @NotificacionNueva  	varchar(50),
    @NotificacionAnterior	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @NotificacionNueva = Notificacion
    FROM Inserted
  SELECT @NotificacionAnterior = Notificacion
    FROM Deleted
  
  IF @NotificacionNueva = @NotificacionAnterior RETURN

  IF @NotificacionNueva IS NULL
  BEGIN
    DELETE FROM NotificacionDestinatario WHERE Notificacion = @NotificacionAnterior
    DELETE FROM NotificacionFiltro WHERE Notificacion = @NotificacionAnterior          
    DELETE FROM NotificacionVigencia WHERE Notificacion = @NotificacionAnterior              
    DELETE FROM NotificacionVigenciaHora WHERE Notificacion = @NotificacionAnterior                  
    DELETE FROM NotificacionConsulta WHERE Notificacion = @NotificacionAnterior                  
    DELETE FROM NotificacionParam WHERE Notificacion = @NotificacionAnterior                      
  END ELSE
  IF @NotificacionNueva <> @NotificacionAnterior
  BEGIN
    UPDATE NotificacionDestinatario SET Notificacion = @NotificacionNueva WHERE Notificacion = @NotificacionAnterior
    UPDATE NotificacionFiltro SET Notificacion = @NotificacionNueva WHERE Notificacion = @NotificacionAnterior    
    UPDATE NotificacionVigencia SET Notificacion = @NotificacionNueva WHERE Notificacion = @NotificacionAnterior        
    UPDATE NotificacionVigenciaHora SET Notificacion = @NotificacionNueva WHERE Notificacion = @NotificacionAnterior            
    UPDATE NotificacionConsulta SET Notificacion = @NotificacionNueva WHERE Notificacion = @NotificacionAnterior                
    UPDATE NotificacionParam SET Notificacion = @NotificacionNueva WHERE Notificacion = @NotificacionAnterior                    
  END
END
GO

/****** NotificacionConsulta ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionConsulta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionConsulta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionConsulta') and type = 'U') 
CREATE TABLE dbo.NotificacionConsulta (
    Notificacion			varchar(50) NOT NULL,
    ConsultaNombre			varchar(50) NOT NULL,
    
    Consulta				varchar(max) NULL,

	CONSTRAINT priNotificacionConsulta PRIMARY KEY  CLUSTERED (Notificacion, ConsultaNombre)
)
GO

/****** NotificacionParam ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionParam') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionParam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionParam') and type = 'U') 
CREATE TABLE dbo.NotificacionParam (
    Notificacion			varchar(50) NOT NULL,
    Parametro				varchar(100) NOT NULL,
    
    Valor					varchar(255) NULL,
    
	CONSTRAINT priNotificacionParam PRIMARY KEY  CLUSTERED (Notificacion, Parametro)
)
GO

/****** NotificacionDestinatario ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionDestinatario') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionDestinatario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionDestinatario') and type = 'U') 
CREATE TABLE dbo.NotificacionDestinatario (
    Notificacion			varchar(50) NOT NULL,
    RID						int identity(1,1) NOT NULL,
    
    TipoDestinatario		varchar(20) NULL,
    SeccionDestinatario		varchar(20) NULL, --PARA,CC,CCO
    Destinatario			varchar(100) NULL,
    DestinatarioCorreo		varchar(255) NULL,
    
	CONSTRAINT priNotificacionDestinatario PRIMARY KEY  CLUSTERED (Notificacion, RID)
)
GO

EXEC spALTER_TABLE 'NotificacionDestinatario', 'SeccionDestinatario', 'varchar(20) NULL'
GO

/****** NotificacionFiltro ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionFiltro') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionFiltro','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionFiltro') and type = 'U') 
CREATE TABLE dbo.NotificacionFiltro (
    Notificacion			varchar(50) NOT NULL,
    RID						int identity(1,1) NOT NULL,
	
	Empresa					varchar(10) NULL,
	Sucursal				varchar(10) NULL,
	UEN						varchar(10) NULL,
	Usuario					varchar(10) NULL,
	Modulo					varchar(10) NULL,
	Movimiento				varchar(20) NULL,
	Estatus					varchar(15) NULL,
	Situacion				varchar(50) NULL,
	Proyecto				varchar(50) NULL,
	ContactoTipo			varchar(20) NULL,
	Contacto				varchar(10) NULL,
	ImporteMin				float NULL,
	ImporteMax				float NULL,
	ValidarAlEmitir			bit NULL DEFAULT 1,
		
	CONSTRAINT priNotificacionFiltro PRIMARY KEY  CLUSTERED (Notificacion, RID)
)
GO

EXEC spALTER_TABLE 'NotificacionFiltro', 'Proyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NotificacionFiltro', 'ContactoTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NotificacionFiltro', 'Contacto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'NotificacionFiltro', 'ImporteMin', 'float NULL'
EXEC spALTER_TABLE 'NotificacionFiltro', 'ImporteMax', 'float NULL'
EXEC spALTER_TABLE 'NotificacionFiltro', 'ValidarAlEmitir', 'bit NULL DEFAULT 1'
GO

/****** NotificacionVigencia ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionVigencia') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionVigencia','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionVigencia') and type = 'U') 
CREATE TABLE dbo.NotificacionVigencia (
    Notificacion			varchar(50) NOT NULL,
    RID						int identity(1,1) NOT NULL,
	
	FechaD					datetime NULL,
	FechaA					datetime NULL,
	
	CONSTRAINT priNotificacionVigencia PRIMARY KEY  CLUSTERED (Notificacion, RID)
)
GO

/****** NotificacionVigenciaTemp ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionVigenciaTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionVigenciaTemp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionVigenciaTemp') and type = 'U') 
CREATE TABLE dbo.NotificacionVigenciaTemp (
	Estacion				int NOT NULL,
    Notificacion			varchar(50) NOT NULL,
    RID						int identity(1,1) NOT NULL,
	
	FechaD					datetime NULL,
	FechaA					datetime NULL,
	
	CONSTRAINT priNotificacionVigenciaTemp PRIMARY KEY  CLUSTERED (Estacion, Notificacion, RID)
)
GO

/****** NotificacionVigenciaHora ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionVigenciaHora') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionVigenciaHora','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionVigenciaHora') and type = 'U') 
CREATE TABLE dbo.NotificacionVigenciaHora (
    Notificacion			varchar(50) NOT NULL,
    RID						int identity(1,1) NOT NULL,
	
	HoraD					varchar(5) NULL,
	HoraA					varchar(5) NULL,
	
	CONSTRAINT priNotificacionVigenciaHora PRIMARY KEY  CLUSTERED (Notificacion, RID)
)
GO

/****** NotificacionVigenciaHoraTemp ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionVigenciaHoraTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionVigenciaHoraTemp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionVigenciaHoraTemp') and type = 'U') 
CREATE TABLE dbo.NotificacionVigenciaHoraTemp (
	Estacion				int NOT NULL,
    Notificacion			varchar(50) NOT NULL,
    RID						int identity(1,1) NOT NULL,
	
	HoraD					varchar(5) NULL,
	HoraA					varchar(5) NULL,
	
	CONSTRAINT priNotificacionVigenciaHoraTemp PRIMARY KEY  CLUSTERED (Estacion, Notificacion, RID)
)
GO

/****** NotificacionConsultaTemp ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionConsultaTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionConsultaTemp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionConsultaTemp') and type = 'U') 
CREATE TABLE dbo.NotificacionConsultaTemp (
	Estacion				int NOT NULL,
    Notificacion			varchar(50) NOT NULL,
    ConsultaNombre			varchar(50) NOT NULL,
    
    Valor					varchar(255) NULL,

	CONSTRAINT priNotificacionConsultaTemp PRIMARY KEY  CLUSTERED (Estacion, Notificacion, ConsultaNombre)
)
GO

/****** NotificacionHist ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionHist') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionHist','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionHist') and type = 'U') 
CREATE TABLE dbo.NotificacionHist (
	ID						int identity(1,1) NOT NULL,
	
	
	Fecha					datetime NULL,
	IntelisisServiceID		int NULL,
	
	Empresa					varchar(5) NULL,	
	Modulo					varchar(20) NULL,
	ModuloID				varchar(20) NULL,
	FechaNotificacion		datetime NULL,
	Notificacion			varchar(50) NULL,
	Asunto					varchar(255) NULL,	
	Mensaje					varchar(max) NULL,
	Para					varchar(max) NULL,
	CC						varchar(max) NULL,
	CCO						varchar(max) NULL,
	Anexos					varchar(max) NULL,
	
	CONSTRAINT priNotificacionHist PRIMARY KEY  CLUSTERED (ID)
)
GO

-- 11326
EXEC spALTER_TABLE 'NotificacionHist', 'Anexos', 'varchar(max) NULL'
GO

/****** UsuarioNotificacion ******/
if not exists (select * from SysTabla where SysTabla = 'UsuarioNotificacion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioNotificacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioNotificacion') and type = 'U') 
CREATE TABLE dbo.UsuarioNotificacion (
    Usuario					varchar(10) NOT NULL,
	RID						int identity(1,1) NOT NULL,
	
	IntelisisServiceID		int NULL,	
	Empresa					varchar(5) NULL,	
	Modulo					varchar(20) NULL,
	ModuloID				varchar(20) NULL,
	FechaNotificacion		datetime NULL,
	Notificacion			varchar(50) NULL,
	Asunto					varchar(255) NULL,	
	Mensaje					varchar(max) NULL,
	Para					varchar(max) NULL,
	CC						varchar(max) NULL,
	CCO						varchar(max) NULL,
	Anexos					varchar(max) NULL,
	
	Estatus					varchar(15) NULL DEFAULT 'PENDIENTE',
	
	CONSTRAINT priUsuarioNotificacion PRIMARY KEY  CLUSTERED (Usuario, RID)
)
GO

-- 11326
EXEC spALTER_TABLE 'UsuarioNotificacion', 'Anexos', 'varchar(max) NULL'
GO

/****** NotificacionTagAyuda ******/
if not exists (select * from SysTabla where SysTabla = 'NotificacionTagAyuda') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NotificacionTagAyuda','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NotificacionTagAyuda') and type = 'U') 
CREATE TABLE dbo.NotificacionTagAyuda (
	Tag					varchar(100) NOT NULL,
	

	Asunto				bit NULL,
	Mensaje				bit	NULL,
	Consulta			bit NULL,
	Condicion			bit NULL,
	Descripcion			varchar(255) NULL,
			
	CONSTRAINT priNotificacionTagAyuda PRIMARY KEY  CLUSTERED (Tag)
)
GO
