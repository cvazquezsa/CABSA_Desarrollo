/*******************************************************************************************/
/*                                         AUTOTRANSPORTES                                 */
/*******************************************************************************************/

if (select version from version)<=1474
begin
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.AutoServicio') 		and type = 'U') drop table AutoServicio")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.AutoRol')    		and type = 'U') drop table AutoRol")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.AutoCorrida')  		and type = 'U') drop table AutoCorrida")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.AutoCorridaD') 		and type = 'U') drop table AutoCorridaD")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.AutoCorridaRuta') 	and type = 'U') drop table AutoCorridaRuta")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.AutoCorridaPlantilla') 	and type = 'U') drop table AutoCorridaPlantilla")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.AutoBoleto')   		and type = 'U') drop table AutoBoleto")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.AutoComision') 		and type = 'U') drop table AutoComision")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.AutoLocalidad') 		and type = 'U') drop table AutoLocalidad")
end
GO
if (select version from version)<=2006
begin
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.EspacioProrrateo') 	and type = 'U') drop table EspacioProrrateo")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.AutoTipo') 		and type = 'U') drop table AutoTipo")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Autobus') 		and type = 'U') drop table Autobus")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.AutoSocio') 		and type = 'U') drop table AutoSocio")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.EspacioResultado') 	and type = 'U') drop table EspacioResultado")
end
GO
if (select version from version)<=2132 and exists (select * from sysobjects where id = object_id('dbo.EspacioResultado') and type = 'U')
 drop table EspacioResultado
GO
if (select version from version)<=2172 and exists (select * from sysobjects where id = object_id('dbo.EspacioPorcentaje') and type = 'U') 
 drop table EspacioPorcentaje
GO
if (select version from version)<=2174 and exists (select * from sysobjects where id = object_id('dbo.AutoCfg') and type = 'U') 
 drop table AutoCfg
GO

/****** PropietarioSocio ******/
if not exists(select * from SysTabla where SysTabla = 'PropietarioSocio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PropietarioSocio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PropietarioSocio') and type = 'U') 
CREATE TABLE dbo.PropietarioSocio (
	Propietario		char(10)	NOT NULL,
	Socio			char(10)	NOT NULL,

	Porcentaje		float		NULL,

	CONSTRAINT priPropietarioSocio PRIMARY KEY  CLUSTERED (Propietario, Socio)
)
GO

/****** EspacioPropietario ******/
if not exists(select * from SysTabla where SysTabla = 'EspacioPropietario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EspacioPropietario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EspacioPropietario') and type = 'U') 
CREATE TABLE dbo.EspacioPropietario (
	Espacio			char(10)	NOT NULL,
	Propietario		char(10)	NOT NULL,

	Porcentaje		float		NULL,

	CONSTRAINT priEspacioPropietario PRIMARY KEY  CLUSTERED (Espacio, Propietario)
)
GO

