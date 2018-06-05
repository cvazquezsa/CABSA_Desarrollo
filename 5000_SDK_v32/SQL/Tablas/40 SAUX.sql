/*******************************************************************************************/
/*                                         SAUX                             	           */
/*******************************************************************************************/

/****** SAUX (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'SAUX')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('SAUX','Movimiento','SAUX')
if not exists (select * from sysobjects where id = object_id('dbo.SAUX') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SAUX (
	ID 					int         NOT NULL IDENTITY(1,1),
	Empresa				char(5)	    NOT NULL,
	Sucursal			int			NOT NULL DEFAULT 0,
	Usuario 			char(10)   		NULL,
	Mov  				char(20)    NOT NULL,
	MovID				varchar(20)    	NULL,	 
	TipoContacto	    varchar(10)		NULL,
	Contacto			varchar(10)		NULL,
	EnviarA				int				NULL,
	FechaEmision 		datetime    	NULL,	 	
	FechaEntrega 		datetime    	NULL,	 
	Concepto			varchar(50)		NULL,
	Proyecto  			varchar(50)   	NULL,
	Referencia 			varchar(50) 	NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 			char(15)   		NULL,
	Situacion			varchar(50)		NULL,
	SituacionFecha		datetime		NULL,
	SituacionUsuario	varchar(10)		NULL,
	SituacionNota		varchar(100)	NULL,
	OrigenTipo			varchar(10)		NULL,
	Origen				varchar(20)		NULL,
	OrigenID			varchar(20)		NULL,				
	UltimoCambio 		datetime    	NULL,

	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	UEN					int				NULL,
    Periodo				int				NULL,
	Ejercicio			int				NULL,
	FechaRegistro		datetime		NULL, 

	CONSTRAINT priSAUX PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'SAUX'
END
go
EXEC spSincroNivelRegistro @Tabla = 'SAUX'
go

if exists (select * from sysobjects where id = object_id('dbo.tgSAUXA') and sysstat & 0xf = 8) drop trigger dbo.tgSAUXA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSAUXC') and sysstat & 0xf = 8) drop trigger dbo.tgSAUXC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSAUXB') and sysstat & 0xf = 8) drop trigger dbo.tgSAUXB
GO
EXEC spModificarPK_Mov 'SAUX'
GO
EXEC spSincroNivelRegistroCampos 'SAUX'
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SAUX' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON SAUX (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SAUX' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON SAUX (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SAUX' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON SAUX (OrigenID,Origen,Empresa)
go

-- Aqui va el Matenimiento a la tabla

GO
CREATE TRIGGER tgSAUXC ON SAUX
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
  
  SELECT @Modulo = 'SAUX'
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
END
GO

CREATE TRIGGER tgSAUXB ON SAUX
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
    EXEC spMovAlEliminar 'SAUX', @ID
END
GO

/****** SAUXD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'SAUXD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('SAUXD','Movimiento','SAUX')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXD') and type = 'U') 
CREATE TABLE dbo.SAUXD (
	ID 						int       	NOT NULL,
	Renglon					float		NOT NULL,
	Producto				varchar(20)		NULL,
	SubProducto				varchar(20)		NULL,
	Servicio				varchar(20)		NULL,
	Codigo					varchar(20)		NULL,
	Cantidad				float			NULL,
	CantidadPendeiente		float			NULL,
	CantidadCancelada		float			NULL,
	CantidadA				float			NULL,
	FechaRequerida			datetime		NULL,
	FechaInicio				datetime		NULL,
	FechaFin				datetime		NULL,
	FechaEntrega			datetime		NULL,
	Estado					varchar(15)		NULL	DEFAULT 'SINAFECTAR',
	Observaciones			varchar(100)	NULL,
	Prioridad				varchar(100)	NULL,
	Aplica					varchar(20)		NULL,
	AplicaID				varchar(20)		NULL,

	CONSTRAINT priSAUXD PRIMARY KEY CLUSTERED (ID, Renglon)
)
go

if exists (select * from sysobjects where id = object_id('dbo.cSAUXD') and sysstat & 0xf = 2) drop view dbo.cSAUXD
GO
CREATE VIEW cSAUXD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  Producto,
  SubProducto,
  Servicio,
  Codigo,
  Cantidad,
  CantidadPendeiente,
  CantidadCancelada,
  CantidadA,
  FechaRequerida,
  FechaInicio,
  FechaFin,
  FechaEntrega,
  Estado,
  Observaciones,
  Prioridad

FROM
  SAUXD
GO

/****** Consecutivos SAUX ******/
if not exists(select * from SysTabla where SysTabla = 'SAUXC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SAUXC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SAUXC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)     NULL,
	Mov 		    char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int			NULL,
	Ejercicio		int			NULL,

	Consecutivo 	int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priSAUXC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'SAUXC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'SAUXC', '(ID)'
GO

/****** SAUXDIndicador (Referencia) ******/
if not exists(select * from SysTabla where SysTabla = 'SAUXDIndicador')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('SAUXDIndicador','Movimiento','SAUX')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXDIndicador') and type = 'U') 
CREATE TABLE dbo.SAUXDIndicador (
	ID 				int       	NOT NULL,
	Renglon			float		NOT NULL,
	Indicador		varchar(20)	NOT	NULL,
	Servicio		varchar(20)		NULL,
	Producto		varchar(20)		NULL,
	Valor			varchar(255)	NULL,		
	Observaciones	varchar(100)	NULL,

	CONSTRAINT priSAUXDIndicador PRIMARY KEY CLUSTERED (ID, Renglon, Indicador)
)
GO

/****** SAUXServicio ******/
if not exists(select * from SysTabla where SysTabla = 'SAUXServicio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SAUXServicio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXServicio') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SAUXServicio (
	Servicio		varchar(20) NOT NULL,
 	
 	Descripcion		varchar(100)	NULL,
	Descripcion2	varchar(100)	NULL,
	Categoria		varchar (50)	NULL,
	Grupo			varchar (50)	NULL,
	Familia			varchar (50)	NULL,
	Estatus			varchar (15)	NULL,
	Tipo			varchar (30)	NULL,
	Movimiento		varchar (20)	NULL,    

 	CONSTRAINT priSAUXServicio PRIMARY KEY  CLUSTERED (Servicio)
  )
  EXEC spSincroSemilla 'SAUXServicio'
END
GO

/*** SAUXServicioGrupo ***/
if not exists(select * from SysTabla where SysTabla = 'SAUXServicioGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SAUXServicioGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXServicioGrupo') and type = 'U') 
CREATE TABLE dbo.SAUXServicioGrupo (
	Grupo		varchar(50)	NOT NULL,

	CONSTRAINT priSAUXServicioGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

/*** SAUXServicioFamilia ***/
if not exists(select * from SysTabla where SysTabla = 'SAUXServicioFamilia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SAUXServicioFamilia','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXServicioFamilia') and type = 'U') 
CREATE TABLE dbo.SAUXServicioFamilia (
	Familia		varchar(50)	NOT NULL,

	CONSTRAINT priSAUXServicioFamilia PRIMARY KEY  CLUSTERED (Familia)
)
GO

