/* TEMPORALES */

/****** CorreoRecibido ******/
if not exists (select * from SysTabla where SysTabla = 'CorreoRecibido')  --AUTORIZACIONREMOTA
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CorreoRecibido','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.CorreoRecibido') and type = 'U') 
CREATE TABLE dbo.CorreoRecibido (
    SPID				int NOT NULL,
    ID					int NOT NULL,
	Cuenta				varchar(50) NULL,
	Fecha				varchar(50) NULL,    
	CantidadMensajes	int NULL,
	Servidor			varchar(50) NULL,
	BaseDatos			varchar(50) NULL,
	Empresa				varchar(5) NULL,			
        
    De					varchar(255) NULL,
    Para				varchar(max) NULL,  
    CC					varchar(max) NULL,    
    Asunto				varchar(max) NULL,      
    Mensaje				varchar(max) NULL,        
    Enviado				varchar(50) NULL,

	CONSTRAINT priCorreoRecibido PRIMARY KEY  CLUSTERED (SPID, ID)
)
GO

/* PolizaDescuadrada */
if exists (select * from sysobjects where id = object_id('dbo.PolizaDescuadrada') and sysstat & 0xf = 3) drop table dbo.PolizaDescuadrada
go
CREATE TABLE dbo.PolizaDescuadrada (
	Modulo			char(5)		NOT NULL, 
	ID			int		NOT NULL, 
	RID			int		NOT NULL IDENTITY(1,1),

	Cuenta			varchar(20)	NULL, 
	SubCuenta		varchar(50)	NULL, 
	Concepto		varchar(50)	NULL, 
	Debe			money		NULL, 
	Haber			money		NULL, 
	SucursalContable	int		NULL,

	CONSTRAINT priPolizaDescuadrada PRIMARY KEY CLUSTERED (Modulo, ID, RID)
)
go

/* PolizaDescuadradaSesion */
--if exists (select * from sysobjects where id = object_id('dbo.PolizaDescuadradaSesion') and sysstat & 0xf = 3) drop table dbo.PolizaDescuadradaSesion
go
/*CREATE TABLE dbo.PolizaDescuadradaSesion (
	Modulo			char(5)		NOT NULL, 
	ID			int		NOT NULL, 
	RID			int		NOT NULL,

	Cuenta			varchar(20)	NULL, 
	SubCuenta		varchar(50)	NULL, 
	Concepto		varchar(50)	NULL, 
	Debe			money		NULL, 
	Haber			money		NULL, 
	SucursalContable	int		NULL,

	CONSTRAINT priPolizaDescuadradaSesion PRIMARY KEY CLUSTERED (Modulo, ID, RID)
)*/
go

