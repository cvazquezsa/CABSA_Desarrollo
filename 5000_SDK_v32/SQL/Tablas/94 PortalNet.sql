SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/****** EmpresaCfgPNet ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='EmpresaCfgPNet' and type ='U')
CREATE TABLE EmpresaCfgPNet(
	Empresa			varchar(5)   NOT NULL,
	Nombre			varchar(100) NULL,
	Telefonos		varchar(150) NULL,
	Direccion		varchar(255) NULL,
	ImagenPath		varchar(150) NULL,
	Email			varchar(100) NULL,
	MapaLatitud		varchar(50)  NULL,
	MapaLongitud	varchar(50)  NULL,
	MapaPrecision	varchar(50)  NULL,
	Mision			varchar(MAX) NULL,
	Vision			varchar(MAX) NULL,
	Nosotros		varchar(MAX) NULL,
	AvisoPrivacidad	varchar(MAX) NULL,
	URLIntranet		varchar(150) NULL,
	URLExtranet		varchar(150) NULL,
	SitioMantenimiento bit DEFAULT(0) NOT NULL,
)
GO

/****** pNetOpcionMostrar ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetOpcionMostrar' and type ='U')
CREATE TABLE pNetOpcionMostrar(
	OpcionMostrarID	int identity,
	Descripcion		varchar(150)   NULL,
	Estatus			bit DEFAULT(0) NOT NULL,
	CONSTRAINT PK_pNetOpcionMostrar PRIMARY KEY CLUSTERED (OpcionMostrarID)
)
GO

/****** pNetEmpresaOpcionMostrar ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetEmpresaOpcionMostrar' and type ='U')
CREATE TABLE pNetEmpresaOpcionMostrar(
	Empresa			varchar(5)   NOT NULL,
	OpcionMostrarID	int		     NOT NULL,
	Value			varchar(MAX) NULL
)
GO

/****** pNetRedSocialCat ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetRedSocialCat' and type ='U')
CREATE TABLE pNetRedSocialCat(
	RedSocialID	int identity	NOT NULL,
	Descripcion	varchar(150)	NULL,
	ImagenPath	varchar(150)	NULL,
	Estatus		bit DEFAULT(0)	NOT NULL,
	CONSTRAINT PK_pNetRedSocialCat PRIMARY KEY CLUSTERED (RedSocialID)
)
GO

/****** pNetEmpresaRedSocial ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetEmpresaRedSocial' and type ='U')
CREATE TABLE pNetEmpresaRedSocial(
	Empresa		varchar(5)   NOT NULL,
	RedSocialID	int			 NOT NULL,
	URL			varchar(MAX) NULL
)
GO

/****** pNetSucursal ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetSucursal' and type ='U')
CREATE TABLE pNetSucursal(
	Empresa			varchar(5)	 NOT NULL,
	Sucursal		int			 NOT NULL,
	Nombre			varchar(100) NULL,
	Telefonos		varchar(150) NULL,
	Direccion		varchar(255) NULL,
	ImagenPath		varchar(150) NULL,
	Email			varchar(100) NULL,
	MapaLatitud		varchar(50)	 NULL,
	MapaLongitud	varchar(50)	 NULL,
	MapaPrecision	varchar(50)	 NULL,
	Estatus			char(1)		 NOT NULL 
	CONSTRAINT def_pNetSucursal_estatus DEFAULT '1'
)
GO

IF NOT EXISTS(SELECT * FROM sysobjects where name ='PK_pNetSucursal' and xtype ='PK')
  ALTER TABLE dbo.pNetSucursal ADD CONSTRAINT PK_pNetSucursal PRIMARY KEY CLUSTERED (Empresa, Sucursal)
GO

/****** pNetUsuario ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetUsuario' and type ='U')
CREATE TABLE pNetUsuario(
	IDUsuario		int IDENTITY,
	Usuario			varchar(10)  NOT NULL,
	IDUsuarioTipo	int			 NOT NULL,
	IDRole			int			 NULL,	
	eMail			varchar(50)  NULL,
	Nombre			varchar(100) NULL,
	UrlImagen		varchar(255) NULL,
	Estatus			varchar(15)  NULL,
	FechaRegistro	datetime     NOT NULL DEFAULT GETDATE(),
	CONSTRAINT pk_pNetUsuario PRIMARY KEY CLUSTERED (Usuario ASC, IDUsuarioTipo ASC))
GO
EXEC spALTER_TABLE 'pNetUsuario', 'Telefono', 'varchar(100) NULL'
GO
EXEC spALTER_TABLE 'pNetUsuario', 'PrimeraVez', 'bit NOT NULL', '1'
GO
EXEC spALTER_TABLE 'pNetUsuario', 'Empresa', 'varchar(5) NULL'
GO
EXEC spALTER_TABLE 'pNetUsuario', 'Sucursal', 'int NULL'
GO
EXEC spALTER_TABLE 'Personal', 'Acreedor', 'varchar(10) NULL'
GO

/****** pNetUsuarioTipo ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetUsuarioTipo' and type ='U')
CREATE TABLE pNetUsuarioTipo(
	IDUsuarioTipo	int identity	NOT NULL,
	Descripcion		Varchar(60)		NULL,
	Tabla			Varchar(60)		NOT NULL,
	Campo			Varchar(60)		NOT NULL,
	Estatus			bit DEFAULT(0)	NOT NULL)
GO

/****** pNetUsuarioRecovery ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetUsuarioRecovery' and type ='U')
CREATE TABLE pNetUsuarioRecovery(
	Usuario			varchar(10)  NULL,
	IDUsuarioTipo	int			 NULL,
	eMail			varchar(50)  NULL,
	Token			varchar(100) NULL,
	FechaSolicitud	datetime CONSTRAINT DF_Date_pNetUsuarioRecovery DEFAULT GETDATE())
GO

/****** pNetRole ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetRole' and type ='U')
CREATE TABLE pNetRole(
	IDRole		  int IDENTITY(1,1),
	IDUsuarioTipo int				 NULL,
	Descripcion	  nvarchar(50)		 NULL,

	CONSTRAINT PK_pNetRole PRIMARY KEY CLUSTERED (IDRole)
)
GO

/****** pNetPermiso ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetPermiso' and type ='U')
CREATE TABLE pNetPermiso(
 IDPermiso		int			  NOT NULL,
 Descripcion	nvarchar(100) NULL,
 IDUsuarioTipo  int			  NULL,
 Icon			nvarchar(50)  NULL,
 Ruta			nvarchar(50)  NULL,
 IDPermisoPadre int			  NULL,
 Mostrar		int			  NULL
)
GO

/****** pNetUsuarioEmpresa ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetUsuarioEmpresa' and type ='U')
CREATE TABLE pNetUsuarioEmpresa(
	IDUsuarioEmpresa int IDENTITY(1,1),
	IDUsuario		 varchar(10)	NULL,
	Empresa			 varchar(5)		NULL
	CONSTRAINT PK_pNetUsuarioEmpresa PRIMARY KEY CLUSTERED (IDUsuarioEmpresa))
GO
/****** pNetConDin ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetConDin' and type ='U')
CREATE TABLE pNetConDin(
	IDpNetConDin	int IDENTITY(1,1),
	IDUsuario		int			 NOT NULL,
	IDUsuarioTipo	int			 NOT NULL,
	Nombre			varchar(100) NOT NULL,
	Favorito		bit			 NULL,
	Privado			bit			 NULL,
	ObjetoBase		varchar(100) NULL,
	APIGetString	varchar(max) NULL,
	JSONMetaData	varchar(max) NULL
	CONSTRAINT PK_pNetConDin PRIMARY KEY CLUSTERED (IDpNetConDin)
)
GO

/****** pNetConDinFavs ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetConDinFavs' and type ='U')
CREATE TABLE pNetConDinFavs(
	IDpNetConDin	int NOT NULL,
	IDUsuario		int NOT NULL,
	IDUsuarioTipo	int NOT NULL
	CONSTRAINT PK_pNetConDinFavs PRIMARY KEY CLUSTERED (IDpNetConDin, IDUsuario, IDUsuarioTipo)
)
GO


IF(SELECT COUNT(*) FROM pNetPermiso) = 0
BEGIN
 INSERT INTO dbo.pNetPermiso select 1,'Portal',1,'icon-screen-desktop', null, null, 1
 INSERT INTO dbo.pNetPermiso select 2,'Selecciona empresa',1,'', 'selecciona-empresa', 1, 1
 INSERT INTO dbo.pNetPermiso select 3,'Usuarios',1,'icon-users', '', null, 1
 INSERT INTO dbo.pNetPermiso select 4,'Todos los usuarios',1,'', 'todos-usuarios', 3, 1
 INSERT INTO dbo.pNetPermiso select 5,'Alta usuario',1,'', 'usuario-portal', 3, 1
 INSERT INTO dbo.pNetPermiso select 6,'Roles',1,'fa fa-lock', '', null, 1
 INSERT INTO dbo.pNetPermiso select 7,'Roles',1,'', 'roles', 6, 1
 INSERT INTO dbo.pNetPermiso select 8,'Asignar Plantilla',1,'', 'AsignaPlantilla', 1, 0
 INSERT INTO dbo.pNetPermiso select 9,'Editar Información',1,'', 'empresas', 1, 0
 INSERT INTO dbo.pNetPermiso select 10,'Editar Usuario',1,'', 'usuario-portal-editar', 3, 0
 --INSERT INTO dbo.pNetPermiso select 11,'Documentos',3,'fa fa-book', '', null, 0
 --INSERT INTO dbo.pNetPermiso select 12,'Administrar Documentos',3,'', 'admin-documentos', 11, 0
 --INSERT INTO dbo.pNetPermiso select 13,'Resumen de Movimientos',3,'fa fa-book', '', null, 0
 --INSERT INTO dbo.pNetPermiso select 14,'Estado de Cuenta',3,'', 'cte-edocuenta', 13, 1
 --INSERT INTO dbo.pNetPermiso select 15,'Facturas',3,'', 'cte-facturas', 13, 1 
 --INSERT INTO dbo.pNetPermiso select 16,'Garantías',1,'fa fa-calendar', '', null, 1
 --INSERT INTO dbo.pNetPermiso select 17,'Nueva Solicitud',1,'', 'alta-garantia', 16, 1
 --INSERT INTO dbo.pNetPermiso select 18,'Consulta/Seguimiento',1,'', 'consulta-garantia', 16, 1
 --INSERT INTO dbo.pNetPermiso select 19,'Clientes',3,'', 'icon-users', 13, 0
 --INSERT INTO dbo.pNetPermiso select 20,'Facturación', 3, 'fa-file-code-o', 'cte-consulta-facturacion', 13, 1
 --INSERT INTO dbo.pNetPermiso select 21,'Reportes',4,'fa fa-book', '', null, 0
 --INSERT INTO dbo.pNetPermiso select 22,'Estado de Cuenta',4,'', 'prov-edocuenta', 21, 1
 --INSERT INTO dbo.pNetPermiso select 23,'Reportes',2,'fa fa-book', '', null, 0
 --INSERT INTO dbo.pNetPermiso select 24,'Saldo de Vacaciones',2,'', 'pers-vacaciones', 23, 1
 --INSERT INTO dbo.pNetPermiso select 25,'Viáticos',2,'fa fa-book', '', null, 0
 --INSERT INTO dbo.pNetPermiso select 26,'Viáticos',2,'', 'pers-vacaciones', 25, 1 
 --INSERT INTO dbo.pNetPermiso select 27,'Agregar viáticos',2,'', 'acreed-viaticos', 25, 1  
 --INSERT INTO dbo.pNetPermiso select 28,'Consultas', 1,'fa fa-filter', '', null, 1
 --INSERT INTO dbo.pNetPermiso select 29,'Consultas Dinámicas', 1,'', 'cons-dinamicas', 28, 1
 INSERT INTO dbo.pNetPermiso select 29,'Recibo de nómina', 2,'', 'recibo-nomina', 23, 1 
 INSERT INTO dbo.pNetPermiso SELECT 70, 'Administrar Anexos', 1, 'fa fa-file-image-o', '', NULL, 1
 INSERT INTO dbo.pNetPermiso SELECT 71, 'Artículos', 1, '', 'AnexosArt', 70, 1
 --INSERT INTO pNetPermiso SELECT 72, 'Existencias de Artículos', 2, '', 'ArtExistencia', 23, 1
  --INSERT INTO dbo.pNetPermiso SELECT 73, 'Condominios', 1, 'fa fa-building-o', '', NULL, 1
 --INSERT INTO dbo.pNetPermiso SELECT 74, 'Amenidades', 1, '', 'condAmenidades', 73, 1
 --INSERT INTO dbo.pNetPermiso SELECT 75, 'Solicitar Amenidades', 1, '', 'condSolicitarAmenidades', 73, 1  
END
GO
DELETE FROM pNetPermiso WHERE IDPermiso IN (16,17,18, 28,29, 24, 23, 72,25,26,27,11,12,13,14,15,19,20,21,22,37,38,39,40,73,74,75)
GO

/****** pNetRolePermiso ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetRolePermiso' and type ='U')
CREATE TABLE pNetRolePermiso(
	IDRolePermiso	int IDENTITY(1,1) NOT NULL,
	IDRole			int NULL,
	IDPermiso		int NULL,
	CONSTRAINT PK_pNetRolePermiso PRIMARY KEY CLUSTERED (IDRolePermiso))
GO

IF(SELECT COUNT(*) FROM pNetOpcionMostrar) = 0
BEGIN
	INSERT INTO dbo.pNetOpcionMostrar(Descripcion) VALUES('Comunicados')
	INSERT INTO dbo.pNetOpcionMostrar(Descripcion) VALUES('Noticias')
	INSERT INTO dbo.pNetOpcionMostrar(Descripcion) VALUES('Destacados')
	INSERT INTO dbo.pNetOpcionMostrar(Descripcion) VALUES('BolsaTrabajo')
	INSERT INTO dbo.pNetOpcionMostrar(Descripcion) VALUES('CaptarContactos')
	INSERT INTO dbo.pNetOpcionMostrar(Descripcion) VALUES('RegCV')
	INSERT INTO dbo.pNetOpcionMostrar(Descripcion) VALUES('Email Contacto')
END
GO

IF(SELECT COUNT(*) FROM pNetRedSocialCat) = 0
BEGIN
	INSERT INTO dbo.pNetRedSocialCat(Descripcion, ImagenPath) VALUES('Facebook', NULL)
	INSERT INTO dbo.pNetRedSocialCat(Descripcion, ImagenPath) VALUES('Twitter', NULL)
	INSERT INTO dbo.pNetRedSocialCat(Descripcion, ImagenPath) VALUES('Google', NULL)
	INSERT INTO dbo.pNetRedSocialCat(Descripcion, ImagenPath) VALUES('Instagram', NULL)
	INSERT INTO dbo.pNetRedSocialCat(Descripcion, ImagenPath) VALUES('LinkedIn', NULL)
	INSERT INTO dbo.pNetRedSocialCat(Descripcion, ImagenPath) VALUES('YouTube', NULL)
	INSERT INTO dbo.pNetRedSocialCat(Descripcion, ImagenPath) VALUES('Vine', NULL)
	INSERT INTO dbo.pNetRedSocialCat(Descripcion, ImagenPath) VALUES('FourSquare', NULL)
	INSERT INTO dbo.pNetRedSocialCat(Descripcion, ImagenPath) VALUES('Pinterest', NULL)
	INSERT INTO dbo.pNetRedSocialCat(Descripcion, ImagenPath) VALUES('Blogger', NULL)
END
GO

IF(SELECT COUNT(*) FROM pNetRole) = 0
BEGIN
 INSERT INTO dbo.pNetRole (IDUsuarioTipo, Descripcion) VALUES (1, 'Administrador'); 
END
GO

IF(SELECT COUNT(*) FROM pNetRolePermiso) = 0
BEGIN
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 6); 
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 7);
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 1);
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 2);
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 3);
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 4);
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 5);
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 8); 
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 9);
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 10); 
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 28);
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (1, 29); 
 INSERT INTO dbo.pNetRolePermiso (IDRole, IDPermiso) VALUES (26, 72);
END
GO
TRUNCATE TABLE pNetUsuarioTipo
GO
IF(SELECT COUNT(*) FROM pNetUsuarioTipo) = 0
BEGIN
 INSERT INTO dbo.pNetUsuarioTipo (Descripcion, Estatus, Tabla, Campo) VALUES ('Intelisis', 1, 'Usuario', 'Usuario'); 
 INSERT INTO dbo.pNetUsuarioTipo (Descripcion, Estatus, Tabla, Campo) VALUES ('Personal', 1, 'Personal', 'Personal');
 INSERT INTO dbo.pNetUsuarioTipo (Descripcion, Estatus, Tabla, Campo) VALUES ('Cliente', 1, 'Cte', 'Cliente');
 INSERT INTO dbo.pNetUsuarioTipo (Descripcion, Estatus, Tabla, Campo) VALUES ('Proveedor', 1, 'Prov', 'Proveedor');
 INSERT INTO dbo.pNetUsuarioTipo (Descripcion, Estatus, Tabla, Campo) VALUES ('Acreedor', 1, 'Prov', 'Proveedor');
 INSERT INTO dbo.pNetUsuarioTipo (Descripcion, Estatus, Tabla, Campo) VALUES ('Proyecto', 1, 'Usuario', 'Usuario');
END
GO
GO
IF EXISTS (SELECT 1 FROM pNetUsuarioTipo WHERE Descripcion = 'Acreedor')
	DELETE FROM pNetUsuarioTipo WHERE Descripcion = 'Acreedor'
GO

IF(SELECT COUNT(*) FROM pNetUsuario) = 0
BEGIN
 INSERT INTO dbo.pNetUsuario (Usuario, IDUsuarioTipo, eMail, Nombre, Estatus, IDRole ) VALUES ('ADMIN', 1, 'admin@intelisis.com', 'Administrador', '1', 1); 
 INSERT INTO dbo.pNetUsuario (Usuario, IDUsuarioTipo, eMail, Nombre, Estatus, IDRole ) VALUES ('DEMO', 1, 'DEMO@intelisis.com', 'Demo', '1', 1); 
END
GO
EXEC spALTER_TABLE 'Art', 'DescripcionHTML', 'varchar(MAX)', ''
GO

/****** EmpresaCfgPNetPlantillas ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='EmpresaCfgPNetPlantillas' and type ='U')
CREATE TABLE EmpresaCfgPNetPlantillas(
 Empresa	varchar(5)   NOT NULL,
 Nombre		varchar(20)  NOT NULL,
 Condicion	varchar(20)  NULL,  -- Alta Personal, Generar Nómina, Periódica
 Perfil		varchar(50)  NULL,
 Asunto		varchar(255) NULL,
 Mensaje	varchar(max) NULL,
 Dias		int			 NULL,
 Estatus    varchar(50)  NULL,

 CONSTRAINT priEmpresaCfgPNetPlantillas PRIMARY KEY(Empresa, Nombre)
)
GO

IF NOT EXISTS(SELECT 1 FROM EmpresaCfgPNetPlantillas)
BEGIN
 DECLARE @Empresa varchar(5)
 
 SELECT @Empresa = MIN(Empresa) FROM Empresa WHERE Estatus = 'ALTA'
 
  WHILE @Empresa IS NOT NULL
  BEGIN
   INSERT INTO EmpresaCfgPNetPlantillas(Empresa, Nombre, Asunto, Condicion, Estatus, Mensaje) SELECT @Empresa, 'Bienvenida', 'Bienvenida', 'Alta Personal', 'ACTIVA', NULL
   INSERT INTO EmpresaCfgPNetPlantillas(Empresa, Nombre, Asunto, Condicion, Estatus, Mensaje) SELECT @Empresa, 'Nuevo Recibo', 'Usted ha recibido un CFDI - Recibo(s) de Nómina', 'Generar Nómina', 'ACTIVA', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">  <HTML><HEAD>  <META content="text/html; charset=unicode" http-equiv=Content-Type>  <META name=GENERATOR content="MSHTML 11.00.9600.18377"></HEAD>  <BODY><SPAN lang=ES-MX>  <P dir=ltr align=justify><FONT face="@Arial Unicode MS">Conforme a las cláusulas   contractuales y sus adendas que rigen la relación legal y laboral entre Muebles   para Baño, S.A. de C.V. y usted, nos permitimos notificarle que hemos puesto a   su disposición un Comprobante Fiscal Digital por Internet (CFDI) debidamente   timbrado conforme a las disposiciones fiscales y laborales vigentes y que   contiene sus recibos de nómina correspondiente a   <STRONG>@@Periodo</STRONG>.</FONT></P>  <P dir=ltr align=justify><FONT face="@Arial Unicode MS">Usted deberá consultarlo   y firmarlo accediendo directamente al sitio web mencionado en su contrato y   adendas o siguiendo el vínculo: </FONT></SPAN><A   href="http://gersa4.intelisiscloud.com/portalnet/"><SPAN lang=ES-MX><FONT   face="@Arial Unicode MS">http://gersa4.intelisiscloud.com/portalnet/</FONT></SPAN></A><SPAN   lang=ES-MX><FONT face="@Arial Unicode MS"> donde deberá ingresar su clave de   usuario y su clave secreta. Usted podrá descargar, imprimir y/o enviar por email   este comprobante.</FONT></P>  <P dir=ltr align=justify><FONT face="@Arial Unicode MS">Por último, esta es una   notificación automática por lo que no deberá responder a esta dirección. Si   usted tiene dudas o aclaraciones deberá canalizar sus comentarios a la dirección   </FONT></SPAN><A href="mailto:nomina@gersamex.com.mx"><SPAN lang=ES-MX><FONT   face="@Arial Unicode MS">nomina@gersamex.com.mx</FONT></SPAN></A></P><FONT   size=2 face=Arial><FONT size=2 face=Arial><SPAN lang=ES-MX>  <P dir=ltr align=justify><FONT size=3   face="@Arial Unicode MS">Atentamente,</FONT></P>  <P dir=ltr align=justify><FONT size=3 face="@Arial Unicode MS">Recursos   Humanos</FONT></P>  <P dir=ltr align=justify><FONT size=3 face="@Arial Unicode MS">Muebles para Baño   SA de CV</FONT></P></FONT></FONT></SPAN></BODY></HTML>'
   INSERT INTO EmpresaCfgPNetPlantillas(Empresa, Nombre, Asunto, Condicion, Estatus, Mensaje) SELECT @Empresa, 'Recordatorio', 'Recordatorio', 'Periódica', 'ACTIVA', NULL
   INSERT INTO EmpresaCfgPNetPlantillas(Empresa, Nombre, Asunto, Condicion, Estatus, Mensaje) SELECT @Empresa, 'Seguimiento', 'Seguimiento', 'Periódica', 'ACTIVA', NULL

   SELECT @Empresa = MIN(Empresa) FROM Empresa WHERE Estatus = 'ALTA' AND Empresa > @Empresa
  END
END
GO

/* pNetNotificacionTrabajo */
if not exists (select * from sysobjects where id = object_id('dbo.pNetNotificacionTrabajo') and type = 'U') 
CREATE TABLE dbo.pNetNotificacionTrabajo (
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

	Procesar    		varchar(30)		NULL	DEFAULT 'Procesar Correos',
  	
    CONSTRAINT priNetNotificacionTrabajo PRIMARY KEY  CLUSTERED (Trabajo)
)
GO