/****** EspacioTipo ******/
if not exists(select * from SysTabla where SysTabla = 'EspacioTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EspacioTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EspacioTipo') and type = 'U') 
CREATE TABLE dbo.EspacioTipo (
	Tipo			varchar(50)	NOT NULL,

	CONSTRAINT priEspacioTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

/****** Espacio ******/
if not exists(select * from SysTabla where SysTabla = 'Espacio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Espacio','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Espacio') and type = 'U') 
CREATE TABLE dbo.Espacio (
	Espacio			varchar(10)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Servicio		varchar(50)	NULL,
	Rol			varchar(50)	NULL,
	Marca			varchar(50)	NULL,
	Tipo			varchar(50)	NULL,
	Modelo			varchar(10)	NULL,
	Placas			varchar(10)	NULL,
	Legal			varchar(10)	NULL,
	Motor			varchar(20)	NULL,
	Chasis			varchar(20)	NULL,
	TarjetaCirculacion	varchar(20)	NULL,
	TarjetaCasetas		varchar(30)	NULL,
        Estatus			varchar(15)	NULL,
	Alta			datetime	NULL,
	Baja			datetime	NULL,
	UltimoMantenimiento	datetime	NULL,
	UltimoMantenimientoKms	int		NULL,
	Observaciones		varchar(255)	NULL,
	TieneMovimientos	bit		NULL DEFAULT 0,
        NivelAcceso		varchar(50)	NULL,
	Empresa			varchar(5)		NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Descripcion1		varchar(50)	NULL,
	Descripcion2		varchar(50)	NULL,
	Descripcion3		varchar(50)	NULL,
	Descripcion4		varchar(50)	NULL,
	Descripcion5		varchar(50)	NULL,
	Descripcion6		varchar(50)	NULL,
	Descripcion7		varchar(50)	NULL,
	Descripcion8		varchar(50)	NULL,
	Descripcion9		varchar(50)	NULL,
	Descripcion10		varchar(50)	NULL,

	Mantenimiento		varchar(50)	NULL,
	KmsAnteriores		int		NULL,
	KmsActuales		int		NULL,
	Antiguedad		datetime	NULL,
	NumeroEconomico		varchar(20)	NULL,
	Almacen			varchar(10)	NULL,
	AlmacenAlterno		varchar(10)	NULL,
	SaldoAFavor		money		NULL,
	Metros			float		NULL,
	
	OcupacionMaxima		int		NULL,

	CONSTRAINT priEspacio PRIMARY KEY  CLUSTERED (Espacio)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgEspacioAB') and sysstat & 0xf = 8) drop trigger dbo.tgEspacioAB
GO
if exists (select * from sysobjects where id = object_id('dbo.tgEspacioBC') and sysstat & 0xf = 8) drop trigger dbo.tgEspacioBC
GO
EXEC spALTER_TABLE 'Espacio', 'Empresa', 'char(5) NULL'
EXEC spALTER_TABLE 'Espacio', 'UltimoMantenimientoKms', 'int NULL'
EXEC spALTER_TABLE 'Espacio', 'Situacion', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Espacio', 'SituacionFecha', 'datetime NULL'
EXEC spALTER_TABLE 'Espacio', 'Descripcion1', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Espacio', 'Descripcion2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Espacio', 'Descripcion3', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Espacio', 'Descripcion4', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Espacio', 'Descripcion5', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Espacio', 'Descripcion6', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Espacio', 'Descripcion7', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Espacio', 'Descripcion8', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Espacio', 'Descripcion9', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Espacio', 'Descripcion10', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Espacio', 'Mantenimiento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Espacio', 'KmsAnteriores', 'int NULL'
EXEC spALTER_TABLE 'Espacio', 'KmsActuales', 'int NULL'
EXEC spALTER_TABLE 'Espacio', 'Antiguedad', 'datetime NULL'
EXEC spALTER_TABLE 'Espacio', 'NumeroEconomico', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Espacio', 'Almacen', 'char(10) NULL'
EXEC spALTER_TABLE 'Espacio', 'AlmacenAlterno', 'char(10) NULL'
EXEC spALTER_TABLE 'Espacio', 'SaldoAFavor', 'money NULL'
EXEC spALTER_TABLE 'Espacio', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Espacio', 'SituacionNota', 'varchar(100) NULL'
GO
if (select version from version)<=2318
  ALTER TABLE Espacio ALTER COLUMN NumeroEconomico varchar(20) NULL
GO
EXEC spALTER_TABLE 'Espacio', 'Metros', 'float NULL'
GO
IF (SELECT Version FROM Version)<=3192
BEGIN
  EXEC("spEliminarPK 'Espacio'")	
  EXEC("spALTER_COLUMN 'Espacio','Espacio', 'varchar(10) NOT NULL'")
  EXEC("ALTER TABLE Espacio ADD CONSTRAINT priEspacio PRIMARY KEY CLUSTERED (Espacio)")	
END
GO
EXEC spALTER_COLUMN 'Espacio' ,'Modelo', 'varchar(10) NULL'
EXEC spALTER_COLUMN 'Espacio' ,'Placas', 'varchar(10) NULL'
EXEC spALTER_COLUMN 'Espacio' ,'Legal', 'varchar(10) NULL'
EXEC spALTER_COLUMN 'Espacio' ,'Motor', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'Espacio' ,'Chasis', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'Espacio' ,'TarjetaCirculacion', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'Espacio' ,'TarjetaCasetas', 'varchar(30) NULL'
EXEC spALTER_COLUMN 'Espacio' ,'Estatus', 'varchar(15) NULL'
EXEC spALTER_COLUMN 'Espacio' ,'Empresa', 'varchar(5) NULL'
EXEC spALTER_COLUMN 'Espacio' ,'Almacen', 'varchar(10) NULL'
EXEC spALTER_COLUMN 'Espacio' ,'AlmacenAlterno', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'Espacio' ,'OcupacionMaxima', 'int NULL'
GO

/****** EspacioCierre ******/
if not exists(select * from SysTabla where SysTabla = 'EspacioCierre')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EspacioCierre','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.EspacioCierre') and type = 'U') 
CREATE TABLE dbo.EspacioCierre (
	Espacio			char(10)	NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,

	SaldoAFavor		money		NULL,

	CONSTRAINT priEspacioCierre PRIMARY KEY  CLUSTERED (Espacio, Ejercicio, Periodo)
)
GO


/****** Fechas ******/
if not exists(select * from SysTabla where SysTabla = 'EspacioFecha')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EspacioFecha','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EspacioFecha') and type = 'U') 
CREATE TABLE dbo.EspacioFecha (
	Espacio			char(10) 	NOT NULL,
	FechaD			datetime 	NOT NULL,
	FechaA			datetime 	NULL,

	CONSTRAINT priEspacioFecha PRIMARY KEY CLUSTERED (Espacio, FechaD)
)
GO

/****** EspacioAsignacion ******/
if not exists(select * from SysTabla where SysTabla = 'EspacioAsignacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EspacioAsignacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EspacioAsignacion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EspacioAsignacion (
	ID			int		NOT NULL IDENTITY(1,1),

	Empresa			char(5)		NULL,
	Espacio			char(10) 	NULL,
	Fecha			datetime 	NULL,
	Hora			char(5)		NULL,
	Cliente			varchar(10)	NULL,
	Proyecto		varchar(50)	NULL,
	Estatus			char(15)	NULL	DEFAULT 'ALTA'

	CONSTRAINT priEspacioAsignacion PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'EspacioAsignacion'
END
GO

EXEC spFK 'EspacioAsignacion','Cliente','Cte','Cliente'
GO

/****** ArtEspacio ******/
if not exists(select * from SysTabla where SysTabla = 'ArtEspacio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtEspacio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtEspacio') and type = 'U') 
CREATE TABLE dbo.ArtEspacio (
	Articulo		char(20)	NOT NULL,
	Espacio			char(10)	NOT NULL,

	CONSTRAINT priArtEspacio PRIMARY KEY  CLUSTERED (Articulo, Espacio)
)
GO

/****** AutoCfg ******/
if not exists(select * from SysTabla where SysTabla = 'AutoCfg')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoCfg','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoCfg') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AutoCfg (
	ID				int		NOT NULL IDENTITY(1,1),

	SHCP				char(10)	NULL	DEFAULT 'SHCP',
        CalcISR				varchar(20)	NULL	DEFAULT '%',
	TablaISR			varchar(50)	NULL,
	PorcentajeISR			float		NULL	DEFAULT 35,
	PorcentajeCiegos		float		NULL	DEFAULT 10,
	BoletosSinRecaudar		varchar(50)	NULL	DEFAULT 'Boletos sin Recaudar',
	BoletosSinRecaudarMesAnterior	varchar(50)	NULL	DEFAULT 'Boletos sin Recaudar (Mes Anterior)',
	TotalIngresos			varchar(50)	NULL	DEFAULT 'Total Ingresos',
	TotalEgresos			varchar(50)	NULL	DEFAULT 'Total Egresos',
	TotalEstimulos			varchar(50)	NULL	DEFAULT 'Total Estimulos Fiscales',
	TotalImpuestosRetenidos		varchar(50)	NULL	DEFAULT 'Total Impuestos Retenidos',
	BaseGravableISR			varchar(50)	NULL	DEFAULT 'Base Gravable ISR',
	BaseGravableNeta		varchar(50)	NULL	DEFAULT 'Base Gravable Neta',
	FacilidadesAdministrativas	varchar(50)	NULL	DEFAULT '10% Facilidades Administrativas',
	RemanentePorPagarASocios	varchar(50)	NULL	DEFAULT 'Remanente por Pagar a Socios',
	AmortizacionPerdida		varchar(50)	NULL	DEFAULT 'Amortización Perdida Régimen de Salida',
	ISR				varchar(50)	NULL	DEFAULT 'ISR',
	UtilidadAntesImpuestos		varchar(50)	NULL	DEFAULT 'Utilidad Antes de Impuestos',
	ImpuestosRetenidosPorPagar	varchar(50)	NULL	DEFAULT 'Impuestos Retenidos por Pagar',
	ImpuestoPorPagar		varchar(50)	NULL	DEFAULT 'Impuesto por Pagar (por Acreditar)',

	CONSTRAINT priAutoCfg PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'AutoCfg'
END
GO
if not exists(select * from AutoCfg)
  INSERT AutoCfg (SHCP) VALUES ('SHCP')
go

/****** EspacioResultado ******/
if not exists(select * from SysTabla where SysTabla = 'EspacioResultado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EspacioResultado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EspacioResultado') and type = 'U') 
CREATE TABLE dbo.EspacioResultado (
	Empresa			char(5)		NOT NULL,
	Parte			char(10)	NOT NULL,
	Espacio			char(10)	NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,

	Cantidad		float		NULL,
	Ingreso			money		NULL,
	Egreso			money		NULL,
	EgresoND		money		NULL,
	Importe			money		NULL,
	Orden			int		NULL,

	CONSTRAINT priEspacioResultado PRIMARY KEY  CLUSTERED (Empresa, Parte, Espacio, Concepto, Ejercicio, Periodo)
)
GO
EXEC spALTER_TABLE 'EspacioResultado', 'Importe', 'money NULL'
EXEC spALTER_TABLE 'EspacioResultado', 'Orden', 'int NULL'
GO

