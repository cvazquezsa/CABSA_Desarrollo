

/*******************************************************************************************/
/*                                           EMBARQUES                                     */
/*******************************************************************************************/

/****** EmbarqueTarifa ******/
if not exists(select * from SysTabla where SysTabla = 'EmbarqueTarifa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmbarqueTarifa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueTarifa') and type = 'U') 
CREATE TABLE dbo.EmbarqueTarifa (
	Agrupador		varchar(20)	NOT NULL,  -- Categoria, Grupo, Familia, Fabricante, Linea
	Nombre			varchar(50) 	NOT NULL,  -- HP

	CostoVenta		money		NULL,
	CostoInv		money		NULL,
	CostoCompra		money		NULL,
	Moneda			char(10)	NULL,

	PorcentajeVenta		float		NULL,
	PorcentajeInv		float		NULL,
	PorcentajeCompra	float		NULL,

	CONSTRAINT priEmbarqueTarifa PRIMARY KEY CLUSTERED (Agrupador, Nombre)
)
GO
EXEC spALTER_TABLE 'EmbarqueTarifa', 'PorcentajeVenta','float NULL'
EXEC spALTER_TABLE 'EmbarqueTarifa', 'PorcentajeInv','float NULL'
EXEC spALTER_TABLE 'EmbarqueTarifa', 'PorcentajeCompra','float NULL'
GO

/****** Guias de Embarques ******/
if not exists (select * from SysTabla where SysTabla = 'GuiaEmbarque') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GuiaEmbarque','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.GuiaEmbarque') and type = 'U') 
CREATE TABLE dbo.GuiaEmbarque (
	Modulo			char(5)		NOT NULL,
	ID 			int         	NOT NULL,

	FechaEnvio		datetime    	NULL,
	Paquetes		int         	NULL,
	FormaEnvio 		varchar(50)   	NULL, 

	PersonaRecibio		varchar(50) 	NULL,
	FechaRecepcion		datetime    	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priGuiaEmbarque PRIMARY KEY CLUSTERED (Modulo, ID)
)
go
EXEC spModificarPK_SucursalSinOrigen 'GuiaEmbarque', '(Modulo, ID)'
GO

/****** GuiaEmbarqueD ******/
if not exists (select * from SysTabla where SysTabla = 'GuiaEmbarqueD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GuiaEmbarqueD','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.GuiaEmbarqueD') and type = 'U') 
CREATE TABLE dbo.GuiaEmbarqueD (
	Modulo			char(5)		NOT NULL,
	ID 			int         	NOT NULL,
	Guia			varchar(50)	NOT NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priGuiaEmbarqueD PRIMARY KEY CLUSTERED (Modulo, ID, Guia)
)
EXEC spModificarPK_SucursalSinOrigen 'GuiaEmbarqueD', '(Modulo, ID, Guia)'
GO

EXEC spFK2 'GuiaEmbarqueD','Modulo','ID','GuiaEmbarque','Modulo','ID'
GO

