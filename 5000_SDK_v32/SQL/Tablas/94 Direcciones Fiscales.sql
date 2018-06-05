SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/*******************************************************************************************/
/*                          Direcciones Fiscales                                           */
/*******************************************************************************************/

/****** CteDireccionFiscal ******/
if not exists(select * from SysTabla where SysTabla = 'CteDireccionFiscal')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CteDireccionFiscal', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteDireccionFiscal') and type = 'U')
CREATE TABLE CteDireccionFiscal(
 Cliente        varchar(10) NOT NULL,
 Icono          int         NULL,
 Mapeado        int         NULL,
 ClaveCP        varchar(5)  NULL,
 ClavePais      varchar(3)  NULL,
 ClaveEstado    varchar(3)  NULL,
 ClaveMunicipio varchar(3)  NULL,
 ClaveLocalidad varchar(2)  NULL,
 ClaveColonia   varchar(10) NULL,
 
 CONSTRAINT priCteDireccionFiscal PRIMARY KEY CLUSTERED(Cliente)
)
GO


/****** CteEnviarADireccionFiscal ******/
if not exists(select * from SysTabla where SysTabla = 'CteEnviarADireccionFiscal')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CteEnviarADireccionFiscal', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteEnviarADireccionFiscal') and type = 'U')
CREATE TABLE CteEnviarADireccionFiscal(
 Cliente        varchar(10) NOT NULL,
 ID             int         NOT NULL,
 Icono          int         NULL,
 Mapeado        int         NULL,
 ClaveCP        varchar(5)  NULL,
 ClavePais      varchar(3)  NULL,
 ClaveEstado    varchar(3)  NULL,
 ClaveMunicipio varchar(3)  NULL,
 ClaveLocalidad varchar(2)  NULL,
 ClaveColonia   varchar(10) NULL,
 
 CONSTRAINT priCteEnviarADireccionFiscal PRIMARY KEY CLUSTERED(Cliente,ID)
)
GO


/****** ProvDireccionFiscal ******/
if not exists(select * from SysTabla where SysTabla = 'ProvDireccionFiscal')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ProvDireccionFiscal', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ProvDireccionFiscal') and type = 'U')
CREATE TABLE ProvDireccionFiscal(
 Proveedor      varchar(10) NOT NULL,
 Icono          int         NULL,
 Mapeado        int         NULL,
 ClaveCP        varchar(5)  NULL,
 ClavePais      varchar(3)  NULL,
 ClaveEstado    varchar(3)  NULL,
 ClaveMunicipio varchar(3)  NULL,
 ClaveLocalidad varchar(2)  NULL,
 ClaveColonia   varchar(10) NULL,
 
 CONSTRAINT priProvDireccionFiscal PRIMARY KEY CLUSTERED(Proveedor)
)
GO