/* ImportarPrecios */
if exists (select * from sysobjects where id = object_id('dbo.ImportarPrecios') and sysstat & 0xf = 3) drop table dbo.ImportarPrecios
go
CREATE TABLE dbo.ImportarPrecios (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Articulo		char(20)	NULL,
	Descripcion		varchar(100)   	NULL,
	Precio  		money        	NULL,

	CONSTRAINT priImportarPrecios PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/* BandejaEntrada */
if exists (select * from sysobjects where id = object_id('dbo.BandejaEntrada') and sysstat & 0xf = 3) drop table dbo.BandejaEntrada
go
CREATE TABLE dbo.BandejaEntrada (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Origen			varchar(255)	NULL,
	Destino			varchar(255)	NULL,
	Asunto			varchar(255)   	NULL,
	Mensaje			text		NULL,
	Fecha			varchar(255)	NULL,

	CONSTRAINT priBandejaEntrada PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/* ImportarAutoVenta */
if exists (select * from sysobjects where id = object_id('dbo.ImportarAutoVenta') and sysstat & 0xf = 3) drop table dbo.ImportarAutoVenta
go
CREATE TABLE dbo.ImportarAutoVenta (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Clave			varchar(255)   	NULL,

	CONSTRAINT priImportarAutoVenta PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/* ImportarInv */
if not exists(select * from SysTabla where SysTabla = 'ImportarInv')
INSERT INTO SysTabla (SysTabla) VALUES ('ImportarInv')
if exists (select * from sysobjects where id = object_id('dbo.ImportarInv') and type = 'U') 
DROP TABLE dbo.ImportarInv
CREATE TABLE dbo.ImportarInv (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Clave			char(20)   	NULL,

	CONSTRAINT priImportarInv PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/* ImportarInvArt */
if not exists(select * from SysTabla where SysTabla = 'ImportarInvArt')
INSERT INTO SysTabla (SysTabla) VALUES ('ImportarInvArt')
if exists (select * from sysobjects where id = object_id('dbo.ImportarInvArt') and type = 'U') 
DROP TABLE dbo.ImportarInvArt
CREATE TABLE dbo.ImportarInvArt (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Articulo		char(20)	NULL,
	Descripcion		varchar(100)   	NULL,
	Serie			char(20)	NULL,
	Ubicacion		varchar(100)   	NULL,

	CONSTRAINT priImportarInvArt PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/****** ListaID  ******/
if not exists(select * from SysTabla where SysTabla = 'ListaID')
INSERT INTO SysTabla (SysTabla) VALUES ('ListaID')
if exists (select * from sysobjects where id = object_id('dbo.ListaID') and type = 'U') 
DROP TABLE dbo.ListaID
CREATE TABLE dbo.ListaID (
	Estacion	int  	NOT NULL,
	IDInterno	int	NOT NULL IDENTITY (1,1),

	ID		int	NOT NULL,

	CONSTRAINT priListaID PRIMARY KEY CLUSTERED (Estacion, IDInterno)

)
GO

/****** ListaIDOk  ******/
if not exists(select * from SysTabla where SysTabla = 'ListaIDOk')
INSERT INTO SysTabla (SysTabla) VALUES ('ListaIDOk')
if exists (select * from sysobjects where id = object_id('dbo.ListaIDOk') and type = 'U') 
DROP TABLE dbo.ListaIDOk
CREATE TABLE dbo.ListaIDOk (
	Estacion	int  		NOT NULL,
	IDInterno	int		NOT NULL IDENTITY (1,1),

	ID		int		NOT NULL,
	Empresa		char(5)		NULL,
	Modulo		char(5)		NULL,
	Ok		int		NULL,
	OkRef		varchar(255)	NULL,

	CONSTRAINT priListaIDOk PRIMARY KEY CLUSTERED (Estacion, IDInterno)

)
GO


/****** ListaIDRenglon  ******/
if not exists(select * from SysTabla where SysTabla = 'ListaIDRenglon')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaIDRenglon','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla) VALUES ('ListaIDRenglon')
if exists (select * from sysobjects where id = object_id('dbo.ListaIDRenglon') and type = 'U') 
DROP TABLE dbo.ListaIDRenglon
CREATE TABLE dbo.ListaIDRenglon (
	Estacion	int  	NOT NULL,
	IDInterno	int	NOT NULL IDENTITY (1,1),

	Modulo		char(5)	NOT NULL,
	ID		int	NOT NULL,
	Renglon		float	NOT NULL,
	RenglonSub	int	NOT NULL,

	CONSTRAINT priListaIDRenglon PRIMARY KEY CLUSTERED (Estacion, IDInterno)

)
GO

/****** ListaModuloID  ******/
if not exists(select * from SysTabla where SysTabla = 'ListaModuloID')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaModuloID','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla) VALUES ('ListaModuloID')
if exists (select * from sysobjects where id = object_id('dbo.ListaModuloID') and type = 'U') 
DROP TABLE dbo.ListaModuloID
CREATE TABLE dbo.ListaModuloID (
	Estacion	int  	NOT NULL,
	IDInterno	int	NOT NULL IDENTITY (1,1),

	Modulo		char(5)	NOT NULL,
	ID		int	NOT NULL,

	CONSTRAINT priListaModuloID PRIMARY KEY CLUSTERED (Estacion, IDInterno)

)
GO

/****** ListaFiltro  ******/
if not exists(select * from SysTabla where SysTabla = 'ListaFiltro')
INSERT INTO SysTabla (SysTabla) VALUES ('ListaFiltro')
if exists (select * from sysobjects where id = object_id('dbo.ListaFiltro') and type = 'U') 
DROP TABLE dbo.ListaFiltro
CREATE TABLE dbo.ListaFiltro (
	Estacion	int  		NOT NULL,
	ID		int		NOT NULL IDENTITY (1,1),

	Clave		varchar(255)	NULL,

	CONSTRAINT priListaFiltro PRIMARY KEY CLUSTERED (Estacion, ID)

)
GO
EXEC spADD_INDEX 'ListaFiltro', 'Clave', 'Clave, Estacion'
GO

/****** ListaSt  ******/
if not exists(select * from SysTabla where SysTabla = 'ListaSt')
INSERT INTO SysTabla (SysTabla) VALUES ('ListaSt')
if exists (select * from sysobjects where id = object_id('dbo.ListaSt') and type = 'U') 
DROP TABLE dbo.ListaSt
CREATE TABLE dbo.ListaSt (
	Estacion	int  		NOT NULL,
	ID		int		NOT NULL IDENTITY (1,1),

	Clave		varchar(255)	NULL,

	CONSTRAINT priListaSt PRIMARY KEY CLUSTERED (Estacion, ID)

)
GO

/*************** spListaStEliminar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spListaStEliminar') and type = 'P') drop procedure dbo.spListaStEliminar
GO             
CREATE PROCEDURE spListaStEliminar
					@Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  DELETE ListaSt WHERE Estacion = @Estacion
  RETURN 
END
GO

/*************** spListaStAgregar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spListaStAgregar') and type = 'P') drop procedure dbo.spListaStAgregar
GO             
CREATE PROCEDURE spListaStAgregar
					@Estacion		int,
					@Clave			varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  INSERT ListaSt (Estacion, Clave) VALUES (@Estacion, @Clave)
  RETURN 
END
GO

/*************** spListaStQuitar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spListaStQuitar') and type = 'P') drop procedure dbo.spListaStQuitar
GO             
CREATE PROCEDURE spListaStQuitar
					@Estacion		int,
					@Primero		bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int,
    @Clave	varchar(255)

  SELECT @ID = NULL, @Clave = NULL
  IF @Primero = 1
    SELECT @ID = MIN(ID) FROM ListaSt WHERE Estacion = @Estacion
  ELSE
    SELECT @ID = MAX(ID) FROM ListaSt WHERE Estacion = @Estacion

  SELECT @Clave = Clave FROM ListaSt WHERE Estacion = @Estacion AND ID = @ID
  DELETE ListaSt WHERE Estacion = @Estacion AND ID = @ID
  SELECT "Clave" = @Clave
  RETURN 
END
GO

/**************** spListaStProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spListaStProcesar') and type = 'P') drop procedure dbo.spListaStProcesar
GO
CREATE PROCEDURE spListaStProcesar
			@Estacion		int,
			@Archivo		varchar(255) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  SELECT 'Resultado' = @Resultado
  RETURN
END
GO

/****** ListaDatos  ******/
if not exists(select * from SysTabla where SysTabla = 'ListaDatos')
INSERT INTO SysTabla (SysTabla) VALUES ('ListaDatos')
if exists (select * from sysobjects where id = object_id('dbo.ListaDatos') and type = 'U') 
DROP TABLE dbo.ListaDatos
CREATE TABLE dbo.ListaDatos (
	Estacion	int  		NOT NULL,
	ID		int		NOT NULL IDENTITY (1,1),

	Datos		text	NULL,

	CONSTRAINT priListaDatos PRIMARY KEY CLUSTERED (Estacion, ID)

)
GO


/****** TempWS  ******/
if not exists(select * from SysTabla where SysTabla = 'TempWS')
INSERT INTO SysTabla (SysTabla) VALUES ('TempWS')
if exists (select * from sysobjects where id = object_id('dbo.TempWS') and type = 'U') 
DROP TABLE dbo.TempWS
CREATE TABLE dbo.TempWS (
	GID		uniqueidentifier  	NOT NULL,
	Numero		int		  	NOT NULL,

	Datos		text			NULL,
	FechaHora	datetime		NULL	DEFAULT GETDATE(),

	CONSTRAINT priTempWS PRIMARY KEY CLUSTERED (GID, Numero)
)
GO

/****** ListaProdSerieLote  ******/
if not exists(select * from SysTabla where SysTabla = 'ListaProdSerieLote')
INSERT INTO SysTabla (SysTabla) VALUES ('ListaProdSerieLote')
if exists (select * from sysobjects where id = object_id('dbo.ListaProdSerieLote') and type = 'U') 
DROP TABLE dbo.ListaProdSerieLote
CREATE TABLE dbo.ListaProdSerieLote (
	Estacion	int  		NOT NULL,
	ID		int		NOT NULL IDENTITY (1,1),

	SerieLote	varchar(50)	NULL,

	CONSTRAINT priListaProdSerieLote PRIMARY KEY CLUSTERED (Estacion, ID)

)
GO


/****** VentaConciliarN  ******/
if not exists(select * from SysTabla where SysTabla = 'VentaConciliarN')
INSERT INTO SysTabla (SysTabla) VALUES ('VentaConciliarN')
if exists (select * from sysobjects where id = object_id('dbo.VentaConciliarN') and type = 'U') 
DROP TABLE dbo.VentaConciliarN
CREATE TABLE dbo.VentaConciliarN (
	Estacion	int  		NOT NULL,
	ID		int		NOT NULL IDENTITY (1,1),

	Orden		int		NULL,
	Renglon		float		NULL,
	RenglonSub	int		NULL,
	Articulo	char(20)	NULL,
	SubCuenta	varchar(50)	NULL,
	Cantidad	float		NULL,
	Unidad		varchar(50)	NULL,
	Factor		float		NULL,

	CONSTRAINT priVentaConciliarN PRIMARY KEY CLUSTERED (Estacion, ID)
)
GO

/****** VentaConciliarA  ******/
if not exists(select * from SysTabla where SysTabla = 'VentaConciliarA')
INSERT INTO SysTabla (SysTabla) VALUES ('VentaConciliarA')
if exists (select * from sysobjects where id = object_id('dbo.VentaConciliarA') and type = 'U') 
DROP TABLE dbo.VentaConciliarA
CREATE TABLE dbo.VentaConciliarA (
	Estacion	int  		NOT NULL,
	Orden		int		NOT NULL,

	Renglon		float		NULL,
	RenglonSub	int		NULL,
	Articulo	char(20)	NULL,
	SubCuenta	varchar(50)	NULL,
	Cantidad	float		NULL,
	Unidad		varchar(50)	NULL,
	Factor		float		NULL,

	CONSTRAINT priVentaConciliarA PRIMARY KEY CLUSTERED (Estacion, Orden)
)
GO

/****** VerAuxiliares  ******/
if not exists(select * from SysTabla where SysTabla = 'VerAux')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VerAux','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla) VALUES ('VerAux')
if exists (select * from sysobjects where id = object_id('dbo.VerAux') and type = 'U') 
DROP TABLE dbo.VerAux
CREATE TABLE dbo.VerAux(
   ID			int		IDENTITY(1,1) NOT NULL,
   Fecha		datetime	NOT NULL,
   Orden		int		NOT NULL      DEFAULT 0,
   Estacion		int		NOT NULL,

   Grupo		char(10)	NULL,
   SubCuenta		varchar(50)	NULL,
   Ejercicio          	int     	NULL,
   Periodo		int		NULL,
   Modulo		char(5)		NULL,
   ModuloID		int		NULL,
   Mov			char(20)	NULL,
   MovID		varchar(20)	NULL,
   Aplica		varchar(20)	NULL,
   AplicaID		varchar(20)	NULL,
   Concepto		varchar(50)	NULL,   
   Referencia		varchar(50)	NULL,

   Cargo		money		NULL,
   Abono		money		NULL,
   Saldo		money		NULL,
   Total		money		NOT NULL	DEFAULT 0.0,

   CargoU		float		NULL,
   AbonoU		float		NULL,
   TotalU		float		NOT NULL	DEFAULT 0,

  CONSTRAINT priVerAux PRIMARY KEY CLUSTERED (Estacion, Fecha, Orden, ID)
)
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VerAux' AND sysindexes.name = 'Aplica' AND sysobjects.id = sysindexes.id)
    DROP INDEX VerAux.Aplica
  ALTER TABLE VerAux ALTER COLUMN MovID varchar(20)
  ALTER TABLE VerAux ALTER COLUMN AplicaID varchar(20)
END
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VerAux' AND sysindexes.name = 'Mov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Mov ON VerAux (Estacion, Fecha, ModuloID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VerAux' AND sysindexes.name = 'Aplica' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Aplica ON VerAux (Estacion, Aplica, AplicaID, Fecha, ModuloID)
GO

/****** VerAuxCorte  ******/
if not exists(select * from SysTabla where SysTabla = 'VerAuxCorte')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VerAuxCorte','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla) VALUES ('VerAuxCorte')
if exists (select * from sysobjects where id = object_id('dbo.VerAuxCorte') and type = 'U') 
DROP TABLE dbo.VerAuxCorte
CREATE TABLE dbo.VerAuxCorte (
   Estacion		int		NOT NULL,
   ID			int		IDENTITY(1,1) NOT NULL,

   Empresa		char(5)		NULL,
   Modulo		char(5)		NULL,
   Moneda		char(10)	NULL,
   Cuenta		char(10)	NULL,
   Mov			char(20)	NULL,
   MovID		varchar(20)	NULL,

   ModuloID		int		NULL,

   Saldo		money		NULL,

  CONSTRAINT priVerAuxCorte PRIMARY KEY CLUSTERED (Estacion, ID)
)
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VerAuxCorte' AND sysindexes.name = 'Mov' AND sysobjects.id = sysindexes.id)
    DROP INDEX VerAuxCorte.Mov
  ALTER TABLE VerAuxCorte ALTER COLUMN MovID varchar(20)
END

EXEC spFK 'VerAuxCorte','ModuloID','Cxc','ID'
EXEC spFK 'VerAuxCorte','ModuloID','Cxp','ID'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VerAuxCorte' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ModuloID ON VerAuxCorte (Estacion, ModuloID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VerAuxCorte' AND sysindexes.name = 'Mov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Mov      ON VerAuxCorte (Estacion, Mov, MovID)
GO


/****** VerRama  ******/
if not exists(select * from SysTabla where SysTabla = 'VerRama')
INSERT INTO SysTabla (SysTabla) VALUES ('VerRama')
if exists (select * from sysobjects where id = object_id('dbo.VerRama') and type = 'U') 
DROP TABLE dbo.VerRama
CREATE TABLE dbo.VerRama (
     Estacion		int		NOT NULL,
     Orden		int		NOT NULL,

     Cuenta		char(20)	NULL,
     Rama		char(20)	NULL,
     SubCuenta		varchar(50)	NULL,
     Descripcion	varchar(100)	NULL,
     EsAcreedora	bit		NOT NULL  	DEFAULT 0,
     EsAcumulativa	bit		NOT NULL  	DEFAULT 0,
     Tipo		char(15)	NULL,

     Inicio		money		NULL,
     Cargos		money		NULL,
     Abonos		money		NULL,
     Final		money		NULL,
     Comparacion	money		NULL,

     InicioU		float		NULL,
     CargosU		float		NULL,
     AbonosU		float		NULL,
     FinalU		float		NULL,

     Periodo		int		NULL, 		-- para Totalizadores 999

  CONSTRAINT priVerRama PRIMARY KEY CLUSTERED (Estacion, Orden)
)
GO

/****** VerAcumulados  ******/
if not exists(select * from SysTabla where SysTabla = 'VerAcum')
INSERT INTO SysTabla (SysTabla) VALUES ('VerAcum')
if exists (select * from sysobjects where id = object_id('dbo.VerAcum') and type = 'U') 
DROP TABLE dbo.VerAcum
CREATE TABLE dbo.VerAcum (
     Estacion		int		NOT NULL,
     Grupo		char(10)	NOT NULL,
     Moneda		char(10)	NOT NULL,
     Ejercicio          int     	NOT NULL,
     Periodo		int		NOT NULL,

     Inicio		money		NULL DEFAULT 0,
     Cargos		money		NULL DEFAULT 0,
     Abonos		money		NULL DEFAULT 0,
     Final		money		NULL DEFAULT 0,

     InicioU		float		NULL DEFAULT 0,
     CargosU		float		NULL DEFAULT 0,
     AbonosU		float		NULL DEFAULT 0,
     FinalU		float		NULL DEFAULT 0,

  CONSTRAINT priVerAcum PRIMARY KEY CLUSTERED (Estacion, Grupo, Moneda, Ejercicio, Periodo)
)
GO

/****** VerEjercicio ******/
if not exists(select * from SysTabla where SysTabla = 'VerEjercicio')
INSERT INTO SysTabla (SysTabla) VALUES ('VerEjercicio')
if exists (select * from sysobjects where id = object_id('dbo.VerEjercicio') and type = 'U') 
DROP TABLE dbo.VerEjercicio
CREATE TABLE dbo.VerEjercicio (
     Estacion		int		NOT NULL,
     Grupo		char(10)	NOT NULL,
     Cuenta		char(20)	NOT NULL,
     Moneda		char(10)	NOT NULL,
     Ejercicio          int     	NOT NULL,

     Periodo0		money		NULL DEFAULT 0,
     Periodo1		money		NULL DEFAULT 0,
     Periodo2		money		NULL DEFAULT 0,
     Periodo3		money		NULL DEFAULT 0,
     Periodo4		money		NULL DEFAULT 0,
     Periodo5		money		NULL DEFAULT 0,
     Periodo6		money		NULL DEFAULT 0,
     Periodo7		money		NULL DEFAULT 0,
     Periodo8		money		NULL DEFAULT 0,
     Periodo9		money		NULL DEFAULT 0,
     Periodo10		money		NULL DEFAULT 0,
     Periodo11		money		NULL DEFAULT 0,
     Periodo12		money		NULL DEFAULT 0,
     Periodo13		money		NULL DEFAULT 0,

     PeriodoU0		float		NULL DEFAULT 0,
     PeriodoU1		float		NULL DEFAULT 0,
     PeriodoU2		float		NULL DEFAULT 0,
     PeriodoU3		float		NULL DEFAULT 0,
     PeriodoU4		float		NULL DEFAULT 0,
     PeriodoU5		float		NULL DEFAULT 0,
     PeriodoU6		float		NULL DEFAULT 0,
     PeriodoU7		float		NULL DEFAULT 0,
     PeriodoU8		float		NULL DEFAULT 0,
     PeriodoU9		float		NULL DEFAULT 0,
     PeriodoU10		float		NULL DEFAULT 0,
     PeriodoU11		float		NULL DEFAULT 0,
     PeriodoU12		float		NULL DEFAULT 0,
     PeriodoU13		float		NULL DEFAULT 0,

  CONSTRAINT priVerEjercicio PRIMARY KEY CLUSTERED (Estacion, Grupo, Cuenta, Moneda, Ejercicio)
)
GO

/****** VerPend ******/
if not exists(select * from SysTabla where SysTabla = 'VerPend')
INSERT INTO SysTabla (SysTabla) VALUES ('VerPend')
if exists (select * from sysobjects where id = object_id('dbo.VerPend') and type = 'U') 
DROP TABLE dbo.VerPend
CREATE TABLE dbo.VerPend (
   Estacion		int		NOT NULL,
   Orden		int		NOT NULL,

   Periodo		int		NULL,
   Moneda		char(10)	NULL,
   Grupo		char(10)	NULL,
   Cuenta		char(20) 	NULL,
   Fecha		char(20)	NULL,
   ID			int		NULL,
   Mov			char(20)	NULL,
   MovID		varchar(20)	NULL,
   Vigente		money		NULL	DEFAULT 0.0,
   Vencido		money		NULL	DEFAULT 0.0,
   C1			money		NULL	DEFAULT 0.0,
   C2			money		NULL	DEFAULT 0.0,
   C3			money		NULL	DEFAULT 0.0,
   C4			money		NULL	DEFAULT 0.0,
   C5			money		NULL	DEFAULT 0.0,

  CONSTRAINT priVerPend PRIMARY KEY CLUSTERED (Estacion, Orden)
)
GO
if (select version from version) <= 1095
  ALTER TABLE VerPend ALTER COLUMN MovID varchar(20)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VerPend' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cuenta ON VerPend (Estacion, Moneda, Grupo, Cuenta)
GO


/****** VerContBalanza ******/
if not exists(select * from SysTabla where SysTabla = 'VerContBalanza')
INSERT INTO SysTabla (SysTabla) VALUES ('VerContBalanza')
if exists (select * from sysobjects where id = object_id('dbo.VerContBalanza') and type = 'U') 
DROP TABLE dbo.VerContBalanza
CREATE TABLE dbo.VerContBalanza (
   Estacion		int		NOT NULL,
   Cuenta		char(20)	NOT NULL,
   Tipo			char(15)	NULL,

   Inicio   		money		NULL,
   Cargos		money		NULL,
   Abonos		money		NULL,


  CONSTRAINT priVerContBalanza PRIMARY KEY CLUSTERED (Estacion, Cuenta)
)
GO

/****** VerPos ******/
if not exists(select * from SysTabla where SysTabla = 'VerPos')
INSERT INTO SysTabla (SysTabla) VALUES ('VerPos')
if exists (select * from sysobjects where id = object_id('dbo.VerPos') and type = 'U') 
DROP TABLE dbo.VerPos
CREATE TABLE dbo.VerPos (
   ID			int		IDENTITY(1,1) NOT NULL,
   Estacion		int		NOT NULL,
   Periodo		int		NULL,

   Orden		int		NULL,
   Modulo		char(5)		NULL,
   Mov			char(20)	NULL,
   MovID		varchar(20)	NULL,
   Referencia		varchar(50)     NULL,
   Observaciones	varchar(100)    NULL,
   FechaEmision		datetime	NULL,
   Vencimiento		datetime	NULL,
   Dias			int		NULL,
   Cuenta		char(20)	NULL,
   Nombre		varchar(100)	NULL,

   Disponible		money		NULL,
   Vencido		money		NULL,
   Vencido5		money		NULL,
   Vencido4		money		NULL,
   Vencido3		money		NULL,
   Vencido2		money		NULL,
   Vencido1		money		NULL,
   Vigente		money		NULL,
   Vigente1		money		NULL,
   Vigente2		money		NULL,
   Vigente3		money		NULL,
   Vigente4		money		NULL,
   Vigente5		money		NULL,

  CONSTRAINT priVerPos PRIMARY KEY CLUSTERED (Estacion, ID)
)
GO
if (select version from version) <= 1095
  ALTER TABLE VerPos ALTER COLUMN MovID varchar(20)
GO

/****** VerCambioPos ******/
if not exists(select * from SysTabla where SysTabla = 'VerCambioPos')
INSERT INTO SysTabla (SysTabla) VALUES ('VerCambioPos')
if exists (select * from sysobjects where id = object_id('dbo.VerCambioPos') and type = 'U') 
DROP TABLE dbo.VerCambioPos
CREATE TABLE dbo.VerCambioPos (
   ID			int		IDENTITY(1,1) NOT NULL,
   Estacion		int		NOT NULL,

   Empresa		char(5)		NULL,
   Sucursal		int		NULL,
   Fecha		datetime	NULL,
   Moneda		char(10)	NULL,

   Cerrado		bit		NOT NULL DEFAULT 0,
   FechaHoy		datetime	NULL,
   Fecha24		datetime	NULL,
   Fecha48		datetime	NULL,
   Inicio		money		NULL,
   VentaHoy		money		NULL,
   Venta24		money		NULL,
   Venta48		money		NULL,
   VentaHoyMN		money		NULL,
   Venta24MN		money		NULL,
   Venta48MN		money		NULL,
   OtrosIngresos  	money		NULL,
   OtrosEgresos		money		NULL,
   DepositosAnticipados	money		NULL,
   CompraHoy		money		NULL,
   Compra24		money		NULL,
   Compra48		money		NULL,
   CompraHoyMN		money		NULL,
   Compra24MN		money		NULL,
   Compra48MN		money		NULL,
   BancosHoy		money		NULL,
   Bancos24		money		NULL,
   CxcHoy		money		NULL,
   Cxc24		money		NULL,
   Cxc48		money		NULL,
   CxcMas		money		NULL,
   CxpHoy		money		NULL,
   Cxp24		money		NULL,
   Cxp48		money		NULL,
   CxpMas		money		NULL,
   Saldo		money		NULL,
   SaldoHoy		money		NULL,
   Saldo24		money		NULL,
   Saldo48		money		NULL,
   PosicionHoy		money		NULL,
   Posicion24		money		NULL,
   Posicion48		money		NULL,

  CONSTRAINT priVerCambioPos PRIMARY KEY CLUSTERED (Estacion, ID)
)
GO

/****** VerCambioUtil ******/
if not exists(select * from SysTabla where SysTabla = 'VerCambioUtil')
INSERT INTO SysTabla (SysTabla) VALUES ('VerCambioUtil')
if exists (select * from sysobjects where id = object_id('dbo.VerCambioUtil') and type = 'U') 
DROP TABLE dbo.VerCambioUtil
CREATE TABLE dbo.VerCambioUtil (
   ID			int		IDENTITY(1,1) NOT NULL,
   Estacion		int		NOT NULL,

   Empresa		char(5)		NULL,
   FechaD		datetime	NULL,
   FechaA		datetime	NULL,
   Moneda		char(10)	NULL,

   Inicio		money		NULL,
   InicioMN		money		NULL,
   InicioTC		float		NULL,
   Compra		money		NULL,
   CompraMN		money		NULL,
   CompraTC		float		NULL,
   Venta		money		NULL,
   VentaMN		money		NULL,
   VentaTC		float		NULL,
   Final		money		NULL,
   FinalMN		money		NULL,
   FinalTC		float		NULL,

   UtilidadMN		money		NULL,

   Cotizacion1		float		NULL,
   Ok1			bit		NULL  	DEFAULT 0,
   Cotizacion2		float		NULL,
   Ok2			bit		NULL  	DEFAULT 0,
   Cotizacion3		float		NULL,
   Ok3			bit		NULL  	DEFAULT 0,

  CONSTRAINT priVerCambioUtil PRIMARY KEY CLUSTERED (Estacion, ID)
)
GO

EXEC spFK 'VerCambioUtil','Moneda','Mon','Moneda'
GO

/****** VerContListaCta ******/
if not exists(select * from SysTabla where SysTabla = 'VerContListaCta')
INSERT INTO SysTabla (SysTabla) VALUES ('VerContListaCta')
if exists (select * from sysobjects where id = object_id('dbo.VerContListaCta') and type = 'U') 
DROP TABLE dbo.VerContListaCta
CREATE TABLE dbo.VerContListaCta (
   ID			int		IDENTITY(1,1) NOT NULL,

   Estacion		int		NOT NULL,
   Cuenta		char(20)	NOT NULL,

  CONSTRAINT priVerContListaCta PRIMARY KEY CLUSTERED (ID)
)
GO

/****** VerContListaRama ******/
if not exists(select * from SysTabla where SysTabla = 'VerContListaRama')
INSERT INTO SysTabla (SysTabla) VALUES ('VerContListaRama')
if exists (select * from sysobjects where id = object_id('dbo.VerContListaRama') and type = 'U') 
DROP TABLE dbo.VerContListaRama
CREATE TABLE dbo.VerContListaRama (
   ID			int		IDENTITY(1,1) NOT NULL,

   Estacion		int		NOT NULL,
   Cuenta		char(20)	NOT NULL,

  CONSTRAINT priVerContListaRama PRIMARY KEY CLUSTERED (ID)
)
GO


/****** VerContSPD ******/
if not exists(select * from SysTabla where SysTabla = 'VerContSPD')
INSERT INTO SysTabla (SysTabla) VALUES ('VerContSPD')
if exists (select * from sysobjects where id = object_id('dbo.VerContSPD') and type = 'U') 
DROP TABLE dbo.VerContSPD
CREATE TABLE dbo.VerContSPD (

   Estacion		int		NOT NULL,
   Cuenta		char(20)	NOT NULL,
   SPD			money		NULL,
   SMM			money		NULL,

  CONSTRAINT priVerContSaldos PRIMARY KEY CLUSTERED (Estacion, Cuenta)
)
GO

/****** VerMovFlujo ******/
if not exists(select * from SysTabla where SysTabla = 'VerMovFlujo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VerMovFlujo','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla) VALUES ('VerMovFlujo')
if exists (select * from sysobjects where id = object_id('dbo.VerMovFlujo') and type = 'U') 
DROP TABLE dbo.VerMovFlujo
CREATE TABLE dbo.VerMovFlujo(

   Estacion		int		NOT NULL,
   Tipo			char(10)	NOT NULL, 		--Origen/Destino
   Nivel		int		NOT NULL,
   ID			int		IDENTITY(1,1) NOT NULL,

   Empresa		char(5)		NULL,
   Modulo		char(5)		NULL,
   ModuloID		int		NULL,
   Mov			char(20)	NULL,
   MovID		varchar(20)	NULL,

  CONSTRAINT priVerMovFlujo PRIMARY KEY CLUSTERED (Estacion, Tipo, Nivel, ID)
)
GO
if (select version from version) <= 1095
  ALTER TABLE VerMovFlujo ALTER COLUMN MovID varchar(20)
go

/****** VerPedidoPos ******/
if not exists(select * from SysTabla where SysTabla = 'VerPedidoPos')
INSERT INTO SysTabla (SysTabla) VALUES ('VerPedidoPos')
if exists (select * from sysobjects where id = object_id('dbo.VerPedidoPos') and type = 'U') 
DROP TABLE dbo.VerPedidoPos
CREATE TABLE dbo.VerPedidoPos (
   Estacion		int		NOT NULL,
   ID			int		NOT NULL,
   Renglon		float		NOT NULL,
   RenglonSub		int		NOT NULL DEFAULT 0,

   CantidadPendiente    float		NULL,
   CantidadRemisionada  float		NULL,
   CantidadFacturada	float		NULL,

  CONSTRAINT priVerPedidoPos PRIMARY KEY CLUSTERED (Estacion, ID, Renglon, RenglonSub)
)
GO
EXEC spALTER_TABLE 'VerPedidoPos', 'CantidadPendiente', 'float NULL'
GO

/****** EstadoCuenta ******/
if not exists(select * from SysTabla where SysTabla = 'EstadoCuenta')
INSERT INTO SysTabla (SysTabla) VALUES ('EstadoCuenta')
if exists (select * from sysobjects where id = object_id('dbo.EstadoCuenta') and type = 'U') 
DROP TABLE dbo.EstadoCuenta
CREATE TABLE dbo.EstadoCuenta (
   ID			int IDENTITY(1,1)	NOT NULL,
   Modulo		char(5)				NOT NULL,
   Estacion		int					NOT NULL,
   Cuenta			char(10)		NOT NULL,
   
   ClienteEnviarA	int				NULL,
   AuxiliarID		int				NULL,
   ModuloID			int				NULL,
   Efectivo			money			NULL,
   Consumos			money			NULL,
   Vales			money			NULL,
   Redondeo			money			NULL,
   Moneda			char(10)		NULL,
   
   Grafica			bit				NULL DEFAULT 0,
   SaldoDescripcion	varchar(50)		NULL,		
   SaldoImporte		money			NULL DEFAULT 0.0,
   Empresa			varchar(5)		NULL,
   Vencimiento		datetime		NULL,
   Referencia		varchar(50)		NULL,
   
  CONSTRAINT priEstadoCuenta PRIMARY KEY CLUSTERED (Modulo, Estacion, ID)
)
GO
EXEC spAlter_Table 'EstadoCuenta','ClienteEnviarA','int	NULL'
EXEC spAlter_Table 'EstadoCuenta','Grafica','bit	NULL DEFAULT 0 WITH VALUES'
EXEC spAlter_Table 'EstadoCuenta','SaldoDescripcion','varchar(50)	NULL'
EXEC spAlter_Table 'EstadoCuenta','SaldoImporte','money	NULL DEFAULT 0.0 WITH VALUES'
EXEC spAlter_Table 'EstadoCuenta','Empresa','varchar(5)	NULL'
EXEC spAlter_Table 'EstadoCuenta','Vencimiento','datetime	NULL'
EXEC spAlter_Table 'EstadoCuenta','Referencia','varchar(50)	NULL'
GO

/****** ContactoDireccion  ******/
if not exists(select * from SysTabla where SysTabla = 'ContactoDireccion')
INSERT INTO SysTabla (SysTabla) VALUES ('ContactoDireccion')
if exists (select * from sysobjects where id = object_id('dbo.ContactoDireccion') and type = 'U') 
DROP TABLE dbo.ContactoDireccion
CREATE TABLE dbo.ContactoDireccion (
     Estacion		int				NULL,
	 ID				int				NULL,
	 ContactoTipo	varchar(20)		NULL,
	 Contacto		varchar(10)		NULL,		
	 Direccion		varchar(255)	NULL	 
)
GO


/****** ContactoDireccionHorizontal  ******/
if not exists(select * from SysTabla where SysTabla = 'ContactoDireccionHorizontal')
INSERT INTO SysTabla (SysTabla) VALUES ('ContactoDireccionHorizontal')
if exists (select * from sysobjects where id = object_id('dbo.ContactoDireccionHorizontal') and type = 'U') 
DROP TABLE dbo.ContactoDireccionHorizontal
CREATE TABLE dbo.ContactoDireccionHorizontal (
     Estacion		int				NULL,
     ContactoTipo	varchar(20)		NULL,
	 Contacto		varchar(10)		NULL,
	 Direccion1		varchar(255)	NULL,
	 Direccion2		varchar(255)	NULL,		
	 Direccion3		varchar(255)	NULL,
	 Direccion4		varchar(255)	NULL,		
	 Direccion5		varchar(255)	NULL,
	 Direccion6		varchar(255)	NULL,
	 Direccion7		varchar(255)	NULL,
	 Direccion8		varchar(255)	NULL																							 
)
GO

/****** EstadoCuentaGrafica ******/
if not exists(select * from SysTabla where SysTabla = 'EstadoCuentaGrafica')
INSERT INTO SysTabla (SysTabla) VALUES ('EstadoCuentaGrafica')
if exists (select * from sysobjects where id = object_id('dbo.EstadoCuentaGrafica') and type = 'U') 
DROP TABLE dbo.EstadoCuentaGrafica
CREATE TABLE dbo.EstadoCuentaGrafica (

  Estacion					int					NOT NULL,  
  Empresa					varchar(5)			NOT NULL,
  ID						int IDENTITY(1,1)	NOT NULL,  

  Grafica					bit					NULL DEFAULT 1,  
  Modulo					varchar(5)			NULL,
  Moneda					varchar(10)			NULL,    
  Cuenta					varchar(10)			NULL,
  SaldoDescripcion			varchar(50)			NULL,
  SaldoImporte				float				NULL,

  CONSTRAINT priEstadoCuentaGrafica PRIMARY KEY CLUSTERED (Estacion, Empresa, ID)
)
GO

EXEC spFK 'EstadoCuenta','AuxiliarID','Auxiliar','ID'
EXEC spFK 'EstadoCuenta','ModuloID','Cxc','ID'
EXEC spFK 'EstadoCuenta','ModuloID','Cxp','ID'
GO

/****** CompraSugerir ******/
if not exists(select * from SysTabla where SysTabla = 'CompraSugerir') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CompraSugerir','Movimiento','COMS')
--JGD INSERT INTO SysTabla (SysTabla) VALUES ('CompraSugerir')
if exists (select * from sysobjects where id = object_id('dbo.CompraSugerir') and type = 'U') 
DROP TABLE dbo.CompraSugerir
GO
CREATE TABLE dbo.CompraSugerir (

   Estacion		int		NOT NULL,
   CompraID		int		NOT NULL,
   ID			int		NOT NULL	IDENTITY(1,1),

   Modulo		char(5)		NULL,
   ModuloID		int		NULL,
   Mov			char(20)	NULL,
   MovID		varchar(20)	NULL,
   FechaEmision		datetime	NULL,
   FechaRequerida	datetime	NULL,
   Referencia		varchar(50)	NULL,
   Cliente		char(10)	NULL,
   Almacen		char(10)	NULL,

   Articulo		char(20)	NOT NULL,
   SubCuenta		varchar(50)	NULL,
   Precio		money		NULL,
   Descuento		float		NULL,
   ServicioArticulo	varchar(20)	NULL,
   ServicioSerie	varchar(20)	NULL,
   ServicioFecha	datetime	NULL,
   ClaveProveedor	varchar(20)	NULL,
   UnidadCompra		varchar(50)	NULL,
   CantidadMinima	float		NULL,
   Multiplos		int		NULL		DEFAULT 1,
   MultiplosUnidad	varchar(50)	NULL,

   Cantidad		float		NULL,
   CantidadA		float		NULL,
   FactorDemanda	float		NULL,
   Paquete		int		NULL,

  CONSTRAINT priCompraSugerir PRIMARY KEY CLUSTERED (Estacion, CompraID, ID)
)
GO
if (select version from version) <= 1095
  ALTER TABLE CompraSugerir ALTER COLUMN MovID varchar(20)
go
EXEC spALTER_TABLE 'CompraSugerir', 'Paquete', 'int NULL'
go

/****** VentaCteDLista ******/
if not exists(select * from SysTabla where SysTabla = 'VentaCteDLista')
INSERT INTO SysTabla (SysTabla) VALUES ('VentaCteDLista')
if exists (select * from sysobjects where id = object_id('dbo.VentaCteDLista') and type = 'U') 
DROP TABLE dbo.VentaCteDLista
CREATE TABLE dbo.VentaCteDLista (

   Estacion	int		NOT NULL,
   ID		int		NOT NULL,
   Renglon	float		NOT NULL,
   RenglonSub	int		NOT NULL,

   CantidadA	float		NULL,

  CONSTRAINT priVentaCteDLista PRIMARY KEY CLUSTERED (Estacion, ID, Renglon, RenglonSub)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VentaCteDLista' AND sysindexes.name = 'ID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ID ON dbo.VentaCteDLista (ID, Renglon, RenglonSub)
GO

EXEC spALTER_TABLE 'VentaCteDLista', 'Cantidad', 'float NULL'
EXEC spALTER_TABLE 'VentaCteDLista', 'Estatus', 'bit NULL'
GO

/****** ArtR ******/
if not exists(select * from SysTabla where SysTabla = 'ArtR')
INSERT INTO SysTabla (SysTabla) VALUES ('ArtR')
if exists (select * from sysobjects where id = object_id('dbo.ArtR') and type = 'U') 
DROP TABLE dbo.ArtR
CREATE TABLE dbo.ArtR (
	Empresa		  char(5)	NOT NULL,
	Articulo	  char(20)	NOT NULL,
	SubCuenta	  varchar(50)	NOT NULL  DEFAULT '',
	Almacen		  char(10)	NOT NULL,

	Localizacion	  varchar(50) 	NULL,
	Minimo 		  float 	NULL,
	Maximo 		  float 	NULL,
	PuntoOrden	  float 	NULL,
	PuntoOrdenOrdenar float 	NULL,

	INV		  float		NULL,		-- Saldo Inventarios
	CSG		  float		NULL,		-- Saldo A Consignacion
	RESV		  float		NULL,		-- Saldo Reservados
	VMOS		  float		NULL,		-- Saldo Ventas de Mostrador
	GAR		  float		NULL,		-- Saldo En Garantia
	AF		  float		NULL,		-- Saldo Activos Fijos
	PZA		  float		NULL,		-- Saldo Piezas

	CantidadOrdenada  	float		NULL,
	RequsicionesPendientes  float		NULL,		
	CompraPendiente	  	float		NULL,		
	VentaPendiente	  	float		NULL,		
	VentaRemisionada  	float		NULL,
	ProdPendiente	  	float		NULL,		
	InvPendiente	  	float		NULL,
	EnTransito	  	float		NULL,

	TieneMovimientos  bit		NOT NULL 	DEFAULT 0,

	Logico1		  bit		NOT NULL 	DEFAULT 0,
	Logico2		  bit		NOT NULL 	DEFAULT 0,
	Logico3		  bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priArtR PRIMARY KEY CLUSTERED (Empresa, Articulo, SubCuenta, Almacen)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgArtRB') and sysstat & 0xf = 8) 
  drop trigger dbo.tgArtRB
GO



/****** PersonalAsiste ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalAsiste')
INSERT INTO SysTabla (SysTabla) VALUES ('PersonalAsiste')
if exists (select * from sysobjects where id = object_id('dbo.PersonalAsiste') and type = 'U') 
DROP TABLE PersonalAsiste
GO
CREATE TABLE dbo.PersonalAsiste (
	Empresa		  char(5)	NOT NULL,
	Personal	  char(10) 	NOT NULL,
	Fecha		  datetime	NOT NULL,
        ID		  int		NOT NULL IDENTITY(1,1),

	Entrada		  datetime	NULL,
	Salida		  datetime	NULL,
	Localidad	  varchar(50)	NULL,
	ProcesarAusencia  bit		NOT NULL DEFAULT 1,
	ProcesarExtra     bit		NOT NULL DEFAULT 1,

	CONSTRAINT priPersonalAsiste PRIMARY KEY  CLUSTERED (Empresa, Personal, Fecha, ID)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PersonalAsiste' AND sysindexes.name = 'FechaEntrada' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEntrada ON dbo.PersonalAsiste (Empresa, Personal, Entrada)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PersonalAsiste' AND sysindexes.name = 'FechaSalida' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaSalida  ON dbo.PersonalAsiste (Empresa, Personal, Salida)
go

/****** PersonalAsisteDifDia ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalAsisteDifDia')
INSERT INTO SysTabla (SysTabla) VALUES ('PersonalAsisteDifDia')
if exists (select * from sysobjects where id = object_id('dbo.PersonalAsisteDifDia') and type = 'U')
DROP TABLE PersonalAsisteDifDia
GO
CREATE TABLE dbo.PersonalAsisteDifDia (
	Empresa		char(5)		NOT NULL,
	Personal	char(10) 	NOT NULL,
	Fecha 		datetime	NOT NULL,
	ID		int		NOT NULL IDENTITY(1,1),

	Extra		int		NULL,
	Ausencia	int		NULL,
	Minutos		int		NULL,

	Permiso		varchar(20)	NULL,
	PermisoID	varchar(20)	NULL,
	PermisoConcepto varchar(50)	NULL,

   CONSTRAINT priPersonalAsisteDifDia PRIMARY KEY  CLUSTERED (Empresa, Personal, Fecha, ID)
)
go

/****** PersonalAsisteDifMin ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalAsisteDifMin')
INSERT INTO SysTabla (SysTabla) VALUES ('PersonalAsisteDifMin')
if exists (select * from sysobjects where id = object_id('dbo.PersonalAsisteDifMin') and type = 'U') 
DROP TABLE PersonalAsisteDifMin
GO
CREATE TABLE dbo.PersonalAsisteDifMin (
	Empresa		char(5)		NOT NULL,
	Personal	char(10) 	NOT NULL,
	Fecha 		datetime	NOT NULL,
	ID		int		NOT NULL IDENTITY(1,1),

	FechaHoraD	datetime	NOT NULL,
	FechaHoraA	datetime	NOT NULL,
	Extra		int		NULL,
	Ausencia	int		NULL,
	Registro	char(10)	NULL,           -- Entrada/Salida/Permiso

	Permiso		varchar(20)	NULL,
	PermisoID	varchar(20)	NULL,
	PermisoConcepto varchar(50)	NULL,

       CONSTRAINT priPersonalAsisteDifMin PRIMARY KEY  CLUSTERED (Empresa, Personal, Fecha, ID)
)
go

/****** PersonalAsisteDif ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalAsisteDif')
INSERT INTO SysTabla (SysTabla) VALUES ('PersonalAsisteDif')
if exists (select * from sysobjects where id = object_id('dbo.PersonalAsisteDif') and type = 'U') 
DROP TABLE PersonalAsisteDif
GO
CREATE TABLE dbo.PersonalAsisteDif (
	Empresa		char(5)		NOT NULL,
        Personal	char(10) 	NOT NULL,
	Fecha 		datetime	NOT NULL,
	ID		int		NOT NULL IDENTITY(1,1),

	Registro	char(10)	NULL,           -- Entrada/Salida/Permiso
	Cantidad	int		NULL,
	Tipo		varchar(20)	NULL,
	Concepto	varchar(50)	NULL,

	CONSTRAINT priPersonalAsisteDif PRIMARY KEY  CLUSTERED (Empresa, Personal, Fecha, ID)
)
go

/****** ResumenMov ******/
if not exists(select * from SysTabla where SysTabla = 'ResumenMov')
INSERT INTO SysTabla (SysTabla) VALUES ('ResumenMov')
if exists (select * from sysobjects where id = object_id('dbo.ResumenMov') and type = 'U') 
DROP TABLE ResumenMov
GO
CREATE TABLE dbo.ResumenMov (
	Modulo		char(5)		NOT NULL,
	Empresa		char(5)		NOT NULL,
	Sucursal	int		NOT NULL,
	Ejercicio	int		NOT NULL,
	Periodo		int		NOT NULL,

	Mov		char(20)	NOT NULL,
	Moneda		char(10)	NOT NULL,
	Estatus		char(15)	NOT NULL,

	Conteo		int		NULL,
	Importe		money		NULL,
	Impuestos	money		NULL,
	Saldo		money		NULL,

	CONSTRAINT priResumenMov PRIMARY KEY  CLUSTERED (Mov, Ejercicio, Periodo, Estatus, Sucursal, Moneda, Modulo, Empresa)
)
go

EXEC spFK 'ResumenMov','Modulo','Modulo','Modulo'
GO

/****** ResumenMovProyecto ******/
if not exists(select * from SysTabla where SysTabla = 'ResumenMovProyecto')
INSERT INTO SysTabla (SysTabla) VALUES ('ResumenMovProyecto')
if exists (select * from sysobjects where id = object_id('dbo.ResumenMovProyecto') and type = 'U') 
DROP TABLE ResumenMovProyecto
GO
CREATE TABLE dbo.ResumenMovProyecto (
	Modulo		char(5)		NOT NULL,
	Empresa		char(5)		NOT NULL,
	Sucursal	int		NOT NULL,
	Ejercicio	int		NOT NULL,
	Periodo		int		NOT NULL,

	Mov		char(20)	NOT NULL,
	Moneda		char(10)	NOT NULL,
	Estatus		char(15)	NOT NULL,
	Proyecto	varchar(50)	NOT NULL,

	Conteo		int		NULL,
	Importe		money		NULL,
	Impuestos	money		NULL,
	Saldo		money		NULL,

	CONSTRAINT priResumenMovProyecto PRIMARY KEY  CLUSTERED (Proyecto, Mov, Ejercicio, Periodo, Estatus, Sucursal, Moneda, Modulo, Empresa)
)
go

EXEC spFK 'ResumenMovProyecto','Modulo','Modulo','Modulo'
GO

/****** ResumenSaldo ******/
if not exists(select * from SysTabla where SysTabla = 'ResumenSaldo')
INSERT INTO SysTabla (SysTabla) VALUES ('ResumenSaldo')
if exists (select * from sysobjects where id = object_id('dbo.ResumenSaldo') and type = 'U') 
DROP TABLE ResumenSaldo
GO
CREATE TABLE dbo.ResumenSaldo (
	Modulo		char(5)		NOT NULL,
	Rama		char(5)		NOT NULL,
	Empresa		char(5)		NOT NULL,
	Sucursal	int		NOT NULL,
	Moneda		char(10)	NOT NULL,

	Saldo		money		NULL,
	SaldoU		float		NULL,

	CONSTRAINT priResumenSaldo PRIMARY KEY  CLUSTERED (Rama, Sucursal, Modulo, Moneda, Empresa)
)
go

EXEC spFK 'ResumenSaldo','Modulo','Modulo','Modulo'
GO

/****** ProcesarCBInfo  ******/
if not exists(select * from SysTabla where SysTabla = 'ProcesarCBInfo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProcesarCBInfo','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla) VALUES ('ProcesarCBInfo')
if not exists (select * from sysobjects where id = object_id('dbo.ProcesarCBInfo') and type = 'U') 
CREATE TABLE dbo.ProcesarCBInfo (
	Estacion		int		NOT NULL,

	Empresa			char(5)		NULL,
	Modulo			char(5)		NULL,
	ID			int		NULL,

	Renglon			float		NULL,
	RenglonSub		int		NULL,

	CONSTRAINT priProcesarCBInfo  PRIMARY KEY  CLUSTERED (Estacion)
)
GO


/****** VerInvCorte  ******/
if not exists(select * from SysTabla where SysTabla = 'VerInvCorte')
INSERT INTO SysTabla (SysTabla) VALUES ('VerInvCorte')
if exists (select * from sysobjects where id = object_id('dbo.VerInvCorte') and type = 'U') 
DROP TABLE dbo.VerInvCorte
CREATE TABLE dbo.VerInvCorte (
   Estacion		int		NOT NULL,
   ID			int		IDENTITY(1,1) NOT NULL,

   Empresa		char(5)		NULL,
   Almacen		char(10)	NULL,
   Articulo		char(20)	NULL,
   SubCuenta		varchar(50)	NULL,
   Existencia		float		NULL,
   Fecha		datetime	NULL,

  CONSTRAINT priVerInvCorte PRIMARY KEY CLUSTERED (Estacion, ID)
)
GO



/****** ProrrateoFecha ******/
if not exists (select * from SysTabla where SysTabla = 'ProrrateoFecha') 
INSERT INTO SysTabla (SysTabla) VALUES ('ProrrateoFecha')
if exists (select * from sysobjects where id = object_id('dbo.ProrrateoFecha') and type = 'U') 
DROP TABLE dbo.ProrrateoFecha
if not exists (select * from sysobjects where id = object_id('dbo.ProrrateoFecha') and type = 'U') 
  CREATE TABLE dbo.ProrrateoFecha (
	Estacion	int		NOT NULL,
	ID		int		NOT NULL 	IDENTITY(1,1),

	Cantidad	float		NULL,
	Fecha		datetime	NULL,

	CONSTRAINT priProrrateoFecha PRIMARY KEY  CLUSTERED (Estacion, ID)
)
GO


/* MovLote */
if exists (select * from sysobjects where id = object_id('dbo.MovLote') and sysstat & 0xf = 3) drop table dbo.MovLote
go
CREATE TABLE dbo.MovLote (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Mov			char(20)	NULL,
	MovID			varchar(20)   	NULL,

	CONSTRAINT priMovLote PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/**************** spMovLoteEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovLoteEliminar') and type = 'P') drop procedure dbo.spMovLoteEliminar
GO             
CREATE PROCEDURE spMovLoteEliminar
			@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  DELETE MovLote WHERE Estacion = @Estacion
END
GO

/* CtaLote */
if exists (select * from sysobjects where id = object_id('dbo.CtaLote') and sysstat & 0xf = 3) drop table dbo.CtaLote
go
CREATE TABLE dbo.CtaLote (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Cuenta			char(20)	NULL,

	CONSTRAINT priCtaLote PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/**************** spCtaLoteEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCtaLoteEliminar') and type = 'P') drop procedure dbo.spCtaLoteEliminar
GO             
CREATE PROCEDURE spCtaLoteEliminar
			@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  DELETE CtaLote WHERE Estacion = @Estacion
END
GO



/****** CompraProrrateoManual ******/
if not exists(select * from SysTabla where SysTabla = 'CompraProrrateoManual')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CompraProrrateoManual','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CompraProrrateoManual') and type = 'U') 
CREATE TABLE dbo.CompraProrrateoManual (
	Estacion	int		NOT NULL,
	Grupo		varchar(50)	NOT NULL,

	Cantidad	float		NULL,	

	CONSTRAINT priCompraProrrateoManual PRIMARY KEY CLUSTERED (Estacion, Grupo)
)
GO


/**************** spCompraProrrateoManualEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompraProrrateoManualEliminar') and type = 'P') drop procedure dbo.spCompraProrrateoManualEliminar
GO             
CREATE PROCEDURE spCompraProrrateoManualEliminar
			@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  DELETE CompraProrrateoManual WHERE Estacion = @Estacion
END
GO


/****** VentaAsignarSusutitos ******/
if exists (select * from sysobjects where id = object_id('dbo.VentaAsignarSusutitos') and sysstat & 0xf = 3) drop table dbo.VentaAsignarSusutitos
go
if not exists (select * from sysobjects where id = object_id('dbo.VentaAsignarSusutitos') and type = 'U') 
CREATE TABLE dbo.VentaAsignarSusutitos (
	Estacion	int		NOT NULL,
	ID		int		NOT NULL	IDENTITY(1,1),

	Orden		int		NULL,
	Articulo	char(20)	NULL,	
	SubCuenta	varchar(50)	NULL,
	Almacen		char(10)	NULL,
	Factor		float		NULL,	
	Comentarios	varchar(100)	NULL,

	Disponible	float		NULL,	
	Cantidad	float		NULL,	

	CONSTRAINT priVentaAsignarSusutitos PRIMARY KEY CLUSTERED (Estacion, ID)
)
GO

/**************** spVentaAsignarSusutitos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaAsignarSusutitos') and type = 'P') drop procedure dbo.spVentaAsignarSusutitos
GO             
CREATE PROCEDURE spVentaAsignarSusutitos
			@Estacion		int,
			@Empresa		char(5),
			@Almacen		char(10),
			@ArticuloSustituir	char(20)
--//WITH ENCRYPTION
AS BEGIN
  DELETE VentaAsignarSusutitos WHERE Estacion = @Estacion
  INSERT VentaAsignarSusutitos (Estacion, Factor, Orden, Comentarios, Articulo, SubCuenta, Almacen, Disponible)
        SELECT @Estacion, s.Factor, s.Orden, s.Comentarios, s.Sustituto, d.SubCuenta, @Almacen, d.Disponible
          FROM ArtSustituto s, ArtSubDisponible d
         WHERE s.Articulo = @ArticuloSustituir AND d.Empresa = @Empresa AND s.Sustituto=d.Articulo AND d.Almacen = @Almacen
END
GO
-- spVentaAsignarSusutitos 501, 'DEMO', 'STOCK', 'CAJA'
-- select * from VentaAsignarSusutitos
-- select * from ArtSustituto
-- spVentaAsignarSusutitosAceptar 100, 4, 2048, 0, 1, 'A1', NULL

/**************** spVentaAsignarSusutitosAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaAsignarSusutitosAceptar') and type = 'P') drop procedure dbo.spVentaAsignarSusutitosAceptar
GO             
CREATE PROCEDURE spVentaAsignarSusutitosAceptar
			@Estacion	int,
			@ID		int,
			@Renglon	float,
			@RenglonSub	int,
	 		@RenglonID	int,
			@Articulo	char(20),
			@SubCuenta	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @ActualizarPrecios	bit,
    @NuevoRenglonSub	int,
    @Orden		int,
    @sArticulo		char(20), 
    @sSubCuenta		varchar(50),
    @ListaPrecios	varchar(50),
    @Precio		float,
    @Moneda		char(10),
    @TipoCambio		float 

  IF NOT EXISTS(SELECT * FROM VentaAsignarSusutitos WHERE Estacion = @Estacion AND NULLIF(Cantidad, 0) IS NOT NULL)
    RETURN
  BEGIN TRANSACTION
    SELECT @Empresa = Empresa, @ListaPrecios = ListaPreciosEsp, @Moneda = Moneda, @TipoCambio = TipoCambio FROM Venta WHERE ID = @ID
    SELECT @ActualizarPrecios = ISNULL(FacturarSustitutosPrecios, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa

    SELECT @NuevoRenglonSub = ISNULL(MAX(RenglonSub), 0) FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
    UPDATE VentaAsignarSusutitos SET Orden = NULL WHERE Estacion = @Estacion
    SELECT @Orden = 0
    UPDATE VentaAsignarSusutitos SET @Orden = Orden = @Orden + 1 WHERE Estacion = @Estacion AND NULLIF(Cantidad, 0) IS NOT NULL

    SELECT @SubCuenta = NULLIF(@SubCuenta, '0')
    SELECT d.* 
      INTO #VentaDetalle 
      FROM cVentaD d, VentaAsignarSusutitos s 
     WHERE d.ID = @ID AND d.Renglon = @Renglon AND d.RenglonSub = @RenglonSub AND d.RenglonID = @RenglonID AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '')
       AND s.Estacion = @Estacion AND NULLIF(s.Cantidad, 0) IS NOT NULL

    UPDATE #VentaDetalle SET RenglonSub = s.ID FROM VentaAsignarSusutitos s WHERE s.Estacion = @Estacion AND NULLIF(s.Cantidad, 0) IS NOT NULL
    SELECT @Orden = 0
    UPDATE #VentaDetalle SET @Orden = RenglonSub = @Orden + 1, SustitutoArticulo = Articulo, SustitutoSubCuenta = SubCuenta
    UPDATE #VentaDetalle SET Articulo = s.Articulo, SubCuenta = NULLIF(s.SubCuenta, ''), CantidadInventario = d.CantidadInventario*s.Cantidad/NULLIF(d.Cantidad, 0), Cantidad = s.Cantidad FROM #VentaDetalle d, VentaAsignarSusutitos s WHERE s.Estacion = @Estacion AND NULLIF(s.Cantidad, 0) IS NOT NULL AND d.RenglonSub = s.Orden
    UPDATE #VentaDetalle SET @NuevoRenglonSub = RenglonSub = @NuevoRenglonSub + 1 

    IF @ActualizarPrecios = 1
    BEGIN
      DECLARE crActualizarPrecios CURSOR FOR
       SELECT Articulo, SubCuenta
         FROM #VentaDetalle
      OPEN crActualizarPrecios
      FETCH NEXT FROM crActualizarPrecios INTO @sArticulo, @sSubCuenta
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          EXEC spVerArtPrecioDescuento @sArticulo, @sSubCuenta, @ListaPrecios, @Moneda, @TipoCambio, 1, @Precio OUTPUT
          UPDATE #VentaDetalle SET Precio = @Precio WHERE CURRENT OF crActualizarPrecios
        END
        FETCH NEXT FROM crActualizarPrecios INTO @sArticulo, @sSubCuenta
      END  -- While
      CLOSE crActualizarPrecios
      DEALLOCATE crActualizarPrecios
    END

    DELETE VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')   
    INSERT INTO cVentaD SELECT * FROM #VentaDetalle
    DROP TABLE #VentaDetalle
  IF @@ERROR = 0
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION
END
GO

-- spProgramaAsignarSusutitosAceptar 501, 54, 4096.0, 'CAJA', '0'

/**************** spProgramaAsignarSusutitosAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProgramaAsignarSusutitosAceptar') and type = 'P') drop procedure dbo.spProgramaAsignarSusutitosAceptar
GO             
CREATE PROCEDURE spProgramaAsignarSusutitosAceptar
			@Estacion	int,
			@ID		int,
			@Renglon	float,
			@Articulo	char(20),
			@SubCuenta	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cantidad		float,
    @NuevoRenglon	float,
    @Orden		int

  IF NOT EXISTS(SELECT * FROM VentaAsignarSusutitos WHERE Estacion = @Estacion AND NULLIF(Cantidad, 0) IS NOT NULL)
    RETURN
  --BEGIN TRANSACTION
    UPDATE VentaAsignarSusutitos SET Orden = NULL WHERE Estacion = @Estacion
    SELECT @Orden = 0
    UPDATE VentaAsignarSusutitos SET @Orden = Orden = @Orden + 1 WHERE Estacion = @Estacion AND NULLIF(Cantidad, 0) IS NOT NULL

    SELECT @SubCuenta = NULLIF(@SubCuenta, '0')
    SELECT Producto, SubProducto, CantidadP, UnidadP, Lote, Unidad, Factor, Merma, Desperdicio, AlmacenDestino, AlmacenOrigen, FechaRequerida
      INTO #ProgramaMaterial
      FROM ProdProgramaMaterial
     WHERE ID = @ID AND Renglon = @Renglon

    SELECT @NuevoRenglon = ISNULL(MAX(Renglon), 0) FROM ProdProgramaMaterial WHERE ID = @ID

    DECLARE crSustitutos CURSOR FOR
     SELECT Articulo, SubCuenta, Cantidad
       FROM VentaAsignarSusutitos
      WHERE Estacion = @Estacion AND NULLIF(Cantidad, 0) IS NOT NULL

    OPEN crSustitutos
    FETCH NEXT FROM crSustitutos INTO @Articulo, @SubCuenta, @Cantidad
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @NuevoRenglon = @NuevoRenglon + 2048.0
        INSERT ProdProgramaMaterial (ID, Renglon, Producto, SubProducto, CantidadP, UnidadP, Lote, Articulo, SubCuenta, Cantidad, Unidad, Factor, Merma, Desperdicio, AlmacenDestino, AlmacenOrigen, FechaRequerida)
        SELECT @ID, @NuevoRenglon, Producto, SubProducto, CantidadP, UnidadP, Lote, @Articulo, @SubCuenta, @Cantidad, Unidad, Factor, Merma, Desperdicio, AlmacenDestino, AlmacenOrigen, FechaRequerida
          FROM #ProgramaMaterial
      END
      FETCH NEXT FROM crSustitutos INTO @Articulo, @SubCuenta, @Cantidad
    END  -- While
    CLOSE crSustitutos
    DEALLOCATE crSustitutos
    DELETE ProdProgramaMaterial WHERE ID = @ID AND Renglon = @Renglon

/*  IF @@ERROR = 0
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION*/
END
GO

/****** Reevaluacion ******/
if not exists(select * from SysTabla where SysTabla = 'Reevaluacion')
INSERT INTO SysTabla (SysTabla) VALUES ('Reevaluacion')
if exists (select * from sysobjects where id = object_id('dbo.Reevaluacion') and type = 'U') 
DROP TABLE dbo.Reevaluacion
CREATE TABLE dbo.Reevaluacion (
	Estacion	int		NOT NULL,
	Moneda		char(10)	NOT NULL,

	TipoCambio	float		NULL,

	CONSTRAINT priReevaluacion PRIMARY KEY CLUSTERED (Estacion, Moneda)

)
GO

EXEC spFK 'Reevaluacion','Moneda','Mon','Moneda'
GO

/**************** spReevaluacionPreparar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spReevaluacionPreparar') and type = 'P') drop procedure dbo.spReevaluacionPreparar
GO             
CREATE PROCEDURE spReevaluacionPreparar
			@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  DELETE Reevaluacion WHERE Estacion = @Estacion
END
GO

/* PlanDemanda */
if exists (select * from sysobjects where id = object_id('dbo.PlanDemanda') and sysstat & 0xf = 3) drop table dbo.PlanDemanda
go
CREATE TABLE dbo.PlanDemanda (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Modulo			char(5)		NULL,
	ModuloID		int		NULL,
	Mov			char(20)	NULL,
	MovID			varchar(20)	NULL,
	Empresa			char(5)		NULL,
	Almacen			char(10)	NULL,
	Articulo		char(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Acronimo		char(10)	NULL,
	Periodo			int		NULL,
	Cantidad		money		NULL,

	CONSTRAINT priPlanDemanda PRIMARY KEY CLUSTERED (Estacion, ID)
)
go


/****** TransferirLote ******/
if not exists(select * from SysTabla where SysTabla = 'TransferirLote')
INSERT INTO SysTabla (SysTabla) VALUES ('TransferirLote')
if exists (select * from sysobjects where id = object_id('dbo.TransferirLote') and type = 'U') 
DROP TABLE dbo.TransferirLote
CREATE TABLE dbo.TransferirLote (
	Estacion	int		NOT NULL,
	Almacen		char(10)	NOT NULL,

	Cantidad	int		NULL,

	CONSTRAINT priTransferirLote PRIMARY KEY CLUSTERED (Estacion, Almacen)

)
GO

/****** ArtExplosion ******/
if not exists(select * from SysTabla where SysTabla = 'ArtExplosion')
INSERT INTO SysTabla (SysTabla) VALUES ('ArtExplosion')
if exists (select * from sysobjects where id = object_id('dbo.ArtExplosion') and type = 'U') 
DROP TABLE dbo.ArtExplosion
CREATE TABLE dbo.ArtExplosion (
	Estacion		int		NOT NULL,
	Articulo		char(20) 	NOT NULL,

	Cantidad		float	 	NULL,

	CONSTRAINT priArtExplosion PRIMARY KEY  CLUSTERED (Estacion, Articulo)
)
go



/****** ABCSugeridoCat ******/
if not exists(select * from SysTabla where SysTabla = 'ABCSugeridoCat')
INSERT INTO SysTabla (SysTabla) VALUES ('ABCSugeridoCat')
if exists (select * from sysobjects where id = object_id('dbo.ABCSugeridoCat') and type = 'U') 
DROP TABLE dbo.ABCSugeridoCat
CREATE TABLE dbo.ABCSugeridoCat (
	Estacion		int		NOT NULL,
	Categoria		varchar(50)	NOT NULL,

	FechaHora		datetime	NULL,

	CONSTRAINT priABCSugeridoCat PRIMARY KEY  CLUSTERED (Estacion, Categoria)
)
go


/****** ABCSugerido ******/
if not exists(select * from SysTabla where SysTabla = 'ABCSugerido')
INSERT INTO SysTabla (SysTabla) VALUES ('ABCSugerido')
if exists (select * from sysobjects where id = object_id('dbo.ABCSugerido') and type = 'U') 
DROP TABLE dbo.ABCSugerido
CREATE TABLE dbo.ABCSugerido (
	Categoria		varchar(50)	NOT NULL,
	Articulo		char(20) 	NOT NULL,

	ABC			char(1)		NULL,
	Cantidad		float		NULL,
	Valor			money		NULL,
	Participacion		float		NULL,

	CONSTRAINT priABCSugerido PRIMARY KEY  CLUSTERED (Categoria, Articulo)
)
go


/****** ArtQuiebre ******/
if not exists(select * from SysTabla where SysTabla = 'ArtQuiebre')
INSERT INTO SysTabla (SysTabla) VALUES ('ArtQuiebre')
if exists (select * from sysobjects where id = object_id('dbo.ArtQuiebre') and type = 'U') 
DROP TABLE dbo.ArtQuiebre
CREATE TABLE dbo.ArtQuiebre (
	Familia			varchar(50)	NOT NULL,
	Articulo		char(20) 	NOT NULL,

	Ventas			float	 	NULL,
	Devoluciones		float	 	NULL,
	Faltantes		float	 	NULL,
        DemandaNeta             float	 	NULL,
	Scanner			float		NULL,

	VentaAjustada		float		NULL,

	CONSTRAINT priArtQuiebre PRIMARY KEY  CLUSTERED (Familia, Articulo)
)
go

/****** CteQuiebre ******/
if not exists(select * from SysTabla where SysTabla = 'CteQuiebre')
INSERT INTO SysTabla (SysTabla) VALUES ('CteQuiebre')
if exists (select * from sysobjects where id = object_id('dbo.CteQuiebre') and type = 'U') 
DROP TABLE dbo.CteQuiebre
CREATE TABLE dbo.CteQuiebre (
	Familia              varchar(50)        NOT NULL,
	Cliente              char(10)           NOT NULL,
	EnviarA              int                NOT NULL,

	VentaNeta            float              NULL,

	CONSTRAINT priCteQuiebre PRIMARY KEY  CLUSTERED (Familia, Cliente, EnviarA)
)
go

/* ListaOk */
if exists (select * from sysobjects where id = object_id('dbo.ListaOk') and sysstat & 0xf = 3) drop table dbo.ListaOk
go
CREATE TABLE dbo.ListaOk (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

        Ok                      int             NULL,
        OkRef                   varchar(255)    NULL,

	CONSTRAINT priListaOk PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

EXEC spFK 'ListaOk','Ok','MensajeLista','Mensaje'
GO

/* ExplorarVINFiltro */
if exists (select * from sysobjects where id = object_id('dbo.ExplorarVINFiltro') and sysstat & 0xf = 3) drop table dbo.ExplorarVINFiltro
go
CREATE TABLE dbo.ExplorarVINFiltro (
	Estacion		int		NOT NULL,

    	Fabricante		varchar(50)	NULL,
    	Modelo			varchar(50)	NULL,
    	Linea			varchar(50)	NULL,
    	Version			varchar(50)	NULL,
    	Articulo		varchar(50)	NULL,
	
	CONSTRAINT priExplorarVINFiltro PRIMARY KEY CLUSTERED (Estacion)
)
go

/* SugerirFacturaNConsumo */
if exists (select * from sysobjects where id = object_id('dbo.SugerirFacturaNConsumo') and sysstat & 0xf = 3) drop table dbo.SugerirFacturaNConsumo
go
CREATE TABLE dbo.SugerirFacturaNConsumo (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Renglon			float		NULL,
	RenglonID		int		NULL,
	Articulo		char(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	Importe			money		NULL,

	EstaCubierto		bit		NULL	DEFAULT 0,
	Extra			bit		NULL	DEFAULT 0,

	CONSTRAINT priSugerirFacturaNConsumo PRIMARY KEY CLUSTERED (Estacion, ID)
)
go


/* ReporteSistemaDetallista */
if exists (select * from sysobjects where id = object_id('dbo.ReporteSistemaDetallista') and sysstat & 0xf = 3) drop table dbo.ReporteSistemaDetallista
go
CREATE TABLE dbo.ReporteSistemaDetallista (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Grupo			int		NULL,		
	DepartamentoDetallista	int		NULL,
	Orden			int		NULL,
	Concepto		varchar(50)	NULL,
	Costo			money		NULL,
	Precio			money		NULL,
	Factor			float		NULL,

	CONSTRAINT priReporteSistemaDetallista PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/* VentaTraspasarArticulos */
if exists (select * from sysobjects where id = object_id('dbo.VentaTraspasarArticulos') and sysstat & 0xf = 3) drop table dbo.VentaTraspasarArticulos
go
CREATE TABLE dbo.VentaTraspasarArticulos (
	ID			int		NOT NULL,
	Estacion		int		NOT NULL,
	RID			int		NOT NULL IDENTITY(1,1),

	Codigo			varchar(30)	NULL,		
	Articulo		varchar(20)	NULL,
	Cantidad		float		NULL,
	Precio			float		NULL,
	Costo			float		NULL,
	Accion			varchar(20)	NULL,		-- Agregar / Cancelar
	Referencia		varchar(50)	NULL,

	CONSTRAINT priVentaTraspasarArticulos PRIMARY KEY CLUSTERED (ID, Estacion, RID)
)
go

EXEC spFK 'VentaTraspasarArticulos','Codigo','CB','Codigo'
EXEC spFK 'VentaTraspasarArticulos','Articulo','Art','Articulo'
GO

/****** InfoPathEstructura ******/
/*if not exists(select * from SysTabla where SysTabla = 'InfoPathEstructura')
INSERT INTO SysTabla (SysTabla) VALUES ('InfoPathEstructura')
if exists (select * from sysobjects where id = object_id('dbo.InfoPathEstructura') and type = 'U') DROP TABLE dbo.InfoPathEstructura*/
GO
/*CREATE TABLE dbo.InfoPathEstructura (
	Sesion		int  		NOT NULL,
	ID		int		NOT NULL IDENTITY (1,1),

	Grupo		varchar(100)	NULL,
	SubGrupoDe	varchar(100)	NULL,
	Campo		varchar(100)	NULL,

	Tipo		varchar(20)	NULL,	-- varchar(??), int, float, money

	CONSTRAINT priInfoPathEstructura PRIMARY KEY CLUSTERED (Sesion, ID)

)*/
GO

/****** InfoPathDato ******/
/*if not exists(select * from SysTabla where SysTabla = 'InfoPathDato')
INSERT INTO SysTabla (SysTabla) VALUES ('InfoPathDato')
if exists (select * from sysobjects where id = object_id('dbo.InfoPathDato') and type = 'U') DROP TABLE dbo.InfoPathDato*/
GO
/*CREATE TABLE dbo.InfoPathDato (
	Sesion		int  		NOT NULL,
	ID		int		NOT NULL IDENTITY (1,1),

	Grupo		varchar(100)	NULL,
	SubGrupoDe	varchar(100)	NULL,
	Campo		varchar(100)	NULL,

	Renglon		int		NULL,
	Dato		varchar(255)	NULL,
	Texto		text		NULL,

	CONSTRAINT priInfoPathDato PRIMARY KEY CLUSTERED (Sesion, ID)

)*/
GO

/* ContDistribuir */
if exists (select * from sysobjects where id = object_id('dbo.ContDistribuir') and sysstat & 0xf = 3) drop table dbo.ContDistribuir
go
CREATE TABLE dbo.ContDistribuir (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Cuenta			varchar(20)	NULL,
	SubCuenta		varchar(50)   	NULL,
	Importe  		money        	NULL,

	CONSTRAINT priContDistribuir PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

EXEC spFK 'ContDistribuir','Cuenta','Cta','Cuenta'
GO

/* ArtOpcionWizard */
if exists (select * from sysobjects where id = object_id('dbo.ArtOpcionWizard') and sysstat & 0xf = 3) drop table dbo.ArtOpcionWizard
go
CREATE TABLE dbo.ArtOpcionWizard (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Opcion			char(1)		NULL,	
	Generar			bit		NULL	DEFAULT 0,

	CONSTRAINT priArtOpcionWizard PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

EXEC spFK 'ArtOpcionWizard','Opcion','Opcion','Opcion'
GO

/* ArtOpcionPreliminar */
if exists (select * from sysobjects where id = object_id('dbo.ArtOpcionPreliminar') and sysstat & 0xf = 3) drop table dbo.ArtOpcionPreliminar
go
CREATE TABLE dbo.ArtOpcionPreliminar (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Codigo			varchar(30)	NULL,
	SubCuenta		varchar(50)	NULL,	

	CONSTRAINT priArtOpcionPreliminar PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/* ContRegDif */
if exists (select * from sysobjects where id = object_id('dbo.ContRegDif') and sysstat & 0xf = 3) drop table dbo.ContRegDif
go
CREATE TABLE dbo.ContRegDif (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL,

	ContImporte		money		NULL,
	RegImporte		money		NULL,

	CONSTRAINT priContRegDif PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

EXEC spFK 'ContRegDif','ID','Cont','ID'
GO

--drop table SerieLoteMovLinea
/****** SerieLoteMovLinea ******/
/*if not exists(select * from SysTabla where SysTabla = 'SerieLoteMovLinea')
INSERT INTO SysTabla (SysTabla) VALUES ('SerieLoteMovLinea')
if exists (select * from sysobjects where id = object_id('dbo.SerieLoteMovLinea') and type = 'U') 
DROP TABLE dbo.SerieLoteMovLinea
CREATE TABLE dbo.SerieLoteMovLinea (
	Estacion	int  		NOT NULL,
	RID		int		NOT NULL IDENTITY(1,1),

	Empresa		char(5)		NOT NULL,
	Modulo		char(5)		NOT NULL,
	ID		int		NOT NULL,
	RenglonID	int		NOT NULL,
	Articulo	varchar(20)	NOT NULL,
	SubCuenta	varchar(50)	NOT NULL,

	Linea		varchar(255)	NULL,

	CONSTRAINT priSerieLoteMovLinea PRIMARY KEY CLUSTERED (Estacion, RID, ID, RenglonID, Articulo, SubCuenta, Empresa, Modulo)

)*/
GO

/* SPIDTemp */
if exists (select * from sysobjects where id = object_id('dbo.SPIDTemp') and sysstat & 0xf = 3) drop table dbo.SPIDTemp
go
CREATE TABLE dbo.SPIDTemp (
	SPID			int		NOT NULL,

	Monetario		money		NULL,
	Flotante		float		NULL,
	Numerico		int		NULL,
	Texto			varchar(255)	NULL,
	Fecha			datetime	NULL,

	CONSTRAINT priSPIDTemp PRIMARY KEY CLUSTERED (SPID)
)
go


/**************** spSPIDTemp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSPIDTemp') and type = 'P') drop procedure dbo.spSPIDTemp
GO
CREATE PROCEDURE spSPIDTemp
			@Monetario	money		= NULL,
			@Flotante	float		= NULL,
			@Numerico	int		= NULL,
			@Texto		varchar(255)	= NULL,
			@Fecha		datetime	= NULL
--//WITH ENCRYPTION
AS BEGIN
  UPDATE SPIDTemp
     SET Monetario = @Monetario,
         Flotante  = @Flotante,
         Numerico  = @Numerico,
         Texto	   = @Texto,
         Fecha     = @Fecha
   WHERE SPID = @@SPID
  IF @@ROWCOUNT = 0
    INSERT SPIDTemp (
            SPID,   Monetario,  Flotante,  Numerico,  Texto,  Fecha)
    VALUES (@@SPID, @Monetario, @Flotante, @Numerico, @Texto, @Fecha)
  RETURN
END
GO


/* MapaTemp */
if exists (select * from sysobjects where id = object_id('dbo.MapaTemp') and sysstat & 0xf = 3) drop table dbo.MapaTemp
go
CREATE TABLE dbo.MapaTemp (
	Estacion		int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Clave			varchar(20)	NULL,
	EnviarA			int		NULL,
	Nombre 			varchar(100)    NULL,
	Direccion 		varchar(100) 	NULL,
	DireccionNumero		varchar(20)	NULL,
	DireccionNumeroInt	varchar(20)	NULL,
	EntreCalles		varchar(100) 	NULL,
	Observaciones		varchar(100)    NULL,
	Delegacion		varchar(100) 	NULL,
	Colonia 		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	CodigoPostal 		varchar(15) 	NULL,

	Situacion		varchar(50)	NULL,
	SituacionColorNumero	int		NULL,

	MapaLatitud		float		NULL,
	MapaLongitud		float		NULL,
	MapaPrecision		int		NULL,
	MapaRuta		varchar(20)	NULL,
	MapaOrden		int		NULL,
	MapaRutaKm		float		NULL,
	MapaRutaMinutos		float		NULL,
        EmbarqueMov             int             NULL,

	CONSTRAINT priMapaTemp PRIMARY KEY CLUSTERED (Estacion, ID)
)
go

/**************** spMapaTempBorrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMapaTempBorrar') and type = 'P') drop procedure dbo.spMapaTempBorrar
GO
CREATE PROCEDURE spMapaTempBorrar
			@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  DELETE MapaTemp WHERE Estacion = @Estacion
  RETURN
END
GO

/**************** spMapaTempAgregar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMapaTempAgregar') and type = 'P') drop procedure dbo.spMapaTempAgregar
GO
CREATE PROCEDURE spMapaTempAgregar
			@Estacion	int,
			@Referencia	varchar(50),
			@Clave		varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p		int,
    @Clave1	varchar(20),
    @Clave2	varchar(20)
    
  IF CHARINDEX('|', @Referencia) > 0
  BEGIN
    SELECT @p = CHARINDEX ('|', @Clave)
    IF @p > 0
      SELECT @Clave1 = SUBSTRING(@Clave, 1, @p-1),
             @Clave2 = SUBSTRING(@Clave, @p+1, LEN(@Clave))
  END
  
  IF @Referencia = 'Cliente'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,   SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Cliente, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, s.Situacion, c.Numero,             MapaLatitud, MapaLongitud, MapaPrecision
      FROM Cte
      LEFT OUTER JOIN CtaSituacion s ON s.Rama = 'CXC' AND s.Situacion = Cte.Situacion
      LEFT OUTER JOIN Color c ON s.Color = c.Color      
     WHERE Cte.Cliente = @Clave
  IF @Referencia = 'Cliente|EnviarA'
    INSERT MapaTemp (
           Estacion,  Clave,  Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, @Clave, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision
      FROM CteEnviarA
     WHERE Cliente = @Clave1 AND ID = CONVERT(int, @Clave2)
  IF @Referencia = 'Proveedor'
    INSERT MapaTemp (
           Estacion,  Clave,     Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,   SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Proveedor, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, s.Situacion, c.Numero,             MapaLatitud, MapaLongitud, MapaPrecision
      FROM Prov
      LEFT OUTER JOIN CtaSituacion s ON s.Rama = 'CXP' AND s.Situacion = Prov.Situacion
      LEFT OUTER JOIN Color c ON s.Color = c.Color      
     WHERE Prov.Proveedor = @Clave
  IF @Referencia = 'Personal'
    INSERT MapaTemp (
           Estacion,  Clave,    Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,   SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Personal, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, s.Situacion, c.Numero,             MapaLatitud, MapaLongitud, MapaPrecision
      FROM Personal
      LEFT OUTER JOIN CtaSituacion s ON s.Rama = 'CXP' AND s.Situacion = Personal.Situacion
      LEFT OUTER JOIN Color c ON s.Color = c.Color      
     WHERE Personal.Personal = @Clave
  IF @Referencia = 'Agente'
    INSERT MapaTemp (
           Estacion,  Clave,  Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, Delegacion, */Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Agente, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, Delegacion, */Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision
      FROM Agente
     WHERE Agente.Agente = @Clave
  IF @Referencia = 'Almacen'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Almacen, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision
      FROM Alm
     WHERE Alm.Almacen = @Clave
  IF @Referencia = 'Sucursal'
    INSERT MapaTemp (
           Estacion,  Clave,                          Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, */Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, CONVERT(varchar(10), Sucursal), Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, */Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision
      FROM Sucursal
     WHERE Sucursal.Sucursal = CONVERT(int, @Clave)

/*  IF @Referencia = 'Desarrollo'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Desarrollo, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Población, Estado, Pais, CodigoPostal, vic_Desarrollo.Situacion, MapaLatitud, MapaLongitud, MapaPrecision
      FROM vic_Desarrollo
    WHERE vic_Desarrollo.Desarrollo = @Clave     
    
  IF @Referencia = 'Inmueble'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Inmueble, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, vic_Inmueble.Situacion, MapaLatitud, MapaLongitud, MapaPrecision
      FROM vic_Inmueble
    WHERE vic_Inmueble.Inmueble = @Clave 

  IF @Referencia = 'Area'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Area, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Población, Estado, Pais, CodigoPostal, vic_Area.Situacion, MapaLatitud, MapaLongitud, MapaPrecision
      FROM vic_Area
    WHERE vic_Area.Area = @Clave     
        
  IF @Referencia = 'Contrato'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Contrato.ID, Contrato.Mov+''+Contrato.MovID, vic_Contrato.Direccion, vic_Contrato.DireccionNumero, vic_Contrato.DireccionNumeroInt, vic_Contrato.EntreCalles, Contrato.Observaciones, vic_Contrato.Delegacion, vic_Contrato.Colonia, vic_Contrato.Población, vic_Contrato.Estado, vic_Contrato.Pais, vic_Contrato.CodigoPostal, Contrato.Situacion, vic_Contrato.MapaLatitud, vic_Contrato.MapaLongitud, vic_Contrato.MapaPrecision
      FROM vic_Contrato
      JOIN Contrato ON vic_Contrato.ID = Contrato.ID
    WHERE vic_Contrato.ID = @Clave     

  IF @Referencia = 'Fiador'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Contrato.ID, vic_Contrato.Fiador, vic_Contrato.DireccionFiador, vic_Contrato.DireccionNumeroFiador, vic_Contrato.DireccionNumeroIntFiador, vic_Contrato.EntreCallesFiador, Contrato.Observaciones, vic_Contrato.DelegacionFiador, vic_Contrato.ColoniaFiador, vic_Contrato.PoblaciónFiador, vic_Contrato.EstadoFiador, vic_Contrato.PaisFiador, vic_Contrato.CodigoPostalFiador, Contrato.Situacion, vic_Contrato.MapaLatitudFiador, vic_Contrato.MapaLongitudFiador, vic_Contrato.MapaPrecisionFiador
      FROM vic_Contrato
      JOIN Contrato ON vic_Contrato.ID = Contrato.ID
    WHERE vic_Contrato.ID = @Clave*/ 
    
  IF @Referencia = 'Proy'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion)
    SELECT @Estacion, Proyecto, Descripcion, Direccion, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion
      FROM Proy
    WHERE Proyecto = @Clave 

   /*IF @Referencia = 'Notaria'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, NumNotaria, NombreCorto, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Población, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision
	FROM vic_Notaria
	WHERE Notaria  = @Clave*/        

  RETURN
END
GO

/**************** spMapaTempAgregarListaSt ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMapaTempAgregarListaSt') and type = 'P') drop procedure dbo.spMapaTempAgregarListaSt
GO
CREATE PROCEDURE spMapaTempAgregarListaSt
			@Estacion	int,
			@Referencia	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DELETE MapaTemp WHERE Estacion = @Estacion
  IF @Referencia = 'Cliente'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Cliente, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Cte.Situacion, Color.Numero,         MapaLatitud, MapaLongitud, MapaPrecision
      FROM Cte
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = Cte.Cliente
      LEFT OUTER JOIN CtaSituacion ON CtaSituacion.Rama = 'CXC' AND CtaSituacion.Situacion = Cte.Situacion
      LEFT OUTER JOIN Color ON Color.Color = CtaSituacion.Color
  IF @Referencia = 'Proveedor'
    INSERT MapaTemp (
           Estacion,  Clave,     Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,      SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Proveedor, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Prov.Situacion, Color.Numero,         MapaLatitud, MapaLongitud, MapaPrecision
      FROM Prov
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = Prov.Proveedor
      LEFT OUTER JOIN CtaSituacion ON CtaSituacion.Rama = 'CXP' AND CtaSituacion.Situacion = Prov.Situacion
      LEFT OUTER JOIN Color ON Color.Color = CtaSituacion.Color
  IF @Referencia = 'Personal'
    INSERT MapaTemp (
           Estacion,  Clave,    Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,          SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Personal, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Personal.Situacion, Color.Numero,         MapaLatitud, MapaLongitud, MapaPrecision
      FROM Personal
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = Personal.Personal
      LEFT OUTER JOIN CtaSituacion ON CtaSituacion.Rama = 'RH' AND CtaSituacion.Situacion = Personal.Situacion
      LEFT OUTER JOIN Color ON Color.Color = CtaSituacion.Color
  IF @Referencia = 'Agente'
    INSERT MapaTemp (
           Estacion,  Clave,  Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, Delegacion, */Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Agente, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, Delegacion, */Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision
      FROM Agente
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = Agente.Agente
  IF @Referencia = 'Almacen'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Almacen, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision
      FROM Alm
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = Alm.Almacen
  IF @Referencia = 'Sucursal'
    INSERT MapaTemp (
           Estacion,  Clave,                          Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, */Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, CONVERT(varchar(10), Sucursal), Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, */Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision
      FROM Sucursal
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = CONVERT(varchar(10), Sucursal)
  /*IF @Referencia = 'Desarrollo'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Desarrollo, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Población, Estado, Pais, CodigoPostal, vic_Desarrollo.Situacion, Color.Numero, MapaLatitud, MapaLongitud, MapaPrecision
      FROM vic_Desarrollo
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = vic_Desarrollo.Desarrollo
      LEFT OUTER JOIN CtaSituacion ON CtaSituacion.Rama = 'CXC' AND CtaSituacion.Situacion = vic_Desarrollo.Situacion
      LEFT OUTER JOIN Color ON Color.Color = CtaSituacion.Color

  IF @Referencia = 'Area'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Area, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Población, Estado, Pais, CodigoPostal, vic_Area.Situacion, Color.Numero, MapaLatitud, MapaLongitud, MapaPrecision
      FROM vic_Area
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = vic_Area.Area
      LEFT OUTER JOIN CtaSituacion ON CtaSituacion.Rama = 'CXC' AND CtaSituacion.Situacion = vic_Area.Situacion
      LEFT OUTER JOIN Color ON Color.Color = CtaSituacion.Color
      
  IF @Referencia = 'Contrato'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Contrato, Mov+' '+MovID, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, vic_Contrato.Observaciones, Delegacion, Colonia, Población, Estado, Pais, CodigoPostal, Contrato.Situacion, Color.Numero, MapaLatitud, MapaLongitud, MapaPrecision
      FROM vic_Contrato 
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = vic_Contrato.ID
      JOIN Contrato ON vic_Contrato.ID = Contrato.ID
      LEFT OUTER JOIN CtaSituacion ON CtaSituacion.Rama = 'CXC' AND CtaSituacion.Situacion = Contrato.Situacion
      LEFT OUTER JOIN Color ON Color.Color = CtaSituacion.Color

  IF @Referencia = 'Inmueble'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Inmueble, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, vic_Inmueble.Situacion, Color.Numero, MapaLatitud, MapaLongitud, MapaPrecision
      FROM vic_Inmueble
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = vic_Inmueble.Inmueble
      LEFT OUTER JOIN CtaSituacion ON CtaSituacion.Rama = 'CXC' AND CtaSituacion.Situacion = vic_Inmueble.Situacion
      LEFT OUTER JOIN Color ON Color.Color = CtaSituacion.Color
      
  IF @Referencia = 'Fiador'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, Contrato, Mov, DireccionFiador, DireccionNumeroFiador, DireccionNumeroIntFiador, EntreCallesFiador, vic_Contrato.ObservacionesFiador, DelegacionFiador, ColoniaFiador, PoblaciónFiador, EstadoFiador, PaisFiador, CodigoPostalFiador, Contrato.Situacion, Color.Numero, MapaLatitudFiador, MapaLongitudFiador, MapaPrecisionFiador
      FROM vic_Contrato 
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = vic_Contrato.ID
      JOIN Contrato ON vic_Contrato.ID = Contrato.ID
      LEFT OUTER JOIN CtaSituacion ON CtaSituacion.Rama = 'CXC' AND CtaSituacion.Situacion = Contrato.Situacion
      LEFT OUTER JOIN Color ON Color.Color = CtaSituacion.Color*/   

  IF @Referencia = 'Proy'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,  SituacionColorNumero)
    SELECT @Estacion, Proyecto, Descripcion, Direccion, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Proy.Situacion, Color.Numero
      FROM Proy 
      JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = Proy.Proyecto
      LEFT OUTER JOIN CtaSituacion ON CtaSituacion.Rama = 'CXC' AND CtaSituacion.Situacion = Proy.Situacion
      LEFT OUTER JOIN Color ON Color.Color = CtaSituacion.Color  

  /*IF @Referencia = 'Notaria'
    INSERT MapaTemp (
           Estacion,  Clave,   Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Situacion,     SituacionColorNumero, MapaLatitud, MapaLongitud, MapaPrecision)
    SELECT @Estacion, NumNotaria, NombreCorto, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Observaciones, Delegacion, Colonia, Población, Estado, Pais, CodigoPostal, '', Color.Numero, MapaLatitud, MapaLongitud, MapaPrecision
	FROM vic_Notaria
    JOIN ListaSt l ON l.Estacion = @Estacion AND l.Clave = vic_Notaria.Notaria
    LEFT OUTER JOIN CtaSituacion ON CtaSituacion.Rama = 'CXC'
    LEFT OUTER JOIN Color ON Color.Color = CtaSituacion.Color*/  

  RETURN
END
GO

/**************** spMapaAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMapaAceptar') and type = 'P') drop procedure dbo.spMapaAceptar
GO
CREATE PROCEDURE spMapaAceptar
			@Estacion	int,
			@Referencia	varchar(50),
			@Accion		varchar(50),	-- POSICIONAR, PINTAR, ENRUTAR
			@ID		int	  
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Clave	varchar(20),
    @MapaOrden	int
    
  SELECT @Accion = UPPER(@Accion)
  IF @Accion NOT IN ('POSICIONAR', 'ENRUTAR') RETURN
  
  IF @Referencia = 'Cliente'
    UPDATE Cte
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM Cte c
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = c.Cliente
  IF @Referencia = 'Cliente|EnviarA'
    UPDATE CteEnviarA
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM CteEnviarA cea
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = cea.Cliente+'|'+CONVERT(varchar(10), cea.ID)
  IF @Referencia = 'Proveedor'
    UPDATE Prov
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM Prov p
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = p.Proveedor
  IF @Referencia = 'Personal'
    UPDATE Personal
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM Personal p
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = p.Personal
  IF @Referencia = 'Agente'
    UPDATE Agente
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM Agente a
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = a.Agente
  IF @Referencia = 'Almacen'
    UPDATE Alm
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM Alm a
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = a.Almacen
  IF @Referencia = 'Sucursal'
    UPDATE Sucursal
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM Sucursal s
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = CONVERT(varchar(10), s.Sucursal)
  IF @Referencia = 'Embarque'
  BEGIN
    IF @ID IS NOT NULL
    BEGIN
      DELETE EmbarqueD WHERE ID = @ID
      INSERT EmbarqueD (ID, Orden, EmbarqueMov)
      SELECT @ID, m.MapaOrden, m.EmbarqueMov
        FROM MapaTemp m 
       WHERE m.Estacion = @Estacion AND m.MapaRuta NOT IN ('INICIO', 'FINAL')

    END
  END

  /*IF @Referencia = 'Desarrollo'
    UPDATE vic_Desarrollo
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM vic_Desarrollo vd
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = vd.Desarrollo
      
      
  IF @Referencia = 'Area'
    UPDATE vic_Area
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM vic_Area va
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = va.Area
      
  IF @Referencia = 'Contrato'
    UPDATE vic_Contrato
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM vic_Contrato vc
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = vc.ID 
      
  IF @Referencia = 'Inmueble'
    UPDATE vic_Inmueble
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM vic_Inmueble vi
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = vi.Inmueble      
      
  IF @Referencia = 'Fiador'
    UPDATE vic_Contrato
       SET MapaLatitudFiador = m.MapaLatitud,
           MapaLongitudFiador = m.MapaLongitud,
           MapaPrecisionFiador = m.MapaPrecision
      FROM vic_Contrato vc
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = vc.ID  
   
  IF @Referencia = 'Notaria'
    UPDATE vic_Notaria
       SET MapaLatitud = m.MapaLatitud,
           MapaLongitud = m.MapaLongitud,
           MapaPrecision = m.MapaPrecision
      FROM vic_Notaria op
      JOIN MapaTemp m ON m.Estacion = @Estacion AND m.Clave = op.Notaria*/ 

  RETURN
END
GO

/**************** spMapaEnrutarEmbarque ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMapaEnrutarEmbarque') and type = 'P') drop procedure dbo.spMapaEnrutarEmbarque
GO
CREATE PROCEDURE spMapaEnrutarEmbarque
			@Estacion	int,
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ruta	varchar(50),
    @SucursalD	int,
    @SucursalA	int
    
  SELECT @Ruta = Ruta FROM Embarque WHERE ID = @ID
  SELECT @SucursalD = SucursalD,
         @SucursalA = SucursalA
    FROM Ruta 
   WHERE Ruta = @Ruta

  DELETE MapaTemp WHERE Estacion = @Estacion
  
  
  INSERT MapaTemp (
         Estacion,  Clave,                          Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, */Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision, MapaRuta)
  SELECT @Estacion, CONVERT(varchar(10), Sucursal), Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, */Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision, 'INICIO'
    FROM Sucursal
   WHERE Sucursal = @SucursalD

  INSERT MapaTemp (
         Estacion,  Clave,                          Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, */Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision, MapaRuta)
  SELECT @Estacion, CONVERT(varchar(10), Sucursal), Nombre, Direccion, DireccionNumero, DireccionNumeroInt, /*EntreCalles, Observaciones, */Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, MapaLatitud, MapaLongitud, MapaPrecision, 'FINAL'
    FROM Sucursal
   WHERE Sucursal = ISNULL(@SucursalA, @SucursalD)

  INSERT MapaTemp (
         Estacion,  Clave,                       Nombre,    Direccion,    DireccionNumero,    DireccionNumeroInt,    EntreCalles,    Observaciones,    Delegacion,    Colonia,    Poblacion,    Estado,    Pais,    CodigoPostal,    MapaOrden, MapaLatitud,    MapaLongitud,    MapaPrecision, EmbarqueMov)
  SELECT @Estacion, CONVERT(varchar(10), ed.ID), em.Nombre, em.Direccion, em.DireccionNumero, em.DireccionNumeroInt, em.EntreCalles, em.Observaciones, em.Delegacion, em.Colonia, em.Poblacion, em.Estado, em.Pais, em.CodigoPostal, ed.Orden,  em.MapaLatitud, em.MapaLongitud, em.MapaPrecision, ed.EmbarqueMov
    FROM EmbarqueD ed
    JOIN EmbarqueMov em ON em.ID = ed.EmbarqueMov
   WHERE ed.ID = @ID
  RETURN
END
GO

/*************************** VisorWeb **************************/
if not exists (select * from SysTabla where SysTabla = 'VisorWeb') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VisorWeb','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.VisorWeb') and type = 'U') 
CREATE TABLE dbo.VisorWeb (
	Estacion	integer			NOT NULL,
	Orden 		integer			NOT NULL,
	TabTitulo	varchar(100)		NULL,
	Zona		varchar(100)		NULL,
	ZonaTitulo	varchar(100)		NULL,
	URL			varchar(255)		NULL,
	Bloqueado	bit					NULL 		DEFAULT 0,

	CONSTRAINT priVisorWeb PRIMARY KEY CLUSTERED (Estacion, Orden)
)
GO

/*************** spVisorWebInicializar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spVisorWebInicializar') and type = 'P') drop procedure dbo.spVisorWebInicializar
GO             
CREATE PROCEDURE spVisorWebInicializar		    
			@Estacion		int,
			@Formato		varchar(50)


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DELETE FROM VisorWeb WHERE Estacion = @Estacion

  INSERT VisorWeb (Estacion,  Orden,                       TabTitulo, Zona, ZonaTitulo, URL, Bloqueado)
           SELECT  @Estacion, ISNULL(NULLIF(Orden,0),RID), TabTitulo, Zona, ZonaTitulo, URL, Bloqueado
             FROM  VisorWebConfigD
            WHERE  RTRIM(LTRIM(Formato)) = RTRIM(LTRIM(@Formato))   
			ORDER  BY RID
			
  SELECT Formato, Descripcion, Editable FROM VisorWebConfig WHERE RTRIM(LTRIM(Formato)) = RTRIM(LTRIM(@Formato)) 
  
END
GO
--DSG
EXEC spADD_INDEX 'ListaSt', 'Clave', 'Estacion, Clave'
GO