/****** Embarques ******/
if not exists (select * from SysTabla where SysTabla = 'EmbarqueC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('EmbarqueC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EmbarqueC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priEmbarqueC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'EmbarqueC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'EmbarqueC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE EmbarqueC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE EmbarqueC ALTER COLUMN Mov     char(20) NULL")
END
GO

/****** EmbarqueMov ******/
if not exists (select * from SysTabla where SysTabla = 'EmbarqueMov') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmbarqueMov','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueMov') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EmbarqueMov (
	ID			int         	NOT NULL IDENTITY(1,1),

	AsignadoID 		int             NULL,
	Concluido		bit		NULL	DEFAULT 0,

	Accion			varchar(50)	NULL,
	Zona			varchar(30)	NULL,
	Ruta			varchar(50)	NULL,
	ZonaTipo		varchar(50)	NULL,
	OrdenEmbarque		int		NULL,
	Empresa			char(5)	        NULL,
	Modulo			char(5)		NULL,
	ModuloID		int		NULL,
	Mov			char(20)	NULL,
	MovID			varchar(20)	NULL,
	FechaEmision		datetime	NULL,
	MovReferencia 		varchar(50) 	NULL,
	MovObservaciones 	varchar(100) 	NULL,
	MovEstatus		char(15)	NULL,
	Almacen			char(10)   	NULL,
	Cliente			char(10)	NULL,
	ClienteEnviarA		int	   	NULL,
	Proveedor		char(10)	NULL,
	AlmacenDestino		char(10)   	NULL,
	Peso			float		NULL,
	Volumen			float		NULL,
	Paquetes		int		NULL,
       	Importe                 money           NULL,
	Impuestos		money           NULL,
	Gastos			money		NULL,
	MovPorcentaje		float		NULL,
	Moneda  		char(10)   	NULL,
	TipoCambio		float		NULL,
	Condicion  		varchar(50)   	NULL,    
	Vencimiento		datetime    	NULL,
	UEN			int		NULL,

	Nombre			varchar(100) 	NULL,
	NombreEnvio		varchar(100) 	NULL,
	Direccion 		varchar(100) 	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Delegacion		varchar(100) 	NULL,
	Colonia 		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Telefonos		varchar(100) 	NULL,
	Contacto1 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
        Extencion1              varchar(10)     NULL,
        Extencion2              varchar(10)     NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	ObservacionesEmbarque	varchar(100)	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	
	DireccionNumero		varchar(20)	NULL,
	DireccionNumeroInt	varchar(20)	NULL,
	MapaLatitud		float		NULL,
	MapaLongitud		float		NULL,
	MapaPrecision		int		NULL,

	CONSTRAINT priEmbarqueMov PRIMARY KEY CLUSTERED (ID)
  )  
  EXEC spSincroSemilla 'EmbarqueMov'
END
GO
if (select version from version) <= 1095
  ALTER TABLE EmbarqueMov ALTER COLUMN MovID varchar(20)
GO
EXEC spModificarPK_SucursalSinOrigen 'EmbarqueMov', '(ID)'
GO

if not exists(select * from syscampo where tabla='EmbarqueMov' and campo='Gastos')
  ALTER TABLE EmbarqueMov ADD Gastos money NULL
go
if not exists(select * from syscampo where tabla='EmbarqueMov' and campo='Concluido')
BEGIN
  EXEC("ALTER TABLE EmbarqueMov ADD Concluido bit NULL DEFAULT 0")
  EXEC("UPDATE EmbarqueMov SET Concluido = 1")
END
GO
EXEC spALTER_TABLE 'EmbarqueMov', 'Delegacion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmbarqueMov', 'MovPorcentaje', 'float NULL'
EXEC spALTER_TABLE 'EmbarqueMov', 'ObservacionesEmbarque', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmbarqueMov', 'UEN', 'int NULL'
go
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE EmbarqueMov ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE EmbarqueMov ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE EmbarqueMov ALTER COLUMN Poblacion varchar(100) NULL")
END
GO
EXEC spALTER_TABLE 'EmbarqueMov', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmbarqueMov', 'DireccionNumeroInt', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmbarqueMov', 'MapaLatitud', 'float NULL'
EXEC spALTER_TABLE 'EmbarqueMov', 'MapaLongitud', 'float NULL'
EXEC spALTER_TABLE 'EmbarqueMov', 'MapaPrecision', 'int NULL'
EXEC spALTER_TABLE 'EmbarqueMov', 'Ubicacion',    'varchar(1000) NULL'
GO