/****** EspacioProrrateo ******/
if not exists(select * from SysTabla where SysTabla = 'EspacioProrrateo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EspacioProrrateo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EspacioProrrateo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EspacioProrrateo (
	  Concepto		varchar(50) 	NOT NULL,
	  ID			int		NOT NULL IDENTITY(1,1),

  	  Rol			varchar(50)	NULL,
	  Espacio		char(10)	NULL,
	  Porcentaje		float		NULL,
		
	CONSTRAINT priEspacioProrrateo PRIMARY KEY  CLUSTERED (Concepto, ID)
  )
  EXEC spSincroSemilla 'EspacioProrrateo'
END
GO

/****** EspacioIngreso ******/
if not exists(select * from SysTabla where SysTabla = 'EspacioIngreso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EspacioIngreso','Maestro')
GO
if not exists (select * from sysobjects where id = object_id('dbo.EspacioIngreso') and type = 'U') 
  CREATE TABLE dbo.EspacioIngreso (
	  Espacio		char(10)	NOT NULL,
	  Ejercicio		int		NOT NULL,
	  Periodo		int		NOT NULL,

	  Importe		money		NULL,
	  Porcentaje		float		NULL,
		
	CONSTRAINT priEspacioIngreso PRIMARY KEY  CLUSTERED (Espacio, Ejercicio, Periodo)
)
GO

