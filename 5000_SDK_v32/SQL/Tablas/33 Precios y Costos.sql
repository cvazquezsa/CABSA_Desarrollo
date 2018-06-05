
/*******************************************************************************************/
/*                                     Precios y Costos                                    */
/*******************************************************************************************/

EXEC spDROP_TABLE 'PrecioMetodo', 2917
GO

/** CAMPOS CALCULADOS **/
EXEC spDROP_COLUMN 'PCD', 'CostoBase'
GO

-- drop table PrecioMetodo
/****** PrecioMetodo  ******/
if not exists(select * from SysTabla where SysTabla = 'PrecioMetodo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PrecioMetodo ','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PrecioMetodo') and type = 'U') 
CREATE TABLE dbo.PrecioMetodo  (
	Metodo			varchar(50)	NOT NULL,

	Base			varchar(20)	NULL,
	Usar			varchar(20)	NULL,		-- Porcentaje, Importe, Margen, Margen Articulo, Margen Minimo, Otro
	Monto			float		NULL,		-- Porcentaje o Importe	
	MontoFijo		bit		NULL	DEFAULT 0,
	Redondear		bit		NULL	DEFAULT 0,
	Redondeo		money		NULL,

	CONSTRAINT priPrecioMetodo PRIMARY KEY CLUSTERED (Metodo)
)
go


