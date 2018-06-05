
/*******************************************************************************************/
/*                                         Campañas                           	           */
/*******************************************************************************************/
EXEC spDROP_TABLE 'ContactoTipo', 2872
EXEC spDROP_TABLE 'ContactoCat', 2872
EXEC spDROP_TABLE 'ContactoGrupo', 2872
EXEC spDROP_TABLE 'ContactoFam', 2872
EXEC spDROP_TABLE 'ContactoOrigen', 2872
EXEC spDROP_TABLE 'Contacto', 2872
EXEC spDROP_TABLE 'Prospecto', 2872
EXEC spDROP_TABLE 'ProspectoCat', 2876
EXEC spDROP_TABLE 'ProspectoGrupo', 2876
EXEC spDROP_TABLE 'ProspectoFam', 2876
EXEC spDROP_TABLE 'ProspectoCtoGrupo', 2876
EXEC spDROP_TABLE 'CMP', 2872
EXEC spDROP_TABLE 'CMPD', 2872
EXEC spDROP_TABLE 'CMPC', 2872
EXEC spDROP_TABLE 'CMPEstado', 2872
EXEC spDROP_TABLE 'CampanaPlan', 3043
EXEC spDROP_TABLE 'CampanaPlanPuesto', 3043
EXEC spDROP_TABLE 'CampanaPlanFiltroCampo', 3043
EXEC spDROP_TABLE 'CampanaPlanFiltroForma', 3043
EXEC spDROP_TABLE 'CampanaPlanCorreo', 3043
EXEC spDROP_TABLE 'Campana', 3045
EXEC spDROP_TABLE 'CampanaD', 3047
EXEC spDROP_TABLE 'CampanaRecurso', 3045
EXEC spDROP_TABLE 'CampanaPlantillaTarea', 3045
EXEC spDROP_TABLE 'CampanaPlantilla', 3045
EXEC spDROP_TABLE 'CampanaTipoEvaluacion', 3045
GO
if exists (select * from sysobjects where id = object_id('dbo.spCampanaPlanPuesto') and type = 'P') drop procedure dbo.spCampanaPlanPuesto
GO
if exists (select * from sysobjects where id = object_id('dbo.spCampanaPlanFiltroCampo') and type = 'P') drop procedure dbo.spCampanaPlanFiltroCampo
GO
if exists (select * from sysobjects where id = object_id('dbo.spCampanaPlanFiltroForma') and type = 'P') drop procedure dbo.spCampanaPlanFiltroForma
GO
EXEC spDROP_TABLE 'CampanaTipoEstado', 3056
EXEC spDROP_TABLE 'CampanaTipoEncuesta', 3047
EXEC spDROP_TABLE 'CampanaTipo', 3062
EXEC spDROP_TABLE 'CampanaD', 3062
EXEC spDROP_TABLE 'CampanaEvento', 3073
EXEC spDROP_TABLE 'CampanaDEncuesta', 3047
EXEC spDROP_TABLE 'CampanaEncuesta', 3047
EXEC spDROP_TABLE 'CampanaDEvento', 3051
EXEC spDROP_TABLE 'CampanaCorreo', 3061
GO

/****** Profesion ******/
if not exists(select * from SysTabla where SysTabla = 'Profesion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Profesion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Profesion') and type = 'U') 
CREATE TABLE dbo.Profesion (
	Profesion		varchar(50)  	NOT NULL,

	CONSTRAINT priProfesion PRIMARY KEY  CLUSTERED (Profesion)
)
go

/****** Industria ******/
if not exists(select * from SysTabla where SysTabla = 'Industria')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Industria','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Industria') and type = 'U') 
CREATE TABLE dbo.Industria (
	Industria		varchar(50)  	NOT NULL,

	CONSTRAINT priIndustria PRIMARY KEY  CLUSTERED (Industria)
)
go


/****** IndustriaGiro ******/
if not exists(select * from SysTabla where SysTabla = 'IndustriaGiro')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('IndustriaGiro','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.IndustriaGiro') and type = 'U') 
CREATE TABLE dbo.IndustriaGiro (
	Industria		varchar(50)  	NOT NULL,
	Giro			varchar(50)  	NOT NULL,

	CONSTRAINT priIndustriaGiro PRIMARY KEY  CLUSTERED (Industria, Giro)
)
go

/*** ProspectoTipo ***/
if not exists(select * from SysTabla where SysTabla = 'ProspectoTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProspectoTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProspectoTipo') and type = 'U') 
CREATE TABLE dbo.ProspectoTipo (
	Tipo		varchar(20)	NOT NULL,
	Orden		int		NULL,

	CONSTRAINT priProspectoTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

EXEC spFK 'Prospecto','Agente','Agente','Agente'
EXEC spFK 'Prospecto','SIC','SIC','SIC'
GO

/*** ProspectoOrigen ***/
if exists (select * from sysobjects where id = object_id('dbo.ProspectoOrigen') and type = 'V') drop view dbo.ProspectoOrigen
GO
if not exists(select * from SysTabla where SysTabla = 'ProspectoOrigen')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProspectoOrigen','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProspectoOrigen') and type = 'U') 
CREATE TABLE dbo.ProspectoOrigen (
	Origen		varchar(50)	NOT NULL,

	CONSTRAINT priProspectoOrigen PRIMARY KEY  CLUSTERED (Origen)
)
GO

/****** SIC  ******/
if not exists(select * from SysTabla where SysTabla = 'SIC')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SIC','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SIC') and type = 'U') 
CREATE TABLE dbo.SIC (
	SIC			varchar(10)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Industria		varchar(50)  	NULL,
	Giro			varchar(50)  	NULL,
	AgentePorOmision	varchar(10)	NULL,

 	CONSTRAINT priSIC PRIMARY KEY  CLUSTERED (SIC)
)
GO
EXEC spADD_INDEX 'SIC', 'Nombre', 'Nombre'
GO
EXEC spALTER_TABLE 'SIC', 'AgentePorOmision', 'varchar(10) NULL'
GO

EXEC spFK 'SIC','AgentePorOmision','Agente','Agente'
GO

/*** ProspectoInteresadoEn ***/
if exists (select * from sysobjects where id = object_id('dbo.ProspectoInteresadoEn') and type = 'V') drop view dbo.ProspectoInteresadoEn
GO
if not exists(select * from SysTabla where SysTabla = 'ProspectoInteresadoEn')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProspectoInteresadoEn','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProspectoInteresadoEn') and type = 'U') 
CREATE TABLE dbo.ProspectoInteresadoEn (
	InteresadoEn		varchar(100)	NOT NULL,

	Articulo		varchar(20)	NULL,
	
	--REQ 13389
	CRMID			varchar(36) NULL,

	CONSTRAINT priProspectoInteresadoEn PRIMARY KEY  CLUSTERED (InteresadoEn)
)
GO

--REQ 13389
EXEC spALTER_TABLE 'ProspectoInteresadoEn', 'CRMID', 'varchar(36) NULL'
GO

--REQ 13389
if exists (select * from sysobjects where id = object_id('dbo.tgProspectoInteresadoEnABC_CRM') and sysstat & 0xf = 8) drop trigger dbo.tgProspectoInteresadoEnABC_CRM
GO
CREATE TRIGGER tgProspectoInteresadoEnABC_CRM ON ProspectoInteresadoEn
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @ProspectoInteresadoEnI  		varchar(10),
    @ProspectoInteresadoEnD		varchar(10),
    @CRMII			varchar(36),
    @CRMID			varchar(36),
    @Datos			varchar(max),
    @Usuario		varchar(10),
    @Contrasena		varchar(32),
    @Ok				int,
    @OkRef			varchar(255),
    @IDIS			int,
    
    @Accion			varchar(20),
    @ArticuloI		varchar(25),
    @ArticuloD		varchar(25),
    @Precio			varchar(25)  

  IF dbo.fnEstaSincronizandoCRM() = 1
    RETURN
     
   SELECT
     @Usuario    = Usuario,
     @Contrasena = Contrasena
   FROM CfgCRM
  
  SELECT @ArticuloI = Articulo, @CRMII = CRMID FROM Inserted  
  SELECT @ArticuloD = Articulo, @CRMII = CRMID FROM Deleted
  SELECT @Precio = PrecioLista FROM Art WHERE Articulo = ISNULL(@ArticuloI, @ArticuloD)
  
  IF @CRMII IS NULL AND @CRMID IS NULL
    RETURN

  IF @CRMII IS NOT NULL AND @CRMID IS NULL
    SELECT @Accion = 'INSERT'
  ELSE  
  IF @CRMII IS NOT NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'UPDATE'
  ELSE  
  IF @CRMII IS NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'DELETE'
  ELSE
    RETURN
    
  SELECT @Datos = '<Intelisis Sistema="IntelisisCRM" Contenido="Solicitud" Referencia="IntelisisCRM.CRM" SubReferencia="" Version="1.0">' + '<Solicitud>' + '<' + @Accion + '>'
     
  IF @ArticuloD IS NULL OR @ArticuloD = @ArticuloI
    SELECT @Datos = @Datos + (SELECT Articulo, CRMID, InteresadoEn, @Precio AS 'PrecioLista' FROM Inserted ProspectoInteresadoEn FOR XML AUTO)
  ELSE
    SELECT @Datos = @Datos + (SELECT Articulo, CRMID, InteresadoEn, @Precio AS 'PrecioLista' FROM Deleted ProspectoInteresadoEn FOR XML AUTO)
     
  SELECT @Datos = @Datos + '</' + @Accion + '></Solicitud></Intelisis>'
         
  EXEC spIntelisisService @Usuario, @Contrasena, @Datos, NULL, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IDIS OUTPUT
   
  RETURN
END
GO

/*** ProspectoTarea ***/
if exists (select * from sysobjects where id = object_id('dbo.ProspectoTarea') and type = 'V') drop view dbo.ProspectoTarea
GO
if not exists(select * from SysTabla where SysTabla = 'ProspectoTarea')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProspectoTarea','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProspectoTarea') and type = 'U') 
CREATE TABLE dbo.ProspectoTarea (
	Tarea			varchar(100)	NOT NULL,
	
	Orden			int		NULL,
	EsFinal			bit		NULL DEFAULT 0,

	CONSTRAINT priProspectoTarea PRIMARY KEY  CLUSTERED (Tarea)
)
GO
EXEC spADD_INDEX 'ProspectoTarea', 'Orden', 'Orden'
GO

/****** Contactos del Prospecto ******/
if not exists(select * from SysTabla where SysTabla = 'ProspectoCto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProspectoCto','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ProspectoCto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ProspectoCto (
	Prospecto		varchar(10) 	NOT NULL,
	ID			int 		NOT NULL IDENTITY(1,1),

	Nombre			varchar(100)	NULL,
	ApellidoPaterno		varchar(30)	NULL,
	ApellidoMaterno		varchar(30)	NULL,
	Atencion		varchar(50)	NULL,
	Tratamiento		varchar(20)	NULL,
	Cargo			varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	FechaNacimiento		datetime	NULL,
	Telefonos		varchar(100)	NULL,
	Extencion		varchar(20)	NULL,
	eMail			varchar(100)	NULL,
	Fax 			varchar(50) 	NULL,
	PedirTono		bit           	NULL DEFAULT 0,
	Tipo			varchar(20)	NULL,
	Sexo			varchar(20)	NULL,
	Usuario			varchar(10)	NULL,
	
	--REQ 13389
	CRMID			varchar(36) NULL,
	AccountId		varchar(36) NULL,

	CONSTRAINT priProspectoCto PRIMARY KEY  CLUSTERED (Prospecto, ID)
  )
  EXEC spSincroSemilla 'ProspectoCto'
END
go

--REQ 13389
EXEC spALTER_TABLE 'ProspectoCto', 'CRMID', 'varchar(36) NULL'
EXEC spALTER_TABLE 'ProspectoCto', 'AccountId', 'varchar(36) NULL'
GO

--REQ 13389
if exists (select * from sysobjects where id = object_id('dbo.tgProspectoCtoABC_CRM') and sysstat & 0xf = 8) drop trigger dbo.tgProspectoCtoABC_CRM
GO
CREATE TRIGGER tgProspectoCtoABC_CRM ON ProspectoCto
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @ProspectoI  		varchar(10),
    @ProspectoD		varchar(10),
    @CRMII			varchar(36),
    @CRMID			varchar(36),
    @Datos			varchar(max),
    @Usuario		varchar(10),
    @Contrasena		varchar(32),
    @Ok				int,
    @OkRef			varchar(255),
    @IDIS			int,
    
    @Accion			varchar(20)

  IF dbo.fnEstaSincronizandoCRM() = 1
    RETURN
     
   SELECT
     @Usuario    = Usuario,
     @Contrasena = Contrasena
   FROM CfgCRM
  
  SELECT @ProspectoI = Prospecto, @CRMII = CRMID FROM Inserted
  SELECT @ProspectoD = Prospecto, @CRMID = CRMID FROM Deleted  
  
  IF (@CRMII IS NULL AND @CRMID IS NULL) OR (NOT EXISTS(SELECT Prospecto FROM Prospecto WHERE Prospecto = ISNULL(@ProspectoI,@ProspectoD) AND Tipo = 'Cliente'))
    RETURN

  IF @CRMII IS NOT NULL AND @CRMID IS NULL
    SELECT @Accion = 'INSERT'
  ELSE  
  IF @CRMII IS NOT NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'UPDATE'
  ELSE  
  IF @CRMII IS NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'DELETE'
  ELSE
    RETURN
    
  SELECT @Datos = '<Intelisis Sistema="IntelisisCRM" Contenido="Solicitud" Referencia="IntelisisCRM.CRM" SubReferencia="" Version="1.0">' + '<Solicitud>' + '<' + @Accion + '>'

  IF @ProspectoD IS NULL OR @ProspectoD = @ProspectoI
    SELECT @Datos = @Datos + (SELECT ApellidoMaterno, ApellidoPaterno, Atencion, Cargo, CRMID, eMail, Extencion, Fax, FechaNacimiento, Grupo, ID, Nombre, PedirTono, Prospecto, Sexo, Telefonos, Tipo, Tratamiento, Usuario, AccountId FROM Inserted ProspectoCto FOR XML AUTO)
  ELSE
    SELECT @Datos = @Datos + (SELECT ApellidoMaterno, ApellidoPaterno,  Atencion, Cargo, CRMID, eMail, Extencion, Fax, FechaNacimiento, Grupo, ID, Nombre, PedirTono, Prospecto, Sexo, Telefonos, Tipo, Tratamiento, Usuario, AccountId FROM Deleted ProspectoCto FOR XML AUTO)
     
  SELECT @Datos = @Datos + '</' + @Accion + '></Solicitud></Intelisis>'
  
  DELETE CteCto WHERE Cliente = ISNULL(@ProspectoI, @ProspectoD)
  INSERT INTO CteCto             (Cliente, Nombre, Atencion, Tratamiento, Cargo, Grupo, FechaNacimiento, Telefonos, Extencion, eMail, Fax, PedirTono, ApellidoPaterno, ApellidoMaterno, Tipo, Sexo, Usuario)
  SELECT ISNULL(@ProspectoI, @ProspectoD), Nombre, Atencion, Tratamiento, Cargo, Grupo, FechaNacimiento, Telefonos, Extencion, eMail, Fax, PedirTono, ApellidoPaterno, ApellidoMaterno, Tipo, Sexo, Usuario
    FROM inserted
  
  EXEC spIntelisisService @Usuario, @Contrasena, @Datos, NULL, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IDIS OUTPUT
   
  RETURN
END
GO

/****** Prospecto ******/
if not exists(select * from SysTabla where SysTabla = 'Prospecto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Prospecto','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Prospecto') and type = 'U') 
CREATE TABLE dbo.Prospecto (
	Prospecto		varchar(10) 	NOT NULL,

	Nombre 			varchar(100)    NULL,
	Direccion 		varchar(100) 	NULL,
	DireccionNumero		varchar(20)	NULL,
	DireccionNumeroInt	varchar(20)	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Delegacion		varchar(100) 	NULL,
	Colonia 		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	Zona 			varchar(30) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	RFC 			varchar(15)     NULL,
	CURP			varchar(30)     NULL,
	Telefonos		varchar(100) 	NULL,
	TelefonosLada		varchar(6)	NULL,
	Fax 			varchar(50) 	NULL,
	PedirTono		bit           	NULL DEFAULT 0,
    	PaginaWeb		varchar(100)	NULL,
	eMail			varchar(50) 	NULL,
    	Comentarios		text		NULL,

	Categoria 		varchar(50) 	NULL,
	Grupo	 		varchar(50)	NULL,
	Familia 		varchar(50) 	NULL,
	Tipo			varchar(15)	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Estatus 		varchar(15) 	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,
	Usuario			varchar(10)	NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,

	SIC			varchar(10)	NULL,
	Origen			varchar(50)	NULL,
	Agente			varchar(10)	NULL,
	InteresadoEn		varchar(100)	NULL,	

	CargaRID		int		NULL,
	--REQ 13389
	ApellidoMaterno		varchar(40)		NULL,
	ApellidoPaterno		varchar(40)		NULL,
	NombreCompleto		varchar(40)		NULL,
	SincronizarCRM		bit				NULL DEFAULT 0,
	CRMID				uniqueidentifier	NULL,
	AccountId			varchar(36)		NULL,
	TemaCRM				varchar(36)		NULL,

	CONSTRAINT priProspecto PRIMARY KEY  CLUSTERED (Prospecto)
)
GO
EXEC spALTER_TABLE 'Prospecto', 'CargaRID', 'int NULL'
EXEC spALTER_TABLE 'Prospecto', 'eMail', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Prospecto', 'InteresadoEn', 'varchar(100) NULL'
GO
EXEC spADD_INDEX 'Prospecto', 'Nombre', 'Nombre'
EXEC spADD_INDEX 'Prospecto', 'CargaRID', 'CargaRID'
GO