IF NOT EXISTS (SELECT * FROM pNetNotificacionTrabajo WHERE Trabajo = 'Notificacion_DEMO_ 0_DEMO_Procesar Correos')
 INSERT pNetNotificacionTrabajo (Trabajo,	Nombre,   Descripcion, spSucursal, spEmpresa, spUsuario)
 VALUES ('Notificacion_DEMO_ 0_DEMO_Procesar Correos', 'Notificacion_DEMO_ 0_DEMO_Procesar Correos', 'Recibos Nómina', 0, 'DEMO', 'DEMO')
GO

/*************************************************************************** Configuración de Tickets ***************************************************************************/
/***************** pNetTipoUserMov ******************/
IF NOT EXISTS(SELECT * FROM Sysobjects WHERE Name = 'pNetTipoUserMov' AND Type = 'U')
BEGIN
CREATE TABLE dbo.pNetTipoUserMov(
	Descripcion			varchar(60)NOT NULL,
	Mov					varchar(20) NULL
	CONSTRAINT AK_Mov UNIQUE(Descripcion,Mov) 
)
END
GO

/***************** pNetTipoUserRecurso ******************/
IF NOT EXISTS(SELECT * FROM Sysobjects WHERE Name = 'pNetTipoUserRecurso' AND Type = 'U')
BEGIN
CREATE TABLE dbo.pNetTipoUserRecurso(
	--IDTipoUserRecurso	int IDENTITY(1,1) NOT NULL,
	Descripcion			varchar(60) NOT NULL,
	Recurso				varchar(10) NOT NULL	
	CONSTRAINT AK_Recurso UNIQUE(Descripcion,Recurso) 
)
END
GO

