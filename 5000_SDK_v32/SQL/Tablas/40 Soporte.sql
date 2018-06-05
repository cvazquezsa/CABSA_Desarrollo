
/*******************************************************************************************/
/*                                         SOPORTE                             	           */
/*******************************************************************************************/

/****** Consecutivos Soporte ******/
if not exists(select * from SysTabla where SysTabla = 'SoporteC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SoporteC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SoporteC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SoporteC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priSoporteC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'SoporteC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'SoporteC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE SoporteC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE SoporteC ALTER COLUMN Mov     char(20) NULL")
END
GO

/****** Soporte (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'Soporte')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Soporte','Movimiento','ST')
if not exists (select * from sysobjects where id = object_id('dbo.Soporte') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Soporte (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov  			char(20)        NOT NULL,
	MovID			varchar(20)    	NULL,	 
	FechaEmision 		datetime    	NULL,	 
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	UEN			int		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Cliente			char(10)	NULL,
	EnviarA			int	   	NULL,
	Proveedor		char(10)	NULL,
	Personal		char(10)	NULL,
	Agente  		char(10)   	NULL,
	Estado			varchar(30)	NULL,
	Contacto		varchar(50)	NULL,
	Telefono		varchar(30)	NULL,
	Extencion 		varchar(10) 	NULL,
	Fax			varchar(30)	NULL,
	eMail			varchar(30)	NULL,
	UsuarioResponsable	char(10)   	NOT NULL,
	FechaInicio		datetime	NULL,
	Vencimiento		datetime	NULL,
	TieneContrato		bit		NOT NULL DEFAULT 0,
	PuedeDevolver		bit		NOT NULL DEFAULT 0,
	Prioridad		char(10)	NULL	 DEFAULT 'Normal',	-- Normal, Alta, Baja
     	Clase			varchar(50)	NULL,  
    	Subclase		varchar(50)	NULL,  

	Titulo			varchar(100)	NULL,
	Problema		text		NULL,
	Solucion		text		NULL,
	Comentarios		text		NULL,
	TiempoTrabajado		varchar(20)	NULL, 

	Importe			money		NULL,
	CondicionPago		varchar(50)	NULL,
	CondicionEntrega    	varchar(50)	NULL,

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
	Version			float		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	Tiempo			float		NULL,
	TiempoUnidad		varchar(50)	NULL,
	ReferenciaInicial	varchar(50)	NULL,
	Destino			varchar(50)	NULL,
	SubModulo		char(5)		NULL	DEFAULT 'ST',
	Espacio			char(10)	NULL,

	FechaTermino		datetime	NULL,
	ProyectoFolio		int		NULL,

	Fuente			varchar(10)	NULL,
	Medio			varchar(50)	NULL,
	Elemento		varchar(50)	NULL,

	VIN			varchar(20)	NULL,
	ServicioTipo		varchar(50)	NULL,
	FechaRequerida		datetime	NULL,
	FechaRevision		datetime	NULL,
	FechaAprobacion		datetime	NULL,
	FechaInicioEst		datetime	NULL,
	FechaFinEst		datetime	NULL,

	Direccion 		varchar(100) 	NULL,
	DireccionNumero		varchar(20)	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Delegacion		varchar(100) 	NULL,
	Colonia 		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	PaisEstado 		varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	Zona 			varchar(30) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Orden			int		NULL,
	Calificacion		float		NULL,
	Reporte			varchar(20)	NULL,
	LineaCredito		varchar(20)	NULL,
	Articulo		varchar(20)	NULL,
	SerieLote		varchar(50)	NULL,

        Causa                   varchar(100)    NULL,
        Clase1                  varchar(50)     NULL,
        Clase2                  varchar(50)     NULL,
        Clase3                  varchar(50)     NULL,
        Clase4                  varchar(50)     NULL,
        Clase5                  varchar(50)     NULL,

	Avance			float		NULL,

	CONSTRAINT priSoporte PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Soporte'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Soporte'
go

if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Soporte.Consecutivo
  ALTER TABLE Soporte ALTER COLUMN MovID varchar(20)
  ALTER TABLE Soporte ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Soporte ALTER COLUMN PolizaID varchar(20)
END
GO



if exists (select * from sysobjects where id = object_id('dbo.tgSoporteA') and sysstat & 0xf = 8) drop trigger dbo.tgSoporteA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSoporteC') and sysstat & 0xf = 8) drop trigger dbo.tgSoporteC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSoporteB') and sysstat & 0xf = 8) drop trigger dbo.tgSoporteB
GO
EXEC spModificarPK_Mov 'Soporte'
GO
EXEC spSincroNivelRegistroCampos 'Soporte'
GO
-- Aqui va el Matenimiento a la tabla
EXEC spALTER_TABLE 'Soporte', 'Proveedor', 'char(10) NULL'
EXEC spALTER_TABLE 'Soporte', 'Personal', 'char(10) NULL'
EXEC spALTER_TABLE 'Soporte', 'Tiempo', 'float NULL'
EXEC spALTER_TABLE 'Soporte', 'TiempoUnidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'ReferenciaInicial', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Soporte', 'Destino', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'SubModulo', 'char(5) NULL DEFAULT "ST"'
EXEC spALTER_TABLE 'Soporte', 'FechaTermino', 'datetime	NULL'
EXEC spALTER_TABLE 'Soporte', 'ProyectoFolio', 'int NULL'

GO
EXEC spRENAME_COLUMN 'Soporte', 'Autobus', 'Espacio'
GO
EXEC spALTER_TABLE 'Soporte', 'Espacio', 'char(10) NULL'
EXEC spALTER_TABLE 'Soporte', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Soporte', 'Fuente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Soporte', 'Medio', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'Elemento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'VIN', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Soporte', 'ServicioTipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'FechaRequerida', 'datetime NULL'
EXEC spALTER_TABLE 'Soporte', 'FechaRevision', 'datetime NULL'
EXEC spALTER_TABLE 'Soporte', 'FechaAprobacion', 'datetime NULL'
EXEC spALTER_TABLE 'Soporte', 'FechaInicioEst', 'datetime NULL'
EXEC spALTER_TABLE 'Soporte', 'FechaFinEst', 'datetime	NULL'

EXEC spALTER_TABLE 'Soporte', 'Direccion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Soporte', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Soporte', 'EntreCalles', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Soporte', 'Plano', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Soporte', 'Delegacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Soporte', 'Colonia', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Soporte', 'CodigoPostal', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Soporte', 'Poblacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Soporte', 'PaisEstado', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Soporte', 'Pais', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Soporte', 'Zona', 'varchar(30) NULL'
GO
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE Soporte ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE Soporte ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE Soporte ALTER COLUMN Poblacion varchar(100) NULL")
END
GO
EXEC spALTER_TABLE 'Soporte', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'Soporte', 'Calificacion', 'float NULL'
EXEC spALTER_TABLE 'Soporte', 'Reporte', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Soporte', 'LineaCredito', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Soporte', 'Articulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Soporte', 'SerieLote', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Soporte', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Soporte', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_COLUMN 'Soporte', 'SerieLote', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'Tipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'Causa', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Soporte', 'Clase1', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'Clase2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'Clase3', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'Clase4', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'Clase5', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Soporte', 'Avance', 'float NULL'
GO

EXEC spFK 'Soporte','UEN','UEN','UEN'
EXEC spFK 'Soporte','Proyecto','Proy','Proyecto'
EXEC spFK 'Soporte','VIN','VIN','VIN'
EXEC spFK 'Soporte','Reporte','Rep','Reporte'
EXEC spFK 'Soporte','LineaCredito','LC','LineaCredito'
EXEC spFK 'Soporte','Articulo','Art','Articulo'
GO

-- Soporte
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Cliente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cliente 	    ON dbo.Soporte (Cliente)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Proveedor' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Proveedor    ON dbo.Soporte (Proveedor)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Personal' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Personal     ON dbo.Soporte (Personal)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Agente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Agente 	    ON dbo.Soporte (Agente)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia   ON dbo.Soporte (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Clase' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Clase 	    ON dbo.Soporte (Clase, Empresa)

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Soporte (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Soporte (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Soporte (Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Soporte (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Soporte (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Soporte (ContID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Reporte' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Reporte 	     ON dbo.Soporte (Reporte)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'LineaCredito' AND sysobjects.id = sysindexes.id)
  CREATE INDEX LineaCredito  ON dbo.Soporte (LineaCredito)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Soporte.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Soporte.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Soporte.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Soporte.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Soporte.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Soporte (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Soporte (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Soporte' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Soporte (OrigenID,Origen,Empresa)
go


GO
CREATE TRIGGER tgSoporteC ON Soporte
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
  
  SELECT @Modulo = 'ST'
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
    UPDATE Soporte SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgSoporteB ON Soporte
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
    EXEC spMovAlEliminar 'ST', @ID
END
GO

/****** SoporteD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'SoporteD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('SoporteD','Movimiento','ST')
if not exists (select * from sysobjects where id = object_id('dbo.SoporteD') and type = 'U') 
CREATE TABLE dbo.SoporteD (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

	Aplica			char(20)	NULL,
	AplicaID		varchar(20)	NULL,

	CONSTRAINT priSoporteD PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'SoporteD', '(ID, Renglon)'
GO

if exists (select * from sysobjects where id = object_id('dbo.cSoporteD') and sysstat & 0xf = 2) drop view dbo.cSoporteD
GO
CREATE VIEW cSoporteD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Aplica,
  AplicaID,
  Sucursal,
  SucursalOrigen

FROM
  SoporteD
GO

/****** SoporteCambio ******/
if not exists(select * from SysTabla where SysTabla = 'SoporteCambio')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('SoporteCambio','Movimiento','ST')
if not exists (select * from sysobjects where id = object_id('dbo.SoporteCambio') and type = 'U') 
CREATE TABLE dbo.SoporteCambio (
	ID 				int       	NOT NULL,
	Numero				int         	NOT NULL,

	Tipo				varchar(50)	NULL,	-- Interno / Externo
	SubTipo				varchar(50)	NULL,	-- 
	Solicitante			char(10)	NULL,
	FechaSolicitud			datetime	NULL,
	Descripcion			varchar(255)	NULL,
	FechaRequerida			datetime	NULL,
	Usuario				char(10)	NULL,
	FechaAnalisisImpacto		datetime	NULL,
	AgenteAnalisisImpacto		char(10)	NULL,
	ResultadoAnalisisImpacto	varchar(20)	NULL,	-- Procede / No Procede	
	Tamano				varchar(20)	NULL,	-- Simple / Moderado / Complejo
	TiempoPreAnalisis		float		NULL,
	TiempoAnalisis			float		NULL,
	TiempoCanalizacion		float		NULL,
	TiempoDiseno			float		NULL,
	TiempoCodificacion		float		NULL,
	TiempoPruebas			float		NULL,
	TiempoCalidad			float		NULL,
	TiempoIntegracion		float		NULL,
	TiempoLiberacion		float		NULL,
	FechaEnvio			datetime	NULL,
	Vencimiento			datetime	NULL,
	FechaAceptacion			datetime	NULL,
	ClienteAceptacion		varchar(50)	NULL,
	FechaPromesaEntrega		datetime	NULL,
	FechaRealEntrega		datetime	NULL,
	ClienteAprobacion		varchar(50)	NULL,
	FechaAprobacion			datetime	NULL,

	CONSTRAINT priSoporteCambio PRIMARY KEY CLUSTERED (ID, Numero)
)
go
EXEC spModificarPK_Sucursal 'SoporteCambio', '(ID, Numero)'
GO

/****** SoporteEstado  ******/
if not exists(select * from SysTabla where SysTabla = 'SoporteEstado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SoporteEstado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SoporteEstado') and type = 'U') 
CREATE TABLE dbo.SoporteEstado (
	Orden		int	 	NOT NULL,
	Estado		varchar(30)	NOT NULL,
	NombrePlural	varchar(50)	NOT NULL,
	
	CONSTRAINT priSoporteEstado PRIMARY KEY CLUSTERED (Orden, Estado)
)
GO


/****** SoporteElemento  ******/
if not exists(select * from SysTabla where SysTabla = 'SoporteElemento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SoporteElemento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SoporteElemento') and type = 'U') 
CREATE TABLE dbo.SoporteElemento (
	Elemento	varchar(50)	NOT NULL,
	Orden		int	 	NULL,
	
	CONSTRAINT priSoporteElemento PRIMARY KEY CLUSTERED (Elemento)
)
GO

/****** SoporteMedio  ******/
if not exists(select * from SysTabla where SysTabla = 'SoporteMedio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SoporteMedio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SoporteMedio') and type = 'U') 
CREATE TABLE dbo.SoporteMedio (
	Medio		varchar(50)	NOT NULL,
	Orden		int	 	NULL,
	
	CONSTRAINT priSoporteMedio PRIMARY KEY CLUSTERED (Medio)
)
GO
