SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET NOCOUNT ON
GO

/* Campos Nuevos a Tabla Usuario para configurar y dar permisos */
EXEC spALTER_TABLE 'Usuario', 'VicAgregaCondic',     'bit NULL'
EXEC spALTER_TABLE 'Usuario', 'VicActualizaCondic',  'bit NULL'
EXEC spALTER_TABLE 'Usuario', 'VicInactivaCondic', '  bit NULL'
EXEC spALTER_TABLE 'Usuario', 'VicEliminaCondic', '   bit NULL'
GO

EXEC spALTER_TABLE 'Usuario', 'vic_VerPlanoGramaDiseno',	   'bit', '0' 
EXEC spALTER_TABLE 'Usuario', 'vic_VerPlanoGramaProduccion',   'bit', '0'
EXEC spALTER_TABLE 'Usuario', 'vic_CopiarAccionesPlanoGrama',  'bit', '0'
EXEC spALTER_TABLE 'Usuario', 'vic_ActualizarPlanoGrama',      'bit', '0'
EXEC spALTER_TABLE 'Usuario', 'vic_EliminarPlanoGrama',        'bit', '0'
EXEC spALTER_TABLE 'Usuario', 'vic_AccionesPlanoGrama',        'bit', '0'
GO

/************************************************************************************************************/
/* vic_Plano Tabla para manejar informacion de Planogramas */
 IF NOT EXISTS (select * from SysTabla where SysTabla = 'vic_Plano') 
    INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('vic_Plano','Cuenta', 'PACTO')
 if not exists (select * from sysobjects where id = object_id('dbo.vic_Plano') and type = 'U') 
 create table dbo.vic_Plano (
      Plano            varchar(15)   not null, 
      Nombre           varchar(200)  null,
      NombreCorto      varchar(30)   null,
      Rama             varchar(10)   null,
      Estatus          varchar(15)   null,
      Tipo             varchar(15)   null,
      Proyecto         varchar(50)   null,
      Cuenta           varchar(20)   null,
      CuentaRetencion  varchar(20)   null,
      FiscalRegimen    varchar(20)   null,
      Familia          varchar(50)   null,
      Categoria        varchar(50)   null,
      Grupo            varchar(50)   null,
      TipoPlano        varchar(50)   null,   -- Tipo de Plano
      Usuario          varchar(10)   null,
      Alta             datetime      null,
      UltimoCambio     datetime      null,
      Conciliar        bit           null,
      SincroID         datetime      null,
      SincroC          int           null,
      Situacion        varchar(50)   null,
      SituacionFecha   datetime      null,
      SituacionUsuario varchar(10)   null,
      SituacionNota    varchar(100)  null,
      NivelAcceso      varchar(50)   null,
      Accesoespecifico varchar(50)   null,
      Idioma           varchar(50)   null,
      Icono            int           null,
      PermitirBorrar   bit           null,
      Comentarios      varchar(1000) null,
      Lista            varchar(50)   null,   -- Inmuebles
      PlanoBlob        image         null,   -- Imagen del Planograma
      Disponible       bit           null,
      NombreForma      varchar(100)  null, 
	  FormaContrato	   varchar(100)  null,
      CONSTRAINT vic_priPlanos PRIMARY KEY  CLUSTERED (Plano)
 )
 GO
 
/* vic_plano_asignacion */
 IF NOT EXISTS (select * from SysTabla where SysTabla = 'vic_plano_asignacion') 
    INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('vic_plano_asignacion','N/A', 'PACTO')
 if not exists (select * from sysobjects where id = object_id('dbo.vic_plano_asignacion') and type = 'U') 
 CREATE TABLE dbo.vic_plano_asignacion (
		plano                           varchar(15)         NOT NULL, 
		elemento                        varchar(100)        NOT NULL, 
		tipo_especial                   bit                 NULL, 
		tipo_plano                      int                 null, 
 CONSTRAINT vic_priplano_asignacion PRIMARY KEY (plano, elemento)
 )
 GO

