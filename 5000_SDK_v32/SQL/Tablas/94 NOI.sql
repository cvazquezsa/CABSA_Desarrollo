if exists (select * from sysobjects where id = object_id('dbo.NOINominaGenerada') and sysstat & 0xf = 2) drop view dbo.NOINominaGenerada
GO
CREATE VIEW NOINominaGenerada
--//WITH ENCRYPTION
AS
  SELECT n.Empresa,n.ID,n.FechaD,n.FechaA
    FROM Nomina n JOIN MovTipo m ON n.Mov = m.Mov AND m.Modulo = 'NOM'
   WHERE n.Estatus = 'CANCELADO' 
     AND n.NOI = 1
     AND m.Clave IN('NOM.N','NOM.NE')
     AND n.FechaA NOT IN(SELECT n.FechaA FROM Nomina n JOIN MovTipo m ON n.Mov = m.Mov AND m.Modulo = 'NOM' WHERE n.Estatus <> 'CANCELADO' AND n.NOI = 1
     AND m.Clave IN('NOM.N','NOM.NE'))
  GROUP BY n.Empresa,n.ID,n.FechaD,n.FechaA     
GO

if exists (select * from sysobjects where id = object_id('dbo.NOINominaGenerada2') and sysstat & 0xf = 2) drop view dbo.NOINominaGenerada2
GO
CREATE VIEW NOINominaGenerada2
--//WITH ENCRYPTION
AS
  SELECT n.Empresa,n.ID,n.FechaD,n.FechaA,n.Estatus
    FROM Nomina n JOIN MovTipo m ON n.Mov = m.Mov AND m.Modulo = 'NOM'
   WHERE n.Estatus = 'CANCELADO' 
     AND n.NOI = 1
     AND m.Clave IN('NOM.N','NOM.NE')
     AND n.FechaA NOT IN(SELECT n.FechaA FROM Nomina n JOIN MovTipo m ON n.Mov = m.Mov AND m.Modulo = 'NOM' WHERE n.Estatus NOT IN('CONCLUIDO','BORRADOR') AND n.NOI = 1
     AND m.Clave IN('NOM.N','NOM.NE'))
  GROUP BY n.Empresa,n.ID,n.FechaD,n.FechaA ,n.Estatus    
  UNION ALL
  SELECT n.Empresa,n.ID,n.FechaD,n.FechaA,n.Estatus
    FROM Nomina n JOIN MovTipo m ON n.Mov = m.Mov AND m.Modulo = 'NOM'
   WHERE n.Estatus = 'BORRADOR' 
     AND n.NOI = 1
     AND m.Clave IN('NOM.N','NOM.NE')
  GROUP BY n.Empresa,n.ID,n.FechaD,n.FechaA,n.Estatus
GO