/****** Consecutivos (PC) ******/
if not exists(select * from SysTabla where SysTabla = 'PCC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('PCC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.PCC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PCC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priPCC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'PCC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'PCC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE PCC ALTER COLUMN Empresa varchar(5)  NULL")
  EXEC("ALTER TABLE PCC ALTER COLUMN Mov     varchar(20) NULL")
END
GO

/****** PC ******/
if not exists(select * from SysTabla where SysTabla = 'PC')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('PC','Movimiento','PC')
if not exists (select * from sysobjects where id = object_id('dbo.PC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PC (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	NOT NULL,
	Mov 			varchar(20)     NOT NULL,	
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
	Concepto		varchar(50)	NULL,
	Moneda  		varchar(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		varchar(10)   	NULL,
	Autorizacion		varchar(10)	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Referencia 		varchar(50) 	NULL,
	Estatus 		varchar(15)   	NULL,
	Situacion		varchar(50)   	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		varchar(20)	NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,
	ContID			int		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	ListaModificar		varchar(20)	NULL,
	Proveedor		varchar(10)	NULL,
	FechaInicio		datetime	NULL,
	FechaTermino		datetime	NULL,
	Recalcular		bit		NULL 	 DEFAULT 0,
	Parcial			bit		NULL	 DEFAULT 1,
	Metodo			varchar(50)	NULL,
	Monto			float		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priPC PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'PC'
END
go
EXEC spSincroNivelRegistro @Tabla = 'PC'
go

-- PC
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.PC (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.PC (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.PC (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.PC (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.PC (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.PC (ContID)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX PC.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX PC.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX PC.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX PC.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX PC.Abrir
GO

if exists (select * from sysobjects where id = object_id('dbo.tgPCA') and sysstat & 0xf = 8) drop trigger dbo.tgPCA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgPCC') and sysstat & 0xf = 8) drop trigger dbo.tgPCC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgPCB') and sysstat & 0xf = 8) drop trigger dbo.tgPCB
GO
EXEC spSincroNivelRegistroCampos 'PC'
GO
EXEC spModificarPK_Mov 'PC'
GO
EXEC spALTER_TABLE 'PC', 'Recalcular', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'PC', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'PC', 'Parcial', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'PC', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'PC', 'SituacionNota', 'varchar(100)	NULL'
EXEC spALTER_TABLE 'PC', 'Proveedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'PC', 'Metodo', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'PC', 'Monto', 'float NULL'
GO

EXEC spFK 'PC','UEN','UEN','UEN'
EXEC spFK 'PC','Proveedor','Prov','Proveedor'
EXEC spFK 'PC','Metodo','PrecioMetodo','Metodo'
GO

--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON PC (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON PC (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PC' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON PC (OrigenID,Origen,Empresa)
go

-- Aqui va el Matenimiento a la tabla

GO
CREATE TRIGGER tgPCC ON PC
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 		varchar(5),
    @Mov		varchar(20),
    @Sucursal		int,
    @ID			int,
    @FechaInicio	datetime,
    @Ahora 		datetime,
    @FechaAnterior	datetime,
    @EstatusNuevo 	varchar(15),
    @EstatusAnterior 	varchar(15),
    @SituacionNueva 	varchar(50),
    @SituacionAnterior 	varchar(50),
    @Usuario		varchar(10),
    @Mensaje		varchar(255),
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Modulo = 'PC'
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
    UPDATE PC SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgPCB ON PC
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	varchar(15),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'PC', @ID
END
GO

/****** PCListaModificar ******/
if not exists(select * from SysTabla where SysTabla = 'PCListaModificar')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('PCListaModificar','Movimiento','PC')
if not exists (select * from sysobjects where id = object_id('dbo.PCListaModificar') and type = 'U') 
CREATE TABLE dbo.PCListaModificar (
	ID 			int       	NOT NULL,
	ListaModificar		varchar(20)	NOT NULL,

	CONSTRAINT priPCListaModificar PRIMARY KEY CLUSTERED (ID, ListaModificar)
)
go
EXEC spModificarPK_Sucursal 'PCListaModificar', '(ID, ListaModificar)'
GO

/****** PCD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'PCD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('PCD','Movimiento','PC')
if not exists (select * from sysobjects where id = object_id('dbo.PCD') and type = 'U') 
CREATE TABLE dbo.PCD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,

	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Unidad			varchar(50)	NULL,
	Nuevo			money		NULL,
	Anterior		money		NULL,
	Baja			bit		NULL	DEFAULT 0,
	ExistenciaSucursal	float		NULL,
	ListaModificar		varchar(20)	NULL,
	SucursalEsp		int		NULL,
	Monto			float		NULL,

	CONSTRAINT priPCD PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PCD' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.PCD (Articulo)
GO
EXEC spModificarPK_Sucursal 'PCD', '(ID, Renglon)'
GO
EXEC spALTER_TABLE 'PCD', 'Baja', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'PCD', 'SubCuenta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'PCD', 'Unidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'PCD', 'ExistenciaSucursal', 'float NULL'
EXEC spALTER_TABLE 'PCD', 'ListaModificar', 'varchar(20) NULL'
EXEC spALTER_TABLE 'PCD', 'SucursalEsp', 'int NULL'
GO
EXEC spRENAME_COLUMN 'PCD.Valor', 'Monto', 'COLUMN'
GO
EXEC spALTER_TABLE 'PCD', 'Monto', 'float NULL'
GO
EXEC spALTER_COLUMN 'PCD', 'SubCuenta', 'varchar(50) NULL'
GO

EXEC spFK 'PCD','Articulo','ArtPrecioCostoMoneda','Articulo'
EXEC spFK 'PCD','Articulo','Art','Articulo'
EXEC spFK 'PCD','SucursalEsp','Sucursal','Sucursal'
EXEC spFK 'PCD','Articulo','ArtCosto','Articulo'
GO

if exists (select * from sysobjects where id = object_id('dbo.cPCD') and sysstat & 0xf = 2) drop view dbo.cPCD
GO
CREATE VIEW cPCD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Articulo,
  SubCuenta,
  Unidad,
  Baja,
  ListaModificar,
  SucursalEsp, 
  Monto,
--  Nuevo,
--  Anterior,
  Sucursal,
  SucursalOrigen

FROM
  PCD
GO

/****** PCBoletin  ******/
if not exists(select * from SysTabla where SysTabla = 'PCBoletin')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PCBoletin','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PCBoletin') and type = 'U') 
  CREATE TABLE dbo.PCBoletin  (
        ID			int		NOT NULL,
	RenglonID		int		NOT NULL IDENTITY(1,1),

	Articulo		varchar(20)	NULL,

	PrecioListaN		money		NULL,
	PrecioListaA		money		NULL,
	Precio2N		money		NULL,
	Precio2A		money		NULL,
	CostoN			money		NULL,
	CostoA			money		NULL,
	IncentivoN		money		NULL,
	IncentivoA		money		NULL,
	PrecioVolumenN		money		NULL,
	PrecioVolumenA		money		NULL,

	Baja			bit		NULL	DEFAULT 0,

	CONSTRAINT priPCBoletin PRIMARY KEY CLUSTERED (ID, RenglonID)
)
go
EXEC spALTER_TABLE 'PCBoletin', 'PrecioVolumenN', 'money NULL'
EXEC spALTER_TABLE 'PCBoletin', 'PrecioVolumenA', 'money NULL'
GO

EXEC spFK 'PCBoletin','Articulo','Art','Articulo'
GO

/****** PrecioCalc  ******/
if not exists(select * from SysTabla where SysTabla = 'PrecioCalc')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PrecioCalc ','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PrecioCalc') and type = 'U') 
CREATE TABLE dbo.PrecioCalc  (
	ListaPrecios		varchar(20)	NOT NULL,

	Base			varchar(20)	NULL,
	Usar			varchar(20)	NULL,
	Porcentaje		float		NULL,
	Redondear		money		NULL,		
	Activa			bit		NOT NULL DEFAULT 0,
	Orden			int		NULL,

	CONSTRAINT priPrecioCalc PRIMARY KEY CLUSTERED (ListaPrecios)
)
go

-- drop table PC_H2
/****** PC_H2 ******/
if not exists(select * from SysTabla where SysTabla = 'PC_H2')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PC_H2','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.PC_H2') and type = 'U') 
CREATE TABLE dbo.PC_H2 (
	Estacion		int		NOT NULL,
	ID 			int       	NOT NULL,	
	Renglon			float		NOT NULL,
	RID			int 	    	NOT NULL IDENTITY(1,1),

	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Unidad			varchar(50)	NULL,
	CostoBase		float		NULL,
	Margen			float		NULL,
	Variacion		float		NULL,
	Redondear		bit		NULL	DEFAULT 0,
	Redondeo		int		NULL,
	Impuesto1		float		NULL,
	Impuesto2		float		NULL,
	UltimoCambio		datetime	NULL,
	Anterior		float		NULL,
	Nuevo			float		NULL,
	ListaModificar		varchar(20)	NULL,

	CONSTRAINT priPC_H2 PRIMARY KEY CLUSTERED (Estacion, ID, Renglon, RID)
)
go
EXEC spALTER_TABLE 'PC_H2', 'ListaModificar', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'PC_H2', 'SubCuenta', 'varchar(50) NULL'
GO

EXEC spFK 'PC_H2','Articulo','Art','Articulo'
GO

/****** PCBoletin  ******/
/*if not exists(select * from SysTabla where SysTabla = 'PCBoletin')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PCBoletin','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PCBoletin') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PCBoletin  (
	Boletin			varchar(50)	NOT NULL,

        BoletinID		int		NOT NULL IDENTITY (1,1),

	FechaRegistro		datetime	NULL,
	VigenciaD		datetime	NULL,
	VigenciaA		datetime	NULL,
	Usuario			char(10)	NULL,

	CONSTRAINT priPCBoletin PRIMARY KEY CLUSTERED (Boletin)
  )
  EXEC spSincroSemilla 'PCBoletin'
END*/
go

/****** PCBoletinD  ******/
/*if not exists(select * from SysTabla where SysTabla = 'PCBoletinD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PCBoletinD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PCBoletinD') and type = 'U') 
CREATE TABLE dbo.PCBoletinD  (
        BoletinID	int		NOT NULL,
	RenglonID	int		NOT NULL IDENTITY (1,1),

	Datos		varchar(255)	NULL,

	CONSTRAINT priPCBoletinD PRIMARY KEY CLUSTERED (BoletinID, RenglonID)
)*/
go

