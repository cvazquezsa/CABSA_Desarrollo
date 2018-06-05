SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF

/****** Consecutivos (Contrato) ******/
if not exists(select * from SysTabla where SysTabla = 'ContratoC')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ContratoC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ContratoC') and type = 'U') 
BEGIN
	CREATE TABLE dbo.ContratoC (
		ID		int		NOT NULL IDENTITY (1,1),
		
		Empresa		char(5)         NULL,
		Mov 		char(20) 	NULL,
		Serie		varchar(20)	NULL,
		Periodo		int		NULL,
		Ejercicio	int		NULL,
		
		Consecutivo 	int		NOT NULL DEFAULT 0,
		Sucursal	int		NOT NULL DEFAULT 0,

		CONSTRAINT priContratoC PRIMARY KEY  CLUSTERED (ID)
	)
	EXEC spSincroSemilla 'ContratoC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'ContratoC', '(ID)'
GO

-- drop table Contrato
/****** Contrato ******/
if not exists(select * from SysTabla where SysTabla = 'Contrato')
	INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Contrato','Movimiento','PACTO')
GO
if not exists (select * from sysobjects where id = object_id('dbo.Contrato') and type = 'U') 
BEGIN
	CREATE TABLE dbo.Contrato (
		ID				int		NOT NULL        IDENTITY(1,1),
		
		Empresa				char(5)		NOT NULL,
		Mov 				char(20)	NOT NULL,	
		MovID				varchar(20)	NULL,
		FechaEmision 			datetime	NULL,
		UltimoCambio 			datetime	NULL,
		
		ContactoTipo			varchar(20)	NULL,	-- Prospecto, Cliente, Proveedor, Personal, Agente
		Prospecto			varchar(10)	NULL,
		Cliente				varchar(10)	NULL,
		Proveedor			varchar(10)	NULL,
		Personal			varchar(10)	NULL,
		Agente				varchar(10)	NULL,
		ContratoRama			varchar(50)	NULL,
		UEN				int		NULL,
		Concepto			varchar(50)	NULL,
		Proyecto  			varchar(50)	NULL,
		Usuario 			char(10)	NULL,
		Autorizacion			char(10)	NULL,
		DocFuente			int		NULL,
		Observaciones 			varchar(100)	NULL,
		Referencia 			varchar(50)	NULL,
		Estatus 			char(15)	NULL,
		Situacion			varchar(50)	NULL,
		SituacionFecha			datetime	NULL,
		SituacionUsuario		varchar(10)	NULL,
		SituacionNota			varchar(100)	NULL,
		Moneda				varchar(10)	NULL,
		TipoCambio			float		NULL,
		
		RamaID				int		NULL,
		IDOrigen			int		NULL,
		OrigenTipo			varchar(10)	NULL,
		Origen				varchar(20)	NULL,
		OrigenID			varchar(20)	NULL,
		
		Ejercicio			int		NULL,
		Periodo				int		NULL,
		FechaRegistro			datetime	NULL, 
		FechaConclusion			datetime	NULL,
		FechaCancelacion		datetime	NULL,
		
		Desde				datetime	NULL,	
		Hasta				datetime	NULL,
		
		Sucursal			int		NOT NULL	DEFAULT 0,
		Prioridad			varchar(10)	NULL,
		
		Comentarios			text		NULL,
		Documento			text		NULL,
		Titulo				varchar(100)	NULL,
		
		Contrato			varchar(50)	NULL,
		
		FechaEscrituracion		datetime	NULL,
		FechaInicio			datetime	NULL,
		Inversionista			varchar(5)	NULL,
		Importe				money		NULL,
		IVAImporte			money		NULL,
		ImporteTotal			money		NULL,
		
		
		CONSTRAINT priContrato PRIMARY KEY CLUSTERED (ID)
	)
	EXEC spSincroSemilla 'Contrato'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Contrato'
EXEC spModificarPK_Mov 'Contrato'
go
EXEC spALTER_TABLE 'Contrato', 'Contrato', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Contrato', 'RamaID', 'int NULL'
EXEC spALTER_TABLE 'Contrato', 'IDOrigen', 'int NULL'
EXEC spALTER_TABLE 'Contrato', 'FechaEscrituracion',	'datetime NULL'
EXEC spALTER_TABLE 'Contrato', 'FechaInicio', 'datetime	NULL'
EXEC spALTER_TABLE 'Contrato', 'Inversionista',	'varchar(5) NULL'
EXEC spALTER_TABLE 'Contrato', 'Importe', 'money NULL'
EXEC spALTER_TABLE 'Contrato', 'IVAImporte', 'money NULL'
EXEC spALTER_TABLE 'Contrato', 'ImporteTotal', 'money NULL'
go

--Contrato
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Contrato' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Consecutivo2  ON dbo.Contrato (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Contrato' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
	CREATE INDEX FechaEmision2 ON dbo.Contrato (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Contrato' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Abrir2        ON dbo.Contrato (Mov, Estatus, Sucursal, Empresa, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Contrato' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Situacion3    ON dbo.Contrato (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Contrato' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Usuario       ON dbo.Contrato (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Contrato' AND sysindexes.name = 'Titulo' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Titulo        ON dbo.Contrato (Titulo)
GO
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Contrato' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
	DROP INDEX Contrato.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Contrato' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
	DROP INDEX Contrato.Situacion2
GO

if exists (select * from sysobjects where id = object_id('dbo.tgContratoA') and sysstat & 0xf = 8) drop trigger dbo.tgContratoA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgContratoC') and sysstat & 0xf = 8) drop trigger dbo.tgContratoC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgContratoB') and sysstat & 0xf = 8) drop trigger dbo.tgContratoB
GO
EXEC spSincroNivelRegistroCampos 'Contrato'
GO
EXEC spModificarPK_Mov 'Contrato'
GO
-- Aqui va el Matenimiento a la tabla
GO

CREATE TRIGGER tgContratoC ON Contrato
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
	DECLARE
		@Modulo 		char(5),
		@Mov			char(20),
		@Sucursal		int,
		@ID			int,
		@FechaInicio		datetime,
		@Ahora 			datetime,
		@FechaAnterior		datetime,
		@EstatusNuevo 		char(15),
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
  
	SELECT @Modulo = 'PACTO'
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
			
			INSERT INTO MovTiempo	(Modulo,  Sucursal,  ID,  Usuario,                              FechaInicio,  FechaComenzo, Estatus,       Situacion) 
					VALUES	(@Modulo, @Sucursal, @ID, ISNULL(@AfectacionUsuario, @Usuario), @FechaInicio, @Ahora,       @EstatusNuevo, @SituacionNueva)
		END
	END
	
	EXEC spMovAlActualizar @Modulo, @ID, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva, @SituacionAnterior
	
	--Para que cancele la poliza cuando Maneja SincroContabilidadMatriz
	/*IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
		UPDATE Contrato SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
	*/
END
GO

CREATE TRIGGER tgContratoB ON Contrato
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
	EXEC spMovAlEliminar 'PACTO', @ID
END
GO

