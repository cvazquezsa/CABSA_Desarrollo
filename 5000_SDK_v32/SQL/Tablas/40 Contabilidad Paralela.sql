/*******************************************************************************************/
/*                                 CONTABILIDAD MULTIPLE                               	   */
/*******************************************************************************************/

/****** ContParalelaEmpresa ******/
if not exists(select * from SysTabla where SysTabla = 'ContParalelaEmpresa')
INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('ContParalelaEmpresa','Maestro', 'CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaEmpresa') and type = 'U') 
CREATE TABLE dbo.ContParalelaEmpresa(
  ID				int			IDENTITY,
  Empresa			varchar(5)	NOT NULL,
  BaseDatosRemota	varchar(255)NOT NULL,
  EmpresaRemota		varchar(255)NOT NULL,
  CONSTRAINT priContParalelaEmpresa PRIMARY KEY CLUSTERED(ID)
)
GO

EXEC spALTER_TABLE 'ContParalelaEmpresa', 'TieneMovimientos', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

/****** Consecutivos ******/
if not exists (select * from SysTabla where SysTabla = 'ContParalelaC') 
INSERT INTO SysTabla (SysTabla, Tipo, Modulo) VALUES ('ContParalelaC', 'Movimiento', 'CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ContParalelaC (
    ID				int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		    char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 	int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priContParalelaC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ContParalelaC'
END
GO

/****** ContParalela (Ficha) ******/
if not exists (select * from SysTabla where SysTabla = 'ContParalela') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalela','Movimiento','CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalela') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ContParalela (
	ID 					int         	NOT NULL IDENTITY(1,1),

	Empresa				char(5)	        NOT NULL,
	Mov  				char(20)        NOT NULL,
	MovID				varchar(20)    	NULL,	 
	FechaEmision 		datetime    	NULL,	 
	UltimoCambio 		datetime    	NULL,
	Concepto			varchar(50)		NULL,
	Proyecto  			varchar(50)   	NULL,
	UEN					int				NULL,
	Moneda 				char(10)   		NULL,
	TipoCambio			float			NULL,
	Usuario 			char(10)   		NULL,
	Autorizacion		char(10)		NULL,
	Referencia 			varchar(50) 	NULL,
	DocFuente			int				NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 			char(15)   		NULL,
	Situacion			varchar(50)		NULL,
	SituacionFecha		datetime		NULL,
	SituacionUsuario	varchar(10)		NULL,
	SituacionNota		varchar(100)	NULL,

	OrigenTipo			varchar(10)		NULL,
	Origen				varchar(20)		NULL,
	OrigenID			varchar(20)		NULL,
    BaseDatosOrigen		varchar(255)	NULL,
    EmpresaOrigen		varchar(5)		NULL,

	Poliza				varchar(20)		NULL,
	PolizaID			varchar(20)		NULL,
	GenerarPoliza		bit	    		NOT NULL DEFAULT 0,
	ContID				int				NULL,

	Ejercicio			int				NULL,
	Periodo				int				NULL,
	FechaRegistro		datetime		NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	Sucursal			int				NOT NULL DEFAULT 0,
	SucursalOrigen		int				NULL,
	SucursalDestino		int				NULL,
			
	CuentaD				varchar(20)		NULL,
	CuentaA				varchar(20)		NULL,
	Nivel				varchar(10)		NULL,

	CONSTRAINT priContParalela PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ContParalela'
END
go
EXEC spSincroNivelRegistro @Tabla = 'ContParalela'
GO

EXEC spALTER_TABLE 'ContParalela', 'Nivel', 'varchar(10) NULL'

EXEC spALTER_TABLE 'ContParalela', 'BaseDatosOrigen', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ContParalela', 'EmpresaOrigen', 'varchar(5) NULL'
EXEC spALTER_TABLE 'ContParalela', 'IDEmpresa', 'int NULL'
GO

EXEC spALTER_TABLE 'ContParalela', 'GeneraEjercicio', 'int NULL'
EXEC spALTER_TABLE 'ContParalela', 'GeneraPeriodo', 'int NULL'
EXEC spALTER_TABLE 'ContParalela', 'GeneraFechaD', 'datetime NULL'
EXEC spALTER_TABLE 'ContParalela', 'GeneraFechaA', 'datetime NULL'
EXEC spALTER_TABLE 'ContParalela', 'GeneraEmpresaOrigen', 'int NULL'

EXEC spALTER_TABLE 'ContParalela', 'GeneraMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ContParalela', 'GeneraMovID', 'varchar(20) NULL'

EXEC spALTER_TABLE 'ContParalela', 'GeneraContMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ContParalela', 'GeneraContMovID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ContParalela', 'GeneraContID', 'int NULL'

EXEC spALTER_TABLE 'ContParalela', 'IDAux', 'int NULL'
GO

EXEC spDROP_INDEX 'ContParalela', 'Abrir2'
EXEC spDROP_COLUMN 'ContParalela', 'Moneda'
EXEC spDROP_COLUMN 'ContParalela', 'TipoCambio'
GO
EXEC spALTER_TABLE 'ContParalela', 'CONTEsCancelacion', 'bit NULL'
GO

-- ContParalela
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia   ON dbo.ContParalela (Referencia)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.ContParalela (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.ContParalela (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.ContParalela (Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.ContParalela (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.ContParalela (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.ContParalela (ContID)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX ContParalela.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX ContParalela.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX ContParalela.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX ContParalela.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX ContParalela.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON ContParalela (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON ContParalela (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalela' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON ContParalela (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgContParalelaA') and sysstat & 0xf = 8) drop trigger dbo.tgContParalelaA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgContParalelaC') and sysstat & 0xf = 8) drop trigger dbo.tgContParalelaC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgContParalelaB') and sysstat & 0xf = 8) drop trigger dbo.tgContParalelaB
GO
EXEC spSincroNivelRegistroCampos 'ContParalela'
GO

-- Aqui va el Matenimiento a la tabla

EXEC spALTER_TABLE 'ContParalela', 'UEN', 'int NULL'
GO
CREATE TRIGGER tgContParalelaC ON ContParalela
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 			char(5),
    @Mov				char(20),
    @Sucursal			int,
    @ID					int,
    @FechaInicio		datetime,
    @Ahora 				datetime,
    @FechaAnterior		datetime,
    @EstatusNuevo 		char(15),
    @EstatusAnterior 	char(15),
    @SituacionNueva 	varchar(50),
    @SituacionAnterior 	varchar(50),
    @Usuario			char(10),
    @Mensaje			char(255),
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10),
    @MovTipo			varchar(20),
    @Empresa			varchar(5),
    @CONTPEnLinea		bit

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID
  
  SELECT @Modulo = 'CONTP'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '') FROM Deleted
  SELECT @Empresa = Empresa, @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @Usuario = Usuario FROM Inserted
  
  SELECT @CONTPEnLinea = ISNULL(CONTPEnLinea, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa
  
  SELECT @MovTipo = Clave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo
  
  IF ((@MovTipo IS NULL) OR (@CONTPEnLinea = 0 AND @MovTipo IN('CONTP.RECIBIRPAQUETE')) OR(@CONTPEnLinea = 1 AND @MovTipo IN('CONTP.RECIBIRPAQUETE', 'CONTP.PAQUETE', 'CONTP.TRANSFORMACION', 'CONTP.POLIZA')))
    RETURN
        
  IF dbo.fnEstaSincronizando() = 1 RETURN
    
  IF @EstatusNuevo <> @EstatusAnterior AND 
     ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('CONFIRMAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
      (@EstatusNuevo = 'CONFIRMAR'  AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO', 'CANCELADO')) OR
      (@EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
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
    UPDATE ContParalela SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO

CREATE TRIGGER tgContParalelaB ON ContParalela
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
    EXEC spMovAlEliminar 'ContParalela', @ID
END
GO

---- MovImpuesto
---- DROP TABLE ContParalelaD
--EXEC spDROP_TABLE 'ContParalelaD', 3089
--GO

/****** ContParalelaD (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'ContParalelaD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaD','Movimiento','CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaD') and type = 'U') 
CREATE TABLE dbo.ContParalelaD (
	ID					int				NOT NULL,
 	Renglon				float			NOT NULL,
	
	Cuenta				varchar(20)		NULL,
	Rama				varchar(20)		NULL, 
	Descripcion			varchar(100)	NULL, 
	Tipo				varchar(15)		NULL, 
	Categoria			varchar(50)		NULL, 
	Grupo				varchar(50)		NULL, 
	Familia				varchar(50)		NULL, 
	EsAcreedora			bit				NULL, 
	EsAcumulativa		bit				NULL, 
	CtaEstatus			varchar(50)		NULL, 
	
	ContID				int				NULL,
	ContMov				varchar(20)		NULL,
	ContMovID			varchar(20)		NULL,
	ContFechaEmision	datetime		NULL,
	ContOrigenTipo		varchar(5)		NULL,
	ContOrigen			varchar(20)		NULL,
	ContOrigenID		varchar(20)		NULL,
	
	PolizaEstatus		varchar(50)		NULL, 
	
	CONSTRAINT priContParalelaD PRIMARY KEY CLUSTERED (ID, Renglon)
)
GO

EXEC spALTER_TABLE 'ContParalelaD', 'CtaEstatus', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ContParalelaD', 'TieneMovimientos', 'bit NULL'
EXEC spALTER_TABLE 'ContParalelaD', 'Estatus', 'varchar(15) NULL'

EXEC spALTER_TABLE 'ContParalelaD', 'ContID', 'int NULL'
EXEC spALTER_TABLE 'ContParalelaD', 'ContMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ContParalelaD', 'ContMovID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ContParalelaD', 'PolizaEstatus', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'ContParalelaD', 'ContFechaEmision', 'datetime NULL'
EXEC spALTER_TABLE 'ContParalelaD', 'ContOrigenTipo', 'varchar(5) NULL'

EXEC spALTER_TABLE 'ContParalelaD', 'ContOrigen', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ContParalelaD', 'ContOrigenID', 'varchar(20) NULL'

EXEC spALTER_TABLE 'ContParalelaD', 'Debe', 'float NULL'
EXEC spALTER_TABLE 'ContParalelaD', 'Haber', 'float NULL'
GO


/****** ContParalelaXML (XML) ******/
if not exists (select * from SysTabla where SysTabla = 'ContParalelaXML') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaXML','Movimiento','CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaXML') and type = 'U') 
CREATE TABLE dbo.ContParalelaXML (
	ID					int				NOT NULL,
 	XML					varchar(max)	NULL,
 	Resultado			varchar(max)	NULL,

	CONSTRAINT priContParalelaXML PRIMARY KEY CLUSTERED (ID)
)
GO

if exists (select * from sysobjects where id = object_id('dbo.cContParalelaD') and sysstat & 0xf = 2) drop view dbo.cContParalelaD
GO
CREATE VIEW cContParalelaD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Cuenta,
  Rama,
  Descripcion,
  Tipo,
  Categoria,
  Grupo,
  Familia,
  EsAcreedora,
  EsAcumulativa,
  TieneMovimientos,
  Estatus
FROM
  ContParalelaD
GO


/****** Cuentas Contables  ******/
if not exists(select * from SysTabla where SysTabla = 'ContParalelaCta')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaCta','Cuenta', 'CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaCta') and type = 'U') 
CREATE TABLE dbo.ContParalelaCta (
    ID					int				NOT NULL,
    Empresa				varchar(5) 		NOT NULL,
	Cuenta				varchar(20) 	NOT NULL,
	Rama				varchar(20)		NULL,

	Descripcion			varchar(100)    NULL,
	Tipo				varchar(15)		NULL,
	Categoria 			varchar(50) 	NULL,
	Familia 			varchar(50) 	NULL,
	Grupo	 			varchar(50)		NULL,
	EsAcreedora			bit				NOT NULL	DEFAULT 0,
	EsAcumulativa		bit				NOT NULL	DEFAULT 0,
	TieneMovimientos	bit				NOT NULL	DEFAULT 0,
	Estatus 			varchar(15) 	NOT NULL,	
	UltimoCambio 		datetime  		NULL,	
	Alta				datetime		NULL,
	CuentaAsignada		varchar(20)		NULL,
	
	
	CONSTRAINT priContParalelaCta PRIMARY KEY  CLUSTERED (ID, Empresa, Cuenta)
	)
go

EXEC spALTER_TABLE 'ContParalelaCta', 'CuentaAsignada', 'varchar(20) NULL'

EXEC spALTER_TABLE 'ContParalelaCta', 'TransformarNegativo', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalelaCta' AND sysindexes.name = 'Rama' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Rama ON dbo.ContParalelaCta (Rama)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalelaCta' AND sysindexes.name = 'Descripcion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Descripcion ON dbo.ContParalelaCta (Descripcion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalelaCta' AND sysindexes.name = 'Categoria' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Categoria   ON dbo.ContParalelaCta (Categoria)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalelaCta' AND sysindexes.name = 'Tipo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Tipo        ON dbo.ContParalelaCta (Tipo)
go

if exists (select * from sysobjects where id = object_id('dbo.ContParalelaDCtaRegistrada') and sysstat & 0xf = 2) drop view dbo.ContParalelaDCtaRegistrada
GO
CREATE VIEW ContParalelaDCtaRegistrada
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  Cuenta,
  Rama,
  Descripcion,
  Tipo,
  Categoria,
  Grupo,
  Familia,
  EsAcreedora,
  EsAcumulativa,
  CtaEstatus,
  TieneMovimientos,
  Estatus
  
FROM
  ContParalelaD
WHERE (CtaEstatus = 'Registrada' OR Tipo IN('Estructura'))
GO

if exists (select * from sysobjects where id = object_id('dbo.ContParalelaDCtaActualizada') and sysstat & 0xf = 2) drop view dbo.ContParalelaDCtaActualizada
GO
CREATE VIEW ContParalelaDCtaActualizada
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  Cuenta,
  Rama,
  Descripcion,
  Tipo,
  Categoria,
  Grupo,
  Familia,
  EsAcreedora,
  EsAcumulativa,
  CtaEstatus,
  TieneMovimientos,
  Estatus
  
FROM
  ContParalelaD
WHERE (CtaEstatus = 'Actualizada' OR Tipo IN('Estructura'))
GO

if exists (select * from sysobjects where id = object_id('dbo.ContParalelaDPolizaNoRegistrada') and sysstat & 0xf = 2) drop view dbo.ContParalelaDPolizaNoRegistrada
GO
CREATE VIEW ContParalelaDPolizaNoRegistrada
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  ContID,
  ContMov,
  ContMovID,
  PolizaEstatus,
  ContFechaEmision,
  ContOrigenTipo,
  ContOrigen,
  ContOrigenID  

FROM
  ContParalelaD
WHERE (PolizaEstatus = 'No Registrada')
GO

if exists (select * from sysobjects where id = object_id('dbo.ContParalelaDPolizaRegistrada') and sysstat & 0xf = 2) drop view dbo.ContParalelaDPolizaRegistrada
GO
CREATE VIEW ContParalelaDPolizaRegistrada
--//WITH ENCRYPTION
AS
SELECT
  ID,
  ContID,
  ContMov,
  ContMovID,
  PolizaEstatus,
  ContFechaEmision,
  ContOrigenTipo,
  ContOrigen,
  ContOrigenID  

FROM
  ContParalelaD
WHERE (PolizaEstatus = 'Registrada')
GO

if exists (select * from sysobjects where id = object_id('dbo.ContParalelaDPolizaTransformada') and sysstat & 0xf = 2) drop view dbo.ContParalelaDPolizaTransformada
GO
CREATE VIEW ContParalelaDPolizaTransformada
--//WITH ENCRYPTION
AS
SELECT
  ID,
  ContID,
  ContMov,
  ContMovID,
  PolizaEstatus,
  ContFechaEmision,
  ContOrigenTipo,
  ContOrigen,
  ContOrigenID  

FROM
  ContParalelaD
WHERE (PolizaEstatus = 'Transformada')
GO


if exists (select * from sysobjects where id = object_id('dbo.ContParalelaDPoliza') and sysstat & 0xf = 2) drop view dbo.ContParalelaDPoliza
GO
CREATE VIEW ContParalelaDPoliza
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  Cuenta,
  Debe,
  Haber
  
FROM
  ContParalelaD
GO

/****** ContParalelaMovDato ******/
if not exists (select * from SysTabla where SysTabla = 'ContParalelaMovDato') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaMovDato','Movimiento','CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaMovDato') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ContParalelaMovDato (
	ID 					int         	NOT NULL IDENTITY(1,1),
	
	Modulo				varchar(5)		NOT NULL,
	ModuloID			int				NOT NULL,			

    Fecha				datetime		NULL,
	Moneda 				char(10)   		NULL,
	TipoCambio			float			NULL,

	CONSTRAINT priContParalelaMovDato PRIMARY KEY CLUSTERED (Modulo, ModuloID)
  )
END
GO


/****** ContParalelaTransforma ******/
if exists (select * from sysobjects where id = object_id('dbo.ContParalelaTransforma') and type = 'U') drop table ContParalelaTransforma 
GO
--if not exists(select * from SysTabla where SysTabla = 'ContParalelaTransforma') 
--INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaTransforma','Maestro','CONTP')
--if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaTransforma') and type = 'U') 
--BEGIN
--  CREATE TABLE dbo.ContParalelaTransforma (
--	ID					int				NOT NULL IDENTITY(1,1),

--	Empresa					varchar(7)		NULL	DEFAULT '(Todas)',
--	Modulo					varchar(5)		NULL,
--	MovTipo       			varchar(20)		NULL,
--	ContMov					varchar(255)	NULL,
--	ContConcepto			varchar(255)	NULL,
--	ContReferencia			varchar(255)	NULL,
--	ContProyecto			varchar(255)	NULL,
--	ContObservaciones		varchar(255) 	NULL,
--	ContUEN					varchar(255) 	NULL,
--	ContContacto			varchar(255) 	NULL,
--	ContContactoTipo		varchar(255) 	NULL,
--	Moneda					varchar(255)	NULL,
--	TipoCambio				varchar(255) 	NULL,
--	Comentarios				varchar(100)	NULL,
--	Estatus					char(15)		NULL,

--	CONSTRAINT priContParalelaTransforma PRIMARY KEY CLUSTERED (ID)
--  )
--  EXEC spSincroSemilla 'ContParalelaTransforma'
--END
--GO

--if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContParalelaTransforma' AND sysindexes.name = 'Mov' AND sysobjects.id = sysindexes.id)
--  CREATE INDEX Mov ON dbo.ContParalelaTransforma (MovTipo, Modulo, Empresa)
--GO

/****** ContParalelaTransformaD ******/
if exists (select * from sysobjects where id = object_id('dbo.ContParalelaTransformaD') and type = 'U') drop table ContParalelaTransformaD 
GO
--if not exists(select * from SysTabla where SysTabla = 'ContParalelaTransformaD') 
--INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaTransformaD','Maestro','CONTP')
--if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaTransformaD') and type = 'U') 
--CREATE TABLE dbo.ContParalelaTransformaD (
--	ID				int				NOT NULL,
--	Renglon			float			NOT NULL,
	
--	Cuenta			varchar(255)	NULL,
--	Concepto		varchar(255)	NULL,
	
--	Debe			varchar(255)	NULL,
--	Haber			varchar(255)	NULL,
	
--	Condicion		varchar(255)	NULL,
--	Comentarios		varchar(255)	NULL,
	
--	Orden			int				NULL,
--	CONSTRAINT priContParalelaTransformaD PRIMARY KEY CLUSTERED (ID, Renglon)
--)
--GO

/****** ContParalelaXMLPlantilla ******/
if not exists(select * from SysTabla where SysTabla = 'ContParalelaXMLPlantilla') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaXMLPlantilla','Maestro','CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaXMLPlantilla') and type = 'U') 
CREATE TABLE dbo.ContParalelaXMLPlantilla (
    ID				int				IDENTITY,
	Modulo			varchar(5)		NOT NULL,
	Consulta		varchar(max)	NULL,
	
	CONSTRAINT priContParalelaXMLPlantilla PRIMARY KEY CLUSTERED (ID)
)
GO

/****** ContParalelaPoliza ******/
if not exists(select * from SysTabla where SysTabla = 'ContParalelaPoliza') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaPoliza','Maestro','CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaPoliza') and type = 'U') 
CREATE TABLE dbo.ContParalelaPoliza (
    RID					int			IDENTITY,
	IDEmpresa			int,
    ID					int, 
    Empresa				varchar(5), 
    Mov					varchar(20), 
    MovID				varchar(20), 
    FechaEmision		datetime, 
    FechaContable		datetime		NULL, 
    Concepto			varchar(50)		NULL, 
    Proyecto			varchar(50)		NULL, 
    UEN					int				NULL,
    Contacto			varchar(10)		NULL, 
    ContactoTipo		varchar(20)		NULL, 
    Moneda				varchar(10), 
    TipoCambio			float, 
    Usuario				varchar(10), 
    Referencia			varchar(10)		NULL, 
    Estatus				varchar(15), 
    OrigenTipo			varchar(5)		NULL, 
    Origen				varchar(20)		NULL, 
    OrigenID			varchar(20)		NULL, 
    Ejercicio			int, 
    Periodo				int, 
    Sucursal			int, 
    Importe				float			NULL,
    RecepcionFecha		datetime		NULL,
    RecepcionMoneda		varchar(10)		NULL, 
    RecepcionTipoCambio	float			NULL,
    OrigenMoneda		varchar(10)		NULL, 
    OrigenTipoCambio	float			NULL,

	CONSTRAINT priContParalelaPoliza PRIMARY KEY CLUSTERED (RID)
)
GO

EXEC spALTER_TABLE 'ContParalelaPoliza', 'CPPolizaID', 'int NULL'

--REQ25300
EXEC spALTER_TABLE 'ContParalelaPoliza', 'CONTEsCancelacion', 'bit NULL'
GO

/****** ContParalelaPolizaD ******/
if not exists(select * from SysTabla where SysTabla = 'ContParalelaPolizaD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaPolizaD','Maestro','CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaPolizaD') and type = 'U') 
CREATE TABLE dbo.ContParalelaPolizaD (
    RID				int			IDENTITY,
	IDEmpresa		int,
    ID				int, 
    Renglon			float, 
    RenglonSub		int, 
    Cuenta			varchar(20), 
    Debe			float		NULL, 
    Haber			float		NULL,

	CONSTRAINT priContParalelaPolizaD PRIMARY KEY CLUSTERED (RID)
)
GO

--REQ25300
EXEC spALTER_TABLE 'ContParalelaPolizaD', 'CONTEsCancelacion', 'bit NULL'
GO    

/****** ContParalelaPolizaOrigen ******/
if not exists(select * from SysTabla where SysTabla = 'ContParalelaPolizaOrigen') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaPolizaOrigen','Maestro','CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaPolizaOrigen') and type = 'U') 
CREATE TABLE dbo.ContParalelaPolizaOrigen (
    RID				int			IDENTITY,
	IDEmpresa		int			NULL,
    ID				int			NULL, 
    IDOrigen		int			NULL, 
    Mov				varchar(20)	NULL, 
    MovID			varchar(20)	NULL, 
    FechaEmision	datetime	NULL, 
    Concepto		varchar(50)	NULL,
    Proyecto		varchar(50)	NULL, 
    UEN				int			NULL,
    Moneda			varchar(10)	NULL, 
    TipoCambio		float		NULL, 
    Usuario			varchar(10)	NULL, 
    Referencia		varchar(10)	NULL, 
    Estatus			varchar(15)	NULL, 
    ContactoTipo	varchar(20)	NULL,
    Contacto		varchar(10)	NULL, 
    Almacen			varchar(10)	NULL, 
    Condicion		varchar(50)	NULL, 
    Vencimiento		datetime	NULL, 
    Importe			float		NULL, 
    Impuestos		float		NULL, 
    Ejercicio		int			NULL, 
    Periodo			int			NULL,
	MovTipo			varchar(20) NULL,
	SubMovTipo		varchar(20) NULL,
	Modulo			varchar(5)	NULL,

	CONSTRAINT priContParalelaPolizaOrigen PRIMARY KEY CLUSTERED (RID)
)
GO    

EXEC spALTER_TABLE 'ContParalelaPolizaOrigen', 'MovTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ContParalelaPolizaOrigen', 'SubMovTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ContParalelaPolizaOrigen', 'Modulo', 'varchar(5) NULL'
GO

/****** ContParalelaPolizaContacto ******/
if not exists(select * from SysTabla where SysTabla = 'ContParalelaPolizaContacto') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaPolizaContacto','Maestro','CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaPolizaContacto') and type = 'U') 
CREATE TABLE dbo.ContParalelaPolizaContacto (
    RID					int			IDENTITY,
	IDEmpresa			int,
	ContactoTipo		varchar(20)		NULL,
	Contacto			varchar(20)		NULL,
	Nombre				varchar(100)	NULL,
	Direccion			varchar(100)	NULL,
	DireccionNumero		varchar(20)		NULL,
	DireccionNumeroInt	varchar(20)		NULL,
	EntreCalles			varchar(100)	NULL, 
	Delegacion			varchar(100)	NULL, 
	Colonia				varchar(100)	NULL, 
	Poblacion			varchar(100)	NULL, 
	Estado				varchar(30)		NULL, 
	Pais				varchar(30)		NULL, 
	CodigoPostal		varchar(15)		NULL, 
	RFC					varchar(15)		NULL, 
	CURP				varchar(30)		NULL, 
	Categoria			varchar(50)		NULL, 
	Grupo				varchar(50)		NULL, 
	Familia				varchar(50)		NULL
)
GO

/****** ContParalelaPeriodoCierre ******/
if not exists(select * from SysTabla where SysTabla = 'ContParalelaPeriodoCierre') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaPeriodoCierre','Maestro','CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaPeriodoCierre') and type = 'U') 
CREATE TABLE dbo.ContParalelaPeriodoCierre (
    RID					int			IDENTITY,
	IDEmpresa			int,
	Ejercicio			int,
	Periodo				int,
	CONSTRAINT	priContParalelaPeriodoCierre PRIMARY KEY CLUSTERED(RID)
)
GO

/****** ContParalelaMovPoliza ******/
if not exists(select * from SysTabla where SysTabla = 'ContParalelaMovPoliza') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContParalelaMovPoliza','Maestro','CONTP')
if not exists (select * from sysobjects where id = object_id('dbo.ContParalelaMovPoliza') and type = 'U') 
CREATE TABLE dbo.ContParalelaMovPoliza (
    RID					int			IDENTITY,
	IDEmpresa			int,
	MovOrigen			varchar(20),
	Mov					varchar(20),
	CONSTRAINT	priContParalelaMovPoliza PRIMARY KEY CLUSTERED(IDEmpresa, MovOrigen)
)
GO