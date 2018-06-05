/****** Produccion ******/

/****** ProdRutaCat ******/
if not exists(select * from SysTabla where SysTabla = 'ProdRutaCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProdRutaCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProdRutaCat') and type = 'U') 
CREATE TABLE dbo.ProdRutaCat (
	Categoria		varchar(50) 	NOT NULL,

	CONSTRAINT priProdRutaCat PRIMARY KEY  CLUSTERED (Categoria)
)
GO

/****** ProdRutaD ******/
if not exists(select * from SysTabla where SysTabla = 'ProdRutaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProdRutaD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProdRutaD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ProdRutaD (
	Ruta			char(20) 	NOT NULL,
 	OrdenID			int 	    	NOT NULL IDENTITY(1,1),

	Orden			int		NULL,
	Centro			char(10)	NULL,
	Operacion		varchar(100)	NULL,
	TiempoFijo		float		NULL,
	TiempoVariable		float		NULL,
	UnidadT			char(10)	NULL,
	Costo			money		NULL,
	Moneda			char(10)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priProdRutaD PRIMARY KEY  CLUSTERED (Ruta, OrdenID)
  )
  EXEC spSincroSemilla 'ProdRutaD'
END
GO

/****** ProdRuta ******/
if not exists(select * from SysTabla where SysTabla = 'ProdRuta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProdRuta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProdRuta') and type = 'U') 
CREATE TABLE dbo.ProdRuta (
	Ruta			char(20) 	NOT NULL,
	Descripcion		varchar(100) 	NULL,
	Categoria		varchar(50) 	NULL,
	TieneMovimientos	bit		NULL	 DEFAULT 0,

	CONSTRAINT priProdRuta PRIMARY KEY  CLUSTERED (Ruta)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgProdRutaBC') and sysstat & 0xf = 8) drop trigger dbo.tgProdRutaBC
GO
if not exists(select * from syscampo where tabla = 'ProdRuta' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE ProdRuta ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE ProdRuta SET TieneMovimientos = 1")
END
GO
CREATE TRIGGER tgProdRutaBC ON ProdRuta
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	char(20),
    @ClaveAnterior	char(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = Ruta FROM Inserted
  SELECT @ClaveAnterior = Ruta FROM Deleted

  IF @ClaveNueva = @ClaveAnterior RETURN

  IF @ClaveNueva IS NULL
    DELETE ProdRutaD WHERE Ruta = @ClaveAnterior
  ELSE
    UPDATE ProdRutaD SET Ruta = @ClaveNueva WHERE Ruta = @ClaveAnterior
END
GO


/****** ProdRutaAlterna ******/
if not exists(select * from SysTabla where SysTabla = 'ProdRutaAlterna')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProdRutaAlterna','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProdRutaAlterna') and type = 'U') 
CREATE TABLE dbo.ProdRutaAlterna (
	Ruta		char(20) 	NOT NULL,
	RutaAlterna	char(20)	NOT NULL,

	Orden		int		NULL,

	CONSTRAINT priProdRutaAlterna PRIMARY KEY  CLUSTERED (Ruta, RutaAlterna)
)
GO

EXEC spFK 'ProdRutaAlterna','RutaAlterna','ProdRuta','Ruta'
GO

if not exists (select * from SysTabla where SysTabla = 'ProdC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ProdC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ProdC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ProdC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priProdC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ProdC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'ProdC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE ProdC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE ProdC ALTER COLUMN Mov     char(20) NULL")
END
GO

/*** Prod ***/
if not exists (select * from SysTabla where SysTabla = 'Prod') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Prod','Movimiento','PROD')
if not exists (select * from sysobjects where id = object_id('dbo.Prod') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Prod (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	Actividad		varchar(50)   	NULL,
	UEN			int		NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,
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

	Directo			bit		NOT NULL DEFAULT 1,
	VerDestino		bit		NOT NULL DEFAULT 0,
	AutoReservar		bit		NOT NULL DEFAULT 0,
	CostoAdicional		bit		NOT NULL DEFAULT 0,
	RenglonID		int		NULL,

	Almacen	        	char(10)   	NULL,
	Prioridad		char(10)	NULL,
	FechaInicio		datetime	NULL,
	FechaEntrega		datetime	NULL,

	Peso			float		NULL,
	Volumen			float		NULL,
	Paquetes		int		NULL,

	OrigenTipo		varchar(10)	NULL,	-- Que Movimiento Origino este Movimiento (si aplica)
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
	Sucursal		int		NOT NULL DEFAULT 0,
	Importe			money		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priProd PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Prod'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Prod'
go
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Prod.Consecutivo
  ALTER TABLE Prod ALTER COLUMN MovID varchar(20)
  ALTER TABLE Prod ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Prod ALTER COLUMN PolizaID varchar(20)
END
GO
if exists(select * from syscampo where tabla = 'Prod' and Campo = 'FechaRequerida') and not exists(select * from syscampo where tabla = 'Prod' and Campo = 'FechaEntrega')
  EXEC sp_rename 'Prod.FechaRequerida', 'FechaEntrega', 'COLUMN'
GO
EXEC spALTER_TABLE 'Prod', 'FechaInicio', 'datetime NULL'
EXEC spALTER_TABLE 'Prod', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Prod', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Prod', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Prod', 'Actividad', 'varchar(50) NULL'
GO

EXEC spFK 'Prod','Proyecto','Proy','Proyecto'
EXEC spFK 'Prod','Moneda','Mon','Moneda'
EXEC spFK 'Prod','UEN','UEN','UEN'
GO

-- Prod
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia   ON dbo.Prod (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Prod (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Prod (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Prod (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Prod (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Prod (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Prod (ContID)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Prod.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Prod.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Prod.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Prod.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Prod.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Prod (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Prod (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prod' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Prod (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgProdA') and sysstat & 0xf = 8) drop trigger dbo.tgProdA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgProdC') and sysstat & 0xf = 8) drop trigger dbo.tgProdC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgProdB') and sysstat & 0xf = 8) drop trigger dbo.tgProdB
GO
EXEC spModificarPK_Mov 'Prod'
GO
EXEC spSincroNivelRegistroCampos 'Prod'
GO
EXEC spALTER_TABLE 'Prod', 'Importe', 'money NULL'
EXEC spALTER_TABLE 'Prod', 'PosicionDWMS', 'varchar(10) NULL'
-- Aqui va el Matenimiento a la tabla
GO
EXEC spALTER_TABLE 'Prod', 'CrossDocking', 'bit NULL DEFAULT 0 WITH VALUES' --8. Desarrollo de proceso Cross Docking
GO

GO
CREATE TRIGGER tgProdC ON Prod
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo		char(5),
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
  
  SELECT @Modulo = 'PROD'
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
    UPDATE Prod SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgProdB ON Prod
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Mov	char(20),
    @MovID	varchar(20),
    @Estatus 	char(15),
    @Mensaje	char(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Mov = Mov, @MovID = MovID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'PROD', @ID
END
GO

/****** Produccion (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'ProdD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ProdD','Movimiento','PROD')
if not exists (select * from sysobjects where id = object_id('dbo.ProdD') and type = 'U') 
CREATE TABLE dbo.ProdD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,
	RenglonSub		int		NOT NULL   	DEFAULT 0,

	RenglonID		int		NULL,
	RenglonTipo		char(1)         NULL 		DEFAULT 'N',

	AutoGenerado		bit		NULL 		DEFAULT 0,
	Almacen			char(10)	NULL,
	Codigo			varchar(30)	NULL,
	Articulo	        char(20) 	NOT NULL,
	SubCuenta		varchar(50)	NULL,
        Cantidad                float     	NULL,
        Costo               	money     	NULL,

	ProdSerieLote		varchar(50)	NULL,

	CantidadPendiente	float	    	NULL,
	CantidadReservada	float	    	NULL,
	CantidadCancelada	float		NULL,
	CantidadOrdenada	float		NULL,
	CantidadA		float	    	NULL,
	Paquete			int		NULL,

	DestinoTipo		varchar(10)	NULL,
	Destino   	        varchar(20)     NULL,	-- Cual es el destino final (ej en una OP es el Pedido x) 
        DestinoID	        varchar(20)     NULL,
	Aplica   	        varchar(20)     NULL,	
        AplicaID	        varchar(20)     NULL,

	Cliente			varchar(10)	NULL,	-- Cuando se maneja BackOrder's por Cliente
	Centro			varchar(10)	NULL,	-- Centro de la Ruta
	CentroDestino		varchar(10)	NULL,	
	Orden			int		NULL,
	OrdenDestino		int		NULL,

	Unidad			varchar(50)	NULL,
	Factor			float	    	NULL DEFAULT 1.0,
        CantidadInventario      float     	NULL,

	Ruta			varchar(20)	NULL,
	Volumen			float		NULL,

	SustitutoArticulo       varchar(20)   	NULL,
	SustitutoSubCuenta	varchar(50)	NULL,

	FechaRequerida		datetime    	NULL,
	FechaEntrega		datetime	NULL,
	DescripcionExtra	varchar(100) 	NULL,

	UltimoReservadoCantidad	float		NULL,
	UltimoReservadoFecha	datetime	NULL,

        Merma	                float     	NULL,
        Desperdicio	        float     	NULL,
	Tipo			varchar(20)	NULL,	-- Producto, Merma, Desperdicio, Sustituto
	Comision		money		NULL,
	ManoObra		money		NULL,
	Indirectos		money		NULL,
	Maquila			money		NULL,
	Personal		varchar(10)	NULL,
	Estacion		varchar(10)	NULL,	
	EstacionDestino		varchar(10)	NULL,	

	Tiempo			float		NULL,
	TiempoUnidad		varchar(10) 	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	Turno			int		NULL,
	TiempoEstandarFijo	float		NULL,
	TiempoEstandarVariable	float		NULL,
	TiempoMuerto		float		NULL,
	Causa			varchar(50)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	AjusteCosteo		money		NULL,
	CostoUEPS		money		NULL,
	CostoPEPS		money		NULL,
	UltimoCosto		money		NULL,
	CostoEstandar		money		NULL,
	CostoPromedio		money		NULL,
	CostoReposicion		money		NULL,
	PrecioLista		money		NULL,
	DepartamentoDetallista	int		NULL,

	Posicion		varchar(10)	NULL,
	Tarima			varchar(20)	NULL,
	
	AplicaRenglon	float		NULL,

	CONSTRAINT priProdD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO
if (select version from version) <= 1095
  ALTER TABLE ProdD ALTER COLUMN AplicaID varchar(20)
if (select version from version) <= 1198
  ALTER TABLE ProdD ALTER COLUMN DestinoID varchar(20)
GO
EXEC spModificarPK_Sucursal 'ProdD', '(ID, Renglon, RenglonSub)'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ProdD' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.ProdD (Articulo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ProdD' AND sysindexes.name = 'ProdSerieLote' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ProdSerieLote ON dbo.ProdD (ProdSerieLote)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ProdD' AND sysindexes.name = 'MatarPendiente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MatarPendiente ON dbo.ProdD (ID, Articulo, SubCuenta)
go
EXEC spALTER_TABLE 'ProdD', 'Maquila', 'money NULL'
EXEC spALTER_TABLE 'ProdD', 'Personal' ,'varchar(10) NULL'
EXEC spALTER_TABLE 'ProdD', 'Turno', 'int NULL'
EXEC spALTER_TABLE 'ProdD', 'TiempoEstandarFijo', 'float NULL'
EXEC spALTER_TABLE 'ProdD', 'TiempoEstandarVariable', 'float NULL'
EXEC spALTER_TABLE 'ProdD', 'TiempoMuerto', 'float NULL'
EXEC spALTER_TABLE 'ProdD', 'Causa', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ProdD', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'ProdD', 'OrdenDestino', 'int NULL'
EXEC spALTER_TABLE 'ProdD', 'Estacion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ProdD', 'EstacionDestino', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ProdD', 'Volumen', 'float NULL'
EXEC spALTER_TABLE 'ProdD', 'Codigo', 'varchar(30) NULL'
EXEC spALTER_TABLE 'ProdD', 'CostoUEPS', 'money NULL'
EXEC spALTER_TABLE 'ProdD', 'CostoPEPS', 'money NULL'
EXEC spALTER_TABLE 'ProdD', 'UltimoCosto', 'money NULL'
EXEC spALTER_TABLE 'ProdD', 'PrecioLista', 'money NULL'
EXEC spALTER_TABLE 'ProdD', 'Posicion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ProdD', 'AjusteCosteo', 'money NULL'
EXEC spALTER_TABLE 'ProdD', 'DepartamentoDetallista', 'int NULL'
EXEC spALTER_COLUMN 'ProdD', 'ProdSerieLote', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ProdD', 'Tarima', 'varchar(20) NULL'
GO
EXEC spALTER_COLUMN 'ProdD', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'ProdD', 'SustitutoSubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ProdD',  'CostoEstandar', 'money NULL' 
EXEC spALTER_TABLE 'ProdD',  'CostoPromedio', 'money NULL' 
EXEC spALTER_TABLE 'ProdD',  'CostoReposicion', 'money NULL' 
GO

EXEC spALTER_TABLE 'ProdD',  'AplicaRenglon', 'float NULL' 
GO

EXEC spFK 'ProdD','Codigo','CB','Codigo'
EXEC spFK 'ProdD','Cliente','Cte','Cliente'
EXEC spFK 'ProdD','Centro','Centro','Centro'
EXEC spFK 'ProdD','Personal','Personal','Personal'
EXEC spFK 'ProdD','Estacion','EstacionT','Estacion'
GO

if (select version from version) <=2285
begin
  EXEC("UPDATE ProdD SET Orden = r.Orden FROM ProdD d, ProdRutaD r WHERE d.Ruta = r.Ruta AND d.Centro = r.Centro")
  EXEC("UPDATE ProdD SET OrdenDestino = r.Orden FROM ProdD d, ProdRutaD r WHERE d.Ruta = r.Ruta AND d.CentroDestino = r.Centro")
end
go

if exists (select * from sysobjects where id = object_id('dbo.cProdD') and sysstat & 0xf = 2) drop view dbo.cProdD
GO
CREATE VIEW cProdD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  RenglonSub,

  RenglonID,
  RenglonTipo,

  AutoGenerado, 
  Almacen,
  Codigo,
  Articulo,
  SubCuenta,
  Cantidad,
  Costo,
  ProdSerieLote,

  CantidadPendiente,
  CantidadReservada,
  CantidadCancelada,
  CantidadOrdenada,
  CantidadA,
  Paquete,

  DestinoTipo,
  Destino,
  DestinoID,
  Aplica,
  AplicaID,

  Cliente,
  Centro,
  CentroDestino,
  Orden,
  OrdenDestino,
  Estacion,
  EstacionDestino,

  Unidad,
  Factor,
  CantidadInventario,

  Ruta,
  Volumen,

  SustitutoArticulo,
  SustitutoSubCuenta,

  FechaRequerida,
  FechaEntrega,
  DescripcionExtra,

  Merma,
  Desperdicio,
  Tipo,
  Comision,
  ManoObra,
  Indirectos,
  Maquila,
  Personal,
  Turno,
  TiempoMuerto,
  Causa,
  Posicion,
  Tarima,

  UltimoReservadoCantidad,
  UltimoReservadoFecha,
  Sucursal,
  SucursalOrigen,

  Logico1,
  Logico2,
  Logico3,
  
  AplicaRenglon

FROM 
  ProdD
GO

if exists (select * from sysobjects where id = object_id('dbo.tgProdDAC') and sysstat & 0xf = 8) drop trigger dbo.tgProdDAC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgProdDAC ON ProdD
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  IF NOT UPDATE(Articulo) RETURN
  DECLARE
    @ID		int,
    @Renglon	float,
    @RenglonSub int

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = MIN(ID), @Renglon = MIN(Renglon), @RenglonSub = MIN(RenglonSub) FROM Inserted WHERE NULLIF(RTRIM(Articulo), '') IS NULL
  IF @ID IS NOT NULL AND @Renglon IS NOT NULL AND @RenglonSub IS NOT NULL
    DELETE ProdD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
END
GO

/****** ProdProgramaMaterial ******/
if not exists(select * from SysTabla where SysTabla = 'ProdProgramaMaterial')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProdProgramaMaterial','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ProdProgramaMaterial') and type = 'U') 
CREATE TABLE dbo.ProdProgramaMaterial (
	ID			int		NOT NULL,
	Renglon			float		NOT NULL,

	Producto		char(20)	NULL,
        SubProducto		varchar(50)	NULL,
	CantidadP 		float		NULL,
	UnidadP			varchar(50)	NULL,

	Lote			varchar(20)	NULL,
	
	Articulo		char(20)	NULL,
	SubCuenta		varchar(50)	NULL,

        Cantidad		float     	NULL,
	Unidad			varchar(50)	NULL,
        Factor			float     	NULL,
        Merma	        	float     	NULL,
        Desperdicio     	float     	NULL,

	AlmacenDestino		char(10)	NULL,
	AlmacenOrigen		char(10)	NULL,
	FechaRequerida		datetime	NULL,

	CONSTRAINT priProdProgramaMaterial PRIMARY KEY CLUSTERED (ID, Renglon)
)
GO
EXEC spModificarPK_Sucursal 'ProdProgramaMaterial', '(ID, Renglon)'
GO
EXEC spALTER_TABLE 'ProdProgramaMaterial', 'CantidadP', 'float NULL'
EXEC spALTER_TABLE 'ProdProgramaMaterial', 'UnidadP', 'varchar(50) NULL'
GO
EXEC spALTER_COLUMN 'ProdProgramaMaterial', 'SubProducto', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'ProdProgramaMaterial', 'SubCuenta', 'varchar(50) NULL'
GO
/*
NOTA - SI SE AGREGAN CAMPOS A ESTA TABLA HAY QUE MODIFICAR EN TABLAS TEMPORALES
*/
--if exists (select * from sysobjects where id = object_id('dbo.cProdProgramaMaterial') and sysstat & 0xf = 2) drop view dbo.cProdProgramaMaterial
GO
/*CREATE VIEW cProdProgramaMaterial
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  Producto,
  SubProducto,
  CantidadP,
  UnidadP,
  Lote,
  Articulo,
  SubCuenta,
  Cantidad,
  Unidad,
  Factor,
  Merma,
  Desperdicio,
  AlmacenDestino,
  AlmacenOrigen,
  FechaRequerida

FROM 
  ProdProgramaMaterial*/
GO



/****** ProdProgramaRuta ******/
if not exists(select * from SysTabla where SysTabla = 'ProdProgramaRuta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProdProgramaRuta','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ProdProgramaRuta') and type = 'U') 
CREATE TABLE dbo.ProdProgramaRuta (
	ID		int		NOT NULL,
	Renglon		float		NOT NULL,
	OrdenID		int		NOT NULL,
	
	Producto	char(20)	NULL,
        SubProducto	varchar(50)	NULL,
	Lote		varchar(20)	NULL,
	
        Cantidad	float     	NULL,
	Unidad		varchar(50)	NULL,

	Ruta		varchar(20)	NULL,
	Centro		char(10)	NULL,
	Estacion	char(10)	NULL,
	Operacion	varchar(100)	NULL,
	Orden		int		NULL,

	TiempoCola	 float		NULL,
	TiempoFijo	 float		NULL,
	TiempoVariable	 float		NULL,
	TiempoEspera	 float		NULL,
	TiempoMovimiento float		NULL,
 	DiasCarga	 float		NULL,
 	DiasEntrega	 float		NULL,

	FechaProcesoInicio	 datetime	NULL,
	FechaProcesoTermino	 datetime	NULL,
	FechaCargaInicio	 datetime	NULL,
	FechaCargaTermino	 datetime	NULL,

	CONSTRAINT priProdProgramaRuta PRIMARY KEY CLUSTERED (ID, Renglon, OrdenID)
)
GO
EXEC spModificarPK_Sucursal 'ProdProgramaRuta', '(ID, Renglon, OrdenID)'
GO
if (select version from version)<=1309
  ALTER TABLE ProdProgramaRuta ALTER COLUMN Ruta varchar(20)
GO
EXEC spALTER_COLUMN 'ProdProgramaRuta', 'SubProducto', 'varchar(50) NULL'
GO

/****** ProdSerieLote ******/
if not exists(select * from SysTabla where SysTabla = 'ProdSerieLote')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProdSerieLote','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ProdSerieLote') and type = 'U') 
CREATE TABLE dbo.ProdSerieLote (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			varchar(5)	NOT NULL,
	ProdSerieLote		varchar(50)	NOT NULL,
	Articulo		varchar(20)	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL DEFAULT '',

	FechaOrden		datetime	NULL,
	FechaEntrada		datetime	NULL,
	CantidadOrdenada 	float		NULL,
	CantidadCancelada 	float		NULL,
	CantidadEntrada		float		NULL,
	CantidadMerma		float		NULL,
	CantidadDesperdicio	float		NULL,

	CONSTRAINT priProdSerieLote PRIMARY KEY  CLUSTERED (Articulo, SubCuenta, ProdSerieLote, Sucursal, Empresa)
)
GO
EXEC spALTER_TABLE 'ProdSerieLote', 'FechaOrden', 'datetime NULL'
EXEC spALTER_TABLE 'ProdSerieLote', 'FechaEntrada', 'datetime NULL'
EXEC spALTER_TABLE 'ProdSerieLote', 'CantidadCancelada', 'float NULL'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ProdSerieLote' AND Campo = 'ProdSerieLote' and Tamano=20) OR
   exists(select * from SysTipoDatos WHERE Tabla = 'ProdSerieLote' AND Campo = 'SubCuenta' and Tamano=20) 
BEGIN
  EXEC spEliminarPK 'ProdSerieLote'
  EXEC spALTER_COLUMN 'ProdSerieLote', 'ProdSerieLote', 'varchar(50) NOT NULL'
  EXEC spALTER_COLUMN 'ProdSerieLote', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE ProdSerieLote ADD CONSTRAINT priProdSerieLote PRIMARY KEY  CLUSTERED (Articulo, SubCuenta, ProdSerieLote, Sucursal, Empresa)')
END
GO
EXEC spModificarPK_AcumSaldo 'ProdSerieLote', '(Articulo, SubCuenta, ProdSerieLote, Sucursal, Empresa)'
GO

/****** ProdSerieLoteCosto ******/
if not exists(select * from SysTabla where SysTabla = 'ProdSerieLoteCosto')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ProdSerieLoteCosto','Movimiento','PROD')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProdSerieLoteCosto','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ProdSerieLoteCosto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ProdSerieLoteCosto (
	Empresa		char(5)		NOT NULL,
	ProdSerieLote	varchar(50)	NOT NULL,	
	Articulo	varchar(20)	NOT NULL,
	SubCuenta	varchar(50)	NOT NULL DEFAULT '',
	Sucursal	int		NOT NULL DEFAULT 0,
	ID		int		NOT NULL IDENTITY(1,1),

	Modulo		char(5)		NULL,
	ModuloID	int		NULL,

	Cargo		money		NULL,
	Abono		money		NULL,
	Moneda		char(10)	NULL,

	Concepto	varchar(50)	NULL,		-- Material, Mano Obra, Indirectos, Comisiones
	CostoExtra	bit		NULL	DEFAULT 0,

	CONSTRAINT priProdSerieLoteCosto PRIMARY KEY  CLUSTERED (Empresa, ProdSerieLote, Articulo, SubCuenta, Sucursal, ID)
  )
  EXEC spSincroSemilla 'ProdSerieLoteCosto'
END
GO
EXEC spALTER_TABLE 'ProdSerieLoteCosto', 'CostoExtra', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ProdSerieLoteCosto' AND Campo = 'ProdSerieLote' and Tamano=20) OR
   exists(select * from SysTipoDatos WHERE Tabla = 'ProdSerieLoteCosto' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ProdSerieLoteCosto'
  EXEC spALTER_COLUMN 'ProdSerieLoteCosto', 'ProdSerieLote', 'varchar(50) NOT NULL'
  EXEC spALTER_COLUMN 'ProdSerieLoteCosto', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE ProdSerieLoteCosto ADD CONSTRAINT priProdSerieLoteCosto PRIMARY KEY  CLUSTERED (Empresa, ProdSerieLote, Articulo, SubCuenta, Sucursal, ID)')
END
GO
EXEC spModificarPK_AcumSaldo 'ProdSerieLoteCosto', '(Empresa, ProdSerieLote, Articulo, SubCuenta, Sucursal, ID)'
GO


/****** RutaDistribucion ******/
if not exists (select * from SysTabla where SysTabla = 'RutaDistribucion') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('RutaDistribucion', 'Maestro')
if exists (select * from sysobjects where id = object_id('dbo.RutaDistribucion') and type = 'U') and (select version from version) <= 1210
DROP TABLE dbo.RutaDistribucion
if not exists (select * from sysobjects where id = object_id('dbo.RutaDistribucion') and type = 'U') 
  CREATE TABLE dbo.RutaDistribucion (
	Ruta		varchar(50)	NOT NULL,

	CONSTRAINT priRutaDistribucion PRIMARY KEY  CLUSTERED (Ruta)
  )
GO
if exists (select * from sysobjects where id = object_id('dbo.tgRutaDistribucionBC') and sysstat & 0xf = 8) drop trigger dbo.tgRutaDistribucionBC
GO

/****** RutaDistribucionD ******/
if not exists (select * from SysTabla where SysTabla = 'RutaDistribucionD') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('RutaDistribucionD', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RutaDistribucionD') and type = 'U') 
  CREATE TABLE dbo.RutaDistribucionD (
	Ruta			varchar(50)	NOT NULL,
	AlmacenDestino		char(10)	NOT NULL,

	AlmacenOrigen		char(10)	NULL,

	TiempoEntrega		int		NULL,
	TiempoEntregaUnidad	varchar(10) 	NULL,

	CONSTRAINT priRutaDistribucionD PRIMARY KEY  CLUSTERED (Ruta, AlmacenDestino)
  )
GO

CREATE TRIGGER tgRutaDistribucionBC ON RutaDistribucion
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @RutaN	varchar(50),
    @RutaA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @RutaN = Ruta FROM Inserted
  SELECT @RutaA = Ruta FROM Deleted

  IF @RutaN = @RutaA RETURN

  IF @RutaN IS NULL
    DELETE RutaDistribucionD WHERE Ruta = @RutaA
  ELSE
    UPDATE RutaDistribucionD SET Ruta =  @RutaN WHERE Ruta = @RutaA
END
GO
