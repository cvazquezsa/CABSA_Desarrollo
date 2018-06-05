SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/*******************************************************************************************/
/*                                         WMS 2.0                         	           */
/*******************************************************************************************/

/****** TarimaTipo ******/
if not exists(select * from SysTabla where SysTabla = 'TarimaTipo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('TarimaTipo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TarimaTipo') and type = 'U') 
  CREATE TABLE dbo.TarimaTipo (
	Tipo			varchar(20)	NOT NULL,
	
	CONSTRAINT priTarimaTipo PRIMARY KEY  CLUSTERED (Tipo)
  )
GO

EXEC spDROP_TABLE 'Tarima', 3120
GO
/****** Tarima ******/
if not exists(select * from SysTabla where SysTabla = 'Tarima')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('Tarima', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Tarima') and type = 'U') 
  CREATE TABLE dbo.Tarima (
	Tarima			varchar(20)	NOT NULL,

	Almacen			varchar(10)	NULL,
	Posicion		varchar(10)	NULL,

	Estatus			varchar(15)	NULL,
	
	Alta			datetime	NULL,
	Baja			datetime	NULL,
	FechaCaducidad		datetime	NULL,
	
	CONSTRAINT priTarima PRIMARY KEY  CLUSTERED (Tarima)
  )
GO
EXEC spALTER_TABLE 'Tarima', 'Alta', 'datetime NULL'
EXEC spALTER_TABLE 'Tarima', 'Baja', 'datetime NULL'
EXEC spALTER_TABLE 'Tarima', 'FechaCaducidad', 'datetime NULL'
GO
EXEC spADD_INDEX 'Tarima', 'Posicion', 'Posicion, Almacen'
GO
--TASK24685
EXEC spADD_INDEX 'Tarima', 'Prepara', 'Posicion, Almacen)INCLUDE(Tarima'
GO

--TASK2429PGC
EXEC spALTER_TABLE 'Tarima', 'Articulo', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Tarima', 'SubCuenta', 'varchar(50)	NULL'
GO
--BUG2760
EXEC spALTER_TABLE 'Tarima', 'TipoEspecial', 'varchar(20)  NULL'

--USB Control Calidad
DECLARE
@ConstraintName VARCHAR(50),
@SQL VARCHAR(100)

SELECT @ConstraintName=sdc.name
FROM sys.default_constraints sdc
JOIN sysobjects s ON sdc.parent_object_id=s.id
JOIN syscolumns sc ON s.ID=sc.ID
WHERE parent_object_id = object_id('Tarima') 
AND parent_column_id=columnproperty(object_id('Tarima'), 'EstatusControlCalidad', 'ColumnId')
AND sc.name='EstatusControlCalidad'

IF @ConstraintName IS NOT NULL
BEGIN
	SELECT @SQL='ALTER TABLE Tarima DROP CONSTRAINT '+@ConstraintName
	EXEC(@SQL)
END
GO
EXEC spALTER_TABLE 'Tarima', 'EstatusControlCalidad', 'varchar(50) NULL'
GO

IF EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.tgAlmPosDomicilios') AND sysstat & 0xf = 8) DROP Trigger dbo.tgAlmPosDomicilios
GO
CREATE TRIGGER tgAlmPosDomicilios ON AlmPos
FOR INSERT, UPDATE
AS
BEGIN
  DECLARE @ArticuloEspI		varchar(20),
          @ArticuloEspD		varchar(20),
          @Almacen			varchar(10),
          @Posicion			varchar(10),
          @Ok				int,
          @OkRef			varchar(255),
          @Tarima			varchar(20),
          @Sucursal			int,
          @Empresa			varchar(5),
          @FechaEmision		datetime,
          @Moneda			varchar(10),
          @CambioDomicilios	bit,
		  @TipoI            varchar(10)

  IF UPDATE(ArticuloEsp)
  BEGIN
    --BUG25090
    SELECT @ArticuloEspI = ISNULL(ArticuloEsp, ''), @Almacen = Almacen, @Posicion = Posicion, @CambioDomicilios = CambioDomicilios, @TipoI=Tipo FROM Inserted --BUG2575
    SELECT @ArticuloEspD = ISNULL(ArticuloEsp, '') FROM Deleted
    SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @Almacen

	--TASK25160
	IF NOT EXISTS(SELECT * FROM EmpresaGral WHERE ISNULL(WMS,0)=1) RETURN
	SELECT @Empresa = Empresa FROM EmpresaGral WHERE ISNULL(WMS,0)=1
	
    SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
    SELECT @FechaEmision = GETDATE()
    
    EXEC spExtraerFecha @FechaEmision OUTPUT
   
    --BUG25090
    IF @CambioDomicilios IS NULL AND @ArticuloEspI <> @ArticuloEspD
    BEGIN              
      --Validamos que no haya Tarimas con existencia
      IF EXISTS(SELECT * 
                  FROM ArtDisponibleTarima 
                  JOIN Tarima ON ArtDisponibleTarima.Tarima = Tarima.Tarima AND ArtDisponibleTarima.Almacen = Tarima.Almacen
                  JOIN AlmPos ON Tarima.Posicion = AlmPos.Posicion AND Tarima.Almacen = AlmPos.Almacen
                 WHERE AlmPos.Almacen = @Almacen
                   AND AlmPos.Posicion = @Posicion
                   AND Tipo = 'Domicilio'
                   AND Disponible > 0
                  )
      BEGIN
        RAISERROR ('Existen Tarimas con Existencia para esta Posición.', 16, 1) 
        RETURN
      END
      
      --BUG25090
      --Validamos que no haya otro Domicilio para el Artículo
      IF EXISTS(SELECT * 
                  FROM ArtDisponibleTarima 
                  JOIN Tarima ON ArtDisponibleTarima.Tarima = Tarima.Tarima AND ArtDisponibleTarima.Almacen = Tarima.Almacen
                  JOIN AlmPos ON Tarima.Posicion = AlmPos.Posicion AND Tarima.Almacen = AlmPos.Almacen
                 WHERE AlmPos.Almacen = @Almacen
                   AND AlmPos.Tipo = 'Domicilio'
                   AND AlmPos.ArticuloEsp = @ArticuloEspI
                   AND AlmPos.Posicion <> @Posicion
                  ) AND @CambioDomicilios IS NULL AND @TipoI<>'Ubicacion' --BUG2575
      BEGIN
        RAISERROR ('Ya existe otro Domicilio para este Articulo.', 16, 1)         
        RETURN
      END

      --Damos de baja las Tarimas
      /*
      IF NOT EXISTS(SELECT * 
                      FROM ArtDisponibleTarima 
                      JOIN Tarima ON ArtDisponibleTarima.Tarima = Tarima.Tarima AND ArtDisponibleTarima.Almacen = Tarima.Almacen
                      JOIN AlmPos ON Tarima.Posicion = AlmPos.Posicion AND Tarima.Almacen = AlmPos.Almacen
                     WHERE AlmPos.Almacen = @Almacen
                       AND AlmPos.Posicion = @Posicion
                       AND Tipo = 'Domicilio'
                       AND Disponible > 0
                       )
      BEGIN
        UPDATE Tarima
           SET Posicion = NULL,
               Estatus  = 'BAJA',
               Alta     = NULL,
               Baja     = GETDATE()
         WHERE Posicion = @Posicion
		   AND Almacen  = @Almacen
      END
      */
      IF NULLIF(RTRIM(@ArticuloEspI), '') IS NOT NULL AND @TipoI='Domicilio' --BUG3690
      BEGIN
        --Creamos la Nueva Tarima
        IF NOT EXISTS(SELECT * 
                        FROM ArtDisponibleTarima 
                        JOIN Tarima ON ArtDisponibleTarima.Tarima = Tarima.Tarima AND ArtDisponibleTarima.Almacen = Tarima.Almacen
                        JOIN AlmPos ON Tarima.Posicion = AlmPos.Posicion AND Tarima.Almacen = AlmPos.Almacen
                       WHERE AlmPos.Almacen = @Almacen
                         AND AlmPos.Posicion = @Posicion
                         AND Tipo = 'Domicilio'
                         )
        BEGIN
          SELECT @Ok = NULL, @OkRef = NULL, @Tarima = NULL
 
          EXEC spConsecutivo 'Tarima', @Sucursal, @Tarima OUTPUT  
		  
		  --BUG2799		  
		  IF @Tarima IS NULL 
		  BEGIN
            RAISERROR ('Falta configurar Consecutivos Generales para el Tipo: Tarima.', 16, 1) 
            RETURN
          END         

          EXEC spTarimaAlta @Empresa, @Sucursal, '', @Almacen, @FechaEmision, @FechaEmision, @Tarima, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT      

          UPDATE Tarima SET Posicion = @Posicion, Articulo=@ArticuloEspI WHERE Tarima = @Tarima --BUG3781
        
          IF EXISTS(SELECT * FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Empresa = @Empresa AND Articulo <> @ArticuloEspI)
            RAISERROR ('Ya existe otro Articulo para esta Nueva Tarima.', 16, 1)         

          IF NOT EXISTS(SELECT Grupo FROM SaldoUWMS WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Grupo = @Almacen AND Cuenta = @ArticuloEspI AND SubCuenta = '' AND Rama = 'INV' AND Moneda = @Moneda AND SubGrupo = @Tarima)
            INSERT INTO SaldoUWMS(      
				     Sucursal,  Empresa, Rama,   Moneda,  Grupo,    SubGrupo,  Cuenta,       SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio)
		     SELECT @Sucursal, @Empresa, 'INV', @Moneda, @Almacen, @Tarima,   @ArticuloEspI, '',        0,     0,      0,            0,             GETDATE()        
        END      
      END

    END 

	/* Es diferente Almacen pero es el mismo articulo y la misma clave de la posición */
	IF @CambioDomicilios IS NULL AND @ArticuloEspI = @ArticuloEspD 
	  BEGIN
		  IF NULLIF(RTRIM(@ArticuloEspI), '') IS NOT NULL AND @TipoI='Domicilio'
		  BEGIN
			IF NOT EXISTS(SELECT * 
							FROM ArtDisponibleTarima 
							JOIN Tarima ON ArtDisponibleTarima.Tarima = Tarima.Tarima AND ArtDisponibleTarima.Almacen = Tarima.Almacen
							JOIN AlmPos ON Tarima.Posicion = AlmPos.Posicion AND Tarima.Almacen = AlmPos.Almacen
						   WHERE AlmPos.Almacen = @Almacen
							 AND AlmPos.Posicion = @Posicion
							 AND Tipo = 'Domicilio'
							 )
			BEGIN
			  SELECT @Ok = NULL, @OkRef = NULL, @Tarima = NULL
 
			  EXEC spConsecutivo 'Tarima', @Sucursal, @Tarima OUTPUT  
		  	  
			  IF @Tarima IS NULL 
			  BEGIN
				RAISERROR ('Falta configurar Consecutivos Generales para el Tipo: Tarima.', 16, 1) 
				RETURN
			  END         

			  EXEC spTarimaAlta @Empresa, @Sucursal, '', @Almacen, @FechaEmision, @FechaEmision, @Tarima, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT      

			  UPDATE Tarima SET Posicion = @Posicion, Articulo=@ArticuloEspI WHERE Tarima = @Tarima
        
			  IF EXISTS(SELECT * FROM ArtDisponibleTarima WHERE Tarima = @Tarima AND Almacen = @Almacen AND Empresa = @Empresa AND Articulo = @ArticuloEspI)
				RAISERROR ('Ya existe otro Articulo para esta Nueva Tarima.', 16, 1)         

			  IF NOT EXISTS(SELECT Grupo FROM SaldoUWMS WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Grupo = @Almacen AND Cuenta = @ArticuloEspI AND SubCuenta = '' AND Rama = 'INV' AND Moneda = @Moneda AND SubGrupo = @Tarima)
				INSERT INTO SaldoUWMS(      
						 Sucursal,  Empresa, Rama,   Moneda,  Grupo,    SubGrupo,  Cuenta,       SubCuenta, Saldo, SaldoU, PorConciliar, PorConciliarU, UltimoCambio)
				 SELECT @Sucursal, @Empresa, 'INV', @Moneda, @Almacen, @Tarima,   @ArticuloEspI, '',        0,     0,      0,            0,             GETDATE()        
			END      
		  END
	  END
  END
END
GO

/****** TarimaSerieLote ******/
if not exists(select * from SysTabla where SysTabla = 'TarimaSerieLote')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('TarimaSerieLote', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.TarimaSerieLote') and type = 'U') 
  CREATE TABLE dbo.TarimaSerieLote (
	Tarima			varchar(20)	NOT NULL,
    SerieLote 	    varchar(50)	NOT NULL,
    Propiedades	    varchar(20)	NULL,
    Existencia     float NULL,
	CONSTRAINT priTarimaSerieLote PRIMARY KEY  CLUSTERED (Tarima,SerieLote)
  )
GO

/****** Consecutivos TMA ******/
if not exists(select * from SysTabla where SysTabla = 'TMAC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('TMAC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.TMAC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.TMAC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priTMAC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'TMAC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'TMAC', '(ID)'
GO

-- drop table TMA
/****** TMA (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'TMA')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('TMA','Movimiento','TMA')
if not exists (select * from sysobjects where id = object_id('dbo.TMA') and type = 'U') 
BEGIN
  CREATE TABLE dbo.TMA (
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

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	Almacen			varchar(10)	NULL,
	Agente			varchar(10)	NULL,

	--REQ12615 WMS
	TarimaSurtido	varchar(20) NULL,
	Montacarga		varchar(10) NULL,
	Zona			varchar(50) NULL,
	Prioridad		varchar(10) NULL,
	FechaInicio		datetime	NULL,
	FechaFin		datetime	NULL,

	CONSTRAINT priTMA PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'TMA'
END
go
EXEC spSincroNivelRegistro @Tabla = 'TMA'
go
--REQ12615 WMS
EXEC spALTER_TABLE 'TMA','TarimaSurtido', 'varchar(20)','NULL'
EXEC spALTER_TABLE 'TMA','Agente', 'varchar(10)','NULL'
EXEC spALTER_TABLE 'TMA','Montacarga', 'varchar(10)','NULL'
EXEC spALTER_TABLE 'TMA','Zona', 'varchar(50)','NULL'
EXEC spALTER_TABLE 'TMA','Prioridad','varchar(10) NULL'
EXEC spALTER_TABLE 'TMA', 'FechaInicio', 'datetime NULL'
EXEC spALTER_TABLE 'TMA', 'FechaFin', 'datetime NULL'
GO
--BUG24697
EXEC spALTER_TABLE 'TMA', 'SucursalFiltro', 'int NULL'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TMA' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia    ON dbo.TMA (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TMA' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.TMA (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TMA' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.TMA (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TMA' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.TMA (Mov, Estatus, Sucursal, Empresa, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TMA' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.TMA (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TMA' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.TMA (Usuario)
GO
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TMA' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX TMA.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TMA' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX TMA.Situacion2
GO

if exists (select * from sysobjects where id = object_id('dbo.tgTMAA') and sysstat & 0xf = 8) drop trigger dbo.tgTMAA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTMAC') and sysstat & 0xf = 8) drop trigger dbo.tgTMAC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTMAB') and sysstat & 0xf = 8) drop trigger dbo.tgTMAB
GO
EXEC spModificarPK_Mov 'TMA'
GO
EXEC spSincroNivelRegistroCampos 'TMA'
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TMA' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON TMA (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TMA' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON TMA (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TMA' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON TMA (OrigenID,Origen,Empresa)
go

-- Aqui va el Matenimiento a la tabla

GO
CREATE TRIGGER tgTMAC ON TMA
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
  
  SELECT @Modulo = 'TMA'
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
/*  IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE TMA SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL */
END
GO
CREATE TRIGGER tgTMAB ON TMA
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
    EXEC spMovAlEliminar 'TMA', @ID
END
GO

-- drop table TMAD
/****** TMAD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'TMAD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('TMAD','Movimiento','TMA')
if not exists (select * from sysobjects where id = object_id('dbo.TMAD') and type = 'U') 
CREATE TABLE dbo.TMAD (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

/*	Aplica			varchar(20)	NULL,
	AplicaID		varchar(20)	NULL,*/
	Tarima			varchar(20)	NULL,
	Almacen			varchar(10)	NULL,
	Posicion		varchar(10)	NULL,
	PosicionDestino		varchar(10)	NULL,
	EstaPendiente		bit		NULL	DEFAULT 0,

	--REQ12615 WMS
    Zona				varchar(50) NULL,
	CantidadPicking		float NULL,
	CantidadA			float NULL,
	CantidadPendiente	float NULL,
	Procesado			bit   NULL	DEFAULT 0,
	Estado				varchar(50) NULL,
	Aplica				varchar(20)	NULL,
	AplicaID			varchar(20)	NULL,
	AplicaRenglon		float		NULL,
	AplicaRenglonID		int			NULL,
	TarimaPCK			varchar(20) NULL,
	CapacidadPosicion	bit	  NULL	DEFAULT 0,
	Prioridad			varchar(10) NULL,
	Montacarga			varchar(10) NULL,
	Unidad				varchar(50) NULL, --REQ 14684
	CantidadUnidad		float		NULL, --REQ 14684

	CONSTRAINT priTMAD PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'TMAD', '(ID, Renglon)'
GO
--REQ12615 WMS
EXEC spALTER_TABLE 'TMAD','Zona', 'varchar(50)','NULL'
EXEC spALTER_TABLE 'TMAD','CantidadPicking', 'float','NULL'
EXEC spALTER_TABLE 'TMAD','CantidadA', 'float','NULL'
EXEC spALTER_TABLE 'TMAD','CantidadPendiente', 'float','NULL'
EXEC spALTER_TABLE 'TMAD','Procesado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'TMAD','Estado','varchar(50) NULL'
EXEC spALTER_TABLE 'TMAD','Aplica', 'varchar(20)','NULL'
EXEC spALTER_TABLE 'TMAD','AplicaID', 'varchar(20)','NULL'
EXEC spALTER_TABLE 'TMAD','AplicaRenglon', 'float','NULL'
EXEC spALTER_TABLE 'TMAD','AplicaRenglonID', 'int','NULL'
EXEC spALTER_TABLE 'TMAD','TarimaPCK', 'varchar(20)','NULL'
EXEC spALTER_TABLE 'TMAD','Prioridad', 'varchar(10)','NULL'
EXEC spALTER_TABLE 'TMAD','CapacidadPosicion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'TMAD','Prioridad','varchar(10) NULL'
EXEC spALTER_TABLE 'TMAD','Montacarga', 'varchar(10)','NULL'
GO
EXEC spALTER_TABLE 'TMAD','Unidad','varchar(50) NULL' --REQ 14684
EXEC spALTER_TABLE 'TMAD','CantidadUnidad','float NULL' --REQ 14684
GO
--BUG24589
EXEC spALTER_TABLE 'TMAD', 'TarimaM', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'TMAD', 'Es50', 'bit NULL'
GO
EXEC spALTER_TABLE 'TMAD', 'Es50TarimaDom', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'TMAD', 'Es50Cantidad', 'float NULL'
GO
EXEC spALTER_TABLE 'TMAD', 'FechaCaducidad', 'datetime NULL'
GO
--TASK2429PGC
EXEC spALTER_TABLE 'TMAD', 'Articulo', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'TMAD', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'TMAD', 'ArtCambioClave', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'TMAD', 'GeneradoEnMovil', 'bit	NULL Default 0'
EXEC spALTER_TABLE 'TMAD', 'ProcesadoEnMovil', 'bit	NULL Default 0'
GO
/****** cTMAD ******/
if exists (select * from sysobjects where id = object_id('dbo.cTMAD') and sysstat & 0xf = 2) drop view dbo.cTMAD
GO
CREATE VIEW cTMAD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Sucursal,
  SucursalOrigen,
  /*Aplica,
  AplicaID,*/
  Tarima,
  Almacen,
  Posicion,
  PosicionDestino,
  EstaPendiente,
  Unidad, --REQ 14684
  CantidadUnidad --REQ 14684

FROM
  TMAD
GO

-- drop table EntarimarMov
/****** EntarimarMov ******/
if not exists(select * from SysTabla where SysTabla = 'EntarimarMov')
INSERT INTO SysTabla (SysTabla) VALUES ('EntarimarMov')
if not exists (select * from sysobjects where id = object_id('dbo.EntarimarMov') and type = 'U') 
  CREATE TABLE dbo.EntarimarMov (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Renglon			float		NOT NULL,
        RenglonSub		int		NOT NULL,
	RenglonID		int		NULL,
	Almacen			varchar(10)	NULL,
	Tarima			varchar(20)	NULL,
	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,

	CantidadA		float		NULL,
	
	CONSTRAINT priEntarimarMov PRIMARY KEY  CLUSTERED (Estacion, ID)
  )
GO
EXEC spALTER_TABLE 'EntarimarMov', 'RenglonID', 'int NULL'
EXEC spADD_INDEX 'EntarimarMov', 'ID', 'Renglon, RenglonSub, ID'
GO

-- SerieLoteMov
-- select * from EntarimarMovSerieLote 
-- drop table EntarimarMovSerieLote 
/****** EntarimarMovSerieLote ******/
if not exists(select * from SysTabla where SysTabla = 'EntarimarMovSerieLote')
INSERT INTO SysTabla (SysTabla) VALUES ('EntarimarMovSerieLote')
if not exists (select * from sysobjects where id = object_id('dbo.EntarimarMovSerieLote') and type = 'U') 
  CREATE TABLE dbo.EntarimarMovSerieLote (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	RenglonID		int		NOT NULL,
	Articulo		varchar(20)	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,
	SerieLote		varchar(50)	NOT NULL,

	Cantidad		float		NULL,
	CantidadA		float		NULL,
	
	CONSTRAINT priEntarimarMovSerieLote PRIMARY KEY  CLUSTERED (Estacion, ID)
  )
GO
EXEC spALTER_TABLE 'EntarimarMovSerieLote', 'Propiedades', 'varchar (20) NULL'
GO
-- drop table EntarimarTarima
/****** EntarimarTarima ******/
if not exists(select * from SysTabla where SysTabla = 'EntarimarTarima')
INSERT INTO SysTabla (SysTabla) VALUES ('EntarimarTarima')
if not exists (select * from sysobjects where id = object_id('dbo.EntarimarTarima') and type = 'U') 
  CREATE TABLE dbo.EntarimarTarima (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Renglon			float		NOT NULL,
        RenglonSub		int		NOT NULL,
	RenglonID		int		NULL,
	Almacen			varchar(10)	NULL,
	Tarima			varchar(20)	NULL,
	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,

	CONSTRAINT priEntarimarTarima PRIMARY KEY  CLUSTERED (Estacion, ID)
  )
GO
EXEC spALTER_TABLE 'EntarimarTarima', 'RenglonID', 'int NULL'
EXEC spADD_INDEX 'EntarimarTarima', 'ID', 'Renglon, RenglonSub, ID'
GO

-- drop table EntarimarTarimaSerieLote
/****** EntarimarTarimaSerieLote ******/
if not exists(select * from SysTabla where SysTabla = 'EntarimarTarimaSerieLote')
INSERT INTO SysTabla (SysTabla) VALUES ('EntarimarTarimaSerieLote')
if not exists (select * from sysobjects where id = object_id('dbo.EntarimarTarimaSerieLote') and type = 'U') 
  CREATE TABLE dbo.EntarimarTarimaSerieLote (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	RenglonID		int		NOT NULL,
	Articulo		varchar(20)	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,
	SerieLote		varchar(50)	NOT NULL,
	Tarima			varchar(20)	NULL,

	Cantidad		float		NULL,
	
	CONSTRAINT priEntarimarTarimaSerieLote PRIMARY KEY  CLUSTERED (Estacion, ID)
  )
GO
EXEC spALTER_TABLE 'EntarimarTarimaSerieLote', 'Propiedades', 'varchar (20) NULL'
GO
-- drop table SurtirTarimaMov
/****** SurtirTarimaMov ******/
if not exists(select * from SysTabla where SysTabla = 'SurtirTarimaMov')
INSERT INTO SysTabla (SysTabla) VALUES ('SurtirTarimaMov')
if not exists (select * from sysobjects where id = object_id('dbo.SurtirTarimaMov') and type = 'U') 
  CREATE TABLE dbo.SurtirTarimaMov (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Almacen			varchar(10)	NULL,
	Posicion		varchar(10)	NULL,
	Tarima			varchar(20)	NULL,
	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	
	CONSTRAINT priSurtirTarimaMov PRIMARY KEY  CLUSTERED (Estacion, ID)
  )
GO

--REQ12615 WMS
/****** WMSModuloMovimiento ******/
if not exists(select * from SysTabla where SysTabla = 'WMSModuloMovimiento')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('WMSModuloMovimiento','Maestro','TMA')
if not exists (select * from sysobjects where id = object_id('dbo.WMSModuloMovimiento') and type = 'U') 
CREATE TABLE dbo.WMSModuloMovimiento (
    Modulo		varchar(5)  NOT NULL,
    Movimiento  varchar(20) NOT NULL,
    Clave		varchar(20) NOT NULL,

    SubClave	varchar(20)		NULL,
	Estatus		varchar(15)		NULL

	CONSTRAINT priWMSModuloMovimiento PRIMARY KEY CLUSTERED (Modulo, Movimiento, Clave)
)
go

--REQ12615 WMS
/****** WMSModuloTarima ******/
if not exists(select * from SysTabla where SysTabla = 'WMSModuloTarima')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('WMSModuloTarima','Maestro','TMA')
if not exists (select * from sysobjects where id = object_id('dbo.WMSModuloTarima') and type = 'U') 
CREATE TABLE dbo.WMSModuloTarima (
    ID					int			IDENTITY,

    IDModulo			int			NULL,
    Modulo				varchar(5)	NULL,
    Renglon				float		NULL,
    RenglonSub			int			NULL,
    Cantidad			float		NULL,
    Tarima				varchar(20)	NULL,
    IDTMA				int			NULL,
    PosicionDestino		varchar(10)	NULL,
	Articulo			varchar(50)	NULL,
	Almacen				varchar(10)	NULL,
	AlmacenDestino		varchar(10) NULL,
	TarimaSurtido		varchar(20)	NULL,
	Utilizar			bit		DEFAULT 0,
	Unidad				varchar(50) NULL, --REQ 14684
	CantidadUnidad		float		NULL, --REQ 14684

	CONSTRAINT priWMSModuloTarima PRIMARY KEY CLUSTERED (ID)
)
go
EXEC spALTER_TABLE 'WMSModuloTarima','Unidad','varchar(50) NULL' --REQ 14684
EXEC spALTER_TABLE 'WMSModuloTarima','CantidadUnidad','float NULL' --REQ 14684
GO
EXEC spALTER_TABLE 'WMSModuloTarima','SubCuenta', 'varchar(50) NULL' --TASK2429PGC
GO

--REQ12615 WMS
/****** WMSSurtidoProcesar ******/
if not exists(select * from SysTabla where SysTabla = 'WMSSurtidoProcesar')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('WMSSurtidoProcesar','N/A','TMA')
if not exists (select * from sysobjects where id = object_id('dbo.WMSSurtidoProcesar') and type = 'U') 
CREATE TABLE dbo.WMSSurtidoProcesar (
    Estacion		int			NOT NULL,
    ID				int			NOT NULL,

    Articulo		varchar(20)		NULL,
    Tarima			varchar(20)		NULL,
    Tipo			varchar(20)		NULL,
    PosicionOrigen	varchar(10)		NULL,
    PosicionDestino	varchar(10)		NULL,
    Acomodador		varchar(10)		NULL,
    CantidadTarima	float			NULL,
    Zona			varchar(50)		NULL,
    Procesado		int			DEFAULT 0,

	CONSTRAINT priWMSSurtidoProcesar PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

--REQ12615 WMS
/****** WMSSurtidoProcesarD ******/
if not exists(select * from SysTabla where SysTabla = 'WMSSurtidoProcesarD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('WMSSurtidoProcesarD','N/A','TMA')
if not exists (select * from sysobjects where id = object_id('dbo.WMSSurtidoProcesarD') and type = 'U') 
CREATE TABLE dbo.WMSSurtidoProcesarD (
    Estacion		int			NULL,
    Articulo		varchar(20)	NULL,
	Almacen			varchar(10)	NULL,
    Tarima			varchar(20)	NULL,
    Tipo			varchar(20)	NULL,
    PosicionOrigen	varchar(10)	NULL,
    PosicionDestino	varchar(10)	NULL,
    Acomodador		varchar(10)	NULL,
    CantidadTarima	float		NULL,
    Zona			varchar(50)	NULL,
	Referencia		varchar(50) NULL,
    Procesado		int			DEFAULT 0,
	Unidad			varchar(50) NULL, --REQ 14684
	CantidadUnidad	float		NULL --REQ 14684
)
go
EXEC spALTER_TABLE 'WMSSurtidoProcesarD','Unidad','varchar(50) NULL' --REQ 14684
EXEC spALTER_TABLE 'WMSSurtidoProcesarD','CantidadUnidad','float NULL' --REQ 14684
GO
--TASK24685
EXEC spDROP_COLUMN 'WMSSurtidoProcesarD', 'SucursalDestino'
EXEC spALTER_TABLE 'WMSSurtidoProcesarD', 'SucursalFiltro', 'int NULL'
GO
EXEC spALTER_TABLE 'WMSSurtidoProcesarD', 'Modulo', 'varchar(5) NULL'
EXEC spALTER_TABLE 'WMSSurtidoProcesarD', 'ModuloID', 'int NULL'
GO
--TASK2429PGC
EXEC spALTER_TABLE 'WMSSurtidoProcesarD','SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'WMSSurtidoProcesarD','TarimaFechaCaducidad', 'datetime NULL'
EXEC spALTER_TABLE 'WMSSurtidoProcesarD','SerieLote', 'varchar(50) NULL'
GO
--TASK6535
EXEC spALTER_TABLE 'WMSSurtidoProcesarD', 'PCKUbicacion', 'int NULL'
GO

EXEC spALTER_TABLE 'WMSSurtidoProcesarD', 'Mov', 'varchar(20) NULL'
GO

EXEC spALTER_TABLE 'WMSSurtidoProcesarD', 'MovID', 'varchar(20) NULL'
GO

--REQ12615 WMS
/****** WMSLista ******/
if not exists(select * from SysTabla where SysTabla = 'WMSLista')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('WMSLista','N/A','TMA')
if not exists (select * from sysobjects where id = object_id('dbo.WMSLista') and type = 'U') 
CREATE TABLE dbo.WMSLista (
    Estacion		int			NULL,
	Modulo			char(5)		NULL,
    IDModulo		int			NULL,
    Articulo		varchar(20)	NULL,
    Cantidad		float		NULL,
	Unidad			varchar(50) NULL, --REQ 14684
	CantidadUnidad	float		NULL --REQ 14684
)
go
EXEC spALTER_TABLE 'WMSLista','Unidad','varchar(50) NULL' --REQ 14684
EXEC spALTER_TABLE 'WMSLista','CantidadUnidad','float NULL' --REQ 14684
GO
EXEC spALTER_TABLE 'WMSLista','SubCuenta', 'varchar(50) NULL' --TASK2429PGC
GO
--REQ12615 WMS
/****** Tarimas Chep  ******/
if not exists(select * from SysTabla where SysTabla = 'CteTarimaChep')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteTarimaChep','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteTarimaChep') and type = 'U') 
CREATE TABLE dbo.CteTarimaChep (
	Cliente				varchar(10) NOT NULL,
	Articulo			varchar(20) NOT NULL,
	UnidadVenta			varchar(50) NOT NULL,
	TarimaChep			varchar(20)		NULL,
	CantidadTarima		int				NULL,
	CantidadEstibas		int				NULL,

	CONSTRAINT priCteTarimaChep PRIMARY KEY CLUSTERED (Cliente, Articulo, UnidadVenta)
)
GO

--REQ12615 WMS
/************************** WMSMontacargaTarea  ****************************************/
if not exists(select * from SysTabla where SysTabla = 'WMSMontacargaTarea')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('WMSMontacargaTarea','N/A','WMS')
if not exists (select * from sysobjects where id = object_id('dbo.WMSMontacargaTarea') and type = 'U') 
CREATE TABLE dbo.WMSMontacargaTarea (
            Estacion		int			NOT NULL,
            IDLista			int			IDENTITY,
            ID				int			NOT NULL,
            Renglon			float			NULL,
            Mov				varchar(20)		NULL,
            MovID			varchar(20)		NULL,
            FechaEmision	datetime		NULL,
            Tarima			varchar(20)	NOT NULL,
            Articulo		varchar(20)		NULL,            
            Montacarga		varchar(20)		NULL,
            Prioridad		varchar(10)		NULL,
            Almacen			varchar(20)		NULL,
            Modificar		bit				NULL,
            Clave			varchar(20)		NULL,
            Movimiento		varchar(30)		NULL,
            Empresa			char(5)			NULL,
            Zona			varchar(50)		NULL,   

			--TASK25101         
			Pasillo         varchar(20)     NULL,
			PosicionOrigen  varchar(10)     NULL,
			PosicionDestino varchar(10)     NULL,
			Sucursal        int             NULL,
			NomSucursal     varchar(50)     NULL,
			NoCajas         float           NULL
            )
GO
--TASK25101
EXEC spALTER_TABLE 'WMSMontacargaTarea','Pasillo', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'WMSMontacargaTarea','PosicionOrigen','varchar(10) NULL'
GO
EXEC spALTER_TABLE 'WMSMontacargaTarea','PosicionDestino','varchar(10) NULL'
GO
EXEC spALTER_TABLE 'WMSMontacargaTarea','Sucursal','int NULL'
GO
EXEC spALTER_TABLE 'WMSMontacargaTarea','NomSucursal','varchar(50) NULL'
GO
EXEC spALTER_TABLE 'WMSMontacargaTarea','NoCajas','float NULL'
GO

--REQ12615 WMS
/************************** WMSSurtidoPendiente  ****************************************/
if not exists(select * from SysTabla where SysTabla = 'WMSSurtidoPendiente')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('WMSSurtidoPendiente','N/A','WMS')
if not exists (select * from sysobjects where id = object_id('dbo.WMSSurtidoPendiente') and type = 'U') 
 CREATE TABLE WMSSurtidoPendiente(
            Estacion		int			NOT NULL,
            Articulo		varchar(20)	NOT NULL,
            Almacen			varchar(20)	NOT NULL,
            Cantidad		float		NULL,
    CONSTRAINT priWMSSurtidoPendiente PRIMARY KEY (Estacion, Articulo, Almacen)
	)
GO
--UserStory4417
EXEC spALTER_TABLE 'WMSSurtidoPendiente  ','SubCuenta','varchar(50) NULL'
GO
EXEC spALTER_TABLE 'WMSSurtidoPendiente', 'Mov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'WMSSurtidoPendiente', 'MovID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'WMSSurtidoPendiente', 'ID', 'int NULL'
EXEC spALTER_TABLE 'WMSSurtidoPendiente', 'Modulo', 'varchar(5) NULL'
GO

--REQ12615 WMS
/************************** WMSLoteMovimiento  ****************************************/
if not exists(select * from SysTabla where SysTabla = 'WMSLoteMovimiento')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('WMSLoteMovimiento','N/A','WMS')
if not exists (select * from sysobjects where id = object_id('dbo.WMSLoteMovimiento') and type = 'U') 
CREATE TABLE dbo.WMSLoteMovimiento (
            Estacion		int			NOT NULL,
            IDLista			int			IDENTITY,
            ID				int			NOT NULL,
            Empresa			char(5)			NULL,
            Movimiento		varchar(50)		NULL,
            FechaEmision	datetime		NULL,
            Almacen			varchar(50)		NULL,
            Tarima			varchar(50)	    NULL,
            Cantidad		float			NULL,
            PosicionOrigen	varchar(50)		NULL,
            PosicionDestino	varchar(50)		NULL,            
            Articulo		varchar(50)		NULL,            
            Descripcion		varchar(100)	NULL,
            CantidadA		float			NULL,
            Zona			varchar(50)		NULL,
            Pasillo			varchar(50)		NULL,
            Fila			varchar(50)		NULL,
            Nivel			varchar(50)		NULL,
            Mov				varchar(20)		NULL,
            Clave			varchar(20)		NULL,
            SubClave		varchar(20)		NULL,
            Renglon			float			NULL,
            Acomodador		varchar(20)		NULL,
            Montacarga		varchar(20)		NULL
            )  
GO
EXEC spALTER_TABLE 'WMSLoteMovimiento', 'SubCuenta', 'varchar(50)	NULL' --BUG3799
GO

--REQ12615 WMS
/****** MapeoMovMovil ******/
if not exists(select * from SysTabla where SysTabla = 'MapeoMovMovil')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MapeoMovMovil','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MapeoMovMovil') and type = 'U') 
CREATE TABLE dbo.MapeoMovMovil (

	Mov     	 				varchar(20)	NULL,
	Modulo						varchar(5)	NULL,
	RequiereMontacarga			bit	NULL,
	MovTransito					varchar(20) NULL,
	MovFinal					varchar(20) NULL
)
GO

--REQ12615 WMS
/****** SerieLoteMovMovil ******/
if not exists(select * from SysTabla where SysTabla = 'SerieLoteMovMovil')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SerieLoteMovMovil','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SerieLoteMovMovil') and type = 'U') 
CREATE TABLE dbo.SerieLoteMovMovil (
	Empresa			varchar(5)		NOT NULL,
	Modulo			varchar(5) 	NOT NULL,
	ID			int		NOT NULL,
	RenglonID		int		NOT NULL,
	Articulo		varchar(20) 	NOT NULL,
	SubCuenta		varchar(50)	    NOT NULL DEFAULT '',
	SerieLote		varchar(50)	NOT NULL,

	Cantidad		float		NULL	 DEFAULT 1.0,
	CantidadAlterna		float		NULL,
	Propiedades		varchar(20)	NULL,
	Ubicacion		int		NULL,
	Cliente			varchar(10)	NULL,
	Localizacion		varchar(10)	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	ArtCostoInv		money		NULL,
	Procesado		bit			NULL DEFAULT 0,	
	Tarima			varchar(20) NULL,

	CONSTRAINT priSerieLoteMovMovil PRIMARY KEY CLUSTERED (ID, RenglonID, Articulo, SubCuenta, SerieLote, Modulo, Empresa)
)
GO

--REQ12615 WMS
/****** FechaCaducidadMovil ******/
if not exists(select * from SysTabla where SysTabla = 'FechaCaducidadMovil')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FechaCaducidadMovil','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.FechaCaducidadMovil') and type = 'U') 
CREATE TABLE dbo.FechaCaducidadMovil (
	Empresa			varchar(5)		NOT NULL,
	Modulo			varchar(5) 		NOT NULL,
	ID				int				NOT NULL,
	RenglonID		int				NOT NULL,
	Articulo		varchar(20) 	NOT NULL,
	SubCuenta		varchar(20) 	NOT NULL,
	
	Cantidad		float		 	    NULL,
	FechaCaducidad	datetime			NULL,
	Procesado		bit					NULL DEFAULT 0,	

	CONSTRAINT priFechaCaducidadMovil PRIMARY KEY CLUSTERED (ID, RenglonID, Articulo, Modulo, Empresa)
)
GO

/**************** spEntarimarMovSerieLoteTodo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEntarimarMovSerieLoteTodo') and type = 'P') drop procedure dbo.spEntarimarMovSerieLoteTodo
GO
CREATE PROCEDURE spEntarimarMovSerieLoteTodo
			@Estacion	int,
			@RenglonID	int,
			@Articulo	varchar(20),
			@SubCuenta	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  UPDATE EntarimarMovSerieLote
     SET CantidadA = Cantidad
   WHERE Estacion = @Estacion AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = ISNULL(NULLIF(@SubCuenta, '0'), '')
  RETURN
END
GO

/**************** fnUnidadMinima ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnUnidadMinima ') DROP FUNCTION fnUnidadMinima 
GO
CREATE FUNCTION fnUnidadMinima (@Articulo varchar(20))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Unidad    varchar(20),
    @UnidadCompra    varchar(20),
    @UnidadTraspaso    varchar(20),
    @Resultado varchar(20)
    SELECT @Unidad = Unidad,
           @UnidadCompra = UnidadCompra,
           @UnidadTraspaso = UnidadTraspaso
      FROM Art
     WHERE Articulo = @Articulo

  SELECT @Resultado = ''
  
  IF @Resultado = '' AND EXISTS (SELECT * FROM Unidad WHERE Factor = 1 AND Unidad = @Unidad)
    SET @Resultado = @Unidad
  IF @Resultado = '' AND EXISTS (SELECT * FROM Unidad WHERE Factor = 1 AND Unidad = @UnidadCompra)
    SET @Resultado = @UnidadCompra
  IF @Resultado = '' AND EXISTS (SELECT * FROM Unidad WHERE Factor = 1 AND Unidad = @UnidadTraspaso)
    SET @Resultado = @UnidadTraspaso

  IF ISNULL(@Resultado,'') = ''
    SELECT @Resultado = Unidad 
      FROM Unidad 
     WHERE Factor = 1

  IF @Articulo IS NOT NULL 
    SELECT @Resultado = Unidad
      FROM Art 
     WHERE Articulo = @Articulo

  RETURN(@Resultado)
END
GO
/**************** fnArtUnidadMinima ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnArtUnidadMinima ') DROP FUNCTION fnArtUnidadMinima 
GO
CREATE FUNCTION fnArtUnidadMinima (@Empresa varchar(5), @Articulo varchar(20))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(50),
    @CfgMultiUnidadesNivel	varchar(20)

  SELECT @CfgMultiUnidadesNivel = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  SELECT @Resultado = NULL
  IF @CfgMultiUnidadesNivel = 'ARTICULO'
    SELECT @Resultado = NULLIF(Unidad, '')
      FROM ArtUnidad 
     WHERE Articulo = @Articulo AND Factor = 1

  IF @Resultado IS NULL
    SELECT @Resultado = dbo.fnUnidadMinima(@Articulo)

  RETURN(@Resultado)
END
GO

/**************** spEntarimar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEntarimar') and type = 'P') drop procedure dbo.spEntarimar
GO
CREATE PROCEDURE spEntarimar
							@Estacion	int,
							@Empresa	varchar(5),
							@Modulo		varchar(5),
							@ModuloID	int,
							@Mov		varchar(20),
							@MovID		varchar(20),
							@Accion		varchar(20),
							@Tarima		varchar(20)	= NULL,
							@ID		    int		= NULL,
							@Conexion	bit		= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon					float,
    @UltRenglon					float,
    @RenglonSub					int,
    @RenglonSubN				int,
    @UltRenglonSub				int,
    @Almacen					varchar(10), 
    @Articulo					varchar(20), 
    @SubCuenta					varchar(50),
    @Posicion					varchar(10), 
    @Cantidad					float, 
    @Unidad						varchar(50), 
    @CantidadA					float,
    @RenglonID					int,
    @MAXRenglonID				int,
    @MovTipo					varchar(20),
    @CfgSeriesLotesMayoreo	    bit,
    @CfgSeriesLotesAutoOrden	varchar(20),
    @Sucursal					int,
    @AlmTipo					varchar(20),
    @ArtTipo					varchar(20),
    @Factor						float,
    @SerieLote					varchar(50),
    @SeriesLotesAutoOrden	    varchar(50),
    @Ok							int,
    @OkRef						varchar(255), --REQ12615 WMS
    @NivelFactorMultiUnidad		varchar(20), --REQ12615 WMS
    @SerieLoteAnterior			varchar(50), --REQ12615 WMS
    @ArtUnidadN					varchar(50),
    @Propiedades				varchar(20),
	@TipoOpcion				    varchar(20), -- Bug 3682
	@Origen                     varchar(20),
    @OrigenID                   varchar(20),
    @OrigenO                    varchar(20),
    @OrigenIDO                  varchar(20)
    
  IF @Modulo NOT IN ('VTAS', 'COMS', 'INV', 'PROD') RETURN
  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @Accion = UPPER(@Accion), @Tarima = NULLIF(RTRIM(@Tarima), ''), @ID = NULLIF(@ID, 0)
  SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  SELECT @CfgSeriesLotesMayoreo = SeriesLotesMayoreo FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @CfgSeriesLotesAutoOrden = ISNULL(UPPER(RTRIM(SeriesLotesAutoOrden)), 'NO')
    FROM EmpresaCfg
   WHERE Empresa = @Empresa
  
   --REQ12615 WMS
  SELECT @NivelFactorMultiUnidad = NivelFactorMultiUnidad
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF @Conexion = 0
    BEGIN TRANSACTION 

  IF @Accion = 'SELECCIONAR/TODO'
  BEGIN
    UPDATE EntarimarMov
       SET CantidadA = Cantidad
     WHERE Estacion = @Estacion

    UPDATE EntarimarMovSerieLote
       SET CantidadA = Cantidad
     WHERE Estacion = @Estacion 
  END ELSE
  IF @Accion = 'SUGERIR'
  BEGIN
    DELETE EntarimarMov             WHERE Estacion = @Estacion
    DELETE EntarimarMovSerieLote    WHERE Estacion = @Estacion
    DELETE EntarimarTarima          WHERE Estacion = @Estacion
    DELETE EntarimarTarimaSerieLote WHERE Estacion = @Estacion
 

    IF @Modulo = 'VTAS'
    BEGIN
      INSERT EntarimarMov (
             Estacion,  Renglon, RenglonSub, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Unidad)
      SELECT @Estacion, Renglon, RenglonSub, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Unidad
        FROM VentaD
       WHERE ID = @ModuloID
--Task 8036
      INSERT EntarimarMovSerieLote (
             Estacion,  RenglonID,     Articulo,     SubCuenta,     SerieLote,     Cantidad, Propiedades)
      SELECT @Estacion, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Cantidad, slm.Propiedades
        FROM SerieLoteMov slm
        JOIN VentaD d ON d.ID = slm.ID AND d.RenglonID = slm.RenglonID AND d.Articulo = slm.Articulo AND ISNULL(d.SubCuenta, '') = slm.SubCuenta
        JOIN Art a ON a.Articulo=d.Articulo --TASK3288
       WHERE slm.Modulo = @Modulo AND slm.ID = @ModuloID
         AND a.SerieLoteInfo=0 --TASK3288

      DECLARE crEntarimar CURSOR LOCAL FOR
       SELECT Sucursal, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Factor
         FROM VentaD
        WHERE ID = @ModuloID
    END ELSE
    IF @Modulo = 'INV'
    BEGIN
      INSERT EntarimarMov (
             Estacion,  Renglon, RenglonSub, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Unidad)
      --SELECT @Estacion, Renglon, RenglonSub, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Unidad
	   SELECT @Estacion, Renglon, RenglonSub, RenglonID, Almacen, Tarima, Articulo, SubCuenta, CASE WHEN ISNULL(CantidadInventario,0) = 0 THEN Cantidad ELSE CantidadInventario END, Unidad --BUg 4189
        FROM InvD
       WHERE ID = @ModuloID AND Seccion IS NULL
--Task 8036
      INSERT EntarimarMovSerieLote (
             Estacion,  RenglonID,     Articulo,     SubCuenta,     SerieLote,     Cantidad, Propiedades)
      SELECT @Estacion, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Cantidad, slm.Propiedades
        FROM SerieLoteMov slm
        JOIN InvD d ON d.ID = slm.ID AND d.RenglonID = slm.RenglonID AND d.Articulo = slm.Articulo AND ISNULL(d.SubCuenta, '') = slm.SubCuenta
        JOIN Art a ON a.Articulo=d.Articulo --TASK3288
       WHERE slm.Modulo = @Modulo AND slm.ID = @ModuloID AND Seccion IS NULL
         AND a.SerieLoteInfo=0 --TASK3288


      DECLARE crEntarimar CURSOR LOCAL FOR
       --SELECT Sucursal, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Factor
	   SELECT Sucursal, RenglonID, Almacen, Tarima, Articulo, SubCuenta, CASE WHEN ISNULL(CantidadInventario,0) = 0 THEN Cantidad ELSE CantidadInventario END, Factor --Bug 4189
         FROM InvD
        WHERE ID = @ModuloID AND Seccion = NULL
    END ELSE
    IF @Modulo = 'COMS'
    BEGIN
      INSERT EntarimarMov (
             Estacion,  Renglon, RenglonSub, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Unidad)
      --SELECT @Estacion, Renglon, RenglonSub, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Unidad
	  SELECT @Estacion, Renglon, RenglonSub, RenglonID, Almacen, Tarima, Articulo, SubCuenta, CASE WHEN ISNULL(CantidadInventario,0) = 0 THEN Cantidad ELSE CantidadInventario END, Unidad --Bug 4189
        FROM CompraD
       WHERE ID = @ModuloID
--Task 8036
      INSERT EntarimarMovSerieLote (
             Estacion,  RenglonID,     Articulo,     SubCuenta,     SerieLote,     Cantidad, Propiedades)
      SELECT @Estacion, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Cantidad, slm.Propiedades
        FROM SerieLoteMov slm
        JOIN CompraD d ON d.ID = slm.ID AND d.RenglonID = slm.RenglonID AND d.Articulo = slm.Articulo AND ISNULL(d.SubCuenta, '') = slm.SubCuenta
        JOIN Art a ON a.Articulo=d.Articulo --TASK3288
       WHERE slm.Modulo = @Modulo AND slm.ID = @ModuloID
         AND a.SerieLoteInfo=0 --TASK3288

      DECLARE crEntarimar CURSOR LOCAL FOR
       SELECT Sucursal, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Factor
         FROM CompraD
        WHERE ID = @ModuloID
    END ELSE
    IF @Modulo = 'PROD'
    BEGIN
      INSERT EntarimarMov (
             Estacion,  Renglon, RenglonSub, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Unidad)
      SELECT @Estacion, Renglon, RenglonSub, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Unidad
        FROM ProdD
       WHERE ID = @ModuloID
--Task 8036
      INSERT EntarimarMovSerieLote (
             Estacion,  RenglonID,     Articulo,     SubCuenta,     SerieLote,     Cantidad, Propiedades)
      SELECT @Estacion, slm.RenglonID, slm.Articulo, slm.SubCuenta, slm.SerieLote, slm.Cantidad, slm.Propiedades
        FROM SerieLoteMov slm
        JOIN ProdD d ON d.ID = slm.ID AND d.RenglonID = slm.RenglonID AND d.Articulo = slm.Articulo AND ISNULL(d.SubCuenta, '') = slm.SubCuenta
        JOIN Art a ON a.Articulo=d.Articulo --TASK3288
       WHERE slm.Modulo = @Modulo AND slm.ID = @ModuloID
         AND a.SerieLoteInfo=0 --TASK3288

      DECLARE crEntarimar CURSOR LOCAL FOR
       SELECT Sucursal, RenglonID, Almacen, Tarima, Articulo, SubCuenta, Cantidad, Factor
         FROM ProdD
        WHERE ID = @ModuloID
    END

    OPEN crEntarimar
    FETCH NEXT FROM crEntarimar INTO @Sucursal, @RenglonID, @Almacen, @Tarima, @Articulo, @SubCuenta, @Cantidad, @Factor
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @AlmTipo = UPPER(Tipo)
          FROM Alm 
         WHERE Almacen = @Almacen
        SELECT @ArtTipo = UPPER(Tipo),
               @SeriesLotesAutoOrden = ISNULL(NULLIF(NULLIF(RTRIM(UPPER(SeriesLotesAutoOrden)), ''), '(EMPRESA)'), @CfgSeriesLotesAutoOrden)
          FROM Art
         WHERE Articulo = @Articulo

        IF @ArtTipo IN ('SERIE', 'LOTE', 'VIN', 'PARTIDA') AND @CfgSeriesLotesMayoreo = 1 
         EXEC spSeriesLotesSurtidoAuto @Sucursal, @Empresa, @Modulo, 1, 0,
				       @ModuloID,  @RenglonID, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Factor,
				       @AlmTipo, @SeriesLotesAutoOrden,	
                                       @Ok OUTPUT, @OkRef OUTPUT, @Tarima = @Tarima
      END
      FETCH NEXT FROM crEntarimar INTO @Sucursal, @RenglonID, @Almacen, @Tarima, @Articulo, @SubCuenta, @Cantidad, @Factor
    END
    CLOSE crEntarimar
    DEALLOCATE crEntarimar
  END ELSE
  IF @Accion = 'ENTARIMAR' AND @Tarima IS NOT NULL
  BEGIN
    DECLARE crEntarimar CURSOR LOCAL FOR
     --REQ12615 WMS
     SELECT e.Renglon, e.RenglonSub, e.RenglonID, e.Almacen, e.Articulo, e.SubCuenta, e.Cantidad, e.Unidad, CASE WHEN @NivelFactorMultiUnidad = 'Articulo' THEN ISNULL((SELECT e.CantidadA / ISNULL(a.Factor,1) FROM ArtUnidad a WHERE a.Articulo = e.Articulo AND a.Unidad = e.Unidad), e.CantidadA) ELSE ISNULL((SELECT e.CantidadA / ISNULL(u.Factor,1) FROM Unidad u WHERE u.Unidad = e.Unidad), e.CantidadA) END
       FROM EntarimarMov e
      WHERE e.Estacion = @Estacion AND ISNULL(e.CantidadA, 0.0) > 0.0-- AND ISNULL(CantidadA, 0.0) <= ISNULL(Cantidad, 0.0)
    OPEN crEntarimar
    FETCH NEXT FROM crEntarimar INTO @Renglon, @RenglonSub, @RenglonID, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadA
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND ISNULL(@CantidadA, 0.0) <= ISNULL(@Cantidad, 0.0) --REQ12615 WMS
      BEGIN
        UPDATE EntarimarTarima
           SET Cantidad = ISNULL(Cantidad, 0.0) + @CantidadA
         WHERE Estacion = @Estacion AND Almacen = @Almacen AND Tarima = @Tarima AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND ISNULL(Unidad, '') = ISNULL(@Unidad, '')
        IF @@ROWCOUNT = 0
		 --IF @CantidadA>0 --BUG3123
         IF CONVERT(NUMERIC(12,3), @CantidadA)>0 --BUG3573
          INSERT EntarimarTarima (
                  Estacion,  Renglon,  RenglonSub,  RenglonID,  Almacen,  Tarima,  Articulo,  SubCuenta,  Cantidad,   Unidad)
          VALUES (@Estacion, @Renglon, @RenglonSub, @RenglonID, @Almacen, @Tarima, @Articulo, @SubCuenta, @CantidadA, @Unidad)

        UPDATE EntarimarMov
           SET Cantidad = NULLIF(ISNULL(Cantidad, 0.0) - @CantidadA, 0.0), CantidadA = NULL
         WHERE CURRENT OF crEntarimar

        IF EXISTS(SELECT * FROM EntarimarMovSerieLote WHERE Estacion = @Estacion AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '')) AND
           (SELECT NULLIF(SUM(CantidadA), 0.0) FROM EntarimarMovSerieLote WHERE Estacion = @Estacion AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '')) IS NULL
        BEGIN
          DECLARE crEntarimarSerieLote CURSOR LOCAL FOR
           SELECT Cantidad
             FROM EntarimarMovSerieLote
            WHERE Estacion = @Estacion AND RenglonID = @RenglonID AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '')
              AND NULLIF(Cantidad, 0.0) IS NOT NULL
          OPEN crEntarimarSerieLote
          FETCH NEXT FROM crEntarimarSerieLote INTO @Cantidad
          WHILE @@FETCH_STATUS <> -1 AND @CantidadA > 0
          BEGIN
            IF @@FETCH_STATUS <> -2 
            BEGIN
--TASK24686
--EMG
              SELECT @ArtTipo = UPPER(Tipo) FROM Art WHERE Articulo = @Articulo
              IF @Cantidad < @CantidadA AND @ArtTipo IN ('SERIE', 'LOTE')
              BEGIN
                UPDATE EntarimarMov
                   SET Cantidad = ISNULL(Cantidad,0.00) + (@CantidadA - @Cantidad)
                 WHERE Estacion = @Estacion AND Articulo = @Articulo AND Renglon = @Renglon
                SELECT @CantidadA = @Cantidad
              END
--EMG
              IF @Cantidad <= @CantidadA 
              BEGIN
                UPDATE EntarimarMovSerieLote SET CantidadA = @Cantidad WHERE CURRENT OF crEntarimarSerieLote
                SELECT @CantidadA = @CantidadA - @Cantidad
              END ELSE
              BEGIN
                UPDATE EntarimarMovSerieLote SET CantidadA = @CantidadA WHERE CURRENT OF crEntarimarSerieLote
                SELECT @CantidadA = 0
              END
            END
            FETCH NEXT FROM crEntarimarSerieLote INTO @Cantidad
          END
          CLOSE crEntarimarSerieLote
          DEALLOCATE crEntarimarSerieLote
        END
      END
      FETCH NEXT FROM crEntarimar INTO @Renglon, @RenglonSub, @RenglonID, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad, @CantidadA
    END
    CLOSE crEntarimar
    DEALLOCATE crEntarimar
--Task 8036
    DECLARE crEntarimarSerieLote CURSOR LOCAL FOR
     SELECT RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, CantidadA, Propiedades
       FROM EntarimarMovSerieLote
      WHERE Estacion = @Estacion AND ISNULL(CantidadA, 0.0) > 0.0 AND ISNULL(CantidadA, 0.0) <= ISNULL(Cantidad, 0.0)
    OPEN crEntarimarSerieLote
    FETCH NEXT FROM crEntarimarSerieLote INTO @RenglonID, @Articulo, @SubCuenta, @SerieLote, @Cantidad, @CantidadA, @Propiedades
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        UPDATE EntarimarTarimaSerieLote
           SET Cantidad = ISNULL(Cantidad, 0.0) + @CantidadA
         WHERE Estacion = @Estacion AND Tarima = @Tarima AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND SerieLote = @SerieLote
        IF @@ROWCOUNT = 0
		 IF @CantidadA>0 --BUG3123
          INSERT EntarimarTarimaSerieLote (
                  Estacion,  RenglonID,  Tarima,  Articulo,  SubCuenta,  SerieLote,  Cantidad, Propiedades)
          VALUES (@Estacion, @RenglonID, @Tarima, @Articulo, @SubCuenta, @SerieLote, @CantidadA, @Propiedades)
--TASK24686
--EMG
        SELECT @ArtTipo = UPPER(Tipo) FROM Art WHERE Articulo = @Articulo
        IF  @ArtTipo IN ('SERIE', 'LOTE')
          UPDATE EntarimarTarima
             SET Cantidad = @CantidadA
           WHERE Estacion = @Estacion
             AND Tarima = @Tarima
--EMG

        UPDATE EntarimarMovSerieLote
           SET Cantidad = NULLIF(ISNULL(Cantidad, 0.0) - @CantidadA, 0.0), CantidadA = NULL
         WHERE CURRENT OF crEntarimarSerieLote
      END
      FETCH NEXT FROM crEntarimarSerieLote INTO @RenglonID, @Articulo, @SubCuenta, @SerieLote, @Cantidad, @CantidadA, @Propiedades
    END
    CLOSE crEntarimarSerieLote
    DEALLOCATE crEntarimarSerieLote
--Task 8036
  END ELSE
  IF @Accion = 'ELIMINAR' AND @ID IS NOT NULL
  BEGIN
    SELECT @CantidadA = NULL
    SELECT @Tarima = Tarima, @Renglon = Renglon, @RenglonSub = RenglonSub, @RenglonID = RenglonID, @CantidadA = Cantidad
      FROM EntarimarTarima
     WHERE Estacion = @Estacion AND ID = @ID

    IF NULLIF(@CantidadA, 0.0) IS NOT NULL
    BEGIN
      UPDATE EntarimarMov
         SET Cantidad = ISNULL(Cantidad, 0.0) + @CantidadA
       WHERE Estacion = @Estacion AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND RenglonID = @RenglonID
      DELETE EntarimarTarima
       WHERE Estacion = @Estacion AND ID = @ID
    END

--Task 8036
    DECLARE crEntarimarSerieLote CURSOR LOCAL FOR
     SELECT SerieLote
       FROM EntarimarTarimaSerieLote
      WHERE Estacion = @Estacion AND RenglonID = @RenglonID AND Tarima = @Tarima
    OPEN crEntarimarSerieLote
    FETCH NEXT FROM crEntarimarSerieLote INTO @SerieLote
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @CantidadA = NULL
        SELECT @CantidadA = Cantidad
          FROM EntarimarTarimaSerieLote
         WHERE Estacion = @Estacion AND RenglonID = @RenglonID AND Tarima = @Tarima AND SerieLote = @SerieLote 

        IF NULLIF(@CantidadA, 0.0) IS NOT NULL
        BEGIN
          UPDATE EntarimarMovSerieLote
             SET Cantidad = ISNULL(Cantidad, 0.0) + @CantidadA
           WHERE Estacion = @Estacion AND RenglonID = @RenglonID 

          DELETE EntarimarTarimaSerieLote
           WHERE CURRENT OF crEntarimarSerieLote
        END
      END
      FETCH NEXT FROM crEntarimarSerieLote INTO @SerieLote
    END
    CLOSE crEntarimarSerieLote
    DEALLOCATE crEntarimarSerieLote
--Task 8036
  END ELSE
  IF @Accion = 'ACEPTAR' AND @Modulo = 'INV' AND @MovTipo = 'INV.TMA'
  BEGIN
    DELETE SerieLoteMov
      FROM InvD d 
      JOIN SerieLoteMov slm ON slm.Empresa = @Empresa AND slm.Modulo = @Modulo AND slm.ID = d.ID AND slm.RenglonID = d.RenglonID AND slm.Articulo = d.Articulo AND slm.SubCuenta = ISNULL(d.SubCuenta, '')
     WHERE d.ID = @ModuloID AND d.Seccion = 1
    DELETE InvD WHERE ID = @ModuloID AND Seccion = 1
  END

  IF @Accion = 'ACEPTAR' AND EXISTS(SELECT * FROM EntarimarTarima WHERE Estacion = @Estacion)
  BEGIN
    SELECT @MAXRenglonID = 0
    IF @Modulo = 'VTAS'
    BEGIN
      SELECT @MAXRenglonID = ISNULL(MAX(RenglonID), 0) FROM VentaD WHERE ID = @ModuloID 
      UPDATE VentaD SET Factor = CantidadInventario/ISNULL(Cantidad, 1.0) WHERE ID = @ModuloID AND NULLIF(CantidadInventario, 0.0) IS NOT NULL
      UPDATE VentaD SET Cantidad = NULLIF(m.Cantidad, 0.0) FROM VentaD d JOIN EntarimarMov m ON m.Estacion = @Estacion AND m.Renglon = d.Renglon AND m.RenglonSub = d.RenglonSub WHERE d.ID = @ModuloID
    END ELSE
    IF @Modulo = 'INV'  
    BEGIN
      SELECT @MAXRenglonID = ISNULL(MAX(RenglonID), 0) FROM InvD WHERE ID = @ModuloID 
--      UPDATE InvD SET Tarima = NULL WHERE ID = @ModuloID  --JGD 15Marzo2011 Ticket 2929
      UPDATE InvD SET Factor = CantidadInventario/ISNULL(Cantidad, 1.0) WHERE ID = @ModuloID AND NULLIF(CantidadInventario, 0.0) IS NOT NULL
      IF @MovTipo <> 'INV.TMA'
        UPDATE InvD SET Cantidad = NULLIF(m.Cantidad, 0.0) FROM InvD d JOIN EntarimarMov m ON m.Estacion = @Estacion AND m.Renglon = d.Renglon AND m.RenglonSub = d.RenglonSub WHERE d.ID = @ModuloID
    END ELSE
    IF @Modulo = 'COMS' 
    BEGIN
      SELECT @MAXRenglonID = ISNULL(MAX(RenglonID), 0) FROM CompraD WHERE ID = @ModuloID 
      UPDATE CompraD SET Factor = CantidadInventario/ISNULL(Cantidad, 1.0) WHERE ID = @ModuloID AND NULLIF(CantidadInventario, 0.0) IS NOT NULL
      UPDATE CompraD SET Cantidad = NULLIF(m.Cantidad, 0.0) FROM CompraD d JOIN EntarimarMov m ON m.Estacion = @Estacion AND m.Renglon = d.Renglon AND m.RenglonSub = d.RenglonSub WHERE d.ID = @ModuloID
    END ELSE
    IF @Modulo = 'PROD' 
    BEGIN
      SELECT @MAXRenglonID = ISNULL(MAX(RenglonID), 0) FROM ProdD WHERE ID = @ModuloID
      UPDATE ProdD SET Factor = CantidadInventario/ISNULL(Cantidad, 1.0) WHERE ID = @ModuloID AND NULLIF(CantidadInventario, 0.0) IS NOT NULL
      UPDATE ProdD SET Cantidad = NULLIF(m.Cantidad, 0.0) FROM ProdD d JOIN EntarimarMov m ON m.Estacion = @Estacion AND m.Renglon = d.Renglon AND m.RenglonSub = d.RenglonSub WHERE d.ID = @ModuloID
    END

    SELECT @UltRenglon = NULL, @UltRenglonSub = NULL
    DECLARE crEntarimar CURSOR LOCAL FOR
     SELECT Renglon, RenglonSub, NULLIF(Cantidad, 0.0), Tarima, Almacen, Articulo, SubCuenta -- TASK2429
       FROM EntarimarTarima
      WHERE Estacion = @Estacion AND NULLIF(RTRIM(Tarima), '') IS NOT NULL
      ORDER BY Renglon, RenglonSub, ID
    OPEN crEntarimar
    FETCH NEXT FROM crEntarimar INTO @Renglon, @RenglonSub, @Cantidad, @Tarima, @Almacen, @Articulo, @SubCuenta -- TASK2429
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Cantidad IS NOT NULL
      BEGIN   
	    --REQ12615 WMS
        --SELECT @Posicion = PosicionDef FROM Alm WHERE Almacen = @Almacen        
        IF @Modulo = 'INV'
          SELECT @Posicion = PosicionWMS FROM Inv WHERE ID = @ModuloID
        ELSE
        IF @Modulo = 'COMS'
          SELECT @Posicion = PosicionWMS FROM Compra WHERE ID = @ModuloID
        ELSE
        IF @Modulo = 'VTAS'
          SELECT @Posicion = PosicionWMS FROM Venta WHERE ID = @ModuloID

        IF @Modulo = 'INV' AND @MovTipo = 'INV.TMA' /* Genero Entarimado de una Orden de Entarimado Manual */
        BEGIN
            IF @Modulo = 'INV'
            BEGIN
                SELECT @Origen = Origen, @OrigenId = OrigenId FROM Inv WHERE ID = @ModuloID

                IF ISNULL(@Origen,'') <> '' AND ISNULL(@OrigenId,'') <> ''
                    SELECT @OrigenO = Origen, @OrigenIDO = OrigenId FROM Inv WHERE Mov = @Origen AND MovID = @OrigenId
            END

            IF ISNULL(@OrigenO,'') = '' AND ISNULL(@OrigenIDO,'') = '' /* La Orden de Entarimado Manual no tiene origen y se obtiene la posicón de Recibo */
            BEGIN
                SELECT @Posicion = DefPosicionRecibo FROM Alm WHERE Almacen = @Almacen                
            END
        END

        UPDATE Tarima
           SET Almacen = @Almacen,
               Posicion = @Posicion,
               Estatus = 'ALTA',
               Alta = GETDATE()
         WHERE Tarima = @Tarima

        IF @@ROWCOUNT = 0
          INSERT Tarima (
                 Tarima,  Almacen,  Posicion,  Estatus, Alta, Articulo, SubCuenta) 
          SELECT @Tarima, @Almacen, @Posicion, 'ALTA', GETDATE(), @Articulo, @SubCuenta -- TASK2429

        IF @Modulo = 'VTAS'
        BEGIN
          IF (@UltRenglon = @Renglon AND @UltRenglonSub = @RenglonSub) OR EXISTS(SELECT * FROM VentaD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Cantidad IS NOT NULL)
          BEGIN
            SELECT @RenglonSubN = 0
            SELECT @RenglonSubN = MAX(RenglonSub) FROM VentaD WHERE ID = @ModuloID AND Renglon = @Renglon
            SELECT @RenglonSubN = ISNULL(@RenglonSubN, 0) + 1, @MAXRenglonID = ISNULL(@MAXRenglonID, 0) + 1
            SELECT * INTO #VentaDetalle FROM cVentaD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
            UPDATE #VentaDetalle SET Cantidad = @Cantidad, Tarima = @Tarima, RenglonSub = @RenglonSubN, RenglonID = @MAXRenglonID
            INSERT INTO cVentaD SELECT * FROM #VentaDetalle
            DROP TABLE #VentaDetalle
            INSERT SerieLoteMov  (
                   Empresa,  Modulo,  ID,        RenglonID,     Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades) --BUG2973
            SELECT @Empresa, @Modulo, @ModuloID, @MAXRenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades  --BUG2973
              FROM EntarimarTarimaSerieLote
             WHERE Estacion = @Estacion AND Tarima = @Tarima
          END ELSE          
            UPDATE VentaD 
               SET Cantidad = @Cantidad, Tarima = @Tarima
             WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        END ELSE
        IF @Modulo = 'INV'
        BEGIN
          IF (@MovTipo = 'INV.TMA') OR (@UltRenglon = @Renglon AND @UltRenglonSub = @RenglonSub) OR EXISTS(SELECT * FROM InvD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Cantidad IS NOT NULL)
          BEGIN
            SELECT @RenglonSubN = 0
            SELECT @RenglonSubN = MAX(RenglonSub) FROM InvD WHERE ID = @ModuloID AND Renglon = @Renglon
            SELECT @RenglonSubN = ISNULL(@RenglonSubN, 0) + 1, @MAXRenglonID = ISNULL(@MAXRenglonID, 0) + 1
            SELECT * INTO #InvDetalle FROM cInvD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
            UPDATE #InvDetalle SET Cantidad = @Cantidad, Tarima = @Tarima, RenglonSub = @RenglonSubN, RenglonID = @MAXRenglonID
            IF @MovTipo = 'INV.TMA'
            BEGIN
              UPDATE #InvDetalle SET Seccion = 1
--              UPDATE InvD SET Tarima = @Tarima WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub --JGD 15Marzo2011 Ticket 2929
            END
            INSERT INTO cInvD SELECT * FROM #InvDetalle
            DROP TABLE #InvDetalle
            INSERT SerieLoteMov  (
                   Empresa,  Modulo,  ID,        RenglonID,     Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades) --BUG2973
            SELECT @Empresa, @Modulo, @ModuloID, @MAXRenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades  --BUG2973
              FROM EntarimarTarimaSerieLote
             WHERE Estacion = @Estacion AND Tarima = @Tarima
          END ELSE          
            UPDATE InvD 
               SET Cantidad = @Cantidad, Tarima = @Tarima
             WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        END ELSE
        IF @Modulo = 'COMS'
        BEGIN
          IF (@UltRenglon = @Renglon AND @UltRenglonSub = @RenglonSub) OR EXISTS(SELECT * FROM CompraD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Cantidad IS NOT NULL)
          BEGIN
            SELECT @RenglonSubN = 0
            SELECT @RenglonSubN = MAX(RenglonSub) FROM CompraD WHERE ID = @ModuloID AND Renglon = @Renglon
            SELECT @RenglonSubN = ISNULL(@RenglonSubN, 0) + 1, @MAXRenglonID = ISNULL(@MAXRenglonID, 0) + 1
            SELECT * INTO #CompraDetalle FROM cCompraD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
            UPDATE #CompraDetalle SET Cantidad = @Cantidad, Tarima = @Tarima, RenglonSub = @RenglonSubN, RenglonID = @MAXRenglonID
            INSERT INTO cCompraD SELECT * FROM #CompraDetalle
            DROP TABLE #CompraDetalle
            INSERT SerieLoteMov  (
                   Empresa,  Modulo,  ID,        RenglonID,     Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades) --BUG2973
            SELECT @Empresa, @Modulo, @ModuloID, @MAXRenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades  --BUG2973
              FROM EntarimarTarimaSerieLote
             WHERE Estacion = @Estacion AND Tarima = @Tarima
          END ELSE          
            UPDATE CompraD 
               SET Cantidad = @Cantidad, Tarima = @Tarima
             WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        END ELSE
        IF @Modulo = 'PROD'
        BEGIN
          IF (@UltRenglon = @Renglon AND @UltRenglonSub = @RenglonSub) OR EXISTS(SELECT * FROM ProdD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Cantidad IS NOT NULL)
          BEGIN
            SELECT @RenglonSubN = 0
            SELECT @RenglonSubN = MAX(RenglonSub) FROM ProdD WHERE ID = @ModuloID AND Renglon = @Renglon
            SELECT @RenglonSubN = ISNULL(@RenglonSubN, 0) + 1, @MAXRenglonID = ISNULL(@MAXRenglonID, 0) + 1
            SELECT * INTO #ProdDetalle FROM cProdD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
            UPDATE #ProdDetalle SET Cantidad = @Cantidad, Tarima = @Tarima, RenglonSub = @RenglonSubN, RenglonID = @MAXRenglonID
            INSERT INTO cProdD SELECT * FROM #ProdDetalle
            DROP TABLE #ProdDetalle
            INSERT SerieLoteMov  (
                   Empresa,  Modulo,  ID,        RenglonID,     Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades) --BUG2973
            SELECT @Empresa, @Modulo, @ModuloID, @MAXRenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Tarima, Propiedades  --BUG2973
              FROM EntarimarTarimaSerieLote
             WHERE Estacion = @Estacion AND Tarima = @Tarima
          END ELSE          
            UPDATE ProdD 
               SET Cantidad = @Cantidad, Tarima = @Tarima
             WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        END

        SELECT @UltRenglon = @Renglon, @UltRenglonSub = @RenglonSub
      END
      FETCH NEXT FROM crEntarimar INTO @Renglon, @RenglonSub, @Cantidad, @Tarima, @Almacen, @Articulo, @SubCuenta -- TASK2429
    END
    CLOSE crEntarimar
    DEALLOCATE crEntarimar
    IF @Modulo = 'VTAS'
    BEGIN
      UPDATE Venta SET RenglonID = @MAXRenglonID WHERE ID = @ModuloID 
      DELETE VentaD WHERE ID = @ModuloID AND Cantidad IS NULL 
      UPDATE VentaD SET CantidadInventario = Cantidad*Factor WHERE ID = @ModuloID AND Factor IS NOT NULL

	  --BUG24430 BUG7750    
      UPDATE VentaD
         SET VentaD.Costo = (ArtCosto.CostoPromedio*ISNULL(VentaD.Factor, 1))/Venta.TipoCambio
        FROM Venta
        JOIN VentaD ON Venta.ID = VentaD.ID
        LEFT OUTER JOIN ArtCosto ON ArtCosto.Empresa = Venta.Empresa AND ArtCosto.Sucursal = Venta.Sucursal AND ArtCosto.Articulo = VentaD.Articulo
       WHERE Venta.ID = @ModuloID   
    END ELSE
    IF @Modulo = 'INV'
    BEGIN
      
       
      UPDATE Inv SET RenglonID = @MAXRenglonID WHERE ID = @ModuloID 
      IF @MovTipo <> 'INV.TMA'
        DELETE InvD WHERE ID = @ModuloID AND Cantidad IS NULL 

      --IF @MovTipo = 'INV.TMA'
      UPDATE InvD 
         SET CantidadInventario = Cantidad,
             Unidad = ISNULL(dbo.fnArtUnidadMinima(@Empresa,Articulo),Unidad)
       WHERE ID = @ModuloID AND Seccion IS NOT NULL

	  --Bug 3682
	  SELECT @TipoOpcion = TipoOpcion 
	    FROM Art 
       WHERE Articulo = @Articulo

	  IF @TipoOpcion <> 'Si' OR @TipoOpcion IS NULL --Bug 3682
	  --BUG24430  BUG7750
      UPDATE InvD
         SET InvD.Costo = (ArtCosto.CostoPromedio*ISNULL(InvD.Factor, 1))/Inv.TipoCambio
        FROM Inv
        JOIN InvD ON Inv.ID = InvD.ID
        LEFT OUTER JOIN ArtCosto ON ArtCosto.Empresa = Inv.Empresa AND ArtCosto.Sucursal = Inv.Sucursal AND ArtCosto.Articulo = InvD.Articulo
       WHERE Inv.ID = @ModuloID
    END ELSE
    IF @Modulo = 'COMS' 
    BEGIN 
      UPDATE Compra SET RenglonID = @MAXRenglonID WHERE ID = @ModuloID 
      DELETE CompraD WHERE ID = @ModuloID AND Cantidad IS NULL 
      UPDATE CompraD SET CantidadInventario = Cantidad*Factor WHERE ID = @ModuloID AND Factor IS NOT NULL

	  --BUG24430 BUG7750
      UPDATE CompraD
         SET CompraD.Costo = (ArtCosto.CostoPromedio*ISNULL(CompraD.Factor, 1))/Compra.TipoCambio
        FROM Compra
        JOIN CompraD ON Compra.ID = CompraD.ID
        LEFT OUTER JOIN ArtCosto ON ArtCosto.Empresa = Compra.Empresa AND ArtCosto.Sucursal = Compra.Sucursal AND ArtCosto.Articulo = CompraD.Articulo
       WHERE Compra.ID = @ModuloID        
    END ELSE
    IF @Modulo = 'PROD' 
    BEGIN
      UPDATE Prod SET RenglonID = @MAXRenglonID WHERE ID = @ModuloID
      DELETE ProdD WHERE ID = @ModuloID AND Cantidad IS NULL 
      UPDATE ProdD SET CantidadInventario = Cantidad*Factor WHERE ID = @ModuloID AND Factor IS NOT NULL

	  --BUG24430 BUG7750
      UPDATE ProdD
         SET ProdD.Costo = (ArtCosto.CostoPromedio*ISNULL(ProdD.Factor, 1))/Prod.TipoCambio
        FROM Prod
        JOIN ProdD ON Prod.ID = ProdD.ID
        LEFT OUTER JOIN ArtCosto ON ArtCosto.Empresa = Prod.Empresa AND ArtCosto.Sucursal = Prod.Sucursal AND ArtCosto.Articulo = ProdD.Articulo
       WHERE Prod.ID = @ModuloID       
    END
  END
--  if exists(select * from InvD where ID = @ModuloID and Seccion = 1) select Seccion, Tarima, * from InvD where ID = @ModuloID and Seccion = 1 --REQ12615 WMS
  IF @Conexion = 0
    COMMIT TRANSACTION
  RETURN
END
GO

/**************** spSurtirTarima ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSurtirTarima') and type = 'P') drop procedure dbo.spSurtirTarima
GO
CREATE PROCEDURE spSurtirTarima
			@Estacion	int,
			@Empresa	varchar(5),
			@Modulo		varchar(5),
			@ModuloID	int,
			@Mov		varchar(20),
			@MovID		varchar(20),
			@Accion		varchar(20),
			@Conexion	bit		= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MovTipo			varchar(20),
    @Almacen			varchar(10), 
    @Posicion			varchar(10), 
    @Tarima			varchar(20), 
    @Articulo			varchar(20), 
    @SubCuenta			varchar(50), 
    @Unidad			varchar(50), 
    @Cantidad			float,
    @CantidadPendiente		float,
    @Renglon			float,
    @RenglonSub			int,
    @RenglonSubN		int,
    @MAXRenglonID		int,
    @Ok				int,
    @OkRef			varchar(255),
    @CfgVentaMultiAlmacen	bit,
    @CfgCompraMultiAlmacen	bit,
    @CfgInvMultiAlmacen		bit

  IF @Modulo NOT IN ('VTAS', 'COMS', 'INV', 'PROD') RETURN
  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @Accion = UPPER(@Accion)
  SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  SELECT @CfgInvMultiAlmacen	= InvMultiAlmacen,
         @CfgCompraMultiAlmacen	= CompraMultiAlmacen,
    	 @CfgVentaMultiAlmacen  = VentaMultiAlmacen
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa 

  IF @Conexion = 0
    BEGIN TRANSACTION 
  
  IF @Accion = 'SUGERIR'
    DELETE SurtirTarimaMov WHERE Estacion = @Estacion
    
  IF @Accion = 'ACEPTAR'
  BEGIN
    SELECT @MAXRenglonID = 0
    IF @Modulo = 'VTAS'
    BEGIN
      SELECT @Almacen = Almacen FROM Venta WHERE ID = @ModuloID
      IF @CfgVentaMultiAlmacen = 0 UPDATE VentaD SET Almacen = @Almacen WHERE ID = @ModuloID AND Almacen <> @Almacen
      SELECT @MAXRenglonID = ISNULL(MAX(RenglonID), 0) FROM VentaD WHERE ID = @ModuloID      
    END ELSE
    IF @Modulo = 'INV'
    BEGIN
      SELECT @Almacen = Almacen FROM Inv WHERE ID = @ModuloID
      IF @CfgInvMultiAlmacen = 0 UPDATE InvD SET Almacen = @Almacen WHERE ID = @ModuloID AND Almacen <> @Almacen
      SELECT @MAXRenglonID = ISNULL(MAX(RenglonID), 0) FROM InvD WHERE ID = @ModuloID      
    END ELSE
    IF @Modulo = 'COMS'
    BEGIN
      SELECT @Almacen = Almacen FROM Compra WHERE ID = @ModuloID
      IF @CfgCompraMultiAlmacen = 0 UPDATE CompraD SET Almacen = @Almacen WHERE ID = @ModuloID AND Almacen <> @Almacen
      SELECT @MAXRenglonID = ISNULL(MAX(RenglonID), 0) FROM CompraD WHERE ID = @ModuloID      
    END ELSE
    IF @Modulo = 'PROD'
    BEGIN
      SELECT @Almacen = Almacen FROM Prod WHERE ID = @ModuloID
      SELECT @MAXRenglonID = ISNULL(MAX(RenglonID), 0) FROM ProdD WHERE ID = @ModuloID      
    END  	

    DECLARE crSurtirTarima CURSOR LOCAL FOR
     SELECT Almacen, Posicion, Tarima, Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), ''), SUM(Cantidad)
       FROM SurtirTarimaMov
      WHERE Estacion = @Estacion 
      GROUP BY Almacen, Posicion, Tarima, Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), '')
    OPEN crSurtirTarima
    FETCH NEXT FROM crSurtirTarima INTO @Almacen, @Posicion, @Tarima, @Articulo, @SubCuenta, @Unidad, @Cantidad
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND NULLIF(@Cantidad, 0.0) IS NOT NULL
      BEGIN   
      	SELECT @Renglon = NULL, @RenglonSub = NULL, @CantidadPendiente = NULL
      	IF @Modulo = 'VTAS'
      	BEGIN
      	  SELECT TOP(1) @Renglon = Renglon, @RenglonSub = RenglonSub, @CantidadPendiente = NULLIF(Cantidad, 0.0)
      	    FROM VentaD
      	   WHERE ID = @ModuloID AND Almacen = @Almacen AND Articulo = @Articulo AND NULLIF(RTRIM(Tarima), '') IS NULL AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') --AND ISNULL(Unidad, '') = ISNULL(@Unidad, '')
      	  IF ISNULL(@CantidadPendiente, 0.0) >= @Cantidad
      	  BEGIN
            SELECT @RenglonSubN = 0
            SELECT @RenglonSubN = MAX(RenglonSub) FROM VentaD WHERE ID = @ModuloID AND Renglon = @Renglon
            SELECT @RenglonSubN = ISNULL(@RenglonSubN, 0) + 1, @MAXRenglonID = ISNULL(@MAXRenglonID, 0) + 1
            SELECT * INTO #VentaDetalle FROM cVentaD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
            UPDATE #VentaDetalle SET Cantidad = @Cantidad, Tarima = @Tarima, RenglonSub = @RenglonSubN, RenglonID = @MAXRenglonID
            INSERT INTO cVentaD SELECT * FROM #VentaDetalle
            DROP TABLE #VentaDetalle
            UPDATE VentaD SET Cantidad = NULLIF(Cantidad - @Cantidad, 0.0) WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
      	  END ELSE SELECT @Ok = 13240, @OkRef = @Articulo
      	END ELSE
      	IF @Modulo = 'INV'
      	BEGIN
      	  SELECT TOP(1) @Renglon = Renglon, @RenglonSub = RenglonSub, @CantidadPendiente = NULLIF(Cantidad, 0.0)
      	    FROM InvD
      	   WHERE ID = @ModuloID AND Almacen = @Almacen AND Articulo = @Articulo AND NULLIF(RTRIM(Tarima), '') IS NULL AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') --AND ISNULL(Unidad, '') = ISNULL(@Unidad, '')
      	  IF ISNULL(@CantidadPendiente, 0.0) >= @Cantidad
      	  BEGIN
            SELECT @RenglonSubN = 0
            SELECT @RenglonSubN = MAX(RenglonSub) FROM InvD WHERE ID = @ModuloID AND Renglon = @Renglon
            SELECT @RenglonSubN = ISNULL(@RenglonSubN, 0) + 1, @MAXRenglonID = ISNULL(@MAXRenglonID, 0) + 1
            SELECT * INTO #InvDetalle FROM cInvD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
            UPDATE #InvDetalle SET Cantidad = @Cantidad, Tarima = @Tarima, RenglonSub = @RenglonSubN, RenglonID = @MAXRenglonID
            INSERT INTO cInvD SELECT * FROM #InvDetalle
            DROP TABLE #InvDetalle
            UPDATE InvD SET Cantidad = NULLIF(Cantidad - @Cantidad, 0.0) WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
      	  END ELSE SELECT @Ok = 13240, @OkRef = @Articulo
      	END ELSE
      	IF @Modulo = 'COMS'
      	BEGIN
      	  SELECT TOP(1) @Renglon = Renglon, @RenglonSub = RenglonSub, @CantidadPendiente = NULLIF(Cantidad, 0.0)
      	    FROM CompraD
      	   WHERE ID = @ModuloID AND Almacen = @Almacen AND Articulo = @Articulo AND NULLIF(RTRIM(Tarima), '') IS NULL AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') --AND ISNULL(Unidad, '') = ISNULL(@Unidad, '')
      	  IF ISNULL(@CantidadPendiente, 0.0) >= @Cantidad
      	  BEGIN
            SELECT @RenglonSubN = 0
            SELECT @RenglonSubN = MAX(RenglonSub) FROM CompraD WHERE ID = @ModuloID AND Renglon = @Renglon
            SELECT @RenglonSubN = ISNULL(@RenglonSubN, 0) + 1, @MAXRenglonID = ISNULL(@MAXRenglonID, 0) + 1
            SELECT * INTO #CompraDetalle FROM cCompraD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
            UPDATE #CompraDetalle SET Cantidad = @Cantidad, Tarima = @Tarima, RenglonSub = @RenglonSubN, RenglonID = @MAXRenglonID
            INSERT INTO cCompraD SELECT * FROM #CompraDetalle
            DROP TABLE #CompraDetalle
            UPDATE CompraD SET Cantidad = NULLIF(Cantidad - @Cantidad, 0.0) WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
      	  END ELSE SELECT @Ok = 13240, @OkRef = @Articulo
      	END ELSE
      	IF @Modulo = 'PROD'
      	BEGIN
      	  SELECT TOP(1) @Renglon = Renglon, @RenglonSub = RenglonSub, @CantidadPendiente = NULLIF(Cantidad, 0.0)
      	    FROM ProdD
      	   WHERE ID = @ModuloID AND Almacen = @Almacen AND Articulo = @Articulo AND NULLIF(RTRIM(Tarima), '') IS NULL AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') --AND ISNULL(Unidad, '') = ISNULL(@Unidad, '')
      	  IF ISNULL(@CantidadPendiente, 0.0) >= @Cantidad
      	  BEGIN
            SELECT @RenglonSubN = 0
            SELECT @RenglonSubN = MAX(RenglonSub) FROM ProdD WHERE ID = @ModuloID AND Renglon = @Renglon
            SELECT @RenglonSubN = ISNULL(@RenglonSubN, 0) + 1, @MAXRenglonID = ISNULL(@MAXRenglonID, 0) + 1
            SELECT * INTO #ProdDetalle FROM cProdD WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
            UPDATE #ProdDetalle SET Cantidad = @Cantidad, Tarima = @Tarima, RenglonSub = @RenglonSubN, RenglonID = @MAXRenglonID
            INSERT INTO cProdD SELECT * FROM #ProdDetalle
            DROP TABLE #ProdDetalle
            UPDATE ProdD SET Cantidad = NULLIF(Cantidad - @Cantidad, 0.0) WHERE ID = @ModuloID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 
      	  END ELSE SELECT @Ok = 13240, @OkRef = @Articulo
      	END
      END
      FETCH NEXT FROM crSurtirTarima INTO @Almacen, @Posicion, @Tarima, @Articulo, @SubCuenta, @Unidad, @Cantidad
    END
    CLOSE crSurtirTarima
    DEALLOCATE crSurtirTarima 
  END

  IF @Modulo = 'VTAS'
  BEGIN
    UPDATE Venta SET RenglonID = @MAXRenglonID WHERE ID = @ModuloID 
    DELETE VentaD WHERE ID = @ModuloID AND NULLIF(Cantidad, 0.0) IS NULL 
  END ELSE
  IF @Modulo = 'INV'
  BEGIN
    UPDATE Inv SET RenglonID = @MAXRenglonID WHERE ID = @ModuloID 
    DELETE InvD WHERE ID = @ModuloID AND NULLIF(Cantidad, 0.0) IS NULL 
  END ELSE
  IF @Modulo = 'COMS'
  BEGIN
    UPDATE Compra SET RenglonID = @MAXRenglonID WHERE ID = @ModuloID 
    DELETE CompraD WHERE ID = @ModuloID AND NULLIF(Cantidad, 0.0) IS NULL 
  END ELSE
  IF @Modulo = 'PROD'
  BEGIN
    UPDATE Prod SET RenglonID = @MAXRenglonID WHERE ID = @ModuloID 
    DELETE ProdD WHERE ID = @ModuloID AND NULLIF(Cantidad, 0.0) IS NULL 
  END
  
  IF @Conexion = 0
  BEGIN
    IF @Ok IS NULL
      COMMIT TRANSACTION
    ELSE 
    BEGIN
      ROLLBACK TRANSACTION
      EXEC spOk_RAISERROR @Ok, @OkRef
    END
  END
  RETURN
END
GO


/**************** fnAutoSurtirTarima ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAutoSurtirTarima' AND type = 'TF') DROP FUNCTION fnAutoSurtirTarima
GO
CREATE FUNCTION fnAutoSurtirTarima (@Empresa varchar(5), @Almacen varchar(10), @Articulo varchar(20), @SubCuenta varchar(50), @Cantidad float, @Unidad varchar(50))
RETURNS @Resultado TABLE (Tarima varchar(20), Posicion varchar(10), Cantidad float)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tarima				varchar(20),
    @Existencia			float,
    @CantidadTarima		float,
    @CantidadPendiente	float,
    @CantidadA			float,
    @Posicion			varchar(20),
    @PosicionTipo		varchar(20),
    @Domicilio			varchar(10),
    @DomicilioTarima	varchar(20),
    @Pasillo			int,
    @Fila				int,
    @Nivel				int
    
    DECLARE @TarimaApartada TABLE(
    Modulo				varchar(10),
    Tarima				varchar(10),
    Cantidad			float)
    
    DECLARE @TarimaApartadaR TABLE(
    Tarima				varchar(10),
    Cantidad			float)

    INSERT INTO @TarimaApartada(Modulo, Tarima, Cantidad)
    SELECT 'VTAS', d.Tarima, SUM(ISNULL(d.CantidadPendiente, 0) + ISNULL(d.CantidadReservada, 0))
      FROM Venta e 
      JOIN VentaD d ON e.ID = d.ID
      JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'VTAS' AND mt.Clave IN ('VTAS.P')
     WHERE e.Empresa = @Empresa
       AND e.Almacen = @Almacen 
       AND e.Estatus IN ('PENDIENTE', 'SINAFECTAR')
       AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '')
       AND NULLIF(RTRIM(d.Tarima), '') IS NOT NULL
     GROUP BY d.Tarima
    
    INSERT INTO @TarimaApartada(Modulo, Tarima, Cantidad)
    SELECT 'INV', d.Tarima, SUM(ISNULL(d.CantidadPendiente, 0) + ISNULL(d.CantidadReservada, 0))
      FROM Inv e 
      JOIN InvD d ON e.ID = d.ID
      JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'INV' AND mt.Clave IN ('INV.OT', 'INV.OI') -- Orden Transferencia, Orden Traspaso
     WHERE e.Empresa = @Empresa
       AND e.Almacen = @Almacen 
       AND e.Estatus IN ('PENDIENTE', 'SINAFECTAR')
       AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '')
       AND NULLIF(RTRIM(d.Tarima), '') IS NOT NULL
     GROUP BY d.Tarima

    INSERT INTO @TarimaApartada(Modulo, Tarima, Cantidad)
    SELECT 'COMS', d.Tarima, SUM(ISNULL(d.CantidadPendiente, 0))
      FROM Compra e 
      JOIN CompraD d ON e.ID = d.ID
      JOIN MovTipo mt ON e.Mov = mt.Mov AND mt.Modulo = 'COMS' AND mt.Clave IN ('COMS.OD') -- Orden Devolucion
     WHERE e.Empresa = @Empresa
       AND e.Almacen = @Almacen 
       AND e.Estatus IN ('PENDIENTE', 'SINAFECTAR')
       AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '')
       AND NULLIF(RTRIM(d.Tarima), '') IS NOT NULL
     GROUP BY d.Tarima
     
    INSERT INTO @TarimaApartadaR(Tarima, Cantidad)
    SELECT Tarima, SUM(Cantidad)
      FROM @TarimaApartada ta
     GROUP BY ta.Tarima

    SELECT @CantidadPendiente = @Cantidad
    SELECT @CantidadTarima = CantidadTarima FROM Art WHERE Articulo = @Articulo
    SELECT TOP 1 @Domicilio = ap.Posicion
      FROM AlmPos ap
     WHERE ap.Almacen = @Almacen AND UPPER(ap.Tipo) = 'DOMICILIO' AND ap.ArticuloEsp = @Articulo
     
    SELECT @Pasillo = ap.Pasillo, @Fila = ap.Fila, @Nivel = ap.Nivel
      FROM AlmPos ap
     WHERE ap.Almacen = @Almacen AND ap.Posicion = @Posicion
      
    IF @CantidadPendiente < @CantidadTarima AND @Domicilio IS NOT NULL
    BEGIN
      SELECT @DomicilioTarima = dbo.fnTarimaEnPosicion(@Almacen, @Domicilio)
      IF @DomicilioTarima IS NOT NULL
        INSERT @Resultado(
                 Tarima, Posicion,  Cantidad)
        VALUES (@DomicilioTarima, @Domicilio, @CantidadPendiente)
    END
    ELSE
    BEGIN
      DECLARE crExistenciaTarima CURSOR LOCAL FOR
       SELECT e.Tarima, t.Posicion, ap.Tipo, SUM(e.Existencia)
         FROM ArtSubExistenciaInvCsgTarima e
         JOIN Tarima t ON t.Tarima = e.Tarima
         JOIN AlmPos ap ON ap.Almacen = @Almacen AND ap.Posicion = t.Posicion
        WHERE e.Empresa = @Empresa AND e.Almacen = @Almacen AND e.Articulo = @Articulo AND e.SubCuenta = ISNULL(@SubCuenta, '')
          AND UPPER(ap.Tipo) = 'UBICACION'
          AND t.Tarima NOT IN (SELECT Tarima FROM @TarimaApartadaR tar)
        GROUP BY e.Tarima, t.Posicion, ap.Tipo, ap.Pasillo, ap.Fila, ap.Nivel
        --ORDER BY ap.Tipo DESC, SUM(e.Existencia), e.Tarima
        ORDER BY Abs(ISNULL(Fila, 0)-@Fila), Abs(ISNULL(Nivel, 0)-@Nivel), Abs(ISNULL(Pasillo, 0)-@Pasillo), e.Tarima
      
      OPEN crExistenciaTarima
      FETCH NEXT FROM crExistenciaTarima INTO @Tarima, @Posicion, @PosicionTipo, @Existencia
      WHILE @@FETCH_STATUS <> -1 AND @CantidadPendiente > 0.0
      BEGIN
        IF @@FETCH_STATUS <> -2 AND NULLIF(@Existencia, 0.0) IS NOT NULL
        BEGIN   
  	    /*IF @PosicionTipo = 'DOMICILIO' OR @CantidadPendiente >= @Existencia
        BEGIN*/
      	  IF @Existencia > @CantidadPendiente
      	  BEGIN
            SELECT @CantidadA = @CantidadPendiente
            SELECT @DomicilioTarima = dbo.fnTarimaEnPosicion(@Almacen, @Domicilio)
            SELECT @Tarima = @DomicilioTarima
      	  END
      	  ELSE 
            SELECT @CantidadA = @Existencia
          
  	      INSERT @Resultado (
   	             Tarima,   Posicion,  Cantidad)
       	  VALUES (@Tarima, @Posicion, @CantidadA)
       	  SELECT @CantidadPendiente = @CantidadPendiente - @CantidadA
      	    /*END*/
         END
        FETCH NEXT FROM crExistenciaTarima INTO @Tarima, @Posicion, @PosicionTipo, @Existencia
      END
      CLOSE crExistenciaTarima
      DEALLOCATE crExistenciaTarima
      
      DELETE @TarimaApartadaR
      
    END -- ELSE
     	
  RETURN 
END
GO

/**************** spAutoSurtirTarima ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAutoSurtirTarima') and type = 'P') drop procedure dbo.spAutoSurtirTarima
GO
CREATE PROCEDURE spAutoSurtirTarima
			@Estacion	int,
			@Empresa	varchar(5),
			@Modulo		varchar(5),
			@ModuloID	int,
			@Mov		varchar(20),
			@MovID		varchar(20),
			@Almacen	varchar(10),
			@Conexion	bit		= 0,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo		varchar(20), 
    @SubCuenta		varchar(50), 
    @Unidad		varchar(50), 
    @Cantidad		float
    
  IF @Estacion IS NULL SELECT @Estacion = -@@SPID
  IF @Modulo = 'VTAS'
    DECLARE crAutoSurtirTarima CURSOR LOCAL FOR
     SELECT Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), ''), SUM(Cantidad)
       FROM VentaD
      WHERE ID = @ModuloID AND NULLIF(RTRIM(Tarima), '') IS NULL
      GROUP BY Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), '')
  ELSE IF @Modulo = 'INV'
    DECLARE crAutoSurtirTarima CURSOR LOCAL FOR
     SELECT Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), ''), SUM(Cantidad)
       FROM InvD
      WHERE ID = @ModuloID AND NULLIF(RTRIM(Tarima), '') IS NULL
      GROUP BY Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), '')
  ELSE IF @Modulo = 'COMS'
    DECLARE crAutoSurtirTarima CURSOR LOCAL FOR
     SELECT Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), ''), SUM(Cantidad)
       FROM CompraD
      WHERE ID = @ModuloID AND NULLIF(RTRIM(Tarima), '') IS NULL
      GROUP BY Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), '')
  ELSE IF @Modulo = 'PROD'
    DECLARE crAutoSurtirTarima CURSOR LOCAL FOR
     SELECT Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), ''), SUM(Cantidad)
       FROM ProdD
      WHERE ID = @ModuloID AND NULLIF(RTRIM(Tarima), '') IS NULL
      GROUP BY Articulo, NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(Unidad), '')
    OPEN crAutoSurtirTarima
    FETCH NEXT FROM crAutoSurtirTarima INTO @Articulo, @SubCuenta, @Unidad, @Cantidad
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND NULLIF(@Cantidad, 0.0) IS NOT NULL
      BEGIN   
        DELETE SurtirTarimaMov WHERE Estacion = @Estacion
        INSERT SurtirTarimaMov (
               Estacion,  Almacen,  Posicion, Tarima, Articulo,  SubCuenta,  Cantidad, Unidad)
        SELECT @Estacion, @Almacen, Posicion, Tarima, @Articulo, @SubCuenta, Cantidad, @Unidad
          FROM dbo.fnAutoSurtirTarima(@Empresa, @Almacen, @Articulo, @SubCuenta, @Cantidad, @Unidad)    

        EXEC spSurtirTarima @Estacion, @Empresa, @Modulo, @ModuloID, @Mov, @MovID, 'ACEPTAR', @Conexion
      END
      FETCH NEXT FROM crAutoSurtirTarima INTO @Articulo, @SubCuenta, @Unidad, @Cantidad
    END
    CLOSE crAutoSurtirTarima
    DEALLOCATE crAutoSurtirTarima

  RETURN
END
GO

--REQ12615 WMS
/***************** cVentaDWMS *******************/
if exists (select * from sysobjects where id = object_id('dbo.cVentaDWMS') and sysstat & 0xf = 2) drop view dbo.cVentaDWMS
GO
CREATE VIEW cVentaDWMS
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
  EnviarA,
  Codigo,
  Articulo,
  SubCuenta,
  --nSubCuenta,
  Precio,
  PrecioSugerido,
  DescuentoTipo,
  DescuentoLinea,
  DescuentoImporte,
  Impuesto1,
  Impuesto2,
  Impuesto3,
  DescripcionExtra,
  Costo,
  CostoActividad,
  Paquete,
  ContUso,
  ContUso2,
  ContUso3,

--  Comision,

  Aplica,
  AplicaID,

  CantidadPendiente,
  CantidadReservada,
  CantidadCancelada,
  CantidadOrdenada,
  CantidadObsequio,

  CantidadA,

  Unidad,
  Factor,
  CantidadInventario,

  SustitutoArticulo,
  SustitutoSubCuenta,
  FechaRequerida,
  HoraRequerida,

  Instruccion,

  UltimoReservadoCantidad,
  UltimoReservadoFecha,
  
  Agente,
  Departamento,
  Sucursal,
  SucursalOrigen,
  AutoLocalidad,
  UEN,
  Espacio,
  CantidadAlterna,
  PoliticaPrecios,
  PrecioMoneda,
  PrecioTipoCambio,
  AFArticulo,
  AFSerie,
  ExcluirPlaneacion,
  Anexo, 
  Estado,
  ExcluirISAN,
  Posicion,
  PresupuestoEsp,
  ProveedorRef,
  TransferirA,
  Tarima,
  ABC,
  TipoImpuesto1,
  TipoImpuesto2,
  TipoImpuesto3,
  OrdenCompra,  
  AnticipoFacturado,
  AnticipoMoneda,
  AnticipoTipoCambio,
  AnticipoRetencion  
FROM
  VentaD
GO

--REQ12615 WMS
/***************** cInvDWMS *******************/
if exists (select * from sysobjects where id = object_id('dbo.cInvDWMS') and sysstat & 0xf = 2) drop view dbo.cInvDWMS
GO
CREATE VIEW cInvDWMS
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
  FechaCaducidad

FROM 
  InvD
GO
--TASK24685
/****** WMSSurtidoPosicionTrabajo ******/
if not exists(select * from SysTabla where SysTabla = 'WMSSurtidoPosicionTrabajo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WMSSurtidoPosicionTrabajo','Herramienta')
if not exists (select * from sysobjects where id = object_id('WMSSurtidoPosicionTrabajo') and type = 'U') 
CREATE TABLE WMSSurtidoPosicionTrabajo(
  RID			int			IDENTITY,
  Modulo		varchar(5),
  ModuloID		int,
  Posicion		varchar(20)	NULL,
  CONSTRAINT priWMSSurtidoPosicionTrabajo PRIMARY KEY CLUSTERED(Modulo, ModuloID)
  )
GO
--TASK24685
EXEC spALTER_TABLE 'WMSSurtidoPosicionTrabajo', 'RID', 'int IDENTITY'
EXEC spALTER_TABLE 'WMSSurtidoPosicionTrabajo', 'Modulo', 'varchar(5)'
EXEC spALTER_TABLE 'WMSSurtidoPosicionTrabajo', 'ModuloID', 'int'
GO
--TASK24685
--23468
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSReacomodoSurtido', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'WMSSurtidoProcesarD', 'TarimaSurtido', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'INV', 'FiltroEspecifico', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaCfg', 'PosicionArticulo', 'bit NULL DEFAULT 1 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaCfg', 'DesentarimarPedido', 'bit NULL DEFAULT 0'   
GO
UPDATE EmpresaCfg SET PosicionArticulo = 1
GO
--TASK24685
--BUG24180
EXEC spALTER_TABLE 'TMA', 'OrigenObservaciones', 'varchar(100)'
GO

--USER STORY 8497
EXEC spALTER_TABLE 'TMA', 'Empacado', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--TASK24685
/*****Herramienta Job Surtido ******************/
/****** WMSSurtidoProcesarTrabajo ******/
if not exists(select * from SysTabla where SysTabla = 'WMSSurtidoProcesarTrabajo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WMSSurtidoProcesarTrabajo','Herramienta')
if not exists (select * from sysobjects where id = object_id('WMSSurtidoProcesarTrabajo') and type = 'U') 
CREATE TABLE WMSSurtidoProcesarTrabajo(
  RID			int			IDENTITY,
  Modulo		varchar(5),
  ModuloID		int,
  CONSTRAINT priWMSSurtidoProcesarTrabajo PRIMARY KEY CLUSTERED(Modulo, ModuloID)
  )
GO
EXEC spADD_INDEX 'WMSSurtidoProcesarTrabajo', 'Ciclo', 'ModuloID, Modulo'
GO
/* WMSSurtidoTrabajo */
if not exists(select * from SysTabla where SysTabla = 'WMSSurtidoTrabajo')
INSERT INTO SysTabla (SysTabla) VALUES ('WMSSurtidoTrabajo')
if not exists (select * from sysobjects where id = object_id('dbo.WMSSurtidoTrabajo') and type = 'U') 
CREATE TABLE dbo.WMSSurtidoTrabajo (
    Trabajo        		varchar(100)NOT NULL,

	spSucursal			int			NOT NULL,
	spEmpresa			varchar(5)	NOT NULL,
	spUsuario			varchar(30) NOT NULL,
	Nombre				varchar(100)	NULL,
	Descripcion			varchar(255)	NULL,
	UltimaActualizacion	datetime		NULL	DEFAULT GETDATE(),
	Activo				bit				NULL	DEFAULT 0,

	Modificar			bit				NULL	DEFAULT 0,


	HoraInicial			varchar(6)		NULL	DEFAULT '00:00',
	HoraFinal			varchar(6)		NULL	DEFAULT '23:59',
	Frecuencia			varchar (20)	NULL	DEFAULT 'Diaria',
	Valor				tinyint			NULL	DEFAULT 1,
	Recurrencia			tinyint			NULL	DEFAULT 1,
	FrecuenciaD			varchar (20)	NULL	DEFAULT 'Minutos',
	ValorD				tinyint			NULL	DEFAULT 30,
	
	Usuario    			varchar(30)		NULL	DEFAULT 'sa',
  	Contrasena  		varchar(30)		NULL	DEFAULT '',
  	
  	Domingo				bit				NULL	DEFAULT 0,
  	Lunes				bit				NULL	DEFAULT 0,
  	Martes				bit				NULL	DEFAULT 0,
  	Miercoles			bit				NULL	DEFAULT 0,
  	Jueves				bit				NULL	DEFAULT 0,
  	Viernes				bit				NULL	DEFAULT 0,
  	Sabado				bit				NULL	DEFAULT 0,
  	
  	Tipo  				varchar(30)		NULL	DEFAULT 'Primer',
  	Dia  				varchar(30)		NULL	DEFAULT 'Lunes',
  	FechaInicial		datetime		NULL    DEFAULT	GETDATE(),

	Procesar    		varchar(30)		NULL	DEFAULT 'Procesar Explosiones',
  	
    CONSTRAINT priWMSSurtidoTrabajo PRIMARY KEY  CLUSTERED (Trabajo)
)
GO
EXEC spALTER_TABLE 'WMSSurtidoTrabajo', 'Procesar', 'varchar(30) NULL DEFAULT "Procesar Explosiones"'
GO
IF NOT EXISTS (SELECT * FROM WMSSurtidoTrabajo WHERE Trabajo = 'Explosionar_DEMO_ 0_DEMO_Procesar Explosiones')
INSERT WMSSurtidoTrabajo (Trabajo,	Nombre,   Descripcion, spSucursal, spEmpresa, spUsuario)
VALUES('Explosionar_DEMO_ 0_DEMO_Procesar Explosiones', 'Explosionar_DEMO_ 0_DEMO_Procesar Explosiones', 'Intelisis Service', 0, 'DEMO', 'DEMO')
GO
--BUG24630
EXEC spADD_INDEX 'TMA', 'UbicacionDisponible', 'ID,Estatus,Empresa,Mov,MovID)INCLUDE (Origen,OrigenID'
EXEC spADD_INDEX 'TMAD', 'UbicacionDisponible', 'PosicionDestino,EstaPendiente'
GO
--BUG24180
/**************** fnRegresaSubTarimaTransitoC ****************/
IF EXISTS (SELECT 1 FROM sysobjects where name = 'fnRegresaSubTarimaTransitoC' AND type IN ('TF','FN')) DROP FUNCTION fnRegresaSubTarimaTransitoC
GO
CREATE FUNCTION fnRegresaSubTarimaTransitoC (@Tarima varchar(20), @MovTipo varchar(20))
RETURNS varchar(20)
AS BEGIN
   
 IF @MovTipo = 'TMA.OSUR'
 BEGIN
   IF (SELECT a.Tipo
         FROM Tarima t
         JOIN AlmPos a
		   ON t.Almacen = a.Almacen
		  AND t.Posicion = a.Posicion
		  AND t.Tarima = @Tarima) = 'Domicilio'
   BEGIN
     IF NOT EXISTS(SELECT d.Tarima 
                     --BUG24180
	                 FROM TMAD d
					 JOIN TMA t
					   ON t.ID = d.ID
					WHERE t.Estatus IN('CONCLUIDO', 'PENDIENTE', 'PROCESAR')
					  AND d.Tarima LIKE @Tarima + '-%'
					GROUP BY d.Tarima)
       SELECT @Tarima = @Tarima + '-1'
     ELSE
       SELECT TOP 1 @Tarima = RTRIM(SUBSTRING(d.Tarima,1,LEN(@Tarima)+1)) + CONVERT(varchar(10),CONVERT(int,RTRIM(SUBSTRING(d.Tarima,LEN(@Tarima)+2,LEN(@Tarima))))+1)
         --BUG24180       
         FROM TMAD d 
         JOIN TMA t
           ON t.ID = d.ID
        WHERE t.Estatus IN('CONCLUIDO', 'PENDIENTE', 'PROCESAR')
          AND d.Tarima LIKE @Tarima + '-%'
		ORDER BY D.ID DESC
   END
 END 
 RETURN (@Tarima)
END
GO

--BUG24180
/****** Consecutivo de Tarimas en Transito ******/
if not exists(select * from SysTabla where SysTabla = 'TarimaTransitoC')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TarimaTransitoC','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TarimaTransitoC') and type = 'U') 
CREATE TABLE dbo.TarimaTransitoC (
  ID				int			IDENTITY,
  Tarima			varchar(20)	NOT NULL,
  Consecutivo		int,
  CONSTRAINT priTarimaTransitoC PRIMARY KEY CLUSTERED(ID)
  )
GO

--BUG24180
IF NOT EXISTS(SELECT ID FROM TarimaTransitoC)
BEGIN
  CREATE TABLE #Tarimas(TarimaActual varchar(20), Tarima varchar(20) NULL, Consecutivo int NULL)

  INSERT INTO #Tarimas(TarimaActual) SELECT dbo.fnRegresaSubTarimaTransitoC(Tarima, 'TMA.OSUR') FROM Tarima WHERE CHARINDEX('-', Tarima, 1) = 0
  
  DELETE #Tarimas WHERE CHARINDEX('-', TarimaActual, 1) = 0
  
  UPDATE #Tarimas 
     SET Tarima = SUBSTRING(TarimaActual, 1, CHARINDEX('-', TarimaActual, 1) - 1),
         Consecutivo = SUBSTRING(TarimaActual, CHARINDEX('-', TarimaActual, 1) + 1, LEN(TarimaActual) - CHARINDEX('-', TarimaActual, 1))

  DELETE #Tarimas WHERE Consecutivo = 1
  
  INSERT INTO TarimaTransitoC(Tarima, Consecutivo) SELECT Tarima, Consecutivo FROM #Tarimas
  
  DROP TABLE #Tarimas
END
GO
--BUG24180
EXEC spADD_INDEX 'TarimaTransitoC', 'Tarima', 'Tarima)INCLUDE(Consecutivo'
EXEC spADD_INDEX 'TMAC', 'Consecutivo', 'Mov, Sucursal, Empresa, Serie, Periodo, Ejercicio)INCLUDE(Consecutivo'
GO
EXEC spADD_INDEX 'TMA', 'CantidadPicking', 'Empresa,Origen,OrigenID'
EXEC spADD_INDEX 'TMA', 'CantidadPicking2', 'Empresa,Origen,OrigenID,Estatus,ID,Mov'
EXEC spADD_INDEX 'TMAD', 'CantidadPicking2', 'ID,Renglon)INCLUDE(Tarima,CantidadPicking'
GO
EXEC spADD_INDEX 'TMAD', 'Pendiente', 'PosicionDestino, Tarima, ID, Renglon'
GO
/****** PosicionArt  ******/
if not exists (select * from sysobjects where id = object_id('dbo.PosicionArt') and type = 'U') 
CREATE TABLE PosicionArt
(	
    Id       int    identity(1,1),
	Posicion varchar(20) NULL, 
	Articulo varchar(20) NULL
)
GO
IF exists (select * from PosicionArt)
	truncate table PosicionArt
GO

IF EXISTS(SELECT * FROM sysobjects WHERE Type='V' AND ID=OBJECT_ID('dbo.WMSSerieLoteLista'))
DROP VIEW dbo.WMSSerieLoteLista
GO
CREATE VIEW WMSSerieLoteLista
AS
SELECT DISTINCT
       Empresa,
       Almacen,
       SerieLote
  FROM SerieLote

GO

IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE TYPE='U' AND ID=OBJECT_ID('dbo.WMSEstatusControlCalidad'))
CREATE TABLE WMSEstatusControlCalidad(
RID INT IDENTITY(1,1),
EstatusControlCalidad VARCHAR(50) NULL,
Estatus VARCHAR(15))

GO

IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE TYPE='U' AND ID=OBJECT_ID('dbo.WMSTarmiaCambioHist'))
BEGIN
	CREATE TABLE WMSTarmiaCambioHist(
	RID INT IDENTITY(1,1),
	Empresa CHAR(5) NULL,
	Sucursal INT NULL,
	Ejercicio INT NULL,
	Periodo INT NULL,
	FechaRegistro DATETIME NULL,
	Usuario CHAR(10) NULL,
	Tarima VARCHAR(20) NULL,
	Almacen VARCHAR(10) NULL,
	Estatus VARCHAR(15) NULL,
	EstatusNuevo VARCHAR(50) NULL,
	EstatusControlCalidad VARCHAR(15) NULL)

	CREATE INDEX EmpTarima ON WMSTarmiaCambioHist(Tarima, Almacen , Sucursal, Empresa)
	CREATE INDEX EmpAlmFecha ON WMSTarmiaCambioHist(Almacen, FechaRegistro, Sucursal, Empresa)
END

GO

/**************************************    WMSTarimaDisponible   *******************************************/
IF NOT EXISTS(SELECT * FROM SYSTABLA WHERE SYSTABLA = 'WMSTarimaDisponible')
INSERT INTO SYSTABLA(SYSTABLA) VALUES ('WMSTarimaDisponible')
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DBO.WMSTarimaDisponible') AND TYPE = 'U') 
  CREATE TABLE DBO.WMSTarimaDisponible(
	Estacion		int				NOT NULL,
	Empresa			varchar(5)		NOT NULL,
	ID				int				NOT NULL,
	Modulo			varchar(20)		NOT NULL,
	ModuloID		int				NOT NULL,
	Movimiento		varchar(50)		NOT NULL,
	Almacen			varchar(10)		NOT NULL,
	Articulo		varchar(20)		NOT NULL,
	SubCuenta		varchar(50)		NOT NULL,
	Tarima			varchar(20)		NOT NULL,
	SerieLote		varchar(50)		NOT NULL,
	Disponible		float			NOT NULL,
	CantidadA		float			NULL
	CONSTRAINT PRIWMSTarimaDisponible PRIMARY KEY CLUSTERED(Estacion, Empresa, Modulo, ID, Articulo, Tarima, SerieLote)
  )
GO
EXEC spAlter_Table 'WMSTarimaDisponible','Apartado','float NULL DEFAULT 0'
GO

/**************************************    WMSPedidosSinSurtir    *******************************************/
IF NOT EXISTS(SELECT * FROM SYSTABLA WHERE SYSTABLA = 'WMSPedidosSinSurtir')
INSERT INTO SYSTABLA(SYSTABLA) VALUES ('WMSPedidosSinSurtir')
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DBO.WMSPedidosSinSurtir') AND TYPE = 'U') 
  CREATE TABLE DBO.WMSPedidosSinSurtir (
	Estacion		int					NOT NULL,
	ID				int identity(1,1)	NOT NULL,
	Empresa			varchar(5)			NOT NULL,
	Modulo			varchar(20)			NOT NULL,
	ModuloID		int					NOT NULL,
	Mov				varchar(20)			NOT NULL,
	MovID			varchar(20)			NOT NULL,
	RenglonID		int					NOT NULL,
	Sucursal		int					NOT NULL,
	Almacen			varchar(10)			NOT NULL,
	Articulo		varchar(20)			NOT NULL,
	SubCuenta		varchar(50)			NOT NULL,
	Tarima			varchar(20)			NOT NULL,
	Cantidad		float				NOT NULL
	CONSTRAINT PRIWMSPedidosSinSurtir PRIMARY KEY CLUSTERED(ID)
  )
GO

/**************************************   WMSTarimaSurtido   ***********************************************/
IF NOT EXISTS(SELECT * FROM SYSTABLA WHERE SYSTABLA = 'WMSTarimaSurtido')
INSERT INTO SYSTABLA(SYSTABLA) VALUES ('WMSTarimaSurtido')
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DBO.WMSTarimaSurtido') AND TYPE = 'U') 
  CREATE TABLE DBO.WMSTarimaSurtido (
	Estacion		int			NOT NULL,
	ID				int			NOT NULL,
	Empresa			varchar(5)	NOT NULL,
	Tarima			varchar(20) NOT NULL,
	SerieLote		varchar(50) NOT NULL,
	Articulo		varchar(20) NOT NULL,
	Almacen			varchar(10)	NOT NULL,		
	Posicion		varchar(10)	NULL,
	Disponible		float		NOT NULL,
	CantidadA		float		NULL DEFAULT 0,
	Movimiento		varchar(50)	NULL,
	OrigenTipo		varchar(10) NULL
	CONSTRAINT PRIWMSTarimaSurtido PRIMARY KEY  CLUSTERED(Estacion, ID, Articulo, Tarima, SerieLote)
  )
GO
EXEC spAlter_Table 'WMSTarimaSurtido','Apartado','float NULL DEFAULT 0'
GO

/*********************************** WMSPaquete ***********************************/
IF NOT EXISTS(SELECT * FROM sysobjects where name='WMSPaquete' and type='u')
CREATE TABLE WMSPaquete(
  Paquete           varchar(20)  NOT NULL,
  IDOrigen          int          NOT NULL,
  IDDestino         int          NOT NULL,
  Articulo          varchar(20)  NULL,
  Subcuenta         varchar(50)  NULL,
  Cantidad          float        NULL,
  Tarima            varchar(20)  NULL,
  TarimaSurtido     varchar(20)  NULL,
  Posicion          varchar(10)  NULL,
  PosicionDestino   varchar(10)  NULL,
  Sucursal          int          NULL,
  Usuario           varchar(10)  NULL,
  Fecha             datetime     NULL
)
GO

/*********************************** MovilLog ***********************************/
IF NOT EXISTS(SELECT * FROM sysobjects where name='MovilLog' and type='u')
CREATE TABLE MovilLog(
  RID               int identity(1,1) NOT NULL,
  Aplicacion        varchar(255)  NULL,
  Empresa           varchar(5)   NULL,
  Usuario           varchar(10)  NULL,
  Modulo            varchar(5)   NULL,
  ModuloID          int          NULL,
  RenglonID         int          NULL,
  Mov               varchar(20)  NULL,
  MovID             varchar(20)  NULL,
  Articulo          varchar(20)  NULL,
  Articulo2         varchar(20)  NULL,
  Subcuenta         varchar(50)  NULL,
  Subcuenta2        varchar(50)  NULL,
  Cantidad          float        NULL,
  Cantidad2         float        NULL,
  CodigoBarras      varchar(30)  NULL,
  FechaLog          datetime     NULL,
  Mensaje           varchar(255) NULL
)
GO

