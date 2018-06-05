/*******************************************************************************************/
/*                                         Competencias                     	           */
/*******************************************************************************************/

-- drop table CompetenciaTipo
/****** CompetenciaTipo ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CompetenciaTipo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CompetenciaTipo', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CompetenciaTipo') AND Type = 'U') 
  CREATE TABLE dbo.CompetenciaTipo (
  	Tipo		varchar(50)	NOT NULL,

	Orden		int		NULL,  
  	CONSTRAINT pkCompetenciaTipo PRIMARY KEY  CLUSTERED (Tipo)
  )  
GO
EXEC spALTER_TABLE 'CompetenciaTipo', 'Orden', 'int NULL'
GO
-- drop table CompetenciaCat
/****** CompetenciaCat ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CompetenciaCat')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CompetenciaCat', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CompetenciaCat') AND Type = 'U') 
  CREATE TABLE dbo.CompetenciaCat (
  	Categoria	varchar(50)	NOT NULL,
  
  	CONSTRAINT pkCompetenciaCat PRIMARY KEY  CLUSTERED (Categoria)
  )  
GO

-- drop table CompetenciaGrupo
/****** CompetenciaGrupo ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CompetenciaGrupo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CompetenciaGrupo', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CompetenciaGrupo') AND Type = 'U') 
  CREATE TABLE dbo.CompetenciaGrupo (
  	Grupo		varchar(50)	NOT NULL,
  
  	CONSTRAINT pkCompetenciaGrupo PRIMARY KEY  CLUSTERED (Grupo)
  )  
GO

-- drop table CompetenciaFam
/****** CompetenciaFam ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CompetenciaFam')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CompetenciaFam', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CompetenciaFam') AND Type = 'U') 
  CREATE TABLE dbo.CompetenciaFam (
  	Familia		varchar(50)	NOT NULL,
  
  	CONSTRAINT pkCompetenciaFam PRIMARY KEY  CLUSTERED (Familia)
  )  
GO

EXEC spDROP_TABLE 'PersonalCompetencia', 3310
GO
/****** PersonalCompetencia ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'PersonalCompetencia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalCompetencia','Cuenta')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.PersonalCompetencia') AND Type = 'U') 
  CREATE TABLE dbo.PersonalCompetencia (
  	Personal		varchar(10)	NOT NULL,
	Competencia		varchar(20)	NOT NULL,
	
	Resultado		varchar(100)	NULL,
	Valor			float		NULL,
	ValorMinimo		float		NULL,
	Peso			float		NULL,
	Observaciones		varchar(100)	NULL,

	CONSTRAINT pkPersonalCompetencia PRIMARY KEY CLUSTERED (Personal, Competencia)
)
GO

EXEC spDROP_TABLE 'PersonalCompetenciaEntrevista', 3310
GO

IF EXISTS (SELECT * FROM SysObjects WHERE name = 'pkPuestoCompetencia') 
AND NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.PuestoCompetencia') 
AND Type = 'U') AND EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.PuestoCompetencia_OLD') AND Type = 'U')
  ALTER TABLE PuestoCompetencia_OLD DROP CONSTRAINT pkPuestoCompetencia

-- drop table PuestoCompetencia
/****** PuestoCompetencia ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'PuestoCompetencia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PuestoCompetencia','Cuenta')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.PuestoCompetencia') AND Type = 'U') 
  CREATE TABLE dbo.PuestoCompetencia (
  	Puesto			varchar(50)	NOT NULL,
	Competencia		varchar(20)	NOT NULL,
	
	Peso			float		NULL,
	ValorMinimo		float		NULL,

	CONSTRAINT pkPuestoCompetencia PRIMARY KEY CLUSTERED (Puesto, Competencia)
)
GO
EXEC spALTER_TABLE 'PuestoCompetencia', 'ValorMinimo', 'float NULL'
GO

/****** PuestoCompetenciaTipo ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'PuestoCompetenciaTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PuestoCompetenciaTipo','Cuenta')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.PuestoCompetenciaTipo') AND Type = 'U') 
  CREATE TABLE dbo.PuestoCompetenciaTipo (
  	Puesto			varchar(50)	NOT NULL,
	Tipo			varchar(50)	NOT NULL,
	
	Peso			float		NULL,

	CONSTRAINT pkPuestoCompetenciaTipo PRIMARY KEY CLUSTERED (Puesto, Tipo)
)
GO

EXEC spDROP_TABLE 'CompetenciaResultado', 3310
GO
/****** CompetenciaResultado ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CompetenciaResultado')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CompetenciaResultado', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CompetenciaResultado') AND Type = 'U') 
  CREATE TABLE dbo.CompetenciaResultado (
  	Competencia	varchar(20)	NOT NULL,
  	Resultado	varchar(100)	NOT NULL,
  	
  	Valor		float		NULL,
  	Orden		int		NULL,
  	  
  	CONSTRAINT pkCompetenciaResultado PRIMARY KEY  CLUSTERED (Competencia, Resultado)
  )
GO
EXEC spADD_INDEX 'CompetenciaResultado', 'Orden', 'Competencia, Orden'
GO

IF EXISTS (SELECT * FROM SysObjects WHERE name = 'pkCompetencia') 
AND NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.Competencia') AND Type = 'U') 
AND EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.Competencia_OLD') AND Type = 'U')
  ALTER TABLE Competencia_OLD DROP CONSTRAINT pkCompetencia

-- drop table Competencia
/****** Competencia ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'Competencia')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('Competencia', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.Competencia') AND Type = 'U') 
  CREATE TABLE dbo.Competencia (
  	Competencia		varchar(20)	NOT NULL,
  	
  	Nombre			varchar(100)	NULL,
  	Descripcion		varchar(255)	NULL,
  	Tipo			varchar(50)	NULL,
  	Categoria		varchar(50)	NULL,
  	Grupo			varchar(50)	NULL,
  	Familia			varchar(50)	NULL,
  
	TieneMovimientos	bit		NULL	DEFAULT 0,
	Estatus 		varchar(15) 	NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Usuario			varchar(10)	NULL,
	
  	CONSTRAINT pkCompetencia PRIMARY KEY  CLUSTERED (Competencia)
  )
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgCompetenciaBC') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgCompetenciaBC
GO
EXEC spALTER_TABLE 'Competencia', 'Nombre', 'Varchar(100) NULL'
GO
IF EXISTS(SELECT * FROM syscampo WHERE tabla = 'Competencia' AND campo = 'Competencia')
  EXEC("ALTER TABLE Competencia ALTER COLUMN Competencia varchar(20) NOT NULL") --JGD 06Abril2011 Solución Ticket 2858
ELSE 
  EXEC spALTER_TABLE 'Competencia', 'Competencia', 'varchar(20) NOT NULL'
GO
IF EXISTS(SELECT * FROM syscampo WHERE tabla = 'Competencia' AND campo = 'Usuario')
  EXEC("ALTER TABLE Competencia ALTER COLUMN Usuario varchar(10) NULL") --JGD 05Abril2011 Solución Ticket 2858
ELSE 
  EXEC spALTER_TABLE 'Competencia', 'Usuario', 'varchar(10) NULL'
GO
IF EXISTS(SELECT * FROM syscampo WHERE tabla = 'Competencia' AND campo = 'Descripcion')
  EXEC("ALTER TABLE Competencia ALTER COLUMN Descripcion varchar(255) NULL") --JGD 05Abril2011 Solución Ticket 2858
ELSE 
  EXEC spALTER_TABLE 'Competencia', 'Descripcion', 'varchar(255) NULL'
GO
EXEC spADD_INDEX 'Competencia', 'Nombre', 'Nombre'
GO
IF EXISTS(SELECT s.Name,sy.Name,sy.Parent_obj 
            FROM sysobjects s 
            JOIN sysobjects sy ON s.id = sy.Parent_obj
           WHERE s.Name = 'Competencia_OLD' AND s.TYPE = 'U'
             AND sy.Name = 'priCompetencia' AND sy.TYPE = 'K')
  EXEC("ALTER TABLE Competencia_OLD DROP CONSTRAINT priCompetencia")
GO
--IF EXISTS(SELECT * FROM sysobjects WHERE NAME = 'priCompetencia' AND TYPE = 'K') --JGD 06Abril2011 Solución Ticket 2858
IF EXISTS(SELECT s.Name,sy.Name,sy.Parent_obj 
            FROM sysobjects s 
            JOIN sysobjects sy ON s.id = sy.Parent_obj
           WHERE s.Name = 'Competencia' AND s.TYPE = 'U'
             AND sy.Name = 'priCompetencia' AND sy.TYPE = 'K')
  EXEC("ALTER TABLE Competencia DROP CONSTRAINT priCompetencia")
GO
IF EXISTS(SELECT * FROM syscampo WHERE tabla = 'Competencia' AND campo = 'Clave') --JGD 06Abril2011 Solución Ticket 2858
  ALTER TABLE Competencia DROP COLUMN Clave
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'pkCompetencia' AND TYPE = 'K') --JGD 06Abril2011 Solución Ticket 2858
  ALTER TABLE Competencia ADD CONSTRAINT pkCompetencia PRIMARY KEY CLUSTERED (Competencia)
GO
CREATE TRIGGER tgCompetenciaBC ON Competencia
--5//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CompetenciaN  varchar(20),
    @CompetenciaA	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CompetenciaN = Competencia FROM Inserted
  SELECT @CompetenciaA = Competencia FROM Deleted
  IF @CompetenciaN = @CompetenciaA RETURN

  IF @CompetenciaN IS NULL 
  BEGIN
    DELETE CompetenciaResultado WHERE Competencia = @CompetenciaA
  END ELSE
  IF @CompetenciaA IS NOT NULL 
  BEGIN
    UPDATE CompetenciaResultado SET Competencia = @CompetenciaN WHERE Competencia = @CompetenciaA
  END
END
GO

