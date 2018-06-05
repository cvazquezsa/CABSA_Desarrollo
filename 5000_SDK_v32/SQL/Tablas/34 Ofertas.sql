
/*******************************************************************************************/
/*                                             Oferta                         	           */
/*******************************************************************************************/

EXEC spDROP_TABLE 'OfertaTipo', 2982
EXEC spDROP_TABLE 'Oferta', 2982
EXEC spDROP_TABLE 'OfertaD', 2982
EXEC spDROP_TABLE 'OfertaDVol', 2982
EXEC spDROP_TABLE 'OfertaFiltro', 2982
EXEC spDROP_TABLE 'OfertaTipoForma', 2982
EXEC spDROP_TABLE 'OfertaTipoPaquete', 2982
EXEC spDROP_TABLE 'OfertaTipoObsequio', 2982
GO

/** CAMPOS CALCULADOS **/
EXEC spDROP_COLUMN 'OfertaD', 'PrecioLista'
EXEC spDROP_COLUMN 'OfertaD', 'CostoBase'
EXEC spDROP_COLUMN 'OfertaH', 'PrecioLista'
EXEC spDROP_COLUMN 'OfertaH', 'CostoBase'
GO

-- drop table OfertaTipo
/****** OfertaTipo ******/
if not exists(select * from SysTabla where SysTabla = 'OfertaTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OfertaTipo ','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OfertaTipo') and type = 'U') 
CREATE TABLE dbo.OfertaTipo  (
	Tipo			varchar(50)	NOT NULL,

	Forma			varchar(50)	NULL,		-- Precio, Descuento, Puntos, Obsequio, Comision
	Usar			varchar(50)	NULL,		-- Porcentaje, Importe, Margen, Margen Articulo, Margen Minimo, Otro
	TieneVolumen		bit		NULL	DEFAULT 0,
	AceptaDevolucion	bit		NULL	DEFAULT 0 ,--REQ 15448

	CONSTRAINT priOfertaTipo PRIMARY KEY CLUSTERED (Tipo)
)
go
--REQ 15448
 EXEC spALTER_TABLE 'OfertaTipo', 'AceptaDevolucion', 'bit NULL DEFAULT 0 WITH VALUES' 

