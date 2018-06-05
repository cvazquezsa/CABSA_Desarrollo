--- 07-Ene-2004 Ver. 1.0.1 SB.EXE 1.2.0 genera las tablas necesarias para ScoreBoard

--- Para guardar que filtros lleva cada proceso 5-01-2004
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'SBFiltro')
	INSERT INTO SysTabla (SysTabla) VALUES ('SBFiltro')
GO
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.SBFiltro') AND Type = 'U')
CREATE TABLE SBFiltro(
	Proceso		varchar(20) NOT NULL,
	Filtro		varchar(20) NOT NULL,
	Tabla		varchar(20) NOT NULL,
	Llave		varchar(20) NOT NULL,
	Nombre		varchar(20) NULL,
	Tipo		varchar(10) NULL,
	Activo		bit	    NULL,
	Parentesis	bit	    NULL,
	ValorDefault	varchar(20) NULL,
	Campo		varchar(20) NULL,
	Orden		smallint    NULL,
	Variable	varchar(20) NULL,

    CONSTRAINT priSBFiltro PRIMARY KEY CLUSTERED (Proceso,Filtro,Tabla)
)
GO
--- Store para llenar la tabla de SBFiltro
IF EXISTS(SELECT * FROM dbo.SysObjects WHERE Id = Object_Id('[dbo].[spSBInsertarFiltro]'))
	DROP PROCEDURE spSBInsertarFiltro
GO
CREATE PROCEDURE spSBInsertarFiltro
        @Proceso	varchar(20),
        @Filtro		varchar(20),
        @Tabla		varchar(20),
        @Llave		varchar(20),
        @Nombre		varchar(20),
        @Tipo		varchar(10),
        @Activo		bit,
        @Parentesis	bit,
	@ValorDefault	varchar(20),
	@Campo		varchar(20),
        @Orden		smallint,
	@Variable	varchar(20) = NULL

--//WITH ENCRYPTION
AS
  IF (SELECT COUNT(*) FROM SBFiltro WHERE Filtro = @Filtro AND Proceso = @Proceso AND Tabla = @Tabla) < 1
    INSERT INTO SBFiltro (Proceso, Filtro, Tabla, Llave, Nombre,Tipo, Activo, ValorDefault, Orden, Variable, Parentesis, Campo)
    	VALUES (@Proceso, @Filtro, @Tabla, @Llave, @Nombre, @Tipo, @Activo, @ValorDefault, @Orden, @Variable , @Parentesis, @Campo)
GO

--- Obtener filtros para cada proceso 5-01-2004
SET QUOTED_IDENTIFIER OFF
GO
IF EXISTS(SELECT * FROM dbo.SysObjects WHERE Id = Object_Id('[dbo].[spSBObtenerFiltro]'))
DROP PROCEDURE [dbo].[spSBObtenerFiltro]
GO
CREATE PROCEDURE spSBObtenerFiltro
	@Proceso	varchar(20)