/**************** WebPaginaIndicador ****************/
-- Author:			Yessenia Villacis
-- Create date:		15-Dic-2008
EXEC spALTER_TABLE 'Prospecto', 'NombreComercial', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Prospecto', 'GrupoEmpresarial', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Prospecto', 'ReferidoNombre', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Prospecto', 'ReferidoMail', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Prospecto', 'ReferidoTelefono', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Prospecto', 'ReferidoRFC', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Prospecto', 'EmpresaTipo', 'varchar(20) NULL'                 --(Pyme – grande - medianaa)
EXEC spALTER_TABLE 'Prospecto', 'Fuente', 'varchar(20) NULL'                      --(Telemarke / Anuncio / Campaña)

EXEC spALTER_TABLE 'Prospecto', 'RelacionReferencia', 'varchar(40) NULL'
GO
-------------------------------------------------------

--REQ 13389
EXEC spALTER_TABLE 'Prospecto', 'ApellidoMaterno', 'varchar(40) NULL'
EXEC spALTER_TABLE 'Prospecto', 'ApellidoPaterno', 'varchar(40) NULL'
EXEC spALTER_TABLE 'Prospecto', 'NombreCompleto', 'varchar(40) NULL'
EXEC spALTER_TABLE 'Prospecto', 'SincronizarCRM', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Prospecto', 'CRMID', 'uniqueidentifier NULL'
EXEC spALTER_TABLE 'Prospecto', 'AccountId', 'varchar(36) NULL'
EXEC spALTER_TABLE 'Prospecto', 'TemaCRM', 'varchar(36) NULL'
GO
if exists (select * from sysobjects where id = object_id('dbo.tgProspectoBC') and sysstat & 0xf = 8) drop trigger dbo.tgProspectoBC
GO
CREATE TRIGGER tgProspectoBC ON Prospecto
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ProspectoN varchar(10),
    @ProspectoA	varchar(10),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ProspectoN = Prospecto FROM Inserted
  SELECT @ProspectoA = Prospecto FROM Deleted
  IF @ProspectoN = @ProspectoA RETURN

  IF @ProspectoN IS NULL 
  BEGIN
    DELETE ProspectoCto WHERE Prospecto = @ProspectoA
  END ELSE
  IF @ProspectoA IS NOT NULL 
  BEGIN
    UPDATE ProspectoCto SET Prospecto = @ProspectoN WHERE Prospecto = @ProspectoA
  END
END
GO

--REQ 13389
if exists (select * from sysobjects where id = object_id('dbo.tgProspectoABC_CRM') and sysstat & 0xf = 8) drop trigger dbo.tgProspectoABC_CRM
GO
CREATE TRIGGER tgProspectoABC_CRM ON Prospecto
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @ProspectoI  		varchar(10),
    @ProspectoD			varchar(10),
    @CRMII				varchar(36),
    @CRMID				varchar(36),
    @Datos				varchar(max),
    @Usuario			varchar(10),
    @Contrasena			varchar(32),
    @Ok					int,
    @OkRef				varchar(255),
    @IDIS				int,
    
    @Accion				varchar(20),
    @TipoI				varchar(25),
    @TipoD				varchar(25),
    @SincronizarCRMI	bit,
    @SincronizarCRMD	bit,
    @EstatusI			varchar(15),
    @EstatusD			varchar(15)

  IF dbo.fnEstaSincronizandoCRM() = 1
    RETURN
     
  SELECT
    @Usuario    = Usuario,
    @Contrasena = Contrasena
    FROM CfgCRM
  
  SELECT @ProspectoI = Prospecto, @CRMII = CRMID, @TipoI = Tipo, @SincronizarCRMI = SincronizarCRM, @EstatusI = Estatus FROM Inserted
  SELECT @ProspectoD = Prospecto, @CRMID = CRMID, @TipoD = ISNULL(Tipo,@TipoI), @SincronizarCRMD = SincronizarCRM, @EstatusD = Estatus FROM Deleted  
  
  IF (@CRMII IS NULL AND @CRMID IS NULL) OR (@TipoI <> 'Contacto' AND @SincronizarCRMI = 0  AND @EstatusI <> 'ALTA')
    RETURN

  IF @CRMII IS NOT NULL AND @CRMID IS NULL
    SELECT @Accion = 'INSERT'
  ELSE  
  IF @CRMII IS NOT NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'UPDATE'
  ELSE  
  IF @CRMII IS NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'DELETE'
  ELSE
    RETURN
    
  SELECT @Datos = '<Intelisis Sistema="IntelisisCRM" Contenido="Solicitud" Referencia="IntelisisCRM.CRM" SubReferencia="" Version="1.0">' + '<Solicitud>' + '<' + @Accion + '>'
     
  IF @TipoI = @TipoD and @SincronizarCRMI = 1
  BEGIN
    IF @ProspectoD IS NULL OR @ProspectoD = @ProspectoI
       SELECT @Datos = @Datos + (SELECT AccountId, Agente, Alta, ApellidoMaterno, ApellidoPaterno, CargaRID, Categoria, CodigoPostal, Colonia, CRMID, CURP, Delegacion, Direccion, DireccionNumero, DireccionNumeroInt, eMail, EmpresaTipo, EntreCalles, Estado, Estatus, Familia, Fax, Fuente, Grupo, GrupoEmpresarial, InteresadoEn, Nombre, NombreComercial, NombreCompleto, Observaciones, Origen, PaginaWeb, Pais, PedirTono, Plano, Poblacion, Prospecto, ReferidoMail, ReferidoNombre, ReferidoRFC, ReferidoTelefono, RelacionReferencia, RFC, SIC, SincronizarCRM, Situacion, SituacionFecha, SituacionNota, SituacionUsuario, Telefonos, TelefonosLada, TemaCRM, TieneMovimientos, Tipo, UltimoCambio, Usuario, Zona FROM Inserted Contacto FOR XML AUTO)
    ELSE
    BEGIN
      IF @SincronizarCRMI = 1 AND @SincronizarCRMD = 0  
        SELECT @Datos = ''
      ELSE
        SELECT @Datos = @Datos + (SELECT AccountId, Agente, Alta, ApellidoMaterno, ApellidoPaterno, CargaRID, Categoria, CodigoPostal, Colonia, CRMID, CURP, Delegacion, Direccion, DireccionNumero, DireccionNumeroInt, eMail, EmpresaTipo, EntreCalles, Estado, Estatus, Familia, Fax, Fuente, Grupo, GrupoEmpresarial, InteresadoEn, Nombre, NombreComercial, NombreCompleto, Observaciones, Origen, PaginaWeb, Pais, PedirTono, Plano, Poblacion, Prospecto, ReferidoMail, ReferidoNombre, ReferidoRFC, ReferidoTelefono, RelacionReferencia, RFC, SIC, SincronizarCRM, Situacion, SituacionFecha, SituacionNota, SituacionUsuario, Telefonos, TelefonosLada, TemaCRM, TieneMovimientos, Tipo, UltimoCambio, Usuario, Zona FROM Deleted Contacto FOR XML AUTO)
    END
     
    SELECT @Datos = @Datos + '</' + @Accion + '></Solicitud></Intelisis>'         
    EXEC spIntelisisService @Usuario, @Contrasena, @Datos, NULL, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IDIS OUTPUT
  END
  ELSE
  BEGIN
    IF @ProspectoD IS NULL OR @ProspectoD = @ProspectoI
      SELECT @Datos = @Datos + (SELECT AccountId, Agente, Alta, ApellidoMaterno, ApellidoPaterno, CargaRID, Categoria, CodigoPostal, Colonia, CRMID, CURP, Delegacion, Direccion, DireccionNumero, DireccionNumeroInt, eMail, EmpresaTipo, EntreCalles, Estado, Estatus, Familia, Fax, Fuente, Grupo, GrupoEmpresarial, InteresadoEn, Nombre, NombreComercial, NombreCompleto, Observaciones, Origen, PaginaWeb, Pais, PedirTono, Plano, Poblacion, Prospecto, ReferidoMail, ReferidoNombre, ReferidoRFC, ReferidoTelefono, RelacionReferencia, RFC, SIC, SincronizarCRM, Situacion, SituacionFecha, SituacionNota, SituacionUsuario, Telefonos, TelefonosLada, TemaCRM, TieneMovimientos, Tipo, UltimoCambio, Usuario, Zona FROM Inserted Contacto FOR XML AUTO)
    ELSE
    BEGIN
      IF @SincronizarCRMI = 1 AND @SincronizarCRMD = 0  
        SELECT @Datos = ''
      ELSE
        SELECT @Datos = @Datos + (SELECT AccountId, Agente, Alta, ApellidoMaterno, ApellidoPaterno, CargaRID, Categoria, CodigoPostal, Colonia, CRMID, CURP, Delegacion, Direccion, DireccionNumero, DireccionNumeroInt, eMail, EmpresaTipo, EntreCalles, Estado, Estatus, Familia, Fax, Fuente, Grupo, GrupoEmpresarial, InteresadoEn, Nombre, NombreComercial, NombreCompleto, Observaciones, Origen, PaginaWeb, Pais, PedirTono, Plano, Poblacion, Prospecto, ReferidoMail, ReferidoNombre, ReferidoRFC, ReferidoTelefono, RelacionReferencia, RFC, SIC, SincronizarCRM, Situacion, SituacionFecha, SituacionNota, SituacionUsuario, Telefonos, TelefonosLada, TemaCRM, TieneMovimientos, Tipo, UltimoCambio, Usuario, Zona FROM Deleted Contacto FOR XML AUTO)
    END
     
    SELECT @Datos = @Datos + '</' + @Accion + '></Solicitud></Intelisis>'         
    EXEC spIntelisisService @Usuario, @Contrasena, @Datos, NULL, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IDIS OUTPUT
     
    SELECT @Datos = '<Intelisis Sistema="IntelisisCRM" Contenido="Solicitud" Referencia="IntelisisCRM.CRM" SubReferencia="" Version="1.0">' + '<Solicitud>' + '<' + @Accion + '>'
     
    IF @ProspectoD IS NULL OR @ProspectoD = @ProspectoI
      SELECT @Datos = @Datos + (SELECT AccountId, Agente, Alta, ApellidoMaterno, ApellidoPaterno, CargaRID, Categoria, CodigoPostal, Colonia, CRMID, CURP, Delegacion, Direccion, DireccionNumero, DireccionNumeroInt, eMail, EmpresaTipo, EntreCalles, Estado, Estatus, Familia, Fax, Fuente, Grupo, GrupoEmpresarial, InteresadoEn, Nombre, NombreComercial, NombreCompleto, Observaciones, Origen, PaginaWeb, Pais, PedirTono, Plano, Poblacion, Prospecto, ReferidoMail, ReferidoNombre, ReferidoRFC, ReferidoTelefono, RelacionReferencia, RFC, SIC, SincronizarCRM, Situacion, SituacionFecha, SituacionNota, SituacionUsuario, Telefonos, TelefonosLada, TemaCRM, TieneMovimientos, Tipo, UltimoCambio, Usuario, Zona FROM Inserted CuentaBorraLead FOR XML AUTO)
    ELSE
    BEGIN
      IF @SincronizarCRMI = 1 AND @SincronizarCRMD = 0  
        SELECT @Datos = ''
      ELSE
        SELECT @Datos = @Datos + (SELECT AccountId, Agente, Alta, ApellidoMaterno, ApellidoPaterno, CargaRID, Categoria, CodigoPostal, Colonia, CRMID, CURP, Delegacion, Direccion, DireccionNumero, DireccionNumeroInt, eMail, EmpresaTipo, EntreCalles, Estado, Estatus, Familia, Fax, Fuente, Grupo, GrupoEmpresarial, InteresadoEn, Nombre, NombreComercial, NombreCompleto, Observaciones, Origen, PaginaWeb, Pais, PedirTono, Plano, Poblacion, Prospecto, ReferidoMail, ReferidoNombre, ReferidoRFC, ReferidoTelefono, RelacionReferencia, RFC, SIC, SincronizarCRM, Situacion, SituacionFecha, SituacionNota, SituacionUsuario, Telefonos, TelefonosLada, TemaCRM, TieneMovimientos, Tipo, UltimoCambio, Usuario, Zona FROM Deleted CuentaBorraLead FOR XML AUTO)
    END
  END      
  RETURN
END
GO