/****** Consecutivos Oferta ******/
if not exists(select * from SysTabla where SysTabla = 'OfertaC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OfertaC', 'MovimientoInfo')
if not exists (select * from sysobjects where id = object_id('dbo.OfertaC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.OfertaC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priOfertaC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'OfertaC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'OfertaC', '(ID)'
GO

-- drop table Oferta
/****** Oferta (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'Oferta')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Oferta','MovimientoInfo','OFER')
if not exists (select * from sysobjects where id = object_id('dbo.Oferta') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Oferta (
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

	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	HoraD			varchar(5)	NULL,
	HoraA			varchar(5)	NULL,
	DiasEsp			varchar(50)	NULL,	

	Tipo			varchar(50)	NULL,
	Forma			varchar(50)	NULL,
	Usar			varchar(50)	NULL,
	TieneVolumen		bit		NULL	DEFAULT 0,
	MontoMinimo		money		NULL,
	TodasSucursales		bit		NULL	DEFAULT 1,

	Categoria		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Familia			varchar(50)	NULL,
	Linea			varchar(50)	NULL,
	Fabricante		varchar(50)	NULL,
	Proveedor		varchar(10)	NULL,
	Porcentaje		float		NULL,

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
	Obsequio        varchar(20) NULL,
	CantidadObsequio float NULL,
	GrupoTipo        varchar(50) NULL,
	CONSTRAINT priOferta PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Oferta'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Oferta'
go

EXEC spADD_INDEX 'Oferta', 'Referencia', 'Referencia'
EXEC spADD_INDEX 'Oferta', 'Consecutivo2', 'MovID, Mov, Estatus, Sucursal, Empresa'
EXEC spADD_INDEX 'Oferta', 'FechaEmision2', 'FechaEmision, Estatus, Empresa'
EXEC spADD_INDEX 'Oferta', 'Abrir2', 'Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion'
EXEC spADD_INDEX 'Oferta', 'Situacion3', 'Estatus, Situacion, Empresa'
EXEC spADD_INDEX 'Oferta', 'Usuario', 'Usuario'
EXEC spADD_INDEX 'Oferta', 'ContID', 'ContID'
go


if exists (select * from sysobjects where id = object_id('dbo.tgOfertaA') and sysstat & 0xf = 8) drop trigger dbo.tgOfertaA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgOfertaC') and sysstat & 0xf = 8) drop trigger dbo.tgOfertaC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgOfertaB') and sysstat & 0xf = 8) drop trigger dbo.tgOfertaB
GO
EXEC spModificarPK_Mov 'Oferta'
GO
EXEC spSincroNivelRegistroCampos 'Oferta'
GO
EXEC spALTER_TABLE 'Oferta', 'Proveedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Oferta', 'Obsequio', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Oferta', 'CantidadObsequio', 'float NULL'
EXEC spALTER_TABLE 'Oferta', 'GrupoTipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Oferta', 'Prioridad', 'int NULL'
GO
-- Aqui va el Matenimiento a la tabla

EXEC spFK 'Oferta','UEN','UEN','UEN'
EXEC spFK 'Oferta','Proyecto','Proy','Proyecto'
EXEC spFK 'Oferta','Moneda','Mon','Moneda'
EXEC spFK 'Oferta','Tipo','OfertaTipo','Tipo'
EXEC spFK 'Oferta','Proveedor','Prov','Proveedor'
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Oferta' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Oferta (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Oferta' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Oferta (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Oferta' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Oferta (OrigenID,Origen,Empresa)
go

CREATE TRIGGER tgOfertaC ON Oferta
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
  
  SELECT @Modulo = 'OFER'
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
    UPDATE Oferta SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgOfertaB ON Oferta
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
    EXEC spMovAlEliminar 'OFER', @ID
END
GO


-- drop table OfertaFiltro
/****** OfertaFiltro ******/
if not exists(select * from SysTabla where SysTabla = 'OfertaFiltro')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('OfertaFiltro','MovimientoInfo','OFER')
if not exists (select * from sysobjects where id = object_id('dbo.OfertaFiltro') and type = 'U') 
BEGIN
  CREATE TABLE dbo.OfertaFiltro (
	ID			int		NOT NULL,
	RID			int		NOT NULL 	IDENTITY(1,1),

	Campo			varchar(50)	NULL,		-- Almacen, Cliente, Grupo Cliente, etc.
	Valor			varchar(100)	NULL,

	CONSTRAINT priOfertaFiltro PRIMARY KEY CLUSTERED (ID, RID)
  )
  EXEC spSincroSemilla 'OfertaFiltro'
END
go
EXEC spModificarPK_Sucursal 'OfertaFiltro', '(ID, RID)'
GO
EXEC spADD_INDEX 'OfertaFiltro', 'Campo', 'ID, Campo'
GO
EXEC spADD_INDEX 'OfertaFiltro', 'Valor', 'ID, Campo, Valor'
GO
-- drop table OfertaSucursalEsp
if not exists(select * from SysTabla where SysTabla = 'OfertaSucursalEsp')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('OfertaSucursalEsp','MovimientoInfo','OFER')
if not exists (select * from sysobjects where id = object_id('dbo.OfertaSucursalEsp') and type = 'U') 
  CREATE TABLE dbo.OfertaSucursalEsp (
	ID			int		NOT NULL,
	SucursalEsp		int		NOT NULL,

	CONSTRAINT priOfertaSucursalEsp PRIMARY KEY CLUSTERED (ID, SucursalEsp)
  )
go
EXEC spModificarPK_Sucursal 'OfertaSucursalEsp', '(ID, SucursalEsp)'
GO

EXEC spFK 'OfertaSucursalEsp','SucursalEsp','Sucursal','Sucursal'
GO

-- drop table OfertaD
/****** OfertaD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'OfertaD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('OfertaD','MovimientoInfo','OFER')
if not exists (select * from sysobjects where id = object_id('dbo.OfertaD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.OfertaD (
	ID				int			NOT NULL,
	Renglon			float		NOT NULL,
	Articulo		varchar(20)	NOT NULL,
	SubCuenta		varchar(50) NULL,
	Obsequio		varchar(20)	NULL,
	Cantidad		float		NULL,
	Porcentaje		float		NULL,
	Precio			float		NULL,
	Importe			money		NULL,


	CONSTRAINT priOfertaD PRIMARY KEY CLUSTERED (ID, Renglon)
  )
  EXEC spSincroSemilla 'OfertaD'
  EXEC spModificarPK_Sucursal 'OfertaD', '(ID, Renglon)'
  EXEC spADD_INDEX 'OfertaD', 'Articulo', 'Articulo, SubCuenta'
END
go

EXEC spFK 'OfertaD','ID','Oferta','ID'
EXEC spFK 'OfertaD','Articulo','Art','Articulo'
GO

--REQ 13393
 EXEC spALTER_TABLE 'OfertaD', 'Moneda'	,	'varchar(10)	NULL' 
 EXEC spALTER_TABLE 'OfertaD', 'Unidad', 'varchar(50) NULL'
 EXEC spALTER_TABLE 'OfertaD', 'Factor', 'float NULL'
 EXEC spALTER_TABLE 'OfertaD', 'UnidadObsequio', 'varchar(50) NULL'
 EXEC spALTER_TABLE 'OfertaD', 'FactorObsequio', 'float NULL'
 EXEC spALTER_TABLE 'OfertaD', 'SubCuentaObsequio', 'varchar(50) NULL'
 GO
if not exists(select * from syscampo where tabla = 'OfertaD' and campo= 'Renglon')
BEGIN
  BEGIN TRAN
  
  ALTER TABLE OfertaD ADD Renglon float NULL
  ALTER TABLE OfertaD ADD SubCuenta varchar(50) NULL

  DECLARE @OfertaID		int,
		  @Renglon		float,
		  @Error		int,
		  @Articulo		varchar(20),
		  @SQL			varchar(100)
  SELECT @Error = 0

  DECLARE crOfertaDActualizaRenglon CURSOR FOR
  SELECT DISTINCT ID
    FROM OfertaD od

  OPEN crOfertaDActualizaRenglon
  FETCH NEXT FROM crOfertaDActualizaRenglon INTO @OfertaID
  WHILE @@FETCH_STATUS <> -1 AND @ERROR = 0
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @ERROR = 0
    BEGIN
      SELECT @Renglon = 2048
      
      DECLARE crOfertaDActualizaRenglon2 CURSOR FOR
      SELECT Articulo
        FROM OfertaD od
       WHERE ID = @OfertaID
       
      OPEN crOfertaDActualizaRenglon2
      FETCH NEXT FROM crOfertaDActualizaRenglon2 INTO @Articulo
      WHILE @@FETCH_STATUS <> -1 AND @Error = 0
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Error = 0
        BEGIN
          SELECT @SQL = 'UPDATE OfertaD SET Renglon = ' + RTRIM(@Renglon) + ' WHERE ID = '  + RTRIM(@OfertaID) + ' AND Articulo = "' + RTRIM(@Articulo) +'"'
          EXEC(@SQL)
          IF @@ERROR <> 0 SELECT @Error = 1
          SELECT @Renglon = @Renglon + 2048
        END
        FETCH NEXT FROM crOfertaDActualizaRenglon2 INTO @Articulo
      END
      
      CLOSE crOfertaDActualizaRenglon2
      DEALLOCATE crOfertaDActualizaRenglon2
    END
    FETCH NEXT FROM crOfertaDActualizaRenglon INTO @OfertaID
  END
  
  CLOSE crOfertaDActualizaRenglon
  DEALLOCATE crOfertaDActualizaRenglon

  IF @Error = 0 --AND NOT EXISTS(SELECT ID FROM OfertaD od WHERE Renglon IS NULL)
  BEGIN
  	ALTER TABLE OfertaD ALTER COLUMN Renglon float NOT NULL
  	EXEC spALTER_PK 'OfertaD', 'ID, Renglon'
    EXEC spModificarPK_Sucursal 'OfertaD', '(ID, Renglon)'
    EXEC spADD_INDEX 'OfertaD', 'Articulo', 'Articulo, SubCuenta'
    COMMIT TRAN
  END
  ELSE
  	ROLLBACK TRAN

END
GO

if exists (select * from sysobjects where id = object_id('dbo.cOfertaD') and sysstat & 0xf = 2) drop view dbo.cOfertaD
GO
CREATE VIEW cOfertaD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  Articulo,
  SubCuenta,
  Obsequio,
  Cantidad,
  Porcentaje,
  Precio,
  Importe,
  Sucursal,
  SucursalOrigen,
  Moneda,
  Unidad,
  Factor,
  UnidadObsequio,
  FactorObsequio,
  SubCuentaObsequio
FROM
  OfertaD
GO

if exists (select * from sysobjects where id = object_id('dbo.tgOfertaD') and sysstat & 0xf = 8) drop trigger dbo.tgOfertaD
GO
CREATE TRIGGER tgOfertaD ON OfertaD
--//WITH ENCRYPTION
FOR INSERT
AS BEGIN
  DECLARE
    @ID int,
    @Mov varchar(20),
    @MovTipo varchar(20),
    @Estatus varchar(20)
    
  SELECT @ID = ID FROM inserted 
  IF @ID IS NOT NULL
  BEGIN
    SELECT @Mov = Mov, @Estatus = Estatus FROM Oferta WHERE ID = @ID
    SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'OFER' AND Mov = @Mov
    IF @MovTipo = 'OFER.OM' AND @Estatus = 'SINAFECTAR'
    IF (SELECT COUNT(Articulo) FROM OfertaD WHERE ID = @ID) > 1
      RAISERROR('Este movimiento Solo Permite Usar Un Articulo', 16, -1)
  END
END
GO

-- drop table OfertaDVol
/****** OfertaDVol (Volumen) ******/
if not exists(select * from SysTabla where SysTabla = 'OfertaDVol')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('OfertaDVol','Movimiento','OFER')
if not exists (select * from sysobjects where id = object_id('dbo.OfertaDVol') and type = 'U') 
  CREATE TABLE dbo.OfertaDVol (
	ID			int			NOT NULL,
	Articulo		varchar(20)		NOT NULL,
	Desde			float			NOT NULL,	-- a partir de 
	Hasta			float			NULL,		-- Hasta

	Cantidad		float		NULL,
	Porcentaje		float		NULL,
	Precio			float		NULL,
	Importe			money		NULL,

	CONSTRAINT priOfertaDVol PRIMARY KEY CLUSTERED (ID, Articulo, Desde)
)
go
EXEC spModificarPK_Sucursal 'OfertaDVol', '(ID, Articulo, Desde)'
GO

-- drop table OfertaH
/****** OfertaH ******/
if not exists(select * from SysTabla where SysTabla = 'OfertaH')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OfertaH', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.OfertaH') and type = 'U') 
  CREATE TABLE dbo.OfertaH (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL,
	Articulo		varchar(20)	NOT NULL,

	Monto1			float		NULL,
	Monto2			float		NULL,
	Monto3			float		NULL,
	Monto4			float		NULL,
	Monto5			float		NULL,
	Monto6			float		NULL,
	Monto7			float		NULL,
	Monto8			float		NULL,
	Monto9			float		NULL,
	Monto10			float		NULL,

	CONSTRAINT priOfertaH PRIMARY KEY CLUSTERED (Estacion, ID, Articulo)
)
go

