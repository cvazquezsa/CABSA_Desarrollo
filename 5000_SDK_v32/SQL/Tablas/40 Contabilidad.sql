/*******************************************************************************************/
/*                                         CONTABILIDAD                                   */
/*******************************************************************************************/
-- Polizas

/****** Contabilidad ******/
if not exists (select * from SysTabla where SysTabla = 'ContC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ContC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ContC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ContC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priContC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ContC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'ContC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE ContC ALTER COLUMN Empresa varchar(5)  NULL")
  EXEC("ALTER TABLE ContC ALTER COLUMN Mov     varchar(20) NULL")
END
GO

/****** Contabilidad ******/
if not exists (select * from SysTabla where SysTabla = 'Cont') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Cont','Movimiento','CONT')
if not exists (select * from sysobjects where id = object_id('dbo.Cont') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Cont (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	NOT NULL,
	Mov 			varchar(20)     NOT NULL,
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	FechaContable		datetime	NOT NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
	Contacto		varchar(10)	NULL,
	ContactoTipo		varchar(20)	NULL,
	ContactoAplica		varchar(10)	NULL,
	Moneda  		varchar(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		varchar(10)   	NULL,
	Autorizacion		varchar(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		varchar(15)   	NULL,
	Situacion		varchar(50)   	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,
	OrigenMoneda		varchar(10)	NULL,
	OrigenTipoCambio	float		NULL,
	OrigenEmpresa		varchar(5)	NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

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

	Moneda2			varchar(10)	NULL,
	TipoCambio2		float		NULL,
	Importe			money		NULL,
	Intercompania		bit		NULL	 DEFAULT 0,
	AfectarPresupuesto	varchar(30)	NULL	 DEFAULT 'No',
	FactorIntegracion	float		NULL	 DEFAULT 1.0,

	CONSTRAINT priCont PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Cont'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Cont'
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Cont.Consecutivo
  ALTER TABLE Cont ALTER COLUMN MovID varchar(20)
  ALTER TABLE Cont ALTER COLUMN OrigenID varchar(20)
END
GO
EXEC spALTER_TABLE 'Cont', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Cont', 'Contacto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cont', 'ContactoTipo', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Cont', 'Moneda2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cont', 'TipoCambio2', 'float NULL'
EXEC spALTER_TABLE 'Cont', 'Importe', 'money NULL'
EXEC spALTER_TABLE 'Cont', 'Intercompania', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cont', 'OrigenMoneda', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Cont', 'OrigenTipoCambio', 'float NULL'
EXEC spALTER_TABLE 'Cont', 'AfectarPresupuesto', 'varchar(30) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'Cont', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cont', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cont', 'ContactoAplica', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cont', 'OrigenEmpresa', 'varchar(5)	NULL'
EXEC spALTER_TABLE 'Cont', 'FactorIntegracion', 'float NULL DEFAULT 1.0 WITH VALUES'
GO
if exists(select * from SysTipoDatos where Tabla = 'Cont' AND Campo = 'AfectarPresupuesto' and Tamano<30)
  ALTER TABLE Cont ALTER COLUMN AfectarPresupuesto varchar(30) NULL
go


-- Actualizar Indices
if (select version from version)<=2767 and exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id) 
  DROP INDEX Cont.Usuario
GO

-- Cont
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Concepto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Concepto      ON dbo.Cont (Concepto, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia    ON dbo.Cont (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'FechaContable' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaContable ON dbo.Cont (FechaContable, Empresa)
go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Cont (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Cont (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Cont (Mov, Estatus, Moneda, Sucursal, Empresa, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Cont (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Cont (Usuario, FechaContable, Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Contacto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Contacto      ON dbo.Cont (Contacto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia    ON dbo.Cont (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Proyecto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Proyecto      ON dbo.Cont (Proyecto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'UEN' AND sysobjects.id = sysindexes.id)
  CREATE INDEX UEN           ON dbo.Cont (UEN)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Origen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Origen        ON dbo.Cont (OrigenID, Origen, Empresa)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cont.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cont.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cont.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cont.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cont.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Cont (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Cont (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cont' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Cont (OrigenID,Origen,Empresa)
go

EXEC spFK 'Cont','UEN','UEN','UEN'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgContA') and sysstat & 0xf = 8) drop trigger dbo.tgContA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgContC') and sysstat & 0xf = 8) drop trigger dbo.tgContC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgContB') and sysstat & 0xf = 8) drop trigger dbo.tgContB
GO
EXEC spModificarPK_Mov 'Cont'
GO
EXEC spSincroNivelRegistroCampos 'Cont'
-- Aqui va el Matenimiento a la tabla
GO
CREATE TRIGGER tgContC ON Cont
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN

  DECLARE
    @Modulo 		varchar(5),
    @Mov		varchar(20),
    @MovIDN		varchar(20),
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
    @AfectacionUsuario	varchar(10),
    --REQ25300
    @OrigenTipo			varchar(5)

  SELECT @OrigenTipo = ISNULL(OrigenTipo, '') FROM Inserted

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID
   
  --REQ25300
  IF @OrigenTipo <> 'CONTP'
  BEGIN
    IF dbo.fnEstaSincronizando() = 1 RETURN

    IF dbo.fnEstaSincronizando() = 1 RETURN  
  END
  
  SELECT @Modulo = 'CONT'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '') FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @MovIDN = NULLIF(RTRIM(MovID), ''), @Usuario = Usuario FROM Inserted
  IF @EstatusNuevo <> @EstatusAnterior AND 
     ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('CONFIRMAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
      (@EstatusNuevo = 'CONFIRMAR'  AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO', 'CANCELADO')) OR
      (@EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    SELECT @Mensaje = RTRIM(@Mensaje) + ' '+RTRIM(@Mov)+' '+RTRIM(@MovIDN)
    RAISERROR (@Mensaje,16,-1) 
  END 
  ELSE BEGIN
    IF @EstatusNuevo NOT IN (NULL, 'AFECTANDO') AND (@EstatusAnterior <> @EstatusNuevo OR @SituacionAnterior <> @SituacionNueva)
    BEGIN
      --REQ25300
      IF @OrigenTipo <> 'CONTP' AND @EstatusAnterior <> @EstatusNuevo AND (@EstatusAnterior <> 'AFECTANDO' OR @SituacionAnterior IS NULL OR @SituacionNueva IS NULL)
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

  --REQ25300
  IF @OrigenTipo <> 'CONTP'
    EXEC spMovAlActualizar @Modulo, @ID, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva, @SituacionAnterior
END
GO

CREATE TRIGGER tgContB ON Cont
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Empresa	varchar(5),
    @Mov	varchar(20),
    @MovID	varchar(20),
    @Estatus 	varchar(15),
    @OrigenTipo	varchar(10),
    @Origen	varchar(20),
    @OrigenID	varchar(20),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Empresa = Empresa, @Mov = Mov, @MovID = MovID, @Estatus = Estatus, @OrigenTipo = NULLIF(RTRIM(OrigenTipo), ''), @Origen = NULLIF(RTRIM(Origen), ''), @OrigenID = OrigenID FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
  BEGIN
    IF @OrigenTipo IS NOT NULL AND @Origen IS NOT NULL 
      EXEC spLigarMovCont 'CANCELAR', @Empresa, @OrigenTipo, @Origen, @OrigenID, @ID, @Mov, @MovID

    EXEC spMovAlEliminar 'CONT', @ID
  END
END
GO

/****** Contabilidad (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'ContD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContD','Movimiento','CONT')
if not exists (select * from sysobjects where id = object_id('dbo.ContD') and type = 'U') 
CREATE TABLE dbo.ContD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,
	RenglonSub		int		NOT NULL DEFAULT 0,

	Cuenta		        varchar(20) 	NULL,
	SubCuenta		varchar(50)	NULL,
	SubCuenta2		varchar(50)	NULL,
	SubCuenta3		varchar(50)	NULL,	
	Concepto		varchar(50)	NULL,
        Debe               	money     	NULL,
        Debe2               	money     	NULL,
        Haber               	money     	NULL,
        Haber2               	money     	NULL,

	Empresa			varchar(5)		NULL,
	Ejercicio 		int 		NULL,
	Periodo 		int 		NULL,
	FechaContable 		datetime 	NULL,

	Sucursal		int		NOT NULL DEFAULT 0,
	
	Presupuesto		bit		NULL	 DEFAULT 0,
	SucursalContable	int		NULL,
	Articulo		varchar(20)	NULL,
	DepartamentoDetallista	int		NULL,
	ContactoEspecifico	varchar(10)	NULL,

	RID			int		NOT NULL IDENTITY(1,1),
        Conciliado		bit		NULL	 DEFAULT 0,
	FechaConciliacion	datetime	NULL,
	Campo				varchar(20)	NULL,

	ContactoTipo		varchar(20)	NULL, --REQ 13147

	CONSTRAINT priContD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO
EXEC spModificarPK_Sucursal 'ContD', '(ID, Renglon, RenglonSub)'
GO
EXEC spALTER_TABLE 'ContD', 'Presupuesto', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ContD', 'ContactoTipo', 'varchar(20)	NULL' --REQ 13147
GO
if not exists(select * from syscampo where tabla = 'ContD' and campo = 'SucursalContable')
begin
  EXEC spALTER_TABLE 'ContD', 'SucursalContable', 'int NULL'
  EXEC("UPDATE ContD SET SucursalContable = Sucursal")
end
GO
if (select version from version) <= 2323
  update cont set importe = (SELECT SUM(Debe) FROM ContD WHERE ID = cont.ID)
GO
EXEC spALTER_TABLE 'ContD', 'Debe2', 'money NULL'
EXEC spALTER_TABLE 'ContD', 'Haber2', 'money NULL'
EXEC spALTER_TABLE 'ContD', 'Articulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ContD', 'DepartamentoDetallista', 'int NULL'
EXEC spALTER_TABLE 'ContD', 'ContactoEspecifico', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ContD', 'RID', 'int NOT NULL IDENTITY(1,1)'
EXEC spALTER_TABLE 'ContD', 'Conciliado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ContD', 'FechaConciliacion', 'datetime NULL'
EXEC spALTER_TABLE 'ContD', 'SubCuenta2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ContD', 'SubCuenta3', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ContD', 'Campo', 'varchar(20) NULL'
GO
EXEC spALTER_COLUMN 'ContD', 'SubCuenta', 'varchar(50) NULL'

GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContD' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cuenta    ON dbo.ContD (Cuenta, SubCuenta, Ejercicio, Periodo, FechaContable, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContD' AND sysindexes.name = 'SubCuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX SubCuenta ON dbo.ContD (SubCuenta, Cuenta, Ejercicio, Periodo, FechaContable, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContD' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.ContD (Articulo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContD' AND sysindexes.name = 'DepartamentoDetallista' AND sysobjects.id = sysindexes.id)
  CREATE INDEX DepartamentoDetallista ON dbo.ContD (DepartamentoDetallista)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContD' AND sysindexes.name = 'SucursalContable' AND sysobjects.id = sysindexes.id)
  CREATE INDEX SucursalContable ON dbo.ContD (SucursalContable)
go
EXEC spADD_INDEX 'ContD', 'RID', 'RID'
GO
-- select * from contd

EXEC spFK2 'ContD','Cuenta','SubCuenta','CtaSub','Cuenta','SubCuenta'
EXEC spFK 'ContD','Cuenta','Cta','Cuenta'
EXEC spFK 'ContD','SucursalContable','Sucursal','Sucursal'
EXEC spFK 'ContD','Articulo','Art','Articulo'
EXEC spFK 'ContD','DepartamentoDetallista','DepartamentoDetallista','Departamento'
GO

if exists (select * from sysobjects where id = object_id('dbo.cContD') and sysstat & 0xf = 2) drop view dbo.cContD
GO
CREATE VIEW cContD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  RenglonSub,

  Cuenta,
  SubCuenta,
  SubCuenta2,
  SubCuenta3,  
  Concepto,
  Debe,
  Debe2,
  Haber,
  Haber2,

  Sucursal,
  SucursalOrigen,
  SucursalContable,

--  Periodo,
  Articulo,
  DepartamentoDetallista,
  Presupuesto 

FROM 
  ContD
GO

/****** Contabilidad (Registro) ******/
if not exists (select * from SysTabla where SysTabla = 'ContReg') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContReg','Movimiento','CONT') 
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ContReg','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.ContReg') and type = 'U') 
CREATE TABLE dbo.ContReg (
	ID			int 	    	NOT NULL,
	RID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)		NULL,
       	Sucursal		int		NULL,
	Modulo			varchar(5)		NULL,
	ModuloID		int		NULL,	 	
       	ModuloRenglon		float		NULL,
       	ModuloRenglonSub	int		NULL,

       	Cuenta			varchar(20) 	NULL, 
       	SubCuenta 		varchar(50) 	NULL,
       	SubCuenta2 		varchar(50) 	NULL,
       	SubCuenta3 		varchar(50) 	NULL,
       	Concepto		varchar(50) 	NULL,
	ContactoEspecifico	varchar(10)	NULL,
       	Debe			money		NULL,
       	Haber			money		NULL,

	CONSTRAINT priContReg PRIMARY KEY CLUSTERED (ID, RID)
)
GO
EXEC spALTER_TABLE 'ContReg', 'ContactoEspecifico', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ContReg', 'SubCuenta2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ContReg', 'SubCuenta3', 'varchar(50) NULL'
GO
EXEC spADD_INDEX 'ContReg', 'Cuenta', 'Cuenta, Empresa'
GO

EXEC spFK 'ContReg','Cuenta','Cta','Cuenta'
GO

/****** ContSocio ******/
if not exists (select * from SysTabla where SysTabla = 'ContSocio') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ContSocio','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.ContSocio') and type = 'U') 
CREATE TABLE dbo.ContSocio (
	ID			int 	    	NOT NULL,
	Socio			varchar(10)	NOT NULL,

	Participacion		float		NULL,

	CONSTRAINT priContSocio PRIMARY KEY CLUSTERED (ID, Socio)
)
GO

EXEC spDROP_TABLE 'ContFiscal', 3082
GO
/****** Contabilidad (Fiscal) ******/
/*if not exists (select * from SysTabla where SysTabla = 'ContFiscal') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContFiscal','Movimiento','CONT')
if not exists (select * from sysobjects where id = object_id('dbo.ContFiscal') and type = 'U') 
CREATE TABLE dbo.ContFiscal (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,

	ObligacionFiscal	varchar(50)	NULL,
        Importe                 money           NULL,
	Tasa			float		NULL,
	Factor			float		NULL,	
	Modulo			varchar(5)	NULL,
	ModuloID		int		NULL,	
	Contacto		varchar(10)	NULL,
	ContactoTipo		varchar(20)	NULL,
	AFArticulo		varchar(20)	NULL,
	AFSerie			varchar(20)	NULL,

	DebeFiscal		money		NULL,
	HaberFiscal		money		NULL,

	CONSTRAINT priContFiscal PRIMARY KEY CLUSTERED (ID, Renglon)
)*/
GO
--EXEC spModificarPK_Sucursal 'ContFiscal', '(ID, Renglon)'
GO
--REQ1997 Preconfigurado
/****** CtaRazonFinanciera  ******/
if not exists (select * from sysobjects where id = object_id('dbo.CtaRazonFinanciera') and type = 'U') 
CREATE TABLE dbo.CtaRazonFinanciera (
--ID    int IDENTITY(1,1) NOT NULL,
--Empresa char(5) NOT NULL,
CtaActivo varchar(20) NULL,
CtaPasivo varchar(20) NULL,
CtaInventario varchar(20) NULL,
CtaEfectivoCaja varchar(20) NULL,
CtaEfectivoBanco varchar(20) NULL,
CtaEfectivoInversion varchar(20) NULL,
CtaCompras varchar(20) NULL,
CtaDevoluciones varchar(20) NULL,
CtaGastosFinancieros varchar(20) NULL
--CONSTRAINT priRazonFinanciera PRIMARY KEY  CLUSTERED (ID)
)
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaActivoFijo', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaActivoDiferido', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaPasivoLargoPlazo', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaPasivoDiferido', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaVentas', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaCostoVentas', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaGastosOperacion', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaOtrosGastosProductos', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaOtrosIngresos', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaDepreAmort', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaCuentasPorCobrar', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaProveedores', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaCuentasPorPagar', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaAcreedores', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaImpuestosPagados', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaCapitalContable', 'varchar(20)'
GO
EXEC spALTER_TABLE 'CtaRazonFinanciera', 'CtaInversionCapital', 'varchar(20)'
GO
/****** CtaRazonesFinancieras  ******/
if not exists (select * from sysobjects where id = object_id('dbo.CtaRazonesFinancieras') and type = 'U') 
CREATE TABLE dbo.CtaRazonesFinancieras (
  Cuenta varchar(20) NOT NULL,
  Descripcion varchar(100),

  CONSTRAINT priCuenta PRIMARY KEY CLUSTERED (Cuenta)

)
GO
/****** CtaRazonesFinancierasAdicionar  ******/
if not exists (select * from sysobjects where id = object_id('dbo.CtaRazonesFinancierasAdicionar') and type = 'U') 
CREATE TABLE dbo.CtaRazonesFinancierasAdicionar (
  Cuenta varchar(20) NOT NULL,
  CuentaA varchar(100),
  CONSTRAINT priRazonFinanciera PRIMARY KEY  CLUSTERED (Cuenta, CuentaA)
)
GO
/****** CtaRazonesFinancierasExcepcionar  ******/
if not exists (select * from sysobjects where id = object_id('dbo.CtaRazonesFinancierasExcepcionar') and type = 'U') 
CREATE TABLE dbo.CtaRazonesFinancierasExcepcionar (
  Cuenta varchar(20) NOT NULL,
  CuentaE varchar(100),
  CONSTRAINT priRazonFinancieraE PRIMARY KEY  CLUSTERED (Cuenta, CuentaE)
)
GO