/**************** spProspectoExpress ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProspectoExpress') and sysstat & 0xf = 4) drop procedure dbo.spProspectoExpress
GO
CREATE PROCEDURE spProspectoExpress
			@Prospecto	varchar(10),
			@Empresa	varchar(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Perfil		varchar(50),
    @Pagina		varchar(20),
    @Nombre		varchar(100),
    @ApellidoPaterno	varchar(30),
    @ApellidoMaterno	varchar(30),
    @Usuario		varchar(10),
    @eMail		varchar(100),
    @Para		varchar(255),
    @Mensaje		varchar(255),
    @Ok			int,
    @OkRef		varchar(255),
    @Asunto		varchar(100),
    @HTML		varchar(max),
    @Conteo		int,
    @Agente		varchar(10),
    @CC			varchar(255)

  SELECT @Mensaje = NULL, @Ok = NULL, @OkRef = NULL, @Conteo = 0
  SELECT @Pagina = NULLIF(RTRIM(ProspectoExpressPagina), ''), @Perfil = DBMailPerfil FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT @Asunto = Nombre, @HTML = CONVERT(varchar(max), HTML) FROM WebPagina WHERE Pagina = @Pagina
  SELECT @Usuario = NULLIF(RTRIM(p.Usuario), ''), @Agente = p.Agente, @CC = dbo.fnCorreoPara(a.Nombre, NULL, NULL, a.eMail)
    FROM Prospecto p
    LEFT OUTER JOIN Agente a ON a.Agente = p.Agente
   WHERE p.Prospecto = @Prospecto

  IF @Usuario IS NOT NULL
    SELECT @Perfil = ISNULL(NULLIF(RTRIM(DBMailPerfil), ''), @Perfil) FROM Usuario WHERE Usuario = @Usuario

  IF @Pagina IS NULL OR @Asunto IS NULL
    SELECT @Ok = 40006

  IF @Ok IS NULL
  BEGIN
    DECLARE crProspectoCto CURSOR LOCAL FOR
     SELECT Nombre, ApellidoPaterno, ApellidoMaterno, eMail
       FROM ProspectoCto
      WHERE Prospecto = @Prospecto

    OPEN crProspectoCto
    FETCH NEXT FROM crProspectoCto INTO @Nombre, @ApellidoPaterno, @ApellidoMaterno, @eMail
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Para = dbo.fnCorreoPara(@Nombre, @ApellidoPaterno, @ApellidoMaterno, @eMail)
        IF @Para IS NOT NULL
        BEGIN
          EXEC spWebPaginaParcear NULL, NULL, @Pagina, @Asunto OUTPUT, NULL, @HTML OUTPUT, NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT
          EXEC spEnviarDBMail @Perfil, @Para, @CC = @CC, @Asunto = @Asunto, @Mensaje = @HTML, @Formato = 'HTML'
          SELECT @Conteo = @Conteo + 1
        END
      END
      FETCH NEXT FROM crProspectoCto INTO @Nombre, @ApellidoPaterno, @ApellidoMaterno, @eMail
    END  -- While
    CLOSE crProspectoCto
    DEALLOCATE crProspectoCto
  END

  IF @Ok IS NULL
    SELECT @Mensaje = CONVERT(varchar, @Conteo)+' Correos Enviados.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  SELECT 'Mensaje' = @Mensaje
  RETURN
END
GO


/****** CampanaTipoSituacion ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaTipoSituacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampanaTipoSituacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaTipoSituacion') and type = 'U') 
  CREATE TABLE dbo.CampanaTipoSituacion (
	CampanaTipo		varchar(50)	NOT NULL,
	Situacion		varchar(50)	NOT NULL,

	Flujo			varchar(20)	NULL,		-- Inicial, Todas, Inicial Todas, Especial, Final

	Orden			int		NULL,
	Icono			int		NULL,

 	CONSTRAINT priCampanaTipoSituacion PRIMARY KEY  CLUSTERED (CampanaTipo, Situacion)
  )
GO
EXEC spALTER_TABLE 'CampanaTipoSituacion', 'Icono', 'int NULL'
EXEC spALTER_TABLE 'CampanaTipoSituacion', 'Flujo', 'varchar(20) NULL'
EXEC spAlter_Table 'CampanaTipoSituacion', 'AccionMovil','varchar(20) Null'
GO
/****** CampanaTipoSituacionTarea ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaTipoSituacionTarea')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampanaTipoSituacionTarea','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaTipoSituacionTarea') and type = 'U') 
  CREATE TABLE dbo.CampanaTipoSituacionTarea (
	CampanaTipo		varchar(50)	NOT NULL,
	Situacion		varchar(50)	NOT NULL,
	Tarea			varchar(100)	NOT NULL,
	Dias			float		NULL,

	Orden			int		NULL,

 	CONSTRAINT priCampanaTipoSituacionTarea PRIMARY KEY  CLUSTERED (CampanaTipo, Situacion, Tarea)
  )
GO
EXEC spALTER_TABLE 'CampanaTipoSituacionTarea', 'Dias', 'float NULL'
GO

-- drop table CampanaTipoEncuesta
/****** CampanaTipoEncuesta ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaTipoEncuesta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampanaTipoEncuesta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaTipoEncuesta') and type = 'U') 
  CREATE TABLE dbo.CampanaTipoEncuesta (
	CampanaTipo		varchar(50)	NOT NULL,
	Campo			varchar(50)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	Orden			int		NULL,

	Tipo			varchar(20)	NULL,	-- Evaluacion, Datos

	TablaEvaluacion		varchar(20)	NULL,
	Peso			float		NULL,

 	CONSTRAINT priCampanaTipoEncuesta PRIMARY KEY  CLUSTERED (CampanaTipo, Campo)
  )
GO

/****** CampanaTipoEncuestaLista ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaTipoEncuestaLista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampanaTipoEncuestaLista','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaTipoEncuestaLista') and type = 'U') 
  CREATE TABLE dbo.CampanaTipoEncuestaLista (
	CampanaTipo		varchar(50)	NOT NULL,
	Campo			varchar(50)	NOT NULL,
	Valor			varchar(255)	NOT NULL,

	Orden			int		NULL,

 	CONSTRAINT priCampanaTipoEncuestaLista PRIMARY KEY  CLUSTERED (CampanaTipo, Campo, Valor)
  )
GO

/****** CampanaTipoCargo ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaTipoCargo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampanaTipoCargo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaTipoCargo') and type = 'U') 
  CREATE TABLE dbo.CampanaTipoCargo (
	CampanaTipo		varchar(50)	NOT NULL,
	Cargo			varchar(50)	NOT NULL,	

 	CONSTRAINT priCampanaTipoCargo PRIMARY KEY  CLUSTERED (CampanaTipo, Cargo)
  )
GO
-- drop table CampanaTipoCalificacion
/****** CampanaTipoCalificacion ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaTipoCalificacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampanaTipoCalificacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaTipoCalificacion') and type = 'U') 
  CREATE TABLE dbo.CampanaTipoCalificacion (
	CampanaTipo		varchar(50)	NOT NULL,
	Calificacion		float		NOT NULL,

	Situacion		varchar(50)	NULL,

 	CONSTRAINT priCampanaTipoCalificacion PRIMARY KEY  CLUSTERED (CampanaTipo, Calificacion)
  )
GO

/****** CampanaTipo ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampanaTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaTipo') and type = 'U') 
CREATE TABLE dbo.CampanaTipo (
	CampanaTipo		varchar(50)	NOT NULL,

	ParaProspectos		bit		NULL	DEFAULT 0,
	ParaClientes		bit		NULL	DEFAULT 0,
	ParaProveedores		bit		NULL	DEFAULT 0,
	ParaPersonal		bit		NULL	DEFAULT 0,
	ParaAgentes		bit		NULL	DEFAULT 0,
--	OportunidadMov		varchar(20)	NULL,
--	SituacionOportunidad	varchar(50)	NULL,

	Sitio			varchar(20)	NULL,
	EncuestaWeb		bit		NULL	DEFAULT 0,
	EncuestaEtiqueta	varchar(100)	NULL,
	EncuestaPagina		varchar(20)	NULL,

	CancelarSuscripcion		bit		NULL	DEFAULT 0,
	CancelarSuscripcionEtiqueta	varchar(100)	NULL,
	CancelarSuscripcionSituacion	varchar(50)	NULL,

--	CalificaMinimo		float		NULL,
	--CalificaSituacion	varchar(50)	NULL,

 	CONSTRAINT priCampanaTipo PRIMARY KEY  CLUSTERED (CampanaTipo)
)
GO
EXEC spDROP_COLUMN 'CampanaTipo', 'OportunidadMov'
EXEC spDROP_COLUMN 'CampanaTipo', 'SituacionOportunidad'
EXEC spDROP_COLUMN 'CampanaTipo', 'SituacionPorOmision'
GO
EXEC spDROP_COLUMN 'CampanaTipo', 'CalificaMinimo'
EXEC spDROP_COLUMN 'CampanaTipo', 'CalificaSituacion'
GO
EXEC spALTER_TABLE 'CampanaTipo', 'CancelarSuscripcion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CampanaTipo', 'CancelarSuscripcionEtiqueta', 'varchar(100)	NULL'
EXEC spALTER_TABLE 'CampanaTipo', 'CancelarSuscripcionSituacion', 'varchar(50)	NULL'
EXEC spRENAME_COLUMN 'CampanaTipo', 'EncuestaSitio', 'Sitio'
GO

EXEC spFK 'CampanaTipo','Sitio','WebSitio','Sitio'
EXEC spFK 'CampanaTipo','EncuestaPagina','WebPagina','Pagina'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCampanaTipoSituacionBC') and sysstat & 0xf = 8) drop trigger dbo.tgCampanaTipoSituacionBC
GO
CREATE TRIGGER tgCampanaTipoSituacionBC ON CampanaTipoSituacion
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CampanaTipoN 	varchar(50),
    @CampanaTipoA	varchar(50),
    @SituacionN		varchar(50),
    @SituacionA		varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CampanaTipoN = CampanaTipo, @SituacionN = Situacion FROM Inserted
  SELECT @CampanaTipoA = CampanaTipo, @SituacionA = Situacion FROM Deleted

  IF @SituacionN = @SituacionA RETURN

  IF @SituacionN IS NULL 
  BEGIN
    DELETE CampanaTipoSituacionTarea WHERE CampanaTipo = @CampanaTipoA AND Situacion = @SituacionA
  END ELSE
  IF @CampanaTipoA IS NOT NULL 
  BEGIN
    UPDATE CampanaTipoSituacionTarea SET Situacion = @SituacionN WHERE CampanaTipo = @CampanaTipoA AND Situacion = @SituacionA
  END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCampanaTipoBC') and sysstat & 0xf = 8) drop trigger dbo.tgCampanaTipoBC
GO
CREATE TRIGGER tgCampanaTipoBC ON CampanaTipo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CampanaTipoN 	varchar(50),
    @CampanaTipoA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CampanaTipoN = CampanaTipo FROM Inserted
  SELECT @CampanaTipoA = CampanaTipo FROM Deleted
  IF @CampanaTipoN = @CampanaTipoA RETURN

  IF @CampanaTipoN IS NULL 
  BEGIN
    DELETE CampanaTipoSituacionTarea WHERE CampanaTipo = @CampanaTipoA
    DELETE CampanaTipoSituacion      WHERE CampanaTipo = @CampanaTipoA
    DELETE CampanaTipoEncuesta       WHERE CampanaTipo = @CampanaTipoA
    DELETE CampanaTipoEncuestaLista  WHERE CampanaTipo = @CampanaTipoA
    DELETE CampanaTipoCalificacion   WHERE CampanaTipo = @CampanaTipoA
  END ELSE
  IF @CampanaTipoA IS NOT NULL 
  BEGIN
    UPDATE CampanaTipoSituacionTarea SET CampanaTipo = @CampanaTipoN WHERE CampanaTipo = @CampanaTipoA
    UPDATE CampanaTipoSituacion      SET CampanaTipo = @CampanaTipoN WHERE CampanaTipo = @CampanaTipoA
    UPDATE CampanaTipoEncuesta       SET CampanaTipo = @CampanaTipoN WHERE CampanaTipo = @CampanaTipoA
    UPDATE CampanaTipoEncuestaLista  SET CampanaTipo = @CampanaTipoN WHERE CampanaTipo = @CampanaTipoA
    UPDATE CampanaTipoCalificacion   SET CampanaTipo = @CampanaTipoN WHERE CampanaTipo = @CampanaTipoA
  END
END
GO

/****** Consecutivos Campana ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CampanaC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CampanaC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)      NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCampanaC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CampanaC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'CampanaC', '(ID)'
GO

/****** Campana (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'Campana')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Campana','Movimiento','CMP')
if not exists (select * from sysobjects where id = object_id('dbo.Campana') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Campana (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	NOT NULL,
	Mov  			varchar(20)     NOT NULL,
	MovID			varchar(20)    	NULL,	 
	FechaEmision 		datetime    	NULL,	 
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	UEN			int		NULL,
	Usuario 		varchar(10)   	NULL,
	Autorizacion		varchar(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		varchar(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	Asunto			varchar(100)	NULL,
	Agente			varchar(10)	NULL,
	CampanaTipo		varchar(50)	NULL,

	TieneVigencia		bit		NULL	DEFAULT 0,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,

	CONSTRAINT priCampana PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Campana'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Campana'
go
EXEC spALTER_TABLE 'Campana', 'TieneVigencia', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Campana', 'FechaD', 'datetime NULL'
EXEC spALTER_TABLE 'Campana', 'FechaA', 'datetime NULL'
go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Campana' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia    ON dbo.Campana (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Campana' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Campana (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Campana' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Campana (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Campana' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Campana (Mov, Estatus, Sucursal, Empresa, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Campana' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Campana (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Campana' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Campana (Usuario)
GO

if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Campana' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Campana.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Campana' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Campana.Situacion2
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Campana' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Campana (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Campana' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Campana (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Campana' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Campana (OrigenID,Origen,Empresa)
go


if exists (select * from sysobjects where id = object_id('dbo.tgCampanaA') and sysstat & 0xf = 8) drop trigger dbo.tgCampanaA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCampanaC') and sysstat & 0xf = 8) drop trigger dbo.tgCampanaC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCampanaB') and sysstat & 0xf = 8) drop trigger dbo.tgCampanaB
GO
EXEC spModificarPK_Mov 'Campana'
GO
EXEC spSincroNivelRegistroCampos 'Campana'
GO
-- Aqui va el Matenimiento a la tabla

GO

EXEC spFK 'Campana','UEN','UEN','UEN'
EXEC spFK 'Campana','Proyecto','Proy','Proyecto'
EXEC spFK 'Campana','Agente','Agente','Agente'
EXEC spFK 'Campana','CampanaTipo','CampanaTipo','CampanaTipo'
GO

CREATE TRIGGER tgCampanaC ON Campana
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 		varchar(5),
    @Mov		varchar(20),
    @Sucursal		int,
    @ID			int,
    @FechaInicio	datetime,
    @Ahora 		datetime,
    @FechaAnterior	datetime,
    @EstatusNuevo 	varchar(15),
    @EstatusAnterior 	varchar(15),
    @SituacionNueva 	varchar(50),
    @SituacionAnterior 	varchar(50),
    @Usuario		varchar(10),
    @Mensaje		varchar(255),
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Modulo = 'CMP'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '') FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @Usuario = Usuario FROM Inserted
  IF @EstatusNuevo <> @EstatusAnterior AND 
     ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
      (@EstatusNuevo IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END 
  ELSE BEGIN
    IF @EstatusNuevo NOT IN (NULL, 'AFECTANDO') AND (@EstatusAnterior <> @EstatusNuevo OR @SituacionAnterior <> @SituacionNueva)
    BEGIN
      IF @EstatusAnterior <> @EstatusNuevo AND (@EstatusAnterior <> 'AFECTANDO' OR @SituacionAnterior IS NULL OR @SituacionNueva IS NULL)
      BEGIN
        EXEC spMovSituacionNueva @Modulo, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva OUTPUT, @ID = @ID
      END
      SELECT @Ahora = GETDATE(), @FechaInicio = NULL
      SELECT @FechaInicio = MIN(FechaInicio), @FechaAnterior = MAX(FechaComenzo) FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID 
      IF @FechaInicio IS NOT NULL AND @FechaAnterior IS NOT NULL
        UPDATE MovTiempo SET FechaTermino = @Ahora WHERE Modulo = @Modulo AND ID = @ID AND FechaComenzo = @FechaAnterior
      IF @FechaInicio IS NULL SELECT @FechaInicio = @Ahora

      INSERT INTO MovTiempo (Modulo,  Sucursal,  ID,  Usuario,                              FechaInicio,  FechaComenzo, Estatus,       Situacion) 
                     VALUES (@Modulo, @Sucursal, @ID, ISNULL(@AfectacionUsuario, @Usuario), @FechaInicio, @Ahora,       @EstatusNuevo, @SituacionNueva)
    END
  END

  EXEC spMovAlActualizar @Modulo, @ID, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva, @SituacionAnterior

  -- Para que cancele la poliza cuando Maneja SincroContabilidadMatriz
/*  IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE Campana SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL */
END
GO


CREATE TRIGGER tgCampanaB ON Campana
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	varchar(15),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'CMP', @ID
END
GO