--//WITH ENCRYPTION
AS
  DECLARE     
	@Filtro		varchar(20),
	@Tabla		varchar(20),
	@Llave		varchar(20),
	@Nombre		varchar(20),
	@Tipo		varchar(10),
	@ValorDefault	varchar(20),
	@Campo		varchar(20),
	@Activo		bit,
	@Parentesis	bit,
	@Variable	varchar(20),
	@Orden		smallint,
	@Cadena		varchar(500),
	@Instruccion	varchar(8000),
	@i		smallint

	DECLARE SB_Cursor CURSOR FOR
	SELECT  DISTINCT a.Filtro, a.Tabla, a.Llave, a.Nombre, a.Tipo, a.Activo, a.Orden, ISNULL(a.ValorDefault,''),Variable,Campo,Parentesis
		FROM    SBFiltro a
		WHERE   Activo = 1 
			AND Proceso = @Proceso 

	  SET @i = 1
	
	  OPEN SB_Cursor
	
	  FETCH NEXT FROM SB_Cursor
	  INTO @Filtro, @Tabla, @Llave, @Nombre, @Tipo, @Activo, @Orden, @ValorDefault, @Variable, @Campo, @Parentesis
	
	  WHILE @@FETCH_STATUS = 0
	  BEGIN
		SET @Cadena = "SELECT 'Campo'= '" + @Campo + "','Valor'="
		IF @Tipo = 'CHAR'
			IF @Parentesis = 1
				SET @Cadena = @Cadena + "'('+" + "RTRIM(" + @Llave + ")"     + "+')',"
			ELSE IF @Nombre IS NULL
				SET @Cadena = @Cadena + "RTRIM(" + @Llave + ") ,"
			      ELSE
				SET @Cadena = @Cadena + "RTRIM(" + @Llave + ") + ' - ' + ISNULL(" + @Nombre + ",''),"
		ELSE
			SET @Cadena = @Cadena + "REPLICATE(' ',6 - LEN(RTRIM(CONVERT(varchar(5)," + @Llave + ")))) + RTRIM(CONVERT(varchar(5)," + @Llave + ")) + ' - ' + ISNULL(" + @Nombre + ",''),"
		
		SET @Cadena = @Cadena + "'Orden' = " + CONVERT(VARCHAR(3),@Orden) + ","
		SET @Cadena = @Cadena + "'Etiqueta' = '" + @Filtro + "',"
		SET @Cadena = @Cadena + "'Grupo' = '" + CONVERT(VARCHAR(2),@Parentesis) + "',"
		SET @Cadena = @Cadena + "'ValorDefault' = '" + @ValorDefault + "' FROM " + @Tabla
		
		IF @Variable IS NOT NULL
			SET @Cadena = @Cadena + " WHERE " + @Variable

		IF @i = 1
			SET @Instruccion = @Cadena
		ELSE
			SET @Instruccion = @Instruccion + ' UNION ' + @Cadena
		
		SET @i = @i + 1
		
		FETCH NEXT FROM SB_Cursor
		INTO @Filtro,@Tabla,@Llave,@Nombre,@Tipo,@Activo,@Orden, @ValorDefault, @Variable, @Campo, @Parentesis
	  END

	CLOSE SB_Cursor
	DEALLOCATE SB_Cursor
	
	SET @Instruccion = @Instruccion + ' ORDER BY Orden'
	
	EXEC (@Instruccion)
	

GO
--- Obtener la lista de acuerdo al grupo
IF EXISTS(SELECT * FROM dbo.SysObjects WHERE Id = Object_Id('[dbo].[spSBGrupoFiltro]'))
DROP PROCEDURE [dbo].[spSBGrupoFiltro]
GO
CREATE PROCEDURE spSBGrupoFiltro
	@Filtro		varchar(50),
	@Valor		varchar(50)

--//WITH ENCRYPTION
AS
 BEGIN
	DECLARE	@Multiple 	bit

IF @Filtro = 'Usuario'
BEGIN
	SELECT @Multiple = Multiple FROM GrupoTrabajo WHERE GrupoTrabajo = @Valor
	IF @Multiple = 1
	SELECT DISTINCT u.Usuario Dato FROM Usuario u, GrupoTrabajoD g WHERE g.GrupoTrabajo = @Valor AND u.GrupoTrabajo = g.GrupoTrabajoD
	ELSE
	SELECT Usuario Dato FROM Usuario WHERE GrupoTrabajo = @Valor
END	

IF @Filtro = 'Mov'
	SELECT Mov Dato FROM MovTipo mt,MovClave mc WHERE mc.Modulo = mt.Modulo AND mc.Clave  = mt.Clave AND mc.Grupo = @Valor


END

GO


--- Tabla temporal de trabajo donde se encuentran los filtros requeridos por el usuario
IF EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.SBTrabajo') AND Type = 'U')
	DROP TABLE SBTrabajo
GO
CREATE TABLE SBTrabajo(
	Id		INT IDENTITY NOT NULL,
	Proceso		varchar(20)  NOT NULL,
	Dimension	varchar(20)  NOT NULL,
	Tipo		varchar(20)  NULL,
	FiltroActual	varchar(1000) NULL,
	FiltroAnterior	varchar(1000) NULL,
	FiltroPresupuesto varchar(1000) NULL,
	Orden		int NULL,

    CONSTRAINT priSBTrabajo PRIMARY KEY CLUSTERED (ID)
)
GO

--- Tabla para guardar los totales requeridos por el usuario
IF EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.SBTotales') AND Type = 'U')
	DROP TABLE SBTotales