/****** EspacioConsumo ******/
if not exists(select * from SysTabla where SysTabla = 'EspacioConsumo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EspacioConsumo','Maestro')
GO
if not exists (select * from sysobjects where id = object_id('dbo.EspacioConsumo') and type = 'U') 
  CREATE TABLE dbo.EspacioConsumo (
	  Espacio		char(10)	NOT NULL,
	  Ejercicio		int		NOT NULL,
	  Periodo		int		NOT NULL,

	  Importe		money		NULL,
	  Porcentaje		float		NULL,
		
	CONSTRAINT priEspacioConsumo PRIMARY KEY  CLUSTERED (Espacio, Ejercicio, Periodo)
)
GO

/****** EspacioMant ******/
if not exists(select * from SysTabla where SysTabla = 'EspacioMant')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EspacioMant','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EspacioMant') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EspacioMant (
	Espacio			char(10)	NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Mantenimiento		varchar(50)	NULL,
	Servicio		varchar(50)	NULL,

	Kms			int		NULL,
	Fecha			datetime	NULL,

	CONSTRAINT priEspacioMant PRIMARY KEY  CLUSTERED (Espacio, ID)
  )
  EXEC spSincroSemilla 'EspacioMant'
END
GO

CREATE TRIGGER tgEspacioAB ON Espacio
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @Espacio		char(10),
    @Empresa		char(5),
    @NumeroEconomico 	varchar(20),
    @Mensaje		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Espacio = NULLIF(RTRIM(Espacio), ''), @Empresa = NULLIF(RTRIM(Empresa), ''), @NumeroEconomico = NULLIF(RTRIM(NumeroEconomico), '') FROM Inserted
  IF @Espacio IS NOT NULL AND @Empresa IS NOT NULL AND @NumeroEconomico IS NOT NULL
  BEGIN
    IF EXISTS (SELECT * FROM Espacio WHERE Empresa = @Empresa AND Espacio <> @Espacio AND NumeroEconomico = @NumeroEconomico)
    BEGIN
      SELECT @Mensaje = '"'+LTRIM(RTRIM(@NumeroEconomico))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 27010
      RAISERROR (@Mensaje,16,-1) 
    END
  END
END
GO


CREATE TRIGGER tgEspacioBC ON Espacio
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @EspacioN 	char(10),
    @EspacioA	char(10)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @EspacioN = Espacio FROM Inserted
  SELECT @EspacioA = Espacio FROM Deleted

  IF @EspacioN = @EspacioA RETURN

  IF @EspacioN IS NULL
  BEGIN
    DELETE EspacioFecha     WHERE Espacio = @EspacioA
    DELETE ArtEspacio       WHERE Espacio = @EspacioA
    DELETE EspacioResultado WHERE Espacio = @EspacioA
    DELETE EspacioMant      WHERE Espacio = @EspacioA
  END ELSE
  BEGIN
    UPDATE EspacioFecha     SET Espacio = @EspacioN WHERE Espacio = @EspacioA
    UPDATE ArtEspacio       SET Espacio = @EspacioN WHERE Espacio = @EspacioA
    UPDATE EspacioResultado SET Espacio = @EspacioN WHERE Espacio = @EspacioA
    UPDATE EspacioMant      SET Espacio = @EspacioN WHERE Espacio = @EspacioA
  END
END
GO


/****** AutoServicio ******/
if not exists(select * from SysTabla where SysTabla = 'AutoServicio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoServicio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoServicio') and type = 'U') 
CREATE TABLE dbo.AutoServicio (
	Clave			char(5)		NOT NULL,
	Servicio		varchar(50)	NOT NULL,

	CONSTRAINT priAutoServicio PRIMARY KEY  CLUSTERED (Clave)
)
GO


/****** AutoRol ******/
if not exists(select * from SysTabla where SysTabla = 'AutoRol')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoRol','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoRol') and type = 'U') 
CREATE TABLE dbo.AutoRol (
	Clave			char(5)		NOT NULL,
	Rol			varchar(50)	NOT NULL,
		
	CONSTRAINT priAutoRol PRIMARY KEY  CLUSTERED (Clave)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgAutoRolBC') and sysstat & 0xf = 8) drop trigger dbo.tgAutoRolBC
GO

/****** AutoRolCargo ******/
if not exists(select * from SysTabla where SysTabla = 'AutoRolCargo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoRolCargo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoRolCargo') and type = 'U') 
CREATE TABLE dbo.AutoRolCargo (
	Rol			varchar(50)	NOT NULL,
	Articulo		char(20)	NOT NULL,
	
	Tipo			varchar(20)	NULL,
	Importe			money		NULL,	

	CONSTRAINT priAutoRolCargo PRIMARY KEY  CLUSTERED (Rol, Articulo)
)
GO

CREATE TRIGGER tgAutoRolBC ON AutoRol
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @RolN 	varchar(50),
    @RolA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @RolN = Rol FROM Inserted
  SELECT @RolA = Rol FROM Deleted

  IF @RolN = @RolA RETURN

  IF @RolN IS NULL
  BEGIN
    DELETE AutoRolCargo    WHERE Rol = @RolA
    DELETE AutoRolComision WHERE Rol = @RolA
  END ELSE
  BEGIN
    UPDATE AutoRolCargo    SET Rol = @RolN WHERE Rol = @RolA
    UPDATE AutoRolComision SET Rol = @RolN WHERE Rol = @RolA
  END