/*** SAUXServicioCategoria ***/
if not exists(select * from SysTabla where SysTabla = 'SAUXServicioCategoria')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SAUXServicioCategoria','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXServicioCategoria') and type = 'U') 
CREATE TABLE dbo.SAUXServicioCategoria (
	Categoria		varchar(50)	NOT NULL,

	CONSTRAINT priSAUXServicioCategoria PRIMARY KEY  CLUSTERED (Categoria)
)
GO

/****** SAUXArtServicio ******/
if not exists(select * from SysTabla where SysTabla = 'SAUXArtServicio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SAUXArtServicio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXArtServicio') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SAUXArtServicio (
	Servicio		varchar(20) NOT NULL,
	Articulo		varchar(20) NOT NULL,
	Cantidad		int			NOT NULL,
 	
 	CONSTRAINT priSAUXArtServicio PRIMARY KEY  CLUSTERED (Servicio, Articulo)
  )
  EXEC spSincroSemilla 'SAUXArtServicio'
END
GO

/****** SAUXIndicador ******/
if not exists(select * from SysTabla where SysTabla = 'SAUXIndicador')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SAUXIndicador','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXIndicador') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SAUXIndicador (
	Indicador		varchar(20) NOT NULL,
 	
 	Descripcion		varchar(100)	NULL,
	Descripcion2	varchar(100)	NULL,
	Categoria		varchar (50)	NULL,
	Grupo			varchar (50)	NULL,
	Familia			varchar (50)	NULL,
	Estatus			varchar (15)	NULL,
	Tipo			varchar (30)	NULL,
	ParametroValido varchar (20)	NULL,
	
 	CONSTRAINT priSAUXIndicador PRIMARY KEY  CLUSTERED (Indicador)
  )
  EXEC spSincroSemilla 'SAUXIndicador'
END
GO

/****** SAUXIndicadorD ******/
if not exists(select * from SysTabla where SysTabla = 'SAUXIndicadorD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SAUXIndicadorD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXIndicadorD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SAUXIndicadorD (
	Indicador			varchar(20) NOT NULL,
    Parametro			varchar(20)	NOT	NULL, 	
    
 	IndicadorMinimo		float			NULL,
	Observaciones		varchar(100)	NULL,
	
	
 	CONSTRAINT priSAUXIndicadorD PRIMARY KEY  CLUSTERED (Indicador, Parametro)
  )
  EXEC spSincroSemilla 'SAUXIndicadorD'
END
GO


/*** SAUXIndicadorGrupo ***/
if not exists(select * from SysTabla where SysTabla = 'SAUXIndicadorGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SAUXIndicadorGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXIndicadorGrupo') and type = 'U') 
CREATE TABLE dbo.SAUXIndicadorGrupo (
	Grupo		varchar(50)	NOT NULL,

	CONSTRAINT priSAUXIndicadorGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

/*** SAUXIndicadorFamilia ***/
if not exists(select * from SysTabla where SysTabla = 'SAUXIndicadorFamilia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SAUXIndicadorFamilia','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXIndicadorFamilia') and type = 'U') 
CREATE TABLE dbo.SAUXIndicadorFamilia (
	Familia		varchar(50)	NOT NULL,

	CONSTRAINT priSAUXIndicadorFamilia PRIMARY KEY  CLUSTERED (Familia)
)
GO

/*** SAUXIndicadorCategoria ***/
if not exists(select * from SysTabla where SysTabla = 'SAUXIndicadorCategoria')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SAUXIndicadorCategoria','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXIndicadorCategoria') and type = 'U') 
CREATE TABLE dbo.SAUXIndicadorCategoria (
	Categoria		varchar(50)	NOT NULL,

	CONSTRAINT priSAUXIndicadorCategoria PRIMARY KEY  CLUSTERED (Categoria)
)
GO

/*** SAUXServIndicador ***/
if not exists(select * from SysTabla where SysTabla = 'SAUXServIndicador')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SAUXServIndicador','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SAUXServIndicador') and type = 'U') 
CREATE TABLE dbo.SAUXServIndicador (
	Servicio		varchar(20) NOT NULL,
	Indicador		varchar(20) NOT NULL,

	CONSTRAINT priSAUXServIndicador PRIMARY KEY  CLUSTERED (Servicio, Indicador)
)
GO

