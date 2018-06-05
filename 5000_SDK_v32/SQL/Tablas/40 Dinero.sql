/*******************************************************************************************/
/*                                          DINERO                                         */
/*******************************************************************************************/


/****** Cuentas Dinero (Cajeros) ******/
if not exists(select * from SysTabla where SysTabla = 'CtaDineroCajero')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaDineroCajero','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CtaDineroCajero') and type = 'U') 
CREATE TABLE dbo.CtaDineroCajero (
	CtaDinero		varchar(10)  	NOT NULL,
	Moneda			varchar(10)	NOT NULL,
	Cajero			varchar(10)	NULL,

	CONSTRAINT priCtaDineroCajero PRIMARY KEY  CLUSTERED (CtaDinero, Moneda)
)
GO

EXEC spFK 'CtaDineroCajero','Cajero','Agente','Agente'
GO

/****** Dinero ******/
if not exists (select * from SysTabla where SysTabla = 'DineroC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('DineroC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.DineroC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.DineroC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priDineroC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'DineroC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'DineroC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE DineroC ALTER COLUMN Empresa varchar(5)  NULL")
  EXEC("ALTER TABLE DineroC ALTER COLUMN Mov     varchar(20) NULL")
END
GO

/****** Dinero (Ficha) ******/
if not exists (select * from SysTabla where SysTabla = 'Dinero') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Dinero','Movimiento','DIN')
if not exists (select * from sysobjects where id = object_id('dbo.Dinero') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Dinero (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	        NOT NULL,
	Mov 			varchar(20)        NOT NULL,
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,	     -- fecha original en la que se realiza el movimiento
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)   	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
	Moneda  		varchar(10)   	NOT NULL,        -- Se va a usar mas adelante por ejemplo depositar dolares a una cuenta en pesos.
	TipoCambio		float		NULL,        
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Usuario 		varchar(10)   	NULL,
	Autorizacion		varchar(10)	NULL,
	Estatus 		varchar(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Directo			bit		NOT NULL DEFAULT 1,

	BeneficiarioNombre	varchar(100)   	NULL,	     -- se usa en cheques
	LeyendaCheque		varchar(100)   	NULL,	     -- se usa en cheques
        Beneficiario		int		NULL,
	CtaDinero 		varchar(10)   	NULL,
	CtaDineroDestino	varchar(10)   	NULL,
	ConDesglose		bit		NOT NULL	DEFAULT 0,         

	Contacto		varchar(10)	NULL,
	ContactoTipo		varchar(20)	NULL,
	ContactoEnviarA		int		NULL,

	Importe   		money       	NULL,	    -- Importe sin Iva y sin Descuentos
	Comisiones		money	    	NULL,
	Impuestos	        money       	NULL,
	Saldo			money		NULL,
	FechaProgramada		datetime	NULL,
	FormaPago		varchar(50) 	NULL,
	Cajero			varchar(10)	NULL,

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

	Corte			int		NULL,
	CorteDestino		int		NULL,

	FechaEntrega		datetime    	NULL,
	EmbarqueEstado		varchar(50)	NULL,

	InstitucionMensaje	varchar(10)	NULL,
	InstitucionSucursal	varchar(10)	NULL,
	InstitucionReferencia1	varchar(50)	NULL,
	InstitucionReferencia2	varchar(50)	NULL,
	AutoConciliar		bit		NULL	 DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,
	Mensaje			int		NULL,
	Liberar			bit		NULL	 DEFAULT 0,
	IVAFiscal		float		NULL,	
	IEPSFiscal		float		NULL,	
	EstaImpreso		bit		NULL	 DEFAULT 0,
	TipoCambioDestino	float		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	Conciliado		bit		NULL     DEFAULT 0,
	FechaConciliacion	datetime	NULL,
	ProveedorAutoEndoso	varchar(10)	NULL,

	CargoBancario		money		NULL,
	CargoBancarioIVA	money		NULL,
	Prioridad		varchar(10)	NULL,
	Comentarios		text		NULL,
	Nota			varchar(100)	NULL,

	FechaOrigen		datetime	NULL,
	ValorOrigen		float		NULL,
	Vencimiento		datetime	NULL,
	InteresTipo		varchar(20)	NULL,	-- Tasa Fija, Tasa Variable, Titulo
	Titulo			varchar(10)	NULL,
	TituloValor		float		NULL,
	Tasa			float		NULL,
	TasaDias		int		NULL,
	TasaRetencion		float		NULL,
	Retencion 		money		NULL,
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20)	NULL, --MEJORA4752	
	ContUso3		varchar(20)	NULL, --MEJORA4752		
	OperacionRelevante	bit		NULL,
	Cliente			varchar(10)	NULL,
	ClienteEnviarA		int		NULL,
	Proveedor		varchar(10)	NULL,
	ChequeDevuelto	bit NULL, --MEJORA6013
	
	CONSTRAINT priDinero PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Dinero'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Dinero'
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Dinero.Consecutivo
  ALTER TABLE Dinero ALTER COLUMN MovID varchar(20)
  ALTER TABLE Dinero ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Dinero ALTER COLUMN PolizaID varchar(20)
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgDineroA') and sysstat & 0xf = 8) drop trigger dbo.tgDineroA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgDineroC') and sysstat & 0xf = 8) drop trigger dbo.tgDineroC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgDineroB') and sysstat & 0xf = 8) drop trigger dbo.tgDineroB
GO
EXEC spModificarPK_Mov 'Dinero'
GO
EXEC spSincroNivelRegistroCampos 'Dinero'
GO
EXEC spALTER_TABLE 'Dinero', 'Cajero', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Dinero', 'Mensaje', 'int NULL'
EXEC spALTER_TABLE 'Dinero', 'Liberar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Dinero', 'IVAFiscal', 'float NULL'
EXEC spALTER_TABLE 'Dinero', 'IEPSFiscal', 'float NULL'
EXEC spALTER_TABLE 'Dinero', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Dinero', 'EstaImpreso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Dinero', 'Contacto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Dinero', 'ContactoTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Dinero', 'TipoCambioDestino', 'float NULL'
EXEC spALTER_TABLE 'Dinero', 'Conciliado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Dinero', 'FechaConciliacion', 'datetime NULL'
EXEC spALTER_TABLE 'Dinero', 'LeyendaCheque', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Dinero', 'ProveedorAutoEndoso', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Dinero', 'CargoBancario', 'money NULL'
EXEC spALTER_TABLE 'Dinero', 'CargoBancarioIVA', 'money	NULL'
EXEC spALTER_TABLE 'Dinero', 'Prioridad', 'varchar(10) NULL DEFAULT "Normal" WITH VALUES'
EXEC spALTER_TABLE 'Dinero', 'Comentarios', 'text NULL'
EXEC spALTER_TABLE 'Dinero', 'Nota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Dinero', 'FechaOrigen', 'datetime NULL'
EXEC spALTER_TABLE 'Dinero', 'Vencimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Dinero', 'Tasa', 'float NULL'
EXEC spALTER_TABLE 'Dinero', 'TasaDias', 'int NULL'
EXEC spALTER_TABLE 'Dinero', 'TasaRetencion', 'float NULL'
EXEC spALTER_TABLE 'Dinero', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Dinero', 'OperacionRelevante','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Dinero', 'ContactoEnviarA', 'int NULL'
EXEC spALTER_TABLE 'Dinero', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Dinero', 'ClienteEnviarA', 'int NULL'
EXEC spALTER_TABLE 'Dinero', 'Proveedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Dinero', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Dinero', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Dinero', 'InteresTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Dinero', 'Retencion', 'money NULL'
EXEC spALTER_TABLE 'Dinero', 'Titulo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Dinero', 'TituloValor', 'float NULL'
EXEC spALTER_TABLE 'Dinero', 'ValorOrigen', 'float NULL'
-- Aqui va el Matenimiento a la tabla
GO
EXEC spALTER_TABLE 'Dinero', 'ContUso2', 'varchar(20) NULL' --MEJORA4752
EXEC spALTER_TABLE 'Dinero', 'ContUso3', 'varchar(20) NULL' --MEJORA4752
GO
EXEC spALTER_TABLE 'Dinero', 'ChequeDevuelto', 'bit NULL DEFAULT 0' --MEJORA6013
GO