EXEC spFK 'EmbarqueMov','Modulo','Modulo','Modulo'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EmbarqueMov' AND sysindexes.name = 'Asignado' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Asignado ON dbo.EmbarqueMov (AsignadoID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EmbarqueMov' AND sysindexes.name = 'Cliente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cliente ON dbo.EmbarqueMov (Cliente, ClienteEnviarA)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EmbarqueMov' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ModuloID ON dbo.EmbarqueMov (ModuloID, Modulo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EmbarqueMov' AND sysindexes.name = 'MovID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovID ON dbo.EmbarqueMov (MovID, Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EmbarqueMov' AND sysindexes.name = 'Ruta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Ruta ON dbo.EmbarqueMov (Ruta, Cliente)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EmbarqueMov' AND sysindexes.name = 'Zona' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Zona ON dbo.EmbarqueMov (Zona)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EmbarqueMov' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre ON dbo.EmbarqueMov (Nombre)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EmbarqueMov' AND sysindexes.name = 'NombreEnvio' AND sysobjects.id = sysindexes.id)
  CREATE INDEX NombreEnvio ON dbo.EmbarqueMov (NombreEnvio)
go


/*** Embarque ***/
if not exists (select * from SysTabla where SysTabla = 'Embarque') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Embarque','Movimiento','EMB')
if not exists (select * from sysobjects where id = object_id('dbo.Embarque') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Embarque (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov			char(20)        NOT NULL,        
	MovID			varchar(20)    	NULL,	     
	Moneda  		char(10)   	NULL,
	TipoCambio		float		NULL,
	FechaEmision 		datetime    	NULL,	     
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Concepto		varchar(50)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Vehiculo 		char(10)  	NULL,
	Ruta			varchar(50)	NULL,
	Agente 			char(10)  	NULL,
	Gastos 			money		NULL,
	Proveedor		char(10)	NULL,
	Importe			money		NULL,
	Impuestos		money		NULL,
	Condicion  		varchar(50)   	NULL,    
	Vencimiento		datetime    	NULL,
	CxpReferencia		varchar(50) 	NULL,
	PersonalCobrador	varchar(10)	NULL,

	Volumen			float		NULL,
	Peso			float		NULL,
	Paquetes		int		NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	CtaDinero		char(10)        NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		varchar(20)	NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,
	ContID			int		NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	FechaSalida		datetime	NULL,  
	FechaRetorno		datetime	NULL,  
	KmsSalida		float		NULL,
	KmsRetorno		float		NULL,
	TermoInicio		datetime	NULL,
	TermoFin		datetime	NULL,
	DiaRetorno		datetime	NULL,  

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
	ImporteEmbarque		money		NULL,

	CONSTRAINT priEmbarque PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Embarque'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Embarque'
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Embarque.Consecutivo
  ALTER TABLE Embarque ALTER COLUMN MovID varchar(20)
  ALTER TABLE Embarque ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Embarque ALTER COLUMN PolizaID varchar(20)
END
GO

-- Embarque
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Vehiculo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Vehiculo	    ON dbo.Embarque (Vehiculo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Ruta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Ruta	    ON dbo.Embarque (Ruta)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Agente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Agente	    ON dbo.Embarque (Agente)

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Embarque (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Embarque (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Embarque (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Embarque (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Embarque (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Embarque (ContID)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Embarque.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Embarque.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Embarque.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Embarque.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Embarque.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Embarque (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Embarque (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Embarque' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Embarque (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgEmbarqueA') and sysstat & 0xf = 8) drop trigger dbo.tgEmbarqueA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgEmbarqueC') and sysstat & 0xf = 8) drop trigger dbo.tgEmbarqueC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgEmbarqueB') and sysstat & 0xf = 8) drop trigger dbo.tgEmbarqueB
GO
EXEC spModificarPK_Mov 'Embarque'
GO
EXEC spSincroNivelRegistroCampos 'Embarque'
GO
EXEC spALTER_TABLE 'Embarque', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Embarque', 'PersonalCobrador', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Embarque', 'DiaRetorno', 'datetime NULL'
EXEC spALTER_TABLE 'Embarque', 'KmsSalida', 'float NULL'
EXEC spALTER_TABLE 'Embarque', 'KmsRetorno', 'float NULL'
EXEC spALTER_TABLE 'Embarque', 'TermoInicio', 'datetime	NULL'
EXEC spALTER_TABLE 'Embarque', 'TermoFin', 'datetime NULL'
EXEC spALTER_TABLE 'Embarque', 'ImporteEmbarque', 'money NULL'
EXEC spALTER_TABLE 'Embarque', 'SituacionUsuario', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Embarque', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Embarque', 'TempInicio', 'int NULL'
EXEC spALTER_TABLE 'Embarque', 'TempFin', 'int NULL'
GO
EXEC spALTER_TABLE 'Embarque', 'Agente2', 'char(10) NULL'
GO

EXEC spDROP_COLUMN 'Embarque', 'AlmacenD'
EXEC spDROP_COLUMN 'Embarque', 'AlmacenA'
GO

EXEC spFK 'Embarque','Moneda','Mon','Moneda'
EXEC spFK 'Embarque','UEN','UEN','UEN'
EXEC spFK 'Embarque','PersonalCobrador','Personal','Personal'
GO

-- Aqui va el Matenimiento a la tabla
GO
CREATE TRIGGER tgEmbarqueC ON Embarque
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
  
  SELECT @Modulo = 'EMB'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '') FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @Usuario = Usuario FROM Inserted
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
    UPDATE Embarque SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgEmbarqueB ON Embarque
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Empresa	char(5),
    @Estatus 	char(15),
    @Mensaje	char(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Estatus = Estatus, @Empresa = Empresa FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
  BEGIN
    UPDATE EmbarqueMov  SET AsignadoID = NULL WHERE AsignadoID = @ID 

    EXEC spMovAlEliminar 'EMB', @ID
    EXEC spGastoAnexoEliminar @Empresa, 'EMB', @ID
  END
END
GO

/****** EmbarqueD ******/
if not exists (select * from SysTabla where SysTabla = 'EmbarqueD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('EmbarqueD','Movimiento','EMB')
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueD') and type = 'U') 
CREATE TABLE dbo.EmbarqueD (
	ID 			int             NOT NULL,
	Orden			int		NOT NULL,

	EmbarqueMov		int		NULL,
	Paquetes		int		NULL,
	Estado			varchar(50)	NULL,
	FechaHora    		datetime    	NULL,
	Persona			varchar(50)   	NULL, 
	PersonaID		varchar(50)   	NULL, 

	Forma      		varchar(50)	NULL,
	Importe			money		NULL,

	Referencia 		varchar(50) 	NULL,
	Observaciones 		varchar(100) 	NULL,
	Causa			varchar(50)	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	MovPorcentaje		float		NULL,
	DesembarqueParcial	bit		NULL DEFAULT 0,

	CONSTRAINT priEmbarqueD PRIMARY KEY CLUSTERED (ID, Orden)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgEmbarqueDC') and sysstat & 0xf = 8) drop trigger dbo.tgEmbarqueDC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgEmbarqueDAC') and sysstat & 0xf = 8) drop trigger dbo.tgEmbarqueDAC
GO
EXEC spModificarPK_Sucursal 'EmbarqueD', '(ID, Orden)'
GO
if not exists(select * from syscampo where tabla = 'EmbarqueD' and Campo = 'Causa')
  ALTER TABLE EmbarqueD ADD Causa varchar(50) NULL
GO
EXEC spALTER_TABLE 'EmbarqueD', 'MovPorcentaje', 'float	NULL'
EXEC spALTER_TABLE 'EmbarqueD', 'DesembarqueParcial', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spFK 'EmbarqueD','EmbarqueMov','EmbarqueMov','ID'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EmbarqueD' AND sysindexes.name = 'EmbarqueMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX EmbarqueMov  ON dbo.EmbarqueD (EmbarqueMov)
GO

if exists (select * from sysobjects where id = object_id('dbo.cEmbarqueD') and sysstat & 0xf = 2) drop view dbo.cEmbarqueD
GO
CREATE VIEW cEmbarqueD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Orden,

  EmbarqueMov,
  Paquetes,
  Estado,
  FechaHora,
  Persona,
  PersonaID,

  Forma,
  Importe,

  Referencia,
  Observaciones,

  Sucursal,
  SucursalOrigen,

  Logico1,
  Logico2,
  Logico3,
  Logico4,
  Logico5

FROM
  EmbarqueD
GO

-- Aqui va el Matenimiento a la tabla
GO
CREATE TRIGGER tgEmbarqueDAC ON EmbarqueD
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(Paquetes) OR UPDATE(Observaciones)
    UPDATE EmbarqueMov 
       SET Paquetes = i.Paquetes, ObservacionesEmbarque = i.Observaciones
      FROM Inserted i, EmbarqueMov em
     WHERE i.EmbarqueMov = em.ID
END
GO


/****** EmbarqueDArt ******/
if not exists (select * from SysTabla where SysTabla = 'EmbarqueDArt') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('EmbarqueDArt','Movimiento','EMB')
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueDArt') and type = 'U') 
CREATE TABLE dbo.EmbarqueDArt (
	ID 			int             NOT NULL,
	EmbarqueMov		int		NOT NULL,
	Modulo			char(5)		NOT NULL,
	ModuloID		int		NOT NULL,
	Renglon			float		NOT NULL,
	RenglonSub		int		NOT NULL,

	ImporteTotal		money		NULL,
	CantidadTotal		float		NULL,

	Cantidad		float		NULL,	
	Tarima			varchar (20) NULL,--REQ12615 WMS

	CONSTRAINT priEmbarqueDArt PRIMARY KEY CLUSTERED (ID, EmbarqueMov, Modulo, ModuloID, Renglon, RenglonSub)
)
GO
EXEC spALTER_TABLE 'EmbarqueDArt', 'Tarima', 'varchar (20) NULL'--REQ12615 WMS
GO
EXEC spModificarPK_Sucursal 'EmbarqueDArt', '(ID, EmbarqueMov, Modulo, ModuloID, Renglon, RenglonSub)'
GO

EXEC spFK3 'EmbarqueDArt','ModuloID','Renglon','RenglonSub','VentaD','ID','Renglon','RenglonSub'
GO

/****** EmbarqueAsistenteCobro ******/
if not exists (select * from SysTabla where SysTabla = 'EmbarqueAsistenteCobro') 
INSERT INTO SysTabla (SysTabla) VALUES ('EmbarqueAsistenteCobro')
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueAsistenteCobro') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EmbarqueAsistenteCobro (
	ID 			int             NOT NULL,
	IDRenglon		int		NOT NULL IDENTITY(1,1),

	Mov			char(20)        NOT NULL,        
	MovID			varchar(20)    	NULL,	     
	FechaHora    		datetime    	NULL,
	Importe			money		NULL,
	Forma      		varchar(50)	NULL,
	Estado			varchar(50)	NULL		DEFAULT 'Cobrado',
	Causa			varchar(50)	NULL,
	Persona			varchar(50)   	NULL, 
	PersonaID		varchar(50)   	NULL, 
	Referencia 		varchar(50) 	NULL,

	CONSTRAINT priEmbarqueAsistenteCobro PRIMARY KEY CLUSTERED (ID, IDRenglon)
  )
  EXEC spSincroSemilla 'EmbarqueAsistenteCobro'
END
GO
EXEC spALTER_TABLE 'EmbarqueAsistenteCobro', 'FechaHora', 'datetime NULL'
EXEC spALTER_TABLE 'EmbarqueAsistenteCobro', 'Estado', 'varchar(50) NULL DEFAULT "Cobrado" WITH VALUES'
EXEC spALTER_TABLE 'EmbarqueAsistenteCobro', 'Causa', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmbarqueAsistenteCobro', 'Persona', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmbarqueAsistenteCobro', 'PersonaID', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmbarqueAsistenteCobro', 'Referencia', 'varchar(50) NULL'
GO

/****** EmbarqueAsistenteGeneral ******/
if not exists (select * from SysTabla where SysTabla = 'EmbarqueAsistenteGeneral') 
INSERT INTO SysTabla (SysTabla) VALUES ('EmbarqueAsistenteGeneral')
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueAsistenteGeneral') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EmbarqueAsistenteGeneral (
	Empresa			char(5)		NOT NULL,
	Estacion		int		NOT NULL,
	IDRenglon		int		NOT NULL IDENTITY(1,1),

	Mov			char(20)        NOT NULL,        
	MovID			varchar(20)    	NULL,	     
	FechaHora    		datetime    	NULL,
	Importe			money		NULL,
	Forma      		varchar(50)	NULL,
	Estado			varchar(50)	NULL		DEFAULT 'Cobrado',
	Causa			varchar(50)	NULL,
	Persona			varchar(50)   	NULL, 
	PersonaID		varchar(50)   	NULL, 
	Referencia 		varchar(50) 	NULL,

	CONSTRAINT priEmbarqueAsistenteGeneral PRIMARY KEY CLUSTERED (Empresa, Estacion, IDRenglon)
  )
  EXEC spSincroSemilla 'EmbarqueAsistenteGeneral'
END
GO
EXEC spALTER_TABLE 'EmbarqueAsistenteGeneral', 'Persona', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmbarqueAsistenteGeneral', 'PersonaID', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmbarqueAsistenteGeneral', 'Referencia', 'varchar(50) NULL'
GO