EXEC spFK 'OfertaH','Articulo','Art','Articulo'
GO

-- drop table OfertaHVol 
/****** OfertaHVol (Volumen) ******/
if not exists(select * from SysTabla where SysTabla = 'OfertaHVol')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OfertaHVol','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.OfertaHVol') and type = 'U') 
  CREATE TABLE dbo.OfertaHVol (
	Estacion	int		NOT NULL,
	ID		int		NOT NULL,
	Cantidad	float		NOT NULL,	-- a partir de 

	CONSTRAINT priOfertaHVol PRIMARY KEY CLUSTERED (Estacion, ID, Cantidad)
)
GO
--Task 19293
/****** OfertaCascadaGrupo ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'OfertaCascadaGrupo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OfertaCascadaGrupo', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.OfertaCascadaGrupo') AND type = 'U') 
  CREATE TABLE dbo.OfertaCascadaGrupo (
        ID         int NOT NULL,
        Desde      float NOT NULL,
        Hasta      float NULL,
        Porcentaje float NULL,
  CONSTRAINT priOfertaCascadaGrupo PRIMARY KEY CLUSTERED (ID,Desde)
  )
GO
EXEC spALTER_TABLE 'OfertaCascadaGrupo', 'RID', 'int identity(1,1) NOT NULL' --Bug 5048
EXEC spALTER_PK 'OfertaCascadaGrupo', 'ID, RID'
/**************** spOfertaArtListaAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaArtListaAceptar') and type = 'P') drop procedure dbo.spOfertaArtListaAceptar
GO             
CREATE PROCEDURE spOfertaArtListaAceptar
				@Estacion	int,
				@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Renglon			float,
  @Articulo			varchar(20)
  -- SET nocount ON
  DECLARE crOfertaArtListaAceptar CURSOR LOCAL FOR
  SELECT a.Articulo
    FROM Art a
   WHERE a.Articulo IN (SELECT Clave FROM ListaSt WHERE Estacion = @Estacion) 
     AND a.Articulo NOT IN (SELECT Articulo FROM OfertaD WHERE ID = @ID)

  SELECT @Renglon = Max(Renglon) FROM OfertaD od WHERE od.ID = @ID
  SELECT @Renglon = ISNULL(@Renglon, 0) + 2048
     
  OPEN crOfertaArtListaAceptar
  FETCH NEXT FROM crOfertaArtListaAceptar INTO @Articulo
  WHILE @@FETCH_STATUS = 0
  BEGIN
  	INSERT OfertaD (ID, Renglon, Articulo)
  	VALUES(@ID, @Renglon, @Articulo)
  	
  	SELECT @Renglon = @Renglon + 2048
  	
  	FETCH NEXT FROM crOfertaArtListaAceptar INTO @Articulo
  END
  
  CLOSE crOfertaArtListaAceptar
  DEALLOCATE crOfertaArtListaAceptar
     
  RETURN
END
GO

-- select * from ofertaH
-- spOfertaHSugerir 100,3
/**************** spOfertaHSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaHSugerir') and type = 'P') drop procedure dbo.spOfertaHSugerir
GO             
CREATE PROCEDURE spOfertaHSugerir
                    @Estacion	int,
		    @ID		int
--//WITH ENCRYPTION
AS BEGIN
  DELETE OfertaH WHERE Estacion = @Estacion AND ID = @ID AND Articulo NOT IN (SELECT Articulo FROM OfertaD WHERE ID = @ID)
  INSERT OfertaH (Estacion, ID, Articulo) SELECT @Estacion, @ID, Articulo FROM OfertaD WHERE ID = @ID AND Articulo NOT IN (SELECT Articulo FROM OfertaH WHERE Estacion = @Estacion AND ID = @ID)
  IF NOT EXISTS(SELECT * FROM OfertaHVol WHERE Estacion = @Estacion AND ID = @ID)
    INSERT OfertaHVol (Estacion, ID, Cantidad) VALUES (@Estacion, @ID, 1)
  RETURN
END
GO

/**************** spOfertaHVolGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaHVolGenerar') and type = 'P') drop procedure dbo.spOfertaHVolGenerar
GO             
CREATE PROCEDURE spOfertaHVolGenerar
			@Estacion	int,
			@ID		int,
			@Sucursal	int,
			@Desde		float,
			@Hasta		float,
			@Usar		varchar(50),
			@Monto		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL	nvarchar(4000),
    @MAXFLOAT	float

  SELECT @MAXFLOAT = 999999999.0
  SELECT @SQL = 
    N'INSERT OfertaDVol (
             ID,  Sucursal,  SucursalOrigen, Articulo, Desde,  Hasta,                     '+@Usar+')
      SELECT @ID, @Sucursal, @Sucursal,      Articulo, @Desde, ISNULL(@Hasta, @MAXFLOAT), Monto'+CONVERT(varchar, @Monto)+
      ' FROM OfertaH
       WHERE Estacion = @Estacion AND ID = @ID'
  EXEC sp_ExecuteSQL @SQL, N'@Estacion int, @ID int, @Sucursal int, @Desde float, @Hasta float, @MAXFLOAT float', @Estacion, @ID, @Sucursal, @Desde, @Hasta, @MAXFLOAT
END
GO

/**************** spOfertaHGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOfertaHGenerar') and type = 'P') drop procedure dbo.spOfertaHGenerar
GO             
CREATE PROCEDURE spOfertaHGenerar
                    @Estacion	int,
		    @ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal	int,
    @Usar	varchar(20),
    @Desde	float,
    @Hasta	float

  SELECT @Sucursal = Sucursal, @Usar = Usar FROM Oferta WHERE ID = @ID
  DELETE OfertaD    WHERE ID = @ID  
  DELETE OfertaDVol WHERE ID = @ID  

  SELECT @Desde = NULL, @Hasta = NULL
  IF @Usar = 'PRECIO'
    INSERT OfertaD (
           ID,  Renglon, Sucursal,  SucursalOrigen, Articulo, Precio) 
    SELECT @ID, 2048.0,  @Sucursal, @Sucursal,      Articulo, Monto1
      FROM OfertaH
     WHERE Estacion = @Estacion AND ID = @ID
  ELSE IF @Usar = 'PORCENTAJE'
    INSERT OfertaD (
           ID,  Renglon,  Sucursal,  SucursalOrigen, Articulo, Porcentaje) 
    SELECT @ID, 2048.0,   @Sucursal, @Sucursal,      Articulo, Monto1
      FROM OfertaH
     WHERE Estacion = @Estacion AND ID = @ID
  ELSE IF @Usar = 'CANTIDAD'
    INSERT OfertaD (
           ID,  Renglon,  Sucursal,  SucursalOrigen, Articulo, Cantidad) 
    SELECT @ID, 2048.0,   @Sucursal, @Sucursal,      Articulo, Monto1
      FROM OfertaH
     WHERE Estacion = @Estacion AND ID = @ID
  ELSE IF @Usar = 'IMPORTE'
    INSERT OfertaD (
           ID,  Renglon,  Sucursal,  SucursalOrigen, Articulo, Importe) 
    SELECT @ID, 2048.0,   @Sucursal, @Sucursal,      Articulo, Monto1
      FROM OfertaH
     WHERE Estacion = @Estacion AND ID = @ID

  DECLARE crEscala CURSOR LOCAL FOR
   SELECT Cantidad 
     FROM OfertaHVol
    WHERE Estacion = @Estacion AND ID = @ID
  OPEN crEscala

  FETCH NEXT FROM crEscala INTO @Desde
  --IF @@FETCH_STATUS = 0 
  --  FETCH NEXT FROM crEscala INTO @Desde

  
  IF @@FETCH_STATUS = 0 
  BEGIN
    FETCH NEXT FROM crEscala INTO @Hasta
    EXEC spOfertaHVolGenerar @Estacion, @ID, @Sucursal, @Desde, @Hasta, @Usar, 1
  END
  
  SELECT @Desde = @Hasta, @Hasta = NULL
  IF @@FETCH_STATUS = 0 
  BEGIN
    FETCH NEXT FROM crEscala INTO @Hasta
    EXEC spOfertaHVolGenerar @Estacion, @ID, @Sucursal, @Desde, @Hasta, @Usar, 2
  END

  -- Monto 4
  SELECT @Desde = @Hasta, @Hasta = NULL
  IF @@FETCH_STATUS = 0 
  BEGIN
    FETCH NEXT FROM crEscala INTO @Hasta
    EXEC spOfertaHVolGenerar @Estacion, @ID, @Sucursal, @Desde, @Hasta, @Usar, 3
  END

  -- Monto 5
  SELECT @Desde = @Hasta, @Hasta = NULL
  IF @@FETCH_STATUS = 0 
  BEGIN
    FETCH NEXT FROM crEscala INTO @Hasta
    EXEC spOfertaHVolGenerar @Estacion, @ID, @Sucursal, @Desde, @Hasta, @Usar, 4
  END

  -- Monto 6
  SELECT @Desde = @Hasta, @Hasta = NULL
  IF @@FETCH_STATUS = 0 
  BEGIN
    FETCH NEXT FROM crEscala INTO @Hasta
    EXEC spOfertaHVolGenerar @Estacion, @ID, @Sucursal, @Desde, @Hasta, @Usar, 5
  END

  -- Monto 7
  SELECT @Desde = @Hasta, @Hasta = NULL
  IF @@FETCH_STATUS = 0 
  BEGIN
    FETCH NEXT FROM crEscala INTO @Hasta
    EXEC spOfertaHVolGenerar @Estacion, @ID, @Sucursal, @Desde, @Hasta, @Usar, 6
  END

  -- Monto 8
  SELECT @Desde = @Hasta, @Hasta = NULL
  IF @@FETCH_STATUS = 0 
  BEGIN
    FETCH NEXT FROM crEscala INTO @Hasta
    EXEC spOfertaHVolGenerar @Estacion, @ID, @Sucursal, @Desde, @Hasta, @Usar, 7
  END

  -- Monto 9
  SELECT @Desde = @Hasta, @Hasta = NULL
  IF @@FETCH_STATUS = 0 
  BEGIN
    FETCH NEXT FROM crEscala INTO @Hasta
    EXEC spOfertaHVolGenerar @Estacion, @ID, @Sucursal, @Desde, @Hasta, @Usar, 8
  END

  -- Monto 10
  SELECT @Desde = @Hasta, @Hasta = NULL
  IF @@FETCH_STATUS = 0 
  BEGIN
    FETCH NEXT FROM crEscala INTO @Hasta
    EXEC spOfertaHVolGenerar @Estacion, @ID, @Sucursal, @Desde, @Hasta, @Usar, 9
  END
  
    -- Monto 11
  SELECT @Desde = @Hasta, @Hasta = NULL
  IF @@FETCH_STATUS = 0 
  BEGIN
    FETCH NEXT FROM crEscala INTO @Hasta
    EXEC spOfertaHVolGenerar @Estacion, @ID, @Sucursal, @Desde, @Hasta, @Usar, 10
  END

  CLOSE crEscala
  DEALLOCATE crEscala

  -- Borrar 
  DELETE OfertaDVol WHERE ID = @ID AND NULLIF(Precio, 0.0) IS NULL AND NULLIF(Cantidad, 0.0) IS NULL AND NULLIF(Porcentaje, 0.0) IS NULL AND NULLIF(Importe, 0.0) IS NULL
  DELETE OfertaH WHERE Estacion = @Estacion
  DELETE OfertaHVol WHERE Estacion = @Estacion
  RETURN
END
GO

-- select dbo.fnArtPrecioLista('A1')
/**************** fnArtPrecioLista ****************/
IF exists (SELECT name FROM sysobjects WHERE name = 'fnArtPrecioLista') DROP FUNCTION dbo.fnArtPrecioLista
GO
CREATE FUNCTION fnArtPrecioLista (@Articulo varchar(20))
RETURNS money
--//WITH ENCRYPTION
AS BEGIN 
  RETURN(SELECT PrecioLista FROM Art WHERE Articulo=@Articulo)