/*** InterfaseAspel ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'InterfaseAspel')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InterfaseAspel','Maestro')
if NOT EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.InterfaseAspel') and type = 'U') 
CREATE TABLE dbo.InterfaseAspel (
    SistemaAspel	    varchar(10)	NOT NULL,
    Servidor	            varchar(50)	NOT NULL,
    BaseDatosNombre	    varchar(50)	NOT NULL,    
    Empresa      	    varchar(5)	NOT NULL,    
    EmpresaAspel	    varchar(2)	NOT NULL,    
    SucursalIntelisis       int         NOT NULL,
    
CONSTRAINT priInterfaseAspel PRIMARY KEY CLUSTERED (SistemaAspel)
)
GO

EXEC spALTER_TABLE 'InterfaseAspel', 'Empresa', 'varchar(5) NOT NULL'
EXEC spALTER_TABLE 'InterfaseAspel', 'EmpresaAspel', 'varchar(2) NOT NULL'
EXEC spALTER_TABLE 'InterfaseAspel', 'SucursalIntelisis', 'int NOT NULL'
GO

/*** InterfaseAspelNOI ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'InterfaseAspelNOI')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InterfaseAspelNOI','Maestro')
if NOT EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.InterfaseAspelNOI') and type = 'U') 
CREATE TABLE dbo.InterfaseAspelNOI (
    Empresa      	    varchar(5)	NOT NULL,    
    TipoPeriodo             varchar(20) NOT NULL,
    CtaDinero               varchar(10) NOT NULL, 
    Moneda                  varchar(10) NOT NULL,
    MovNomina               varchar(20) NOT NULL,
    Concepto                varchar(50) NULL,                    
    ConceptoDIN             varchar(50) NULL,

    
CONSTRAINT priInterfaseAspelNOI PRIMARY KEY CLUSTERED (Empresa)
)
GO


/*** NOITablaPeriodo ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOITablaPeriodo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOITablaPeriodo','N/A')
if  EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOITablaPeriodo') and type = 'U') DROP TABLE NOITablaPeriodo
GO
CREATE TABLE dbo.NOITablaPeriodo (
    Estacion                int  NOT NULL,
    Nomina       	    varchar(10)	NOT NULL,
    FechaA                  datetime NULL,
    FechaD                  datetime NULL,

    
CONSTRAINT priNOITablaPeriodo PRIMARY KEY CLUSTERED (Estacion,Nomina)
)
GO



/*** NOIParamTablaPeriodo ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOIParamTablaPeriodo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOIParamTablaPeriodo','N/A')
if  EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOIParamTablaPeriodo') and type = 'U') DROP TABLE NOIParamTablaPeriodo
GO
CREATE TABLE dbo.NOIParamTablaPeriodo (
    Estacion                int  NOT NULL,
    Nomina       	    varchar(10)	NOT NULL,
    FechaA                  datetime  NULL,
    FechaD                  datetime  NULL,
  
CONSTRAINT priNOIParamTablaPeriodo PRIMARY KEY CLUSTERED (Estacion,Nomina)
)
GO





/*** NOINominaEspecial ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOINominaEspecial')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOINominaEspecial','N/A')
if  EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOINominaEspecial') and type = 'U') DROP TABLE NOINominaEspecial
GO
CREATE TABLE dbo.NOINominaEspecial (
    Estacion                int NOT NULL,
    Mov       	    varchar(20)	NOT NULL,
  
CONSTRAINT priNOINominaEspecial PRIMARY KEY CLUSTERED (Estacion)
)
GO


/*** NOIParamNominaGenerada ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOIParamNominaGenerada')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOIParamNominaGenerada','N/A')
if  EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOIParamNominaGenerada') and type = 'U') DROP TABLE NOIParamNominaGenerada
Go
CREATE TABLE dbo.NOIParamNominaGenerada (
    Estacion                int NOT NULL,
    ID       	            int	NOT NULL,
    FechaA                  datetime NULL,
    FechaD                  datetime NULL,
  
CONSTRAINT priNOIParamNominaGenerada PRIMARY KEY CLUSTERED (Estacion,ID)
)
GO

/*** NOIPersonal ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOIPersonal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOIPersonal','N/A')
if NOT EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOIPersonal') and type = 'U') 
CREATE TABLE dbo.NOIPersonal (
    EmpresaNOI	                varchar(2)	NOT NULL,
    Estacion                    int             NOT NULL,
    Nomina       	        varchar(10)	NOT NULL,
    Personal                    varchar(10)     NOT NULL,
    Nombre                      varchar(30)     NULL,
    ApellidoPaterno             varchar(30)     NULL,
    ApellidoMaterno             varchar(30)     NULL,
    Estatus                     varchar(15)     NULL,
    Registro2                   varchar(30)     NULL,
    Departamento                varchar(50)     NULL,
    Puesto                      varchar(50)     NULL,
    Registro3                   varchar(30)     NULL,
    FechaAlta                   datetime        NULL,
    FechaBaja                   datetime        NULL,
    FormaPago                   varchar(50)     NULL,
    SueldoDiario                money           NULL,
    SDI                         money           NULL,
    TipoSueldo                  varchar(10)     NULL,
    Direccion                   varchar(100)    NULL,
    Colonia                     varchar(100)    NULL,
    Poblacion                   varchar(100)    NULL,
    Estado                      varchar(30)     NULL,
    CodigoPostal                varchar(15)     NULL,
    CtaDinero                   varchar(10)     NULL,
    PersonalCuenta              varchar(20)     NULL,
    LugarNacimiento             varchar(50)     NULL,
    Tipo                        varchar(20)     NULL,
    TipoContrato                varchar(50)     NULL,
    EstadoCivil                 varchar(20)     NULL,
    UnidadMedica                int             NULL,
    Padre                       varchar(50)     NULL,
    Madre                       varchar(50)     NULL,
    Telefono                    varchar(50)     NULL,
    Sexo                        varchar(10)     NULL,
    FechaNacimiento             datetime        NULL,
    Registro                    varchar(30)     NULL,
    Email                       varchar(50)     NULL,
    Jornada                     varchar(20)     NULL,
    PeriodoTipo                 varchar(20)     NULL,
    ZonaEconomica               varchar(30)     NULL,
    Moneda                      varchar(10)     NULL,
    Ok                          int             NULL,
    OkRef                       varchar(255)    NULL,
    Verificado                  bit             NULL,

CONSTRAINT priNOIPersonal PRIMARY KEY CLUSTERED (EmpresaNOI,Estacion,Nomina,Personal)
)
GO



/*** NOINomina ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOINomina')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOINomina','N/A')
if NOT EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOINomina') and type = 'U') 
CREATE TABLE dbo.NOINomina (
  EmpresaNOI	  varchar(2)	NOT NULL,
  Estacion        int           NOT NULL,
  Nomina       	  varchar(10)	NOT NULL,
  Empresa         varchar(5)    NOT NULL,
  Sucursal        int           NOT NULL,
  Tipo            varchar(50)	NOT NULL,
  FechaD          datetime,
  FechaA          datetime,
  Personal        varchar(10)	NOT NULL,
  SueldoDiario    float         NULL,
  TotalPer        float         NULL,
  TotalDed        float         NULL,
  IMSS            float         NULL,
  ISPT            float         NULL,
  Infonavit       float         NULL,
  NetoPagado      float         NULL,
  Ok              int           NULL,
  OkRef           varchar(255)  NULL,
  Nombre          varchar(125)  NULL,
  Verificado      bit           NULL,
  NominaEspecial  bit           NULL  DEFAULT 0 ,
  

CONSTRAINT priNOINomina PRIMARY KEY CLUSTERED (EmpresaNOI,Estacion,Nomina,Personal)
)
GO

EXEC spALTER_TABLE 'NOINomina', 'NominaEspecial', 'bit NULL DEFAULT 0 WITH VALUES'  


/*** NOINominaD ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOINominaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOINominaD','N/A')
if NOT EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOINominaD') and type = 'U') 
CREATE TABLE dbo.NOINominaD (
    EmpresaNOI	                varchar(2)	NOT NULL,
    Estacion                    int             NOT NULL,
    Nomina                      varchar(10)	NOT NULL,
    Personal                    varchar(10)	NOT NULL,
    NominaConcepto              varchar(10)	NOT NULL,
    Valor                       float           NULL,
    Ok                          int             NULL,
    OkRef                       varchar(255)    NULL,

CONSTRAINT priNOINominaD PRIMARY KEY CLUSTERED (EmpresaNOI,Estacion,Nomina,Personal,NominaConcepto)
)
GO


/*** NOIFormaPago ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOIFormaPago')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOIFormaPago','Cuenta')
if NOT EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOIFormaPago') and type = 'U') 
CREATE TABLE dbo.NOIFormaPago (
    FormaPagoNOI                varchar(50)	NOT NULL,
    ClaveNOI                    varchar(1)	NOT NULL,
    FormaPago                   varchar(50)	NOT NULL,

CONSTRAINT priNOIFormaPago PRIMARY KEY CLUSTERED (FormaPagoNOI)
)
GO


/*** NOITipoEmpleado ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOITipoEmpleado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOITipoEmpleado','Cuenta')
if NOT EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOITipoEmpleado') and type = 'U') 
CREATE TABLE dbo.NOITipoEmpleado (
    TipoEmpleadoNOI             varchar(20)	NOT NULL,
    ClaveNOI                    varchar(1)	NOT NULL,
    Tipo                        varchar(20)	NOT NULL,

CONSTRAINT priNOITipoEmpleado PRIMARY KEY CLUSTERED (TipoEmpleadoNOI)
)
GO

/*** NOINominaConcepto ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOINominaConcepto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOINominaConcepto','N/A')
if NOT EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOINominaConcepto') and type = 'U') 
CREATE TABLE dbo.NOINominaConcepto (
    EmpresaNOI	                varchar(2)	NOT NULL,
    Estacion                    int             NOT NULL,
    Nomina       	        varchar(10)	NOT NULL,
    NominaConcepto              varchar(10)	NOT NULL,
    Concepto                    varchar(50)     NULL, 
    Movimiento                  varchar(20)     NULL,  
    GravaISR                    varchar(50)     NULL, 
    GravaIMSS                   varchar(50)     NULL, 
    GravaImpuestoEstatal        varchar(50)     NULL, 
    Modulo                      varchar(5)      NULL, 
    Estatus                     varchar(15)     NULL, 
    Pais                        varchar(30)     NULL,
    CuentaGrupo                 varchar(20)     NULL,
    Ok                          int             NULL,
    OkRef                       varchar(255)    NULL,

CONSTRAINT priNOINominaConcepto PRIMARY KEY CLUSTERED (Estacion,EmpresaNOI,Nomina,NominaConcepto)
)
GO


/*** NOIDepartamento ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOIDepartamento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOIDepartamento','N/A')
if NOT EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOIDepartamento') and type = 'U') 
CREATE TABLE dbo.NOIDepartamento (
    Estacion                    int             NOT NULL,
    EmpresaNOI	                varchar(2)	NOT NULL,
    Departamento       	        varchar(50)	NOT NULL,
    Sucursal                    int             NULL,
    Ok                          int             NULL,
    OkRef                       varchar(255)    NULL,

CONSTRAINT priNOIDepartamento PRIMARY KEY CLUSTERED (EmpresaNOI,Estacion,Departamento)
)
GO


/*** NOIPuestos ***/
if NOT EXISTS(SELECT * FROM SysTabla where SysTabla = 'NOIPuestos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NOIPuestos','N/A')
if NOT EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.NOIPuestos') and type = 'U') 
CREATE TABLE dbo.NOIPuestos (
    EmpresaNOI	                varchar(2)	NOT NULL,
    Estacion                    int             NOT NULL,
    Puesto       	        varchar(50)	NOT NULL,
    SueldoRangoMinimo           float           NULL,
    SueldoRangoMaximo           float           NULL,
    Ok                          int             NULL,
    OkRef                       varchar(255)    NULL,

CONSTRAINT priNOIPuestos PRIMARY KEY CLUSTERED (EmpresaNOI,Estacion,Puesto)
)
GO