/************************************************************************ Nomina ************************************************************************/

/****** NominaConsulta ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='NominaConsulta' and type ='U')
CREATE TABLE NominaConsulta(
	ID				int NULL,
	Personal		varchar(10) NULL,
	Empresa         varchar(5)  NULL,
	MovID			varchar(20) NULL,
	VioDetalle      bit			NULL,
	FechaDetalle    datetime	NULL,
	Acuerdo         bit			NULL,
	FechaAcuerdo    datetime	NULL,
	Estatus         bit			NULL
)
GO

/*********** fnFormatoMonedaDec *************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormatoMonedaDec') 
	DROP FUNCTION fnFormatoMonedaDec
GO
CREATE FUNCTION dbo.fnFormatoMonedaDec
(			
	@Valor decimal(30,10), 
	@Decimales int
) 
RETURNS VARCHAR(50) 
AS BEGIN
    DECLARE @Resultado          varchar(20),
            @Negativo           bit,
            @Antes              varchar(20),   
            @Despues            varchar(20),
            @Coma               int,
            @RedondeoMonetarios int

	SELECT @Negativo = CASE WHEN @Valor < 0 THEN 1 ELSE 0 END
    SELECT @Valor    = ROUND(@Valor, @Decimales)
        
	IF @Negativo = 1	
		SET @Valor = -1 * @Valor

	SET @Resultado = CONVERT(varchar, ISNULL(@Valor, 0.0))
	
	IF CHARINDEX ('.',@Resultado) > 0 
	BEGIN
		SET @Despues = SUBSTRING(@Resultado, CHARINDEX ('.', @Resultado), LEN(@Resultado))	
		SET @Antes  = SUBSTRING(@Resultado,1, CHARINDEX ('.', @Resultado)-1)	
	END
	ELSE
	BEGIN
		SET @Antes =   @Resultado
		SET @Despues = ''
	END
	
	IF LEN(@Antes) > 3 
	BEGIN
		SET @Coma = 3
		WHILE @Coma > 1 and @Coma < LEN(  @Antes)
		BEGIN
			SET @Antes = SUBSTRING(@Antes,1,LEN(@Antes) - @Coma) + ',' + RIGHT(@Antes,@Coma)
			SET @Coma = @Coma + 4
		END
	END
	
	SET @Resultado = @Antes + SUBSTRING(@Despues,1,@Decimales + 1)

	IF @Negativo = 1
		SET @Resultado = '-' + @Resultado
	
	SELECT @Resultado = '$' + @Resultado
	
	RETURN  @Resultado	

  RETURN (@Resultado)
 END
GO

/******** fnCalculaAntiguedad **************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.fnCalculaAntiguedad') AND Type = 'FN') 
	DROP FUNCTION dbo.fnCalculaAntiguedad
GO
CREATE FUNCTION dbo.fnCalculaAntiguedad
(
  @FechaIngreso datetime,
  @FechaActual  datetime
)
RETURNS varchar(25)
BEGIN
 DECLARE @FechaAñoActual    datetime,
         @FechaAñoActualMes datetime, 
         @DiffAño           int,
         @DiffMes           int,
         @DiffDia           int,
         @sAño              varchar(8),
         @sMes              varchar(9),
         @sDia              varchar(8),
         @sSalida           varchar(25) 

 SET @DiffAño = dbo.fnDiferenciaFecha('yy', @FechaIngreso, @FechaActual) 
 
 SET @FechaAñoActual = DATEADD(yy, @DiffAño, @FechaIngreso)  
 SET @DiffMes = dbo.fnDiferenciaFecha('mm', @FechaAñoActual, @FechaActual)
 
 SET @FechaAñoActualMes = DATEADD(mm, @DiffMes, @FechaAñoActual)  
 SET @DiffDia = dbo.fnDiferenciaFecha('dd', @FechaAñoActualMes, @FechaActual)
 
 SET @sAño =        
             CASE WHEN @DiffAño = 0 THEN ''
                  WHEN @DiffAño = 1 THEN CAST(@DiffAño AS varchar) + ' Año '
                  WHEN @DiffAño > 1 THEN CAST(@DiffAño AS varchar) + ' Años '
             END

 SET @sMes =       
             CASE WHEN @DiffMes = 0 THEN ''
                  WHEN @DiffMes = 1 THEN CAST(@DiffMes AS varchar) + ' Mes '
                  WHEN @DiffMes > 1 THEN CAST(@DiffMes AS varchar) + ' Meses '
             END

 SET @sDia = 
             CASE WHEN @DiffDia = 0 THEN ''
                  WHEN @DiffDia = 1 THEN CAST(@DiffDia AS varchar) + ' Día '
                  WHEN @DiffDia > 1 THEN CAST(@DiffDia AS varchar) + ' Días '
             END
             
 SET @sSalida = CASE WHEN @sAño + @sMes + @sDia = '' THEN 'Sin Antiguedad' 
                     ELSE @sAño + @sMes + @sDia 
                END

 RETURN @sSalida
END
GO

 /*************** fnDiferenciaFecha *****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.fnDiferenciaFecha') AND Type = 'FN') 
	DROP FUNCTION dbo.fnDiferenciaFecha
GO
CREATE FUNCTION dbo.fnDiferenciaFecha
(
	@Tipo         varchar(2),
	@FechaIngreso datetime,
	@FechaActual  datetime
)
RETURNS INT
BEGIN
  RETURN        
    CASE WHEN @FechaIngreso > @FechaActual 
	THEN NULL 
    ELSE
	CASE WHEN UPPER(@Tipo) NOT IN ('YY','MM','DD') THEN NULL    
		WHEN UPPER(@Tipo) = 'YY' THEN                
		CASE 
			WHEN DATEPART(DAY, @FechaIngreso) > DATEPART(DAY, @FechaActual) THEN DATEDIFF(MONTH, @FechaIngreso, @FechaActual) - 1
			ELSE DATEDIFF(MONTH, @FechaIngreso, @FechaActual)
		END / 12
		WHEN UPPER(@Tipo) = 'MM' THEN                   
		CASE     
			WHEN DATEPART(DAY, @FechaIngreso) > DATEPART(DAY, @FechaActual) THEN DATEDIFF(MONTH, @FechaIngreso, @FechaActual) - 1
			ELSE DATEDIFF(MONTH, @FechaIngreso, @FechaActual)
		END
		WHEN UPPER(@Tipo) = 'DD' THEN      
		CASE     
			WHEN CONVERT(varchar,@FechaIngreso,108) > CONVERT(varchar,@FechaActual,108)  THEN DATEDIFF(dd, @FechaIngreso, @FechaActual) - 1
			ELSE DATEDIFF(dd, @FechaIngreso, @FechaActual)
		END
		END
	END
	END
GO

/********************************************************************** Estado de Cuenta **********************************************************************/