/****** PersonalDireccionFiscal ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalDireccionFiscal')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('PersonalDireccionFiscal', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalDireccionFiscal') and type = 'U')
CREATE TABLE PersonalDireccionFiscal(
 Personal       varchar(10) NOT NULL,
 Icono          int         NULL,
 Mapeado        int         NULL,
 ClaveCP        varchar(5)  NULL,
 ClavePais      varchar(3)  NULL,
 ClaveEstado    varchar(3)  NULL,
 ClaveMunicipio varchar(3)  NULL,
 ClaveLocalidad varchar(2)  NULL,
 ClaveColonia   varchar(10) NULL,
 
 CONSTRAINT priPersonalDireccionFiscal PRIMARY KEY CLUSTERED(Personal)
)
GO

/****** EmpresaDireccionFiscal ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaDireccionFiscal')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('EmpresaDireccionFiscal', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaDireccionFiscal') and type = 'U')
CREATE TABLE EmpresaDireccionFiscal(
 Empresa        varchar(5)  NOT NULL,
 Icono          int         NULL,
 Mapeado        int         NULL,
 ClaveCP        varchar(5)  NULL,
 ClavePais      varchar(3)  NULL,
 ClaveEstado    varchar(3)  NULL,
 ClaveMunicipio varchar(3)  NULL,
 ClaveLocalidad varchar(2)  NULL,
 ClaveColonia   varchar(10) NULL,
 
 CONSTRAINT priEmpresaDireccionFiscal PRIMARY KEY CLUSTERED(Empresa)
)
GO


/****** SucursalDireccionFiscal ******/
if not exists(select * from SysTabla where SysTabla = 'SucursalDireccionFiscal')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SucursalDireccionFiscal', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.SucursalDireccionFiscal') and type = 'U')
CREATE TABLE SucursalDireccionFiscal(
 Sucursal       int         NOT NULL,
 Icono          int         NULL,
 Mapeado        int         NULL,
 ClaveCP        varchar(5)  NULL,
 ClavePais      varchar(3)  NULL,
 ClaveEstado    varchar(3)  NULL,
 ClaveMunicipio varchar(3)  NULL,
 ClaveLocalidad varchar(2)  NULL,
 ClaveColonia   varchar(10) NULL,
 
 CONSTRAINT priSucursalDireccionFiscal PRIMARY KEY CLUSTERED(Sucursal)
)
GO


if exists (select * from sysobjects where id = object_id('dbo.SATDireccionFiscal') and sysstat & 0xf = 2) drop view dbo.SATDireccionFiscal
GO
CREATE VIEW SATDireccionFiscal
--//WITH ENCRYPTION
AS
SELECT
  SATCatCP.ID 'ID',
  SATCatCP.ClaveCP 'ClaveCP',
  SATPais.ClavePais 'ClavePais',
  SATPais.Descripcion 'SATPaisDescripcion',
  SATCatCP.ClaveEstado 'ClaveEstado',
  SATEstado.Descripcion 'SATEstadoDescripcion',
  SATCatCP.ClaveMunicipio 'ClaveMunicipio',
  SATMunicipio.Descripcion 'SATMunicipioDescripcion',
  SATCatCP.ClaveLocalidad 'ClaveLocalidad',
  SATLocalidad.Descripcion 'SATLocalidadDescripcion',
  SATColonia.ClaveColonia 'ClaveColonia',
  SATColonia.Descripcion 'SATColoniaDescripcion',
  SATCatCP.HusoHorario 'HusoHorario',
  SATCatCP.Descripcion 'Descripcion',
  SATCatCP.VeranoMesInicio 'VeranoMesInicio',
  SATCatCP.VeranoDiaInicio 'VeranoDiaInicio',
  SATCatCP.VeranoHoraInicio 'VeranoHoraInicio',
  SATCatCP.VeranoDiferenciaHoraria 'VeranoDiferenciaHoraria',
  SATCatCP.InviernoMesInicio 'InviernoMesInicio',
  SATCatCP.InviernoDiaInicio 'InviernoDiaInicio',
  SATCatCP.InviernoHoraInicio 'InviernoHoraInicio',
  SATCatCP.InviernoDiferenciaHoraria 'InviernoDiferenciaHoraria'
FROM SATCatCP
LEFT OUTER JOIN SATEstado ON SATCatCP.ClaveEstado=SATEstado.ClaveEstado
LEFT OUTER JOIN SATPais ON SATEstado.ClavePais = SATPais.ClavePais
LEFT OUTER JOIN SATMunicipio ON SATCatCP.ClaveMunicipio=SATMunicipio.ClaveMunicipio AND SATCatCP.ClaveEstado=SATMunicipio.ClaveEstado
LEFT OUTER JOIN SATLocalidad ON SATCatCP.ClaveLocalidad=SATLocalidad.ClaveLocalidad AND SATCatCP.ClaveEstado=SATLocalidad.ClaveEstado
LEFT OUTER JOIN SATColonia ON SATCatCP.ClaveCP = SATColonia.ClaveCP
GO


