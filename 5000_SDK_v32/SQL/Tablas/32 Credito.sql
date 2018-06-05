
/*******************************************************************************************/
/*                                         Credito                         	           */
/*******************************************************************************************/
EXEC spDROP_TABLE 'Factoraje', 2919
EXEC spDROP_TABLE 'FactorajeC', 2919
GO

/****** Consecutivos Credito ******/
if not exists(select * from SysTabla where SysTabla = 'CreditoC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CreditoC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CreditoC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CreditoC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCreditoC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CreditoC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'CreditoC', '(ID)'
GO

-- drop table Credito
/****** Credito (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'Credito')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Credito','Movimiento','CREDI')
if not exists (select * from sysobjects where id = object_id('dbo.Credito') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Credito (
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

	Deudor			varchar(10)	NULL,
	Acreedor		varchar(10)	NULL,
	Importe			money		NULL,

	LineaCreditoEsp		bit		NULL	DEFAULT 0,
	LineaCredito		varchar(20)	NULL,
	LineaCreditoFondeo	varchar(20)	NULL,
 	TipoTasa		varchar(20)	NULL,
	TieneTasaEsp		bit		NULL	DEFAULT 0,
	TasaEsp			float		NULL,
	TipoAmortizacion	varchar(20)	NULL,
	Condicion		varchar(50)	NULL,
	Vencimiento		datetime    	NULL,
	CtaDinero		varchar(10)	NULL,
	FormaPago		varchar(50)	NULL,
	Comisiones		money		NULL,
	ComisionesIVA		money		NULL,

	CONSTRAINT priCredito PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Credito'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Credito'
go
EXEC spADD_INDEX 'Credito', 'Referencia', 'Referencia'
EXEC spADD_INDEX 'Credito', 'Consecutivo2', 'MovID, Mov, Estatus, Sucursal, Empresa'
EXEC spADD_INDEX 'Credito', 'FechaEmision2', 'FechaEmision, Estatus, Empresa'
EXEC spADD_INDEX 'Credito', 'Abrir2', 'Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion'
EXEC spADD_INDEX 'Credito', 'Situacion3', 'Estatus, Situacion, Empresa'
EXEC spADD_INDEX 'Credito', 'Usuario', 'Usuario'
EXEC spADD_INDEX 'Credito', 'ContID', 'ContID'
go

EXEC spFK 'Credito','UEN','UEN','UEN'
EXEC spFK 'Credito','Proyecto','Proy','Proyecto'
EXEC spFK 'Credito','Moneda','Mon','Moneda'
EXEC spFK 'Credito','Deudor','Cte','Cliente'
EXEC spFK 'Credito','Acreedor','Prov','Proveedor'
EXEC spFK 'Credito','TipoTasa','TipoTasa','TipoTasa'
EXEC spFK 'Credito','TipoAmortizacion','TipoAmortizacion','TipoAmortizacion'
EXEC spFK 'Credito','LineaCredito','LC','LineaCredito'
EXEC spFK 'Credito','CtaDinero','CtaDinero','CtaDinero'
GO

--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Credito' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Credito (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Credito' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Credito (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Credito' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Credito (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgCreditoA') and sysstat & 0xf = 8) drop trigger dbo.tgCreditoA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCreditoC') and sysstat & 0xf = 8) drop trigger dbo.tgCreditoC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCreditoB') and sysstat & 0xf = 8) drop trigger dbo.tgCreditoB
GO
EXEC spModificarPK_Mov 'Credito'
GO
EXEC spSincroNivelRegistroCampos 'Credito'
GO
-- Aqui va el Matenimiento a la tabla

GO
CREATE TRIGGER tgCreditoC ON Credito
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
  
  SELECT @Modulo = 'CREDI'
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
    UPDATE Credito SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgCreditoB ON Credito
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
    EXEC spMovAlEliminar 'CREDI', @ID
END
GO