GO
CREATE TABLE SBTotales(
	Id		INT IDENTITY NOT NULL,
	Id_Proceso	INT NOT NULL,
	Llave		VARCHAR(100)   NULL,
	Nombre		VARCHAR(100)  NULL,
	Actual		MONEY  NULL,
	Anterior	MONEY  NULL,
	Presupuesto	MONEY  NULL,

    CONSTRAINT priSBTotales PRIMARY KEY CLUSTERED (ID)
)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SBTotales' AND sysindexes.name = 'ID_proceso' AND sysobjects.id = sysindexes.id)
CREATE INDEX Id_Proceso      ON dbo.SBTotales (Id_Proceso)
GO

--- Guarda las vistas de los usuarios
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'SBVista')
	INSERT INTO SysTabla (SysTabla) VALUES ('SBVista')
GO
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.SBVista') AND Type = 'U')
CREATE TABLE SBVista(
	Vista		varchar(100)    NOT NULL,
        ID              int             NOT NULL      IDENTITY(1,1),
	Proceso		varchar(50)     NOT NULL,
	Dimension	varchar(50)     NOT NULL,
	Medida 		varchar(50)     NOT NULL,
	Fecha 		varchar(50)     NULL,
	Orden		varchar(50)     NULL,

    CONSTRAINT priSBVista PRIMARY KEY CLUSTERED (Vista)
)
GO

--- El detalle de vistas
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'SBVistaD')
	INSERT INTO SysTabla (SysTabla) VALUES ('SBVistaD')
GO
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.SBVistaD') AND Type = 'U')
CREATE TABLE SBVistaD(
        ID              int             NOT NULL,
        RID             int             NOT NULL      IDENTITY(1,1),
	Filtro		varchar(50)     NOT NULL,
	Valor		varchar(50)     NULL,
	Etiqueta        varchar(50)     NULL,

    CONSTRAINT priSBVistaD PRIMARY KEY CLUSTERED (ID, RID, Filtro)
)
GO


-- Los procesos que utiliza la ScoreBoard
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'SBProceso')
	INSERT INTO SysTabla (SysTabla) VALUES ('SBProceso')
GO
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.SBProceso') AND Type = 'U')
CREATE TABLE SBProceso(
	Proceso		varchar(50)     NOT NULL,
	InvertirColores	bit 		NOT NULL 	DEFAULT 0,
	Importe		bit 		NOT NULL 	DEFAULT 1,
	Cantidad	bit 		NOT NULL 	DEFAULT 1,
	Margen		bit 		NOT NULL 	DEFAULT 0,
	UsarPresupuesto	bit 		NOT NULL 	DEFAULT 0,
	UsarFecha	bit 		NOT NULL 	DEFAULT 1,
	MostrarPorcentajeNegativo	bit 		NOT NULL 	DEFAULT 1,

    CONSTRAINT priSBProceso PRIMARY KEY CLUSTERED (Proceso)
)
GO


--- las dimensiones de cada proceso
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'SBProcesoDimension')
	INSERT INTO SysTabla (SysTabla) VALUES ('SBProcesoDimension')
GO 
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.SBProcesoDimension') AND Type = 'U')
CREATE TABLE SBProcesoDimension(
	Proceso			varchar(50)     NOT NULL,
	Dimension		varchar(50)     NOT NULL,
	AnteriorPrimerPorc	float		NULL		DEFAULT 50,
	AnteriorSegundoPorc	float		NULL		DEFAULT 100,
	PresupuestoPrimerPorc	float		NULL		DEFAULT 50,
	PresupuestoSegundoPorc	float		NULL		DEFAULT 100,
	Tabla			varchar(50)     NULL,
	Catalogo		varchar(50)     NULL,
	NombreCampo		varchar(50)     NULL,
	UsarDescripcion		bit		NULL 		DEFAULT 0,
	LlaveCatalogo		varchar(50)     NULL,	
	LlaveDimension		varchar(50)     NULL,	
	TituloNegritas		bit		NULL		DEFAULT 0,	
	Cubo			Varchar(20)	NULL,	

    CONSTRAINT priSBProcesoDimension PRIMARY KEY CLUSTERED (Proceso, Dimension)
)
GO