/****** Clientes ******/
if exists (select * from sysobjects where id = object_id('dbo.tgSATCteDirFiscal') and sysstat & 0xf = 8) drop trigger dbo.tgSATCteDirFiscal
GO
CREATE TRIGGER tgSATCteDirFiscal ON Cte
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
DECLARE
 @Cliente          varchar(10),
 @ClaveCP          varchar(5),
 @ClavePais        varchar(3),
 @ClaveEstado      varchar(3),
 @ClaveMunicipio   varchar(3),
 @ClaveLocalidad   varchar(2),
 @ClaveColonia     varchar(4),

 @Ok               int,
 @OkRef            varchar(255)
 
 IF UPDATE(Delegacion) OR UPDATE(Colonia) OR UPDATE(CodigoPostal) OR UPDATE(Poblacion) OR UPDATE(Estado) OR UPDATE(Pais)
 BEGIN
  SELECT @Cliente = i.Cliente, @ClavePais = ClavePais FROM SATPais p JOIN inserted i ON p.Descripcion = i.Pais
  SELECT @ClaveEstado = e.ClaveEstado FROM SATEstado e JOIN SATPais p ON e.ClavePais = p.ClavePais
    JOIN inserted i ON p.Descripcion = i.Pais AND e.Descripcion = i.Estado
  IF ISNULL(@ClavePais,'') = 'MEX'
   SELECT     
    @ClaveCP = SATCatCP.ClaveCP,
    @ClavePais = SATPais.ClavePais,
    @ClaveEstado = SATCatCP.ClaveEstado,
    @ClaveMunicipio = SATCatCP.ClaveMunicipio,
    @ClaveLocalidad = SATCatCP.ClaveLocalidad,
    @ClaveColonia = SATColonia.ClaveColonia
    FROM SATCatCP
    LEFT OUTER JOIN SATEstado ON SATCatCP.ClaveEstado=SATEstado.ClaveEstado
    LEFT OUTER JOIN SATPais ON SATEstado.ClavePais = SATPais.ClavePais
    LEFT OUTER JOIN SATMunicipio ON SATCatCP.ClaveMunicipio=SATMunicipio.ClaveMunicipio AND SATCatCP.ClaveEstado=SATMunicipio.ClaveEstado
    LEFT OUTER JOIN SATLocalidad ON SATCatCP.ClaveLocalidad=SATLocalidad.ClaveLocalidad AND SATCatCP.ClaveEstado=SATLocalidad.ClaveEstado
    LEFT OUTER JOIN SATColonia ON SATCatCP.ClaveCP = SATColonia.ClaveCP
    JOIN inserted i ON ISNULL(SATCatCP.ClaveCP,'') = i.CodigoPostal
     AND ISNULL(SATEstado.Descripcion,'') = i.Estado
     AND ISNULL(SATPais.Descripcion,'') = i.Pais
     AND ISNULL(SATMunicipio.Descripcion,'') = i.Delegacion
     AND ISNULL(SATColonia.Descripcion,'') = i.Colonia
     AND ISNULL(SATLocalidad.Descripcion,'') = i.Poblacion

   UPDATE CteDireccionFiscal SET Icono = 434, Mapeado = 1, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado, ClaveMunicipio = @ClaveMunicipio,
    ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia WHERE Cliente = @Cliente

   IF @@ROWCOUNT = 0 AND ISNULL(@Cliente,'') <> ''
	INSERT INTO CteDireccionFiscal(Cliente,  Icono, Mapeado, ClaveCP,  ClavePais,  ClaveEstado,   ClaveMunicipio,  ClaveLocalidad, ClaveColonia)
	                       SELECT @Cliente,  434,   1,       @ClaveCP, @ClavePais, @ClaveEstado, @ClaveMunicipio, @ClaveLocalidad, @ClaveColonia
 END
END
GO