/****** espCxcEstadoCuentaAntiguedad ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='espCxcEstadoCuentaAntiguedad' and type ='U')
CREATE TABLE espCxcEstadoCuentaAntiguedad(
 Estacion		int			NOT NULL,
 Moneda			varchar(10) NULL,
 Cuenta			varchar(10) NULL,
 Mov			varchar(20) NULL,
 MovID			varchar(20) NULL,
 ModuloID		int			NULL,
 Saldo			money		NULL,
 Vencimiento	datetime	NULL,
 MovTipo		varchar(20) NULL,
 Dias			int			NULL,
 Posfechado		money		NULL,
 AlCorriente	money		NULL,
 Plazo1			money		NULL,
 Plazo2			money		NULL,
 Plazo3			money		NULL,
 Plazo4			money		NULL,
 PlazoMayor		money		NULL,

 CONSTRAINT IX_espCxcEstadoCuentaAntiguedad PRIMARY KEY(Estacion)
)
GO

/****** espCxcEstadoCuentaClaveClientes ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='espCxcEstadoCuentaClaveClientes' and type ='U')
CREATE TABLE espCxcEstadoCuentaClaveClientes(
 Estacion		int			NOT NULL,
 Cliente		varchar(10) NULL,
 Moneda			varchar(10)	NULL,

 CONSTRAINT IX_espCxcEstadoCuentaClaveClientes PRIMARY KEY(Estacion)
)
GO

/****** espCxcEstadoCuentaAux ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='espCxcEstadoCuentaAux' and type ='U')
CREATE TABLE espCxcEstadoCuentaAux(
 Estacion		int			NOT NULL,
 AuxiliarID		int			NULL,
 Moneda			varchar(10)	NULL,
 Cliente		varchar(10)	NULL,
 IDMov			int			NULL,
 Mov			varchar(20) NULL,
 MovID			varchar(20) NULL,
 FechaEmision	datetime	NULL,
 Cargo			money		NULL,
 Abono			money		NULL,
 TipoCambio		float		NULL,
 Dias			int			NULL,
 IDAplica		int			NULL,
 Aplica			varchar(20) NULL,
 AplicaID		varchar(20) NULL,

 CONSTRAINT IX_espCxcEstadoCuentaAux PRIMARY KEY(Estacion)
)
GO

/****** espCxcEstadoCuentaSaldos ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='espCxcEstadoCuentaSaldos' and type ='U')
CREATE TABLE espCxcEstadoCuentaSaldos(
 Estacion		int			NOT NULL,
 Cliente		varchar(10) NULL,
 Moneda			varchar(10) NULL,
 Inicial		money		NULL,
 Final			money		NULL,
 Posfechado		money		NULL,
 AlCorriente	money		NULL,
 Rango1			money		NULL,
 Rango2			money		NULL,
 Rango3			money		NULL,
 Rango4			money		NULL,
 RangoMayor		money		NULL,
 CargosA		money		NULL,
 AbonosA		money		NULL,

 CONSTRAINT IX_espCxcEstadoCuentaSaldos PRIMARY KEY(Estacion)
)
GO

/****** espCxcEstadoCuenta ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='espCxcEstadoCuenta' and type ='U')
CREATE TABLE espCxcEstadoCuenta(
 ID				int			identity(1,1),
 Estacion		int			NULL,
 Cliente		varchar(10) NULL,
 EnviarA		int			NULL,
 Moneda			varchar(10) NULL,
 AuxiliarID		int			NULL,
 IDMov			int			NULL,
 Mov			varchar(20) NULL,
 MovID			varchar(20) NULL,
 FechaEmision	datetime	NULL,
 Cargo			money		NULL,
 Abono			money		NULL,
 TipoCambio		float		NULL,
 Vencimiento	datetime	NULL,
 Dias			int			NULL,
 IDAplica		int			NULL,
 Aplica			varchar(20) NULL,
 AplicaID		varchar(20) NULL,
 FechaAplica	datetime	NULL,
 SaldoInicial	money		NULL,
 SaldoFinal		money		NULL,
 Posfechado		money		NULL,
 AlCorriente	money		NULL,
 Rango1			money		NULL,
 Rango2			money		NULL,
 Rango3			money		NULL,
 Rango4			money		NULL,
 RangoMayor		money		NULL,
 CargoA			money		NULL,
 AbonosA			money		NULL,
 SaldoMovil		money		NULL,

CONSTRAINT PK_espCxcEstadoCuenta PRIMARY KEY(ID)
)
GO

/********************************************************************** Recibos Nomina ******************************************************************/