-- REQ12336
EXEC spALTER_TABLE 'Dinero', 'EmidaRequestId', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'Dinero','CorteImporte','Money NULL'
GO

EXEC spFK2 'Dinero','Cliente','ClienteEnviarA','CteEnviarA','Cliente','ID'
EXEC spFK 'Dinero','Beneficiario','Beneficiario','Beneficiario'
EXEC spFK 'Dinero','CtaDinero','CtaDinero','CtaDinero'
EXEC spFK 'Dinero','Cajero','Agente','Agente'
EXEC spFK 'Dinero','Mensaje','MensajeLista','Mensaje'
EXEC spFK 'Dinero','UEN','UEN','UEN'
EXEC spFK 'Dinero','ContUso','CentroCostos','CentroCostos'
EXEC spFK 'Dinero','Cliente','Cte','Cliente'
EXEC spFK 'Dinero','Proveedor','Prov','Proveedor'
EXEC spFK 'Dinero','Titulo','Titulo','Titulo'
GO

-- Dinero
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'CtaDinero' AND sysobjects.id = sysindexes.id)
  CREATE INDEX CtaDinero    ON dbo.Dinero (CtaDinero)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'CorteCaja' AND sysobjects.id = sysindexes.id)
  CREATE INDEX CorteCaja    ON dbo.Dinero (CtaDinero, Mov, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Beneficiario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Beneficiario ON dbo.Dinero (BeneficiarioNombre)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia   ON dbo.Dinero (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Prioridad' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Prioridad    ON dbo.Dinero (Prioridad)

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Dinero (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Dinero (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Dinero (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Dinero (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Dinero (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Dinero (ContID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Corte' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Corte	     ON dbo.Dinero (Corte)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'CorteDestino' AND sysobjects.id = sysindexes.id)
  CREATE INDEX CorteDestino  ON dbo.Dinero (CorteDestino)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'CtaDineroDestino' AND sysobjects.id = sysindexes.id)
  CREATE INDEX CtaDineroDestino ON Dinero(CtaDineroDestino)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Dinero.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Dinero.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Dinero.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Dinero.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Dinero.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Dinero (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Dinero (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Dinero (OrigenID,Origen,Empresa)
GO

EXEC spADD_INDEX 'Dinero', 'Origen', 'OrigenID, Origen, OrigenTipo, Empresa'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Dinero' AND sysindexes.name = 'EmpresaEstatus' AND sysobjects.id = sysindexes.id)
   CREATE INDEX EmpresaEstatus ON Dinero(Empresa,Estatus)INCLUDE(ID,CtaDinero,CtaDineroDestino)
GO


CREATE TRIGGER tgDineroC ON Dinero
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 		varchar(5),
    @Mov		varchar(20),
    @MovID		varchar(20),
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
  
  IF UPDATE(Conciliado) OR UPDATE(FechaConciliacion) RETURN

  SELECT @Modulo = 'DIN'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '') FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @MovID = MovID, @Usuario = Usuario FROM Inserted
  IF @EstatusNuevo <> @EstatusAnterior AND 
     ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('CONFIRMAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
      (@EstatusNuevo = 'CONFIRMAR'  AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO', 'CANCELADO')) OR
      (@EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    SELECT @Mensaje = RTRIM(@Mensaje) + ' '+RTRIM(@Mov)+' '+RTRIM(@MovID)
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
    UPDATE Dinero SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgDineroB ON Dinero
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
    EXEC spMovAlEliminar 'DIN', @ID
END
GO

/****** Dinero (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'DineroD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('DineroD','Movimiento','DIN')
if not exists (select * from sysobjects where id = object_id('dbo.DineroD') and type = 'U') 
CREATE TABLE dbo.DineroD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,
	RenglonSub		int		NOT NULL   DEFAULT 0,

        Importe                 money       	NULL,
	FormaPago		varchar(50) 	NULL,
	Referencia	        varchar(50) 	NULL,
	Aplica   	        varchar(20)        NULL,
        AplicaID	        varchar(20)     NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	ContUso			varchar(20)	NULL,
	ContUso2		varchar(20)	NULL, --MEJORA4752	
	ContUso3		varchar(20)	NULL, --MEJORA4752		
	Institucion		varchar(20)	NULL,
	CtaDinero		varchar(10)	NULL,--MEJORA5669
	Moneda   		varchar(10)	NULL,--MEJORA5669
	CtaDineroDestino	varchar(10)	NULL,--MEJORA5669
	TipoCambio              float           NULL,--MEJORA5669

	CONSTRAINT priDineroD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)

)
GO
if (select version from version) <= 1095
  ALTER TABLE DineroD ALTER COLUMN AplicaID varchar(20)
GO
EXEC spModificarPK_Sucursal 'DineroD', '(ID, Renglon, RenglonSub)'
GO
EXEC spALTER_TABLE 'DineroD', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'DineroD', 'Institucion', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'DineroD', 'ContUso2', 'varchar(20) NULL' --MEJORA4752
EXEC spALTER_TABLE 'DineroD', 'ContUso3', 'varchar(20) NULL' --MEJORA4752
GO

 EXEC spALTER_TABLE 'DineroD', 'CtaDinero', 'varchar(10)  NULL' --MEJORA5669
 EXEC spALTER_TABLE 'DineroD', 'Moneda', 'varchar(10)  NULL'--MEJORA5669
 EXEC spALTER_TABLE 'DineroD', 'CtaDineroDestino', 'varchar(10)  NULL'--MEJORA5669
 EXEC spALTER_TABLE 'DineroD', 'TipoCambio', 'float  NULL'--MEJORA5669
GO

EXEC spFK 'DineroD','ContUso','CentroCostos','CentroCostos'
EXEC spFK 'DineroD','Institucion','InstitucionFin','Institucion'
GO

if exists (select * from sysobjects where id = object_id('dbo.cDineroD') and sysstat & 0xf = 2) drop view dbo.cDineroD
GO
CREATE VIEW cDineroD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  RenglonSub,
  Importe,
  FormaPago,
  Referencia,
  Aplica,
  AplicaID,
  Sucursal,
  SucursalOrigen,
  ContUso,
  ContUso2, --MEJORA4752
  ContUso3, --MEJORA4752
  Institucion,--MEJORA5669
  CtaDinero,--MEJORA5669
  Moneda,   --MEJORA5669
  CtaDineroDestino,--MEJORA5669
  TipoCambio  --MEJORA5669

FROM
  DineroD
GO

/****** ConciliacionLog ******/
if not exists(select * from SysTabla where SysTabla = 'ConciliacionLog')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ConciliacionLog', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ConciliacionLog') and type = 'U') 
CREATE TABLE dbo.ConciliacionLog (
	Tipo			varchar(20)  	NOT NULL,
	Clave			varchar(20)  	NOT NULL,

	Estatus			varchar(15)	NOT NULL,
	Fecha			datetime	NULL,

	CONSTRAINT priConciliacionLog PRIMARY KEY  CLUSTERED (Tipo, Clave)
)
GO


--REQ 13393 POS
/****** DineroDenominacion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'DineroDenominacion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('DineroDenominacion', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.DineroDenominacion') AND type = 'U') 
  CREATE TABLE dbo.DineroDenominacion (
        ID                      int          NOT NULL,
        FormaPago               varchar(50)  NOT NULL,
        Denominacion            float        NOT NULL, 
        Nombre                  varchar(50)  NULL,   
        Cantidad                int          NULL,        
  CONSTRAINT priDineroDenominacion PRIMARY KEY CLUSTERED (ID, FormaPago,Denominacion)
  )
GO
EXEC spALTER_TABLE 'DineroDenominacion', 'Nombre',	'varchar(50)	NULL'
GO

/****** MovCorteDetalle (Ficha) ******/
if not exists (select * from SysTabla where SysTabla = 'MovCorteDetalle') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('MovCorteDetalle','Movimiento','DIN')
if not exists (select * from sysobjects where id = object_id('dbo.MovCorteDetalle') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovCorteDetalle (
    IDcorte				int				NOT NULL,
	ID 					int         	NOT NULL,
	Mov 				varchar(20)     NULL,
	MovID				varchar(20)    	NULL,
    CorteImporte   		money       NULL,
	Cancelado			bit NOT NULL DEFAULT 0,

	CONSTRAINT priMovCorteDetalle PRIMARY KEY CLUSTERED (IDCorte, ID)
  )
END