/****** Sucursales de Clientes ******/
if exists (select * from sysobjects where id = object_id('dbo.tgSATCteEnviarADirFiscal') and sysstat & 0xf = 8) drop trigger dbo.tgSATCteEnviarADirFiscal
GO
CREATE TRIGGER tgSATCteEnviarADirFiscal ON CteEnviarA
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
DECLARE
 @Cliente          varchar(10),
 @ID               int,
 @ClaveCP          varchar(5),
 @ClavePais        varchar(3),
 @ClaveEstado      varchar(3),
 @ClaveMunicipio   varchar(3),
 @ClaveLocalidad   varchar(2),
 @ClaveColonia     varchar(4)
 
 IF UPDATE(Delegacion) OR UPDATE(Colonia) OR UPDATE(CodigoPostal) OR UPDATE(Poblacion) OR UPDATE(Estado) OR UPDATE(Pais)
 BEGIN
  SELECT @Cliente = i.Cliente, @ID = i.ID, @ClavePais = ClavePais FROM SATPais p JOIN inserted i ON p.Descripcion = i.Pais
  SELECT @ClaveEstado = e.ClaveEstado FROM SATEstado e JOIN SATPais p ON e.ClavePais = p.ClavePais
    JOIN inserted i ON p.Descripcion = i.Pais AND e.Descripcion = i.Estado
  IF ISNULL(@ClavePais,'') = 'MEX'
   SELECT 
    @ClaveCP = SATCatCP.ClaveCP,
    @ClavePais = SATPais.ClavePais,
    @ClaveEstado = SATCatCP.ClaveEstado,
    @ClaveMunicipio = SATCatCP.ClaveMunicipio,
    @ClaveLocalidad = SATCatCP.ClaveLocalidad,
    @ClaveColonia = SATColonia.ClaveColonia
    FROM SATCatCP
    LEFT OUTER JOIN SATEstado ON SATCatCP.ClaveEstado=SATEstado.ClaveEstado
    LEFT OUTER JOIN SATPais ON SATEstado.ClavePais = SATPais.ClavePais
    LEFT OUTER JOIN SATMunicipio ON SATCatCP.ClaveMunicipio=SATMunicipio.ClaveMunicipio AND SATCatCP.ClaveEstado=SATMunicipio.ClaveEstado
    LEFT OUTER JOIN SATLocalidad ON SATCatCP.ClaveLocalidad=SATLocalidad.ClaveLocalidad AND SATCatCP.ClaveEstado=SATLocalidad.ClaveEstado
    LEFT OUTER JOIN SATColonia ON SATCatCP.ClaveCP = SATColonia.ClaveCP
    JOIN inserted i ON ISNULL(SATCatCP.ClaveCP,'') = i.CodigoPostal
     AND ISNULL(SATEstado.Descripcion,'') = i.Estado
     AND ISNULL(SATPais.Descripcion,'') = i.Pais
     AND ISNULL(SATMunicipio.Descripcion,'') = i.Delegacion
     AND ISNULL(SATColonia.Descripcion,'') = i.Colonia
     AND ISNULL(SATLocalidad.Descripcion,'') = i.Poblacion

   UPDATE CteEnviarADireccionFiscal SET Icono = 434, Mapeado = 1, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado, ClaveMunicipio = @ClaveMunicipio,
    ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia WHERE Cliente = @Cliente AND ID = @ID

   IF @@ROWCOUNT = 0 AND ISNULL(@Cliente,'') <> '' AND @ID IS NOT NULL
	INSERT INTO CteEnviarADireccionFiscal(Cliente, ID, Icono, Mapeado, ClaveCP,  ClavePais,  ClaveEstado,   ClaveMunicipio,  ClaveLocalidad, ClaveColonia)
	                              SELECT @Cliente, @ID, 434,   1,       @ClaveCP, @ClavePais, @ClaveEstado, @ClaveMunicipio, @ClaveLocalidad, @ClaveColonia
 END
END
GO



