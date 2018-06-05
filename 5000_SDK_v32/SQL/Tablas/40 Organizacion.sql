/*******************************************************************************************/
/*                                         Organizacion                      	           */
/*******************************************************************************************/

-- drop table Organizacion
/****** Organizacion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'Organizacion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('Organizacion', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.Organizacion') AND Type = 'U') 
  CREATE TABLE dbo.Organizacion (
  	Organizacion	int		NOT NULL,
  	
  	Nombre		varchar(100)	NULL,
  	Descripcion	varchar(255)	NULL,

  	CONSTRAINT priOrganizacion PRIMARY KEY  CLUSTERED (Organizacion)
  )  
GO

/****** OrganizacionRol ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'OrganizacionRol')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OrganizacionRol', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.OrganizacionRol') AND Type = 'U') 
  CREATE TABLE dbo.OrganizacionRol (
  	Rol		varchar(50)	NOT NULL,

  	CONSTRAINT priOrganizacionRol PRIMARY KEY  CLUSTERED (Rol)
  )  
GO

-- drop table OrganizacionPosicion
-- select * from OrganizacionPosicion
/****** OrganizacionPosicion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'OrganizacionPosicion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OrganizacionPosicion', 'Cuenta')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.OrganizacionPosicion') AND Type = 'U') 
  CREATE TABLE dbo.OrganizacionPosicion (
  	Organizacion		int		NOT NULL,
  	Posicion		varchar(50)	NOT NULL,
  	
  	Nombre			varchar(100)	NULL,
  	Orden			varchar(255)	NULL,
  	Capacidad		int		NULL,
  	RolEsp			varchar(50)	NULL,
  	TieneMovimientos	bit		NULL	DEFAULT 0,
  
  	CONSTRAINT priOrganizacionPosicion PRIMARY KEY  CLUSTERED (Posicion, Organizacion)
  )  
GO
EXEC spADD_INDEX 'OrganizacionPosicion', 'Orden', 'Orden, Organizacion'
EXEC spADD_INDEX 'OrganizacionPosicion', 'Nombre', 'Nombre, Organizacion'
GO
EXEC spALTER_TABLE 'OrganizacionPosicion', 'TieneMovimientos', 'bit NULL DEFAULT 0'
GO

EXEC spDROP_TABLE 'EntidadTipoRelacion',3312
GO
/****** EntidadTipoRelacion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'EntidadTipoRelacion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('EntidadTipoRelacion', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.EntidadTipoRelacion') AND Type = 'U') 
  CREATE TABLE dbo.EntidadTipoRelacion (
	ContactoTipo	varchar(20)	NOT NULL,
  	TipoRelacion	varchar(50)	NOT NULL,

  	CONSTRAINT priEntidadTipoRelacion PRIMARY KEY  CLUSTERED (ContactoTipo, TipoRelacion)
  )  
GO

EXEC spDROP_TABLE 'EntidadPosicion',3307
GO
/****** EntidadPosicion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'EntidadPosicion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('EntidadPosicion', 'Cuenta')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.EntidadPosicion') AND Type = 'U') 
  CREATE TABLE dbo.EntidadPosicion (
  	Entidad		varchar(20)	NOT NULL,
  	Organizacion	int		NOT NULL,
  	Posicion	varchar(50)	NOT NULL,
  	Estatus		varchar(15)	NOT NULL,
  	
  	Rol		varchar(50)	NULL,
	Observaciones	varchar(100)	NULL,
	UltimoCambio	datetime	NULL,
  
  	CONSTRAINT priEntidadPosicion PRIMARY KEY  CLUSTERED (Entidad, Organizacion, Posicion, Estatus)
  )  
GO
EXEC spADD_INDEX 'EntidadPosicion', 'Posicion', 'Posicion, Organizacion, Entidad, Estatus'
GO
EXEC spDROP_TABLE 'EntidadCuenta',3306
GO
/****** EntidadCuenta ******/
/*IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'EntidadCuenta')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('EntidadCuenta', 'Cuenta')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.EntidadCuenta') AND Type = 'U') 
BEGIN
  CREATE TABLE dbo.EntidadCuenta (
  	Entidad		varchar(20)	NOT NULL,
  	ContactoTipo	varchar(20)	NOT NULL,	-- Cliente, Proveedor, Agente, Empresa, etc.
  	RID		int		IDENTITY(1,1) NOT NULL,
  
	Prospecto	varchar(10)	NULL,	
  	Cliente		varchar(10)	NULL,
  	Proveedor	varchar(10)	NULL,
  	Agente		varchar(10)	NULL,
  	Personal	varchar(10)	NULL,
  	Espacio		varchar(10)	NULL,
  	Recurso		varchar(10)	NULL,
  	VIN		varchar(20)	NULL,
  	
  	Funcion		varchar(50)	NULL,
  	Porcentaje	float		NULL,
  	PorOmision	bit		NULL,
  
  	CONSTRAINT priEntidadCuenta PRIMARY KEY  CLUSTERED (Entidad, ContactoTipo, RID)
  )  
  EXEC spSincroSemilla 'EntidadCuenta'
END*/
GO