/****** CampanaEncuesta (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaEncuesta')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CampanaEncuesta','Movimiento','CMP')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaEncuesta') and type = 'U') 
  CREATE TABLE dbo.CampanaEncuesta (
	ID 			int       	NOT NULL,
	RID			int		NOT NULL,
	Campo			varchar(20)	NOT NULL,

	Respuesta		varchar(255)	NULL,
	Calificacion		float		NULL,

	CONSTRAINT priCampanaEncuesta PRIMARY KEY CLUSTERED (ID, RID, Campo)
  )
go
EXEC spModificarPK_Sucursal 'CampanaEncuesta', '(ID, RID, Campo)'
GO
EXEC spALTER_TABLE 'CampanaEncuesta', 'Calificacion', 'float NULL'
GO

/**************** spCampanaEncuesta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaEncuesta') and sysstat & 0xf = 4) drop procedure dbo.spCampanaEncuesta
GO
CREATE PROCEDURE spCampanaEncuesta
			@ID		int,
			@RID		int,
			@CampanaTipo	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  IF NOT EXISTS(SELECT * FROM CampanaEncuesta WHERE ID = @ID AND RID = @RID)
    INSERT CampanaEncuesta (ID, RID, Campo)
    SELECT @ID, @RID, Campo
      FROM CampanaTipoEncuesta
     WHERE CampanaTipo = @CampanaTipo
  RETURN
END
GO

/**************** spCampanaEncuestaAyuda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaEncuestaAyuda') and sysstat & 0xf = 4) drop procedure dbo.spCampanaEncuestaAyuda
GO
CREATE PROCEDURE spCampanaEncuestaAyuda
			@CampanaTipo	varchar(50),
			@Campo		varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tipo	varchar(20)
  SELECT @Tipo = UPPER(Tipo) FROM CampanaTipoEncuesta WHERE CampanaTipo = @CampanaTipo AND Campo = @Campo
  IF @Tipo = 'DATOS'
    SELECT Valor 
      FROM CampanaTipoEncuestaLista
     WHERE CampanaTipo = @CampanaTipo AND Campo = @Campo
     ORDER BY Orden
  ELSE
    SELECT tabla.Nombre 
      FROM CampanaTipoEncuesta tipo
      JOIN TablaEvaluacionD tabla ON tabla.TablaEvaluacion = tipo.TablaEvaluacion
     WHERE tipo.CampanaTipo = @CampanaTipo AND tipo.Campo = @Campo
     ORDER BY tabla.Orden
  RETURN
END
GO

-- select * from CampanaEncuesta
/**************** spCampanaEncuestaRespuestaValor ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaEncuestaRespuestaValor') and sysstat & 0xf = 4) drop procedure dbo.spCampanaEncuestaRespuestaValor
GO
CREATE PROCEDURE spCampanaEncuestaRespuestaValor
			@CampanaTipo	varchar(50),
			@Campo		varchar(100),
                        @Respuesta	varchar(255),
			@Valor		float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Valor = NULL
  SELECT @Valor = tabla.Valor
    FROM CampanaTipoEncuesta tipo
    JOIN TablaEvaluacionD tabla ON tabla.TablaEvaluacion = tipo.TablaEvaluacion
   WHERE tipo.CampanaTipo = @CampanaTipo AND tipo.Campo = @Campo AND tabla.Nombre=@Respuesta
  RETURN
END
GO
-- campanad

/**************** spCampanaEncuestaRespuesta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaEncuestaRespuesta') and sysstat & 0xf = 4) drop procedure dbo.spCampanaEncuestaRespuesta
GO
CREATE PROCEDURE spCampanaEncuestaRespuesta
			@CampanaTipo	varchar(50),
			@Campo		varchar(100),
                        @Respuesta	varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Valor float
  EXEC spCampanaEncuestaRespuestaValor @CampanaTipo,  @Campo, @Respuesta, @Valor OUTPUT
  SELECT 'Valor' = @Valor
  RETURN
END
GO

/**************** spCampanaEncuestaCalificacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaEncuestaCalificacion') and sysstat & 0xf = 4) drop procedure dbo.spCampanaEncuestaCalificacion
GO
CREATE PROCEDURE spCampanaEncuestaCalificacion
			@ID		int,
			@RID		int,
			@Calificacion	float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Calificacion = SUM(e.Calificacion*(tipo.Peso/100.0))
    FROM CampanaTipoEncuesta tipo
    JOIN Campana c ON c.ID = @ID
    JOIN CampanaEncuesta e ON e.ID = c.ID AND e.RID = @RID AND e.Campo = tipo.Campo
   WHERE tipo.CampanaTipo = c.CampanaTipo 
  RETURN
END
GO

-- select * from campanad where id =2
-- spCampanaEncuestaAceptar 2,3
/**************** spCampanaEncuestaAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaEncuestaAceptar') and sysstat & 0xf = 4) drop procedure dbo.spCampanaEncuestaAceptar
GO
CREATE PROCEDURE spCampanaEncuestaAceptar
			@ID		int,
			@RID		int,
			@Calificacion	float		= NULL	OUTPUT,
			@Situacion	varchar(50)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE    
    @CampanaTipo	varchar(50),
    @CalificacionMax	float,
    @CalificaSituacion	varchar(50)

  SELECT @CampanaTipo = CampanaTipo
    FROM Campana
   WHERE ID = @ID

  UPDATE CampanaEncuesta
     SET Calificacion = tabla.Valor
    FROM CampanaEncuesta e
    JOIN CampanaTipoEncuesta tipo ON tipo.CampanaTipo = @CampanaTipo AND tipo.Campo = e.Campo
    JOIN TablaEvaluacionD tabla ON tabla.TablaEvaluacion = tipo.TablaEvaluacion AND tabla.nombre = e.Respuesta
   WHERE e.ID = @ID AND e.RID = @RID

  EXEC spCampanaEncuestaCalificacion @ID, @RID, @Calificacion OUTPUT
  SELECT @Situacion = Situacion FROM CampanaD WHERE ID = @ID AND RID = @RID

  SELECT @CalificacionMax = MAX(Calificacion)    
    FROM CampanaTipoCalificacion
   WHERE CampanaTipo = @CampanaTipo AND @Calificacion>=Calificacion

  SELECT @CalificaSituacion = NULL
  SELECT @CalificaSituacion = NULLIF(RTRIM(Situacion), '')
    FROM CampanaTipoCalificacion
   WHERE CampanaTipo = @CampanaTipo AND Calificacion = @CalificacionMax

  IF @CalificacionMax IS NOT NULL AND @CalificaSituacion IS NOT NULL AND @CalificaSituacion <> @Situacion
  BEGIN
    SELECT @Situacion = @CalificaSituacion
    INSERT CampanaEvento (ID, RID, Tipo, Situacion) VALUES (@ID, @RID, 'Encuesta', @Situacion)

    UPDATE CampanaD SET Situacion = @CalificaSituacion
     WHERE ID = @ID AND RID = @RID
  END

  RETURN
END
GO


/**************** spCampanaDCalificacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaDCalificacion') and sysstat & 0xf = 4) drop procedure dbo.spCampanaDCalificacion
GO
CREATE PROCEDURE spCampanaDCalificacion
			@ID		int,
			@RID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Calificacion	float

  EXEC spCampanaEncuestaCalificacion @ID, @RID, @Calificacion OUTPUT
  SELECT 'Calificacion' = @Calificacion
  RETURN
END
GO

-- drop table CampanaEvento
/****** CampanaEvento (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaEvento')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CampanaEvento','Movimiento','CMP')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaEvento') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CampanaEvento (
	ID 			int       	NOT NULL,
	RID			int		NOT NULL,
	EventoID		int         	NOT NULL IDENTITY(1,1),

	FechaHora		datetime	NULL	DEFAULT GETDATE(),
	Tipo			varchar(20)	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	Observaciones		varchar(255)	NULL,
	Comentarios		text		NULL,

	CONSTRAINT priCampanaEvento PRIMARY KEY CLUSTERED (ID, RID, EventoID)
  )
  EXEC spSincroSemilla 'CampanaEvento'
END
go
EXEC spModificarPK_Sucursal 'CampanaEvento', '(ID, RID, EventoID)'
GO
EXEC spALTER_TABLE 'CampanaEvento', 'Comentarios', 'text NULL'
GO

-- spCampanaDSituacion 7,8
-- select * from CampanaEvento where id = 7 and rid=8 order by fechahora desc
/**************** spCampanaDSituacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaDSituacion') and sysstat & 0xf = 4) drop procedure dbo.spCampanaDSituacion
GO
CREATE PROCEDURE spCampanaDSituacion
			@ID		int,
			@RID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Situacion	varchar(50)
  
  SELECT TOP(1) @Situacion = Situacion
    FROM CampanaEvento
   WHERE ID = @ID AND RID = @RID 
   ORDER BY EventoID DESC
  IF @@ROWCOUNT = 0
    SELECT @Situacion = Situacion FROM CampanaD WHERE ID = @ID AND RID = @RID

  SELECT 'Situacion' = @Situacion
  RETURN
END
GO

/**************** spCampanaDSituacionFecha ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaDSituacionFecha') and sysstat & 0xf = 4) drop procedure dbo.spCampanaDSituacionFecha
GO
CREATE PROCEDURE spCampanaDSituacionFecha
			@ID		int,
			@RID		int
--//WITH ENCRYPTION
AS BEGIN
  SELECT TOP(1) SituacionFecha
    FROM CampanaEvento
   WHERE ID = @ID AND RID = @RID 
   ORDER BY EventoID DESC
  RETURN
END
GO

/**************** spCampanaDObservaciones ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaDObservaciones') and sysstat & 0xf = 4) drop procedure dbo.spCampanaDObservaciones
GO
CREATE PROCEDURE spCampanaDObservaciones
			@ID		int,
			@RID		int
--//WITH ENCRYPTION
AS BEGIN
  SELECT TOP(1) Observaciones
    FROM CampanaEvento
   WHERE ID = @ID AND RID = @RID 
   ORDER BY EventoID DESC
  RETURN
END
GO

/**************** spCampanaDEventoAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaDEventoAceptar') and sysstat & 0xf = 4) drop procedure dbo.spCampanaDEventoAceptar
GO
CREATE PROCEDURE spCampanaDEventoAceptar
			@ID		int,
			@RID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EventoID		int,
    @Calificacion	float,
    @Situacion		varchar(50),
    @SituacionFecha	datetime,
    @Observaciones	varchar(225)

  SELECT @EventoID = MAX(EventoID)
    FROM CampanaEvento
   WHERE ID = @ID AND RID = @RID 
  SELECT @Situacion = Situacion,
         @SituacionFecha = SituacionFecha,
         @Observaciones = Observaciones
    FROM CampanaEvento
   WHERE ID = @ID AND RID = @RID AND EventoID = @EventoID
  EXEC spCampanaEncuestaCalificacion @ID, @RID, @Calificacion OUTPUT
  UPDATE CampanaD 
     SET Situacion = @Situacion,
         SituacionFecha = @SituacionFecha,
         Observaciones = @Observaciones,
         Calificacion = @Calificacion
   WHERE ID = @ID AND RID = @RID
  RETURN
END
GO

/****** CampanaCorreo ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaCorreo')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CampanaCorreo','Movimiento','CMP')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaCorreo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CampanaCorreo (
	ID 			int       	NOT NULL,
	CorreoID		int 		NOT NULL IDENTITY(1,1),

	FechaHora		datetime	NULL,
	Pagina			varchar(20)	NULL,
	Asunto			varchar(100)	NULL,
	Estatus			varchar(15)	NULL,

	CONSTRAINT priCampanaCorreo PRIMARY KEY CLUSTERED (ID, CorreoID)
  )
  EXEC spSincroSemilla 'CampanaCorreo'
END
go
EXEC spModificarPK_Sucursal 'CampanaCorreo', '(ID, CorreoID)'
GO

EXEC spFK 'CampanaCorreo','Pagina','WebPagina','Pagina'
GO

-- drop table CampanaCfgCorreo
/****** CampanaCfgCorreo ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaCfgCorreo')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CampanaCfgCorreo','Movimiento','CMP')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaCfgCorreo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CampanaCfgCorreo (
	ID 			int       	NOT NULL,
	CfgID			int 		NOT NULL IDENTITY(1,1),

	Frecuencia		varchar(20)	NULL,	-- Diario, Semanal, Mensual
	SiguienteEnvio		datetime	NULL,
	Pagina			varchar(20)	NULL,
	Asunto			varchar(100)	NULL,
	Situacion		varchar(50)	NULL,
	Estatus			varchar(15)	NULL,

	CONSTRAINT priCampanaCfgCorreo PRIMARY KEY CLUSTERED (ID, CfgID)
  )
  EXEC spSincroSemilla 'CampanaCfgCorreo'
END
go
EXEC spModificarPK_Sucursal 'CampanaCfgCorreo', '(ID, CfgID)'
GO

EXEC spFK 'CampanaCfgCorreo','Pagina','WebPagina','Pagina'
GO

-- drop table CampanaCfgSituacion
/****** CampanaCfgSituacion ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaCfgSituacion')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CampanaCfgSituacion','Movimiento','CMP')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaCfgSituacion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CampanaCfgSituacion (
	ID 			int       	NOT NULL,
	CfgID			int 		NOT NULL IDENTITY(1,1),

	Situacion		varchar(50)	NULL,
	Accion			varchar(50)	NULL,		-- Enviar Correo, Generar Proyecto, Transferir Contacto
	Pagina			varchar(20)	NULL,
	Asunto			varchar(100)	NULL,
	ProyectoMov		varchar(20)	NULL,
	ProyectoPlantilla	varchar(50)	NULL,
	CampanaMov		varchar(20)	NULL,
	CampanaMovID		varchar(20)	NULL,
	OportunidadMov		varchar(20)	NULL,
	Estatus			varchar(15)	NULL,
	GestionMov		varchar(20)	NULL,
	GestionAsunto		varchar(255)	NULL,
	GestionPara		varchar(10)	NULL,

	CONSTRAINT priCampanaCfgSituacion PRIMARY KEY CLUSTERED (ID, CfgID)
  )
  EXEC spSincroSemilla 'CampanaCfgSituacion'
END
go
EXEC spModificarPK_Sucursal 'CampanaCfgSituacion', '(ID, CfgID)'
GO
EXEC spALTER_TABLE 'CampanaCfgSituacion', 'ProyectoPlantilla', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CampanaCfgSituacion', 'OportunidadMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CampanaCfgSituacion', 'GestionMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CampanaCfgSituacion', 'GestionAsunto', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CampanaCfgSituacion', 'GestionPara', 'varchar(10) NULL'
GO

EXEC spFK 'CampanaCfgSituacion','Pagina','WebPagina','Pagina'
GO

-- drop table CampanaTarea
/****** CampanaTarea ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaTarea')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CampanaTarea','Movimiento','CMP')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaTarea') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CampanaTarea (
	ID 			int       	NOT NULL,
	RID			int		NOT NULL,
	TareaID			int 		NOT NULL IDENTITY(1,1),

	FechaHora		datetime	NULL	DEFAULT GETDATE(),
	Situacion		varchar(50)	NULL,
	Inicio			datetime	NULL,
	Vencimiento		datetime	NULL,
	FechaConclusion		datetime	NULL,
	Asunto			varchar(100)	NULL,
	Estado			varchar(30)	NULL,
	Avance			float		NULL,

	CONSTRAINT priCampanaTarea PRIMARY KEY CLUSTERED (ID, RID, TareaID)
  )
  EXEC spSincroSemilla 'CampanaTarea'
END
go
EXEC spModificarPK_Sucursal 'CampanaTarea', '(ID, RID, TareaID)'
GO

-- drop table CampanaD
/****** CampanaD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'CampanaD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CampanaD','Movimiento','CMP')
if not exists (select * from sysobjects where id = object_id('dbo.CampanaD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CampanaD (
	ID 			int       	NOT NULL,
	RID			int		NOT NULL IDENTITY(1,1),

	Contacto		varchar(10)	NULL,	
	ContactoTipo		varchar(20)	NULL,	-- Prospecto, Cliente, Proveedor, Personal, Agente

	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	Observaciones		varchar(255)	NULL,
	Calificacion		float		NULL,
	Usuario			varchar(10)	NULL,

	CONSTRAINT priCampanaD PRIMARY KEY CLUSTERED (ID, RID)
  )
  EXEC spSincroSemilla 'CampanaD'
END
go
EXEC spModificarPK_Sucursal 'CampanaD', '(ID, RID)'
GO
EXEC spALTER_TABLE 'CampanaD', 'Usuario', 'varchar(10) NULL'
GO
--CampanaD--
EXEC spAlter_Table 'CampanaD','EnviarA','int Null'
EXEC spAlter_Table 'CampanaD','FechaD','datetime Null'
EXEC spAlter_Table 'CampanaD','FechaA','datetime Null'
EXEC spAlter_Table 'CampanaD','ListaPreciosEsp','varchar(20) Null'
EXEC spAlter_Table 'CampanaD','Instruccion','varchar(255) Null'
EXEC spAlter_Table 'CampanaD','MapaLatitud','float Null'
EXEC spAlter_Table 'CampanaD','MapaLongitud','float Null'
EXEC spAlter_Table 'CampanaD','MapaPrecision','int Null'
EXEC spAlter_Table 'CampanaD','Almacen','varchar(10) Null'
EXEC spAlter_Table 'CampanaD','SubSituacion','varchar(50) Null'
GO

/**************** spCampanaCorreoEnviarPara ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaCorreoEnviarPara') and sysstat & 0xf = 4) drop procedure dbo.spCampanaCorreoEnviarPara
GO
CREATE PROCEDURE spCampanaCorreoEnviarPara
			@ID				int,
			@Pagina				varchar(20),
			@Asunto				varchar(100),

			@Para				varchar(255),
			@Perfil				varchar(50),
			@RID				int,
			@HTML				varchar(max),
			@PaginaTipo			varchar(20),
			@Sitio				varchar(20),

			@EncuestaWeb			bit, 
			@EncuestaEtiqueta		varchar(100),
			@EncuestaPagina			varchar(20),
			@CancelarSuscripcion		bit, 
			@CancelarSuscripcionEtiqueta	varchar(100), 
			@Ok				int		OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Vinculo		varchar(max)

  IF @EncuestaWeb = 1 AND UPPER(@PaginaTipo) IN ('ENCUESTA', 'HTML')
  BEGIN
    SELECT @Vinculo = WebSitio.URL_Sitio+'encuesta.aspx?pagina='+@EncuestaPagina+'&Origen=CMP|'+CONVERT(varchar, @ID)+'|'+CONVERT(varchar, @RID)
      FROM WebSitio
     WHERE Sitio = @Sitio

    SELECT @HTML = @HTML + '<p align="center"><a href="'+@Vinculo+'">'+ISNULL(@EncuestaEtiqueta, @Vinculo)+'</a></p>'
  END 
  IF @CancelarSuscripcion = 1
  BEGIN
    SELECT @Vinculo = WebSitio.URL_Sitio+'cancelarsuscripcion.aspx?Origen=CMP|'+CONVERT(varchar, @ID)+'|'+CONVERT(varchar, @RID)
      FROM WebSitio
     WHERE Sitio = @Sitio
    SELECT @HTML = @HTML + '<p align="center"><a href="'+@Vinculo+'">'+ISNULL(@CancelarSuscripcionEtiqueta, @Vinculo)+'</a></p>'
  END
  EXEC spWebPaginaParcear NULL, NULL, @Pagina, @Asunto OUTPUT, NULL, @HTML OUTPUT, NULL, @ID, @RID, @Ok OUTPUT, @OkRef OUTPUT
  EXEC spEnviarDBMail @Perfil, @Para, @Asunto = @Asunto, @Mensaje = @HTML, @Formato = 'HTML'
  RETURN
END
GO

/**************** spCampanaCorreoEnviar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaCorreoEnviar') and sysstat & 0xf = 4) drop procedure dbo.spCampanaCorreoEnviar
GO
CREATE PROCEDURE spCampanaCorreoEnviar
			@ID		int,
			@Pagina		varchar(20),
			@Asunto		varchar(100),

			@Conteo		int		OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CampanaTipo			varchar(50),
    @ContactoTipo			varchar(20),
    @Contacto				varchar(10),
    @Nombre				varchar(100),
    @ApellidoPaterno			varchar(30),
    @ApellidoMaterno			varchar(30),
    @eMail				varchar(100),
    @Para				varchar(255),
    @Empresa				varchar(5),
    @Usuario				varchar(10),
    @Perfil				varchar(50),
    @PaginaTipo				varchar(20),
    @HTML				varchar(max),
    @Sitio				varchar(20),
    @EncuestaWeb			bit, 
    @EncuestaEtiqueta			varchar(100),
    @EncuestaPagina			varchar(20),
    @CancelarSuscripcion		bit,
    @CancelarSuscripcionEtiqueta	varchar(100),
    @RID				int,
    @EnvioCorreo			bit

  SELECT @Conteo = 0
  SELECT @CampanaTipo = CampanaTipo, @Empresa = Empresa, @Usuario = NULLIF(RTRIM(Usuario), '') FROM Campana WHERE ID = @ID
  SELECT @Perfil = DBMailPerfil FROM EmpresaGral WHERE Empresa = @Empresa  
  IF @Usuario IS NOT NULL
    SELECT @Perfil = ISNULL(NULLIF(RTRIM(DBMailPerfil), ''), @Perfil) FROM Usuario WHERE Usuario = @Usuario

  SELECT @PaginaTipo = Tipo, @HTML = CONVERT(varchar(max), HTML) FROM WebPagina WHERE Pagina = @Pagina
  SELECT @Sitio = NULLIF(RTRIM(Sitio), ''), @EncuestaWeb = ISNULL(EncuestaWeb, 0), @EncuestaEtiqueta = NULLIF(RTRIM(EncuestaEtiqueta), ''), @EncuestaPagina = NULLIF(RTRIM(EncuestaPagina), ''),
         @CancelarSuscripcion = ISNULL(CancelarSuscripcion, 0), @CancelarSuscripcionEtiqueta = NULLIF(RTRIM(CancelarSuscripcionEtiqueta), '')
 
    FROM CampanaTipo
   WHERE CampanaTipo = @CampanaTipo

  DECLARE crCampanaD CURSOR LOCAL FOR
   SELECT d.RID, d.Contacto, d.ContactoTipo
     FROM CampanaD d
    WHERE d.ID = @ID AND d.RID IN (SELECT RID FROM #CampanaCorreoEnviar)
  OPEN crCampanaD
  FETCH NEXT FROM crCampanaD INTO @RID, @Contacto, @ContactoTipo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @EnvioCorreo = 0

      IF @ContactoTipo IN ('Cliente', 'Prospecto')
      BEGIN
        IF @ContactoTipo = 'Cliente'   
          DECLARE crCampanaCto CURSOR LOCAL FOR
           SELECT c.Nombre, c.ApellidoPaterno, c.ApellidoMaterno, eMail
             FROM CteCto c
             JOIN CampanaTipoCargo t ON t.CampanaTipo = @CampanaTipo AND t.Cargo = c.Cargo
            WHERE c.Cliente = @Contacto 
        ELSE
        IF @ContactoTipo = 'Prospecto' 
          DECLARE crCampanaCto CURSOR LOCAL FOR
           SELECT c.Nombre, c.ApellidoPaterno, c.ApellidoMaterno, eMail
             FROM ProspectoCto c
             JOIN CampanaTipoCargo t ON t.CampanaTipo = @CampanaTipo AND t.Cargo = c.Cargo
            WHERE c.Prospecto = @Contacto 

        OPEN crCampanaCto
        FETCH NEXT FROM crCampanaCto INTO @Nombre, @ApellidoPaterno, @ApellidoMaterno, @eMail
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            SELECT @Para = NULL
            SELECT @Para = dbo.fnCorreoPara(@Nombre, @ApellidoPaterno, @ApellidoMaterno, @eMail)
            IF @Para IS NOT NULL
            BEGIN
              EXEC spCampanaCorreoEnviarPara @ID, @Pagina, @Asunto, @Para, @Perfil, @RID, @HTML, @PaginaTipo, @Sitio, @EncuestaWeb, @EncuestaEtiqueta, @EncuestaPagina, @CancelarSuscripcion, @CancelarSuscripcionEtiqueta, @Ok OUTPUT, @OkRef OUTPUT 
              SELECT @Conteo = @Conteo + 1, @EnvioCorreo = 1
            END
          END
          FETCH NEXT FROM crCampanaCto INTO @Nombre, @ApellidoPaterno, @ApellidoMaterno, @eMail
        END  -- While
        CLOSE crCampanaCto
        DEALLOCATE crCampanaCto
      END ELSE
      BEGIN
        SELECT @Para = NULL
        IF @ContactoTipo = 'Personal'
          SELECT @Para = dbo.fnCorreoPara(Nombre, ApellidoPaterno, ApellidoMaterno, eMail)
            FROM Personal 
           WHERE Personal = @Contacto
        ELSE
        IF @ContactoTipo = 'Proveedor'
          SELECT @Para = dbo.fnCorreoPara(Contacto1, NULL, NULL, eMail1)
            FROM Prov
           WHERE Proveedor = @Contacto
        ELSE
        IF @ContactoTipo = 'Agente'
          SELECT @Para = dbo.fnCorreoPara(Nombre, NULL, NULL, eMail)
            FROM Agente
           WHERE Agente = @Contacto
        IF @Para IS NOT NULL
        BEGIN
          EXEC spCampanaCorreoEnviarPara @ID, @Pagina, @Asunto, @Para, @Perfil, @RID, @HTML, @PaginaTipo, @Sitio, @EncuestaWeb, @EncuestaEtiqueta, @EncuestaPagina, @CancelarSuscripcion, @CancelarSuscripcionEtiqueta, @Ok OUTPUT, @OkRef OUTPUT 
          SELECT @Conteo = @Conteo + 1, @EnvioCorreo = 1
        END
      END

      IF @EnvioCorreo = 1
        INSERT CampanaEvento (ID, RID, Tipo, Observaciones) VALUES (@ID, @RID, 'Correo', @Asunto)
    END
    FETCH NEXT FROM crCampanaD INTO @RID, @Contacto, @ContactoTipo
  END  -- While
  CLOSE crCampanaD
  DEALLOCATE crCampanaD

  RETURN
END
GO

/**************** spCampanaCorreoEnviarListaSt ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaCorreoEnviarListaSt') and sysstat & 0xf = 4) drop procedure dbo.spCampanaCorreoEnviarListaSt
GO
CREATE PROCEDURE spCampanaCorreoEnviarListaSt
			@ID		int,
			@CorreoID	int,
			@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo		int,
    @Pagina		varchar(20),
    @Asunto		varchar(100),
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255)

  SELECT @Conteo = 0, @Ok = NULL, @OkRef = NULL, @Mensaje = NULL
  SELECT @Pagina = Pagina, @Asunto = Asunto FROM CampanaCorreo WHERE ID = @ID AND CorreoID = @CorreoID

  CREATE TABLE #CampanaCorreoEnviar (RID int PRIMARY KEY NOT NULL)
  INSERT #CampanaCorreoEnviar (RID)
  SELECT DISTINCT CONVERT(int, Clave) FROM ListaSt WHERE Estacion = @Estacion

  EXEC spCampanaCorreoEnviar @ID, @Pagina, @Asunto, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    SELECT @Mensaje = CONVERT(varchar, @Conteo)+' Correos Enviados.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  DROP TABLE #CampanaCorreoEnviar
  SELECT 'Mensaje' = @Mensaje
  RETURN
END
GO

/**************** spCampanaCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaCerrarDia') and sysstat & 0xf = 4) drop procedure dbo.spCampanaCerrarDia
GO
CREATE PROCEDURE spCampanaCerrarDia
			@Sucursal	int, 
			@Empresa	varchar(5), 
			@Usuario	varchar(10), 
			@FechaTrabajo	datetime, 
			@Fecha		datetime,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo		int,
    @ID			int, 
    @Frecuencia		varchar(20), 
    @Situacion		varchar(50), 
    @Pagina		varchar(20), 
    @Asunto		varchar(100),
    @TieneVigencia	bit,
    @FechaD		datetime,
    @FechaA		datetime,
    @CampanaTipo	varchar(50),
    @ConcluirCampana	bit

  SELECT @Conteo = 0
  CREATE TABLE #CampanaCorreoEnviar (RID int PRIMARY KEY NOT NULL)

  DECLARE crCampanaCfgCorreo CURSOR LOCAL FOR
   SELECT c.ID, CASE WHEN c.TieneVigencia = 1 THEN c.FechaD ELSE @Fecha END, CASE WHEN c.TieneVigencia = 1 THEN c.FechaA ELSE @Fecha END, UPPER(ca.Frecuencia), NULLIF(RTRIM(ca.Situacion), ''), NULLIF(RTRIM(ca.Pagina), ''), NULLIF(RTRIM(ca.Asunto), '')
     FROM CampanaCfgCorreo ca
     JOIN Campana c ON c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE'
    WHERE ca.SiguienteEnvio = @Fecha AND ca.Estatus = 'ALTA'

  OPEN crCampanaCfgCorreo
  FETCH NEXT FROM crCampanaCfgCorreo INTO @ID, @FechaD, @FechaA, @Frecuencia, @Situacion, @Pagina, @Asunto
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Pagina IS NOT NULL AND @Fecha BETWEEN @FechaD AND @FechaA
    BEGIN
      SELECT @Situacion = NULLIF(NULLIF(RTRIM(@Situacion), ''), '(Todas)')
      TRUNCATE TABLE #CampanaCorreoEnviar
      INSERT #CampanaCorreoEnviar (RID)
      SELECT RID FROM CampanaD WHERE ID = @ID AND Situacion = ISNULL(@Situacion, Situacion)
      EXEC spCampanaCorreoEnviar @ID, @Pagina, @Asunto, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      UPDATE CampanaCfgCorreo 
         SET SiguienteEnvio = CASE @Frecuencia 
				WHEN 'DIARIA'  THEN DATEADD(day, 1, @Fecha)
				WHEN 'SEMANAL' THEN DATEADD(week, 1, @Fecha)
				WHEN 'MENSUAL' THEN DATEADD(month, 1, @Fecha)
				WHEN 'ANUAL' THEN DATEADD(year, 1, @Fecha)
                                ELSE NULL
			      END
       WHERE CURRENT OF crCampanaCfgCorreo
    END
    FETCH NEXT FROM crCampanaCfgCorreo INTO @ID, @FechaD, @FechaA, @Frecuencia, @Situacion, @Pagina, @Asunto
  END  -- While
  CLOSE crCampanaCfgCorreo
  DEALLOCATE crCampanaCfgCorreo
  DROP TABLE #CampanaCorreoEnviar


  DECLARE crCampanaPendiente CURSOR LOCAL FOR
   SELECT ID, TieneVigencia, CASE WHEN TieneVigencia = 1 THEN FechaD ELSE @Fecha END, CASE WHEN TieneVigencia = 1 THEN FechaA ELSE @Fecha END, CampanaTipo
     FROM Campana
    WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE'

  OPEN crCampanaPendiente
  FETCH NEXT FROM crCampanaPendiente INTO @ID, @TieneVigencia, @FechaD, @FechaA, @CampanaTipo
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @ConcluirCampana = 0

      IF EXISTS(SELECT * FROM CampanaD d JOIN CampanaTipoSituacion s ON s.CampanaTipo = @CampanaTipo AND s.Situacion = d.Situacion WHERE d.ID = @ID AND s.Flujo <> 'Final')
      BEGIN
        IF @TieneVigencia = 1 AND NOT @Fecha BETWEEN @FechaD AND @FechaA
          SELECT @ConcluirCampana = 1
      END ELSE
        SELECT @ConcluirCampana = 1

      IF @ConcluirCampana = 1
        UPDATE Campana SET Estatus = 'CONCLUIDO', FechaConclusion = @FechaTrabajo WHERE CURRENT OF crCampanaPendiente
    END
    FETCH NEXT FROM crCampanaPendiente INTO @ID, @TieneVigencia, @FechaD, @FechaA, @CampanaTipo
  END  -- While
  CLOSE crCampanaPendiente
  DEALLOCATE crCampanaPendiente

  RETURN
END
GO


/**************** spCampanaGenerarProyecto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaGenerarProyecto') and type = 'P') drop procedure dbo.spCampanaGenerarProyecto
GO
CREATE PROCEDURE spCampanaGenerarProyecto
			@ID		int,
			@RID		int,
			@ProyectoMov	varchar(20),
			@Plantilla	varchar(50)
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @Empresa		char(5),
    @Sucursal		int,
    @Moneda		varchar(10),
    @TipoCambio		float,
    @ContactoTipo	varchar(20),
    @Contacto		varchar(10), 
    @Prospecto		varchar(10), 
    @Cliente		varchar(10), 
    @Proveedor		varchar(10), 
    @Personal		varchar(10), 
    @Agente		varchar(10),
    @ProyectoID		int

  IF NULLIF(RTRIM(@ProyectoMov), '') IS NULL RETURN
  SELECT @Plantilla = NULLIF(RTRIM(@Plantilla), '')
  SELECT @ContactoTipo = ContactoTipo, @Contacto = Contacto FROM CampanaD WHERE ID = @ID AND RID = @RID
  IF UPPER(@ContactoTipo) = 'PROSPECTO' SELECT @Prospecto = @Contacto ELSE
  IF UPPER(@ContactoTipo) = 'CLIENTE'   SELECT @Cliente   = @Contacto ELSE
  IF UPPER(@ContactoTipo) = 'PROVEEDOR' SELECT @Proveedor = @Contacto ELSE
  IF UPPER(@ContactoTipo) = 'PERSONAL'  SELECT @Personal  = @Contacto ELSE
  IF UPPER(@ContactoTipo) = 'AGENTEL'   SELECT @Agente    = @Contacto 

  SELECT @Empresa = c.Empresa, @Sucursal = c.Sucursal
    FROM Campana c 
   WHERE c.ID = @ID 

  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda
   
  INSERT Proyecto (
         UltimoCambio, Sucursal,  SucursalOrigen, OrigenTipo, Origen, OrigenID, Empresa,   Usuario,   Estatus,     Mov,          FechaEmision,   Concepto,   UEN,   Referencia,   Observaciones,   Moneda,  TipoCambio,  ContactoTipo,  Prospecto,  Cliente,  Proveedor,  Personal,  Agente)
  SELECT GETDATE(),    @Sucursal, @Sucursal,      'CMP',      c.Mov,  c.MovID,  c.Empresa, c.Usuario, 'CONFIRMAR', @ProyectoMov, c.FechaEmision, c.Concepto, c.UEN, c.Referencia, c.Observaciones, @Moneda, @TipoCambio, @ContactoTipo, @Prospecto, @Cliente, @Proveedor, @Personal, @Agente
    FROM Campana c
   WHERE c.ID = @ID
  SELECT @ProyectoID = SCOPE_IDENTITY()

  IF @Plantilla IS NOT NULL
    EXEC spProyectoNuevo NULL, @ProyectoID, @Plantilla, @Sucursal
  RETURN
END
GO

/**************** spCampanaGenerarGestion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaGenerarGestion') and type = 'P') drop procedure dbo.spCampanaGenerarGestion
GO
CREATE PROCEDURE spCampanaGenerarGestion
			@ID		int,
			@RID		int,
			@GestionMov	varchar(20),
			@GestionAsunto	varchar(255),
			@GestionPara	varchar(10)
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @Empresa		char(5),
    @Sucursal		int,
  /*  @Moneda		varchar(10),
    @TipoCambio		float,
    @ContactoTipo	varchar(20),
    @Contacto		varchar(10), 
    @Prospecto		varchar(10), 
    @Cliente		varchar(10), 
    @Proveedor		varchar(10), 
    @Personal		varchar(10), 
    @Agente		varchar(10),*/
    @GestionID		int

  IF NULLIF(RTRIM(@GestionMov), '') IS NULL RETURN
  SELECT @Empresa = c.Empresa, @Sucursal = c.Sucursal
    FROM Campana c 
   WHERE c.ID = @ID 