/****** Empresas ******/
if exists (select * from sysobjects where id = object_id('dbo.tgSATEmpresaDirFiscal') and sysstat & 0xf = 8) drop trigger dbo.tgSATEmpresaDirFiscal
GO
CREATE TRIGGER tgSATEmpresaDirFiscal ON Empresa
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
DECLARE
 @Empresa          varchar(5),
 @ClaveCP          varchar(5),
 @ClavePais        varchar(3),
 @ClaveEstado      varchar(3),
 @ClaveMunicipio   varchar(3),
 @ClaveLocalidad   varchar(2),
 @ClaveColonia     varchar(4)
 
 IF UPDATE(Delegacion) OR UPDATE(Colonia) OR UPDATE(CodigoPostal) OR UPDATE(Poblacion) OR UPDATE(Estado) OR UPDATE(Pais)
 BEGIN
  SELECT @Empresa = i.Empresa, @ClavePais = ClavePais FROM SATPais p JOIN inserted i ON p.Descripcion = i.Pais
  SELECT @ClaveEstado = e.ClaveEstado FROM SATEstado e JOIN SATPais p ON e.ClavePais = p.ClavePais
    JOIN inserted i ON p.Descripcion = i.Pais AND e.Descripcion = i.Estado
  IF ISNULL(@ClavePais,'') = 'MEX'
   SELECT 
    @ClaveCP = SATCatCP.ClaveCP,
    @ClavePais = SATPais.ClavePais,
    @ClaveEstado = SATCatCP.ClaveEstado,
    @ClaveMunicipio = SATCatCP.ClaveMunicipio,
    @ClaveLocalidad = SATCatCP.ClaveLocalidad,
    @ClaveColonia = SATColonia.ClaveColonia
    FROM SATCatCP
    LEFT OUTER JOIN SATEstado ON SATCatCP.ClaveEstado=SATEstado.ClaveEstado
    LEFT OUTER JOIN SATPais ON SATEstado.ClavePais = SATPais.ClavePais
    LEFT OUTER JOIN SATMunicipio ON SATCatCP.ClaveMunicipio=SATMunicipio.ClaveMunicipio AND SATCatCP.ClaveEstado=SATMunicipio.ClaveEstado
    LEFT OUTER JOIN SATLocalidad ON SATCatCP.ClaveLocalidad=SATLocalidad.ClaveLocalidad AND SATCatCP.ClaveEstado=SATLocalidad.ClaveEstado
    LEFT OUTER JOIN SATColonia ON SATCatCP.ClaveCP = SATColonia.ClaveCP
    JOIN inserted i ON ISNULL(SATCatCP.ClaveCP,'') = i.CodigoPostal
     AND ISNULL(SATEstado.Descripcion,'') = i.Estado
     AND ISNULL(SATPais.Descripcion,'') = i.Pais
     AND ISNULL(SATMunicipio.Descripcion,'') = i.Delegacion
     AND ISNULL(SATColonia.Descripcion,'') = i.Colonia
     AND ISNULL(SATLocalidad.Descripcion,'') = i.Poblacion

   UPDATE EmpresaDireccionFiscal SET Icono = 434, Mapeado = 1, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado, ClaveMunicipio = @ClaveMunicipio,
    ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia WHERE Empresa = @Empresa

   IF @@ROWCOUNT = 0 AND ISNULL(@Empresa,'') <> ''
	INSERT INTO EmpresaDireccionFiscal(Empresa,  Icono, Mapeado, ClaveCP,  ClavePais,  ClaveEstado,   ClaveMunicipio,  ClaveLocalidad, ClaveColonia)
	                           SELECT @Empresa, 434,   1,       @ClaveCP, @ClavePais, @ClaveEstado, @ClaveMunicipio, @ClaveLocalidad, @ClaveColonia
 END
END
GO