END
GO

-- select dbo.fnOfertaArtCostoBase(3, 'A1')
/**************** fnOfertaArtCostoBase ****************/
IF exists (SELECT name FROM sysobjects WHERE name = 'fnOfertaArtCostoBase') DROP FUNCTION dbo.fnOfertaArtCostoBase
GO
CREATE FUNCTION fnOfertaArtCostoBase (@ID int, @Articulo varchar(20))
RETURNS money
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Base	varchar(50),
    @Empresa	varchar(5),
    @Moneda	varchar(10),
    @TipoCambio	float

  SELECT @Empresa = o.Empresa, @Moneda = o.Moneda, @TipoCambio = o.TipoCambio, @Base = gral.CostoBase 
    FROM Oferta o
    JOIN EmpresaGral gral ON gral.Empresa = o.Empresa
   WHERE o.ID = @ID

  RETURN(SELECT dbo.fnPCGet(@Empresa, 0, @Moneda, @TipoCambio, @Articulo, NULL, NULL, @Base))
END
GO

GO
EXEC spALTER_TABLE 'OfertaD', 'PrecioLista', 'AS dbo.fnArtPrecioLista(Articulo)'
EXEC spALTER_TABLE 'OfertaD', 'CostoBase', 'AS dbo.fnOfertaArtCostoBase(ID, Articulo)'
EXEC spALTER_TABLE 'OfertaH', 'PrecioLista', 'AS dbo.fnArtPrecioLista(Articulo)'
EXEC spALTER_TABLE 'OfertaH', 'CostoBase', 'AS dbo.fnOfertaArtCostoBase(ID, Articulo)'
GO
EXEC spALTER_TABLE 'Oferta', 'PrioridadG', 'int NULL'
EXEC spALTER_TABLE 'Oferta', 'CategoriaD','varchar(50) NULL'
EXEC spALTER_TABLE 'Oferta', 'GrupoD','varchar(50) NULL'
EXEC spALTER_TABLE 'Oferta', 'FamiliaD','varchar(50) NULL'
EXEC spALTER_TABLE 'Oferta', 'LineaD','varchar(50) NULL'
EXEC spALTER_TABLE 'Oferta', 'FabricanteD','varchar(50) NULL'
EXEC spALTER_TABLE 'Oferta', 'ProveedorD','varchar(50) NULL'
EXEC spALTER_TABLE 'Oferta', 'ABC','varchar(50) NULL'
EXEC spALTER_TABLE 'Oferta', 'FormaPago','varchar(50) NULL'
EXEC spALTER_TABLE 'Oferta', 'Articulo','varchar(20) NULL'
EXEC spALTER_TABLE 'OfertaDVol', 'ListaPrecios', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Oferta', 'ListaPreciosEsp','varchar(20) NULL'
EXEC spALTER_TABLE 'OfertaTipo', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'Oferta', 'Unidad','varchar(50) NULL'
EXEC spALTER_TABLE 'Oferta', 'UnidadObsequio', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Oferta', 'SubCuentaObsequio', 'varchar(50) NULL'