/* vic_PlanoAcciones Tabla de configuracion para Acciones de los Planogramas */
 IF NOT EXISTS (select * from SysTabla where SysTabla = 'vic_PlanoAcciones') 
    INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('vic_PlanoAcciones','N/A', 'PACTO')
 if not exists (select * from sysobjects where id = object_id('dbo.vic_PlanoAcciones') and type = 'U') 
 create table dbo.vic_PlanoAcciones (
     Plano                          varchar(15)     not null,
     Renglon                        float           not null,
     RenglonSub                     int             not null, 
     Nombre                         varchar(50)     null,
     Query                          varchar(max)    null,
     QueryColor                     varchar(max)    null,
     Estatus                        varchar(15)     null,   -- ACTIVO, INACTIVO
     AplicaProm                     bit             null, 
     CONSTRAINT vic_priPlanoAcciones PRIMARY KEY  CLUSTERED (Plano, Renglon, RenglonSub)
 )
 GO
  
/* vic_PlanoAccionesDef */
 IF NOT EXISTS (select * from SysTabla where SysTabla = 'vic_PlanoAccionesDef') 
    INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('vic_PlanoAccionesDef','N/A', 'PACTO')
 if not exists (select * from sysobjects where id = object_id('dbo.vic_PlanoAccionesDef') and type = 'U') 
 create table dbo.vic_PlanoAccionesDef (
   Plano                        varchar(15)         not null,
   Nombre                       varchar(50)         not null,
   Renglon                      int                 identity(1,1),
   RenglonSub                   int                 not null, 
   Orden                        int                 null,
   Color                        int                 null,   
   LeyendaColor                 varchar(20)         null,
   Expresion                    varchar(1000)       null,    
  CONSTRAINT vic_priPlanoAccionesDef PRIMARY KEY  CLUSTERED (Plano, Nombre, Renglon, RenglonSub)
 )
 GO

/* vic_PlanoCat */
 IF NOT EXISTS (select * from SysTabla where SysTabla = 'vic_PlanoCat') 
    INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('vic_PlanoCat','Maestro', 'PACTO')
 if not exists (select * from sysobjects where id = object_id('dbo.vic_PlanoCat') and type = 'U') 
 create table dbo.vic_PlanoCat (
    Categoria               varchar(50)          not null, 
    Categoriamaestra        varchar(50)          null,
    Icono                   int                  null, 
    CONSTRAINT vic_priPlano PRIMARY KEY  CLUSTERED (Categoria)
 )
 GO
 
/* vic_PlanoFam */
 IF NOT EXISTS (select * from SysTabla where SysTabla = 'vic_PlanoFam') 
    INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('vic_PlanoFam','Maestro', 'PACTO')
 if not exists (select * from sysobjects where id = object_id('dbo.vic_PlanoFam') and type = 'U') 
 create table dbo.vic_PlanoFam (
    Familia                 varchar(50)          not null, 
    Familiamaestra          varchar(50)          null,
    Icono                   int                  null, 
    CONSTRAINT vic_priPlanoFam PRIMARY KEY  CLUSTERED (Familia)
 )
 GO
 
/* vic_PlanoGrp */
 IF NOT EXISTS (select * from SysTabla where SysTabla = 'vic_PlanoGrp') 
    INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('vic_PlanoGrp','Maestro', 'PACTO')
 if not exists (select * from sysobjects where id = object_id('dbo.vic_PlanoGrp') and type = 'U') 
 create table dbo.vic_PlanoGrp (
    Grupo                   varchar(50)          not null, 
    Grupomaestra            varchar(50)          null,
    Icono                   int                  null, 
    CONSTRAINT vic_priPlanoGrp PRIMARY KEY  CLUSTERED (Grupo)
 )
 GO
 