EXEC spDROP_TABLE 'EntidadRelacion',3312
GO
/****** EntidadRelacion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'EntidadRelacion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('EntidadRelacion', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.EntidadRelacion') AND Type = 'U') 
  CREATE TABLE dbo.EntidadRelacion (
	Entidad		varchar(20)			NOT NULL,
  	RID		int		IDENTITY(1,1)	NOT NULL,
  	
	ContactoTipo	varchar(20)	NULL,		-- Prospecto, Cliente, Proveedor, Agente, Personal, Espacio, Entidad, VIN, Recurso
	TipoRelacion	varchar(50)	NULL,
	
	Prospecto	varchar(10)	NULL,	
  	Cliente		varchar(10)	NULL,
  	Proveedor	varchar(10)	NULL,
  	Agente		varchar(10)	NULL,
  	Personal	varchar(10)	NULL,
  	Espacio		varchar(10)	NULL,
  	Recurso		varchar(10)	NULL,
  	VIN		varchar(20)	NULL,
	EntidadDestino	varchar(20)	NULL,	
	Usuario		varchar(10)	NULL,
  
	Observaciones	varchar(100)	NULL,
  	Estatus		varchar(15)	NULL,
	UltimoCambio	datetime	NULL,
  	
  	CONSTRAINT priEntidadRelacion PRIMARY KEY  CLUSTERED (Entidad, RID)
  )  
GO
EXEC spALTER_TABLE 'EntidadRelacion', 'Estatus', 'varchar(15) NULL'
GO
-- drop table Entidad
/****** Entidad ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'Entidad')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('Entidad', 'Cuenta')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.Entidad') AND Type = 'U') 
  CREATE TABLE dbo.Entidad (
  	Entidad			varchar(20)	NOT NULL,  	

  	SubCatalogo		varchar(5)	NOT NULL	DEFAULT 'ENT',  	
  	Nombre			varchar(100)	NULL,
  	Tipo			varchar(20)	NULL,	-- Persona Fisica, Persona Moral, Espacio, Objeto
  
	TieneMovimientos	bit		NULL	DEFAULT 0,
	Estatus 		varchar(15) 	NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Usuario			varchar(10)	NULL,

	Nombres			varchar(50)	NULL,
	ApellidoPaterno		varchar(50)	NULL,
	ApellidoMaterno		varchar(50)	NULL,
	
	Organizacion		varchar(100)	NULL,
	Cargo			varchar(100)	NULL,
		
	Direccion 		varchar(100) 	NULL,
	DireccionNumero		varchar(20)	NULL,
	DireccionNumeroInt	varchar(20)	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Delegacion		varchar(100) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Colonia 		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	
	Registro1		varchar(20)	NULL,
	Registro2		varchar(20)	NULL,
	Registro3		varchar(20)	NULL,
	
	PaginaWeb		varchar(100) 	NULL,

	CorreoEletronico1	varchar(50)     NULL,
	CorreoEletronico2	varchar(50) 	NULL,
	CorreoEletronico3	varchar(50) 	NULL,
	
	Telefonos1		varchar(100)	NULL,
	Telefonos2		varchar(100)	NULL,
	Telefonos3		varchar(100)	NULL,
	Telefonos4		varchar(100)	NULL,

	Fax 			varchar(50)     NULL,
	PedirTono		bit           	NULL DEFAULT 0,
	
  	CONSTRAINT priEntidad PRIMARY KEY  CLUSTERED (Entidad)
  )
GO
if exists (select * from sysobjects where id = object_id('dbo.tgEntidadBC') and sysstat & 0xf = 8) drop trigger dbo.tgEntidadBC
GO
EXEC spADD_INDEX 'Entidad', 'Abrir', 'SubCatalogo, Estatus, Usuario'
EXEC spADD_INDEX 'Entidad', 'Nombre', 'Nombre, SubCatalogo'
EXEC spADD_INDEX 'Entidad', 'Entidad', 'Entidad, SubCatalogo'
GO
CREATE TRIGGER tgEntidadBC ON Entidad
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @EntidadN  varchar(20),
    @EntidadA	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @EntidadN = Entidad FROM Inserted
  SELECT @EntidadA = Entidad FROM Deleted
  IF @EntidadN = @EntidadA RETURN

  IF @EntidadN IS NULL 
  BEGIN
    DELETE EntidadCuenta	WHERE Entidad = @EntidadA
    DELETE EntidadRelacion	WHERE Entidad = @EntidadA
    DELETE EntidadPosicion	WHERE Entidad = @EntidadA
  END ELSE
  IF @EntidadA IS NOT NULL 
  BEGIN
    UPDATE EntidadCuenta	SET Entidad = @EntidadN WHERE Entidad = @EntidadA
    UPDATE EntidadRelacion	SET Entidad = @EntidadN WHERE Entidad = @EntidadA
    UPDATE EntidadPosicion	SET Entidad = @EntidadN WHERE Entidad = @EntidadA
  END
END
GO

/****** Consecutivos Organiza ******/
if not exists(select * from SysTabla where SysTabla = 'OrganizaC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OrganizaC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.OrganizaC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.OrganizaC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priOrganizaC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'OrganizaC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'OrganizaC', '(ID)'
GO

-- drop table Organiza
/****** Organiza (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'Organiza')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Organiza','Movimiento','ORG')
if not exists (select * from sysobjects where id = object_id('dbo.Organiza') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Organiza (
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
			
	CONSTRAINT priOrganiza PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Organiza'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Organiza'
go
EXEC spALTER_TABLE 'Organiza', 'Comentarios', 'text NULL'
GO
EXEC spADD_INDEX 'Organiza', 'Referencia', 'Referencia'
EXEC spADD_INDEX 'Organiza', 'Consecutivo', 'MovID, Mov, Estatus, Sucursal, Empresa'
EXEC spADD_INDEX 'Organiza', 'FechaEmision', 'FechaEmision, Estatus, Empresa'
EXEC spADD_INDEX 'Organiza', 'Abrir', 'Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion'
EXEC spADD_INDEX 'Organiza', 'Situacion', 'Estatus, Situacion, Empresa'
EXEC spADD_INDEX 'Organiza', 'Usuario', 'Usuario'
EXEC spADD_INDEX 'Organiza', 'ContID', 'ContID'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgOrganizaA') and sysstat & 0xf = 8) drop trigger dbo.tgOrganizaA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgOrganizaC') and sysstat & 0xf = 8) drop trigger dbo.tgOrganizaC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgOrganizaB') and sysstat & 0xf = 8) drop trigger dbo.tgOrganizaB
GO
EXEC spModificarPK_Mov 'Organiza'
GO
EXEC spSincroNivelRegistroCampos 'Organiza'
GO
-- Aqui va el Matenimiento a la tabla
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Organiza' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Organiza (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Organiza' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Organiza (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Organiza' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Organiza (OrigenID,Origen,Empresa)
go


GO
CREATE TRIGGER tgOrganizaC ON Organiza
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
  
  SELECT @Modulo = 'ORG'
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
    UPDATE Organiza SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgOrganizaB ON Organiza
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
    EXEC spMovAlEliminar 'ORG', @ID
END
GO

EXEC spDROP_TABLE 'OrganizaD',3312
GO
/****** OrganizaD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'OrganizaD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('OrganizaD','Movimiento','ORG')
if not exists (select * from sysobjects where id = object_id('dbo.OrganizaD') and type = 'U') 
CREATE TABLE dbo.OrganizaD (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

	Organizacion		int		NULL,
	Posicion		varchar(50)	NULL,
	Entidad			varchar(20)	NULL,
	Rol			varchar(50)	NULL,
	
	ContactoTipo		varchar(20)	NULL,		-- Prospecto, Cliente, Proveedor, Agente, Personal, Espacio, Entidad, VIN, Recurso
	TipoRelacion		varchar(50)	NULL,	
	Prospecto		varchar(10)	NULL,	
  	Cliente			varchar(10)	NULL,
  	Proveedor		varchar(10)	NULL,
  	Agente			varchar(10)	NULL,
  	Personal		varchar(10)	NULL,
  	Espacio			varchar(10)	NULL,
  	Recurso			varchar(10)	NULL,
  	VIN			varchar(20)	NULL,
	EntidadDestino		varchar(20)	NULL,	
	Usuario			varchar(10)	NULL,
  
	Observaciones		varchar(100)	NULL,

	CONSTRAINT priOrganizaD PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'OrganizaD', '(ID, Renglon)'
GO

if exists (select * from sysobjects where id = object_id('dbo.cOrganizaD') and sysstat & 0xf = 2) drop view dbo.cOrganizaD
GO
CREATE VIEW cOrganizaD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  Sucursal,
  SucursalOrigen,

  Organizacion,
  Posicion,
  Entidad,
  Rol,
  ContactoTipo,
  TipoRelacion,
  Prospecto,
  Cliente,
  Proveedor,
  Agente,
  Personal,
  Espacio,
  Recurso,
  VIN,
  EntidadDestino,
  Usuario,

  Observaciones

FROM
  OrganizaD
GO