GO
/****** OfertaLog (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'OfertaLog')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('OfertaLog','MovimientoInfo','OFER')
if not exists (select * from sysobjects where id = object_id('dbo.OfertaLog') and type = 'U') 
BEGIN
    CREATE TABLE OfertaLog (
	  ID					int NOT NULL,
	  OfertaID              int NOT NULL,
	  RID                   int NOT NULL,
	  Mov                   varchar(20)NULL,
	  MovID                 varchar(20)NULL,
	  Prioridad				int NULL,
	  PrioridadG			int NULL,
	  Tipo                  varchar(20)NULL,
	  Forma                 varchar(20)NULL,
	  Usar                  varchar(20)NULL,
	  Articulo				varchar(20) COLLATE Database_Default NOT NULL, 
	  SubCuenta				varchar(50) COLLATE Database_Default NULL, 
	  Unidad				varchar(50) COLLATE Database_Default NULL, 
	  Descuento				float NULL,
	  DescuentoImporte		money NULL, 
	  Puntos				float NULL, 
	  PuntosPorcentaje		float NULL, 
	  Comision				float NULL, 
	  ComisionPorcentaje	float NULL, 
	  CantidadObsequio		float NULL,
	  Costo					float NULL,
	  PrecioBaseCosto		float NULL,
	  PrecioBaseLista		float NULL,
	  Precio				float NULL,
	  ArticuloObsequio		varchar(20)NULL,
	  UnidadObsequio		varchar(5) NULL,
	  ArtTipo				varchar(20)NULL,
	  CantidadOferta		float NULL,
	  DescuentoP1			float NULL,
	  DescuentoP2			float NULL,
	  DescuentoP3			float NULL,
	  DescuentoG1			float NULL,
	  DescuentoG2			float NULL,
	  DescuentoG3			float NULL,
	  SucursalDetalle	    int	 NULL,
	  OfertaIDP1			int NULL,
	  OfertaIDP2			int NULL,
	  OfertaIDP3			int NULL,
	  OfertaIDG1			int NULL,
	  OfertaIDG2			int NULL,
	  OfertaIDG3			int NULL)
END
GO
EXEC spALTER_TABLE 'OfertaLog', 'Descripcion','varchar(255) NULL'
EXEC spALTER_TABLE 'OfertaLog', 'SubCuentaObsequio','varchar(50) NULL'
EXEC spALTER_COLUMN 'OfertaLog', 'Tipo','varchar(50) NULL'
EXEC spALTER_COLUMN 'OfertaLog', 'Forma','varchar(50) NULL'
EXEC spALTER_COLUMN 'OfertaLog', 'Usar','varchar(50) NULL'
EXEC spALTER_COLUMN 'OfertaLog', 'UnidadObsequio','varchar(50) NULL'
EXEC spALTER_COLUMN 'OfertaLog', 'Descripcion','varchar(255) NULL'
GO
/****** OfertaLogPos (Ficha) ******/
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'OfertaLogPos' AND COLUMN_NAME = 'IDOferta')
	DROP TABLE OfertaLogPos