END
GO


/****** AutoLocalidad ******/
if not exists(select * from SysTabla where SysTabla = 'AutoLocalidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoLocalidad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoLocalidad') and type = 'U') 
CREATE TABLE dbo.AutoLocalidad (
	Localidad		char(5) 	NOT NULL,

	Nombre			varchar(100)	NULL,
		
	CONSTRAINT priAutoLocalidad PRIMARY KEY  CLUSTERED (Localidad)
)
GO

/****** AutoRuta ******/
if not exists(select * from SysTabla where SysTabla = 'AutoRuta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoRuta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoRuta') and type = 'U') 
CREATE TABLE dbo.AutoRuta (
	Ruta			char(5) 	NOT NULL,

	Nombre			varchar(100)	NULL,
		
	CONSTRAINT priAutoRuta PRIMARY KEY  CLUSTERED (Ruta)
)
GO

/****** AutoRutaD ******/
if not exists(select * from SysTabla where SysTabla = 'AutoRutaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoRutaD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoRutaD') and type = 'U') 
CREATE TABLE dbo.AutoRutaD (
	Ruta			char(5) 	NOT NULL,
	Orden			int		NOT NULL,
	Localidad		char(5)		NOT NULL,
		
	CONSTRAINT priAutoRutaD PRIMARY KEY  CLUSTERED (Ruta, Orden, Localidad)
)
GO

EXEC spFK 'AutoRutaD','Localidad','AutoLocalidad','Localidad'
GO

/****** AutoComision ******/
if not exists(select * from SysTabla where SysTabla = 'AutoComision')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoComision','Maestro')
if (select version from version)<=2041 and exists (select * from sysobjects where id = object_id('dbo.AutoComision') and type = 'U') 
drop table AutoComision
GO
if not exists (select * from sysobjects where id = object_id('dbo.AutoComision') and type = 'U') 
CREATE TABLE dbo.AutoComision (
	Comision		varchar(50)	NOT NULL,

	Tipo			varchar(20)	NULL,
	Cantidad		float		NULL,
		
	CONSTRAINT priAutoComision PRIMARY KEY  CLUSTERED (Comision)
)
GO

/****** AutoCorrida ******/
if not exists(select * from SysTabla where SysTabla = 'AutoCorrida')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoCorrida','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoCorrida') and type = 'U') 
CREATE TABLE dbo.AutoCorrida (
	Corrida			varchar(20) 	NOT NULL,

	Nombre			varchar(100)	NULL,

	Hora			char(5)		NULL,
	Servicio		varchar(50)	NULL,		
	Rol			varchar(50)	NULL,		
	Origen			varchar(5)	NULL,
	Destino			varchar(5)	NULL,
	Kms			int		NULL,
	Lts			int		NULL,
	Ruta			char(5)		NULL,

	Comision		varchar(50)	NULL,
	MantExterno		float		NULL,
	Operador2		bit		NULL	DEFAULT 0,
	Operador2Pct		float		NULL,
		
	CONSTRAINT priAutoCorrida PRIMARY KEY  CLUSTERED (Corrida)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgAutoCorridaBC') and sysstat & 0xf = 8) drop trigger dbo.tgAutoCorridaBC
GO
EXEC spALTER_TABLE 'AutoCorrida', 'Comision', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AutoCorrida', 'MantExterno', 'float NULL'
GO
if (select version from version)<=2111
BEGIN
  EXEC("ALTER TABLE AutoCorrida ALTER COLUMN Corrida varchar(20) NOT NULL")
  EXEC("ALTER TABLE AutoCorrida ALTER COLUMN Kms int NULL")
  EXEC("ALTER TABLE AutoCorrida ALTER COLUMN Lts int NULL")
END
GO
EXEC spALTER_TABLE 'AutoCorrida', 'Operador2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'AutoCorrida', 'Operador2Pct', 'float NULL'
GO

EXEC spFK 'AutoCorrida','Ruta','AutoRuta','Ruta'
GO

/****** AutoCorridaPlantilla ******/
if not exists(select * from SysTabla where SysTabla = 'AutoCorridaPlantilla')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoCorridaPlantilla','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoCorridaPlantilla') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AutoCorridaPlantilla (
	Corrida			varchar(20) 	NOT NULL,
	ID			int		NOT NULL 	IDENTITY(1,1),

	Articulo		char(20)	NOT NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Localidad		varchar(5)	NULL,
	Orden			int		NULL,
	Almacen			varchar(20)	NULL		DEFAULT 'Operador',
	ImporteMaximo		money		NULL,

	CONSTRAINT priAutoCorridaPlantilla PRIMARY KEY  CLUSTERED (Corrida, ID)
  )
  EXEC spSincroSemilla 'AutoCorridaPlantilla'