/****** Personal ******/
if exists (select * from sysobjects where id = object_id('dbo.tgSATPersonalDirFiscal') and sysstat & 0xf = 8) drop trigger dbo.tgSATPersonalDirFiscal
GO
CREATE TRIGGER tgSATPersonalDirFiscal ON Personal
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
DECLARE
 @Personal         varchar(10),
 @ClaveCP          varchar(5),
 @ClavePais        varchar(3),
 @ClaveEstado      varchar(3),
 @ClaveMunicipio   varchar(3),
 @ClaveLocalidad   varchar(2),
 @ClaveColonia     varchar(4)
 
 IF UPDATE(Delegacion) OR UPDATE(Colonia) OR UPDATE(CodigoPostal) OR UPDATE(Poblacion) OR UPDATE(Estado) OR UPDATE(Pais)
 BEGIN
  SELECT @Personal = i.Personal, @ClavePais = ClavePais FROM SATPais p JOIN inserted i ON p.Descripcion = i.Pais
  SELECT @ClaveEstado = e.ClaveEstado FROM SATEstado e JOIN SATPais p ON e.ClavePais = p.ClavePais
    JOIN inserted i ON p.Descripcion = i.Pais AND e.Descripcion = i.Estado
  IF ISNULL(@ClavePais,'') = 'MEX'
   SELECT     
    @ClaveCP = SATCatCP.ClaveCP,
    @ClavePais = SATPais.ClavePais,
    @ClaveEstado = SATCatCP.ClaveEstado,
    @ClaveMunicipio = SATCatCP.ClaveMunicipio,
    @ClaveLocalidad = SATCatCP.ClaveLocalidad,
    @ClaveColonia = SATColonia.ClaveColonia
    FROM SATCatCP
    LEFT OUTER JOIN SATEstado ON SATCatCP.ClaveEstado=SATEstado.ClaveEstado
    LEFT OUTER JOIN SATPais ON SATEstado.ClavePais = SATPais.ClavePais
    LEFT OUTER JOIN SATMunicipio ON SATCatCP.ClaveMunicipio=SATMunicipio.ClaveMunicipio AND SATCatCP.ClaveEstado=SATMunicipio.ClaveEstado
    LEFT OUTER JOIN SATLocalidad ON SATCatCP.ClaveLocalidad=SATLocalidad.ClaveLocalidad AND SATCatCP.ClaveEstado=SATLocalidad.ClaveEstado
    LEFT OUTER JOIN SATColonia ON SATCatCP.ClaveCP = SATColonia.ClaveCP
    JOIN inserted i ON ISNULL(SATCatCP.ClaveCP,'') = i.CodigoPostal
     AND ISNULL(SATEstado.Descripcion,'') = i.Estado 
     AND ISNULL(SATPais.Descripcion,'') = i.Pais
     AND ISNULL(SATMunicipio.Descripcion,'') = i.Delegacion
     AND ISNULL(SATColonia.Descripcion,'') = i.Colonia
     AND ISNULL(SATLocalidad.Descripcion,'') = i.Poblacion

   UPDATE PersonalDireccionFiscal SET Icono = 434, Mapeado = 1, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado, ClaveMunicipio = @ClaveMunicipio,
    ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia WHERE Personal = @Personal

   IF @@ROWCOUNT = 0 AND ISNULL(@Personal,'') <> ''
	INSERT INTO PersonalDireccionFiscal(Personal,  Icono, Mapeado, ClaveCP,  ClavePais,  ClaveEstado,   ClaveMunicipio,  ClaveLocalidad, ClaveColonia)
	                             SELECT @Personal, 434,   1,       @ClaveCP, @ClavePais, @ClaveEstado, @ClaveMunicipio, @ClaveLocalidad, @ClaveColonia
 END
END
GO


/****** Proveedores ******/
if exists (select * from sysobjects where id = object_id('dbo.tgSATProvDirFiscal') and sysstat & 0xf = 8) drop trigger dbo.tgSATProvDirFiscal
GO


