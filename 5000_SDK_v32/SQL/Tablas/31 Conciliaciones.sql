
/*******************************************************************************************/
/*                                         Conciliacion                         	           */
/*******************************************************************************************/

/****** Consecutivos Conciliacion ******/
if not exists(select * from SysTabla where SysTabla = 'ConciliacionC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ConciliacionC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ConciliacionC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ConciliacionC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priConciliacionC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ConciliacionC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'ConciliacionC', '(ID)'
GO

-- drop table Conciliacion
/****** Conciliacion (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'Conciliacion')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Conciliacion','Movimiento','CONC')
if not exists (select * from sysobjects where id = object_id('dbo.Conciliacion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Conciliacion (
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
	Sucursal		int		NOT NULL DEFAULT 0,
	Moneda			char(10)	NULL,
	TipoCambio		float		NULL,

	CtaDinero		varchar(10)	NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,

	SaldoBanco		money		NULL,
	SaldoConciliado		money		NULL,
	SaldoLibros		money		NULL,

	CONSTRAINT priConciliacion PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Conciliacion'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Conciliacion'
go
EXEC spADD_INDEX 'Conciliacion', 'Referencia', 'Referencia'
EXEC spADD_INDEX 'Conciliacion', 'Consecutivo2', 'MovID, Mov, Estatus, Sucursal, Empresa'
EXEC spADD_INDEX 'Conciliacion', 'FechaEmision2', 'FechaEmision, Estatus, Empresa'
EXEC spADD_INDEX 'Conciliacion', 'Abrir2', 'Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion'
EXEC spADD_INDEX 'Conciliacion', 'Situacion3', 'Estatus, Situacion, Empresa'
EXEC spADD_INDEX 'Conciliacion', 'Usuario', 'Usuario'
EXEC spADD_INDEX 'Conciliacion', 'ContID', 'ContID'
EXEC spADD_INDEX 'Conciliacion', 'CtaDinero','ID,CtaDinero'
go
EXEC spDROP_COLUMN 'Conciliacion', 'SaldoAnterior'
EXEC spDROP_COLUMN 'Conciliacion', 'Cargos'
EXEC spDROP_COLUMN 'Conciliacion', 'Abonos'
go
EXEC spALTER_TABLE 'Conciliacion', 'SaldoBanco', 'money	NULL'
EXEC spALTER_TABLE 'Conciliacion', 'SaldoConciliado', 'money NULL'
EXEC spALTER_TABLE 'Conciliacion', 'SaldoLibros', 'money NULL'
go

--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Conciliacion' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Conciliacion (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Conciliacion' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Conciliacion (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Conciliacion' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Conciliacion (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgConciliacionA') and sysstat & 0xf = 8) drop trigger dbo.tgConciliacionA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgConciliacionC') and sysstat & 0xf = 8) drop trigger dbo.tgConciliacionC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgConciliacionB') and sysstat & 0xf = 8) drop trigger dbo.tgConciliacionB
GO
EXEC spModificarPK_Mov 'Conciliacion'
GO
EXEC spSincroNivelRegistroCampos 'Conciliacion'
GO
-- Aqui va el Matenimiento a la tabla

EXEC spFK 'Conciliacion','UEN','UEN','UEN'
EXEC spFK 'Conciliacion','Proyecto','Proy','Proyecto'
EXEC spFK 'Conciliacion','Moneda','Mon','Moneda'
EXEC spFK 'Conciliacion','CtaDinero','CtaDinero','CtaDinero'
GO

CREATE TRIGGER tgConciliacionC ON Conciliacion
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
  
  SELECT @Modulo = 'CONC'
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
    UPDATE Conciliacion SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgConciliacionB ON Conciliacion
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
    EXEC spMovAlEliminar 'CONC', @ID
END
GO

-- drop table ConciliacionD
/****** ConciliacionD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'ConciliacionD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ConciliacionD','Movimiento','CONC')
if not exists (select * from sysobjects where id = object_id('dbo.ConciliacionD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ConciliacionD (
	ID			int		NOT NULL,
	RID			int		NOT NULL 	IDENTITY(1,1),

	Fecha			datetime	NULL,
	Concepto		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,
	Cargo			money		NULL,
	Abono			money		NULL,
	Observaciones		varchar(100)	NULL,
	Manual			int		NULL,

	TipoMovimiento		varchar(20)	NULL,
	Auxiliar		int		NULL,
	ContD			int		NULL,
	ConceptoGasto		varchar(50)	NULL,
	Acreedor		varchar(10)	NULL,	
	ObligacionFiscal	varchar(50)	NULL,
	ObligacionFiscal2	varchar(50)	NULL,
	Tasa			float		NULL,
	TipoImporte		varchar(20)	NULL,
	Seccion			smallint	NOT NULL	DEFAULT 0,

	CONSTRAINT priConciliacionD PRIMARY KEY CLUSTERED (ID, RID)
  )
  EXEC spSincroSemilla 'ConciliacionD'
END
go
EXEC spModificarPK_Sucursal 'ConciliacionD', '(ID, RID)'
GO
EXEC spALTER_TABLE 'ConciliacionD', 'ConceptoGasto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ConciliacionD', 'Acreedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ConciliacionD', 'Tasa', 'float NULL'
EXEC spALTER_TABLE 'ConciliacionD', 'TipoImporte', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ConciliacionD', 'Seccion', 'smallint NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ConciliacionD', 'ObligacionFiscal', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ConciliacionD', 'ObligacionFiscal2', 'varchar(50) NULL'
GO
EXEC spADD_INDEX 'ConciliacionD', 'Seccion','ID,Seccion'
EXEC spADD_INDEX 'ConciliacionD', 'SeccionAuxiliar','ID,Seccion,Auxiliar'

GO
EXEC spFK 'ConciliacionD','Auxiliar','Auxiliar','ID'
GO

--sp_rename 'ConciliacionD.AuxiliarManual', 'Manual', 'COLUMN'
if exists (select * from sysobjects where id = object_id('dbo.cConciliacionD') and sysstat & 0xf = 2) drop view dbo.cConciliacionD
GO
CREATE VIEW cConciliacionD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Fecha,
  Concepto,
  Referencia,
  Cargo,
  Abono,
  Observaciones,
  Sucursal,
  SucursalOrigen,
  Seccion

FROM
  ConciliacionD
GO

/****** ConciliacionCompensacion ******/
if not exists(select * from SysTabla where SysTabla = 'ConciliacionCompensacion')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ConciliacionCompensacion','Movimiento','CONC')
if not exists (select * from sysobjects where id = object_id('dbo.ConciliacionCompensacion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ConciliacionCompensacion (
	ID			int		NOT NULL,
	RID			int		NOT NULL 	IDENTITY(1,1),

	ConciliacionD		int		NULL,
	Manual			int		NULL,

	CONSTRAINT priConciliacionCompensacion PRIMARY KEY CLUSTERED (ID, RID)
  )
  EXEC spSincroSemilla 'ConciliacionCompensacion'
END
go
EXEC spModificarPK_Sucursal 'ConciliacionCompensacion', '(ID, RID)'
GO