END
GO
EXEC spALTER_TABLE 'AutoCorridaPlantilla', 'SubCuenta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'AutoCorridaPlantilla', 'Almacen', 'varchar(20) NULL DEFAULT "Operador" WITH VALUES'
EXEC spALTER_TABLE 'AutoCorridaPlantilla', 'ImporteMaximo', 'money NULL'
GO
if (select version from version)<=2111
  EXEC("ALTER TABLE AutoCorridaPlantilla ALTER COLUMN Corrida varchar(20) NOT NULL")
GO
EXEC spALTER_COLUMN 'AutoCorridaPlantilla', 'SubCuenta', 'varchar(50) NULL'
GO

/****** AutoCorridaComision ******/
if not exists(select * from SysTabla where SysTabla = 'AutoCorridaComision')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoCorridaComision','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoCorridaComision') and type = 'U') 
  CREATE TABLE dbo.AutoCorridaComision (
	Corrida			varchar(20) 	NOT NULL,
	Comision		varchar(50)	NOT NULL,

	CONSTRAINT priAutoCorridaComision PRIMARY KEY  CLUSTERED (Corrida, Comision)
  )
GO

/****** AutoCorridaRol ******/
if not exists(select * from SysTabla where SysTabla = 'AutoCorridaRol')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoCorridaRol','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoCorridaRol') and type = 'U') 
  CREATE TABLE dbo.AutoCorridaRol (
	Corrida			varchar(20) 	NOT NULL,
	Rol			varchar(50)	NOT NULL,

	CONSTRAINT priAutoCorridaRol PRIMARY KEY  CLUSTERED (Corrida, Rol)
  )
GO

/****** AutoCorridaRolComision ******/
if not exists(select * from SysTabla where SysTabla = 'AutoCorridaRolComision')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoCorridaRolComision','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoCorridaRolComision') and type = 'U') 
  CREATE TABLE dbo.AutoCorridaRolComision (
	Corrida			varchar(20) 	NOT NULL,
	Rol			varchar(50) 	NOT NULL,
	Comision		varchar(50)	NOT NULL,

	CONSTRAINT priAutoCorridaRolComision PRIMARY KEY  CLUSTERED (Corrida, Rol, Comision)
  )
GO


CREATE TRIGGER tgAutoCorridaBC ON AutoCorrida
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CorridaN 	varchar(20),
    @CorridaA	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CorridaN = Corrida FROM Inserted
  SELECT @CorridaA = Corrida FROM Deleted

  IF @CorridaN = @CorridaA RETURN

  IF @CorridaN IS NULL
  BEGIN
    DELETE AutoCorridaPlantilla   WHERE Corrida = @CorridaA
    DELETE AutoCorridaComision    WHERE Corrida = @CorridaA
    DELETE AutoCorridaRol         WHERE Corrida = @CorridaA
    DELETE AutoCorridaRolComision WHERE Corrida = @CorridaA

  END ELSE
  BEGIN
    UPDATE AutoCorridaPlantilla   SET Corrida = @CorridaN WHERE Corrida = @CorridaA
    UPDATE AutoCorridaComision    SET Corrida = @CorridaN WHERE Corrida = @CorridaA
    UPDATE AutoCorridaRol         SET Corrida = @CorridaN WHERE Corrida = @CorridaA
    UPDATE AutoCorridaRolComision SET Corrida = @CorridaN WHERE Corrida = @CorridaA
  END
END
GO


/****** AutoBoleto ******/
if (select version from version)<=2052 
  if exists (select * from sysobjects where id = object_id('dbo.AutoBoleto') and type = 'U') drop table AutoBoleto
GO
if not exists(select * from SysTabla where SysTabla = 'AutoBoleto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoBoleto','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.AutoBoleto') and type = 'U') 
CREATE TABLE dbo.AutoBoleto (
	Taquilla		int		NOT NULL,
	Folio			int		NOT NULL,
	OficinaVenta		char(5)		NOT NULL,
	Estatus			char(1) 	NOT NULL,

	Origen			char(5)		NULL,
	Destino			char(5)		NULL,
	FechaViaje		datetime	NULL,	
	HoraSalida		char(5)		NULL,
	TipoPasajero		char(1)		NULL,
	TipoDescuento		char(3)		NULL,
	Corrida			char(20)	NULL,
	Usuario			char(6)		NULL,
	TipoServicio		char(1)		NULL,
	FechaVenta		datetime	NULL,
	HoraVenta		char(5)		NULL,
	Sesion			int		NULL,
	Precio			money		NULL,

	Asiento			int		NULL,
	Descuento		money		NULL,
	FormaPago		int		NULL,
	Cxc			char(2)		NULL,
	Cliente			char(10)	NULL,
	Recaudado		bit		NULL	DEFAULT 0,

	VentaID			int		NULL,
	VentaRenglon		float		NULL,
	VentaRenglonSub		int		NULL,
	Empresa			char(5)		NULL,

	FacturaID		int		NULL,
	Proyecto		varchar(50)	NULL,
        Serie                   varchar(20)	NULL,
	
	CONSTRAINT priAutoBoleto PRIMARY KEY CLUSTERED (Taquilla, Folio, OficinaVenta, Estatus)
)
GO
if (select version from version)<=2111
  EXEC("ALTER TABLE AutoBoleto ALTER COLUMN Corrida varchar(20) NULL")