/* vic_TipoPlano Tabla de Configuracion para los Tipos de Planogramas */
 IF NOT EXISTS (select * from SysTabla where SysTabla = 'vic_TipoPlano') 
    INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('vic_TipoPlano','Maestro', 'PACTO')
 if not exists (select * from sysobjects where id = object_id('dbo.vic_TipoPlano') and type = 'U') 
 create table dbo.vic_TipoPlano (
		TipoPlano						varchar(50)     not null, 
		Icono							int             null,
		FiltroLista						varchar(1000)   null,
		TotalCamposFiltroLista			int             null,   -- 1, 2
		C1A								char(1)         null,   -- D (derecha), I (izquierda), C (centro)
		C1TD							varchar(7)      null,   -- Fecha, Entero, Decimal, Texto
		C1E								varchar(25)     null,
		C2A								char(1)         null,   -- D (derecha), I (izquierda), C (centro)
		C2TD							varchar(7)      null,   -- Fecha, Entero, Decimal, Texto
		C2E								varchar(25)     null,
		FiltroElemento					varchar(1000)   null,
		TotalCamposFiltroElemento		int				null,   -- 1, 2, 3, 4
		CFE1A							char(1)         null,   -- D (derecha), I (izquierda), C (centro)
		CFE1TD							varchar(7)      null,   -- Fecha, Entero, Decimal, Texto
		CFE1E							varchar(25)     null,
		CFE2A							char(1)         null,   -- D (derecha), I (izquierda), C (centro)
		CFE2TD							varchar(7)      null,   -- Fecha, Entero, Decimal, Texto
		CFE2E							varchar(25)     null,
		CFE3A							char(1)         null,   -- D (derecha), I (izquierda), C (centro)
		CFE3TD							varchar(7)      null,   -- Fecha, Entero, Decimal, Texto
		CFE3E							varchar(25)     null,
		CFE4A							char(1)         null,   -- D (derecha), I (izquierda), C (centro)
		CFE4TD							varchar(7)      null,   -- Fecha, Entero, Decimal, Texto
		CFE4E							varchar(25)     null,
		FiltroElementoEspecial			varchar(1000)   null,
		TotalCamposFEE					int             null,   -- 1, 2, 3, 4
		CFEE1A							char(1)         null,   -- D (derecha), I (izquierda), C (centro)
		CFEE1TD							varchar(7)      null,   -- Fecha, Entero, Decimal, Texto
		CFEE1E							varchar(25)     null,
		CFEE2A							char(1)         null,   -- D (derecha), I (izquierda), C (centro)
		CFEE2TD							varchar(7)      null,   -- Fecha, Entero, Decimal, Texto
		CFEE2E							varchar(25)     null,
		CFEE3A							char(1)         null,   -- D (derecha), I (izquierda), C (centro)
		CFEE3TD							varchar(7)      null,   -- Fecha, Entero, Decimal, Texto
		CFEE3E							varchar(25)     null,
		CFEE4A							char(1)         null,   -- D (derecha), I (izquierda), C (centro)
		CFEE4TD							varchar(7)      null,   -- Fecha, Entero, Decimal, Texto
		CFEE4E							varchar(25)     null,
		Comentarios						varchar(1000)   null, 
		CONSTRAINT vic_priTipoPlano PRIMARY KEY  CLUSTERED (TipoPlano)
 )
 GO
 