/****** LogRecibosNomina ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='LogRecibosNomina' and type ='U')
CREATE TABLE LogRecibosNomina(
	ID				int identity,
	Usuario			varchar(20),
	IDUsuarioTipo	int,
	[Hash]			varchar(MAX),
	API				varchar(MAX),
	Data			varchar(MAX),
	Descripcion		varchar(MAX),
	FechaRegistro	datetime default CURRENT_TIMESTAMP
)
GO


/********************************************************************** Comunicados **********************************************************************/
/****** pNetComunicado ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetComunicado' and type ='U')
CREATE TABLE pNetComunicado(
	IDComunicado	int NOT NULL identity(1,1),
	Titulo			varchar(60),
	Registro		varchar(10),
	DirigidoA		varchar(15),
	FechaRegistro	datetime,
	FechaPublicado	datetime,
	FechaVigencia	datetime,	
	Descripcion		varchar(255),
	Prioridad		varchar(15),
	--IDAnexo		int,
	Tipo			int,
	Estatus			bit

	CONSTRAINT PK_pNetComunicado PRIMARY KEY(IDComunicado)
)
GO

/****** pNetCatComunicado ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetCatComunicado' and type ='U')
CREATE TABLE pNetCatComunicado(
	IDCatCom		int NOT NULL identity(1,1),
	Descripcion		varchar(100)
)
GO

/****** LLenado de pNetCatComunicado *********/
IF NOT EXISTS(SELECT 1 FROM pNetCatComunicado)
BEGIN
	INSERT INTO pNetCatComunicado values('General')
	INSERT INTO pNetCatComunicado values('Moroso')
	INSERT INTO pNetCatComunicado values('Aviso')
	INSERT INTO pNetCatComunicado values('Legal')
	INSERT INTO pNetCatComunicado values('Reunión')
