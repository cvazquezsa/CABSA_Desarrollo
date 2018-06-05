
/*******************************************************************************************/
/*                                         INVENTARIOS                                     */
/*******************************************************************************************/

/****** Inventarios ******/
if not exists (select * from SysTabla where SysTabla = 'InvC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('InvC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.InvC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.InvC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priInvC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'InvC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'InvC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE InvC ALTER COLUMN Empresa varchar(5)  NULL")
  EXEC("ALTER TABLE InvC ALTER COLUMN Mov     varchar(20) NULL")
END
GO

/****** Inventarios ******/
if not exists (select * from SysTabla where SysTabla = 'Inv') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Inv','Movimiento','INV')
if not exists (select * from sysobjects where id = object_id('dbo.Inv') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Inv (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	        NOT NULL,
	Mov 			varchar(20)        NOT NULL,
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	Actividad		varchar(100)   	NULL,
	UEN			int		NULL,
	Moneda  		varchar(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		varchar(10)   	NULL,
	Autorizacion		varchar(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		varchar(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,
	Prioridad		varchar(10)	NULL,

	Directo			bit		NOT NULL DEFAULT 1,
	RenglonID		int		NULL,

	Almacen	        	varchar(10)   	NULL,
	AlmacenDestino  	varchar(10)   	NULL,
	AlmacenTransito		varchar(10)	NULL,
	Largo			bit	    	NOT NULL DEFAULT 0,
	FechaRequerida		datetime	NULL,
	Condicion		varchar(50)	NULL,
	Vencimiento		datetime	NULL,
	FormaEnvio 		varchar(50)   	NULL,  

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
	FechaOrigen		datetime    	NULL,

	Peso			float		NULL,
	Volumen			float		NULL,
	Paquetes		int		NULL,

	FechaEntrega		datetime    	NULL,
	EmbarqueEstado		varchar(50)	NULL,
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
	VerLote			bit		NULL 	 DEFAULT 0,
	EspacioResultado	bit		NULL 	 DEFAULT 0,
	VerDestino		bit		NULL 	 DEFAULT 0,
	EstaImpreso		bit		NULL	 DEFAULT 0,
	Personal		varchar(10)	NULL,

	Reabastecido			bit				NULL	 DEFAULT 0,
	Conteo					int				NULL,
	Agente					varchar(10)		NULL,
	ACRetencion				float			NULL,
	SubModulo				varchar(5)		NULL	DEFAULT 'INV',
	PedimentoExtraccion		varchar(50)		NULL,
 --REQ12534 Factory  	
	ReferenciaMES   		varchar(50)		NULL,
	PedidoMES          		varchar(20)		NULL,
	Serie             		varchar(3)		NULL,
	Motivo             		varchar(8)		NULL,
	IDMES                           int			NULL,
	IDMarcaje                       int			NULL,
	MovMES		                bit		        NULL	 DEFAULT 0,
	
	

/*	GestionMov		varchar(20)	NULL,
	GestionMovID		varchar(20)	NULL,
	GestionActividad	varchar(20)	NULL,
	GestionID		int		NULL,
	GestionPlanRID		int		NULL,*/
	
	--REQ12615 WMS
	PosicionWMS				varchar(10)		NULL,
	--Task 19162
	PosicionDWMS			varchar(10)		NULL,
	--BUG24540
	--TASK25114
	PasilloEsp              varchar(10)     NULL,
	CONSTRAINT priInv PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Inv'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Inv'
GO

if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Inv.Consecutivo
  ALTER TABLE Inv ALTER COLUMN MovID varchar(20)
  ALTER TABLE Inv ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Inv ALTER COLUMN PolizaID varchar(20)
END
GO

-- Inv
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia   ON dbo.Inv (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'Almacen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Almacen      ON dbo.Inv (Almacen)

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Inv (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Inv (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Inv (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Inv (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Inv (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Inv (ContID)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Inv.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Inv.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Inv.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Inv.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Inv.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Inv (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Inv (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Inv' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Inv (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgInvA') and sysstat & 0xf = 8) drop trigger dbo.tgInvA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgInvC') and sysstat & 0xf = 8) drop trigger dbo.tgInvC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgInvB') and sysstat & 0xf = 8) drop trigger dbo.tgInvB
GO
EXEC spModificarPK_Mov 'Inv'
GO
EXEC spSincroNivelRegistroCampos 'Inv'
GO
EXEC spALTER_TABLE 'Inv', 'Importe', 'money NULL'
EXEC spALTER_TABLE 'Inv', 'VerLote', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Inv', 'EspacioResultado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Inv', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Inv', 'VerDestino', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Inv', 'EstaImpreso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Inv', 'Personal', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Inv', 'Reabastecido', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Inv', 'Conteo', 'int NULL'
EXEC spALTER_TABLE 'Inv', 'Agente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Inv', 'ACRetencion', 'float	NULL'
EXEC spALTER_TABLE 'Inv', 'SubModulo', 'varchar(5) NULL DEFAULT "INV" WITH VALUES'
EXEC spALTER_TABLE 'Inv', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Inv', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Inv', 'Actividad', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Inv', 'PedimentoExtraccion', 'varchar(50) NULL'
/*EXEC spALTER_TABLE 'Inv', 'GestionMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Inv', 'GestionMovID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Inv', 'GestionActividad', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Inv', 'GestionID', 'int NULL'
EXEC spALTER_TABLE 'Inv', 'GestionPlanRID', 'int NULL'*/
-- Aqui va el Matenimiento a la tabla
GO
 --REQ12534 Factory  
EXEC spALTER_TABLE 'Inv', 'ReferenciaMES', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Inv', 'PedidoMES ', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Inv', 'PedidoMES ', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Inv', 'Serie', 'varchar(3) NULL'
EXEC spALTER_TABLE 'Inv', 'IDMES', 'int NULL'
EXEC spALTER_TABLE 'Inv', 'IDMarcaje', 'int NULL'
EXEC spALTER_TABLE 'Inv', 'MovMES','  bit NULL'
EXEC spALTER_TABLE 'Inv', 'Motivo', 'varchar(8) NULL'
GO

--REQ12615 WMS
EXEC spALTER_TABLE 'Inv', 'PosicionWMS', 'varchar(10) NULL'
--Task 19162
EXEC spALTER_TABLE 'Inv', 'PosicionDWMS', 'varchar(10) NULL'
GO

--TASK25114
--BUG24540
EXEC spALTER_TABLE 'Inv', 'PasilloEsp', 'varchar(10) NULL'
GO

EXEC spALTER_TABLE 'Inv', 'CrossDocking', 'bit NULL DEFAULT 0 WITH VALUES' --8. Desarrollo de proceso Cross Docking
GO

EXEC spFK 'Inv','Almacen','Alm','Almacen'
EXEC spFK 'Inv','Proyecto','Proy','Proyecto'
EXEC spFK 'Inv','UEN','UEN','UEN'
EXEC spFK 'Inv','Personal','Personal','Personal'
EXEC spFK 'Inv','Agente','Agente','Agente'
GO

--EXEC spADD_INDEX 'Inv', 'Gestion', 'GestionActividad, GestionMovID, GestionMov, Empresa'
--GO

--Integración MES
EXEC spALTER_TABLE 'Inv', 'MesLanzamiento', 'varchar(100) NULL'
GO

CREATE TRIGGER tgInvC ON Inv
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
  
  SELECT @Modulo = 'INV'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '')  FROM Deleted
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
    UPDATE Inv SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgInvB ON Inv
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Mov	varchar(20),
    @MovID	varchar(20),
    @Estatus 	varchar(15),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Mov = Mov, @MovID = MovID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'INV', @ID
END
GO

/****** Inventarios (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'InvD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('InvD','Movimiento','INV')
if not exists (select * from sysobjects where id = object_id('dbo.InvD') and type = 'U') 
CREATE TABLE dbo.InvD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,
	RenglonSub		int		NOT NULL DEFAULT 0,

	RenglonID		int		NULL,
	RenglonTipo		char(1)         NULL DEFAULT 'N',

        Cantidad                float     	NULL,
	Almacen			varchar(10)	NULL,
	Codigo			varchar(30) 	NULL,
	Articulo	        varchar(20) 	NOT NULL,
	ArticuloDestino	        varchar(20) 	NULL,
	SubCuenta		varchar(50)	NULL,
	SubCuentaDestino	varchar(50)	NULL,
        Costo               	money     	NULL,
	CostoInv		money     	NULL,
	ContUso			varchar(20)	NULL,
	Espacio			varchar(10)	NULL,

	CantidadReservada	float	    	NULL,
	CantidadCancelada	float		NULL,
	CantidadOrdenada	float		NULL,
	CantidadPendiente	float     	NULL,
	CantidadA		float     	NULL,
	Paquete			int		NULL,
	FechaRequerida		datetime	NULL,

	Aplica   	        varchar(20)     NULL,
        AplicaID	        varchar(20)     NULL,

	DestinoTipo		varchar(10)	NULL,
	Destino			varchar(20)	NULL,
	DestinoID		varchar(20)	NULL,
	Cliente			varchar(10)	NULL,

	Unidad			varchar(50)	NULL,
	Factor			float	    	NULL DEFAULT 1.0,
        CantidadInventario      float     	NULL,

	UltimoReservadoCantidad	float		NULL,
	UltimoReservadoFecha	datetime	NULL,

	ProdSerieLote		varchar(50)	NULL,
        Merma	                float     	NULL,
        Desperdicio	        float     	NULL,

	Producto		varchar(20)	NULL,
	SubProducto		varchar(20)	NULL,
	Tipo			varchar(20)	NULL,	-- Salida, Merma, Desperdicio, Devolucion
	Sucursal		int		NOT NULL DEFAULT 0,
	Precio			money		NULL,
	SegundoConteo		float		NULL,
	DescripcionExtra	varchar(100) 	NULL,

	AjusteCosteo		money		NULL,
	CostoUEPS		money		NULL,
	CostoPEPS		money		NULL,
	UltimoCosto		money		NULL,
	CostoEstandar		money		NULL,
	PrecioLista		money		NULL,
	DepartamentoDetallista	int		NULL,
	AjustePrecioLista	money		NULL,

	Posicion		varchar(10)	NULL,
	Tarima			varchar(20)	NULL,
	Seccion			smallint	NULL,
	FechaCaducidad		datetime	NULL,

	CostoPromedio		money		NULL,
	CostoReposicion		money		NULL,
 --REQ12534 Factory  	
 	INFORCostoConsumoMat	float		NULL,
 	INFORCostoManoObra	float		NULL,
 	INFORCostoIndirecto	float		NULL,
 	
 	AplicaRenglon		float		NULL,

	CONSTRAINT priInvD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO



 



if (select version from version) <= 1095
  ALTER TABLE InvD ALTER COLUMN AplicaID varchar(20)
GO
EXEC spModificarPK_Sucursal 'InvD', '(ID, Renglon, RenglonSub)'
GO
EXEC spALTER_TABLE 'InvD', 'CostoInv', 'money NULL'
EXEC spALTER_TABLE 'InvD', 'Precio', 'money NULL'
GO
EXEC spRENAME_COLUMN 'InvD', 'Autobus', 'Espacio'
GO
EXEC spALTER_TABLE 'InvD', 'Espacio', 'varchar(10) NULL'
EXEC spALTER_TABLE 'InvD', 'DestinoTipo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'InvD', 'Destino', 'varchar(20) NULL'
EXEC spALTER_TABLE 'InvD', 'DestinoID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'InvD', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'InvD', 'SubCuentaDestino', 'varchar(50) NULL'
EXEC spALTER_TABLE 'InvD', 'SegundoConteo', 'float NULL'
EXEC spALTER_TABLE 'InvD', 'Codigo', 'varchar(30) NULL'
EXEC spALTER_TABLE 'InvD', 'DescripcionExtra', 'varchar(100) NULL'
EXEC spALTER_TABLE 'InvD', 'CostoUEPS', 'money NULL'
EXEC spALTER_TABLE 'InvD', 'CostoPEPS', 'money NULL'
EXEC spALTER_TABLE 'InvD', 'UltimoCosto', 'money NULL'
EXEC spALTER_TABLE 'InvD', 'PrecioLista', 'money NULL'
EXEC spALTER_TABLE 'InvD', 'Posicion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'InvD', 'AjusteCosteo', 'money NULL'
EXEC spALTER_TABLE 'InvD', 'DepartamentoDetallista', 'int NULL'
EXEC spALTER_TABLE 'InvD', 'AjustePrecioLista', 'money NULL'
EXEC spALTER_COLUMN 'InvD', 'ProdSerieLote', 'varchar(50) NULL'
EXEC spALTER_TABLE 'InvD', 'Tarima', 'varchar(20) NULL'
EXEC spALTER_TABLE 'InvD', 'Seccion', 'smallint	NULL'
EXEC spALTER_TABLE 'InvD', 'CostoEstandar', 'money NULL'
GO
EXEC spALTER_COLUMN 'InvD', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'InvD', 'SubCuentaDestino', 'varchar(50) NULL'
EXEC spALTER_TABLE 'InvD', 'FechaCaducidad', 'datetime NULL'
GO

EXEC spALTER_TABLE 'InvD',  'CostoPromedio', 'money NULL' 
EXEC spALTER_TABLE 'InvD',  'CostoReposicion', 'money NULL' 
EXEC spALTER_TABLE 'InvD', 'PosicionActual', 'varchar(10) NULL'
EXEC spALTER_TABLE 'InvD', 'PosicionReal', 'varchar(10) NULL'
GO
--REQ12534 Factory  
EXEC spAlter_Table 'InvD', 'INFORCostoConsumoMat','  float NULL'
EXEC spAlter_Table 'InvD', 'INFORCostoManoObra','  float NULL'
EXEC spAlter_Table 'InvD', 'INFORCostoIndirecto','  float NULL'
EXEC spALTER_TABLE 'InvD', 'PosicionDestino', 'varchar(10) NULL'  
GO

EXEC spALTER_TABLE 'InvD',  'AplicaRenglon', 'float NULL' 
GO  
    
EXEC spFK2 'InvD','Almacen','Posicion','AlmPos','Almacen','Posicion'
EXEC spFK 'InvD','Codigo','CB','Codigo'
EXEC spFK 'InvD','Articulo','Art','Articulo'
EXEC spFK 'InvD','ContUso','CentroCostos','CentroCostos'
EXEC spFK 'InvD','Cliente','Cte','Cliente'
GO

--Integración MES
EXEC spALTER_TABLE 'InvD', 'MesLanzamiento', 'varchar(100) NULL'
EXEC spALTER_TABLE 'InvD', 'MesProdCostoMaquinaria', 'money NULL' -- CosteMaquinaria
EXEC spALTER_TABLE 'InvD', 'MesProdCostoMaquila', 'money NULL' -- ?
EXEC spALTER_TABLE 'InvD', 'MesProdCostoConsumoMat', 'money NULL' -- CosteMaterial
EXEC spALTER_TABLE 'InvD', 'MesProdCostoIndirecto', 'money NULL' -- CosteIndirecto
EXEC spALTER_TABLE 'InvD', 'MesProdCostoManoObra', 'money NULL' -- CosteOperarios
EXEC spDROP_COLUMN 'InvD', 'INFORCostoConsumoMat'
EXEC spDROP_COLUMN 'InvD', 'INFORCostoManoObra'
EXEC spDROP_COLUMN 'InvD', 'INFORCostoIndirecto'
GO

if (select version from version) <=2286
  alter table InvD alter column ArticuloDestino varchar(20) NULL
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'InvD' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.InvD (Articulo, SubCuenta)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'InvD' AND sysindexes.name = 'MatarPendiente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MatarPendiente ON dbo.InvD (ID, Articulo, SubCuenta)
go

if exists (select * from sysobjects where id = object_id('dbo.cInvD') and sysstat & 0xf = 2) drop view dbo.cInvD
GO
CREATE VIEW cInvD
--//WITH ENCRYPTION
AS
	SELECT
		ID,
		Renglon,
		RenglonSub,

		RenglonID,
		RenglonTipo,

		Cantidad,
		Almacen,
		Codigo,
		Articulo,
		SubCuenta,
		ArticuloDestino,
		SubCuentaDestino,
		Costo,
		CostoInv,
		ContUso,
		Espacio,

		CantidadReservada,
		CantidadCancelada,
		CantidadOrdenada,
		CantidadPendiente,
		CantidadA,
		Paquete,
		FechaRequerida,

		Aplica,
		AplicaID,

		DestinoTipo,
		Destino,
		DestinoID,
		Cliente,

		Unidad,
		Factor,
		CantidadInventario,

		UltimoReservadoCantidad,
		UltimoReservadoFecha,

		ProdSerieLote,
		Merma,
		Desperdicio,

		Producto,
		SubProducto,
		Tipo,

		Sucursal,
		SucursalOrigen,
		Precio,
		DescripcionExtra,
		Posicion,
		Tarima,
		Seccion,
		FechaCaducidad,
		PosicionDestino,
		AplicaRenglon,
		MesLanzamiento

	FROM 
		InvD
GO

if exists (select * from sysobjects where id = object_id('dbo.tgInvDAC') and sysstat & 0xf = 8) drop trigger dbo.tgInvDAC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgInvDAC ON InvD
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @ID		int,
    @Renglon	float,
    @RenglonSub int,
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF EXISTS(SELECT * FROM Inserted WHERE NULLIF(RTRIM(Almacen), '') IS NULL)
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 20830
    RAISERROR (@Mensaje,16,-1) 
  END

  IF NOT UPDATE(Articulo) RETURN
  SELECT @ID = MIN(ID), @Renglon = MIN(Renglon), @RenglonSub = MIN(RenglonSub) FROM Inserted WHERE NULLIF(RTRIM(Articulo), '') IS NULL
  IF @ID IS NOT NULL AND @Renglon IS NOT NULL AND @RenglonSub IS NOT NULL
    DELETE InvD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
END
GO

/****** Capas de Costo ******/
if not exists (select * from SysTabla where SysTabla = 'InvCapa') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InvCapa','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.InvCapa') and type = 'U') 
BEGIN
  CREATE TABLE dbo.InvCapa (
	Sucursal		int		NOT NULL DEFAULT 0,
	ID 			int	  	NOT NULL IDENTITY(1,1),

	Activa			bit		NOT NULL DEFAULT 1,
	Sistema			char(1)		NOT NULL DEFAULT 'G',  -- G / U / P
	Empresa			varchar(5)	        NOT NULL,
	Articulo 		varchar(20) 	NOT NULL,
	SubCuenta		varchar(50)	NULL 	  DEFAULT '',
	Fecha			datetime	NOT NULL,
	Existencia 		float		NULL,
	Costo			money		NULL,

	Modulo			varchar(5)    	NULL,
	Mov			varchar(20)     	NULL,
	MovID			varchar(20)	NULL,

	OtraMoneda						varchar(10) NULL, --MEJORA6230
	OtraMonedaTipoCambio			float NULL,  --MEJORA6230
	OtraMonedaTipoCambioVenta		float NULL,  --MEJORA6230
	OtraMonedaTipoCambioCompra		float NULL,  --MEJORA6230

	CONSTRAINT priInvCapa PRIMARY KEY CLUSTERED (Sucursal, ID)
  )
  EXEC spSincroSemilla 'InvCapa'
END
go
if (select version from version) <= 1098
  ALTER TABLE InvCapa ALTER COLUMN MovID varchar(20)
GO
EXEC spModificarPK_AcumSaldo 'InvCapa', '(Sucursal, ID)'
GO
if not exists(select * from syscampo where tabla = 'InvCapa' and campo= 'Sistema')
begin
  ALTER TABLE InvCapa ADD Sistema char(1) NOT NULL DEFAULT 'G' WITH VALUES
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'InvCapa' AND sysindexes.name = 'Art' AND sysobjects.id = sysindexes.id) DROP INDEX InvCapa.Art
end
GO
EXEC spALTER_TABLE 'InvCapa', 'Activa', 'bit NOT NULL DEFAULT 1 WITH VALUES'
GO
EXEC spALTER_COLUMN 'InvCapa', 'SubCuenta', 'varchar(50) NULL', '""'
GO

EXEC spFK 'InvCapa','Articulo','Art','Articulo'
GO
EXEC spALTER_TABLE 'InvCapa', 'OtraMoneda', 'varchar(10) NULL' --MEJORA6230
EXEC spALTER_TABLE 'InvCapa', 'OtraMonedaTipoCambio', 'float NULL' --MEJORA6230
EXEC spALTER_TABLE 'InvCapa', 'OtraMonedaTipoCambioVenta', 'float NULL' --MEJORA6230
EXEC spALTER_TABLE 'InvCapa', 'OtraMonedaTipoCambioCompra', 'float NULL' --MEJORA6230
GO

/*
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'InvCapa' AND sysindexes.name = 'Art' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Art ON dbo.InvCapa (Articulo, SubCuenta, Activa, Empresa, Sistema)
*/
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'InvCapa' AND sysindexes.name = 'Art' AND sysobjects.id = sysindexes.id) DROP INDEX InvCapa.Art
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'InvCapa' AND sysindexes.name = 'AgregarInvCapa' AND sysobjects.id = sysindexes.id)
 CREATE INDEX AgregarInvCapa ON InvCapa (MovID, Mov, Modulo, Articulo, Costo, SubCuenta, Sistema, Empresa) INCLUDE (ID, Sucursal, Existencia)
GO

/****** Capas UEPS ******/
if exists (select * from sysobjects where id = object_id('dbo.InvCapaUEPS') and type = 'U')
BEGIN
  DROP TABLE InvCapaUEPS
  DELETE SysTabla WHERE SysTabla = 'InvCapaUEPS' 
END
GO

/****** Capas PEPS ******/
if exists (select * from sysobjects where id = object_id('dbo.InvCapaPEPS') and type = 'U')
BEGIN
  DROP TABLE InvCapaPEPS
  DELETE SysTabla WHERE SysTabla = 'InvCapaPEPS'
END
GO


/****** Auxiliar Capas de Costo ******/
if not exists (select * from SysTabla where SysTabla = 'InvCapaAux') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InvCapaAux','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InvCapaAux','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.InvCapaAux') and type = 'U') 
BEGIN
  CREATE TABLE dbo.InvCapaAux (
	ID 			int	  	NOT NULL,
	RID 			int	  	NOT NULL IDENTITY(1,1),

	Fecha			datetime	NULL,
	Modulo			varchar(5)	NULL,
	ModuloID		int		NULL,
	Renglon			float		NULL,
	RenglonSub		int		NULL,
	
	Almacen			varchar(10)	NULL,

	CargoU			float		NULL,
	AbonoU			float		NULL,

	CONSTRAINT priInvCapaAux PRIMARY KEY CLUSTERED (ID, RID)
  )
  EXEC spSincroSemilla 'InvCapaAux'
END
go

IF NOT EXISTS(SELECT * FROM InvCapaAux)
BEGIN
  DECLARE @Fecha	datetime
  SELECT @Fecha = GETDATE()
  EXEC spExtraerFecha @Fecha OUTPUT
  INSERT INTO InvCapaAux (ID, CargoU, Fecha) SELECT ID, Existencia, @Fecha FROM InvCapa 
END
GO

/****** InvGastoDiverso ******/
if not exists (select * from SysTabla where SysTabla = 'InvGastoDiverso') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('InvGastoDiverso','Movimiento','INV')
GO
if (select version from version)<=2409 
  UPDATE SysTabla SET Modulo = 'INV' WHERE sysTabla = 'InvGastoDiverso'
GO
if not exists (select * from sysobjects where id = object_id('dbo.InvGastoDiverso') and type = 'U') 
BEGIN
  CREATE TABLE dbo.InvGastoDiverso (
	ID			int 	    	NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	Acreedor		varchar(10)	NOT NULL,
	RenglonID		int		IDENTITY(1,1) NOT NULL,

	Importe			money		NULL,
	PorcentajeImpuestos	float		NULL,
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,
	Prorrateo		varchar(20)	NULL,
	FechaEmision		datetime	NULL,
	Condicion		varchar(50)	NULL,
	Vencimiento		datetime	NULL,
	Referencia		varchar(50)	NULL,
	Retencion		money		NULL,
	Retencion2		money		NULL,
	Retencion3		money		NULL,
	Impuestos		money		NULL,
	Multiple		bit		NULL 	 DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,
	PedimentoEspecifico	varchar(20)	NULL,

	CONSTRAINT priInvGastoDiverso PRIMARY KEY CLUSTERED (ID, Concepto, Acreedor, RenglonID)
  )
  EXEC spSincroSemilla 'InvGastoDiverso'
END
GO
if exists (select * from sysobjects where id = object_id('dbo.tgInvGastoDiversoABC') and sysstat & 0xf = 8) drop trigger dbo.tgInvGastoDiversoABC
GO
EXEC spALTER_TABLE 'InvGastoDiverso', 'Retencion3', 'money NULL'
GO
-- Aqui va el Matenimiento a la tabla
EXEC spModificarPK_Sucursal 'InvGastoDiverso', '(ID, Concepto, Acreedor, RenglonID)'
GO

EXEC spFK 'InvGastoDiverso','ID','Inv','ID'
EXEC spFK 'InvGastoDiverso','Acreedor','Prov','Proveedor'
GO

/****** InvGastoDiversoD ******/
if not exists (select * from SysTabla where SysTabla = 'InvGastoDiversoD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('InvGastoDiversoD','Movimiento','INV')
GO
if (select version from version)<=2409 
  UPDATE SysTabla SET Modulo = 'INV' WHERE sysTabla = 'InvGastoDiversoD'
GO
if not exists (select * from sysobjects where id = object_id('dbo.InvGastoDiversoD') and type = 'U') 
CREATE TABLE dbo.InvGastoDiversoD (
	ID			int 	    	NOT NULL,
	RenglonID		int		NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	Acreedor		varchar(10)	NOT NULL,
	ConceptoD		varchar(50)	NOT NULL,

	Importe			money		NULL,
	Retencion		money		NULL,
	Retencion2		money		NULL,
	Retencion3		money		NULL,
	Impuestos		money		NULL,
	Referencia		varchar(50)	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priInvGastoDiversoD PRIMARY KEY CLUSTERED (ID, RenglonID, Concepto, Acreedor, ConceptoD)
)
GO
EXEC spModificarPK_Sucursal 'InvGastoDiversoD', '(ID, RenglonID, Concepto, Acreedor, ConceptoD)'
GO
EXEC spALTER_TABLE 'InvGastoDiversoD', 'Retencion3', 'money NULL'
GO
--TASK25114
--BUG24540
/****** Artículo en blanco para Inventario Físico ******/
if not exists(select * from SysTabla where SysTabla = 'WMSInventarioFisicoArtBlanco')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WMSInventarioFisicoArtBlanco','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WMSInventarioFisicoArtBlanco') and type = 'U') 
CREATE TABLE dbo.WMSInventarioFisicoArtBlanco (
  ID				int			IDENTITY,
  Articulo			varchar(20)	NOT NULL,
  Tarima			varchar(20)	NOT NULL,
  CONSTRAINT priWMSInventarioFisicoArtBlanco PRIMARY KEY CLUSTERED(ID)
  )
GO

EXEC spALTER_TABLE 'Usuario', 'AutorizaAltaTarima', 'Bit NULL default 0'

 /*********     TarimasBajaWMS     *********/
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE Id = OBJECT_ID('TarimasBajaWMS') and TYPE = 'U')
BEGIN
  CREATE TABLE TarimasBajaWMS(
    Id                  int          identity(1,1) NOT NULL,
	Tarima              varchar(20)                    NULL,
	SaldoU              MONEY                          NULL,
	Articulo            varchar(20)                    NULL,
	Almacen				varchar(10)                    NULL
	)
END	
GO

--REQ1821 Precong
/****** VerRotacionInv  ******/
if exists (select * from sysobjects where id = object_id('dbo.VerRotacionInv') and type = 'U') 
	DROP TABLE dbo.VerRotacionInv
CREATE TABLE dbo.VerRotacionInv (
Estacion			int				NOT NULL,
ID					int				IDENTITY(1,1) NOT NULL,
Empresa				char(5)			NULL,
Sucursal			int				NULL,
Nombre				varchar(100)	NULL,
Articulo			varchar(20)		NULL,
Descripcion1		varchar(100)	NULL,
Unidad				varchar(50)		NULL,
Moneda				varchar(10)		NULL,
SubCuenta			varchar(50)		NULL,
CostoTotalNetoMN	money			NULL,
CostoInvInicial		money			NULL,
CostoInvFinal		money			NULL,
CostoInvPromedio	money			NULL,
CostoInvPromedioMN	money			NULL,
Rotacion			float			NULL,
CONSTRAINT priVerRotacionInv PRIMARY KEY CLUSTERED (Estacion, ID)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VerRotacionInv' AND sysindexes.name = 'VerRotacionInv' AND sysobjects.id = sysindexes.id)
  CREATE INDEX VerRotacionInv ON VerRotacionInv (Estacion, Empresa, Sucursal, Moneda, Articulo, SubCuenta)

GO