/****** Sucursales ******/
if exists (select * from sysobjects where id = object_id('dbo.tgSATSucursalDirFiscal') and sysstat & 0xf = 8) drop trigger dbo.tgSATSucursalDirFiscal
GO
CREATE TRIGGER tgSATSucursalDirFiscal ON Sucursal
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
DECLARE
 @Sucursal         int,
 @ClaveCP          varchar(5),
 @ClavePais        varchar(3),
 @ClaveEstado      varchar(3),
 @ClaveMunicipio   varchar(3),
 @ClaveLocalidad   varchar(2),
 @ClaveColonia     varchar(4)
 
 IF UPDATE(Delegacion) OR UPDATE(Colonia) OR UPDATE(CodigoPostal) OR UPDATE(Poblacion) OR UPDATE(Estado) OR UPDATE(Pais)
 BEGIN
  SELECT @Sucursal = i.Sucursal, @ClavePais = ClavePais FROM SATPais p JOIN inserted i ON p.Descripcion = i.Pais
  SELECT @ClaveEstado = e.ClaveEstado FROM SATEstado e JOIN SATPais p ON e.ClavePais = p.ClavePais
    JOIN inserted i ON p.Descripcion = i.Pais AND e.Descripcion = i.Estado
  IF ISNULL(@ClavePais,'') = 'MEX'
   SELECT     
    @ClaveCP = SATCatCP.ClaveCP,
    @ClavePais = SATPais.ClavePais,
    @ClaveEstado = SATCatCP.ClaveEstado,
    @ClaveMunicipio = SATCatCP.ClaveMunicipio,
    @ClaveLocalidad = SATCatCP.ClaveLocalidad,
    @ClaveColonia = SATColonia.ClaveColonia
    FROM SATCatCP
    LEFT OUTER JOIN SATEstado ON SATCatCP.ClaveEstado=SATEstado.ClaveEstado
    LEFT OUTER JOIN SATPais ON SATEstado.ClavePais = SATPais.ClavePais
    LEFT OUTER JOIN SATMunicipio ON SATCatCP.ClaveMunicipio=SATMunicipio.ClaveMunicipio AND SATCatCP.ClaveEstado=SATMunicipio.ClaveEstado
    LEFT OUTER JOIN SATLocalidad ON SATCatCP.ClaveLocalidad=SATLocalidad.ClaveLocalidad AND SATCatCP.ClaveEstado=SATLocalidad.ClaveEstado
    LEFT OUTER JOIN SATColonia ON SATCatCP.ClaveCP = SATColonia.ClaveCP
    JOIN inserted i ON ISNULL(SATCatCP.ClaveCP,'') = i.CodigoPostal
     AND ISNULL(SATEstado.Descripcion,'') = i.Estado
     AND ISNULL(SATPais.Descripcion,'') = i.Pais
     AND ISNULL(SATMunicipio.Descripcion,'') = i.Delegacion
     AND ISNULL(SATColonia.Descripcion,'') = i.Colonia
     AND ISNULL(SATLocalidad.Descripcion,'') = i.Poblacion

   UPDATE SucursalDireccionFiscal SET Icono = 434, Mapeado = 1, ClaveCP = @ClaveCP, ClavePais = @ClavePais, ClaveEstado = @ClaveEstado, ClaveMunicipio = @ClaveMunicipio,
    ClaveLocalidad = @ClaveLocalidad, ClaveColonia = @ClaveColonia WHERE Sucursal = @Sucursal

   IF @@ROWCOUNT = 0 AND @Sucursal IS NOT NULL
	INSERT INTO SucursalDireccionFiscal(Sucursal,  Icono, Mapeado, ClaveCP,  ClavePais,  ClaveEstado,   ClaveMunicipio,  ClaveLocalidad, ClaveColonia)
	                             SELECT @Sucursal, 434,   1,       @ClaveCP, @ClavePais, @ClaveEstado, @ClaveMunicipio, @ClaveLocalidad, @ClaveColonia
 END
END
GO