END
GO


/****** pNetComunicadoXPerfil ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetComunicadoXPerfil' and type ='U')
CREATE TABLE pNetComunicadoXPerfil(
	IDComunicado	int NOT NULL,
	IDUsuarioTipo	int NOT NULL
)
GO


/****** pNetComunicadoXUsuario ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetComunicadoXUsuario' and type ='U')
CREATE TABLE pNetComunicadoXUsuario(
	IDComunicado	int			NOT NULL,
	Usuario			varchar(10) NOT NULL,
	IDUsuarioTipo	int			NOT NULL
)
GO

/*****PortalNetCfg*****/
IF EXISTS(SELECT * FROM sysobjects where name ='PortalNetCfg' and type ='U') DROP TABLE PortalNetCfg
GO
CREATE TABLE PortalNetCfg(
	ID			int			 IDENTITY(1,1),
	Empresa		varchar(5)   NULL,
	URL			varchar(255) NULL,
	Descripcion varchar(80)  NULL,
	Estatus		varchar(15)  NOT NULL
 
 CONSTRAINT priPortalNetCfg PRIMARY KEY CLUSTERED (ID)
)
GO 

EXEC spALTER_TABLE 'PortalNetCfg', 'VisiblePara', 'varchar(10) NULL'

GO
 /****** AnexoBase64 ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='AnexoBase64' and type ='U')
CREATE TABLE AnexoBase64(
	ID			int			 NOT NULL IDENTITY,
	AnexoBase64	nchar(8)	 NOT NULL CONSTRAINT IX_AnexoBase64 UNIQUE NONCLUSTERED, 
	Archivo		varchar(MAX),
	
	CONSTRAINT priAnexoBase64 PRIMARY KEY CLUSTERED (ID)
 )
GO

EXEC spALTER_TABLE 'AnexoBase64', 'Rama', 'varchar(5) NULL'
GO
EXEC spALTER_TABLE 'AnexoBase64', 'IDR',  'int NULL'
GO
/******* pNetAnexoComunicado ***********/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetAnexoComunicado' and type ='U')
CREATE TABLE pNetAnexoComunicado(
  IDComunicado	int			 NOT NULL ,
  AnexoBase64	nchar(16)    NOT NULL,
  Nombre		varchar(100) NULL,
  Extension		varchar(5)   NULL,
  MimeType		varchar(100) NULL,
  Size			int			 NULL

 CONSTRAINT priAnexoComunicado PRIMARY KEY  CLUSTERED (IDComunicado,AnexoBase64)
)
GO
GO