/* vic_Inmueble */
 IF NOT EXISTS (select * from SysTabla where SysTabla = 'vic_Inmueble') 
    INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('vic_Inmueble','Cuenta', 'PACTO')
 if not exists (select * from sysobjects where id = object_id('dbo.vic_Inmueble') and type = 'U') 
 create table dbo.vic_Inmueble (
      Desarrollo                    Varchar(50)         null, 
      Inmueble                      Varchar(15)         not null, 
      Nombre                        Varchar(200)        null,
      NombreCorto                   Varchar(30)         null,
      Rama                          Varchar(10)         null,
      Estatus                       Varchar(15)         null,
      Tipo                          Varchar(15)         null,
      Proyecto                      Varchar(50)         null,
      Cuenta                        Varchar(20)         null,
      CuentaRetencion               Varchar(20)         null,
      FiscalRegimen                 Varchar(20)         null,
      Familia                       Varchar(50)         null,
      Categoria                     Varchar(50)         null,
      Grupo                         Varchar(50)         null,
      Tipoinmueble                  Varchar(50)         null,
      Usuario                       Varchar(10)         null,
      Alta                          Datetime            null,
      UltimoCambio                  Datetime            null,
      Conciliar                     Bit                 null,
      SincroID                      Datetime            null,
      SincroC                       Int                null,
      Situacion                     Varchar(50)         null,
      SituacionFecha                Datetime            null,
      SituacionUsuario              Varchar(10)         null,
      SituacionNota                 Varchar(100)        null,
      NivelAcceso                   Varchar(50)         null,
      Accesoespecifico              Varchar(50)         null,
      Idioma                        Varchar(50)         null,
      Icono                         Int                null,
      PermitirBorrar                Bit                 null,
      Direccionfisica               Varchar(100)        null,
      DireccionNumerofisica         Varchar(20)         null,
      EntreCallesfisica             Varchar(100)        null,
      DireccionNumeroIntfisica      Varchar(20)         null,
      Planofisica                   Varchar(15)         null,
      Observacionesfisica           Varchar(100)        null,
      Coloniafisica                 Varchar(100)        null,
      Poblacionfisica               Varchar(100)        null,
      Estadofisica                  Varchar(30)         null,
      Paisfisica                    Varchar(30)         null,
      CodigoPostalfisica            Varchar(15)         null,
      Delegacionfisica              Varchar(100)        null,
      MapaLatitudfisica             Int                 null,
      MapaLongitudfisica            Int                 null,
      MapaOrdenfisica               Int                null,
      MapaPrecisionfisica           Int                 null,
      Empresa                       Varchar(5)          null,
      MapaRutafisica                Varchar(20)         null,
      Direccion                     Varchar(100)        null,
      MapaRutaKmfisica              Int                 null,
      MapaRutaMinutosfisica         Int                 null,
      DireccionNumero               Varchar(20)         null,
      EntreCalles                   Varchar(100)        null,
      DireccionNumeroInt            Varchar(20)         null,
      Plano                         Varchar(15)         null,
      Observaciones                 Varchar(100)        null,
      Gerenta                       Varchar(100)        null,
      Colonia                       Varchar(100)        null,
      SubGerente                    Varchar(100)        null,
      Poblacion                     Varchar(100)        null,
      Estado                        Varchar(30)         null,
      Logo                          Varchar(100)        null,
      FechaComercializa             Datetime            null,
      Pais                          Varchar(30)         null,
      FechaApertura                 Datetime            null,
      CodigoPostal                  Varchar(15)         null,
      Reserva                       Float               null,
      Terreno                       Float               null,
      Delegacion                    Varchar(100)        null,
      AreaComun                     Float               null,
      Construccion                  Float               null,
      MapaLatitud                   Int                 null,
      Estacionamiento               Float               null,
      MapaLongitud                  Int                 null,
      MapaOrden                     Int                 null,
      EstacionamientoLugares        Int                 null,
      MapaPrecision                 Int                 null,
      Condominio                    Bit                 null,
      MapaRuta                      Varchar(20)         null,
      Lugar                         Varchar(200)        null,
      MapaRutaKm                    Int                 null,
      MapaRutaMinutos               Int                 null,
      Comentarios                   Varchar(1000)       null, 
     PermiteDiasAdel               bit                 null, 
     DiasAdel                      int                 null,
 
     CONSTRAINT vic_priInmueble PRIMARY KEY  CLUSTERED (Inmueble)
 )
 go
 
 EXEC spAlter_Table  'vic_Inmueble', 'PermiteDiasAdel',        'bit null'
 EXEC spAlter_Table  'vic_Inmueble', 'DiasAdel',                   'int null'
 EXEC spALTER_COLUMN 'vic_Inmueble', 'Comentarios',            'Text null'
 EXEC spALTER_TABLE  'vic_Inmueble', 'VtasConsignacion',           'bit NULL DEFAULT 0'
 EXEC spALTER_TABLE  'vic_Inmueble', 'AlmacenVtasConsignacion', 'varchar(10) NULL'
 GO