if not exists(select * from SysTabla where SysTabla = 'OfertaLogPos')
	INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('OfertaLogPos','MovimientoInfo','OFER')
if not exists (select * from sysobjects where id = object_id('dbo.OfertaLogPos') and type = 'U') 
BEGIN
    CREATE TABLE OfertaLogPos (
	  ID					varchar(36) not null,
	  OfertaID              int NOT NULL,
	  RID                   int NOT NULL,
	  Mov                   varchar(20)NULL,
	  MovID                 varchar(20)NULL,
	  Prioridad				int NULL,
	  PrioridadG			int NULL,
	  Tipo                  varchar(20)NULL,
	  Forma                 varchar(20)NULL,
	  Usar                  varchar(20)NULL,
	  Articulo				varchar(20) COLLATE Database_Default NOT NULL, 
	  SubCuenta				varchar(50) COLLATE Database_Default NULL, 
	  Unidad				varchar(50) COLLATE Database_Default NULL, 
	  Descuento				float NULL,
	  DescuentoImporte		money NULL, 
	  Puntos				float NULL, 
	  PuntosPorcentaje		float NULL, 
	  Comision				float NULL, 
	  ComisionPorcentaje	float NULL, 
	  CantidadObsequio		float NULL,
	  Costo					float NULL,
	  PrecioBaseCosto		float NULL,
	  PrecioBaseLista		float NULL,
	  Precio				float NULL,
	  ArticuloObsequio		varchar(20)NULL,
	  UnidadObsequio		varchar(5) NULL,
	  ArtTipo				varchar(20)NULL,
	  CantidadOferta		float NULL,
	  DescuentoP1			float NULL,
	  DescuentoP2			float NULL,
	  DescuentoP3			float NULL,
	  DescuentoG1			float NULL,
	  DescuentoG2			float NULL,
	  DescuentoG3			float NULL,
	  SucursalDetalle	    int	 NULL,
	  OfertaIDP1			int NULL,
	  OfertaIDP2			int NULL,
	  OfertaIDP3			int NULL,
	  OfertaIDG1			int NULL,
	  OfertaIDG2			int NULL,
	  OfertaIDG3			int NULL,
	  EsPuntos              bit NULL)
END
GO
EXEC spALTER_TABLE 'OfertaLogPos', 'EsPuntos','bit NULL'
EXEC spALTER_TABLE 'OfertaLogPos', 'SubCuentaObsequio','varchar(50) NULL'
EXEC spALTER_TABLE 'OfertaLogPos', 'Descripcion','varchar(255) NULL'
EXEC spALTER_COLUMN 'OfertaLogPos', 'Tipo','varchar(50) NULL'
EXEC spALTER_COLUMN 'OfertaLogPos', 'Forma','varchar(50) NULL'
EXEC spALTER_COLUMN 'OfertaLogPos', 'Usar','varchar(50) NULL'
EXEC spALTER_TABLE 'OfertaLogPos', 'UnidadObsequio','varchar(50) NULL'
EXEC spALTER_COLUMN 'OfertaLogPos', 'Descripcion','varchar(255) NULL'
GO