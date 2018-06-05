/****** Consecutivos Recluta ******/
if not exists(select * from SysTabla where SysTabla = 'ReclutaC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ReclutaC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ReclutaC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ReclutaC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priReclutaC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ReclutaC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'ReclutaC', '(ID)'
GO

EXEC spDROP_TABLE 'Recluta', 3310
GO
/****** Recluta (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'Recluta')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Recluta','Movimiento','RE')
if not exists (select * from sysobjects where id = object_id('dbo.Recluta') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Recluta (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	NOT NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
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
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	IDOrigen		int		NULL,
	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		varchar(20)	NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,
	ContID			int		NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,
	Comentarios		text		NULL,
	Prioridad		varchar(10)	NULL,
	PuedeDevolver		bit		NULL	DEFAULT 0,

	Personal		varchar(10)	NULL,
	Puesto			varchar(50)	NULL,
	
	SueldoD			money		NULL,
	SueldoA			money		NULL,
	
	SueldoActual		money		NULL,
	SueldoMinimo		money		NULL,
	SueldoAspira		money		NULL,
			
	-- Aqui van los campos del modulo

	CONSTRAINT priRecluta PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Recluta'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Recluta'
go
EXEC spALTER_TABLE 'Recluta', 'Comentarios', 'text NULL'
EXEC spALTER_TABLE 'Recluta', 'PuedeDevolver', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Recluta', 'Prioridad', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Recluta', 'IDOrigen', 'int NULL'
EXEC spALTER_TABLE 'Recluta', 'SueldoD', 'money NULL'
EXEC spALTER_TABLE 'Recluta', 'SueldoA', 'money NULL'
EXEC spALTER_TABLE 'Recluta', 'SueldoActual', 'money NULL'
EXEC spALTER_TABLE 'Recluta', 'SueldoMinimo', 'money NULL'
EXEC spALTER_TABLE 'Recluta', 'SueldoAspira', 'money NULL'
GO
EXEC spADD_INDEX 'Recluta', 'Referencia', 'Referencia'
EXEC spADD_INDEX 'Recluta', 'Consecutivo', 'MovID, Mov, Estatus, Sucursal, Empresa'
EXEC spADD_INDEX 'Recluta', 'FechaEmision', 'FechaEmision, Estatus, Empresa'
EXEC spADD_INDEX 'Recluta', 'Abrir', 'Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion'
EXEC spADD_INDEX 'Recluta', 'Situacion', 'Estatus, Situacion, Empresa'
EXEC spADD_INDEX 'Recluta', 'Usuario', 'Usuario'
EXEC spADD_INDEX 'Recluta', 'ContID', 'ContID'
GO

--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Recluta' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Recluta (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Recluta' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Recluta (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Recluta' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Recluta (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgReclutaA') and sysstat & 0xf = 8) drop trigger dbo.tgReclutaA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgReclutaC') and sysstat & 0xf = 8) drop trigger dbo.tgReclutaC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgReclutaB') and sysstat & 0xf = 8) drop trigger dbo.tgReclutaB
GO
EXEC spModificarPK_Mov 'Recluta'
GO
EXEC spSincroNivelRegistroCampos 'Recluta'
GO
-- Aqui va el Matenimiento a la tabla

GO
CREATE TRIGGER tgReclutaC ON Recluta
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 		char(5),
    @Mov		char(20),
    @Sucursal		int,
    @ID			int,
    @FechaInicio	datetime,
    @Ahora 		datetime,
    @FechaAnterior	datetime,
    @EstatusNuevo 	char(15),
    @EstatusAnterior 	char(15),
    @SituacionNueva 	varchar(50),
    @SituacionAnterior 	varchar(50),
    @Usuario		char(10),
    @Mensaje		char(255),
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Modulo = 'RE'
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
  IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE Recluta SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgReclutaB ON Recluta
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	char(15),
    @Mensaje	char(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'RE', @ID
END
GO

-- drop table ReclutaPlaza
/****** ReclutaPlaza (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'ReclutaPlaza')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ReclutaPlaza','Movimiento','RE')
if not exists (select * from sysobjects where id = object_id('dbo.ReclutaPlaza') and type = 'U') 
CREATE TABLE dbo.ReclutaPlaza (
	ID 			int       	NOT NULL,
	Plaza			varchar(20)	NOT NULL,
	
	EstaPendiente		bit		NULL	DEFAULT 0,

	CONSTRAINT priReclutaPlaza PRIMARY KEY CLUSTERED (ID, Plaza)
)
go
EXEC spModificarPK_Sucursal 'ReclutaPlaza', '(ID, Plaza)'
GO
if exists (select * from sysobjects where id = object_id('dbo.cReclutaPlaza') and sysstat & 0xf = 2) drop view dbo.cReclutaPlaza
GO
CREATE VIEW cReclutaPlaza
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Plaza,
  EstaPendiente,
  Sucursal,
  SucursalOrigen

FROM
  ReclutaPlaza
GO

-- drop table ReclutaCompetenciaTipo
/****** ReclutaCompetenciaTipo (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'ReclutaCompetenciaTipo')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ReclutaCompetenciaTipo','Movimiento','RE')
if not exists (select * from sysobjects where id = object_id('dbo.ReclutaCompetenciaTipo') and type = 'U') 
CREATE TABLE dbo.ReclutaCompetenciaTipo (
	ID 			int       	NOT NULL,
	Tipo			varchar(50)	NOT NULL,
	
	Peso			float		NULL,

	CONSTRAINT priReclutaCompetenciaTipo PRIMARY KEY CLUSTERED (ID, Tipo)
)
go
EXEC spModificarPK_Sucursal 'ReclutaCompetenciaTipo', '(ID, Tipo)'
GO
if exists (select * from sysobjects where id = object_id('dbo.cReclutaCompetenciaTipo') and sysstat & 0xf = 2) drop view dbo.cReclutaCompetenciaTipo
GO
CREATE VIEW cReclutaCompetenciaTipo
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Tipo,
  Peso,
  Sucursal,
  SucursalOrigen

FROM
  ReclutaCompetenciaTipo
GO

EXEC spDROP_TABLE 'ReclutaD', 3492
GO
/****** ReclutaD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'ReclutaD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ReclutaD','Movimiento','RE')
if not exists (select * from sysobjects where id = object_id('dbo.ReclutaD') and type = 'U') 
CREATE TABLE dbo.ReclutaD (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,
	Competencia		varchar(20)	NOT NULL,
	Resultado		varchar(100)	NULL,
	Valor			float		NULL,
	Peso			float		NULL,
	Observaciones		varchar(100)	NULL,

	CONSTRAINT priReclutaD PRIMARY KEY CLUSTERED (ID, Renglon, Competencia)
)
go

ALTER TABLE ReclutaD ALTER COLUMN Competencia varchar(20) NOT NULL
GO
EXEC spModificarPK_Sucursal 'ReclutaD', '(ID, Renglon, Competencia)'
GO
EXEC spALTER_TABLE 'ReclutaD', 'ValorMinimo', 'float NULL'
GO

DECLARE
   @pk varchar(256)
SELECT @pk = pk FROM SysPK WHERE Tabla = 'ReclutaD'
EXEC('ALTER TABLE ReclutaD DROP CONSTRAINT '+@pk)
ALTER TABLE ReclutaD ADD CONSTRAINT priReclutaD PRIMARY KEY CLUSTERED (ID, Renglon, Competencia)
GO

if exists (select * from sysobjects where id = object_id('dbo.cReclutaD') and sysstat & 0xf = 2) drop view dbo.cReclutaD
GO
CREATE VIEW cReclutaD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  Sucursal,
  SucursalOrigen,

  Competencia,
  Resultado,
  Valor,
  ValorMinimo,
  Peso,
  Observaciones

FROM
  ReclutaD
GO

EXEC spDROP_TABLE 'ReclutaDA', 3492
GO
/****** ReclutaDA (Valor Anterior) ******/
if not exists(select * from SysTabla where SysTabla = 'ReclutaDA')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ReclutaDA','Movimiento','RE')
if not exists (select * from sysobjects where id = object_id('dbo.ReclutaDA') and type = 'U') 
CREATE TABLE dbo.ReclutaDA (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

	Competencia		varchar(20)	NULL,
	
	Resultado		varchar(100)	NULL,
	Valor			float		NULL,
	ValorMinimo		float		NULL,

	Peso			float		NULL,
	Observaciones		varchar(100)	NULL,

	CONSTRAINT priReclutaDA PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'ReclutaDA', '(ID, Renglon)'
GO

-- exec spPuestoCompetenciaOk 'Administracion'
/**************** spPuestoCompetenciaOk ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPuestoCompetenciaOk') and type = 'P') drop procedure dbo.spPuestoCompetenciaOk
GO             
CREATE PROCEDURE spPuestoCompetenciaOk
				 @Puesto	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tipo	varchar(50),
    @Peso	float
    
  SELECT @Tipo = NULL
  SELECT TOP(1) @Tipo = a.Tipo, @Peso = SUM(pa.Peso) 
    FROM PuestoCompetencia pa
    JOIN Competencia a ON a.Competencia = pa.Competencia
   WHERE pa.Puesto = @Puesto
   GROUP BY a.Tipo
  HAVING SUM(pa.Peso) <> 100.0

  SELECT 'Tipo' = @Tipo
END
GO

-- spReclutaCompetenciaSugerir 7
-- select * from reclutad where id = 7
/**************** spReclutaCompetenciaSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReclutaCompetenciaSugerir') and type = 'P') drop procedure dbo.spReclutaCompetenciaSugerir
GO             
CREATE PROCEDURE spReclutaCompetenciaSugerir
				@ID		int				
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal		int,
    @Personal		varchar(10),
    @PersonalEstatus	varchar(15),
    @Puesto		varchar(50),
    @MovTipo		varchar(20)
 
  SELECT @Sucursal = e.Sucursal, @Personal = e.Personal, @Puesto = e.Puesto, 
         @MovTipo = mt.Clave 
    FROM Recluta e
    LEFT OUTER JOIN MovTipo mt ON mt.Modulo = 'RE' AND mt.Mov = e.Mov
   WHERE e.ID = @ID
   
  DELETE ReclutaD		WHERE ID = @ID
  DELETE ReclutaCompetenciaTipo	WHERE ID = @ID

  IF @MovTipo = 'RE.SCO'
    INSERT ReclutaCompetenciaTipo (
           ID,  Sucursal,  Tipo, Peso)
    SELECT @ID, @Sucursal, Tipo, Peso
      FROM PuestoCompetenciaTipo
     WHERE Puesto = @Puesto
    
  IF @MovTipo IN ('RE.SCO', 'RE.AP', 'RE.ECO', 'RE.CO', 'RE.RCO')
    INSERT ReclutaD (ID, Renglon, Sucursal, Competencia, Peso, ValorMinimo)
    SELECT @ID, ROW_NUMBER() OVER(ORDER BY Competencia)*2048.0, @Sucursal, Competencia, Peso, ValorMinimo
      FROM PuestoCompetencia
     WHERE Puesto = @Puesto
  IF @MovTipo IN ('RE.SEV', 'RE.EV')
    INSERT ReclutaD (ID, Renglon, Sucursal, Competencia, Peso, Resultado, Valor, ValorMinimo)
    SELECT @ID, ROW_NUMBER() OVER(ORDER BY Competencia)*2048.0, @Sucursal, Competencia, Peso, Resultado, Valor, ValorMinimo
      FROM PersonalCompetencia
     WHERE Personal = @Personal
END
GO


/**************** fnReclutaPlazasPendientes ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnReclutaPlazasPendientes') DROP FUNCTION fnReclutaPlazasPendientes
GO
CREATE FUNCTION fnReclutaPlazasPendientes (@ID int)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	int
  SELECT @Resultado = COUNT(*) FROM ReclutaPlaza WHERE ID = @ID AND EstaPendiente = 1
  RETURN(NULLIF(@Resultado, 0))
END
GO


/**************** fnReclutaCalifica ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnReclutaCalifica') DROP FUNCTION fnReclutaCalifica
GO
CREATE FUNCTION fnReclutaCalifica (@ID int)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit
    
  SELECT @Resultado = 1
  IF EXISTS(SELECT * FROM ReclutaD WHERE ID = @ID AND ISNULL(Valor, 0) < ISNULL(ValorMinimo, 0) AND ValorMinimo IS NOT NULL)
    SELECT @Resultado = 0
  RETURN(@Resultado)
END
GO

/**************** fnReclutaCalificacion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnReclutaCalificacion') DROP FUNCTION fnReclutaCalificacion
GO
CREATE FUNCTION fnReclutaCalificacion (@ID int)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	float,
    @Puesto	varchar(50)
  SELECT @Puesto = Puesto FROM Recluta WHERE ID = @ID
  
  SELECT @Resultado = SUM(d.Valor*(d.Peso/100.0)*(t.Peso/100.0)) 
    FROM ReclutaD d
    JOIN Recluta e ON e.ID = d.ID
    JOIN Competencia c ON c.Competencia = d.Competencia
    JOIN ReclutaCompetenciaTipo t ON t.ID = e.IDOrigen AND t.Tipo = c.Tipo
   WHERE d.ID = @ID
  RETURN(@Resultado)
END
GO