/* Tablas para sp */
 IF NOT EXISTS (select * from SysTabla where SysTabla = 'vic_planotemp') 
    INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('vic_planotemp','N/A', 'PACTO')
 if not exists (select * from sysobjects where id = object_id('dbo.vic_planotemp') and type = 'U') 
 CREATE TABLE dbo.vic_planotemp (
   Estacion          Int                NOT NULL,   
   plano             varchar(15)        NOT NULL, 
   elemento          varchar(100)		NOT NULL,  
   Nombre            varchar(50)        NOT NULL,   
   Valor             varchar(200)		null,  
   Descripcion       varchar(200)		null,
   Color             varchar(25)		null DEFAULT NULL, 
   Valor_color		 varchar(200)		null
 CONSTRAINT vic_priplanotemp PRIMARY KEY (plano, elemento, nombre)
 )
 GO
 
/* El spCopiarUsuarioCfg llama a xpCopiarUsuarioCfg vic3DescUsuarioCarpeta */ 
IF NOT EXISTS (select * from sysobjects where id = object_id('dbo.vic3DescUsuarioCarpeta') and type = 'U') 
CREATE TABLE dbo.vic3DescUsuarioCarpeta(
    Usuario                         VARCHAR(10)     COLLATE DATABASE_DEFAULT    NOT NULL,
    Contrato                        BIT             DEFAULT 0                       NULL,
    Generales                       BIT             DEFAULT 0                       NULL,   
    FirFisica                       BIT             DEFAULT 0                       NULL,   
    Fiador                          BIT             DEFAULT 0                       NULL,   
    Fianza                          BIT             DEFAULT 0                       NULL,   
    Fechas                          BIT             DEFAULT 0                       NULL,   
    CondRenta                       BIT             DEFAULT 0                       NULL,   
    CondVenta                       BIT             DEFAULT 0                       NULL,   
    CondServicio                    BIT             DEFAULT 0                       NULL,
    Condiciones                     BIT             DEFAULT 0                       NULL,   
    Relaciones                      BIT             DEFAULT 0                       NULL,   
    Minutas                         BIT             DEFAULT 0                       NULL,
    Solicitudes                     BIT             DEFAULT 0                       NULL,
    Tramites                        BIT             DEFAULT 0                       NULL,
    Prorrogas                       BIT             DEFAULT 0                       NULL,
    Caracteristicas                 BIT             DEFAULT 0                       NULL,
    Documento                       BIT             DEFAULT 0                       NULL,
    Tareas                          BIT             DEFAULT 0                       NULL,
    Comentarios                     BIT             DEFAULT 0                       NULL,
    CondContrac                     BIT             DEFAULT 0                       NULL,
    Locales                         BIT             DEFAULT 0                       NULL,           
    Extra                           BIT             DEFAULT 0                       NULL,
    CONSTRAINT privic3DescUsuarioCarpeta PRIMARY KEY(Usuario)
)
GO

IF NOT EXISTS (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarima' AND sysindexes.name = 'Idx_WMSTarimaAlmacen' AND sysobjects.id = sysindexes.id)
	CREATE NONCLUSTERED INDEX Idx_WMSTarimaAlmacen
	ON [dbo].[Tarima] ([Almacen])
	INCLUDE ([Tarima],[Posicion],[Estatus])
GO