GO
if not exists(select * from syscampo where tabla = 'AutoBoleto' and Campo = 'Empresa')
begin
  EXEC("spALTER_TABLE 'AutoBoleto', 'Empresa', 'char(5) NULL'")
  EXEC("DECLARE
    @Empresa char(5)
  SELECT @Empresa = MIN(Empresa) FROM Empresa WHERE Empresa <> 'DEMO'
  UPDATE AutoBoleto SET Empresa = @Empresa")
end
GO
EXEC spALTER_TABLE 'AutoBoleto', 'FacturaID', 'int NULL'
EXEC spALTER_TABLE 'AutoBoleto', 'Proyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AutoBoleto', 'Serie', 'varchar(20) NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AutoBoleto' AND sysindexes.name = 'VentaID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX VentaID ON dbo.AutoBoleto (VentaID)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AutoBoleto' AND sysindexes.name = 'FacturaID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FacturaID ON dbo.AutoBoleto (FacturaID)
GO


/****** AutoBoletoMov ******/
if not exists(select * from SysTabla where SysTabla = 'AutoBoletoMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoBoletoMov','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AutoBoletoMov') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AutoBoletoMov (
	Empresa			char(5)		NOT NULL,
	Modulo			char(5) 	NOT NULL,
	ID		        int		NOT NULL,
        RID                     int             NOT NULL        IDENTITY(1,1),

	RenglonID		int		NULL,
	Articulo		char(20) 	NULL,
	SubCuenta		varchar(50)	NULL,

        Cantidad                float           NULL,
        BoletoD                 varchar(20)     NULL,
        BoletoA                 varchar(20)     NULL,
        Precio                  money           NULL,
        Origen                  varchar(10)     NULL,
        Destino                 varchar(10)     NULL,
	TipoPasajero		char(1)		NULL,

	CONSTRAINT priAutoBoletoMov PRIMARY KEY CLUSTERED (Empresa, Modulo, ID, RID)
  )
  EXEC spSincroSemilla 'AutoBoletoMov'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'AutoBoletoMov', '(Empresa, Modulo, ID, RID)'
GO
EXEC spALTER_COLUMN 'AutoBoletoMov', 'SubCuenta', 'varchar(50) NULL'
GO

/****** AutoDescuento ******/
if not exists(select * from SysTabla where SysTabla = 'AutoDescuento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoDescuento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoDescuento') and type = 'U') 
CREATE TABLE dbo.AutoDescuento (
	Mov			char(20)	NOT NULL,

	Articulo		char(20)	NULL,
	MovAjuste		char(20)	NULL,
	Orden			int		NULL,
		
	CONSTRAINT priAutoDescuento PRIMARY KEY  CLUSTERED (Mov)
)
GO