/********************************************************************** Amenidades **********************************************************************/
/****** Amenidades ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='Amenidades' and type ='U')
CREATE TABLE Amenidades(
    ID				int identity(1,1),
    Espacio			varchar(10)  NOT NULL,
	DiaCompletoHora varchar(20)  NOT NULL,
	FechaRegistro	datetime	 NOT null,
    FechaDesde		datetime	 NOT null,
	FechaHasta		datetime	 NOT null,
    NumPersonas		int			 NOT null,
    Cliente			varchar(20)	 NOT null,
    NomCteInquilino varchar(100) NOT null,
    Vivienda		varchar(20)  NULL,
    Telefono		varchar(100) NULL,
    eMail			varchar(255) NOT null,
    Observaciones	varchar(255) NOT null

    CONSTRAINT priAmenidades PRIMARY KEY CLUSTERED(ID, Espacio, Cliente, FechaDesde, FechaHasta)
)
GO
/***************************** Alteracion de Tabla Amenidades *****************************/
EXEC spALTER_TABLE 'Amenidades', 'Mov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Amenidades', 'MovID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Amenidades', 'IDMovDet', 'INT NULL'
GO

/****** AmenidadesHorario ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='AmenidadesHorario' and type ='U')
CREATE TABLE AmenidadesHorario(
	IDAmenidades	int			NOT NULL,
    Horario			varchar(50) NOT NULL,
)
GO

/********************************************************************** Eventualidades **********************************************************************/