/*  SELECT @ContactoTipo = ContactoTipo, @Contacto = Contacto FROM CampanaD WHERE ID = @ID AND RID = @RID
  IF UPPER(@ContactoTipo) = 'PROSPECTO' SELECT @Prospecto = @Contacto ELSE
  IF UPPER(@ContactoTipo) = 'CLIENTE'   SELECT @Cliente   = @Contacto ELSE
  IF UPPER(@ContactoTipo) = 'PROVEEDOR' SELECT @Proveedor = @Contacto ELSE
  IF UPPER(@ContactoTipo) = 'PERSONAL'  SELECT @Personal  = @Contacto ELSE
  IF UPPER(@ContactoTipo) = 'AGENTEL'   SELECT @Agente    = @Contacto 

  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda
  */ 
  INSERT Gestion (
         UltimoCambio, Sucursal,  SucursalOrigen, OrigenTipo, Origen, OrigenID, Empresa,   Usuario,   Estatus,      Mov,         FechaEmision,   Concepto,   UEN,   Referencia,   Observaciones,   Asunto/*,   Moneda,  TipoCambio,  ContactoTipo,  Prospecto,  Cliente,  Proveedor,  Personal,  Agente*/)
  SELECT GETDATE(),    @Sucursal, @Sucursal,      'CMP',      c.Mov,  c.MovID,  c.Empresa, c.Usuario, 'SINAFECTAR', @GestionMov, c.FechaEmision, c.Concepto, c.UEN, c.Referencia, c.Observaciones, @GestionAsunto/*, @Moneda, @TipoCambio, @ContactoTipo, @Prospecto, @Cliente, @Proveedor, @Personal, @Agente*/
    FROM Campana c
   WHERE c.ID = @ID
  SELECT @GestionID = SCOPE_IDENTITY()

  INSERT GestionPara (
  	 ID,          Usuario,      Participacion, Sucursal,  SucursalOrigen)
  VALUES (@GestionID, @GestionPara, 'Requerido',   @Sucursal, @Sucursal)
  
  EXEC spAfectar 'GES', @GestionID, @EnSilencio = 1
  RETURN
END
GO

/**************** spCampanaActualizarSituacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaActualizarSituacion') and type = 'P') drop procedure dbo.spCampanaActualizarSituacion --ARCC Campanas
GO
CREATE PROCEDURE spCampanaActualizarSituacion
			@ID		int,
			@RID		int
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE	@ContactoTipo		varchar(20),
  		@Contacto		varchar(10),
		@Situacion		varchar(50),
		@SituacionUsuario	varchar(10),
		@SituacionFecha		datetime,
		@Observaciones		varchar(100),
		
		@CampanaMov		varchar(20),
		@CampanaMovID		varchar(20),
		@Empresa		varchar(5),
		@Usuario		varchar(10)
  
  
  SELECT @CampanaMov = Mov, @CampanaMovID = MovID, @Empresa = Empresa, @Usuario = Usuario FROM Campana WHERE ID = @ID
  SELECT @ContactoTipo = ContactoTipo, @Contacto = Contacto, @Situacion = Situacion, @SituacionFecha = SituacionFecha, @SituacionUsuario = Usuario, @Observaciones = SUBSTRING(Observaciones,1,100) FROM CampanaD WHERE ID = @ID AND RID = @RID

  IF RTRIM(UPPER(@ContactoTipo)) = 'CLIENTE' 
  BEGIN
    IF EXISTS(SELECT * FROM CtaSituacion WHERE RAMA = 'CXC' AND Situacion = @Situacion AND CampanaMov = @CampanaMov AND CampanaMovID = @CampanaMovID)	
      EXEC spCambiarCtaSituacion 'CXC', @Contacto, @Situacion, @SituacionFecha, @SituacionUsuario, @Observaciones, @Empresa, @Usuario
  END  
  IF RTRIM(UPPER(@ContactoTipo)) = 'PROSPECTO' 
  BEGIN
    IF EXISTS(SELECT * FROM CtaSituacion WHERE RAMA = 'CMP' AND Situacion = @Situacion AND CampanaMov = @CampanaMov AND CampanaMovID = @CampanaMovID)	
      EXEC spCambiarCtaSituacion 'CMP', @Contacto, @Situacion, @SituacionFecha, @SituacionUsuario, @Observaciones, @Empresa, @Usuario
  END  

  IF RTRIM(UPPER(@ContactoTipo)) = 'PROVEEDOR' 
  BEGIN
    IF EXISTS(SELECT * FROM CtaSituacion WHERE RAMA = 'CXP' AND Situacion = @Situacion AND CampanaMov = @CampanaMov AND CampanaMovID = @CampanaMovID)	
      EXEC spCambiarCtaSituacion 'CXP', @Contacto, @Situacion, @SituacionFecha, @SituacionUsuario, @Observaciones, @Empresa, @Usuario
  END  

  IF RTRIM(UPPER(@ContactoTipo)) = 'PERSONAL' 
  BEGIN
    IF EXISTS(SELECT * FROM CtaSituacion WHERE RAMA = 'RH' AND Situacion = @Situacion AND CampanaMov = @CampanaMov AND CampanaMovID = @CampanaMovID)	
      EXEC spCambiarCtaSituacion 'RH', @Contacto, @Situacion, @SituacionFecha, @SituacionUsuario, @Observaciones, @Empresa, @Usuario
  END  
  RETURN
END
GO

/**************** fnCampanaSituacionPorOmision ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCampanaSituacionPorOmision') DROP FUNCTION fnCampanaSituacionPorOmision
GO
CREATE FUNCTION fnCampanaSituacionPorOmision (@ID int)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CampanaTipo		varchar(50),
    @SituacionPorOmision	varchar(30)

  SELECT @CampanaTipo = CampanaTipo
    FROM Campana c
   WHERE ID = @ID

  SELECT TOP(1) @SituacionPorOmision = Situacion
    FROM CampanaTipoSituacion
   WHERE CampanaTipo = @CampanaTipo AND Flujo = 'Inicial'
   ORDER BY Orden

  RETURN(@SituacionPorOmision)
END
GO



-- select * from campanad
-- select * from campanatarea
-- update campanad set situacion = 'sin Contacto' where rid=4
-- update campanad set situacion = 'Esta Interesado' where rid=4
if exists (select * from sysobjects where id = object_id('dbo.tgCampanaDABC') and sysstat & 0xf = 8) drop trigger dbo.tgCampanaDABC
GO
CREATE TRIGGER tgCampanaDABC ON CampanaD
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @IDN		int,
    @IDA		int,
    @RIDN		int,
    @RIDA		int,
    @Mov		varchar(20),
    @MovID		varchar(20),
    @SituacionN		varchar(50),
    @SituacionA		varchar(50),
    @Empresa		varchar(5),
    @Sucursal		int,
    @CampanaID		int,
    @CampanaRID		int,
    @CampanaTipo	varchar(50),
    @Pagina		varchar(20), 
    @Asunto		varchar(100),
    @Accion		varchar(50),
    @ProyectoMov	varchar(20), 
    @ProyectoPlantilla	varchar(50), 
    @CampanaMov		varchar(20), 
    @CampanaMovID	varchar(20), 
    @ContactoTipo	varchar(20), 
    @Contacto		varchar(10),
    @Usuario		varchar(10),
    @Hoy		datetime,
    @Ok			int,
    @OkRef		varchar(255),
    @Cliente		varchar(10),
    @Proveedor		varchar(10),
    @Personal		varchar(10),
    @Agente		varchar(10),
    @Almacen		varchar(10),
    @Moneda		varchar(10),
    @TipoCambio		float,
    @Tipo		varchar(20),
    @OportunidadID	int,
    @OportunidadMov	varchar(20),
    @OportunidadMovID	varchar(20),
    @GestionMov		varchar(20),
    @GestionAsunto	varchar(255),
    @GestionPara	varchar(10)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @IDN = ID, @RIDN = RID, @SituacionN = Situacion, @Contacto = Contacto, @ContactoTipo = ContactoTipo, @Usuario = Usuario FROM Inserted
  SELECT @IDA = ID, @RIDA = RID, @SituacionA = Situacion FROM Deleted

  IF @IDN IS NULL 
  BEGIN
    DELETE CampanaTarea    WHERE ID = @IDA AND RID = @RIDA
    DELETE CampanaEvento   WHERE ID = @IDA AND RID = @RIDA
    DELETE CampanaEncuesta WHERE ID = @IDA AND RID = @RIDA
  END ELSE
  IF @SituacionN <> @SituacionA
  BEGIN
    SELECT @Hoy = dbo.fnFechaSinHora(GETDATE())
    SELECT @Mov = Mov, @MovID = MovID, @Empresa = Empresa, @Sucursal = Sucursal, @CampanaTipo = CampanaTipo, @Agente = Agente FROM Campana WHERE ID = @IDN
    SELECT @Almacen = MIN(Almacen) FROM Alm WHERE Sucursal = @Sucursal AND Estatus = 'ALTA'
    SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
      FROM EmpresaCfg cfg, Mon m
     WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

    -- Insertar Tareas  
    INSERT CampanaTarea  (ID, RID, Situacion, Asunto, Estado, Inicio, Vencimiento)
    SELECT @IDN, @RIDN, @SituacionN, Tarea, 'No comenzada', @Hoy, DATEADD(day, Dias, @Hoy)
      FROM CampanaTipoSituacionTarea 
     WHERE CampanaTipo = @CampanaTipo AND Situacion = @SituacionN 
       AND Tarea NOT IN (SELECT Asunto FROM CampanaTarea WHERE ID = @IDN AND RID = @RIDN)
     ORDER BY Orden

    DECLARE crCampanaCfgSituacion CURSOR LOCAL FOR
     SELECT UPPER(Accion), Pagina, Asunto, ProyectoMov, ProyectoPlantilla, CampanaMov, CampanaMovID, OportunidadMov, NULLIF(RTRIM(GestionMov), ''), NULLIF(RTRIM(GestionAsunto), ''), NULLIF(RTRIM(GestionPara), '')
       FROM CampanaCfgSituacion
      WHERE ID = @IDN AND Situacion = @SituacionN AND Estatus = 'ALTA'

    OPEN crCampanaCfgSituacion
    FETCH NEXT FROM crCampanaCfgSituacion INTO @Accion, @Pagina, @Asunto, @ProyectoMov, @ProyectoPlantilla, @CampanaMov, @CampanaMovID, @OportunidadMov, @GestionMov, @GestionAsunto, @GestionPara
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Accion = 'ENVIAR CORREO'
        BEGIN
          CREATE TABLE #CampanaCorreoEnviar (RID int PRIMARY KEY NOT NULL)
          INSERT #CampanaCorreoEnviar(RID) VALUES (@RIDN)
          EXEC spCampanaCorreoEnviar @IDN, @Pagina, @Asunto, NULL, @Ok OUTPUT, @OkRef OUTPUT
          DROP TABLE #CampanaCorreoEnviar
        END ELSE
        IF @Accion = 'GENERAR PROYECTO'
          EXEC spCampanaGenerarProyecto @IDN, @RIDN, @ProyectoMov, @ProyectoPlantilla
        ELSE
        IF @Accion = 'GENERAR GESTION'
          EXEC spCampanaGenerarGestion @IDN, @RIDN, @GestionMov, @GestionAsunto, @GestionPara
        ELSE
        IF @Accion IN ('COPIAR CONTACTO', 'MOVER CONTACTO', 'ELIMINAR CONTACTO')
        BEGIN
          IF @Accion IN ('COPIAR CONTACTO', 'MOVER CONTACTO')
          BEGIN
            SELECT @CampanaID = NULL
            SELECT @CampanaID = MIN(ID)
              FROM Campana
             WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE' AND Mov = @CampanaMov AND MovID = @CampanaMovID
            IF @CampanaID IS NOT NULL
            BEGIN
              IF NOT EXISTS(SELECT * FROM CampanaD WHERE ID = @CampanaID AND Contacto = @Contacto AND ContactoTipo = @ContactoTipo)
              BEGIN
                INSERT CampanaD (
                       ID, Contacto, ContactoTipo, Situacion, Usuario) 
                SELECT @CampanaID, @Contacto, @ContactoTipo, dbo.fnCampanaSituacionPorOmision(@IDN), @Usuario
                SELECT @CampanaRID = SCOPE_IDENTITY()
                INSERT CampanaEvento (
                       ID,         RID,         FechaHora, Tipo, Situacion, SituacionFecha, Observaciones, Sucursal, SucursalOrigen, Comentarios)
                SELECT @CampanaID, @CampanaRID, FechaHora, Tipo, Situacion, SituacionFecha, Observaciones, Sucursal, SucursalOrigen, Comentarios
                  FROM CampanaEvento
                 WHERE ID = @IDN AND RID = @RIDN
              END
            END
          END
          IF (@Accion = 'MOVER CONTACTO' AND @CampanaID IS NOT NULL) OR (@Accion = 'ELIMINAR CONTACTO')
          BEGIN
            DELETE CampanaD      WHERE ID = @IDN AND RID = @RIDN
            DELETE CampanaEvento WHERE ID = @IDN AND RID = @RIDN
            DELETE CampanaTarea  WHERE ID = @IDN AND RID = @RIDN
          END
        END ELSE
        IF UPPER(@ContactoTipo) = 'PROSPECTO'
        BEGIN
          IF @Accion IN ('GENERAR CLIENTE', 'GENERAR OPORTUNIDAD')
          BEGIN
            IF @Accion = 'GENERAR OPORTUNIDAD' SELECT @Tipo = 'Oportunidad' ELSE SELECT @Tipo = 'Cliente'
            EXEC spConsecutivo 'Cte', @Sucursal, @Cliente OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @AutoGenerar = 1
            INSERT Cte (
                   Cliente,  Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Plano, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, TelefonosLada, Fax, PedirTono, /*PaginaWeb, */Comentarios, Categoria, Grupo, Familia, SIC, Tipo,  Agente, Estatus, Usuario,  Alta)
            SELECT @Cliente, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Plano, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, TelefonosLada, Fax, PedirTono, /*PaginaWeb, */Comentarios, Categoria, Grupo, Familia, SIC, @Tipo, Agente, 'ALTA',  @Usuario, GETDATE()
              FROM Prospecto
             WHERE Prospecto = @Contacto

            SET IDENTITY_INSERT CteCto ON;
            INSERT CteCto (
                   Cliente,  ID, Nombre, ApellidoPaterno, ApellidoMaterno, Atencion, Tratamiento, Cargo, Grupo, FechaNacimiento, Telefonos, Extencion, eMail, Fax, PedirTono, Tipo, Sexo, Usuario)
            SELECT @Cliente, ID, Nombre, ApellidoPaterno, ApellidoMaterno, Atencion, Tratamiento, Cargo, Grupo, FechaNacimiento, Telefonos, Extencion, eMail, Fax, PedirTono, Tipo, Sexo, Usuario
              FROM ProspectoCto
             WHERE Prospecto = @Contacto
            SET IDENTITY_INSERT CteCto OFF;
            UPDATE Prospecto
               SET Tipo = @Tipo
             WHERE Prospecto = @Contacto
            INSERT FormaExtraValor (
                   FormaTipo, Aplica,    AplicaClave, Campo, Valor)
            SELECT FormaTipo, 'Cliente', @Cliente,    Campo, Valor
              FROM FormaExtraValor
             WHERE Aplica = 'Prospecto' AND AplicaClave = @Contacto

            INSERT CtaBitacora (Modulo, Cuenta,   Fecha,     Evento,    Usuario)
            SELECT DISTINCT     'CXC',  @Cliente, FechaHora, Situacion, @Usuario
              FROM CampanaEvento
             WHERE ID = @IDN AND RID = @RIDN
          END ELSE
          IF @Accion = 'GENERAR PROVEEDOR'
          BEGIN
            EXEC spConsecutivo 'Prov', @Sucursal, @Proveedor OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @AutoGenerar = 1
            INSERT Prov (
                   Proveedor,  Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Plano, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, /*TelefonosLada, */Fax, PedirTono, /*PaginaWeb, *//*Comentarios, */Categoria, /*Grupo, */Familia, Tipo,        Agente, Estatus, /*Usuario,  */Alta)
            SELECT @Proveedor, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Plano, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, /*TelefonosLada, */Fax, PedirTono, /*PaginaWeb, *//*Comentarios, */Categoria, /*Grupo, */Familia, 'Proveedor', Agente, 'ALTA',  /*@Usuario, */GETDATE()
              FROM Prospecto
             WHERE Prospecto = @Contacto
            UPDATE Prospecto
               SET Tipo = 'Proveedor'
             WHERE Prospecto = @Contacto
            INSERT FormaExtraValor (
                   FormaTipo, Aplica,      AplicaClave, Campo, Valor)
            SELECT FormaTipo, 'Proveedor', @Proveedor,  Campo, Valor
              FROM FormaExtraValor
             WHERE Aplica = 'Prospecto' AND AplicaClave = @Contacto
            INSERT CtaBitacora (Modulo, Cuenta,     Fecha,     Evento,    Usuario)
            SELECT DISTINCT     'CXP',  @Proveedor, FechaHora, Situacion, @Usuario
              FROM CampanaEvento
             WHERE ID = @IDN AND RID = @RIDN
          END ELSE
          IF @Accion = 'GENERAR AGENTE'
          BEGIN
            EXEC spConsecutivo 'Agente', @Sucursal, @Agente OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @AutoGenerar = 1
            INSERT Agente (
                   Agente,  Nombre, Direccion, /*DireccionNumero, DireccionNumeroInt, EntreCalles, Plano, Observaciones, Delegacion, */Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, /*TelefonosLada, Fax, PedirTono, *//*PaginaWeb, *//*Comentarios, */Categoria, /*Grupo, */Familia, Tipo,     /*Agente, */Estatus, /*Usuario,  */Alta)
            SELECT @Agente, Nombre, Direccion, /*DireccionNumero, DireccionNumeroInt, EntreCalles, Plano, Observaciones, Delegacion, */Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, /*TelefonosLada, Fax, PedirTono, *//*PaginaWeb, *//*Comentarios, */Categoria, /*Grupo, */Familia, 'Agente', /*Agente, */'ALTA',  /*@Usuario, */GETDATE()
              FROM Prospecto
             WHERE Prospecto = @Contacto
            UPDATE Prospecto
               SET Tipo = 'Agente'
             WHERE Prospecto = @Contacto
            INSERT FormaExtraValor (
                   FormaTipo, Aplica,   AplicaClave, Campo, Valor)
            SELECT FormaTipo, 'Agente', @Agente,     Campo, Valor
              FROM FormaExtraValor
             WHERE Aplica = 'Prospecto' AND AplicaClave = @Contacto
            INSERT CtaBitacora (Modulo,   Cuenta,  Fecha,     Evento,    Usuario)
            SELECT DISTINCT     'AGENT',  @Agente, FechaHora, Situacion, @Usuario
              FROM CampanaEvento
             WHERE ID = @IDN AND RID = @RIDN
          END ELSE
          IF @Accion = 'GENERAR PERSONAL'
          BEGIN
            EXEC spConsecutivo 'Personal', @Sucursal, @Personal OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @AutoGenerar = 1
            INSERT Personal (
                   Personal,  Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Plano, Observaciones, */Delegacion, Colonia, Poblacion, Estado, Pais, /*Zona, */CodigoPostal, Registro, Registro2, Telefono,  /*TelefonosLada, Fax, PedirTono, *//*PaginaWeb, *//*Comentarios, */Categoria, Grupo, /*Familia, */Tipo,       /*Agente, */Estatus, /*Usuario,  */FechaAlta)
            SELECT @Personal, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Plano, Observaciones, */Delegacion, Colonia, Poblacion, Estado, Pais, /*Zona, */CodigoPostal, RFC,      CURP,      Telefonos, /*TelefonosLada, Fax, PedirTono, *//*PaginaWeb, *//*Comentarios, */Categoria, Grupo, /*Familia, */'Empleado', /*Agente, */'ALTA',  /*@Usuario, */GETDATE()
              FROM Prospecto
             WHERE Prospecto = @Contacto
            UPDATE Prospecto
               SET Tipo = 'Personal'
             WHERE Prospecto = @Contacto
            INSERT FormaExtraValor (
                   FormaTipo, Aplica,     AplicaClave, Campo, Valor)
            SELECT FormaTipo, 'Personal', @Personal,   Campo, Valor
              FROM FormaExtraValor
             WHERE Aplica = 'Prospecto' AND AplicaClave = @Contacto
            INSERT CtaBitacora (Modulo, Cuenta,    Fecha,     Evento,    Usuario)
            SELECT DISTINCT     'RH',   @Personal, FechaHora, Situacion, @Usuario
              FROM CampanaEvento
             WHERE ID = @IDN AND RID = @RIDN
          END 

          IF @Accion = 'GENERAR OPORTUNIDAD' AND UPPER(@ContactoTipo) IN ('PROSPECTO', 'CLIENTE') AND NULLIF(RTRIM(@OportunidadMov), '') IS NOT NULL
          BEGIN
            IF UPPER(@ContactoTipo) = 'CLIENTE' SELECT @Cliente = @Contacto

            INSERT Venta (
                    Empresa,  Cliente,  Mov,             FechaEmision, Usuario,  Moneda,  TipoCambio,  Agente,  Estatus,      Almacen)
            VALUES (@Empresa, @Cliente, @OportunidadMov, @Hoy,         @Usuario, @Moneda, @TipoCambio, @Agente, 'SINAFECTAR', @Almacen)
            SELECT @OportunidadID = SCOPE_IDENTITY()
            EXEC spAfectar 'VTAS', @OportunidadID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
            SELECT @OportunidadMovID = MovID FROM Venta WHERE ID = @OportunidadID
            EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'CMP', @IDN, @Mov, @MovID, 'VTAS', @OportunidadID, @OportunidadMov, @OportunidadMovID, @Ok OUTPUT
          END
                    
        END
        IF @Accion = 'ACTUALIZAR SITUACION CONTACTO'
          EXEC spCampanaActualizarSituacion @IDN, @RIDN
        
      END
      FETCH NEXT FROM crCampanaCfgSituacion INTO @Accion, @Pagina, @Asunto, @ProyectoMov, @ProyectoPlantilla, @CampanaMov, @CampanaMovID, @OportunidadMov, @GestionMov, @GestionAsunto, @GestionPara
    END  -- While
    CLOSE crCampanaCfgSituacion
    DEALLOCATE crCampanaCfgSituacion

  END
  EXEC spOk_RAISERROR @Ok, @OkRef
END
GO

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.cCampanaD') and sysstat & 0xf = 2) 
	DROP VIEW dbo.cCampanaD
GO
CREATE VIEW cCampanaD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Sucursal,
  SucursalOrigen,
  Contacto,
  ContactoTipo,
  Situacion,
  Observaciones,
  Calificacion,
  Usuario,
  EnviarA,
  ListaPreciosEsp,
  Instruccion,
  MapaLatitud,
  MapaLongitud,
  MapaPrecision,
  Almacen,
  FechaD,
  FechaA
FROM
  CampanaD
GO

/**************** spCampanaUsuarioAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaUsuarioAsignar') and sysstat & 0xf = 4) drop procedure dbo.spCampanaUsuarioAsignar
GO
CREATE PROCEDURE spCampanaUsuarioAsignar
			@Estacion	int,
			@ID		int,
			@Usuario	varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  IF EXISTS(SELECT * FROM Usuario WHERE Usuario=@Usuario)
    UPDATE CampanaD SET Usuario = @Usuario WHERE ID = @ID AND RID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
  RETURN
END
GO

/** fnCampanaTipoSituacionIcono */
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCampanaTipoSituacionIcono') DROP FUNCTION fnCampanaTipoSituacionIcono
GO
CREATE FUNCTION fnCampanaTipoSituacionIcono (@ID int, @Situacion varchar(50))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  RETURN(SELECT Icono FROM Campana c JOIN CampanaTipoSituacion t ON t.CampanaTipo = c.CampanaTipo AND t.Situacion = @Situacion WHERE c.ID = @ID)
END
GO