/****** AutoMant ******/
if not exists(select * from SysTabla where SysTabla = 'AutoMant')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoMant','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoMant') and type = 'U') 
CREATE TABLE dbo.AutoMant (
	Mantenimiento	varchar(50)	NOT NULL,


	CONSTRAINT priAutoMant PRIMARY KEY  CLUSTERED (Mantenimiento)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgAutoMantBC') and sysstat & 0xf = 8) drop trigger dbo.tgAutoMantBC
GO

/****** AutoMantServ ******/
if not exists(select * from SysTabla where SysTabla = 'AutoMantServ')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoMantServ','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoMantServ') and type = 'U') 
CREATE TABLE dbo.AutoMantServ (
	Mantenimiento	varchar(50)	NOT NULL,
	Servicio	varchar(50)	NOT NULL,

	Kms		int		NULL,
	Tiempo		int		NULL,
	Unidad		varchar(50)	NULL,
	Dias		int		NULL,
	Tipo		varchar(20)	NULL,

	CONSTRAINT priAutoMantServ PRIMARY KEY  CLUSTERED (Mantenimiento, Servicio)
)
GO

/****** AutoMantServD ******/
if not exists(select * from SysTabla where SysTabla = 'AutoMantServD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoMantServD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoMantServD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AutoMantServD (
	Mantenimiento	varchar(50)	NOT NULL,
	Servicio	varchar(50)	NOT NULL,
	ID		int		NOT NULL IDENTITY(1,1),

	Articulo	char(20)	NULL,
	SubCuenta	varchar(50)	NULL,
	Cantidad	float		NULL,

	CONSTRAINT priAutoMantServD PRIMARY KEY  CLUSTERED (Mantenimiento, Servicio, ID)
  )
  EXEC spSincroSemilla 'AutoMantServD'
END
GO
EXEC spALTER_COLUMN 'AutoMantServD', 'SubCuenta', 'varchar(50) NULL'
GO

CREATE TRIGGER tgAutoMantBC ON AutoMant
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @MantenimientoN 	varchar(50),
    @MantenimientoA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @MantenimientoN = Mantenimiento FROM Inserted
  SELECT @MantenimientoA = Mantenimiento FROM Deleted

  IF @MantenimientoN = @MantenimientoA RETURN

  IF @MantenimientoN IS NULL
  BEGIN
    DELETE AutoMantServ  WHERE Mantenimiento = @MantenimientoA
    DELETE AutoMantServD WHERE Mantenimiento = @MantenimientoA
  END ELSE
  BEGIN
    UPDATE AutoMantServ  SET Mantenimiento = @MantenimientoN WHERE Mantenimiento = @MantenimientoA
    UPDATE AutoMantServD SET Mantenimiento = @MantenimientoN WHERE Mantenimiento = @MantenimientoA
  END
END
GO

/****** AutoBomba ******/
if not exists(select * from SysTabla where SysTabla = 'AutoBomba')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AutoBomba','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AutoBomba') and type = 'U') 
CREATE TABLE dbo.AutoBomba (
	Bomba			varchar(10) 	NOT NULL,
		
	CONSTRAINT priAutoBomba PRIMARY KEY  CLUSTERED (Bomba)
)
GO


/**********************************************************************/
/**********************  REGISTROS POR OMISION  ***********************/
/**********************************************************************/

if not exists(select * from AutoRol)
begin
  INSERT AutoRol (Clave, Rol) VALUES ('B', 'Premier')
  INSERT AutoRol (Clave, Rol) VALUES ('C', 'Somex Local')
  INSERT AutoRol (Clave, Rol) VALUES ('F', 'Dina Turbo')
  INSERT AutoRol (Clave, Rol) VALUES ('H', 'Pegasso RSD')
  INSERT AutoRol (Clave, Rol) VALUES ('I', 'Autovias')
  INSERT AutoRol (Clave, Rol) VALUES ('J', 'M.A.T.')
  INSERT AutoRol (Clave, Rol) VALUES ('L', 'Microbus Local')
  INSERT AutoRol (Clave, Rol) VALUES ('M', 'Mercedes Benz Local')
  INSERT AutoRol (Clave, Rol) VALUES ('O', 'Avante')
  INSERT AutoRol (Clave, Rol) VALUES ('P', 'Pegasso')
  INSERT AutoRol (Clave, Rol) VALUES ('R', 'Viajero Plus')
  INSERT AutoRol (Clave, Rol) VALUES ('S', 'Satelite')
  INSERT AutoRol (Clave, Rol) VALUES ('T', 'Pegasso RS')
  INSERT AutoRol (Clave, Rol) VALUES ('V', 'Viajero')
end
GO

if not exists(select * from AutoServicio)
begin
  INSERT AutoServicio (Clave, Servicio) VALUES ('01', 'Mercedes Benz')
  INSERT AutoServicio (Clave, Servicio) VALUES ('02', 'Andare')
  INSERT AutoServicio (Clave, Servicio) VALUES ('03', 'Avante A')
  INSERT AutoServicio (Clave, Servicio) VALUES ('04', 'Avante B')
  INSERT AutoServicio (Clave, Servicio) VALUES ('05', 'Premier A')
  INSERT AutoServicio (Clave, Servicio) VALUES ('06', 'Premier B')
  INSERT AutoServicio (Clave, Servicio) VALUES ('07', 'Premier C')
  INSERT AutoServicio (Clave, Servicio) VALUES ('08', 'Viajero')
  INSERT AutoServicio (Clave, Servicio) VALUES ('09', 'Premier Atlac')
  INSERT AutoServicio (Clave, Servicio) VALUES ('10', 'Fuera de Servicio')
  INSERT AutoServicio (Clave, Servicio) VALUES ('11', 'Microbus Local')
  INSERT AutoServicio (Clave, Servicio) VALUES ('12', 'Mercedes B.L.')
  INSERT AutoServicio (Clave, Servicio) VALUES ('13', 'Somex Local')
  INSERT AutoServicio (Clave, Servicio) VALUES ('14', 'Avante C')
  INSERT AutoServicio (Clave, Servicio) VALUES ('15', 'Dina Turbo Especial')
  INSERT AutoServicio (Clave, Servicio) VALUES ('16', 'Avante D')
  INSERT AutoServicio (Clave, Servicio) VALUES ('17', 'Microbus Jilotepec')
  INSERT AutoServicio (Clave, Servicio) VALUES ('18', 'Microbus Tlalpujahua')
  INSERT AutoServicio (Clave, Servicio) VALUES ('19', 'M.A.T.')
  INSERT AutoServicio (Clave, Servicio) VALUES ('20', 'Viajero Plus')
  INSERT AutoServicio (Clave, Servicio) VALUES ('21', 'Avante Plus 1')
  INSERT AutoServicio (Clave, Servicio) VALUES ('22', 'RSD')
  INSERT AutoServicio (Clave, Servicio) VALUES ('23', 'Autovias')
  INSERT AutoServicio (Clave, Servicio) VALUES ('24', 'Mercedes RS')
  INSERT AutoServicio (Clave, Servicio) VALUES ('25', 'Extras')
end
GO

if not exists(select * from AutoLocalidad)
begin
  INSERT AutoLocalidad (Localidad, Nombre) VALUES ('MEXO', 'Mexico')
  INSERT AutoLocalidad (Localidad, Nombre) VALUES ('QRO',  'Queretaro')
  INSERT AutoLocalidad (Localidad, Nombre) VALUES ('MORE', 'Morelia')
  INSERT AutoLocalidad (Localidad, Nombre) VALUES ('ACAMB', NULL)
  INSERT AutoLocalidad (Localidad, Nombre) VALUES ('PATZ',  NULL)
end
go