/****** pNetEventualidades ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetEventualidades' and type ='U')
CREATE TABLE pNetEventualidades(
    ID				int identity(1,1),
	Fecha			datetime     NULL,
	Tipo			varchar(50)  NULL,
	Identificacion  varchar(100) NULL,
	Acomp			varchar(255) NULL,
	Apartamento		varchar(100) NULL,
	Cliente			varchar(10)  NULL,
	Torre			varchar(100) NULL,
	Matricula		varchar(20)  NULL,
	Cajon			varchar(50)  NULL,
	Comentarios		varchar(max) NULL,

	CONSTRAINT PK_pNetEventualidades PRIMARY KEY(ID)
)
GO

EXEC spALTER_TABLE 'pNetEventualidades', 'Tipo', 'varchar(50) NULL'
GO

/****** pNetTipoEventualidades ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='pNetTipoEventualidades' and type ='U')
CREATE TABLE pNetTipoEventualidades(
	Tipo			varchar(50) NOT NULL,

	CONSTRAINT PK_pNetTipoEventualidades PRIMARY KEY(Tipo)
)
GO

IF NOT EXISTS(SELECT 1 FROM pNetTipoEventualidades)
BEGIN
  INSERT INTO pNetTipoEventualidades (Tipo) SELECT 'Acceso Visita'
  INSERT INTO pNetTipoEventualidades (Tipo) SELECT 'Salida Vista'
  INSERT INTO pNetTipoEventualidades (Tipo) SELECT 'Reparaciones'
  INSERT INTO pNetTipoEventualidades (Tipo) SELECT 'Otro'
END
GO

/********************************************************************** Configuraciones PortalNet **********************************************************************/
/****** PortalNetCfgXUsuario ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='PortalNetCfgXUsuario' and type ='U')
CREATE TABLE PortalNetCfgXUsuario(
 Empresa		varchar(5)  NULL,
 Descripcion	varchar(80) NULL,
 IDUsuario		int			NULL)
GO

/****** PortalNetCfgXPerfil ******/
IF NOT EXISTS(SELECT * FROM sysobjects where name ='PortalNetCfgXPerfil' and type ='U')
CREATE TABLE PortalNetCfgXPerfil(
 Empresa		varchar(5)  NULL,
 Descripcion	varchar(80) NULL,
 IDUsuarioTipo	int			NULL)
GO