/**************** spCampanaEliminarContacto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaEliminarContacto') and sysstat & 0xf = 4) drop procedure dbo.spCampanaEliminarContacto
GO
CREATE PROCEDURE spCampanaEliminarContacto
			@ID		int,
			@RID		int
--//WITH ENCRYPTION
AS BEGIN
  DELETE CampanaD
   WHERE ID = @ID AND RID = @RID
  RETURN
END
GO

/**************** spCampanaAgregarContactos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampanaAgregarContactos') and type = 'P') drop procedure dbo.spCampanaAgregarContactos
GO
CREATE PROCEDURE spCampanaAgregarContactos
		    @Estacion		int,
		    @Usuario		varchar(10),
    		    @ID               	int,		
    		    @ContactoTipo       varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SituacionPorOmision	varchar(30),
    @Contacto			varchar(10)

  SELECT @SituacionPorOmision = dbo.fnCampanaSituacionPorOmision(@ID)

  DECLARE crListaSt CURSOR LOCAL FOR
  SELECT DISTINCT Clave
    FROM ListaSt
   WHERE Estacion = @Estacion AND Clave NOT IN (SELECT Contacto FROM CampanaD WHERE ID = @ID AND ContactoTipo = @ContactoTipo)
  OPEN crListaSt
  FETCH NEXT FROM crListaSt INTO @Contacto
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      INSERT CampanaD (
              ID,  ContactoTipo,  Situacion,            Contacto,  Usuario)
      VALUES (@ID, @ContactoTipo, @SituacionPorOmision, @Contacto, @Usuario)
    END
    FETCH NEXT FROM crListaSt INTO @Contacto
  END  -- While
  CLOSE crListaSt
  DEALLOCATE crListaSt
  RETURN
END
GO

/**************** ProspectoIntelisis ****************/
-- Author:			Yessenia Villacis
-- Create date:		12-Dic-2008
if not exists(select * from SysTabla where SysTabla = 'ProspectoIntelisis')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProspectoIntelisis','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ProspectoIntelisis') and type = 'U') 
CREATE TABLE dbo.ProspectoIntelisis(
      Prospecto varchar(10) NOT NULL,
      SistemaActual varchar(100) NULL,
      NumeroUsuarios int NULL,
      Problema text NULL,
      eMailSistemas varchar(50) NULL,
      emailFinanzas varchar(50) NULL,
      CoordinaEvaluacion varchar(50) NULL,
      SistemaExperto varchar(50) NULL
  CONSTRAINT priProspectoIntelisis PRIMARY KEY  CLUSTERED
  (Prospecto)
)
GO

/**************** TipoFuente ****************/
-- Author:			Yessenia Villacis
-- Create date:		15-Dic-2008
EXEC spALTER_TABLE 'ProspectoIntelisis', 'NombreSistemas', 'varchar(40) NULL'
EXEC spALTER_TABLE 'ProspectoIntelisis', 'NombreFinanzas', 'varchar(40) NULL'
EXEC spALTER_TABLE 'ProspectoIntelisis', 'MontoEstimado', 'varchar(40) NULL'
EXEC spALTER_TABLE 'ProspectoIntelisis', 'TipoLicenciamiento', 'varchar(40) NULL'

GO

/**************** ProspectoInteresadoEnD ****************/
-- Author:			Yessenia Villacis
-- Create date:		12-Dic-2008
if not exists(select * from SysTabla where SysTabla = 'ProspectoInteresadoEnD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProspectoInteresadoEnD','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.[ProspectoInteresadoEnD]') and type = 'U') 
CREATE TABLE [dbo].[ProspectoInteresadoEnD](
	Prospecto varchar(10) NOT NULL,
	InteresadoEn [varchar](100) NOT NULL,
	Articulo [varchar](20) NULL,
	 CONSTRAINT [priProspectoInteresadoEnD] PRIMARY KEY CLUSTERED 
	(
		Prospecto,
		[InteresadoEn] ASC
	)
)
GO


/**************** TipoEmpresa ****************/
-- Author:			Yessenia Villacis
-- Create date:		12-Dic-2008
if not exists(select * from SysTabla where SysTabla = 'TipoEmpresa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoEmpresa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoEmpresa') and type = 'U') 
CREATE TABLE [dbo].[TipoEmpresa](
	[TipoEmpresaID] [smallint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](40) NULL,
	 CONSTRAINT [PK_TipoEmpresa] PRIMARY KEY CLUSTERED 
	(
		[TipoEmpresaID] ASC
	)
)
GO

/**************** TipoFuente ****************/
-- Author:			Yessenia Villacis
-- Create date:		12-Dic-2008
if not exists(select * from SysTabla where SysTabla = 'TipoFuente')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoFuente','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoFuente') and type = 'U') 
CREATE TABLE [dbo].[TipoFuente](
	[TipoFuenteID] [smallint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](40) NULL,
	 CONSTRAINT [PK_TipoFuente] PRIMARY KEY CLUSTERED 
	(
		[TipoFuenteID] ASC
	)
)
GO

/**************** TipoFuente ****************/
-- Author:			Yessenia Villacis
-- Create date:		15-Dic-2008
if not exists(select * from SysTabla where SysTabla = 'TipoSistemaActual')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoSistemaActual','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoSistemaActual') and type = 'U') 
CREATE TABLE [dbo].[TipoSistemaActual](
	[TipoSistemaActualID] [smallint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](40) NULL,
	 CONSTRAINT [PK_TipoSistemaActual] PRIMARY KEY CLUSTERED 
	(
		[TipoSistemaActualID] ASC
	)
)
GO

/**************** TipoFuente ****************/
-- Author:			Yessenia Villacis
-- Create date:		15-Dic-2008
if not exists(select * from SysTabla where SysTabla = 'TipoSistemaExperto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoSistemaExperto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoSistemaExperto') and type = 'U') 
CREATE TABLE [dbo].[TipoSistemaExperto](
	[TipoSistemaExpertoID] [smallint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](40) NULL,
	 CONSTRAINT [PK_TipoSistemaExperto] PRIMARY KEY CLUSTERED 
	(
		[TipoSistemaExpertoID] ASC
	)
)
GO

/**************** TipoFuente ****************/
-- Author:			Yessenia Villacis
-- Create date:		15-Dic-2008
if not exists(select * from SysTabla where SysTabla = 'TipoCoordinaciónEvaluacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoCoordinaciónEvaluacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoCoordinaciónEvaluacion') and type = 'U') 
CREATE TABLE [dbo].[TipoCoordinaciónEvaluacion](
	[TipoCoordinaciónEvaluacionID] [smallint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](40) NULL,
	 CONSTRAINT [PK_TipoCoordinaciónEvaluacion] PRIMARY KEY CLUSTERED 
	(
		[TipoCoordinaciónEvaluacionID] ASC
	)
)
GO

/**************** TipoFuente ****************/
-- Author:			Yessenia Villacis
-- Create date:		15-Dic-2008
if not exists(select * from SysTabla where SysTabla = 'TipoRelacionReferencia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoRelacionReferencia','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoRelacionReferencia') and type = 'U') 
CREATE TABLE [dbo].[TipoRelacionReferencia](
	[TipoRelacionReferenciaID] [smallint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](40) NULL,
	 CONSTRAINT [PK_TipoRelacionReferencia] PRIMARY KEY CLUSTERED 
	(
		[TipoRelacionReferenciaID] ASC
	)
)
GO

/**************** TipoFuente ****************/
-- Author:			Yessenia Villacis
-- Create date:		15-Dic-2008
if not exists(select * from SysTabla where SysTabla = 'TipoLicenciamiento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoLicenciamiento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoLicenciamiento') and type = 'U') 
CREATE TABLE [dbo].[TipoLicenciamiento](
	[TipoLicenciamientoID] [smallint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](40) NULL,
	 CONSTRAINT [PK_TipoLicenciamiento] PRIMARY KEY CLUSTERED 
	(
		[TipoLicenciamientoID] ASC
	)
)
GO

/**************** TipoFuente ****************/
-- Author:			Yessenia Villacis
-- Create date:		15-Dic-2008
if not exists(select * from SysTabla where SysTabla = 'ProspectoCompetencia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProspectoCompetencia','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ProspectoCompetencia') and type = 'U') 
CREATE TABLE [dbo].[ProspectoCompetencia](
	[ProspectoCompetenciaID] [smallint] IDENTITY(1,1) NOT NULL,
	[Competencia] [varchar](10) NOT NULL,
	[Descripcion] [varchar](40) NULL,
	 CONSTRAINT [PK_ProspectoCompetencia] PRIMARY KEY CLUSTERED 
	(
		[Competencia] ASC
	)
)
GO

/**************** TipoFuente ****************/
-- Author:			Yessenia Villacis
-- Create date:		15-Dic-2008
if not exists(select * from SysTabla where SysTabla = 'ProspectoCompetenciaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProspectoCompetenciaD','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ProspectoCompetenciaD') and type = 'U') 
CREATE TABLE [dbo].[ProspectoCompetenciaD](
	Prospecto varchar(10) NOT NULL,
	[Competencia] [varchar](10) NOT NULL,
	 CONSTRAINT [PK_ProspectoCompetenciaD] PRIMARY KEY CLUSTERED 
	(
		Prospecto,Competencia ASC
	)
)
GO

/****** CampanaTipoSubSituacion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CampanaTipoSubSituacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampanaTipoSubSituacion','Maestro')

IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.CampanaTipoSubSituacion') and TYPE = 'U') 
  CREATE TABLE dbo.CampanaTipoSubSituacion (
	CampanaTipo		varchar(50)	NOT NULL,
	Situacion		varchar(50)	NOT NULL,
	SubSituacion	varchar(50)	NOT NULL,
	Orden			int		NULL
 	CONSTRAINT priCampanaTipoSubSituacion PRIMARY KEY  CLUSTERED (CampanaTipo, Situacion, SubSituacion)
  )
GO

/*** MovilUsuarioCfg ***/
if not exists(select * from SysTabla where SysTabla = 'MovilUsuarioCfg')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovilUsuarioCfg','Maestro')
GO 
IF NOT EXISTS(SELECT * FROM sysobjects where name ='MovilUsuarioCfg' and type ='U')
CREATE TABLE MovilUsuarioCfg(
    Empresa	            char(5)NOT NULL,
    Usuario	            varchar(10)NOT NULL,
    Agente	            varchar(10) NULL,
    PedidosAConsultar	int NULL,
    ContrasenaCorta	    bit NULL,
    IntentosBloquear	int NULL,
    DiasHistorico	    int NULL,
    Movimiento	        varchar(20) NULL,
    UltimaSincro	    datetime NULL,
    Almacen             varchar(30) Null,
CONSTRAINT priMovilUsuarioCfg PRIMARY KEY CLUSTERED(Usuario,Empresa))
GO
EXEC spAlter_Table 'MovilUsuarioCfg','MovDescr','varchar(20) Null'
EXEC spAlter_Table 'MovilUsuarioCfg','CobrosAConsultar','int Null'
EXEC spAlter_Table 'MovilUsuarioCfg','MonedaBase','char(10) Null'
EXEC spAlter_Table 'MovilUsuarioCfg','MovimientoCobro','varchar(20) Null'
EXEC spAlter_Table 'MovilUsuarioCfg','MovimientoAnticipo','varchar(20) Null'
EXEC spAlter_Table 'MovilUsuarioCfg','Sucursal','int Null'
GO
ALTER TABLE MovilUsuarioCfg ALTER COLUMN Agente varchar(10) NOT NULL
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'MovilUsuarioCfg' AND COLUMN_NAME = 'Almacen')
BEGIN
	ALTER TABLE MovilUsuarioCfg DROP COLUMN Almacen
END
GO
IF EXISTS(SELECT * FROM SYS.OBJECTS WHERE name = 'priMovilUsuarioCfg')
BEGIN
	ALTER TABLE MovilUsuarioCfg DROP CONSTRAINT priMovilUsuarioCfg 
END
GO
ALTER TABLE MovilUsuarioCfg ADD CONSTRAINT  priMovilUsuarioCfg PRIMARY KEY CLUSTERED(Empresa,Usuario,Agente)
GO

/*** CampanaAM ***/
if not exists(select * from SysTabla where SysTabla = 'CampanaAM')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampanaAM','Maestro')
GO 
IF NOT EXISTS(SELECT * FROM sysobjects where name ='CampanaAM' and type ='U')
CREATE TABLE CampanaAM(
    Estacion            int NOT NULL,
    ID                  int NOT NULL,
CONSTRAINT priCampanaAM PRIMARY KEY CLUSTERED(ID,Estacion))
GO

/*** CampanaMovilCfg ***/
if not exists(select * from SysTabla where SysTabla = 'CampanaMovilCfg')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampanaMovilCfg','Maestro')
GO 
IF NOT EXISTS(SELECT * FROM sysobjects where name ='CampanaMovilCfg' and type ='U')
CREATE TABLE CampanaMovilCfg(
    Empresa             char(5) NOT NULL,
    HorarioD            datetime NULL,
    HorarioA            datetime NULL,
    Duracion            int NULL,
    ServidorSMTP        varchar(255) NULL,
    iCalsPath           varchar(255) NULL,
CONSTRAINT priCampanaMovilCfg PRIMARY KEY CLUSTERED(Empresa))
GO
Exec spAlter_Table 'CampanaMovilCfg','ServidorSMTP','varchar(255) Null'	
Exec spAlter_Table 'CampanaMovilCfg','iCalsPath','varchar(255) Null'	
GO

/*** CampanaDTemp ***/
if not exists(select * from SysTabla where SysTabla = 'CampanaDTemp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampanaDTemp','N/A')
GO 
IF NOT EXISTS(SELECT * FROM sysobjects where name ='CampanaDTemp' and type ='U')
CREATE TABLE CampanaDTemp(
    RID           int NOT NULL,
    Cliente	      varchar(100)NULL,
    Situacion	  varchar(50)NULL,
    Observaciones varchar(100)NULL,
    Instruccion	  varchar(255)NULL,
    FechaD	      datetime NULL,
    FechaA	      datetime NULL,
    ListaPreciosEsp varchar(20)NULL,
CONSTRAINT priCampanaDTemp PRIMARY KEY CLUSTERED(RID))
GO
EXEC spAlter_Table 'CampanaDTemp','ListaPreciosEsp','varchar(20) Null'

/*******************************************  Movil  *******************************************/
/*** CteProcesarMovil ***/
if not exists(select * from SysTabla where SysTabla = 'CteProcesarMovil')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteProcesarMovil','Maestro')
GO 
IF NOT EXISTS(SELECT * FROM sysobjects where name ='CteProcesarMovil' and type ='U')
CREATE TABLE CteProcesarMovil(
    ID                  int identity(1,1),
    Empresa             char(5)NULL,
    Estacion            int NOT NULL,
    Cliente             varchar(10) NULL,
    Agente              varchar(10) NULL,
    AgenteNombre        varchar(100) NULL,
    ClienteNombre       varchar(100) NULL,
    EnviarA             int NULL,
    Tipo                varchar(15) NULL,
    Direccion           varchar(100) NULL,
    DireccionNumero     varchar(20) NULL,
    DireccionNumeroInt  varchar(20) NULL,
    Rama                varchar(10) NULL,
    Estatus             varchar(15) NULL,
    Categoria           varchar(50) NULL,
    Familia             varchar(50) NULL,
    Grupo               varchar(50) NULL,
    Espacio             varchar(10) NULL,
CONSTRAINT priCteProcesarMovil PRIMARY KEY CLUSTERED(ID))
GO
/*** OfertaMovilTemp ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'OfertaMovilTemp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OfertaMovilTemp','N/A')
if NOT EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.OfertaMovilTemp') and type = 'U') 
CREATE TABLE dbo.OfertaMovilTemp (
  GUID                  varchar(50) NOT NULL,
  RID                   int  IDENTITY,
  Empresa               varchar(5)      NULL,
  Sucursal              int             NULL, 
  Almacen               varchar(10)     NULL, 
  Agente                varchar(10)     NULL, 
  Movimiento            varchar(20)     NULL, 
  Moneda                varchar(10)     NULL,
  ListaPrecios          varchar(50)     NULL, 
  Articulo              varchar(20)     NULL, 
  SubCuenta             varchar(50)     NULL, 
  Unidad                varchar(50)     NULL, 
  PrecioSugerido        float           NULL,  
  Precio                float           NULL, 
  Descuento             float           NULL, 
  DescuentoImporte      float           NULL, 
  Comision              float           NULL, 
  ComisionPorcentaje    float           NULL, 
  OfertaID              int             NULL,       
CONSTRAINT priOfertaMovilTemp PRIMARY KEY CLUSTERED (GUID,RID)
)
GO
/* Agregar indices
  CREATE INDEX Lista ON OfertaMovilTemp(GUID,Articulo, ListaPrecios)
  CREATE INDEX Articulo ON OfertaMovilTemp(Articulo)
*/
/*** MovilPantallaVista ***/
if not exists(select * from SysTabla where SysTabla = 'MovilPantallaVista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovilPantallaVista','Maestro')
GO 
IF NOT EXISTS(SELECT * FROM sysobjects where name ='MovilPantallaVista' and type ='U')
CREATE TABLE MovilPantallaVista(
	IDMovilVista		 int identity,
    Empresa	             char(5)NOT NULL,
    Pantalla	         varchar(20)NOT NULL,
    Vista	             varchar(100)NULL,
CONSTRAINT priMovilPantallaVista PRIMARY KEY CLUSTERED(IDMovilVista,Pantalla,Empresa))
GO
/*** MovilVistaCampo ***/
if not exists(select * from SysTabla where SysTabla = 'MovilVistaCampo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovilVistaCampo','Maestro')
GO 
IF NOT EXISTS(SELECT * FROM sysobjects where name ='MovilVistaCampo' and type ='U')
CREATE TABLE MovilVistaCampo(
	IDMovilVista		int,
    Campo               varchar(100)NOT NULL,
    NecesarioMovil		bit DEFAULT(0) NOT NULL,
    Llave	            varchar(100)NULL,
    Requerido           bit NULL,
    Visible             bit NULL,
    Etiqueta            VARCHAR(100)NULL,
    Seccion             int NULL,
    Orden               int NULL,
    Formato             varchar(30)NULL,
    Longitud            varchar(30)NULL,
    Busqueda            bit NULL,
    Editable			bit NULL,
CONSTRAINT priMovilVistaCampo PRIMARY KEY CLUSTERED(IDMovilVista,Campo))
GO
Exec spAlter_Table 'MovilVistaCampo','Editable','bit Null'	
GO

/****** MovilVisitas ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'MovilVisitas')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovilVisitas','Maestro')

IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.MovilVisitas') and TYPE = 'U') 
  CREATE TABLE dbo.MovilVisitas (
	OrdenID  varchar(50) NOT NULL,  -- Movil
	ID		 int		 NOT NULL, -- Venta
	IDVisita varchar(10) NOT NULL  -- Agenda
 	CONSTRAINT priMovilVisitas PRIMARY KEY  CLUSTERED (OrdenID)
  )
GO
IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.MovilMoneda') and TYPE = 'U') 
  CREATE TABLE dbo.MovilMoneda (
    Empresa  char(5) NOT NULL,
    Moneda   char(10) NOT NULL,
 	CONSTRAINT priMovilMoneda PRIMARY KEY  CLUSTERED (Moneda,Empresa)
  )
GO
IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.MovilFormaPago') and TYPE = 'U') 
  CREATE TABLE dbo.MovilFormaPago (
    Empresa  char(5) NOT NULL,
    FormaPago   char(50) NOT NULL,
 	CONSTRAINT priMovilFormaPago PRIMARY KEY  CLUSTERED (FormaPago,Empresa)
  )
GO

/******* Adecuacion en Producto 25/07/2016 | Tabla 'WebCxCPendientesPaso' de Registro CxC Pendientes  ******/
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('WebCxCPendientesPaso') AND Type='U') 
-- Drop Table WebCxCPendientesPaso
	CREATE TABLE WebCxCPendientesPaso( 
	Movimiento		Varchar (20)  NULL , 
	MovId			Varchar (20)  NULL , 
	IdVisita        Int           Not Null, 
	IdCxC	        Int           Not Null, 
	Cliente         Varchar (10)  Not Null, 
	Saldo           Money  Default 0.00 , 
	Fecha           Datetime      NULL, 
	Seleccion       varchar(5)    NULL,
	CONSTRAINT priWebCxCPendientesPaso PRIMARY KEY  CLUSTERED (IdVisita, IdCxC, Cliente)
) 
GO 

IF NOT EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Agenda' AND Modulo = 'CMP')
INSERT INTO MovTipo (Modulo, Mov, Orden, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov, Grupo, Icono, Factor, ConsecutivoPorEmpresa, AfectarPresupuesto, ProyectoSugerir, TipoConsecutivo) VALUES ('CMP', 'Agenda', 30, 'CMP.A', NULL, 'CMP', 'Agenda', NULL, NULL, 1, 'Si', '(por Omision)', 'Movimiento', 'Modulo')
GO

SET DATEFIRST 7
SET ANSI_NULLS ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
GO
/**************** fnISGetArtOpcion ****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.fnISGetArtOpcion') AND type = 'Fn') 
	DROP FUNCTION dbo.fnISGetArtOpcion
GO
CREATE FUNCTION dbo.fnISGetArtOpcion
(
	@Articulo    varchar(20),
	@Agente      varchar(100) = NULL,
	@GUID		 varchar(50)
)
RETURNS XML
AS
BEGIN
  DECLARE 
    @Empresa char(5),
	@sXListaPrecios varchar(max),
	@XMLArt XML, 
	@XOpciones XML, 
	@XOpcion XML, 
	@XListaPrecios XML, 
	@XDetalle XML, 
	@XTasa XML,
	@sXTasa varchar(max),
	@Parcial  varchar(max)

    DECLARE @Lista TABLE(ID int identity(1,1),Lista varchar(100))

	SELECT @Empresa = Empresa
	  FROM MovilUsuarioCfg 
	 WHERE Agente = @Agente
	 
	SELECT @XMLArt = (
		SELECT Articulos.Articulo,REPLACE(Articulos.Descripcion1,':','')AS Descripcion1, REPLACE(Articulos.Descripcion2,':','')AS Descripcion2, REPLACE(Articulos.Categoria,':','')AS Categoria, 
			   Articulos.Unidad, Articulos.ImpuestoExento, REPLACE(Articulos.Tipo,':','')AS Tipo, Articulos.MonedaPrecio, REPLACE(Articulos.Almacen,':','')AS Almacen, Articulos.Disponible, 
			   REPLACE(Articulos.Grupo,':','')AS Grupo, REPLACE(Articulos.Linea,':','')AS Linea, REPLACE(Articulos.Familia,':','')AS Familia, Articulos.PrecioLista, 
			   TasaIVA,Articulos.Estatus, Articulos.Existencia, ArtJuego.Clave, ArtJuego.Descripcion
		  FROM (
				  SELECT DISTINCT Articulo.Articulo Articulo, 
  					 ISNULL(Articulo.Descripcion1, ' ') Descripcion1, 
  					 ISNULL(Articulo.Descripcion2, ' ') Descripcion2,  
  					 ISNULL(Articulo.Categoria,	   ' ') Categoria,
  					 ISNULL(Articulo.Unidad,	   ' ') Unidad, 
  					 ISNULL(Articulo.Tipo,		   ' ') Tipo,
  					 ISNULL(Articulo.MonedaPrecio, ' ') MonedaPrecio,
  					 ISNULL(Articulo.Impuesto1Excento,   '0') ImpuestoExento,
  					 ISNULL(Oferta.Almacen,        ' ') Almacen,
  					 CAST(CAST(ISNULL(ArtDisponible.Disponible,  ' ') AS DECIMAL(18, 2)) AS VARCHAR(15)) Disponible,
  					 ISNULL(Articulo.Grupo,		   ' ') Grupo,
  					 ISNULL(Articulo.Linea,		   ' ') Linea,
  					 ISNULL(Articulo.Familia,	   ' ') Familia,
  					 ISNULL(Articulo.PrecioLista,  ' ') PrecioLista,
  					 CAST(CAST(ISNULL(Articulo.Impuesto1,    ' ') AS DECIMAL(18, 2)) AS VARCHAR(15)) TasaIVA,
  					 ISNULL(Articulo.Estatus,	   ' ') Estatus,
  					 CAST(CAST(ISNULL(ArtDisponible.Existencias,   ' ') AS DECIMAL(18, 2)) AS VARCHAR(15)) Existencia
				FROM Art Articulo
				JOIN OfertaMovilTemp Oferta      ON Articulo.Articulo = Oferta.Articulo AND Articulo.Articulo = @Articulo
				LEFT JOIN ArtExistenciaReservado ArtDisponible ON Articulo.Articulo = ArtDisponible.Articulo AND ArtDisponible.Empresa = @Empresa AND ArtDisponible.Almacen = Oferta.Almacen
			   WHERE Oferta.GUID = @GUID
		   )AS Articulos
		  LEFT JOIN (
			SELECT Aj.Articulo, AD.Opcion Clave, Aj.Descripcion
			  FROM ArtJuego Aj
			  JOIN ArtJuegoD  AD ON Aj.Articulo = AD.Articulo AND Aj.Juego = AD.Juego
		) AS ArtJuego ON Articulos.Articulo = ArtJuego.Articulo
		FOR XML AUTO, TYPE, ELEMENTS
	)
	
	-- GENERAMOS BARRIDO DE OPCIONES --
	
	SET @XOpciones = '<ArtOpciones/>'

	DECLARE @Opcion char, @Descripcion varchar(100)
	DECLARE @Numero int, @Nombre varchar(100)

	DECLARE Opcion_cursor CURSOR FOR 
	SELECT Opcion,Descripcion
	  FROM
	(SELECT Top 2 Op.Opcion, Op.Descripcion,ao.Orden 
	  FROM ArtOpcion AO 
	  JOIN Opcion Op ON AO.Opcion = Op.Opcion
	 WHERE AO.Articulo = @Articulo 
	 --GROUP BY AO.Articulo, Op.Opcion, Op.Descripcion 
	 ORDER BY ao.Orden, Op.Descripcion) Opciones
	 ORDER BY Orden DESC, Descripcion DESC

	OPEN Opcion_cursor

	FETCH NEXT FROM Opcion_cursor 
	INTO @Opcion, @Descripcion

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   SET @Descripcion = REPLACE(@Descripcion,'/','')
	   SET @Descripcion = REPLACE(@Descripcion,':','')
		SELECT @XOpcion = '<' + replace(@Descripcion, ' ', '_') + '/>'

		IF NOT EXISTS(SELECT Articulo FROM ArtOpcionD WHERE Opcion = @Opcion and Articulo = @Articulo)
		BEGIN
			DECLARE Detalle_cursor CURSOR FOR 
			SELECT AD.Numero, AD.Nombre
			  FROM ArtOpcion AO 
			  JOIN Opcion ArtOpciones ON AO.Opcion = ArtOpciones.Opcion 
			  JOIN OpcionD AD ON AO.Opcion = AD.Opcion 
			 WHERE AO.Opcion = @Opcion and AO.Articulo = @Articulo 
			 GROUP BY AD.Numero, AD.Nombre
			 ORDER BY AD.Numero
		END
		ELSE
		BEGIN
			DECLARE Detalle_cursor CURSOR FOR 
			SELECT AD.Numero, AD.Nombre
			  FROM ArtOpcionD AO 
			  JOIN Opcion ArtOpciones ON AO.Opcion = ArtOpciones.Opcion 
			  JOIN OpcionD AD ON AO.Opcion = AD.Opcion AND AO.Numero = AD.Numero 
			 WHERE AO.Opcion = @Opcion and AO.Articulo = @Articulo 
			 GROUP BY AD.Numero, AD.Nombre
			 ORDER BY AD.Nombre
		END
		
			OPEN Detalle_cursor
			FETCH NEXT FROM Detalle_cursor
			INTO @Numero, @Nombre
            
    		WHILE @@FETCH_STATUS = 0
			BEGIN
			SET @Nombre = REPLACE(@Nombre,'&','')
				SELECT @XDetalle = '<' + @Opcion + CAST(@Numero as varchar(10)) + '>' + dbo.Replace4XML(@Nombre) + '</' + @Opcion + CAST(@Numero as varchar(10)) + '>'

				SET @XOpcion.modify('insert <XDetalleTemp/> as first into /*[1]')
				SET @XOpcion = CAST( REPLACE( CAST(@XOpcion AS VARCHAR(MAX)), '<XDetalleTemp/>', CAST(@XDetalle AS VARCHAR(MAX))) AS XML)
				--SET @XOpcion.modify('insert sql:variable("@XDetalle") into (/*)[1]') -- SQL 2008

			FETCH NEXT FROM Detalle_cursor
			INTO @Numero, @Nombre
			END

			CLOSE Detalle_cursor
			DEALLOCATE Detalle_cursor

			SET @XOpciones.modify('insert <XOpcionTemp/> as first into /*[1]')
			SET @XOpciones = CAST( REPLACE( CAST(@XOpciones AS VARCHAR(MAX)), '<XOpcionTemp/>', CAST(@XOpcion AS VARCHAR(MAX))) AS XML)
			-- SET @XOpciones.modify('insert sql:variable("@XOpcion") into (/ArtOpciones)[1]') -- SQL 2008

		FETCH NEXT FROM Opcion_cursor 
		INTO @Opcion, @Descripcion
	END 

	CLOSE Opcion_cursor;
	DEALLOCATE Opcion_cursor;
	
	-- GENERAMOS BARRIDO DE LISTA DE PRECIOS --
	
    INSERT @Lista(Lista)
	SELECT '<' + dbo.Replace4XML(Oferta.ListaPrecios) + '>'
							+ CAST(ISNULL(CAST(Oferta.Precio as decimal(18,2)), '0.00') AS VARCHAR(100))
							+ '</' + dbo.Replace4XML(Oferta.ListaPrecios) + '>'
	  FROM OfertaMovilTemp Oferta 
	  LEFT JOIN Art Articulo ON Oferta.Articulo = Articulo.Articulo
	 WHERE Oferta.Articulo = @Articulo and Oferta.GUID = @GUID
	 GROUP BY '<' + dbo.Replace4XML(Oferta.ListaPrecios) + '>'
							+ CAST(ISNULL(CAST(Oferta.Precio as decimal(18,2)), '0.00') AS VARCHAR(100))
							+ '</' + dbo.Replace4XML(Oferta.ListaPrecios) + '>'
    
	IF @@Version LIKE '%2005%' OR @@Version LIKE '%2008%' OR @@Version LIKE '%2012%' OR @@Version LIKE '%2014%' OR @@Version LIKE '%2016%'
    BEGIN
        SET @sXListaPrecios = ''
        
	    DECLARE Precios_cursor CURSOR FOR 
	    SELECT Lista
	      FROM @Lista
	    OPEN Precios_cursor
	    FETCH NEXT FROM Precios_cursor 
	    INTO @Parcial
	    WHILE @@FETCH_STATUS = 0
	    BEGIN
          SET @sXListaPrecios = @sXListaPrecios + @Parcial
        FETCH NEXT FROM Precios_cursor 
		INTO @Parcial
        END
        CLOSE Precios_cursor;
	    DEALLOCATE Precios_cursor;
        
    END
    --IF @@VERSION NOT LIKE '%2005%'
	ELSE
    BEGIN
        SELECT @sXListaPrecios = dbo.clrconcatenate(Lista) FROM @Lista
    END

	SET @sXListaPrecios = '<ListaPrecios>' + @sXListaPrecios + '</ListaPrecios>'
	SET @XListaPrecios = CAST(REPLACE(REPLACE(REPLACE(@sXListaPrecios, '(', ''), ')', ''), '-', '') AS XML)
	
	-- GENERAMOS BARRIDO DE TASA DE IMPUESTOS POR ZONA --
	
	SELECT @sXTasa = '<TasaIVAZona>'
    
  	SELECT @sXTasa = @sXTasa + '<' + dbo.Replace4XML('Z'+ZI.Zona) + '>' + CAST(ZI.Porcentaje AS VARCHAR(10)) + '</' + dbo.Replace4XML('Z'+ZI.Zona) + '>'
	  FROM ZonaImp ZI
	  JOIN Art A ON ZI.Impuesto = A.Impuesto1
	 WHERE A.Articulo = @Articulo
	
	SELECT @sXTasa = @sXTasa + '</TasaIVAZona>'
	 
	SET @XTasa = CAST(REPLACE(REPLACE(REPLACE(@sXTasa, '(', ''), ')', ''), '-', '') AS XML)

	SET @XMLArt.modify('insert <XOpcionesATemp/> as first into /*[1]')
	SET @XMLArt = CAST( REPLACE( CAST(@XMLArt AS VARCHAR(MAX)), '<XOpcionesATemp/>', CAST(@XOpciones AS VARCHAR(MAX))) AS XML)
	-- SET @XMLArt.modify('insert sql:variable("@XOpciones") into (/Articulos)[1]') -- SQL 2008

	SET @XMLArt.modify('insert <XListaPreciosTemp/> as first into /*[1]')
	SET @XMLArt = CAST( REPLACE( CAST(@XMLArt AS VARCHAR(MAX)), '<XListaPreciosTemp/>', CAST(@XListaPrecios AS VARCHAR(MAX))) AS XML)
	-- SET @XMLArt.modify('insert sql:variable("@XListaPrecios") into (/Articulos)[1]') -- SQL 2008

	SET @XMLArt.modify('insert <XTasaTemp/> as first into /*[1]')
	SET @XMLArt = CAST( REPLACE( CAST(@XMLArt AS VARCHAR(MAX)), '<XTasaTemp/>', CAST(@XTasa AS VARCHAR(MAX))) AS XML)
	-- SET @XMLArt.modify('insert sql:variable("@XTasa") into (/Articulos)[1]') -- SQL 2008
	
	RETURN @XMLArt
END
GO

SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
SET ANSI_WARNINGS OFF
SET ANSI_PADDING OFF
SET NOCOUNT OFF
GO
SET DATEFIRST 7
SET ANSI_NULLS ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
GO
/**************** fnSplitTable ****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.fnSplitTable') AND type = 'TF') 
	DROP FUNCTION dbo.fnSplitTable
GO
CREATE FUNCTION dbo.fnSplitTable (@StringSplit varchar(max), @Delimiter char(1))
RETURNS @tResult Table(ID int identity, Valor varchar(max))
AS
BEGIN
	DECLARE @StringResult varchar(max)
	SET @StringResult = @StringSplit

	WHILE (SELECT CHARINDEX(@Delimiter, @StringResult)) > 0
	BEGIN
		INSERT @tResult SELECT SUBSTRING(@StringResult, 1, CHARINDEX(@Delimiter, @StringResult) - 1)
		SET @StringResult = SUBSTRING(@StringResult,  CHARINDEX(@Delimiter, @StringResult) + 1, LEN(@StringSplit))
	END

	INSERT @tResult SELECT @StringResult
RETURN
END
GO
SET DATEFIRST 7
SET ANSI_NULLS ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
GO
/**************** Replace4XML ****************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('dbo.Replace4XML') AND type = 'FN') 
	DROP FUNCTION dbo.Replace4XML
GO
CREATE FUNCTION dbo.Replace4XML(@Value varchar(max))
RETURNS varchar(max)
AS
BEGIN
	DECLARE @ToReplace TABLE(Valor char)
	
	INSERT @ToReplace 
	SELECT Valor
	  FROM dbo.fnSplitTable('(,),", ,<,>,%,/,\,;,#,$,&,:', ',')

	SELECT @Value = REPLACE(@Value, Valor, '') 
	  FROM @ToReplace

RETURN @Value
END
GO